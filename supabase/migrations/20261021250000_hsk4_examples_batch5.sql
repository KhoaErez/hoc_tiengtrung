-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 5 (100 TỪ)
-- Phạm vi: #1401 [景点] (jǐngdiǎn) -> #1500 [美] (měi)
-- Tổng số câu ví dụ: 200 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Không tạo từ mới hay bản ghi trùng trong vocabularies
--   - Cập nhật chuẩn hóa cột word_type (Từ loại) và meaning_vi (Nghĩa TV)
--   - Nạp chính xác 2 câu ví dụ vào bảng vocabulary_examples kèm Pinyin và dịch TV
--   - Đồng bộ các cột tương thích ngược example_hanzi, example_pinyin, example_vi
--   - Phân biệt chính xác từ đa âm [空] (kōng - Tính từ) và [空] (kòng - Động từ/Danh từ)
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
  -- [景点] (jǐngdiǎn) - điểm tham quan, danh lam thắng cảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '景点' AND pinyin = 'jǐngdiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '景点'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jǐngdiǎn',
      meaning_vi = 'điểm tham quan, danh lam thắng cảnh',
      example_hanzi = '故宫和颐和园是北京最具代表性的著名旅游景点。',
      example_pinyin = 'Gùgōng hé Yíhéyuán shì Běijīng zuì jù dàibiǎoxìng de zhùmíng lǚyóu jǐngdiǎn.',
      example_vi = 'Cố Cung và Di Hòa Viên là những điểm tham quan du lịch nổi tiếng tiêu biểu nhất của Bắc Kinh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '故宫和颐和园是北京最具代表性的著名旅游景点。', 'Gùgōng hé Yíhéyuán shì Běijīng zuì jù dàibiǎoxìng de zhùmíng lǚyóu jǐngdiǎn.', 'Cố Cung và Di Hòa Viên là những điểm tham quan du lịch nổi tiếng tiêu biểu nhất của Bắc Kinh.', 'basic', 1),
        (v_id, '当地文旅部门通过深度挖掘古村落的历史文化底蕴，将原本冷僻的小山村成功打造成了热门生态旅游景点。', 'Dāngdì wénlǚ bùmén tōngguò shēndù wājué gǔcūnluò de lìshǐ wénhuà dǐyùn, jiāng yuánběn lěngpì de xiǎo shāncūn chénggōng dǎzào chéng le rèmén shēngtài lǚyóu jǐngdiǎn.', 'Ngành văn hóa du lịch địa phương thông qua việc khai thác sâu bề dày lịch sử văn hóa của các thôn làng cổ, đã xây dựng thành công ngôi làng miền núi vốn hẻo lánh thành điểm du lịch sinh thái hút khách.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [景区] (jǐngqū) - khu danh thắng, khu du lịch, khu thắng cảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '景区' AND pinyin = 'jǐngqū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '景区'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jǐngqū',
      meaning_vi = 'khu danh thắng, khu du lịch, khu thắng cảnh',
      example_hanzi = '节假日期间前往张家界景区的海内外游客络绎不绝。',
      example_pinyin = 'Jiéjiàrì qījiān qiánwǎng Zhāngjiājiè jǐngqū de hǎinèiwài yóukè luòyì-bùjué.',
      example_vi = 'Trong các dịp nghỉ lễ tết, du khách trong và ngoài nước đổ về khu thắng cảnh Trương Gia Giới nườm nượp không ngớt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '节假日期间前往张家界景区的海内外游客络绎不绝。', 'Jiéjiàrì qījiān qiánwǎng Zhāngjiājiè jǐngqū de hǎinèiwài yóukè luòyì-bùjué.', 'Trong các dịp nghỉ lễ tết, du khách trong và ngoài nước đổ về khu thắng cảnh Trương Gia Giới nườm nượp không ngớt.', 'basic', 1),
        (v_id, '为切实保护世界自然遗产地脆弱的生态环境，景区管理处实施了全网实名分时段预约与每日客流上限管控机制。', 'Wèi qièshí bǎohù shìjiè zìrán yíchǎndì cuìruò de shēngtài huánjìng, jǐngqū guǎnlǐchù shíshī le quán wǎng shímíng fēnshíduàn yùyuē yǔ měirì kèliú shàngxiàn guǎnkòng jīzhì.', 'Để bảo vệ thiết thực môi trường sinh thái mỏng manh của khu di sản thiên nhiên thế giới, ban quản lý khu danh thắng đã triển khai cơ chế kiểm soát giới hạn lượng khách mỗi ngày và đặt chỗ trước định danh theo khung giờ trên toàn mạng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [景色] (jǐngsè) - cảnh sắc, cảnh quan, phong cảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '景色' AND pinyin = 'jǐngsè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '景色'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jǐngsè',
      meaning_vi = 'cảnh sắc, cảnh quan, phong cảnh',
      example_hanzi = '春天西湖边桃红柳绿，湖光山色的秀美景色令人流连忘返。',
      example_pinyin = 'Chūntiān Xīhú biān táohóng-liǔlǜ, húguāng-shānsè de xiùměi jǐngsè lìng rén liúlián-wàngfǎn.',
      example_vi = 'Mùa xuân bên bờ Tây Hồ đào hồng liễu thắm, cảnh sắc sông núi nước biếc tuyệt đẹp khiến lòng người lưu luyến quên cả lối về.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '春天西湖边桃红柳绿，湖光山色的秀美景色令人流连忘返。', 'Chūntiān Xīhú biān táohóng-liǔlǜ, húguāng-shānsè de xiùměi jǐngsè lìng rén liúlián-wàngfǎn.', 'Mùa xuân bên bờ Tây Hồ đào hồng liễu thắm, cảnh sắc sông núi nước biếc tuyệt đẹp khiến lòng người lưu luyến quên cả lối về.', 'basic', 1),
        (v_id, '站在现代化观景平台远眺，古老巍峨的历史城墙与鳞次栉比的摩天大楼交相辉映，构成了一幅古今交融的壮丽城市景色。', 'Zhàn zài xiàndàihuà guānjǐng píngtái yuǎntiào, gǔlǎo wēi’é de lìshǐ chéngqiáng yǔ líncì-zhìbǐ de mótiān-dàlóu jiāoxiāng-huìyìng, gòuchéng le yì fú gǔ-jīn jiāoróng de zhuànglì chéngshì jǐngsè.', 'Đứng trên đài ngắm cảnh hiện đại nhìn ra xa, bức tường thành lịch sử cổ kính nguy nga cùng những tòa nhà chọc trời san sát đan xen hòa quyện, tạo nên bức tranh cảnh sắc đô thị tráng lệ giao thoa giữa cổ xưa và hiện đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [竟然] (jìngrán) - vậy mà, lại có thể, bất ngờ thay [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '竟然' AND pinyin = 'jìngrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '竟然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'jìngrán',
      meaning_vi = 'vậy mà, lại có thể, bất ngờ thay',
      example_hanzi = '这道难度极高的数学竞赛压轴题，他竟然只用了十分钟就解出来了。',
      example_pinyin = 'Zhè dào nándù jí gāo de shùxué jìngsài yāzhóutí, tā jìngrán zhǐ yòng le shí fēnzhōng jiù jiě chūlái le.',
      example_vi = 'Câu hỏi chốt hạ của kỳ thi học sinh giỏi toán có độ khó cực cao này, cậu ấy vậy mà chỉ dùng mười phút là đã giải ra rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这道难度极高的数学竞赛压轴题，他竟然只用了十分钟就解出来了。', 'Zhè dào nándù jí gāo de shùxué jìngsài yāzhóutí, tā jìngrán zhǐ yòng le shí fēnzhōng jiù jiě chūlái le.', 'Câu hỏi chốt hạ của kỳ thi học sinh giỏi toán có độ khó cực cao này, cậu ấy vậy mà chỉ dùng mười phút là đã giải ra rồi.', 'basic', 1),
        (v_id, '经过长达数年的艰苦自主攻关，一家名不见经传的初创科技公司竟然在超导量子芯片领域率先取得了突破性重大进展。', 'Jīngguò cháng dá shù nián de jiānkǔ zìzhǔ gōngguān, yì jiā míngbùjiànjīngzhuàn de chūchuàng kējì gōngsī jìngrán zài chāodǎo liàngzǐ xīnpiàn lǐngyù xiānshuài qǔdé le tūpòxìng zhòngdà jìnzhǎn.', 'Trải qua nhiều năm kiên trì nỗ lực tự chủ đột phá, một công ty công nghệ khởi nghiệp vô danh tiểu tốt lại có thể là đơn vị đi đầu giành được bước tiến đột phá trọng đại trong lĩnh vực chip lượng tử siêu dẫn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [竞争] (jìngzhēng) - cạnh tranh; cuộc cạnh tranh [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '竞争' AND pinyin = 'jìngzhēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '竞争'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'jìngzhēng',
      meaning_vi = 'cạnh tranh; cuộc cạnh tranh',
      example_hanzi = '当今社会的职场就业竞争非常激烈，需要不断提升综合能力。',
      example_pinyin = 'Dāngjīn shèhuì de zhíchǎng jiùyè jìngzhēng fēicháng jīliè, xūyào bùduàn tíshēng zōnghé nénglì.',
      example_vi = 'Cuộc cạnh tranh việc làm nơi chốn công sở trong xã hội ngày nay vô cùng khốc liệt, đòi hỏi phải không ngừng nâng cao năng lực tổng hợp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '当今社会的职场就业竞争非常激烈，需要不断提升综合能力。', 'Dāngjīn shèhuì de zhíchǎng jiùyè jìngzhēng fēicháng jīliè, xūyào bùduàn tíshēng zōnghé nénglì.', 'Cuộc cạnh tranh việc làm nơi chốn công sở trong xã hội ngày nay vô cùng khốc liệt, đòi hỏi phải không ngừng nâng cao năng lực tổng hợp.', 'basic', 1),
        (v_id, '高科技企业若想在全球化残酷竞争中脱颖而出，唯有坚持核心底层技术的自主知识产权研发并构建坚固的专利壁垒。', 'Gāokējì qǐyè ruò xiǎng zài quánqiúhuà cánkù jìngzhēng zhōng tuōyǐng-érchū, wéiyǒu jiānchí héxīn dǐcéng jìshù de zìzhǔ zhīshi chǎnquán yánfā bìng gòujiàn jiāngù de zhuānlì bìlěi.', 'Doanh nghiệp công nghệ cao nếu muốn nổi bật vượt trội trong cuộc cạnh tranh toàn cầu hóa tàn khốc, chỉ có kiên trì tự chủ nghiên cứu công nghệ tầng đáy độc quyền và xây dựng rào cản bằng sáng chế kiên cố.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [镜子] (jìngzi) - gương, chiếc gương [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '镜子' AND pinyin = 'jìngzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '镜子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jìngzi',
      meaning_vi = 'gương, chiếc gương',
      example_hanzi = '出门上班之前，他习惯站在穿衣镜子前整理一下西装领带。',
      example_pinyin = 'Chūmén shàngbān zhīqián, tā xíguàn zhàn zài chuānyī jìngzi qián zhěnglǐ yíxià xīzhuāng lǐngdài.',
      example_vi = 'Trước khi ra ngoài đi làm, anh ấy quen đứng trước gương soi toàn thân chỉnh đốn lại bộ vest và cà vạt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出门上班之前，他习惯站在穿衣镜子前整理一下西装领带。', 'Chūmén shàngbān zhīqián, tā xíguàn zhàn zài chuānyī jìngzi qián zhěnglǐ yíxià xīzhuāng lǐngdài.', 'Trước khi ra ngoài đi làm, anh ấy quen đứng trước gương soi toàn thân chỉnh đốn lại bộ vest và cà vạt.', 'basic', 1),
        (v_id, '唐太宗曾言“以铜为镜，可以正衣冠；以史为镜，可以知兴替”，历史正如一面清晰的镜子启迪着后人居安思危。', 'Táng Tàizōng céng yán “yǐ tóng wéi jìng, kěyǐ zhèng yīguān; yǐ shǐ wéi jìng, kěyǐ zhī xīngtì”, lìshǐ zhèngrú yí miàn qīngxī de jìngzi qǐdí zhe hòurén jū’ān-sīwēi.', 'Đường Thái Tông từng nói "Lấy đồng làm gương có thể chỉnh ngay ngắn áo mũ; lấy sử làm gương có thể biết hưng thịnh suy vong", lịch sử tựa như chiếc gương sáng khai sáng cho hậu thế lo toan lúc an nhàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [究竟] (jiūjìng) - rốt cuộc, thực sự; kết cục, chân tướng [Phó từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '究竟' AND pinyin = 'jiūjìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '究竟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Danh từ',
      pinyin = 'jiūjìng',
      meaning_vi = 'rốt cuộc, thực sự; kết cục, chân tướng',
      example_hanzi = '大家讨论了半天，你心里究竟赞成哪一种合作方案？',
      example_pinyin = 'Dàjiā tǎolùn le bàntiān, nǐ xīnlǐ jiūjìng zànchéng nǎ yì zhǒng hézuò fāng’àn?',
      example_vi = 'Mọi người đã thảo luận suốt nửa ngày, trong lòng bạn rốt cuộc tán thành phương án hợp tác nào?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大家讨论了半天，你心里究竟赞成哪一种合作方案？', 'Dàjiā tǎolùn le bàntiān, nǐ xīnlǐ jiūjìng zànchéng nǎ yì zhǒng hézuò fāng’àn?', 'Mọi người đã thảo luận suốt nửa ngày, trong lòng bạn rốt cuộc tán thành phương án hợp tác nào?', 'basic', 1),
        (v_id, '为了彻底查明该实验数据异常究竟源自底层仪器物理传感故障还是环境电磁干扰，科研小组连夜进行了严密的交叉对照实验。', 'Wèile chèdǐ chámíng gāi shíyàn shùjù yìcháng jiūjìng yuánzì dǐcéng yíqì wùlǐ chuángǎn gùzhàng háishì huánjìng diàncí gānrǎo, kēyán xiǎozǔ liányè jìnxíng le yánmì de jiāochā duìzhào shíyàn.', 'Để làm sáng tỏ triệt để số liệu thực nghiệm bất thường này rốt cuộc bắt nguồn từ sự cố cảm biến vật lý thiết bị tầng dưới hay do nhiễu điện từ môi trường, nhóm nghiên cứu đã thức trắng đêm tiến hành các thực nghiệm đối chứng chéo chặt chẽ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [就是] (jiùshì) - chính là; chẳng qua là; chỉ có điều [Phó từ / Liên từ / Trợ từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '就是' AND pinyin = 'jiùshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '就是'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Liên từ / Trợ từ',
      pinyin = 'jiùshì',
      meaning_vi = 'chính là; chẳng qua là; chỉ có điều',
      example_hanzi = '站在校门口穿蓝色外套的那位长者就是我们学校的校长。',
      example_pinyin = 'Zhàn zài xiàomén kǒu chuān lánsè wàitào de nà wèi zhǎngzhě jiùshì wǒmen xuéxiào de xiàozhǎng.',
      example_vi = 'Bậc trưởng bối mặc áo khoác xanh dương đứng ở cổng trường chính là hiệu trưởng trường chúng tôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '站在校门口穿蓝色外套的那位长者就是我们学校的校长。', 'Zhàn zài xiàomén kǒu chuān lánsè wàitào de nà wèi zhǎngzhě jiùshì wǒmen xuéxiào de xiàozhǎng.', 'Bậc trưởng bối mặc áo khoác xanh dương đứng ở cổng trường chính là hiệu trưởng trường chúng tôi.', 'basic', 1),
        (v_id, '这项创新技术方案的综合优势非常明显，就是初期研发设备的采购与安装成本相对较为高昂。', 'Zhè xiàng chuàngxīn jìshù fāng’àn de zōnghé yōushì fēicháng míngxiǎn, jiùshì chūqī yánfā shèbèi de cǎigòu yǔ ānzhuāng chéngběn xiāngduì jiàowéi gāo’áng.', 'Ưu thế tổng hợp của phương án công nghệ đổi mới sáng tạo này rất rõ ràng, chỉ có điều chi phí mua sắm và lắp đặt trang thiết bị R&D giai đoạn đầu tương đối đắt đỏ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [举] (jǔ) - giơ lên, nâng lên; nêu ra (ví dụ) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '举' AND pinyin = 'jǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '举'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jǔ',
      meaning_vi = 'giơ lên, nâng lên; nêu ra (ví dụ)',
      example_hanzi = '在课堂上有不懂的疑问时，请先举手再向老师提问。',
      example_pinyin = 'Zài kètáng shang yǒu bù dǒng de yíwèn shí, qǐng xiān jǔshǒu zài xiàng lǎoshī tíwèn.',
      example_vi = 'Trong lớp học khi có thắc mắc chưa hiểu, xin hãy giơ tay lên trước rồi mới đặt câu hỏi cho thầy cô.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在课堂上有不懂的疑问时，请先举手再向老师提问。', 'Zài kètáng shang yǒu bù dǒng de yíwèn shí, qǐng xiān jǔshǒu zài xiàng lǎoshī tíwèn.', 'Trong lớp học khi có thắc mắc chưa hiểu, xin hãy giơ tay lên trước rồi mới đặt câu hỏi cho thầy cô.', 'basic', 1),
        (v_id, '法学教授在解析这部新反垄断法律细则时，列举了大量近年来国际互联网跨国巨头的典型反不正当竞争诉讼判例。', 'Fǎxué jiàoshòu zài jiěxī zhè bù xīn fǎn-lǒngduàn fǎlǜ xìzé shí, lièjǔ le dàliàng jìnniánlái guójì hùliánwǎng kuàguó jùtóu de diǎnxíng fǎn-búzhèngdàng jìngzhēng sùsòng pànlì.', 'Giáo sư luật học khi phân tích chi tiết điều khoản luật chống độc quyền mới này đã nêu ra rất nhiều án lệ kiện tụng chống cạnh tranh không lành mạnh điển hình của các gã khổng lồ internet đa quốc gia quốc tế trong những năm gần đây.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [举办] (jǔbàn) - tổ chức, đăng cai tổ chức [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '举办' AND pinyin = 'jǔbàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '举办'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jǔbàn',
      meaning_vi = 'tổ chức, đăng cai tổ chức',
      example_hanzi = '市图书馆定于本周六上午举办一场关于中国传统茶文化的公益讲座。',
      example_pinyin = 'Shì túshūguǎn dìng yú běn zhōuliù shàngwǔ jǔbàn yì chǎng guānyú Zhōngguó chuántǒng chá wénhuà de gōngyì jiǎngzuò.',
      example_vi = 'Thư viện thành phố ấn định sáng thứ Bảy tuần này sẽ tổ chức một buổi tọa đàm công ích về văn hóa trà truyền thống Trung Hoa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '市图书馆定于本周六上午举办一场关于中国传统茶文化的公益讲座。', 'Shì túshūguǎn dìng yú běn zhōuliù shàngwǔ jǔbàn yì chǎng guānyú Zhōngguó chuántǒng chá wénhuà de gōngyì jiǎngzuò.', 'Thư viện thành phố ấn định sáng thứ Bảy tuần này sẽ tổ chức một buổi tọa đàm công ích về văn hóa trà truyền thống Trung Hoa.', 'basic', 1),
        (v_id, '中国成功举办了举世瞩目的冬季奥林匹克运动会与进博会，充分向全世界展现了卓越的大国办赛水准与高水平对外开放姿态。', 'Zhōngguó chénggōng jǔbàn le jǔshì-zhǔmù de Dōngjì Àolínpǐkè Yùndònghuì yǔ Jìnbóhuì, chōngfèn xiàng quán shìjiè zhǎnxiàn le zhuóyuè de dàguó bàn sài shuǐzhǔn yǔ gāo shuǐpíng duìwài kāifàng zītài.', 'Trung Quốc đã tổ chức thành công Thế vận hội Thể thao Mùa đông và Hội chợ Nhập khẩu Quốc tế thu hút sự dõi theo của toàn cầu, phô diễn trọn vẹn trước toàn thế giới trình độ tổ chức giải đấu xuất sắc của nước lớn và tư thế mở cửa đối ngoại tiêu chuẩn cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [举例] (jǔlì) - lấy ví dụ, nêu ví dụ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '举例' AND pinyin = 'jǔlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '举例'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jǔlì',
      meaning_vi = 'lấy ví dụ, nêu ví dụ',
      example_hanzi = '你能结合这篇阅读文章的内容，举例说明这个生词的用法吗？',
      example_pinyin = 'Nǐ néng jiéhé zhè piān yuèdú wénzhāng de nèiróng, jǔlì shuōmíng zhè gè shēngcí de yòngfǎ ma?',
      example_vi = 'Bạn có thể kết hợp với nội dung bài đọc này để lấy ví dụ minh họa cho cách dùng của từ mới này không?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你能结合这篇阅读文章的内容，举例说明这个生词的用法吗？', 'Nǐ néng jiéhé zhè piān yuèdú wénzhāng de nèiróng, jǔlì shuōmíng zhè gè shēngcí de yòngfǎ ma?', 'Bạn có thể kết hợp với nội dung bài đọc này để lấy ví dụ minh họa cho cách dùng của từ mới này không?', 'basic', 1),
        (v_id, '经济学专著通过列举多国产业政策在不同历史阶段的成败得失案例，深入阐述了有效市场与有为政府协同运行的内在机理。', 'Jīngjìxué zhuānzhù tōngguò lièjǔ duō guó chǎnyè zhèngcè zài bùtóng lìshǐ jiēduàn de chéng-bài-dé-shī ànlì, shēnrù chǎnshù le yǒuxiào shìchǎng yǔ yǒuwéi zhèngfǔ xiétóng yùnxíng de nèizài jīlǐ.', 'Chuyên khảo kinh tế học thông qua việc nêu ví dụ về các trường hợp thành bại được mất của chính sách công nghiệp nhiều nước ở các giai đoạn lịch sử khác nhau, đã giải thích sâu sắc cơ chế nội tại về sự vận hành hiệp đồng giữa thị trường hiệu quả và chính phủ hữu vi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [举行] (jǔxíng) - tiến hành, tổ chức (buổi lễ, cuộc thi, hội nghị) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '举行' AND pinyin = 'jǔxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '举行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jǔxíng',
      meaning_vi = 'tiến hành, tổ chức (buổi lễ, cuộc thi, hội nghị)',
      example_hanzi = '全校运动会将于明天上午八点在学校主体育场隆重举行。',
      example_pinyin = 'Quán xiào yùndònghuì jiāng yú míngtiān shàngwǔ bā diǎn zài xuéxiào zhǔ tǐyùchǎng lóngzhòng jǔxíng.',
      example_vi = 'Đại hội thể thao toàn trường sẽ được tổ chức long trọng vào 8 giờ sáng mai tại sân vận động chính của trường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '全校运动会将于明天上午八点在学校主体育场隆重举行。', 'Quán xiào yùndònghuì jiāng yú míngtiān shàngwǔ bā diǎn zài xuéxiào zhǔ tǐyùchǎng lóngzhòng jǔxíng.', 'Đại hội thể thao toàn trường sẽ được tổ chức long trọng vào 8 giờ sáng mai tại sân vận động chính của trường.', 'basic', 1),
        (v_id, '二十国集团领导人年度峰会在多国元首出席的庄严氛围中隆重举行，与会各方就维护全球金融稳定与促进绿色发展达成了历史性共识。', 'Èrshíguó Jítuán lǐngdǎorén niándù fēnghuì zài duō guó yuánshǒu chūxí de zhuāngyán fēnwéi zhōng lóngzhòng jǔxíng, yùhuì gè fāng jiù wéihù quánqiú jīnróng wěndìng yǔ cùjìn lǜsè fāzhǎn dáchéng le lìshǐxìng gòngshí.', 'Hội nghị thượng đỉnh thường niên các nhà lãnh đạo G20 đã long trọng diễn ra trong bầu không khí trang nghiêm với sự tham dự của nguyên thủ nhiều quốc gia, các bên tham dự đã đạt được nhận thức chung mang tính lịch sử về việc giữ vững ổn định tài chính toàn cầu và thúc đẩy phát triển xanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [聚] (jù) - tụ họp, sum họp, quây quần [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '聚' AND pinyin = 'jù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '聚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jù',
      meaning_vi = 'tụ họp, sum họp, quây quần',
      example_hanzi = '大学毕业十周年之际，当年的同班同学们再次聚在一起畅叙友情。',
      example_pinyin = 'Dàxué bìyè shí zhōunián zhī jì, dāngnián de tóngbān tóngxuémen zàicì jù zài yìqǐ chàngxù yǒuqíng.',
      example_vi = 'Nhân dịp kỷ niệm 10 năm ngày tốt nghiệp đại học, các bạn học cùng lớp năm nào lại quây quần tụ họp bên nhau hàn huyên tình bạn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大学毕业十周年之际，当年的同班同学们再次聚在一起畅叙友情。', 'Dàxué bìyè shí zhōunián zhī jì, dāngnián de tóngbān tóngxuémen zàicì jù zài yìqǐ chàngxù yǒuqíng.', 'Nhân dịp kỷ niệm 10 năm ngày tốt nghiệp đại học, các bạn học cùng lớp năm nào lại quây quần tụ họp bên nhau hàn huyên tình bạn.', 'basic', 1),
        (v_id, '该高新技术产业园区通过优厚的扶持政策汇聚了全球各地的顶尖科学家与算法专家，形成了强劲的科研创新合力。', 'Gāi gāoxīnjìshù chǎnyè yuánqū tōngguò yōuhòu de fúchí zhèngcè huìjù le quánqiú gèdì de dǐngjiān kēxuéjiā yǔ suànfǎ zhuānjiā, xíngchéng le qiángjìn de kēyán chuàngxīn hélì.', 'Khu công nghiệp công nghệ cao này thông qua những chính sách ưu đãi hỗ trợ hậu hĩnh đã quy tụ các nhà khoa học và chuyên gia thuật toán hàng đầu từ khắp nơi trên thế giới, tạo nên sức mạnh tổng hợp đổi mới nghiên cứu khoa học mạnh mẽ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [聚餐] (jùcān) - liên hoan ăn uống, ăn bữa cơm chung [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '聚餐' AND pinyin = 'jùcān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '聚餐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jùcān',
      meaning_vi = 'liên hoan ăn uống, ăn bữa cơm chung',
      example_hanzi = '今天部门圆满完成了月度业务指标，主管晚上请大家一起聚餐庆祝。',
      example_pinyin = 'Jīntiān bùmén yuánmǎn wánchéng le yuèdù yèwù zhǐbiāo, zhǔguǎn wǎnshang qǐng dàjiā yìqǐ jùcān qìngzhù.',
      example_vi = 'Hôm nay phòng ban đã hoàn thành viên mãn chỉ tiêu kinh doanh tháng, buổi tối trưởng phòng mời mọi người cùng đi ăn liên hoan chúc mừng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天部门圆满完成了月度业务指标，主管晚上请大家一起聚餐庆祝。', 'Jīntiān bùmén yuánmǎn wánchéng le yuèdù yèwù zhǐbiāo, zhǔguǎn wǎnshang qǐng dàjiā yìqǐ jùcān qìngzhù.', 'Hôm nay phòng ban đã hoàn thành viên mãn chỉ tiêu kinh doanh tháng, buổi tối trưởng phòng mời mọi người cùng đi ăn liên hoan chúc mừng.', 'basic', 1),
        (v_id, '在新春佳节来临之际，公司工会特别组织了一场温馨丰盛的年终员工家属答谢聚餐晚宴。', 'Zài xīnchūn jiājié láilín zhī jì, gōngsī gōnghuì tèbié zǔzhī le yì chǎng wēnxīn fēngshèng de niánzhōng yuángōng jiāshǔ dáxiè jùcān wǎnyàn.', 'Nhân dịp tết đến xuân về đang đến gần, công đoàn công ty đã đặc biệt tổ chức một bữa tiệc tối liên hoan tất niên ấm áp thịnh soạn để tri ân gia đình người thân của nhân viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [聚会] (jùhuì) - tụ họp, họp mặt; buổi họp mặt [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '聚会' AND pinyin = 'jùhuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '聚会'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'jùhuì',
      meaning_vi = 'tụ họp, họp mặt; buổi họp mặt',
      example_hanzi = '周末他在家里举办了一个小型的朋友聚会，大家一起做饭聊天。',
      example_pinyin = 'Zhōumò tā zài jiā lǐ jǔbàn le yí gè xiǎoxíng de péngyou jùhuì, dàjiā yìqǐ zuòfàn liáotiān.',
      example_vi = 'Cuối tuần anh ấy tổ chức một buổi tụ họp bạn bè quy mô nhỏ tại nhà, mọi người cùng nhau nấu ăn trò chuyện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末他在家里举办了一个小型的朋友聚会，大家一起做饭聊天。', 'Zhōumò tā zài jiā lǐ jǔbàn le yí gè xiǎoxíng de péngyou jùhuì, dàjiā yìqǐ zuòfàn liáotiān.', 'Cuối tuần anh ấy tổ chức một buổi tụ họp bạn bè quy mô nhỏ tại nhà, mọi người cùng nhau nấu ăn trò chuyện.', 'basic', 1),
        (v_id, '本届国际校友联谊聚会吸引了来自三十多个国家和地区的数百名杰出校友，成为推动校企跨国科研产学研合作的重要纽带。', 'Běn jiè guójì xiàoyǒu liányí jùhuì xīyǐn le láizì sānshí duō gè guójiā hé dìqū de shù bǎi míng jiéchū xiàoyǒu, chéngwéi tuīdòng xiào-qǐ kuàguó kēyán chǎn-xué-yán hézuò de zhòngyào niǔdài.', 'Buổi gặp mặt giao lưu cựu sinh viên quốc tế kỳ này đã thu hút hàng trăm cựu sinh viên kiệt xuất đến từ hơn 30 quốc gia và vùng lãnh thổ, trở thành cầu nối quan trọng thúc đẩy hợp tác nghiên cứu ứng dụng giữa nhà trường và doanh nghiệp xuyên quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [拒绝] (jùjué) - từ chối, cự tuyệt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '拒绝' AND pinyin = 'jùjué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '拒绝'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jùjué',
      meaning_vi = 'từ chối, cự tuyệt',
      example_hanzi = '面对别人提出的不合理非分要求，我们应当态度坚决地予以拒绝。',
      example_pinyin = 'Miànduì biérén tíchū de bù hélǐ fēifèn yāoqiú, wǒmen yīngdāng tàidu jiānjué de yǔyǐ jùjué.',
      example_vi = 'Đối mặt với những yêu cầu phi lý quá đáng mà người khác đưa ra, chúng ta nên giữ thái độ kiên quyết từ chối.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '面对别人提出的不合理非分要求，我们应当态度坚决地予以拒绝。', 'Miànduì biérén tíchū de bù hélǐ fēifèn yāoqiú, wǒmen yīngdāng tàidu jiānjué de yǔyǐ jùjué.', 'Đối mặt với những yêu cầu phi lý quá đáng mà người khác đưa ra, chúng ta nên giữ thái độ kiên quyết từ chối.', 'basic', 1),
        (v_id, '为了捍卫企业的长远品牌商誉与消费者切身安全，质检委员会坚决拒绝了让任何一批指标未达标的零部件流入组装车间。', 'Wèile hànwèi qǐyè de chángyuǎn pǐnpái shāngyù yǔ xiāofèizhě qièshēn ānquán, zhìjiǎn wěiyuánhuì jiānjué jùjué le ràng rènhé yì pī zhǐbiāo wèi dábiāo de língbùjiàn liúrù zǔzhuāng chējiān.', 'Để bảo vệ uy tín thương hiệu lâu dài của doanh nghiệp và an toàn thiết thực của người tiêu dùng, ủy ban kiểm tra chất lượng đã kiên quyết từ chối cho phép bất kỳ lô linh kiện chưa đạt chỉ tiêu nào lọt vào xưởng lắp ráp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [距离] (jùlí) - khoảng cách; cách, cách xa [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '距离' AND pinyin = 'jùlí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '距离'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'jùlí',
      meaning_vi = 'khoảng cách; cách, cách xa',
      example_hanzi = '我家距离地铁站步行只需要五分钟左右。',
      example_pinyin = 'Wǒ jiā jùlí dìtiězhàn bùxíng zhǐ xūyào wǔ fēnzhōng zuǒyòu.',
      example_vi = 'Nhà tôi cách ga tàu điện ngầm đi bộ chỉ mất tầm năm phút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我家距离地铁站步行只需要五分钟左右。', 'Wǒ jiā jùlí dìtiězhàn bùxíng zhǐ xūyào wǔ fēnzhōng zuǒyòu.', 'Nhà tôi cách ga tàu điện ngầm đi bộ chỉ mất tầm năm phút.', 'basic', 1),
        (v_id, '跨国视频会议技术与云端远程协作工具的广泛应用，在极大程度上消弭了地理空间距离对跨国企业日常协同办公的阻碍。', 'Kuàguó shìpín huìyì jìshù yǔ yúnduān yuǎnchéng xiézuò gōngjù de guǎngfàn yìngyòng, zài jí dà chéngdù shang xiāomǐ le dìlǐ kōngjiān jùlí duì kuàguó qǐyè rìcháng xiétóng bàngōng de zǔ’ài.', 'Việc ứng dụng rộng rãi công nghệ hội nghị truyền hình xuyên quốc gia và các công cụ cộng tác từ xa trên đám mây đã xóa nhòa đáng kể rào cản về khoảng cách không gian địa lý đối với công việc văn phòng phối hợp hàng ngày của các doanh nghiệp đa quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [剧院] (jùyuàn) - nhà hát, rạp hát [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '剧院' AND pinyin = 'jùyuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '剧院'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jùyuàn',
      meaning_vi = 'nhà hát, rạp hát',
      example_hanzi = '今晚市中心的大剧院里有一场世界顶级的芭蕾舞专场演出。',
      example_pinyin = 'Jīnwǎn shìzhōngxīn de dà jùyuàn lǐ yǒu yì chǎng shìjiè dǐngjí de bālěiwǔ zhuānchǎng yǎnchū.',
      example_vi = 'Tối nay tại Nhà hát Lớn ở trung tâm thành phố có một buổi biểu diễn múa ba lê chuyên đề đẳng cấp hàng đầu thế giới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今晚市中心的大剧院里有一场世界顶级的芭蕾舞专场演出。', 'Jīnwǎn shìzhōngxīn de dà jùyuàn lǐ yǒu yì chǎng shìjiè dǐngjí de bālěiwǔ zhuānchǎng yǎnchū.', 'Tối nay tại Nhà hát Lớn ở trung tâm thành phố có một buổi biểu diễn múa ba lê chuyên đề đẳng cấp hàng đầu thế giới.', 'basic', 1),
        (v_id, '新建成的市文化艺术中心大剧院融合了世界一流的声学建筑设计与数字舞台机械装置，能够完美承载大型交响乐与世界级经典歌剧。', 'Xīnjiàn chéng de shì wénhuà yìshù zhōngxīn dà jùyuàn rónghé le shìjiè yīliú de shēngxué jiànzhù shèjì yǔ shùzì wǔtái jīxiè zhuāngzhì, nénggòu wánměi chéngzài dàxíng jiāoxiǎngyuè yǔ shìjièjí jīngdiǎn gējù.', 'Nhà hát lớn thuộc Trung tâm Văn hóa Nghệ thuật thành phố mới xây dựng đã dung hợp thiết kế kiến trúc âm học hàng đầu thế giới và thiết bị cơ khí sân khấu kỹ thuật số, có khả năng dung nạp hoàn hảo các buổi hòa nhạc giao hưởng quy mô lớn và nhạc kịch kinh điển đẳng cấp thế giới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [开玩笑] (kāi wánxiào) - nói đùa, đùa cợt, trêu đùa [Cụm động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '开玩笑' AND pinyin = 'kāi wánxiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '开玩笑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Cụm động từ',
      pinyin = 'kāi wánxiào',
      meaning_vi = 'nói đùa, đùa cợt, trêu đùa',
      example_hanzi = '别当真，我刚才只是跟你随口开玩笑呢。',
      example_pinyin = 'Bié dàngzhēn, wǒ gāngcái zhǐ shì gēn nǐ suíkǒu kāi wánxiào ne.',
      example_vi = 'Đừng cho là thật nhé, lúc nãy tôi chỉ nói đùa buột miệng với bạn thôi mà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '别当真，我刚才只是跟你随口开玩笑呢。', 'Bié dàngzhēn, wǒ gāngcái zhǐ shì gēn nǐ suíkǒu kāi wánxiào ne.', 'Đừng cho là thật nhé, lúc nãy tôi chỉ nói đùa buột miệng với bạn thôi mà.', 'basic', 1),
        (v_id, '在极其严肃庄重的外事外交与商务谈判签约场合，随意开玩笑往往会导致不必要的跨文化误读与外交礼仪失范。', 'Zài jíqí yánsù zhuāngzhòng de wàishì wàijiāo yǔ shāngwù tánpàn qiānyuē chǎnghé, suíyì kāi wánxiào wǎngwǎng huì dǎozhì bú bìyào de kuà-wénhuà wùdú yǔ wàijiāo lǐyí shīfàn.', 'Trong các dịp ký kết đàm phán thương mại và ngoại giao đối ngoại hết sức nghiêm túc trang trọng, việc tùy tiện nói đùa thường dẫn tới những hiểu lầm xuyên văn hóa không đáng có và vi phạm chuẩn mực nghi lễ ngoại giao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [看法] (kànfǎ) - cách nhìn, quan điểm, nhận định [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '看法' AND pinyin = 'kànfǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '看法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kànfǎ',
      meaning_vi = 'cách nhìn, quan điểm, nhận định',
      example_hanzi = '对于这个问题，不知道李老师有什么不同的看法？',
      example_pinyin = 'Duìyú zhè gè wèntí, bù zhīdào Lǐ lǎoshī yǒu shénme bùtóng de kànfǎ?',
      example_vi = 'Đối với vấn đề này, không biết thầy Lý có quan điểm nhận định gì khác không?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '对于这个问题，不知道李老师有什么不同的看法？', 'Duìyú zhè gè wèntí, bù zhīdào Lǐ lǎoshī yǒu shénme bùtóng de kànfǎ?', 'Đối với vấn đề này, không biết thầy Lý có quan điểm nhận định gì khác không?', 'basic', 1),
        (v_id, '在激烈的战略研讨会上，管理团队应当鼓励成员各抒己见，包容多元甚至相互碰撞的不同看法以激发最佳决策思路。', 'Zài jīliè de zhànlüè yántǎohuì shang, guǎnlǐ tuánduì yīngdāng gǔlì chéngyuán gèshū-jǐjiàn, bāoróng duōyuán shènzhì xiānghù pèngzhuàng de bùtóng kànfǎ yǐ jīfā zuì jiā juécè sīlù.', 'Tại buổi hội thảo chiến lược sôi nổi, đội ngũ quản lý cần khuyến khích các thành viên bày tỏ ý kiến riêng, bao dung những quan điểm đa dạng thậm chí va chạm lẫn nhau để khơi mở tư duy ra quyết định tối ưu nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [烤] (kǎo) - nướng, quay (thịt, bánh) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '烤' AND pinyin = 'kǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '烤'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'kǎo',
      meaning_vi = 'nướng, quay (thịt, bánh)',
      example_hanzi = '北京烤鸭色泽金黄、皮脆肉嫩，闻名海内外。',
      example_pinyin = 'Běijīng kǎoyā sèzé jīnhuáng, pí cuì ròu nèn, wénmíng hǎinèiwài.',
      example_vi = 'Vịt quay Bắc Kinh sắc màu vàng óng, da giòn thịt mềm, nổi tiếng khắp trong và ngoài nước.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '北京烤鸭色泽金黄、皮脆肉嫩，闻名海内外。', 'Běijīng kǎoyā sèzé jīnhuáng, pí cuì ròu nèn, wénmíng hǎinèiwài.', 'Vịt quay Bắc Kinh sắc màu vàng óng, da giòn thịt mềm, nổi tiếng khắp trong và ngoài nước.', 'basic', 1),
        (v_id, '这家具有数十年传统技艺的百年老字号餐厅，始终坚持使用天然果木碳火慢火烘烤，保留了传统烤肉最地道的醇香风味。', 'Zhè jiā jùyǒu shù shí nián chuántǒng jìyì de bǎinián lǎozìhào cāntīng, shǐzhōng jiānchí shǐyòng tiānrán guǒmù tànhuǒ mànhuǒ hōngkǎo, bǎoliú le chuántǒng kǎoròu zuì dìdao de chúnxiāng fēngwèi.', 'Nhà hàng thương hiệu lâu đời trăm năm sở hữu tay nghề truyền thống mấy chục năm này luôn kiên trì dùng than gỗ cây ăn quả tự nhiên om lửa nhỏ nướng từ từ, giữ trọn hương vị thơm nồng chuẩn mực nhất của món thịt nướng truyền thống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [考虑] (kǎolǜ) - cân nhắc, suy xét; sự đắn đo [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '考虑' AND pinyin = 'kǎolǜ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '考虑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'kǎolǜ',
      meaning_vi = 'cân nhắc, suy xét; sự đắn đo',
      example_hanzi = '这件事情关系重大，请你先回去慎重考虑一下再做决定。',
      example_pinyin = 'Zhè jiàn shìqing guānxì zhòngdà, qǐng nǐ xiān huíqù shènzhòng kǎolǜ yíxià zài zuò juédìng.',
      example_vi = 'Sự việc này có liên quan hệ trọng, xin bạn hãy về nhà suy nghĩ cân nhắc thật cẩn trọng rồi hẵng đưa ra quyết định.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这件事情关系重大，请你先回去慎重考虑一下再做决定。', 'Zhè jiàn shìqing guānxì zhòngdà, qǐng nǐ xiān huíqù shènzhòng kǎolǜ yíxià zài zuò juédìng.', 'Sự việc này có liên quan hệ trọng, xin bạn hãy về nhà suy nghĩ cân nhắc thật cẩn trọng rồi hẵng đưa ra quyết định.', 'basic', 1),
        (v_id, '跨国并购交易方案在正式拍板签署前，必须全方位综合考虑目标企业的隐性负债风险与跨文化团队整合难点。', 'Kuàguó bìnggòu jiāoyì fāng’àn zài zhèngshì pāibǎn qiānshǔ qián, bìxū quánfāngwèi zōnghé kǎolǜ mùbiāo qǐyè de yǐnxìng fùzhài fēngxiǎn yǔ kuà-wénhuà tuánduì zhěnghé nándiǎn.', 'Phương án giao dịch mua bán sáp nhập xuyên quốc gia trước khi chính thức chốt hạ ký kết, bắt buộc phải cân nhắc tổng hợp toàn diện các rủi ro nợ tiềm ẩn của doanh nghiệp mục tiêu và những khó khăn trong việc hợp nhất đội ngũ đa văn hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [考生] (kǎoshēng) - thí sinh, người dự thi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '考生' AND pinyin = 'kǎoshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '考生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kǎoshēng',
      meaning_vi = 'thí sinh, người dự thi',
      example_hanzi = '请各位考生按时携带准考证和有效身份证件进入考场。',
      example_pinyin = 'Qǐng gèwèi kǎoshēng ànshí xiédài zhǔnkǎozhèng hé yǒuxiào shēnfèn zhèngjiàn jìnrù kǎochǎng.',
      example_vi = 'Xin mời các vị thí sinh mang theo thẻ dự thi và giấy tờ tùy thân còn hiệu lực vào phòng thi đúng giờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请各位考生按时携带准考证和有效身份证件进入考场。', 'Qǐng gèwèi kǎoshēng ànshí xiédài zhǔnkǎozhèng hé yǒuxiào shēnfèn zhèngjiàn jìnrù kǎochǎng.', 'Xin mời các vị thí sinh mang theo thẻ dự thi và giấy tờ tùy thân còn hiệu lực vào phòng thi đúng giờ.', 'basic', 1),
        (v_id, '各考点考务监考人员严格执行考试纪律，运用高科技防作弊信号屏蔽系统全力为广大考生营造公平公正的考试竞争环境。', 'Gè kǎodiǎn kǎowù jiānkǎo rényuán yángé zhíxíng kǎoshì jìlǜ, yùnyòng gāokējì fáng-zuòbì xìnhào píngbì xìtǒng quánlì wèi guǎngdà kǎoshēng yíngzào gōngpíng-gōngzhèng de kǎoshì jìngzhēng huánjìng.', 'Cán bộ giám thị coi thi tại từng điểm thi thực hiện nghiêm ngặt kỷ luật phòng thi, sử dụng hệ thống chắn sóng chống gian lận công nghệ cao dốc sức tạo lập môi trường cạnh tranh thi cử công bằng chính trực cho đông đảo thí sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [棵] (kē) - cây, gốc (cây cối) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '棵' AND pinyin = 'kē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '棵'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'kē',
      meaning_vi = 'cây, gốc (cây cối)',
      example_hanzi = '我家院子正中央栽种着一棵枝繁叶茂的古老桂花树。',
      example_pinyin = 'Wǒ jiā yuànzi zhèngzhōngyāng zāizhòng zhe yì kē zhīfán-yèmào de gǔlǎo guìhuāshù.',
      example_vi = 'Chính giữa sân nhà tôi có trồng một cây hoa quế cổ thụ cành lá xum xuê tốt tươi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我家院子正中央栽种着一棵枝繁叶茂的古老桂花树。', 'Wǒ jiā yuànzi zhèngzhōngyāng zāizhòng zhe yì kē zhīfán-yèmào de gǔlǎo guìhuāshù.', 'Chính giữa sân nhà tôi có trồng một cây hoa quế cổ thụ cành lá xum xuê tốt tươi.', 'basic', 1),
        (v_id, '林业科研人员对自然保护区内现存的每一棵国家一级珍稀濒危古树名木，都建立了专属数字化健康监测档案。', 'Línyè kēyán rényuán duì zìrán bǎohùqū nèi xiàncún de měi yì kē guójiā yījí zhēnxī bīnwēi gǔshù míngmù, dōu jiànlì le zhuānshǔ shùzìhuà jiànkāng jiāncè dàng’àn.', 'Các cán bộ nghiên cứu lâm nghiệp đã thiết lập hồ sơ theo dõi sức khỏe số hóa độc quyền cho từng gốc cây cổ thụ quý hiếm nguy cấp cấp 1 quốc gia còn tồn tại trong khu bảo tồn thiên nhiên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [科技] (kējì) - khoa học kỹ thuật, công nghệ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '科技' AND pinyin = 'kējì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '科技'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kējì',
      meaning_vi = 'khoa học kỹ thuật, công nghệ',
      example_hanzi = '现代信息科技的飞速发展给人们的生活带来了极大便利。',
      example_pinyin = 'Xiàndài xìnxī kējì de fēisù fāzhǎn gěi rénmen de shēnghuó dài lái le jí dà biànlì.',
      example_vi = 'Sự phát triển thần tốc của công nghệ thông tin hiện đại đã đem lại sự tiện lợi vô cùng to lớn cho đời sống con người.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '现代信息科技的飞速发展给人们的生活带来了极大便利。', 'Xiàndài xìnxī kējì de fēisù fāzhǎn gěi rénmen de shēnghuó dài lái le jí dà biànlì.', 'Sự phát triển thần tốc của công nghệ thông tin hiện đại đã đem lại sự tiện lợi vô cùng to lớn cho đời sống con người.', 'basic', 1),
        (v_id, '坚持创新在现代化建设全局中的核心地位，把科技自立自强作为国家发展的战略支撑。', 'Jiānchí chuàngxīn zài xiàndàihuà jiànshè quánjú zhōng de héxīn dìwèi, bǎ kējì zìlì-zìqiáng zuòwéi guójiā fāzhǎn de zhànlüè zhīchēng.', 'Kiên trì vị thế cốt lõi của đổi mới sáng tạo trong cục diện xây dựng hiện đại hóa, coi khoa học công nghệ tự lực tự cường là trụ cột chiến lược cho sự phát triển của quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [科学] (kēxué) - khoa học; mang tính khoa học, hợp lý [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '科学' AND pinyin = 'kēxué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '科学'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'kēxué',
      meaning_vi = 'khoa học; mang tính khoa học, hợp lý',
      example_hanzi = '制定学习计划一定要遵循科学合理的原则，劳逸结合。',
      example_pinyin = 'Zhìdìng xuéxí jìhuà yídìng yào zūnxún kēxué hélǐ de yuánzé, láoyì-jiéhé.',
      example_vi = 'Lập kế hoạch học tập nhất định phải tuân theo nguyên tắc khoa học hợp lý, kết hợp làm việc và nghỉ ngơi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '制定学习计划一定要遵循科学合理的原则，劳逸结合。', 'Zhìdìng xuéxí jìhuà yídìng yào zūnxún kēxué hélǐ de yuánzé, láoyì-jiéhé.', 'Lập kế hoạch học tập nhất định phải tuân theo nguyên tắc khoa học hợp lý, kết hợp làm việc và nghỉ ngơi.', 'basic', 1),
        (v_id, '推动社会高质量发展必须牢固树立科学决策意识，尊重客观规律并充分听取多领域跨学科专家的论证意见。', 'Tuīdòng shèhuì gāozhìliàng fāzhǎn bìxū láogù shùlì kēxué juécè yìshí, zūnzhòng kèguān guīlǜ bìng chōngfèn tīngqǔ duō lǐngyù kuà-xuékē zhuānjiā de lùnzhèng yìjiàn.', 'Thúc đẩy xã hội phát triển chất lượng cao bắt buộc phải xác lập vững chắc ý thức ra quyết sách khoa học, tôn trọng quy luật khách quan và lắng nghe đầy đủ ý kiến phản biện của các chuyên gia liên ngành đa lĩnh vực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [咳] (ké) - ho [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '咳' AND pinyin = 'ké'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '咳'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'ké',
      meaning_vi = 'ho',
      example_hanzi = '他感冒了，嗓子干痒难受，一直在轻轻地咳。',
      example_pinyin = 'Tā gǎnmào le, sǎngzi gān yǎng nánshòu, yìzhí zài qīngqīng de ké.',
      example_vi = 'Anh ấy bị cảm rồi, cổ họng khô ngứa khó chịu, cứ ho khẽ suốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他感冒了，嗓子干痒难受，一直在轻轻地咳。', 'Tā gǎnmào le, sǎngzi gān yǎng nánshòu, yìzhí zài qīngqīng de ké.', 'Anh ấy bị cảm rồi, cổ họng khô ngứa khó chịu, cứ ho khẽ suốt.', 'basic', 1),
        (v_id, '医生在仔细听诊后提醒患者，如果胸痛伴随咳痰甚至咳血等症状，务必尽快进行低剂量螺旋CT复查。', 'Yīshēng zài zǐxì tīngzhěn hòu tíxǐng huànzhě, rúguǒ xiōngtòng bànsuí ké tán shènzhì ké xiě děng zhèngzhuàng, wùbì jǐnkuài jìnxíng dī-jìliàng luóxuán CT fùchá.', 'Bác sĩ sau khi cẩn thận nghe tim phổi đã nhắc nhở người bệnh, nếu đau ngực đi kèm triệu chứng ho có đờm thậm chí ho ra máu thì nhất thiết phải nhanh chóng chụp CT xoắn ốc liều thấp để kiểm tra lại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [咳嗽] (késou) - ho, chứng ho [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '咳嗽' AND pinyin = 'késou'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '咳嗽'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'késou',
      meaning_vi = 'ho, chứng ho',
      example_hanzi = '冬天天气寒冷干燥，受凉后很容易引起感冒和咳嗽。',
      example_pinyin = 'Dōngtiān tiānqì hánlěng gānzào, shòuliáng hòu hěn róngyì yǐnqǐ gǎnmào hé késou.',
      example_vi = 'Mùa đông thời tiết lạnh giá khô hanh, sau khi bị nhiễm lạnh rất dễ gây ra cảm cúm và ho.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '冬天天气寒冷干燥，受凉后很容易引起感冒和咳嗽。', 'Dōngtiān tiānqì hánlěng gānzào, shòuliáng hòu hěn róngyì yǐnqǐ gǎnmào hé késou.', 'Mùa đông thời tiết lạnh giá khô hanh, sau khi bị nhiễm lạnh rất dễ gây ra cảm cúm và ho.', 'basic', 1),
        (v_id, '患者连续剧烈剧烈咳嗽两周以上未见好转，经呼吸内科专家会诊确诊为慢性过敏性支气管炎，需规范雾化治疗。', 'Huànzhě liánxù jùliè késou liǎng zhōu yǐshàng wèi jiàn hǎozhuǎn, jīng hūxī nèikē zhuānjiā huìzhěn quèzhěn wéi mànxìng guòmǐnxìng zhīqìguǎnyán, xū guīfàn wùhuà zhìliáo.', 'Bệnh nhân ho dữ dội liên tục hơn hai tuần không thấy thuyên giảm, qua hội chẩn của các chuyên gia nội hô hấp đã chẩn đoán là viêm phế quản dị ứng mãn tính, cần điều trị khí dung đúng quy chuẩn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [可惜] (kěxī) - đáng tiếc, tiếc là [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '可惜' AND pinyin = 'kěxī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '可惜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'kěxī',
      meaning_vi = 'đáng tiếc, tiếc là',
      example_hanzi = '他因为在最后关头出现小失误而与金牌擦肩而过，实在太可惜了。',
      example_pinyin = 'Tā yīnwèi zài zuìhòu guāntóu chūxiàn xiǎo shīwù ér yǔ jīnpái cājiān-érguò, shízài tài kěxī le.',
      example_vi = 'Anh ấy do mắc lỗi nhỏ ở thời khắc cuối cùng mà lỡ mất huy chương vàng, thật sự quá đáng tiếc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他因为在最后关头出现小失误而与金牌擦肩而过，实在太可惜了。', 'Tā yīnwèi zài zuìhòu guāntóu chūxiàn xiǎo shīwù ér yǔ jīnpái cājiān-érguò, shízài tài kěxī le.', 'Anh ấy do mắc lỗi nhỏ ở thời khắc cuối cùng mà lỡ mất huy chương vàng, thật sự quá đáng tiếc.', 'basic', 1),
        (v_id, '这家拥有百年精湛传统手工艺的老作坊因缺乏现代市场商业化运作而濒临倒闭，这无疑是宝贵文化遗产传承的重大可惜。', 'Zhè jiā yōngyǒu bǎinián jīngzhàn chuántǒng shǒugōngyì de lǎo zuòfang yīn quēfá xiàndài shìchǎng shāngyèhuà yùnzuò ér bīnlín dǎobì, zhè wúyí shì bǎoguì wénhuà yíchǎn chuánchéng de zhòngdà kěxī.', 'Xưởng thủ công lâu đời sở hữu tay nghề thủ công truyền thống tinh xảo trăm năm này vì thiếu vận hành thương mại hóa thị trường hiện đại mà đứng trước nguy cơ đóng cửa, đây không nghi ngờ gì là điều vô cùng đáng tiếc đối với sự kế thừa di sản văn hóa quý báu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [克] (kè) - gam (g) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '克' AND pinyin = 'kè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '克'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'kè',
      meaning_vi = 'gam (g)',
      example_hanzi = '制作这个草莓蛋糕需要准备两百克低筋面粉和五十克白糖。',
      example_pinyin = 'Zhìzuò zhè gè cǎoméi dàngāo xūyào zhǔnbèi liǎng bǎi kè dījīn miànfěn hé wǔshí kè bái táng.',
      example_vi = 'Làm chiếc bánh ga-tô dâu tây này cần chuẩn bị 200 gam bột mì số 8 và 50 gam đường trắng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '制作这个草莓蛋糕需要准备两百克低筋面粉和五十克白糖。', 'Zhìzuò zhè gè cǎoméi dàngāo xūyào zhǔnbèi liǎng bǎi kè dījīn miànfěn hé wǔshí kè bái táng.', 'Làm chiếc bánh ga-tô dâu tây này cần chuẩn bị 200 gam bột mì số 8 và 50 gam đường trắng.', 'basic', 1),
        (v_id, '国家卫生健康委员会提倡健康清淡饮食，建议成年人每人每天食盐摄入量应严格控制在五克以内。', 'Guójiā Wèishēng Jiànkāng Wěiyuánhuì tíchàng jiànkāng qīngdàn yǐnshí, jiànyì chéngniánrén měi rén měi tiān shíyán shèrùliàng yīng yángé kòngzhì zài wǔ kè yǐnèi.', 'Ủy ban Y tế Sức khỏe Quốc gia kêu gọi ăn uống thanh đạm lành mạnh, khuyến nghị mỗi người trưởng thành mỗi ngày lượng muối ăn nạp vào nên được kiểm soát nghiêm ngặt dưới 5 gam.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [课程] (kèchéng) - khóa học, môn học, chương trình học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '课程' AND pinyin = 'kèchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '课程'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kèchéng',
      meaning_vi = 'khóa học, môn học, chương trình học',
      example_hanzi = '新学期我选修了中国古代文学和跨文化交际两门课程。',
      example_pinyin = 'Xīn xuéqī wǒ xuǎnxiū le Zhōngguó gǔdài wénxué hé kuà-wénhuà jiāojì liǎng mén kèchéng.',
      example_vi = 'Học kỳ mới tôi đã đăng ký học tự chọn hai môn học là Văn học cổ đại Trung Quốc và Giao tiếp đa văn hóa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '新学期我选修了中国古代文学和跨文化交际两门课程。', 'Xīn xuéqī wǒ xuǎnxiū le Zhōngguó gǔdài wénxué hé kuà-wénhuà jiāojì liǎng mén kèchéng.', 'Học kỳ mới tôi đã đăng ký học tự chọn hai môn học là Văn học cổ đại Trung Quốc và Giao tiếp đa văn hóa.', 'basic', 1),
        (v_id, '该重点大学全面优化商科专业培养方案，重磅推出了深度融合人工智能大数据分析与绿色金融投资的创新前沿课程体系。', 'Gāi zhòngdiǎn dàxué quánmiàn yōuhuà shāngkē zhuānyè péiyǎng fāng’àn, zhòngbàng tuīchū le shēndù rónghé réngōng zhìnéng dàshùjù fēnxī yǔ lǜsè jīnróng tóuzī de chuàngxīn qiányán kèchéng tǐxì.', 'Trường đại học trọng điểm này đã tối ưu hóa toàn diện đề án đào tạo chuyên ngành thương mại, tung ra hệ thống chương trình học tiên phong đổi mới kết hợp sâu sắc giữa phân tích dữ liệu lớn AI và đầu tư tài chính xanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [客气] (kèqi) - khách sáo, lịch sự, khiêm nhường [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '客气' AND pinyin = 'kèqi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '客气'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'kèqi',
      meaning_vi = 'khách sáo, lịch sự, khiêm nhường',
      example_hanzi = '大家都是多年的好朋友，千万别太客气了。',
      example_pinyin = 'Dàjiā dōu shì duō nián de hǎo péngyou, qiānwàn bié tài kèqi le.',
      example_vi = 'Mọi người đều là bạn tốt nhiều năm với nhau, tuyệt đối đừng quá khách sáo nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大家都是多年的好朋友，千万别太客气了。', 'Dàjiā dōu shì duō nián de hǎo péngyou, qiānwàn bié tài kèqi le.', 'Mọi người đều là bạn tốt nhiều năm với nhau, tuyệt đối đừng quá khách sáo nhé.', 'basic', 1),
        (v_id, '在严肃的商务谈判中，既要保持文明礼貌有节的客气风度，也必须寸步不让地坚守己方的核心利益底线。', 'Zài yánsù de shāngwù tánpàn zhōng, jì yào bǎochí wénmíng lǐmào yǒujié de kèqi fēngdù, yě bìxū cùnbù-búràng de jiānshǒu jǐfāng de héxīn lìyì dǐxiàn.', 'Trong cuộc đàm phán thương mại nghiêm túc, vừa phải giữ phong thái lịch sự chừng mực văn minh lễ độ, cũng vừa phải kiên định không nhượng bộ nửa bước giữ vững ranh giới lợi ích cốt lõi của bên mình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [课堂] (kètáng) - lớp học, giờ lên lớp, giảng đường [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '课堂' AND pinyin = 'kètáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '课堂'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kètáng',
      meaning_vi = 'lớp học, giờ lên lớp, giảng đường',
      example_hanzi = '老师生动幽默的讲解让整个课堂充满了欢快的笑声。',
      example_pinyin = 'Lǎoshī shēngdòng yōumò de jiǎngjiě ràng zhěnggè kètáng chōngmǎn le huānkuài de xiàoshēng.',
      example_vi = 'Lời giảng giải hài hước sinh động của thầy giáo khiến cho cả lớp học tràn ngập tiếng cười vui vẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师生动幽默的讲解让整个课堂充满了欢快的笑声。', 'Lǎoshī shēngdòng yōumò de jiǎngjiě ràng zhěnggè kètáng chōngmǎn le huānkuài de xiàoshēng.', 'Lời giảng giải hài hước sinh động của thầy giáo khiến cho cả lớp học tràn ngập tiếng cười vui vẻ.', 'basic', 1),
        (v_id, '现代高校教学模式积极打破传统单一课堂的时空局限，通过引入虚拟仿真实验与校企现场教学，全面提升学生的综合实践应用素养。', 'Xiàndài gāoxiào jiàoxué móshì jījí dǎpò chuántǒng dānyī kètáng de shíkōng júxiàn, tōngguò yǐnrù xūnǐ fǎngzhēn shíyàn yǔ xiào-qǐ xiànchǎng jiàoxué, quánmiàn tíshēng xuésheng de zōnghé shíjiàn yìngyòng sùyǎng.', 'Mô hình dạy học đại học hiện đại chủ động phá vỡ giới hạn thời không của lớp học đơn thuần truyền thống, thông qua việc đưa vào các thí nghiệm mô phỏng ảo và dạy học trực tiếp tại hiện trường doanh nghiệp, nâng cao toàn diện tố chất ứng dụng thực hành tổng hợp của sinh viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [客厅] (kètīng) - phòng khách [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '客厅' AND pinyin = 'kètīng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '客厅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kètīng',
      meaning_vi = 'phòng khách',
      example_hanzi = '晚饭后一家人常常围坐在明亮宽敞的客厅里看电视聊天。',
      example_pinyin = 'Wǎnfàn hòu yì jiā rén chángcháng wéizuò zài míngliàng kuānchang de kètīng lǐ kàn diànshì liáotiān.',
      example_vi = 'Sau bữa cơm tối cả gia đình thường quây quần ngồi trong phòng khách sáng sủa rộng rãi xem tivi trò chuyện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '晚饭后一家人常常围坐在明亮宽敞的客厅里看电视聊天。', 'Wǎnfàn hòu yì jiā rén chángcháng wéizuò zài míngliàng kuānchang de kètīng lǐ kàn diànshì liáotiān.', 'Sau bữa cơm tối cả gia đình thường quây quần ngồi trong phòng khách sáng sủa rộng rãi xem tivi trò chuyện.', 'basic', 1),
        (v_id, '现代住宅室内空间设计更加注重开放式客厅与多功能社交空间的灵活重构，为家庭成员创造温馨亲密的互动场景。', 'Xiàndài zhùzhái shìnèi kōngjiān shèjì gèngjiā zhùzhòng kāifàngshì kètīng yǔ duōgōngnéng shèjiāo kōngjiān de línghuó chónggòu, wèi jiātíng chéngyuán chuàngzào wēnxīn qīnmì de hùdòng chǎngjǐng.', 'Thiết kế không gian nội thất nhà ở hiện đại càng chú trọng vào việc tái cấu trúc linh hoạt phòng khách kiểu mở và không gian giao lưu đa chức năng, tạo ra bối cảnh tương tác ấm cúng thân mật cho các thành viên trong gia đình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [肯定] (kěndìng) - khẳng định; chắc chắn, nhất định [Động từ / Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '肯定' AND pinyin = 'kěndìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '肯定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ / Phó từ',
      pinyin = 'kěndìng',
      meaning_vi = 'khẳng định; chắc chắn, nhất định',
      example_hanzi = '只要你坚持每天认真听写，中文听力成绩肯定会大幅提升。',
      example_pinyin = 'Zhǐyào nǐ jiānchí měitiān rènzhēn tīngxiě, Zhōngwén tīnglì chéngjì kěndìng huì dàfú tíshēng.',
      example_vi = 'Chỉ cần bạn kiên trì mỗi ngày nghe chép chính tả nghiêm túc, điểm nghe tiếng Trung chắc chắn sẽ tăng vọt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '只要你坚持每天认真听写，中文听力成绩肯定会大幅提升。', 'Zhǐyào nǐ jiānchí měitiān rènzhēn tīngxiě, Zhōngwén tīnglì chéngjì kěndìng huì dàfú tíshēng.', 'Chỉ cần bạn kiên trì mỗi ngày nghe chép chính tả nghiêm túc, điểm nghe tiếng Trung chắc chắn sẽ tăng vọt.', 'basic', 1),
        (v_id, '董事会对研发团队在突破核心技术封锁中所付出的艰苦努力给予了高度肯定，并当场决定追加新一轮项目攻关专项资金。', 'Dǒngshìhuì duì yánfā tuánduì zài tūpò héxīn jìshù fēngsuǒ zhōng suǒ fùchū de jiānkǔ nǔlì jǐyǔ le gāodù kěndìng, bìng dāngchǎng juédìng zhuījiā xīn yì lún xiàngmù gōngguān zhuānxiàng zījīn.', 'Hội đồng quản trị đã dành sự khẳng định và đánh giá rất cao đối với những nỗ lực gian khổ của đội ngũ R&D trong việc phá vỡ sự phong tỏa công nghệ cốt lõi, và quyết định ngay tại chỗ cấp thêm nguồn vốn chuyên đề mới cho dự án đột phá.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [空] (kōng) - trống rỗng, rỗng không [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '空' AND pinyin = 'kōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '空'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'kōng',
      meaning_vi = 'trống rỗng, rỗng không',
      example_hanzi = '这个纸箱子里是空的，没有任何东西。',
      example_pinyin = 'Zhè gè zhǐxiāngzi lǐ shì kōng de, méiyǒu rènhé dōngxi.',
      example_vi = 'Bên trong thùng giấy này là trống không, không có bất kỳ thứ gì.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个纸箱子里是空的，没有任何东西。', 'Zhè gè zhǐxiāngzi lǐ shì kōng de, méiyǒu rènhé dōngxi.', 'Bên trong thùng giấy này là trống không, không có bất kỳ thứ gì.', 'basic', 1),
        (v_id, '任何宏伟的商业蓝图如果缺乏脚踏实地的落地执行机制，最终都不过是一句空话罢了。', 'Rènhé hóngwěi de shāngyè lántú rúguǒ quēfá jiǎotà-shídì de luòdì zhíxíng jīzhì, zuìzhōng dōu búguò shì yí jù kōnghuà bàle.', 'Bất kỳ bản kế hoạch thương mại hoành tráng nào nếu thiếu cơ chế thực thi vững chắc đi vào thực tiễn, cuối cùng cũng chỉ là lời nói suông rỗng tuếch mà thôi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [空气] (kōngqì) - không khí, bầu không khí [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '空气' AND pinyin = 'kōngqì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '空气'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kōngqì',
      meaning_vi = 'không khí, bầu không khí',
      example_hanzi = '清晨去公园里散步，呼吸一下新鲜纯净的空气，令人心旷神怡。',
      example_pinyin = 'Qīngchén qù gōngyuán lǐ sànbù, hūxī yíxià xīnxiān chúnjìng de kōngqì, lìng rén xīnxuàng-shényí.',
      example_vi = 'Sáng sớm đi dạo trong công viên, hít thở một chút không khí trong lành thanh khiết, làm lòng người khoan khoái nhẹ nhõm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '清晨去公园里散步，呼吸一下新鲜纯净的空气，令人心旷神怡。', 'Qīngchén qù gōngyuán lǐ sànbù, hūxī yíxià xīnxiān chúnjìng de kōngqì, lìng rén xīnxuàng-shényí.', 'Sáng sớm đi dạo trong công viên, hít thở một chút không khí trong lành thanh khiết, làm lòng người khoan khoái nhẹ nhõm.', 'basic', 1),
        (v_id, '国家深入打好蓝天保卫战，通过淘汰落后产能与治理机动车排放，使全国重点城市的环境空气质量优良天数比例稳步提升。', 'Guójiā shēnrù dǎ hǎo lántiān bǎowèizhàn, tōngguò táotài luòhòu chǎnnéng yǔ zhìlǐ jīdòngchē páifàng, shǐ quánguó zhòngdiǎn chéngshì de huánjìng kōngqì zhìliàng yōuliáng tiānshù bǐlì wěnbù tíshēng.', 'Nhà nước triển khai sâu rộng chiến dịch bảo vệ bầu trời xanh, thông qua việc loại bỏ năng lực sản xuất lạc hậu và xử lý khí thải xe cơ giới, giúp tỷ lệ ngày chất lượng không khí môi trường đạt chuẩn tốt tại các thành phố trọng điểm toàn quốc tăng lên vững chắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [恐怕] (kǒngpà) - e rằng, sợ rằng, có lẽ [Phó từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '恐怕' AND pinyin = 'kǒngpà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '恐怕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Động từ',
      pinyin = 'kǒngpà',
      meaning_vi = 'e rằng, sợ rằng, có lẽ',
      example_hanzi = '现在外面的风雪越来越大，今晚的户外演出恐怕要推迟了。',
      example_pinyin = 'Xiànzài wàimiàn de fēngxuě yuèláiyuè dà, jīnwǎn de hùwài yǎnchū kǒngpà yào tuīchí le.',
      example_vi = 'Hiện tại mưa tuyết bên ngoài càng lúc càng to, buổi biểu diễn ngoài trời tối nay e rằng phải hoãn lại rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '现在外面的风雪越来越大，今晚的户外演出恐怕要推迟了。', 'Xiànzài wàimiàn de fēngxuě yuèláiyuè dà, jīnwǎn de hùwài yǎnchū kǒngpà yào tuīchí le.', 'Hiện tại mưa tuyết bên ngoài càng lúc càng to, buổi biểu diễn ngoài trời tối nay e rằng phải hoãn lại rồi.', 'basic', 1),
        (v_id, '如果未能按期完成核心芯片架构的严密可靠性测试，整个新一代智能设备的量产发布计划恐怕要整体顺延一个季度。', 'Rúguǒ wèinéng ànqī wánchéng héxīn xīnpiàn jiàgòu de yánmì kěkàoxìng cèshì, zhěnggè xīn yídài zhìnéng shèbèi de liàngchǎn fābù jìhuà kǒngpà yào zhěngtǐ shùnyán yí gè jīdù.', 'Nếu không hoàn thành đúng hạn việc kiểm tra độ tin cậy nghiêm ngặt của kiến trúc chip cốt lõi, toàn bộ kế hoạch ra mắt sản xuất hàng loạt thiết bị thông minh thế hệ mới e rằng phải lùi lại một quý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [空] (kòng) - rảnh rỗi, thời gian rảnh; để trống [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '空' AND pinyin = 'kòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '空'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'kòng',
      meaning_vi = 'rảnh rỗi, thời gian rảnh; để trống',
      example_hanzi = '这个周末你如果有空，我们一起去国家博物馆看展览吧。',
      example_pinyin = 'Zhè gè zhōumò nǐ rúguǒ yǒu kòng, wǒmen yìqǐ qù Guójiā Bówùguǎn kàn zhǎnlǎn ba.',
      example_vi = 'Cuối tuần này nếu bạn có thời gian rảnh, chúng ta cùng đi Bảo tàng Quốc gia xem triển lãm nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个周末你如果有空，我们一起去国家博物馆看展览吧。', 'Zhè gè zhōumò nǐ rúguǒ yǒu kòng, wǒmen yìqǐ qù Guójiā Bówùguǎn kàn zhǎnlǎn ba.', 'Cuối tuần này nếu bạn có thời gian rảnh, chúng ta cùng đi Bảo tàng Quốc gia xem triển lãm nhé.', 'basic', 1),
        (v_id, '在繁重紧凑的高强度商务出差行程中，他特意抽空专程拜访了在当地高校从事前沿科学研究的多年老同学。', 'Zài fánzhòng jǐncòu de gāoxiēndù shāngwù chūchāi xíngchéng zhōng, tā tèyì chōukòng zhuānchéng bàifǎng le zài dāngdì gāoxiào cóngshì qiányán kēxué yánjiū de duō nián lǎo tóngxué.', 'Trong lịch trình công tác thương mại áp lực cao bận rộn dày đặc, anh ấy đã đặc biệt bớt chút thời gian rảnh cất công đến thăm người bạn học cũ nhiều năm đang làm nghiên cứu khoa học tiên phong tại trường đại học sở tại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [口语] (kǒuyǔ) - khẩu ngữ, ngôn ngữ nói [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '口语' AND pinyin = 'kǒuyǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '口语'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kǒuyǔ',
      meaning_vi = 'khẩu ngữ, ngôn ngữ nói',
      example_hanzi = '他每天早上都坚持大声朗读，口语表达越来越自然流利。',
      example_pinyin = 'Tā měitiān zǎoshang dōu jiānchí dàshēng lǎngdú, kǒuyǔ biǎodá yuèláiyuè zìrán liúlì.',
      example_vi = 'Mỗi sáng anh ấy đều kiên trì đọc to thành tiếng, khả năng diễn đạt khẩu ngữ ngày càng tự nhiên lưu loát.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他每天早上都坚持大声朗读，口语表达越来越自然流利。', 'Tā měitiān zǎoshang dōu jiānchí dàshēng lǎngdú, kǒuyǔ biǎodá yuèláiyuè zìrán liúlì.', 'Mỗi sáng anh ấy đều kiên trì đọc to thành tiếng, khả năng diễn đạt khẩu ngữ ngày càng tự nhiên lưu loát.', 'basic', 1),
        (v_id, '国际商务汉语高级考试不仅考查考生的书面文案分析理解能力，更着重评估其在跨国谈判环境下的即兴口语沟通与辩驳应变素养。', 'Guójì shāngwù Hànyǔ gāojí kǎoshì bùjǐn kǎochá kǎoshēng de shūmiàn wén’àn fēnxī lǐjiě nénglì, gèng zhuózhòng pínggū qí zài kuàguó tánpàn huánjìng xià de jíxìng kǒuyǔ gōutōng yǔ biànbó yìngbiàn sùyǎng.', 'Kỳ thi tiếng Trung thương mại quốc tế cao cấp không chỉ khảo sát năng lực đọc hiểu phân tích văn bản giấy của thí sinh, mà đặc biệt đánh giá năng lực giao tiếp khẩu ngữ ứng khẩu và ứng biến phản biện của họ trong môi trường đàm phán xuyên quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [苦] (kǔ) - đắng; cực khổ, vất vả [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '苦' AND pinyin = 'kǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '苦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'kǔ',
      meaning_vi = 'đắng; cực khổ, vất vả',
      example_hanzi = '良药苦口利于病，这碗中药虽然有点苦，但能有效退烧。',
      example_pinyin = 'Liángyào-kǔkǒu lìyú bìng, zhè wǎn zhōngyào suīrán yǒudiǎn kǔ, dàn néng yǒuxiào tuìshāo.',
      example_vi = 'Thuốc đắng dã tật, bát thuốc bắc này tuy có hơi đắng nhưng có thể hạ sốt rất hiệu quả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '良药苦口利于病，这碗中药虽然有点苦，但能有效退烧。', 'Liángyào-kǔkǒu lìyú bìng, zhè wǎn zhōngyào suīrán yǒudiǎn kǔ, dàn néng yǒuxiào tuìshāo.', 'Thuốc đắng dã tật, bát thuốc bắc này tuy có hơi đắng nhưng có thể hạ sốt rất hiệu quả.', 'basic', 1),
        (v_id, '“吃得苦中苦，方为人上人”，青年一代在求学和创业路上必须耐得住寂寞、吃得了艰辛磨难。', '“Chī de kǔzhōngkǔ, fāng wéi rénshàngrén”, qīngnián yídài zài qiúxué hé chuàngyè lùshang bìxū nài de zhù jìmò, chī de liǎo jiānxīn mónàn.', '"Chịu được cái khổ trong muôn vàn cái khổ mới có thể làm nên việc phi thường", thế hệ thanh niên trên con đường học tập và khởi nghiệp phải chịu được nỗi cô đơn và vượt qua được gian nan thử thách.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [快餐] (kuàicān) - thức ăn nhanh, đồ ăn nhanh (fast food) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '快餐' AND pinyin = 'kuàicān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '快餐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kuàicān',
      meaning_vi = 'thức ăn nhanh, đồ ăn nhanh (fast food)',
      example_hanzi = '中午工作忙得走不开，他就在办公室附近随便点了一份中式快餐。',
      example_pinyin = 'Zhōngwǔ gōngzuò máng de zǒu-bù-kāi, tā jiù zài bàngōngshì fùjìn suíbiàn diǎn le yí fèn Zhōngshì kuàicān.',
      example_vi = 'Buổi trưa công việc bận rộn không dứt ra được, anh ấy liền gọi bừa một suất cơm đồ ăn nhanh kiểu Trung Quốc ở gần văn phòng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中午工作忙得走不开，他就在办公室附近随便点了一份中式快餐。', 'Zhōngwǔ gōngzuò máng de zǒu-bù-kāi, tā jiù zài bàngōngshì fùjìn suíbiàn diǎn le yí fèn Zhōngshì kuàicān.', 'Buổi trưa công việc bận rộn không dứt ra được, anh ấy liền gọi bừa một suất cơm đồ ăn nhanh kiểu Trung Quốc ở gần văn phòng.', 'basic', 1),
        (v_id, '随着当代年轻人生活节奏的加快与健康养生意识的觉醒，注重低脂低卡、营养均衡的新型轻食中式快餐品牌迎来了爆发式增长。', 'Suízhe dāngdài niánqīngrén shēnghuó jiézòu de jiākuài yǔ jiànkāng yǎngshēng yìshí de juéxǐng, zhùzhòng dījī-dīkǎ, yíngyǎng jūnhéng de xīnxíng qīngshí Zhōngshì kuàicān pǐnpái yínglái le bàofāshì zēngzhǎng.', 'Cùng với nhịp sống hối hả của giới trẻ đương đại và sự thức tỉnh của ý thức chăm sóc sức khỏe, các thương hiệu đồ ăn nhanh kiểu Trung thanh đạm mới chú trọng ít mỡ ít calo và dinh dưỡng cân bằng đã đón nhận sự tăng trưởng bùng nổ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [快递] (kuàidì) - chuyển phát nhanh; bưu kiện chuyển phát nhanh [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '快递' AND pinyin = 'kuàidì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '快递'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'kuàidì',
      meaning_vi = 'chuyển phát nhanh; bưu kiện chuyển phát nhanh',
      example_hanzi = '快递员刚刚打电话说，我的网购包裹已经送达小区的快递驿站了。',
      example_pinyin = 'Kuàidìyuán gānggāng dǎ diànhuà shuō, wǒ de wǎnggòu bāoguǒ yǐjīng sòngdá xiǎoqū de kuàidì yìzhàn.',
      example_vi = 'Nhân viên chuyển phát nhanh vừa gọi điện báo bưu kiện mua hàng qua mạng của tôi đã được giao tới trạm nhận bưu phẩm của khu chung cư rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '快递员刚刚打电话说，我的网购包裹已经送达小区的快递驿站了。', 'Kuàidìyuán gānggāng dǎ diànhuà shuō, wǒ de wǎnggòu bāoguǒ yǐjīng sòngdá xiǎoqū de kuàidì yìzhàn.', 'Nhân viên chuyển phát nhanh vừa gọi điện báo bưu kiện mua hàng qua mạng của tôi đã được giao tới trạm nhận bưu phẩm của khu chung cư rồi.', 'basic', 1),
        (v_id, '现代智慧物流网络通过全面引入无人配送车、智能自动化分拣机器人以及无人机，实现了跨省快递“次日达”的高效履约能力。', 'Xiàndài zhìhuì wùliú wǎngluò tōngguò quánmiàn yǐnrù wúrén pèisòngchē, zhìnéng zìdònghuà fēnjiǎn jīqìrén yǐjí wúrénjī, shíxiàn le kuàshěng kuàidì “cìrì dá” de gāoxiào lǚyuē nénglì.', 'Mạng lưới logistics thông minh hiện đại thông qua việc đưa vào đồng bộ xe giao hàng không người lái, robot phân loại tự động thông minh cùng máy bay không người lái, đã hiện thực hóa năng lực giao hàng chuyển phát nhanh liên tỉnh "ngày hôm sau nhận hàng" với hiệu suất cực cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [快速] (kuàisù) - nhanh chóng, thần tốc [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '快速' AND pinyin = 'kuàisù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '快速'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'kuàisù',
      meaning_vi = 'nhanh chóng, thần tốc',
      example_hanzi = '走这条城市快速路可以避开早高峰的繁华拥堵路段。',
      example_pinyin = 'Zǒu zhè tiáo chéngshì kuàisùlù kěyǐ bìkāi zǎogāofēng de fánhuá yōngdǔ lùduàn.',
      example_vi = 'Đi theo con đường cao tốc nội đô này có thể tránh được các đoạn đường ùn tắc nhộn nhịp giờ cao điểm sáng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '走这条城市快速路可以避开早高峰的繁华拥堵路段。', 'Zǒu zhè tiáo chéngshì kuàisùlù kěyǐ bìkāi zǎogāofēng de fánhuá yōngdǔ lùduàn.', 'Đi theo con đường cao tốc nội đô này có thể tránh được các đoạn đường ùn tắc nhộn nhịp giờ cao điểm sáng.', 'basic', 1),
        (v_id, '面对突如其来的突发公共卫生事件，政府各应急职能部门迅速启动了快速响应协调联动机制。', 'Miànduì tūrúqílái de tūfā gōnggòng wèishēng shìjiàn, zhèngfǔ gè yìngjí zhínéng bùmén xùnsù qǐdòng le kuàisù xiǎngyìng xiétóng liándòng jīzhì.', 'Đối mặt với sự cố y tế công cộng bất ngờ ập tới, các cơ quan chức năng ứng phó khẩn cấp của chính phủ đã nhanh chóng kích hoạt cơ chế phản ứng nhanh phối hợp hành động đồng bộ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [困] (kùn) - buồn ngủ; mắc kẹt, vây hãm [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '困' AND pinyin = 'kùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '困'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'kùn',
      meaning_vi = 'buồn ngủ; mắc kẹt, vây hãm',
      example_hanzi = '昨晚加班写论文熬到凌晨两点，今天一整天都感觉非常困。',
      example_pinyin = 'Zuówǎn jiābān xiě lùnwén áo dào língchén liǎng diǎn, jīntiān yì zhěng tiān dōu gǎnjué fēicháng kùn.',
      example_vi = 'Tối qua thức khuya viết luận văn đến tận hai giờ sáng, hôm nay cả ngày cảm thấy vô cùng buồn ngủ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '昨晚加班写论文熬到凌晨两点，今天一整天都感觉非常困。', 'Zuówǎn jiābān xiě lùnwén áo dào língchén liǎng diǎn, jīntiān yì zhěng tiān dōu gǎnjué fēicháng kùn.', 'Tối qua thức khuya viết luận văn đến tận hai giờ sáng, hôm nay cả ngày cảm thấy vô cùng buồn ngủ.', 'basic', 1),
        (v_id, '在暴雨引发的山洪泥石流险情发生后，抢险武警官兵争分夺秒挺进灾区，成功解救出被困在孤岛上的数十名受灾群众。', 'Zài bàoyǔ yǐnfā de shānhóng níshíliú xiǎnqíng fāshēng hòu, qiǎngxiǎn wǔjǐng guānbīng zhēngfēn-duómiǎo tǐngjìn zāiqū, chénggōng jiějiù chū bèi kùn zài gūdǎo shang de shù shí míng shòuzāi qúnzhòng.', 'Sau khi hiểm họa lũ quét sạt lở bùn đất do mưa lớn gây ra xuất hiện, các cán bộ chiến sĩ cảnh sát vũ trang cứu hộ đã tranh thủ từng giây từng phút tiến vào vùng thiên tai, giải cứu thành công hàng chục người dân bị mắc kẹt trên hòn đảo cô lập.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [困难] (kùnnan) - khó khăn, trở ngại; gian nan [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '困难' AND pinyin = 'kùnnan'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '困难'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'kùnnan',
      meaning_vi = 'khó khăn, trở ngại; gian nan',
      example_hanzi = '生活中无论遇到什么样的困难，我们都要充满信心勇敢面对。',
      example_pinyin = 'Shēnghuó zhōng wúlùn yù dào shénmeyàng de kùnnan, wǒmen dōu yào chōngmǎn xìnxīn yǒnggǎn miànduì.',
      example_vi = 'Trong cuộc sống bất kể gặp phải khó khăn trắc trở như thế nào, chúng ta đều phải tràn trề tự tin dũng cảm đối mặt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '生活中无论遇到什么样的困难，我们都要充满信心勇敢面对。', 'Shēnghuó zhōng wúlùn yù dào shénmeyàng de kùnnan, wǒmen dōu yào chōngmǎn xìnxīn yǒnggǎn miànduì.', 'Trong cuộc sống bất kể gặp phải khó khăn trắc trở như thế nào, chúng ta đều phải tràn trề tự tin dũng cảm đối mặt.', 'basic', 1),
        (v_id, '在面临外部供应链技术封锁与宏观市场需求萎缩的重重困难之下，该高科技制造企业依靠自主创新实现了逆势突破。', 'Zài miànlín wàibù gōngyìngliàn jìshù fēngsuǒ yǔ hóngguān shìchǎng xūqiú wěisuō de chóngchóng kùnnan zhīxià, gāi gāokējì zhìzào qǐyè yīkào zìzhǔ chuàngxīn shíxiàn le nìshì tūpò.', 'Dưới muôn trùng khó khăn khi đối mặt với sự phong tỏa công nghệ chuỗi cung ứng bên ngoài và sự suy giảm nhu cầu thị trường vĩ mô, doanh nghiệp chế tạo công nghệ cao này dựa vào đổi mới sáng tạo độc lập đã đạt được sự bứt phá ngược dòng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [拉] (lā) - kéo, lôi, dắt; kéo (đàn violon) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '拉' AND pinyin = 'lā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '拉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'lā',
      meaning_vi = 'kéo, lôi, dắt; kéo (đàn violon)',
      example_hanzi = '门上写着“请往外拉”，请不要用力往里面推。',
      example_pinyin = 'Mén shang xiě zhe “qǐng wǎng wài lā”, qǐng bú yào yònglì wǎng lǐmiàn tuī.',
      example_vi = 'Trên cửa có ghi "Xin kéo ra ngoài", vui lòng đừng dùng sức đẩy vào trong.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '门上写着“请往外拉”，请不要用力往里面推。', 'Mén shang xiě zhe “qǐng wǎng wài lā”, qǐng bú yào yònglì wǎng lǐmiàn tuī.', 'Trên cửa có ghi "Xin kéo ra ngoài", vui lòng đừng dùng sức đẩy vào trong.', 'basic', 1),
        (v_id, '国家积极出台一系列促消费与扩内需的重磅扶持政策，旨在有效拉动民间投资增长与实体经济稳步复苏。', 'Guójiā jījí chūtái yí xìliè cù xiāofèi yǔ kuò nèixū de zhòngbàng fúchí zhèngcè, zhǐ zài yǒuxiào lādòng mínjiān tóuzī zēngzhǎng yǔ shítǐ jīngjì wěnbù fùsū.', 'Nhà nước tích cực ban hành hàng loạt chính sách hỗ trợ trọng điểm nhằm thúc đẩy tiêu dùng và mở rộng cầu nội địa, hướng tới việc kéo theo tăng trưởng đầu tư tư nhân và sự phục hồi vững chắc của nền kinh tế thực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [垃圾] (lājī) - rác, rác thải [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '垃圾' AND pinyin = 'lājī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '垃圾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lājī',
      meaning_vi = 'rác, rác thải',
      example_hanzi = '请把喝完的饮料塑料瓶扔进那个可回收垃圾桶里。',
      example_pinyin = 'Qǐng bǎ hē wán de yǐnliào sùliàopíng rēng jìn nà gè kě-huíshōu lājītǒng lǐ.',
      example_vi = 'Xin hãy vứt chai nhựa nước giải khát đã uống xong vào thùng rác tái chế kia.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把喝完的饮料塑料瓶扔进那个可回收垃圾桶里。', 'Qǐng bǎ hē wán de yǐnliào sùliàopíng rēng jìn nà gè kě-huíshōu lājītǒng lǐ.', 'Xin hãy vứt chai nhựa nước giải khát đã uống xong vào thùng rác tái chế kia.', 'basic', 1),
        (v_id, '城市推行生活垃圾分类减量化与资源化无害化处理，是推进国家生态文明建设与绿色低碳循环发展的关键抓手。', 'Chéngshì tuīxíng shēnghuó lājī fēnlèi jiǎnliànghuà yǔ zīyuánhuà wúhàihuà chǔlǐ, shì tuījìn guójiā shēngtài wénmíng jiànshè yǔ lǜsè dītàn xúnhuán fāzhǎn de guānjiàn zhuāshǒu.', 'Đô thị đẩy mạnh phân loại rác thải sinh hoạt giảm thiểu về lượng và xử lý vô hại hóa tận dụng tài nguyên chính là đòn bẩy then chốt để thúc đẩy xây dựng văn minh sinh thái quốc gia và phát triển kinh tế tuần hoàn xanh phát thải thấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [辣] (là) - cay [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '辣' AND pinyin = 'là'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '辣'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'là',
      meaning_vi = 'cay',
      example_hanzi = '四川麻辣火锅的味道虽然很辣，但非常过瘾美味。',
      example_pinyin = 'Sìchuān málà huǒguō de wèidao suīrán hěn là, dàn fēicháng guòyǐn měiwèi.',
      example_vi = 'Mùi vị lẩu cay tê Tứ Xuyên tuy rằng rất cay nhưng vô cùng đã miệng và thơm ngon.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '四川麻辣火锅的味道虽然很辣，但非常过瘾美味。', 'Sìchuān málà huǒguō de wèidao suīrán hěn là, dàn fēicháng guòyǐn měiwèi.', 'Mùi vị lẩu cay tê Tứ Xuyên tuy rằng rất cay nhưng vô cùng đã miệng và thơm ngon.', 'basic', 1),
        (v_id, '在川菜与湘菜等特色地方菜系向全国快速推广的过程中，餐饮企业根据不同地域消费者的饮食喜好推出了微辣与微麻等多元改良口味。', 'Zài Chuāncài yǔ Xiāngcài děng tèsè dìfāng càixì xiàng quánguó kuàisù tuīguǎng de guòchéng zhōng, cānyǐn qǐyè gēnjù bùtóng dìyù xiāofèizhě de yǐnshí xǐhào tuīchū le wēilà yǔ wēimá děng duōyuán gǎiliáng kǒuwèi.', 'Trong quá trình các hệ thống ẩm thực địa phương đặc trưng như món Tứ Xuyên và món Hồ Nam được quảng bá rộng rãi ra toàn quốc, các doanh nghiệp ăn uống đã căn cứ theo sở thích ẩm thực của người tiêu dùng từng vùng miền để đưa ra các khẩu vị cải biên đa dạng như cay nhẹ và tê nhẹ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [来不及] (láibují) - không kịp, không đủ thời gian [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '来不及' AND pinyin = 'láibují'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '来不及'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'láibují',
      meaning_vi = 'không kịp, không đủ thời gian',
      example_hanzi = '早上出门太匆忙，我甚至连早饭都来不及吃了。',
      example_pinyin = 'Zǎoshang chūmén tài cōngmáng, wǒ shènzhì lián zǎofàn dōu láibují chī le.',
      example_vi = 'Sáng nay ra khỏi nhà quá vội vàng, tôi thậm chí ngay cả cơm sáng cũng không kịp ăn nữa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '早上出门太匆忙，我甚至连早饭都来不及吃了。', 'Zǎoshang chūmén tài cōngmáng, wǒ shènzhì lián zǎofàn dōu láibují chī le.', 'Sáng nay ra khỏi nhà quá vội vàng, tôi thậm chí ngay cả cơm sáng cũng không kịp ăn nữa.', 'basic', 1),
        (v_id, '在数字化新产品快速迭代周期中，若不能及早预见市场需求风向变化，企业后续调整战略布局将完全来不及追赶先机。', 'Zài shùzìhuà xīn chǎnpǐn kuàisù diédài zhōuqī zhōng, ruò bù néng jízǎo yùjiàn shìchǎng xūqiú fēngxiàng biànhuà, qǐyè hòuxù tiáozhěng zhànlüè bùjú jiāng wánquán láibují zhuīgǎn xiānjī.', 'Trong chu kỳ lặp lại nhanh chóng của sản phẩm số mới, nếu không thể thấy trước từ sớm sự đổi chiều trong nhu cầu thị trường, việc doanh nghiệp điều chỉnh bố cục chiến lược sau đó sẽ hoàn toàn không kịp bắt lấy thời cơ đi đầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [来得及] (láidejí) - kịp, còn kịp thời gian [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '来得及' AND pinyin = 'láidejí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '来得及'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'láidejí',
      meaning_vi = 'kịp, còn kịp thời gian',
      example_hanzi = '距离高铁发车还有一个多小时，我们现在慢慢走去候车厅完全来得及。',
      example_pinyin = 'Jùlí gāotiě fāchē hái yǒu yí gè duō xiǎoshí, wǒmen xiànzài mànmàn zǒu qù hòuchētīng wánquán láidejí.',
      example_vi = 'Cách lúc tàu cao tốc khởi hành còn hơn một tiếng đồng hồ nữa, bây giờ chúng ta thong thả đi tới phòng chờ tàu hoàn toàn còn kịp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '距离高铁发车还有一个多小时，我们现在慢慢走去候车厅完全来得及。', 'Jùlí gāotiě fāchē hái yǒu yí gè duō xiǎoshí, wǒmen xiànzài mànmàn zǒu qù hòuchētīng wánquán láidejí.', 'Cách lúc tàu cao tốc khởi hành còn hơn một tiếng đồng hồ nữa, bây giờ chúng ta thong thả đi tới phòng chờ tàu hoàn toàn còn kịp.', 'basic', 1),
        (v_id, '只要项目团队迅速调配精干研发骨干并优化系统集成流程，赶在下周客户评估截止日前完成升级测试完全来得及。', 'Zhǐyào xiàngmù tuánduì xùnsù tiáopèi jīnggàn yánfā gǔgàn bìng yōuhuà xìtǒng jíchéng liúchéng, gǎn zài xià zhōu kèhù pínggū jiézhǐ rì qián wánchéng shēngjí cèshì wánquán láidejí.', 'Chỉ cần đội ngũ dự án nhanh chóng điều động các cán bộ R&D nòng cốt tinh anh và tối ưu hóa quy trình tích hợp hệ thống, thì việc chạy kịp hoàn thành kiểm thử nâng cấp trước thời hạn chót đánh giá của khách hàng tuần sau hoàn toàn còn kịp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [懒] (lǎn) - lười biếng, lười nhác [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '懒' AND pinyin = 'lǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '懒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'lǎn',
      meaning_vi = 'lười biếng, lười nhác',
      example_hanzi = '他平时太懒了，换下来的脏衣服总是堆在洗衣机旁好几天不洗。',
      example_pinyin = 'Tā píngshí tài lǎn le, huàn xiàlai de zāng yīfu zǒngshì duī zài xǐyījī páng hǎo jǐ tiān bù xǐ.',
      example_vi = 'Anh ấy ngày thường lười quá, quần áo bẩn thay ra luôn vứt đống cạnh máy giặt cả mấy ngày không giặt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他平时太懒了，换下来的脏衣服总是堆在洗衣机旁好几天不洗。', 'Tā píngshí tài lǎn le, huàn xiàlai de zāng yīfu zǒngshì duī zài xǐyījī páng hǎo jǐ tiān bù xǐ.', 'Anh ấy ngày thường lười quá, quần áo bẩn thay ra luôn vứt đống cạnh máy giặt cả mấy ngày không giặt.', 'basic', 1),
        (v_id, '在激烈的学术研究与创新攻关中，切忌贪图安逸和思想懒惰，必须持之以恒地追踪国际前沿科研动态。', 'Zài jīliè de xuéshù yánjiū yǔ chuàngxīn gōngguān zhōng, qièjì tāntú ānyì hé sīxiǎng lǎnduò, bìxū chízhīyǐhéng de zhuīzōng guójì qiányán kēyán dòngtài.', 'Trong công tác nghiên cứu học thuật và đổi mới sáng tạo khốc liệt, tuyệt đối tránh ham muốn an nhàn và lười biếng tư duy, bắt buộc phải kiên trì bền bỉ theo dõi sát sao mọi diễn biến nghiên cứu khoa học tiên phong quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [浪费] (làngfèi) - lãng phí [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '浪费' AND pinyin = 'làngfèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '浪费'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'làngfèi',
      meaning_vi = 'lãng phí',
      example_hanzi = '我们在食堂打饭时应当按量取餐，千万不要浪费粮食。',
      example_pinyin = 'Wǒmen zài shítáng dǎ fàn shí yīngdāng àn liàng qǔ cān, qiānwàn bú yào làngfèi liángshi.',
      example_vi = 'Chúng ta khi lấy cơm ở căng-tin nên lấy vừa đủ lượng dùng, tuyệt đối không được lãng phí lương thực.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们在食堂打饭时应当按量取餐，千万不要浪费粮食。', 'Wǒmen zài shítáng dǎ fàn shí yīngdāng àn liàng qǔ cān, qiānwàn bú yào làngfèi liángshi.', 'Chúng ta khi lấy cơm ở căng-tin nên lấy vừa đủ lượng dùng, tuyệt đối không được lãng phí lương thực.', 'basic', 1),
        (v_id, '推行精益生产与敏捷化供应链管理的核心宗旨，就是消除各个生产环节一切非增值的冗余与资源浪费。', 'Tuīxíng jīngyì shēngchǎn yǔ mǐnjiéhuà gōngyìngliàn guǎnlǐ de héxīn zōngzhǐ, jiùshì xiāochú gègè shēngchǎn huánjié yíqiè fēi zēngzhí de rǒngyú yǔ zīyuán làngfèi.', 'Tôn chỉ cốt lõi của việc đẩy mạnh sản xuất tinh gọn và quản lý chuỗi cung ứng linh hoạt chính là xóa bỏ mọi sự dư thừa không gia tăng giá trị và sự lãng phí tài nguyên ở từng mắt xích sản xuất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [浪漫] (làngmàn) - lãng mạn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '浪漫' AND pinyin = 'làngmàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '浪漫'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'làngmàn',
      meaning_vi = 'lãng mạn',
      example_hanzi = '漫步在巴黎塞纳河畔的黄昏微风中，感觉格外浪漫惬意。',
      example_pinyin = 'Mànbù zài Bālí Sè’nà Hé pàn de huánghūn wēifēng zhōng, gǎnjué géwài làngmàn qièyì.',
      example_vi = 'Rảo bước trong làn gió chiều tà bên bờ sông Seine ở Paris, cảm thấy vô cùng lãng mạn và thoải mái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '漫步在巴黎塞纳河畔的黄昏微风中，感觉格外浪漫惬意。', 'Mànbù zài Bālí Sè’nà Hé pàn de huánghūn wēifēng zhōng, gǎnjué géwài làngmàn qièyì.', 'Rảo bước trong làn gió chiều tà bên bờ sông Seine ở Paris, cảm thấy vô cùng lãng mạn và thoải mái.', 'basic', 1),
        (v_id, '这部现实主义电影巧妙融合了细腻动人的诗意表达与浪漫情怀，深刻展现了普通人在时代洪流中对美好生活的不懈追求。', 'Zhè bù xiànshízhǔyì diànyǐng qiǎomiào rónghé le xìnì dòngrén de shīyì biǎodá yǔ làngmàn qínghuái, shēnkè zhǎnxiàn le pǔtōng rén zài shídài hóngliú zhōng duì měihǎo shēnghuó de búxiè zhuīqiú.', 'Bộ phim điện ảnh theo chủ nghĩa hiện thực này đã khéo léo dung hợp cách biểu đạt thi vị tinh tế xúc động lòng người cùng cảm xúc lãng mạn, phản ánh sâu sắc sự theo đuổi không ngừng nghỉ cuộc sống tươi đẹp của những người bình dị giữa dòng chảy thời đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [老虎] (lǎohǔ) - con hổ, hùm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '老虎' AND pinyin = 'lǎohǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '老虎'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lǎohǔ',
      meaning_vi = 'con hổ, hùm',
      example_hanzi = '动物园里的东北虎体型极其健壮威武，被称为森林百兽之王。',
      example_pinyin = 'Dòngwùyuán lǐ de Dōngběihǔ tǐxíng jíqí jiànzhuàng wēiwǔ, bèi chēng wéi sēnlín bǎishòuzhīwáng.',
      example_vi = 'Hổ Đông Bắc trong vườn thú thể hình vô cùng tráng kiện uy vũ, được mệnh danh là chúa tể muôn loài nơi rừng xanh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '动物园里的东北虎体型极其健壮威武，被称为森林百兽之王。', 'Dòngwùyuán lǐ de Dōngběihǔ tǐxíng jíqí jiànzhuàng wēiwǔ, bèi chēng wéi sēnlín bǎishòuzhīwáng.', 'Hổ Đông Bắc trong vườn thú thể hình vô cùng tráng kiện uy vũ, được mệnh danh là chúa tể muôn loài nơi rừng xanh.', 'basic', 1),
        (v_id, '国家林业草原部门设立了东北虎豹国家公园，通过科学栖息地生态修复，使野生东北虎种群数量实现了稳步恢复增长。', 'Guójiā Línyè Cǎoyuán bùmén shèlì le Dōngběihǔ-bào Guójiā Gōngyuán, tōngguò kēxué qīxīdì shēngtài xiūfù, shǐ yěshēng Dōngběihǔ zhǒngqún shùliàng shíxiàn le wěnbù huìfù zēngzhǎng.', 'Cơ quan lâm nghiệp và đồng cỏ quốc gia đã thành lập Vườn quốc gia Hổ Báo Đông Bắc, thông qua phục hồi sinh thái môi trường sống khoa học, giúp số lượng quần thể hổ Đông Bắc hoang dã đạt được sự phục hồi tăng trưởng vững chắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [老家] (lǎojiā) - quê quán, quê hương, nhà xưa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '老家' AND pinyin = 'lǎojiā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '老家'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lǎojiā',
      meaning_vi = 'quê quán, quê hương, nhà xưa',
      example_hanzi = '他虽然在北京工作多年，但他的老家在美丽的江南水乡苏州。',
      example_pinyin = 'Tā suīrán zài Běijīng gōngzuò duō nián, dàn tā de lǎojiā zài měilì de Jiāngnán shuǐxiāng Sūzhōu.',
      example_vi = 'Anh ấy tuy làm việc ở Bắc Kinh nhiều năm, nhưng quê hương của anh ấy ở vùng sông nước Giang Nam Tô Châu xinh đẹp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他虽然在北京工作多年，但他的老家在美丽的江南水乡苏州。', 'Tā suīrán zài Běijīng gōngzuò duō nián, dàn tā de lǎojiā zài měilì de Jiāngnán shuǐxiāng Sūzhōu.', 'Anh ấy tuy làm việc ở Bắc Kinh nhiều năm, nhưng quê hương của anh ấy ở vùng sông nước Giang Nam Tô Châu xinh đẹp.', 'basic', 1),
        (v_id, '春节长假期间他专程带全家人回到阔别已久的农村老家探望乡亲，亲身感受到了家乡在新农村建设中发生的翻天覆地巨变。', 'Chūnjié chángjià qījiān tā zhuānchéng dài quán jiā rén huí dào kuòbié-yǐjiǔ de nóngcūn lǎojiā tànwàng xiāngqīn, qīnshēn gǎnshòu dào le jiāxiāng zài xīn nóngcūn jiànshè zhōng fāshēng de fāntiān-fùdì jùbiàn.', 'Trong kỳ nghỉ Tết dài ngày anh ấy đã cất công đưa cả gia đình trở về quê nhà nông thôn đã xa cách bấy lâu để thăm hỏi bà con chòm xóm, đích thân cảm nhận những thay đổi long trời lở đất của quê hương trong công cuộc xây dựng nông thôn mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [老年] (lǎonián) - tuổi già, tuổi xế chiều, người cao tuổi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '老年' AND pinyin = 'lǎonián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '老年'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lǎonián',
      meaning_vi = 'tuổi già, tuổi xế chiều, người cao tuổi',
      example_hanzi = '爷爷退休后参加了社区的老年合唱团，每天生活十分丰富充实。',
      example_pinyin = 'Yéye tuìxiū hòu cānjiā le shèqū de lǎonián héchàngtuán, měitiān shēnghuó shífēn fēngfù chōngshí.',
      example_vi = 'Sau khi nghỉ hưu ông nội tham gia vào đoàn hợp xướng người cao tuổi của khu dân cư, cuộc sống mỗi ngày vô cùng phong phú bổ ích.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爷爷退休后参加了社区的老年合唱团，每天生活十分丰富充实。', 'Yéye tuìxiū hòu cānjiā le shèqū de lǎonián héchàngtuán, měitiān shēnghuó shífēn fēngfù chōngshí.', 'Sau khi nghỉ hưu ông nội tham gia vào đoàn hợp xướng người cao tuổi của khu dân cư, cuộc sống mỗi ngày vô cùng phong phú bổ ích.', 'basic', 1),
        (v_id, '面对人口老龄化国家战略要求，政府积极完善居家社区机构相协调、医养康养相结合的多层次老年养老服务体系。', 'Miànduì rénkǒu lǎolínghuà guójiā zhànlüè yāoqiú, zhèngfǔ jījí wánshàn jūjiā shèqū jīgòu xiāng xiétóng, yī-yǎng kāng-yǎng xiāng jiéhé de duōcéngcì lǎonián yǎnglǎo fúwù tǐxì.', 'Đối mặt với yêu cầu của chiến lược quốc gia về già hóa dân số, chính phủ tích cực hoàn thiện hệ thống dịch vụ dưỡng lão người cao tuổi đa tầng nấc kết hợp hiệp đồng giữa gia đình, cộng đồng và viện dưỡng lão, gắn kết giữa y tế chăm sóc và nghỉ dưỡng phục hồi chức năng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [老是] (lǎoshì) - luôn luôn, cứ mãi (mang sắc thái phàn nàn nhẹ) [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '老是' AND pinyin = 'lǎoshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '老是'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'lǎoshì',
      meaning_vi = 'luôn luôn, cứ mãi (mang sắc thái phàn nàn nhẹ)',
      example_hanzi = '你老是边看电视边吃零食，这样很容易引起消化不良。',
      example_pinyin = 'Nǐ lǎoshì biān kàn diànshì biān chī língshí, zhèyàng hěn róngyì yǐnqǐ xiāohuà bùliáng.',
      example_vi = 'Bạn cứ vừa xem tivi vừa ăn đồ ăn vặt mãi, như vậy rất dễ dẫn tới khó tiêu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你老是边看电视边吃零食，这样很容易引起消化不良。', 'Nǐ lǎoshì biān kàn diànshì biān chī língshí, zhèyàng hěn róngyì yǐnqǐ xiāohuà bùliáng.', 'Bạn cứ vừa xem tivi vừa ăn đồ ăn vặt mãi, như vậy rất dễ dẫn tới khó tiêu.', 'basic', 1),
        (v_id, '如果一个团队在遇到挫折时老是习惯性推卸责任而非严谨复盘反省，那么任何宏大的商业战略目标都将沦为空谈。', 'Rúguǒ yí gè tuánduì zài yù dào cuòzhé shí lǎoshì xíguànxìng tuīxiè zérèn ér fēi yánjǐn fùpán fǎnxǐng, nàme rènhé hóngdà de shāngyè zhànlüè mùbiāo dōu jiāng lúnwéi kōngtán.', 'Nếu một đội ngũ khi gặp phải thất bại cứ có thói quen đùn đẩy trách nhiệm thay vì nghiêm túc đánh giá rút kinh nghiệm lại, thì bất kỳ mục tiêu chiến lược thương mại to tát nào cũng sẽ trở thành lời nói suông.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [冷静] (lěngjìng) - bình tĩnh, điềm tĩnh [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '冷静' AND pinyin = 'lěngjìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '冷静'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'lěngjìng',
      meaning_vi = 'bình tĩnh, điềm tĩnh',
      example_hanzi = '遇到突发紧急危险情况时，首先要保持冷静，千万不要慌张。',
      example_pinyin = 'Yù dào tūfā jǐnjí wēixiǎn qíngkuàng shí, shǒuxiān yào bǎochí lěngjìng, qiānwàn bú yào huāngzhāng.',
      example_vi = 'Khi gặp phải tình huống khẩn cấp nguy hiểm bất ngờ, trước hết phải giữ bình tĩnh, tuyệt đối không được hoảng loạn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '遇到突发紧急危险情况时，首先要保持冷静，千万不要慌张。', 'Yù dào tūfā jǐnjí wēixiǎn qíngkuàng shí, shǒuxiān yào bǎochí lěngjìng, qiānwàn bú yào huāngzhāng.', 'Khi gặp phải tình huống khẩn cấp nguy hiểm bất ngờ, trước hết phải giữ bình tĩnh, tuyệt đối không được hoảng loạn.', 'basic', 1),
        (v_id, '在金融市场暴跌恐慌蔓延的极端行情下，成熟理性的专业投资机构展现出过人的冷静定力，逆向布局被错杀的优质核心资产。', 'Zài jīnróng shìchǎng bàodiē kǒnghuāng mànyán de jíduān hángqíng xià, chéngshú lǐxìng de zhuānyè tóuzī jīgòu zhǎnxiàn chū guòrén de lěngjìng dìnglì, nìxiàng bùjú bèi cuòshā de yōuzhì héxīn zīchǎn.', 'Dưới tình trạng thị trường cực đoan khi nỗi hoảng loạn bán tháo trên thị trường tài chính lan rộng, tổ chức đầu tư chuyên nghiệp chín chắn lý tính đã phô diễn định lực điềm tĩnh hơn người, đầu tư ngược chiều vào các tài sản cốt lõi chất lượng cao bị định giá sai lầm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [理发] (lǐfà) - cắt tóc, hớt tóc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '理发' AND pinyin = 'lǐfà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '理发'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'lǐfà',
      meaning_vi = 'cắt tóc, hớt tóc',
      example_hanzi = '他的头发太长了，下午准备去小区门口的理发店理发。',
      example_pinyin = 'Tā de tóufa tài cháng le, xiàwǔ zhǔnbèi qù xiǎoqū ménkǒu de lǐfàdiàn lǐfà.',
      example_vi = 'Tóc của anh ấy dài quá rồi, buổi chiều chuẩn bị ra tiệm cắt tóc ở cổng khu chung cư để cắt tóc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他的头发太长了，下午准备去小区门口的理发店理发。', 'Tā de tóufa tài cháng le, xiàwǔ zhǔnbèi qù xiǎoqū ménkǒu de lǐfàdiàn lǐfà.', 'Tóc của anh ấy dài quá rồi, buổi chiều chuẩn bị ra tiệm cắt tóc ở cổng khu chung cư để cắt tóc.', 'basic', 1),
        (v_id, '农历二月初二俗称“龙抬头”，依照中国传统民俗习惯，许多老百姓在这一天纷纷前往理发馆理发祈求一年好彩头。', 'Nónglì èr yuè chū’èr súchēng “Lóng táitóu”, yīzhào Zhōngguó chuántǒng mínsú xíguàn, xǔduō lǎobǎixìng zài zhè yì tiān fēnfēn qiánwǎng lǐfàguǎn lǐfà qǐqiú yì nián hǎo cǎitóu.', 'Ngày mùng 2 tháng 2 âm lịch thường gọi là "Rồng ngẩng đầu", chiếu theo phong tục tập quán truyền thống Trung Hoa, đông đảo người dân vào ngày này tấp nập đi tiệm cắt tóc để cắt tóc cầu mong cả năm may mắn hanh thông.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [理解] (lǐjiě) - thấu hiểu, hiểu rõ; sự thấu cảm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '理解' AND pinyin = 'lǐjiě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '理解'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'lǐjiě',
      meaning_vi = 'thấu hiểu, hiểu rõ; sự thấu cảm',
      example_hanzi = '老师非常耐心地用生动的实例帮助同学们理解这个复杂的语法难点。',
      example_pinyin = 'Lǎoshī fēicháng nàixīn de yòng shēngdòng de shílì bāngzhù tóngxuémen lǐjiě zhè gè fùzá de yǔfǎ nándiǎn.',
      example_vi = 'Thầy giáo rất kiên nhẫn dùng những ví dụ thực tế sinh động giúp các bạn học sinh hiểu được điểm ngữ pháp khó phức tạp này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师非常耐心地用生动的实例帮助同学们理解这个复杂的语法难点。', 'Lǎoshī fēicháng nàixīn de yòng shēngdòng de shílì bāngzhù tóngxuémen lǐjiě zhè gè fùzá de yǔfǎ nándiǎn.', 'Thầy giáo rất kiên nhẫn dùng những ví dụ thực tế sinh động giúp các bạn học sinh hiểu được điểm ngữ pháp khó phức tạp này.', 'basic', 1),
        (v_id, '在跨文化国际商务谈判中，双方应当建立在相互尊重与深刻理解彼此商业文化背景与利益诉求的坚实基石之上。', 'Zài kuà-wénhuà guójì shāngwù tánpàn zhōng, shuāngfāng yīngdāng jiànlì zài xiānghù zūnzhòng yǔ shēnkè lǐjiě bǐcǐ shāngyè wénhuà bèijǐng yǔ lìyì sùqiú de jiānshí jīshí zhīshàng.', 'Trong đàm phán thương mại quốc tế đa văn hóa, hai bên cần thiết lập dựa trên hòn đá tảng vững chãi của sự tôn trọng lẫn nhau và thấu hiểu sâu sắc bối cảnh văn hóa kinh doanh cùng nguyện vọng lợi ích của đôi bên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [礼貌] (lǐmào) - lễ phép, lịch sự; phép lịch sự [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '礼貌' AND pinyin = 'lǐmào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '礼貌'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'lǐmào',
      meaning_vi = 'lễ phép, lịch sự; phép lịch sự',
      example_hanzi = '见到长辈和老师时主动问好，是一种懂礼貌的良好品格。',
      example_pinyin = 'Jiàn dào zhǎngbèi hé lǎoshī shí zhǔdòng wènhǎo, shì yì zhǒng dǒng lǐmào de liánghǎo pǐngé.',
      example_vi = 'Khi gặp người lớn tuổi và thầy cô chủ động chào hỏi là một phẩm cách tốt đẹp biết lễ phép.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '见到长辈和老师时主动问好，是一种懂礼貌的良好品格。', 'Jiàn dào zhǎngbèi hé lǎoshī shí zhǔdòng wènhǎo, shì yì zhǒng dǒng lǐmào de liánghǎo pǐngé.', 'Khi gặp người lớn tuổi và thầy cô chủ động chào hỏi là một phẩm cách tốt đẹp biết lễ phép.', 'basic', 1),
        (v_id, '客服代表在面对客户情绪激动的咨询投诉时，始终保持言辞礼貌严谨并专业高效地化解客户疑虑，赢得了客户的尊重。', 'Kèfù dàibiǎo zài miànduì kèhù qíngxù jīdòng de zīxún tóusù shí, shǐzhōng bǎochí yáncí lǐmào yánjǐn bìng zhuānyè gāoxiào de huàjiě kèhù yílǜ, yíngdé le kèhù de zūnzhòng.', 'Đại diện chăm sóc khách hàng khi đối mặt với những khiếu nại thắc mắc với cảm xúc bức xúc của khách hàng, luôn giữ lời lẽ lịch thiệp cẩn trọng và giải tỏa mối ngờ vực của khách hàng một cách chuyên nghiệp hiệu quả, giành được sự tôn trọng của khách hàng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [理想] (lǐxiǎng) - lý tưởng, hoài bão; lý tưởng, hoàn mỹ [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '理想' AND pinyin = 'lǐxiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '理想'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'lǐxiǎng',
      meaning_vi = 'lý tưởng, hoài bão; lý tưởng, hoàn mỹ',
      example_hanzi = '他从小立志成为一名救死扶伤的优秀医生，如今终于实现了自己的崇高理想。',
      example_pinyin = 'Tā cóngxiǎo lìzhì chéngwéi yì míng jiùsǐ-fúshāng de yōuxiù yīshēng, rújīn zhōngyú shíxiàn le zìjǐ de chónggāo lǐxiǎng.',
      example_vi = 'Từ nhỏ anh ấy đã lập chí trở thành một bác sĩ giỏi cứu người giúp đời, ngày nay cuối cùng đã hiện thực hóa được lý tưởng cao đẹp của mình.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他从小立志成为一名救死扶伤的优秀医生，如今终于实现了自己的崇高理想。', 'Tā cóngxiǎo lìzhì chéngwéi yì míng jiùsǐ-fúshāng de yōuxiù yīshēng, rújīn zhōngyú shíxiàn le zìjǐ de chónggāo lǐxiǎng.', 'Từ nhỏ anh ấy đã lập chí trở thành một bác sĩ giỏi cứu người giúp đời, ngày nay cuối cùng đã hiện thực hóa được lý tưởng cao đẹp của mình.', 'basic', 1),
        (v_id, '这家新型研发中心拥有世界先进的超净实验装备与一流的科学家团队，是青年科研工作者施展才华抱负的最理想平台。', 'Zhè jiā xīnxíng yánfā zhōngxīn yōngyǒu shìjiè xiānjìn de chāojìng shíyàn zhuāngbèi yǔ yīliú de kēxuéjiā tuánduì, shì qīngnián kēyán gōngzuòzhě shīzhǎn cáihuá bàofù de zuì lǐxiǎng píngtái.', 'Trung tâm R&D kiểu mới này sở hữu thiết bị thực nghiệm siêu sạch tiên tiến thế giới cùng đội ngũ nhà khoa học hạng nhất, là bệ phóng lý tưởng nhất để các cán bộ nghiên cứu trẻ thi thố tài năng hoài bão.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [厉害] (lìhai) - lợi hại, xuất chúng; dữ dội, nghiêm trọng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '厉害' AND pinyin = 'lìhai'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '厉害'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'lìhai',
      meaning_vi = 'lợi hại, xuất chúng; dữ dội, nghiêm trọng',
      example_hanzi = '他学中文才短短半年就能流畅地跟中国人交流，真是太厉害了！',
      example_pinyin = 'Tā xué Zhōngwén cái duǎnduǎn bàn nián jiù néng liúchàng de gēn Zhōngguórén jiāoliú, zhēn shì tài lìhai le!',
      example_vi = 'Anh ấy học tiếng Trung mới vỏn vẹn nửa năm mà đã có thể giao tiếp trôi chảy với người Trung Quốc, quả thật quá lợi hại!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他学中文才短短半年就能流畅地跟中国人交流，真是太厉害了！', 'Tā xué Zhōngwén cái duǎnduǎn bàn nián jiù néng liúchàng de gēn Zhōngguórén jiāoliú, zhēn shì tài lìhai le!', 'Anh ấy học tiếng Trung mới vỏn vẹn nửa năm mà đã có thể giao tiếp trôi chảy với người Trung Quốc, quả thật quá lợi hại!', 'basic', 1),
        (v_id, '受今年第十六号超强台风正面袭击影响，沿海局部地区出现了极其厉害的风暴潮并引发大面积停电险情。', 'Shòu jīnnián dì shíliù hào chāoqiáng táifēng zhèngmiàn xíjī yǐngxiǎng, yánhǎi júbù dìqū chūxiàn le jíqí lìhai de fēngbàocháo bìng yǐnfā dà miànjī tíngdiàn xiǎnqíng.', 'Chịu ảnh hưởng từ cú đổ bộ trực diện của cơn siêu bão số 16 năm nay, các khu vực ven biển cục bộ đã xuất hiện đợt triều cường bão cực kỳ dữ dội và gây ra sự cố mất điện trên diện rộng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [力气] (lìqi) - sức lực, hơi sức [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '力气' AND pinyin = 'lìqi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '力气'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lìqi',
      meaning_vi = 'sức lực, hơi sức',
      example_hanzi = '这个实木大书柜实在太重了，我一个人使出浑身力气也挪不动它。',
      example_pinyin = 'Zhè gè shímù dà shūguì shízài tài zhòng le, wǒ yí gè rén shǐ chū húnshēn lìqi yě nuó budòng tā.',
      example_vi = 'Chiếc tủ sách gỗ tự nhiên lớn này thực sự quá nặng, một mình tôi dồn hết sức lực khắp người cũng không dịch chuyển nổi nó.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个实木大书柜实在太重了，我一个人使出浑身力气也挪不动它。', 'Zhè gè shímù dà shūguì shízài tài zhòng le, wǒ yí gè rén shǐ chū húnshēn lìqi yě nuó budòng tā.', 'Chiếc tủ sách gỗ tự nhiên lớn này thực sự quá nặng, một mình tôi dồn hết sức lực khắp người cũng không dịch chuyển nổi nó.', 'basic', 1),
        (v_id, '国家为了从根本上攻克关键芯片光刻机“卡脖子”技术难关，集中了全国高校、科研院所和领军企业的全部优势科研力气实施大兵团协同作战。', 'Guójiā wèile cóng gēnběn shang gōngkè guānjiàn xīnpiàn guāngkèjī “kǎ bǎngzi” jìshù nánguān, jízhōng le quánguó gāoxiào, kēyán yuànsuǒ hé lǐngjūn qǐyè de quánbù yōushì kēyán lìqi shíshī dà bīngtuán xiétóng zuòzhàn.', 'Nhà nước để giải quyết triệt để từ gốc rễ bài toán hóc búa "nghẽn cổ chai" về công nghệ máy quang khắc chip then chốt, đã tập trung toàn bộ nguồn lực sức mạnh nghiên cứu ưu thế của các trường đại học, viện nghiên cứu và doanh nghiệp đầu ngành toàn quốc để thực thi tác chiến hiệp đồng quy mô lớn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [例如] (lìrú) - ví dụ như, chẳng hạn như [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '例如' AND pinyin = 'lìrú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '例如'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'lìrú',
      meaning_vi = 'ví dụ như, chẳng hạn như',
      example_hanzi = '中国有许多风景秀丽的名山大川，例如泰山、黄山和长江三峡。',
      example_pinyin = 'Zhōngguó yǒu xǔduō fēngjǐng xiùlì de míngshān-dàchuān, lìrú Tàishān, Huángshān hé Cháng Jiāng Sānxiá.',
      example_vi = 'Trung Quốc có rất nhiều danh lam thắng cảnh núi non sông nước tươi đẹp, ví dụ như Thái Sơn, Hoàng Sơn và Tam Hiệp sông Trường Giang.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国有许多风景秀丽的名山大川，例如泰山、黄山和长江三峡。', 'Zhōngguó yǒu xǔduō fēngjǐng xiùlì de míngshān-dàchuān, lìrú Tàishān, Huángshān hé Cháng Jiāng Sānxiá.', 'Trung Quốc có rất nhiều danh lam thắng cảnh núi non sông nước tươi đẹp, ví dụ như Thái Sơn, Hoàng Sơn và Tam Hiệp sông Trường Giang.', 'basic', 1),
        (v_id, '新兴数字经济涵盖了多元化商业形态，例如云计算基础设施服务、基于大语言模型的人工智能应用以及跨国跨境数字电商物流。', 'Xīnxīng shùzì jīngjì hángài le duōyuánhuà shāngyè xíngtài, lìrú yúnjìsuàn jīchǔ shèshī fúwù, jīyú dà yǔyán móxíng de réngōng zhìnéng yìngyòng yǐjí kuàguó kuàjìng shùzì diànshāng wùliú.', 'Nền kinh tế số mới nổi bao gồm nhiều hình thái thương mại đa dạng hóa, ví dụ như dịch vụ cơ sở hạ tầng điện toán đám mây, các ứng dụng trí tuệ nhân tạo dựa trên mô hình ngôn ngữ lớn cũng như logistics thương mại điện tử số xuyên quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [例子] (lìzi) - ví dụ, tấm gương, thí dụ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '例子' AND pinyin = 'lìzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '例子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lìzi',
      meaning_vi = 'ví dụ, tấm gương, thí dụ',
      example_hanzi = '老师在黑板上举了一个非常通俗易懂的生活例子来说明物理定律。',
      example_pinyin = 'Lǎoshī zài hēibǎn shang jǔ le yí gè fēicháng tōngsú-yìdǒng de shēnghuó lìzi lái shuōmíng wùlǐ dìnglǜ.',
      example_vi = 'Thầy giáo đã nêu một ví dụ đời sống vô cùng dễ hiểu trên bảng để giải thích cho định luật vật lý.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师在黑板上举了一个非常通俗易懂的生活例子来说明物理定律。', 'Lǎoshī zài hēibǎn shang jǔ le yí gè fēicháng tōngsú-yìdǒng de shēnghuó lìzi lái shuōmíng wùlǐ dìnglǜ.', 'Thầy giáo đã nêu một ví dụ đời sống vô cùng dễ hiểu trên bảng để giải thích cho định luật vật lý.', 'basic', 1),
        (v_id, '这位当代杰出青年科学家扎根荒漠三十年致力治沙绿化的感人事迹，是当代青年投身美丽中国建设的生动鲜活例子。', 'Zhè wèi dāngdài jiéchū qīngnián kēxuéjiā zhāgēn huāngmò sānshí nián zhìlì zhìshā lǜhuà de gǎnrén shìjì, shì dāngdài qīngnián tóushēn Měilì Zhōngguó jiànshè de shēngdòng xiānhuó lìzi.', 'Hành động xúc động của nhà khoa học trẻ kiệt xuất đương đại này gắn bó với sa mạc ba mươi năm dốc lòng phủ xanh chống sa mạc hóa, là một ví dụ sống động tươi mới về việc thanh niên đương đại dấn thân vào công cuộc xây dựng nước Trung Hoa tươi đẹp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [俩] (liǎ) - hai người, hai (bằng 两个) [Số lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '俩' AND pinyin = 'liǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '俩'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Số lượng từ',
      pinyin = 'liǎ',
      meaning_vi = 'hai người, hai (bằng 两个)',
      example_hanzi = '他们俩从小在一个大院里长大，感情比亲兄弟还要深厚。',
      example_pinyin = 'Tāmen liǎ cóngxiǎo zài yí gè dàyuàn lǐ zhǎngdà, gǎnqíng bǐ qīn xiōngdì hái yào shēnhòu.',
      example_vi = 'Hai người họ từ nhỏ cùng lớn lên trong một khu tập thể, tình cảm còn sâu nặng hơn cả anh em ruột thịt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他们俩从小在一个大院里长大，感情比亲兄弟还要深厚。', 'Tāmen liǎ cóngxiǎo zài yí gè dàyuàn lǐ zhǎngdà, gǎnqíng bǐ qīn xiōngdì hái yào shēnhòu.', 'Hai người họ từ nhỏ cùng lớn lên trong một khu tập thể, tình cảm còn sâu nặng hơn cả anh em ruột thịt.', 'basic', 1),
        (v_id, '这对青年创业夫妻俩凭借敏锐的市场洞察力与十年如一日的坚持，成功把一家家庭作坊打造成了年营收破亿元的高科技独角兽企业。', 'Zhè duì qīngnián chuàngyè fūqī liǎ píngjiè mǐnruì de shìchǎng dòngchálì yǔ shí nián rú yí rì de jiānchí, chénggōng bǎ yì jiā jiātíng zuòfang dǎzào chéng le nián yíngshōu pò yì yuán de gāokējì dújiǎoshòu qǐyè.', 'Hai vợ chồng trẻ khởi nghiệp này nhờ vào sự nhạy bén quan sát thị trường và sự kiên trì mười năm như một, đã xây dựng thành công một xưởng gia đình thành doanh nghiệp kỳ lân công nghệ cao doanh thu hàng năm vượt trăm triệu nhân dân tệ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [连] (lián) - ngay cả, đến cả (连...都/也...); liên kết [Giới từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '连' AND pinyin = 'lián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '连'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ / Động từ',
      pinyin = 'lián',
      meaning_vi = 'ngay cả, đến cả (连...都/也...); liên kết',
      example_hanzi = '这道题太简单了，连刚上小学一年级的小朋友都能算出来。',
      example_pinyin = 'Zhè dào tí tài jiǎndān le, lián gāng shàng xiǎoxué yīniánjí de xiǎopéngyou dōu néng suàn chūlái.',
      example_vi = 'Câu hỏi này quá đơn giản, ngay cả em nhỏ vừa vào lớp một tiểu học cũng có thể tính ra được.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这道题太简单了，连刚上小学一年级的小朋友都能算出来。', 'Zhè dào tí tài jiǎndān le, lián gāng shàng xiǎoxué yīniánjí de xiǎopéngyou dōu néng suàn chūlái.', 'Câu hỏi này quá đơn giản, ngay cả em nhỏ vừa vào lớp một tiểu học cũng có thể tính ra được.', 'basic', 1),
        (v_id, '在这场突如其来的罕见全球金融海啸中，连多家具备上百年悠久历史的国际顶级投资银行都因流动性枯竭而陷入破产危机。', 'Zài zhè chǎng tūrúqílái de hǎnjiàn quánqiú jīnróng hǎixiào zhōng, lián duō jiā jùbèi shàng bǎi nián yōujiǔ lìshǐ de guójì dǐngjí tóuzī yínháng dōu yīn liúdòngxìng kūjié ér xiànrù pòchǎn wēijī.', 'Trong cơn sóng thần tài chính toàn cầu hiếm thấy bất ngờ ập đến này, ngay cả nhiều ngân hàng đầu tư hàng đầu quốc tế có bề dày lịch sử hơn trăm năm cũng vì cạn kiệt thanh khoản mà rơi vào khủng hoảng phá sản.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [联系] (liánxì) - liên hệ, liên lạc; mối liên hệ [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '联系' AND pinyin = 'liánxì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '联系'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'liánxì',
      meaning_vi = 'liên hệ, liên lạc; mối liên hệ',
      example_hanzi = '这是我的新手机号码和微信号，以后常联系！',
      example_pinyin = 'Zhè shì wǒ de xīn shǒujī hàomǎ hé Wēixìn hào, yǐhòu cháng liánxì!',
      example_vi = 'Đây là số điện thoại di động mới và số WeChat của tôi, sau này nhớ thường xuyên liên lạc nhé!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这是我的新手机号码和微信号，以后常联系！', 'Zhè shì wǒ de xīn shǒujī hàomǎ hé Wēixìn hào, yǐhòu cháng liánxì!', 'Đây là số điện thoại di động mới và số WeChat của tôi, sau này nhớ thường xuyên liên lạc nhé!', 'basic', 1),
        (v_id, '事物之间是普遍联系并相互作用的，企业管理者在制定重大决策时必须树立全局系统思维。', 'Shìwù zhījiān shì pǔbiàn liánxì bìng xiānghù zuòyòng de, qǐyè guǎnlǐzhě zài zhìdìng zhòngdà juécè shí bìxū shùlì quánjú xìtǒng sīwéi.', 'Mọi sự vật giữa chúng đều có mối liên hệ phổ biến và tác động qua lại lẫn nhau, nhà quản trị doanh nghiệp khi đưa ra các quyết sách trọng đại bắt buộc phải xây dựng tư duy hệ thống cục diện toàn diện.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [凉] (liáng) - mát, mát mẻ; nguội lạnh [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '凉' AND pinyin = 'liáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '凉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'liáng',
      meaning_vi = 'mát, mát mẻ; nguội lạnh',
      example_hanzi = '秋天来了，早晚的天气明显转凉，出门要记得添衣服。',
      example_pinyin = 'Qiūtiān lái le, zǎowǎn de tiānqì míngxiǎn zhuǎn liáng, chūmén yào jìde tiān yīfu.',
      example_vi = 'Mùa thu đến rồi, thời tiết sáng tối se lạnh rõ rệt, khi ra ngoài nhớ mặc thêm áo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '秋天来了，早晚的天气明显转凉，出门要记得添衣服。', 'Qiūtiān lái le, zǎowǎn de tiānqì míngxiǎn zhuǎn liáng, chūmén yào jìde tiān yīfu.', 'Mùa thu đến rồi, thời tiết sáng tối se lạnh rõ rệt, khi ra ngoài nhớ mặc thêm áo.', 'basic', 1),
        (v_id, '在经历长达一年的资本狂热追捧后，此前过度炒作的虚拟概念投资市场终于迎来了一波理性回归的冷静降温凉潮。', 'Zài jīnglì cháng dá yì nián de zīběn kuángrè zhuīpěng hòu, cǐqián guòdù chǎozuò de xūnǐ gàiniàn tóuzī shìchǎng zhōngyú yínglái le yì bō lǐxìng huíguī de lěngjìng jiàngwēn liáng cháo.', 'Sau khi trải qua cơn cuồng nhiệt săn đón của dòng vốn kéo dài một năm, thị trường đầu tư các khái niệm ảo từng bị thổi phồng quá mức trước đây cuối cùng đã đón nhận một làn sóng nguội lạnh hạ nhiệt điềm tĩnh của sự trở về với lý tính.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [量] (liáng) - đo, đo lường (nhiệt độ, chiều dài, thể tích) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '量' AND pinyin = 'liáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'liáng',
      meaning_vi = 'đo, đo lường (nhiệt độ, chiều dài, thể tích)',
      example_hanzi = '护士拿着体温计耐心地为躺在病床上的小朋友量体温。',
      example_pinyin = 'Hùshi názhe tǐwēnjì nàixīn de wèi tǎng zài bìngchuáng shang de xiǎopéngyou liáng tǐwēn.',
      example_vi = 'Y tá cầm nhiệt kế kiên nhẫn đo nhiệt độ cơ thể cho em bé đang nằm trên giường bệnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '护士拿着体温计耐心地为躺在病床上的小朋友量体温。', 'Hùshi názhe tǐwēnjì nàixīn de wèi tǎng zài bìngchuáng shang de xiǎopéngyou liáng tǐwēn.', 'Y tá cầm nhiệt kế kiên nhẫn đo nhiệt độ cơ thể cho em bé đang nằm trên giường bệnh.', 'basic', 1),
        (v_id, '航天精密制造工程师利用高精度激光干涉仪对火箭发动机关键燃烧室构件进行纳米级尺寸精密测量。', 'Hángtiān jīngmì zhìzào gōngchéngshī lìyòng gāo-jīngdù jīguāng gānsheyí duì huǒjiàn fādòngjī guānjiàn ránshāoshì gòujiàn jìnxíng nàmǐjí chǐcun jīngmì cèliáng.', 'Kỹ sư chế tạo chính xác hàng không vũ trụ sử dụng máy đo giao thoa laser độ chính xác cao để tiến hành đo đạc chính xác kích thước cấp độ nanomet đối với cấu kiện buồng đốt then chốt của động cơ tên lửa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [两] (liǎng) - lạng (đơn vị đo khối lượng truyền thống, 1 lạng = 50g) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '两' AND pinyin = 'liǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '两'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'liǎng',
      meaning_vi = 'lạng (đơn vị đo khối lượng truyền thống, 1 lạng = 50g)',
      example_hanzi = '老板，请帮我称两半龙井春茶，用精美铁罐包装起来。',
      example_pinyin = 'Lǎobǎn, qǐng bāng wǒ chēng liǎng bàn Lóngjǐng chūnchá, yòng jīngměi tiěguàn bāozhuāng qǐlai.',
      example_vi = 'Ông chủ ơi, cân giúp tôi hai lạng rưỡi trà xuân Long Tỉnh, đóng gói vào hộp thiếc tinh xảo giúp nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老板，请帮我称两半龙井春茶，用精美铁罐包装起来。', 'Lǎobǎn, qǐng bāng wǒ chēng liǎng bàn Lóngjǐng chūnchá, yòng jīngměi tiěguàn bāozhuāng qǐlai.', 'Ông chủ ơi, cân giúp tôi hai lạng rưỡi trà xuân Long Tỉnh, đóng gói vào hộp thiếc tinh xảo giúp nhé.', 'basic', 1),
        (v_id, '中国传统贵金属与中药材计量体系中，“半斤八两”典故源自古代十六两为一斤的历史计量制度。', 'Zhōngguó chuántǒng guìjīnshǔ yǔ zhōngyàocái jìliàng tǐxì zhōng, “bànjīn-bāliǎng” diǎngù yuánzì gǔdài shíliù liǎng wéi yì jīn de lìshǐ jìliàng zhìdù.', 'Trong hệ thống đo lường kim loại quý và dược liệu đông y truyền thống của Trung Quốc, điển tích "nửa cân tám lạng" bắt nguồn từ chế độ đo lường lịch sử thời cổ đại 16 lạng bằng 1 cân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [亮] (liàng) - sáng, sáng sủa; sáng lên, bật sáng [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '亮' AND pinyin = 'liàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '亮'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'liàng',
      meaning_vi = 'sáng, sáng sủa; sáng lên, bật sáng',
      example_hanzi = '夜幕降临，天安门广场两旁的华灯渐渐亮了起来。',
      example_pinyin = 'Yèmù jiànglín, Tiān’ānmén guǎngchǎng liǎngpáng de huádēng jiànjiàn liàng le qǐlai.',
      example_vi = 'Màn đêm buông xuống, những ngọn đèn hoa lệ hai bên quảng trường Thiên An Môn dần dần sáng bừng lên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夜幕降临，天安门广场两旁的华灯渐渐亮了起来。', 'Yèmù jiànglín, Tiān’ānmén guǎngchǎng liǎngpáng de huádēng jiànjiàn liàng le qǐlai.', 'Màn đêm buông xuống, những ngọn đèn hoa lệ hai bên quảng trường Thiên An Môn dần dần sáng bừng lên.', 'basic', 1),
        (v_id, '当国际仲裁庭最终宣布中国高科技企业在全球专利侵权官司中全面胜诉时，全场研发团队的眼睛里闪烁着无比自豪激动的亮光。', 'Dāng guójì zhòngcáitíng zuìzhōng xuānbù Zhōngguó gāokējì qǐyè zài quánqiú zhuānlì qīnquán guānsi zhōng quánmiàn shèngsù shí, quánchǎng yánfā tuánduì de yǎnjing lǐ shǎnshuò zhe wúbǐ zìháo jīdòng de liàngguāng.', 'Khi tòa trọng tài quốc tế cuối cùng tuyên bố doanh nghiệp công nghệ cao Trung Quốc toàn thắng trong vụ kiện vi phạm sáng chế toàn cầu, trong ánh mắt của toàn thể đội ngũ R&D lấp lánh ánh sáng tự hào và xúc động vô bờ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [列] (liè) - chuyến (tàu hỏa); liệt kê, xếp hàng [Lượng từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '列' AND pinyin = 'liè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '列'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Động từ',
      pinyin = 'liè',
      meaning_vi = 'chuyến (tàu hỏa); liệt kê, xếp hàng',
      example_hanzi = '请大家在纸上列出一份本次野外露营所需的物品清单。',
      example_pinyin = 'Qǐng dàjiā zài zhǐ shang liè chū yí fèn běn cì yěwài lùyíng suǒ xū de wùpǐn qīngdān.',
      example_vi = 'Xin mời mọi người liệt kê ra trên giấy một bản danh sách các vật dụng cần thiết cho chuyến cắm trại dã ngoại lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请大家在纸上列出一份本次野外露营所需的物品清单。', 'Qǐng dàjiā zài zhǐ shang liè chū yí fèn běn cì yěwài lùyíng suǒ xū de wùpǐn qīngdān.', 'Xin mời mọi người liệt kê ra trên giấy một bản danh sách các vật dụng cần thiết cho chuyến cắm trại dã ngoại lần này.', 'basic', 1),
        (v_id, '随着全国铁路实行新的列车运行图，多列时速三百五十公里的复兴号智能动车组列车正式投入繁忙干线运营。', 'Suízhe quánguó tiělù shíxíng xīn de lièchē yùnxíngtú, duō liè shísù sān bǎi wǔshí gōnglǐ de Fùxīnghào zhìnéng dòngchēzǔ lièchē zhèngshì tóurù fánmáng gànxiàn yùnyíng.', 'Cùng với việc ngành đường sắt toàn quốc áp dụng biểu đồ chạy tàu mới, nhiều chuyến tàu động lực thông minh Phục Hưng vận tốc 350 km/h đã chính thức đi vào vận hành trên các tuyến huyết mạch bận rộn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [零下] (líng xià) - dưới 0 độ C, âm (nhiệt độ) [Cụm danh từ / Cụm từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '零下' AND pinyin = 'líng xià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '零下'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Cụm danh từ / Cụm từ',
      pinyin = 'líng xià',
      meaning_vi = 'dưới 0 độ C, âm (nhiệt độ)',
      example_hanzi = '哈尔滨冬天的气温经常降到零下二十多度。',
      example_pinyin = 'Hā’ěrbīn dōngtiān de qìwēn jīngcháng jiàng dào líng xià èrshí duō dù.',
      example_vi = 'Nhiệt độ mùa đông ở Cáp Nhĩ Tân thường xuyên giảm xuống dưới âm hai mươi mấy độ C.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '哈尔滨冬天的气温经常降到零下二十多度。', 'Hā’ěrbīn dōngtiān de qìwēn jīngcháng jiàng dào líng xià èrshí duō dù.', 'Nhiệt độ mùa đông ở Cáp Nhĩ Tân thường xuyên giảm xuống dưới âm hai mươi mấy độ C.', 'basic', 1),
        (v_id, '在零下四十摄氏度的极端极寒高原恶劣环境下，我国新型新能源特种作业车辆顺利通过了全天候野外可靠性严苛极限测试。', 'Zài líng xià sìshí shèshìdù de jíduān jíhán gāoyuán èliè huánjìng xià, wǒ guó xīnxíng xīnnéngyuán tèzhǒng zuòyè chēliàng shùnlì tōngguò le quántiānhòu yěwài kěkàoxìng yánkē jíxiàn cèshì.', 'Dưới môi trường khắc nghiệt cao nguyên cực rét âm bốn mươi độ C, các dòng xe vận hành chuyên dụng năng lượng mới kiểu mới của nước ta đã vượt qua kỳ kiểm tra giới hạn nghiêm ngặt về độ tin cậy dã ngoại suốt ngày đêm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [零花钱] (línghuāqián) - tiền tiêu vặt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '零花钱' AND pinyin = 'línghuāqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '零花钱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'línghuāqián',
      meaning_vi = 'tiền tiêu vặt',
      example_hanzi = '父母每个月会给小明五十元零花钱，并教他学会记账理财。',
      example_pinyin = 'Fùmǔ měi gè yuè huì gěi Xiǎomíng wǔshí yuán línghuāqián, bìng jiāo tā xuéhuì jìzhàng lǐcái.',
      example_vi = 'Mỗi tháng cha mẹ cho Tiểu Minh 50 tệ tiền tiêu vặt, và dạy cậu bé học cách ghi chép chi tiêu quản lý tài chính.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '父母每个月会给小明五十元零花钱，并教他学会记账理财。', 'Fùmǔ měi gè yuè huì gěi Xiǎomíng wǔshí yuán línghuāqián, bìng jiāo tā xuéhuì jìzhàng lǐcái.', 'Mỗi tháng cha mẹ cho Tiểu Minh 50 tệ tiền tiêu vặt, và dạy cậu bé học cách ghi chép chi tiêu quản lý tài chính.', 'basic', 1),
        (v_id, '引导青少年合理规划使用零花钱，不仅是培养儿童财商与节约意识的良好契机，更是树立正确金钱价值观的家庭必修课。', 'Yǐndǎo qīngshàonián hélǐ guīhuà shǐyòng línghuāqián, bùjǐn shì péiyǎng értóng cáishāng yǔ jiéyuē yìshí de liánghǎo qìjī, gèng shì shùlì zhèngquè jīnqián jiàzhíguān de jiātíng bìxiūkè.', 'Hướng dẫn thanh thiếu niên lên kế hoạch sử dụng tiền tiêu vặt hợp lý không chỉ là cơ hội tốt để bồi dưỡng chỉ số tài chính (FQ) và ý thức tiết kiệm cho con trẻ, mà còn là bài học gia đình bắt buộc để xác lập giá trị quan tiền bạc đúng đắn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [零钱] (língqián) - tiền lẻ, tiền thối [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '零钱' AND pinyin = 'língqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '零钱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'língqián',
      meaning_vi = 'tiền lẻ, tiền thối',
      example_hanzi = '乘公交车前，请提前准备好两元纸币零钱投币。',
      example_pinyin = 'Chéng gōngjiāochē qián, qǐng tíqián zhǔnbèi hǎo liǎng yuán zhǐbì língqián tóu bì.',
      example_vi = 'Trước khi lên xe buýt, xin vui lòng chuẩn bị sẵn tiền lẻ hai tệ tiền giấy để bỏ vào thùng vé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '乘公交车前，请提前准备好两元纸币零钱投币。', 'Chéng gōngjiāochē qián, qǐng tíqián zhǔnbèi hǎo liǎng yuán zhǐbì língqián tóu bì.', 'Trước khi lên xe buýt, xin vui lòng chuẩn bị sẵn tiền lẻ hai tệ tiền giấy để bỏ vào thùng vé.', 'basic', 1),
        (v_id, '随着移动支付与数字人民币在日常消费中的全场景普及，传统商贩与市民出门随身携带纸币硬币零钱的现象已经大幅减少。', 'Suízhe yídòng zhīfù yǔ shùzì rénmínbì zài rìcháng xiāofèi zhōng de quán chǎngjǐng pǔjí, chuántǒng shāngfàn yǔ shìmín chūmén suíshēn xiédài zhǐbì yìngbì língqián de xiànxiàng yǐjīng dàfú jiǎnshǎo.', 'Cùng với sự phổ cập mọi ngữ cảnh của thanh toán di động và đồng nhân dân tệ số trong tiêu dùng hàng ngày, hiện tượng tiểu thương truyền thống và người dân mang theo tiền lẻ tiền giấy tiền xu bên mình khi ra đường đã giảm mạnh rõ rệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [零食] (língshí) - đồ ăn vặt, thức ăn vặt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '零食' AND pinyin = 'língshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '零食'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'língshí',
      meaning_vi = 'đồ ăn vặt, thức ăn vặt',
      example_hanzi = '小孩子在饭前半小时千万不要吃太多甜食和零食，以免影响正餐胃口。',
      example_pinyin = 'Xiǎoháizi zài fànqián bàn xiǎoshí qiānwàn bú yào chī tài duō tiánshí hé língshí, yǐmiǎn yǐngxiǎng zhèngcān wèikǒu.',
      example_vi = 'Trẻ nhỏ nửa tiếng trước bữa ăn tuyệt đối đừng ăn quá nhiều đồ ngọt và đồ ăn vặt, tránh làm ảnh hưởng đến cảm giác ngon miệng bữa chính.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小孩子在饭前半小时千万不要吃太多甜食和零食，以免影响正餐胃口。', 'Xiǎoháizi zài fànqián bàn xiǎoshí qiānwàn bú yào chī tài duō tiánshí hé língshí, yǐmiǎn yǐngxiǎng zhèngcān wèikǒu.', 'Trẻ nhỏ nửa tiếng trước bữa ăn tuyệt đối đừng ăn quá nhiều đồ ngọt và đồ ăn vặt, tránh làm ảnh hưởng đến cảm giác ngon miệng bữa chính.', 'basic', 1),
        (v_id, '现代健康休闲食品行业顺应消费升级趋势，全面发力研发低糖低盐、非油炸的高品质坚果与果脯类健康零食产品。', 'Xiàndài jiànkāng xiūxián shípǐn hángyè shùnyìng xiāofèi shēngjí qūshì, quánmiàn fālì yánfā dītáng-dīyán, fēi-yóuzhá de gāo pǐnzhì jiānguǒ yǔ guǒfǔ lèi jiànkāng língshí chǎnpǐn.', 'Ngành thực phẩm ăn vặt lành mạnh hiện đại thuận theo xu hướng nâng cấp tiêu dùng, dốc toàn lực nghiên cứu phát triển các dòng sản phẩm đồ ăn vặt bổ dưỡng từ quả sấy khô và hạt dinh dưỡng chất lượng cao ít đường ít muối và không chiên qua dầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [另] (lìng) - khác, riêng (người khác, nơi khác) [Đại từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '另' AND pinyin = 'lìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '另'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ / Phó từ',
      pinyin = 'lìng',
      meaning_vi = 'khác, riêng (người khác, nơi khác)',
      example_hanzi = '会议室今天被占用了，我们另找一个空房间开会吧。',
      example_pinyin = 'Huìyìshì jīntiān bèi zhànyòng le, wǒmen lìng zhǎo yí gè kōng fángjiān kāihuì ba.',
      example_vi = 'Phòng họp hôm nay bị dùng mất rồi, chúng ta tìm riêng một phòng trống khác để họp đi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '会议室今天被占用了，我们另找一个空房间开会吧。', 'Huìyìshì jīntiān bèi zhànyòng le, wǒmen lìng zhǎo yí gè kōng fángjiān kāihuì ba.', 'Phòng họp hôm nay bị dùng mất rồi, chúng ta tìm riêng một phòng trống khác để họp đi.', 'basic', 1),
        (v_id, '除主旨发言之外，大会还另设有四个平行的前沿技术圆桌论坛，供各界代表深入闭门研讨。', 'Chú zhǔzhǐ fāyán zhīwài, dàhuì hái lìng shè yǒu sì gè píngxíng de qiányán jìshù yuánzhuō lùntán, gōng gèjiè dàibiǎo shēnrù bìmén yántǎo.', 'Ngoài phiên phát biểu khai mạc chủ đề, đại hội còn bố trí riêng 4 diễn đàn bàn tròn công nghệ tiên phong song song, dành cho đại biểu các giới thảo luận kín sâu sắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [另外] (lìngwài) - ngoài ra, hơn nữa; khác [Đại từ / Phó từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '另外' AND pinyin = 'lìngwài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '另外'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ / Phó từ / Liên từ',
      pinyin = 'lìngwài',
      meaning_vi = 'ngoài ra, hơn nữa; khác',
      example_hanzi = '这本书我已经读完了，另外那两本书我下周借给你。',
      example_pinyin = 'Zhè běn shū wǒ yǐjīng dú wán le, lìngwài nà liǎng běn shū wǒ xià zhōu jiè gěi nǐ.',
      example_vi = 'Cuốn sách này tôi đã đọc xong rồi, hai cuốn sách còn lại kia tuần sau tôi cho bạn mượn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这本书我已经读完了，另外那两本书我下周借给你。', 'Zhè běn shū wǒ yǐjīng dú wán le, lìngwài nà liǎng běn shū wǒ xià zhōu jiè gěi nǐ.', 'Cuốn sách này tôi đã đọc xong rồi, hai cuốn sách còn lại kia tuần sau tôi cho bạn mượn.', 'basic', 1),
        (v_id, '该方案不仅能显著降低企业生产制造的单位能耗，另外还能全面提升终端产品的质量稳定性与良品率。', 'Gāi fāng’àn bùjǐn néng xiǎnzhù jiàngdī qǐyè shēngchǎn zhìzào de dānwèi nénghào, lìngwài hái néng quánmiàn tíshēng zhōngduān chǎnpǐn de zhìliàng wěndìngxìng yǔ liángpǐnlǜ.', 'Phương án này không những có thể giảm đáng kể mức tiêu hao năng lượng đơn vị trong sản xuất chế tạo của doanh nghiệp, ngoài ra còn nâng cao toàn diện độ ổn định chất lượng và tỷ lệ đạt chuẩn của sản phẩm đầu cuối.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [留] (liú) - ở lại; giữ lại; để lại (lời nhắn) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '留' AND pinyin = 'liú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '留'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'liú',
      meaning_vi = 'ở lại; giữ lại; để lại (lời nhắn)',
      example_hanzi = '天色已经很晚了，今天晚上你就留在我家里住吧。',
      example_pinyin = 'Tiānsè yǐjīng hěn wǎn le, jīntiān wǎnshang nǐ jiù liú zài wǒ jiā lǐ zhù ba.',
      example_vi = 'Trời đã muộn lắm rồi, tối nay bạn cứ ở lại nhà tôi ngủ nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '天色已经很晚了，今天晚上你就留在我家里住吧。', 'Tiānsè yǐjīng hěn wǎn le, jīntiān wǎnshang nǐ jiù liú zài wǒ jiā lǐ zhù ba.', 'Trời đã muộn lắm rồi, tối nay bạn cứ ở lại nhà tôi ngủ nhé.', 'basic', 1),
        (v_id, '地方政府出台了涵盖落户安居、科研启动经费与子女入学在内的全方位政策，千方百计留住高精尖科研创新领军人才。', 'Dìfāng zhèngfǔ chūtái le hángài luòhù ānjū, kēyán qǐdòng jīngfèi yǔ zǐnǚ rùxué zàinèi de quánfāngwèi zhèngcè, qiānfāng-bǎijì liú zhù gāojīngjiān kēyán chuàngxīn lǐngjūn réncái.', 'Chính quyền địa phương đã ban hành chính sách toàn diện bao gồm cả nhập hộ khẩu an cư, kinh phí khởi động nghiên cứu và nhập học cho con cái, tìm đủ mọi cách để giữ chân các nhân tài đầu ngành đổi mới nghiên cứu công nghệ đỉnh cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [流] (liú) - chảy, trôi chảy, lưu thông [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '流' AND pinyin = 'liú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '流'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'liú',
      meaning_vi = 'chảy, trôi chảy, lưu thông',
      example_hanzi = '奔腾不息的长江水由西向东日夜流向浩瀚的大海。',
      example_pinyin = 'Bēnténg-bùxī de Cháng Jiāng shuǐ yóu xī xiàng dōng rìyè liú xiàng hàohàn de dàhǎi.',
      example_vi = 'Dòng nước Trường Giang cuồn cuộn không ngừng từ phía tây chảy về phía đông ngày đêm đổ ra biển lớn mênh mông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '奔腾不息的长江水由西向东日夜流向浩瀚的大海。', 'Bēnténg-bùxī de Cháng Jiāng shuǐ yóu xī xiàng dōng rìyè liú xiàng hàohàn de dàhǎi.', 'Dòng nước Trường Giang cuồn cuộn không ngừng từ phía tây chảy về phía đông ngày đêm đổ ra biển lớn mênh mông.', 'basic', 1),
        (v_id, '在剧烈的体育运动后大量出汗导致水分与电解质快速流失，此时应及时补充温淡盐水以维持体内水盐平衡。', 'Zài jùliè de tǐyù yùndòng hòu dàliàng chū hàn dǎozhì shuǐfèn yǔ diànjiězì kuàisù liúshī, cǐshí yīng jíshí bǔchōng wēn dàn yánshuǐ yǐ wéichí tǐnèi shuǐ-yán pínghéng.', 'Sau khi vận động thể thao mạnh ra nhiều mồ hôi dẫn tới lượng nước và chất điện giải bị tiêu hao thất thoát nhanh chóng, lúc này cần kịp thời bổ sung nước muối loãng ấm để duy trì sự cân bằng nước - muối trong cơ thể.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [流利] (liúlì) - lưu loát, trôi chảy [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '流利' AND pinyin = 'liúlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '流利'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'liúlì',
      meaning_vi = 'lưu loát, trôi chảy',
      example_hanzi = '这位留学生来中国才两年，普通话就说得非常流利地道。',
      example_pinyin = 'Zhè wèi liúxuéshēng lái Zhōngguó cái liǎng nián, pǔtōnghuà jiù shuō de fēicháng liúlì dìdao.',
      example_vi = 'Bạn lưu học sinh này mới đến Trung Quốc được hai năm mà tiếng phổ thông đã nói vô cùng lưu loát chuẩn vị.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这位留学生来中国才两年，普通话就说得非常流利地道。', 'Zhè wèi liúxuéshēng lái Zhōngguó cái liǎng nián, pǔtōnghuà jiù shuō de fēicháng liúlì dìdao.', 'Bạn lưu học sinh này mới đến Trung Quốc được hai năm mà tiếng phổ thông đã nói vô cùng lưu loát chuẩn vị.', 'basic', 1),
        (v_id, '外事翻译官在联合国高级别多边双语磋商中，凭借高度精准流利的同声传译为各方达成外交共识提供了卓越沟通保障。', 'Wàishì fānyìguān zài Liánhéguó gāojíbié duōbiān shuāngyǔ cuōshāng zhōng, píngjiè gāodù jīngzhǔn liúlì de tóngshēng-chuányì wèi gè fāng dáchéng wàijiāo gòngshí tígōng le zhuóyuè gōutōng bǎozhàng.', 'Cán bộ phiên dịch đối ngoại trong cuộc tham vấn song ngữ đa phương cấp cao của Liên Hợp Quốc, nhờ vào kỹ năng dịch cabin đồng thời trôi chảy chuẩn xác tột bậc đã đem lại sự bảo đảm kết nối thông suốt xuất sắc để các bên đạt được đồng thuận ngoại giao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [留下] (liúxia) - để lại, lưu lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '留下' AND pinyin = 'liúxia'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '留下'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'liúxia',
      meaning_vi = 'để lại, lưu lại',
      example_hanzi = '离开办公室之前，请记得在值班表上留下您的联系电话。',
      example_pinyin = 'Líkāi bàngōngshì zhīqián, qǐng jìde zài zhíbānbiǎo shang liúxia nín de liánxì diànhuà.',
      example_vi = 'Trước khi rời văn phòng, xin nhớ để lại số điện thoại liên hệ của bạn trên bảng trực ban.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '离开办公室之前，请记得在值班表上留下您的联系电话。', 'Líkāi bàngōngshì zhīqián, qǐng jìde zài zhíbānbiǎo shang liúxia nín de liánxì diànhuà.', 'Trước khi rời văn phòng, xin nhớ để lại số điện thoại liên hệ của bạn trên bảng trực ban.', 'basic', 1),
        (v_id, '老一辈科学家在极其艰苦的高原荒漠上战风沙搞科研，为国家国防事业与科技自立自强留下了彪炳史册的宝贵精神财富。', 'Lǎo yí bèi kēxuéjiā zài jíqí jiānkǔ de gāoyuán huāngmò shang zhàn fēngshā gǎo kēyán, wèi guójiā guófáng shìyè yǔ kējì zìlì-zìqiáng liúxia le biāobǐng-shǐcè de bǎoguì jīngshén cáifù.', 'Thế hệ nhà khoa học đi trước trên vùng sa mạc cao nguyên vô cùng gian khổ đã chiến đấu với gió cát làm nghiên cứu, để lại tài sản tinh thần vô giá rạng danh sử sách cho sự nghiệp quốc phòng và nền khoa học công nghệ tự lực tự cường của tổ quốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [流行] (liúxíng) - thịnh hành, phổ biến, hợp mốt [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '流行' AND pinyin = 'liúxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '流行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'liúxíng',
      meaning_vi = 'thịnh hành, phổ biến, hợp mốt',
      example_hanzi = '这首充满国潮元素的流行歌曲在各大音乐播放软件上高居榜首。',
      example_pinyin = 'Zhè shǒu chōngmǎn guócháo yuánsù de liúxíng gēqǔ zài gè dà yīnyuè bōfàng ruǎnjiàn shang gāojū bǎngshǒu.',
      example_vi = 'Bài hát thịnh hành đậm chất phong cách truyền thống mới này đang chễm chệ chiếm ngôi đầu bảng trên các ứng dụng nghe nhạc lớn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这首充满国潮元素的流行歌曲在各大音乐播放软件上高居榜首。', 'Zhè shǒu chōngmǎn guócháo yuánsù de liúxíng gēqǔ zài gè dà yīnyuè bōfàng ruǎnjiàn shang gāojū bǎngshǒu.', 'Bài hát thịnh hành đậm chất phong cách truyền thống mới này đang chễm chệ chiếm ngôi đầu bảng trên các ứng dụng nghe nhạc lớn.', 'basic', 1),
        (v_id, '新消费品牌通过深度洞察当代年轻群体的审美变迁，精准引领并塑造了绿色低碳可持续时尚生活方式的流行新风尚。', 'Xīn xiāofèi pǐnpái tōngguò shēndù dòngchá dāngdài niánqīng qúntǐ de shěnměi biànqiān, jīngzhǔn yǐnlǐng bìng sùzào le lǜsè dītàn kěchíxù shíshàng shēnghuó fāngshì de liúxíng xīn fēngshàng.', 'Thương hiệu tiêu dùng mới thông qua việc thấu hiểu sâu sắc sự thay đổi thẩm mỹ của nhóm người trẻ đương đại, đã dẫn dắt và định hình chuẩn xác xu thế mốt thịnh hành mới về lối sống thời trang bền vững xanh giảm phát thải carbon.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [路过] (lùguò) - đi ngang qua, tiện đường ghé qua [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '路过' AND pinyin = 'lùguò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '路过'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'lùguò',
      meaning_vi = 'đi ngang qua, tiện đường ghé qua',
      example_hanzi = '今天下班路过面包店的时候，我顺便买了一条刚出炉的吐司。',
      example_pinyin = 'Jīntiān xiàbān lùguò miànbāodiàn de shíhou, wǒ shùnbiàn mǎi le yì tiáo gāng chū lú de tǔsī.',
      example_vi = 'Hôm nay lúc tan làm đi ngang qua tiệm bánh mì, tôi đã thuận tiện mua một ổ bánh mì gối vừa mới ra lò.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天下班路过面包店的时候，我顺便买了一条刚出炉的吐司。', 'Jīntiān xiàbān lùguò miànbāodiàn de shíhou, wǒ shùnbiàn mǎi le yì tiáo gāng chū lú de tǔsī.', 'Hôm nay lúc tan làm đi ngang qua tiệm bánh mì, tôi đã thuận tiện mua một ổ bánh mì gối vừa mới ra lò.', 'basic', 1),
        (v_id, '在外贸商务出差路过海滨经济特区期间，考察代表团顺道走访调研了多家具有全球竞争力的智能制造标杆示范企业。', 'Zài wàimào shāngwù chūchāi lùguò hǎibīn jīngjì tèqū qījiān, kǎochá dàibiǎotuán shùndào zǒufǎng diàoyán le duō jiā jùyǒu quánqiú jìngzhēnglì de zhìnéng zhìzào biāogān shìfàn qǐyè.', 'Trong thời gian đi công tác thương mại ngoại thương ghé qua đặc khu kinh tế ven biển, đoàn đại biểu khảo sát đã tiện đường đến thăm và tìm hiểu thực tế nhiều doanh nghiệp mô hình kiểu mẫu sản xuất thông minh có năng lực cạnh tranh toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [旅馆] (lǚguǎn) - khách sạn, nhà nghỉ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '旅馆' AND pinyin = 'lǚguǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '旅馆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lǚguǎn',
      meaning_vi = 'khách sạn, nhà nghỉ',
      example_hanzi = '到达目的地之后，我们先在火车站附近找了一家干净实惠的小旅馆住下。',
      example_pinyin = 'Dàodá mùdìdì zhīhòu, wǒmen xiān zài huǒchēzhàn fùjìn zhǎo le yì jiā gānjìng shíhuì de xiǎo lǚguǎn zhù xià.',
      example_vi = 'Sau khi đến điểm đến, trước hết chúng tôi tìm một nhà nghỉ nhỏ sạch sẽ giá cả phải chăng ở gần ga tàu hỏa để ở lại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '到达目的地之后，我们先在火车站附近找了一家干净实惠的小旅馆住下。', 'Dàodá mùdìdì zhīhòu, wǒmen xiān zài huǒchēzhàn fùjìn zhǎo le yì jiā gānjìng shíhuì de xiǎo lǚguǎn zhù xià.', 'Sau khi đến điểm đến, trước hết chúng tôi tìm một nhà nghỉ nhỏ sạch sẽ giá cả phải chăng ở gần ga tàu hỏa để ở lại.', 'basic', 1),
        (v_id, '为迎接即将到来的国际文化艺术旅游节，古镇景区对辖区内具有数百年历史风貌的传统民居客栈旅馆实施了全方位的消防安全与卫生评级提升工程。', 'Wèi yíngjiē jíjiāng dàolái de guójì wénhuà yìshù lǚyóujié, gǔzhèn jǐngqū duì xiáqū nèi jùyǒu shù bǎi nián lìshǐ fēngmào de chuántǒng mínjū kèzhàn lǚguǎn shíshī le quánfāngwèi de xiāofáng ānquán yǔ wèishēng píngjí tíshēng gōngchéng.', 'Để nghênh đón lễ hội du lịch nghệ thuật văn hóa quốc tế sắp tới, khu thắng cảnh thị trấn cổ đã triển khai công trình nâng cấp toàn diện về đánh giá xếp hạng vệ sinh và an toàn phòng cháy chữa cháy đối với các nhà nghỉ quán trọ nhà cổ truyền thống có diện mạo lịch sử hàng trăm năm trong khu vực quản lý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [旅客] (lǚkè) - hành khách, du khách đi tàu xe [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '旅客' AND pinyin = 'lǚkè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '旅客'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lǚkè',
      meaning_vi = 'hành khách, du khách đi tàu xe',
      example_hanzi = '请前往上海虹桥站的各位旅客带好随身行李物品准备检票进站。',
      example_pinyin = 'Qǐng qiánwǎng Shànghǎi Hóngqiáo zhàn de gèwèi lǚkè dài hǎo suíshēn xíngli wùpǐn zhǔnbèi jiǎnpiào jìn zhàn.',
      example_vi = 'Xin mời các vị hành khách đi ga Hồng Kiều Thượng Hải mang theo hành lý tư trang sẵn sàng soát vé vào ga.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请前往上海虹桥站的各位旅客带好随身行李物品准备检票进站。', 'Qǐng qiánwǎng Shànghǎi Hóngqiáo zhàn de gèwèi lǚkè dài hǎo suíshēn xíngli wùpǐn zhǔnbèi jiǎnpiào jìn zhàn.', 'Xin mời các vị hành khách đi ga Hồng Kiều Thượng Hải mang theo hành lý tư trang sẵn sàng soát vé vào ga.', 'basic', 1),
        (v_id, '在春运全国跨省客流超高负荷运转的极端考验下，全国各大交通运输枢纽通过设立智慧绿色便民通道，全力保障亿万旅客平安温馨归乡。', 'Zài chūnyùn quánguó kuàshěng kèliú chāo gāo fùhè yùnzhuǎn de jíduān kǎoyàn xià, quánguó gè dà jiāotōng yùnshū shūniǔ tōngguò shèlì zhìhuì lǜsè biànmín tōngdào, quánlì bǎozhàng yìwàn lǚkè píng’ān wēnxīn guī xiāng.', 'Dưới bài kiểm tra khắc nghiệt của lưu lượng hành khách liên tỉnh toàn quốc vận hành siêu tải dịp cao điểm Tết, các đầu mối giao thông vận tải lớn toàn quốc thông qua việc thiết lập luồng xanh tiện ích thông minh, dốc toàn lực bảo đảm cho hàng trăm triệu hành khách về quê an lành ấm áp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [旅行] (lǚxíng) - du lịch, chuyến du lịch [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '旅行' AND pinyin = 'lǚxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '旅行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'lǚxíng',
      meaning_vi = 'du lịch, chuyến du lịch',
      example_hanzi = '读万卷书，行万里路，年轻时多出去旅行能极大开阔眼界。',
      example_pinyin = 'Dú wàn juàn shū, xíng wàn lǐ lù, niánqīng shí duō chūqu lǚxíng néng jídà kāikuò yǎnjiè.',
      example_vi = 'Đi một ngày đàng học một sàng khôn, thời trẻ đi du lịch nhiều có thể mở mang tầm mắt đáng kể.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '读万卷书，行万里路，年轻时多出去旅行能极大开阔眼界。', 'Dú wàn juàn shū, xíng wàn lǐ lù, niánqīng shí duō chūqu lǚxíng néng jídà kāikuò yǎnjiè.', 'Đi một ngày đàng học một sàng khôn, thời trẻ đi du lịch nhiều có thể mở mang tầm mắt đáng kể.', 'basic', 1),
        (v_id, '深度文化主题定制旅行日益成为当代高净值消费群体的新宠，游客更加渴望深入当地历史街区探寻非物质文化遗产的原真魅力。', 'Shēndù wénhuà zhǔtí dìngzhì lǚxíng rìyì chéngwéi dāngdài gāojìngzhí xiāofèi qúntǐ de xīn chǒng, yóukè gèngjiā kěwàng shēnrù dāngdì lìshǐ jiēqū tànxún fēiwùzhì wénhuà yíchǎn de yuánzhēn mèilì.', 'Các tour du lịch may đo theo chủ đề văn hóa chuyên sâu ngày càng trở thành trào lưu mới được nhóm khách hàng giá trị tài sản ròng cao đương đại ưa chuộng, du khách càng thêm khao khát đi sâu vào các con phố lịch sử bản địa để khám phá nét quyến rũ nguyên bản của di sản văn hóa phi vật thể.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [律师] (lǜshī) - luật sư [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '律师' AND pinyin = 'lǜshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '律师'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lǜshī',
      meaning_vi = 'luật sư',
      example_hanzi = '在正式签署这份重要的商业合同之前，务必先交由专业律师过目审核。',
      example_pinyin = 'Zài zhèngshì qiānshǔ zhè fèn zhòngyào de shāngyè hétong zhīqián, wùbì xiān jiāo yóu zhuānyè lǜshī guòmù shěnhé.',
      example_vi = 'Trước khi chính thức ký kết bản hợp đồng thương mại quan trọng này, nhất thiết phải giao cho luật sư chuyên nghiệp xem qua thẩm duyệt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在正式签署这份重要的商业合同之前，务必先交由专业律师过目审核。', 'Zài zhèngshì qiānshǔ zhè fèn zhòngyào de shāngyè hétong zhīqián, wùbì xiān jiāo yóu zhuānyè lǜshī guòmù shěnhé.', 'Trước khi chính thức ký kết bản hợp đồng thương mại quan trọng này, nhất thiết phải giao cho luật sư chuyên nghiệp xem qua thẩm duyệt.', 'basic', 1),
        (v_id, '优秀的涉外涉知识产权资深专职律师，不仅需要精通跨国商事仲裁法律细则，更要在复杂的全球反垄断调查中敏锐洞悉监管裁判尺度。', 'Yōuxiù de shèwài shè zhīshi chǎnquán zīshēn zhuānzhí lǜshī, bùjǐn xūyào jīngtōng kuàguó shāngshì zhòngcái fǎlǜ xìzé, gèng yào zài fùzá de quánqiú fǎn-lǒngduàn diàochá zhōng mǐnruì dòngxī jiānguǎn cáipàn chǐdù.', 'Luật sư chuyên trách kỳ cựu xuất sắc trong lĩnh vực sở hữu trí tuệ và yếu tố nước ngoài không chỉ cần tinh thông các điều khoản chi tiết luật trọng tài thương mại xuyên quốc gia, mà còn phải nhạy bén thấu suốt biên độ phán quyết giám sát trong các cuộc điều tra chống độc quyền toàn cầu phức tạp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [乱] (luàn) - bừa bãi, lộn xộn, hỗn loạn; tùy tiện [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '乱' AND pinyin = 'luàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '乱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'luàn',
      meaning_vi = 'bừa bãi, lộn xộn, hỗn loạn; tùy tiện',
      example_hanzi = '下课后教室里的桌椅有些凌乱，值日生正在认真把桌椅摆放整齐。',
      example_pinyin = 'Xiàkè hòu jiàoshì lǐ de zhuōyǐ yǒuxiē língluàn, zhírìshēng zhèngzài rènzhēn bǎ zhuōyǐ bǎifàng zhěngqí.',
      example_vi = 'Sau giờ tan học bàn ghế trong phòng học có phần lộn xộn, bạn học sinh trực nhật đang cẩn thận kê xếp bàn ghế ngay ngắn lại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '下课后教室里的桌椅有些凌乱，值日生正在认真把桌椅摆放整齐。', 'Xiàkè hòu jiàoshì lǐ de zhuōyǐ yǒuxiē língluàn, zhírìshēng zhèngzài rènzhēn bǎ zhuōyǐ bǎifàng zhěngqí.', 'Sau giờ tan học bàn ghế trong phòng học có phần lộn xộn, bạn học sinh trực nhật đang cẩn thận kê xếp bàn ghế ngay ngắn lại.', 'basic', 1),
        (v_id, '在极其复杂的跨国突发公关危机面前，企业发言人切忌自乱阵脚随意发声，必须以详实铁证与严谨口径从容化解舆情波澜。', 'Zài jíqí fùzá de kuàguó tūfā gōngguān wēijī miànqián, qǐyè fāyánrén qièjì zì luàn zhènjiǎo suíyì fāshēng, bìxū yǐ xiángshí tiězhèng yǔ yánjǐn kǒujìng cóngróng huàjiě yúqíng bōlán.', 'Trước cuộc khủng hoảng quan hệ công chúng bất ngờ xảy ra xuyên quốc gia cực kỳ phức tạp, người phát ngôn của doanh nghiệp tuyệt đối tránh tự làm rối loạn hàng ngũ tùy tiện lên tiếng, mà bắt buộc phải dựa vào chứng cứ vững như thép và phát ngôn chặt chẽ để bình tĩnh hóa giải sóng gió dư luận.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [落] (luò) - rơi xuống, rụng; tụt lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '落' AND pinyin = 'luò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '落'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'luò',
      meaning_vi = 'rơi xuống, rụng; tụt lại',
      example_hanzi = '秋风吹过，金黄色的银杏树叶纷纷扬扬地飘落在公园的小路上。',
      example_pinyin = 'Qiūfēng chuī guò, jīnhuángsè de yínxìng shùyè fēnfēn-yángyáng de piāoluò zài gōngyuán de xiǎolù shang.',
      example_vi = 'Gió thu thổi qua, những chiếc lá cây ngân hạnh vàng óng phấp phới rơi rụng trên lối đi nhỏ trong công viên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '秋风吹过，金黄色的银杏树叶纷纷扬扬地飘落在公园的小路上。', 'Qiūfēng chuī guò, jīnhuángsè de yínxìng shùyè fēnfēn-yángyáng de piāoluò zài gōngyuán de xiǎolù shang.', 'Gió thu thổi qua, những chiếc lá cây ngân hạnh vàng óng phấp phới rơi rụng trên lối đi nhỏ trong công viên.', 'basic', 1),
        (v_id, '在瞬息万变的高新技术全球产业竞争浪潮中，不进则退，任何稍有迟疑松懈的企业都极有可能迅速落入被淘汰的残酷境地。', 'Zài shùnxī-wànbiàn de gāoxīnjìshù quánqiú chǎnyè jìngzhēng làngcháo zhōng, bú jìn zé tuì, rènhé shāoyǒu chíyí sōngxiè de qǐyè dōu jí yǒukěnéng xùnsù luò rù bèi táotài de cánkù jìngdì.', 'Giữa làn sóng cạnh tranh ngành công nghiệp toàn cầu công nghệ cao biến đổi trong chớp mắt, không tiến ắt sẽ lùi, bất kỳ doanh nghiệp nào chỉ cần có chút do dự buông lỏng đều rất có thể nhanh chóng rơi vào hoàn cảnh tàn khốc bị đào thải.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [麻烦] (máfan) - phiền phức, rắc rối; làm phiền; điều phiền toái [Tính từ / Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '麻烦' AND pinyin = 'máfan'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '麻烦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ / Danh từ',
      pinyin = 'máfan',
      meaning_vi = 'phiền phức, rắc rối; làm phiền; điều phiền toái',
      example_hanzi = '服务员，不好意思麻烦您再帮我们加一壶热茶。',
      example_pinyin = 'Fúwùyuán, bù hǎoyìsi máfan nín zài bāng wǒmen jiā yì hú rè chá.',
      example_vi = 'Phục vụ ơi, thật ngại quá làm phiền bạn giúp chúng tôi thêm một ấm trà nóng nữa nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '服务员，不好意思麻烦您再帮我们加一壶热茶。', 'Fúwùyuán, bù hǎoyìsi máfan nín zài bāng wǒmen jiā yì hú rè chá.', 'Phục vụ ơi, thật ngại quá làm phiền bạn giúp chúng tôi thêm một ấm trà nóng nữa nhé.', 'basic', 1),
        (v_id, '在跨国业务架构重组与财税申报流程中，合规法务团队提前开展地毯式风险排查，彻底消除了可能给企业引来巨额处罚的潜在麻烦。', 'Zài kuàguó yèwù jiàgòu chóngzǔ yǔ cáishuì shēnbào liúchéng zhōng, héguī fǎwù tuánduì tíqián kāizhǎn dìtǎnshì fēngxiǎn páichá, chèdǐ xiāochú le kěnéng gěi qǐyè yǐn lái jù’é chǔfá de qiánzài máfan.', 'Trong quy trình tái cơ cấu kiến trúc nghiệp vụ đa quốc gia và kê khai tài chính thuế khóa, đội ngũ pháp chế tuân thủ đã rà soát rủi ro toàn diện từ sớm, triệt tiêu hoàn toàn những rắc rối tiềm ẩn có thể mang lại những án phạt khổng lồ cho doanh nghiệp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [馒头] (mántou) - màn thầu, bánh bao không nhân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '馒头' AND pinyin = 'mántou'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '馒头'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'mántou',
      meaning_vi = 'màn thầu, bánh bao không nhân',
      example_hanzi = '北方人的早餐往往喜欢吃刚蒸出锅的热气腾腾的大白馒头配一碗小米粥。',
      example_pinyin = 'Běifāngrén de zǎocān wǎngwǎng xǐhuan chī gāng zhēng chū guō de rèqì-téngténg de dà bái mántou pèi yì wǎn xiǎomǐzhōu.',
      example_vi = 'Bữa sáng của người miền Bắc thường thích ăn bánh màn thầu trắng lớn nóng hổi vừa mới hấp ra khỏi nồi kèm một bát cháo kê.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '北方人的早餐往往喜欢吃刚蒸出锅的热气腾腾的大白馒头配一碗小米粥。', 'Běifāngrén de zǎocān wǎngwǎng xǐhuan chī gāng zhēng chū guō de rèqì-téngténg de dà bái mántou pèi yì wǎn xiǎomǐzhōu.', 'Bữa sáng của người miền Bắc thường thích ăn bánh màn thầu trắng lớn nóng hổi vừa mới hấp ra khỏi nồi kèm một bát cháo kê.', 'basic', 1),
        (v_id, '这家具有上百年传统发酵技艺的老字号面点工坊，坚持采用传统老面自然发酵手工揉制，蒸出的馒头麦香浓郁、筋道可口。', 'Zhè jiā jùyǒu shàng bǎi nián chuántǒng fājiào jìyì de lǎozìhào miàndiǎn gōngfǎng, jiānchí cǎiyòng chuántǒng lǎomiàn zìrán fājiào shǒugōng róuzhì, zhēng chū de mántou màixiāng nóngyù, jìndao kěkǒu.', 'Xưởng bánh ngọt điểm tâm thương hiệu lâu đời sở hữu kỹ thuật lên men truyền thống hơn trăm năm này kiên trì sử dụng men chua tự nhiên truyền thống nhào nặn thủ công, bánh màn thầu hấp ra thơm lừng mùi lúa mì, dẻo dai ngon miệng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [满] (mǎn) - đầy, tràn đầy; làm đầy; tròn đủ (tuổi, thời hạn) [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '满' AND pinyin = 'mǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '满'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'mǎn',
      meaning_vi = 'đầy, tràn đầy; làm đầy; tròn đủ (tuổi, thời hạn)',
      example_hanzi = '周末的放映厅里座无虚席，坐满了前来观看新电影的年轻观众。',
      example_pinyin = 'Zhōumò de fàngyìngtīng lǐ zuòwúxūxí, zuò mǎn le qiánlái guānkàn xīn diànyǐng de niánqīng guānzhòng.',
      example_vi = 'Phòng chiếu rạp phim cuối tuần không còn chỗ trống, ngồi chật kín khán giả trẻ tuổi đến đón xem bộ phim mới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末的放映厅里座无虚席，坐满了前来观看新电影的年轻观众。', 'Zhōumò de fàngyìngtīng lǐ zuòwúxūxí, zuò mǎn le qiánlái guānkàn xīn diànyǐng de niánqīng guānzhòng.', 'Phòng chiếu rạp phim cuối tuần không còn chỗ trống, ngồi chật kín khán giả trẻ tuổi đến đón xem bộ phim mới.', 'basic', 1),
        (v_id, '当科研攻关团队经过数千次失败终于成功突破核心芯片制造极限时，每个人的心中都充满了无以言表的欣慰与崇高成就感。', 'Dāng kēyán gōngguān tuánduì jīngguò shù qiān cì shībài zhōngyú chénggōng tūpò héxīn xīnpiàn zhìzào jíxiàn shí, měi gè rén de xīnzhōng dōu chōngmǎn le wúyǐyánbiǎo de xīnwèi yǔ chónggāo chéngjiùgǎn.', 'Khi đội ngũ nghiên cứu đột phá trải qua hàng nghìn lần thất bại cuối cùng đã bứt phá thành công giới hạn chế tạo chip cốt lõi, trong lòng mỗi người đều tràn ngập niềm an ủi không lời nào tả xiết và cảm giác thành tựu cao cả.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [毛巾] (máojīn) - khăn mặt, khăn lông, khăn tắm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '毛巾' AND pinyin = 'máojīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '毛巾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'máojīn',
      meaning_vi = 'khăn mặt, khăn lông, khăn tắm',
      example_hanzi = '洗完脸后，请用干净柔软的纯棉纯白毛巾把脸上的水轻轻擦干。',
      example_pinyin = 'Xǐ wán liǎn hòu, qǐng yòng gānjìng róuruǎn de chúnmián chún bái máojīn bǎ liǎn shang de shuǐ qīngqīng cā gān.',
      example_vi = 'Sau khi rửa mặt xong, xin hãy dùng chiếc khăn lông cotton trắng tinh mềm mại sạch sẽ lau khô nhẹ nhàng nước trên mặt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '洗完脸后，请用干净柔软的纯棉纯白毛巾把脸上的水轻轻擦干。', 'Xǐ wán liǎn hòu, qǐng yòng gānjìng róuruǎn de chúnmián chún bái máojīn bǎ liǎn shang de shuǐ qīngqīng cā gān.', 'Sau khi rửa mặt xong, xin hãy dùng chiếc khăn lông cotton trắng tinh mềm mại sạch sẽ lau khô nhẹ nhàng nước trên mặt.', 'basic', 1),
        (v_id, '为了践行绿色低碳环保与减塑倡议，现代高端星级连锁酒店积极倡导常住旅客根据实际需求减少一次性毛巾与床单的过度更换频次。', 'Wèile jiànxíng lǜsè dītàn huánbǎo yǔ jiǎnsù chàngyì, xiàndài gāoduān xīngjí liánsuǒ jiǔdiàn jījí chàngdǎo chángzhù lǚkè gēnjù shíjì xūqiú jiǎnshǎo yícìxìng máojīn yǔ chuángdān de guòdù gēnghuàn píncì.', 'Để thực thi sáng kiến bảo vệ môi trường xanh ít phát thải và giảm thiểu rác thải nhựa, các chuỗi khách sạn hạng sao cao cấp hiện đại tích cực kêu gọi khách lưu trú dài ngày căn cứ theo nhu cầu thực tế giảm bớt tần suất thay thế quá mức khăn tắm và ga trải giường dùng một lần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [毛衣] (máoyī) - áo len [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '毛衣' AND pinyin = 'máoyī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '毛衣'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'máoyī',
      meaning_vi = 'áo len',
      example_hanzi = '天气转冷了，出门时里面穿一件保暖的羊绒毛衣会感觉非常舒服温暖。',
      example_pinyin = 'Tiānqì zhuǎn lěng le, chūmén shí lǐmiàn chuān yí jiàn bǎonuǎn de yángróng máoyī huì gǎnjué fēicháng shūfu wēnnuǎn.',
      example_vi = 'Thời tiết chuyển lạnh rồi, khi ra ngoài bên trong mặc một chiếc áo len lông cừu giữ nhiệt sẽ cảm thấy vô cùng thoải mái và ấm áp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '天气转冷了，出门时里面穿一件保暖的羊绒毛衣会感觉非常舒服温暖。', 'Tiānqì zhuǎn lěng le, chūmén shí lǐmiàn chuān yí jiàn bǎonuǎn de yángróng máoyī huì gǎnjué fēicháng shūfu wēnnuǎn.', 'Thời tiết chuyển lạnh rồi, khi ra ngoài bên trong mặc một chiếc áo len lông cừu giữ nhiệt sẽ cảm thấy vô cùng thoải mái và ấm áp.', 'basic', 1),
        (v_id, '母亲亲手一针一线编织的那件粗花呢暖心纯羊毛毛衣，无论走遍千山万水，始终是游子心底最温暖深沉的岁月记忆。', 'Mǔqīn qīnshǒu yì zhēn yí xiàn biānzhī de nà jiàn cūhuāní nuǎnxīn chún yángmáo máoyī, wúlùn zǒu biàn qiānshān-wànshuǐ, shǐzhōng shì yóuzǐ xīndǐ zuì wēnnuǎn shēnchén de suìyuè jìyì.', 'Chiếc áo len thuần lông cừu ấm áp đan tay từng đường kim mũi chỉ của mẹ, bất kể đi khắp muôn dặm nẻo đường, luôn luôn là ký ức năm tháng ấm áp sâu lắng nhất tận đáy lòng người con xa xứ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [帽子] (màozi) - mũ, nón [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '帽子' AND pinyin = 'màozi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '帽子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'màozi',
      meaning_vi = 'mũ, nón',
      example_hanzi = '夏天出门旅行时戴上一顶宽檐遮阳草帽子，可以有效防止阳光紫外线晒伤皮肤。',
      example_pinyin = 'Xiàtiān chūmén lǚxíng shí dài shàng yì dǐng kuānyán zhēyáng cǎomàozi, kěyǐ yǒuxiào fángzhǐ yángguāng zǐwàixiàn shàishāng pífū.',
      example_vi = 'Mùa hè khi đi du lịch ra ngoài đội một chiếc mũ cói che nắng vành rộng có thể phòng ngừa tia cực tím ánh mặt trời làm cháy rát da một cách hiệu quả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夏天出门旅行时戴上一顶宽檐遮阳草帽子，可以有效防止阳光紫外线晒伤皮肤。', 'Xiàtiān chūmén lǚxíng shí dài shàng yì dǐng kuānyán zhēyáng cǎomàozi, kěyǐ yǒuxiào fángzhǐ yángguāng zǐwàixiàn shàishāng pífū.', 'Mùa hè khi đi du lịch ra ngoài đội một chiếc mũ cói che nắng vành rộng có thể phòng ngừa tia cực tím ánh mặt trời làm cháy rát da một cách hiệu quả.', 'basic', 1),
        (v_id, '在重特大建筑工程施工与高危地下矿山作业现场，所有进入作业区域的一线施工技术人员必须严格佩戴标准安全防撞防护帽子。', 'Zài zhòngtèdà jiànzhù gōngchéng shīgōng yǔ gāowēi dìxià kuàngshān zuòyè xiànchǎng, suǒyǒu jìnrù zuòyè qūyù de yīxiàn shīgōng jìshù rényuán bìxū yángé pèidài biāozhǔn ānquán fángzhuàng fánghù màozi.', 'Tại hiện trường thi công công trình xây dựng đặc biệt lớn và vận hành mỏ ngầm dưới lòng đất có độ nguy hiểm cao, tất cả nhân viên kỹ thuật thi công tuyến đầu bước vào khu vực tác nghiệp đều bắt buộc phải đội mũ bảo hộ chống va đập đạt chuẩn một cách nghiêm ngặt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [美] (měi) - đẹp, xinh đẹp; tốt đẹp [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '美' AND pinyin = 'měi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '美'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'měi',
      meaning_vi = 'đẹp, xinh đẹp; tốt đẹp',
      example_hanzi = '桂林山水甲天下，那里的碧水青山真是美不胜收。',
      example_pinyin = 'Guìlín shānshuǐ jiǎ tiānxià, nàlǐ de bìshuǐ-qīngshān zhēn shì měibùshèngshōu.',
      example_vi = 'Non nước Quế Lâm đệ nhất thiên hạ, cảnh non xanh nước biếc nơi ấy quả thực đẹp không sao tả xiết.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '桂林山水甲天下，那里的碧水青山真是美不胜收。', 'Guìlín shānshuǐ jiǎ tiānxià, nàlǐ de bìshuǐ-qīngshān zhēn shì měibùshèngshōu.', 'Non nước Quế Lâm đệ nhất thiên hạ, cảnh non xanh nước biếc nơi ấy quả thực đẹp không sao tả xiết.', 'basic', 1),
        (v_id, '真正的艺术之美不仅体现在形式技法的炉火纯青，更深植于作品所传递出的对人类真善美的深邃关怀与崇高精神追求。', 'Zhēnzhèng de yìshù zhī měi bùjǐn tǐxiàn zài xíngshì jìfǎ de lúhuǒ-chúnqīng, gèng shēn zhí yú zuòpǐn suǒ chuándì chū de duì rénlèi zhēn-shàn-měi de shēnsuì guānhuái yǔ chónggāo jīngshén zhuīqiú.', 'Vẻ đẹp thực sự của nghệ thuật không chỉ thể hiện ở kỹ xảo hình thức đạt tới độ điêu luyện chín muồi, mà còn bén rễ sâu sắc ở sự quan tâm sâu lắng và sự theo đuổi tinh thần cao cả đối với Chân - Thiện - Mỹ của nhân loại truyền tải qua tác phẩm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 5: #1401 -> #1500)!', v_count;
END $$;
