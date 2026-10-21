-- ====================================================================
-- MIGRATION: HSK 4 - BƯỚC 1: DỌN DẸP 121 TỪ LỆCH CẤP & CHUẨN HÓA 518 TỪ HIỆN CÓ
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn 11/2025)
-- Đặc điểm:
--   1. Dọn dẹp 52 bản ghi HSK 4 cũ bị trùng với từ chuẩn đã có ở HSK 1, 2, 3
--   2. Chuyển 69 từ thuộc cấp độ cao (HSK 5, 6, 7-9) sang hsk_level = 'HSK 5'
--   3. Chuẩn hóa cột word_type (Từ loại tiếng Việt) cho 518 từ HSK 4 chuẩn hiện có
--   4. Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
-- ====================================================================

DO $$
DECLARE
  v_del_count integer := 0;
  v_move_count integer := 0;
  v_norm_count integer := 0;
BEGIN
  -- 1. XÓA BẢN GHI HSK 4 CŨ BỊ TRÙNG VỚI TỪ ĐÃ CÓ Ở HSK 1, 2, 3
  DELETE FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi IN ('勺子', '来自', '地点', '羽毛球', '卫生间', '合适', '凉快', '生活', '号码', '网站', '对话', '开心', '坚持', '以为', '糖', '出发', '照', '网球', '尝', '表演');
  DELETE FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi IN ('学期', '咱们', '丢', '得', '方向', '到处', '平时', '收', '发展', '毛', '遍', '语言', '刚', '大概', '页', '行', '可是', '差不多', '出生', '方法');
  DELETE FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi IN ('比如', '沙发', '最好', '挺', '节', '好像', '受到', '矿泉水', '发生', '脏', '安全', '只要');

  -- 2. CHUYỂN CÁC TỪ CẤP CAO (HSK 5, 6, 7-9) TỪ HSK 4 SANG HSK 5
  UPDATE public.vocabularies 
  SET hsk_level = 'HSK 5'
  WHERE hsk_level = 'HSK 4' AND hanzi IN ('骗', '传真', '可怜', '打扮', '烤鸭', '刷牙', '公共汽车', '北京', '因为……所以……', '红', '同情', '长城', '马虎', '爬山', '呀', '白', '排列', '杯', '迷路', '唱歌');
  UPDATE public.vocabularies 
  SET hsk_level = 'HSK 5'
  WHERE hsk_level = 'HSK 4' AND hanzi IN ('秋', '春', '虽然……但是……', '穷', '登机牌', '北边', '弹钢琴', '橡皮', '抽烟', '不大', '高速公路', '火车站', '塑料袋', '半年', '只有……才……', '聊天', '第一', '垃圾桶', '富', '占线');
  UPDATE public.vocabularies 
  SET hsk_level = 'HSK 5'
  WHERE hsk_level = 'HSK 4' AND hanzi IN ('填空', '电子邮件', '售货员', '减肥', '打篮球', '长江', '面条', '照相机', '服务员', '熊猫', '百分之', '小姐', '夏', '邮局', '行李箱', '踢足球', '大使馆', '刮风', '信封', '放暑假');
  UPDATE public.vocabularies 
  SET hsk_level = 'HSK 5'
  WHERE hsk_level = 'HSK 4' AND hanzi IN ('以', '礼拜天', '冬', '黄河', '羊肉', '黑', '不但……而且……', '付款', '绿');

  -- 3. CHUẨN HÓA CỘT word_type (TỪ LOẠI TIẾNG VIỆT) CHO 518 TỪ HSK 4 CHUẨN HIỆN CÓ
  UPDATE public.vocabularies
  SET 
    word_type = 'Thán từ',
    pinyin = 'ā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '啊';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'àiqíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '爱情';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'àixīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '爱心';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'ānjiǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '安检';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'ānpái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '安排';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Giới từ',
    pinyin = 'àn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '按';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'ànshí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '按时';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ',
    pinyin = 'ànzhào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '按照';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'báijiǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '白酒';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bàngōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '办公';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bànlǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '办理';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bànshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '办事';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'bàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '棒';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bǎohù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '保护';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'bǎozhèng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '保证';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '抱';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bàokǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '报考';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bàomíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '报名';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'bàoqiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '抱歉';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bēi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '背';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'bēibāo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '背包';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'běibù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '北部';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'bèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '倍';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'běnkē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '本科';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'běnlái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '本来';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'bèn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '笨';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'bízi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '鼻子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bǐshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '笔试';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bìyè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '毕业';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'bìyèshēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '毕业生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'biànyú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '便于';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'biāozhǔn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '标准';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'biǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '表';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'biǎogé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '表格';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'biǎoshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '表示';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'biǎoxiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '表现';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'biǎoyáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '表扬';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'bǐnggān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '饼干';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Phó từ / Liên từ',
    pinyin = 'bìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '并';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'bìngqiě'
  WHERE hsk_level = 'HSK 4' AND hanzi = '并且';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bōfàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '播放';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'bóshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '博士';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'búbì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不必';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'búbiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不便';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Phó từ',
    pinyin = 'búduàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不断';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Phó từ',
    pinyin = 'búgòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不够';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'búguò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不过';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'búlùn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不论';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'bù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '步';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Lượng từ',
    pinyin = 'bù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '部';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'bùdébù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不得不';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'bùfen'
  WHERE hsk_level = 'HSK 4' AND hanzi = '部分';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'bùguǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不管';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ / Liên từ',
    pinyin = 'bùguāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不光';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'bùjǐn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不仅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'bùmǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不满';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'bùmén'
  WHERE hsk_level = 'HSK 4' AND hanzi = '部门';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'bùrú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '不如';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'cā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '擦';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'cāi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '猜';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'cáiliào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '材料';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'cānguān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '参观';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'cānsài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '参赛';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'cāntīng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '餐厅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'cāochǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '操场';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'cèsuǒ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '厕所';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chákàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '查看';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'cháyè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '茶叶';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'cházhǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '查找';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'chàdiǎnr'
  WHERE hsk_level = 'HSK 4' AND hanzi = '差点儿';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chǎnshēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '产生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '厂';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'chǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '场';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chāoguò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '超过';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chēsù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '车速';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chēwèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '车位';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chéng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '城';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chéng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '乘';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'chénggōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '成功';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chéngkè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '乘客';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'chéngshí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '诚实';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chéngwéi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '成为';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chéngzuò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '乘坐';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chījīng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '吃惊';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'chí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '迟';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'chóng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '重';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'chóngxīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '重新';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chūchāi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '出差';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chūkǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '出口';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chūxiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '出现';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chūxíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '出行';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chūzū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '出租';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chúfáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '厨房';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chúshī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '厨师';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chuāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '窗';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'chuānghu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '窗户';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'chuī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '吹';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'cíyǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '词语';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ',
    pinyin = 'cǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '此';
  UPDATE public.vocabularies
  SET 
    word_type = 'Cụm từ',
    pinyin = 'cǐ cì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '此次';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'cǐwài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '此外';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'cóngcǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '从此';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'cónglái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '从来';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'cóngzhōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '从中';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'cū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '粗';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'cūxīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '粗心';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'cūn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '村';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'cún'
  WHERE hsk_level = 'HSK 4' AND hanzi = '存';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'cuòguò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '错过';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Danh từ',
    pinyin = 'cuòwù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '错误';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dāying'
  WHERE hsk_level = 'HSK 4' AND hanzi = '答应';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dá'
  WHERE hsk_level = 'HSK 4' AND hanzi = '答';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dá’àn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '答案';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dádào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '达到';
  UPDATE public.vocabularies
  SET 
    word_type = 'Cụm từ',
    pinyin = 'dǎ zhāohu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '打招呼';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dǎbài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '打败';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dǎgōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '打工';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dǎrǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '打扰';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dǎyìn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '打印';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dǎyìnjī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '打印机';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dǎzhé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '打折';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dǎzhēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '打针';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dàbā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '大巴';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'dàdà'
  WHERE hsk_level = 'HSK 4' AND hanzi = '大大';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dàifu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '大夫';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'dàliàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '大量';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dàsài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '大赛';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dàtīng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '大厅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'dàyuē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '大约';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dàzìrán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '大自然';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dāi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '待';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '戴';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dàizi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '袋子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dānwèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '单位';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Giới từ',
    pinyin = 'dāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '当';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dāngshí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '当时';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dāo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '刀';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'dǎoyóu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '导游';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '倒';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Lượng từ',
    pinyin = 'dào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '道';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'dàodǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '到底';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dàolái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '到来';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dàolù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '道路';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dàoqiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '道歉';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'déyì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '得意';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dēngjī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '登机';
  UPDATE public.vocabularies
  SET 
    word_type = 'Trợ từ',
    pinyin = 'děng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '等';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ',
    pinyin = 'děngdào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '等到';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'dī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '低';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dījià'
  WHERE hsk_level = 'HSK 4' AND hanzi = '低价';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dīwēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '低温';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dīyú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '低于';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '底';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dǐxia'
  WHERE hsk_level = 'HSK 4' AND hanzi = '底下';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dìqiú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '地球';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dìzhǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '地址';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'diǎnmíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '点名';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'diǎntóu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '点头';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'diàndòngchē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '电动车';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'diànshìjù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '电视剧';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'diào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '掉';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'diàochá'
  WHERE hsk_level = 'HSK 4' AND hanzi = '调查';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '订';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '定';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dōngbù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '东部';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dòngchē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '动车';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dòngzuò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '动作';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dúzhě'
  WHERE hsk_level = 'HSK 4' AND hanzi = '读者';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dǔchē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '堵车';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'dùjià'
  WHERE hsk_level = 'HSK 4' AND hanzi = '度假';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'dùzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '肚子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'duǎnxìn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '短信';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'duì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '队';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'duìfāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '对方';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'duìmiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '对面';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ',
    pinyin = 'duìyú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '对于';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'duìyuán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '队员';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'duìzhǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '队长';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'dùn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '顿';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'duōme'
  WHERE hsk_level = 'HSK 4' AND hanzi = '多么';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'duōshù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '多数';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'duōyàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '多样';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'ér'
  WHERE hsk_level = 'HSK 4' AND hanzi = '而';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'értóng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '儿童';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'fāchū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '发出';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'fāsòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '发送';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '法';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fǎlǜ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '法律';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'fānyì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '翻译';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'fán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '烦';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'fánnǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '烦恼';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'fǎnduì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '反对';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fāngmiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '方面';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fāngshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '方式';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fángdōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '房东';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fángzū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '房租';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'fàngqì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '放弃';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'fàngsōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '放松';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Động từ',
    pinyin = 'fèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '费';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fèiyong'
  WHERE hsk_level = 'HSK 4' AND hanzi = '费用';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fēnshù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '分数';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'fēnwéi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '分为';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'fèn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '份';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'fēngfù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '丰富';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fēngjǐng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '风景';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'fǒuzé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '否则';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'fú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '幅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'fúhé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '符合';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'fù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '付';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fùmǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '父母';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fùnǚ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '父女';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fùqīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '父亲';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'fùyìn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '复印';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'fùzá'
  WHERE hsk_level = 'HSK 4' AND hanzi = '复杂';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'fùzé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '负责';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fùzérén'
  WHERE hsk_level = 'HSK 4' AND hanzi = '负责人';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'fùzǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '父子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gǎi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '改';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gǎibiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '改变';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'gān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '干';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gānbēi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '干杯';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '赶';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '敢';
  UPDATE public.vocabularies
  SET 
    word_type = 'Hậu tố',
    pinyin = 'gǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '感';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'gǎndòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '感动';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'gǎnjǐn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '赶紧';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Động từ',
    pinyin = 'gǎnjué'
  WHERE hsk_level = 'HSK 4' AND hanzi = '感觉';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'gǎnkuài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '赶快';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gǎnqíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '感情';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'gǎnrén'
  WHERE hsk_level = 'HSK 4' AND hanzi = '感人';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gǎnshàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '赶上';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'gǎnshòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '感受';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gǎnxiè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '感谢';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gànhuór'
  WHERE hsk_level = 'HSK 4' AND hanzi = '干活儿';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gāngqín'
  WHERE hsk_level = 'HSK 4' AND hanzi = '钢琴';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gāojià'
  WHERE hsk_level = 'HSK 4' AND hanzi = '高价';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gāokǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '高考';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'gāosù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '高速';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gāowēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '高温';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gāoyú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '高于';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gēbo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '胳膊';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gēshēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '歌声';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gēshǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '歌手';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ / Phó từ',
    pinyin = 'gè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '各';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gèdì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '各地';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ / Phó từ',
    pinyin = 'gègè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '各个';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ',
    pinyin = 'gèwèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '各位';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ',
    pinyin = 'gèzhǒng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '各种';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'gèngjiā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '更加';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gōngchǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '工厂';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gōngfu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '功夫';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'gōnggòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '公共';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gōngkè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '功课';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'gōnglǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '公里';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gōnglù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '公路';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gōngrén'
  WHERE hsk_level = 'HSK 4' AND hanzi = '工人';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gōngzī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '工资';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'gòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '共';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'gòngtóng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '共同';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Phó từ',
    pinyin = 'gòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '够';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gòumǎi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '购买';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gòuwù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '购物';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gūjì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '估计';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gūniang'
  WHERE hsk_level = 'HSK 4' AND hanzi = '姑娘';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'gǔlì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '鼓励';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'gùkè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '顾客';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'gùyì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '故意';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'guà'
  WHERE hsk_level = 'HSK 4' AND hanzi = '挂';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'guānjiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '关键';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'guānkàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '观看';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'guānzhòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '观众';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'guǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '管';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'guǎnlǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '管理';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ / Động từ / Phó từ',
    pinyin = 'guāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '光';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'guǎngbō'
  WHERE hsk_level = 'HSK 4' AND hanzi = '广播';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'guǎnggào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '广告';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'guàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '逛';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'guīdìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '规定';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'guójí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '国籍';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Danh từ',
    pinyin = 'guójì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '国际';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'guǒzhī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '果汁';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'guòchéng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '过程';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'hǎiyáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '海洋';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'hàixiū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '害羞';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'hánjià'
  WHERE hsk_level = 'HSK 4' AND hanzi = '寒假';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'hánlěng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '寒冷';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'hǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '喊';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'hàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '汗';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'hángbān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '航班';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'hǎochù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '好处';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'hǎohǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '好好';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'hǎoxiào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '好笑';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'hégé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '合格';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'hézi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '盒子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'hóngbāo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '红包';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'hòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '厚';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'hòuhuǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '后悔';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'hūrán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '忽然';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'hùliánwǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '互联网';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'hùshi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '护士';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'hùxiāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '互相';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'huàjù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '话剧';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'huáiyí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '怀疑';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'huàichù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '坏处';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'huánbǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '环保';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'huànchéng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '换乘';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'huífù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '回复';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'huíxìn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '回信';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'huíyì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '回忆';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'huìyuán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '会员';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ / Danh từ',
    pinyin = 'huó'
  WHERE hsk_level = 'HSK 4' AND hanzi = '活';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'huódòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '活动';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'huópō'
  WHERE hsk_level = 'HSK 4' AND hanzi = '活泼';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'huǒ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '火';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'huò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '货';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'huòdé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '获得';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'huòjiǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '获奖';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'huòqǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '获取';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'jīběn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '基本';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'jīběnshàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '基本上';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jīchǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '基础';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'jīdòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '激动';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'jījí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '积极';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jīlěi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '积累';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'jíshí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '及时';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'jíshǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '即使';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ / Liên từ',
    pinyin = 'jì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '既';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '寄';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Động từ',
    pinyin = 'jìhuà'
  WHERE hsk_level = 'HSK 4' AND hanzi = '计划';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'jìrán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '既然';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jìshù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '技术';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jìxù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '继续';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jìzhě'
  WHERE hsk_level = 'HSK 4' AND hanzi = '记者';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiābān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '加班';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiājù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '家具';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiākuài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '加快';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiāqiáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '加强';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiārù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '加入';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'jiāshàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '加上';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiātíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '家庭';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiāxiāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '家乡';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiāyóu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '加油';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiāyóuzhàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '加油站';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiāzhǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '家长';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'jiǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '假';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiàgé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '价格';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiàqián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '价钱';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiàrì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '假日';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '减';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiǎnqīng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '减轻';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiǎnshǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '减少';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiànshēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '健身';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiànshēnfáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '健身房';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'jiànyì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '建议';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '江';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ / Phó từ',
    pinyin = 'jiāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '将';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiānglái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '将来';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'jiāngyào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '将要';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '奖';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiǎngjīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '奖金';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiǎngxuéjīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '奖学金';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '降';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiàngdī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '降低';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiàngjià'
  WHERE hsk_level = 'HSK 4' AND hanzi = '降价';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiàngluò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '降落';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiàngwēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '降温';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiāo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '交';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Danh từ',
    pinyin = 'jiāo’ào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '骄傲';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiāojǐng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '交警';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiāoliú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '交流';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiāoqū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '郊区';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiāotōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '交通';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiàoliàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '教练';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiàoshī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '教师';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiàoshòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '教授';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiàoxué'
  WHERE hsk_level = 'HSK 4' AND hanzi = '教学';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Động từ',
    pinyin = 'jiàoyù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '教育';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiàozuò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '叫作';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiēdào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '街道';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiēshòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '接受';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Phó từ',
    pinyin = 'jiēzhe'
  WHERE hsk_level = 'HSK 4' AND hanzi = '接着';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Liên từ',
    pinyin = 'jiéguǒ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '结果';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jiéjiàrì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '节假日';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiéyuē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '节约';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiézhàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '结账';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jiěshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '解释';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jīnhòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '今后';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'jǐn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '仅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ / Liên từ',
    pinyin = 'jǐnguǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '尽管';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'jǐnjǐn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '仅仅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'jǐnzhāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '紧张';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jìnrù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '进入';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jìnxíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '进行';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jìnzhǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '禁止';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'jīngcǎi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '精彩';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jīngjì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '经济';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jīngjù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '京剧';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'jīnglì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '经历';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jīngyàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '经验';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jǐngchá'
  WHERE hsk_level = 'HSK 4' AND hanzi = '警察';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jǐngdiǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '景点';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jǐngqū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '景区';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jǐngsè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '景色';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'jìngrán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '竟然';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jìngzhēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '竞争';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jìngzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '镜子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'jiūjìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '究竟';
  UPDATE public.vocabularies
  SET 
    word_type = 'Trợ từ / Phó từ / Liên từ',
    pinyin = 'jiùshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '就是';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '举';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jǔbàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '举办';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jǔlì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '举例';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jǔxíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '举行';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '聚';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jùcān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '聚餐';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'jùhuì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '聚会';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'jùjué'
  WHERE hsk_level = 'HSK 4' AND hanzi = '拒绝';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'jùlí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '距离';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'jùyuàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '剧院';
  UPDATE public.vocabularies
  SET 
    word_type = 'Cụm từ',
    pinyin = 'kāi wánxiào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '开玩笑';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kànfǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '看法';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'kǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '烤';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'kǎolǜ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '考虑';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kǎoshēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '考生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'kē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '棵';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kējì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '科技';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'kēxué'
  WHERE hsk_level = 'HSK 4' AND hanzi = '科学';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'ké'
  WHERE hsk_level = 'HSK 4' AND hanzi = '咳';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'késou'
  WHERE hsk_level = 'HSK 4' AND hanzi = '咳嗽';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'kěxī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '可惜';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'kè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '克';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kèchéng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '课程';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'kèqi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '客气';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kètáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '课堂';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kètīng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '客厅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ / Phó từ',
    pinyin = 'kěndìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '肯定';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'kōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '空';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kōngqì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '空气';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Phó từ',
    pinyin = 'kǒngpà'
  WHERE hsk_level = 'HSK 4' AND hanzi = '恐怕';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ / Danh từ',
    pinyin = 'kòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '空';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kǒuyǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '口语';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'kǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '苦';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kuàicān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '快餐';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'kuàidì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '快递';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'kuàisù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '快速';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'kùn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '困';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Danh từ',
    pinyin = 'kùnnan'
  WHERE hsk_level = 'HSK 4' AND hanzi = '困难';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'lā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '拉';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'lājī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '垃圾';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'là'
  WHERE hsk_level = 'HSK 4' AND hanzi = '辣';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'láibují'
  WHERE hsk_level = 'HSK 4' AND hanzi = '来不及';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'láidejí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '来得及';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'lǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '懒';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'làngfèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '浪费';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'làngmàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '浪漫';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'lǎohǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '老虎';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'lǎojiā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '老家';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'lǎonián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '老年';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'lǎoshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '老是';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'lěngjìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '冷静';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'lǐfà'
  WHERE hsk_level = 'HSK 4' AND hanzi = '理发';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'lǐjiě'
  WHERE hsk_level = 'HSK 4' AND hanzi = '理解';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'lǐmào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '礼貌';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'lǐxiǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '理想';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'lìhai'
  WHERE hsk_level = 'HSK 4' AND hanzi = '厉害';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'lìqi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '力气';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'lìrú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '例如';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'lìzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '例子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Số lượng từ',
    pinyin = 'liǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '俩';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ',
    pinyin = 'lián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '连';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'liánxì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '联系';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'liáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '凉';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'liáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '量';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'liǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '两';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'liàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '亮';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Lượng từ',
    pinyin = 'liè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '列';
  UPDATE public.vocabularies
  SET 
    word_type = 'Cụm từ',
    pinyin = 'líng xià'
  WHERE hsk_level = 'HSK 4' AND hanzi = '零下';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'línghuāqián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '零花钱';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'língqián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '零钱';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'língshí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '零食';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ',
    pinyin = 'lìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '另';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ / Phó từ / Liên từ',
    pinyin = 'lìngwài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '另外';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'liú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '留';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'liú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '流';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'liúlì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '流利';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'liúxia'
  WHERE hsk_level = 'HSK 4' AND hanzi = '留下';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'liúxíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '流行';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'lùguò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '路过';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'lǚguǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '旅馆';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'lǚkè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '旅客';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'lǚxíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '旅行';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'lǜshī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '律师';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'luàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '乱';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'luò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '落';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ / Danh từ',
    pinyin = 'máfan'
  WHERE hsk_level = 'HSK 4' AND hanzi = '麻烦';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mántou'
  WHERE hsk_level = 'HSK 4' AND hanzi = '馒头';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'mǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '满';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'máojīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '毛巾';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'máoyī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '毛衣';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'màozi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '帽子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'měi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '美';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'měihǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '美好';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'měijǐng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '美景';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'měilì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '美丽';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'měishí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '美食';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Động từ',
    pinyin = 'mèng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '梦';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'mèngxiǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '梦想';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mìmǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '密码';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'miǎnfèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '免费';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'miànduì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '面对';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'miànshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '面试';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'miǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '秒';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mínzú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '民族';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '末';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mǔnǚ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '母女';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mǔqīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '母亲';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mǔzǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '母子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mùbiāo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '目标';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mùdì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '目的';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mùdìdì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '目的地';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'mùqián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '目前';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Danh từ',
    pinyin = 'nàixīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '耐心';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'nánbù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '南部';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'nándào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '难道';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'nánshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '男士';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'nánshòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '难受';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'nánwàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '难忘';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'nánxìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '男性';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'nèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '内';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'nèiróng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '内容';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'nèixīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '内心';
  UPDATE public.vocabularies
  SET 
    word_type = 'Cụm từ',
    pinyin = 'néng fǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '能否';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'nénggòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '能够';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'nénglì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '能力';
  UPDATE public.vocabularies
  SET 
    word_type = 'Thán từ',
    pinyin = 'ǹg'
  WHERE hsk_level = 'HSK 4' AND hanzi = '嗯';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'niándǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '年底';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'niánlíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '年龄';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'nóngcūn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '农村';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'nòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '弄';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'nǚxìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '女性';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'nuǎnhuo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '暖和';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ / Tính từ',
    pinyin = 'ǒu’ěr'
  WHERE hsk_level = 'HSK 4' AND hanzi = '偶尔';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'pāi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '拍';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ / Lượng từ',
    pinyin = 'pái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '排';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'pái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '牌';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'páiduì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '排队';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'páiqiú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '排球';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'páizi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '牌子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'pànduàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '判断';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'péi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '陪';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'pīpíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '批评';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'pífū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '皮肤';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'píqi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '脾气';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'píxié'
  WHERE hsk_level = 'HSK 4' AND hanzi = '皮鞋';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Lượng từ',
    pinyin = 'piān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '篇';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Lượng từ',
    pinyin = 'piàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '片';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'pīngpāngqiú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '乒乓球';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Danh từ',
    pinyin = 'píngcháng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '平常';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'pò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '破';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'pútao'
  WHERE hsk_level = 'HSK 4' AND hanzi = '葡萄';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'pútaojiǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '葡萄酒';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'pǔbiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '普遍';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'pǔtōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '普通';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'pǔtōnghuà'
  WHERE hsk_level = 'HSK 4' AND hanzi = '普通话';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'qī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '期';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qīmò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '期末';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qīzhōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '期中';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ',
    pinyin = 'qícì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '其次';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qízhōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '其中';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'qǐdào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '起到';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Động từ',
    pinyin = 'qì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '气';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qìhòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '气候';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qìshuǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '汽水';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qìwēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '气温';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'qiānkè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '千克';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'qiānwàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '千万';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'qiānzhèng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '签证';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qiánfāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '前方';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qiánhòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '前后';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'qiáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '强';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'qiāo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '敲';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qiáo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '桥';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'qiǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '巧';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qiǎokèlì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '巧克力';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qīnqi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '亲戚';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qín'
  WHERE hsk_level = 'HSK 4' AND hanzi = '琴';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'qīng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '轻';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qīngnián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '青年';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'qīngsōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '轻松';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qíngkuàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '情况';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'qìngzhù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '庆祝';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qiúduì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '球队';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qiúmí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '球迷';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'qū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '区';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'qūbié'
  WHERE hsk_level = 'HSK 4' AND hanzi = '区别';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'qǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '取';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'qǔdé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '取得';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'qǔxiāo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '取消';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'quán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '全';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'quánbù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '全部';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'quándōu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '全都';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'quánqiú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '全球';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'quánshēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '全身';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'quē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '缺';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'quēdiǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '缺点';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'quēshǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '缺少';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'què'
  WHERE hsk_level = 'HSK 4' AND hanzi = '却';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'quèshí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '确实';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'rán’ér'
  WHERE hsk_level = 'HSK 4' AND hanzi = '然而';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ / Danh từ',
    pinyin = 'rènao'
  WHERE hsk_level = 'HSK 4' AND hanzi = '热闹';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'rénshēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '人生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'rénshù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '人数';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'rényuán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '人员';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ',
    pinyin = 'rènhé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '任何';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'rènwu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '任务';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'rēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '扔';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'réng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '仍';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'réngrán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '仍然';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'rìcháng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '日常';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'rìjì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '日记';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'rìqī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '日期';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'rìzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '日子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'rù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '入';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'rùkǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '入口';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'rùxué'
  WHERE hsk_level = 'HSK 4' AND hanzi = '入学';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'rùzhù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '入住';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'sànbù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '散步';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'sǎomǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '扫码';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'sēnlín'
  WHERE hsk_level = 'HSK 4' AND hanzi = '森林';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shāngliang'
  WHERE hsk_level = 'HSK 4' AND hanzi = '商量';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shāngpǐn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '商品';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'shāngxīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '伤心';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shàngmén'
  WHERE hsk_level = 'HSK 4' AND hanzi = '上门';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'shāo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '稍';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'shāowēi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '稍微';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'shǎojiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '少见';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'shǎoliàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '少量';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shǎoshù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '少数';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shàonián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '少年';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shèhuì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '社会';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'shèshìdù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '摄氏度';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Lượng từ',
    pinyin = 'shēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '身';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'shēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '深';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shēnfènzhèng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '身份证';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shēnqǐng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '申请';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'shènzhì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '甚至';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'shēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shēngmìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '生命';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shēngyi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '生意';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shěng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '省';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shèng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '剩';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'shībài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '失败';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shīfu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '师傅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shīqù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '失去';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shīshēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '师生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'shīwàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '失望';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'shífēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '十分';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'shíjì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '实际';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shíjiānbiǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '时间表';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'shíjìshàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '实际上';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shípǐn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '食品';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shítáng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '食堂';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shíwù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '食物';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'shízài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '实在';
  UPDATE public.vocabularies
  SET 
    word_type = 'Cụm từ',
    pinyin = 'shízì lùkǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '十字路口';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '使';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shǐguǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '使馆';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shǐyòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '使用';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shìchǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '市场';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'shìfǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '是否';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shìhé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '适合';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shìjì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '世纪';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shìpín'
  WHERE hsk_level = 'HSK 4' AND hanzi = '视频';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shìqū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '市区';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shìtí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '试题';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shìyìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '适应';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shōufèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '收费';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'shōurù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '收入';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shōushi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '收拾';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shōutīng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '收听';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'shǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '首';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shǒudū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '首都';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ / Đại từ',
    pinyin = 'shǒuxiān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '首先';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shòubuliǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '受不了';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shòupiàoyuán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '售票员';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shòushāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '受伤';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '输';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'shú/shóu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '熟';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'shúxi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '熟悉';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shǔjià'
  WHERE hsk_level = 'HSK 4' AND hanzi = '暑假';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Số từ',
    pinyin = 'shù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '数';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shùliàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '数量';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shùlín'
  WHERE hsk_level = 'HSK 4' AND hanzi = '树林';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shùzì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '数字';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'shuài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '帅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'shùnbiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '顺便';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'shùnlì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '顺利';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shùnxù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '顺序';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shuōfǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '说法';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'shuōmíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '说明';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shuōmíngshū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '说明书';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'shuòshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '硕士';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'sǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '死';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'sùdù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '速度';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'sùliào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '塑料';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'suān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '酸';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'suānnǎi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '酸奶';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Phó từ',
    pinyin = 'suàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '算';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ / Liên từ',
    pinyin = 'suíbiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '随便';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ',
    pinyin = 'suízhe'
  WHERE hsk_level = 'HSK 4' AND hanzi = '随着';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'sūnnǚ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '孙女';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'sūnzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '孙子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'suǒyǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '所有';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'tái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '台';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '抬';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'táitóu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '抬头';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tàidù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '态度';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '弹';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '谈';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '汤';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '躺';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'tàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '趟';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tǎolùn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '讨论';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'tǎoyàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '讨厌';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tèdiǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '特点';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '提';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tíchū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '提出';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tídào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '提到';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tígōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '提供';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tíqián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '提前';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tíxǐng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '提醒';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tǐjiǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '体检';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tǐwēn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '体温';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tǐzhòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '体重';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tiánxiě'
  WHERE hsk_level = 'HSK 4' AND hanzi = '填写';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tiáojiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '条件';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tīnglì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '听力';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tīngzhòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '听众';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '停';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tíngchē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '停车';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tíngchēchǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '停车场';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tíngzhǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '停止';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'tōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '通';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Giới từ',
    pinyin = 'tōngguò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '通过';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'tōngzhī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '通知';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tóngnián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '童年';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Liên từ',
    pinyin = 'tóngshí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '同时';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'tóngyàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '同样';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tǒng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '桶';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'tòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '痛';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'tóutòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '头痛';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '图';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'túpiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '图片';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'tǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '土';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tuī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '推';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tuīchí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '推迟';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tuīchū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '推出';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'tuō'
  WHERE hsk_level = 'HSK 4' AND hanzi = '脱';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wàzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '袜子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'wàichū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '外出';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wàitào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '外套';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'wánquán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '完全';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'wǎn’ān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '晚安';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wǎncān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '晚餐';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'wǎnggòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '网购';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'wǎngwǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '往往';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wǎngyè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '网页';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wǎngyǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '网友';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wǎngzhǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '网址';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Danh từ',
    pinyin = 'wēixiǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '危险';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'wéi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '为';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '味';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wèidào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '味道';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Danh từ',
    pinyin = 'wèishēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '卫生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wēndù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '温度';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'wén'
  WHERE hsk_level = 'HSK 4' AND hanzi = '闻';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wénjiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '文件';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wénzhāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '文章';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wénzì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '文字';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'wūrǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '污染';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'wú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '无';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'wúfǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '无法';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'wúliáo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '无聊';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'wúlùn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '无论';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'wǔcān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '午餐';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'wùhuì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '误会';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'xī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '吸';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xībù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '西部';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xīhóngshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '西红柿';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'xīyǐn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '吸引';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'xì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '细';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'xìxīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '细心';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'xiàjiàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '下降';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'xiān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '鲜';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiānhuā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '鲜花';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'xián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '咸';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiànjīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '现金';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'xiànmù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '羡慕';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiànshàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '线上';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiànxià'
  WHERE hsk_level = 'HSK 4' AND hanzi = '线下';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'xiànyǒu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '现有';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'xiāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '香';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'xiāngbǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '相比';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Liên từ',
    pinyin = 'xiāngfǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '相反';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'xiānghù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '相互';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'xiāngtóng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '相同';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'xiángxì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '详细';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'xiǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '响';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiǎngfǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '想法';
  UPDATE public.vocabularies
  SET 
    word_type = 'Lượng từ',
    pinyin = 'xiàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '项';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiāoxi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '消息';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiǎochī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '小吃';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiǎohuǒzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '小伙子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiǎoshuō'
  WHERE hsk_level = 'HSK 4' AND hanzi = '小说';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiǎozǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '小组';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiàoguǒ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '效果';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Động từ',
    pinyin = 'xiàohua'
  WHERE hsk_level = 'HSK 4' AND hanzi = '笑话';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiě'
  WHERE hsk_level = 'HSK 4' AND hanzi = '血';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '心';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'xīnkǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '辛苦';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xīnqíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '心情';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xìnhào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '信号';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xìnxī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '信息';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xìnxīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '信心';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'xīngfèn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '兴奋';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xīngxing'
  WHERE hsk_level = 'HSK 4' AND hanzi = '星星';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'xǐng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '醒';
  UPDATE public.vocabularies
  SET 
    word_type = 'Hậu tố',
    pinyin = 'xìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '性';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xìngbié'
  WHERE hsk_level = 'HSK 4' AND hanzi = '性别';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'xìngfú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '幸福';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xìnggé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '性格';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xiōngdì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '兄弟';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xióng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '熊';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'xiū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '修';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'xiūlǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '修理';
  UPDATE public.vocabularies
  SET 
    word_type = 'Số từ',
    pinyin = 'xǔduō'
  WHERE hsk_level = 'HSK 4' AND hanzi = '许多';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xuéfèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '学费';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'xuéyuàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '学院';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '压';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yālì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '压力';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yágāo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '牙膏';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'Yàzhōu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '亚洲';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '烟';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '盐';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Động từ',
    pinyin = 'yángé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '严格';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yánjiū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '研究';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yánjiūshēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '研究生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'yánzhòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '严重';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '演';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yǎnchàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '演唱';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yǎnchū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '演出';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yǎnjìng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '眼镜';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yǎnqián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '眼前';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yǎnyuán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '演员';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yángguāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '阳光';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yǎngchéng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '养成';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yàngzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '样子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yāoqǐng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '邀请';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'yàoshi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '要是';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yàoshi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '钥匙';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'yěxǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '也许';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Lượng từ',
    pinyin = 'yè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '夜';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yèwǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '夜晚';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yèzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '叶子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Đại từ',
    pinyin = 'yíqiè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '一切';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'yǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '已';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yǐnèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '以内';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yìjiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '意见';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yìshēng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '一生';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yìshù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '艺术';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'yīncǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '因此';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yǐnqǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '引起';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yìnxiàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '印象';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '赢';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yíngdé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '赢得';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yìngpìn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '应聘';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'yǒnggǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '勇敢';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ / Danh từ',
    pinyin = 'yǒngyuǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '永远';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yònglái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '用来';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yòngyú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '用于';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yōudiǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '优点';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'yōumò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '幽默';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'yōuxiù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '优秀';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ',
    pinyin = 'yóu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '由';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yóu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '油';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'yóuqí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '尤其';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yóuwán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '游玩';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ / Liên từ',
    pinyin = 'yóuyú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '由于';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'yǒuhǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '友好';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yǒuqíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '友情';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'yǒuqù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '有趣';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yǒuxiào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '有效';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yǒuyì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '友谊';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yǒuzhe'
  WHERE hsk_level = 'HSK 4' AND hanzi = '有着';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'yúkuài'
  WHERE hsk_level = 'HSK 4' AND hanzi = '愉快';
  UPDATE public.vocabularies
  SET 
    word_type = 'Liên từ',
    pinyin = 'yúshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '于是';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ / Liên từ',
    pinyin = 'yǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '与';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yǔfǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '语法';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yùxí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '预习';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ / Phó từ',
    pinyin = 'yuánlái'
  WHERE hsk_level = 'HSK 4' AND hanzi = '原来';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yuánliàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '原谅';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yuányīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '原因';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yuǎnlí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '远离';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yuànzhǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '院长';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yuànzi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '院子';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Phó từ',
    pinyin = 'yuē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '约';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'yuēhuì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '约会';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yuèbing'
  WHERE hsk_level = 'HSK 4' AND hanzi = '月饼';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yuèdú'
  WHERE hsk_level = 'HSK 4' AND hanzi = '阅读';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yuèfèn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '月份';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'yún'
  WHERE hsk_level = 'HSK 4' AND hanzi = '云';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'yǔnxǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '允许';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zázhì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '杂志';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'zàicì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '再次';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Liên từ',
    pinyin = 'zàishuō'
  WHERE hsk_level = 'HSK 4' AND hanzi = '再说';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zànshí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '暂时';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zàntíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '暂停';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zǎocān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '早餐';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zǎochen'
  WHERE hsk_level = 'HSK 4' AND hanzi = '早晨';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zérèn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '责任';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zēngjiā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '增加';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zēngzhǎng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '增长';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhāopìn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '招聘';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zháo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '着';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zháohuǒ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '着火';
  UPDATE public.vocabularies
  SET 
    word_type = 'Trợ từ',
    pinyin = 'zhě'
  WHERE hsk_level = 'HSK 4' AND hanzi = '者';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'zhēnzhèng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '真正';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhěng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '整';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhěnggè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '整个';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhěnglǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '整理';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhèng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '证';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhèngcháng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '正常';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ / Phó từ',
    pinyin = 'zhènghǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '正好';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhèngjiàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '证件';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'zhèngmíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '证明';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhèngquè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '正确';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhèngshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '正式';
  UPDATE public.vocabularies
  SET 
    word_type = 'Trợ từ',
    pinyin = 'zhī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '之';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhīchí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '支持';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhīfù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '支付';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhīhòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '之后';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhījiān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '之间';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhīqián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '之前';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhīshi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '知识';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhīzhōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '之中';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'zhí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '值';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhídé'
  WHERE hsk_level = 'HSK 4' AND hanzi = '值得';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhíjiē'
  WHERE hsk_level = 'HSK 4' AND hanzi = '直接';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhíwù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '植物';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhíyè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '职业';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhǐ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '指';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhǐchū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '指出';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'zhǐhǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '只好';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhǐjīn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '纸巾';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhìliàng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '质量';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ',
    pinyin = 'zhìshǎo'
  WHERE hsk_level = 'HSK 4' AND hanzi = '至少';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhōngcān'
  WHERE hsk_level = 'HSK 4' AND hanzi = '中餐';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhōngnián'
  WHERE hsk_level = 'HSK 4' AND hanzi = '中年';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '种';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'zhòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '重';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Phó từ',
    pinyin = 'zhòngdiǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '重点';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhòngshì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '重视';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhōuwéi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '周围';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zhǔyi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '主意';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhù'
  WHERE hsk_level = 'HSK 4' AND hanzi = '祝';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhùhè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '祝贺';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhùmíng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '著名';
  UPDATE public.vocabularies
  SET 
    word_type = 'Phó từ / Tính từ',
    pinyin = 'zhuānmén'
  WHERE hsk_level = 'HSK 4' AND hanzi = '专门';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ',
    pinyin = 'zhuānyè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '专业';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhuǎn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '转';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhuǎnfā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '转发';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhuǎnjī'
  WHERE hsk_level = 'HSK 4' AND hanzi = '转机';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhuàn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '赚';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zhuāng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '装';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhǔn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '准';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhǔnquè'
  WHERE hsk_level = 'HSK 4' AND hanzi = '准确';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zhǔnshí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '准时';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zīliào'
  WHERE hsk_level = 'HSK 4' AND hanzi = '资料';
  UPDATE public.vocabularies
  SET 
    word_type = 'Tính từ',
    pinyin = 'zǐxì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '仔细';
  UPDATE public.vocabularies
  SET 
    word_type = 'Giới từ',
    pinyin = 'zì'
  WHERE hsk_level = 'HSK 4' AND hanzi = '自';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Tính từ / Phó từ',
    pinyin = 'zìrán'
  WHERE hsk_level = 'HSK 4' AND hanzi = '自然';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zìxí'
  WHERE hsk_level = 'HSK 4' AND hanzi = '自习';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ / Tính từ',
    pinyin = 'zìxìn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '自信';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zìxué'
  WHERE hsk_level = 'HSK 4' AND hanzi = '自学';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'zǒngjié'
  WHERE hsk_level = 'HSK 4' AND hanzi = '总结';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zū'
  WHERE hsk_level = 'HSK 4' AND hanzi = '租';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zǔ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '组';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zuìzhōng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '最终';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Tính từ',
    pinyin = 'zūnzhòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '尊重';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zuǒyòu'
  WHERE hsk_level = 'HSK 4' AND hanzi = '左右';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ / Lượng từ',
    pinyin = 'zuò'
  WHERE hsk_level = 'HSK 4' AND hanzi = '座';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zuòfǎ'
  WHERE hsk_level = 'HSK 4' AND hanzi = '做法';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zuòjiā'
  WHERE hsk_level = 'HSK 4' AND hanzi = '作家';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ',
    pinyin = 'zuòmèng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '做梦';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zuòpǐn'
  WHERE hsk_level = 'HSK 4' AND hanzi = '作品';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Giới từ',
    pinyin = 'zuòwéi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '作为';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zuòwèi'
  WHERE hsk_level = 'HSK 4' AND hanzi = '座位';
  UPDATE public.vocabularies
  SET 
    word_type = 'Động từ / Danh từ',
    pinyin = 'zuòwén'
  WHERE hsk_level = 'HSK 4' AND hanzi = '作文';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zuòyòng'
  WHERE hsk_level = 'HSK 4' AND hanzi = '作用';
  UPDATE public.vocabularies
  SET 
    word_type = 'Danh từ',
    pinyin = 'zuòzhě'
  WHERE hsk_level = 'HSK 4' AND hanzi = '作者';

  GET DIAGNOSTICS v_norm_count = ROW_COUNT;
  RAISE NOTICE 'Hoàn tất Bước 1: Đã dọn dẹp và chuẩn hóa thành công toàn bộ từ vựng HSK 4 hiện có!';
END $$;
