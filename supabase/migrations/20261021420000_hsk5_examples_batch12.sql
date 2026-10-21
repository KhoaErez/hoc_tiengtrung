-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 12 (100 TỪ TIẾP THEO)
-- Phạm vi: #3102 [台阶] (táijiē) -> #3201 [稳定] (wěndìng)
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
  -- [3102] [台阶] (táijiē) - bậc thềm, bậc thang; bậc thang danh dự/lối thoát thể diện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '台阶' AND pinyin = 'táijiē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '台阶' AND pinyin = 'táijiē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '台阶'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '台阶'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'táijiē',
      meaning_vi = 'bậc thềm, bậc thang; bậc thang danh dự/lối thoát thể diện',
      example_hanzi = '图书馆门前修建了宽阔平缓的石砌台阶，两旁摆放着郁郁葱葱的盆栽花卉。',
      example_pinyin = 'Túshūguǎn ménqián xiūjiàn le kuānkuò pínghuǎn de shíqì táijiē, liǎngpáng bǎifàng zhe yùyù-cōngcōng de pénzāi huāhuì.',
      example_vi = 'Trước cửa thư viện được xây dựng những bậc thềm lát đá thoai thoải rộng rãi, hai bên bày những chậu hoa cây cảnh xanh tươi mướt mắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '台阶',
      'táijiē',
      'bậc thềm, bậc thang; bậc thang danh dự/lối thoát thể diện',
      'Danh từ',
      'HSK 5',
      '图书馆门前修建了宽阔平缓的石砌台阶，两旁摆放着郁郁葱葱的盆栽花卉。',
      'Túshūguǎn ménqián xiūjiàn le kuānkuò pínghuǎn de shíqì táijiē, liǎngpáng bǎifàng zhe yùyù-cōngcōng de pénzāi huāhuì.',
      'Trước cửa thư viện được xây dựng những bậc thềm lát đá thoai thoải rộng rãi, hai bên bày những chậu hoa cây cảnh xanh tươi mướt mắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '图书馆门前修建了宽阔平缓的石砌台阶，两旁摆放着郁郁葱葱的盆栽花卉。', 'Túshūguǎn ménqián xiūjiàn le kuānkuò pínghuǎn de shíqì táijiē, liǎngpáng bǎifàng zhe yùyù-cōngcōng de pénzāi huāhuì.', 'Trước cửa thư viện được xây dựng những bậc thềm lát đá thoai thoải rộng rãi, hai bên bày những chậu hoa cây cảnh xanh tươi mướt mắt.', 'basic', 1),
      (v_id, '在激烈的商务谈判陷入僵局时，经验丰富的主持人巧妙提出折中方案，为双方体面退让铺平了台阶。', 'Zài jīliè de shāngwù tánpàn xiànrù jiāngjú shí, jīngyàn fēngfù de zhǔchírén qiǎomiào tíchū zhézhōng fāng’àn, wèi shuāngfāng tǐmiàn tuìràng pūpíng le táijiē.', 'Khi cuộc đàm phán thương mại căng thẳng rơi vào bế tắc, người chủ trì giàu kinh nghiệm đã khéo léo đưa ra phương án thỏa hiệp dung hòa, tạo lối thoát thể diện cho cả hai bên nhượng bộ trong danh dự.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3103] [太太] (tàitai) - bà xã, phu nhân, bà [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '太太' AND pinyin = 'tàitai'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '太太' AND pinyin = 'tàitai'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '太太'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '太太'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tàitai',
      meaning_vi = 'bà xã, phu nhân, bà',
      example_hanzi = '王教授和他的太太经常在傍晚时分手牵着手在校园林荫道上散步。',
      example_pinyin = 'Wáng jiàoshòu hé tā de tàitai jīngcháng zài bàngwǎn shífēn shǒu qiān zhe shǒu zài xiàoyuán línyīndào shang sànbù.',
      example_vi = 'Giáo sư Vương và bà xã của ông thường hay tay trong tay đi dạo trên con đường rợp bóng cây của khuôn viên trường vào lúc chập tối.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '太太',
      'tàitai',
      'bà xã, phu nhân, bà',
      'Danh từ',
      'HSK 5',
      '王教授和他的太太经常在傍晚时分手牵着手在校园林荫道上散步。',
      'Wáng jiàoshòu hé tā de tàitai jīngcháng zài bàngwǎn shífēn shǒu qiān zhe shǒu zài xiàoyuán línyīndào shang sànbù.',
      'Giáo sư Vương và bà xã của ông thường hay tay trong tay đi dạo trên con đường rợp bóng cây của khuôn viên trường vào lúc chập tối.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '王教授和他的太太经常在傍晚时分手牵着手在校园林荫道上散步。', 'Wáng jiàoshòu hé tā de tàitai jīngcháng zài bàngwǎn shífēn shǒu qiān zhe shǒu zài xiàoyuán línyīndào shang sànbù.', 'Giáo sư Vương và bà xã của ông thường hay tay trong tay đi dạo trên con đường rợp bóng cây của khuôn viên trường vào lúc chập tối.', 'basic', 1),
      (v_id, '在大使馆举行的国庆招待晚宴上，外交公使携太太亲切接见了中外友好文化使者与商界杰出代表。', 'Zài dàshǐguǎn jǔxíng de guóqìng zhāodài wǎnyàn shang, wàijiāo gōngshǐ xié tàitai qīnqiè jiējiàn le zhōng-wài yǒuhǎo wénhuà shǐzhě yǔ shāngjiè jiéchū dàibiǎo.', 'Tại tiệc chiêu đãi Quốc khánh tổ chức ở đại sứ quán, ngài công sứ ngoại giao cùng phu nhân đã ân cần tiếp đón các sứ giả văn hóa hữu nghị Trung - ngoại và các đại diện xuất sắc của giới doanh nhân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3104] [谈话] (tánhuà) - nói chuyện, trò chuyện; cuộc nói chuyện, buổi hội đàm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '谈话' AND pinyin = 'tánhuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '谈话' AND pinyin = 'tánhuà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '谈话'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '谈话'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'tánhuà',
      meaning_vi = 'nói chuyện, trò chuyện; cuộc nói chuyện, buổi hội đàm',
      example_hanzi = '班主任今天下午找小明谈话，耐心地鼓励他卸下包袱、积极面对近期的学业压力。',
      example_pinyin = 'Bānzhǔrèn jīntiān xiàwǔ zhǎo Xiǎomíng tánhuà, nàixīn de gǔlì tā xiè xià bāofu, jījí miànduì jìnqī de xuéyè yālì.',
      example_vi = 'Giáo viên chủ nhiệm chiều nay đã tìm gặp Tiểu Minh nói chuyện, kiên nhẫn khích lệ em trút bỏ gánh nặng tâm lý và tích cực đối mặt với áp lực học tập gần đây.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '谈话',
      'tánhuà',
      'nói chuyện, trò chuyện; cuộc nói chuyện, buổi hội đàm',
      'Động từ / Danh từ',
      'HSK 5',
      '班主任今天下午找小明谈话，耐心地鼓励他卸下包袱、积极面对近期的学业压力。',
      'Bānzhǔrèn jīntiān xiàwǔ zhǎo Xiǎomíng tánhuà, nàixīn de gǔlì tā xiè xià bāofu, jījí miànduì jìnqī de xuéyè yālì.',
      'Giáo viên chủ nhiệm chiều nay đã tìm gặp Tiểu Minh nói chuyện, kiên nhẫn khích lệ em trút bỏ gánh nặng tâm lý và tích cực đối mặt với áp lực học tập gần đây.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '班主任今天下午找小明谈话，耐心地鼓励他卸下包袱、积极面对近期的学业压力。', 'Bānzhǔrèn jīntiān xiàwǔ zhǎo Xiǎomíng tánhuà, nàixīn de gǔlì tā xiè xià bāofu, jījí miànduì jìnqī de xuéyè yālì.', 'Giáo viên chủ nhiệm chiều nay đã tìm gặp Tiểu Minh nói chuyện, kiên nhẫn khích lệ em trút bỏ gánh nặng tâm lý và tích cực đối mặt với áp lực học tập gần đây.', 'basic', 1),
      (v_id, '纪检监察机关依规依纪对履职不力的企事业单位主要负责人开展诫勉谈话，严肃指出问题并督促限期整改落实。', 'Jìjiǎn jiānchá jīgòu yīguī yījì duì lǚzhí bùlì de qǐ-shìyè dānwèi zhǔyào fùzérén kāizhǎn jièmiǎn tánhuà, yánsù zhǐchū wèntí bìng dūcù xiànqī zhěnggǎi luòshí.', 'Cơ quan kiểm tra giám sát kỷ luật theo quy định đã triển khai cuộc nói chuyện nhắc nhở răn đe đối với người phụ trách chính của đơn vị sự nghiệp doanh nghiệp thực thi nhiệm vụ yếu kém, nghiêm túc chỉ rõ vấn đề và đốc thúc chấn chỉnh khắc phục trong thời hạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3105] [桃] (táo) - quả đào, cây đào [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '桃' AND pinyin = 'táo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '桃' AND pinyin = 'táo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '桃'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '桃'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'táo',
      meaning_vi = 'quả đào, cây đào',
      example_hanzi = '盛夏时节，果园里的水蜜桃挂满枝头，果肉饱满多汁，香气扑鼻。',
      example_pinyin = 'Shèngxià shíjié, guǒyuán lǐ de shuǐmìtáo guà mǎn zhītóu, guǒròu bǎomǎn duō zhī, xiāngqì pūbí.',
      example_vi = 'Vào độ giữa hè, những quả đào mật trong vườn sai trĩu cành, cùi quả căng mọng nhiều nước, tỏa hương thơm ngát.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '桃',
      'táo',
      'quả đào, cây đào',
      'Danh từ',
      'HSK 5',
      '盛夏时节，果园里的水蜜桃挂满枝头，果肉饱满多汁，香气扑鼻。',
      'Shèngxià shíjié, guǒyuán lǐ de shuǐmìtáo guà mǎn zhītóu, guǒròu bǎomǎn duō zhī, xiāngqì pūbí.',
      'Vào độ giữa hè, những quả đào mật trong vườn sai trĩu cành, cùi quả căng mọng nhiều nước, tỏa hương thơm ngát.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '盛夏时节，果园里的水蜜桃挂满枝头，果肉饱满多汁，香气扑鼻。', 'Shèngxià shíjié, guǒyuán lǐ de shuǐmìtáo guà mǎn zhītóu, guǒròu bǎomǎn duō zhī, xiāngqì pūbí.', 'Vào độ giữa hè, những quả đào mật trong vườn sai trĩu cành, cùi quả căng mọng nhiều nước, tỏa hương thơm ngát.', 'basic', 1),
      (v_id, '农业科研团队成功解析了地方优异蟠桃种质资源的抗逆基因序列，为培育早熟耐储运高产优质桃新品系奠定了分子育种基础。', 'Nóngyè kēyán tuánduì chénggōng jiěxī le dìfāng yōuyì pántáo zhǒngzhì zīyuán de kàngnì jīyīn xùliè, wèi péiyù zǎoshú nàichǔyùn gāochǎn yōuzhì táo xīn pǐnxì diàndìng le fēnzǐ yùzhǒng jīchǔ.', 'Nhóm nghiên cứu khoa học nông nghiệp đã giải mã thành công trình tự gen kháng nghịch của nguồn phôi đào dẹt địa phương xuất sắc, đặt nền tảng chọn giống phân tử cho việc ươm tạo dòng đào mới chất lượng cao năng suất cao chín sớm chịu được bảo quản vận chuyển.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3106] [套] (tào) - bộ, sê-ri; vỏ bọc; lồng vào, chụp vào [Lượng từ / Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '套' AND pinyin = 'tào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '套' AND pinyin = 'tào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '套'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '套'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ / Danh từ / Động từ',
      pinyin = 'tào',
      meaning_vi = 'bộ, sê-ri; vỏ bọc; lồng vào, chụp vào',
      example_hanzi = '他们在城市中心按揭购买了一套采光良好的三室两厅精装商品房。',
      example_pinyin = 'Tāmen zài chéngshì zhōngxīn ànjiē gòumǎi le yí tào cǎiguāng liánghǎo de sānshì-liǎngtīng jīngzhuāng shāngpǐnfáng.',
      example_vi = 'Họ đã vay trả góp mua một căn nhà ở thương mại ba phòng ngủ hai phòng khách đầy đủ nội thất có ánh sáng chan hòa ở trung tâm thành phố.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '套',
      'tào',
      'bộ, sê-ri; vỏ bọc; lồng vào, chụp vào',
      'Lượng từ / Danh từ / Động từ',
      'HSK 5',
      '他们在城市中心按揭购买了一套采光良好的三室两厅精装商品房。',
      'Tāmen zài chéngshì zhōngxīn ànjiē gòumǎi le yí tào cǎiguāng liánghǎo de sānshì-liǎngtīng jīngzhuāng shāngpǐnfáng.',
      'Họ đã vay trả góp mua một căn nhà ở thương mại ba phòng ngủ hai phòng khách đầy đủ nội thất có ánh sáng chan hòa ở trung tâm thành phố.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他们在城市中心按揭购买了一套采光良好的三室两厅精装商品房。', 'Tāmen zài chéngshì zhōngxīn ànjiē gòumǎi le yí tào cǎiguāng liánghǎo de sānshì-liǎngtīng jīngzhuāng shāngpǐnfáng.', 'Họ đã vay trả góp mua một căn nhà ở thương mại ba phòng ngủ hai phòng khách đầy đủ nội thất có ánh sáng chan hòa ở trung tâm thành phố.', 'basic', 1),
      (v_id, '该科研机构成功研制出一整套具备完全自主知识产权的超导量子计算测控软硬件系统。', 'Gāi kēyán jīgòu chénggōng yánzhì chū yì zhěngtào jùbèi wánquán zìzhǔ zhīshi chǎnquán de chāodǎo liàngzǐ jìsuàn cèkòng ruǎnhàrjiàn xìtǒng.', 'Cơ quan nghiên cứu khoa học này đã nghiên cứu chế tạo thành công một bộ hoàn chỉnh hệ thống phần cứng và phần mềm đo lường điều khiển tính toán lượng tử siêu dẫn có toàn quyền sở hữu trí tuệ tự chủ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3107] [特产] (tèchǎn) - đặc sản, sản vật đặc trưng vùng miền [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '特产' AND pinyin = 'tèchǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特产' AND pinyin = 'tèchǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '特产'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特产'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tèchǎn',
      meaning_vi = 'đặc sản, sản vật đặc trưng vùng miền',
      example_hanzi = '出差旅行结束返程时，他特意在当地老字号商店买了几盒知名特产糕点带给亲友。',
      example_pinyin = 'Chūchāi lǚxíng jiéshù fǎnchéng shí, tā tèyì zài dāngdì lǎozìhào shāngdiàn mǎi le jǐ hé zhīmíng tèchǎn gāodiǎn dài gěi qīnyǒu.',
      example_vi = 'Khi kết thúc chuyến đi công tác trở về, anh ấy đã đặc biệt ghé qua cửa hàng lâu đời ở địa phương mua mấy hộp bánh đặc sản nổi tiếng mang về làm quà cho người thân và bạn bè.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '特产',
      'tèchǎn',
      'đặc sản, sản vật đặc trưng vùng miền',
      'Danh từ',
      'HSK 5',
      '出差旅行结束返程时，他特意在当地老字号商店买了几盒知名特产糕点带给亲友。',
      'Chūchāi lǚxíng jiéshù fǎnchéng shí, tā tèyì zài dāngdì lǎozìhào shāngdiàn mǎi le jǐ hé zhīmíng tèchǎn gāodiǎn dài gěi qīnyǒu.',
      'Khi kết thúc chuyến đi công tác trở về, anh ấy đã đặc biệt ghé qua cửa hàng lâu đời ở địa phương mua mấy hộp bánh đặc sản nổi tiếng mang về làm quà cho người thân và bạn bè.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出差旅行结束返程时，他特意在当地老字号商店买了几盒知名特产糕点带给亲友。', 'Chūchāi lǚxíng jiéshù fǎnchéng shí, tā tèyì zài dāngdì lǎozìhào shāngdiàn mǎi le jǐ hé zhīmíng tèchǎn gāodiǎn dài gěi qīnyǒu.', 'Khi kết thúc chuyến đi công tác trở về, anh ấy đã đặc biệt ghé qua cửa hàng lâu đời ở địa phương mua mấy hộp bánh đặc sản nổi tiếng mang về làm quà cho người thân và bạn bè.', 'basic', 1),
      (v_id, '依托国家地理标志保护产品认证，地方政府积极引导特色农产品走产业化、品牌化的高附加值富民增收之路。', 'Yītuō guójiā dìlǐ biāozhì bǎohù chǎnpǐn rènzhèng, dìfāng zhèngfǔ jījí yǐndǎo tèsè nóngchǎnpǐn zǒu chǎnyèhuà, pǐnpáihuà de gāo-fùjiāzhí fùmín-zēngshōu zhī lù.', 'Dựa vào chứng nhận sản phẩm bảo hộ chỉ dẫn địa lý quốc gia, chính quyền địa phương tích cực định hướng nông sản đặc sản đi theo con đường nâng cao giá trị gia tăng làm giàu tăng thu nhập cho dân theo hướng sản xuất hàng hóa và thương hiệu hóa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3108] [特色] (tèsè) - đặc sắc, nét đặc trưng tiêu biểu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '特色' AND pinyin = 'tèsè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特色' AND pinyin = 'tèsè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '特色'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特色'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tèsè',
      meaning_vi = 'đặc sắc, nét đặc trưng tiêu biểu',
      example_hanzi = '这家坐落在老街巷深处的餐馆，以制作正宗地道的地方特色小吃而远近闻名。',
      example_pinyin = 'Zhè jiā zuòluò zài lǎojiē xiàng shēnchù de cānguǎn, yǐ zhìzuò zhèngzōng dìdao de dìfāng tèsè xiǎochī ér yuǎnjìn-wénmíng.',
      example_vi = 'Quán ăn nằm sâu trong con hẻm cổ này nổi tiếng gần xa nhờ chế biến các món ăn vặt đặc sắc chuẩn vị dân dã của địa phương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '特色',
      'tèsè',
      'đặc sắc, nét đặc trưng tiêu biểu',
      'Danh từ',
      'HSK 5',
      '这家坐落在老街巷深处的餐馆，以制作正宗地道的地方特色小吃而远近闻名。',
      'Zhè jiā zuòluò zài lǎojiē xiàng shēnchù de cānguǎn, yǐ zhìzuò zhèngzōng dìdao de dìfāng tèsè xiǎochī ér yuǎnjìn-wénmíng.',
      'Quán ăn nằm sâu trong con hẻm cổ này nổi tiếng gần xa nhờ chế biến các món ăn vặt đặc sắc chuẩn vị dân dã của địa phương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家坐落在老街巷深处的餐馆，以制作正宗地道的地方特色小吃而远近闻名。', 'Zhè jiā zuòluò zài lǎojiē xiàng shēnchù de cānguǎn, yǐ zhìzuò zhèngzōng dìdao de dìfāng tèsè xiǎochī ér yuǎnjìn-wénmíng.', 'Quán ăn nằm sâu trong con hẻm cổ này nổi tiếng gần xa nhờ chế biến các món ăn vặt đặc sắc chuẩn vị dân dã của địa phương.', 'basic', 1),
      (v_id, '全面推进乡村振兴必须因地制宜深挖乡土文化与生态禀赋，走出一条具有区域辨识度的特色产业高质量发展新路。', 'Quánmiàn tuījìn xiāngcūn zhènxīng bìxū yīndì-zhìyí shēn wā xiāngtǔ wénhuà yǔ shēngtài bǐngfù, zǒu chū yì tiáo jùyǒu qūyù biànshídù de tèsè chǎnyè gāo-zhìliàng fāzhǎn xīn lù.', 'Thúc đẩy toàn diện phục hưng nông thôn bắt buộc phải tùy theo điều kiện địa phương đào sâu văn hóa làng quê và nguồn tài nguyên sinh thái sẵn có, bước ra một con đường mới phát triển ngành đặc sắc chất lượng cao mang dấu ấn nhận diện vùng miền.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3109] [特殊] (tèshū) - đặc thù, đặc biệt, cá biệt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '特殊' AND pinyin = 'tèshū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特殊' AND pinyin = 'tèshū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '特殊'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特殊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'tèshū',
      meaning_vi = 'đặc thù, đặc biệt, cá biệt',
      example_hanzi = '如果因身体突发疾病等特殊情况无法参加期末考试，学生可以凭医院开具的诊断证明申请缓考。',
      example_pinyin = 'Rúguǒ yīn shēntǐ tūfā jíbìng děng tèshū qíngkuàng wúfǎ cānjiā qīmò kǎoshì, xuéshēng kěyǐ píng yīyuàn kāijù de zhěnduàn zhèngmíng shēnqǐng huǎnkǎo.',
      example_vi = 'Nếu vì tình huống đặc biệt như cơ thể bất ngờ ốm đau mà không thể tham gia thi học kỳ, học sinh có thể dựa vào giấy xác nhận chẩn đoán của bệnh viện để xin hoãn thi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '特殊',
      'tèshū',
      'đặc thù, đặc biệt, cá biệt',
      'Tính từ',
      'HSK 5',
      '如果因身体突发疾病等特殊情况无法参加期末考试，学生可以凭医院开具的诊断证明申请缓考。',
      'Rúguǒ yīn shēntǐ tūfā jíbìng děng tèshū qíngkuàng wúfǎ cānjiā qīmò kǎoshì, xuéshēng kěyǐ píng yīyuàn kāijù de zhěnduàn zhèngmíng shēnqǐng huǎnkǎo.',
      'Nếu vì tình huống đặc biệt như cơ thể bất ngờ ốm đau mà không thể tham gia thi học kỳ, học sinh có thể dựa vào giấy xác nhận chẩn đoán của bệnh viện để xin hoãn thi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果因身体突发疾病等特殊情况无法参加期末考试，学生可以凭医院开具的诊断证明申请缓考。', 'Rúguǒ yīn shēntǐ tūfā jíbìng děng tèshū qíngkuàng wúfǎ cānjiā qīmò kǎoshì, xuéshēng kěyǐ píng yīyuàn kāijù de zhěnduàn zhèngmíng shēnqǐng huǎnkǎo.', 'Nếu vì tình huống đặc biệt như cơ thể bất ngờ ốm đau mà không thể tham gia thi học kỳ, học sinh có thể dựa vào giấy xác nhận chẩn đoán của bệnh viện để xin hoãn thi.', 'basic', 1),
      (v_id, '在应对极其严峻复杂的特殊外部宏观经济周期波动中，必须出台兼顾逆周期调节与跨周期设计的系统性一揽子增量政策。', 'Zài yìngduì jíqí yánjùn fùzá de tèshū wàibù hóngguān jīngjì zhōuqī bōdòng zhōng, bìxū chūtái jiāngù nì-zhōuqī tiáojié yǔ kuà-zhōuqī shèjì de xìtǒngxìng yìlǎnzǐ zēngliàng zhèngcè.', 'Trong việc ứng phó với những biến động chu kỳ kinh tế vĩ mô bên ngoài đặc thù gay gắt và phức tạp, bắt buộc phải ban hành gói chính sách gia tăng mang tính hệ thống kết hợp hài hòa giữa điều tiết ngược chu kỳ và thiết kế liên chu kỳ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3110] [特有] (tèyǒu) - đặc hữu, riêng có, vốn có [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '特有' AND pinyin = 'tèyǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特有' AND pinyin = 'tèyǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '特有'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特有'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'tèyǒu',
      meaning_vi = 'đặc hữu, riêng có, vốn có',
      example_hanzi = '大熊猫是中国特有的珍稀野生哺乳动物，被誉为中国国宝。',
      example_pinyin = 'Dàxióngmāo shì Zhōngguó tèyǒu de zhēnxī yěshēng bǔrǔ dòngwù, bèi yù wèi Zhōngguó guóbǎo.',
      example_vi = 'Gấu trúc lớn là loài động vật có vú hoang dã quý hiếm đặc hữu của Trung Quốc, được mệnh danh là quốc bảo của Trung Hoa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '特有',
      'tèyǒu',
      'đặc hữu, riêng có, vốn có',
      'Tính từ',
      'HSK 5',
      '大熊猫是中国特有的珍稀野生哺乳动物，被誉为中国国宝。',
      'Dàxióngmāo shì Zhōngguó tèyǒu de zhēnxī yěshēng bǔrǔ dòngwù, bèi yù wèi Zhōngguó guóbǎo.',
      'Gấu trúc lớn là loài động vật có vú hoang dã quý hiếm đặc hữu của Trung Quốc, được mệnh danh là quốc bảo của Trung Hoa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大熊猫是中国特有的珍稀野生哺乳动物，被誉为中国国宝。', 'Dàxióngmāo shì Zhōngguó tèyǒu de zhēnxī yěshēng bǔrǔ dòngwù, bèi yù wèi Zhōngguó guóbǎo.', 'Gấu trúc lớn là loài động vật có vú hoang dã quý hiếm đặc hữu của Trung Quốc, được mệnh danh là quốc bảo của Trung Hoa.', 'basic', 1),
      (v_id, '传统手工造纸技艺中所展现的独特帘纹与天然植物纤维肌理，展现出东方传统纸质文物特有的人文温度与审美意境。', 'Chuántǒng shǒugōng zàozhǐ jìyì zhōng suǒ zhǎnxiàn de dútè liánwén yǔ tiānrán zhíwù xiānwéi jīlǐ, zhǎnxiàn chū dōngfāng chuántǒng zhǐzhì wénwù tèyǒu de rénwén wēndù yǔ shěnměi yìjìng.', 'Đường vân mành độc đáo và thớ sợi thực vật tự nhiên thể hiện trong kỹ thuật làm giấy thủ công truyền thống toát lên hơi ấm nhân văn và cảnh giới thẩm mỹ đặc hữu của các cổ vật chất liệu giấy truyền thống phương Đông.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3111] [特征] (tèzhēng) - đặc trưng, dấu hiệu đặc trưng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '特征' AND pinyin = 'tèzhēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特征' AND pinyin = 'tèzhēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '特征'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '特征'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tèzhēng',
      meaning_vi = 'đặc trưng, dấu hiệu đặc trưng',
      example_hanzi = '这两种植物虽然外形十分相似，但仔细观察叶片的边缘形状就能发现明显的区别特征。',
      example_pinyin = 'Zhè liǎng zhǒng zhíwù suīrán wàixíng shífēn xiāngsì, dàn zǐxì guānchá yèpiàn de biānyuán xíngzhuàng jiù néng fāxiàn míngxiǎn de qūbié tèzhēng.',
      example_vi = 'Hai loài thực vật này tuy hình dáng bên ngoài rất giống nhau nhưng quan sát kỹ hình dáng mép lá thì có thể phát hiện ra đặc trưng phân biệt rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '特征',
      'tèzhēng',
      'đặc trưng, dấu hiệu đặc trưng',
      'Danh từ',
      'HSK 5',
      '这两种植物虽然外形十分相似，但仔细观察叶片的边缘形状就能发现明显的区别特征。',
      'Zhè liǎng zhǒng zhíwù suīrán wàixíng shífēn xiāngsì, dàn zǐxì guānchá yèpiàn de biānyuán xíngzhuàng jiù néng fāxiàn míngxiǎn de qūbié tèzhēng.',
      'Hai loài thực vật này tuy hình dáng bên ngoài rất giống nhau nhưng quan sát kỹ hình dáng mép lá thì có thể phát hiện ra đặc trưng phân biệt rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这两种植物虽然外形十分相似，但仔细观察叶片的边缘形状就能发现明显的区别特征。', 'Zhè liǎng zhǒng zhíwù suīrán wàixíng shífēn xiāngsì, dàn zǐxì guānchá yèpiàn de biānyuán xíngzhuàng jiù néng fāxiàn míngxiǎn de qūbié tèzhēng.', 'Hai loài thực vật này tuy hình dáng bên ngoài rất giống nhau nhưng quan sát kỹ hình dáng mép lá thì có thể phát hiện ra đặc trưng phân biệt rõ rệt.', 'basic', 1),
      (v_id, '多维生物识别安全认证系统通过深度卷积神经网络精准提取人脸三维骨骼微结构与虹膜细微纹理特征。', 'Duōwéi shēngwù shíbié ānquán rènzhèng xìtǒng tōngguò shēndù juǎnjī shénjīng wǎngluò jīngzhǔn tíqǔ rénliǎn sānwéi gǔgé wēijiégòu yǔ hóngmó xìwēi wénlǐ tèzhēng.', 'Hệ thống chứng thực an toàn nhận dạng sinh trắc học đa chiều thông qua mạng nơ-ron tích chập sâu đã trích xuất chuẩn xác vi cấu trúc xương 3D khuôn mặt và các đặc trưng vân mắt mống mắt tinh vi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3112] [疼痛] (téngtòng) - đau đớn, nhức nhối; cơn đau [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '疼痛' AND pinyin = 'téngtòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '疼痛' AND pinyin = 'téngtòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '疼痛'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '疼痛'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'téngtòng',
      meaning_vi = 'đau đớn, nhức nhối; cơn đau',
      example_hanzi = '医生在给患者进行局部麻醉后，拔牙过程中几乎感觉不到任何剧烈的疼痛。',
      example_pinyin = 'Yīshēng zài gěi huànzhě jìnxíng júbù mázuì hòu, báyá guòchéng zhōng jīhū gǎnjué búdào rènhé jùliè de téngtòng.',
      example_vi = 'Sau khi bác sĩ gây tê cục bộ cho người bệnh, trong quá trình nhổ răng hầu như không cảm thấy bất kỳ cơn đau dữ dội nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '疼痛',
      'téngtòng',
      'đau đớn, nhức nhối; cơn đau',
      'Tính từ / Danh từ',
      'HSK 5',
      '医生在给患者进行局部麻醉后，拔牙过程中几乎感觉不到任何剧烈的疼痛。',
      'Yīshēng zài gěi huànzhě jìnxíng júbù mázuì hòu, báyá guòchéng zhōng jīhū gǎnjué búdào rènhé jùliè de téngtòng.',
      'Sau khi bác sĩ gây tê cục bộ cho người bệnh, trong quá trình nhổ răng hầu như không cảm thấy bất kỳ cơn đau dữ dội nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '医生在给患者进行局部麻醉后，拔牙过程中几乎感觉不到任何剧烈的疼痛。', 'Yīshēng zài gěi huànzhě jìnxíng júbù mázuì hòu, báyá guòchéng zhōng jīhū gǎnjué búdào rènhé jùliè de téngtòng.', 'Sau khi bác sĩ gây tê cục bộ cho người bệnh, trong quá trình nhổ răng hầu như không cảm thấy bất kỳ cơn đau dữ dội nào.', 'basic', 1),
      (v_id, '现代临床医学普遍推行无痛诊疗体系与术后多模式镇痛方案，有效降低创伤应激反应并显著提升患者围手术期康复质量。', 'Xiàndài línchuáng yīxué pǔbiàn tuīxíng wútòng zhěnliáo tǐxì yǔ shùhòu duō-móshì zhèntòng fāng’àn, yǒuxiào jiàngdī chuāngshāng yìngjī fǎnyìng bìng xiǎnzhù tíshēng huànzhě wéishǒushùqī kāngfù zhìliàng.', 'Y học lâm sàng hiện đại áp dụng rộng rãi hệ thống khám chữa bệnh không đau và phác đồ giảm đau đa phương thức sau mổ, hạ thấp hữu hiệu phản ứng stress do chấn thương và nâng cao rõ rệt chất lượng hồi phục chu phẫu cho người bệnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3113] [提倡] (tíchàng) - đề xướng, khuyến khích, cổ vũ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '提倡' AND pinyin = 'tíchàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提倡' AND pinyin = 'tíchàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '提倡'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提倡'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tíchàng',
      meaning_vi = 'đề xướng, khuyến khích, cổ vũ',
      example_hanzi = '学校一贯提倡厉行节约反对铺张浪费，要求同学们在食堂就餐时践行“光盘行动”。',
      example_pinyin = 'Xuéxiào yíguàn tíchàng lìxíng-jiéyuē fǎnduì pūzhāng-làngfèi, yāoqiú tóngxuémen zài shítáng jiùcān shí jiànxíng “guāngpán xíngdòng”.',
      example_vi = 'Nhà trường luôn đề xướng thực hành tiết kiệm phản đối xa hoa lãng phí, yêu cầu các bạn học sinh khi ăn cơm tại căng tin hãy thực hiện "hành động ăn sạch đĩa".'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '提倡',
      'tíchàng',
      'đề xướng, khuyến khích, cổ vũ',
      'Động từ',
      'HSK 5',
      '学校一贯提倡厉行节约反对铺张浪费，要求同学们在食堂就餐时践行“光盘行动”。',
      'Xuéxiào yíguàn tíchàng lìxíng-jiéyuē fǎnduì pūzhāng-làngfèi, yāoqiú tóngxuémen zài shítáng jiùcān shí jiànxíng “guāngpán xíngdòng”.',
      'Nhà trường luôn đề xướng thực hành tiết kiệm phản đối xa hoa lãng phí, yêu cầu các bạn học sinh khi ăn cơm tại căng tin hãy thực hiện "hành động ăn sạch đĩa".'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校一贯提倡厉行节约反对铺张浪费，要求同学们在食堂就餐时践行“光盘行动”。', 'Xuéxiào yíguàn tíchàng lìxíng-jiéyuē fǎnduì pūzhāng-làngfèi, yāoqiú tóngxuémen zài shítáng jiùcān shí jiànxíng “guāngpán xíngdòng”.', 'Nhà trường luôn đề xướng thực hành tiết kiệm phản đối xa hoa lãng phí, yêu cầu các bạn học sinh khi ăn cơm tại căng tin hãy thực hiện "hành động ăn sạch đĩa".', 'basic', 1),
      (v_id, '全社会应当大力提倡绿色低碳循环的生活消费方式，形成崇尚节约、低碳环保的新型生态文明社会风尚。', 'Quán shèhuì yīngdāng dàlì tíchàng lǜsè dītàn xúnhuán de shēnghuó xiāofèi fāngshì, xíngchéng chóngshàng jiéyuē, dītàn huánbǎo de xīnxíng shēngtài wénmíng shèhuì fēngshàng.', 'Toàn xã hội cần ra sức đề xướng phương thức tiêu dùng sinh hoạt tuần hoàn ít carbon xanh, hình thành nếp sống xã hội văn minh sinh thái kiểu mới tôn sùng tiết kiệm và thân thiện môi trường ít carbon.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3114] [提交] (tíjiāo) - nộp, đệ trình, nộp lên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '提交' AND pinyin = 'tíjiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提交' AND pinyin = 'tíjiāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '提交'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提交'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tíjiāo',
      meaning_vi = 'nộp, đệ trình, nộp lên',
      example_hanzi = '请各位项目负责人务必在下周五下班前，将本年度工作总结报告提交给行政部门。',
      example_pinyin = 'Qǐng gèwèi xiàngmù fùzérén wùbì zài xià zhōuwǔ xiàbān qián, jiāng běn niándù gōngzuò zǒngjié bàogào tíjiāo gěi xíngzhèng bùmén.',
      example_vi = 'Xin mời các vị phụ trách dự án nhất thiết nộp báo cáo tổng kết công tác năm nay lên bộ phận hành chính trước giờ tan làm thứ Sáu tuần sau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '提交',
      'tíjiāo',
      'nộp, đệ trình, nộp lên',
      'Động từ',
      'HSK 5',
      '请各位项目负责人务必在下周五下班前，将本年度工作总结报告提交给行政部门。',
      'Qǐng gèwèi xiàngmù fùzérén wùbì zài xià zhōuwǔ xiàbān qián, jiāng běn niándù gōngzuò zǒngjié bàogào tíjiāo gěi xíngzhèng bùmén.',
      'Xin mời các vị phụ trách dự án nhất thiết nộp báo cáo tổng kết công tác năm nay lên bộ phận hành chính trước giờ tan làm thứ Sáu tuần sau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请各位项目负责人务必在下周五下班前，将本年度工作总结报告提交给行政部门。', 'Qǐng gèwèi xiàngmù fùzérén wùbì zài xià zhōuwǔ xiàbān qián, jiāng běn niándù gōngzuò zǒngjié bàogào tíjiāo gěi xíngzhèng bùmén.', 'Xin mời các vị phụ trách dự án nhất thiết nộp báo cáo tổng kết công tác năm nay lên bộ phận hành chính trước giờ tan làm thứ Sáu tuần sau.', 'basic', 1),
      (v_id, '重大兼并重组方案经董事会审议通过后，必须依法正式提交反垄断执法主管机构进行经营者集中反垄断审查。', 'Zhòngdà jiānbìng chóngzǔ fāng’àn jīng dǒngshìhuì shěnyì tōngguò hòu, bìxū yīfǎ zhèngshì tíjiāo fǎnlǒngduàn zhífǎ zhǔguǎn jīgòu jìnxíng jīngyíngzhě jízhōng fǎnlǒngduàn shěnchá.', 'Phương án sáp nhập tái cấu trúc trọng đại sau khi được hội đồng quản trị xem xét thông qua bắt buộc phải chính thức đệ trình lên cơ quan chủ quản thực thi luật chống độc quyền theo luật định để thẩm tra chống độc quyền tập trung người kinh doanh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3115] [题目] (tímù) - đề mục, chủ đề, câu hỏi đề thi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '题目' AND pinyin = 'tímù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '题目' AND pinyin = 'tímù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '题目'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '题目'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tímù',
      meaning_vi = 'đề mục, chủ đề, câu hỏi đề thi',
      example_hanzi = '在答题卡上作答之前，请务必仔细阅读试卷上的每一道题目要求。',
      example_pinyin = 'Zài dātíkǎ shang zuòdá zhīqián, qǐng wùbì zǐxì yuèdú shìjuàn shang de měi yí dào tímù yāoqiú.',
      example_vi = 'Trước khi làm bài trên phiếu trả lời, xin nhất thiết phải đọc kỹ càng yêu cầu của từng câu hỏi trên đề thi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '题目',
      'tímù',
      'đề mục, chủ đề, câu hỏi đề thi',
      'Danh từ',
      'HSK 5',
      '在答题卡上作答之前，请务必仔细阅读试卷上的每一道题目要求。',
      'Zài dātíkǎ shang zuòdá zhīqián, qǐng wùbì zǐxì yuèdú shìjuàn shang de měi yí dào tímù yāoqiú.',
      'Trước khi làm bài trên phiếu trả lời, xin nhất thiết phải đọc kỹ càng yêu cầu của từng câu hỏi trên đề thi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在答题卡上作答之前，请务必仔细阅读试卷上的每一道题目要求。', 'Zài dātíkǎ shang zuòdá zhīqián, qǐng wùbì zǐxì yuèdú shìjuàn shang de měi yí dào tímù yāoqiú.', 'Trước khi làm bài trên phiếu trả lời, xin nhất thiết phải đọc kỹ càng yêu cầu của từng câu hỏi trên đề thi.', 'basic', 1),
      (v_id, '研究生毕业论文选题应当紧扣学科前沿理论动态与国家重大工程实际急需，避免题目空泛脱离实践。', 'Yánjiūshēng bìyè lùnwén xuǎntí yīngdāng jǐnkòu xuékē qiányán lǐlùn dòngtài yǔ guójiā zhòngdà gōngchéng shíjì jíxū, bìmiǎn tímù kōngfàn tuōlí shíjiàn.', 'Việc lựa chọn đề tài luận văn tốt nghiệp của học viên cao học cần bám sát diễn biến lý luận mũi nhọn của ngành học và nhu cầu thực tế cấp bách của các công trình trọng điểm quốc gia, tránh để đề tài rỗng tuếch xa rời thực tiễn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3116] [提起] (tíqǐ) - nhắc tới, đề cập đến; nhấc lên, xách lên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '提起' AND pinyin = 'tíqǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提起' AND pinyin = 'tíqǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '提起'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提起'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tíqǐ',
      meaning_vi = 'nhắc tới, đề cập đến; nhấc lên, xách lên',
      example_hanzi = '每当提起那位当年在艰苦岁月里无私帮助过自己的老班长，他眼里总是闪烁着感激的泪花。',
      example_pinyin = 'Měidāng tíqǐ nà wèi dāngnián zài jiānkǔ suìyuè lǐ wúsī bāngzhù guò zìjǐ de lǎo bānzhǎng, tā yǎn lǐ zǒngshì shǎnshuò zhe gǎnjī de lèihuā.',
      example_vi = 'Mỗi khi nhắc tới người lớp trưởng năm xưa từng vô tư giúp đỡ mình trong những năm tháng gian khổ, trong mắt anh ấy luôn lấp lánh những giọt nước mắt biết ơn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '提起',
      'tíqǐ',
      'nhắc tới, đề cập đến; nhấc lên, xách lên',
      'Động từ',
      'HSK 5',
      '每当提起那位当年在艰苦岁月里无私帮助过自己的老班长，他眼里总是闪烁着感激的泪花。',
      'Měidāng tíqǐ nà wèi dāngnián zài jiānkǔ suìyuè lǐ wúsī bāngzhù guò zìjǐ de lǎo bānzhǎng, tā yǎn lǐ zǒngshì shǎnshuò zhe gǎnjī de lèihuā.',
      'Mỗi khi nhắc tới người lớp trưởng năm xưa từng vô tư giúp đỡ mình trong những năm tháng gian khổ, trong mắt anh ấy luôn lấp lánh những giọt nước mắt biết ơn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每当提起那位当年在艰苦岁月里无私帮助过自己的老班长，他眼里总是闪烁着感激的泪花。', 'Měidāng tíqǐ nà wèi dāngnián zài jiānkǔ suìyuè lǐ wúsī bāngzhù guò zìjǐ de lǎo bānzhǎng, tā yǎn lǐ zǒngshì shǎnshuò zhe gǎnjī de lèihuā.', 'Mỗi khi nhắc tới người lớp trưởng năm xưa từng vô tư giúp đỡ mình trong những năm tháng gian khổ, trong mắt anh ấy luôn lấp lánh những giọt nước mắt biết ơn.', 'basic', 1),
      (v_id, '针对跨国企业严重侵害中小投资者合法权益的证券欺诈行为，投资者保护机构依法向管辖法院提起证券民事集体诉讼。', 'Zhēnduì kuàguó qǐyè yánzhòng qīnhài zhōng-xiǎo tóuzīzhě héfǎ quányì de zhèngquàn qīzhà xíngwéi, tóuzīzhě bǎohù jīgòu yīfǎ xiàng guǎnxiá fǎyuàn tíqǐ zhèngquàn mínshì jítǐ sùsòng.', 'Nhắm vào hành vi gian lận chứng khoán xâm hại nghiêm trọng quyền lợi hợp pháp của các nhà đầu tư vừa và nhỏ của doanh nghiệp đa quốc gia, cơ quan bảo vệ nhà đầu tư đã đệ đơn khởi kiện tập thể dân sự chứng khoán lên tòa án có thẩm quyền theo luật định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3117] [提升] (tíshēng) - nâng cao, cải thiện, thăng tiến [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '提升' AND pinyin = 'tíshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提升' AND pinyin = 'tíshēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '提升'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提升'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tíshēng',
      meaning_vi = 'nâng cao, cải thiện, thăng tiến',
      example_hanzi = '为了提升团队整体的工作效率，公司定期为员工举办专业技能培训课程。',
      example_pinyin = 'Wèile tíshēng tuánduì zhěngtǐ de gōngzuò xiàolǜ, gōngsī dìngqī wèi yuángōng jǔbàn zhuānyè jìnéng péixùn kèchéng.',
      example_vi = 'Nhằm nâng cao hiệu suất làm việc chung của đội ngũ, công ty định kỳ tổ chức các khóa đào tạo kỹ năng chuyên môn cho nhân viên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '提升',
      'tíshēng',
      'nâng cao, cải thiện, thăng tiến',
      'Động từ',
      'HSK 5',
      '为了提升团队整体的工作效率，公司定期为员工举办专业技能培训课程。',
      'Wèile tíshēng tuánduì zhěngtǐ de gōngzuò xiàolǜ, gōngsī dìngqī wèi yuángōng jǔbàn zhuānyè jìnéng péixùn kèchéng.',
      'Nhằm nâng cao hiệu suất làm việc chung của đội ngũ, công ty định kỳ tổ chức các khóa đào tạo kỹ năng chuyên môn cho nhân viên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了提升团队整体的工作效率，公司定期为员工举办专业技能培训课程。', 'Wèile tíshēng tuánduì zhěngtǐ de gōngzuò xiàolǜ, gōngsī dìngqī wèi yuángōng jǔbàn zhuānyè jìnéng péixùn kèchéng.', 'Nhằm nâng cao hiệu suất làm việc chung của đội ngũ, công ty định kỳ tổ chức các khóa đào tạo kỹ năng chuyên môn cho nhân viên.', 'basic', 1),
      (v_id, '着力提升自主创新能力与产业链供应链韧性安全水平，是构建现代化产业体系并抵御外部极端风险冲击的核心支柱。', 'Zhuólì tíshēng zìzhǔ chuàngxīn nénglì yǔ chǎnyèliàn gōngyìngliàn rènxìng ānquán shuǐpíng, shì gòujiàn xiàndàihuà chǎnyè tǐxì bìng dǐyù wàibù jíduān fēngxiǎn chōngjī de héxīn zhīzhù.', 'Tập trung nâng cao năng lực đổi mới tự chủ và trình độ an toàn chống chịu của chuỗi sản xuất chuỗi cung ứng là trụ cột cốt lõi để xây dựng hệ thống ngành hiện đại và chống đỡ những cú sốc rủi ro cực đoan từ bên ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3118] [提问] (tíwèn) - đặt câu hỏi, nêu câu hỏi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '提问' AND pinyin = 'tíwèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提问' AND pinyin = 'tíwèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '提问'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '提问'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tíwèn',
      meaning_vi = 'đặt câu hỏi, nêu câu hỏi',
      example_hanzi = '讲座结束后留出了二十分钟的自由互动时间，现场听众纷纷举手向主讲嘉宾提问。',
      example_pinyin = 'Jiǎngzuò jiéshù hòu liú chū le èrshí fēnzhōng de zìyóu hùdòng shíjiān, xiànchǎng tīngzhòng fēnfēn jǔshǒu xiàng zhǔjiǎng jiābīn tíwèn.',
      example_vi = 'Sau khi buổi tọa đàm kết thúc đã dành ra 20 phút giao lưu tự do, thính giả tại hiện trường tới tấp giơ tay đặt câu hỏi cho vị khách mời diễn giả chính.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '提问',
      'tíwèn',
      'đặt câu hỏi, nêu câu hỏi',
      'Động từ',
      'HSK 5',
      '讲座结束后留出了二十分钟的自由互动时间，现场听众纷纷举手向主讲嘉宾提问。',
      'Jiǎngzuò jiéshù hòu liú chū le èrshí fēnzhōng de zìyóu hùdòng shíjiān, xiànchǎng tīngzhòng fēnfēn jǔshǒu xiàng zhǔjiǎng jiābīn tíwèn.',
      'Sau khi buổi tọa đàm kết thúc đã dành ra 20 phút giao lưu tự do, thính giả tại hiện trường tới tấp giơ tay đặt câu hỏi cho vị khách mời diễn giả chính.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '讲座结束后留出了二十分钟的自由互动时间，现场听众纷纷举手向主讲嘉宾提问。', 'Jiǎngzuò jiéshù hòu liú chū le èrshí fēnzhōng de zìyóu hùdòng shíjiān, xiànchǎng tīngzhòng fēnfēn jǔshǒu xiàng zhǔjiǎng jiābīn tíwèn.', 'Sau khi buổi tọa đàm kết thúc đã dành ra 20 phút giao lưu tự do, thính giả tại hiện trường tới tấp giơ tay đặt câu hỏi cho vị khách mời diễn giả chính.', 'basic', 1),
      (v_id, '在国际学术前沿高峰论坛的答辩环节，与会顶尖同行专家围绕实验边界设定与多模态数据拟合精度展开了极具深度的连续提问。', 'Zài guójì xuéshù qiányán gāofēng lùntán de dābiàn huánjié, yùhuì dǐngjiān tóngháng zhuānjiā wéirào shíyàn biānjiè shèdìng yǔ duō-mótài shùjù nǐhé jīngdù zhǎnkāi le jí jù shēndù de liánxù tíwèn.', 'Trong phần bảo vệ của diễn đàn đỉnh cao học thuật mũi nhọn quốc tế, các chuyên gia đồng nghiệp hàng đầu tham dự đã liên tiếp đặt ra những câu hỏi vô cùng sâu sắc xoay quanh việc thiết lập ranh giới thí nghiệm và độ chính xác khớp dữ liệu đa phương thức.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3119] [体会] (tǐhuì) - lĩnh hội, cảm nhận sâu sắc; bài học thấm thía [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '体会' AND pinyin = 'tǐhuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '体会' AND pinyin = 'tǐhuì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '体会'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '体会'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'tǐhuì',
      meaning_vi = 'lĩnh hội, cảm nhận sâu sắc; bài học thấm thía',
      example_hanzi = '只有亲身经历过偏远山区的支教生活，才能深刻体会到乡村教师付出的艰辛与崇高。',
      example_pinyin = 'Zhǐyào qīnshēn jīnglì guò piānyuǎn shānqū de zhījiào shēnghuó, cái néng shēnkè tǐhuì dào xiāngcūn jiàoshī fùchū de jiānxīn yǔ chónggāo.',
      example_vi = 'Chỉ khi đích thân trải qua cuộc sống đi dạy tình nguyện ở vùng núi hẻo lánh thì mới có thể thấm thía sâu sắc những gian khổ nhọc nhằn và sự cao cả mà các giáo viên làng quê đã bỏ ra.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '体会',
      'tǐhuì',
      'lĩnh hội, cảm nhận sâu sắc; bài học thấm thía',
      'Động từ / Danh từ',
      'HSK 5',
      '只有亲身经历过偏远山区的支教生活，才能深刻体会到乡村教师付出的艰辛与崇高。',
      'Zhǐyào qīnshēn jīnglì guò piānyuǎn shānqū de zhījiào shēnghuó, cái néng shēnkè tǐhuì dào xiāngcūn jiàoshī fùchū de jiānxīn yǔ chónggāo.',
      'Chỉ khi đích thân trải qua cuộc sống đi dạy tình nguyện ở vùng núi hẻo lánh thì mới có thể thấm thía sâu sắc những gian khổ nhọc nhằn và sự cao cả mà các giáo viên làng quê đã bỏ ra.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只有亲身经历过偏远山区的支教生活，才能深刻体会到乡村教师付出的艰辛与崇高。', 'Zhǐyào qīnshēn jīnglì guò piānyuǎn shānqū de zhījiào shēnghuó, cái néng shēnkè tǐhuì dào xiāngcūn jiàoshī fùchū de jiānxīn yǔ chónggāo.', 'Chỉ khi đích thân trải qua cuộc sống đi dạy tình nguyện ở vùng núi hẻo lánh thì mới có thể thấm thía sâu sắc những gian khổ nhọc nhằn và sự cao cả mà các giáo viên làng quê đã bỏ ra.', 'basic', 1),
      (v_id, '从波澜壮阔的百年工业化奋斗征程中，我们深刻体会到坚持科技自主创新与弘扬工匠精神是实现制造强国的必由之路。', 'Cóng bōlán-zhuàngkuò de bǎinián gōngyèhuà fèndòu zhēngchéng zhōng, wǒmen shēnkè tǐhuì dào jiānchí kējì zìzhǔ chuàngxīn yǔ hóngyáng gōngjiàng jīngshén shì shíxiàn zhìzào qiángguó de bìyóuzhīlù.', 'Từ chặng đường phấn đấu công nghiệp hóa trăm năm hào hùng tráng lệ, chúng ta thấm thía sâu sắc rằng kiên trì đổi mới công nghệ tự chủ và phát huy tinh thần người thợ thủ công lành nghề là con đường tất yếu để hiện thực hóa một cường quốc chế tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3120] [体力] (tǐlì) - thể lực, sức lực cơ bắp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '体力' AND pinyin = 'tǐlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '体力' AND pinyin = 'tǐlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '体力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '体力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tǐlì',
      meaning_vi = 'thể lực, sức lực cơ bắp',
      example_hanzi = '经过长达四十公里的马拉松长跑，参赛选手的体力几乎已经消耗到了极限。',
      example_pinyin = 'Jīngguò cháng dá sìshí gōnglǐ de mǎlāsōng chángpǎo, cānsài xuǎnshǒu de tǐlì jīhū yǐjīng xiāohào dào le jíxiàn.',
      example_vi = 'Sau cuộc chạy cự ly dài marathon hơn 40 km, thể lực của các vận động viên dự thi hầu như đã tiêu hao tới giới hạn cực đại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '体力',
      'tǐlì',
      'thể lực, sức lực cơ bắp',
      'Danh từ',
      'HSK 5',
      '经过长达四十公里的马拉松长跑，参赛选手的体力几乎已经消耗到了极限。',
      'Jīngguò cháng dá sìshí gōnglǐ de mǎlāsōng chángpǎo, cānsài xuǎnshǒu de tǐlì jīhū yǐjīng xiāohào dào le jíxiàn.',
      'Sau cuộc chạy cự ly dài marathon hơn 40 km, thể lực của các vận động viên dự thi hầu như đã tiêu hao tới giới hạn cực đại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过长达四十公里的马拉松长跑，参赛选手的体力几乎已经消耗到了极限。', 'Jīngguò cháng dá sìshí gōnglǐ de mǎlāsōng chángpǎo, cānsài xuǎnshǒu de tǐlì jīhū yǐjīng xiāohào dào le jíxiàn.', 'Sau cuộc chạy cự ly dài marathon hơn 40 km, thể lực của các vận động viên dự thi hầu như đã tiêu hao tới giới hạn cực đại.', 'basic', 1),
      (v_id, '工业外骨骼机器人的推广应用大幅减轻了重载搬运工人的体力负荷，有力保障了特种作业工人的职业健康与作业安全。', 'Gōngyè wàigǔgé jīqìrén de tuīguǎng yìngyòng dàfú jiǎnqīng le zhòngzǎi bānyùn gōngrén de tǐlì fùhè, yǒulì bǎozhàng le tèzhǒng zuòyè gōngrén de zhíyè jiànkāng yǔ zuòyè ānquán.', 'Việc nhân rộng ứng dụng robot khung xương ngoài công nghiệp đã giảm tải mạnh mẽ gánh nặng thể lực cho công nhân bốc vác tải trọng nặng, bảo đảm vững chắc sức khỏe nghề nghiệp và an toàn tác nghiệp cho công nhân làm việc đặc thù.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3121] [体现] (tǐxiàn) - thể hiện, biểu hiện ra, phản ánh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '体现' AND pinyin = 'tǐxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '体现' AND pinyin = 'tǐxiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '体现'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '体现'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tǐxiàn',
      meaning_vi = 'thể hiện, biểu hiện ra, phản ánh',
      example_hanzi = '在公共汽车上主动给老弱病残孕乘客让座，体现了良好的社会文明公德。',
      example_pinyin = 'Zài gōnggòng qìchē shang zhǔdòng gěi lǎo-ruò-bìng-cán-yùn chéngkè ràngzuò, tǐxiàn le liánghǎo de shèhuì wénmíng gōngdé.',
      example_vi = 'Chủ động nhường ghế cho hành khách già yếu bệnh tật mang thai trên xe buýt thể hiện đạo đức văn minh công cộng tốt đẹp của xã hội.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '体现',
      'tǐxiàn',
      'thể hiện, biểu hiện ra, phản ánh',
      'Động từ',
      'HSK 5',
      '在公共汽车上主动给老弱病残孕乘客让座，体现了良好的社会文明公德。',
      'Zài gōnggòng qìchē shang zhǔdòng gěi lǎo-ruò-bìng-cán-yùn chéngkè ràngzuò, tǐxiàn le liánghǎo de shèhuì wénmíng gōngdé.',
      'Chủ động nhường ghế cho hành khách già yếu bệnh tật mang thai trên xe buýt thể hiện đạo đức văn minh công cộng tốt đẹp của xã hội.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在公共汽车上主动给老弱病残孕乘客让座，体现了良好的社会文明公德。', 'Zài gōnggòng qìchē shang zhǔdòng gěi lǎo-ruò-bìng-cán-yùn chéngkè ràngzuò, tǐxiàn le liánghǎo de shèhuì wénmíng gōngdé.', 'Chủ động nhường ghế cho hành khách già yếu bệnh tật mang thai trên xe buýt thể hiện đạo đức văn minh công cộng tốt đẹp của xã hội.', 'basic', 1),
      (v_id, '坚持在发展中保障和改善民生，切实解决人民群众急难愁盼问题，集中体现了我们党全心全意为人民服务的根本宗旨。', 'Jiānchí zài fāzhǎn zhōng bǎozhàng hé gǎishàn mínshēng, qièshí jiějué rénmín qúnzhòng jínán-chóupàn wèntí, jízhōng tǐxiàn le wǒmen dǎng quánxīn-quányì wèi rénmín fúwù de gēnběn zōngzhǐ.', 'Kiên trì bảo đảm và cải thiện dân sinh trong quá trình phát triển, thiết thực giải quyết các vấn đề cấp bách thiết thân của quần chúng nhân dân đã thể hiện tập trung tôn chỉ căn bản hết lòng hết sức phục vụ nhân dân của Đảng ta.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3122] [体验] (tǐyàn) - trải nghiệm; sự trải nghiệm thực tế [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '体验' AND pinyin = 'tǐyàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '体验' AND pinyin = 'tǐyàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '体验'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '体验'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'tǐyàn',
      meaning_vi = 'trải nghiệm; sự trải nghiệm thực tế',
      example_hanzi = '科技馆里的虚拟现实互动展区为前来参观的小朋友们提供了身临其境的太空漫游体验。',
      example_pinyin = 'Kējìguǎn lǐ de xūnǐ xiànshí hùdòng zhǎnqū wèi qiánlái cānguān de xiǎopéngyǒumen tígōng le shēnlínqíjìng de tàikōng mànyóu tǐyàn.',
      example_vi = 'Khu triển lãm tương tác thực tế ảo trong bảo tàng khoa học đã mang lại trải nghiệm du ngoạn vũ trụ như đang trực tiếp đắm mình trong không gian cho các em nhỏ tới tham quan.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '体验',
      'tǐyàn',
      'trải nghiệm; sự trải nghiệm thực tế',
      'Động từ / Danh từ',
      'HSK 5',
      '科技馆里的虚拟现实互动展区为前来参观的小朋友们提供了身临其境的太空漫游体验。',
      'Kējìguǎn lǐ de xūnǐ xiànshí hùdòng zhǎnqū wèi qiánlái cānguān de xiǎopéngyǒumen tígōng le shēnlínqíjìng de tàikōng mànyóu tǐyàn.',
      'Khu triển lãm tương tác thực tế ảo trong bảo tàng khoa học đã mang lại trải nghiệm du ngoạn vũ trụ như đang trực tiếp đắm mình trong không gian cho các em nhỏ tới tham quan.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '科技馆里的虚拟现实互动展区为前来参观的小朋友们提供了身临其境的太空漫游体验。', 'Kējìguǎn lǐ de xūnǐ xiànshí hùdòng zhǎnqū wèi qiánlái cānguān de xiǎopéngyǒumen tígōng le shēnlínqíjìng de tàikōng mànyóu tǐyàn.', 'Khu triển lãm tương tác thực tế ảo trong bảo tàng khoa học đã mang lại trải nghiệm du ngoạn vũ trụ như đang trực tiếp đắm mình trong không gian cho các em nhỏ tới tham quan.', 'basic', 1),
      (v_id, '移动应用产品架构师必须将敏捷开发与深度用户体验反馈循环紧密结合，持续打磨微秒级界面响应与直觉化交互设计。', 'Yídòng yìngyòng chǎnpǐn jiàgòushī bìxū jiāng mǐnjié kāifā yǔ shēndù yònghù tǐyàn fǎnkuì xúnhuán jǐnmì jiéhé, chíxù dǎmó wēimiǎojí jièmiàn xiǎngyìng yǔ zhíjuéhuà jiāohù shèjì.', 'Kiến trúc sư sản phẩm ứng dụng di động bắt buộc phải kết hợp chặt chẽ việc phát triển linh hoạt với vòng lặp phản hồi trải nghiệm người dùng chuyên sâu, liên tục mài giũa tốc độ phản hồi giao diện tính bằng micro giây và thiết kế tương tác theo trực giác.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3123] [替] (tì) - thay thế; thay cho, giùm cho [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '替' AND pinyin = 'tì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '替' AND pinyin = 'tì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '替'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '替'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Giới từ',
      pinyin = 'tì',
      meaning_vi = 'thay thế; thay cho, giùm cho',
      example_hanzi = '同事今天突发生病请假，热心的张明主动替他承担了下午的客户接待工作。',
      example_pinyin = 'Tóngshì jīntiān tūfā shēngbìng qǐngjià, rèxīn de Zhāng Míng zhǔdòng tì tā chéngdān le xiàwǔ de kèhù jiēdài gōngzuò.',
      example_vi = 'Đồng nghiệp hôm nay đột nhiên bị ốm xin nghỉ, Trương Minh nhiệt tình đã chủ động làm thay anh ấy công việc tiếp đón khách hàng buổi chiều.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '替',
      'tì',
      'thay thế; thay cho, giùm cho',
      'Động từ / Giới từ',
      'HSK 5',
      '同事今天突发生病请假，热心的张明主动替他承担了下午的客户接待工作。',
      'Tóngshì jīntiān tūfā shēngbìng qǐngjià, rèxīn de Zhāng Míng zhǔdòng tì tā chéngdān le xiàwǔ de kèhù jiēdài gōngzuò.',
      'Đồng nghiệp hôm nay đột nhiên bị ốm xin nghỉ, Trương Minh nhiệt tình đã chủ động làm thay anh ấy công việc tiếp đón khách hàng buổi chiều.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '同事今天突发生病请假，热心的张明主动替他承担了下午的客户接待工作。', 'Tóngshì jīntiān tūfā shēngbìng qǐngjià, rèxīn de Zhāng Míng zhǔdòng tì tā chéngdān le xiàwǔ de kèhù jiēdài gōngzuò.', 'Đồng nghiệp hôm nay đột nhiên bị ốm xin nghỉ, Trương Minh nhiệt tình đã chủ động làm thay anh ấy công việc tiếp đón khách hàng buổi chiều.', 'basic', 1),
      (v_id, '工业智能化升级的核心逻辑是用高精度机械装备替代高危繁重的人力劳动，从而大幅提升生产本质安全水平。', 'Gōngyè zhìnénghuà shēngjí de héxīn luóji shì yòng gāo-jīngdù jīxiè zhuāngbèi tìdài gāowēi fánzhòng de rénlì láodòng, cóng’ér dàfú tíshēng shēngchǎn běnzhì ānquán shuǐpíng.', 'Logic cốt lõi của nâng cấp thông minh hóa công nghiệp là dùng trang thiết bị cơ giới hóa độ chính xác cao để thay thế lao động chân tay nặng nhọc nguy hiểm, từ đó nâng cao mạnh mẽ trình độ an toàn bản chất trong sản xuất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3124] [天空] (tiānkōng) - bầu trời, vòm trời [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '天空' AND pinyin = 'tiānkōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '天空' AND pinyin = 'tiānkōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '天空'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '天空'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tiānkōng',
      meaning_vi = 'bầu trời, vòm trời',
      example_hanzi = '雨后初晴，蔚蓝的天空中架起了一道绚丽夺目的七色彩虹。',
      example_pinyin = 'Yǔ hòu chū qíng, wèilán de tiānkōng zhōng jià qǐ le yí dào xuànlì-duómù de qīsè cǎihóng.',
      example_vi = 'Mưa tạnh trời hửng nắng, trên bầu trời trong xanh bắc lên một dải cầu vồng bảy sắc lung linh rực rỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '天空',
      'tiānkōng',
      'bầu trời, vòm trời',
      'Danh từ',
      'HSK 5',
      '雨后初晴，蔚蓝的天空中架起了一道绚丽夺目的七色彩虹。',
      'Yǔ hòu chū qíng, wèilán de tiānkōng zhōng jià qǐ le yí dào xuànlì-duómù de qīsè cǎihóng.',
      'Mưa tạnh trời hửng nắng, trên bầu trời trong xanh bắc lên một dải cầu vồng bảy sắc lung linh rực rỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '雨后初晴，蔚蓝的天空中架起了一道绚丽夺目的七色彩虹。', 'Yǔ hòu chū qíng, wèilán de tiānkōng zhōng jià qǐ le yí dào xuànlì-duómù de qīsè cǎihóng.', 'Mưa tạnh trời hửng nắng, trên bầu trời trong xanh bắc lên một dải cầu vồng bảy sắc lung linh rực rỡ.', 'basic', 1),
      (v_id, '大力发展低空经济与无人驾驶载人eVTOL航空器，正在重构现代立体交通网络并向广阔的天空拓展城市发展新维度。', 'Dàlì fāzhǎn dīkōng jīngjì yǔ wúrén jiàshǐ zàirén eVTOL hángkōngqì, zhèngzài chónggòu xiàndài lìtǐ jiāotōng wǎngluò bìng xiàng guǎngkuò de tiānkōng tuòzhǎn chéngshì fāzhǎn xīn wéidù.', 'Ra sức phát triển kinh tế tầm thấp và phương tiện bay chở người không người lái eVTOL đang tái cấu trúc mạng lưới giao thông lập thể hiện đại và mở rộng chiều hướng phát triển đô thị mới vươn tới vòm trời bao la.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3125] [天上] (tiānshàng) - trên trời, trên không trung [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '天上' AND pinyin = 'tiānshàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '天上' AND pinyin = 'tiānshàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '天上'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '天上'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tiānshàng',
      meaning_vi = 'trên trời, trên không trung',
      example_hanzi = '夏天的夜晚凉风习习，天上挂着一轮皎洁明亮的弯弯月亮。',
      example_pinyin = 'Xiàtiān de yèwǎn liángfēng-xíxí, tiānshang guà zhe yì lún jiǎojié míngliàng de wānwān yuèliang.',
      example_vi = 'Đêm mùa hè gió mát hiu hiu, trên trời treo một vầng trăng khuyết sáng trong vằng vặc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '天上',
      'tiānshàng',
      'trên trời, trên không trung',
      'Danh từ',
      'HSK 5',
      '夏天的夜晚凉风习习，天上挂着一轮皎洁明亮的弯弯月亮。',
      'Xiàtiān de yèwǎn liángfēng-xíxí, tiānshang guà zhe yì lún jiǎojié míngliàng de wānwān yuèliang.',
      'Đêm mùa hè gió mát hiu hiu, trên trời treo một vầng trăng khuyết sáng trong vằng vặc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夏天的夜晚凉风习习，天上挂着一轮皎洁明亮的弯弯月亮。', 'Xiàtiān de yèwǎn liángfēng-xíxí, tiānshang guà zhe yì lún jiǎojié míngliàng de wānwān yuèliang.', 'Đêm mùa hè gió mát hiu hiu, trên trời treo một vầng trăng khuyết sáng trong vằng vặc.', 'basic', 1),
      (v_id, '我国高分辨率对地观测系统犹如日夜巡航在天上的“天眼”，为国家资源勘查、生态监测与防灾减灾提供高频遥感保障。', 'Wǒguó gāo-fēnbianlǜ duìdì guāncè xìtǒng yóurú rìyè xúnháng zài tiānshang de “tiānyǎn”, wèi guójiā zīyuán kānchá, shēngtài jiānkòng yǔ fángzāi-jiǎnzāi tígōng gāopín yáogǎn bǎozhàng.', 'Hệ thống quan sát Trái Đất độ phân giải cao của nước ta tựa như "mắt thần" ngày đêm tuần tra trên trời, bảo đảm viễn thám tần suất cao cho công tác thăm dò tài nguyên quốc gia, giám sát sinh thái và phòng chống giảm nhẹ thiên tai.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3126] [填] (tián) - điền vào, lấp đầy, viết vào [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '填' AND pinyin = 'tián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '填' AND pinyin = 'tián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '填'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '填'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tián',
      meaning_vi = 'điền vào, lấp đầy, viết vào',
      example_hanzi = '报考大学志愿时，考生需要认真核对代码并准确填报志愿表格。',
      example_pinyin = 'Bàokǎo dàxué zhìyuàn shí, kǎoshēng xūyào rènzhēn héduì dàimǎ bìng zhǔnquè tiánbào zhìyuàn biǎogé.',
      example_vi = 'Khi đăng ký nguyện vọng đại học, thí sinh cần đối chiếu kỹ mã ngành và điền chính xác vào biểu mẫu nguyện vọng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '填',
      'tián',
      'điền vào, lấp đầy, viết vào',
      'Động từ',
      'HSK 5',
      '报考大学志愿时，考生需要认真核对代码并准确填报志愿表格。',
      'Bàokǎo dàxué zhìyuàn shí, kǎoshēng xūyào rènzhēn héduì dàimǎ bìng zhǔnquè tiánbào zhìyuàn biǎogé.',
      'Khi đăng ký nguyện vọng đại học, thí sinh cần đối chiếu kỹ mã ngành và điền chính xác vào biểu mẫu nguyện vọng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '报考大学志愿时，考生需要认真核对代码并准确填报志愿表格。', 'Bàokǎo dàxué zhìyuàn shí, kǎoshēng xūyào rènzhēn héduì dàimǎ bìng zhǔnquè tiánbào zhìyuàn biǎogé.', 'Khi đăng ký nguyện vọng đại học, thí sinh cần đối chiếu kỹ mã ngành và điền chính xác vào biểu mẫu nguyện vọng.', 'basic', 1),
      (v_id, '自主研制第四代核电高温气冷堆燃料元件，成功填补了我国在先进商用核电固有安全堆型关键材料领域的空白。', 'Zìzhǔ yánzhì dì-sì-dài hédiàn gāowēn qìlěngduī ránliào yuánjiàn, chénggōng tiánbǔ le wǒguó zài xiānjìn shāngyòng hédiàn gùyǒu ānquán duīxíng guānjiàn cáiliào lǐngyù de kòngbái.', 'Việc tự chủ nghiên cứu chế tạo thành công nguyên tố nhiên liệu lò phản ứng hạt nhân khí làm mát nhiệt độ cao thế hệ thứ tư đã lấp đầy khoảng trống của nước ta trong lĩnh vực vật liệu then chốt cho các mẫu lò an toàn nội tại thương mại tiên tiến.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3127] [甜品] (tiánpǐn) - món tráng miệng ngọt, đồ ngọt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '甜品' AND pinyin = 'tiánpǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '甜品' AND pinyin = 'tiánpǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '甜品'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '甜品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tiánpǐn',
      meaning_vi = 'món tráng miệng ngọt, đồ ngọt',
      example_hanzi = '丰盛的西餐晚宴结束后，服务员端上了精心制作的冰淇淋和巧克力蛋糕等甜品。',
      example_pinyin = 'Fēngshèng de xīcān wǎnyàn jiéshù hòu, fúwùyuán duān shàng le jīngxīn zhìzuò de bīngqílín hé qiǎokèlì dàngāo děng tiánpǐn.',
      example_vi = 'Sau khi bữa tiệc tối đồ Tây thịnh soạn kết thúc, người phục vụ bưng lên các món tráng miệng như kem và bánh gato sô-cô-la được chế biến tinh tế.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '甜品',
      'tiánpǐn',
      'món tráng miệng ngọt, đồ ngọt',
      'Danh từ',
      'HSK 5',
      '丰盛的西餐晚宴结束后，服务员端上了精心制作的冰淇淋和巧克力蛋糕等甜品。',
      'Fēngshèng de xīcān wǎnyàn jiéshù hòu, fúwùyuán duān shàng le jīngxīn zhìzuò de bīngqílín hé qiǎokèlì dàngāo děng tiánpǐn.',
      'Sau khi bữa tiệc tối đồ Tây thịnh soạn kết thúc, người phục vụ bưng lên các món tráng miệng như kem và bánh gato sô-cô-la được chế biến tinh tế.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '丰盛的西餐晚宴结束后，服务员端上了精心制作的冰淇淋和巧克力蛋糕等甜品。', 'Fēngshèng de xīcān wǎnyàn jiéshù hòu, fúwùyuán duān shàng le jīngxīn zhìzuò de bīngqílín hé qiǎokèlì dàngāo děng tiánpǐn.', 'Sau khi bữa tiệc tối đồ Tây thịnh soạn kết thúc, người phục vụ bưng lên các món tráng miệng như kem và bánh gato sô-cô-la được chế biến tinh tế.', 'basic', 1),
      (v_id, '现代新中式烘焙品牌将低糖低脂健康理念融入传统甜品研发，成功开拓了兼顾味觉享受与养生诉求的新消费赛道。', 'Xiàndài xīn-Zhōngshì hōngbèi pǐnpái jiāng dītáng dīzhī jiànkāng lǐniàn róngrù chuántǒng tiánpǐn yánfā, chénggōng kāituò le jiāngù wèijué xiǎngshòu yǔ yǎngshēng sùqiú de xīn xiāofèi sàidào.', 'Thương hiệu làm bánh ngọt kiểu Trung Hoa mới hiện đại đã lồng ghép quan niệm sức khỏe ít đường ít béo vào nghiên cứu phát triển món tráng miệng truyền thống, mở ra thành công đường đua tiêu dùng mới kết hợp giữa thưởng thức vị giác và nhu cầu dưỡng sinh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3128] [挑] (tiāo) - chọn lựa, kén chọn; gánh trên vai [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '挑' AND pinyin = 'tiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挑' AND pinyin = 'tiāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '挑'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tiāo',
      meaning_vi = 'chọn lựa, kén chọn; gánh trên vai',
      example_hanzi = '在水果摊前买苹果时，老奶奶戴着老花镜非常细心地挑挑选选。',
      example_pinyin = 'Zài shuǐguǒ tān qián mǎi píngguǒ shí, lǎonǎinai dài zhe lǎohuājìng fēicháng xìnxīn de tiāotiāo-xuǎnxuǎn.',
      example_vi = 'Khi mua táo trước sạp hoa quả, bà cụ đeo kính lão tỉ mỉ cẩn thận chọn tới chọn lui.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '挑',
      'tiāo',
      'chọn lựa, kén chọn; gánh trên vai',
      'Động từ',
      'HSK 5',
      '在水果摊前买苹果时，老奶奶戴着老花镜非常细心地挑挑选选。',
      'Zài shuǐguǒ tān qián mǎi píngguǒ shí, lǎonǎinai dài zhe lǎohuājìng fēicháng xìnxīn de tiāotiāo-xuǎnxuǎn.',
      'Khi mua táo trước sạp hoa quả, bà cụ đeo kính lão tỉ mỉ cẩn thận chọn tới chọn lui.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在水果摊前买苹果时，老奶奶戴着老花镜非常细心地挑挑选选。', 'Zài shuǐguǒ tān qián mǎi píngguǒ shí, lǎonǎinai dài zhe lǎohuājìng fēicháng xìnxīn de tiāotiāo-xuǎnxuǎn.', 'Khi mua táo trước sạp hoa quả, bà cụ đeo kính lão tỉ mỉ cẩn thận chọn tới chọn lui.', 'basic', 1),
      (v_id, '青年科技领军人才当勇挑国家战略科技攻关重担，在“卡脖子”核心技术领域打头阵、攻难关。', 'Qīngnián kējì lǐngjūn réncái dāng yǒng tiāo guójiā zhànlüè kējì gōngguān zhòngdàn, zài “qiǎbózi” héxīn jìshù lǐngyù dǎ tóuzhèn, gōng nánguān.', 'Nhân tài trẻ dẫn đầu khoa học công nghệ phải dũng cảm gánh vác trọng trách khắc phục khó khăn công nghệ chiến lược quốc gia, đi tiên phong xung kích công phá các cửa ải hiểm nghèo trong các lĩnh vực công nghệ cốt lõi bị "nghẽn cổ chai".', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3129] [挑选] (tiāoxuǎn) - chọn lựa, tuyển chọn kỹ càng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '挑选' AND pinyin = 'tiāoxuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挑选' AND pinyin = 'tiāoxuǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '挑选'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挑选'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tiāoxuǎn',
      meaning_vi = 'chọn lựa, tuyển chọn kỹ càng',
      example_hanzi = '新学期开始前，妈妈带他去书店精心挑选了几本优秀的课外阅读辅导书。',
      example_pinyin = 'Xīn xuéqī kāishǐ qián, māma dài tā qù shūdiàn jīngxīn tiāoxuǎn le jǐ běn yōuxiù de kèwài yuèdú fǔdǎoshū.',
      example_vi = 'Trước khi học kỳ mới bắt đầu, mẹ dẫn em tới hiệu sách tỉ mỉ chọn lựa mấy cuốn sách bổ trợ đọc ngoại khóa xuất sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '挑选',
      'tiāoxuǎn',
      'chọn lựa, tuyển chọn kỹ càng',
      'Động từ',
      'HSK 5',
      '新学期开始前，妈妈带他去书店精心挑选了几本优秀的课外阅读辅导书。',
      'Xīn xuéqī kāishǐ qián, māma dài tā qù shūdiàn jīngxīn tiāoxuǎn le jǐ běn yōuxiù de kèwài yuèdú fǔdǎoshū.',
      'Trước khi học kỳ mới bắt đầu, mẹ dẫn em tới hiệu sách tỉ mỉ chọn lựa mấy cuốn sách bổ trợ đọc ngoại khóa xuất sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新学期开始前，妈妈带他去书店精心挑选了几本优秀的课外阅读辅导书。', 'Xīn xuéqī kāishǐ qián, māma dài tā qù shūdiàn jīngxīn tiāoxuǎn le jǐ běn yōuxiù de kèwài yuèdú fǔdǎoshū.', 'Trước khi học kỳ mới bắt đầu, mẹ dẫn em tới hiệu sách tỉ mỉ chọn lựa mấy cuốn sách bổ trợ đọc ngoại khóa xuất sắc.', 'basic', 1),
      (v_id, '航天员选拔中心通过多重极其苛刻的生理极限耐受性与超重环境模拟测试，严格挑选执行深空任务的预备航天员。', 'Hángtiānyuán xuǎnbá zhōngxīn tōngguò duōchóng jíqí kěkè de shēnglǐ jíxiàn nàishòuxìng yǔ chāozhòng huánjìng mónǐ cèshì, yángé tiāoxuǎn zhíxíng shēnkōng rènwù de yùbèi hángtiānyuán.', 'Trung tâm tuyển chọn phi hành gia thông qua nhiều bài kiểm tra mô phỏng môi trường siêu trọng và khả năng chịu đựng giới hạn sinh lý cực kỳ khắt khe, đã tuyển chọn nghiêm ngặt các phi hành gia dự bị thực thi nhiệm vụ không gian sâu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3130] [调] (tiáo) - điều chỉnh, hòa trộn, nêm nếm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '调' AND pinyin = 'tiáo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调' AND pinyin = 'tiáo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '调'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tiáo',
      meaning_vi = 'điều chỉnh, hòa trộn, nêm nếm',
      example_hanzi = '厨师在炒菜出锅前，加入适量的香油和胡椒粉调味。',
      example_pinyin = 'Chúshī zài chǎocài chū guō qián, jiārù shìliàng de xiāngyóu hé hújiāofěn tiáowèi.',
      example_vi = 'Đầu bếp trước khi bắc món xào ra khỏi chảo đã cho thêm một lượng dầu mè và bột tiêu thích hợp để nêm nếm gia vị.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '调',
      'tiáo',
      'điều chỉnh, hòa trộn, nêm nếm',
      'Động từ',
      'HSK 5',
      '厨师在炒菜出锅前，加入适量的香油和胡椒粉调味。',
      'Chúshī zài chǎocài chū guō qián, jiārù shìliàng de xiāngyóu hé hújiāofěn tiáowèi.',
      'Đầu bếp trước khi bắc món xào ra khỏi chảo đã cho thêm một lượng dầu mè và bột tiêu thích hợp để nêm nếm gia vị.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '厨师在炒菜出锅前，加入适量的香油和胡椒粉调味。', 'Chúshī zài chǎocài chū guō qián, jiārù shìliàng de xiāngyóu hé hújiāofěn tiáowèi.', 'Đầu bếp trước khi bắc món xào ra khỏi chảo đã cho thêm một lượng dầu mè và bột tiêu thích hợp để nêm nếm gia vị.', 'basic', 1),
      (v_id, '中央银行综合考量通胀预期与宏观信贷增速，适时适度灵活微调公开市场逆回购操作利率。', 'Zhōngyāng yínháng zōnghé kǎoliàng tōngzhàng yùqī yǔ hóngguān xìndài zēngsù, shìshí shìdù línghuó wēitiáo gōngkāi shìchǎng nìhuígòu cāozuò lìlǜ.', 'Ngân hàng Trung ương cân nhắc tổng hợp kỳ vọng lạm phát và tốc độ tăng trưởng tín dụng vĩ mô, kịp thời điều chỉnh vi mô linh hoạt ở mức độ vừa phải đối với lãi suất nghiệp vụ mua lại nghịch trên thị trường mở.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3131] [调皮] (tiáopí) - nghịch ngợm, bướng bỉnh, tinh quái [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '调皮' AND pinyin = 'tiáopí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调皮' AND pinyin = 'tiáopí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '调皮'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调皮'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'tiáopí',
      meaning_vi = 'nghịch ngợm, bướng bỉnh, tinh quái',
      example_hanzi = '那个调皮可爱的小男孩在院子里捉迷藏，把衣服蹭得全是泥土。',
      example_pinyin = 'Nà ge tiáopí kě’ài de xiǎo nánhái zài yuànzi lǐ zhuōmícáng, bǎ yīfu cèng de quán shì nítǔ.',
      example_vi = 'Cậu bé nghịch ngợm đáng yêu kia chơi trốn tìm trong sân, làm quần áo cọ quẹt dính đầy bùn đất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '调皮',
      'tiáopí',
      'nghịch ngợm, bướng bỉnh, tinh quái',
      'Tính từ',
      'HSK 5',
      '那个调皮可爱的小男孩在院子里捉迷藏，把衣服蹭得全是泥土。',
      'Nà ge tiáopí kě’ài de xiǎo nánhái zài yuànzi lǐ zhuōmícáng, bǎ yīfu cèng de quán shì nítǔ.',
      'Cậu bé nghịch ngợm đáng yêu kia chơi trốn tìm trong sân, làm quần áo cọ quẹt dính đầy bùn đất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '那个调皮可爱的小男孩在院子里捉迷藏，把衣服蹭得全是泥土。', 'Nà ge tiáopí kě’ài de xiǎo nánhái zài yuànzi lǐ zhuōmícáng, bǎ yīfu cèng de quán shì nítǔ.', 'Cậu bé nghịch ngợm đáng yêu kia chơi trốn tìm trong sân, làm quần áo cọ quẹt dính đầy bùn đất.', 'basic', 1),
      (v_id, '优秀的幼儿启蒙教育学者善于包容儿童调皮好动的天性，将其旺盛的求知探索欲正面转化为创造性实践潜能。', 'Yōuxiù de yòu’ér qǐméng jiàoyù xuézhě shànyú bāoróng értóng tiáopí hàodòng de tiānxìng, jiāng qí wàngshèng de qiúzhī tànsuǒ yù zhèngmiàn zhuǎnhuà wèi chuàngzàoxìng shíjiàn qiánnéng.', 'Học giả giáo dục khai tâm mầm non xuất sắc rất biết cách bao dung bản tính hiếu động nghịch ngợm của trẻ nhỏ, chuyển hóa tích cực khát khao tìm tòi học hỏi mãnh liệt của trẻ thành tiềm năng thực hành mang tính sáng tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3132] [调整] (tiáozhěng) - điều chỉnh, căn chỉnh; sự điều chỉnh [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '调整' AND pinyin = 'tiáozhěng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调整' AND pinyin = 'tiáozhěng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '调整'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调整'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'tiáozhěng',
      meaning_vi = 'điều chỉnh, căn chỉnh; sự điều chỉnh',
      example_hanzi = '根据天气预报的最新降雨信息，学校及时调整了校运会的比赛日程。',
      example_pinyin = 'Gēnjù tiānqì yùbào de zuìxīn jiàngyǔ xìnxī, xuéxiào jíshí tiáozhěng le xiàoyùnhuì de bǐsài rìchéng.',
      example_vi = 'Căn cứ vào thông tin dự báo thời tiết lượng mưa mới nhất, nhà trường đã kịp thời điều chỉnh lịch thi đấu của đại hội thể thao trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '调整',
      'tiáozhěng',
      'điều chỉnh, căn chỉnh; sự điều chỉnh',
      'Động từ / Danh từ',
      'HSK 5',
      '根据天气预报的最新降雨信息，学校及时调整了校运会的比赛日程。',
      'Gēnjù tiānqì yùbào de zuìxīn jiàngyǔ xìnxī, xuéxiào jíshí tiáozhěng le xiàoyùnhuì de bǐsài rìchéng.',
      'Căn cứ vào thông tin dự báo thời tiết lượng mưa mới nhất, nhà trường đã kịp thời điều chỉnh lịch thi đấu của đại hội thể thao trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '根据天气预报的最新降雨信息，学校及时调整了校运会的比赛日程。', 'Gēnjù tiānqì yùbào de zuìxīn jiàngyǔ xìnxī, xuéxiào jíshí tiáozhěng le xiàoyùnhuì de bǐsài rìchéng.', 'Căn cứ vào thông tin dự báo thời tiết lượng mưa mới nhất, nhà trường đã kịp thời điều chỉnh lịch thi đấu của đại hội thể thao trường.', 'basic', 1),
      (v_id, '深化供给侧结构性改革必须持续推进落后过剩产能淘汰，加快推动战略性新兴产业布局优化与结构战略性调整。', 'Shēnhuà gōngjǐcè jiégòuxìng gǎigé bìxū chíxù tuījìn luòhòu guòshèng chǎnnéng táotài, jiākuài tuīdòng zhànlüèxìng xīnxīng chǎnyè bùjú yōuhuà yǔ jiégòu zhànlüèxìng tiáozhěng.', 'Đào sâu cải cách cơ cấu phía cung bắt buộc phải liên tục thúc đẩy đào thải năng lực sản xuất dư thừa lạc hậu, đẩy nhanh tối ưu hóa bố trí và điều chỉnh mang tính chiến lược về cơ cấu đối với các ngành mới nổi mang tính chiến lược.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3133] [挑战] (tiǎozhàn) - thách thức; lời thách thức, thử thách cam go [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '挑战' AND pinyin = 'tiǎozhàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挑战' AND pinyin = 'tiǎozhàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '挑战'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挑战'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'tiǎozhàn',
      meaning_vi = 'thách thức; lời thách thức, thử thách cam go',
      example_hanzi = '攀登海拔数千米的高峰对登山队员的体能和意志力都是一次极大的严峻挑战。',
      example_pinyin = 'Pāndēng hǎibá shù qiān mǐ de gāofēng duì dēngshān duìyuán de tǐnéng hé yìzhìlì dōu shì yí cì jí dà de yánjùn tiǎozhàn.',
      example_vi = 'Leo lên đỉnh núi cao hàng nghìn mét so với mực nước biển là một thử thách vô cùng khắc nghiệt đối với thể lực và ý chí của các vận động viên leo núi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '挑战',
      'tiǎozhàn',
      'thách thức; lời thách thức, thử thách cam go',
      'Động từ / Danh từ',
      'HSK 5',
      '攀登海拔数千米的高峰对登山队员的体能和意志力都是一次极大的严峻挑战。',
      'Pāndēng hǎibá shù qiān mǐ de gāofēng duì dēngshān duìyuán de tǐnéng hé yìzhìlì dōu shì yí cì jí dà de yánjùn tiǎozhàn.',
      'Leo lên đỉnh núi cao hàng nghìn mét so với mực nước biển là một thử thách vô cùng khắc nghiệt đối với thể lực và ý chí của các vận động viên leo núi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '攀登海拔数千米的高峰对登山队员的体能和意志力都是一次极大的严峻挑战。', 'Pāndēng hǎibá shù qiān mǐ de gāofēng duì dēngshān duìyuán de tǐnéng hé yìzhìlì dōu shì yí cì jí dà de yánjùn tiǎozhàn.', 'Leo lên đỉnh núi cao hàng nghìn mét so với mực nước biển là một thử thách vô cùng khắc nghiệt đối với thể lực và ý chí của các vận động viên leo núi.', 'basic', 1),
      (v_id, '面对地缘政治割裂与全球气候危机等深层次复杂挑战，国际社会应当摒弃零和博弈思维，携手构建人类命运共同体。', 'Miànduì dìyuán zhèngzhì gēliè yǔ quánqiú qìhòu wēijī děng shēncéngcì fùzá tiǎozhàn, guójì shèhuì yīngdāng bìngqì línghé bóyì sīwéi, xiéshǒu gòujiàn rénlèi mìngyùn gòngtóngtǐ.', 'Đối mặt với những thách thức phức tạp ở tầng mức sâu xa như sự chia rẽ địa chính trị và khủng hoảng khí hậu toàn cầu, cộng đồng quốc tế cần gạt bỏ tư duy được mất có tổng bằng không, kề vai sát cánh xây dựng cộng đồng chung vận mệnh nhân loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3134] [跳高] (tiàogāo) - nhảy cao (môn điền kinh) [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '跳高' AND pinyin = 'tiàogāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '跳高' AND pinyin = 'tiàogāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '跳高'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '跳高'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'tiàogāo',
      meaning_vi = 'nhảy cao (môn điền kinh)',
      example_hanzi = '在校运会男子跳高比赛中，小李凭借优美的背越式姿态一举打破了年级纪录。',
      example_pinyin = 'Zài xiàoyùnhuì nánzǐ tiàogāo bǐsài zhōng, Xiǎo Lǐ píngjiè yōuměi de bèiyuèshì zītài yìjǔ dǎpò le niánjí jìlù.',
      example_vi = 'Trong cuộc thi nhảy cao nam tại đại hội thể thao trường, Tiểu Lý nhờ tư thế nhảy lưng qua xà đẹp mắt đã một phát phá vỡ kỷ lục của khối.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '跳高',
      'tiàogāo',
      'nhảy cao (môn điền kinh)',
      'Động từ / Danh từ',
      'HSK 5',
      '在校运会男子跳高比赛中，小李凭借优美的背越式姿态一举打破了年级纪录。',
      'Zài xiàoyùnhuì nánzǐ tiàogāo bǐsài zhōng, Xiǎo Lǐ píngjiè yōuměi de bèiyuèshì zītài yìjǔ dǎpò le niánjí jìlù.',
      'Trong cuộc thi nhảy cao nam tại đại hội thể thao trường, Tiểu Lý nhờ tư thế nhảy lưng qua xà đẹp mắt đã một phát phá vỡ kỷ lục của khối.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在校运会男子跳高比赛中，小李凭借优美的背越式姿态一举打破了年级纪录。', 'Zài xiàoyùnhuì nánzǐ tiàogāo bǐsài zhōng, Xiǎo Lǐ píngjiè yōuměi de bèiyuèshì zītài yìjǔ dǎpò le niánjí jìlù.', 'Trong cuộc thi nhảy cao nam tại đại hội thể thao trường, Tiểu Lý nhờ tư thế nhảy lưng qua xà đẹp mắt đã một phát phá vỡ kỷ lục của khối.', 'basic', 1),
      (v_id, '现代运动生物力学通过高速红外三维动作捕捉系统，精细剖析跳高运动员助跑弧度、起跳制动与过杆质心轨迹。', 'Xiàndài yùndòng shēngwùlìxué tōngguò gāosù hóngwài sānwéi dòngzuò bǔzhuō xìtǒng, jīngxì pōuxī tiàogāo yùndòngyuán zhùpǎo húdù, qǐtiào zhìdòng yǔ guògān zhìxīn guǐjì.', 'Cơ sinh học thể thao hiện đại thông qua hệ thống bắt chuyển động 3D hồng ngoại tốc độ cao, đã phân tích tỉ mỉ độ cong đà chạy, phanh hãm giậm nhảy và quỹ đạo trọng tâm khi qua xà của vận động viên nhảy cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3135] [跳远] (tiàoyuǎn) - nhảy xa (môn điền kinh) [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '跳远' AND pinyin = 'tiàoyuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '跳远' AND pinyin = 'tiàoyuǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '跳远'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '跳远'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'tiàoyuǎn',
      meaning_vi = 'nhảy xa (môn điền kinh)',
      example_hanzi = '他在沙坑前全力助跑并准确踏板，成功在跳远决赛中夺得了金牌。',
      example_pinyin = 'Tā zài shākēng qián quánlì zhùpǎo bìng zhǔnquè tàbǎn, chénggōng zài tiàoyuǎn juésài zhōng duó dé le jīnpái.',
      example_vi = 'Anh ấy dốc toàn lực chạy đà trước hố cát và giậm ván chính xác, đã giành được huy chương vàng đầy thuyết phục trong trận chung kết nhảy xa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '跳远',
      'tiàoyuǎn',
      'nhảy xa (môn điền kinh)',
      'Động từ / Danh từ',
      'HSK 5',
      '他在沙坑前全力助跑并准确踏板，成功在跳远决赛中夺得了金牌。',
      'Tā zài shākēng qián quánlì zhùpǎo bìng zhǔnquè tàbǎn, chénggōng zài tiàoyuǎn juésài zhōng duó dé le jīnpái.',
      'Anh ấy dốc toàn lực chạy đà trước hố cát và giậm ván chính xác, đã giành được huy chương vàng đầy thuyết phục trong trận chung kết nhảy xa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在沙坑前全力助跑并准确踏板，成功在跳远决赛中夺得了金牌。', 'Tā zài shākēng qián quánlì zhùpǎo bìng zhǔnquè tàbǎn, chénggōng zài tiàoyuǎn juésài zhōng duó dé le jīnpái.', 'Anh ấy dốc toàn lực chạy đà trước hố cát và giậm ván chính xác, đã giành được huy chương vàng đầy thuyết phục trong trận chung kết nhảy xa.', 'basic', 1),
      (v_id, '竞技田径科研训练基地采用地面测力台系统与风阻模拟传感器，针对跳远选手的起跳水平初速度与腾空俯仰角实施数字化精准监控。', 'Jìngjì tiánjìng kēyán xùnliàn jīdì cǎiyòng dìmiàn cèlìtái xìtǒng yǔ fēngzǔ mónǐ chuángǎnqì, zhēnduì tiàoyuǎn xuǎnshǒu de qǐtiào shuǐpíng chūsùdù yǔ téngkōng fǔyǎngjiǎo shíshī shùzìhuà jīngzhǔn jiānkòng.', 'Căn cứ huấn luyện nghiên cứu khoa học điền kinh thi đấu áp dụng hệ thống bàn đo lực mặt sàn và cảm biến mô phỏng sức cản của gió, thực hiện giám sát số hóa chuẩn xác đối với vận tốc ngang ban đầu khi giậm nhảy và góc nâng chúc trên không của vận động viên nhảy xa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3136] [贴] (tiē) - dán, đính vào, dán áp sát [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '贴' AND pinyin = 'tiē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '贴' AND pinyin = 'tiē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '贴'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '贴'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tiē',
      meaning_vi = 'dán, đính vào, dán áp sát',
      example_hanzi = '农历大年三十，全家人欢欢喜喜地在正门大门上贴上了喜庆的红春联和福字。',
      example_pinyin = 'Nónglì dà nián sānshí, quán jiā rén huānhuān-xǐxǐ de zài zhèngmén dàmén shang tiē shàng le xǐqìng de hóng chūnlián hé fúzì.',
      example_vi = 'Ngày ba mươi Tết âm lịch, cả gia đình vui vẻ dán câu đối đỏ mừng xuân và chữ Phúc đỏ thắm lên cửa chính ra vào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '贴',
      'tiē',
      'dán, đính vào, dán áp sát',
      'Động từ',
      'HSK 5',
      '农历大年三十，全家人欢欢喜喜地在正门大门上贴上了喜庆的红春联和福字。',
      'Nónglì dà nián sānshí, quán jiā rén huānhuān-xǐxǐ de zài zhèngmén dàmén shang tiē shàng le xǐqìng de hóng chūnlián hé fúzì.',
      'Ngày ba mươi Tết âm lịch, cả gia đình vui vẻ dán câu đối đỏ mừng xuân và chữ Phúc đỏ thắm lên cửa chính ra vào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '农历大年三十，全家人欢欢喜喜地在正门大门上贴上了喜庆的红春联和福字。', 'Nónglì dà nián sānshí, quán jiā rén huānhuān-xǐxǐ de zài zhèngmén dàmén shang tiē shàng le xǐqìng de hóng chūnlián hé fúzì.', 'Ngày ba mươi Tết âm lịch, cả gia đình vui vẻ dán câu đối đỏ mừng xuân và chữ Phúc đỏ thắm lên cửa chính ra vào.', 'basic', 1),
      (v_id, '柔性智能电子皮肤通过超薄仿生黏附界面紧密贴附于人体表皮，能够连续实时监测心电与皮温等关键生理体征参数。', 'Róuxìng zhìnéng diànzǐ pífū tōngguò chāobáo fǎngshēng niánfù jièmiàn jǐnmì tiēfù yú réntǐ biǎopí, nénggòu liánxù shíshí jiānkòng xīndiàn yǔ píwēn děng guānjiàn shēnglǐ tǐzhēng cānshù.', 'Làn da điện tử thông minh dẻo thông qua bề mặt bám dính sinh học siêu mỏng dán áp sát chặt chẽ vào biểu bì cơ thể người, có thể liên tục giám sát thời gian thực các thông số dấu hiệu sinh tồn then chốt như điện tim và nhiệt độ da.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3137] [铁路] (tiělù) - đường sắt, mạng lưới đường sắt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '铁路' AND pinyin = 'tiělù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '铁路' AND pinyin = 'tiělù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '铁路'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '铁路'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tiělù',
      meaning_vi = 'đường sắt, mạng lưới đường sắt',
      example_hanzi = '横穿大西北崇山峻岭的高速铁路全线通车，让昔日漫长的旅程变得极其快捷方便。',
      example_pinyin = 'Héngchuān dà-xīběi chóngshān-jùnlǐng de gāosù tiělù quánxiàn tōngchē, ràng xīrì màncháng de lǚchéng biàn de jíqí kuàijié fāngbiàn.',
      example_vi = 'Tuyến đường sắt cao tốc xuyên qua núi non trùng điệp miền Tây Bắc đã thông xe toàn tuyến, khiến hành trình dài dằng dặc ngày xưa trở nên cực kỳ nhanh chóng và tiện lợi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '铁路',
      'tiělù',
      'đường sắt, mạng lưới đường sắt',
      'Danh từ',
      'HSK 5',
      '横穿大西北崇山峻岭的高速铁路全线通车，让昔日漫长的旅程变得极其快捷方便。',
      'Héngchuān dà-xīběi chóngshān-jùnlǐng de gāosù tiělù quánxiàn tōngchē, ràng xīrì màncháng de lǚchéng biàn de jíqí kuàijié fāngbiàn.',
      'Tuyến đường sắt cao tốc xuyên qua núi non trùng điệp miền Tây Bắc đã thông xe toàn tuyến, khiến hành trình dài dằng dặc ngày xưa trở nên cực kỳ nhanh chóng và tiện lợi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '横穿大西北崇山峻岭的高速铁路全线通车，让昔日漫长的旅程变得极其快捷方便。', 'Héngchuān dà-xīběi chóngshān-jùnlǐng de gāosù tiělù quánxiàn tōngchē, ràng xīrì màncháng de lǚchéng biàn de jíqí kuàijié fāngbiàn.', 'Tuyến đường sắt cao tốc xuyên qua núi non trùng điệp miền Tây Bắc đã thông xe toàn tuyến, khiến hành trình dài dằng dặc ngày xưa trở nên cực kỳ nhanh chóng và tiện lợi.', 'basic', 1),
      (v_id, '以“八纵八横”高速铁路网为骨干骨架的现代化综合立体交通体系，有力促进了跨区域经济要素高效循环与国土空间协调开发。', 'Yǐ “bā zòng bā héng” gāosù tiělùwǎng wéi gǔgàn gǔjià de xiàndàihuà zōnghé lìtǐ jiāotōng tǐxì, yǒulì cùjìn le kuà-qūyù jīngjì yàosù gāoxiào xúnhuán yǔ guótǔ kōngjiān xiétóng kāifā.', 'Hệ thống giao thông lập thể tổng hợp hiện đại lấy mạng lưới đường sắt cao tốc "tám dọc tám ngang" làm khung xương sống đã thúc đẩy mạnh mẽ sự tuần hoàn hiệu quả của các yếu tố kinh tế liên khu vực và khai thác hiệp đồng không gian lãnh thổ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3138] [停留] (tíngliú) - dừng lại, lưu lại, đỗ lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '停留' AND pinyin = 'tíngliú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '停留' AND pinyin = 'tíngliú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '停留'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '停留'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tíngliú',
      meaning_vi = 'dừng lại, lưu lại, đỗ lại',
      example_hanzi = '这趟长途城际特快列车在途经的中途大站仅停留短短三分钟。',
      example_pinyin = 'Zhè tàng chángtú chéngjì tèkuài lièchē zài tújīng de zhōngtú dàzhàn jǐn tíngliú duǎnduǎn sān fēnzhōng.',
      example_vi = 'Chuyến tàu nhanh liên thành phố đường dài này tại ga lớn đi qua giữa đường chỉ dừng lại vỏn vẹn đúng 3 phút.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '停留',
      'tíngliú',
      'dừng lại, lưu lại, đỗ lại',
      'Động từ',
      'HSK 5',
      '这趟长途城际特快列车在途经的中途大站仅停留短短三分钟。',
      'Zhè tàng chángtú chéngjì tèkuài lièchē zài tújīng de zhōngtú dàzhàn jǐn tíngliú duǎnduǎn sān fēnzhōng.',
      'Chuyến tàu nhanh liên thành phố đường dài này tại ga lớn đi qua giữa đường chỉ dừng lại vỏn vẹn đúng 3 phút.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这趟长途城际特快列车在途经的中途大站仅停留短短三分钟。', 'Zhè tàng chángtú chéngjì tèkuài lièchē zài tújīng de zhōngtú dàzhàn jǐn tíngliú duǎnduǎn sān fēnzhōng.', 'Chuyến tàu nhanh liên thành phố đường dài này tại ga lớn đi qua giữa đường chỉ dừng lại vỏn vẹn đúng 3 phút.', 'basic', 1),
      (v_id, '科学理论探索绝不能停留在已知结论的教条式重复之上，而必须勇于直面未知领域并不断开拓认知新疆域。', 'Kēxué lǐlùn tànsuǒ jué bù néng tíngliú zài yǐzhī jiélùn de jiàotiáoshì chóngfù zhī shàng, ér bìxū yǒngyú zhímiàn wèizhī lǐngyù bìng búduàn kāituò rènzhī xīn jiāngyù.', 'Khám phá lý luận khoa học tuyệt đối không thể dừng lại ở việc lặp lại máy móc giáo điều các kết luận đã biết, mà bắt buộc phải dũng cảm đối diện với các lĩnh vực chưa biết và không ngừng khai mở những ranh giới nhận thức mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3139] [通常] (tōngcháng) - thông thường, thường lệ, bình thường [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '通常' AND pinyin = 'tōngcháng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '通常' AND pinyin = 'tōngcháng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '通常'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '通常'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Tính từ',
      pinyin = 'tōngcháng',
      meaning_vi = 'thông thường, thường lệ, bình thường',
      example_hanzi = '周末的早晨，他通常会起个大早去附近的森林公园跑步晨练。',
      example_pinyin = 'Zhōumò de zǎochen, tā tōngcháng huì qǐ ge dà zǎo qù fùjìn de sēnlín gōngyuán pǎobù chénliàn.',
      example_vi = 'Vào buổi sáng cuối tuần, anh ấy thông thường sẽ dậy từ rất sớm để tới công viên rừng gần nhà chạy bộ tập thể dục buổi sáng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '通常',
      'tōngcháng',
      'thông thường, thường lệ, bình thường',
      'Phó từ / Tính từ',
      'HSK 5',
      '周末的早晨，他通常会起个大早去附近的森林公园跑步晨练。',
      'Zhōumò de zǎochen, tā tōngcháng huì qǐ ge dà zǎo qù fùjìn de sēnlín gōngyuán pǎobù chénliàn.',
      'Vào buổi sáng cuối tuần, anh ấy thông thường sẽ dậy từ rất sớm để tới công viên rừng gần nhà chạy bộ tập thể dục buổi sáng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末的早晨，他通常会起个大早去附近的森林公园跑步晨练。', 'Zhōumò de zǎochen, tā tōngcháng huì qǐ ge dà zǎo qù fùjìn de sēnlín gōngyuán pǎobù chénliàn.', 'Vào buổi sáng cuối tuần, anh ấy thông thường sẽ dậy từ rất sớm để tới công viên rừng gần nhà chạy bộ tập thể dục buổi sáng.', 'basic', 1),
      (v_id, '按照国际惯例与多边经贸协定规则，主权债务重组谈判通常由主要国际官方债权人俱乐部与商业银行财团协同推进。', 'Ànzhào guójì guànlì yǔ duōbiān jīngmào xiédìng guīzé, zhǔquán zhàiwù chóngzǔ tánpàn tōngcháng yóu zhǔyào guójì guānfāng zhàiquánrén jùlèbù yǔ shāngyè yínháng cáituán xiétóng tuījìn.', 'Theo thông lệ quốc tế và quy tắc các hiệp định kinh tế thương mại đa phương, đàm phán tái cơ cấu nợ công thông thường do câu lạc bộ các chủ nợ chính thức quốc tế chủ chốt hiệp đồng thúc đẩy cùng các tập đoàn ngân hàng thương mại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3140] [通行] (tōngxíng) - thông hành, lưu thông, đi lại qua [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '通行' AND pinyin = 'tōngxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '通行' AND pinyin = 'tōngxíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '通行'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '通行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tōngxíng',
      meaning_vi = 'thông hành, lưu thông, đi lại qua',
      example_hanzi = '新建的跨江特大悬索桥经过严格安全验收后，今天上午正式对社会车辆通车通行。',
      example_pinyin = 'Xīn jiàn de kuàjiāng tèdà xuánsuǒqiáo jīngguò yángé ānquán yànshōu hòu, jīntiān shàngwǔ zhèngshì duì shèhuì chēliàng tōngchē tōngxíng.',
      example_vi = 'Cây cầu treo dây võng vượt sông cỡ lớn mới xây sau khi qua nghiệm thu an toàn nghiêm ngặt đã chính thức thông xe cho các phương tiện xã hội lưu thông vào sáng nay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '通行',
      'tōngxíng',
      'thông hành, lưu thông, đi lại qua',
      'Động từ',
      'HSK 5',
      '新建的跨江特大悬索桥经过严格安全验收后，今天上午正式对社会车辆通车通行。',
      'Xīn jiàn de kuàjiāng tèdà xuánsuǒqiáo jīngguò yángé ānquán yànshōu hòu, jīntiān shàngwǔ zhèngshì duì shèhuì chēliàng tōngchē tōngxíng.',
      'Cây cầu treo dây võng vượt sông cỡ lớn mới xây sau khi qua nghiệm thu an toàn nghiêm ngặt đã chính thức thông xe cho các phương tiện xã hội lưu thông vào sáng nay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新建的跨江特大悬索桥经过严格安全验收后，今天上午正式对社会车辆通车通行。', 'Xīn jiàn de kuàjiāng tèdà xuánsuǒqiáo jīngguò yángé ānquán yànshōu hòu, jīntiān shàngwǔ zhèngshì duì shèhuì chēliàng tōngchē tōngxíng.', 'Cây cầu treo dây võng vượt sông cỡ lớn mới xây sau khi qua nghiệm thu an toàn nghiêm ngặt đã chính thức thông xe cho các phương tiện xã hội lưu thông vào sáng nay.', 'basic', 1),
      (v_id, '推进大湾区规则机制软联通旨在优化跨境人员要素高效便捷流动，推行一地两检与跨境车辆资质互认通行。', 'Tuījìn dàwānqū guīzé jīzhì ruǎn liántōng zhǐ zài yōuhuà kuàjìng rényuán yàosù gāoxiào biànjié liúdòng, tuīxíng yīdì-liǎngjiǎn yǔ kuàjìng chēliàng zīzhì hùrèn tōngxíng.', 'Thúc đẩy liên thông mềm về cơ chế quy tắc khu vực vịnh lớn nhằm tối ưu hóa sự lưu chuyển tiện lợi hiệu quả cao của các yếu tố nhân lực xuyên biên giới, nhân rộng kiểm tra một điểm hai thủ tục và công nhận lẫn nhau tư cách xe cộ lưu thông qua lại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3141] [同] (tóng) - cùng, giống nhau; với, cùng với [Tính từ / Giới từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '同' AND pinyin = 'tóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '同' AND pinyin = 'tóng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '同'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '同'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Giới từ / Liên từ',
      pinyin = 'tóng',
      meaning_vi = 'cùng, giống nhau; với, cùng với',
      example_hanzi = '他们俩在同一所重点大学读书，并且住在同一间学生宿舍。',
      example_pinyin = 'Tāmen liǎ zài tóng yì suǒ zhòngdiǎn dàxué dúshū, bìngqiě zhù zài tóng yì jiān xuéshēng sùshè.',
      example_vi = 'Hai bạn ấy cùng học tại một trường đại học trọng điểm, hơn nữa lại ở chung trong một phòng ký túc xá sinh viên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '同',
      'tóng',
      'cùng, giống nhau; với, cùng với',
      'Tính từ / Giới từ / Liên từ',
      'HSK 5',
      '他们俩在同一所重点大学读书，并且住在同一间学生宿舍。',
      'Tāmen liǎ zài tóng yì suǒ zhòngdiǎn dàxué dúshū, bìngqiě zhù zài tóng yì jiān xuéshēng sùshè.',
      'Hai bạn ấy cùng học tại một trường đại học trọng điểm, hơn nữa lại ở chung trong một phòng ký túc xá sinh viên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他们俩在同一所重点大学读书，并且住在同一间学生宿舍。', 'Tāmen liǎ zài tóng yì suǒ zhòngdiǎn dàxué dúshū, bìngqiě zhù zài tóng yì jiān xuéshēng sùshè.', 'Hai bạn ấy cùng học tại một trường đại học trọng điểm, hơn nữa lại ở chung trong một phòng ký túc xá sinh viên.', 'basic', 1),
      (v_id, '中国愿同国际社会一道，坚定践行真正的多边主义，共同维护以联合国宪章宗旨和原则为基础的国际法治秩序。', 'Zhōngguó yuàn tóng guójì shèhuì yídào, jiāndìng jiànxíng zhēnzhèng de duōbiānzhǔyì, gòngtóng wéihù yǐ Liánhéguó xiànzhāng zōngzhǐ hé yuánzé wéi jīchǔ de guójì fǎzhì zhìxù.', 'Trung Quốc sẵn sàng cùng với cộng đồng quốc tế kiên định thực thi chủ nghĩa đa phương chân chính, cùng nhau bảo vệ trật tự pháp trị quốc tế dựa trên tôn chỉ và nguyên tắc của Hiến chương Liên Hợp Quốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3142] [同情] (tóngqíng) - đồng cảm, cảm thông, thương cảm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '同情' AND pinyin = 'tóngqíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '同情' AND pinyin = 'tóngqíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '同情'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '同情'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'tóngqíng',
      meaning_vi = 'đồng cảm, cảm thông, thương cảm',
      example_hanzi = '看到受灾同胞的房屋受损严重，大家纷纷慷慨解囊献出爱心同情。',
      example_pinyin = 'Kàndào shòuzāi tóngbāo de fángwū shòusǔn yánzhòng, dàjiā fēnfēn kāngkǎi-jiěnáng xiàn chū àixīn tóngqíng.',
      example_vi = 'Nhìn thấy nhà cửa của đồng bào vùng thiên tai bị hư hỏng nghiêm trọng, mọi người tới tấp mở rộng hầu bao quyên góp sẻ chia tình thương cảm ái hữu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '同情',
      'tóngqíng',
      'đồng cảm, cảm thông, thương cảm',
      'Động từ / Danh từ',
      'HSK 5',
      '看到受灾同胞的房屋受损严重，大家纷纷慷慨解囊献出爱心同情。',
      'Kàndào shòuzāi tóngbāo de fángwū shòusǔn yánzhòng, dàjiā fēnfēn kāngkǎi-jiěnáng xiàn chū àixīn tóngqíng.',
      'Nhìn thấy nhà cửa của đồng bào vùng thiên tai bị hư hỏng nghiêm trọng, mọi người tới tấp mở rộng hầu bao quyên góp sẻ chia tình thương cảm ái hữu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '看到受灾同胞的房屋受损严重，大家纷纷慷慨解囊献出爱心同情。', 'Kàndào shòuzāi tóngbāo de fángwū shòusǔn yánzhòng, dàjiā fēnfēn kāngkǎi-jiěnáng xiàn chū àixīn tóngqíng.', 'Nhìn thấy nhà cửa của đồng bào vùng thiên tai bị hư hỏng nghiêm trọng, mọi người tới tấp mở rộng hầu bao quyên góp sẻ chia tình thương cảm ái hữu.', 'basic', 1),
      (v_id, '现代人道主义关怀不应仅停留在朴素的情感同情层面，而应转化为健全普惠的救助救济制度保障体系。', 'Xiàndài réndàozhǔyì guānhuái bù yīng jǐn tíngliú zài pǔsù de qínggǎn tóngqíng céngmiàn, ér yīng zhuǎnhuà wèi jiànquán pǔhuì de jiùzhù jiùjì zhìdù bǎozhàng tǐxì.', 'Sự quan tâm nhân đạo hiện đại không nên chỉ dừng lại ở tầng mức cảm thông tình cảm mộc mạc, mà cần chuyển hóa thành hệ thống thể chế bảo trợ cứu trợ cứu tế bao trùm hoàn thiện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3143] [同一] (tóngyī) - cùng một, giống hệt, duy nhất chung [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '同一' AND pinyin = 'tóngyī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '同一' AND pinyin = 'tóngyī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '同一'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '同一'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'tóngyī',
      meaning_vi = 'cùng một, giống hệt, duy nhất chung',
      example_hanzi = '几位志同道合的创业伙伴为了同一个美好梦想，夜以继日地并肩奋斗。',
      example_pinyin = 'Jǐ wèi zhìtóng-dàohé de chuàngyè huǒbàn wèile tóng yí ge měihǎo mèngxiǎng, yèyǐjìrì de bìngjiān fèndòu.',
      example_vi = 'Mấy người bạn khởi nghiệp chí đồng đạo hợp vì cùng một giấc mơ tươi đẹp đã kề vai sát cánh phấn đấu miệt mài ngày đêm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '同一',
      'tóngyī',
      'cùng một, giống hệt, duy nhất chung',
      'Tính từ',
      'HSK 5',
      '几位志同道合的创业伙伴为了同一个美好梦想，夜以继日地并肩奋斗。',
      'Jǐ wèi zhìtóng-dàohé de chuàngyè huǒbàn wèile tóng yí ge měihǎo mèngxiǎng, yèyǐjìrì de bìngjiān fèndòu.',
      'Mấy người bạn khởi nghiệp chí đồng đạo hợp vì cùng một giấc mơ tươi đẹp đã kề vai sát cánh phấn đấu miệt mài ngày đêm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '几位志同道合的创业伙伴为了同一个美好梦想，夜以继日地并肩奋斗。', 'Jǐ wèi zhìtóng-dàohé de chuàngyè huǒbàn wèile tóng yí ge měihǎo mèngxiǎng, yèyǐjìrì de bìngjiān fèndòu.', 'Mấy người bạn khởi nghiệp chí đồng đạo hợp vì cùng một giấc mơ tươi đẹp đã kề vai sát cánh phấn đấu miệt mài ngày đêm.', 'basic', 1),
      (v_id, '在全国统一大市场建设中，必须坚决破除地方保护和市场分割，实现同一类市场准入标准和公平竞争规则。', 'Zài quánguó tǒngyī dà shìchǎng jiànshè zhōng, bìxū jiānjué pòchú dìfāng bǎohù hé shìchǎng fēngē, shíxiàn tóng yí lèi shìchǎng zhǔnrù biāozhǔn hé gōngpíng jìngzhēng guīzé.', 'Trong xây dựng đại thị trường thống nhất toàn quốc, bắt buộc phải kiên quyết phá bỏ bảo hộ địa phương và chia cắt thị trường, thực hiện cùng một loại tiêu chuẩn tiếp cận thị trường và quy tắc cạnh tranh công bằng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3144] [统计] (tǒngjì) - thống kê; số liệu thống kê [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '统计' AND pinyin = 'tǒngjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '统计' AND pinyin = 'tǒngjì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '统计'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '统计'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'tǒngjì',
      meaning_vi = 'thống kê; số liệu thống kê',
      example_hanzi = '班长根据全班同学的投票结果，认真统计了本次春游目的地的意向票数。',
      example_pinyin = 'Bānzhǎng gēnjù quán bān tóngxué de tóupiào jiéguǒ, rènzhēn tǒngjì le běn cì chūnyóu mùdìdì de yìxiàng piàoshù.',
      example_vi = 'Lớp trưởng căn cứ vào kết quả bỏ phiếu của cả lớp đã nghiêm túc thống kê số phiếu nguyện vọng điểm đến cho chuyến dã ngoại mùa xuân lần này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '统计',
      'tǒngjì',
      'thống kê; số liệu thống kê',
      'Động từ / Danh từ',
      'HSK 5',
      '班长根据全班同学的投票结果，认真统计了本次春游目的地的意向票数。',
      'Bānzhǎng gēnjù quán bān tóngxué de tóupiào jiéguǒ, rènzhēn tǒngjì le běn cì chūnyóu mùdìdì de yìxiàng piàoshù.',
      'Lớp trưởng căn cứ vào kết quả bỏ phiếu của cả lớp đã nghiêm túc thống kê số phiếu nguyện vọng điểm đến cho chuyến dã ngoại mùa xuân lần này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '班长根据全班同学的投票结果，认真统计了本次春游目的地的意向票数。', 'Bānzhǎng gēnjù quán bān tóngxué de tóupiào jiéguǒ, rènzhēn tǒngjì le běn cì chūnyóu mùdìdì de yìxiàng piàoshù.', 'Lớp trưởng căn cứ vào kết quả bỏ phiếu của cả lớp đã nghiêm túc thống kê số phiếu nguyện vọng điểm đến cho chuyến dã ngoại mùa xuân lần này.', 'basic', 1),
      (v_id, '国家统计局依法完善现代统计调查制度体系，强化大数据、云计算与卫星遥感技术在宏观经济核算中的集成应用。', 'Guójiā Tǒngjìjú yīfǎ wánshàn xiàndài tǒngjì diàochá zhìdù tǐxì, qiánghuà dà-shùjù, yúnjìsuàn yǔ wèixīng yáogǎn jìshù zài hóngguān jīngjì hésuàn zhōng de jíchéng yìngyòng.', 'Tổng cục Thống kê quốc gia theo luật định hoàn thiện hệ thống chế độ điều tra thống kê hiện đại, củng cố ứng dụng tích hợp công nghệ dữ liệu lớn, điện toán đám mây và viễn thám vệ tinh trong hạch toán kinh tế vĩ mô.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3145] [统一] (tǒngyī) - thống nhất; đồng bộ, nhất thể hóa [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '统一' AND pinyin = 'tǒngyī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '统一' AND pinyin = 'tǒngyī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '统一'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '统一'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'tǒngyī',
      meaning_vi = 'thống nhất; đồng bộ, nhất thể hóa',
      example_hanzi = '参加集体升旗仪式时，全体师生必须统一穿着整齐的校服和工作装。',
      example_pinyin = 'Cānjiā jítǐ shēngqí yíshì shí, quántǐ shīshēng bìxū tǒngyī chuānzhuó zhěngqí de xiàofú hé gōngzuòzhuāng.',
      example_vi = 'Khi tham gia lễ chào cờ tập thể, toàn thể giáo viên và học sinh bắt buộc phải mặc đồng phục học sinh và trang phục công sở gọn gàng đồng bộ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '统一',
      'tǒngyī',
      'thống nhất; đồng bộ, nhất thể hóa',
      'Động từ / Tính từ',
      'HSK 5',
      '参加集体升旗仪式时，全体师生必须统一穿着整齐的校服和工作装。',
      'Cānjiā jítǐ shēngqí yíshì shí, quántǐ shīshēng bìxū tǒngyī chuānzhuó zhěngqí de xiàofú hé gōngzuòzhuāng.',
      'Khi tham gia lễ chào cờ tập thể, toàn thể giáo viên và học sinh bắt buộc phải mặc đồng phục học sinh và trang phục công sở gọn gàng đồng bộ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '参加集体升旗仪式时，全体师生必须统一穿着整齐的校服和工作装。', 'Cānjiā jítǐ shēngqí yíshì shí, quántǐ shīshēng bìxū tǒngyī chuānzhuó zhěngqí de xiàofú hé gōngzuòzhuāng.', 'Khi tham gia lễ chào cờ tập thể, toàn thể giáo viên và học sinh bắt buộc phải mặc đồng phục học sinh và trang phục công sở gọn gàng đồng bộ.', 'basic', 1),
      (v_id, '构建全国统一大市场是畅通国内大循环、激发各类经营主体内生动力与创新活力的先导性基础工程。', 'Gòujiàn quánguó tǒngyī dà shìchǎng shì chàngtōng guónèi dà xúnhuán, jīfā gè lèi jīngyíng zhǔtǐ nèishēng dònglì yǔ chuàngxīn huólì de xiāndǎoxìng jīchǔ gōngchéng.', 'Xây dựng thị trường lớn thống nhất toàn quốc là công trình nền tảng mang tính mở đường nhằm khơi thông tuần hoàn lớn trong nước, kích hoạt động lực nội sinh và sức sống đổi mới của các chủ thể kinh doanh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3146] [痛苦] (tòngkǔ) - thống khổ, đau đớn, khổ sở [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '痛苦' AND pinyin = 'tòngkǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '痛苦' AND pinyin = 'tòngkǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '痛苦'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '痛苦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'tòngkǔ',
      meaning_vi = 'thống khổ, đau đớn, khổ sở',
      example_hanzi = '面对亲人离去的巨大悲痛，他在朋友们的悉心陪伴与开导下慢慢走出了痛苦。',
      example_pinyin = 'Miànduì qīnrén líqù de jùdà bēitòng, tā zài péngyoumen de xīxīn péibàn yǔ kāidǎo xià mànmàn zǒu chū le tòngkǔ.',
      example_vi = 'Đối mặt với nỗi đau đớn mất người thân vô cùng to lớn, anh ấy dưới sự đồng hành tận tình và khuyên nhủ của bạn bè đã từ từ bước ra khỏi nỗi thống khổ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '痛苦',
      'tòngkǔ',
      'thống khổ, đau đớn, khổ sở',
      'Tính từ / Danh từ',
      'HSK 5',
      '面对亲人离去的巨大悲痛，他在朋友们的悉心陪伴与开导下慢慢走出了痛苦。',
      'Miànduì qīnrén líqù de jùdà bēitòng, tā zài péngyoumen de xīxīn péibàn yǔ kāidǎo xià mànmàn zǒu chū le tòngkǔ.',
      'Đối mặt với nỗi đau đớn mất người thân vô cùng to lớn, anh ấy dưới sự đồng hành tận tình và khuyên nhủ của bạn bè đã từ từ bước ra khỏi nỗi thống khổ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对亲人离去的巨大悲痛，他在朋友们的悉心陪伴与开导下慢慢走出了痛苦。', 'Miànduì qīnrén líqù de jùdà bēitòng, tā zài péngyoumen de xīxīn péibàn yǔ kāidǎo xià mànmàn zǒu chū le tòngkǔ.', 'Đối mặt với nỗi đau đớn mất người thân vô cùng to lớn, anh ấy dưới sự đồng hành tận tình và khuyên nhủ của bạn bè đã từ từ bước ra khỏi nỗi thống khổ.', 'basic', 1),
      (v_id, '传统高耗能产业在绿色低碳转型中经历的产能淘汰与转型阵痛，是迈向高质量发展阶段必须承受并积极化解的结构性痛苦。', 'Chuántǒng gāo-hàonéng chǎnyè zài lǜsè dītàn zhuǎnxíng zhōng jīnglì de chǎnnéng táotài yǔ zhuǎnxíng zhèntòng, shì mài xiàng gāo-zhìliàng fāzhǎn jiēduàn bìxū chéngshòu bìng jījí huàjiě de jiégòuxìng tòngkǔ.', 'Sự đào thải năng lực sản xuất và cơn đau quặn chuyển đổi mà ngành tiêu hao năng lượng cao truyền thống phải nếm trải trong quá trình chuyển đổi xanh ít carbon là nỗi đau cơ cấu bắt buộc phải gánh chịu và tích cực hóa giải để bước tới giai đoạn phát triển chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3147] [投] (tóu) - ném, bỏ phiếu, đầu tư, hướng tới [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '投' AND pinyin = 'tóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '投' AND pinyin = 'tóu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '投'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '投'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tóu',
      meaning_vi = 'ném, bỏ phiếu, đầu tư, hướng tới',
      example_hanzi = '他站在罚球线外深呼吸后起跳投篮，篮球在空中划出完美弧线空心入网。',
      example_pinyin = 'Tā zhàn zài fáqiúxiàn wài shēnhūxī hòu qǐtiào tóulán, lánqiú zài kōngzhōng huà chū wánměi húxiàn kōngxīn rùwǎng.',
      example_vi = 'Anh ấy đứng ngoài vạch ném phạt hít thở sâu rồi bật nhảy ném bóng rổ, quả bóng vẽ nên đường cong tuyệt đẹp trên không rơi gọn lỏn vào rổ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '投',
      'tóu',
      'ném, bỏ phiếu, đầu tư, hướng tới',
      'Động từ',
      'HSK 5',
      '他站在罚球线外深呼吸后起跳投篮，篮球在空中划出完美弧线空心入网。',
      'Tā zhàn zài fáqiúxiàn wài shēnhūxī hòu qǐtiào tóulán, lánqiú zài kōngzhōng huà chū wánměi húxiàn kōngxīn rùwǎng.',
      'Anh ấy đứng ngoài vạch ném phạt hít thở sâu rồi bật nhảy ném bóng rổ, quả bóng vẽ nên đường cong tuyệt đẹp trên không rơi gọn lỏn vào rổ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他站在罚球线外深呼吸后起跳投篮，篮球在空中划出完美弧线空心入网。', 'Tā zhàn zài fáqiúxiàn wài shēnhūxī hòu qǐtiào tóulán, lánqiú zài kōngzhōng huà chū wánměi húxiàn kōngxīn rùwǎng.', 'Anh ấy đứng ngoài vạch ném phạt hít thở sâu rồi bật nhảy ném bóng rổ, quả bóng vẽ nên đường cong tuyệt đẹp trên không rơi gọn lỏn vào rổ.', 'basic', 1),
      (v_id, '耐心资本应当加大对早期基础前沿原创硬科技项目的直投支持力度，甘坐冷板凳培育战略性先导产业。', 'Nàixīn zīběn yīngdāng jiàdà duì zǎoqī jīchǔ qiányán yuánchuàng yìngkējì xiàngmù de zhítóu zhīchí lìdù, gān zuò lěngbǎndèng péiyù zhànlüèxìng xiāndǎo chǎnyè.', 'Nguồn vốn kiên nhẫn cần tăng cường mức độ đầu tư trực tiếp vào các dự án công nghệ cứng nguyên bản mũi nhọn cơ sở giai đoạn đầu, sẵn lòng ngồi ghế lạnh dày công ươm mầm các ngành tiên phong mang tính chiến lược.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3148] [投入] (tóurù) - đầu tư, đưa vào; chăm chú, hết mình; nguồn lực bỏ vào [Động từ / Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '投入' AND pinyin = 'tóurù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '投入' AND pinyin = 'tóurù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '投入'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '投入'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ / Danh từ',
      pinyin = 'tóurù',
      meaning_vi = 'đầu tư, đưa vào; chăm chú, hết mình; nguồn lực bỏ vào',
      example_hanzi = '这支科研团队全身心投入到新型环保储能电池的实验研发攻关之中。',
      example_pinyin = 'Zhè zhī kēyán tuánduì quánshēnxīn tóurù dào xīnxíng huánbǎo chǔnéng diànchí de shíyàn yánfā gōngguān zhī zhōng.',
      example_vi = 'Đội ngũ nghiên cứu khoa học này dốc trọn toàn tâm toàn ý vào công cuộc nghiên cứu thí nghiệm khắc phục khó khăn của pin lưu trữ năng lượng thân thiện môi trường kiểu mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '投入',
      'tóurù',
      'đầu tư, đưa vào; chăm chú, hết mình; nguồn lực bỏ vào',
      'Động từ / Tính từ / Danh từ',
      'HSK 5',
      '这支科研团队全身心投入到新型环保储能电池的实验研发攻关之中。',
      'Zhè zhī kēyán tuánduì quánshēnxīn tóurù dào xīnxíng huánbǎo chǔnéng diànchí de shíyàn yánfā gōngguān zhī zhōng.',
      'Đội ngũ nghiên cứu khoa học này dốc trọn toàn tâm toàn ý vào công cuộc nghiên cứu thí nghiệm khắc phục khó khăn của pin lưu trữ năng lượng thân thiện môi trường kiểu mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这支科研团队全身心投入到新型环保储能电池的实验研发攻关之中。', 'Zhè zhī kēyán tuánduì quánshēnxīn tóurù dào xīnxíng huánbǎo chǔnéng diànchí de shíyàn yánfā gōngguān zhī zhōng.', 'Đội ngũ nghiên cứu khoa học này dốc trọn toàn tâm toàn ý vào công cuộc nghiên cứu thí nghiệm khắc phục khó khăn của pin lưu trữ năng lượng thân thiện môi trường kiểu mới.', 'basic', 1),
      (v_id, '我国持续加大全社会全社会研发经费研发投入强度，基础研究投入比重稳步攀升，为原始创新提供了坚实的物质支撑。', 'Wǒguó chíxù jiàdà quán shèhuì yánfā jīngfèi tóurù qiángdù, jīchǔ yánjiū tóurù bǐzhòng wěnbù pānshēng, wèi yuánshǐ chuàngxīn tígōng le jiānshí de wùzhì zhīchēng.', 'Nước ta liên tục tăng cường cường độ đầu tư kinh phí nghiên cứu phát triển toàn xã hội, tỷ trọng đầu tư nghiên cứu cơ bản tăng vọt vững chắc, cung cấp điểm tựa vật chất kiên cố cho đổi mới nguyên bản.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3149] [头] (tou) - hậu tố chỉ danh từ (đá, gỗ, suy nghĩ, đầu mối) [Hậu tố từ loại]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '头' AND pinyin = 'tou'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '头' AND pinyin = 'tou'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '头'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '头'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Hậu tố từ loại',
      pinyin = 'tou',
      meaning_vi = 'hậu tố chỉ danh từ (đá, gỗ, suy nghĩ, đầu mối)',
      example_hanzi = '清澈见底的溪流边散落着许多圆滚滚的大石头。',
      example_pinyin = 'Qīngchè jiàn dǐ de xīliú biān sànluò zhe xǔduō yuángǔngǔn de dà shítou.',
      example_vi = 'Bên bờ con suối trong vắt thấy tận đáy nằm rải rác rất nhiều tảng đá to tròn vo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '头',
      'tou',
      'hậu tố chỉ danh từ (đá, gỗ, suy nghĩ, đầu mối)',
      'Hậu tố từ loại',
      'HSK 5',
      '清澈见底的溪流边散落着许多圆滚滚的大石头。',
      'Qīngchè jiàn dǐ de xīliú biān sànluò zhe xǔduō yuángǔngǔn de dà shítou.',
      'Bên bờ con suối trong vắt thấy tận đáy nằm rải rác rất nhiều tảng đá to tròn vo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '清澈见底的溪流边散落着许多圆滚滚的大石头。', 'Qīngchè jiàn dǐ de xīliú biān sànluò zhe xǔduō yuángǔngǔn de dà shítou.', 'Bên bờ con suối trong vắt thấy tận đáy nằm rải rác rất nhiều tảng đá to tròn vo.', 'basic', 1),
      (v_id, '面对错综复杂的产业转型瓶颈，企业家必须理清战略发展的关键点头与突破着力点。', 'Miànduì cuòzōng-fùzá de chǎnyè zhuǎnxíng píngjǐng, qǐyèjiā bìxū lǐqīng zhànlüè fāzhǎn de guānjiàn diǎntou yǔ tūpò zhuólìdiǎn.', 'Đối mặt với nút thắt cổ chai phức tạp đan xen của quá trình chuyển đổi ngành nghề, các doanh nhân bắt buộc phải làm rõ các đầu mối then chốt và điểm đột phá trọng tâm của sự phát triển chiến lược.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3150] [突出] (tūchū) - nổi bật, xuất chúng; làm nổi bật [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '突出' AND pinyin = 'tūchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '突出' AND pinyin = 'tūchū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '突出'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '突出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'tūchū',
      meaning_vi = 'nổi bật, xuất chúng; làm nổi bật',
      example_hanzi = '他在本届全国青年技能大赛中表现极其突出，摘得了数控加工项目的特等奖。',
      example_pinyin = 'Tā zài běnjiè quánguó qīngnián jìnéng dàsài zhōng biǎoxiàn jíqí tūchū, zhāidé le shùkòng jiāgōng xiàngmù de tèděngjiǎng.',
      example_vi = 'Anh ấy trong kỳ đại hội thi tay nghề thanh niên toàn quốc lần này thể hiện cực kỳ nổi bật, đã ẵm trọn giải đặc biệt của hạng mục gia công điều khiển số.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '突出',
      'tūchū',
      'nổi bật, xuất chúng; làm nổi bật',
      'Tính từ / Động từ',
      'HSK 5',
      '他在本届全国青年技能大赛中表现极其突出，摘得了数控加工项目的特等奖。',
      'Tā zài běnjiè quánguó qīngnián jìnéng dàsài zhōng biǎoxiàn jíqí tūchū, zhāidé le shùkòng jiāgōng xiàngmù de tèděngjiǎng.',
      'Anh ấy trong kỳ đại hội thi tay nghề thanh niên toàn quốc lần này thể hiện cực kỳ nổi bật, đã ẵm trọn giải đặc biệt của hạng mục gia công điều khiển số.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在本届全国青年技能大赛中表现极其突出，摘得了数控加工项目的特等奖。', 'Tā zài běnjiè quánguó qīngnián jìnéng dàsài zhōng biǎoxiàn jíqí tūchū, zhāidé le shùkòng jiāgōng xiàngmù de tèděngjiǎng.', 'Anh ấy trong kỳ đại hội thi tay nghề thanh niên toàn quốc lần này thể hiện cực kỳ nổi bật, đã ẵm trọn giải đặc biệt của hạng mục gia công điều khiển số.', 'basic', 1),
      (v_id, '国家级高新区规划必须突出战略性新兴产业集聚效应，坚决避免无序低水平同质化重复建设与恶性竞争。', 'Guójiājí gāoxīnqū guīhuà bìxū tūchū zhànlüèxìng xīnxīng chǎnyè jíjù xiàoyì, jiānjué bìmiǎn wúxù dī-shuǐpíng tóngzhìhuà chóngfù jiànshè yǔ èxìng jìngzhēng.', 'Quy hoạch khu công nghệ cao cấp quốc gia bắt buộc phải làm nổi bật hiệu ứng tập tụ của các ngành mới nổi mang tính chiến lược, kiên quyết né tránh xây dựng trùng lặp tràn lan đơn điệu trình độ thấp và cạnh tranh tiêu cực vô trật tự.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3151] [图画] (túhuà) - bức tranh, tranh vẽ, hội họa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '图画' AND pinyin = 'túhuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '图画' AND pinyin = 'túhuà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '图画'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '图画'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'túhuà',
      meaning_vi = 'bức tranh, tranh vẽ, hội họa',
      example_hanzi = '美术课上，孩子们挥动水彩画笔在白纸上描绘出一幅幅充满童趣的美丽图画。',
      example_pinyin = 'Měishùkè shang, háizimen huīdòng shuǐcǎi huàbǐ zài báizhǐ shang miáohuì chū yì fúfú chōngmǎn tóngqù de měilì túhuà.',
      example_vi = 'Trong giờ mỹ thuật, các bạn nhỏ vung cây cọ màu nước trên trang giấy trắng vẽ nên từng bức tranh xinh đẹp ngập tràn nét ngây thơ hồn nhiên của tuổi thơ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '图画',
      'túhuà',
      'bức tranh, tranh vẽ, hội họa',
      'Danh từ',
      'HSK 5',
      '美术课上，孩子们挥动水彩画笔在白纸上描绘出一幅幅充满童趣的美丽图画。',
      'Měishùkè shang, háizimen huīdòng shuǐcǎi huàbǐ zài báizhǐ shang miáohuì chū yì fúfú chōngmǎn tóngqù de měilì túhuà.',
      'Trong giờ mỹ thuật, các bạn nhỏ vung cây cọ màu nước trên trang giấy trắng vẽ nên từng bức tranh xinh đẹp ngập tràn nét ngây thơ hồn nhiên của tuổi thơ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '美术课上，孩子们挥动水彩画笔在白纸上描绘出一幅幅充满童趣的美丽图画。', 'Měishùkè shang, háizimen huīdòng shuǐcǎi huàbǐ zài báizhǐ shang miáohuì chū yì fúfú chōngmǎn tóngqù de měilì túhuà.', 'Trong giờ mỹ thuật, các bạn nhỏ vung cây cọ màu nước trên trang giấy trắng vẽ nên từng bức tranh xinh đẹp ngập tràn nét ngây thơ hồn nhiên của tuổi thơ.', 'basic', 1),
      (v_id, '以《千里江山图》为代表的中国传统青绿山水图画，运用富丽堂皇的石青石绿矿物颜料描摹出祖国锦绣河山的壮阔气象。', 'Yǐ 《Qiānlǐ Jiāngshān Tú》 wéi dàibiǎo de Zhōngguó chuántǒng qīnglǜ shānshuǐ túhuà, yùnyòng fùlì-tánghuáng de shíqīng shílǜ kuàngwù yánliào miáomó chū zǔguó jǐnxiù héshān de zhuàngkuò qìxiàng.', 'Các bức tranh sơn thủy thanh lục truyền thống Trung Hoa với đại diện là "Thanh Lý Giang Sơn Đồ" đã vận dụng bột khoáng chất thạch thanh thạch lục lộng lẫy để khắc họa nên khí tượng hùng vĩ của non sông gấm vóc tổ quốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3152] [图书] (túshū) - sách báo, thư tịch, ấn phẩm đọc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '图书' AND pinyin = 'túshū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '图书' AND pinyin = 'túshū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '图书'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '图书'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'túshū',
      meaning_vi = 'sách báo, thư tịch, ấn phẩm đọc',
      example_hanzi = '学校图书馆近期采购了数千册涵盖文学、历史和自然科学的优质图书。',
      example_pinyin = 'Xuéxiào túshūguǎn jìnqī cǎigòu le shù qiān cè hángài wénxué, lìshǐ hé zìrán kēxué de yōuzhì túshū.',
      example_vi = 'Thư viện nhà trường thời gian gần đây đã thu mua hàng nghìn cuốn sách chất lượng bao quát các lĩnh vực văn học, lịch sử và khoa học tự nhiên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '图书',
      'túshū',
      'sách báo, thư tịch, ấn phẩm đọc',
      'Danh từ',
      'HSK 5',
      '学校图书馆近期采购了数千册涵盖文学、历史和自然科学的优质图书。',
      'Xuéxiào túshūguǎn jìnqī cǎigòu le shù qiān cè hángài wénxué, lìshǐ hé zìrán kēxué de yōuzhì túshū.',
      'Thư viện nhà trường thời gian gần đây đã thu mua hàng nghìn cuốn sách chất lượng bao quát các lĩnh vực văn học, lịch sử và khoa học tự nhiên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校图书馆近期采购了数千册涵盖文学、历史和自然科学的优质图书。', 'Xuéxiào túshūguǎn jìnqī cǎigòu le shù qiān cè hángài wénxué, lìshǐ hé zìrán kēxué de yōuzhì túshū.', 'Thư viện nhà trường thời gian gần đây đã thu mua hàng nghìn cuốn sách chất lượng bao quát các lĩnh vực văn học, lịch sử và khoa học tự nhiên.', 'basic', 1),
      (v_id, '国家古籍保护中心运用纳米脱酸与三维高光谱数字复原技术，抢救性保护并数字化影印濒危珍贵古籍图书文献。', 'Guójiā gǔjí bǎohù zhōngxīn yùnyòng nàmǐ tuōsuān yǔ sānwéi gāo-guāngpǔ shùzì fùyuán jìshù, qiǎngjiùxìng bǎohù bìng shùzìhuà yǐngyìn bīnwēi zhēnguì gǔjí túshū wénxiàn.', 'Trung tâm bảo tồn cổ tịch quốc gia áp dụng công nghệ khử axit nanomet và phục chế số hóa đa phổ 3D, thực hiện bảo tồn cấp cứu và in chụp số hóa các thư tịch tư liệu sách cổ quý hiếm có nguy cơ hư hại biến mất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3153] [土地] (tǔdì) - đất đai, thổ địa, điền địa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '土地' AND pinyin = 'tǔdì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '土地' AND pinyin = 'tǔdì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '土地'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '土地'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tǔdì',
      meaning_vi = 'đất đai, thổ địa, điền địa',
      example_hanzi = '这片广袤肥沃的黑色土地非常适合种植大豆、玉米和优质水稻。',
      example_pinyin = 'Zhè piàn guǎngmào féiwò de hēisè tǔdì fēicháng shìhé zhòngzhí dàdòu, yùmǐ hé yōuzhì shuǐdào.',
      example_vi = 'Vùng đất đen phì nhiêu màu mỡ bao la này vô cùng thích hợp để gieo trồng đậu tương, ngô và lúa nước chất lượng cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '土地',
      'tǔdì',
      'đất đai, thổ địa, điền địa',
      'Danh từ',
      'HSK 5',
      '这片广袤肥沃的黑色土地非常适合种植大豆、玉米和优质水稻。',
      'Zhè piàn guǎngmào féiwò de hēisè tǔdì fēicháng shìhé zhòngzhí dàdòu, yùmǐ hé yōuzhì shuǐdào.',
      'Vùng đất đen phì nhiêu màu mỡ bao la này vô cùng thích hợp để gieo trồng đậu tương, ngô và lúa nước chất lượng cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这片广袤肥沃的黑色土地非常适合种植大豆、玉米和优质水稻。', 'Zhè piàn guǎngmào féiwò de hēisè tǔdì fēicháng shìhé zhòngzhí dàdòu, yùmǐ hé yōuzhì shuǐdào.', 'Vùng đất đen phì nhiêu màu mỡ bao la này vô cùng thích hợp để gieo trồng đậu tương, ngô và lúa nước chất lượng cao.', 'basic', 1),
      (v_id, '严格落实国家耕地保护红线与节约集约用地制度，坚决遏制耕地“非农化”、防止“非粮化”，牢牢守住十八亿亩耕地红线。', 'Yángé luòshí guójiā gēngdì bǎohù hóngxiàn yǔ jiéyuē jíyuē yòngdì zhìdù, jiānjué èzhì gēngdì “fēi-nónghuà”、fángzhǐ “fēi-liánghuà”, láoláo shǒuzhù shíbā yì mǔ gēngdì hóngxiàn.', 'Thực thi nghiêm ngặt ranh giới đỏ bảo vệ đất canh tác quốc gia và chế độ sử dụng đất tiết kiệm tập trung, kiên quyết ngăn chặn đất canh tác bị "phi nông nghiệp hóa" và phòng chống "phi lương thực hóa", giữ vững ranh giới đỏ 1,8 tỷ mẫu đất canh tác.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3154] [土豆] (tǔdòu) - khoai tây [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '土豆' AND pinyin = 'tǔdòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '土豆' AND pinyin = 'tǔdòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '土豆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '土豆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tǔdòu',
      meaning_vi = 'khoai tây',
      example_hanzi = '妈妈在厨房里切了满满一盘细细的土豆丝，准备做清炒酸辣土豆丝。',
      example_pinyin = 'Māma zài chúfáng lǐ qiē le mǎnmǎn yì pán xìxì de tǔdòusī, zhǔnbèi zuò qīngchǎo suānlà tǔdòusī.',
      example_vi = 'Mẹ ở trong bếp thái đầy ắp một đĩa khoai tây sợi mảnh, chuẩn bị làm món khoai tây xào chua cay giòn ngọt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '土豆',
      'tǔdòu',
      'khoai tây',
      'Danh từ',
      'HSK 5',
      '妈妈在厨房里切了满满一盘细细的土豆丝，准备做清炒酸辣土豆丝。',
      'Māma zài chúfáng lǐ qiē le mǎnmǎn yì pán xìxì de tǔdòusī, zhǔnbèi zuò qīngchǎo suānlà tǔdòusī.',
      'Mẹ ở trong bếp thái đầy ắp một đĩa khoai tây sợi mảnh, chuẩn bị làm món khoai tây xào chua cay giòn ngọt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '妈妈在厨房里切了满满一盘细细的土豆丝，准备做清炒酸辣土豆丝。', 'Māma zài chúfáng lǐ qiē le mǎnmǎn yì pán xìxì de tǔdòusī, zhǔnbèi zuò qīngchǎo suānlà tǔdòusī.', 'Mẹ ở trong bếp thái đầy ắp một đĩa khoai tây sợi mảnh, chuẩn bị làm món khoai tây xào chua cay giòn ngọt.', 'basic', 1),
      (v_id, '农业科研团队积极推进马铃薯主粮化国家战略，培育出抗晚疫病、富含花青素的特种功能性彩色土豆新品系。', 'Nóngyè kēyán tuánduì jījí tuījìn mǎlíngshǔ zhǔliánghuà guójiā zhànlüè, péiyù chū kàng wǎnyìbìng, fùhán huāqīngsù de tèzhǒng gōngnéngxìng cǎisè tǔdòu xīn pǐnxì.', 'Nhóm nghiên cứu khoa học nông nghiệp tích cực thúc đẩy chiến lược quốc gia lấy khoai tây làm lương thực chính, nhân giống thành công các dòng khoai tây màu sắc chức năng đặc chủng giàu anthocyanin và kháng bệnh mốc sương muộn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3155] [兔子] (tùzi) - con thỏ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '兔子' AND pinyin = 'tùzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '兔子' AND pinyin = 'tùzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '兔子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '兔子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tùzi',
      meaning_vi = 'con thỏ',
      example_hanzi = '笼子里养着一只通体雪白、长着两只长长耳朵和红眼睛的可爱兔子。',
      example_pinyin = 'Lóngzi lǐ yǎng zhe yì zhī tōngtǐ xuěbái, zhǎng zhe liǎng zhī chángcháng ěrduo hé hóng yǎnjing de kě’ài tùzi.',
      example_vi = 'Trong chuồng nuôi một chú thỏ đáng yêu toàn thân trắng muốt như tuyết, có đôi tai dài dài và đôi mắt đỏ tròn xoe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '兔子',
      'tùzi',
      'con thỏ',
      'Danh từ',
      'HSK 5',
      '笼子里养着一只通体雪白、长着两只长长耳朵和红眼睛的可爱兔子。',
      'Lóngzi lǐ yǎng zhe yì zhī tōngtǐ xuěbái, zhǎng zhe liǎng zhī chángcháng ěrduo hé hóng yǎnjing de kě’ài tùzi.',
      'Trong chuồng nuôi một chú thỏ đáng yêu toàn thân trắng muốt như tuyết, có đôi tai dài dài và đôi mắt đỏ tròn xoe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '笼子里养着一只通体雪白、长着两只长长耳朵和红眼睛的可爱兔子。', 'Lóngzi lǐ yǎng zhe yì zhī tōngtǐ xuěbái, zhǎng zhe liǎng zhī chángcháng ěrduo hé hóng yǎnjing de kě’ài tùzi.', 'Trong chuồng nuôi một chú thỏ đáng yêu toàn thân trắng muốt như tuyết, có đôi tai dài dài và đôi mắt đỏ tròn xoe.', 'basic', 1),
      (v_id, '野生动物生态学科考队在荒漠绿洲过渡带建立红外相机监测阵列，系统追踪高原鼠兔与草兔等小型草食动物的种群动态迁徙规律。', 'Yěshēng dòngwù shēngtài xuékē kǎoduì zài huāngmò lǜzhōu guòdùdài jiànlì hóngwài xiàngjī jiānkòng zhènliè, xìtǒng zhuīzōng gāoyuán shǔtù yǔ cǎotù děng xiǎoxíng cǎoshí dòngwù de zhǒngqún dòngtài qiānxǐ guīlǜ.', 'Đội khảo sát sinh thái động vật hoang dã đã thiết lập mảng camera hồng ngoại tại dải chuyển tiếp ốc đảo hoang mạc, theo dõi có hệ thống quy luật di cư động thái quần thể của các loài ăn cỏ cỡ nhỏ như thỏ pika cao nguyên và thỏ rừng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3156] [团] (tuán) - đoàn, nhóm; cuộn, nắm, khối; vo tròn [Lượng từ / Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '团' AND pinyin = 'tuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '团' AND pinyin = 'tuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '团'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '团'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ / Danh từ / Động từ',
      pinyin = 'tuán',
      meaning_vi = 'đoàn, nhóm; cuộn, nắm, khối; vo tròn',
      example_hanzi = '他在桌前把写废的草稿纸揉成一团，随手扔进了旁边的垃圾桶里。',
      example_pinyin = 'Tā zài zhuō qián bǎ xiě fèi de cǎogǎozhǐ róu chéng yì tuán, suíshǒu rēng jìn le pángbiān de lājītǒng lǐ.',
      example_vi = 'Anh ấy vò tờ giấy nháp viết hỏng thành một nắm tròn trên bàn, tiện tay ném vào sọt rác bên cạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '团',
      'tuán',
      'đoàn, nhóm; cuộn, nắm, khối; vo tròn',
      'Lượng từ / Danh từ / Động từ',
      'HSK 5',
      '他在桌前把写废的草稿纸揉成一团，随手扔进了旁边的垃圾桶里。',
      'Tā zài zhuō qián bǎ xiě fèi de cǎogǎozhǐ róu chéng yì tuán, suíshǒu rēng jìn le pángbiān de lājītǒng lǐ.',
      'Anh ấy vò tờ giấy nháp viết hỏng thành một nắm tròn trên bàn, tiện tay ném vào sọt rác bên cạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在桌前把写废的草稿纸揉成一团，随手扔进了旁边的垃圾桶里。', 'Tā zài zhuō qián bǎ xiě fèi de cǎogǎozhǐ róu chéng yì tuán, suíshǒu rēng jìn le pángbiān de lājītǒng lǐ.', 'Anh ấy vò tờ giấy nháp viết hỏng thành một nắm tròn trên bàn, tiện tay ném vào sọt rác bên cạnh.', 'basic', 1),
      (v_id, '国家级高水平院士专家顾问团深入老工业基地，把脉问诊制造业数字化转型与绿色重构发展路径。', 'Guójiājí gāo-shuǐpíng yuànshì zhuānjiā gùwèntuán shēnrù lǎo gōngyè jīdì, bǎmài-wènzhěn zhìzàoyè shùzìhuà zhuǎnxíng yǔ lǜsè chónggòu fāzhǎn lùjìng.', 'Đoàn cố vấn chuyên gia viện sĩ trình độ cao cấp quốc gia đã đi sâu vào các căn cứ công nghiệp cũ, bắt mạch kê đơn cho con đường phát triển tái cấu trúc xanh và chuyển đổi số hóa của ngành chế tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3157] [团队] (tuánduì) - đội ngũ, tập thể, đoàn thể [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '团队' AND pinyin = 'tuánduì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '团队' AND pinyin = 'tuánduì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '团队'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '团队'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tuánduì',
      meaning_vi = 'đội ngũ, tập thể, đoàn thể',
      example_hanzi = '在这项复杂的课题研发中，大家齐心协力展现出了极其优秀的团队配合精神。',
      example_pinyin = 'Zài zhè xiàng fùzá de kètí yánfā zhōng, dàjiā qíxīn-xiélì zhǎnxiàn chū le jíqí yōuxiù de tuánduì pèihé jīngshén.',
      example_vi = 'Trong nghiên cứu đề tài phức tạp này, mọi người đồng lòng hiệp lực thể hiện tinh thần phối hợp đội ngũ vô cùng xuất sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '团队',
      'tuánduì',
      'đội ngũ, tập thể, đoàn thể',
      'Danh từ',
      'HSK 5',
      '在这项复杂的课题研发中，大家齐心协力展现出了极其优秀的团队配合精神。',
      'Zài zhè xiàng fùzá de kètí yánfā zhōng, dàjiā qíxīn-xiélì zhǎnxiàn chū le jíqí yōuxiù de tuánduì pèihé jīngshén.',
      'Trong nghiên cứu đề tài phức tạp này, mọi người đồng lòng hiệp lực thể hiện tinh thần phối hợp đội ngũ vô cùng xuất sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在这项复杂的课题研发中，大家齐心协力展现出了极其优秀的团队配合精神。', 'Zài zhè xiàng fùzá de kètí yánfā zhōng, dàjiā qíxīn-xiélì zhǎnxiàn chū le jíqí yōuxiù de tuánduì pèihé jīngshén.', 'Trong nghiên cứu đề tài phức tạp này, mọi người đồng lòng hiệp lực thể hiện tinh thần phối hợp đội ngũ vô cùng xuất sắc.', 'basic', 1),
      (v_id, '打破学科壁垒与科研机构院所界限，跨部门组建国家战略科技攻关团队，是攻坚底层卡脖子技术的关键体制创新。', 'Dǎpò xuékē bìlěi yǔ kēyán jīgòu yuànsuǒ jièxiàn, kuà-bùmén zǔjiàn guójiā zhànlüè kējì gōngguān tuánduì, shì gōngjiān dǐcéng qiǎbózi jìshù de guānjiàn tǐzhì chuàngxīn.', 'Phá bỏ rào cản phân ngành và ranh giới các viện nghiên cứu khoa học, thành lập đội ngũ khắc phục khó khăn công nghệ chiến lược quốc gia liên ngành là đổi mới thể chế then chốt để công phá các công nghệ nghẽn cổ chai nền tảng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3158] [推动] (tuīdòng) - thúc đẩy, đẩy mạnh, cổ xúy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '推动' AND pinyin = 'tuīdòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '推动' AND pinyin = 'tuīdòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '推动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '推动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tuīdòng',
      meaning_vi = 'thúc đẩy, đẩy mạnh, cổ xúy',
      example_hanzi = '全校师生共同努力，有力推动了绿色校园节能减排行动的全面落实。',
      example_pinyin = 'Quán xiào shīshēng gòngtóng nǔlì, yǒulì tuīdòng le lǜsè xiàoyuán jiénéng-jiǎnpái xíngdòng de quánmiàn luòshí.',
      example_vi = 'Toàn thể giáo viên và học sinh cùng nhau nỗ lực, đã thúc đẩy mạnh mẽ việc thực hiện toàn diện hành động tiết kiệm năng lượng giảm phát thải trong khuôn viên trường học xanh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '推动',
      'tuīdòng',
      'thúc đẩy, đẩy mạnh, cổ xúy',
      'Động từ',
      'HSK 5',
      '全校师生共同努力，有力推动了绿色校园节能减排行动的全面落实。',
      'Quán xiào shīshēng gòngtóng nǔlì, yǒulì tuīdòng le lǜsè xiàoyuán jiénéng-jiǎnpái xíngdòng de quánmiàn luòshí.',
      'Toàn thể giáo viên và học sinh cùng nhau nỗ lực, đã thúc đẩy mạnh mẽ việc thực hiện toàn diện hành động tiết kiệm năng lượng giảm phát thải trong khuôn viên trường học xanh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '全校师生共同努力，有力推动了绿色校园节能减排行动的全面落实。', 'Quán xiào shīshēng gòngtóng nǔlì, yǒulì tuīdòng le lǜsè xiàoyuán jiénéng-jiǎnpái xíngdòng de quánmiàn luòshí.', 'Toàn thể giáo viên và học sinh cùng nhau nỗ lực, đã thúc đẩy mạnh mẽ việc thực hiện toàn diện hành động tiết kiệm năng lượng giảm phát thải trong khuôn viên trường học xanh.', 'basic', 1),
      (v_id, '以科技创新引领现代化产业体系建设，大力推动战略性新兴产业融合集群发展，培育壮大经济发展新动能。', 'Yǐ kējì chuàngxīn yǐnlǐng xiàndàihuà chǎnyè tǐxì jiànshè, dàlì tuīdòng zhànlüèxìng xīnxīng chǎnyè rónghé jíqún fāzhǎn, péiyù zhuàngdà jīngjì fāzhǎn xīn dòngnéng.', 'Lấy đổi mới khoa học công nghệ dẫn dắt xây dựng hệ thống ngành hiện đại, ra sức thúc đẩy sự phát triển cụm dung hợp các ngành mới nổi mang tính chiến lược, ươm mầm lớn mạnh động năng phát triển kinh tế mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3159] [推广] (tuīguǎng) - nhân rộng, phổ biến, quảng bá rộng rãi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '推广' AND pinyin = 'tuīguǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '推广' AND pinyin = 'tuīguǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '推广'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '推广'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tuīguǎng',
      meaning_vi = 'nhân rộng, phổ biến, quảng bá rộng rãi',
      example_hanzi = '农业技术人员深入田间地头，向广大农户示范推广高效节水滴灌新技术。',
      example_pinyin = 'Nóngyè jìshù rényuán shēnrù tiánjiān-dìtóu, xiàng guǎngdà nónghù shìfàn tuīguǎng gāoxiào jiéshuǐ dīguàn xīn jìshù.',
      example_vi = 'Cán bộ kỹ thuật nông nghiệp đi sâu tới tận bờ ruộng, làm mẫu và nhân rộng kỹ thuật tưới nhỏ giọt tiết kiệm nước hiệu quả cao cho đông đảo bà con nông dân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '推广',
      'tuīguǎng',
      'nhân rộng, phổ biến, quảng bá rộng rãi',
      'Động từ',
      'HSK 5',
      '农业技术人员深入田间地头，向广大农户示范推广高效节水滴灌新技术。',
      'Nóngyè jìshù rényuán shēnrù tiánjiān-dìtóu, xiàng guǎngdà nónghù shìfàn tuīguǎng gāoxiào jiéshuǐ dīguàn xīn jìshù.',
      'Cán bộ kỹ thuật nông nghiệp đi sâu tới tận bờ ruộng, làm mẫu và nhân rộng kỹ thuật tưới nhỏ giọt tiết kiệm nước hiệu quả cao cho đông đảo bà con nông dân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '农业技术人员深入田间地头，向广大农户示范推广高效节水滴灌新技术。', 'Nóngyè jìshù rényuán shēnrù tiánjiān-dìtóu, xiàng guǎngdà nónghù shìfàn tuīguǎng gāoxiào jiéshuǐ dīguàn xīn jìshù.', 'Cán bộ kỹ thuật nông nghiệp đi sâu tới tận bờ ruộng, làm mẫu và nhân rộng kỹ thuật tưới nhỏ giọt tiết kiệm nước hiệu quả cao cho đông đảo bà con nông dân.', 'basic', 1),
      (v_id, '在工业能效提升专项行动中，重点推广大型电机变频调速与工业余热余压梯级利用节能降碳先进成熟适用技术。', 'Zài gōngyè néngxiào tíshēng zhuānxiàng xíngdòng zhōng, zhòngdiǎn tuīguǎng dàxíng diànjī biànpín tiáosù yǔ gōngyè yúrè-yúyā tījī lìyòng jiénéng jiàngtàn xiānjìn chéngshú shìyòng jìshù.', 'Trong hành động chuyên đề nâng cao hiệu suất năng lượng công nghiệp, trọng điểm là nhân rộng các kỹ thuật áp dụng chín muồi tiên tiến về tiết kiệm năng lượng giảm carbon như điều tốc biến tần động cơ lớn và tận dụng nhiệt áp suất dư công nghiệp theo bậc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3160] [推荐] (tuījiàn) - giới thiệu, tiến cử, đề xuất [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '推荐' AND pinyin = 'tuījiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '推荐' AND pinyin = 'tuījiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '推荐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '推荐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tuījiàn',
      meaning_vi = 'giới thiệu, tiến cử, đề xuất',
      example_hanzi = '热心的图书管理员向初学者热情推荐了几本通俗实用的汉语语法入门读物。',
      example_pinyin = 'Rèxīn de túshū guǎnlǐyuán xiàng chūxuézhě rèqíng tuījiàn le jǐ běn tōngsú shíyòng de Hànyǔ yǔfǎ rùmén dúwù.',
      example_vi = 'Người quản lý thư viện nhiệt tình đã nồng nhiệt giới thiệu cho người mới học mấy cuốn sách nhập môn ngữ pháp tiếng Hán giản dị và thực dụng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '推荐',
      'tuījiàn',
      'giới thiệu, tiến cử, đề xuất',
      'Động từ',
      'HSK 5',
      '热心的图书管理员向初学者热情推荐了几本通俗实用的汉语语法入门读物。',
      'Rèxīn de túshū guǎnlǐyuán xiàng chūxuézhě rèqíng tuījiàn le jǐ běn tōngsú shíyòng de Hànyǔ yǔfǎ rùmén dúwù.',
      'Người quản lý thư viện nhiệt tình đã nồng nhiệt giới thiệu cho người mới học mấy cuốn sách nhập môn ngữ pháp tiếng Hán giản dị và thực dụng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '热心的图书管理员向初学者热情推荐了几本通俗实用的汉语语法入门读物。', 'Rèxīn de túshū guǎnlǐyuán xiàng chūxuézhě rèqíng tuījiàn le jǐ běn tōngsú shíyòng de Hànyǔ yǔfǎ rùmén dúwù.', 'Người quản lý thư viện nhiệt tình đã nồng nhiệt giới thiệu cho người mới học mấy cuốn sách nhập môn ngữ pháp tiếng Hán giản dị và thực dụng.', 'basic', 1),
      (v_id, '基于多模态深度神经网络的智能个性化推荐引擎，能实时捕捉用户长短期偏好漂移并实现纳秒级精准信息分发。', 'Jīyú duō-mótài shēndù shénjīng wǎngluò de zhìnéng gèxìnghuà tuījiàn yǐnqíng, néng shíshí bǔzhuō yònghù cháng-duǎnqī piānhào piāoyí bìng shíxiàn nàmiǎojí jīngzhǔn xìnxī fēnfā.', 'Công cụ gợi ý đề xuất cá nhân hóa thông minh dựa trên mạng nơ-ron sâu đa phương thức có thể bắt kịp thời gian thực sự dịch chuyển sở thích dài ngắn hạn của người dùng và thực hiện phân phối thông tin chuẩn xác cấp nano giây.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3161] [推进] (tuījìn) - thúc đẩy tiến lên, xúc tiến, đẩy tới [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '推进' AND pinyin = 'tuījìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '推进' AND pinyin = 'tuījìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '推进'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '推进'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tuījìn',
      meaning_vi = 'thúc đẩy tiến lên, xúc tiến, đẩy tới',
      example_hanzi = '在大家的通力配合下，新校区体育场馆的各项建设工程正在平稳有序向前推进。',
      example_pinyin = 'Zài dàjiā de tōnglì pèihé xià, xīn xiàoqū tǐyù chǎngguǎn de gè xiàng jiànshè gōngchéng zhèngzài píngwěn yǒuxù xiàngqián tuījìn.',
      example_vi = 'Dưới sự phối hợp toàn diện của mọi người, các hạng mục công trình xây dựng nhà thi đấu thể thao của khu học xá mới đang vững vàng tiến triển về phía trước một cách có trật tự.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '推进',
      'tuījìn',
      'thúc đẩy tiến lên, xúc tiến, đẩy tới',
      'Động từ',
      'HSK 5',
      '在大家的通力配合下，新校区体育场馆的各项建设工程正在平稳有序向前推进。',
      'Zài dàjiā de tōnglì pèihé xià, xīn xiàoqū tǐyù chǎngguǎn de gè xiàng jiànshè gōngchéng zhèngzài píngwěn yǒuxù xiàngqián tuījìn.',
      'Dưới sự phối hợp toàn diện của mọi người, các hạng mục công trình xây dựng nhà thi đấu thể thao của khu học xá mới đang vững vàng tiến triển về phía trước một cách có trật tự.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在大家的通力配合下，新校区体育场馆的各项建设工程正在平稳有序向前推进。', 'Zài dàjiā de tōnglì pèihé xià, xīn xiàoqū tǐyù chǎngguǎn de gè xiàng jiànshè gōngchéng zhèngzài píngwěn yǒuxù xiàngqián tuījìn.', 'Dưới sự phối hợp toàn diện của mọi người, các hạng mục công trình xây dựng nhà thi đấu thể thao của khu học xá mới đang vững vàng tiến triển về phía trước một cách có trật tự.', 'basic', 1),
      (v_id, '坚定不移推进高水平对外开放，稳步推进规则、规制、管理、标准等制度型开放，持续营造市场化法治化国际化一流营商环境。', 'Jiāndìng-bùyí tuījìn gāo-shuǐpíng duìwài kāifàng, wěnbù tuījìn guīzé, guīzhì, guǎnlǐ, biāozhǔn děng zhìdùxíng kāifàng, chíxù yíngzào shìchǎnghuà fǎzhìhuà guójìhuà yīliú yíngshāng huánjìng.', 'Kiên định không dao động thúc đẩy mở cửa đối ngoại trình độ cao, từng bước xúc tiến mở cửa mang tính thể chế về quy tắc, quy chế, quản lý và tiêu chuẩn, liên tục kiến tạo môi trường kinh doanh hàng đầu quốc tế hóa, pháp trị hóa và thị trường hóa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3162] [退] (tuì) - lùi lại, thoái lui, trả lại (hàng, vé) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '退' AND pinyin = 'tuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '退' AND pinyin = 'tuì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '退'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '退'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tuì',
      meaning_vi = 'lùi lại, thoái lui, trả lại (hàng, vé)',
      example_hanzi = '在狭窄的胡同里会车时，前车主动向后倒车退让以便对向车辆通行。',
      example_pinyin = 'Zài xiázhǎi de hútòng lǐ huìchē shí, qiánchē zhǔdòng xiàng hòu dàochē tuìràng yǐbiàn duìxiàng chēliàng tōngxíng.',
      example_vi = 'Khi tránh xe trong con ngõ hẹp, xe phía trước đã chủ động lùi xe nhường đường để xe đi ngược chiều lưu thông qua.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '退',
      'tuì',
      'lùi lại, thoái lui, trả lại (hàng, vé)',
      'Động từ',
      'HSK 5',
      '在狭窄的胡同里会车时，前车主动向后倒车退让以便对向车辆通行。',
      'Zài xiázhǎi de hútòng lǐ huìchē shí, qiánchē zhǔdòng xiàng hòu dàochē tuìràng yǐbiàn duìxiàng chēliàng tōngxíng.',
      'Khi tránh xe trong con ngõ hẹp, xe phía trước đã chủ động lùi xe nhường đường để xe đi ngược chiều lưu thông qua.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在狭窄的胡同里会车时，前车主动向后倒车退让以便对向车辆通行。', 'Zài xiázhǎi de hútòng lǐ huìchē shí, qiánchē zhǔdòng xiàng hòu dàochē tuìràng yǐbiàn duìxiàng chēliàng tōngxíng.', 'Khi tránh xe trong con ngõ hẹp, xe phía trước đã chủ động lùi xe nhường đường để xe đi ngược chiều lưu thông qua.', 'basic', 1),
      (v_id, '根据消费者权益保护法相关规定，通过互联网平台购买的常规七天无理由退货商品应保持商品完好并退回商家。', 'Gēnjù xiāofèizhě quányì bǎohùfǎ xiāngguān guīdìng, tōngguò hùliánwǎng píngtái gòumǎi de chángguī qī tiān wú lǐyóu tuìhuò shāngpǐn yīng bǎochí shāngpǐn wánhǎo bìng tuìhuí shāngjiā.', 'Căn cứ vào quy định liên quan của luật bảo vệ quyền lợi người tiêu dùng, hàng hóa thông thường mua qua nền tảng Internet áp dụng chính sách 7 ngày trả hàng không cần lý do phải giữ nguyên vẹn và gửi trả lại cho bên bán.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3163] [退出] (tuìchū) - rút lui, thoát ra, rút khỏi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '退出' AND pinyin = 'tuìchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '退出' AND pinyin = 'tuìchū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '退出'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '退出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tuìchū',
      meaning_vi = 'rút lui, thoát ra, rút khỏi',
      example_hanzi = '电脑使用完毕后，请记得点击右上角的按钮安全退出个人账号。',
      example_pinyin = 'Diànnǎo shǐyòng wánbì hòu, qǐng jìde diǎnjī yòushàngjiǎo de ànniǔ ānquán tuìchū gèrén zhànghào.',
      example_vi = 'Sau khi dùng máy tính xong, xin hãy nhớ bấm vào nút ở góc trên bên phải để thoát an toàn khỏi tài khoản cá nhân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '退出',
      'tuìchū',
      'rút lui, thoát ra, rút khỏi',
      'Động từ',
      'HSK 5',
      '电脑使用完毕后，请记得点击右上角的按钮安全退出个人账号。',
      'Diànnǎo shǐyòng wánbì hòu, qǐng jìde diǎnjī yòushàngjiǎo de ànniǔ ānquán tuìchū gèrén zhànghào.',
      'Sau khi dùng máy tính xong, xin hãy nhớ bấm vào nút ở góc trên bên phải để thoát an toàn khỏi tài khoản cá nhân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '电脑使用完毕后，请记得点击右上角的按钮安全退出个人账号。', 'Diànnǎo shǐyòng wánbì hòu, qǐng jìde diǎnjī yòushàngjiǎo de ànniǔ ānquán tuìchū gèrén zhànghào.', 'Sau khi dùng máy tính xong, xin hãy nhớ bấm vào nút ở góc trên bên phải để thoát an toàn khỏi tài khoản cá nhân.', 'basic', 1),
      (v_id, '依法完善市场化重整与破产清算制度机制，畅通落后低效产能与僵尸企业的常态化退出渠道。', 'Yīfǎ wánshàn shìchǎnghuà chóngzhěng yǔ pòchǎn qīngsuàn zhìdù jīzhì, chàngtōng luòhòu dīxiào chǎnnéng yǔ jiāngshī qǐyè de chángtàihuà tuìchū qúdào.', 'Hoàn thiện cơ chế thể chế tái cơ cấu theo định hướng thị trường và thanh lý phá sản theo luật định, khơi thông các kênh rút lui thường thái hóa đối với các doanh nghiệp xác sống và năng lực sản xuất yếu kém lạc hậu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3164] [退还] (tuìhuán) - hoàn trả lại, trả lại tiền/vật [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '退还' AND pinyin = 'tuìhuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '退还' AND pinyin = 'tuìhuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '退还'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '退还'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tuìhuán',
      meaning_vi = 'hoàn trả lại, trả lại tiền/vật',
      example_hanzi = '租客在合同到期退房时，房东在确认房屋设施完好后全额退还了押金。',
      example_pinyin = 'Zūkè zài hétong dàoqī tuìfáng shí, fángdōng zài quèrèn fángwū shèshī wánhǎo hòu quán’é tuìhuán le yājīn.',
      example_vi = 'Khi khách thuê nhà hết hạn hợp đồng trả phòng, chủ nhà sau khi xác nhận cơ sở vật chất phòng ốc nguyên vẹn đã hoàn trả toàn bộ số tiền đặt cọc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '退还',
      'tuìhuán',
      'hoàn trả lại, trả lại tiền/vật',
      'Động từ',
      'HSK 5',
      '租客在合同到期退房时，房东在确认房屋设施完好后全额退还了押金。',
      'Zūkè zài hétong dàoqī tuìfáng shí, fángdōng zài quèrèn fángwū shèshī wánhǎo hòu quán’é tuìhuán le yājīn.',
      'Khi khách thuê nhà hết hạn hợp đồng trả phòng, chủ nhà sau khi xác nhận cơ sở vật chất phòng ốc nguyên vẹn đã hoàn trả toàn bộ số tiền đặt cọc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '租客在合同到期退房时，房东在确认房屋设施完好后全额退还了押金。', 'Zūkè zài hétong dàoqī tuìfáng shí, fángdōng zài quèrèn fángwū shèshī wánhǎo hòu quán’é tuìhuán le yājīn.', 'Khi khách thuê nhà hết hạn hợp đồng trả phòng, chủ nhà sau khi xác nhận cơ sở vật chất phòng ốc nguyên vẹn đã hoàn trả toàn bộ số tiền đặt cọc.', 'basic', 1),
      (v_id, '税务机关大力推行增值税留抵退税全流程线上直达服务，依法限期将留抵税额精准退还给符合条件的制造型中小微企业。', 'Shuìwù jīgòu dàlì tuīxíng zēngzhíshuì liúdǐ tuìshuì quán-liúchéng xiànshàng zhídá fúwù, yīfǎ xiànqī jiāng liúdǐ shuì’é jīngzhǔn tuìhuán gěi fúhé tiáojiàn de zhìzàoxíng zhōng-xiǎo-wēi qǐyè.', 'Cơ quan thuế ra sức nhân rộng dịch vụ trực tuyến trực tiếp toàn trình về hoàn thuế giá trị gia tăng lũy kế còn được khấu trừ, hoàn trả chuẩn xác số tiền thuế được hoàn trong thời hạn luật định cho các doanh nghiệp vừa, nhỏ và siêu nhỏ thuộc ngành chế tạo đủ điều kiện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3165] [退休] (tuìxiū) - nghỉ hưu, về hưu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '退休' AND pinyin = 'tuìxiū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '退休' AND pinyin = 'tuìxiū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '退休'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '退休'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'tuìxiū',
      meaning_vi = 'nghỉ hưu, về hưu',
      example_hanzi = '退休之后，李老师在社区老年大学报名学习国画和园艺养花，晚年生活丰富多彩。',
      example_pinyin = 'Tuìxiū zhīhòu, Lǐ lǎoshī zài shèqū lǎonián dàxué bàomíng xuéxí guóhuà hé yuányì yǎnghuā, wǎnnián shēnghuó fēngfù-duōcǎi.',
      example_vi = 'Sau khi nghỉ hưu, thầy Lý đăng ký học tranh thủy mặc và nghệ thuật làm vườn chăm hoa tại trường đại học người cao tuổi của khu phố, cuộc sống tuổi già phong phú muôn màu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '退休',
      'tuìxiū',
      'nghỉ hưu, về hưu',
      'Động từ',
      'HSK 5',
      '退休之后，李老师在社区老年大学报名学习国画和园艺养花，晚年生活丰富多彩。',
      'Tuìxiū zhīhòu, Lǐ lǎoshī zài shèqū lǎonián dàxué bàomíng xuéxí guóhuà hé yuányì yǎnghuā, wǎnnián shēnghuó fēngfù-duōcǎi.',
      'Sau khi nghỉ hưu, thầy Lý đăng ký học tranh thủy mặc và nghệ thuật làm vườn chăm hoa tại trường đại học người cao tuổi của khu phố, cuộc sống tuổi già phong phú muôn màu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '退休之后，李老师在社区老年大学报名学习国画和园艺养花，晚年生活丰富多彩。', 'Tuìxiū zhīhòu, Lǐ lǎoshī zài shèqū lǎonián dàxué bàomíng xuéxí guóhuà hé yuányì yǎnghuā, wǎnnián shēnghuó fēngfù-duōcǎi.', 'Sau khi nghỉ hưu, thầy Lý đăng ký học tranh thủy mặc và nghệ thuật làm vườn chăm hoa tại trường đại học người cao tuổi của khu phố, cuộc sống tuổi già phong phú muôn màu.', 'basic', 1),
      (v_id, '稳妥有序实施渐进式延迟法定退休年龄改革，是积极应对人口老龄化并实现人力资源科学合理开发的重大制度安排。', 'Wěntuǒ yǒuxù shíshī jiànjìnshì yánchí fǎdìng tuìxiū niánlíng gǎigé, shì jījí yìngduì rénkǒu lǎolínghuà bìng shíxiàn rénlì zīyuán kēxué hélǐ kāifā de zhòngdà zhìdù ānpái.', 'Thực thi vững chắc có trật tự cải cách lùi dần độ tuổi nghỉ hưu theo luật định theo lộ trình là sự sắp đặt thể chế trọng đại nhằm tích cực ứng phó già hóa dân số và thực hiện khai thác hợp lý khoa học nguồn lực nhân lực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3166] [拖鞋] (tuōxié) - dép lê, dép đi trong nhà [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '拖鞋' AND pinyin = 'tuōxié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拖鞋' AND pinyin = 'tuōxié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '拖鞋'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拖鞋'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'tuōxié',
      meaning_vi = 'dép lê, dép đi trong nhà',
      example_hanzi = '每天下班回到家，换上一双柔软舒适的棉拖鞋，整个人顿时放松了下来。',
      example_pinyin = 'Měitiān xiàbān huí dào jiā, huàn shàng yì shuāng róuruǎn shūshì de mián tuōxié, zhěng ge rén dùnshí fàngsōng le xiàlai.',
      example_vi = 'Mỗi ngày tan làm về đến nhà, đổi sang một đôi dép lê bông mềm mại dễ chịu, cả người lập tức cảm thấy thư giãn hẳn ra.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '拖鞋',
      'tuōxié',
      'dép lê, dép đi trong nhà',
      'Danh từ',
      'HSK 5',
      '每天下班回到家，换上一双柔软舒适的棉拖鞋，整个人顿时放松了下来。',
      'Měitiān xiàbān huí dào jiā, huàn shàng yì shuāng róuruǎn shūshì de mián tuōxié, zhěng ge rén dùnshí fàngsōng le xiàlai.',
      'Mỗi ngày tan làm về đến nhà, đổi sang một đôi dép lê bông mềm mại dễ chịu, cả người lập tức cảm thấy thư giãn hẳn ra.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天下班回到家，换上一双柔软舒适的棉拖鞋，整个人顿时放松了下来。', 'Měitiān xiàbān huí dào jiā, huàn shàng yì shuāng róuruǎn shūshì de mián tuōxié, zhěng ge rén dùnshí fàngsōng le xiàlai.', 'Mỗi ngày tan làm về đến nhà, đổi sang một đôi dép lê bông mềm mại dễ chịu, cả người lập tức cảm thấy thư giãn hẳn ra.', 'basic', 1),
      (v_id, '酒店客房全面推行绿色低碳环保行动，不再主动提供一次性塑料拖鞋与日化消耗品，引导房客践行可持续绿色出行理念。', 'Jiǔdiàn kèfáng quánmiàn tuīxíng lǜsè dītàn huánbǎo xíngdòng, bú zài zhǔdòng tígōng yícìxìng sùliào tuōxié yǔ rìhuà xiāohàopǐn, yǐndǎo fángkè jiànxíng kěchíxù lǜsè chūxíng lǐniàn.', 'Phòng nghỉ khách sạn thực hiện toàn diện hành động bảo vệ môi trường xanh ít carbon, không còn chủ động cung cấp dép lê nhựa dùng một lần và đồ dùng hóa mỹ phẩm tiêu hao, định hướng du khách thực hành quan niệm du lịch xanh bền vững.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3167] [外部] (wàibù) - bên ngoài, ngoại vi, bên ngoài tổ chức/hệ thống [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '外部' AND pinyin = 'wàibù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外部' AND pinyin = 'wàibù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '外部'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外部'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wàibù',
      meaning_vi = 'bên ngoài, ngoại vi, bên ngoài tổ chức/hệ thống',
      example_hanzi = '这栋现代化教学大楼的外部墙面全部采用了具有隔热节能效果的钢化玻璃幕墙。',
      example_pinyin = 'Zhè dòng xiàndàihuà jiàoxué dàlóu de wàibù qiángmiàn quánbù cǎiyòng le jùyǒu gérè jiénéng xiàoguǒ de gānghuà bōli mùqiáng.',
      example_vi = 'Mặt tường bên ngoài của tòa nhà giảng đường hiện đại này toàn bộ đều áp dụng vách kính cường lực có hiệu quả cách nhiệt và tiết kiệm năng lượng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '外部',
      'wàibù',
      'bên ngoài, ngoại vi, bên ngoài tổ chức/hệ thống',
      'Danh từ',
      'HSK 5',
      '这栋现代化教学大楼的外部墙面全部采用了具有隔热节能效果的钢化玻璃幕墙。',
      'Zhè dòng xiàndàihuà jiàoxué dàlóu de wàibù qiángmiàn quánbù cǎiyòng le jùyǒu gérè jiénéng xiàoguǒ de gānghuà bōli mùqiáng.',
      'Mặt tường bên ngoài của tòa nhà giảng đường hiện đại này toàn bộ đều áp dụng vách kính cường lực có hiệu quả cách nhiệt và tiết kiệm năng lượng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这栋现代化教学大楼的外部墙面全部采用了具有隔热节能效果的钢化玻璃幕墙。', 'Zhè dòng xiàndàihuà jiàoxué dàlóu de wàibù qiángmiàn quánbù cǎiyòng le jùyǒu gérè jiénéng xiàoguǒ de gānghuà bōli mùqiáng.', 'Mặt tường bên ngoài của tòa nhà giảng đường hiện đại này toàn bộ đều áp dụng vách kính cường lực có hiệu quả cách nhiệt và tiết kiệm năng lượng.', 'basic', 1),
      (v_id, '面对严峻复杂多变的外部地缘政治经济环境，我国必须牢牢把握扩大内需这一战略基点，以国内大循环的确定性对冲外部环境的不确定性。', 'Miànduì yánjùn fùzá duōbiàn de wàibù dìyuán zhèngzhì jīngjì huánjìng, wǒguó bìxū láoláo bǎwò kuòdà nèixū zhè yí zhànlüè jīdiǎn, yǐ guónèi dà xúnhuán de quèdìngxìng duìchōng wàibù huánjìng de bú-quèdìngxìng.', 'Đối mặt với môi trường kinh tế chính trị địa duyên bên ngoài gay gắt phức tạp đa biến, nước ta bắt buộc phải nắm chắc điểm tựa chiến lược mở rộng nội cầu, dùng tính xác định của đại tuần hoàn trong nước để bù trừ hóa giải tính bất định của môi trường bên ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3168] [外公] (wàigōng) - ông ngoại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '外公' AND pinyin = 'wàigōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外公' AND pinyin = 'wàigōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '外公'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外公'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wàigōng',
      meaning_vi = 'ông ngoại',
      example_hanzi = '每逢暑假，他最喜欢去乡下外公家的小菜园里采摘新鲜的西红柿和黄瓜。',
      example_pinyin = 'Měiféng shǔjià, tā zuì xǐhuan qù xiāngxià wàigōng jiā de xiǎocàiyuán lǐ cǎizhāi xīnxiān de xīhóngshì hé huángguā.',
      example_vi = 'Cứ mỗi dịp nghỉ hè, em thích nhất là về mảnh vườn rau nhỏ nhà ông ngoại ở nông thôn để hái những quả cà chua và dưa chuột tươi rói.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '外公',
      'wàigōng',
      'ông ngoại',
      'Danh từ',
      'HSK 5',
      '每逢暑假，他最喜欢去乡下外公家的小菜园里采摘新鲜的西红柿和黄瓜。',
      'Měiféng shǔjià, tā zuì xǐhuan qù xiāngxià wàigōng jiā de xiǎocàiyuán lǐ cǎizhāi xīnxiān de xīhóngshì hé huángguā.',
      'Cứ mỗi dịp nghỉ hè, em thích nhất là về mảnh vườn rau nhỏ nhà ông ngoại ở nông thôn để hái những quả cà chua và dưa chuột tươi rói.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每逢暑假，他最喜欢去乡下外公家的小菜园里采摘新鲜的西红柿和黄瓜。', 'Měiféng shǔjià, tā zuì xǐhuan qù xiāngxià wàigōng jiā de xiǎocàiyuán lǐ cǎizhāi xīnxiān de xīhóngshì hé huángguā.', 'Cứ mỗi dịp nghỉ hè, em thích nhất là về mảnh vườn rau nhỏ nhà ông ngoại ở nông thôn để hái những quả cà chua và dưa chuột tươi rói.', 'basic', 1),
      (v_id, '外公作为参与新中国第一代重工业基地建设的老劳模，他那艰苦奋斗、淡泊名利的高尚风骨深深烙印在整个家族后辈的心中。', 'Wàigōng zuòwéi cānyù xīn Zhōngguó dì-yī-dài zhònggōngyè jīdì jiànshè de lǎo láomó, tā nà jiānkǔ-fèndòu, dànbó-mínglì de gāoshàng fēnggǔ shēnshēn làoyìn zài zhěng ge jiāzú hòubèi de xīn zhōng.', 'Ông ngoại với tư cách là một chiến sĩ thi đua lão thành từng tham gia xây dựng căn cứ công nghiệp nặng thế hệ đầu tiên của nước Trung Hoa mới, khí phách cao thượng gian khổ phấn đấu coi nhẹ danh lợi của ông đã khắc sâu trong tâm khảm của các thế hệ con cháu toàn bộ gia tộc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3169] [外观] (wàiguān) - ngoại quan, diện mạo bên ngoài [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '外观' AND pinyin = 'wàiguān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外观' AND pinyin = 'wàiguān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '外观'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外观'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wàiguān',
      meaning_vi = 'ngoại quan, diện mạo bên ngoài',
      example_hanzi = '这款新款笔记本电脑采用了流线型金属机身，外观看起来既时尚又轻薄。',
      example_pinyin = 'Zhè kuǎn xīnkuǎn bǐjìběn diànnǎo cǎiyòng le liúxiànxíng jīnshǔ jīshēn, wàiguān kàn qǐlai jì shíshàng yòu qīngbáo.',
      example_vi = 'Chiếc máy tính xách tay mẫu mới này áp dụng thân vỏ kim loại dạng khí động học thuôn mượt, diện mạo bên ngoài trông vừa thời trang lại vừa mỏng nhẹ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '外观',
      'wàiguān',
      'ngoại quan, diện mạo bên ngoài',
      'Danh từ',
      'HSK 5',
      '这款新款笔记本电脑采用了流线型金属机身，外观看起来既时尚又轻薄。',
      'Zhè kuǎn xīnkuǎn bǐjìběn diànnǎo cǎiyòng le liúxiànxíng jīnshǔ jīshēn, wàiguān kàn qǐlai jì shíshàng yòu qīngbáo.',
      'Chiếc máy tính xách tay mẫu mới này áp dụng thân vỏ kim loại dạng khí động học thuôn mượt, diện mạo bên ngoài trông vừa thời trang lại vừa mỏng nhẹ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这款新款笔记本电脑采用了流线型金属机身，外观看起来既时尚又轻薄。', 'Zhè kuǎn xīnkuǎn bǐjìběn diànnǎo cǎiyòng le liúxiànxíng jīnshǔ jīshēn, wàiguān kàn qǐlai jì shíshàng yòu qīngbáo.', 'Chiếc máy tính xách tay mẫu mới này áp dụng thân vỏ kim loại dạng khí động học thuôn mượt, diện mạo bên ngoài trông vừa thời trang lại vừa mỏng nhẹ.', 'basic', 1),
      (v_id, '工业设计专家委员会在评审高端装备工业设计奖项时，兼顾了人机工程美学外观与极端工况环境下的耐磨抗腐蚀功能可靠性。', 'Gōngyè shèjì zhuānjiā wěiyuánhuì zài píngshěn gāoduān zhuāngbèi gōngyè shèjì jiǎngxiàng shí, jiāngù le rénjī gōngchéng měixué wàiguān yǔ jíduān gōngkuàng huánjìng xià de nàimó kàng-fǔshí gōngnéng kěkàoxìng.', 'Hội đồng chuyên gia thiết kế công nghiệp khi thẩm định các giải thưởng thiết kế công nghiệp trang thiết bị cao cấp đã xem xét dung hòa giữa diện mạo mỹ học công thái học người-máy và độ tin cậy công năng chống ăn mòn chịu mài mòn dưới môi trường làm việc cực đoan.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3170] [外婆] (wàipó) - bà ngoại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '外婆' AND pinyin = 'wàipó'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外婆' AND pinyin = 'wàipó'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '外婆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外婆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wàipó',
      meaning_vi = 'bà ngoại',
      example_hanzi = '每次回老家看望外婆，慈祥的老人家总是早早备好了孙子最爱吃的江南传统桂花糕。',
      example_pinyin = 'Měi cì huí lǎojiā kànwàng wàipó, cíxiáng de lǎorénjia zǒngshì zǎozǎo bèi hǎo le sūnzi zuì ài chī de Jiāngnán chuántǒng guìhuāgāo.',
      example_vi = 'Mỗi lần về quê thăm bà ngoại, người bà đôn hậu bao giờ cũng chuẩn bị từ sớm món bánh hoa quế truyền thống vùng Giang Nam mà đứa cháu thích ăn nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '外婆',
      'wàipó',
      'bà ngoại',
      'Danh từ',
      'HSK 5',
      '每次回老家看望外婆，慈祥的老人家总是早早备好了孙子最爱吃的江南传统桂花糕。',
      'Měi cì huí lǎojiā kànwàng wàipó, cíxiáng de lǎorénjia zǒngshì zǎozǎo bèi hǎo le sūnzi zuì ài chī de Jiāngnán chuántǒng guìhuāgāo.',
      'Mỗi lần về quê thăm bà ngoại, người bà đôn hậu bao giờ cũng chuẩn bị từ sớm món bánh hoa quế truyền thống vùng Giang Nam mà đứa cháu thích ăn nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每次回老家看望外婆，慈祥的老人家总是早早备好了孙子最爱吃的江南传统桂花糕。', 'Měi cì huí lǎojiā kànwàng wàipó, cíxiáng de lǎorénjia zǒngshì zǎozǎo bèi hǎo le sūnzi zuì ài chī de Jiāngnán chuántǒng guìhuāgāo.', 'Mỗi lần về quê thăm bà ngoại, người bà đôn hậu bao giờ cũng chuẩn bị từ sớm món bánh hoa quế truyền thống vùng Giang Nam mà đứa cháu thích ăn nhất.', 'basic', 1),
      (v_id, '外婆手把手传授给后辈的江南扎染与传统丝绣针法，成为全家人用心守护与世代赓续的非物质文化遗产家族记忆。', 'Wàipó shǒubǎshǒu chuánshòu gěi hòubèi de Jiāngnán zāshī yǔ chuántǒng sīxiù zhēnfǎ, chéngwéi quán jiā rén yòngxīn shǒuhù yǔ shìdài gēngxù de fēiwùzhì wénhuà yíchǎn jiāzú jìyì.', 'Kỹ thuật nhuộm buộc và đường kim thêu tơ tằm truyền thống vùng Giang Nam mà bà ngoại tận tay truyền dạy cho hậu bối đã trở thành ký ức gia tộc di sản văn hóa phi vật thể mà cả gia đình dốc lòng gìn giữ và nối tiếp qua nhiều thế hệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3171] [外形] (wàixíng) - hình dáng bên ngoài, ngoại hình, phom dáng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '外形' AND pinyin = 'wàixíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外形' AND pinyin = 'wàixíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '外形'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '外形'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wàixíng',
      meaning_vi = 'hình dáng bên ngoài, ngoại hình, phom dáng',
      example_hanzi = '新设计的水下探测器采用了模仿深海蝠鲼的扁平仿生外形，游动时阻力极小。',
      example_pinyin = 'Xīn shèjì de shuǐxià tàncèqì cǎiyòng le mófǎng shēnhǎi fúfèn de biǎnpíng fǎngshēng wàixíng, yóudòng shí zǔlì jí xiǎo.',
      example_vi = 'Thiết bị thăm dò dưới nước thiết kế mới áp dụng phom dáng mô phỏng sinh học hình dẹt của loài cá đuối biển sâu, sức cản cực nhỏ khi bơi lội.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '外形',
      'wàixíng',
      'hình dáng bên ngoài, ngoại hình, phom dáng',
      'Danh từ',
      'HSK 5',
      '新设计的水下探测器采用了模仿深海蝠鲼的扁平仿生外形，游动时阻力极小。',
      'Xīn shèjì de shuǐxià tàncèqì cǎiyòng le mófǎng shēnhǎi fúfèn de biǎnpíng fǎngshēng wàixíng, yóudòng shí zǔlì jí xiǎo.',
      'Thiết bị thăm dò dưới nước thiết kế mới áp dụng phom dáng mô phỏng sinh học hình dẹt của loài cá đuối biển sâu, sức cản cực nhỏ khi bơi lội.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新设计的水下探测器采用了模仿深海蝠鲼的扁平仿生外形，游动时阻力极小。', 'Xīn shèjì de shuǐxià tàncèqì cǎiyòng le mófǎng shēnhǎi fúfèn de biǎnpíng fǎngshēng wàixíng, yóudòng shí zǔlì jí xiǎo.', 'Thiết bị thăm dò dưới nước thiết kế mới áp dụng phom dáng mô phỏng sinh học hình dẹt của loài cá đuối biển sâu, sức cản cực nhỏ khi bơi lội.', 'basic', 1),
      (v_id, '新一代宽体大型民用客机在气动外形优化中广泛采用了超临界机翼与仿生翼尖小翼构型，大幅降低巡航诱导阻力并显著提升燃油经济性。', 'Xīn yí dài kuāntǐ dàxíng mínyòng kèjī zài qìdòng wàixíng yōuhuà zhōng guǎngfàn cǎiyòng le chāolínjiè jīyì yǔ fǎngshēng yìjiān xiǎoyì gòuxíng, dàfú jiàngdī xúnháng yòudǎo zǔlì bìng xiǎnzhù tíshēng rányóu jīngjìxìng.', 'Máy bay chở khách dân dụng cỡ lớn thân rộng thế hệ mới trong việc tối ưu hóa hình dáng khí động học đã áp dụng rộng rãi cấu hình cánh siêu tới hạn và cánh nhỏ đầu mút mô phỏng sinh học, giảm mạnh sức cản cảm ứng hành trình và nâng cao rõ rệt tính kinh tế tiết kiệm nhiên liệu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3172] [弯] (wān) - cong, uốn cong; khúc quanh, khúc cua [Tính từ / Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '弯' AND pinyin = 'wān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '弯' AND pinyin = 'wān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '弯'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '弯'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ / Danh từ',
      pinyin = 'wān',
      meaning_vi = 'cong, uốn cong; khúc quanh, khúc cua',
      example_hanzi = '汽车行驶在盘山公路上，司机师傅在每一个急弯处都减速按喇叭提醒对向来车。',
      example_pinyin = 'Qìchē xíngshǐ zài pánshān gōnglù shang, sījī shīfu zài měi yí ge jíwān chù dōu jiǎnsù àn lǎba tíxǐng duìxiàng láichē.',
      example_vi = 'Xe ô tô lưu thông trên đường đèo quanh núi, bác tài xế ở mỗi khúc cua gắt đều giảm tốc độ bấm còi nhắc nhở xe đi chiều ngược lại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '弯',
      'wān',
      'cong, uốn cong; khúc quanh, khúc cua',
      'Tính từ / Động từ / Danh từ',
      'HSK 5',
      '汽车行驶在盘山公路上，司机师傅在每一个急弯处都减速按喇叭提醒对向来车。',
      'Qìchē xíngshǐ zài pánshān gōnglù shang, sījī shīfu zài měi yí ge jíwān chù dōu jiǎnsù àn lǎba tíxǐng duìxiàng láichē.',
      'Xe ô tô lưu thông trên đường đèo quanh núi, bác tài xế ở mỗi khúc cua gắt đều giảm tốc độ bấm còi nhắc nhở xe đi chiều ngược lại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '汽车行驶在盘山公路上，司机师傅在每一个急弯处都减速按喇叭提醒对向来车。', 'Qìchē xíngshǐ zài pánshān gōnglù shang, sījī shīfu zài měi yí ge jíwān chù dōu jiǎnsù àn lǎba tíxǐng duìxiàng láichē.', 'Xe ô tô lưu thông trên đường đèo quanh núi, bác tài xế ở mỗi khúc cua gắt đều giảm tốc độ bấm còi nhắc nhở xe đi chiều ngược lại.', 'basic', 1),
      (v_id, '现代重型工业大口径厚壁合金管道采用中频感应局部无缝热弯工艺，确保管道弯曲部位承压强度与微观晶粒度完全达标。', 'Xiàndài zhòngxíng gōngyè dà-kǒujìng hòubì héjīn guǎndào cǎiyòng zhōngpín gǎnyìng júbù wùfèng rèwān gōngyì, quèbǎo guǎndào wānqū bùwèi chéngyā qiángdù yǔ wēiguān jīnglìdù wánquán dābiāo.', 'Đường ống hợp kim thành dày khẩu độ lớn của công nghiệp nặng hiện đại áp dụng quy trình uốn nhiệt không mối nối cục bộ bằng cảm ứng trung tần, bảo đảm độ bền chịu áp lực và độ mịn hạt tinh thể vi mô tại vị trí uốn cong của đường ống hoàn toàn đạt chuẩn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3173] [玩具] (wánjù) - đồ chơi, đồ chơi trẻ em [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '玩具' AND pinyin = 'wánjù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '玩具' AND pinyin = 'wánjù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '玩具'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '玩具'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wánjù',
      meaning_vi = 'đồ chơi, đồ chơi trẻ em',
      example_hanzi = '六一国际儿童节那天，爸爸送给儿子一套精致的拼装遥控赛车玩具。',
      example_pinyin = 'Liùyī Guójì Értóngjié nà tiān, bàba sòng gěi érzi yí tào jīngzhì de pīnzhuāng yáokòng sàichē wánjù.',
      example_vi = 'Ngày Quốc tế Thiếu nhi 1/6, bố đã tặng cho con trai một bộ đồ chơi xe đua điều khiển từ xa lắp ráp tinh xảo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '玩具',
      'wánjù',
      'đồ chơi, đồ chơi trẻ em',
      'Danh từ',
      'HSK 5',
      '六一国际儿童节那天，爸爸送给儿子一套精致的拼装遥控赛车玩具。',
      'Liùyī Guójì Értóngjié nà tiān, bàba sòng gěi érzi yí tào jīngzhì de pīnzhuāng yáokòng sàichē wánjù.',
      'Ngày Quốc tế Thiếu nhi 1/6, bố đã tặng cho con trai một bộ đồ chơi xe đua điều khiển từ xa lắp ráp tinh xảo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '六一国际儿童节那天，爸爸送给儿子一套精致的拼装遥控赛车玩具。', 'Liùyī Guójì Értóngjié nà tiān, bàba sòng gěi érzi yí tào jīngzhì de pīnzhuāng yáokòng sàichē wánjù.', 'Ngày Quốc tế Thiếu nhi 1/6, bố đã tặng cho con trai một bộ đồ chơi xe đua điều khiển từ xa lắp ráp tinh xảo.', 'basic', 1),
      (v_id, '出口儿童玩具生产企业必须严格遵循国际玩具安全标准认证，严禁在塑料与涂层中添加任何超标的塑化剂与重金属有毒有害物质。', 'Chūkǒu értóng wánjù shēngchǎn qǐyè bìxū yángé zūnxún guójì wánjù ānquán biāozhǔn rènzhèng, yánjìn zài sùliào yǔ túcéng zhōng tiānjiā rènhé chāobiāo de sùhuàjì yǔ zhòngjīnshǔ yǒudú-yǒuhài wùzhì.', 'Doanh nghiệp sản xuất đồ chơi trẻ em xuất khẩu bắt buộc phải tuân thủ nghiêm ngặt các chứng nhận tiêu chuẩn an toàn đồ chơi quốc tế, nghiêm cấm thêm bất kỳ chất hóa dẻo hay kim loại nặng độc hại vượt quá tiêu chuẩn nào vào nhựa và lớp sơn phủ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3174] [完美] (wánměi) - hoàn mỹ, hoàn hảo, không tì vết [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '完美' AND pinyin = 'wánměi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '完美' AND pinyin = 'wánměi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '完美'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '完美'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'wánměi',
      meaning_vi = 'hoàn mỹ, hoàn hảo, không tì vết',
      example_hanzi = '经过全体演职人员数月的排练，昨晚的芭蕾舞剧专场演出堪称完美。',
      example_pinyin = 'Jīngguò quántǐ yǎnzhí rényuán shù yuè de páiliàn, zuówǎn de bālěiwǔjù zhuānchǎng yǎnchū kānchēng wánměi.',
      example_vi = 'Sau mấy tháng luyện tập của toàn thể diễn viên và ban tổ chức, buổi công diễn vở múa ba-lê tối qua xứng đáng gọi là hoàn mỹ tuyệt vời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '完美',
      'wánměi',
      'hoàn mỹ, hoàn hảo, không tì vết',
      'Tính từ',
      'HSK 5',
      '经过全体演职人员数月的排练，昨晚的芭蕾舞剧专场演出堪称完美。',
      'Jīngguò quántǐ yǎnzhí rényuán shù yuè de páiliàn, zuówǎn de bālěiwǔjù zhuānchǎng yǎnchū kānchēng wánměi.',
      'Sau mấy tháng luyện tập của toàn thể diễn viên và ban tổ chức, buổi công diễn vở múa ba-lê tối qua xứng đáng gọi là hoàn mỹ tuyệt vời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过全体演职人员数月的排练，昨晚的芭蕾舞剧专场演出堪称完美。', 'Jīngguò quántǐ yǎnzhí rényuán shù yuè de páiliàn, zuówǎn de bālěiwǔjù zhuānchǎng yǎnchū kānchēng wánměi.', 'Sau mấy tháng luyện tập của toàn thể diễn viên và ban tổ chức, buổi công diễn vở múa ba-lê tối qua xứng đáng gọi là hoàn mỹ tuyệt vời.', 'basic', 1),
      (v_id, '追求极致卓越的工匠精神要求将工程制造精度推向极限，实现硬核尖端装备各子系统机电协同与人机界面的完美契合。', 'Zhuīqiú jízhì zhuóyuè de gōngjiàng jīngshén yāoqiú jiāng gōngchéng zhìzào jīngdù tuī xiàng jíxiàn, shíxiàn yìnghé jiānduān zhuāngbèi gè zǐxìtǒng jīdiàn xiétóng yǔ rénjī jièmiàn de wánměi qìhé.', 'Tinh thần người thợ lành nghề theo đuổi sự xuất sắc tột đỉnh đòi hỏi phải đẩy độ chính xác trong chế tạo công trình đạt đến giới hạn, hiện thực hóa sự ăn khớp hoàn hảo giữa phối hợp cơ điện các hệ thống con và giao diện người-máy của trang thiết bị mũi nhọn cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3175] [完善] (wánshàn) - hoàn thiện, hoàn chỉnh; làm cho hoàn hảo [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '完善' AND pinyin = 'wánshàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '完善' AND pinyin = 'wánshàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '完善'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '完善'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'wánshàn',
      meaning_vi = 'hoàn thiện, hoàn chỉnh; làm cho hoàn hảo',
      example_hanzi = '这篇学术调研论文的论点非常鲜明，但在结论部分仍需进一步修改和完善。',
      example_pinyin = 'Zhè piān xuéshù diàoyán lùnwén de lùndiǎn fēicháng xiānmíng, dàn zài jiélùn bùfen réng xū jìnyíbù xiūgǎi hé wánshàn.',
      example_vi = 'Luận điểm của bài luận văn khảo sát học thuật này rất rõ ràng, nhưng ở phần kết luận vẫn cần chỉnh sửa và hoàn thiện thêm một bước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '完善',
      'wánshàn',
      'hoàn thiện, hoàn chỉnh; làm cho hoàn hảo',
      'Tính từ / Động từ',
      'HSK 5',
      '这篇学术调研论文的论点非常鲜明，但在结论部分仍需进一步修改和完善。',
      'Zhè piān xuéshù diàoyán lùnwén de lùndiǎn fēicháng xiānmíng, dàn zài jiélùn bùfen réng xū jìnyíbù xiūgǎi hé wánshàn.',
      'Luận điểm của bài luận văn khảo sát học thuật này rất rõ ràng, nhưng ở phần kết luận vẫn cần chỉnh sửa và hoàn thiện thêm một bước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这篇学术调研论文的论点非常鲜明，但在结论部分仍需进一步修改和完善。', 'Zhè piān xuéshù diàoyán lùnwén de lùndiǎn fēicháng xiānmíng, dàn zài jiélùn bùfen réng xū jìnyíbù xiūgǎi hé wánshàn.', 'Luận điểm của bài luận văn khảo sát học thuật này rất rõ ràng, nhưng ở phần kết luận vẫn cần chỉnh sửa và hoàn thiện thêm một bước.', 'basic', 1),
      (v_id, '建立健全公平竞争审查机制，加快完善知识产权综合司法保护体系，切实筑牢激励原始创新的法治基石。', 'Jiànlì jiànquán gōngpíng jìngzhēng shěnchá jīzhì, jiākuài wánshàn zhīshi chǎnquán zōnghé sīfǎ bǎohù tǐxì, qièshí zhù láo jīlì yuánshǐ chuàngxīn de fǎzhì jīshí.', 'Xây dựng và hoàn thiện cơ chế thẩm tra cạnh tranh công bằng, đẩy nhanh hoàn thiện hệ thống bảo hộ tư pháp tổng hợp quyền sở hữu trí tuệ, đắp vững chắc nền móng pháp trị khuyến khích đổi mới nguyên bản.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3176] [完整] (wánzhěng) - hoàn chỉnh, trọn vẹn, nguyên vẹn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '完整' AND pinyin = 'wánzhěng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '完整' AND pinyin = 'wánzhěng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '完整'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '完整'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'wánzhěng',
      meaning_vi = 'hoàn chỉnh, trọn vẹn, nguyên vẹn',
      example_hanzi = '考古工作者在古墓发掘现场，成功提取出一件保存十分完好的唐代三彩陶马。',
      example_pinyin = 'Kǎogǔ gōngzuòzhě zài gǔmù fājué xiànchǎng, chénggōng tíqǔ chū yí jiàn bǎocún shífēn wánhǎo de Tángdài sāncǎi táomǎ.',
      example_vi = 'Các cán bộ khảo cổ tại hiện trường khai quật mộ cổ đã khai quật thành công một chú ngựa gốm tam thái thời Đường còn bảo tồn nguyên vẹn hoàn hảo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '完整',
      'wánzhěng',
      'hoàn chỉnh, trọn vẹn, nguyên vẹn',
      'Tính từ',
      'HSK 5',
      '考古工作者在古墓发掘现场，成功提取出一件保存十分完好的唐代三彩陶马。',
      'Kǎogǔ gōngzuòzhě zài gǔmù fājué xiànchǎng, chénggōng tíqǔ chū yí jiàn bǎocún shífēn wánhǎo de Tángdài sāncǎi táomǎ.',
      'Các cán bộ khảo cổ tại hiện trường khai quật mộ cổ đã khai quật thành công một chú ngựa gốm tam thái thời Đường còn bảo tồn nguyên vẹn hoàn hảo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '考古工作者在古墓发掘现场，成功提取出一件保存十分完好的唐代三彩陶马。', 'Kǎogǔ gōngzuòzhě zài gǔmù fājué xiànchǎng, chénggōng tíqǔ chū yí jiàn bǎocún shífēn wánhǎo de Tángdài sāncǎi táomǎ.', 'Các cán bộ khảo cổ tại hiện trường khai quật mộ cổ đã khai quật thành công một chú ngựa gốm tam thái thời Đường còn bảo tồn nguyên vẹn hoàn hảo.', 'basic', 1),
      (v_id, '我国已建成全球门类最齐全、体系最完整的现代工业制造业配套产业链，构成了抵御外部风险冲击的战略纵深底盘。', 'Wǒguó yǐ jiànchéng quánqiú ménlèi zuì qíquán, tǐxì zuì wánzhěng de xiàndài gōngyè zhìzàoyè pèitào chǎnyèliàn, gòuchéng le dǐyù wàibù fēngxiǎn chōngjī de zhànlüè zòngshēn dǐpán.', 'Nước ta đã xây dựng được chuỗi sản xuất phụ trợ ngành công nghiệp chế tạo hiện đại có danh mục đầy đủ nhất và hệ thống hoàn chỉnh nhất toàn cầu, cấu thành bệ đỡ chiều sâu chiến lược để chống chọi các cú sốc rủi ro từ bên ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3177] [万一] (wànyī) - vạn nhất, ngộ nhỡ, lỡ như; trường hợp bất trắc [Liên từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '万一' AND pinyin = 'wànyī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '万一' AND pinyin = 'wànyī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '万一'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '万一'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ / Danh từ',
      pinyin = 'wànyī',
      meaning_vi = 'vạn nhất, ngộ nhỡ, lỡ như; trường hợp bất trắc',
      example_hanzi = '出门前请随身携带一把折叠雨伞，以防万一下雨。',
      example_pinyin = 'Chūmén qián qǐng suíshēn xiédài yī bǎ zhédié yǔsǎn, yǐfáng wànyī xiàyǔ.',
      example_vi = 'Trước khi ra ngoài xin hãy mang theo một chiếc ô gập bên mình phòng khi ngộ nhỡ trời đổ mưa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '万一',
      'wànyī',
      'vạn nhất, ngộ nhỡ, lỡ như; trường hợp bất trắc',
      'Liên từ / Danh từ',
      'HSK 5',
      '出门前请随身携带一把折叠雨伞，以防万一下雨。',
      'Chūmén qián qǐng suíshēn xiédài yī bǎ zhédié yǔsǎn, yǐfáng wànyī xiàyǔ.',
      'Trước khi ra ngoài xin hãy mang theo một chiếc ô gập bên mình phòng khi ngộ nhỡ trời đổ mưa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出门前请随身携带一把折叠雨伞，以防万一下雨。', 'Chūmén qián qǐng suíshēn xiédài yī bǎ zhédié yǔsǎn, yǐfáng wànyī xiàyǔ.', 'Trước khi ra ngoài xin hãy mang theo một chiếc ô gập bên mình phòng khi ngộ nhỡ trời đổ mưa.', 'basic', 1),
      (v_id, '金融机构必须建立健全极端流动性危机与突发网络瘫痪的应急预案，防范万一出现的系统性金融风险。', 'Jīnróng jīgòu bìxū jiànlì jiànquán jíduān liúdòngxìng wēijī yǔ tūfā wǎngluò tānhuàn de yìngjí yù’àn, fángfàn wànyī chūxiàn de xìtǒngxìng jīnróng fēngxiǎn.', 'Các định chế tài chính bắt buộc phải xây dựng hoàn thiện phương án ứng phó khẩn cấp đối với khủng hoảng thanh khoản cực đoan và tê liệt mạng bất ngờ, phòng ngừa rủi ro tài chính mang tính hệ thống rủi ro xảy ra.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3178] [往返] (wǎngfǎn) - khứ hồi, đi đi về về, qua lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '往返' AND pinyin = 'wǎngfǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '往返' AND pinyin = 'wǎngfǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '往返'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '往返'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wǎngfǎn',
      meaning_vi = 'khứ hồi, đi đi về về, qua lại',
      example_hanzi = '这趟高速列车往返于北京和上海之间，单程仅需四个多小时。',
      example_pinyin = 'Zhè tàng gāosù lièchē wǎngfǎn yú Běijīng hé Shànghǎi zhījiān, dānchéng jǐn xū sì gè duō xiǎoshí.',
      example_vi = 'Chuyến tàu cao tốc này chạy khứ hồi giữa Bắc Kinh và Thượng Hải, một chiều chỉ mất hơn bốn tiếng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '往返',
      'wǎngfǎn',
      'khứ hồi, đi đi về về, qua lại',
      'Động từ',
      'HSK 5',
      '这趟高速列车往返于北京和上海之间，单程仅需四个多小时。',
      'Zhè tàng gāosù lièchē wǎngfǎn yú Běijīng hé Shànghǎi zhījiān, dānchéng jǐn xū sì gè duō xiǎoshí.',
      'Chuyến tàu cao tốc này chạy khứ hồi giữa Bắc Kinh và Thượng Hải, một chiều chỉ mất hơn bốn tiếng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这趟高速列车往返于北京和上海之间，单程仅需四个多小时。', 'Zhè tàng gāosù lièchē wǎngfǎn yú Běijīng hé Shànghǎi zhījiān, dānchéng jǐn xū sì gè duō xiǎoshí.', 'Chuyến tàu cao tốc này chạy khứ hồi giữa Bắc Kinh và Thượng Hải, một chiều chỉ mất hơn bốn tiếng.', 'basic', 1),
      (v_id, '跨境商旅专线航班的高密度复航极大便利了两国商务代表团的高频往返，有力推动了双边经贸合作与文化交流。', 'Kuàjìng shānglǚ zhuānxiàn hángbān de gāomìdù fùháng jídà biànlì le liǎng guó shāngwù dàibiǎotuán de gāopín wǎngfǎn, yǒulì tuīdòng le shuāngbiān jīngmào hézuò yǔ wénhuà jiāoliú.', 'Việc khôi phục mật độ cao các chuyến bay thương mại xuyên biên giới đã tạo điều kiện vô cùng thuận lợi cho các đoàn đại biểu thương mại hai nước đi lại với tần suất cao, thúc đẩy mạnh mẽ hợp tác kinh tế - thương mại và giao lưu văn hóa song phương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3179] [网络] (wǎngluò) - mạng lưới, mạng internet, viễn thông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '网络' AND pinyin = 'wǎngluò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '网络' AND pinyin = 'wǎngluò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '网络'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '网络'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wǎngluò',
      meaning_vi = 'mạng lưới, mạng internet, viễn thông',
      example_hanzi = '现代社会中，人们的工作、学习与日常生活都已离不开互联网络。',
      example_pinyin = 'Xiàndài shèhuì zhōng, rénmen de gōngzuò, xuéxí yǔ rìcháng shēnghuó dōu yǐ lí bù kāi hùlián wǎngluò.',
      example_vi = 'Trong xã hội hiện đại, công việc, học tập và đời sống thường nhật của mọi người đều đã không thể tách rời mạng internet.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '网络',
      'wǎngluò',
      'mạng lưới, mạng internet, viễn thông',
      'Danh từ',
      'HSK 5',
      '现代社会中，人们的工作、学习与日常生活都已离不开互联网络。',
      'Xiàndài shèhuì zhōng, rénmen de gōngzuò, xuéxí yǔ rìcháng shēnghuó dōu yǐ lí bù kāi hùlián wǎngluò.',
      'Trong xã hội hiện đại, công việc, học tập và đời sống thường nhật của mọi người đều đã không thể tách rời mạng internet.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现代社会中，人们的工作、学习与日常生活都已离不开互联网络。', 'Xiàndài shèhuì zhōng, rénmen de gōngzuò, xuéxí yǔ rìcháng shēnghuó dōu yǐ lí bù kāi hùlián wǎngluò.', 'Trong xã hội hiện đại, công việc, học tập và đời sống thường nhật của mọi người đều đã không thể tách rời mạng internet.', 'basic', 1),
      (v_id, '电信运营商正全力加速推进千兆光纤网络与第六代移动通信技术的全域覆盖，为数字经济实体转型构筑坚实底座。', 'Diànxìn yùnyíngshāng zhèng quánlì jiāsù tuījìn qiānzhào guāngxiān wǎngluò yǔ dìliùdài yídòng tōngxìn jìshù de quányù fùgài, wèi shùzì jīngjì shítǐ zhuǎnxíng gòuzhù jiānshí dǐzuò.', 'Các nhà mạng viễn thông đang dốc toàn lực đẩy nhanh độ phủ toàn diện của mạng cáp quang gigabit và công nghệ thông tin di động thế hệ 6G, kiến tạo nền tảng vững chắc cho sự chuyển đổi của thực thể kinh tế số.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3180] [危害] (wēihài) - nguy hại, gây hại, làm tổn hại; tác hại [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '危害' AND pinyin = 'wēihài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '危害' AND pinyin = 'wēihài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '危害'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '危害'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'wēihài',
      meaning_vi = 'nguy hại, gây hại, làm tổn hại; tác hại',
      example_hanzi = '长期吸烟和过度酗酒会严重危害人体的呼吸道和心血管健康。',
      example_pinyin = 'Chángqī xīyān hé guòdù xùjiǔ huì yánzhòng wēihài réntǐ de hūxīdào hé xīnxuèguǎn jiànkāng.',
      example_vi = 'Hút thuốc lá lâu năm và lạm dụng rượu bia quá độ sẽ gây nguy hại nghiêm trọng đến đường hô hấp và sức khỏe tim mạch của cơ thể người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '危害',
      'wēihài',
      'nguy hại, gây hại, làm tổn hại; tác hại',
      'Động từ / Danh từ',
      'HSK 5',
      '长期吸烟和过度酗酒会严重危害人体的呼吸道和心血管健康。',
      'Chángqī xīyān hé guòdù xùjiǔ huì yánzhòng wēihài réntǐ de hūxīdào hé xīnxuèguǎn jiànkāng.',
      'Hút thuốc lá lâu năm và lạm dụng rượu bia quá độ sẽ gây nguy hại nghiêm trọng đến đường hô hấp và sức khỏe tim mạch của cơ thể người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长期吸烟和过度酗酒会严重危害人体的呼吸道和心血管健康。', 'Chángqī xīyān hé guòdù xùjiǔ huì yánzhòng wēihài réntǐ de hūxīdào hé xīnxuèguǎn jiànkāng.', 'Hút thuốc lá lâu năm và lạm dụng rượu bia quá độ sẽ gây nguy hại nghiêm trọng đến đường hô hấp và sức khỏe tim mạch của cơ thể người.', 'basic', 1),
      (v_id, '工业废气未经环保脱硫脱硝处理直接违规排放，对流域生态平衡与周边居民公共卫生安全构成了不可逆转的严重危害。', 'Gōngyè fèiqì wèijīng huánbǎo tuōliú tuōxiāo chǔlǐ zhíjiē wéiguī páifàng, duì liùyù shēngtài pínghéng yǔ zhōubiān jūmín gōnggòng wèishēng ānquán gòuchéng le bùkě nìzhuǎn de yánzhòng wēihài.', 'Khí thải công nghiệp chưa qua xử lý khử lưu huỳnh khử nitơ bảo vệ môi trường mà xả trái phép trực tiếp đã tạo thành tác hại nguy hiểm khôn lường không thể đảo ngược đối với cân bằng sinh thái lưu vực và an toàn vệ sinh công cộng của cư dân xung quanh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3181] [微笑] (wēixiào) - mỉm cười, cười mỉm; nụ cười [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '微笑' AND pinyin = 'wēixiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '微笑' AND pinyin = 'wēixiào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '微笑'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '微笑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'wēixiào',
      meaning_vi = 'mỉm cười, cười mỉm; nụ cười',
      example_hanzi = '面对客户提出的咨询，前台接待人员始终保持着温和亲切的微笑。',
      example_pinyin = 'Miànduì kèhù tíchū de zīxún, qiántái jiēdài rényuán shǐzhōng bǎochí zhe wēnhé qīnqiè de wēixiào.',
      example_vi = 'Trước những thắc mắc tư vấn của khách hàng, nhân viên tiếp tân luôn giữ nụ cười dịu dàng và thân thiện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '微笑',
      'wēixiào',
      'mỉm cười, cười mỉm; nụ cười',
      'Động từ / Danh từ',
      'HSK 5',
      '面对客户提出的咨询，前台接待人员始终保持着温和亲切的微笑。',
      'Miànduì kèhù tíchū de zīxún, qiántái jiēdài rényuán shǐzhōng bǎochí zhe wēnhé qīnqiè de wēixiào.',
      'Trước những thắc mắc tư vấn của khách hàng, nhân viên tiếp tân luôn giữ nụ cười dịu dàng và thân thiện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对客户提出的咨询，前台接待人员始终保持着温和亲切的微笑。', 'Miànduì kèhù tíchū de zīxún, qiántái jiēdài rényuán shǐzhōng bǎochí zhe wēnhé qīnqiè de wēixiào.', 'Trước những thắc mắc tư vấn của khách hàng, nhân viên tiếp tân luôn giữ nụ cười dịu dàng và thân thiện.', 'basic', 1),
      (v_id, '在多边外交互动与高层商务谈判中，真诚从容的微笑不仅能有效消弭紧张对立气氛，更能彰显出开放包容的大国风范。', 'Zài duōbiān wàijiāo hùdòng yǔ gāocéng shāngwù tánpàn zhōng, zhēnchéng cóngróng de wēixiào bùjǐn néng yǒuxiào xiāomǐ jǐnzhāng duìlì qìfēn, gèng néng zhāngxiǎn chū kāifàng bāoróng de dàguó fēngfàn.', 'Trong tương tác ngoại giao đa phương và đàm phán thương mại cấp cao, nụ cười chân thành ung dung không chỉ xóa tan bầu không khí căng thẳng đối đầu một cách hiệu quả, mà còn thể hiện phong thái cởi mở bao dung của một nước lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3182] [威胁] (wēixié) - uy hiếp, đe dọa; mối đe dọa [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '威胁' AND pinyin = 'wēixié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '威胁' AND pinyin = 'wēixié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '威胁'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '威胁'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'wēixié',
      meaning_vi = 'uy hiếp, đe dọa; mối đe dọa',
      example_hanzi = '持续蔓延的森林山火直接威胁着山脚下数个自然村落居民的生命财产安全。',
      example_pinyin = 'Chíxù mànyán de sēnlín shānhuǒ zhíjiē wēixié zhe shānjiǎoxià shù gè zìrán cūnluò jūmín de shēngmìng cáichǎn ānquán.',
      example_vi = 'Trận cháy rừng tiếp tục lan rộng đe dọa trực tiếp đến an toàn tính mạng và tài sản của cư dân tại một số ngôi làng dưới chân núi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '威胁',
      'wēixié',
      'uy hiếp, đe dọa; mối đe dọa',
      'Động từ / Danh từ',
      'HSK 5',
      '持续蔓延的森林山火直接威胁着山脚下数个自然村落居民的生命财产安全。',
      'Chíxù mànyán de sēnlín shānhuǒ zhíjiē wēixié zhe shānjiǎoxià shù gè zìrán cūnluò jūmín de shēngmìng cáichǎn ānquán.',
      'Trận cháy rừng tiếp tục lan rộng đe dọa trực tiếp đến an toàn tính mạng và tài sản của cư dân tại một số ngôi làng dưới chân núi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '持续蔓延的森林山火直接威胁着山脚下数个自然村落居民的生命财产安全。', 'Chíxù mànyán de sēnlín shānhuǒ zhíjiē wēixié zhe shānjiǎoxià shù gè zìrán cūnluò jūmín de shēngmìng cáichǎn ānquán.', 'Trận cháy rừng tiếp tục lan rộng đe dọa trực tiếp đến an toàn tính mạng và tài sản của cư dân tại một số ngôi làng dưới chân núi.', 'basic', 1),
      (v_id, '高度隐蔽的分布式拒绝服务攻击与勒索软件病毒，正对全球核心金融基础设施与关键数据资产构成致命威胁。', 'Gāodù yǐnbì de fēnbùshì jùjué fúwù gōngjī yǔ lùosuǒ ruǎnjiàn bìngdú, zhèng duì quánqiú héxīn jīnróng jīchǔ shèshī yǔ guānjiàn shùjù zīchǎn gòuchéng zhìmìng wēixié.', 'Các cuộc tấn công từ chối dịch vụ phân tán DDoS có độ ẩn giấu cao và mã độc tống tiền đang tạo thành mối đe dọa chết người đối với hạ tầng tài chính cốt lõi và tài sản dữ liệu trọng yếu trên toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3183] [围] (wéi) - vây quanh, quây lại, quấn, quàng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '围' AND pinyin = 'wéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '围' AND pinyin = 'wéi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '围'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '围'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wéi',
      meaning_vi = 'vây quanh, quây lại, quấn, quàng',
      example_hanzi = '操场上的同学们兴奋地围成一个大圆圈，欢快地唱起节日祝贺歌曲。',
      example_pinyin = 'Cāochǎng shàng de tóngxuémen xīngfèn de wéi chéng yī gè dà yuánquān, huānkuài de chàng qǐ jiérì zhùhè gēqǔ.',
      example_vi = 'Các bạn học sinh trên sân thể dục phấn khởi quây thành một vòng tròn lớn, vui vẻ cất tiếng hát chúc mừng ngày lễ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '围',
      'wéi',
      'vây quanh, quây lại, quấn, quàng',
      'Động từ',
      'HSK 5',
      '操场上的同学们兴奋地围成一个大圆圈，欢快地唱起节日祝贺歌曲。',
      'Cāochǎng shàng de tóngxuémen xīngfèn de wéi chéng yī gè dà yuánquān, huānkuài de chàng qǐ jiérì zhùhè gēqǔ.',
      'Các bạn học sinh trên sân thể dục phấn khởi quây thành một vòng tròn lớn, vui vẻ cất tiếng hát chúc mừng ngày lễ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '操场上的同学们兴奋地围成一个大圆圈，欢快地唱起节日祝贺歌曲。', 'Cāochǎng shàng de tóngxuémen xīngfèn de wéi chéng yī gè dà yuánquān, huānkuài de chàng qǐ jiérì zhùhè gēqǔ.', 'Các bạn học sinh trên sân thể dục phấn khởi quây thành một vòng tròn lớn, vui vẻ cất tiếng hát chúc mừng ngày lễ.', 'basic', 1),
      (v_id, '施工单位在深基坑作业面四周严格设立全封闭隔离围挡与智能位移沉降监测传感器，确保周边建筑物绝对安全。', 'Shīgōng dānwèi zài shēnjīkēng zuòyèmiàn sìzhōu yángé shèlì quán-fēngbì gélí wéidǎng yǔ zhìnéng wèiyí chénjiàng jiāncè chuángǎnqì, quèbǎo zhōubiān jiànzhùwù juéduì ānquán.', 'Đơn vị thi công thiết lập nghiêm ngặt hàng rào bao quanh cách ly khép kín cùng cảm biến giám sát độ lún dịch chuyển thông minh xung quanh bề mặt hố móng sâu, bảo đảm các công trình kiến trúc xung quanh tuyệt đối an toàn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3184] [为] (wéi) - bởi, được, bị (kết cấu bị động trang trọng văn viết 为...所...) [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '为' AND pinyin = 'wéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '为' AND pinyin = 'wéi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '为'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '为'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Giới từ',
      pinyin = 'wéi',
      meaning_vi = 'bởi, được, bị (kết cấu bị động trang trọng văn viết 为...所...)',
      example_hanzi = '这位年轻学者严谨求实的学术治学精神深受同行学者与广大学生所赞赏。',
      example_pinyin = 'Zhè wèi niánqīng xuézhě yánjǐn qiúshí de xuéshù zhìxué jīngshén shēnshòu tóngháng xuézhě yǔ guǎngdà xuéshēng suǒ zànshǎng.',
      example_vi = 'Tinh thần nghiên cứu học thuật cẩn trọng thực tế của vị học giả trẻ này được các đồng nghiệp và đông đảo sinh viên hết sức khen ngợi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '为',
      'wéi',
      'bởi, được, bị (kết cấu bị động trang trọng văn viết 为...所...)',
      'Giới từ',
      'HSK 5',
      '这位年轻学者严谨求实的学术治学精神深受同行学者与广大学生所赞赏。',
      'Zhè wèi niánqīng xuézhě yánjǐn qiúshí de xuéshù zhìxué jīngshén shēnshòu tóngháng xuézhě yǔ guǎngdà xuéshēng suǒ zànshǎng.',
      'Tinh thần nghiên cứu học thuật cẩn trọng thực tế của vị học giả trẻ này được các đồng nghiệp và đông đảo sinh viên hết sức khen ngợi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位年轻学者严谨求实的学术治学精神深受同行学者与广大学生所赞赏。', 'Zhè wèi niánqīng xuézhě yánjǐn qiúshí de xuéshù zhìxué jīngshén shēnshòu tóngháng xuézhě yǔ guǎngdà xuéshēng suǒ zànshǎng.', 'Tinh thần nghiên cứu học thuật cẩn trọng thực tế của vị học giả trẻ này được các đồng nghiệp và đông đảo sinh viên hết sức khen ngợi.', 'basic', 1),
      (v_id, '该项突破性的人工智能开源算法一经全球公开发布，即为国际主流科学界与工业顶级期刊所广泛引用与高度评价。', 'Gāi xiàng tūpòxìng de réngōng zhìnéng kāiyuán suànfǎ yījīng quánqiú gōngkāi fābù, jí wéi guójì zhǔliú kēxuéjiè yǔ gōngyè dǐngjí qīkān suǒ guǎngfàn yǐnyòng yǔ gāodù píngjià.', 'Thuật toán mã nguồn mở trí tuệ nhân tạo mang tính đột phá này vừa được công bố rộng rãi trên toàn cầu, liền được giới khoa học chính thống quốc tế và các tạp chí kỹ thuật công nghiệp hàng đầu trích dẫn rộng rãi và đánh giá rất cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3185] [维持] (wéichí) - duy trì, gìn giữ, giữ vững trạng thái [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '维持' AND pinyin = 'wéichí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '维持' AND pinyin = 'wéichí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '维持'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '维持'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wéichí',
      meaning_vi = 'duy trì, gìn giữ, giữ vững trạng thái',
      example_hanzi = '交通警察在繁忙的十字路口指挥车流，全力维持早高峰期间的道路畅通。',
      example_pinyin = 'Jiāotōng jǐngchá zài fánmáng de shízì lùkǒu zhǐhuī chēliú, quánlì wéichí zǎogāofēng qījiān de dàolù chàngtōng.',
      example_vi = 'Cảnh sát giao thông phân luồng phương tiện tại ngã tư đông đúc, dốc sức duy trì sự thông suốt của đường sá trong giờ cao điểm buổi sáng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '维持',
      'wéichí',
      'duy trì, gìn giữ, giữ vững trạng thái',
      'Động từ',
      'HSK 5',
      '交通警察在繁忙的十字路口指挥车流，全力维持早高峰期间的道路畅通。',
      'Jiāotōng jǐngchá zài fánmáng de shízì lùkǒu zhǐhuī chēliú, quánlì wéichí zǎogāofēng qījiān de dàolù chàngtōng.',
      'Cảnh sát giao thông phân luồng phương tiện tại ngã tư đông đúc, dốc sức duy trì sự thông suốt của đường sá trong giờ cao điểm buổi sáng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '交通警察在繁忙的十字路口指挥车流，全力维持早高峰期间的道路畅通。', 'Jiāotōng jǐngchá zài fánmáng de shízì lùkǒu zhǐhuī chēliú, quánlì wéichí zǎogāofēng qījiān de dàolù chàngtōng.', 'Cảnh sát giao thông phân luồng phương tiện tại ngã tư đông đúc, dốc sức duy trì sự thông suốt của đường sá trong giờ cao điểm buổi sáng.', 'basic', 1),
      (v_id, '中央银行综合运用公开市场操作与逆回购工具，全力维持银行体系流动性合理充裕与本币汇率基本稳定。', 'Zhōngyāng yínháng zōnghé yùnyòng gōngkāi shìchǎng cāozuò yǔ nì-huígòu gōngjù, quánlì wéichí yínháng tǐxì liúdòngxìng hélǐ chōngyù yǔ běnbì huìlǜ jīběn wěndìng.', 'Ngân hàng Trung ương vận dụng tổng hợp các nghiệp vụ thị trường mở và công cụ repo đảo ngược, dốc toàn lực duy trì tính thanh khoản dồi dào hợp lý của hệ thống ngân hàng và tỷ giá đồng nội tệ cơ bản ổn định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3186] [违法] (wéifǎ) - phạm pháp, vi phạm pháp luật [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '违法' AND pinyin = 'wéifǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '违法' AND pinyin = 'wéifǎ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '违法'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '违法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wéifǎ',
      meaning_vi = 'phạm pháp, vi phạm pháp luật',
      example_hanzi = '在法律面前人人平等，实施酒后驾驶机动车属于严重违法的行为。',
      example_pinyin = 'Zài fǎlǜ miànqián rénrén píngděng, shíshī jiǔhòu jiàshǐ jīdòngchē shǔyú yánzhòng wéifǎ de xíngwéi.',
      example_vi = 'Mọi người đều bình đẳng trước pháp luật, hành vi điều khiển phương tiện cơ giới sau khi uống rượu bia thuộc về hành vi phạm pháp nghiêm trọng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '违法',
      'wéifǎ',
      'phạm pháp, vi phạm pháp luật',
      'Động từ',
      'HSK 5',
      '在法律面前人人平等，实施酒后驾驶机动车属于严重违法的行为。',
      'Zài fǎlǜ miànqián rénrén píngděng, shíshī jiǔhòu jiàshǐ jīdòngchē shǔyú yánzhòng wéifǎ de xíngwéi.',
      'Mọi người đều bình đẳng trước pháp luật, hành vi điều khiển phương tiện cơ giới sau khi uống rượu bia thuộc về hành vi phạm pháp nghiêm trọng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在法律面前人人平等，实施酒后驾驶机动车属于严重违法的行为。', 'Zài fǎlǜ miànqián rénrén píngděng, shíshī jiǔhòu jiàshǐ jīdòngchē shǔyú yánzhòng wéifǎ de xíngwéi.', 'Mọi người đều bình đẳng trước pháp luật, hành vi điều khiển phương tiện cơ giới sau khi uống rượu bia thuộc về hành vi phạm pháp nghiêm trọng.', 'basic', 1),
      (v_id, '市场监督管理稽查部门严厉打击虚假商业宣传与侵犯知识产权等违法行为，坚决捍卫公平公正的营商法治秩序。', 'Shìchǎng jiāndū guǎnlǐ jīchá bùmén yánlì dǎjī xūjiǎ shāngyè xuānchuán yǔ qīnfàn zhīshi chǎnquán děng wéifǎ xíngwéi, jiānjué hànwèi gōngpíng gōngzhèng de yíngshāng fǎzhì zhìxù.', 'Cơ quan thanh tra quản lý giám sát thị trường kiên quyết trấn áp các hành vi phạm pháp như quảng cáo thương mại sai sự thật và xâm phạm quyền sở hữu trí tuệ, giữ vững trật tự pháp quyền kinh doanh công bằng, chính trực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3187] [违反] (wéifǎn) - vi phạm, làm trái, trái với (nội quy, quy định, hợp đồng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '违反' AND pinyin = 'wéifǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '违反' AND pinyin = 'wéifǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '违反'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '违反'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wéifǎn',
      meaning_vi = 'vi phạm, làm trái, trái với (nội quy, quy định, hợp đồng)',
      example_hanzi = '员工如果无故旷工或擅自向外泄露内部商业机密，都属于严重违反公司劳动纪律。',
      example_pinyin = 'Yuángōng rúguǒ wúgù kuànggōng huò shànzì xiàng wài xièlù nèibù shāngyè jīmì, dōu shǔyú yánzhòng wéifǎn gōngsī láodòng jìlǜ.',
      example_vi = 'Nhân viên nếu tự ý nghỉ việc không lý do hoặc tùy tiện tiết lộ bí mật kinh doanh nội bộ ra ngoài đều thuộc về vi phạm nghiêm trọng kỷ luật lao động của công ty.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '违反',
      'wéifǎn',
      'vi phạm, làm trái, trái với (nội quy, quy định, hợp đồng)',
      'Động từ',
      'HSK 5',
      '员工如果无故旷工或擅自向外泄露内部商业机密，都属于严重违反公司劳动纪律。',
      'Yuángōng rúguǒ wúgù kuànggōng huò shànzì xiàng wài xièlù nèibù shāngyè jīmì, dōu shǔyú yánzhòng wéifǎn gōngsī láodòng jìlǜ.',
      'Nhân viên nếu tự ý nghỉ việc không lý do hoặc tùy tiện tiết lộ bí mật kinh doanh nội bộ ra ngoài đều thuộc về vi phạm nghiêm trọng kỷ luật lao động của công ty.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '员工如果无故旷工或擅自向外泄露内部商业机密，都属于严重违反公司劳动纪律。', 'Yuángōng rúguǒ wúgù kuànggōng huò shànzì xiàng wài xièlù nèibù shāngyè jīmì, dōu shǔyú yánzhòng wéifǎn gōngsī láodòng jìlǜ.', 'Nhân viên nếu tự ý nghỉ việc không lý do hoặc tùy tiện tiết lộ bí mật kinh doanh nội bộ ra ngoài đều thuộc về vi phạm nghiêm trọng kỷ luật lao động của công ty.', 'basic', 1),
      (v_id, '该跨国并购方案因严重违反反垄断法中的经营者集中反审查申报条款，被反垄断监管总局依法责令停止实施并课以巨额罚款。', 'Gāi kuàguó bìnggòu fāng’àn yīn yánzhòng wéifǎn fǎnlǒngduàn fǎ zhōng de jīngyíngzhě jízhōng fǎn-shěnchá shēnbào tiáokuǎn, bèi fǎnlǒngduàn jiānguǎn zǒngjú yīfǎ zélìng tíngzhǐ shíshī bìng kè yǐ jù’é fákuǎn.', 'Phương án sáp nhập mua lại xuyên quốc gia này do vi phạm nghiêm trọng các điều khoản khai báo thẩm tra tập trung kinh tế trong Luật Chống độc quyền, đã bị Tổng cục giám sát chống độc quyền ra lệnh đình chỉ thực hiện theo luật định và áp mức phạt tiền khổng lồ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3188] [围巾] (wéijīn) - khăn quàng cổ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '围巾' AND pinyin = 'wéijīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '围巾' AND pinyin = 'wéijīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '围巾'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '围巾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wéijīn',
      meaning_vi = 'khăn quàng cổ',
      example_hanzi = '冬天的清晨寒风呼啸，出门前记得围上一条柔软厚实的羊毛围巾。',
      example_pinyin = 'Dōngtiān de qīngchén hánfēng hūxiào, chūmén qián jìde wéi shàng yī tiáo róuruǎn hòushí de yángmáo wéijīn.',
      example_vi = 'Sáng mùa đông gió lạnh rít từng cơn, trước khi ra ngoài nhớ quàng một chiếc khăn len mềm mại ấm áp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '围巾',
      'wéijīn',
      'khăn quàng cổ',
      'Danh từ',
      'HSK 5',
      '冬天的清晨寒风呼啸，出门前记得围上一条柔软厚实的羊毛围巾。',
      'Dōngtiān de qīngchén hánfēng hūxiào, chūmén qián jìde wéi shàng yī tiáo róuruǎn hòushí de yángmáo wéijīn.',
      'Sáng mùa đông gió lạnh rít từng cơn, trước khi ra ngoài nhớ quàng một chiếc khăn len mềm mại ấm áp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '冬天的清晨寒风呼啸，出门前记得围上一条柔软厚实的羊毛围巾。', 'Dōngtiān de qīngchén hánfēng hūxiào, chūmén qián jìde wéi shàng yī tiáo róuruǎn hòushí de yángmáo wéijīn.', 'Sáng mùa đông gió lạnh rít từng cơn, trước khi ra ngoài nhớ quàng một chiếc khăn len mềm mại ấm áp.', 'basic', 1),
      (v_id, '展厅橱窗内陈列着融合非遗苏绣技艺的高级真丝羊绒围巾，精湛雅致的手工针法吸引了众多海外客商驻足洽谈订购。', 'Zhǎntīng chúchuāng nèi chénliè zhe rónghé fēiyí Sūxiù jìyì de gāojí zhēnsī yángróng wéijīn, jīngzhàn yǎzhì de shǒugōng zhēnfǎ xīyǐn le zhòngduō hǎiwài kèshāng zhùzú qiàtán dìnggòu.', 'Tủ kính phòng trưng bày bày biện những chiếc khăn quàng cổ cashmere tơ tằm cao cấp kết hợp kỹ nghệ thêu Tô Châu di sản phi vật thể, đường kim mũi chỉ thủ công tinh xảo trang nhã đã thu hút đông đảo thương nhân nước ngoài dừng chân đàm phán đặt mua.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3189] [围绕] (wéirào) - xoay quanh, tập trung quanh (trọng tâm, đề tài) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '围绕' AND pinyin = 'wéirào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '围绕' AND pinyin = 'wéirào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '围绕'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '围绕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wéirào',
      meaning_vi = 'xoay quanh, tập trung quanh (trọng tâm, đề tài)',
      example_hanzi = '全体参会教师围绕如何有效提升课堂教学质量展开了热烈的讨论。',
      example_pinyin = 'Quántǐ cānhuì jiàoshī wéirào rúhé yǒuxiào tíshēng kètáng jiàoxué zhìliàng zhǎnkāi le rèliè de tǎolùn.',
      example_vi = 'Toàn thể giáo viên tham dự cuộc họp đã xoay quanh việc làm thế nào để nâng cao chất lượng giảng dạy trên lớp một cách hiệu quả để thảo luận sôi nổi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '围绕',
      'wéirào',
      'xoay quanh, tập trung quanh (trọng tâm, đề tài)',
      'Động từ',
      'HSK 5',
      '全体参会教师围绕如何有效提升课堂教学质量展开了热烈的讨论。',
      'Quántǐ cānhuì jiàoshī wéirào rúhé yǒuxiào tíshēng kètáng jiàoxué zhìliàng zhǎnkāi le rèliè de tǎolùn.',
      'Toàn thể giáo viên tham dự cuộc họp đã xoay quanh việc làm thế nào để nâng cao chất lượng giảng dạy trên lớp một cách hiệu quả để thảo luận sôi nổi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '全体参会教师围绕如何有效提升课堂教学质量展开了热烈的讨论。', 'Quántǐ cānhuì jiàoshī wéirào rúhé yǒuxiào tíshēng kètáng jiàoxué zhìliàng zhǎnkāi le rèliè de tǎolùn.', 'Toàn thể giáo viên tham dự cuộc họp đã xoay quanh việc làm thế nào để nâng cao chất lượng giảng dạy trên lớp một cách hiệu quả để thảo luận sôi nổi.', 'basic', 1),
      (v_id, '全球数字经济峰会紧紧围绕“通用人工智能治理框架与跨境数据要素安全合规流动”核心议题，达成了广泛共识。', 'Quánqiú shùzì jīngjì fēnghuì jǐnjǐn wéirào “tōngyòng réngōng zhìnéng zhìlǐ kuàngjià yǔ kuàjìng shùjù yàosù ānquán hégūi liúdòng” héxīn yìtí, dáchéng le guǎngfàn gòngshí.', 'Hội nghị thượng đỉnh kinh tế số toàn cầu bám sát xoay quanh chủ đề cốt lõi "Khung quản trị trí tuệ nhân tạo tạo sinh đa năng và luân chuyển dòng dữ liệu xuyên biên giới an toàn hợp chuẩn", đạt được sự đồng thuận rộng rãi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3190] [维修] (wéixiū) - bảo dưỡng sửa chữa, duy tu, bảo trì; việc tu sửa [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '维修' AND pinyin = 'wéixiū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '维修' AND pinyin = 'wéixiū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '维修'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '维修'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'wéixiū',
      meaning_vi = 'bảo dưỡng sửa chữa, duy tu, bảo trì; việc tu sửa',
      example_hanzi = '这台笔记本电脑的主板出现了故障，需要送往官方售后中心进行专业维修。',
      example_pinyin = 'Zhè tái bǐjìběn diànnǎo de zhǔbǎn chūxiàn le gùzhàng, xūyào sòng wǎng guānfāng shòuhòu zhōngxīn jìnxíng zhuānyè wéixiū.',
      example_vi = 'Bo mạch chủ của chiếc máy tính xách tay này bị sự cố hỏng hóc, cần phải gửi tới trung tâm dịch vụ khách hàng chính hãng để sửa chữa chuyên nghiệp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '维修',
      'wéixiū',
      'bảo dưỡng sửa chữa, duy tu, bảo trì; việc tu sửa',
      'Động từ / Danh từ',
      'HSK 5',
      '这台笔记本电脑的主板出现了故障，需要送往官方售后中心进行专业维修。',
      'Zhè tái bǐjìběn diànnǎo de zhǔbǎn chūxiàn le gùzhàng, xūyào sòng wǎng guānfāng shòuhòu zhōngxīn jìnxíng zhuānyè wéixiū.',
      'Bo mạch chủ của chiếc máy tính xách tay này bị sự cố hỏng hóc, cần phải gửi tới trung tâm dịch vụ khách hàng chính hãng để sửa chữa chuyên nghiệp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这台笔记本电脑的主板出现了故障，需要送往官方售后中心进行专业维修。', 'Zhè tái bǐjìběn diànnǎo de zhǔbǎn chūxiàn le gùzhàng, xūyào sòng wǎng guānfāng shòuhòu zhōngxīn jìnxíng zhuānyè wéixiū.', 'Bo mạch chủ của chiếc máy tính xách tay này bị sự cố hỏng hóc, cần phải gửi tới trung tâm dịch vụ khách hàng chính hãng để sửa chữa chuyên nghiệp.', 'basic', 1),
      (v_id, '铁路工务段利用列车停运的夜间“天窗期”，对高速铁路线路道岔与电气化接触网设备开展精细化预防性维修检修。', 'Tiělù gōngwùduàn lìyòng lièchē tíngyùn de yèjiān “tiānchuāngqī”, duì gāosù tiělù xiànlù dàochà yǔ diànqìhuà jiēchùwǎng shèbèi kāizhǎn jīngxìhuà yùfángxìng wéixiū jiǎnxiū.', 'Đoạn công vụ đường sắt tận dụng "khung giờ vàng" ngừng tàu ban đêm để triển khai công tác kiểm tra duy tu bảo dưỡng phòng ngừa tinh gọn đối với các ghi đường ray và thiết bị đường dây tiếp xúc điện khí hóa của tuyến đường sắt cao tốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3191] [唯一] (wéiyī) - duy nhất, độc nhất [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '唯一' AND pinyin = 'wéiyī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '唯一' AND pinyin = 'wéiyī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '唯一'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '唯一'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'wéiyī',
      meaning_vi = 'duy nhất, độc nhất',
      example_hanzi = '在激烈的跨国岗位选拔竞争中，他是唯一获得全额公派进修资格的青年工程师。',
      example_pinyin = 'Zài jīliè de kuàguó gǎngwèi xuǎnbá jìngzhēng zhōng, tā shì wéiyī huòdé quán’é gōngpài jìnxiū zīgé de qīngnián gōngchéngshī.',
      example_vi = 'Trong cuộc cạnh tranh tuyển chọn vị trí xuyên quốc gia khốc liệt, anh ấy là kỹ sư trẻ duy nhất giành được suất cử đi tu nghiệp toàn phần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '唯一',
      'wéiyī',
      'duy nhất, độc nhất',
      'Tính từ',
      'HSK 5',
      '在激烈的跨国岗位选拔竞争中，他是唯一获得全额公派进修资格的青年工程师。',
      'Zài jīliè de kuàguó gǎngwèi xuǎnbá jìngzhēng zhōng, tā shì wéiyī huòdé quán’é gōngpài jìnxiū zīgé de qīngnián gōngchéngshī.',
      'Trong cuộc cạnh tranh tuyển chọn vị trí xuyên quốc gia khốc liệt, anh ấy là kỹ sư trẻ duy nhất giành được suất cử đi tu nghiệp toàn phần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在激烈的跨国岗位选拔竞争中，他是唯一获得全额公派进修资格的青年工程师。', 'Zài jīliè de kuàguó gǎngwèi xuǎnbá jìngzhēng zhōng, tā shì wéiyī huòdé quán’é gōngpài jìnxiū zīgé de qīngnián gōngchéngshī.', 'Trong cuộc cạnh tranh tuyển chọn vị trí xuyên quốc gia khốc liệt, anh ấy là kỹ sư trẻ duy nhất giành được suất cử đi tu nghiệp toàn phần.', 'basic', 1),
      (v_id, '突破底层关键核心技术壁垒并构建自主可控供应链，是高新技术实体企业在全球竞争格局重构浪潮中赢得主动的唯一途径。', 'Tūpò dǐcéng guānjiàn héxīn jìshù bìlěi bìng gòujiàn zìzhǔ kěkòng gōngyìngliàn, shì gāoxīnjìshù shítǐ qǐyè zài quánqiú jìngzhēng géjú chónggòu làngcháo zhōng yíngdé zhǔdòng de wéiyī tújìng.', 'Đột phá rào cản công nghệ cốt lõi then chốt tầng đáy và kiến tạo chuỗi cung ứng tự chủ kiểm soát được chính là con đường duy nhất để các doanh nghiệp thực thể công nghệ cao giành thế chủ động trong làn sóng tái cơ cấu cục diện cạnh tranh toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3192] [尾巴] (wěiba) - cái đuôi, phần đuôi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '尾巴' AND pinyin = 'wěiba'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尾巴' AND pinyin = 'wěiba'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '尾巴'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尾巴'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wěiba',
      meaning_vi = 'cái đuôi, phần đuôi',
      example_hanzi = '小狗看到主人下班回家，立刻欢快地摇晃着尾巴跑上前去迎接。',
      example_pinyin = 'Xiǎogǒu kàndào zhǔrén xiàbān huíjiā, lìkè huānkuài de yáohuàng zhe wěiba pǎo shàng qián qù yíngjiē.',
      example_vi = 'Chú cún nhỏ nhìn thấy chủ đi làm về liền vui mừng vẫy đuôi chạy tới đón mừng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '尾巴',
      'wěiba',
      'cái đuôi, phần đuôi',
      'Danh từ',
      'HSK 5',
      '小狗看到主人下班回家，立刻欢快地摇晃着尾巴跑上前去迎接。',
      'Xiǎogǒu kàndào zhǔrén xiàbān huíjiā, lìkè huānkuài de yáohuàng zhe wěiba pǎo shàng qián qù yíngjiē.',
      'Chú cún nhỏ nhìn thấy chủ đi làm về liền vui mừng vẫy đuôi chạy tới đón mừng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小狗看到主人下班回家，立刻欢快地摇晃着尾巴跑上前去迎接。', 'Xiǎogǒu kàndào zhǔrén xiàbān huíjiā, lìkè huānkuài de yáohuàng zhe wěiba pǎo shàng qián qù yíngjiē.', 'Chú cún nhỏ nhìn thấy chủ đi làm về liền vui mừng vẫy đuôi chạy tới đón mừng.', 'basic', 1),
      (v_id, '在野外生态考察中，红外感应相机清晰记录下了雪豹利用粗长蓬松的尾巴在陡峭岩壁边缘精准调节身体奔跑平衡的珍贵影像。', 'Zài yěwài shēngtài kǎochá zhōng, hóngwài gǎnyìng xiàngjī qīngxī jìlù xià le xuěbào lìyòng cū cháng péngsōng de wěiba zài dǒuqiào yánbì biānyuán jīngzhǔn tiáojié shēntǐ bēnpǎo pínghéng de zhēnguì yǐngxiàng.', 'Trong đợt khảo sát sinh thái dã ngoại, máy ảnh cảm ứng hồng ngoại đã ghi lại rõ nét thước phim quý giá về việc báo tuyết sử dụng chiếc đuôi to dài bông xù để điều chỉnh thăng bằng cơ thể một cách chuẩn xác khi chạy nhảy bên mép vách đá dựng đứng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3193] [伟大] (wěidà) - vĩ đại, to lớn, phi thường [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '伟大' AND pinyin = 'wěidà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伟大' AND pinyin = 'wěidà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '伟大'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伟大'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'wěidà',
      meaning_vi = 'vĩ đại, to lớn, phi thường',
      example_hanzi = '母亲为了子女的健康成长倾注了毕生心血，母爱是世间最无私而伟大的力量。',
      example_pinyin = 'Mǔqīn wèile zǐnǚ de jiànkāng chéngzhǎng qīngzhù le bìshēng xīnxuè, mǔ’ài shì shìjiān zuì wúsī ér wěidà de lìliàng.',
      example_vi = 'Người mẹ vì sự trưởng thành khỏe mạnh của con cái đã dốc trọn tâm huyết cả đời, tình mẹ là nguồn sức mạnh vị tha và vĩ đại nhất trần đời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '伟大',
      'wěidà',
      'vĩ đại, to lớn, phi thường',
      'Tính từ',
      'HSK 5',
      '母亲为了子女的健康成长倾注了毕生心血，母爱是世间最无私而伟大的力量。',
      'Mǔqīn wèile zǐnǚ de jiànkāng chéngzhǎng qīngzhù le bìshēng xīnxuè, mǔ’ài shì shìjiān zuì wúsī ér wěidà de lìliàng.',
      'Người mẹ vì sự trưởng thành khỏe mạnh của con cái đã dốc trọn tâm huyết cả đời, tình mẹ là nguồn sức mạnh vị tha và vĩ đại nhất trần đời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '母亲为了子女的健康成长倾注了毕生心血，母爱是世间最无私而伟大的力量。', 'Mǔqīn wèile zǐnǚ de jiànkāng chéngzhǎng qīngzhù le bìshēng xīnxuè, mǔ’ài shì shìjiān zuì wúsī ér wěidà de lìliàng.', 'Người mẹ vì sự trưởng thành khỏe mạnh của con cái đã dốc trọn tâm huyết cả đời, tình mẹ là nguồn sức mạnh vị tha và vĩ đại nhất trần đời.', 'basic', 1),
      (v_id, '数代航天科研人员历经半个多世纪的自力更生与自主创新，成功建成国家载人空间站，谱写了人类探索浩瀚太空的伟大篇章。', 'Shù dài hángtiān kēyán rényuán lìjīng bàn gè duō shìjì de zìlì-gèngshēng yǔ zìzhǔ chuàngxīn, chénggōng jiànchéng guójiā zàirén kōngjiānzhàn, pǔxiě le rénlèi tànsuǒ hàohàn tàikōng de wěidà piānzhāng.', 'Nhiều thế hệ cán bộ nghiên cứu khoa học vũ trụ trải qua hơn nửa thế kỷ tự lực cánh sinh và tự chủ đổi mới sáng tạo, đã xây dựng thành công trạm vũ trụ có người lái cấp quốc gia, viết nên trang sử vĩ đại trong công cuộc thám hiểm không gian vũ trụ bao la của loài người.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3194] [胃] (wèi) - dạ dày, bao tử [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '胃' AND pinyin = 'wèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胃' AND pinyin = 'wèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '胃'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胃'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wèi',
      meaning_vi = 'dạ dày, bao tử',
      example_hanzi = '长期的饮食作息不规律和过度暴饮暴食，很容易引发胃炎与胃黏膜受损。',
      example_pinyin = 'Chángqī de yǐnshí zuòxī bù guīlǜ hé guòdù bàoyǐn-bàoshí, hěn róngyì yǐnfā wèiyán yǔ wèiniánmó shòusǔn.',
      example_vi = 'Chế độ ăn uống sinh hoạt thất thường lâu ngày cùng thói quen ăn uống vô độ quá mức rất dễ gây ra viêm dạ dày và tổn thương niêm mạc bao tử.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '胃',
      'wèi',
      'dạ dày, bao tử',
      'Danh từ',
      'HSK 5',
      '长期的饮食作息不规律和过度暴饮暴食，很容易引发胃炎与胃黏膜受损。',
      'Chángqī de yǐnshí zuòxī bù guīlǜ hé guòdù bàoyǐn-bàoshí, hěn róngyì yǐnfā wèiyán yǔ wèiniánmó shòusǔn.',
      'Chế độ ăn uống sinh hoạt thất thường lâu ngày cùng thói quen ăn uống vô độ quá mức rất dễ gây ra viêm dạ dày và tổn thương niêm mạc bao tử.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长期的饮食作息不规律和过度暴饮暴食，很容易引发胃炎与胃黏膜受损。', 'Chángqī de yǐnshí zuòxī bù guīlǜ hé guòdù bàoyǐn-bàoshí, hěn róngyì yǐnfā wèiyán yǔ wèiniánmó shòusǔn.', 'Chế độ ăn uống sinh hoạt thất thường lâu ngày cùng thói quen ăn uống vô độ quá mức rất dễ gây ra viêm dạ dày và tổn thương niêm mạc bao tử.', 'basic', 1),
      (v_id, '现代高清无痛电子胃镜与靶向窄带成像技术的推广，显著提高了早期微小胃部恶性肿瘤病灶的筛查确诊率。', 'Xiàndài gāoqīng wútòng diànzǐ wèijìng yǔ bǎxiàng zhǎidài chéngxiàng jìshù de tuīguǎng, xiǎnzhù tígāo le zǎoqī wēixiǎo wèibù èxìng zhǒngliú bìngzào de shāichá quèzhěn lǜ.', 'Việc phổ biến công nghệ nội soi dạ dày điện tử không đau độ nét cao cùng kỹ thuật chụp quang học dải hẹp khu trú đã nâng cao rõ rệt tỷ lệ sàng lọc chẩn đoán chính xác các ổ tổn thương khối u ác tính li ti giai đoạn đầu ở dạ dày.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3195] [喂] (wèi) - cho ăn, bón, đút ăn, nuôi dưỡng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '喂' AND pinyin = 'wèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '喂' AND pinyin = 'wèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '喂'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '喂'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wèi',
      meaning_vi = 'cho ăn, bón, đút ăn, nuôi dưỡng',
      example_hanzi = '护士坐在病床旁边，极其耐心地用小勺给术后不能自理的患者喂流质温热稀粥。',
      example_pinyin = 'Hùshi zuò zài bìngchuáng pángbiān, jíqí nàixīn de yòng xiǎosháo gěi shùhòu bùnéng zìlǐ de huànzhě wèi liúzhì wēnrè xīzhōu.',
      example_vi = 'Y tá ngồi bên cạnh giường bệnh, vô cùng kiên nhẫn dùng chiếc thìa nhỏ đút từng muỗng cháo loãng ấm nóng cho người bệnh sau phẫu thuật chưa thể tự chăm sóc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '喂',
      'wèi',
      'cho ăn, bón, đút ăn, nuôi dưỡng',
      'Động từ',
      'HSK 5',
      '护士坐在病床旁边，极其耐心地用小勺给术后不能自理的患者喂流质温热稀粥。',
      'Hùshi zuò zài bìngchuáng pángbiān, jíqí nàixīn de yòng xiǎosháo gěi shùhòu bùnéng zìlǐ de huànzhě wèi liúzhì wēnrè xīzhōu.',
      'Y tá ngồi bên cạnh giường bệnh, vô cùng kiên nhẫn dùng chiếc thìa nhỏ đút từng muỗng cháo loãng ấm nóng cho người bệnh sau phẫu thuật chưa thể tự chăm sóc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '护士坐在病床旁边，极其耐心地用小勺给术后不能自理的患者喂流质温热稀粥。', 'Hùshi zuò zài bìngchuáng pángbiān, jíqí nàixīn de yòng xiǎosháo gěi shùhòu bùnéng zìlǐ de huànzhě wèi liúzhì wēnrè xīzhōu.', 'Y tá ngồi bên cạnh giường bệnh, vô cùng kiên nhẫn dùng chiếc thìa nhỏ đút từng muỗng cháo loãng ấm nóng cho người bệnh sau phẫu thuật chưa thể tự chăm sóc.', 'basic', 1),
      (v_id, '数字化现代智慧牧场采用智能传感器精准监测奶牛采食数据，并由全自动无人饲喂系统按需精准调配投喂全混合营养日粮。', 'Shùzìhuà xiàndài zhìhuì mùchǎng cǎiyòng zhìnéng chuángǎnqì jīngzhǔn jiāncè nǎiniú cǎishí shùjù, bìng yóu quán-zìdòng wúrén sìwèi xìtǒng ànxū jīngzhǔn tiáopèi tóuwèi quán-hùnhé yíngyǎng rìliáng.', 'Nông trại thông minh hiện đại số hóa áp dụng cảm biến thông minh để giám sát chính xác dữ liệu hấp thu thức ăn của bò sữa, và được hệ thống phân phối thức ăn tự động không người lái điều phối định lượng và cho ăn khẩu phần dinh dưỡng hỗn hợp theo đúng nhu cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3196] [未来] (wèilái) - tương lai, sau này; mai sau [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '未来' AND pinyin = 'wèilái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '未来' AND pinyin = 'wèilái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '未来'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '未来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'wèilái',
      meaning_vi = 'tương lai, sau này; mai sau',
      example_hanzi = '青年人应当脚踏实地努力汲取知识，勇敢自信地迎接未来的各项机遇与挑战。',
      example_pinyin = 'Qīngniánrén yīngdāng jiǎotàshídì nǔlì jíqǔ zhīshi, yǒnggǎn zìxìn de yíngjiē wèilái de gè xiàng jīyù yǔ tiǎozhàn.',
      example_vi = 'Thanh niên nên nỗ lực tiếp thu kiến thức một cách thiết thực vững vàng, dũng cảm và tự tin đón nhận những cơ hội và thách thức trong tương lai.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '未来',
      'wèilái',
      'tương lai, sau này; mai sau',
      'Danh từ / Tính từ',
      'HSK 5',
      '青年人应当脚踏实地努力汲取知识，勇敢自信地迎接未来的各项机遇与挑战。',
      'Qīngniánrén yīngdāng jiǎotàshídì nǔlì jíqǔ zhīshi, yǒnggǎn zìxìn de yíngjiē wèilái de gè xiàng jīyù yǔ tiǎozhàn.',
      'Thanh niên nên nỗ lực tiếp thu kiến thức một cách thiết thực vững vàng, dũng cảm và tự tin đón nhận những cơ hội và thách thức trong tương lai.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青年人应当脚踏实地努力汲取知识，勇敢自信地迎接未来的各项机遇与挑战。', 'Qīngniánrén yīngdāng jiǎotàshídì nǔlì jíqǔ zhīshi, yǒnggǎn zìxìn de yíngjiē wèilái de gè xiàng jīyù yǔ tiǎozhàn.', 'Thanh niên nên nỗ lực tiếp thu kiến thức một cách thiết thực vững vàng, dũng cảm và tự tin đón nhận những cơ hội và thách thức trong tương lai.', 'basic', 1),
      (v_id, '超前战略布局量子计算、类脑智能与可控核聚变等未来产业新赛道，是抢占全球科技制高点并培育发展新质生产力的战略支点。', 'Chāoqián zhànlüè bùjú liàngzǐ jìsuàn, lèinǎo zhìnéng yǔ kěkòng héjùbiàn děng wèilái chǎnyè xīn sàidào, shì qiǎngzhàn quánqiú kējì zhìgāodiǎn bìng péiyù fāzhǎn xīnzhì shēngchǎnlì de zhànlüè zhīdiǎn.', 'Bố trí chiến lược đi trước đón đầu các đường đua ngành công nghiệp tương lai như tính toán lượng tử, trí tuệ nhân tạo mô phỏng não bộ và phản ứng nhiệt hạch có kiểm soát chính là điểm tựa chiến lược để chiếm lĩnh đỉnh cao công nghệ toàn cầu và nuôi dưỡng lực lượng sản xuất chất lượng mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3197] [位于] (wèiyú) - nằm ở, tọa lạc tại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '位于' AND pinyin = 'wèiyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '位于' AND pinyin = 'wèiyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '位于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '位于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wèiyú',
      meaning_vi = 'nằm ở, tọa lạc tại',
      example_hanzi = '这所百年历史名校位于风景秀丽的山脚下，校园内古树参天，环境幽雅宜人。',
      example_pinyin = 'Zhè suǒ bǎinián lìshǐ míngxiào wèiyú fēngjǐng xiùlì de shānjiǎoxià, xiàoyuán nèi gǔshù cāntiān, huánjìng yōuyǎ yírén.',
      example_vi = 'Ngôi trường danh tiếng trăm năm lịch sử này nằm ở chân núi phong cảnh tươi đẹp, bên trong khuôn viên cổ thụ rợp bóng trời, không gian trang nhã dễ chịu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '位于',
      'wèiyú',
      'nằm ở, tọa lạc tại',
      'Động từ',
      'HSK 5',
      '这所百年历史名校位于风景秀丽的山脚下，校园内古树参天，环境幽雅宜人。',
      'Zhè suǒ bǎinián lìshǐ míngxiào wèiyú fēngjǐng xiùlì de shānjiǎoxià, xiàoyuán nèi gǔshù cāntiān, huánjìng yōuyǎ yírén.',
      'Ngôi trường danh tiếng trăm năm lịch sử này nằm ở chân núi phong cảnh tươi đẹp, bên trong khuôn viên cổ thụ rợp bóng trời, không gian trang nhã dễ chịu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这所百年历史名校位于风景秀丽的山脚下，校园内古树参天，环境幽雅宜人。', 'Zhè suǒ bǎinián lìshǐ míngxiào wèiyú fēngjǐng xiùlì de shānjiǎoxià, xiàoyuán nèi gǔshù cāntiān, huánjìng yōuyǎ yírén.', 'Ngôi trường danh tiếng trăm năm lịch sử này nằm ở chân núi phong cảnh tươi đẹp, bên trong khuôn viên cổ thụ rợp bóng trời, không gian trang nhã dễ chịu.', 'basic', 1),
      (v_id, '位于粤港澳大湾区核心交通枢纽节点的综合保税港区，正依托高水平制度型对外开放加速融入国际国内双循环新发展格局。', 'Wèiyú Yuè-Gǎng-Ào Dàwānqū héxīn jiāotōng shūniǔ jiédiǎn de zōnghé bǎoshuì gǎngqū, zhèng yītuō gāoshuǐpíng zhìdùxíng duìwài kāifàng jiāsù róngrù guójì guónèi shuāngxúnhuán xīn fāzhǎn géjú.', 'Khu cảng mậu dịch bảo thuế tổng hợp tọa lạc tại điểm nút giao thông cốt lõi của Vùng vịnh lớn Quảng Đông - Hồng Kông - Ma Cao đang dựa vào sự mở cửa đối ngoại mang tính thể chế tiêu chuẩn cao để đẩy nhanh hòa nhập vào cục diện phát triển mới tuần hoàn kép trong nước và quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3198] [位置] (wèizhì) - vị trí, chỗ ngồi, địa vị, chỗ đứng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '位置' AND pinyin = 'wèizhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '位置' AND pinyin = 'wèizhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '位置'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '位置'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wèizhì',
      meaning_vi = 'vị trí, chỗ ngồi, địa vị, chỗ đứng',
      example_hanzi = '请大家进入会议室后先核对自己的名字，并在指定的座位位置上有序就座。',
      example_pinyin = 'Qǐng dàjiā jìnrù huìyìshì hòu xiān h किसानों héduì zìjǐ de míngzi, bìng zài zhǐdìng de zuòwèi wèizhì shàng yǒuxù jiùzuò.',
      example_vi = 'Xin mời mọi người sau khi vào phòng họp hãy kiểm tra tên mình trước và ngồi vào đúng vị trí chỗ ngồi đã quy định một cách trật tự.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '位置',
      'wèizhì',
      'vị trí, chỗ ngồi, địa vị, chỗ đứng',
      'Danh từ',
      'HSK 5',
      '请大家进入会议室后先核对自己的名字，并在指定的座位位置上有序就座。',
      'Qǐng dàjiā jìnrù huìyìshì hòu xiān h किसानों héduì zìjǐ de míngzi, bìng zài zhǐdìng de zuòwèi wèizhì shàng yǒuxù jiùzuò.',
      'Xin mời mọi người sau khi vào phòng họp hãy kiểm tra tên mình trước và ngồi vào đúng vị trí chỗ ngồi đã quy định một cách trật tự.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请大家进入会议室后先核对自己的名字，并在指定的座位位置上有序就座。', 'Qǐng dàjiā jìnrù huìyìshì hòu xiān h किसानों héduì zìjǐ de míngzi, bìng zài zhǐdìng de zuòwèi wèizhì shàng yǒuxù jiùzuò.', 'Xin mời mọi người sau khi vào phòng họp hãy kiểm tra tên mình trước và ngồi vào đúng vị trí chỗ ngồi đã quy định một cách trật tự.', 'basic', 1),
      (v_id, '在百年未有之大变局与全球产业链重构背景下，实体制造企业必须精准识变，找准并牢牢巩固自身在全球价值链分工中的关键枢纽位置。', 'Zài bǎinián wèiyǒu zhī dàbiànjú yǔ quánqiú chǎnyèliàn chónggòu bèijǐng xià, shítǐ zhìzào qǐyè bìxū jīngzhǔn shíbiàn, zhǎozhǔn bìng láoláo gǒnggù zìshēn zài quánqiú jiàzhíliàn fēngōng zhōng de guānjiàn shūniǔ wèizhì.', 'Dưới bối cảnh biến cục lớn trăm năm chưa từng có và sự tái cấu trúc chuỗi công nghiệp toàn cầu, các doanh nghiệp chế tạo thực thể bắt buộc phải nhận diện chuẩn xác thời cuộc, xác định đúng và củng cố vững chắc vị trí then chốt trọng yếu của mình trong phân công chuỗi giá trị toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3199] [温暖] (wēnnuǎn) - ấm áp, dịu dàng; sưởi ấm, làm ấm lòng [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '温暖' AND pinyin = 'wēnnuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '温暖' AND pinyin = 'wēnnuǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '温暖'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '温暖'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'wēnnuǎn',
      meaning_vi = 'ấm áp, dịu dàng; sưởi ấm, làm ấm lòng',
      example_hanzi = '在寒风刺骨的冬日里，妈妈端来的一碗热气腾腾的生姜红糖水让全身都感到无比温暖。',
      example_pinyin = 'Zài hánfēng cìgǔ de dōngrì lǐ, māmā duān lái de yī wǎn rèqì téngténg de shēngjiāng hóngtáng shuǐ ràng quánshēn dōu gǎndào wúbǐ wēnnuǎn.',
      example_vi = 'Trong ngày đông gió lạnh buốt xương, bát nước gừng đường đỏ bốc hơi nghi ngút mẹ mang tới khiến cả người cảm thấy ấm áp vô cùng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '温暖',
      'wēnnuǎn',
      'ấm áp, dịu dàng; sưởi ấm, làm ấm lòng',
      'Tính từ / Động từ',
      'HSK 5',
      '在寒风刺骨的冬日里，妈妈端来的一碗热气腾腾的生姜红糖水让全身都感到无比温暖。',
      'Zài hánfēng cìgǔ de dōngrì lǐ, māmā duān lái de yī wǎn rèqì téngténg de shēngjiāng hóngtáng shuǐ ràng quánshēn dōu gǎndào wúbǐ wēnnuǎn.',
      'Trong ngày đông gió lạnh buốt xương, bát nước gừng đường đỏ bốc hơi nghi ngút mẹ mang tới khiến cả người cảm thấy ấm áp vô cùng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在寒风刺骨的冬日里，妈妈端来的一碗热气腾腾的生姜红糖水让全身都感到无比温暖。', 'Zài hánfēng cìgǔ de dōngrì lǐ, māmā duān lái de yī wǎn rèqì téngténg de shēngjiāng hóngtáng shuǐ ràng quánshēn dōu gǎndào wúbǐ wēnnuǎn.', 'Trong ngày đông gió lạnh buốt xương, bát nước gừng đường đỏ bốc hơi nghi ngút mẹ mang tới khiến cả người cảm thấy ấm áp vô cùng.', 'basic', 1),
      (v_id, '社区志愿者为孤寡独居老人送去御寒棉衣与生活照料，以实打实的精细化关怀举措温暖了弱势群体的切身心田。', 'Shèqū zhìyuànzhě wèi gūguǎ dújū lǎorén sòng qù yùhán miányī yǔ shēnghuó zhàoliào, yǐ shídǎshí de jīngxìhuà guānhuái jǔcuò wēnnuǎn le ruòshì qúntǐ de qièshēn xīntián.', 'Các tình nguyện viên cộng đồng gửi tặng áo bông giữ ấm và chăm lo sinh hoạt cho các cụ già neo đơn, sưởi ấm cõi lòng những đối tượng yếu thế bằng các biện pháp chăm sóc tinh gọn, thiết thực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3200] [文学] (wénxué) - văn học, tác phẩm văn học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '文学' AND pinyin = 'wénxué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '文学' AND pinyin = 'wénxué'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '文学'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '文学'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wénxué',
      meaning_vi = 'văn học, tác phẩm văn học',
      example_hanzi = '他从小就在家庭的熏陶下对中国古代古典文学和现代散文表现出浓厚的学术兴趣。',
      example_pinyin = 'Tā cóngxiǎo jiù zài jiātíng de xūntáo xià duì Zhōngguó gǔdài gǔdiǎn wénxué hé xiàndài sǎnwén biǎoxiàn chū nónghòu de xuéshù xìngqù.',
      example_vi = 'Từ nhỏ dưới sự hun đúc của gia đình, anh ấy đã thể hiện niềm hứng thú học thuật sâu sắc đối với văn học cổ điển Trung Quốc và tản văn hiện đại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '文学',
      'wénxué',
      'văn học, tác phẩm văn học',
      'Danh từ',
      'HSK 5',
      '他从小就在家庭的熏陶下对中国古代古典文学和现代散文表现出浓厚的学术兴趣。',
      'Tā cóngxiǎo jiù zài jiātíng de xūntáo xià duì Zhōngguó gǔdài gǔdiǎn wénxué hé xiàndài sǎnwén biǎoxiàn chū nónghòu de xuéshù xìngqù.',
      'Từ nhỏ dưới sự hun đúc của gia đình, anh ấy đã thể hiện niềm hứng thú học thuật sâu sắc đối với văn học cổ điển Trung Quốc và tản văn hiện đại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他从小就在家庭的熏陶下对中国古代古典文学和现代散文表现出浓厚的学术兴趣。', 'Tā cóngxiǎo jiù zài jiātíng de xūntáo xià duì Zhōngguó gǔdài gǔdiǎn wénxué hé xiàndài sǎnwén biǎoxiàn chū nónghòu de xuéshù xìngqù.', 'Từ nhỏ dưới sự hun đúc của gia đình, anh ấy đã thể hiện niềm hứng thú học thuật sâu sắc đối với văn học cổ điển Trung Quốc và tản văn hiện đại.', 'basic', 1),
      (v_id, '这部史诗级长篇巨著深刻折射出时代变革中的众生百态与深层人性博弈，被公认为当代现实主义文学创作的经典丰碑。', 'Zhè bù shǐshījí chángpiān jùzhù shēnkè zhéshè chū shídài biàngé zhōng de zhòngshēng bǎitài yǔ shēncéng rénxìng bóyì, bèi gōngrèn wéi dāngdài xiànshí zhǔyì wénxué chuàngzuò de jīngdiǎn fēngbēi.', 'Bộ trường thiên tiểu thuyết đậm chất sử thi này phản ánh sâu sắc muôn mặt nhân sinh và sự đấu tranh giằng xé của bản tính con người trong cuộc biến thiên thời đại, được công nhận là đài tưởng niệm kinh điển của sáng tác văn học hiện thực chủ nghĩa đương đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3201] [稳定] (wěndìng) - ổn định, vững chắc; làm cho ổn định, giữ vững [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '稳定' AND pinyin = 'wěndìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '稳定' AND pinyin = 'wěndìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '稳定'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '稳定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'wěndìng',
      meaning_vi = 'ổn định, vững chắc; làm cho ổn định, giữ vững',
      example_hanzi = '经过重症监护室医护人员的通宵全力抢救，病人的各项生命体征终于逐渐恢复了稳定。',
      example_pinyin = 'Jīngguò zhòngzhèng jiānhùshì yīhù rényuán de tōngxiāo quánlì qiǎngjiù, bìngrén de gè xiàng shēngmìng tǐzhēng zhōngyú zhújiàn huìfù le wěndìng.',
      example_vi = 'Sau khi được các nhân viên y tế phòng hồi sức tích cực dốc sức cấp cứu thâu đêm, các dấu hiệu sinh tồn của bệnh nhân cuối cùng đã dần hồi phục ổn định.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '稳定',
      'wěndìng',
      'ổn định, vững chắc; làm cho ổn định, giữ vững',
      'Tính từ / Động từ',
      'HSK 5',
      '经过重症监护室医护人员的通宵全力抢救，病人的各项生命体征终于逐渐恢复了稳定。',
      'Jīngguò zhòngzhèng jiānhùshì yīhù rényuán de tōngxiāo quánlì qiǎngjiù, bìngrén de gè xiàng shēngmìng tǐzhēng zhōngyú zhújiàn huìfù le wěndìng.',
      'Sau khi được các nhân viên y tế phòng hồi sức tích cực dốc sức cấp cứu thâu đêm, các dấu hiệu sinh tồn của bệnh nhân cuối cùng đã dần hồi phục ổn định.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过重症监护室医护人员的通宵全力抢救，病人的各项生命体征终于逐渐恢复了稳定。', 'Jīngguò zhòngzhèng jiānhùshì yīhù rényuán de tōngxiāo quánlì qiǎngjiù, bìngrén de gè xiàng shēngmìng tǐzhēng zhōngyú zhújiàn huìfù le wěndìng.', 'Sau khi được các nhân viên y tế phòng hồi sức tích cực dốc sức cấp cứu thâu đêm, các dấu hiệu sinh tồn của bệnh nhân cuối cùng đã dần hồi phục ổn định.', 'basic', 1),
      (v_id, '宏观调控部门适时出台一揽子逆周期政策工具，着力稳预期、稳就业、稳物价，有力维护了经济社会发展大局和谐稳定。', 'Hóngguān tiáokòng bùmén shìshí chūtái yī lǎn zi nì-zhōuqī zhèngcè gōngjù, zhuólì wěn yùqī, wěn jiùyè, wěn wùjià, yǒulì wéihù le jīngjì shèhuì fāzhǎn dàjú héxié wěndìng.', 'Bộ phận điều tiết kinh tế vĩ mô kịp thời đưa ra gói công cụ chính sách nghịch chu kỳ, chú trọng ổn định kỳ vọng, ổn định việc làm, bình ổn vật giá, duy trì vững chắc cục diện phát triển kinh tế xã hội hài hòa và ổn định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn tất cập nhật HSK 5 - Batch 12! Tổng số từ đã xử lý: %', v_count;
END $$;
