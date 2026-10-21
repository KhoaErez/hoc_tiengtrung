-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 7 (100 TỪ CTI / 99 BẢN GHI DB)
-- Phạm vi: #1601 [全球] (quánqiú) -> #1700 [说明] (shuōmíng)
-- Tổng số câu ví dụ: 198 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Ghi chú:
--   - CTI #1646 và #1647 đều là '生' (shēng), được chuẩn hóa thành 1 bản ghi duy nhất
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
  -- [全球] (quánqiú) - toàn cầu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '全球' AND pinyin = 'quánqiú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '全球'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'quánqiú',
      meaning_vi = 'toàn cầu',
      example_hanzi = '随着互联网技术的飞速发展，全球各地的联系变得越来越紧密。',
      example_pinyin = 'Suízhe hùliánwǎng jìshù de fēisù fāzhǎn, quánqiú gèdì de liánxì biànde yuèláiyuè jǐnmì.',
      example_vi = 'Cùng với sự phát triển nhanh chóng của công nghệ Internet, mối liên hệ giữa các nơi trên toàn cầu trở nên ngày càng gắn kết.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着互联网技术的飞速发展，全球各地的联系变得越来越紧密。', 'Suízhe hùliánwǎng jìshù de fēisù fāzhǎn, quánqiú gèdì de liánxì biànde yuèláiyuè jǐnmì.', 'Cùng với sự phát triển nhanh chóng của công nghệ Internet, mối liên hệ giữa các nơi trên toàn cầu trở nên ngày càng gắn kết.', 'basic', 1),
        (v_id, '面对气候变化等严峻挑战，国际社会必须加强合作，共同维护全球生态安全。', 'Miànduì qìhòu biànhuà děng yánjùn tiǎozhàn, guójì shèhuì bìxū jiāqiáng hézuò, gòngtóng wéihù quánqiú shēngtài ānquán.', 'Trước những thách thức nghiêm trọng như biến đổi khí hậu, cộng đồng quốc tế bắt buộc phải tăng cường hợp tác, cùng nhau duy trì an ninh sinh thái toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [全身] (quánshēn) - toàn thân, khắp người [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '全身' AND pinyin = 'quánshēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '全身'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'quánshēn',
      meaning_vi = 'toàn thân, khắp người',
      example_hanzi = '昨天跑完长跑以后，我今天感觉全身酸痛，连走路都很吃力。',
      example_pinyin = 'Zuótiān pǎo wán chángpǎo yǐhòu, wǒ jīntiān gǎnjué quánshēn suāntòng, lián zǒulù dōu hěn chīlì.',
      example_vi = 'Hôm qua sau khi chạy đường dài xong, hôm nay tôi cảm thấy toàn thân đau nhức, đến đi lại cũng rất vất vả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '昨天跑完长跑以后，我今天感觉全身酸痛，连走路都很吃力。', 'Zuótiān pǎo wán chángpǎo yǐhòu, wǒ jīntiān gǎnjué quánshēn suāntòng, lián zǒulù dōu hěn chīlì.', 'Hôm qua sau khi chạy đường dài xong, hôm nay tôi cảm thấy toàn thân đau nhức, đến đi lại cũng rất vất vả.', 'basic', 1),
        (v_id, '医生建议患者每年进行一次系统的全身健康体检，以便及早发现潜在的健康隐患。', 'Yīshēng jiànyì huànzhě měi nián jìnxíng yí cì xìtǒng de quánshēn jiànkāng tǐjiǎn, yǐbiàn jízǎo fāxiàn qiánzài de jiànkāng yǐnhuàn.', 'Bác sĩ kiến nghị người bệnh mỗi năm nên tiến hành kiểm tra sức khỏe toàn thân một cách có hệ thống, để sớm phát hiện các nguy cơ sức khỏe tiềm ẩn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [缺] (quē) - thiếu, khuyết, vắng mặt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '缺' AND pinyin = 'quē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '缺'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'quē',
      meaning_vi = 'thiếu, khuyết, vắng mặt',
      example_hanzi = '我们在做西红柿炒鸡蛋，发现厨房里正好缺了一点儿白糖。',
      example_pinyin = 'Wǒmen zài zuò xīhóngshì chǎo jīdàn, fāxiàn chúfáng lǐ zhènghǎo quē le yìdiǎnr báitáng.',
      example_vi = 'Chúng tôi đang làm món cà chua xào trứng thì phát hiện trong bếp vừa vặn thiếu một chút đường trắng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们在做西红柿炒鸡蛋，发现厨房里正好缺了一点儿白糖。', 'Wǒmen zài zuò xīhóngshì chǎo jīdàn, fāxiàn chúfáng lǐ zhènghǎo quē le yìdiǎnr báitáng.', 'Chúng tôi đang làm món cà chua xào trứng thì phát hiện trong bếp vừa vặn thiếu một chút đường trắng.', 'basic', 1),
        (v_id, '这次新产品的研发项目技术要求极高，目前团队内部最缺的就是有丰富实战经验的高级算法工程师。', 'Zhè cì xīn chǎnpǐn de yánfā xiàngmù jìshù yāoqiú jí gāo, mùqián tuánduì nèibù zuì quē de jiùshì yǒu fēngfù shízhàn jīngyàn de gāojí suànfǎ gōngchéngshī.', 'Dự án nghiên cứu phát triển sản phẩm mới lần này yêu cầu kỹ thuật cực cao, hiện tại trong nội bộ đội ngũ thiếu nhất chính là kỹ sư thuật toán cao cấp có kinh nghiệm thực chiến phong phú.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [缺点] (quēdiǎn) - khuyết điểm, nhược điểm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '缺点' AND pinyin = 'quēdiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '缺点'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'quēdiǎn',
      meaning_vi = 'khuyết điểm, nhược điểm',
      example_hanzi = '每个人都有自己的优点和缺点，我们要学会包容和理解别人。',
      example_pinyin = 'Měi gè rén dōu yǒu zìjǐ de yōudiǎn hé quēdiǎn, wǒmen yào xuéhuì bāoróng hé lǐjiě biérén.',
      example_vi = 'Mỗi người đều có ưu điểm và khuyết điểm của riêng mình, chúng ta cần học cách bao dung và thấu hiểu người khác.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每个人都有自己的优点和缺点，我们要学会包容和理解别人。', 'Měi gè rén dōu yǒu zìjǐ de yōudiǎn hé quēdiǎn, wǒmen yào xuéhuì bāoróng hé lǐjiě biérén.', 'Mỗi người đều có ưu điểm và khuyết điểm của riêng mình, chúng ta cần học cách bao dung và thấu hiểu người khác.', 'basic', 1),
        (v_id, '在求职面试中，客观诚恳地评价自己的缺点并说明改进方案，往往能展现出成熟稳重的职业素养。', 'Zài qiúzhí miànshì zhōng, kèguān chéngkěn de píngjià zìjǐ de quēdiǎn bìng shuōmíng gǎijìn fāng’àn, wǎngwǎng néng zhǎnxiàn chū chéngshú wěnzhòng de zhíyè sùyǎng.', 'Trong buổi phỏng vấn xin việc, việc khách quan chân thành đánh giá khuyết điểm của bản thân và nêu rõ phương án khắc phục thường thể hiện tố chất nghề nghiệp chín chắn và đáng tin cậy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [缺少] (quēshǎo) - thiếu, thiếu hụt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '缺少' AND pinyin = 'quēshǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '缺少'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'quēshǎo',
      meaning_vi = 'thiếu, thiếu hụt',
      example_hanzi = '他因为长期缺少体育锻炼，体质变得比较虚弱。',
      example_pinyin = 'Tā yīnwèi chángqī quēshǎo tǐyù duànliàn, tǐzhì biànde bǐjiào xūruò.',
      example_vi = 'Anh ấy do lâu ngày thiếu rèn luyện thể dục thể thao nên thể chất trở nên khá yếu ớt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他因为长期缺少体育锻炼，体质变得比较虚弱。', 'Tā yīnwèi chángqī quēshǎo tǐyù duànliàn, tǐzhì biànde bǐjiào xūruò.', 'Anh ấy do lâu ngày thiếu rèn luyện thể dục thể thao nên thể chất trở nên khá yếu ớt.', 'basic', 1),
        (v_id, '偏远乡村教育事业最缺少的是优秀的师资力量和现代化的多媒体教学设施。', 'Piānyuǎn xiāngcūn jiàoyù shìyè zuì quēshǎo de shì yōuxiù de shīzī lìliàng hé xiàndàihuà de duōméitǐ jiàoxué shèshī.', 'Điều mà sự nghiệp giáo dục ở các vùng nông thôn xa xôi hẻo lánh thiếu thốn nhất chính là đội ngũ giáo viên ưu tú và các trang thiết bị giảng dạy đa phương tiện hiện đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [却] (què) - lại, nhưng mà [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '却' AND pinyin = 'què'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '却'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'què',
      meaning_vi = 'lại, nhưng mà',
      example_hanzi = '外面虽然下着大雨，但他却坚持准时去操场跑步。',
      example_pinyin = 'Wàimiàn suīrán xiàzhe dàyǔ, dàn tā què jiānchí zhǔnshí qù cāochǎng pǎobù.',
      example_vi = 'Bên ngoài trời tuy đang mưa to, nhưng anh ấy lại kiên trì đi ra sân tập chạy bộ đúng giờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '外面虽然下着大雨，但他却坚持准时去操场跑步。', 'Wàimiàn suīrán xiàzhe dàyǔ, dàn tā què jiānchí zhǔnshí qù cāochǎng pǎobù.', 'Bên ngoài trời tuy đang mưa to, nhưng anh ấy lại kiên trì đi ra sân tập chạy bộ đúng giờ.', 'basic', 1),
        (v_id, '许多创业者虽然付出了巨大的努力，却往往因为市场调研不足而遭遇严重的商业挫折。', 'Xǔduō chuàngyèzhě suīrán fùchū le jùdà de nǔlì, què wǎngwǎng yīnwèi shìchǎng diàoyán bùzú ér zāoyù yánzhòng de shāngyè cuòzhé.', 'Nhiều người khởi nghiệp tuy đã bỏ ra nỗ lực to lớn, nhưng lại thường vì nghiên cứu thị trường chưa đủ mà gặp phải thất bại kinh doanh nghiêm trọng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [确实] (quèshí) - quả thực, thực sự [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '确实' AND pinyin = 'quèshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '确实'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'quèshí',
      meaning_vi = 'quả thực, thực sự',
      example_hanzi = '这道四川菜的辣味确实名不虚传，吃得我满头大汗。',
      example_pinyin = 'Zhè dào Sìchuān cài de làwèi quèshí míngbùxūchuán, chī de wǒ mǎntóudàhàn.',
      example_vi = 'Vị cay của món ăn Tứ Xuyên này quả thực danh bất hư truyền, làm tôi ăn đến mức toát mồ hôi đầm đìa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这道四川菜的辣味确实名不虚传，吃得我满头大汗。', 'Zhè dào Sìchuān cài de làwèi quèshí míngbùxūchuán, chī de wǒ mǎntóudàhàn.', 'Vị cay của món ăn Tứ Xuyên này quả thực danh bất hư truyền, làm tôi ăn đến mức toát mồ hôi đầm đìa.', 'basic', 1),
        (v_id, '从最新的财务报表数据来看，公司在第三季度的经营效益确实取得了显著的稳步提升。', 'Cóng zuìxīn de cáiwù bàobiǎo shùjù lái kàn, gōngsī zài dì-sān jǐdù de jīngyíng xiàoyì quèshí qǔdé le xiǎnzhù de wěnbù tíshēng.', 'Nhìn từ số liệu báo cáo tài chính mới nhất, hiệu quả kinh doanh của công ty trong quý ba quả thực đã đạt được sự cải thiện vững chắc rõ rệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [然而] (rán’ér) - tuy nhiên, thế nhưng [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '然而' AND pinyin = 'rán’ér'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '然而'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'rán’ér',
      meaning_vi = 'tuy nhiên, thế nhưng',
      example_hanzi = '大家都以为这次考试很容易，然而实际答卷时才发现难度很大。',
      example_pinyin = 'Dàjiā dōu yǐwéi zhè cì kǎoshì hěn róngyì, rán’ér shíjì dájuàn shí cái fāxiàn nándù hěn dà.',
      example_vi = 'Mọi người đều ngỡ rằng kỳ thi lần này rất dễ, tuy nhiên khi làm bài thực tế mới nhận thấy độ khó rất cao.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大家都以为这次考试很容易，然而实际答卷时才发现难度很大。', 'Dàjiā dōu yǐwéi zhè cì kǎoshì hěn róngyì, rán’ér shíjì dájuàn shí cái fāxiàn nándù hěn dà.', 'Mọi người đều ngỡ rằng kỳ thi lần này rất dễ, tuy nhiên khi làm bài thực tế mới nhận thấy độ khó rất cao.', 'basic', 1),
        (v_id, '新技术的大规模应用虽然极大地提高了生产效率，然而同时也给传统行业的就业结构带来了深刻的变革与压力。', 'Xīn jìshù de dà guīmó yìngyòng suīrán jídà de tígāo le shēngchǎn xiàolǜ, rán’ér tóngshí yě gěi chuántǒng hángyè de jiùyè jiégòu dàilái le shēnkè de biàngé yǔ yālì.', 'Việc ứng dụng quy mô lớn công nghệ mới tuy nâng cao hiệu suất sản xuất rất lớn, tuy nhiên đồng thời cũng mang lại áp lực và sự thay đổi sâu sắc cho cơ cấu việc làm của ngành truyền thống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [热闹] (rènao) - náo nhiệt, sôi động; cảnh nhộn nhịp [Tính từ / Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '热闹' AND pinyin = 'rènao'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '热闹'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ / Danh từ',
      pinyin = 'rènao',
      meaning_vi = 'náo nhiệt, sôi động; cảnh nhộn nhịp',
      example_hanzi = '逢年过节的时候，步行街上张灯结彩，到处都十分热闹。',
      example_pinyin = 'Féngnián-guòjié de shíhou, bùxíngjiē shang zhāngdēng-jiécǎi, dàochù dōu shífēn rènao.',
      example_vi = 'Vào dịp lễ tết, trên phố đi bộ giăng đèn kết hoa, khắp nơi đều vô cùng náo nhiệt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '逢年过节的时候，步行街上张灯结彩，到处都十分热闹。', 'Féngnián-guòjié de shíhou, bùxíngjiē shang zhāngdēng-jiécǎi, dàochù dōu shífēn rènao.', 'Vào dịp lễ tết, trên phố đi bộ giăng đèn kết hoa, khắp nơi đều vô cùng náo nhiệt.', 'basic', 1),
        (v_id, '文化旅游节开幕式吸引了数万名海内外游客前来观赏，为这座历史文化名城增添了繁华热闹的气氛。', 'Wénhuà lǚyóu jié kāimùshì xīyǐn le shù wàn míng hǎinèiwài yóukè qiánlái guānshǎng, wèi zhè zuò lìshǐ wénhuà míngchéng zēngtiān le fánhuá rènao de qìfēn.', 'Lễ khai mạc lễ hội du lịch văn hóa đã thu hút hàng vạn du khách trong và ngoài nước đến thưởng ngoạn, tăng thêm bầu không khí phồn hoa náo nhiệt cho thành phố danh tiếng lịch sử văn hóa này.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [人生] (rénshēng) - nhân sinh, cuộc đời, đời người [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '人生' AND pinyin = 'rénshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '人生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'rénshēng',
      meaning_vi = 'nhân sinh, cuộc đời, đời người',
      example_hanzi = '读一本好书就像与智者交谈，能给我们的人生指明前进的方向。',
      example_pinyin = 'Dú yì běn hǎo shū jiù xiàng yǔ zhìzhě jiāotán, néng gěi wǒmen de rénshēng zhǐmíng qiánjìn de fāngxiàng.',
      example_vi = 'Đọc một cuốn sách hay giống như trò chuyện cùng bậc trí giả, có thể chỉ rõ phương hướng tiến lên cho cuộc đời chúng ta.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '读一本好书就像与智者交谈，能给我们的人生指明前进的方向。', 'Dú yì běn hǎo shū jiù xiàng yǔ zhìzhě jiāotán, néng gěi wǒmen de rénshēng zhǐmíng qiánjìn de fāngxiàng.', 'Đọc một cuốn sách hay giống như trò chuyện cùng bậc trí giả, có thể chỉ rõ phương hướng tiến lên cho cuộc đời chúng ta.', 'basic', 1),
        (v_id, '面对人生的重大抉择与挫折，保持积极乐观的心态并勇于承担责任，是成就一番事业的基石。', 'Miànduì rénshēng de zhòngdà juézé yǔ cuòzhé, bǎochí jījí lèguān de xīntài bìng yǒngyú chéngdān zérèn, shì chéngjiù yì fān shìyè de jīshí.', 'Đối mặt trước những ngã rẽ và trắc trở lớn của cuộc đời, giữ vững tâm thái tích cực lạc quan và dũng cảm gánh vác trách nhiệm là nền tảng để làm nên sự nghiệp lớn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [人数] (rénshù) - số người, nhân số [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '人数' AND pinyin = 'rénshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '人数'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'rénshù',
      meaning_vi = 'số người, nhân số',
      example_hanzi = '参加这次汉语角活动的人数超过了五十人，现场座无虚席。',
      example_pinyin = 'Cānjiā zhè cì Hànyǔ jiǎo huódòng de rénshù chāoguò le wǔshí rén, xiànchǎng zuòwúxūxí.',
      example_vi = 'Số người tham gia buổi sinh hoạt góc tiếng Hán lần này đã vượt quá năm mươi người, hội trường không còn chỗ trống.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '参加这次汉语角活动的人数超过了五十人，现场座无虚席。', 'Cānjiā zhè cì Hànyǔ jiǎo huódòng de rénshù chāoguò le wǔshí rén, xiànchǎng zuòwúxūxí.', 'Số người tham gia buổi sinh hoạt góc tiếng Hán lần này đã vượt quá năm mươi người, hội trường không còn chỗ trống.', 'basic', 1),
        (v_id, '由于报考该重点大学研究生的人数创下历史新高，招生录取的竞争竞争异常激烈。', 'Yóuyú bàokǎo gāi zhòngdiǎn dàxué yánjiūshēng de rénshù chuàngxià lìshǐ xīngāo, zhāoshēng lùqǔ de jìngzhēng yìcháng jīliè.', 'Do số người đăng ký dự thi cao học tại trường đại học trọng điểm này lập kỷ lục mới trong lịch sử, sự cạnh tranh xét tuyển nhập học diễn ra vô cùng khốc liệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [人员] (rényuán) - nhân viên, cán bộ, nhân sự [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '人员' AND pinyin = 'rényuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '人员'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'rényuán',
      meaning_vi = 'nhân viên, cán bộ, nhân sự',
      example_hanzi = '非工作人员未经许可请勿擅自进入实验室核心区域。',
      example_pinyin = 'Fēi gōngzuò rényuán wèijīng xǔkě qǐng wù shànzì jìnrù shíyànshì héxīn qūyù.',
      example_vi = 'Người không có nhiệm vụ nếu chưa được cấp phép xin chớ tự ý đi vào khu vực trọng yếu của phòng thí nghiệm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '非工作人员未经许可请勿擅自进入实验室核心区域。', 'Fēi gōngzuò rényuán wèijīng xǔkě qǐng wù shànzì jìnrù shíyànshì héxīn qūyù.', 'Người không có nhiệm vụ nếu chưa được cấp phép xin chớ tự ý đi vào khu vực trọng yếu của phòng thí nghiệm.', 'basic', 1),
        (v_id, '医疗救援人员在发生自然灾害的第一时间赶赴现场，开展了紧张有序的伤员搜救与救治工作。', 'Yīliáo jiùyuán rényuán zài fāshēng zìrán zāihài de dì-yī shíjiān gǎnfù xiànchǎng, kāizhǎn le jǐnzhāng yǒuxù de shāngyuán sōujiù yǔ jiùzhì gōngzuò.', 'Lực lượng nhân viên cứu hộ y tế đã khẩn trương tới hiện trường ngay thời khắc đầu tiên khi thiên tai xảy ra, triển khai công tác tìm kiếm cứu nạn và cấp cứu thương binh vô cùng khẩn trương nhưng trật tự.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [任何] (rènhé) - bất kỳ, bất cứ [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '任何' AND pinyin = 'rènhé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '任何'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ',
      pinyin = 'rènhé',
      meaning_vi = 'bất kỳ, bất cứ',
      example_hanzi = '无论在任何情况下，我们都应该遵守法律法规和基本道德规范。',
      example_pinyin = 'Wúlùn zài rènhé qíngkuàng xià, wǒmen dōu yīnggāi zūnshǒu fǎlǜ fǎguī hé jīběn dàodé guīfàn.',
      example_vi = 'Bất luận trong bất kỳ tình huống nào, chúng ta cũng nên tuân thủ quy định pháp luật và các chuẩn mực đạo đức cơ bản.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '无论在任何情况下，我们都应该遵守法律法规和基本道德规范。', 'Wúlùn zài rènhé qíngkuàng xià, wǒmen dōu yīnggāi zūnshǒu fǎlǜ fǎguī hé jīběn dàodé guīfàn.', 'Bất luận trong bất kỳ tình huống nào, chúng ta cũng nên tuân thủ quy định pháp luật và các chuẩn mực đạo đức cơ bản.', 'basic', 1),
        (v_id, '任何科学研究的突破都离不开严谨求实的态度和日复一日的反复实验验证。', 'Rènhé kēxué yánjiū de tūpò dōu líbùkāi yánjǐn qiúshí de tàidu hé rì fù yí rì de fǎnfù shíyàn yànzhèng.', 'Bất kỳ đột phá nào trong nghiên cứu khoa học cũng không thể tách rời thái độ nghiêm cẩn cầu thị và việc lặp đi lặp lại các thí nghiệm kiểm chứng ngày qua ngày.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [任务] (rènwu) - nhiệm vụ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '任务' AND pinyin = 'rènwu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '任务'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'rènwu',
      meaning_vi = 'nhiệm vụ',
      example_hanzi = '老师给我们布置了一项假期社会调查任务，要求开学前提交报告。',
      example_pinyin = 'Lǎoshī gěi wǒmen bùzhì le yí xiàng jiàqī shèhuì diàochá rènwu, yāoqiú kāixué qián tíjiāo bàogào.',
      example_vi = 'Thầy giáo đã giao cho chúng tôi một nhiệm vụ điều tra xã hội trong kỳ nghỉ, yêu cầu nộp báo cáo trước khi khai giảng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师给我们布置了一项假期社会调查任务，要求开学前提交报告。', 'Lǎoshī gěi wǒmen bùzhì le yí xiàng jiàqī shèhuì diàochá rènwu, yāoqiú kāixué qián tíjiāo bàogào.', 'Thầy giáo đã giao cho chúng tôi một nhiệm vụ điều tra xã hội trong kỳ nghỉ, yêu cầu nộp báo cáo trước khi khai giảng.', 'basic', 1),
        (v_id, '项目团队加班加点通力合作，最终提前两天圆满完成了系统上线的核心任务。', 'Xiàngmù tuánduì jiābān-jiādiǎn tōnglì-hézuò, zuìzhōng tíqián liǎng tiān yuánmǎn wánchéng le xìtǒng shàngxiàn de héxīn rènwu.', 'Đội ngũ dự án đã tăng ca làm thêm chung sức hợp tác, cuối cùng hoàn thành mỹ mãn nhiệm vụ cốt lõi đưa hệ thống lên mạng sớm hơn hai ngày.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [扔] (rēng) - ném, vứt, quăng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '扔' AND pinyin = 'rēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '扔'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'rēng',
      meaning_vi = 'ném, vứt, quăng',
      example_hanzi = '请把吃完的果皮和饮料瓶扔进分类垃圾桶里。',
      example_pinyin = 'Qǐng bǎ chī wán de guǒpí hé yǐnliàopíng rēng jìn fēnlèi lājītǒng lǐ.',
      example_vi = 'Xin hãy vứt vỏ hoa quả và chai nước uống đã dùng xong vào thùng rác phân loại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把吃完的果皮和饮料瓶扔进分类垃圾桶里。', 'Qǐng bǎ chī wán de guǒpí hé yǐnliàopíng rēng jìn fēnlèi lājītǒng lǐ.', 'Xin hãy vứt vỏ hoa quả và chai nước uống đã dùng xong vào thùng rác phân loại.', 'basic', 1),
        (v_id, '不要因为遇到一点挫折就轻易把曾经的理想和目标全部扔掉，坚持才是成功的关键。', 'Búyào yīnwèi yùdào yìdiǎnr cuòzhé jiù qīngyì bǎ céngjīng de lǐxiǎng hé mùbiāo quánbù rēngdiào, jiānchí cái shì chénggōng de guānjiàn.', 'Đừng vì gặp phải một chút trắc trở mà dễ dàng vứt bỏ toàn bộ lý tưởng và mục tiêu từng có, kiên trì mới là chìa khóa của thành công.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [仍] (réng) - vẫn, còn [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '仍' AND pinyin = 'réng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '仍'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'réng',
      meaning_vi = 'vẫn, còn',
      example_hanzi = '尽管天色已晚，图书馆里仍有不少同学在安静地自习。',
      example_pinyin = 'Jǐnguǎn tiānsè yǐ wǎn, túshūguǎn lǐ réng yǒu bù shǎo tóngxué zài ānjìng de zìxí.',
      example_vi = 'Mặc dù trời đã muộn, trong thư viện vẫn có không ít bạn học đang yên lặng tự học.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '尽管天色已晚，图书馆里仍有不少同学在安静地自习。', 'Jǐnguǎn tiānsè yǐ wǎn, túshūguǎn lǐ réng yǒu bù shǎo tóngxué zài ānjìng de zìxí.', 'Mặc dù trời đã muộn, trong thư viện vẫn có không ít bạn học đang yên lặng tự học.', 'basic', 1),
        (v_id, '虽然国际局势错综复杂，但和平与发展仍是当今时代不可阻挡的主题与大趋势。', 'Suīrán guójì júshì cuòzōng-fùzá, dàn hépíng yǔ fāzhǎn réng shì dāngjīn shídài bùkě zǔdǎng de zhǔtí yǔ dà qūshì.', 'Tuy cục diện quốc tế đan xen phức tạp, nhưng hòa bình và phát triển vẫn là chủ đề và xu thế lớn không thể ngăn cản của thời đại ngày nay.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [仍然] (réngrán) - vẫn, vẫn như cũ [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '仍然' AND pinyin = 'réngrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '仍然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'réngrán',
      meaning_vi = 'vẫn, vẫn như cũ',
      example_hanzi = '经过多次失败，他仍然没有灰心，反而更加努力地寻找解决办法。',
      example_pinyin = 'Jīngguò duō cì shībài, tā réngrán méiyǒu huīxīn, fǎn’ér gèngjiā nǔlì de xúnzhǎo jiějué bànfǎ.',
      example_vi = 'Trải qua nhiều lần thất bại, anh ấy vẫn không hề nản lòng, trái lại càng thêm nỗ lực tìm kiếm giải pháp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过多次失败，他仍然没有灰心，反而更加努力地寻找解决办法。', 'Jīngguò duō cì shībài, tā réngrán méiyǒu huīxīn, fǎn’ér gèngjiā nǔlì de xúnzhǎo jiějué bànfǎ.', 'Trải qua nhiều lần thất bại, anh ấy vẫn không hề nản lòng, trái lại càng thêm nỗ lực tìm kiếm giải pháp.', 'basic', 1),
        (v_id, '即便在数字多媒体时代，纸质经典书籍对于培养深度阅读与独立思考能力仍然具有不可替代的价值。', 'Jíbiàn zài shùzì duōméitǐ shídài, zhǐzhì jīngdiǎn shūjí duìyú péiyǎng shēndù yuèdú yǔ dúlì sīkǎo nénglì réngrán jùyǒu bùkě tìdài de jiàzhí.', 'Ngay cả trong thời đại đa phương tiện số hóa, sách kinh điển bản giấy đối với việc bồi dưỡng năng lực đọc sâu và tư duy độc lập vẫn sở hữu giá trị không thể thay thế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [日常] (rìcháng) - hàng ngày, thường ngày [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '日常' AND pinyin = 'rìcháng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '日常'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'rìcháng',
      meaning_vi = 'hàng ngày, thường ngày',
      example_hanzi = '多用汉语与朋友交流，是提高日常口语表达能力的有效途径。',
      example_pinyin = 'Duō yòng Hànyǔ yǔ péngyou jiāoliú, shì tígāo rìcháng kǒuyǔ biǎodá nénglì de yǒuxiào tújìng.',
      example_vi = 'Dùng nhiều tiếng Hán để giao lưu với bạn bè là con đường hữu hiệu để nâng cao năng lực diễn đạt khẩu ngữ thường ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '多用汉语与朋友交流，是提高日常口语表达能力的有效途径。', 'Duō yòng Hànyǔ yǔ péngyou jiāoliú, shì tígāo rìcháng kǒuyǔ biǎodá nénglì de yǒuxiào tújìng.', 'Dùng nhiều tiếng Hán để giao lưu với bạn bè là con đường hữu hiệu để nâng cao năng lực diễn đạt khẩu ngữ thường ngày.', 'basic', 1),
        (v_id, '企业要建立健全日常安全生产巡查机制，切实防范化解各类安全隐患。', 'Qǐyè yào jiànlì jiànquán rìcháng ānquán shēngchǎn xúnchá jīzhì, qièshí fángfàn huàjiě gèlèi ānquán yǐnhuàn.', 'Doanh nghiệp cần xây dựng và hoàn thiện cơ chế tuần tra sản xuất an toàn hàng ngày, thiết thực phòng ngừa và hóa giải mọi mối nguy hiểm an toàn tiềm ẩn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [日记] (rìjì) - nhật ký [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '日记' AND pinyin = 'rìjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '日记'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'rìjì',
      meaning_vi = 'nhật ký',
      example_hanzi = '他从初中开始就养成了每天晚上睡觉前写日记的良好习惯。',
      example_pinyin = 'Tā cóng chūzhōng kāishǐ jiù yǎngchéng le měi tiān wǎnshang shuìjiào qián xiě rìjì de liánghǎo xíguàn.',
      example_vi = 'Cậu ấy từ thời cấp hai đã hình thành thói quen tốt đẹp là viết nhật ký trước khi đi ngủ mỗi tối.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他从初中开始就养成了每天晚上睡觉前写日记的良好习惯。', 'Tā cóng chūzhōng kāishǐ jiù yǎngchéng le měi tiān wǎnshang shuìjiào qián xiě rìjì de liánghǎo xíguàn.', 'Cậu ấy từ thời cấp hai đã hình thành thói quen tốt đẹp là viết nhật ký trước khi đi ngủ mỗi tối.', 'basic', 1),
        (v_id, '许多历史学家通过研究近代名人的私密日记，发现了许多教科书上未曾记载的重要历史细节。', 'Xǔduō lìshǐxuéjiā tōngguò yánjiū jìndài míngrén de sīmì rìjì, fāxiàn le xǔduō jiàokēshū shang wèicéng jìzǎi de zhòngyào lìshǐ xìjié.', 'Nhiều nhà sử học thông qua việc nghiên cứu nhật ký riêng tư của các danh nhân thời cận đại đã phát hiện nhiều chi tiết lịch sử quan trọng chưa từng được ghi chép trong sách giáo khoa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [日期] (rìqī) - ngày tháng, ngày giờ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '日期' AND pinyin = 'rìqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '日期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'rìqī',
      meaning_vi = 'ngày tháng, ngày giờ',
      example_hanzi = '买食品时一定要看清楚包装袋上的生产日期和保质期。',
      example_pinyin = 'Mǎi shípǐn shí yídìng yào kàn qīngchu bāozhuāngdài shang de shēngchǎn rìqī hé bǎozhìqī.',
      example_vi = 'Khi mua thực phẩm nhất định phải nhìn rõ ngày sản xuất và hạn sử dụng ghi trên bao bì.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '买食品时一定要看清楚包装袋上的生产日期和保质期。', 'Mǎi shípǐn shí yídìng yào kàn qīngchu bāozhuāngdài shang de shēngchǎn rìqī hé bǎozhìqī.', 'Khi mua thực phẩm nhất định phải nhìn rõ ngày sản xuất và hạn sử dụng ghi trên bao bì.', 'basic', 1),
        (v_id, '双方在合同谈判中最终确认了项目交付的截止日期以及阶段性成果验收节点。', 'Shuāngfāng zài hétong tánpàn zhōng zuìzhōng quèrèn le xiàngmù jiāofù de jiézhǐ rìqī yǐjí jiēduànxìng chéngguǒ yànshōu jiédiǎn.', 'Hai bên trong đàm phán hợp đồng cuối cùng đã xác nhận thời hạn chót bàn giao dự án cũng như các mốc nghiệm thu thành quả từng giai đoạn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [日子] (rìzi) - ngày tháng, cuộc sống, ngày [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '日子' AND pinyin = 'rìzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '日子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'rìzi',
      meaning_vi = 'ngày tháng, cuộc sống, ngày',
      example_hanzi = '随着农村经济的发展，乡亲们的生活过得越来越红火，日子越过越甜。',
      example_pinyin = 'Suízhe nóngcūn jīngjì de fāzhǎn, xiāngqīnmen de shēnghuó guò de yuèláiyuè hónghuo, rìzi yuè guò yuè tián.',
      example_vi = 'Cùng với sự phát triển kinh tế nông thôn, đời sống bà con chòm xóm trôi qua ngày càng khấm khá, cuộc sống ngày càng ngọt ngào ấm no.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着农村经济的发展，乡亲们的生活过得越来越红火，日子越过越甜。', 'Suízhe nóngcūn jīngjì de fāzhǎn, xiāngqīnmen de shēnghuó guò de yuèláiyuè hónghuo, rìzi yuè guò yuè tián.', 'Cùng với sự phát triển kinh tế nông thôn, đời sống bà con chòm xóm trôi qua ngày càng khấm khá, cuộc sống ngày càng ngọt ngào ấm no.', 'basic', 1),
        (v_id, '在艰苦奋斗的创业岁月里，虽然日子过得十分清贫，但大家心中都怀揣着对未来的美好期望。', 'Zài jiānkǔ fèndòu de chuàngyè suìyuè lǐ, suīrán rìzi guò de shífēn qīngpín, dàn dàjiā xīnzhōng dōu huáichuǎizhe duì wèilái de měihǎo qīwàng.', '', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [入] (rù) - vào, nhập [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '入' AND pinyin = 'rù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '入'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'rù',
      meaning_vi = 'vào, nhập',
      example_hanzi = '天色已晚，气温骤降，我们赶紧进屋入座取暖。',
      example_pinyin = 'Tiānsè yǐ wǎn, qìwēn zhòujiàng, wǒmen gǎnjǐn jìn wū rù zuò qǔnuǎn.',
      example_vi = 'Trời đã tối, nhiệt độ giảm đột ngột, chúng tôi mau chóng vào nhà ngồi vào chỗ sưởi ấm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '天色已晚，气温骤降，我们赶紧进屋入座取暖。', 'Tiānsè yǐ wǎn, qìwēn zhòujiàng, wǒmen gǎnjǐn jìn wū rù zuò qǔnuǎn.', 'Trời đã tối, nhiệt độ giảm đột ngột, chúng tôi mau chóng vào nhà ngồi vào chỗ sưởi ấm.', 'basic', 1),
        (v_id, '俗话说“入乡随俗”，到一个新的国家生活工作，尊重并融入当地的文化习俗至关重要。', 'Súhuà shuō “rù xiāng suí sú”, dào yí gè xīn de guójiā shēnghuó gōngzuò, zūnzhòng bìng róngrù dāngdì de wénhuà xísú zhìguān zhòngyào.', 'Tục ngữ có câu "nhập gia tùy tục", khi đến một đất nước mới sinh sống làm việc, tôn trọng và hòa nhập vào phong tục văn hóa bản địa là điều vô cùng quan trọng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [入口] (rùkǒu) - lối vào, cửa vào [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '入口' AND pinyin = 'rùkǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '入口'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'rùkǒu',
      meaning_vi = 'lối vào, cửa vào',
      example_hanzi = '地铁站的A号入口处安装了全新的无障碍电梯，方便行动不便的人士通行。',
      example_pinyin = 'Dìtiězhàn de A hào rùkǒuchù ānzhuāng le quánxīn de wúzhàng’ài diàntī, fāngbiàn xíngdòng búbiàn de rénshì tōngxíng.',
      example_vi = 'Tại vị trí cửa vào số A của ga tàu điện ngầm đã lắp đặt thang máy không rào cản hoàn toàn mới, tiện cho người đi lại khó khăn di chuyển.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '地铁站的A号入口处安装了全新的无障碍电梯，方便行动不便的人士通行。', 'Dìtiězhàn de A hào rùkǒuchù ānzhuāng le quánxīn de wúzhàng’ài diàntī, fāngbiàn xíngdòng búbiàn de rénshì tōngxíng.', 'Tại vị trí cửa vào số A của ga tàu điện ngầm đã lắp đặt thang máy không rào cản hoàn toàn mới, tiện cho người đi lại khó khăn di chuyển.', 'basic', 1),
        (v_id, '大型博览会期间，主办方在主入口设置了多台智能人脸识别闸机，极大提升了入场通行效率。', 'Dàxíng bólǎnhuì qījiān, zhǔbànfāng zài zhǔ rùkǒu shèzhì le duō tái zhìnéng rénliǎn shíbié zhájī, jídà tíshēng le rùchǎng tōngxíng xiàolǜ.', 'Trong thời gian diễn ra hội chợ triển lãm lớn, ban tổ chức đã bố trí nhiều cổng kiểm soát nhận diện khuôn mặt thông minh tại lối vào chính, nâng cao hiệu suất vào cổng rất nhiều.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [入学] (rùxué) - nhập học [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '入学' AND pinyin = 'rùxué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '入学'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'rùxué',
      meaning_vi = 'nhập học',
      example_hanzi = '今天是一年级新生入学的日子，校园里洋溢着欢声笑语。',
      example_pinyin = 'Jīntiān shì yīniánjí xīnshēng rùxué de rìzi, xiàoyuán lǐ yángyìzhe huānshēng-xiàoyǔ.',
      example_vi = 'Hôm nay là ngày học sinh mới lớp một nhập học, trong sân trường tràn ngập tiếng cười nói vui tươi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天是一年级新生入学的日子，校园里洋溢着欢声笑语。', 'Jīntiān shì yīniánjí xīnshēng rùxué de rìzi, xiàoyuán lǐ yángyìzhe huānshēng-xiàoyǔ.', 'Hôm nay là ngày học sinh mới lớp một nhập học, trong sân trường tràn ngập tiếng cười nói vui tươi.', 'basic', 1),
        (v_id, '高校在新生入学报到阶段开辟了“绿色通道”，确保家庭经济困难的学生也能顺利办理注册手续。', 'Gāoxiào zài xīnshēng rùxué bàodào jiēduàn kāipì le “lǜsè tōngdào”, quèbǎo jiātíng jīngjì kùnnan de xuésheng yě néng shùnlì bànlǐ zhùcè shǒuxù.', 'Các trường đại học đã mở "kênh xanh" trong giai đoạn tân sinh viên đến nhập học báo danh, bảo đảm sinh viên có gia cảnh khó khăn cũng có thể làm thủ tục đăng ký thuận lợi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [入住] (rùzhù) - nhận phòng, dọn vào ở [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '入住' AND pinyin = 'rùzhù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '入住'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'rùzhù',
      meaning_vi = 'nhận phòng, dọn vào ở',
      example_hanzi = '我们下午两点到达酒店前台办理了入住手续，房间干净整洁。',
      example_pinyin = 'Wǒmen xiàwǔ liǎng diǎn dàodá jiǔdiàn qiántái bànlǐ le rùzhù shǒuxù, fángjiān gānjìng zhěngjié.',
      example_vi = 'Chúng tôi đến quầy lễ tân khách sạn lúc hai giờ chiều để làm thủ tục nhận phòng, phòng ốc sạch sẽ ngăn nắp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们下午两点到达酒店前台办理了入住手续，房间干净整洁。', 'Wǒmen xiàwǔ liǎng diǎn dàodá jiǔdiàn qiántái bànlǐ le rùzhù shǒuxù, fángjiān gānjìng zhěngjié.', 'Chúng tôi đến quầy lễ tân khách sạn lúc hai giờ chiều để làm thủ tục nhận phòng, phòng ốc sạch sẽ ngăn nắp.', 'basic', 1),
        (v_id, '新建成的青年人才公寓正式迎来首批住户入住，完善的配套设施赢得了大家的一致好评。', 'Xīnjiàn-chéng de qīngnián réncái gōngyù zhèngshì yínglái shǒupī zhùhù rùzhù, wánshàn de pèitào shèshī yíngdé le dàjiā de yízhì hǎopíng.', 'Khu chung cư nhân tài trẻ mới xây dựng đã chính thức đón đợt cư dân đầu tiên dọn vào ở, các cơ sở vật chất phụ trợ hoàn thiện đã nhận được sự khen ngợi đồng thanh của mọi người.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [散步] (sànbù) - đi dạo, tản bộ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '散步' AND pinyin = 'sànbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '散步'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'sànbù',
      meaning_vi = 'đi dạo, tản bộ',
      example_hanzi = '晚饭后和家人一起到湖边散步，是一天中最放松的时刻。',
      example_pinyin = 'Wǎnfàn hòu hé jiārén yìqǐ dào húbiān sànbù, shì yì tiān zhōng zuì fàngsōng de shíkè.',
      example_vi = 'Sau bữa tối cùng người nhà đi dạo bên bờ hồ là thời khắc thư giãn nhất trong một ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '晚饭后和家人一起到湖边散步，是一天中最放松的时刻。', 'Wǎnfàn hòu hé jiārén yìqǐ dào húbiān sànbù, shì yì tiān zhōng zuì fàngsōng de shíkè.', 'Sau bữa tối cùng người nhà đi dạo bên bờ hồ là thời khắc thư giãn nhất trong một ngày.', 'basic', 1),
        (v_id, '医学专家指出，每天坚持快走或散步半小时以上，对改善心血管功能和降低慢性病风险大有益处。', 'Yīxué zhuānjiā zhǐchū, měi tiān jiānchí kuàizǒu huò sànbù bàn xiǎoshí yǐshàng, duì gǎishàn xīnxuèguǎn gōngnéng hé jiàngdī mànxìngbìng fēngxiǎn dàyǒu-yìchù.', 'Chuyên gia y học chỉ rõ rằng mỗi ngày kiên trì đi bộ nhanh hoặc tản bộ từ nửa tiếng trở lên mang lại lợi ích rất lớn đối với việc cải thiện chức năng tim mạch và hạ thấp nguy cơ bệnh mãn tính.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [扫码] (sǎomǎ) - quét mã (QR) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '扫码' AND pinyin = 'sǎomǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '扫码'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'sǎomǎ',
      meaning_vi = 'quét mã (QR)',
      example_hanzi = '在超市结账时，拿出手机扫码就能瞬间完成移动支付。',
      example_pinyin = 'Zài chāoshì jiézhàng shí, ná chū shǒujī sǎomǎ jiù néng shùnjiān wánchéng yídòng zhīfù.',
      example_vi = 'Khi thanh toán ở siêu thị, lấy điện thoại ra quét mã là có thể hoàn tất thanh toán di động trong chớp mắt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在超市结账时，拿出手机扫码就能瞬间完成移动支付。', 'Zài chāoshì jiézhàng shí, ná chū shǒujī sǎomǎ jiù néng shùnjiān wánchéng yídòng zhīfù.', 'Khi thanh toán ở siêu thị, lấy điện thoại ra quét mã là có thể hoàn tất thanh toán di động trong chớp mắt.', 'basic', 1),
        (v_id, '如今无论是乘坐公共交通还是参观博物馆，游客只需扫码即可快速实现身份核验与票务预约。', 'Rújīn wúlùn shì chéngzuò gōnggòng jiāotōng háishi cānguān bówùguǎn, yóukè zhǐ xū sǎomǎ jíkě kuàisù shíxiàn shēnfèn héyàn yǔ piàowù yùyuē.', 'Ngày nay dù là đi phương tiện giao thông công cộng hay tham quan bảo tàng, du khách chỉ cần quét mã là có thể nhanh chóng thực hiện đối chiếu căn cước và đặt trước vé tham quan.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [森林] (sēnlín) - rừng rậm, rừng nguyên sinh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '森林' AND pinyin = 'sēnlín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '森林'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'sēnlín',
      meaning_vi = 'rừng rậm, rừng nguyên sinh',
      example_hanzi = '这座国家森林公园里空气清新，生长着各种珍贵的树木和花草。',
      example_pinyin = 'Zhè zuò guójiā sēnlín gōngyuán lǐ kōngqì qīngxīn, shēngzhǎngzhe gèzhǒng zhēnguì de shùmù hé huācǎo.',
      example_vi = 'Trong công viên rừng rậm quốc gia này không khí trong lành, sinh trưởng đủ loại cây cối hoa cỏ quý giá.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这座国家森林公园里空气清新，生长着各种珍贵的树木和花草。', 'Zhè zuò guójiā sēnlín gōngyuán lǐ kōngqì qīngxīn, shēngzhǎngzhe gèzhǒng zhēnguì de shùmù hé huācǎo.', 'Trong công viên rừng rậm quốc gia này không khí trong lành, sinh trưởng đủ loại cây cối hoa cỏ quý giá.', 'basic', 1),
        (v_id, '森林被誉为“地球之肺”，在涵养水源、防风固沙以及维持全球生物多样性方面起着不可替代的生态屏障作用。', 'Sēnlín bèi yù wéi “dìqiú zhī fèi”, zài hányǎng shuǐyuán, fángfēng-gùshā yǐjí wéichí quánqiú shēngwù duōyàngxìng fāngmiàn qǐzhe bùkě tìdài de shēngtài píngzhàng zuòyòng.', 'Rừng rậm được ví như "lá phổi của Trái Đất", giữ vai trò bức bình phong sinh thái không thể thay thế trong việc nuôi dưỡng nguồn nước, chắn gió giữ cát cũng như duy trì tính đa dạng sinh học toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [商量] (shāngliang) - thương lượng, bàn bạc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '商量' AND pinyin = 'shāngliang'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '商量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shāngliang',
      meaning_vi = 'thương lượng, bàn bạc',
      example_hanzi = '关于周末去哪里野餐的事情，我们晚上回去再仔细商量一下。',
      example_pinyin = 'Guānyú zhōumò qù nǎlǐ yěcān de shìqing, wǒmen wǎnshang huíqù zài zǐxì shāngliang yíxià.',
      example_vi = 'Về việc cuối tuần đi dã ngoại ở đâu, tối nay chúng mình về nhà rồi bàn bạc kỹ lại nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '关于周末去哪里野餐的事情，我们晚上回去再仔细商量一下。', 'Guānyú zhōumò qù nǎlǐ yěcān de shìqing, wǒmen wǎnshang huíqù zài zǐxì shāngliang yíxià.', 'Về việc cuối tuần đi dã ngoại ở đâu, tối nay chúng mình về nhà rồi bàn bạc kỹ lại nhé.', 'basic', 1),
        (v_id, '在重大投资决策出台之前，管理层必须召集各部门主管深入商量评估各种潜在的市场风险。', 'Zài zhòngdà tóuzī juécè chūtái zhīqián, guǎnlǐcéng bìxū zhàojí gè bùmén zhǔguǎn shēnrù shāngliang pínggū gèzhǒng qiánzài de shìchǎng fēngxiǎn.', 'Trước khi quyết sách đầu tư quan trọng được ban hành, ban quản lý bắt buộc phải triệu tập các trưởng bộ phận để bàn bạc sâu sắc đánh giá các loại rủi ro thị trường tiềm ẩn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [商品] (shāngpǐn) - hàng hóa, thương phẩm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '商品' AND pinyin = 'shāngpǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '商品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shāngpǐn',
      meaning_vi = 'hàng hóa, thương phẩm',
      example_hanzi = '商场货架上摆满了琳琅满目的日常商品，种类十分丰富。',
      example_pinyin = 'Shāngchǎng huòjià shang bǎi mǎn le línláng-mǎnmù de rìcháng shāngpǐn, zhǒnglèi shífēn fēngfù.',
      example_vi = 'Trên các kệ hàng của trung tâm thương mại bày đầy hàng hóa thiết yếu hàng ngày hoa cả mắt, chủng loại vô cùng phong phú.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '商场货架上摆满了琳琅满目的日常商品，种类十分丰富。', 'Shāngchǎng huòjià shang bǎi mǎn le línláng-mǎnmù de rìcháng shāngpǐn, zhǒnglèi shífēn fēngfù.', 'Trên các kệ hàng của trung tâm thương mại bày đầy hàng hóa thiết yếu hàng ngày hoa cả mắt, chủng loại vô cùng phong phú.', 'basic', 1),
        (v_id, '为切实保护消费者的合法权益，市场监管部门依法加大了对假冒伪劣商品的查处与打击力度。', 'Wèi qièshí bǎohù xiāofèizhě de héfǎ quányì, shìchǎng jiānguǎn bùmén yīfǎ jiàdà le duì jiǎmào-wěiliè shāngpǐn de cháchǔ yǔ dǎjī lìdù.', 'Nhằm thiết thực bảo vệ quyền lợi hợp pháp của người tiêu dùng, cơ quan quản lý thị trường đã gia tăng mức độ điều tra xử lý và trấn áp các mặt hàng nhái hàng giả hàng kém chất lượng theo đúng quy định pháp luật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [伤心] (shāngxīn) - đau lòng, buồn bã [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '伤心' AND pinyin = 'shāngxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '伤心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'shāngxīn',
      meaning_vi = 'đau lòng, buồn bã',
      example_hanzi = '听到自己心爱的小猫走丢的消息，妹妹伤心得忍不住掉下了眼泪。',
      example_pinyin = 'Tīngdào zìjǐ xīn’ài de xiǎomāo zǒudiū de xiāoxi, mèimei shāngxīn de rěnbuzhù diào xià le yǎnlèi.',
      example_vi = 'Nghe tin chú mèo cưng của mình bị thất lạc, em gái buồn đau lòng đến mức không kìm được nước mắt rơi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到自己心爱的小猫走丢的消息，妹妹伤心得忍不住掉下了眼泪。', 'Tīngdào zìjǐ xīn’ài de xiǎomāo zǒudiū de xiāoxi, mèimei shāngxīn de rěnbuzhù diào xià le yǎnlèi.', 'Nghe tin chú mèo cưng của mình bị thất lạc, em gái buồn đau lòng đến mức không kìm được nước mắt rơi.', 'basic', 1),
        (v_id, '无论面对多么令人伤心的挫折与离别，我们都要学会坚强地收拾好心情，重新勇敢地迈步向前。', 'Wúlùn miànduì duōme lìng rén shāngxīn de cuòzhé yǔ líbié, wǒmen dōu yào xuéhuì jiānqiáng de shōushi hǎo xīnqíng, chóngxīn yǒnggǎn de màibù xiàngqián.', 'Dù phải đối mặt với nỗi thất bại và chia ly đau lòng đến thế nào đi chăng nữa, chúng ta cũng đều phải học cách kiên cường thu xếp lại tâm trạng, dũng cảm vững bước tiến về phía trước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [上门] (shàngmén) - đến tận nhà, phục vụ tận cửa [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '上门' AND pinyin = 'shàngmén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '上门'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shàngmén',
      meaning_vi = 'đến tận nhà, phục vụ tận cửa',
      example_hanzi = '家里的空调突然不制冷了，我打电话预约了师傅明天下午上门维修。',
      example_pinyin = 'Jiā lǐ de kōngtiáo tūrán bú zhìlěng le, wǒ dǎ diànhuà yùyuē le shīfu míngtiān xiàwǔ shàngmén wéixiū.',
      example_vi = 'Điều hòa ở nhà đột nhiên không làm mát nữa, tôi đã gọi điện hẹn thợ chiều mai đến tận nhà sửa chữa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '家里的空调突然不制冷了，我打电话预约了师傅明天下午上门维修。', 'Jiā lǐ de kōngtiáo tūrán bú zhìlěng le, wǒ dǎ diànhuà yùyuē le shīfu míngtiān xiàwǔ shàngmén wéixiū.', 'Điều hòa ở nhà đột nhiên không làm mát nữa, tôi đã gọi điện hẹn thợ chiều mai đến tận nhà sửa chữa.', 'basic', 1),
        (v_id, '社区卫生服务中心定期组织全科医生开展上门义诊，为行动不便的高龄老人送去暖心关怀。', 'Shèqū wèishēng fúwù zhōngxīn dìngqī zǔzhī quánkē yīshēng kāizhǎn shàngmén yìzhěn, wèi xíngdòng búbiàn de gāolíng lǎorén sòng qù nuǎnxīn guānhuái.', 'Trung tâm dịch vụ y tế cộng đồng định kỳ tổ chức các bác sĩ đa khoa triển khai khám bệnh từ thiện tận nhà, mang lại sự quan tâm ấm áp cho các cụ già cao tuổi đi lại khó khăn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [稍] (shāo) - hơi, một chút [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '稍' AND pinyin = 'shāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '稍'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'shāo',
      meaning_vi = 'hơi, một chút',
      example_hanzi = '请您在候车室稍候片刻，列车很快就会开始检票进站。',
      example_pinyin = 'Qǐng nín zài hòuchēshì shāo hòu piànkè, lièchē hěn kuài jiù huì kāishǐ jiǎnpiào jìnzhàn.',
      example_vi = 'Xin quý khách chờ trong phòng đợi một lát, đoàn tàu sẽ bắt đầu soát vé vào ga rất nhanh thôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请您在候车室稍候片刻，列车很快就会开始检票进站。', 'Qǐng nín zài hòuchēshì shāo hòu piànkè, lièchē hěn kuài jiù huì kāishǐ jiǎnpiào jìnzhàn.', 'Xin quý khách chờ trong phòng đợi một lát, đoàn tàu sẽ bắt đầu soát vé vào ga rất nhanh thôi.', 'basic', 1),
        (v_id, '本次实验对温度控制的要求极其严苛，温度稍有波动就会对最终晶体的纯度产生严重影响。', 'Běn cì shíyàn duì wēndù kòngzhì de yāoqiú jíqí yánkē, wēndù shāo yǒu bōdòng jiù huì duì zuìzhōng jīngtǐ de chúndù chǎnshēng yánzhòng yǐngxiǎng.', 'Thí nghiệm lần này yêu cầu kiểm soát nhiệt độ cực kỳ khắt khe, nhiệt độ chỉ cần hơi có biến động một chút là sẽ gây ảnh hưởng nghiêm trọng đến độ tinh khiết của tinh thể cuối cùng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [稍微] (shāowēi) - hơi, một chút, một ít [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '稍微' AND pinyin = 'shāowēi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '稍微'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'shāowēi',
      meaning_vi = 'hơi, một chút, một ít',
      example_hanzi = '这件外套款式很好看，就是尺码稍微大了一点点。',
      example_pinyin = 'Zhè jiàn wàitào kuǎnshì hěn hǎokàn, jiùshì chǐmǎ shāowēi dà le yìdiǎndiǎn.',
      example_vi = 'Chiếc áo khoác này kiểu dáng rất đẹp, chỉ là kích cỡ hơi rộng một chút xíu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这件外套款式很好看，就是尺码稍微大了一点点。', 'Zhè jiàn wàitào kuǎnshì hěn hǎokàn, jiùshì chǐmǎ shāowēi dà le yìdiǎndiǎn.', 'Chiếc áo khoác này kiểu dáng rất đẹp, chỉ là kích cỡ hơi rộng một chút xíu.', 'basic', 1),
        (v_id, '报告中的部分图表排版稍微做些细节调整，整体视觉呈现效果就会更加清晰专业。', 'Bàogào zhōng de bùfen túbiǎo páibǎn shāowēi zuò xiē xìjié tiáozhěng, zhěngtǐ shìjué chéngxiàn xiàoguǒ jiù huì gèngjiā qīngxī zhuānyè.', 'Dàn trang một số biểu đồ trong báo cáo chỉ cần hơi điều chỉnh chi tiết một chút, hiệu quả hiển thị thị giác tổng thể sẽ càng thêm rõ ràng và chuyên nghiệp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [少见] (shǎojiàn) - hiếm thấy, ít thấy [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '少见' AND pinyin = 'shǎojiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '少见'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'shǎojiàn',
      meaning_vi = 'hiếm thấy, ít thấy',
      example_hanzi = '在南方城市能看到这么大一场鹅毛大雪，确实非常少见。',
      example_pinyin = 'Zài nánfāng chéngshì néng kàndào zhème dà yì cháng émáo dàyǔ, quèshí fēicháng shǎojiàn.',
      example_vi = 'Ở các thành phố miền Nam mà thấy được một trận tuyết lớn như lông ngỗng thế này, quả thực vô cùng hiếm thấy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在南方城市能看到这么大一场鹅毛大雪，确实非常少见。', 'Zài nánfāng chéngshì néng kàndào zhème dà yì cháng émáo dàyǔ, quèshí fēicháng shǎojiàn.', 'Ở các thành phố miền Nam mà thấy được một trận tuyết lớn như lông ngỗng thế này, quả thực vô cùng hiếm thấy.', 'basic', 1),
        (v_id, '他年纪轻轻就在国际顶级学术期刊上连续发表多篇开创性论文，在学术界实属少见的青年才俊。', 'Tā niánjì qīngqīng jiù zài guójì dǐngjí xuéshù qīkān shang liánxù fābiǎo duō piān kāichuàngxìng lùnwén, zài xuéshùjiè shí shǔ shǎojiàn de qīngnián cáijùn.', 'Anh ấy tuổi đời còn rất trẻ nhưng đã liên tục đăng nhiều bài báo mang tính khai phá trên các tạp chí học thuật đỉnh cao quốc tế, trong giới học thuật thực sự là tài năng trẻ hiếm thấy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [少量] (shǎoliàng) - lượng ít, số lượng nhỏ [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '少量' AND pinyin = 'shǎoliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '少量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'shǎoliàng',
      meaning_vi = 'lượng ít, số lượng nhỏ',
      example_hanzi = '煮汤的时候只需加入少量的盐和香油提味即可。',
      example_pinyin = 'Zhǔ tāng de shíhou zhǐ xū jiārù shǎoliàng de yán hé xiāngyóu tíwèi jíkě.',
      example_vi = 'Khi nấu canh chỉ cần cho thêm lượng ít muối và dầu mè để dậy mùi là được.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '煮汤的时候只需加入少量的盐和香油提味即可。', 'Zhǔ tāng de shíhou zhǐ xū jiārù shǎoliàng de yán hé xiāngyóu tíwèi jíkě.', 'Khi nấu canh chỉ cần cho thêm lượng ít muối và dầu mè để dậy mùi là được.', 'basic', 1),
        (v_id, '实验室在处理剧毒化学试剂时，每次仅允许取用极少量样品，并严格执行双人复核安全制度。', 'Shíyànshì zài chǔlǐ jùdú huàxué shìjì shí, měi cì jǐn yǔnxǔ qǔyòng jí shǎoliàng yàngpǐn, bìng yángé zhíxíng shuāngrén fùhé ānquán zhìdù.', 'Phòng thí nghiệm khi xử lý các hóa chất cực độc, mỗi lần chỉ cho phép lấy một lượng cực ít mẫu thử, và chấp hành nghiêm ngặt chế độ an toàn hai người cùng kiểm duyệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [少数] (shǎoshù) - thiểu số, số ít [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '少数' AND pinyin = 'shǎoshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '少数'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shǎoshù',
      meaning_vi = 'thiểu số, số ít',
      example_hanzi = '在这次班级聚会投票中，只有少数同学赞成去郊外爬山。',
      example_pinyin = 'Zài zhè cì bānjí jùhuì tóupiào zhōng, zhǐyǒu shǎoshù tóngxué zànchéng qù jiāowài páshān.',
      example_vi = 'Trong cuộc bỏ phiếu họp lớp lần này, chỉ có số ít bạn học tán thành việc đi ngoại ô leo núi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在这次班级聚会投票中，只有少数同学赞成去郊外爬山。', 'Zài zhè cì bānjí jùhuì tóupiào zhōng, zhǐyǒu shǎoshù tóngxué zànchéng qù jiāowài páshān.', 'Trong cuộc bỏ phiếu họp lớp lần này, chỉ có số ít bạn học tán thành việc đi ngoại ô leo núi.', 'basic', 1),
        (v_id, '民主决策既要坚持少数服从多数的原则，同时也必须充分尊重并倾听少数群体的合理诉求。', 'Mínzhǔ juécè jì yào jiānchí shǎoshù fúcóng duōshù de yuánzé, tóngshí yě bìxū chōngfèn zūnzhòng bìng qīngtīng shǎoshù qúntǐ de hélǐ sùqiú.', 'Quyết sách dân chủ vừa phải kiên trì nguyên tắc thiểu số phục tùng đa số, đồng thời cũng bắt buộc phải tôn trọng đầy đủ và lắng nghe nguyện vọng chính đáng của nhóm thiểu số.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [少年] (shàonián) - thiếu niên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '少年' AND pinyin = 'shàonián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '少年'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shàonián',
      meaning_vi = 'thiếu niên',
      example_hanzi = '自古英雄出少年，我们要树立远大理想，努力学好文化知识。',
      example_pinyin = 'Zìgǔ yīngxióng chū shàonián, wǒmen yào shùlì yuǎndà lǐxiǎng, nǔlì xué hǎo wénhuà zhīshi.',
      example_vi = 'Từ xưa anh hùng xuất thiếu niên, chúng ta cần xác lập lý tưởng cao xa, nỗ lực học tốt kiến thức văn hóa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '自古英雄出少年，我们要树立远大理想，努力学好文化知识。', 'Zìgǔ yīngxióng chū shàonián, wǒmen yào shùlì yuǎndà lǐxiǎng, nǔlì xué hǎo wénhuà zhīshi.', 'Từ xưa anh hùng xuất thiếu niên, chúng ta cần xác lập lý tưởng cao xa, nỗ lực học tốt kiến thức văn hóa.', 'basic', 1),
        (v_id, '全社会都应当高度重视青少年心理健康教育，为青少年的健康茁壮成长营造良好的家庭与校园环境。', 'Quán shèhuì dōu yīngdāng gāodù zhòngshì qīngshàonián xīnlǐ jiànkāng jiàoyù, wèi qīngshàonián de jiànkāng zhuózhuàng chéngzhǎng yíngzào liánghǎo de jiātíng yǔ xiàoyuán huánjìng.', 'Toàn xã hội đều cần hết sức coi trọng giáo dục sức khỏe tâm lý thanh thiếu niên, tạo dựng môi trường gia đình và học đường lành mạnh cho sự trưởng thành khỏe mạnh vững vàng của thiếu niên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [社会] (shèhuì) - xã hội [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '社会' AND pinyin = 'shèhuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '社会'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shèhuì',
      meaning_vi = 'xã hội',
      example_hanzi = '大学毕业生即将走出校园踏入社会，开启全新的独立人生旅程。',
      example_pinyin = 'Dàxué bìyèshēng jíjiāng zǒuchū xiàoyuán tàrù shèhuì, kāiqǐ quánxīn de dúlì rénshēng lǚchéng.',
      example_vi = 'Sinh viên tốt nghiệp đại học sắp bước ra khỏi khuôn viên nhà trường để bước vào xã hội, mở ra hành trình cuộc đời tự lập hoàn toàn mới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大学毕业生即将走出校园踏入社会，开启全新的独立人生旅程。', 'Dàxué bìyèshēng jíjiāng zǒuchū xiàoyuán tàrù shèhuì, kāiqǐ quánxīn de dúlì rénshēng lǚchéng.', 'Sinh viên tốt nghiệp đại học sắp bước ra khỏi khuôn viên nhà trường để bước vào xã hội, mở ra hành trình cuộc đời tự lập hoàn toàn mới.', 'basic', 1),
        (v_id, '构建和谐包容的法治社会，需要每一位公民自觉遵纪守法，共同弘扬公平正义的社会正能量。', 'Gòujiàn héxié bāoróng de fǎzhì shèhuì, xūyào měi yí wèi gōngmín zìjué zūnjì-shǒufǎ, gòngtóng hóngyáng gōngpíng-zhèngyì de shèhuì zhèngnéngliàng.', 'Xây dựng một xã hội pháp quyền hài hòa và bao dung cần mỗi người công dân tự giác tuân thủ kỷ cương pháp luật, cùng nhau phát huy năng lượng tích cực của công bằng chính nghĩa xã hội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [摄氏度] (shèshìdù) - độ C (độ Celsius) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '摄氏度' AND pinyin = 'shèshìdù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '摄氏度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'shèshìdù',
      meaning_vi = 'độ C (độ Celsius)',
      example_hanzi = '今天下午最高气温达到了三十八摄氏度，天气非常炎热。',
      example_pinyin = 'Jīntiān xiàwǔ zuìgāo qìwēn dádào le sānshíbā shèshìdù, tiānqì fēicháng yánrè.',
      example_vi = 'Chiều hôm nay nhiệt độ cao nhất đã lên tới ba mươi tám độ C, thời tiết vô cùng nóng nực.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天下午最高气温达到了三十八摄氏度，天气非常炎热。', 'Jīntiān xiàwǔ zuìgāo qìwēn dádào le sānshíbā shèshìdù, tiānqì fēicháng yánrè.', 'Chiều hôm nay nhiệt độ cao nhất đã lên tới ba mươi tám độ C, thời tiết vô cùng nóng nực.', 'basic', 1),
        (v_id, '这种新型特种生物疫苗必须在零下二十摄氏度的恒温冷链环境下进行安全储存与长途运输。', 'Zhè zhǒng xīnxíng tèzhǒng shēngwù yìmiáo bìxū zài língxià èrshí shèshìdù de héngwēn lěngliàn huánjìng xià jìnxíng ānquán chúcún yǔ chángtú yùnshū.', 'Loại vắc xin sinh học đặc chủng kiểu mới này bắt buộc phải được lưu trữ an toàn và vận chuyển đường dài trong môi trường dây chuyền lạnh ổn định ở nhiệt độ âm hai mươi độ C.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [身] (shēn) - thân thể, mình; bộ (quần áo) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '身' AND pinyin = 'shēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '身'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'shēn',
      meaning_vi = 'thân thể, mình; bộ (quần áo)',
      example_hanzi = '他今天穿了一身笔挺深蓝色的西装，显得精神帅气。',
      example_pinyin = 'Tā jīntiān chuān le yì shēn bǐtǐng shēnlánsè de xīzhuāng, xiǎnde jīngshen shuàiqi.',
      example_vi = 'Hôm nay anh ấy mặc một bộ com-lê xanh lam đậm thẳng thớm, trông rất hoạt bát đẹp trai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他今天穿了一身笔挺深蓝色的西装，显得精神帅气。', 'Tā jīntiān chuān le yì shēn bǐtǐng shēnlánsè de xīzhuāng, xiǎnde jīngshen shuàiqi.', 'Hôm nay anh ấy mặc một bộ com-lê xanh lam đậm thẳng thớm, trông rất hoạt bát đẹp trai.', 'basic', 1),
        (v_id, '身教胜于言传，优秀的教育工作者总是通过自己的模范言行为学生树立立身处世的人生榜样。', 'Shēnjiào shèng yú yánchuán, yōuxiù de jiàoyù gōngzuòzhě zǒngshì tōngguò zìjǐ de mófàn yánxíng wèi xuésheng shùlì lìshēn-chǔshì de rénshēng bǎngyàng.', 'Thân giáo hơn lời truyền dạy, những nhà giáo ưu tú luôn thông qua lời nói và việc làm gương mẫu của chính mình để dựng nên tấm gương đối nhân xử thế cho học sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [深] (shēn) - sâu, đậm, sâu sắc [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '深' AND pinyin = 'shēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '深'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'shēn',
      meaning_vi = 'sâu, đậm, sâu sắc',
      example_hanzi = '那片湖水非常深，岸边立着“严禁下水游泳”的醒目警示牌。',
      example_pinyin = 'Nà piàn húshuǐ fēicháng shēn, ànbiān lìzhe “yánjìn xiàshuǐ yóuyǒng” de xǐngmù jǐngshìpái.',
      example_vi = 'Vùng nước hồ đó rất sâu, bên bờ dựng biển cảnh báo bắt mắt "nghiêm cấm xuống nước bơi lội".'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '那片湖水非常深，岸边立着“严禁下水游泳”的醒目警示牌。', 'Nà piàn húshuǐ fēicháng shēn, ànbiān lìzhe “yánjìn xiàshuǐ yóuyǒng” de xǐngmù jǐngshìpái.', 'Vùng nước hồ đó rất sâu, bên bờ dựng biển cảnh báo bắt mắt "nghiêm cấm xuống nước bơi lội".', 'basic', 1),
        (v_id, '这篇深度长篇调查报告深刻剖析了现代城市快速扩张进程中所面临的人口老龄化与资源环境双重压力。', 'Zhè piān shēndù chángpiān diàochá bàogào shēnkè pōuxī le xiàndài chéngshì kuàisù kuòzhāng jìnchéng zhōng suǒ miànlín de rénkǒu lǎolínghuà yǔ zīyuán huánjìng shuāngchóng yālì.', 'Bài báo cáo điều tra dài kỳ có chiều sâu này đã phân tích sâu sắc áp lực kép giữa già hóa dân số và tài nguyên môi trường mà các thành phố hiện đại phải đối mặt trong tiến trình mở rộng nhanh chóng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [身份证] (shēnfènzhèng) - căn cước công dân, chứng minh thư [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '身份证' AND pinyin = 'shēnfènzhèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '身份证'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shēnfènzhèng',
      meaning_vi = 'căn cước công dân, chứng minh thư',
      example_hanzi = '去火车站取票或者进站安检时，请提前准备好二代身份证。',
      example_pinyin = 'Qù huǒchēzhàn qǔpiào huòzhě jìnzhàn ānjiǎn shí, qǐng tíqián zhǔnbèi hǎo èrdài shēnfènzhèng.',
      example_vi = 'Khi đến ga tàu hỏa lấy vé hoặc qua cửa kiểm tra an ninh, xin vui lòng chuẩn bị sẵn thẻ căn cước công dân thế hệ hai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '去火车站取票或者进站安检时，请提前准备好二代身份证。', 'Qù huǒchēzhàn qǔpiào huòzhě jìnzhàn ānjiǎn shí, qǐng tíqián zhǔnbèi hǎo èrdài shēnfènzhèng.', 'Khi đến ga tàu hỏa lấy vé hoặc qua cửa kiểm tra an ninh, xin vui lòng chuẩn bị sẵn thẻ căn cước công dân thế hệ hai.', 'basic', 1),
        (v_id, '外出旅游时不慎遗失身份证件，应当立即向就近公安派出所报案并申请办理临时身份证明。', 'Wàichū lǚyóu shí búshèn yíshī shēnfèn zhèngjiàn, yīngdāng lìjí xiàng jiùjìn gōng’ān pàichūsuǒ bào’àn bìng shēnqǐng bànlǐ línshí shēnfèn zhèngmíng.', 'Khi ra ngoài du lịch nếu sơ ý làm mất giấy tờ tùy thân, cần lập tức trình báo với đồn công an gần nhất và nộp đơn xin cấp giấy chứng nhận căn cước tạm thời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [申请] (shēnqǐng) - đăng ký, xin, nộp đơn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '申请' AND pinyin = 'shēnqǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '申请'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shēnqǐng',
      meaning_vi = 'đăng ký, xin, nộp đơn',
      example_hanzi = '他正在准备各项材料，打算下个月正式申请中国政府全额奖学金。',
      example_pinyin = 'Tā zhèngzài zhǔnbèi gè xiàng cáiliào, dǎsuan xià gè yuè zhèngshì shēnqǐng Zhōngguó zhèngfǔ quán’é jiǎngxuéjīn.',
      example_vi = 'Cậu ấy đang chuẩn bị các loại giấy tờ hồ sơ, dự định tháng sau sẽ chính thức nộp đơn xin học bổng toàn phần chính phủ Trung Quốc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他正在准备各项材料，打算下个月正式申请中国政府全额奖学金。', 'Tā zhèngzài zhǔnbèi gè xiàng cáiliào, dǎsuan xià gè yuè zhèngshì shēnqǐng Zhōngguó zhèngfǔ quán’é jiǎngxuéjīn.', 'Cậu ấy đang chuẩn bị các loại giấy tờ hồ sơ, dự định tháng sau sẽ chính thức nộp đơn xin học bổng toàn phần chính phủ Trung Quốc.', 'basic', 1),
        (v_id, '这家科技初创企业凭借自主创新的核心技术专利，成功申请到了国家战略性新兴产业扶持发展专项基金。', 'Zhè jiā kējì chūchuàng qǐyè píngjiè zìzhǔ chuàngxīn de héxīn jìshù zhuānlì, chénggōng shēnqǐng dào le guójiā zhànlüèxìng xīnxīng chǎnyè fúchí fāzhǎn zhuānxiàng jījīn.', 'Doanh nghiệp khởi nghiệp công nghệ này nhờ vào bằng sáng chế kỹ thuật cốt lõi tự chủ đổi mới, đã nộp đơn thành công và nhận được quỹ chuyên biệt hỗ trợ phát triển ngành công nghiệp mới nổi mang tính chiến lược của quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [甚至] (shènzhì) - thậm chí, ngay cả [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '甚至' AND pinyin = 'shènzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '甚至'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'shènzhì',
      meaning_vi = 'thậm chí, ngay cả',
      example_hanzi = '他工作起来非常专注投入，忙的时候甚至连午饭都顾不上吃。',
      example_pinyin = 'Tā gōngzuò qǐlai fēicháng zhuānzhù tóurù, máng de shíhou shènzhì lián wǔfàn dōu gùbushàng chī.',
      example_vi = 'Anh ấy khi làm việc vô cùng chuyên tâm nhập tâm, lúc bận rộn thậm chí ngay cả cơm trưa cũng chẳng đoái hoài ăn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他工作起来非常专注投入，忙的时候甚至连午饭都顾不上吃。', 'Tā gōngzuò qǐlai fēicháng zhuānzhù tóurù, máng de shíhou shènzhì lián wǔfàn dōu gùbushàng chī.', 'Anh ấy khi làm việc vô cùng chuyên tâm nhập tâm, lúc bận rộn thậm chí ngay cả cơm trưa cũng chẳng đoái hoài ăn.', 'basic', 1),
        (v_id, '由于长期超负荷运转且缺乏必要维护，部分老旧设备出现严重磨损，甚至随时可能引发重大安全生产事故。', 'Yóuyú chángqī chāofùhè yùnzhuǎn qiě quēfá bìyào wéihù, bùfen lǎojiù shèbèi chūxiàn yánzhòng mósǔn, shènzhì suíshí kěnéng yǐnfā zhòngdà ānquán shēngchǎn shìgù.', 'Do lâu ngày vận hành quá tải và thiếu sự bảo dưỡng cần thiết, một số thiết bị cũ kỹ xuất hiện độ hao mòn nghiêm trọng, thậm chí có thể châm ngòi sự cố an toàn sản xuất nghiêm trọng bất cứ lúc nào.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [生] (shēng) - sinh ra, lớn lên; còn sống, chưa chín, xa lạ [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '生' AND pinyin = 'shēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'shēng',
      meaning_vi = 'sinh ra, lớn lên; còn sống, chưa chín, xa lạ',
      example_hanzi = '春天大地回暖，万物复苏，田野里的花草树木都充满了勃勃生机。',
      example_pinyin = 'Chūntiān dàdì huínuǎn, wànwù fùsū, tiányě lǐ de huācǎo-shùmù dōu chōngmǎn le bóbó shēngjī.',
      example_vi = 'Mùa xuân đất trời ấm lại, vạn vật hồi sinh, hoa cỏ cây cối ngoài đồng ruộng đều tràn trề sức sống phơi phới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '春天大地回暖，万物复苏，田野里的花草树木都充满了勃勃生机。', 'Chūntiān dàdì huínuǎn, wànwù fùsū, tiányě lǐ de huācǎo-shùmù dōu chōngmǎn le bóbó shēngjī.', 'Mùa xuân đất trời ấm lại, vạn vật hồi sinh, hoa cỏ cây cối ngoài đồng ruộng đều tràn trề sức sống phơi phới.', 'basic', 1),
        (v_id, '为了饮食安全与健康，千万不能直接饮用未经煮沸杀菌的生水，烹饪肉类也必须彻底煮熟再食用。', 'Wèile yǐnshí ānquán yǔ jiànkāng, qiānwàn bù néng zhíjiē yǐnyòng wèijīng zhǔfèi shājūn de shēngshuǐ, pēngrèn ròulèi yě bìxū chèdǐ zhǔshóu zài shíyòng.', 'Vì an toàn và sức khỏe ăn uống, tuyệt đối không được uống trực tiếp nước lã chưa đun sôi tiệt trùng, và nấu các loại thịt cũng bắt buộc phải nấu chín kỹ rồi mới thưởng thức.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [生命] (shēngmìng) - sinh mạng, sự sống, mạng sống [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '生命' AND pinyin = 'shēngmìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '生命'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shēngmìng',
      meaning_vi = 'sinh mạng, sự sống, mạng sống',
      example_hanzi = '生命只有一次，我们在日常生活中一定要珍爱生命，注意交通安全。',
      example_pinyin = 'Shēngmìng zhǐyǒu yí cì, wǒmen zài rìcháng shēnghuó zhōng yídìng yào zhēn’ài shēngmìng, zhùyì jiāotōng ānquán.',
      example_vi = 'Sinh mạng chỉ có một lần, chúng ta trong cuộc sống hàng ngày nhất định phải trân quý sinh mạng, chú ý an toàn giao thông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '生命只有一次，我们在日常生活中一定要珍爱生命，注意交通安全。', 'Shēngmìng zhǐyǒu yí cì, wǒmen zài rìcháng shēnghuó zhōng yídìng yào zhēn’ài shēngmìng, zhùyì jiāotōng ānquán.', 'Sinh mạng chỉ có một lần, chúng ta trong cuộc sống hàng ngày nhất định phải trân quý sinh mạng, chú ý an toàn giao thông.', 'basic', 1),
        (v_id, '医护工作者白衣执甲奋战在抢救第一线，用无私奉献与高超医术守护着每一个垂危患者宝贵的生命。', 'Yīhù gōngzuòzhě báiyīzhíjiǎ fènzhàn zài qiǎngjiù dì-yī xiàn, yòng wúsī fèngxiàn yǔ gāochāo yīshù shǒuhùzhe měi yí gè chuíwēi huànzhě bǎoguì de shēngmìng.', 'Các y bác sĩ áo trắng xung trận chiến đấu nơi tuyến đầu cấp cứu, dùng sự cống hiến quên mình và y thuật cao siêu để chở che cho sinh mạng quý báu của từng người bệnh nguy kịch.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [生意] (shēngyi) - buôn bán, kinh doanh, làm ăn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '生意' AND pinyin = 'shēngyi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '生意'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shēngyi',
      meaning_vi = 'buôn bán, kinh doanh, làm ăn',
      example_hanzi = '叔叔在步行街开了一家特色咖啡馆，服务热情周到，生意十分红火。',
      example_pinyin = 'Shūshu zài bùxíngjiē kāi le yì jiā tèsè kāfēiguǎn, fúwù rèqíng zhōudào, shēngyi shífēn hónghuo.',
      example_vi = 'Chú tôi mở một quán cà phê đặc sắc trên phố đi bộ, phục vụ nhiệt tình chu đáo, việc làm ăn buôn bán rất phát đạt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '叔叔在步行街开了一家特色咖啡馆，服务热情周到，生意十分红火。', 'Shūshu zài bùxíngjiē kāi le yì jiā tèsè kāfēiguǎn, fúwù rèqíng zhōudào, shēngyi shífēn hónghuo.', 'Chú tôi mở một quán cà phê đặc sắc trên phố đi bộ, phục vụ nhiệt tình chu đáo, việc làm ăn buôn bán rất phát đạt.', 'basic', 1),
        (v_id, '在激烈的市场竞争中，做生意必须恪守诚实守信的底线原则，树立优良的品牌信誉才能行稳致远。', 'Zài jīliè de shìchǎng jìngzhēng zhōng, zuò shēngyi bìxū kèshǒu chéngshí-shǒuxìn de dǐxiàn yuánzé, shùlì yōuliáng de pǐnpái xìnyù cái néng xíngwěn-zhìyuǎn.', 'Trong cuộc cạnh tranh thị trường khốc liệt, làm kinh doanh buôn bán bắt buộc phải khắc sâu nguyên tắc cốt lõi trung thực giữ chữ tín, tạo dựng uy tín thương hiệu xuất sắc thì mới có thể tiến xa và vững chắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [省] (shěng) - tỉnh (đơn vị hành chính) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '省' AND pinyin = 'shěng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '省'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shěng',
      meaning_vi = 'tỉnh (đơn vị hành chính)',
      example_hanzi = '中国面积最大的省是哪个？很多人都知道是新疆维吾尔自治区和青海省。',
      example_pinyin = 'Zhōngguó miànjī zuìdà de shěng shì nǎge? Hěn duō rén dōu zhīdào shì Xīnjiāng Wéiwú’ěr Zìzhìqū hé Qīnghǎi Shěng.',
      example_vi = 'Tỉnh có diện tích lớn nhất của Trung Quốc là nơi nào? Rất nhiều người đều biết đó là Khu tự trị Duy Ngô Nhĩ Tân Cương và tỉnh Thanh Hải.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国面积最大的省是哪个？很多人都知道是新疆维吾尔自治区和青海省。', 'Zhōngguó miànjī zuìdà de shěng shì nǎge? Hěn duō rén dōu zhīdào shì Xīnjiāng Wéiwú’ěr Zìzhìqū hé Qīnghǎi Shěng.', 'Tỉnh có diện tích lớn nhất của Trung Quốc là nơi nào? Rất nhiều người đều biết đó là Khu tự trị Duy Ngô Nhĩ Tân Cương và tỉnh Thanh Hải.', 'basic', 1),
        (v_id, '为推动区域协调发展，沿海经济大省加大对中西部省份的对口帮扶与产业转移合作力度。', 'Wèi tuīdòng qūyù xiétiáo fāzhǎn, yánhǎi jīngjì dà shěng jiàdà duì zhōng-xībù shěngfèn de duìkǒu bāngfú yǔ chǎnyè zhuǎnyí hézuò lìdù.', 'Nhằm thúc đẩy phát triển hài hòa giữa các vùng miền, các tỉnh lớn kinh tế ven biển đã tăng cường mức độ hỗ trợ đối ứng và hợp tác chuyển giao ngành nghề cho các tỉnh miền Trung và miền Tây.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [剩] (shèng) - thừa, còn lại, sót lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '剩' AND pinyin = 'shèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '剩'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shèng',
      meaning_vi = 'thừa, còn lại, sót lại',
      example_hanzi = '桌子上还剩下了不少饭菜，我们打包带回去当明天的午饭吧。',
      example_pinyin = 'Zhuōzi shang hái shèngxia le bù shǎo fàncài, wǒmen dǎbāo dài huíqù dāng míngtiān de wǔfàn ba.',
      example_vi = 'Trên bàn vẫn còn thừa lại không ít thức ăn, chúng mình đóng hộp mang về nhà làm bữa trưa mai nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '桌子上还剩下了不少饭菜，我们打包带回去当明天的午饭吧。', 'Zhuōzi shang hái shèngxia le bù shǎo fàncài, wǒmen dǎbāo dài huíqù dāng míngtiān de wǔfàn ba.', 'Trên bàn vẫn còn thừa lại không ít thức ăn, chúng mình đóng hộp mang về nhà làm bữa trưa mai nhé.', 'basic', 1),
        (v_id, '距离项目竞标截止只剩下最后不到三天时间，整个策划团队正争分夺秒地完善投标文件。', 'Jùlí xiàngmù jìngbiāo jiézhǐ zhǐ shèngxia zuìhòu bú dào sān tiān shíjiān, zhěnggè cèhuà tuánduì zhèng zhēngfēn-duómiǎo de wánshàn tóubiāo wénjiàn.', 'Cách thời hạn chót đấu thầu dự án chỉ còn sót lại chưa đầy ba ngày, cả đội ngũ lập kế hoạch đang tranh thủ từng phút từng giây hoàn thiện hồ sơ dự thầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [失败] (shībài) - thất bại [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '失败' AND pinyin = 'shībài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '失败'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'shībài',
      meaning_vi = 'thất bại',
      example_hanzi = '常言道“失败是成功之母”，只要吸取教训，就一定能够再次站起来。',
      example_pinyin = 'Chángyándào “shībài shì chénggōng zhī mǔ”, zhǐyào xīqǔ jiàoxun, jiù yídìng nénggòu zàicì zhàn qǐlai.',
      example_vi = 'Người xưa thường nói "thất bại là mẹ thành công", chỉ cần biết rút ra bài học thì nhất định có thể đứng dậy một lần nữa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '常言道“失败是成功之母”，只要吸取教训，就一定能够再次站起来。', 'Chángyándào “shībài shì chénggōng zhī mǔ”, zhǐyào xīqǔ jiàoxun, jiù yídìng nénggòu zàicì zhàn qǐlai.', 'Người xưa thường nói "thất bại là mẹ thành công", chỉ cần biết rút ra bài học thì nhất định có thể đứng dậy một lần nữa.', 'basic', 1),
        (v_id, '面对突如其来的商业并购失败，企业管理层迅速调整战略布局，成功化危机为企业转型的契机。', 'Miànduì tūrúqílái de shāngyè bìnggòu shībài, qǐyè guǎnlǐcéng xùnsù tiáozhěng zhànlüè bùjú, chénggōng huà wēijī wéi qǐyè zhuǎnxíng de qìjī.', 'Đối mặt trước thất bại thâu tóm kinh doanh bất ngờ ập đến, ban quản lý doanh nghiệp nhanh chóng điều chỉnh bố cục chiến lược, thành công biến nguy cơ thành thời cơ chuyển mình cho công ty.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [师傅] (shīfu) - thợ, sư phụ, bác tài [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '师傅' AND pinyin = 'shīfu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '师傅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shīfu',
      meaning_vi = 'thợ, sư phụ, bác tài',
      example_hanzi = '修车师傅手艺十分娴熟，不到半个小时就帮我把自行车修好了。',
      example_pinyin = 'Xiūchē shīfu shǒuyì shífēn xiánshú, bú dào bàn gè xiǎoshí jiù bāng wǒ bǎ zìxíngchē xiū hǎo le.',
      example_vi = 'Bác thợ sửa xe tay nghề vô cùng thuần thục, chưa đầy nửa tiếng đã giúp tôi sửa xong chiếc xe đạp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '修车师傅手艺十分娴熟，不到半个小时就帮我把自行车修好了。', 'Xiūchē shīfu shǒuyì shífēn xiánshú, bú dào bàn gè xiǎoshí jiù bāng wǒ bǎ zìxíngchē xiū hǎo le.', 'Bác thợ sửa xe tay nghề vô cùng thuần thục, chưa đầy nửa tiếng đã giúp tôi sửa xong chiếc xe đạp.', 'basic', 1),
        (v_id, '这位有着三十余年工龄的高级技师不仅技术过硬，更通过“师带徒”模式培养出了一大批青年技术骨干。', 'Zhè wèi yǒuzhe sānshí yú nián gōnglíng de gāojí jìshī bùjǐn jìshù guòyìng, gèng tōngguò “shī dài tú” móshì péiyǎng chū le yí dà pī qīngnián jìshù gǔgàn.', 'Người sư phụ kỹ thuật viên cao cấp với hơn ba mươi năm tuổi nghề này không chỉ có kỹ thuật vững vàng, mà còn thông qua mô hình "thầy kèm trò" bồi dưỡng nên một lượng lớn cán bộ kỹ thuật trẻ nòng cốt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [失去] (shīqù) - mất đi, đánh mất [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '失去' AND pinyin = 'shīqù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '失去'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shīqù',
      meaning_vi = 'mất đi, đánh mất',
      example_hanzi = '无论遇到多大的困难，我们都千万不能失去对未来的信心。',
      example_pinyin = 'Wúlùn yùdào duō dà de kùnnan, wǒmen dōu qiānwàn bù néng shīqù duì wèilái de xìnxīn.',
      example_vi = 'Bất luận gặp phải khó khăn lớn đến mức nào, chúng ta cũng tuyệt đối không được đánh mất niềm tin vào tương lai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '无论遇到多大的困难，我们都千万不能失去对未来的信心。', 'Wúlùn yùdào duō dà de kùnnan, wǒmen dōu qiānwàn bù néng shīqù duì wèilái de xìnxīn.', 'Bất luận gặp phải khó khăn lớn đến mức nào, chúng ta cũng tuyệt đối không được đánh mất niềm tin vào tương lai.', 'basic', 1),
        (v_id, '企业如果缺乏创新意识并长期漠视客户体验，迟早会在日益激烈的市场角逐中失去核心竞争力。', 'Qǐyè rúguǒ quēfá chuàngxīn yìshí bìng chángqī mòshì kèhù tǐyàn, chízǎo huì zài rìyì jīliè de shìchǎng jiǎozhú zhōng shīqù héxīn jìngzhēnglì.', 'Doanh nghiệp nếu thiếu đi ý thức đổi mới và lâu ngày phớt lờ trải nghiệm khách hàng thì sớm muộn cũng sẽ đánh mất năng lực cạnh tranh cốt lõi trong cuộc tranh đua thị trường ngày một khốc liệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [师生] (shīshēng) - thầy trò, giáo viên và học sinh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '师生' AND pinyin = 'shīshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '师生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shīshēng',
      meaning_vi = 'thầy trò, giáo viên và học sinh',
      example_hanzi = '教师节那天，全校师生欢聚在礼堂举行了隆重的庆祝晚会。',
      example_pinyin = 'Jiàoshījié nà tiān, quán xiào shīshēng huānjù zài lǐtáng jǔxíng le lóngzhòng de qìngzhù wǎnhuì.',
      example_vi = 'Vào ngày Nhà giáo, toàn thể thầy trò trong trường quây quần tại lễ đường tổ chức đêm dạ hội chúc mừng long trọng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '教师节那天，全校师生欢聚在礼堂举行了隆重的庆祝晚会。', 'Jiàoshījié nà tiān, quán xiào shīshēng huānjù zài lǐtáng jǔxíng le lóngzhòng de qìngzhù wǎnhuì.', 'Vào ngày Nhà giáo, toàn thể thầy trò trong trường quây quần tại lễ đường tổ chức đêm dạ hội chúc mừng long trọng.', 'basic', 1),
        (v_id, '现代高校倡导建立平等尊重、教学相长的良性互动师生关系，以此激发学生的自主学术创新潜能。', 'Xiàndài gāoxiào chàngdǎo jiànlì píngděng zūnzhòng, jiàoxué-xiāngzhǎng de liángxìng hùdòng shīshēng guānxi, yǐ cǐ jīfā xuésheng de zìzhǔ xuéshù chuàngxīn qiánnéng.', 'Các trường đại học hiện đại cổ vũ xây dựng mối quan hệ thầy trò tương tác lành mạnh, bình đẳng tôn trọng và cùng hỗ trợ học tập, lấy đó để khơi dậy tiềm năng sáng tạo học thuật tự chủ của học sinh sinh viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [失望] (shīwàng) - thất vọng [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '失望' AND pinyin = 'shīwàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '失望'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'shīwàng',
      meaning_vi = 'thất vọng',
      example_hanzi = '这场电影的故事情节很平淡，看完后让大家感到有些失望。',
      example_pinyin = 'Zhè chǎng diànyǐng de gùshì qíngjié hěn píngdàn, kàn wán hòu ràng dàjiā gǎndào yǒuxiē shīwàng.',
      example_vi = 'Tình tiết cốt truyện của bộ phim này rất nhạt nhòa, sau khi xem xong khiến mọi người cảm thấy có phần thất vọng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这场电影的故事情节很平淡，看完后让大家感到有些失望。', 'Zhè chǎng diànyǐng de gùshì qíngjié hěn píngdàn, kàn wán hòu ràng dàjiā gǎndào yǒuxiē shīwàng.', 'Tình tiết cốt truyện của bộ phim này rất nhạt nhòa, sau khi xem xong khiến mọi người cảm thấy có phần thất vọng.', 'basic', 1),
        (v_id, '面对投资者的殷切信任与期待，管理层表示将以更加稳健扎实的经营业绩回报社会，绝不让大家失望。', 'Miànduì tóuzīzhě de yīnqiè xìnrèn yǔ qīdài, guǎnlǐcéng biàoshì jiāng yǐ gèngjiā wěnjiàn zhāshi de jīngyíng yèjì huíbào shèhuì, jué bú ràng dàjiā shīwàng.', 'Trước niềm tin cậy và kỳ vọng tha thiết của các nhà đầu tư, ban quản lý bày tỏ sẽ dùng thành quả kinh doanh vững vàng vững chắc hơn nữa để đền đáp xã hội, tuyệt đối không phụ sự kỳ vọng của mọi người.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [十分] (shífēn) - vô cùng, hết sức, rất [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '十分' AND pinyin = 'shífēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '十分'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'shífēn',
      meaning_vi = 'vô cùng, hết sức, rất',
      example_hanzi = '听到同学们都顺利通过了汉语水平考试，王老师感到十分欣慰。',
      example_pinyin = 'Tīngdào tóngxuémen dōu shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì, Wáng lǎoshī gǎndào shífēn xīnwèi.',
      example_vi = 'Nghe tin các bạn học sinh đều thuận lợi vượt qua kỳ thi năng lực Hán ngữ HSK, thầy Vương cảm thấy vô cùng an lòng vui vẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到同学们都顺利通过了汉语水平考试，王老师感到十分欣慰。', 'Tīngdào tóngxuémen dōu shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì, Wáng lǎoshī gǎndào shífēn xīnwèi.', 'Nghe tin các bạn học sinh đều thuận lợi vượt qua kỳ thi năng lực Hán ngữ HSK, thầy Vương cảm thấy vô cùng an lòng vui vẻ.', 'basic', 1),
        (v_id, '在精密仪器加工过程中，技术参数的细微偏差都有可能导致产品报废，因此操作必须十分精确谨慎。', 'Zài jīngmì yíqì jiāgōng guòchéng zhōng, jìshù cānshù de xìwēi piānchā dōu yǒu kěnéng dǎozhì chǎnpǐn bàofèi, yīncǐ cāozuò bìxū shífēn jīngquè jǐnshèn.', 'Trong quá trình gia công thiết bị dụng cụ tinh vi, sự sai lệch nhỏ của thông số kỹ thuật đều có khả năng dẫn đến sản phẩm hỏng loại bỏ, do đó thao tác bắt buộc phải hết sức chính xác và cẩn trọng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [实际] (shíjì) - thực tế, thực tại [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '实际' AND pinyin = 'shíjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '实际'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'shíjì',
      meaning_vi = 'thực tế, thực tại',
      example_hanzi = '做事情不能光凭空想象，一定要紧密结合客观的实际情况。',
      example_pinyin = 'Zuò shìqing bù néng guāng píngkōng xiǎngxiàng, yídìng yào jǐnmì jiéhé kèguān de shíjì qíngkuàng.',
      example_vi = 'Làm việc không thể chỉ dựa vào tưởng tượng viển vông, nhất định phải gắn liền chặt chẽ với tình hình thực tế khách quan.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '做事情不能光凭空想象，一定要紧密结合客观的实际情况。', 'Zuò shìqing bù néng guāng píngkōng xiǎngxiàng, yídìng yào jǐnmì jiéhé kèguān de shíjì qíngkuàng.', 'Làm việc không thể chỉ dựa vào tưởng tượng viển vông, nhất định phải gắn liền chặt chẽ với tình hình thực tế khách quan.', 'basic', 1),
        (v_id, '任何理论政策的制定都必须坚持一切从实际出发，实事求是地解决人民群众最关心、最直接的利益问题。', 'Rènhé lǐlùn zhèngcè de zhìdìng dōu bìxū jiānchí yíqiè cóng shíjì chūfā, shíshì-qiúshì de jiějué rénmín qúnzhòng zuì guānxīn, zuì zhíjiē de lìyì wèntí.', 'Việc hoạch định bất kỳ chính sách lý luận nào cũng bắt buộc phải kiên trì tất cả xuất phát từ thực tế, giải quyết đúng sự thật những vấn đề lợi ích trực tiếp nhất, được quần chúng nhân dân quan tâm nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [时间表] (shíjiānbiǎo) - thời gian biểu, lịch trình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '时间表' AND pinyin = 'shíjiānbiǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '时间表'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shíjiānbiǎo',
      meaning_vi = 'thời gian biểu, lịch trình',
      example_hanzi = '新学期开始了，我给自己制定了一份科学合理的每日复习时间表。',
      example_pinyin = 'Xīn xuéqī kāishǐ le, wǒ gěi zìjǐ zhìdìng le yí fèn kēxué hélǐ de měirì fùxí shíjiānbiǎo.',
      example_vi = 'Học kỳ mới đã bắt đầu rồi, tôi đã tự lập cho mình một bản thời gian biểu ôn tập hàng ngày khoa học và hợp lý.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '新学期开始了，我给自己制定了一份科学合理的每日复习时间表。', 'Xīn xuéqī kāishǐ le, wǒ gěi zìjǐ zhìdìng le yí fèn kēxué hélǐ de měirì fùxí shíjiānbiǎo.', 'Học kỳ mới đã bắt đầu rồi, tôi đã tự lập cho mình một bản thời gian biểu ôn tập hàng ngày khoa học và hợp lý.', 'basic', 1),
        (v_id, '国家能源局明确了未来十年清洁能源转型的发展路线图和分阶段实施的时间表。', 'Guójiā Néngyuánjú míngquè le wèilái shí nián qīngjié néngyuán zhuǎnxíng de fāzhǎn lùxiàntú hé fēnjiēduàn shíshī de shíjiānbiǎo.', 'Cục Năng lượng Quốc gia đã xác định rõ lộ trình phát triển và thời gian biểu thực hiện theo từng giai đoạn của quá trình chuyển dịch năng lượng sạch trong mười năm tới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [实际上] (shíjìshàng) - trên thực tế, thực ra [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '实际上' AND pinyin = 'shíjìshàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '实际上'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'shíjìshàng',
      meaning_vi = 'trên thực tế, thực ra',
      example_hanzi = '大家以为他只学了半年中文，实际上他在家已经坚持自学两年多了。',
      example_pinyin = 'Dàjiā yǐwéi tā zhǐ xué le bàn nián Zhōngwén, shíjìshàng tā zài jiā yǐjīng jiānchí zìxué liǎng nián duō le.',
      example_vi = 'Mọi người ngỡ rằng anh ấy chỉ mới học tiếng Trung nửa năm, thực ra anh ấy ở nhà đã kiên trì tự học hơn hai năm rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大家以为他只学了半年中文，实际上他在家已经坚持自学两年多了。', 'Dàjiā yǐwéi tā zhǐ xué le bàn nián Zhōngwén, shíjìshàng tā zài jiā yǐjīng jiānchí zìxué liǎng nián duō le.', 'Mọi người ngỡ rằng anh ấy chỉ mới học tiếng Trung nửa năm, thực ra anh ấy ở nhà đã kiên trì tự học hơn hai năm rồi.', 'basic', 1),
        (v_id, '表面上看这只是一次普通的商业赞助合作，实际上是两家行业领军巨头在跨境电商领域的深度战略联姻。', 'Biǎomiàn shang kàn zhè zhǐ shì yí cì pǔtōng de shāngyè zànzhù hézuò, shíjìshàng shì liǎng jiā hángyè lǐngjūn jùtóu zài kuàjìng diànshāng lǐngyù de shēndù zhànlüè liányīn.', 'Nhìn bên ngoài thì đây chỉ là một vụ hợp tác tài trợ thương mại bình thường, thực tế trên thực tế là sự kết duyên chiến lược có chiều sâu giữa hai ông lớn đầu ngành trong lĩnh vực thương mại điện tử xuyên biên giới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [食品] (shípǐn) - thực phẩm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '食品' AND pinyin = 'shípǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '食品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shípǐn',
      meaning_vi = 'thực phẩm',
      example_hanzi = '我们在超市选购食品时，应当尽量选择低糖低盐的健康食品。',
      example_pinyin = 'Wǒmen zài chāoshì xuǎngòu shípǐn shí, yīngdāng jǐnliàng xuǎnzé dītáng-dīyán de jiànkāng shípǐn.',
      example_vi = 'Khi chúng ta chọn mua thực phẩm ở siêu thị, nên cố gắng chọn những thực phẩm lành mạnh ít đường ít muối.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们在超市选购食品时，应当尽量选择低糖低盐的健康食品。', 'Wǒmen zài chāoshì xuǎngòu shípǐn shí, yīngdāng jǐnliàng xuǎnzé dītáng-dīyán de jiànkāng shípǐn.', 'Khi chúng ta chọn mua thực phẩm ở siêu thị, nên cố gắng chọn những thực phẩm lành mạnh ít đường ít muối.', 'basic', 1),
        (v_id, '食品安全关乎人民群众的身体健康与生命安全，必须以最严谨的标准实行全链条严格监管。', 'Shípǐn ānquán guānhū rénmín qúnzhòng de shēntǐ jiànkāng yǔ shēngmìng ānquán, bìxū yǐ zuì yánjǐn de biāozhǔn shíxíng quánliàntiáo yángé jiānguǎn.', 'An toàn thực phẩm liên quan mật thiết đến sức khỏe thể chất và an toàn tính mạng của quần chúng nhân dân, bắt buộc phải áp dụng tiêu chuẩn nghiêm ngặt nhất để thực thi giám sát chặt chẽ toàn bộ chuỗi cung ứng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [食堂] (shítáng) - nhà ăn, căng tin [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '食堂' AND pinyin = 'shítáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '食堂'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shítáng',
      meaning_vi = 'nhà ăn, căng tin',
      example_hanzi = '我们大学食堂的饭菜既可口卫生又价格实惠，每天都有很多师生光顾。',
      example_pinyin = 'Wǒmen dàxué shítáng de fàncài jì kěkǒu wèishēng yòu jiàgé shíhuì, měi tiān dōu yǒu hěn duō shīshēng guānggù.',
      example_vi = 'Cơm canh ở nhà ăn trường đại học chúng tôi vừa ngon miệng vệ sinh lại có giá cả phải chăng, ngày nào cũng có rất đông thầy trò ghé ăn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们大学食堂的饭菜既可口卫生又价格实惠，每天都有很多师生光顾。', 'Wǒmen dàxué shítáng de fàncài jì kěkǒu wèishēng yòu jiàgé shíhuì, měi tiān dōu yǒu hěn duō shīshēng guānggù.', 'Cơm canh ở nhà ăn trường đại học chúng tôi vừa ngon miệng vệ sinh lại có giá cả phải chăng, ngày nào cũng có rất đông thầy trò ghé ăn.', 'basic', 1),
        (v_id, '为了切实保障职工的身心健康，公司工会全面升级了员工食堂的环境卫生与营养膳食搭配。', 'Wèile qièshí bǎozhàng zhígōng de shēnxīn jiànkāng, gōngsī gōnghuì quánmiàn shēngjí le yuángōng shítáng de huánjìng wèishēng yǔ yíngyǎng shànshí dāpèi.', 'Nhằm thiết thực bảo đảm sức khỏe thể chất và tinh thần cho người lao động, công đoàn công ty đã nâng cấp toàn diện vệ sinh môi trường và cách phối hợp khẩu phần ăn dinh dưỡng của nhà ăn cán bộ công nhân viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [食物] (shíwù) - thức ăn, món ăn, thực phẩm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '食物' AND pinyin = 'shíwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '食物'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shíwù',
      meaning_vi = 'thức ăn, món ăn, thực phẩm',
      example_hanzi = '勤俭节约是传统美德，我们每顿饭都应该按量盛取，绝不浪费食物。',
      example_pinyin = 'Qínjiǎn-jiéyuē shì chuántǒng měidé, wǒmen měi dùn fàn dōu yīnggāi àn liàng chéngqǔ, jué bú làngfèi shíwù.',
      example_vi = 'Cần kiệm tiết kiệm là mỹ đức truyền thống, mỗi bữa cơm chúng ta đều nên lấy vừa đủ lượng, tuyệt đối không lãng phí thức ăn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '勤俭节约是传统美德，我们每顿饭都应该按量盛取，绝不浪费食物。', 'Qínjiǎn-jiéyuē shì chuántǒng měidé, wǒmen měi dùn fàn dōu yīnggāi àn liàng chéngqǔ, jué bú làngfèi shíwù.', 'Cần kiệm tiết kiệm là mỹ đức truyền thống, mỗi bữa cơm chúng ta đều nên lấy vừa đủ lượng, tuyệt đối không lãng phí thức ăn.', 'basic', 1),
        (v_id, '在寒冷的冬季，野生动物往往面临天然食物匮乏的严峻挑战，林业部门为此组织了人工定点投喂救助。', 'Zài hánlěng de dōngjì, yěshēng dòngwù wǎngwǎng miànlín tiānrán shíwù kuìfá de yánjùn tiǎozhàn, línyè bùmén wèicǐ zǔzhī le réngōng dìngdiǎn tóuwèi jiùzhù.', 'Vào mùa đông lạnh giá, động vật hoang dã thường đối mặt trước thử thách gay gắt do thiếu hụt thức ăn tự nhiên, ngành lâm nghiệp vì thế đã tổ chức việc cho ăn cứu trợ định điểm nhân tạo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [实在] (shízài) - thật sự, quả thực; chân thành, thật thà [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '实在' AND pinyin = 'shízài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '实在'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'shízài',
      meaning_vi = 'thật sự, quả thực; chân thành, thật thà',
      example_hanzi = '他这个人说话做事向来非常实在，从来不夸大其词，大家都很信赖他。',
      example_pinyin = 'Tā zhè gè rén shuōhuà zuòshì xiànglái fēicháng shízài, cónglái bù kuādà-qící, dàjiā dōu hěn xìnlài tā.',
      example_vi = 'Con người anh ấy nói năng làm việc từ trước tới nay đều rất chân thành thật thà, chưa từng phóng đại nói quá, mọi người đều vô cùng tin cậy anh ấy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他这个人说话做事向来非常实在，从来不夸大其词，大家都很信赖他。', 'Tā zhè gè rén shuōhuà zuòshì xiànglái fēicháng shízài, cónglái bù kuādà-qící, dàjiā dōu hěn xìnlài tā.', 'Con người anh ấy nói năng làm việc từ trước tới nay đều rất chân thành thật thà, chưa từng phóng đại nói quá, mọi người đều vô cùng tin cậy anh ấy.', 'basic', 1),
        (v_id, '连续高强度加班了一个月，今天终于完成了上线部署，大家实在感觉精疲力竭，但心里感到无比欣慰。', 'Liánxù gāo qiángdù jiābān le yí gè yuè, jīntiān zhōngyú wánchéng le shàngxiàn bùshǔ, dàjiā shízài gǎnjué jīngpí-lìjié, dàn xīn lǐ gǎndào wúbǐ xīnwèi.', 'Liên tục tăng ca cường độ cao suốt một tháng, hôm nay rốt cuộc đã hoàn tất việc triển khai đưa hệ thống lên mạng, mọi người quả thực cảm thấy kiệt sức, nhưng trong lòng cảm thấy vô cùng mãn nguyện.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [十字路口] (shízì lùkǒu) - ngã tư đường [Cụm từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '十字路口' AND pinyin = 'shízì lùkǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '十字路口'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Cụm từ / Danh từ',
      pinyin = 'shízì lùkǒu',
      meaning_vi = 'ngã tư đường',
      example_hanzi = '在繁华市区的十字路口，行人和车辆都要严格看红绿灯指示有序通行。',
      example_pinyin = 'Zài fánhuá shìqū de shízì lùkǒu, xíngrén hé chēliàng dōu yào yángé kàn hónglǜdēng zhǐshì yǒuxù tōngxíng.',
      example_vi = 'Ở ngã tư đường thuộc khu nội thành phồn hoa, người đi bộ và xe cộ đều phải nhìn nghiêm ngặt theo tín hiệu đèn giao thông để lưu thông có trật tự.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在繁华市区的十字路口，行人和车辆都要严格看红绿灯指示有序通行。', 'Zài fánhuá shìqū de shízì lùkǒu, xíngrén hé chēliàng dōu yào yángé kàn hónglǜdēng zhǐshì yǒuxù tōngxíng.', 'Ở ngã tư đường thuộc khu nội thành phồn hoa, người đi bộ và xe cộ đều phải nhìn nghiêm ngặt theo tín hiệu đèn giao thông để lưu thông có trật tự.', 'basic', 1),
        (v_id, '站在人生职业规划的十字路口，是选择继续深造还是直接步入职场，需要结合自身长远优势作出审慎抉择。', 'Zhàn zài rénshēng zhíyè guīhuà de shízì lùkǒu, shì xuǎnzé jìxù shēnzào háishi zhíjiē bùrù zhíchǎng, xūyào jiéhé zìshēn chángyuǎn yōushì zuòchū shěnshèn juézé.', 'Đứng trước ngã tư đường của việc quy hoạch sự nghiệp cuộc đời, là lựa chọn tiếp tục học lên cao hay trực tiếp bước vào nơi làm việc, cần phải kết hợp thế mạnh dài hạn của bản thân để đưa ra sự lựa chọn cẩn trọng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [使] (shǐ) - khiến cho, làm cho [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '使' AND pinyin = 'shǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '使'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shǐ',
      meaning_vi = 'khiến cho, làm cho',
      example_hanzi = '经常进行户外慢跑和散步，能够使我们的身心得到极大的放松与舒缓。',
      example_pinyin = 'Jīngcháng jìnxíng hùwài mànpǎo hé sànbù, nénggòu shǐ wǒmen de shēnxīn dédào jídà de fàngsōng yǔ shūhuǎn.',
      example_vi = 'Thường xuyên chạy chậm và đi bộ ngoài trời có thể khiến cho thể chất và tinh thần của chúng ta nhận được sự thư giãn và xoa dịu rất lớn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经常进行户外慢跑和散步，能够使我们的身心得到极大的放松与舒缓。', 'Jīngcháng jìnxíng hùwài mànpǎo hé sànbù, nénggòu shǐ wǒmen de shēnxīn dédào jídà de fàngsōng yǔ shūhuǎn.', 'Thường xuyên chạy chậm và đi bộ ngoài trời có thể khiến cho thể chất và tinh thần của chúng ta nhận được sự thư giãn và xoa dịu rất lớn.', 'basic', 1),
        (v_id, '数字基础设施的全面升级普及，使得边远山区的农特产品能够通过直播电商迅捷销往全国各地。', 'Shùzì jīchǔ shèshī de quánmiàn shēngjí pǔjí, shǐde biānyuǎn shānqū de nóngtè chǎnpǐn nénggòu tōngguò zhībō diànshāng xùnjié xiāo wǎng quánguó gèdì.', 'Sự nâng cấp và phổ cập toàn diện của cơ sở hạ tầng số đã khiến cho nông đặc sản của vùng miền núi xa xôi có thể tiêu thụ nhanh chóng tới khắp mọi miền đất nước thông qua thương mại điện tử phát sóng trực tiếp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [使馆] (shǐguǎn) - đại sứ quán [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '使馆' AND pinyin = 'shǐguǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '使馆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shǐguǎn',
      meaning_vi = 'đại sứ quán',
      example_hanzi = '准备出国留学前，他前往中国驻当地使馆办理了相关的签证与认证手续。',
      example_pinyin = 'Zhǔnbèi chūguó liúxué qián, tā qiánwǎng Zhōngguó zhù dāngdì shǐguǎn bànlǐ le xiāngguān de qiānzhèng yǔ rènzhèng shǒuxù.',
      example_vi = 'Trước khi chuẩn bị đi du học, anh ấy đã tới đại sứ quán Trung Quốc ở sở tại để làm các thủ tục visa và thị thực chứng nhận liên quan.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '准备出国留学前，他前往中国驻当地使馆办理了相关的签证与认证手续。', 'Zhǔnbèi chūguó liúxué qián, tā qiánwǎng Zhōngguó zhù dāngdì shǐguǎn bànlǐ le xiāngguān de qiānzhèng yǔ rènzhèng shǒuxù.', 'Trước khi chuẩn bị đi du học, anh ấy đã tới đại sứ quán Trung Quốc ở sở tại để làm các thủ tục visa và thị thực chứng nhận liên quan.', 'basic', 1),
        (v_id, '使馆在促进两国双边经贸往来、深化民间文化艺术交流以及保护海外侨民合法权益方面发挥着桥梁纽带作用。', 'Shǐguǎn zài cùjìn liǎng guó shuāngbiān jīng-mào wǎnglái, shēnhuà mínjiān wénhuà yìshù jiāoliú yǐjí bǎohù hǎiwài qiáomín héfǎ quányì fāngmiàn fāhuīzhe qiáoliáng niǔdài zuòyòng.', 'Đại sứ quán phát huy vai trò cầu nối gắn kết trong việc thúc đẩy giao lưu kinh tế thương mại song phương giữa hai nước, làm sâu sắc giao lưu văn hóa nghệ thuật nhân dân cũng như bảo vệ quyền lợi hợp pháp của kiều bào ở hải ngoại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [使用] (shǐyòng) - sử dụng, dùng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '使用' AND pinyin = 'shǐyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '使用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shǐyòng',
      meaning_vi = 'sử dụng, dùng',
      example_hanzi = '购买新家用电器后，一定要仔细阅读说明书再正确开始使用。',
      example_pinyin = 'Gòumǎi xīn jiāyòng diànqì hòu, yídìng yào zǐxì yuèdú shuōmíngshū zài zhèngquè kāishǐ shǐyòng.',
      example_vi = 'Sau khi mua đồ điện gia dụng mới, nhất định phải đọc kỹ sách hướng dẫn sử dụng rồi mới bắt đầu sử dụng đúng cách.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '购买新家用电器后，一定要仔细阅读说明书再正确开始使用。', 'Gòumǎi xīn jiāyòng diànqì hòu, yídìng yào zǐxì yuèdú shuōmíngshū zài zhèngquè kāishǐ shǐyòng.', 'Sau khi mua đồ điện gia dụng mới, nhất định phải đọc kỹ sách hướng dẫn sử dụng rồi mới bắt đầu sử dụng đúng cách.', 'basic', 1),
        (v_id, '金融机构在收集和使用个人敏感数据信息时，必须严格遵守国家网络安全与个人信息保护法。', 'Jīnróng jīgòu zài shōují hé shǐyòng gèrén mǐngǎn shùjù xìnxī shí, bìxū yángé zūnshǒu guójiā wǎngluò ānquán yǔ gèrén xìnxī bǎohù fǎ.', 'Các tổ chức tài chính khi thu thập và sử dụng dữ liệu thông tin nhạy cảm cá nhân bắt buộc phải tuân thủ nghiêm ngặt Luật an ninh mạng và Luật bảo vệ thông tin cá nhân của nhà nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [市场] (shìchǎng) - thị trường, chợ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '市场' AND pinyin = 'shìchǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '市场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shìchǎng',
      meaning_vi = 'thị trường, chợ',
      example_hanzi = '每天清晨，早市农贸市场里都挤满了前来购买新鲜蔬菜水果的居民。',
      example_pinyin = 'Měi tiān qīngchén, zǎoshì nóngmào shìchǎng lǐ dōu jǐ mǎn le qiánlái gòumǎi xīnxiān shūcài shuǐguǒ de jūmín.',
      example_vi = 'Mỗi sáng sớm, trong chợ nông sản họp sớm đều đông nghẹt người dân tới mua rau quả tươi ngon.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天清晨，早市农贸市场里都挤满了前来购买新鲜蔬菜水果的居民。', 'Měi tiān qīngchén, zǎoshì nóngmào shìchǎng lǐ dōu jǐ mǎn le qiánlái gòumǎi xīnxiān shūcài shuǐguǒ de jūmín.', 'Mỗi sáng sớm, trong chợ nông sản họp sớm đều đông nghẹt người dân tới mua rau quả tươi ngon.', 'basic', 1),
        (v_id, '企业要敏锐把握海外新兴市场的多元消费需求，以高质量创新产品不断拓展国际市场份额。', 'Qǐyè yào mǐnruì bǎwò hǎiwài xīnxīng shìchǎng de duōyuán xiāofèi xūqiú, yǐ gāozhìliàng chuàngxīn chǎnpǐn bùduàn tuòzhǎn guójì shìchǎng fèn’é.', 'Doanh nghiệp cần nhạy bén nắm bắt nhu cầu tiêu dùng đa dạng của các thị trường mới nổi ở hải ngoại, dùng các sản phẩm đổi mới chất lượng cao để không ngừng mở rộng thị phần trên thị trường quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [是否] (shìfǒu) - có hay không, liệu có phải [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '是否' AND pinyin = 'shìfǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '是否'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'shìfǒu',
      meaning_vi = 'có hay không, liệu có phải',
      example_hanzi = '请您确认一下明天上午是否能够准时参加我们的班级座谈会。',
      example_pinyin = 'Qǐng nín quèrèn yíxià míngtiān shàngwǔ shìfǒu nénggòu zhǔnshí cānjiā wǒmen de bānjí zuòtánhuì.',
      example_vi = 'Xin bạn hãy xác nhận xem sáng mai liệu có thể tham gia buổi tọa đàm lớp học của chúng tôi đúng giờ hay không.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请您确认一下明天上午是否能够准时参加我们的班级座谈会。', 'Qǐng nín quèrèn yíxià míngtiān shàngwǔ shìfǒu nénggòu zhǔnshí cānjiā wǒmen de bānjí zuòtánhuì.', 'Xin bạn hãy xác nhận xem sáng mai liệu có thể tham gia buổi tọa đàm lớp học của chúng tôi đúng giờ hay không.', 'basic', 1),
        (v_id, '评判一项公共政策是否成功有效，最终要看是否真正解决了老百姓最现实最迫切的民生关切。', 'Píngpàn yí xiàng gōnggòng zhèngcè shìfǒu chénggōng yǒuxiào, zuìzhōng yào kàn shìfǒu zhēnzhèng jiějué le lǎobǎixìng zuì xiànshí zuì pòqiè de mínshēng guānqiè.', 'Đánh giá một chính sách công có thành công và hiệu quả hay không, cuối cùng phải nhìn vào việc liệu nó có thực sự giải quyết được những nỗi lo dân sinh thiết thực và cấp bách nhất của người dân hay không.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [适合] (shìhé) - phù hợp, thích hợp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '适合' AND pinyin = 'shìhé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '适合'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shìhé',
      meaning_vi = 'phù hợp, thích hợp',
      example_hanzi = '秋高气爽的时节，非常适合一家人去郊外登高徒步赏红叶。',
      example_pinyin = 'Qiūgāo-qìshuǎng de shíjié, fēicháng shìhé yì jiā rén qù jiāowài dēnggāo túbù shǎng hóngyè.',
      example_vi = 'Vào tiết trời thu cao khí mát, rất phù hợp cho cả gia đình cùng đi ngoại ô leo núi tản bộ ngắm lá đỏ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '秋高气爽的时节，非常适合一家人去郊外登高徒步赏红叶。', 'Qiūgāo-qìshuǎng de shíjié, fēicháng shìhé yì jiā rén qù jiāowài dēnggāo túbù shǎng hóngyè.', 'Vào tiết trời thu cao khí mát, rất phù hợp cho cả gia đình cùng đi ngoại ô leo núi tản bộ ngắm lá đỏ.', 'basic', 1),
        (v_id, '在职业生涯初期，选择一个契合个人兴趣特长且具备长远发展潜力的平台，往往比单纯追求高薪更为适合。', 'Zài zhíyè shēngyá chūqī, xuǎnzé yí gè qìhé gèrén xìngqù tècháng qiě jùbèi chángyuǎn fāzhǎn qiánlì de píngtái, wǎngwǎng bǐ dānchún zhuīqiú gāoxīn gèng wéi shìhé.', 'Trong giai đoạn đầu của sự nghiệp làm việc, chọn lựa một nền tảng phù hợp với sở thích sở trường của bản thân lại sở hữu tiềm năng phát triển lâu dài thường phù hợp hơn nhiều so với việc chỉ đơn thuần theo đuổi mức lương cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [世纪] (shìjì) - thế kỷ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '世纪' AND pinyin = 'shìjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '世纪'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shìjì',
      meaning_vi = 'thế kỷ',
      example_hanzi = '人类社会在二十一世纪迎来了人工智能与数字技术的全面爆发与深刻重塑。',
      example_pinyin = 'Rénlèi shèhuì zài èrshíyī shìjì yínglái le réngōng zhìnéng yǔ shùzì jìshù de quánmiàn bàofā yǔ shēnkè zhòngsù.',
      example_vi = 'Xã hội loài người trong thế kỷ hai mươi mốt đã đón nhận sự bùng nổ toàn diện và định hình lại sâu sắc của trí tuệ nhân tạo và công nghệ số.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '人类社会在二十一世纪迎来了人工智能与数字技术的全面爆发与深刻重塑。', 'Rénlèi shèhuì zài èrshíyī shìjì yínglái le réngōng zhìnéng yǔ shùzì jìshù de quánmiàn bàofā yǔ shēnkè zhòngsù.', 'Xã hội loài người trong thế kỷ hai mươi mốt đã đón nhận sự bùng nổ toàn diện và định hình lại sâu sắc của trí tuệ nhân tạo và công nghệ số.', 'basic', 1),
        (v_id, '回顾二十世纪波澜壮阔的世界近现代历史，维护和平与促进共同发展始终是各国人民的共同夙愿。', 'Huígù èrshí shìjì bōlán-zhuàngkuò de shìjiè jìn-xiàndài lìshǐ, wéihù hépíng yǔ cùjìn gòngtóng fāzhǎn shǐzhōng shì gè guó rénmín de gòngtóng sùyuàn.', 'Nhìn lại lịch sử cận hiện đại thế giới đầy sóng gió hào hùng của thế kỷ hai mươi, giữ gìn hòa bình và thúc đẩy cùng phát triển luôn là ước nguyện chung của nhân dân các nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [视频] (shìpín) - video, đoạn phim [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '视频' AND pinyin = 'shìpín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '视频'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shìpín',
      meaning_vi = 'video, đoạn phim',
      example_hanzi = '周末我喜欢在网络平台上观看优质的汉语教学视频和中国传统文化纪录片。',
      example_pinyin = 'Zhōumò wǒ xǐhuan zài wǎngluò píngtái shang guānkàn yōuzhì de Hànyǔ jiàoxué shìpín hé Zhōngguó chuántǒng wénhuà jìlùpiàn.',
      example_vi = 'Cuối tuần tôi thích xem các video dạy học tiếng Hán chất lượng cao và phim tài liệu văn hóa truyền thống Trung Quốc trên nền tảng mạng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末我喜欢在网络平台上观看优质的汉语教学视频和中国传统文化纪录片。', 'Zhōumò wǒ xǐhuan zài wǎngluò píngtái shang guānkàn yōuzhì de Hànyǔ jiàoxué shìpín hé Zhōngguó chuántǒng wénhuà jìlùpiàn.', 'Cuối tuần tôi thích xem các video dạy học tiếng Hán chất lượng cao và phim tài liệu văn hóa truyền thống Trung Quốc trên nền tảng mạng.', 'basic', 1),
        (v_id, '跨国企业广泛采用高清云视频会议系统，大幅降低了跨区域协作的沟通成本并显著提升了决策执行效率。', 'Kuàguó qǐyè guǎngfàn cǎiyòng gāoqīng yún shìpín huìyì xìtǒng, dàfú jiàngdī le kuà qūyù xiézuò de gōutōng chéngběn bìng xiǎnzhù tíshēng le juécè zhíxíng xiàolǜ.', 'Các doanh nghiệp đa quốc gia ứng dụng rộng rãi hệ thống hội nghị truyền hình video đám mây độ nét cao, giảm mạnh chi phí giao tiếp cộng tác liên vùng và nâng cao rõ rệt hiệu suất thực thi ra quyết định.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [市区] (shìqū) - khu vực nội thành, nội ô [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '市区' AND pinyin = 'shìqū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '市区'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shìqū',
      meaning_vi = 'khu vực nội thành, nội ô',
      example_hanzi = '从郊区坐地铁直达繁华的核心市区，全程只需要大约四十分钟车程。',
      example_pinyin = 'Cóng jiāoqū zuò dìtiě zhídá fánhuá de héxīn shìqū, quánchéng zhǐ xūyào dàyuē sìshí fēnzhōng chēchéng.',
      example_vi = 'Từ ngoại ô đi tàu điện ngầm chạy thẳng đến khu vực nội thành trọng tâm sầm uất, toàn bộ hành trình chỉ cần khoảng bốn mươi phút đi xe.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '从郊区坐地铁直达繁华的核心市区，全程只需要大约四十分钟车程。', 'Cóng jiāoqū zuò dìtiě zhídá fánhuá de héxīn shìqū, quánchéng zhǐ xūyào dàyuē sìshí fēnzhōng chēchéng.', 'Từ ngoại ô đi tàu điện ngầm chạy thẳng đến khu vực nội thành trọng tâm sầm uất, toàn bộ hành trình chỉ cần khoảng bốn mươi phút đi xe.', 'basic', 1),
        (v_id, '市政府持续加大对老旧市区的市政管网改造与绿化美化投入，显著提升了广大居民的宜居幸福感。', 'Shì zhèngfǔ chíxù jiàdà duì lǎojiù shìqū de shìzhèng guǎnwǎng gǎizào yǔ lǜhuà měihuà tóurù, xiǎnzhù tíshēng le guǎngdà jūmín de yíjū xìngfúgǎn.', 'Chính quyền thành phố tiếp tục gia tăng đầu tư cải tạo mạng lưới đường ống đô thị và phủ xanh làm đẹp cho khu nội thành cũ, nâng cao rõ rệt cảm giác hạnh phúc sống an cư của đông đảo cư dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [试题] (shìtí) - đề thi, câu hỏi thi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '试题' AND pinyin = 'shìtí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '试题'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shìtí',
      meaning_vi = 'đề thi, câu hỏi thi',
      example_hanzi = '期末考试的语文试题紧扣课本大纲，难度适中且题型设计新颖。',
      example_pinyin = 'Qīmò kǎoshì de yǔwén shìtí jǐnkòu kèběn dàgāng, nándù shìzhōng qiě tíxíng shèjì xīnyǐng.',
      example_vi = 'Đề thi môn Ngữ văn cuối kỳ bám sát đề cương sách giáo khoa, độ khó vừa phải và mẫu câu hỏi được thiết kế mới mẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '期末考试的语文试题紧扣课本大纲，难度适中且题型设计新颖。', 'Qīmò kǎoshì de yǔwén shìtí jǐnkòu kèběn dàgāng, nándù shìzhōng qiě tíxíng shèjì xīnyǐng.', 'Đề thi môn Ngữ văn cuối kỳ bám sát đề cương sách giáo khoa, độ khó vừa phải và mẫu câu hỏi được thiết kế mới mẻ.', 'basic', 1),
        (v_id, '命题专家组严格按照教育测量学标准，对国家统一考试的试题区分度与信效度进行了科学严密的抽样论证。', 'Mìngtí zhuānjiā zǔ yángé ànzhào jiàoyù cèliángxué biāozhǔn, duì guójiā tǒngyī kǎoshì de shìtí qūfēndù yǔ xìn-xiàodù jìnxíng le kēxué yánmì de chōuyàng lùnzhèng.', 'Tổ chuyên gia ra đề thi đã chiểu theo nghiêm ngặt các tiêu chuẩn trắc lượng giáo dục học, tiến hành chứng minh lấy mẫu khoa học và chặt chẽ đối với độ phân hóa và độ tin cậy hiệu lực của câu hỏi đề thi trong kỳ thi thống nhất toàn quốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [适应] (shìyìng) - thích nghi, thích ứng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '适应' AND pinyin = 'shìyìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '适应'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shìyìng',
      meaning_vi = 'thích nghi, thích ứng',
      example_hanzi = '刚到一个陌生的城市生活，需要一段时间来逐渐适应当地的气候和饮食。',
      example_pinyin = 'Gāng dào yí gè mòshēng de chéngshì shēnghuó, xūyào yí duàn shíjiān lái zhújiàn shìyìng dāngdì de qìhòu hé yǐnshí.',
      example_vi = 'Mới đến một thành phố xa lạ sinh sống, cần một khoảng thời gian để dần thích nghi với khí hậu và ăn uống bản địa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '刚到一个陌生的城市生活，需要一段时间来逐渐适应当地的气候和饮食。', 'Gāng dào yí gè mòshēng de chéngshì shēnghuó, xūyào yí duàn shíjiān lái zhújiàn shìyìng dāngdì de qìhòu hé yǐnshí.', 'Mới đến một thành phố xa lạ sinh sống, cần một khoảng thời gian để dần thích nghi với khí hậu và ăn uống bản địa.', 'basic', 1),
        (v_id, '面对日新月异的技术变革浪潮，现代企业与职场人士必须具备强大的自我迭代与快速适应能力。', 'Miànduì rìxīn-yuèyì de jìshù biàngé làngcháo, xiàndài qǐyè yǔ zhíchǎng rénshì bìxū jùbèi qiángdà de zìwǒ diédài yǔ kuàisù shìyìng nénglì.', 'Trước làn sóng biến đổi kỹ thuật đổi thay từng ngày, doanh nghiệp hiện đại và người lao động chốn công sở bắt buộc phải sở hữu năng lực tự nâng cấp mạnh mẽ và thích ứng nhanh chóng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [收费] (shōufèi) - thu phí, tính phí [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '收费' AND pinyin = 'shōufèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '收费'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shōufèi',
      meaning_vi = 'thu phí, tính phí',
      example_hanzi = '市内大部分公立公园和公共图书馆都常年对市民免费开放，不收取任何门票费用。',
      example_pinyin = 'Shì nèi dà bùfen gōnglì gōngyuán hé gōnggòng túshūguǎn dōu chángnián duì shìmín miǎnfèi kāifàng, bù shōuqǔ rènhé ménpiào fèiyong.',
      example_vi = 'Đa phần các công viên công lập và thư viện công cộng trong thành phố đều mở cửa miễn phí quanh năm cho người dân, không thu bất kỳ phí vé vào cửa nào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '市内大部分公立公园和公共图书馆都常年对市民免费开放，不收取任何门票费用。', 'Shì nèi dà bùfen gōnglì gōngyuán hé gōnggòng túshūguǎn dōu chángnián duì shìmín miǎnfèi kāifàng, bù shōuqǔ rènhé ménpiào fèiyong.', 'Đa phần các công viên công lập và thư viện công cộng trong thành phố đều mở cửa miễn phí quanh năm cho người dân, không thu bất kỳ phí vé vào cửa nào.', 'basic', 1),
        (v_id, '物价监管部门要求各物业服务公司严格按照明码标价规定，向全体业主全面公示各项物业收费细目。', 'Wùjià jiānguǎn bùmén yāoqiú gè wùyè fúwù gōngsī yángé ànzhào míngmǎ-biāojià guīdìng, xiàng quántǐ yèzhǔ quánmiàn gōngshì gè xiàng wùyè shōufèi xìmù.', 'Cơ quan giám sát vật giá yêu cầu các công ty dịch vụ quản lý tòa nhà phải chiểu theo nghiêm ngặt quy định niêm yết giá công khai, công bố toàn diện từng hạng mục thu phí quản lý tới toàn thể các chủ hộ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [收入] (shōurù) - thu nhập; thu vào [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '收入' AND pinyin = 'shōurù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '收入'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'shōurù',
      meaning_vi = 'thu nhập; thu vào',
      example_hanzi = '哥哥毕业工作两年后，每个月的工资收入比刚入职时有了明显的增长。',
      example_pinyin = 'Gēge bìyè gōngzuò liǎng nián hòu, měi gè yuè de gōngzī shōurù bǐ gāng rùzhí shí yǒu le míngxiǎn de zēngzhǎng.',
      example_vi = 'Anh trai sau khi tốt nghiệp đi làm hai năm, tiền lương thu nhập mỗi tháng đã có sự gia tăng rõ rệt so với lúc mới vào nghề.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '哥哥毕业工作两年后，每个月的工资收入比刚入职时有了明显的增长。', 'Gēge bìyè gōngzuò liǎng nián hòu, měi gè yuè de gōngzī shōurù bǐ gāng rùzhí shí yǒu le míngxiǎn de zēngzhǎng.', 'Anh trai sau khi tốt nghiệp đi làm hai năm, tiền lương thu nhập mỗi tháng đã có sự gia tăng rõ rệt so với lúc mới vào nghề.', 'basic', 1),
        (v_id, '深化收入分配制度改革，切实提高中低收入群体收入水平，是缩小贫富差距与扎实推进共同富裕的重要举措。', 'Shēnhuà shōurù fēnpèi zhìdù gǎigé, qièshí tígāo zhōng-dī shōurù qúntǐ shōurù shuǐpíng, shì suōxiǎo pín-fù chājù yǔ zhāshi tuījìn gòngtóng fùyù de zhòngyào jǔcuò.', 'Làm sâu sắc cải cách chế độ phân phối thu nhập, thiết thực nâng cao mức thu nhập của nhóm có thu nhập trung bình và thấp là biện pháp quan trọng để thu hẹp khoảng cách giàu nghèo và thúc đẩy vững chắc mục tiêu thịnh vượng chung.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [收拾] (shōushi) - dọn dẹp, thu dọn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '收拾' AND pinyin = 'shōushi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '收拾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shōushi',
      meaning_vi = 'dọn dẹp, thu dọn',
      example_hanzi = '周末上午我们花了两小时把整个书房和客厅收拾得干干净净。',
      example_pinyin = 'Zhōumò shàngwǔ wǒmen huā le liǎng xiǎoshí bǎ zhěnggè shūfáng hé kètīng shōushi de gāngānjìngjìng.',
      example_vi = 'Sáng cuối tuần chúng tôi dành ra hai tiếng đồng hồ dọn dẹp toàn bộ phòng đọc sách và phòng khách sạch bong kin kít.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末上午我们花了两小时把整个书房和客厅收拾得干干净净。', 'Zhōumò shàngwǔ wǒmen huā le liǎng xiǎoshí bǎ zhěnggè shūfáng hé kètīng shōushi de gāngānjìngjìng.', 'Sáng cuối tuần chúng tôi dành ra hai tiếng đồng hồ dọn dẹp toàn bộ phòng đọc sách và phòng khách sạch bong kin kít.', 'basic', 1),
        (v_id, '出差前必须仔细核对并收拾好所有商业合同原件与随行证件，避免因疏漏造成工作延误。', 'Chūchāi qián bìxū zǐxì héduì bìng shōushi hǎo suǒyǒu shāngyè hétong yuánjiàn yǔ suíxíng zhèngjiàn, bìmiǎn yīn shūlòu zàochéng gōngzuò yánwù.', 'Trước khi đi công tác bắt buộc phải kiểm tra kỹ lưỡng và thu dọn cẩn thận toàn bộ bản gốc hợp đồng thương mại và giấy tờ tùy thân mang theo, tránh vì sơ suất gây chậm trễ công việc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [收听] (shōutīng) - nghe đài, lắng nghe phát thanh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '收听' AND pinyin = 'shōutīng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '收听'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shōutīng',
      meaning_vi = 'nghe đài, lắng nghe phát thanh',
      example_hanzi = '爷爷每天清晨起床后第一件事就是打开收音机收听早间新闻广播。',
      example_pinyin = 'Yéye měi tiān qīngchén qǐchuáng hòu dì-yī jiàn shì jiùshì dǎkāi shōuyīnjī shōutīng zǎojiān xīnwén guǎngbō.',
      example_vi = 'Việc đầu tiên của ông nội sau khi thức dậy vào mỗi sáng sớm chính là bật radio nghe buổi phát thanh tin tức ban sáng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爷爷每天清晨起床后第一件事就是打开收音机收听早间新闻广播。', 'Yéye měi tiān qīngchén qǐchuáng hòu dì-yī jiàn shì jiùshì dǎkāi shōuyīnjī shōutīng zǎojiān xīnwén guǎngbō.', 'Việc đầu tiên của ông nội sau khi thức dậy vào mỗi sáng sớm chính là bật radio nghe buổi phát thanh tin tức ban sáng.', 'basic', 1),
        (v_id, '许多自驾车主在早晚高峰时段习惯收听交通广播电台，实时获取最新的城市路况与拥堵避让提示。', 'Xǔduō zìjià chēzhǔ zài zǎo-wǎn gāofēng shíduàn xíguàn shōutīng jiāotōng guǎngbō diàntái, shíshí huòqǔ zuìxīn de chéngshì lùkuàng yǔ yōngdǔ bìràng tíshì.', 'Nhiều chủ xe tự lái vào khung giờ cao điểm sáng tối có thói quen nghe đài phát thanh giao thông, thu nhận kịp thời tình hình đường sá thành phố và lời nhắc tránh ùn tắc mới nhất theo thời gian thực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [首] (shǒu) - bài (thơ, bài hát) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '首' AND pinyin = 'shǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '首'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'shǒu',
      meaning_vi = 'bài (thơ, bài hát)',
      example_hanzi = '这首优美动听的钢琴抒情曲总能让人在忙碌之后感到内心格外宁静。',
      example_pinyin = 'Zhè shǒu yōuměi dòngtīng de gāngqín shūqíngqǔ zǒng néng ràng rén zài mánglù zhīhòu gǎndào nèixīn géwài níngjìng.',
      example_vi = 'Khúc nhạc trữ tình piano du dương êm tai này luôn có thể khiến con người cảm thấy nội tâm đặc biệt bình yên sau những bận rộn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这首优美动听的钢琴抒情曲总能让人在忙碌之后感到内心格外宁静。', 'Zhè shǒu yōuměi dòngtīng de gāngqín shūqíngqǔ zǒng néng ràng rén zài mánglù zhīhòu gǎndào nèixīn géwài níngjìng.', 'Khúc nhạc trữ tình piano du dương êm tai này luôn có thể khiến con người cảm thấy nội tâm đặc biệt bình yên sau những bận rộn.', 'basic', 1),
        (v_id, '唐代诗人李白所作的这首千古名篇以宏大的想象力与壮丽的文辞，展现了中国古典诗歌的至高艺术造诣。', 'Tángdài shīrén Lǐ Bái suǒ zuò de zhè shǒu qiāngǔ míngpiān yǐ hóngdà de xiǎngxiànglì yǔ zhuànglì de wéncí, zhǎnxiàn le Zhōngguó gǔdiǎn shīgē de zhìgāo yìshù zàoyì.', 'Thi phẩm ngàn đời danh tiếng do nhà thơ thời Đường Lý Bạch sáng tác với trí tưởng tượng kỳ vĩ và câu từ tráng lệ đã thể hiện tài năng nghệ thuật tối cao của thi ca cổ điển Trung Hoa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [首都] (shǒudū) - thủ đô [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '首都' AND pinyin = 'shǒudū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '首都'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shǒudū',
      meaning_vi = 'thủ đô',
      example_hanzi = '北京是中国的首都，拥有悠久的历史文化和雄伟的故宫、长城等世界文化遗产。',
      example_pinyin = 'Běijīng shì Zhōngguó de shǒudū, yōngyǒu yōujiǔ de lìshǐ wénhuà hé xióngwěi de Gùgōng, Chángchéng děng shìjiè wénhuà yíchǎn.',
      example_vi = 'Bắc Kinh là thủ đô của Trung Quốc, sở hữu lịch sử văn hóa lâu đời cùng các di sản văn hóa thế giới hùng vĩ như Cố Cung, Vạn Lý Trường Thành.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '北京是中国的首都，拥有悠久的历史文化和雄伟的故宫、长城等世界文化遗产。', 'Běijīng shì Zhōngguó de shǒudū, yōngyǒu yōujiǔ de lìshǐ wénhuà hé xióngwěi de Gùgōng, Chángchéng děng shìjiè wénhuà yíchǎn.', 'Bắc Kinh là thủ đô của Trung Quốc, sở hữu lịch sử văn hóa lâu đời cùng các di sản văn hóa thế giới hùng vĩ như Cố Cung, Vạn Lý Trường Thành.', 'basic', 1),
        (v_id, '作为全国的政治中心和国际交往核心枢纽，首都持续优化城市功能布局，全面推进国际一流和谐宜居之都建设。', 'Zuòwéi quánguó de zhèngzhì zhōngxīn hé guójì jiāowǎng héxīn shūniǔ, shǒudū chíxù yōuhuà chéngshì gōngnéng bùjú, quánmiàn tuījìn guójì yīliú héxié yíjū zhī dū jiànshè.', 'Với tư cách là trung tâm chính trị và đầu mối trọng tâm giao lưu quốc tế của cả nước, thủ đô không ngừng tối ưu hóa bố cục chức năng đô thị, thúc đẩy toàn diện việc xây dựng thủ phủ quốc tế hạng nhất hài hòa đáng sống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [首先] (shǒuxiān) - đầu tiên, trước hết [Phó từ / Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '首先' AND pinyin = 'shǒuxiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '首先'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Đại từ',
      pinyin = 'shǒuxiān',
      meaning_vi = 'đầu tiên, trước hết',
      example_hanzi = '要想把中文学好，首先要下功夫打好拼音和声调的基础。',
      example_pinyin = 'Yào xiǎng bǎ Zhōngwén xué hǎo, shǒuxiān yào xià gōngfu dǎ hǎo pīnyīn hé shēngdiào de jīchǔ.',
      example_vi = 'Muốn học tốt tiếng Trung, trước hết phải bỏ công sức xây dựng nền tảng vững chắc về bính âm và các thanh điệu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '要想把中文学好，首先要下功夫打好拼音和声调的基础。', 'Yào xiǎng bǎ Zhōngwén xué hǎo, shǒuxiān yào xià gōngfu dǎ hǎo pīnyīn hé shēngdiào de jīchǔ.', 'Muốn học tốt tiếng Trung, trước hết phải bỏ công sức xây dựng nền tảng vững chắc về bính âm và các thanh điệu.', 'basic', 1),
        (v_id, '在推进重大工程项目立项时，首先必须全面开展环境影响评估，坚决守牢生态环保的安全红线。', 'Zài tuījìn zhòngdà gōngchéng xiàngmù lìxiàng shí, shǒuxiān bìxū quánmiàn kāizhǎn huánjìng yǐngxiǎng pínggū, jiānjué shǒuláo shēngtài huánbǎo de ānquán hóngxiàn.', 'Khi thúc đẩy thẩm định phê duyệt dự án công trình trọng điểm, trước hết bắt buộc phải triển khai đánh giá tác động môi trường một cách toàn diện, kiên quyết giữ vững ranh giới an toàn đỏ về bảo vệ môi trường sinh thái.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [受不了] (shòubuliǎo) - chịu không nổi, không chịu được [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '受不了' AND pinyin = 'shòubuliǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '受不了'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shòubuliǎo',
      meaning_vi = 'chịu không nổi, không chịu được',
      example_hanzi = '外面夏天的天气实在太闷热了，没有空调的话大家真的受不了。',
      example_pinyin = 'Wàimiàn xiàtiān de tiānqì shízài tài mēnrè le, méiyǒu kōngtiáo dehuà dàjiā zhēn de shòubuliǎo.',
      example_vi = 'Thời tiết mùa hè bên ngoài quả thực quá oi bức, nếu không có điều hòa thì mọi người thực sự chịu không nổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '外面夏天的天气实在太闷热了，没有空调的话大家真的受不了。', 'Wàimiàn xiàtiān de tiānqì shízài tài mēnrè le, méiyǒu kōngtiáo dehuà dàjiā zhēn de shòubuliǎo.', 'Thời tiết mùa hè bên ngoài quả thực quá oi bức, nếu không có điều hòa thì mọi người thực sự chịu không nổi.', 'basic', 1),
        (v_id, '面对长期无休止的高强度加班和缺乏人情味的管理模式，部分核心技术人员表示身心俱疲实在受不了，纷纷提出离职申请。', 'Miànduì chángqī wúxiūzhǐ de gāo qiángdù jiābān hé quēfá rénqíngwèi de guǎnlǐ móshì, bùfen héxīn jìshù rényuán biàoshì shēnxīn-jùpí shízài shòubuliǎo, fēnfēn tíchū lízhí shēnqǐng.', 'Đối mặt trước tình trạng tăng ca cường độ cao không hồi kết kéo dài và mô hình quản lý thiếu tình người, một số nhân viên kỹ thuật cốt lõi bày tỏ thân tâm rã rời thật sự không chịu nổi, rủ nhau nộp đơn xin thôi việc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [售票员] (shòupiàoyuán) - nhân viên bán vé [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '售票员' AND pinyin = 'shòupiàoyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '售票员'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shòupiàoyuán',
      meaning_vi = 'nhân viên bán vé',
      example_hanzi = '长途汽车站的售票员态度热情耐心，详细为旅客解答换乘班次问题。',
      example_pinyin = 'Chángtú qìchēzhàn de shòupiàoyuán tàidu rèqíng nàixīn, xiángxì wèi lǚkè jiědá huànchéng bāncì wèntí.',
      example_vi = 'Nhân viên bán vé của bến xe khách đường dài có thái độ nhiệt tình kiên nhẫn, giải đáp tỉ mỉ cho hành khách các thắc mắc về chuyến xe chuyển tuyến.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '长途汽车站的售票员态度热情耐心，详细为旅客解答换乘班次问题。', 'Chángtú qìchēzhàn de shòupiàoyuán tàidu rèqíng nàixīn, xiángxì wèi lǚkè jiědá huànchéng bāncì wèntí.', 'Nhân viên bán vé của bến xe khách đường dài có thái độ nhiệt tình kiên nhẫn, giải đáp tỉ mỉ cho hành khách các thắc mắc về chuyến xe chuyển tuyến.', 'basic', 1),
        (v_id, '虽然移动网络自主购票已经普及，但各大客运枢纽仍保留人工售票窗口，售票员专门为老年群体提供贴心温情的线下购票服务。', 'Suīrán yídòng wǎngluò zìzhǔ gòupiào yǐjīng pǔjí, dàn gè dà kèyùn shūniǔ réng bǎoliú réngōng shòupiào chuāngkǒu, shòupiàoyuán zhuānmén wèi lǎonián qúntǐ tígōng tiēxīn wēnqíng de xiànxià gòupiào fúwù.', 'Mặc dù việc tự mua vé qua mạng di động đã phổ cập, nhưng các đầu mối vận tải hành khách lớn vẫn duy trì quầy bán vé trực tiếp, các nhân viên bán vé chuyên cung cấp dịch vụ mua vé trực tiếp tận tình chu đáo cho đối tượng người cao tuổi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [受伤] (shòushāng) - bị thương [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '受伤' AND pinyin = 'shòushāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '受伤'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shòushāng',
      meaning_vi = 'bị thương',
      example_hanzi = '他在踢足球的时候不小心扭伤了右脚脚踝，受了点轻伤。',
      example_pinyin = 'Tā zài tī zúqiú de shíhou bù xiǎoxīn niǔshāng le yòujiǎo jiǎohuái, shòu le diǎn qīngshāng.',
      example_vi = 'Cậu ấy trong lúc đá bóng đã sơ ý trẹo mắt cá chân phải, bị thương nhẹ một chút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在踢足球的时候不小心扭伤了右脚脚踝，受了点轻伤。', 'Tā zài tī zúqiú de shíhou bù xiǎoxīn niǔshāng le yòujiǎo jiǎohuái, shòu le diǎn qīngshāng.', 'Cậu ấy trong lúc đá bóng đã sơ ý trẹo mắt cá chân phải, bị thương nhẹ một chút.', 'basic', 1),
        (v_id, '高速公路发生多车连环追尾事故后，交警与医护人员火速赶往现场救援，第一时间将受伤人员转移至医院抢救。', 'Gāosù gōnglù fāshēng duō chē liánhuán zhuīwěi shìgù hòu, jiāojǐng yǔ yīhù rényuán huǒsù gǎnwǎng xiànchǎng jiùyuán, dì-yī shíjiān jiāng shòushāng rényuán zhuǎnyí zhì yīyuàn qiǎngjiù.', 'Sau vụ tai nạn nhiều xe đâm liên hoàn trên đường cao tốc, cảnh sát giao thông và nhân viên y tế hỏa tốc tới hiện trường cứu hộ, ngay thời khắc đầu tiên đã chuyển những người bị thương tới bệnh viện cấp cứu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [输] (shū) - thua, thất bại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '输' AND pinyin = 'shū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '输'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shū',
      meaning_vi = 'thua, thất bại',
      example_hanzi = '友谊第一，比赛第二，即使下棋输了一局也不要灰心丧气。',
      example_pinyin = 'Yǒuyì dì-yī, bǐsài dì-èr, jíshǐ xiàqí shū le yì jú yě búyào huīxīn-sàngqì.',
      example_vi = 'Hữu nghị là hàng đầu, thi đấu là thứ hai, cho dù đánh cờ thua một ván cũng đừng nản lòng thoái chí.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '友谊第一，比赛第二，即使下棋输了一局也不要灰心丧气。', 'Yǒuyì dì-yī, bǐsài dì-èr, jíshǐ xiàqí shū le yì jú yě búyào huīxīn-sàngqì.', 'Hữu nghị là hàng đầu, thi đấu là thứ hai, cho dù đánh cờ thua một ván cũng đừng nản lòng thoái chí.', 'basic', 1),
        (v_id, '面对技术封锁与市场准入壁垒，自主创新型企业绝不能认输，唯有攻克核心关键技术才能赢得未来主动权。', 'Miànduì jìshù fēngsuǒ yǔ shìchǎng zhǔnrù bìlěi, zìzhǔ chuàngxīnxíng qǐyè jué bù néng rènshū, wéiyǒu gōngkè héxīn guānjiàn jìshù cái néng yíngdé wèilái zhǔdòngquán.', 'Đối mặt trước sự phong tỏa kỹ thuật và rào cản gia nhập thị trường, doanh nghiệp thuộc loại hình tự chủ đổi mới tuyệt đối không thể chịu thua, chỉ có công phá các kỹ thuật then chốt cốt lõi thì mới có thể giành lấy quyền chủ động trong tương lai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [熟] (shú/shóu) - chín (thức ăn); quen thuộc [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '熟' AND pinyin = 'shú/shóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '熟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'shú/shóu',
      meaning_vi = 'chín (thức ăn); quen thuộc',
      example_hanzi = '秋天到了，果园里的苹果和葡萄都熟透了，散发出诱人的香气。',
      example_pinyin = 'Qiūtiān dào le, guǒyuán lǐ de píngguǒ hé pútao dōu shú tòu le, sànfā chū yòurén de xiāngqì.',
      example_vi = 'Mùa thu đến rồi, táo và nho trong vườn quả đều đã chín mọng, tỏa ra hương thơm quyến rũ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '秋天到了，果园里的苹果和葡萄都熟透了，散发出诱人的香气。', 'Qiūtiān dào le, guǒyuán lǐ de píngguǒ hé pútao dōu shú tòu le, sànfā chū yòurén de xiāngqì.', 'Mùa thu đến rồi, táo và nho trong vườn quả đều đã chín mọng, tỏa ra hương thơm quyến rũ.', 'basic', 1),
        (v_id, '俗话说“熟能生巧”，复杂的临床手术操作技能必须通过成百上千次的反复严谨模拟训练才能达到精湛纯熟。', 'Súhuà shuō “shú néng shēng qiǎo”, fùzá de línchuáng shǒushù cāozuò jìnéng bìxū tōngguò chéng bǎi shàng qiān cì de fǎnfù yánjǐn mónǐ xùnliàn cái néng dádào jīngzhàn chúnshú.', 'Tục ngữ có câu "trăm hay không bằng tay quen", các kỹ năng thao tác phẫu thuật lâm sàng phức tạp bắt buộc phải thông qua hàng trăm hàng ngàn lần huấn luyện mô phỏng nghiêm cẩn lặp đi lặp lại thì mới có thể đạt tới mức điêu luyện thuần thục.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [熟悉] (shúxi) - quen thuộc, hiểu rõ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '熟悉' AND pinyin = 'shúxi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '熟悉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'shúxi',
      meaning_vi = 'quen thuộc, hiểu rõ',
      example_hanzi = '他在这座古城生活了二十多年，对这里的每条大街小巷都非常熟悉。',
      example_pinyin = 'Tā zài zhè zuò gǔchéng shēnghuó le èrshí duō nián, duì zhèlǐ de měi tiáo dàjiē-xiǎoxiàng dōu fēicháng shúxi.',
      example_vi = 'Anh ấy sinh sống ở tòa cổ thành này hơn hai mươi năm, đối với từng đường to ngõ nhỏ ở nơi này đều vô cùng quen thuộc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在这座古城生活了二十多年，对这里的每条大街小巷都非常熟悉。', 'Tā zài zhè zuò gǔchéng shēnghuó le èrshí duō nián, duì zhèlǐ de měi tiáo dàjiē-xiǎoxiàng dōu fēicháng shúxi.', 'Anh ấy sinh sống ở tòa cổ thành này hơn hai mươi năm, đối với từng đường to ngõ nhỏ ở nơi này đều vô cùng quen thuộc.', 'basic', 1),
        (v_id, '新员工入职后应当尽快熟悉企业内部的业务工作流程与规章制度，以便更好地融入团队协作体系。', 'Xīn yuángōng rùzhí hòu yīngdāng jǐnkuài shúxi qǐyè nèibù de yèwù gōngzuò liúchéng yǔ guīzhāng zhìdù, yǐbiàn gèng hǎo de róngrù tuánduì xiézuò tǐxì.', 'Nhân viên mới sau khi vào làm nên nhanh chóng làm quen và hiểu rõ các quy trình công tác nghiệp vụ cùng nội quy quy chế nội bộ doanh nghiệp, để hòa nhập tốt hơn vào hệ thống cộng tác nhóm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [暑假] (shǔjià) - nghỉ hè, kỳ nghỉ hè [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '暑假' AND pinyin = 'shǔjià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '暑假'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shǔjià',
      meaning_vi = 'nghỉ hè, kỳ nghỉ hè',
      example_hanzi = '今年暑假我打算和大学室友一起去云南旅游，领略美丽的高原风光。',
      example_pinyin = 'Jīnnián shǔjià wǒ dǎsuan hé dàxué shìyǒu yìqǐ qù Yúnnán lǚyóu, lǐnglüè měilì de gāoyuán fēngguāng.',
      example_vi = 'Kỳ nghỉ hè năm nay tôi dự định cùng bạn cùng phòng đại học đi du lịch Vân Nam, thưởng ngoạn phong cảnh cao nguyên tươi đẹp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今年暑假我打算和大学室友一起去云南旅游，领略美丽的高原风光。', 'Jīnnián shǔjià wǒ dǎsuan hé dàxué shìyǒu yìqǐ qù Yúnnán lǚyóu, lǐnglüè měilì de gāoyuán fēngguāng.', 'Kỳ nghỉ hè năm nay tôi dự định cùng bạn cùng phòng đại học đi du lịch Vân Nam, thưởng ngoạn phong cảnh cao nguyên tươi đẹp.', 'basic', 1),
        (v_id, '许多高校鼓励大学生利用暑假深入基层乡村开展科技文化卫生“三下乡”社会实践，将专业理论运用于乡村振兴实践。', 'Xǔduō gāoxiào gǔlì dàxuésheng lìyòng shǔjià shēnrù jīcéng xiāngcūn kāizhǎn kējì wénhuà wèishēng “sān xià xiāng” shèhuì shíjiàn, jiāng zhuānyè lǐlùn yùnyòng yú xiāngcūn zhènxīng shíjiàn.', 'Nhiều trường đại học khuyến khích sinh viên tận dụng kỳ nghỉ hè đi sâu vào các làng quê cơ sở triển khai phong trào thực tiễn xã hội "ba đưa về nông thôn" gồm khoa học kỹ thuật, văn hóa và y tế, vận dụng lý luận chuyên ngành vào thực tiễn chấn hưng nông thôn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [数] (shù) - con số, số lượng [Danh từ / Số từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '数' AND pinyin = 'shù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '数'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Số từ',
      pinyin = 'shù',
      meaning_vi = 'con số, số lượng',
      example_hanzi = '在数学课上，老师教我们认识自然数和分数的性质与运算法则。',
      example_pinyin = 'Zài shùxué kè shang, lǎoshī jiāo wǒmen rènshi zìránshù hé fēnshù de xìngzhì yǔ yùnsuàn fǎzé.',
      example_vi = 'Trong tiết học toán, thầy giáo dạy chúng tôi nhận biết tính chất và quy tắc vận hành tính toán của số tự nhiên và phân số.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在数学课上，老师教我们认识自然数和分数的性质与运算法则。', 'Zài shùxué kè shang, lǎoshī jiāo wǒmen rènshi zìránshù hé fēnshù de xìngzhì yǔ yùnsuàn fǎzé.', 'Trong tiết học toán, thầy giáo dạy chúng tôi nhận biết tính chất và quy tắc vận hành tính toán của số tự nhiên và phân số.', 'basic', 1),
        (v_id, '各项经济宏观运行指标的数字充分表明，国家实体经济基本盘稳固，展现出强大的发展韧性与增长潜力。', 'Gè xiàng jīngjì hóngguān yùnxíng zhǐbiāo de shùzì chōngfèn biǎomíng, guójiā shítǐ jīngjì jīběnpán wěngù, zhǎnxiàn chū qiángdà de fāzhǎn rènxìng yǔ zēngzhǎng qiánlì.', 'Các con số từ các chỉ tiêu vận hành vĩ mô kinh tế đã chứng minh đầy đủ rằng nền tảng cơ bản kinh tế thực của quốc gia rất vững chắc, thể hiện độ bền bỉ phát triển và tiềm năng tăng trưởng mạnh mẽ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [数量] (shùliàng) - số lượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '数量' AND pinyin = 'shùliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '数量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shùliàng',
      meaning_vi = 'số lượng',
      example_hanzi = '我们采购办公用品时，一定要仔细清点实际数量是否与发票清单一致。',
      example_pinyin = 'Wǒmen cǎigòu bàngōng yòngpǐn shí, yídìng yào zǐxì qīngdiǎn shíjì shùliàng shìfǒu yǔ fāpiào qīngdān yízhì.',
      example_vi = 'Khi chúng ta thu mua đồ dùng văn phòng, nhất định phải kiểm đếm kỹ xem số lượng thực tế có trùng khớp với danh sách hóa đơn hay không.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们采购办公用品时，一定要仔细清点实际数量是否与发票清单一致。', 'Wǒmen cǎigòu bàngōng yòngpǐn shí, yídìng yào zǐxì qīngdiǎn shíjì shùliàng shìfǒu yǔ fāpiào qīngdān yízhì.', 'Khi chúng ta thu mua đồ dùng văn phòng, nhất định phải kiểm đếm kỹ xem số lượng thực tế có trùng khớp với danh sách hóa đơn hay không.', 'basic', 1),
        (v_id, '现代制造业正在从单纯追求产品生产数量的规模扩张，加快向追求高品质与高附加值的内涵式增长模式转变。', 'Xiàndài zhìzàoyè zhèngzài cóng dānchún zhuīqiú chǎnpǐn shēngchǎn shùliàng de guīmó kuòzhāng, jiākuài xiàng zhuīqiú gāo pǐnzhì yǔ gāo fùjiāzhí de nèihánshì zēngzhǎng móshì zhuǎnbiàn.', 'Ngành sản xuất chế tạo hiện đại đang từ chỗ đơn thuần theo đuổi mở rộng quy mô về mặt số lượng sản phẩm, đẩy nhanh chuyển biến sang mô hình tăng trưởng hàm lượng nội tại hướng đến chất lượng cao và giá trị gia tăng cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [树林] (shùlín) - rừng cây, rặng cây [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '树林' AND pinyin = 'shùlín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '树林'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shùlín',
      meaning_vi = 'rừng cây, rặng cây',
      example_hanzi = '清晨漫步在校园的小树林里，能听到鸟儿欢快清脆的鸣叫声。',
      example_pinyin = 'Qīngchén mànbù zài xiàoyuán de xiǎo shùlín lǐ, néng tīngdào niǎor huānkuài qīngcuì de míngjiàoshēng.',
      example_vi = 'Sáng sớm tản bộ trong rừng cây nhỏ của khuôn viên trường, có thể nghe thấy tiếng hót trong trẻo vui tươi của bầy chim non.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '清晨漫步在校园的小树林里，能听到鸟儿欢快清脆的鸣叫声。', 'Qīngchén mànbù zài xiàoyuán de xiǎo shùlín lǐ, néng tīngdào niǎor huānkuài qīngcuì de míngjiàoshēng.', 'Sáng sớm tản bộ trong rừng cây nhỏ của khuôn viên trường, có thể nghe thấy tiếng hót trong trẻo vui tươi của bầy chim non.', 'basic', 1),
        (v_id, '生态防护林工程在沿海和干旱荒漠地带构筑起数道绿色屏障，有效阻遏了水土流失并改善了区域微气候环境。', 'Shēngtài fánghùlín gōngchéng zài yánhǎi hé gānhàn huāngmò dìdài gòuzhù qǐ shù dào lǜsè píngzhàng, yǒuxiào zǔ’è le shuǐ-tǔ liúshī bìng gǎishàn le qūyù wēi-qìhòu huánjìng.', 'Công trình rừng cây phòng hộ sinh thái đã dựng nên nhiều dải bình phong xanh ở các dải ven biển và vùng hoang mạc khô cằn, ngăn chặn xói mòn đất và rửa trôi nước hữu hiệu đồng thời cải thiện môi trường vi khí hậu khu vực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [数字] (shùzì) - chữ số, con số, kỹ thuật số [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '数字' AND pinyin = 'shùzì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '数字'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shùzì',
      meaning_vi = 'chữ số, con số, kỹ thuật số',
      example_hanzi = '设置网上银行支付密码时，切忌使用自己生日等过于简单的数字组合。',
      example_pinyin = 'Shèzhì wǎngshang yínháng zhīfù mìmǎ shí, qièjì shǐyòng zìjǐ shēngrì děng guòyú jiǎndān de shùzì zǔhé.',
      example_vi = 'Khi thiết lập mật khẩu thanh toán ngân hàng trực tuyến, tránh dùng những tổ hợp con số quá đơn giản như ngày sinh nhật của chính mình.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '设置网上银行支付密码时，切忌使用自己生日等过于简单的数字组合。', 'Shèzhì wǎngshang yínháng zhīfù mìmǎ shí, qièjì shǐyòng zìjǐ shēngrì děng guòyú jiǎndān de shùzì zǔhé.', 'Khi thiết lập mật khẩu thanh toán ngân hàng trực tuyến, tránh dùng những tổ hợp con số quá đơn giản như ngày sinh nhật của chính mình.', 'basic', 1),
        (v_id, '加快推进数字经济与实体经济深度融合，大力发展数字基础设施，是抢占未来国际竞争制高点的核心引擎。', 'Jiākuài tuījìn shùzì jīngjì yǔ shítǐ jīngjì shēndù rónghé, dàlì fāzhǎn shùzì jīchǔ shèshī, shì qiǎngzhàn wèilái guójì jìngzhēng zhìgāodiǎn de héxīn yǐnqíng.', 'Đẩy nhanh việc thúc đẩy hội nhập sâu giữa kinh tế số và kinh tế thực, dốc sức phát triển cơ sở hạ tầng số là động cơ cốt lõi nhằm chiếm lĩnh điểm cao trong cạnh tranh quốc tế mai sau.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [帅] (shuài) - đẹp trai, bảnh bao, tuấn tú [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '帅' AND pinyin = 'shuài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '帅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'shuài',
      meaning_vi = 'đẹp trai, bảnh bao, tuấn tú',
      example_hanzi = '哥哥今天换上这套运动装，显得特别英俊帅气。',
      example_pinyin = 'Gēge jīntiān huàn shàng zhè tào yùndòngzhuāng, xiǎnde tèbié yīngjùn shuàiqi.',
      example_vi = 'Hôm nay anh trai thay bộ đồ thể thao này, trông vô cùng anh tuấn và bảnh bao đẹp trai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '哥哥今天换上这套运动装，显得特别英俊帅气。', 'Gēge jīntiān huàn shàng zhè tào yùndòngzhuāng, xiǎnde tèbié yīngjùn shuàiqi.', 'Hôm nay anh trai thay bộ đồ thể thao này, trông vô cùng anh tuấn và bảnh bao đẹp trai.', 'basic', 1),
        (v_id, '真正的成熟与魅力不仅在于拥有帅气出众的外表，更在于内心坚韧负责的品格与深厚的文化涵养。', 'Zhēnzhèng de chéngshú yǔ mèilì bùjǐn zàiyú yōngyǒu shuàiqi chūzhòng de wàibiǎo, gèng zàiyú nèixīn jiānrèn fùzérèn de pǐngé yǔ shēnhòu de wénhuà hányǎng.', 'Sự chín chắn và quyến rũ đích thực không chỉ nằm ở việc sở hữu diện mạo đẹp trai xuất chúng bên ngoài, mà càng nằm ở phẩm cách kiên định đầy trách nhiệm bên trong và nội hàm văn hóa sâu sắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [顺便] (shùnbiàn) - nhân tiện, tiện thể [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '顺便' AND pinyin = 'shùnbiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '顺便'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'shùnbiàn',
      meaning_vi = 'nhân tiện, tiện thể',
      example_hanzi = '你下楼去超市买水果的时候，顺便帮我带一瓶牛奶回来吧。',
      example_pinyin = 'Nǐ xià lóu qù chāoshì mǎi shuǐguǒ de shíhou, shùnbiàn bāng wǒ dài yì píng niúnǎi huílái ba.',
      example_vi = 'Lúc bạn xuống tầng đi siêu thị mua hoa quả, tiện thể xách giúp mình một bình sữa bò về nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你下楼去超市买水果的时候，顺便帮我带一瓶牛奶回来吧。', 'Nǐ xià lóu qù chāoshì mǎi shuǐguǒ de shíhou, shùnbiàn bāng wǒ dài yì píng niúnǎi huílái ba.', 'Lúc bạn xuống tầng đi siêu thị mua hoa quả, tiện thể xách giúp mình một bình sữa bò về nhé.', 'basic', 1),
        (v_id, '趁着这次前往上海参加行业高峰论坛的契机，企业代表团顺便对长三角地区的多家战略合作伙伴进行了深度拜访考察。', 'Chènzhe zhè cì qiánwǎng Shànghǎi cānjiā hángyè gāofēng lùntán de qìjī, qǐyè dàibiǎotuán shùnbiàn duì Cháng-Sānjiǎo dìqū de duō jiā zhànlüè hézuò huǒbàn jìnxíng le shēndù bàifǎng kǎochá.', 'Nhân cơ hội tới Thượng Hải tham dự diễn đàn thượng đỉnh ngành nghề lần này, đoàn đại biểu doanh nghiệp đã tiện thể tiến hành viếng thăm và khảo sát sâu sắc nhiều đối tác hợp tác chiến lược ở khu vực đồng bằng Trường Giang.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [顺利] (shùnlì) - thuận lợi, suôn sẻ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '顺利' AND pinyin = 'shùnlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '顺利'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'shùnlì',
      meaning_vi = 'thuận lợi, suôn sẻ',
      example_hanzi = '祝贺你在今天的毕业答辩中发挥出色，顺利取得了硕士学位。',
      example_pinyin = 'Zhùhè nǐ zài jīntiān de bìyè dábiàn zhōng fāhuī chūsè, shùnlì qǔdé le shuòshì xuéwèi.',
      example_vi = 'Chúc mừng bạn trong buổi bảo vệ tốt nghiệp hôm nay đã phát huy xuất sắc, thuận lợi đạt được học vị thạc sĩ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '祝贺你在今天的毕业答辩中发挥出色，顺利取得了硕士学位。', 'Zhùhè nǐ zài jīntiān de bìyè dábiàn zhōng fāhuī chūsè, shùnlì qǔdé le shuòshì xuéwèi.', 'Chúc mừng bạn trong buổi bảo vệ tốt nghiệp hôm nay đã phát huy xuất sắc, thuận lợi đạt được học vị thạc sĩ.', 'basic', 1),
        (v_id, '在全体建设者夜以继日的协同奋战下，跨海特大桥主桥塔顺利实现精准合龙，创造了桥梁建造史上的新纪录。', 'Zài quántǐ jiànshèzhě yèyǐjìrì de xiétóng fènzhàn xià, kuàhǎi tèdàqiáo zhǔ qiáotǎ shùnlì shíxiàn jīngzhǔn hélóng, chuàngzào le qiáoliáng jiànzào shǐ shang de xīn jìlù.', 'Dưới sự chung sức chiến đấu ngày đêm của toàn thể các kỹ sư công nhân xây dựng, tháp chính cây cầu vượt biển siêu lớn đã thuận lợi hợp long chuẩn xác, tạo nên kỷ lục mới trong lịch sử xây dựng cầu đường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [顺序] (shùnxù) - thứ tự, trình tự [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '顺序' AND pinyin = 'shùnxù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '顺序'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shùnxù',
      meaning_vi = 'thứ tự, trình tự',
      example_hanzi = '在医院挂号看病时，请大家自觉按照排队叫号的先后顺序候诊。',
      example_pinyin = 'Zài yīyuàn guàhào kànbìng shí, qǐng dàjiā zìjué ànzhào páiduì jiàohào de xiānhòu shùnxù hòuzhěn.',
      example_vi = 'Khi lấy số khám bệnh ở bệnh viện, xin mọi người tự giác chờ khám theo thứ tự trước sau của việc xếp hàng gọi số.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在医院挂号看病时，请大家自觉按照排队叫号的先后顺序候诊。', 'Zài yīyuàn guàhào kànbìng shí, qǐng dàjiā zìjué ànzhào páiduì jiàohào de xiānhòu shùnxù hòuzhěn.', 'Khi lấy số khám bệnh ở bệnh viện, xin mọi người tự giác chờ khám theo thứ tự trước sau của việc xếp hàng gọi số.', 'basic', 1),
        (v_id, '安装大型工业自动化精密设备时，必须严格遵循技术手册规定的装配顺序，任何工序颠倒都可能引发设备故障。', 'Ānzhuāng dàxíng gōngyè zìdònghuà jīngmì shèbèi shí, bìxū yángé zūnxún jìshù shǒucè guīdìng de zhuāngpèi shùnxù, rènhé gōngxù diāndǎo dōu kěnéng yǐnfā shèbèi gùzhàng.', 'Khi lắp đặt các thiết bị tinh vi tự động hóa công nghiệp cỡ lớn, bắt buộc phải tuân thủ nghiêm ngặt trình tự lắp ráp được quy định trong sổ tay kỹ thuật, bất kỳ công đoạn nào bị đảo lộn đều có thể gây ra sự cố hỏng hóc thiết bị.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [说法] (shuōfǎ) - cách nói, phát biểu, quan điểm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '说法' AND pinyin = 'shuōfǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '说法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shuōfǎ',
      meaning_vi = 'cách nói, phát biểu, quan điểm',
      example_hanzi = '民间常有“冬吃萝卜夏吃姜”的传统养生说法，蕴含着朴素的生活智慧。',
      example_pinyin = 'Mínjiān cháng yǒu “dōng chī luóbo xià chī jiāng” de chuántǒng yǎngshēng shuōfǎ, yùnhánzhe pǔsù de shēnghuó zhìhuì.',
      example_vi = 'Trong dân gian thường có cách nói dưỡng sinh truyền thống "mùa đông ăn củ cải mùa hè ăn gừng", ẩn chứa trí tuệ đời sống mộc mạc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '民间常有“冬吃萝卜夏吃姜”的传统养生说法，蕴含着朴素的生活智慧。', 'Mínjiān cháng yǒu “dōng chī luóbo xià chī jiāng” de chuántǒng yǎngshēng shuōfǎ, yùnhánzhe pǔsù de shēnghuó zhìhuì.', 'Trong dân gian thường có cách nói dưỡng sinh truyền thống "mùa đông ăn củ cải mùa hè ăn gừng", ẩn chứa trí tuệ đời sống mộc mạc.', 'basic', 1),
        (v_id, '对于网络上流传的不实谣言，官方权威部门应当在第一时间发布事实核查通报，给广大社会公众一个明确权威的说法。', 'Duìyú wǎngluò shang liúchuán de bùshí yáoyán, guānfāng quánwēi bùmén yīngdāng zài dì-yī shíjiān fābù shìshí héchá tōngbào, gěi guǎngdà shèhuì gōngzhòng yí gè míngquè quánwēi de shuōfǎ.', 'Đối với những tin đồn thất thiệt lan truyền trên mạng, các ban ngành thẩm quyền chính thức cần phát thông báo xác minh sự thật ngay thời khắc đầu tiên, mang lại lời giải thích rõ ràng và uy tín cho đông đảo công chúng xã hội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [说明] (shuōmíng) - thuyết minh, giải thích, làm rõ; lời giải thích [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '说明' AND pinyin = 'shuōmíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '说明'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'shuōmíng',
      meaning_vi = 'thuyết minh, giải thích, làm rõ; lời giải thích',
      example_hanzi = '请你向大家详细说明一下这次校园文化节活动的具体举办方案。',
      example_pinyin = 'Qǐng nǐ xiàng dàjiā xiángxì shuōmíng yíxià zhè cì xiàoyuán wénhuàjié huódòng de jùtǐ jǔbàn fāng’àn.',
      example_vi = 'Xin mời bạn giải thích chi tiết cho mọi người về phương án tổ chức cụ thể của hoạt động lễ hội văn hóa học đường lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请你向大家详细说明一下这次校园文化节活动的具体举办方案。', 'Qǐng nǐ xiàng dàjiā xiángxì shuōmíng yíxià zhè cì xiàoyuán wénhuàjié huódòng de jùtǐ jǔbàn fāng’àn.', 'Xin mời bạn giải thích chi tiết cho mọi người về phương án tổ chức cụ thể của hoạt động lễ hội văn hóa học đường lần này.', 'basic', 1),
        (v_id, '近几个月外贸出口数据的持续强劲反弹，充分说明国家一系列稳外贸促创新的政策举措正在发挥显著实效。', 'Jìn jǐ gè yuè wàimào chūkǒu shùjù de chíxù qiángjìng fǎntán, chōngfèn shuōmíng guójiā yí xìliè wěn wàimào cù chuàngxīn de zhèngcè jǔcuò zhèngzài fāhuī xiǎnzhù shíxiào.', 'Sự bật tăng mạnh mẽ liên tục của số liệu xuất khẩu ngoại thương trong mấy tháng gần đây đã chứng minh rõ ràng rằng một loạt chính sách biện pháp ổn định ngoại thương thúc đẩy đổi mới của nhà nước đang phát huy hiệu quả thực tế rõ rệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 198 câu ví dụ cho % từ vựng HSK 4 (Batch 7: #1601 -> #1700)!', v_count;
END $$;
