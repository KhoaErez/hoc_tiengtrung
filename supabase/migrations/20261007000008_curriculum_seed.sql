-- 1. Schema Migration cho Curriculum
ALTER TABLE public.lessons ALTER COLUMN user_id DROP NOT NULL;
ALTER TABLE public.lessons ALTER COLUMN original_text DROP NOT NULL;
ALTER TABLE public.lessons ADD COLUMN IF NOT EXISTS lesson_number integer;
ALTER TABLE public.lessons ADD COLUMN IF NOT EXISTS is_system boolean default false;
ALTER TABLE public.lesson_vocabularies ADD COLUMN IF NOT EXISTS sort_order integer;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Anyone can read system lessons.') THEN
    CREATE POLICY "Anyone can read system lessons." ON public.lessons FOR SELECT USING (is_system = true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Anyone can read system lesson_vocabularies.') THEN
    CREATE POLICY "Anyone can read system lesson_vocabularies." ON public.lesson_vocabularies FOR SELECT USING (EXISTS (SELECT 1 FROM public.lessons WHERE id = lesson_vocabularies.lesson_id AND is_system = true));
  END IF;
END $$;

-- 2. Xóa Curriculum cũ (nếu có) để seed lại
DELETE FROM public.lessons WHERE is_system = true;

-- 3. Data Insertion
INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('50e8242c-c6d2-40ba-b06c-0f64d83cbb08', 'Bài 1 - Xin chào và làm quen', 'Các mẫu câu chào hỏi, xưng hô và giới thiệu tên cơ bản.', 'HSK 1', 1, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '50e8242c-c6d2-40ba-b06c-0f64d83cbb08', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('你', '好', '我', '叫', '名字', '认识', '高兴', '是', '先生', '小姐', '谁', '什么', '吗', '呢');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('dca2dd56-3813-4e89-aca8-53f216e32dd4', 'Bài 2 - Gia đình và bạn bè', 'Nói về các thành viên trong gia đình, người thân và mối quan hệ.', 'HSK 1', 2, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'dca2dd56-3813-4e89-aca8-53f216e32dd4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('他', '她', '我们', '人', '家', '爸爸', '妈妈', '儿子', '女儿', '朋友', '岁', '的', '和');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7ae67e7b-d6e3-48ac-8167-0fd5caf4f596', 'Bài 3 - Chữ số và lượng từ', 'Chữ số cơ bản từ 1 đến 10 cùng các lượng từ thông dụng.', 'HSK 1', 3, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7ae67e7b-d6e3-48ac-8167-0fd5caf4f596', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '个', '几', '些', '多', '少', '块', '本');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('84dc955a-70c3-44d7-a669-c31daf2c622e', 'Bài 4 - Thời gian và lịch trình', 'Cách diễn đạt giờ giấc, các buổi trong ngày, thứ ngày tháng năm.', 'HSK 1', 4, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '84dc955a-70c3-44d7-a669-c31daf2c622e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('年', '月', '号', '星期', '今天', '明天', '昨天', '现在', '点', '分钟', '上午', '中午', '下午', '时候');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('15f0321b-860c-4d3d-9bd2-2fe0b30cce6b', 'Bài 5 - Trường học và học tập', 'Từ vựng về trường lớp, thầy cô, bạn bè và kỹ năng học tiếng Trung.', 'HSK 1', 5, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '15f0321b-860c-4d3d-9bd2-2fe0b30cce6b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('学校', '老师', '学生', '同学', '汉语', '学习', '字', '写', '读', '说', '听', '书', '看');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b8987ddc-b03b-4b50-a58b-21c536eaf4c3', 'Bài 6 - Mua sắm và đồ dùng', 'Hỏi giá cả, mua sắm đồ dùng cá nhân và thiết bị quen thuộc.', 'HSK 1', 6, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b8987ddc-b03b-4b50-a58b-21c536eaf4c3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('买', '钱', '多少', '东西', '衣服', '杯子', '电脑', '电视', '电影', '漂亮', '这', '那', '一点儿');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3ea59185-76c9-4b6b-8937-4db233831a05', 'Bài 7 - Ẩm thực và ăn uống', 'Tên các món ăn, đồ uống phổ biến và bày tỏ sở thích ẩm thực.', 'HSK 1', 7, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3ea59185-76c9-4b6b-8937-4db233831a05', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('吃', '喝', '茶', '水', '水果', '苹果', '米饭', '菜', '饭店', '喜欢', '想', '太', '很');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('344b0aa4-e686-44c8-969a-7304fa0b93ef', 'Bài 8 - Vị trí và địa điểm', 'Phương hướng, vị trí đồ vật và các địa điểm quen thuộc.', 'HSK 1', 8, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '344b0aa4-e686-44c8-969a-7304fa0b93ef', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('在', '哪儿', '哪', '中国', '北京', '商店', '医院', '上', '下', '前面', '后面', '里', '桌子', '椅子');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9f0805d0-b91d-44e1-8ff2-1248b16b9346', 'Bài 9 - Đi lại và công việc', 'Phương tiện giao thông, cách thức di chuyển và nghề nghiệp cơ bản.', 'HSK 1', 9, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9f0805d0-b91d-44e1-8ff2-1248b16b9346', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('去', '来', '回', '坐', '开', '飞机', '出租车', '怎么', '怎么样', '住', '工作', '医生');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d23fb015-f289-4eb8-ba8e-f93f56e8fb23', 'Bài 10 - Giao tiếp hàng ngày', 'Lời cảm ơn, xin lỗi, gọi điện thoại và nói về thú cưng.', 'HSK 1', 10, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd23fb015-f289-4eb8-ba8e-f93f56e8fb23', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('谢谢', '不客气', '对不起', '没关系', '再见', '请', '喂', '打电话', '狗', '猫', '爱', '做');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c2d7894d-9fcd-47ee-a6cf-04ef736902a0', 'Bài 11 - Thời tiết và trạng thái', 'Mô tả thời tiết, đặc điểm tính chất, khả năng và sự việc.', 'HSK 1', 11, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c2d7894d-9fcd-47ee-a6cf-04ef736902a0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('天气', '下雨', '热', '冷', '大', '小', '能', '会', '看见', '睡觉', '有', '没有', '不', '都', '了');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('94443420-313c-488a-a679-4cdb900c8e61', 'Bài 1 - Gia đình và Mối quan hệ', 'Các từ vựng về thành viên gia đình, đại từ xưng hô và giới tính.', 'HSK 2', 1, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '94443420-313c-488a-a679-4cdb900c8e61', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('丈夫', '妻子', '哥哥', '姐姐', '弟弟', '妹妹', '孩子', '大家', '您', '它', '男', '女', '姓');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('77c2925c-545d-43af-9441-27b2e4b6d3e8', 'Bài 2 - Sức khỏe và Thói quen sinh hoạt', 'Nói về nề nếp sinh hoạt hằng ngày, trạng thái cơ thể và sức khỏe.', 'HSK 2', 2, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '77c2925c-545d-43af-9441-27b2e4b6d3e8', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('起床', '休息', '生病', '身体', '药', '累', '洗', '穿', '眼睛', '笑', '快乐', '生日');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('27a2b566-0586-4426-aa7d-c3737f8c4030', 'Bài 3 - Thể thao và Giải trí', 'Các hoạt động rèn luyện thể chất, sở thích vui chơi và giải trí.', 'HSK 2', 3, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '27a2b566-0586-4426-aa7d-c3737f8c4030', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('运动', '跑步', '踢足球', '打篮球', '游泳', '唱歌', '跳舞', '玩', '旅游', '报纸', '一起');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('dc81aac7-e1f9-4e8a-9900-7dfeb46acf29', 'Bài 4 - Ẩm thực và Nhà hàng', 'Tên các món ăn, đồ uống thông dụng và giao tiếp khi đi ăn uống.', 'HSK 2', 4, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'dc81aac7-e1f9-4e8a-9900-7dfeb46acf29', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('羊肉', '鱼', '鸡蛋', '西瓜', '面条', '牛奶', '咖啡', '好吃', '服务员', '等', '一下');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('01045043-b59b-4cc3-a932-631a7c36cb79', 'Bài 5 - Mua sắm và Đồ dùng cá nhân', 'Từ vựng về mua bán, giá cả, màu sắc và đồ dùng thường ngày.', 'HSK 2', 5, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '01045043-b59b-4cc3-a932-631a7c36cb79', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('卖', '贵', '便宜', '件', '颜色', '红', '白', '黑', '新', '手机', '手表', '送', '找');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ca9c4149-a662-422c-9188-b5685b825b61', 'Bài 6 - Thời gian, Thời tiết và Con số', 'Cách diễn đạt mốc thời gian, trạng thái thời tiết và các con số lớn.', 'HSK 2', 6, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ca9c4149-a662-422c-9188-b5685b825b61', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('早上', '晚上', '去年', '日', '小时', '时间', '晴', '阴', '雪', '零', '两', '百', '千', '第一');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5d979021-4b47-45c9-9e18-43f45dbbc8a6', 'Bài 7 - Đi lại và Chỉ đường', 'Phương tiện giao thông, vị trí không gian và cách hỏi đường, di chuyển.', 'HSK 2', 7, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5d979021-4b47-45c9-9e18-43f45dbbc8a6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('公共汽车', '火车站', '机场', '票', '路', '走', '往', '离', '远', '近', '左边', '右边', '旁边', '外', '门', '出', '进', '从', '到');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7e710dea-9862-403f-8f09-ab8031d0ca57', 'Bài 8 - Học tập và Lớp học', 'Môi trường học tập, thi cử và trao đổi thông tin trong lớp.', 'HSK 2', 8, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7e710dea-9862-403f-8f09-ab8031d0ca57', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('教室', '课', '考试', '题', '错', '懂', '问', '问题', '铅笔', '知道', '说话', '介绍', '告诉');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b42f4801-bcb4-43df-9e7b-cac2499082a5', 'Bài 9 - Công việc và Nơi ở', 'Chủ đề công sở, tiến độ công việc và nơi lưu trú, phòng ốc.', 'HSK 2', 9, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b42f4801-bcb4-43df-9e7b-cac2499082a5', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('上班', '公司', '事情', '忙', '房间', '宾馆', '准备', '开始', '完', '帮助', '希望', '次', '每');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8e78386b-7dbd-4bc9-962a-101cf2119a66', 'Bài 10 - Miêu tả, Cảm nhận và So sánh', 'Tính từ miêu tả đặc điểm, mức độ và cấu trúc so sánh, biểu đạt ý kiến.', 'HSK 2', 10, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '8e78386b-7dbd-4bc9-962a-101cf2119a66', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('高', '长', '快', '慢', '对', '意思', '觉得', '比', '最', '非常', '真', '也', '还');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('80681700-a311-4b11-b4e7-8dfabb44dfd6', 'Bài 11 - Ngữ pháp và Liên từ thông dụng', 'Các liên từ nối câu, động từ năng nguyện và trợ từ ngữ pháp quan trọng của HSK 2.', 'HSK 2', 11, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '80681700-a311-4b11-b4e7-8dfabb44dfd6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('为什么', '因为……所以……', '虽然……但是……', '可以', '可能', '要', '别', '给', '让', '得', '就', '正在', '着', '过', '已经', '再', '吧');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c2f534da-0171-4382-9173-e18d7f6913be', 'Bài 1 - Bốn mùa và Thế giới xung quanh', 'Từ vựng về thời tiết, các mùa trong năm và môi trường tự nhiên.', 'HSK 3', 1, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c2f534da-0171-4382-9173-e18d7f6913be', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('春', '夏', '冬', '季节', '太阳', '刮风', '动物', '世界', '国家', '城市', '地图', '地方');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('02025cad-9dbc-4b98-b7b0-693223b43f23', 'Bài 2 - Đường đi và Di chuyển', 'Các từ chỉ phương hướng, vị trí và phương tiện giao thông.', 'HSK 3', 2, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '02025cad-9dbc-4b98-b7b0-693223b43f23', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('东', '南', '北方', '中间', '向', '地铁', '公园', '护照', '司机', '伞', '搬', '方便');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('dbefe8b2-57ca-4f0d-b2a1-00f756ffca90', 'Bài 3 - Con người và Ngoại hình', 'Miêu tả ngoại hình, các mối quan hệ người thân và xã hội.', 'HSK 3', 3, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'dbefe8b2-57ca-4f0d-b2a1-00f756ffca90', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('奶奶', '叔叔', '客人', '别人', '同事', '年轻', '个子', '头发', '嘴', '可爱', '像', '声音');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3e17e9a4-9bc5-4fbf-be33-52aa29ed2ca3', 'Bài 4 - Nhịp sống gia đình', 'Sinh hoạt hàng ngày, đồ dùng gia đình và môi trường sống.', 'HSK 3', 4, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3e17e9a4-9bc5-4fbf-be33-52aa29ed2ca3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('刷牙', '干净', '打扫', '冰箱', '包', '帽子', '旧', '新鲜', '啤酒', '习惯', '周末', '安静');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('537858c0-24e1-4eeb-ac09-89657d44a231', 'Bài 5 - Sức khỏe và Cảm xúc', 'Diễn tả trạng thái sức khỏe thể chất, tâm lý và cảm xúc.', 'HSK 3', 5, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '537858c0-24e1-4eeb-ac09-89657d44a231', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('健康', '体育', '感冒', '发烧', '哭', '担心', '放心', '害怕', '奇怪', '坏', '小心', '变化', '关心');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('219d0d0c-6d2f-4822-a0d9-99177dad8fb9', 'Bài 6 - Trường học và Tri thức', 'Từ vựng liên quan đến trường lớp, các môn học và học tập.', 'HSK 3', 6, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '219d0d0c-6d2f-4822-a0d9-99177dad8fb9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('中文', '历史', '数学', '文化', '年级', '作业', '成绩', '句子', '复习', '教', '故事', '图书馆', '提高');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5d1b9784-789a-4e98-9936-f76504ca35d6', 'Bài 7 - Công sở và Giải quyết công việc', 'Môi trường làm việc văn phòng, hội họp và các kế hoạch công việc.', 'HSK 3', 7, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5d1b9784-789a-4e98-9936-f76504ca35d6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('办公室', '会议', '办法', '打算', '完成', '同意', '决定', '了解', '参加', '影响', '回答', '帮忙', '努力', '关系');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d9d45e1d-7aac-489a-87aa-53e8217de123', 'Bài 8 - Mua sắm và Số lượng', 'Từ vựng về tiền tệ, thanh toán và các lượng từ thông dụng.', 'HSK 3', 8, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd9d45e1d-7aac-489a-87aa-53e8217de123', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('元', '分', '万', '一共', '信用卡', '公斤', '换', '借', '双', '张', '层', '位', '口', '只');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('06019ce8-33cc-4de3-b0f3-ee6fa2207549', 'Bài 9 - Hành động và Công nghệ', 'Các thao tác hàng ngày, trao đổi thông tin và tương tác kỹ thuật số.', 'HSK 3', 9, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '06019ce8-33cc-4de3-b0f3-ee6fa2207549', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('拿', '放', '带', '接', '关', '发', '发现', '上网', '新闻', '忘记', '明白', '感兴趣');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('36d52868-61d9-4cdb-be4a-ebab774d587c', 'Bài 10 - Thời gian và Tần suất', 'Cách diễn đạt mốc thời gian, khoảng thời gian và mức độ thường xuyên.', 'HSK 3', 10, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '36d52868-61d9-4cdb-be4a-ebab774d587c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一会儿', '刻', '半', '一直', '总是', '刚才', '以前', '后来', '久', '一般', '几乎', '差', '多么');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ae69c037-5b81-4cf6-956b-1af8080dede2', 'Bài 11 - Thái độ và Quan điểm', 'Các phó từ và động từ năng nguyện thể hiện nhận định, thái độ.', 'HSK 3', 11, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ae69c037-5b81-4cf6-956b-1af8080dede2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一定', '当然', '应该', '必须', '愿意', '其实', '主要', '容易', '一样', '其他');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b7a0b790-f408-423b-bb48-fb1a29e9f917', 'Bài 12 - Liên kết câu và Ngữ pháp nâng cao', 'Các liên từ logic, giới từ và hư từ cấu trúc câu thông dụng trong HSK 3.', 'HSK 3', 12, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b7a0b790-f408-423b-bb48-fb1a29e9f917', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('不但……而且……', '只有……才……', '如果', '或者', '又', '一边', '先', '为', '为了', '关于', '把', '地', '啊');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e67fea6d-6aa8-4c0a-82f2-90f61df7698c', 'Bài 13 - Diện mạo và cơ thể', 'Mô tả đặc điểm ngoại hình và các bộ phận trên cơ thể người', 'HSK 3', 13, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e67fea6d-6aa8-4c0a-82f2-90f61df7698c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('脸', '耳朵', '鼻子', '脚', '腿', '胖', '瘦', '矮', '长', '短', '老', '聪明');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d7cc2058-fefd-4d8c-8574-fd550d4f3989', 'Bài 14 - Sức khỏe và sinh hoạt', 'Nói về cảm giác thể chất, sức khỏe và thói quen sinh hoạt cá nhân', 'HSK 3', 14, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd7cc2058-fefd-4d8c-8574-fd550d4f3989', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('疼', '舒服', '洗澡', '洗手间', '锻炼', '渴', '饿', '饱', '请假', '照顾', '检查');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3553e060-586f-48e8-be34-ef1929906a3b', 'Bài 15 - Gia đình và giao tiếp', 'Từ vựng về người thân, hàng xóm và các hoạt động tương tác, kết nối', 'HSK 3', 15, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3553e060-586f-48e8-be34-ef1929906a3b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('爷爷', '阿姨', '邻居', '结婚', '自己', '见面', '聊天', '讲', '热情', '欢迎', '记得', '相信');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8a0165b3-c246-49e6-b484-d71544c037ac', 'Bài 16 - Ẩm thực và bàn ăn', 'Khám phá các món ăn, đồ uống và vật dụng quen thuộc trong bữa ăn', 'HSK 3', 16, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '8a0165b3-c246-49e6-b484-d71544c037ac', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('甜', '面包', '蛋糕', '香蕉', '饮料', '菜单', '盘子', '碗', '筷子', '瓶子', '超市', '米');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9dd561d5-1686-4279-ae16-466904a6c4ea', 'Bài 17 - Mua sắm và trang phục', 'Từ vựng về quần áo, phụ kiện và các hoạt động mua bán, giao dịch', 'HSK 3', 17, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9dd561d5-1686-4279-ae16-466904a6c4ea', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('衬衫', '裙子', '裤子', '皮鞋', '试', '礼物', '银行', '角', '条', '种', '简单', '用');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('50b7d855-cc5c-4bce-a1ad-490425ebd4eb', 'Bài 18 - Nhà cửa và đồ dùng', 'Không gian sống, trang thiết bị gia đình và vật dụng tiện ích', 'HSK 3', 18, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '50b7d855-cc5c-4bce-a1ad-490425ebd4eb', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('楼', '电梯', '灯', '空调', '照片', '照相机', '行李箱', '清楚', '环境', '词典', '笔记本');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0ef98f91-5055-41fb-ab9e-3f5c31d92bfc', 'Bài 19 - Thiên nhiên và muôn loài', 'Từ vựng về cảnh sắc tự nhiên, thế giới động vật và màu sắc', 'HSK 3', 19, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0ef98f91-5055-41fb-ab9e-3f5c31d92bfc', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('月亮', '黄河', '树', '花', '草', '秋', '熊猫', '鸟', '马', '蓝', '绿', '西', '有名');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5ba76d92-f1c5-44d6-b17a-37e1fe37bd39', 'Bài 20 - Giao thông và di chuyển', 'Phương tiện giao thông, địa điểm và những trải nghiệm trên đường đi', 'HSK 3', 20, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5ba76d92-f1c5-44d6-b17a-37e1fe37bd39', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('自行车', '骑', '船', '辆', '站', '街道', '附近', '离开', '起飞', '过去', '经过', '遇到');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('56e35db1-d007-43f1-8944-f6069fe5e8d6', 'Bài 21 - Học tập và công sở', 'Môi trường trường học, công ty và cách xử lý công việc hằng ngày', 'HSK 3', 21, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '56e35db1-d007-43f1-8944-f6069fe5e8d6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('校长', '经理', '班', '留学', '练习', '黑板', '电子邮件', '迟到', '要求', '解决', '机会', '选择');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('64f69c26-44e8-4b8d-93fb-596998551e1b', 'Bài 22 - Sở thích và giải trí', 'Các hoạt động thư giãn, văn hóa nghệ thuật, thể thao và lễ hội', 'HSK 3', 22, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '64f69c26-44e8-4b8d-93fb-596998551e1b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('爱好', '音乐', '画', '游戏', '比赛', '爬山', '节日', '节目', '水平', '认真', '满意', '注意');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7c700bc6-c8d7-411a-ad6f-24c0695cfa6c', 'Bài 23 - Cảm xúc và nhận định', 'Bày tỏ tâm trạng, quan điểm cá nhân và mức độ so sánh', 'HSK 3', 23, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7c700bc6-c8d7-411a-ad6f-24c0695cfa6c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('生气', '着急', '难过', '认为', '重要', '难', '需要', '更', '极', '比较', '特别');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('fea02b1f-1cd4-4234-8523-75f55399d0c0', 'Bài 24 - Thời gian và liên từ logic', 'Trạng từ chỉ thời gian, tần suất và các liên từ kết nối câu thông dụng', 'HSK 3', 24, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'fea02b1f-1cd4-4234-8523-75f55399d0c0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('最近', '经常', '马上', '突然', '终于', '最后', '然后', '结束', '起来', '越', '还', '还是', '跟', '被', '除了', '根据', '段', '过');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('63923018-5ef0-4f78-9364-da9a5d0db1b4', 'Bài 1 - Chốn công sở bận rộn', 'Từ vựng về công việc văn phòng, nhiệm vụ, chức danh và tác phong làm việc chuyên nghiệp.', 'HSK 4', 1, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '63923018-5ef0-4f78-9364-da9a5d0db1b4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('专业', '专门', '任务', '加班', '出差', '传真', '占线', '博士', '压力', '保证', '准时', '合格', '作家', '作者', '信心');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9e8a0221-1f0c-4019-8831-657fbd8ed5dc', 'Bài 2 - Giao tiếp và Ứng xử', 'Mối quan hệ bạn bè, người thân cùng các kỹ năng tương tác, hòa nhập xã hội.', 'HSK 4', 2, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9e8a0221-1f0c-4019-8831-657fbd8ed5dc', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('亲戚', '俩', '儿童', '交流', '交', '友好', '友谊', '互相', '共同', '原谅', '反对', '允许', '印象', '动作', '乱');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f97792ed-2427-4fe0-899f-c756b7473f1d', 'Bài 3 - Cảm xúc và Tính cách', 'Miêu tả các trạng thái tâm lý, cảm xúc đa dạng và đánh giá phẩm chất con người.', 'HSK 4', 3, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f97792ed-2427-4fe0-899f-c756b7473f1d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('伤心', '兴奋', '冷静', '勇敢', '可怜', '可惜', '吃惊', '后悔', '同情', '受不了', '厉害', '严格', '严重', '优点', '优秀');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f52a0193-8638-472c-b3f1-67b74ee00a10', 'Bài 4 - Trên những chặng đường', 'Các phương tiện giao thông, hướng dẫn đi lại và trải nghiệm khi du lịch hay tham quan.', 'HSK 4', 4, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f52a0193-8638-472c-b3f1-67b74ee00a10', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('乘坐', '交通', '出发', '参观', '加油站', '公里', '停', '入口', '卫生间', '厕所', '到处', '亚洲', '危险', '保护', '修理');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e27ba487-03a8-4cef-9b1f-a1749629e50c', 'Bài 5 - Góc bếp và Nếp sống thường nhật', 'Đời sống hàng ngày, thói quen sinh hoạt, nấu nướng và hiện tượng tự nhiên quanh ta.', 'HSK 4', 5, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e27ba487-03a8-4cef-9b1f-a1749629e50c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('厨房', '包子', '刀', '勺子', '减肥', '力气', '养成', '出生', '凉快', '叶子', '云', '丢', '剩', '厚', '低');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ae2d58b4-ee32-4cfc-81d1-c3fb8fc4eea5', 'Bài 6 - Mua sắm và Tiêu dùng', 'Kinh nghiệm chọn lựa đồ đạc, giá cả, thanh toán và sử dụng dịch vụ thông minh.', 'HSK 4', 6, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ae2d58b4-ee32-4cfc-81d1-c3fb8fc4eea5', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('价格', '付款', '免费', '取', '值得', '合适', '减少', '假', '丰富', '倒', '使', '使用', '信封', '号码', '台');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e735e38a-94c2-4c27-8e61-7b60b0ee6ac0', 'Bài 7 - Văn hóa và Kỷ nguyên số', 'Khám phá nghệ thuật truyền thống, thể thao và công nghệ thông tin thời hiện đại.', 'HSK 4', 7, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e735e38a-94c2-4c27-8e61-7b60b0ee6ac0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('乒乓球', '京剧', '功夫', '互联网', '信息', '世纪', '举', '举办', '举行', '内容', '作用', '区别', '发展', '发生', '出现');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4614ec24-04da-4429-8fea-f244d23ac072', 'Bài 8 - Tư duy và Giải quyết vấn đề', 'Các từ vựng về phán đoán, phân tích nguyên nhân và đưa ra quyết định sáng suốt.', 'HSK 4', 8, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4614ec24-04da-4429-8fea-f244d23ac072', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('以为', '估计', '判断', '主意', '原因', '原来', '关键', '准确', '仔细', '到底', '受到', '及时', '千万', '例如', '刚');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('44c23dd1-ed7d-45f4-94b1-d8a260ec15e0', 'Bài 9 - Nghệ thuật liên kết và Tranh luận', 'Các liên từ logic giúp kết nối câu văn mạch lạc, chặt chẽ và thuyết phục hơn.', 'HSK 4', 9, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '44c23dd1-ed7d-45f4-94b1-d8a260ec15e0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('不仅', '不管', '不过', '与', '于是', '即使', '却', '可是', '另外', '只要', '只好', '不得不', '同时', '其次', '也许');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4d346631-9428-4198-881a-95016d5e05d1', 'Bài 10 - Mức độ, Phạm vi và Tần suất', 'Các phó từ, lượng từ và từ chỉ mức độ giúp câu nói chính xác và tự nhiên như người bản xứ.', 'HSK 4', 10, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4d346631-9428-4198-881a-95016d5e05d1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一切', '全部', '任何', '各', '其中', '内', '之', '以', '份', '倍', '十分', '光', '从来', '仍然', '偶尔');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('64c12033-2f78-42c5-a4cb-38c705de245c', 'Bài 11 - Phỏng vấn và Công sở', 'Từ vựng về nghề nghiệp, tuyển dụng và chế độ làm việc trong môi trường công sở.', 'HSK 4', 11, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '64c12033-2f78-42c5-a4cb-38c705de245c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('招聘', '应聘', '工资', '奖金', '律师', '导游', '师傅', '护士', '大夫', '售货员', '技术', '提供', '安排', '按时');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('1baec1a9-9a93-4192-a780-4ccafc29f022', 'Bài 12 - Gia đình và Nhà cửa', 'Các từ vựng liên quan đến nơi ở, đồ đạc sinh hoạt và cuộc sống gia đình thường nhật.', 'HSK 4', 12, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '1baec1a9-9a93-4192-a780-4ccafc29f022', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('房东', '客厅', '家具', '垃圾桶', '塑料袋', '存', '寄', '密码', '安全', '孙子', '富', '抱', '挂', '抬');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('dae3a247-128b-44ff-bed9-b34f4dbc715c', 'Bài 13 - Ẩm thực và Mua sắm', 'Khám phá hương vị món ăn, thói quen ăn uống và các hoạt động mua sắm, tiêu dùng.', 'HSK 4', 13, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'dae3a247-128b-44ff-bed9-b34f4dbc715c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('尝', '味道', '咸', '小吃', '巧克力', '干杯', '打折', '排队', '够', '抽烟', '吸引', '广告', '广播');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('51b2f81f-f3b6-4091-a65f-2eefc16f4bb1', 'Bài 14 - Con người và Tính cách', 'Miêu tả ngoại hình, phong thái, tuổi tác và những nét tính cách đặc trưng của con người.', 'HSK 4', 14, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '51b2f81f-f3b6-4091-a65f-2eefc16f4bb1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('性格', '态度', '幽默', '害羞', '懒', '帅', '小伙子', '年龄', '性别', '打扮', '戴', '尊重', '开玩笑');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('21f15679-068c-46b8-9101-d18dc52ab9b7', 'Bài 15 - Cảm xúc và Động lực sống', 'Thể hiện thế giới nội tâm, tâm trạng buồn vui và sự nỗ lực kiên trì để đạt được thành công.', 'HSK 4', 15, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '21f15679-068c-46b8-9101-d18dc52ab9b7', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('开心', '愉快', '幸福', '得意', '失望', '失败', '成功', '成为', '坚持', '怀疑', '感觉', '感情', '感动', '心情');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ba415fbc-d396-4fea-8982-09c25964afdf', 'Bài 16 - Giao tiếp và Ứng xử', 'Cách bày tỏ quan điểm, đưa ra đề xuất, trao đổi và xã giao một cách lịch sự, khéo léo.', 'HSK 4', 16, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ba415fbc-d396-4fea-8982-09c25964afdf', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('商量', '建议', '意见', '对话', '打招呼', '打扰', '抱歉', '感谢', '批评', '拒绝', '接受', '提', '指');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7f193999-a8a7-435f-bf1e-9f58b5a74a50', 'Bài 17 - Học tập và Rèn luyện', 'Từ vựng về hoạt động ở trường học, kỳ nghỉ, tài liệu học tập và rèn luyện kỹ năng.', 'HSK 4', 17, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7f193999-a8a7-435f-bf1e-9f58b5a74a50', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('学期', '寒假', '报名', '基础', '填空', '复印', '打印', '小说', '弹钢琴', '总结', '排列', '增加', '复杂');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b0d90195-6b5b-494a-b902-9fc9afbb6e16', 'Bài 18 - Giao thông và Địa lý', 'Các từ vựng về di chuyển, vị trí địa lý, không gian xung quanh và phạm vi quốc tế.', 'HSK 4', 18, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b0d90195-6b5b-494a-b902-9fc9afbb6e16', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('堵车', '座位', '座', '地点', '地址', '对面', '周围', '大使馆', '国际', '国籍', '地球', '场', '底');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('636ac4e5-c160-47a8-9d1c-b25621d49164', 'Bài 19 - Sức khỏe và Thao tác', 'Nói về triệu chứng sức khỏe, tình trạng thể chất và các thao tác hành động thường ngày.', 'HSK 4', 19, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '636ac4e5-c160-47a8-9d1c-b25621d49164', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('咳嗽', '打针', '困', '困难', '响', '弄', '扔', '拉', '推', '掉', '推迟', '引起', '接着');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6e776911-559b-47e3-9f80-0e6636382431', 'Bài 20 - Thời gian và Ước lượng', 'Các từ chỉ thời điểm, mức độ, sự suy đoán và cách ước lượng số lượng hoặc tình thế.', 'HSK 4', 20, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '6e776911-559b-47e3-9f80-0e6636382431', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('平时', '当时', '将来', '往往', '大概', '大约', '差不多', '左右', '挺', '尤其', '恐怕', '好像', '实在', '实际');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('adcb0ed3-08be-4e29-a7d6-17ef1e4ad511', 'Bài 21 - Liên kết câu và Lập luận', 'Các liên từ, phó từ và từ chức năng quan trọng dùng để kết nối mạch ý và diễn đạt logic.', 'HSK 4', 21, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'adcb0ed3-08be-4e29-a7d6-17ef1e4ad511', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('咱们', '呀', '回忆', '因此', '否则', '尽管', '并且', '所有', '完全', '好处', '对于', '按照', '情况', '当', '干', '得');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c552fe44-ed0c-40f5-b8f9-c23d4029113d', 'Bài 22 - Tình cảm & Gia đình', 'Chia sẻ về các mối quan hệ thân thương, tình yêu và những cung bậc cảm xúc trong cuộc sống.', 'HSK 4', 22, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c552fe44-ed0c-40f5-b8f9-c23d4029113d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('母亲', '父亲', '爱情', '浪漫', '熟悉', '理解', '烦恼', '激动', '活泼', '礼貌', '梦', '永远', '生命');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6b32ba79-e286-4153-b1f9-3abd1993a0d2', 'Bài 23 - Không gian sống & Chăm sóc bản thân', 'Miêu tả không gian gia đình, các vật dụng thường ngày và thói quen vệ sinh, làm đẹp.', 'HSK 4', 23, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '6b32ba79-e286-4153-b1f9-3abd1993a0d2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('收拾', '整理', '擦', '敲', '沙发', '窗户', '毛巾', '牙膏', '盒子', '照', '理发', '皮肤', '汗', '橡皮');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('dad0b91e-a32d-45d8-9ba6-c3229450c789', 'Bài 24 - Ẩm thực & Chi tiêu đời thường', 'Thưởng thức các món ngon, thức uống cùng những trải nghiệm mua sắm, quản lý tiền bạc.', 'HSK 4', 24, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'dad0b91e-a32d-45d8-9ba6-c3229450c789', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('烤鸭', '汤', '果汁', '矿泉水', '盐', '现金', '租', '浪费', '省', '穷', '破', '毛');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('68f781b0-4e76-4cea-8cd2-c03b745d27d9', 'Bài 25 - Du lịch & Hòa mình với thiên nhiên', 'Các chuyến hành trình nghỉ dưỡng, quan sát cảnh quan tự nhiên, thời tiết và môi trường.', 'HSK 4', 25, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '68f781b0-4e76-4cea-8cd2-c03b745d27d9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('旅行', '登机牌', '散步', '景色', '桥', '森林', '棵', '植物', '海洋', '空气', '气候', '温度', '暖和', '放暑假', '污染');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('09f0fc93-3e45-4002-bd40-6e6e479d569a', 'Bài 26 - Học thuật & Tri thức', 'Môi trường học tập đại học, hoạt động nghiên cứu khoa học và trau dồi vốn ngôn ngữ.', 'HSK 4', 26, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '09f0fc93-3e45-4002-bd40-6e6e479d569a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('教授', '教育', '毕业', '硕士', '研究', '知识', '科学', '文章', '杂志', '日记', '普通话', '流利');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9646a48c-fd93-45e9-9b0a-d324673858c8', 'Bài 27 - Công việc & Con đường sự nghiệp', 'Bàn về kinh doanh, sự cạnh tranh, nỗ lực tích lũy kinh nghiệm và đạt được mục tiêu công việc.', 'HSK 4', 27, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9646a48c-fd93-45e9-9b0a-d324673858c8', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('收入', '生意', '竞争', '申请', '积累', '支持', '改变', '放弃', '条件', '目的', '标准', '效果', '积极', '理想', '材料');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0c978b9c-63c7-49ed-904d-6b5f911679ab', 'Bài 28 - Đời sống xã hội & Văn hóa giải trí', 'Khám phá đời sống cộng đồng, các quy định pháp luật cùng hoạt động nghệ thuật náo nhiệt.', 'HSK 4', 28, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0c978b9c-63c7-49ed-904d-6b5f911679ab', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('社会', '民族', '法律', '禁止', '演出', '演员', '活动', '流行', '热闹', '短信', '祝贺', '生活', '消息');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4a403955-f3ae-41d8-980e-ccdc8d9382ce', 'Bài 29 - Quản lý thời gian & Kế hoạch', 'Sắp xếp lịch trình, xử lý tình huống khẩn trương và thư giãn đúng lúc.', 'HSK 4', 29, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4a403955-f3ae-41d8-980e-ccdc8d9382ce', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('提前', '提醒', '暂时', '来不及', '来得及', '礼拜天', '秒', '留', '收', '放松', '最好');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6c1bf2b4-1451-470c-9307-59d3323fbd3c', 'Bài 30 - Góc nhìn, Nhận xét & Đánh giá', 'Bày tỏ quan điểm cá nhân, nhận diện đặc điểm và đánh giá người hoặc sự vật xung quanh.', 'HSK 4', 30, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '6c1bf2b4-1451-470c-9307-59d3323fbd3c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('看法', '特点', '样子', '有趣', '棒', '无聊', '真正', '正常', '正式', '正确', '敢', '故意', '猜', '眼镜');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9b69a3ab-d9ef-450a-b7bb-84548791974e', 'Bài 31 - Số lượng, Phương thức & Trạng thái', 'Các từ vựng chỉ số liệu, cách thức hành động và các trạng thái biến chuyển cụ thể.', 'HSK 4', 31, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9b69a3ab-d9ef-450a-b7bb-84548791974e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('数字', '数量', '百分之', '方向', '方法', '方面', '稍微', '深', '空', '满', '火', '死');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('36b04146-aa49-4d3f-9daf-94d341679738', 'Bài 32 - Lập luận & Kết nối câu', 'Vận dụng các liên từ và phó từ logic giúp câu văn mạch lạc, chặt chẽ và biểu cảm hơn.', 'HSK 4', 32, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '36b04146-aa49-4d3f-9daf-94d341679738', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('既然', '无论', '是否', '比如', '甚至', '然而', '由', '由于', '相反', '相同', '直接', '确实', '竟然', '究竟', '普遍', '本来', '正好', '来自', '无');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('17edca68-9048-4b6c-b320-2e06d089cab1', 'Bài 33 - Ẩm thực & Hương vị', 'Các món ăn, đồ uống quen thuộc cùng các tính từ miêu tả mùi vị và cảm giác khi ăn uống', 'HSK 4', 33, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '17edca68-9048-4b6c-b320-2e06d089cab1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('餐厅', '饺子', '饼干', '西红柿', '葡萄', '糖', '辣', '酸', '苦', '香', '肚子', '难受');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7805f781-6f44-410e-9f67-3e40dd8fb5d8', 'Bài 34 - Mua sắm & Tiêu dùng', 'Từ vựng về đi chợ, lựa chọn hàng hóa, đồ dùng cá nhân và quản lý chi tiêu tài chính', 'HSK 4', 34, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7805f781-6f44-410e-9f67-3e40dd8fb5d8', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('购物', '顾客', '质量', '零钱', '袜子', '镜子', '钥匙', '逛', '适合', '节约', '赚', '经济', '顺便');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('13624c1a-9d34-4faa-9494-b3a4489a233c', 'Bài 35 - Du lịch & Đi lại', 'Các chuyến bay, danh lam thắng cảnh, phương tiện giao thông và định hướng đường sá', 'HSK 4', 35, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '13624c1a-9d34-4faa-9494-b3a4489a233c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('航班', '降落', '签证', '高速公路', '迷路', '距离', '速度', '趟', '首都', '郊区', '长城', '长江', '邮局', '阳光');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('55c297a5-812d-4685-badc-b83b0562332b', 'Bài 36 - Thể thao & Giải trí', 'Các bộ môn thể thao, hoạt động biểu diễn nghệ thuật và trải nghiệm tự nhiên', 'HSK 4', 36, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '55c297a5-812d-4685-badc-b83b0562332b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('网球', '羽毛球', '赢', '输', '艺术', '精彩', '表演', '观众', '节', '著名', '美丽', '自然', '老虎');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('127a9bbb-9f67-4cfd-8682-cf123d569e36', 'Bài 37 - Gặp gỡ & Ứng xử', 'Giao lưu bạn bè, hẹn hò, bày tỏ cảm xúc và giải quyết hiểu lầm trong giao tiếp', 'HSK 4', 37, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '127a9bbb-9f67-4cfd-8682-cf123d569e36', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('约会', '聚会', '邀请', '陪', '联系', '道歉', '误会', '解释', '鼓励', '羡慕', '讨厌', '笑话', '麻烦');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('09c64655-20c4-49ab-bf49-654a38b701be', 'Bài 38 - Tính cách & Phẩm chất', 'Những nét tính cách, thói quen và trạng thái tinh thần của con người', 'HSK 4', 38, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '09c64655-20c4-49ab-bf49-654a38b701be', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('粗心', '马虎', '笨', '耐心', '诚实', '自信', '骄傲', '脾气', '缺点', '轻松', '紧张', '辛苦', '骗', '随便');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9eddc976-0ce7-4991-b9e2-615b16916a5f', 'Bài 39 - Công việc & Trách nhiệm', 'Nghề nghiệp xã hội, năng lực làm việc, quy chế cơ quan và kinh nghiệm công sở', 'HSK 4', 39, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9eddc976-0ce7-4991-b9e2-615b16916a5f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('职业', '记者', '警察', '管理', '负责', '责任', '能力', '经验', '经历', '规定', '表格', '调查', '表扬', '顺利');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('eb4170c3-ee0c-47c0-81db-a94e3eb29a16', 'Bài 40 - Học tập & Ngôn ngữ', 'Phương pháp học tiếng Trung, kỹ năng đọc hiểu và chuẩn bị tài liệu bài vở', 'HSK 4', 40, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'eb4170c3-ee0c-47c0-81db-a94e3eb29a16', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('语言', '词语', '语法', '翻译', '阅读', '预习', '篇', '页', '答案', '详细', '重点', '错误', '顺序', '网站');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d28ee1d8-ba06-4183-bb20-e8bd6a46bbb4', 'Bài 41 - Kế hoạch & Đánh giá', 'Thảo luận, đưa ra ý kiến, lập kế hoạch và đo lường sự phù hợp trong công việc', 'HSK 4', 41, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd28ee1d8-ba06-4183-bb20-e8bd6a46bbb4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('计划', '讨论', '谈', '说明', '表示', '通知', '证明', '考虑', '符合', '缺少', '获得', '重视', '重新');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f90c8b87-4343-4438-b0ef-95d95b77427c', 'Bài 42 - Sinh hoạt & Thể trạng', 'Động tác hàng ngày, thói quen sinh hoạt và các mức độ biến đổi thể chất', 'HSK 4', 42, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f90c8b87-4343-4438-b0ef-95d95b77427c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('胳膊', '躺', '醒', '脱', '脏', '赶', '转', '适应', '行', '轻', '重', '超过', '降低');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5376bb68-e008-4dcb-86b2-571dfa013970', 'Bài 43 - Lập luận & Liên từ logic', 'Các liên từ, phó từ và cấu trúc diễn đạt dùng để liên kết câu và lập luận chặt chẽ', 'HSK 4', 43, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5376bb68-e008-4dcb-86b2-571dfa013970', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('首先', '过程', '进行', '继续', '结果', '通过', '随着', '而', '连', '要是', '难道', '肯定', '至少', '部分', '遍', '等', '许多');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('aee51434-37e2-4bfb-b96a-679ea5791f1e', 'Bài 1 - Công sở và Hợp tác kinh doanh', 'Từ vựng về hoạt động văn phòng, ký kết hợp đồng và tài chính thương mại.', 'HSK 5', 1, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'aee51434-37e2-4bfb-b96a-679ea5791f1e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('兼职', '利息', '利润', '利益', '办理', '单位', '发票', '召开', '出席', '双方', '合作', '合同', '名片', '员工');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8551fb94-c4c5-45bc-b51f-6e41a7bc8de4', 'Bài 2 - Nông thôn và Không gian cư trú', 'Các từ chỉ nơi chốn, nông thôn, nhà ở và vị trí không gian.', 'HSK 5', 2, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '8551fb94-c4c5-45bc-b51f-6e41a7bc8de4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('公寓', '卧室', '台阶', '县', '农村', '农民', '农业', '内部', '华裔', '单元', '分布', '占');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('06509aaf-e4f7-4b76-af93-083152b59ef0', 'Bài 3 - Sản xuất, Kỹ thuật và Giao thông', 'Thuật ngữ liên quan đến công nghiệp, chế tạo, vật liệu và phương tiện.', 'HSK 5', 3, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '06509aaf-e4f7-4b76-af93-083152b59ef0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('原料', '制作', '制造', '制定', '制度', '化学', '印刷', '创造', '发明', '功能', '出口', '卡车', '列车', '到达');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ec830457-f077-4ad1-afef-77f35d539bcb', 'Bài 4 - Giao tiếp, Phát ngôn và Quan điểm', 'Các động từ và danh từ diễn tả ý kiến, thông báo, mệnh lệnh và đối thoại.', 'HSK 5', 4, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ec830457-f077-4ad1-afef-77f35d539bcb', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('公布', '公开', '发表', '发言', '叙述', '否定', '否认', '反应', '反映', '劝', '命令', '告别', '启发');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7f1549f7-04f2-4258-a11f-4bac250d2411', 'Bài 5 - Ý chí, Phấn đấu và Nỗ lực', 'Từ vựng miêu tả sự kiên trì, quyết tâm, phẩm chất và tinh thần vượt khó.', 'HSK 5', 5, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7f1549f7-04f2-4258-a11f-4bac250d2411', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('冒险', '前途', '力量', '勇气', '刻苦', '勤奋', '决心', '出色', '及格', '具备', '可靠', '劳动', '参与', '发挥');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('58f7f659-43e0-4585-ba49-4dc885fe8306', 'Bài 6 - Cảm xúc và Trạng thái thể chất', 'Biểu đạt tâm trạng lo lắng, sợ hãi, phản xạ và cử chỉ của con người.', 'HSK 5', 6, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '58f7f659-43e0-4585-ba49-4dc885fe8306', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('冷淡', '可怕', '吓', '吃亏', '吐', '吻', '呆', '呼吸', '后背', '受伤', '发愁', '发抖', '匆忙');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d36a9c20-d16a-4ad7-a264-7043d6524068', 'Bài 7 - Văn hóa, Thể thao và Giải trí', 'Chủ đề về thi đấu, lịch sử, nghệ thuật và danh lam thắng cảnh.', 'HSK 5', 7, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd36a9c20-d16a-4ad7-a264-7043d6524068', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('冠军', '决赛', '刺激', '动画片', '博物馆', '名牌', '名胜古迹', '古代', '古典', '写作', '出版', '军事');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('98c5eb2e-524d-4667-afd6-5209463616b3', 'Bài 8 - Đời sống hàng ngày và Sinh hoạt', 'Các từ quen thuộc về đồ dùng, ăn uống và hành động sinh hoạt đời thường.', 'HSK 5', 8, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '98c5eb2e-524d-4667-afd6-5209463616b3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('冰激凌', '口味', '叉子', '剪刀', '包裹', '关闭', '冻', '冲', '切', '划', '吹', '吵', '吵架', '周到', '劳驾');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ae8a62eb-9ad0-4b2e-a6f6-33b9acb1ae4a', 'Bài 9 - Tư duy, Quy chuẩn và Đánh giá logic', 'Từ vựng dùng để phân tích vấn đề, so sánh và đánh giá tính hợp lý.', 'HSK 5', 9, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ae8a62eb-9ad0-4b2e-a6f6-33b9acb1ae4a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('具体', '原则', '公平', '合法', '合理', '后果', '利用', '取消', '删除', '包含', '包括', '分析', '参考', '吸收', '吸取');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('bf57d573-5b3c-42cc-a60b-f74459742669', 'Bài 10 - Phó từ, Liên từ và Ngữ pháp trừu tượng', 'Các từ nối, hư từ và phó từ quan trọng giúp diễn đạt mạch lạc trong HSK 5.', 'HSK 5', 10, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'bf57d573-5b3c-42cc-a60b-f74459742669', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('凭', '则', '勿', '反复', '反正', '反而', '再三', '其余', '各自', '可见', '初级', '分别', '单独', '单纯', '单调');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a4d09a11-329a-43ba-a3b6-7278e794e19c', 'Bài 11 - Lượng từ, Y tế và Xã hội', 'Các đơn vị đo lường, thuật ngữ sức khỏe và biến chuyển xã hội, cuộc sống.', 'HSK 5', 11, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a4d09a11-329a-43ba-a3b6-7278e794e19c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('匹', '升', '厘米', '吨', '册', '内科', '危害', '去世', '分手', '发达', '合影', '分配', '出示');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('363271de-5f03-4043-ab49-319507159b4c', 'Bài 12 - Biện luận và Liên kết', 'Các liên từ và cấu trúc biểu thị điều kiện, giả định và mối quan hệ logic trong câu.', 'HSK 5', 12, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '363271de-5f03-4043-ab49-319507159b4c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一旦', '万一', '与其', '不如', '不然', '何况', '何必', '以及', '从而', '以来', '依然', '便', '假如', '假设', '促使');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('2955eb61-12cf-40ec-8e90-42a33de3df23', 'Bài 13 - Mức độ và Phán đoán', 'Từ ngữ chỉ tần suất, mức độ, tình trạng toàn diện và cách biểu đạt sự phỏng đoán, so sánh.', 'HSK 5', 13, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '2955eb61-12cf-40ec-8e90-42a33de3df23', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一再', '一律', '一致', '丝毫', '不得了', '不断', '不见得', '不足', '仿佛', '似乎', '似的', '偶然', '充分', '充满', '全面');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9607215c-dfc5-46b0-bdc1-8641935c0b70', 'Bài 14 - Tâm lý và Tính cách', 'Từ vựng miêu tả cảm xúc, thái độ ứng xử và nét tính cách của con người.', 'HSK 5', 14, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9607215c-dfc5-46b0-bdc1-8641935c0b70', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('不安', '不耐烦', '不要紧', '严肃', '专心', '乐观', '乖', '佩服', '亲切', '体贴', '假装', '倒霉', '信任', '傻', '享受');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ca1143ee-15d3-482e-9c7f-1bd751b879b3', 'Bài 15 - Công sở và Doanh nghiệp', 'Từ vựng về bộ máy tổ chức, chức vụ quản lý, nghiệp vụ và các hoạt động kinh doanh.', 'HSK 5', 15, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ca1143ee-15d3-482e-9c7f-1bd751b879b3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('专家', '业务', '业余', '中介', '主任', '主席', '人事', '人员', '人才', '企业', '会计', '从事', '代表', '伙伴', '保险');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('80956384-dd4a-4439-89d8-bd7e8113f7c2', 'Bài 16 - Giao tiếp và Xã giao', 'Các từ ngữ liên quan đến tương tác, giao lưu, tranh luận và hành động qua lại trong xã hội.', 'HSK 5', 16, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '80956384-dd4a-4439-89d8-bd7e8113f7c2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('交往', '交换', '交际', '主张', '主持', '争论', '争取', '借口', '催', '伤害', '代替', '伸', '使劲儿', '光临', '促进');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('48d3d994-a931-440e-a3f6-f225e409c1e7', 'Bài 17 - Đời sống và Tiện ích', 'Từ vựng về sinh hoạt hàng ngày, giải trí, thiết bị công nghệ và lưu trữ thông tin.', 'HSK 5', 17, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '48d3d994-a931-440e-a3f6-f225e409c1e7', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('休闲', '健身', '俱乐部', '书架', '乐器', '丝绸', '充电器', '光盘', '下载', '信号', '兔子', '兑换', '人民币', '保存', '修改');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('555bd95d-29a3-41ed-a81c-4735a72e2ae2', 'Bài 18 - Thời gian và Lịch sử', 'Các khái niệm về dòng thời gian, truyền thống văn hóa, vị trí không gian và sự lan truyền.', 'HSK 5', 18, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '555bd95d-29a3-41ed-a81c-4735a72e2ae2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一辈子', '从前', '从此', '中旬', '临时', '傍晚', '元旦', '公元', '传统', '传说', '传播', '传染', '位于', '位置', '中心');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b2f654e4-1c4d-4cff-87db-a3da76ce2a91', 'Bài 19 - Chiêm nghiệm Nhân sinh', 'Từ vựng về trải nghiệm cuộc sống, tư duy nhận thức, giá trị và lý tưởng cao đẹp.', 'HSK 5', 19, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b2f654e4-1c4d-4cff-87db-a3da76ce2a91', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('人生', '人类', '人物', '伟大', '价值', '体会', '体现', '体验', '主观', '主题', '个人', '个性', '克服', '了不起', '事实');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7cf3af47-cc72-4eb1-8aed-94179566e8b9', 'Bài 20 - Đặc tính và Nhận định', 'Từ miêu tả tính chất bề ngoài, ưu thế, phẩm chất sự việc và thái độ hành động.', 'HSK 5', 20, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7cf3af47-cc72-4eb1-8aed-94179566e8b9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('优势', '优惠', '优美', '光明', '光滑', '亮', '保持', '保留', '上当', '偷', '丑', '主人', '主动', '义务', '作品');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('dd16dfc2-d5ef-4868-9b45-6d6b7b19a124', 'Bài 21 - Xã hội và Quy chuẩn', 'Các mối quan hệ thân thiết, số liệu đo lường, thứ tự và sự sản sinh của sự vật.', 'HSK 5', 21, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'dd16dfc2-d5ef-4868-9b45-6d6b7b19a124', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('亲爱', '亲自', '人口', '亿', '兄弟', '公主', '作文', '作为', '事先', '事物', '个别', '乙', '克', '产生', '产品');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('2504b1fe-ef95-49aa-9984-0c8af46c8a6c', 'Bài 22 - Gia đình và Hôn nhân', 'Từ vựng về các mối quan hệ thân tộc, cưới hỏi và đời sống gia đình', 'HSK 5', 22, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '2504b1fe-ef95-49aa-9984-0c8af46c8a6c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('外公', '姥姥', '姑姑', '姑娘', '妇女', '太太', '女士', '家庭', '婚姻', '婚礼', '娶', '嫁', '孝顺', '宝贝', '对象');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('1453c1d6-2007-4fe8-97a5-392e88d65c8d', 'Bài 23 - Cảm xúc và Khẩu ngữ giao tiếp', 'Các thán từ, ngữ điệu và từ ngữ bộc lộ tâm trạng trong trò chuyện', 'HSK 5', 23, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '1453c1d6-2007-4fe8-97a5-392e88d65c8d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('哈', '哎', '唉', '嗯', '喊', '嗓子', '声调', '夸', '夸张', '实话', '安慰', '委屈', '寂寞', '天真');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('65e6df20-7368-45a5-af9d-9efd48eea927', 'Bài 24 - Tính cách và Thái độ sống', 'Miêu tả tính nết, phẩm chất và thái độ đối nhân xử thế', 'HSK 5', 24, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '65e6df20-7368-45a5-af9d-9efd48eea927', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('善良', '善于', '坚决', '坚强', '坦率', '大方', '好奇', '好客', '小气', '尊敬', '客观', '对待', '在乎');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d2073fd3-f608-4953-bf04-9c45e33aa669', 'Bài 25 - Học thuật và Phát triển năng lực', 'Từ vựng liên quan đến giáo dục, nghiên cứu lý thuyết và thực hành', 'HSK 5', 25, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd2073fd3-f608-4953-bf04-9c45e33aa669', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('哲学', '培养', '培训', '学历', '学术', '学问', '实验', '实践', '实习', '实现', '实用', '字母', '夏令营');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e74974d3-6861-48c4-a495-87257073c23e', 'Bài 26 - Kinh doanh và Truyền thông sự kiện', 'Chủ đề thương mại, quảng bá thông tin và giải trí truyền thông', 'HSK 5', 26, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e74974d3-6861-48c4-a495-87257073c23e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('商业', '商务', '商品', '嘉宾', '宴会', '宣传', '宣布', '咨询', '媒体', '导演', '娱乐', '字幕', '复制');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('fadd1bce-97d9-42b2-b494-0a1af99ae580', 'Bài 27 - Đời sống thường nhật và Đồ gia dụng', 'Nơi ở, công việc nội trợ và các vật dụng thường gặp quanh ta', 'HSK 5', 27, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'fadd1bce-97d9-42b2-b494-0a1af99ae580', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('家乡', '家务', '宿舍', '地毯', '墙', '壶', '夹子', '尺子', '围巾', '套', '安装', '土豆', '小麦');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9c42660f-59a7-4085-861a-6d3cac6b63a8', 'Bài 28 - Thiên nhiên và Thế giới sinh vật', 'Khám phá địa lý, thiên tai, không gian và động thực vật', 'HSK 5', 28, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9c42660f-59a7-4085-861a-6d3cac6b63a8', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('天空', '夜', '土地', '地区', '地理', '地震', '大象', '宠物', '尾巴', '咬', '嫩', '宽', '堆');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4ff95369-35df-4e01-8bb0-193306222177', 'Bài 29 - Xã hội, Quốc gia và Văn hóa', 'Các khía cạnh về ngoại giao, thể chế, an ninh và thể thao truyền thống', 'HSK 5', 29, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4ff95369-35df-4e01-8bb0-193306222177', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('和平', '国庆节', '国王', '士兵', '官', '外交', '地位', '威胁', '妨碍', '射击', '太极拳', '大厦', '大型');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6dedeebc-b163-44cb-ace7-e664f5cb7350', 'Bài 30 - Nhân sinh và Nỗ lực vươn lên', 'Bàn về số phận, thời gian, sự nghiệp và ý chí vượt khó', 'HSK 5', 30, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '6dedeebc-b163-44cb-ace7-e664f5cb7350', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('命运', '奇迹', '奋斗', '存在', '宝贵', '寿命', '失去', '失业', '失眠', '寻找', '尽力', '尽量', '尽快');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8f9a5ec5-6ed7-4daf-84a7-8ee2f66c71c8', 'Bài 31 - Tương tác và Giải quyết vấn đề', 'Các mối liên hệ đa chiều, phân tích nguyên nhân và hoàn thiện mục tiêu', 'HSK 5', 31, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '8f9a5ec5-6ed7-4daf-84a7-8ee2f66c71c8', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('对手', '对方', '对比', '密切', '处理', '导致', '因素', '在于', '围绕', '团', '姿势', '完善', '完整', '完美', '基本');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e6deff7f-321a-4df0-9839-654755aa2c8c', 'Bài 32 - Liên từ và Phó từ logic', 'Các hư từ, trạng từ chỉ mức độ, hình thái và liên kết lập luận', 'HSK 5', 32, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e6deff7f-321a-4df0-9839-654755aa2c8c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('哪怕', '唯一', '因而', '如今', '如何', '始终', '宁可', '多亏', '多余', '居然', '固定', '均匀', '圆', '圈', '地道');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7db4b68d-6d43-4ec2-aa17-2b6d118839a3', 'Bài 33 - Công nghiệp và Phát triển', 'Từ vựng về sản xuất, công trình kiến trúc, kỹ thuật và xây dựng cơ bản.', 'HSK 5', 33, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7db4b68d-6d43-4ec2-aa17-2b6d118839a3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('工业', '工人', '工厂', '工程师', '工具', '手工', '建筑', '建设', '开发', '开放', '展开', '建立', '成立', '扩大', '应用');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('bfb6a20b-143c-47e4-b7f7-361d86478493', 'Bài 34 - Nơi làm việc và Trách nhiệm', 'Nói về chức vụ quản lý, công việc thực tế, thủ tục giấy tờ và tinh thần trách nhiệm.', 'HSK 5', 34, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'bfb6a20b-143c-47e4-b7f7-361d86478493', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('干活儿', '打工', '待遇', '总裁', '总理', '总统', '执照', '手续', '批准', '批', '承担', '承认', '承受', '成就', '成果');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e09fa90a-a23a-4621-a4cf-8fec01b21a14', 'Bài 35 - Giao tiếp và Hoạt động xã hội', 'Các từ ngữ dùng trong giao lưu, hỏi thăm, lễ kỷ niệm và sự kiện công cộng.', 'HSK 5', 35, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e09fa90a-a23a-4621-a4cf-8fec01b21a14', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('打交道', '打听', '征求', '往返', '彼此', '志愿者', '开幕式', '展览', '届', '庆祝', '恭喜', '应付', '强调', '废话', '戏剧');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0da1c690-f51f-4564-bdc2-6427dbeb0230', 'Bài 36 - Thế giới nội tâm và Cảm xúc', 'Bày tỏ trạng thái tâm lý, tình cảm, cảm xúc vui buồn và phản ứng của con người.', 'HSK 5', 36, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0da1c690-f51f-4564-bdc2-6427dbeb0230', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('心理', '心脏', '情绪', '感受', '感想', '感激', '恋爱', '恨', '微笑', '悲观', '惭愧', '慌张', '忍不住', '愿望', '恶劣');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('61cb8ee5-68b1-4f6b-83ba-bcb9ab715b7d', 'Bài 37 - Tư duy và Nhận thức', 'Khám phá hoạt động trí óc, sự hồi tưởng, trí tưởng tượng và vốn tri thức.', 'HSK 5', 37, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '61cb8ee5-68b1-4f6b-83ba-bcb9ab715b7d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('思想', '思考', '想象', '幻想', '怀念', '想念', '忽视', '念', '常识', '意义', '归纳', '形容', '成语', '情景', '悠久');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c388fa0d-81fe-4c24-8a1f-8ab6456108a3', 'Bài 38 - Con người và Sức khỏe', 'Các giai đoạn phát triển của đời người, chăm sóc y tế và thói quen sinh hoạt.', 'HSK 5', 38, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c388fa0d-81fe-4c24-8a1f-8ab6456108a3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('手指', '手术', '急诊', '打喷嚏', '当心', '怀孕', '恢复', '成人', '成长', '成熟', '年纪', '戒', '戒指', '扇子', '手套');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('18580ccb-1fdc-4f73-acdf-d6de8a093ec9', 'Bài 39 - Không gian sống và Môi trường', 'Mô tả địa điểm sinh hoạt, cảnh quan thiên nhiên và đồ dùng trong cuộc sống thường nhật.', 'HSK 5', 39, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '18580ccb-1fdc-4f73-acdf-d6de8a093ec9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('屋子', '所', '幼儿园', '广场', '市场', '当地', '岛屿', '岸', '彩虹', '影子', '干燥', '开水', '布', '抄', '扶');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ac6e2a65-c00b-4720-9422-8a103f0364e0', 'Bài 40 - Quy mô và Thuộc tính', 'Từ vựng miêu tả hình dạng, tính chất, mức độ và đặc trưng của sự vật.', 'HSK 5', 40, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ac6e2a65-c00b-4720-9422-8a103f0364e0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('形式', '形成', '形状', '形象', '形势', '幅', '巨大', '广大', '广泛', '差距', '巧妙', '弱', '强烈', '性质', '成分');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f3fbb0da-295f-400a-93e2-47a017751d22', 'Bài 41 - Thời gian và Sự cân bằng', 'Biểu đạt các khái niệm về thời gian, đo lường, sự công bằng và bình ổn.', 'HSK 5', 41, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f3fbb0da-295f-400a-93e2-47a017751d22', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('平', '平均', '平安', '平常', '平方', '平等', '平衡', '平静', '年代', '度过', '延长', '战争', '总共', '录取', '录音');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('fe1172ec-837a-46af-b5a4-3ed3653cb9b2', 'Bài 42 - Suy luận và Đánh giá logic', 'Các phó từ, liên từ chỉ quan hệ nhân quả, tình huống bất ngờ và ngữ khí lập luận.', 'HSK 5', 42, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'fe1172ec-837a-46af-b5a4-3ed3653cb9b2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('属于', '干脆', '幸亏', '幸运', '彻底', '必然', '必要', '忽然', '急忙', '怪不得', '总之', '总算', '悄悄', '意外', '或许');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('1abc9936-a8b3-44e3-875d-aede102d7aef', 'Bài 43 - Thiên nhiên & Động thực vật', 'Khám phá các loài động vật, cây trái và các yếu tố trong môi trường tự nhiên.', 'HSK 5', 43, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '1abc9936-a8b3-44e3-875d-aede102d7aef', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('狮子', '猪', '猴子', '桃', '桔子', '梨', '玉米', '根', '池塘', '沙滩', '沙漠', '洞', '灾害', '煤炭', '火柴');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('884d4384-0c0c-41e8-9c1a-75e622364357', 'Bài 44 - Nghệ thuật ẩm thực', 'Các món ăn, mùi vị và những phương pháp chế biến trong nhà bếp.', 'HSK 5', 44, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '884d4384-0c0c-41e8-9c1a-75e622364357', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('油炸', '炒', '煮', '烫', '烂', '点心', '海鲜', '浓', '淡', '清淡', '消化', '盆', '盖', '浇', '洒');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f3a02b05-deb1-4788-8475-63b45d468d8e', 'Bài 45 - Sức khỏe & Cơ thể', 'Chăm sóc cơ thể, các vấn đề sức khỏe và cảm giác thể chất.', 'HSK 5', 45, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f3a02b05-deb1-4788-8475-63b45d468d8e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('牙齿', '病毒', '治疗', '疲劳', '痒', '痛苦', '痛快', '毛病', '熬夜', '歇', '疼爱', '湿润', '潮湿', '温暖', '温柔');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('bb76a1da-6223-476d-ac2a-c099c26a7cf7', 'Bài 46 - Tính cách & Cảm xúc', 'Miêu tả tính cách con người, tâm lý và những cung bậc cảm xúc.', 'HSK 5', 46, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'bb76a1da-6223-476d-ac2a-c099c26a7cf7', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('淘气', '狡猾', '活跃', '灵活', '消极', '犹豫', '灰心', '疯狂', '沉默', '热心', '热烈', '热爱', '爱心', '爱惜', '爱护');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b93300c7-1d7b-4de8-9396-b8f426654856', 'Bài 47 - Đời sống thường nhật', 'Đồ dùng sinh hoạt quen thuộc và những hành động, trạng thái đời thường.', 'HSK 5', 47, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b93300c7-1d7b-4de8-9396-b8f426654856', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('梳子', '牛仔裤', '玩具', '玻璃', '电池', '柜台', '灰尘', '灰', '滴', '漏', '滑', '滚', '甩', '歪', '欠');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('fdadddb9-38f0-483f-a495-f9731d2fe211', 'Bài 48 - Du lịch, Văn hóa & Kinh tế', 'Hoạt động trải nghiệm, giải trí, văn hóa và các giao dịch kinh tế.', 'HSK 5', 48, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'fdadddb9-38f0-483f-a495-f9731d2fe211', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('游览', '浏览', '海关', '欧洲', '消费', '汇率', '涨', '欣赏', '球迷', '武术', '王子', '汽油', '燃烧', '登记', '注册');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8aeaa6b8-9d9f-4e83-a702-37e9af52cf9e', 'Bài 49 - Khoa học & Đời sống xã hội', 'Tìm hiểu về hiện tượng vật chất, đời sống xã hội và pháp luật.', 'HSK 5', 49, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '8aeaa6b8-9d9f-4e83-a702-37e9af52cf9e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('现代', '现实', '现象', '物理', '物质', '生产', '生长', '生动', '用途', '用功', '电台', '法院', '派', '流传', '演讲');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('db3e1473-1b01-4bc4-84e1-903579cc61dd', 'Bài 50 - Tư duy, Lý luận & Nghiên cứu', 'Các thuật ngữ về tư duy học thuật, khái niệm và phương pháp tiếp cận.', 'HSK 5', 50, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'db3e1473-1b01-4bc4-84e1-903579cc61dd', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('概念', '概括', '理论', '理由', '测验', '疑问', '核心', '标志', '标点', '步骤', '比例', '模仿', '模特', '样式', '熟练');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0ae4e161-b143-4acc-8dd7-4ec52149ff3a', 'Bài 51 - Đặc trưng & Trạng thái', 'Mô tả tính chất riêng biệt, trạng thái biến chuyển và trải nghiệm sâu sắc.', 'HSK 5', 51, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0ae4e161-b143-4acc-8dd7-4ec52149ff3a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('特征', '特殊', '特色', '独特', '独立', '状况', '状态', '模糊', '深刻', '满足', '消失', '流泪', '梦想', '珍惜', '激烈');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('94958422-0130-42ef-84db-c87374daf7fc', 'Bài 52 - Giao tiếp & Lập luận', 'Nghệ thuật trò chuyện, từ ngữ liên kết và cách nhìn nhận vấn đề.', 'HSK 5', 52, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '94958422-0130-42ef-84db-c87374daf7fc', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('沟通', '气氛', '根本', '格外', '毕竟', '此外', '的确', '照常', '正', '某', '甲', '片', '片面', '次要', '浅');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('11c8e98e-73ee-4f31-984c-ea6bfa01e85b', 'Bài 53 - Chân dung và Phẩm chất', 'Từ vựng miêu tả ngoại hình, tính cách và phẩm chất của con người', 'HSK 5', 53, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '11c8e98e-73ee-4f31-984c-ea6bfa01e85b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('舒适', '良好', '苗条', '英俊', '英雄', '虚心', '讲究', '诚恳', '调皮', '谦虚', '谨慎', '豪华', '身份');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b44cc5a4-8321-49c6-b2a9-00e00689b49c', 'Bài 54 - Ẩm thực và Thế giới tự nhiên', 'Từ vựng về món ăn, sinh vật và biểu tượng văn hóa tự nhiên', 'HSK 5', 54, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b44cc5a4-8321-49c6-b2a9-00e00689b49c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('色彩', '花生', '营养', '蔬菜', '薄', '蛇', '蜜蜂', '蝴蝶', '诗', '豆腐', '象征', '象棋', '辣椒');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('49ca305a-4376-4fbd-a46f-c135a7d204bf', 'Bài 55 - Nghệ thuật giao tiếp và Đàm phán', 'Các từ ngữ liên quan đến trao đổi, tranh luận, thuyết phục và đánh giá', 'HSK 5', 55, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '49ca305a-4376-4fbd-a46f-c135a7d204bf', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('议论', '讽刺', '评价', '话题', '询问', '语气', '说服', '请求', '谈判', '责备', '赞成', '赞美', '转告', '辩论');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('46bd8ce3-065b-4a0a-80d5-e0e4effa0c14', 'Bài 56 - Học thuật và Nghiên cứu', 'Từ vựng phục vụ học tập, thi cử, quan điểm và tư duy nghiên cứu', 'HSK 5', 56, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '46bd8ce3-065b-4a0a-80d5-e0e4effa0c14', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('观察', '观念', '观点', '角度', '角色', '训练', '记录', '记忆', '讲座', '论文', '词汇', '试卷', '课程', '辅导');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0dcd9195-9c52-4ec1-813d-00ce4e5fd291', 'Bài 57 - Kinh tế và Thương mại', 'Các khái niệm về kinh doanh, tài chính, giao dịch và nguồn vốn', 'HSK 5', 57, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0dcd9195-9c52-4ec1-813d-00ce4e5fd291', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('节省', '营业', '行业', '计算', '讨价还价', '财产', '账户', '贷款', '贸易', '资格', '资源', '资金', '赔偿', '进口');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a8124478-c833-4472-ae90-9b8d82ae9e74', 'Bài 58 - Quy chuẩn và Không gian sống', 'Từ vựng về quy tắc, thiết kế kiến trúc, nội thất và cơ sở vật chất', 'HSK 5', 58, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a8124478-c833-4472-ae90-9b8d82ae9e74', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('范围', '被子', '装', '装修', '装饰', '规则', '规律', '规模', '规矩', '设备', '设施', '设计', '车厢', '车库');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('85549ee4-3736-4352-9d75-8c82ed862529', 'Bài 59 - Cử chỉ và Hành vi con người', 'Từ ngữ miêu tả động tác cơ thể, biểu cảm và cách hành xử', 'HSK 5', 59, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '85549ee4-3736-4352-9d75-8c82ed862529', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('行为', '行人', '行动', '补充', '表情', '表明', '表现', '表达', '表面', '踩', '蹲', '身材', '躲藏');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7e01de49-b507-4793-8ee2-f01423118ab9', 'Bài 60 - Đời sống, Y tế và Xã hội', 'Từ vựng về sức khỏe, thủ tục hành chính và các sự kiện trong cuộc sống', 'HSK 5', 60, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7e01de49-b507-4793-8ee2-f01423118ab9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('血', '证件', '证据', '诊断', '贡献', '资料', '辞职', '过敏', '过期', '运气', '退休', '逗', '造成');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('75e76f0d-0746-4929-980e-c1ae21d19da6', 'Bài 61 - Chuyển động và Vận tải', 'Từ vựng chỉ sự dịch chuyển, đón nhận, rút lui và tiến bộ', 'HSK 5', 61, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '75e76f0d-0746-4929-980e-c1ae21d19da6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('落后', '转变', '轮流', '输入', '迎接', '运用', '运输', '进步', '追', '退', '退步', '逃', '逃避', '递');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('80db9651-f7a5-41c3-a3f7-d523abe3c0f8', 'Bài 62 - Thời gian và Nhịp độ', 'Từ ngữ biểu thị tốc độ, xu hướng và tính liên tục của sự việc', 'HSK 5', 62, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '80db9651-f7a5-41c3-a3f7-d523abe3c0f8', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('赶快', '赶紧', '趁', '超级', '趋势', '迅速', '近代', '连忙', '连续', '迟早', '迫切', '逐步', '逐渐', '通常');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f017f7e5-3861-4c72-98a6-2232f194eda3', 'Bài 63 - Đánh giá, Thử thách và Nhận định', 'Từ vựng về tính chất khó khăn, chuẩn mực đánh giá và khả năng xảy ra', 'HSK 5', 63, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f017f7e5-3861-4c72-98a6-2232f194eda3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('艰巨', '艰苦', '要不', '说不定', '调整', '软', '软件', '轻易', '轻视', '达到', '过分', '违反', '追求', '透明');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d860940d-04a1-4489-b4ff-32fa2bd2d48a', 'Bài 64 - Dòng chảy thời gian', 'Các từ vựng về thời gian, lịch trình và các giai đoạn phát triển.', 'HSK 5', 64, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd860940d-04a1-4489-b4ff-32fa2bd2d48a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('日历', '日子', '日常', '日期', '日程', '时代', '时刻', '时期', '时差', '期间', '曾经', '最初', '未来', '持续', '期待');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ba2a32e7-879a-4031-95bd-132bd1229f8c', 'Bài 65 - Tài chính và Thủ tục', 'Từ vựng liên quan đến tiền bạc, giấy tờ hành chính và truyền thông báo chí.', 'HSK 5', 65, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ba2a32e7-879a-4031-95bd-132bd1229f8c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('报到', '报告', '报社', '报道', '挂号', '押金', '支票', '收据', '支', '挣', '捐', '投资', '投入', '损失', '收获');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('1db40806-2b4e-4510-9d60-156e9baed4c8', 'Bài 66 - Hành động bằng đôi tay', 'Các động từ chỉ thao tác thường ngày bằng tay và hoạt động thể chất.', 'HSK 5', 66, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '1db40806-2b4e-4510-9d60-156e9baed4c8', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('抓', '抓紧', '抢', '披', '拆', '拍', '挥', '捡', '插', '握手', '摆', '摇', '摸', '撕', '摘', '搞');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('baa8a80a-8df4-4583-8e44-2b99d3b2fd8c', 'Bài 67 - Giao thông và Sự cố', 'Từ vựng về di chuyển, phương hướng, tình huống nguy hiểm và cứu hộ.', 'HSK 5', 67, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'baa8a80a-8df4-4583-8e44-2b99d3b2fd8c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('摩托车', '拐弯', '拥挤', '拦', '挡', '撞', '摔倒', '救', '救护车', '晕', '振动', '斜', '断', '杀', '枪', '朝');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5354ba52-6569-49a6-b267-bab12f74829c', 'Bài 68 - Học tập và Giáo dục', 'Chủ đề về học vấn, tài liệu giảng dạy, văn học và rèn luyện kỹ năng.', 'HSK 5', 68, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5354ba52-6569-49a6-b267-bab12f74829c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('教材', '教练', '教训', '拼音', '文字', '文学', '文明', '文具', '文件', '本科', '提纲', '提问', '朗读', '描写', '本领');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4252e2dc-fe7a-46a7-baf1-87d6271bb109', 'Bài 69 - Quản lý và Kế hoạch', 'Các kỹ năng điều hành, lên phương án và nâng cao hiệu suất công việc.', 'HSK 5', 69, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4252e2dc-fe7a-46a7-baf1-87d6271bb109', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('把握', '掌握', '担任', '指导', '指挥', '控制', '推广', '提倡', '措施', '方案', '方式', '方', '效率', '挑战', '操心');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b5404d56-d17f-4a57-9b6e-80eaad760be9', 'Bài 70 - Chính trị và Xã hội', 'Khái niệm về bộ máy chính quyền, quyền lực và văn hóa ứng xử giao tiếp.', 'HSK 5', 70, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b5404d56-d17f-4a57-9b6e-80eaad760be9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('政府', '政治', '改革', '改善', '改正', '改进', '权利', '权力', '敌人', '招待', '接待', '接触', '接近', '拥抱', '推辞');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3ef0b2ac-3750-4e01-bae9-4a953d75ebb1', 'Bài 71 - Đời sống và Thiên nhiên', 'Sinh hoạt thường ngày, thời trang, giải trí và thế giới tự nhiên xung quanh.', 'HSK 5', 71, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3ef0b2ac-3750-4e01-bae9-4a953d75ebb1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('日用品', '服装', '时尚', '时髦', '明星', '摄影', '播放', '抽屉', '操场', '昆虫', '木头', '朵', '果实', '晒', '暗');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('da6cdd1b-1ee9-4c00-971a-15d5608a311f', 'Bài 72 - Góc nhìn và Đánh giá', 'Từ vựng biểu đạt nhận thức, phán đoán logic, cảm xúc và thái độ sống.', 'HSK 5', 72, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'da6cdd1b-1ee9-4c00-971a-15d5608a311f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('明显', '明确', '显得', '显然', '显示', '据说', '推荐', '抱怨', '无奈', '无所谓', '未必', '果然', '极其', '有利', '敏感');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5e845c33-ce56-45bc-b243-4fb1973f45eb', 'Bài 73 - Khoa học và Cấu trúc sự vật', 'Các khái niệm về công nghệ, dữ liệu số, trí tuệ và bản chất của vạn vật.', 'HSK 5', 73, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5e845c33-ce56-45bc-b243-4fb1973f45eb', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('数', '数据', '数码', '整个', '整体', '整齐', '无数', '本质', '智慧', '机器', '构成', '抽象', '搜索');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6a96d663-0ddc-4d8f-8db7-8b44252e0ea0', 'Bài 74 - Hương vị cuộc sống', 'Từ vựng về ăn uống, thực phẩm, đồ dùng nhà bếp và các thói quen thường nhật.', 'HSK 5', 74, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '6a96d663-0ddc-4d8f-8db7-8b44252e0ea0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('酱油', '醋', '锅', '零食', '食物', '馒头', '香肠', '骨头', '酒吧', '醉', '闻', '顿', '随身', '随手');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('845a3bfa-5aee-421c-bfbc-5b8701d4aec6', 'Bài 75 - Nhà cửa và Lễ hội truyền thống', 'Khám phá từ vựng về không gian sống, quan hệ xóm giềng và nét đẹp phong tục Tết cổ truyền.', 'HSK 5', 75, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '845a3bfa-5aee-421c-bfbc-5b8701d4aec6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('阳台', '隔壁', '锁', '铃', '长辈', '问候', '陌生', '除夕', '鞭炮', '风俗', '龙', '项链', '鲜艳', '高档');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3c9c38ac-3c2b-4450-ae43-2e327aea872d', 'Bài 76 - Thiên nhiên và Thế giới vật chất', 'Các hiện tượng thời tiết, cảnh sắc tự nhiên cùng những đơn vị đo lường và kim loại quen thuộc.', 'HSK 5', 76, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3c9c38ac-3c2b-4450-ae43-2e327aea872d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('闪电', '雷', '雾', '飘', '陆地', '风景', '钓', '阵', '预报', '面积', '重量', '金属', '钢铁', '银', '黄金');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5ee745f9-8d14-4402-b269-6c59bf755d26', 'Bài 77 - Công sở và Công nghệ thông tin', 'Từ vựng chuyên dùng trong môi trường văn phòng, thiết bị máy tính và truyền thông.', 'HSK 5', 77, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5ee745f9-8d14-4402-b269-6c59bf755d26', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('部门', '销售', '领导', '项目', '项', '阶段', '零件', '键盘', '鼠标', '麦克风', '频道', '采访', '预订', '题目');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('173dab62-28df-4a29-a634-bddea7f01c5b', 'Bài 78 - Tuổi trẻ và Hoạt động tập thể', 'Chủ đề về thanh xuân, phong cách cá nhân, tinh thần đoàn kết và biểu cảm cảm xúc.', 'HSK 5', 78, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '173dab62-28df-4a29-a634-bddea7f01c5b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('青', '青少年', '青春', '魅力', '风格', '高级', '鼓掌', '鼓舞', '集中', '集体', '集合', '骂', '闯', '首', '颗');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('719a3c7f-8fde-4da1-8cdd-ade668b84103', 'Bài 79 - Tư duy lý luận và Quy tắc đạo đức', 'Các từ vựng trừu tượng liên quan đến tư duy logic, chuẩn mực hành vi và cách thức tranh luận.', 'HSK 5', 79, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '719a3c7f-8fde-4da1-8cdd-ade668b84103', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('逻辑', '道德', '道理', '遗憾', '遵守', '针对', '阻止', '限制', '靠', '面对', '配合', '顶', '非', '除非');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('01535e8a-a316-44e4-b4c5-5ba3dc02a349', 'Bài 80 - Đối mặt thử thách và Quản lý rủi ro', 'Từ vựng về phương pháp giải quyết vấn đề, phòng ngừa hiểm nguy và các chuyến hành trình.', 'HSK 5', 80, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '01535e8a-a316-44e4-b4c5-5ba3dc02a349', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('驾驶', '长途', '陆续', '随时', '难免', '难怪', '面临', '风险', '预防', '避免', '采取', '重复', '重大', '领域');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8fff48bc-bf42-40bd-b45d-3f7a582d759c', 'Bài 81 - Cơ thể và sức khỏe', 'Các bộ phận cơ thể con người và cảm giác thể chất.', 'HSK 5', 81, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '8fff48bc-bf42-40bd-b45d-3f7a582d759c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('眉毛', '睁', '瞎', '瞧', '脖子', '肩膀', '胸', '腰', '背', '脑袋', '肌肉', '胃', '胃口', '着凉');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d0432925-2cde-4cb5-9f00-8c03690fd638', 'Bài 82 - Gia đình và các mối quan hệ', 'Từ vựng về người thân, giao tiếp ứng xử và tình cảm giữa người với người.', 'HSK 5', 82, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd0432925-2cde-4cb5-9f00-8c03690fd638', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('老婆', '舅舅', '离婚', '看望', '祝福', '称呼', '相处', '答应', '舍不得', '私人', '老百姓', '胆小鬼', '看不起');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('40bf2a46-b8b7-4436-8f8f-cd0a9bdd43b6', 'Bài 83 - Tính cách và thế giới nội tâm', 'Miêu tả tính cách con người, cảm xúc và trạng thái tinh thần.', 'HSK 5', 83, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '40bf2a46-b8b7-4436-8f8f-cd0a9bdd43b6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('老实', '能干', '糊涂', '糟糕', '自私', '自觉', '自豪', '自由', '自愿', '盼望', '精神', '精力', '真实', '称赞');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('fda3a5ff-7c2d-41e0-89dd-b2222ad12501', 'Bài 84 - Công sở và thương trường', 'Các thuật ngữ về kinh doanh, tài chính, việc làm và quản lý văn phòng.', 'HSK 5', 84, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'fda3a5ff-7c2d-41e0-89dd-b2222ad12501', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('老板', '秘书', '简历', '签', '经商', '经营', '结账', '股票', '破产', '税', '罚款', '耽误', '硬件');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b04d79b5-f4ed-4f7f-89c0-f467e730407b', 'Bài 85 - Vật dụng và thế giới quanh ta', 'Đồ dùng sinh hoạt hằng ngày, tự nhiên và các đặc điểm của sự vật.', 'HSK 5', 85, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b04d79b5-f4ed-4f7f-89c0-f467e730407b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('窗帘', '肥皂', '胶水', '绳子', '管子', '耳环', '系领带', '竹子', '石头', '粮食', '老鼠', '翅膀', '紫', '臭');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ceebd0cc-c4a8-42d4-9885-6e09597e25dd', 'Bài 86 - Cấu trúc và hệ thống', 'Các khái niệm về phân loại, tổ chức, tổng hợp và kết cấu logic.', 'HSK 5', 86, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ceebd0cc-c4a8-42d4-9885-6e09597e25dd', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('目录', '种类', '类型', '程序', '结构', '系统', '组合', '组成', '组织', '组', '联合', '统一', '综合', '细节');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ba8c0d19-e4e0-4eb7-b998-dc7341786edb', 'Bài 87 - Hành động và sự biến đổi', 'Các động từ chỉ thao tác cụ thể, sự tác động và chuyển biến trạng thái.', 'HSK 5', 87, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ba8c0d19-e4e0-4eb7-b998-dc7341786edb', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('砍', '破坏', '碎', '碰', '粘贴', '绕', '翻', '维修', '缩短', '缓解', '移动', '缺乏', '着火', '系');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d4ad2bc9-c441-490f-8744-cf7653c07355', 'Bài 88 - Thời gian và tiến độ', 'Từ ngữ biểu thị thời gian, sự gấp rút, chờ đợi và nhịp độ công việc.', 'HSK 5', 88, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd4ad2bc9-c441-490f-8744-cf7653c07355', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('目前', '至今', '自从', '至于', '立刻', '立即', '紧急', '等待', '空闲', '稳定', '纪录');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('244496cc-64a5-4f07-9530-6181db8f93b4', 'Bài 89 - Logic, so sánh và mức độ', 'Các từ vựng dùng để lập luận, so sánh mức độ và liên kết ý tưởng.', 'HSK 5', 89, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '244496cc-64a5-4f07-9530-6181db8f93b4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('直', '相似', '相关', '相对', '相当', '矛盾', '等于', '简直', '绝对', '程度', '突出', '结论', '结合', '纷纷');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4dc161a0-77f4-44c3-bd53-436008e1769a', 'Bài 90 - Văn hóa và đời sống xã hội', 'Tìm hiểu về truyền thống, nghệ thuật, trật tự kỷ luật và phát triển xã hội.', 'HSK 5', 90, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4dc161a0-77f4-44c3-bd53-436008e1769a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('秩序', '纪律', '纪念', '移民', '神秘', '神话', '经典', '美术', '胡同', '网络', '背景', '胜利', '繁荣');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('67036d61-3a9b-42fb-96e5-429133945175', 'Bài 91 - Không gian, nhận thức và thuộc tính', 'Từ vựng mô tả không gian, đặc tính chất liệu và quá trình xử lý thông tin.', 'HSK 5', 91, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '67036d61-3a9b-42fb-96e5-429133945175', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('目标', '空间', '窄', '粗糙', '硬', '结实', '省略', '称', '胡说', '确定', '确认', '编辑', '群', '能源', '秘密', '自动');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7717755e-0666-4353-8a8d-d0bc19b0ac9e', 'Bài 1 - Lời hay ý đẹp', 'Các thành ngữ HSK 6 thông dụng dùng để miêu tả tình huống, năng lực và nhận thức.', 'HSK 6', 1, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7717755e-0666-4353-8a8d-d0bc19b0ac9e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一举两得', '一如既往', '一帆风顺', '一目了然', '不可思议', '不屑一顾', '不择手段', '不敢当', '不相上下', '不言而喻', '众所周知', '争先恐后', '任重道远', '优胜劣汰');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('69019b81-e2be-45a7-97f5-cbdbb235d009', 'Bài 2 - Sắc thái ngôn từ', 'Các phó từ chỉ mức độ, tần suất và diễn đạt tâm lý tinh tế trong câu.', 'HSK 6', 2, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '69019b81-e2be-45a7-97f5-cbdbb235d009', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一向', '一贯', '一度', '万分', '不免', '不妨', '不得已', '不惜', '不愧', '不料', '不时', '不止', '不由得', '不禁', '不顾', '与日俱增');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7f9cc08f-5335-48b5-861f-8495f9154ba0', 'Bài 3 - Liên kết văn bản', 'Các liên từ chỉ mục đích, nguyên nhân - hệ quả và từ ngữ trang trọng trong văn viết.', 'HSK 6', 3, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7f9cc08f-5335-48b5-861f-8495f9154ba0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('以便', '以免', '以往', '以至', '以致', '亦', '仍旧', '之际', '为期', '乘', '人为', '人工', '书面');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d7b5d6bc-08a6-44d5-af84-d305763222e9', 'Bài 4 - Chốn công sở', 'Từ vựng về quan hệ cấp bậc, quản trị công việc và các cuộc gặp gỡ chính thức.', 'HSK 6', 4, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd7b5d6bc-08a6-44d5-af84-d305763222e9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('上任', '上级', '下属', '主管', '书记', '任命', '交代', '代理', '事务', '事项', '东道主', '主办', '会晤');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0d1750c5-0847-4e72-9049-ed1903d76663', 'Bài 5 - Thương trường & Kinh tế', 'Thuật ngữ liên quan đến giao dịch thương mại, đàm phán kinh doanh và lợi thế cạnh tranh.', 'HSK 6', 5, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0d1750c5-0847-4e72-9049-ed1903d76663', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('交易', '交涉', '产业', '亏损', '亏待', '专利', '事业', '仓库', '代价', '优先', '优越', '优异', '争夺', '交叉', '亚军');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('047d171e-c534-4040-9775-9949f04f0250', 'Bài 6 - Thời sự & Ngoại giao', 'Từ vựng về các vấn đề xã hội, thể chế chính trị, xung đột và hòa giải quốc tế.', 'HSK 6', 6, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '047d171e-c534-4040-9775-9949f04f0250', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('主权', '主义', '主导', '主流', '中央', '中立', '中断', '争端', '争议', '事态', '事件', '人质', '人道', '举足轻重', '举世瞩目');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('2ab3d109-f961-4390-b30a-f71835a2084d', 'Bài 7 - Nhân cách & Phẩm chất', 'Từ vựng miêu tả nhân tính, phẩm chất đạo đức và phong thái cá nhân.', 'HSK 6', 7, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '2ab3d109-f961-4390-b30a-f71835a2084d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('一丝不苟', '一流', '上进', '争气', '人性', '人格', '仁慈', '丑恶', '任性', '任意', '从容', '乞丐', '个体', '人士', '人家');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b689ffa0-0688-49b6-9d45-2f555e04199a', 'Bài 8 - Cảm xúc & Ứng xử', 'Miêu tả thói quen, tâm lý, thái độ và những hành vi ứng xử thường nhật.', 'HSK 6', 8, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b689ffa0-0688-49b6-9d45-2f555e04199a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('亲密', '亲热', '乐意', '乐趣', '为难', '丢三落四', '丢人', '东张西望', '仓促', '企图', '举动', '上瘾', '不像话', '不堪');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('028da626-8e0d-41f3-9def-7d87b6b9e02d', 'Bài 9 - Văn hóa & Đời sống', 'Từ vựng về nghệ thuật truyền thống, phong tục tập quán và cảnh vật quê hương.', 'HSK 6', 9, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '028da626-8e0d-41f3-9def-7d87b6b9e02d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('书法', '书籍', '乐谱', '习俗', '乡镇', '人间', '亭子', '井', '丘陵', '丛', '乌黑', '丰收', '丰满', '丰盛', '仪式', '世代');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('89755958-598c-42c7-bfd7-05400f6ed99f', 'Bài 10 - Khoa học & Kỷ luật', 'Từ vựng về khoa học tự nhiên, tính chuẩn mực, quy tắc nghiêm ngặt và phân loại.', 'HSK 6', 10, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '89755958-598c-42c7-bfd7-05400f6ed99f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('严厉', '严密', '严寒', '严峻', '严禁', '丧失', '临床', '仪器', '事故', '事迹', '二氧化碳', '专程', '专长', '专题', '上游', '丁', '丙', '串', '丸');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5b18bd29-861f-43ac-9fc4-05ab58a183d3', 'Bài 11 - Gia đình & Đời sống thường nhật', 'Các từ vựng về gia đình, mối quan hệ thân thiết và nếp sinh hoạt đời thường.', 'HSK 6', 11, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5b18bd29-861f-43ac-9fc4-05ab58a183d3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('伯母', '侄子', '伴侣', '保姆', '伺候', '佳肴', '作息', '便条', '保重', '关怀', '关照', '体谅', '伴随', '俗话', '兜');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('203e4c90-a056-4e96-ab45-a1943cb15cf1', 'Bài 12 - Tính cách & Phẩm chất con người', 'Miêu tả tính tình, thái độ ứng xử, phẩm chất đạo đức và trạng thái cảm xúc.', 'HSK 6', 12, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '203e4c90-a056-4e96-ab45-a1943cb15cf1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('伶俐', '倔强', '侥幸', '侃侃而谈', '兢兢业业', '克制', '冲动', '兴致勃勃', '兴高采烈', '体面', '修养', '保守', '健全', '僵硬', '偶像');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('fb1506c1-7700-4a02-82af-1acc8c650cb6', 'Bài 13 - Văn hóa, Phong tục & Vinh quang', 'Khám phá truyền thống văn hóa, lễ nghi, tác phẩm văn học và sự vinh danh.', 'HSK 6', 13, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'fb1506c1-7700-4a02-82af-1acc8c650cb6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('儒家', '农历', '元宵节', '典礼', '典型', '体裁', '传记', '传授', '光彩', '光芒', '光荣', '光辉', '传达', '传单', '公告');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c2b90df9-53d2-4785-a00d-1310dbb786b9', 'Bài 14 - Nhà nước, Chính trị & Xã hội', 'Thuật ngữ về thể chế quốc gia, quân sự, an ninh và quyền nghĩa vụ công dân.', 'HSK 6', 14, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c2b90df9-53d2-4785-a00d-1310dbb786b9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('党', '共和国', '元首', '公民', '使命', '军队', '俘虏', '保卫', '侵犯', '侵略', '倡导', '倡议', '候选', '公关', '公务');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c23432bc-65e5-4462-b229-6a0eb2a87a95', 'Bài 15 - Pháp luật, Công lý & Đạo đức', 'Từ vựng về tính minh bạch, quy tắc pháp lý, gian lận và sự thật.', 'HSK 6', 15, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c23432bc-65e5-4462-b229-6a0eb2a87a95', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('公正', '公道', '公证', '公然', '公认', '公安局', '侦探', '伪造', '作废', '作弊', '冒充', '冒犯', '侮辱', '冤枉', '做主');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3f0f22b8-6ed8-4c9b-948c-70f771d27b75', 'Bài 16 - Kinh tế, Tài chính & Thương mại', 'Chủ đề cung cầu thị trường, tiền tệ, đầu tư kinh doanh và tài sản.', 'HSK 6', 16, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3f0f22b8-6ed8-4c9b-948c-70f771d27b75', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('供给', '供不应求', '倒闭', '债券', '偿还', '储备', '储存', '储蓄', '兑现', '兴旺', '兴隆', '共计', '住宅', '停泊', '停滞');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a18f1b45-bc8c-4211-a561-bc2e790988a0', 'Bài 17 - Công việc & Tinh thần nỗ lực', 'Nói về trách nhiệm nghề nghiệp, xây dựng bảo quản và ý chí phấn đấu.', 'HSK 6', 17, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a18f1b45-bc8c-4211-a561-bc2e790988a0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('作风', '值班', '充实', '充当', '先进', '全力以赴', '再接再厉', '决策', '停顿', '修复', '修建', '保养', '保管', '保密', '保障');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a5be8d34-db79-4f77-ac4b-2e6ead1c7033', 'Bài 18 - Nhận thức, Niềm tin & Đánh giá', 'Diễn đạt niềm tin, các điểm tựa lý luận, thành kiến và sự thấu hiểu.', 'HSK 6', 18, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a5be8d34-db79-4f77-ac4b-2e6ead1c7033', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('依据', '依托', '依赖', '依靠', '借助', '借鉴', '信仰', '信念', '信誉', '信赖', '偏见', '偏差', '倾向', '共鸣', '全局');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ba9a2529-8dd4-42d8-b1bf-cf911e23c034', 'Bài 19 - Tư duy phân tích & Tự nhiên', 'Khám phá cấu trúc, bản chất vấn đề, các hiện tượng xung đột và thiên nhiên.', 'HSK 6', 19, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ba9a2529-8dd4-42d8-b1bf-cf911e23c034', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('体系', '体积', '元素', '公式', '内在', '内涵', '内幕', '侧面', '冲突', '冲击', '伤脑筋', '例外', '冰雹', '倾斜', '俯视');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('88985588-c4c9-4d73-a5a2-1b1d468f3e2b', 'Bài 20 - Điều kiện, Trạng thái & Biến đổi', 'Các liên từ, phó từ chỉ điều kiện, tình huống và sự biến chuyển của sự vật.', 'HSK 6', 20, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '88985588-c4c9-4d73-a5a2-1b1d468f3e2b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('依旧', '便于', '便利', '倘若', '偏偏', '偏僻', '先前', '免得', '况且', '充沛', '充足', '倾听', '免疫', '冷却', '冷落');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d86bf490-45fe-4c9a-abc7-f186021a5e90', 'Bài 21 - Khẩu ngữ và thán từ giao tiếp', 'Những từ cảm thán và quán ngữ thông dụng giúp giao tiếp tự nhiên và sinh động hơn trong đời sống hàng ngày.', 'HSK 6', 21, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd86bf490-45fe-4c9a-abc7-f186021a5e90', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('咋', '啥', '哇', '哦', '哼', '啦', '喂', '嗨', '嘛', '嘿', '呵', '吞吞吐吐', '含糊');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a557742f-1c53-4be8-985c-e1354aa5b61c', 'Bài 22 - Thế giới âm thanh và tiếng ồn', 'Từ vựng diễn tả các loại âm thanh xung quanh, tiếng ồn náo nhiệt và những âm thanh do con người phát ra.', 'HSK 6', 22, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a557742f-1c53-4be8-985c-e1354aa5b61c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('吼', '呼啸', '响亮', '哨', '喇叭', '喧哗', '嘈杂', '噪音', '嚷', '叹气', '呻吟', '哭泣', '哄');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c5520737-2e45-4eee-baf4-5a7c90a4e4eb', 'Bài 23 - Giao tiếp, dặn dò và phong cách nói', 'Các từ vựng về giọng điệu, dặn dò, trao đổi lời nói cũng như thói quen ăn nói thường ngày.', 'HSK 6', 23, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c5520737-2e45-4eee-baf4-5a7c90a4e4eb', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('口头', '口气', '口音', '唠叨', '啰唆', '叮嘱', '吩咐', '告诫', '告辞', '嘱咐', '呼吁', '呼唤', '吹捧', '吹牛');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a3f9577e-108d-4097-920c-2ec743c4fbb8', 'Bài 24 - Bày tỏ chính kiến và tranh luận', 'Các từ vựng nâng cao dùng trong trao đổi quan điểm, phản bác ý kiến, phản hồi và thuyết phục.', 'HSK 6', 24, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a3f9577e-108d-4097-920c-2ec743c4fbb8', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('各抒己见', '反驳', '反馈', '反面', '否决', '响应', '号召', '嘲笑', '唾弃', '含义', '发誓', '固执', '固然');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('29f53ca6-cea4-46ae-8806-b2c65261beaf', 'Bài 25 - Cơ thể và phản ứng sinh lý', 'Tìm hiểu về các bộ phận trên cơ thể con người cùng các hoạt động, phản ứng và tình trạng thể chất.', 'HSK 6', 25, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '29f53ca6-cea4-46ae-8806-b2c65261beaf', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('口腔', '嘴唇', '喉咙', '四肢', '器官', '嗅觉', '咀嚼', '啃', '叼', '呕吐', '喘气', '哺乳', '哆嗦', '发炎');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('42751b23-f6ab-44c0-a04d-427048a5cf36', 'Bài 26 - Cảm xúc, tính cách và phẩm hạnh', 'Từ ngữ miêu tả tâm trạng cảm xúc, nét tính cách cá nhân và phẩm chất đạo đức của con người.', 'HSK 6', 26, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '42751b23-f6ab-44c0-a04d-427048a5cf36', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('发呆', '喜悦', '喜闻乐见', '可恶', '古怪', '吝啬', '君子', '品德', '品质', '和气', '和蔼', '吃苦', '吃力', '受罪');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('68726dd6-95f2-4c62-b395-c2b11a67c910', 'Bài 27 - Quan hệ xã hội và sự gắn kết', 'Từ vựng về tình đồng chí, sự hòa thuận, tinh thần đoàn kết tập thể và hợp tác cùng phát triển.', 'HSK 6', 27, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '68726dd6-95f2-4c62-b395-c2b11a67c910', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('同志', '同胞', '团体', '团结', '团圆', '和睦', '和解', '和谐', '合伙', '合并', '向导', '后代', '后勤', '后顾之忧');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('69979af0-6db4-4b05-978b-4100554d76e1', 'Bài 28 - Nhà nước, pháp luật và tổ chức', 'Các thuật ngữ liên quan đến bộ máy chính quyền, quốc phòng an ninh, pháp luật và quy chế xã hội.', 'HSK 6', 28, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '69979af0-6db4-4b05-978b-4100554d76e1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('国务院', '国防', '司法', '司令', '取缔', '名额', '名誉', '名次', '名副其实', '商标', '回报', '回收', '回避');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3ab5cc69-30d0-4b73-bfdd-a8ccfaee899c', 'Bài 29 - Khởi xướng, phát triển và công bố', 'Các hành động phát động phong trào, công bố thông tin, khai mở và những giai đoạn phát triển ban đầu.', 'HSK 6', 29, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3ab5cc69-30d0-4b73-bfdd-a8ccfaee899c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('发动', '发射', '发布', '发行', '发觉', '发扬', '发育', '发财', '启事', '启示', '启程', '启蒙', '呈现', '命名');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0d740073-3358-434d-8b3c-121c78c686ca', 'Bài 30 - Biến chuyển, kế hoạch và đánh giá', 'Từ vựng phản ánh sự thay đổi của sự vật, quy trình lập kế hoạch và việc cân nhắc, đánh giá hiệu quả.', 'HSK 6', 30, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0d740073-3358-434d-8b3c-121c78c686ca', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('变故', '变质', '变迁', '周密', '周年', '周折', '周期', '周转', '周边', '合成', '合算', '可行', '可观', '回顾');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d77169dd-86cf-4dc8-82f3-d77259edfc7c', 'Bài 31 - Thiên nhiên, đời sống và trải nghiệm', 'Từ vựng về các hiện tượng tự nhiên, đặc tính vật chất, đồ dùng và những trải nghiệm hương vị đời sống.', 'HSK 6', 31, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd77169dd-86cf-4dc8-82f3-d77259edfc7c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('台风', '园林', '固体', '固有', '器材', '品种', '可口', '品尝', '古董', '吉祥', '向往', '向来', '吊', '唯独');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9242162f-d463-489c-a535-3e3563e79868', 'Bài 32 - Bí ẩn của Vũ trụ và Thiên nhiên', 'Tìm hiểu các từ vựng về không gian vũ trụ, thiên văn, tài nguyên và thế giới tự nhiên kỳ thú.', 'HSK 6', 32, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9242162f-d463-489c-a535-3e3563e79868', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('宇宙', '太空', '天文', '天然气', '夕阳', '地质', '地势', '土壤', '坡', '奇妙', '奥秘', '基因', '培育', '孕育', '天堂');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('96066097-890c-48b7-a8bc-c55ac2541621', 'Bài 33 - Kiến trúc và Kết cấu Vật lý', 'Các công trình kiến trúc, đặc điểm địa hình, vật liệu và sự biến đổi vật lý.', 'HSK 6', 33, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '96066097-890c-48b7-a8bc-c55ac2541621', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('城堡', '塔', '堤坝', '基地', '坚固', '坚硬', '坚实', '垂直', '垫', '堆积', '塌', '堵塞', '坑', '孔', '坠');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0a21317c-b763-4f9a-aec4-656ce2d16823', 'Bài 34 - Gia đình, Đời người và Mối quan hệ', 'Từ vựng về các thành viên gia đình, thân phận và các khía cạnh trong đời sống con người.', 'HSK 6', 34, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0a21317c-b763-4f9a-aec4-656ce2d16823', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('夫妇', '夫人', '媳妇', '嫂子', '娃娃', '婴儿', '大伙儿', '天伦之乐', '娇气', '天生', '奴隶', '大臣', '坟墓', '埋葬', '安详');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('1b53d4b8-041d-46a4-85b6-7ddc078ddded', 'Bài 35 - Tâm lý, Cảm xúc và Thái độ sống', 'Khám phá thế giới nội tâm, tính cách, tâm trạng và cách phản ứng của con người.', 'HSK 6', 35, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '1b53d4b8-041d-46a4-85b6-7ddc078ddded', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('外向', '孤独', '孤立', '嫉妒', '嫌', '在意', '埋怨', '坦白', '坚定', '坚韧', '妄想', '姿态', '宁愿', '宁肯', '安宁');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('838c200c-b858-4391-b9a6-c498cf4c143d', 'Bài 36 - Pháp luật, Điều tra và Biến cố', 'Từ vựng liên quan đến xét xử tư pháp, giải quyết sai phạm, bẫy rập và các tình huống nguy hiểm.', 'HSK 6', 36, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '838c200c-b858-4391-b9a6-c498cf4c143d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('审判', '审查', '审理', '嫌疑', '处分', '处境', '处置', '圈套', '埋伏', '子弹', '失事', '失误', '失踪', '堕落', '埋没');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('65300d74-0b5c-43f1-9235-96ef8dab963b', 'Bài 37 - Kinh doanh, Tài chính và Thị trường', 'Các thuật ngữ về hoạt động thương mại, khách hàng, tài chính và sự vận hành kinh tế.', 'HSK 6', 37, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '65300d74-0b5c-43f1-9235-96ef8dab963b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('客户', '基金', '垄断', '实力', '实惠', '季度', '季军', '奢侈', '定期', '备份', '备忘录', '媒介', '外行', '多元化', '地步');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('959cf627-8982-4585-9291-2116d2c95f64', 'Bài 38 - Quản trị, Kế hoạch và Thực thi', 'Nói về công tác điều hành, bổ nhiệm, thỏa thuận và triển khai các kế hoạch thực tế.', 'HSK 6', 38, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '959cf627-8982-4585-9291-2116d2c95f64', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('官方', '委员', '委托', '实施', '实行', '完毕', '完备', '安置', '妥善', '妥当', '妥协', '姑且', '宗旨', '奠定', '守护');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('1d65a841-0817-41ee-9bd0-94afccb1f6f4', 'Bài 39 - Tư duy, Văn hóa và Học thuật', 'Các khái niệm về nghiên cứu học thuật, tôn giáo, mỹ thuật và nhận thức thế giới khách quan.', 'HSK 6', 39, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '1d65a841-0817-41ee-9bd0-94afccb1f6f4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('宗教', '学说', '学位', '定义', '实事求是', '实质', '宏观', '宏伟', '境界', '审美', '图案', '墨水儿', '塑造', '外表', '外界');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d90ebc6d-f3f8-4364-a3e6-5e8fe069562b', 'Bài 40 - Tài năng, Vinh quang và Uy tín', 'Các từ ngữ ca ngợi tài năng kiệt xuất, quyền uy, phần thưởng và sự cống hiến lớn lao.', 'HSK 6', 40, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd90ebc6d-f3f8-4364-a3e6-5e8fe069562b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('天才', '天赋', '威信', '威望', '威风', '威力', '声誉', '声明', '声势', '奉献', '奖励', '奖赏', '壮丽', '壮烈', '圆满');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f1486548-42df-4b91-bf25-270593aef0f5', 'Bài 41 - Nhịp sống, Khung cảnh và Diễn biến', 'Mô tả hoàn cảnh xã hội, cảnh tượng náo nhiệt, sự biến chuyển và mức độ của sự việc.', 'HSK 6', 41, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f1486548-42df-4b91-bf25-270593aef0f5', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('场合', '场所', '场面', '增添', '壮观', '复兴', '复活', '大不了', '大体', '大意', '大肆', '大致', '夹杂', '奔波', '奔驰');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3683db76-06b0-42de-b794-bbc8ea24cc72', 'Bài 42 - Pháp luật và Công lý', 'Từ vựng về tội phạm, thủ tục tố tụng, xét xử và các biện pháp cưỡng chế pháp luật.', 'HSK 6', 42, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3683db76-06b0-42de-b794-bbc8ea24cc72', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('刑事', '判决', '原告', '凶手', '凶恶', '包庇', '勾结', '出卖', '制裁', '制止', '压制', '压迫', '压榨');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9d2758c1-a43e-46a3-8858-6d4b74cd5075', 'Bài 43 - Khát vọng và Ý chí vươn lên', 'Nói về tinh thần khởi nghiệp, sáng tạo, ý chí kiên trì vượt khó và tiền đồ tương lai.', 'HSK 6', 43, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9d2758c1-a43e-46a3-8858-6d4b74cd5075', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('创业', '创新', '创立', '创作', '力争', '力求', '力所能及', '勇于', '勉励', '勤劳', '勤俭', '千方百计', '半途而废', '出息');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('2ec29f1e-e568-4018-86fa-9bc559aacc36', 'Bài 44 - Hợp tác và Nơi làm việc', 'Các thuật ngữ về tổ chức đoàn thể, phối hợp công việc, truyền thông và quyền lợi nhân sự.', 'HSK 6', 44, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '2ec29f1e-e568-4018-86fa-9bc559aacc36', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('协会', '协助', '协商', '协议', '协调', '助手', '助理', '参谋', '动员', '剪彩', '博览会', '刊登', '刊物', '分红');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('1e7f7414-40dc-4f88-9831-63a93a999463', 'Bài 45 - Thế giới nội tâm và Cảm xúc', 'Khám phá tâm lý, thái độ, nhân cách và những trạng thái cảm xúc tinh tế của con người.', 'HSK 6', 45, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '1e7f7414-40dc-4f88-9831-63a93a999463', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('冷酷', '凄凉', '厌恶', '反感', '反思', '别扭', '出神', '压抑', '勉强', '卑鄙', '卓越', '分寸', '凑合', '凝视');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('36f68fb6-7cc2-4db4-b0a9-6de1f67cc2b0', 'Bài 46 - Tư duy phản biện và Tranh luận', 'Từ vựng hỗ trợ lập luận logic, đối chiếu sự việc, phân tích mâu thuẫn và biện giải quan điểm.', 'HSK 6', 46, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '36f68fb6-7cc2-4db4-b0a9-6de1f67cc2b0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('准则', '前提', '原理', '参照', '分辨', '区分', '划分', '分歧', '分明', '反之', '反问', '列举', '南辕北辙', '切实');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9bb73321-5f13-40c7-b963-5de0cf60f465', 'Bài 47 - Khoa học, Tự nhiên và Khám phá', 'Các khái niệm về sinh học, hóa học, địa lý và quá trình nghiên cứu tự nhiên.', 'HSK 6', 47, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9bb73321-5f13-40c7-b963-5de0cf60f465', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('化石', '化肥', '化验', '勘探', '动脉', '分泌', '凝固', '冻结', '北极', '卫星', '反射', '凹凸', '分解', '原始');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c75de9f0-8768-425c-b406-35ba1cd0a161', 'Bài 48 - Đời sống, Văn hóa và Xã hội', 'Khám phá phong tục truyền thống, xuất thân, thẩm mỹ và những nét sinh hoạt đời thường.', 'HSK 6', 48, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c75de9f0-8768-425c-b406-35ba1cd0a161', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('华丽', '华侨', '历代', '历来', '博大精深', '出身', '别墅', '别致', '卡通', '剧本', '压岁钱', '双胞胎', '包装', '化妆');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e2afaf1c-10f1-45b2-b52c-cecbe6984a99', 'Bài 49 - Biến động và Tình thế cấp bách', 'Mô tả động lực, biến chuyển nhanh chóng, nguy cơ khủng hoảng và các thời khắc quyết định.', 'HSK 6', 49, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e2afaf1c-10f1-45b2-b52c-cecbe6984a99', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('动力', '动态', '动机', '动荡', '动身', '动静', '势力', '势必', '危机', '加剧', '剧烈', '削弱', '刻不容缓', '刹车');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('efcf5472-6918-409a-807d-e4f49aac5eff', 'Bài 50 - Hành động, Xung đột và Chiến thuật', 'Các từ chỉ hành động can thiệp, tấn công, phòng vệ, phong tỏa và phương thức giải quyết xung đột.', 'HSK 6', 50, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'efcf5472-6918-409a-807d-e4f49aac5eff', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('包围', '包袱', '占据', '占领', '剑', '刺', '削', '割', '劈', '剥削', '反抗', '动手', '制服', '制约', '分散', '分裂');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f8d68160-2b46-4aef-b165-a772a399e9fc', 'Bài 51 - Thời gian và Bước chuyển mới', 'Nói về thời điểm, bước chuẩn bị ban đầu, điều kiện diễn tiến và định hướng tương lai.', 'HSK 6', 51, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f8d68160-2b46-4aef-b165-a772a399e9fc', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('凌晨', '刹那', '即将', '及早', '原先', '初步', '前景', '凡是', '即便', '务必', '出路', '反常');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d89819f8-c403-4cf6-a008-d99096c73cc6', 'Bài 52 - Thành quả, Năng lực và Quy mô', 'Đánh giá công lao, hiệu quả thực tế, sức ảnh hưởng và các quy chuẩn phân định kết quả.', 'HSK 6', 52, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd89819f8-c403-4cf6-a008-d99096c73cc6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('功劳', '功效', '加工', '压缩', '凝聚', '分量', '十足', '利害', '区域', '卷', '副');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('56dd5fcf-154b-42dc-a93d-12fcc8ec28f6', 'Bài 53 - Nhà nước và Trật tự xã hội', 'Từ vựng về thể chế chính trị, pháp luật, quân sự và an ninh quốc gia.', 'HSK 6', 53, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '56dd5fcf-154b-42dc-a93d-12fcc8ec28f6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('宪法', '宣誓', '宣扬', '废除', '封建', '封锁', '封闭', '局势', '局面', '廉洁', '州', '将军', '屈服', '巡逻', '导弹');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f606ccd8-f822-4bb5-9cb4-7b3fbe3656ff', 'Bài 54 - Đương đầu với thách thức', 'Các từ vựng về mâu thuẫn, trở ngại, sự cố bất ngờ và chiến lược ứng phó.', 'HSK 6', 54, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f606ccd8-f822-4bb5-9cb4-7b3fbe3656ff', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('对抗', '对立', '对付', '对策', '干扰', '干涉', '干预', '屏障', '崩溃', '弊端', '弊病', '异常', '尴尬', '尖锐', '岔');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('47c83af4-0339-43b6-9b9c-c0437fab5866', 'Bài 55 - Thiên nhiên và Cảnh quan', 'Khám phá địa hình tự nhiên, cảnh vật sông núi và các hiện tượng môi trường.', 'HSK 6', 55, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '47c83af4-0339-43b6-9b9c-c0437fab5866', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('山脉', '峡谷', '岩石', '平原', '平坦', '广阔', '宽敞', '开阔', '干旱', '废墟', '巢穴', '寂静', '弥漫', '庄稼', '川流不息');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9a532c3e-2e1e-4f86-ae84-7d5ad9f72b05', 'Bài 56 - Không gian sống và Kiến trúc', 'Từ vựng về nơi cư trú, các công trình xây dựng, đồ dùng và sắp đặt không gian.', 'HSK 6', 56, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9a532c3e-2e1e-4f86-ae84-7d5ad9f72b05', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('宫殿', '寺庙', '居住', '居民', '幢', '巷', '帐篷', '床单', '容器', '容纳', '密封', '就近', '布局', '布置', '庞大');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('568ce8c3-bb2b-4ec9-aec4-4c3b5bb8ecc6', 'Bài 57 - Sự nghiệp và Lao động', 'Các thuật ngữ về tìm kiếm việc làm, quản trị, khai phá và nỗ lực cống hiến.', 'HSK 6', 57, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '568ce8c3-bb2b-4ec9-aec4-4c3b5bb8ecc6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('就业', '就职', '岗位', '开拓', '开辟', '开展', '开采', '开支', '开除', '履行', '巩固', '干劲', '废寝忘食', '带领', '尝试');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('320cd926-7761-42bf-bb51-e385e56f5b9a', 'Bài 58 - Nhân cách và Phẩm chất', 'Mô tả tính cách, nội tâm, thái độ xử thế và các giá trị đạo đức.', 'HSK 6', 58, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '320cd926-7761-42bf-bb51-e385e56f5b9a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('庄严', '庄重', '宽容', '容忍', '尊严', '崇高', '崇拜', '崇敬', '开朗', '开明', '平庸', '平凡', '庸俗', '幼稚', '寄托');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('1403623c-5b6d-4822-b5b2-ed29986f9097', 'Bài 59 - Đời sống và Giao tiếp thường nhật', 'Quan hệ gia đình, cơ thể người, cách ứng xử và sinh hoạt hằng ngày.', 'HSK 6', 59, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '1403623c-5b6d-4822-b5b2-ed29986f9097', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('家属', '岳母', '家伙', '家常', '容貌', '屁股', '尸体', '寒暄', '应酬', '应邀', '巴结', '巴不得', '小心翼翼', '宰', '岂有此理');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f7c6ca8f-628d-49bf-8d22-091fe3f59205', 'Bài 60 - Khoa học, Công nghệ và Đo lường', 'Từ vựng chuyên môn về công nghệ, chỉ số kỹ thuật, bình diện và tính đối xứng.', 'HSK 6', 60, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f7c6ca8f-628d-49bf-8d22-091fe3f59205', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('导航', '引擎', '导向', '尖端', '屏幕', '密度', '幅度', '层次', '局部', '局限', '平行', '平面', '对称', '对照', '对应');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('cdf75aa1-c33b-470f-96eb-f8a3fab5fa22', 'Bài 61 - Thời gian và Biến chuyển', 'Diễn đạt dòng chảy thời gian, tiến trình thay đổi và so sánh trạng thái.', 'HSK 6', 61, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'cdf75aa1-c33b-470f-96eb-f8a3fab5fa22', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('岁月', '年度', '延期', '延续', '延伸', '屡次', '层出不穷', '崭新', '将近', '将就', '富裕', '差别', '并列', '并非', '尚且');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a33ad613-f868-4b57-81fc-fcc67e193226', 'Bài 62 - Văn hóa và Tư tưởng biểu đạt', 'Nghệ thuật ngôn từ, truyền thống văn hóa, giáo dục và định hướng tương lai.', 'HSK 6', 62, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a33ad613-f868-4b57-81fc-fcc67e193226', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('家喻户晓', '寓言', '对联', '座右铭', '序言', '引用', '引导', '展望', '展现', '展示', '工艺品', '师范', '布告', '寻觅', '屑');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e6a41f53-620e-4d1f-aa00-68c48ff305e2', 'Bài 63 - Bão táp cảm xúc', 'Các từ vựng biểu đạt nỗi sợ hãi, phẫn nộ, ngạc nhiên và nỗi buồn sâu sắc.', 'HSK 6', 63, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e6a41f53-620e-4d1f-aa00-68c48ff305e2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('恐吓', '恐怖', '恐惧', '惊动', '惊奇', '惊讶', '愣', '恼火', '愤怒', '恶心', '悔恨', '惋惜', '悲哀', '悲惨', '忧郁');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7549b329-664a-4e59-8820-f07e42713b6d', 'Bài 64 - Thế giới nội tâm', 'Khám phá tâm tư, sự sẻ chia, nỗi nhớ nhung và những cung bậc tình cảm tinh tế.', 'HSK 6', 64, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7549b329-664a-4e59-8820-f07e42713b6d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('心态', '心灵', '心疼', '心甘情愿', '心眼儿', '心血', '快活', '思念', '惦记', '慰问', '憋', '恩怨', '恨不得', '恍然大悟', '感慨');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('31f3eafa-49e7-46d1-8fee-b4e7d0f4506b', 'Bài 65 - Tính cách và nhân cách', 'Miêu tả đạo đức, khí phách con người cùng những thói quen và tính cách cần lưu ý.', 'HSK 6', 65, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '31f3eafa-49e7-46d1-8fee-b4e7d0f4506b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('忠实', '忠诚', '恭敬', '恳切', '慈祥', '慈善', '慷慨', '慎重', '志气', '怠慢', '急躁', '懒惰', '愚昧', '愚蠢', '忌讳');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b97d2635-ccc7-4609-bb2d-c3aa174c5e47', 'Bài 66 - Tư duy và ý chí', 'Các từ ngữ liên quan đến năng lực nhận thức, quá trình suy ngẫm, ý đồ và sự kiên định.', 'HSK 6', 66, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b97d2635-ccc7-4609-bb2d-c3aa174c5e47', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('心得', '思索', '思维', '意向', '意味着', '意图', '意志', '意料', '意识', '忍受', '忍耐', '想方设法', '悬念', '忽略', '惯例');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('11b84466-bcd5-4e4e-b817-56af3d8c4762', 'Bài 67 - Chiến trận và xung đột', 'Chủ đề tranh chấp, đối đầu quân sự, chiến lược tác chiến và các biện pháp cưỡng chế.', 'HSK 6', 67, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '11b84466-bcd5-4e4e-b817-56af3d8c4762', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('打仗', '打击', '打架', '战斗', '战役', '战术', '战略', '征服', '戒备', '惹祸', '惩罚', '强制', '强迫', '打官司', '得罪');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c4b1678b-ad92-47f3-a91a-5799383d69e2', 'Bài 68 - Hành động và cảm quan', 'Các động tác cơ thể cụ thể, sự quan sát không gian và đặc tính vật chất đời sống.', 'HSK 6', 68, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c4b1678b-ad92-47f3-a91a-5799383d69e2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('扑', '扒', '扎', '扛', '托运', '打包', '打猎', '打量', '手势', '徘徊', '悬挂', '悬崖峭壁', '弦', '扁', '弹性');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8cf917c1-81c5-4dcf-b318-e435f691177f', 'Bài 69 - Thời gian và tiến trình', 'Các từ chỉ mốc thời gian, tính cấp bách, chu kỳ lặp lại và nhịp độ phát triển.', 'HSK 6', 69, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '8cf917c1-81c5-4dcf-b318-e435f691177f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('当代', '当初', '当前', '当场', '当面', '当务之急', '往事', '往常', '截止', '截至', '成天', '慢性', '循序渐进', '循环', '急剧');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6ac49ee2-c652-460b-b4e1-7966f1a7262c', 'Bài 70 - Sự nghiệp và kinh doanh', 'Từ vựng về tài năng nghề nghiệp, thái độ làm việc, quản lý chi phí và kết quả hợp tác.', 'HSK 6', 70, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '6ac49ee2-c652-460b-b4e1-7966f1a7262c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('才干', '手法', '手艺', '扎实', '得力', '徒弟', '忙碌', '急于求成', '急功近利', '急切', '成心', '成效', '成本', '成员', '成交');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5b3e1083-a8f3-46a4-9896-9255e3a878c2', 'Bài 71 - Đánh giá và suy luận', 'Các từ ngữ dùng để so sánh được mất, đánh giá mức độ tương quan và đúc kết kết luận.', 'HSK 6', 71, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5b3e1083-a8f3-46a4-9896-9255e3a878c2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('恰到好处', '恰巧', '恰当', '得天独厚', '得不偿失', '微不足道', '悬殊', '弥补', '弱点', '恶化', '愈', '感染', '归根到底', '总而言之', '总和');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e701ca5a-5ae2-44a8-9d6f-c44fced9fcdf', 'Bài 72 - Xã hội và đời sống thực tế', 'Thuật ngữ liên quan đến pháp luật, sức khỏe, tình hình thực tế và hiện tượng xã hội.', 'HSK 6', 72, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e701ca5a-5ae2-44a8-9d6f-c44fced9fcdf', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('归还', '当事人', '当选', '征收', '情形', '情报', '情理', '情节', '患者', '性命', '性感', '性能', '彩票', '微观', '形态');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6e39bb7a-e690-4efc-ba5e-de326dde4d1e', 'Bài 73 - Bản lĩnh và Khí chất', 'Các từ vựng miêu tả phẩm chất xuất chúng, ý chí kiên định và phong thái của con người.', 'HSK 6', 73, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '6e39bb7a-e690-4efc-ba5e-de326dde4d1e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('杰出', '果断', '树立', '榜样', '模范', '毅力', '毅然', '泰斗', '正义', '正气', '气质', '气魄', '气概');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4bccaeee-8c9f-4f0e-ba5f-77d6bf3c045a', 'Bài 74 - Cảm xúc và Thế giới nội tâm', 'Từ vựng về tâm trạng, cảm xúc tích cực lẫn tiêu cực và trạng thái tinh thần.', 'HSK 6', 74, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4bccaeee-8c9f-4f0e-ba5f-77d6bf3c045a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('欢乐', '欣慰', '欣欣向荣', '欲望', '枯燥', '沉思', '沉着', '沉重', '沉闷', '沮丧', '泄气', '津津有味', '活力', '正经');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e5e98a6b-fef2-4f02-a34a-75721d6f2c5f', 'Bài 75 - An ninh và Trật tự xã hội', 'Chủ đề liên quan đến hành vi phạm pháp, bạo lực, đấu tranh phòng chống tội phạm.', 'HSK 6', 75, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e5e98a6b-fef2-4f02-a34a-75721d6f2c5f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('查获', '治安', '歹徒', '殴打', '欺负', '欺骗', '毒品', '武器', '武装', '残忍', '残酷', '毁灭', '棍棒', '杜绝');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9d132854-9a99-4f9b-a5cb-f98ea2210446', 'Bài 76 - Pháp luật và Thể chế', 'Các thuật ngữ về luật pháp, quy định, quản trị nhà nước và quyền công dân.', 'HSK 6', 76, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9d132854-9a99-4f9b-a5cb-f98ea2210446', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('条款', '条约', '法人', '治理', '案件', '案例', '档案', '殖民地', '民主', '民间', '束缚', '歧视', '武侠', '正规');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4e312c92-f34f-4943-867c-76aca663d05f', 'Bài 77 - Ngôn ngữ và Truyền thông', 'Từ vựng về tư duy ngôn ngữ, giao tiếp, phản hồi và các hoạt động báo chí truyền thông.', 'HSK 6', 77, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4e312c92-f34f-4943-867c-76aca663d05f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('构思', '比喻', '比方', '标题', '栏目', '汇报', '歌颂', '污蔑', '检讨', '泄露', '沾光', '母语', '注释', '歪曲');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8b3fac2d-d57d-45e0-bc06-99780829f752', 'Bài 78 - Thế giới Thực vật và Tự nhiên', 'Từ ngữ miêu tả cây cối, sự sinh trưởng, môi trường sinh thái và diện mạo tự nhiên.', 'HSK 6', 78, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '8b3fac2d-d57d-45e0-bc06-99780829f752', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('枝', '梢', '株', '栽培', '枯萎', '棉花', '根深蒂固', '标本', '沼泽', '沿海', '气象', '气味', '气色');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('83a3565c-362c-4643-a1c1-f2b085a26156', 'Bài 79 - Sông nước và Vật chất lỏng', 'Các hiện tượng tự nhiên liên quan đến nước, sóng gió, chất lỏng và sự biến đổi trạng thái.', 'HSK 6', 79, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '83a3565c-362c-4643-a1c1-f2b085a26156', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('洪水', '泛滥', '汹涌', '波浪', '波涛', '泡沫', '沸腾', '沉淀', '沐浴', '泼', '水利', '水泥', '水龙头', '氧气');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c7a95969-1966-4c9c-8f9d-c42171b59363', 'Bài 80 - Mô hình, Tiêu chuẩn và Kết cấu', 'Các từ vựng về cấu trúc, khuôn mẫu, quy cách kỹ thuật và kiểm định chất lượng.', 'HSK 6', 80, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c7a95969-1966-4c9c-8f9d-c42171b59363', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('框架', '格局', '格式', '模型', '模式', '模样', '样品', '档次', '次品', '次序', '检验', '标记', '桥梁', '杠杆');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8bc5202e-6d91-4e12-9fa4-d636e656c9d4', 'Bài 81 - Đời sống và Tiêu dùng thường nhật', 'Các vật dụng sinh hoạt, màu sắc, hình khối, ẩm thực và văn hóa ứng xử hàng ngày.', 'HSK 6', 81, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '8bc5202e-6d91-4e12-9fa4-d636e656c9d4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('枕头', '柴油', '油漆', '油腻', '款式', '款待', '正宗', '正月', '橙', '棕色', '柔和', '染', '椭圆');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6caa7468-d569-486a-9563-a77f19c6e46e', 'Bài 82 - Hành động, Chuyển động và Tình trạng cơ thể', 'Các từ ngữ chỉ động tác cụ thể, cử chỉ tập trung, di chuyển và trạng thái sinh học.', 'HSK 6', 82, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '6caa7468-d569-486a-9563-a77f19c6e46e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('步伐', '桨', '横', '注视', '注重', '注射', '气势', '气功', '气压', '残留', '残疾', '死亡', '来历');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('97b0f3b6-627b-4e39-a465-e1813cc9d03d', 'Bài 83 - Đo lường và Khái niệm trừu tượng', 'Hệ thống lượng từ, đơn vị đo, tư duy logic, nguồn gốc và các quy luật mang tính triết lý.', 'HSK 6', 83, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '97b0f3b6-627b-4e39-a465-e1813cc9d03d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('束', '枚', '栋', '来源', '根源', '条理', '极端', '极限', '比重', '毫无', '毫米', '永恒', '正当', '正负');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('175a7cb8-ce59-4b22-ad3e-66d99bf099bc', 'Bài 84 - Khéo léo đôi tay', 'Các động tác tỉ mỉ và thao tác đồ vật quen thuộc hàng ngày bằng bàn tay', 'HSK 6', 84, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '175a7cb8-ce59-4b22-ad3e-66d99bf099bc', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('拧', '拨', '拽', '拣', '拾', '捏', '捞', '掏', '掐', '掰', '揉', '搓', '捧', '捎', '搁');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5c9918e4-72a5-4686-929a-0cc6fb22a561', 'Bài 85 - Cử chỉ & Đồ dùng sinh hoạt', 'Các cử chỉ tiếp xúc, chăm sóc cơ thể cùng những vật dụng sinh hoạt gần gũi', 'HSK 6', 85, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5c9918e4-72a5-4686-929a-0cc6fb22a561', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('抚摸', '按摩', '搂', '搀', '拄', '拐杖', '拳头', '指甲', '挎', '携带', '捆绑', '搅拌', '摊', '把手', '插座');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f4ecc2a3-f540-4fa1-ba7d-434beadc08ba', 'Bài 86 - Ý chí & Vượt qua thử thách', 'Nói về hoài bão, nỗ lực phấn đấu bền bỉ và xoay chuyển tình thế trong cuộc sống', 'HSK 6', 86, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f4ecc2a3-f540-4fa1-ba7d-434beadc08ba', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('抱负', '执着', '拼命', '拼搏', '挣扎', '持久', '挺拔', '振兴', '振奋', '扭转', '挽回', '挽救', '摆脱', '拥有', '拿手');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4b644ee5-1243-49ba-839b-8d193d63d17a', 'Bài 87 - Khám phá & Tư duy nghiên cứu', 'Từ vựng về quá trình tìm tòi, thăm dò thực tế và tư duy suy luận khoa học', 'HSK 6', 87, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4b644ee5-1243-49ba-839b-8d193d63d17a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('探索', '探讨', '探测', '挖掘', '推测', '推理', '推论', '推翻', '描绘', '提炼', '拟定', '摘要', '技巧', '指南针', '据悉');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('aac59fa8-76f4-4bdd-b2e9-4f0c42145678', 'Bài 88 - Điều hành & Quản lý công việc', 'Giao phó chỉ thị, cộng tác làm việc và bảo đảm chất lượng trong công sở', 'HSK 6', 88, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'aac59fa8-76f4-4bdd-b2e9-4f0c42145678', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('执行', '指令', '指示', '指定', '指标', '指望', '提示', '提议', '提拔', '把关', '承办', '承包', '承诺', '搭档', '搭配');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c0f8db18-7851-489b-ab6e-17de6d55b2c2', 'Bài 89 - Kinh doanh & Thị trường', 'Các hoạt động thương mại, tài chính, thanh toán và mở rộng quy mô kinh tế', 'HSK 6', 89, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c0f8db18-7851-489b-ab6e-17de6d55b2c2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('批发', '推销', '招标', '招收', '报酬', '报销', '投机', '担保', '扩充', '扩张', '扩散', '扣', '拖延', '拔苗助长', '排放');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d144ba45-ec59-4b2e-826f-3eb478792699', 'Bài 90 - Lễ nghi & Đời sống xã hội', 'Thăm hỏi xã giao, thái độ ứng xử cùng các hoạt động văn hóa cộng đồng', 'HSK 6', 90, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd144ba45-ec59-4b2e-826f-3eb478792699', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('拜年', '拜访', '拜托', '探望', '报答', '抚养', '拥护', '授予', '扮演', '排练', '投票', '投诉', '搭', '接连', '摇滚');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('117e76fd-ebcf-4cf9-b928-ce90eb55c126', 'Bài 91 - Bất đồng & Xung đột', 'Thể hiện sự phản đối, phê phán, khiêu khích và các hành vi gây rối', 'HSK 6', 91, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '117e76fd-ebcf-4cf9-b928-ce90eb55c126', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('批判', '抗议', '抵制', '抵抗', '投降', '挑剔', '挑拨', '挑衅', '指责', '扰乱', '捣乱', '排斥', '排除', '抹杀', '折腾');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('816080fe-b331-4d5a-9133-4953c60c5421', 'Bài 92 - Pháp luật & Đấu tranh an ninh', 'Hành vi vi phạm pháp luật, bảo vệ trật tự an ninh và vạch trần chân tướng', 'HSK 6', 92, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '816080fe-b331-4d5a-9133-4953c60c5421', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('抢劫', '掠夺', '搏斗', '揍', '报警', '拘留', '拘束', '报仇', '报复', '捍卫', '捕捉', '揭露', '掩护', '掩盖', '掩饰');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0a22f7f3-6a7e-4ca7-86cd-89891e909519', 'Bài 93 - Biến cố & Thay đổi', 'Đối mặt với những rủi ro, tổn thất, cứu nạn cùng các hiện tượng biến động', 'HSK 6', 93, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0a22f7f3-6a7e-4ca7-86cd-89891e909519', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('折磨', '挫折', '摧残', '损坏', '抛弃', '抢救', '折', '挥霍', '抵达', '掀起', '摇摆', '投掷', '挨', '挪', '摄氏度');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3eebf7a2-cf4d-4de4-9170-b28f0a2ad0d3', 'Bài 94 - Hành động & Thao tác', 'Các động từ mô tả hành động tay chân, sự vận động và thao tác cụ thể', 'HSK 6', 94, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3eebf7a2-cf4d-4de4-9170-b28f0a2ad0d3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('摩擦', '摸索', '撇', '撤退', '撤销', '播种', '操作', '操练', '攀登', '攒', '收缩', '收藏', '敞开', '旋转', '晾');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d7cae04a-ff8e-4008-a253-edce767ff5be', 'Bài 95 - Kinh tế & Tài chính', 'Từ vựng về thu chi, ngân sách, nguồn lực và lợi ích kinh tế', 'HSK 6', 95, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd7cae04a-ff8e-4008-a253-edce767ff5be', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('支出', '支援', '支撑', '支柱', '支流', '支配', '收益', '效益', '数额', '本钱', '昂贵', '普及', '无偿', '救济');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ea173000-482f-4523-b58c-c6deb0958030', 'Bài 96 - Chính trị & Quyền lực', 'Các khái niệm về đường lối chính sách, cơ quan quyền lực và đấu tranh xã hội', 'HSK 6', 96, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ea173000-482f-4523-b58c-c6deb0958030', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('政权', '政策', '方针', '机构', '权威', '权衡', '斗争', '整顿', '晋升', '敌视', '攻克', '攻击', '旗帜', '服从');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('39996ca3-9afb-4813-8e89-bbb60607093b', 'Bài 97 - Trí tuệ & Năng lực', 'Từ vựng diễn đạt khả năng tư duy, sự nhanh nhạy và tài năng của con người', 'HSK 6', 97, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '39996ca3-9afb-4813-8e89-bbb60607093b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('擅长', '操劳', '操纵', '敏捷', '敏锐', '明智', '智力', '智商', '智能', '本事', '本能', '机动', '机械', '机智', '机灵');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('dc18d976-6ce7-4355-94db-28fb63bb4869', 'Bài 98 - Văn hóa & Nghệ thuật', 'Các phương diện về văn học, văn vật, âm nhạc và phong thái tao nhã', 'HSK 6', 98, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'dc18d976-6ce7-4355-94db-28fb63bb4869', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('散文', '文凭', '文物', '文献', '文艺', '文雅', '斯文', '旋律', '曲子', '旗袍', '方言', '杂技', '收音机');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e7654cd0-5aca-42ab-89d9-52b59795a1c1', 'Bài 99 - Thời gian & Không gian', 'Các từ chỉ dòng chảy thời gian, thời đại, phương hướng và tự nhiên', 'HSK 6', 99, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e7654cd0-5aca-42ab-89d9-52b59795a1c1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('日新月异', '日益', '时事', '时光', '时常', '时而', '昔日', '昼夜', '朝代', '期限', '方位', '方圆', '晴朗');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('fc16c3ca-34ed-41bc-be3f-886f6d57ad2e', 'Bài 100 - Thái độ & Cảm xúc', 'Biểu hiện tâm lý, tinh thần trách nhiệm và thái độ sống', 'HSK 6', 100, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'fc16c3ca-34ed-41bc-be3f-886f6d57ad2e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('敬业', '敬礼', '敷衍', '服气', '期望', '朝气蓬勃', '朴实', '朴素', '无动于衷', '无微不至', '无忧无虑', '无精打采');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('fb9cd0bd-e214-4d57-adcb-3c39379a7970', 'Bài 101 - Đạo đức & Hành vi', 'Các chuẩn mực ứng xử xã hội, hành vi sai trái và đánh giá phẩm chất', 'HSK 6', 101, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'fb9cd0bd-e214-4d57-adcb-3c39379a7970', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('撒谎', '擅自', '教养', '是非', '暴力', '无理取闹', '无知', '无耻', '无能为力', '无赖', '无辜', '昏迷', '旷课');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('873e1ebe-11c8-40ac-9141-e585ec1265e1', 'Bài 102 - Quyết định & Công bố', 'Từ vựng liên quan đến việc cân nhắc, đưa ra phán đoán và công khai thông tin', 'HSK 6', 102, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '873e1ebe-11c8-40ac-9141-e585ec1265e1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('斟酌', '斩钉截铁', '断定', '断绝', '施加', '施展', '散发', '散布', '暴露', '曝光', '更正', '有条不紊', '显著', '晃');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('118a3bab-b56d-42c0-be63-8a72337dae42', 'Bài 103 - Đổi mới & Đời sống', 'Sự phát triển, biến chuyển của sự vật và các cột mốc trong cuộc sống', 'HSK 6', 103, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '118a3bab-b56d-42c0-be63-8a72337dae42', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('新娘', '新郎', '新陈代谢', '新颖', '故乡', '故障', '改良', '放大', '放射', '斑', '曲折', '更新', '杂交', '昌盛');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('eb7cc30a-d704-4057-a005-98e77bb68986', 'Bài 104 - Cơ hội & Nhận định', 'Từ vựng về bản thân, thời cơ, các phó từ ngữ khí và mức độ', 'HSK 6', 104, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'eb7cc30a-d704-4057-a005-98e77bb68986', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('本人', '本身', '机密', '机遇', '时机', '无比', '无穷无尽', '无非', '未免', '明明', '暂且', '暗示', '暧昧');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('746e38b8-599b-4966-b811-d879014980aa', 'Bài 105 - Biển cả và dòng nước', 'Khám phá địa lý tự nhiên, sông hồ, thác nước và cảnh sắc thiên nhiên.', 'HSK 6', 105, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '746e38b8-599b-4966-b811-d879014980aa', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('海拔', '海滨', '湖泊', '港口', '港湾', '溪', '瀑布', '淡水', '温带', '灌溉', '潜水', '漂浮', '淹没', '源泉', '潮流');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d614d0d5-0310-4c34-9549-d80af2cb949f', 'Bài 106 - Tính chất của chất lỏng', 'Miêu tả các hiện tượng biến đổi, hòa tan và đặc tính của dòng chảy.', 'HSK 6', 106, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd614d0d5-0310-4c34-9549-d80af2cb949f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('液体', '浸泡', '淋', '溅', '溶解', '渗透', '混浊', '混合', '清澈', '滋润', '渠道', '渣', '涌现', '澄清', '流通');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0ac3076d-433d-47d5-9c31-79f4d14d7f20', 'Bài 107 - Hương vị bếp nhà', 'Từ vựng về nấu nướng, gia vị, khói bếp và ẩm thực đời sống thường nhật.', 'HSK 6', 107, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0ac3076d-433d-47d5-9c31-79f4d14d7f20', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('涮火锅', '烹饪', '煎', '熬', '烘', '炉灶', '炊烟', '滋味', '清真', '狼吞虎咽', '现成', '涂抹', '熨', '点缀', '玉');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a788d9ba-67d1-43f0-a36b-6ee1d8f20caa', 'Bài 108 - Lửa và sức mạnh bùng nổ', 'Nói về ngọn lửa, cứu hỏa, năng lượng và các hiện tượng mãnh liệt.', 'HSK 6', 108, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a788d9ba-67d1-43f0-a36b-6ee1d8f20caa', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('火焰', '火箭', '火药', '消防', '熄灭', '灭亡', '灾难', '爆发', '爆炸', '猛烈', '烟花爆竹', '炎热', '照耀', '灿烂', '濒临');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('09f11653-0a50-4718-830f-568748a131cc', 'Bài 109 - Thanh lọc và trật tự', 'Chủ đề vệ sinh, loại bỏ tạp chất, đo lường và duy trì hiện trường sạch sẽ.', 'HSK 6', 109, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '09f11653-0a50-4718-830f-568748a131cc', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('测量', '浑身', '消毒', '消灭', '消耗', '消除', '清洁', '清理', '清除', '淘汰', '牢固', '混淆', '混乱', '环节', '现场');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5896aec4-cf6a-4708-8d9c-68fed1089a19', 'Bài 110 - Thương mại và đời sống', 'Các từ vựng về đàm phán, vật tư, tài sản và thực tế đời sống kinh tế.', 'HSK 6', 110, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5896aec4-cf6a-4708-8d9c-68fed1089a19', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('洽谈', '物资', '物业', '物美价廉', '淡季', '热门', '版本', '现状', '渔民', '牲畜', '犬', '牵制', '牵扯', '特定', '特意');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a7cde2ee-5d6a-4d60-bdf4-b27c94c854da', 'Bài 111 - Cung bậc cảm xúc', 'Bộc lộ những khát khao, nhiệt huyết, lo âu và tình cảm chân thành.', 'HSK 6', 111, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a7cde2ee-5d6a-4d60-bdf4-b27c94c854da', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('渴望', '激情', '激励', '激发', '热泪盈眶', '焦急', '焦点', '灵敏', '爱不释手', '爱戴', '爽快', '牢骚', '浓厚', '深情厚谊', '炫耀');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('469197b4-be3b-4e38-b2e6-97eaecfa58c4', 'Bài 112 - Nghệ thuật và cảm hứng', 'Khám phá diễn xuất, âm nhạc, truyện tranh và sự phát triển tư duy sáng tạo.', 'HSK 6', 112, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '469197b4-be3b-4e38-b2e6-97eaecfa58c4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('演习', '演变', '演奏', '演绎', '漫画', '灯笼', '灵感', '灵魂', '熏陶', '玩弄', '玩意儿', '潇洒', '潜力', '潜移默化', '特长');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('aa56f737-a9d0-468d-862c-7d6f206ddb86', 'Bài 113 - Tính cách và con người', 'Khắc họa phẩm chất, phong thái, hành vi và các vai trò trong xã hội.', 'HSK 6', 113, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'aa56f737-a9d0-468d-862c-7d6f206ddb86', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('流氓', '流浪', '狠心', '独裁', '狭窄', '狭隘', '狼狈', '温和', '深沉', '活该', '渺小', '率领', '牺牲', '派遣', '派别');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4e555901-06e1-466b-89e0-d9e8f56bccba', 'Bài 114 - Khoảnh khắc và thời gian', 'Các từ ngữ miêu tả nhận thức, sự tiếp diễn, dòng thời gian và trạng thái trừu tượng.', 'HSK 6', 114, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4e555901-06e1-466b-89e0-d9e8f56bccba', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('涉及', '流露', '深奥', '清晨', '清晰', '清醒', '滔滔不绝', '滞留', '溜', '漫长', '照样', '片刻', '片断', '牵', '犹如');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d3058f7c-acd3-4136-8d11-2b7e5ebef278', 'Bài 115 - Sức khỏe và Cơ thể', 'Từ vựng về thể trạng, bệnh tật, triệu chứng và các dấu hiệu trên cơ thể.', 'HSK 6', 115, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd3058f7c-acd3-4136-8d11-2b7e5ebef278', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('生理', '疲倦', '疲惫', '疾病', '症状', '瘫痪', '瘸', '癌症', '疙瘩', '疤', '皱纹', '秃', '知觉', '神经');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6121332c-2c0f-44d8-9b6c-b9caae8dc44e', 'Bài 116 - Ánh nhìn và Biểu cảm', 'Các cử chỉ của đôi mắt, cách quan sát và sắc thái biểu cảm khuôn mặt.', 'HSK 6', 116, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '6121332c-2c0f-44d8-9b6c-b9caae8dc44e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('目光', '目睹', '盯', '盲目', '眨', '眯', '眼光', '眼神', '眼色', '瞄准', '瞪', '瞻仰', '瞬间', '神态', '神气');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4fd8b8b8-9607-404e-bd56-268521c7bc2f', 'Bài 117 - Thiên nhiên và Nông nghiệp', 'Từ vựng về tài nguyên thiên nhiên, địa hình, trồng trọt và sinh thái.', 'HSK 6', 117, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4fd8b8b8-9607-404e-bd56-268521c7bc2f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('田野', '畔', '盆地', '生态', '生物', '畜牧', '种子', '种植', '稻谷', '石油', '矿产', '砍伐', '盛产', '盛开', '稠密');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0a9c4dfa-75f4-403c-bb4b-831199e8b309', 'Bài 118 - Nguồn cội và Đời sống tinh thần', 'Từ vựng về gia đình, tổ tiên, tín ngưỡng truyền thống và quan niệm phúc lành.', 'HSK 6', 118, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '0a9c4dfa-75f4-403c-bb4b-831199e8b309', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('祖先', '祖国', '祖父', '社区', '种族', '神仙', '神圣', '神奇', '生肖', '福利', '福气', '知足常乐', '称心如意', '皇后', '皇帝');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('bf19c1e6-84a4-4353-9c20-f6ddfd537ef4', 'Bài 119 - Nghệ thuật Ứng xử', 'Cách thức giao tiếp, nghi lễ xã giao và xây dựng các mối quan hệ tốt đẹp.', 'HSK 6', 119, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'bf19c1e6-84a4-4353-9c20-f6ddfd537ef4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('理睬', '疏远', '礼尚往来', '礼节', '示意', '示范', '磋商', '磨合', '盛情', '真挚', '着想', '留念', '留恋', '生疏', '看待');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('961eb4b4-de7b-48b4-b263-273ebfa6988e', 'Bài 120 - Tư duy và Nhận thức', 'Từ vựng diễn đạt quá trình suy nghĩ, phán đoán logic, chân lý và tâm lý.', 'HSK 6', 120, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '961eb4b4-de7b-48b4-b263-273ebfa6988e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('理智', '理所当然', '理直气壮', '琢磨', '疑惑', '畏惧', '留神', '疏忽', '真理', '真相', '确信', '确切', '着迷', '空想', '画蛇添足');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('914ea8ae-64eb-415e-ba0c-69cf76d7f3de', 'Bài 121 - Pháp luật và Quy chuẩn xã hội', 'Các thuật ngữ liên quan đến thủ tục, kỷ luật, quy tắc và an ninh trật tự.', 'HSK 6', 121, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '914ea8ae-64eb-415e-ba0c-69cf76d7f3de', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('监狱', '监督', '监视', '盗窃', '示威', '盖章', '申报', '督促', '私自', '破例', '界限', '生效', '确保', '确立', '称号', '瓦解');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3c431a4c-f022-4e32-8670-7f74fb7d74dd', 'Bài 122 - Thương mại và Công nghệ', 'Từ vựng về hoạt động kinh doanh, hàng hóa quý giá và thiết bị số hóa.', 'HSK 6', 122, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '3c431a4c-f022-4e32-8670-7f74fb7d74dd', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('用户', '畅销', '盈利', '租赁', '直播', '电源', '登录', '登陆', '稿件', '磁带', '珍珠', '珍稀', '珍贵', '皮革', '畅通');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('17836fe6-378d-4621-83bb-64651047d4c9', 'Bài 123 - Đo lường và Tương quan', 'Từ ngữ chỉ kích thước, mức độ so sánh, sự biến chuyển và mối quan hệ qua lại.', 'HSK 6', 123, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '17836fe6-378d-4621-83bb-64651047d4c9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('直径', '磅', '秤', '相差', '相等', '相应', '相辅相成', '短促', '皆', '番', '着手', '着重', '空前绝后', '生锈', '痕迹');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ad240538-9b28-4386-a88a-7d0fcf3e809c', 'Bài 124 - Nhịp sống và Động thái', 'Các động từ hành động thường nhật, sinh tồn, văn hóa nghệ thuật và thể thao.', 'HSK 6', 124, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ad240538-9b28-4386-a88a-7d0fcf3e809c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('生存', '生机', '生育', '甭', '田径', '省会', '码头', '砖', '砸', '磕', '盘旋', '盛', '盛行', '相声', '科目');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('64cc0fab-0c57-46dc-97c5-1bc84422e011', 'Bài 125 - Cơ thể và Y học', 'Từ vựng về các bộ phận cơ thể người, bệnh lý và thăm khám sức khỏe.', 'HSK 6', 125, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '64cc0fab-0c57-46dc-97c5-1bc84422e011', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('肺', '肿瘤', '脂肪', '脉搏', '腹泻', '膜', '膝盖', '臂', '舌头', '舔', '胸膛', '血压', '蛋白质', '解剖', '衰老', '苍白');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e369df59-bb92-42d6-bf94-2ea708861dd2', 'Bài 126 - Chinh phục Bầu trời và Đại dương', 'Các từ liên quan đến ngành hàng không, hàng hải, tàu thuyền và hành trình khám phá.', 'HSK 6', 126, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e369df59-bb92-42d6-bf94-2ea708861dd2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('舟', '航天', '航空', '航行', '舰艇', '舱', '船舶', '艘', '装卸', '装备', '观光', '覆盖');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('38118971-aca0-4c8c-99f4-dd806a89669e', 'Bài 127 - Thế giới Tự nhiên và Sinh thái', 'Tìm hiểu về thực vật, tài nguyên, thiên nhiên và sự biến đổi của vạn vật.', 'HSK 6', 127, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '38118971-aca0-4c8c-99f4-dd806a89669e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('肥沃', '花瓣', '花蕾', '茎', '茂盛', '萌芽', '蔓延', '蕴藏', '蚂蚁', '蔚蓝', '融化', '蜡烛', '蒸发', '荒凉');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7b034b09-61d7-4624-83a2-a6f4e95de202', 'Bài 128 - Kinh doanh và Thị trường Lao động', 'Từ vựng về tổ chức doanh nghiệp, tài chính, nhân sự và quản trị dự án.', 'HSK 6', 128, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7b034b09-61d7-4624-83a2-a6f4e95de202', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('股东', '股份', '董事长', '薪水', '裁员', '解雇', '补偿', '补救', '补贴', '落实', '落成', '规划', '行列');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('9e0de0cb-3ee8-4bc4-8fec-3879442c628e', 'Bài 129 - Pháp luật và Trật tự Xã hội', 'Học về các quy chuẩn hành chính, thủ tục xét xử, quyền ngôn luận và pháp luật.', 'HSK 6', 129, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '9e0de0cb-3ee8-4bc4-8fec-3879442c628e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('被告', '触犯', '裁判', '行政', '规章', '规范', '规格', '表决', '表态', '舆论', '言论', '虐待', '腐败', '范畴');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f5e48df6-5829-41b4-9f66-fdf740217c2f', 'Bài 130 - Phẩm cách và Đạo đức Con người', 'Các tính từ và thành ngữ chỉ nhân phẩm, hành vi và thái độ sống.', 'HSK 6', 130, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f5e48df6-5829-41b4-9f66-fdf740217c2f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('良心', '英勇', '英明', '见义勇为', '肆无忌惮', '虚伪', '虚假', '虚荣', '背叛', '胆怯', '自卑', '自满', '蔑视', '藐视');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('1a13a690-2575-409a-869d-e86380dffd3c', 'Bài 131 - Tầm nhìn và Tri thức', 'Diễn đạt về góc nhìn, tầm mắt, mức độ hiểu biết và sự thức tỉnh tư tưởng.', 'HSK 6', 131, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '1a13a690-2575-409a-869d-e86380dffd3c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('视力', '视线', '视野', '视频', '见解', '见闻', '见多识广', '觉悟', '觉醒', '茫然', '茫茫', '胸怀', '肖像');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5a5eee3d-f523-470e-9e14-0af44935e8cc', 'Bài 132 - Văn hóa Nghệ thuật và Lễ nghi', 'Chủ đề trang phục, văn chương, nghệ thuật biểu diễn và nghi thức trang trọng.', 'HSK 6', 132, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5a5eee3d-f523-470e-9e14-0af44935e8cc', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('舞蹈', '节奏', '著作', '背诵', '衣裳', '裁缝', '衬托', '胡须', '舒畅', '衷心', '表彰', '致辞', '荣幸', '荣誉');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('70a517ff-3988-4494-9052-e56faeeadf96', 'Bài 133 - Hương vị và Trải nghiệm Nhân sinh', 'Từ ẩm thực, mùi vị đến những khó khăn, nỗ lực và bài học cuộc sống.', 'HSK 6', 133, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '70a517ff-3988-4494-9052-e56faeeadf96', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('荤', '腥', '苦涩', '苦尽甘来', '节制', '融洽', '苏醒', '脆弱', '薄弱', '能量', '艰难');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('2404ee9d-63e0-4190-adae-93a0059c77f2', 'Bài 134 - Biến động, Thử thách và Đổi thay', 'Các từ miêu tả sự tan rã, mục nát, xung đột và quá trình tự lập, tự cường.', 'HSK 6', 134, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '2404ee9d-63e0-4190-adae-93a0059c77f2', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('袭击', '胜负', '被动', '衰退', '解体', '解放', '解散', '解除', '脱离', '腐朽', '腐烂', '腐蚀', '自主', '自力更生');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a717f4d1-3ef0-4678-be01-a167cbd8bb4d', 'Bài 135 - Tư duy Logic và Đánh giá Vấn đề', 'Biểu đạt nguyên nhân, kết quả, các yếu tố then chốt và phán đoán logic.', 'HSK 6', 135, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a717f4d1-3ef0-4678-be01-a167cbd8bb4d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('胡乱', '草案', '草率', '荒唐', '荒谬', '莫名其妙', '致使', '致力', '自发', '若干', '要命', '要点', '要素', '衔接', '角落');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('00b6f42a-5c6c-4010-9399-d8c88ed410b4', 'Bài 136 - Khoa học và Tiến hóa', 'Các thuật ngữ về công nghệ, phát triển khoa học và quy luật tiến hóa tự nhiên.', 'HSK 6', 136, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '00b6f42a-5c6c-4010-9399-d8c88ed410b4', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('运算', '运行', '还原', '进化', '进展', '递增', '遥控', '遗传', '钙', '通讯', '问世', '迸发', '迹象', '酝酿', '里程碑');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('410d95c8-c269-48fc-b626-5ddbcf1220fd', 'Bài 137 - Kinh tế và Tài chính', 'Từ vựng về thị trường, tài chính, mua sắm và các hiện tượng kinh tế.', 'HSK 6', 137, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '410d95c8-c269-48fc-b626-5ddbcf1220fd', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('连年', '连锁', '逐年', '通货膨胀', '金融', '钞票', '采购', '配套', '配备', '途径', '通用', '通俗', '遗产', '遗失', '遗留');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('dce8ac73-0aa3-4d3e-b1da-5910dc7b0357', 'Bài 138 - Chiến lược và Tranh chấp', 'Bối cảnh đối kháng, đội ngũ, cách bố phòng và các chiến thuật ngăn cản.', 'HSK 6', 138, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'dce8ac73-0aa3-4d3e-b1da-5910dc7b0357', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('进攻', '违背', '部署', '队伍', '防守', '防御', '阵地', '阵容', '间谍', '阴谋', '阻拦', '阻挠', '阻碍', '遏制', '逆行');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b520e718-9b81-4f84-806b-7ac1713d522f', 'Bài 139 - Pháp luật và Hiểm họa', 'Từ vựng về tư pháp, điều tra vi phạm, cạm bẫy và đối mặt với rủi ro.', 'HSK 6', 139, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b520e718-9b81-4f84-806b-7ac1713d522f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('通缉', '逮捕', '逼迫', '迫害', '追究', '销毁', '隐患', '隐瞒', '陷害', '陷阱', '遭受', '遭殃', '遭遇', '陷入', '释放');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('859c3bd7-f56b-45e4-bd5c-d9b93a3b31cd', 'Bài 140 - Chế tác và Nghệ thuật', 'Mô tả chất liệu, công cụ sản xuất, tạo hình và nghệ thuật thủ công.', 'HSK 6', 140, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '859c3bd7-f56b-45e4-bd5c-d9b93a3b31cd', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('铜', '钻石', '钩子', '铸造', '铺', '锋利', '锤', '镶嵌', '陶瓷', '造型', '闪烁', '镜头', '陈列', '陈旧', '重叠');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4c6468c3-59b6-4280-81e3-706c15ecd817', 'Bài 141 - Tâm lý và Cảm xúc', 'Biểu hiện cảm xúc, phản ứng nội tâm và thái độ cư xử của con người.', 'HSK 6', 141, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4c6468c3-59b6-4280-81e3-706c15ecd817', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('迟疑', '迟缓', '迟钝', '迫不及待', '迷人', '迷惑', '迷信', '陶醉', '鄙视', '钦佩', '镇定', '镇静', '难堪', '野心', '野蛮');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c0977980-f960-4390-884a-da9caeb27a96', 'Bài 142 - Giao tiếp và Xã hội', 'Diễn đạt ý kiến, mối quan hệ con người, phân tầng xã hội và trao đổi thông tin.', 'HSK 6', 142, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c0977980-f960-4390-884a-da9caeb27a96', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('过问', '透露', '阐述', '陈述', '闲话', '附和', '采纳', '郑重', '配偶', '隔阂', '阶层', '隐私', '间接', '部位', '遵循');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f595eebc-341e-4c4d-91db-2f7931800fdd', 'Bài 143 - Không gian và Rào cản', 'Từ vựng miêu tả địa hình, cảnh quan, khoảng cách và sự che chắn.', 'HSK 6', 143, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f595eebc-341e-4c4d-91db-2f7931800fdd', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('遥远', '遍布', '陡峭', '隧道', '雄伟', '遮挡', '隔离', '障碍', '闭塞', '隐蔽', '隐约', '间隔', '迎面', '降临', '迈');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4b126118-3e78-439e-a7db-d742c09ba1b0', 'Bài 144 - Tuyển chọn và Nỗ lực', 'Chủ đề thi tuyển, đánh giá thẩm định, tinh thần kiên trì và đức tính quý báu.', 'HSK 6', 144, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4b126118-3e78-439e-a7db-d742c09ba1b0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('选举', '选手', '选拔', '钻研', '锲而不舍', '难得', '难能可贵', '锦上添花', '鉴于', '鉴别', '鉴定', '隆重', '适宜', '重心', '采集');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('801e90ba-2a01-4914-a99f-2142421ba6ab', 'Bài 145 - Hành vi và Nhịp sống', 'Các liên từ logic, thói quen sinh hoạt, phòng ngừa và dấu mốc đời người.', 'HSK 6', 145, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '801e90ba-2a01-4914-a99f-2142421ba6ab', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('近来', '进而', '连同', '逢', '逝世', '追悼', '酒精', '酗酒', '防止', '防治', '附件', '附属', '除', '随即', '随意');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('2e3f96d5-9e15-49a1-b5c7-860fb18e93eb', 'Bài 146 - Pháp luật và Trách nhiệm', 'Các từ vựng về pháp lý, kiện tụng, hành vi vi phạm và phán xét lỗi lầm.', 'HSK 6', 146, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '2e3f96d5-9e15-49a1-b5c7-860fb18e93eb', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('警告', '警惕', '诉讼', '辩护', '辩解', '诬陷', '诽谤', '谣言', '诈骗', '贿赂', '贼', '走私', '赌博', '谴责', '过失');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e1228f42-d5be-4568-9c88-4e866a5ed8ea', 'Bài 147 - Tài chính và Kinh tế', 'Các thuật ngữ về tiền tệ, tài sản, ngân sách và các vấn đề kinh tế - xã hội.', 'HSK 6', 147, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e1228f42-d5be-4568-9c88-4e866a5ed8ea', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('财务', '财富', '财政', '货币', '资产', '资本', '赤字', '资助', '赞助', '贩卖', '贪污', '贪婪', '贫乏', '贫困', '负担');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d73cf60c-35f6-47ca-ac31-9bf0762b4c69', 'Bài 148 - Nghệ thuật Giao tiếp', 'Từ vựng về ứng xử, đối nhân xử thế, thư tín xã giao và thái độ giao tiếp.', 'HSK 6', 148, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'd73cf60c-35f6-47ca-ac31-9bf0762b4c69', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('讨好', '讥笑', '让步', '诚挚', '请帖', '请柬', '请教', '请示', '诸位', '谢绝', '谦逊', '责怪', '谅解', '误解', '过奖');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7f419dbe-8842-4f5f-9b83-61fb8407b6aa', 'Bài 149 - Nghiên cứu và Đánh giá', 'Chủ đề học thuật, kiểm chứng, diễn đàn thảo luận và phân tích thông tin.', 'HSK 6', 149, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7f419dbe-8842-4f5f-9b83-61fb8407b6aa', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('论坛', '论证', '课题', '评估', '评论', '证书', '证实', '试验', '辨认', '识别', '辩证', '记性', '记载', '误差', '譬如');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('78ebcd87-ee63-46b5-a26d-96be4717f56f', 'Bài 150 - Kế hoạch và Điều hành', 'Từ vựng về tổ chức công việc, điều phối nhân sự, soạn thảo và thực thi dự án.', 'HSK 6', 150, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '78ebcd87-ee63-46b5-a26d-96be4717f56f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('设立', '设置', '设想', '试图', '谋求', '调动', '调节', '调剂', '调和', '调解', '资深', '贯彻', '起草', '达成', '辅助');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('480b2ad4-25d3-4e87-b12d-af0d236e5b55', 'Bài 151 - Hành động và Cử chỉ', 'Các động tác cơ thể, chuyển động của chân và dấu vết di chuyển.', 'HSK 6', 151, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '480b2ad4-25d3-4e87-b12d-af0d236e5b55', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('趴', '跌', '跨', '跪', '跳跃', '践踏', '踊跃', '踏实', '蹦', '蹬', '跟踪', '跟随', '跟前', '踪迹', '辫子');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('13c29753-d710-4d9e-bdcc-0b3357686885', 'Bài 152 - Không gian và Địa lý', 'Các khái niệm về đường biên giới, giao thông vận tải và phạm vi địa lý.', 'HSK 6', 152, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '13c29753-d710-4d9e-bdcc-0b3357686885', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('边境', '边界', '边疆', '边缘', '辽阔', '赤道', '走廊', '轨道', '轮廓', '轮胎', '轮船', '走漏', '转移', '转让', '迁徙');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('27f6962c-3c75-40f7-80e5-832a9c674f96', 'Bài 153 - Chuyển biến và Khởi đầu', 'Từ vựng về bước ngoặt, quá trình phát triển, nguồn gốc và sự chuyển giao.', 'HSK 6', 153, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '27f6962c-3c75-40f7-80e5-832a9c674f96', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('起伏', '起初', '起源', '起码', '起哄', '转折', '转达', '过渡', '过滤', '较量', '轰动', '辐射', '超越', '诞生', '诞辰');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5ab48459-5fed-49b7-9a2c-d7b685eaf5e0', 'Bài 154 - Phẩm chất và Tính cách', 'Từ ngữ miêu tả đạo đức, cốt cách con người và thái độ nhìn nhận giá trị.', 'HSK 6', 154, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5ab48459-5fed-49b7-9a2c-d7b685eaf5e0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('贵族', '贤惠', '豪迈', '辛勤', '败坏', '贬低', '贬义', '计较', '认可', '认定', '许可', '诱惑', '辜负', '迁就', '辉煌');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('fcc885d9-9ad4-49df-a33b-1576d6ba3cbe', 'Bài 155 - Đời sống và Cảm nhận', 'Từ vựng về sinh hoạt thường nhật, mức độ biểu đạt và cảm xúc con người.', 'HSK 6', 155, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'fcc885d9-9ad4-49df-a33b-1576d6ba3cbe', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('诧异', '赞叹', '趣味', '谜语', '调料', '话筒', '贝壳', '访问', '赠送', '赋予', '足以', '迄今为止', '过于', '过度', '过瘾');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('c5c08272-0c4e-4c23-9c5f-446524359b24', 'Bài 156 - Không gian và Phương hướng', 'Từ vựng miêu tả vị trí không gian, hình khối, sự chuyển động và khoảng cách.', 'HSK 6', 156, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'c5c08272-0c4e-4c23-9c5f-446524359b24', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('空洞', '空白', '空虚', '空隙', '穿越', '突破', '窝', '立交桥', '立体', '立方', '竖', '纵横', '经纬', '缺口');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('dbd8f414-50d5-4a49-9523-4f80748bdeef', 'Bài 157 - Kế hoạch và Thủ tục Công việc', 'Từ vựng về quy trình hành chính, hội nghị báo cáo và xây dựng sách lược.', 'HSK 6', 157, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'dbd8f414-50d5-4a49-9523-4f80748bdeef', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('答复', '答辩', '策划', '策略', '筛选', '筹备', '签署', '纪要', '纲领', '章程', '等级', '级别', '统筹兼顾', '统计');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5cfbf979-3828-4df0-8593-da5d11f761f1', 'Bài 158 - Tổ chức và Xã hội', 'Từ ngữ liên quan đến bộ máy tổ chức, vai trò nghề nghiệp và phong trào tập thể.', 'HSK 6', 158, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '5cfbf979-3828-4df0-8593-da5d11f761f1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('职位', '职务', '职能', '管辖', '统治', '联盟', '联络', '联欢', '竞赛', '竞选', '罢工', '群众', '籍贯');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7be14143-990b-486f-8226-0da3df245d8f', 'Bài 159 - Khám phá Khoa học và Nghiên cứu', 'Thuật ngữ dùng trong khảo sát thực địa, nghiên cứu vi sinh và kiểm chứng khoa học.', 'HSK 6', 159, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7be14143-990b-486f-8226-0da3df245d8f', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('考古', '考察', '考核', '考验', '细胞', '细菌', '纤维', '维生素', '线索', '结晶', '类似', '系列', '繁殖');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('59001a48-e397-4f04-a7cf-014f1bc06b4e', 'Bài 160 - Kỹ năng và Sự Tinh xảo', 'Các từ thể hiện trình độ chuyên môn cao, độ chuẩn xác và tinh thần làm việc hết mình.', 'HSK 6', 160, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '59001a48-e397-4f04-a7cf-014f1bc06b4e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('精华', '精密', '精心', '精益求精', '精确', '精简', '精致', '精通', '细致', '窍门', '聚精会神', '竭尽全力', '耐用');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e4c42f38-e7b0-41cf-93d9-eab8341f0fbe', 'Bài 161 - Tài chính và Pháp lý', 'Từ vựng về quản lý ngân sách, nghĩa vụ tài chính và giải quyết tranh chấp pháp luật.', 'HSK 6', 161, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e4c42f38-e7b0-41cf-93d9-eab8341f0fbe', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('经费', '结算', '缴纳', '精打细算', '耗费', '索取', '纠正', '纠纷', '约束', '维护', '维持', '罪犯', '绑架');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ea8a45e5-383f-4a4d-a1d3-496b329b9856', 'Bài 162 - Vật dụng và Đời sống Thường nhật', 'Từ vựng về ẩm thực, may mặc, nghề thủ công truyền thống và sinh hoạt hằng ngày.', 'HSK 6', 162, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ea8a45e5-383f-4a4d-a1d3-496b329b9856', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('粥', '素食', '粉末', '粉碎', '粒', '罐', '筐', '纽扣儿', '羽绒服', '纺织', '编织', '绣', '缠绕', '端午节', '耕地');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b12af63f-1836-41b1-b400-81cf3875c9c9', 'Bài 163 - Ngôn ngữ, Văn tự và Hình thức', 'Các từ chỉ đặc điểm chữ viết, văn bản và diện mạo của sự vật.', 'HSK 6', 163, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b12af63f-1836-41b1-b400-81cf3875c9c9', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('简体字', '繁体字', '简化', '简要', '简陋', '童话', '符号', '纯洁', '纯粹', '粉色', '美观', '耀眼', '笼罩', '繁华');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('76091f8a-45ee-4366-aadd-61359cf9fef1', 'Bài 164 - Phẩm chất và Ứng xử', 'Từ ngữ miêu tả tính cách, tiêu chuẩn đạo đức và cách đối nhân xử thế.', 'HSK 6', 164, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '76091f8a-45ee-4366-aadd-61359cf9fef1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('端正', '绅士', '粗鲁', '笨拙', '素质', '羞耻', '美妙', '美满', '立场', '立足', '耍', '糟蹋', '缺陷');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('7fb80660-6fbc-48e3-9816-9bdc4527c6ae', 'Bài 165 - Tâm lý và Tình huống Đời sống', 'Diễn tả cảm xúc, tâm lý con người và những biến chuyển, hoàn cảnh trong cuộc sống.', 'HSK 6', 165, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '7fb80660-6fbc-48e3-9816-9bdc4527c6ae', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('纳闷儿', '绝望', '联想', '紧迫', '繁忙', '缓和', '等候', '缺席', '罕见', '聋哑', '络绎不绝', '给予', '继承');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('34ac7b3e-fa67-48f1-b66e-017ceea37dcf', 'Bài 166 - Hành động, Diễn tiến và Kết cục', 'Từ vựng chỉ động tác cơ thể, tiến trình đi đến kết quả và các từ biểu thị ngữ khí.', 'HSK 6', 166, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '34ac7b3e-fa67-48f1-b66e-017ceea37dcf', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('窜', '端', '算数', '索性', '终止', '终点', '终究', '终身', '结局', '统统', '缘故', '翘', '翼', '耸', '而已');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('ab766283-6fe3-466e-a8ab-410d021e65f6', 'Bài 167 - Thiên nhiên và muôn loài', 'Từ vựng về thời gian trong ngày, cảnh quan thiên nhiên và thế giới động vật.', 'HSK 6', 167, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'ab766283-6fe3-466e-a8ab-410d021e65f6', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('霞', '黄昏', '黎明', '风暴', '风光', '风土人情', '飘扬', '飞翔', '飞禽走兽', '鸽子', '饲养', '雌雄');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('88acddc4-83e7-4d9e-b205-7484348f294d', 'Bài 168 - Dự đoán và dòng thời gian', 'Các từ miêu tả sự tiên tri, thay đổi trạng thái, tần suất và những biến chuyển theo thời gian.', 'HSK 6', 168, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '88acddc4-83e7-4d9e-b205-7484348f294d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('预兆', '预先', '预料', '预期', '预言', '顿时', '频率', '频繁', '颇', '零星', '颠倒', '颠簸', '饱经沧桑', '飞跃');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b671d3d8-382c-415f-887e-f1c9e3b71bd1', 'Bài 169 - Doanh nghiệp và quản lý', 'Từ vựng thiết thực trong môi trường công sở, ngân sách, nhân sự và quản trị dự án.', 'HSK 6', 169, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'b671d3d8-382c-415f-887e-f1c9e3b71bd1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('预算', '需求', '集团', '雇佣', '雄厚', '顾问', '额外', '验收', '验证', '齐全', '领先', '骨干', '齐心协力', '须知');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('f79f6d64-3bcb-44db-ab57-ebaca1e03649', 'Bài 170 - Thời cuộc và chính trị', 'Các từ vựng về lãnh sự, pháp luật, lãnh thổ và các hoạt động chính trị - quân sự.', 'HSK 6', 170, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'f79f6d64-3bcb-44db-ab57-ebaca1e03649', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('领事馆', '领土', '领袖', '革命', '颁布', '颁发', '非法', '驱逐', '驻扎', '骚扰', '鼓动', '首要', '雷达');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('e43e638f-43c6-4007-90b8-804a03f4f05e', 'Bài 171 - Ẩm thực và nghệ thuật sống', 'Từ vựng liên quan đến ăn uống, thẩm mỹ, đồ trang sức và hoạt động nghệ thuật.', 'HSK 6', 171, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'e43e638f-43c6-4007-90b8-804a03f4f05e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('饮食', '饥饿', '馋', '馅儿', '饱和', '风味', '雕刻', '雕塑', '题材', '首饰', '魔术', '音响', '风气', '风趣');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a95067ba-3934-4037-8307-dd0ad25bb764', 'Bài 172 - Bản lĩnh và phong thái', 'Từ vựng khắc họa phẩm cách, cốt cách ứng xử và năng lực xuất chúng của con người.', 'HSK 6', 172, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT 'a95067ba-3934-4037-8307-dd0ad25bb764', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('高尚', '高峰', '高明', '高涨', '高潮', '高超', '魄力', '顽强', '顽固', '霸道', '风度', '面子', '面貌', '鞠躬');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('4ff74ef8-b4d7-4787-85e3-29a4745b83f8', 'Bài 173 - Tâm lý, thể chất và nhận thức', 'Khám phá các phản ứng sinh học cơ thể, thấu hiểu nhận thức và những rung động tâm lý phức tạp.', 'HSK 6', 173, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) SELECT '4ff74ef8-b4d7-4787-85e3-29a4745b83f8', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('震惊', '震撼', '颤抖', '雪上加霜', '靠拢', '鞭策', '顾虑', '领会', '领悟', '颈椎', '饶恕', '魔鬼', '鲜明', '鸦雀无声', '麻木', '麻痹', '麻醉', '默默', '鼻涕');

