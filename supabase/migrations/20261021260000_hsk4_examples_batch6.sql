-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 6 (100 TỪ)
-- Phạm vi: #1501 [美好] (měihǎo) -> #1600 [全都] (quándōu)
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
  -- [美好] (měihǎo) - tươi đẹp, tốt đẹp [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '美好' AND pinyin = 'měihǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '美好'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'měihǎo',
      meaning_vi = 'tươi đẹp, tốt đẹp',
      example_hanzi = '童年时光总是给我们留下许多温馨美好的回忆。',
      example_pinyin = 'Tóngnián shíguāng zǒngshì gěi wǒmen liúxia xǔduō wēnxīn měihǎo de huíyì.',
      example_vi = 'Khoảng thời gian tuổi thơ luôn để lại cho chúng ta nhiều ký ức ấm áp tươi đẹp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '童年时光总是给我们留下许多温馨美好的回忆。', 'Tóngnián shíguāng zǒngshì gěi wǒmen liúxia xǔduō wēnxīn měihǎo de huíyì.', 'Khoảng thời gian tuổi thơ luôn để lại cho chúng ta nhiều ký ức ấm áp tươi đẹp.', 'basic', 1),
        (v_id, '人民对美好生活的向往就是我们奋斗的目标，国家坚持通过高质量发展持续增进民生福祉。', 'Rénmín duì měihǎo shēnghuó de xiàngwǎng jiùshì wǒmen fèndòu de mùbiāo, guójiā jiānchí tōngguò gāozhìliàng fāzhǎn chíxù zēngjìn mínshēng fúzhǐ.', 'Sự khao khát của nhân dân đối với cuộc sống tốt đẹp chính là mục tiêu phấn đấu của chúng ta, đất nước kiên trì thông qua phát triển chất lượng cao để không ngừng nâng cao phúc lợi dân sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [美景] (měijǐng) - cảnh đẹp, mỹ cảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '美景' AND pinyin = 'měijǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '美景'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'měijǐng',
      meaning_vi = 'cảnh đẹp, mỹ cảnh',
      example_hanzi = '登上山顶俯瞰，整座城市绚丽迷人的万家灯火美景尽收眼底。',
      example_pinyin = 'Dēng shàng shāndǐng fǔkàn, zhěng zuò chéngshì xuànlì-mírén de wànjiādēnghuǒ měijǐng jìn shōu yǎndǐ.',
      example_vi = 'Lên đỉnh núi nhìn xuống, toàn cảnh cảnh đẹp ánh đèn vạn mái ấm lung linh mê đắm của cả thành phố thu trọn vào tầm mắt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '登上山顶俯瞰，整座城市绚丽迷人的万家灯火美景尽收眼底。', 'Dēng shàng shāndǐng fǔkàn, zhěng zuò chéngshì xuànlì-mírén de wànjiādēnghuǒ měijǐng jìn shōu yǎndǐ.', 'Lên đỉnh núi nhìn xuống, toàn cảnh cảnh đẹp ánh đèn vạn mái ấm lung linh mê đắm của cả thành phố thu trọn vào tầm mắt.', 'basic', 1),
        (v_id, '桂林漓江烟雨空濛，奇峰倒影与碧水渔舟相映成趣，构成了天下独绝的天然中国山水画美景。', 'Guìlín Lí Jiāng yānyǔ kōngméng, qífēng dàoyǐng yǔ bìshuǐ yúzhōu xiāngyìng-chéngqù, gòuchéng le tiānxià dújué de tiānrán Zhōngguó shānshuǐhuà měijǐng.', 'Mưa bụi mờ ảo trên sông Ly ở Quế Lâm, bóng núi kỳ vĩ in đáy nước hòa cùng thuyền câu dòng nước biếc, tạo nên cảnh đẹp tranh sơn thủy Trung Hoa tự nhiên độc nhất vô nhị dưới gầm trời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [美丽] (měilì) - xinh đẹp, tươi đẹp [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '美丽' AND pinyin = 'měilì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '美丽'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'měilì',
      meaning_vi = 'xinh đẹp, tươi đẹp',
      example_hanzi = '春天到了，公园里的桃花盛开，景色非常美丽。',
      example_pinyin = 'Chūntiān dào le, gōngyuán lǐ de táohuā shèngkāi, jǐngsè fēicháng měilì.',
      example_vi = 'Mùa xuân đến rồi, hoa đào trong công viên đua nở, cảnh sắc vô cùng tươi đẹp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '春天到了，公园里的桃花盛开，景色非常美丽。', 'Chūntiān dào le, gōngyuán lǐ de táohuā shèngkāi, jǐngsè fēicháng měilì.', 'Mùa xuân đến rồi, hoa đào trong công viên đua nở, cảnh sắc vô cùng tươi đẹp.', 'basic', 1),
        (v_id, '建设人与自然和谐共生的“美丽中国”，必须牢固树立绿水青山就是金山银山的生态发展理念。', 'Jiànshè rén yǔ zìrán héxié-gòngshēng de “Měilì Zhōngguó”, bìxū láogù shùlì lǜshuǐ-qīngshān jiùshì jīnshān-yínshān de shēngtài fāzhǎn lǐniàn.', 'Xây dựng một "Trung Quốc tươi đẹp" nơi con người và thiên nhiên cùng chung sống hòa hợp, bắt buộc phải xác lập vững chắc triết lý phát triển sinh thái núi xanh nước biếc chính là núi vàng núi bạc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [美食] (měishí) - món ăn ngon, mỹ vị ẩm thực [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '美食' AND pinyin = 'měishí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '美食'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'měishí',
      meaning_vi = 'món ăn ngon, mỹ vị ẩm thực',
      example_hanzi = '来到成都旅游，一定要去品尝一下宽窄巷子里的传统特色地道美食。',
      example_pinyin = 'Lái dào Chéngdū lǚyóu, yídìng yào qù pǐncháng yíxià Kuānzhǎi Xiàngzi lǐ de chuántǒng tèsè dìdao měishí.',
      example_vi = 'Đến Thành Đô du lịch, nhất định phải đi nếm thử các món ăn ngon đặc sắc truyền thống chuẩn vị ở ngõ Rộng Hẹp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '来到成都旅游，一定要去品尝一下宽窄巷子里的传统特色地道美食。', 'Lái dào Chéngdū lǚyóu, yídìng yào qù pǐncháng yíxià Kuānzhǎi Xiàngzi lǐ de chuántǒng tèsè dìdao měishí.', 'Đến Thành Đô du lịch, nhất định phải đi nếm thử các món ăn ngon đặc sắc truyền thống chuẩn vị ở ngõ Rộng Hẹp.', 'basic', 1),
        (v_id, '中国饮食文化博大精深，纪录片《舌尖上的中国》生动展现了中华大地千百年来因地制宜孕育出的多元特色美食体系。', 'Zhōngguó yǐnshí wénhuà bódà-jīngshēn, jìlùpiàn “Shéjiān shang de Zhōngguó” shēngdòng zhǎnxiàn le Zhōnghuá dàdì qiān bǎi nián lái yīndìzhìyí yùnyù chū de duōyuán tèsè měishí tǐxì.', 'Văn hóa ẩm thực Trung Hoa bác đại tinh thâm, bộ phim tài liệu "Trung Hoa trên đầu lưỡi" đã thể hiện sinh động hệ thống mỹ vị ẩm thực đặc sắc đa dạng được nuôi dưỡng từ sự thích nghi theo địa phương qua hàng ngàn năm trên mảnh đất Trung Hoa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [梦] (mèng) - giấc mơ, chiêm bao; nằm mơ [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '梦' AND pinyin = 'mèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '梦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'mèng',
      meaning_vi = 'giấc mơ, chiêm bao; nằm mơ',
      example_hanzi = '昨晚我做了一个非常奇特有趣的梦，梦见自己登上了月球。',
      example_pinyin = 'Zuówǎn wǒ zuò le yí gè fēicháng qítè yǒuqù de mèng, mèngjiàn zìjǐ dēng shàng le yuèqiú.',
      example_vi = 'Tối qua tôi đã mơ một giấc mơ vô cùng kỳ lạ và thú vị, mơ thấy mình đã đặt chân lên mặt trăng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '昨晚我做了一个非常奇特有趣的梦，梦见自己登上了月球。', 'Zuówǎn wǒ zuò le yí gè fēicháng qítè yǒuqù de mèng, mèngjiàn zìjǐ dēng shàng le yuèqiú.', 'Tối qua tôi đã mơ một giấc mơ vô cùng kỳ lạ và thú vị, mơ thấy mình đã đặt chân lên mặt trăng.', 'basic', 1),
        (v_id, '一代代航天科学家把飞天揽月的千年梦想，化作了神舟飞船与天宫空间站翱翔苍穹的壮丽现实。', 'Yídàidài hángtiān kēxuéjiā bǎ fēitiān lǎn yuè de qiānnián mèng, huà zuò le Shénzhōu fēichuán yǔ Tiāngōng kōngjiānzhàn áoxiáng cāngqióng de zhuànglì xiànshí.', 'Từng thế hệ nhà khoa học hàng không vũ trụ đã biến giấc mơ ngàn năm bay lên trời hái trăng thành hiện thực tráng lệ khi tàu Thần Châu và trạm không gian Thiên Cung bay lượn giữa bầu trời xanh thẳm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [梦想] (mèngxiǎng) - ước mơ, hoài bão; mơ ước [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '梦想' AND pinyin = 'mèngxiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '梦想'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'mèngxiǎng',
      meaning_vi = 'ước mơ, hoài bão; mơ ước',
      example_hanzi = '他从小的梦想就是成为一名救死扶伤的白衣天使。',
      example_pinyin = 'Tā cóngxiǎo de mèngxiǎng jiùshì chéngwéi yì míng jiùsǐ-fúshāng de báiyī tiānshǐ.',
      example_vi = 'Ước mơ từ nhỏ của anh ấy chính là trở thành một thiên thần áo trắng cứu người giúp đời.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他从小的梦想就是成为一名救死扶伤的白衣天使。', 'Tā cóngxiǎo de mèngxiǎng jiùshì chéngwéi yì míng jiùsǐ-fúshāng de báiyī tiānshǐ.', 'Ước mơ từ nhỏ của anh ấy chính là trở thành một thiên thần áo trắng cứu người giúp đời.', 'basic', 1),
        (v_id, '青年一代生逢伟大时代，应当敢于有梦、勇于追梦、勤于圆梦，把个人远大抱负融入国家发展伟业之中。', 'Qīngnián yídài shēng féng wěidà shídài, yīngdāng gǎnyú yǒu mèng, yǒngyú zhuī mèng, qínyú yuán mèng, bǎ gèrén yuǎndà bàofù róngrù guójiā fāzhǎn wěiyè zhīzhōng.', 'Thế hệ trẻ sinh ra giữa thời đại vĩ đại, cần phải dám có ước mơ, dũng cảm theo đuổi ước mơ, cần mẫn hiện thực hóa ước mơ, hòa hoài bão lớn của cá nhân vào sự nghiệp phát triển vĩ đại của đất nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [密码] (mìmǎ) - mật khẩu, mật mã [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '密码' AND pinyin = 'mìmǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '密码'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mìmǎ',
      meaning_vi = 'mật khẩu, mật mã',
      example_hanzi = '为了账户资金安全，银行卡取款密码请不要设置得过于简单。',
      example_pinyin = 'Wèile zhànghù zījīn ānquán, yínhángkǎ qǔkuǎn mìmǎ qǐng bú yào shèzhì de guòyú jiǎndān.',
      example_vi = 'Để đảm bảo an toàn tiền vốn trong tài khoản, mật khẩu rút tiền thẻ ngân hàng xin đừng cài đặt quá đơn giản.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了账户资金安全，银行卡取款密码请不要设置得过于简单。', 'Wèile zhànghù zījīn ānquán, yínhángkǎ qǔkuǎn mìmǎ qǐng bú yào shèzhì de guòyú jiǎndān.', 'Để đảm bảo an toàn tiền vốn trong tài khoản, mật khẩu rút tiền thẻ ngân hàng xin đừng cài đặt quá đơn giản.', 'basic', 1),
        (v_id, '网络信息安全专家建议用户开启多重身份双因子验证，并定期对关键业务系统的管理账户密码进行加密轮换。', 'Wǎngluò xìnxī ānquán zhuānjiā jiànyì yònghù kāiqǐ duōchóng shēnfèn shuāng-yīnzǐ yànzhèng, bìng dìngqī duì guānjiàn yèwù xìtǒng de guǎnlǐ zhànghù mìmǎ jìnxíng jiāmì lúnhuàn.', 'Các chuyên gia an toàn thông tin mạng khuyến nghị người dùng kích hoạt xác thực hai yếu tố đa tầng danh tính, và định kỳ đổi mã hóa luân phiên mật khẩu tài khoản quản trị của các hệ thống nghiệp vụ trọng yếu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [免费] (miǎnfèi) - miễn phí; miễn cước [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '免费' AND pinyin = 'miǎnfèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '免费'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'miǎnfèi',
      meaning_vi = 'miễn phí; miễn cước',
      example_hanzi = '市立博物馆在每个星期二全天向广大市民和游客免费开放。',
      example_pinyin = 'Shìlì bówùguǎn zài měi gè xīngqī’èr quántiān xiàng guǎngdà shìmín hé yóukè miǎnfèi kāifàng.',
      example_vi = 'Bảo tàng thành phố mở cửa miễn phí cả ngày cho đông đảo người dân và du khách vào mỗi thứ Ba hàng tuần.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '市立博物馆在每个星期二全天向广大市民和游客免费开放。', 'Shìlì bówùguǎn zài měi gè xīngqī’èr quántiān xiàng guǎngdà shìmín hé yóukè miǎnfèi kāifàng.', 'Bảo tàng thành phố mở cửa miễn phí cả ngày cho đông đảo người dân và du khách vào mỗi thứ Ba hàng tuần.', 'basic', 1),
        (v_id, '为吸引更多海外高水平创新创业团队落户，该国家级科技园区提供了长达三年的免租金研发办公场地与免费云算力支持。', 'Wèi xīyǐn gèng duō hǎiwài gāo shuǐpíng chuàngxīn chuàngyè tuánduì luòhù, gāi guójiājí kējì yuánqū tígōng le cháng dá sān nián de miǎn zūjīn yánfā bàngōng chǎngdì yǔ miǎnfèi yúnsuànlì zhīchí.', 'Để thu hút thêm nhiều đội ngũ đổi mới khởi nghiệp trình độ cao từ hải ngoại về định cư, khu công nghệ cấp quốc gia này đã đem lại mặt bằng văn phòng R&D miễn tiền thuê kéo dài tới 3 năm cùng hỗ trợ năng lực điện toán đám mây miễn phí.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [面对] (miànduì) - đối mặt, đối diện [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '面对' AND pinyin = 'miànduì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '面对'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'miànduì',
      meaning_vi = 'đối mặt, đối diện',
      example_hanzi = '遇到困难的时候，我们要勇敢乐观地面对，不能逃避退缩。',
      example_pinyin = 'Yù dào kùnnan de shíhou, wǒmen yào yǒnggǎn lèguān de miànduì, bù néng táobì tuìsuō.',
      example_vi = 'Khi gặp khó khăn, chúng ta phải dũng cảm lạc quan đối mặt, không được trốn tránh thoái lui.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '遇到困难的时候，我们要勇敢乐观地面对，不能逃避退缩。', 'Yù dào kùnnan de shíhou, wǒmen yào yǒnggǎn lèguān de miànduì, bù néng táobì tuìsuō.', 'Khi gặp khó khăn, chúng ta phải dũng cảm lạc quan đối mặt, không được trốn tránh thoái lui.', 'basic', 1),
        (v_id, '面对复杂多变的国际宏观地缘经济环境与激烈竞争，中国制造业坚定不移地加快推进高端化、智能化与绿色化转型升级。', 'Miànduì fùzá duōbiàn de guójì hóngguān dìyuán jīngjì huánjìng yǔ jīliè jìngzhēng, Zhōngguó zhìzàoyè jiāndìng-bùyí de jiākuài tuījìn gāoduānhuà, zhìnénghuà yǔ lǜsèhuà zhuǎnxíng shēngjí.', 'Đối mặt với môi trường kinh tế địa chính trị vĩ mô quốc tế phức tạp biến động và cạnh tranh gay gắt, ngành chế tạo Trung Quốc kiên định không dao động đẩy nhanh thúc đẩy chuyển đổi nâng cấp theo hướng cao cấp hóa, thông minh hóa và xanh hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [面试] (miànshì) - phỏng vấn; dự phỏng vấn [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '面试' AND pinyin = 'miànshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '面试'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'miànshì',
      meaning_vi = 'phỏng vấn; dự phỏng vấn',
      example_hanzi = '明天上午九点他将前往一家知名外企参加第二轮求职面试。',
      example_pinyin = 'Míngtiān shàngwǔ jiǔ diǎn tā jiāng qiánwǎng yì jiā zhìmíng wàiqǐ cānjiā dì-èr lún qiúzhí miànshì.',
      example_vi = '9 giờ sáng mai anh ấy sẽ đến một doanh nghiệp nước ngoài nổi tiếng để tham gia vòng phỏng vấn xin việc thứ hai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '明天上午九点他将前往一家知名外企参加第二轮求职面试。', 'Míngtiān shàngwǔ jiǔ diǎn tā jiāng qiánwǎng yì jiā zhìmíng wàiqǐ cānjiā dì-èr lún qiúzhí miànshì.', '9 giờ sáng mai anh ấy sẽ đến một doanh nghiệp nước ngoài nổi tiếng để tham gia vòng phỏng vấn xin việc thứ hai.', 'basic', 1),
        (v_id, '知名跨国科技巨头在招聘资深算法工程师时，面试考核重点不仅仅是扎实的编程能力，更极其看重跨学科系统设计架构素养。', 'Zhìmíng kuàguó kējì jùtóu zài zhāopìn zīshēn suànfǎ gōngchéngshī shí, miànshì kǎohé zhòngdiǎn bù jǐnjǐn shì zhāshi de biānchéng nénglì, gèng jíqí kànzhòng kuà-xuékē xìtǒng shèjì jiàgòu sùyǎng.', 'Gã khổng lồ công nghệ đa quốc gia nổi tiếng khi tuyển dụng kỹ sư thuật toán kỳ cựu, trọng tâm sát hạch phỏng vấn không chỉ là năng lực lập trình vững vàng mà đặc biệt coi trọng tố chất kiến trúc thiết kế hệ thống liên ngành.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [秒] (miǎo) - giây (thời gian, góc độ) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '秒' AND pinyin = 'miǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '秒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'miǎo',
      meaning_vi = 'giây (thời gian, góc độ)',
      example_hanzi = '短跑名将苏炳添在男子一百米比赛中跑出了九秒八三的亚洲奇迹纪录。',
      example_pinyin = 'Duǎnpǎo míngjiàng Sū Bǐngtiān zài nánzǐ yì bǎi mǐ bǐsài zhōng pǎo chū le jiǔ miǎo bā sān de Yàzhōu qíjì jìlù.',
      example_vi = 'Danh tướng chạy cự ly ngắn Tô Bính Thiêm trong nội dung 100 mét nam đã chạy ra kỷ lục kỳ tích châu Á 9 giây 83.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '短跑名将苏炳添在男子一百米比赛中跑出了九秒八三的亚洲奇迹纪录。', 'Duǎnpǎo míngjiàng Sū Bǐngtiān zài nánzǐ yì bǎi mǐ bǐsài zhōng pǎo chū le jiǔ miǎo bā sān de Yàzhōu qíjì jìlù.', 'Danh tướng chạy cự ly ngắn Tô Bính Thiêm trong nội dung 100 mét nam đã chạy ra kỷ lục kỳ tích châu Á 9 giây 83.', 'basic', 1),
        (v_id, '高频量化交易系统能够在几微秒甚至纳秒级别内自动完成海量金融行情解析与算法委托下单。', 'Gāopín liànghuà jiāoyì xìtǒng nénggòu zài jǐ wēimiǎo shènzhì nàmiǎo jíbié nèi zìdòng wánchéng hǎiliàng jīnróng hángqíng jiěxī yǔ suànfǎ wěituō xiàdān.', 'Hệ thống giao dịch định lượng tần suất cao có khả năng tự động hoàn thành việc phân tích diễn biến tài chính khổng lồ và đặt lệnh ủy thác thuật toán trong vài micro giây thậm chí cấp độ nano giây.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [民族] (mínzú) - dân tộc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '民族' AND pinyin = 'mínzú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '民族'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mínzú',
      meaning_vi = 'dân tộc',
      example_hanzi = '中国是一个由五十六个民族组成的团结和睦的多民族大家庭。',
      example_pinyin = 'Zhōngguó shì yí gè yóu wǔshíliù gè mínzú zǔchéng de tuánjié hémù de duō mínzú dà jiātíng.',
      example_vi = 'Trung Quốc là một đại gia đình đa dân tộc đoàn kết hòa thuận được tạo thành từ năm mươi sáu dân tộc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国是一个由五十六个民族组成的团结和睦的多民族大家庭。', 'Zhōngguó shì yí gè yóu wǔshíliù gè mínzú zǔchéng de tuánjié hémù de duō mínzú dà jiātíng.', 'Trung Quốc là một đại gia đình đa dân tộc đoàn kết hòa thuận được tạo thành từ năm mươi sáu dân tộc.', 'basic', 1),
        (v_id, '实现中华民族伟大复兴是近代以来中国人民最伟大的梦想，需要海内外中华儿女同心同德团结拼搏。', 'Shíxiàn Zhōnghuá mínzú wěidà fùxīng shì jìndài yǐlái Zhōngguó rénmín zuì wěidà de mèngxiǎng, xūyào hǎinèiwài Zhōnghuá érnǚ tóngxīn-tóngdé tuánjié pīnbó.', 'Hiện thực hóa sự phục hưng vĩ đại của dân tộc Trung Hoa là ước mơ vĩ đại nhất của nhân dân Trung Quốc từ thời cận đại đến nay, đòi hỏi con em Trung Hoa trong và ngoài nước phải đồng tâm hiệp lực đoàn kết phấn đấu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [末] (mò) - cuối, ngọn, mạt (cuối tuần, cuối kỳ, cuối năm) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '末' AND pinyin = 'mò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '末'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mò',
      meaning_vi = 'cuối, ngọn, mạt (cuối tuần, cuối kỳ, cuối năm)',
      example_hanzi = '学校定于本学期末举行全校中文演讲比赛。',
      example_pinyin = 'Xuéxiào dìng yú běn xuéqīmò jǔxíng quán xiào Zhōngwén yǎnjiǎng bǐsài.',
      example_vi = 'Nhà trường ấn định cuối học kỳ này sẽ tổ chức cuộc thi diễn thuyết tiếng Trung toàn trường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学校定于本学期末举行全校中文演讲比赛。', 'Xuéxiào dìng yú běn xuéqīmò jǔxíng quán xiào Zhōngwén yǎnjiǎng bǐsài.', 'Nhà trường ấn định cuối học kỳ này sẽ tổ chức cuộc thi diễn thuyết tiếng Trung toàn trường.', 'basic', 1),
        (v_id, '各跨国商业银行在每年第四季度末都要严格按照国际巴塞尔协议标准，开展全面细致的资产流动性压力测试。', 'Gè kuàguó shāngyè yínháng zài měi nián dì sì jīdùmò dōu yào yángé ànzhào guójì Bāsāi’ěr xiéyì biāozhǔn, kāizhǎn quánmiàn xìzhì de zīchǎn liúdòngxìng yālì cèshì.', 'Các ngân hàng thương mại đa quốc gia vào cuối quý 4 mỗi năm đều phải theo sát tiêu chuẩn Hiệp ước Basel quốc tế, triển khai kiểm tra sức ép thanh khoản tài sản một cách toàn diện tỉ mỉ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [母女] (mǔnǚ) - mẹ và con gái, mẹ con [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '母女' AND pinyin = 'mǔnǚ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '母女'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mǔnǚ',
      meaning_vi = 'mẹ và con gái, mẹ con',
      example_hanzi = '他们母女俩长得很像，笑起来的眼神特别温柔。',
      example_pinyin = 'Tāmen mǔnǚ liǎ zhǎng de hěn xiàng, xiào qǐlai de yǎnshén tèbié wēnróu.',
      example_vi = 'Hai mẹ con họ trông rất giống nhau, ánh mắt khi cười vô cùng dịu dàng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他们母女俩长得很像，笑起来的眼神特别温柔。', 'Tāmen mǔnǚ liǎ zhǎng de hěn xiàng, xiào qǐlai de yǎnshén tèbié wēnróu.', 'Hai mẹ con họ trông rất giống nhau, ánh mắt khi cười vô cùng dịu dàng.', 'basic', 1),
        (v_id, '这对医学科学家母女先后投身于热带抗疟疾特效药物的艰苦提取研究，为保障全人类公共卫生健康做出了卓越贡献。', 'Zhè duì yīxué kēxuéjiā mǔnǚ xiānhòu tóushēn yú rèdài kàng nüèjí tèxiào yàowù de jiānkǔ tíqǔ yánjiū, wèi bǎozhàng quán rénlèi gōnggòng wèishēng jiànkāng zuò chū le zhuóyuè gòngxiàn.', 'Hai mẹ con nhà khoa học y học này đã lần lượt dấn thân vào nghiên cứu chiết xuất gian khổ thuốc đặc trị sốt rét nhiệt đới, đóng góp xuất sắc cho việc bảo vệ sức khỏe y tế công cộng của toàn nhân loại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [母亲] (mǔqīn) - mẹ, người mẹ, thân mẫu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '母亲' AND pinyin = 'mǔqīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '母亲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mǔqīn',
      meaning_vi = 'mẹ, người mẹ, thân mẫu',
      example_hanzi = '每年的五月第二个星期天是母亲节，大家都向伟大的母亲表达感恩之情。',
      example_pinyin = 'Měi nián de wǔ yuè dì-èr gè xīngqītiān shì Mǔqīnjié, dàjiā dōu xiàng wěidà de mǔqīn biǎodá gǎn’ēn zhī qíng.',
      example_vi = 'Chủ nhật thứ hai của tháng Năm hàng năm là Ngày của Mẹ, mọi người đều bày tỏ lòng biết ơn tới người mẹ vĩ đại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年的五月第二个星期天是母亲节，大家都向伟大的母亲表达感恩之情。', 'Měi nián de wǔ yuè dì-èr gè xīngqītiān shì Mǔqīnjié, dàjiā dōu xiàng wěidà de mǔqīn biǎodá gǎn’ēn zhī qíng.', 'Chủ nhật thứ hai của tháng Năm hàng năm là Ngày của Mẹ, mọi người đều bày tỏ lòng biết ơn tới người mẹ vĩ đại.', 'basic', 1),
        (v_id, '黄河作为中华民族的母亲河，千百年来孕育了璀璨繁盛的古代农耕文明，更凝聚着中华儿女百折不挠的伟大民族品格。', 'Huáng Hé zuòwéi Zhōnghuá mínzú de mǔqīn hé, qiān bǎi nián lái yùnyù le cuǐcàn fánshèng de gǔdài nónggēng wénmíng, gèng níngjù zhe Zhōnghuá érnǚ bǎizhé-bùnáo de wěidà mínzú pǐngé.', 'Sông Hoàng Hà với tư cách là dòng sông mẹ của dân tộc Trung Hoa, hàng ngàn năm qua đã nuôi dưỡng nền văn minh nông canh cổ đại rực rỡ phồn thịnh, và ngưng tụ phẩm cách dân tộc vĩ đại kiên cường bất khuất của những người con Trung Hoa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [母子] (mǔzǐ) - mẹ và con trai, mẹ con [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '母子' AND pinyin = 'mǔzǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '母子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mǔzǐ',
      meaning_vi = 'mẹ và con trai, mẹ con',
      example_hanzi = '星期天下午，他们母子俩常常在小区的花园里散步晒太阳。',
      example_pinyin = 'Xīngqītiān xiàwǔ, tāmen mǔzǐ liǎ chángcháng zài xiǎoqū de huāyuán lǐ sànbù shài tàiyáng.',
      example_vi = 'Chiều Chủ nhật, hai mẹ con họ thường đi dạo sưởi nắng trong hoa viên khu chung cư.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '星期天下午，他们母子俩常常在小区的花园里散步晒太阳。', 'Xīngqītiān xiàwǔ, tāmen mǔzǐ liǎ chángcháng zài xiǎoqū de huāyuán lǐ sànbù shài tàiyáng.', 'Chiều Chủ nhật, hai mẹ con họ thường đi dạo sưởi nắng trong hoa viên khu chung cư.', 'basic', 1),
        (v_id, '母子连心，无论身在天涯海角，母亲那份深沉无私的爱始终是游子搏击风浪、勇往直前的心灵港湾。', 'Mǔ-zǐ lián xīn, wúlùn shēn zài tiānyá-hǎijiǎo, mǔqīn nà fèn shēnchén wúsī de ài shǐzhōng shì yóuzǐ bójī fēnglàng, yǒngwǎng-zhíqián de xīnlíng gǎngwān.', 'Mẹ con liền tâm, bất kể thân ở chân trời góc bể, tình yêu thương vô tư sâu sắc của mẹ luôn là bến đỗ tâm hồn để người con xa xứ vượt qua sóng gió và dũng cảm tiến về phía trước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [目标] (mùbiāo) - mục tiêu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '目标' AND pinyin = 'mùbiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '目标'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mùbiāo',
      meaning_vi = 'mục tiêu',
      example_hanzi = '新学期伊始，他为自己确立了通过HSK四级考试的明确学业目标。',
      example_pinyin = 'Xīn xuéqī yīshǐ, tā wèi zìjǐ quèlì le tōngguò HSK sìjí kǎoshì de míngquè xuéyè mùbiāo.',
      example_vi = 'Đầu học kỳ mới, cậu ấy đã xác lập cho bản thân mục tiêu học tập rõ ràng là vượt qua kỳ thi HSK 4.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '新学期伊始，他为自己确立了通过HSK四级考试的明确学业目标。', 'Xīn xuéqī yīshǐ, tā wèi zìjǐ quèlì le tōngguò HSK sìjí kǎoshì de míngquè xuéyè mùbiāo.', 'Đầu học kỳ mới, cậu ấy đã xác lập cho bản thân mục tiêu học tập rõ ràng là vượt qua kỳ thi HSK 4.', 'basic', 1),
        (v_id, '为如期实现“双碳”中长期国家战略目标，能源行业正在加速推动清洁能源替代与传统火电能效改造升级。', 'Wèi rúqī shíxiàn “shuāngtàn” zhōng-chángqī guójiā zhànlüè mùbiāo, néngyuán hángyè zhèngzài jiāsù tuīdòng qīngjié néngyuán tìdài yǔ chuántǒng huǒdiàn néngxiào gǎizào shēngjí.', 'Để đạt được mục tiêu chiến lược quốc gia trung và dài hạn về "carbon kép" đúng thời hạn, ngành năng lượng đang đẩy nhanh việc thúc đẩy thay thế năng lượng sạch và cải tạo nâng cấp hiệu suất năng lượng nhiệt điện truyền thống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [目的] (mùdì) - mục đích [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '目的' AND pinyin = 'mùdì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '目的'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mùdì',
      meaning_vi = 'mục đích',
      example_hanzi = '举办这次文化交流活动的目的是增进不同国家青年之间的相互了解与友谊。',
      example_pinyin = 'Jǔbàn zhè cì wénhuà jiāoliú huódòng de mùdì shì zēngjìn bùtóng guójiā qīngnián zhījiān de xiānghù liǎojiě yǔ yǒuyì.',
      example_vi = 'Mục đích của việc tổ chức hoạt động giao lưu văn hóa lần này là tăng cường sự hiểu biết và tình bạn lẫn nhau giữa giới trẻ các quốc gia khác nhau.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '举办这次文化交流活动的目的是增进不同国家青年之间的相互了解与友谊。', 'Jǔbàn zhè cì wénhuà jiāoliú huódòng de mùdì shì zēngjìn bùtóng guójiā qīngnián zhījiān de xiānghù liǎojiě yǔ yǒuyì.', 'Mục đích của việc tổ chức hoạt động giao lưu văn hóa lần này là tăng cường sự hiểu biết và tình bạn lẫn nhau giữa giới trẻ các quốc gia khác nhau.', 'basic', 1),
        (v_id, '跨国企业进行跨境战略投资的根本目的，在于整合全球前沿核心专利技术、优化供应链配置并开拓新兴海外消费市场。', 'Kuàguó qǐyè jìnxíng kuàjìng zhànlüè tóuzī de gēnběn mùdì, zàiyú zhěnghé quánqiú qiányán héxīn zhuānlì jìshù, yōuhuà gōngyìngliàn pèizhì bìng kāituò xīnxīng hǎiwài xiāofèi shìchǎng.', 'Mục đích căn bản của các doanh nghiệp đa quốc gia khi tiến hành đầu tư chiến lược xuyên biên giới nằm ở việc tích hợp công nghệ sáng chế cốt lõi tiên phong toàn cầu, tối ưu hóa phân bổ chuỗi cung ứng và khai phá thị trường tiêu dùng mới nổi ở nước ngoài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [目的地] (mùdìdì) - điểm đến, nơi đến [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '目的地' AND pinyin = 'mùdìdì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '目的地'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mùdìdì',
      meaning_vi = 'điểm đến, nơi đến',
      example_hanzi = '经过十个小时的漫长飞行，飞机终于平稳降落在旅行的目的地机场。',
      example_pinyin = 'Jīngguò shí gè xiǎoshí de màncháng fēixíng, fēijī zhōngyú píngwěn jiàngluò zài lǚxíng de mùdìdì jīchǎng.',
      example_vi = 'Trải qua mười tiếng bay dài dằng dặc, máy bay cuối cùng đã hạ cánh êm thuận xuống sân bay điểm đến của chuyến du lịch.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过十个小时的漫长飞行，飞机终于平稳降落在旅行的目的地机场。', 'Jīngguò shí gè xiǎoshí de màncháng fēixíng, fēijī zhōngyú píngwěn jiàngluò zài lǚxíng de mùdìdì jīchǎng.', 'Trải qua mười tiếng bay dài dằng dặc, máy bay cuối cùng đã hạ cánh êm thuận xuống sân bay điểm đến của chuyến du lịch.', 'basic', 1),
        (v_id, '凭借安全稳定的社会治安、极其丰富的世界文化遗产与现代化的基础设施，中国日益成为全球入境游客首选的理想旅游目的地。', 'Píngjiè ānquán wěndìng de shèhuì zhì’ān, jíqí fēngfù de shìjiè wénhuà yíchǎn yǔ xiàndàihuà de jīchǔ shèshī, Zhōngguó rìyì chéngwéi quánqiú rùjìng yóukè shǒuxuǎn de lǐxiǎng lǚyóu mùdìdì.', 'Nhờ vào an ninh trật tự xã hội an toàn ổn định, di sản văn hóa thế giới vô cùng phong phú cùng cơ sở hạ tầng hiện đại, Trung Quốc ngày càng trở thành điểm đến du lịch lý tưởng được lựa chọn hàng đầu của du khách quốc tế nhập cảnh toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [目前] (mùqián) - hiện tại, hiện nay, trước mắt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '目前' AND pinyin = 'mùqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '目前'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mùqián',
      meaning_vi = 'hiện tại, hiện nay, trước mắt',
      example_hanzi = '目前这项工程的第一阶段建设已经圆满完工，即将投入使用。',
      example_pinyin = 'Mùqián zhè xiàng gōngchéng de dì-yī jiēduàn jiànshè yǐjīng yuánmǎn wángōng, jíjiāng tóurù shǐyòng.',
      example_vi = 'Hiện nay công tác xây dựng giai đoạn một của công trình này đã hoàn thành viên mãn, sắp sửa đi vào sử dụng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '目前这项工程的第一阶段建设已经圆满完工，即将投入使用。', 'Mùqián zhè xiàng gōngchéng de dì-yī jiēduàn jiànshè yǐjīng yuánmǎn wángōng, jíjiāng tóurù shǐyòng.', 'Hiện nay công tác xây dựng giai đoạn một của công trình này đã hoàn thành viên mãn, sắp sửa đi vào sử dụng.', 'basic', 1),
        (v_id, '尽管目前外部全球经济增长动能有所放缓，但我国宏观经济基本面韧性强、回旋空间大，长期向好的基本趋势没有改变。', 'Jǐnguǎn mùqián wàibù quánqiú jīngjì zēngzhǎng dòngnéng yǒusuǒ fànghuǎn, dàn wǒ guó hóngguān jīngjì jīběnmiàn rènxìng qiáng, huíxuán kōngjiān dà, chángqī xiànghǎo de jīběn qūshì méiyǒu gǎibiàn.', 'Dù cho hiện tại động năng tăng trưởng kinh tế toàn cầu bên ngoài có phần chậm lại, nhưng các yếu tố cơ bản của nền kinh tế vĩ mô nước ta có sức bền bỉ lớn, dư địa linh hoạt rộng, xu thế cơ bản khởi sắc tốt đẹp lâu dài không hề thay đổi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [耐心] (nàixīn) - kiên nhẫn, nhẫn nại; lòng kiên nhẫn [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '耐心' AND pinyin = 'nàixīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '耐心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'nàixīn',
      meaning_vi = 'kiên nhẫn, nhẫn nại; lòng kiên nhẫn',
      example_hanzi = '李老师对待基础薄弱的学生总是充满极大的耐心，一遍又一遍地讲解。',
      example_pinyin = 'Lǐ lǎoshī duìdài jīchǔ bóruò de xuésheng zǒngshì chōngmǎn jídà de nàixīn, yí biàn yòu yí biàn de jiǎngjiě.',
      example_vi = 'Thầy Lý đối với những học sinh có nền tảng còn yếu luôn tràn ngập sự kiên nhẫn to lớn, giảng giải hết lần này qua lần khác.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '李老师对待基础薄弱的学生总是充满极大的耐心，一遍又一遍地讲解。', 'Lǐ lǎoshī duìdài jīchǔ bóruò de xuésheng zǒngshì chōngmǎn jídà de nàixīn, yí biàn yòu yí biàn de jiǎngjiě.', 'Thầy Lý đối với những học sinh có nền tảng còn yếu luôn tràn ngập sự kiên nhẫn to lớn, giảng giải hết lần này qua lần khác.', 'basic', 1),
        (v_id, '在突破前沿底层硬核科技研发难关的过程中，科研团队与战略资本都需要保持长远的战略定力与极大的耐心，甘坐十年冷板凳。', 'Zài tūpò qiányán dǐcéng yìhé kējì yánfā nánguān de guòchéng zhōng, kēyán tuánduì yǔ zhànlüè zīběn dōu xūyào bǎochí chángyuǎn de zhànlüè dìnglì yǔ jídà de nàixīn, gān zuò shí nián lěngbǎndèng.', 'Trong quá trình đột phá các cửa ải hóc búa của công nghệ lõi cứng tiên phong tầng dưới, đội ngũ nghiên cứu và nguồn vốn chiến lược đều cần giữ vững định lực chiến lược lâu dài và lòng kiên nhẫn tột cùng, sẵn sàng chịu đựng mười năm miệt mài âm thầm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [南部] (nánbù) - phía nam, miền nam, phần phía nam [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '南部' AND pinyin = 'nánbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '南部'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nánbù',
      meaning_vi = 'phía nam, miền nam, phần phía nam',
      example_hanzi = '中国南部沿海地区冬季气候温暖湿润，是很多北方人避寒过冬的胜地。',
      example_pinyin = 'Zhōngguó nánbù yánhǎi dìqū dōngjì qìhòu wēnnuǎn shīrùn, shì hěn duō běifāngrén bìhán guò dōng de shèngdì.',
      example_vi = 'Khu vực ven biển phía nam Trung Quốc vào mùa đông khí hậu ấm áp ẩm ướt, là điểm đến lý tưởng để nhiều người phương bắc tránh rét qua đông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国南部沿海地区冬季气候温暖湿润，是很多北方人避寒过冬的胜地。', 'Zhōngguó nánbù yánhǎi dìqū dōngjì qìhòu wēnnuǎn shīrùn, shì hěn duō běifāngrén bìhán guò dōng de shèngdì.', 'Khu vực ven biển phía nam Trung Quốc vào mùa đông khí hậu ấm áp ẩm ướt, là điểm đến lý tưởng để nhiều người phương bắc tránh rét qua đông.', 'basic', 1),
        (v_id, '随着国家粤港澳大湾区重大战略的深入推进，我国南部沿海城市群正在加速构建具有全球影响力的现代化世界级科技创新枢纽。', 'Suízhe guójiā Yuè-Gǎng-Ào Dàwānqū zhòngdà zhànlüè de shēnrù tuījìn, wǒ guó nánbù yánhǎi chéngshìqún zhèngzài jiāsù gòujiàn jùyǒu quánqiú yǐngxiǎnglì de xiàndàihuà shìjièjí kējì chuàngxīn shūniǔ.', 'Cùng với việc triển khai sâu rộng chiến lược trọng đại Vùng Vịnh Lớn Quảng Đông - Hồng Kông - Ma Cao của quốc gia, cụm đô thị ven biển phía nam nước ta đang đẩy nhanh kiến tạo đầu mối đổi mới khoa học công nghệ cấp thế giới hiện đại có tầm ảnh hưởng toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [难道] (nándào) - chẳng lẽ, há lẽ (dùng trong câu phản vấn) [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '难道' AND pinyin = 'nándào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '难道'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'nándào',
      meaning_vi = 'chẳng lẽ, há lẽ (dùng trong câu phản vấn)',
      example_hanzi = '外面雨下得这么大，难道你今天还要坚持出门踢球吗？',
      example_pinyin = 'Wàimiàn yǔ xià de zhème dà, nándào nǐ jīntiān hái yào jiānchí chūmén tī qiú ma?',
      example_vi = 'Bên ngoài mưa rơi to như thế này, chẳng lẽ hôm nay bạn vẫn khăng khăng đòi ra ngoài đá bóng sao?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '外面雨下得这么大，难道你今天还要坚持出门踢球吗？', 'Wàimiàn yǔ xià de zhème dà, nándào nǐ jīntiān hái yào jiānchí chūmén tī qiú ma?', 'Bên ngoài mưa rơi to như thế này, chẳng lẽ hôm nay bạn vẫn khăng khăng đòi ra ngoài đá bóng sao?', 'basic', 1),
        (v_id, '在事实铁证与严谨财务审计核查数据面前，难道涉案机构还能继续编造谎言百般抵赖其违规操纵证券市场的行为吗？', 'Zài shìshí tiězhèng yǔ yánjǐn cáiwù shěnjì héchá shùjù miànqián, nándào shè’àn jīgòu hái néng jìxù biānzào huǎngyán bǎibān dǐlài qí wéiguī cāozòng zhèngquàn shìchǎng de xíngwéi ma?', 'Trước chứng cứ sắt đá của sự thật và các số liệu kiểm toán tài chính chặt chẽ, chẳng lẽ tổ chức liên quan tới vụ án còn có thể tiếp tục thêu dệt dối trá tìm trăm phương ngàn kế chối bỏ hành vi thao túng thị trường chứng khoán trái quy định của mình sao?', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [男士] (nánshì) - nam giới, quý ông, đàn ông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '男士' AND pinyin = 'nánshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '男士'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nánshì',
      meaning_vi = 'nam giới, quý ông, đàn ông',
      example_hanzi = '这家商场的三楼专门销售高端品牌的男士商务正装与皮鞋。',
      example_pinyin = 'Zhè jiā shāngchǎng de sān lóu zhuānmén xiāoshòu gāoduān pǐnpái de nánshì shāngwù zhèngzhuāng yǔ píxié.',
      example_vi = 'Tầng 3 của trung tâm thương mại này chuyên bán âu phục thương mại và giày da nam của các thương hiệu cao cấp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家商场的三楼专门销售高端品牌的男士商务正装与皮鞋。', 'Zhè jiā shāngchǎng de sān lóu zhuānmén xiāoshòu gāoduān pǐnpái de nánshì shāngwù zhèngzhuāng yǔ píxié.', 'Tầng 3 của trung tâm thương mại này chuyên bán âu phục thương mại và giày da nam của các thương hiệu cao cấp.', 'basic', 1),
        (v_id, '当代男士护肤与个人形象护理消费市场呈现快速扩张态势，高品质、专业定制的个人形象产品深受都市年轻职场男士的青睐。', 'Dāngdài nánshì hùfū yǔ gèrén xíngxiàng hùlǐ xiāofèi shìchǎng chéngxiàn kuàisù kuòzhāng tàishì, gāo pǐnzhì, zhuānyè dìngzhì de gèrén xíngxiàng chǎnpǐn shēn shòu dūshì niánqīng zhíchǎng nánshì de qīnglài.', 'Thị trường tiêu dùng chăm sóc da và diện mạo cá nhân của nam giới đương đại đang thể hiện xu thế mở rộng nhanh chóng, các dòng sản phẩm chăm sóc diện mạo cá nhân chất lượng cao và tùy chỉnh chuyên nghiệp rất được nam giới trẻ nơi công sở đô thị ưa chuộng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [难受] (nánshòu) - khó chịu, đau đớn, bức bối; buồn lòng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '难受' AND pinyin = 'nánshòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '难受'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'nánshòu',
      meaning_vi = 'khó chịu, đau đớn, bức bối; buồn lòng',
      example_hanzi = '他感冒发烧了，浑身酸痛，嗓子也特别难受。',
      example_pinyin = 'Tā gǎnmào fāshāo le, húnshēn suāntòng, sǎngzi yě tèbié nánshòu.',
      example_vi = 'Cậu ấy bị cảm sốt rồi, khắp người đau nhức, cổ họng cũng vô cùng khó chịu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他感冒发烧了，浑身酸痛，嗓子也特别难受。', 'Tā gǎnmào fāshāo le, húnshēn suāntòng, sǎngzi yě tèbié nánshòu.', 'Cậu ấy bị cảm sốt rồi, khắp người đau nhức, cổ họng cũng vô cùng khó chịu.', 'basic', 1),
        (v_id, '看到倾注了团队整整三年心血与研发经费的试验样机因意外故障受损，在场的所有工程师心里都无比难受。', 'Kàn dào qīngzhù le tuánduì zhěngzhěng sān nián xīnxuè yǔ yánfā jīngfèi de shìyàn yàngjī yīn yìwài gùzhàng shòusǔn, zàichǎng de suǒyǒu gōngchéngshī xīn lǐ dōu wúbǐ nánshòu.', 'Nhìn cỗ máy thử nghiệm đã dồn trọn vẹn ba năm tâm huyết và kinh phí R&D của đội ngũ bị hư hại do sự cố ngoài ý muốn, tất cả các kỹ sư có mặt tại hiện trường trong lòng đều vô cùng buồn đau nhức nhối.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [难忘] (nánwàng) - khó quên, đáng nhớ, không thể nào quên [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '难忘' AND pinyin = 'nánwàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '难忘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'nánwàng',
      meaning_vi = 'khó quên, đáng nhớ, không thể nào quên',
      example_hanzi = '这次在中国度过的难忘寒假，让我深深爱上了博大精深的中华文化。',
      example_pinyin = 'Zhè cì zài Zhōngguó dùguò de nánwàng hánjià, ràng wǒ shēnshēn ài shàng le bódà-jīngshēn de Zhōnghuá wénhuà.',
      example_vi = 'Kỳ nghỉ đông khó quên trải qua ở Trung Quốc lần này đã khiến tôi say mê sâu sắc nền văn hóa Trung Hoa bác đại tinh thâm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这次在中国度过的难忘寒假，让我深深爱上了博大精深的中华文化。', 'Zhè cì zài Zhōngguó dùguò de nánwàng hánjià, ràng wǒ shēnshēn ài shàng le bódà-jīngshēn de Zhōnghuá wénhuà.', 'Kỳ nghỉ đông khó quên trải qua ở Trung Quốc lần này đã khiến tôi say mê sâu sắc nền văn hóa Trung Hoa bác đại tinh thâm.', 'basic', 1),
        (v_id, '奥运健儿在世界体坛赛场上顽强拼搏、绝地反击并最终登上最高领奖台的激动瞬间，成为了载入史册并令亿万观众永生难忘的经典画面。', 'Àoyùn jiàn’ér zài shìjiè tǐtán sàichǎng shang wánqiáng pīnbó, juédì fǎnjī bìng zuìzhōng dēng shàng zuì gāo lǐngjiǎngtái de jīdòng shūnjiān, chéngwéi le zǎi rù shǐcè bìng lìng yìwàn guānzhòng yǒngshēng-nánwàng de jīngdiǎn huàmiàn.', 'Khoảnh khắc xúc động khi các tuyển thủ Olympic ngoan cường chiến đấu, lội ngược dòng từ hiểm cảnh và cuối cùng bước lên bục vinh quang cao nhất trên đấu trường thể thao thế giới đã trở thành thước phim kinh điển ghi vào sử sách và khiến hàng trăm triệu khán giả suốt đời không thể nào quên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [男性] (nánxìng) - nam giới, phái nam [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '男性' AND pinyin = 'nánxìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '男性'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nánxìng',
      meaning_vi = 'nam giới, phái nam',
      example_hanzi = '医生建议中年男性平时要适度参加体育锻炼，预防心脑血管疾病。',
      example_pinyin = 'Yīshēng jiànyì zhōngnián nánxìng píngshí yào shìdù cānjiā tǐyù duànliàn, yùfáng xīn-nǎoxièguǎn jíbìng.',
      example_vi = 'Bác sĩ khuyến nghị nam giới tuổi trung niên ngày thường nên tham gia rèn luyện thể dục thể thao điều độ để phòng ngừa các bệnh tim mạch và mạch máu não.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '医生建议中年男性平时要适度参加体育锻炼，预防心脑血管疾病。', 'Yīshēng jiànyì zhōngnián nánxìng píngshí yào shìdù cānjiā tǐyù duànliàn, yùfáng xīn-nǎoxièguǎn jíbìng.', 'Bác sĩ khuyến nghị nam giới tuổi trung niên ngày thường nên tham gia rèn luyện thể dục thể thao điều độ để phòng ngừa các bệnh tim mạch và mạch máu não.', 'basic', 1),
        (v_id, '随着社会文明的进步与育儿观念的革新，越来越多的年轻职场男性主动休陪产假并积极分担家庭育儿照料责任。', 'Suízhe shèhuì wénmíng de jìnbù yǔ yù’ér guānniàn de géxīn, yuèláiyuè duō de niánqīng zhíchǎng nánxìng zhǔdòng xiū péichǎnjià bìng jījí fēndān jiātíng yù’ér zhàoliào zérèn.', 'Cùng với sự tiến bộ của văn minh xã hội và đổi mới quan niệm nuôi dạy con, ngày càng nhiều nam giới trẻ chốn công sở chủ động nghỉ phép chăm vợ sinh và tích cực san sẻ trách nhiệm chăm nom con cái trong gia đình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [内] (nèi) - trong, bên trong, nội bộ, trong vòng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '内' AND pinyin = 'nèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '内'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nèi',
      meaning_vi = 'trong, bên trong, nội bộ, trong vòng',
      example_hanzi = '请大家在二十分钟内认真完成这份中文随堂测验试卷。',
      example_pinyin = 'Qǐng dàjiā zài èrshí fēnzhōng nèi rènzhēn wánchéng zhè fèn Zhōngwén suítáng cèyàn shìjuàn.',
      example_vi = 'Xin mời mọi người trong vòng 20 phút hoàn thành nghiêm túc đề kiểm tra tại lớp môn tiếng Trung này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请大家在二十分钟内认真完成这份中文随堂测验试卷。', 'Qǐng dàjiā zài èrshí fēnzhōng nèi rènzhēn wánchéng zhè fèn Zhōngwén suítáng cèyàn shìjuàn.', 'Xin mời mọi người trong vòng 20 phút hoàn thành nghiêm túc đề kiểm tra tại lớp môn tiếng Trung này.', 'basic', 1),
        (v_id, '企业内部审计合规委员会应在三十个工作日内对举报反映的违规招标行为展开全面独立调查并出具专项核查报告。', 'Qǐyè nèibù shěnjì héguī wěiyuánhuì yīng zài sānshí gè gōngzuòrì nèi duì jǔbào fǎnyìng de wéiguī zhāobiāo xíngwéi zhǎnkāi quánmiàn dúlì diàochá bìng chūjù zhuānxiàng héchá bàogào.', 'Ủy ban kiểm toán nội bộ tuân thủ của doanh nghiệp cần trong vòng 30 ngày làm việc triển khai điều tra độc lập toàn diện đối với hành vi đấu thầu vi phạm quy định do người tố cáo phản ánh và xuất trình báo cáo thẩm tra chuyên đề.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [内容] (nèiróng) - nội dung [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '内容' AND pinyin = 'nèiróng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '内容'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nèiróng',
      meaning_vi = 'nội dung',
      example_hanzi = '这本中文小说的故事情节非常吸引人，内容极其丰富生动。',
      example_pinyin = 'Zhè běn Zhōngwén xiǎoshuō de gùshì qíngjié fēicháng xīyǐn rén, nèiróng jíqí fēngfù shēngdòng.',
      example_vi = 'Tình tiết câu chuyện của cuốn tiểu thuyết tiếng Trung này rất lôi cuốn, nội dung vô cùng phong phú và sinh động.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这本中文小说的故事情节非常吸引人，内容极其丰富生动。', 'Zhè běn Zhōngwén xiǎoshuō de gùshì qíngjié fēicháng xīyǐn rén, nèiróng jíqí fēngfù shēngdòng.', 'Tình tiết câu chuyện của cuốn tiểu thuyết tiếng Trung này rất lôi cuốn, nội dung vô cùng phong phú và sinh động.', 'basic', 1),
        (v_id, '在互联网内容产业蓬勃发展的当下，只有深耕优质原创与高知识密度的深度内容，才能在海量信息洪流中铸就不可替代的核心竞争力。', 'Zài hùliánwǎng nèiróng chǎnyè péngbó fāzhǎn de dāngxià, zhǐyǒu shēngēng yōuzhì yuánchuàng yǔ gāo zhīshi mìdù de shēndù nèiróng, cái néng zài hǎiliàng xìnxī hóngliú zhōng zhù jiù bùkě-tìdài de héxīn jìngzhēnglì.', 'Giữa thời điểm ngành công nghiệp nội dung internet phát triển bừng bừng hiện nay, chỉ có đào sâu sáng tạo nội dung gốc chất lượng cao và có mật độ tri thức sâu sắc, mới có thể đúc nên sức cạnh tranh cốt lõi không thể thay thế giữa dòng thác thông tin khổng lồ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [内心] (nèixīn) - nội tâm, đáy lòng, tâm can [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '内心' AND pinyin = 'nèixīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '内心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nèixīn',
      meaning_vi = 'nội tâm, đáy lòng, tâm can',
      example_hanzi = '虽然他表面上看起来很平静，但其实内心十分激动紧张。',
      example_pinyin = 'Suīrán tā biǎomiàn shang kàn qǐlai hěn píngjìng, dàn qíshí nèixīn shífēn jīdòng jǐnzhāng.',
      example_vi = 'Tuy rằng trên bề mặt trông anh ấy rất bình tĩnh, nhưng thực chất trong lòng vô cùng xúc động và căng thẳng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '虽然他表面上看起来很平静，但其实内心十分激动紧张。', 'Suīrán tā biǎomiàn shang kàn qǐlai hěn píngjìng, dàn qíshí nèixīn shífēn jīdòng jǐnzhāng.', 'Tuy rằng trên bề mặt trông anh ấy rất bình tĩnh, nhưng thực chất trong lòng vô cùng xúc động và căng thẳng.', 'basic', 1),
        (v_id, '在遭遇外部剧烈变局与人生重重逆境时，拥有强大的内心世界与坚定的信念定力，是战胜一切艰难险阻的精神支柱。', 'Zài zāoyù wàibù jùliè biànjú yǔ rénshēng chóngchóng nìjìng shí, yōngyǒu qiángdà de nèixīn shìjiè yǔ jiāndìng de xìnniàn dìnglì, shì zhànshèng yíqiè jiānnán-xiǎnzǔ de jīngshén zhīzhù.', 'Khi gặp phải những biến cục dữ dội từ bên ngoài và muôn trùng nghịch cảnh cuộc đời, việc sở hữu một thế giới nội tâm vững vàng cùng định lực niềm tin kiên định chính là trụ cột tinh thần để đánh bại mọi gian nan trắc trở hiểm nguy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [能否] (néng fǒu) - liệu có thể hay không, có thể... không [Cụm trợ từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '能否' AND pinyin = 'néng fǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '能否'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Cụm trợ từ / Phó từ',
      pinyin = 'néng fǒu',
      meaning_vi = 'liệu có thể hay không, có thể... không',
      example_hanzi = '请问李经理，能否把明天下午的会议改到后天上午举行？',
      example_pinyin = 'Qǐngwèn Lǐ jīnglǐ, néng fǒu bǎ míngtiān xiàwǔ de huìyì gǎi dào hòutiān shàngwǔ jǔxíng?',
      example_vi = 'Xin hỏi giám đốc Lý, liệu có thể đổi buổi họp chiều mai sang sáng ngày kia tổ chức được không?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请问李经理，能否把明天下午的会议改到后天上午举行？', 'Qǐngwèn Lǐ jīnglǐ, néng fǒu bǎ míngtiān xiàwǔ de huìyì gǎi dào hòutiān shàngwǔ jǔxíng?', 'Xin hỏi giám đốc Lý, liệu có thể đổi buổi họp chiều mai sang sáng ngày kia tổ chức được không?', 'basic', 1),
        (v_id, '在全球新一轮科技革命中，我国能否牢牢把握人工智能发展主动权，关键取决于我们在基础芯片与核心算法领域的技术突破。', 'Zài quánqiú xīn yì lún kējì gémìng zhōng, wǒ guó néng fǒu láoláo bǎwò réngōng zhìnéng fāzhǎn zhǔdòngquán, guānjiàn qǔjué yú wǒmen zài jīchǔ xīnpiàn yǔ héxīn suànfǎ lǐngyù de jìshù tūpò.', 'Trong làn sóng cách mạng khoa học công nghệ mới trên toàn cầu, nước ta liệu có thể nắm vững chắc quyền chủ động phát triển trí tuệ nhân tạo hay không, mấu chốt phụ thuộc vào những bước đột phá công nghệ của chúng ta trong lĩnh vực chip cơ sở và thuật toán cốt lõi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [能够] (nénggòu) - có thể, có khả năng [Động từ năng nguyện]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '能够' AND pinyin = 'nénggòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '能够'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ năng nguyện',
      pinyin = 'nénggòu',
      meaning_vi = 'có thể, có khả năng',
      example_hanzi = '只要坚持每天多听多练，你一定能够顺利通过中文考试。',
      example_pinyin = 'Zhǐyào jiānchí měitiān duō tīng duō liàn, nǐ yídìng nénggòu shùnlì tōngguò Zhōngwén kǎoshì.',
      example_vi = 'Chỉ cần kiên trì mỗi ngày nghe nhiều luyện nhiều, bạn nhất định có thể thuận lợi vượt qua kỳ thi tiếng Trung.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '只要坚持每天多听多练，你一定能够顺利通过中文考试。', 'Zhǐyào jiānchí měitiān duō tīng duō liàn, nǐ yídìng nénggòu shùnlì tōngguò Zhōngwén kǎoshì.', 'Chỉ cần kiên trì mỗi ngày nghe nhiều luyện nhiều, bạn nhất định có thể thuận lợi vượt qua kỳ thi tiếng Trung.', 'basic', 1),
        (v_id, '具备深厚跨学科底蕴与敏捷创新思维的复合型人才，能够在大数据与人工智能深度融合的复杂工程体系中快速破局。', 'Jùbèi shēnhòu kuà-xuékē dǐyùn yǔ mǐnjié chuàngxīn sīwéi de fùhéxíng réncái, nénggòu zài dàshùjù yǔ réngōng zhìnéng shēndù rónghé de fùzá gōngchéng tǐxì zhōng kuàisù pòjú.', 'Nhân tài phức hợp sở hữu nền tảng liên ngành sâu sắc và tư duy đổi mới nhanh nhạy, có thể nhanh chóng mở ra cục diện mới trong hệ thống công trình phức tạp kết hợp sâu sắc giữa dữ liệu lớn và trí tuệ nhân tạo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [能力] (nénglì) - năng lực, khả năng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '能力' AND pinyin = 'nénglì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '能力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nénglì',
      meaning_vi = 'năng lực, khả năng',
      example_hanzi = '他在大学期间积极参与学生会社团活动，组织协调能力得到了极大提升。',
      example_pinyin = 'Tā zài dàxué qījiān jījí cānyù xuéshenghuì shètuán huódòng, zǔzhī xiétóng nénglì dédào le jídà tíshēng.',
      example_vi = 'Trong thời gian học đại học anh ấy tích cực tham gia các hoạt động hội sinh viên câu lạc bộ, năng lực tổ chức điều phối đã được nâng cao đáng kể.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在大学期间积极参与学生会社团活动，组织协调能力得到了极大提升。', 'Tā zài dàxué qījiān jījí cānyù xuéshenghuì shètuán huódòng, zǔzhī xiétóng nénglì dédào le jídà tíshēng.', 'Trong thời gian học đại học anh ấy tích cực tham gia các hoạt động hội sinh viên câu lạc bộ, năng lực tổ chức điều phối đã được nâng cao đáng kể.', 'basic', 1),
        (v_id, '在全球供应链动荡重构的宏观背景下，增强自主创新能力与产业链抗风险韧性是保障国家经济安全的核心支撑。', 'Zài quánqiú gōngyìngliàn dòngdàng chónggòu de hóngguān bèijǐng xià, zēngqiáng zìzhǔ chuàngxīn nénglì yǔ chǎnyèliàn kàng-fēngxiǎn rènxìng shì bǎozhàng guójiā jīngjì ānquán de héxīn zhīchēng.', 'Dưới bối cảnh vĩ mô tái cấu trúc đầy biến động của chuỗi cung ứng toàn cầu, việc tăng cường năng lực đổi mới độc lập và sức bền chống chịu rủi ro của chuỗi ngành nghề là điểm tựa cốt lõi để bảo đảm an ninh kinh tế quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [嗯] (ǹg) - ừ, vâng (thán từ đồng ý, đáp lời) [Thán từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '嗯' AND pinyin = 'ǹg'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '嗯'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Thán từ',
      pinyin = 'ǹg',
      meaning_vi = 'ừ, vâng (thán từ đồng ý, đáp lời)',
      example_hanzi = '“你今天下午有空一起去图书馆吗？”“嗯，好的，那我们两点见。”',
      example_pinyin = '“Nǐ jīntiān xiàwǔ yǒu kòng yìqǐ qù túshūguǎn ma?” “Ǹg, hǎo de, nà wǒmen liǎng diǎn jiàn.”',
      example_vi = '"Chiều nay bạn có rảnh cùng đi thư viện không?" "Ừ, được thôi, vậy hai giờ chúng mình gặp nhau nhé."'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '“你今天下午有空一起去图书馆吗？”“嗯，好的，那我们两点见。”', '“Nǐ jīntiān xiàwǔ yǒu kòng yìqǐ qù túshūguǎn ma?” “Ǹg, hǎo de, nà wǒmen liǎng diǎn jiàn.”', '"Chiều nay bạn có rảnh cùng đi thư viện không?" "Ừ, được thôi, vậy hai giờ chúng mình gặp nhau nhé."', 'basic', 1),
        (v_id, '“关于这个技术方案的修改细节，你都记清楚了吗？”“嗯，我已经全部记在备忘录里了，散会后立刻执行。”', '“Guānyú zhè gè jìshù fāng’àn de xiūgǎi xìjié, nǐ dōu jì qīngchu le ma?” “Ǹg, wǒ yǐjīng quánbù jì zài bèiwànglù lǐ le, sànhuì hòu lìkè zhíxíng.”', '"Về các chi tiết sửa đổi của phương án kỹ thuật này, bạn đã ghi nhớ rõ ràng hết chưa?" "Vâng, tôi đã ghi lại toàn bộ vào sổ tay ghi nhớ rồi, tan họp sẽ lập tức thực thi ngay."', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [年底] (niándǐ) - cuối năm, dịp cuối năm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '年底' AND pinyin = 'niándǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '年底'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'niándǐ',
      meaning_vi = 'cuối năm, dịp cuối năm',
      example_hanzi = '每年年底各个公司都会给辛勤工作的优秀员工发放年终奖。',
      example_pinyin = 'Měi nián niándǐ gègè gōngsī dōu huì gěi xīnqín gōngzuò de yōuxiù yuángōng fāfàng niánzhōngjiǎng.',
      example_vi = 'Dịp cuối năm hàng năm các công ty đều sẽ phát tiền thưởng cuối năm cho những nhân viên xuất sắc đã làm việc chăm chỉ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年年底各个公司都会给辛勤工作的优秀员工发放年终奖。', 'Měi nián niándǐ gègè gōngsī dōu huì gěi xīnqín gōngzuò de yōuxiù yuángōng fāfàng niánzhōngjiǎng.', 'Dịp cuối năm hàng năm các công ty đều sẽ phát tiền thưởng cuối năm cho những nhân viên xuất sắc đã làm việc chăm chỉ.', 'basic', 1),
        (v_id, '财务部正紧锣密鼓地开展年底资产清查与财务报表决算审计，为集团管理层制定新年战略提供精准的数据依据。', 'Cáiwùbù zhèng jǐnluó-mìgǔ de kāizhǎn niándǐ zīchǎn qīngchá yǔ cáiwù bàobiǎo juésuàn shěnjì, wèi jítuán guǎnlǐcéng zhìdìng xīn nián zhànlüè tígōng jīngzhǔn de shùjù yījù.', 'Phòng tài chính đang khẩn trương ráo riết triển khai công tác kiểm kê tài sản cuối năm và kiểm toán quyết toán báo cáo tài chính, cung cấp căn cứ số liệu chuẩn xác cho ban quản lý tập đoàn lập chiến lược năm mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [年龄] (niánlíng) - tuổi tác, lứa tuổi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '年龄' AND pinyin = 'niánlíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '年龄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'niánlíng',
      meaning_vi = 'tuổi tác, lứa tuổi',
      example_hanzi = '学习任何知识和技能，只要有恒心，什么时候都不受年龄的限制。',
      example_pinyin = 'Xuéxí rènhé zhīshi hé jìnéng, zhǐyào yǒu héngxīn, shénme shíhou dōu bú shòu niánlíng de xiànzhì.',
      example_vi = 'Học tập bất kỳ kiến thức hay kỹ năng nào, chỉ cần có lòng kiên trì thì bất cứ lúc nào cũng không bị hạn chế bởi tuổi tác.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学习任何知识和技能，只要有恒心，什么时候都不受年龄的限制。', 'Xuéxí rènhé zhīshi hé jìnéng, zhǐyào yǒu héngxīn, shénme shíhou dōu bú shòu niánlíng de xiànzhì.', 'Học tập bất kỳ kiến thức hay kỹ năng nào, chỉ cần có lòng kiên trì thì bất cứ lúc nào cũng không bị hạn chế bởi tuổi tác.', 'basic', 1),
        (v_id, '在招聘选拔核心科研领军人才时，应当坚决打破唯学历、唯资历、唯年龄的传统用人桎梏，坚持唯才是举。', 'Zài zhāopìn xuǎnbá héxīn kēyán lǐngjūn réncái shí, yīngdāng jiānjué dǎpò wéi xuélì, wéi zīlì, wéi niánlíng de chuántǒng yòngrén zhìgù, jiānchí wéicái-shìjǔ.', 'Khi tuyển dụng tuyển chọn nhân tài đầu ngành nghiên cứu khoa học cốt lõi, cần kiên quyết phá bỏ gông cùm dùng người truyền thống chỉ chăm chăm nhìn vào bằng cấp, thâm niên và tuổi tác, kiên trì tiêu chí chỉ chọn người có tài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [农村] (nóngcūn) - nông thôn, vùng quê [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '农村' AND pinyin = 'nóngcūn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '农村'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nóngcūn',
      meaning_vi = 'nông thôn, vùng quê',
      example_hanzi = '农村的空气格外清新，夜晚还能看见满天的繁星。',
      example_pinyin = 'Nóngcūn de kōngqì géwài qīngxīn, yèwǎn hái néng kànjiàn mǎntiān de fánxīng.',
      example_vi = 'Không khí ở nông thôn trong lành khác lạ, ban đêm còn có thể ngắm nhìn bầu trời đầy sao lấp lánh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '农村的空气格外清新，夜晚还能看见满天的繁星。', 'Nóngcūn de kōngqì géwài qīngxīn, yèwǎn hái néng kànjiàn mǎntiān de fánxīng.', 'Không khí ở nông thôn trong lành khác lạ, ban đêm còn có thể ngắm nhìn bầu trời đầy sao lấp lánh.', 'basic', 1),
        (v_id, '全面推进乡村振兴战略要求加快建设宜居宜业和美乡村，推动优质医疗教育公共资源向农村基层下沉延伸。', 'Quánmiàn tuījìn xiāngcūn zhènxīng zhànlüè yāoqiú jiākuài jiànshè yíjū-yíyè héměi xiāngcūn, tuīdòng yōuzhì yīliáo jiàoyù gōnggòng zīyuán xiàng nóngcūn jīcéng xiàchén yánshēn.', 'Đẩy mạnh toàn diện chiến lược chấn hưng nông thôn đòi hỏi phải đẩy nhanh việc xây dựng các làng quê hài hòa tươi đẹp thích hợp để an cư lạc nghiệp, thúc đẩy nguồn lực công về y tế giáo dục chất lượng cao hướng về cơ sở nông thôn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [弄] (nòng) - làm, xử lý; kiếm, làm cho (bẩn, hỏng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '弄' AND pinyin = 'nòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '弄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'nòng',
      meaning_vi = 'làm, xử lý; kiếm, làm cho (bẩn, hỏng)',
      example_hanzi = '他不小心把刚买的新衬衫弄脏了一大块。',
      example_pinyin = 'Tā bù xiǎoxīn bǎ gāng mǎi de xīn chènshān nòng zāng le yí dà kuài.',
      example_vi = 'Anh ấy sơ ý làm bẩn một mảng lớn trên chiếc áo sơ mi mới mua.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他不小心把刚买的新衬衫弄脏了一大块。', 'Tā bù xiǎoxīn bǎ gāng mǎi de xīn chènshān nòng zāng le yí dà kuài.', 'Anh ấy sơ ý làm bẩn một mảng lớn trên chiếc áo sơ mi mới mua.', 'basic', 1),
        (v_id, '在推进重大工程项目落地实施之前，技术团队必须先把所有底层架构的逻辑关系弄清楚、弄明白。', 'Zài tuījìn zhòngdà gōngchéng xiàngmù luòdì shíshī zhīqián, jìshù tuánduì bìxū xiān bǎ suǒyǒu dǐcéng jiàgòu de luóji guānxì nòng qīngchu, nòng míngbai.', 'Trước khi thúc đẩy việc đưa dự án công trình trọng điểm đi vào thực tế triển khai, đội ngũ kỹ thuật bắt buộc phải làm cho rõ ràng rành mạch tất cả các mối quan hệ logic của kiến trúc tầng đáy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [女性] (nǚxìng) - nữ giới, phái nữ, phụ nữ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '女性' AND pinyin = 'nǚxìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '女性'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nǚxìng',
      meaning_vi = 'nữ giới, phái nữ, phụ nữ',
      example_hanzi = '现代女性在职场中展现出越来越出色的独立自主与专业才华。',
      example_pinyin = 'Xiàndài nǚxìng zài zhíchǎng zhōng zhǎnxiàn chū yuèláiyuè chūsè de dúlì-zìzhǔ yǔ zhuānyè cáihuá.',
      example_vi = 'Phụ nữ hiện đại nơi chốn công sở thể hiện sự độc lập tự chủ và tài năng chuyên môn ngày càng xuất chúng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '现代女性在职场中展现出越来越出色的独立自主与专业才华。', 'Xiàndài nǚxìng zài zhíchǎng zhōng zhǎnxiàn chū yuèláiyuè chūsè de dúlì-zìzhǔ yǔ zhuānyè cáihuá.', 'Phụ nữ hiện đại nơi chốn công sở thể hiện sự độc lập tự chủ và tài năng chuyên môn ngày càng xuất chúng.', 'basic', 1),
        (v_id, '支持女性科研人员在科技创新中挑大梁、当主角，是激发全社会创新活力与推动科技进步的重要举措。', 'Zhīchí nǚxìng kēyán rényuán zài kējì chuàngxīn zhōng tiāo dàliáng, dāng zhǔjué, shì jīfā quán shèhuì chuàngxīn huólì yǔ tuīdòng kējì jìnbù de zhòngyào jǔcuò.', 'Ủng hộ các nữ cán bộ nghiên cứu gánh vác rường cột, đóng vai trò chủ chốt trong đổi mới khoa học công nghệ chính là giải pháp quan trọng để khơi dậy sức sống đổi mới toàn xã hội và thúc đẩy tiến bộ khoa học công nghệ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [暖和] (nuǎnhuo) - ấm áp; làm ấm [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '暖和' AND pinyin = 'nuǎnhuo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '暖和'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'nuǎnhuo',
      meaning_vi = 'ấm áp; làm ấm',
      example_hanzi = '冬天的房间里开着暖气，一进门就感觉特别暖和舒适。',
      example_pinyin = 'Dōngtiān de fángjiān lǐ kāi zhe nuǎnqì, yí jìnmén jiù gǎnjué tèbié nuǎnhuo shūshì.',
      example_vi = 'Trong phòng vào mùa đông có bật lò sưởi, vừa bước vào cửa đã cảm thấy vô cùng ấm áp dễ chịu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '冬天的房间里开着暖气，一进门就感觉特别暖和舒适。', 'Dōngtiān de fángjiān lǐ kāi zhe nuǎnqì, yí jìnmén jiù gǎnjué tèbié nuǎnhuo shūshì.', 'Trong phòng vào mùa đông có bật lò sưởi, vừa bước vào cửa đã cảm thấy vô cùng ấm áp dễ chịu.', 'basic', 1),
        (v_id, '随着初春气温逐渐回升转暖和，全国冬小麦主产区全面拉开了春季田间水肥田间管理的农忙序幕。', 'Suízhe chūchūn qìwēn zhújiàn huíshēng zhuǎn nuǎnhuo, quánguó dōngxiàomài zhǔchǎnqū quánmiàn lākāi le chūnjì tiánjiān shuǐ-féi tiánjiān guǎnlǐ de nóngmáng xùmù.', 'Cùng với việc nhiệt độ đầu xuân dần ấm áp trở lại, các vùng sản xuất lúa mì mùa đông chủ yếu trên toàn quốc đã đồng loạt mở màn đợt bận rộn vụ mùa quản lý phân nước trên đồng ruộng mùa xuân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [偶尔] (ǒu’ěr) - thỉnh thoảng, đôi khi [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '偶尔' AND pinyin = 'ǒu’ěr'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '偶尔'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'ǒu’ěr',
      meaning_vi = 'thỉnh thoảng, đôi khi',
      example_hanzi = '他平时工作虽然非常忙碌，但周末偶尔也会约朋友去郊外钓鱼。',
      example_pinyin = 'Tā píngshí gōngzuò suīrán fēicháng mánglù, dàn zhōumò ǒu’ěr yě huì yuē péngyou qù jiāowài diàoyú.',
      example_vi = 'Ngày thường công việc của anh ấy tuy rất bận rộn, nhưng cuối tuần thỉnh thoảng cũng hẹn bạn bè ra ngoại thành câu cá.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他平时工作虽然非常忙碌，但周末偶尔也会约朋友去郊外钓鱼。', 'Tā píngshí gōngzuò suīrán fēicháng mánglù, dàn zhōumò ǒu’ěr yě huì yuē péngyou qù jiāowài diàoyú.', 'Ngày thường công việc của anh ấy tuy rất bận rộn, nhưng cuối tuần thỉnh thoảng cũng hẹn bạn bè ra ngoại thành câu cá.', 'basic', 1),
        (v_id, '在长期坚持健康规律饮食与作息的前提下，偶尔吃一次高热量的美味甜品对身体并无大碍。', 'Zài chángqī jiānchí jiànkāng guīlǜ yǐnshí yǔ zuòxī de qiántí xià, ǒu’ěr chī yí cì gāo-rèliàng de měiwèi tiánpǐn duì shēntǐ bìng wú dà’ài.', 'Dưới tiền đề kiên trì ăn uống và nghỉ ngơi điều độ lành mạnh lâu dài, đôi khi ăn một lần món tráng miệng thơm ngon hàm lượng calo cao cũng không gây ảnh hưởng lớn cho sức khỏe.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [拍] (pāi) - chụp (ảnh), quay (phim); vỗ, đập; cây vợt [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '拍' AND pinyin = 'pāi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '拍'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'pāi',
      meaning_vi = 'chụp (ảnh), quay (phim); vỗ, đập; cây vợt',
      example_hanzi = '桂林的风景太美了，游客们纷纷拿出手机拍下了许多精彩瞬间。',
      example_pinyin = 'Guìlín de fēngjǐng tài měi le, yóukèmen fēnfēn ná chū shǒujī pāi xià le xǔduō jīngcǎi shūnjiān.',
      example_vi = 'Phong cảnh Quế Lâm đẹp quá, du khách đua nhau lấy điện thoại ra chụp lại biết bao khoảnh khắc tuyệt vời.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '桂林的风景太美了，游客们纷纷拿出手机拍下了许多精彩瞬间。', 'Guìlín de fēngjǐng tài měi le, yóukèmen fēnfēn ná chū shǒujī pāi xià le xǔduō jīngcǎi shūnjiān.', 'Phong cảnh Quế Lâm đẹp quá, du khách đua nhau lấy điện thoại ra chụp lại biết bao khoảnh khắc tuyệt vời.', 'basic', 1),
        (v_id, '导演团队历经三年艰苦采风，用顶尖超高清镜头拍出了一部真实展现极地野生动物生存奇迹的重磅生态纪录片。', 'Dǎoyǎn tuánduì lìjīng sān nián jiānkǔ cǎifēng, yòng dǐngjiān chāo-gāoqīng jìngtóu pāi chū le yì bù zhēnshí zhǎnxiàn jídì yěshēng dòngwù shēngcún qíjì de zhòngbàng shēngtài jìlùpiàn.', 'Đội ngũ đạo diễn trải qua ba năm gian khổ đi thực tế, dùng ống kính siêu nét hàng đầu đã quay nên một bộ phim tài liệu sinh thái tầm cỡ phản ánh chân thực kỳ tích sinh tồn của các loài động vật hoang dã vùng cực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [排] (pái) - hàng, dãy; sắp xếp, xếp đặt [Lượng từ / Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '排' AND pinyin = 'pái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '排'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Động từ / Danh từ',
      pinyin = 'pái',
      meaning_vi = 'hàng, dãy; sắp xếp, xếp đặt',
      example_hanzi = '电影院正中央第五排的座位观影视线和音效体验最佳。',
      example_pinyin = 'Diànyǐngyuàn zhèngzhōngyāng dì-wǔ pái de zuòwèi guānyǐng shìxiàn hé yīnxiào tǐyàn zuì jiā.',
      example_vi = 'Chỗ ngồi ở hàng thứ năm chính giữa rạp chiếu phim có tầm nhìn và trải nghiệm hiệu ứng âm thanh tốt nhất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '电影院正中央第五排的座位观影视线和音效体验最佳。', 'Diànyǐngyuàn zhèngzhōngyāng dì-wǔ pái de zuòwèi guānyǐng shìxiàn hé yīnxiào tǐyàn zuì jiā.', 'Chỗ ngồi ở hàng thứ năm chính giữa rạp chiếu phim có tầm nhìn và trải nghiệm hiệu ứng âm thanh tốt nhất.', 'basic', 1),
        (v_id, '现代智能工厂调度系统利用先进算法自动编排生产工序，极大缩短了物料周转时间并提高了产线利用率。', 'Xiàndài zhìnéng gōngchǎng diàodù xìtǒng lìyòng xiānjìn suànfǎ zìdòng biānpái shēngchǎn gōngxù, jí dà suōduǎn le wùliào zhōuzhuǎn shíjiān bìng tígāo le chǎnxiàn lìyònglǜ.', 'Hệ thống điều độ nhà máy thông minh hiện đại sử dụng thuật toán tiên tiến tự động sắp xếp quy trình sản xuất, rút ngắn rất lớn thời gian luân chuyển nguyên vật liệu và nâng cao hiệu suất sử dụng dây chuyền.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [牌] (pái) - tấm biển, biển báo; quân bài, thẻ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '牌' AND pinyin = 'pái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '牌'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'pái',
      meaning_vi = 'tấm biển, biển báo; quân bài, thẻ',
      example_hanzi = '路口立着一块显眼的交通指示牌，提醒司机前方禁止左转。',
      example_pinyin = 'Lùkǒu lì zhe yí kuài xiǎnyǎn de jiāotōng zhǐshìpái, tíxǐng sījī qiánfāng jìnzhǐ zuǒzhuǎn.',
      example_vi = 'Tại ngã tư có dựng một tấm biển chỉ dẫn giao thông bắt mắt, nhắc nhở tài xế phía trước cấm rẽ trái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '路口立着一块显眼的交通指示牌，提醒司机前方禁止左转。', 'Lùkǒu lì zhe yí kuài xiǎnyǎn de jiāotōng zhǐshìpái, tíxǐng sījī qiánfāng jìnzhǐ zuǒzhuǎn.', 'Tại ngã tư có dựng một tấm biển chỉ dẫn giao thông bắt mắt, nhắc nhở tài xế phía trước cấm rẽ trái.', 'basic', 1),
        (v_id, '中国在高端新能源装备制造领域已经培育出一批叫得响、立得住的国际知名金字招牌。', 'Zhōngguó zài gāoduān xīnnéngyuán zhuāngbèi zhìzào lǐngyù yǐjīng péiyù chū yí pī jiào de xiǎng, lì de zhù de guójì zhìmíng jīnzì zhāopai.', 'Trung Quốc trong lĩnh vực chế tạo thiết bị năng lượng mới cao cấp đã bồi dưỡng nên một loạt thương hiệu bảng vàng nức tiếng thế giới vang danh và đứng vững chắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [排队] (páiduì) - xếp hàng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '排队' AND pinyin = 'páiduì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '排队'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'páiduì',
      meaning_vi = 'xếp hàng',
      example_hanzi = '在地铁站进站口，乘客们自觉排队有序刷卡通过闸机。',
      example_pinyin = 'Zài dìtiězhàn jìnzhànkǒu, chéngkèmen zìjué páiduì yǒuxù shuākǎ tōngguò zhájī.',
      example_vi = 'Tại cửa vào ga tàu điện ngầm, các hành khách tự giác xếp hàng quẹt thẻ qua cửa soát vé có trật tự.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在地铁站进站口，乘客们自觉排队有序刷卡通过闸机。', 'Zài dìtiězhàn jìnzhànkǒu, chéngkèmen zìjué páiduì yǒuxù shuākǎ tōngguò zhájī.', 'Tại cửa vào ga tàu điện ngầm, các hành khách tự giác xếp hàng quẹt thẻ qua cửa soát vé có trật tự.', 'basic', 1),
        (v_id, '政务服务中心通过全面推行网上预约与掌上通办，从根本上解决了群众以往办事跑断腿、排长队的历史痛点。', 'Zhèngwù fúwù zhōngxīn tōngguò quánmiàn tuīxíng wǎngshàng yùyuē yǔ zhǎngshàng tōngbàn, cóng gēnběn shang jiějué le qúnzhòng yǐwǎng bànshì pǎo duàn tuǐ, pái chángduì de lìshǐ tòngdiǎn.', 'Trung tâm dịch vụ hành chính công thông qua việc triển khai toàn diện đặt lịch hẹn trên mạng và xử lý thông suốt trên di động, đã giải quyết tận gốc rễ nỗi đau lịch sử của người dân trước đây khi làm thủ tục phải chạy mòn chân và xếp hàng dài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [排球] (páiqiú) - bóng chuyền [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '排球' AND pinyin = 'páiqiú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '排球'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'páiqiú',
      meaning_vi = 'bóng chuyền',
      example_hanzi = '大学体育课上，老师正在指导同学们练习排球垫球的基本动作。',
      example_pinyin = 'Dàxué tǐyùkè shang, lǎoshī zhèngzài zhǐdǎo tóngxuémen liànxí páiqiú diànqiú de jīběn dòngzuò.',
      example_vi = 'Trong tiết thể dục đại học, thầy giáo đang hướng dẫn các bạn học sinh luyện tập động tác đệm bóng chuyền cơ bản.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大学体育课上，老师正在指导同学们练习排球垫球的基本动作。', 'Dàxué tǐyùkè shang, lǎoshī zhèngzài zhǐdǎo tóngxuémen liànxí páiqiú diànqiú de jīběn dòngzuò.', 'Trong tiết thể dục đại học, thầy giáo đang hướng dẫn các bạn học sinh luyện tập động tác đệm bóng chuyền cơ bản.', 'basic', 1),
        (v_id, '中国女排在世界大赛中屡创辉煌，不畏强敌、顽强战斗的“女排精神”深深激励着一代代中华儿女奋勇向前。', 'Zhōngguó nǚpái zài shìjiè dàsài zhōng lǚ chuàng huīhuáng, bú wèi qiángdí, wánqiáng zhàndòu de “nǚpái jīngshén” shēnshēn jīlì zhe yídàidài Zhōnghuá érnǚ fènyǒng qiánxián.', 'Đội tuyển bóng chuyền nữ Trung Quốc liên tiếp tạo nên kỳ tích huy hoàng tại các giải đấu thế giới, "tinh thần bóng chuyền nữ" không sợ đối thủ mạnh, chiến đấu ngoan cường đã khích lệ sâu sắc từng thế hệ con em Trung Hoa dũng cảm tiến bước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [牌子] (páizi) - nhãn hiệu, thương hiệu; tấm biển [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '牌子' AND pinyin = 'páizi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '牌子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'páizi',
      meaning_vi = 'nhãn hiệu, thương hiệu; tấm biển',
      example_hanzi = '这件羽绒服是什么牌子的？保暖效果真的非常不错。',
      example_pinyin = 'Zhè jiàn yǔróngfú shì shénme páizi de? Bǎonuǎn xiàoguǒ zhēn de fēicháng búcuò.',
      example_vi = 'Chiếc áo phao lông vũ này là của thương hiệu nào thế? Hiệu quả giữ ấm quả thực rất tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这件羽绒服是什么牌子的？保暖效果真的非常不错。', 'Zhè jiàn yǔróngfú shì shénme páizi de? Bǎonuǎn xiàoguǒ zhēn de fēicháng búcuò.', 'Chiếc áo phao lông vũ này là của thương hiệu nào thế? Hiệu quả giữ ấm quả thực rất tốt.', 'basic', 1),
        (v_id, '在激烈的全球消费市场竞争中，中国自主品牌正加速摘掉低端代工的旧标签，树立起以自主科技与原创美学为支撑的高端品牌牌子。', 'Zài jīliè de quánqiú xiāofèi shìchǎng jìngzhēng zhōng, Zhōngguó zìzhǔ pǐnpái zhèng jiāsù zhāidiào dīduān dàigōng de jiù biāoqiān, shùlì qǐ yǐ zìzhǔ kējì yǔ yuánchuàng měixué wéi zhīchēng de gāoduān pǐnpái páizi.', 'Giữa cuộc cạnh tranh thị trường tiêu dùng toàn cầu khốc liệt, các thương hiệu độc lập của Trung Quốc đang đẩy nhanh việc tháo bỏ mác gia công giá rẻ cũ, dựng xây nên những thương hiệu nhãn hiệu cao cấp được chống đỡ bằng công nghệ tự chủ và mỹ học sáng tạo nguyên bản.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [判断] (pànduàn) - phán đoán, nhận định, đánh giá [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '判断' AND pinyin = 'pànduàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '判断'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'pànduàn',
      meaning_vi = 'phán đoán, nhận định, đánh giá',
      example_hanzi = '在没有任何充分证据之前，千万不要主观地下结论判断对错。',
      example_pinyin = 'Zài méiyǒu rènhé chōngfèn zhèngjù zhīqián, qiānwàn bú yào zhǔguān de xià jiélùn pànduàn duì-cuò.',
      example_vi = 'Trước khi chưa có bất kỳ bằng chứng đầy đủ nào, tuyệt đối không được đưa ra kết luận phán đoán đúng sai một cách chủ quan.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在没有任何充分证据之前，千万不要主观地下结论判断对错。', 'Zài méiyǒu rènhé chōngfèn zhèngjù zhīqián, qiānwàn bú yào zhǔguān de xià jiélùn pànduàn duì-cuò.', 'Trước khi chưa có bất kỳ bằng chứng đầy đủ nào, tuyệt đối không được đưa ra kết luận phán đoán đúng sai một cách chủ quan.', 'basic', 1),
        (v_id, '优秀的基金投资经理在面对复杂的宏观经济数据时，能够敏锐洞察周期拐点并作出精准的前瞻性战略判断。', 'Yōuxiù de jījīn tóuzī jīnglǐ zài miànduì fùzá de hóngguān jīngjì shùjù shí, nénggòu mǐnruì dòngchá zhōuqī guǎidiǎn bìng zuò chū jīngzhǔn de qiánzhānxìng zhànlüè pànduàn.', 'Giám đốc đầu tư quỹ xuất sắc khi đối mặt với các số liệu kinh tế vĩ mô phức tạp, có thể nhạy bén thấy trước điểm đảo chiều chu kỳ và đưa ra nhận định chiến lược đón đầu chuẩn xác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [陪] (péi) - đồng hành, đi cùng, bầu bạn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '陪' AND pinyin = 'péi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '陪'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'péi',
      meaning_vi = 'đồng hành, đi cùng, bầu bạn',
      example_hanzi = '周末只要一有空，他都会抽出时间在家里陪伴父母聊天。',
      example_pinyin = 'Zhōumò zhǐyào yì yǒu kòng, tā dōu huì chōu chū shíjiān zài jiā lǐ péibàn fùmǔ liáotiān.',
      example_vi = 'Cuối tuần chỉ cần có thời gian rảnh, anh ấy đều bớt chút thời gian ở nhà bầu bạn trò chuyện cùng cha mẹ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末只要一有空，他都会抽出时间在家里陪伴父母聊天。', 'Zhōumò zhǐyào yì yǒu kòng, tā dōu huì chōu chū shíjiān zài jiā lǐ péibàn fùmǔ liáotiān.', 'Cuối tuần chỉ cần có thời gian rảnh, anh ấy đều bớt chút thời gian ở nhà bầu bạn trò chuyện cùng cha mẹ.', 'basic', 1),
        (v_id, '招商引资团队推行全生命周期“保姆式”陪跑服务，及时协助战略投资企业解决项目审批与用地等各环节实际困难。', 'Zhāoshāng-yǐnzī tuánduì tuīxíng quán shēngmìng-zhōuqī “bǎomǔshì” péipǎo fúwù, jíshí xiézhù zhànlüè tóuzī qǐyè jiějué xiàngmù shěnpī yǔ yòngdì děng gè huánjié shíjì kùnnan.', 'Đội ngũ xúc tiến thu hút đầu tư áp dụng dịch vụ "đồng hành chăm sóc trọn vẹn" toàn bộ vòng đời, kịp thời hỗ trợ các doanh nghiệp đầu tư chiến lược tháo gỡ khó khăn thực tế ở các khâu như thẩm định phê duyệt dự án và cấp đất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [批评] (pīpíng) - phê bình, chỉ trích; lời phê bình [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '批评' AND pinyin = 'pīpíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '批评'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'pīpíng',
      meaning_vi = 'phê bình, chỉ trích; lời phê bình',
      example_hanzi = '虚心接受老师提出的善意批评，有助于我们更快地纠正自身的错误。',
      example_pinyin = 'Xūxīn jiēshòu lǎoshī tíchū de shànyì pīpíng, yǒuzhùyú wǒmen gèng kuài de jiūzhèng zìshēn de cuòwù.',
      example_vi = 'Khiêm tốn tiếp thu những lời phê bình thiện chí do thầy cô đưa ra sẽ giúp chúng ta nhanh chóng sửa chữa sai lầm của bản thân.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '虚心接受老师提出的善意批评，有助于我们更快地纠正自身的错误。', 'Xūxīn jiēshòu lǎoshī tíchū de shànyì pīpíng, yǒuzhùyú wǒmen gèng kuài de jiūzhèng zìshēn de cuòwù.', 'Khiêm tốn tiếp thu những lời phê bình thiện chí do thầy cô đưa ra sẽ giúp chúng ta nhanh chóng sửa chữa sai lầm của bản thân.', 'basic', 1),
        (v_id, '在学术自由探索与严谨求证的研讨氛围中，学者们应当勇于展开客观犀利的学术批评与同行评议。', 'Zài xuéshù zìyóu tànsuǒ yǔ yánjǐn qiúzhèng de yántǎo fēnwéi zhōng, xuézhěmen yīngdāng yǒngyú zhǎnkāi kèguān xīlì de xuéshù pīpíng yǔ tóngháng píngyì.', 'Trong bầu không khí hội thảo khám phá học thuật tự do và chứng minh chặt chẽ, các học giả cần dũng cảm triển khai phê bình học thuật khách quan sắc bén và bình duyệt đồng cấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [皮肤] (pífū) - da, làn da [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '皮肤' AND pinyin = 'pífū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '皮肤'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'pífū',
      meaning_vi = 'da, làn da',
      example_hanzi = '在烈日下进行户外运动时，一定要涂抹防晒霜以保护皮肤不被晒伤。',
      example_pinyin = 'Zài lièrì xià jìnxíng hùwài yùndòng shí, yídìng yào túmǒ fángshàishuāng yǐ bǎohù pífū bú bèi shàishāng.',
      example_vi = 'Khi vận động ngoài trời dưới trời nắng gắt, nhất định phải bôi kem chống nắng để bảo vệ da không bị cháy nắng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在烈日下进行户外运动时，一定要涂抹防晒霜以保护皮肤不被晒伤。', 'Zài lièrì xià jìnxíng hùwài yùndòng shí, yídìng yào túmǒ fángshàishuāng yǐ bǎohù pífū bú bèi shàishāng.', 'Khi vận động ngoài trời dưới trời nắng gắt, nhất định phải bôi kem chống nắng để bảo vệ da không bị cháy nắng.', 'basic', 1),
        (v_id, '皮肤科临床医学研究表明，长期熬夜、精神高压以及过度高糖高脂饮食是诱发顽固性慢性皮肤炎症的重要元凶。', 'Pífūkē línchuáng yīxué yánjiū biǎomíng, chángqī áoyè, jīngshén gāoyā yǐjí guòdù gāotáng-gāozhī yǐnshí shì yòufā wángùxìng mànxìng pífū yánzhèng de zhòngyào yuánxiōng.', 'Nghiên cứu y học lâm sàng da liễu chỉ ra rằng, thường xuyên thức khuya, căng thẳng tinh thần kéo dài cùng chế độ ăn uống quá nhiều đường nhiều dầu mỡ là những thủ phạm chính gây ra các chứng viêm da mãn tính dai dẳng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [脾气] (píqi) - tính khí, tính tình, cơn cáu giận [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '脾气' AND pinyin = 'píqi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '脾气'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'píqi',
      meaning_vi = 'tính khí, tính tình, cơn cáu giận',
      example_hanzi = '王经理待人十分温和随和，工作十几年从未见他跟谁发过脾气。',
      example_pinyin = 'Wáng jīnglǐ dài rén shífēn wēnhé suíhe, gōngzuò shí jǐ nián cóngwèi jiàn tā gēn shéi fā guò píqi.',
      example_vi = 'Giám đốc Vương đối xử với mọi người rất ôn hòa dễ gần, làm việc hơn mười năm chưa từng thấy anh ấy nổi cáu với ai bao giờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '王经理待人十分温和随和，工作十几年从未见他跟谁发过脾气。', 'Wáng jīnglǐ dài rén shífēn wēnhé suíhe, gōngzuò shí jǐ nián cóngwèi jiàn tā gēn shéi fā guò píqi.', 'Giám đốc Vương đối xử với mọi người rất ôn hòa dễ gần, làm việc hơn mười năm chưa từng thấy anh ấy nổi cáu với ai bao giờ.', 'basic', 1),
        (v_id, '成熟卓越的职业经理人应当具备极高的情商与情绪管理能力，绝不把个人负面脾气带入到团队协同决策中。', 'Chéngshú zhuóyuè de zhíyè jīnglǐrén yīngdāng jùbèi jí gāo de qíngshāng yǔ qíngxù guǎnlǐ nénglì, jué bù bǎ gèrén fùmiàn píqi dài rù dào tuánduì xiétóng juécè zhōng.', 'Nhà quản lý chuyên nghiệp chín chắn xuất sắc cần có chỉ số cảm xúc (EQ) và năng lực quản lý cảm xúc cực cao, tuyệt đối không mang tính khí tiêu cực cá nhân vào trong việc đưa ra quyết sách phối hợp của đội ngũ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [皮鞋] (píxié) - giày da [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '皮鞋' AND pinyin = 'píxié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '皮鞋'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'píxié',
      meaning_vi = 'giày da',
      example_hanzi = '参加正式商务签约仪式时，他换上了一身笔挺西装和擦得锃亮的黑皮鞋。',
      example_pinyin = 'Cānjiā zhèngshì shāngwù qiānyuē yíshì shí, tā huàn shàng le yì shēn bǐtǐng xīzhuāng hé cā de zèngliàng de hēi píxié.',
      example_vi = 'Khi tham dự buổi lễ ký kết thương mại chính thức, anh ấy đã thay một bộ vest phẳng phiu và đôi giày da đen đánh bóng loáng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '参加正式商务签约仪式时，他换上了一身笔挺西装和擦得锃亮的黑皮鞋。', 'Cānjiā zhèngshì shāngwù qiānyuē yíshì shí, tā huàn shàng le yì shēn bǐtǐng xīzhuāng hé cā de zèngliàng de hēi píxié.', 'Khi tham dự buổi lễ ký kết thương mại chính thức, anh ấy đã thay một bộ vest phẳng phiu và đôi giày da đen đánh bóng loáng.', 'basic', 1),
        (v_id, '手工定制高端真皮皮鞋融合了百年传统的经典固特异缝线制鞋工艺，为成功商务人士提供了极佳的舒适透气脚感。', 'Shǒugōng dìngzhì gāoduān zhēnpí píxié rónghé le bǎinián chuántǒng de jīngdiǎn Gùtèyì féngxiàn zhìxié gōngyì, wèi chénggōng shāngwù rénshì tígōng le jí jiā de shūshì tòuqì jiǎogǎn.', 'Giày da thật cao cấp may đo thủ công kết hợp kỹ thuật đóng giày may viền Goodyear kinh điển truyền thống trăm năm, đem lại cảm giác êm chân thoáng khí tuyệt vời cho giới doanh nhân thành đạt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [篇] (piān) - bài, thiên (bài viết, bài báo, bài khóa) [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '篇' AND pinyin = 'piān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '篇'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'piān',
      meaning_vi = 'bài, thiên (bài viết, bài báo, bài khóa)',
      example_hanzi = '请大家在课后认真精读这篇关于中国传统节日文化的中文短文。',
      example_pinyin = 'Qǐng dàjiā zài kèhòu rènzhēn jīngdú zhè piān guānyú Zhōngguó chuántǒng jiérì wénhuà de Zhōngwén duǎnwén.',
      example_vi = 'Xin mời mọi người sau giờ học chăm chú đọc kỹ bài văn ngắn tiếng Trung về văn hóa ngày lễ tết truyền thống Trung Hoa này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请大家在课后认真精读这篇关于中国传统节日文化的中文短文。', 'Qǐng dàjiā zài kèhòu rènzhēn jīngdú zhè piān guānyú Zhōngguó chuántǒng jiérì wénhuà de Zhōngwén duǎnwén.', 'Xin mời mọi người sau giờ học chăm chú đọc kỹ bài văn ngắn tiếng Trung về văn hóa ngày lễ tết truyền thống Trung Hoa này.', 'basic', 1),
        (v_id, '该学术攻关团队在国际顶尖学术期刊上连续发表了三篇关于量子计算核心算法的重磅学术论文。', 'Gāi xuéshù gōngguān tuánduì zài guójì dǐngjiān xuéshù qīkān shang liánxù fābiǎo le sān piān guānyú liàngzǐ jìsuàn héxīn suànfǎ de zhòngbàng xuéshù lùnwén.', 'Đội ngũ nghiên cứu học thuật này đã liên tiếp công bố ba bài luận văn học thuật tầm cỡ về thuật toán cốt lõi của tính toán lượng tử trên tạp chí học thuật hàng đầu quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [片] (piàn) - mảnh, phiến, lát, viên (thuốc); dải (đất, mây) [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '片' AND pinyin = 'piàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '片'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'piàn',
      meaning_vi = 'mảnh, phiến, lát, viên (thuốc); dải (đất, mây)',
      example_hanzi = '医生嘱咐他饭后半小时温水服用一片感冒消炎药。',
      example_pinyin = 'Yīshēng zhǔfù tā fànhòu bàn xiǎoshí wēnshuǐ fúyòng yí piàn gǎnmào xiāoyányào.',
      example_vi = 'Bác sĩ dặn dò cậu ấy nửa tiếng sau bữa ăn uống một viên thuốc cảm tiêu viêm bằng nước ấm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '医生嘱咐他饭后半小时温水服用一片感冒消炎药。', 'Yīshēng zhǔfù tā fànhòu bàn xiǎoshí wēnshuǐ fúyòng yí piàn gǎnmào xiāoyányào.', 'Bác sĩ dặn dò cậu ấy nửa tiếng sau bữa ăn uống một viên thuốc cảm tiêu viêm bằng nước ấm.', 'basic', 1),
        (v_id, '随着全国生态林业保护工程的深入推进，我国北方沙漠边缘已经筑起了一片横跨数千公里的绿色防护林生态屏障。', 'Suízhe quánguó shēngtài línyè bǎohù gōngchéng de shēnrù tuījìn, wǒ guó běifāng shāmò biānyuán yǐjīng zhù qǐ le yí piàn héngkuà shù qiān gōnglǐ de lǜsè fánghùlín shēngtài píngzhàng.', 'Cùng với việc đẩy mạnh sâu rộng công trình bảo vệ lâm nghiệp sinh thái toàn quốc, rìa sa mạc phía bắc nước ta đã dựng nên một dải lá chắn sinh thái rừng phòng hộ xanh trải dài hàng ngàn cây số.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [乒乓球] (pīngpāngqiú) - bóng bàn, môn bóng bàn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '乒乓球' AND pinyin = 'pīngpāngqiú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '乒乓球'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'pīngpāngqiú',
      meaning_vi = 'bóng bàn, môn bóng bàn',
      example_hanzi = '课间休息时，操场边的乒乓球台前总是围满了打球的同学。',
      example_pinyin = 'Kèjiān xiūxi shí, cāochǎng biān de pīngpāngqiútái qián zǒngshì wéi mǎn le dǎ qiú de tóngxué.',
      example_vi = 'Vào giờ ra chơi giữa các tiết học, trước các bàn bóng bàn bên rìa sân tập luôn vây kín những bạn học sinh chơi bóng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '课间休息时，操场边的乒乓球台前总是围满了打球的同学。', 'Kèjiān xiūxi shí, cāochǎng biān de pīngpāngqiútái qián zǒngshì wéi mǎn le dǎ qiú de tóngxué.', 'Vào giờ ra chơi giữa các tiết học, trước các bàn bóng bàn bên rìa sân tập luôn vây kín những bạn học sinh chơi bóng.', 'basic', 1),
        (v_id, '乒乓球被誉为中国的“国球”，不仅在世界各大体育赛事上屡获殊荣，更在历史上写下了著名的“小球转动大球”的乒乓外交佳话。', 'Pīngpāngqiú bèi yù wéi Zhōngguó de “guóqiú”, bùjǐn zài shìjiè gè dà tǐyù sàishì shang lǚ huò shūróng, gèng zài lìshǐ shang xiě xià le zhùmíng de “xiǎo qiú zhuǎndòng dà qiú” de pīngpāng wàijiāo jiāhuà.', 'Bóng bàn được mệnh danh là "quốc cầu" của Trung Quốc, không chỉ liên tiếp giành vinh quang tại các giải thi đấu thể thao lớn trên thế giới, mà còn viết nên câu chuyện ngoại giao bóng bàn giai thoại nổi tiếng "quả bóng nhỏ xoay chuyển quả địa cầu lớn" trong lịch sử.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [平常] (píngcháng) - bình thường, ngày thường; tầm thường [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '平常' AND pinyin = 'píngcháng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '平常'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'píngcháng',
      meaning_vi = 'bình thường, ngày thường; tầm thường',
      example_hanzi = '他平常下了班之后，最喜欢在家里看书或者听音乐放松。',
      example_pinyin = 'Tā píngcháng xià le bān zhīhòu, zuì xǐhuan zài jiā lǐ kànshū huòzhě tīng yīnyuè fàngsōng.',
      example_vi = 'Ngày thường sau khi tan sở, anh ấy thích nhất là ở nhà đọc sách hoặc nghe nhạc thư giãn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他平常下了班之后，最喜欢在家里看书或者听音乐放松。', 'Tā píngcháng xià le bān zhīhòu, zuì xǐhuan zài jiā lǐ kànshū huòzhě tīng yīnyuè fàngsōng.', 'Ngày thường sau khi tan sở, anh ấy thích nhất là ở nhà đọc sách hoặc nghe nhạc thư giãn.', 'basic', 1),
        (v_id, '伟大往往孕育于平常之中，无数普通劳动者在极其平常的工作岗位上的默默坚守与辛勤付出，铸就了时代发展的巍峨基石。', 'Wěidà wǎngwǎng yùnyù yú píngcháng zhīzhōng, wúshù pǔtōng láodòngzhě zài jíqí píngcháng de gōngzuò gǎngwèi shang de mòmò jiānshǒu yǔ xīnqín fùchū, zhù jiù le shídài fāzhǎn de wēi’é jīshí.', 'Sự vĩ đại thường được nuôi dưỡng từ những điều bình thường, sự cống hiến cần cù và kiên trì thầm lặng nơi vị trí công tác hết sức bình thường của vô số người lao động bình dị đã đúc nên nền móng sừng sững cho sự phát triển thời đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [破] (pò) - rách, hỏng, vỡ; phá vỡ (kỷ lục) [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '破' AND pinyin = 'pò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '破'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'pò',
      meaning_vi = 'rách, hỏng, vỡ; phá vỡ (kỷ lục)',
      example_hanzi = '他不小心把心爱的玻璃杯摔在地上破成碎片了。',
      example_pinyin = 'Tā bù xiǎoxīn bǎ xīn’ài de bōlibēi shuāi zài dì shang pò chéng suìpiàn le.',
      example_vi = 'Cậu ấy sơ ý đánh rơi chiếc cốc thủy tinh yêu thích xuống đất vỡ thành từng mảnh vụn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他不小心把心爱的玻璃杯摔在地上破成碎片了。', 'Tā bù xiǎoxīn bǎ xīn’ài de bōlibēi shuāi zài dì shang pò chéng suìpiàn le.', 'Cậu ấy sơ ý đánh rơi chiếc cốc thủy tinh yêu thích xuống đất vỡ thành từng mảnh vụn.', 'basic', 1),
        (v_id, '这家高科技初创企业仅用了两年时间就在海外市场取得了重大突破，年度营业额强势破亿元大关。', 'Zhè jiā gāokējì chūchuàng qǐyè jǐn yòng le liǎng nián shíjiān jiù zài hǎiwài shìchǎng qǔdé le zhòngdà tūpò, niándù yíngyè’é qiángshì pò yì yuán dàguān.', 'Doanh nghiệp khởi nghiệp công nghệ cao này chỉ dùng thời gian hai năm đã giành được bước đột phá quan trọng tại thị trường nước ngoài, doanh thu hàng năm phá mốc trăm triệu nhân dân tệ một cách mạnh mẽ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [葡萄] (pútao) - nho, quả nho [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '葡萄' AND pinyin = 'pútao'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '葡萄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'pútao',
      meaning_vi = 'nho, quả nho',
      example_hanzi = '新疆吐鲁番盆地光照十分充足，出产的无核白葡萄格外甘甜。',
      example_pinyin = 'Xīnjiāng Tǔlǔfān péndì guāngzhào shífēn chōngzú, chūchǎn de wúhé bái pútao géwài gāntián.',
      example_vi = 'Bồn địa Turpan ở Tân Cương ánh nắng vô cùng dồi dào, những trái nho trắng không hạt sản xuất ở đây ngọt lịm khác thường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '新疆吐鲁番盆地光照十分充足，出产的无核白葡萄格外甘甜。', 'Xīnjiāng Tǔlǔfān péndì guāngzhào shífēn chōngzú, chūchǎn de wúhé bái pútao géwài gāntián.', 'Bồn địa Turpan ở Tân Cương ánh nắng vô cùng dồi dào, những trái nho trắng không hạt sản xuất ở đây ngọt lịm khác thường.', 'basic', 1),
        (v_id, '现代设施农业大棚全面引入了水肥一体化滴灌与温光智能调控技术，使得高品质阳光玫瑰鲜食葡萄实现了标准化规模化种植。', 'Xiàndài shèshī nóngyè dàpéng quánmiàn yǐnrù le shuǐ-féi yītǐhuà dīguàn yǔ wēn-guāng zhìnéng tiáokòng jìshù, shǐde gāo pǐnzhì yángguāng méiguī xiānshí pútao shíxiàn le biāozhǔnhuà guīmóhuà zhòngzhí.', 'Các nhà kính nông nghiệp trang thiết bị hiện đại đã đưa vào đồng bộ công nghệ tưới nhỏ giọt tích hợp phân - nước và điều khiển thông minh nhiệt độ - ánh sáng, giúp giống nho tươi ăn trực tiếp Mẫu Đơn Ánh Dương chất lượng cao đạt được việc trồng trọt quy mô hóa chuẩn hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [葡萄酒] (pútaojiǔ) - rượu vang, rượu nho [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '葡萄酒' AND pinyin = 'pútaojiǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '葡萄酒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'pútaojiǔ',
      meaning_vi = 'rượu vang, rượu nho',
      example_hanzi = '在浪漫温馨的烛光晚宴上，大家举起高脚杯品尝香醇的红葡萄酒。',
      example_pinyin = 'Zài làngmàn wēnxīn de zhúguāng wǎnyàn shang, dàjiā jǔ qǐ gāojiǎobēi pǐncháng xiāngchún de hóng pútaojiǔ.',
      example_vi = 'Trong bữa tiệc tối dưới ánh nến lãng mạn ấm cúng, mọi người nâng ly chân cao thưởng thức ly rượu vang đỏ thơm nồng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在浪漫温馨的烛光晚宴上，大家举起高脚杯品尝香醇的红葡萄酒。', 'Zài làngmàn wēnxīn de zhúguāng wǎnyàn shang, dàjiā jǔ qǐ gāojiǎobēi pǐncháng xiāngchún de hóng pútaojiǔ.', 'Trong bữa tiệc tối dưới ánh nến lãng mạn ấm cúng, mọi người nâng ly chân cao thưởng thức ly rượu vang đỏ thơm nồng.', 'basic', 1),
        (v_id, '宁夏贺兰山东麓凭借得天独厚的风土气候资源，成功培育出享誉海内外的优质葡萄庄园并斩获多项国际顶级葡萄酒大赛金奖。', 'Níngxià Hèlán Shān dōnglù píngjiè détiān-dúhòu de fēngtǔ qìhòu zīyuán, chénggōng péiyù chū xiǎngyù hǎinèiwài de yōuzhì pútao zhuāngyuán bìng zhǎnhuò duō xiàng guójì dǐngjí pútaojiǔ dàsài jīnjiǎng.', 'Khu vực sườn đông dãy núi Hạ Lan ở Ninh Hạ nhờ vào nguồn tài nguyên thổ nhưỡng và khí hậu được trời phú độc nhất vô nhị, đã gây dựng thành công những trang viên rượu nho chất lượng cao vang danh trong và ngoài nước và ẵm nhiều giải vàng tại các cuộc thi rượu vang hàng đầu thế giới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [普遍] (pǔbiàn) - phổ biến, rộng khắp [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '普遍' AND pinyin = 'pǔbiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '普遍'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'pǔbiàn',
      meaning_vi = 'phổ biến, rộng khắp',
      example_hanzi = '如今移动扫码支付已经普遍渗透到了人们日常生活的方方面面。',
      example_pinyin = 'Rújīn yídòng sǎomǎ zhīfù yǐjīng pǔbiàn shèntòu dào le rénmen rìcháng shēnghuó de fāngfāng-miànmiàn.',
      example_vi = 'Ngày nay thanh toán quét mã di động đã phổ biến len lỏi vào từng phương diện của đời sống hàng ngày con người.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如今移动扫码支付已经普遍渗透到了人们日常生活的方方面面。', 'Rújīn yídòng sǎomǎ zhīfù yǐjīng pǔbiàn shèntòu dào le rénmen rìcháng shēnghuó de fāngfāng-miànmiàn.', 'Ngày nay thanh toán quét mã di động đã phổ biến len lỏi vào từng phương diện của đời sống hàng ngày con người.', 'basic', 1),
        (v_id, '在数字化技术深度赋能各行各业的背景下，数据驱动决策与敏捷协同已成为现代高成长型企业的普遍共识。', 'Zài shùzìhuà jìshù shēndù fùnéng gè háng gè yè de bèijǐng xià, shùjù qūdòng juécè yǔ mǐnjié xiétóng yǐ chéngwéi xiàndài gāo-chéngzhǎngxíng qǐyè de pǔbiàn gòngshí.', 'Dưới bối cảnh công nghệ số trao quyền sâu sắc cho mọi ngành nghề, việc ra quyết định dựa trên dữ liệu và hiệp đồng linh hoạt đã trở thành nhận thức chung phổ biến của các doanh nghiệp tăng trưởng cao hiện đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [普通] (pǔtōng) - phổ thông, bình thường, bình dị [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '普通' AND pinyin = 'pǔtōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '普通'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'pǔtōng',
      meaning_vi = 'phổ thông, bình thường, bình dị',
      example_hanzi = '这只是一款普通样式的双肩包，但结实耐用且容量很大。',
      example_pinyin = 'Zhè zhǐ shì yì kuǎn pǔtōng yàngshì de shuāngjiānbāo, dàn jiēshi-nàiyòng qiě róngliàng hěn dà.',
      example_vi = 'Đây chỉ là một mẫu ba lô kiểu dáng bình thường, nhưng bền chắc và có dung tích rất lớn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这只是一款普通样式的双肩包，但结实耐用且容量很大。', 'Zhè zhǐ shì yì kuǎn pǔtōng yàngshì de shuāngjiānbāo, dàn jiēshi-nàiyòng qiě róngliàng hěn dà.', 'Đây chỉ là một mẫu ba lô kiểu dáng bình thường, nhưng bền chắc và có dung tích rất lớn.', 'basic', 1),
        (v_id, '许多看似极为普通的基层一线劳动者，在国家遭遇急难险重的关键考验关头，挺身而出书写了不平凡的英雄赞歌。', 'Xǔduō kànsì jíwéi pǔtōng de jīcéng yīxiàn láodòngzhě, zài guójiā zāoyù jínán-xiǎnzhòng de guānjiàn kǎoyàn guāntóu, tǐngshēn-érchū shūxiě le bù píngfán de yīngxióng zàngē.', 'Nhiều người lao động tuyến đầu cơ sở nhìn bề ngoài hết sức bình thường, ở thời khắc đất nước đối mặt với thử thách cam go nguy cấp then chốt, đã dũng cảm dấn thân viết nên bài ca anh hùng không hề tầm thường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [普通话] (pǔtōnghuà) - tiếng phổ thông, tiếng Quan Thoại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '普通话' AND pinyin = 'pǔtōnghuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '普通话'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'pǔtōnghuà',
      meaning_vi = 'tiếng phổ thông, tiếng Quan Thoại',
      example_hanzi = '学习汉语一定要以北京语音为基础、标准普通话为准则。',
      example_pinyin = 'Xuéxí Hànyǔ yídìng yào yǐ Běijīng yǔyīn wéi jīchǔ, biāozhǔn pǔtōnghuà wéi zhǔnzé.',
      example_vi = 'Học tiếng Hán nhất định phải lấy ngữ âm Bắc Kinh làm cơ sở, tiếng phổ thông tiêu chuẩn làm chuẩn mực.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学习汉语一定要以北京语音为基础、标准普通话为准则。', 'Xuéxí Hànyǔ yídìng yào yǐ Běijīng yǔyīn wéi jīchǔ, biāozhǔn pǔtōnghuà wéi zhǔnzé.', 'Học tiếng Hán nhất định phải lấy ngữ âm Bắc Kinh làm cơ sở, tiếng phổ thông tiêu chuẩn làm chuẩn mực.', 'basic', 1),
        (v_id, '大力推广普及国家通用语言文字与规范普通话教学，是促进各民族广泛交往交流交融与铸牢中华民族共同体意识的战略工程。', 'Dàlì tuīguǎng pǔjí guójiā tōngyòng yǔyán wénzì yǔ guīfàn pǔtōnghuà jiàoxué, shì cùjìn gè mínzú guǎngfàn jiāowǎng jiāoliú jiāoróng yǔ zhù láo Zhōnghuá mínzú gòngtóngtǐ yìshí de zhànlüè gōngchéng.', 'Tập trung thúc đẩy phổ cập chữ viết và ngôn ngữ thông dụng quốc gia cùng việc giảng dạy tiếng phổ thông chuẩn hóa chính là công trình chiến lược để thúc đẩy các dân tộc giao lưu qua lại hòa quyện rộng rãi và đúc kết vững chắc ý thức cộng đồng chung dân tộc Trung Hoa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [期] (qī) - kỳ, giai đoạn, số (tạp chí, khóa học) [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '期' AND pinyin = 'qī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'qī',
      meaning_vi = 'kỳ, giai đoạn, số (tạp chí, khóa học)',
      example_hanzi = '这所语言学院开设的新一期高级中文进修班将于下周正式开课。',
      example_pinyin = 'Zhè suǒ yǔyán xuéyuàn kāishè de xīn yì qī gāojí Zhōngwén jìnxiūbān jiāng yú xià zhōu zhèngshì kāikè.',
      example_vi = 'Khóa học bồi dưỡng tiếng Trung cao cấp kỳ mới do học viện ngôn ngữ này mở sẽ chính thức khai giảng vào tuần sau.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这所语言学院开设的新一期高级中文进修班将于下周正式开课。', 'Zhè suǒ yǔyán xuéyuàn kāishè de xīn yì qī gāojí Zhōngwén jìnxiūbān jiāng yú xià zhōu zhèngshì kāikè.', 'Khóa học bồi dưỡng tiếng Trung cao cấp kỳ mới do học viện ngôn ngữ này mở sẽ chính thức khai giảng vào tuần sau.', 'basic', 1),
        (v_id, '总投资达百亿元的国家级高新技术重大工程项目分为三期建设，目前一期工程已全面竣工并实现商业投产。', 'Zǒng tóuzī dá bǎi yì yuán de guójiājí gāoxīnjìshù zhòngdà gōngchéng xiàngmù fēnwéi sān qī jiànshè, mùqián yī qī gōngchéng yǐ quánmiàn jùngōng bìng shíxiàn shāngyè tóuchǎn.', 'Dự án công trình trọng điểm công nghệ cao cấp quốc gia với tổng mức đầu tư trăm tỷ tệ được chia làm 3 kỳ xây dựng, hiện tại công trình kỳ một đã hoàn công toàn diện và đi vào sản xuất thương mại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [期末] (qīmò) - cuối kỳ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '期末' AND pinyin = 'qīmò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '期末'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qīmò',
      meaning_vi = 'cuối kỳ',
      example_hanzi = '随着期末考试的临近，图书馆里的自习自修座位天天爆满。',
      example_pinyin = 'Suízhe qīmò kǎoshì de línjìn, túshūguǎn lǐ de zìxí zìxiū zuòwèi tiāntiān bàomǎn.',
      example_vi = 'Cùng với việc kỳ thi cuối kỳ đang tới gần, các chỗ tự học trong thư viện ngày nào cũng kín chỗ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着期末考试的临近，图书馆里的自习自修座位天天爆满。', 'Suízhe qīmò kǎoshì de línjìn, túshūguǎn lǐ de zìxí zìxiū zuòwèi tiāntiān bàomǎn.', 'Cùng với việc kỳ thi cuối kỳ đang tới gần, các chỗ tự học trong thư viện ngày nào cũng kín chỗ.', 'basic', 1),
        (v_id, '学校教务处在期末综合测评中全面推行多元评价体系，彻底打破单纯以卷面考试成绩评定学生优劣的单一考核模式。', 'Xuéxiào jiàowùchù zài qīmò zōnghé cèpíng zhōng quánmiàn tuīxíng duōyuán píngjià tǐxì, chèdǐ dǎpò dānchún yǐ juànmiàn kǎoshì chéngjì píngdìng xuésheng yōuliè de dānyī kǎohé móshì.', 'Phòng đào tạo của trường trong đợt đánh giá tổng hợp cuối kỳ đã triển khai toàn diện hệ thống đánh giá đa chiều, phá vỡ hoàn toàn mô hình sát hạch đơn thuần chỉ dựa vào điểm bài thi trên giấy để xếp loại học sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [期中] (qīzhōng) - giữa kỳ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '期中' AND pinyin = 'qīzhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '期中'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qīzhōng',
      meaning_vi = 'giữa kỳ',
      example_hanzi = '经过认真的考前复习，他在本次期中教学测验中取得了全优的好成绩。',
      example_pinyin = 'Jīngguò rènzhēn de kǎoqián fùxí, tā zài běn cì qīzhōng jiàoxué cèyàn zhōng qǔdé le quányōu de hǎo chéngjì.',
      example_vi = 'Trải qua quá trình ôn tập kỹ lưỡng trước kỳ thi, cậu ấy đã đạt thành tích xuất sắc toàn diện trong bài kiểm tra giảng dạy giữa kỳ lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过认真的考前复习，他在本次期中教学测验中取得了全优的好成绩。', 'Jīngguò rènzhēn de kǎoqián fùxí, tā zài běn cì qīzhōng jiàoxué cèyàn zhōng qǔdé le quányōu de hǎo chéngjì.', 'Trải qua quá trình ôn tập kỹ lưỡng trước kỳ thi, cậu ấy đã đạt thành tích xuất sắc toàn diện trong bài kiểm tra giảng dạy giữa kỳ lần này.', 'basic', 1),
        (v_id, '教研室针对期中考试所反馈出的核心知识薄弱盲点，迅速开展集体教研并针对性调整了后半学期的教学进度安排。', 'Jiàoyánshì zhēnduì qīzhōng kǎoshì suǒ fǎnhuì chū de héxīn zhīshi bóruò mángdiǎn, xùnsù kāizhǎn jítǐ jiàoyán bìng zhēnduìxìng tiáozhěng le hòubàn xuéqī de jiàoxué jìndù ānpái.', 'Tổ bộ môn nhắm vào các điểm mù kiến thức yếu cốt lõi được phản hồi qua kỳ thi giữa kỳ, đã nhanh chóng triển khai sinh hoạt chuyên môn tập thể và điều chỉnh có mục tiêu kế hoạch tiến độ giảng dạy nửa cuối học kỳ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [其次] (qícì) - thứ hai, tiếp theo đó, mặt khác [Đại từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '其次' AND pinyin = 'qícì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '其次'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ / Liên từ',
      pinyin = 'qícì',
      meaning_vi = 'thứ hai, tiếp theo đó, mặt khác',
      example_hanzi = '选择工作首先要考虑自己的兴趣爱好，其次是薪酬待遇和发展空间。',
      example_pinyin = 'Xuǎnzé gōngzuò shǒuxiān yào kǎolǜ zìjǐ de xìngqù àihào, qícì shì xīnchóu dàiyù hé fāzhǎn kōngjiān.',
      example_vi = 'Chọn lựa công việc trước hết cần xem xét sở thích đam mê của bản thân, tiếp theo đó mới là chế độ tiền lương đãi ngộ và không gian thăng tiến.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '选择工作首先要考虑自己的兴趣爱好，其次是薪酬待遇和发展空间。', 'Xuǎnzé gōngzuò shǒuxiān yào kǎolǜ zìjǐ de xìngqù àihào, qícì shì xīnchóu dàiyù hé fāzhǎn kōngjiān.', 'Chọn lựa công việc trước hết cần xem xét sở thích đam mê của bản thân, tiếp theo đó mới là chế độ tiền lương đãi ngộ và không gian thăng tiến.', 'basic', 1),
        (v_id, '推动企业数字化转型，首要是建立全局数据治理战略，其次必须打通各业务部门数据孤岛并确保底层信息安全。', 'Tuīdòng qǐyè shùzìhuà zhuǎnxíng, shǒuyào shì jiànlì quánjú shùjù zhìlǐ zhànlüè, qícì bìxū dǎtōng gè yèwù bùmén shùjù gūdǎo bìng quèbǎo dǐcéng xìnxī ānquán.', 'Thúc đẩy chuyển đổi số của doanh nghiệp, việc hàng đầu là xác lập chiến lược quản trị dữ liệu toàn diện, tiếp theo đó bắt buộc phải khai thông các ốc đảo dữ liệu của các phòng ban nghiệp vụ và bảo đảm an toàn thông tin tầng đáy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [其中] (qízhōng) - trong đó, trong số đó [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '其中' AND pinyin = 'qízhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '其中'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qízhōng',
      meaning_vi = 'trong đó, trong số đó',
      example_hanzi = '我们班一共有三十位留学生，其中有十二位来自欧洲国家。',
      example_pinyin = 'Wǒmen bān yígòng yǒu sānshí wèi liúxuéshēng, qízhōng yǒu shí’èr wèi láizì Ōuzhōu guójiā.',
      example_vi = 'Lớp chúng tôi có tổng cộng ba mươi bạn lưu học sinh, trong số đó có mười hai bạn đến từ các quốc gia châu Âu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们班一共有三十位留学生，其中有十二位来自欧洲国家。', 'Wǒmen bān yígòng yǒu sānshí wèi liúxuéshēng, qízhōng yǒu shí’èr wèi láizì Ōuzhōu guójiā.', 'Lớp chúng tôi có tổng cộng ba mươi bạn lưu học sinh, trong số đó có mười hai bạn đến từ các quốc gia châu Âu.', 'basic', 1),
        (v_id, '本届国际高新技术交易博览会集中展示了上千项突破性前沿成果，其中百余项属于全球首创并拥有完全自主知识产权。', 'Běn jiè guójì gāoxīnjìshù jiāoyì bólǎnhuì jízhōng zhǎnshì le shàng qiān xiàng tūpòxìng qiányán chéngguǒ, qízhōng bǎi yú xiàng shǔyú quánqiú shǒuchuàng bìng yōngyǒu wánquán zìzhǔ zhīshi chǎnquán.', 'Hội chợ triển lãm giao dịch công nghệ cao quốc tế kỳ này đã trưng bày tập trung hơn một ngàn thành quả tiên phong mang tính đột phá, trong đó có hơn một trăm hạng mục thuộc diện sáng tạo đầu tiên trên toàn cầu và sở hữu quyền sở hữu trí tuệ hoàn toàn độc lập.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [起到] (qǐdào) - đóng vai trò, phát huy tác dụng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '起到' AND pinyin = 'qǐdào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '起到'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'qǐdào',
      meaning_vi = 'đóng vai trò, phát huy tác dụng',
      example_hanzi = '每天坚持慢跑半小时，对于增强心肺功能能够起到非常显著的作用。',
      example_pinyin = 'Měitiān jiānchí mànpǎo bàn xiǎoshí, duìyú zēngqiáng xīn-fèi gōngnéng nénggòu qǐdào fēicháng xiǎnzhù de zuòyòng.',
      example_vi = 'Mỗi ngày kiên trì chạy bộ chậm nửa tiếng có thể phát huy tác dụng vô cùng rõ rệt đối với việc tăng cường chức năng tim phổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天坚持慢跑半小时，对于增强心肺功能能够起到非常显著的作用。', 'Měitiān jiānchí mànpǎo bàn xiǎoshí, duìyú zēngqiáng xīn-fèi gōngnéng nénggòu qǐdào fēicháng xiǎnzhù de zuòyòng.', 'Mỗi ngày kiên trì chạy bộ chậm nửa tiếng có thể phát huy tác dụng vô cùng rõ rệt đối với việc tăng cường chức năng tim phổi.', 'basic', 1),
        (v_id, '国家设立国家级战略性产业投资基金，在引导撬动海量社会多元资本投向原始硬科技创新领域中起到了关键杠杆作用。', 'Guójiā shèlì guójiājí zhànlüèxìng chǎnyè tóuzī jījīn, zài yǐndǎo qiàodòng hǎiliàng shèhuì duōyuán zīběn tóu xiàng yuánshǐ yì kējì chuàngxīn lǐngyù zhōng qǐdào le guānjiàn gànggǎn zuòyòng.', 'Nhà nước thành lập quỹ đầu tư công nghiệp mang tính chiến lược cấp quốc gia đã đóng vai trò đòn bẩy then chốt trong việc dẫn dắt và kích hoạt dòng vốn đa dạng khổng lồ của xã hội đầu tư vào lĩnh vực đổi mới công nghệ cốt lõi nguyên bản.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [气] (qì) - khí, không khí, hơi; cơn giận; tức giận [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '气' AND pinyin = 'qì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '气'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'qì',
      meaning_vi = 'khí, không khí, hơi; cơn giận; tức giận',
      example_hanzi = '他因为朋友无缘无故爽约而生了一肚子的气。',
      example_pinyin = 'Tā yīnwèi péngyou wúyuán-wúgù shuǎngyuē ér shēng le yí dùzi de qì.',
      example_vi = 'Anh ấy vì người bạn vô duyên vô cớ lỡ hẹn mà bực tức đầy một bụng giận dỗi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他因为朋友无缘无故爽约而生了一肚子的气。', 'Tā yīnwèi péngyou wúyuán-wúgù shuǎngyuē ér shēng le yí dùzi de qì.', 'Anh ấy vì người bạn vô duyên vô cớ lỡ hẹn mà bực tức đầy một bụng giận dỗi.', 'basic', 1),
        (v_id, '在极其寒冷漫长的北方冬季，天然气管网安全稳定足额保供关系到千家万户市民温暖过冬的切身民生福祉。', 'Zài jíqí hánlěng màncháng de běifāng dōngjì, tiānránqì guǎnwǎng ānquán wěndìng zú’é bǎogōng guānxì dào qiānjiā-wànhù shìmín wēnnuǎn guò dōng de qièshēn mínshēng fúzhǐ.', 'Trong mùa đông phía bắc lạnh giá và dài dằng dặc, việc cung ứng an toàn ổn định đầy đủ lượng khí của mạng lưới đường ống khí đốt thiên nhiên liên quan thiết thực tới phúc lợi dân sinh sưởi ấm qua mùa đông của hàng vạn mái ấm thị dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [气候] (qìhòu) - khí hậu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '气候' AND pinyin = 'qìhòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '气候'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qìhòu',
      meaning_vi = 'khí hậu',
      example_hanzi = '昆明四季如春，气候非常宜人，被誉为中国的“春城”。',
      example_pinyin = 'Kūnmíng sìjì-rúchūn, qìhòu fēicháng yírén, bèi yù wéi Zhōngguó de “Chūnchéng”.',
      example_vi = 'Côn Minh bốn mùa như xuân, khí hậu vô cùng dễ chịu, được mệnh danh là "thành phố mùa xuân" của Trung Quốc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '昆明四季如春，气候非常宜人，被誉为中国的“春城”。', 'Kūnmíng sìjì-rúchūn, qìhòu fēicháng yírén, bèi yù wéi Zhōngguó de “Chūnchéng”.', 'Côn Minh bốn mùa như xuân, khí hậu vô cùng dễ chịu, được mệnh danh là "thành phố mùa xuân" của Trung Quốc.', 'basic', 1),
        (v_id, '国际社会呼吁各国携手全面落实《巴黎协定》，积极推进低碳绿色能源转型以共同应对全球气候变暖危机。', 'Guójì shèhuì hūyù gè guó xiéshǒu quánmiàn luòshí “Bālí Xiédìng”, jījí tuījìn dītàn lǜsè néngyuán zhuǎnxíng yǐ gòngtóng yìngduì quánqiú qìhòu biànnuǎn wēijī.', 'Cộng đồng quốc tế kêu gọi các nước chung tay thực thi toàn diện "Hiệp định Paris", tích cực thúc đẩy chuyển đổi năng lượng xanh giảm phát thải carbon để cùng nhau ứng phó với cuộc khủng hoảng biến đổi khí hậu toàn cầu ấm lên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [汽水] (qìshuǐ) - nước có ga, nước ngọt có ga [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '汽水' AND pinyin = 'qìshuǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '汽水'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qìshuǐ',
      meaning_vi = 'nước có ga, nước ngọt có ga',
      example_hanzi = '夏天打完篮球之后喝上一罐冰镇橘子汽水，感觉格外爽快。',
      example_pinyin = 'Xiàtiān dǎ wán lánqiú zhīhòu hē shàng yí guàn bīngzhèn júzi qìshuǐ, gǎnjué géwài shuǎngkuai.',
      example_vi = 'Mùa hè sau khi chơi bóng rổ xong uống một lon nước ngọt vị cam ướp lạnh, cảm thấy sảng khoái vô cùng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夏天打完篮球之后喝上一罐冰镇橘子汽水，感觉格外爽快。', 'Xiàtiān dǎ wán lánqiú zhīhòu hē shàng yí guàn bīngzhèn júzi qìshuǐ, gǎnjué géwài shuǎngkuai.', 'Mùa hè sau khi chơi bóng rổ xong uống một lon nước ngọt vị cam ướp lạnh, cảm thấy sảng khoái vô cùng.', 'basic', 1),
        (v_id, '随着当代年轻消费者对健康养生理念的追求，主打零糖零脂零卡的新型果汁无糖苏打汽水在快消品市场上迅速走红。', 'Suízhe dāngdài niánqīng xiāofèizhě duì jiànkāng yǎngshēng lǐniàn de zhuīqiú, zhǔdǎ líng táng líng zhī líng kǎ de xīnxíng guǒzhī wú táng sūdǎ qìshuǐ zài kuàixiāopǐn shìchǎng shang xùnsù zǒuhóng.', 'Cùng với việc người tiêu dùng trẻ tuổi đương đại theo đuổi các quan niệm chăm sóc sức khỏe, dòng sản phẩm nước ngọt soda không đường bổ sung nước ép hoa quả mới nổi bật với tiêu chí không đường không mỡ không calo đã nhanh chóng gây sốt trên thị trường hàng tiêu dùng nhanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [气温] (qìwēn) - nhiệt độ không khí, nhiệt độ ngoài trời [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '气温' AND pinyin = 'qìwēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '气温'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qìwēn',
      meaning_vi = 'nhiệt độ không khí, nhiệt độ ngoài trời',
      example_hanzi = '据中央气象台预报，受强冷空气影响明天本地气温将骤降十度。',
      example_pinyin = 'Jù Zhōngyāng Qìxiàngtái yùbào, shòu qiáng lěng kōngqì yǐngxiǎng míngtiān běndì qìwēn jiāng zhòujiàng shí dù.',
      example_vi = 'Theo dự báo của Đài Khí tượng Trung ương, do ảnh hưởng của không khí lạnh mạnh ngày mai nhiệt độ địa phương sẽ giảm đột ngột 10 độ C.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '据中央气象台预报，受强冷空气影响明天本地气温将骤降十度。', 'Jù Zhōngyāng Qìxiàngtái yùbào, shòu qiáng lěng kōngqì yǐngxiǎng míngtiān běndì qìwēn jiāng zhòujiàng shí dù.', 'Theo dự báo của Đài Khí tượng Trung ương, do ảnh hưởng của không khí lạnh mạnh ngày mai nhiệt độ địa phương sẽ giảm đột ngột 10 độ C.', 'basic', 1),
        (v_id, '在夏季持续极端高温干旱天气影响下，局部地区电网用电负荷与农业灌溉用水需求创下了历史同期最高纪录。', 'Zài xiàjì chíxù jíduān gāowēn gānhàn tiānqì yǐngxiǎng xià, júbù dìqū diànwǎng yòngdiàn fùhè yǔ nóngyè guàngài yòngshuǐ xūqiú chuàng xià le lìshǐ tóngqī zuì gāo jìlù.', 'Dưới ảnh hưởng của thời tiết hạn hán nắng nóng cực đoan kéo dài vào mùa hè, phụ tải tiêu thụ điện của mạng lưới điện và nhu cầu nước tưới tiêu nông nghiệp tại các khu vực cục bộ đã lập kỷ lục cao nhất lịch sử cùng kỳ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [千克] (qiānkè) - ki-lô-gam (kg) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '千克' AND pinyin = 'qiānkè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '千克'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'qiānkè',
      meaning_vi = 'ki-lô-gam (kg)',
      example_hanzi = '他在水果超市里买了三千克新鲜红富士苹果。',
      example_pinyin = 'Tā zài shuǐguǒ chāoshì lǐ mǎi le sān qiānkè xīnxiān hóngfùshì píngguǒ.',
      example_vi = 'Anh ấy đã mua ba ki-lô-gam táo Fuji tươi tại siêu thị hoa quả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在水果超市里买了三千克新鲜红富士苹果。', 'Tā zài shuǐguǒ chāoshì lǐ mǎi le sān qiānkè xīnxiān hóngfùshì píngguǒ.', 'Anh ấy đã mua ba ki-lô-gam táo Fuji tươi tại siêu thị hoa quả.', 'basic', 1),
        (v_id, '航天飞船有效载荷指标极其严苛，科研人员竭尽全力优化结构设计，将新型星载核心仪器的总重量减轻了数十千克。', 'Hángtiān fēichuán yǒuxiào zàihè zhǐbiāo jíqí yánkē, kēyán rényuán jiéjìn-quánlì yōuhuà jiégòu shèjì, jiāng xīnxíng xīngzài héxīn yíqì de zǒng zhòngliàng jiǎnqīng le shù shí qiānkè.', 'Chỉ tiêu trọng tải hữu ích của tàu vũ trụ cực kỳ khắt khe, các nhà nghiên cứu khoa học đã dốc toàn lực tối ưu hóa thiết kế kết cấu, làm giảm bớt vài chục ki-lô-gam tổng trọng lượng của các thiết bị cốt lõi gắn trên vệ tinh kiểu mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [千万] (qiānwàn) - nhất thiết, tuyệt đối (khuyên can); hàng chục triệu [Phó từ / Số từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '千万' AND pinyin = 'qiānwàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '千万'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Số từ',
      pinyin = 'qiānwàn',
      meaning_vi = 'nhất thiết, tuyệt đối (khuyên can); hàng chục triệu',
      example_hanzi = '道路千万条，安全第一条，开车出行千万不要酒后驾驶。',
      example_pinyin = 'Dàolù qiānwàn tiáo, ānquán dì-yī tiáo, kāichē chūxíng qiānwàn bú yào jiǔhòu jiàshǐ.',
      example_vi = 'Đường đi có vạn nẻo, an toàn là số một, lái xe ra đường nhất thiết tuyệt đối không được lái xe sau khi uống rượu bia.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '道路千万条，安全第一条，开车出行千万不要酒后驾驶。', 'Dàolù qiānwàn tiáo, ānquán dì-yī tiáo, kāichē chūxíng qiānwàn bú yào jiǔhòu jiàshǐ.', 'Đường đi có vạn nẻo, an toàn là số một, lái xe ra đường nhất thiết tuyệt đối không được lái xe sau khi uống rượu bia.', 'basic', 1),
        (v_id, '在签署重大跨国知识产权转让合同前，法务团队千万要核查专利权属与国际排他性授权范围，切忌粗心大意。', 'Zài qiānshǔ zhòngdà kuàguó zhīshi chǎnquán zhuǎnràng hétong qián, fǎwù tuánduì qiānwàn yào héchá zhuānlì quánshǔ yǔ guójì páitāxìng shòuquán fànwéi, qièjì cūxīn-dàyì.', 'Trước khi ký kết hợp đồng chuyển nhượng quyền sở hữu trí tuệ xuyên quốc gia quan trọng, đội ngũ pháp chế nhất thiết tuyệt đối phải thẩm định quyền sở hữu sáng chế và phạm vi cấp phép độc quyền quốc tế, tránh lơ là bất cẩn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [签证] (qiānzhèng) - thị thực, visa; cấp thị thực [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '签证' AND pinyin = 'qiānzhèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '签证'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'qiānzhèng',
      meaning_vi = 'thị thực, visa; cấp thị thực',
      example_hanzi = '准备出国留学前，请务必提前准备齐全所需材料办理留学签证。',
      example_pinyin = 'Zhǔnbèi chūguó liúxué qián, qǐng wùbì tíqián zhǔnbèi qíquán suǒ xū cáiliào bànlǐ liúxué qiānzhèng.',
      example_vi = 'Trước khi chuẩn bị ra nước ngoài du học, xin nhất thiết phải chuẩn bị đầy đủ các giấy tờ cần thiết từ trước để làm thủ tục xin visa du học.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '准备出国留学前，请务必提前准备齐全所需材料办理留学签证。', 'Zhǔnbèi chūguó liúxué qián, qǐng wùbì tíqián zhǔnbèi qíquán suǒ xū cáiliào bànlǐ liúxué qiānzhèng.', 'Trước khi chuẩn bị ra nước ngoài du học, xin nhất thiết phải chuẩn bị đầy đủ các giấy tờ cần thiết từ trước để làm thủ tục xin visa du học.', 'basic', 1),
        (v_id, '为促进中外人员往来与经贸合作，我国对多个国家持续扩大单方面免签与过境免免签政策覆盖范围。', 'Wèi cùjìn zhōngwài rényuán wǎnglái yǔ jīngmào hézuò, wǒ guó duì duō gè guójiā chíxù kuòdà dānfāngmiàn miǎnqiān yǔ guòjìng miǎnqiān zhèngcè fùgài fànwéi.', 'Để thúc đẩy việc giao lưu nhân dân và hợp tác kinh tế thương mại giữa Trung Quốc và nước ngoài, nước ta liên tục mở rộng phạm vi bao phủ chính sách miễn thị thực đơn phương và miễn thị thực quá cảnh đối với nhiều quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [前方] (qiánfāng) - phía trước, đằng trước [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '前方' AND pinyin = 'qiánfāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '前方'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qiánfāng',
      meaning_vi = 'phía trước, đằng trước',
      example_hanzi = '车载导航语音提示：前方两公里处有道路施工，请减速慢行。',
      example_pinyin = 'Chēzài dǎoháng yǔyīn tíshì: Qiánfāng liǎng gōnglǐ chù yǒu dàolù shīgōng, qǐng jiǎnsù mànxíng.',
      example_vi = 'Giọng nói định vị trên ô tô nhắc nhở: Cách hai ki-lô-mét phía trước có công trình thi công đường xá, xin vui lòng giảm tốc độ đi chậm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '车载导航语音提示：前方两公里处有道路施工，请减速慢行。', 'Chēzài dǎoháng yǔyīn tíshì: Qiánfāng liǎng gōnglǐ chù yǒu dàolù shīgōng, qǐng jiǎnsù mànxíng.', 'Giọng nói định vị trên ô tô nhắc nhở: Cách hai ki-lô-mét phía trước có công trình thi công đường xá, xin vui lòng giảm tốc độ đi chậm.', 'basic', 1),
        (v_id, '无论前进道路的前方还有多少艰难险阻与风高浪急的考验，全体科研人员始终秉持攀登科学高峰的坚定信念一往无前。', 'Wúlùn qiánjìn dàolù de qiánfāng hái yǒu duōshao jiānnán-xiǎnzǔ yǔ fēnggāo-làngjí de kǎoyàn, quántǐ kēyán rényuán shǐzhōng bǐngchí pāndēng kēxué gāofēng de jiāndìng xìnniàn yìwǎng-wúqián.', 'Bất kể phía trước trên con đường tiến lên còn biết bao gian nan trắc trở và những thử thách sóng to gió lớn, toàn thể các nhà nghiên cứu khoa học luôn giữ vững niềm tin kiên định chinh phục đỉnh cao khoa học để dũng cảm tiến về phía trước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [前后] (qiánhòu) - trước sau; khoảng chừng (thời gian trước sau) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '前后' AND pinyin = 'qiánhòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '前后'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qiánhòu',
      meaning_vi = 'trước sau; khoảng chừng (thời gian trước sau)',
      example_hanzi = '每年清明节前后，江南一带正是采摘明前春茶的最佳时节。',
      example_pinyin = 'Měi nián Qīngmíngjié qiánhòu, Jiāngnán yídài zhèng shì cǎizhāi míngqián chūnchá de zuì jiā shíjié.',
      example_vi = 'Hàng năm vào khoảng trước sau tết Thanh minh, vùng Giang Nam chính là thời điểm đẹp nhất để thu hái trà xuân trước tiết Thanh minh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年清明节前后，江南一带正是采摘明前春茶的最佳时节。', 'Měi nián Qīngmíngjié qiánhòu, Jiāngnán yídài zhèng shì cǎizhāi míngqián chūnchá de zuì jiā shíjié.', 'Hàng năm vào khoảng trước sau tết Thanh minh, vùng Giang Nam chính là thời điểm đẹp nhất để thu hái trà xuân trước tiết Thanh minh.', 'basic', 1),
        (v_id, '在重大航天发射任务执行的前后全流程中，数以千计的地面监测控制测控台站与远洋测量船实施了全天候无缝精密测控保障。', 'Zài zhòngdà hángtiān fāshè rènwu zhíxíng de qiánhòu quán liúchéng zhōng, shù yǐ qiān jì de dìmiàn jiāncè kòngzhì cèkòng táizhàn yǔ yuǎnyáng cèliángchuán shíshī le quántiānhòu wúfèng jīngmì cèkòng bǎozhàng.', 'Trong toàn bộ quy trình trước sau của việc thực hiện nhiệm vụ phóng hàng không vũ trụ trọng đại, hàng nghìn trạm đo đạc kiểm soát mặt đất và tàu đo lường viễn dương đã thực thi bảo đảm đo kiểm chính xác liền mạch suốt ngày đêm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [强] (qiáng) - mạnh mẽ, kiên cường; tốt hơn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '强' AND pinyin = 'qiáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '强'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'qiáng',
      meaning_vi = 'mạnh mẽ, kiên cường; tốt hơn',
      example_hanzi = '他的身体素质和体能非常强，连续跑了五公里也没有觉得喘。',
      example_pinyin = 'Tā de shēntǐ sùzhì hé tǐnéng fēicháng qiáng, liánxù pǎo le wǔ gōnglǐ yě méiyǒu juéde chuǎn.',
      example_vi = 'Tố chất cơ thể và thể lực của anh ấy rất khỏe mạnh, chạy liên tục 5 km cũng không hề cảm thấy hụt hơi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他的身体素质和体能非常强，连续跑了五公里也没有觉得喘。', 'Tā de shēntǐ sùzhì hé tǐnéng fēicháng qiáng, liánxù pǎo le wǔ gōnglǐ yě méiyǒu juéde chuǎn.', 'Tố chất cơ thể và thể lực của anh ấy rất khỏe mạnh, chạy liên tục 5 km cũng không hề cảm thấy hụt hơi.', 'basic', 1),
        (v_id, '强大的国家战略科技力量是维护国家主权、安全以及发展利益的坚强基石与核心战略支撑。', 'Qiángdà de guójiā zhànlüè kējì lìliàng shì wéihù guójiā zhǔquán, ānquán yǐjí fāzhǎn lìyì de jiānqiáng jīshí yǔ héxīn zhànlüè zhīchēng.', 'Lực lượng khoa học công nghệ mang tính chiến lược quốc gia hùng mạnh chính là hòn đá tảng kiên cường và điểm tựa chiến lược cốt lõi để giữ gìn chủ quyền, an ninh cũng như lợi ích phát triển của đất nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [敲] (qiāo) - gõ, gõ cửa, đập [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '敲' AND pinyin = 'qiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '敲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'qiāo',
      meaning_vi = 'gõ, gõ cửa, đập',
      example_hanzi = '进入别人的办公室或房间之前，请先轻轻敲门以示礼貌。',
      example_pinyin = 'Jìnrù biérén de bàngōngshì huò fángjiān zhīqián, qǐng xiān qīngqīng qiāo mén yǐ shì lǐmào.',
      example_vi = 'Trước khi bước vào văn phòng hay phòng riêng của người khác, xin hãy gõ cửa nhẹ nhàng để thể hiện phép lịch sự.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '进入别人的办公室或房间之前，请先轻轻敲门以示礼貌。', 'Jìnrù biérén de bàngōngshì huò fángjiān zhīqián, qǐng xiān qīngqīng qiāo mén yǐ shì lǐmào.', 'Trước khi bước vào văn phòng hay phòng riêng của người khác, xin hãy gõ cửa nhẹ nhàng để thể hiện phép lịch sự.', 'basic', 1),
        (v_id, '随着新年钟声敲响，成千上万的市民齐聚城市中心广场，欢声笑语共同迎接新一年的到来。', 'Suízhe xīnnián zhōngshēng qiāo xiǎng, chéngqiān-shàngwàn de shìmín qíjù chéngshì zhōngxīn guǎngchǎng, huānshēng-xiàoyǔ gòngtóng yíngjiē xīn yì nián de dàolái.', 'Cùng với tiếng chuông năm mới vang lên, hàng vạn người dân tề tựu tại quảng trường trung tâm thành phố, trong tiếng cười vui rộn rã cùng nhau nghênh đón năm mới đã đến.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [桥] (qiáo) - cây cầu, cầu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '桥' AND pinyin = 'qiáo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '桥'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qiáo',
      meaning_vi = 'cây cầu, cầu',
      example_hanzi = '赵州桥是一座建于隋代具有一千四百多年悠久历史的古老石拱桥。',
      example_pinyin = 'Zhàozhōu Qiáo shì yí zuò jiàn yú Suídài jùyǒu yì qiān sì bǎi duō nián yōujiǔ lìshǐ de gǔlǎo shí gǒngqiáo.',
      example_vi = 'Cầu Triệu Châu là cây cầu vòm đá cổ kính được xây dựng vào thời nhà Tùy có bề dày lịch sử hơn 1.400 năm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '赵州桥是一座建于隋代具有一千四百多年悠久历史的古老石拱桥。', 'Zhàozhōu Qiáo shì yí zuò jiàn yú Suídài jùyǒu yì qiān sì bǎi duō nián yōujiǔ lìshǐ de gǔlǎo shí gǒngqiáo.', 'Cầu Triệu Châu là cây cầu vòm đá cổ kính được xây dựng vào thời nhà Tùy có bề dày lịch sử hơn 1.400 năm.', 'basic', 1),
        (v_id, '全长五十五公里的港珠澳跨海大桥作为世界上总体跨度最长的跨海大桥，被誉为现代世界工程建设史上的“新七大奇迹”之一。', 'Quán cháng wǔshíwǔ gōnglǐ de Gǎng-Zhū-Ào kuàhǎi dàqiáo zuòwéi shìjiè shang zǒngtǐ kuàdù zuì cháng de kuàhǎi dàqiáo, bèi yù wéi xiàndài shìjiè gōngchéng jiànshè shǐ shang de “xīn qī dà qíjì” zhīyī.', 'Cầu vượt biển Hồng Kông - Chu Hải - Ma Cao dài 55 km với tư cách là cây cầu vượt biển có khẩu độ tổng thể dài nhất thế giới, được ca ngợi là một trong "bảy kỳ quan mới" trong lịch sử xây dựng công trình thế giới hiện đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [巧] (qiǎo) - khéo léo, tài tình; tình cờ, trùng hợp [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '巧' AND pinyin = 'qiǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '巧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'qiǎo',
      meaning_vi = 'khéo léo, tài tình; tình cờ, trùng hợp',
      example_hanzi = '真巧啊！我正打算给你打电话，没想到一出门就碰见你了。',
      example_pinyin = 'Zhēn qiǎo a! Wǒ zhèng dǎsuàn gěi nǐ dǎ diànhuà, méi xiǎngdào yì chūmén jiù pèngjiàn nǐ le.',
      example_vi = 'Khéo quá đi mất! Tôi đang định gọi điện thoại cho bạn, không ngờ vừa bước chân ra cửa đã chạm mặt bạn rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '真巧啊！我正打算给你打电话，没想到一出门就碰见你了。', 'Zhēn qiǎo a! Wǒ zhèng dǎsuàn gěi nǐ dǎ diànhuà, méi xiǎngdào yì chūmén jiù pèngjiàn nǐ le.', 'Khéo quá đi mất! Tôi đang định gọi điện thoại cho bạn, không ngờ vừa bước chân ra cửa đã chạm mặt bạn rồi.', 'basic', 1),
        (v_id, '民间民间非遗刺绣大师凭借巧夺天工的精湛针法技艺，在薄如蝉翼的丝绸织物上生动绣出了栩栩如生的百鸟朝凤图。', 'Mínjiān fēiyí cìxiù dàshī píngjiè qiǎoduó-tiāngōng de jīngzhàn zhēnfǎ jìyì, zài báo rú chányì de sīchóu zhīwù shang shēngdòng xiù chū le xǔxǔ-rúshēng de bǎi niǎo cháo fèng tú.', 'Đại sư thêu ren di sản phi vật thể dân gian nhờ vào tay nghề mũi kim tinh xảo đoạt cả công trời, đã thêu nên bức tranh bách điểu triều phụng sống động như thật trên tấm vải lụa mỏng tang như cánh ve.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [巧克力] (qiǎokèlì) - sô-cô-la (chocolate) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '巧克力' AND pinyin = 'qiǎokèlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '巧克力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qiǎokèlì',
      meaning_vi = 'sô-cô-la (chocolate)',
      example_hanzi = '情人节那天，他为心爱的女友精心挑选了一盒心形黑巧克力。',
      example_pinyin = 'Qíngrénjié nà tiān, tā wèi xīn’ài de nǚyǒu jīngxīn tiāoxuǎn le yì hé xīnxíng hēi qiǎokèlì.',
      example_vi = 'Vào ngày lễ Tình nhân, anh ấy đã dày công chọn cho người bạn gái thân yêu một hộp sô-cô-la đen hình trái tim.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '情人节那天，他为心爱的女友精心挑选了一盒心形黑巧克力。', 'Qíngrénjié nà tiān, tā wèi xīn’ài de nǚyǒu jīngxīn tiāoxuǎn le yì hé xīnxíng hēi qiǎokèlì.', 'Vào ngày lễ Tình nhân, anh ấy đã dày công chọn cho người bạn gái thân yêu một hộp sô-cô-la đen hình trái tim.', 'basic', 1),
        (v_id, '随着大众对健康天然食品消费偏好的提升，富含天然可可多酚且不添加代可可脂的高纯度纯黑巧克力销量大幅增长。', 'Suízhe dàzhòng duì jiànkāng tiānrán shípǐn xiāofèi piānhào de tíshēng, fùhán tiānrán kěkě duōfēn qiě bù tiānjiā dài kěkězhī de gāo-chúndù chún hēi qiǎokèlì xiāoliàng dàfú zēngzhǎng.', 'Cùng với sự gia tăng thị hiếu tiêu dùng của đại chúng đối với thực phẩm tự nhiên lành mạnh, doanh số của dòng sô-cô-la đen nguyên chất độ tinh khiết cao giàu polyphenol cacao tự nhiên và không chứa bơ cacao thay thế đã tăng trưởng vượt bậc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [亲戚] (qīnqi) - bà con, họ hàng, thân thích [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '亲戚' AND pinyin = 'qīnqi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '亲戚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qīnqi',
      meaning_vi = 'bà con, họ hàng, thân thích',
      example_hanzi = '每年春节长假期间，全家人都会走亲访友，向各位亲戚拜年。',
      example_pinyin = 'Měi nián Chūnjié chángjià qījiān, quán jiā rén dōu huì zǒu qīn fǎng yǒu, xiàng gèwèi qīnqi bài nián.',
      example_vi = 'Hàng năm trong kỳ nghỉ Tết dài ngày, cả gia đình đều đi thăm hỏi người thân bạn bè, chúc tết các vị họ hàng bà con.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年春节长假期间，全家人都会走亲访友，向各位亲戚拜年。', 'Měi nián Chūnjié chángjià qījiān, quán jiā rén dōu huì zǒu qīn fǎng yǒu, xiàng gèwèi qīnqi bài nián.', 'Hàng năm trong kỳ nghỉ Tết dài ngày, cả gia đình đều đi thăm hỏi người thân bạn bè, chúc tết các vị họ hàng bà con.', 'basic', 1),
        (v_id, '传统宗族文化中互助互济的亲戚血脉纽带，在现代快节奏原子化都市生活中正在转化为更加注重情感共鸣与边界感的新型社交形态。', 'Chuántǒng zōngzú wénhuà zhōng hùzhù-hùjì de qīnqi xuèmài niǔdài, zài xiàndài kuài jiézòu yuánzǐhuà dūshì shēnghuó zhōng zhèngzài zhuǎnhuà wéi gèngjiā zhùzhòng qínggǎn gòngmíng yǔ biānjiègǎn de xīnxíng shèjiāo xíngtài.', 'Mối liên kết huyết mạch bà con thân thích đùm bọc tương trợ trong văn hóa gia tộc dòng họ truyền thống, giữa đời sống đô thị nguyên tử hóa nhịp độ nhanh hiện đại đang chuyển hóa thành hình thái giao tiếp mới chú trọng hơn vào sự đồng cảm cảm xúc và cảm giác ranh giới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [琴] (qín) - đàn, nhạc cụ (cổ cầm, đàn tranh, dương cầm) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '琴' AND pinyin = 'qín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '琴'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qín',
      meaning_vi = 'đàn, nhạc cụ (cổ cầm, đàn tranh, dương cầm)',
      example_hanzi = '在中国古代文人雅士的修养中，“琴棋书画”被列为四雅之首。',
      example_pinyin = 'Zài Zhōngguó gǔdài wénrén-yǎshì de xiūyǎng zhōng, “qín-qí-shū-huà” bèi liè wéi sì yǎ zhī shǒu.',
      example_vi = 'Trong sự tu dưỡng của các văn nhân nhã sĩ thời cổ đại Trung Quốc, "cầm kỳ thi họa" được xếp đứng đầu trong tứ nhã.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在中国古代文人雅士的修养中，“琴棋书画”被列为四雅之首。', 'Zài Zhōngguó gǔdài wénrén-yǎshì de xiūyǎng zhōng, “qín-qí-shū-huà” bèi liè wéi sì yǎ zhī shǒu.', 'Trong sự tu dưỡng của các văn nhân nhã sĩ thời cổ đại Trung Quốc, "cầm kỳ thi họa" được xếp đứng đầu trong tứ nhã.', 'basic', 1),
        (v_id, '古琴艺术作为人类非物质文化遗产代表作，其苍古幽微的琴音蕴含着人与自然天人合一的东方深刻哲学思想。', 'Gǔqín yìshù zuòwéi rénlèi fēiwùzhì wénhuà yíchǎn dàibiǎozuò, qí cānggǔ-yōuwēi de qínyīn yùnhán zhe rén yǔ zìrán tiānrén-héyī de Dōngfāng shēnkè zhéxué sīxiǎng.', 'Nghệ thuật cổ cầm với tư cách là kiệt tác đại diện di sản văn hóa phi vật thể của nhân loại, tiếng đàn trầm mặc u hoài của nó ẩn chứa tư tưởng triết học phương Đông sâu sắc về sự hòa hợp thiên nhân hợp nhất giữa con người và thiên nhiên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [轻] (qīng) - nhẹ, không nặng; nhẹ nhàng, xem nhẹ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '轻' AND pinyin = 'qīng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '轻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'qīng',
      meaning_vi = 'nhẹ, không nặng; nhẹ nhàng, xem nhẹ',
      example_hanzi = '这台新上市的超薄便携式笔记本电脑重量非常轻，非常适合出差携带。',
      example_pinyin = 'Zhè tái xīn shàngshì de chāobáo biànxiéshì bǐjìběn diànnǎo zhòngliàng fēicháng qīng, fēicháng shìhé chūchāi xiédài.',
      example_vi = 'Chiếc máy tính xách tay siêu mỏng nhẹ tiện dụng mới ra mắt này trọng lượng vô cùng nhẹ, rất thích hợp mang theo khi đi công tác.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这台新上市的超薄便携式笔记本电脑重量非常轻，非常适合出差携带。', 'Zhè tái xīn shàngshì de chāobáo biànxiéshì bǐjìběn diànnǎo zhòngliàng fēicháng qīng, fēicháng shìhé chūchāi xiédài.', 'Chiếc máy tính xách tay siêu mỏng nhẹ tiện dụng mới ra mắt này trọng lượng vô cùng nhẹ, rất thích hợp mang theo khi đi công tác.', 'basic', 1),
        (v_id, '汽车制造行业通过广泛应用超高强钢与轻质碳纤维复合材料，成功实现了整车结构轻量化并大幅降低了能耗。', 'Qìchē zhìzào hángyè tōngguò guǎngfàn yìngyòng chāogāoqiáng gāng yǔ qīngzhì tànxiānwéi fùhé cáiliào, chénggōng shíxiàn le zhěng chē jiégòu qīngliànghuà bìng dàfú jiàngdī le nénghào.', 'Ngành chế tạo ô tô thông qua việc ứng dụng rộng rãi thép siêu cường lực và vật liệu composite sợi carbon siêu nhẹ, đã hiện thực hóa thành công việc nhẹ hóa kết cấu toàn bộ thân xe và cắt giảm đáng kể mức tiêu hao năng lượng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [青年] (qīngnián) - thanh niên, giới trẻ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '青年' AND pinyin = 'qīngnián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '青年'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qīngnián',
      meaning_vi = 'thanh niên, giới trẻ',
      example_hanzi = '五四青年节前夕，大学校园里举办了朝气蓬勃的青年科技文化节。',
      example_pinyin = 'Wǔsì Qīngniánjié qiánxī, dàxué xiàoyuán lǐ jǔbàn le zhāoqì-péngbó de qīngnián kējì wénhuàjié.',
      example_vi = 'Trước thềm ngày Tết Thanh niên mùng 4 tháng 5, trong khuôn viên trường đại học đã tổ chức lễ hội văn hóa khoa học công nghệ thanh niên tràn đầy sức sống tươi trẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '五四青年节前夕，大学校园里举办了朝气蓬勃的青年科技文化节。', 'Wǔsì Qīngniánjié qiánxī, dàxué xiàoyuán lǐ jǔbàn le zhāoqì-péngbó de qīngnián kējì wénhuàjié.', 'Trước thềm ngày Tết Thanh niên mùng 4 tháng 5, trong khuôn viên trường đại học đã tổ chức lễ hội văn hóa khoa học công nghệ thanh niên tràn đầy sức sống tươi trẻ.', 'basic', 1),
        (v_id, '青年一代有理想、有本领、有担当，国家就有前途，民族就有希望，广大青年应当勇立时代潮头奋发有为。', 'Qīngnián yídài yǒu lǐxiǎng, yǒu běnlǐng, yǒu dāndāng, guójiā jiù yǒu qiántú, mínzú jiù yǒu xīwàng, guǎngdà qīngnián yīngdāng yǒng lì shídài cháotóu fènfā-yǒuwéi.', 'Thế hệ trẻ có lý tưởng, có bản lĩnh, có trách nhiệm gánh vác thì đất nước mới có tiền đồ, dân tộc mới có hy vọng, đông đảo thanh niên cần dũng cảm đứng đầu ngọn sóng thời đại để nỗ lực vươn lên làm nên việc lớn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [轻松] (qīngsōng) - thoải mái, nhẹ nhõm, thư thái [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '轻松' AND pinyin = 'qīngsōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '轻松'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'qīngsōng',
      meaning_vi = 'thoải mái, nhẹ nhõm, thư thái',
      example_hanzi = '紧张的高考结束后，他终于可以彻底轻松一下，去海边度个长假。',
      example_pinyin = 'Jǐnzhāng de gāokǎo jiéshù hòu, tā zhōngyú kěyǐ chèdǐ qīngsōng yíxià, qù hǎibiān dù gè chángjià.',
      example_vi = 'Kỳ thi đại học căng thẳng kết thúc rồi, cậu ấy cuối cùng có thể thoải mái nhẹ nhõm hoàn toàn, đi biển nghỉ một kỳ nghỉ dài.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '紧张的高考结束后，他终于可以彻底轻松一下，去海边度个长假。', 'Jǐnzhāng de gāokǎo jiéshù hòu, tā zhōngyú kěyǐ chèdǐ qīngsōng yíxià, qù hǎibiān dù gè chángjià.', 'Kỳ thi đại học căng thẳng kết thúc rồi, cậu ấy cuối cùng có thể thoải mái nhẹ nhõm hoàn toàn, đi biển nghỉ một kỳ nghỉ dài.', 'basic', 1),
        (v_id, '先进的低代码开发平台使得即使没有深厚编程底子的业务人员，也能够轻松搭建起符合个性化管理需求的数字化应用工具。', 'Xiānjìn de dīdàimǎ kāifā píngtái shǐde jíshǐ méiyǒu shēnhòu biānchéng dǐzi de yèwù rényuán, yě nénggòu qīngsōng dājiàn qǐ fúhé gèxìnghuà guǎnlǐ xūqiú de shùzìhuà yìngyòng gōngjù.', 'Nền tảng phát triển low-code tiên tiến giúp cho ngay cả các nhân viên nghiệp vụ không có nền tảng lập trình sâu cũng có thể dễ dàng thoải mái tự dựng nên các công cụ ứng dụng số hóa đáp ứng nhu cầu quản lý cá nhân hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [情况] (qíngkuàng) - tình hình, tình trạng, hoàn cảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '情况' AND pinyin = 'qíngkuàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '情况'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qíngkuàng',
      meaning_vi = 'tình hình, tình trạng, hoàn cảnh',
      example_hanzi = '医生在仔细询问了患者的病情后，安慰家属说目前身体恢复情况非常良好。',
      example_pinyin = 'Yīshēng zài zǐxì xúnwèn le huànzhě de bìngqíng hòu, ānwèi jiāshǔ shuō mùqián shēntǐ huìfù qíngkuàng fēicháng liánghǎo.',
      example_vi = 'Bác sĩ sau khi cẩn thận hỏi han bệnh tình của bệnh nhân đã an ủi người nhà rằng hiện tại tình hình hồi phục cơ thể rất tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '医生在仔细询问了患者的病情后，安慰家属说目前身体恢复情况非常良好。', 'Yīshēng zài zǐxì xúnwèn le huànzhě de bìngqíng hòu, ānwèi jiāshǔ shuō mùqián shēntǐ huìfù qíngkuàng fēicháng liánghǎo.', 'Bác sĩ sau khi cẩn thận hỏi han bệnh tình của bệnh nhân đã an ủi người nhà rằng hiện tại tình hình hồi phục cơ thể rất tốt.', 'basic', 1),
        (v_id, '各业务部门负责人应在每月经营分析会上客观如实汇报项目进度情况，切忌报喜不报忧，以便管理层迅速作出战略应对。', 'Gè yèwù bùmén fùzérén yīng zài měi yuè jīngyíng fēnxīhuì shang kèguān rúshí huìbào xiàngmù jìndù qíngkuàng, qièjì bàoxǐ-bùbàoyōu, yǐbiàn guǎnlǐcéng xùnsù zuò chū zhànlüè yìngduì.', 'Người phụ trách các bộ phận nghiệp vụ cần báo cáo tình hình tiến độ dự án một cách khách quan trung thực trong cuộc họp phân tích kinh doanh hàng tháng, tuyệt đối tránh báo tin mừng giấu tin lo, để ban quản lý nhanh chóng đưa ra giải pháp chiến lược ứng phó.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [庆祝] (qìngzhù) - chúc mừng, ăn mừng, kỷ niệm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '庆祝' AND pinyin = 'qìngzhù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '庆祝'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'qìngzhù',
      meaning_vi = 'chúc mừng, ăn mừng, kỷ niệm',
      example_hanzi = '为了庆祝公司成立二十周年，全体员工齐聚一堂举办了盛大的联欢晚会。',
      example_pinyin = 'Wèile qìngzhù gōngsī chénglì èrshí zhōunián, quántǐ yuángōng qíjù-yìtáng jǔbàn le shèngdà de liánhuān wǎnhuì.',
      example_vi = 'Để kỷ niệm 20 năm ngày thành lập công ty, toàn thể nhân viên đã tề tựu đông đủ tổ chức buổi dạ hội liên hoan hoành tráng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了庆祝公司成立二十周年，全体员工齐聚一堂举办了盛大的联欢晚会。', 'Wèile qìngzhù gōngsī chénglì èrshí zhōunián, quántǐ yuángōng qíjù-yìtáng jǔbàn le shèngdà de liánhuān wǎnhuì.', 'Để kỷ niệm 20 năm ngày thành lập công ty, toàn thể nhân viên đã tề tựu đông đủ tổ chức buổi dạ hội liên hoan hoành tráng.', 'basic', 1),
        (v_id, '在国庆七十五周年隆重庆典之际，五星红旗在庄严的天安门广场冉冉升起，全场数万名同胞齐声高唱国歌共同庆祝祖国生日。', 'Zài guóqìng qīshíwǔ zhōunián lóngzhòng qìngdiǎn zhī jì, wǔxīng-hóngqí zài zhuāngyán de Tiān’ānmén guǎngchǎng rǎnrǎn shēngqǐ, quánchǎng shù wàn míng tóngbāo qíshēng gāochàng guógē gòngtóng qìngzhù zǔguó shēngrì.', 'Nhân dịp đại lễ long trọng kỷ niệm 75 năm Quốc khánh, lá cờ đỏ năm sao từ từ bay lên trên quảng trường Thiên An Môn trang nghiêm, hàng vạn đồng bào toàn khán phòng đồng thanh hát vang quốc ca cùng chúc mừng ngày sinh của tổ quốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [球队] (qiúduì) - đội bóng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '球队' AND pinyin = 'qiúduì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '球队'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qiúduì',
      meaning_vi = 'đội bóng',
      example_hanzi = '我们学校足球队在刚刚结束的大学生联赛中勇夺冠军。',
      example_pinyin = 'Wǒmen xuéxiào zúqiúduì zài gānggāng jiéshù de dàxuésheng liánsài zhōng yǒng duó guànjūn.',
      example_vi = 'Đội bóng đá trường chúng tôi trong giải bóng đá sinh viên đại học vừa khép lại đã dũng cảm đoạt chức vô địch.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们学校足球队在刚刚结束的大学生联赛中勇夺冠军。', 'Wǒmen xuéxiào zúqiúduì zài gānggāng jiéshù de dàxuésheng liánsài zhōng yǒng duó guànjūn.', 'Đội bóng đá trường chúng tôi trong giải bóng đá sinh viên đại học vừa khép lại đã dũng cảm đoạt chức vô địch.', 'basic', 1),
        (v_id, '这支拥有上百年辉煌队史的豪门足球俱乐部球队，通过引进国际顶尖主教练与青训梯队建设，重新焕发出争夺冠军的强劲竞争力。', 'Zhè zhī yōngyǒu shàng bǎi nián huīhuáng duìshǐ de háomén zúqiú jùlèbù qiúduì, tōngguò yǐnjìn guójì dǐngjiān zhǔjiàoliàn yǔ qīngxùn tīduì jiànshè, chóngxīn huànfā chū zhēngduó guànjūn de qiángjìn jìngzhēnglì.', 'Đội bóng câu lạc bộ bóng đá danh gia vọng tộc sở hữu lịch sử hơn trăm năm huy hoàng này thông qua việc chiêu mộ huấn luyện viên trưởng hàng đầu quốc tế và xây dựng hệ thống tuyến trẻ đào tạo kế cận, đã làm sống lại sức cạnh tranh mạnh mẽ để tranh đoạt chức vô địch.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [球迷] (qiúmí) - người hâm mộ bóng đá/thể thao, fan bóng đá [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '球迷' AND pinyin = 'qiúmí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '球迷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qiúmí',
      meaning_vi = 'người hâm mộ bóng đá/thể thao, fan bóng đá',
      example_hanzi = '数万名热情的足球迷冒雨在看台上为自己喜爱的球队呐喊助威。',
      example_pinyin = 'Shù wàn míng rèqíng de zúqiúmí mào yǔ zài kàntái shang wèi zìjǐ xǐ’ài de qiúduì nàhǎn zhùwēi.',
      example_vi = 'Hàng vạn người hâm mộ bóng đá nhiệt tình đội mưa trên khán đài hò reo cổ vũ cho đội bóng mà mình yêu thích.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '数万名热情的足球迷冒雨在看台上为自己喜爱的球队呐喊助威。', 'Shù wàn míng rèqíng de zúqiúmí mào yǔ zài kàntái shang wèi zìjǐ xǐ’ài de qiúduì nàhǎn zhùwēi.', 'Hàng vạn người hâm mộ bóng đá nhiệt tình đội mưa trên khán đài hò reo cổ vũ cho đội bóng mà mình yêu thích.', 'basic', 1),
        (v_id, '在这场举世瞩目的世界杯半决赛终场哨声吹响瞬间，胜利球队的狂热球迷们涌入市中心广场载歌载舞通宵庆祝。', 'Zài zhè chǎng jǔshì-zhǔmù de shìjièbēi bànjuésài zhōngchǎng shàoshēng chuīxiǎng shūnjiān, shènglì qiúduì de kuángrè qiúmímen yǒngrù shìzhōngxīn guǎngchǎng zàigē-zàiwǔ tōngxiāo qìngzhù.', 'Ngay khoảnh khắc tiếng còi mãn cuộc trận bán kết World Cup thu hút sự chú ý của toàn thế giới vang lên, những người hâm mộ cuồng nhiệt của đội bóng chiến thắng đã tràn vào quảng trường trung tâm thành phố ca múa ăn mừng thâu đêm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [区] (qū) - khu, quận, khu vực [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '区' AND pinyin = 'qū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '区'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'qū',
      meaning_vi = 'khu, quận, khu vực',
      example_hanzi = '市中心商业区拥有许多现代化的大型购物中心与写字楼。',
      example_pinyin = 'Shìzhōngxīn shāngyèqū yōngyǒu xǔduō xiàndàihuà de dàxíng gòuwù zhōngxīn yǔ xiězìlóu.',
      example_vi = 'Khu thương mại trung tâm thành phố sở hữu nhiều trung tâm mua sắm và tòa nhà văn phòng hiện đại quy mô lớn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '市中心商业区拥有许多现代化的大型购物中心与写字楼。', 'Shìzhōngxīn shāngyèqū yōngyǒu xǔduō xiàndàihuà de dàxíng gòuwù zhōngxīn yǔ xiězìlóu.', 'Khu thương mại trung tâm thành phố sở hữu nhiều trung tâm mua sắm và tòa nhà văn phòng hiện đại quy mô lớn.', 'basic', 1),
        (v_id, '为打造国际一流营商环境，经济技术开发区管委会实行“一网通办”全流程数字政务审批，极大激发了外商投资信心。', 'Wèi dǎzào guójì yīliú yíngshāng huánjìng, jīngjì jìshù kāifāqū guǎnwěihuì shíxíng “yí wǎng tōng bàn” quán liúchéng shùzì zhèngwù shěnpī, jí dà jīfā le wàishāng tóuzī xìnxīn.', 'Để xây dựng môi trường kinh doanh hạng nhất quốc tế, ban quản lý khu phát triển kinh tế kỹ thuật đã thực hiện giải quyết thủ tục số hóa hành chính toàn quy trình "một mạng thông suốt", khơi dậy rất lớn niềm tin đầu tư của doanh nghiệp nước ngoài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [区别] (qūbié) - sự khác biệt; phân biệt [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '区别' AND pinyin = 'qūbié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '区别'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'qūbié',
      meaning_vi = 'sự khác biệt; phân biệt',
      example_hanzi = '你能清楚地分辨出普通话和方言在发音上的主要区别吗？',
      example_pinyin = 'Nǐ néng qīngchu de fēnbiàn chū pǔtōnghuà hé fāngyán zài fāyīn shang de zhǔyào qūbié ma?',
      example_vi = 'Bạn có thể phân biệt rõ ràng sự khác biệt chủ yếu về mặt phát âm giữa tiếng phổ thông và tiếng địa phương không?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你能清楚地分辨出普通话和方言在发音上的主要区别吗？', 'Nǐ néng qīngchu de fēnbiàn chū pǔtōnghuà hé fāngyán zài fāyīn shang de zhǔyào qūbié ma?', 'Bạn có thể phân biệt rõ ràng sự khác biệt chủ yếu về mặt phát âm giữa tiếng phổ thông và tiếng địa phương không?', 'basic', 1),
        (v_id, '法学专家在分析本案时严密论证，准确区别了民事违约责任与刑事合同诈骗罪在构成要件与主观故意上的法律界限。', 'Fǎxué zhuānjiā zài fēnxī běn’àn shí yánmì lùnzhèng, zhǔnquè qūbié le mínshì wéiyuē zérèn yǔ xíngshì hétong zhàpiànzuì zài gòuchéng yàojiàn yǔ zhǔguān gùyì shang de fǎlǜ jièxiàn.', 'Chuyên gia luật học khi phân tích vụ án này đã lập luận chặt chẽ, phân biệt chuẩn xác ranh giới pháp lý về yếu tố cấu thành và cố ý chủ quan giữa trách nhiệm vi phạm hợp đồng dân sự và tội phạm lừa đảo hợp đồng hình sự.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [取] (qǔ) - lấy, rút (tiền), nhận (đồ) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '取' AND pinyin = 'qǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '取'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'qǔ',
      meaning_vi = 'lấy, rút (tiền), nhận (đồ)',
      example_hanzi = '下班回家的路上，请顺便帮我去快递驿站取一下快递包裹。',
      example_pinyin = 'Xiàbān huí jiā de lùshang, qǐng shùnbiàn bāng wǒ qù kuàidì yìzhàn qǔ yíxià kuàidì bāoguǒ.',
      example_vi = 'Trên đường tan sở về nhà, xin thuận tiện giúp tôi ghé qua trạm nhận hàng để lấy gói bưu kiện chuyển phát nhanh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '下班回家的路上，请顺便帮我去快递驿站取一下快递包裹。', 'Xiàbān huí jiā de lùshang, qǐng shùnbiàn bāng wǒ qù kuàidì yìzhàn qǔ yíxià kuàidì bāoguǒ.', 'Trên đường tan sở về nhà, xin thuận tiện giúp tôi ghé qua trạm nhận hàng để lấy gói bưu kiện chuyển phát nhanh.', 'basic', 1),
        (v_id, '做学问与从事科学研究应当秉持实事求是的严谨态度，采取科学规范的实证实验方法，切不可投机取巧。', 'Zuò xuéwèn yǔ cóngshì kēxué yánjiū yīngdāng bǐngchí shíshì-qiúshì de yánjǐn tàidu, cǎiqǔ kēxué guīfàn de shízhèng shíyàn fāngfǎ, qiè bù kě tóujī-qǔqiǎo.', 'Làm học vấn và làm công tác nghiên cứu khoa học cần giữ vững thái độ nghiêm cẩn thực sự cầu thị, áp dụng phương pháp thực nghiệm kiểm chứng khoa học quy chuẩn, tuyệt đối không được trục lợi cơ hội khôn lỏi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [取得] (qǔdé) - đạt được, giành được, thu được [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '取得' AND pinyin = 'qǔdé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '取得'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'qǔdé',
      meaning_vi = 'đạt được, giành được, thu được',
      example_hanzi = '经过长达几个月的刻苦努力，他在本次汉语水平考试中取得了优异成绩。',
      example_pinyin = 'Jīngguò cháng dá jǐ gè yuè de kèkǔ nǔlì, tā zài běn cì Hànyǔ shuǐpíng kǎoshì zhōng qǔdé le yōuyì chéngjì.',
      example_vi = 'Trải qua mấy tháng nỗ lực khổ luyện, cậu ấy đã đạt được thành tích xuất sắc trong kỳ thi năng lực Hán ngữ lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过长达几个月的刻苦努力，他在本次汉语水平考试中取得了优异成绩。', 'Jīngguò cháng dá jǐ gè yuè de kèkǔ nǔlì, tā zài běn cì Hànyǔ shuǐpíng kǎoshì zhōng qǔdé le yōuyì chéngjì.', 'Trải qua mấy tháng nỗ lực khổ luyện, cậu ấy đã đạt được thành tích xuất sắc trong kỳ thi năng lực Hán ngữ lần này.', 'basic', 1),
        (v_id, '科研攻关团队经过上万次实验试错，终于在超导量子芯片核心制造工艺领域取得了具有里程碑意义的重大突破。', 'Kēyán gōngguān tuánduì jīngguò shàng wàn cì shíyàn shìcuò, zhōngyú zài chāodǎo liàngzǐ xīnpiàn héxīn zhìzào gōngyì lǐngyù qǔdé le jùyǒu lǐchéngbēi yìyì de zhòngdà tūpò.', 'Đội ngũ nghiên cứu đột phá sau hàng vạn lần thử nghiệm sai sót, cuối cùng đã giành được bước đột phá trọng đại mang ý nghĩa cột mốc lịch sử trong lĩnh vực công nghệ chế tạo chip lượng tử siêu dẫn cốt lõi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [取消] (qǔxiāo) - hủy bỏ, bãi bỏ, hủy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '取消' AND pinyin = 'qǔxiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '取消'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'qǔxiāo',
      meaning_vi = 'hủy bỏ, bãi bỏ, hủy',
      example_hanzi = '因为突然遭遇极端雷暴大风天气，原定今晚举行的户外演唱会被迫取消。',
      example_pinyin = 'Yīnwèi tūrán zāoyù jíduān léibào dàfēng tiānqì, yuándìng jīnwǎn jǔxíng de hùwài yǎnchànghuì bèipò qǔxiāo.',
      example_vi = 'Do bất ngờ gặp phải thời tiết cực đoan mưa giông gió giật mạnh, buổi biểu diễn ca nhạc ngoài trời dự kiến tối nay buộc phải hủy bỏ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '因为突然遭遇极端雷暴大风天气，原定今晚举行的户外演唱会被迫取消。', 'Yīnwèi tūrán zāoyù jíduān léibào dàfēng tiānqì, yuándìng jīnwǎn jǔxíng de hùwài yǎnchànghuì bèipò qǔxiāo.', 'Do bất ngờ gặp phải thời tiết cực đoan mưa giông gió giật mạnh, buổi biểu diễn ca nhạc ngoài trời dự kiến tối nay buộc phải hủy bỏ.', 'basic', 1),
        (v_id, '为进一步优化国际营商环境并扩大高水平对外开放，政府部门正式宣布全面取消外资准入负面清单中的所有制造业限制措施。', 'Wèi jìnyíbù yōuhuà guójì yíngshāng huánjìng bìng kuòdà gāo shuǐpíng duìwài kāifàng, zhèngfǔ bùmén zhèngshì xuānbù quánmiàn qǔxiāo wàizī zhǔnrù fùmiàn qīngdān zhōng de suǒyǒu zhìzàoyè xiànzhì cuòshī.', 'Để tiếp tục tối ưu hóa môi trường kinh doanh quốc tế và mở rộng mở cửa đối ngoại tiêu chuẩn cao, cơ quan chính phủ đã chính thức tuyên bố hủy bỏ toàn bộ các biện pháp hạn chế ngành chế tạo trong danh mục tiêu cực về tiếp cận vốn đầu tư nước ngoài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [全] (quán) - toàn, toàn bộ; đầy đủ [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '全' AND pinyin = 'quán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '全'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'quán',
      meaning_vi = 'toàn, toàn bộ; đầy đủ',
      example_hanzi = '全班同学都积极参加了这次迎新年中华文化知识竞赛。',
      example_pinyin = 'Quán bān tóngxué dōu jījí cānjiā le zhè cì yíng xīnnián Zhōnghuá wénhuà zhīshi jìngsài.',
      example_vi = 'Toàn bộ các bạn học sinh trong lớp đều tích cực tham gia cuộc thi tìm hiểu kiến thức văn hóa Trung Hoa chào đón năm mới lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '全班同学都积极参加了这次迎新年中华文化知识竞赛。', 'Quán bān tóngxué dōu jījí cānjiā le zhè cì yíng xīnnián Zhōnghuá wénhuà zhīshi jìngsài.', 'Toàn bộ các bạn học sinh trong lớp đều tích cực tham gia cuộc thi tìm hiểu kiến thức văn hóa Trung Hoa chào đón năm mới lần này.', 'basic', 1),
        (v_id, '建设现代化产业体系必须坚持把发展经济的着力点放在实体经济上，推进全产业链供应链的高质量协同创新。', 'Jiànshè xiàndàihuà chǎnyè tǐxì bìxū jiānchí bǎ fāzhǎn jīngjì de zhuólìdiǎn fàng zài shítǐ jīngjì shang, tuījìn quán chǎnyèliàn gōngyìngliàn de gāozhìliàng xiétóng chuàngxīn.', 'Xây dựng hệ thống công nghiệp hiện đại bắt buộc phải kiên trì đặt điểm tựa phát triển kinh tế vào nền kinh tế thực, thúc đẩy sự đổi mới hiệp đồng chất lượng cao của toàn bộ chuỗi ngành nghề và chuỗi cung ứng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [全部] (quánbù) - toàn bộ, tất cả [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '全部' AND pinyin = 'quánbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '全部'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'quánbù',
      meaning_vi = 'toàn bộ, tất cả',
      example_hanzi = '经过全组同学连续三天的努力，所有的实验测试数据已经全部整理完毕。',
      example_pinyin = 'Jīngguò quán zǔ tóngxué liánxù sān tiān de nǔlì, suǒyǒu de shíyàn cèshì shùjù yǐjīng quánbù zhěnglǐ wánbì.',
      example_vi = 'Trải qua nỗ lực ba ngày liên tiếp của cả nhóm học sinh, tất cả các số liệu kiểm thử thực nghiệm đều đã được chỉnh lý hoàn tất toàn bộ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过全组同学连续三天的努力，所有的实验测试数据已经全部整理完毕。', 'Jīngguò quán zǔ tóngxué liánxù sān tiān de nǔlì, suǒyǒu de shíyàn cèshì shùjù yǐjīng quánbù zhěnglǐ wánbì.', 'Trải qua nỗ lực ba ngày liên tiếp của cả nhóm học sinh, tất cả các số liệu kiểm thử thực nghiệm đều đã được chỉnh lý hoàn tất toàn bộ.', 'basic', 1),
        (v_id, '跨国并购交易的交割先决条件已全部达成，双方正式完成了涵盖所有海外分支机构与专利资产的全部法律交割手续。', 'Kuàguó bìnggòu jiāoyì de jiāogē xiānjué tiáojiàn yǐ quánbù dáchéng, shuāngfāng zhèngshì wánchéng le hángài suǒyǒu hǎiwài fēnzhī jīgòu yǔ zhuānlì zīchǎn de quánbù fǎlǜ jiāogē shǒuxù.', 'Các điều kiện tiên quyết bàn giao của thương vụ mua bán sáp nhập xuyên quốc gia đã đạt được toàn bộ, hai bên đã chính thức hoàn thành toàn bộ thủ tục chuyển giao pháp lý bao gồm mọi chi nhánh hải ngoại và tài sản bằng sáng chế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [全都] (quándōu) - tất cả đều, thảy đều [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '全都' AND pinyin = 'quándōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '全都'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'quándōu',
      meaning_vi = 'tất cả đều, thảy đều',
      example_hanzi = '听到这个令人振奋的特大喜讯，在场的所有老师和同学们全都高兴地欢呼鼓掌。',
      example_pinyin = 'Tīng dào zhè gè lìng rén zhènfèn de tédà xǐxùn, zàichǎng de suǒyǒu lǎoshī hé tóngxuémen quándōu gāoxìng de huānhū gǔzhǎng.',
      example_vi = 'Nghe được tin vui vô cùng phấn khởi này, tất cả các thầy cô và học sinh có mặt đều vui mừng reo hò vỗ tay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到这个令人振奋的特大喜讯，在场的所有老师和同学们全都高兴地欢呼鼓掌。', 'Tīng dào zhè gè lìng rén zhènfèn de tédà xǐxùn, zàichǎng de suǒyǒu lǎoshī hé tóngxuémen quándōu gāoxìng de huānhū gǔzhǎng.', 'Nghe được tin vui vô cùng phấn khởi này, tất cả các thầy cô và học sinh có mặt đều vui mừng reo hò vỗ tay.', 'basic', 1),
        (v_id, '经过全流程严格的环境可靠性与抗电磁干扰测试，首批交付的智能高端工业机器人各项性能指标全都优于国际行业标准。', 'Jīngguò quán liúchéng yángé de huánjìng kěkàoxìng yǔ kàng-diàncǐ gānrǎo cèshì, shǒupī jiāofù de zhìnéng gāoduān gōngyè jīqìrén gè xiàng xìngnéng zhǐbiāo quándōu yōuyú guójì hángyè biāozhǔn.', 'Trải qua các đợt kiểm tra nghiêm ngặt toàn quy trình về độ tin cậy môi trường và khả năng chống nhiễu điện từ, từng chỉ tiêu tính năng của lô robot công nghiệp cao cấp thông minh bàn giao đầu tiên thảy đều vượt trội hơn các tiêu chuẩn ngành quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 6: #1501 -> #1600)!', v_count;
END $$;
