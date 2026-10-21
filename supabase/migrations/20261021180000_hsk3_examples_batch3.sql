-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 3 - BATCH 3 (80 TỪ)
-- Phạm vi: Từ [盘子] (pánzi) đến [黑板] (hēibǎn)
-- Tổng số câu ví dụ: 160 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Không tạo từ mới hay bản ghi trùng trong vocabularies
--   - Cập nhật chuẩn hóa cột word_type (Từ loại)
--   - Nạp chính xác 2 câu ví dụ vào bảng vocabulary_examples kèm Pinyin và dịch TV
--   - Đồng bộ cột tương thích ngược example_hanzi trên bảng vocabularies
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
  -- [盘子] (pánzi) - cái đĩa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '盘子'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'pánzi',
      example_hanzi = '服务员，请再给我们拿两个干净的盘子。',
      example_pinyin = 'Fúwùyuán, qǐng zài gěi wǒmen ná liǎng gè gānjìng de pánzi.',
      example_vi = 'Phục vụ ơi, xin hãy lấy thêm cho chúng tôi hai chiếc đĩa sạch.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '服务员，请再给我们拿两个干净的盘子。', 'Fúwùyuán, qǐng zài gěi wǒmen ná liǎng gè gānjìng de pánzi.', 'Phục vụ ơi, xin hãy lấy thêm cho chúng tôi hai chiếc đĩa sạch.', 'basic', 1),
        (v_id, '他不小心把桌上的白瓷盘子打碎了，连忙向主人道歉。', 'Tā bù xiǎoxīn bǎ zhuō shang de bái cí pánzi dǎ suì le, liánmáng xiàng zhǔrén dàoqiàn.', 'Anh ấy lỡ tay làm vỡ chiếc đĩa sứ trắng trên bàn, vội vàng xin lỗi chủ nhà.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [相信] (xiāngxìn) - tin tưởng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '相信'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xiāngxìn',
      example_hanzi = '只要你努力，我相信你一定能学好汉语。',
      example_pinyin = 'Zhǐyào nǐ nǔlì, wǒ xiāngxìn nǐ yídìng néng xué hǎo Hànyǔ.',
      example_vi = 'Chỉ cần bạn nỗ lực, tôi tin bạn nhất định có thể học tốt tiếng Trung.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '只要你努力，我相信你一定能学好汉语。', 'Zhǐyào nǐ nǔlì, wǒ xiāngxìn nǐ yídìng néng xué hǎo Hànyǔ.', 'Chỉ cần bạn nỗ lực, tôi tin bạn nhất định có thể học tốt tiếng Trung.', 'basic', 1),
        (v_id, '互相信任与真诚沟通是朋友之间保持长久友谊的基石。', 'Hùxiāng xìnrèn yǔ zhēnchéng gōutōng shì péngyou zhījiān bǎochí chángjiǔ yǒuyì de jīshí.', 'Tin tưởng lẫn nhau và giao tiếp chân thành là nền tảng giữ gìn tình bạn lâu bền.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [着急] (zháojí) - sốt ruột, lo lắng [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '着急'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'zháojí',
      example_hanzi = '别着急，离飞机起飞还有两个小时呢。',
      example_pinyin = 'Bié zháojí, lí fēijī qǐfēi hái yǒu liǎng gè xiǎoshí ne.',
      example_vi = 'Đừng lo lắng, còn hai tiếng nữa máy bay mới cất cánh mà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '别着急，离飞机起飞还有两个小时呢。', 'Bié zháojí, lí fēijī qǐfēi hái yǒu liǎng gè xiǎoshí ne.', 'Đừng lo lắng, còn hai tiếng nữa máy bay mới cất cánh mà.', 'basic', 1),
        (v_id, '找不到准考证的他急得满头大汗，不知道该怎么办。', 'Zhǎo bú dào zhǔnkǎozhèng de tā jí de mǎntóudàhàn, bù zhīdào gāi zěnme bàn.', 'Không tìm thấy thẻ dự thi khiến cậu ấy sốt ruột toát mồ hôi hột, không biết phải làm sao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [短] (duǎn) - ngắn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '短'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'duǎn',
      example_hanzi = '这条裤子太短了，换一条长一点儿的吧。',
      example_pinyin = 'Zhè tiáo kùzi tài duǎn le, huàn yì tiáo cháng yìdiǎnr de ba.',
      example_vi = 'Chiếc quần này ngắn quá rồi, đổi chiếc dài hơn một chút đi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这条裤子太短了，换一条长一点儿的吧。', 'Zhè tiáo kùzi tài duǎn le, huàn yì tiáo cháng yìdiǎnr de ba.', 'Chiếc quần này ngắn quá rồi, đổi chiếc dài hơn một chút đi.', 'basic', 1),
        (v_id, '在短短的一个月时间里，他的汉语口语水平有了显著提高。', 'Zài duǎnduǎn de yí gè yuè shíjiān lǐ, tā de Hànyǔ kǒuyǔ shuǐpíng yǒu le xiǎnzhù tígāo.', 'Chỉ trong vòng vỏn vẹn một tháng ngắn ngủi, trình độ khẩu ngữ tiếng Trung của cậu ấy đã tiến bộ rõ rệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [矮] (ǎi) - thấp, lùn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '矮'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'ǎi',
      example_hanzi = '弟弟比哥哥矮了半个头。',
      example_pinyin = 'Dìdi bǐ gēge ǎi le bàn gè tóu.',
      example_vi = 'Em trai thấp hơn anh trai nửa cái đầu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '弟弟比哥哥矮了半个头。', 'Dìdi bǐ gēge ǎi le bàn gè tóu.', 'Em trai thấp hơn anh trai nửa cái đầu.', 'basic', 1),
        (v_id, '虽然他身材比较矮小，但打起篮球来速度极快而且非常灵活。', 'Suīrán tā shēncái bǐjiào ǎixiǎo, dàn dǎ qǐ lánqiú lái sùdù jí kuài érqiě fēicháng línghuó.', 'Tuy vóc dáng khá thấp bé, nhưng khi chơi bóng rổ thì tốc độ cực nhanh và vô cùng linh hoạt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [碗] (wǎn) - bát, chén [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '碗'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'wǎn',
      example_hanzi = '中午我吃了一大碗热腾腾的牛肉面。',
      example_pinyin = 'Zhōngwǔ wǒ chī le yí dà wǎn rèténgténg de niúròumiàn.',
      example_vi = 'Buổi trưa tôi đã ăn một bát to mì bò nóng hổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中午我吃了一大碗热腾腾的牛肉面。', 'Zhōngwǔ wǒ chī le yí dà wǎn rèténgténg de niúròumiàn.', 'Buổi trưa tôi đã ăn một bát to mì bò nóng hổi.', 'basic', 1),
        (v_id, '吃完晚饭后，孩子们主动帮妈妈把碗筷收拾得干干净净。', 'Chī wán wǎnfàn hòu, háizimen zhǔdòng bāng māma bǎ wǎnkuài shōushi de gāngānjìngjìng.', 'Sau bữa tối, các con chủ động giúp mẹ dọn dẹp bát đũa sạch bong kin kít.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [礼物] (lǐwù) - quà tặng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '礼物'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lǐwù',
      example_hanzi = '这是我为你准备的生日礼物。',
      example_pinyin = 'Zhè shì wǒ wèi nǐ zhǔnbèi de shēngrì lǐwù.',
      example_vi = 'Đây là món quà sinh nhật tôi chuẩn bị cho bạn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这是我为你准备的生日礼物。', 'Zhè shì wǒ wèi nǐ zhǔnbèi de shēngrì lǐwù.', 'Đây là món quà sinh nhật tôi chuẩn bị cho bạn.', 'basic', 1),
        (v_id, '收到远方朋友寄来的珍贵礼物，他感到既惊喜又温暖。', 'Shōudào yuǎnfāng péngyou jì lái de zhēnguì lǐwù, tā gǎndào jì jīngxǐ yòu wēnnuǎn.', 'Nhận được món quà quý giá do người bạn phương xa gửi tới, anh ấy cảm thấy vừa bất ngờ vừa ấm lòng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [离开] (líkāi) - rời đi, rời khỏi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '离开'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'líkāi',
      example_hanzi = '会议还没结束，他因为有急事就提前离开了。',
      example_pinyin = 'Huìyì hái méi jiéshù, tā yīnwèi yǒu jíshì jiù tíqián líkāi le.',
      example_vi = 'Cuộc họp vẫn chưa kết thúc, anh ấy vì có việc gấp nên đã rời đi sớm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '会议还没结束，他因为有急事就提前离开了。', 'Huìyì hái méi jiéshù, tā yīnwèi yǒu jíshì jiù tíqián líkāi le.', 'Cuộc họp vẫn chưa kết thúc, anh ấy vì có việc gấp nên đã rời đi sớm.', 'basic', 1),
        (v_id, '高中毕业后，很多同学离开故乡前往大城市读大学。', 'Gāozhōng bìyè hòu, hěnduō tóngxué líkāi gùxiāng qiánwǎng dà chéngshì dú dàxué.', 'Sau khi tốt nghiệp cấp ba, nhiều bạn học rời quê hương đến các thành phố lớn học đại học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [种] (zhǒng) - loại, chủng loại [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '种'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'zhǒng',
      example_hanzi = '超市里有各种各样新鲜的水果。',
      example_pinyin = 'Chāoshì lǐ yǒu gèzhǒng-gèyàng xīnxiān de shuǐguǒ.',
      example_vi = 'Trong siêu thị có đủ mọi loại hoa quả tươi ngon.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '超市里有各种各样新鲜的水果。', 'Chāoshì lǐ yǒu gèzhǒng-gèyàng xīnxiān de shuǐguǒ.', 'Trong siêu thị có đủ mọi loại hoa quả tươi ngon.', 'basic', 1),
        (v_id, '这种新型智能手机不仅外观时尚，拍照功能也非常强大。', 'Zhè zhǒng xīnxíng zhìnéng shǒujī bùjǐn wàiguān shíshàng, pāizhào gōngnéng yě fēicháng qiángdà.', 'Loại điện thoại thông minh mẫu mới này không những kiểu dáng thời trang mà chức năng chụp ảnh cũng rất mạnh mẽ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [空调] (kōngtiáo) - điều hòa, máy lạnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '空调'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kōngtiáo',
      example_hanzi = '夏天太热了，房间需要开空调。',
      example_pinyin = 'Xiàtiān tài rè le, fángjiān xūyào kāi kōngtiáo.',
      example_vi = 'Mùa hè nóng quá, trong phòng cần phải bật điều hòa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夏天太热了，房间需要开空调。', 'Xiàtiān tài rè le, fángjiān xūyào kāi kōngtiáo.', 'Mùa hè nóng quá, trong phòng cần phải bật điều hòa.', 'basic', 1),
        (v_id, '外出前请记得随手关闭办公室里的空调和电灯，节约用电。', 'Wàichū qián qǐng jìde suíshǒu guānbì bàngōngshì lǐ de kōngtiáo hé diàndēng, jiéyuē yòngdiàn.', 'Trước khi ra ngoài xin nhớ tắt máy lạnh và đèn trong văn phòng để tiết kiệm điện.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [突然] (tūrán) - đột nhiên, bất ngờ [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '突然'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'tūrán',
      example_hanzi = '刚才还是晴天，突然下起了大雨。',
      example_pinyin = 'Gāngcái hái shì qíngtiān, tūrán xià qǐ le dàyǔ.',
      example_vi = 'Vừa rồi trời vẫn nắng, đột nhiên lại đổ cơn mưa lớn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '刚才还是晴天，突然下起了大雨。', 'Gāngcái hái shì qíngtiān, tūrán xià qǐ le dàyǔ.', 'Vừa rồi trời vẫn nắng, đột nhiên lại đổ cơn mưa lớn.', 'basic', 1),
        (v_id, '听到这个令人震惊的突然消息，大家都愣住了。', 'Tīng dào zhè gè lìng rén zhènjīng de tūrán xiāoxi, dàjiā dōu lèng zhù le.', 'Nghe tin tức bất ngờ gây kinh ngạc này, mọi người đều sững sờ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [站] (zhàn) - đứng; bến, trạm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '站'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhàn',
      example_hanzi = '我们在地铁站门口等你，快点儿来吧。',
      example_pinyin = 'Wǒmen zài dìtiězhàn ménkǒu děng nǐ, kuài diǎnr lái ba.',
      example_vi = 'Chúng tôi đợi bạn ở cửa ga tàu điện ngầm, đến nhanh nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们在地铁站门口等你，快点儿来吧。', 'Wǒmen zài dìtiězhàn ménkǒu děng nǐ, kuài diǎnr lái ba.', 'Chúng tôi đợi bạn ở cửa ga tàu điện ngầm, đến nhanh nhé.', 'basic', 1),
        (v_id, '公车上没有空座位了，他一直站了一个多小时才到家。', 'Gōngchē shang méiyǒu kōng zuòwèi le, tā yìzhí zhàn le yí gè duō xiǎoshí cái dào jiā.', 'Trên xe buýt không còn chỗ trống, anh ấy đứng suốt hơn một tiếng đồng hồ mới về tới nhà.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [笔记本] (bǐjìběn) - vở ghi chép; máy tính xách tay [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '笔记本'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bǐjìběn',
      example_hanzi = '他随身带了一个小笔记本，随时记录生词。',
      example_pinyin = 'Tā suíshēn dài le yí gè xiǎo bǐjìběn, suíshí jìlù shēngcí.',
      example_vi = 'Cậu ấy mang theo một cuốn sổ tay nhỏ bên mình để ghi chép từ mới bất cứ lúc nào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他随身带了一个小笔记本，随时记录生词。', 'Tā suíshēn dài le yí gè xiǎo bǐjìběn, suíshí jìlù shēngcí.', 'Cậu ấy mang theo một cuốn sổ tay nhỏ bên mình để ghi chép từ mới bất cứ lúc nào.', 'basic', 1),
        (v_id, '这部轻薄的笔记本电脑续航时间长，非常适合商务出差。', 'Zhè bù qīngbáo de bǐjìběn diànnǎo xùháng shíjiān cháng, fēicháng shìhé shāngwù chūchāi.', 'Chiếc máy tính xách tay mỏng nhẹ này thời lượng pin lâu, rất thích hợp cho những chuyến công tác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [筷子] (kuàizi) - đũa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '筷子'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kuàizi',
      example_hanzi = '许多刚学中文的外国朋友都在练习使用筷子。',
      example_pinyin = 'Xǔduō gāng xué Zhōngwén de wàiguó péngyou dōu zài liànxí shǐyòng kuàizi.',
      example_vi = 'Nhiều người bạn nước ngoài mới học tiếng Trung đều đang tập dùng đũa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '许多刚学中文的外国朋友都在练习使用筷子。', 'Xǔduō gāng xué Zhōngwén de wàiguó péngyou dōu zài liànxí shǐyòng kuàizi.', 'Nhiều người bạn nước ngoài mới học tiếng Trung đều đang tập dùng đũa.', 'basic', 1),
        (v_id, '一双做工精美的竹筷子既实用又具有中国传统文化特色。', 'Yì shuāng zuògōng jīngměi de zhú kuàizi jì shíyòng yòu jùyǒu Zhōngguó chuántǒng wénhuà tèsè.', 'Một đôi đũa tre được chế tác tinh xảo vừa thiết thực lại vừa mang đậm nét văn hóa truyền thống Trung Hoa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [简单] (jiǎndān) - đơn giản [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '简单'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'jiǎndān',
      example_hanzi = '这个语法规则其实非常简单好懂。',
      example_pinyin = 'Zhè gè yǔfǎ guīzé qíshí fēicháng jiǎndān hǎodǒng.',
      example_vi = 'Quy tắc ngữ pháp này thực ra vô cùng đơn giản dễ hiểu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个语法规则其实非常简单好懂。', 'Zhè gè yǔfǎ guīzé qíshí fēicháng jiǎndān hǎodǒng.', 'Quy tắc ngữ pháp này thực ra vô cùng đơn giản dễ hiểu.', 'basic', 1),
        (v_id, '他喜欢过简单质朴的生活，不追求奢华的物质享受。', 'Tā xǐhuan guò jiǎndān zhìpǔ de shēnghuó, bù zhuīqiú shēhuá de wùzhì xiǎngshòu.', 'Anh ấy thích sống một cuộc đời giản dị mộc mạc, không màng đến những hưởng thụ vật chất xa hoa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [米] (mǐ) - gạo; mét [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '米'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'mǐ',
      example_hanzi = '这座新建的跨海大桥全长超过一千米。',
      example_pinyin = 'Zhè zuò xīnjiàn de kuàhǎi dàqiáo quáncháng chāoguò yìqiān mǐ.',
      example_vi = 'Cây cầu vượt biển mới xây này có tổng chiều dài hơn một nghìn mét.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这座新建的跨海大桥全长超过一千米。', 'Zhè zuò xīnjiàn de kuàhǎi dàqiáo quáncháng chāoguò yìqiān mǐ.', 'Cây cầu vượt biển mới xây này có tổng chiều dài hơn một nghìn mét.', 'basic', 1),
        (v_id, '北方人习惯吃面食，而南方家庭通常顿顿少不了白米饭。', 'Běifāng rén xíguàn chī miànshí, ér nánfāng jiātíng tōngcháng dùndùn shǎobuliǎo bái mǐfàn.', 'Người miền Bắc quen ăn đồ làm từ bột mì, trong khi các gia đình miền Nam thường bữa nào cũng không thể thiếu cơm trắng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [练习] (liànxí) - luyện tập; bài tập [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '练习'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'liànxí',
      example_hanzi = '每天坚持做听力练习对提高汉语水平很有帮助。',
      example_pinyin = 'Měitiān jiānchí zuò tīnglì liànxí duì tígāo Hànyǔ shuǐpíng hěn yǒu bāngzhù.',
      example_vi = 'Hàng ngày kiên trì làm bài luyện nghe rất có ích cho việc nâng cao trình độ tiếng Trung.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天坚持做听力练习对提高汉语水平很有帮助。', 'Měitiān jiānchí zuò tīnglì liànxí duì tígāo Hànyǔ shuǐpíng hěn yǒu bāngzhù.', 'Hàng ngày kiên trì làm bài luyện nghe rất có ích cho việc nâng cao trình độ tiếng Trung.', 'basic', 1),
        (v_id, '课文后面的五道综合练习题请同学们认真完成。', 'Kèwén hòumiàn de wǔ dào zōnghé liànxí tí qǐng tóngxuémen rènzhēn wánchéng.', 'Năm câu bài tập tổng hợp sau bài khóa xin các bạn học hãy nghiêm túc hoàn thành.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [终于] (zhōngyú) - cuối cùng, rốt cuộc [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '终于'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'zhōngyú',
      example_hanzi = '经过三个月的刻苦复习，他终于通过了HSK考试。',
      example_pinyin = 'Jīngguò sān gè yuè de kèkǔ fùxí, tā zhōngyú tōngguò le HSK kǎoshì.',
      example_vi = 'Sau ba tháng ôn tập miệt mài, cuối cùng cậu ấy đã thi đỗ kỳ thi HSK.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过三个月的刻苦复习，他终于通过了HSK考试。', 'Jīngguò sān gè yuè de kèkǔ fùxí, tā zhōngyú tōngguò le HSK kǎoshì.', 'Sau ba tháng ôn tập miệt mài, cuối cùng cậu ấy đã thi đỗ kỳ thi HSK.', 'basic', 1),
        (v_id, '爬了四个小时的山路，我们终于登上了雄伟壮丽的山顶。', 'Pá le sì gè xiǎoshí de shānlù, wǒmen zhōngyú dēngshàng le xióngwěi zhuànglì de shāndǐng.', 'Leo suốt bốn tiếng đường núi, cuối cùng chúng tôi đã đặt chân lên đỉnh núi hùng vĩ tráng lệ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [经理] (jīnglǐ) - giám đốc, quản lý [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '经理'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jīnglǐ',
      example_hanzi = '王经理正在会议室里跟重要客户商谈业务。',
      example_pinyin = 'Wáng jīnglǐ zhèngzài huìyìshì lǐ gēn zhòngyào kèhù shāngtán yèwù.',
      example_vi = 'Giám đốc Vương đang ở trong phòng họp bàn thảo công việc kinh doanh với khách hàng quan trọng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '王经理正在会议室里跟重要客户商谈业务。', 'Wáng jīnglǐ zhèngzài huìyìshì lǐ gēn zhòngyào kèhù shāngtán yèwù.', 'Giám đốc Vương đang ở trong phòng họp bàn thảo công việc kinh doanh với khách hàng quan trọng.', 'basic', 1),
        (v_id, '作为销售部门的经理，她始终以身作则带领团队攻坚克难。', 'Zuòwéi xiāoshòu bùmén de jīnglǐ, tā shǐzhōng yǐshēnzuòzé dàilǐng tuánduì gōngjiān-kènán.', 'Với tư cách là quản lý bộ phận kinh doanh, cô ấy luôn gương mẫu dẫn dắt cả nhóm vượt qua thử thách khó khăn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [经过] (jīngguò) - đi qua; trải qua; quá trình [Động từ / Giới từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '经过'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Giới từ / Danh từ',
      pinyin = 'jīngguò',
      example_hanzi = '每天上学我都会经过那家热闹的面包店。',
      example_pinyin = 'Měitiān shàngxué wǒ dōu huì jīngguò nà jiā rènao de miànbāodiàn.',
      example_vi = 'Mỗi ngày đi học tôi đều đi qua tiệm bánh mì nhộn nhịp đó.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天上学我都会经过那家热闹的面包店。', 'Měitiān shàngxué wǒ dōu huì jīngguò nà jiā rènao de miànbāodiàn.', 'Mỗi ngày đi học tôi đều đi qua tiệm bánh mì nhộn nhịp đó.', 'basic', 1),
        (v_id, '经过多次沟通与耐心协商，双方终于达成了合作协议。', 'Jīngguò duō cì gōutōng yǔ nàixīn xiéshāng, shuāngfāng zhōngyú dáchéng le hézuò xiéyì.', 'Trải qua nhiều lần trao đổi và kiên nhẫn hiệp thương, hai bên rốt cuộc đã đạt được thỏa thuận hợp tác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [结婚] (jiéhūn) - kết hôn, cưới [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '结婚'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiéhūn',
      example_hanzi = '他们打算在今年国庆节举行婚礼结婚。',
      example_pinyin = 'Tāmen dǎsuàn zài jīnnián Guóqìngjié jǔxíng hūnlǐ jiéhūn.',
      example_vi = 'Họ dự định sẽ tổ chức hôn lễ và kết hôn vào dịp Quốc khánh năm nay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他们打算在今年国庆节举行婚礼结婚。', 'Tāmen dǎsuàn zài jīnnián Guóqìngjié jǔxíng hūnlǐ jiéhūn.', 'Họ dự định sẽ tổ chức hôn lễ và kết hôn vào dịp Quốc khánh năm nay.', 'basic', 1),
        (v_id, '他们相识相恋五年后喜结良缘，婚后的生活幸福甜美。', 'Tāmen xiāngshí xiāngliàn wǔ nián hòu xǐjié liángyuán, hūnhòu de shēnghuó xìngfú tiánměi.', 'Sau năm năm quen biết và yêu thương nhau họ đã nên duyên vợ chồng, cuộc sống sau kết hôn thật hạnh phúc ngọt ngào.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [结束] (jiéshù) - kết thúc, chấm dứt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '结束'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiéshù',
      example_hanzi = '今天的期末考试下午五点准时结束。',
      example_pinyin = 'Jīntiān de qīmò kǎoshì xiàwǔ wǔ diǎn zhǔnshí jiéshù.',
      example_vi = 'Kỳ thi học kỳ hôm nay đúng 5 giờ chiều sẽ kết thúc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天的期末考试下午五点准时结束。', 'Jīntiān de qīmò kǎoshì xiàwǔ wǔ diǎn zhǔnshí jiéshù.', 'Kỳ thi học kỳ hôm nay đúng 5 giờ chiều sẽ kết thúc.', 'basic', 1),
        (v_id, '随着裁判哨声响起，这场精彩激烈的足球比赛圆满结束。', 'Suízhe cáipàn shàoshēng xiǎngqǐ, zhè chǎng jīngcǎi jīliè de zúqiú bǐsài yuánmǎn jiéshù.', 'Theo tiếng còi của trọng tài vang lên, trận bóng đá sôi nổi kịch tính này đã kết thúc tốt đẹp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [老] (lǎo) - già, cũ; luôn luôn [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '老'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'lǎo',
      example_hanzi = '尊老爱幼是中华民族的传统美德。',
      example_pinyin = 'Zūn lǎo ài yòu shì Zhōnghuá mínzú de chuántǒng měidé.',
      example_vi = 'Kính già yêu trẻ là nét đẹp đạo đức truyền thống của dân tộc Trung Hoa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '尊老爱幼是中华民族的传统美德。', 'Zūn lǎo ài yòu shì Zhōnghuá mínzú de chuántǒng měidé.', 'Kính già yêu trẻ là nét đẹp đạo đức truyền thống của dân tộc Trung Hoa.', 'basic', 1),
        (v_id, '他是我的老朋友了，虽然好久没见但一见面依然十分亲切。', 'Tā shì wǒ de lǎo péngyou le, suīrán hǎojiǔ méi jiàn dàn yí jiànmiàn yīrán shífēn qīnqiè.', 'Anh ấy là bạn cũ lâu năm của tôi, dẫu lâu ngày chưa gặp nhưng vừa gặp lại vẫn thấy vô cùng thân thiết.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [耳朵] (ěrduo) - tai [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '耳朵'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'ěrduo',
      example_hanzi = '兔子的耳朵长长的，十分惹人喜爱。',
      example_pinyin = 'Tùzi de ěrduo chángcháng de, shífēn rě rén xǐ’ài.',
      example_vi = 'Đôi tai của chú thỏ dài dài, trông vô cùng đáng yêu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '兔子的耳朵长长的，十分惹人喜爱。', 'Tùzi de ěrduo chángcháng de, shífēn rě rén xǐ’ài.', 'Đôi tai của chú thỏ dài dài, trông vô cùng đáng yêu.', 'basic', 1),
        (v_id, '长时间戴耳机听大音量音乐会对耳朵的听力造成损伤。', 'Cháng shíjiān dài ěrjī tīng dà yīnliàng yīnyuè huì duì ěrduo de tīnglì zàochéng sǔnshāng.', 'Đeo tai nghe bật âm lượng lớn trong thời gian dài sẽ gây tổn hại tới thính lực của tai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [聪明] (cōngming) - thông minh [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '聪明'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'cōngming',
      example_hanzi = '这个小男孩非常聪明，学东西一学就会。',
      example_pinyin = 'Zhè gè xiǎonánhái fēicháng cōngming, xué dōngxi yì xué jiù huì.',
      example_vi = 'Cậu bé này rất thông minh, học cái gì cũng chỉ học một lần là biết ngay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个小男孩非常聪明，学东西一学就会。', 'Zhè gè xiǎonánhái fēicháng cōngming, xué dōngxi yì xué jiù huì.', 'Cậu bé này rất thông minh, học cái gì cũng chỉ học một lần là biết ngay.', 'basic', 1),
        (v_id, '他不仅智力超群、聪明机智，而且待人做事非常诚恳谦虚。', 'Tā bùjǐn zhìlì chāoqún, cōngming jīzhì, érqiě dài rén zuò shì fēicháng chéngkěn qiānxū.', 'Anh ấy không chỉ trí tuệ hơn người, thông minh nhanh trí mà đối nhân xử thế cũng vô cùng chân thành khiêm tốn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [胖] (pàng) - béo, mập [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '胖'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'pàng',
      example_hanzi = '他最近胃口很好，吃得有点儿发胖了。',
      example_pinyin = 'Tā zuìjìn wèikǒu hěn hǎo, chī de yǒudiǎnr fāpàng le.',
      example_vi = 'Dạo này ăn uống ngon miệng nên anh ấy hơi mập ra một chút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他最近胃口很好，吃得有点儿发胖了。', 'Tā zuìjìn wèikǒu hěn hǎo, chī de yǒudiǎnr fāpàng le.', 'Dạo này ăn uống ngon miệng nên anh ấy hơi mập ra một chút.', 'basic', 1),
        (v_id, '为了身体健康，他决定少吃油腻食物并坚持每天跑步减肥。', 'Wèile shēntǐ jiànkāng, tā juédìng shǎo chī yóunì shíwù bìng jiānchí měitiān pǎobù jiǎnféi.', 'Để đảm bảo sức khỏe, anh ấy quyết định giảm bớt đồ ăn dầu mỡ và kiên trì chạy bộ giảm cân mỗi ngày.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [脚] (jiǎo) - chân, bàn chân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '脚'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiǎo',
      example_hanzi = '走了一整天路，我的双脚又酸又痛。',
      example_pinyin = 'Zǒu le yì zhěng tiān lù, wǒ de shuāngjiǎo yòu suān yòu tòng.',
      example_vi = 'Đi bộ suốt cả ngày trời, hai bàn chân tôi vừa mỏi vừa đau.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '走了一整天路，我的双脚又酸又痛。', 'Zǒu le yì zhěng tiān lù, wǒ de shuāngjiǎo yòu suān yòu tòng.', 'Đi bộ suốt cả ngày trời, hai bàn chân tôi vừa mỏi vừa đau.', 'basic', 1),
        (v_id, '踢足球前要换上合脚的专业球鞋，以防运动时扭伤脚踝。', 'Tī zúqiú qián yào huàn shàng héjiǎo de zhuānyè qiúxié, yǐfáng yùndòng shí niǔshāng jiǎohuái.', 'Trước khi đá bóng cần thay giày thể thao vừa vặn chân để đề phòng trật mắt cá chân lúc vận động.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [脸] (liǎn) - mặt, gương mặt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '脸'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'liǎn',
      example_hanzi = '早上起床后，第一件事就是洗脸刷牙。',
      example_pinyin = 'Zǎoshang qǐchuáng hòu, dì-yī jiàn shì jiù shì xǐliǎn shuāyá.',
      example_vi = 'Buổi sáng sau khi thức dậy, việc đầu tiên chính là rửa mặt và đánh răng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '早上起床后，第一件事就是洗脸刷牙。', 'Zǎoshang qǐchuáng hòu, dì-yī jiàn shì jiù shì xǐliǎn shuāyá.', 'Buổi sáng sau khi thức dậy, việc đầu tiên chính là rửa mặt và đánh răng.', 'basic', 1),
        (v_id, '听到老师当众表扬自己的进步，她害羞得脸都红了。', 'Tīng dào lǎoshī dāngzhòng biǎoyáng zìjǐ de jìnbù, tā hàixiū de liǎn dōu hóng le.', 'Nghe thầy giáo khen ngợi sự tiến bộ của mình trước lớp, cô bé ngại ngùng đỏ bừng cả mặt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [腿] (tuǐ) - chân, cẳng chân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '腿'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tuǐ',
      example_hanzi = '爷爷年纪大了，两条腿走路不太方便。',
      example_pinyin = 'Yéye niánjì dà le, liǎng tiáo tuǐ zǒulù bú tài fāngbiàn.',
      example_vi = 'Ông tuổi đã cao, hai chân đi lại không còn được thuận tiện lắm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爷爷年纪大了，两条腿走路不太方便。', 'Yéye niánjì dà le, liǎng tiáo tuǐ zǒulù bú tài fāngbiàn.', 'Ông tuổi đã cao, hai chân đi lại không còn được thuận tiện lắm.', 'basic', 1),
        (v_id, '他在昨天的篮球比赛中不慎撞伤了小腿，需要静养两周。', 'Tā zài zuótiān de lánqiú bǐsài zhōng búshèn zhuàngshāng le xiǎotuǐ, xūyào jìngyǎng liǎng zhōu.', 'Trong trận bóng rổ hôm qua anh ấy sơ ý bị va đập đau bắp chân, cần nghỉ ngơi tĩnh dưỡng hai tuần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [自行车] (zìxíngchē) - xe đạp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '自行车'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zìxíngchē',
      example_hanzi = '我每天骑自行车去学校，既环保又能锻炼身体。',
      example_pinyin = 'Wǒ měitiān qí zìxíngchē qù xuéxiào, jì huánbǎo yòu néng duànliàn shēntǐ.',
      example_vi = 'Hàng ngày tôi đều đạp xe đến trường, vừa bảo vệ môi trường lại vừa rèn luyện sức khỏe.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我每天骑自行车去学校，既环保又能锻炼身体。', 'Wǒ měitiān qí zìxíngchē qù xuéxiào, jì huánbǎo yòu néng duànliàn shēntǐ.', 'Hàng ngày tôi đều đạp xe đến trường, vừa bảo vệ môi trường lại vừa rèn luyện sức khỏe.', 'basic', 1),
        (v_id, '城市里随处可见共享自行车，为市民绿色出行提供了极大的便利。', 'Chéngshì lǐ suíchù kějiàn gòngxiǎng zìxíngchē, wèi shìmín lǜsè chūxíng tígōng le jídà de biànlì.', 'Trong thành phố có thể thấy xe đạp công cộng ở khắp nơi, mang lại tiện lợi to lớn cho việc đi lại xanh của người dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [船] (chuán) - thuyền, tàu thủy [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '船'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chuán',
      example_hanzi = '周末我们要坐船去那个美丽的小岛游玩。',
      example_pinyin = 'Zhōumò wǒmen yào zuò chuán qù nà gè měilì de xiǎodǎo yóuwán.',
      example_vi = 'Cuối tuần chúng tôi sẽ đi thuyền ra hòn đảo xinh đẹp kia để tham quan dạo chơi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末我们要坐船去那个美丽的小岛游玩。', 'Zhōumò wǒmen yào zuò chuán qù nà gè měilì de xiǎodǎo yóuwán.', 'Cuối tuần chúng tôi sẽ đi thuyền ra hòn đảo xinh đẹp kia để tham quan dạo chơi.', 'basic', 1),
        (v_id, '夜幕降临，江面上往来的货船亮起了一盏盏温暖明亮的航灯。', 'Yèmù jiànglín, jiāngmiàn shang wǎnglái de huòchuán liàng qǐ le yì zhǎnzhǎn wēnnuǎn míngliàng de hángdēng.', 'Màn đêm buông xuống, những con tàu chở hàng qua lại trên mặt sông thắp lên từng ngọn đèn hoa tiêu ấm áp và sáng tỏ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [节日] (jiérì) - ngày lễ, tết [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '节日'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiérì',
      example_hanzi = '春节是中国最重要的传统节日。',
      example_pinyin = 'Chūnjié shì Zhōngguó zuì zhòngyào de chuántǒng jiérì.',
      example_vi = 'Tết Nguyên Đán là ngày lễ truyền thống quan trọng nhất của Trung Quốc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '春节是中国最重要的传统节日。', 'Chūnjié shì Zhōngguó zuì zhòngyào de chuántǒng jiérì.', 'Tết Nguyên Đán là ngày lễ truyền thống quan trọng nhất của Trung Quốc.', 'basic', 1),
        (v_id, '每逢重大节日，大街小巷都挂满了大红灯笼，洋溢着喜庆祥和的氛围。', 'Měiféng zhòngdà jiérì, dàjiē-xiǎoxiàng dōu guà mǎn le dà hóng dēnglong, yángyì zhe xǐqìng xiánghé de fēnwéi.', 'Mỗi dịp ngày lễ lớn, khắp các phố lớn ngõ nhỏ đều treo đầy đèn lồng đỏ, tràn ngập không khí vui tươi đầm ấm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [节目] (jiémù) - chương trình, tiết mục [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '节目'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiémù',
      example_hanzi = '今晚电视上有一个非常好看的歌舞节目。',
      example_pinyin = 'Jīnwǎn diànshì shang yǒu yí gè fēicháng hǎokàn de gēwǔ jiémù.',
      example_vi = 'Tối nay trên ti vi có một chương trình ca múa nhạc rất hay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今晚电视上有一个非常好看的歌舞节目。', 'Jīnwǎn diànshì shang yǒu yí gè fēicháng hǎokàn de gēwǔ jiémù.', 'Tối nay trên ti vi có một chương trình ca múa nhạc rất hay.', 'basic', 1),
        (v_id, '在新年联欢会上，各国留学生表演了丰富多彩的特色文艺节目。', 'Zài xīnnián liánhuānhuì shang, gèguó liúxuéshēng biǎoyǎn le fēngfù duōcǎi de tèsè wényì jiémù.', 'Tại buổi liên hoan chào năm mới, các lưu học sinh các nước đã biểu diễn những tiết mục văn nghệ đặc sắc phong phú đa dạng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [草] (cǎo) - cỏ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '草'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'cǎo',
      example_hanzi = '春天到了，公园里的草变绿了。',
      example_pinyin = 'Chūntiān dào le, gōngyuán lǐ de cǎo biàn lǜ le.',
      example_vi = 'Mùa xuân đã đến rồi, bãi cỏ trong công viên đã chuyển sang màu xanh mướt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '春天到了，公园里的草变绿了。', 'Chūntiān dào le, gōngyuán lǐ de cǎo biàn lǜ le.', 'Mùa xuân đã đến rồi, bãi cỏ trong công viên đã chuyển sang màu xanh mướt.', 'basic', 1),
        (v_id, '请大家爱护绿化环境，不要随意践踏草坪上的嫩草。', 'Qǐng dàjiā àihù lǜhuà huánjìng, bú yào suíyì jiàntà cǎopíng shang de nèncǎo.', 'Xin mọi người hãy gìn giữ môi trường cây xanh, không giẫm đạp bừa bãi lên lớp cỏ non trên thảm cỏ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [菜单] (càidān) - thực đơn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '菜单'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'càidān',
      example_hanzi = '服务员，请给我们拿一份菜单看一看。',
      example_pinyin = 'Fúwùyuán, qǐng gěi wǒmen ná yí fèn càidān kàn yí kàn.',
      example_vi = 'Phục vụ ơi, xin mang cho chúng tôi một cuốn thực đơn để xem với.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '服务员，请给我们拿一份菜单看一看。', 'Fúwùyuán, qǐng gěi wǒmen ná yí fèn càidān kàn yí kàn.', 'Phục vụ ơi, xin mang cho chúng tôi một cuốn thực đơn để xem với.', 'basic', 1),
        (v_id, '这家川菜馆的菜单上图文并茂，还详细标注了每道菜的辣度等级。', 'Zhè jiā Chuāncàiguǎn de càidān shang túwén-bìngmào, hái xiángxì biāozhù le měi dào cài de làdù děngjí.', 'Thực đơn của quán ăn Tứ Xuyên này có cả hình ảnh lẫn chữ rất sinh động, lại còn ghi rõ cấp độ cay của từng món.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [蓝] (lán) - xanh lam, xanh da trời [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '蓝'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'lán',
      example_hanzi = '今天天气晴朗，蓝蓝的天空上没有一丝白云。',
      example_pinyin = 'Jīntiān tiānqì qínglǎng, lánlán de tiānkōng shang méiyǒu yì sī bái yún.',
      example_vi = 'Hôm nay thời tiết đẹp trời, bầu trời trong xanh không một gợn mây trắng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天天气晴朗，蓝蓝的天空上没有一丝白云。', 'Jīntiān tiānqì qínglǎng, lánlán de tiānkōng shang méiyǒu yì sī bái yún.', 'Hôm nay thời tiết đẹp trời, bầu trời trong xanh không một gợn mây trắng.', 'basic', 1),
        (v_id, '她身穿一件深蓝色的晚礼服，显得优雅大方而且气质非凡。', 'Tā shēn chuān yí jiàn shēnlánsè de wǎnlǐfú, xiǎnde yōuyǎ dàfāng érqiě qìzhì fēifán.', 'Cô ấy mặc một chiếc đầm dạ hội màu xanh lam sẫm, trông vừa thanh lịch trang nhã vừa toát lên khí chất phi phàm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [蛋糕] (dàngāo) - bánh ngọt, bánh ga tô [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '蛋糕'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dàngāo',
      example_hanzi = '妈妈亲手做了一个美味的水果奶油蛋糕。',
      example_pinyin = 'Māma qīnshǒu zuò le yí gè měiwèi de shuǐguǒ nǎiyóu dàngāo.',
      example_vi = 'Mẹ đã tự tay làm một chiếc bánh ga tô kem hoa quả thơm ngon.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '妈妈亲手做了一个美味的水果奶油蛋糕。', 'Māma qīnshǒu zuò le yí gè měiwèi de shuǐguǒ nǎiyóu dàngāo.', 'Mẹ đã tự tay làm một chiếc bánh ga tô kem hoa quả thơm ngon.', 'basic', 1),
        (v_id, '吹灭生日蛋糕上的蜡烛后，他许下了一个美好的新年愿望。', 'Chuī miè shēngrì dàngāo shang de làzhú hòu, tā xǔ xià le yí gè měihǎo de xīnnián yuànwàng.', 'Sau khi thổi tắt nến trên chiếc bánh sinh nhật, cậu ấy đã thầm ước một điều ước năm mới tốt lành.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [衬衫] (chènshān) - áo sơ mi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '衬衫'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chènshān',
      example_hanzi = '去公司面试时，他穿了一件整洁得体的白衬衫。',
      example_pinyin = 'Qù gōngsī miànshì shí, tā chuān le yí jiàn zhěngjié détǐ de bái chènshān.',
      example_vi = 'Khi đến công ty phỏng vấn, anh ấy mặc một chiếc áo sơ mi trắng chỉnh tề vừa vặn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '去公司面试时，他穿了一件整洁得体的白衬衫。', 'Qù gōngsī miànshì shí, tā chuān le yí jiàn zhěngjié détǐ de bái chènshān.', 'Khi đến công ty phỏng vấn, anh ấy mặc một chiếc áo sơ mi trắng chỉnh tề vừa vặn.', 'basic', 1),
        (v_id, '这件纯棉长袖衬衫面料柔软舒适，透气吸汗，穿起来非常合身。', 'Zhè jiàn chúnmián chángxiù chènshān miànliào róuruǎn shūshì, tòuqì xīhàn, chuān qǐlái fēicháng héshēn.', 'Chiếc áo sơ mi dài tay bằng cotton nguyên chất này chất vải mềm mại dễ chịu, thoáng khí thấm mồ hôi, mặc vào rất tôn dáng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [被] (bèi) - bị, được (câu bị động) [Giới từ / Trợ từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '被'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ / Trợ từ',
      pinyin = 'bèi',
      example_hanzi = '放在桌上的牛奶被调皮的小猫打翻了。',
      example_pinyin = 'Fàng zài zhuō shang de niúnǎi bèi tiáopí de xiǎomāo dǎ fān le.',
      example_vi = 'Cốc sữa đặt trên bàn đã bị chú mèo con tinh nghịch gạt đổ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '放在桌上的牛奶被调皮的小猫打翻了。', 'Fàng zài zhuō shang de niúnǎi bèi tiáopí de xiǎomāo dǎ fān le.', 'Cốc sữa đặt trên bàn đã bị chú mèo con tinh nghịch gạt đổ.', 'basic', 1),
        (v_id, '他出色的工作表现受到了公司领导的充分肯定，被评为年度优秀员工。', 'Tā chūsè de gōngzuò biǎoxiàn shòudào le gōngsī lǐngdǎo de chōngfèn kěndìng, bèi píng wèi niándù yōuxiù yuángōng.', 'Thể hiện công việc xuất sắc của anh ấy đã được ban lãnh đạo công ty ghi nhận đầy đủ và được bầu làm nhân viên ưu tú của năm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [裙子] (qúnzi) - váy [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '裙子'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qúnzi',
      example_hanzi = '妹妹今天穿了一条漂亮的红裙子。',
      example_pinyin = 'Mèimei jīntiān chuān le yì tiáo piàoliang de hóng qúnzi.',
      example_vi = 'Hôm nay em gái mặc một chiếc váy màu đỏ xinh xắn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '妹妹今天穿了一条漂亮的红裙子。', 'Mèimei jīntiān chuān le yì tiáo piàoliang de hóng qúnzi.', 'Hôm nay em gái mặc một chiếc váy màu đỏ xinh xắn.', 'basic', 1),
        (v_id, '这条淡雅的碎花长裙非常适合夏天在海边度假散步时穿。', 'Zhè tiáo dànyǎ de suìhuā chángqún fēicháng shìhé xiàtiān zài hǎibiān dùjià sànbù shí chuān.', 'Chiếc đầm dài hoa nhí trang nhã này rất thích hợp mặc khi đi nghỉ mát dạo bước bên bờ biển vào mùa hè.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [西] (xī) - hướng tây, phía tây [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '西'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xī',
      example_hanzi = '太阳每天从东方升起，从西方落下。',
      example_pinyin = 'Tàiyáng měitiān cóng dōngfāng shēngqǐ, cóng xīfāng luòxià.',
      example_vi = 'Mặt trời mỗi ngày đều mọc ở đằng đông và lặn ở đằng tây.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '太阳每天从东方升起，从西方落下。', 'Tàiyáng měitiān cóng dōngfāng shēngqǐ, cóng xīfāng luòxià.', 'Mặt trời mỗi ngày đều mọc ở đằng đông và lặn ở đằng tây.', 'basic', 1),
        (v_id, '学校的体育馆坐落在主教学楼西侧，走几步路就能到。', 'Xuéxiào de tǐyùguǎn zuòluò zài zhǔ jiàoxuélóu xī cè, zǒu jǐ bù lù jiù néng dào.', 'Nhà thi đấu thể dục của trường nằm ở phía tây tòa nhà giảng đường chính, đi vài bước là tới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [西瓜] (xīguā) - dưa hấu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '西瓜'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xīguā',
      example_hanzi = '夏天吃冰镇西瓜又解渴又爽口。',
      example_pinyin = 'Xiàtiān chī bīngzhèn xīguā yòu jiěkě yòu shuǎngkǒu.',
      example_vi = 'Mùa hè ăn dưa hấu ướp lạnh vừa giải khát vừa đã miệng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夏天吃冰镇西瓜又解渴又爽口。', 'Xiàtiān chī bīngzhèn xīguā yòu jiěkě yòu shuǎngkǒu.', 'Mùa hè ăn dưa hấu ướp lạnh vừa giải khát vừa đã miệng.', 'basic', 1),
        (v_id, '爸爸从早市买回来一个又大又圆的大西瓜，切开后果肉鲜红香甜。', 'Bàba cóng zǎoshì mǎi huílái yí gè yòu dà yòu yuán de dà xīguā, qiē kāi hòu guǒròu xiānhóng xiāngtián.', 'Bố đi chợ sớm mua về một quả dưa hấu to tròn, bổ ra ruột đỏ tươi và ngọt lịm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [要求] (yāoqiú) - yêu cầu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '要求'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'yāoqiú',
      example_hanzi = '老师要求大家每天按时完成课外中文作业。',
      example_pinyin = 'Lǎoshī yāoqiú dàjiā měitiān ànshí wánchéng kèwài Zhōngwén zuòyè.',
      example_vi = 'Thầy giáo yêu cầu mọi người mỗi ngày làm bài tập tiếng Trung ngoại khóa đúng giờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师要求大家每天按时完成课外中文作业。', 'Lǎoshī yāoqiú dàjiā měitiān ànshí wánchéng kèwài Zhōngwén zuòyè.', 'Thầy giáo yêu cầu mọi người mỗi ngày làm bài tập tiếng Trung ngoại khóa đúng giờ.', 'basic', 1),
        (v_id, '这家跨国企业招聘时对应聘者的英语交流能力提出了很高的要求。', 'Zhè jiā kuàguó qǐyè zhāopìn shí duì yìngpìnzhě de Yīngyǔ jiāoliú nénglì tíchū le hěn gāo de yāoqiú.', 'Doanh nghiệp đa quốc gia này khi tuyển dụng đã đưa ra yêu cầu rất cao về năng lực giao tiếp tiếng Anh của ứng viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [见面] (jiànmiàn) - gặp mặt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '见面'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiànmiàn',
      example_hanzi = '我们约好明天下午两点在图书馆门口见面。',
      example_pinyin = 'Wǒmen yuē hǎo míngtiān xiàwǔ liǎng diǎn zài túshūguǎn ménkǒu jiànmiàn.',
      example_vi = 'Chúng tôi hẹn nhau 2 giờ chiều mai gặp mặt ở cổng thư viện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们约好明天下午两点在图书馆门口见面。', 'Wǒmen yuē hǎo míngtiān xiàwǔ liǎng diǎn zài túshūguǎn ménkǒu jiànmiàn.', 'Chúng tôi hẹn nhau 2 giờ chiều mai gặp mặt ở cổng thư viện.', 'basic', 1),
        (v_id, '多年未见的老同学再次见面时，大家都激动得热泪盈眶。', 'Duō nián wèi jiàn de lǎo tóngxué zàicì jiànmiàn shí, dàjiā dōu jīdòng de rèlèi yíngkuàng.', 'Khi những người bạn học lâu năm không gặp lại có dịp hội ngộ, ai nấy đều xúc động rưng rưng nước mắt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [角] (jiǎo) - hào (tiền); góc; sừng [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '角'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'jiǎo',
      example_hanzi = '这支铅笔只要八角钱，非常便宜。',
      example_pinyin = 'Zhè zhī qiānbǐ zhǐ yào bā jiǎo qián, fēicháng piányi.',
      example_vi = 'Chiếc bút chì này chỉ có tám hào thôi, rất rẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这支铅笔只要八角钱，非常便宜。', 'Zhè zhī qiānbǐ zhǐ yào bā jiǎo qián, fēicháng piányi.', 'Chiếc bút chì này chỉ có tám hào thôi, rất rẻ.', 'basic', 1),
        (v_id, '房间的一角整齐地摆放着一张小书桌和一台台灯。', 'Fángjiān de yì jiǎo zhěngqí de bǎifàng zhe yì zhāng xiǎo shūzhuō hé yì tái táidēng.', 'Ở một góc căn phòng bài trí gọn gàng một chiếc bàn học nhỏ và một ngọn đèn bàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [解决] (jiějué) - giải quyết [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '解决'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiějué',
      example_hanzi = '遇到了难题，我们应该想办法尽快解决。',
      example_pinyin = 'Yùdào le nántí, wǒmen yīnggāi xiǎng bànfǎ jǐnkuài jiějué.',
      example_vi = 'Gặp phải vấn đề khó khăn, chúng ta nên nghĩ cách giải quyết càng sớm càng tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '遇到了难题，我们应该想办法尽快解决。', 'Yùdào le nántí, wǒmen yīnggāi xiǎng bànfǎ jǐnkuài jiějué.', 'Gặp phải vấn đề khó khăn, chúng ta nên nghĩ cách giải quyết càng sớm càng tốt.', 'basic', 1),
        (v_id, '通过大家的群策群力与共同探讨，困扰团队已久的技术难题终于得到了妥善解决。', 'Tōngguò dàjiā de qúncè-qúnlì yǔ gòngtóng tàntǎo, kùnrǎo tuánduì yǐjiǔ de jìshù nántí zhōngyú dédào le tuǒshàn jiějué.', 'Nhờ trí tuệ tập thể và sự cùng nhau thảo luận, bài toán kỹ thuật làm trăn trở đội ngũ bấy lâu nay cuối cùng đã được giải quyết thỏa đáng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [认为] (rènwéi) - cho rằng, nghĩ rằng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '认为'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'rènwéi',
      example_hanzi = '我认为这个方案切实可行，值得尝试。',
      example_pinyin = 'Wǒ rènwéi zhè gè fāng’àn qièshí kěxíng, zhídé chángshì.',
      example_vi = 'Tôi cho rằng phương án này thực sự khả thi, rất đáng để thử.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我认为这个方案切实可行，值得尝试。', 'Wǒ rènwéi zhè gè fāng’àn qièshí kěxíng, zhídé chángshì.', 'Tôi cho rằng phương án này thực sự khả thi, rất đáng để thử.', 'basic', 1),
        (v_id, '许多教育专家普遍认为，培养孩子的良好阅读习惯对其终身成长至关重要。', 'Xǔduō jiàoyù zhuānjiā pǔbiàn rènwéi, péiyǎng háizi de liánghǎo yuèdú xíguàn duì qí zhōngshēn chéngzhǎng zhìguān zhòngyào.', 'Nhiều chuyên gia giáo dục nhìn chung đều cho rằng, rèn luyện thói quen đọc sách tốt cho con trẻ có tầm quan trọng sống còn đối với sự phát triển suốt đời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [认真] (rènzhēn) - nghiêm túc, chăm chỉ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '认真'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'rènzhēn',
      example_hanzi = '上课时同学们都在认真听老师讲课。',
      example_pinyin = 'Shàngkè shí tóngxuémen dōu zài rènzhēn tīng lǎoshī jiǎngkè.',
      example_vi = 'Trong giờ học các bạn đều đang chăm chú nghiêm túc nghe thầy giáo giảng bài.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '上课时同学们都在认真听老师讲课。', 'Shàngkè shí tóngxuémen dōu zài rènzhēn tīng lǎoshī jiǎngkè.', 'Trong giờ học các bạn đều đang chăm chú nghiêm túc nghe thầy giáo giảng bài.', 'basic', 1),
        (v_id, '他对待每一项工作任务都极其认真负责，赢得了客户与同事的一致信赖。', 'Tā duìdài měi yí xiàng gōngzuò rènwu dōu jíqí rènzhēn fùzé, yíngdé le kèhù yǔ tóngshì de yízhì xìnlài.', 'Anh ấy đối với bất kỳ nhiệm vụ công việc nào cũng vô cùng nghiêm túc có trách nhiệm, giành được sự tin cậy tuyệt đối của khách hàng và đồng nghiệp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [讲] (jiǎng) - nói, kể, giảng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '讲'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiǎng',
      example_hanzi = '奶奶正在客厅里给小孙子讲有趣的童话故事。',
      example_pinyin = 'Nǎinai zhèngzài kètīng lǐ gěi xiǎo sūnzi jiǎng yǒuqù de tónghuà gùshì.',
      example_vi = 'Bà nội đang ở trong phòng khách kể chuyện cổ tích thú vị cho cháu trai nhỏ nghe.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '奶奶正在客厅里给小孙子讲有趣的童话故事。', 'Nǎinai zhèngzài kètīng lǐ gěi xiǎo sūnzi jiǎng yǒuqù de tónghuà gùshì.', 'Bà nội đang ở trong phòng khách kể chuyện cổ tích thú vị cho cháu trai nhỏ nghe.', 'basic', 1),
        (v_id, '李教授用生动通俗的语言给大家讲解了深奥复杂的科学原理。', 'Lǐ jiàoshòu yòng shēngdòng tōngsú de yǔyán gěi dàjiā jiǎngjiě le shēn’ào fùzá de kēxué yuánlǐ.', 'Giáo sư Lý đã dùng ngôn ngữ sinh động dễ hiểu để giảng giải cho mọi người những nguyên lý khoa học sâu xa phức tạp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [词典] (cídiǎn) - từ điển [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '词典'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'cídiǎn',
      example_hanzi = '遇到不认识的生词，你可以查一查这本词典。',
      example_pinyin = 'Yùdào bù rènshi de shēngcí, nǐ kěyǐ chá yì chá zhè běn cídiǎn.',
      example_vi = 'Gặp từ mới không biết, bạn có thể tra cứu cuốn từ điển này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '遇到不认识的生词，你可以查一查这本词典。', 'Yùdào bù rènshi de shēngcí, nǐ kěyǐ chá yì chá zhè běn cídiǎn.', 'Gặp từ mới không biết, bạn có thể tra cứu cuốn từ điển này.', 'basic', 1),
        (v_id, '这本现代汉语词典内容收录全面，是学习中文不可或缺的实用工具书。', 'Zhè běn xiàndài Hànyǔ cídiǎn nèiróng shōulù quánmiàn, shì xuéxí Zhōngwén bù kě huò quē de shíyòng gōngjùshū.', 'Cuốn từ điển Hán ngữ hiện đại này thu thập nội dung toàn diện, là sách công cụ thiết thực không thể thiếu khi học tiếng Trung.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [试] (shì) - thử, làm thử [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '试'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shì',
      example_hanzi = '这件外套款式很漂亮，你可以去试衣间试穿一下。',
      example_pinyin = 'Zhè jiàn wàitào kuǎnshì hěn piàoliang, nǐ kěyǐ qù shìyījiān shìchuān yíxià.',
      example_vi = 'Kiểu dáng chiếc áo khoác này rất đẹp, bạn có thể vào phòng thử đồ mặc thử xem sao.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这件外套款式很漂亮，你可以去试衣间试穿一下。', 'Zhè jiàn wàitào kuǎnshì hěn piàoliang, nǐ kěyǐ qù shìyījiān shìchuān yíxià.', 'Kiểu dáng chiếc áo khoác này rất đẹp, bạn có thể vào phòng thử đồ mặc thử xem sao.', 'basic', 1),
        (v_id, '不要害怕失败，勇于尝试新事物才能不断发现自己的潜能。', 'Bú yào hàipà shībài, yǒngyú chángshì xīn shìwù cái néng búduàn fāxiàn zìjǐ de qiánnéng.', 'Đừng sợ thất bại, dũng cảm thử nghiệm những điều mới mẻ thì mới không ngừng phát hiện ra tiềm năng của chính mình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [请假] (qǐngjià) - xin nghỉ phép [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '请假'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'qǐngjià',
      example_hanzi = '他今天身体不太舒服，向公司请假了一天。',
      example_pinyin = 'Tā jīntiān shēntǐ bú tài shūfu, xiàng gōngsī qǐngjià le yì tiān.',
      example_vi = 'Hôm nay trong người không được khỏe, cậu ấy đã xin công ty nghỉ phép một ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他今天身体不太舒服，向公司请假了一天。', 'Tā jīntiān shēntǐ bú tài shūfu, xiàng gōngsī qǐngjià le yì tiān.', 'Hôm nay trong người không được khỏe, cậu ấy đã xin công ty nghỉ phép một ngày.', 'basic', 1),
        (v_id, '由于家里突发急事，他提前在考勤系统上提交了请假申请。', 'Yóuyú jiālǐ tūfā jíshì, tā tíqián zài kǎoqín xìtǒng shang tíjiāo le qǐngjià shēnqǐng.', 'Do gia đình có việc đột xuất, anh ấy đã nộp đơn xin nghỉ phép từ trước trên hệ thống chấm công.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [起飞] (qǐfēi) - cất cánh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '起飞'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'qǐfēi',
      example_hanzi = '各位乘客请注意，飞往北京的航班马上就要起飞了。',
      example_pinyin = 'Gèwèi chéngkè qǐng zhùyì, fēi wǎng Běijīng de hángbān mǎshàng jiù yào qǐfēi le.',
      example_vi = 'Xin quý hành khách chú ý, chuyến bay đi Bắc Kinh sắp sửa cất cánh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '各位乘客请注意，飞往北京的航班马上就要起飞了。', 'Gèwèi chéngkè qǐng zhùyì, fēi wǎng Běijīng de hángbān mǎshàng jiù yào qǐfēi le.', 'Xin quý hành khách chú ý, chuyến bay đi Bắc Kinh sắp sửa cất cánh.', 'basic', 1),
        (v_id, '飞机起飞和降落时，请所有乘客系好安全带并关闭电子设备。', 'Fēijī qǐfēi hé jiàngluò shí, qǐng suǒyǒu chéngkè jì hǎo ānquándài bìng guānbì diànzǐ shèbèi.', 'Khi máy bay cất cánh và hạ cánh, xin tất cả hành khách thắt dây an toàn và tắt các thiết bị điện tử.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [越] (yuè) - càng; vượt qua [Phó từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '越'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Động từ',
      pinyin = 'yuè',
      example_hanzi = '随着练习的增加，他的中文说得越来越流利了。',
      example_pinyin = 'Suízhe liànxí de zēngjiā, tā de Zhōngwén shuō de yuè lái yuè liúlì le.',
      example_vi = 'Cùng với sự tăng cường luyện tập, tiếng Trung của cậu ấy nói ngày càng lưu loát.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着练习的增加，他的中文说得越来越流利了。', 'Suízhe liànxí de zēngjiā, tā de Zhōngwén shuō de yuè lái yuè liúlì le.', 'Cùng với sự tăng cường luyện tập, tiếng Trung của cậu ấy nói ngày càng lưu loát.', 'basic', 1),
        (v_id, '雨越下越大，路上的行人都纷纷撑起了雨伞。', 'Yǔ yuè xià yuè dà, lù shang de xíngrén dōu fēnfēn chēng qǐ le yǔsǎn.', 'Mưa càng rơi càng nặng hạt, người đi đường ai nấy đều vội vàng bung dù che mưa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [辆] (liàng) - chiếc, xe (lượng từ xe cộ) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '辆'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'liàng',
      example_hanzi = '院子里停着一辆崭新的红色小轿车。',
      example_pinyin = 'Yuànzi lǐ tíng zhe yí liàng zhǎnxīn de hóngsè xiǎojiàochē.',
      example_vi = 'Trong sân đang đỗ một chiếc xe con màu đỏ mới toanh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '院子里停着一辆崭新的红色小轿车。', 'Yuànzi lǐ tíng zhe yí liàng zhǎnxīn de hóngsè xiǎojiàochē.', 'Trong sân đang đỗ một chiếc xe con màu đỏ mới toanh.', 'basic', 1),
        (v_id, '公司为了方便员工上下班通勤，特意购置了两辆大型班车。', 'Gōngsī wèile fāngbiàn yuángōng shàng-xiàbān tōngqín, tèyì gòuzhì le liǎng liàng dàxíng bānchē.', 'Nhằm tạo thuận tiện cho nhân viên đi làm hàng ngày, công ty đã đặc biệt mua sắm hai chiếc xe đưa đón cỡ lớn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [过去] (guòqù) - quá khứ, trước đây; đi qua [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '过去'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'guòqù',
      example_hanzi = '过去这里是一片农田，现在建成了繁华的商业区。',
      example_pinyin = 'Guòqù zhèlǐ shì yí piàn nóngtián, xiànzài jiànchéng le fánhuá de shāngyèqū.',
      example_vi = 'Trước đây nơi này là một vùng ruộng đồng, nay đã xây thành khu thương mại sầm uất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '过去这里是一片农田，现在建成了繁华的商业区。', 'Guòqù zhèlǐ shì yí piàn nóngtián, xiànzài jiànchéng le fánhuá de shāngyèqū.', 'Trước đây nơi này là một vùng ruộng đồng, nay đã xây thành khu thương mại sầm uất.', 'basic', 1),
        (v_id, '过去的事情就让它过去吧，我们要积极面对充满希望的未来。', 'Guòqù de shìqing jiù ràng tā guòqù ba, wǒmen yào jījí miànduì chōngmǎn xīwàng de wèilái.', 'Chuyện trong quá khứ hãy để nó trôi qua đi, chúng ta cần tích cực hướng tới tương lai tràn ngập hy vọng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [迟到] (chídào) - đến muộn, đi trễ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '迟到'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'chídào',
      example_hanzi = '因为路上遇到严重堵车，他上班迟到了十五分钟。',
      example_pinyin = 'Yīnwèi lù shang yùdào yánzhòng dǔchē, tā shàngbān chídào le shíwǔ fēnzhōng.',
      example_vi = 'Bởi vì trên đường gặp tắc xe nghiêm trọng, anh ấy đã đi làm muộn mười lăm phút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '因为路上遇到严重堵车，他上班迟到了十五分钟。', 'Yīnwèi lù shang yùdào yánzhòng dǔchē, tā shàngbān chídào le shíwǔ fēnzhōng.', 'Bởi vì trên đường gặp tắc xe nghiêm trọng, anh ấy đã đi làm muộn mười lăm phút.', 'basic', 1),
        (v_id, '养成守时的好习惯非常重要，任何正式场合都尽量不要迟到。', 'Yǎngchéng shǒushí de hǎo xíguàn fēicháng zhòngyào, rènhé zhèngshì chǎnghé dōu jǐnliàng bú yào chídào.', 'Hình thành thói quen tốt đúng giờ là điều hết sức quan trọng, trong mọi dịp trang trọng đều nên cố gắng không đi trễ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [选择] (xuǎnzé) - lựa chọn, chọn lựa [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '选择'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'xuǎnzé',
      example_hanzi = '面对这么多好吃的菜，我真不知道该选择哪一个。',
      example_pinyin = 'Miànduì zhème duō hǎochī de cài, wǒ zhēn bù zhīdào gāi xuǎnzé nǎ yí gè.',
      example_vi = 'Đứng trước nhiều món ngon như thế này, tôi thực sự chẳng biết nên chọn món nào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '面对这么多好吃的菜，我真不知道该选择哪一个。', 'Miànduì zhème duō hǎochī de cài, wǒ zhēn bù zhīdào gāi xuǎnzé nǎ yí gè.', 'Đứng trước nhiều món ngon như thế này, tôi thực sự chẳng biết nên chọn món nào.', 'basic', 1),
        (v_id, '毕业后是继续攻读硕士还是直接步入职场，是一个需要深思熟虑的重大选择。', 'Bìyè hòu shì jìxù gōngdú shuòshì háishì zhíjiē bùrù zhíchǎng, shì yí gè xūyào shēnsī-shúlǜ de zhòngdà xuǎnzé.', 'Sau khi tốt nghiệp nên học tiếp thạc sĩ hay đi làm ngay là một lựa chọn hệ trọng cần suy xét thấu đáo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [遇到] (yùdào) - gặp, bắt gặp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '遇到'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'yùdào',
      example_hanzi = '昨天在去图书馆的路上，我碰巧遇到了多年未见的小学同学。',
      example_pinyin = 'Zuótiān zài qù túshūguǎn de lù shang, wǒ pèngqiǎo yùdào le duō nián wèi jiàn de xiǎoxué tóngxué.',
      example_vi = 'Hôm qua trên đường tới thư viện, tôi tình cờ gặp lại người bạn tiểu học nhiều năm chưa gặp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '昨天在去图书馆的路上，我碰巧遇到了多年未见的小学同学。', 'Zuótiān zài qù túshūguǎn de lù shang, wǒ pèngqiǎo yùdào le duō nián wèi jiàn de xiǎoxué tóngxué.', 'Hôm qua trên đường tới thư viện, tôi tình cờ gặp lại người bạn tiểu học nhiều năm chưa gặp.', 'basic', 1),
        (v_id, '在学习和人生的道路上遇到困难并不可怕，关键是要保持坚韧的毅力。', 'Zài xuéxí hé rénshēng de dàolù shang yùdào kùnnan bìng bù kěpà, guānjiàn shì yào bǎochí jiānrèn de yìlì.', 'Trên con đường học tập và đường đời gặp phải khó khăn không hề đáng sợ, then chốt là phải giữ được ý chí kiên định.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [邻居] (línjū) - hàng xóm, láng giềng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '邻居'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'línjū',
      example_hanzi = '我家隔壁住着一位非常热心友善的老邻居。',
      example_pinyin = 'Wǒ jiā gébì zhù zhe yí wèi fēicháng rèxīn yǒushàn de lǎo línjū.',
      example_vi = 'Sát vách nhà tôi có một người hàng xóm lớn tuổi rất nhiệt tình và tốt bụng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我家隔壁住着一位非常热心友善的老邻居。', 'Wǒ jiā gébì zhù zhe yí wèi fēicháng rèxīn yǒushàn de lǎo línjū.', 'Sát vách nhà tôi có một người hàng xóm lớn tuổi rất nhiệt tình và tốt bụng.', 'basic', 1),
        (v_id, '俗话说“远亲不如近邻”，平时邻里之间应该互帮互助、和睦相处。', 'Súhuà shuō “yuǎnqīn bùrú jìnlín”, píngshí línlǐ zhījiān yīnggāi hùbāng-hùzhù, hémù xiāngchǔ.', 'Tục ngữ có câu "Bán anh em xa mua láng giềng gần", ngày thường bà con xóm giềng nên tương trợ và sống chan hòa với nhau.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [重要] (zhòngyào) - quan trọng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '重要'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'zhòngyào',
      example_hanzi = '保持规律的作息时间对身体健康非常重要。',
      example_pinyin = 'Bǎochí guīlǜ de zuòxī shíjiān duì shēntǐ jiànkāng fēicháng zhòngyào.',
      example_vi = 'Duy trì giờ giấc sinh hoạt điều độ rất quan trọng đối với sức khỏe.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '保持规律的作息时间对身体健康非常重要。', 'Bǎochí guīlǜ de zuòxī shíjiān duì shēntǐ jiànkāng fēicháng zhòngyào.', 'Duy trì giờ giấc sinh hoạt điều độ rất quan trọng đối với sức khỏe.', 'basic', 1),
        (v_id, '这份合同关系到整个项目的成败，是一个非常重要的商业文件。', 'Zhè fèn hétong guānxì dào zhěnggè xiàngmù de chéngbài, shì yí gè fēicháng zhòngyào de shāngyè wénjiàn.', 'Bản hợp đồng này liên quan trực tiếp đến sự thành bại của cả dự án, là một tài liệu thương mại vô cùng quan trọng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [铅笔] (qiānbǐ) - bút chì [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '铅笔'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qiānbǐ',
      example_hanzi = '小弟弟正在用铅笔在画纸上认真地画小动物。',
      example_pinyin = 'Xiǎo dìdi zhèngzài yòng qiānbǐ zài huàzhǐ shang rènzhēn de huà xiǎo dòngwù.',
      example_vi = 'Em trai nhỏ đang dùng bút chì chăm chú vẽ con vật nhỏ lên tờ giấy vẽ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小弟弟正在用铅笔在画纸上认真地画小动物。', 'Xiǎo dìdi zhèngzài yòng qiānbǐ zài huàzhǐ shang rènzhēn de huà xiǎo dòngwù.', 'Em trai nhỏ đang dùng bút chì chăm chú vẽ con vật nhỏ lên tờ giấy vẽ.', 'basic', 1),
        (v_id, '参加标准化考试涂答题卡时，务必使用正规的2B铅笔。', 'Cānjiā biāozhǔnhuà kǎoshì tú dǎtíkǎ shí, wùbì shǐyòng zhèngguī de 2B qiānbǐ.', 'Khi tham gia thi chuẩn hóa tô phiếu trả lời, nhất định phải dùng bút chì 2B đạt chuẩn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [银行] (yínháng) - ngân hàng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '银行'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yínháng',
      example_hanzi = '我家附近有一家中国银行，存取现金都很方便。',
      example_pinyin = 'Wǒ jiā fùjìn yǒu yì jiā Zhōngguó Yínháng, cún qǔ xiànjīn dōu hěn fāngbiàn.',
      example_vi = 'Gần nhà tôi có một chi nhánh Ngân hàng Trung Quốc, gửi hay rút tiền mặt đều rất thuận tiện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我家附近有一家中国银行，存取现金都很方便。', 'Wǒ jiā fùjìn yǒu yì jiā Zhōngguó Yínháng, cún qǔ xiànjīn dōu hěn fāngbiàn.', 'Gần nhà tôi có một chi nhánh Ngân hàng Trung Quốc, gửi hay rút tiền mặt đều rất thuận tiện.', 'basic', 1),
        (v_id, '随着手机网银的普及，大部分银行转账业务都可以随时在线完成。', 'Suízhe shǒujī wǎngyín de pǔjí, dà bùfen yínháng zhuǎnzhàng yèwù dōu kěyǐ suíshí zàixiàn wánchéng.', 'Cùng với sự phổ biến của ngân hàng điện tử trên điện thoại, phần lớn các giao dịch chuyển khoản ngân hàng đều có thể thực hiện trực tuyến mọi lúc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [锻炼] (duànliàn) - rèn luyện, tập luyện [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '锻炼'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'duànliàn',
      example_hanzi = '每天清晨到公园慢跑半小时是他多年坚持的锻炼习惯。',
      example_pinyin = 'Měitiān qīngchén dào gōngyuán mànpǎo bàn xiǎoshí shì tā duō nián jiānchí de duànliàn xíguàn.',
      example_vi = 'Mỗi sáng sớm ra công viên chạy bộ nửa tiếng là thói quen rèn luyện mà anh ấy kiên trì nhiều năm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天清晨到公园慢跑半小时是他多年坚持的锻炼习惯。', 'Měitiān qīngchén dào gōngyuán mànpǎo bàn xiǎoshí shì tā duō nián jiānchí de duànliàn xíguàn.', 'Mỗi sáng sớm ra công viên chạy bộ nửa tiếng là thói quen rèn luyện mà anh ấy kiên trì nhiều năm.', 'basic', 1),
        (v_id, '积极参与社会实践活动不仅能开阔眼界，更能全面锻炼同学们的沟通协作能力。', 'Jījí cānyù shèhuì shíjiàn huódòng bùjǐn néng kāikuò yǎnjiè, gèng néng quánmiàn duànliàn tóngxuémen de gōutōng xiézuò nénglì.', 'Tích cực tham gia hoạt động thực tế xã hội không chỉ mở rộng tầm mắt mà còn rèn luyện toàn diện năng lực giao tiếp và phối hợp nhóm của các bạn học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [长] (cháng) - dài [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '长'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'cháng',
      example_hanzi = '中国万里长城是世界上最长、最著名的人类古代建筑之一。',
      example_pinyin = 'Zhōngguó Wànlǐ Chángchéng shì shìjiè shang zuì cháng, zuì zhùmíng de rénlèi gǔdài jiànzhù zhī yī.',
      example_vi = 'Vạn Lý Trường Thành của Trung Quốc là một trong những công trình kiến trúc cổ đại dài nhất và nổi tiếng nhất thế giới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国万里长城是世界上最长、最著名的人类古代建筑之一。', 'Zhōngguó Wànlǐ Chángchéng shì shìjiè shang zuì cháng, zuì zhùmíng de rénlèi gǔdài jiànzhù zhī yī.', 'Vạn Lý Trường Thành của Trung Quốc là một trong những công trình kiến trúc cổ đại dài nhất và nổi tiếng nhất thế giới.', 'basic', 1),
        (v_id, '经过长达几个月的刻苦备考，他最终以优异成绩考取了理想的大学。', 'Jīngguò cháng dá jǐ gè yuè de kèkǔ bèikǎo, tā zuìzhōng yǐ yōuyì chéngjì kǎoqǔ le lǐxiǎng de dàxué.', 'Trải qua mấy tháng ròng ôn thi vất vả, cuối cùng cậu ấy đã thi đỗ vào ngôi trường đại học hằng mơ ước với thành tích xuất sắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [阿姨] (āyí) - dì, cô, bác gái [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '阿姨'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'āyí',
      example_hanzi = '李阿姨每次见到我们都笑眯眯地打招呼，非常和蔼。',
      example_pinyin = 'Lǐ āyí měi cì jiàndào wǒmen dōu xiàomīmī de dǎzhāohu, fēicháng hé’ǎi.',
      example_vi = 'Dì Lý mỗi lần gặp chúng tôi đều cười tươi chào hỏi, rất đỗi hiền từ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '李阿姨每次见到我们都笑眯眯地打招呼，非常和蔼。', 'Lǐ āyí měi cì jiàndào wǒmen dōu xiàomīmī de dǎzhāohu, fēicháng hé’ǎi.', 'Dì Lý mỗi lần gặp chúng tôi đều cười tươi chào hỏi, rất đỗi hiền từ.', 'basic', 1),
        (v_id, '周末邻居王阿姨常常给社区里的小朋友们烘焙美味可口的饼干蛋糕。', 'Zhōumò línjū Wáng āyí chángcháng gěi shèqū lǐ de xiǎopéngyoumen hōngbèi měiwèi-kěkǒu de bǐnggān dàngāo.', 'Cuối tuần bác gái Vương hàng xóm thường làm những mẻ bánh quy bánh ngọt thơm ngon cho các em nhỏ trong khu phố.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [附近] (fùjìn) - gần đây, lân cận [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '附近'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fùjìn',
      example_hanzi = '请问这附近有没有大型超市或药店？',
      example_pinyin = 'Qǐngwèn zhè fùjìn yǒu méiyǒu dàxíng chāoshì huò yàodiàn?',
      example_vi = 'Xin hỏi gần đây có siêu thị lớn hay hiệu thuốc nào không?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请问这附近有没有大型超市或药店？', 'Qǐngwèn zhè fùjìn yǒu méiyǒu dàxíng chāoshì huò yàodiàn?', 'Xin hỏi gần đây có siêu thị lớn hay hiệu thuốc nào không?', 'basic', 1),
        (v_id, '学校附近交通四通八达，周边餐馆和便利店林立，生活极为便利。', 'Xuéxiào fùjìn jiāotōng sìtōng-bādá, zhōubiān cānguǎn hé biànlìdiàn línlì, shēnghuó jíwéi biànlì.', 'Giao thông xung quanh trường học đi lại muôn nẻo thuận tiện, hàng quán và cửa hàng tiện lợi san sát, đời sống vô cùng tiện nghi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [除了] (chúle) - ngoài ra, trừ ra [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '除了'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'chúle',
      example_hanzi = '除了星期天以外，图书馆每天都对外开放。',
      example_pinyin = 'Chúle xīngqītiān yǐwài, túshūguǎn měitiān dōu duìwài kāifàng.',
      example_vi = 'Ngoại trừ ngày Chủ nhật, thư viện mở cửa đón bạn đọc mỗi ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '除了星期天以外，图书馆每天都对外开放。', 'Chúle xīngqītiān yǐwài, túshūguǎn měitiān dōu duìwài kāifàng.', 'Ngoại trừ ngày Chủ nhật, thư viện mở cửa đón bạn đọc mỗi ngày.', 'basic', 1),
        (v_id, '除了精通汉语，她还能非常流利地用英语和日语进行商务洽谈。', 'Chúle jīngtōng Hànyǔ, tā hái néng fēicháng liúlì de yòng Yīngyǔ hé Rìyǔ jìnxíng shāngwù qiàtán.', 'Ngoài việc tinh thông tiếng Trung, cô ấy còn có thể dùng tiếng Anh và tiếng Nhật đàm phán thương mại rất lưu loát.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [难] (nán) - khó [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '难'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'nán',
      example_hanzi = '汉字虽然笔画比较多，但只要掌握了偏旁部首就不难学。',
      example_pinyin = 'Hànzì suīrán bǐhuà bǐjiào duō, dàn zhǐyào zhǎngwò le piānpáng-bùshǒu jiù bù nán xué.',
      example_vi = 'Chữ Hán tuy khá nhiều nét, nhưng chỉ cần nắm vững bộ thủ thì học không khó.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '汉字虽然笔画比较多，但只要掌握了偏旁部首就不难学。', 'Hànzì suīrán bǐhuà bǐjiào duō, dàn zhǐyào zhǎngwò le piānpáng-bùshǒu jiù bù nán xué.', 'Chữ Hán tuy khá nhiều nét, nhưng chỉ cần nắm vững bộ thủ thì học không khó.', 'basic', 1),
        (v_id, '“天下无难事，只怕有心人”，只要坚持到底就一定能克服难关。', '“Tiānxià wú nánshì, zhǐ pà yǒuxīnrén”, zhǐyào jiānchí dàodǐ jiù yídìng néng kèfú nánguān.', '"Không có việc gì khó, chỉ sợ lòng không bền", chỉ cần kiên trì đến cùng thì nhất định vượt qua mọi thử thách.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [难过] (nánguò) - buồn bã, đau lòng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '难过'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'nánguò',
      example_hanzi = '听到宠物小狗生病的消息，妹妹心里非常难过。',
      example_pinyin = 'Tīng dào chǒngwù xiǎogǒu shēngbìng de xiāoxi, mèimei xīnlǐ fēicháng nánguò.',
      example_vi = 'Nghe tin chú chó cưng bị ốm, em gái trong lòng rất buồn bã.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到宠物小狗生病的消息，妹妹心里非常难过。', 'Tīng dào chǒngwù xiǎogǒu shēngbìng de xiāoxi, mèimei xīnlǐ fēicháng nánguò.', 'Nghe tin chú chó cưng bị ốm, em gái trong lòng rất buồn bã.', 'basic', 1),
        (v_id, '好朋友马上就要回国了，离别之际大家心里都依依不舍，十分难过。', 'Hǎo péngyou mǎshàng jiù yào huíguó le, líbié zhī jì dàjiā xīnlǐ dōu yīyī-bùshě, shífēn nánguò.', 'Bạn tốt sắp phải về nước rồi, trong giờ phút chia ly ai nấy đều bịn rịn không nỡ rời xa, vô cùng ngậm ngùi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [需要] (xūyào) - cần, nhu cầu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '需要'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'xūyào',
      example_hanzi = '如果你在学习上有任何问题，需要帮助请随时告诉我。',
      example_pinyin = 'Rúguǒ nǐ zài xuéxí shang yǒu rènhé wèntí, xūyào bāngzhù qǐng suíshí gàosu wǒ.',
      example_vi = 'Nếu bạn có bất cứ vấn đề gì trong học tập và cần sự giúp đỡ thì hãy báo cho tôi biết bất cứ lúc nào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如果你在学习上有任何问题，需要帮助请随时告诉我。', 'Rúguǒ nǐ zài xuéxí shang yǒu rènhé wèntí, xūyào bāngzhù qǐng suíshí gàosu wǒ.', 'Nếu bạn có bất cứ vấn đề gì trong học tập và cần sự giúp đỡ thì hãy báo cho tôi biết bất cứ lúc nào.', 'basic', 1),
        (v_id, '掌握一门流利的外语需要长期的日常积累与持之以恒的口语练习。', 'Zhǎngwò yì mén liúlì de wàiyǔ xūyào chángqī de rìcháng jīlěi yǔ chízhīyǐhéng de kǒuyǔ liànxí.', 'Để làm chủ một ngoại ngữ lưu loát đòi hỏi sự tích lũy thường nhật lâu dài và sự kiên trì luyện tập nói không ngừng nghỉ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [音乐] (yīnyuè) - âm nhạc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '音乐'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yīnyuè',
      example_hanzi = '工作感到疲劳的时候，听听轻松的轻音乐能让人心情愉悦。',
      example_pinyin = 'Gōngzuò gǎndào píláo de shíhou, tīngting qīngsōng de qīngyīnyuè néng ràng rén xīnqíng yúyuè.',
      example_vi = 'Khi làm việc mệt mỏi, nghe chút nhạc nhẹ êm dịu sẽ giúp tâm trạng thư thái phấn chấn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '工作感到疲劳的时候，听听轻松的轻音乐能让人心情愉悦。', 'Gōngzuò gǎndào píláo de shíhou, tīngting qīngsōng de qīngyīnyuè néng ràng rén xīnqíng yúyuè.', 'Khi làm việc mệt mỏi, nghe chút nhạc nhẹ êm dịu sẽ giúp tâm trạng thư thái phấn chấn.', 'basic', 1),
        (v_id, '他从小就在音乐方面展现出了非凡的艺术天赋，尤其擅长弹奏古典钢琴曲。', 'Tā cóngxiǎo jiù zài yīnyuè fāngmiàn zhǎnxiàn chū le fēifán de yìshù tiānfù, yóuqí shàncháng tánzòu gǔdiǎn gāngqínqǔ.', 'Từ nhỏ anh ấy đã bộc lộ năng khiếu nghệ thuật phi phàm về âm nhạc, đặc biệt sở trường diễn tấu các bản nhạc piano cổ điển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [饮料] (yǐnliào) - đồ uống [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '饮料'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yǐnliào',
      example_hanzi = '冰箱里放满了各种果汁和冰镇清凉饮料。',
      example_pinyin = 'Bīngxiāng lǐ fàng mǎn le gèzhǒng guǒzhī hé bīngzhèn qīngliáng yǐnliào.',
      example_vi = 'Trong tủ lạnh để đầy đủ các loại nước ép trái cây và thức uống thanh nhiệt mát lạnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '冰箱里放满了各种果汁和冰镇清凉饮料。', 'Bīngxiāng lǐ fàng mǎn le gèzhǒng guǒzhī hé bīngzhèn qīngliáng yǐnliào.', 'Trong tủ lạnh để đầy đủ các loại nước ép trái cây và thức uống thanh nhiệt mát lạnh.', 'basic', 1),
        (v_id, '为了保持健康的身材，医生建议平时尽量少喝含糖量过高的碳酸饮料。', 'Wèile bǎochí jiànkāng de shēncái, yīshēng jiànyì píngshí jǐnliàng shǎo hē hántángliàng guò gāo de tànsuān yǐnliào.', 'Để duy trì vóc dáng khỏe khoắn, bác sĩ khuyên ngày thường nên hạn chế tối đa uống nước ngọt có ga hàm lượng đường cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [饱] (bǎo) - no [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '饱'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'bǎo',
      example_hanzi = '今天的饭菜实在太可口了，我已经吃得饱饱的了。',
      example_pinyin = 'Jīntiān de fàncài shízài tài kěkǒu le, wǒ yǐjīng chī de bǎobǎo de le.',
      example_vi = 'Cơm canh hôm nay quả thực quá đỗi ngon miệng, tôi đã ăn no căng bụng rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天的饭菜实在太可口了，我已经吃得饱饱的了。', 'Jīntiān de fàncài shízài tài kěkǒu le, wǒ yǐjīng chī de bǎobǎo de le.', 'Cơm canh hôm nay quả thực quá đỗi ngon miệng, tôi đã ăn no căng bụng rồi.', 'basic', 1),
        (v_id, '俗话说“饭吃七分饱，健康活到老”，适度饮食有助于肠胃消化。', 'Súhuà shuō “fàn chī qī fēn bǎo, jiànkāng huó dào lǎo”, shìdù yǐnshí yǒu zhùyú chángwèi xiāohuà.', 'Tục ngữ nói "Ăn cơm bảy phần no, mạnh khỏe sống đến già", ăn uống chừng mực rất có ích cho hệ tiêu hóa dạ dày.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [饿] (è) - đói [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '饿'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'è',
      example_hanzi = '忙了一下午都没顾上吃饭，现在肚子正饿得咕咕叫呢。',
      example_pinyin = 'Máng le yí xiàwǔ dōu méi gù shàng chīfàn, xiànzài dùzi zhèng è de gūgū jiào ne.',
      example_vi = 'Bận suốt cả buổi chiều không kịp ăn cơm, bây giờ bụng đang đói cồn cào kêu réo đây.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '忙了一下午都没顾上吃饭，现在肚子正饿得咕咕叫呢。', 'Máng le yí xiàwǔ dōu méi gù shàng chīfàn, xiànzài dùzi zhèng è de gūgū jiào ne.', 'Bận suốt cả buổi chiều không kịp ăn cơm, bây giờ bụng đang đói cồn cào kêu réo đây.', 'basic', 1),
        (v_id, '无论工作有多繁忙，也不要经常饿着肚子熬夜加班，健康永远是第一位的。', 'Wúlùn gōngzuò yǒu duō fánmáng, yě bú yào chángcháng è zhe dùzi áoyè jiābān, jiànkāng yǒngyuǎn shì dì-yī wèi de.', 'Cho dù công việc có bận rộn đến đâu, cũng đừng thường xuyên để bụng đói thức khuya tăng ca, sức khỏe luôn luôn là số một.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [香蕉] (xiāngjiāo) - chuối [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '香蕉'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiāngjiāo',
      example_hanzi = '运动健身之后吃一根香蕉能够迅速补充身体能量。',
      example_pinyin = 'Yùndòng jiànshēn zhīhòu chī yì gēn xiāngjiāo nénggòu xùnsù bǔchōng shēntǐ néngliàng.',
      example_vi = 'Sau khi tập thể dục thể thao ăn một quả chuối có thể nhanh chóng bù đắp năng lượng cho cơ thể.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '运动健身之后吃一根香蕉能够迅速补充身体能量。', 'Yùndòng jiànshēn zhīhòu chī yì gēn xiāngjiāo nénggòu xùnsù bǔchōng shēntǐ néngliàng.', 'Sau khi tập thể dục thể thao ăn một quả chuối có thể nhanh chóng bù đắp năng lượng cho cơ thể.', 'basic', 1),
        (v_id, '这串金黄熟透的香蕉散发着诱人的果香，口感香甜软糯。', 'Zhè chuàn jīnhuáng shútòu de xiāngjiāo sànfā zhe yòurén de guǒxiāng, kǒugǎn xiāngtián ruǎnnuò.', 'Nải chuối chín vàng ươm này tỏa ra mùi hương hoa quả quyến rũ, ăn vào ngọt thơm mềm dẻo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [马] (mǎ) - ngựa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '马'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mǎ',
      example_hanzi = '广阔的大草原上一群骏马正在迎着晨风自由奔跑。',
      example_pinyin = 'Guǎngkuò de dà cǎoyuán shang yì qún jùnmǎ zhèngzài yíng zhe chénfēng zìyóu bēnpǎo.',
      example_vi = 'Trên thảo nguyên mênh mông, một đàn tuấn mã đang đón gió sớm tự do phi nước đại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '广阔的大草原上一群骏马正在迎着晨风自由奔跑。', 'Guǎngkuò de dà cǎoyuán shang yì qún jùnmǎ zhèngzài yíng zhe chénfēng zìyóu bēnpǎo.', 'Trên thảo nguyên mênh mông, một đàn tuấn mã đang đón gió sớm tự do phi nước đại.', 'basic', 1),
        (v_id, '古时候人们出行主要依靠马匹或马车，马在古代交通和军事中占据着极其重要的地位。', 'Gǔ shíhou rénmen chūxíng zhǔyào yīkào mǎpǐ huò mǎchē, mǎ zài gǔdài jiāotōng hé jūnshì zhōng zhànjù zhe jíqí zhòngyào de dìwèi.', 'Thời xưa con người đi lại chủ yếu nương nhờ vào ngựa hoặc xe ngựa, loài ngựa giữ vai trò cực kỳ trọng yếu trong giao thông và quân sự cổ đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [马上] (mǎshàng) - ngay lập tức [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '马上'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'mǎshàng',
      example_hanzi = '请您稍等片刻，服务员马上就把热茶送过来。',
      example_pinyin = 'Qǐng nín shāoděng piànkè, fúwùyuán mǎshàng jiù bǎ rè chá sòng guòlái.',
      example_vi = 'Xin ngài vui lòng chờ chốc lát, nhân viên phục vụ sẽ mang trà nóng tới ngay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请您稍等片刻，服务员马上就把热茶送过来。', 'Qǐng nín shāoděng piànkè, fúwùyuán mǎshàng jiù bǎ rè chá sòng guòlái.', 'Xin ngài vui lòng chờ chốc lát, nhân viên phục vụ sẽ mang trà nóng tới ngay.', 'basic', 1),
        (v_id, '得知客户急需修改方案的要求后，项目团队马上组织召开了紧急协调会。', 'Dézhī kèhù jíxū xiūgǎi fāng’àn de yāoqiú hòu, xiàngmù tuánduì mǎshàng zǔzhī zhàokāi le jǐnjí xiétiáohuì.', 'Ngay khi biết yêu cầu khách hàng cần sửa gấp phương án, nhóm dự án đã lập tức tổ chức cuộc họp điều phối khẩn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [骑] (qí) - cưỡi, lái (xe hai bánh) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '骑'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'qí',
      example_hanzi = '星期天上午我喜欢骑着自行车沿着江边绿道慢行赏景。',
      example_pinyin = 'Xīngqītiān shàngwǔ wǒ xǐhuan qí zhe zìxíngchē yánzhe jiāngbiān lǜdào mànxíng shǎngxǐng.',
      example_vi = 'Sáng Chủ nhật tôi thích đạp xe đi thong dong dọc theo lối đi xanh ven sông ngắm cảnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '星期天上午我喜欢骑着自行车沿着江边绿道慢行赏景。', 'Xīngqītiān shàngwǔ wǒ xǐhuan qí zhe zìxíngchē yánzhe jiāngbiān lǜdào mànxíng shǎngxǐng.', 'Sáng Chủ nhật tôi thích đạp xe đi thong dong dọc theo lối đi xanh ven sông ngắm cảnh.', 'basic', 1),
        (v_id, '内蒙古牧民们从小就练就了一手精湛高超的骑马本领。', 'Nèiménggǔ mùmínmen cóngxiǎo jiù liàn jiù le yì shǒu jīngzhàn gāochāo de qímǎ běnlǐng.', 'Những người dân du mục Nội Mông ngay từ thuở nhỏ đã tôi luyện được tài nghệ cưỡi ngựa điêu luyện tuyệt vời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [黑板] (hēibǎn) - bảng đen [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '黑板'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hēibǎn',
      example_hanzi = '上课时老师在黑板上写下了今天要学的几个核心语法重点。',
      example_pinyin = 'Shàngkè shí lǎoshī zài hēibǎn shang xiě xià le jīntiān yào xué de jǐ gè héxīn yǔfǎ zhòngdiǎn.',
      example_vi = 'Trong giờ học thầy giáo đã viết lên bảng đen vài điểm ngữ pháp trọng tâm cần học hôm nay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '上课时老师在黑板上写下了今天要学的几个核心语法重点。', 'Shàngkè shí lǎoshī zài hēibǎn shang xiě xià le jīntiān yào xué de jǐ gè héxīn yǔfǎ zhòngdiǎn.', 'Trong giờ học thầy giáo đã viết lên bảng đen vài điểm ngữ pháp trọng tâm cần học hôm nay.', 'basic', 1),
        (v_id, '值日生认真地把黑板擦得干干净净，为下一节课做好了准备。', 'Zhírìshēng rènzhēn de bǎ hēibǎn cā de gāngānjìngjìng, wèi xià yì jié kè zuò hǎo le zhǔnbèi.', 'Học sinh trực nhật đã cẩn thận lau sạch bóng bảng đen, sẵn sàng chuẩn bị cho tiết học kế tiếp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 160 câu ví dụ cho % từ vựng HSK 3 (Batch 3 - Hoàn tất toàn bộ HSK 3)!', v_count;
END $$;
