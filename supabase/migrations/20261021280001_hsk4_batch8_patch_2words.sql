-- ====================================================================
-- PATCH: BỔ SUNG CÂU VÍ DỤ CHO 2 TỪ CÒN LẠI CỦA BATCH 8: [抬头] VÀ [躺]
-- Đưa Batch 8 lên trọn vẹn 100/100 từ (200 câu ví dụ) và toàn HSK 4 lên đúng 80.0%!
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
BEGIN
  -- 1. [抬头] (táitóu) - ngẩng đầu, ngước nhìn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '抬头'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'táitóu',
      meaning_vi = 'ngẩng đầu, ngước nhìn; ngóc đầu lên',
      example_hanzi = '夜晚走在宁静的乡间小路上，抬头就能看见满天璀璨的繁星。',
      example_pinyin = 'Yèwǎn zǒu zài níngjìng de xiāngjiān xiǎolù shang, táitóu jiù néng kànjiàn mǎntiān cuǐcàn de fánxīng.',
      example_vi = 'Buổi tối đi trên con đường làng yên tĩnh, ngẩng đầu lên là có thể nhìn thấy muôn vì sao lấp lánh khắp trời.'
    WHERE id = v_id;

    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夜晚走在宁静的乡间小路上，抬头就能看见满天璀璨的繁星。', 'Yèwǎn zǒu zài níngjìng de xiāngjiān xiǎolù shang, táitóu jiù néng kànjiàn mǎntiān cuǐcàn de fánxīng.', 'Buổi tối đi trên con đường làng yên tĩnh, ngẩng đầu lên là có thể nhìn thấy muôn vì sao lấp lánh khắp trời.', 'basic', 1),
        (v_id, '青年学者在学术探索中既要脚踏实地扎实钻研专业细节，更要经常抬头看路把握国际学术前沿的大趋势。', 'Qīngnián xuézhě zài xuéshù tànsuǒ zhōng jì yào jiǎotàshídì zhāshi zuānyán zhuānyè xìjié, gèng yào jīngcháng táitóu kàn lù bǎwò guójì xuéshù qiányán de dà qūshì.', 'Các học giả trẻ trong nghiên cứu học thuật vừa phải đặt chân vững vàng chuyên tâm nghiên cứu sâu các chi tiết chuyên ngành, càng phải thường xuyên ngẩng đầu nhìn đường để nắm bắt xu thế lớn của mũi nhọn học thuật quốc tế.', 'applied', 2);
    END IF;
  END IF;

  -- 2. [躺] (tǎng) - nằm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '躺'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tǎng',
      meaning_vi = 'nằm',
      example_hanzi = '工作累了一整天，回到家躺在舒适柔软的沙发上感觉格外轻松。',
      example_pinyin = 'Gōngzuò lèi le yì zhěng tiān, huí dào jiā tǎng zài shūshì róuruǎn de shāfā shang gǎnjué géwài qīngsōng.',
      example_vi = 'Làm việc mệt mỏi cả ngày, về tới nhà nằm trên chiếc ghế sô pha êm ái dễ chịu cảm thấy vô cùng thoải mái.'
    WHERE id = v_id;

    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '工作累了一整天，回到家躺在舒适柔软的沙发上感觉格外轻松。', 'Gōngzuò lèi le yì zhěng tiān, huí dào jiā tǎng zài shūshì róuruǎn de shāfā shang gǎnjué géwài qīngsōng.', 'Làm việc mệt mỏi cả ngày, về tới nhà nằm trên chiếc ghế sô pha êm ái dễ chịu cảm thấy vô cùng thoải mái.', 'basic', 1),
        (v_id, '医生再三叮嘱做完腰椎手术的患者必须绝对卧床静养平躺两周，切勿过早下地负重活动。', 'Yīshēng zàisān dīngzhǔ zuò wán yāozhuī shǒushù de huànzhě bìxū juéduì wòchuáng jìngyǎng píngtǎng liǎng zhōu, qièwù guòzǎo xiàdì fùzhòng huódòng.', 'Bác sĩ dặn đi dặn lại bệnh nhân sau khi mổ cột sống thắt lưng bắt buộc phải tuyệt đối nằm yên trên giường tĩnh dưỡng trong hai tuần, chớ nên xuống đất vận động mang vác quá sớm.', 'applied', 2);
    END IF;
  END IF;

  RAISE NOTICE 'Hoàn thành cập nhật ví dụ cho 2 từ [抬头] và [躺]!';
END $$;
