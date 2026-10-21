-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 1 (100 TỪ ĐẦU TIÊN)
-- Phạm vi: #2001 [哎] (āi) -> #2100 [差别] (chābié)
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
  -- [2001] [哎] (āi) - này, này bạn (thán từ dùng để gọi hoặc nhắc nhở) [Thán từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '哎'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哎'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Thán từ',
      pinyin = 'āi',
      meaning_vi = 'này, này bạn (thán từ dùng để gọi hoặc nhắc nhở)',
      example_hanzi = '哎，你把钱包掉在地上了！',
      example_pinyin = 'Āi, nǐ bǎ qiánbāo diào zài dì shang le!',
      example_vi = 'Này, bạn làm rơi ví tiền xuống đất rồi kìa!'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '哎',
      'āi',
      'này, này bạn (thán từ dùng để gọi hoặc nhắc nhở)',
      'Thán từ',
      'HSK 5',
      '哎，你把钱包掉在地上了！',
      'Āi, nǐ bǎ qiánbāo diào zài dì shang le!',
      'Này, bạn làm rơi ví tiền xuống đất rồi kìa!'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '哎，你把钱包掉在地上了！',
        'Āi, nǐ bǎ qiánbāo diào zài dì shang le!',
        'Này, bạn làm rơi ví tiền xuống đất rồi kìa!',
        'basic',
        1
      ),
      (
        v_id,
        '哎，李经理，刚才王总打电话找你商量合同的事。',
        'Āi, Lǐ jīnglǐ, gāngcái Wáng zǒng dǎ diànhuà zhǎo nǐ shāngliang hétong de shì.',
        'Này, quản lý Lý ơi, vừa nãy tổng giám đốc Vương gọi điện tìm anh để bàn chuyện hợp đồng đấy.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2002] [哎呀] (āiyā) - ối chao, trời ơi (thán từ biểu thị ngạc nhiên, hối tiếc hoặc kêu đau) [Thán từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '哎呀'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哎呀'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Thán từ',
      pinyin = 'āiyā',
      meaning_vi = 'ối chao, trời ơi (thán từ biểu thị ngạc nhiên, hối tiếc hoặc kêu đau)',
      example_hanzi = '哎呀，我出门忘记带钥匙了。',
      example_pinyin = 'Āiyā, wǒ chūmén wàngjì dài yàoshi le.',
      example_vi = 'Ối chao, tôi ra khỏi nhà quên mang theo chìa khóa rồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '哎呀',
      'āiyā',
      'ối chao, trời ơi (thán từ biểu thị ngạc nhiên, hối tiếc hoặc kêu đau)',
      'Thán từ',
      'HSK 5',
      '哎呀，我出门忘记带钥匙了。',
      'Āiyā, wǒ chūmén wàngjì dài yàoshi le.',
      'Ối chao, tôi ra khỏi nhà quên mang theo chìa khóa rồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '哎呀，我出门忘记带钥匙了。',
        'Āiyā, wǒ chūmén wàngjì dài yàoshi le.',
        'Ối chao, tôi ra khỏi nhà quên mang theo chìa khóa rồi.',
        'basic',
        1
      ),
      (
        v_id,
        '哎呀，这趟高铁马上要开了，我们得赶紧检票上车。',
        'Āiyā, zhè tàng gāotiě mǎshàng yào kāi le, wǒmen děi gǎnjǐn jiǎnpiào shàngchē.',
        'Trời ơi, chuyến tàu cao tốc này sắp chạy rồi, chúng ta phải mau chóng soát vé lên tàu thôi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2003] [唉] (ài) - chao ôi, than ôi (thở dài biểu thị buồn bã, bất lực hoặc đồng ý) [Thán từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '唉'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '唉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Thán từ',
      pinyin = 'ài',
      meaning_vi = 'chao ôi, than ôi (thở dài biểu thị buồn bã, bất lực hoặc đồng ý)',
      example_hanzi = '唉，这次考试我又粗心做错了一道题。',
      example_pinyin = 'Ài, zhè cì kǎoshì wǒ yòu cūxīn zuò cuò le yí dào tí.',
      example_vi = 'Than ôi, lần thi này tôi lại bất cẩn làm sai mất một câu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '唉',
      'ài',
      'chao ôi, than ôi (thở dài biểu thị buồn bã, bất lực hoặc đồng ý)',
      'Thán từ',
      'HSK 5',
      '唉，这次考试我又粗心做错了一道题。',
      'Ài, zhè cì kǎoshì wǒ yòu cūxīn zuò cuò le yí dào tí.',
      'Than ôi, lần thi này tôi lại bất cẩn làm sai mất một câu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '唉，这次考试我又粗心做错了一道题。',
        'Ài, zhè cì kǎoshì wǒ yòu cūxīn zuò cuò le yí dào tí.',
        'Than ôi, lần thi này tôi lại bất cẩn làm sai mất một câu.',
        'basic',
        1
      ),
      (
        v_id,
        '“你能帮我把这份材料打印一下吗？”“唉，好的，我马上办。”',
        '“Nǐ néng bāng wǒ bǎ zhè fèn cáiliào dǎyìn yíxià ma?” “Ài, hǎode, wǒ mǎshàng bàn.”',
        '“Bạn có thể in giúp tôi tập tài liệu này không?” “Dạ vâng, được chứ, tôi làm ngay đây.”',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2004] [爱护] (àihù) - yêu quý và bảo vệ, giữ gìn (đồ vật, của công, môi trường) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '爱护'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '爱护'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'àihù',
      meaning_vi = 'yêu quý và bảo vệ, giữ gìn (đồ vật, của công, môi trường)',
      example_hanzi = '我们每个人都应该爱护校园里的花草树木。',
      example_pinyin = 'Wǒmen měi gè rén dōu yīnggāi àihù xiàoyuán lǐ de huācǎo shùmù.',
      example_vi = 'Mỗi người chúng ta đều nên bảo vệ cỏ cây hoa lá trong khuôn viên trường học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '爱护',
      'àihù',
      'yêu quý và bảo vệ, giữ gìn (đồ vật, của công, môi trường)',
      'Động từ',
      'HSK 5',
      '我们每个人都应该爱护校园里的花草树木。',
      'Wǒmen měi gè rén dōu yīnggāi àihù xiàoyuán lǐ de huācǎo shùmù.',
      'Mỗi người chúng ta đều nên bảo vệ cỏ cây hoa lá trong khuôn viên trường học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '我们每个人都应该爱护校园里的花草树木。',
        'Wǒmen měi gè rén dōu yīnggāi àihù xiàoyuán lǐ de huācǎo shùmù.',
        'Mỗi người chúng ta đều nên bảo vệ cỏ cây hoa lá trong khuôn viên trường học.',
        'basic',
        1
      ),
      (
        v_id,
        '公司提倡员工爱护办公设备，养成节约用电的良好习惯。',
        'Gōngsī tíchàng yuángōng àihù bàngōng shèbèi, yǎngchéng jiéyuē yòngdiàn de liánghǎo xíguàn.',
        'Công ty kêu gọi nhân viên giữ gìn thiết bị văn phòng, hình thành thói quen tốt tiết kiệm điện.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2005] [安] (ān) - lắp đặt; an lòng, bình an [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '安'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '安'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'ān',
      meaning_vi = 'lắp đặt; an lòng, bình an',
      example_hanzi = '工人们正在为新教室安窗帘和电风扇。',
      example_pinyin = 'Gōngrénmen zhèngzài wèi xīn jiàoshì ān chuānglián hé diànfēngshàn.',
      example_vi = 'Các công nhân đang lắp rèm cửa và quạt điện cho lớp học mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '安',
      'ān',
      'lắp đặt; an lòng, bình an',
      'Động từ / Tính từ',
      'HSK 5',
      '工人们正在为新教室安窗帘和电风扇。',
      'Gōngrénmen zhèngzài wèi xīn jiàoshì ān chuānglián hé diànfēngshàn.',
      'Các công nhân đang lắp rèm cửa và quạt điện cho lớp học mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '工人们正在为新教室安窗帘和电风扇。',
        'Gōngrénmen zhèngzài wèi xīn jiàoshì ān chuānglián hé diànfēngshàn.',
        'Các công nhân đang lắp rèm cửa và quạt điện cho lớp học mới.',
        'basic',
        1
      ),
      (
        v_id,
        '得知手术非常成功，大家都放下心来，心里十分安稳。',
        'Dézhī shǒushù fēicháng chénggōng, dàjiā dōu fàngxià xīn lái, xīnlǐ shífēn ānwěn.',
        'Biết tin ca phẫu thuật vô cùng thành công, mọi người đều thở phào nhẹ nhõm, lòng dạ vô cùng bình an.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2006] [安全带] (ānquándài) - dây an toàn (trên ô tô, máy bay) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '安全带'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '安全带'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'ānquándài',
      meaning_vi = 'dây an toàn (trên ô tô, máy bay)',
      example_hanzi = '上车后请第一时间系好安全带。',
      example_pinyin = 'Shàngchē hòu qǐng dì-yī shíjiān jì hǎo ānquándài.',
      example_vi = 'Sau khi lên xe xin vui lòng thắt dây an toàn trước tiên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '安全带',
      'ānquándài',
      'dây an toàn (trên ô tô, máy bay)',
      'Danh từ',
      'HSK 5',
      '上车后请第一时间系好安全带。',
      'Shàngchē hòu qǐng dì-yī shíjiān jì hǎo ānquándài.',
      'Sau khi lên xe xin vui lòng thắt dây an toàn trước tiên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '上车后请第一时间系好安全带。',
        'Shàngchē hòu qǐng dì-yī shíjiān jì hǎo ānquándài.',
        'Sau khi lên xe xin vui lòng thắt dây an toàn trước tiên.',
        'basic',
        1
      ),
      (
        v_id,
        '飞机遇到强气流发生颠簸时，乘客必须坐在座位上并系紧安全带。',
        'Fēijī yùdào qiáng qìliú fāshēng diānbǒ shí, chéngkè bìxū zuò zài zuòwèi shàng bìng jì jǐn ānquándài.',
        'Khi máy bay gặp luồng không khí mạnh bị rung lắc, hành khách bắt buộc phải ngồi tại chỗ và thắt chặt dây an toàn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2007] [安慰] (ānwèi) - an ủi, vỗ về; cảm thấy ấm lòng, thanh thản [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '安慰'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '安慰'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'ānwèi',
      meaning_vi = 'an ủi, vỗ về; cảm thấy ấm lòng, thanh thản',
      example_hanzi = '看到朋友伤心落泪，他轻声安慰了她很久。',
      example_pinyin = 'Kàndào péngyou shāngxīn luòlèi, tā qīngshēng ānwèi le tā hěn jiǔ.',
      example_vi = 'Thấy bạn đau lòng rơi lệ, anh ấy đã nhẹ nhàng an ủi cô ấy một hồi lâu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '安慰',
      'ānwèi',
      'an ủi, vỗ về; cảm thấy ấm lòng, thanh thản',
      'Động từ / Tính từ',
      'HSK 5',
      '看到朋友伤心落泪，他轻声安慰了她很久。',
      'Kàndào péngyou shāngxīn luòlèi, tā qīngshēng ānwèi le tā hěn jiǔ.',
      'Thấy bạn đau lòng rơi lệ, anh ấy đã nhẹ nhàng an ủi cô ấy một hồi lâu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '看到朋友伤心落泪，他轻声安慰了她很久。',
        'Kàndào péngyou shāngxīn luòlèi, tā qīngshēng ānwèi le tā hěn jiǔ.',
        'Thấy bạn đau lòng rơi lệ, anh ấy đã nhẹ nhàng an ủi cô ấy một hồi lâu.',
        'basic',
        1
      ),
      (
        v_id,
        '看到孩子们都健康成长而且事业有成，父母感到莫大的安慰。',
        'Kàndào háizimen dōu jiànkāng chéngzhǎng érqiě shìyè yǒuchéng, fùmǔ gǎndào mòdà de ānwèi.',
        'Nhìn thấy các con đều khôn lớn khỏe mạnh lại thành đạt trong sự nghiệp, cha mẹ cảm thấy vô cùng an lòng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2008] [安装] (ānzhuāng) - lắp đặt (thiết bị), cài đặt (phần mềm máy tính/điện thoại) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '安装'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '安装'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'ānzhuāng',
      meaning_vi = 'lắp đặt (thiết bị), cài đặt (phần mềm máy tính/điện thoại)',
      example_hanzi = '技术员正在我的电脑上安装最新的杀毒软件。',
      example_pinyin = 'Jìshùyuán zhèngzài wǒ de diànnǎo shàng ānzhuāng zuìxīn de shādú ruǎnjiàn.',
      example_vi = 'Kỹ thuật viên đang cài đặt phần mềm diệt virus mới nhất trên máy tính của tôi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '安装',
      'ānzhuāng',
      'lắp đặt (thiết bị), cài đặt (phần mềm máy tính/điện thoại)',
      'Động từ',
      'HSK 5',
      '技术员正在我的电脑上安装最新的杀毒软件。',
      'Jìshùyuán zhèngzài wǒ de diànnǎo shàng ānzhuāng zuìxīn de shādú ruǎnjiàn.',
      'Kỹ thuật viên đang cài đặt phần mềm diệt virus mới nhất trên máy tính của tôi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '技术员正在我的电脑上安装最新的杀毒软件。',
        'Jìshùyuán zhèngzài wǒ de diànnǎo shàng ānzhuāng zuìxīn de shādú ruǎnjiàn.',
        'Kỹ thuật viên đang cài đặt phần mềm diệt virus mới nhất trên máy tính của tôi.',
        'basic',
        1
      ),
      (
        v_id,
        '为了提高生产效率，工厂下个月将安装两套自动化流水线。',
        'Wèile tígāo shēngchǎn xiàolǜ, gōngchǎng xià gè yuè jiāng ānzhuāng liǎng tào zìdònghuà liúshuǐxiàn.',
        'Để nâng cao năng suất sản xuất, tháng tới nhà máy sẽ lắp đặt hai dây chuyền tự động hóa.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2009] [暗] (àn) - tối, mờ, u ám (ánh sáng); ngầm, bí mật [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '暗'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '暗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'àn',
      meaning_vi = 'tối, mờ, u ám (ánh sáng); ngầm, bí mật',
      example_hanzi = '屋里光线太暗了，把灯打开吧。',
      example_pinyin = 'Wū lǐ guāngxiàn tài àn le, bǎ dēng dǎkāi ba.',
      example_vi = 'Ánh sáng trong phòng tối quá, bật đèn lên đi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '暗',
      'àn',
      'tối, mờ, u ám (ánh sáng); ngầm, bí mật',
      'Tính từ',
      'HSK 5',
      '屋里光线太暗了，把灯打开吧。',
      'Wū lǐ guāngxiàn tài àn le, bǎ dēng dǎkāi ba.',
      'Ánh sáng trong phòng tối quá, bật đèn lên đi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '屋里光线太暗了，把灯打开吧。',
        'Wū lǐ guāngxiàn tài àn le, bǎ dēng dǎkāi ba.',
        'Ánh sáng trong phòng tối quá, bật đèn lên đi.',
        'basic',
        1
      ),
      (
        v_id,
        '他在心里暗暗下定决心，一定要在年底前完成这个具有挑战性的项目。',
        'Tā zài xīnlǐ àn’àn xiàdìng juéxīn, yídìng yào zài niándǐ qián wánchéng zhè gè jùyǒu tiǎozhànxìng de xiàngmù.',
        'Anh ấy thầm hạ quyết tâm trong lòng, nhất định phải hoàn thành dự án đầy thách thức này trước cuối năm.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2010] [熬夜] (áoyè) - thức khuya, thức đêm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '熬夜'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '熬夜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'áoyè',
      meaning_vi = 'thức khuya, thức đêm',
      example_hanzi = '经常熬夜对身体健康有很大的害处。',
      example_pinyin = 'Jīngcháng áoyè duì shēntǐ jiànkāng yǒu hěn dà de hàichù.',
      example_vi = 'Thường xuyên thức khuya có tác hại rất lớn đối với sức khỏe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '熬夜',
      'áoyè',
      'thức khuya, thức đêm',
      'Động từ',
      'HSK 5',
      '经常熬夜对身体健康有很大的害处。',
      'Jīngcháng áoyè duì shēntǐ jiànkāng yǒu hěn dà de hàichù.',
      'Thường xuyên thức khuya có tác hại rất lớn đối với sức khỏe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '经常熬夜对身体健康有很大的害处。',
        'Jīngcháng áoyè duì shēntǐ jiànkāng yǒu hěn dà de hàichù.',
        'Thường xuyên thức khuya có tác hại rất lớn đối với sức khỏe.',
        'basic',
        1
      ),
      (
        v_id,
        '为了赶在截止日期前提交设计方案，整个团队连续熬夜加班了好几天。',
        'Wèile gǎn zài jiézhǐ rìqī qián tíjiāo shèjì fāng’àn, zhěnggè tuánduì liánxù áoyè jiābān le hǎo jǐ tiān.',
        'Để kịp nộp phương án thiết kế trước thời hạn chót, cả đội ngũ đã thức đêm tăng ca liên tục mấy ngày liền.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2011] [把握] (bǎwò) - nắm chắc, nắm bắt (cơ hội); sự chắc chắn, tự tin thành công [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '把握'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '把握'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'bǎwò',
      meaning_vi = 'nắm chắc, nắm bắt (cơ hội); sự chắc chắn, tự tin thành công',
      example_hanzi = '年轻人要学会主动把握每一个锻炼自己的机会。',
      example_pinyin = 'Niánqīngrén yào xuéhuì zhǔdòng bǎwò měi yí gè duànliàn zìjǐ de jīhuì.',
      example_vi = 'Người trẻ tuổi cần học cách chủ động nắm bắt từng cơ hội rèn luyện bản thân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '把握',
      'bǎwò',
      'nắm chắc, nắm bắt (cơ hội); sự chắc chắn, tự tin thành công',
      'Động từ / Danh từ',
      'HSK 5',
      '年轻人要学会主动把握每一个锻炼自己的机会。',
      'Niánqīngrén yào xuéhuì zhǔdòng bǎwò měi yí gè duànliàn zìjǐ de jīhuì.',
      'Người trẻ tuổi cần học cách chủ động nắm bắt từng cơ hội rèn luyện bản thân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '年轻人要学会主动把握每一个锻炼自己的机会。',
        'Niánqīngrén yào xuéhuì zhǔdòng bǎwò měi yí gè duànliàn zìjǐ de jīhuì.',
        'Người trẻ tuổi cần học cách chủ động nắm bắt từng cơ hội rèn luyện bản thân.',
        'basic',
        1
      ),
      (
        v_id,
        '对于这次投标能否成功，项目经理表示团队做了充足准备，很有把握。',
        'Duìyú zhè cì tóubiāo néng fǒu chénggōng, xiàngmù jīnglǐ biǎoshì tuánduì zuò le chōngzú zhǔnbèi, hěn yǒu bǎwò.',
        'Về việc cuộc đấu thầu lần này có thành công hay không, giám đốc dự án cho biết cả đội đã chuẩn bị đầy đủ và rất có nắm chắc.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2012] [白] (bái) - trắng; uổng công, công cốc; miễn phí [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '白'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '白'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'bái',
      meaning_vi = 'trắng; uổng công, công cốc; miễn phí',
      example_hanzi = '冬天的大雪过后，整座城市变成了一片白茫茫的世界。',
      example_pinyin = 'Dōngtiān de dàxuě guòhòu, zhěng zuò chéngshì biànchéng le yí piàn bái mángmáng de shìjiè.',
      example_vi = 'Sau trận tuyết lớn mùa đông, toàn thành phố biến thành một thế giới trắng xóa bạt ngàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '白',
      'bái',
      'trắng; uổng công, công cốc; miễn phí',
      'Tính từ / Phó từ',
      'HSK 5',
      '冬天的大雪过后，整座城市变成了一片白茫茫的世界。',
      'Dōngtiān de dàxuě guòhòu, zhěng zuò chéngshì biànchéng le yí piàn bái mángmáng de shìjiè.',
      'Sau trận tuyết lớn mùa đông, toàn thành phố biến thành một thế giới trắng xóa bạt ngàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '冬天的大雪过后，整座城市变成了一片白茫茫的世界。',
        'Dōngtiān de dàxuě guòhòu, zhěng zuò chéngshì biànchéng le yí piàn bái mángmáng de shìjiè.',
        'Sau trận tuyết lớn mùa đông, toàn thành phố biến thành một thế giới trắng xóa bạt ngàn.',
        'basic',
        1
      ),
      (
        v_id,
        '今天去图书馆才发现闭馆装修，害得我顶着大雨白跑了一趟。',
        'Jīntiān qù túshūguǎn cái fāxiàn bìguǎn zhuāngxiū, hài de wǒ dǐng zhe dàyǔ bái pǎo le yí tàng.',
        'Hôm nay đến thư viện mới phát hiện đóng cửa sửa chữa, làm tôi đội mưa to đi một chuyến công cốc.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2013] [半夜] (bànyè) - nửa đêm, đêm khuya [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '半夜'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '半夜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bànyè',
      meaning_vi = 'nửa đêm, đêm khuya',
      example_hanzi = '半夜突然下起大雨，雷声把熟睡的孩子惊醒了。',
      example_pinyin = 'Bànyè tūrán xià qǐ dàyǔ, léishēng bǎ shúshuì de háizi jīngxǐng le.',
      example_vi = 'Nửa đêm trời bỗng đổ mưa lớn, tiếng sấm làm đứa trẻ đang ngủ say giật mình tỉnh giấc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '半夜',
      'bànyè',
      'nửa đêm, đêm khuya',
      'Danh từ',
      'HSK 5',
      '半夜突然下起大雨，雷声把熟睡的孩子惊醒了。',
      'Bànyè tūrán xià qǐ dàyǔ, léishēng bǎ shúshuì de háizi jīngxǐng le.',
      'Nửa đêm trời bỗng đổ mưa lớn, tiếng sấm làm đứa trẻ đang ngủ say giật mình tỉnh giấc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '半夜突然下起大雨，雷声把熟睡的孩子惊醒了。',
        'Bànyè tūrán xià qǐ dàyǔ, léishēng bǎ shúshuì de háizi jīngxǐng le.',
        'Nửa đêm trời bỗng đổ mưa lớn, tiếng sấm làm đứa trẻ đang ngủ say giật mình tỉnh giấc.',
        'basic',
        1
      ),
      (
        v_id,
        '急诊科医生经常半夜接到紧急通知赶回医院参与抢救手术。',
        'Jízhěnkē yīshēng jīngcháng bànyè jiēdào jǐnjí tōngzhī gǎnhuí yīyuàn cānyù qiǎngjiù shǒushù.',
        'Bác sĩ khoa cấp cứu thường nhận được thông báo khẩn lúc nửa đêm để lập tức chạy về bệnh viện tham gia ca mổ cấp cứu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2014] [傍晚] (bàngwǎn) - hoàng hôn, chập tối, lúc sẩm tối [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '傍晚'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '傍晚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bàngwǎn',
      meaning_vi = 'hoàng hôn, chập tối, lúc sẩm tối',
      example_hanzi = '傍晚时分，公园里有很多散步和跳广场舞的人。',
      example_pinyin = 'Bàngwǎn shífēn, gōngyuán lǐ yǒu hěn duō sànbù hé tiào guǎngchǎngwǔ de rén.',
      example_vi = 'Lúc chập tối, trong công viên có rất nhiều người đi dạo và nhảy múa quảng trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '傍晚',
      'bàngwǎn',
      'hoàng hôn, chập tối, lúc sẩm tối',
      'Danh từ',
      'HSK 5',
      '傍晚时分，公园里有很多散步和跳广场舞的人。',
      'Bàngwǎn shífēn, gōngyuán lǐ yǒu hěn duō sànbù hé tiào guǎngchǎngwǔ de rén.',
      'Lúc chập tối, trong công viên có rất nhiều người đi dạo và nhảy múa quảng trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '傍晚时分，公园里有很多散步和跳广场舞的人。',
        'Bàngwǎn shífēn, gōngyuán lǐ yǒu hěn duō sànbù hé tiào guǎngchǎngwǔ de rén.',
        'Lúc chập tối, trong công viên có rất nhiều người đi dạo và nhảy múa quảng trường.',
        'basic',
        1
      ),
      (
        v_id,
        '我们坐在海滩边的咖啡馆里，静静欣赏傍晚落日映红天边的壮丽美景。',
        'Wǒmen zuò zài hǎitān biān de kāfēiguǎn lǐ, jìngjìng xīnshǎng bàngwǎn luòrì yìng hóng tiānbiān de zhuànglì měijǐng.',
        'Chúng tôi ngồi trong quán cà phê ven bãi biển, tĩnh lặng ngắm nhìn cảnh tượng hoàng hôn tuyệt đẹp rực đỏ cả góc trời.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2015] [包裹] (bāoguǒ) - bưu kiện, gói hàng; bao bọc, bọc kín [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '包裹'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '包裹'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'bāoguǒ',
      meaning_vi = 'bưu kiện, gói hàng; bao bọc, bọc kín',
      example_hanzi = '快递员刚把老家寄来的包裹送到门口。',
      example_pinyin = 'Kuàidìyuán gāng bǎ lǎojiā jì lái de bāoguǒ sòng dào ménkǒu.',
      example_vi = 'Nhân viên chuyển phát nhanh vừa đưa bưu kiện gửi từ quê nhà đến trước cửa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '包裹',
      'bāoguǒ',
      'bưu kiện, gói hàng; bao bọc, bọc kín',
      'Danh từ / Động từ',
      'HSK 5',
      '快递员刚把老家寄来的包裹送到门口。',
      'Kuàidìyuán gāng bǎ lǎojiā jì lái de bāoguǒ sòng dào ménkǒu.',
      'Nhân viên chuyển phát nhanh vừa đưa bưu kiện gửi từ quê nhà đến trước cửa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '快递员刚把老家寄来的包裹送到门口。',
        'Kuàidìyuán gāng bǎ lǎojiā jì lái de bāoguǒ sòng dào ménkǒu.',
        'Nhân viên chuyển phát nhanh vừa đưa bưu kiện gửi từ quê nhà đến trước cửa.',
        'basic',
        1
      ),
      (
        v_id,
        '易碎物品在邮寄前必须用泡沫塑料仔细包裹好，以免途中受损。',
        'Yìsuǐ wùpǐn zài yóujì qián bìxū yòng pàomò sùliào zǐxì bāoguǒ hǎo, yǐmiǎn túzhōng shòusǔn.',
        'Đồ dễ vỡ trước khi gửi bưu điện bắt buộc phải dùng màng xốp bọc thật kỹ càng, tránh bị hư hỏng trên đường đi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2016] [包含] (bāohán) - chứa đựng, bao hàm (nội dung, ý nghĩa sâu xa, đạo lý) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '包含'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '包含'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bāohán',
      meaning_vi = 'chứa đựng, bao hàm (nội dung, ý nghĩa sâu xa, đạo lý)',
      example_hanzi = '这句简短的格言包含了深刻的人生道理。',
      example_pinyin = 'Zhè jù jiǎnduǎn de géyán bāohán le shēnkè de rénshēng dàolǐ.',
      example_vi = 'Câu châm ngôn ngắn gọn này bao hàm đạo lý nhân sinh sâu sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '包含',
      'bāohán',
      'chứa đựng, bao hàm (nội dung, ý nghĩa sâu xa, đạo lý)',
      'Động từ',
      'HSK 5',
      '这句简短的格言包含了深刻的人生道理。',
      'Zhè jù jiǎnduǎn de géyán bāohán le shēnkè de rénshēng dàolǐ.',
      'Câu châm ngôn ngắn gọn này bao hàm đạo lý nhân sinh sâu sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这句简短的格言包含了深刻的人生道理。',
        'Zhè jù jiǎnduǎn de géyán bāohán le shēnkè de rénshēng dàolǐ.',
        'Câu châm ngôn ngắn gọn này bao hàm đạo lý nhân sinh sâu sắc.',
        'basic',
        1
      ),
      (
        v_id,
        '本次旅游套餐的报价中已经包含了全程机票、四星级酒店住宿以及早餐费用。',
        'Běn cì lǚyóu tàocān de bàojià zhōng yǐjīng bāohán le quánchéng jīpiào, sì xīngjí jiǔdiàn zhùsù yǐjí zǎocān fèiyòng.',
        'Báo giá của gói du lịch lần này đã bao hàm toàn bộ vé máy bay, khách sạn bốn sao và chi phí bữa sáng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2017] [包括] (bāokuò) - bao gồm (liệt kê danh mục, thành phần người hoặc vật) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '包括'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '包括'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bāokuò',
      meaning_vi = 'bao gồm (liệt kê danh mục, thành phần người hoặc vật)',
      example_hanzi = '参加这次聚会的一共有十二个人，包括老师和学生。',
      example_pinyin = 'Cānjiā zhè cì jùhuì de yí gòng yǒu shí’èr gè rén, bāokuò lǎoshī hé xuésheng.',
      example_vi = 'Tham gia buổi tụ họp lần này tổng cộng có mười hai người, bao gồm cả thầy giáo và học sinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '包括',
      'bāokuò',
      'bao gồm (liệt kê danh mục, thành phần người hoặc vật)',
      'Động từ',
      'HSK 5',
      '参加这次聚会的一共有十二个人，包括老师和学生。',
      'Cānjiā zhè cì jùhuì de yí gòng yǒu shí’èr gè rén, bāokuò lǎoshī hé xuésheng.',
      'Tham gia buổi tụ họp lần này tổng cộng có mười hai người, bao gồm cả thầy giáo và học sinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '参加这次聚会的一共有十二个人，包括老师和学生。',
        'Cānjiā zhè cì jùhuì de yí gòng yǒu shí’èr gè rén, bāokuò lǎoshī hé xuésheng.',
        'Tham gia buổi tụ họp lần này tổng cộng có mười hai người, bao gồm cả thầy giáo và học sinh.',
        'basic',
        1
      ),
      (
        v_id,
        '公司福利待遇优厚，包括五险一金、带薪年假以及定期的全员健康体检。',
        'Gōngsī fúlì dàiyù yōuhòu, bāokuò wǔ xiǎn yì jīn, dàixīn niánjià yǐjí dìngqī de quányuán jiànkāng tǐjiǎn.',
        'Chế độ đãi ngộ phúc lợi của công ty rất tốt, bao gồm bảo hiểm đầy đủ, nghỉ phép năm hưởng lương và khám sức khỏe định kỳ cho toàn thể nhân viên.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2018] [包装] (bāozhuāng) - đóng gói; bao bì, bao gói hàng hóa [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '包装'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '包装'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'bāozhuāng',
      meaning_vi = 'đóng gói; bao bì, bao gói hàng hóa',
      example_hanzi = '这个礼品盒的外包装设计得非常精美。',
      example_pinyin = 'Zhè gè lǐpǐnhé de wài bāozhuāng shèjì de fēicháng jīngměi.',
      example_vi = 'Bao bì bên ngoài của hộp quà tặng này được thiết kế rất tinh xảo đẹp mắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '包装',
      'bāozhuāng',
      'đóng gói; bao bì, bao gói hàng hóa',
      'Động từ / Danh từ',
      'HSK 5',
      '这个礼品盒的外包装设计得非常精美。',
      'Zhè gè lǐpǐnhé de wài bāozhuāng shèjì de fēicháng jīngměi.',
      'Bao bì bên ngoài của hộp quà tặng này được thiết kế rất tinh xảo đẹp mắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这个礼品盒的外包装设计得非常精美。',
        'Zhè gè lǐpǐnhé de wài bāozhuāng shèjì de fēicháng jīngměi.',
        'Bao bì bên ngoài của hộp quà tặng này được thiết kế rất tinh xảo đẹp mắt.',
        'basic',
        1
      ),
      (
        v_id,
        '现代企业不仅注重产品内在质量，还十分重视采用环保材料进行产品包装。',
        'Xiàndài qǐyè bùjǐn zhùzhòng chǎnpǐn nèizài zhìliàng, hái shífēn zhòngshì cǎiyòng huánbǎo cáiliào jìnxíng chǎnpǐn bāozhuāng.',
        'Doanh nghiệp hiện đại không chỉ chú trọng chất lượng bên trong của sản phẩm mà còn rất coi trọng việc sử dụng vật liệu thân thiện môi trường để đóng gói sản phẩm.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2019] [薄] (báo) - mỏng (độ dày), mảnh mai; nhạt nhẽo (tình cảm) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '薄'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '薄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'báo',
      meaning_vi = 'mỏng (độ dày), mảnh mai; nhạt nhẽo (tình cảm)',
      example_hanzi = '春天天气转暖了，大家换上了薄薄的外套。',
      example_pinyin = 'Chūntiān tiānqì zhuǎn nuǎn le, dàjiā huàn shàng le báo báo de wàitào.',
      example_vi = 'Mùa xuân thời tiết ấm lên rồi, mọi người đều đổi sang mặc áo khoác mỏng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '薄',
      'báo',
      'mỏng (độ dày), mảnh mai; nhạt nhẽo (tình cảm)',
      'Tính từ',
      'HSK 5',
      '春天天气转暖了，大家换上了薄薄的外套。',
      'Chūntiān tiānqì zhuǎn nuǎn le, dàjiā huàn shàng le báo báo de wàitào.',
      'Mùa xuân thời tiết ấm lên rồi, mọi người đều đổi sang mặc áo khoác mỏng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '春天天气转暖了，大家换上了薄薄的外套。',
        'Chūntiān tiānqì zhuǎn nuǎn le, dàjiā huàn shàng le báo báo de wàitào.',
        'Mùa xuân thời tiết ấm lên rồi, mọi người đều đổi sang mặc áo khoác mỏng.',
        'basic',
        1
      ),
      (
        v_id,
        '湖面上的冰层还很薄，严禁行人在上面滑冰走动，以防发生溺水危险。',
        'Húmiàn shàng de bīngcéng hái hěn báo, yánjìn xíngrén zài shàngmiàn huábīng zǒudòng, yǐ fáng fāshēng nìshuǐ wēixiǎn.',
        'Lớp băng trên mặt hồ còn rất mỏng, nghiêm cấm người đi bộ trượt băng hay đi lại bên trên nhằm phòng ngừa nguy hiểm đuối nước.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2020] [宝] (bǎo) - bảo vật, báu vật, điều trân quý [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '宝'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宝'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bǎo',
      meaning_vi = 'bảo vật, báu vật, điều trân quý',
      example_hanzi = '在老人心里，活泼可爱的孙子就是全家的宝。',
      example_pinyin = 'Zài lǎorén xīnlǐ, huópō kě’ài de sūnzi jiù shì quánjiā de bǎo.',
      example_vi = 'Trong lòng người già, đứa cháu nội hoạt bát đáng yêu chính là báu vật của cả gia đình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '宝',
      'bǎo',
      'bảo vật, báu vật, điều trân quý',
      'Danh từ',
      'HSK 5',
      '在老人心里，活泼可爱的孙子就是全家的宝。',
      'Zài lǎorén xīnlǐ, huópō kě’ài de sūnzi jiù shì quánjiā de bǎo.',
      'Trong lòng người già, đứa cháu nội hoạt bát đáng yêu chính là báu vật của cả gia đình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在老人心里，活泼可爱的孙子就是全家的宝。',
        'Zài lǎorén xīnlǐ, huópō kě’ài de sūnzi jiù shì quánjiā de bǎo.',
        'Trong lòng người già, đứa cháu nội hoạt bát đáng yêu chính là báu vật của cả gia đình.',
        'basic',
        1
      ),
      (
        v_id,
        '经过多年的刻苦钻研，这位老中医积累了一套被称为“镇院之宝”的独特针灸疗法。',
        'Jīngguò duō nián de kèkǔ zuānyán, zhè wèi lǎo zhōngyī jīlěi le yí tào bèi chēng wèi “zhèn yuàn zhī bǎo” de dútè zhēnjiǔ liáofǎ.',
        'Qua nhiều năm miệt mài nghiên cứu, vị bác sĩ đông y lão thành này đã tích lũy được liệu pháp châm cứu độc đáo được mệnh danh là “báu vật trấn viện”.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2021] [保] (bǎo) - bảo đảm, giữ gìn, bảo vệ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '保'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '保'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bǎo',
      meaning_vi = 'bảo đảm, giữ gìn, bảo vệ',
      example_hanzi = '工厂既要抓紧时间赶进度，又要严格保质量。',
      example_pinyin = 'Gōngchǎng jì yào zhuājǐn shíjiān gǎn jìndù, yòu yào yángé bǎo zhìliàng.',
      example_vi = 'Nhà máy vừa phải tranh thủ thời gian đẩy nhanh tiến độ, lại vừa phải giữ nghiêm chất lượng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '保',
      'bǎo',
      'bảo đảm, giữ gìn, bảo vệ',
      'Động từ',
      'HSK 5',
      '工厂既要抓紧时间赶进度，又要严格保质量。',
      'Gōngchǎng jì yào zhuājǐn shíjiān gǎn jìndù, yòu yào yángé bǎo zhìliàng.',
      'Nhà máy vừa phải tranh thủ thời gian đẩy nhanh tiến độ, lại vừa phải giữ nghiêm chất lượng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '工厂既要抓紧时间赶进度，又要严格保质量。',
        'Gōngchǎng jì yào zhuājǐn shíjiān gǎn jìndù, yòu yào yángé bǎo zhìliàng.',
        'Nhà máy vừa phải tranh thủ thời gian đẩy nhanh tiến độ, lại vừa phải giữ nghiêm chất lượng.',
        'basic',
        1
      ),
      (
        v_id,
        '面临复杂多变的市场环境，企业首要的任务是保稳定、促发展。',
        'Miànlín fùzá duōbiàn de shìchǎng huánjìng, qǐyè shǒuyào de rènwu shì bǎo wěndìng, cù fāzhǎn.',
        'Đối mặt với môi trường thị trường biến động phức tạp, nhiệm vụ hàng đầu của doanh nghiệp là giữ vững ổn định và thúc đẩy phát triển.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2022] [保安] (bǎo’ān) - bảo vệ, nhân viên an ninh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '保安'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '保安'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bǎo’ān',
      meaning_vi = 'bảo vệ, nhân viên an ninh',
      example_hanzi = '小区的保安师傅工作非常认真负责。',
      example_pinyin = 'Xiǎoqū de bǎo’ān shīfu gōngzuò fēicháng rènzhēn fùzé.',
      example_vi = 'Bác bảo vệ khu chung cư làm việc rất tận tâm và có trách nhiệm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '保安',
      'bǎo’ān',
      'bảo vệ, nhân viên an ninh',
      'Danh từ',
      'HSK 5',
      '小区的保安师傅工作非常认真负责。',
      'Xiǎoqū de bǎo’ān shīfu gōngzuò fēicháng rènzhēn fùzé.',
      'Bác bảo vệ khu chung cư làm việc rất tận tâm và có trách nhiệm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '小区的保安师傅工作非常认真负责。',
        'Xiǎoqū de bǎo’ān shīfu gōngzuò fēicháng rènzhēn fùzé.',
        'Bác bảo vệ khu chung cư làm việc rất tận tâm và có trách nhiệm.',
        'basic',
        1
      ),
      (
        v_id,
        '进入写字楼前，所有访客都必须在保安处出示有效证件并办理登记手续。',
        'Jìnrù xiězìlóu qián, suǒyǒu fǎngkè dōu bìxū zài bǎo’ān chù chūshì yǒuxiào zhèngjiàn bìng bànlǐ dēngjì shǒuxù.',
        'Trước khi vào tòa nhà văn phòng, mọi khách đến thăm đều bắt buộc phải xuất trình giấy tờ tùy thân hợp lệ tại quầy an ninh và làm thủ tục đăng ký.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2023] [宝贝] (bǎobèi) - bảo bối, bảo vật; cục cưng (gọi con nhỏ hoặc người thân yêu) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '宝贝'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宝贝'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bǎobèi',
      meaning_vi = 'bảo bối, bảo vật; cục cưng (gọi con nhỏ hoặc người thân yêu)',
      example_hanzi = '妈妈轻轻吻了吻熟睡中的小宝贝。',
      example_pinyin = 'Māma qīngqīng wěn le wěn shúshuì zhōng de xiǎo bǎobèi.',
      example_vi = 'Người mẹ nhẹ nhàng hôn lên trán đứa con bé bỏng đáng yêu đang ngủ say.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '宝贝',
      'bǎobèi',
      'bảo bối, bảo vật; cục cưng (gọi con nhỏ hoặc người thân yêu)',
      'Danh từ',
      'HSK 5',
      '妈妈轻轻吻了吻熟睡中的小宝贝。',
      'Māma qīngqīng wěn le wěn shúshuì zhōng de xiǎo bǎobèi.',
      'Người mẹ nhẹ nhàng hôn lên trán đứa con bé bỏng đáng yêu đang ngủ say.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '妈妈轻轻吻了吻熟睡中的小宝贝。',
        'Māma qīngqīng wěn le wěn shúshuì zhōng de xiǎo bǎobèi.',
        'Người mẹ nhẹ nhàng hôn lên trán đứa con bé bỏng đáng yêu đang ngủ say.',
        'basic',
        1
      ),
      (
        v_id,
        '这块祖传的美玉是爷爷珍藏了一辈子的宝贝，从不轻易拿出来示人。',
        'Zhè kuài zǔchuán de měiyù shì yéye zhēncáng le yí bèizi de bǎobèi, cóngbù qīngyì ná chūlái shì rén.',
        'Miếng ngọc quý gia truyền này là báu vật mà ông nội đã trân quý giữ gìn suốt cả cuộc đời, không bao giờ tùy tiện mang ra khoe ai.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2024] [保持] (bǎochí) - duy trì, giữ vững (trạng thái, thói quen, cự ly, mối liên hệ) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '保持'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '保持'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bǎochí',
      meaning_vi = 'duy trì, giữ vững (trạng thái, thói quen, cự ly, mối liên hệ)',
      example_hanzi = '阅览室内请保持安静，不要大声喧哗。',
      example_pinyin = 'Yuèlǎnshì nèi qǐng bǎochí ānjìng, bú yào dàshēng xuānhuá.',
      example_vi = 'Trong phòng đọc sách xin vui lòng giữ im lặng, không làm ồn lớn tiếng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '保持',
      'bǎochí',
      'duy trì, giữ vững (trạng thái, thói quen, cự ly, mối liên hệ)',
      'Động từ',
      'HSK 5',
      '阅览室内请保持安静，不要大声喧哗。',
      'Yuèlǎnshì nèi qǐng bǎochí ānjìng, bú yào dàshēng xuānhuá.',
      'Trong phòng đọc sách xin vui lòng giữ im lặng, không làm ồn lớn tiếng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '阅览室内请保持安静，不要大声喧哗。',
        'Yuèlǎnshì nèi qǐng bǎochí ānjìng, bú yào dàshēng xuānhuá.',
        'Trong phòng đọc sách xin vui lòng giữ im lặng, không làm ồn lớn tiếng.',
        'basic',
        1
      ),
      (
        v_id,
        '在高速公路上驾驶车辆时，驾驶员必须时刻与前车保持足够的安全车距。',
        'Zài gāosù gōnglù shàng jiàshǐ chēliàng shí, jiàshǐyuán bìxū shíkè yǔ qiánchē bǎochí zúgòu de ānquán chējù.',
        'Khi lái xe trên đường cao tốc, tài xế phải luôn duy trì cự ly an toàn vừa đủ với xe phía trước.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2025] [保存] (bǎocún) - lưu lại, bảo quản, lưu trữ (tập tin máy tính, hiện vật, đồ dùng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '保存'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '保存'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bǎocún',
      meaning_vi = 'lưu lại, bảo quản, lưu trữ (tập tin máy tính, hiện vật, đồ dùng)',
      example_hanzi = '写完文章后，千万别忘了点击保存按钮。',
      example_pinyin = 'Xiě wán wénzhāng hòu, qiānwàn bié wàng le diǎnjī bǎocún ànniǔ.',
      example_vi = 'Sau khi viết xong bài văn, nhất định đừng quên bấm nút lưu lại nhé.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '保存',
      'bǎocún',
      'lưu lại, bảo quản, lưu trữ (tập tin máy tính, hiện vật, đồ dùng)',
      'Động từ',
      'HSK 5',
      '写完文章后，千万别忘了点击保存按钮。',
      'Xiě wán wénzhāng hòu, qiānwàn bié wàng le diǎnjī bǎocún ànniǔ.',
      'Sau khi viết xong bài văn, nhất định đừng quên bấm nút lưu lại nhé.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '写完文章后，千万别忘了点击保存按钮。',
        'Xiě wán wénzhāng hòu, qiānwàn bié wàng le diǎnjī bǎocún ànniǔ.',
        'Sau khi viết xong bài văn, nhất định đừng quên bấm nút lưu lại nhé.',
        'basic',
        1
      ),
      (
        v_id,
        '珍贵的历史文物需要在恒温恒湿的专业库房中妥善保存，防止氧化损坏。',
        'Zhēnguì de lìshǐ wénwù xūyào zài héngwēn héngshī de zhuānyè kùfáng zhōng tuǒshàn bǎocún, fángzhǐ yǎnghuà sǔnhuài.',
        'Di vật lịch sử quý giá cần được bảo quản chu đáo trong kho chuyên dụng có nhiệt độ và độ ẩm không đổi để ngăn chặn hư hỏng do oxy hóa.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2026] [宝贵] (bǎoguì) - quý báu, quý giá (thời gian, kinh nghiệm, cơ hội) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '宝贵'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宝贵'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'bǎoguì',
      meaning_vi = 'quý báu, quý giá (thời gian, kinh nghiệm, cơ hội)',
      example_hanzi = '时间非常宝贵，我们要抓紧每分每秒好好学习。',
      example_pinyin = 'Shíjiān fēicháng bǎoguì, wǒmen yào zhuājǐn měi fēn měi miǎo hǎohǎo xuéxí.',
      example_vi = 'Thời gian vô cùng quý báu, chúng ta phải tranh thủ từng phút từng giây để học tập cho tốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '宝贵',
      'bǎoguì',
      'quý báu, quý giá (thời gian, kinh nghiệm, cơ hội)',
      'Tính từ',
      'HSK 5',
      '时间非常宝贵，我们要抓紧每分每秒好好学习。',
      'Shíjiān fēicháng bǎoguì, wǒmen yào zhuājǐn měi fēn měi miǎo hǎohǎo xuéxí.',
      'Thời gian vô cùng quý báu, chúng ta phải tranh thủ từng phút từng giây để học tập cho tốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '时间非常宝贵，我们要抓紧每分每秒好好学习。',
        'Shíjiān fēicháng bǎoguì, wǒmen yào zhuājǐn měi fēn měi miǎo hǎohǎo xuéxí.',
        'Thời gian vô cùng quý báu, chúng ta phải tranh thủ từng phút từng giây để học tập cho tốt.',
        'basic',
        1
      ),
      (
        v_id,
        '老专家们在会上提出的建设性意见，为我们后续的项目研发提供了十分宝贵的经验。',
        'Lǎo zhuānjiāmen zài huì shàng tíchū de jiànshèxìng yìjiàn, wèi wǒmen hòuxù de xiàngmù yánfā tígōng le shífēn bǎoguì de jīngyàn.',
        'Những ý kiến mang tính xây dựng mà các chuyên gia lão thành đưa ra tại hội nghị đã cung cấp kinh nghiệm vô cùng quý giá cho công tác nghiên cứu phát triển dự án tiếp theo của chúng tôi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2027] [保留] (bǎoliú) - giữ lại, bảo lưu (ý kiến, quyền hạn, phong tục, hiện trạng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '保留'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '保留'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bǎoliú',
      meaning_vi = 'giữ lại, bảo lưu (ý kiến, quyền hạn, phong tục, hiện trạng)',
      example_hanzi = '老城区完整地保留了许多明清时期的传统古建筑。',
      example_pinyin = 'Lǎo chéngqū wánzhěng de bǎoliú le xǔduō Míng Qīng shíqī de chuántǒng gǔ jiànzhù.',
      example_vi = 'Khu phố cổ đã lưu giữ một cách nguyên vẹn nhiều công trình kiến trúc cổ truyền thống thời Minh - Thanh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '保留',
      'bǎoliú',
      'giữ lại, bảo lưu (ý kiến, quyền hạn, phong tục, hiện trạng)',
      'Động từ',
      'HSK 5',
      '老城区完整地保留了许多明清时期的传统古建筑。',
      'Lǎo chéngqū wánzhěng de bǎoliú le xǔduō Míng Qīng shíqī de chuántǒng gǔ jiànzhù.',
      'Khu phố cổ đã lưu giữ một cách nguyên vẹn nhiều công trình kiến trúc cổ truyền thống thời Minh - Thanh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '老城区完整地保留了许多明清时期的传统古建筑。',
        'Lǎo chéngqū wánzhěng de bǎoliú le xǔduō Míng Qīng shíqī de chuántǒng gǔ jiànzhù.',
        'Khu phố cổ đã lưu giữ một cách nguyên vẹn nhiều công trình kiến trúc cổ truyền thống thời Minh - Thanh.',
        'basic',
        1
      ),
      (
        v_id,
        '虽然多数人赞成这项改革方案，但张经理依然保留自己的反对意见。',
        'Suīrán duōshù rén zànchéng zhè xiàng gǎigé fāng’àn, dàn Zhāng jīnglǐ yīrán bǎoliú zìjǐ de fǎnduì yìjiàn.',
        'Mặc dù đa số mọi người tán thành phương án cải cách này, nhưng giám đốc Trương vẫn bảo lưu ý kiến phản đối của mình.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2028] [保险] (bǎoxiǎn) - bảo hiểm (thương mại); an toàn, chắc chắn, tin cậy [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '保险'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '保险'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'bǎoxiǎn',
      meaning_vi = 'bảo hiểm (thương mại); an toàn, chắc chắn, tin cậy',
      example_hanzi = '买车之后，一定要记得每年按时给车辆买保险。',
      example_pinyin = 'Mǎi chē zhīhòu, yídìng yào jìde měi nián ànshí gěi chēliàng mǎi bǎoxiǎn.',
      example_vi = 'Sau khi mua xe hơi, nhất định phải nhớ mua bảo hiểm cho xe đúng hạn hàng năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '保险',
      'bǎoxiǎn',
      'bảo hiểm (thương mại); an toàn, chắc chắn, tin cậy',
      'Danh từ / Tính từ',
      'HSK 5',
      '买车之后，一定要记得每年按时给车辆买保险。',
      'Mǎi chē zhīhòu, yídìng yào jìde měi nián ànshí gěi chēliàng mǎi bǎoxiǎn.',
      'Sau khi mua xe hơi, nhất định phải nhớ mua bảo hiểm cho xe đúng hạn hàng năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '买车之后，一定要记得每年按时给车辆买保险。',
        'Mǎi chē zhīhòu, yídìng yào jìde měi nián ànshí gěi chēliàng mǎi bǎoxiǎn.',
        'Sau khi mua xe hơi, nhất định phải nhớ mua bảo hiểm cho xe đúng hạn hàng năm.',
        'basic',
        1
      ),
      (
        v_id,
        '为了保险起见，出发前我们最好把所有重要文件和合同备份到云端硬盘中。',
        'Wèile bǎoxiǎn qǐjiàn, chūfā qián wǒmen zuìhǎo bǎ suǒyǒu zhòngyào wénjiàn hé hétong bèifèn dào yúnduān yìngpán zhōng.',
        'Để cho an toàn chắc chắn, trước khi lên đường tốt nhất chúng ta nên sao lưu toàn bộ hồ sơ và hợp đồng quan trọng lên ổ đĩa đám mây.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2029] [保质期] (bǎozhìqī) - hạn sử dụng, thời hạn bảo đảm chất lượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '保质期'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '保质期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bǎozhìqī',
      meaning_vi = 'hạn sử dụng, thời hạn bảo đảm chất lượng',
      example_hanzi = '购买食品时要仔细查看包装袋上的生产日期和保质期。',
      example_pinyin = 'Gòumǎi shípǐn shí yào zǐxì chákàn bāozhuāngdài shàng de shēngchǎn rìqī hé bǎozhìqī.',
      example_vi = 'Khi mua thực phẩm cần xem xét kỹ ngày sản xuất và hạn sử dụng trên túi bao bì.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '保质期',
      'bǎozhìqī',
      'hạn sử dụng, thời hạn bảo đảm chất lượng',
      'Danh từ',
      'HSK 5',
      '购买食品时要仔细查看包装袋上的生产日期和保质期。',
      'Gòumǎi shípǐn shí yào zǐxì chákàn bāozhuāngdài shàng de shēngchǎn rìqī hé bǎozhìqī.',
      'Khi mua thực phẩm cần xem xét kỹ ngày sản xuất và hạn sử dụng trên túi bao bì.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '购买食品时要仔细查看包装袋上的生产日期和保质期。',
        'Gòumǎi shípǐn shí yào zǐxì chákàn bāozhuāngdài shàng de shēngchǎn rìqī hé bǎozhìqī.',
        'Khi mua thực phẩm cần xem xét kỹ ngày sản xuất và hạn sử dụng trên túi bao bì.',
        'basic',
        1
      ),
      (
        v_id,
        '超市管理规定，凡是临近保质期的鲜奶制品，必须提前下架或者进行打折促销。',
        'Chāoshì guǎnlǐ guīdìng, fánshì línjìn bǎozhìqī de xiānnǎi zhìpǐn, bìxū tíqián xiàjià huòzhě jìnxíng dǎzhé cùxiāo.',
        'Quy định quản lý của siêu thị nêu rõ, hễ sản phẩm sữa tươi nào cận hạn sử dụng đều phải hạ kệ trước thời hạn hoặc giảm giá kích cầu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2030] [报到] (bàodào) - đến trình diện, làm thủ tục điểm danh (nhập học, nhận việc, hội nghị) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '报到'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '报到'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bàodào',
      meaning_vi = 'đến trình diện, làm thủ tục điểm danh (nhập học, nhận việc, hội nghị)',
      example_hanzi = '新生请于九月一日上午八点到学校大礼堂报到。',
      example_pinyin = 'Xīnshēng qǐng yú jiǔ yuè yī rì shàngwǔ bā diǎn dào xuéxiào dà lǐtáng bàodào.',
      example_vi = 'Tân sinh viên xin vui lòng đến hội trường lớn của trường làm thủ tục nhập học lúc tám giờ sáng ngày một tháng chín.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '报到',
      'bàodào',
      'đến trình diện, làm thủ tục điểm danh (nhập học, nhận việc, hội nghị)',
      'Động từ',
      'HSK 5',
      '新生请于九月一日上午八点到学校大礼堂报到。',
      'Xīnshēng qǐng yú jiǔ yuè yī rì shàngwǔ bā diǎn dào xuéxiào dà lǐtáng bàodào.',
      'Tân sinh viên xin vui lòng đến hội trường lớn của trường làm thủ tục nhập học lúc tám giờ sáng ngày một tháng chín.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '新生请于九月一日上午八点到学校大礼堂报到。',
        'Xīnshēng qǐng yú jiǔ yuè yī rì shàngwǔ bā diǎn dào xuéxiào dà lǐtáng bàodào.',
        'Tân sinh viên xin vui lòng đến hội trường lớn của trường làm thủ tục nhập học lúc tám giờ sáng ngày một tháng chín.',
        'basic',
        1
      ),
      (
        v_id,
        '新入职的员工第一天上班需要先去人力资源部报到并领取办公用品。',
        'Xīn rùzhí de yuángōng dì-yī tiān shàngbān xūyào xiān qù rénlì zīyuánbù bàodào bìng lǐngqǔ bàngōng yòngpǐn.',
        'Nhân viên mới tuyển dụng ngày đầu tiên đi làm cần phải đến phòng nhân sự trình diện trước và nhận đồ dùng văn phòng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2031] [报道] (bàodào) - đưa tin; bản tin, bài báo, phóng sự [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '报道'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '报道'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'bàodào',
      meaning_vi = 'đưa tin; bản tin, bài báo, phóng sự',
      example_hanzi = '各大新闻媒体昨天详细报道了这场国际科技展览会。',
      example_pinyin = 'Gè dà xīnwén méitǐ zuótiān xiángxì bàodào le zhè chǎng guójì kējì zhǎnlǎnhuì.',
      example_vi = 'Các cơ quan truyền thông báo chí lớn hôm qua đã đưa tin chi tiết về triển lãm công nghệ quốc tế này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '报道',
      'bàodào',
      'đưa tin; bản tin, bài báo, phóng sự',
      'Động từ / Danh từ',
      'HSK 5',
      '各大新闻媒体昨天详细报道了这场国际科技展览会。',
      'Gè dà xīnwén méitǐ zuótiān xiángxì bàodào le zhè chǎng guójì kējì zhǎnlǎnhuì.',
      'Các cơ quan truyền thông báo chí lớn hôm qua đã đưa tin chi tiết về triển lãm công nghệ quốc tế này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '各大新闻媒体昨天详细报道了这场国际科技展览会。',
        'Gè dà xīnwén méitǐ zuótiān xiángxì bàodào le zhè chǎng guójì kējì zhǎnlǎnhuì.',
        'Các cơ quan truyền thông báo chí lớn hôm qua đã đưa tin chi tiết về triển lãm công nghệ quốc tế này.',
        'basic',
        1
      ),
      (
        v_id,
        '根据记者深入一线的调查报道，该地区的生态环境得到了非常明显的改善。',
        'Gēnjù jìzhě shēnrù yīxiàn de diàochá bàodào, gāi dìqū de shēngtài huánjìng dédào le fēicháng míngxiǎn de gǎishàn.',
        'Căn cứ theo bài phóng sự điều tra sâu sát thực địa của phóng viên, môi trường sinh thái ở khu vực này đã đạt được sự cải thiện vô cùng rõ nét.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2032] [报告] (bàogào) - báo cáo, bản báo cáo; trình báo, báo cáo lên cấp trên [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '报告'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '报告'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'bàogào',
      meaning_vi = 'báo cáo, bản báo cáo; trình báo, báo cáo lên cấp trên',
      example_hanzi = '他用了一个月的时间终于写完了这份市场调研报告。',
      example_pinyin = 'Tā yòng le yí gè yuè de shíjiān zhōngyú xiě wán le zhè fèn shìchǎng diàoyán bàogào.',
      example_vi = 'Anh ấy dùng thời gian tròn một tháng cuối cùng cũng đã viết xong bản báo cáo khảo sát thị trường này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '报告',
      'bàogào',
      'báo cáo, bản báo cáo; trình báo, báo cáo lên cấp trên',
      'Danh từ / Động từ',
      'HSK 5',
      '他用了一个月的时间终于写完了这份市场调研报告。',
      'Tā yòng le yí gè yuè de shíjiān zhōngyú xiě wán le zhè fèn shìchǎng diàoyán bàogào.',
      'Anh ấy dùng thời gian tròn một tháng cuối cùng cũng đã viết xong bản báo cáo khảo sát thị trường này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他用了一个月的时间终于写完了这份市场调研报告。',
        'Tā yòng le yí gè yuè de shíjiān zhōngyú xiě wán le zhè fèn shìchǎng diàoyán bàogào.',
        'Anh ấy dùng thời gian tròn một tháng cuối cùng cũng đã viết xong bản báo cáo khảo sát thị trường này.',
        'basic',
        1
      ),
      (
        v_id,
        '如果在生产现场发现安全隐患，工人有责任立即向车间主管报告。',
        'Rúguǒ zài shēngchǎn xiànchǎng fāxiàn ānquán yǐnhuàn, gōngrén yǒu zérèn lìjí xiàng chējiān zhǔguǎn bàogào.',
        'Nếu phát hiện nguy cơ mất an toàn tại hiện trường sản xuất, công nhân có trách nhiệm báo cáo ngay lập tức cho quản đốc phân xưởng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2033] [报警] (bàojǐng) - báo cảnh sát, báo công an, phát tín hiệu báo động [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '报警'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '报警'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bàojǐng',
      meaning_vi = 'báo cảnh sát, báo công an, phát tín hiệu báo động',
      example_hanzi = '遇到紧急突发危险情况，请立即拨打110报警电话。',
      example_pinyin = 'Yùdào jǐnjí tūfā wēixiǎn qíngkuàng, qǐng lìjí bōdǎ yāoyāolíng bàojǐng diànhuà.',
      example_vi = 'Gặp tình huống khẩn cấp nguy hiểm bất ngờ, xin hãy lập tức gọi số điện thoại 110 báo cảnh sát.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '报警',
      'bàojǐng',
      'báo cảnh sát, báo công an, phát tín hiệu báo động',
      'Động từ',
      'HSK 5',
      '遇到紧急突发危险情况，请立即拨打110报警电话。',
      'Yùdào jǐnjí tūfā wēixiǎn qíngkuàng, qǐng lìjí bōdǎ yāoyāolíng bàojǐng diànhuà.',
      'Gặp tình huống khẩn cấp nguy hiểm bất ngờ, xin hãy lập tức gọi số điện thoại 110 báo cảnh sát.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '遇到紧急突发危险情况，请立即拨打110报警电话。',
        'Yùdào jǐnjí tūfā wēixiǎn qíngkuàng, qǐng lìjí bōdǎ yāoyāolíng bàojǐng diànhuà.',
        'Gặp tình huống khẩn cấp nguy hiểm bất ngờ, xin hãy lập tức gọi số điện thoại 110 báo cảnh sát.',
        'basic',
        1
      ),
      (
        v_id,
        '路人发现商铺着火后第一时间报警并协助疏散群众，避免了人员伤亡。',
        'Lùrén fāxiàn shāngpù zháohuǒ hòu dì-yī shíjiān bàojǐng bìng xiézhù shūsàn qúnzhòng, bìmiǎn le rényuán shāngwáng.',
        'Người qua đường sau khi phát hiện cửa hàng bốc cháy đã lập tức báo công an và hỗ trợ sơ tán người dân, tránh được thương vong về người.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2034] [暴雨] (bàoyǔ) - mưa bão, mưa to như trút nước [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '暴雨'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '暴雨'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bàoyǔ',
      meaning_vi = 'mưa bão, mưa to như trút nước',
      example_hanzi = '昨晚的一场特大暴雨导致市区多条低洼路段积水严重。',
      example_pinyin = 'Zuówǎn de yì chǎng tèdà bàoyǔ dǎozhì shìqū duō tiáo dīwā lùduàn jīshuǐ yánzhòng.',
      example_vi = 'Một trận mưa bão đặc biệt lớn tối qua đã khiến nhiều đoạn đường trũng thấp trong nội thành ngập úng nghiêm trọng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '暴雨',
      'bàoyǔ',
      'mưa bão, mưa to như trút nước',
      'Danh từ',
      'HSK 5',
      '昨晚的一场特大暴雨导致市区多条低洼路段积水严重。',
      'Zuówǎn de yì chǎng tèdà bàoyǔ dǎozhì shìqū duō tiáo dīwā lùduàn jīshuǐ yánzhòng.',
      'Một trận mưa bão đặc biệt lớn tối qua đã khiến nhiều đoạn đường trũng thấp trong nội thành ngập úng nghiêm trọng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '昨晚的一场特大暴雨导致市区多条低洼路段积水严重。',
        'Zuówǎn de yì chǎng tèdà bàoyǔ dǎozhì shìqū duō tiáo dīwā lùduàn jīshuǐ yánzhòng.',
        'Một trận mưa bão đặc biệt lớn tối qua đã khiến nhiều đoạn đường trũng thấp trong nội thành ngập úng nghiêm trọng.',
        'basic',
        1
      ),
      (
        v_id,
        '气象台发布了暴雨黄色预警信号，建议市民非必要不要外出并在安全室内躲避。',
        'Qìxiàngtái fābù le bàoyǔ huángsè yùjǐng xìnhào, jiànyì shìmín fēi bìyào bú yào wàichū bìng zài ānquán shìnèi duǒbì.',
        'Đài khí tượng đã phát tín hiệu cảnh báo mưa bão màu vàng, khuyến cáo người dân không nên ra ngoài khi không cần thiết và trú ẩn ở trong phòng an toàn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2035] [抱怨] (bàoyuàn) - phàn nàn, oán trách, cằn nhằn, kêu ca [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '抱怨'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抱怨'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'bàoyuàn',
      meaning_vi = 'phàn nàn, oán trách, cằn nhằn, kêu ca',
      example_hanzi = '遇到困难时，与其无休止地抱怨，不如积极想办法解决。',
      example_pinyin = 'Yùdào kùnnan shí, yǔqí wúxiūzhǐ de bàoyuàn, bùrú jījí xiǎng bànfǎ jiějué.',
      example_vi = 'Khi gặp khó khăn, thay vì phàn nàn không dứt thì thà rằng tích cực nghĩ cách giải quyết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '抱怨',
      'bàoyuàn',
      'phàn nàn, oán trách, cằn nhằn, kêu ca',
      'Động từ / Danh từ',
      'HSK 5',
      '遇到困难时，与其无休止地抱怨，不如积极想办法解决。',
      'Yùdào kùnnan shí, yǔqí wúxiūzhǐ de bàoyuàn, bùrú jījí xiǎng bànfǎ jiějué.',
      'Khi gặp khó khăn, thay vì phàn nàn không dứt thì thà rằng tích cực nghĩ cách giải quyết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '遇到困难时，与其无休止地抱怨，不如积极想办法解决。',
        'Yùdào kùnnan shí, yǔqí wúxiūzhǐ de bàoyuàn, bùrú jījí xiǎng bànfǎ jiějué.',
        'Khi gặp khó khăn, thay vì phàn nàn không dứt thì thà rằng tích cực nghĩ cách giải quyết.',
        'basic',
        1
      ),
      (
        v_id,
        '客户因为物流延误多次打电话向客服部门抱怨服务质量太差。',
        'Kèhù yīnwèi wùliú yánwù duō cì dǎ diànhuà xiàng kèfù bùmén bàoyuàn fúwù zhìliàng tài chà.',
        'Khách hàng vì chuyện vận chuyển chậm trễ đã nhiều lần gọi điện đến bộ phận chăm sóc khách hàng phàn nàn chất lượng dịch vụ quá kém.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2036] [背] (bèi) - lưng; học thuộc lòng; cõng (đọc bēi) [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '背'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '背'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'bèi',
      meaning_vi = 'lưng; học thuộc lòng; cõng (đọc bēi)',
      example_hanzi = '在电脑前久坐不动容易引起背部酸痛。',
      example_pinyin = 'Zài diànnǎo qián jiǔ zuò búdòng róngyì yǐnqǐ bèibù suāntòng.',
      example_vi = 'Ngồi bất động lâu trước máy tính rất dễ gây đau mỏi phần lưng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '背',
      'bèi',
      'lưng; học thuộc lòng; cõng (đọc bēi)',
      'Danh từ / Động từ',
      'HSK 5',
      '在电脑前久坐不动容易引起背部酸痛。',
      'Zài diànnǎo qián jiǔ zuò búdòng róngyì yǐnqǐ bèibù suāntòng.',
      'Ngồi bất động lâu trước máy tính rất dễ gây đau mỏi phần lưng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在电脑前久坐不动容易引起背部酸痛。',
        'Zài diànnǎo qián jiǔ zuò búdòng róngyì yǐnqǐ bèibù suāntòng.',
        'Ngồi bất động lâu trước máy tính rất dễ gây đau mỏi phần lưng.',
        'basic',
        1
      ),
      (
        v_id,
        '语文老师要求同学们在今天放学前把这首唐诗背得滚瓜烂熟。',
        'Yǔwén lǎoshī yāoqiú tóngxuémen zài jīntiān fàngxué qián bǎ zhè shǒu Tángshī bèi de gǔnguālànshú.',
        'Giáo viên ngữ văn yêu cầu các bạn học sinh trước khi tan học hôm nay phải học thuộc lòng bài thơ Đường này vanh vách.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2037] [背后] (bèihòu) - phía sau lưng; đằng sau (nguyên nhân sâu xa, bàn tán sau lưng) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '背后'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '背后'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bèihòu',
      meaning_vi = 'phía sau lưng; đằng sau (nguyên nhân sâu xa, bàn tán sau lưng)',
      example_hanzi = '做人要光明正大，千万不要在别人背后说坏话。',
      example_pinyin = 'Zuòrén yào guāngmíngzhèngdà, qiānwàn bú yào zài biérén bèihòu shuō huàihuà.',
      example_vi = 'Làm người cần phải quang minh chính đại, tuyệt đối không được nói xấu sau lưng người khác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '背后',
      'bèihòu',
      'phía sau lưng; đằng sau (nguyên nhân sâu xa, bàn tán sau lưng)',
      'Danh từ',
      'HSK 5',
      '做人要光明正大，千万不要在别人背后说坏话。',
      'Zuòrén yào guāngmíngzhèngdà, qiānwàn bú yào zài biérén bèihòu shuō huàihuà.',
      'Làm người cần phải quang minh chính đại, tuyệt đối không được nói xấu sau lưng người khác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '做人要光明正大，千万不要在别人背后说坏话。',
        'Zuòrén yào guāngmíngzhèngdà, qiānwàn bú yào zài biérén bèihòu shuō huàihuà.',
        'Làm người cần phải quang minh chính đại, tuyệt đối không được nói xấu sau lưng người khác.',
        'basic',
        1
      ),
      (
        v_id,
        '这项科研成果成功取得突破的背后，凝聚着全体团队成员数千个日夜的辛勤付出。',
        'Zhè xiàng kēyán chéngguǒ chénggōng qǔdé tūpò de bèihòu, níngjù zhe quántǐ tuánduì chéngyuán shù qiān gè rìyè de xīnqín fùchū.',
        'Đằng sau sự đột phá thành công của thành quả nghiên cứu khoa học này là sự kết tinh của hàng ngàn ngày đêm cống hiến cần cù của toàn thể thành viên đội ngũ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2038] [背景] (bèijǐng) - bối cảnh (lịch sử, thời đại, văn hóa); phông nền; gia thế [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '背景'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '背景'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bèijǐng',
      meaning_vi = 'bối cảnh (lịch sử, thời đại, văn hóa); phông nền; gia thế',
      example_hanzi = '这张合影照片的背景是雄伟壮丽的长城。',
      example_pinyin = 'Zhè zhāng héyǐng zhàopiàn de bèijǐng shì xióngwěi zhuànglì de Chángchéng.',
      example_vi = 'Phông nền của bức ảnh chụp chung này là Vạn Lý Trường Thành hùng vĩ tráng lệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '背景',
      'bèijǐng',
      'bối cảnh (lịch sử, thời đại, văn hóa); phông nền; gia thế',
      'Danh từ',
      'HSK 5',
      '这张合影照片的背景是雄伟壮丽的长城。',
      'Zhè zhāng héyǐng zhàopiàn de bèijǐng shì xióngwěi zhuànglì de Chángchéng.',
      'Phông nền của bức ảnh chụp chung này là Vạn Lý Trường Thành hùng vĩ tráng lệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这张合影照片的背景是雄伟壮丽的长城。',
        'Zhè zhāng héyǐng zhàopiàn de bèijǐng shì xióngwěi zhuànglì de Chángchéng.',
        'Phông nền của bức ảnh chụp chung này là Vạn Lý Trường Thành hùng vĩ tráng lệ.',
        'basic',
        1
      ),
      (
        v_id,
        '了解小说创作的历史时代背景，有助于读者更深刻地理解书中各个人物的命运抉择。',
        'Liǎojiě xiǎoshuō chuàngzuò de lìshǐ shídài bèijǐng, yǒuzhùyú dúzhě gèng shēnkè de lǐjiě shū zhōng gè gè rénwù de mìngyùn juézé.',
        'Hiểu được bối cảnh thời đại lịch sử sáng tác của tiểu thuyết sẽ giúp ích cho độc giả thấu hiểu sâu sắc hơn những lựa chọn số phận của từng nhân vật trong sách.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2039] [被子] (bèizi) - cái chăn, mền đắp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '被子'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '被子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bèizi',
      meaning_vi = 'cái chăn, mền đắp',
      example_hanzi = '今天天气晴朗，妈妈把冬天的厚被子拿到阳台上晒太阳。',
      example_pinyin = 'Jīntiān tiānqì qínglǎng, māma bǎ dōngtiān de hòu bèizi ná dào yángtái shàng shài tàiyáng.',
      example_vi = 'Hôm nay trời nắng đẹp, mẹ đem chiếc chăn bông mùa đông dày ra ban công phơi nắng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '被子',
      'bèizi',
      'cái chăn, mền đắp',
      'Danh từ',
      'HSK 5',
      '今天天气晴朗，妈妈把冬天的厚被子拿到阳台上晒太阳。',
      'Jīntiān tiānqì qínglǎng, māma bǎ dōngtiān de hòu bèizi ná dào yángtái shàng shài tàiyáng.',
      'Hôm nay trời nắng đẹp, mẹ đem chiếc chăn bông mùa đông dày ra ban công phơi nắng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '今天天气晴朗，妈妈把冬天的厚被子拿到阳台上晒太阳。',
        'Jīntiān tiānqì qínglǎng, māma bǎ dōngtiān de hòu bèizi ná dào yángtái shàng shài tàiyáng.',
        'Hôm nay trời nắng đẹp, mẹ đem chiếc chăn bông mùa đông dày ra ban công phơi nắng.',
        'basic',
        1
      ),
      (
        v_id,
        '夜里气温下降得很快，睡觉时一定要盖好被子，别着凉感冒了。',
        'Yèlǐ qìwēn xiàjiàng de hěn kuài, shuìjiào shí yídìng yào gài hǎo bèizi, bié zháoliáng gǎnmào le.',
        'Ban đêm nhiệt độ hạ xuống rất nhanh, khi ngủ nhất định phải đắp chăn cẩn thận, kẻo bị nhiễm lạnh cảm cúm đấy.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2040] [本] (běn) - này, bản (bản thân, bản công ty); gốc rễ, vốn liếng; quyển, cuốn [Đại từ / Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '本'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '本'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ / Danh từ / Lượng từ',
      pinyin = 'běn',
      meaning_vi = 'này, bản (bản thân, bản công ty); gốc rễ, vốn liếng; quyển, cuốn',
      example_hanzi = '本公司始终坚持“质量第一、客户至上”的经营原则。',
      example_pinyin = 'Běn gōngsī shǐzhōng jiānchí “zhìliàng dì-yī, kèhù zhìshàng” de jīngyíng yuánzé.',
      example_vi = 'Bản công ty luôn kiên trì nguyên tắc kinh doanh “chất lượng hàng đầu, khách hàng là trên hết”.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '本',
      'běn',
      'này, bản (bản thân, bản công ty); gốc rễ, vốn liếng; quyển, cuốn',
      'Đại từ / Danh từ / Lượng từ',
      'HSK 5',
      '本公司始终坚持“质量第一、客户至上”的经营原则。',
      'Běn gōngsī shǐzhōng jiānchí “zhìliàng dì-yī, kèhù zhìshàng” de jīngyíng yuánzé.',
      'Bản công ty luôn kiên trì nguyên tắc kinh doanh “chất lượng hàng đầu, khách hàng là trên hết”.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '本公司始终坚持“质量第一、客户至上”的经营原则。',
        'Běn gōngsī shǐzhōng jiānchí “zhìliàng dì-yī, kèhù zhìshàng” de jīngyíng yuánzé.',
        'Bản công ty luôn kiên trì nguyên tắc kinh doanh “chất lượng hàng đầu, khách hàng là trên hết”.',
        'basic',
        1
      ),
      (
        v_id,
        '投资做生意无论追求多大利润，首先都要守住本钱，控制好风险。',
        'Tóuzī zuò shēngyì wúlùn zhuīqiú duō dà lìrùn, shǒuxiān dōu yào shǒuzhù běnqián, kòngzhì hǎo fēngxiǎn.',
        'Đầu tư làm ăn kinh doanh dù cho theo đuổi lợi nhuận lớn đến đâu thì trước hết đều phải giữ được vốn gốc và kiểm soát tốt rủi ro.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2041] [本地] (běndì) - bản địa, địa phương sở tại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '本地'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '本地'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'běndì',
      meaning_vi = 'bản địa, địa phương sở tại',
      example_hanzi = '品尝本地特色传统小吃是体验旅行乐趣的最好方式之一。',
      example_pinyin = 'Pǐncháng běndì tèsè chuántǒng xiǎochī shì tǐyàn lǚxíng lèqù de zuì hǎo fāngshì zhī yī.',
      example_vi = 'Thưởng thức món ăn vặt truyền thống đặc sản bản địa là một trong những cách tốt nhất để trải nghiệm niềm vui du lịch.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '本地',
      'běndì',
      'bản địa, địa phương sở tại',
      'Danh từ',
      'HSK 5',
      '品尝本地特色传统小吃是体验旅行乐趣的最好方式之一。',
      'Pǐncháng běndì tèsè chuántǒng xiǎochī shì tǐyàn lǚxíng lèqù de zuì hǎo fāngshì zhī yī.',
      'Thưởng thức món ăn vặt truyền thống đặc sản bản địa là một trong những cách tốt nhất để trải nghiệm niềm vui du lịch.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '品尝本地特色传统小吃是体验旅行乐趣的最好方式之一。',
        'Pǐncháng běndì tèsè chuántǒng xiǎochī shì tǐyàn lǚxíng lèqù de zuì hǎo fāngshì zhī yī.',
        'Thưởng thức món ăn vặt truyền thống đặc sản bản địa là một trong những cách tốt nhất để trải nghiệm niềm vui du lịch.',
        'basic',
        1
      ),
      (
        v_id,
        '这家外企非常重视本地化经营策略，积极招聘并大力培养本地优秀管理人才。',
        'Zhè jiā wàiqǐ fēicháng zhòngshì běndìhuà jīngyíng cèlüè, jījí zhāopìn bìng dàlì péiyǎng běndì yōuxiù guǎnlǐ réncái.',
        'Doanh nghiệp có vốn đầu tư nước ngoài này rất coi trọng chiến lược kinh doanh bản địa hóa, tích cực tuyển dụng và ra sức đào tạo nhân tài quản lý xuất sắc tại địa phương.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2042] [本领] (běnlǐng) - bản lĩnh, tài năng, năng lực chuyên môn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '本领'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '本领'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'běnlǐng',
      meaning_vi = 'bản lĩnh, tài năng, năng lực chuyên môn',
      example_hanzi = '年轻人要脚踏实地，在实践中练就一身真本领。',
      example_pinyin = 'Niánqīngrén yào jiǎotàshídì, zài shíjiàn zhōng liàn jiù yì shēn zhēn běnlǐng.',
      example_vi = 'Người trẻ tuổi cần làm việc vững chắc từng bước, rèn giũa nên một thân bản lĩnh thực thụ trong thực tiễn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '本领',
      'běnlǐng',
      'bản lĩnh, tài năng, năng lực chuyên môn',
      'Danh từ',
      'HSK 5',
      '年轻人要脚踏实地，在实践中练就一身真本领。',
      'Niánqīngrén yào jiǎotàshídì, zài shíjiàn zhōng liàn jiù yì shēn zhēn běnlǐng.',
      'Người trẻ tuổi cần làm việc vững chắc từng bước, rèn giũa nên một thân bản lĩnh thực thụ trong thực tiễn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '年轻人要脚踏实地，在实践中练就一身真本领。',
        'Niánqīngrén yào jiǎotàshídì, zài shíjiàn zhōng liàn jiù yì shēn zhēn běnlǐng.',
        'Người trẻ tuổi cần làm việc vững chắc từng bước, rèn giũa nên một thân bản lĩnh thực thụ trong thực tiễn.',
        'basic',
        1
      ),
      (
        v_id,
        '这位老技师有一手听发动机声音就能判断故障所在的绝妙本领，令人佩服不已。',
        'Zhè wèi lǎo jìshī yǒu yì shǒu tīng fādòngjī shēngyīn jiù néng pànduàn gùzhàng suǒzài de juémiào běnlǐng, lìng rén pèifú bùyǐ.',
        'Người thợ kỹ thuật cao tuổi này có tài nghệ tuyệt luân là chỉ cần nghe tiếng động cơ là có thể phán đoán chính xác chỗ hỏng hóc, khiến ai nấy đều vô cùng khâm phục.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2043] [本人] (běnrén) - bản thân tôi; đích thân người đó [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '本人'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '本人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ',
      pinyin = 'běnrén',
      meaning_vi = 'bản thân tôi; đích thân người đó',
      example_hanzi = '领取毕业证书必须由毕业生本人凭有效身份证件亲自签领。',
      example_pinyin = 'Lǐngqǔ bìyè zhèngshū bìxū yóu bìyèshēng běnrén píng yǒuxiào shēnfèn zhèngjiàn qīnzì qiānlǐng.',
      example_vi = 'Việc nhận bằng tốt nghiệp bắt buộc phải do đích thân sinh viên tốt nghiệp tự mình ký nhận dựa trên giấy tờ tùy thân hợp lệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '本人',
      'běnrén',
      'bản thân tôi; đích thân người đó',
      'Đại từ',
      'HSK 5',
      '领取毕业证书必须由毕业生本人凭有效身份证件亲自签领。',
      'Lǐngqǔ bìyè zhèngshū bìxū yóu bìyèshēng běnrén píng yǒuxiào shēnfèn zhèngjiàn qīnzì qiānlǐng.',
      'Việc nhận bằng tốt nghiệp bắt buộc phải do đích thân sinh viên tốt nghiệp tự mình ký nhận dựa trên giấy tờ tùy thân hợp lệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '领取毕业证书必须由毕业生本人凭有效身份证件亲自签领。',
        'Lǐngqǔ bìyè zhèngshū bìxū yóu bìyèshēng běnrén píng yǒuxiào shēnfèn zhèngjiàn qīnzì qiānlǐng.',
        'Việc nhận bằng tốt nghiệp bắt buộc phải do đích thân sinh viên tốt nghiệp tự mình ký nhận dựa trên giấy tờ tùy thân hợp lệ.',
        'basic',
        1
      ),
      (
        v_id,
        '对于大会上提出的这项新提案，我本人完全赞同并愿意全力协助推进落实。',
        'Duìyú dàhuì shàng tíchū de zhè xiàng xīn tí’àn, wǒ běnrén wánquán zàntóng bìng yuànyì quánlì xiézhù tuījìn luòshí.',
        'Đối với đề xuất mới được đưa ra tại đại hội lần này, cá nhân tôi hoàn toàn tán đồng và sẵn sàng dốc toàn lực hỗ trợ thúc đẩy triển khai thực hiện.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2044] [本质] (běnzhì) - bản chất (cốt lõi, bản tính căn bản bên trong) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '本质'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '本质'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'běnzhì',
      meaning_vi = 'bản chất (cốt lõi, bản tính căn bản bên trong)',
      example_hanzi = '我们看问题不能只看表面现象，而要抓住事物的本质。',
      example_pinyin = 'Wǒmen kàn wèntí bù néng zhǐ kàn biǎomiàn xiànxiàng, ér yào zhuāzhù shìwù de běnzhì.',
      example_vi = 'Chúng ta nhìn nhận vấn đề không thể chỉ nhìn hiện tượng bên ngoài, mà phải nắm bắt được bản chất cốt lõi của sự vật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '本质',
      'běnzhì',
      'bản chất (cốt lõi, bản tính căn bản bên trong)',
      'Danh từ',
      'HSK 5',
      '我们看问题不能只看表面现象，而要抓住事物的本质。',
      'Wǒmen kàn wèntí bù néng zhǐ kàn biǎomiàn xiànxiàng, ér yào zhuāzhù shìwù de běnzhì.',
      'Chúng ta nhìn nhận vấn đề không thể chỉ nhìn hiện tượng bên ngoài, mà phải nắm bắt được bản chất cốt lõi của sự vật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '我们看问题不能只看表面现象，而要抓住事物的本质。',
        'Wǒmen kàn wèntí bù néng zhǐ kàn biǎomiàn xiànxiàng, ér yào zhuāzhù shìwù de běnzhì.',
        'Chúng ta nhìn nhận vấn đề không thể chỉ nhìn hiện tượng bên ngoài, mà phải nắm bắt được bản chất cốt lõi của sự vật.',
        'basic',
        1
      ),
      (
        v_id,
        '教育的本质并不是单向灌输书本知识，而是启发学生的思维与激发内在潜能。',
        'Jiàoyù de běnzhì bìng bú shì dānxiàng guànshū shūběn zhīshi, ér shì qǐfā xuésheng de sīwéi yǔ jīfā nèizài qiánnéng.',
        'Bản chất của giáo dục không phải là nhồi nhét kiến thức sách vở một chiều, mà là khơi gợi tư duy và đánh thức tiềm năng nội tại của học sinh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2045] [彼此] (bǐcǐ) - lẫn nhau, hai bên đối phương; đôi bên [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '彼此'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '彼此'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ',
      pinyin = 'bǐcǐ',
      meaning_vi = 'lẫn nhau, hai bên đối phương; đôi bên',
      example_hanzi = '好朋友之间应当相互理解、彼此信任。',
      example_pinyin = 'Hǎo péngyou zhījiān yīngdāng xiānghù lǐjiě, bǐcǐ xìnrèn.',
      example_vi = 'Giữa những người bạn tốt với nhau nên thông cảm cho nhau và tin tưởng lẫn nhau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '彼此',
      'bǐcǐ',
      'lẫn nhau, hai bên đối phương; đôi bên',
      'Đại từ',
      'HSK 5',
      '好朋友之间应当相互理解、彼此信任。',
      'Hǎo péngyou zhījiān yīngdāng xiānghù lǐjiě, bǐcǐ xìnrèn.',
      'Giữa những người bạn tốt với nhau nên thông cảm cho nhau và tin tưởng lẫn nhau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '好朋友之间应当相互理解、彼此信任。',
        'Hǎo péngyou zhījiān yīngdāng xiānghù lǐjiě, bǐcǐ xìnrèn.',
        'Giữa những người bạn tốt với nhau nên thông cảm cho nhau và tin tưởng lẫn nhau.',
        'basic',
        1
      ),
      (
        v_id,
        '在激烈的商务谈判中，双方都展现出诚意并做出适度让步，最终增进了彼此的互利合作。',
        'Zài jīliè de shāngwù tánpàn zhōng, shuāngfāng dōu zhǎnxiàn chū chéngyì bìng zuòchū shìdù ràngbù, zuìzhōng zēngjìn le bǐcǐ de hùlì hézuò.',
        'Trong cuộc đàm phán thương mại căng thẳng, hai bên đều thể hiện thiện chí và nhượng bộ hợp lý, cuối cùng đã tăng cường mối quan hệ hợp tác đôi bên cùng có lợi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2046] [比分] (bǐfēn) - tỷ số trận đấu, điểm số thi đấu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '比分'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '比分'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bǐfēn',
      meaning_vi = 'tỷ số trận đấu, điểm số thi đấu',
      example_hanzi = '经过九十分钟的激烈角逐，两队最终以二比二的比分握手言和。',
      example_pinyin = 'Jīngguò jiǔshí fēnzhōng de jīliè jiǎozhú, liǎng duì zuìzhōng yǐ èr bǐ èr de bǐfēn wòshǒu yánhé.',
      example_vi = 'Sau chín mươi phút thi đấu giằng co quyết liệt, hai đội cuối cùng bắt tay hòa nhau với tỷ số hai đều.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '比分',
      'bǐfēn',
      'tỷ số trận đấu, điểm số thi đấu',
      'Danh từ',
      'HSK 5',
      '经过九十分钟的激烈角逐，两队最终以二比二的比分握手言和。',
      'Jīngguò jiǔshí fēnzhōng de jīliè jiǎozhú, liǎng duì zuìzhōng yǐ èr bǐ èr de bǐfēn wòshǒu yánhé.',
      'Sau chín mươi phút thi đấu giằng co quyết liệt, hai đội cuối cùng bắt tay hòa nhau với tỷ số hai đều.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '经过九十分钟的激烈角逐，两队最终以二比二的比分握手言和。',
        'Jīngguò jiǔshí fēnzhōng de jīliè jiǎozhú, liǎng duì zuìzhōng yǐ èr bǐ èr de bǐfēn wòshǒu yánhé.',
        'Sau chín mươi phút thi đấu giằng co quyết liệt, hai đội cuối cùng bắt tay hòa nhau với tỷ số hai đều.',
        'basic',
        1
      ),
      (
        v_id,
        '主队在比分一度落后的严峻形势下顶住压力，在比赛读秒阶段成功逆转战局。',
        'Zhǔduì zài bǐfēn yídù luòhòu de yánjùn xíngshì xià dǐngzhù yālì, zài bǐsài dúmiǎo jiēduàn chénggōng nìzhuǎn zhànjú.',
        'Đội chủ nhà dưới tình thế ngặt nghèo điểm số từng bị tụt lại phía sau đã chịu được áp lực, lội ngược dòng cục diện ngoạn mục ở những giây bù giờ cuối trận.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2047] [比例] (bǐlì) - tỷ lệ, tỷ xích, mức độ tương quan [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '比例'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '比例'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bǐlì',
      meaning_vi = 'tỷ lệ, tỷ xích, mức độ tương quan',
      example_hanzi = '制作这种特色蛋糕时，面粉和牛奶的比例必须严格控制好。',
      example_pinyin = 'Zhìzuò zhè zhǒng tèsè dàngāo shí, miànfěn hé niúnǎi de bǐlì bìxū yángé kòngzhì hǎo.',
      example_vi = 'Khi làm loại bánh ngọt đặc sản này, tỷ lệ giữa bột mì và sữa tươi bắt buộc phải kiểm soát thật chuẩn xác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '比例',
      'bǐlì',
      'tỷ lệ, tỷ xích, mức độ tương quan',
      'Danh từ',
      'HSK 5',
      '制作这种特色蛋糕时，面粉和牛奶的比例必须严格控制好。',
      'Zhìzuò zhè zhǒng tèsè dàngāo shí, miànfěn hé niúnǎi de bǐlì bìxū yángé kòngzhì hǎo.',
      'Khi làm loại bánh ngọt đặc sản này, tỷ lệ giữa bột mì và sữa tươi bắt buộc phải kiểm soát thật chuẩn xác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '制作这种特色蛋糕时，面粉和牛奶的比例必须严格控制好。',
        'Zhìzuò zhè zhǒng tèsè dàngāo shí, miànfěn hé niúnǎi de bǐlì bìxū yángé kòngzhì hǎo.',
        'Khi làm loại bánh ngọt đặc sản này, tỷ lệ giữa bột mì và sữa tươi bắt buộc phải kiểm soát thật chuẩn xác.',
        'basic',
        1
      ),
      (
        v_id,
        '随着高新技术产业的迅猛发展，研发经费在公司总支出中的比例逐年显著上升。',
        'Suízhe gāoxīn jìshù chǎnyè de xùnměng fāzhǎn, yánfā jīngfèi zài gōngsī zǒng zhīchū zhōng de bǐlì zhúnián xiǎnzhù shàngshēng.',
        'Cùng với sự phát triển thần tốc của các ngành công nghệ cao, tỷ lệ kinh phí nghiên cứu phát triển trong tổng chi của công ty tăng lên rõ rệt qua từng năm.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2048] [比喻] (bǐyù) - ví von, ẩn dụ; hình ảnh so sánh ví von [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '比喻'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '比喻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'bǐyù',
      meaning_vi = 'ví von, ẩn dụ; hình ảnh so sánh ví von',
      example_hanzi = '人们常用“辛勤的园丁”来生动比喻默默奉献的人民教师。',
      example_pinyin = 'Rénmen cháng yòng “xīnqín de yuándīng” lái shēngdòng bǐyù mòmò fèngxiàn de rénmín jiàoshī.',
      example_vi = 'Mọi người thường dùng hình ảnh “người làm vườn cần mẫn” để ví von sinh động cho những người thầy giáo âm thầm cống hiến.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '比喻',
      'bǐyù',
      'ví von, ẩn dụ; hình ảnh so sánh ví von',
      'Động từ / Danh từ',
      'HSK 5',
      '人们常用“辛勤的园丁”来生动比喻默默奉献的人民教师。',
      'Rénmen cháng yòng “xīnqín de yuándīng” lái shēngdòng bǐyù mòmò fèngxiàn de rénmín jiàoshī.',
      'Mọi người thường dùng hình ảnh “người làm vườn cần mẫn” để ví von sinh động cho những người thầy giáo âm thầm cống hiến.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '人们常用“辛勤的园丁”来生动比喻默默奉献的人民教师。',
        'Rénmen cháng yòng “xīnqín de yuándīng” lái shēngdòng bǐyù mòmò fèngxiàn de rénmín jiàoshī.',
        'Mọi người thường dùng hình ảnh “người làm vườn cần mẫn” để ví von sinh động cho những người thầy giáo âm thầm cống hiến.',
        'basic',
        1
      ),
      (
        v_id,
        '演讲者运用了许多贴近日常生活的生动比喻，把深奥复杂的经济学原理讲得通俗易懂。',
        'Yǎnjiǎngzhě yùnyòng le xǔduō tiējìn rìcháng shēnghuó de shēngdòng bǐyù, bǎ shēn’ào fùzá de jīngjìxué yuánlǐ jiǎng de tōngsú yìdǒng.',
        'Diễn giả đã vận dụng nhiều hình ảnh ví von sinh động gần gũi với đời sống thường nhật, giảng giải các nguyên lý kinh tế học thâm sâu phức tạp một cách dễ hiểu và đại chúng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2049] [必] (bì) - ắt, nhất định, tất yếu, phải [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '必'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '必'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'bì',
      meaning_vi = 'ắt, nhất định, tất yếu, phải',
      example_hanzi = '只要坚持不懈地付出努力，就必能迎来胜利的曙光。',
      example_pinyin = 'Zhǐyào jiānchí bú xiè de fùchū nǔlì, jiù bì néng yínglái shènglì de shǔguāng.',
      example_vi = 'Chỉ cần kiên trì nỗ lực không ngừng nghỉ, thì ắt sẽ đón được ánh rạng đông của thắng lợi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '必',
      'bì',
      'ắt, nhất định, tất yếu, phải',
      'Phó từ',
      'HSK 5',
      '只要坚持不懈地付出努力，就必能迎来胜利的曙光。',
      'Zhǐyào jiānchí bú xiè de fùchū nǔlì, jiù bì néng yínglái shènglì de shǔguāng.',
      'Chỉ cần kiên trì nỗ lực không ngừng nghỉ, thì ắt sẽ đón được ánh rạng đông của thắng lợi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '只要坚持不懈地付出努力，就必能迎来胜利的曙光。',
        'Zhǐyào jiānchí bú xiè de fùchū nǔlì, jiù bì néng yínglái shènglì de shǔguāng.',
        'Chỉ cần kiên trì nỗ lực không ngừng nghỉ, thì ắt sẽ đón được ánh rạng đông của thắng lợi.',
        'basic',
        1
      ),
      (
        v_id,
        '古人云“言必信，行必果”，这句话强调为人处世一定要讲求诚信与执行力。',
        'Gǔrén yún “yán bì xìn, xíng bì guǒ”, zhè jù huà qiángdiào wéirén chǔshì yídìng yào jiǎngqiú chéngxìn yǔ zhíxínglì.',
        'Người xưa có câu “lời nói ắt phải giữ chữ tín, hành động ắt phải dứt khoát có kết quả”, câu này nhấn mạnh cách đối nhân xử thế nhất định phải coi trọng chữ tín và năng lực hành động.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2050] [毕竟] (bìjìng) - rốt cuộc, dù sao thì, suy cho cùng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '毕竟'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '毕竟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'bìjìng',
      meaning_vi = 'rốt cuộc, dù sao thì, suy cho cùng',
      example_hanzi = '小明毕竟还是个七岁的孩子，有些事情我们不能对他要求太苛刻。',
      example_pinyin = 'Xiǎomíng bìjìng hái shì gè qī suì de háizi, yǒuxiē shìqing wǒmen bù néng duì tā yāoqiú tài kēkè.',
      example_vi = 'Tiểu Minh dù sao thì vẫn chỉ là một đứa trẻ bảy tuổi, có những việc chúng ta không nên đòi hỏi ở em quá khắt khe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '毕竟',
      'bìjìng',
      'rốt cuộc, dù sao thì, suy cho cùng',
      'Phó từ',
      'HSK 5',
      '小明毕竟还是个七岁的孩子，有些事情我们不能对他要求太苛刻。',
      'Xiǎomíng bìjìng hái shì gè qī suì de háizi, yǒuxiē shìqing wǒmen bù néng duì tā yāoqiú tài kēkè.',
      'Tiểu Minh dù sao thì vẫn chỉ là một đứa trẻ bảy tuổi, có những việc chúng ta không nên đòi hỏi ở em quá khắt khe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '小明毕竟还是个七岁的孩子，有些事情我们不能对他要求太苛刻。',
        'Xiǎomíng bìjìng hái shì gè qī suì de háizi, yǒuxiē shìqing wǒmen bù néng duì tā yāoqiú tài kēkè.',
        'Tiểu Minh dù sao thì vẫn chỉ là một đứa trẻ bảy tuổi, có những việc chúng ta không nên đòi hỏi ở em quá khắt khe.',
        'basic',
        1
      ),
      (
        v_id,
        '线上视频会议虽然高效便捷，但毕竟无法完全替代面对面商务会谈所建立的情感信任。',
        'Xiànshàng shìpín huìyì suīrán gāoxiào biànjié, dàn bìjìng wúfǎ wánquán tìdài miànduìmiàn shāngwù huìtán suǒ jiànlì de qínggǎn xìnrèn.',
        'Hội nghị truyền hình trực tuyến tuy nhanh chóng và tiện lợi, nhưng suy cho cùng vẫn không thể thay thế hoàn toàn sự tin cậy cảm xúc được gầy dựng qua các buổi gặp gỡ đàm phán thương mại trực tiếp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2051] [避免] (bìmiǎn) - tránh, né tránh (xung đột, sai lầm, rủi ro, tai nạn) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '避免'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '避免'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bìmiǎn',
      meaning_vi = 'tránh, né tránh (xung đột, sai lầm, rủi ro, tai nạn)',
      example_hanzi = '开车时集中注意力可以有效避免交通事故的发生。',
      example_pinyin = 'Kāichē shí jízhōng zhùyìlì kěyǐ yǒuxiào bìmiǎn jiāotōng shìgù de fāshēng.',
      example_vi = 'Khi lái xe tập trung chú ý có thể tránh được tai nạn giao thông xảy ra một cách hiệu quả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '避免',
      'bìmiǎn',
      'tránh, né tránh (xung đột, sai lầm, rủi ro, tai nạn)',
      'Động từ',
      'HSK 5',
      '开车时集中注意力可以有效避免交通事故的发生。',
      'Kāichē shí jízhōng zhùyìlì kěyǐ yǒuxiào bìmiǎn jiāotōng shìgù de fāshēng.',
      'Khi lái xe tập trung chú ý có thể tránh được tai nạn giao thông xảy ra một cách hiệu quả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '开车时集中注意力可以有效避免交通事故的发生。',
        'Kāichē shí jízhōng zhùyìlì kěyǐ yǒuxiào bìmiǎn jiāotōng shìgù de fāshēng.',
        'Khi lái xe tập trung chú ý có thể tránh được tai nạn giao thông xảy ra một cách hiệu quả.',
        'basic',
        1
      ),
      (
        v_id,
        '在商务合作中，双方应在合同中明确权责划分，以避免日后产生不必要的法律纠纷。',
        'Zài shāngwù hézuò zhōng, shuāngfāng yīng zài hétong zhōng míngquè quánzé huàfēn, yǐ bìmiǎn rìhòu chǎnshēng bú bìyào de fǎlǜ jiūfēn.',
        'Trong hợp tác kinh doanh, hai bên nên phân định rõ ràng quyền hạn và trách nhiệm trong hợp đồng, nhằm tránh phát sinh tranh chấp pháp lý không đáng có về sau.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2052] [闭幕式] (bìmùshì) - lễ bế mạc (đại hội thể thao, liên hoan phim, triển lãm) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '闭幕式'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '闭幕式'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bìmùshì',
      meaning_vi = 'lễ bế mạc (đại hội thể thao, liên hoan phim, triển lãm)',
      example_hanzi = '昨晚举行的运动会闭幕式演出了精彩绝伦的文艺节目。',
      example_pinyin = 'Zuówǎn jǔxíng de yùndònghuì bìmùshì yǎnchū le jīngcǎi juélún de wényì jiémù.',
      example_vi = 'Lễ bế mạc đại hội thể thao tổ chức tối qua đã trình diễn các tiết mục văn nghệ vô cùng đặc sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '闭幕式',
      'bìmùshì',
      'lễ bế mạc (đại hội thể thao, liên hoan phim, triển lãm)',
      'Danh từ',
      'HSK 5',
      '昨晚举行的运动会闭幕式演出了精彩绝伦的文艺节目。',
      'Zuówǎn jǔxíng de yùndònghuì bìmùshì yǎnchū le jīngcǎi juélún de wényì jiémù.',
      'Lễ bế mạc đại hội thể thao tổ chức tối qua đã trình diễn các tiết mục văn nghệ vô cùng đặc sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '昨晚举行的运动会闭幕式演出了精彩绝伦的文艺节目。',
        'Zuówǎn jǔxíng de yùndònghuì bìmùshì yǎnchū le jīngcǎi juélún de wényì jiémù.',
        'Lễ bế mạc đại hội thể thao tổ chức tối qua đã trình diễn các tiết mục văn nghệ vô cùng đặc sắc.',
        'basic',
        1
      ),
      (
        v_id,
        '在国际电影节的闭幕式上，组委会隆重颁发了备受瞩目的最佳导演与最佳影片金奖。',
        'Zài guójì diànyǐngjié de bìmùshì shàng, zǔwěihuì lóngzhòng bānfā le bèishòu zhǔmù de zuìjiā dǎoyǎn yǔ zuìjiā yǐngpiàn jīnjiǎng.',
        'Tại lễ bế mạc liên hoan phim quốc tế, ban tổ chức đã long trọng trao các giải vàng đạo diễn xuất sắc nhất và phim truyện xuất sắc nhất thu hút nhiều sự chú ý.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2053] [必然] (bìrán) - tất nhiên, tất yếu; tính tất nhiên, quy luật không thể tránh [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '必然'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '必然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'bìrán',
      meaning_vi = 'tất nhiên, tất yếu; tính tất nhiên, quy luật không thể tránh',
      example_hanzi = '不努力付出汗水，考试不及格是必然的结果。',
      example_pinyin = 'Bù nǔlì fùchū hànshuǐ, kǎoshì bù jígé shì bìrán de jiéguǒ.',
      example_vi = 'Không chịu nỗ lực đổ mồ hôi, thì thi trượt là một kết quả tất nhiên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '必然',
      'bìrán',
      'tất nhiên, tất yếu; tính tất nhiên, quy luật không thể tránh',
      'Tính từ / Phó từ',
      'HSK 5',
      '不努力付出汗水，考试不及格是必然的结果。',
      'Bù nǔlì fùchū hànshuǐ, kǎoshì bù jígé shì bìrán de jiéguǒ.',
      'Không chịu nỗ lực đổ mồ hôi, thì thi trượt là một kết quả tất nhiên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '不努力付出汗水，考试不及格是必然的结果。',
        'Bù nǔlì fùchū hànshuǐ, kǎoshì bù jígé shì bìrán de jiéguǒ.',
        'Không chịu nỗ lực đổ mồ hôi, thì thi trượt là một kết quả tất nhiên.',
        'basic',
        1
      ),
      (
        v_id,
        '随着数字经济的深度普及，传统零售行业走向线上线下融合已是不可逆转的必然趋势。',
        'Suízhe shùzì jīngjì de shēndù pǔjí, chuántǒng língshòu hángyè zǒuxiàng xiànshàng xiànxià rónghé yǐ shì bùkě nìzhuǎn de bìrán qūshì.',
        'Cùng với sự phổ cập sâu rộng của nền kinh tế số, ngành bán lẻ truyền thống tiến tới kết hợp trực tuyến và trực tiếp đã là xu thế tất yếu không thể đảo ngược.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2054] [必需] (bìxū) - thiết yếu, bắt buộc phải có, không thể thiếu [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '必需'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '必需'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'bìxū',
      meaning_vi = 'thiết yếu, bắt buộc phải có, không thể thiếu',
      example_hanzi = '阳光、空气和水是人类生存必需的自然资源。',
      example_pinyin = 'Yángguāng, kōngqì hé shuǐ shì rénlèi shēngcún bìxū de zìrán zīyuán.',
      example_vi = 'Ánh nắng, không khí và nước là những tài nguyên thiên nhiên thiết yếu cho sự sinh tồn của loài người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '必需',
      'bìxū',
      'thiết yếu, bắt buộc phải có, không thể thiếu',
      'Tính từ / Động từ',
      'HSK 5',
      '阳光、空气和水是人类生存必需的自然资源。',
      'Yángguāng, kōngqì hé shuǐ shì rénlèi shēngcún bìxū de zìrán zīyuán.',
      'Ánh nắng, không khí và nước là những tài nguyên thiên nhiên thiết yếu cho sự sinh tồn của loài người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '阳光、空气和水是人类生存必需的自然资源。',
        'Yángguāng, kōngqì hé shuǐ shì rénlèi shēngcún bìxū de zìrán zīyuán.',
        'Ánh nắng, không khí và nước là những tài nguyên thiên nhiên thiết yếu cho sự sinh tồn của loài người.',
        'basic',
        1
      ),
      (
        v_id,
        '出门长途徒步探险之前，必须提前备齐指南针、急救药品和净水片等户外必需装备。',
        'Chūmén chángtú túbù tànxiǎn zhīqián, bìxū tíqián bèi qí zhǐnánzhēn, jíjiù yàopǐn hé jìngshuǐpiàn děng hùwài bìxū zhuāngbèi.',
        'Trước khi lên đường đi thám hiểm đi bộ đường dài, bắt buộc phải chuẩn bị đầy đủ các trang bị thiết yếu ngoài trời như la bàn, thuốc cấp cứu và viên lọc nước.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2055] [必要] (bìyào) - cần thiết, thiết yếu (điều kiện, thủ tục, biện pháp) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '必要'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '必要'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'bìyào',
      meaning_vi = 'cần thiết, thiết yếu (điều kiện, thủ tục, biện pháp)',
      example_hanzi = '在做重大决定之前，征求父母和专业人士的意见是非常有必要的。',
      example_pinyin = 'Zài zuò zhòngdà juédìng zhīqián, zhēngqiú fùmǔ hé zhuānyè rénshì de yìjiàn shì fēicháng yǒu bìyào de.',
      example_vi = 'Trước khi đưa ra quyết định trọng đại, việc tham khảo ý kiến của cha mẹ và các chuyên gia là vô cùng cần thiết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '必要',
      'bìyào',
      'cần thiết, thiết yếu (điều kiện, thủ tục, biện pháp)',
      'Tính từ',
      'HSK 5',
      '在做重大决定之前，征求父母和专业人士的意见是非常有必要的。',
      'Zài zuò zhòngdà juédìng zhīqián, zhēngqiú fùmǔ hé zhuānyè rénshì de yìjiàn shì fēicháng yǒu bìyào de.',
      'Trước khi đưa ra quyết định trọng đại, việc tham khảo ý kiến của cha mẹ và các chuyên gia là vô cùng cần thiết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在做重大决定之前，征求父母和专业人士的意见是非常有必要的。',
        'Zài zuò zhòngdà juédìng zhīqián, zhēngqiú fùmǔ hé zhuānyè rénshì de yìjiàn shì fēicháng yǒu bìyào de.',
        'Trước khi đưa ra quyết định trọng đại, việc tham khảo ý kiến của cha mẹ và các chuyên gia là vô cùng cần thiết.',
        'basic',
        1
      ),
      (
        v_id,
        '为了确保施工现场的零事故，工程部采取了一切必要的安全防护措施与监管手段。',
        'Wèile quèbǎo shīgōng xiànchǎng de líng shìgù, gōngchéngbù cǎiqǔ le yíqiè bìyào de ānquán fánghù cuòshī yǔ jiānguǎn shǒuduàn.',
        'Để đảm bảo không xảy ra tai nạn nào tại công trường thi công, phòng kỹ thuật công trình đã áp dụng mọi biện pháp phòng hộ an toàn và phương thức giám sát cần thiết.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2056] [便] (biàn) - thì, liền, ngay (tương đương 就); thuận tiện [Phó từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '便'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '便'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Liên từ',
      pinyin = 'biàn',
      meaning_vi = 'thì, liền, ngay (tương đương 就); thuận tiện',
      example_hanzi = '下课铃声一响，同学们便迫不及待地跑出了教室。',
      example_pinyin = 'Xiàkè língshēng yì xiǎng, tóngxuémen biàn pòbùjídài de pǎo chū le jiàoshì.',
      example_vi = 'Chuông tan học vừa reo lên, các bạn học sinh liền nóng lòng chạy ùa ra khỏi lớp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '便',
      'biàn',
      'thì, liền, ngay (tương đương 就); thuận tiện',
      'Phó từ / Liên từ',
      'HSK 5',
      '下课铃声一响，同学们便迫不及待地跑出了教室。',
      'Xiàkè língshēng yì xiǎng, tóngxuémen biàn pòbùjídài de pǎo chū le jiàoshì.',
      'Chuông tan học vừa reo lên, các bạn học sinh liền nóng lòng chạy ùa ra khỏi lớp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '下课铃声一响，同学们便迫不及待地跑出了教室。',
        'Xiàkè língshēng yì xiǎng, tóngxuémen biàn pòbùjídài de pǎo chū le jiàoshì.',
        'Chuông tan học vừa reo lên, các bạn học sinh liền nóng lòng chạy ùa ra khỏi lớp.',
        'basic',
        1
      ),
      (
        v_id,
        '如贵方在合同执行过程中遇到任何疑问，便可随时致电我司客户服务专线进行咨询。',
        'Rú guìfāng zài hétong zhíxíng guòchéng zhōng yùdào rènhé yíwèn, biàn kě suíshí zhìdiàn wǒ sī kèhù fúwù zhuānxiàn jìnxíng zīxún.',
        'Nếu quý công ty gặp bất kỳ thắc mắc nào trong quá trình thực hiện hợp đồng, thì có thể gọi điện đến đường dây nóng chăm sóc khách hàng của công ty chúng tôi bất cứ lúc nào để được tư vấn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2057] [变动] (biàndòng) - biến động, thay đổi (nhân sự, giá cả, thời cuộc) [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '变动'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '变动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'biàndòng',
      meaning_vi = 'biến động, thay đổi (nhân sự, giá cả, thời cuộc)',
      example_hanzi = '由于原作者时间冲突，今天的讲座日程安排有了临时变动。',
      example_pinyin = 'Yóuyú yuán zuòzhě shíjiān chōngtū, jīntiān de jiǎngzuò rìchéng ānpái yǒu le línshí biàndòng.',
      example_vi = 'Do tác giả bị trùng lịch trình, nên lịch sắp xếp buổi tọa đàm hôm nay có sự thay đổi tạm thời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '变动',
      'biàndòng',
      'biến động, thay đổi (nhân sự, giá cả, thời cuộc)',
      'Động từ / Danh từ',
      'HSK 5',
      '由于原作者时间冲突，今天的讲座日程安排有了临时变动。',
      'Yóuyú yuán zuòzhě shíjiān chōngtū, jīntiān de jiǎngzuò rìchéng ānpái yǒu le línshí biàndòng.',
      'Do tác giả bị trùng lịch trình, nên lịch sắp xếp buổi tọa đàm hôm nay có sự thay đổi tạm thời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '由于原作者时间冲突，今天的讲座日程安排有了临时变动。',
        'Yóuyú yuán zuòzhě shíjiān chōngtū, jīntiān de jiǎngzuò rìchéng ānpái yǒu le línshí biàndòng.',
        'Do tác giả bị trùng lịch trình, nên lịch sắp xếp buổi tọa đàm hôm nay có sự thay đổi tạm thời.',
        'basic',
        1
      ),
      (
        v_id,
        '国际原油市场价格的大幅剧烈变动，给许多跨国航空公司带来了巨大的运营成本压力。',
        'Guójì yuányóu shìchǎng jiàgé de dà fú jùliè biàndòng, gěi xǔduō kuàguó hángkōng gōngsī dài lái le jùdà de yùnyíng chéngběn yālì.',
        'Sự biến động dữ dội với biên độ lớn của giá dầu thô trên thị trường quốc tế đã đem lại áp lực chi phí vận hành to lớn cho nhiều hãng hàng không đa quốc gia.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2058] [便利] (biànlì) - tiện lợi, thuận lợi, tiện ích; tạo điều kiện thuận lợi [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '便利'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '便利'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'biànlì',
      meaning_vi = 'tiện lợi, thuận lợi, tiện ích; tạo điều kiện thuận lợi',
      example_hanzi = '现代发达的高速铁路网络为人们的商务出行提供了极大的便利。',
      example_pinyin = 'Xiàndài fādá de gāosù tiělù wǎngluò wèi rénmen de shāngwù chūxíng tígōng le jí dà de biànlì.',
      example_vi = 'Mạng lưới đường sắt cao tốc hiện đại phát triển đã mang lại sự tiện lợi vô cùng to lớn cho những chuyến đi công tác của mọi người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '便利',
      'biànlì',
      'tiện lợi, thuận lợi, tiện ích; tạo điều kiện thuận lợi',
      'Tính từ / Động từ',
      'HSK 5',
      '现代发达的高速铁路网络为人们的商务出行提供了极大的便利。',
      'Xiàndài fādá de gāosù tiělù wǎngluò wèi rénmen de shāngwù chūxíng tígōng le jí dà de biànlì.',
      'Mạng lưới đường sắt cao tốc hiện đại phát triển đã mang lại sự tiện lợi vô cùng to lớn cho những chuyến đi công tác của mọi người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '现代发达的高速铁路网络为人们的商务出行提供了极大的便利。',
        'Xiàndài fādá de gāosù tiělù wǎngluò wèi rénmen de shāngwù chūxíng tígōng le jí dà de biànlì.',
        'Mạng lưới đường sắt cao tốc hiện đại phát triển đã mang lại sự tiện lợi vô cùng to lớn cho những chuyến đi công tác của mọi người.',
        'basic',
        1
      ),
      (
        v_id,
        '当地政府不断简化外商投资审批流程，旨在为企业落地兴业提供最大程度的便利。',
        'Dāngdì zhèngfǔ búduàn jiǎnhuà wàishāng tóuzī shěnpī liúchéng, zhǐ zài wèi qǐyè luòdì xīngyè tígōng zuì dà chéngdù de biànlì.',
        'Chính quyền sở tại không ngừng tinh giản quy trình xét duyệt đầu tư nước ngoài, nhằm tạo điều kiện thuận lợi tối đa cho các doanh nghiệp đặt chân xây dựng sự nghiệp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2059] [便利店] (biànlìdiàn) - cửa hàng tiện lợi (mở cửa 24/7) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '便利店'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '便利店'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'biànlìdiàn',
      meaning_vi = 'cửa hàng tiện lợi (mở cửa 24/7)',
      example_hanzi = '我家小区楼下有一家二十四小时营业的便利店。',
      example_pinyin = 'Wǒ jiā xiǎoqū lóu xià yǒu yì jiā èrshísì xiǎoshí yíngyè de biànlìdiàn.',
      example_vi = 'Dưới chân tòa chung cư nhà tôi có một cửa hàng tiện lợi mở cửa phục vụ hai mươi bốn giờ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '便利店',
      'biànlìdiàn',
      'cửa hàng tiện lợi (mở cửa 24/7)',
      'Danh từ',
      'HSK 5',
      '我家小区楼下有一家二十四小时营业的便利店。',
      'Wǒ jiā xiǎoqū lóu xià yǒu yì jiā èrshísì xiǎoshí yíngyè de biànlìdiàn.',
      'Dưới chân tòa chung cư nhà tôi có một cửa hàng tiện lợi mở cửa phục vụ hai mươi bốn giờ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '我家小区楼下有一家二十四小时营业的便利店。',
        'Wǒ jiā xiǎoqū lóu xià yǒu yì jiā èrshísì xiǎoshí yíngyè de biànlìdiàn.',
        'Dưới chân tòa chung cư nhà tôi có một cửa hàng tiện lợi mở cửa phục vụ hai mươi bốn giờ.',
        'basic',
        1
      ),
      (
        v_id,
        '便利店不仅售卖日常食品和生活日用品，还能为社区居民提供代收快递和缴费等多元服务。',
        'Biànlìdiàn bùjǐn shòumài rìcháng shípǐn hé shēnghuó rìyòngpǐn, hái néng wèi shèqū jūmín tígōng dàishōu kuàidì hé jiǎofèi děng duōyuán fúwù.',
        'Cửa hàng tiện lợi không chỉ bày bán thực phẩm hằng ngày và đồ dùng sinh hoạt, mà còn có thể cung cấp các dịch vụ đa dạng như nhận bưu phẩm hộ và thanh toán hóa đơn cho cư dân trong khu vực.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2060] [标题] (biātí) - tiêu đề, đề mục, tựa đề (bài viết, tin tức, slide thuyết trình) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '标题'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '标题'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'biātí',
      meaning_vi = 'tiêu đề, đề mục, tựa đề (bài viết, tin tức, slide thuyết trình)',
      example_hanzi = '写文章时要想出一个引人注目的好标题。',
      example_pinyin = 'Xiě wénzhāng shí yào xiǎng chū yí gè yǐnrénzhùmù de hǎo biātí.',
      example_vi = 'Khi viết bài cần nghĩ ra một tiêu đề hay thu hút sự chú ý của người đọc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '标题',
      'biātí',
      'tiêu đề, đề mục, tựa đề (bài viết, tin tức, slide thuyết trình)',
      'Danh từ',
      'HSK 5',
      '写文章时要想出一个引人注目的好标题。',
      'Xiě wénzhāng shí yào xiǎng chū yí gè yǐnrénzhùmù de hǎo biātí.',
      'Khi viết bài cần nghĩ ra một tiêu đề hay thu hút sự chú ý của người đọc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '写文章时要想出一个引人注目的好标题。',
        'Xiě wénzhāng shí yào xiǎng chū yí gè yǐnrénzhùmù de hǎo biātí.',
        'Khi viết bài cần nghĩ ra một tiêu đề hay thu hút sự chú ý của người đọc.',
        'basic',
        1
      ),
      (
        v_id,
        '许多网络新闻为了吸引点击率，故意制作夸张失实甚至误导读者的虚假标题。',
        'Xǔduō wǎngluò xīnwén wèile xīyǐn diǎnjīlǜ, gùyì zhìzuò kuāzhāng shīshí shènzhì wùdǎo dúzhě de xūjiǎ biātí.',
        'Nhiều bản tin mạng vì để câu lượt nhấp chuột mà cố ý giật những tiêu đề giả mạo phóng đại sai sự thật, thậm chí gây hiểu lầm cho độc giả.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2061] [标志] (biāozhì) - biểu tượng, dấu mốc, biển báo; đánh dấu bước ngoặt [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '标志'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '标志'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'biāozhì',
      meaning_vi = 'biểu tượng, dấu mốc, biển báo; đánh dấu bước ngoặt',
      example_hanzi = '看到那个红色的禁止掉头交通标志了吗？',
      example_pinyin = 'Kàndào nà ge hóngsè de jìnzhǐ diàotóu jiāotōng biāozhì le ma?',
      example_vi = 'Bạn có nhìn thấy biển báo giao thông cấm quay đầu xe màu đỏ kia không?'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '标志',
      'biāozhì',
      'biểu tượng, dấu mốc, biển báo; đánh dấu bước ngoặt',
      'Danh từ / Động từ',
      'HSK 5',
      '看到那个红色的禁止掉头交通标志了吗？',
      'Kàndào nà ge hóngsè de jìnzhǐ diàotóu jiāotōng biāozhì le ma?',
      'Bạn có nhìn thấy biển báo giao thông cấm quay đầu xe màu đỏ kia không?'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '看到那个红色的禁止掉头交通标志了吗？',
        'Kàndào nà ge hóngsè de jìnzhǐ diàotóu jiāotōng biāozhì le ma?',
        'Bạn có nhìn thấy biển báo giao thông cấm quay đầu xe màu đỏ kia không?',
        'basic',
        1
      ),
      (
        v_id,
        '这颗新型通信卫星的成功发射，标志着我国航空航天技术跨上了一个全新的台阶。',
        'Zhè kē xīnxíng tōngxìn wèixīng de chénggōng fāshè, biāozhì zhe wǒ guó hángkōng hángtiān jìshù kuà shàng le yí gè quánxīn de táijiē.',
        'Việc phóng thành công vệ tinh viễn thông kiểu mới này đánh dấu kỹ thuật hàng không vũ trụ nước ta đã bước lên một tầm cao hoàn toàn mới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2062] [表达] (biǎodá) - diễn đạt, bày tỏ, bộc lộ (suy nghĩ, tình cảm, quan điểm) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '表达'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '表达'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'biǎodá',
      meaning_vi = 'diễn đạt, bày tỏ, bộc lộ (suy nghĩ, tình cảm, quan điểm)',
      example_hanzi = '他性格有些内向，平时不太善于用言语表达自己的情感。',
      example_pinyin = 'Tā xìnggé yǒuxiē nèixiàng, píngshí bú tài shànyú yòng yányǔ biǎodá zìjǐ de qínggǎn.',
      example_vi = 'Tính cách của anh ấy hơi hướng nội, bình thường không giỏi dùng lời nói để bày tỏ tình cảm của mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '表达',
      'biǎodá',
      'diễn đạt, bày tỏ, bộc lộ (suy nghĩ, tình cảm, quan điểm)',
      'Động từ',
      'HSK 5',
      '他性格有些内向，平时不太善于用言语表达自己的情感。',
      'Tā xìnggé yǒuxiē nèixiàng, píngshí bú tài shànyú yòng yányǔ biǎodá zìjǐ de qínggǎn.',
      'Tính cách của anh ấy hơi hướng nội, bình thường không giỏi dùng lời nói để bày tỏ tình cảm của mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他性格有些内向，平时不太善于用言语表达自己的情感。',
        'Tā xìnggé yǒuxiē nèixiàng, píngshí bú tài shànyú yòng yányǔ biǎodá zìjǐ de qínggǎn.',
        'Tính cách của anh ấy hơi hướng nội, bình thường không giỏi dùng lời nói để bày tỏ tình cảm của mình.',
        'basic',
        1
      ),
      (
        v_id,
        '代表团团长在闭幕答谢宴会上发表致辞，向东道主的热情接待表达了由衷的感谢。',
        'Dàibiǎotuán tuánzhǎng zài bìmù dáxiè yànhuì shàng fābiǎo zhìcí, xiàng dōngdàozhǔ de rèqíng jiēdài biǎodá le yóuzhōng de gǎnxiè.',
        'Trưởng đoàn đại biểu đã phát biểu chúc mừng tại tiệc chiêu đãi cảm ơn bế mạc, bày tỏ lòng biết ơn chân thành trước sự tiếp đón nồng hậu của nước chủ nhà.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2063] [表面] (biǎomiàn) - bề mặt; vẻ bên ngoài, bề ngoài [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '表面'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '表面'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'biǎomiàn',
      meaning_vi = 'bề mặt; vẻ bên ngoài, bề ngoài',
      example_hanzi = '请大家用干净柔软的抹布擦拭桌子表面。',
      example_pinyin = 'Qǐng dàjiā yòng gānjìng róuruǎn de mābù cāshì zhuōzi biǎomiàn.',
      example_vi = 'Xin mọi người hãy dùng khăn lau mềm sạch lau chùi bề mặt bàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '表面',
      'biǎomiàn',
      'bề mặt; vẻ bên ngoài, bề ngoài',
      'Danh từ',
      'HSK 5',
      '请大家用干净柔软的抹布擦拭桌子表面。',
      'Qǐng dàjiā yòng gānjìng róuruǎn de mābù cāshì zhuōzi biǎomiàn.',
      'Xin mọi người hãy dùng khăn lau mềm sạch lau chùi bề mặt bàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '请大家用干净柔软的抹布擦拭桌子表面。',
        'Qǐng dàjiā yòng gānjìng róuruǎn de mābù cāshì zhuōzi biǎomiàn.',
        'Xin mọi người hãy dùng khăn lau mềm sạch lau chùi bề mặt bàn.',
        'basic',
        1
      ),
      (
        v_id,
        '表面看起来这只是一起普通的劳动合同纠纷，实际上却牵涉到复杂的知识产权归属争议。',
        'Biǎomiàn kàn qǐlái zhè zhǐ shì yì qǐ pǔtōng de láodòng hétong jiūfēn, shíjì shang què qiānshè dào fùzá de zhīshi chǎnquán guīshǔ zhēngyì.',
        'Bề ngoài nhìn vào đây chỉ là một vụ tranh chấp hợp đồng lao động bình thường, nhưng trên thực tế lại dính dáng đến sự tranh cãi phức tạp về quyền sở hữu trí tuệ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2064] [表明] (biǎomíng) - chỉ rõ, chứng tỏ, làm rõ (thái độ, lập trường, kết quả số liệu) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '表明'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '表明'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'biǎomíng',
      meaning_vi = 'chỉ rõ, chứng tỏ, làm rõ (thái độ, lập trường, kết quả số liệu)',
      example_hanzi = '科学研究结果表明，规律的作息时间对维持人体免疫力至关重要。',
      example_pinyin = 'Kēxué yánjiū jiéguǒ biǎomíng, guīlǜ de zuòxī shíjiān duì wéichí réntǐ miǎnyìlì zhìguān zhòngyào.',
      example_vi = 'Kết quả nghiên cứu khoa học chỉ rõ rằng, thời gian sinh hoạt làm việc nghỉ ngơi điều độ có ý nghĩa vô cùng sống còn đối với việc duy trì sức đề kháng của cơ thể.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '表明',
      'biǎomíng',
      'chỉ rõ, chứng tỏ, làm rõ (thái độ, lập trường, kết quả số liệu)',
      'Động từ',
      'HSK 5',
      '科学研究结果表明，规律的作息时间对维持人体免疫力至关重要。',
      'Kēxué yánjiū jiéguǒ biǎomíng, guīlǜ de zuòxī shíjiān duì wéichí réntǐ miǎnyìlì zhìguān zhòngyào.',
      'Kết quả nghiên cứu khoa học chỉ rõ rằng, thời gian sinh hoạt làm việc nghỉ ngơi điều độ có ý nghĩa vô cùng sống còn đối với việc duy trì sức đề kháng của cơ thể.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '科学研究结果表明，规律的作息时间对维持人体免疫力至关重要。',
        'Kēxué yánjiū jiéguǒ biǎomíng, guīlǜ de zuòxī shíjiān duì wéichí réntǐ miǎnyìlì zhìguān zhòngyào.',
        'Kết quả nghiên cứu khoa học chỉ rõ rằng, thời gian sinh hoạt làm việc nghỉ ngơi điều độ có ý nghĩa vô cùng sống còn đối với việc duy trì sức đề kháng của cơ thể.',
        'basic',
        1
      ),
      (
        v_id,
        '外交部发言人在记者招待会上严正表明了我方在维护国家领土主权问题上的坚定原则立场。',
        'Wàijiāobù fāyánrén zài jìzhě zhāodàihuì shàng yánzhèng biǎomíng le wǒ fāng zài wéihù guójiā lǐngtǔ zhǔquán wèntí shàng de jiāndìng yuánzé lìchǎng.',
        'Người phát ngôn Bộ Ngoại giao tại buổi họp báo đã nêu rõ lập trường nguyên tắc kiên định của phía chúng ta trong vấn đề bảo vệ chủ quyền lãnh thổ quốc gia.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2065] [表情] (biǎoqíng) - biểu cảm, nét mặt, sắc mặt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '表情'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '表情'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'biǎoqíng',
      meaning_vi = 'biểu cảm, nét mặt, sắc mặt',
      example_hanzi = '听到这个令人振奋的好消息，他的脸上露出了欣慰的表情。',
      example_pinyin = 'Tīngdào zhè gè lìngrén zhènfèn de hǎo xiāoxi, tā de liǎn shàng lùchū le xīnwèi de biǎoqíng.',
      example_vi = 'Nghe được tin tốt lành phấn khởi này, trên gương mặt anh ấy đã lộ ra vẻ biểu cảm đầy an lòng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '表情',
      'biǎoqíng',
      'biểu cảm, nét mặt, sắc mặt',
      'Danh từ',
      'HSK 5',
      '听到这个令人振奋的好消息，他的脸上露出了欣慰的表情。',
      'Tīngdào zhè gè lìngrén zhènfèn de hǎo xiāoxi, tā de liǎn shàng lùchū le xīnwèi de biǎoqíng.',
      'Nghe được tin tốt lành phấn khởi này, trên gương mặt anh ấy đã lộ ra vẻ biểu cảm đầy an lòng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '听到这个令人振奋的好消息，他的脸上露出了欣慰的表情。',
        'Tīngdào zhè gè lìngrén zhènfèn de hǎo xiāoxi, tā de liǎn shàng lùchū le xīnwèi de biǎoqíng.',
        'Nghe được tin tốt lành phấn khởi này, trên gương mặt anh ấy đã lộ ra vẻ biểu cảm đầy an lòng.',
        'basic',
        1
      ),
      (
        v_id,
        '优秀的演员能够通过极其细微的面部表情和眼神变化，深刻生动地刻画出角色复杂的心理冲突。',
        'Yōuxiù de yǎnyuán nénggòu tōngguò jíqí xìwēi de miànbù biǎoqíng hé yǎnshén biànhuà, shēnkè shēngdòng de kèhuà chū juésè fùzá de xīnlǐ chōngtū.',
        'Một diễn viên xuất sắc có thể thông qua nét mặt và ánh mắt biến hóa cực kỳ tinh tế để khắc họa sinh động sâu sắc những xung đột tâm lý phức tạp của nhân vật.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2066] [别] (bié) - đừng; khác (biérén, biéde); ghim, cài; từ biệt [Phó từ / Đại từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '别'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '别'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Đại từ / Động từ',
      pinyin = 'bié',
      meaning_vi = 'đừng; khác (biérén, biéde); ghim, cài; từ biệt',
      example_hanzi = '天气预报说今天下午有雷阵雨，出门别忘了带雨伞。',
      example_pinyin = 'Tiānqì yùbào shuō jīntiān xiàwǔ yǒu léizhènyǔ, chūmén bié wàng le dài yǔsǎn.',
      example_vi = 'Dự báo thời tiết nói chiều nay có mưa rào kèm sấm sét, ra ngoài đừng quên mang theo ô nhé.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '别',
      'bié',
      'đừng; khác (biérén, biéde); ghim, cài; từ biệt',
      'Phó từ / Đại từ / Động từ',
      'HSK 5',
      '天气预报说今天下午有雷阵雨，出门别忘了带雨伞。',
      'Tiānqì yùbào shuō jīntiān xiàwǔ yǒu léizhènyǔ, chūmén bié wàng le dài yǔsǎn.',
      'Dự báo thời tiết nói chiều nay có mưa rào kèm sấm sét, ra ngoài đừng quên mang theo ô nhé.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '天气预报说今天下午有雷阵雨，出门别忘了带雨伞。',
        'Tiānqì yùbào shuō jīntiān xiàwǔ yǒu léizhènyǔ, chūmén bié wàng le dài yǔsǎn.',
        'Dự báo thời tiết nói chiều nay có mưa rào kèm sấm sét, ra ngoài đừng quên mang theo ô nhé.',
        'basic',
        1
      ),
      (
        v_id,
        '参加国际高端论坛时，每位参会代表都需要把特制的嘉宾证件别在胸前左侧。',
        'Cānjiā guójì gāoduān lùntán shí, měi wèi cānhuì dàibiǎo dōu xūyào bǎ tèzhì de jiābīn zhèngjiàn bié zài xiōngqián zuǒcè.',
        'Khi tham dự diễn đàn cao cấp quốc tế, mỗi đại biểu tham dự đều cần phải cài thẻ khách mời đặc biệt bên ngực trái.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2067] [饼] (bǐng) - bánh dẹt, bánh nướng (bánh quy, bánh kếp, bánh trung thu) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '饼'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '饼'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bǐng',
      meaning_vi = 'bánh dẹt, bánh nướng (bánh quy, bánh kếp, bánh trung thu)',
      example_hanzi = '奶奶亲手烙的葱油饼香脆可口，孩子们都很爱吃。',
      example_pinyin = 'Nǎinai qīnshǒu lào de cōngyóubǐng xiāng cuì kěkǒu, háizimen dōu hěn ài chī.',
      example_vi = 'Món bánh hành nướng chính tay bà làm giòn thơm ngon miệng, tụi nhỏ ai cũng thích ăn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '饼',
      'bǐng',
      'bánh dẹt, bánh nướng (bánh quy, bánh kếp, bánh trung thu)',
      'Danh từ',
      'HSK 5',
      '奶奶亲手烙的葱油饼香脆可口，孩子们都很爱吃。',
      'Nǎinai qīnshǒu lào de cōngyóubǐng xiāng cuì kěkǒu, háizimen dōu hěn ài chī.',
      'Món bánh hành nướng chính tay bà làm giòn thơm ngon miệng, tụi nhỏ ai cũng thích ăn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '奶奶亲手烙的葱油饼香脆可口，孩子们都很爱吃。',
        'Nǎinai qīnshǒu lào de cōngyóubǐng xiāng cuì kěkǒu, háizimen dōu hěn ài chī.',
        'Món bánh hành nướng chính tay bà làm giòn thơm ngon miệng, tụi nhỏ ai cũng thích ăn.',
        'basic',
        1
      ),
      (
        v_id,
        '每逢中秋佳节，亲朋好友之间互赠传统月饼，寄托着阖家团圆幸福的美好祝福。',
        'Měi féng Zhōngqiū jiājié, qīnpéng hǎoyǒu zhījiān hù zèng chuántǒng yuèbǐng, jìtuō zhe héjiā tuányuán xìngfú de měihǎo zhùfú.',
        'Mỗi dịp tết Trung thu, người thân bạn bè tặng nhau bánh trung thu truyền thống, gửi gắm lời chúc tốt đẹp gia đình đoàn viên hạnh phúc trọn vẹn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2068] [病房] (bìngfáng) - phòng bệnh, buồng bệnh nhân trong bệnh viện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '病房'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '病房'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bìngfáng',
      meaning_vi = 'phòng bệnh, buồng bệnh nhân trong bệnh viện',
      example_hanzi = '为保证病人充分休养，探视病房时请保持安静。',
      example_pinyin = 'Wèi bǎozhèng bìngrén chōngfèn xiūyǎng, tànshì bìngfáng shí qǐng bǎochí ānjìng.',
      example_vi = 'Để đảm bảo bệnh nhân được nghỉ ngơi dưỡng sức đầy đủ, khi vào thăm phòng bệnh xin vui lòng giữ trật tự.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '病房',
      'bìngfáng',
      'phòng bệnh, buồng bệnh nhân trong bệnh viện',
      'Danh từ',
      'HSK 5',
      '为保证病人充分休养，探视病房时请保持安静。',
      'Wèi bǎozhèng bìngrén chōngfèn xiūyǎng, tànshì bìngfáng shí qǐng bǎochí ānjìng.',
      'Để đảm bảo bệnh nhân được nghỉ ngơi dưỡng sức đầy đủ, khi vào thăm phòng bệnh xin vui lòng giữ trật tự.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '为保证病人充分休养，探视病房时请保持安静。',
        'Wèi bǎozhèng bìngrén chōngfèn xiūyǎng, tànshì bìngfáng shí qǐng bǎochí ānjìng.',
        'Để đảm bảo bệnh nhân được nghỉ ngơi dưỡng sức đầy đủ, khi vào thăm phòng bệnh xin vui lòng giữ trật tự.',
        'basic',
        1
      ),
      (
        v_id,
        '重症监护病房配备了最先进的生命体征监测仪器，由专业医护人员二十四小时不间断值守。',
        'Zhòngzhèng jiānhù bìngfáng pèibèi le zuì xiānjìn de shēngmìng tǐzhēng jiāncè yíqì, yóu zhuānyè yīhù rényuán èrshísì xiǎoshí bú jiànduàn zhíshǒu.',
        'Phòng bệnh chăm sóc đặc biệt (ICU) được trang bị thiết bị theo dõi dấu hiệu sinh tồn hiện đại nhất, do đội ngũ y bác sĩ chuyên nghiệp túc trực suốt hai mươi bốn giờ không ngắt quãng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2069] [病情] (bìngqíng) - bệnh tình, diễn biến tình trạng bệnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '病情'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '病情'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bìngqíng',
      meaning_vi = 'bệnh tình, diễn biến tình trạng bệnh',
      example_hanzi = '经过几天的精心治疗和调养，老爷爷的病情已经逐渐稳定下来了。',
      example_pinyin = 'Jīngguò jǐ tiān de jīngxīn zhìliáo hé tiáoyǎng, lǎo yéye de bìngqíng yǐjīng zhújiàn wěndìng xiàlái le.',
      example_vi = 'Sau mấy ngày điều trị và bồi dưỡng tận tình, bệnh tình của cụ ông đã dần ổn định trở lại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '病情',
      'bìngqíng',
      'bệnh tình, diễn biến tình trạng bệnh',
      'Danh từ',
      'HSK 5',
      '经过几天的精心治疗和调养，老爷爷的病情已经逐渐稳定下来了。',
      'Jīngguò jǐ tiān de jīngxīn zhìliáo hé tiáoyǎng, lǎo yéye de bìngqíng yǐjīng zhújiàn wěndìng xiàlái le.',
      'Sau mấy ngày điều trị và bồi dưỡng tận tình, bệnh tình của cụ ông đã dần ổn định trở lại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '经过几天的精心治疗和调养，老爷爷的病情已经逐渐稳定下来了。',
        'Jīngguò jǐ tiān de jīngxīn zhìliáo hé tiáoyǎng, lǎo yéye de bìngqíng yǐjīng zhújiàn wěndìng xiàlái le.',
        'Sau mấy ngày điều trị và bồi dưỡng tận tình, bệnh tình của cụ ông đã dần ổn định trở lại.',
        'basic',
        1
      ),
      (
        v_id,
        '主治医师向病人家属详细通报了最新的病情诊断分析，并共同商定后续的最佳手术治疗方案。',
        'Zhǔzhì yīshī xiàng bìngrén jiāshǔ xiángxì tōngbào le zuìxīn de bìngqíng zhěnduàn fēnxī, bìng gòngtóng shāngdìng hòuxù de zuìjiā shǒushù zhìliáo fāng’àn.',
        'Bác sĩ điều trị chính đã thông báo cặn kẽ kết quả phân tích chẩn đoán bệnh tình mới nhất cho người nhà bệnh nhân, đồng thời cùng thống nhất phương án phẫu thuật tối ưu nhất tiếp theo.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2070] [拨打] (bōdǎ) - gọi điện, quay số, bấm số điện thoại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '拨打'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拨打'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bōdǎ',
      meaning_vi = 'gọi điện, quay số, bấm số điện thoại',
      example_hanzi = '如果您在国外遇到紧急求助事项，请立即拨打外交部全球领保电话。',
      example_pinyin = 'Rúguǒ nín zài guówài yùdào jǐnjí qiúzhù shìxiàng, qǐng lìjí bōdǎ wàijiāobù quánqiú lǐngbǎo diànhuà.',
      example_vi = 'Nếu quý vị gặp việc khẩn cấp cần trợ giúp tại nước ngoài, xin hãy lập tức bấm số gọi điện thoại bảo hộ lãnh sự toàn cầu của Bộ Ngoại giao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '拨打',
      'bōdǎ',
      'gọi điện, quay số, bấm số điện thoại',
      'Động từ',
      'HSK 5',
      '如果您在国外遇到紧急求助事项，请立即拨打外交部全球领保电话。',
      'Rúguǒ nín zài guówài yùdào jǐnjí qiúzhù shìxiàng, qǐng lìjí bōdǎ wàijiāobù quánqiú lǐngbǎo diànhuà.',
      'Nếu quý vị gặp việc khẩn cấp cần trợ giúp tại nước ngoài, xin hãy lập tức bấm số gọi điện thoại bảo hộ lãnh sự toàn cầu của Bộ Ngoại giao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '如果您在国外遇到紧急求助事项，请立即拨打外交部全球领保电话。',
        'Rúguǒ nín zài guówài yùdào jǐnjí qiúzhù shìxiàng, qǐng lìjí bōdǎ wàijiāobù quánqiú lǐngbǎo diànhuà.',
        'Nếu quý vị gặp việc khẩn cấp cần trợ giúp tại nước ngoài, xin hãy lập tức bấm số gọi điện thoại bảo hộ lãnh sự toàn cầu của Bộ Ngoại giao.',
        'basic',
        1
      ),
      (
        v_id,
        '客户拨打售后服务热线后，智能语音导航系统将根据按键提示迅速转接到相应的人工客服专线。',
        'Kèhù bōdǎ shòuhòu fúwù rèxiàn hòu, zhìnéng yǔyīn dǎoháng xìtǒng jiāng gēnjù ànjiàn tíshì xùnsù zhuǎnjiē dào xiāngyìng de réngōng kèfù zhuānxiàn.',
        'Sau khi khách hàng quay số gọi đến đường dây nóng hậu mãi, hệ thống điều hướng giọng nói thông minh sẽ căn cứ theo phím bấm chuyển tiếp nhanh chóng tới điện thoại viên tương ứng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2071] [玻璃] (bōli) - thủy tinh, kính [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '玻璃'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '玻璃'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bōli',
      meaning_vi = 'thủy tinh, kính',
      example_hanzi = '调皮的小男孩在踢球时不小心打碎了邻居家的窗户玻璃。',
      example_pinyin = 'Tiáopí de xiǎo nánhái zài tīqiú shí bù xiǎoxīn dǎsuì le línjū jiā de chuānghu bōli.',
      example_vi = 'Cậu bé nghịch ngợm trong lúc đá bóng đã vô ý làm vỡ tấm kính cửa sổ nhà hàng xóm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '玻璃',
      'bōli',
      'thủy tinh, kính',
      'Danh từ',
      'HSK 5',
      '调皮的小男孩在踢球时不小心打碎了邻居家的窗户玻璃。',
      'Tiáopí de xiǎo nánhái zài tīqiú shí bù xiǎoxīn dǎsuì le línjū jiā de chuānghu bōli.',
      'Cậu bé nghịch ngợm trong lúc đá bóng đã vô ý làm vỡ tấm kính cửa sổ nhà hàng xóm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '调皮的小男孩在踢球时不小心打碎了邻居家的窗户玻璃。',
        'Tiáopí de xiǎo nánhái zài tīqiú shí bù xiǎoxīn dǎsuì le línjū jiā de chuānghu bōli.',
        'Cậu bé nghịch ngợm trong lúc đá bóng đã vô ý làm vỡ tấm kính cửa sổ nhà hàng xóm.',
        'basic',
        1
      ),
      (
        v_id,
        '这座现代化超高层地标建筑外墙全部采用了双层隔音隔热的绿色环保钢化玻璃幕墙。',
        'Zhè zuò xiàndàihuà chāogāocéng dìbiāo jiànzhù wàiqiáng quánbù cǎiyòng le shuāngcéng géyīn gérè de lǜsè huánbǎo gānghuà bōli mùqiáng.',
        'Mặt ngoài của tòa nhà chọc trời mang tính biểu tượng hiện đại này toàn bộ sử dụng vách kính cường lực thân thiện với môi trường hai lớp cách âm và cách nhiệt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2072] [博物馆] (bówùguǎn) - viện bảo tàng, nhà bảo tàng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '博物馆'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '博物馆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'bówùguǎn',
      meaning_vi = 'viện bảo tàng, nhà bảo tàng',
      example_hanzi = '周末老师带着全班同学去参观了故宫博物院和自然博物馆。',
      example_pinyin = 'Zhōumò lǎoshī dài zhe quán bān tóngxué qù cānguān le Gùgōng Bówùyuàn hé zìrán bówùguǎn.',
      example_vi = 'Cuối tuần thầy giáo dẫn toàn thể học sinh trong lớp đi tham quan Bảo tàng Cố Cung và Bảo tàng Tự nhiên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '博物馆',
      'bówùguǎn',
      'viện bảo tàng, nhà bảo tàng',
      'Danh từ',
      'HSK 5',
      '周末老师带着全班同学去参观了故宫博物院和自然博物馆。',
      'Zhōumò lǎoshī dài zhe quán bān tóngxué qù cānguān le Gùgōng Bówùyuàn hé zìrán bówùguǎn.',
      'Cuối tuần thầy giáo dẫn toàn thể học sinh trong lớp đi tham quan Bảo tàng Cố Cung và Bảo tàng Tự nhiên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '周末老师带着全班同学去参观了故宫博物院和自然博物馆。',
        'Zhōumò lǎoshī dài zhe quán bān tóngxué qù cānguān le Gùgōng Bówùyuàn hé zìrán bówùguǎn.',
        'Cuối tuần thầy giáo dẫn toàn thể học sinh trong lớp đi tham quan Bảo tàng Cố Cung và Bảo tàng Tự nhiên.',
        'basic',
        1
      ),
      (
        v_id,
        '许多国家级博物馆通过引入虚拟现实数字化互动技术，让珍藏的历史国宝生动地“活”了起来。',
        'Xǔduō guójiājí bówùguǎn tōngguò yǐnrù xūnǐ xiànshí shùzìhuà hùdòng jìshù, ràng zhēncáng de lìshǐ guóbǎo shēngdòng de “huó” le qǐlái.',
        'Nhiều viện bảo tàng cấp quốc gia thông qua việc đưa vào công nghệ tương tác kỹ thuật số thực tế ảo (VR) đã khiến các quốc bảo lịch sử được trân giữ trở nên sống động như đang “sống lại”.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2073] [不利] (búlì) - bất lợi, không có lợi, có hại [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '不利'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '不利'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'búlì',
      meaning_vi = 'bất lợi, không có lợi, có hại',
      example_hanzi = '在狂风暴雨的不利天气条件下，船只严禁私自出海作业。',
      example_pinyin = 'Zài kuángfēng bàoyǔ de búlì tiānqì tiáojiàn xià, chuánzhī yánjìn sīsì chūhǎi zuòyè.',
      example_vi = 'Dưới điều kiện thời tiết giông bão bất lợi, nghiêm cấm tàu thuyền tự ý ra khơi hoạt động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '不利',
      'búlì',
      'bất lợi, không có lợi, có hại',
      'Tính từ',
      'HSK 5',
      '在狂风暴雨的不利天气条件下，船只严禁私自出海作业。',
      'Zài kuángfēng bàoyǔ de búlì tiānqì tiáojiàn xià, chuánzhī yánjìn sīsì chūhǎi zuòyè.',
      'Dưới điều kiện thời tiết giông bão bất lợi, nghiêm cấm tàu thuyền tự ý ra khơi hoạt động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在狂风暴雨的不利天气条件下，船只严禁私自出海作业。',
        'Zài kuángfēng bàoyǔ de búlì tiānqì tiáojiàn xià, chuánzhī yánjìn sīsì chūhǎi zuòyè.',
        'Dưới điều kiện thời tiết giông bão bất lợi, nghiêm cấm tàu thuyền tự ý ra khơi hoạt động.',
        'basic',
        1
      ),
      (
        v_id,
        '面对汇率波动和原材料价格上涨的不利局面，公司积极调整出口策略以有效对冲经营风险。',
        'Miànduì huìlǜ bōdòng hé yuáncáiliào jiàgé shàngzhǎng de búlì júmiàn, gōngsī jījí tiáozhěng chūkǒu cèlüè yǐ yǒuxiào duìchōng jīngyíng fēngxiǎn.',
        'Đối mặt với cục diện bất lợi từ tỷ giá biến động và giá nguyên vật liệu tăng cao, công ty đã tích cực điều chỉnh chiến lược xuất khẩu nhằm phòng ngừa rủi ro kinh doanh một cách hiệu quả.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2074] [不幸] (búxìng) - bất hạnh, không may; điều rủi ro, tai ương [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '不幸'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '不幸'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'búxìng',
      meaning_vi = 'bất hạnh, không may; điều rủi ro, tai ương',
      example_hanzi = '听到这位优秀的青年科学家不幸英年早逝的噩耗，大家深感悲痛。',
      example_pinyin = 'Tīngdào zhè wèi yōuxiù de qīngnián kēxuéjiā búxìng yīngnián zǎoshì de èhào, dàjiā shēn gǎn bēitòng.',
      example_vi = 'Nghe tin dữ nhà khoa học trẻ xuất sắc này không may qua đời khi tuổi đời còn quá trẻ, ai nấy đều cảm thấy vô cùng đau xót.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '不幸',
      'búxìng',
      'bất hạnh, không may; điều rủi ro, tai ương',
      'Tính từ / Danh từ',
      'HSK 5',
      '听到这位优秀的青年科学家不幸英年早逝的噩耗，大家深感悲痛。',
      'Tīngdào zhè wèi yōuxiù de qīngnián kēxuéjiā búxìng yīngnián zǎoshì de èhào, dàjiā shēn gǎn bēitòng.',
      'Nghe tin dữ nhà khoa học trẻ xuất sắc này không may qua đời khi tuổi đời còn quá trẻ, ai nấy đều cảm thấy vô cùng đau xót.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '听到这位优秀的青年科学家不幸英年早逝的噩耗，大家深感悲痛。',
        'Tīngdào zhè wèi yōuxiù de qīngnián kēxuéjiā búxìng yīngnián zǎoshì de èhào, dàjiā shēn gǎn bēitòng.',
        'Nghe tin dữ nhà khoa học trẻ xuất sắc này không may qua đời khi tuổi đời còn quá trẻ, ai nấy đều cảm thấy vô cùng đau xót.',
        'basic',
        1
      ),
      (
        v_id,
        '“不幸之中的万幸”是指在遭遇突如其来的严重车祸时，车上的乘客都系了安全带而全部平安生还。',
        '“Búxìng zhī zhōng de wànxìng” shì zhǐ zài zāoyù tūrúqílái de yánzhòng chēhuò shí, chē shàng de chéngkè dōu jì le ānquándài ér quánbù píng’ān shēnghuán.',
        '“Trong cái rủi có cái may” chính là nói khi gặp phải tai nạn xe cộ nghiêm trọng bất ngờ ập đến, hành khách trên xe đều đã thắt dây an toàn nên toàn bộ sống sót bình an.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2075] [不要紧] (bú yàojǐn) - không sao, không hề gì, không có gì đáng ngại [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '不要紧'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '不要紧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'bú yàojǐn',
      meaning_vi = 'không sao, không hề gì, không có gì đáng ngại',
      example_hanzi = '“真对不起，踩到你的脚了！”“没关系，不要紧的。”',
      example_pinyin = '“Zhēn duìbuqǐ, cǎi dào nǐ de jiǎo le!” “Méi guānxi, bú yàojǐn de.”',
      example_vi = '“Thực sự xin lỗi bạn, tôi dẫm vào chân bạn rồi!” “Không sao đâu, không hề gì đâu mà.”'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '不要紧',
      'bú yàojǐn',
      'không sao, không hề gì, không có gì đáng ngại',
      'Tính từ',
      'HSK 5',
      '“真对不起，踩到你的脚了！”“没关系，不要紧的。”',
      '“Zhēn duìbuqǐ, cǎi dào nǐ de jiǎo le!” “Méi guānxi, bú yàojǐn de.”',
      '“Thực sự xin lỗi bạn, tôi dẫm vào chân bạn rồi!” “Không sao đâu, không hề gì đâu mà.”'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '“真对不起，踩到你的脚了！”“没关系，不要紧的。”',
        '“Zhēn duìbuqǐ, cǎi dào nǐ de jiǎo le!” “Méi guānxi, bú yàojǐn de.”',
        '“Thực sự xin lỗi bạn, tôi dẫm vào chân bạn rồi!” “Không sao đâu, không hề gì đâu mà.”',
        'basic',
        1
      ),
      (
        v_id,
        '医生仔细检查了拍片结果后安慰家属说：“只是轻微的肌肉拉伤，骨头没有大碍，休养几天就不要紧了。”',
        'Yīshēng zǐxì jiǎnchá le pāipiàn jiéguǒ hòu ānwèi jiāshǔ shuō: “Zhǐ shì qīngwēi de jīròu lāshāng, gǔtou méiyǒu dà’ài, xiūyǎng jǐ tiān jiù bú yàojǐn le.”',
        'Bác sĩ sau khi kiểm tra kỹ lưỡng kết quả chụp phim đã an ủi người nhà rằng: “Chỉ là rách cơ nhẹ, xương cốt không hề hấn gì, tịnh dưỡng vài ngày là không sao nữa đâu.”',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2076] [补充] (bǔchōng) - bổ sung, thêm vào (nội dung, nhân lực, năng lượng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '补充'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '补充'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bǔchōng',
      meaning_vi = 'bổ sung, thêm vào (nội dung, nhân lực, năng lượng)',
      example_hanzi = '剧烈运动之后需要及时补充水分和电解质。',
      example_pinyin = 'Jùliè yùndòng zhīhòu xūyào jíshí bǔchōng shuǐfèn hé diànjiězì.',
      example_vi = 'Sau khi vận động mạnh mẽ cần kịp thời bổ sung nước và chất điện giải.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '补充',
      'bǔchōng',
      'bổ sung, thêm vào (nội dung, nhân lực, năng lượng)',
      'Động từ',
      'HSK 5',
      '剧烈运动之后需要及时补充水分和电解质。',
      'Jùliè yùndòng zhīhòu xūyào jíshí bǔchōng shuǐfèn hé diànjiězì.',
      'Sau khi vận động mạnh mẽ cần kịp thời bổ sung nước và chất điện giải.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '剧烈运动之后需要及时补充水分和电解质。',
        'Jùliè yùndòng zhīhòu xūyào jíshí bǔchōng shuǐfèn hé diànjiězì.',
        'Sau khi vận động mạnh mẽ cần kịp thời bổ sung nước và chất điện giải.',
        'basic',
        1
      ),
      (
        v_id,
        '汇报结束后，项目副总监就关键财务预算数据作了详尽的补充说明。',
        'Huìbào jiéshù hòu, xiàngmù fù zǒngjiān jiù guānjiàn cáiwù yùsuàn shùjù zuò le xiángjìn de bǔchōng shuōmíng.',
        'Sau khi bài báo cáo kết thúc, phó giám đốc dự án đã đưa ra lời giải thích bổ sung cặn kẽ về các số liệu dự toán tài chính then chốt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2077] [不得了] (bùdéliǎo) - cực kỳ, ghê gớm, vô cùng (mức độ cao); nguy to, hỏng to [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '不得了'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '不得了'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'bùdéliǎo',
      meaning_vi = 'cực kỳ, ghê gớm, vô cùng (mức độ cao); nguy to, hỏng to',
      example_hanzi = '今天的气温高达四十摄氏度，天气热得不得了。',
      example_pinyin = 'Jīntiān de qìwēn gāodá sìshí shèshìdù, tiānqì rè de bùdéliǎo.',
      example_vi = 'Nhiệt độ hôm nay lên tới bốn mươi độ C, thời tiết nóng bức vô cùng ghê gớm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '不得了',
      'bùdéliǎo',
      'cực kỳ, ghê gớm, vô cùng (mức độ cao); nguy to, hỏng to',
      'Tính từ',
      'HSK 5',
      '今天的气温高达四十摄氏度，天气热得不得了。',
      'Jīntiān de qìwēn gāodá sìshí shèshìdù, tiānqì rè de bùdéliǎo.',
      'Nhiệt độ hôm nay lên tới bốn mươi độ C, thời tiết nóng bức vô cùng ghê gớm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '今天的气温高达四十摄氏度，天气热得不得了。',
        'Jīntiān de qìwēn gāodá sìshí shèshìdù, tiānqì rè de bùdéliǎo.',
        'Nhiệt độ hôm nay lên tới bốn mươi độ C, thời tiết nóng bức vô cùng ghê gớm.',
        'basic',
        1
      ),
      (
        v_id,
        '听到自己荣获全国学术创新大赛一等奖，他高兴得不得了，迫不及待地与全家人分享喜悦。',
        'Tīngdào zìjǐ rónghuò quánguó xuéshù chuàngxīn dàsài yī děng jiǎng, tā gāoxìng de bùdéliǎo, pòbùjídài de yǔ quán jiārén fēnxiǎng xǐyuè.',
        'Nghe tin bản thân vinh dự đoạt giải nhất cuộc thi sáng tạo học thuật toàn quốc, anh ấy vui mừng khôn xiết, sốt sắng chia sẻ niềm vui với cả gia đình.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2078] [不符] (bùfú) - không khớp, không phù hợp, bất nhất (thực tế và lời nói/hồ sơ) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '不符'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '不符'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bùfú',
      meaning_vi = 'không khớp, không phù hợp, bất nhất (thực tế và lời nói/hồ sơ)',
      example_hanzi = '实际测量出来的数据与理论计算结果严重不符。',
      example_pinyin = 'Shíjì cèliáng chūlái de shùjù yǔ lǐlùn jìsuàn jiéguǒ yánzhòng bùfú.',
      example_vi = 'Số liệu đo đạc thực tế hoàn toàn không khớp nghiêm trọng với kết quả tính toán trên lý thuyết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '不符',
      'bùfú',
      'không khớp, không phù hợp, bất nhất (thực tế và lời nói/hồ sơ)',
      'Động từ',
      'HSK 5',
      '实际测量出来的数据与理论计算结果严重不符。',
      'Shíjì cèliáng chūlái de shùjù yǔ lǐlùn jìsuàn jiéguǒ yánzhòng bùfú.',
      'Số liệu đo đạc thực tế hoàn toàn không khớp nghiêm trọng với kết quả tính toán trên lý thuyết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '实际测量出来的数据与理论计算结果严重不符。',
        'Shíjì cèliáng chūlái de shùjù yǔ lǐlùn jìsuàn jiéguǒ yánzhòng bùfú.',
        'Số liệu đo đạc thực tế hoàn toàn không khớp nghiêm trọng với kết quả tính toán trên lý thuyết.',
        'basic',
        1
      ),
      (
        v_id,
        '经人事部门严格核实，该求职者简历中所填写的学历和从业经历与官方档案信息完全不符。',
        'Jīng rénshì bùmén yángé héshí, gāi qiúzhízhě jiǎnlì zhōng suǒ tiánxiě de xuélì hé cóngyè jīnglì yǔ guānfāng dàng’àn xìnxī wánquán bùfú.',
        'Qua xác minh nghiêm ngặt của phòng nhân sự, trình độ học vấn và kinh nghiệm làm việc ghi trong sơ yếu lý lịch của ứng viên này hoàn toàn bất nhất với thông tin hồ sơ lưu trữ chính thức.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2079] [不良] (bùliáng) - xấu, có hại, không lành mạnh, bất hảo (hành vi, nợ xấu, phản ứng phụ) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '不良'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '不良'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'bùliáng',
      meaning_vi = 'xấu, có hại, không lành mạnh, bất hảo (hành vi, nợ xấu, phản ứng phụ)',
      example_hanzi = '青少年要自觉抵制不良诱惑，养成健康积极的生活习惯。',
      example_pinyin = 'Qīngshàonián yào zìjué dǐzhì bùliáng yòuhuò, yǎngchéng jiànkāng jījí de shēnghuó xíguàn.',
      example_vi = 'Thanh thiếu niên cần tự giác bài trừ những cám dỗ không lành mạnh, hình thành thói quen sống tích cực khỏe khoắn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '不良',
      'bùliáng',
      'xấu, có hại, không lành mạnh, bất hảo (hành vi, nợ xấu, phản ứng phụ)',
      'Tính từ',
      'HSK 5',
      '青少年要自觉抵制不良诱惑，养成健康积极的生活习惯。',
      'Qīngshàonián yào zìjué dǐzhì bùliáng yòuhuò, yǎngchéng jiànkāng jījí de shēnghuó xíguàn.',
      'Thanh thiếu niên cần tự giác bài trừ những cám dỗ không lành mạnh, hình thành thói quen sống tích cực khỏe khoắn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '青少年要自觉抵制不良诱惑，养成健康积极的生活习惯。',
        'Qīngshàonián yào zìjué dǐzhì bùliáng yòuhuò, yǎngchéng jiànkāng jījí de shēnghuó xíguàn.',
        'Thanh thiếu niên cần tự giác bài trừ những cám dỗ không lành mạnh, hình thành thói quen sống tích cực khỏe khoắn.',
        'basic',
        1
      ),
      (
        v_id,
        '服用这种新型降压药后如出现头晕或胃部不适等不良反应，患者应立即停药并向医生咨询。',
        'Fúyòng zhè zhǒng xīnxíng jiàngyā yào hòu rú chūxiàn tóuyūn huò wèibù bùshì děng bùliáng fǎnyìng, huànzhě yīng lìjí tíngyào bìng xiàng yīshēng zīxún.',
        'Sau khi uống loại thuốc hạ huyết áp kiểu mới này nếu xuất hiện phản ứng phụ xấu như chóng mặt hay khó chịu dạ dày, người bệnh nên ngưng thuốc ngay và tham khảo ý kiến bác sĩ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2080] [不然] (bùrán) - nếu không thì, bằng không; không phải như vậy [Liên từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '不然'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '不然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ / Phó từ',
      pinyin = 'bùrán',
      meaning_vi = 'nếu không thì, bằng không; không phải như vậy',
      example_hanzi = '我们现在就得出门，不然上班就要迟到了。',
      example_pinyin = 'Wǒmen xiànzài jiù děi chūmén, bùrán shàngbān jiù yào chídào le.',
      example_vi = 'Bây giờ chúng ta phải đi ngay thôi, nếu không thì đi làm sẽ bị muộn mất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '不然',
      'bùrán',
      'nếu không thì, bằng không; không phải như vậy',
      'Liên từ / Phó từ',
      'HSK 5',
      '我们现在就得出门，不然上班就要迟到了。',
      'Wǒmen xiànzài jiù děi chūmén, bùrán shàngbān jiù yào chídào le.',
      'Bây giờ chúng ta phải đi ngay thôi, nếu không thì đi làm sẽ bị muộn mất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '我们现在就得出门，不然上班就要迟到了。',
        'Wǒmen xiànzài jiù děi chūmén, bùrán shàngbān jiù yào chídào le.',
        'Bây giờ chúng ta phải đi ngay thôi, nếu không thì đi làm sẽ bị muộn mất.',
        'basic',
        1
      ),
      (
        v_id,
        '企业必须与时俱进加快数字化转型步伐，不然在日益残酷激烈的国际市场竞争中就难逃被淘汰的命运。',
        'Qǐyè bìxū yǔshíjùjìn jiākuài shùzìhuà zhuǎnxíng bùfá, bùrán zài rìyì cánkù jīliè de guójì shìchǎng jìngzhēng zhōng jiù nán táo bèi táotài de mìngyùn.',
        'Doanh nghiệp bắt buộc phải bắt kịp thời đại đẩy nhanh bước chân chuyển đổi số, bằng không trong cuộc cạnh tranh thị trường quốc tế ngày càng tàn khốc gay gắt sẽ khó thoát khỏi số phận bị đào thải.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2081] [步行] (bùxíng) - đi bộ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '步行'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '步行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'bùxíng',
      meaning_vi = 'đi bộ',
      example_hanzi = '我家离公司只有两公里，我每天坚持步行上下班。',
      example_pinyin = 'Wǒ jiā lí gōngsī zhǐ yǒu liǎng gōnglǐ, wǒ měitiān jiānchí bùxíng shàng-xiàbān.',
      example_vi = 'Nhà tôi cách công ty chỉ có hai cây số, tôi kiên trì đi bộ đi làm và về nhà mỗi ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '步行',
      'bùxíng',
      'đi bộ',
      'Động từ',
      'HSK 5',
      '我家离公司只有两公里，我每天坚持步行上下班。',
      'Wǒ jiā lí gōngsī zhǐ yǒu liǎng gōnglǐ, wǒ měitiān jiānchí bùxíng shàng-xiàbān.',
      'Nhà tôi cách công ty chỉ có hai cây số, tôi kiên trì đi bộ đi làm và về nhà mỗi ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '我家离公司只有两公里，我每天坚持步行上下班。',
        'Wǒ jiā lí gōngsī zhǐ yǒu liǎng gōnglǐ, wǒ měitiān jiānchí bùxíng shàng-xiàbān.',
        'Nhà tôi cách công ty chỉ có hai cây số, tôi kiên trì đi bộ đi làm và về nhà mỗi ngày.',
        'basic',
        1
      ),
      (
        v_id,
        '市政府规划建设了横跨市中心的绿色滨江步行街，极大方便了市民休闲观光与健康健步走。',
        'Shì zhèngfǔ guīhuà jiànshè le héngkuà shì zhōngxīn de lǜsè bīnjiāng bùxíngjiē, jí dà fāngbiàn le shìmín xiūxián guānguāng yǔ jiànkāng jiànbùzǒu.',
        'Chính quyền thành phố đã quy hoạch xây dựng tuyến phố đi bộ ven sông xanh vắt ngang trung tâm thành phố, tạo thuận tiện lớn cho người dân vui chơi ngắm cảnh và đi bộ rèn luyện sức khỏe.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2082] [不足] (bùzú) - không đủ, thiếu thốn; điểm thiếu sót; không đáng [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '不足'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '不足'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'bùzú',
      meaning_vi = 'không đủ, thiếu thốn; điểm thiếu sót; không đáng',
      example_hanzi = '长期睡眠不足会导致工作效率低下和身体免疫力下降。',
      example_pinyin = 'Chángqī shuìmián bùzú huì dǎozhì gōngzuò xiàolǜ dīxià hé shēntǐ miǎnyìlì xiàjiàng.',
      example_vi = 'Thiếu ngủ trong thời gian dài sẽ dẫn tới hiệu suất làm việc sa sút và hệ miễn dịch của cơ thể suy giảm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '不足',
      'bùzú',
      'không đủ, thiếu thốn; điểm thiếu sót; không đáng',
      'Tính từ / Động từ',
      'HSK 5',
      '长期睡眠不足会导致工作效率低下和身体免疫力下降。',
      'Chángqī shuìmián bùzú huì dǎozhì gōngzuò xiàolǜ dīxià hé shēntǐ miǎnyìlì xiàjiàng.',
      'Thiếu ngủ trong thời gian dài sẽ dẫn tới hiệu suất làm việc sa sút và hệ miễn dịch của cơ thể suy giảm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '长期睡眠不足会导致工作效率低下和身体免疫力下降。',
        'Chángqī shuìmián bùzú huì dǎozhì gōngzuò xiàolǜ dīxià hé shēntǐ miǎnyìlì xiàjiàng.',
        'Thiếu ngủ trong thời gian dài sẽ dẫn tới hiệu suất làm việc sa sút và hệ miễn dịch của cơ thể suy giảm.',
        'basic',
        1
      ),
      (
        v_id,
        '在年终总结会议上，各业务部门客观总结了上一季度的辉煌成绩，也深刻反思了存在的工作不足与短板。',
        'Zài niánzhōng zǒngjié huìyì shàng, gè yèwù bùmén kèguān zǒngjié le shàng yí jìdù de huīhuáng chéngjì, yě shēnkè fǎnsī le cúnzài de gōngzuò bùzú yǔ duǎnbǎn.',
        'Tại hội nghị tổng kết cuối năm, các phòng ban nghiệp vụ đã khách quan tổng kết những thành tích rực rỡ của quý trước, đồng thời cũng nhìn nhận sâu sắc những thiếu sót và điểm yếu còn tồn tại trong công việc.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2083] [才] (cái) - mới, vừa mới, chỉ; tài năng, người có tài [Phó từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '才'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '才'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Danh từ',
      pinyin = 'cái',
      meaning_vi = 'mới, vừa mới, chỉ; tài năng, người có tài',
      example_hanzi = '现在才早晨六点钟，公园里就已经有很多晨练的老人了。',
      example_pinyin = 'Xiànzài cái zǎochén liù diǎn zhōng, gōngyuán lǐ jiù yǐjīng yǒu hěn duō chénliàn de lǎorén le.',
      example_vi = 'Bây giờ mới sáu giờ sáng mà trong công viên đã có rất nhiều người già tập thể dục buổi sáng rồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '才',
      'cái',
      'mới, vừa mới, chỉ; tài năng, người có tài',
      'Phó từ / Danh từ',
      'HSK 5',
      '现在才早晨六点钟，公园里就已经有很多晨练的老人了。',
      'Xiànzài cái zǎochén liù diǎn zhōng, gōngyuán lǐ jiù yǐjīng yǒu hěn duō chénliàn de lǎorén le.',
      'Bây giờ mới sáu giờ sáng mà trong công viên đã có rất nhiều người già tập thể dục buổi sáng rồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '现在才早晨六点钟，公园里就已经有很多晨练的老人了。',
        'Xiànzài cái zǎochén liù diǎn zhōng, gōngyuán lǐ jiù yǐjīng yǒu hěn duō chénliàn de lǎorén le.',
        'Bây giờ mới sáu giờ sáng mà trong công viên đã có rất nhiều người già tập thể dục buổi sáng rồi.',
        'basic',
        1
      ),
      (
        v_id,
        '企业唯有唯才是举、知人善任，方能在群雄逐鹿的激烈竞争中立于不败之地。',
        'Qǐyè wéi yǒu wéicái shì jǔ, zhīrén shànrèn, fāng néng zài qúnxióng zhúlù de jīliè jìngzhēng zhōng lì yú bú bài zhī dì.',
        'Doanh nghiệp chỉ khi trọng dụng nhân tài, biết người biết dùng người thì mới có thể đứng vững ở vị thế bất bại trong cuộc cạnh tranh ác liệt muôn bên tranh giành.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2084] [裁判] (cáipàn) - trọng tài; phân xử, làm trọng tài [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '裁判'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '裁判'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'cáipàn',
      meaning_vi = 'trọng tài; phân xử, làm trọng tài',
      example_hanzi = '比赛过程中，运动员必须服从裁判的公正判决。',
      example_pinyin = 'Bǐsài guòchéng zhōng, yùndòngyuán bìxū fúcóng cáipàn de gōngzhèng pànjué.',
      example_vi = 'Trong quá trình thi đấu, vận động viên bắt buộc phải phục tùng phán quyết công minh của trọng tài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '裁判',
      'cáipàn',
      'trọng tài; phân xử, làm trọng tài',
      'Danh từ / Động từ',
      'HSK 5',
      '比赛过程中，运动员必须服从裁判的公正判决。',
      'Bǐsài guòchéng zhōng, yùndòngyuán bìxū fúcóng cáipàn de gōngzhèng pànjué.',
      'Trong quá trình thi đấu, vận động viên bắt buộc phải phục tùng phán quyết công minh của trọng tài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '比赛过程中，运动员必须服从裁判的公正判决。',
        'Bǐsài guòchéng zhōng, yùndòngyuán bìxū fúcóng cáipàn de gōngzhèng pànjué.',
        'Trong quá trình thi đấu, vận động viên bắt buộc phải phục tùng phán quyết công minh của trọng tài.',
        'basic',
        1
      ),
      (
        v_id,
        '主裁判借助视频助理裁判技术仔细回看录像后，果断判定客队前锋在禁区内犯规并判罚点球。',
        'Zhǔ cáipàn jièzhù shìpín zhùlǐ cáipàn jìshù zǐxì huíkàn lùxiàng hòu, guǒduàn pàndìng kèduì qiánfēng zài jìnqū nèi fànguī bìng pànfá diǎnqiú.',
        'Trọng tài chính sau khi nhờ công nghệ trợ lý trọng tài video (VAR) xem lại băng ghi hình cẩn thận, đã dứt khoát xác định tiền đạo đội khách phạm quy trong vòng cấm và thổi phạt đền.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2085] [采访] (cǎifǎng) - phỏng vấn (báo chí, truyền thông); cuộc phỏng vấn [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '采访'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '采访'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'cǎifǎng',
      meaning_vi = 'phỏng vấn (báo chí, truyền thông); cuộc phỏng vấn',
      example_hanzi = '记者正在现场采访夺得冠军的短跑运动员。',
      example_pinyin = 'Jìzhě zhèngzài xiànchǎng cǎifǎng duó dé guànjūn de duǎnpǎo yùndòngyuán.',
      example_vi = 'Phóng viên đang phỏng vấn ngay tại hiện trường vận động viên chạy cự ly ngắn vừa giành ngôi vô địch.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '采访',
      'cǎifǎng',
      'phỏng vấn (báo chí, truyền thông); cuộc phỏng vấn',
      'Động từ / Danh từ',
      'HSK 5',
      '记者正在现场采访夺得冠军的短跑运动员。',
      'Jìzhě zhèngzài xiànchǎng cǎifǎng duó dé guànjūn de duǎnpǎo yùndòngyuán.',
      'Phóng viên đang phỏng vấn ngay tại hiện trường vận động viên chạy cự ly ngắn vừa giành ngôi vô địch.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '记者正在现场采访夺得冠军的短跑运动员。',
        'Jìzhě zhèngzài xiànchǎng cǎifǎng duó dé guànjūn de duǎnpǎo yùndòngyuán.',
        'Phóng viên đang phỏng vấn ngay tại hiện trường vận động viên chạy cự ly ngắn vừa giành ngôi vô địch.',
        'basic',
        1
      ),
      (
        v_id,
        '在接受国家电视台高端访谈节目的独家专访时，这位著名企业家分享了创业初期的艰难经历与成功经验。',
        'Zài jiēshòu guójiā diànshìtái gāoduān fǎngtán jiémù de dújiā zhuānfǎng shí, zhè wèi zhùmíng qǐyèjiā fēnxiǎng le chuàngyè chūqī de jiānnán jīnglì yǔ chénggōng jīngyàn.',
        'Khi nhận lời phỏng vấn độc quyền của chương trình trò chuyện cao cấp đài truyền hình quốc gia, vị doanh nhân nổi tiếng này đã chia sẻ những trải nghiệm gian khổ và kinh nghiệm thành công thời kỳ đầu khởi nghiệp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2086] [采取] (cǎiqǔ) - áp dụng, thi hành (biện pháp, phương châm, chính sách, hành động) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '采取'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '采取'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cǎiqǔ',
      meaning_vi = 'áp dụng, thi hành (biện pháp, phương châm, chính sách, hành động)',
      example_hanzi = '学校采取了许多有效措施来保障全体师生的饮食卫生安全。',
      example_pinyin = 'Xuéxiào cǎiqǔ le xǔduō yǒuxiào cuòshī lái bǎozhàng quántǐ shīshēng de yǐnshí wèishēng ānquán.',
      example_vi = 'Nhà trường đã áp dụng nhiều biện pháp hữu hiệu để đảm bảo an toàn vệ sinh ăn uống cho toàn thể thầy cô và học sinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '采取',
      'cǎiqǔ',
      'áp dụng, thi hành (biện pháp, phương châm, chính sách, hành động)',
      'Động từ',
      'HSK 5',
      '学校采取了许多有效措施来保障全体师生的饮食卫生安全。',
      'Xuéxiào cǎiqǔ le xǔduō yǒuxiào cuòshī lái bǎozhàng quántǐ shīshēng de yǐnshí wèishēng ānquán.',
      'Nhà trường đã áp dụng nhiều biện pháp hữu hiệu để đảm bảo an toàn vệ sinh ăn uống cho toàn thể thầy cô và học sinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '学校采取了许多有效措施来保障全体师生的饮食卫生安全。',
        'Xuéxiào cǎiqǔ le xǔduō yǒuxiào cuòshī lái bǎozhàng quántǐ shīshēng de yǐnshí wèishēng ānquán.',
        'Nhà trường đã áp dụng nhiều biện pháp hữu hiệu để đảm bảo an toàn vệ sinh ăn uống cho toàn thể thầy cô và học sinh.',
        'basic',
        1
      ),
      (
        v_id,
        '面对严峻的通货膨胀压力，央行果断决定采取适度从紧的货币金融政策以稳定物价水平。',
        'Miànduì yánjùn de tōnghuò péngzhàng yālì, yāngháng guǒduàn juédìng cǎiqǔ shìdù cóngjǐn de huòbì jīnróng cèlüè yǐ wěndìng wùjià shuǐpíng.',
        'Trước áp lực lạm phát gay gắt, ngân hàng trung ương đã dứt khoát quyết định áp dụng chính sách tài chính tiền tệ thắt chặt vừa phải nhằm ổn định mặt bằng giá cả.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2087] [彩色] (cǎisè) - có màu sắc, rực rỡ sắc màu, in màu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '彩色'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '彩色'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'cǎisè',
      meaning_vi = 'có màu sắc, rực rỡ sắc màu, in màu',
      example_hanzi = '小女孩用彩色画笔在白纸上画出了一道美丽的彩虹。',
      example_pinyin = 'Xiǎo nǚhái yòng cǎisè huàbǐ zài bái zhǐ shàng huà chū le yí dào měilì de cǎihóng.',
      example_vi = 'Bé gái dùng bút vẽ màu vẽ một dải cầu vồng xinh đẹp lên trên tờ giấy trắng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '彩色',
      'cǎisè',
      'có màu sắc, rực rỡ sắc màu, in màu',
      'Tính từ',
      'HSK 5',
      '小女孩用彩色画笔在白纸上画出了一道美丽的彩虹。',
      'Xiǎo nǚhái yòng cǎisè huàbǐ zài bái zhǐ shàng huà chū le yí dào měilì de cǎihóng.',
      'Bé gái dùng bút vẽ màu vẽ một dải cầu vồng xinh đẹp lên trên tờ giấy trắng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '小女孩用彩色画笔在白纸上画出了一道美丽的彩虹。',
        'Xiǎo nǚhái yòng cǎisè huàbǐ zài bái zhǐ shàng huà chū le yí dào měilì de cǎihóng.',
        'Bé gái dùng bút vẽ màu vẽ một dải cầu vồng xinh đẹp lên trên tờ giấy trắng.',
        'basic',
        1
      ),
      (
        v_id,
        '请将宣传推广手册全部采用高分辨率彩色双面印刷，以彰显公司的高端品牌形象。',
        'Qǐng jiāng xuānchuán tuīguǎng shǒucè quánbù cǎiyòng gāo fēnbianlǜ cǎisè shuāngmiàn yìnshuā, yǐ zhāngxiǎn gōngsī de gāoduān pǐnpái xíngxiàng.',
        'Xin hãy in toàn bộ sổ tay quảng bá truyền thông bằng mực màu độ phân giải cao trên cả hai mặt, nhằm tôn vinh hình ảnh thương hiệu cao cấp của công ty.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2088] [采用] (cǎiyòng) - sử dụng, áp dụng (công nghệ, phương pháp, kiến nghị, mẫu mã) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '采用'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '采用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cǎiyòng',
      meaning_vi = 'sử dụng, áp dụng (công nghệ, phương pháp, kiến nghị, mẫu mã)',
      example_hanzi = '这栋现代写字楼采用了先进的智能节能照明系统。',
      example_pinyin = 'Zhè dòng xiàndài xiězìlóu cǎiyòng le xiānjìn de zhìnéng jiénéng zhàomíng xìtǒng.',
      example_vi = 'Tòa nhà văn phòng hiện đại này đã áp dụng hệ thống chiếu sáng tiết kiệm năng lượng thông minh tiên tiến.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '采用',
      'cǎiyòng',
      'sử dụng, áp dụng (công nghệ, phương pháp, kiến nghị, mẫu mã)',
      'Động từ',
      'HSK 5',
      '这栋现代写字楼采用了先进的智能节能照明系统。',
      'Zhè dòng xiàndài xiězìlóu cǎiyòng le xiānjìn de zhìnéng jiénéng zhàomíng xìtǒng.',
      'Tòa nhà văn phòng hiện đại này đã áp dụng hệ thống chiếu sáng tiết kiệm năng lượng thông minh tiên tiến.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这栋现代写字楼采用了先进的智能节能照明系统。',
        'Zhè dòng xiàndài xiězìlóu cǎiyòng le xiānjìn de zhìnéng jiénéng zhàomíng xìtǒng.',
        'Tòa nhà văn phòng hiện đại này đã áp dụng hệ thống chiếu sáng tiết kiệm năng lượng thông minh tiên tiến.',
        'basic',
        1
      ),
      (
        v_id,
        '研发团队经过数轮严密试验论证，决定采用这种新型复合材料替代传统的重金属零部件。',
        'Yánfā tuánduì jīngguò shù lún yánmì shìyàn lùnzhèng, juédìng cǎiyòng zhè zhǒng xīnxíng fùhé cáiliào tìdài chuántǒng de zhòngjīnshǔ língbùjiàn.',
        'Đội ngũ R&D qua nhiều vòng thử nghiệm và chứng minh chặt chẽ đã quyết định sử dụng vật liệu composite kiểu mới này để thay thế các linh kiện kim loại nặng truyền thống.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2089] [参考] (cānkǎo) - tham khảo; tài liệu tham khảo, sự tham chiếu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '参考'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '参考'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'cānkǎo',
      meaning_vi = 'tham khảo; tài liệu tham khảo, sự tham chiếu',
      example_hanzi = '写毕业论文时需要广泛查阅并参考相关学术书籍。',
      example_pinyin = 'Xiě bìyè lùnwén shí xūyào guǎngfàn cháyuè bìng cānkǎo xiāngguān xuéshù shūjí.',
      example_vi = 'Khi viết khóa luận tốt nghiệp cần tra cứu sâu rộng và tham khảo sách học thuật liên quan.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '参考',
      'cānkǎo',
      'tham khảo; tài liệu tham khảo, sự tham chiếu',
      'Động từ / Danh từ',
      'HSK 5',
      '写毕业论文时需要广泛查阅并参考相关学术书籍。',
      'Xiě bìyè lùnwén shí xūyào guǎngfàn cháyuè bìng cānkǎo xiāngguān xuéshù shūjí.',
      'Khi viết khóa luận tốt nghiệp cần tra cứu sâu rộng và tham khảo sách học thuật liên quan.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '写毕业论文时需要广泛查阅并参考相关学术书籍。',
        'Xiě bìyè lùnwén shí xūyào guǎngfàn cháyuè bìng cānkǎo xiāngguān xuéshù shūjí.',
        'Khi viết khóa luận tốt nghiệp cần tra cứu sâu rộng và tham khảo sách học thuật liên quan.',
        'basic',
        1
      ),
      (
        v_id,
        '本投资分析报告所列数据仅供客户决策参考，不构成任何直接的证券买卖要约建议。',
        'Běn tóuzī fēnxī bàogào suǒ liè shùjù jǐn gōng kèhù juécè cānkǎo, bù gòuchéng rènhé zhíjiē de zhèngquàn mǎimài yàoyuē jiànyì.',
        'Các số liệu nêu trong báo cáo phân tích đầu tư này chỉ mang tính tham khảo cho quyết định của khách hàng, không cấu thành bất kỳ đề xuất chào mua bán chứng khoán trực tiếp nào.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2090] [餐饮] (cānyǐn) - ẩm thực, ăn uống; ngành dịch vụ ăn uống (nhà hàng, khách sạn) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '餐饮'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '餐饮'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'cānyǐn',
      meaning_vi = 'ẩm thực, ăn uống; ngành dịch vụ ăn uống (nhà hàng, khách sạn)',
      example_hanzi = '商场五楼是聚集了各国风味美食的餐饮专区。',
      example_pinyin = 'Shāngchǎng wǔ lóu shì jùjí le gè guó fēngwèi měishí de cānyǐn zhuānqū.',
      example_vi = 'Tầng năm của trung tâm thương mại là khu vực ẩm thực chuyên biệt quy tụ món ăn ngon hương vị các nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '餐饮',
      'cānyǐn',
      'ẩm thực, ăn uống; ngành dịch vụ ăn uống (nhà hàng, khách sạn)',
      'Danh từ',
      'HSK 5',
      '商场五楼是聚集了各国风味美食的餐饮专区。',
      'Shāngchǎng wǔ lóu shì jùjí le gè guó fēngwèi měishí de cānyǐn zhuānqū.',
      'Tầng năm của trung tâm thương mại là khu vực ẩm thực chuyên biệt quy tụ món ăn ngon hương vị các nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '商场五楼是聚集了各国风味美食的餐饮专区。',
        'Shāngchǎng wǔ lóu shì jùjí le gè guó fēngwèi měishí de cānyǐn zhuānqū.',
        'Tầng năm của trung tâm thương mại là khu vực ẩm thực chuyên biệt quy tụ món ăn ngon hương vị các nước.',
        'basic',
        1
      ),
      (
        v_id,
        '受线上外卖平台与生鲜电商的双重推动，连锁餐饮行业的数字化外送业务迎来爆发式增长。',
        'Shòu xiànshàng wàimài píngtái yǔ shēngxiān diànshāng de shuāngchóng tuīdòng, liánsuǒ cānyǐn hángyè de shùzìhuà wàisòng yèwù yínglái bàofāshì zēngzhǎng.',
        'Nhận lực đẩy kép từ các nền tảng giao đồ ăn trực tuyến và thương mại điện tử thực phẩm tươi sống, mảng dịch vụ giao hàng kỹ thuật số của ngành ẩm thực chuỗi đã đón nhận mức tăng trưởng bùng nổ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2091] [参与] (cānyù) - tham gia, dự phần vào (hoạt động, dự án, xây dựng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '参与'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '参与'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cānyù',
      meaning_vi = 'tham gia, dự phần vào (hoạt động, dự án, xây dựng)',
      example_hanzi = '学校鼓励所有学生积极参与社区义务劳动和公益志愿活动。',
      example_pinyin = 'Xuéxiào gǔlì suǒyǒu xuésheng jījí cānyù shèqū yìwù láodòng hé gōngyì zhìyuàn huódòng.',
      example_vi = 'Nhà trường khuyến khích toàn thể học sinh tích cực tham gia lao động nghĩa vụ cộng đồng và các hoạt động tình nguyện công ích.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '参与',
      'cānyù',
      'tham gia, dự phần vào (hoạt động, dự án, xây dựng)',
      'Động từ',
      'HSK 5',
      '学校鼓励所有学生积极参与社区义务劳动和公益志愿活动。',
      'Xuéxiào gǔlì suǒyǒu xuésheng jījí cānyù shèqū yìwù láodòng hé gōngyì zhìyuàn huódòng.',
      'Nhà trường khuyến khích toàn thể học sinh tích cực tham gia lao động nghĩa vụ cộng đồng và các hoạt động tình nguyện công ích.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '学校鼓励所有学生积极参与社区义务劳动和公益志愿活动。',
        'Xuéxiào gǔlì suǒyǒu xuésheng jījí cānyù shèqū yìwù láodòng hé gōngyì zhìyuàn huódòng.',
        'Nhà trường khuyến khích toàn thể học sinh tích cực tham gia lao động nghĩa vụ cộng đồng và các hoạt động tình nguyện công ích.',
        'basic',
        1
      ),
      (
        v_id,
        '能够作为核心主创人员全过程参与国家重点水利枢纽工程的论证建设，是我一生的骄傲。',
        'Nénggòu zuòwéi héxīn zhǔchuàng rényuán quán guòchéng cānyù guójiā zhòngdiǎn shuǐlì shūniǔ gōngchéng de lùnzhèng jiànshè, shì wǒ yìshēng de jiāo’ào.',
        'Có thể với tư cách thành viên sáng lập nòng cốt tham gia toàn bộ quá trình chứng minh xây dựng công trình đầu mối thủy lợi trọng điểm quốc gia là niềm tự hào suốt cả cuộc đời tôi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2092] [藏] (cáng) - cất giấu, ẩn náu, giấu kín; tàng trữ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '藏'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '藏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cáng',
      meaning_vi = 'cất giấu, ẩn náu, giấu kín; tàng trữ',
      example_hanzi = '小猫受到了惊吓，敏捷地藏到了沙发底下。',
      example_pinyin = 'Xiǎomāo shòudào le jīngxià, mǐnjié de cáng dào le shāfā dǐxia.',
      example_vi = 'Chú mèo con bị hoảng sợ, nhanh nhẹn chui tọt vào trốn dưới gầm ghế sofa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '藏',
      'cáng',
      'cất giấu, ẩn náu, giấu kín; tàng trữ',
      'Động từ',
      'HSK 5',
      '小猫受到了惊吓，敏捷地藏到了沙发底下。',
      'Xiǎomāo shòudào le jīngxià, mǐnjié de cáng dào le shāfā dǐxia.',
      'Chú mèo con bị hoảng sợ, nhanh nhẹn chui tọt vào trốn dưới gầm ghế sofa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '小猫受到了惊吓，敏捷地藏到了沙发底下。',
        'Xiǎomāo shòudào le jīngxià, mǐnjié de cáng dào le shāfā dǐxia.',
        'Chú mèo con bị hoảng sợ, nhanh nhẹn chui tọt vào trốn dưới gầm ghế sofa.',
        'basic',
        1
      ),
      (
        v_id,
        '古色古香的徽派传统村落深藏在翠竹环绕的大山峡谷之中，宛如一幅世外桃源水墨画卷。',
        'Gǔsègǔxiāng de Huīpài chuántǒng cūnluò shēn cáng zài cuìzhú huánrào de dàshān xiágǔ zhī zhōng, wǎnrú yì fú shìwàitáoyuán shuǐmò huàjuàn.',
        'Ngôi làng cổ truyền thống mang đậm nét kiến trúc phái Huy Châu ẩn sâu trong khe núi non trùng điệp tre biếc bao quanh, tựa như một bức tranh thủy mặc chốn đào nguyên tiên cảnh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2093] [操作] (cāozuò) - thao tác, vận hành, điều khiển (máy móc, thiết bị, hệ thống) [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '操作'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '操作'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'cāozuò',
      meaning_vi = 'thao tác, vận hành, điều khiển (máy móc, thiết bị, hệ thống)',
      example_hanzi = '新手请在专业教练的指导下规范操作这台精密机床。',
      example_pinyin = 'Xīnshǒu qǐng zài zhuānyè jiàoliàn de zhǐdǎo xià guīfàn cāozuò zhè tái jīngmì jīchuáng.',
      example_vi = 'Người mới xin vui lòng vận hành chiếc máy công cụ chuẩn xác này đúng quy phạm dưới sự hướng dẫn của huấn luyện viên chuyên nghiệp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '操作',
      'cāozuò',
      'thao tác, vận hành, điều khiển (máy móc, thiết bị, hệ thống)',
      'Động từ / Danh từ',
      'HSK 5',
      '新手请在专业教练的指导下规范操作这台精密机床。',
      'Xīnshǒu qǐng zài zhuānyè jiàoliàn de zhǐdǎo xià guīfàn cāozuò zhè tái jīngmì jīchuáng.',
      'Người mới xin vui lòng vận hành chiếc máy công cụ chuẩn xác này đúng quy phạm dưới sự hướng dẫn của huấn luyện viên chuyên nghiệp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '新手请在专业教练的指导下规范操作这台精密机床。',
        'Xīnshǒu qǐng zài zhuānyè jiàoliàn de zhǐdǎo xià guīfàn cāozuò zhè tái jīngmì jīchuáng.',
        'Người mới xin vui lòng vận hành chiếc máy công cụ chuẩn xác này đúng quy phạm dưới sự hướng dẫn của huấn luyện viên chuyên nghiệp.',
        'basic',
        1
      ),
      (
        v_id,
        '本智能控制系统的界面设计极其人性化，工作人员只需点击屏幕即可轻松完成复杂的操作流程。',
        'Běn zhìnéng kòngzhì xìtǒng de jièmiàn shèjì jíqí rénxìnghuà, gōngzuò rényuán zhǐ xū diǎnjī píngmù jí kě qīngsōng wánchéng fùzá de cāozuò liúchéng.',
        'Giao diện của hệ thống điều khiển thông minh này được thiết kế cực kỳ thân thiện với người dùng, nhân viên làm việc chỉ cần nhấp vào màn hình là có thể dễ dàng hoàn thành quy trình thao tác phức tạp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2094] [册] (cè) - cuốn, quyển, tập (sách); tập sách, album [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '册'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '册'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'cè',
      meaning_vi = 'cuốn, quyển, tập (sách); tập sách, album',
      example_hanzi = '这套权威实用的汉语百科全书一共分为上下两册。',
      example_pinyin = 'Zhè tào quánwēi shíyòng de Hànyǔ bǎikē quánshū yí gòng fēn wéi shàng-xià liǎng cè.',
      example_vi = 'Bộ bách khoa toàn thư tiếng Hán thực dụng uy tín này tổng cộng được chia thành hai tập thượng và hạ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '册',
      'cè',
      'cuốn, quyển, tập (sách); tập sách, album',
      'Lượng từ / Danh từ',
      'HSK 5',
      '这套权威实用的汉语百科全书一共分为上下两册。',
      'Zhè tào quánwēi shíyòng de Hànyǔ bǎikē quánshū yí gòng fēn wéi shàng-xià liǎng cè.',
      'Bộ bách khoa toàn thư tiếng Hán thực dụng uy tín này tổng cộng được chia thành hai tập thượng và hạ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这套权威实用的汉语百科全书一共分为上下两册。',
        'Zhè tào quánwēi shíyòng de Hànyǔ bǎikē quánshū yí gòng fēn wéi shàng-xià liǎng cè.',
        'Bộ bách khoa toàn thư tiếng Hán thực dụng uy tín này tổng cộng được chia thành hai tập thượng và hạ.',
        'basic',
        1
      ),
      (
        v_id,
        '这部长篇历史小说自正式发行以来，在全国各大书店累计畅销已突破五十万册。',
        'Zhè bù chángpiān lìshǐ xiǎoshuō zì zhèngshì fāxíng yǐlái, zài quánguó gè dà shūdiàn lěijì chàngxiāo yǐ tūpò wǔshí wàn cè.',
        'Cuốn tiểu thuyết lịch sử trường thiên này kể từ khi chính thức phát hành đến nay, lượng bán chạy tích lũy tại các nhà sách lớn trên toàn quốc đã vượt mốc năm trăm nghìn bản.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2095] [测] (cè) - đo, đo lường, khảo nghiệm, trắc lượng, đoán [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '测'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '测'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cè',
      meaning_vi = 'đo, đo lường, khảo nghiệm, trắc lượng, đoán',
      example_hanzi = '护士每天早晨都会来病房为病人测体温和量血压。',
      example_pinyin = 'Hùshi měitiān zǎochén dōu huì lái bìngfáng wèi bìngrén cè tǐwēn hé liáng xuèyā.',
      example_vi = 'Y tá mỗi buổi sáng đều đến phòng bệnh đo thân nhiệt và đo huyết áp cho bệnh nhân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '测',
      'cè',
      'đo, đo lường, khảo nghiệm, trắc lượng, đoán',
      'Động từ',
      'HSK 5',
      '护士每天早晨都会来病房为病人测体温和量血压。',
      'Hùshi měitiān zǎochén dōu huì lái bìngfáng wèi bìngrén cè tǐwēn hé liáng xuèyā.',
      'Y tá mỗi buổi sáng đều đến phòng bệnh đo thân nhiệt và đo huyết áp cho bệnh nhân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '护士每天早晨都会来病房为病人测体温和量血压。',
        'Hùshi měitiān zǎochén dōu huì lái bìngfáng wèi bìngrén cè tǐwēn hé liáng xuèyā.',
        'Y tá mỗi buổi sáng đều đến phòng bệnh đo thân nhiệt và đo huyết áp cho bệnh nhân.',
        'basic',
        1
      ),
      (
        v_id,
        '气象监测部门利用先进的高空探测雷达和气象卫星，严密监测台风的最新移动路径。',
        'Qìxiàng jiāncè bùmén lìyòng xiānjìn de gāokōng tàncè léidá hé qìxiàng wèixīng, yánmì jiāncè táifēng de zuìxīn yídòng lùjìng.',
        'Cơ quan giám sát khí tượng sử dụng radar thám trắc tầm cao tiên tiến và vệ tinh khí tượng để theo dõi chặt chẽ quỹ đạo di chuyển mới nhất của cơn bão nhiệt đới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2096] [测试] (cèshì) - kiểm tra, thử nghiệm, trắc nghiệm (phần mềm, thiết bị, năng lực) [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '测试'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '测试'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'cèshì',
      meaning_vi = 'kiểm tra, thử nghiệm, trắc nghiệm (phần mềm, thiết bị, năng lực)',
      example_hanzi = '软件工程师正在对手机应用程序的新功能进行多轮严格测试。',
      example_pinyin = 'Ruǎnjiàn gōngchéngshī zhèngzài duì shǒujī yìngyòng chéngxù de xīn gōngnéng jìnxíng duō lún yángé cèshì.',
      example_vi = 'Các kỹ sư phần mềm đang tiến hành nhiều đợt thử nghiệm khắt khe đối với chức năng mới của ứng dụng di động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '测试',
      'cèshì',
      'kiểm tra, thử nghiệm, trắc nghiệm (phần mềm, thiết bị, năng lực)',
      'Động từ / Danh từ',
      'HSK 5',
      '软件工程师正在对手机应用程序的新功能进行多轮严格测试。',
      'Ruǎnjiàn gōngchéngshī zhèngzài duì shǒujī yìngyòng chéngxù de xīn gōngnéng jìnxíng duō lún yángé cèshì.',
      'Các kỹ sư phần mềm đang tiến hành nhiều đợt thử nghiệm khắt khe đối với chức năng mới của ứng dụng di động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '软件工程师正在对手机应用程序的新功能进行多轮严格测试。',
        'Ruǎnjiàn gōngchéngshī zhèngzài duì shǒujī yìngyòng chéngxù de xīn gōngnéng jìnxíng duō lún yángé cèshì.',
        'Các kỹ sư phần mềm đang tiến hành nhiều đợt thử nghiệm khắt khe đối với chức năng mới của ứng dụng di động.',
        'basic',
        1
      ),
      (
        v_id,
        '新车量产投放市场之前，必须在极端严寒的高原和酷暑沙漠环境中接受各项性能耐久性极限测试。',
        'Xīn chē liàngchǎn tóufàng shìchǎng zhīqián, bìxū zài jíduān yánhán de gāoyuán hé kùshǔ shāmò huánjìng zhōng jiēshòu gè xiàng xìngnéng nàijiǔxìng jíxiàn cèshì.',
        'Trước khi dòng xe mới sản xuất hàng loạt đưa ra thị trường, bắt buộc phải trải qua các bài kiểm tra giới hạn về độ bền và tính năng trong môi trường cao nguyên cực kỳ lạnh giá và sa mạc nóng bức.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2097] [曾] (céng) - từng, đã từng (biểu thị sự việc xảy ra trong quá khứ) [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '曾'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '曾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'céng',
      meaning_vi = 'từng, đã từng (biểu thị sự việc xảy ra trong quá khứ)',
      example_hanzi = '他年轻时曾是一名优秀的国家级男子排球运动员。',
      example_pinyin = 'Tā niánqīng shí céng shì yì míng yōuxiù de guójiājí nánzǐ páiqiú yùndòngyuán.',
      example_vi = 'Thời trẻ anh ấy từng là một vận động viên bóng chuyền nam cấp quốc gia xuất sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '曾',
      'céng',
      'từng, đã từng (biểu thị sự việc xảy ra trong quá khứ)',
      'Phó từ',
      'HSK 5',
      '他年轻时曾是一名优秀的国家级男子排球运动员。',
      'Tā niánqīng shí céng shì yì míng yōuxiù de guójiājí nánzǐ páiqiú yùndòngyuán.',
      'Thời trẻ anh ấy từng là một vận động viên bóng chuyền nam cấp quốc gia xuất sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他年轻时曾是一名优秀的国家级男子排球运动员。',
        'Tā niánqīng shí céng shì yì míng yōuxiù de guójiājí nánzǐ páiqiú yùndòngyuán.',
        'Thời trẻ anh ấy từng là một vận động viên bóng chuyền nam cấp quốc gia xuất sắc.',
        'basic',
        1
      ),
      (
        v_id,
        '两座历史文化名城曾在古代丝绸之路的经贸与文明交流中扮演过举足轻重的重要桥梁角色。',
        'Liǎng zuò lìshǐ wénhuà míngchéng céng zài gǔdài Sīchóu zhī Lù de jīng-mào yǔ wénmíng jiāoliú zhōng bànyǎn guò jǔzúqīngzhòng de zhòngyào qiáoliáng juésè.',
        'Hai danh thành lịch sử văn hóa từng đóng vai trò cầu nối trọng yếu có sức ảnh hưởng to lớn trong hoạt động kinh tế thương mại và giao lưu văn minh trên Con đường Tơ lụa cổ đại.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2098] [曾经] (céngjīng) - đã từng, trước đây từng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '曾经'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '曾经'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'céngjīng',
      meaning_vi = 'đã từng, trước đây từng',
      example_hanzi = '我曾经在北方这座海滨城市工作生活了整整五年。',
      example_pinyin = 'Wǒ céngjīng zài běifāng zhè zuò hǎibīn chéngshì gōngzuò shēnghuó le zhěngzhěng wǔ nián.',
      example_vi = 'Tôi đã từng làm việc và sinh sống tại thành phố ven biển miền bắc này trọn vẹn năm năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '曾经',
      'céngjīng',
      'đã từng, trước đây từng',
      'Phó từ',
      'HSK 5',
      '我曾经在北方这座海滨城市工作生活了整整五年。',
      'Wǒ céngjīng zài běifāng zhè zuò hǎibīn chéngshì gōngzuò shēnghuó le zhěngzhěng wǔ nián.',
      'Tôi đã từng làm việc và sinh sống tại thành phố ven biển miền bắc này trọn vẹn năm năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '我曾经在北方这座海滨城市工作生活了整整五年。',
        'Wǒ céngjīng zài běifāng zhè zuò hǎibīn chéngshì gōngzuò shēnghuó le zhěngzhěng wǔ nián.',
        'Tôi đã từng làm việc và sinh sống tại thành phố ven biển miền bắc này trọn vẹn năm năm.',
        'basic',
        1
      ),
      (
        v_id,
        '这家老牌机械制造厂曾经创造过十分辉煌的业绩，如今在科技转型浪潮中再次焕发了蓬勃生机。',
        'Zhè jiā lǎopái jīxiè zhìzàochǎng céngjīng chuàngzào guò shífēn huīhuáng de yèjì, rújīn zài kējì zhuǎnxíng làngcháo zhōng zàicì huànfā le péngbó shēngjī.',
        'Nhà máy chế tạo cơ khí lâu đời này từng tạo nên những thành tích vô cùng rực rỡ, ngày nay trong làn sóng chuyển đổi công nghệ đã một lần nữa bừng sáng sức sống phơi phới dồi dào.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2099] [插] (chā) - cắm, cắm vào; xen vào, chen ngang (cắm sạc, ngắt lời) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '插'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '插'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chā',
      meaning_vi = 'cắm, cắm vào; xen vào, chen ngang (cắm sạc, ngắt lời)',
      example_hanzi = '手机电量不足了，请赶紧把充电器插到插座上。',
      example_pinyin = 'Shǒujī diànliàng bùzú le, qǐng gǎnjǐn bǎ chōngdiànqì chā dào chāzuò shàng.',
      example_vi = 'Điện thoại sắp hết pin rồi, xin hãy mau cắm cục sạc vào ổ cắm điện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '插',
      'chā',
      'cắm, cắm vào; xen vào, chen ngang (cắm sạc, ngắt lời)',
      'Động từ',
      'HSK 5',
      '手机电量不足了，请赶紧把充电器插到插座上。',
      'Shǒujī diànliàng bùzú le, qǐng gǎnjǐn bǎ chōngdiànqì chā dào chāzuò shàng.',
      'Điện thoại sắp hết pin rồi, xin hãy mau cắm cục sạc vào ổ cắm điện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '手机电量不足了，请赶紧把充电器插到插座上。',
        'Shǒujī diànliàng bùzú le, qǐng gǎnjǐn bǎ chōngdiànqì chā dào chāzuò shàng.',
        'Điện thoại sắp hết pin rồi, xin hãy mau cắm cục sạc vào ổ cắm điện.',
        'basic',
        1
      ),
      (
        v_id,
        '在正式的商务会议中，当别人正在发言阐述观点时，中途随意插话是极其不礼貌的行为。',
        'Zài zhèngshì de shāngwù huìyì zhōng, dāng biérén zhèngzài fāyán chǎnshù guāndiǎn shí, zhōngtú suíyì chāhuà shì jíqí bù lǐmào de xíngwéi.',
        'Trong cuộc họp kinh doanh chính thức, khi người khác đang phát biểu trình bày quan điểm, việc tùy tiện chen ngang ngắt lời giữa chừng là hành vi hết sức bất lịch sự.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2100] [差别] (chābié) - sự khác biệt, chênh lệch, phân biệt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '差别'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '差别'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chābié',
      meaning_vi = 'sự khác biệt, chênh lệch, phân biệt',
      example_hanzi = '这两款手机在外观设计上几乎看不出什么明显的差别。',
      example_pinyin = 'Zhè liǎng kuǎn shǒujī zài wàiguān shèjì shàng jīhū kàn bù chū shénme míngxiǎn de chābié.',
      example_vi = 'Hai mẫu điện thoại này trên thiết kế bề ngoài hầu như không nhìn ra sự khác biệt rõ nét nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '差别',
      'chābié',
      'sự khác biệt, chênh lệch, phân biệt',
      'Danh từ',
      'HSK 5',
      '这两款手机在外观设计上几乎看不出什么明显的差别。',
      'Zhè liǎng kuǎn shǒujī zài wàiguān shèjì shàng jīhū kàn bù chū shénme míngxiǎn de chābié.',
      'Hai mẫu điện thoại này trên thiết kế bề ngoài hầu như không nhìn ra sự khác biệt rõ nét nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这两款手机在外观设计上几乎看不出什么明显的差别。',
        'Zhè liǎng kuǎn shǒujī zài wàiguān shèjì shàng jīhū kàn bù chū shénme míngxiǎn de chābié.',
        'Hai mẫu điện thoại này trên thiết kế bề ngoài hầu như không nhìn ra sự khác biệt rõ nét nào.',
        'basic',
        1
      ),
      (
        v_id,
        '城乡之间在公共医疗卫生资源配置与教育质量方面仍然存在着不容忽视的客观差别。',
        'Chéng-xiāng zhījiān zài gōnggòng yīliáo wèishēng zīyuán pèizhì yǔ jiàoyù zhìliàng fāngmiàn réngrán cúnzài zhe bùróng hūshì de kèguān chābié.',
        'Giữa thành thị và nông thôn trong việc phân bổ tài nguyên y tế công cộng và chất lượng giáo dục vẫn còn tồn tại những sự chênh lệch khách quan không thể xem nhẹ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp câu ví dụ HSK 5 - Batch 1: đã xử lý % từ vựng.', v_count;
END $$;
