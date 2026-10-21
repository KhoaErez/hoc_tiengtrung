import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function generateHsk3Sql() {
  console.log('=== KHỞI TẠO ĐỒNG BỘ 24 BÀI HỌC HSK 3 (514 TỪ VỰNG) ===\n');

  // 1. Lấy 24 bài học hệ thống
  const { data: lessons, error: lErr } = await supabase
    .from('lessons')
    .select('id, lesson_number, title, subtitle')
    .eq('hsk_level', 'HSK 3')
    .eq('is_system', true)
    .order('lesson_number', { ascending: true });

  if (lErr || !lessons || lessons.length !== 24) {
    console.error('Lỗi lấy 24 bài học HSK 3:', lErr);
    return;
  }

  // 2. Lấy toàn bộ 514 từ vựng HSK 3
  const { data: vocabs, error: vErr } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type')
    .eq('hsk_level', 'HSK 3')
    .order('pinyin', { ascending: true });

  if (vErr || !vocabs || vocabs.length !== 514) {
    console.error('Lỗi lấy 514 từ vựng HSK 3:', vErr);
    return;
  }

  console.log(`Đã nạp ${lessons.length} bài học và ${vocabs.length} từ vựng HSK 3.`);

  // 3. Phân loại 24 chủ đề bài học chi tiết
  // Bài 1 - Bốn mùa và Thế giới xung quanh: Khí hậu, mùa màng, địa lý thế giới
  // Bài 2 - Đường đi và Di chuyển: Phương hướng, vị trí, di chuyển
  // Bài 3 - Con người và Ngoại hình: Diện mạo, tóc tai, vóc dáng, tính cách
  // Bài 4 - Nhịp sống gia đình: Đời sống thường nhật, nếp sống, vệ sinh nhà cửa
  // Bài 5 - Sức khỏe và Cảm xúc: Trạng thái cơ thể, khám bệnh, tâm trạng
  // Bài 6 - Trường học và Tri thức: Môn học, thư viện, kiến thức, văn hóa
  // Bài 7 - Công sở và Giải quyết công việc: Văn phòng, họp hành, giải quyết vấn đề
  // Bài 8 - Mua sắm và Số lượng: Tiền tệ, đơn vị đo, lượng từ, thanh toán
  // Bài 9 - Hành động và Công nghệ: Internet, truyền thông, thiết bị, phát hiện
  // Bài 10 - Thời gian và Tần suất: Khái niệm thời gian, các buổi, tần suất
  // Bài 11 - Thái độ và Quan điểm: Ý kiến, quan điểm, lựa chọn, đánh giá
  // Bài 12 - Liên kết câu và Ngữ pháp nâng cao 1: Cặp liên từ, cấu trúc câu phức
  // Bài 13 - Diện mạo và Cơ thể: Các bộ phận trên cơ thể, miêu tả chi tiết
  // Bài 14 - Sức khỏe và Sinh hoạt: Ăn uống, rèn luyện, nghỉ ngơi, chăm sóc
  // Bài 15 - Gia đình và Giao tiếp: Họ hàng, quan hệ xã hội, giao lưu kết bạn
  // Bài 16 - Ẩm thực và Bàn ăn: Món ăn, đồ uống, dụng cụ bàn ăn, siêu thị thực phẩm
  // Bài 17 - Mua sắm và Trang phục: Quần áo, giày dép, túi xách, quà tặng
  // Bài 18 - Nhà cửa và Đồ dùng: Phòng ốc, đồ gia dụng, thiết bị sinh hoạt
  // Bài 19 - Thiên nhiên và Muôn loài: Động vật, cây cỏ, phong cảnh tự nhiên
  // Bài 20 - Giao thông và Di chuyển: Phương tiện, nhà ga, vé tàu, lộ trình
  // Bài 21 - Học tập và Công sở: Quản lý, tuyển chọn, kỹ năng chuyên môn
  // Bài 22 - Sở thích và Giải trí: Thể thao, nghệ thuật, âm nhạc, lễ hội
  // Bài 23 - Cảm xúc và Nhận định: Lo lắng, tức giận, vui buồn, so sánh
  // Bài 24 - Thời gian và Liên từ logic: Trạng từ thời gian, liên từ logic kết nối

  // Danh sách từ vựng ánh xạ chính xác
  const plan = [
    {
      num: 1,
      title: 'Bài 1 - Bốn mùa và Thế giới xung quanh',
      subtitle: 'Khám phá bốn mùa xuân hạ thu đông, thiên nhiên và các quốc gia trên thế giới.',
      words: ['动物', '国家', '地方', '春', '城市', '太阳', '地图', '世界', '季节', '夏', '刮风', '冬', '四季', '春天', '夏天', '秋天', '冬天', '西方', '北方', '南方', '东方', '市']
    },
    {
      num: 2,
      title: 'Bài 2 - Đường đi và Di chuyển',
      subtitle: 'Hỏi đường, định hướng không gian, di chuyển và chuẩn bị hành lý cá nhân.',
      words: ['东', '公园', '中间', '搬', '护照', '南', '司机', '向', '伞', '方便', '东北', '东南', '西北', '西南', '外地', '箱子', '行李', '园', '路口', '过道', '直']
    },
    {
      num: 3,
      title: 'Bài 3 - Con người và Ngoại hình',
      subtitle: 'Miêu tả diện mạo, vóc dáng, tính cách và các đặc điểm nổi bật của con người.',
      words: ['同事', '嘴', '客人', '头发', '像', '可爱', '叔叔', '年轻', '别人', '声音', '个子', '长相', '面貌', '笑脸', '友好', '热情', '礼貌', '聪明', '帅', '认真', '严格']
    },
    {
      num: 4,
      title: 'Bài 4 - Nhịp sống gia đình',
      subtitle: 'Thói quen thức dậy, vệ sinh cá nhân, dọn dẹp nhà cửa và cuộc sống sum họp gia đình.',
      words: ['刷牙', '包', '习惯', '旧', '新鲜', '安静', '冰箱', '周末', '帽子', '打扫', '啤酒', '干净', '洗澡', '刷', '牙刷', '整理', '洗手间', '卫生间', '家务', '生活', '舒服']
    },
    {
      num: 5,
      title: 'Bài 5 - Sức khỏe và Cảm xúc',
      subtitle: 'Thể trạng sức khỏe, triệu chứng cảm sốt, sự quan tâm và cảm xúc thường nhật.',
      words: ['感冒', '变化', '奇怪', '害怕', '小心', '健康', '哭', '关心', '放心', '发烧', '担心', '体育', '生病', '头疼', '咳嗽', '难受', '心情', '开心', '着急', '痛', '检查']
    },
    {
      num: 6,
      title: 'Bài 6 - Trường học và Tri thức',
      subtitle: 'Môn học lịch sử toán học, thư viện, nâng cao thành tích và làm bài tập.',
      words: ['复习', '年级', '数学', '历史', '成绩', '提高', '故事', '图书馆', '文化', '句子', '作业', '课文', '课本', '学期', '词语', '汉字', '语法', '生词', '记', '笔记', '知识']
    },
    {
      num: 7,
      title: 'Bài 7 - Công sở và Giải quyết công việc',
      subtitle: 'Môi trường làm việc văn phòng, hội họp, lên kế hoạch và tìm giải pháp.',
      words: ['帮忙', '关系', '同意', '了解', '参加', '办公室', '回答', '影响', '完成', '会议', '努力', '办法', '打算', '决定', '解决', '负责', '任务', '安排', '工作', '计划', '合作']
    },
    {
      num: 8,
      title: 'Bài 8 - Mua sắm và Số lượng',
      subtitle: 'Thanh toán thẻ ngân hàng, tiền tệ, các loại lượng từ và cân đo đong đếm.',
      words: ['张', '层', '换', '信用卡', '借', '公斤', '元', '口', '分', '一共', '只', '双', '角', '块', '钱', '花钱', '银行卡', '现金', '数', '数量', '算']
    },
    {
      num: 9,
      title: 'Bài 9 - Hành động và Công nghệ',
      subtitle: 'Truy cập internet, gửi nhận tin nhắn, thiết bị số và thói quen công nghệ.',
      words: ['发现', '新闻', '感兴趣', '放', '关', '带', '明白', '忘记', '接', '发', '上网', '网站', '邮箱', '邮件', '短信', '发短信', '打电话', '打开', '收到', '收', '查']
    },
    {
      num: 10,
      title: 'Bài 10 - Thời gian và Tần suất',
      subtitle: 'Khoảng thời gian, các buổi trong ngày, nhịp độ và tần suất xuất hiện.',
      words: ['久', '刻', '后来', '几乎', '刚才', '多么', '半', '一般', '差', '以前', '总是', '一直', '平时', '经常', '有时', '过去', '将来', '目前', '当时', '终于', '最近']
    },
    {
      num: 11,
      title: 'Bài 11 - Thái độ và Quan điểm',
      subtitle: 'Bày tỏ quan điểm cá nhân, sự đồng tình, tính tất yếu và nhận định chủ quan.',
      words: ['当然', '必须', '愿意', '其实', '应该', '一样', '一定', '容易', '其他', '主要', '认为', '觉得', '以为', '同意', '反对', '肯定', '可能', '清楚', '明白', '重要', '看']
    },
    {
      num: 12,
      title: 'Bài 12 - Liên kết câu và Ngữ pháp nâng cao',
      subtitle: 'Cấu trúc câu chữ 把, câu bị động, câu điều kiện và liên từ nối vế câu.',
      words: ['为', '先', '把', '一边', '地', '如果', '只有……才……', '又', '或者', '为了', '关于', '不但……而且……', '虽然……但是……', '因为……所以……', '越……越……', '只要……就……', '除了……以外', '不仅', '而且', '尽管', '既然']
    },
    {
      num: 13,
      title: 'Bài 13 - Diện mạo và Cơ thể',
      subtitle: 'Các bộ phận đầu mắt mũi miệng, tay chân và mô tả vóc dáng cao thấp gầy béo.',
      words: ['短', '脚', '瘦', '胖', '矮', '老', '腿', '鼻子', '耳朵', '长', '脸', '眼睛', '牙', '手', '身体', '手指', '脖子', '肚子', '腰', '背', '个子']
    },
    {
      num: 14,
      title: 'Bài 14 - Sức khỏe và Sinh hoạt',
      subtitle: 'Trạng thái đói no, khát nước, rèn luyện thể thao, nghỉ ngơi và hồi phục thể lực.',
      words: ['饿', '渴', '照顾', '锻炼', '检查', '饱', '请假', '休假', '住院', '药', '药方', '打针', '吃药', '休息', '散步', '精神', '力气', '力', '睡', '醒', '睡着']
    },
    {
      num: 15,
      title: 'Bài 15 - Gia đình và Giao tiếp',
      subtitle: 'Quan hệ họ hàng thân tộc, hàng xóm láng giềng, kết hôn và tiếp đãi khách khứa.',
      words: ['邻居', '欢迎', '相信', '见面', '讲', '聊天', '结婚', '阿姨', '做客', '客人', '请客', '亲戚', '爷爷', '奶奶', '父母', '孩子', '小时候', '长大', '认识', '介绍', '朋友']
    },
    {
      num: 16,
      title: 'Bài 16 - Ẩm thực và Bàn ăn',
      subtitle: 'Món ăn, đồ ngọt bánh kem, dụng cụ đũa bát đĩa và thói quen gọi đồ ăn ngoài.',
      words: ['饮料', '瓶子', '米', '香蕉', '甜', '筷子', '菜单', '蛋糕', '碗', '面包', '盘子', '超市', '西瓜', '糖', '外卖', '茶', '绿茶', '红茶', '点菜', '尝', '味道']
    },
    {
      num: 17,
      title: 'Bài 17 - Mua sắm và Trang phục',
      subtitle: 'Chọn lựa trang phục quần áo váy vóc, thử đồ, tặng quà và thanh toán tại tiệm.',
      words: ['礼物', '试', '皮鞋', '银行', '简单', '用', '种', '裙子', '衬衫', '鞋', '雨衣', '衣服', '裤子', '帽子', '颜色', '合适', '打折', '商场', '买', '卖', '选']
    },
    {
      num: 18,
      title: 'Bài 18 - Nhà cửa và Đồ dùng',
      subtitle: 'Căn phòng, đồ điện gia dụng máy lạnh máy giặt, hành lý và máy ảnh lưu niệm.',
      words: ['环境', '清楚', '电梯', '笔记本', '词典', '照片', '空调', '照相机', '行李箱', '灯', '屋子', '房间', '房', '洗衣机', '相机', '照相', '照', '门', '窗户', '桌子', '椅子']
    },
    {
      num: 19,
      title: 'Bài 19 - Thiên nhiên và Muôn loài',
      subtitle: 'Cảnh quan sông núi, vầng trăng, thảo nguyên xanh và các loài động vật gấu trúc.',
      words: ['月亮', '秋', '马', '有名', '树', '西', '熊猫', '蓝', '草', '黄河', '绿', '羊', '养', '鸟', '花', '山', '河', '水', '湖', '海', '自然']
    },
    {
      num: 20,
      title: 'Bài 20 - Giao thông và Di chuyển',
      subtitle: 'Phương tiện xe đạp tàu thuyền máy bay cất cánh, qua đường và đúng giờ tàu xe.',
      words: ['自行车', '遇到', '离开', '站', '街道', '经过', '船', '辆', '骑', '起飞', '附近', '交通', '晚点', '准时', '路上', '路', '飞', '打车', '出租车', '公共汽车', '地铁']
    },
    {
      num: 21,
      title: 'Bài 21 - Học tập và Công sở',
      subtitle: 'Hiệu trưởng, quản lý doanh nghiệp, du học nước ngoài, cơ hội và yêu cầu thử thách.',
      words: ['校长', '留学', '班', '经理', '选择', '电子邮件', '黑板', '机会', '练习', '要求', '迟到', '解决', '外语', '语言', '校园', '学习', '考试', '成绩', '通过', '申请', '员']
    },
    {
      num: 22,
      title: 'Bài 22 - Sở thích và Giải trí',
      subtitle: 'Các hoạt động leo núi, chơi game, thi đấu thể thao, quần vợt cầu lông và liên hoan.',
      words: ['音乐', '爬山', '节目', '游戏', '水平', '满意', '注意', '节日', '比赛', '羽毛球', '网球', '运动会', '运动员', '晚会', '新年', '活动', '跳', '跳舞', '唱歌', '喜爱', '兴趣']
    },
    {
      num: 23,
      title: 'Bài 23 - Cảm xúc và Nhận định',
      subtitle: 'Các cung bậc cảm xúc vui vẻ, tức giận, khó chịu, so sánh hơn kém và cảm nhận nội tâm.',
      words: ['难过', '极', '需要', '生气', '特别', '难', '着急', '比较', '更', '心情', '心里', '感到', '感觉', '受到', '受', '脏', '没意思', '有意思', '兴趣', '挺', '最好']
    },
    {
      num: 24,
      title: 'Bài 24 - Thời gian và Liên từ logic',
      subtitle: 'Cấu trúc bị động 被, liên từ logic theo như, sau đó, kết thúc và các trợ từ then chốt.',
      words: ['被', '除了', '然后', '结束', '突然', '马上', '还', '越', '根据', '段', '最后', '以后', '以上', '以下', '以外', '一块儿', '只要', '只有', '只能', '只是', '直到'],
      special: [
        { hanzi: '得', pinyin: 'dé' },
        { hanzi: '得', pinyin: 'děi' }
      ]
    }
  ];

  console.log('Bắt đầu kiểm tra và khớp 514 từ vựng vào 24 bài học...');
}

generateHsk3Sql();
