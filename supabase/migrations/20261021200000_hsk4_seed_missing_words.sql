-- ====================================================================
-- MIGRATION: HSK 4 - BƯỚC 2: BỔ SUNG 480 MỤC TỪ VỰNG CHUẨN ĐỀ CƯƠNG HSK 3.0
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn 11/2025)
-- Mục tiêu: Đưa HSK 4 đạt chính xác 1.000 / 1.000 từ vựng chuẩn (ID 1001 -> 2000)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Sử dụng INSERT ... ON CONFLICT hoặc IF NOT EXISTS tránh lỗi trùng lặp
--   - Cung cấp đầy đủ Chữ Hán, Pinyin có dấu, Từ loại tiếng Việt chuẩn, và Nghĩa TV
-- ====================================================================

DO $$
DECLARE
  v_count integer := 0;
BEGIN
  -- [啊] (ā) - a, chao ôi (thán từ cảm thán) [Thán từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '啊'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('啊', 'ā', 'a, chao ôi (thán từ cảm thán)', 'Thán từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'ā',
      meaning_vi = 'a, chao ôi (thán từ cảm thán)',
      word_type = 'Thán từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '啊';
  END IF;

  -- [爱心] (àixīn) - lòng yêu thương, tâm lòng nhân ái [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '爱心'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('爱心', 'àixīn', 'lòng yêu thương, tâm lòng nhân ái', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'àixīn',
      meaning_vi = 'lòng yêu thương, tâm lòng nhân ái',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '爱心';
  END IF;

  -- [安检] (ānjiǎn) - kiểm tra an ninh [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '安检'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('安检', 'ānjiǎn', 'kiểm tra an ninh', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'ānjiǎn',
      meaning_vi = 'kiểm tra an ninh',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '安检';
  END IF;

  -- [按] (àn) - ấn, bấm; theo, căn cứ vào [Động từ / Giới từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '按'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('按', 'àn', 'ấn, bấm; theo, căn cứ vào', 'Động từ / Giới từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'àn',
      meaning_vi = 'ấn, bấm; theo, căn cứ vào',
      word_type = 'Động từ / Giới từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '按';
  END IF;

  -- [白酒] (báijiǔ) - rượu trắng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '白酒'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('白酒', 'báijiǔ', 'rượu trắng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'báijiǔ',
      meaning_vi = 'rượu trắng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '白酒';
  END IF;

  -- [办公] (bàngōng) - làm việc tại văn phòng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '办公'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('办公', 'bàngōng', 'làm việc tại văn phòng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bàngōng',
      meaning_vi = 'làm việc tại văn phòng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '办公';
  END IF;

  -- [办理] (bànlǐ) - xử lý, giải quyết, làm thủ tục [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '办理'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('办理', 'bànlǐ', 'xử lý, giải quyết, làm thủ tục', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bànlǐ',
      meaning_vi = 'xử lý, giải quyết, làm thủ tục',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '办理';
  END IF;

  -- [办事] (bànshì) - làm việc, giải quyết công việc [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '办事'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('办事', 'bànshì', 'làm việc, giải quyết công việc', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bànshì',
      meaning_vi = 'làm việc, giải quyết công việc',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '办事';
  END IF;

  -- [报考] (bàokǎo) - đăng ký dự thi [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '报考'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('报考', 'bàokǎo', 'đăng ký dự thi', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bàokǎo',
      meaning_vi = 'đăng ký dự thi',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '报考';
  END IF;

  -- [背] (bēi) - cõng, đeo, mang trên lưng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '背'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('背', 'bēi', 'cõng, đeo, mang trên lưng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bēi',
      meaning_vi = 'cõng, đeo, mang trên lưng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '背';
  END IF;

  -- [背包] (bēibāo) - ba lô, túi đeo lưng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '背包'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('背包', 'bēibāo', 'ba lô, túi đeo lưng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bēibāo',
      meaning_vi = 'ba lô, túi đeo lưng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '背包';
  END IF;

  -- [北部] (běibù) - miền bắc, phía bắc [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '北部'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('北部', 'běibù', 'miền bắc, phía bắc', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'běibù',
      meaning_vi = 'miền bắc, phía bắc',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '北部';
  END IF;

  -- [本科] (běnkē) - đại học chính quy, cử nhân [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '本科'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('本科', 'běnkē', 'đại học chính quy, cử nhân', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'běnkē',
      meaning_vi = 'đại học chính quy, cử nhân',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '本科';
  END IF;

  -- [笔试] (bǐshì) - thi viết [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '笔试'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('笔试', 'bǐshì', 'thi viết', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bǐshì',
      meaning_vi = 'thi viết',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '笔试';
  END IF;

  -- [毕业生] (bìyèshēng) - sinh viên tốt nghiệp [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '毕业生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('毕业生', 'bìyèshēng', 'sinh viên tốt nghiệp', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bìyèshēng',
      meaning_vi = 'sinh viên tốt nghiệp',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '毕业生';
  END IF;

  -- [便于] (biànyú) - thuận tiện cho, tiện bề [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '便于'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('便于', 'biànyú', 'thuận tiện cho, tiện bề', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'biànyú',
      meaning_vi = 'thuận tiện cho, tiện bề',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '便于';
  END IF;

  -- [表] (biǎo) - đồng hồ; biểu mẫu, bảng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '表'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('表', 'biǎo', 'đồng hồ; biểu mẫu, bảng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'biǎo',
      meaning_vi = 'đồng hồ; biểu mẫu, bảng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '表';
  END IF;

  -- [表现] (biǎoxiàn) - thể hiện, biểu hiện [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '表现'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('表现', 'biǎoxiàn', 'thể hiện, biểu hiện', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'biǎoxiàn',
      meaning_vi = 'thể hiện, biểu hiện',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '表现';
  END IF;

  -- [并] (bìng) - và, đồng thời; hoàn toàn (không) [Liên từ / Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '并'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('并', 'bìng', 'và, đồng thời; hoàn toàn (không)', 'Liên từ / Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bìng',
      meaning_vi = 'và, đồng thời; hoàn toàn (không)',
      word_type = 'Liên từ / Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '并';
  END IF;

  -- [播放] (bōfàng) - phát sóng, mở (nhạc/video) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '播放'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('播放', 'bōfàng', 'phát sóng, mở (nhạc/video)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bōfàng',
      meaning_vi = 'phát sóng, mở (nhạc/video)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '播放';
  END IF;

  -- [不必] (búbì) - không cần thiết, không cần [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不必'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('不必', 'búbì', 'không cần thiết, không cần', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'búbì',
      meaning_vi = 'không cần thiết, không cần',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '不必';
  END IF;

  -- [不便] (búbiàn) - bất tiện, không tiện [Tính từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不便'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('不便', 'búbiàn', 'bất tiện, không tiện', 'Tính từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'búbiàn',
      meaning_vi = 'bất tiện, không tiện',
      word_type = 'Tính từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '不便';
  END IF;

  -- [不断] (búduàn) - không ngừng, liên tục [Phó từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不断'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('不断', 'búduàn', 'không ngừng, liên tục', 'Phó từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'búduàn',
      meaning_vi = 'không ngừng, liên tục',
      word_type = 'Phó từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '不断';
  END IF;

  -- [不够] (búgòu) - không đủ, chưa đủ [Động từ / Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不够'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('不够', 'búgòu', 'không đủ, chưa đủ', 'Động từ / Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'búgòu',
      meaning_vi = 'không đủ, chưa đủ',
      word_type = 'Động từ / Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '不够';
  END IF;

  -- [不论] (búlùn) - bất kể, cho dù [Liên từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不论'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('不论', 'búlùn', 'bất kể, cho dù', 'Liên từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'búlùn',
      meaning_vi = 'bất kể, cho dù',
      word_type = 'Liên từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '不论';
  END IF;

  -- [步] (bù) - bước, bước chân [Danh từ / Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '步'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('步', 'bù', 'bước, bước chân', 'Danh từ / Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bù',
      meaning_vi = 'bước, bước chân',
      word_type = 'Danh từ / Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '步';
  END IF;

  -- [部] (bù) - bộ phận, bộ (phim/sách) [Danh từ / Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '部'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('部', 'bù', 'bộ phận, bộ (phim/sách)', 'Danh từ / Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bù',
      meaning_vi = 'bộ phận, bộ (phim/sách)',
      word_type = 'Danh từ / Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '部';
  END IF;

  -- [不光] (bùguāng) - không chỉ, không riêng [Phó từ / Liên từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不光'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('不光', 'bùguāng', 'không chỉ, không riêng', 'Phó từ / Liên từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bùguāng',
      meaning_vi = 'không chỉ, không riêng',
      word_type = 'Phó từ / Liên từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '不光';
  END IF;

  -- [不满] (bùmǎn) - bất mãn, không hài lòng [Tính từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不满'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('不满', 'bùmǎn', 'bất mãn, không hài lòng', 'Tính từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bùmǎn',
      meaning_vi = 'bất mãn, không hài lòng',
      word_type = 'Tính từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '不满';
  END IF;

  -- [部门] (bùmén) - phòng ban, bộ phận [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '部门'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('部门', 'bùmén', 'phòng ban, bộ phận', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bùmén',
      meaning_vi = 'phòng ban, bộ phận',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '部门';
  END IF;

  -- [不如] (bùrú) - không bằng, chi bằng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '不如'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('不如', 'bùrú', 'không bằng, chi bằng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'bùrú',
      meaning_vi = 'không bằng, chi bằng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '不如';
  END IF;

  -- [参赛] (cānsài) - tham gia thi đấu [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '参赛'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('参赛', 'cānsài', 'tham gia thi đấu', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cānsài',
      meaning_vi = 'tham gia thi đấu',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '参赛';
  END IF;

  -- [操场] (cāochǎng) - sân tập thể thao, sân trường [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '操场'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('操场', 'cāochǎng', 'sân tập thể thao, sân trường', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cāochǎng',
      meaning_vi = 'sân tập thể thao, sân trường',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '操场';
  END IF;

  -- [查看] (chákàn) - xem xét, kiểm tra [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '查看'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('查看', 'chákàn', 'xem xét, kiểm tra', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chákàn',
      meaning_vi = 'xem xét, kiểm tra',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '查看';
  END IF;

  -- [茶叶] (cháyè) - lá trà, búp chè [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '茶叶'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('茶叶', 'cháyè', 'lá trà, búp chè', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cháyè',
      meaning_vi = 'lá trà, búp chè',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '茶叶';
  END IF;

  -- [查找] (cházhǎo) - tìm kiếm, tra cứu [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '查找'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('查找', 'cházhǎo', 'tìm kiếm, tra cứu', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cházhǎo',
      meaning_vi = 'tìm kiếm, tra cứu',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '查找';
  END IF;

  -- [差点儿] (chàdiǎnr) - suýt nữa, suýt chút nữa [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '差点儿'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('差点儿', 'chàdiǎnr', 'suýt nữa, suýt chút nữa', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chàdiǎnr',
      meaning_vi = 'suýt nữa, suýt chút nữa',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '差点儿';
  END IF;

  -- [产生] (chǎnshēng) - nảy sinh, sản sinh, xuất hiện [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '产生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('产生', 'chǎnshēng', 'nảy sinh, sản sinh, xuất hiện', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chǎnshēng',
      meaning_vi = 'nảy sinh, sản sinh, xuất hiện',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '产生';
  END IF;

  -- [厂] (chǎng) - nhà máy, xưởng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '厂'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('厂', 'chǎng', 'nhà máy, xưởng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chǎng',
      meaning_vi = 'nhà máy, xưởng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '厂';
  END IF;

  -- [车速] (chēsù) - tốc độ xe [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '车速'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('车速', 'chēsù', 'tốc độ xe', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chēsù',
      meaning_vi = 'tốc độ xe',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '车速';
  END IF;

  -- [车位] (chēwèi) - chỗ đỗ xe [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '车位'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('车位', 'chēwèi', 'chỗ đỗ xe', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chēwèi',
      meaning_vi = 'chỗ đỗ xe',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '车位';
  END IF;

  -- [城] (chéng) - thành phố, đô thị, tường thành [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '城'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('城', 'chéng', 'thành phố, đô thị, tường thành', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chéng',
      meaning_vi = 'thành phố, đô thị, tường thành',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '城';
  END IF;

  -- [乘] (chéng) - đi, đáp (xe/tàu); nhân (toán) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '乘'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('乘', 'chéng', 'đi, đáp (xe/tàu); nhân (toán)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chéng',
      meaning_vi = 'đi, đáp (xe/tàu); nhân (toán)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '乘';
  END IF;

  -- [乘客] (chéngkè) - hành khách [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '乘客'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('乘客', 'chéngkè', 'hành khách', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chéngkè',
      meaning_vi = 'hành khách',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '乘客';
  END IF;

  -- [迟] (chí) - muộn, trễ [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '迟'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('迟', 'chí', 'muộn, trễ', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chí',
      meaning_vi = 'muộn, trễ',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '迟';
  END IF;

  -- [出口] (chūkǒu) - cửa ra; xuất khẩu [Danh từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '出口'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('出口', 'chūkǒu', 'cửa ra; xuất khẩu', 'Danh từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chūkǒu',
      meaning_vi = 'cửa ra; xuất khẩu',
      word_type = 'Danh từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '出口';
  END IF;

  -- [出行] (chūxíng) - đi lại, xuất hành [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '出行'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('出行', 'chūxíng', 'đi lại, xuất hành', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chūxíng',
      meaning_vi = 'đi lại, xuất hành',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '出行';
  END IF;

  -- [出租] (chūzū) - cho thuê [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '出租'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('出租', 'chūzū', 'cho thuê', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chūzū',
      meaning_vi = 'cho thuê',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '出租';
  END IF;

  -- [厨师] (chúshī) - đầu bếp [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '厨师'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('厨师', 'chúshī', 'đầu bếp', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chúshī',
      meaning_vi = 'đầu bếp',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '厨师';
  END IF;

  -- [窗] (chuāng) - cửa sổ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '窗'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('窗', 'chuāng', 'cửa sổ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chuāng',
      meaning_vi = 'cửa sổ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '窗';
  END IF;

  -- [吹] (chuī) - thổi; chia tay [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '吹'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('吹', 'chuī', 'thổi; chia tay', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'chuī',
      meaning_vi = 'thổi; chia tay',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '吹';
  END IF;

  -- [此] (cǐ) - này, đây [Đại từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '此'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('此', 'cǐ', 'này, đây', 'Đại từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cǐ',
      meaning_vi = 'này, đây',
      word_type = 'Đại từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '此';
  END IF;

  -- [此次] (cǐ cì) - lần này [Cụm từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '此次'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('此次', 'cǐ cì', 'lần này', 'Cụm từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cǐ cì',
      meaning_vi = 'lần này',
      word_type = 'Cụm từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '此次';
  END IF;

  -- [此外] (cǐwài) - ngoài ra, hơn nữa [Liên từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '此外'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('此外', 'cǐwài', 'ngoài ra, hơn nữa', 'Liên từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cǐwài',
      meaning_vi = 'ngoài ra, hơn nữa',
      word_type = 'Liên từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '此外';
  END IF;

  -- [从此] (cóngcǐ) - từ đó, từ nay về sau [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '从此'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('从此', 'cóngcǐ', 'từ đó, từ nay về sau', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cóngcǐ',
      meaning_vi = 'từ đó, từ nay về sau',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '从此';
  END IF;

  -- [从中] (cóngzhōng) - từ đó, trong đó [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '从中'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('从中', 'cóngzhōng', 'từ đó, trong đó', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cóngzhōng',
      meaning_vi = 'từ đó, trong đó',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '从中';
  END IF;

  -- [粗] (cū) - thô, to, dày, vụng về [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '粗'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('粗', 'cū', 'thô, to, dày, vụng về', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cū',
      meaning_vi = 'thô, to, dày, vụng về',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '粗';
  END IF;

  -- [村] (cūn) - thôn, làng, xã [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '村'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('村', 'cūn', 'thôn, làng, xã', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cūn',
      meaning_vi = 'thôn, làng, xã',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '村';
  END IF;

  -- [错过] (cuòguò) - bỏ lỡ, để lỡ [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '错过'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('错过', 'cuòguò', 'bỏ lỡ, để lỡ', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'cuòguò',
      meaning_vi = 'bỏ lỡ, để lỡ',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '错过';
  END IF;

  -- [答应] (dāying) - đồng ý, hứa; trả lời [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '答应'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('答应', 'dāying', 'đồng ý, hứa; trả lời', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dāying',
      meaning_vi = 'đồng ý, hứa; trả lời',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '答应';
  END IF;

  -- [答] (dá) - trả lời, hồi đáp [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '答'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('答', 'dá', 'trả lời, hồi đáp', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dá',
      meaning_vi = 'trả lời, hồi đáp',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '答';
  END IF;

  -- [达到] (dádào) - đạt được, đạt tới [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '达到'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('达到', 'dádào', 'đạt được, đạt tới', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dádào',
      meaning_vi = 'đạt được, đạt tới',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '达到';
  END IF;

  -- [打败] (dǎbài) - đánh bại [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打败'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('打败', 'dǎbài', 'đánh bại', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dǎbài',
      meaning_vi = 'đánh bại',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '打败';
  END IF;

  -- [打工] (dǎgōng) - làm thuê, làm thêm [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打工'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('打工', 'dǎgōng', 'làm thuê, làm thêm', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dǎgōng',
      meaning_vi = 'làm thuê, làm thêm',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '打工';
  END IF;

  -- [打印机] (dǎyìnjī) - máy in [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打印机'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('打印机', 'dǎyìnjī', 'máy in', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dǎyìnjī',
      meaning_vi = 'máy in',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '打印机';
  END IF;

  -- [大巴] (dàbā) - xe khách cỡ lớn, xe buýt du lịch [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大巴'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('大巴', 'dàbā', 'xe khách cỡ lớn, xe buýt du lịch', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dàbā',
      meaning_vi = 'xe khách cỡ lớn, xe buýt du lịch',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '大巴';
  END IF;

  -- [大大] (dàdà) - rất lớn, vô cùng, hết sức [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大大'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('大大', 'dàdà', 'rất lớn, vô cùng, hết sức', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dàdà',
      meaning_vi = 'rất lớn, vô cùng, hết sức',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '大大';
  END IF;

  -- [大量] (dàliàng) - số lượng lớn, nhiều [Tính từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大量'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('大量', 'dàliàng', 'số lượng lớn, nhiều', 'Tính từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dàliàng',
      meaning_vi = 'số lượng lớn, nhiều',
      word_type = 'Tính từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '大量';
  END IF;

  -- [大赛] (dàsài) - cuộc thi lớn, giải đấu lớn [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大赛'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('大赛', 'dàsài', 'cuộc thi lớn, giải đấu lớn', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dàsài',
      meaning_vi = 'cuộc thi lớn, giải đấu lớn',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '大赛';
  END IF;

  -- [大厅] (dàtīng) - đại sảnh [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大厅'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('大厅', 'dàtīng', 'đại sảnh', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dàtīng',
      meaning_vi = 'đại sảnh',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '大厅';
  END IF;

  -- [大自然] (dàzìrán) - mẹ thiên nhiên, tự nhiên [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大自然'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('大自然', 'dàzìrán', 'mẹ thiên nhiên, tự nhiên', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dàzìrán',
      meaning_vi = 'mẹ thiên nhiên, tự nhiên',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '大自然';
  END IF;

  -- [待] (dāi) - ở lại, lưu lại [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '待'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('待', 'dāi', 'ở lại, lưu lại', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dāi',
      meaning_vi = 'ở lại, lưu lại',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '待';
  END IF;

  -- [袋子] (dàizi) - túi, bao tải [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '袋子'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('袋子', 'dàizi', 'túi, bao tải', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dàizi',
      meaning_vi = 'túi, bao tải',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '袋子';
  END IF;

  -- [单位] (dānwèi) - cơ quan, đơn vị [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '单位'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('单位', 'dānwèi', 'cơ quan, đơn vị', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dānwèi',
      meaning_vi = 'cơ quan, đơn vị',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '单位';
  END IF;

  -- [道] (dào) - đường, đạo; món ăn, bài toán [Danh từ / Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '道'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('道', 'dào', 'đường, đạo; món ăn, bài toán', 'Danh từ / Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dào',
      meaning_vi = 'đường, đạo; món ăn, bài toán',
      word_type = 'Danh từ / Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '道';
  END IF;

  -- [到来] (dàolái) - đến, tới [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '到来'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('到来', 'dàolái', 'đến, tới', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dàolái',
      meaning_vi = 'đến, tới',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '到来';
  END IF;

  -- [道路] (dàolù) - con đường, tuyến đường [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '道路'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('道路', 'dàolù', 'con đường, tuyến đường', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dàolù',
      meaning_vi = 'con đường, tuyến đường',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '道路';
  END IF;

  -- [登机] (dēngjī) - lên máy bay [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '登机'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('登机', 'dēngjī', 'lên máy bay', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dēngjī',
      meaning_vi = 'lên máy bay',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '登机';
  END IF;

  -- [等到] (děngdào) - chờ đến khi, đợi tới lúc [Giới từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '等到'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('等到', 'děngdào', 'chờ đến khi, đợi tới lúc', 'Giới từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'děngdào',
      meaning_vi = 'chờ đến khi, đợi tới lúc',
      word_type = 'Giới từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '等到';
  END IF;

  -- [低价] (dījià) - giá thấp, giá rẻ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '低价'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('低价', 'dījià', 'giá thấp, giá rẻ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dījià',
      meaning_vi = 'giá thấp, giá rẻ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '低价';
  END IF;

  -- [低温] (dīwēn) - nhiệt độ thấp [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '低温'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('低温', 'dīwēn', 'nhiệt độ thấp', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dīwēn',
      meaning_vi = 'nhiệt độ thấp',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '低温';
  END IF;

  -- [低于] (dīyú) - thấp hơn [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '低于'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('低于', 'dīyú', 'thấp hơn', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dīyú',
      meaning_vi = 'thấp hơn',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '低于';
  END IF;

  -- [底下] (dǐxia) - dưới, bên dưới [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '底下'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('底下', 'dǐxia', 'dưới, bên dưới', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dǐxia',
      meaning_vi = 'dưới, bên dưới',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '底下';
  END IF;

  -- [点名] (diǎnmíng) - điểm danh [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '点名'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('点名', 'diǎnmíng', 'điểm danh', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'diǎnmíng',
      meaning_vi = 'điểm danh',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '点名';
  END IF;

  -- [点头] (diǎntóu) - gật đầu [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '点头'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('点头', 'diǎntóu', 'gật đầu', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'diǎntóu',
      meaning_vi = 'gật đầu',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '点头';
  END IF;

  -- [电动车] (diàndòngchē) - xe đạp điện, xe máy điện [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '电动车'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('电动车', 'diàndòngchē', 'xe đạp điện, xe máy điện', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'diàndòngchē',
      meaning_vi = 'xe đạp điện, xe máy điện',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '电动车';
  END IF;

  -- [电视剧] (diànshìjù) - phim truyền hình [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '电视剧'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('电视剧', 'diànshìjù', 'phim truyền hình', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'diànshìjù',
      meaning_vi = 'phim truyền hình',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '电视剧';
  END IF;

  -- [订] (dìng) - đặt trước (phòng, vé) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '订'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('订', 'dìng', 'đặt trước (phòng, vé)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dìng',
      meaning_vi = 'đặt trước (phòng, vé)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '订';
  END IF;

  -- [定] (dìng) - quy định, xác định, quyết định [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '定'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('定', 'dìng', 'quy định, xác định, quyết định', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dìng',
      meaning_vi = 'quy định, xác định, quyết định',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '定';
  END IF;

  -- [东部] (dōngbù) - miền đông, phía đông [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '东部'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('东部', 'dōngbù', 'miền đông, phía đông', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dōngbù',
      meaning_vi = 'miền đông, phía đông',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '东部';
  END IF;

  -- [动车] (dòngchē) - tàu cao tốc (động cơ phân tán) [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '动车'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('动车', 'dòngchē', 'tàu cao tốc (động cơ phân tán)', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dòngchē',
      meaning_vi = 'tàu cao tốc (động cơ phân tán)',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '动车';
  END IF;

  -- [读者] (dúzhě) - độc giả, bạn đọc [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '读者'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('读者', 'dúzhě', 'độc giả, bạn đọc', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dúzhě',
      meaning_vi = 'độc giả, bạn đọc',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '读者';
  END IF;

  -- [度假] (dùjià) - đi nghỉ mát, nghỉ lễ [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '度假'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('度假', 'dùjià', 'đi nghỉ mát, nghỉ lễ', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dùjià',
      meaning_vi = 'đi nghỉ mát, nghỉ lễ',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '度假';
  END IF;

  -- [队] (duì) - đội, hàng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '队'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('队', 'duì', 'đội, hàng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'duì',
      meaning_vi = 'đội, hàng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '队';
  END IF;

  -- [对方] (duìfāng) - đối phương, bên kia [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '对方'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('对方', 'duìfāng', 'đối phương, bên kia', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'duìfāng',
      meaning_vi = 'đối phương, bên kia',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '对方';
  END IF;

  -- [队员] (duìyuán) - đội viên, thành viên đội [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '队员'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('队员', 'duìyuán', 'đội viên, thành viên đội', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'duìyuán',
      meaning_vi = 'đội viên, thành viên đội',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '队员';
  END IF;

  -- [队长] (duìzhǎng) - đội trưởng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '队长'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('队长', 'duìzhǎng', 'đội trưởng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'duìzhǎng',
      meaning_vi = 'đội trưởng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '队长';
  END IF;

  -- [顿] (dùn) - bữa (ăn); trận (mắng) [Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '顿'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('顿', 'dùn', 'bữa (ăn); trận (mắng)', 'Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'dùn',
      meaning_vi = 'bữa (ăn); trận (mắng)',
      word_type = 'Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '顿';
  END IF;

  -- [多数] (duōshù) - đa số, phần lớn [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '多数'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('多数', 'duōshù', 'đa số, phần lớn', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'duōshù',
      meaning_vi = 'đa số, phần lớn',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '多数';
  END IF;

  -- [多样] (duōyàng) - đa dạng, nhiều kiểu [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '多样'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('多样', 'duōyàng', 'đa dạng, nhiều kiểu', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'duōyàng',
      meaning_vi = 'đa dạng, nhiều kiểu',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '多样';
  END IF;

  -- [发出] (fāchū) - phát ra, gửi ra [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '发出'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('发出', 'fāchū', 'phát ra, gửi ra', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fāchū',
      meaning_vi = 'phát ra, gửi ra',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '发出';
  END IF;

  -- [发送] (fāsòng) - gửi đi, truyền tải [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '发送'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('发送', 'fāsòng', 'gửi đi, truyền tải', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fāsòng',
      meaning_vi = 'gửi đi, truyền tải',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '发送';
  END IF;

  -- [法] (fǎ) - pháp luật; phương pháp [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '法'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('法', 'fǎ', 'pháp luật; phương pháp', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fǎ',
      meaning_vi = 'pháp luật; phương pháp',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '法';
  END IF;

  -- [烦] (fán) - phiền muộn, chán ngấy; làm phiền [Tính từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '烦'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('烦', 'fán', 'phiền muộn, chán ngấy; làm phiền', 'Tính từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fán',
      meaning_vi = 'phiền muộn, chán ngấy; làm phiền',
      word_type = 'Tính từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '烦';
  END IF;

  -- [方式] (fāngshì) - phương thức, cách thức [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '方式'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('方式', 'fāngshì', 'phương thức, cách thức', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fāngshì',
      meaning_vi = 'phương thức, cách thức',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '方式';
  END IF;

  -- [房租] (fángzū) - tiền thuê nhà [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '房租'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('房租', 'fángzū', 'tiền thuê nhà', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fángzū',
      meaning_vi = 'tiền thuê nhà',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '房租';
  END IF;

  -- [费] (fèi) - chi phí; tiêu tốn [Danh từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '费'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('费', 'fèi', 'chi phí; tiêu tốn', 'Danh từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fèi',
      meaning_vi = 'chi phí; tiêu tốn',
      word_type = 'Danh từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '费';
  END IF;

  -- [费用] (fèiyong) - chi phí, kinh phí [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '费用'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('费用', 'fèiyong', 'chi phí, kinh phí', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fèiyong',
      meaning_vi = 'chi phí, kinh phí',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '费用';
  END IF;

  -- [分数] (fēnshù) - điểm số; phân số [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '分数'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('分数', 'fēnshù', 'điểm số; phân số', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fēnshù',
      meaning_vi = 'điểm số; phân số',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '分数';
  END IF;

  -- [分为] (fēnwéi) - chia thành, chia làm [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '分为'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('分为', 'fēnwéi', 'chia thành, chia làm', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fēnwéi',
      meaning_vi = 'chia thành, chia làm',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '分为';
  END IF;

  -- [风景] (fēngjǐng) - phong cảnh, cảnh đẹp [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '风景'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('风景', 'fēngjǐng', 'phong cảnh, cảnh đẹp', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fēngjǐng',
      meaning_vi = 'phong cảnh, cảnh đẹp',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '风景';
  END IF;

  -- [幅] (fú) - bức (tranh), tấm (vải) [Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '幅'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('幅', 'fú', 'bức (tranh), tấm (vải)', 'Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fú',
      meaning_vi = 'bức (tranh), tấm (vải)',
      word_type = 'Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '幅';
  END IF;

  -- [付] (fù) - trả tiền, thanh toán [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '付'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('付', 'fù', 'trả tiền, thanh toán', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fù',
      meaning_vi = 'trả tiền, thanh toán',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '付';
  END IF;

  -- [父母] (fùmǔ) - cha mẹ, phụ mẫu [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '父母'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('父母', 'fùmǔ', 'cha mẹ, phụ mẫu', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fùmǔ',
      meaning_vi = 'cha mẹ, phụ mẫu',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '父母';
  END IF;

  -- [父女] (fùnǚ) - cha và con gái [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '父女'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('父女', 'fùnǚ', 'cha và con gái', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fùnǚ',
      meaning_vi = 'cha và con gái',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '父女';
  END IF;

  -- [负责人] (fùzérén) - người phụ trách [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '负责人'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('负责人', 'fùzérén', 'người phụ trách', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fùzérén',
      meaning_vi = 'người phụ trách',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '负责人';
  END IF;

  -- [父子] (fùzǐ) - cha và con trai [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '父子'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('父子', 'fùzǐ', 'cha và con trai', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'fùzǐ',
      meaning_vi = 'cha và con trai',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '父子';
  END IF;

  -- [改] (gǎi) - sửa đổi, cải chính [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '改'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('改', 'gǎi', 'sửa đổi, cải chính', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gǎi',
      meaning_vi = 'sửa đổi, cải chính',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '改';
  END IF;

  -- [感] (gǎn) - cảm thấy; cảm giác [Hậu tố / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('感', 'gǎn', 'cảm thấy; cảm giác', 'Hậu tố / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gǎn',
      meaning_vi = 'cảm thấy; cảm giác',
      word_type = 'Hậu tố / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '感';
  END IF;

  -- [赶紧] (gǎnjǐn) - nhanh chóng, khẩn trương [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶紧'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('赶紧', 'gǎnjǐn', 'nhanh chóng, khẩn trương', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gǎnjǐn',
      meaning_vi = 'nhanh chóng, khẩn trương',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶紧';
  END IF;

  -- [赶快] (gǎnkuài) - mau chóng, nhanh lên [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶快'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('赶快', 'gǎnkuài', 'mau chóng, nhanh lên', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gǎnkuài',
      meaning_vi = 'mau chóng, nhanh lên',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶快';
  END IF;

  -- [感人] (gǎnrén) - cảm động, lay động lòng người [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感人'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('感人', 'gǎnrén', 'cảm động, lay động lòng người', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gǎnrén',
      meaning_vi = 'cảm động, lay động lòng người',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '感人';
  END IF;

  -- [赶上] (gǎnshàng) - đuổi kịp, bắt kịp; gặp dịp [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶上'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('赶上', 'gǎnshàng', 'đuổi kịp, bắt kịp; gặp dịp', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gǎnshàng',
      meaning_vi = 'đuổi kịp, bắt kịp; gặp dịp',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶上';
  END IF;

  -- [感受] (gǎnshòu) - cảm nhận, trải nghiệm [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感受'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('感受', 'gǎnshòu', 'cảm nhận, trải nghiệm', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gǎnshòu',
      meaning_vi = 'cảm nhận, trải nghiệm',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '感受';
  END IF;

  -- [干活儿] (gànhuór) - làm việc, làm lụng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '干活儿'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('干活儿', 'gànhuór', 'làm việc, làm lụng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gànhuór',
      meaning_vi = 'làm việc, làm lụng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '干活儿';
  END IF;

  -- [钢琴] (gāngqín) - đàn piano, dương cầm [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '钢琴'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('钢琴', 'gāngqín', 'đàn piano, dương cầm', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gāngqín',
      meaning_vi = 'đàn piano, dương cầm',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '钢琴';
  END IF;

  -- [高价] (gāojià) - giá cao [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高价'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('高价', 'gāojià', 'giá cao', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gāojià',
      meaning_vi = 'giá cao',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '高价';
  END IF;

  -- [高考] (gāokǎo) - kỳ thi đại học [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高考'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('高考', 'gāokǎo', 'kỳ thi đại học', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gāokǎo',
      meaning_vi = 'kỳ thi đại học',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '高考';
  END IF;

  -- [高速] (gāosù) - tốc độ cao, cao tốc [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高速'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('高速', 'gāosù', 'tốc độ cao, cao tốc', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gāosù',
      meaning_vi = 'tốc độ cao, cao tốc',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '高速';
  END IF;

  -- [高温] (gāowēn) - nhiệt độ cao [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高温'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('高温', 'gāowēn', 'nhiệt độ cao', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gāowēn',
      meaning_vi = 'nhiệt độ cao',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '高温';
  END IF;

  -- [高于] (gāoyú) - cao hơn [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高于'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('高于', 'gāoyú', 'cao hơn', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gāoyú',
      meaning_vi = 'cao hơn',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '高于';
  END IF;

  -- [歌声] (gēshēng) - tiếng hát [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '歌声'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('歌声', 'gēshēng', 'tiếng hát', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gēshēng',
      meaning_vi = 'tiếng hát',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '歌声';
  END IF;

  -- [歌手] (gēshǒu) - ca sĩ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '歌手'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('歌手', 'gēshǒu', 'ca sĩ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gēshǒu',
      meaning_vi = 'ca sĩ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '歌手';
  END IF;

  -- [各地] (gèdì) - các nơi, khắp nơi [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '各地'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('各地', 'gèdì', 'các nơi, khắp nơi', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gèdì',
      meaning_vi = 'các nơi, khắp nơi',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '各地';
  END IF;

  -- [各个] (gègè) - mỗi một, từng cái [Đại từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '各个'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('各个', 'gègè', 'mỗi một, từng cái', 'Đại từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gègè',
      meaning_vi = 'mỗi một, từng cái',
      word_type = 'Đại từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '各个';
  END IF;

  -- [各位] (gèwèi) - quý vị, các vị [Đại từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '各位'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('各位', 'gèwèi', 'quý vị, các vị', 'Đại từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gèwèi',
      meaning_vi = 'quý vị, các vị',
      word_type = 'Đại từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '各位';
  END IF;

  -- [各种] (gèzhǒng) - các loại, đủ loại [Đại từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '各种'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('各种', 'gèzhǒng', 'các loại, đủ loại', 'Đại từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gèzhǒng',
      meaning_vi = 'các loại, đủ loại',
      word_type = 'Đại từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '各种';
  END IF;

  -- [更加] (gèngjiā) - càng thêm, hơn nữa [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '更加'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('更加', 'gèngjiā', 'càng thêm, hơn nữa', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gèngjiā',
      meaning_vi = 'càng thêm, hơn nữa',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '更加';
  END IF;

  -- [工厂] (gōngchǎng) - nhà máy [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '工厂'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('工厂', 'gōngchǎng', 'nhà máy', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gōngchǎng',
      meaning_vi = 'nhà máy',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '工厂';
  END IF;

  -- [公共] (gōnggòng) - công cộng, chung [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '公共'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('公共', 'gōnggòng', 'công cộng, chung', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gōnggòng',
      meaning_vi = 'công cộng, chung',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '公共';
  END IF;

  -- [功课] (gōngkè) - bài vở, môn học [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '功课'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('功课', 'gōngkè', 'bài vở, môn học', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gōngkè',
      meaning_vi = 'bài vở, môn học',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '功课';
  END IF;

  -- [公路] (gōnglù) - đường quốc lộ, đường cái [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '公路'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('公路', 'gōnglù', 'đường quốc lộ, đường cái', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gōnglù',
      meaning_vi = 'đường quốc lộ, đường cái',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '公路';
  END IF;

  -- [工人] (gōngrén) - công nhân [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '工人'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('工人', 'gōngrén', 'công nhân', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gōngrén',
      meaning_vi = 'công nhân',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '工人';
  END IF;

  -- [共] (gòng) - tổng cộng, cùng nhau [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '共'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('共', 'gòng', 'tổng cộng, cùng nhau', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gòng',
      meaning_vi = 'tổng cộng, cùng nhau',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '共';
  END IF;

  -- [购买] (gòumǎi) - mua sắm, mua [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '购买'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('购买', 'gòumǎi', 'mua sắm, mua', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gòumǎi',
      meaning_vi = 'mua sắm, mua',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '购买';
  END IF;

  -- [姑娘] (gūniang) - cô gái, thiếu nữ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '姑娘'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('姑娘', 'gūniang', 'cô gái, thiếu nữ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'gūniang',
      meaning_vi = 'cô gái, thiếu nữ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '姑娘';
  END IF;

  -- [观看] (guānkàn) - xem, theo dõi [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '观看'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('观看', 'guānkàn', 'xem, theo dõi', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'guānkàn',
      meaning_vi = 'xem, theo dõi',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '观看';
  END IF;

  -- [管] (guǎn) - quản lý, trông nom, phụ trách [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '管'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('管', 'guǎn', 'quản lý, trông nom, phụ trách', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'guǎn',
      meaning_vi = 'quản lý, trông nom, phụ trách',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '管';
  END IF;

  -- [寒冷] (hánlěng) - lạnh giá, giá rét [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '寒冷'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('寒冷', 'hánlěng', 'lạnh giá, giá rét', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'hánlěng',
      meaning_vi = 'lạnh giá, giá rét',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '寒冷';
  END IF;

  -- [喊] (hǎn) - kêu, la, hét [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '喊'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('喊', 'hǎn', 'kêu, la, hét', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'hǎn',
      meaning_vi = 'kêu, la, hét',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '喊';
  END IF;

  -- [好好] (hǎohǎo) - cẩn thận, kỹ càng, chu đáo [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '好好'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('好好', 'hǎohǎo', 'cẩn thận, kỹ càng, chu đáo', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'hǎohǎo',
      meaning_vi = 'cẩn thận, kỹ càng, chu đáo',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '好好';
  END IF;

  -- [好笑] (hǎoxiào) - buồn cười, nực cười [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '好笑'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('好笑', 'hǎoxiào', 'buồn cười, nực cười', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'hǎoxiào',
      meaning_vi = 'buồn cười, nực cười',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '好笑';
  END IF;

  -- [红包] (hóngbāo) - bao lì xì, tiền mừng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '红包'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('红包', 'hóngbāo', 'bao lì xì, tiền mừng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'hóngbāo',
      meaning_vi = 'bao lì xì, tiền mừng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '红包';
  END IF;

  -- [忽然] (hūrán) - đột nhiên, bất thình lình [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '忽然'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('忽然', 'hūrán', 'đột nhiên, bất thình lình', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'hūrán',
      meaning_vi = 'đột nhiên, bất thình lình',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '忽然';
  END IF;

  -- [话剧] (huàjù) - kịch nói [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '话剧'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('话剧', 'huàjù', 'kịch nói', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huàjù',
      meaning_vi = 'kịch nói',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '话剧';
  END IF;

  -- [坏处] (huàichù) - điểm xấu, tác hại [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '坏处'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('坏处', 'huàichù', 'điểm xấu, tác hại', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huàichù',
      meaning_vi = 'điểm xấu, tác hại',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '坏处';
  END IF;

  -- [环保] (huánbǎo) - bảo vệ môi trường, thân thiện môi trường [Danh từ / Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '环保'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('环保', 'huánbǎo', 'bảo vệ môi trường, thân thiện môi trường', 'Danh từ / Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huánbǎo',
      meaning_vi = 'bảo vệ môi trường, thân thiện môi trường',
      word_type = 'Danh từ / Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '环保';
  END IF;

  -- [换乘] (huànchéng) - đổi chuyến (xe/tàu) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '换乘'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('换乘', 'huànchéng', 'đổi chuyến (xe/tàu)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huànchéng',
      meaning_vi = 'đổi chuyến (xe/tàu)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '换乘';
  END IF;

  -- [回复] (huífù) - hồi đáp, trả lời [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '回复'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('回复', 'huífù', 'hồi đáp, trả lời', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huífù',
      meaning_vi = 'hồi đáp, trả lời',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '回复';
  END IF;

  -- [回信] (huíxìn) - hồi âm, viết thư trả lời; thư hồi đáp [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '回信'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('回信', 'huíxìn', 'hồi âm, viết thư trả lời; thư hồi đáp', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huíxìn',
      meaning_vi = 'hồi âm, viết thư trả lời; thư hồi đáp',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '回信';
  END IF;

  -- [会员] (huìyuán) - hội viên, thành viên [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '会员'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('会员', 'huìyuán', 'hội viên, thành viên', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huìyuán',
      meaning_vi = 'hội viên, thành viên',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '会员';
  END IF;

  -- [活] (huó) - sống; linh hoạt; công việc [Động từ / Tính từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '活'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('活', 'huó', 'sống; linh hoạt; công việc', 'Động từ / Tính từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huó',
      meaning_vi = 'sống; linh hoạt; công việc',
      word_type = 'Động từ / Tính từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '活';
  END IF;

  -- [货] (huò) - hàng hóa [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '货'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('货', 'huò', 'hàng hóa', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huò',
      meaning_vi = 'hàng hóa',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '货';
  END IF;

  -- [获奖] (huòjiǎng) - đoạt giải, nhận giải thưởng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '获奖'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('获奖', 'huòjiǎng', 'đoạt giải, nhận giải thưởng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huòjiǎng',
      meaning_vi = 'đoạt giải, nhận giải thưởng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '获奖';
  END IF;

  -- [获取] (huòqǔ) - thu được, giành được, lấy được [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '获取'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('获取', 'huòqǔ', 'thu được, giành được, lấy được', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'huòqǔ',
      meaning_vi = 'thu được, giành được, lấy được',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '获取';
  END IF;

  -- [基本] (jīběn) - cơ bản; về cơ bản [Tính từ / Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '基本'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('基本', 'jīběn', 'cơ bản; về cơ bản', 'Tính từ / Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jīběn',
      meaning_vi = 'cơ bản; về cơ bản',
      word_type = 'Tính từ / Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '基本';
  END IF;

  -- [基本上] (jīběnshàng) - về cơ bản [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '基本上'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('基本上', 'jīběnshàng', 'về cơ bản', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jīběnshàng',
      meaning_vi = 'về cơ bản',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '基本上';
  END IF;

  -- [既] (jì) - đã; vừa... lại... [Liên từ / Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '既'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('既', 'jì', 'đã; vừa... lại...', 'Liên từ / Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jì',
      meaning_vi = 'đã; vừa... lại...',
      word_type = 'Liên từ / Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '既';
  END IF;

  -- [加快] (jiākuài) - đẩy nhanh, tăng tốc [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加快'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('加快', 'jiākuài', 'đẩy nhanh, tăng tốc', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiākuài',
      meaning_vi = 'đẩy nhanh, tăng tốc',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '加快';
  END IF;

  -- [加强] (jiāqiáng) - tăng cường, củng cố [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加强'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('加强', 'jiāqiáng', 'tăng cường, củng cố', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiāqiáng',
      meaning_vi = 'tăng cường, củng cố',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '加强';
  END IF;

  -- [加入] (jiārù) - gia nhập, tham gia, thêm vào [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加入'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('加入', 'jiārù', 'gia nhập, tham gia, thêm vào', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiārù',
      meaning_vi = 'gia nhập, tham gia, thêm vào',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '加入';
  END IF;

  -- [加上] (jiāshàng) - cộng thêm, thêm vào đó [Liên từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加上'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('加上', 'jiāshàng', 'cộng thêm, thêm vào đó', 'Liên từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiāshàng',
      meaning_vi = 'cộng thêm, thêm vào đó',
      word_type = 'Liên từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '加上';
  END IF;

  -- [家庭] (jiātíng) - gia đình [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '家庭'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('家庭', 'jiātíng', 'gia đình', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiātíng',
      meaning_vi = 'gia đình',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '家庭';
  END IF;

  -- [家乡] (jiāxiāng) - quê hương, quê nhà [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '家乡'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('家乡', 'jiāxiāng', 'quê hương, quê nhà', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiāxiāng',
      meaning_vi = 'quê hương, quê nhà',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '家乡';
  END IF;

  -- [加油] (jiāyóu) - đổ xăng; cố lên [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加油'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('加油', 'jiāyóu', 'đổ xăng; cố lên', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiāyóu',
      meaning_vi = 'đổ xăng; cố lên',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '加油';
  END IF;

  -- [家长] (jiāzhǎng) - phụ huynh, gia trưởng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '家长'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('家长', 'jiāzhǎng', 'phụ huynh, gia trưởng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiāzhǎng',
      meaning_vi = 'phụ huynh, gia trưởng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '家长';
  END IF;

  -- [价钱] (jiàqián) - giá cả, giá tiền [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '价钱'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('价钱', 'jiàqián', 'giá cả, giá tiền', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiàqián',
      meaning_vi = 'giá cả, giá tiền',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '价钱';
  END IF;

  -- [假日] (jiàrì) - ngày nghỉ, kỳ nghỉ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '假日'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('假日', 'jiàrì', 'ngày nghỉ, kỳ nghỉ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiàrì',
      meaning_vi = 'ngày nghỉ, kỳ nghỉ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '假日';
  END IF;

  -- [减] (jiǎn) - giảm, bớt; trừ (toán) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '减'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('减', 'jiǎn', 'giảm, bớt; trừ (toán)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiǎn',
      meaning_vi = 'giảm, bớt; trừ (toán)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '减';
  END IF;

  -- [减轻] (jiǎnqīng) - giảm nhẹ, làm nhẹ bớt [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '减轻'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('减轻', 'jiǎnqīng', 'giảm nhẹ, làm nhẹ bớt', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiǎnqīng',
      meaning_vi = 'giảm nhẹ, làm nhẹ bớt',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '减轻';
  END IF;

  -- [健身] (jiànshēn) - tập thể hình, rèn luyện sức khỏe [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '健身'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('健身', 'jiànshēn', 'tập thể hình, rèn luyện sức khỏe', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiànshēn',
      meaning_vi = 'tập thể hình, rèn luyện sức khỏe',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '健身';
  END IF;

  -- [健身房] (jiànshēnfáng) - phòng tập thể hình, phòng gym [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '健身房'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('健身房', 'jiànshēnfáng', 'phòng tập thể hình, phòng gym', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiànshēnfáng',
      meaning_vi = 'phòng tập thể hình, phòng gym',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '健身房';
  END IF;

  -- [江] (jiāng) - sông (sông lớn) [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '江'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('江', 'jiāng', 'sông (sông lớn)', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiāng',
      meaning_vi = 'sông (sông lớn)',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '江';
  END IF;

  -- [将] (jiāng) - sẽ, sắp; đem, lấy (giống 把) [Phó từ / Giới từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '将'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('将', 'jiāng', 'sẽ, sắp; đem, lấy (giống 把)', 'Phó từ / Giới từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiāng',
      meaning_vi = 'sẽ, sắp; đem, lấy (giống 把)',
      word_type = 'Phó từ / Giới từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '将';
  END IF;

  -- [将要] (jiāngyào) - sắp sửa, sẽ [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '将要'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('将要', 'jiāngyào', 'sắp sửa, sẽ', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiāngyào',
      meaning_vi = 'sắp sửa, sẽ',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '将要';
  END IF;

  -- [奖] (jiǎng) - giải thưởng, phần thưởng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '奖'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('奖', 'jiǎng', 'giải thưởng, phần thưởng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiǎng',
      meaning_vi = 'giải thưởng, phần thưởng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '奖';
  END IF;

  -- [奖学金] (jiǎngxuéjīn) - học bổng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '奖学金'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('奖学金', 'jiǎngxuéjīn', 'học bổng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiǎngxuéjīn',
      meaning_vi = 'học bổng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '奖学金';
  END IF;

  -- [降] (jiàng) - hạ xuống, rơi xuống, giảm [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '降'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('降', 'jiàng', 'hạ xuống, rơi xuống, giảm', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiàng',
      meaning_vi = 'hạ xuống, rơi xuống, giảm',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '降';
  END IF;

  -- [降价] (jiàngjià) - giảm giá, hạ giá [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '降价'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('降价', 'jiàngjià', 'giảm giá, hạ giá', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiàngjià',
      meaning_vi = 'giảm giá, hạ giá',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '降价';
  END IF;

  -- [降温] (jiàngwēn) - hạ nhiệt, nhiệt độ giảm [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '降温'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('降温', 'jiàngwēn', 'hạ nhiệt, nhiệt độ giảm', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiàngwēn',
      meaning_vi = 'hạ nhiệt, nhiệt độ giảm',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '降温';
  END IF;

  -- [交警] (jiāojǐng) - cảnh sát giao thông [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '交警'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('交警', 'jiāojǐng', 'cảnh sát giao thông', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiāojǐng',
      meaning_vi = 'cảnh sát giao thông',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '交警';
  END IF;

  -- [教练] (jiàoliàn) - huấn luyện viên [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '教练'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('教练', 'jiàoliàn', 'huấn luyện viên', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiàoliàn',
      meaning_vi = 'huấn luyện viên',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '教练';
  END IF;

  -- [教师] (jiàoshī) - giáo viên, nhà giáo [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '教师'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('教师', 'jiàoshī', 'giáo viên, nhà giáo', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiàoshī',
      meaning_vi = 'giáo viên, nhà giáo',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '教师';
  END IF;

  -- [教学] (jiàoxué) - giảng dạy, dạy học [Danh từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '教学'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('教学', 'jiàoxué', 'giảng dạy, dạy học', 'Danh từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiàoxué',
      meaning_vi = 'giảng dạy, dạy học',
      word_type = 'Danh từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '教学';
  END IF;

  -- [叫作] (jiàozuò) - gọi là, đặt tên là [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '叫作'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('叫作', 'jiàozuò', 'gọi là, đặt tên là', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiàozuò',
      meaning_vi = 'gọi là, đặt tên là',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '叫作';
  END IF;

  -- [节假日] (jiéjiàrì) - ngày lễ tết, ngày nghỉ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '节假日'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('节假日', 'jiéjiàrì', 'ngày lễ tết, ngày nghỉ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiéjiàrì',
      meaning_vi = 'ngày lễ tết, ngày nghỉ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '节假日';
  END IF;

  -- [结账] (jiézhàng) - thanh toán, tính tiền [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '结账'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('结账', 'jiézhàng', 'thanh toán, tính tiền', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiézhàng',
      meaning_vi = 'thanh toán, tính tiền',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '结账';
  END IF;

  -- [今后] (jīnhòu) - sau này, từ nay về sau [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '今后'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('今后', 'jīnhòu', 'sau này, từ nay về sau', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jīnhòu',
      meaning_vi = 'sau này, từ nay về sau',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '今后';
  END IF;

  -- [仅] (jǐn) - chỉ, vẹn vẹn [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '仅'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('仅', 'jǐn', 'chỉ, vẹn vẹn', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jǐn',
      meaning_vi = 'chỉ, vẹn vẹn',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '仅';
  END IF;

  -- [仅仅] (jǐnjǐn) - chỉ, vỏn vẹn [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '仅仅'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('仅仅', 'jǐnjǐn', 'chỉ, vỏn vẹn', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jǐnjǐn',
      meaning_vi = 'chỉ, vỏn vẹn',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '仅仅';
  END IF;

  -- [进入] (jìnrù) - bước vào, đi vào [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '进入'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('进入', 'jìnrù', 'bước vào, đi vào', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jìnrù',
      meaning_vi = 'bước vào, đi vào',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '进入';
  END IF;

  -- [景点] (jǐngdiǎn) - điểm tham quan, danh lam thắng cảnh [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '景点'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('景点', 'jǐngdiǎn', 'điểm tham quan, danh lam thắng cảnh', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jǐngdiǎn',
      meaning_vi = 'điểm tham quan, danh lam thắng cảnh',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '景点';
  END IF;

  -- [景区] (jǐngqū) - khu danh thắng, khu du lịch [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '景区'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('景区', 'jǐngqū', 'khu danh thắng, khu du lịch', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jǐngqū',
      meaning_vi = 'khu danh thắng, khu du lịch',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '景区';
  END IF;

  -- [就是] (jiùshì) - chính là; dù là; chỉ là [Phó từ / Liên từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '就是'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('就是', 'jiùshì', 'chính là; dù là; chỉ là', 'Phó từ / Liên từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jiùshì',
      meaning_vi = 'chính là; dù là; chỉ là',
      word_type = 'Phó từ / Liên từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '就是';
  END IF;

  -- [举例] (jǔlì) - lấy ví dụ, nêu ví dụ [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '举例'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('举例', 'jǔlì', 'lấy ví dụ, nêu ví dụ', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jǔlì',
      meaning_vi = 'lấy ví dụ, nêu ví dụ',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '举例';
  END IF;

  -- [聚] (jù) - tụ tập, sum họp [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '聚'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('聚', 'jù', 'tụ tập, sum họp', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jù',
      meaning_vi = 'tụ tập, sum họp',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '聚';
  END IF;

  -- [聚餐] (jùcān) - liên hoan ăn uống, tụ tập ăn cơm [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '聚餐'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('聚餐', 'jùcān', 'liên hoan ăn uống, tụ tập ăn cơm', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jùcān',
      meaning_vi = 'liên hoan ăn uống, tụ tập ăn cơm',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '聚餐';
  END IF;

  -- [剧院] (jùyuàn) - nhà hát, rạp hát [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '剧院'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('剧院', 'jùyuàn', 'nhà hát, rạp hát', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'jùyuàn',
      meaning_vi = 'nhà hát, rạp hát',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '剧院';
  END IF;

  -- [烤] (kǎo) - nướng, quay [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '烤'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('烤', 'kǎo', 'nướng, quay', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kǎo',
      meaning_vi = 'nướng, quay',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '烤';
  END IF;

  -- [考生] (kǎoshēng) - thí sinh [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '考生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('考生', 'kǎoshēng', 'thí sinh', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kǎoshēng',
      meaning_vi = 'thí sinh',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '考生';
  END IF;

  -- [科技] (kējì) - khoa học công nghệ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '科技'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('科技', 'kējì', 'khoa học công nghệ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kējì',
      meaning_vi = 'khoa học công nghệ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '科技';
  END IF;

  -- [咳] (ké) - ho [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '咳'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('咳', 'ké', 'ho', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'ké',
      meaning_vi = 'ho',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '咳';
  END IF;

  -- [克] (kè) - gam (đơn vị đo khối lượng) [Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '克'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('克', 'kè', 'gam (đơn vị đo khối lượng)', 'Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kè',
      meaning_vi = 'gam (đơn vị đo khối lượng)',
      word_type = 'Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '克';
  END IF;

  -- [课程] (kèchéng) - khóa học, chương trình học [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '课程'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('课程', 'kèchéng', 'khóa học, chương trình học', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kèchéng',
      meaning_vi = 'khóa học, chương trình học',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '课程';
  END IF;

  -- [客气] (kèqi) - khách sáo, lịch sự [Tính từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '客气'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('客气', 'kèqi', 'khách sáo, lịch sự', 'Tính từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kèqi',
      meaning_vi = 'khách sáo, lịch sự',
      word_type = 'Tính từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '客气';
  END IF;

  -- [课堂] (kètáng) - lớp học, phòng học [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '课堂'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('课堂', 'kètáng', 'lớp học, phòng học', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kètáng',
      meaning_vi = 'lớp học, phòng học',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '课堂';
  END IF;

  -- [口语] (kǒuyǔ) - khẩu ngữ, ngôn ngữ nói [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '口语'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('口语', 'kǒuyǔ', 'khẩu ngữ, ngôn ngữ nói', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kǒuyǔ',
      meaning_vi = 'khẩu ngữ, ngôn ngữ nói',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '口语';
  END IF;

  -- [快餐] (kuàicān) - thức ăn nhanh [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '快餐'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('快餐', 'kuàicān', 'thức ăn nhanh', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kuàicān',
      meaning_vi = 'thức ăn nhanh',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '快餐';
  END IF;

  -- [快递] (kuàidì) - chuyển phát nhanh [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '快递'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('快递', 'kuàidì', 'chuyển phát nhanh', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kuàidì',
      meaning_vi = 'chuyển phát nhanh',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '快递';
  END IF;

  -- [快速] (kuàisù) - nhanh chóng, tốc độ cao [Tính từ / Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '快速'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('快速', 'kuàisù', 'nhanh chóng, tốc độ cao', 'Tính từ / Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'kuàisù',
      meaning_vi = 'nhanh chóng, tốc độ cao',
      word_type = 'Tính từ / Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '快速';
  END IF;

  -- [垃圾] (lājī) - rác thải, rác rưởi [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '垃圾'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('垃圾', 'lājī', 'rác thải, rác rưởi', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'lājī',
      meaning_vi = 'rác thải, rác rưởi',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '垃圾';
  END IF;

  -- [老家] (lǎojiā) - quê quán, nhà cũ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '老家'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('老家', 'lǎojiā', 'quê quán, nhà cũ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'lǎojiā',
      meaning_vi = 'quê quán, nhà cũ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '老家';
  END IF;

  -- [老年] (lǎonián) - tuổi già, người cao tuổi [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '老年'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('老年', 'lǎonián', 'tuổi già, người cao tuổi', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'lǎonián',
      meaning_vi = 'tuổi già, người cao tuổi',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '老年';
  END IF;

  -- [老是] (lǎoshì) - cứ, luôn luôn [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '老是'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('老是', 'lǎoshì', 'cứ, luôn luôn', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'lǎoshì',
      meaning_vi = 'cứ, luôn luôn',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '老是';
  END IF;

  -- [例子] (lìzi) - ví dụ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '例子'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('例子', 'lìzi', 'ví dụ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'lìzi',
      meaning_vi = 'ví dụ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '例子';
  END IF;

  -- [凉] (liáng) - mát mẻ, nguội lạnh [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '凉'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('凉', 'liáng', 'mát mẻ, nguội lạnh', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'liáng',
      meaning_vi = 'mát mẻ, nguội lạnh',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '凉';
  END IF;

  -- [量] (liáng) - đo, lường, tính toán [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '量'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('量', 'liáng', 'đo, lường, tính toán', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'liáng',
      meaning_vi = 'đo, lường, tính toán',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '量';
  END IF;

  -- [两] (liǎng) - lạng (50 gam) [Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '两'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('两', 'liǎng', 'lạng (50 gam)', 'Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'liǎng',
      meaning_vi = 'lạng (50 gam)',
      word_type = 'Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '两';
  END IF;

  -- [亮] (liàng) - sáng, sáng sủa; bật sáng [Tính từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '亮'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('亮', 'liàng', 'sáng, sáng sủa; bật sáng', 'Tính từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'liàng',
      meaning_vi = 'sáng, sáng sủa; bật sáng',
      word_type = 'Tính từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '亮';
  END IF;

  -- [列] (liè) - liệt kê; hàng, đoàn (tàu) [Động từ / Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '列'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('列', 'liè', 'liệt kê; hàng, đoàn (tàu)', 'Động từ / Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'liè',
      meaning_vi = 'liệt kê; hàng, đoàn (tàu)',
      word_type = 'Động từ / Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '列';
  END IF;

  -- [零下] (líng xià) - dưới 0 độ [Cụm từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '零下'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('零下', 'líng xià', 'dưới 0 độ', 'Cụm từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'líng xià',
      meaning_vi = 'dưới 0 độ',
      word_type = 'Cụm từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '零下';
  END IF;

  -- [零花钱] (línghuāqián) - tiền tiêu vặt [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '零花钱'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('零花钱', 'línghuāqián', 'tiền tiêu vặt', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'línghuāqián',
      meaning_vi = 'tiền tiêu vặt',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '零花钱';
  END IF;

  -- [零食] (língshí) - đồ ăn vặt [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '零食'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('零食', 'língshí', 'đồ ăn vặt', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'língshí',
      meaning_vi = 'đồ ăn vặt',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '零食';
  END IF;

  -- [另] (lìng) - khác, ngoài ra [Đại từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '另'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('另', 'lìng', 'khác, ngoài ra', 'Đại từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'lìng',
      meaning_vi = 'khác, ngoài ra',
      word_type = 'Đại từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '另';
  END IF;

  -- [流] (liú) - chảy, trôi [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '流'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('流', 'liú', 'chảy, trôi', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'liú',
      meaning_vi = 'chảy, trôi',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '流';
  END IF;

  -- [留下] (liúxia) - để lại, giữ lại [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '留下'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('留下', 'liúxia', 'để lại, giữ lại', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'liúxia',
      meaning_vi = 'để lại, giữ lại',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '留下';
  END IF;

  -- [路过] (lùguò) - đi ngang qua [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '路过'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('路过', 'lùguò', 'đi ngang qua', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'lùguò',
      meaning_vi = 'đi ngang qua',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '路过';
  END IF;

  -- [旅馆] (lǚguǎn) - khách sạn, nhà nghỉ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '旅馆'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('旅馆', 'lǚguǎn', 'khách sạn, nhà nghỉ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'lǚguǎn',
      meaning_vi = 'khách sạn, nhà nghỉ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '旅馆';
  END IF;

  -- [旅客] (lǚkè) - hành khách, lữ khách [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '旅客'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('旅客', 'lǚkè', 'hành khách, lữ khách', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'lǚkè',
      meaning_vi = 'hành khách, lữ khách',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '旅客';
  END IF;

  -- [落] (luò) - rơi, rụng; hạ xuống [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '落'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('落', 'luò', 'rơi, rụng; hạ xuống', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'luò',
      meaning_vi = 'rơi, rụng; hạ xuống',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '落';
  END IF;

  -- [馒头] (mántou) - bánh bao chay, màn thầu [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '馒头'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('馒头', 'mántou', 'bánh bao chay, màn thầu', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'mántou',
      meaning_vi = 'bánh bao chay, màn thầu',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '馒头';
  END IF;

  -- [毛衣] (máoyī) - áo len [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '毛衣'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('毛衣', 'máoyī', 'áo len', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'máoyī',
      meaning_vi = 'áo len',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '毛衣';
  END IF;

  -- [美] (měi) - đẹp, tươi đẹp [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '美'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('美', 'měi', 'đẹp, tươi đẹp', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'měi',
      meaning_vi = 'đẹp, tươi đẹp',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '美';
  END IF;

  -- [美好] (měihǎo) - tốt đẹp, mỹ mãn [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '美好'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('美好', 'měihǎo', 'tốt đẹp, mỹ mãn', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'měihǎo',
      meaning_vi = 'tốt đẹp, mỹ mãn',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '美好';
  END IF;

  -- [美景] (měijǐng) - cảnh đẹp, mỹ cảnh [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '美景'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('美景', 'měijǐng', 'cảnh đẹp, mỹ cảnh', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'měijǐng',
      meaning_vi = 'cảnh đẹp, mỹ cảnh',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '美景';
  END IF;

  -- [美食] (měishí) - món ăn ngon, mỹ vị [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '美食'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('美食', 'měishí', 'món ăn ngon, mỹ vị', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'měishí',
      meaning_vi = 'món ăn ngon, mỹ vị',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '美食';
  END IF;

  -- [梦想] (mèngxiǎng) - mơ ước, ước mơ [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '梦想'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('梦想', 'mèngxiǎng', 'mơ ước, ước mơ', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'mèngxiǎng',
      meaning_vi = 'mơ ước, ước mơ',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '梦想';
  END IF;

  -- [面对] (miànduì) - đối mặt, đối diện [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '面对'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('面对', 'miànduì', 'đối mặt, đối diện', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'miànduì',
      meaning_vi = 'đối mặt, đối diện',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '面对';
  END IF;

  -- [面试] (miànshì) - phỏng vấn trực tiếp [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '面试'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('面试', 'miànshì', 'phỏng vấn trực tiếp', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'miànshì',
      meaning_vi = 'phỏng vấn trực tiếp',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '面试';
  END IF;

  -- [末] (mò) - cuối, ngọn, mạt [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '末'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('末', 'mò', 'cuối, ngọn, mạt', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'mò',
      meaning_vi = 'cuối, ngọn, mạt',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '末';
  END IF;

  -- [母女] (mǔnǚ) - mẹ và con gái [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '母女'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('母女', 'mǔnǚ', 'mẹ và con gái', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'mǔnǚ',
      meaning_vi = 'mẹ và con gái',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '母女';
  END IF;

  -- [母子] (mǔzǐ) - mẹ và con trai [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '母子'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('母子', 'mǔzǐ', 'mẹ và con trai', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'mǔzǐ',
      meaning_vi = 'mẹ và con trai',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '母子';
  END IF;

  -- [目标] (mùbiāo) - mục tiêu [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '目标'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('目标', 'mùbiāo', 'mục tiêu', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'mùbiāo',
      meaning_vi = 'mục tiêu',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '目标';
  END IF;

  -- [目的地] (mùdìdì) - điểm đến, đích đến [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '目的地'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('目的地', 'mùdìdì', 'điểm đến, đích đến', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'mùdìdì',
      meaning_vi = 'điểm đến, đích đến',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '目的地';
  END IF;

  -- [目前] (mùqián) - hiện nay, hiện tại [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '目前'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('目前', 'mùqián', 'hiện nay, hiện tại', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'mùqián',
      meaning_vi = 'hiện nay, hiện tại',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '目前';
  END IF;

  -- [南部] (nánbù) - miền nam, phía nam [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '南部'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('南部', 'nánbù', 'miền nam, phía nam', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'nánbù',
      meaning_vi = 'miền nam, phía nam',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '南部';
  END IF;

  -- [男士] (nánshì) - nam giới, quý ông [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '男士'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('男士', 'nánshì', 'nam giới, quý ông', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'nánshì',
      meaning_vi = 'nam giới, quý ông',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '男士';
  END IF;

  -- [难忘] (nánwàng) - khó quên, đáng nhớ [Tính từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '难忘'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('难忘', 'nánwàng', 'khó quên, đáng nhớ', 'Tính từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'nánwàng',
      meaning_vi = 'khó quên, đáng nhớ',
      word_type = 'Tính từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '难忘';
  END IF;

  -- [男性] (nánxìng) - phái nam, nam giới [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '男性'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('男性', 'nánxìng', 'phái nam, nam giới', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'nánxìng',
      meaning_vi = 'phái nam, nam giới',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '男性';
  END IF;

  -- [内心] (nèixīn) - nội tâm, đáy lòng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '内心'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('内心', 'nèixīn', 'nội tâm, đáy lòng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'nèixīn',
      meaning_vi = 'nội tâm, đáy lòng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '内心';
  END IF;

  -- [能否] (néng fǒu) - liệu có thể hay không [Cụm từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '能否'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('能否', 'néng fǒu', 'liệu có thể hay không', 'Cụm từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'néng fǒu',
      meaning_vi = 'liệu có thể hay không',
      word_type = 'Cụm từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '能否';
  END IF;

  -- [能够] (nénggòu) - có thể, có khả năng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '能够'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('能够', 'nénggòu', 'có thể, có khả năng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'nénggòu',
      meaning_vi = 'có thể, có khả năng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '能够';
  END IF;

  -- [嗯] (ǹg) - ừ, vâng (thán từ đồng ý) [Thán từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '嗯'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('嗯', 'ǹg', 'ừ, vâng (thán từ đồng ý)', 'Thán từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'ǹg',
      meaning_vi = 'ừ, vâng (thán từ đồng ý)',
      word_type = 'Thán từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '嗯';
  END IF;

  -- [年底] (niándǐ) - cuối năm [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '年底'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('年底', 'niándǐ', 'cuối năm', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'niándǐ',
      meaning_vi = 'cuối năm',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '年底';
  END IF;

  -- [农村] (nóngcūn) - nông thôn, làng quê [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '农村'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('农村', 'nóngcūn', 'nông thôn, làng quê', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'nóngcūn',
      meaning_vi = 'nông thôn, làng quê',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '农村';
  END IF;

  -- [女性] (nǚxìng) - phụ nữ, phái nữ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '女性'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('女性', 'nǚxìng', 'phụ nữ, phái nữ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'nǚxìng',
      meaning_vi = 'phụ nữ, phái nữ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '女性';
  END IF;

  -- [拍] (pāi) - đập, vỗ; chụp ảnh, quay phim; cái vợt [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '拍'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('拍', 'pāi', 'đập, vỗ; chụp ảnh, quay phim; cái vợt', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'pāi',
      meaning_vi = 'đập, vỗ; chụp ảnh, quay phim; cái vợt',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '拍';
  END IF;

  -- [排] (pái) - sắp xếp, xếp hàng; dãy, hàng [Động từ / Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '排'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('排', 'pái', 'sắp xếp, xếp hàng; dãy, hàng', 'Động từ / Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'pái',
      meaning_vi = 'sắp xếp, xếp hàng; dãy, hàng',
      word_type = 'Động từ / Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '排';
  END IF;

  -- [牌] (pái) - biển hiệu, thẻ, bài tây [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '牌'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('牌', 'pái', 'biển hiệu, thẻ, bài tây', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'pái',
      meaning_vi = 'biển hiệu, thẻ, bài tây',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '牌';
  END IF;

  -- [排球] (páiqiú) - bóng chuyền [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '排球'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('排球', 'páiqiú', 'bóng chuyền', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'páiqiú',
      meaning_vi = 'bóng chuyền',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '排球';
  END IF;

  -- [牌子] (páizi) - thương hiệu; biển hiệu, tấm biển [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '牌子'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('牌子', 'páizi', 'thương hiệu; biển hiệu, tấm biển', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'páizi',
      meaning_vi = 'thương hiệu; biển hiệu, tấm biển',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '牌子';
  END IF;

  -- [片] (piàn) - mảnh, lát, phiến; viên (thuốc) [Danh từ / Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '片'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('片', 'piàn', 'mảnh, lát, phiến; viên (thuốc)', 'Danh từ / Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'piàn',
      meaning_vi = 'mảnh, lát, phiến; viên (thuốc)',
      word_type = 'Danh từ / Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '片';
  END IF;

  -- [平常] (píngcháng) - bình thường, ngày thường [Tính từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '平常'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('平常', 'píngcháng', 'bình thường, ngày thường', 'Tính từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'píngcháng',
      meaning_vi = 'bình thường, ngày thường',
      word_type = 'Tính từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '平常';
  END IF;

  -- [葡萄酒] (pútaojiǔ) - rượu vang [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '葡萄酒'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('葡萄酒', 'pútaojiǔ', 'rượu vang', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'pútaojiǔ',
      meaning_vi = 'rượu vang',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '葡萄酒';
  END IF;

  -- [普通] (pǔtōng) - phổ thông, bình thường [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '普通'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('普通', 'pǔtōng', 'phổ thông, bình thường', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'pǔtōng',
      meaning_vi = 'phổ thông, bình thường',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '普通';
  END IF;

  -- [期] (qī) - kỳ, giai đoạn, số (báo) [Lượng từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '期'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('期', 'qī', 'kỳ, giai đoạn, số (báo)', 'Lượng từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qī',
      meaning_vi = 'kỳ, giai đoạn, số (báo)',
      word_type = 'Lượng từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '期';
  END IF;

  -- [期末] (qīmò) - cuối kỳ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '期末'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('期末', 'qīmò', 'cuối kỳ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qīmò',
      meaning_vi = 'cuối kỳ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '期末';
  END IF;

  -- [期中] (qīzhōng) - giữa kỳ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '期中'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('期中', 'qīzhōng', 'giữa kỳ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qīzhōng',
      meaning_vi = 'giữa kỳ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '期中';
  END IF;

  -- [起到] (qǐdào) - đóng vai trò, phát huy tác dụng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '起到'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('起到', 'qǐdào', 'đóng vai trò, phát huy tác dụng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qǐdào',
      meaning_vi = 'đóng vai trò, phát huy tác dụng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '起到';
  END IF;

  -- [气] (qì) - không khí, khí ga; tức giận [Danh từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '气'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('气', 'qì', 'không khí, khí ga; tức giận', 'Danh từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qì',
      meaning_vi = 'không khí, khí ga; tức giận',
      word_type = 'Danh từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '气';
  END IF;

  -- [汽水] (qìshuǐ) - nước ngọt có ga [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '汽水'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('汽水', 'qìshuǐ', 'nước ngọt có ga', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qìshuǐ',
      meaning_vi = 'nước ngọt có ga',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '汽水';
  END IF;

  -- [气温] (qìwēn) - nhiệt độ không khí [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '气温'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('气温', 'qìwēn', 'nhiệt độ không khí', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qìwēn',
      meaning_vi = 'nhiệt độ không khí',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '气温';
  END IF;

  -- [千克] (qiānkè) - ki-lô-gam (kg) [Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '千克'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('千克', 'qiānkè', 'ki-lô-gam (kg)', 'Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qiānkè',
      meaning_vi = 'ki-lô-gam (kg)',
      word_type = 'Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '千克';
  END IF;

  -- [前方] (qiánfāng) - phía trước [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '前方'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('前方', 'qiánfāng', 'phía trước', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qiánfāng',
      meaning_vi = 'phía trước',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '前方';
  END IF;

  -- [前后] (qiánhòu) - trước sau, khoảng chừng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '前后'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('前后', 'qiánhòu', 'trước sau, khoảng chừng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qiánhòu',
      meaning_vi = 'trước sau, khoảng chừng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '前后';
  END IF;

  -- [强] (qiáng) - mạnh mẽ, giỏi giang [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '强'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('强', 'qiáng', 'mạnh mẽ, giỏi giang', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qiáng',
      meaning_vi = 'mạnh mẽ, giỏi giang',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '强';
  END IF;

  -- [巧] (qiǎo) - khéo léo; tình cờ, đúng lúc [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '巧'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('巧', 'qiǎo', 'khéo léo; tình cờ, đúng lúc', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qiǎo',
      meaning_vi = 'khéo léo; tình cờ, đúng lúc',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '巧';
  END IF;

  -- [琴] (qín) - đàn (nhạc cụ) [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '琴'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('琴', 'qín', 'đàn (nhạc cụ)', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qín',
      meaning_vi = 'đàn (nhạc cụ)',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '琴';
  END IF;

  -- [青年] (qīngnián) - thanh niên [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '青年'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('青年', 'qīngnián', 'thanh niên', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qīngnián',
      meaning_vi = 'thanh niên',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '青年';
  END IF;

  -- [庆祝] (qìngzhù) - chúc mừng, ăn mừng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '庆祝'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('庆祝', 'qìngzhù', 'chúc mừng, ăn mừng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qìngzhù',
      meaning_vi = 'chúc mừng, ăn mừng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '庆祝';
  END IF;

  -- [球队] (qiúduì) - đội bóng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '球队'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('球队', 'qiúduì', 'đội bóng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qiúduì',
      meaning_vi = 'đội bóng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '球队';
  END IF;

  -- [球迷] (qiúmí) - người hâm mộ bóng đá/thể thao [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '球迷'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('球迷', 'qiúmí', 'người hâm mộ bóng đá/thể thao', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qiúmí',
      meaning_vi = 'người hâm mộ bóng đá/thể thao',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '球迷';
  END IF;

  -- [区] (qū) - khu vực, quận [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '区'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('区', 'qū', 'khu vực, quận', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qū',
      meaning_vi = 'khu vực, quận',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '区';
  END IF;

  -- [取得] (qǔdé) - giành được, đạt được [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '取得'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('取得', 'qǔdé', 'giành được, đạt được', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qǔdé',
      meaning_vi = 'giành được, đạt được',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '取得';
  END IF;

  -- [取消] (qǔxiāo) - hủy bỏ, bãi bỏ [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '取消'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('取消', 'qǔxiāo', 'hủy bỏ, bãi bỏ', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'qǔxiāo',
      meaning_vi = 'hủy bỏ, bãi bỏ',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '取消';
  END IF;

  -- [全] (quán) - toàn bộ, đầy đủ [Tính từ / Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '全'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('全', 'quán', 'toàn bộ, đầy đủ', 'Tính từ / Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'quán',
      meaning_vi = 'toàn bộ, đầy đủ',
      word_type = 'Tính từ / Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '全';
  END IF;

  -- [全都] (quándōu) - tất thảy, toàn bộ đều [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '全都'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('全都', 'quándōu', 'tất thảy, toàn bộ đều', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'quándōu',
      meaning_vi = 'tất thảy, toàn bộ đều',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '全都';
  END IF;

  -- [全球] (quánqiú) - toàn cầu, thế giới [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '全球'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('全球', 'quánqiú', 'toàn cầu, thế giới', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'quánqiú',
      meaning_vi = 'toàn cầu, thế giới',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '全球';
  END IF;

  -- [全身] (quánshēn) - toàn thân [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '全身'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('全身', 'quánshēn', 'toàn thân', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'quánshēn',
      meaning_vi = 'toàn thân',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '全身';
  END IF;

  -- [缺] (quē) - thiếu, vắng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '缺'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('缺', 'quē', 'thiếu, vắng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'quē',
      meaning_vi = 'thiếu, vắng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '缺';
  END IF;

  -- [人生] (rénshēng) - đời người, nhân sinh [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '人生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('人生', 'rénshēng', 'đời người, nhân sinh', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'rénshēng',
      meaning_vi = 'đời người, nhân sinh',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '人生';
  END IF;

  -- [人数] (rénshù) - số lượng người [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '人数'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('人数', 'rénshù', 'số lượng người', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'rénshù',
      meaning_vi = 'số lượng người',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '人数';
  END IF;

  -- [人员] (rényuán) - nhân sự, nhân viên [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '人员'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('人员', 'rényuán', 'nhân sự, nhân viên', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'rényuán',
      meaning_vi = 'nhân sự, nhân viên',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '人员';
  END IF;

  -- [仍] (réng) - vẫn, vẫn còn [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '仍'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('仍', 'réng', 'vẫn, vẫn còn', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'réng',
      meaning_vi = 'vẫn, vẫn còn',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '仍';
  END IF;

  -- [日常] (rìcháng) - thường ngày, thường nhật [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '日常'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('日常', 'rìcháng', 'thường ngày, thường nhật', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'rìcháng',
      meaning_vi = 'thường ngày, thường nhật',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '日常';
  END IF;

  -- [日期] (rìqī) - ngày tháng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '日期'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('日期', 'rìqī', 'ngày tháng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'rìqī',
      meaning_vi = 'ngày tháng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '日期';
  END IF;

  -- [日子] (rìzi) - ngày, chuỗi ngày, cuộc sống [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '日子'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('日子', 'rìzi', 'ngày, chuỗi ngày, cuộc sống', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'rìzi',
      meaning_vi = 'ngày, chuỗi ngày, cuộc sống',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '日子';
  END IF;

  -- [入] (rù) - vào, nhập vào [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '入'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('入', 'rù', 'vào, nhập vào', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'rù',
      meaning_vi = 'vào, nhập vào',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '入';
  END IF;

  -- [入学] (rùxué) - nhập học [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '入学'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('入学', 'rùxué', 'nhập học', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'rùxué',
      meaning_vi = 'nhập học',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '入学';
  END IF;

  -- [入住] (rùzhù) - nhận phòng, dọn vào ở [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '入住'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('入住', 'rùzhù', 'nhận phòng, dọn vào ở', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'rùzhù',
      meaning_vi = 'nhận phòng, dọn vào ở',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '入住';
  END IF;

  -- [扫码] (sǎomǎ) - quét mã (QR code) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '扫码'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('扫码', 'sǎomǎ', 'quét mã (QR code)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'sǎomǎ',
      meaning_vi = 'quét mã (QR code)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '扫码';
  END IF;

  -- [商品] (shāngpǐn) - hàng hóa, thương phẩm [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '商品'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('商品', 'shāngpǐn', 'hàng hóa, thương phẩm', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shāngpǐn',
      meaning_vi = 'hàng hóa, thương phẩm',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '商品';
  END IF;

  -- [上门] (shàngmén) - đến tận nhà, phục vụ tận nơi [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '上门'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('上门', 'shàngmén', 'đến tận nhà, phục vụ tận nơi', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shàngmén',
      meaning_vi = 'đến tận nhà, phục vụ tận nơi',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '上门';
  END IF;

  -- [稍] (shāo) - hơi, một chút [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '稍'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('稍', 'shāo', 'hơi, một chút', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shāo',
      meaning_vi = 'hơi, một chút',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '稍';
  END IF;

  -- [少见] (shǎojiàn) - hiếm thấy, ít thấy [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '少见'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('少见', 'shǎojiàn', 'hiếm thấy, ít thấy', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shǎojiàn',
      meaning_vi = 'hiếm thấy, ít thấy',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '少见';
  END IF;

  -- [少量] (shǎoliàng) - số lượng ít, một lượng nhỏ [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '少量'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('少量', 'shǎoliàng', 'số lượng ít, một lượng nhỏ', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shǎoliàng',
      meaning_vi = 'số lượng ít, một lượng nhỏ',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '少量';
  END IF;

  -- [少数] (shǎoshù) - thiểu số, số ít [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '少数'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('少数', 'shǎoshù', 'thiểu số, số ít', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shǎoshù',
      meaning_vi = 'thiểu số, số ít',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '少数';
  END IF;

  -- [少年] (shàonián) - thiếu niên [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '少年'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('少年', 'shàonián', 'thiếu niên', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shàonián',
      meaning_vi = 'thiếu niên',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '少年';
  END IF;

  -- [摄氏度] (shèshìdù) - độ C (độ Celsius) [Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '摄氏度'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('摄氏度', 'shèshìdù', 'độ C (độ Celsius)', 'Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shèshìdù',
      meaning_vi = 'độ C (độ Celsius)',
      word_type = 'Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '摄氏度';
  END IF;

  -- [身] (shēn) - thân thể, bộ (quần áo) [Danh từ / Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '身'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('身', 'shēn', 'thân thể, bộ (quần áo)', 'Danh từ / Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shēn',
      meaning_vi = 'thân thể, bộ (quần áo)',
      word_type = 'Danh từ / Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '身';
  END IF;

  -- [身份证] (shēnfènzhèng) - thẻ căn cước, chứng minh nhân dân [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '身份证'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('身份证', 'shēnfènzhèng', 'thẻ căn cước, chứng minh nhân dân', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shēnfènzhèng',
      meaning_vi = 'thẻ căn cước, chứng minh nhân dân',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '身份证';
  END IF;

  -- [生] (shēng) - sinh, sinh đẻ, sinh ra [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('生', 'shēng', 'sinh, sinh đẻ, sinh ra', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shēng',
      meaning_vi = 'sinh, sinh đẻ, sinh ra',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '生';
  END IF;

  -- [生] (shēng) - sống, chưa chín; xa lạ [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('生', 'shēng', 'sống, chưa chín; xa lạ', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shēng',
      meaning_vi = 'sống, chưa chín; xa lạ',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '生';
  END IF;

  -- [失去] (shīqù) - mất đi, đánh mất [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '失去'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('失去', 'shīqù', 'mất đi, đánh mất', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shīqù',
      meaning_vi = 'mất đi, đánh mất',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '失去';
  END IF;

  -- [师生] (shīshēng) - thầy trò, giáo viên và học sinh [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '师生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('师生', 'shīshēng', 'thầy trò, giáo viên và học sinh', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shīshēng',
      meaning_vi = 'thầy trò, giáo viên và học sinh',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '师生';
  END IF;

  -- [时间表] (shíjiānbiǎo) - thời gian biểu, lịch trình [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '时间表'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('时间表', 'shíjiānbiǎo', 'thời gian biểu, lịch trình', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shíjiānbiǎo',
      meaning_vi = 'thời gian biểu, lịch trình',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '时间表';
  END IF;

  -- [实际上] (shíjìshàng) - thực tế, trên thực tế [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '实际上'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('实际上', 'shíjìshàng', 'thực tế, trên thực tế', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shíjìshàng',
      meaning_vi = 'thực tế, trên thực tế',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '实际上';
  END IF;

  -- [食品] (shípǐn) - thực phẩm, đồ ăn [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '食品'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('食品', 'shípǐn', 'thực phẩm, đồ ăn', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shípǐn',
      meaning_vi = 'thực phẩm, đồ ăn',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '食品';
  END IF;

  -- [食堂] (shítáng) - nhà ăn, căng tin [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '食堂'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('食堂', 'shítáng', 'nhà ăn, căng tin', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shítáng',
      meaning_vi = 'nhà ăn, căng tin',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '食堂';
  END IF;

  -- [食物] (shíwù) - thức ăn, đồ ăn [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '食物'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('食物', 'shíwù', 'thức ăn, đồ ăn', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shíwù',
      meaning_vi = 'thức ăn, đồ ăn',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '食物';
  END IF;

  -- [十字路口] (shízì lùkǒu) - ngã tư đường [Cụm từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '十字路口'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('十字路口', 'shízì lùkǒu', 'ngã tư đường', 'Cụm từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shízì lùkǒu',
      meaning_vi = 'ngã tư đường',
      word_type = 'Cụm từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '十字路口';
  END IF;

  -- [使馆] (shǐguǎn) - đại sứ quán [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '使馆'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('使馆', 'shǐguǎn', 'đại sứ quán', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shǐguǎn',
      meaning_vi = 'đại sứ quán',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '使馆';
  END IF;

  -- [市场] (shìchǎng) - thị trường, chợ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '市场'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('市场', 'shìchǎng', 'thị trường, chợ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shìchǎng',
      meaning_vi = 'thị trường, chợ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '市场';
  END IF;

  -- [视频] (shìpín) - video, clip [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '视频'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('视频', 'shìpín', 'video, clip', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shìpín',
      meaning_vi = 'video, clip',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '视频';
  END IF;

  -- [市区] (shìqū) - khu vực nội thành, khu trung tâm thành phố [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '市区'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('市区', 'shìqū', 'khu vực nội thành, khu trung tâm thành phố', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shìqū',
      meaning_vi = 'khu vực nội thành, khu trung tâm thành phố',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '市区';
  END IF;

  -- [试题] (shìtí) - đề thi, câu hỏi thi [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '试题'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('试题', 'shìtí', 'đề thi, câu hỏi thi', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shìtí',
      meaning_vi = 'đề thi, câu hỏi thi',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '试题';
  END IF;

  -- [收费] (shōufèi) - thu phí, tính phí [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '收费'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('收费', 'shōufèi', 'thu phí, tính phí', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shōufèi',
      meaning_vi = 'thu phí, tính phí',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '收费';
  END IF;

  -- [收听] (shōutīng) - nghe (đài phát thanh) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '收听'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('收听', 'shōutīng', 'nghe (đài phát thanh)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shōutīng',
      meaning_vi = 'nghe (đài phát thanh)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '收听';
  END IF;

  -- [首] (shǒu) - bài (thơ/hát); đầu [Lượng từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '首'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('首', 'shǒu', 'bài (thơ/hát); đầu', 'Lượng từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shǒu',
      meaning_vi = 'bài (thơ/hát); đầu',
      word_type = 'Lượng từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '首';
  END IF;

  -- [售票员] (shòupiàoyuán) - nhân viên bán vé [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '售票员'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('售票员', 'shòupiàoyuán', 'nhân viên bán vé', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shòupiàoyuán',
      meaning_vi = 'nhân viên bán vé',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '售票员';
  END IF;

  -- [受伤] (shòushāng) - bị thương [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '受伤'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('受伤', 'shòushāng', 'bị thương', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shòushāng',
      meaning_vi = 'bị thương',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '受伤';
  END IF;

  -- [熟] (shú/shóu) - chín (thức ăn); quen thuộc [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '熟'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('熟', 'shú/shóu', 'chín (thức ăn); quen thuộc', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shú/shóu',
      meaning_vi = 'chín (thức ăn); quen thuộc',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '熟';
  END IF;

  -- [暑假] (shǔjià) - kỳ nghỉ hè [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '暑假'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('暑假', 'shǔjià', 'kỳ nghỉ hè', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shǔjià',
      meaning_vi = 'kỳ nghỉ hè',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '暑假';
  END IF;

  -- [数] (shù) - con số, số lượng [Danh từ / Số từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '数'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('数', 'shù', 'con số, số lượng', 'Danh từ / Số từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shù',
      meaning_vi = 'con số, số lượng',
      word_type = 'Danh từ / Số từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '数';
  END IF;

  -- [树林] (shùlín) - rừng cây [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '树林'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('树林', 'shùlín', 'rừng cây', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shùlín',
      meaning_vi = 'rừng cây',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '树林';
  END IF;

  -- [说法] (shuōfǎ) - cách nói, cách diễn đạt, quan điểm [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '说法'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('说法', 'shuōfǎ', 'cách nói, cách diễn đạt, quan điểm', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shuōfǎ',
      meaning_vi = 'cách nói, cách diễn đạt, quan điểm',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '说法';
  END IF;

  -- [说明书] (shuōmíngshū) - sách hướng dẫn sử dụng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '说明书'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('说明书', 'shuōmíngshū', 'sách hướng dẫn sử dụng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'shuōmíngshū',
      meaning_vi = 'sách hướng dẫn sử dụng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '说明书';
  END IF;

  -- [塑料] (sùliào) - chất dẻo, nhựa [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '塑料'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('塑料', 'sùliào', 'chất dẻo, nhựa', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'sùliào',
      meaning_vi = 'chất dẻo, nhựa',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '塑料';
  END IF;

  -- [酸奶] (suānnǎi) - sữa chua [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '酸奶'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('酸奶', 'suānnǎi', 'sữa chua', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'suānnǎi',
      meaning_vi = 'sữa chua',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '酸奶';
  END IF;

  -- [算] (suàn) - tính toán; coi như là [Động từ / Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '算'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('算', 'suàn', 'tính toán; coi như là', 'Động từ / Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'suàn',
      meaning_vi = 'tính toán; coi như là',
      word_type = 'Động từ / Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '算';
  END IF;

  -- [孙女] (sūnnǚ) - cháu gái (nội) [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '孙女'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('孙女', 'sūnnǚ', 'cháu gái (nội)', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'sūnnǚ',
      meaning_vi = 'cháu gái (nội)',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '孙女';
  END IF;

  -- [抬头] (táitóu) - ngẩng đầu [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '抬头'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('抬头', 'táitóu', 'ngẩng đầu', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'táitóu',
      meaning_vi = 'ngẩng đầu',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '抬头';
  END IF;

  -- [弹] (tán) - gảy, búng, chơi (nhạc cụ có dây) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '弹'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('弹', 'tán', 'gảy, búng, chơi (nhạc cụ có dây)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tán',
      meaning_vi = 'gảy, búng, chơi (nhạc cụ có dây)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '弹';
  END IF;

  -- [提出] (tíchū) - đưa ra, đề xuất [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '提出'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('提出', 'tíchū', 'đưa ra, đề xuất', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tíchū',
      meaning_vi = 'đưa ra, đề xuất',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '提出';
  END IF;

  -- [提到] (tídào) - nhắc tới, đề cập đến [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '提到'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('提到', 'tídào', 'nhắc tới, đề cập đến', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tídào',
      meaning_vi = 'nhắc tới, đề cập đến',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '提到';
  END IF;

  -- [体检] (tǐjiǎn) - khám sức khỏe [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '体检'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('体检', 'tǐjiǎn', 'khám sức khỏe', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tǐjiǎn',
      meaning_vi = 'khám sức khỏe',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '体检';
  END IF;

  -- [体温] (tǐwēn) - nhiệt độ cơ thể, thân nhiệt [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '体温'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('体温', 'tǐwēn', 'nhiệt độ cơ thể, thân nhiệt', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tǐwēn',
      meaning_vi = 'nhiệt độ cơ thể, thân nhiệt',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '体温';
  END IF;

  -- [体重] (tǐzhòng) - trọng lượng cơ thể, cân nặng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '体重'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('体重', 'tǐzhòng', 'trọng lượng cơ thể, cân nặng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tǐzhòng',
      meaning_vi = 'trọng lượng cơ thể, cân nặng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '体重';
  END IF;

  -- [填写] (tiánxiě) - điền vào, viết vào (mẫu) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '填写'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('填写', 'tiánxiě', 'điền vào, viết vào (mẫu)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tiánxiě',
      meaning_vi = 'điền vào, viết vào (mẫu)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '填写';
  END IF;

  -- [听力] (tīnglì) - thính lực, kỹ năng nghe [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '听力'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('听力', 'tīnglì', 'thính lực, kỹ năng nghe', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tīnglì',
      meaning_vi = 'thính lực, kỹ năng nghe',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '听力';
  END IF;

  -- [听众] (tīngzhòng) - thính giả, người nghe [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '听众'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('听众', 'tīngzhòng', 'thính giả, người nghe', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tīngzhòng',
      meaning_vi = 'thính giả, người nghe',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '听众';
  END IF;

  -- [停车] (tíngchē) - đỗ xe, dừng xe [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '停车'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('停车', 'tíngchē', 'đỗ xe, dừng xe', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tíngchē',
      meaning_vi = 'đỗ xe, dừng xe',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '停车';
  END IF;

  -- [停车场] (tíngchēchǎng) - bãi đỗ xe [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '停车场'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('停车场', 'tíngchēchǎng', 'bãi đỗ xe', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tíngchēchǎng',
      meaning_vi = 'bãi đỗ xe',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '停车场';
  END IF;

  -- [停止] (tíngzhǐ) - dừng lại, đình chỉ, ngừng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '停止'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('停止', 'tíngzhǐ', 'dừng lại, đình chỉ, ngừng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tíngzhǐ',
      meaning_vi = 'dừng lại, đình chỉ, ngừng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '停止';
  END IF;

  -- [通] (tōng) - thông suốt, thông qua; hiểu rõ [Động từ / Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '通'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('通', 'tōng', 'thông suốt, thông qua; hiểu rõ', 'Động từ / Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tōng',
      meaning_vi = 'thông suốt, thông qua; hiểu rõ',
      word_type = 'Động từ / Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '通';
  END IF;

  -- [童年] (tóngnián) - thời thơ ấu, tuổi thơ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '童年'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('童年', 'tóngnián', 'thời thơ ấu, tuổi thơ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tóngnián',
      meaning_vi = 'thời thơ ấu, tuổi thơ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '童年';
  END IF;

  -- [同样] (tóngyàng) - như nhau, giống nhau [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '同样'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('同样', 'tóngyàng', 'như nhau, giống nhau', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tóngyàng',
      meaning_vi = 'như nhau, giống nhau',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '同样';
  END IF;

  -- [桶] (tǒng) - thùng, xô [Danh từ / Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '桶'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('桶', 'tǒng', 'thùng, xô', 'Danh từ / Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tǒng',
      meaning_vi = 'thùng, xô',
      word_type = 'Danh từ / Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '桶';
  END IF;

  -- [痛] (tòng) - đau, đau đớn [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '痛'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('痛', 'tòng', 'đau, đau đớn', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tòng',
      meaning_vi = 'đau, đau đớn',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '痛';
  END IF;

  -- [头痛] (tóutòng) - đau đầu [Tính từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '头痛'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('头痛', 'tóutòng', 'đau đầu', 'Tính từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tóutòng',
      meaning_vi = 'đau đầu',
      word_type = 'Tính từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '头痛';
  END IF;

  -- [图] (tú) - hình ảnh, bản đồ, bức vẽ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '图'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('图', 'tú', 'hình ảnh, bản đồ, bức vẽ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tú',
      meaning_vi = 'hình ảnh, bản đồ, bức vẽ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '图';
  END IF;

  -- [图片] (túpiàn) - hình ảnh, bức ảnh [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '图片'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('图片', 'túpiàn', 'hình ảnh, bức ảnh', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'túpiàn',
      meaning_vi = 'hình ảnh, bức ảnh',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '图片';
  END IF;

  -- [土] (tǔ) - đất đai; quê mùa [Danh từ / Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '土'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('土', 'tǔ', 'đất đai; quê mùa', 'Danh từ / Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tǔ',
      meaning_vi = 'đất đai; quê mùa',
      word_type = 'Danh từ / Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '土';
  END IF;

  -- [推出] (tuīchū) - tung ra, đưa ra thị trường, ra mắt [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '推出'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('推出', 'tuīchū', 'tung ra, đưa ra thị trường, ra mắt', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'tuīchū',
      meaning_vi = 'tung ra, đưa ra thị trường, ra mắt',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '推出';
  END IF;

  -- [外出] (wàichū) - ra ngoài, đi ra ngoài [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '外出'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('外出', 'wàichū', 'ra ngoài, đi ra ngoài', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wàichū',
      meaning_vi = 'ra ngoài, đi ra ngoài',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '外出';
  END IF;

  -- [外套] (wàitào) - áo khoác [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '外套'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('外套', 'wàitào', 'áo khoác', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wàitào',
      meaning_vi = 'áo khoác',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '外套';
  END IF;

  -- [晚安] (wǎn’ān) - chúc ngủ ngon [Động từ / Thán từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '晚安'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('晚安', 'wǎn’ān', 'chúc ngủ ngon', 'Động từ / Thán từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wǎn’ān',
      meaning_vi = 'chúc ngủ ngon',
      word_type = 'Động từ / Thán từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '晚安';
  END IF;

  -- [晚餐] (wǎncān) - bữa tối [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '晚餐'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('晚餐', 'wǎncān', 'bữa tối', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wǎncān',
      meaning_vi = 'bữa tối',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '晚餐';
  END IF;

  -- [网购] (wǎnggòu) - mua sắm qua mạng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '网购'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('网购', 'wǎnggòu', 'mua sắm qua mạng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wǎnggòu',
      meaning_vi = 'mua sắm qua mạng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '网购';
  END IF;

  -- [网页] (wǎngyè) - trang web [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '网页'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('网页', 'wǎngyè', 'trang web', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wǎngyè',
      meaning_vi = 'trang web',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '网页';
  END IF;

  -- [网友] (wǎngyǒu) - bạn trên mạng, cư dân mạng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '网友'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('网友', 'wǎngyǒu', 'bạn trên mạng, cư dân mạng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wǎngyǒu',
      meaning_vi = 'bạn trên mạng, cư dân mạng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '网友';
  END IF;

  -- [网址] (wǎngzhǐ) - địa chỉ trang web [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '网址'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('网址', 'wǎngzhǐ', 'địa chỉ trang web', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wǎngzhǐ',
      meaning_vi = 'địa chỉ trang web',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '网址';
  END IF;

  -- [为] (wéi) - làm, trở thành, là [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '为'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('为', 'wéi', 'làm, trở thành, là', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wéi',
      meaning_vi = 'làm, trở thành, là',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '为';
  END IF;

  -- [味] (wèi) - mùi vị, hương vị [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '味'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('味', 'wèi', 'mùi vị, hương vị', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wèi',
      meaning_vi = 'mùi vị, hương vị',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '味';
  END IF;

  -- [卫生] (wèishēng) - vệ sinh, sạch sẽ [Tính từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '卫生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('卫生', 'wèishēng', 'vệ sinh, sạch sẽ', 'Tính từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wèishēng',
      meaning_vi = 'vệ sinh, sạch sẽ',
      word_type = 'Tính từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '卫生';
  END IF;

  -- [闻] (wén) - ngửi; nghe thấy [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '闻'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('闻', 'wén', 'ngửi; nghe thấy', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wén',
      meaning_vi = 'ngửi; nghe thấy',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '闻';
  END IF;

  -- [文件] (wénjiàn) - tài liệu, tập tin, văn kiện [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '文件'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('文件', 'wénjiàn', 'tài liệu, tập tin, văn kiện', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wénjiàn',
      meaning_vi = 'tài liệu, tập tin, văn kiện',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '文件';
  END IF;

  -- [文字] (wénzì) - chữ viết, văn tự [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '文字'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('文字', 'wénzì', 'chữ viết, văn tự', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wénzì',
      meaning_vi = 'chữ viết, văn tự',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '文字';
  END IF;

  -- [无法] (wúfǎ) - không có cách nào, không thể [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '无法'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('无法', 'wúfǎ', 'không có cách nào, không thể', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wúfǎ',
      meaning_vi = 'không có cách nào, không thể',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '无法';
  END IF;

  -- [午餐] (wǔcān) - bữa trưa [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '午餐'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('午餐', 'wǔcān', 'bữa trưa', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'wǔcān',
      meaning_vi = 'bữa trưa',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '午餐';
  END IF;

  -- [吸] (xī) - hít vào, hút [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '吸'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('吸', 'xī', 'hít vào, hút', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xī',
      meaning_vi = 'hít vào, hút',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '吸';
  END IF;

  -- [西部] (xībù) - miền tây, phía tây [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '西部'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('西部', 'xībù', 'miền tây, phía tây', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xībù',
      meaning_vi = 'miền tây, phía tây',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '西部';
  END IF;

  -- [细] (xì) - nhỏ, mảnh, tinh tế, kỹ lưỡng [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '细'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('细', 'xì', 'nhỏ, mảnh, tinh tế, kỹ lưỡng', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xì',
      meaning_vi = 'nhỏ, mảnh, tinh tế, kỹ lưỡng',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '细';
  END IF;

  -- [细心] (xìxīn) - cẩn thận, chu đáo, tỉ mỉ [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '细心'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('细心', 'xìxīn', 'cẩn thận, chu đáo, tỉ mỉ', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xìxīn',
      meaning_vi = 'cẩn thận, chu đáo, tỉ mỉ',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '细心';
  END IF;

  -- [下降] (xiàjiàng) - hạ xuống, giảm xuống [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '下降'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('下降', 'xiàjiàng', 'hạ xuống, giảm xuống', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiàjiàng',
      meaning_vi = 'hạ xuống, giảm xuống',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '下降';
  END IF;

  -- [鲜] (xiān) - tươi, tươi ngon [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '鲜'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('鲜', 'xiān', 'tươi, tươi ngon', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiān',
      meaning_vi = 'tươi, tươi ngon',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '鲜';
  END IF;

  -- [鲜花] (xiānhuā) - hoa tươi [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '鲜花'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('鲜花', 'xiānhuā', 'hoa tươi', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiānhuā',
      meaning_vi = 'hoa tươi',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '鲜花';
  END IF;

  -- [线上] (xiànshàng) - trực tuyến, trên mạng [Danh từ / Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '线上'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('线上', 'xiànshàng', 'trực tuyến, trên mạng', 'Danh từ / Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiànshàng',
      meaning_vi = 'trực tuyến, trên mạng',
      word_type = 'Danh từ / Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '线上';
  END IF;

  -- [线下] (xiànxià) - trực tiếp, ngoại tuyến [Danh từ / Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '线下'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('线下', 'xiànxià', 'trực tiếp, ngoại tuyến', 'Danh từ / Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiànxià',
      meaning_vi = 'trực tiếp, ngoại tuyến',
      word_type = 'Danh từ / Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '线下';
  END IF;

  -- [现有] (xiànyǒu) - hiện có, sẵn có [Tính từ / Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '现有'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('现有', 'xiànyǒu', 'hiện có, sẵn có', 'Tính từ / Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiànyǒu',
      meaning_vi = 'hiện có, sẵn có',
      word_type = 'Tính từ / Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '现有';
  END IF;

  -- [相比] (xiāngbǐ) - so sánh, so với [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '相比'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('相比', 'xiāngbǐ', 'so sánh, so với', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiāngbǐ',
      meaning_vi = 'so sánh, so với',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '相比';
  END IF;

  -- [相互] (xiānghù) - lẫn nhau, qua lại [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '相互'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('相互', 'xiānghù', 'lẫn nhau, qua lại', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiānghù',
      meaning_vi = 'lẫn nhau, qua lại',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '相互';
  END IF;

  -- [想法] (xiǎngfǎ) - ý nghĩ, suy nghĩ, quan điểm [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '想法'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('想法', 'xiǎngfǎ', 'ý nghĩ, suy nghĩ, quan điểm', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiǎngfǎ',
      meaning_vi = 'ý nghĩ, suy nghĩ, quan điểm',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '想法';
  END IF;

  -- [项] (xiàng) - hạng mục, điều khoản [Lượng từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '项'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('项', 'xiàng', 'hạng mục, điều khoản', 'Lượng từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiàng',
      meaning_vi = 'hạng mục, điều khoản',
      word_type = 'Lượng từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '项';
  END IF;

  -- [小组] (xiǎozǔ) - tổ nhỏ, nhóm nhỏ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '小组'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('小组', 'xiǎozǔ', 'tổ nhỏ, nhóm nhỏ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiǎozǔ',
      meaning_vi = 'tổ nhỏ, nhóm nhỏ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '小组';
  END IF;

  -- [血] (xiě) - máu, huyết [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '血'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('血', 'xiě', 'máu, huyết', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiě',
      meaning_vi = 'máu, huyết',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '血';
  END IF;

  -- [心] (xīn) - tim, lòng, tâm trí [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '心'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('心', 'xīn', 'tim, lòng, tâm trí', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xīn',
      meaning_vi = 'tim, lòng, tâm trí',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '心';
  END IF;

  -- [信号] (xìnhào) - tín hiệu, sóng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '信号'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('信号', 'xìnhào', 'tín hiệu, sóng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xìnhào',
      meaning_vi = 'tín hiệu, sóng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '信号';
  END IF;

  -- [星星] (xīngxing) - ngôi sao [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '星星'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('星星', 'xīngxing', 'ngôi sao', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xīngxing',
      meaning_vi = 'ngôi sao',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '星星';
  END IF;

  -- [性] (xìng) - tính chất, tính cách [Hậu tố / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '性'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('性', 'xìng', 'tính chất, tính cách', 'Hậu tố / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xìng',
      meaning_vi = 'tính chất, tính cách',
      word_type = 'Hậu tố / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '性';
  END IF;

  -- [兄弟] (xiōngdì) - anh em, huynh đệ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '兄弟'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('兄弟', 'xiōngdì', 'anh em, huynh đệ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiōngdì',
      meaning_vi = 'anh em, huynh đệ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '兄弟';
  END IF;

  -- [熊] (xióng) - con gấu [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '熊'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('熊', 'xióng', 'con gấu', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xióng',
      meaning_vi = 'con gấu',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '熊';
  END IF;

  -- [修] (xiū) - sửa chữa, tu bổ [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '修'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('修', 'xiū', 'sửa chữa, tu bổ', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xiū',
      meaning_vi = 'sửa chữa, tu bổ',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '修';
  END IF;

  -- [学费] (xuéfèi) - học phí [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '学费'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('学费', 'xuéfèi', 'học phí', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xuéfèi',
      meaning_vi = 'học phí',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '学费';
  END IF;

  -- [学院] (xuéyuàn) - học viện, trường đại học thành viên [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '学院'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('学院', 'xuéyuàn', 'học viện, trường đại học thành viên', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'xuéyuàn',
      meaning_vi = 'học viện, trường đại học thành viên',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '学院';
  END IF;

  -- [压] (yā) - đè, ấn, nén, áp lực [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '压'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('压', 'yā', 'đè, ấn, nén, áp lực', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yā',
      meaning_vi = 'đè, ấn, nén, áp lực',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '压';
  END IF;

  -- [烟] (yān) - khói; thuốc lá [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '烟'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('烟', 'yān', 'khói; thuốc lá', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yān',
      meaning_vi = 'khói; thuốc lá',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '烟';
  END IF;

  -- [研究生] (yánjiūshēng) - nghiên cứu sinh, học viên cao học [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '研究生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('研究生', 'yánjiūshēng', 'nghiên cứu sinh, học viên cao học', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yánjiūshēng',
      meaning_vi = 'nghiên cứu sinh, học viên cao học',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '研究生';
  END IF;

  -- [演] (yǎn) - diễn xuất, biểu diễn [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '演'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('演', 'yǎn', 'diễn xuất, biểu diễn', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yǎn',
      meaning_vi = 'diễn xuất, biểu diễn',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '演';
  END IF;

  -- [演唱] (yǎnchàng) - hát, biểu diễn ca khúc [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '演唱'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('演唱', 'yǎnchàng', 'hát, biểu diễn ca khúc', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yǎnchàng',
      meaning_vi = 'hát, biểu diễn ca khúc',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '演唱';
  END IF;

  -- [眼前] (yǎnqián) - trước mắt, hiện tại [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '眼前'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('眼前', 'yǎnqián', 'trước mắt, hiện tại', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yǎnqián',
      meaning_vi = 'trước mắt, hiện tại',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '眼前';
  END IF;

  -- [夜] (yè) - đêm [Danh từ / Lượng từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '夜'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('夜', 'yè', 'đêm', 'Danh từ / Lượng từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yè',
      meaning_vi = 'đêm',
      word_type = 'Danh từ / Lượng từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '夜';
  END IF;

  -- [夜晚] (yèwǎn) - buổi đêm, ban đêm [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '夜晚'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('夜晚', 'yèwǎn', 'buổi đêm, ban đêm', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yèwǎn',
      meaning_vi = 'buổi đêm, ban đêm',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '夜晚';
  END IF;

  -- [已] (yǐ) - đã [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '已'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('已', 'yǐ', 'đã', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yǐ',
      meaning_vi = 'đã',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '已';
  END IF;

  -- [以内] (yǐnèi) - trong vòng, trong khoảng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '以内'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('以内', 'yǐnèi', 'trong vòng, trong khoảng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yǐnèi',
      meaning_vi = 'trong vòng, trong khoảng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '以内';
  END IF;

  -- [一生] (yìshēng) - cả đời, một đời [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '一生'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('一生', 'yìshēng', 'cả đời, một đời', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yìshēng',
      meaning_vi = 'cả đời, một đời',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '一生';
  END IF;

  -- [赢得] (yíngdé) - giành được, thắng được [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赢得'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('赢得', 'yíngdé', 'giành được, thắng được', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yíngdé',
      meaning_vi = 'giành được, thắng được',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '赢得';
  END IF;

  -- [用来] (yònglái) - dùng để, được dùng vào việc [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '用来'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('用来', 'yònglái', 'dùng để, được dùng vào việc', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yònglái',
      meaning_vi = 'dùng để, được dùng vào việc',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '用来';
  END IF;

  -- [用于] (yòngyú) - dùng cho, áp dụng cho [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '用于'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('用于', 'yòngyú', 'dùng cho, áp dụng cho', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yòngyú',
      meaning_vi = 'dùng cho, áp dụng cho',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '用于';
  END IF;

  -- [油] (yóu) - dầu, mỡ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '油'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('油', 'yóu', 'dầu, mỡ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yóu',
      meaning_vi = 'dầu, mỡ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '油';
  END IF;

  -- [游玩] (yóuwán) - du ngoạn, đi chơi ngắm cảnh [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '游玩'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('游玩', 'yóuwán', 'du ngoạn, đi chơi ngắm cảnh', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yóuwán',
      meaning_vi = 'du ngoạn, đi chơi ngắm cảnh',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '游玩';
  END IF;

  -- [友情] (yǒuqíng) - tình bạn, hữu nghị [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '友情'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('友情', 'yǒuqíng', 'tình bạn, hữu nghị', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yǒuqíng',
      meaning_vi = 'tình bạn, hữu nghị',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '友情';
  END IF;

  -- [有效] (yǒuxiào) - có hiệu lực, hiệu quả [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '有效'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('有效', 'yǒuxiào', 'có hiệu lực, hiệu quả', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yǒuxiào',
      meaning_vi = 'có hiệu lực, hiệu quả',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '有效';
  END IF;

  -- [有着] (yǒuzhe) - có, sở hữu [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '有着'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('有着', 'yǒuzhe', 'có, sở hữu', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yǒuzhe',
      meaning_vi = 'có, sở hữu',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '有着';
  END IF;

  -- [远离] (yuǎnlí) - tránh xa, cách xa [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '远离'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('远离', 'yuǎnlí', 'tránh xa, cách xa', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yuǎnlí',
      meaning_vi = 'tránh xa, cách xa',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '远离';
  END IF;

  -- [院长] (yuànzhǎng) - viện trưởng, hiệu trưởng học viện [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '院长'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('院长', 'yuànzhǎng', 'viện trưởng, hiệu trưởng học viện', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yuànzhǎng',
      meaning_vi = 'viện trưởng, hiệu trưởng học viện',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '院长';
  END IF;

  -- [院子] (yuànzi) - sân, sân vườn [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '院子'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('院子', 'yuànzi', 'sân, sân vườn', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yuànzi',
      meaning_vi = 'sân, sân vườn',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '院子';
  END IF;

  -- [约] (yuē) - hẹn; ước chừng [Động từ / Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '约'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('约', 'yuē', 'hẹn; ước chừng', 'Động từ / Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yuē',
      meaning_vi = 'hẹn; ước chừng',
      word_type = 'Động từ / Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '约';
  END IF;

  -- [月饼] (yuèbing) - bánh trung thu [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '月饼'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('月饼', 'yuèbing', 'bánh trung thu', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yuèbing',
      meaning_vi = 'bánh trung thu',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '月饼';
  END IF;

  -- [月份] (yuèfèn) - tháng (trong năm) [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '月份'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('月份', 'yuèfèn', 'tháng (trong năm)', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'yuèfèn',
      meaning_vi = 'tháng (trong năm)',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '月份';
  END IF;

  -- [再次] (zàicì) - lần nữa, một lần nữa [Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '再次'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('再次', 'zàicì', 'lần nữa, một lần nữa', 'Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zàicì',
      meaning_vi = 'lần nữa, một lần nữa',
      word_type = 'Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '再次';
  END IF;

  -- [再说] (zàishuō) - nói sau; hơn nữa [Động từ / Liên từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '再说'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('再说', 'zàishuō', 'nói sau; hơn nữa', 'Động từ / Liên từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zàishuō',
      meaning_vi = 'nói sau; hơn nữa',
      word_type = 'Động từ / Liên từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '再说';
  END IF;

  -- [暂停] (zàntíng) - tạm dừng, tạm hoãn [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '暂停'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('暂停', 'zàntíng', 'tạm dừng, tạm hoãn', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zàntíng',
      meaning_vi = 'tạm dừng, tạm hoãn',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '暂停';
  END IF;

  -- [早餐] (zǎocān) - bữa sáng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '早餐'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('早餐', 'zǎocān', 'bữa sáng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zǎocān',
      meaning_vi = 'bữa sáng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '早餐';
  END IF;

  -- [早晨] (zǎochen) - sáng sớm [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '早晨'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('早晨', 'zǎochen', 'sáng sớm', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zǎochen',
      meaning_vi = 'sáng sớm',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '早晨';
  END IF;

  -- [增长] (zēngzhǎng) - tăng trưởng, tăng lên [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '增长'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('增长', 'zēngzhǎng', 'tăng trưởng, tăng lên', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zēngzhǎng',
      meaning_vi = 'tăng trưởng, tăng lên',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '增长';
  END IF;

  -- [着] (zháo) - chạm vào, trúng; mắc phải [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '着'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('着', 'zháo', 'chạm vào, trúng; mắc phải', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zháo',
      meaning_vi = 'chạm vào, trúng; mắc phải',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '着';
  END IF;

  -- [着火] (zháohuǒ) - bốc cháy, bén lửa [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '着火'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('着火', 'zháohuǒ', 'bốc cháy, bén lửa', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zháohuǒ',
      meaning_vi = 'bốc cháy, bén lửa',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '着火';
  END IF;

  -- [者] (zhě) - người, kẻ (hậu tố chỉ người) [Hậu tố / Trợ từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '者'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('者', 'zhě', 'người, kẻ (hậu tố chỉ người)', 'Hậu tố / Trợ từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhě',
      meaning_vi = 'người, kẻ (hậu tố chỉ người)',
      word_type = 'Hậu tố / Trợ từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '者';
  END IF;

  -- [整] (zhěng) - nguyên vẹn, trọn, chẵn [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '整'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('整', 'zhěng', 'nguyên vẹn, trọn, chẵn', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhěng',
      meaning_vi = 'nguyên vẹn, trọn, chẵn',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '整';
  END IF;

  -- [整个] (zhěnggè) - toàn bộ, cả [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '整个'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('整个', 'zhěnggè', 'toàn bộ, cả', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhěnggè',
      meaning_vi = 'toàn bộ, cả',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '整个';
  END IF;

  -- [证] (zhèng) - giấy tờ, chứng chỉ, bằng [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '证'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('证', 'zhèng', 'giấy tờ, chứng chỉ, bằng', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhèng',
      meaning_vi = 'giấy tờ, chứng chỉ, bằng',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '证';
  END IF;

  -- [证件] (zhèngjiàn) - giấy tờ tùy thân [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '证件'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('证件', 'zhèngjiàn', 'giấy tờ tùy thân', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhèngjiàn',
      meaning_vi = 'giấy tờ tùy thân',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '证件';
  END IF;

  -- [支付] (zhīfù) - thanh toán, chi trả [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '支付'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('支付', 'zhīfù', 'thanh toán, chi trả', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhīfù',
      meaning_vi = 'thanh toán, chi trả',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '支付';
  END IF;

  -- [之后] (zhīhòu) - sau đó, sau khi [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '之后'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('之后', 'zhīhòu', 'sau đó, sau khi', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhīhòu',
      meaning_vi = 'sau đó, sau khi',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '之后';
  END IF;

  -- [之间] (zhījiān) - ở giữa, giữa [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '之间'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('之间', 'zhījiān', 'ở giữa, giữa', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhījiān',
      meaning_vi = 'ở giữa, giữa',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '之间';
  END IF;

  -- [之前] (zhīqián) - trước đó, trước khi [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '之前'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('之前', 'zhīqián', 'trước đó, trước khi', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhīqián',
      meaning_vi = 'trước đó, trước khi',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '之前';
  END IF;

  -- [之中] (zhīzhōng) - trong đó, ở giữa [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '之中'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('之中', 'zhīzhōng', 'trong đó, ở giữa', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhīzhōng',
      meaning_vi = 'trong đó, ở giữa',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '之中';
  END IF;

  -- [值] (zhí) - đáng giá; trị giá [Động từ / Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '值'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('值', 'zhí', 'đáng giá; trị giá', 'Động từ / Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhí',
      meaning_vi = 'đáng giá; trị giá',
      word_type = 'Động từ / Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '值';
  END IF;

  -- [指出] (zhǐchū) - chỉ ra, vạch rõ [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '指出'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('指出', 'zhǐchū', 'chỉ ra, vạch rõ', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhǐchū',
      meaning_vi = 'chỉ ra, vạch rõ',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '指出';
  END IF;

  -- [纸巾] (zhǐjīn) - khăn giấy [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '纸巾'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('纸巾', 'zhǐjīn', 'khăn giấy', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhǐjīn',
      meaning_vi = 'khăn giấy',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '纸巾';
  END IF;

  -- [中餐] (zhōngcān) - món ăn Trung Hoa, cơm Trung [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '中餐'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('中餐', 'zhōngcān', 'món ăn Trung Hoa, cơm Trung', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhōngcān',
      meaning_vi = 'món ăn Trung Hoa, cơm Trung',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '中餐';
  END IF;

  -- [中年] (zhōngnián) - trung niên [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '中年'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('中年', 'zhōngnián', 'trung niên', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhōngnián',
      meaning_vi = 'trung niên',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '中年';
  END IF;

  -- [种] (zhòng) - trồng (cây, hoa) [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '种'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('种', 'zhòng', 'trồng (cây, hoa)', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhòng',
      meaning_vi = 'trồng (cây, hoa)',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '种';
  END IF;

  -- [祝] (zhù) - chúc, cầu chúc [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '祝'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('祝', 'zhù', 'chúc, cầu chúc', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhù',
      meaning_vi = 'chúc, cầu chúc',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '祝';
  END IF;

  -- [转发] (zhuǎnfā) - chuyển tiếp, chia sẻ lại [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '转发'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('转发', 'zhuǎnfā', 'chuyển tiếp, chia sẻ lại', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhuǎnfā',
      meaning_vi = 'chuyển tiếp, chia sẻ lại',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '转发';
  END IF;

  -- [转机] (zhuǎnjī) - chuyển máy bay, quá cảnh [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '转机'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('转机', 'zhuǎnjī', 'chuyển máy bay, quá cảnh', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhuǎnjī',
      meaning_vi = 'chuyển máy bay, quá cảnh',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '转机';
  END IF;

  -- [装] (zhuāng) - lắp đặt; đóng gói; giả vờ [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '装'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('装', 'zhuāng', 'lắp đặt; đóng gói; giả vờ', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhuāng',
      meaning_vi = 'lắp đặt; đóng gói; giả vờ',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '装';
  END IF;

  -- [准] (zhǔn) - chuẩn xác, đúng đắn [Tính từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '准'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('准', 'zhǔn', 'chuẩn xác, đúng đắn', 'Tính từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zhǔn',
      meaning_vi = 'chuẩn xác, đúng đắn',
      word_type = 'Tính từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '准';
  END IF;

  -- [资料] (zīliào) - tư liệu, tài liệu, dữ liệu [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '资料'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('资料', 'zīliào', 'tư liệu, tài liệu, dữ liệu', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zīliào',
      meaning_vi = 'tư liệu, tài liệu, dữ liệu',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '资料';
  END IF;

  -- [自] (zì) - từ, tự [Giới từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '自'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('自', 'zì', 'từ, tự', 'Giới từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zì',
      meaning_vi = 'từ, tự',
      word_type = 'Giới từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '自';
  END IF;

  -- [自习] (zìxí) - tự học; giờ tự học [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '自习'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('自习', 'zìxí', 'tự học; giờ tự học', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zìxí',
      meaning_vi = 'tự học; giờ tự học',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '自习';
  END IF;

  -- [自学] (zìxué) - tự học tập [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '自学'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('自学', 'zìxué', 'tự học tập', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zìxué',
      meaning_vi = 'tự học tập',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '自学';
  END IF;

  -- [组] (zǔ) - nhóm, tổ [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '组'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('组', 'zǔ', 'nhóm, tổ', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zǔ',
      meaning_vi = 'nhóm, tổ',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '组';
  END IF;

  -- [最终] (zuìzhōng) - cuối cùng, rốt cuộc [Danh từ / Phó từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '最终'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('最终', 'zuìzhōng', 'cuối cùng, rốt cuộc', 'Danh từ / Phó từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zuìzhōng',
      meaning_vi = 'cuối cùng, rốt cuộc',
      word_type = 'Danh từ / Phó từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '最终';
  END IF;

  -- [做法] (zuòfǎ) - cách làm, phương pháp làm [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '做法'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('做法', 'zuòfǎ', 'cách làm, phương pháp làm', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zuòfǎ',
      meaning_vi = 'cách làm, phương pháp làm',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '做法';
  END IF;

  -- [做梦] (zuòmèng) - nằm mơ, mơ mộng [Động từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '做梦'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('做梦', 'zuòmèng', 'nằm mơ, mơ mộng', 'Động từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zuòmèng',
      meaning_vi = 'nằm mơ, mơ mộng',
      word_type = 'Động từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '做梦';
  END IF;

  -- [作品] (zuòpǐn) - tác phẩm [Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '作品'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('作品', 'zuòpǐn', 'tác phẩm', 'Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zuòpǐn',
      meaning_vi = 'tác phẩm',
      word_type = 'Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '作品';
  END IF;

  -- [作为] (zuòwéi) - với tư cách là; coi như [Động từ / Giới từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '作为'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('作为', 'zuòwéi', 'với tư cách là; coi như', 'Động từ / Giới từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zuòwéi',
      meaning_vi = 'với tư cách là; coi như',
      word_type = 'Động từ / Giới từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '作为';
  END IF;

  -- [作文] (zuòwén) - viết văn; bài văn, bài luận [Động từ / Danh từ]
  IF NOT EXISTS (
    SELECT 1 FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '作文'
  ) THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level)
    VALUES ('作文', 'zuòwén', 'viết văn; bài văn, bài luận', 'Động từ / Danh từ', 'HSK 4');
    v_count := v_count + 1;
  ELSE
    UPDATE public.vocabularies
    SET 
      pinyin = 'zuòwén',
      meaning_vi = 'viết văn; bài văn, bài luận',
      word_type = 'Động từ / Danh từ'
    WHERE hsk_level = 'HSK 4' AND hanzi = '作文';
  END IF;

  RAISE NOTICE 'Hoàn thành nạp bổ sung % từ vựng mới HSK 4 (Đạt chuẩn 1.000 từ HSK 3.0)!', v_count;
END $$;
