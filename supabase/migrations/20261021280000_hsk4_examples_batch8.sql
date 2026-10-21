-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 8 (100 TỪ)
-- Phạm vi: #1701 [说明书] (shuōmíngshū) -> #1800 [线下] (xiànxià)
-- Tổng số câu ví dụ: 200 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Không tạo từ mới hay bản ghi trùng trong vocabularies
--   - Cập nhật chuẩn hóa cột word_type (Từ loại) và meaning_vi (Nghĩa TV)
--   - Nạp chính xác 2 câu ví dụ vào bảng vocabulary_examples kèm Pinyin và dịch TV
--   - Đồng bộ các cột tương thích ngược example_hanzi, example_pinyin, example_vi
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
  -- [说明书] (shuōmíngshū) - sách hướng dẫn sử dụng, bản hướng dẫn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '说明书' AND pinyin = 'shuōmíngshū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '说明书'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shuōmíngshū',
      meaning_vi = 'sách hướng dẫn sử dụng, bản hướng dẫn',
      example_hanzi = '组装这套新家具之前，一定要先认真阅读随箱附带的说明书。',
      example_pinyin = 'Zǔzhuāng zhè tào xīn jiājù zhīqián, yídìng yào xiān rènzhēn yuèdú suí xiāng fùdài de shuōmíngshū.',
      example_vi = 'Trước khi lắp ráp bộ đồ nội thất mới này, nhất định phải đọc kỹ cuốn sách hướng dẫn kèm theo trong thùng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '组装这套新家具之前，一定要先认真阅读随箱附带的说明书。', 'Zǔzhuāng zhè tào xīn jiājù zhīqián, yídìng yào xiān rènzhēn yuèdú suí xiāng fùdài de shuōmíngshū.', 'Trước khi lắp ráp bộ đồ nội thất mới này, nhất định phải đọc kỹ cuốn sách hướng dẫn kèm theo trong thùng.', 'basic', 1),
        (v_id, '药品说明书必须详尽规范地标注适应症、不良反应以及禁忌事项，以确保患者用药安全有效。', 'Yàopǐn shuōmíngshū bìxū xiángjìn guīfàn de biāozhù shìyìngzhèng, bùliáng fǎnyìng yǐjí jìnjì shìxiàng, yǐ quèbǎo huànzhě yòngyào ānquán yǒuxiào.', 'Bản hướng dẫn sử dụng thuốc bắt buộc phải ghi rõ ràng quy chuẩn các chỉ định, phản ứng có hại cũng như các điều kiêng kỵ nhằm bảo đảm an toàn và hiệu quả dùng thuốc của người bệnh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [硕士] (shuòshì) - thạc sĩ, học vị thạc sĩ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '硕士' AND pinyin = 'shuòshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '硕士'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shuòshì',
      meaning_vi = 'thạc sĩ, học vị thạc sĩ',
      example_hanzi = '姐姐经过两年的刻苦攻读，终于顺利获得了计算机科学硕士学位。',
      example_pinyin = 'Jiějie jīngguò liǎng nián de kèkǔ gōngdú, zhōngyú shùnlì huòdé le jìsuànjī kēxué shuòshì xuéwèi.',
      example_vi = 'Chị gái sau hai năm khổ công miệt mài học tập, cuối cùng đã thuận lợi nhận được học vị thạc sĩ khoa học máy tính.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '姐姐经过两年的刻苦攻读，终于顺利获得了计算机科学硕士学位。', 'Jiějie jīngguò liǎng nián de kèkǔ gōngdú, zhōngyú shùnlì huòdé le jìsuànjī kēxué shuòshì xuéwèi.', 'Chị gái sau hai năm khổ công miệt mài học tập, cuối cùng đã thuận lợi nhận được học vị thạc sĩ khoa học máy tính.', 'basic', 1),
        (v_id, '国家大力推进专业学位硕士研究生培养模式改革，重点提升研究生的行业前沿实践与应用创新能力。', 'Guójiā dàlì tuījìn zhuānyè xuéwèi shuòshì yánjiūshēng péiyǎng móshì gǎigé, zhòngdiǎn tíshēng yánjiūshēng de hángyè qiányán shíjiàn yǔ yìngyòng chuàngxīn nénglì.', 'Nhà nước dốc sức đẩy mạnh cải cách mô hình đào tạo học viên cao học thạc sĩ theo định hướng ứng dụng chuyên nghiệp, trọng tâm nâng cao năng lực thực tiễn mũi nhọn ngành nghề và đổi mới ứng dụng của học viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [死] (sǐ) - chết, qua đời; cứng nhắc, cực kỳ [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '死' AND pinyin = 'sǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '死'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'sǐ',
      meaning_vi = 'chết, qua đời; cứng nhắc, cực kỳ',
      example_hanzi = '阳台上那盆绿植因为冬天缺水已经干枯死掉了。',
      example_pinyin = 'Yángtái shang nà pén lǜzhí yīnwèi dōngtiān quēshuǐ yǐjīng gānkū sǐ diào le.',
      example_vi = 'Chậu cây xanh ngoài ban công vì mùa đông thiếu nước nên đã bị khô héo chết mất rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '阳台上那盆绿植因为冬天缺水已经干枯死掉了。', 'Yángtái shang nà pén lǜzhí yīnwèi dōngtiān quēshuǐ yǐjīng gānkū sǐ diào le.', 'Chậu cây xanh ngoài ban công vì mùa đông thiếu nước nên đã bị khô héo chết mất rồi.', 'basic', 1),
        (v_id, '做学问与处理复杂问题切忌照本宣科、生搬硬套死规律，唯有融会贯通才能真正做到举一反三。', 'Zuò xuéwèn yǔ chǔlǐ fùzá wèntí qièjì zhàoběn-xuānkē, shēngbān-yìngtào sǐ guīlǜ, wéiyǒu rónghuì-guàntōng cái néng zhēnzhèng zuòdào jǔyī-fǎnsān.', 'Làm học vấn và xử lý vấn đề phức tạp tuyệt đối tránh rập khuôn theo sách vở, áp dụng máy móc các quy luật chết cứng nhắc, chỉ có hiểu sâu thấu suốt mới có thể thực sự suy một biết mười.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [速度] (sùdù) - tốc độ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '速度' AND pinyin = 'sùdù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '速度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'sùdù',
      meaning_vi = 'tốc độ',
      example_hanzi = '中国高速列车的运行速度非常平稳快捷，让跨城出行变得十分便利。',
      example_pinyin = 'Zhōngguó gāosù lièchē de yùnxíng sùdù fēicháng píngwěn kuàijié, ràng kuà chéng chūxíng biànde shífēn biànlì.',
      example_vi = 'Tốc độ vận hành của đoàn tàu cao tốc Trung Quốc vô cùng êm ái nhanh chóng, khiến việc đi lại giữa các thành phố trở nên hết sức thuận tiện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国高速列车的运行速度非常平稳快捷，让跨城出行变得十分便利。', 'Zhōngguó gāosù lièchē de yùnxíng sùdù fēicháng píngwěn kuàijié, ràng kuà chéng chūxíng biànde shífēn biànlì.', 'Tốc độ vận hành của đoàn tàu cao tốc Trung Quốc vô cùng êm ái nhanh chóng, khiến việc đi lại giữa các thành phố trở nên hết sức thuận tiện.', 'basic', 1),
        (v_id, '在激烈的全球科技创新博弈中，科研成果转化的推进速度直接决定了企业能否在产业竞争中抢占战略制高点。', 'Zài jīliè de quánqiú kējì chuàngxīn bóyì zhōng, kēyán chéngguǒ zhuǎnhuà de tuījìn sùdù zhíjiē juédìng le qǐyè néngfǒu zài chǎnyè jìngzhēng zhōng qiǎngzhàn zhànlüè zhìgāodiǎn.', 'Trong cuộc cọ xát đổi mới khoa học công nghệ toàn cầu khốc liệt, tốc độ thúc đẩy chuyển hóa thành quả nghiên cứu trực tiếp quyết định doanh nghiệp liệu có thể chiếm lĩnh đỉnh cao chiến lược trong cạnh tranh ngành hay không.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [塑料] (sùliào) - nhựa, chất dẻo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '塑料' AND pinyin = 'sùliào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '塑料'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'sùliào',
      meaning_vi = 'nhựa, chất dẻo',
      example_hanzi = '去菜市场买菜时，我们尽量自带布袋，自觉减少一次性塑料袋的使用。',
      example_pinyin = 'Qù càishìchǎng mǎi cài shí, wǒmen jǐnliàng zìdài bùdài, zìjué jiǎnshǎo yícìxìng sùliàodài de shǐyòng.',
      example_vi = 'Khi đi chợ mua rau, chúng ta hãy cố gắng mang theo túi vải, tự giác giảm bớt việc dùng túi nhựa nilon một lần.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '去菜市场买菜时，我们尽量自带布袋，自觉减少一次性塑料袋的使用。', 'Qù càishìchǎng mǎi cài shí, wǒmen jǐnliàng zìdài bùdài, zìjué jiǎnshǎo yícìxìng sùliàodài de shǐyòng.', 'Khi đi chợ mua rau, chúng ta hãy cố gắng mang theo túi vải, tự giác giảm bớt việc dùng túi nhựa nilon một lần.', 'basic', 1),
        (v_id, '为加强生态环境保护，多国政府相继出台严格政策限制难降解传统塑料制品的生产与销售，大力推广可生物降解绿色材料。', 'Wèi jiāqiáng shēngtài huánjìng bǎohù, duō guó zhèngfǔ xiāngjì chūtái yángé zhèngcè xiànzhì nán jiàngjiě chuántǒng sùliào zhìpǐn de shēngchǎn yǔ xiāoshòu, dàlì tuīguǎng kě shēngwù jiàngjiě lǜsè cáiliào.', 'Nhằm tăng cường bảo vệ môi trường sinh thái, chính phủ nhiều nước đã liên tiếp ban hành chính sách nghiêm ngặt hạn chế sản xuất và kinh doanh các sản phẩm nhựa truyền thống khó phân hủy, dốc sức nhân rộng các vật liệu xanh có khả năng tự phân hủy sinh học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [酸] (suān) - chua; mỏi, đau nhức mỏi [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '酸' AND pinyin = 'suān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '酸'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'suān',
      meaning_vi = 'chua; mỏi, đau nhức mỏi',
      example_hanzi = '这个柠檬实在太酸了，必须加很多蜂蜜冲水才能喝得下去。',
      example_pinyin = 'Zhè gè níngméng shízài tài suān le, bìxū jiā hěn duō fēngmì chōng shuǐ cái néng hē de xiàqù.',
      example_vi = 'Quả chanh này quả thực quá chua, bắt buộc phải pha thêm nhiều mật ong với nước thì mới uống nổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个柠檬实在太酸了，必须加很多蜂蜜冲水才能喝得下去。', 'Zhè gè níngméng shízài tài suān le, bìxū jiā hěn duō fēngmì chōng shuǐ cái néng hē de xiàqù.', 'Quả chanh này quả thực quá chua, bắt buộc phải pha thêm nhiều mật ong với nước thì mới uống nổi.', 'basic', 1),
        (v_id, '在电脑前保持不良坐姿伏案工作一整天，他的颈椎和肩膀感到酸痛难忍，医生建议每小时起身做做拉伸放松。', 'Zài diànnǎo qián bǎochí bùliáng zuòzī fú’àn gōngzuò yì zhěng tiān, tā de jǐngzhuī hé jiānbǎng gǎndào suāntòng nánrěn, yīshēng jiànyì měi xiǎoshí qǐshēn zuòzuo lāshēn fàngsōng.', 'Giữ tư thế ngồi không tốt cúi gập người làm việc trước máy tính suốt cả ngày, đốt sống cổ và bờ vai của anh ấy mỏi nhức khó chịu, bác sĩ khuyên mỗi tiếng nên đứng dậy làm động tác duỗi cơ thư giãn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [酸奶] (suānnǎi) - sữa chua [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '酸奶' AND pinyin = 'suānnǎi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '酸奶'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'suānnǎi',
      meaning_vi = 'sữa chua',
      example_hanzi = '每天早餐喝一杯新鲜酸奶搭配麦片，既营养健康又能促进肠胃消化。',
      example_pinyin = 'Měi tiān zǎocān hē yì bēi xīnxiān suānnǎi dāpèi màipiàn, jì yíngyǎng jiànkāng yòu néng cùjìn chángwèi xiāohuà.',
      example_vi = 'Bữa sáng mỗi ngày uống một cốc sữa chua tươi kết hợp với yến mạch, vừa giàu dinh dưỡng tốt cho sức khỏe lại có thể thúc đẩy tiêu hóa đường ruột dạ dày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天早餐喝一杯新鲜酸奶搭配麦片，既营养健康又能促进肠胃消化。', 'Měi tiān zǎocān hē yì bēi xīnxiān suānnǎi dāpèi màipiàn, jì yíngyǎng jiànkāng yòu néng cùjìn chángwèi xiāohuà.', 'Bữa sáng mỗi ngày uống một cốc sữa chua tươi kết hợp với yến mạch, vừa giàu dinh dưỡng tốt cho sức khỏe lại có thể thúc đẩy tiêu hóa đường ruột dạ dày.', 'basic', 1),
        (v_id, '现代乳品加工企业通过引进纯正高活性益生菌发酵菌种，成功研发出兼具零蔗糖与醇厚口感的高端风味酸奶系列产品。', 'Xiàndài rǔpǐn jiāgōng qǐyè tōngguò yǐnjìn chúnzhèng gāo huóxìng yìshēngjūn fāxiào jùnzhǒng, chénggōng yánfā chū jiānjù líng zhètáng yǔ chúnhòu kǒugǎn de gāoduān fēngwèi suānnǎi xìliè chǎnpǐn.', 'Các doanh nghiệp chế biến sữa hiện đại thông qua việc nhập về các chủng men vi sinh probiotic hoạt tính cao thuần chủng, đã nghiên cứu phát triển thành công chuỗi sản phẩm sữa chua hương vị cao cấp vừa không chứa đường mía lại sở hữu hương vị đậm đà.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [算] (suàn) - tính, tính toán; coi như là, rốt cuộc [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '算' AND pinyin = 'suàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '算'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Phó từ',
      pinyin = 'suàn',
      meaning_vi = 'tính, tính toán; coi như là, rốt cuộc',
      example_hanzi = '经过全家人的一番精心计算，我们终于把买房的首付款凑齐了。',
      example_pinyin = 'Jīngguò quán jiā rén de yì fān jīngxīn jìsuàn, wǒmen zhōngyú bǎ mǎi fáng de shǒufùkuǎn còu qí le.',
      example_vi = 'Trải qua tính toán kỹ lưỡng của cả gia đình, chúng tôi cuối cùng đã gom đủ tiền trả trước đợt một để mua nhà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过全家人的一番精心计算，我们终于把买房的首付款凑齐了。', 'Jīngguò quán jiā rén de yì fān jīngxīn jìsuàn, wǒmen zhōngyú bǎ mǎi fáng de shǒufùkuǎn còu qí le.', 'Trải qua tính toán kỹ lưỡng của cả gia đình, chúng tôi cuối cùng đã gom đủ tiền trả trước đợt một để mua nhà.', 'basic', 1),
        (v_id, '历经数月艰苦的技术攻关与多轮极限性能测试，新一代卫星通信芯片总算圆满通过了国家权威部门的综合验收。', 'Lìjīng shù yuè jiānkǔ de jìshù gōngguān yǔ duō lún jíxiàn xìngnéng cèshì, xīn yídài wèixīng tōngxìn xīnpiàn zǒngsuàn yuánmǎn tōngguò le guójiā quánwēi bùmén de zōnghé yànshōu.', 'Trải qua mấy tháng ròng rã đột phá kỹ thuật gian khổ cùng nhiều vòng thử nghiệm hiệu năng giới hạn, con chip truyền thông vệ tinh thế hệ mới rốt cuộc đã vượt qua mỹ mãn đợt nghiệm thu tổng hợp của cơ quan thẩm quyền quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [随便] (suíbiàn) - tùy ý, tùy tiện, tự nhiên [Động từ / Tính từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '随便' AND pinyin = 'suíbiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '随便'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ / Liên từ',
      pinyin = 'suíbiàn',
      meaning_vi = 'tùy ý, tùy tiện, tự nhiên',
      example_hanzi = '大家请随便坐，不用太拘束，就像在自己家里一样。',
      example_pinyin = 'Dàjiā qǐng suíbiàn zuò, búyòng tài jūshù, jiù xiàng zài zìjǐ jiā lǐ yíyàng.',
      example_vi = 'Mời mọi người cứ tự nhiên ngồi, không cần quá câu nệ gò bó, cứ giống như ở nhà mình vậy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大家请随便坐，不用太拘束，就像在自己家里一样。', 'Dàjiā qǐng suíbiàn zuò, búyòng tài jūshù, jiù xiàng zài zìjǐ jiā lǐ yíyàng.', 'Mời mọi người cứ tự nhiên ngồi, không cần quá câu nệ gò bó, cứ giống như ở nhà mình vậy.', 'basic', 1),
        (v_id, '在严肃的商业谈判与法律合同起草过程中，用词表述必须严谨规范，绝不能随随便便使用含糊不清的口语化词汇。', 'Zài yánsù de shāngyè tánpàn yǔ fǎlǜ hétong qǐcǎo guòchéng zhōng, yòngcí biǎoshù bìxū yánjǐn guīfàn, jué bù néng suísuí-biànbiàn shǐyòng hánhú-bùqīng de kǒuyǔhuà cíhuì.', 'Trong quá trình đàm phán thương mại nghiêm túc và soạn thảo hợp đồng pháp lý, việc dùng từ diễn đạt bắt buộc phải nghiêm cẩn chuẩn mực, tuyệt đối không được tùy tiện sử dụng các từ ngữ khẩu ngữ mơ hồ không rõ ràng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [随着] (suízhe) - cùng với, theo đà [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '随着' AND pinyin = 'suízhe'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '随着'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'suízhe',
      meaning_vi = 'cùng với, theo đà',
      example_hanzi = '随着春季气温逐渐回升，路旁的花草树木纷纷吐露出嫩绿的新芽。',
      example_pinyin = 'Suízhe chūnjì qìwēn zhújiàn huíshēng, lùpáng de huācǎo-shùmù fēnfēn tǔlù chū nènlǜ de xīnyá.',
      example_vi = 'Cùng với nhiệt độ mùa xuân dần ấm lên, cây cỏ hoa lá ven đường đồng loạt trổ ra những chồi non xanh mướt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着春季气温逐渐回升，路旁的花草树木纷纷吐露出嫩绿的新芽。', 'Suízhe chūnjì qìwēn zhújiàn huíshēng, lùpáng de huācǎo-shùmù fēnfēn tǔlù chū nènlǜ de xīnyá.', 'Cùng với nhiệt độ mùa xuân dần ấm lên, cây cỏ hoa lá ven đường đồng loạt trổ ra những chồi non xanh mướt.', 'basic', 1),
        (v_id, '随着人工智能与大数据算法在医疗诊断领域的深入渗透，个性化精准诊疗方案正在为战胜复杂疑难杂症带来革命性突破。', 'Suízhe réngōng zhìnéng yǔ dà shùjù suànfǎ zài yīliáo zhěnduàn lǐngyù de shēnrù shèntòu, gèxìnghuà jīngzhǔn zhěnliáo fāng’àn zhèngzài wèi zhànshèng fùzá yínán-zázhèng dàilái gémìngxìng tūpò.', 'Cùng với sự thâm nhập sâu sắc của trí tuệ nhân tạo và thuật toán dữ liệu lớn trong lĩnh vực chẩn đoán y tế, các phác đồ khám chữa bệnh chuẩn xác cá nhân hóa đang mang lại đột phá mang tính cách mạng nhằm chiến thắng các căn bệnh phức tạp nan y.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [孙女] (sūnnǚ) - cháu gái (nội) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '孙女' AND pinyin = 'sūnnǚ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '孙女'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'sūnnǚ',
      meaning_vi = 'cháu gái (nội)',
      example_hanzi = '爷爷每天下午都会准时去学校门口接小孙女放学回家。',
      example_pinyin = 'Yéye měi tiān xiàwǔ dōu huì zhǔnshí qù xuéxiào ménkǒu jiē xiǎo sūnnǚ fàngxué huíjiā.',
      example_vi = 'Ông nội mỗi buổi chiều đều đi đến cổng trường đúng giờ để đón cháu gái nhỏ tan học về nhà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爷爷每天下午都会准时去学校门口接小孙女放学回家。', 'Yéye měi tiān xiàwǔ dōu huì zhǔnshí qù xuéxiào ménkǒu jiē xiǎo sūnnǚ fàngxué huíjiā.', 'Ông nội mỗi buổi chiều đều đi đến cổng trường đúng giờ để đón cháu gái nhỏ tan học về nhà.', 'basic', 1),
        (v_id, '这位德高望重的老教授在学术退休座谈会上深情表示，未来希望能有更多时间陪伴小孙女快乐健康地成长。', 'Zhè wèi dégāo-wàngzhòng de lǎo jiàoshòu zài xuéshù tuìxiū zuòtánhuì shang shēnqíng biàoshì, wèilái xīwàng néng yǒu gèng duō shíjiān péibàn xiǎo sūnnǚ kuàilè jiànkāng de chéngzhǎng.', 'Vị giáo sư già đức cao vọng trọng này trong buổi tọa đàm về hưu học thuật đã xúc động chia sẻ rằng tương lai hy vọng có thêm nhiều thời gian đồng hành cùng cháu gái nhỏ lớn khôn vui vẻ và mạnh khỏe.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [孙子] (sūnzi) - cháu trai (nội) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '孙子' AND pinyin = 'sūnzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '孙子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'sūnzi',
      meaning_vi = 'cháu trai (nội)',
      example_hanzi = '奶奶看到可爱的孙子考了全班第一名，脸上笑开了花。',
      example_pinyin = 'Nǎinai kàndào kě’ài de sūnzi kǎo le quán bān dì-yī míng, liǎn shang xiào kāi le huā.',
      example_vi = 'Bà nội nhìn thấy đứa cháu trai đáng yêu thi đứng nhất lớp, khuôn mặt tươi cười như hoa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '奶奶看到可爱的孙子考了全班第一名，脸上笑开了花。', 'Nǎinai kàndào kě’ài de sūnzi kǎo le quán bān dì-yī míng, liǎn shang xiào kāi le huā.', 'Bà nội nhìn thấy đứa cháu trai đáng yêu thi đứng nhất lớp, khuôn mặt tươi cười như hoa.', 'basic', 1),
        (v_id, '传承优良家风是中华传统文化的重要精髓，祖辈经常将诚实勤勉的立身格言谆谆教导给年幼的孙子。', 'Chuánchéng yōuliáng jiāfēng shì Zhōnghuá chuántǒng wénhuà de zhòngyào jīngsuǐ, zǔbèi jīngcháng jiāng chéngshí qínmiǎn de lìshēn géyán zhūnzhūn jiàodǎo gěi niányòu de sūnzi.', 'Lưu truyền gia phong tốt đẹp là tinh hoa quan trọng của văn hóa truyền thống Trung Hoa, thế hệ ông bà thường ân cần dạy bảo cho cháu trai thơ ấu những châm ngôn lập thân về sự trung thực và cần mẫn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [所有] (suǒyǒu) - tất cả, toàn bộ, sở hữu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '所有' AND pinyin = 'suǒyǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '所有'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'suǒyǒu',
      meaning_vi = 'tất cả, toàn bộ, sở hữu',
      example_hanzi = '出发前请大家仔细检查一遍，确认带齐了所有的随身行李物品。',
      example_pinyin = 'Chūfā qián qǐng dàjiā zǐxì jiǎnchá yí biàn, quèrèn dài qí le suǒyǒu de suíshēn xíngli wùpǐn.',
      example_vi = 'Trước khi xuất phát xin mọi người hãy kiểm tra kỹ một lượt, xác nhận đã đem đủ tất cả hành lý đồ đạc tùy thân.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出发前请大家仔细检查一遍，确认带齐了所有的随身行李物品。', 'Chūfā qián qǐng dàjiā zǐxì jiǎnchá yí biàn, quèrèn dài qí le suǒyǒu de suíshēn xíngli wùpǐn.', 'Trước khi xuất phát xin mọi người hãy kiểm tra kỹ một lượt, xác nhận đã đem đủ tất cả hành lý đồ đạc tùy thân.', 'basic', 1),
        (v_id, '在法治社会中，所有公民和法人在法律面前一律平等，任何组织都不得享有超越宪法法律的特权。', 'Zài fǎzhì shèhuì zhōng, suǒyǒu gōngmín hé fǎrén zài fǎlǜ miànqián yílǜ píngděng, rènhé zǔzhī dōu bùdé xiǎngyǒu chāoyuè xiànfǎ fǎlǜ de tèquán.', 'Trong một xã hội pháp quyền, tất cả mọi công dân và pháp nhân trước pháp luật đều bình đẳng như nhau, bất kỳ tổ chức nào cũng không được hưởng đặc quyền vượt lên trên hiến pháp và pháp luật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [台] (tái) - chiếc, cái, cỗ; bệ, đài, sân khấu [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '台' AND pinyin = 'tái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '台'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'tái',
      meaning_vi = 'chiếc, cái, cỗ; bệ, đài, sân khấu',
      example_hanzi = '我们实验室新添置了两台高精度的实验测量仪器。',
      example_pinyin = 'Wǒmen shíyànshì xīn tiānzhì le liǎng tái gāo jīngdù de shíyàn cèliáng yíqì.',
      example_vi = 'Phòng thí nghiệm chúng tôi mới mua sắm thêm hai chiếc máy đo lường thí nghiệm độ chính xác cao.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们实验室新添置了两台高精度的实验测量仪器。', 'Wǒmen shíyànshì xīn tiānzhì le liǎng tái gāo jīngdù de shíyàn cèliáng yíqì.', 'Phòng thí nghiệm chúng tôi mới mua sắm thêm hai chiếc máy đo lường thí nghiệm độ chính xác cao.', 'basic', 1),
        (v_id, '年轻演员历经数十载艰苦磨砺，终于能够沉稳自信地登上国家级艺术大剧院的璀璨舞台展现风采。', 'Niánqīng yǎnyuán lìjīng shùshí zǎi jiānkǔ mólì, zhōngyú nénggòu chénwěn zìxìn de dēng shàng guójiājí yìshù dà jùyuàn de cuǐcàn wǔtái zhǎnxiàn fēngcǎi.', 'Diễn viên trẻ sau mấy chục năm rèn luyện mài giũa gian khổ, cuối cùng đã có thể vững vàng tự tin bước lên sân khấu lung linh của nhà hát lớn nghệ thuật cấp quốc gia để khoe tài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [抬] (tái) - ngẩng, nâng; khiêng, vác [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '抬' AND pinyin = 'tái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '抬'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tái',
      meaning_vi = 'ngẩng, nâng; khiêng, vác',
      example_hanzi = '请大家抬起头来，跟着黑板上的例句大声朗读一遍。',
      example_pinyin = 'Qǐng dàjiā tái qǐ tóu lái, gēnzhe hēibǎn shang de lìjù dàshēng lǎngdú yí biàn.',
      example_vi = 'Xin mời mọi người ngẩng đầu lên, đọc to theo câu ví dụ trên bảng đen một lần.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请大家抬起头来，跟着黑板上的例句大声朗读一遍。', 'Qǐng dàjiā tái qǐ tóu lái, gēnzhe hēibǎn shang de lìjù dàshēng lǎngdú yí biàn.', 'Xin mời mọi người ngẩng đầu lên, đọc to theo câu ví dụ trên bảng đen một lần.', 'basic', 1),
        (v_id, '两位年轻志愿者奋不顾身地抬起沉重的救援担架，将重伤员迅速转移至直升机临时停机坪。', 'Liǎng wèi niánqīng zhìyuànzhě fènbùgùshēn de tái qǐ chénzhòng de jiùyuán dānjià, jiāng zhòngshāngyuán xùnsù zhuǎnyí zhì zhíshēngjī línshí tíngjīpíng.', 'Hai tình nguyện viên trẻ tuổi đã quên mình khiêng chiếc cáng cứu hộ nặng nề, nhanh chóng chuyển bệnh nhân bị thương nặng tới bãi đỗ trực thăng tạm thời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [抬头] (táitóu) - ngẩng đầu, ngước nhìn; ngóc đầu lên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '抬头' AND pinyin = 'táitóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '抬头'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'táitóu',
      meaning_vi = 'ngẩng đầu, ngước nhìn; ngóc đầu lên',
      example_hanzi = '夜晚走在宁静的乡间小路上，抬头就能看见满天璀璨的繁星。',
      example_pinyin = 'Yèwǎn zǒu zài níngjìng de xiāngjiān xiǎolù shang, táitóu jiù néng kànjiàn mǎntiān cuǐcàn de fánxīng.',
      example_vi = 'Buổi tối đi trên con đường làng yên tĩnh, ngẩng đầu lên là có thể nhìn thấy muôn vì sao lấp lánh khắp trời.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夜晚走在宁静的乡间小路上，抬头就能看见满天璀璨的繁星。', 'Yèwǎn zǒu zài níngjìng de xiāngjiān xiǎolù shang, táitóu jiù néng kànjiàn mǎntiān cuǐcàn de fánxīng.', 'Buổi tối đi trên con đường làng yên tĩnh, ngẩng đầu lên là có thể nhìn thấy muôn vì sao lấp lánh khắp trời.', 'basic', 1),
        (v_id, '青年学者在学术探索中既要脚踏实地扎实钻研专业细节，更要经常抬头看路把握国际学术前沿的大趋势。', 'Qīngnián xuézhě zài xuéshù tànsuǒ zhōng jì yào jiǎotàshídì zhāshi zuānyán zhuānyè xìjié, gèng yào jīngcháng táitóu kàn lù bǎwò guójì xuéshù qiányán de dà qūshì.', 'Các học giả trẻ trong nghiên cứu học thuật vừa phải đặt chân vững vàng chuyên tâm nghiên cứu sâu các chi tiết chuyên ngành, càng phải thường xuyên ngẩng đầu nhìn đường để nắm bắt xu thế lớn của mũi nhọn học thuật quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [态度] (tàidu) - thái độ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '态度' AND pinyin = 'tàidu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '态度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tàidu',
      meaning_vi = 'thái độ',
      example_hanzi = '这家餐厅的服务员态度十分亲切周到，给顾客留下了极好的印象。',
      example_pinyin = 'Zhè jiā cāntīng de fúwùyuán tàidu shífēn qīnqiè zhōudào, gěi gùkè liúxià le jí hǎo de yìnxiàng.',
      example_vi = 'Nhân viên phục vụ của nhà hàng này có thái độ rất thân thiện và chu đáo, để lại ấn tượng vô cùng tốt đẹp cho thực khách.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家餐厅的服务员态度十分亲切周到，给顾客留下了极好的印象。', 'Zhè jiā cāntīng de fúwùyuán tàidu shífēn qīnqiè zhōudào, gěi gùkè liúxià le jí hǎo de yìnxiàng.', 'Nhân viên phục vụ của nhà hàng này có thái độ rất thân thiện và chu đáo, để lại ấn tượng vô cùng tốt đẹp cho thực khách.', 'basic', 1),
        (v_id, '在科学探索与技术攻关的道路上，必须始终保持严谨客观、实事求是的治学态度，容不得半点虚假。', 'Zài kēxué tànsuǒ yǔ jìshù gōngguān de dàolù shang, bìxū shǐzhōng bǎochí yánjǐn kèguān, shíshì-qiúshì de zhìxué tàidu, róngbudé bàndiǎnr xūjiǎ.', 'Trên con đường khám phá khoa học và đột phá kỹ thuật, bắt buộc phải luôn giữ vững thái độ làm học vấn nghiêm cẩn khách quan và đúng sự thật, không chấp nhận mảy may giả dối.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [弹] (tán) - gảy, búng, chơi (nhạc cụ có dây) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '弹' AND pinyin = 'tán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '弹'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tán',
      meaning_vi = 'gảy, búng, chơi (nhạc cụ có dây)',
      example_hanzi = '小妹妹从五岁开始学习弹钢琴，现在已经能弹奏很多著名中外名曲了。',
      example_pinyin = 'Xiǎo mèimei cóng wǔ suì kāishǐ xuéxí tán gāngqín, xiànzài yǐjīng néng tánzòu hěn duō zhùmíng zhōng-wài míngqǔ le.',
      example_vi = 'Em gái nhỏ từ năm tuổi đã bắt đầu học đánh đàn piano, hiện nay đã có thể tấu lên rất nhiều khúc ca nổi tiếng trong và ngoài nước.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小妹妹从五岁开始学习弹钢琴，现在已经能弹奏很多著名中外名曲了。', 'Xiǎo mèimei cóng wǔ suì kāishǐ xuéxí tán gāngqín, xiànzài yǐjīng néng tánzòu hěn duō zhùmíng zhōng-wài míngqǔ le.', 'Em gái nhỏ từ năm tuổi đã bắt đầu học đánh đàn piano, hiện nay đã có thể tấu lên rất nhiều khúc ca nổi tiếng trong và ngoài nước.', 'basic', 1),
        (v_id, '音乐家在古典音乐会上深情弹奏中国传统古筝名曲《高山流水》，空灵悠扬的琴声令全场听众听得如痴如醉。', 'Yīnyuèjiā zài gǔdiǎn yīnyuèhuì shang shēnqíng tánzòu Zhōngguó chuántǒng gǔzhēng míngqǔ “Gāoshān Liúshuǐ”, kōnglíng yōuyáng de qínshēng lìng quán chǎng tīngzhòng tīng de rúchī-rúzuì.', 'Nhà âm nhạc trong buổi hòa nhạc cổ điển đã biểu diễn gảy khúc nhạc đàn tranh truyền thống Trung Hoa bất hủ "Cao Sơn Lưu Thủy" đầy truyền cảm, tiếng đàn thanh thoát du dương khiến toàn thể khán thính giả lắng nghe đến say đắm ngây ngất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [谈] (tán) - nói chuyện, đàm thoại, bàn bạc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '谈' AND pinyin = 'tán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '谈'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tán',
      meaning_vi = 'nói chuyện, đàm thoại, bàn bạc',
      example_hanzi = '晚饭后大家围坐在客厅沙发上，愉快地谈论着白天的趣事。',
      example_pinyin = 'Wǎnfàn hòu dàjiā wéizuò zài kètīng shāfā shang, yúkuài de tánlùnzhe báitiān de qùshì.',
      example_vi = 'Sau bữa tối mọi người ngồi quây quần trên ghế sô pha phòng khách, vui vẻ bàn luận về những mẩu chuyện thú vị ban ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '晚饭后大家围坐在客厅沙发上，愉快地谈论着白天的趣事。', 'Wǎnfàn hòu dàjiā wéizuò zài kètīng shāfā shang, yúkuài de tánlùnzhe báitiān de qùshì.', 'Sau bữa tối mọi người ngồi quây quần trên ghế sô pha phòng khách, vui vẻ bàn luận về những mẩu chuyện thú vị ban ngày.', 'basic', 1),
        (v_id, '两国外交代表团就全面深化战略互信与双边多领域经贸投资合作展开了建设性深入会谈。', 'Liǎng guó wàijiāo dàibiǎotuán jiù quánmiàn shēnhuà zhànlüè hùxìn yǔ shuāngbiān duō lǐngyù jīng-mào tóuzī hézuò zhǎnkāi le jiànshèxìng shēnrù huìtán.', 'Đoàn đại biểu ngoại giao hai nước đã tiến hành hội đàm sâu sắc mang tính xây dựng về việc làm sâu sắc toàn diện lòng tin chiến lược lẫn nhau và hợp tác đầu tư kinh tế thương mại nhiều lĩnh vực song phương.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [汤] (tāng) - canh, súp, nước dùng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '汤' AND pinyin = 'tāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '汤'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tāng',
      meaning_vi = 'canh, súp, nước dùng',
      example_hanzi = '冬天喝一碗热气腾腾的牛肉萝卜汤，感觉整个人都暖和了起来。',
      example_pinyin = 'Dōngtiān hē yì wǎn rèqì-téngténg de niúròu luóbo tāng, gǎnjué zhěng gè rén dōu nuǎnhuo le qǐlai.',
      example_vi = 'Mùa đông húp một bát canh thịt bò nấu củ cải nóng hổi bốc khói, cảm thấy cả người ấm hẳn lên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '冬天喝一碗热气腾腾的牛肉萝卜汤，感觉整个人都暖和了起来。', 'Dōngtiān hē yì wǎn rèqì-téngténg de niúròu luóbo tāng, gǎnjué zhěng gè rén dōu nuǎnhuo le qǐlai.', 'Mùa đông húp một bát canh thịt bò nấu củ cải nóng hổi bốc khói, cảm thấy cả người ấm hẳn lên.', 'basic', 1),
        (v_id, '广府传统老火靓汤讲究药食同源，因时因季选用精选药材文火慢炖数小时，蕴含着深厚独到的岭南养生文化。', 'Guǎngfǔ chuántǒng lǎohuǒ liàngtāng jiǎngjiu yào-shí tóngyuán, yīn shí yīn jì xuǎnyòng jīngxuǎn yàocái wénhuǒ màn dùn shù xiǎoshí, yùnhánzhe shēnhòu dúdào de Lǐngnán yǎngshēng wénhuà.', 'Món canh thuốc ninh lửa nhỏ truyền thống Quảng Đông rất coi trọng triết lý thuốc và thức ăn cùng nguồn gốc, tùy thời tiết theo mùa mà chọn lọc dược liệu ninh nhỏ lửa nhiều giờ, hàm chứa nét văn hóa dưỡng sinh Lĩnh Nam sâu sắc độc đáo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [躺] (tǎng) - nằm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '躺' AND pinyin = 'tǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '躺'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tǎng',
      meaning_vi = 'nằm',
      example_hanzi = '工作累了一整天，回到家躺在舒适柔软的沙发上感觉格外轻松。',
      example_pinyin = 'Gōngzuò lèi le yì zhěng tiān, huí dào jiā tǎng zài shūshì róuruǎn de shāfā shang gǎnjué géwài qīngsōng.',
      example_vi = 'Làm việc mệt mỏi cả ngày, về tới nhà nằm trên chiếc ghế sô pha êm ái dễ chịu cảm thấy vô cùng thoải mái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '工作累了一整天，回到家躺在舒适柔软的沙发上感觉格外轻松。', 'Gōngzuò lèi le yì zhěng tiān, huí dào jiā tǎng zài shūshì róuruǎn de shāfā shang gǎnjué géwài qīngsōng.', 'Làm việc mệt mỏi cả ngày, về tới nhà nằm trên chiếc ghế sô pha êm ái dễ chịu cảm thấy vô cùng thoải mái.', 'basic', 1),
        (v_id, '医生再三叮嘱做完腰椎手术的患者必须绝对卧床静养平躺两周，切勿过早下地负重活动。', 'Yīshēng zàisān dīngzhǔ zuò wán yāozhuī shǒushù de huànzhě bìxū juéduì wòchuáng jìngyǎng píngtǎng liǎng zhōu, qièwù guòzǎo xiàdì fùzhòng huódòng.', 'Bác sĩ dặn đi dặn lại bệnh nhân sau khi mổ cột sống thắt lưng bắt buộc phải tuyệt đối nằm yên trên giường tĩnh dưỡng trong hai tuần, chớ nên xuống đất vận động mang vác quá sớm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [趟] (tàng) - chuyến, lượt [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '趟' AND pinyin = 'tàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '趟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'tàng',
      meaning_vi = 'chuyến, lượt',
      example_hanzi = '趁着周末天气晴朗，我打算回一趟老家探望年迈的爷爷奶奶。',
      example_pinyin = 'Chènzhe zhōumò tiānqì qínglǎng, wǒ dǎsuan huí yí tàng lǎojiā tànwàng niánmài de yéye nǎinai.',
      example_vi = 'Nhân lúc cuối tuần thời tiết nắng đẹp, tôi dự định về quê một chuyến thăm ông bà nội tuổi già sức yếu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '趁着周末天气晴朗，我打算回一趟老家探望年迈的爷爷奶奶。', 'Chènzhe zhōumò tiānqì qínglǎng, wǒ dǎsuan huí yí tàng lǎojiā tànwàng niánmài de yéye nǎinai.', 'Nhân lúc cuối tuần thời tiết nắng đẹp, tôi dự định về quê một chuyến thăm ông bà nội tuổi già sức yếu.', 'basic', 1),
        (v_id, '为了落实关键设备采购的各项合同细节，商务代表团在一个月内连续往返跑了三趟欧洲各大供应商工厂。', 'Wèile luòshí guānjiàn shèbèi cǎigòu de gè xiàng hétong xìjié, shāngwù dàibiǎotuán zài yí gè yuè nèi liánxù wǎngfǎn pǎo le sān tàng Ōuzhōu gè dà gōngyìngshāng gōngchǎng.', 'Nhằm triển khai chi tiết các hợp đồng thu mua thiết bị then chốt, đoàn đại biểu thương vụ trong vòng một tháng đã liên tục đi về ba chuyến tới các nhà máy nhà cung cấp lớn ở châu Âu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [讨论] (tǎolùn) - thảo luận, bàn bạc [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '讨论' AND pinyin = 'tǎolùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '讨论'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'tǎolùn',
      meaning_vi = 'thảo luận, bàn bạc',
      example_hanzi = '下课后，几位同学聚在图书馆的研讨室一起热烈讨论数学作业难题。',
      example_pinyin = 'Xiàkè hòu, jǐ wèi tóngxué jù zài túshūguǎn de yántǎoshì yìqǐ rèliè tǎolùn shùxué zuòyè nántí.',
      example_vi = 'Sau khi tan học, mấy bạn học tụ tập trong phòng hội thảo thư viện cùng nhau thảo luận sôi nổi về bài toán khó.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '下课后，几位同学聚在图书馆的研讨室一起热烈讨论数学作业难题。', 'Xiàkè hòu, jǐ wèi tóngxué jù zài túshūguǎn de yántǎoshì yìqǐ rèliè tǎolùn shùxué zuòyè nántí.', 'Sau khi tan học, mấy bạn học tụ tập trong phòng hội thảo thư viện cùng nhau thảo luận sôi nổi về bài toán khó.', 'basic', 1),
        (v_id, '专家评审委员会围绕城市中长期轨道交通规划方案的可行性与生态环境影响展开了长达两天的专题科学讨论。', 'Zhuānjiā píngshěn wěiyuánhuì wéirào chéngshì zhōng-chángqī guǐdào jiāotōng guīhuà fāng’àn de kěxíngxìng yǔ shēngtài huánjìng yǐngxiǎng zhǎnkāi le cháng dá liǎng tiān de zhuāntí kēxué tǎolùn.', 'Hội đồng thẩm định chuyên gia đã xoay quanh tính khả thi và tác động môi trường sinh thái của phương án quy hoạch giao thông đường sắt trung và dài hạn của thành phố để mở cuộc thảo luận khoa học chuyên đề kéo dài tới hai ngày.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [讨厌] (tǎoyàn) - ghét, chán ghét; đáng ghét [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '讨厌' AND pinyin = 'tǎoyàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '讨厌'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'tǎoyàn',
      meaning_vi = 'ghét, chán ghét; đáng ghét',
      example_hanzi = '夏天露营的时候最讨厌有成群的蚊子在耳边嗡嗡叫。',
      example_pinyin = 'Xiàtiān lùyíng de shíhou zuì tǎoyàn yǒu chéngqún de wénzi zài ěrbiān wēngwēng jiào.',
      example_vi = 'Lúc cắm trại mùa hè ghét nhất là có từng đàn muỗi vo ve kêu quanh tai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夏天露营的时候最讨厌有成群的蚊子在耳边嗡嗡叫。', 'Xiàtiān lùyíng de shíhou zuì tǎoyàn yǒu chéngqún de wénzi zài ěrbiān wēngwēng jiào.', 'Lúc cắm trại mùa hè ghét nhất là có từng đàn muỗi vo ve kêu quanh tai.', 'basic', 1),
        (v_id, '在职场人际沟通中，傲慢自大、推诿扯皮的行事作风往往最令人讨厌，真诚协作才能建立长久互信。', 'Zài zhíchǎng rénjì gōutōng zhōng, àomàn-zìdà, tuīwěi-chěpí de xíngshì zuòfēng wǎngwǎng zuì lìng rén tǎoyàn, zhēnchéng xiézuò cái néng jiànlì chángjiǔ hùxìn.', 'Trong giao tiếp quan hệ đồng nghiệp nơi làm việc, tác phong làm việc ngạo mạn tự phụ và đùn đẩy trách nhiệm thường khiến người khác chán ghét nhất, chỉ có chân thành cộng tác mới xây dựng được lòng tin cậy dài lâu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [特点] (tèdiǎn) - đặc điểm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '特点' AND pinyin = 'tèdiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '特点'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tèdiǎn',
      meaning_vi = 'đặc điểm',
      example_hanzi = '这只智能手表的显著特点是电池续航时间长且具备专业的防水功能。',
      example_pinyin = 'Zhè zhī zhìnéng shǒubiǎo de xiǎnzhù tèdiǎn shì diànchí xùháng shíjiān cháng qiě jùbèi zhuānyè de fángshuǐ gōngnéng.',
      example_vi = 'Đặc điểm nổi bật của chiếc đồng hồ thông minh này là thời lượng pin dài và có chức năng chống nước chuyên nghiệp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这只智能手表的显著特点是电池续航时间长且具备专业的防水功能。', 'Zhè zhī zhìnéng shǒubiǎo de xiǎnzhù tèdiǎn shì diànchí xùháng shíjiān cháng qiě jùbèi zhuānyè de fángshuǐ gōngnéng.', 'Đặc điểm nổi bật của chiếc đồng hồ thông minh này là thời lượng pin dài và có chức năng chống nước chuyên nghiệp.', 'basic', 1),
        (v_id, '因地制宜是乡村特色产业发展的灵魂，必须深度挖掘当地自然资源禀赋与深厚历史文化特点，走差异化品牌发展之路。', 'Yīndìzhìyí shì xiāngcūn tèsè chǎnyè fāzhǎn de línghún, bìxū shēndù wājué dāngdì zìrán zīyuán bǐngfù yǔ shēnhòu lìshǐ wénhuà tèdiǎn, zǒu chāyìhuà pǐnpái fāzhǎn zhī lù.', 'Tùy cơ ứng biến theo vùng đất là linh hồn của sự phát triển ngành nghề đặc sắc nông thôn, bắt buộc phải khai thác sâu sắc tài nguyên thiên nhiên vốn có cùng các đặc điểm lịch sử văn hóa dày dặn của bản địa, bước đi trên con đường phát triển thương hiệu khác biệt hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [提] (tí) - xách, nhấc; đề cập, nêu ra [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '提' AND pinyin = 'tí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '提'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tí',
      meaning_vi = 'xách, nhấc; đề cập, nêu ra',
      example_hanzi = '他手里提着两袋沉重的新鲜水果，快步向家里走去。',
      example_pinyin = 'Tā shǒu lǐ tízhe liǎng dài chénzhòng de xīnxiān shuǐguǒ, kuàibù xiàng jiā lǐ zǒu qù.',
      example_vi = 'Trên tay anh ấy xách hai túi hoa quả tươi nặng trĩu, rảo bước đi nhanh về nhà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他手里提着两袋沉重的新鲜水果，快步向家里走去。', 'Tā shǒu lǐ tízhe liǎng dài chénzhòng de xīnxiān shuǐguǒ, kuàibù xiàng jiā lǐ zǒu qù.', 'Trên tay anh ấy xách hai túi hoa quả tươi nặng trĩu, rảo bước đi nhanh về nhà.', 'basic', 1),
        (v_id, '在本次跨部门业务协调会上，技术总监当场提了三条极具建设性的优化方案。', 'Zài běn cì kuà bùmén yèwù xiétiáo huì shang, jìshù zǒngjiān dāngchǎng tí le sān tiáo jí jù jiànshèxìng de yōuhuà fāng’àn.', 'Trong cuộc họp điều phối nghiệp vụ liên phòng ban lần này, giám đốc kỹ thuật đã nêu ra ngay tại chỗ ba phương án tối ưu hóa mang tính xây dựng rất cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [提出] (tíchū) - đưa ra, nêu ra, đề xuất [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '提出' AND pinyin = 'tíchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '提出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tíchū',
      meaning_vi = 'đưa ra, nêu ra, đề xuất',
      example_hanzi = '如果你对本次班级春游活动安排有什么建议，可以随时向班长提出。',
      example_pinyin = 'Rúguǒ nǐ duì běn cì bānjí chūnyóu huódòng ānpái yǒu shénme jiànyì, kěyǐ suíshí xiàng bānzhǎng tíchū.',
      example_vi = 'Nếu bạn có kiến nghị gì về việc sắp xếp hoạt động du xuân của lớp lần này, có thể đề xuất với lớp trưởng bất cứ lúc nào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如果你对本次班级春游活动安排有什么建议，可以随时向班长提出。', 'Rúguǒ nǐ duì běn cì bānjí chūnyóu huódòng ānpái yǒu shénme jiànyì, kěyǐ suíshí xiàng bānzhǎng tíchū.', 'Nếu bạn có kiến nghị gì về việc sắp xếp hoạt động du xuân của lớp lần này, có thể đề xuất với lớp trưởng bất cứ lúc nào.', 'basic', 1),
        (v_id, '科学家在顶尖国际学术论坛上正式提出了量子计算与生物医药交叉研究的全新理论构架。', 'Kēxuéjiā zài dǐngjiān guójì xuéshù lùntán shang zhèngshì tíchū le liàngzǐ jìsuàn yǔ shēngwù yīyào jiāochā yánjiū de quánxīn lǐlùn gòujià.', 'Các nhà khoa học trong diễn đàn học thuật quốc tế đỉnh cao đã chính thức đưa ra khung lý thuyết hoàn toàn mới về nghiên cứu giao thoa giữa tính toán lượng tử và y dược sinh học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [提到] (tídào) - nhắc tới, đề cập tới [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '提到' AND pinyin = 'tídào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '提到'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tídào',
      meaning_vi = 'nhắc tới, đề cập tới',
      example_hanzi = '老师刚才在课堂上专门提到了这本语法参考书的重要性。',
      example_pinyin = 'Lǎoshī gāngcái zài kètáng shang zhuānmén tídào le zhè běn yǔfǎ cānkǎoshū de zhòngyàoxìng.',
      example_vi = 'Thầy giáo vừa rồi trên lớp đã đặc biệt nhắc tới tầm quan trọng của cuốn sách tham khảo ngữ pháp này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师刚才在课堂上专门提到了这本语法参考书的重要性。', 'Lǎoshī gāngcái zài kètáng shang zhuānmén tídào le zhè běn yǔfǎ cānkǎoshū de zhòngyàoxìng.', 'Thầy giáo vừa rồi trên lớp đã đặc biệt nhắc tới tầm quan trọng của cuốn sách tham khảo ngữ pháp này.', 'basic', 1),
        (v_id, '国家发展改革委发布的最新规划纲要中，明确提到了要加快培育壮大绿色低碳战略性新兴产业。', 'Guójiā Fāzhǎn Gǎigé Wěi fābù de zuìxīn guīhuà gāngyào zhōng, míngquè tídào le yào jiākuài péiyù zhuàngdà lǜsè dītàn zhànlüèxìng xīnxīng chǎnyè.', 'Trong cương yếu quy hoạch mới nhất do Ủy ban Phát triển và Cải cách Quốc gia công bố, đã nêu rõ ràng cần đẩy nhanh việc nuôi dưỡng và lớn mạnh các ngành công nghiệp mới nổi mang tính chiến lược các-bon thấp xanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [提供] (tígōng) - cung cấp, đem lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '提供' AND pinyin = 'tígōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '提供'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tígōng',
      meaning_vi = 'cung cấp, đem lại',
      example_hanzi = '这家青年旅舍每天清晨为入住的旅客免费提供丰盛可口的营养早餐。',
      example_pinyin = 'Zhè jiā qīngnián lǚshè měi tiān qīngchén wèi rùzhù de lǚkè miǎnfèi tígōng fēngshèng kěkǒu de yíngyǎng zǎocān.',
      example_vi = 'Nhà nghỉ thanh niên này mỗi sáng sớm đều cung cấp bữa sáng dinh dưỡng phong phú ngon miệng miễn phí cho du khách lưu trú.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家青年旅舍每天清晨为入住的旅客免费提供丰盛可口的营养早餐。', 'Zhè jiā qīngnián lǚshè měi tiān qīngchén wèi rùzhù de lǚkè miǎnfèi tígōng fēngshèng kěkǒu de yíngyǎng zǎocān.', 'Nhà nghỉ thanh niên này mỗi sáng sớm đều cung cấp bữa sáng dinh dưỡng phong phú ngon miệng miễn phí cho du khách lưu trú.', 'basic', 1),
        (v_id, '金融监管部门出台多项支持政策，引导商业银行加大对科技型中小微企业的信贷支持并提供优惠利率。', 'Jīnróng jiānguǎn bùmén chūtái duō xiàng zhīchí zhèngcè, yǐndǎo shāngyè yínháng jiàdà duì kējìxíng zhōng-xiǎowēi qǐyè de xìndài zhīchí bìng tígōng yōuhuì lìlǜ.', 'Cơ quan giám sát tài chính đã ban hành nhiều chính sách hỗ trợ, định hướng các ngân hàng thương mại gia tăng hỗ trợ tín dụng và cung cấp mức lãi suất ưu đãi cho các doanh nghiệp vừa, nhỏ và siêu nhỏ công nghệ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [提前] (tíqián) - sớm hơn, trước thời hạn, sớm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '提前' AND pinyin = 'tíqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '提前'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tíqián',
      meaning_vi = 'sớm hơn, trước thời hạn, sớm',
      example_hanzi = '由于明天早晨可能堵车，我们决定提前半小时从家里出发。',
      example_pinyin = 'Yóuyú míngtiān zǎochén kěnéng dǔchē, wǒmen juédìng tíqián bàn xiǎoshí cóng jiā lǐ chūfā.',
      example_vi = 'Do sáng mai có thể tắc đường, chúng tôi quyết định xuất phát từ nhà sớm hơn nửa tiếng đồng hồ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '由于明天早晨可能堵车，我们决定提前半小时从家里出发。', 'Yóuyú míngtiān zǎochén kěnéng dǔchē, wǒmen juédìng tíqián bàn xiǎoshí cóng jiā lǐ chūfā.', 'Do sáng mai có thể tắc đường, chúng tôi quyết định xuất phát từ nhà sớm hơn nửa tiếng đồng hồ.', 'basic', 1),
        (v_id, '经过全体工程建设人员的日夜奋战，这条连接两座重点经济区的高速铁路提前两个月全线通车。', 'Jīngguò quántǐ gōngchéng jiànshè rényuán de rìyè fènzhàn, zhè tiáo liánjiē liǎng zuò zhòngdiǎn jīngjìqū de gāosù tiělù tíqián liǎng gè yuè quánxiàn tōngchē.', 'Qua sự chiến đấu ngày đêm của toàn thể công nhân kỹ sư xây dựng công trình, tuyến đường sắt cao tốc kết nối hai khu kinh tế trọng điểm này đã thông xe toàn tuyến trước hai tháng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [提醒] (tíxǐng) - nhắc nhở [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '提醒' AND pinyin = 'tíxǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '提醒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tíxǐng',
      meaning_vi = 'nhắc nhở',
      example_hanzi = '出门前妈妈总是温和地提醒我要带好钥匙和雨伞。',
      example_pinyin = 'Chūmén qián māma zǒngshì wēnhé de tíxǐng wǒ yào dài hǎo yàoshi hé yǔsǎn.',
      example_vi = 'Trước khi ra khỏi cửa, mẹ luôn nhẹ nhàng nhắc nhở tôi phải mang theo chìa khóa và ô.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出门前妈妈总是温和地提醒我要带好钥匙和雨伞。', 'Chūmén qián māma zǒngshì wēnhé de tíxǐng wǒ yào dài hǎo yàoshi hé yǔsǎn.', 'Trước khi ra khỏi cửa, mẹ luôn nhẹ nhàng nhắc nhở tôi phải mang theo chìa khóa và ô.', 'basic', 1),
        (v_id, '交通安全管理部门通过短信与公路大屏实时发布大雾黄色预警，提醒过往司机谨慎慢行保持安全车距。', 'Jiāotōng ānquán guǎnlǐ bùmén tōngguò duǎnxìn yǔ gōnglù dàpíng shíshí fābù dàwù huángsè yùjǐng, tíxǐng guòwǎng sījī jǐnshèn mànxíng bǎochí ānquán chējù.', 'Cơ quan quản lý an toàn giao thông thông qua tin nhắn và màn hình lớn đường cao tốc đã phát cảnh báo sương mù vàng theo thời gian thực, nhắc nhở các tài xế qua lại cẩn trọng đi chậm và giữ khoảng cách xe an toàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [体检] (tǐjiǎn) - khám sức khỏe, kiểm tra thể chất [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '体检' AND pinyin = 'tǐjiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '体检'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'tǐjiǎn',
      meaning_vi = 'khám sức khỏe, kiểm tra thể chất',
      example_hanzi = '公司每年春天都会组织全体员工到指定三甲医院进行一次全面的健康体检。',
      example_pinyin = 'Gōngsī měi nián chūntiān dōu huì zǔzhī quántǐ yuángōng dào zhǐdìng sānjiǎ yīyuàn jìnxíng yí cì quánmiàn de jiànkāng tǐjiǎn.',
      example_vi = 'Công ty mỗi độ xuân về đều tổ chức cho toàn thể nhân viên tới bệnh viện hạng A được chỉ định để khám sức khỏe toàn diện một lần.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '公司每年春天都会组织全体员工到指定三甲医院进行一次全面的健康体检。', 'Gōngsī měi nián chūntiān dōu huì zǔzhī quántǐ yuángōng dào zhǐdìng sānjiǎ yīyuàn jìnxíng yí cì quánmiàn de jiànkāng tǐjiǎn.', 'Công ty mỗi độ xuân về đều tổ chức cho toàn thể nhân viên tới bệnh viện hạng A được chỉ định để khám sức khỏe toàn diện một lần.', 'basic', 1),
        (v_id, '医学专家呼吁中年以上群体必须重视早期防癌筛查体检，做到疾病早预防、早发现、早治疗。', 'Yīxué zhuānjiā hūyù zhōngnián yǐshàng qúntǐ bìxū zhòngshì zǎoqī fáng’ái shāichá tǐjiǎn, zuòdào jíbìng zǎo yùfáng, zǎo fāxiàn, zǎo zhìliáo.', 'Các chuyên gia y học kêu gọi nhóm đối tượng từ trung niên trở lên bắt buộc phải coi trọng việc khám sức khỏe sàng lọc tầm soát ung thư sớm, đạt được mục tiêu bệnh tật phòng ngừa sớm, phát hiện sớm và điều trị sớm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [体温] (tǐwēn) - thân nhiệt, nhiệt độ cơ thể [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '体温' AND pinyin = 'tǐwēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '体温'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tǐwēn',
      meaning_vi = 'thân nhiệt, nhiệt độ cơ thể',
      example_hanzi = '孩子感觉身体发烫，护士马上拿来电子体温计为他测量体温。',
      example_pinyin = 'Háizi gǎnjué shēntǐ fātàng, hùshi mǎshàng ná lái diànzǐ tǐwēnjì wèi tā cèliáng tǐwēn.',
      example_vi = 'Đứa trẻ cảm thấy người nóng ran, y tá lập tức lấy nhiệt kế điện tử đo thân nhiệt cho bé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '孩子感觉身体发烫，护士马上拿来电子体温计为他测量体温。', 'Háizi gǎnjué shēntǐ fātàng, hùshi mǎshàng ná lái diànzǐ tǐwēnjì wèi tā cèliáng tǐwēn.', 'Đứa trẻ cảm thấy người nóng ran, y tá lập tức lấy nhiệt kế điện tử đo thân nhiệt cho bé.', 'basic', 1),
        (v_id, '患者在重症监护期间，智能生命体征监测仪会全天候连续记录其体温、心率及血压的动态波动曲线。', 'Huànzhě zài zhòngzhèng jiānhù qījiān, zhìnéng shēngmìng tǐzhēng jiāncèyí huì quántiānhòu liánxù jìlù qí tǐwēn, xīnlǜ jí xuèyā de dòngtài bōdòng qūxiàn.', 'Trong thời gian bệnh nhân được chăm sóc đặc biệt, máy theo dõi dấu hiệu sinh tồn thông minh sẽ ghi chép liên tục 24/24 đường cong biến động thân nhiệt, nhịp tim và huyết áp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [体重] (tǐzhòng) - thể trọng, cân nặng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '体重' AND pinyin = 'tǐzhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '体重'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tǐzhòng',
      meaning_vi = 'thể trọng, cân nặng',
      example_hanzi = '他通过坚持科学慢跑和清淡饮食，三个月内成功减掉了五公斤体重。',
      example_pinyin = 'Tā tōngguò jiānchí kēxué mànpǎo hé qīngdàn yǐnshí, sān gè yuè nèi chénggōng jiǎndiào le wǔ gōngjīn tǐzhòng.',
      example_vi = 'Anh ấy nhờ kiên trì chạy chậm khoa học và ăn uống thanh đạm, trong vòng ba tháng đã giảm thành công năm cân thể trọng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他通过坚持科学慢跑和清淡饮食，三个月内成功减掉了五公斤体重。', 'Tā tōngguò jiānchí kēxué mànpǎo hé qīngdàn yǐnshí, sān gè yuè nèi chénggōng jiǎndiào le wǔ gōngjīn tǐzhòng.', 'Anh ấy nhờ kiên trì chạy chậm khoa học và ăn uống thanh đạm, trong vòng ba tháng đã giảm thành công năm cân thể trọng.', 'basic', 1),
        (v_id, '公共卫生调查报告显示，青少年肥胖率上升已成为影响健康素质的突出问题，合理控制体重迫在眉睫。', 'Gōnggòng wèishēng diàochá bàogào xiǎnshì, qīngshàonián féipànglǜ shàngshēng yǐ chéngwéi yǐngxiǎng jiànkāng sùzhì de tūchū wèntí, hélǐ kòngzhì tǐzhòng pòzàiméijié.', 'Báo cáo điều tra y tế công cộng chỉ ra rằng tỷ lệ béo phì ở thanh thiếu niên gia tăng đã trở thành vấn đề nổi cộm ảnh hưởng đến tố chất sức khỏe, việc kiểm soát cân nặng hợp lý đang vô cùng cấp bách.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [填写] (tiánxiě) - điền vào, viết vào đơn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '填写' AND pinyin = 'tiánxiě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '填写'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tiánxiě',
      meaning_vi = 'điền vào, viết vào đơn',
      example_hanzi = '到银行办理开户业务时，请在柜台工作人员的指导下认真填写申请表。',
      example_pinyin = 'Dào yínháng bànlǐ kāihù yèwù shí, qǐng zài guìtái gōngzuò rényuán de zhǐdǎo xià rènzhēn tiánxiě shēnqǐngbiǎo.',
      example_vi = 'Khi tới ngân hàng làm thủ tục mở tài khoản, xin vui lòng điền kỹ vào đơn đăng ký dưới sự hướng dẫn của nhân viên quầy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '到银行办理开户业务时，请在柜台工作人员的指导下认真填写申请表。', 'Dào yínháng bànlǐ kāihù yèwù shí, qǐng zài guìtái gōngzuò rényuán de zhǐdǎo xià rènzhēn tiánxiě shēnqǐngbiǎo.', 'Khi tới ngân hàng làm thủ tục mở tài khoản, xin vui lòng điền kỹ vào đơn đăng ký dưới sự hướng dẫn của nhân viên quầy.', 'basic', 1),
        (v_id, '考生在网上填报高考志愿时，必须确保个人基础信息与专业代码填写准确无误，避免因失误影响录取。', 'Kǎoshēng zài wǎngshang tiánbào gāokǎo zhìyuàn shí, bìxū quèbǎo gèrén jīchǔ xìnxī yǔ zhuānyè dàimǎ tiánxiě zhǔnquè-wúwù, bìmiǎn yīn shīwù yǐngxiǎng lùqǔ.', 'Thí sinh khi điền nguyện vọng thi đại học trên mạng bắt buộc phải bảo đảm thông tin cơ bản cá nhân và mã chuyên ngành được điền chính xác tuyệt đối không sai sót, tránh vì sơ suất làm ảnh hưởng việc trúng tuyển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [条件] (tiáojiàn) - điều kiện, tiêu chuẩn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '条件' AND pinyin = 'tiáojiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '条件'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tiáojiàn',
      meaning_vi = 'điều kiện, tiêu chuẩn',
      example_hanzi = '我们学校图书馆的环境优雅安静，为同学们自主学习创造了极好的条件。',
      example_pinyin = 'Wǒmen xuéxiào túshūguǎn de huánjìng yōuyǎ ānjìng, wèi tóngxuémen zìzhǔ xuéxí chuàngzào le jí hǎo de tiáojiàn.',
      example_vi = 'Môi trường thư viện trường chúng tôi tao nhã yên tĩnh, đã tạo ra điều kiện cực kỳ tốt cho các bạn học sinh tự chủ học tập.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们学校图书馆的环境优雅安静，为同学们自主学习创造了极好的条件。', 'Wǒmen xuéxiào túshūguǎn de huánjìng yōuyǎ ānjìng, wèi tóngxuémen zìzhǔ xuéxí chuàngzào le jí hǎo de tiáojiàn.', 'Môi trường thư viện trường chúng tôi tao nhã yên tĩnh, đã tạo ra điều kiện cực kỳ tốt cho các bạn học sinh tự chủ học tập.', 'basic', 1),
        (v_id, '国家积极出台税费减免与融资便利等多项优惠政策，为广大民营企业健康长远发展营造公平透明的营商条件。', 'Guójiā jījí chūtái shuìfèi jiǎnmiǎn yǔ róngzī biànlì děng duō xiàng yōuhuì zhèngcè, wèi guǎngdà mínyíng qǐyè jiànkāng chángyuǎn fāzhǎn yíngzào gōngpíng tòumíng de yíngshāng tiáojiàn.', 'Nhà nước tích cực ban hành nhiều chính sách ưu đãi như miễn giảm thuế phí và thuận tiện hóa gọi vốn, tạo dựng điều kiện môi trường kinh doanh công bằng minh bạch cho sự phát triển lành mạnh lâu dài của các doanh nghiệp tư nhân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [听力] (tīnglì) - thính lực, khả năng nghe, phần thi nghe [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '听力' AND pinyin = 'tīnglì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '听力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tīnglì',
      meaning_vi = 'thính lực, khả năng nghe, phần thi nghe',
      example_hanzi = '每天坚持收听十五分钟中文新闻广播，能有效提高汉语听力水平。',
      example_pinyin = 'Měi tiān jiānchí shōutīng shíwǔ fēnzhōng Zhōngwén xīnwén guǎngbō, néng yǒuxiào tígāo Hànyǔ tīnglì shuǐpíng.',
      example_vi = 'Mỗi ngày kiên trì nghe đài tin tức tiếng Trung mười lăm phút có thể nâng cao trình độ khả năng nghe tiếng Hán hiệu quả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天坚持收听十五分钟中文新闻广播，能有效提高汉语听力水平。', 'Měi tiān jiānchí shōutīng shíwǔ fēnzhōng Zhōngwén xīnwén guǎngbō, néng yǒuxiào tígāo Hànyǔ tīnglì shuǐpíng.', 'Mỗi ngày kiên trì nghe đài tin tức tiếng Trung mười lăm phút có thể nâng cao trình độ khả năng nghe tiếng Hán hiệu quả.', 'basic', 1),
        (v_id, '在汉语水平考试（HSK）中，听力理解部分重点考察考生在真实交际语境中抓取核心关键信息并进行逻辑推理的综合能力。', 'Zài Hànyǔ Shuǐpíng Kǎoshì (HSK) zhōng, tīnglì lǐjiě bùfen zhòngdiǎn kǎochá kǎoshēng zài zhēnshí jiāojì yǔjìng zhōng zhuāqǔ héxīn guānjiàn xìnxī bìng jìnxíng luóji tuīlǐ de zōnghé nénglì.', 'Trong kỳ thi năng lực Hán ngữ HSK, phần thi đọc hiểu nghe hiểu tập trung khảo sát năng lực tổng hợp của thí sinh trong việc nắm bắt thông tin cốt lõi then chốt và suy luận logic trong ngữ cảnh giao tiếp chân thực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [听众] (tīngzhòng) - thính giả, người nghe [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '听众' AND pinyin = 'tīngzhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '听众'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tīngzhòng',
      meaning_vi = 'thính giả, người nghe',
      example_hanzi = '著名作家在学术讲座结束时，热情回答了在场年轻听众提出的许多精彩问题。',
      example_pinyin = 'Zhùmíng zuòjiā zài xuéshù jiǎngzuò jiéshù shí, rèqíng huídá le zàichǎng niánqīng tīngzhòng tíchū de xǔduō jīngcǎi wèntí.',
      example_vi = 'Nhà văn nổi tiếng vào lúc kết thúc buổi thuyết trình học thuật đã nhiệt tình giải đáp nhiều câu hỏi đặc sắc do thính giả trẻ tuổi có mặt đặt ra.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '著名作家在学术讲座结束时，热情回答了在场年轻听众提出的许多精彩问题。', 'Zhùmíng zuòjiā zài xuéshù jiǎngzuò jiéshù shí, rèqíng huídá le zàichǎng niánqīng tīngzhòng tíchū de xǔduō jīngcǎi wèntí.', 'Nhà văn nổi tiếng vào lúc kết thúc buổi thuyết trình học thuật đã nhiệt tình giải đáp nhiều câu hỏi đặc sắc do thính giả trẻ tuổi có mặt đặt ra.', 'basic', 1),
        (v_id, '广播电台经典音乐频道开播二十周年特别节目反响热烈，数百万忠实听众通过网络互动平台发来真挚祝福。', 'Guǎngbō diàntái jīngdiǎn yīnyuè píndào kāibō èrshí zhōunián tèbié jiémù fǎnxiǎng rèliè, shù bǎi wàn zhōngshí tīngzhòng tōngguò wǎngluò hùdòng píngtái fā lái zhēnzhì zhùfú.', 'Chương trình đặc biệt kỷ niệm hai mươi năm phát sóng của kênh âm nhạc kinh điển đài phát thanh đã tạo tiếng vang nồng nhiệt, hàng triệu thính giả trung thành thông qua nền tảng tương tác mạng đã gửi tới những lời chúc chân thành.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [停] (tíng) - dừng, ngừng, đỗ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '停' AND pinyin = 'tíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '停'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tíng',
      meaning_vi = 'dừng, ngừng, đỗ',
      example_hanzi = '外面的雨渐渐停了，天边露出了美丽的七色彩虹。',
      example_pinyin = 'Wàimiàn de yǔ jiànjiàn tíng le, tiānbiān lùchū le měilì de qīsè cǎihóng.',
      example_vi = 'Cơn mưa bên ngoài dần dần tạnh dừng rồi, chân trời lộ ra chiếc cầu vồng bảy sắc tuyệt đẹp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '外面的雨渐渐停了，天边露出了美丽的七色彩虹。', 'Wàimiàn de yǔ jiànjiàn tíng le, tiānbiān lùchū le měilì de qīsè cǎihóng.', 'Cơn mưa bên ngoài dần dần tạnh dừng rồi, chân trời lộ ra chiếc cầu vồng bảy sắc tuyệt đẹp.', 'basic', 1),
        (v_id, '遇到突发紧急故障时，操作员必须立即按下红色紧急停机按钮，使整条高速流水生产线瞬间安全停止运行。', 'Yùdào tūfā jǐnjí gùzhàng shí, cāozuòyuán bìxū lìjí àn xià hóngsè jǐnjí tíngjī ànniǔ, shǐ zhěng tiáo gāosù liúshuǐ shēngchǎnxiàn shùnjiān ānquán tíngzhǐ yùnxíng.', 'Khi gặp sự cố khẩn cấp đột xuất, nhân viên vận hành bắt buộc phải lập tức ấn nút dừng máy khẩn cấp màu đỏ, khiến toàn bộ dây chuyền sản xuất tốc độ cao dừng vận hành an toàn trong chớp mắt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [停车] (tíngchē) - đỗ xe, dừng xe [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '停车' AND pinyin = 'tíngchē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '停车'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tíngchē',
      meaning_vi = 'đỗ xe, dừng xe',
      example_hanzi = '市中心商业街路面狭窄，路边设立了明显的“严禁停车”警示标志。',
      example_pinyin = 'Shì zhōngxīn shāngyèjiē lùmiàn xiázhǎi, lùbiān shèlì le míngxiǎn de “yánjìn tíngchē” jǐngshì biāozhì.',
      example_vi = 'Mặt đường phố thương mại trung tâm thành phố rất chật hẹp, ven đường dựng biển cảnh báo rõ rệt "nghiêm cấm đỗ xe".'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '市中心商业街路面狭窄，路边设立了明显的“严禁停车”警示标志。', 'Shì zhōngxīn shāngyèjiē lùmiàn xiázhǎi, lùbiān shèlì le míngxiǎn de “yánjìn tíngchē” jǐngshì biāozhì.', 'Mặt đường phố thương mại trung tâm thành phố rất chật hẹp, ven đường dựng biển cảnh báo rõ rệt "nghiêm cấm đỗ xe".', 'basic', 1),
        (v_id, '城市交通治理部门通过大力推广智慧路侧停车诱导系统与共享停车泊位，有效缓解了老旧住宅小区居民停车难的痛点问题。', 'Chéngshì jiāotōng zhìlǐ bùmén tōngguò dàlì tuīguǎng zhìhuì lùcè tíngchē yòudǎo xìtǒng yǔ gòngxiǎng tíngchē bówèi, yǒuxiào huǎnjiě le lǎojiù zhùzhái xiǎoqū jūmín tíngchē nán de tòngdiǎn wèntí.', 'Cơ quan quản lý giao thông đô thị thông qua việc đẩy mạnh nhân rộng hệ thống dẫn đường đỗ xe thông minh ven đường và các vị trí đỗ xe dùng chung, đã giải tỏa hữu hiệu điểm nghẽn khó khăn khi đỗ xe của cư dân các khu tập thể chung cư cũ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [停车场] (tíngchēchǎng) - bãi đỗ xe [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '停车场' AND pinyin = 'tíngchēchǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '停车场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tíngchēchǎng',
      meaning_vi = 'bãi đỗ xe',
      example_hanzi = '大型购物中心地下设有三层智能立体停车场，车位非常充足。',
      example_pinyin = 'Dàxíng gòuwù zhōngxīn dìxià shèyǒu sān céng zhìnéng lìtǐ tíngchēchǎng, chēwèi fēicháng chōngzú.',
      example_vi = 'Dưới tầng hầm của trung tâm mua sắm lớn có bãi đỗ xe lập thể thông minh ba tầng, chỗ đậu xe vô cùng dồi dào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大型购物中心地下设有三层智能立体停车场，车位非常充足。', 'Dàxíng gòuwù zhōngxīn dìxià shèyǒu sān céng zhìnéng lìtǐ tíngchēchǎng, chēwèi fēicháng chōngzú.', 'Dưới tầng hầm của trung tâm mua sắm lớn có bãi đỗ xe lập thể thông minh ba tầng, chỗ đậu xe vô cùng dồi dào.', 'basic', 1),
        (v_id, '现代化综合交通枢纽在规划设计时，将大型智能停车场、轨道交通站点与地面公交站台实现了无缝立体换乘对接。', 'Xiàndàihuà zōnghé jiāotōng shūniǔ zài guīhuà shèjì shí, jiāng dàxíng zhìnéng tíngchēchǎng, guǐdào jiāotōng zhàndiǎn yǔ dǐmiàn gōngjiāo zhàntái shíxiàn le wúfèng lìtǐ huànchéng duìjiē.', 'Đầu mối giao thông tổng hợp hiện đại hóa khi quy hoạch thiết kế đã thực hiện việc kết nối chuyển tuyến lập thể không khoảng cách giữa bãi đỗ xe thông minh cỡ lớn, ga đường sắt đô thị và trạm xe buýt mặt đất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [停止] (tíngzhǐ) - ngừng lại, đình chỉ, dừng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '停止' AND pinyin = 'tíngzhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '停止'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tíngzhǐ',
      meaning_vi = 'ngừng lại, đình chỉ, dừng',
      example_hanzi = '随着裁判终场哨声响起，双方激烈拼抢的足球比赛正式停止。',
      example_pinyin = 'Suízhe cáipàn zhōngchǎng shàoshēng xiǎngqǐ, shuāngfāng jīliè pīnqiǎng de zúqiú bǐsài zhèngshì tíngzhǐ.',
      example_vi = 'Cùng với tiếng còi kết thúc trận đấu của trọng tài vang lên, trận thi đấu bóng đá tranh chấp quyết liệt giữa hai bên chính thức dừng lại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着裁判终场哨声响起，双方激烈拼抢的足球比赛正式停止。', 'Suízhe cáipàn zhōngchǎng shàoshēng xiǎngqǐ, shuāngfāng jīliè pīnqiǎng de zúqiú bǐsài zhèngshì tíngzhǐ.', 'Cùng với tiếng còi kết thúc trận đấu của trọng tài vang lên, trận thi đấu bóng đá tranh chấp quyết liệt giữa hai bên chính thức dừng lại.', 'basic', 1),
        (v_id, '为切实保护长江流域生物多样性，沿江省市全面依法实行了为期十年的常年禁捕，停止一切生产性捕捞作业。', 'Wèi qièshí bǎohù Cháng Jiāng liùyù shēngwù duōyàngxìng, yán jiāng shěng-shì quánmiàn yīfǎ shíxíng le wéiqī shí nián de chángnián jìnbǔ, tíngzhǐ yíqiè shēngchǎnxìng bǔlāo zuòyè.', 'Nhằm thiết thực bảo vệ tính đa dạng sinh học lưu vực sông Trường Giang, các tỉnh thành ven sông đã thực thi toàn diện theo pháp luật việc cấm đánh bắt quanh năm kéo dài mười năm, đình chỉ mọi hoạt động đánh bắt mang tính sản xuất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [通] (tōng) - thông suốt, thông qua; thấu hiểu, thông thạo [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '通' AND pinyin = 'tōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '通'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'tōng',
      meaning_vi = 'thông suốt, thông qua; thấu hiểu, thông thạo',
      example_hanzi = '经过维修工人的连夜疏通，洗手间堵塞的下水管道终于彻底通了。',
      example_pinyin = 'Jīngguò wéixiū gōngrén de liányè shūtōng, xǐshǒujiān dǔsè de xiàshuǐ guǎndào zhōngyú chèdǐ tōng le.',
      example_vi = 'Qua sự thông tắc xuyên đêm của các bác thợ sửa chữa, đường ống thoát nước bị tắc của phòng vệ sinh cuối cùng đã thông suốt hoàn toàn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过维修工人的连夜疏通，洗手间堵塞的下水管道终于彻底通了。', 'Jīngguò wéixiū gōngrén de liányè shūtōng, xǐshǒujiān dǔsè de xiàshuǐ guǎndào zhōngyú chèdǐ tōng le.', 'Qua sự thông tắc xuyên đêm của các bác thợ sửa chữa, đường ống thoát nước bị tắc của phòng vệ sinh cuối cùng đã thông suốt hoàn toàn.', 'basic', 1),
        (v_id, '这位博古通今的资深外交官不仅精通多国语言，更能熟练运用跨文化沟通艺术化解国际多边纷争。', 'Zhè wèi bógǔ-tōngjīn de zīshēn wàijiāoguān bùjǐn jīngtōng duō guó yǔyán, gèng néng shúliàn yùnyòng kuà wénhuà gōutōng yìshù huàjiě guójì duōbiān fēnzhēng.', 'Vị nhà ngoại giao kỳ cựu uyên bác thấu hiểu xưa nay này không chỉ thông thạo nhiều thứ tiếng, mà càng có thể vận dụng điêu luyện nghệ thuật giao tiếp xuyên văn hóa để hóa giải những tranh chấp đa phương quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [通过] (tōngguò) - thông qua, vượt qua; qua (con đường) [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '通过' AND pinyin = 'tōngguò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '通过'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Giới từ',
      pinyin = 'tōngguò',
      meaning_vi = 'thông qua, vượt qua; qua (con đường)',
      example_hanzi = '经过三个月的辛勤复习，他终于顺利通过了高级职业技能资格考试。',
      example_pinyin = 'Jīngguò sān gè yuè de xīnqín fùxí, tā zhōngyú shùnlì tōngguò le gāojí zhíyè jìnéng zīgé kǎoshì.',
      example_vi = 'Trải qua ba tháng chăm chỉ ôn tập, anh ấy cuối cùng đã thuận lợi vượt qua kỳ thi chứng chỉ kỹ năng nghề nghiệp cao cấp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过三个月的辛勤复习，他终于顺利通过了高级职业技能资格考试。', 'Jīngguò sān gè yuè de xīnqín fùxí, tā zhōngyú shùnlì tōngguò le gāojí zhíyè jìnéng zīgé kǎoshì.', 'Trải qua ba tháng chăm chỉ ôn tập, anh ấy cuối cùng đã thuận lợi vượt qua kỳ thi chứng chỉ kỹ năng nghề nghiệp cao cấp.', 'basic', 1),
        (v_id, '全国人大常委会全体会议全票表决通过了新的生态环境保护法修正案，为绿色可持续发展提供了坚实的法治保障。', 'Quánguó Réndà Chángwěihuì quántǐ huìyì quánpiào biǎojué tōngguò le xīn de shēngtài huánjìng bǎohù fǎ xiūzhèng’àn, wèi lǜsè kěchíxù fāzhǎn tígōng le jiānshí de fǎzhì bǎozhàng.', 'Hội nghị toàn thể Ủy ban Thường vụ Đại hội Đại biểu Nhân dân Toàn quốc đã bỏ phiếu toàn thể thông qua dự thảo sửa đổi Luật Bảo vệ Môi trường Sinh thái mới, mang lại sự bảo đảm pháp quyền vững chắc cho phát triển xanh bền vững.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [通知] (tōngzhī) - thông báo, báo tin; bản thông báo [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '通知' AND pinyin = 'tōngzhī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '通知'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'tōngzhī',
      meaning_vi = 'thông báo, báo tin; bản thông báo',
      example_hanzi = '辅导员在班级微信群里发布了一条关于明天上午举行班会的紧急通知。',
      example_pinyin = 'Fǔdǎoyuán zài bānjí Wēixìn qún lǐ fābù le yì tiáo guānyú míngtiān shàngwǔ jǔxíng bānhuì de jǐnjí tōngzhī.',
      example_vi = 'Thầy cố vấn học tập đã đăng trong nhóm WeChat của lớp một bản thông báo khẩn về việc tổ chức họp lớp vào sáng mai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '辅导员在班级微信群里发布了一条关于明天上午举行班会的紧急通知。', 'Fǔdǎoyuán zài bānjí Wēixìn qún lǐ fābù le yì tiáo guānyú míngtiān shàngwǔ jǔxíng bānhuì de jǐnjí tōngzhī.', 'Thầy cố vấn học tập đã đăng trong nhóm WeChat của lớp một bản thông báo khẩn về việc tổ chức họp lớp vào sáng mai.', 'basic', 1),
        (v_id, '人事部门正式下发关于优化年度绩效考核与员工岗位晋升机制的通知文件，要求各业务部门认真贯彻落实。', 'Rénshì bùmén zhèngshì xiàfā guānyú yōuhuà niándù jìxiào kǎohé yǔ yuángōng gǎngwèi jìnshēng jīzhì de tōngzhī wénjiàn, yāoqiú gè yèwù bùmén rènzhēn guànchè luòshí.', 'Phòng nhân sự đã chính thức ban hành văn bản thông báo về việc tối ưu hóa cơ chế đánh giá hiệu suất năm và thăng chức vị trí của nhân viên, yêu cầu các phòng ban nghiệp vụ quán triệt thực hiện nghiêm túc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [童年] (tóngnián) - tuổi thơ, thời thơ ấu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '童年' AND pinyin = 'tóngnián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '童年'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tóngnián',
      meaning_vi = 'tuổi thơ, thời thơ ấu',
      example_hanzi = '在乡村奶奶家和小伙伴们捉迷藏、下河捉鱼，是我童年最开心的记忆。',
      example_pinyin = 'Zài xiāngcūn nǎinai jiā hé xiǎo huǒbànmen zhuōmícáng, xià hé zhuō yú, shì wǒ tóngnián zuì kāixīn de jìyì.',
      example_vi = 'Ở nhà bà nội dưới nông thôn cùng các bạn nhỏ chơi trốn tìm, xuống sông bắt cá là ký ức vui vẻ nhất thời thơ ấu của tôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在乡村奶奶家和小伙伴们捉迷藏、下河捉鱼，是我童年最开心的记忆。', 'Zài xiāngcūn nǎinai jiā hé xiǎo huǒbànmen zhuōmícáng, xià hé zhuō yú, shì wǒ tóngnián zuì kāixīn de jìyì.', 'Ở nhà bà nội dưới nông thôn cùng các bạn nhỏ chơi trốn tìm, xuống sông bắt cá là ký ức vui vẻ nhất thời thơ ấu của tôi.', 'basic', 1),
        (v_id, '心理学研究表明，健康温馨的家庭环境与充满关爱的童年经历，对一个人健全人格与心理韧性的形成具有奠基性作用。', 'Xīnlǐxué yánjiū biǎomíng, jiànkāng wēnxīn de jiātíng huánjìng yǔ chōngmǎn guān’ài de tóngnián jīnglì, duì yí gè rén jiànquán réngé yǔ xīnlǐ rènxìng de xíngchéng jùyǒu diànjīxìng zuòyòng.', 'Nghiên cứu tâm lý học chỉ ra rằng môi trường gia đình ấm cúng lành mạnh và trải nghiệm tuổi thơ tràn đầy tình yêu thương giữ vai trò đặt nền móng đối với sự hình thành nhân cách kiện toàn và độ bền bỉ tâm lý của một con người.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [同时] (tóngshí) - đồng thời, cùng lúc [Danh từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '同时' AND pinyin = 'tóngshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '同时'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Liên từ',
      pinyin = 'tóngshí',
      meaning_vi = 'đồng thời, cùng lúc',
      example_hanzi = '他在大学期间努力学好本专业功课，同时还积极参加各种社会公益志愿者活动。',
      example_pinyin = 'Tā zài dàxué qījiān nǔlì xué hǎo běn zhuānyè gōngkè, tóngshí hái jījí cānjiā gèzhǒng shèhuì gōngyì zhìyuànzhě huódòng.',
      example_vi = 'Anh ấy trong thời gian học đại học nỗ lực học tốt bài vở chuyên ngành, đồng thời còn tích cực tham gia các hoạt động tình nguyện viên công ích xã hội.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在大学期间努力学好本专业功课，同时还积极参加各种社会公益志愿者活动。', 'Tā zài dàxué qījiān nǔlì xué hǎo běn zhuānyè gōngkè, tóngshí hái jījí cānjiā gèzhǒng shèhuì gōngyì zhìyuànzhě huódòng.', 'Anh ấy trong thời gian học đại học nỗ lực học tốt bài vở chuyên ngành, đồng thời còn tích cực tham gia các hoạt động tình nguyện viên công ích xã hội.', 'basic', 1),
        (v_id, '我们要在持续做大做强经济蛋糕的同时，更加注重通过制度创新切实分好蛋糕，让发展成果更多更公平地惠及全体人民。', 'Wǒmen yào zài chíxù zuò dà zuò qiáng jīngjì dàngāo de tóngshí, gèngjiā zhùzhòng tōngguò zhìdù chuàngxīn qièshí fēn hǎo dàngāo, ràng fāzhǎn chéngguǒ gèng duō gèng gōngpíng de huìjí quántǐ rénmín.', 'Chúng ta vừa phải làm lớn làm mạnh chiếc bánh kinh tế, đồng thời càng phải chú trọng thông qua đổi mới chế độ để phân chia chiếc bánh thật tốt, khiến thành quả phát triển mang lại lợi ích nhiều hơn và công bằng hơn cho toàn thể nhân dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [同样] (tóngyàng) - cùng loại, tương tự, như nhau [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '同样' AND pinyin = 'tóngyàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '同样'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'tóngyàng',
      meaning_vi = 'cùng loại, tương tự, như nhau',
      example_hanzi = '这两台智能手机虽然品牌不同，但配置了同样强大的处理器。',
      example_pinyin = 'Zhè liǎng tái zhìnéng shǒujī suīrán pǐnpái bùtóng, dàn pèizhì le tóngyàng qiángdà de chǔlǐqì.',
      example_vi = 'Hai chiếc điện thoại thông minh này tuy nhãn hiệu khác nhau, nhưng được trang bị bộ vi xử lý mạnh mẽ tương tự nhau.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这两台智能手机虽然品牌不同，但配置了同样强大的处理器。', 'Zhè liǎng tái zhìnéng shǒujī suīrán pǐnpái bùtóng, dàn pèizhì le tóngyàng qiángdà de chǔlǐqì.', 'Hai chiếc điện thoại thông minh này tuy nhãn hiệu khác nhau, nhưng được trang bị bộ vi xử lý mạnh mẽ tương tự nhau.', 'basic', 1),
        (v_id, '在全球性公共卫生危机面前，没有任何国家能够独善其身，全人类拥有同样不可分割的安全利益与共同命运。', 'Zài quánqiúxìng gōnggòng wèishēng wēijī miànqián, méiyǒu rènhé guójiā nénggòu dúshànqíshēn, quán rénlèi yōngyǒu tóngyàng bùkě fēngē de ānquán lìyì yǔ gòngtóng mìngyùn.', 'Trước cuộc khủng hoảng y tế công cộng mang tính toàn cầu, không một quốc gia nào có thể tự lo cho riêng mình, toàn nhân loại sở hữu lợi ích an ninh và vận mệnh chung không thể chia tách như nhau.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [桶] (tǒng) - thùng, xô [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '桶' AND pinyin = 'tǒng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '桶'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'tǒng',
      meaning_vi = 'thùng, xô',
      example_hanzi = '大扫除的时候，同学们提来两桶清水把教室的地板拖洗得干干净净。',
      example_pinyin = 'Dàsǎochú de shíhou, tóngxuémen tí lái liǎng tǒng qīngshuǐ bǎ jiàoshì de dìbǎn tuō xǐ de gāngānjìngjìng.',
      example_vi = 'Lúc tổng vệ sinh, các bạn học sinh xách tới hai thùng nước sạch lau chùi sàn lớp học sạch bong kin kít.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大扫除的时候，同学们提来两桶清水把教室的地板拖洗得干干净净。', 'Dàsǎochú de shíhou, tóngxuémen tí lái liǎng tǒng qīngshuǐ bǎ jiàoshì de dìbǎn tuō xǐ de gāngānjìngjìng.', 'Lúc tổng vệ sinh, các bạn học sinh xách tới hai thùng nước sạch lau chùi sàn lớp học sạch bong kin kít.', 'basic', 1),
        (v_id, '受地缘政治局势紧张与主要产油国联合减产影响，国际原油期货价格单日暴涨至每桶九十五美元以上。', 'Shòu dìyuán zhèngzhì júshì jǐnzhāng yǔ zhǔyào chǎnyóuguó liánhé jiǎnchǎn yǐngxiǎng, guójì yuányóu qīhuò jiàgé dānrì bàozhǎng zhì měi tǒng jiǔshíwǔ měiyuán yǐshàng.', 'Chịu ảnh hưởng bởi cục diện địa chính trị căng thẳng và các nước sản xuất dầu mỏ chính cùng cắt giảm sản lượng, giá dầu thô tương lai quốc tế trong một ngày đã tăng vọt lên trên chín mươi lăm đô la một thùng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [痛] (tòng) - đau, đau đớn; đau xót [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '痛' AND pinyin = 'tòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '痛'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'tòng',
      meaning_vi = 'đau, đau đớn; đau xót',
      example_hanzi = '踢球时不小心摔了一跤，膝盖擦破了皮，感觉一阵阵隐隐作痛。',
      example_pinyin = 'Tīqiú shí bù xiǎoxīn shuāi le yì jiāo, xīgài cāpò le pí, gǎnjué yízhènzhèn yǐnyǐn-zuòtòng.',
      example_vi = 'Khi đá bóng sơ ý ngã một cái, đầu gối trầy xước da, cảm thấy từng cơn đau râm ran.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '踢球时不小心摔了一跤，膝盖擦破了皮，感觉一阵阵隐隐作痛。', 'Tīqiú shí bù xiǎoxīn shuāi le yì jiāo, xīgài cāpò le pí, gǎnjué yízhènzhèn yǐnyǐn-zuòtòng.', 'Khi đá bóng sơ ý ngã một cái, đầu gối trầy xước da, cảm thấy từng cơn đau râm ran.', 'basic', 1),
        (v_id, '面对重大突发安全事故暴露出的管理漏洞，相关责任部门痛定思痛，迅速启动全行业安全隐患铁腕排查整治。', 'Miànduì zhòngdà tūfā ānquán shìgù bàolù chū de guǎnlǐ lòudòng, xiāngguān zérèn bùmén tòngdìng-sītòng, xùnsù qǐdòng quán hángyè ānquán yǐnhuàn tiěwàn páichá zhěngzhì.', 'Trước những lỗ hổng quản lý bị phơi bày từ sự cố an toàn đột phát nghiêm trọng, các cơ quan ban ngành chịu trách nhiệm liên quan đã đau đớn ngẫm lại nỗi đau, nhanh chóng khởi động đợt rà soát chấn chỉnh các mối nguy an toàn bằng bàn tay sắt trên toàn ngành.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [头痛] (tóutòng) - đau đầu, nhức đầu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '头痛' AND pinyin = 'tóutòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '头痛'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'tóutòng',
      meaning_vi = 'đau đầu, nhức đầu',
      example_hanzi = '他因为昨晚着凉感冒，今天一整天都感到有些头痛乏力。',
      example_pinyin = 'Tā yīnwèi zuówǎn zháoliáng gǎnmào, jīntiān yì zhěng tiān dōu gǎndào yǒuxiē tóutòng fálì.',
      example_vi = 'Cậu ấy vì tối qua bị nhiễm lạnh cảm mạo nên hôm nay cả ngày đều cảm thấy hơi đau đầu mệt mỏi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他因为昨晚着凉感冒，今天一整天都感到有些头痛乏力。', 'Tā yīnwèi zuówǎn zháoliáng gǎnmào, jīntiān yì zhěng tiān dōu gǎndào yǒuxiē tóutòng fálì.', 'Cậu ấy vì tối qua bị nhiễm lạnh cảm mạo nên hôm nay cả ngày đều cảm thấy hơi đau đầu mệt mỏi.', 'basic', 1),
        (v_id, '如何有效平衡老旧工业区产业转型升级与周边生态环境保护，是令许多地方政府深感头痛的复杂治理课题。', 'Rúhé yǒuxiào pínghéng lǎojiù gōngyèqū chǎnyè zhuǎnxíng shēngjí yǔ zhōubiān shēngtài huánjìng bǎohù, shì lìng xǔduō dìfāng zhèngfǔ shēngǎn tóutòng de fùzá zhìlǐ kètí.', 'Làm thế nào để cân bằng hiệu quả giữa chuyển đổi nâng cấp ngành nghề khu công nghiệp cũ và bảo vệ môi trường sinh thái xung quanh là đề tài quản trị phức tạp khiến nhiều chính quyền địa phương vô cùng đau đầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [图] (tú) - tranh, bản đồ, hình vẽ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '图' AND pinyin = 'tú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '图'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tú',
      meaning_vi = 'tranh, bản đồ, hình vẽ',
      example_hanzi = '公园入口处的展板上画着一张清晰详尽的游览路线示意图。',
      example_pinyin = 'Gōngyuán rùkǒuchù de zhǎnbǎn shang huàzhe yì zhāng qīngxī xiángjìn de yóulǎn lùxiàn shìyìtú.',
      example_vi = 'Trên bảng triển lãm tại lối vào công viên có vẽ một sơ đồ tuyến đường tham quan rõ ràng và tỉ mỉ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '公园入口处的展板上画着一张清晰详尽的游览路线示意图。', 'Gōngyuán rùkǒuchù de zhǎnbǎn shang huàzhe yì zhāng qīngxī xiángjìn de yóulǎn lùxiàn shìyìtú.', 'Trên bảng triển lãm tại lối vào công viên có vẽ một sơ đồ tuyến đường tham quan rõ ràng và tỉ mỉ.', 'basic', 1),
        (v_id, '工程设计师正在对照三维建筑结构施工图，对核心承重构件的应力受载情况进行精确数值模拟。', 'Gōngchéng shèjìshī zhèngzài duìzhào sānwéi jiànzhù jiégòu shīgōngtú, duì héxīn chéngzhòng gòujiàn de yīnglì shòuzài qíngkuàng jìnxíng jīngquè shùzhí mónǐ.', 'Kỹ sư thiết kế công trình đang đối chiếu bản vẽ thi công kết cấu kiến trúc 3D, tiến hành mô phỏng số liệu chính xác tình hình chịu tải ứng suất của các cấu kiện chịu lực cốt lõi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [图片] (túpiàn) - hình ảnh, bức tranh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '图片' AND pinyin = 'túpiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '图片'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'túpiàn',
      meaning_vi = 'hình ảnh, bức tranh',
      example_hanzi = '他在社交平台上分享了许多在黄山旅游时拍摄的高清风景图片。',
      example_pinyin = 'Tā zài shèjiāo píngtái shang fēnxiǎng le xǔduō zài Huángshān lǚyóu shí pāishè de gāoqīng fēngjǐng túpiàn.',
      example_vi = 'Anh ấy chia sẻ trên nền tảng mạng xã hội rất nhiều hình ảnh phong cảnh độ nét cao chụp lúc đi du lịch Hoàng Sơn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在社交平台上分享了许多在黄山旅游时拍摄的高清风景图片。', 'Tā zài shèjiāo píngtái shang fēnxiǎng le xǔduō zài Huángshān lǚyóu shí pāishè de gāoqīng fēngjǐng túpiàn.', 'Anh ấy chia sẻ trên nền tảng mạng xã hội rất nhiều hình ảnh phong cảnh độ nét cao chụp lúc đi du lịch Hoàng Sơn.', 'basic', 1),
        (v_id, '本次国家地理摄影大展通过近千幅极具视觉震撼力的高清图片，全景生动呈现了全球濒危珍稀野生动物的生存现状。', 'Běn cì guójiā dìlǐ shèyǐng dàzhǎn tōngguò jìn qiān fú jí jù shìjué zhènhànlì de gāoqīng túpiàn, quánjǐng shēngdòng chéngxiàn le quánqiú bīnwēi zhēnxī yěshēng dòngwù de shēngcún xiànzhuàng.', 'Triển lãm nhiếp ảnh địa lý quốc gia lần này thông qua gần một ngàn bức hình ảnh độ nét cao đầy sức chấn động thị giác đã tái hiện sinh động toàn cảnh hiện trạng sinh tồn của các loài động vật hoang dã quý hiếm có nguy cơ tuyệt chủng trên toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [土] (tǔ) - đất, thổ nhưỡng; quê mùa [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '土' AND pinyin = 'tǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '土'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'tǔ',
      meaning_vi = 'đất, thổ nhưỡng; quê mùa',
      example_hanzi = '爷爷在院子里翻松了黑土，准备开春播种各种蔬菜种子。',
      example_pinyin = 'Yéye zài yuànzi lǐ fānsōng le hēitǔ, zhǔnbèi kāichūn bōzhǒng gèzhǒng shūcài zhǒngzi.',
      example_vi = 'Ông nội xới tơi đất đen trong sân, chuẩn bị gieo các loại hạt rau khi đầu xuân tới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爷爷在院子里翻松了黑土，准备开春播种各种蔬菜种子。', 'Yéye zài yuànzi lǐ fānsōng le hēitǔ, zhǔnbèi kāichūn bōzhǒng gèzhǒng shūcài zhǒngzi.', 'Ông nội xới tơi đất đen trong sân, chuẩn bị gieo các loại hạt rau khi đầu xuân tới.', 'basic', 1),
        (v_id, '开展农田水土流失综合治理与土壤重金属污染修复，是确保国家耕地红线与粮食安全生产的战略基石。', 'Kāizhǎn nóngtián shuǐ-tǔ liúshī zōnghé zhìlǐ yǔ tǔrǎng zhòngjīnshǔ wūrǎn xiūfù, shì quèbǎo guójiā gēngdì hóngxiàn yǔ liángshi ānquán shēngchǎn de zhànlüè jīshí.', 'Triển khai xử lý tổng hợp xói mòn đất nước nông điền và phục hồi ô nhiễm kim loại nặng trong đất là nền tảng chiến lược để bảo đảm ranh giới đỏ đất canh tác và sản xuất an ninh lương thực quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [推] (tuī) - đẩy; suy ra, thúc đẩy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '推' AND pinyin = 'tuī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '推'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tuī',
      meaning_vi = 'đẩy; suy ra, thúc đẩy',
      example_hanzi = '超市玻璃门上贴着“请向前推”的温馨提示标语。',
      example_pinyin = 'Chāoshì bōlimén shang tiēzhe “qǐng xiàng qián tuī” de wēnxīn tíshì biāoyǔ.',
      example_vi = 'Trên cửa kính siêu thị có dán khẩu hiệu nhắc nhở ấm áp "xin hãy đẩy về phía trước".'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '超市玻璃门上贴着“请向前推”的温馨提示标语。', 'Chāoshì bōlimén shang tiēzhe “qǐng xiàng qián tuī” de wēnxīn tíshì biāoyǔ.', 'Trên cửa kính siêu thị có dán khẩu hiệu nhắc nhở ấm áp "xin hãy đẩy về phía trước".', 'basic', 1),
        (v_id, '高校与科研院所大力推行科技成果所有权与长期使用权改革，极大激发了科研骨干投身科技创新的内生动力。', 'Gāoxiào yǔ kēyán yuànsuǒ dàlì tuīxíng kējì chéngguǒ suǒyǒuquán yǔ chángqī shǐyòngquán gǎigé, jídà jīfā le kēyán gǔgàn tóushēn kējì chuàngxīn de nèishēng dònglì.', 'Các trường đại học và viện nghiên cứu dốc sức đẩy mạnh cải cách quyền sở hữu và quyền sử dụng dài hạn thành quả khoa học công nghệ, khơi dậy mạnh mẽ động lực nội tại dấn thân đổi mới công nghệ của các cán bộ nghiên cứu nòng cốt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [推迟] (tuīchí) - hoãn lại, lùi lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '推迟' AND pinyin = 'tuīchí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '推迟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tuīchí',
      meaning_vi = 'hoãn lại, lùi lại',
      example_hanzi = '由于突然降大雨，原定今天下午举行的校园运动会被迫推迟到下周五。',
      example_pinyin = 'Yóuyú tūrán jiàng dàyǔ, yuándìng jīntiān xiàwǔ jǔxíng de xiàoyuán yùndònghuì bèipò tuīchí dào xià zhōuwǔ.',
      example_vi = 'Do trời đột ngột đổ mưa to, đại hội thể thao học đường dự kiến tổ chức chiều nay buộc phải hoãn lại sang thứ sáu tuần sau.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '由于突然降大雨，原定今天下午举行的校园运动会被迫推迟到下周五。', 'Yóuyú tūrán jiàng dàyǔ, yuándìng jīntiān xiàwǔ jǔxíng de xiàoyuán yùndònghuì bèipò tuīchí dào xià zhōuwǔ.', 'Do trời đột ngột đổ mưa to, đại hội thể thao học đường dự kiến tổ chức chiều nay buộc phải hoãn lại sang thứ sáu tuần sau.', 'basic', 1),
        (v_id, '受极端恶劣风暴天气与航路管制影响，多架国际长途航班不得不临时推迟起飞时间。', 'Shòu jíduān èliè fēngbào tiānqì yǔ hánglù guǎnzhì yǐngxiǎng, duō jià guójì chángtú hángbān bùdébù línshí tuīchí qǐfēi shíjiān.', 'Chịu ảnh hưởng bởi thời tiết giông bão khắc nghiệt và kiểm soát đường bay, nhiều chuyến bay đường dài quốc tế đành phải tạm thời lùi giờ cất cánh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [推出] (tuīchū) - đưa ra, tung ra, ra mắt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '推出' AND pinyin = 'tuīchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '推出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tuīchū',
      meaning_vi = 'đưa ra, tung ra, ra mắt',
      example_hanzi = '这家手机厂商下个月将在北京正式推出搭载最新自研芯片的旗舰智能手机。',
      example_pinyin = 'Zhè jiā shǒujī chǎngshāng xià gè yuè jiāng zài Běijīng zhèngshì tuīchū dāzài zuìxīn zìyán xīnpiàn de qíjiàn zhìnéng shǒujī.',
      example_vi = 'Hãng điện thoại này tháng sau sẽ chính thức ra mắt tại Bắc Kinh chiếc điện thoại thông minh đầu bảng trang bị chip tự nghiên cứu mới nhất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家手机厂商下个月将在北京正式推出搭载最新自研芯片的旗舰智能手机。', 'Zhè jiā shǒujī chǎngshāng xià gè yuè jiāng zài Běijīng zhèngshì tuīchū dāzài zuìxīn zìyán xīnpiàn de qíjiàn zhìnéng shǒujī.', 'Hãng điện thoại này tháng sau sẽ chính thức ra mắt tại Bắc Kinh chiếc điện thoại thông minh đầu bảng trang bị chip tự nghiên cứu mới nhất.', 'basic', 1),
        (v_id, '文旅部会同多个部门联合推出一系列针对入境外国游客的支付便利化与离境退税优化政策，有力促进了入境游消费回暖。', 'Wén-lǚ Bù huìtóng duō gè bùmén liánhé tuīchū yí xìliè zhēnduì rùjìng wàiguó yóukè de zhīfù biànlìhuà yǔ líjìng tuìshuì yōuhuà zhèngcè, yǒulì cùjìn le rùjìngyóu xiāofèi huínuǎn.', 'Bộ Văn hóa và Du lịch phối hợp cùng nhiều ban ngành liên hiệp tung ra một loạt chính sách tối ưu hóa hoàn thuế xuất cảnh và thuận tiện hóa thanh toán dành cho du khách nước ngoài nhập cảnh, thúc đẩy mạnh mẽ sự ấm lại của tiêu dùng du lịch nhập cảnh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [脱] (tuō) - cởi (quần áo, giày), thoát khỏi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '脱' AND pinyin = 'tuō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '脱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tuō',
      meaning_vi = 'cởi (quần áo, giày), thoát khỏi',
      example_hanzi = '进屋后室内暖气很足，他赶紧脱下厚重的羽绒服挂在衣架上。',
      example_pinyin = 'Jìn wū hòu shìnèi nuǎnqì hěn zú, tā gǎnjǐn tuō xià hòuzhòng de yǔróngfú guà zài yījià shang.',
      example_vi = 'Sau khi vào phòng, hệ thống sưởi trong nhà rất ấm áp, anh ấy vội vàng cởi chiếc áo khoác lông vũ dày cộm treo lên móc áo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '进屋后室内暖气很足，他赶紧脱下厚重的羽绒服挂在衣架上。', 'Jìn wū hòu shìnèi nuǎnqì hěn zú, tā gǎnjǐn tuō xià hòuzhòng de yǔróngfú guà zài yījià shang.', 'Sau khi vào phòng, hệ thống sưởi trong nhà rất ấm áp, anh ấy vội vàng cởi chiếc áo khoác lông vũ dày cộm treo lên móc áo.', 'basic', 1),
        (v_id, '通过持续多年的精准扶贫攻坚与特色产业培育，千百万曾经深陷贫困泥潭的山区群众终于彻底脱贫致富。', 'Tōngguò chíxù duō nián de jīngzhǔn fúpín gōngjiān yǔ tèsè chǎnyè péiyù, qiānbǎiwàn céngjīng shēnxiàn pínkùn nítán de shānqū qúnzhòng zhōngyú chèdǐ tuōpín-zhìfù.', 'Thông qua nhiều năm liên tục nỗ lực xóa đói giảm nghèo chuẩn xác và gây dựng ngành nghề đặc sắc, hàng chục triệu người dân miền núi từng lún sâu trong vũng lầy nghèo khó cuối cùng đã thoát nghèo làm giàu hoàn toàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [袜子] (wàzi) - tất, vớ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '袜子' AND pinyin = 'wàzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '袜子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wàzi',
      meaning_vi = 'tất, vớ',
      example_hanzi = '冬天外出跑步时，最好穿一双吸汗且保暖的纯棉运动袜子。',
      example_pinyin = 'Dōngtiān wàichū pǎobù shí, zuìhǎo chuān yì shuāng xīhàn qiě bǎonuǎn de chúnmián yùndòng wàzi.',
      example_vi = 'Mùa đông khi ra ngoài chạy bộ, tốt nhất nên đi một đôi tất thể thao cotton nguyên chất vừa thấm hút mồ hôi lại giữ ấm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '冬天外出跑步时，最好穿一双吸汗且保暖的纯棉运动袜子。', 'Dōngtiān wàichū pǎobù shí, zuìhǎo chuān yì shuāng xīhàn qiě bǎonuǎn de chúnmián yùndòng wàzi.', 'Mùa đông khi ra ngoài chạy bộ, tốt nhất nên đi một đôi tất thể thao cotton nguyên chất vừa thấm hút mồ hôi lại giữ ấm.', 'basic', 1),
        (v_id, '纺织科研团队利用新型石墨烯复合纤维成功研发出具备持久抑菌与智能发热功能的高科技健康功能袜子，深受户外运动爱好者青睐。', 'Fǎngzhī kēyán tuánduì lìyòng xīnxíng shímòxī fùhé xiānwéi chénggōng yánfā chū jùbèi chíjiǔ yìjūn yǔ zhìnéng fārè gōngnéng de gāokējì jiànkāng gōngnéng wàzi, shēn shòu hùwài yùndòng àihàozhě qīnglài.', 'Đội ngũ nghiên cứu dệt may sử dụng sợi composite graphene kiểu mới đã nghiên cứu thành công loại tất tính năng sức khỏe công nghệ cao sở hữu chức năng kháng khuẩn lâu bền và tự phát nhiệt thông minh, được những người yêu thích thể thao ngoài trời vô cùng đón nhận.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [外出] (wàichū) - đi ra ngoài, ra ngoài [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '外出' AND pinyin = 'wàichū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '外出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'wàichū',
      meaning_vi = 'đi ra ngoài, ra ngoài',
      example_hanzi = '周末天气晴朗舒适，许多市民都选择全家外出郊游野餐。',
      example_pinyin = 'Zhōumò tiānqì qínglǎng shūshì, xǔduō shìmín dōu xuǎnzé quán jiā wàichū jiāoyóu yěcān.',
      example_vi = 'Cuối tuần trời quang đãng dễ chịu, rất nhiều người dân đều chọn cùng cả nhà đi ra ngoài dã ngoại cắm trại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末天气晴朗舒适，许多市民都选择全家外出郊游野餐。', 'Zhōumò tiānqì qínglǎng shūshì, xǔduō shìmín dōu xuǎnzé quán jiā wàichū jiāoyóu yěcān.', 'Cuối tuần trời quang đãng dễ chịu, rất nhiều người dân đều chọn cùng cả nhà đi ra ngoài dã ngoại cắm trại.', 'basic', 1),
        (v_id, '国家卫健委提醒老年人及慢性病患者在雾霾重污染天气应尽量减少不必要的外出，若确需外出必须做好科学防护。', 'Guójiā Wèijiànwěi tíxǐng lǎoniánrén jí mànxìngbìng huànzhě zài wùmái zhòng wūrǎn tiānqì yīng jǐnliàng jiǎnshǎo bú bìyào de wàichū, ruò què xū wàichū bìxū zuò hǎo kēxué fánghù.', 'Ủy ban Y tế Sức khỏe Quốc gia nhắc nhở người cao tuổi và bệnh nhân mắc bệnh mãn tính trong những ngày thời tiết ô nhiễm khói bụi nặng nề nên cố gắng giảm thiểu việc đi ra ngoài không cần thiết, nếu quả thực phải ra ngoài thì bắt buộc phải làm tốt phòng hộ khoa học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [外套] (wàitào) - áo khoác ngoài, áo ngoài [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '外套' AND pinyin = 'wàitào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '外套'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wàitào',
      meaning_vi = 'áo khoác ngoài, áo ngoài',
      example_hanzi = '早晚温差比较大，出门前记得在短袖外面套一件薄外套。',
      example_pinyin = 'Zǎo-wǎn wēnchā bǐjiào dà, chūmén qián jìde zài duǎnxiù wàimiàn tào yí jiàn báo wàitào.',
      example_vi = 'Chênh lệch nhiệt độ sớm tối khá lớn, trước khi ra cửa nhớ khoác thêm một chiếc áo khoác mỏng bên ngoài áo cộc tay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '早晚温差比较大，出门前记得在短袖外面套一件薄外套。', 'Zǎo-wǎn wēnchā bǐjiào dà, chūmén qián jìde zài duǎnxiù wàimiàn tào yí jiàn báo wàitào.', 'Chênh lệch nhiệt độ sớm tối khá lớn, trước khi ra cửa nhớ khoác thêm một chiếc áo khoác mỏng bên ngoài áo cộc tay.', 'basic', 1),
        (v_id, '这家高端运动服饰品牌最新推出的防风透气户外冲锋衣外套，凭借出色的防水科技与时尚剪裁赢得了广阔市场。', 'Zhè jiā gāoduān yùndòng fúshì pǐnpái zuìxīn tuīchū de fángfēng-tòuqì hùwài chōngfēngyī wàitào, píngjiè chūsè de fángshuǐ kējì yǔ shíshàng jiǎncái yíngdé le guǎngkuò shìchǎng.', 'Chiếc áo khoác ngoài chống gió thoáng khí dành cho hoạt động ngoài trời mới nhất do thương hiệu trang phục thể thao cao cấp này tung ra, nhờ vào công nghệ chống nước xuất sắc cùng đường may thời thượng đã chiếm trọn thị trường rộng lớn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [完全] (wánquán) - hoàn toàn, trọn vẹn [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '完全' AND pinyin = 'wánquán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '完全'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'wánquán',
      meaning_vi = 'hoàn toàn, trọn vẹn',
      example_hanzi = '他经过一个月的静养与调理，身体已经完全康复了。',
      example_pinyin = 'Tā jīngguò yí gè yuè de jìngyǎng yǔ tiáolǐ, shēntǐ yǐjīng wánquán kāngfù le.',
      example_vi = 'Anh ấy sau một tháng tĩnh dưỡng và bồi bổ, thân thể đã hoàn toàn bình phục rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他经过一个月的静养与调理，身体已经完全康复了。', 'Tā jīngguò yí gè yuè de jìngyǎng yǔ tiáolǐ, shēntǐ yǐjīng wánquán kāngfù le.', 'Anh ấy sau một tháng tĩnh dưỡng và bồi bổ, thân thể đã hoàn toàn bình phục rồi.', 'basic', 1),
        (v_id, '面对复杂多变的国际地缘政治环境，我国完全有信心、有能力、有底气战胜一切前进道路上的艰难险阻。', 'Miànduì fùzá-duōbiàn de guójì dìyuán zhèngzhì huánjìng, wǒ guó wánquán yǒu xìnxīn, yǒu nénglì, yǒu dǐqì zhànshèng yíqiè qiánjìn dàolù shang de jiānnán-xiǎnzǔ.', 'Đối mặt trước môi trường địa chính trị quốc tế biến đổi khôn lường, đất nước chúng ta hoàn toàn có niềm tin, có năng lực và có nền tảng vững vàng để chiến thắng mọi chông gai hiểm trở trên con đường tiến về phía trước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [晚安] (wǎn’ān) - chúc ngủ ngon [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '晚安' AND pinyin = 'wǎn’ān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '晚安'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'wǎn’ān',
      meaning_vi = 'chúc ngủ ngon',
      example_hanzi = '睡觉前互道一声“晚安”，能给平淡的家庭生活增添许多温馨。',
      example_pinyin = 'Shuìjiào qián hù dào yì shēng “wǎn’ān”, néng gěi píngdàn de jiātíng shēnghuó zēngtiān xǔduō wēnxīn.',
      example_vi = 'Trước khi đi ngủ gửi tới nhau một lời "chúc ngủ ngon", có thể tăng thêm bao điều ấm áp cho cuộc sống gia đình bình dị.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '睡觉前互道一声“晚安”，能给平淡的家庭生活增添许多温馨。', 'Shuìjiào qián hù dào yì shēng “wǎn’ān”, néng gěi píngdàn de jiātíng shēnghuó zēngtiān xǔduō wēnxīn.', 'Trước khi đi ngủ gửi tới nhau một lời "chúc ngủ ngon", có thể tăng thêm bao điều ấm áp cho cuộc sống gia đình bình dị.', 'basic', 1),
        (v_id, '随着当代快节奏职场生活的压力加剧，许多都市青年在睡前互发“晚安”已成为一种互相慰藉与情感陪伴的重要社交仪式。', 'Suízhe dāngdài kuài jiézòu zhíchǎng shēnghuó de yālì jiājù, xǔduō dūshì qīngnián zài shuìqián hù fā “wǎn’ān” yǐ chéngwéi yì zhǒng hùxiāng wèijiè yǔ qínggǎn péibàn de zhòngyào shèjiāo yíshì.', 'Cùng với áp lực gia tăng của cuộc sống công sở nhịp độ nhanh thời hiện đại, nhiều người trẻ thành thị nhắn tin "chúc ngủ ngon" cho nhau trước giờ ngủ đã trở thành một nghi thức giao tiếp xã hội quan trọng để an ủi và đồng hành tình cảm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [晚餐] (wǎncān) - bữa tối, cơm tối [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '晚餐' AND pinyin = 'wǎncān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '晚餐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wǎncān',
      meaning_vi = 'bữa tối, cơm tối',
      example_hanzi = '今天晚上全家人一起在家里享用了一顿丰盛美味的团圆晚餐。',
      example_pinyin = 'Jīntiān wǎnshang quán jiā rén yìqǐ zài jiā lǐ xiǎngyòng le yí dùn fēngshèng měiwèi de tuányuán wǎncān.',
      example_vi = 'Tối hôm nay cả nhà cùng nhau thưởng thức một bữa tối đoàn viên phong phú ngon miệng ngay tại nhà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天晚上全家人一起在家里享用了一顿丰盛美味的团圆晚餐。', 'Jīntiān wǎnshang quán jiā rén yìqǐ zài jiā lǐ xiǎngyòng le yí dùn fēngshèng měiwèi de tuányuán wǎncān.', 'Tối hôm nay cả nhà cùng nhau thưởng thức một bữa tối đoàn viên phong phú ngon miệng ngay tại nhà.', 'basic', 1),
        (v_id, '国际高峰论坛闭幕当天，主办国为来自全球的各国代表团团长举行了隆重盛大的欢迎国宴晚餐。', 'Guójì gāofēng lùntán bìmù dāngtiān, zhǔbànguó wèi láizì quánqiú de gè guó dàibiǎotuán tuánzhǎng jǔxíng le lóngzhòng shèngdà de huānyíng guóyàn wǎncān.', 'Vào đúng ngày bế mạc diễn đàn thượng đỉnh quốc tế, nước chủ nhà đã tổ chức một bữa tối quốc yến chào mừng vô cùng long trọng thịnh đại dành cho các trưởng đoàn đại biểu các nước đến từ khắp toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [网购] (wǎnggòu) - mua sắm qua mạng, mua sắm online [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '网购' AND pinyin = 'wǎnggòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '网购'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'wǎnggòu',
      meaning_vi = 'mua sắm qua mạng, mua sắm online',
      example_hanzi = '如今很多年轻人都习惯通过智能手机应用进行便捷的日常网购。',
      example_pinyin = 'Rújīn hěn duō niánqīng rén dōu xíguàn tōngguò zhìnéng shǒujī yìngyòng jìnxíng biànjié de rìcháng wǎnggòu.',
      example_vi = 'Ngày nay rất nhiều người trẻ đều quen với việc mua sắm qua mạng hàng ngày tiện lợi thông qua ứng dụng điện thoại thông minh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如今很多年轻人都习惯通过智能手机应用进行便捷的日常网购。', 'Rújīn hěn duō niánqīng rén dōu xíguàn tōngguò zhìnéng shǒujī yìngyòng jìnxíng biànjié de rìcháng wǎnggòu.', 'Ngày nay rất nhiều người trẻ đều quen với việc mua sắm qua mạng hàng ngày tiện lợi thông qua ứng dụng điện thoại thông minh.', 'basic', 1),
        (v_id, '随着农村现代化物流配送网络的全面贯通，农特产品网购直播直销已成为推动乡村全面振兴的新型强劲增长点。', 'Suízhe nóngcūn xiàndàihuà wùliú pèisòng wǎngluò de quánmiàn guàntōng, nóngtè chǎnpǐn wǎnggòu zhībō zhíxiāo yǐ chéngwéi tuīdòng xiāngcūn quánmiàn zhènxīng de xīnxíng qiángjìng zēngzhǎngdiǎn.', 'Cùng với việc thông suốt toàn diện mạng lưới giao hàng hậu cần hiện đại hóa nông thôn, việc livestream bán hàng trực tiếp và mua sắm nông đặc sản qua mạng đã trở thành điểm tăng trưởng mới mẻ mạnh mẽ thúc đẩy chấn hưng toàn diện nông thôn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [往往] (wǎngwǎng) - thường, hay [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '往往' AND pinyin = 'wǎngwǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '往往'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'wǎngwǎng',
      meaning_vi = 'thường, hay',
      example_hanzi = '性格乐观豁达的人在生活中往往能结交到更多真诚的朋友。',
      example_pinyin = 'Xìnggé lèguān huòdá de rén zài shēnghuó zhōng wǎngwǎng néng jiéjiāo dào gèng duō zhēnchéng de péngyou.',
      example_vi = 'Những người có tính cách lạc quan cởi mở trong cuộc sống thường có thể kết giao được với nhiều bạn bè chân thành hơn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '性格乐观豁达的人在生活中往往能结交到更多真诚的朋友。', 'Xìnggé lèguān huòdá de rén zài shēnghuó zhōng wǎngwǎng néng jiéjiāo dào gèng duō zhēnchéng de péngyou.', 'Những người có tính cách lạc quan cởi mở trong cuộc sống thường có thể kết giao được với nhiều bạn bè chân thành hơn.', 'basic', 1),
        (v_id, '重大的科学原创性突破，往往诞生在多学科深度交叉碰撞与勇于打破传统思维定势的探索实践之中。', 'Zhòngdà de kēxué yuánchuàngxìng tūpò, wǎngwǎng dànshēng zài duō xuékē shēndù jiāochā pèngzhuàng yǔ yǒngyú dǎpò chuántǒng sīwéi dìngshì de tànsuǒ shíjiàn zhī zhōng.', 'Những đột phá mang tính sáng tạo gốc to lớn trong khoa học thường được thai nghén từ trong thực tiễn khám phá có sự va chạm giao thoa sâu sắc giữa nhiều ngành học và sự dũng cảm phá bỏ lối mòn tư duy truyền thống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [网页] (wǎngyè) - trang web [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '网页' AND pinyin = 'wǎngyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '网页'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wǎngyè',
      meaning_vi = 'trang web',
      example_hanzi = '你可以直接打开我们学校的官方网页，查询最新的期末考试安排。',
      example_pinyin = 'Nǐ kěyǐ zhíjiē dǎkāi wǒmen xuéxiào de guānfāng wǎngyè, cháxún zuìxīn de qīmò kǎoshì ānpái.',
      example_vi = 'Bạn có thể mở trực tiếp trang web chính thức của trường chúng ta để tra cứu lịch thi cuối kỳ mới nhất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你可以直接打开我们学校的官方网页，查询最新的期末考试安排。', 'Nǐ kěyǐ zhíjiē dǎkāi wǒmen xuéxiào de guānfāng wǎngyè, cháxún zuìxīn de qīmò kǎoshì ānpái.', 'Bạn có thể mở trực tiếp trang web chính thức của trường chúng ta để tra cứu lịch thi cuối kỳ mới nhất.', 'basic', 1),
        (v_id, '前端开发团队重构了政府便民服务平台的网页交互架构，全面兼容各种移动端屏幕并大幅提升了页面加载响应速度。', 'Qiánduān kāifā tuánduì chónggòu le zhèngfǔ biànmín fúwù píngtái de wǎngyè jiāohù jiàgòu, quánmiàn xiāngróng gèzhǒng yídòngduān píngmù bìng dàfú tíshēng le yèmiàn jiāzài xiǎngyìng sùdù.', 'Đội ngũ phát triển giao diện người dùng đã tái cấu trúc kiến trúc tương tác trang web của nền tảng dịch vụ tiện ích dân sinh chính quyền, tương thích toàn diện với mọi màn hình thiết bị di động và nâng cao vượt bậc tốc độ phản hồi tải trang.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [网友] (wǎngyǒu) - bạn trên mạng, cư dân mạng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '网友' AND pinyin = 'wǎngyǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '网友'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wǎngyǒu',
      meaning_vi = 'bạn trên mạng, cư dân mạng',
      example_hanzi = '他通过网络语言交换平台结识了许多热爱学习中文的外国网友。',
      example_pinyin = 'Tā tōngguò wǎngluò yǔyán jiāohuàn píngtái jiéshí le xǔduō rè’ài xuéxí Zhōngwén de wàiguó wǎngyǒu.',
      example_vi = 'Anh ấy thông qua nền tảng trao đổi ngôn ngữ trên mạng đã quen biết nhiều người bạn trên mạng nước ngoài yêu thích học tiếng Trung.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他通过网络语言交换平台结识了许多热爱学习中文的外国网友。', 'Tā tōngguò wǎngluò yǔyán jiāohuàn píngtái jiéshí le xǔduō rè’ài xuéxí Zhōngwén de wàiguó wǎngyǒu.', 'Anh ấy thông qua nền tảng trao đổi ngôn ngữ trên mạng đã quen biết nhiều người bạn trên mạng nước ngoài yêu thích học tiếng Trung.', 'basic', 1),
        (v_id, '在遭遇突发自然灾害的危急时刻，数以千万计的热心网友通过网络公益平台迅速汇聚爱心善款，驰援灾区灾后重建。', 'Zài zāoyù tūfā zìrán zāihài de wēijí shíkè, shù yǐ qiānwàn jì de rèxīn wǎngyǒu tōngguò wǎngluò gōngyì píngtái xùnsù huìjù àixīn shànkuǎn, chíyuán zāiqū zāihòu chóngjiàn.', 'Vào thời khắc nguy cấp khi hứng chịu thiên tai bất ngờ ập đến, hàng chục triệu cư dân mạng nhiệt tâm thông qua các nền tảng công ích mạng đã nhanh chóng quy tụ nguồn tiền quyên góp hảo tâm, chi viện cho vùng thiên tai tái thiết sau thảm họa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [网址] (wǎngzhǐ) - địa chỉ trang web, URL [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '网址' AND pinyin = 'wǎngzhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '网址'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wǎngzhǐ',
      meaning_vi = 'địa chỉ trang web, URL',
      example_hanzi = '请把你们公司官方网站的网址发到我的邮箱里。',
      example_pinyin = 'Qǐng bǎ nǐmen gōngsī guānfāng wǎngzhàn de wǎngzhǐ fā dào wǒ de yóuxiāng lǐ.',
      example_vi = 'Xin hãy gửi địa chỉ trang web chính thức của công ty bạn vào hòm thư điện tử của tôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把你们公司官方网站的网址发到我的邮箱里。', 'Qǐng bǎ nǐmen gōngsī guānfāng wǎngzhàn de wǎngzhǐ fā dào wǒ de yóuxiāng lǐ.', 'Xin hãy gửi địa chỉ trang web chính thức của công ty bạn vào hòm thư điện tử của tôi.', 'basic', 1),
        (v_id, '网络安全专家郑重提醒广大网民，切勿随意点击来历不明的可疑网址链接，以切实防范电信网络诈骗与个人财产损失。', 'Wǎngluò ānquán zhuānjiā zhèngzhòng tíxǐng guǎngdà wǎngmín, qièwù suíyì diǎnjī láilì-bùmíng de kěyí wǎngzhǐ liànjiē, yǐ qièshí fángfàn diànxìn wǎngluò zhàpiàn yǔ gèrén cáichǎn sǔnshī.', 'Các chuyên gia an ninh mạng nhắc nhở nghiêm túc đông đảo cư dân mạng tuyệt đối không tùy tiện nhấp vào các đường link địa chỉ web khả nghi không rõ nguồn gốc, để thiết thực phòng ngừa lừa đảo mạng viễn thông và thiệt hại tài sản cá nhân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [危险] (wēixiǎn) - nguy hiểm; hiểm nguy [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '危险' AND pinyin = 'wēixiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '危险'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'wēixiǎn',
      meaning_vi = 'nguy hiểm; hiểm nguy',
      example_hanzi = '没有救生员在场看护的深水水域游泳是非常危险的行为。',
      example_pinyin = 'Méiyǒu jiùshēngyuán zàichǎng kānhù de shēnshuǐ shuǐyù yóuyǒng shì fēicháng wēixiǎn de xíngwéi.',
      example_vi = 'Bơi lội ở vùng nước sâu không có nhân viên cứu hộ túc trực trông nom là hành vi vô cùng nguy hiểm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '没有救生员在场看护的深水水域游泳是非常危险的行为。', 'Méiyǒu jiùshēngyuán zàichǎng kānhù de shēnshuǐ shuǐyù yóuyǒng shì fēicháng wēixiǎn de xíngwéi.', 'Bơi lội ở vùng nước sâu không có nhân viên cứu hộ túc trực trông nom là hành vi vô cùng nguy hiểm.', 'basic', 1),
        (v_id, '在化工易燃易爆危险化学品仓储管理中，必须严格执行防爆、防火、防静电最高安全标准，彻底杜绝重大安全事故风险。', 'Zài huàgōng yìrán-yìbào wēixiǎn huàxuépǐn cāngchǔ guǎnlǐ zhōng, bìxū yángé zhíxíng fángbào, fánghuǒ, fángjìngdiàn zuìgāo ānquán biāozhǔn, chèdǐ dùjué zhòngdà ānquán shìgù fēngxiǎn.', 'Trong công tác quản lý kho hóa chất nguy hiểm dễ cháy dễ nổ của ngành hóa chất, bắt buộc phải thực thi nghiêm ngặt các tiêu chuẩn an toàn cao nhất về chống nổ, chống cháy và chống tĩnh điện, triệt để loại bỏ nguy cơ sự cố an toàn nghiêm trọng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [为] (wéi) - làm, trở thành, là [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '为' AND pinyin = 'wéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '为'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'wéi',
      meaning_vi = 'làm, trở thành, là',
      example_hanzi = '青年一代要树立远大抱负，努力成长为对社会有用的人才。',
      example_pinyin = 'Qīngnián yídài yào shùlì yuǎndà bàofù, nǔlì chéngzhǎng wéi duì shèhuì yǒuyòng de réncái.',
      example_vi = 'Thế hệ thanh niên cần xác lập hoài bão cao xa, nỗ lực trưởng thành trở thành người tài có ích cho xã hội.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '青年一代要树立远大抱负，努力成长为对社会有用的人才。', 'Qīngnián yídài yào shùlì yuǎndà bàofù, nǔlì chéngzhǎng wéi duì shèhuì yǒuyòng de réncái.', 'Thế hệ thanh niên cần xác lập hoài bão cao xa, nỗ lực trưởng thành trở thành người tài có ích cho xã hội.', 'basic', 1),
        (v_id, '企业坚持以人为本、以创新为魂，把推动高质量发展作为企业全体干部职工团结奋斗的共同行动纲领。', 'Qǐyè jiānchí yǐ rén wéi běn, yǐ chuàngxīn wéi hún, bǎ tuīdòng gāozhìliàng fāzhǎn zuòwéi qǐyè quántǐ gànbù zhígōng tuánjié fèndòu de gòngtóng xíngdòng gānglǐng.', 'Doanh nghiệp kiên trì lấy con người làm gốc, lấy đổi mới làm linh hồn, coi việc thúc đẩy phát triển chất lượng cao là cương lĩnh hành động chung để toàn thể cán bộ công nhân viên doanh nghiệp đoàn kết phấn đấu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [味] (wèi) - mùi, vị, hương vị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '味' AND pinyin = 'wèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '味'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wèi',
      meaning_vi = 'mùi, vị, hương vị',
      example_hanzi = '厨房里飘出一股浓郁诱人的红烧肉香味，让人闻了胃口大开。',
      example_pinyin = 'Chúfáng lǐ piāo chū yì gǔ nóngyù yòurén de hóngshāoròu xiāngwèi, ràng rén wén le wèikǒu dà kāi.',
      example_vi = 'Trong gian bếp bay ra một làn mùi thơm thịt kho tàu nồng nàn quyến rũ, khiến người ta ngửi thấy là thèm ăn ngay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '厨房里飘出一股浓郁诱人的红烧肉香味，让人闻了胃口大开。', 'Chúfáng lǐ piāo chū yì gǔ nóngyù yòurén de hóngshāoròu xiāngwèi, ràng rén wén le wèikǒu dà kāi.', 'Trong gian bếp bay ra một làn mùi thơm thịt kho tàu nồng nàn quyến rũ, khiến người ta ngửi thấy là thèm ăn ngay.', 'basic', 1),
        (v_id, '这部优秀的现实主义文学巨著饱含着深厚的生活烟火味与真挚的人性关怀，深深打动了数以亿计的海内外读者。', 'Zhè bù yōuxiù de xiànshízhǔyì wénxué jùzhù bǎohánzhe shēnhòu de shēnghuó yānhuǒwèi yǔ zhēnzhì de rénxìng guānhuái, shēnshēn dǎdòng le shù yǐ yì jì de hǎinèiwài dúzhě.', 'Tác phẩm văn học hiện thực xuất sắc này chứa chan hương vị khói lửa cuộc đời sâu đậm và sự quan tâm nhân tính chân thành, làm rung động sâu sắc hàng trăm triệu độc giả trong và ngoài nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [味道] (wèidào) - hương vị, mùi vị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '味道' AND pinyin = 'wèidào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '味道'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wèidào',
      meaning_vi = 'hương vị, mùi vị',
      example_hanzi = '妈妈亲手做的西红柿打卤面，永远是我记忆深处最美味温暖的味道。',
      example_pinyin = 'Māma qīnshǒu zuò de xīhóngshì dǎlǔmiàn, yǒngyuǎn shì wǒ jìyì shēnchù zuì měiwèi wēnnuǎn de wèidào.',
      example_vi = 'Món mì sốt cà chua do chính tay mẹ nấu luôn là hương vị thơm ngon và ấm áp nhất trong sâu thẳm ký ức của tôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '妈妈亲手做的西红柿打卤面，永远是我记忆深处最美味温暖的味道。', 'Māma qīnshǒu zuò de xīhóngshì dǎlǔmiàn, yǒngyuǎn shì wǒ jìyì shēnchù zuì měiwèi wēnnuǎn de wèidào.', 'Món mì sốt cà chua do chính tay mẹ nấu luôn là hương vị thơm ngon và ấm áp nhất trong sâu thẳm ký ức của tôi.', 'basic', 1),
        (v_id, '传统老字号餐饮企业在坚守百年正宗地道味道精髓的同时，积极融合现代营养膳食理念推陈出新。', 'Chuántǒng lǎozìhào cānyǐn qǐyè zài jiānshǒu bǎi nián zhèngzōng dìdao wèidào jīngsuǐ de tóngshí, jījí rónghé xiàndài yíngyǎng shànshí lǐniàn tuīchén-chūxīn.', 'Doanh nghiệp ẩm thực danh tiếng truyền thống lâu năm trong lúc giữ gìn tinh hoa hương vị chuẩn vị chính tông trăm năm, đã tích cực kết hợp triết lý khẩu phần dinh dưỡng hiện đại để đổi mới sáng tạo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [卫生] (wèishēng) - vệ sinh; sạch sẽ [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '卫生' AND pinyin = 'wèishēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '卫生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'wèishēng',
      meaning_vi = 'vệ sinh; sạch sẽ',
      example_hanzi = '饭前便后勤洗手是养成良好个人卫生习惯的基本常识。',
      example_pinyin = 'Fàn qián biàn hòu qín xǐshǒu shì yǎngchéng liánghǎo gèrén wèishēng xíguàn de jīběn chángshí.',
      example_vi = 'Năng rửa tay trước khi ăn và sau khi đi vệ sinh là kiến thức thường thức cơ bản để hình thành thói quen vệ sinh cá nhân tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '饭前便后勤洗手是养成良好个人卫生习惯的基本常识。', 'Fàn qián biàn hòu qín xǐshǒu shì yǎngchéng liánghǎo gèrén wèishēng xíguàn de jīběn chángshí.', 'Năng rửa tay trước khi ăn và sau khi đi vệ sinh là kiến thức thường thức cơ bản để hình thành thói quen vệ sinh cá nhân tốt.', 'basic', 1),
        (v_id, '国家深入开展爱国卫生运动，扎实推进健康中国建设，全面改善城乡人居环境卫生状况并筑牢公共卫生防疫网。', 'Guójiā shēnrù kāizhǎn àiguó wèishēng yùndòng, zhāshi tuījìn Jiànkāng Zhōngguó jiànshè, quánmiàn gǎishàn chéng-xiāng rénjū huánjìng wèishēng zhuàngkuàng bìng zhùláo gōnggòng wèishēng fángyì wǎng.', 'Nhà nước triển khai sâu rộng phong trào vệ sinh yêu nước, thúc đẩy vững chắc việc xây dựng Nước Trung Hoa Khỏe Mạnh, cải thiện toàn diện tình trạng vệ sinh môi trường sống của đô thị và nông thôn đồng thời củng cố vững chắc lưới phòng dịch y tế công cộng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [温度] (wēndù) - nhiệt độ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '温度' AND pinyin = 'wēndù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '温度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wēndù',
      meaning_vi = 'nhiệt độ',
      example_hanzi = '初春时节天气变化频繁，早晚室外温度依然很低，大家要注意保暖。',
      example_pinyin = 'Chūchūn shíjié tiānqì biànhuà pínfán, zǎo-wǎn shìwài wēndù yīrán hěn dī, dàjiā yào zhùyì bǎonuǎn.',
      example_vi = 'Tiết trời đầu xuân thay đổi thường xuyên, nhiệt độ ngoài trời sớm tối vẫn còn rất thấp, mọi người cần chú ý giữ ấm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '初春时节天气变化频繁，早晚室外温度依然很低，大家要注意保暖。', 'Chūchūn shíjié tiānqì biànhuà pínfán, zǎo-wǎn shìwài wēndù yīrán hěn dī, dàjiā yào zhùyì bǎonuǎn.', 'Tiết trời đầu xuân thay đổi thường xuyên, nhiệt độ ngoài trời sớm tối vẫn còn rất thấp, mọi người cần chú ý giữ ấm.', 'basic', 1),
        (v_id, '现代农业智能温室大棚利用物联网传感器，对大棚内的光照强度、空气湿度与土壤温度实行毫秒级精准自动化智能调控。', 'Xiàndài nóngyè zhìnéng wēnshì dàpéng lìyòng wùliánwǎng chuángǎnqì, duì dàpéng nèi de guāngzhào qiángdù, kōngqì shīdù yǔ tǔrǎng wēndù shíxíng háomiǎojí jīngzhǔn zìdònghuà zhìnéng tiáokòng.', 'Nhà màng thông minh nông nghiệp hiện đại tận dụng các cảm biến vạn vật kết nối IoT để thực hiện việc điều khiển thông minh tự động hóa chuẩn xác đến từng mili-giây đối với cường độ chiếu sáng, độ ẩm không khí và nhiệt độ thổ nhưỡng trong nhà kính.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [闻] (wén) - ngửi; nghe thấy, nghe tiếng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '闻' AND pinyin = 'wén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '闻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'wén',
      meaning_vi = 'ngửi; nghe thấy, nghe tiếng',
      example_hanzi = '一走进花店，迎面就能闻到百合花散发出的阵阵清香。',
      example_pinyin = 'Yì zǒu jìn huādiàn, yíngmiàn jiù néng wén dào bǎihéhuā sànfā chū de zhènzhèn qīngxiāng.',
      example_vi = 'Vừa bước vào tiệm hoa, trước mặt đã có thể ngửi thấy từng làn hương thơm ngát tỏa ra từ hoa bách hợp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '一走进花店，迎面就能闻到百合花散发出的阵阵清香。', 'Yì zǒu jìn huādiàn, yíngmiàn jiù néng wén dào bǎihéhuā sànfā chū de zhènzhèn qīngxiāng.', 'Vừa bước vào tiệm hoa, trước mặt đã có thể ngửi thấy từng làn hương thơm ngát tỏa ra từ hoa bách hợp.', 'basic', 1),
        (v_id, '这位博学多识的老学者不仅知识渊博，更善于通过敏锐的学术洞察力做到见微知著、举一反三，在国际学界闻名遐迩。', 'Zhè wèi bóxué-duōshí de lǎo xuézhě bùjǐn zhīshi yuānbó, gèng shànyú tōngguò mǐnruì de xuéshù dòngchálì zuòdào jiànwēi-zhīzhù, jǔyī-fǎnsān, zài guójì xuéjiè wénmíng-xiá’ěr.', 'Vị học giả già học rộng biết nhiều này không chỉ có tri thức uyên bác, mà càng giỏi thông qua năng lực quan sát học thuật nhạy bén để nhìn việc nhỏ thấy đại cục, suy một biết mười, nức tiếng gần xa trong giới học thuật quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [文件] (wénjiàn) - tài liệu, văn kiện, tập tin [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '文件' AND pinyin = 'wénjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '文件'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wénjiàn',
      meaning_vi = 'tài liệu, văn kiện, tập tin',
      example_hanzi = '请把下周开会要用的总结报告文件打印三份带到会议室。',
      example_pinyin = 'Qǐng bǎ xià zhōu kāihuì yào yòng de zǒngjié bàogào wénjiàn dǎyìn sān fèn dài dào huìyìshì.',
      example_vi = 'Xin hãy in ba bản tài liệu báo cáo tổng kết dùng cho cuộc họp tuần sau mang tới phòng họp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把下周开会要用的总结报告文件打印三份带到会议室。', 'Qǐng bǎ xià zhōu kāihuì yào yòng de zǒngjié bàogào wénjiàn dǎyìn sān fèn dài dào huìyìshì.', 'Xin hãy in ba bản tài liệu báo cáo tổng kết dùng cho cuộc họp tuần sau mang tới phòng họp.', 'basic', 1),
        (v_id, '企业在推进数字化办公转型的进程中，必须建立严格的涉密商业电子文件加密存储与授权流转审核机制。', 'Qǐyè zài tuījìn shùzìhuà bàngōng zhuǎnxíng de jìnchéng zhōng, bìxū jiànlì yángé de shèmì shāngyè diànzǐ wénjiàn jiāmì chúcún yǔ shòuquán liúzhuǎn shěnhé jīzhì.', 'Doanh nghiệp trong tiến trình thúc đẩy chuyển đổi văn phòng số hóa bắt buộc phải xây dựng cơ chế mã hóa lưu trữ và xét duyệt luân chuyển cấp quyền nghiêm ngặt đối với các tập tin tài liệu điện tử thương mại mang tính bảo mật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [文章] (wénzhāng) - bài văn, bài viết, bài báo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '文章' AND pinyin = 'wénzhāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '文章'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wénzhāng',
      meaning_vi = 'bài văn, bài viết, bài báo',
      example_hanzi = '他在今天的报纸副刊上发表了一篇关于家乡风俗变迁的优美文章。',
      example_pinyin = 'Tā zài jīntiān de bàozhǐ fùkān shang fābiǎo le yì piān guānyú jiāxiāng fēngsú biànqiān de yōuměi wénzhāng.',
      example_vi = 'Anh ấy đã đăng một bài văn tuyệt đẹp về sự thay đổi phong tục quê hương trên phụ trương báo hôm nay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在今天的报纸副刊上发表了一篇关于家乡风俗变迁的优美文章。', 'Tā zài jīntiān de bàozhǐ fùkān shang fābiǎo le yì piān guānyú jiāxiāng fēngsú biànqiān de yōuměi wénzhāng.', 'Anh ấy đã đăng một bài văn tuyệt đẹp về sự thay đổi phong tục quê hương trên phụ trương báo hôm nay.', 'basic', 1),
        (v_id, '科研团队历时三年攻关完成的高水平研究成果，正式以长篇封面文章的形式发表在国际权威顶级期刊《自然》上。', 'Kēyán tuánduì lìshí sān nián gōngguān wánchéng de gāo shuǐpíng yánjiū chéngguǒ, zhèngshì yǐ chángpiān fēngmiàn wénzhāng de xíngshì fābiǎo zài guójì quánwēi dǐngjí qīkān “Zìrán” shang.', 'Thành quả nghiên cứu trình độ cao do đội ngũ nghiên cứu khoa học dày công đột phá suốt ba năm đã chính thức được đăng tải dưới hình thức bài viết trang bìa dài kỳ trên tạp chí đỉnh cao uy tín quốc tế Nature.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [文字] (wénzì) - chữ viết, văn tự [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '文字' AND pinyin = 'wénzì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '文字'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wénzì',
      meaning_vi = 'chữ viết, văn tự',
      example_hanzi = '汉字是世界上历史最悠久且至今仍在使用表意文字系统之一。',
      example_pinyin = 'Hànzì shì shìjiè shang lìshǐ zuì yōujiǔ qiě zhìjīn réng zài shǐyòng biǎoyì wénzì xìtǒng zhī yī.',
      example_vi = 'Chữ Hán là một trong những hệ thống văn tự biểu ý có lịch sử lâu đời nhất trên thế giới và cho tới nay vẫn đang được sử dụng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '汉字是世界上历史最悠久且至今仍在使用表意文字系统之一。', 'Hànzì shì shìjiè shang lìshǐ zuì yōujiǔ qiě zhìjīn réng zài shǐyòng biǎoyì wénzì xìtǒng zhī yī.', 'Chữ Hán là một trong những hệ thống văn tự biểu ý có lịch sử lâu đời nhất trên thế giới và cho tới nay vẫn đang được sử dụng.', 'basic', 1),
        (v_id, '殷墟甲骨文的发现与科学释读，将中国有文字记载的可靠信史大幅向前推进到了商代晚期。', 'Yīnxū jiǎgǔwén de fāxiàn yǔ kēxué shìdú, jiāng Zhōngguó yǒu wénzì jìzǎi de kěkào xìnshǐ dàfú xiàng qián tuījìn dào le Shāngdài wǎnqī.', 'Việc phát hiện và đọc giải khoa học giáp cốt văn tại phế tích Ân Khư đã thúc đẩy đáng tin cậy lịch sử có văn tự ghi chép của Trung Quốc tiến mạnh về phía trước tới tận thời kỳ cuối nhà Thương.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [污染] (wūrǎn) - ô nhiễm; sự ô nhiễm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '污染' AND pinyin = 'wūrǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '污染'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'wūrǎn',
      meaning_vi = 'ô nhiễm; sự ô nhiễm',
      example_hanzi = '河水因为受到工业废水的非法排放而遭受了严重的污染。',
      example_pinyin = 'Héshuǐ yīnwèi shòudào gōngyè fèishuǐ de fēifǎ páifàng ér zāoshòu le yánzhòng de wūrǎn.',
      example_vi = 'Nước sông do bị xả trộm nước thải công nghiệp trái phép mà đã hứng chịu sự ô nhiễm nghiêm trọng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '河水因为受到工业废水的非法排放而遭受了严重的污染。', 'Héshuǐ yīnwèi shòudào gōngyè fèishuǐ de fēifǎ páifàng ér zāoshòu le yánzhòng de wūrǎn.', 'Nước sông do bị xả trộm nước thải công nghiệp trái phép mà đã hứng chịu sự ô nhiễm nghiêm trọng.', 'basic', 1),
        (v_id, '各级生态环境部门坚持精准治污、科学治污、依法治污，深入打好蓝天、碧水、净土保卫战，全面遏制各类环境污染恶化态势。', 'Gè jí shēngtài huánjìng bùmén jiānchí jīngzhǔn zhìwū, kēxué zhìwū, yīfǎ zhìwū, shēnrù dǎ hǎo lántiān, bìshuǐ, jìngtǔ bǎowèizhàn, quánmiàn èzhì gèlèi huánjìng wūrǎn èhuà tàishì.', 'Cơ quan môi trường sinh thái các cấp kiên trì xử lý ô nhiễm chuẩn xác, xử lý ô nhiễm khoa học và theo đúng pháp luật, đánh thắng sâu sắc trận chiến bảo vệ trời xanh, nước biếc, đất lành, ngăn chặn toàn diện xu thế suy thoái do các loại ô nhiễm môi trường gây ra.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [无] (wú) - không có, vô [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '无' AND pinyin = 'wú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '无'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'wú',
      meaning_vi = 'không có, vô',
      example_hanzi = '在安静祥和的夜晚，他安然入睡，心中毫无烦恼与牵挂。',
      example_pinyin = 'Zài ānjìng xiánghé de yèwǎn, tā ānrán rùshuì, xīn zhōng háo wú fánnǎo yǔ qiānguà.',
      example_vi = 'Trong đêm tối yên bình và tường hòa, anh ấy thanh thản chìm vào giấc ngủ, trong lòng không hề có chút phiền muộn và vướng bận.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在安静祥和的夜晚，他安然入睡，心中毫无烦恼与牵挂。', 'Zài ānjìng xiánghé de yèwǎn, tā ānrán rùshuì, xīn zhōng háo wú fánnǎo yǔ qiānguà.', 'Trong đêm tối yên bình và tường hòa, anh ấy thanh thản chìm vào giấc ngủ, trong lòng không hề có chút phiền muộn và vướng bận.', 'basic', 1),
        (v_id, '广大科研人员发扬艰苦创业、敢为人先的精神，在无资金、无设备、无技术图纸的极其艰苦条件下实现了核心装备的完全自主自研。', 'Guǎngdà kēyán rényuán fāyáng jiānkǔ chuàngyè, gǎn wéi rén xiān de jīngshén, zài wú zījīn, wú shèbèi, wú jìshù túzhǐ de jíqí jiānkǔ tiáojiàn xià shíxiàn le héxīn zhuāngbèi de wánquán zìzhǔ zìyán.', 'Đông đảo cán bộ nghiên cứu khoa học phát huy tinh thần khởi nghiệp gian khổ, dám đi trước người khác, trong điều kiện cực kỳ gian nan không vốn, không thiết bị, không bản vẽ kỹ thuật đã thực hiện thành công việc tự nghiên cứu tự chủ hoàn toàn các trang thiết bị cốt lõi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [无法] (wúfǎ) - không thể, không có cách nào [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '无法' AND pinyin = 'wúfǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '无法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Phó từ',
      pinyin = 'wúfǎ',
      meaning_vi = 'không thể, không có cách nào',
      example_hanzi = '山里手机信号非常微弱，导致我们暂时无法与外界取得正常电话联系。',
      example_pinyin = 'Shān lǐ shǒujī xìnhào fēicháng wēiruò, dǎozhì wǒmen zànshí wúfǎ yǔ wàijiè qǔdé zhèngcháng diànhuà liánxì.',
      example_vi = 'Trong núi sóng điện thoại di động vô cùng yếu ớt, dẫn đến việc chúng tôi tạm thời không thể liên lạc điện thoại bình thường với bên ngoài.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '山里手机信号非常微弱，导致我们暂时无法与外界取得正常电话联系。', 'Shān lǐ shǒujī xìnhào fēicháng wēiruò, dǎozhì wǒmen zànshí wúfǎ yǔ wàijiè qǔdé zhèngcháng diànhuà liánxì.', 'Trong núi sóng điện thoại di động vô cùng yếu ớt, dẫn đến việc chúng tôi tạm thời không thể liên lạc điện thoại bình thường với bên ngoài.', 'basic', 1),
        (v_id, '由于双方在核心知识产权归属与未来利益分成模式上分歧巨大，跨国商业并购谈判陷入僵局而暂时无法推进。', 'Yóuyú shuāngfāng zài héxīn zhīshi chǎnquán guīshǔ yǔ wèilái lìyì fēnchéng móshì shang fēnqí jùdà, kuàguó shāngyè bìnggòu tánpàn xiànrù jiāngjú ér zànshí wúfǎ tuījìn.', 'Do hai bên có bất đồng quá lớn về quyền sở hữu tài sản trí tuệ cốt lõi và mô hình phân chia lợi ích mai sau, đàm phán sáp nhập thương mại xuyên quốc gia đã rơi vào bế tắc và tạm thời không có cách nào thúc đẩy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [无聊] (wúliáo) - buồn chán, vô vị, tẻ nhạt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '无聊' AND pinyin = 'wúliáo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '无聊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'wúliáo',
      meaning_vi = 'buồn chán, vô vị, tẻ nhạt',
      example_hanzi = '下雨天只能呆在家里看电视，弟弟觉得十分无聊。',
      example_pinyin = 'Xiàyǔtiān zhǐ néng dāi zài jiā lǐ kàn diànshì, dìdi juéde shífēn wúliáo.',
      example_vi = 'Ngày mưa chỉ có thể ru rú ở nhà xem tivi, em trai cảm thấy vô cùng buồn chán.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '下雨天只能呆在家里看电视，弟弟觉得十分无聊。', 'Xiàyǔtiān zhǐ néng dāi zài jiā lǐ kàn diànshì, dìdi juéde shífēn wúliáo.', 'Ngày mưa chỉ có thể ru rú ở nhà xem tivi, em trai cảm thấy vô cùng buồn chán.', 'basic', 1),
        (v_id, '年轻人应当珍惜宝贵的青春年华，将精力倾注于专业精进与自我提升，切勿沉湎于无聊低俗的网络口水战中虚度光阴。', 'Niánqīngrén yīngdāng zhēnxī bǎoguì de qīngchūn niánhuá, jiāng jīnglì qīngzhù yú zhuānyè jīngjìn yǔ zìwǒ tíshēng, qièwù chénmiǎn yú wúliáo dīsú de wǎngluò kǒushuǐzhàn zhōng xūdù guāngyīn.', 'Người trẻ tuổi nên trân quý những năm tháng thanh xuân quý báu, dồn sức lực vào việc nâng cao chuyên môn và hoàn thiện bản thân, tránh đắm chìm vào những cuộc khẩu chiến mạng vô vị tầm thường để rồi lãng phí thời gian.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [无论] (wúlùn) - bất luận, dù cho, cho dù [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '无论' AND pinyin = 'wúlùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '无论'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'wúlùn',
      meaning_vi = 'bất luận, dù cho, cho dù',
      example_hanzi = '无论明天下多大的雨，我们预定的毕业典礼都会如期举行。',
      example_pinyin = 'Wúlùn míngtiān xià duō dà de yǔ, wǒmen yùdìng de bìyè diǎnlǐ dōu huì rúqī jǔxíng.',
      example_vi = 'Bất luận ngày mai trời mưa to đến đâu, buổi lễ tốt nghiệp đã định của chúng tôi đều sẽ diễn ra đúng hạn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '无论明天下多大的雨，我们预定的毕业典礼都会如期举行。', 'Wúlùn míngtiān xià duō dà de yǔ, wǒmen yùdìng de bìyè diǎnlǐ dōu huì rúqī jǔxíng.', 'Bất luận ngày mai trời mưa to đến đâu, buổi lễ tốt nghiệp đã định của chúng tôi đều sẽ diễn ra đúng hạn.', 'basic', 1),
        (v_id, '无论国际风云如何变幻莫测，中国坚持高水平对外开放、与世界各国合作共赢的发展决心决不会动摇。', 'Wúlùn guójì fēngyún rúhé biànhuàn-mòcè, Zhōngguó jiānchí gāo shuǐpíng duìwài kāifàng, yǔ shìjiè gè guó hézuò-gòngyíng de fāzhǎn juéxīn jué bú huì dòngyáo.', 'Bất luận phong vân quốc tế biến hóa khôn lường ra sao, quyết tâm phát triển của Trung Quốc trong việc kiên trì mở cửa đối ngoại trình độ cao và hợp tác cùng có lợi với các nước trên thế giới quyết không bao giờ lay chuyển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [午餐] (wǔcān) - bữa trưa, cơm trưa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '午餐' AND pinyin = 'wǔcān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '午餐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wǔcān',
      meaning_vi = 'bữa trưa, cơm trưa',
      example_hanzi = '中午下课后，我和室友一起去二楼学生食堂享用美味午餐。',
      example_pinyin = 'Zhōngwǔ xiàkè hòu, wǒ hé shìyǒu yìqǐ qù èr lóu xuésheng shítáng xiǎngyòng měiwèi wǔcān.',
      example_vi = 'Sau khi tan học buổi trưa, tôi cùng bạn cùng phòng lên nhà ăn sinh viên tầng hai thưởng thức bữa trưa ngon miệng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中午下课后，我和室友一起去二楼学生食堂享用美味午餐。', 'Zhōngwǔ xiàkè hòu, wǒ hé shìyǒu yìqǐ qù èr lóu xuésheng shítáng xiǎngyòng měiwèi wǔcān.', 'Sau khi tan học buổi trưa, tôi cùng bạn cùng phòng lên nhà ăn sinh viên tầng hai thưởng thức bữa trưa ngon miệng.', 'basic', 1),
        (v_id, '国家深入实施农村义务教育学生营养改善计划，为数千万农村贫困地区中小学生提供免费营养搭配午餐。', 'Guójiā shēnrù shíshī nóngcūn yìwù jiàoyù xuésheng yíngyǎng gǎishàn jìhuà, wèi shù qiānwàn nóngcūn pínkùn dìqū zhōng-xiǎoxuéshēng tígōng miǎnfèi yíngyǎng dāpèi wǔcān.', 'Nhà nước triển khai sâu rộng kế hoạch cải thiện dinh dưỡng cho học sinh giáo dục bắt buộc nông thôn, cung cấp bữa trưa phối hợp dinh dưỡng miễn phí cho hàng chục triệu học sinh tiểu học và trung học vùng nông thôn nghèo khó.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [误会] (wùhuì) - hiểu lầm; sự hiểu lầm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '误会' AND pinyin = 'wùhuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '误会'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'wùhuì',
      meaning_vi = 'hiểu lầm; sự hiểu lầm',
      example_hanzi = '他们俩因为缺少及时沟通而产生了一些小误会，解释清楚后很快就和好了。',
      example_pinyin = 'Tāmen liǎ yīnwèi quēshǎo jíshí gōutōng ér chǎnshēng le yìxiē xiǎo wùhuì, jiěshì qīngchu hòu hěn kuài jiù héhǎo le.',
      example_vi = 'Hai người họ vì thiếu giao tiếp kịp thời mà nảy sinh một chút hiểu lầm nhỏ, sau khi giải thích rõ ràng thì nhanh chóng làm lành.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他们俩因为缺少及时沟通而产生了一些小误会，解释清楚后很快就和好了。', 'Tāmen liǎ yīnwèi quēshǎo jíshí gōutōng ér chǎnshēng le yìxiē xiǎo wùhuì, jiěshì qīngchu hòu hěn kuài jiù héhǎo le.', 'Hai người họ vì thiếu giao tiếp kịp thời mà nảy sinh một chút hiểu lầm nhỏ, sau khi giải thích rõ ràng thì nhanh chóng làm lành.', 'basic', 1),
        (v_id, '在跨文化国际交往中，唯有坚持相互尊重与包容互鉴，才能有效消除偏见与误会，夯实国家间睦邻友好的民意基础。', 'Zài kuà wénhuà guójì jiāowǎng zhōng, wéiyǒu jiānchí xiānghù zūnzhòng yǔ bāoróng hùjiàn, cái néng yǒuxiào xiāochú piānjiàn yǔ wùhuì, hāngshí guójiā jiān mùlín yǒuhǎo de mínyì jīchǔ.', 'Trong giao lưu quốc tế xuyên văn hóa, chỉ có kiên trì tôn trọng lẫn nhau và bao dung học hỏi lẫn nhau thì mới có thể xóa bỏ định kiến và hiểu lầm hiệu quả, củng cố vững chắc nền tảng lòng dân láng giềng hữu nghị giữa các quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [吸] (xī) - hít, hút [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '吸' AND pinyin = 'xī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '吸'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xī',
      meaning_vi = 'hít, hút',
      example_hanzi = '清晨漫步在松树林里，深深吸一口新鲜湿润的空气，令人心旷神怡。',
      example_pinyin = 'Qīngchén mànbù zài sōngshùlín lǐ, shēnshēn xī yì kǒu xīnxiān shīrùn de kōngqì, lìng rén xīnkuàng-shényí.',
      example_vi = 'Sáng sớm tản bộ trong rừng thông, hít sâu một hơi không khí trong lành ẩm mát khiến lòng người thư thái sảng khoái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '清晨漫步在松树林里，深深吸一口新鲜湿润的空气，令人心旷神怡。', 'Qīngchén mànbù zài sōngshùlín lǐ, shēnshēn xī yì kǒu xīnxiān shīrùn de kōngqì, lìng rén xīnkuàng-shényí.', 'Sáng sớm tản bộ trong rừng thông, hít sâu một hơi không khí trong lành ẩm mát khiến lòng người thư thái sảng khoái.', 'basic', 1),
        (v_id, '公共场所控烟执法部门全面加大巡查力度，严格禁止在医院、学校等室内公共场所吸香烟或电子烟。', 'Gōnggòng chǎngsuǒ kòngyān zhífǎ bùmén quánmiàn jiàdà xúnchá lìdù, yángé jìnzhǐ zài yīyuàn, xuéxiào děng shìnèi gōnggòng chǎngsuǒ xī xiāngyān huò diànzǐyān.', 'Cơ quan thực thi pháp luật kiểm soát thuốc lá nơi công cộng đã tăng cường toàn diện mức độ tuần tra, nghiêm cấm hút thuốc lá điếu hoặc thuốc lá điện tử tại các nơi công cộng trong nhà như bệnh viện, trường học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [西部] (xībù) - miền Tây, phía Tây [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '西部' AND pinyin = 'xībù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '西部'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xībù',
      meaning_vi = 'miền Tây, phía Tây',
      example_hanzi = '中国西部地域辽阔，拥有雄伟壮丽的雪山、高原与广袤草原。',
      example_pinyin = 'Zhōngguó xībù dìyù liáokuò, yōngyǒu xióngwěi zhuànglì de xuěshān, gāoyuán yǔ guǎngmào cǎoyuán.',
      example_vi = 'Miền Tây Trung Quốc cương thổ bao la, sở hữu những ngọn núi tuyết hùng vĩ tráng lệ, cao nguyên và những thảo nguyên mênh mông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国西部地域辽阔，拥有雄伟壮丽的雪山、高原与广袤草原。', 'Zhōngguó xībù dìyù liáokuò, yōngyǒu xióngwěi zhuànglì de xuěshān, gāoyuán yǔ guǎngmào cǎoyuán.', 'Miền Tây Trung Quốc cương thổ bao la, sở hữu những ngọn núi tuyết hùng vĩ tráng lệ, cao nguyên và những thảo nguyên mênh mông.', 'basic', 1),
        (v_id, '国家深入推进新时代西部大开发战略，着力构建大保护、大开放、高质量发展的新格局。', 'Guójiā shēnrù tuījìn xīn shídài xībù dà kāifā zhànlüè, zhuólì gòujiàn dà bǎohù, dà kāifàng, gāozhìliàng fāzhǎn de xīn géjú.', 'Nhà nước triển khai sâu rộng chiến lược đại phát triển miền Tây thời đại mới, chú trọng kiến tạo cục diện mới về bảo vệ lớn, mở cửa lớn và phát triển chất lượng cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [西红柿] (xīhóngshì) - cà chua [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '西红柿' AND pinyin = 'xīhóngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '西红柿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xīhóngshì',
      meaning_vi = 'cà chua',
      example_hanzi = '西红柿炒鸡蛋是一道深受全中国千家万户喜爱的经典传统家常菜。',
      example_pinyin = 'Xīhóngshì chǎo jīdàn shì yí dào shēn shòu quán Zhōngguó qiānjiā-wànhù xǐ’ài de jīngdiǎn chuántǒng jiāchángcài.',
      example_vi = 'Cà chua xào trứng là một món ăn gia đình truyền thống kinh điển được muôn vàn mái ấm trên khắp Trung Quốc yêu thích.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '西红柿炒鸡蛋是一道深受全中国千家万户喜爱的经典传统家常菜。', 'Xīhóngshì chǎo jīdàn shì yí dào shēn shòu quán Zhōngguó qiānjiā-wànhù xǐ’ài de jīngdiǎn chuántǒng jiāchángcài.', 'Cà chua xào trứng là một món ăn gia đình truyền thống kinh điển được muôn vàn mái ấm trên khắp Trung Quốc yêu thích.', 'basic', 1),
        (v_id, '现代农业科技示范园区采用先进无土立体栽培与水肥一体化滴灌技术，培育出的高糖度优质西红柿畅销高端生鲜市场。', 'Xiàndài nóngyè kējì shìfàn yuánqū cǎiyòng xiānjìn wútǔ lìtǐ zāipéi yǔ shuǐ-féi yītǐhuà dīguàn jìshù, péiyù chū de gāotángdù yōuzhì xīhóngshì chàngxiāo gāoduān shēngxiān shìchǎng.', 'Khu công viên trình diễn khoa học công nghệ nông nghiệp hiện đại áp dụng kỹ thuật canh tác lập thể không dùng đất và tưới nhỏ giọt tích hợp nước phân tiên tiến, những trái cà chua chất lượng cao độ ngọt cao nuôi trồng ra bán rất chạy trên thị trường thực phẩm tươi sống cao cấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [吸引] (xīyǐn) - thu hút, lôi cuốn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '吸引' AND pinyin = 'xīyǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '吸引'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xīyǐn',
      meaning_vi = 'thu hút, lôi cuốn',
      example_hanzi = '这座滨海旅游城市凭借优美的自然风光和宜人的气候，每年吸引了数以百万计的中外游客。',
      example_pinyin = 'Zhè zuò bīnhǎi lǚyóu chéngshì píngjiè yōuměi de zìrán fēngguāng hé yírén de qìhòu, měi nián xīyǐn le shù yǐ bǎiwàn jì de zhōng-wài yóukè.',
      example_vi = 'Thành phố du lịch ven biển này nhờ vào phong cảnh tự nhiên tươi đẹp và khí hậu dễ chịu, mỗi năm thu hút hàng triệu du khách trong và ngoài nước.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这座滨海旅游城市凭借优美的自然风光和宜人的气候，每年吸引了数以百万计的中外游客。', 'Zhè zuò bīnhǎi lǚyóu chéngshì píngjiè yōuměi de zìrán fēngguāng hé yírén de qìhòu, měi nián xīyǐn le shù yǐ bǎiwàn jì de zhōng-wài yóukè.', 'Thành phố du lịch ven biển này nhờ vào phong cảnh tự nhiên tươi đẹp và khí hậu dễ chịu, mỗi năm thu hút hàng triệu du khách trong và ngoài nước.', 'basic', 1),
        (v_id, '高新技术产业开发区通过打造国际一流的法治化营商环境与优厚的人才支持政策，持续吸引全球顶尖创新领军团队入驻。', 'Gāoxīn jìshù chǎnyè kāifāqū tōngguò dǎzào guójì yīliú de fǎzhìhuà yíngshāng huánjìng yǔ yōuhòu de réncái zhīchí zhèngcè, chíxù xīyǐn quánqiú dǐngjiān chuàngxīn lǐngjūn tuánduì rùzhù.', 'Khu phát triển ngành công nghệ cao thông qua việc tạo dựng môi trường kinh doanh pháp quyền hạng nhất quốc tế và chính sách đãi ngộ nhân tài hậu hĩnh, đã không ngừng thu hút các đội ngũ dẫn đầu đổi mới đỉnh cao toàn cầu tới định cư làm việc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [细] (xì) - nhỏ, mảnh, tinh tế, tỉ mỉ, kỹ lưỡng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '细' AND pinyin = 'xì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '细'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xì',
      meaning_vi = 'nhỏ, mảnh, tinh tế, tỉ mỉ, kỹ lưỡng',
      example_hanzi = '春雨像牛毛一样又轻又细，无声无息地滋润着田野里的庄稼。',
      example_pinyin = 'Chūnyǔ xiàng niúmáo yíyàng yòu qīng yòu xì, wúshēng-wúxī de zīrùnzhe tiányě lǐ de zhuāngjia.',
      example_vi = 'Mưa xuân như sợi lông tơ vừa nhẹ vừa mảnh, lặng lẽ không một tiếng động tưới tắm cho mùa màng trên đồng ruộng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '春雨像牛毛一样又轻又细，无声无息地滋润着田野里的庄稼。', 'Chūnyǔ xiàng niúmáo yíyàng yòu qīng yòu xì, wúshēng-wúxī de zīrùnzhe tiányě lǐ de zhuāngjia.', 'Mưa xuân như sợi lông tơ vừa nhẹ vừa mảnh, lặng lẽ không một tiếng động tưới tắm cho mùa màng trên đồng ruộng.', 'basic', 1),
        (v_id, '在精密微纳米芯片制造光刻工艺中，微米级乃至纳米级的细微缺陷都会直接导致整块晶圆报废，工艺控制必须精益求精。', 'Zài jīngmì wēi-nàmǐ xīnpiàn zhìzào guāngkè gōngyì zhōng, wēimǐjí nǎizhì nàmǐjí de xìwēi quēxiàn dōu huì zhíjiē dǎozhì zhěng kuài jīngyuán bàofèi, gōngyì kòngzhì bìxū jīngyìqiújīng.', 'Trong quy trình quang khắc chế tạo vi mạch bán dẫn nano cực kỳ tinh vi, khuyết tật nhỏ li ti cấp độ mi-crô-mét thậm chí na-nô-mét đều sẽ trực tiếp khiến toàn bộ tấm wafer bị hỏng loại bỏ, việc kiểm soát quy trình bắt buộc phải tinh xảo cầu tinh xảo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [细心] (xìxīn) - cẩn thận, chu đáo, tỉ mỉ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '细心' AND pinyin = 'xìxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '细心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xìxīn',
      meaning_vi = 'cẩn thận, chu đáo, tỉ mỉ',
      example_hanzi = '做数学计算题时一定要认真细心，千万不能粗心大意写错数字。',
      example_pinyin = 'Zuò shùxué jìsuàn tí shí yídìng yào rènzhēn xìxīn, qiānwàn bù néng cūxīn-dàyì xiě cuò shùzì.',
      example_vi = 'Khi làm bài tính toán số học nhất định phải cẩn thận tỉ mỉ, tuyệt đối không được sơ ý bất cẩn viết nhầm số.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '做数学计算题时一定要认真细心，千万不能粗心大意写错数字。', 'Zuò shùxué jìsuàn tí shí yídìng yào rènzhēn xìxīn, qiānwàn bù néng cūxīn-dàyì xiě cuò shùzì.', 'Khi làm bài tính toán số học nhất định phải cẩn thận tỉ mỉ, tuyệt đối không được sơ ý bất cẩn viết nhầm số.', 'basic', 1),
        (v_id, '在长达八个小时的复杂微创神经外科手术中，主刀专家以极其沉稳细心的操作精准剥离病灶，成功保全了患者的核心神经功能。', 'Zài cháng dá bā gè xiǎoshí de fùzá wēichuàng shénjīng wàikē shǒushù zhōng, zhǔdāo zhuānjiā yǐ jíqí chénwěn xìxīn de cāozuò jīngzhǔn bōlí bìngzào, chénggōng bǎoquán le huànzhě de héxīn shénjīng gōngnéng.', 'Trong ca phẫu thuật ngoại thần kinh xâm lấn tối thiểu phức tạp kéo dài tới tám tiếng đồng hồ, chuyên gia mổ chính bằng thao tác cực kỳ vững vàng và cẩn thận tỉ mỉ đã bóc tách chuẩn xác ổ bệnh, bảo tồn thành công chức năng thần kinh cốt lõi của người bệnh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [下降] (xiàjiàng) - giảm xuống, hạ xuống, sụt giảm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '下降' AND pinyin = 'xiàjiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '下降'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xiàjiàng',
      meaning_vi = 'giảm xuống, hạ xuống, sụt giảm',
      example_hanzi = '随着夜幕降临，室外气温骤然下降了近十度。',
      example_pinyin = 'Suízhe yèmù jiànglín, shìwài qìwēn zhòurán xiàjiàng le jìn shí dù.',
      example_vi = 'Cùng với màn đêm buông xuống, nhiệt độ ngoài trời đột ngột hạ xuống gần mười độ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着夜幕降临，室外气温骤然下降了近十度。', 'Suízhe yèmù jiànglín, shìwài qìwēn zhòurán xiàjiàng le jìn shí dù.', 'Cùng với màn đêm buông xuống, nhiệt độ ngoài trời đột ngột hạ xuống gần mười độ.', 'basic', 1),
        (v_id, '得益于国家多项稳产保供与平抑物价措施的落地显效，居民消费价格指数（CPI）涨幅呈现高位平稳回落下降态势。', 'Déyì yú guójiā duō xiàng wěnchǎn bǎogōng yǔ píngyì wùjià cuòshī de luòdì xiǎnxiào, jūmín xiāofèi jiàgé zhǐshù (CPI) zhǎngfú chéngxiàn gāowèi píngwěn huíluò xiàjiàng tàishì.', 'Nhờ vào nhiều biện pháp ổn định sản xuất bảo đảm cung ứng và bình ổn vật giá của nhà nước phát huy hiệu quả rõ rệt, mức tăng chỉ số giá tiêu dùng CPI đã thể hiện xu thế hạ nhiệt giảm xuống ổn định từ mức cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [鲜] (xiān) - tươi, tươi sống; thơm ngon, thanh ngọt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '鲜' AND pinyin = 'xiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '鲜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xiān',
      meaning_vi = 'tươi, tươi sống; thơm ngon, thanh ngọt',
      example_hanzi = '这碗刚出锅的鲜鱼汤味道格外鲜美，让人回味无穷。',
      example_pinyin = 'Zhè wǎn gāng chū guō de xiān yútāng wèidào géwài xiānměi, ràng rén huíwèi-wúqióng.',
      example_vi = 'Bát canh cá tươi vừa múc ra khỏi nồi này mùi vị đặc biệt tươi ngọt ngon lành, khiến người ta nhớ mãi không nguôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这碗刚出锅的鲜鱼汤味道格外鲜美，让人回味无穷。', 'Zhè wǎn gāng chū guō de xiān yútāng wèidào géwài xiānměi, ràng rén huíwèi-wúqióng.', 'Bát canh cá tươi vừa múc ra khỏi nồi này mùi vị đặc biệt tươi ngọt ngon lành, khiến người ta nhớ mãi không nguôi.', 'basic', 1),
        (v_id, '冷链物流冷藏技术的重大创新突破，使得原产地当日捕捞的活体海鲜能够在二十四小时内鲜活送达内陆腹地千家万户的餐桌。', 'Lěngliàn wùliú lěngcáng jìshù de zhòngdà chuàngxīn tūpò, shǐde yuánchǎndì dāngrì bǔlāo de huótǐ hǎixiān nénggòu zài èrshísì xiǎoshí nèi xiānhuó sòngdá nèilù fùdì qiānjiā-wànhù de cānzhuō.', 'Đột phá đổi mới quan trọng của kỹ thuật bảo quản lạnh chuỗi cung ứng lạnh đã giúp hải sản tươi sống đánh bắt trong ngày tại nơi sản xuất có thể vận chuyển tươi sống đến bàn ăn của muôn vàn mái ấm vùng sâu nội địa trong vòng 24 giờ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [鲜花] (xiānhuā) - hoa tươi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '鲜花' AND pinyin = 'xiānhuā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '鲜花'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiānhuā',
      meaning_vi = 'hoa tươi',
      example_hanzi = '母亲节那天，小芳买了一束芬芳美丽的康乃馨鲜花送给妈妈。',
      example_pinyin = 'Mǔqīnjié nà tiān, Xiǎofāng mǎi le yí shù fēnfāng měilì de kāngnǎixīn xiānhuā sòng gěi māma.',
      example_vi = 'Vào ngày của Mẹ, Tiểu Phương đã mua một bó hoa tươi cẩm chướng ngát hương xinh đẹp tặng mẹ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '母亲节那天，小芳买了一束芬芳美丽的康乃馨鲜花送给妈妈。', 'Mǔqīnjié nà tiān, Xiǎofāng mǎi le yí shù fēnfāng měilì de kāngnǎixīn xiānhuā sòng gěi māma.', 'Vào ngày của Mẹ, Tiểu Phương đã mua một bó hoa tươi cẩm chướng ngát hương xinh đẹp tặng mẹ.', 'basic', 1),
        (v_id, '国家植物园温室内常年繁花似锦，来自五大洲的上千种名贵鲜花竞相绽放，为游客呈现了一场永不落幕的植物世界视觉盛宴。', 'Guójiā Zhíwùyuán wēnshì nèi chángnián fánhuā-sìjǐn, láizì wǔdàzhōu de shàng qiān zhǒng míngguì xiānhuā jìngxiāng zhànfàng, wèi yóukè chéngxiàn le yì chǎng yǒng bú luòmù de zhíwù shìjiè shìjué shèngyàn.', 'Trong nhà kính của Vườn Thực vật Quốc gia quanh năm hoa nở như gấm, hơn ngàn loại hoa tươi quý hiếm đến từ năm châu cùng nhau khoe sắc, mang lại cho du khách một bữa tiệc thị giác thế giới thực vật không bao giờ tàn khép lại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [咸] (xián) - mặn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '咸' AND pinyin = 'xián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '咸'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xián',
      meaning_vi = 'mặn',
      example_hanzi = '今天厨师烧汤时不小心多放了点盐，汤的味道稍微有点咸。',
      example_pinyin = 'Jīntiān chúshī shāo tāng shí bù xiǎoxīn duō fàng le diǎn yán, tāng de wèidào shāowēi yǒudiǎnr xián.',
      example_vi = 'Hôm nay đầu bếp khi nấu canh sơ ý cho hơi nhiều muối một chút, vị canh hơi mặn một tí.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天厨师烧汤时不小心多放了点盐，汤的味道稍微有点咸。', 'Jīntiān chúshī shāo tāng shí bù xiǎoxīn duō fàng le diǎn yán, tāng de wèidào shāowēi yǒudiǎnr xián.', 'Hôm nay đầu bếp khi nấu canh sơ ý cho hơi nhiều muối một chút, vị canh hơi mặn một tí.', 'basic', 1),
        (v_id, '现代心血管健康医学指南明确倡导“减盐减糖减油”的科学健康生活理念，长期摄入过咸的高钠饮食会显著增加患高血压和肾脏疾病的潜在风险。', 'Xiàndài xīnxuèguǎn jiànkāng yīxué zhǐnán míngquè chàngdǎo “jiǎnyán jiǎntáng jiǎnyóu” de kēxué jiànkāng shēnghuó lǐniàn, chángqī shèrù guò xián de gāonà yǐnshí huì xiǎnzhù zēngjiā huàn gāoxuèyā hé shènzàng jíbìng de qiánzài fēngxiǎn.', 'Cẩm nang y học sức khỏe tim mạch hiện đại cổ vũ rõ nét triết lý sống khoa học khỏe mạnh "giảm muối giảm đường giảm dầu", việc lâu dài hấp thụ khẩu phần ăn quá mặn giàu natri sẽ làm tăng đáng kể nguy cơ tiềm ẩn mắc huyết áp cao và các bệnh về thận.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [现金] (xiànjīn) - tiền mặt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '现金' AND pinyin = 'xiànjīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '现金'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiànjīn',
      meaning_vi = 'tiền mặt',
      example_hanzi = '虽然移动支付非常普及，但他出门时还是习惯在钱包里备上少量现金应急。',
      example_pinyin = 'Suīrán yídòng zhīfù fēicháng pǔjí, dàn tā chūmén shí háishi xíguàn zài qiánbāo lǐ bèi shàng shǎoliàng xiànjīn yìngjí.',
      example_vi = 'Mặc dù thanh toán di động rất phổ biến, nhưng anh ấy khi ra cửa vẫn quen chuẩn bị một ít tiền mặt trong ví để dùng lúc khẩn cấp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '虽然移动支付非常普及，但他出门时还是习惯在钱包里备上少量现金应急。', 'Suīrán yídòng zhīfù fēicháng pǔjí, dàn tā chūmén shí háishi xíguàn zài qiánbāo lǐ bèi shàng shǎoliàng xiànjīn yìngjí.', 'Mặc dù thanh toán di động rất phổ biến, nhưng anh ấy khi ra cửa vẫn quen chuẩn bị một ít tiền mặt trong ví để dùng lúc khẩn cấp.', 'basic', 1),
        (v_id, '中国人民银行发布明确规范，任何单位和个人不得以任何理由拒收法定纸币现金，切实保障各类群体特别是老年消费者的自主支付权益。', 'Zhōngguó Rénmín Yínháng fābù míngquè guīfàn, rènhé dānwèi hé gèrén bùdé yǐ rènhé lǐyóu jùshōu fǎdìng zhǐbì xiànjīn, qièshí bǎozhàng gèlèi qúntǐ tèbié shì lǎonián xiāofèizhě de zìzhǔ zhīfù quányì.', 'Ngân hàng Nhân dân Trung Quốc ban hành quy chuẩn rõ ràng, bất kỳ đơn vị và cá nhân nào cũng không được từ chối nhận tiền mặt giấy bạc pháp định với bất kỳ lý do gì, thiết thực bảo vệ quyền lợi thanh toán tự chủ của các nhóm đối tượng đặc biệt là người tiêu dùng cao tuổi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [羡慕] (xiànmù) - ngưỡng mộ, ghen tị [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '羡慕' AND pinyin = 'xiànmù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '羡慕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xiànmù',
      meaning_vi = 'ngưỡng mộ, ghen tị',
      example_hanzi = '看到同学能说一口流利地道的汉语，大家心里都非常羡慕。',
      example_pinyin = 'Kàndào tóngxué néng shuō yì kǒu liúlì dìdao de Hànyǔ, dàjiā xīn lǐ dōu fēicháng xiànmù.',
      example_vi = 'Nhìn thấy bạn học có thể nói được một giọng tiếng Hán lưu loát chuẩn chỉnh, trong lòng mọi người đều vô cùng ngưỡng mộ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '看到同学能说一口流利地道的汉语，大家心里都非常羡慕。', 'Kàndào tóngxué néng shuō yì kǒu liúlì dìdao de Hànyǔ, dàjiā xīn lǐ dōu fēicháng xiànmù.', 'Nhìn thấy bạn học có thể nói được một giọng tiếng Hán lưu loát chuẩn chỉnh, trong lòng mọi người đều vô cùng ngưỡng mộ.', 'basic', 1),
        (v_id, '与其单纯在场外盲目羡慕别人的成功与光环，不如脚踏实地将精力转化为日复一日默默奋斗的坚韧行动。', 'Yǔqí dānchún zài chǎngwài mángmù xiànmù biérén de chénggōng yǔ guānghuán, bùrú jiǎotàshídì jiāng jīnglì zhuǎnhuà wéi rì fù yí rì mòmò fèndòu de jiānrèn xíngdòng.', 'Thay vì chỉ đơn thuần đứng ngoài sân ngưỡng mộ mù quáng hào quang và thành công của người khác, chi bằng hãy vững vàng đặt chân xuống đất biến sức lực thành hành động kiên cường âm thầm phấn đấu ngày này qua ngày khác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [线上] (xiànshàng) - trực tuyến, trên mạng, online [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '线上' AND pinyin = 'xiànshàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '线上'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiànshàng',
      meaning_vi = 'trực tuyến, trên mạng, online',
      example_hanzi = '因为出差在外地，他今天通过网络视频参加了线上的部门例会。',
      example_pinyin = 'Yīnwèi chūchāi zài wàidì, tā jīntiān tōngguò wǎngluò shìpín cānjiā le xiànshàng de bùmén lìhuì.',
      example_vi = 'Vì đi công tác ở ngoại tỉnh, anh ấy hôm nay đã tham gia cuộc họp định kỳ của bộ phận trực tuyến qua video mạng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '因为出差在外地，他今天通过网络视频参加了线上的部门例会。', 'Yīnwèi chūchāi zài wàidì, tā jīntiān tōngguò wǎngluò shìpín cānjiā le xiànshàng de bùmén lìhuì.', 'Vì đi công tác ở ngoại tỉnh, anh ấy hôm nay đã tham gia cuộc họp định kỳ của bộ phận trực tuyến qua video mạng.', 'basic', 1),
        (v_id, '现代零售巨头加速推进“线上云店下单与线下智慧门店即时配送”深度融合的新零售模式，实现了全天候全场景的极致购物体验。', 'Xiàndài língshòu jùtóu jiāsù tuījìn “xiànshàng yúndiàn xiàdān yǔ xiànxià zhìhuì méndiàn jíshí pèisòng” shēndù rónghé de xīn língshòu móshì, shíxiàn le quántiānhòu quán chǎngjǐng de jízhì gòuwù tǐyàn.', 'Gã khổng lồ bán lẻ hiện đại đẩy nhanh việc xúc tiến mô hình bán lẻ mới kết hợp sâu sắc giữa "đặt hàng trên cửa hàng đám mây trực tuyến và giao hàng tức thì từ cửa hàng thông minh trực tiếp", đạt được trải nghiệm mua sắm tột đỉnh 24/7 trên mọi kịch bản.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [线下] (xiànxià) - trực tiếp, tại chỗ, offline [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '线下' AND pinyin = 'xiànxià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '线下'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiànxià',
      meaning_vi = 'trực tiếp, tại chỗ, offline',
      example_hanzi = '虽然网上有很多试卷，但参加线下全真模拟考试的临场感更强。',
      example_pinyin = 'Suīrán wǎngshang yǒu hěn duō shìjuàn, dàn cānjiā xiànxià quánzhēn mónǐ kǎoshì de línchǎnggǎn gèng qiáng.',
      example_vi = 'Tuy trên mạng có rất nhiều đề thi, nhưng việc tham gia thi mô phỏng như thật trực tiếp đem lại cảm giác hiện trường chân thực mạnh mẽ hơn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '虽然网上有很多试卷，但参加线下全真模拟考试的临场感更强。', 'Suīrán wǎngshang yǒu hěn duō shìjuàn, dàn cānjiā xiànxià quánzhēn mónǐ kǎoshì de línchǎnggǎn gèng qiáng.', 'Tuy trên mạng có rất nhiều đề thi, nhưng việc tham gia thi mô phỏng như thật trực tiếp đem lại cảm giác hiện trường chân thực mạnh mẽ hơn.', 'basic', 1),
        (v_id, '政务服务大厅持续深化“一网通办”改革，同时大力优化线下实体窗口的人性化便民帮办代办服务，切实兜牢民生办事底线。', 'Zhèngwù fúwù dàtīng chíxù shēnhuà “yì wǎng tōng bàn” gǎigé, tóngshí dàlì yōuhuà xiànxià shítǐ chuāngkǒu de rénxìnghuà biànmín bāngbàn dàibàn fúwù, qièshí dōuláo mínshēng bànshì dǐxiàn.', 'Đại sảnh dịch vụ công tiếp tục làm sâu sắc cải cách "một mạng giải quyết thông suốt", đồng thời dốc sức tối ưu hóa dịch vụ hướng dẫn làm hộ mang tính nhân văn tiện dân tại các quầy trực tiếp bên ngoài, thiết thực giữ vững nền tảng giải quyết công việc cho đời sống dân sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 8: #1701 -> #1800)!', v_count;
END $$;
