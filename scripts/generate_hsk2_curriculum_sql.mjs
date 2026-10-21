import fs from 'fs';

const LESSONS = [
  {
    id: '94443420-313c-488a-a679-4cdb900c8e61',
    num: 1,
    title: 'Bài 1 - Gia đình và Xưng hô',
    subtitle: 'Nói về ông bà, vợ chồng, trẻ em, tuổi thơ và các dịp đón tết sum vầy.',
    words: ['爷爷', '奶奶', '丈夫', '妻子', '男孩儿', '女孩儿', '小孩儿', '小时候', '姓名', '姓', '自己', '过年', '名', '位', '生日', '送'],
    special: [{ hanzi: '过', pinyin: 'guò' }]
  },
  {
    id: '77c2925c-545d-43af-9441-27b2e4b6d3e8',
    num: 2,
    title: 'Bài 2 - Sức khỏe và Thói quen sinh hoạt',
    subtitle: 'Mô tả sức khỏe, cảm giác thoải mái hay mệt mỏi, các bộ phận cơ thể và thăm khám mua thuốc.',
    words: ['身体', '舒服', '累', '疼', '眼睛', '手', '洗', '药', '药店', '床', '起来', '笑', '跑', '跑步', '走路', '动', '运动']
  },
  {
    id: '27a2b566-0586-4426-aa7d-c3737f8c4030',
    num: 3,
    title: 'Bài 3 - Thể thao và Sở thích giải trí',
    subtitle: 'Các môn thể thao bóng đá, bóng rổ, bơi lội, khiêu vũ và các hoạt động giải trí cuối tuần.',
    words: ['爱好', '踢', '足球', '踢足球', '篮球', '打', '打篮球', '球', '游', '游泳', '跳舞', '唱歌', '画', '花', '旅游', '快乐', '有意思']
  },
  {
    id: 'dc81aac7-e1f9-4e8a-9900-7dfeb46acf29',
    num: 4,
    title: 'Bài 4 - Ẩm thực và Bữa ăn',
    subtitle: 'Tên các món thịt cá, mì sợi, đồ uống trà sữa cà phê và gọi món tại quán ăn.',
    words: ['饭馆', '羊肉', '肉', '鱼', '面条', '咖啡', '奶茶', '红茶', '绿茶', '点', '服务员', '拿', '错', '不错', '完', '洗手间', '门口']
  },
  {
    id: '01045043-b59b-4cc3-a932-631a7c36cb79',
    num: 5,
    title: 'Bài 5 - Mua sắm, Quần áo và Đồ dùng',
    subtitle: 'Mua sắm tại trung tâm thương mại, màu sắc quần áo và các dụng cụ cá nhân.',
    words: ['商场', '门', '门票', '票', '裤子', '手表', '颜色', '红色', '黑色', '绿色', '白色', '包', '书包', '本子', '笔', '条', '准备']
  },
  {
    id: 'ca9c4149-a662-422c-9188-b5685b825b61',
    num: 6,
    title: 'Bài 6 - Thời gian, Thời tiết và Số đếm',
    subtitle: 'Diễn đạt tuần lễ, khoảnh khắc, thời tiết nắng râm, số đếm hàng vạn và tần suất.',
    words: ['周', '时', '一会儿', '有时', '经常', '晴', '阴', '第一', '万', '次', '每', '离', '远', '近', '快', '慢', '已经', '快要']
  },
  {
    id: '5d979021-4b47-45c9-9e18-43f45dbbc8a6',
    num: 7,
    title: 'Bài 7 - Đi lại, Giao thông và Du lịch',
    subtitle: 'Phương tiện xe buýt, tàu điện ngầm, taxi, máy bay và các chặng đường di chuyển.',
    words: ['路', '路上', '走', '车站', '火车站', '机场', '机票', '公共汽车', '公交车', '地铁', '打车', '站', '飞', '外国', '出来', '出去', '出门', '出国']
  },
  {
    id: '7e710dea-9862-403f-8f09-ab8031d0ca57',
    num: 8,
    title: 'Bài 8 - Học tập, Thi cử và Lớp học',
    subtitle: 'Trường học, lớp học, thi cử kiểm tra, học từ vựng và cùng bạn bè rèn luyện.',
    words: ['班', '教室', '高中', '开学', '开始', '考', '考试', '题', '懂', '教', '词', '记得', '忘', '介绍', '事情', '告诉', '跟']
  },
  {
    id: 'b42f4801-bcb4-43df-9e7b-cac2499082a5',
    num: 9,
    title: 'Bài 9 - Công việc, Giao tiếp và Công nghệ',
    subtitle: 'Làm việc văn phòng, khách sạn, lướt web, thái độ lịch thiệp và ứng xử thường nhật.',
    words: ['酒店', '楼', '间', '打开', '帮', '帮忙', '让', '等', '希望', '上网', '网上', '不好意思', '没意思', '意思', '为什么', '可能', '正']
  },
  {
    id: '8e78386b-7dbd-4bc9-962a-101cf2119a66',
    num: 10,
    title: 'Bài 10 - Phương hướng, Vị trí và Không gian',
    subtitle: 'Phương hướng trước sau, trong ngoài, trái phải và các động tác tiến lùi di chuyển.',
    words: ['前面', '后面', '旁边', '里面', '外面', '上面', '下面', '左', '左边', '右', '右边', '往', '进', '进来', '进去', '上来', '上去']
  },
  {
    id: '80681700-a311-4b11-b4e7-8dfabb44dfd6',
    num: 11,
    title: 'Bài 11 - Xu hướng, Biến chuyển và Miêu tả',
    subtitle: 'Động từ xu hướng lên xuống qua lại, miêu tả chiều cao vóc dáng, so sánh và trạng thái.',
    words: ['下来', '下去', '过来', '过去', '回来', '回去', '出', '高', '个子', '长', '坏', '鸟', '最', '比', '那么', '那样', '这样']
  },
  {
    id: '1a2b3c4d-0002-4000-8000-000000000012',
    num: 12,
    title: 'Bài 12 - Phó từ, Liên từ và Trợ từ ngữ pháp',
    subtitle: 'Cặp liên từ tuy... nhưng, vì... nên, trợ từ tiếp diễn và các cấu trúc ngữ pháp then chốt HSK 2.',
    words: ['虽然', '但是', '虽然……但是……', '因为', '所以', '因为……所以……', '但', '还是', '一起', '就', '从', '从小', '这么', '啊', '着', '得', '地'],
    special: [{ hanzi: '过', pinyin: 'guo' }]
  }
];

let sql = `-- ====================================================================
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
`;

LESSONS.forEach(l => {
  sql += `  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('${l.id}', '${l.title}', '${l.subtitle}', 'HSK 2', ${l.num}, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

`;
});

const lessonIdList = LESSONS.map(l => `'${l.id}'`).join(', ');

sql += `  -- ------------------------------------------------------------------
  -- BƯỚC 2: DỌN DẸP VÀ TÁI LIÊN KẾT BẢNG NỐI LESSON_VOCABULARIES
  -- ------------------------------------------------------------------
  DELETE FROM public.lesson_vocabularies
  WHERE lesson_id IN (${lessonIdList});

`;

LESSONS.forEach(l => {
  const quotedWords = l.words.map(w => `'${w}'`).join(', ');
  sql += `  -- ${l.title} (${l.words.length + (l.special ? l.special.length : 0)} từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '${l.id}',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi IN (${quotedWords});

`;

  if (l.special) {
    l.special.forEach(sp => {
      sql += `  -- Từ đặc biệt phân biệt đa âm / đa từ loại: [${sp.hanzi}] (${sp.pinyin})
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '${l.id}',
    v.id,
    99,
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 2' AND v.hanzi = '${sp.hanzi}' AND v.pinyin = '${sp.pinyin}';

`;
    });
  }
});

sql += `  RAISE NOTICE 'Hoàn tất đồng bộ 12 bài học HSK 2 với 207 từ vựng chuẩn HSK 3.0!';
END $$;
`;

fs.writeFileSync('supabase/migrations/20261022020000_hsk2_curriculum_reconciliation.sql', sql, 'utf8');
console.log('Successfully wrote migration file: supabase/migrations/20261022020000_hsk2_curriculum_reconciliation.sql');
