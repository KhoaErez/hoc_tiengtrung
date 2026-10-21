-- ====================================================================
-- MIGRATION: ĐỒNG BỘ TOÀN DIỆN LỘ TRÌNH 12 BÀI HỌC HSK 2 (207 TỪ CHUẨN HSK 3.0)
-- 1. Cập nhật 11 bài học hiện có + thêm Bài 12 (Tổng 12 bài học)
-- 2. Liên kết toàn bộ 207 từ vựng HSK 2 vào bài học qua lesson_vocabularies
-- Tuyệt đối bảo toàn 100% tiến độ người dùng trong user_vocabularies!
-- ====================================================================

DO $$
BEGIN
  -- ------------------------------------------------------------------
  -- BƯỚC 1: CẬP NHẬT HOẶC CHÈN 12 BÀI HỌC HSK 2 VÀO PUBLIC.LESSONS
  -- ------------------------------------------------------------------
  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('94443420-313c-488a-a679-4cdb900c8e61', 'Bài 1 - Gia đình và Xưng hô', 'Nói về ông bà, vợ chồng, trẻ em, tuổi thơ và các dịp đón tết sum vầy.', 'HSK 2', 1, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('77c2925c-545d-43af-9441-27b2e4b6d3e8', 'Bài 2 - Sức khỏe và Thói quen sinh hoạt', 'Mô tả sức khỏe, cảm giác thoải mái hay mệt mỏi, các bộ phận cơ thể và thăm khám mua thuốc.', 'HSK 2', 2, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('27a2b566-0586-4426-aa7d-c3737f8c4030', 'Bài 3 - Thể thao và Sở thích giải trí', 'Các môn thể thao bóng đá, bóng rổ, bơi lội, khiêu vũ và các hoạt động giải trí cuối tuần.', 'HSK 2', 3, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('dc81aac7-e1f9-4e8a-9900-7dfeb46acf29', 'Bài 4 - Ẩm thực và Bữa ăn', 'Tên các món thịt cá, mì sợi, đồ uống trà sữa cà phê và gọi món tại quán ăn.', 'HSK 2', 4, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('01045043-b59b-4cc3-a932-631a7c36cb79', 'Bài 5 - Mua sắm, Quần áo và Đồ dùng', 'Mua sắm tại trung tâm thương mại, màu sắc quần áo và các dụng cụ cá nhân.', 'HSK 2', 5, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('ca9c4149-a662-422c-9188-b5685b825b61', 'Bài 6 - Thời gian, Thời tiết và Số đếm', 'Diễn đạt tuần lễ, khoảnh khắc, thời tiết nắng râm, số đếm hàng vạn và tần suất.', 'HSK 2', 6, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('5d979021-4b47-45c9-9e18-43f45dbbc8a6', 'Bài 7 - Đi lại, Giao thông và Du lịch', 'Phương tiện xe buýt, tàu điện ngầm, taxi, máy bay và các chặng đường di chuyển.', 'HSK 2', 7, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('7e710dea-9862-403f-8f09-ab8031d0ca57', 'Bài 8 - Học tập, Thi cử và Lớp học', 'Trường học, lớp học, thi cử kiểm tra, học từ vựng và cùng bạn bè rèn luyện.', 'HSK 2', 8, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('b42f4801-bcb4-43df-9e7b-cac2499082a5', 'Bài 9 - Công việc, Giao tiếp và Công nghệ', 'Làm việc văn phòng, khách sạn, lướt web, thái độ lịch thiệp và ứng xử thường nhật.', 'HSK 2', 9, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('8e78386b-7dbd-4bc9-962a-101cf2119a66', 'Bài 10 - Phương hướng, Vị trí và Không gian', 'Phương hướng trước sau, trong ngoài, trái phải và các động tác tiến lùi di chuyển.', 'HSK 2', 10, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('80681700-a311-4b11-b4e7-8dfabb44dfd6', 'Bài 11 - Xu hướng, Biến chuyển và Miêu tả', 'Động từ xu hướng lên xuống qua lại, miêu tả chiều cao vóc dáng, so sánh và trạng thái.', 'HSK 2', 11, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('1a2b3c4d-0002-4000-8000-000000000012', 'Bài 12 - Phó từ, Liên từ và Trợ từ ngữ pháp', 'Cặp liên từ tuy... nhưng, vì... nên, trợ từ tiếp diễn và các cấu trúc ngữ pháp then chốt HSK 2.', 'HSK 2', 12, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  -- ------------------------------------------------------------------
  -- BƯỚC 2: DỌN DẸP VÀ TÁI LIÊN KẾT BẢNG NỐI LESSON_VOCABULARIES
  -- ------------------------------------------------------------------
  DELETE FROM public.lesson_vocabularies
  WHERE lesson_id IN ('94443420-313c-488a-a679-4cdb900c8e61', '77c2925c-545d-43af-9441-27b2e4b6d3e8', '27a2b566-0586-4426-aa7d-c3737f8c4030', 'dc81aac7-e1f9-4e8a-9900-7dfeb46acf29', '01045043-b59b-4cc3-a932-631a7c36cb79', 'ca9c4149-a662-422c-9188-b5685b825b61', '5d979021-4b47-45c9-9e18-43f45dbbc8a6', '7e710dea-9862-403f-8f09-ab8031d0ca57', 'b42f4801-bcb4-43df-9e7b-cac2499082a5', '8e78386b-7dbd-4bc9-962a-101cf2119a66', '80681700-a311-4b11-b4e7-8dfabb44dfd6', '1a2b3c4d-0002-4000-8000-000000000012');

  -- Bài 1 - Gia đình và Xưng hô (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '94443420-313c-488a-a679-4cdb900c8e61',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('爷爷', '奶奶', '丈夫', '妻子', '男孩儿', '女孩儿', '小孩儿', '小时候', '姓名', '姓', '自己', '过年', '名', '位', '生日', '送');

  -- Từ đặc biệt phân biệt đa âm / đa từ loại: [过] (guò)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '94443420-313c-488a-a679-4cdb900c8e61',
    v.id,
    99,
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi = '过' AND v.pinyin = 'guò';

  -- Bài 2 - Sức khỏe và Thói quen sinh hoạt (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '77c2925c-545d-43af-9441-27b2e4b6d3e8',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('身体', '舒服', '累', '疼', '眼睛', '手', '洗', '药', '药店', '床', '起来', '笑', '跑', '跑步', '走路', '动', '运动');

  -- Bài 3 - Thể thao và Sở thích giải trí (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '27a2b566-0586-4426-aa7d-c3737f8c4030',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('爱好', '踢', '足球', '踢足球', '篮球', '打', '打篮球', '球', '游', '游泳', '跳舞', '唱歌', '画', '花', '旅游', '快乐', '有意思');

  -- Bài 4 - Ẩm thực và Bữa ăn (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'dc81aac7-e1f9-4e8a-9900-7dfeb46acf29',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('饭馆', '羊肉', '肉', '鱼', '面条', '咖啡', '奶茶', '红茶', '绿茶', '点', '服务员', '拿', '错', '不错', '完', '洗手间', '门口');

  -- Bài 5 - Mua sắm, Quần áo và Đồ dùng (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '01045043-b59b-4cc3-a932-631a7c36cb79',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('商场', '门', '门票', '票', '裤子', '手表', '颜色', '红色', '黑色', '绿色', '白色', '包', '书包', '本子', '笔', '条', '准备');

  -- Bài 6 - Thời gian, Thời tiết và Số đếm (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'ca9c4149-a662-422c-9188-b5685b825b61',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('周', '时', '一会儿', '有时', '经常', '晴', '阴', '第一', '万', '次', '每', '离', '远', '近', '快', '慢', '已经', '快要');

  -- Bài 7 - Đi lại, Giao thông và Du lịch (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '5d979021-4b47-45c9-9e18-43f45dbbc8a6',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('路', '路上', '走', '车站', '火车站', '机场', '机票', '公共汽车', '公交车', '地铁', '打车', '站', '飞', '外国', '出来', '出去', '出门', '出国');

  -- Bài 8 - Học tập, Thi cử và Lớp học (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '7e710dea-9862-403f-8f09-ab8031d0ca57',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('班', '教室', '高中', '开学', '开始', '考', '考试', '题', '懂', '教', '词', '记得', '忘', '介绍', '事情', '告诉', '跟');

  -- Bài 9 - Công việc, Giao tiếp và Công nghệ (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'b42f4801-bcb4-43df-9e7b-cac2499082a5',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('酒店', '楼', '间', '打开', '帮', '帮忙', '让', '等', '希望', '上网', '网上', '不好意思', '没意思', '意思', '为什么', '可能', '正');

  -- Bài 10 - Phương hướng, Vị trí và Không gian (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '8e78386b-7dbd-4bc9-962a-101cf2119a66',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('前面', '后面', '旁边', '里面', '外面', '上面', '下面', '左', '左边', '右', '右边', '往', '进', '进来', '进去', '上来', '上去');

  -- Bài 11 - Xu hướng, Biến chuyển và Miêu tả (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '80681700-a311-4b11-b4e7-8dfabb44dfd6',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('下来', '下去', '过来', '过去', '回来', '回去', '出', '高', '个子', '长', '坏', '鸟', '最', '比', '那么', '那样', '这样');

  -- Bài 12 - Phó từ, Liên từ và Trợ từ ngữ pháp (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '1a2b3c4d-0002-4000-8000-000000000012',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN ('虽然', '但是', '虽然……但是……', '因为', '所以', '因为……所以……', '但', '还是', '一起', '就', '从', '从小', '这么', '啊', '着', '得', '地');

  -- Từ đặc biệt phân biệt đa âm / đa từ loại: [过] (guo)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '1a2b3c4d-0002-4000-8000-000000000012',
    v.id,
    99,
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi = '过' AND v.pinyin = 'guo';

  RAISE NOTICE 'Hoàn tất đồng bộ 12 bài học HSK 2 với 207 từ vựng chuẩn HSK 3.0!';
END $$;
