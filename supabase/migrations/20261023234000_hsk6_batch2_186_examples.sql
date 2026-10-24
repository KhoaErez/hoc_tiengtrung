-- ==============================================================================;
-- MIGRATION: 20261023234000_hsk6_batch2_186_examples.sql;
-- Nạp 186 câu ví dụ HSK 6 Đợt 2 (F - J: 发行 -> 金融) vào vocabularies và vocabulary_examples;
-- Chuẩn đề cương HSK 3.0 (CTI 11/2025), câu ví dụ văn cảnh hiện đại, Pinyin có dấu, dịch chuẩn nghĩa;
-- ==============================================================================;

BEGIN;

-- [发行] (fāxíng): phát hành
UPDATE public.vocabularies
SET example_hanzi = '中央银行为了纪念重要历史事件，正式面向公众发行了一套纪念金币。',
    example_pinyin = 'Zhōngyāng yínháng wèile jīniàn zhòngyào lìshǐ shìjiàn, zhèngshì miànxiàng gōngzhòng fāxíng le yí tào jìniàn jīnbì.',
    example_vi = 'Ngân hàng trung ương nhằm kỷ niệm sự kiện lịch sử trọng đại đã chính thức phát hành một bộ tiền xu vàng kỷ niệm tới công chúng.'
WHERE id = '72ff141e-00c4-4402-9b75-03828a279749' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '72ff141e-00c4-4402-9b75-03828a279749', '中央银行为了纪念重要历史事件，正式面向公众发行了一套纪念金币。', 'Zhōngyāng yínháng wèile jīniàn zhòngyào lìshǐ shìjiàn, zhèngshì miànxiàng gōngzhòng fāxíng le yí tào jìniàn jīnbì.', 'Ngân hàng trung ương nhằm kỷ niệm sự kiện lịch sử trọng đại đã chính thức phát hành một bộ tiền xu vàng kỷ niệm tới công chúng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '72ff141e-00c4-4402-9b75-03828a279749'
);

-- [发炎] (fāyán): viêm, phát viêm
UPDATE public.vocabularies
SET example_hanzi = '扁桃体发炎引起的咽喉红肿疼痛，需要多喝温开水并遵医嘱按时服药。',
    example_pinyin = 'Biǎntáotǐ fāyán yǐnqǐ de yānhóu hóngzhǒng téngtòng, xūyào duō hē wēn kāishuǐ bìng zūn yīzhǔ ànshí fúyào.',
    example_vi = 'Cổ họng sưng đỏ đau nhức do viêm amidan gây ra cần uống nhiều nước ấm và uống thuốc đúng giờ theo chỉ định bác sĩ.'
WHERE id = '0d1190ad-3b08-46c8-9bfa-6d170ee5dcc2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0d1190ad-3b08-46c8-9bfa-6d170ee5dcc2', '扁桃体发炎引起的咽喉红肿疼痛，需要多喝温开水并遵医嘱按时服药。', 'Biǎntáotǐ fāyán yǐnqǐ de yānhóu hóngzhǒng téngtòng, xūyào duō hē wēn kāishuǐ bìng zūn yīzhǔ ànshí fúyào.', 'Cổ họng sưng đỏ đau nhức do viêm amidan gây ra cần uống nhiều nước ấm và uống thuốc đúng giờ theo chỉ định bác sĩ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0d1190ad-3b08-46c8-9bfa-6d170ee5dcc2'
);

-- [发育] (fāyù): phát triển, dậy thì
UPDATE public.vocabularies
SET example_hanzi = '青少年时期是身体骨骼发育的黄金阶段，充足的睡眠和均衡营养尤为关键。',
    example_pinyin = 'Qīng-shàonián shíqī shì shēntǐ gǔgé fāyù de huángjīn jiēduàn, chōngzú de shuìmián hé jūnhéng yíngyǎng yóuwéi guānjiàn.',
    example_vi = 'Thời kỳ thanh thiếu niên là giai đoạn vàng phát triển xương cốt của cơ thể, giấc ngủ đầy đủ và dinh dưỡng cân bằng đặc biệt then chốt.'
WHERE id = 'decbf141-c338-43d6-94ec-6f90a8601308' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'decbf141-c338-43d6-94ec-6f90a8601308', '青少年时期是身体骨骼发育的黄金阶段，充足的睡眠和均衡营养尤为关键。', 'Qīng-shàonián shíqī shì shēntǐ gǔgé fāyù de huángjīn jiēduàn, chōngzú de shuìmián hé jūnhéng yíngyǎng yóuwéi guānjiàn.', 'Thời kỳ thanh thiếu niên là giai đoạn vàng phát triển xương cốt của cơ thể, giấc ngủ đầy đủ và dinh dưỡng cân bằng đặc biệt then chốt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'decbf141-c338-43d6-94ec-6f90a8601308'
);

-- [肺] (fèi): phổi
UPDATE public.vocabularies
SET example_hanzi = '长期吸烟会对人体的气管和肺部造成不可逆转的严重器质性损害。',
    example_pinyin = 'Chángqī xīyān huì duì réntǐ de qìguǎn hé fèibù zàochéng bùkě-nìzhuǎn de yánzhòng qìzhìxìng sǔnhài.',
    example_vi = 'Hút thuốc lá lâu năm sẽ gây ra những tổn hại thực thể nghiêm trọng không thể đảo ngược đối với khí quản và phổi của con người.'
WHERE id = 'af4c09d5-bdf1-4e8b-9c47-b0a812fa9fe3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'af4c09d5-bdf1-4e8b-9c47-b0a812fa9fe3', '长期吸烟会对人体的气管和肺部造成不可逆转的严重器质性损害。', 'Chángqī xīyān huì duì réntǐ de qìguǎn hé fèibù zàochéng bùkě-nìzhuǎn de yánzhòng qìzhìxìng sǔnhài.', 'Hút thuốc lá lâu năm sẽ gây ra những tổn hại thực thể nghiêm trọng không thể đảo ngược đối với khí quản và phổi của con người.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'af4c09d5-bdf1-4e8b-9c47-b0a812fa9fe3'
);

-- [肥沃] (féi wò): màu mỡ, phì nhiêu
UPDATE public.vocabularies
SET example_hanzi = '长江中下游平原土地肥沃、水网密布，素有中国传统鱼米之乡的美誉。',
    example_pinyin = 'Chángjiāng zhōng-xiàyóu píngyuán tǔdì féiwò, shuǐwǎng mìbù, sù yǒu Zhōngguó chuántǒng yúmǐ zhī xiāng de měiyù.',
    example_vi = 'Đồng bằng trung hạ lưu sông Trường Giang đất đai màu mỡ, mạng lưới sông ngòi dày đặc, từ xưa đã nức tiếng là vựa lúa miền quê trù phú của Trung Quốc.'
WHERE id = 'fe679ddf-ef47-47bb-a4f1-d49cee187e4e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fe679ddf-ef47-47bb-a4f1-d49cee187e4e', '长江中下游平原土地肥沃、水网密布，素有中国传统鱼米之乡的美誉。', 'Chángjiāng zhōng-xiàyóu píngyuán tǔdì féiwò, shuǐwǎng mìbù, sù yǒu Zhōngguó chuántǒng yúmǐ zhī xiāng de měiyù.', 'Đồng bằng trung hạ lưu sông Trường Giang đất đai màu mỡ, mạng lưới sông ngòi dày đặc, từ xưa đã nức tiếng là vựa lúa miền quê trù phú của Trung Quốc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fe679ddf-ef47-47bb-a4f1-d49cee187e4e'
);

-- [丰收] (fēng shōu): bội thu, được mùa
UPDATE public.vocabularies
SET example_hanzi = '金秋十月稻谷飘香，金黄的麦浪翻滚，广袤的田野上迎来了丰收的喜悦。',
    example_pinyin = 'Jīnqiū shí yuè dàogǔ piāoxiāng, jīnhuáng de màilàng fāngǔn, guǎngmào de tiányě shang yínglái le fēngshōu de xǐyuè.',
    example_vi = 'Tháng mười mùa thu vàng hương lúa thơm ngát, sóng lúa mì vàng óng dập dờn, đồng ruộng bát ngát đón niềm vui bội thu.'
WHERE id = 'f073f26a-066f-41fb-b85a-36673e4b9d40' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f073f26a-066f-41fb-b85a-36673e4b9d40', '金秋十月稻谷飘香，金黄的麦浪翻滚，广袤的田野上迎来了丰收的喜悦。', 'Jīnqiū shí yuè dàogǔ piāoxiāng, jīnhuáng de màilàng fāngǔn, guǎngmào de tiányě shang yínglái le fēngshōu de xǐyuè.', 'Tháng mười mùa thu vàng hương lúa thơm ngát, sóng lúa mì vàng óng dập dờn, đồng ruộng bát ngát đón niềm vui bội thu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f073f26a-066f-41fb-b85a-36673e4b9d40'
);

-- [封闭] (fēngbì): khép kín, đóng kín
UPDATE public.vocabularies
SET example_hanzi = '为了防止大雪冰冻引发交通事故，交警部门对山区高速公路实行了临时封闭。',
    example_pinyin = 'Wèile fángzhǐ dàxuě bīngdòng yǐnfā jiāotōng shìgù, jiāojǐng bùmén duì shānqū gāosù gōnglù shíxíng le línshí fēngbì.',
    example_vi = 'Nhằm ngăn ngừa tai nạn giao thông do tuyết rơi đóng băng, lực lượng cảnh sát giao thông đã tạm thời phong tỏa khép kín đường cao tốc vùng núi.'
WHERE id = '9a6092e4-244b-4681-a100-bd3bfafc7bc2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9a6092e4-244b-4681-a100-bd3bfafc7bc2', '为了防止大雪冰冻引发交通事故，交警部门对山区高速公路实行了临时封闭。', 'Wèile fángzhǐ dàxuě bīngdòng yǐnfā jiāotōng shìgù, jiāojǐng bùmén duì shānqū gāosù gōnglù shíxíng le línshí fēngbì.', 'Nhằm ngăn ngừa tai nạn giao thông do tuyết rơi đóng băng, lực lượng cảnh sát giao thông đã tạm thời phong tỏa khép kín đường cao tốc vùng núi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9a6092e4-244b-4681-a100-bd3bfafc7bc2'
);

-- [风光] (fēngguāng): phong cảnh; vẻ vang
UPDATE public.vocabularies
SET example_hanzi = '桂林山水甲天下，乘着竹筏漂流其间，沿途奇峰倒影的风光令人如痴如醉。',
    example_pinyin = 'Guìlín shānshuǐ jiǎ tiānxià, chéng zhe zhúfá piāoliú qíjiān, yántú qífēng dàoyǐng de fēngguāng lìngrén rúchī-rúzuì.',
    example_vi = 'Non nước Quế Lâm đẹp nhất trần gian, ngồi bè trúc lững lờ trôi theo dòng nước, phong cảnh bóng núi soi bóng ven đường khiến lòng người say đắm.'
WHERE id = 'e664721f-d3d3-4535-8b12-8a5607b43c39' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e664721f-d3d3-4535-8b12-8a5607b43c39', '桂林山水甲天下，乘着竹筏漂流其间，沿途奇峰倒影的风光令人如痴如醉。', 'Guìlín shānshuǐ jiǎ tiānxià, chéng zhe zhúfá piāoliú qíjiān, yántú qífēng dàoyǐng de fēngguāng lìngrén rúchī-rúzuì.', 'Non nước Quế Lâm đẹp nhất trần gian, ngồi bè trúc lững lờ trôi theo dòng nước, phong cảnh bóng núi soi bóng ven đường khiến lòng người say đắm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e664721f-d3d3-4535-8b12-8a5607b43c39'
);

-- [奉献] (fèngxiàn): cống hiến, dâng hiến
UPDATE public.vocabularies
SET example_hanzi = '许多乡村支教教师扎根偏远山区数十年，为乡村教育事业默默奉献了青春。',
    example_pinyin = 'Xǔduō xiāngcūn zhījiào jiàoshī zhāgēn piānyuǎn shānqū shùshí nián, wèi xiāngcūn jiàoyù shìyè mòmò fèngxiàn le qīngchūn.',
    example_vi = 'Nhiều giáo viên tình nguyện cắm bản vùng núi hẻo lánh hàng chục năm, âm thầm cống hiến tuổi thanh xuân cho sự nghiệp giáo dục nông thôn.'
WHERE id = '8d4c8f02-7b8b-4e09-9a5e-e5ce7137bf67' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8d4c8f02-7b8b-4e09-9a5e-e5ce7137bf67', '许多乡村支教教师扎根偏远山区数十年，为乡村教育事业默默奉献了青春。', 'Xǔduō xiāngcūn zhījiào jiàoshī zhāgēn piānyuǎn shānqū shùshí nián, wèi xiāngcūn jiàoyù shìyè mòmò fèngxiàn le qīngchūn.', 'Nhiều giáo viên tình nguyện cắm bản vùng núi hẻo lánh hàng chục năm, âm thầm cống hiến tuổi thanh xuân cho sự nghiệp giáo dục nông thôn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8d4c8f02-7b8b-4e09-9a5e-e5ce7137bf67'
);

-- [愤怒] (fènnù): phẫn nộ, tức giận
UPDATE public.vocabularies
SET example_hanzi = '面对不良商家以次充好、欺诈消费者的恶劣行径，在场顾客都感到十分愤怒。',
    example_pinyin = 'Miànduì bùliáng shāngjiā yǐcì-chōnghǎo, qīzhà xiāofèizhě de èliè xíngjìng, zàichǎng gùkè dōu gǎndào shífēn fènnù.',
    example_vi = 'Trước hành vi xấu xí gian lận hàng giả gạt khách hàng của gian thương, tất cả khách hàng có mặt đều cảm thấy vô cùng phẫn nộ tức giận.'
WHERE id = '6ce99c1b-3008-4ee1-806f-e63e55616348' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6ce99c1b-3008-4ee1-806f-e63e55616348', '面对不良商家以次充好、欺诈消费者的恶劣行径，在场顾客都感到十分愤怒。', 'Miànduì bùliáng shāngjiā yǐcì-chōnghǎo, qīzhà xiāofèizhě de èliè xíngjìng, zàichǎng gùkè dōu gǎndào shífēn fènnù.', 'Trước hành vi xấu xí gian lận hàng giả gạt khách hàng của gian thương, tất cả khách hàng có mặt đều cảm thấy vô cùng phẫn nộ tức giận.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6ce99c1b-3008-4ee1-806f-e63e55616348'
);

-- [分散] (fēnsàn): phân tán
UPDATE public.vocabularies
SET example_hanzi = '自习课上同学们应当保持高度专注，不要随意闲聊以免分散学习注意力。',
    example_pinyin = 'Zìxíkè shang tóngxué men yīngdāng bǎochí gāodù zhuānzhù, bú yào suíyì xiánliáo yǐmiǎn fēnsàn xuéxí zhùyìlì.',
    example_vi = 'Trong giờ tự học các bạn học sinh nên duy trì sự tập trung cao độ, không nên tùy tiện trò chuyện rôm rả để tránh làm phân tán sự chú ý học tập.'
WHERE id = 'a0b32773-b77e-443e-972d-53c0dfafe381' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a0b32773-b77e-443e-972d-53c0dfafe381', '自习课上同学们应当保持高度专注，不要随意闲聊以免分散学习注意力。', 'Zìxíkè shang tóngxué men yīngdāng bǎochí gāodù zhuānzhù, bú yào suíyì xiánliáo yǐmiǎn fēnsàn xuéxí zhùyìlì.', 'Trong giờ tự học các bạn học sinh nên duy trì sự tập trung cao độ, không nên tùy tiện trò chuyện rôm rả để tránh làm phân tán sự chú ý học tập.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a0b32773-b77e-443e-972d-53c0dfafe381'
);

-- [幅度] (fú dù): biên độ, mức độ
UPDATE public.vocabularies
SET example_hanzi = '受国际原油市场供应收紧影响，本月国内成品油零售价格上涨幅度较为明显。',
    example_pinyin = 'Shòu guójì yuányóu shìchǎng gōngyìng shōujǐn yǐngxiǎng, běn yuè guónèi chéngpǐnyóu língshòu jiàgé shàngzhǎng fúdù jiàowéi míngxiǎn.',
    example_vi = 'Chịu tác động bởi sự thu hẹp nguồn cung thị trường dầu thô quốc tế, mức độ tăng giá bán lẻ xăng dầu thành phẩm trong nước tháng này tương đối rõ rệt.'
WHERE id = 'a2a52335-b9d5-445b-932d-9377ea3eb309' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a2a52335-b9d5-445b-932d-9377ea3eb309', '受国际原油市场供应收紧影响，本月国内成品油零售价格上涨幅度较为明显。', 'Shòu guójì yuányóu shìchǎng gōngyìng shōujǐn yǐngxiǎng, běn yuè guónèi chéngpǐnyóu língshòu jiàgé shàngzhǎng fúdù jiàowéi míngxiǎn.', 'Chịu tác động bởi sự thu hẹp nguồn cung thị trường dầu thô quốc tế, mức độ tăng giá bán lẻ xăng dầu thành phẩm trong nước tháng này tương đối rõ rệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a2a52335-b9d5-445b-932d-9377ea3eb309'
);

-- [服从] (fúcóng): phục tùng, tuân theo
UPDATE public.vocabularies
SET example_hanzi = '在执行抢险救灾等紧急任务时，全体救援官兵必须坚决服从指挥命令。',
    example_pinyin = 'Zài zhíxíng qiǎngxiǎn jiùzāi děng jǐnjí rènwù shí, quántǐ jiùyuán guānbīng bìxū jiānjué fúcóng zhǐhuī mìnglìng.',
    example_vi = 'Khi thực hiện nhiệm vụ khẩn cấp phòng chống thiên tai cứu nạn, toàn thể cán bộ chiến sĩ cứu hộ phải kiên quyết phục tùng mệnh lệnh chỉ huy.'
WHERE id = 'dfc4dbe3-8a2d-4699-afcb-6379f371d05d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dfc4dbe3-8a2d-4699-afcb-6379f371d05d', '在执行抢险救灾等紧急任务时，全体救援官兵必须坚决服从指挥命令。', 'Zài zhíxíng qiǎngxiǎn jiùzāi děng jǐnjí rènwù shí, quántǐ jiùyuán guānbīng bìxū jiānjué fúcóng zhǐhuī mìnglìng.', 'Khi thực hiện nhiệm vụ khẩn cấp phòng chống thiên tai cứu nạn, toàn thể cán bộ chiến sĩ cứu hộ phải kiên quyết phục tùng mệnh lệnh chỉ huy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dfc4dbe3-8a2d-4699-afcb-6379f371d05d'
);

-- [辅导] (fǔdǎo): phụ đạo, hướng dẫn
UPDATE public.vocabularies
SET example_hanzi = '放学后班主任老师耐心留在教室里，为几位数学基础偏弱的同学辅导功课。',
    example_pinyin = 'Fàngxué hòu bānzhǔrèn lǎoshī nàixīn liú zài jiàoshì lǐ, wèi jǐ wèi shùxué jīchǔ piān ruò de tóngxué fǔdǎo gōngkè.',
    example_vi = 'Sau giờ tan học thầy giáo chủ nhiệm kiên nhẫn nán lại phòng học để phụ đạo bài vở cho mấy bạn học sinh có nền tảng toán học còn yếu.'
WHERE id = '339f2b85-e859-4e57-9013-b2b843753fdd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '339f2b85-e859-4e57-9013-b2b843753fdd', '放学后班主任老师耐心留在教室里，为几位数学基础偏弱的同学辅导功课。', 'Fàngxué hòu bānzhǔrèn lǎoshī nàixīn liú zài jiàoshì lǐ, wèi jǐ wèi shùxué jīchǔ piān ruò de tóngxué fǔdǎo gōngkè.', 'Sau giờ tan học thầy giáo chủ nhiệm kiên nhẫn nán lại phòng học để phụ đạo bài vở cho mấy bạn học sinh có nền tảng toán học còn yếu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '339f2b85-e859-4e57-9013-b2b843753fdd'
);

-- [覆盖] (fùgài): bao phủ, che phủ
UPDATE public.vocabularies
SET example_hanzi = '一场大雪过后，连绵起伏的群山和辽阔原野都被厚厚的白雪全面覆盖。',
    example_pinyin = 'Yì chǎng dàxuě guòhòu, liánmián-qǐfú de qúnshān hé liáokuò yuányě dōu bèi hòuhòu de báixuě quánmiàn fùgài.',
    example_vi = 'Sau một trận tuyết lớn, những rặng núi trùng điệp và cánh đồng bao la đều bị lớp tuyết trắng dày bao phủ hoàn toàn.'
WHERE id = '868d9b50-9645-4a3e-8756-19aff0883598' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '868d9b50-9645-4a3e-8756-19aff0883598', '一场大雪过后，连绵起伏的群山和辽阔原野都被厚厚的白雪全面覆盖。', 'Yì chǎng dàxuě guòhòu, liánmián-qǐfú de qúnshān hé liáokuò yuányě dōu bèi hòuhòu de báixuě quánmiàn fùgài.', 'Sau một trận tuyết lớn, những rặng núi trùng điệp và cánh đồng bao la đều bị lớp tuyết trắng dày bao phủ hoàn toàn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '868d9b50-9645-4a3e-8756-19aff0883598'
);

-- [符号] (fúhào): ký hiệu
UPDATE public.vocabularies
SET example_hanzi = '这篇古老的文献泥板上雕刻着许多神秘符号，目前语言学者正在努力破译。',
    example_pinyin = 'Zhè piān gǔlǎo de wénxiàn níbǎn shang diāokè zhe xǔduō shénmì fúhào, mùqián yǔyán xuézhě zhèngzài nǔlì pòyì.',
    example_vi = 'Trên phiến đất sét cổ xưa này khắc nhiều ký hiệu thần bí, hiện các nhà nghiên cứu ngôn ngữ đang nỗ lực giải mã.'
WHERE id = 'a4354234-daef-46d9-8227-a0e949230ab6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a4354234-daef-46d9-8227-a0e949230ab6', '这篇古老的文献泥板上雕刻着许多神秘符号，目前语言学者正在努力破译。', 'Zhè piān gǔlǎo de wénxiàn níbǎn shang diāokè zhe xǔduō shénmì fúhào, mùqián yǔyán xuézhě zhèngzài nǔlì pòyì.', 'Trên phiến đất sét cổ xưa này khắc nhiều ký hiệu thần bí, hiện các nhà nghiên cứu ngôn ngữ đang nỗ lực giải mã.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a4354234-daef-46d9-8227-a0e949230ab6'
);

-- [附件] (fùjiàn): tệp đính kèm, phụ kiện
UPDATE public.vocabularies
SET example_hanzi = '详细的调研数据分析报告已经存为电子文档，请大家查阅本封邮件的附件。',
    example_pinyin = 'Xiángxì de diàoyán shùjù fēnxī bàogào yǐjīng cún wèi diànzǐ wéndàng, qǐng dàjiā cháyuè běn fēng yóujiàn de fùjiàn.',
    example_vi = 'Báo cáo phân tích dữ liệu điều tra chi tiết đã được lưu dưới dạng văn bản điện tử, xin mọi người xem tệp đính kèm của bức thư này.'
WHERE id = '2cc0bc53-62b3-41d3-ba31-367427021a1e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2cc0bc53-62b3-41d3-ba31-367427021a1e', '详细的调研数据分析报告已经存为电子文档，请大家查阅本封邮件的附件。', 'Xiángxì de diàoyán shùjù fēnxī bàogào yǐjīng cún wèi diànzǐ wéndàng, qǐng dàjiā cháyuè běn fēng yóujiàn de fùjiàn.', 'Báo cáo phân tích dữ liệu điều tra chi tiết đã được lưu dưới dạng văn bản điện tử, xin mọi người xem tệp đính kèm của bức thư này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2cc0bc53-62b3-41d3-ba31-367427021a1e'
);

-- [福利] (fúlì): phúc lợi
UPDATE public.vocabularies
SET example_hanzi = '为了吸引优秀的技术骨干，高新科技园区为入驻员工提供了完善的福利保障。',
    example_pinyin = 'Wèile xīyǐn yōuxiù de jìshù gǔgàn, gāoxīn kējì yuánqū wèi rùzhù yuángōng tígōng le wánshàn de fúlì bǎozhàng.',
    example_vi = 'Nhằm thu hút lực lượng nòng cốt kỹ thuật xuất sắc, khu công nghệ cao đã cung cấp chế độ phúc lợi hoàn thiện cho nhân viên vào làm việc.'
WHERE id = 'd3854911-1fc2-44fa-850e-92cfa8b104af' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd3854911-1fc2-44fa-850e-92cfa8b104af', '为了吸引优秀的技术骨干，高新科技园区为入驻员工提供了完善的福利保障。', 'Wèile xīyǐn yōuxiù de jìshù gǔgàn, gāoxīn kējì yuánqū wèi rùzhù yuángōng tígōng le wánshàn de fúlì bǎozhàng.', 'Nhằm thu hút lực lượng nòng cốt kỹ thuật xuất sắc, khu công nghệ cao đã cung cấp chế độ phúc lợi hoàn thiện cho nhân viên vào làm việc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd3854911-1fc2-44fa-850e-92cfa8b104af'
);

-- [夫人] (fūrén): phu nhân, bà
UPDATE public.vocabularies
SET example_hanzi = '大使先生携夫人共同出席了本次国际和平慈善晚宴，并向主办方表达感谢。',
    example_pinyin = 'Dàshǐ xiānsheng xié fūrén gòngtóng chūxí le běncì guójì hépíng císhàn wǎnyàn, bìng xiàng zhǔbànfāng biǎodá gǎnxiè.',
    example_vi = 'Ngài đại sứ cùng phu nhân đã cùng tham dự tiệc từ thiện hòa bình quốc tế lần này và gửi lời cảm ơn tới ban tổ chức.'
WHERE id = 'ae99ebbc-543d-4dfa-9df8-f764f0fff2e4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ae99ebbc-543d-4dfa-9df8-f764f0fff2e4', '大使先生携夫人共同出席了本次国际和平慈善晚宴，并向主办方表达感谢。', 'Dàshǐ xiānsheng xié fūrén gòngtóng chūxí le běncì guójì hépíng císhàn wǎnyàn, bìng xiàng zhǔbànfāng biǎodá gǎnxiè.', 'Ngài đại sứ cùng phu nhân đã cùng tham dự tiệc từ thiện hòa bình quốc tế lần này và gửi lời cảm ơn tới ban tổ chức.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ae99ebbc-543d-4dfa-9df8-f764f0fff2e4'
);

-- [富裕] (fùyù): giàu có, dư dả
UPDATE public.vocabularies
SET example_hanzi = '通过发展特色乡村生态农业和观光旅游，昔日贫困的小山村过上了富裕生活。',
    example_pinyin = 'Tōngguò fāzhǎn tèsè xiāngcūn shēngtài nóngyè hé guānguāng lǚyóu, xīrì pínkùn de xiǎoshāncūn guò shang le fùyù shēnghuó.',
    example_vi = 'Nhờ phát triển nông nghiệp sinh thái đặc sản và du lịch tham quan, ngôi làng miền núi nghèo năm xưa nay đã sống cuộc đời giàu có sung túc.'
WHERE id = 'c2635314-836b-45d9-8d65-e276d9c16976' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c2635314-836b-45d9-8d65-e276d9c16976', '通过发展特色乡村生态农业和观光旅游，昔日贫困的小山村过上了富裕生活。', 'Tōngguò fāzhǎn tèsè xiāngcūn shēngtài nóngyè hé guānguāng lǚyóu, xīrì pínkùn de xiǎoshāncūn guò shang le fùyù shēnghuó.', 'Nhờ phát triển nông nghiệp sinh thái đặc sản và du lịch tham quan, ngôi làng miền núi nghèo năm xưa nay đã sống cuộc đời giàu có sung túc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c2635314-836b-45d9-8d65-e276d9c16976'
);

-- [赋予] (fùyǔ): trao cho, ban cho
UPDATE public.vocabularies
SET example_hanzi = '宪法和国家法律赋予了每一位合法公民平等享有接受良好教育的神圣权利。',
    example_pinyin = 'Xiànfǎ hé guójiā fǎlǜ fùyǔ le měi yí wèi héfǎ gōngmín píngděng xiǎngyǒu jiēshòu liánghǎo jiàoyù de shénshèng quánlì.',
    example_vi = 'Hiến pháp và luật pháp quốc gia trao cho mỗi một công dân hợp pháp quyền bình đẳng thiêng liêng được tiếp nhận nền giáo dục tốt đẹp.'
WHERE id = 'f3308de4-6383-4cde-8f98-f6cc0b3d13aa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f3308de4-6383-4cde-8f98-f6cc0b3d13aa', '宪法和国家法律赋予了每一位合法公民平等享有接受良好教育的神圣权利。', 'Xiànfǎ hé guójiā fǎlǜ fùyǔ le měi yí wèi héfǎ gōngmín píngděng xiǎngyǒu jiēshòu liánghǎo jiàoyù de shénshèng quánlì.', 'Hiến pháp và luật pháp quốc gia trao cho mỗi một công dân hợp pháp quyền bình đẳng thiêng liêng được tiếp nhận nền giáo dục tốt đẹp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f3308de4-6383-4cde-8f98-f6cc0b3d13aa'
);

-- [辅助] (fǔzhù): phụ trợ, bổ trợ
UPDATE public.vocabularies
SET example_hanzi = '这款现代人工智能辅助教学软件，能够帮助教师更加精准地分析学生学习薄弱点。',
    example_pinyin = 'Zhè kuǎn xiàndài réngōng zhìnéng fǔzhù jiàoxué ruǎnjiàn, nénggòu bāngzhù jiàoshī gèngjiā jīngzhǔn de fēnxī xuésheng xuéxí bóruòdiǎn.',
    example_vi = 'Phần mềm dạy học phụ trợ bằng trí tuệ nhân tạo hiện đại này có thể giúp giáo viên phân tích chính xác hơn điểm yếu học tập của học sinh.'
WHERE id = 'c9df0cd5-3bb3-42fe-affe-cfb399372e5c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c9df0cd5-3bb3-42fe-affe-cfb399372e5c', '这款现代人工智能辅助教学软件，能够帮助教师更加精准地分析学生学习薄弱点。', 'Zhè kuǎn xiàndài réngōng zhìnéng fǔzhù jiàoxué ruǎnjiàn, nénggòu bāngzhù jiàoshī gèngjiā jīngzhǔn de fēnxī xuésheng xuéxí bóruòdiǎn.', 'Phần mềm dạy học phụ trợ bằng trí tuệ nhân tạo hiện đại này có thể giúp giáo viên phân tích chính xác hơn điểm yếu học tập của học sinh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c9df0cd5-3bb3-42fe-affe-cfb399372e5c'
);

-- [尴尬] (gān gà): lúng túng, ngượng ngùng
UPDATE public.vocabularies
SET example_hanzi = '他在正式演讲时突然忘词停顿了半分钟，站在讲台上感到十分难堪和尴尬。',
    example_pinyin = 'Tā zài zhèngshì yǎnjiǎng shí tūrán wàngcí tíngdùn le bàn fēnzhōng, zhàn zài jiǎngtái shang gǎndào shífēn nánkān hé gāngà.',
    example_vi = 'Anh ấy khi diễn thuyết chính thức đột nhiên quên lời đứng hình suốt nửa phút, đứng trên bục giảng cảm thấy vô cùng khó xử và lúng túng ngượng ngùng.'
WHERE id = 'f0dea705-7e9e-4465-89a0-f5fc68737349' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f0dea705-7e9e-4465-89a0-f5fc68737349', '他在正式演讲时突然忘词停顿了半分钟，站在讲台上感到十分难堪和尴尬。', 'Tā zài zhèngshì yǎnjiǎng shí tūrán wàngcí tíngdùn le bàn fēnzhōng, zhàn zài jiǎngtái shang gǎndào shífēn nánkān hé gāngà.', 'Anh ấy khi diễn thuyết chính thức đột nhiên quên lời đứng hình suốt nửa phút, đứng trên bục giảng cảm thấy vô cùng khó xử và lúng túng ngượng ngùng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f0dea705-7e9e-4465-89a0-f5fc68737349'
);

-- [干旱] (gān hàn): hạn hán, khô hạn
UPDATE public.vocabularies
SET example_hanzi = '连续数月没有有效降雨导致农田出现严重干旱，水利部门紧急开闸调水灌溉。',
    example_pinyin = 'Liánxù shù yuè méiyǒu yǒuxiào jiàngyǔ dǎozhì nóngtián chūxiàn yánzhòng gānhàn, shuǐlì bùmén jǐnjí kāizhá diàoshuǐ guàngài.',
    example_vi = 'Nhiều tháng liền không có lượng mưa hiệu quả khiến ruộng đồng bị hạn hán nghiêm trọng, ngành thủy lợi đã khẩn cấp mở cống xả nước tưới tiêu.'
WHERE id = '12f95792-aae8-4f13-ab9f-809d3a627ec5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '12f95792-aae8-4f13-ab9f-809d3a627ec5', '连续数月没有有效降雨导致农田出现严重干旱，水利部门紧急开闸调水灌溉。', 'Liánxù shù yuè méiyǒu yǒuxiào jiàngyǔ dǎozhì nóngtián chūxiàn yánzhòng gānhàn, shuǐlì bùmén jǐnjí kāizhá diàoshuǐ guàngài.', 'Nhiều tháng liền không có lượng mưa hiệu quả khiến ruộng đồng bị hạn hán nghiêm trọng, ngành thủy lợi đã khẩn cấp mở cống xả nước tưới tiêu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '12f95792-aae8-4f13-ab9f-809d3a627ec5'
);

-- [干扰] (gān rǎo): can nhiễu, làm phiền
UPDATE public.vocabularies
SET example_hanzi = '在安静的自习室里请把手机调至静音模式，以免铃声响动干扰他人阅读。',
    example_pinyin = 'Zài ānjìng de zìxíshì lǐ qǐng bǎ shǒujī tiáo zhì jìngyīn móshì, yǐmiǎn língshēng xiǎngdòng gānrǎo tārén yuèdú.',
    example_vi = 'Trong phòng tự học yên tĩnh xin chuyển điện thoại sang chế độ rung/im lặng để tránh chuông reo làm phiền quấy nhiễu người khác đọc sách.'
WHERE id = 'ea1e2a40-6dbf-4659-873f-d8dfa3413d79' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ea1e2a40-6dbf-4659-873f-d8dfa3413d79', '在安静的自习室里请把手机调至静音模式，以免铃声响动干扰他人阅读。', 'Zài ānjìng de zìxíshì lǐ qǐng bǎ shǒujī tiáo zhì jìngyīn móshì, yǐmiǎn língshēng xiǎngdòng gānrǎo tārén yuèdú.', 'Trong phòng tự học yên tĩnh xin chuyển điện thoại sang chế độ rung/im lặng để tránh chuông reo làm phiền quấy nhiễu người khác đọc sách.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ea1e2a40-6dbf-4659-873f-d8dfa3413d79'
);

-- [干脆] (gāncuì): dứt khoát, thẳng thắn
UPDATE public.vocabularies
SET example_hanzi = '与其天天为了无意义的琐事争执不休，倒不如干脆把话说开、化解矛盾。',
    example_pinyin = 'Yǔqí tiāntiān wèile wú yìyì de suǒshì zhēngzhí-bùxiū, dàobùrú gāncuì bǎ huà shuō kāi, huàjiě máodùn.',
    example_vi = 'Thay vì ngày nào cũng tranh cãi không dứt vì những chuyện vụn vặt vô nghĩa, chi bằng dứt khoát nói rõ mọi chuyện để giải tỏa mâu thuẫn.'
WHERE id = '60e3bc6a-c827-41b1-ba5b-a500db5a0b03' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '60e3bc6a-c827-41b1-ba5b-a500db5a0b03', '与其天天为了无意义的琐事争执不休，倒不如干脆把话说开、化解矛盾。', 'Yǔqí tiāntiān wèile wú yìyì de suǒshì zhēngzhí-bùxiū, dàobùrú gāncuì bǎ huà shuō kāi, huàjiě máodùn.', 'Thay vì ngày nào cũng tranh cãi không dứt vì những chuyện vụn vặt vô nghĩa, chi bằng dứt khoát nói rõ mọi chuyện để giải tỏa mâu thuẫn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '60e3bc6a-c827-41b1-ba5b-a500db5a0b03'
);

-- [岗位] (gǎng wèi): cương vị, vị trí công tác
UPDATE public.vocabularies
SET example_hanzi = '青年医务人员坚守在临床急救第一线岗位上，日夜不知疲倦地守护着患者健康。',
    example_pinyin = 'Qīngnián yīwù rényuán jiānshǒu zài línchuáng jíjiù dì-yīxiàn gǎngwèi shang, rìyè bùzhī-píjuàn de shǒuhù zhe huànzhě jiànkāng.',
    example_vi = 'Đội ngũ y bác sĩ trẻ kiên trì bám trụ ở vị trí công tác tuyến đầu cấp cứu lâm sàng, ngày đêm không mệt mỏi bảo vệ sức khỏe người bệnh.'
WHERE id = 'ddf882f9-ab64-41ad-bc02-0f120b6717a4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ddf882f9-ab64-41ad-bc02-0f120b6717a4', '青年医务人员坚守在临床急救第一线岗位上，日夜不知疲倦地守护着患者健康。', 'Qīngnián yīwù rényuán jiānshǒu zài línchuáng jíjiù dì-yīxiàn gǎngwèi shang, rìyè bùzhī-píjuàn de shǒuhù zhe huànzhě jiànkāng.', 'Đội ngũ y bác sĩ trẻ kiên trì bám trụ ở vị trí công tác tuyến đầu cấp cứu lâm sàng, ngày đêm không mệt mỏi bảo vệ sức khỏe người bệnh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ddf882f9-ab64-41ad-bc02-0f120b6717a4'
);

-- [港口] (gǎngkǒu): cảng, bến cảng
UPDATE public.vocabularies
SET example_hanzi = '现代化的大型深水港口里，数十台大型集装箱吊桥正在高速运转装卸货物。',
    example_pinyin = 'Xiàndàihuà de dàxíng shēnshuǐ gǎngkǒu lǐ, shùshí tái dàxíng jízhuāngxiāng diàoqiáo zhèngzài gāosù yùnzhuǎn zhuāngxiè huòwù.',
    example_vi = 'Tại cảng nước sâu quy mô lớn hiện đại, hàng chục cây cầu cẩu container cỡ lớn đang vận hành tốc độ cao bốc dỡ hàng hóa.'
WHERE id = 'f3c6e6e3-e8d1-4b2c-98e5-499a6375e4f9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f3c6e6e3-e8d1-4b2c-98e5-499a6375e4f9', '现代化的大型深水港口里，数十台大型集装箱吊桥正在高速运转装卸货物。', 'Xiàndàihuà de dàxíng shēnshuǐ gǎngkǒu lǐ, shùshí tái dàxíng jízhuāngxiāng diàoqiáo zhèngzài gāosù yùnzhuǎn zhuāngxiè huòwù.', 'Tại cảng nước sâu quy mô lớn hiện đại, hàng chục cây cầu cẩu container cỡ lớn đang vận hành tốc độ cao bốc dỡ hàng hóa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f3c6e6e3-e8d1-4b2c-98e5-499a6375e4f9'
);

-- [感激] (gǎnjī): cảm kích, biết ơn
UPDATE public.vocabularies
SET example_hanzi = '面对邻居们在困难时刻伸出的援助之手，老夫妇眼中含着热泪连声道谢、深表感激。',
    example_pinyin = 'Miànduì línjū men zài kùnnan shíkè shēnchū de yuánzhù zhī shǒu, lǎo fūfù yǎn zhōng hán zhe rèlèi liánshēng dàoxiè, shēn biǎo gǎnjī.',
    example_vi = 'Trước bàn tay giúp đỡ của bà con chòm xóm trong lúc gian nan, hai vợ chồng già mắt ngấn lệ liên tục cảm ơn và bày tỏ lòng cảm kích sâu sắc.'
WHERE id = '7284e098-4836-4e4d-ab76-82b963b1eb21' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7284e098-4836-4e4d-ab76-82b963b1eb21', '面对邻居们在困难时刻伸出的援助之手，老夫妇眼中含着热泪连声道谢、深表感激。', 'Miànduì línjū men zài kùnnan shíkè shēnchū de yuánzhù zhī shǒu, lǎo fūfù yǎn zhōng hán zhe rèlèi liánshēng dàoxiè, shēn biǎo gǎnjī.', 'Trước bàn tay giúp đỡ của bà con chòm xóm trong lúc gian nan, hai vợ chồng già mắt ngấn lệ liên tục cảm ơn và bày tỏ lòng cảm kích sâu sắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7284e098-4836-4e4d-ab76-82b963b1eb21'
);

-- [感染] (gǎnrǎn): lây nhiễm, truyền cảm
UPDATE public.vocabularies
SET example_hanzi = '这位老音乐家演奏的民乐交响曲情真意切，深深感染了在场的每一位听众。',
    example_pinyin = 'Zhè wèi lǎo yīnyuèjiā yǎnzòu de mínyuè jiāoxiǎngqǔ qíngzhēn-yìqiè, shēnshēn gǎnrǎn le zàichǎng de měi yí wèi tīngzhòng.',
    example_vi = 'Bản giao hưởng dân nhạc do nghệ sĩ già biểu diễn dạt dào tình cảm, truyền cảm lay động sâu sắc tới từng thính giả có mặt.'
WHERE id = '56ff3183-3997-4185-90ab-7a7fb0f6ceaa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '56ff3183-3997-4185-90ab-7a7fb0f6ceaa', '这位老音乐家演奏的民乐交响曲情真意切，深深感染了在场的每一位听众。', 'Zhè wèi lǎo yīnyuèjiā yǎnzòu de mínyuè jiāoxiǎngqǔ qíngzhēn-yìqiè, shēnshēn gǎnrǎn le zàichǎng de měi yí wèi tīngzhòng.', 'Bản giao hưởng dân nhạc do nghệ sĩ già biểu diễn dạt dào tình cảm, truyền cảm lay động sâu sắc tới từng thính giả có mặt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '56ff3183-3997-4185-90ab-7a7fb0f6ceaa'
);

-- [感想] (gǎnxiǎng): cảm tưởng
UPDATE public.vocabularies
SET example_hanzi = '参观完科技成果博览会之后，同学们纷纷在班级讨论区写下了自己的真实感想。',
    example_pinyin = 'Cānguān wán kējì chéngguǒ bólǎnhuì zhīhòu, tóngxué men fēnfēn zài bānjí tǎolùnqū xiě xià le zìjǐ de zhēnshí gǎnxiǎng.',
    example_vi = 'Sau khi tham quan triển lãm thành quả khoa học công nghệ, các bạn học sinh đã cùng viết lại cảm tưởng chân thật của mình trong diễn đàn thảo luận của lớp.'
WHERE id = '0e436700-33b2-4a28-92f2-2a247ed7e0ad' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0e436700-33b2-4a28-92f2-2a247ed7e0ad', '参观完科技成果博览会之后，同学们纷纷在班级讨论区写下了自己的真实感想。', 'Cānguān wán kējì chéngguǒ bólǎnhuì zhīhòu, tóngxué men fēnfēn zài bānjí tǎolùnqū xiě xià le zìjǐ de zhēnshí gǎnxiǎng.', 'Sau khi tham quan triển lãm thành quả khoa học công nghệ, các bạn học sinh đã cùng viết lại cảm tưởng chân thật của mình trong diễn đàn thảo luận của lớp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0e436700-33b2-4a28-92f2-2a247ed7e0ad'
);

-- [干燥] (gānzào): khô ráo, hanh khô
UPDATE public.vocabularies
SET example_hanzi = '北方冬季天气寒冷干燥，室内通常需要使用加湿器以增加空气湿度。',
    example_pinyin = 'Běifāng dōngjì tiānqì hánlěng gānzào, shìnèi tōngcháng xūyào shǐyòng jiāshījì yǐ zēngjiā kōngqì shīdù.',
    example_vi = 'Mùa đông miền bắc thời tiết lạnh giá hanh khô, trong phòng thông thường cần sử dụng máy tạo ẩm để tăng độ ẩm không khí.'
WHERE id = 'bc07b398-d127-45b0-9568-87457d44f1cc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bc07b398-d127-45b0-9568-87457d44f1cc', '北方冬季天气寒冷干燥，室内通常需要使用加湿器以增加空气湿度。', 'Běifāng dōngjì tiānqì hánlěng gānzào, shìnèi tōngcháng xūyào shǐyòng jiāshījì yǐ zēngjiā kōngqì shīdù.', 'Mùa đông miền bắc thời tiết lạnh giá hanh khô, trong phòng thông thường cần sử dụng máy tạo ẩm để tăng độ ẩm không khí.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bc07b398-d127-45b0-9568-87457d44f1cc'
);

-- [高超] (gāochāo): cao siêu, siêu phàm
UPDATE public.vocabularies
SET example_hanzi = '老中医凭借高超的针灸推拿医术，为很多多年受颈肩腰腿痛困扰的患者解除了痛苦。',
    example_pinyin = 'Lǎo zhōngyī píngjiè gāochāo de zhēnjiǔ tuīná yīshù, wèi hěn duō duō nián shòu jǐng-jiān-yāo-tuǐ tòng kùnrǎo de huànzhě jiěchú le tòngkǔ.',
    example_vi = 'Vị thầy thuốc Đông y già nhờ y thuật châm cứu xoa bóp cao siêu đã giải trừ đau đớn cho rất nhiều bệnh nhân bị đau cổ vai lưng gối hành hạ nhiều năm.'
WHERE id = '16e53be0-b37b-449e-92aa-ad78be8b1237' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '16e53be0-b37b-449e-92aa-ad78be8b1237', '老中医凭借高超的针灸推拿医术，为很多多年受颈肩腰腿痛困扰的患者解除了痛苦。', 'Lǎo zhōngyī píngjiè gāochāo de zhēnjiǔ tuīná yīshù, wèi hěn duō duō nián shòu jǐng-jiān-yāo-tuǐ tòng kùnrǎo de huànzhě jiěchú le tòngkǔ.', 'Vị thầy thuốc Đông y già nhờ y thuật châm cứu xoa bóp cao siêu đã giải trừ đau đớn cho rất nhiều bệnh nhân bị đau cổ vai lưng gối hành hạ nhiều năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '16e53be0-b37b-449e-92aa-ad78be8b1237'
);

-- [高峰] (gāofēng): đỉnh cao, cao điểm
UPDATE public.vocabularies
SET example_hanzi = '每天清晨七点半至八点半是城市地铁客流高峰期，车站配有志愿者引导乘客排队。',
    example_pinyin = 'Měitiān qīngchén qī diǎn bàn zhì bā diǎn bàn shì chéngshì dìtiě kèliú gāofēngqī, chēzhàn pèi yǒu zhìyuànzhě yǐndǎo chéngkè páiduì.',
    example_vi = 'Mỗi sáng từ 7h30 đến 8h30 là giờ cao điểm lưu lượng hành khách tàu điện ngầm thành phố, nhà ga có tình nguyện viên hướng dẫn hành khách xếp hàng.'
WHERE id = 'bd0a09f1-c326-4556-bf63-98cde8815c4b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bd0a09f1-c326-4556-bf63-98cde8815c4b', '每天清晨七点半至八点半是城市地铁客流高峰期，车站配有志愿者引导乘客排队。', 'Měitiān qīngchén qī diǎn bàn zhì bā diǎn bàn shì chéngshì dìtiě kèliú gāofēngqī, chēzhàn pèi yǒu zhìyuànzhě yǐndǎo chéngkè páiduì.', 'Mỗi sáng từ 7h30 đến 8h30 là giờ cao điểm lưu lượng hành khách tàu điện ngầm thành phố, nhà ga có tình nguyện viên hướng dẫn hành khách xếp hàng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bd0a09f1-c326-4556-bf63-98cde8815c4b'
);

-- [稿件] (gǎojiàn): bản thảo, bài viết
UPDATE public.vocabularies
SET example_hanzi = '学术期刊的审稿专家正在抓紧对全国各大高校寄送的学术研究稿件进行盲审。',
    example_pinyin = 'Xuéshù qīkān de shěngǎo zhuānjiā zhèngzài zhuājǐn duì quánguó gè dà gāoxiào jìsòng de xuéshù yánjiū gǎojiàn jìnxíng mángshěn.',
    example_vi = 'Các chuyên gia bình duyệt của tạp chí học thuật đang khẩn trương tiến hành chấm mù các bản thảo nghiên cứu học thuật do các trường đại học gửi về.'
WHERE id = '59f6c7c2-1049-4aa2-9c8e-80cfea39507e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '59f6c7c2-1049-4aa2-9c8e-80cfea39507e', '学术期刊的审稿专家正在抓紧对全国各大高校寄送的学术研究稿件进行盲审。', 'Xuéshù qīkān de shěngǎo zhuānjiā zhèngzài zhuājǐn duì quánguó gè dà gāoxiào jìsòng de xuéshù yánjiū gǎojiàn jìnxíng mángshěn.', 'Các chuyên gia bình duyệt của tạp chí học thuật đang khẩn trương tiến hành chấm mù các bản thảo nghiên cứu học thuật do các trường đại học gửi về.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '59f6c7c2-1049-4aa2-9c8e-80cfea39507e'
);

-- [高尚] (gāoshàng): cao thượng
UPDATE public.vocabularies
SET example_hanzi = '舍己为人、热心公益的无私精神，是一种值得全社会广泛推崇的高尚道德品格。',
    example_pinyin = 'Shějǐ-wèirén, rèxīn gōngyì de wúsī jīngshén, shì yì zhǒng zhíde quán shèhuì guǎngfàn tuīchóng de gāoshàng dàodé pǐngé.',
    example_vi = 'Tinh thần xả thân vì người khác và nhiệt tình làm việc công ích là một phẩm cách đạo đức cao thượng rất đáng để toàn xã hội tôn vinh.'
WHERE id = '69ef91d6-880e-4282-988c-f2a91496abb5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '69ef91d6-880e-4282-988c-f2a91496abb5', '舍己为人、热心公益的无私精神，是一种值得全社会广泛推崇的高尚道德品格。', 'Shějǐ-wèirén, rèxīn gōngyì de wúsī jīngshén, shì yì zhǒng zhíde quán shèhuì guǎngfàn tuīchóng de gāoshàng dàodé pǐngé.', 'Tinh thần xả thân vì người khác và nhiệt tình làm việc công ích là một phẩm cách đạo đức cao thượng rất đáng để toàn xã hội tôn vinh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '69ef91d6-880e-4282-988c-f2a91496abb5'
);

-- [割] (gē): cắt, cứa
UPDATE public.vocabularies
SET example_hanzi = '秋天清晨露水未干，农夫便拿着锋利的镰刀来到农田里收割金黄成熟的稻谷。',
    example_pinyin = 'Qiūtiān qīngchén lùshuǐ wèi gān, nóngfū biàn ná zhe fēnglì de liándāo lái dào nóngtián lǐ shōugē jīnhuáng chéngshú de dàogǔ.',
    example_vi = 'Buổi sớm mùa thu sương chưa kịp khô, người nông dân đã cầm lưỡi liềm sắc bén ra đồng gặt lúa chín vàng ươm.'
WHERE id = '0c775018-29de-4db9-bdd7-cf8869b13c67' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0c775018-29de-4db9-bdd7-cf8869b13c67', '秋天清晨露水未干，农夫便拿着锋利的镰刀来到农田里收割金黄成熟的稻谷。', 'Qiūtiān qīngchén lùshuǐ wèi gān, nóngfū biàn ná zhe fēnglì de liándāo lái dào nóngtián lǐ shōugē jīnhuáng chéngshú de dàogǔ.', 'Buổi sớm mùa thu sương chưa kịp khô, người nông dân đã cầm lưỡi liềm sắc bén ra đồng gặt lúa chín vàng ươm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0c775018-29de-4db9-bdd7-cf8869b13c67'
);

-- [个体] (gè tǐ): cá thể, cá nhân
UPDATE public.vocabularies
SET example_hanzi = '在现代化庞大复杂的社会系统中，每一个独立个体都是不可或缺的重要组成部分。',
    example_pinyin = 'Zài xiàndàihuà pángdà fùzá de shèhuì xìtǒng zhōng, měi yí gè dúlì gètǐ dōu shì bùkě-huòquē de zhòngyào zǔchéng bùfen.',
    example_vi = 'Trong hệ thống xã hội phức tạp đồ sộ hiện đại, mỗi một cá thể độc lập đều là bộ phận cấu thành quan trọng không thể thiếu.'
WHERE id = '03ea2558-752e-4fd0-b9d3-7ad1ddcd3c60' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '03ea2558-752e-4fd0-b9d3-7ad1ddcd3c60', '在现代化庞大复杂的社会系统中，每一个独立个体都是不可或缺的重要组成部分。', 'Zài xiàndàihuà pángdà fùzá de shèhuì xìtǒng zhōng, měi yí gè dúlì gètǐ dōu shì bùkě-huòquē de zhòngyào zǔchéng bùfen.', 'Trong hệ thống xã hội phức tạp đồ sộ hiện đại, mỗi một cá thể độc lập đều là bộ phận cấu thành quan trọng không thể thiếu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '03ea2558-752e-4fd0-b9d3-7ad1ddcd3c60'
);

-- [革命] (gémìng): cách mạng
UPDATE public.vocabularies
SET example_hanzi = '绿色清洁能源与人工智能技术的深度融合，正在全球制造业掀起一场深刻的产业革命。',
    example_pinyin = 'Lǜsè qīngjié néngyuán yǔ réngōng zhìnéng jìshù de shēndù rónghé, zhèngzài quánqiú zhìzàoyè xiānqǐ yì chǎng shēnkè de chǎnyè gémìng.',
    example_vi = 'Sự kết hợp sâu sắc giữa năng lượng xanh sạch và trí tuệ nhân tạo đang dấy lên một cuộc cách mạng công nghiệp sâu rộng trong ngành sản xuất toàn cầu.'
WHERE id = 'fa71dbac-a7ac-4a43-88e2-2fbaea0c5eff' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fa71dbac-a7ac-4a43-88e2-2fbaea0c5eff', '绿色清洁能源与人工智能技术的深度融合，正在全球制造业掀起一场深刻的产业革命。', 'Lǜsè qīngjié néngyuán yǔ réngōng zhìnéng jìshù de shēndù rónghé, zhèngzài quánqiú zhìzàoyè xiānqǐ yì chǎng shēnkè de chǎnyè gémìng.', 'Sự kết hợp sâu sắc giữa năng lượng xanh sạch và trí tuệ nhân tạo đang dấy lên một cuộc cách mạng công nghiệp sâu rộng trong ngành sản xuất toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fa71dbac-a7ac-4a43-88e2-2fbaea0c5eff'
);

-- [跟前] (gēnqián): trước mặt, bên cạnh
UPDATE public.vocabularies
SET example_hanzi = '调皮的小花猫轻手轻脚地走到奶奶脚跟前，蜷缩在毛毯边安静地打起呼噜来。',
    example_pinyin = 'Tiáopí de xiǎohuāmāo qīngshǒu-qīngjiǎo de zǒu dào nǎinai jiǎogēnqián, quánsuō zài máotǎn biān ānjìng de dǎ qǐ hūlu lái.',
    example_vi = 'Chú mèo hoa tinh nghịch rón rén đi đến trước chân bà nội, cuộn tròn bên mép chăn len rồi yên ắng ngáy khò khò.'
WHERE id = '15fc3509-11d3-4870-b385-465937e4d659' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '15fc3509-11d3-4870-b385-465937e4d659', '调皮的小花猫轻手轻脚地走到奶奶脚跟前，蜷缩在毛毯边安静地打起呼噜来。', 'Tiáopí de xiǎohuāmāo qīngshǒu-qīngjiǎo de zǒu dào nǎinai jiǎogēnqián, quánsuō zài máotǎn biān ānjìng de dǎ qǐ hūlu lái.', 'Chú mèo hoa tinh nghịch rón rén đi đến trước chân bà nội, cuộn tròn bên mép chăn len rồi yên ắng ngáy khò khò.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '15fc3509-11d3-4870-b385-465937e4d659'
);

-- [跟随] (gēnsuí): đi theo, theo sau
UPDATE public.vocabularies
SET example_hanzi = '青年科考队员跟随经验丰富的地质专家，徒步穿越了地形复杂的高原峡谷。',
    example_pinyin = 'Qīngnián kěkǎoduìyuán gēnsuí jīngyàn fēngfù de dìzhì zhuānjiā, túbù chuānyuè le dìxíng fùzá de gāoyuán xiágǔ.',
    example_vi = 'Các thành viên đoàn khảo sát trẻ tuổi đi theo sau chuyên gia địa chất dày dạn kinh nghiệm, đi bộ băng qua hẻm núi cao nguyên địa hình phức tạp.'
WHERE id = 'e44e2c8f-2e1b-4ffe-8a10-e8cc75738544' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e44e2c8f-2e1b-4ffe-8a10-e8cc75738544', '青年科考队员跟随经验丰富的地质专家，徒步穿越了地形复杂的高原峡谷。', 'Qīngnián kěkǎoduìyuán gēnsuí jīngyàn fēngfù de dìzhì zhuānjiā, túbù chuānyuè le dìxíng fùzá de gāoyuán xiágǔ.', 'Các thành viên đoàn khảo sát trẻ tuổi đi theo sau chuyên gia địa chất dày dạn kinh nghiệm, đi bộ băng qua hẻm núi cao nguyên địa hình phức tạp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e44e2c8f-2e1b-4ffe-8a10-e8cc75738544'
);

-- [跟踪] (gēnzōng): theo dõi, bám theo
UPDATE public.vocabularies
SET example_hanzi = '物流信息服务平台通过北斗卫星定位系统，对跨境货运车辆的行进轨迹进行全天候实时跟踪。',
    example_pinyin = 'Wùliú xìnxī fúwù píngtái tōngguò Běidǒu wèixīng dìngwèi xìtǒng, duì kuàjìng huòyùn chēliàng de xíngjìn guǐjì jìnxíng quántiānhòu shíshí gēnzōng.',
    example_vi = 'Nền tảng dịch vụ thông tin hậu cần thông qua hệ thống định vị vệ tinh Bắc Đẩu theo dõi bám sát quỹ đạo di chuyển xe chở hàng xuyên biên giới 24/7 theo thời gian thực.'
WHERE id = '654c85ea-0eee-481c-916b-40b301dc2231' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '654c85ea-0eee-481c-916b-40b301dc2231', '物流信息服务平台通过北斗卫星定位系统，对跨境货运车辆的行进轨迹进行全天候实时跟踪。', 'Wùliú xìnxī fúwù píngtái tōngguò Běidǒu wèixīng dìngwèi xìtǒng, duì kuàjìng huòyùn chēliàng de xíngjìn guǐjì jìnxíng quántiānhòu shíshí gēnzōng.', 'Nền tảng dịch vụ thông tin hậu cần thông qua hệ thống định vị vệ tinh Bắc Đẩu theo dõi bám sát quỹ đạo di chuyển xe chở hàng xuyên biên giới 24/7 theo thời gian thực.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '654c85ea-0eee-481c-916b-40b301dc2231'
);

-- [巩固] (gǒng gù): củng cố
UPDATE public.vocabularies
SET example_hanzi = '课后及时认真复习当天所学的重点语法与词汇，能够有效巩固课堂学习效果。',
    example_pinyin = 'Kèhòu jíshí rènzhēn fùxí dāngtiān suǒ xué de zhòngdiǎn yǔfǎ yǔ cíhuì, nénggòu yǒuxiào gǒnggù kètáng xuéxí xiàoguǒ.',
    example_vi = 'Sau giờ học kịp thời ôn tập chăm chỉ ngữ pháp và từ vựng trọng tâm trong ngày có thể củng cố hiệu quả học tập trên lớp một cách vững chắc.'
WHERE id = '1122408d-f88f-432f-ad17-eb0647cd7fad' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1122408d-f88f-432f-ad17-eb0647cd7fad', '课后及时认真复习当天所学的重点语法与词汇，能够有效巩固课堂学习效果。', 'Kèhòu jíshí rènzhēn fùxí dāngtiān suǒ xué de zhòngdiǎn yǔfǎ yǔ cíhuì, nénggòu yǒuxiào gǒnggù kètáng xuéxí xiàoguǒ.', 'Sau giờ học kịp thời ôn tập chăm chỉ ngữ pháp và từ vựng trọng tâm trong ngày có thể củng cố hiệu quả học tập trên lớp một cách vững chắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1122408d-f88f-432f-ad17-eb0647cd7fad'
);

-- [公告] (gōnggào): thông báo, cáo thị
UPDATE public.vocabularies
SET example_hanzi = '市民服务中心在官方网站首页发布了关于调整周末办事窗口服务时间的正式公告。',
    example_pinyin = 'Shìmín fúwù zhōngxīn zài guānfāng wǎngzhàn shǒuyè fābù le guānyú tiáozhěng zhōumò bànshì chuāngkǒu fúwù shíjiān de zhèngshì gōnggào.',
    example_vi = 'Trung tâm hành chính công phục vụ cư dân đã đăng thông cáo chính thức trên trang chủ về việc điều chỉnh thời gian làm việc các ô cửa cuối tuần.'
WHERE id = 'bfc23cc5-95bb-4c3b-9a88-1e1735511c94' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bfc23cc5-95bb-4c3b-9a88-1e1735511c94', '市民服务中心在官方网站首页发布了关于调整周末办事窗口服务时间的正式公告。', 'Shìmín fúwù zhōngxīn zài guānfāng wǎngzhàn shǒuyè fābù le guānyú tiáozhěng zhōumò bànshì chuāngkǒu fúwù shíjiān de zhèngshì gōnggào.', 'Trung tâm hành chính công phục vụ cư dân đã đăng thông cáo chính thức trên trang chủ về việc điều chỉnh thời gian làm việc các ô cửa cuối tuần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bfc23cc5-95bb-4c3b-9a88-1e1735511c94'
);

-- [共计] (gòngjì): tổng cộng, cộng lại
UPDATE public.vocabularies
SET example_hanzi = '本次国际学术研讨会共计吸引了来自三十多个国家的五百余位资深学者报名参会。',
    example_pinyin = 'Běncì guójì xuéshù yántǎohuì gòngjì xīyǐn le láizì sānshí duō gè guójiā de wǔbǎi yú wèi zīshēn xuézhě bàomíng cānhuì.',
    example_vi = 'Hội thảo học thuật quốc tế lần này tổng cộng đã thu hút hơn 500 học giả kỳ cựu đến từ hơn 30 quốc gia đăng ký tham dự.'
WHERE id = '8c0da145-71cf-486d-831d-b53174f07d30' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8c0da145-71cf-486d-831d-b53174f07d30', '本次国际学术研讨会共计吸引了来自三十多个国家的五百余位资深学者报名参会。', 'Běncì guójì xuéshù yántǎohuì gòngjì xīyǐn le láizì sānshí duō gè guójiā de wǔbǎi yú wèi zīshēn xuézhě bàomíng cānhuì.', 'Hội thảo học thuật quốc tế lần này tổng cộng đã thu hút hơn 500 học giả kỳ cựu đến từ hơn 30 quốc gia đăng ký tham dự.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8c0da145-71cf-486d-831d-b53174f07d30'
);

-- [供给] (gōngjǐ): cung cấp, chu cấp
UPDATE public.vocabularies
SET example_hanzi = '为了应对极端雨雪天气，物资保障部门全力调配蔬菜与肉类生活必需品的市场供给。',
    example_pinyin = 'Wèile yìngduì jíduān yǔxuě tiānqì, wùzī bǎozhàng bùmén quánlì diàopèi shūcài yǔ ròulèi shēnghuó bìxūpǐn de shìchǎng gōngjǐ.',
    example_vi = 'Nhằm đối phó thời tiết mưa tuyết cực đoan, bộ phận bảo đảm vật tư dốc toàn lực điều phối nguồn cung cấp rau củ và thịt nhu yếu phẩm cho thị trường.'
WHERE id = 'c20acf6f-85e4-492f-8a8a-153c6d1aadda' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c20acf6f-85e4-492f-8a8a-153c6d1aadda', '为了应对极端雨雪天气，物资保障部门全力调配蔬菜与肉类生活必需品的市场供给。', 'Wèile yìngduì jíduān yǔxuě tiānqì, wùzī bǎozhàng bùmén quánlì diàopèi shūcài yǔ ròulèi shēnghuó bìxūpǐn de shìchǎng gōngjǐ.', 'Nhằm đối phó thời tiết mưa tuyết cực đoan, bộ phận bảo đảm vật tư dốc toàn lực điều phối nguồn cung cấp rau củ và thịt nhu yếu phẩm cho thị trường.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c20acf6f-85e4-492f-8a8a-153c6d1aadda'
);

-- [攻击] (gōngjī): tấn công, công kích
UPDATE public.vocabularies
SET example_hanzi = '网络安全防护中心成功拦截了一起针对重点科研机构数据库的恶意黑客网络攻击。',
    example_pinyin = 'Wǎngluò ānquán fánghù zhōngxīn chénggōng lánjié le yì qǐ zhēnduì zhòngdiǎn kēyán jīgòu shùjùkù de è''yì hēikè wǎngluò gōngjī.',
    example_vi = 'Trung tâm phòng vệ an ninh mạng đã đánh chặn thành công một vụ tấn công mạng của tin tặc ác ý nhắm vào cơ sở dữ liệu viện nghiên cứu trọng điểm.'
WHERE id = '98852353-03dc-41f8-9f0f-64a8188b0467' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '98852353-03dc-41f8-9f0f-64a8188b0467', '网络安全防护中心成功拦截了一起针对重点科研机构数据库的恶意黑客网络攻击。', 'Wǎngluò ānquán fánghù zhōngxīn chénggōng lánjié le yì qǐ zhēnduì zhòngdiǎn kēyán jīgòu shùjùkù de è''yì hēikè wǎngluò gōngjī.', 'Trung tâm phòng vệ an ninh mạng đã đánh chặn thành công một vụ tấn công mạng của tin tặc ác ý nhắm vào cơ sở dữ liệu viện nghiên cứu trọng điểm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '98852353-03dc-41f8-9f0f-64a8188b0467'
);

-- [公开] (gōngkāi): công khai
UPDATE public.vocabularies
SET example_hanzi = '所有涉及政府财政预算与公共民生工程的资金使用情况，都应当依法向社会公众公开。',
    example_pinyin = 'Suǒyǒu shèjí zhèngfǔ cáizhèng yùsuàn yǔ gōnggòng mínshēng gōngchéng de zījīn shǐyòng qíngkuàng, dōu yīngdāng yīfǎ xiàng shèhuì gōngzhòng gōngkāi.',
    example_vi = 'Mọi tình hình sử dụng nguồn vốn liên quan tới ngân sách tài chính chính phủ và công trình an sinh dân sinh đều phải công khai minh bạch trước công chúng theo luật.'
WHERE id = '3feabd5b-58e9-4f15-8359-8fb51f5f2769' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3feabd5b-58e9-4f15-8359-8fb51f5f2769', '所有涉及政府财政预算与公共民生工程的资金使用情况，都应当依法向社会公众公开。', 'Suǒyǒu shèjí zhèngfǔ cáizhèng yùsuàn yǔ gōnggòng mínshēng gōngchéng de zījīn shǐyòng qíngkuàng, dōu yīngdāng yīfǎ xiàng shèhuì gōngzhòng gōngkāi.', 'Mọi tình hình sử dụng nguồn vốn liên quan tới ngân sách tài chính chính phủ và công trình an sinh dân sinh đều phải công khai minh bạch trước công chúng theo luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3feabd5b-58e9-4f15-8359-8fb51f5f2769'
);

-- [公民] (gōngmín): công dân
UPDATE public.vocabularies
SET example_hanzi = '依法按时纳税并自觉遵守公共道德秩序，是每一位国家合法公民应当履行的基本义务。',
    example_pinyin = 'Yīfǎ ànshí nàshuì bìng zìjué zūnshǒu gōnggòng dàodé zhìxù, shì měi yí wèi guójiā héfǎ gōngmín yīngdāng lǚxíng de jīběn yìwù.',
    example_vi = 'Nộp thuế đúng hạn theo luật và tự giác tuân thủ trật tự đạo đức công cộng là nghĩa vụ cơ bản mà mỗi công dân hợp pháp của đất nước đều phải thực hiện.'
WHERE id = '5e352e7e-61a5-4b95-a278-dfa284e3ce81' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5e352e7e-61a5-4b95-a278-dfa284e3ce81', '依法按时纳税并自觉遵守公共道德秩序，是每一位国家合法公民应当履行的基本义务。', 'Yīfǎ ànshí nàshuì bìng zìjué zūnshǒu gōnggòng dàodé zhìxù, shì měi yí wèi guójiā héfǎ gōngmín yīngdāng lǚxíng de jīběn yìwù.', 'Nộp thuế đúng hạn theo luật và tự giác tuân thủ trật tự đạo đức công cộng là nghĩa vụ cơ bản mà mỗi công dân hợp pháp của đất nước đều phải thực hiện.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5e352e7e-61a5-4b95-a278-dfa284e3ce81'
);

-- [公认] (gōngrèn): công nhận
UPDATE public.vocabularies
SET example_hanzi = '屠呦呦教授发现青蒿素并拯救了全球数百万疟疾患者，是国际医学界公认的杰出科学家。',
    example_pinyin = 'Tú Yōuyōu jiàoshòu fāxiàn qīnghāosù bìng zhěngjiù le quánqiú shùbǎi wàn nüèjí huànzhě, shì guójì yīxuéjiè gōngrèn de jiéchū kēxuéjiā.',
    example_vi = 'Giáo sư Đồ U U phát hiện artemisinin cứu sống hàng triệu bệnh nhân sốt rét trên toàn cầu là nhà khoa học kiệt xuất được cả giới y học quốc tế công nhận.'
WHERE id = 'f1ef73ff-89c5-4241-ad98-390ea570dd9e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f1ef73ff-89c5-4241-ad98-390ea570dd9e', '屠呦呦教授发现青蒿素并拯救了全球数百万疟疾患者，是国际医学界公认的杰出科学家。', 'Tú Yōuyōu jiàoshòu fāxiàn qīnghāosù bìng zhěngjiù le quánqiú shùbǎi wàn nüèjí huànzhě, shì guójì yīxuéjiè gōngrèn de jiéchū kēxuéjiā.', 'Giáo sư Đồ U U phát hiện artemisinin cứu sống hàng triệu bệnh nhân sốt rét trên toàn cầu là nhà khoa học kiệt xuất được cả giới y học quốc tế công nhận.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f1ef73ff-89c5-4241-ad98-390ea570dd9e'
);

-- [功效] (gōngxiào): công hiệu, tác dụng
UPDATE public.vocabularies
SET example_hanzi = '传统中医认为，适量饮用菊花茶具有清肝明目、疏风散热的良好保健功效。',
    example_pinyin = 'Chuántǒng zhōngyī rènwéi, shìliàng yǐnyòng júhuāchá jùyǒu qīnggān-míngmù, shūfēng-sànrè de liánghǎo bǎojiàn gōngxiào.',
    example_vi = 'Đông y truyền thống cho rằng uống trà hoa cúc lượng vừa phải có công hiệu thanh nhiệt giải độc, sáng mắt mát gan rất tốt cho sức khỏe.'
WHERE id = 'ef6f7e02-960f-4048-aed7-3b711c679ef1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ef6f7e02-960f-4048-aed7-3b711c679ef1', '传统中医认为，适量饮用菊花茶具有清肝明目、疏风散热的良好保健功效。', 'Chuántǒng zhōngyī rènwéi, shìliàng yǐnyòng júhuāchá jùyǒu qīnggān-míngmù, shūfēng-sànrè de liánghǎo bǎojiàn gōngxiào.', 'Đông y truyền thống cho rằng uống trà hoa cúc lượng vừa phải có công hiệu thanh nhiệt giải độc, sáng mắt mát gan rất tốt cho sức khỏe.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ef6f7e02-960f-4048-aed7-3b711c679ef1'
);

-- [公元] (gōngyuán): Công nguyên
UPDATE public.vocabularies
SET example_hanzi = '这座保存完好的古代石拱桥始建于公元七世纪初，历经一千四百多年风雨依然坚固如初。',
    example_pinyin = 'Zhè zuò bǎocún wánhǎo de gǔdài shígǒngqiáo shǐjiàn yú gōngyuán qī shìjì chū, lìjīng yìqiān sìbǎi duō nián fēngyǔ yīrán jiāngù rúchū.',
    example_vi = 'Cây cầu vòm đá cổ được bảo tồn nguyên vẹn này khởi công xây dựng vào đầu thế kỷ 7 Công nguyên, trải qua hơn 1.400 năm mưa gió vẫn vững chãi như thuở ban đầu.'
WHERE id = 'fc806d09-642d-4e2a-939b-6b66d4e96cdc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fc806d09-642d-4e2a-939b-6b66d4e96cdc', '这座保存完好的古代石拱桥始建于公元七世纪初，历经一千四百多年风雨依然坚固如初。', 'Zhè zuò bǎocún wánhǎo de gǔdài shígǒngqiáo shǐjiàn yú gōngyuán qī shìjì chū, lìjīng yìqiān sìbǎi duō nián fēngyǔ yīrán jiāngù rúchū.', 'Cây cầu vòm đá cổ được bảo tồn nguyên vẹn này khởi công xây dựng vào đầu thế kỷ 7 Công nguyên, trải qua hơn 1.400 năm mưa gió vẫn vững chãi như thuở ban đầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fc806d09-642d-4e2a-939b-6b66d4e96cdc'
);

-- [公正] (gōngzhèng): công chính, công bằng
UPDATE public.vocabularies
SET example_hanzi = '法官在法庭审理过程中严格依据客观事实与法律法规，做出了公平公正的判决。',
    example_pinyin = 'Fǎguān zài fǎtíng shěnlǐ guòchéng zhōng yángé yījù kèguān shìshí yǔ fǎlǜ fǎguī, zuòchū le gōngpíng gōngzhèng de pànjué.',
    example_vi = 'Thẩm phán trong quá trình xét xử tại tòa đã căn cứ nghiêm ngặt vào sự thật khách quan và luật pháp quy định để đưa ra phán quyết công bằng công chính.'
WHERE id = 'a20c8a49-4fbb-4f6c-ae3d-19c4bb640067' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a20c8a49-4fbb-4f6c-ae3d-19c4bb640067', '法官在法庭审理过程中严格依据客观事实与法律法规，做出了公平公正的判决。', 'Fǎguān zài fǎtíng shěnlǐ guòchéng zhōng yángé yījù kèguān shìshí yǔ fǎlǜ fǎguī, zuòchū le gōngpíng gōngzhèng de pànjué.', 'Thẩm phán trong quá trình xét xử tại tòa đã căn cứ nghiêm ngặt vào sự thật khách quan và luật pháp quy định để đưa ra phán quyết công bằng công chính.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a20c8a49-4fbb-4f6c-ae3d-19c4bb640067'
);

-- [公主] (gōngzhǔ): công chúa
UPDATE public.vocabularies
SET example_hanzi = '安徒生经典童话故事里的白雪公主心地善良纯洁，深受世界各国小朋友们的喜爱。',
    example_pinyin = 'Āntúshēng jīngdiǎn tónghuà gùshì lǐ de Báixuě gōngzhǔ xīndì shànliáng chúnjié, shēn shòu shìjiè gè guó xiǎopéngyou men de xǐ''ài.',
    example_vi = 'Nàng công chúa Bạch Tuyết trong truyện cổ tích kinh điển của Andersen có tâm hồn trong sáng lương thiện, được trẻ em khắp thế giới yêu thích.'
WHERE id = '8ba99504-9e6b-4c87-8353-dbefda2039c3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8ba99504-9e6b-4c87-8353-dbefda2039c3', '安徒生经典童话故事里的白雪公主心地善良纯洁，深受世界各国小朋友们的喜爱。', 'Āntúshēng jīngdiǎn tónghuà gùshì lǐ de Báixuě gōngzhǔ xīndì shànliáng chúnjié, shēn shòu shìjiè gè guó xiǎopéngyou men de xǐ''ài.', 'Nàng công chúa Bạch Tuyết trong truyện cổ tích kinh điển của Andersen có tâm hồn trong sáng lương thiện, được trẻ em khắp thế giới yêu thích.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8ba99504-9e6b-4c87-8353-dbefda2039c3'
);

-- [拐弯] (guǎiwān): rẽ, quẹo
UPDATE public.vocabularies
SET example_hanzi = '山路崎岖狭窄且视线不佳，汽车在连续拐弯路段行驶时一定要减速慢行、鸣笛示警。',
    example_pinyin = 'Shānlù qíqū xiázhǎi qiě shìxiàn bù jiā, qìchē zài liánxù guǎiwān lùduàn xíngshǐ shí yídìng yào jiǎnsù mànxíng, míngdí shìjǐng.',
    example_vi = 'Đường núi quanh co hiểm trở tầm nhìn hạn chế, ô tô khi chạy qua đoạn đường cua rẽ liên tục nhất định phải giảm tốc độ đi chậm và bấm còi cảnh báo.'
WHERE id = '23b2db00-b4fc-491a-8710-4e835201d1a7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '23b2db00-b4fc-491a-8710-4e835201d1a7', '山路崎岖狭窄且视线不佳，汽车在连续拐弯路段行驶时一定要减速慢行、鸣笛示警。', 'Shānlù qíqū xiázhǎi qiě shìxiàn bù jiā, qìchē zài liánxù guǎiwān lùduàn xíngshǐ shí yídìng yào jiǎnsù mànxíng, míngdí shìjǐng.', 'Đường núi quanh co hiểm trở tầm nhìn hạn chế, ô tô khi chạy qua đoạn đường cua rẽ liên tục nhất định phải giảm tốc độ đi chậm và bấm còi cảnh báo.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '23b2db00-b4fc-491a-8710-4e835201d1a7'
);

-- [罐] (guàn): hũ, bình, lon
UPDATE public.vocabularies
SET example_hanzi = '在炎热口渴的夏季午后，他从冰箱里拿出一听冰镇易拉罐可乐一饮而尽。',
    example_pinyin = 'Zài yánrè kǒukě de xiàjì wǔhòu, tā cóng bīngxiāng lǐ ná chū yì tīng bīngzhèn yìlāguàn kělè yìyǐn''érjìn.',
    example_vi = 'Vào một buổi chiều hè oi bức khát khô họng, anh ấy lấy một lon nước ngọt có gas ướp lạnh từ tủ lạnh ra uống một hơi cạn sạch.'
WHERE id = '492b1815-7370-4c7c-86d2-ef758bbdb2d1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '492b1815-7370-4c7c-86d2-ef758bbdb2d1', '在炎热口渴的夏季午后，他从冰箱里拿出一听冰镇易拉罐可乐一饮而尽。', 'Zài yánrè kǒukě de xiàjì wǔhòu, tā cóng bīngxiāng lǐ ná chū yì tīng bīngzhèn yìlāguàn kělè yìyǐn''érjìn.', 'Vào một buổi chiều hè oi bức khát khô họng, anh ấy lấy một lon nước ngọt có gas ướp lạnh từ tủ lạnh ra uống một hơi cạn sạch.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '492b1815-7370-4c7c-86d2-ef758bbdb2d1'
);

-- [官] (guān): quan, viên chức
UPDATE public.vocabularies
SET example_hanzi = '为官一任应当清正廉洁、造福一方百姓，时刻把人民群众的安危冷暖放在首位。',
    example_pinyin = 'Wéi guān yí rèn yīngdāng qīngzhèng-liánjié, zàofú yì fāng bǎixìng, shíkè bǎ rénmín qúnzhòng de ānwēi lěngnuǎn fàng zài shǒuwèi.',
    example_vi = 'Làm quan một nhiệm kỳ phải thanh liêm chính trực, mang lại phúc lợi cho bách tính muôn dân, luôn đặt sự an nguy ấm no của nhân dân lên hàng đầu.'
WHERE id = '07f568f6-15fb-469f-833f-f5a658f84ad6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '07f568f6-15fb-469f-833f-f5a658f84ad6', '为官一任应当清正廉洁、造福一方百姓，时刻把人民群众的安危冷暖放在首位。', 'Wéi guān yí rèn yīngdāng qīngzhèng-liánjié, zàofú yì fāng bǎixìng, shíkè bǎ rénmín qúnzhòng de ānwēi lěngnuǎn fàng zài shǒuwèi.', 'Làm quan một nhiệm kỳ phải thanh liêm chính trực, mang lại phúc lợi cho bách tính muôn dân, luôn đặt sự an nguy ấm no của nhân dân lên hàng đầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '07f568f6-15fb-469f-833f-f5a658f84ad6'
);

-- [官方] (guānfāng): chính quyền, chính thức
UPDATE public.vocabularies
SET example_hanzi = '卫生健康委员会通过官方微博向社会公布了本次突发疫情的最新流调与防治进展。',
    example_pinyin = 'Wèishēng jiànkāng wěiyuánhuì tōngguò guānfāng wēibó xiàng shèhuì gōngbù le běncì tūfā yìqíng de zuìxīn liúdiào yǔ fángzhì jìnzhǎn.',
    example_vi = 'Ủy ban y tế sức khỏe thông qua tài khoản Weibo chính thức đã công bố tới xã hội tiến triển điều tra dịch tễ và phòng chống mới nhất của đợt dịch bất ngờ này.'
WHERE id = 'b5edd573-b945-4e0d-a36a-84fa8b442929' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b5edd573-b945-4e0d-a36a-84fa8b442929', '卫生健康委员会通过官方微博向社会公布了本次突发疫情的最新流调与防治进展。', 'Wèishēng jiànkāng wěiyuánhuì tōngguò guānfāng wēibó xiàng shèhuì gōngbù le běncì tūfā yìqíng de zuìxīn liúdiào yǔ fángzhì jìnzhǎn.', 'Ủy ban y tế sức khỏe thông qua tài khoản Weibo chính thức đã công bố tới xã hội tiến triển điều tra dịch tễ và phòng chống mới nhất của đợt dịch bất ngờ này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b5edd573-b945-4e0d-a36a-84fa8b442929'
);

-- [广阔] (guǎng kuò): rộng lớn, bao la
UPDATE public.vocabularies
SET example_hanzi = '站在海拔三千米的高山草甸上极目远眺，广阔无垠的绿色草原与蔚蓝天空融为一体。',
    example_pinyin = 'Zhàn zài hǎibá sānqiān mǐ de gāoshān cǎodiàn shang jímù yuǎntiào, guǎngkuò-wúyín de lǜsè cǎoyuán yǔ wèilán tiānkōng róng wéi yìtǐ.',
    example_vi = 'Đứng trên đồng cỏ núi cao ở độ cao 3.000 mét phóng tầm mắt ra xa, thảo nguyên xanh rộng lớn bao la cùng bầu trời xanh biếc hòa thành một dải.'
WHERE id = '35d0b9f2-a5d4-4b5f-be98-b4353e7576c9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '35d0b9f2-a5d4-4b5f-be98-b4353e7576c9', '站在海拔三千米的高山草甸上极目远眺，广阔无垠的绿色草原与蔚蓝天空融为一体。', 'Zhàn zài hǎibá sānqiān mǐ de gāoshān cǎodiàn shang jímù yuǎntiào, guǎngkuò-wúyín de lǜsè cǎoyuán yǔ wèilán tiānkōng róng wéi yìtǐ.', 'Đứng trên đồng cỏ núi cao ở độ cao 3.000 mét phóng tầm mắt ra xa, thảo nguyên xanh rộng lớn bao la cùng bầu trời xanh biếc hòa thành một dải.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '35d0b9f2-a5d4-4b5f-be98-b4353e7576c9'
);

-- [观光] (guānguāng): tham quan, ngắm cảnh
UPDATE public.vocabularies
SET example_hanzi = '来自海内外的数千名游客搭乘游轮夜游黄浦江，欣赏外滩两岸灯火辉煌的迷人观光风貌。',
    example_pinyin = 'Láizì hǎinèiwài de shùqiān míng yóukè dāchéng yóulún yèyóu Huángpǔjiāng, xīnshǎng Wàitān liǎng''àn dēnghuǒ-huīhuáng de mírén guānguāng fēngmào.',
    example_vi = 'Hàng ngàn du khách trong và ngoài nước lên tàu du lịch ngắm cảnh đêm sông Hoàng Phố, chiêm ngưỡng cảnh quan tham quan lung linh ánh đèn mê đắm hai bờ Bến Thượng Hải.'
WHERE id = '9d9df85f-48d7-4fa3-8d8d-1bb3bcfcb689' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9d9df85f-48d7-4fa3-8d8d-1bb3bcfcb689', '来自海内外的数千名游客搭乘游轮夜游黄浦江，欣赏外滩两岸灯火辉煌的迷人观光风貌。', 'Láizì hǎinèiwài de shùqiān míng yóukè dāchéng yóulún yèyóu Huángpǔjiāng, xīnshǎng Wàitān liǎng''àn dēnghuǒ-huīhuáng de mírén guānguāng fēngmào.', 'Hàng ngàn du khách trong và ngoài nước lên tàu du lịch ngắm cảnh đêm sông Hoàng Phố, chiêm ngưỡng cảnh quan tham quan lung linh ánh đèn mê đắm hai bờ Bến Thượng Hải.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9d9df85f-48d7-4fa3-8d8d-1bb3bcfcb689'
);

-- [关怀] (guānhuái): quan tâm, săn sóc
UPDATE public.vocabularies
SET example_hanzi = '社区志愿者逢年过节都会上门探望孤寡老人，送去社会的温暖与无微不至的关怀。',
    example_pinyin = 'Shèqū zhìyuànzhě féngnián-guòjié dōu huì shàngmén tànwàng gūguǎ lǎorén, sòng qù shèhuì de wēnnuǎn yǔ wúwēi-búzhì de guānhuái.',
    example_vi = 'Các tình nguyện viên khu dân cư mỗi dịp lễ tết đều đến tận nhà thăm hỏi người già neo đơn, mang lại hơi ấm và sự quan tâm chu đáo của xã hội.'
WHERE id = '0ced5982-7f70-4523-a798-ff3ed24af93e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0ced5982-7f70-4523-a798-ff3ed24af93e', '社区志愿者逢年过节都会上门探望孤寡老人，送去社会的温暖与无微不至的关怀。', 'Shèqū zhìyuànzhě féngnián-guòjié dōu huì shàngmén tànwàng gūguǎ lǎorén, sòng qù shèhuì de wēnnuǎn yǔ wúwēi-búzhì de guānhuái.', 'Các tình nguyện viên khu dân cư mỗi dịp lễ tết đều đến tận nhà thăm hỏi người già neo đơn, mang lại hơi ấm và sự quan tâm chu đáo của xã hội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0ced5982-7f70-4523-a798-ff3ed24af93e'
);

-- [古典] (gǔdiǎn): cổ điển
UPDATE public.vocabularies
SET example_hanzi = '这位年轻钢琴家对贝多芬和莫扎特的经典古典音乐作品有着深刻独到的艺术理解。',
    example_pinyin = 'Zhè wèi niánqīng gāngqínjiā duì Bèiduōfēn hé Mòzhātè de jīngdiǎn gǔdiǎn yīnyuè zuòpǐn yǒu zhe shēnkè dúdào de yìshù lǐjiě.',
    example_vi = 'Nghệ sĩ dương cầm trẻ tuổi này có sự thấu hiểu nghệ thuật sâu sắc độc đáo đối với các tác phẩm âm nhạc cổ điển kinh điển của Beethoven và Mozart.'
WHERE id = '4dccd490-3e2a-4b00-8a88-5b19238936bf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4dccd490-3e2a-4b00-8a88-5b19238936bf', '这位年轻钢琴家对贝多芬和莫扎特的经典古典音乐作品有着深刻独到的艺术理解。', 'Zhè wèi niánqīng gāngqínjiā duì Bèiduōfēn hé Mòzhātè de jīngdiǎn gǔdiǎn yīnyuè zuòpǐn yǒu zhe shēnkè dúdào de yìshù lǐjiě.', 'Nghệ sĩ dương cầm trẻ tuổi này có sự thấu hiểu nghệ thuật sâu sắc độc đáo đối với các tác phẩm âm nhạc cổ điển kinh điển của Beethoven và Mozart.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4dccd490-3e2a-4b00-8a88-5b19238936bf'
);

-- [孤独] (gūdú): cô đơn, cô độc
UPDATE public.vocabularies
SET example_hanzi = '在异国他乡求学的日子里，每当夜深人静时他难免会感到几分思乡的孤独。',
    example_pinyin = 'Zài yìguó-tāxiāng qiúxué de rìzi lǐ, měi dāng yèshēn-rénjìng shí tā nánmiǎn huì gǎndào jǐ fēn sīxiāng de gūdú.',
    example_vi = 'Trong những ngày tháng du học nơi đất khách quê người, mỗi khi đêm khuya thanh vắng anh ấy khó tránh cảm thấy đôi phần cô đơn nhớ quê hương.'
WHERE id = '4e790fe7-1ad7-4216-9ab6-bf041d1fc639' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4e790fe7-1ad7-4216-9ab6-bf041d1fc639', '在异国他乡求学的日子里，每当夜深人静时他难免会感到几分思乡的孤独。', 'Zài yìguó-tāxiāng qiúxué de rìzi lǐ, měi dāng yèshēn-rénjìng shí tā nánmiǎn huì gǎndào jǐ fēn sīxiāng de gūdú.', 'Trong những ngày tháng du học nơi đất khách quê người, mỗi khi đêm khuya thanh vắng anh ấy khó tránh cảm thấy đôi phần cô đơn nhớ quê hương.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4e790fe7-1ad7-4216-9ab6-bf041d1fc639'
);

-- [姑姑] (gūgu): cô (chị em gái của bố)
UPDATE public.vocabularies
SET example_hanzi = '我的亲姑姑是一名敬业的高中英语特级教师，从小就细心辅导我的外语发音。',
    example_pinyin = 'Wǒ de qīn gūgu shì yì míng jìngyè de gāozhōng Yīngyǔ tèjí jiàoshī, cóngxiǎo jiù xìxīn fǔdǎo wǒ de wàiyǔ fāyīn.',
    example_vi = 'Cô ruột của tôi là một giáo viên tiếng Anh cấp ba ưu tú tận tụy, từ nhỏ đã ân cần kèm cặp phát âm ngoại ngữ cho tôi.'
WHERE id = 'd3add7a4-c178-4d6a-ad11-ae3eef5bb071' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd3add7a4-c178-4d6a-ad11-ae3eef5bb071', '我的亲姑姑是一名敬业的高中英语特级教师，从小就细心辅导我的外语发音。', 'Wǒ de qīn gūgu shì yì míng jìngyè de gāozhōng Yīngyǔ tèjí jiàoshī, cóngxiǎo jiù xìxīn fǔdǎo wǒ de wàiyǔ fāyīn.', 'Cô ruột của tôi là một giáo viên tiếng Anh cấp ba ưu tú tận tụy, từ nhỏ đã ân cần kèm cặp phát âm ngoại ngữ cho tôi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd3add7a4-c178-4d6a-ad11-ae3eef5bb071'
);

-- [跪] (guì): quỳ
UPDATE public.vocabularies
SET example_hanzi = '在传统的祭祖祈福仪式上，子孙后代恭敬地双膝跪地向先祖灵位行礼叩头。',
    example_pinyin = 'Zài chuántǒng de jìzǔ qífú yíshì shang, zǐsūn-hòudài gōngjìng de shuāngxī guì dì xiàng xiānzǔ língwèi xínglǐ kòutóu.',
    example_vi = 'Trong nghi lễ giỗ tổ cầu phúc truyền thống, con cháu cung kính quỳ hai gối xuống đất hành lễ dập đầu trước linh vị tổ tiên.'
WHERE id = 'f3b320fd-4e9e-4da8-8ee7-67f2f3ca9a5b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f3b320fd-4e9e-4da8-8ee7-67f2f3ca9a5b', '在传统的祭祖祈福仪式上，子孙后代恭敬地双膝跪地向先祖灵位行礼叩头。', 'Zài chuántǒng de jìzǔ qífú yíshì shang, zǐsūn-hòudài gōngjìng de shuāngxī guì dì xiàng xiānzǔ língwèi xínglǐ kòutóu.', 'Trong nghi lễ giỗ tổ cầu phúc truyền thống, con cháu cung kính quỳ hai gối xuống đất hành lễ dập đầu trước linh vị tổ tiên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f3b320fd-4e9e-4da8-8ee7-67f2f3ca9a5b'
);

-- [归还] (guī huán): trả lại, hoàn trả
UPDATE public.vocabularies
SET example_hanzi = '从大学图书馆借阅的专业外文参考图书，请务必在借期截止日前按时归还。',
    example_pinyin = 'Cóng dàxué túshūguǎn jièyuè de zhuānyè wàiwén cānkǎo túshū, qǐng wùbì zài jièqī jiézhǐrì qián ànshí guīhuán.',
    example_vi = 'Sách tham khảo ngoại văn chuyên ngành mượn từ thư viện trường đại học xin nhất thiết hoàn trả đúng hạn trước ngày hết hạn mượn.'
WHERE id = '2954a9db-aee4-42fa-b464-30bdeaa39fc6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2954a9db-aee4-42fa-b464-30bdeaa39fc6', '从大学图书馆借阅的专业外文参考图书，请务必在借期截止日前按时归还。', 'Cóng dàxué túshūguǎn jièyuè de zhuānyè wàiwén cānkǎo túshū, qǐng wùbì zài jièqī jiézhǐrì qián ànshí guīhuán.', 'Sách tham khảo ngoại văn chuyên ngành mượn từ thư viện trường đại học xin nhất thiết hoàn trả đúng hạn trước ngày hết hạn mượn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2954a9db-aee4-42fa-b464-30bdeaa39fc6'
);

-- [轨道] (guǐdào): quỹ đạo, đường ray
UPDATE public.vocabularies
SET example_hanzi = '中国空间站核心舱在距地球约四百公里的预定轨道上平稳运行，各项科研实验进展顺利。',
    example_pinyin = 'Zhōngguó kōngjiānzhàn héxīncāng zài jù dìqiú yuē sìbǎi gōnglǐ de yùdìng guǐdào shang píngwěn yùnxíng, gè xiàng kēyán shíyàn jìnzhǎn shùnlì.',
    example_vi = 'Mô-đun lõi trạm vũ trụ Trung Quốc đang vận hành êm thuận trên quỹ đạo định sẵn cách mặt đất khoảng 400 km, các thí nghiệm nghiên cứu tiến triển suôn sẻ.'
WHERE id = '304d46dc-3d7b-416d-94f2-12a4df4e67fd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '304d46dc-3d7b-416d-94f2-12a4df4e67fd', '中国空间站核心舱在距地球约四百公里的预定轨道上平稳运行，各项科研实验进展顺利。', 'Zhōngguó kōngjiānzhàn héxīncāng zài jù dìqiú yuē sìbǎi gōnglǐ de yùdìng guǐdào shang píngwěn yùnxíng, gè xiàng kēyán shíyàn jìnzhǎn shùnlì.', 'Mô-đun lõi trạm vũ trụ Trung Quốc đang vận hành êm thuận trên quỹ đạo định sẵn cách mặt đất khoảng 400 km, các thí nghiệm nghiên cứu tiến triển suôn sẻ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '304d46dc-3d7b-416d-94f2-12a4df4e67fd'
);

-- [规范] (guīfàn): quy phạm, chuẩn mực
UPDATE public.vocabularies
SET example_hanzi = '实验室管理部门明确制定了一套严格的安全操作规范，要求全体科研师生严格执行。',
    example_pinyin = 'Shíyànshì guǎnlǐ bùmén míngquè zhìdìng le yí tào yángé de ānquán cāozuò guīfàn, yāoqiú quántǐ kēyán shīshēng yángé zhíxíng.',
    example_vi = 'Ban quản lý phòng thí nghiệm đã ban hành rõ một bộ quy phạm thao tác an toàn nghiêm ngặt, yêu cầu toàn thể giảng viên sinh viên nghiên cứu thực hiện nghiêm túc.'
WHERE id = '938b9935-fd46-4ae4-bb55-380ce1bc1552' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '938b9935-fd46-4ae4-bb55-380ce1bc1552', '实验室管理部门明确制定了一套严格的安全操作规范，要求全体科研师生严格执行。', 'Shíyànshì guǎnlǐ bùmén míngquè zhìdìng le yí tào yángé de ānquán cāozuò guīfàn, yāoqiú quántǐ kēyán shīshēng yángé zhíxíng.', 'Ban quản lý phòng thí nghiệm đã ban hành rõ một bộ quy phạm thao tác an toàn nghiêm ngặt, yêu cầu toàn thể giảng viên sinh viên nghiên cứu thực hiện nghiêm túc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '938b9935-fd46-4ae4-bb55-380ce1bc1552'
);

-- [规划] (guīhuà): quy hoạch
UPDATE public.vocabularies
SET example_hanzi = '市政府制定了未来十五年的城市立体综合交通网络发展长远规划，旨在缓解拥堵。',
    example_pinyin = 'Shì zhèngfǔ zhìdìng le wèilái shíwǔ nián de chéngshì lìtǐ zōnghé jiāotōng wǎngluò fāzhǎn chángyuǎn guīhuà, zhǐzài huǎnjiě yōngdǔ.',
    example_vi = 'Chính quyền thành phố đã xây dựng quy hoạch phát triển lâu dài mạng lưới giao thông tổng hợp lập thể 15 năm tới nhằm giảm thiểu ùn tắc.'
WHERE id = '506dab03-3924-4ac9-a14f-b5beb178ef7c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '506dab03-3924-4ac9-a14f-b5beb178ef7c', '市政府制定了未来十五年的城市立体综合交通网络发展长远规划，旨在缓解拥堵。', 'Shì zhèngfǔ zhìdìng le wèilái shíwǔ nián de chéngshì lìtǐ zōnghé jiāotōng wǎngluò fāzhǎn chángyuǎn guīhuà, zhǐzài huǎnjiě yōngdǔ.', 'Chính quyền thành phố đã xây dựng quy hoạch phát triển lâu dài mạng lưới giao thông tổng hợp lập thể 15 năm tới nhằm giảm thiểu ùn tắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '506dab03-3924-4ac9-a14f-b5beb178ef7c'
);

-- [规矩] (guīju): quy củ, khuôn phép
UPDATE public.vocabularies
SET example_hanzi = '中国民间茶道有着许多讲究礼节的传统规矩，充分体现了主人对来宾的敬重。',
    example_pinyin = 'Zhōngguó mínjiān chádào yǒu zhe xǔduō jiǎngjiu lǐjié de chuántǒng guīju, chōngfèn tǐxiàn le zhǔrén duì láibīn de jìngzhòng.',
    example_vi = 'Trà đạo dân gian Trung Hoa có rất nhiều quy củ nề nếp truyền thống chú trọng lễ tiết, thể hiện trọn vẹn lòng kính trọng của chủ nhà với khách quý.'
WHERE id = '42ad7abd-9bee-4b8e-a4f1-37792a627803' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '42ad7abd-9bee-4b8e-a4f1-37792a627803', '中国民间茶道有着许多讲究礼节的传统规矩，充分体现了主人对来宾的敬重。', 'Zhōngguó mínjiān chádào yǒu zhe xǔduō jiǎngjiu lǐjié de chuántǒng guīju, chōngfèn tǐxiàn le zhǔrén duì láibīn de jìngzhòng.', 'Trà đạo dân gian Trung Hoa có rất nhiều quy củ nề nếp truyền thống chú trọng lễ tiết, thể hiện trọn vẹn lòng kính trọng của chủ nhà với khách quý.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '42ad7abd-9bee-4b8e-a4f1-37792a627803'
);

-- [过渡] (guòdù): chuyển tiếp, quá độ
UPDATE public.vocabularies
SET example_hanzi = '从化石传统能源向风电光伏等绿色可再生清洁能源的转型，需要平稳有序的战略过渡。',
    example_pinyin = 'Cóng huàshí chuántǒng néngyuán xiàng fēngdiàn guāngfú děng lǜsè kězàishēng qīngjié néngyuán de zhuǎnxíng, xūyào píngwěn yǒuxù de zhànlüè guòdù.',
    example_vi = 'Quá trình chuyển dịch từ năng lượng hóa thạch truyền thống sang năng lượng xanh sạch tái tạo như điện gió điện mặt trời cần có sự quá độ chiến lược êm ả trật tự.'
WHERE id = '7e47455c-3fcf-4ff6-9393-9ad9f0f965a9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7e47455c-3fcf-4ff6-9393-9ad9f0f965a9', '从化石传统能源向风电光伏等绿色可再生清洁能源的转型，需要平稳有序的战略过渡。', 'Cóng huàshí chuántǒng néngyuán xiàng fēngdiàn guāngfú děng lǜsè kězàishēng qīngjié néngyuán de zhuǎnxíng, xūyào píngwěn yǒuxù de zhànlüè guòdù.', 'Quá trình chuyển dịch từ năng lượng hóa thạch truyền thống sang năng lượng xanh sạch tái tạo như điện gió điện mặt trời cần có sự quá độ chiến lược êm ả trật tự.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7e47455c-3fcf-4ff6-9393-9ad9f0f965a9'
);

-- [国王] (guówáng): quốc vương, vua
UPDATE public.vocabularies
SET example_hanzi = '在这部中世纪欧洲历史传记中，作者详细记述了那位骁勇善战的国王传奇的一生。',
    example_pinyin = 'Zài zhè bù zhōngshìjì Ōuzhōu lìshǐ zhuànjì zhōng, zuòzhě xiángxì jìshù le nà wèi xiāoyǒng-shànzhàn de guówáng chuánqí de yì shēng.',
    example_vi = 'Trong cuốn tiểu sử lịch sử châu Âu thời trung cổ này, tác giả đã thuật lại chi tiết cuộc đời huyền thoại của vị vua dũng cảm thiện chiến năm ấy.'
WHERE id = '893b2bf6-180a-4ed7-812b-18996a5d99d7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '893b2bf6-180a-4ed7-812b-18996a5d99d7', '在这部中世纪欧洲历史传记中，作者详细记述了那位骁勇善战的国王传奇的一生。', 'Zài zhè bù zhōngshìjì Ōuzhōu lìshǐ zhuànjì zhōng, zuòzhě xiángxì jìshù le nà wèi xiāoyǒng-shànzhàn de guówáng chuánqí de yì shēng.', 'Trong cuốn tiểu sử lịch sử châu Âu thời trung cổ này, tác giả đã thuật lại chi tiết cuộc đời huyền thoại của vị vua dũng cảm thiện chiến năm ấy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '893b2bf6-180a-4ed7-812b-18996a5d99d7'
);

-- [股票] (gǔpiào): cổ phiếu
UPDATE public.vocabularies
SET example_hanzi = '理财顾问建议普通家庭在投资股票金融市场时要保持理性，做好风险分散管理。',
    example_pinyin = 'Lǐcái gùwèn jiànyì pǔtōng jiātíng zài tóuzī gǔpiào jīnróng shìchǎng shí yào bǎochí lǐxìng, zuò hǎo fēngxiǎn fēnsàn guǎnlǐ.',
    example_vi = 'Cố vấn tài chính khuyến cáo các gia đình bình thường khi đầu tư vào thị trường tài chính cổ phiếu cần giữ lý trí và quản lý phân tán rủi ro tốt.'
WHERE id = 'da2e400c-be51-43c3-bcf2-82716958705c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'da2e400c-be51-43c3-bcf2-82716958705c', '理财顾问建议普通家庭在投资股票金融市场时要保持理性，做好风险分散管理。', 'Lǐcái gùwèn jiànyì pǔtōng jiātíng zài tóuzī gǔpiào jīnróng shìchǎng shí yào bǎochí lǐxìng, zuò hǎo fēngxiǎn fēnsàn guǎnlǐ.', 'Cố vấn tài chính khuyến cáo các gia đình bình thường khi đầu tư vào thị trường tài chính cổ phiếu cần giữ lý trí và quản lý phân tán rủi ro tốt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'da2e400c-be51-43c3-bcf2-82716958705c'
);

-- [固体] (gùtǐ): thể rắn, chất rắn
UPDATE public.vocabularies
SET example_hanzi = '物理常识表明水在零摄氏度以下会凝固成冰，由液体状态转变成坚硬的固体状态。',
    example_pinyin = 'Wùlǐ chángshí biǎomíng shuǐ zài líng shèshìdù yǐxià huì nínggù chéng bīng, yóu yètǐ zhuàngtài zhuǎnbiàn chéng jiānyìng de gùtǐ zhuàngtài.',
    example_vi = 'Kiến thức vật lý thông thường chỉ ra nước dưới 0 độ C sẽ đông lại thành băng, chuyển từ thể lỏng sang trạng thái thể rắn cứng cáp.'
WHERE id = '1d0068cb-035c-4272-8882-bf05e18b944e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1d0068cb-035c-4272-8882-bf05e18b944e', '物理常识表明水在零摄氏度以下会凝固成冰，由液体状态转变成坚硬的固体状态。', 'Wùlǐ chángshí biǎomíng shuǐ zài líng shèshìdù yǐxià huì nínggù chéng bīng, yóu yètǐ zhuàngtài zhuǎnbiàn chéng jiānyìng de gùtǐ zhuàngtài.', 'Kiến thức vật lý thông thường chỉ ra nước dưới 0 độ C sẽ đông lại thành băng, chuyển từ thể lỏng sang trạng thái thể rắn cứng cáp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1d0068cb-035c-4272-8882-bf05e18b944e'
);

-- [骨头] (gútou): xương
UPDATE public.vocabularies
SET example_hanzi = '炖汤师傅用文火慢炖了足足四个小时的猪牛棒骨头，熬出的骨汤浓郁醇厚又营养。',
    example_pinyin = 'Dùntāng shīfu yòng wénhuǒ màn dùn le zúzú sì gè xiǎoshí de zhū-niú bàng gútou, áo chū de gǔtāng nóngyù chúnhòu yòu yíngyǎng.',
    example_vi = 'Đầu bếp hầm canh dùng lửa nhỏ ninh chậm suốt 4 tiếng xương ống heo bò, nấu ra nồi nước hầm xương đậm đà thơm ngậy lại bổ dưỡng.'
WHERE id = '582e24e2-8e85-4a22-992a-8d2a047bf9ac' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '582e24e2-8e85-4a22-992a-8d2a047bf9ac', '炖汤师傅用文火慢炖了足足四个小时的猪牛棒骨头，熬出的骨汤浓郁醇厚又营养。', 'Dùntāng shīfu yòng wénhuǒ màn dùn le zúzú sì gè xiǎoshí de zhū-niú bàng gútou, áo chū de gǔtāng nóngyù chúnhòu yòu yíngyǎng.', 'Đầu bếp hầm canh dùng lửa nhỏ ninh chậm suốt 4 tiếng xương ống heo bò, nấu ra nồi nước hầm xương đậm đà thơm ngậy lại bổ dưỡng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '582e24e2-8e85-4a22-992a-8d2a047bf9ac'
);

-- [顾问] (gùwèn): cố vấn
UPDATE public.vocabularies
SET example_hanzi = '为了应对跨国业务中的法律争议，集团董事会特别聘请了著名法学教授担任首席法律顾问。',
    example_pinyin = 'Wèile yìngduì kuàguó yèwù zhōng de fǎlǜ zhēngyì, jítuán dǒngshìhuì tèbié pìnqǐng le zhùmíng fǎxué jiàoshòu dānrèn shǒuxí fǎlǜ gùwèn.',
    example_vi = 'Để xử lý các tranh chấp pháp lý trong kinh doanh xuyên quốc gia, hội đồng quản trị tập đoàn đã đặc biệt mời giáo sư luật nổi tiếng làm cố vấn pháp lý trưởng.'
WHERE id = '0e363c15-961f-4b47-bc87-29eb6830f692' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0e363c15-961f-4b47-bc87-29eb6830f692', '为了应对跨国业务中的法律争议，集团董事会特别聘请了著名法学教授担任首席法律顾问。', 'Wèile yìngduì kuàguó yèwù zhōng de fǎlǜ zhēngyì, jítuán dǒngshìhuì tèbié pìnqǐng le zhùmíng fǎxué jiàoshòu dānrèn shǒuxí fǎlǜ gùwèn.', 'Để xử lý các tranh chấp pháp lý trong kinh doanh xuyên quốc gia, hội đồng quản trị tập đoàn đã đặc biệt mời giáo sư luật nổi tiếng làm cố vấn pháp lý trưởng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0e363c15-961f-4b47-bc87-29eb6830f692'
);

-- [鼓舞] (gǔwǔ): cổ vũ, khích lệ
UPDATE public.vocabularies
SET example_hanzi = '中国航天科学家攻坚克难取得的伟大成就，极大地鼓舞了全国各族青年的爱国奋斗热情。',
    example_pinyin = 'Zhōngguó hángtiān kēxuéjiā gōngjiān-kènán qǔdé de wěidà chéngjiù, jídà de gǔwǔ le quánguó gè zú qīngnián de àiguó fèndòu rèqíng.',
    example_vi = 'Những thành tựu vĩ đại mà các nhà khoa học hàng không vũ trụ Trung Quốc vượt khó gặt hái được đã cổ vũ khích lệ to lớn nhiệt huyết phấn đấu yêu nước của thanh niên cả nước.'
WHERE id = 'cda17071-fb76-4d80-b97b-168b045a3ba8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cda17071-fb76-4d80-b97b-168b045a3ba8', '中国航天科学家攻坚克难取得的伟大成就，极大地鼓舞了全国各族青年的爱国奋斗热情。', 'Zhōngguó hángtiān kēxuéjiā gōngjiān-kènán qǔdé de wěidà chéngjiù, jídà de gǔwǔ le quánguó gè zú qīngnián de àiguó fèndòu rèqíng.', 'Những thành tựu vĩ đại mà các nhà khoa học hàng không vũ trụ Trung Quốc vượt khó gặt hái được đã cổ vũ khích lệ to lớn nhiệt huyết phấn đấu yêu nước của thanh niên cả nước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cda17071-fb76-4d80-b97b-168b045a3ba8'
);

-- [故障] (gùzhàng): sự cố, trục trặc
UPDATE public.vocabularies
SET example_hanzi = '由于地铁信号系统突发网络通信故障，列车在早高峰期间临时减速运行了十分钟。',
    example_pinyin = 'Yóuyú dìtiě xìnhào xìtǒng tūfā wǎngluò tōngxìn gùzhàng, lièchē zài zǎogāofēng qījiān línshí jiǎnsù yùnxíng le shí fēnzhōng.',
    example_vi = 'Do hệ thống tín hiệu tàu điện ngầm gặp sự cố truyền thông mạng đột xuất, đoàn tàu trong giờ cao điểm sáng đã tạm thời giảm tốc độ chạy trong 10 phút.'
WHERE id = '3264a5bc-8ebd-4f8c-be66-03357bc15ceb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3264a5bc-8ebd-4f8c-be66-03357bc15ceb', '由于地铁信号系统突发网络通信故障，列车在早高峰期间临时减速运行了十分钟。', 'Yóuyú dìtiě xìnhào xìtǒng tūfā wǎngluò tōngxìn gùzhàng, lièchē zài zǎogāofēng qījiān línshí jiǎnsù yùnxíng le shí fēnzhōng.', 'Do hệ thống tín hiệu tàu điện ngầm gặp sự cố truyền thông mạng đột xuất, đoàn tàu trong giờ cao điểm sáng đã tạm thời giảm tốc độ chạy trong 10 phút.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3264a5bc-8ebd-4f8c-be66-03357bc15ceb'
);

-- [海拔] (hǎibá): độ cao so với mực nước biển
UPDATE public.vocabularies
SET example_hanzi = '西藏拉萨被称为高原阳光之城，整个城市坐落在平均海拔三千六百多米的高原河谷地带。',
    example_pinyin = 'Xīzàng Lāsà bèi chēngwéi gāoyuán yángguāng zhī chéng, zhěng gè chéngshì zuòluò zài píngjūn hǎibá sānqiān liùbǎi duō mǐ de gāoyuán hégǔ dìdài.',
    example_vi = 'Lhasa Tây Tạng được mệnh danh là thành phố ánh nắng cao nguyên, toàn thành phố tọa lạc tại vùng thung lũng sông cao nguyên có độ cao trung bình trên 3.600 m so với mực nước biển.'
WHERE id = '71d97e9a-19c8-426d-9c07-a24b7ec4ed89' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '71d97e9a-19c8-426d-9c07-a24b7ec4ed89', '西藏拉萨被称为高原阳光之城，整个城市坐落在平均海拔三千六百多米的高原河谷地带。', 'Xīzàng Lāsà bèi chēngwéi gāoyuán yángguāng zhī chéng, zhěng gè chéngshì zuòluò zài píngjūn hǎibá sānqiān liùbǎi duō mǐ de gāoyuán hégǔ dìdài.', 'Lhasa Tây Tạng được mệnh danh là thành phố ánh nắng cao nguyên, toàn thành phố tọa lạc tại vùng thung lũng sông cao nguyên có độ cao trung bình trên 3.600 m so với mực nước biển.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '71d97e9a-19c8-426d-9c07-a24b7ec4ed89'
);

-- [罕见] (hǎn jiàn): hiếm thấy
UPDATE public.vocabularies
SET example_hanzi = '气象监测部门发布特别报告指出，本周出现的特大暴雪属于该地区近五十年罕见的天气现象。',
    example_pinyin = 'Qìxiàng jiānkè bùmén fābù tèbié bàogào zhǐchū, běn zhōu chūxiàn de tédà bàoxuě shǔyú gāi dìqū jìn wǔshí nián hǎnjiàn de tiānqì xiànxiàng.',
    example_vi = 'Cơ quan quan trắc khí tượng ra báo cáo đặc biệt chỉ rõ trận bão tuyết cực lớn xuất hiện trong tuần này thuộc hiện tượng thời tiết hiếm thấy trong gần 50 năm qua của khu vực.'
WHERE id = '138138c1-f3fc-44b2-9fb5-3c4a4d7e4446' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '138138c1-f3fc-44b2-9fb5-3c4a4d7e4446', '气象监测部门发布特别报告指出，本周出现的特大暴雪属于该地区近五十年罕见的天气现象。', 'Qìxiàng jiānkè bùmén fābù tèbié bàogào zhǐchū, běn zhōu chūxiàn de tédà bàoxuě shǔyú gāi dìqū jìn wǔshí nián hǎnjiàn de tiānqì xiànxiàng.', 'Cơ quan quan trắc khí tượng ra báo cáo đặc biệt chỉ rõ trận bão tuyết cực lớn xuất hiện trong tuần này thuộc hiện tượng thời tiết hiếm thấy trong gần 50 năm qua của khu vực.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '138138c1-f3fc-44b2-9fb5-3c4a4d7e4446'
);

-- [航空] (háng kōng): hàng không
UPDATE public.vocabularies
SET example_hanzi = '国际航空运输协会数据显示，今年跨境商务航空旅客出行量呈现强劲的反弹复苏势头。',
    example_pinyin = 'Guójì hángkōng yùnshū xiéhuì shùjù xiǎnshì, jīnnián kuàjìng shāngwù hángkōng lǚkè chūxíng liàng chéngxiàn qiángjìn de fǎntán fùsū shìtóu.',
    example_vi = 'Số liệu của Hiệp hội Vận tải Hàng không Quốc tế cho thấy lượng hành khách hàng không thương mại xuyên biên giới năm nay phục hồi bật tăng mạnh mẽ.'
WHERE id = '81457b09-1a8e-42fb-9515-994da2359498' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '81457b09-1a8e-42fb-9515-994da2359498', '国际航空运输协会数据显示，今年跨境商务航空旅客出行量呈现强劲的反弹复苏势头。', 'Guójì hángkōng yùnshū xiéhuì shùjù xiǎnshì, jīnnián kuàjìng shāngwù hángkōng lǚkè chūxíng liàng chéngxiàn qiángjìn de fǎntán fùsū shìtóu.', 'Số liệu của Hiệp hội Vận tải Hàng không Quốc tế cho thấy lượng hành khách hàng không thương mại xuyên biên giới năm nay phục hồi bật tăng mạnh mẽ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '81457b09-1a8e-42fb-9515-994da2359498'
);

-- [含义] (hányì): hàm ý, ý nghĩa
UPDATE public.vocabularies
SET example_hanzi = '在深入研读古代哲学经典时，学者们需要结合历史社会语境来精准把握词语深层含义。',
    example_pinyin = 'Zài shēnrù yándú gǔdài zhéxué jīngdiǎn shí, xuézhě men xūyào jiéhé lìshǐ shèhuì yǔjìng lái jīngzhǔn bǎwò cíyǔ shēncéng hányì.',
    example_vi = 'Khi nghiên cứu sâu các tác phẩm triết học kinh điển cổ đại, học giả cần kết hợp ngữ cảnh lịch sử xã hội để nắm bắt chính xác hàm ý tầng sâu của từ ngữ.'
WHERE id = '25b5d3d9-6cba-430c-819f-6f5405b11c22' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '25b5d3d9-6cba-430c-819f-6f5405b11c22', '在深入研读古代哲学经典时，学者们需要结合历史社会语境来精准把握词语深层含义。', 'Zài shēnrù yándú gǔdài zhéxué jīngdiǎn shí, xuézhě men xūyào jiéhé lìshǐ shèhuì yǔjìng lái jīngzhǔn bǎwò cíyǔ shēncéng hányì.', 'Khi nghiên cứu sâu các tác phẩm triết học kinh điển cổ đại, học giả cần kết hợp ngữ cảnh lịch sử xã hội để nắm bắt chính xác hàm ý tầng sâu của từ ngữ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '25b5d3d9-6cba-430c-819f-6f5405b11c22'
);

-- [好客] (hàokè): hiếu khách
UPDATE public.vocabularies
SET example_hanzi = '热情好客的蒙古族牧民手捧洁白的哈达和醇香的马奶酒，热烈欢迎远道而来的尊贵客人。',
    example_pinyin = 'Rèqíng hàokè de Měnggǔzú mùmín shǒu pěng jiébái de hǎdá hé chúnxiāng de mǎnǎijiǔ, rèliè huānyíng yuǎndào-érlái de zūnguì kèrén.',
    example_vi = 'Những người chăn nuôi Mông Cổ nồng hậu hiếu khách hai tay nâng khăn khada trắng muốt cùng chén rượu sữa ngựa thơm nồng, nồng nhiệt chào đón quý khách từ phương xa.'
WHERE id = 'f3c5dbf6-9ee3-4ed5-b852-9047c8f7ba28' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f3c5dbf6-9ee3-4ed5-b852-9047c8f7ba28', '热情好客的蒙古族牧民手捧洁白的哈达和醇香的马奶酒，热烈欢迎远道而来的尊贵客人。', 'Rèqíng hàokè de Měnggǔzú mùmín shǒu pěng jiébái de hǎdá hé chúnxiāng de mǎnǎijiǔ, rèliè huānyíng yuǎndào-érlái de zūnguì kèrén.', 'Những người chăn nuôi Mông Cổ nồng hậu hiếu khách hai tay nâng khăn khada trắng muốt cùng chén rượu sữa ngựa thơm nồng, nồng nhiệt chào đón quý khách từ phương xa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f3c5dbf6-9ee3-4ed5-b852-9047c8f7ba28'
);

-- [毫米] (háomǐ): mi-li-mét
UPDATE public.vocabularies
SET example_hanzi = '现代智能手机芯片的制造工艺极其严苛精密，芯片线路公差甚至要精确到微米与毫米级别。',
    example_pinyin = 'Xiàndài zhìnéng shǒujī xīnpiàn de zhìzào gōngyì jíqí yánkē jīngmì, xīnpiàn xiànlù gōngchà shènzhì yào jīngquè dào wēimǐ yǔ háomǐ jíbié.',
    example_vi = 'Quy trình chế tạo chip điện thoại thông minh hiện đại cực kỳ khắt khe tinh xảo, dung sai vi mạch thậm chí phải chuẩn xác tới cấp độ mi-li-mét và micro-mét.'
WHERE id = '62aa5770-af9e-4753-bde7-bd55721918c2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '62aa5770-af9e-4753-bde7-bd55721918c2', '现代智能手机芯片的制造工艺极其严苛精密，芯片线路公差甚至要精确到微米与毫米级别。', 'Xiàndài zhìnéng shǒujī xīnpiàn de zhìzào gōngyì jíqí yánkē jīngmì, xīnpiàn xiànlù gōngchà shènzhì yào jīngquè dào wēimǐ yǔ háomǐ jíbié.', 'Quy trình chế tạo chip điện thoại thông minh hiện đại cực kỳ khắt khe tinh xảo, dung sai vi mạch thậm chí phải chuẩn xác tới cấp độ mi-li-mét và micro-mét.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '62aa5770-af9e-4753-bde7-bd55721918c2'
);

-- [毫无] (háowú): hoàn toàn không
UPDATE public.vocabularies
SET example_hanzi = '面对穷凶极恶的歹徒，英勇的人民警察毫无畏惧、挺身而出，成功保护了周围群众。',
    example_pinyin = 'Miànduì qióngxiōng-jí''è de dǎitú, yīngyǒng de rénmín jǐngchá háowú wèijù, tǐngshēn-érchū, chénggōng bǎohù le zhōuwéi qúnzhòng.',
    example_vi = 'Đối mặt với tên côn đồ hung hãn cùng đường, người cảnh sát nhân dân anh dũng hoàn toàn không hề sợ hãi, dũng cảm đứng ra bảo vệ an toàn cho quần chúng xung quanh.'
WHERE id = '8a33124b-f818-413c-bdc9-5294dba74fc5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8a33124b-f818-413c-bdc9-5294dba74fc5', '面对穷凶极恶的歹徒，英勇的人民警察毫无畏惧、挺身而出，成功保护了周围群众。', 'Miànduì qióngxiōng-jí''è de dǎitú, yīngyǒng de rénmín jǐngchá háowú wèijù, tǐngshēn-érchū, chénggōng bǎohù le zhōuwéi qúnzhòng.', 'Đối mặt với tên côn đồ hung hãn cùng đường, người cảnh sát nhân dân anh dũng hoàn toàn không hề sợ hãi, dũng cảm đứng ra bảo vệ an toàn cho quần chúng xung quanh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8a33124b-f818-413c-bdc9-5294dba74fc5'
);

-- [号召] (hàozhào): kêu gọi, hiệu triệu
UPDATE public.vocabularies
SET example_hanzi = '学校团委积极号召全校青年团员利用双休日走上街头，开展义务清扫公共街道志愿服务活动。',
    example_pinyin = 'Xuéxiào tuánwěi jījí hàozhào quánxiào qīngnián tuányuán lìyòng shuāngxiūrì zǒu shàng jiētóu, kāizhǎn yìwù qīngsǎo gōnggòng jiēdào zhìyuàn fúwù huódòng.',
    example_vi = 'Đoàn trường tích cực kêu gọi đoàn viên thanh niên toàn trường tận dụng ngày nghỉ cuối tuần xuống phố, triển khai hoạt động tình nguyện quét dọn đường phố công cộng.'
WHERE id = 'd6491f8f-85c8-4465-9b83-e0ac4c9049c1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd6491f8f-85c8-4465-9b83-e0ac4c9049c1', '学校团委积极号召全校青年团员利用双休日走上街头，开展义务清扫公共街道志愿服务活动。', 'Xuéxiào tuánwěi jījí hàozhào quánxiào qīngnián tuányuán lìyòng shuāngxiūrì zǒu shàng jiētóu, kāizhǎn yìwù qīngsǎo gōnggòng jiēdào zhìyuàn fúwù huódòng.', 'Đoàn trường tích cực kêu gọi đoàn viên thanh niên toàn trường tận dụng ngày nghỉ cuối tuần xuống phố, triển khai hoạt động tình nguyện quét dọn đường phố công cộng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd6491f8f-85c8-4465-9b83-e0ac4c9049c1'
);

-- [合并] (hébìng): sáp nhập, hợp nhất
UPDATE public.vocabularies
SET example_hanzi = '为了优化优势学科教育资源配置，这两所历史悠久的综合性名校依法合并为一所大学。',
    example_pinyin = 'Wèile yōuhuà yōushì xuékē jiàoyù zīyuán pèizhì, zhè liǎng suǒ lìshǐ yōujiǔ de zōnghéxìng míngxiào yīfǎ hébìng wèi yì suǒ dàxué.',
    example_vi = 'Nhằm tối ưu hóa phân bổ nguồn lực giáo dục các chuyên ngành thế mạnh, hai ngôi trường đại học tổng hợp lâu đời này đã sáp nhập hợp nhất thành một trường đại học.'
WHERE id = '4ccb942d-8e10-4477-98ec-9b06ba959840' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4ccb942d-8e10-4477-98ec-9b06ba959840', '为了优化优势学科教育资源配置，这两所历史悠久的综合性名校依法合并为一所大学。', 'Wèile yōuhuà yōushì xuékē jiàoyù zīyuán pèizhì, zhè liǎng suǒ lìshǐ yōujiǔ de zōnghéxìng míngxiào yīfǎ hébìng wèi yì suǒ dàxué.', 'Nhằm tối ưu hóa phân bổ nguồn lực giáo dục các chuyên ngành thế mạnh, hai ngôi trường đại học tổng hợp lâu đời này đã sáp nhập hợp nhất thành một trường đại học.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4ccb942d-8e10-4477-98ec-9b06ba959840'
);

-- [合成] (héchéng): hợp thành, tổng hợp
UPDATE public.vocabularies
SET example_hanzi = '生物医药科研攻关团队经过上万次实验筛选，终于在实验室里人工合成了这种特效抗癌靶向分子。',
    example_pinyin = 'Shēngwù yīyào kēyán gōngguān tuánduì jīngguò shàngwàn cì shíyàn shāixuǎn, zhōngyú zài shíyànshì lǐ réngōng héchéng le zhè zhǒng tèxiào kàng''ái bǎxiàng fēnzǐ.',
    example_vi = 'Đội ngũ nghiên cứu mũi nhọn dược sinh học sau hàng vạn lần thí nghiệm sàng lọc cuối cùng đã tổng hợp nhân tạo thành công phân tử đích đặc trị ung thư này trong phòng thí nghiệm.'
WHERE id = '13978627-4171-48f8-8ed1-438e5525c4ea' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '13978627-4171-48f8-8ed1-438e5525c4ea', '生物医药科研攻关团队经过上万次实验筛选，终于在实验室里人工合成了这种特效抗癌靶向分子。', 'Shēngwù yīyào kēyán gōngguān tuánduì jīngguò shàngwàn cì shíyàn shāixuǎn, zhōngyú zài shíyànshì lǐ réngōng héchéng le zhè zhǒng tèxiào kàng''ái bǎxiàng fēnzǐ.', 'Đội ngũ nghiên cứu mũi nhọn dược sinh học sau hàng vạn lần thí nghiệm sàng lọc cuối cùng đã tổng hợp nhân tạo thành công phân tử đích đặc trị ung thư này trong phòng thí nghiệm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '13978627-4171-48f8-8ed1-438e5525c4ea'
);

-- [嘿] (hēi): này, hây (thán từ)
UPDATE public.vocabularies
SET example_hanzi = '嘿，快看操场上空那只巨大的七彩巨龙风筝，飞得真高真稳当啊！',
    example_pinyin = 'Hēi, kuài kàn cāochǎng shàngkōng nà zhī jùdà de qīcǎi jùlóng fēngzheng, fēi de zhēn gāo zhēn wěndang a!',
    example_vi = 'Này, mau nhìn cánh diều rồng khổng lồ bảy sắc trên bầu trời sân vận động kìa, bay thật là cao và vững chãi biết bao!'
WHERE id = '26d0a696-4284-4945-a844-ee2aa6234fa4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '26d0a696-4284-4945-a844-ee2aa6234fa4', '嘿，快看操场上空那只巨大的七彩巨龙风筝，飞得真高真稳当啊！', 'Hēi, kuài kàn cāochǎng shàngkōng nà zhī jùdà de qīcǎi jùlóng fēngzheng, fēi de zhēn gāo zhēn wěndang a!', 'Này, mau nhìn cánh diều rồng khổng lồ bảy sắc trên bầu trời sân vận động kìa, bay thật là cao và vững chãi biết bao!', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '26d0a696-4284-4945-a844-ee2aa6234fa4'
);

-- [恨] (hèn): hận, ghét
UPDATE public.vocabularies
SET example_hanzi = '面对由于自己的粗心大意而丢失的重要科研图纸，他恨自己为什么当时没有多复核一遍。',
    example_pinyin = 'Miànduì yóuyú zìjǐ de cūxīn-dàyì ér diūshī de zhòngyào kēyán túzhǐ, tā hèn zìjǐ wèishénme dāngshí méiyǒu duō fùhé yí biàn.',
    example_vi = 'Trước bản vẽ nghiên cứu quan trọng bị đánh mất do thói sơ suất bất cẩn của mình, anh ấy tự giận hận bản thân tại sao lúc đó không chịu rà soát lại thêm một lượt.'
WHERE id = '111bf4cd-5468-43a1-8e5c-7d91155919c7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '111bf4cd-5468-43a1-8e5c-7d91155919c7', '面对由于自己的粗心大意而丢失的重要科研图纸，他恨自己为什么当时没有多复核一遍。', 'Miànduì yóuyú zìjǐ de cūxīn-dàyì ér diūshī de zhòngyào kēyán túzhǐ, tā hèn zìjǐ wèishénme dāngshí méiyǒu duō fùhé yí biàn.', 'Trước bản vẽ nghiên cứu quan trọng bị đánh mất do thói sơ suất bất cẩn của mình, anh ấy tự giận hận bản thân tại sao lúc đó không chịu rà soát lại thêm một lượt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '111bf4cd-5468-43a1-8e5c-7d91155919c7'
);

-- [横] (héng): ngang, nằm ngang
UPDATE public.vocabularies
SET example_hanzi = '在险峻的长江三峡崇山峻岭之间，一座举世瞩目的现代化悬索大桥横跨长江两岸天堑。',
    example_pinyin = 'Zài xiǎnjùn de Chángjiāng Sānxiá chóngshān-jùnlǐng zhījiān, yí zuò jǔshì-zhǔmù de xiàndàihuà xuánsuǒ dàqiáo héngkuà Chángjiāng liǎng''àn tiānqiàn.',
    example_vi = 'Giữa núi non trùng điệp hiểm trở vùng Tam Hiệp Trường Giang, một cây cầu treo hiện đại tầm cỡ thế giới bắc ngang qua eo hiểm trở nối liền đôi bờ Trường Giang.'
WHERE id = 'cf985185-1a44-404c-a2c2-90a521a1cbf6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cf985185-1a44-404c-a2c2-90a521a1cbf6', '在险峻的长江三峡崇山峻岭之间，一座举世瞩目的现代化悬索大桥横跨长江两岸天堑。', 'Zài xiǎnjùn de Chángjiāng Sānxiá chóngshān-jùnlǐng zhījiān, yí zuò jǔshì-zhǔmù de xiàndàihuà xuánsuǒ dàqiáo héngkuà Chángjiāng liǎng''àn tiānqiàn.', 'Giữa núi non trùng điệp hiểm trở vùng Tam Hiệp Trường Giang, một cây cầu treo hiện đại tầm cỡ thế giới bắc ngang qua eo hiểm trở nối liền đôi bờ Trường Giang.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cf985185-1a44-404c-a2c2-90a521a1cbf6'
);

-- [痕迹] (hénjì): dấu vết, vết tích
UPDATE public.vocabularies
SET example_hanzi = '岁月在这座千年古刹厚重的青砖红墙上留下了清晰沧桑的风雨风化痕迹。',
    example_pinyin = 'Suìyuè zài zhè zuò qiānnián gǔchà hòuzhòng de qīngzhuān hóngqiáng shang liúxià le qīngxī cāngsāng de fēngyǔ fēnghuà hénjì.',
    example_vi = 'Năm tháng đã để lại những dấu vết phong hóa mưa gió phong trần rõ nét trên bức tường gạch đỏ cổ kính dày dặn của ngôi chùa ngàn năm tuổi này.'
WHERE id = '9b84fed8-1174-4124-a73d-b3bab7dba520' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9b84fed8-1174-4124-a73d-b3bab7dba520', '岁月在这座千年古刹厚重的青砖红墙上留下了清晰沧桑的风雨风化痕迹。', 'Suìyuè zài zhè zuò qiānnián gǔchà hòuzhòng de qīngzhuān hóngqiáng shang liúxià le qīngxī cāngsāng de fēngyǔ fēnghuà hénjì.', 'Năm tháng đã để lại những dấu vết phong hóa mưa gió phong trần rõ nét trên bức tường gạch đỏ cổ kính dày dặn của ngôi chùa ngàn năm tuổi này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9b84fed8-1174-4124-a73d-b3bab7dba520'
);

-- [和平] (hépíng): hòa bình
UPDATE public.vocabularies
SET example_hanzi = '维护世界长治久安与全球持久和平，是全人类应当携手共同守护的美好共同心愿。',
    example_pinyin = 'Wéihù shìjiè chángzhì-jiǔ''ān yǔ quánqiú chíjiǔ hépíng, shì quán rénlèi yīngdāng xiéshǒu gòngtóng shǒuhù de měihǎo gòngtóng xīnyuàn.',
    example_vi = 'Gìn giữ nền thái bình lâu dài của thế giới và hòa bình bền vững toàn cầu là tâm nguyện chung tốt đẹp mà toàn thể nhân loại cần chung tay bảo vệ.'
WHERE id = 'b44bb9e0-687a-4e80-b2e6-345be2481caa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b44bb9e0-687a-4e80-b2e6-345be2481caa', '维护世界长治久安与全球持久和平，是全人类应当携手共同守护的美好共同心愿。', 'Wéihù shìjiè chángzhì-jiǔ''ān yǔ quánqiú chíjiǔ hépíng, shì quán rénlèi yīngdāng xiéshǒu gòngtóng shǒuhù de měihǎo gòngtóng xīnyuàn.', 'Gìn giữ nền thái bình lâu dài của thế giới và hòa bình bền vững toàn cầu là tâm nguyện chung tốt đẹp mà toàn thể nhân loại cần chung tay bảo vệ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b44bb9e0-687a-4e80-b2e6-345be2481caa'
);

-- [和谐] (héxié): hài hòa
UPDATE public.vocabularies
SET example_hanzi = '构建人与自然和谐共生的绿色生态文明，是实现人类社会永续健康发展的必由之路。',
    example_pinyin = 'Gòujiàn rén yǔ zìrán héxié gòngshēng de lǜsè shēngtài wénmíng, shì shíxiàn rénlèi shèhuì yǒngxù jiànkāng fāzhǎn de bìyóuzhīlù.',
    example_vi = 'Xây dựng nền văn minh sinh thái xanh con người và thiên nhiên cùng chung sống hài hòa là con đường tất yếu để xã hội loài người phát triển bền vững khỏe mạnh.'
WHERE id = 'b6465976-f0b7-4c1f-ab2d-3d03ec7a8f5f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b6465976-f0b7-4c1f-ab2d-3d03ec7a8f5f', '构建人与自然和谐共生的绿色生态文明，是实现人类社会永续健康发展的必由之路。', 'Gòujiàn rén yǔ zìrán héxié gòngshēng de lǜsè shēngtài wénmíng, shì shíxiàn rénlèi shèhuì yǒngxù jiànkāng fāzhǎn de bìyóuzhīlù.', 'Xây dựng nền văn minh sinh thái xanh con người và thiên nhiên cùng chung sống hài hòa là con đường tất yếu để xã hội loài người phát triển bền vững khỏe mạnh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b6465976-f0b7-4c1f-ab2d-3d03ec7a8f5f'
);

-- [核心] (héxīn): cốt lõi, trọng tâm
UPDATE public.vocabularies
SET example_hanzi = '自主掌握关键核心技术是保障国家高科技产业链与供应链安全自主的根本前提。',
    example_pinyin = 'Zìzhǔ zhǎngwò guānjiàn héxīn jìshù shì bǎozhàng guójiā gāokējì chǎnyèliàn yǔ gōngyìngliàn ānquán zìzhǔ de gēnběn qiántí.',
    example_vi = 'Tự chủ nắm vững công nghệ then chốt cốt lõi là tiền đề căn bản bảo đảm sự an toàn và tự chủ của chuỗi ngành nghề công nghệ cao và chuỗi cung ứng quốc gia.'
WHERE id = '9354b282-3291-48fa-bb5e-5f2fe1bfe3b2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9354b282-3291-48fa-bb5e-5f2fe1bfe3b2', '自主掌握关键核心技术是保障国家高科技产业链与供应链安全自主的根本前提。', 'Zìzhǔ zhǎngwò guānjiàn héxīn jìshù shì bǎozhàng guójiā gāokējì chǎnyèliàn yǔ gōngyìngliàn ānquán zìzhǔ de gēnběn qiántí.', 'Tự chủ nắm vững công nghệ then chốt cốt lõi là tiền đề căn bản bảo đảm sự an toàn và tự chủ của chuỗi ngành nghề công nghệ cao và chuỗi cung ứng quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9354b282-3291-48fa-bb5e-5f2fe1bfe3b2'
);

-- [洪水] (hóngshuǐ): lũ lụt
UPDATE public.vocabularies
SET example_hanzi = '汛期突降特大暴雨导致江水水位暴涨，抗洪抢险官兵日夜坚守大堤成功抵御了凶猛的洪水。',
    example_pinyin = 'Xùnqī tū jiàng tédà bàoyǔ dǎozhì jiāngshuǐ shuǐwèi bàozhǎng, kànghóng qiǎngxiǎn guānbīng rìyè jiānshǒu dàdī chénggōng dǐyù le xiōngměng de hóngshuǐ.',
    example_vi = 'Mùa lũ bất ngờ trút mưa cực lớn khiến mực nước sông dâng vọt, các chiến sĩ chống lũ ngày đêm bám trụ đê điều đã ngăn chặn thành công cơn lũ lụt hung dữ.'
WHERE id = '6635a983-4d45-48da-b985-25f22cda6c75' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6635a983-4d45-48da-b985-25f22cda6c75', '汛期突降特大暴雨导致江水水位暴涨，抗洪抢险官兵日夜坚守大堤成功抵御了凶猛的洪水。', 'Xùnqī tū jiàng tédà bàoyǔ dǎozhì jiāngshuǐ shuǐwèi bàozhǎng, kànghóng qiǎngxiǎn guānbīng rìyè jiānshǒu dàdī chénggōng dǐyù le xiōngměng de hóngshuǐ.', 'Mùa lũ bất ngờ trút mưa cực lớn khiến mực nước sông dâng vọt, các chiến sĩ chống lũ ngày đêm bám trụ đê điều đã ngăn chặn thành công cơn lũ lụt hung dữ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6635a983-4d45-48da-b985-25f22cda6c75'
);

-- [后代] (hòudài): hậu duệ, con cháu
UPDATE public.vocabularies
SET example_hanzi = '我们今天保护好这一方青山绿水与清新空气，就是为子孙后代留下一座用之不竭的绿色宝库。',
    example_pinyin = 'Wǒmen jīntiān bǎohù hǎo zhè yì fāng qīngshān-lǜshuǐ yǔ qīngxīn kōngqì, jiù shì wèi zǐsūn-hòudài liúxià yí zuò yòngzhībùjié de lǜsè bǎokù.',
    example_vi = 'Ngày hôm nay chúng ta bảo vệ tốt vùng non xanh nước biếc và bầu không khí trong lành này chính là để lại cho con cháu muôn đời sau một kho báu xanh vô tận.'
WHERE id = 'eb0183ef-f47e-43c0-8abd-a275c2dee211' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'eb0183ef-f47e-43c0-8abd-a275c2dee211', '我们今天保护好这一方青山绿水与清新空气，就是为子孙后代留下一座用之不竭的绿色宝库。', 'Wǒmen jīntiān bǎohù hǎo zhè yì fāng qīngshān-lǜshuǐ yǔ qīngxīn kōngqì, jiù shì wèi zǐsūn-hòudài liúxià yí zuò yòngzhībùjié de lǜsè bǎokù.', 'Ngày hôm nay chúng ta bảo vệ tốt vùng non xanh nước biếc và bầu không khí trong lành này chính là để lại cho con cháu muôn đời sau một kho báu xanh vô tận.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'eb0183ef-f47e-43c0-8abd-a275c2dee211'
);

-- [壶] (hú): ấm, bình
UPDATE public.vocabularies
SET example_hanzi = '冬日午后坐在暖阳下的窗前，泡上一壶清香四溢的西湖龙井茶，令人心旷神怡。',
    example_pinyin = 'Dōngrì wǔhòu zuò zài nuǎnyáng xià de chuāngqián, pào shang yì hú qīngxiāng-sìyì de Xīhú Lóngjǐng chá, lìngrén xīnkuàng-shényí.',
    example_vi = 'Chiều mùa đông ngồi bên khung cửa sổ dưới nắng ấm, pha một ấm trà Long Tỉnh Tây Hồ thơm ngát bốn phương khiến tâm hồn sảng khoái thư thái.'
WHERE id = 'd417173c-c754-451c-9e32-b19c8a72a580' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd417173c-c754-451c-9e32-b19c8a72a580', '冬日午后坐在暖阳下的窗前，泡上一壶清香四溢的西湖龙井茶，令人心旷神怡。', 'Dōngrì wǔhòu zuò zài nuǎnyáng xià de chuāngqián, pào shang yì hú qīngxiāng-sìyì de Xīhú Lóngjǐng chá, lìngrén xīnkuàng-shényí.', 'Chiều mùa đông ngồi bên khung cửa sổ dưới nắng ấm, pha một ấm trà Long Tỉnh Tây Hồ thơm ngát bốn phương khiến tâm hồn sảng khoái thư thái.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd417173c-c754-451c-9e32-b19c8a72a580'
);

-- [忽略] (hū lüè): bỏ qua, lơ là
UPDATE public.vocabularies
SET example_hanzi = '在进行复杂的精密工程力学计算时，哪怕是千万分之一的数据微小误差也绝对不可忽略。',
    example_pinyin = 'Zài jìnxíng fùzá de jīngmì gōngchéng lìxué jìsuàn shí, nǎpà shì qiānwàn fēnzhī yī de shùjù wēixiǎo wùchā yě juéduì bùkě hūlüè.',
    example_vi = 'Khi tiến hành tính toán cơ học công trình chính xác phức tạp, dẫu là sai số dữ liệu cực nhỏ một phần mười triệu cũng tuyệt đối không được bỏ qua sơ suất.'
WHERE id = 'cd065090-2321-46e3-ae43-208ca177791c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cd065090-2321-46e3-ae43-208ca177791c', '在进行复杂的精密工程力学计算时，哪怕是千万分之一的数据微小误差也绝对不可忽略。', 'Zài jìnxíng fùzá de jīngmì gōngchéng lìxué jìsuàn shí, nǎpà shì qiānwàn fēnzhī yī de shùjù wēixiǎo wùchā yě juéduì bùkě hūlüè.', 'Khi tiến hành tính toán cơ học công trình chính xác phức tạp, dẫu là sai số dữ liệu cực nhỏ một phần mười triệu cũng tuyệt đối không được bỏ qua sơ suất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cd065090-2321-46e3-ae43-208ca177791c'
);

-- [划分] (huàfēn): phân chia, phân định
UPDATE public.vocabularies
SET example_hanzi = '根据地貌特征与水热资源分布，地理学家将全国国土科学划分为数个不同的大型气候生态区。',
    example_pinyin = 'Gēnjù dìmào tèzhēng yǔ shuǐrè zīyuán fēnbù, dìlǐxuéjiā jiāng quánguó guótǔ kēxué huàfēn wèi shù gè bùtóng de dàxíng qìhòu shēngtài qū.',
    example_vi = 'Căn cứ theo đặc trưng địa mạo và phân bố nguồn tài nguyên nhiệt ẩm, các nhà địa lý đã phân chia khoa học lãnh thổ đất nước thành nhiều vùng sinh thái khí hậu lớn khác nhau.'
WHERE id = 'e6e959ee-a114-4a9f-a9b4-b82e05793891' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e6e959ee-a114-4a9f-a9b4-b82e05793891', '根据地貌特征与水热资源分布，地理学家将全国国土科学划分为数个不同的大型气候生态区。', 'Gēnjù dìmào tèzhēng yǔ shuǐrè zīyuán fēnbù, dìlǐxuéjiā jiāng quánguó guótǔ kēxué huàfēn wèi shù gè bùtóng de dàxíng qìhòu shēngtài qū.', 'Căn cứ theo đặc trưng địa mạo và phân bố nguồn tài nguyên nhiệt ẩm, các nhà địa lý đã phân chia khoa học lãnh thổ đất nước thành nhiều vùng sinh thái khí hậu lớn khác nhau.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e6e959ee-a114-4a9f-a9b4-b82e05793891'
);

-- [怀念] (huáiniàn): hoài niệm, nhớ nhung
UPDATE public.vocabularies
SET example_hanzi = '漫步在阔别多年的母校林荫小道上，他格外怀念当年与同窗好友挑灯夜读的青春时光。',
    example_pinyin = 'Mànbù zài kuòbié duō nián de mǔxiào línyīn xiǎodào shang, tā géwài huáiniàn dāngnián yǔ tóngchuāng hǎoyǒu tiǎodēng-yèdú de qīngchūn shíguāng.',
    example_vi = 'Tản bộ trên con đường rợp bóng cây của trường xưa sau nhiều năm xa cách, anh ấy vô cùng hoài niệm nhớ nhung tháng ngày thanh xuân thắp đèn thức thâu đêm đọc sách cùng bạn bè.'
WHERE id = 'ce3d70bc-6ff3-4f76-9a96-26132b6d78af' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ce3d70bc-6ff3-4f76-9a96-26132b6d78af', '漫步在阔别多年的母校林荫小道上，他格外怀念当年与同窗好友挑灯夜读的青春时光。', 'Mànbù zài kuòbié duō nián de mǔxiào línyīn xiǎodào shang, tā géwài huáiniàn dāngnián yǔ tóngchuāng hǎoyǒu tiǎodēng-yèdú de qīngchūn shíguāng.', 'Tản bộ trên con đường rợp bóng cây của trường xưa sau nhiều năm xa cách, anh ấy vô cùng hoài niệm nhớ nhung tháng ngày thanh xuân thắp đèn thức thâu đêm đọc sách cùng bạn bè.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ce3d70bc-6ff3-4f76-9a96-26132b6d78af'
);

-- [怀孕] (huáiyùn): mang thai
UPDATE public.vocabularies
SET example_hanzi = '女性在怀孕期间应当保持愉悦平和的心情，定期前往妇产科医院进行科学的孕期检查。',
    example_pinyin = 'Nǚxìng zài huáiyùn qījiān yīngdāng bǎochí yúyuè pínghé de xīnqíng, dìngqī qiánwǎng fùchǎnkē yīyuàn jìnxíng kēxué de yùnqī jiǎnchá.',
    example_vi = 'Phụ nữ trong thời kỳ mang thai nên giữ tâm trạng vui vẻ nhẹ nhõm, định kỳ đến bệnh viện phụ sản tiến hành khám thai khoa học.'
WHERE id = '1a565556-82e1-42a8-9eef-e34f688d5752' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1a565556-82e1-42a8-9eef-e34f688d5752', '女性在怀孕期间应当保持愉悦平和的心情，定期前往妇产科医院进行科学的孕期检查。', 'Nǚxìng zài huáiyùn qījiān yīngdāng bǎochí yúyuè pínghé de xīnqíng, dìngqī qiánwǎng fùchǎnkē yīyuàn jìnxíng kēxué de yùnqī jiǎnchá.', 'Phụ nữ trong thời kỳ mang thai nên giữ tâm trạng vui vẻ nhẹ nhõm, định kỳ đến bệnh viện phụ sản tiến hành khám thai khoa học.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1a565556-82e1-42a8-9eef-e34f688d5752'
);

-- [患者] (huàn zhě): bệnh nhân
UPDATE public.vocabularies
SET example_hanzi = '白衣天使们以高度的仁爱之心和精湛的专业医术，悉心救治每一位身患重病的危急患者。',
    example_pinyin = 'Báiyī tiānshǐ men yǐ gāodù de rén''ài zhī xīn hé jīngzhàn de zhuānyè yīshù, xīxīn jiùzhì měi yí wèi shēnhuàn zhòngbìng de wēijí huànzhě.',
    example_vi = 'Những thiên thần áo trắng với tấm lòng nhân từ cao cả và y thuật tinh xảo chuyên nghiệp đã tận tâm cứu chữa từng bệnh nhân nguy kịch mang trọng bệnh.'
WHERE id = '26e0f0fc-3048-4e92-93a0-8b6be8dcc25f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '26e0f0fc-3048-4e92-93a0-8b6be8dcc25f', '白衣天使们以高度的仁爱之心和精湛的专业医术，悉心救治每一位身患重病的危急患者。', 'Báiyī tiānshǐ men yǐ gāodù de rén''ài zhī xīn hé jīngzhàn de zhuānyè yīshù, xīxīn jiùzhì měi yí wèi shēnhuàn zhòngbìng de wēijí huànzhě.', 'Những thiên thần áo trắng với tấm lòng nhân từ cao cả và y thuật tinh xảo chuyên nghiệp đã tận tâm cứu chữa từng bệnh nhân nguy kịch mang trọng bệnh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '26e0f0fc-3048-4e92-93a0-8b6be8dcc25f'
);

-- [皇帝] (huángdì): hoàng đế
UPDATE public.vocabularies
SET example_hanzi = '秦始皇作为中国历史上第一位统一六国并确立中央集权制度的皇帝，对历史进程产生了深远影响。',
    example_pinyin = 'Qín Shǐhuáng zuòwéi Zhōngguó lìshǐ shang dì-yī wèi tǒngyī liù guó bìng quèlì zhōngyāng jíquán zhìdù de huángdì, duì lìshǐ jìnchéng chǎnshēng le shēnyuǎn yǐngxiǎng.',
    example_vi = 'Tần Thủy Hoàng với tư cách là vị hoàng đế đầu tiên thống nhất sáu nước và xác lập chế độ tập quyền trung ương trong lịch sử Trung Quốc đã tạo ảnh hưởng sâu rộng tới tiến trình lịch sử.'
WHERE id = 'ed05f081-2328-4575-9963-d21ac5b8d941' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ed05f081-2328-4575-9963-d21ac5b8d941', '秦始皇作为中国历史上第一位统一六国并确立中央集权制度的皇帝，对历史进程产生了深远影响。', 'Qín Shǐhuáng zuòwéi Zhōngguó lìshǐ shang dì-yī wèi tǒngyī liù guó bìng quèlì zhōngyāng jíquán zhìdù de huángdì, duì lìshǐ jìnchéng chǎnshēng le shēnyuǎn yǐngxiǎng.', 'Tần Thủy Hoàng với tư cách là vị hoàng đế đầu tiên thống nhất sáu nước và xác lập chế độ tập quyền trung ương trong lịch sử Trung Quốc đã tạo ảnh hưởng sâu rộng tới tiến trình lịch sử.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ed05f081-2328-4575-9963-d21ac5b8d941'
);

-- [欢乐] (huānlè): vui vẻ, hân hoan
UPDATE public.vocabularies
SET example_hanzi = '大型儿童游乐场里到处回荡着孩子们的欢声笑语，整个园区沉浸在无比欢乐的节日气氛中。',
    example_pinyin = 'Dàxíng értóng yóulèchǎng lǐ dàochù huídàng zhe háizi men de huānshēng-xiàoyǔ, zhěng gè yuánqū chénjìn zài wúbǐ huānlè de jiérì qìfēn zhōng.',
    example_vi = 'Trong công viên vui chơi giải trí trẻ em cỡ lớn vang vọng tiếng cười nói rộn rã của lũ trẻ, cả khuôn viên chìm đắm trong không khí lễ hội vui vẻ hân hoan khôn xiết.'
WHERE id = '898a5861-ee19-4576-afc6-807968776c70' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '898a5861-ee19-4576-afc6-807968776c70', '大型儿童游乐场里到处回荡着孩子们的欢声笑语，整个园区沉浸在无比欢乐的节日气氛中。', 'Dàxíng értóng yóulèchǎng lǐ dàochù huídàng zhe háizi men de huānshēng-xiàoyǔ, zhěng gè yuánqū chénjìn zài wúbǐ huānlè de jiérì qìfēn zhōng.', 'Trong công viên vui chơi giải trí trẻ em cỡ lớn vang vọng tiếng cười nói rộn rã của lũ trẻ, cả khuôn viên chìm đắm trong không khí lễ hội vui vẻ hân hoan khôn xiết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '898a5861-ee19-4576-afc6-807968776c70'
);

-- [幻想] (huànxiǎng): ảo tưởng, mơ tưởng
UPDATE public.vocabularies
SET example_hanzi = '脚踏实地的成功需要依靠日复一日的勤奋拼搏，绝不能把人生寄托在不切实际的空洞幻想之上。',
    example_pinyin = 'Jiǎotà-shídì de chénggōng xūyào yīkào rìfùyírì de qínfèn pīnbó, jué bùnéng bǎ rénshēng jìtuō zài búqiè-shíjì de kōngdòng huànxiǎng zhī shàng.',
    example_vi = 'Thành công thực tế vững chắc cần dựa vào sự cần cù nỗ lực phấn đấu ngày này qua tháng khác, tuyệt đối không thể gửi gắm cuộc đời vào những ảo tưởng viển vông phi thực tế.'
WHERE id = '6a56e1d8-3332-4dbe-af28-83c184ae4d5a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6a56e1d8-3332-4dbe-af28-83c184ae4d5a', '脚踏实地的成功需要依靠日复一日的勤奋拼搏，绝不能把人生寄托在不切实际的空洞幻想之上。', 'Jiǎotà-shídì de chénggōng xūyào yīkào rìfùyírì de qínfèn pīnbó, jué bùnéng bǎ rénshēng jìtuō zài búqiè-shíjì de kōngdòng huànxiǎng zhī shàng.', 'Thành công thực tế vững chắc cần dựa vào sự cần cù nỗ lực phấn đấu ngày này qua tháng khác, tuyệt đối không thể gửi gắm cuộc đời vào những ảo tưởng viển vông phi thực tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6a56e1d8-3332-4dbe-af28-83c184ae4d5a'
);

-- [还原] (huányuán): khôi phục, hoàn nguyên
UPDATE public.vocabularies
SET example_hanzi = '考古学家利用先进的三维激光扫描与虚拟现实技术，生动还原了这处千年古代遗址的历史原貌。',
    example_pinyin = 'Kǎogǔxuéjiā lìyòng xiānjìn de sānwéi jīguāng sǎomiáo yǔ xūnǐ xiànshí jìshù, shēngdòng huányuán le zhè chù qiānnián gǔdài yízhǐ de lìshǐ yuánmào.',
    example_vi = 'Các nhà khảo cổ học sử dụng công nghệ quét laser 3D và thực tế ảo tiên tiến đã khôi phục hoàn nguyên sinh động diện mạo lịch sử ban đầu của di chỉ cổ đại ngàn năm này.'
WHERE id = '0afda2c9-5390-43e2-b221-ad692a8b882c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0afda2c9-5390-43e2-b221-ad692a8b882c', '考古学家利用先进的三维激光扫描与虚拟现实技术，生动还原了这处千年古代遗址的历史原貌。', 'Kǎogǔxuéjiā lìyòng xiānjìn de sānwéi jīguāng sǎomiáo yǔ xūnǐ xiànshí jìshù, shēngdòng huányuán le zhè chù qiānnián gǔdài yízhǐ de lìshǐ yuánmào.', 'Các nhà khảo cổ học sử dụng công nghệ quét laser 3D và thực tế ảo tiên tiến đã khôi phục hoàn nguyên sinh động diện mạo lịch sử ban đầu của di chỉ cổ đại ngàn năm này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0afda2c9-5390-43e2-b221-ad692a8b882c'
);

-- [花生] (huāshēng): củ lạc, đậu phộng
UPDATE public.vocabularies
SET example_hanzi = '北方农家的小院晒谷场上，老奶奶正在挑选刚从地里挖出晾干的新鲜花生果。',
    example_pinyin = 'Běifāng nóngjiā de xiǎoyuàn shàigǔchǎng shang, lǎonǎinai zhèngzài tiāoxuǎn gāng cóng dì lǐ wā chū liànggān de xīnxiān huāshēng guǒ.',
    example_vi = 'Trên sân phơi thóc trong góc sân nhỏ nhà nông miền bắc, bà cụ đang tỉ mỉ chọn lựa những củ lạc tươi vừa mới đào ngoài ruộng phơi khô.'
WHERE id = 'c6c1a446-0254-44bd-827a-049a188f03b8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c6c1a446-0254-44bd-827a-049a188f03b8', '北方农家的小院晒谷场上，老奶奶正在挑选刚从地里挖出晾干的新鲜花生果。', 'Běifāng nóngjiā de xiǎoyuàn shàigǔchǎng shang, lǎonǎinai zhèngzài tiāoxuǎn gāng cóng dì lǐ wā chū liànggān de xīnxiān huāshēng guǒ.', 'Trên sân phơi thóc trong góc sân nhỏ nhà nông miền bắc, bà cụ đang tỉ mỉ chọn lựa những củ lạc tươi vừa mới đào ngoài ruộng phơi khô.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c6c1a446-0254-44bd-827a-049a188f03b8'
);

-- [化石] (huàshí): hóa thạch
UPDATE public.vocabularies
SET example_hanzi = '地质古生物科考队在黄土高原陡峭的地层岩壁中，惊喜地发现了一批保存完好的远古三叶虫化石。',
    example_pinyin = 'Dìzhì gǔ-shēngwù kěkǎoduì zài huángtǔ gāoyuán dǒuqiào de dìcéng yánbì zhōng, jīngxǐ de fāxiàn le yì pī bǎocún wánhǎo de yuǎngǔ sānyèchóng huàshí.',
    example_vi = 'Đoàn khảo sát cổ sinh vật địa chất trên vách đá tầng đất dốc đứng của cao nguyên Hoàng Thổ đã vui mừng phát hiện một lô hóa thạch bọ ba thùy thời cổ đại được bảo tồn nguyên vẹn.'
WHERE id = '689c73e7-5289-4b0c-b045-919c50c82112' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '689c73e7-5289-4b0c-b045-919c50c82112', '地质古生物科考队在黄土高原陡峭的地层岩壁中，惊喜地发现了一批保存完好的远古三叶虫化石。', 'Dìzhì gǔ-shēngwù kěkǎoduì zài huángtǔ gāoyuán dǒuqiào de dìcéng yánbì zhōng, jīngxǐ de fāxiàn le yì pī bǎocún wánhǎo de yuǎngǔ sānyèchóng huàshí.', 'Đoàn khảo sát cổ sinh vật địa chất trên vách đá tầng đất dốc đứng của cao nguyên Hoàng Thổ đã vui mừng phát hiện một lô hóa thạch bọ ba thùy thời cổ đại được bảo tồn nguyên vẹn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '689c73e7-5289-4b0c-b045-919c50c82112'
);

-- [话筒] (huàtǒng): ống nghe, micro
UPDATE public.vocabularies
SET example_hanzi = '国际新闻发布会上，来自世界各地的主流媒体记者排队走到话筒前，踊跃举手提问。',
    example_pinyin = 'Guójì xīnwén fābùhuì shang, láizì shìjiè gèdì de zhǔliú méitǐ jìzhě páiduì zǒu dào huàtǒng qián, yǒngyuè jǔshǒu tíwèn.',
    example_vi = 'Tại buổi họp báo quốc tế, các phóng viên báo chí chủ lưu đến từ khắp nơi trên thế giới đã xếp hàng bước tới trước micro hăng hái giơ tay đặt câu hỏi.'
WHERE id = 'efaf9da6-7b59-4c83-9c9c-7c7da7be4a90' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'efaf9da6-7b59-4c83-9c9c-7c7da7be4a90', '国际新闻发布会上，来自世界各地的主流媒体记者排队走到话筒前，踊跃举手提问。', 'Guójì xīnwén fābùhuì shang, láizì shìjiè gèdì de zhǔliú méitǐ jìzhě páiduì zǒu dào huàtǒng qián, yǒngyuè jǔshǒu tíwèn.', 'Tại buổi họp báo quốc tế, các phóng viên báo chí chủ lưu đến từ khắp nơi trên thế giới đã xếp hàng bước tới trước micro hăng hái giơ tay đặt câu hỏi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'efaf9da6-7b59-4c83-9c9c-7c7da7be4a90'
);

-- [化妆] (huàzhuāng): trang điểm
UPDATE public.vocabularies
SET example_hanzi = '在登台参加全国青年民族舞蹈大赛之前，专业化妆造型师为每一位舞蹈演员化上了精致的舞台妆容。',
    example_pinyin = 'Zài dēngtái cānjiā quánguó qīngnián mínzú wǔdǎo dàsài zhīqián, zhuānyè huàzhuāng zàoxíngshī wèi měi yí wèi wǔdǎo yǎnyuán huà shang le jīngzhì de wǔtái zhuāngróng.',
    example_vi = 'Trước khi bước lên sân khấu tham dự cuộc thi múa dân tộc thanh niên toàn quốc, chuyên gia tạo hình trang điểm đã trang điểm khuôn mặt sân khấu tinh xảo cho từng diễn viên.'
WHERE id = '7edfed46-1f0e-48de-a73f-4c775c9fc5a2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7edfed46-1f0e-48de-a73f-4c775c9fc5a2', '在登台参加全国青年民族舞蹈大赛之前，专业化妆造型师为每一位舞蹈演员化上了精致的舞台妆容。', 'Zài dēngtái cānjiā quánguó qīngnián mínzú wǔdǎo dàsài zhīqián, zhuānyè huàzhuāng zàoxíngshī wèi měi yí wèi wǔdǎo yǎnyuán huà shang le jīngzhì de wǔtái zhuāngróng.', 'Trước khi bước lên sân khấu tham dự cuộc thi múa dân tộc thanh niên toàn quốc, chuyên gia tạo hình trang điểm đã trang điểm khuôn mặt sân khấu tinh xảo cho từng diễn viên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7edfed46-1f0e-48de-a73f-4c775c9fc5a2'
);

-- [回报] (huíbào): đáp lại, báo đáp
UPDATE public.vocabularies
SET example_hanzi = '许多走出贫困大山的优秀学子学成归来后，主动选择返乡创业以回报家乡父老的养育之恩。',
    example_pinyin = 'Xǔduō zǒuchū pínkùn dàshān de yōuxiù xuézǐ xuéchéng guīlái hòu, zhǔdòng xuǎnzé fǎnxiāng chuàngyè yǐ huíbào jiāxiāng fùlǎo de yǎngyù zhī ēn.',
    example_vi = 'Nhiều người con ưu tú sau khi học xong trở về từ chốn núi sâu nghèo khó đã chủ động chọn lập nghiệp tại quê nhà để đền đáp công ơn nuôi dưỡng của bà con lối xóm.'
WHERE id = '8e27ac40-8b2a-41ff-b279-95ac31c51813' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8e27ac40-8b2a-41ff-b279-95ac31c51813', '许多走出贫困大山的优秀学子学成归来后，主动选择返乡创业以回报家乡父老的养育之恩。', 'Xǔduō zǒuchū pínkùn dàshān de yōuxiù xuézǐ xuéchéng guīlái hòu, zhǔdòng xuǎnzé fǎnxiāng chuàngyè yǐ huíbào jiāxiāng fùlǎo de yǎngyù zhī ēn.', 'Nhiều người con ưu tú sau khi học xong trở về từ chốn núi sâu nghèo khó đã chủ động chọn lập nghiệp tại quê nhà để đền đáp công ơn nuôi dưỡng của bà con lối xóm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8e27ac40-8b2a-41ff-b279-95ac31c51813'
);

-- [汇报] (huìbào): báo cáo
UPDATE public.vocabularies
SET example_hanzi = '项目研发总监在季度工作总结会议上，向集团高层详细汇报了新一代智能终端的核心技术突破。',
    example_pinyin = 'Xiàngmù yánfā zǒngjiān zài jìdù gōngzuò zǒngjié huìyì shang, xiàng jítuán gāocéng xiángxì huìbào le xīn yídài zhìnéng zhōngduān de héxīn jìshù tūpò.',
    example_vi = 'Giám đốc R&D dự án trong cuộc họp tổng kết công tác quý đã báo cáo chi tiết với ban lãnh đạo tập đoàn về những đột phá công nghệ cốt lõi của thiết bị đầu cuối thông minh thế hệ mới.'
WHERE id = '021a66e4-9b0c-49e9-8cd1-f0061bc183e3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '021a66e4-9b0c-49e9-8cd1-f0061bc183e3', '项目研发总监在季度工作总结会议上，向集团高层详细汇报了新一代智能终端的核心技术突破。', 'Xiàngmù yánfā zǒngjiān zài jìdù gōngzuò zǒngjié huìyì shang, xiàng jítuán gāocéng xiángxì huìbào le xīn yídài zhìnéng zhōngduān de héxīn jìshù tūpò.', 'Giám đốc R&D dự án trong cuộc họp tổng kết công tác quý đã báo cáo chi tiết với ban lãnh đạo tập đoàn về những đột phá công nghệ cốt lõi của thiết bị đầu cuối thông minh thế hệ mới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '021a66e4-9b0c-49e9-8cd1-f0061bc183e3'
);

-- [灰尘] (huīchén): bụi bặm
UPDATE public.vocabularies
SET example_hanzi = '书房角落里那个常年未曾打开的旧书柜上落满了厚厚一层灰尘，需要彻底擦洗打扫。',
    example_pinyin = 'Shūfáng jiǎoluò lǐ nà gè chángnián wèicéng dǎkāi de jiù shūguì shang luò mǎn le hòuhòu yì céng huīchén, xūyào chèdǐ cāxǐ dǎsǎo.',
    example_vi = 'Chiếc tủ sách cũ nhiều năm chưa từng mở ra ở góc phòng đọc sách phủ đầy một lớp bụi bặm dày đặc, cần phải lau chùi quét dọn triệt để.'
WHERE id = 'd793ee2e-0a97-4967-ae23-69681903e791' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd793ee2e-0a97-4967-ae23-69681903e791', '书房角落里那个常年未曾打开的旧书柜上落满了厚厚一层灰尘，需要彻底擦洗打扫。', 'Shūfáng jiǎoluò lǐ nà gè chángnián wèicéng dǎkāi de jiù shūguì shang luò mǎn le hòuhòu yì céng huīchén, xūyào chèdǐ cāxǐ dǎsǎo.', 'Chiếc tủ sách cũ nhiều năm chưa từng mở ra ở góc phòng đọc sách phủ đầy một lớp bụi bặm dày đặc, cần phải lau chùi quét dọn triệt để.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd793ee2e-0a97-4967-ae23-69681903e791'
);

-- [回顾] (huígù): nhìn lại, hồi tưởng
UPDATE public.vocabularies
SET example_hanzi = '回顾人类科学技术发展的漫长历史长河，每一次产业革命都深刻改变了全球经济社会面貌。',
    example_pinyin = 'Huígù rénlèi kēxué jìshù fāzhǎn de màncháng lìshǐ chánghé, měi yí cì chǎnyè gémìng dōu shēnkè gǎibiàn le quánqiú jīngjì shèhuì miànmào.',
    example_vi = 'Nhìn lại dòng chảy lịch sử dài dằng dặc của sự phát triển khoa học công nghệ loài người, mỗi một cuộc cách mạng công nghiệp đều làm thay đổi sâu sắc diện mạo kinh tế xã hội toàn cầu.'
WHERE id = 'e3f104a7-50db-41ca-af93-1546b72bfe25' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e3f104a7-50db-41ca-af93-1546b72bfe25', '回顾人类科学技术发展的漫长历史长河，每一次产业革命都深刻改变了全球经济社会面貌。', 'Huígù rénlèi kēxué jìshù fāzhǎn de màncháng lìshǐ chánghé, měi yí cì chǎnyè gémìng dōu shēnkè gǎibiàn le quánqiú jīngjì shèhuì miànmào.', 'Nhìn lại dòng chảy lịch sử dài dằng dặc của sự phát triển khoa học công nghệ loài người, mỗi một cuộc cách mạng công nghiệp đều làm thay đổi sâu sắc diện mạo kinh tế xã hội toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e3f104a7-50db-41ca-af93-1546b72bfe25'
);

-- [灰心] (huīxīn): nản lòng, nản chí
UPDATE public.vocabularies
SET example_hanzi = '面对科研攻关道路上的暂时困难与挫折，我们应当振作精神、总结经验，绝不可轻言放弃或丧气灰心。',
    example_pinyin = 'Miànduì kēyán gōngguān dàolù shang de zànshí kùnnan yǔ cuòzhé, wǒmen yīngdāng zhènzuò jīngshén, zǒngjié jīngyàn, jué bùkě qīngyán fàngqì huò sàngqì huīxīn.',
    example_vi = 'Trước những khó khăn và trắc trở tạm thời trên đường nghiên cứu khoa học, chúng ta nên xốc lại tinh thần, đúc rút kinh nghiệm, tuyệt đối không được dễ dàng từ bỏ hay nản chí ngã lòng.'
WHERE id = 'fe308fbd-43e8-414a-8e8e-da00edc3bad4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fe308fbd-43e8-414a-8e8e-da00edc3bad4', '面对科研攻关道路上的暂时困难与挫折，我们应当振作精神、总结经验，绝不可轻言放弃或丧气灰心。', 'Miànduì kēyán gōngguān dàolù shang de zànshí kùnnan yǔ cuòzhé, wǒmen yīngdāng zhènzuò jīngshén, zǒngjié jīngyàn, jué bùkě qīngyán fàngqì huò sàngqì huīxīn.', 'Trước những khó khăn và trắc trở tạm thời trên đường nghiên cứu khoa học, chúng ta nên xốc lại tinh thần, đúc rút kinh nghiệm, tuyệt đối không được dễ dàng từ bỏ hay nản chí ngã lòng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fe308fbd-43e8-414a-8e8e-da00edc3bad4'
);

-- [混合] (hùnhé): hỗn hợp, pha trộn
UPDATE public.vocabularies
SET example_hanzi = '根据特种水泥材料配比要求，施工人员将砂石、水泥与特种防水胶水按照精确比例充分混合均匀。',
    example_pinyin = 'Gēnjù tèzhǒng shuǐní cáiliào pèibǐ yāoqiú, shīgōng rényuán jiāng shāshí, shuǐní yǔ tèzhǒng fángshuǐ jiāoshuǐ ànzhào jīngquè bǐlì chōngfèn hùnhé jūnyún.',
    example_vi = 'Theo yêu cầu cấp phối vật liệu xi măng đặc chủng, nhân viên thi công đã pha trộn hỗn hợp cát đá, xi măng cùng keo chống thấm đặc chủng theo tỷ lệ chuẩn xác một cách đồng đều.'
WHERE id = '9b8feb45-6ec2-472a-8029-925e57c74c37' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9b8feb45-6ec2-472a-8029-925e57c74c37', '根据特种水泥材料配比要求，施工人员将砂石、水泥与特种防水胶水按照精确比例充分混合均匀。', 'Gēnjù tèzhǒng shuǐní cáiliào pèibǐ yāoqiú, shīgōng rényuán jiāng shāshí, shuǐní yǔ tèzhǒng fángshuǐ jiāoshuǐ ànzhào jīngquè bǐlì chōngfèn hùnhé jūnyún.', 'Theo yêu cầu cấp phối vật liệu xi măng đặc chủng, nhân viên thi công đã pha trộn hỗn hợp cát đá, xi măng cùng keo chống thấm đặc chủng theo tỷ lệ chuẩn xác một cách đồng đều.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9b8feb45-6ec2-472a-8029-925e57c74c37'
);

-- [混乱] (hùnluàn): hỗn loạn, lộn xộn
UPDATE public.vocabularies
SET example_hanzi = '突发电网短路导致城市十字路口交通信号灯全部熄灭，交警迅速赶往现场指挥交通以防秩序混乱。',
    example_pinyin = 'Tūfā diànwǎng duǎnlù dǎozhì chéngshì shízì lùkǒu jiāotōng xìnhàodēng quánbù xīmiè, jiāojǐng xùnsù gǎnwǎng xiànchǎng zhǐhuī jiāotōng yǐ fáng zhìxù hùnluàn.',
    example_vi = 'Lưới điện bị đoản mạch bất ngờ khiến toàn bộ đèn tín hiệu giao thông ngã tư thành phố bị tắt lịm, cảnh sát giao thông đã tức tốc tới hiện trường điều tiết để tránh hỗn loạn trật tự.'
WHERE id = 'b861c53e-150b-420c-8dd3-5a1257491e57' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b861c53e-150b-420c-8dd3-5a1257491e57', '突发电网短路导致城市十字路口交通信号灯全部熄灭，交警迅速赶往现场指挥交通以防秩序混乱。', 'Tūfā diànwǎng duǎnlù dǎozhì chéngshì shízì lùkǒu jiāotōng xìnhàodēng quánbù xīmiè, jiāojǐng xùnsù gǎnwǎng xiànchǎng zhǐhuī jiāotōng yǐ fáng zhìxù hùnluàn.', 'Lưới điện bị đoản mạch bất ngờ khiến toàn bộ đèn tín hiệu giao thông ngã tư thành phố bị tắt lịm, cảnh sát giao thông đã tức tốc tới hiện trường điều tiết để tránh hỗn loạn trật tự.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b861c53e-150b-420c-8dd3-5a1257491e57'
);

-- [婚姻] (hūnyīn): hôn nhân
UPDATE public.vocabularies
SET example_hanzi = '美满幸福的婚姻家庭生活建立在夫妻双方彼此忠诚、相互尊重与同甘共苦的深厚感情基石之上。',
    example_pinyin = 'Měimǎn xìngfú de hūnyīn jiātíng shēnghuó jiànlì zài fūqī shuāngfāng bǐcǐ zhōngchéng, xiānghù zūnzhòng yǔ tónggān-gòngkǔ de shēnhòu gǎnqíng jīshí zhī shàng.',
    example_vi = 'Cuộc sống hôn nhân gia đình mỹ mãn hạnh phúc được xây dựng trên nền tảng tình cảm sâu sắc của hai vợ chồng cùng chung thủy, tôn trọng lẫn nhau và đồng cam cộng khổ.'
WHERE id = 'e2d9057c-e2d3-4171-93a5-6cdfba25ef3e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e2d9057c-e2d3-4171-93a5-6cdfba25ef3e', '美满幸福的婚姻家庭生活建立在夫妻双方彼此忠诚、相互尊重与同甘共苦的深厚感情基石之上。', 'Měimǎn xìngfú de hūnyīn jiātíng shēnghuó jiànlì zài fūqī shuāngfāng bǐcǐ zhōngchéng, xiānghù zūnzhòng yǔ tónggān-gòngkǔ de shēnhòu gǎnqíng jīshí zhī shàng.', 'Cuộc sống hôn nhân gia đình mỹ mãn hạnh phúc được xây dựng trên nền tảng tình cảm sâu sắc của hai vợ chồng cùng chung thủy, tôn trọng lẫn nhau và đồng cam cộng khổ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e2d9057c-e2d3-4171-93a5-6cdfba25ef3e'
);

-- [货币] (huòbì): tiền tệ
UPDATE public.vocabularies
SET example_hanzi = '随着数字信息金融科技的快速演进，数字化法定数字货币正在全球许多国家试点推广应用。',
    example_pinyin = 'Suízhe shùzì xìnxī jīnróng kējì de kuàisù yǎnjìn, shùzìhuà fǎdìng shùzì huòbì zhèngzài quánqiú xǔduō guójiā shìdiǎn tuīguǎng yìngyòng.',
    example_vi = 'Cùng với sự phát triển nhanh chóng của công nghệ tài chính thông tin số, tiền tệ kỹ thuật số pháp định đang được thí điểm mở rộng ứng dụng tại nhiều quốc gia trên toàn cầu.'
WHERE id = '3a6bc156-e239-4fa3-b716-1c1a5e42f179' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3a6bc156-e239-4fa3-b716-1c1a5e42f179', '随着数字信息金融科技的快速演进，数字化法定数字货币正在全球许多国家试点推广应用。', 'Suízhe shùzì xìnxī jīnróng kējì de kuàisù yǎnjìn, shùzìhuà fǎdìng shùzì huòbì zhèngzài quánqiú xǔduō guójiā shìdiǎn tuīguǎng yìngyòng.', 'Cùng với sự phát triển nhanh chóng của công nghệ tài chính thông tin số, tiền tệ kỹ thuật số pháp định đang được thí điểm mở rộng ứng dụng tại nhiều quốc gia trên toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3a6bc156-e239-4fa3-b716-1c1a5e42f179'
);

-- [火柴] (huǒchái): diêm
UPDATE public.vocabularies
SET example_hanzi = '户外探险队员在野外露营生火时，用随身携带的特制防水火柴点燃了干燥的干柴。',
    example_pinyin = 'Hùwài tànxiǎnduìyuán zài yěwài lùyíng shēnghuǒ shí, yòng suíshēn xiédài de tèzhì fángshuǐ huǒchái diǎnrán le gānzào de gānchái.',
    example_vi = 'Các thành viên đội thám hiểm ngoài trời khi cắm trại đốt lửa nơi hoang dã đã dùng que diêm chống nước đặc chế mang theo bên mình châm cháy cành củi khô.'
WHERE id = '76e86ec9-eed0-42ec-814e-815ad8be5c19' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '76e86ec9-eed0-42ec-814e-815ad8be5c19', '户外探险队员在野外露营生火时，用随身携带的特制防水火柴点燃了干燥的干柴。', 'Hùwài tànxiǎnduìyuán zài yěwài lùyíng shēnghuǒ shí, yòng suíshēn xiédài de tèzhì fángshuǐ huǒchái diǎnrán le gānzào de gānchái.', 'Các thành viên đội thám hiểm ngoài trời khi cắm trại đốt lửa nơi hoang dã đã dùng que diêm chống nước đặc chế mang theo bên mình châm cháy cành củi khô.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '76e86ec9-eed0-42ec-814e-815ad8be5c19'
);

-- [活力] (huólì): sức sống, sinh lực
UPDATE public.vocabularies
SET example_hanzi = '通过持续深化体制机制改革与优化营商环境，极大地激发了民营经济的市场创新活力。',
    example_pinyin = 'Tōngguò chíxù shēnhuà tǐzhì jīzhì gǎigé yǔ yōuhuà yíngshāng huánjìng, jídà de jīfā le mínyíng jīngjì de shìchǎng chuàngxīn huólì.',
    example_vi = 'Thông qua việc tiếp tục làm sâu sắc cải cách thể chế cơ chế và tối ưu hóa môi trường kinh doanh đã khơi dậy mạnh mẽ sức sống đổi mới thị trường của kinh tế tư nhân.'
WHERE id = '81ca6837-3a54-418f-8aff-034482022f16' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '81ca6837-3a54-418f-8aff-034482022f16', '通过持续深化体制机制改革与优化营商环境，极大地激发了民营经济的市场创新活力。', 'Tōngguò chíxù shēnhuà tǐzhì jīzhì gǎigé yǔ yōuhuà yíngshāng huánjìng, jídà de jīfā le mínyíng jīngjì de shìchǎng chuàngxīn huólì.', 'Thông qua việc tiếp tục làm sâu sắc cải cách thể chế cơ chế và tối ưu hóa môi trường kinh doanh đã khơi dậy mạnh mẽ sức sống đổi mới thị trường của kinh tế tư nhân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '81ca6837-3a54-418f-8aff-034482022f16'
);

-- [活跃] (huóyuè): sôi nổi, hoạt bát
UPDATE public.vocabularies
SET example_hanzi = '语文老师通过启发式提问和生动的故事讲解，使得整堂课的课堂交流气氛格外活跃。',
    example_pinyin = 'Yǔwén lǎoshī tōngguò qǐfāshì tíwèn hé shēngdòng de gùshì jiǎngjiě, shǐde zhěngtáng kè de kètáng jiāoliú qìfēn géwài huóyuè.',
    example_vi = 'Thầy giáo ngữ văn thông qua các câu hỏi gợi mở và giảng giải những câu chuyện sinh động đã khiến bầu không khí giao lưu của cả buổi học vô cùng sôi nổi hoạt bát.'
WHERE id = '59f93f2e-0556-4de8-9bd5-289febf0d573' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '59f93f2e-0556-4de8-9bd5-289febf0d573', '语文老师通过启发式提问和生动的故事讲解，使得整堂课的课堂交流气氛格外活跃。', 'Yǔwén lǎoshī tōngguò qǐfāshì tíwèn hé shēngdòng de gùshì jiǎngjiě, shǐde zhěngtáng kè de kètáng jiāoliú qìfēn géwài huóyuè.', 'Thầy giáo ngữ văn thông qua các câu hỏi gợi mở và giảng giải những câu chuyện sinh động đã khiến bầu không khí giao lưu của cả buổi học vô cùng sôi nổi hoạt bát.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '59f93f2e-0556-4de8-9bd5-289febf0d573'
);

-- [继承] (jì chéng): thừa kế, kế thừa
UPDATE public.vocabularies
SET example_hanzi = '当代青年应当自觉承担起保护历史文化遗产的重任，继承并弘扬中华优秀传统美德。',
    example_pinyin = 'Dāngdài qīngnián yīngdāng zìjué chéngdān qǐ bǎohù lìshǐ wénhuà yíchǎn de zhòngrèn, jìchéng bìng hóngyáng Zhōnghuá yōuxiù chuántǒng měidé.',
    example_vi = 'Thanh niên đương đại nên tự giác gánh vác trọng trách bảo vệ di sản văn hóa lịch sử, kế thừa và phát huy những mỹ đức truyền thống ưu tú của Trung Hoa.'
WHERE id = '743a3840-762c-4e8a-a9c8-7189ff7aa112' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '743a3840-762c-4e8a-a9c8-7189ff7aa112', '当代青年应当自觉承担起保护历史文化遗产的重任，继承并弘扬中华优秀传统美德。', 'Dāngdài qīngnián yīngdāng zìjué chéngdān qǐ bǎohù lìshǐ wénhuà yíchǎn de zhòngrèn, jìchéng bìng hóngyáng Zhōnghuá yōuxiù chuántǒng měidé.', 'Thanh niên đương đại nên tự giác gánh vác trọng trách bảo vệ di sản văn hóa lịch sử, kế thừa và phát huy những mỹ đức truyền thống ưu tú của Trung Hoa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '743a3840-762c-4e8a-a9c8-7189ff7aa112'
);

-- [急切] (jí qiè): cấp bách, tha thiết
UPDATE public.vocabularies
SET example_hanzi = '在候机大厅焦急等候了数小时的父母，用急切渴望的目光注视着每一位走出通道的旅客。',
    example_pinyin = 'Zài hòujī dàtīng jiāojí děnghòu le shù xiǎoshí de fùmǔ, yòng jíqiè kěwàng de mùguāng zhùshì zhe měi yí wèi zǒu chū tōngdào de lǚkè.',
    example_vi = 'Bố mẹ sốt ruột chờ đợi suốt mấy tiếng tại sảnh chờ sân bay, dùng ánh mắt tha thiết nóng lòng dõi theo từng hành khách bước ra từ cửa ra vào.'
WHERE id = '7f3ae745-469d-4dbb-92b2-8830528fbf54' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7f3ae745-469d-4dbb-92b2-8830528fbf54', '在候机大厅焦急等候了数小时的父母，用急切渴望的目光注视着每一位走出通道的旅客。', 'Zài hòujī dàtīng jiāojí děnghòu le shù xiǎoshí de fùmǔ, yòng jíqiè kěwàng de mùguāng zhùshì zhe měi yí wèi zǒu chū tōngdào de lǚkè.', 'Bố mẹ sốt ruột chờ đợi suốt mấy tiếng tại sảnh chờ sân bay, dùng ánh mắt tha thiết nóng lòng dõi theo từng hành khách bước ra từ cửa ra vào.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7f3ae745-469d-4dbb-92b2-8830528fbf54'
);

-- [饥饿] (jī'è): đói khát
UPDATE public.vocabularies
SET example_hanzi = '联合国粮食署积极呼吁国际社会采取果断行动，消除全球贫困地区的营养不良与饥饿问题。',
    example_pinyin = 'Liánhéguó liángshíshǔ jījí hūyù guójì shèhuì cǎiqǔ guǒduàn xíngdòng, xiāochú quánqiú pínkùn dìqū de yíngyǎng-bùliáng yǔ jī''è wèntí.',
    example_vi = 'Chương trình Lương thực Liên Hợp Quốc tích cực kêu gọi cộng đồng quốc tế hành động quyết đoán để xóa bỏ vấn nạn suy dinh dưỡng và đói khát tại các khu vực nghèo khó toàn cầu.'
WHERE id = 'fa52bf2a-2774-4205-a3f3-66a91bd5aba1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fa52bf2a-2774-4205-a3f3-66a91bd5aba1', '联合国粮食署积极呼吁国际社会采取果断行动，消除全球贫困地区的营养不良与饥饿问题。', 'Liánhéguó liángshíshǔ jījí hūyù guójì shèhuì cǎiqǔ guǒduàn xíngdòng, xiāochú quánqiú pínkùn dìqū de yíngyǎng-bùliáng yǔ jī''è wèntí.', 'Chương trình Lương thực Liên Hợp Quốc tích cực kêu gọi cộng đồng quốc tế hành động quyết đoán để xóa bỏ vấn nạn suy dinh dưỡng và đói khát tại các khu vực nghèo khó toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fa52bf2a-2774-4205-a3f3-66a91bd5aba1'
);

-- [嫁] (jià): lấy (chồng), gả
UPDATE public.vocabularies
SET example_hanzi = '在这个温馨喜庆的婚礼上，新娘身着纯白婚纱，在亲朋好友的深情祝福中幸福出嫁。',
    example_pinyin = 'Zài zhè gè wēnxīn xǐqìng de hūnlǐ shang, xīnniáng shēnzhuó chún bái hūnshā, zài qīnpéng-hǎoyǒu de shēnqíng zhùfú zhōng xìngfú chūjià.',
    example_vi = 'Trong hôn lễ ấm áp tưng bừng này, cô dâu khoác trên mình bộ váy cưới trắng tinh khôi, hạnh phúc lấy chồng xuất giá giữa muôn vàn lời chúc phúc thâm tình của người thân và bạn bè.'
WHERE id = 'da28614b-f5d3-4aa2-9800-f85c333764a2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'da28614b-f5d3-4aa2-9800-f85c333764a2', '在这个温馨喜庆的婚礼上，新娘身着纯白婚纱，在亲朋好友的深情祝福中幸福出嫁。', 'Zài zhè gè wēnxīn xǐqìng de hūnlǐ shang, xīnniáng shēnzhuó chún bái hūnshā, zài qīnpéng-hǎoyǒu de shēnqíng zhùfú zhōng xìngfú chūjià.', 'Trong hôn lễ ấm áp tưng bừng này, cô dâu khoác trên mình bộ váy cưới trắng tinh khôi, hạnh phúc lấy chồng xuất giá giữa muôn vàn lời chúc phúc thâm tình của người thân và bạn bè.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'da28614b-f5d3-4aa2-9800-f85c333764a2'
);

-- [家常] (jiācháng): thường ngày, cơm nhà
UPDATE public.vocabularies
SET example_hanzi = '虽然饭馆里的菜肴十分丰盛，但最能温暖远方游子心灵的始终还是妈妈亲手做的那顿家常便饭。',
    example_pinyin = 'Suīrán fànguǎn lǐ de càiyáo shífēn fēngshèng, dàn zuì néng wēnnuǎn yuǎnfāng yóuzǐ xīnlíng de shǐzhōng háishì māma qīnshǒu zuò de nà dùn jiācháng-biànfàn.',
    example_vi = 'Dù món ăn ngoài tiệm có thịnh soạn đến đâu, thứ có thể sưởi ấm tâm hồn người con xa xứ nhất mãi mãi vẫn là bữa cơm thường ngày mẹ tự tay nấu.'
WHERE id = 'fa23948f-2897-4fba-bc20-067abfba671e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fa23948f-2897-4fba-bc20-067abfba671e', '虽然饭馆里的菜肴十分丰盛，但最能温暖远方游子心灵的始终还是妈妈亲手做的那顿家常便饭。', 'Suīrán fànguǎn lǐ de càiyáo shífēn fēngshèng, dàn zuì néng wēnnuǎn yuǎnfāng yóuzǐ xīnlíng de shǐzhōng háishì māma qīnshǒu zuò de nà dùn jiācháng-biànfàn.', 'Dù món ăn ngoài tiệm có thịnh soạn đến đâu, thứ có thể sưởi ấm tâm hồn người con xa xứ nhất mãi mãi vẫn là bữa cơm thường ngày mẹ tự tay nấu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fa23948f-2897-4fba-bc20-067abfba671e'
);

-- [加剧] (jiājù): gia tăng, thêm trầm trọng
UPDATE public.vocabularies
SET example_hanzi = '持续高温干旱天气导致河流流量骤减，进一步加剧了周边农业生产与城镇供水的严峻压力。',
    example_pinyin = 'Chíxù gāowēn gānhàn tiānqì dǎozhì héliú liúliàng zhòujiǎn, jìnyíbù jiājù le zhōubiān nóngyè shēngchǎn yǔ chéngzhèn gōngshuǐ de yánjùn yālì.',
    example_vi = 'Thời tiết nắng nóng khô hạn kéo dài làm lưu lượng sông sụt giảm đột ngột, càng làm gia tăng thêm trầm trọng áp lực gay gắt đối với sản xuất nông nghiệp và cấp nước đô thị xung quanh.'
WHERE id = 'd8e6effe-2a09-451e-aed2-ebf6cbc49eb3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd8e6effe-2a09-451e-aed2-ebf6cbc49eb3', '持续高温干旱天气导致河流流量骤减，进一步加剧了周边农业生产与城镇供水的严峻压力。', 'Chíxù gāowēn gānhàn tiānqì dǎozhì héliú liúliàng zhòujiǎn, jìnyíbù jiājù le zhōubiān nóngyè shēngchǎn yǔ chéngzhèn gōngshuǐ de yánjùn yālì.', 'Thời tiết nắng nóng khô hạn kéo dài làm lưu lượng sông sụt giảm đột ngột, càng làm gia tăng thêm trầm trọng áp lực gay gắt đối với sản xuất nông nghiệp và cấp nước đô thị xung quanh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd8e6effe-2a09-451e-aed2-ebf6cbc49eb3'
);

-- [剑] (jiàn): kiếm, thanh kiếm
UPDATE public.vocabularies
SET example_hanzi = '中国古代武术讲究剑随身动、身剑合一，佩剑不仅是防身兵刃更是文人雅士高洁风骨的象征。',
    example_pinyin = 'Zhōngguó gǔdài wǔshù jiǎngjiu jiàn suí shēn dòng, shēn jiàn hé yī, pèijiàn bùjǐn shì fángshēn bīngrèn gèng shì wénrén-yǎshì gāojié fēnggǔ de xiàngzhēng.',
    example_vi = 'Võ thuật cổ truyền Trung Hoa đề cao kiếm theo thân chuyển động, thân kiếm hợp nhất; thanh kiếm đeo bên mình không chỉ là vũ khí phòng thân mà còn là biểu tượng khí phách thanh tao của bậc văn nhân tao nhã.'
WHERE id = '42ce02ad-6948-4a28-88bf-3a7e667eb302' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '42ce02ad-6948-4a28-88bf-3a7e667eb302', '中国古代武术讲究剑随身动、身剑合一，佩剑不仅是防身兵刃更是文人雅士高洁风骨的象征。', 'Zhōngguó gǔdài wǔshù jiǎngjiu jiàn suí shēn dòng, shēn jiàn hé yī, pèijiàn bùjǐn shì fángshēn bīngrèn gèng shì wénrén-yǎshì gāojié fēnggǔ de xiàngzhēng.', 'Võ thuật cổ truyền Trung Hoa đề cao kiếm theo thân chuyển động, thân kiếm hợp nhất; thanh kiếm đeo bên mình không chỉ là vũ khí phòng thân mà còn là biểu tượng khí phách thanh tao của bậc văn nhân tao nhã.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '42ce02ad-6948-4a28-88bf-3a7e667eb302'
);

-- [肩膀] (jiānbǎng): vai
UPDATE public.vocabularies
SET example_hanzi = '父亲用宽厚有力的肩膀扛起沉重的行囊，默默为全家人的美好幸福生活遮风挡雨。',
    example_pinyin = 'Fùqīn yòng kuānhòu yǒulì de jiānbǎng káng qǐ chénzhòng de xíngnang, mòmò wèi quánjiā rén de měihǎo xìngfú shēnghuó zhēfēng-dǎngyǔ.',
    example_vi = 'Người cha dùng bờ vai rộng dày dạn vững chãi gánh vác túi hành lý nặng trĩu, âm thầm che mưa chắn gió cho cuộc sống ấm no hạnh phúc của cả gia đình.'
WHERE id = 'cf6250eb-75d5-4314-982c-6127aac4a0a2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cf6250eb-75d5-4314-982c-6127aac4a0a2', '父亲用宽厚有力的肩膀扛起沉重的行囊，默默为全家人的美好幸福生活遮风挡雨。', 'Fùqīn yòng kuānhòu yǒulì de jiānbǎng káng qǐ chénzhòng de xíngnang, mòmò wèi quánjiā rén de měihǎo xìngfú shēnghuó zhēfēng-dǎngyǔ.', 'Người cha dùng bờ vai rộng dày dạn vững chãi gánh vác túi hành lý nặng trĩu, âm thầm che mưa chắn gió cho cuộc sống ấm no hạnh phúc của cả gia đình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cf6250eb-75d5-4314-982c-6127aac4a0a2'
);

-- [鉴定] (jiàndìng): giám định, đánh giá
UPDATE public.vocabularies
SET example_hanzi = '国家文物局组织资深文博专家对这件出土青铜器进行了严格的科学技术断代与真伪鉴定。',
    example_pinyin = 'Guójiā wénwùjú zǔzhī zīshēn wénbó zhuānjiā duì zhè jiàn chūtǔ qīngtóngqì jìnxíng le yángé de kēxué jìshù duàndài yǔ zhēn-wěi jiàndìng.',
    example_vi = 'Cục Di sản Văn hóa Quốc gia đã tổ chức các chuyên gia bảo tàng kỳ cựu tiến hành xác định niên đại khoa học kỹ thuật và giám định đánh giá thật giả nghiêm ngặt cho món đồ đồng mới khai quật này.'
WHERE id = '814d1ad6-c5d3-4876-b0bb-cc281ed0ae1e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '814d1ad6-c5d3-4876-b0bb-cc281ed0ae1e', '国家文物局组织资深文博专家对这件出土青铜器进行了严格的科学技术断代与真伪鉴定。', 'Guójiā wénwùjú zǔzhī zīshēn wénbó zhuānjiā duì zhè jiàn chūtǔ qīngtóngqì jìnxíng le yángé de kēxué jìshù duàndài yǔ zhēn-wěi jiàndìng.', 'Cục Di sản Văn hóa Quốc gia đã tổ chức các chuyên gia bảo tàng kỳ cựu tiến hành xác định niên đại khoa học kỹ thuật và giám định đánh giá thật giả nghiêm ngặt cho món đồ đồng mới khai quật này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '814d1ad6-c5d3-4876-b0bb-cc281ed0ae1e'
);

-- [坚定] (jiāndìng): kiên định, vững vàng
UPDATE public.vocabularies
SET example_hanzi = '无论前方的攀登之路有多么坎坷漫长，他始终怀着坚定不移的信念朝着科学高峰奋勇前行。',
    example_pinyin = 'Wúlùn qiánfāng de pāndēng zhī lù yǒu duōme kǎnkě màncháng, tā shǐzhōng huái zhe jiāndìng-bùyí de xìnniàn cháozhe kēxué gāofēng fènyǒng qiánxíng.',
    example_vi = 'Dù cho con đường leo núi phía trước có gập ghềnh và dài đằng đẵng đến đâu, anh ấy vẫn luôn ôm ấp niềm tin kiên định không đổi dũng cảm tiến bước tới đỉnh cao khoa học.'
WHERE id = '850d5af3-aaef-492a-aa68-c0b6dc603f87' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '850d5af3-aaef-492a-aa68-c0b6dc603f87', '无论前方的攀登之路有多么坎坷漫长，他始终怀着坚定不移的信念朝着科学高峰奋勇前行。', 'Wúlùn qiánfāng de pāndēng zhī lù yǒu duōme kǎnkě màncháng, tā shǐzhōng huái zhe jiāndìng-bùyí de xìnniàn cháozhe kēxué gāofēng fènyǒng qiánxíng.', 'Dù cho con đường leo núi phía trước có gập ghềnh và dài đằng đẵng đến đâu, anh ấy vẫn luôn ôm ấp niềm tin kiên định không đổi dũng cảm tiến bước tới đỉnh cao khoa học.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '850d5af3-aaef-492a-aa68-c0b6dc603f87'
);

-- [监督] (jiāndū): giám sát
UPDATE public.vocabularies
SET example_hanzi = '食品药品监管部门应当加大对学校食堂食品卫生安全的日常巡查与全方位监督力度。',
    example_pinyin = 'Shípǐn yàopǐn jiānguǎn bùmén yīngdāng jiàdà duì xuéxiào shítáng shípǐn wèishēng ānquán de rìcháng xúnchá yǔ quánfāngwèi jiāndū lìdù.',
    example_vi = 'Cơ quan giám sát quản lý thực phẩm và dược phẩm cần tăng cường độ tuần tra thường nhật và giám sát toàn diện đối với an toàn vệ sinh thực phẩm nhà ăn trường học.'
WHERE id = '8272a28c-fe36-4179-9f3a-49648d4f42ba' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8272a28c-fe36-4179-9f3a-49648d4f42ba', '食品药品监管部门应当加大对学校食堂食品卫生安全的日常巡查与全方位监督力度。', 'Shípǐn yàopǐn jiānguǎn bùmén yīngdāng jiàdà duì xuéxiào shítáng shípǐn wèishēng ānquán de rìcháng xúnchá yǔ quánfāngwèi jiāndū lìdù.', 'Cơ quan giám sát quản lý thực phẩm và dược phẩm cần tăng cường độ tuần tra thường nhật và giám sát toàn diện đối với an toàn vệ sinh thực phẩm nhà ăn trường học.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8272a28c-fe36-4179-9f3a-49648d4f42ba'
);

-- [间隔] (jiàngé): khoảng cách, ngăn cách
UPDATE public.vocabularies
SET example_hanzi = '在现代化高等级公路施工中，技术规范严格规定路旁防护林苗木栽种间隔应保持在三米整。',
    example_pinyin = 'Zài xiàndàihuà gāoděngjí gōnglù shīgōng zhōng, jìshù guīfàn yángé guīdìng lùpáng fánghùlín miáomù zāizhòng jiàngé yīng bǎochí zài sān mǐ zhěng.',
    example_vi = 'Trong thi công đường bộ cấp cao hiện đại, quy chuẩn kỹ thuật quy định nghiêm ngặt khoảng cách trồng cây giống rừng phòng hộ ven đường phải duy trì tròn 3 mét.'
WHERE id = 'a6c1604e-c34a-4cbc-ba27-5b1dae16b76b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a6c1604e-c34a-4cbc-ba27-5b1dae16b76b', '在现代化高等级公路施工中，技术规范严格规定路旁防护林苗木栽种间隔应保持在三米整。', 'Zài xiàndàihuà gāoděngjí gōnglù shīgōng zhōng, jìshù guīfàn yángé guīdìng lùpáng fánghùlín miáomù zāizhòng jiàngé yīng bǎochí zài sān mǐ zhěng.', 'Trong thi công đường bộ cấp cao hiện đại, quy chuẩn kỹ thuật quy định nghiêm ngặt khoảng cách trồng cây giống rừng phòng hộ ven đường phải duy trì tròn 3 mét.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a6c1604e-c34a-4cbc-ba27-5b1dae16b76b'
);

-- [将军] (jiāngjūn): tướng quân, vị tướng
UPDATE public.vocabularies
SET example_hanzi = '这位身经百战的功勋将军在指挥部沙盘前神情镇定自若，严谨部署着突破敌人防线的战役方案。',
    example_pinyin = 'Zhè wèi shēnjīng-bǎizhàn de gōngxūn jiāngjūn zài zhǐhuībù shāpán qián shénqíng zhèndìng-zìruò, yánjǐn bùshǔ zhe tūpò dírén fángxiàn de zhànyì fāng''àn.',
    example_vi = 'Vị tướng quân dạn dày trăm trận chiến công hiển hách trước sa bàn sở chỉ huy thần thái bình tĩnh tự tin, cẩn trọng bố trí phương án chiến dịch chọc thủng phòng tuyến quân địch.'
WHERE id = '734f757c-19f9-475f-aa51-fac796524638' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '734f757c-19f9-475f-aa51-fac796524638', '这位身经百战的功勋将军在指挥部沙盘前神情镇定自若，严谨部署着突破敌人防线的战役方案。', 'Zhè wèi shēnjīng-bǎizhàn de gōngxūn jiāngjūn zài zhǐhuībù shāpán qián shénqíng zhèndìng-zìruò, yánjǐn bùshǔ zhe tūpò dírén fángxiàn de zhànyì fāng''àn.', 'Vị tướng quân dạn dày trăm trận chiến công hiển hách trước sa bàn sở chỉ huy thần thái bình tĩnh tự tin, cẩn trọng bố trí phương án chiến dịch chọc thủng phòng tuyến quân địch.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '734f757c-19f9-475f-aa51-fac796524638'
);

-- [坚固] (jiāngù): kiên cố, chắc chắn
UPDATE public.vocabularies
SET example_hanzi = '建造在花岗岩岩基上的防洪海堤历经数十次超强台风巨浪的猛烈冲刷，依然固若金汤、十分坚固。',
    example_pinyin = 'Jiànzào zài huāgāngyán yánjī shang de fánghóng hǎidī lìjīng shùshí cì chāoqiáng táifēng jùlàng de měngliè chōngshuā, yīrán gùruòjīntāng, shífēn jiāngù.',
    example_vi = 'Đê biển ngăn lũ được xây dựng trên nền móng đá hoa cương trải qua hàng chục lần bão lớn sóng dữ dữ dội vùi dập vẫn sừng sững kiên cố như bàn thạch.'
WHERE id = '420319af-1881-4cef-a328-f3be3548b0ba' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '420319af-1881-4cef-a328-f3be3548b0ba', '建造在花岗岩岩基上的防洪海堤历经数十次超强台风巨浪的猛烈冲刷，依然固若金汤、十分坚固。', 'Jiànzào zài huāgāngyán yánjī shang de fánghóng hǎidī lìjīng shùshí cì chāoqiáng táifēng jùlàng de měngliè chōngshuā, yīrán gùruòjīntāng, shífēn jiāngù.', 'Đê biển ngăn lũ được xây dựng trên nền móng đá hoa cương trải qua hàng chục lần bão lớn sóng dữ dữ dội vùi dập vẫn sừng sững kiên cố như bàn thạch.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '420319af-1881-4cef-a328-f3be3548b0ba'
);

-- [简化] (jiǎnhuà): đơn giản hóa
UPDATE public.vocabularies
SET example_hanzi = '政务服务大厅通过推行数字一网通办举措，极大简化了企业申领营业执照的审批办理流程。',
    example_pinyin = 'Zhèngwù fúwù dàtīng tōngguò tuīxíng shùzì yìwǎngtōngbàn jǔcuò, jídà jiǎnhuà le qǐyè shēnlǐng yíngyè zhízhào de shěnpī bànlǐ liúchéng.',
    example_vi = 'Đại sảnh dịch vụ hành chính công thông qua triển khai giải pháp số một cửa điện tử đã đơn giản hóa rất nhiều quy trình xét duyệt cấp phép đăng ký kinh doanh cho doanh nghiệp.'
WHERE id = '92aebf71-a909-4632-912d-d531d7defbef' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '92aebf71-a909-4632-912d-d531d7defbef', '政务服务大厅通过推行数字一网通办举措，极大简化了企业申领营业执照的审批办理流程。', 'Zhèngwù fúwù dàtīng tōngguò tuīxíng shùzì yìwǎngtōngbàn jǔcuò, jídà jiǎnhuà le qǐyè shēnlǐng yíngyè zhízhào de shěnpī bànlǐ liúchéng.', 'Đại sảnh dịch vụ hành chính công thông qua triển khai giải pháp số một cửa điện tử đã đơn giản hóa rất nhiều quy trình xét duyệt cấp phép đăng ký kinh doanh cho doanh nghiệp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '92aebf71-a909-4632-912d-d531d7defbef'
);

-- [间接] (jiànjiē): gián tiếp
UPDATE public.vocabularies
SET example_hanzi = '保护好流域上游的森林植被水源地，对下游城市防止泥沙淤积和水患具有极其重要的间接保护作用。',
    example_pinyin = 'Bǎohù hǎo liúyù shàngyóu de sēnlín zhíbèi shuǐyuándì, duì xiàyóu chéngshì fángzhǐ níshā yūjī hé shuǐhuàn jùyǒu jíqí zhòngyào de jiànjiē bǎohù zuòyòng.',
    example_vi = 'Bảo vệ tốt nguồn nước và thảm thực vật rừng ở thượng nguồn lưu vực có tác dụng bảo vệ gián tiếp cực kỳ quan trọng đối với các đô thị hạ lưu trong việc ngăn ngừa phù sa bồi lắng và lũ lụt.'
WHERE id = 'a001dbeb-6d58-448d-b4f8-82b95dbc28e9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a001dbeb-6d58-448d-b4f8-82b95dbc28e9', '保护好流域上游的森林植被水源地，对下游城市防止泥沙淤积和水患具有极其重要的间接保护作用。', 'Bǎohù hǎo liúyù shàngyóu de sēnlín zhíbèi shuǐyuándì, duì xiàyóu chéngshì fángzhǐ níshā yūjī hé shuǐhuàn jùyǒu jíqí zhòngyào de jiànjiē bǎohù zuòyòng.', 'Bảo vệ tốt nguồn nước và thảm thực vật rừng ở thượng nguồn lưu vực có tác dụng bảo vệ gián tiếp cực kỳ quan trọng đối với các đô thị hạ lưu trong việc ngăn ngừa phù sa bồi lắng và lũ lụt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a001dbeb-6d58-448d-b4f8-82b95dbc28e9'
);

-- [坚决] (jiānjué): kiên quyết
UPDATE public.vocabularies
SET example_hanzi = '面对破坏生态环境、非法盗采珍贵矿产资源的违法犯罪行为，执法部门坚决予以严厉打击惩处。',
    example_pinyin = 'Miànduì pòhuài shēngtài huánjìng, fēifǎ dǎocǎi zhēnguì kuàngchǎn zīyuán de wéifǎ fànzuì xíngwéi, zhífǎ bùmén jiānjué yǔyǐ yánlì dǎjī chéngchǔ.',
    example_vi = 'Trước các hành vi vi phạm pháp luật hủy hoại môi trường sinh thái và khai thác trộm tài nguyên khoáng sản quý giá, cơ quan hành pháp kiên quyết trừng trị nghiêm khắc.'
WHERE id = 'fe39b236-caeb-4ca7-a74a-b8ee388e7d85' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fe39b236-caeb-4ca7-a74a-b8ee388e7d85', '面对破坏生态环境、非法盗采珍贵矿产资源的违法犯罪行为，执法部门坚决予以严厉打击惩处。', 'Miànduì pòhuài shēngtài huánjìng, fēifǎ dǎocǎi zhēnguì kuàngchǎn zīyuán de wéifǎ fànzuì xíngwéi, zhífǎ bùmén jiānjué yǔyǐ yánlì dǎjī chéngchǔ.', 'Trước các hành vi vi phạm pháp luật hủy hoại môi trường sinh thái và khai thác trộm tài nguyên khoáng sản quý giá, cơ quan hành pháp kiên quyết trừng trị nghiêm khắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fe39b236-caeb-4ca7-a74a-b8ee388e7d85'
);

-- [艰难] (jiānnán): gian nan, khó khăn
UPDATE public.vocabularies
SET example_hanzi = '创业初期虽然历经资金短缺与市场开拓的重重艰难困苦，但他凭借顽强的毅力带领团队走出了低谷。',
    example_pinyin = 'Chuàngyè chūqī suīrán lìjīng zījīn duǎnquē yǔ shìchǎng kāituò de chóngchóng jiānnán kùnkǔ, dàn tā píngjiè wánqiáng de yìlì dàilǐng tuánduì zǒu chū le dīgǔ.',
    example_vi = 'Thời kỳ đầu lập nghiệp dù trải qua muôn vàn gian nan vất vả vì thiếu thốn vốn liếng và mở rộng thị trường, song anh ấy nhờ nghị lực kiên cường đã dẫn dắt đội ngũ vượt qua vực sâu.'
WHERE id = '8d0a182a-33fe-42dd-a56d-cf8b72eb0a10' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8d0a182a-33fe-42dd-a56d-cf8b72eb0a10', '创业初期虽然历经资金短缺与市场开拓的重重艰难困苦，但他凭借顽强的毅力带领团队走出了低谷。', 'Chuàngyè chūqī suīrán lìjīng zījīn duǎnquē yǔ shìchǎng kāituò de chóngchóng jiānnán kùnkǔ, dàn tā píngjiè wánqiáng de yìlì dàilǐng tuánduì zǒu chū le dīgǔ.', 'Thời kỳ đầu lập nghiệp dù trải qua muôn vàn gian nan vất vả vì thiếu thốn vốn liếng và mở rộng thị trường, song anh ấy nhờ nghị lực kiên cường đã dẫn dắt đội ngũ vượt qua vực sâu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8d0a182a-33fe-42dd-a56d-cf8b72eb0a10'
);

-- [健全] (jiànquán): kiện toàn, lành mạnh
UPDATE public.vocabularies
SET example_hanzi = '国家正在加速健全覆盖全民的基本养老与医疗保障体系，切实增进各族人民群众的民生福祉。',
    example_pinyin = 'Guójiā zhèngzài jiāsù jiànquán fùgài quánmín de jīběn yǎnglǎo yǔ yīliáo bǎozhàng tǐxì, qièshí zēngjìn gè zú rénmín qúnzhòng de mínshēng fúzhǐ.',
    example_vi = 'Nhà nước đang đẩy nhanh việc kiện toàn hoàn thiện hệ thống an sinh hưu trí và bảo hiểm y tế cơ bản bao phủ toàn dân, nâng cao phúc lợi dân sinh của đồng bào các dân tộc.'
WHERE id = '2dd96cb0-ff27-47e9-a55f-22e1efcf427a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2dd96cb0-ff27-47e9-a55f-22e1efcf427a', '国家正在加速健全覆盖全民的基本养老与医疗保障体系，切实增进各族人民群众的民生福祉。', 'Guójiā zhèngzài jiāsù jiànquán fùgài quánmín de jīběn yǎnglǎo yǔ yīliáo bǎozhàng tǐxì, qièshí zēngjìn gè zú rénmín qúnzhòng de mínshēng fúzhǐ.', 'Nhà nước đang đẩy nhanh việc kiện toàn hoàn thiện hệ thống an sinh hưu trí và bảo hiểm y tế cơ bản bao phủ toàn dân, nâng cao phúc lợi dân sinh của đồng bào các dân tộc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2dd96cb0-ff27-47e9-a55f-22e1efcf427a'
);

-- [检验] (jiǎnyàn): kiểm nghiệm, kiểm tra
UPDATE public.vocabularies
SET example_hanzi = '实践是检验真理的唯一标准，一项科学理论是否正确必须接受长期的社会实践和科学实验反复检验。',
    example_pinyin = 'Shíjiàn shì jiǎnyàn zhēnlǐ de wéiyī biāozhǔn, yí xiàng kēxué lǐlùn shìfǒu zhèngquè bìxū jiēshòu chángqī de shèhuì shíjiàn hé kēxué shíyàn fǎnfù jiǎnyàn.',
    example_vi = 'Thực tiễn là tiêu chuẩn duy nhất để kiểm nghiệm chân lý, một lý luận khoa học có đúng đắn hay không nhất thiết phải trải qua sự kiểm nghiệm lặp đi lặp lại của thực tiễn xã hội và thí nghiệm khoa học lâu dài.'
WHERE id = '4aac94e2-e016-4342-979c-049dfa2f965d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4aac94e2-e016-4342-979c-049dfa2f965d', '实践是检验真理的唯一标准，一项科学理论是否正确必须接受长期的社会实践和科学实验反复检验。', 'Shíjiàn shì jiǎnyàn zhēnlǐ de wéiyī biāozhǔn, yí xiàng kēxué lǐlùn shìfǒu zhèngquè bìxū jiēshòu chángqī de shèhuì shíjiàn hé kēxué shíyàn fǎnfù jiǎnyàn.', 'Thực tiễn là tiêu chuẩn duy nhất để kiểm nghiệm chân lý, một lý luận khoa học có đúng đắn hay không nhất thiết phải trải qua sự kiểm nghiệm lặp đi lặp lại của thực tiễn xã hội và thí nghiệm khoa học lâu dài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4aac94e2-e016-4342-979c-049dfa2f965d'
);

-- [坚硬] (jiānyìng): cứng rắn, rắn chắc
UPDATE public.vocabularies
SET example_hanzi = '深海潜水器外壳采用了高强度特种合金钢材料，能够承受深达万米海底坚硬地层的巨大水压。',
    example_pinyin = 'Shēnhǎi qiánshuǐqì wàiké cǎiyòng le gāo qiángdù tèzhǒng héjīnggāng cáiliào, nénggòu chéngshòu shēn dá wàn mǐ hǎidǐ jiānyìng dìcéng de jùdà shuǐyā.',
    example_vi = 'Vỏ tàu lặn biển sâu sử dụng vật liệu thép hợp kim đặc chủng cường độ cao, có thể chịu được áp lực nước khổng lồ tại tầng địa chất cứng rắn sâu vạn mét dưới đáy biển.'
WHERE id = 'aee5e8db-f42e-4b54-929a-9be5450bc8dc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'aee5e8db-f42e-4b54-929a-9be5450bc8dc', '深海潜水器外壳采用了高强度特种合金钢材料，能够承受深达万米海底坚硬地层的巨大水压。', 'Shēnhǎi qiánshuǐqì wàiké cǎiyòng le gāo qiángdù tèzhǒng héjīnggāng cáiliào, nénggòu chéngshòu shēn dá wàn mǐ hǎidǐ jiānyìng dìcéng de jùdà shuǐyā.', 'Vỏ tàu lặn biển sâu sử dụng vật liệu thép hợp kim đặc chủng cường độ cao, có thể chịu được áp lực nước khổng lồ tại tầng địa chất cứng rắn sâu vạn mét dưới đáy biển.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'aee5e8db-f42e-4b54-929a-9be5450bc8dc'
);

-- [兼职] (jiānzhí): làm thêm, kiêm nhiệm
UPDATE public.vocabularies
SET example_hanzi = '他在完成大学学业的同时，在学校图书馆申请了一份图书编目整理的勤工俭学兼职工作。',
    example_pinyin = 'Tā zài wánchéng dàxué xuéyè de tóngshí, zài xuéxiào túshūguǎn shēnqǐng le yí fèn túshū biānmù zhěnglǐ de qíngōng-jiǎnxué jiānzhí gōngzuò.',
    example_vi = 'Trong khi hoàn thành chương trình đại học, anh ấy đã nộp đơn xin một công việc làm thêm kiêm nhiệm bán thời gian phân loại sách tại thư viện trường.'
WHERE id = '8bed47ab-f257-4822-9561-6f3b35f8a52d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8bed47ab-f257-4822-9561-6f3b35f8a52d', '他在完成大学学业的同时，在学校图书馆申请了一份图书编目整理的勤工俭学兼职工作。', 'Tā zài wánchéng dàxué xuéyè de tóngshí, zài xuéxiào túshūguǎn shēnqǐng le yí fèn túshū biānmù zhěnglǐ de qíngōng-jiǎnxué jiānzhí gōngzuò.', 'Trong khi hoàn thành chương trình đại học, anh ấy đã nộp đơn xin một công việc làm thêm kiêm nhiệm bán thời gian phân loại sách tại thư viện trường.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8bed47ab-f257-4822-9561-6f3b35f8a52d'
);

-- [焦点] (jiāodiǎn): tiêu điểm, trọng tâm
UPDATE public.vocabularies
SET example_hanzi = '新能源汽车与低空经济技术的最新发展成果，成为了本次世界智能产业博览会全场瞩目的焦点。',
    example_pinyin = 'Xīnnéngyuán qìchē yǔ dīkōng jīngjì jìshù de zuìxīn fāzhǎn chéngguǒ, chéngwéi le běncì shìjiè zhìnéng chǎnyè bólǎnhuì quánchǎng zhǔmù de jiāodiǎn.',
    example_vi = 'Thành quả phát triển mới nhất của xe năng lượng mới và kinh tế tầm thấp đã trở thành tiêu điểm tâm điểm thu hút sự chú ý của toàn bộ hội chợ triển lãm công nghiệp thông minh thế giới lần này.'
WHERE id = '98780b6a-9c8c-40f9-90a7-a8d78c26f175' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '98780b6a-9c8c-40f9-90a7-a8d78c26f175', '新能源汽车与低空经济技术的最新发展成果，成为了本次世界智能产业博览会全场瞩目的焦点。', 'Xīnnéngyuán qìchē yǔ dīkōng jīngjì jìshù de zuìxīn fāzhǎn chéngguǒ, chéngwéi le běncì shìjiè zhìnéng chǎnyè bólǎnhuì quánchǎng zhǔmù de jiāodiǎn.', 'Thành quả phát triển mới nhất của xe năng lượng mới và kinh tế tầm thấp đã trở thành tiêu điểm tâm điểm thu hút sự chú ý của toàn bộ hội chợ triển lãm công nghiệp thông minh thế giới lần này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '98780b6a-9c8c-40f9-90a7-a8d78c26f175'
);

-- [交际] (jiāojì): giao tiếp, giao tế
UPDATE public.vocabularies
SET example_hanzi = '现代社会高度重视人际沟通与团队协作能力，掌握恰当得体的社交礼仪与交际技巧十分必要。',
    example_pinyin = 'Xiàndài shèhuì gāodù zhòngshì rénjì gōutōng yǔ tuánduì xiézuò nénglì, zhǎngwò qiàdàng détǐ de shèjiāo lǐyí yǔ jiāojì jìqiǎo shífēn bìyào.',
    example_vi = 'Xã hội hiện đại rất coi trọng khả năng giao tiếp giữa các cá nhân và hợp tác đội ngũ, nắm vững nghi thức xã giao và kỹ năng giao tiếp đúng mực là vô cùng cần thiết.'
WHERE id = 'e310d4a2-6007-41c4-bd12-97172e3adcd3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e310d4a2-6007-41c4-bd12-97172e3adcd3', '现代社会高度重视人际沟通与团队协作能力，掌握恰当得体的社交礼仪与交际技巧十分必要。', 'Xiàndài shèhuì gāodù zhòngshì rénjì gōutōng yǔ tuánduì xiézuò nénglì, zhǎngwò qiàdàng détǐ de shèjiāo lǐyí yǔ jiāojì jìqiǎo shífēn bìyào.', 'Xã hội hiện đại rất coi trọng khả năng giao tiếp giữa các cá nhân và hợp tác đội ngũ, nắm vững nghi thức xã giao và kỹ năng giao tiếp đúng mực là vô cùng cần thiết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e310d4a2-6007-41c4-bd12-97172e3adcd3'
);

-- [角落] (jiǎoluò): góc, xó
UPDATE public.vocabularies
SET example_hanzi = '虽然小猫躲藏在客厅书架后面昏暗隐蔽的小角落里，细心的小主人还是一眼发现了它。',
    example_pinyin = 'Suīrán xiǎomāo duǒcáng zài kètīng shūjià hòumiàn hūn''àn yǐnbì de xiǎo jiǎoluò lǐ, xìxīn de xiǎo zhǔrén háishì yìyǎn fāxiàn le tā.',
    example_vi = 'Dù chú mèo con trốn vào một góc nhỏ khuất tối phía sau giá sách phòng khách, người chủ nhỏ tinh ý vẫn liếc mắt một cái là phát hiện ra ngay.'
WHERE id = 'c3d1af2f-2716-415c-a7ff-1acd10ff57c8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c3d1af2f-2716-415c-a7ff-1acd10ff57c8', '虽然小猫躲藏在客厅书架后面昏暗隐蔽的小角落里，细心的小主人还是一眼发现了它。', 'Suīrán xiǎomāo duǒcáng zài kètīng shūjià hòumiàn hūn''àn yǐnbì de xiǎo jiǎoluò lǐ, xìxīn de xiǎo zhǔrén háishì yìyǎn fāxiàn le tā.', 'Dù chú mèo con trốn vào một góc nhỏ khuất tối phía sau giá sách phòng khách, người chủ nhỏ tinh ý vẫn liếc mắt một cái là phát hiện ra ngay.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c3d1af2f-2716-415c-a7ff-1acd10ff57c8'
);

-- [胶水] (jiāoshuǐ): keo dán, hồ dán
UPDATE public.vocabularies
SET example_hanzi = '手工制作课上，美术老师教同学们使用环保无毒的固体胶水将彩纸粘贴在画板上。',
    example_pinyin = 'Shǒugōng zhìzuò kè shang, měishù lǎoshī jiāo tóngxué men shǐyòng huánbǎo wú dú de gùtǐ jiāoshuǐ jiāng cǎizhǐ zhāntiē zài huàbǎn shang.',
    example_vi = 'Trong giờ thủ công, cô giáo mỹ thuật dạy các em học sinh dùng keo dán khô thân thiện môi trường không độc hại để dán giấy màu lên bảng vẽ.'
WHERE id = '2c34df3d-98f9-4e2d-8d50-9b48403bf77f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2c34df3d-98f9-4e2d-8d50-9b48403bf77f', '手工制作课上，美术老师教同学们使用环保无毒的固体胶水将彩纸粘贴在画板上。', 'Shǒugōng zhìzuò kè shang, měishù lǎoshī jiāo tóngxué men shǐyòng huánbǎo wú dú de gùtǐ jiāoshuǐ jiāng cǎizhǐ zhāntiē zài huàbǎn shang.', 'Trong giờ thủ công, cô giáo mỹ thuật dạy các em học sinh dùng keo dán khô thân thiện môi trường không độc hại để dán giấy màu lên bảng vẽ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2c34df3d-98f9-4e2d-8d50-9b48403bf77f'
);

-- [教训] (jiàoxun): bài học, dạy bảo
UPDATE public.vocabularies
SET example_hanzi = '我们应当认真吸取过去项目管理工作中因为沟通不畅导致的深刻教训，防止重蹈覆辙。',
    example_pinyin = 'Wǒmen yīngdāng rènzhēn xīqǔ guòqù xiàngmù guǎnlǐ gōngzuò zhōng yīnwèi gōutōng bú chàng dǎozhì de shēnkè jiàoxun, fángzhǐ chóngdǎofùzhé.',
    example_vi = 'Chúng ta cần nghiêm túc rút ra bài học đắt giá sâu sắc do giao tiếp chưa thông suốt gây ra trong quản lý dự án trước đây để tránh đi vào vết xe đổ.'
WHERE id = 'f4763e18-454c-420c-836d-53603f3924ef' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f4763e18-454c-420c-836d-53603f3924ef', '我们应当认真吸取过去项目管理工作中因为沟通不畅导致的深刻教训，防止重蹈覆辙。', 'Wǒmen yīngdāng rènzhēn xīqǔ guòqù xiàngmù guǎnlǐ gōngzuò zhōng yīnwèi gōutōng bú chàng dǎozhì de shēnkè jiàoxun, fángzhǐ chóngdǎofùzhé.', 'Chúng ta cần nghiêm túc rút ra bài học đắt giá sâu sắc do giao tiếp chưa thông suốt gây ra trong quản lý dự án trước đây để tránh đi vào vết xe đổ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f4763e18-454c-420c-836d-53603f3924ef'
);

-- [假设] (jiǎshè): giả thuyết, giả sử
UPDATE public.vocabularies
SET example_hanzi = '物理科学家首先在理论模型中提出了一项大胆科学假设，随后通过大型粒子对撞机实验验证了它。',
    example_pinyin = 'Wùlǐ kēxuéjiā shǒuxiān zài lǐlùn móxíng zhōng tíchū le yí xiàng dàdǎn kēxué jiǎshè, suíhòu tōngguò dàxíng lìzǐ duìzhuàngjī shíyàn yànzhèng le tā.',
    example_vi = 'Các nhà vật lý trước tiên đưa ra một giả thuyết khoa học táo bạo trong mô hình lý thuyết, sau đó đã xác minh nó thông qua thí nghiệm máy gia tốc hạt va chạm cỡ lớn.'
WHERE id = '889deebb-30a2-42bf-885c-60e166de13f6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '889deebb-30a2-42bf-885c-60e166de13f6', '物理科学家首先在理论模型中提出了一项大胆科学假设，随后通过大型粒子对撞机实验验证了它。', 'Wùlǐ kēxuéjiā shǒuxiān zài lǐlùn móxíng zhōng tíchū le yí xiàng dàdǎn kēxué jiǎshè, suíhòu tōngguò dàxíng lìzǐ duìzhuàngjī shíyàn yànzhèng le tā.', 'Các nhà vật lý trước tiên đưa ra một giả thuyết khoa học táo bạo trong mô hình lý thuyết, sau đó đã xác minh nó thông qua thí nghiệm máy gia tốc hạt va chạm cỡ lớn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '889deebb-30a2-42bf-885c-60e166de13f6'
);

-- [家属] (jiāshǔ): người nhà, thân nhân
UPDATE public.vocabularies
SET example_hanzi = '重症监护室门外的等候区里，几位患者家属正神情焦急地等待着主治医生介绍最新病情进展。',
    example_pinyin = 'Zhòngzhèng jiānhùshì ménwài de děnghòuqū lǐ, jǐ wèi huànzhě jiāshǔ zhèng shénqíng jiāojí de děngdài zhe zhǔzhì yīshēng jièshào zuìxīn bìngqíng jìnzhǎn.',
    example_vi = 'Ở khu vực chờ bên ngoài phòng hồi sức cấp cứu đặc biệt, mấy người nhà thân nhân của bệnh nhân đang nóng lòng chờ đợi bác sĩ điều trị thông báo tiến triển bệnh tình mới nhất.'
WHERE id = '11b55a15-22fe-4af9-9ab4-dc619688e14f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '11b55a15-22fe-4af9-9ab4-dc619688e14f', '重症监护室门外的等候区里，几位患者家属正神情焦急地等待着主治医生介绍最新病情进展。', 'Zhòngzhèng jiānhùshì ménwài de děnghòuqū lǐ, jǐ wèi huànzhě jiāshǔ zhèng shénqíng jiāojí de děngdài zhe zhǔzhì yīshēng jièshào zuìxīn bìngqíng jìnzhǎn.', 'Ở khu vực chờ bên ngoài phòng hồi sức cấp cứu đặc biệt, mấy người nhà thân nhân của bệnh nhân đang nóng lòng chờ đợi bác sĩ điều trị thông báo tiến triển bệnh tình mới nhất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '11b55a15-22fe-4af9-9ab4-dc619688e14f'
);

-- [即便] (jíbiàn): cho dù, ngay cả khi
UPDATE public.vocabularies
SET example_hanzi = '即便在前行道路上遭遇狂风骤雨与艰难险阻，真正志存高远的追梦人也绝不会轻言放弃退缩。',
    example_pinyin = 'Jìbiàn zài qiánxíng dàolù shang zāoyù kuángfēng-zhòuyǔ yǔ jiānnán xiǎnzǔ, zhēnzhèng zhìcúngāoyuǎn de zhuīmèngrén yě jué bú huì qīngyán fàngqì tuìsuō.',
    example_vi = 'Cho dù trên đường tiến bước gặp phải giông bão tơi bời và gian nan hiểm trở, người theo đuổi ước mơ thực sự có chí lớn cũng tuyệt đối không dễ dàng buông tay lùi bước.'
WHERE id = 'adf0f570-f6a0-4d08-a2fb-d5539b04fdb2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'adf0f570-f6a0-4d08-a2fb-d5539b04fdb2', '即便在前行道路上遭遇狂风骤雨与艰难险阻，真正志存高远的追梦人也绝不会轻言放弃退缩。', 'Jìbiàn zài qiánxíng dàolù shang zāoyù kuángfēng-zhòuyǔ yǔ jiānnán xiǎnzǔ, zhēnzhèng zhìcúngāoyuǎn de zhuīmèngrén yě jué bú huì qīngyán fàngqì tuìsuō.', 'Cho dù trên đường tiến bước gặp phải giông bão tơi bời và gian nan hiểm trở, người theo đuổi ước mơ thực sự có chí lớn cũng tuyệt đối không dễ dàng buông tay lùi bước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'adf0f570-f6a0-4d08-a2fb-d5539b04fdb2'
);

-- [基地] (jīdì): căn cứ, cơ sở
UPDATE public.vocabularies
SET example_hanzi = '国家级航天育种实验基地坐落在日照充沛的大西北戈壁边缘，培育出了许多高产农作物品种。',
    example_pinyin = 'Guójiājí hángtiān yùzhǒng shíyàn jīdì zuòluò zài rìzhào chōngpèi de dà xīběi gēbì biānyuán, péiyù chū le xǔduō gāochǎn nóngzuòwù pǐnzhǒng.',
    example_vi = 'Căn cứ cơ sở thí nghiệm nhân giống hàng không cấp quốc gia tọa lạc bên mép sa mạc Gobi vùng Tây Bắc tràn ngập ánh nắng, lai tạo ra rất nhiều giống cây trồng năng suất cao.'
WHERE id = 'efa783a4-b320-4e29-b2a6-790cb891215d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'efa783a4-b320-4e29-b2a6-790cb891215d', '国家级航天育种实验基地坐落在日照充沛的大西北戈壁边缘，培育出了许多高产农作物品种。', 'Guójiājí hángtiān yùzhǒng shíyàn jīdì zuòluò zài rìzhào chōngpèi de dà xīběi gēbì biānyuán, péiyù chū le xǔduō gāochǎn nóngzuòwù pǐnzhǒng.', 'Căn cứ cơ sở thí nghiệm nhân giống hàng không cấp quốc gia tọa lạc bên mép sa mạc Gobi vùng Tây Bắc tràn ngập ánh nắng, lai tạo ra rất nhiều giống cây trồng năng suất cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'efa783a4-b320-4e29-b2a6-790cb891215d'
);

-- [极端] (jíduān): cực đoan
UPDATE public.vocabularies
SET example_hanzi = '受全球厄尔尼诺气候异常现象影响，今年世界许多地区频繁遭遇极端干旱和特大暴雨灾害天气。',
    example_pinyin = 'Shòu quánqiú È''ěrnínuò qìhòu yìcháng xiànxiàng yǐngxiǎng, jīnnián shìjiè xǔduō dìqū pínfán zāoyù jíduān gānhàn hé tédà bàoyǔ zāihài tiānqì.',
    example_vi = 'Chịu tác động của hiện tượng khí hậu El Nino bất thường toàn cầu, năm nay nhiều nơi trên thế giới liên tục hứng chịu thời tiết thiên tai hạn hán cực đoan và mưa bão cực lớn.'
WHERE id = '22262e22-07af-43e7-9944-0ecb339b8046' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '22262e22-07af-43e7-9944-0ecb339b8046', '受全球厄尔尼诺气候异常现象影响，今年世界许多地区频繁遭遇极端干旱和特大暴雨灾害天气。', 'Shòu quánqiú È''ěrnínuò qìhòu yìcháng xiànxiàng yǐngxiǎng, jīnnián shìjiè xǔduō dìqū pínfán zāoyù jíduān gānhàn hé tédà bàoyǔ zāihài tiānqì.', 'Chịu tác động của hiện tượng khí hậu El Nino bất thường toàn cầu, năm nay nhiều nơi trên thế giới liên tục hứng chịu thời tiết thiên tai hạn hán cực đoan và mưa bão cực lớn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '22262e22-07af-43e7-9944-0ecb339b8046'
);

-- [接连] (jiē lián): liên tiếp, liên tục
UPDATE public.vocabularies
SET example_hanzi = '我国跳水健儿在本次世界游泳锦标赛决赛中发挥神勇，接连夺得了四枚极具含金量的单双人金牌。',
    example_pinyin = 'Wǒ guó tiàoshuǐ jiàn''ér zài běncì shìjiè yóuyǒng jǐnbiāosài juésài zhōng fāhuī shényǒng, jiēlián duódé le sì méi jí jù hánjīnliàng de dān-shuāngrén jīnpái.',
    example_vi = 'Các vận động viên nhảy cầu nước ta trong trận chung kết giải vô địch bơi lội thế giới đã thi đấu xuất thần, liên tiếp giành được 4 tấm huy chương vàng đơn đôi danh giá.'
WHERE id = 'f2c84bda-c164-4d9b-ba2f-ffbc9393eb3a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f2c84bda-c164-4d9b-ba2f-ffbc9393eb3a', '我国跳水健儿在本次世界游泳锦标赛决赛中发挥神勇，接连夺得了四枚极具含金量的单双人金牌。', 'Wǒ guó tiàoshuǐ jiàn''ér zài běncì shìjiè yóuyǒng jǐnbiāosài juésài zhōng fāhuī shényǒng, jiēlián duódé le sì méi jí jù hánjīnliàng de dān-shuāngrén jīnpái.', 'Các vận động viên nhảy cầu nước ta trong trận chung kết giải vô địch bơi lội thế giới đã thi đấu xuất thần, liên tiếp giành được 4 tấm huy chương vàng đơn đôi danh giá.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f2c84bda-c164-4d9b-ba2f-ffbc9393eb3a'
);

-- [杰出] (jiéchū): kiệt xuất, xuất sắc
UPDATE public.vocabularies
SET example_hanzi = '钱学森先生作为中国航天科技事业的杰出奠基人，为国家两弹一星国防现代化建设建立了卓越功勋。',
    example_pinyin = 'Qián Xuésēn xiānsheng zuòwéi Zhōngguó hángtiān kējì shìyè de jiéchū diànjīrén, wèi guójiā liǎngdàn-yìxīng guófáng xiàndàihuà jiànshè jiànlì le zhuóyuè gōngxūn.',
    example_vi = 'Nhà khoa học Tiền Học Sâm với tư cách là người đặt nền móng kiệt xuất cho sự nghiệp khoa học công nghệ vũ trụ Trung Quốc đã lập nên chiến công chói lọi cho công cuộc hiện đại hóa quốc phòng.'
WHERE id = '35013312-0aa8-4030-8881-8131b250b194' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '35013312-0aa8-4030-8881-8131b250b194', '钱学森先生作为中国航天科技事业的杰出奠基人，为国家两弹一星国防现代化建设建立了卓越功勋。', 'Qián Xuésēn xiānsheng zuòwéi Zhōngguó hángtiān kējì shìyè de jiéchū diànjīrén, wèi guójiā liǎngdàn-yìxīng guófáng xiàndàihuà jiànshè jiànlì le zhuóyuè gōngxūn.', 'Nhà khoa học Tiền Học Sâm với tư cách là người đặt nền móng kiệt xuất cho sự nghiệp khoa học công nghệ vũ trụ Trung Quốc đã lập nên chiến công chói lọi cho công cuộc hiện đại hóa quốc phòng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '35013312-0aa8-4030-8881-8131b250b194'
);

-- [解放] (jiěfàng): giải phóng
UPDATE public.vocabularies
SET example_hanzi = '新一轮人工智能与自动化工业技术的飞速进步，极大地解放了繁重的人类体力与重复性脑力劳动。',
    example_pinyin = 'Xīn yì lún réngōng zhìnéng yǔ zìdònghuà gōngyè jìshù de fēisù jìnbù, jídà de jiěfàng le fánzhòng de rénlèi tǐlì yǔ chóngfùxìng nǎolì láodòng.',
    example_vi = 'Bước tiến thần tốc của làn sóng công nghệ trí tuệ nhân tạo và công nghiệp tự động hóa mới đã giải phóng mạnh mẽ sức lao động thể lực nặng nhọc và trí óc lặp đi lặp lại của con người.'
WHERE id = '463cddcc-f7e2-4e5b-8c09-bf1dbc66f8a7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '463cddcc-f7e2-4e5b-8c09-bf1dbc66f8a7', '新一轮人工智能与自动化工业技术的飞速进步，极大地解放了繁重的人类体力与重复性脑力劳动。', 'Xīn yì lún réngōng zhìnéng yǔ zìdònghuà gōngyè jìshù de fēisù jìnbù, jídà de jiěfàng le fánzhòng de rénlèi tǐlì yǔ chóngfùxìng nǎolì láodòng.', 'Bước tiến thần tốc của làn sóng công nghệ trí tuệ nhân tạo và công nghiệp tự động hóa mới đã giải phóng mạnh mẽ sức lao động thể lực nặng nhọc và trí óc lặp đi lặp lại của con người.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '463cddcc-f7e2-4e5b-8c09-bf1dbc66f8a7'
);

-- [借鉴] (jièjiàn): tham khảo, rút kinh nghiệm
UPDATE public.vocabularies
SET example_hanzi = '我们在探索本土化现代化发展道路时，既要立足自身国情实际，也要积极借鉴世界各国有益文明成果。',
    example_pinyin = 'Wǒmen zài tànsuǒ běntǔhuà xiàndàihuà fāzhǎn dàolù shí, jì yào lìzú zìshēn guóqíng shíjì, yě yào jījí jièjiàn shìjiè gè guó yǒuyì wénmíng chéngguǒ.',
    example_vi = 'Khi khám phá con đường hiện đại hóa bản địa hóa, chúng ta vừa phải dựa vào thực tiễn tình hình đất nước mình, vừa cần tích cực tham khảo rút kinh nghiệm từ những thành quả văn minh có ích của các nước trên thế giới.'
WHERE id = '00e582d8-c7a2-4fec-a704-2d3982c35fa1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '00e582d8-c7a2-4fec-a704-2d3982c35fa1', '我们在探索本土化现代化发展道路时，既要立足自身国情实际，也要积极借鉴世界各国有益文明成果。', 'Wǒmen zài tànsuǒ běntǔhuà xiàndàihuà fāzhǎn dàolù shí, jì yào lìzú zìshēn guóqíng shíjì, yě yào jījí jièjiàn shìjiè gè guó yǒuyì wénmíng chéngguǒ.', 'Khi khám phá con đường hiện đại hóa bản địa hóa, chúng ta vừa phải dựa vào thực tiễn tình hình đất nước mình, vừa cần tích cực tham khảo rút kinh nghiệm từ những thành quả văn minh có ích của các nước trên thế giới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '00e582d8-c7a2-4fec-a704-2d3982c35fa1'
);

-- [结实] (jiēshi): chắc chắn, vạm vỡ
UPDATE public.vocabularies
SET example_hanzi = '常年在海岛风浪中锻炼生长的年轻水兵个个体魄结实、动作敏捷，洋溢着坚毅威武的英姿。',
    example_pinyin = 'Chángnián zài hǎidǎo fēnglàng zhōng duànliàn shēngzhǎng de niánqīng shuǐbīng gègè tǐpò jiēshi, dòngzuò mǐnjié, yángyì zhe jiānyì wēiwǔ de yīngzī.',
    example_vi = 'Những người lính thủy trẻ tuổi quanh năm rèn luyện trưởng thành giữa sóng gió biển đảo ai nấy đều có thân hình rắn rỏi chắc chắn, động tác nhanh nhẹn, toát lên vẻ oai phong kiên nghị.'
WHERE id = 'bf1b2caa-aca8-4998-91bb-e43a9da5e815' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bf1b2caa-aca8-4998-91bb-e43a9da5e815', '常年在海岛风浪中锻炼生长的年轻水兵个个体魄结实、动作敏捷，洋溢着坚毅威武的英姿。', 'Chángnián zài hǎidǎo fēnglàng zhōng duànliàn shēngzhǎng de niánqīng shuǐbīng gègè tǐpò jiēshi, dòngzuò mǐnjié, yángyì zhe jiānyì wēiwǔ de yīngzī.', 'Những người lính thủy trẻ tuổi quanh năm rèn luyện trưởng thành giữa sóng gió biển đảo ai nấy đều có thân hình rắn rỏi chắc chắn, động tác nhanh nhẹn, toát lên vẻ oai phong kiên nghị.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bf1b2caa-aca8-4998-91bb-e43a9da5e815'
);

-- [截至] (jiézhì): tính đến (thời điểm)
UPDATE public.vocabularies
SET example_hanzi = '截至今年九月底，全国新能源汽车产销量双双突破千万辆大关，占全球市场份额稳步提升。',
    example_pinyin = 'Jiézhì jīnnián jiǔ yuè dǐ, quánguó xīnnéngyuán qìchē chǎn-xiāoliàng shuāngshuāng tūpò qiānwàn liàng dàguān, zhàn quánqiú shìchǎng fèn''é wěnbù tíshēng.',
    example_vi = 'Tính đến cuối tháng 9 năm nay, cả sản lượng sản xuất và tiêu thụ xe năng lượng mới toàn quốc đều vượt mốc mười triệu chiếc, chiếm thị phần ổn định trên thị trường toàn cầu.'
WHERE id = '7a67c600-a345-4edb-aea3-ca46c44197b0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7a67c600-a345-4edb-aea3-ca46c44197b0', '截至今年九月底，全国新能源汽车产销量双双突破千万辆大关，占全球市场份额稳步提升。', 'Jiézhì jīnnián jiǔ yuè dǐ, quánguó xīnnéngyuán qìchē chǎn-xiāoliàng shuāngshuāng tūpò qiānwàn liàng dàguān, zhàn quánqiú shìchǎng fèn''é wěnbù tíshēng.', 'Tính đến cuối tháng 9 năm nay, cả sản lượng sản xuất và tiêu thụ xe năng lượng mới toàn quốc đều vượt mốc mười triệu chiếc, chiếm thị phần ổn định trên thị trường toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7a67c600-a345-4edb-aea3-ca46c44197b0'
);

-- [截止] (jiézhǐ): kết thúc, hết hạn
UPDATE public.vocabularies
SET example_hanzi = '本次全国青年科技创新成果孵化基金项目申报工作，将于本周五下午五点准时截止提交材料。',
    example_pinyin = 'Běncì quánguó qīngnián kējì chuàngxīn chéngguǒ fūhuà jījīn xiàngmù shēnbào gōngzuò, jiāng yú běn zhōuwǔ xiàwǔ wǔ diǎn zhǔnshí jiézhǐ tíjiāo cáiliào.',
    example_vi = 'Công tác nộp hồ sơ xin cấp vốn dự án quỹ ươm mầm sáng tạo khoa học công nghệ thanh niên toàn quốc lần này sẽ kết thúc hết hạn nộp tài liệu vào đúng 5 giờ chiều thứ sáu này.'
WHERE id = '55097f60-b7f0-4559-9867-c2e15cd9d0fe' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '55097f60-b7f0-4559-9867-c2e15cd9d0fe', '本次全国青年科技创新成果孵化基金项目申报工作，将于本周五下午五点准时截止提交材料。', 'Běncì quánguó qīngnián kējì chuàngxīn chéngguǒ fūhuà jījīn xiàngmù shēnbào gōngzuò, jiāng yú běn zhōuwǔ xiàwǔ wǔ diǎn zhǔnshí jiézhǐ tíjiāo cáiliào.', 'Công tác nộp hồ sơ xin cấp vốn dự án quỹ ươm mầm sáng tạo khoa học công nghệ thanh niên toàn quốc lần này sẽ kết thúc hết hạn nộp tài liệu vào đúng 5 giờ chiều thứ sáu này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '55097f60-b7f0-4559-9867-c2e15cd9d0fe'
);

-- [戒指] (jièzhi): nhẫn
UPDATE public.vocabularies
SET example_hanzi = '在亲朋好友热烈真诚的掌声与祝福声中，新郎满怀深情地为新娘戴上了闪耀的结婚钻戒戒指。',
    example_pinyin = 'Zài qīnpéng-hǎoyǒu rèliè zhēnchéng de zhǎngshēng yǔ zhùfúshēng zhōng, xīnláng mǎnhuái shēnqíng de wèi xīnniáng dài shang le shǎnyào de jiéhūn zuànjiè jièzhi.',
    example_vi = 'Trong tiếng vỗ tay và lời chúc phúc chân thành nồng nhiệt của bạn bè người thân, chú rể chứa chan tình cảm đeo chiếc nhẫn cưới kim cương lấp lánh lên tay cô dâu.'
WHERE id = 'da05decd-7277-4eab-99e0-0db4675bcd8d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'da05decd-7277-4eab-99e0-0db4675bcd8d', '在亲朋好友热烈真诚的掌声与祝福声中，新郎满怀深情地为新娘戴上了闪耀的结婚钻戒戒指。', 'Zài qīnpéng-hǎoyǒu rèliè zhēnchéng de zhǎngshēng yǔ zhùfúshēng zhōng, xīnláng mǎnhuái shēnqíng de wèi xīnniáng dài shang le shǎnyào de jiéhūn zuànjiè jièzhi.', 'Trong tiếng vỗ tay và lời chúc phúc chân thành nồng nhiệt của bạn bè người thân, chú rể chứa chan tình cảm đeo chiếc nhẫn cưới kim cương lấp lánh lên tay cô dâu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'da05decd-7277-4eab-99e0-0db4675bcd8d'
);

-- [借助] (jièzhù): nhờ vào, mượn cớ
UPDATE public.vocabularies
SET example_hanzi = '天体物理学家借助最新一代高灵敏度空间巡天望远镜，观测到了距地球百亿光年外的早期遥远星系。',
    example_pinyin = 'Tiāntǐ wùlǐxuéjiā jièzhù zuìxīn yídài gāo língmǐndù kōngjiān xúntiān wàngyuǎnjìng, guāncè dào le jù dìqiú bǎiyì guāngnián wài de zǎoqī yáoyuǎn xīngxì.',
    example_vi = 'Các nhà vật lý thiên văn nhờ vào kính viễn vọng không gian độ nhạy cao thế hệ mới nhất đã quan sát được các thiên hà xa xôi thuở ban đầu cách Trái Đất hàng chục tỷ năm ánh sáng.'
WHERE id = 'cfef3140-4cd8-4394-b045-de0d5aeaf6e0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cfef3140-4cd8-4394-b045-de0d5aeaf6e0', '天体物理学家借助最新一代高灵敏度空间巡天望远镜，观测到了距地球百亿光年外的早期遥远星系。', 'Tiāntǐ wùlǐxuéjiā jièzhù zuìxīn yídài gāo língmǐndù kōngjiān xúntiān wàngyuǎnjìng, guāncè dào le jù dìqiú bǎiyì guāngnián wài de zǎoqī yáoyuǎn xīngxì.', 'Các nhà vật lý thiên văn nhờ vào kính viễn vọng không gian độ nhạy cao thế hệ mới nhất đã quan sát được các thiên hà xa xôi thuở ban đầu cách Trái Đất hàng chục tỷ năm ánh sáng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cfef3140-4cd8-4394-b045-de0d5aeaf6e0'
);

-- [节奏] (jiézòu): tiết tấu, nhịp điệu
UPDATE public.vocabularies
SET example_hanzi = '现代大都市的日常工作与生活节奏十分快捷紧张，下班后散步听音乐有助于放松身心、调节压力。',
    example_pinyin = 'Xiàndài dà dūshì de rìcháng gōngzuò yǔ shēnghuó jiézòu shífēn kuàijié jǐnzhāng, xiàbān hòu sànbù tīng yīnyuè yǒuzhùyú fàngsōng shēnxīn, tiáojié yālì.',
    example_vi = 'Nhịp điệu tiết tấu công việc và cuộc sống hàng ngày tại các đô thị hiện đại rất nhanh và căng thẳng, sau giờ làm đi dạo nghe nhạc giúp thư giãn thể xác tinh thần và điều hòa áp lực.'
WHERE id = '84a449c8-fec5-459e-949c-d918ee038aaf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '84a449c8-fec5-459e-949c-d918ee038aaf', '现代大都市的日常工作与生活节奏十分快捷紧张，下班后散步听音乐有助于放松身心、调节压力。', 'Xiàndài dà dūshì de rìcháng gōngzuò yǔ shēnghuó jiézòu shífēn kuàijié jǐnzhāng, xiàbān hòu sànbù tīng yīnyuè yǒuzhùyú fàngsōng shēnxīn, tiáojié yālì.', 'Nhịp điệu tiết tấu công việc và cuộc sống hàng ngày tại các đô thị hiện đại rất nhanh và căng thẳng, sau giờ làm đi dạo nghe nhạc giúp thư giãn thể xác tinh thần và điều hòa áp lực.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '84a449c8-fec5-459e-949c-d918ee038aaf'
);

-- [激发] (jīfā): kích thích, khơi dậy
UPDATE public.vocabularies
SET example_hanzi = '优秀的科普讲座通过趣味互动实验，极大地激发了广大少年儿童探索浩瀚自然奥秘的求知欲。',
    example_pinyin = 'Yōuxiù de kěpǔ jiǎngzuò tōngguò qùwèi hùdòng shíyàn, jídà de jīfā le guǎngdà shàonián-értóng tànsuǒ hàohàn zìrán àomì de qiúzhīyù.',
    example_vi = 'Buổi thuyết trình phổ biến khoa học bổ ích qua các thí nghiệm tương tác thú vị đã khơi dậy mạnh mẽ lòng khát khao hiểu biết khám phá bí ẩn tự nhiên bao la của đông đảo thiếu nhi.'
WHERE id = '220ca331-247f-46b1-9d19-19c6af797a67' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '220ca331-247f-46b1-9d19-19c6af797a67', '优秀的科普讲座通过趣味互动实验，极大地激发了广大少年儿童探索浩瀚自然奥秘的求知欲。', 'Yōuxiù de kěpǔ jiǎngzuò tōngguò qùwèi hùdòng shíyàn, jídà de jīfā le guǎngdà shàonián-értóng tànsuǒ hàohàn zìrán àomì de qiúzhīyù.', 'Buổi thuyết trình phổ biến khoa học bổ ích qua các thí nghiệm tương tác thú vị đã khơi dậy mạnh mẽ lòng khát khao hiểu biết khám phá bí ẩn tự nhiên bao la của đông đảo thiếu nhi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '220ca331-247f-46b1-9d19-19c6af797a67'
);

-- [基金] (jījīn): quỹ
UPDATE public.vocabularies
SET example_hanzi = '国家自然科学基金设立专门重大科研专项，重点扶持青年学者开展前沿基础科学探索。',
    example_pinyin = 'Guójiā zìrán kēxué jījīn shèlì zhuānmén zhòngdà kēyán zhuānxiàng, zhòngdiǎn fúchí qīngnián xuézhě kāizhǎn qiányán jīchǔ kēxué tànsuǒ.',
    example_vi = 'Quỹ khoa học tự nhiên quốc gia thành lập chuyên đề nghiên cứu trọng điểm để nâng đỡ các học giả trẻ triển khai nghiên cứu khoa học cơ bản tiên phong.'
WHERE id = '6b14f75c-6ce4-4b24-9ef1-0c5fb49ec8fe' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6b14f75c-6ce4-4b24-9ef1-0c5fb49ec8fe', '国家自然科学基金设立专门重大科研专项，重点扶持青年学者开展前沿基础科学探索。', 'Guójiā zìrán kēxué jījīn shèlì zhuānmén zhòngdà kēyán zhuānxiàng, zhòngdiǎn fúchí qīngnián xuézhě kāizhǎn qiányán jīchǔ kēxué tànsuǒ.', 'Quỹ khoa học tự nhiên quốc gia thành lập chuyên đề nghiên cứu trọng điểm để nâng đỡ các học giả trẻ triển khai nghiên cứu khoa học cơ bản tiên phong.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6b14f75c-6ce4-4b24-9ef1-0c5fb49ec8fe'
);

-- [季军] (jìjūn): vị trí thứ ba, giải ba
UPDATE public.vocabularies
SET example_hanzi = '在经过五局鏖战的激烈女排半决赛中，客场作战的年轻队员顶住压力，最终荣获本次大赛的季军铜牌。',
    example_pinyin = 'Zài jīngguò wǔ jú áozhàn de jīliè nǚpái bànjuésài zhōng, kèchǎng zuòzhàn de niánqīng duìyuán dǐng zhù yālì, zuìzhōng rónghuò běncì dàsài de jìjūn tóngpái.',
    example_vi = 'Trong trận bán kết bóng chuyền nữ kịch tính sau 5 hiệp quyết liệt, các tuyển thủ trẻ thi đấu trên sân khách chịu vững áp lực và cuối cùng giành giải ba huy chương đồng giải đấu.'
WHERE id = 'e0f7b060-ddb6-4e40-89fe-2307f1ffc467' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e0f7b060-ddb6-4e40-89fe-2307f1ffc467', '在经过五局鏖战的激烈女排半决赛中，客场作战的年轻队员顶住压力，最终荣获本次大赛的季军铜牌。', 'Zài jīngguò wǔ jú áozhàn de jīliè nǚpái bànjuésài zhōng, kèchǎng zuòzhàn de niánqīng duìyuán dǐng zhù yālì, zuìzhōng rónghuò běncì dàsài de jìjūn tóngpái.', 'Trong trận bán kết bóng chuyền nữ kịch tính sau 5 hiệp quyết liệt, các tuyển thủ trẻ thi đấu trên sân khách chịu vững áp lực và cuối cùng giành giải ba huy chương đồng giải đấu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e0f7b060-ddb6-4e40-89fe-2307f1ffc467'
);

-- [激励] (jīlì): khích lệ, động viên
UPDATE public.vocabularies
SET example_hanzi = '革命英烈们不怕牺牲、忠诚报国的崇高气节，跨越时空始终激励着一代又一代中华儿女奋勇前进。',
    example_pinyin = 'Gémìng yīngliè men bú pà xīshēng, zhōngchéng bàoguó de chónggāo qìjié, kuàyuè shíkōng shǐzhōng jīlì zhe yídài yòu yídài Zhōnghuá érnǚ fènyǒng qiánjìn.',
    example_vi = 'Khí tiết thanh cao không sợ hy sinh hết lòng phụng sự đất nước của các anh hùng liệt sĩ cách mạng vượt qua thời không luôn khích lệ động viên bao thế hệ con Lạc cháu Hồng dũng cảm tiến bước.'
WHERE id = '5b7c549c-4f6d-4871-afbf-355d6e4b2f7d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5b7c549c-4f6d-4871-afbf-355d6e4b2f7d', '革命英烈们不怕牺牲、忠诚报国的崇高气节，跨越时空始终激励着一代又一代中华儿女奋勇前进。', 'Gémìng yīngliè men bú pà xīshēng, zhōngchéng bàoguó de chónggāo qìjié, kuàyuè shíkōng shǐzhōng jīlì zhe yídài yòu yídài Zhōnghuá érnǚ fènyǒng qiánjìn.', 'Khí tiết thanh cao không sợ hy sinh hết lòng phụng sự đất nước của các anh hùng liệt sĩ cách mạng vượt qua thời không luôn khích lệ động viên bao thế hệ con Lạc cháu Hồng dũng cảm tiến bước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5b7c549c-4f6d-4871-afbf-355d6e4b2f7d'
);

-- [纪律] (jìlǜ): kỷ luật
UPDATE public.vocabularies
SET example_hanzi = '一支拥有强大战斗力的高素质现代化军队，必须拥有铁一般严明的组织作风与政治纪律。',
    example_pinyin = 'Yì zhī yōngyǒu qiángdà zhàndòulì de gāo sùzhì xiàndàihuà jūnduì, bìxū yōngyǒu tiě yìbān yánmíng de zǔzhī zuòfēng yǔ zhèngzhì jìlǜ.',
    example_vi = 'Một đội quân hiện đại hóa tố chất cao sở hữu sức chiến đấu mạnh mẽ nhất thiết phải có phong cách tổ chức và kỷ luật chính trị nghiêm minh như sắt thép.'
WHERE id = '27048e6d-e02b-4a51-93b0-89229cfa0154' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '27048e6d-e02b-4a51-93b0-89229cfa0154', '一支拥有强大战斗力的高素质现代化军队，必须拥有铁一般严明的组织作风与政治纪律。', 'Yì zhī yōngyǒu qiángdà zhàndòulì de gāo sùzhì xiàndàihuà jūnduì, bìxū yōngyǒu tiě yìbān yánmíng de zǔzhī zuòfēng yǔ zhèngzhì jìlǜ.', 'Một đội quân hiện đại hóa tố chất cao sở hữu sức chiến đấu mạnh mẽ nhất thiết phải có phong cách tổ chức và kỷ luật chính trị nghiêm minh như sắt thép.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '27048e6d-e02b-4a51-93b0-89229cfa0154'
);

-- [寂寞] (jìmò): cô đơn, quạnh quẽ
UPDATE public.vocabularies
SET example_hanzi = '守卫在千里茫茫戈壁深处雷达站哨所的年轻战士，把对亲人的思念化作坚守寂寞岗位的执着奉献。',
    example_pinyin = 'Shǒuwèi zài qiānlǐ mángmáng gēbì shēnchù léidázhàn shàosuǒ de niánqīng zhànshì, bǎ duì qīnrén de sīniàn huàzuò jiānshǒu jìmò gǎngwèi de zhízhuó fèngxiàn.',
    example_vi = 'Người chiến sĩ trẻ gác trạm radar sâu trong lòng sa mạc mênh mông ngàn dặm đã biến nỗi nhớ người thân thành sự cống hiến kiên trì bám trụ vị trí quạnh quẽ cô đơn.'
WHERE id = '1311bf48-1f3e-49b8-9a4e-6db064922506' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1311bf48-1f3e-49b8-9a4e-6db064922506', '守卫在千里茫茫戈壁深处雷达站哨所的年轻战士，把对亲人的思念化作坚守寂寞岗位的执着奉献。', 'Shǒuwèi zài qiānlǐ mángmáng gēbì shēnchù léidázhàn shàosuǒ de niánqīng zhànshì, bǎ duì qīnrén de sīniàn huàzuò jiānshǒu jìmò gǎngwèi de zhízhuó fèngxiàn.', 'Người chiến sĩ trẻ gác trạm radar sâu trong lòng sa mạc mênh mông ngàn dặm đã biến nỗi nhớ người thân thành sự cống hiến kiên trì bám trụ vị trí quạnh quẽ cô đơn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1311bf48-1f3e-49b8-9a4e-6db064922506'
);

-- [进而] (jìn'ér): tiếp đó, hơn nữa
UPDATE public.vocabularies
SET example_hanzi = '我们应当首先切实做好生活垃圾的源头分类减量，进而推进整个城市生态资源的高效循环回收利用。',
    example_pinyin = 'Wǒmen yīngdāng shǒuxiān qièshí zuò hǎo shēnghuó lājī de yuántóu fēnlèi jiǎnliàng, jìn''ér tuījìn zhěng gè chéngshì shēngtài zīyuán de gāoxiào xúnhuán huíshōu lìyòng.',
    example_vi = 'Chúng ta trước hết cần làm tốt việc phân loại giảm thiểu rác thải sinh hoạt ngay từ đầu nguồn, tiếp đó hơn nữa thúc đẩy việc tái chế tận dụng tuần hoàn hiệu quả tài nguyên sinh thái toàn thành phố.'
WHERE id = '5c148527-3431-40a9-9944-992bcd712dab' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5c148527-3431-40a9-9944-992bcd712dab', '我们应当首先切实做好生活垃圾的源头分类减量，进而推进整个城市生态资源的高效循环回收利用。', 'Wǒmen yīngdāng shǒuxiān qièshí zuò hǎo shēnghuó lājī de yuántóu fēnlèi jiǎnliàng, jìn''ér tuījìn zhěng gè chéngshì shēngtài zīyuán de gāoxiào xúnhuán huíshōu lìyòng.', 'Chúng ta trước hết cần làm tốt việc phân loại giảm thiểu rác thải sinh hoạt ngay từ đầu nguồn, tiếp đó hơn nữa thúc đẩy việc tái chế tận dụng tuần hoàn hiệu quả tài nguyên sinh thái toàn thành phố.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5c148527-3431-40a9-9944-992bcd712dab'
);

-- [井] (jǐng): cái giếng
UPDATE public.vocabularies
SET example_hanzi = '古村落中央这口开凿于宋代的老水井水源甘冽清甜，百年来始终日夜滋养着依井而居的乡里百姓。',
    example_pinyin = 'Gǔcūnluò zhōngyāng zhè kǒu kāizáo yú Sòngdài de lǎo shuǐjǐng shuǐyuán gānliè qīngtián, bǎinián lái shǐzhōng rìyè zīyǎng zhe yī jǐng ér jū de xiānglǐ bǎixìng.',
    example_vi = 'Chiếc giếng nước cổ đào từ thời nhà Tống ở giữa ngôi làng cổ dòng nước ngọt mát lành, trăm năm qua ngày đêm nuôi nấng biết bao người dân xóm giềng sống quanh miệng giếng.'
WHERE id = 'f7404a84-7a4c-429a-8ff7-29dc9e86bc4f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f7404a84-7a4c-429a-8ff7-29dc9e86bc4f', '古村落中央这口开凿于宋代的老水井水源甘冽清甜，百年来始终日夜滋养着依井而居的乡里百姓。', 'Gǔcūnluò zhōngyāng zhè kǒu kāizáo yú Sòngdài de lǎo shuǐjǐng shuǐyuán gānliè qīngtián, bǎinián lái shǐzhōng rìyè zīyǎng zhe yī jǐng ér jū de xiānglǐ bǎixìng.', 'Chiếc giếng nước cổ đào từ thời nhà Tống ở giữa ngôi làng cổ dòng nước ngọt mát lành, trăm năm qua ngày đêm nuôi nấng biết bao người dân xóm giềng sống quanh miệng giếng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f7404a84-7a4c-429a-8ff7-29dc9e86bc4f'
);

-- [惊讶] (jīng yà): ngạc nhiên, sửng sốt
UPDATE public.vocabularies
SET example_hanzi = '当魔术师在万众瞩目下奇迹般地让舞台中央巨大的机械飞机瞬间消失时，全场观众无不感到目瞪口呆与极度惊讶。',
    example_pinyin = 'Dāng móshùshī zài wànzhòng-zhǔmù xià qíjì bān de ràng wǔtái zhōngyāng jùdà de jīxiè fēijī shùnjiān xiāoshī shí, quánchǎng guānzhòng wúbù gǎndào mùdèng-kǒudāi yǔ jídù jīngyà.',
    example_vi = 'Khi nhà ảo thuật tài ba biến chiếc máy bay cơ khí khổng lồ ở giữa sân khấu biến mất trong chớp mắt trước sự chứng kiến của mọi người, toàn thể khán giả ai nấy đều tròn mắt há hốc mồm ngạc nhiên sửng sốt tột cùng.'
WHERE id = 'f04d153a-a886-48c8-98ef-7fceefb64170' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f04d153a-a886-48c8-98ef-7fceefb64170', '当魔术师在万众瞩目下奇迹般地让舞台中央巨大的机械飞机瞬间消失时，全场观众无不感到目瞪口呆与极度惊讶。', 'Dāng móshùshī zài wànzhòng-zhǔmù xià qíjì bān de ràng wǔtái zhōngyāng jùdà de jīxiè fēijī shùnjiān xiāoshī shí, quánchǎng guānzhòng wúbù gǎndào mùdèng-kǒudāi yǔ jídù jīngyà.', 'Khi nhà ảo thuật tài ba biến chiếc máy bay cơ khí khổng lồ ở giữa sân khấu biến mất trong chớp mắt trước sự chứng kiến của mọi người, toàn thể khán giả ai nấy đều tròn mắt há hốc mồm ngạc nhiên sửng sốt tột cùng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f04d153a-a886-48c8-98ef-7fceefb64170'
);

-- [警告] (jǐnggào): cảnh cáo
UPDATE public.vocabularies
SET example_hanzi = '针对违规排放未经处理工业废水的重污染企业，环保行政执法大队下达了责令限期停产整顿的行政警告惩处书。',
    example_pinyin = 'Zhēnduì wéiguī páifàng wèijīng chǔlǐ gōngyè fèishuǐ de zhòng wūrǎn qǐyè, huánbǎo xíngzhèng zhífǎ dàduì xiàdá le zélìng xiànqī tíngchǎn zhěngdùn de xíngzhèng jǐnggào chéngchǔ shū.',
    example_vi = 'Đối với doanh nghiệp xả trộm nước thải công nghiệp ô nhiễm chưa qua xử lý, đội thanh tra môi trường đã ban hành quyết định xử phạt cảnh cáo hành chính buộc tạm dừng sản xuất để khắc phục.'
WHERE id = '505b449e-4963-4c74-9e72-25b5063745d1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '505b449e-4963-4c74-9e72-25b5063745d1', '针对违规排放未经处理工业废水的重污染企业，环保行政执法大队下达了责令限期停产整顿的行政警告惩处书。', 'Zhēnduì wéiguī páifàng wèijīng chǔlǐ gōngyè fèishuǐ de zhòng wūrǎn qǐyè, huánbǎo xíngzhèng zhífǎ dàduì xiàdá le zélìng xiànqī tíngchǎn zhěngdùn de xíngzhèng jǐnggào chéngchǔ shū.', 'Đối với doanh nghiệp xả trộm nước thải công nghiệp ô nhiễm chưa qua xử lý, đội thanh tra môi trường đã ban hành quyết định xử phạt cảnh cáo hành chính buộc tạm dừng sản xuất để khắc phục.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '505b449e-4963-4c74-9e72-25b5063745d1'
);

-- [精确] (jīngquè): chính xác, chuẩn xác
UPDATE public.vocabularies
SET example_hanzi = '经过多轮严密理论建模推算与精密测量仪器校正，科研团队最终获取了空间飞行器精确的重返大气层轨道参数。',
    example_pinyin = 'Jīngguò duō lún yánmì lǐlùn jiànmó tuīsuàn yǔ jīngmì cèliáng yíqì jiàozhèng, kēyán tuánduì zuìzhōng huòqǔ le kōngjiān fēixíngqì jīngquè de zhòngfǎn dàqìcéng guǐdào cānshù.',
    example_vi = 'Sau nhiều vòng mô hình hóa lý thuyết và hiệu chuẩn bằng dụng cụ đo đạc chính xác, nhóm nghiên cứu đã thu được các thông số quỹ đạo chính xác khi tàu bay vũ trụ quay lại bầu khí quyển.'
WHERE id = 'a0731a4a-e59f-490c-857b-4dcbe6805a79' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a0731a4a-e59f-490c-857b-4dcbe6805a79', '经过多轮严密理论建模推算与精密测量仪器校正，科研团队最终获取了空间飞行器精确的重返大气层轨道参数。', 'Jīngguò duō lún yánmì lǐlùn jiànmó tuīsuàn yǔ jīngmì cèliáng yíqì jiàozhèng, kēyán tuánduì zuìzhōng huòqǔ le kōngjiān fēixíngqì jīngquè de zhòngfǎn dàqìcéng guǐdào cānshù.', 'Sau nhiều vòng mô hình hóa lý thuyết và hiệu chuẩn bằng dụng cụ đo đạc chính xác, nhóm nghiên cứu đã thu được các thông số quỹ đạo chính xác khi tàu bay vũ trụ quay lại bầu khí quyển.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a0731a4a-e59f-490c-857b-4dcbe6805a79'
);

-- [竞赛] (jìngsài): thi đấu, đua tranh
UPDATE public.vocabularies
SET example_hanzi = '来自全国各大名校的上万名优秀大学生代表汇聚一堂，参与全国大学生数学建模与程序设计竞赛角逐。',
    example_pinyin = 'Láizì quánguó gè dà míngxiào de shàngwàn míng yōuxiù dàxuésheng dàibiǎo huìjù-yìtáng, cānyù quánguó dàxuésheng shùxué jiànmó yǔ chéngxù shèjì jìngsài jiǎozhú.',
    example_vi = 'Hàng vạn sinh viên ưu tú từ các trường đại học danh tiếng cả nước đã tề tựu tranh tài trong cuộc thi mô hình hóa toán học và thiết kế thuật toán lập trình sinh viên toàn quốc.'
WHERE id = '456f11df-cc6b-407a-a2af-5bf7bcfec2bd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '456f11df-cc6b-407a-a2af-5bf7bcfec2bd', '来自全国各大名校的上万名优秀大学生代表汇聚一堂，参与全国大学生数学建模与程序设计竞赛角逐。', 'Láizì quánguó gè dà míngxiào de shàngwàn míng yōuxiù dàxuésheng dàibiǎo huìjù-yìtáng, cānyù quánguó dàxuésheng shùxué jiànmó yǔ chéngxù shèjì jìngsài jiǎozhú.', 'Hàng vạn sinh viên ưu tú từ các trường đại học danh tiếng cả nước đã tề tựu tranh tài trong cuộc thi mô hình hóa toán học và thiết kế thuật toán lập trình sinh viên toàn quốc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '456f11df-cc6b-407a-a2af-5bf7bcfec2bd'
);

-- [经商] (jīngshāng): kinh doanh
UPDATE public.vocabularies
SET example_hanzi = '浙商群体历来具有敢为人先的拼搏闯劲和诚信守法的优良商业传统，在海内外经商投资领域享有良好声誉。',
    example_pinyin = 'Zhèshāng qúntǐ lìlái jùyǒu gǎnwèirénxiān de pīnbó chuǎngjìn hé chéngxìn shǒufǎ de yōuliáng shāngyè chuántǒng, zài hǎinèiwài jīngshāng tóuzī lǐngyù xiǎngyǒu liánghǎo shēngyù.',
    example_vi = 'Cộng đồng thương gia Chiết Giang từ xưa đã có tinh thần dám nghĩ dám làm và truyền thống kinh doanh giữ chữ tín thượng tôn pháp luật, có danh tiếng vang dội trong lĩnh vực kinh doanh đầu tư trong và ngoài nước.'
WHERE id = '4ef74753-e5b1-443a-b127-b96747c5e1c6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4ef74753-e5b1-443a-b127-b96747c5e1c6', '浙商群体历来具有敢为人先的拼搏闯劲和诚信守法的优良商业传统，在海内外经商投资领域享有良好声誉。', 'Zhèshāng qúntǐ lìlái jùyǒu gǎnwèirénxiān de pīnbó chuǎngjìn hé chéngxìn shǒufǎ de yōuliáng shāngyè chuántǒng, zài hǎinèiwài jīngshāng tóuzī lǐngyù xiǎngyǒu liánghǎo shēngyù.', 'Cộng đồng thương gia Chiết Giang từ xưa đã có tinh thần dám nghĩ dám làm và truyền thống kinh doanh giữ chữ tín thượng tôn pháp luật, có danh tiếng vang dội trong lĩnh vực kinh doanh đầu tư trong và ngoài nước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4ef74753-e5b1-443a-b127-b96747c5e1c6'
);

-- [精通] (jīngtōng): tinh thông, thành thạo
UPDATE public.vocabularies
SET example_hanzi = '这位在跨国联合组织长期从事同声传译工作的资深外语专家，精通汉、英、法三种联合国官方工作语言。',
    example_pinyin = 'Zhè wèi zài kuàguó liánhé zǔzhī chángqī cóngshì tóngshēng-chuányì gōngzuò de zīshēn wàiyǔ zhuānjiā, jīngtōng Hàn, Yīng, Fǎ sān zhǒng Liánhéguó guānfāng gōngzuò yǔyán.',
    example_vi = 'Chuyên gia ngoại ngữ kỳ cựu chuyên làm phiên dịch cabin song song tại các tổ chức quốc tế này tinh thông thành thạo ba thứ tiếng làm việc chính thức của Liên Hợp Quốc là tiếng Trung, Anh và Pháp.'
WHERE id = '147fe42a-052f-4446-a701-3967cbdf40f2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '147fe42a-052f-4446-a701-3967cbdf40f2', '这位在跨国联合组织长期从事同声传译工作的资深外语专家，精通汉、英、法三种联合国官方工作语言。', 'Zhè wèi zài kuàguó liánhé zǔzhī chángqī cóngshì tóngshēng-chuányì gōngzuò de zīshēn wàiyǔ zhuānjiā, jīngtōng Hàn, Yīng, Fǎ sān zhǒng Liánhéguó guānfāng gōngzuò yǔyán.', 'Chuyên gia ngoại ngữ kỳ cựu chuyên làm phiên dịch cabin song song tại các tổ chức quốc tế này tinh thông thành thạo ba thứ tiếng làm việc chính thức của Liên Hợp Quốc là tiếng Trung, Anh và Pháp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '147fe42a-052f-4446-a701-3967cbdf40f2'
);

-- [镜头] (jìngtóu): ống kính, cảnh quay
UPDATE public.vocabularies
SET example_hanzi = '自然地理摄影大师穿行在大兴安岭冰雪原始森林之间，用高清长焦镜头记录下了东北虎敏捷跃起的珍贵瞬间。',
    example_pinyin = 'Zìrán dìlǐ shèyǐng dàshī chuānxíng zài Dàxīng''ānlǐng bīngxuě yuánshǐ sēnlín zhījiān, yòng gāoqīng chángjiāo jìngtóu jìlù xià le dōngběihǔ mǐnjié yuèqǐ de zhēnguì shùnjiān.',
    example_vi = 'Bậc thầy nhiếp ảnh địa lý tự nhiên băng qua rừng nguyên sinh tuyết trắng dãy Đại Hưng An, dùng ống kính tele siêu nét ghi lại khoảnh khắc quý giá khi con hổ Siberia bật nhảy thoăn thoắt.'
WHERE id = 'ecb1ca4b-f0fa-4a96-9cf7-3bc25a8caca8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ecb1ca4b-f0fa-4a96-9cf7-3bc25a8caca8', '自然地理摄影大师穿行在大兴安岭冰雪原始森林之间，用高清长焦镜头记录下了东北虎敏捷跃起的珍贵瞬间。', 'Zìrán dìlǐ shèyǐng dàshī chuānxíng zài Dàxīng''ānlǐng bīngxuě yuánshǐ sēnlín zhījiān, yòng gāoqīng chángjiāo jìngtóu jìlù xià le dōngběihǔ mǐnjié yuèqǐ de zhēnguì shùnjiān.', 'Bậc thầy nhiếp ảnh địa lý tự nhiên băng qua rừng nguyên sinh tuyết trắng dãy Đại Hưng An, dùng ống kính tele siêu nét ghi lại khoảnh khắc quý giá khi con hổ Siberia bật nhảy thoăn thoắt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ecb1ca4b-f0fa-4a96-9cf7-3bc25a8caca8'
);

-- [精心] (jīngxīn): tỉ mỉ, tận tâm
UPDATE public.vocabularies
SET example_hanzi = '在农业园艺园丁的精心培育与照料下，珍稀的名贵兰花在温室里悄然绽放，散发出沁人心脾的淡雅清香。',
    example_pinyin = 'Zài nóngyè yuányì yuándīng de jīngxīn péiyù yǔ zhàoliào xià, zhēnxī de míngguì lánhuā zài wēnshì lǐ qiǎorán zhànfàng, sànfā chū qìnrénxīnpí de dànyǎ qīngxiāng.',
    example_vi = 'Dưới sự chăm sóc nuôi dưỡng tận tâm tỉ mỉ của người làm vườn hoa viên, giống lan quý hiếm đã lặng lẽ bung nở trong nhà kính, tỏa ra mùi hương thanh nhã ngát hương lòng người.'
WHERE id = '8a869b4f-13ce-4bc5-8a76-869a73414022' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8a869b4f-13ce-4bc5-8a76-869a73414022', '在农业园艺园丁的精心培育与照料下，珍稀的名贵兰花在温室里悄然绽放，散发出沁人心脾的淡雅清香。', 'Zài nóngyè yuányì yuándīng de jīngxīn péiyù yǔ zhàoliào xià, zhēnxī de míngguì lánhuā zài wēnshì lǐ qiǎorán zhànfàng, sànfā chū qìnrénxīnpí de dànyǎ qīngxiāng.', 'Dưới sự chăm sóc nuôi dưỡng tận tâm tỉ mỉ của người làm vườn hoa viên, giống lan quý hiếm đã lặng lẽ bung nở trong nhà kính, tỏa ra mùi hương thanh nhã ngát hương lòng người.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8a869b4f-13ce-4bc5-8a76-869a73414022'
);

-- [精致] (jīngzhì): tinh tế, tinh xảo
UPDATE public.vocabularies
SET example_hanzi = '江南古典园林中的亭台楼阁与假山池沼布局精妙绝伦，门窗木雕更是做工极其精致细腻、巧夺天工。',
    example_pinyin = 'Jiāngnán gǔdiǎn yuánlín zhōng de tíngtái-lóugé yǔ jiǎshān-chízhǎo bùjú jīngmiào-juélún, ménchuāng mùdiāo gèng shì zuògōng jíqí jīngzhì xìnì, qiǎoduótiāngōng.',
    example_vi = 'Lầu gác đình đài và non bộ ao sen trong vườn cảnh cổ điển Giang Nam bố cục tuyệt diệu khôn xiết, điêu khắc gỗ nơi cửa sổ càng tinh xảo tinh tế đạt đến độ xuất thần tuyệt tác.'
WHERE id = 'aec5d9a2-30f7-47b5-8ab4-8bce877d5b94' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'aec5d9a2-30f7-47b5-8ab4-8bce877d5b94', '江南古典园林中的亭台楼阁与假山池沼布局精妙绝伦，门窗木雕更是做工极其精致细腻、巧夺天工。', 'Jiāngnán gǔdiǎn yuánlín zhōng de tíngtái-lóugé yǔ jiǎshān-chízhǎo bùjú jīngmiào-juélún, ménchuāng mùdiāo gèng shì zuògōng jíqí jīngzhì xìnì, qiǎoduótiāngōng.', 'Lầu gác đình đài và non bộ ao sen trong vườn cảnh cổ điển Giang Nam bố cục tuyệt diệu khôn xiết, điêu khắc gỗ nơi cửa sổ càng tinh xảo tinh tế đạt đến độ xuất thần tuyệt tác.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'aec5d9a2-30f7-47b5-8ab4-8bce877d5b94'
);

-- [颈椎] (jǐngzhuī): đốt sống cổ
UPDATE public.vocabularies
SET example_hanzi = '骨科医生提醒长期久坐面对电脑办公的职场白领，应当每隔一小时起立活动舒展颈椎与腰背部肌肉。',
    example_pinyin = 'Gǔkē yīshēng tíxǐng chángqī jiǔzuò miànduì diànnǎo bàngōng de zhíchǎng báilǐng, yīngdāng měi gé yì xiǎoshí qǐlì huódòng shūzhǎn jǐngzhuī yǔ yāobèibù jīròu.',
    example_vi = 'Bác sĩ chỉnh hình xương khớp nhắc nhở nhân viên văn phòng ngồi làm việc trước máy tính lâu nên cứ sau mỗi tiếng thì đứng dậy vận động thả lỏng các đốt sống cổ và cơ bắp vùng lưng hông.'
WHERE id = 'b517873e-3697-40b2-8da8-5ad5a83e7b35' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b517873e-3697-40b2-8da8-5ad5a83e7b35', '骨科医生提醒长期久坐面对电脑办公的职场白领，应当每隔一小时起立活动舒展颈椎与腰背部肌肉。', 'Gǔkē yīshēng tíxǐng chángqī jiǔzuò miànduì diànnǎo bàngōng de zhíchǎng báilǐng, yīngdāng měi gé yì xiǎoshí qǐlì huódòng shūzhǎn jǐngzhuī yǔ yāobèibù jīròu.', 'Bác sĩ chỉnh hình xương khớp nhắc nhở nhân viên văn phòng ngồi làm việc trước máy tính lâu nên cứ sau mỗi tiếng thì đứng dậy vận động thả lỏng các đốt sống cổ và cơ bắp vùng lưng hông.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b517873e-3697-40b2-8da8-5ad5a83e7b35'
);

-- [进化] (jìnhuà): tiến hóa
UPDATE public.vocabularies
SET example_hanzi = '生物学达尔文自然选择学说揭示了地球上形形色色的物种在漫长地质岁月中适应自然环境的进化历程。',
    example_pinyin = 'Shēngwùxué Dá''ěrwén zìrán xuǎnzé xuéshuō jiēshì le dìqiú shang xíngxíng-sèsè de wùzhǒng zài màncháng dìzhì suìyuè zhōng shìyìng zìrán huánjìng de jìnhuà lìchéng.',
    example_vi = 'Học thuyết chọn lọc tự nhiên Darwin trong sinh học đã vạch rõ tiến trình tiến hóa thích nghi môi trường tự nhiên trong suốt năm tháng địa chất dài đằng đẵng của muôn loài trên Trái Đất.'
WHERE id = '329592c7-e961-4367-a286-506c1dacc12a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '329592c7-e961-4367-a286-506c1dacc12a', '生物学达尔文自然选择学说揭示了地球上形形色色的物种在漫长地质岁月中适应自然环境的进化历程。', 'Shēngwùxué Dá''ěrwén zìrán xuǎnzé xuéshuō jiēshì le dìqiú shang xíngxíng-sèsè de wùzhǒng zài màncháng dìzhì suìyuè zhōng shìyìng zìrán huánjìng de jìnhuà lìchéng.', 'Học thuyết chọn lọc tự nhiên Darwin trong sinh học đã vạch rõ tiến trình tiến hóa thích nghi môi trường tự nhiên trong suốt năm tháng địa chất dài đằng đẵng của muôn loài trên Trái Đất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '329592c7-e961-4367-a286-506c1dacc12a'
);

-- [近来] (jìnlái): dạo này, gần đây
UPDATE public.vocabularies
SET example_hanzi = '近来全国许多地区推行的政务服务数字化一站式办理举措，切实方便了广大人民群众与经营主体办事。',
    example_pinyin = 'Jìnlái quánguó xǔduō dìqū tuīxíng de zhèngwù fúwù shùzìhuà yízhànshì bànlǐ jǔcuò, qièshí fāngbiàn le guǎngdà rénmín qúnzhòng yǔ jīngyíng zhǔtǐ bànshì.',
    example_vi = 'Gần đây giải pháp xử lý một cửa số hóa các thủ tục hành chính công được triển khai tại nhiều địa phương cả nước đã tạo thuận lợi thực chất cho người dân và doanh nghiệp làm thủ tục.'
WHERE id = '25c5d7fc-4717-462e-ad39-44a8d80de58d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '25c5d7fc-4717-462e-ad39-44a8d80de58d', '近来全国许多地区推行的政务服务数字化一站式办理举措，切实方便了广大人民群众与经营主体办事。', 'Jìnlái quánguó xǔduō dìqū tuīxíng de zhèngwù fúwù shùzìhuà yízhànshì bànlǐ jǔcuò, qièshí fāngbiàn le guǎngdà rénmín qúnzhòng yǔ jīngyíng zhǔtǐ bànshì.', 'Gần đây giải pháp xử lý một cửa số hóa các thủ tục hành chính công được triển khai tại nhiều địa phương cả nước đã tạo thuận lợi thực chất cho người dân và doanh nghiệp làm thủ tục.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '25c5d7fc-4717-462e-ad39-44a8d80de58d'
);

-- [金融] (jīnróng): tài chính
UPDATE public.vocabularies
SET example_hanzi = '健全现代中央银行制度与加强宏观审慎监管体系，是防范化解系统性金融风险、保障实体经济平稳发展的核心基石。',
    example_pinyin = 'Jiànquán xiàndài zhōngyāng yínháng zhìdù yǔ jiāqiáng hóngguān shěnshèn jiānguǎn tǐxì, shì fángfàn huàjiě xìtǒngxìng jīnróng fēngxiǎn, bǎozhàng shítǐ jīngjì píngwěn fāzhǎn de héxīn jīshí.',
    example_vi = 'Hoàn thiện chế độ ngân hàng trung ương hiện đại và tăng cường hệ thống giám sát an toàn vĩ mô là nền tảng cốt lõi phòng ngừa hóa giải rủi ro tài chính mang tính hệ thống, bảo đảm nền kinh tế thực phát triển vững vàng.'
WHERE id = 'c0c4a11a-3d5d-4e82-960a-4a3b6a608851' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c0c4a11a-3d5d-4e82-960a-4a3b6a608851', '健全现代中央银行制度与加强宏观审慎监管体系，是防范化解系统性金融风险、保障实体经济平稳发展的核心基石。', 'Jiànquán xiàndài zhōngyāng yínháng zhìdù yǔ jiāqiáng hóngguān shěnshèn jiānguǎn tǐxì, shì fángfàn huàjiě xìtǒngxìng jīnróng fēngxiǎn, bǎozhàng shítǐ jīngjì píngwěn fāzhǎn de héxīn jīshí.', 'Hoàn thiện chế độ ngân hàng trung ương hiện đại và tăng cường hệ thống giám sát an toàn vĩ mô là nền tảng cốt lõi phòng ngừa hóa giải rủi ro tài chính mang tính hệ thống, bảo đảm nền kinh tế thực phát triển vững vàng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c0c4a11a-3d5d-4e82-960a-4a3b6a608851'
);

COMMIT;
