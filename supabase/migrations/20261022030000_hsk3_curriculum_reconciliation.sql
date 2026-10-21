-- ====================================================================
-- MIGRATION: ĐỒNG BỘ TOÀN DIỆN LỘ TRÌNH 24 BÀI HỌC HSK 3 (514 TỪ CHUẨN HSK 3.0)
-- 1. Cập nhật 24 bài học hệ thống hiện có vào public.lessons
-- 2. Liên kết toàn bộ 514 từ vựng HSK 3 vào bài học qua lesson_vocabularies (21-22 từ/bài)
-- Tuyệt đối bảo toàn 100% tiến độ người dùng trong user_vocabularies!
-- ====================================================================

DO $$
BEGIN
  -- ------------------------------------------------------------------
  -- BƯỚC 1: CẬP NHẬT HOẶC CHÈN 24 BÀI HỌC HSK 3 VÀO PUBLIC.LESSONS
  -- ------------------------------------------------------------------
  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('c2f534da-0171-4382-9173-e18d7f6913be', 'Bài 1 - Bốn mùa và Thế giới xung quanh', 'Từ vựng về thời tiết, các mùa trong năm và môi trường tự nhiên.', 'HSK 3', 1, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('02025cad-9dbc-4b98-b7b0-693223b43f23', 'Bài 2 - Đường đi và Di chuyển', 'Các từ chỉ phương hướng, vị trí và phương tiện giao thông.', 'HSK 3', 2, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('dbefe8b2-57ca-4f0d-b2a1-00f756ffca90', 'Bài 3 - Con người và Ngoại hình', 'Miêu tả ngoại hình, các mối quan hệ người thân và xã hội.', 'HSK 3', 3, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('3e17e9a4-9bc5-4fbf-be33-52aa29ed2ca3', 'Bài 4 - Nhịp sống gia đình', 'Sinh hoạt hàng ngày, đồ dùng gia đình và môi trường sống.', 'HSK 3', 4, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('537858c0-24e1-4eeb-ac09-89657d44a231', 'Bài 5 - Sức khỏe và Cảm xúc', 'Diễn tả trạng thái sức khỏe thể chất, tâm lý và cảm xúc.', 'HSK 3', 5, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('219d0d0c-6d2f-4822-a0d9-99177dad8fb9', 'Bài 6 - Trường học và Tri thức', 'Từ vựng liên quan đến trường lớp, các môn học và học tập.', 'HSK 3', 6, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('5d1b9784-789a-4e98-9936-f76504ca35d6', 'Bài 7 - Công sở và Giải quyết công việc', 'Môi trường làm việc văn phòng, hội họp và các kế hoạch công việc.', 'HSK 3', 7, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('d9d45e1d-7aac-489a-87aa-53e8217de123', 'Bài 8 - Mua sắm và Số lượng', 'Từ vựng về tiền tệ, thanh toán và các lượng từ thông dụng.', 'HSK 3', 8, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('06019ce8-33cc-4de3-b0f3-ee6fa2207549', 'Bài 9 - Hành động và Công nghệ', 'Các thao tác hàng ngày, trao đổi thông tin và tương tác kỹ thuật số.', 'HSK 3', 9, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('36d52868-61d9-4cdb-be4a-ebab774d587c', 'Bài 10 - Thời gian và Tần suất', 'Cách diễn đạt mốc thời gian, khoảng thời gian và mức độ thường xuyên.', 'HSK 3', 10, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('ae69c037-5b81-4cf6-956b-1af8080dede2', 'Bài 11 - Thái độ và Quan điểm', 'Các phó từ và động từ năng nguyện thể hiện nhận định, thái độ.', 'HSK 3', 11, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('b7a0b790-f408-423b-bb48-fb1a29e9f917', 'Bài 12 - Liên kết câu và Ngữ pháp nâng cao', 'Các liên từ logic, giới từ và hư từ cấu trúc câu thông dụng trong HSK 3.', 'HSK 3', 12, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('e67fea6d-6aa8-4c0a-82f2-90f61df7698c', 'Bài 13 - Diện mạo và cơ thể', 'Mô tả đặc điểm ngoại hình và các bộ phận trên cơ thể người', 'HSK 3', 13, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('d7cc2058-fefd-4d8c-8574-fd550d4f3989', 'Bài 14 - Sức khỏe và sinh hoạt', 'Nói về cảm giác thể chất, sức khỏe và thói quen sinh hoạt cá nhân', 'HSK 3', 14, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('3553e060-586f-48e8-be34-ef1929906a3b', 'Bài 15 - Gia đình và giao tiếp', 'Từ vựng về người thân, hàng xóm và các hoạt động tương tác, kết nối', 'HSK 3', 15, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('8a0165b3-c246-49e6-b484-d71544c037ac', 'Bài 16 - Ẩm thực và bàn ăn', 'Khám phá các món ăn, đồ uống và vật dụng quen thuộc trong bữa ăn', 'HSK 3', 16, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('9dd561d5-1686-4279-ae16-466904a6c4ea', 'Bài 17 - Mua sắm và trang phục', 'Từ vựng về quần áo, phụ kiện và các hoạt động mua bán, giao dịch', 'HSK 3', 17, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('50b7d855-cc5c-4bce-a1ad-490425ebd4eb', 'Bài 18 - Nhà cửa và đồ dùng', 'Không gian sống, trang thiết bị gia đình và vật dụng tiện ích', 'HSK 3', 18, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('0ef98f91-5055-41fb-ab9e-3f5c31d92bfc', 'Bài 19 - Thiên nhiên và muôn loài', 'Từ vựng về cảnh sắc tự nhiên, thế giới động vật và màu sắc', 'HSK 3', 19, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('5ba76d92-f1c5-44d6-b17a-37e1fe37bd39', 'Bài 20 - Giao thông và di chuyển', 'Phương tiện giao thông, địa điểm và những trải nghiệm trên đường đi', 'HSK 3', 20, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('56e35db1-d007-43f1-8944-f6069fe5e8d6', 'Bài 21 - Học tập và công sở', 'Môi trường trường học, công ty và cách xử lý công việc hằng ngày', 'HSK 3', 21, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('64f69c26-44e8-4b8d-93fb-596998551e1b', 'Bài 22 - Sở thích và giải trí', 'Các hoạt động thư giãn, văn hóa nghệ thuật, thể thao và lễ hội', 'HSK 3', 22, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('7c700bc6-c8d7-411a-ad6f-24c0695cfa6c', 'Bài 23 - Cảm xúc và nhận định', 'Bày tỏ tâm trạng, quan điểm cá nhân và mức độ so sánh', 'HSK 3', 23, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('fea02b1f-1cd4-4234-8523-75f55399d0c0', 'Bài 24 - Thời gian và liên từ logic', 'Trạng từ chỉ thời gian, tần suất và các liên từ kết nối câu thông dụng', 'HSK 3', 24, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  -- ------------------------------------------------------------------
  -- BƯỚC 2: DỌN DẸP VÀ TÁI LIÊN KẾT BẢNG NỐI LESSON_VOCABULARIES CHO 24 BÀI HSK 3
  -- ------------------------------------------------------------------
  DELETE FROM public.lesson_vocabularies
  WHERE lesson_id IN ('c2f534da-0171-4382-9173-e18d7f6913be', '02025cad-9dbc-4b98-b7b0-693223b43f23', 'dbefe8b2-57ca-4f0d-b2a1-00f756ffca90', '3e17e9a4-9bc5-4fbf-be33-52aa29ed2ca3', '537858c0-24e1-4eeb-ac09-89657d44a231', '219d0d0c-6d2f-4822-a0d9-99177dad8fb9', '5d1b9784-789a-4e98-9936-f76504ca35d6', 'd9d45e1d-7aac-489a-87aa-53e8217de123', '06019ce8-33cc-4de3-b0f3-ee6fa2207549', '36d52868-61d9-4cdb-be4a-ebab774d587c', 'ae69c037-5b81-4cf6-956b-1af8080dede2', 'b7a0b790-f408-423b-bb48-fb1a29e9f917', 'e67fea6d-6aa8-4c0a-82f2-90f61df7698c', 'd7cc2058-fefd-4d8c-8574-fd550d4f3989', '3553e060-586f-48e8-be34-ef1929906a3b', '8a0165b3-c246-49e6-b484-d71544c037ac', '9dd561d5-1686-4279-ae16-466904a6c4ea', '50b7d855-cc5c-4bce-a1ad-490425ebd4eb', '0ef98f91-5055-41fb-ab9e-3f5c31d92bfc', '5ba76d92-f1c5-44d6-b17a-37e1fe37bd39', '56e35db1-d007-43f1-8944-f6069fe5e8d6', '64f69c26-44e8-4b8d-93fb-596998551e1b', '7c700bc6-c8d7-411a-ad6f-24c0695cfa6c', 'fea02b1f-1cd4-4234-8523-75f55399d0c0');

  -- Bài 1: Bài 1 - Bốn mùa và Thế giới xung quanh (22 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'c2f534da-0171-4382-9173-e18d7f6913be',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('动物', '国家', '地方', '春', '城市', '太阳', '地图', '世界', '季节', '夏', '刮风', '冬', '比如', '春天', '东北', '东方', '东南', '冬天', '风', '刮', '或', '季');

  -- Bài 2: Bài 2 - Đường đi và Di chuyển (22 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '02025cad-9dbc-4b98-b7b0-693223b43f23',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('东', '公园', '北方', '中间', '搬', '护照', '南', '司机', '向', '伞', '方便', '搬家', '北', '方向', '画家', '楼梯', '南方', '男人', '男生', '身边', '西北', '西方');

  -- Bài 3: Bài 3 - Con người và Ngoại hình (22 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'dbefe8b2-57ca-4f0d-b2a1-00f756ffca90',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('同事', '嘴', '客人', '头发', '像', '可爱', '叔叔', '年轻', '别人', '声音', '爱人', '病人', '宾馆', '大人', '动物园', '老人', '名单', '名人', '声', '游客', '员', '咱们');

  -- Bài 4: Bài 4 - Nhịp sống gia đình (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '3e17e9a4-9bc5-4fbf-be33-52aa29ed2ca3',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('刷牙', '习惯', '旧', '新鲜', '安静', '冰箱', '周末', '打扫', '啤酒', '干净', '冰激凌', '出院', '懂得', '服务', '黄色', '牛', '扫', '刷', '牙刷', '直到', '脏');

  -- Bài 5: Bài 5 - Sức khỏe và Cảm xúc (22 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '537858c0-24e1-4eeb-ac09-89657d44a231',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('感冒', '变化', '奇怪', '害怕', '小心', '健康', '哭', '关心', '放心', '发烧', '担心', '体育', '大概', '大衣', '对话', '封', '关机', '还', '花园', '开花', '开机', '课本');

  -- Bài 6: Bài 6 - Trường học và Tri thức (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '219d0d0c-6d2f-4822-a0d9-99177dad8fb9',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('复习', '年级', '数学', '历史', '成绩', '提高', '故事', '图书馆', '文化', '句子', '作业', '初中', '短裤', '干', '记', '句', '沙发', '外语', '学期', '养', '收');

  -- Bài 7: Bài 7 - Công sở và Giải quyết công việc (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '5d1b9784-789a-4e98-9936-f76504ca35d6',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('关系', '同意', '了解', '参加', '办公室', '回答', '影响', '完成', '会议', '努力', '办法', '打算', '决定', '帮助', '会', '女人', '山', '受', '受到', '晚会', '怕');

  -- Bài 8: Bài 8 - Mua sắm và Số lượng (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'd9d45e1d-7aac-489a-87aa-53e8217de123',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('张', '层', '换', '信用卡', '借', '公斤', '一共', '双', '安全', '报纸', '不见', '出生', '方便面', '感到', '鸡', '卡', '毛', '箱子', '鞋', '银行卡', '纸');

  -- Bài 9: Bài 9 - Hành động và Công nghệ (22 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '06019ce8-33cc-4de3-b0f3-ee6fa2207549',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('发现', '新闻', '感兴趣', '放', '关', '带', '明白', '忘记', '接', '发', '常', '到处', '的话', '工作日', '加', '女生', '勺子', '网站', '信', '兴趣', '邮件', '邮箱');

  -- Bài 10: Bài 10 - Thời gian và Tần suất (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '36d52868-61d9-4cdb-be4a-ebab774d587c',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('久', '刻', '后来', '几乎', '刚才', '一般', '差', '以前', '总是', '一直', '半天', '不久', '不行', '刚', '刚刚', '好久', '身高', '选', '以后', '中', '总');

  -- Bài 11: Bài 11 - Thái độ và Quan điểm (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'ae69c037-5b81-4cf6-956b-1af8080dede2',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('当然', '必须', '愿意', '其实', '应该', '一样', '一定', '容易', '其他', '主要', '不同', '大小', '该', '坚持', '爬', '市', '以为', '园', '夏天', '只是');

  -- Từ đặc biệt phân biệt đa âm [得] (dé)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'ae69c037-5b81-4cf6-956b-1af8080dede2',
    v.id,
    99,
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi = '得' AND v.pinyin = 'dé';

  -- Bài 12: Bài 12 - Liên kết câu và Ngữ pháp nâng cao (22 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'b7a0b790-f408-423b-bb48-fb1a29e9f917',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('为', '先', '把', '一边', '地', '如果', '只有……才……', '又', '或者', '为了', '关于', '不但……而且……', '不但', '而且', '检票', '可', '可是', '面前', '前年', '前天', '新年', '只');

  -- Bài 13: Bài 13 - Diện mạo và cơ thể (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'e67fea6d-6aa8-4c0a-82f2-90f61df7698c',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('短', '脚', '瘦', '胖', '矮', '聪明', '老', '腿', '耳朵', '长', '脸', '遍', '耳机', '关注', '假期', '路口', '难听', '起', '牙', '生活', '心里');

  -- Bài 14: Bài 14 - Sức khỏe và sinh hoạt (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'd7cc2058-fefd-4d8c-8574-fd550d4f3989',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('饿', '渴', '洗澡', '照顾', '锻炼', '检查', '饱', '请假', '变', '变成', '查', '得分', '方法', '放假', '姐妹', '练', '外卖', '休假', '怎么办', '住院', '秋天');

  -- Bài 15: Bài 15 - Gia đình và giao tiếp (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '3553e060-586f-48e8-be34-ef1929906a3b',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('邻居', '欢迎', '相信', '见面', '讲', '聊天', '热情', '结婚', '阿姨', '表演', '常见', '电', '放学', '过节', '斤', '聊', '聊天儿', '听说', '语言', '只有', '西南');

  -- Bài 16: Bài 16 - Ẩm thực và bàn ăn (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '8a0165b3-c246-49e6-b484-d71544c037ac',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('饮料', '瓶子', '米', '香蕉', '甜', '筷子', '菜单', '蛋糕', '碗', '盘子', '常常', '电子书', '发生', '高铁', '街', '路边', '马路', '平时', '糖', '西瓜', '做客');

  -- Bài 17: Bài 17 - Mua sắm và trang phục (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '9dd561d5-1686-4279-ae16-466904a6c4ea',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('礼物', '试', '银行', '角', '简单', '用', '种', '裙子', '衬衫', '冰', '尝', '常用', '发展', '海', '酒', '铅笔', '卫生间', '页', '雨衣', '最好', '矿泉水');

  -- Bài 18: Bài 18 - Nhà cửa và đồ dùng (22 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '50b7d855-cc5c-4bce-a1ad-490425ebd4eb',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('环境', '清楚', '电梯', '笔记本', '词典', '照片', '空调', '照相机', '行李箱', '灯', '笔记', '地点', '房子', '号码', '红绿灯', '拍照', '室', '屋子', '相机', '洗衣机', '照', '照相');

  -- Bài 19: Bài 19 - Thiên nhiên và muôn loài (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '0ef98f91-5055-41fb-ab9e-3f5c31d92bfc',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('月亮', '秋', '马', '有名', '树', '西', '熊猫', '蓝', '草', '黄河', '绿', '草地', '大熊猫', '好像', '开会', '汽车', '小区', '羊', '怎样', '四季', '只能');

  -- Bài 20: Bài 20 - Giao thông và di chuyển (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '5ba76d92-f1c5-44d6-b17a-37e1fe37bd39',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('自行车', '遇到', '离开', '站', '经过', '船', '辆', '骑', '起飞', '附近', '过去', '差不多', '分开', '河', '开心', '请客', '晚点', '有关', '遇见', '上衣', '字典');

  -- Bài 21: Bài 21 - Học tập và công sở (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '56e35db1-d007-43f1-8944-f6069fe5e8d6',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('校长', '留学', '经理', '选择', '电子邮件', '黑板', '机会', '练习', '要求', '迟到', '解决', '办', '班级', '合适', '看来', '留学生', '校园', '有用', '子', '只要', '运动员');

  -- Bài 22: Bài 22 - Sở thích và giải trí (22 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '64f69c26-44e8-4b8d-93fb-596998551e1b',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('音乐', '爬山', '节目', '认真', '游戏', '水平', '满意', '注意', '节日', '比赛', '出发', '丢', '夫妻', '后年', '节', '球场', '跳', '体育馆', '网球', '喜爱', '羽毛球', '运动会');

  -- Bài 23: Bài 23 - Cảm xúc và nhận định (23 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '7c700bc6-c8d7-411a-ad6f-24c0695cfa6c',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('重要', '难过', '极', '需要', '生气', '认为', '特别', '难', '着急', '比较', '更', '别的', '不用', '得到', '好多', '急', '课文', '凉快', '难看', '难题', '收到', '挺', '外地');

  -- Bài 24: Bài 24 - Thời gian và liên từ logic (21 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'fea02b1f-1cd4-4234-8523-75f55399d0c0',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN ('被', '除了', '然后', '结束', '突然', '马上', '最近', '越', '根据', '终于', '段', '最后', '后天', '来自', '认得', '行李', '一块儿', '以上', '以外', '以下');

  -- Từ đặc biệt phân biệt đa âm [得] (děi)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'fea02b1f-1cd4-4234-8523-75f55399d0c0',
    v.id,
    99,
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi = '得' AND v.pinyin = 'děi';

  RAISE NOTICE 'Hoàn tất đồng bộ 24 bài học HSK 3 với 514 từ vựng chuẩn HSK 3.0!';
END $$;
