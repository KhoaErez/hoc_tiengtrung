-- ====================================================================
-- MIGRATION PATCH: BỔ SUNG 4 TỪ VỰNG & 8 CÂU VÍ DỤ CÒN THIẾU TRONG BATCH 9
-- Các từ: #1815 [小组], #1818 [血], #1819 [心], #1822 [信号]
-- Nâng tổng tiến độ HSK 4 lên đúng 899 / 999 từ (đúng 90.0% = 1.798 ví dụ)
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
  -- 1. [小组] (xiǎozǔ) - tổ nhỏ, nhóm nhỏ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '小组'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiǎozǔ',
      meaning_vi = 'tổ nhỏ, nhóm nhỏ',
      example_hanzi = '为了完成这次历史调研报告，全班同学自愿分成了五个兴趣合作小组。',
      example_pinyin = 'Wèile wánchéng zhè cì lìshǐ diàoyán bàogào, quánbān tóngxué zìyuàn fēnchéng le wǔ gè xìngqù hézuò xiǎozǔ.',
      example_vi = 'Để hoàn thành bản báo cáo nghiên cứu lịch sử lần này, cả lớp đã tự nguyện chia thành năm nhóm nhỏ hợp tác theo sở thích.'
    WHERE id = v_id;

    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了完成这次历史调研报告，全班同学自愿分成了五个兴趣合作小组。', 'Wèile wánchéng zhè cì lìshǐ diàoyán bàogào, quánbān tóngxué zìyuàn fēnchéng le wǔ gè xìngqù hézuò xiǎozǔ.', 'Để hoàn thành bản báo cáo nghiên cứu lịch sử lần này, cả lớp đã tự nguyện chia thành năm nhóm nhỏ hợp tác theo sở thích.', 'basic', 1),
        (v_id, '国务院成立跨部门重大科技攻关专项领导小组，统筹推进国家战略科技力量布局与体制机制创新。', 'Guówùyuàn chénglì kuà-bùmén zhòngdà kējì gōngguān zhuānxiàng lǐngdǎo xiǎozǔ, tǒngchóu tuījìn guójiā zhànlüè kējì lìliàng bùjú yǔ tǐzhì jīzhì chuàngxīn.', 'Quốc vụ viện thành lập tổ lãnh đạo chuyên trách đột phá khoa học công nghệ trọng đại liên ngành, điều phối tổng thể việc bố trí lực lượng khoa học công nghệ chiến lược quốc gia và đổi mới thể chế cơ chế.', 'applied', 2);
    END IF;
    v_count := v_count + 1;
  END IF;

  -- 2. [血] (xiě) - máu, huyết [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '血'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiě',
      meaning_vi = 'máu, huyết',
      example_hanzi = '他不小心划破了手指，鲜红的血立刻从伤口渗了出来。',
      example_pinyin = 'Tā bù xiǎoxīn huápò le shǒuzhǐ, xiānhóng de xiě lìkè cóng shāngkǒu shèn le chūlái.',
      example_vi = 'Anh ấy không may làm trầy ngón tay, máu tươi đỏ thắm lập tức rỉ ra từ vết thương.'
    WHERE id = v_id;

    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他不小心划破了手指，鲜红的血立刻从伤口渗了出来。', 'Tā bù xiǎoxīn huápò le shǒuzhǐ, xiānhóng de xiě lìkè cóng shāngkǒu shèn le chūlái.', 'Anh ấy không may làm trầy ngón tay, máu tươi đỏ thắm lập tức rỉ ra từ vết thương.', 'basic', 1),
        (v_id, '无偿献血不仅是拯救临床危重病患生命的崇高人道主义奉献善举，也是一座城市精神文明水平的重要体现。', 'Wúcháng xiànxiě bùjǐn shì zhěngjiù línchuáng wēizhòng bìnghuàn shēngmìng de chónggāo réndàozhǔyì fèngxiàn shànjǔ, yě shì yí zuò chéngshì jīngshén wénmíng shuǐpíng de zhòngyào tǐxiàn.', 'Hiến máu tình nguyện không chỉ là nghĩa cử nhân đạo cao đẹp cống hiến cứu sống tính mạng người bệnh nguy kịch trong điều trị lâm sàng, mà còn là biểu hiện quan trọng về trình độ văn minh tinh thần của một thành phố.', 'applied', 2);
    END IF;
    v_count := v_count + 1;
  END IF;

  -- 3. [心] (xīn) - tim, lòng, tâm trí [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '心'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xīn',
      meaning_vi = 'tim, lòng, tâm trí',
      example_hanzi = '听到医生的检查结果一切正常，妈妈悬着的一颗心终于踏实地放了下来。',
      example_pinyin = 'Tīngdào yīshēng de jiǎnchá jiéguǒ yíqiè zhèngcháng, māma xuánzhe de yì kē xīn zhōngyú tàshi de fàng le xiàlái.',
      example_vi = 'Nghe bác sĩ thông báo kết quả khám mọi thứ đều bình thường, trái tim đang thấp thỏm của mẹ cuối cùng cũng yên lòng buông xuống được.'
    WHERE id = v_id;

    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到医生的检查结果一切正常，妈妈悬着的一颗心终于踏实地放了下来。', 'Tīngdào yīshēng de jiǎnchá jiéguǒ yíqiè zhèngcháng, māma xuánzhe de yì kē xīn zhōngyú tàshi de fàng le xiàlái.', 'Nghe bác sĩ thông báo kết quả khám mọi thứ đều bình thường, trái tim đang thấp thỏm của mẹ cuối cùng cũng yên lòng buông xuống được.', 'basic', 1),
        (v_id, '医者仁心，广大医务工作者将保障人民身体健康与生命安全的崇高初心化作日夜坚守救死扶伤的无私奉献。', 'Yīzhě rénxīn, guǎngdà yīwù gōngzuòzhě jiāng bǎozhàng rénmín shēntǐ jiànkāng yǔ shēngmìng ānquán de chónggāo chūxīn huà zuò rì yè jiānshǒu jiùsǐ-fúshāng de wúsī fèngxiàn.', 'Lương y như từ mẫu, đội ngũ cán bộ y tế đông đảo đã biến tấm lòng ban đầu cao cả bảo vệ sức khỏe thể chất và an toàn tính mạng của nhân dân thành sự cống hiến quên mình ngày đêm bám trụ cứu người chữa bệnh.', 'applied', 2);
    END IF;
    v_count := v_count + 1;
  END IF;

  -- 4. [信号] (xìnhào) - tín hiệu, sóng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '信号'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xìnhào',
      meaning_vi = 'tín hiệu, sóng',
      example_hanzi = '列车进入长长的山区隧道后，手机的网络信号突然变得非常微弱。',
      example_pinyin = 'Lièchē jìnrù chángcháng de shānqū suìdào hòu, shǒujī de wǎngluò xìnhào tūrán biàn de fēicháng wēiruò.',
      example_vi = 'Sau khi đoàn tàu đi vào đường hầm miền núi dài hun hút, sóng mạng điện thoại đột nhiên trở nên rất yếu.'
    WHERE id = v_id;

    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '列车进入长长的山区隧道后，手机的网络信号突然变得非常微弱。', 'Lièchē jìnrù chángcháng de shānqū suìdào hòu, shǒujī de wǎngluò xìnhào tūrán biàn de fēicháng wēiruò.', 'Sau khi đoàn tàu đi vào đường hầm miền núi dài hun hút, sóng mạng điện thoại đột nhiên trở nên rất yếu.', 'basic', 1),
        (v_id, '央行下调金融机构存款准备金率，向宏观经济释放了坚定实施稳健宽松货币政策、全力支持实体经济复苏的积极信号。', 'Yāngháng xiàtiáo jīnróng jīgòu cúnkuǎn zhǔnbèijīnlǜ, xiàng hóngguān jīngjì shìfàng le jiāndìng shíshī wěnjiàn kuānsōng huòbì zhèngcè, quánlì zhīchí shítǐ jīngjì fùsū de jījí xìnhào.', 'Ngân hàng Trung ương hạ tỷ lệ dự trữ bắt buộc của các tổ chức tài chính, giải phóng tín hiệu tích cực tới nền kinh tế vĩ mô về việc kiên định thực thi chính sách tiền tệ nới lỏng thận trọng, dốc toàn lực hỗ trợ sự phục hồi của kinh tế thực.', 'applied', 2);
    END IF;
    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp ví dụ cho % từ vựng HSK 4 patch bổ sung!', v_count;
END $$;
