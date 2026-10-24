-- ==============================================================================;
-- MIGRATION: 20261024010000_hsk6_batch4_186_examples.sql;
-- Nạp 186 câu ví dụ HSK 6 Đợt 4 (Q - X: 确立 -> 协调) vào vocabularies và vocabulary_examples;
-- Chuẩn đề cương HSK 3.0 (CTI 11/2025), câu ví dụ văn cảnh hiện đại, Pinyin có dấu, dịch chuẩn nghĩa;
-- ==============================================================================;

BEGIN;

-- [确立] (quèlì): xác lập, thiết lập
UPDATE public.vocabularies
SET example_hanzi = '经过多年的艰苦探索，该企业终于在激烈的行业竞争中确立了自己的核心竞争优势。',
    example_pinyin = 'Jīngguò duōnián de jiānkǔ tànsuǒ, gāi qǐyè zhōngyú zài jīliè de hángyè jìngzhēng zhōng quèlì le zìjǐ de héxīn jìngzhēng yōushì.',
    example_vi = 'Trải qua nhiều năm tìm tòi gian khổ, doanh nghiệp này cuối cùng đã xác lập được lợi thế cạnh tranh cốt lõi của mình trong cuộc cạnh tranh ngành khốc liệt.'
WHERE id = 'd6b7da60-119d-41db-8de7-255132ade62e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd6b7da60-119d-41db-8de7-255132ade62e', '经过多年的艰苦探索，该企业终于在激烈的行业竞争中确立了自己的核心竞争优势。', 'Jīngguò duōnián de jiānkǔ tànsuǒ, gāi qǐyè zhōngyú zài jīliè de hángyè jìngzhēng zhōng quèlì le zìjǐ de héxīn jìngzhēng yōushì.', 'Trải qua nhiều năm tìm tòi gian khổ, doanh nghiệp này cuối cùng đã xác lập được lợi thế cạnh tranh cốt lõi của mình trong cuộc cạnh tranh ngành khốc liệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd6b7da60-119d-41db-8de7-255132ade62e'
);

-- [区分] (qūfēn): phân biệt, chia ra
UPDATE public.vocabularies
SET example_hanzi = '在学术研究中，学者必须严格区分客观事实与研究者的主观推论。',
    example_pinyin = 'Zài xuéshù yánjiū zhōng, xuézhě bìxū yángé qūfēn kèguān shìshí yǔ yánjiūzhě de zhǔguān tuīlùn.',
    example_vi = 'Trong nghiên cứu học thuật, học giả cần phải phân biệt rạch ròi giữa sự thật khách quan và suy luận chủ quan của người nghiên cứu.'
WHERE id = '2a99cb0a-fe53-42be-ac7c-a644c18724d8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2a99cb0a-fe53-42be-ac7c-a644c18724d8', '在学术研究中，学者必须严格区分客观事实与研究者的主观推论。', 'Zài xuéshù yánjiū zhōng, xuézhě bìxū yángé qūfēn kèguān shìshí yǔ yánjiūzhě de zhǔguān tuīlùn.', 'Trong nghiên cứu học thuật, học giả cần phải phân biệt rạch ròi giữa sự thật khách quan và suy luận chủ quan của người nghiên cứu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2a99cb0a-fe53-42be-ac7c-a644c18724d8'
);

-- [群众] (qún zhòng): quần chúng
UPDATE public.vocabularies
SET example_hanzi = '基层干部应当深入广大人民群众，虚心倾听大家的呼声与实际诉求。',
    example_pinyin = 'Jīcéng gànbù yīngdāng shēnrù guǎngdà rénmín qúnzhòng, xūxīn qīngtīng dàjiā de hūshēng yǔ shíjì sùqiú.',
    example_vi = 'Cán bộ cơ sở cần đi sâu vào quần chúng nhân dân rộng rãi, khiêm tốn lắng nghe tiếng lòng và những nguyện vọng thiết thực của mọi người.'
WHERE id = 'b35c4c3b-ec29-4f27-9e34-df611f3a79e7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b35c4c3b-ec29-4f27-9e34-df611f3a79e7', '基层干部应当深入广大人民群众，虚心倾听大家的呼声与实际诉求。', 'Jīcéng gànbù yīngdāng shēnrù guǎngdà rénmín qúnzhòng, xūxīn qīngtīng dàjiā de hūshēng yǔ shíjì sùqiú.', 'Cán bộ cơ sở cần đi sâu vào quần chúng nhân dân rộng rãi, khiêm tốn lắng nghe tiếng lòng và những nguyện vọng thiết thực của mọi người.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b35c4c3b-ec29-4f27-9e34-df611f3a79e7'
);

-- [趣味] (qùwèi): thú vị, hứng thú
UPDATE public.vocabularies
SET example_hanzi = '这本科普读物兼具科学性与趣味，深受广大小读者的由衷喜爱。',
    example_pinyin = 'Zhè běn kēpǔ dúwù jiānjù kēxuéxìng yǔ qùwèi, shēn shòu guǎngdà xiǎo dúzhě de yóuzhōng xǐ''ài.',
    example_vi = 'Cuốn sách phổ biến khoa học này vừa có tính khoa học lại vừa đậm tính hứng thú, được đông đảo độc giả nhỏ tuổi hết lòng yêu mến.'
WHERE id = '8fcb1066-bfae-4a9f-84eb-ce3142ce3a6e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8fcb1066-bfae-4a9f-84eb-ce3142ce3a6e', '这本科普读物兼具科学性与趣味，深受广大小读者的由衷喜爱。', 'Zhè běn kēpǔ dúwù jiānjù kēxuéxìng yǔ qùwèi, shēn shòu guǎngdà xiǎo dúzhě de yóuzhōng xǐ''ài.', 'Cuốn sách phổ biến khoa học này vừa có tính khoa học lại vừa đậm tính hứng thú, được đông đảo độc giả nhỏ tuổi hết lòng yêu mến.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8fcb1066-bfae-4a9f-84eb-ce3142ce3a6e'
);

-- [染] (rǎn): nhuộm, lây lan
UPDATE public.vocabularies
SET example_hanzi = '秋风渐起，漫山遍野的树叶都被染成了如火如荼的金红色。',
    example_pinyin = 'Qiūfēng jiàn qǐ, mànshān-biànyě de shùyè dōu bèi rǎn chéng le rúhuǒ-rútú de jīnhóng sè.',
    example_vi = 'Gió thu dần thổi, lá cây khắp rừng núi đều bị nhuộm thành một sắc đỏ vàng rực rỡ như lửa.'
WHERE id = '6387593c-9014-4183-a95d-f81b30101e05' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6387593c-9014-4183-a95d-f81b30101e05', '秋风渐起，漫山遍野的树叶都被染成了如火如荼的金红色。', 'Qiūfēng jiàn qǐ, mànshān-biànyě de shùyè dōu bèi rǎn chéng le rúhuǒ-rútú de jīnhóng sè.', 'Gió thu dần thổi, lá cây khắp rừng núi đều bị nhuộm thành một sắc đỏ vàng rực rỡ như lửa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6387593c-9014-4183-a95d-f81b30101e05'
);

-- [热门] (rèmén): sốt dẻo, được ưa chuộng
UPDATE public.vocabularies
SET example_hanzi = '人工智能与大数据分析已成为当今全球高等院校中最热门的专业方向之一。',
    example_pinyin = 'Réngōng zhìnéng yǔ dà shùjù fēnxī yǐ chéngwéi dāngjīn quánqiú gāoděng yuànxiào zhōng zuì rèmén de zhuānyè fāngxiàng zhīyī.',
    example_vi = 'Trí tuệ nhân tạo và phân tích dữ liệu lớn đã trở thành một trong những chuyên ngành sốt dẻo nhất tại các trường đại học toàn cầu hiện nay.'
WHERE id = 'd0d88213-5f19-4615-8729-633e3a4ef958' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd0d88213-5f19-4615-8729-633e3a4ef958', '人工智能与大数据分析已成为当今全球高等院校中最热门的专业方向之一。', 'Réngōng zhìnéng yǔ dà shùjù fēnxī yǐ chéngwéi dāngjīn quánqiú gāoděng yuànxiào zhōng zuì rèmén de zhuānyè fāngxiàng zhīyī.', 'Trí tuệ nhân tạo và phân tích dữ liệu lớn đã trở thành một trong những chuyên ngành sốt dẻo nhất tại các trường đại học toàn cầu hiện nay.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd0d88213-5f19-4615-8729-633e3a4ef958'
);

-- [忍受] (rěn shòu): chịu đựng, nhẫn nhịn
UPDATE public.vocabularies
SET example_hanzi = '为了顺利完成这项重大工程，科研人员长年忍受着偏远高原的严寒与寂寞。',
    example_pinyin = 'Wèile shùnlì wánchéng zhè xiàng zhòngdà gōngchéng, kēyán rényuán chángnián rěnshòu zhe piānyuǎn gāoyuán de yánhán yǔ jìmò.',
    example_vi = 'Để hoàn thành thuận lợi công trình trọng đại này, các nhân viên nghiên cứu khoa học quanh năm phải chịu đựng cái giá rét và nỗi cô đơn nơi cao nguyên hẻo lánh.'
WHERE id = 'b4f7f1b1-ba1b-444e-a737-6dd54090d4f7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b4f7f1b1-ba1b-444e-a737-6dd54090d4f7', '为了顺利完成这项重大工程，科研人员长年忍受着偏远高原的严寒与寂寞。', 'Wèile shùnlì wánchéng zhè xiàng zhòngdà gōngchéng, kēyán rényuán chángnián rěnshòu zhe piānyuǎn gāoyuán de yánhán yǔ jìmò.', 'Để hoàn thành thuận lợi công trình trọng đại này, các nhân viên nghiên cứu khoa học quanh năm phải chịu đựng cái giá rét và nỗi cô đơn nơi cao nguyên hẻo lánh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b4f7f1b1-ba1b-444e-a737-6dd54090d4f7'
);

-- [认定] (rèndìng): nhận định, khẳng định
UPDATE public.vocabularies
SET example_hanzi = '权威司法鉴定机构最终认定，该起事故并非自然灾害而是严重的人为过失所致。',
    example_pinyin = 'Quánwēi sīfǎ jiàndìng jīgòu zuìzhōng rèndìng, gāi qǐ shìgù bìng fēi zìrán zāihài ér shì yánzhòng de rénwéi guòshī suǒ zhì.',
    example_vi = 'Cơ quan giám định tư pháp có thẩm quyền cuối cùng nhận định rằng, vụ tai nạn đó không phải thiên tai mà do lỗi bất cẩn nghiêm trọng của con người gây ra.'
WHERE id = '5ee5c8e3-ac84-42b8-b7d3-4b56a1d402f8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5ee5c8e3-ac84-42b8-b7d3-4b56a1d402f8', '权威司法鉴定机构最终认定，该起事故并非自然灾害而是严重的人为过失所致。', 'Quánwēi sīfǎ jiàndìng jīgòu zuìzhōng rèndìng, gāi qǐ shìgù bìng fēi zìrán zāihài ér shì yánzhòng de rénwéi guòshī suǒ zhì.', 'Cơ quan giám định tư pháp có thẩm quyền cuối cùng nhận định rằng, vụ tai nạn đó không phải thiên tai mà do lỗi bất cẩn nghiêm trọng của con người gây ra.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5ee5c8e3-ac84-42b8-b7d3-4b56a1d402f8'
);

-- [仍旧] (réngjiù): vẫn, vẫn như cũ
UPDATE public.vocabularies
SET example_hanzi = '尽管历经数十年的沧桑巨变，老校区门口的那棵古槐树仍旧郁郁葱葱。',
    example_pinyin = 'Jǐnguǎn lìjīng shùshí nián de cāngsāng jùbiàn, lǎo xiàoqū ménkǒu de nà kē gǔ huáishù réngjiù yùyù-cōngcōng.',
    example_vi = 'Mặc dù đã trải qua hàng chục năm biến thiên dâu bể, cây hoè cổ thụ trước cổng khu học xá cũ vẫn tươi tốt sum suê như xưa.'
WHERE id = '71424656-82f8-49e0-99b4-3ddc17f7daf6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '71424656-82f8-49e0-99b4-3ddc17f7daf6', '尽管历经数十年的沧桑巨变，老校区门口的那棵古槐树仍旧郁郁葱葱。', 'Jǐnguǎn lìjīng shùshí nián de cāngsāng jùbiàn, lǎo xiàoqū ménkǒu de nà kē gǔ huáishù réngjiù yùyù-cōngcōng.', 'Mặc dù đã trải qua hàng chục năm biến thiên dâu bể, cây hoè cổ thụ trước cổng khu học xá cũ vẫn tươi tốt sum suê như xưa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '71424656-82f8-49e0-99b4-3ddc17f7daf6'
);

-- [人家] (rénjia): người ta, nhà người khác
UPDATE public.vocabularies
SET example_hanzi = '未经人家事先允许，随意翻阅别人的私人物品是非常不礼貌的失态行为。',
    example_pinyin = 'Wèijīng rénjia shìxiān yǔnxǔ, suíyì fānyuè biérén de sīrén wùpǐn shì fēicháng bù lǐmào de shītài xíngwéi.',
    example_vi = 'Khi chưa được người ta cho phép trước, tùy tiện lục lọi đồ đạc cá nhân của người khác là hành vi vô phép tắc rất thiếu lịch sự.'
WHERE id = '7987de10-e5bc-4bfa-9ffb-ff27e04cb881' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7987de10-e5bc-4bfa-9ffb-ff27e04cb881', '未经人家事先允许，随意翻阅别人的私人物品是非常不礼貌的失态行为。', 'Wèijīng rénjia shìxiān yǔnxǔ, suíyì fānyuè biérén de sīrén wùpǐn shì fēicháng bù lǐmào de shītài xíngwéi.', 'Khi chưa được người ta cho phép trước, tùy tiện lục lọi đồ đạc cá nhân của người khác là hành vi vô phép tắc rất thiếu lịch sự.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7987de10-e5bc-4bfa-9ffb-ff27e04cb881'
);

-- [认可] (rènkě): công nhận, thừa nhận
UPDATE public.vocabularies
SET example_hanzi = '他的严谨治学态度不仅获得了同行学者的高度认可，也赢得了国际学术界的广泛赞誉。',
    example_pinyin = 'Tā de yánjǐn zhìxué tàidù bùjǐn huòdé le tóngháng xuézhě de gāodù rènkě, yě yíngdé le guójì xuéshùjiè de guǎngfàn zànyù.',
    example_vi = 'Thái độ nghiên cứu nghiêm cẩn của ông không chỉ nhận được sự công nhận cao từ các học giả đồng nghiệp, mà còn giành được sự tán thưởng rộng rãi của giới học thuật quốc tế.'
WHERE id = '9e116743-8c40-405f-bfb9-d1354fdb1acb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9e116743-8c40-405f-bfb9-d1354fdb1acb', '他的严谨治学态度不仅获得了同行学者的高度认可，也赢得了国际学术界的广泛赞誉。', 'Tā de yánjǐn zhìxué tàidù bùjǐn huòdé le tóngháng xuézhě de gāodù rènkě, yě yíngdé le guójì xuéshùjiè de guǎngfàn zànyù.', 'Thái độ nghiên cứu nghiêm cẩn của ông không chỉ nhận được sự công nhận cao từ các học giả đồng nghiệp, mà còn giành được sự tán thưởng rộng rãi của giới học thuật quốc tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9e116743-8c40-405f-bfb9-d1354fdb1acb'
);

-- [人士] (rénshì): nhân sĩ, giới, người
UPDATE public.vocabularies
SET example_hanzi = '来自医学界的权威专业人士一致呼吁，公众应当重视预防慢性疾病的日常健康管理。',
    example_pinyin = 'Láizì yīxuéjiè de quánwēi zhuānyè rénshì yízhì hūyù, gōngzhòng yīngdāng zhòngshì yùfáng mànxìng jíbìng de rìcháng jiànkāng guǎnlǐ.',
    example_vi = 'Các nhân sĩ chuyên môn uy tín đến từ giới y học đồng thanh kêu gọi công chúng cần coi trọng việc quản lý sức khỏe hằng ngày nhằm phòng ngừa các bệnh mạn tính.'
WHERE id = 'aee00d5f-a523-4c7c-ad85-bc0e43205453' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'aee00d5f-a523-4c7c-ad85-bc0e43205453', '来自医学界的权威专业人士一致呼吁，公众应当重视预防慢性疾病的日常健康管理。', 'Láizì yīxuéjiè de quánwēi zhuānyè rénshì yízhì hūyù, gōngzhòng yīngdāng zhòngshì yùfáng mànxìng jíbìng de rìcháng jiànkāng guǎnlǐ.', 'Các nhân sĩ chuyên môn uy tín đến từ giới y học đồng thanh kêu gọi công chúng cần coi trọng việc quản lý sức khỏe hằng ngày nhằm phòng ngừa các bệnh mạn tính.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'aee00d5f-a523-4c7c-ad85-bc0e43205453'
);

-- [人事] (rénshì): nhân sự
UPDATE public.vocabularies
SET example_hanzi = '随着跨国公司业务架构的调整，总部人事部门近期重新梳理了各岗位的职责与考核标准。',
    example_pinyin = 'Suízhe kuàguó gōngsī yèwù jiàgòu de tiáozhěng, zǒngbù rénshì bùmén jìnqī chóngxīn shūlǐ le gè gǎngwèi de zhízé yǔ kǎohé biāozhǔn.',
    example_vi = 'Cùng với sự điều chỉnh cơ cấu kinh doanh của công ty đa quốc gia, phòng nhân sự trụ sở chính gần đây đã rà soát lại chức trách và tiêu chuẩn đánh giá của các vị trí.'
WHERE id = '0ed5056e-354a-4ada-bd61-253659c08822' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0ed5056e-354a-4ada-bd61-253659c08822', '随着跨国公司业务架构的调整，总部人事部门近期重新梳理了各岗位的职责与考核标准。', 'Suízhe kuàguó gōngsī yèwù jiàgòu de tiáozhěng, zǒngbù rénshì bùmén jìnqī chóngxīn shūlǐ le gè gǎngwèi de zhízé yǔ kǎohé biāozhǔn.', 'Cùng với sự điều chỉnh cơ cấu kinh doanh của công ty đa quốc gia, phòng nhân sự trụ sở chính gần đây đã rà soát lại chức trách và tiêu chuẩn đánh giá của các vị trí.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0ed5056e-354a-4ada-bd61-253659c08822'
);

-- [人为] (rénwéi): do con người, nhân tạo
UPDATE public.vocabularies
SET example_hanzi = '调查专家组明确指出，此次电网瘫痪并非恶劣暴风雪引发，而是人为操作失误酿成的。',
    example_pinyin = 'Diàochá zhuānjiā zǔ míngquè zhǐchū, cǐ cì diànwǎng tānhuān bìng fēi èliè bàofēngxuě yǐnfā, ér shì rénwéi cāozuò shīwù niàngchéng de.',
    example_vi = 'Tổ chuyên gia điều tra chỉ rõ rằng, sự cố tê liệt lưới điện lần này không phải do bão tuyết khốc liệt gây ra, mà là do lỗi thao tác của con người tạo nên.'
WHERE id = 'd8a76652-06d0-40ee-b057-4e39c9e18074' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd8a76652-06d0-40ee-b057-4e39c9e18074', '调查专家组明确指出，此次电网瘫痪并非恶劣暴风雪引发，而是人为操作失误酿成的。', 'Diàochá zhuānjiā zǔ míngquè zhǐchū, cǐ cì diànwǎng tānhuān bìng fēi èliè bàofēngxuě yǐnfā, ér shì rénwéi cāozuò shīwù niàngchéng de.', 'Tổ chuyên gia điều tra chỉ rõ rằng, sự cố tê liệt lưới điện lần này không phải do bão tuyết khốc liệt gây ra, mà là do lỗi thao tác của con người tạo nên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd8a76652-06d0-40ee-b057-4e39c9e18074'
);

-- [日益] (rìyì): ngày càng
UPDATE public.vocabularies
SET example_hanzi = '随着全球化进程的不断加深，跨国界文化交流与多语种互通显得日益紧迫与关键。',
    example_pinyin = 'Suízhe quánqiúhuà jìnchéng de bùduàn jiāshēn, kuà guójiè wénhuà jiāoliú yǔ duō yǔzhǒng hùtōng xiǎnde rìyì jǐnpò yǔ guānjiàn.',
    example_vi = 'Cùng với tiến trình toàn cầu hóa không ngừng sâu sắc, việc giao lưu văn hóa xuyên biên giới và liên thông đa ngôn ngữ ngày càng trở nên cấp bách và then chốt.'
WHERE id = '6d0a4911-b6ea-4aed-9f54-5a737fb581bd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6d0a4911-b6ea-4aed-9f54-5a737fb581bd', '随着全球化进程的不断加深，跨国界文化交流与多语种互通显得日益紧迫与关键。', 'Suízhe quánqiúhuà jìnchéng de bùduàn jiāshēn, kuà guójiè wénhuà jiāoliú yǔ duō yǔzhǒng hùtōng xiǎnde rìyì jǐnpò yǔ guānjiàn.', 'Cùng với tiến trình toàn cầu hóa không ngừng sâu sắc, việc giao lưu văn hóa xuyên biên giới và liên thông đa ngôn ngữ ngày càng trở nên cấp bách và then chốt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6d0a4911-b6ea-4aed-9f54-5a737fb581bd'
);

-- [融化] (rónghuà): tan chảy
UPDATE public.vocabularies
SET example_hanzi = '初春温暖明媚的阳光驱散了严寒，山谷里封冻数月的积雪开始渐渐融化。',
    example_pinyin = 'Chūchūn wēnnuǎn míngmèi de yángguāng qūsàn le yánhán, shāngǔ lǐ fēngdòng shù yuè de jīxuě kāishǐ jiànjiàn rónghuà.',
    example_vi = 'Ánh nắng ấm áp rạng rỡ của đầu xuân đã xua tan giá rét, lớp tuyết đóng băng nhiều tháng trong thung lũng bắt đầu dần dần tan chảy.'
WHERE id = 'c8600842-7bc4-49ba-ae9e-42a54870622e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c8600842-7bc4-49ba-ae9e-42a54870622e', '初春温暖明媚的阳光驱散了严寒，山谷里封冻数月的积雪开始渐渐融化。', 'Chūchūn wēnnuǎn míngmèi de yángguāng qūsàn le yánhán, shāngǔ lǐ fēngdòng shù yuè de jīxuě kāishǐ jiànjiàn rónghuà.', 'Ánh nắng ấm áp rạng rỡ của đầu xuân đã xua tan giá rét, lớp tuyết đóng băng nhiều tháng trong thung lũng bắt đầu dần dần tan chảy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c8600842-7bc4-49ba-ae9e-42a54870622e'
);

-- [荣誉] (róngyù): danh dự
UPDATE public.vocabularies
SET example_hanzi = '这位老科学家将国家最高科学技术奖的无上荣誉归功于整个科研团队的默契协作。',
    example_pinyin = 'Zhè wèi lǎo kēxuéjiā jiāng guójiā zuìgāo kēxué jìshù jiǎng de wúshàng róngyù guīgōng yú zhěnggè kēyán tuánduì de mòqì xiézuò.',
    example_vi = 'Nhà khoa học lão thành đã quy vinh dự tối cao của Giải thưởng Khoa học Công nghệ Quốc gia cho sự hợp tác ăn ý của toàn thể đội ngũ nghiên cứu.'
WHERE id = 'b8bc5409-a6ed-4e08-aa9c-5d3ac5bcf90c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b8bc5409-a6ed-4e08-aa9c-5d3ac5bcf90c', '这位老科学家将国家最高科学技术奖的无上荣誉归功于整个科研团队的默契协作。', 'Zhè wèi lǎo kēxuéjiā jiāng guójiā zuìgāo kēxué jìshù jiǎng de wúshàng róngyù guīgōng yú zhěnggè kēyán tuánduì de mòqì xiézuò.', 'Nhà khoa học lão thành đã quy vinh dự tối cao của Giải thưởng Khoa học Công nghệ Quốc gia cho sự hợp tác ăn ý của toàn thể đội ngũ nghiên cứu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b8bc5409-a6ed-4e08-aa9c-5d3ac5bcf90c'
);

-- [弱点] (ruò diǎn): điểm yếu
UPDATE public.vocabularies
SET example_hanzi = '一名真正成熟高超的棋手，善于在瞬息万变的对局中敏锐捕捉对手的致命弱点。',
    example_pinyin = 'Yì míng zhēnzhèng chéngshú gāochāo de qíshǒu, shànyú zài shùnxī-wànbiàn de duìjú zhōng mǐnruì bǔzhuō duìshǒu de zhìmìng ruòdiǎn.',
    example_vi = 'Một kỳ thủ thực sự thành thục và cao cường luôn giỏi việc nắm bắt nhạy bén điểm yếu chí mạng của đối thủ giữa thế cờ biến ảo khôn lường.'
WHERE id = '5b2b8391-cfd8-41d9-8110-ea177a6a4150' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5b2b8391-cfd8-41d9-8110-ea177a6a4150', '一名真正成熟高超的棋手，善于在瞬息万变的对局中敏锐捕捉对手的致命弱点。', 'Yì míng zhēnzhèng chéngshú gāochāo de qíshǒu, shànyú zài shùnxī-wànbiàn de duìjú zhōng mǐnruì bǔzhuō duìshǒu de zhìmìng ruòdiǎn.', 'Một kỳ thủ thực sự thành thục và cao cường luôn giỏi việc nắm bắt nhạy bén điểm yếu chí mạng của đối thủ giữa thế cờ biến ảo khôn lường.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5b2b8391-cfd8-41d9-8110-ea177a6a4150'
);

-- [散发] (sànfā): tỏa ra, phát ra, phát tờ rơi
UPDATE public.vocabularies
SET example_hanzi = '雨后的茉莉花园里弥漫着清新的泥土芬芳，散发出一缕缕沁人心脾的幽香。',
    example_pinyin = 'Yǔ hòu de mòlì huāyuán lǐ mímàn zhe qīngxīn de nítǔ fēnfāng, sànfā chū yì lǚlǚ qìnrénxīnpí de yōuxiāng.',
    example_vi = 'Khu vườn hoa nhài sau cơn mưa thoang thoảng hương đất tinh khôi, tỏa ra từng làn hương thơm thanh khiết thấm đượm lòng người.'
WHERE id = '532c29a6-5888-447f-b6dd-a0c0167be2da' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '532c29a6-5888-447f-b6dd-a0c0167be2da', '雨后的茉莉花园里弥漫着清新的泥土芬芳，散发出一缕缕沁人心脾的幽香。', 'Yǔ hòu de mòlì huāyuán lǐ mímàn zhe qīngxīn de nítǔ fēnfāng, sànfā chū yì lǚlǚ qìnrénxīnpí de yōuxiāng.', 'Khu vườn hoa nhài sau cơn mưa thoang thoảng hương đất tinh khôi, tỏa ra từng làn hương thơm thanh khiết thấm đượm lòng người.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '532c29a6-5888-447f-b6dd-a0c0167be2da'
);

-- [丧失] (sàng shī): đánh mất, mất đi
UPDATE public.vocabularies
SET example_hanzi = '突如其来的强烈地震让这座繁华的沿海城市在短时间内彻底丧失了供电和通信功能。',
    example_pinyin = 'Tūrúqílái de qiángliè dìzhèn ràng zhè zuò fánhuá de yánhǎi chéngshì zài duǎn shíjiān nèi chèdǐ sàngshī le gōngdiàn hé tōngxìn gōngnéng.',
    example_vi = 'Trận động đất mạnh bất ngờ ập đến khiến thành phố ven biển phồn hoa này trong thoáng chốc mất đi hoàn toàn chức năng cấp điện và thông tin liên lạc.'
WHERE id = '82652f5b-743b-4daa-9203-3794af8bba31' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '82652f5b-743b-4daa-9203-3794af8bba31', '突如其来的强烈地震让这座繁华的沿海城市在短时间内彻底丧失了供电和通信功能。', 'Tūrúqílái de qiángliè dìzhèn ràng zhè zuò fánhuá de yánhǎi chéngshì zài duǎn shíjiān nèi chèdǐ sàngshī le gōngdiàn hé tōngxìn gōngnéng.', 'Trận động đất mạnh bất ngờ ập đến khiến thành phố ven biển phồn hoa này trong thoáng chốc mất đi hoàn toàn chức năng cấp điện và thông tin liên lạc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '82652f5b-743b-4daa-9203-3794af8bba31'
);

-- [散文] (sǎnwén): tản văn, văn xuôi
UPDATE public.vocabularies
SET example_hanzi = '先生的抒情散文辞藻优美动人，字里行间无不流淌着对故土山川与亲人的深切眷恋。',
    example_pinyin = 'Xiānsheng de shūqíng sǎnwén cízǎo yōuměi dòngrén, zìlǐ-hángjiān wúbù liútǎng zhe duì gùtǔ shānchuān yǔ qīnrén de shēnqiè juànliàn.',
    example_vi = 'Những áng tản văn trữ tình của tiên sinh ngôn từ đẹp đẽ cảm động, giữa các con chữ không đâu là không chan chứa nỗi quyến luyến sâu nặng với núi sông quê hương và người thân.'
WHERE id = '8da2fec0-34ae-405a-9403-a88c94e7ace8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8da2fec0-34ae-405a-9403-a88c94e7ace8', '先生的抒情散文辞藻优美动人，字里行间无不流淌着对故土山川与亲人的深切眷恋。', 'Xiānsheng de shūqíng sǎnwén cízǎo yōuměi dòngrén, zìlǐ-hángjiān wúbù liútǎng zhe duì gùtǔ shānchuān yǔ qīnrén de shēnqiè juànliàn.', 'Những áng tản văn trữ tình của tiên sinh ngôn từ đẹp đẽ cảm động, giữa các con chữ không đâu là không chan chứa nỗi quyến luyến sâu nặng với núi sông quê hương và người thân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8da2fec0-34ae-405a-9403-a88c94e7ace8'
);

-- [杀] (shā): giết, sát hại
UPDATE public.vocabularies
SET example_hanzi = '这种新型广谱抗菌药物能够有效杀灭耐药性细菌，极大地降低了术后感染风险。',
    example_pinyin = 'Zhè zhǒng xīnxíng guǎngpǔ kàngjūn yàowù nénggòu yǒuxiào shāmiè nàiyàoxìng xìjūn, jídà de jiàngdī le shùhòu gǎnrǎn fēngxiǎn.',
    example_vi = 'Loại thuốc kháng khuẩn phổ rộng mới này có thể tiêu diệt vi khuẩn kháng thuốc một cách hữu hiệu, giảm thiểu tối đa nguy cơ nhiễm trùng sau phẫu thuật.'
WHERE id = '194e7307-892e-4464-8e3a-9b95f8ad125d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '194e7307-892e-4464-8e3a-9b95f8ad125d', '这种新型广谱抗菌药物能够有效杀灭耐药性细菌，极大地降低了术后感染风险。', 'Zhè zhǒng xīnxíng guǎngpǔ kàngjūn yàowù nénggòu yǒuxiào shāmiè nàiyàoxìng xìjūn, jídà de jiàngdī le shùhòu gǎnrǎn fēngxiǎn.', 'Loại thuốc kháng khuẩn phổ rộng mới này có thể tiêu diệt vi khuẩn kháng thuốc một cách hữu hiệu, giảm thiểu tối đa nguy cơ nhiễm trùng sau phẫu thuật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '194e7307-892e-4464-8e3a-9b95f8ad125d'
);

-- [刹车] (shāchē): hãm phanh, đạp phanh
UPDATE public.vocabularies
SET example_hanzi = '面对突然冲向路中央的流浪犬，经验丰富的司机沉着冷静地紧急踩下了刹车。',
    example_pinyin = 'Miànduì tūrán chōng xiàng lù zhōngyāng de liúlàng quǎn, jīngyàn fēngfù de sījī chénzhuó lěngjìng de jǐnjí cǎi xià le shāchē.',
    example_vi = 'Đối mặt với chú chó hoang bất ngờ lao ra giữa lòng đường, người tài xế giàu kinh nghiệm đã bình tĩnh đạp phanh khẩn cấp.'
WHERE id = 'ecda2ccf-1326-42a4-8803-0caf6ea0d96e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ecda2ccf-1326-42a4-8803-0caf6ea0d96e', '面对突然冲向路中央的流浪犬，经验丰富的司机沉着冷静地紧急踩下了刹车。', 'Miànduì tūrán chōng xiàng lù zhōngyāng de liúlàng quǎn, jīngyàn fēngfù de sījī chénzhuó lěngjìng de jǐnjí cǎi xià le shāchē.', 'Đối mặt với chú chó hoang bất ngờ lao ra giữa lòng đường, người tài xế giàu kinh nghiệm đã bình tĩnh đạp phanh khẩn cấp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ecda2ccf-1326-42a4-8803-0caf6ea0d96e'
);

-- [筛选] (shāixuǎn): sàng lọc, chọn lựa
UPDATE public.vocabularies
SET example_hanzi = '人力资源部门从上千份海内外求职简历中，严格筛选出了二十名最具潜力的候选人。',
    example_pinyin = 'Rénlì zīyuán bùmén cóng shàng qiān fèn hǎinèiwài qiúzhí jiǎnlì zhōng, yángé shāixuǎn chū le èrshí míng zuì jù qiánlì de hòuxuǎnrén.',
    example_vi = 'Bộ phận nhân sự từ hàng ngàn bản hồ sơ xin việc trong và ngoài nước đã sàng lọc nghiêm ngặt ra 20 ứng viên giàu tiềm năng nhất.'
WHERE id = '83c74683-b6c1-4eff-9467-c9e829b71240' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '83c74683-b6c1-4eff-9467-c9e829b71240', '人力资源部门从上千份海内外求职简历中，严格筛选出了二十名最具潜力的候选人。', 'Rénlì zīyuán bùmén cóng shàng qiān fèn hǎinèiwài qiúzhí jiǎnlì zhōng, yángé shāixuǎn chū le èrshí míng zuì jù qiánlì de hòuxuǎnrén.', 'Bộ phận nhân sự từ hàng ngàn bản hồ sơ xin việc trong và ngoài nước đã sàng lọc nghiêm ngặt ra 20 ứng viên giàu tiềm năng nhất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '83c74683-b6c1-4eff-9467-c9e829b71240'
);

-- [上级] (shàng jí): cấp trên
UPDATE public.vocabularies
SET example_hanzi = '各基层单位在推行全新工作方案之前，必须事先报请上级主管部门批准备案。',
    example_pinyin = 'Gè jīcéng dānwèi zài tuīxíng quánxīn gōngzuò fāng''àn zhīqián, bìxū shìxiān bào qǐng shàngjí zhǔguǎn bùmén pīzhǔn bèi''àn.',
    example_vi = 'Các đơn vị cơ sở trước khi triển khai phương án công tác hoàn toàn mới đều phải báo cáo xin phê chuẩn và lưu hồ sơ từ cơ quan chủ quản cấp trên.'
WHERE id = '3a468403-5360-4387-91e0-fcc0a5a71724' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3a468403-5360-4387-91e0-fcc0a5a71724', '各基层单位在推行全新工作方案之前，必须事先报请上级主管部门批准备案。', 'Gè jīcéng dānwèi zài tuīxíng quánxīn gōngzuò fāng''àn zhīqián, bìxū shìxiān bào qǐng shàngjí zhǔguǎn bùmén pīzhǔn bèi''àn.', 'Các đơn vị cơ sở trước khi triển khai phương án công tác hoàn toàn mới đều phải báo cáo xin phê chuẩn và lưu hồ sơ từ cơ quan chủ quản cấp trên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3a468403-5360-4387-91e0-fcc0a5a71724'
);

-- [上进] (shàng jìn): cầu tiến, tiến bộ
UPDATE public.vocabularies
SET example_hanzi = '青年一代唯有时刻保持积极上进的心态，才能在日新月异的技术变革中立于不败之地。',
    example_pinyin = 'Qīngnián yídài wéiyǒu shíkè bǎochí jījí shàngjìn de xīntài, cáinéng zài rìxīn-yuèyì de jìshù biàngé zhōng lì yú búbài zhī dì.',
    example_vi = 'Thế hệ thanh niên chỉ có duy trì tâm thế tích cực cầu tiến mọi lúc mới có thể đứng vững trước những đổi thay công nghệ thay đổi từng ngày.'
WHERE id = '2738bf3f-0493-4b30-8919-ed2cef886f27' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2738bf3f-0493-4b30-8919-ed2cef886f27', '青年一代唯有时刻保持积极上进的心态，才能在日新月异的技术变革中立于不败之地。', 'Qīngnián yídài wéiyǒu shíkè bǎochí jījí shàngjìn de xīntài, cáinéng zài rìxīn-yuèyì de jìshù biàngé zhōng lì yú búbài zhī dì.', 'Thế hệ thanh niên chỉ có duy trì tâm thế tích cực cầu tiến mọi lúc mới có thể đứng vững trước những đổi thay công nghệ thay đổi từng ngày.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2738bf3f-0493-4b30-8919-ed2cef886f27'
);

-- [商标] (shāngbiāo): nhãn hiệu, thương hiệu
UPDATE public.vocabularies
SET example_hanzi = '企业应当及时申请注册具有辨识度的专属商标，以切实保护自身的知识产权与商誉。',
    example_pinyin = 'Qǐyè yīngdāng jíshí shēnqǐng zhùcè jùyǒu biànshídù de zhuānshǔ shāngbiāo, yǐ qièshí bǎohù zìshēn de zhīshi chǎnquán yǔ shāngyù.',
    example_vi = 'Doanh nghiệp nên kịp thời nộp đơn đăng ký nhãn hiệu độc quyền có độ nhận diện cao nhằm bảo vệ thiết thực quyền sở hữu trí tuệ và uy tín thương mại của mình.'
WHERE id = '39f338eb-086f-4ec9-94c7-a23c3f542b9d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '39f338eb-086f-4ec9-94c7-a23c3f542b9d', '企业应当及时申请注册具有辨识度的专属商标，以切实保护自身的知识产权与商誉。', 'Qǐyè yīngdāng jíshí shēnqǐng zhùcè jùyǒu biànshídù de zhuānshǔ shāngbiāo, yǐ qièshí bǎohù zìshēn de zhīshi chǎnquán yǔ shāngyù.', 'Doanh nghiệp nên kịp thời nộp đơn đăng ký nhãn hiệu độc quyền có độ nhận diện cao nhằm bảo vệ thiết thực quyền sở hữu trí tuệ và uy tín thương mại của mình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '39f338eb-086f-4ec9-94c7-a23c3f542b9d'
);

-- [上当] (shàngdàng): mắc lừa, bị lừa
UPDATE public.vocabularies
SET example_hanzi = '网络诈骗手法层出不穷，广大老年群体在接到涉及转账汇款的陌生电话时切莫轻信上当。',
    example_pinyin = 'Wǎngluò zhàpiàn shǒufǎ céngchū-bùqióng, guǎngdà lǎonián qúntǐ zài jiē dào shèjí zhuǎnzhàng huìkuǎn de mòshēng diànhuà shí qiè mò qīngxìn shàngdàng.',
    example_vi = 'Chiêu trò lừa đảo qua mạng xuất hiện liên tục không dứt, đông đảo người cao tuổi khi nhận được cuộc gọi lạ liên quan đến chuyển khoản tuyệt đối chớ nhẹ dạ mắc lừa.'
WHERE id = '44617974-68f6-499d-a86d-ea02179f2fba' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '44617974-68f6-499d-a86d-ea02179f2fba', '网络诈骗手法层出不穷，广大老年群体在接到涉及转账汇款的陌生电话时切莫轻信上当。', 'Wǎngluò zhàpiàn shǒufǎ céngchū-bùqióng, guǎngdà lǎonián qúntǐ zài jiē dào shèjí zhuǎnzhàng huìkuǎn de mòshēng diànhuà shí qiè mò qīngxìn shàngdàng.', 'Chiêu trò lừa đảo qua mạng xuất hiện liên tục không dứt, đông đảo người cao tuổi khi nhận được cuộc gọi lạ liên quan đến chuyển khoản tuyệt đối chớ nhẹ dạ mắc lừa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '44617974-68f6-499d-a86d-ea02179f2fba'
);

-- [舌头] (shé tou): lưỡi
UPDATE public.vocabularies
SET example_hanzi = '中医师在望闻问切的诊断过程中，通常会仔细观察患者舌头的色泽与舌苔形态。',
    example_pinyin = 'Zhōngyīshī zài wàng-wén-wèn-qiè de zhěnduàn guòchéng zhōng, tōngcháng huì zǐxì guānchá huànzhě shétou de sèzé yǔ shétāi xíngtài.',
    example_vi = 'Các thầy thuốc đông y trong quá trình chẩn đoán tứ chẩn thường quan sát kỹ lưỡng sắc diện của lưỡi và hình thái rêu lưỡi của người bệnh.'
WHERE id = 'ba2a69cd-7176-40cd-a40e-1781cca5a8bd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ba2a69cd-7176-40cd-a40e-1781cca5a8bd', '中医师在望闻问切的诊断过程中，通常会仔细观察患者舌头的色泽与舌苔形态。', 'Zhōngyīshī zài wàng-wén-wèn-qiè de zhěnduàn guòchéng zhōng, tōngcháng huì zǐxì guānchá huànzhě shétou de sèzé yǔ shétāi xíngtài.', 'Các thầy thuốc đông y trong quá trình chẩn đoán tứ chẩn thường quan sát kỹ lưỡng sắc diện của lưỡi và hình thái rêu lưỡi của người bệnh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ba2a69cd-7176-40cd-a40e-1781cca5a8bd'
);

-- [涉及] (shèjí): liên quan đến, đề cập tới
UPDATE public.vocabularies
SET example_hanzi = '这次宏观经济法案的重大修订，涉及金融外汇、劳动就业以及环境保护等诸多重要领域。',
    example_pinyin = 'Zhè cì hóngguān jīngjì fǎ''àn de zhòngdà xiūdìng, shèjí jīnróng wàihuì, láodòng jiùyè yǐjí huánjìng bǎohù děng zhūduō zhòngyào lǐngyù.',
    example_vi = 'Lần sửa đổi lớn đạo luật kinh tế vĩ mô này liên quan đến rất nhiều lĩnh vực quan trọng như tài chính ngoại hối, lao động việc làm và bảo vệ môi trường.'
WHERE id = 'dce63833-5cda-4488-bdc5-b78458d9afed' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dce63833-5cda-4488-bdc5-b78458d9afed', '这次宏观经济法案的重大修订，涉及金融外汇、劳动就业以及环境保护等诸多重要领域。', 'Zhè cì hóngguān jīngjì fǎ''àn de zhòngdà xiūdìng, shèjí jīnróng wàihuì, láodòng jiùyè yǐjí huánjìng bǎohù děng zhūduō zhòngyào lǐngyù.', 'Lần sửa đổi lớn đạo luật kinh tế vĩ mô này liên quan đến rất nhiều lĩnh vực quan trọng như tài chính ngoại hối, lao động việc làm và bảo vệ môi trường.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dce63833-5cda-4488-bdc5-b78458d9afed'
);

-- [射击] (shèjī): bắn súng, xạ kích
UPDATE public.vocabularies
SET example_hanzi = '国家队射击运动员凭借着极高的心理素质与沉着冷静的发挥，在决赛中勇夺桂冠。',
    example_pinyin = 'Guójiāduì shèjī yùndòngyuán píngjiè zhe jígāo de xīnlǐ sùzhì yǔ chénzhuó lěngjìng de fāhuī, zài juésài zhōng yǒng duó guìguān.',
    example_vi = 'Vận động viên bắn súng đội tuyển quốc gia dựa vào bản lĩnh tâm lý cực cao cùng phong độ bình tĩnh vững vàng đã xuất sắc đoạt ngôi quán quân trong trận chung kết.'
WHERE id = '6d88af9b-071e-4639-aeab-49d2d4521654' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6d88af9b-071e-4639-aeab-49d2d4521654', '国家队射击运动员凭借着极高的心理素质与沉着冷静的发挥，在决赛中勇夺桂冠。', 'Guójiāduì shèjī yùndòngyuán píngjiè zhe jígāo de xīnlǐ sùzhì yǔ chénzhuó lěngjìng de fāhuī, zài juésài zhōng yǒng duó guìguān.', 'Vận động viên bắn súng đội tuyển quốc gia dựa vào bản lĩnh tâm lý cực cao cùng phong độ bình tĩnh vững vàng đã xuất sắc đoạt ngôi quán quân trong trận chung kết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6d88af9b-071e-4639-aeab-49d2d4521654'
);

-- [盛] (shèng): thịnh vượng, nồng hậu
UPDATE public.vocabularies
SET example_hanzi = '好客的主人热情地拿出精美的瓷碗，为远道而来的贵宾盛满了热气腾腾的鸡汤。',
    example_pinyin = 'Hàokè de zhǔrén rèqíng de ná chū jīngměi de cíwǎn, wèi yuǎndào''érlái de guìbīn chéng mǎn le rèqì-téngténg de jītāng.',
    example_vi = 'Chủ nhà hiếu khách nhiệt tình lấy ra những chiếc bát sứ tinh xảo, múc đầy bát canh gà nóng hổi bốc khói nghi ngút cho vị khách quý từ phương xa tới.'
WHERE id = '7fb84dfa-5758-42d5-928a-e57eb13974d1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7fb84dfa-5758-42d5-928a-e57eb13974d1', '好客的主人热情地拿出精美的瓷碗，为远道而来的贵宾盛满了热气腾腾的鸡汤。', 'Hàokè de zhǔrén rèqíng de ná chū jīngměi de cíwǎn, wèi yuǎndào''érlái de guìbīn chéng mǎn le rèqì-téngténg de jītāng.', 'Chủ nhà hiếu khách nhiệt tình lấy ra những chiếc bát sứ tinh xảo, múc đầy bát canh gà nóng hổi bốc khói nghi ngút cho vị khách quý từ phương xa tới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7fb84dfa-5758-42d5-928a-e57eb13974d1'
);

-- [声调] (shēngdiào): thanh điệu, giọng điệu
UPDATE public.vocabularies
SET example_hanzi = '对于初学汉语的外国留学生而言，准确掌握四个基本声调的变化规律是攻克口语发音的必修课。',
    example_pinyin = 'Duìyú chūxué hànyǔ de wàiguó liúxuéshēng ér''yán, zhǔnquè zhǎngwò sì gè jīběn shēngdiào de biànhuà guīlǜ shì gōngkè kǒuyǔ fāyīn de bìxiūkè.',
    example_vi = 'Đối với lưu học sinh nước ngoài mới học tiếng Trung, việc nắm vững chuẩn xác quy luật biến đổi của bốn thanh điệu cơ bản là bài học bắt buộc để chinh phục phát âm khẩu ngữ.'
WHERE id = 'a8c5d157-2ae1-4256-b52e-59270e5387a7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a8c5d157-2ae1-4256-b52e-59270e5387a7', '对于初学汉语的外国留学生而言，准确掌握四个基本声调的变化规律是攻克口语发音的必修课。', 'Duìyú chūxué hànyǔ de wàiguó liúxuéshēng ér''yán, zhǔnquè zhǎngwò sì gè jīběn shēngdiào de biànhuà guīlǜ shì gōngkè kǒuyǔ fāyīn de bìxiūkè.', 'Đối với lưu học sinh nước ngoài mới học tiếng Trung, việc nắm vững chuẩn xác quy luật biến đổi của bốn thanh điệu cơ bản là bài học bắt buộc để chinh phục phát âm khẩu ngữ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a8c5d157-2ae1-4256-b52e-59270e5387a7'
);

-- [生态] (shēngtài): sinh thái
UPDATE public.vocabularies
SET example_hanzi = '保护好珍贵的湿地生态环境，对维持区域生物多样性与调节气候具有不可估量的意义。',
    example_pinyin = 'Bǎohù hǎo zhēnguì de shīdì shēngtài huánjìng, duì wéichí qūyù shēngwù duōyàngxìng yǔ tiáojié qìhòu jùyǒu bùkě gūliàng de yìyì.',
    example_vi = 'Bảo vệ tốt môi trường sinh thái đất ngập nước quý giá có ý nghĩa không thể đong đếm đối với việc duy trì đa dạng sinh học khu vực và điều hòa khí hậu.'
WHERE id = 'e9f05563-fb3d-4cc1-9822-c092bd9da87a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e9f05563-fb3d-4cc1-9822-c092bd9da87a', '保护好珍贵的湿地生态环境，对维持区域生物多样性与调节气候具有不可估量的意义。', 'Bǎohù hǎo zhēnguì de shīdì shēngtài huánjìng, duì wéichí qūyù shēngwù duōyàngxìng yǔ tiáojié qìhòu jùyǒu bùkě gūliàng de yìyì.', 'Bảo vệ tốt môi trường sinh thái đất ngập nước quý giá có ý nghĩa không thể đong đếm đối với việc duy trì đa dạng sinh học khu vực và điều hòa khí hậu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e9f05563-fb3d-4cc1-9822-c092bd9da87a'
);

-- [神经] (shénjīng): thần kinh
UPDATE public.vocabularies
SET example_hanzi = '长期处于高强度、无休止的工作压力之下，极容易导致人体植物神经功能紊乱与失眠。',
    example_pinyin = 'Chángqī chǔyú gāo qiángdù, wú xiūzhǐ de gōngzuò yālì zhīxià, jí róngyì dǎozhì réntǐ zhíwù shénjīng gōngnéng wěnluàn yǔ shīmián.',
    example_vi = 'Lâu dài ở dưới áp lực công việc cường độ cao và không ngừng nghỉ rất dễ dẫn đến rối loạn chức năng thần kinh thực vật và mất ngủ của cơ thể.'
WHERE id = '852cb1c1-5e30-4908-a335-82fa08a4e023' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '852cb1c1-5e30-4908-a335-82fa08a4e023', '长期处于高强度、无休止的工作压力之下，极容易导致人体植物神经功能紊乱与失眠。', 'Chángqī chǔyú gāo qiángdù, wú xiūzhǐ de gōngzuò yālì zhīxià, jí róngyì dǎozhì réntǐ zhíwù shénjīng gōngnéng wěnluàn yǔ shīmián.', 'Lâu dài ở dưới áp lực công việc cường độ cao và không ngừng nghỉ rất dễ dẫn đến rối loạn chức năng thần kinh thực vật và mất ngủ của cơ thể.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '852cb1c1-5e30-4908-a335-82fa08a4e023'
);

-- [审美] (shěnměi): thẩm mỹ
UPDATE public.vocabularies
SET example_hanzi = '优秀的艺术设计作品应当兼具实用功能与高雅的审美意趣，给人带来精神上的升华与愉悦。',
    example_pinyin = 'Yōuxiù de yìshù shèjì zuòpǐn yīngdāng jiānjù shíyòng gōngnéng yǔ gāoyǎ de shěnměi yìqù, gěi rén dàilái jīngshén shang de shēnghuá yǔ yúyuè.',
    example_vi = 'Tác phẩm thiết kế nghệ thuật ưu tú cần phải hội tụ cả công năng thực dụng lẫn phong vị thẩm mỹ tao nhã, đem lại cho con người sự thăng hoa và hân hoan về tinh thần.'
WHERE id = '67cb0432-bc33-461f-95c4-11de612b21e9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '67cb0432-bc33-461f-95c4-11de612b21e9', '优秀的艺术设计作品应当兼具实用功能与高雅的审美意趣，给人带来精神上的升华与愉悦。', 'Yōuxiù de yìshù shèjì zuòpǐn yīngdāng jiānjù shíyòng gōngnéng yǔ gāoyǎ de shěnměi yìqù, gěi rén dàilái jīngshén shang de shēnghuá yǔ yúyuè.', 'Tác phẩm thiết kế nghệ thuật ưu tú cần phải hội tụ cả công năng thực dụng lẫn phong vị thẩm mỹ tao nhã, đem lại cho con người sự thăng hoa và hân hoan về tinh thần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '67cb0432-bc33-461f-95c4-11de612b21e9'
);

-- [神奇] (shénqí): thần kỳ, kỳ diệu
UPDATE public.vocabularies
SET example_hanzi = '大自然中孕育着无数神奇奥秘的生物现象，等待着青年探索者们去揭开谜底。',
    example_pinyin = 'Dàzìrán zhōng yùnyù zhe wúshù shénqí àomì de shēngwù xiànxiàng, děngdài zhe qīngnián tànsuǒzhě men qù jiēkāi mídǐ.',
    example_vi = 'Thiên nhiên bao la nuôi dưỡng vô số hiện tượng sinh vật kỳ diệu và bí ẩn, đang chờ đón những nhà thám hiểm trẻ tuổi đi khám phá lời giải đáp.'
WHERE id = 'f09e455a-117b-4cc9-942a-dacbbd17e65d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f09e455a-117b-4cc9-942a-dacbbd17e65d', '大自然中孕育着无数神奇奥秘的生物现象，等待着青年探索者们去揭开谜底。', 'Dàzìrán zhōng yùnyù zhe wúshù shénqí àomì de shēngwù xiànxiàng, děngdài zhe qīngnián tànsuǒzhě men qù jiēkāi mídǐ.', 'Thiên nhiên bao la nuôi dưỡng vô số hiện tượng sinh vật kỳ diệu và bí ẩn, đang chờ đón những nhà thám hiểm trẻ tuổi đi khám phá lời giải đáp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f09e455a-117b-4cc9-942a-dacbbd17e65d'
);

-- [设想] (shèxiǎng): tưởng tượng, trù tính
UPDATE public.vocabularies
SET example_hanzi = '建筑大师以极具前瞻性的眼光，大胆提出了关于未来垂直生态城市的规划设想。',
    example_pinyin = 'Jiànzhù dàshī yǐ jíbǐng qiánzhānxìng de yǎnguāng, dàdǎn tíchū le guānyú wèilái chuízhí shēngtài chéngshì de guīhuà shèxiǎng.',
    example_vi = 'Bậc thầy kiến trúc với tầm nhìn mang tính đón đầu đã mạnh dạn đề xuất một ý tưởng quy hoạch giả tưởng về thành phố sinh thái thẳng đứng trong tương lai.'
WHERE id = 'f5e0a544-8c1d-467d-aca1-d10580131b20' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f5e0a544-8c1d-467d-aca1-d10580131b20', '建筑大师以极具前瞻性的眼光，大胆提出了关于未来垂直生态城市的规划设想。', 'Jiànzhù dàshī yǐ jíbǐng qiánzhānxìng de yǎnguāng, dàdǎn tíchū le guānyú wèilái chuízhí shēngtài chéngshì de guīhuà shèxiǎng.', 'Bậc thầy kiến trúc với tầm nhìn mang tính đón đầu đã mạnh dạn đề xuất một ý tưởng quy hoạch giả tưởng về thành phố sinh thái thẳng đứng trong tương lai.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f5e0a544-8c1d-467d-aca1-d10580131b20'
);

-- [拾] (shí): nhặt, lượm
UPDATE public.vocabularies
SET example_hanzi = '这位朴实的保洁阿姨在候机大厅拾到了装有巨额现金的皮包，毫不犹豫地交还失主。',
    example_pinyin = 'Zhè wèi pǔshí de bǎojié āyí zài hòujī dàtīng shí dào le zhuāng yǒu jù''é xiànjīn de píbāo, háo bù yóuyù de jiāohuán shīzhǔ.',
    example_vi = 'Người dì lao công chất phác đã nhặt được chiếc túi da chứa một lượng tiền mặt khổng lồ ở sảnh chờ sân bay và không ngần ngại trao trả cho khổ chủ.'
WHERE id = '325d48e6-9bd6-4147-84b2-e5e9456cd03a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '325d48e6-9bd6-4147-84b2-e5e9456cd03a', '这位朴实的保洁阿姨在候机大厅拾到了装有巨额现金的皮包，毫不犹豫地交还失主。', 'Zhè wèi pǔshí de bǎojié āyí zài hòujī dàtīng shí dào le zhuāng yǒu jù''é xiànjīn de píbāo, háo bù yóuyù de jiāohuán shīzhǔ.', 'Người dì lao công chất phác đã nhặt được chiếc túi da chứa một lượng tiền mặt khổng lồ ở sảnh chờ sân bay và không ngần ngại trao trả cho khổ chủ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '325d48e6-9bd6-4147-84b2-e5e9456cd03a'
);

-- [事务] (shì wù): sự vụ, công việc
UPDATE public.vocabularies
SET example_hanzi = '随着国际交往日益密切，该涉外律所每日需要处理大量繁重的跨境民商事法律事务。',
    example_pinyin = 'Suízhe guójì jiāowǎng rìyì mìqiè, gāi shèwài lǜsuǒ měi rì xūyào chǔlǐ dàliàng fánzhòng de kuàjìng mínshāngshì fǎlǜ shìwù.',
    example_vi = 'Cùng với sự giao lưu quốc tế ngày càng gắn kết, văn phòng luật sư có yếu tố nước ngoài này mỗi ngày phải xử lý khối lượng lớn các sự vụ pháp lý dân sự thương mại xuyên biên giới bề bộn.'
WHERE id = '65a81ea3-0f6a-4e19-831b-6311017308bc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '65a81ea3-0f6a-4e19-831b-6311017308bc', '随着国际交往日益密切，该涉外律所每日需要处理大量繁重的跨境民商事法律事务。', 'Suízhe guójì jiāowǎng rìyì mìqiè, gāi shèwài lǜsuǒ měi rì xūyào chǔlǐ dàliàng fánzhòng de kuàjìng mínshāngshì fǎlǜ shìwù.', 'Cùng với sự giao lưu quốc tế ngày càng gắn kết, văn phòng luật sư có yếu tố nước ngoài này mỗi ngày phải xử lý khối lượng lớn các sự vụ pháp lý dân sự thương mại xuyên biên giới bề bộn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '65a81ea3-0f6a-4e19-831b-6311017308bc'
);

-- [识别] (shíbié): nhận biết, phân biệt
UPDATE public.vocabularies
SET example_hanzi = '新一代智能监控系统配备了先进的人脸识别技术，能在几毫秒内准确核实人员身份。',
    example_pinyin = 'Xīn yídài zhìnéng jiānkòng xìtǒng pèibèi le xiānjìn de rénliǎn shíbié jìshù, néng zài jǐ háomiǎo nèi zhǔnquè héshí rényuán shēnfèn.',
    example_vi = 'Hệ thống giám sát thông minh thế hệ mới được trang bị công nghệ nhận diện khuôn mặt tiên tiến, có thể xác thực chuẩn xác danh tính nhân sự chỉ trong vài mili giây.'
WHERE id = '3e246155-b58b-45a3-9753-c3590cf8328f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3e246155-b58b-45a3-9753-c3590cf8328f', '新一代智能监控系统配备了先进的人脸识别技术，能在几毫秒内准确核实人员身份。', 'Xīn yídài zhìnéng jiānkòng xìtǒng pèibèi le xiānjìn de rénliǎn shíbié jìshù, néng zài jǐ háomiǎo nèi zhǔnquè héshí rényuán shēnfèn.', 'Hệ thống giám sát thông minh thế hệ mới được trang bị công nghệ nhận diện khuôn mặt tiên tiến, có thể xác thực chuẩn xác danh tính nhân sự chỉ trong vài mili giây.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3e246155-b58b-45a3-9753-c3590cf8328f'
);

-- [士兵] (shìbīng): binh lính, chiến sĩ
UPDATE public.vocabularies
SET example_hanzi = '边防士兵们在零下三十度的极端风雪环境中日夜站岗放哨，用青春守护着祖国疆土。',
    example_pinyin = 'Biānfáng shìbīng men zài língxià sānshí dù de jíduān fēngxuě huánjìng zhōng rìyè zhàngǎng-fàngshào, yòng qīngchūn shǒuhù zhe zǔguó jiāngtǔ.',
    example_vi = 'Các binh sĩ biên phòng ngày đêm gác tiêu tuần tra giữa môi trường bão tuyết khắc nghiệt âm ba mươi độ, dùng tuổi thanh xuân bảo vệ bờ cõi Tổ quốc.'
WHERE id = '5642aa3e-4002-443f-a4c5-1b53e278fa98' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5642aa3e-4002-443f-a4c5-1b53e278fa98', '边防士兵们在零下三十度的极端风雪环境中日夜站岗放哨，用青春守护着祖国疆土。', 'Biānfáng shìbīng men zài língxià sānshí dù de jíduān fēngxuě huánjìng zhōng rìyè zhàngǎng-fàngshào, yòng qīngchūn shǒuhù zhe zǔguó jiāngtǔ.', 'Các binh sĩ biên phòng ngày đêm gác tiêu tuần tra giữa môi trường bão tuyết khắc nghiệt âm ba mươi độ, dùng tuổi thanh xuân bảo vệ bờ cõi Tổ quốc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5642aa3e-4002-443f-a4c5-1b53e278fa98'
);

-- [示范] (shìfàn): làm mẫu, nêu gương
UPDATE public.vocabularies
SET example_hanzi = '教练亲自为学员们进行规范的标准动作示范，并耐心细致地纠正每一个细微偏差。',
    example_pinyin = 'Jiàoliàn qīnzì wèi xuéyuán men jìnxíng guīfàn de biāozhǔn dòngzuò shìfàn, bìng nàixīn xìzhì de jiūzhèng měi yí gè xìwēi piānchā.',
    example_vi = 'Huấn luyện viên đích thân thực hiện thao tác mẫu chuẩn mực theo quy phạm cho các học viên, đồng thời kiên nhẫn tỉ mỉ uốn nắn từng sai lệch nhỏ.'
WHERE id = 'ff40ded9-5cfe-4da9-9ffb-444574c9d91c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ff40ded9-5cfe-4da9-9ffb-444574c9d91c', '教练亲自为学员们进行规范的标准动作示范，并耐心细致地纠正每一个细微偏差。', 'Jiàoliàn qīnzì wèi xuéyuán men jìnxíng guīfàn de biāozhǔn dòngzuò shìfàn, bìng nàixīn xìzhì de jiūzhèng měi yí gè xìwēi piānchā.', 'Huấn luyện viên đích thân thực hiện thao tác mẫu chuẩn mực theo quy phạm cho các học viên, đồng thời kiên nhẫn tỉ mỉ uốn nắn từng sai lệch nhỏ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ff40ded9-5cfe-4da9-9ffb-444574c9d91c'
);

-- [释放] (shìfàng): phóng thích, giải phóng
UPDATE public.vocabularies
SET example_hanzi = '全面深化各领域改革将进一步释放市场主体的创新活力，有力促进宏观经济稳步复苏。',
    example_pinyin = 'Quánmiàn shēnhuà gè lǐngyù gǎigé jiāng jìnyíbù shìfàng shìchǎng zhǔtǐ de chuàngxīn huólì, yǒulì cùjìn hóngguān jīngjì wěnbù fùsū.',
    example_vi = 'Việc cải cách sâu rộng toàn diện trên các lĩnh vực sẽ giải phóng thêm sức sống đổi mới của các chủ thể thị trường, thúc đẩy mạnh mẽ nền kinh tế vĩ mô phục hồi vững chắc.'
WHERE id = '1109dd47-af91-4ede-af09-dcef5848eaff' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1109dd47-af91-4ede-af09-dcef5848eaff', '全面深化各领域改革将进一步释放市场主体的创新活力，有力促进宏观经济稳步复苏。', 'Quánmiàn shēnhuà gè lǐngyù gǎigé jiāng jìnyíbù shìfàng shìchǎng zhǔtǐ de chuàngxīn huólì, yǒulì cùjìn hóngguān jīngjì wěnbù fùsū.', 'Việc cải cách sâu rộng toàn diện trên các lĩnh vực sẽ giải phóng thêm sức sống đổi mới của các chủ thể thị trường, thúc đẩy mạnh mẽ nền kinh tế vĩ mô phục hồi vững chắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1109dd47-af91-4ede-af09-dcef5848eaff'
);

-- [时光] (shíguāng): thời gian, thời khắc
UPDATE public.vocabularies
SET example_hanzi = '虽然那些青涩美好的大学时光早已远去，但同窗好友之间真挚深厚的情谊永不褪色。',
    example_pinyin = 'Suīrán nàxiē qīngsè měihǎo de dàxué shíguāng zǎoyǐ yuǎn qù, dàn tóngchuāng hǎoyǒu zhījiān zhēnzhì shēnhòu de qíngyì yǒng bù tuìsè.',
    example_vi = 'Tuy khoảng thời gian đại học tươi đẹp ngây thơ ấy đã lùi xa từ lâu, nhưng tình cảm chân thành sâu nặng giữa những người bạn đồng môn sẽ mãi không phai nhòa.'
WHERE id = '9a84affb-de63-497e-bbcf-f00c42d48e14' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9a84affb-de63-497e-bbcf-f00c42d48e14', '虽然那些青涩美好的大学时光早已远去，但同窗好友之间真挚深厚的情谊永不褪色。', 'Suīrán nàxiē qīngsè měihǎo de dàxué shíguāng zǎoyǐ yuǎn qù, dàn tóngchuāng hǎoyǒu zhījiān zhēnzhì shēnhòu de qíngyì yǒng bù tuìsè.', 'Tuy khoảng thời gian đại học tươi đẹp ngây thơ ấy đã lùi xa từ lâu, nhưng tình cảm chân thành sâu nặng giữa những người bạn đồng môn sẽ mãi không phai nhòa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9a84affb-de63-497e-bbcf-f00c42d48e14'
);

-- [实话] (shíhuà): lời nói thật
UPDATE public.vocabularies
SET example_hanzi = '面对多年挚友的真诚征询，他最终还是说了实话，诚恳指出了方案中潜在的商业漏洞。',
    example_pinyin = 'Miànduì duōnián zhìyǒu de zhēnchéng zhēnxún, tā zuìzhōng háishì shuō le shíhuà, chéngkěn zhǐchū le fāng''àn zhōng qiánzài de shāngyè lòudòng.',
    example_vi = 'Đối mặt với sự tham vấn chân thành của người bạn thân bao năm, anh rốt cuộc vẫn nói lời thật lòng, chân thành chỉ ra lỗ hổng kinh doanh tiềm ẩn trong phương án.'
WHERE id = '7ac78ab0-1c22-4d60-a56b-b6afe41fcde4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7ac78ab0-1c22-4d60-a56b-b6afe41fcde4', '面对多年挚友的真诚征询，他最终还是说了实话，诚恳指出了方案中潜在的商业漏洞。', 'Miànduì duōnián zhìyǒu de zhēnchéng zhēnxún, tā zuìzhōng háishì shuō le shíhuà, chéngkěn zhǐchū le fāng''àn zhōng qiánzài de shāngyè lòudòng.', 'Đối mặt với sự tham vấn chân thành của người bạn thân bao năm, anh rốt cuộc vẫn nói lời thật lòng, chân thành chỉ ra lỗ hổng kinh doanh tiềm ẩn trong phương án.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7ac78ab0-1c22-4d60-a56b-b6afe41fcde4'
);

-- [实惠] (shíhuì): lợi ích thực tế, giá rẻ
UPDATE public.vocabularies
SET example_hanzi = '这家社区平价便民超市不仅蔬菜水果品类繁多，价格也十分经济实惠。',
    example_pinyin = 'Zhè jiā shèqū píngjià biànmín chāoshì bùjǐn shūcài shuǐguǒ pǐnlèi fánduō, jiàgé yě shífēn jīngjì shíhuì.',
    example_vi = 'Siêu thị bình dân tiện ích phục vụ cộng đồng này không chỉ phong phú các loại rau củ hoa quả mà mức giá cũng vô cùng tiết kiệm thực tế.'
WHERE id = '7d29fd09-95ce-424f-88c0-2b3b8e6af84a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7d29fd09-95ce-424f-88c0-2b3b8e6af84a', '这家社区平价便民超市不仅蔬菜水果品类繁多，价格也十分经济实惠。', 'Zhè jiā shèqū píngjià biànmín chāoshì bùjǐn shūcài shuǐguǒ pǐnlèi fánduō, jiàgé yě shífēn jīngjì shíhuì.', 'Siêu thị bình dân tiện ích phục vụ cộng đồng này không chỉ phong phú các loại rau củ hoa quả mà mức giá cũng vô cùng tiết kiệm thực tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7d29fd09-95ce-424f-88c0-2b3b8e6af84a'
);

-- [时机] (shíjī): thời cơ, cơ hội
UPDATE public.vocabularies
SET example_hanzi = '一位精明果决的投资者善于准确把握市场周期的脉搏，并在最佳时机果断出手布局。',
    example_pinyin = 'Yí wèi jīngmíng guǒjué de tóuzīzhě shànyú zhǔnquè bǎwò shìchǎng zhōuqī de màibó, bìng zài zuìjiā shíjī guǒduàn chūshǒu bùjú.',
    example_vi = 'Một nhà đầu tư thông minh quyết đoán luôn giỏi nắm bắt chuẩn xác mạch đập của chu kỳ thị trường, và quyết đoán ra tay bố trí vào thời cơ tối ưu nhất.'
WHERE id = '65331318-da58-40c9-914d-8c46bfa4783b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '65331318-da58-40c9-914d-8c46bfa4783b', '一位精明果决的投资者善于准确把握市场周期的脉搏，并在最佳时机果断出手布局。', 'Yí wèi jīngmíng guǒjué de tóuzīzhě shànyú zhǔnquè bǎwò shìchǎng zhōuqī de màibó, bìng zài zuìjiā shíjī guǒduàn chūshǒu bùjú.', 'Một nhà đầu tư thông minh quyết đoán luôn giỏi nắm bắt chuẩn xác mạch đập của chu kỳ thị trường, và quyết đoán ra tay bố trí vào thời cơ tối ưu nhất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '65331318-da58-40c9-914d-8c46bfa4783b'
);

-- [势力] (shìli): thế lực
UPDATE public.vocabularies
SET example_hanzi = '司法机关坚决依法严厉打击各类黑恶黑帮势力，全力保障人民群众的生命与财产安全。',
    example_pinyin = 'Sīfǎ jīgòu jiānjué yīfǎ yánlì dǎjī gè lèi hēi''è hēibāng shìlì, quánlì bǎozhàng rénmín qúnzhòng de shēngmìng yǔ cáichǎn ānquán.',
    example_vi = 'Cơ quan tư pháp kiên quyết thẳng tay trấn áp nghiêm trị theo pháp luật các loại thế lực côn đồ xã hội đen, dốc toàn lực bảo đảm an toàn tính mạng và tài sản cho quần chúng nhân dân.'
WHERE id = '7792b919-f9b1-4f34-8608-8bce47c67ed4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7792b919-f9b1-4f34-8608-8bce47c67ed4', '司法机关坚决依法严厉打击各类黑恶黑帮势力，全力保障人民群众的生命与财产安全。', 'Sīfǎ jīgòu jiānjué yīfǎ yánlì dǎjī gè lèi hēi''è hēibāng shìlì, quánlì bǎozhàng rénmín qúnzhòng de shēngmìng yǔ cáichǎn ānquán.', 'Cơ quan tư pháp kiên quyết thẳng tay trấn áp nghiêm trị theo pháp luật các loại thế lực côn đồ xã hội đen, dốc toàn lực bảo đảm an toàn tính mạng và tài sản cho quần chúng nhân dân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7792b919-f9b1-4f34-8608-8bce47c67ed4'
);

-- [视力] (shìlì): thị lực
UPDATE public.vocabularies
SET example_hanzi = '眼科专家郑重建议青少年切勿长时间沉迷电子屏幕，以有效预防视力过早发生严重下降。',
    example_pinyin = 'Yǎnkē zhuānjiā zhèngzhòng jiànyì qīng-shàonián qiè wù cháng shíjiān chénmí diànzǐ píngmù, yǐ yǒuxiào yùfáng shìlì guòzǎo fāshēng yánzhòng xiàjiàng.',
    example_vi = 'Chuyên gia nhãn khoa thiết tha khuyên bảo thanh thiếu niên tuyệt đối không nên cắm mặt vào màn hình điện tử trong thời gian dài, để phòng ngừa thị lực suy giảm nghiêm trọng quá sớm một cách hiệu quả.'
WHERE id = '6f4e25c7-041e-47dc-95f1-35eab46017d8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6f4e25c7-041e-47dc-95f1-35eab46017d8', '眼科专家郑重建议青少年切勿长时间沉迷电子屏幕，以有效预防视力过早发生严重下降。', 'Yǎnkē zhuānjiā zhèngzhòng jiànyì qīng-shàonián qiè wù cháng shíjiān chénmí diànzǐ píngmù, yǐ yǒuxiào yùfáng shìlì guòzǎo fāshēng yánzhòng xiàjiàng.', 'Chuyên gia nhãn khoa thiết tha khuyên bảo thanh thiếu niên tuyệt đối không nên cắm mặt vào màn hình điện tử trong thời gian dài, để phòng ngừa thị lực suy giảm nghiêm trọng quá sớm một cách hiệu quả.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6f4e25c7-041e-47dc-95f1-35eab46017d8'
);

-- [时尚] (shíshàng): thời trang, xu hướng
UPDATE public.vocabularies
SET example_hanzi = '这座国际大都市不仅是全球前沿的金融中心，更是引领全球潮流时尚的摩登之都。',
    example_pinyin = 'Zhè zuò guójì dà dūshì bùjǐn shì quánqiú qiányán de jīnróng zhōngxīn, gèng shì yǐnlǐng quánqiú cháoliú shíshàng de módēng zhī dū.',
    example_vi = 'Đại đô thị quốc tế này không chỉ là trung tâm tài chính đi đầu thế giới, mà còn là kinh đô hiện đại dẫn dắt xu hướng thời trang toàn cầu.'
WHERE id = 'aa303b34-01d1-4c07-abf9-b097b75ed21a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'aa303b34-01d1-4c07-abf9-b097b75ed21a', '这座国际大都市不仅是全球前沿的金融中心，更是引领全球潮流时尚的摩登之都。', 'Zhè zuò guójì dà dūshì bùjǐn shì quánqiú qiányán de jīnróng zhōngxīn, gèng shì yǐnlǐng quánqiú cháoliú shíshàng de módēng zhī dū.', 'Đại đô thị quốc tế này không chỉ là trung tâm tài chính đi đầu thế giới, mà còn là kinh đô hiện đại dẫn dắt xu hướng thời trang toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'aa303b34-01d1-4c07-abf9-b097b75ed21a'
);

-- [试图] (shìtú): thử, có ý định
UPDATE public.vocabularies
SET example_hanzi = '某些不法黑客多次试图突破国家核心网络安全防御系统，但均被安全卫士成功拦截。',
    example_pinyin = 'Mǒuxiē bùfǎ hēikè duō cì shìtú tūpò guójiā héxīn wǎngluò ānquán fángyù xìtǒng, dàn jūn bèi ānquán wèishì chénggōng lánjié.',
    example_vi = 'Một số tin tặc phi pháp từng nhiều lần mưu toan đột phá hệ thống phòng thủ an ninh mạng cốt lõi của quốc gia, nhưng đều bị các vệ sĩ an ninh đánh chặn thành công.'
WHERE id = '2c165a46-5c16-4375-9ee8-bd960bab70e7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2c165a46-5c16-4375-9ee8-bd960bab70e7', '某些不法黑客多次试图突破国家核心网络安全防御系统，但均被安全卫士成功拦截。', 'Mǒuxiē bùfǎ hēikè duō cì shìtú tūpò guójiā héxīn wǎngluò ānquán fángyù xìtǒng, dàn jūn bèi ānquán wèishì chénggōng lánjié.', 'Một số tin tặc phi pháp từng nhiều lần mưu toan đột phá hệ thống phòng thủ an ninh mạng cốt lõi của quốc gia, nhưng đều bị các vệ sĩ an ninh đánh chặn thành công.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2c165a46-5c16-4375-9ee8-bd960bab70e7'
);

-- [事项] (shìxiàng): sự việc, hạng mục
UPDATE public.vocabularies
SET example_hanzi = '在与外资企业签署正式合作协议之前，法务团队必须逐一仔细核对各项合同违约事项。',
    example_pinyin = 'Zài yǔ wàizī qǐyè qiānshǔ zhèngshì hézuò xiéyì zhīqián, fǎwù tuánduì bìxū zhúyī zǐxì héduì gè xiàng hétong wéiyuē shìxiàng.',
    example_vi = 'Trước khi ký kết thỏa thuận hợp tác chính thức với doanh nghiệp có vốn đầu tư nước ngoài, đội ngũ pháp chế cần phải tỉ mỉ đối chiếu từng điều khoản sự việc vi phạm hợp đồng.'
WHERE id = 'de7be255-6c84-495a-897f-7b22ae68d195' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'de7be255-6c84-495a-897f-7b22ae68d195', '在与外资企业签署正式合作协议之前，法务团队必须逐一仔细核对各项合同违约事项。', 'Zài yǔ wàizī qǐyè qiānshǔ zhèngshì hézuò xiéyì zhīqián, fǎwù tuánduì bìxū zhúyī zǐxì héduì gè xiàng hétong wéiyuē shìxiàng.', 'Trước khi ký kết thỏa thuận hợp tác chính thức với doanh nghiệp có vốn đầu tư nước ngoài, đội ngũ pháp chế cần phải tỉ mỉ đối chiếu từng điều khoản sự việc vi phạm hợp đồng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'de7be255-6c84-495a-897f-7b22ae68d195'
);

-- [适宜] (shìyí): thích hợp, phù hợp
UPDATE public.vocabularies
SET example_hanzi = '这座沿海海滨小镇气候温和湿润、四季分明，是极其适宜老年人颐养天年的宜居之所。',
    example_pinyin = 'Zhè zuò yánhǎi hǎibīn xiǎozhèn qìhòu wēnhé shīrùn, sìjì fēnmíng, shì jíqí shìyí lǎoniánrén yíyǎng tiānnián de yíjū zhī suǒ.',
    example_vi = 'Thị trấn ven biển này khí hậu ôn hòa ẩm ướt, bốn mùa phân minh, là nơi định cư vô cùng thích hợp cho người cao tuổi an dưỡng tuổi già.'
WHERE id = 'feacc51c-0ac4-4cde-850f-c6667bd02262' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'feacc51c-0ac4-4cde-850f-c6667bd02262', '这座沿海海滨小镇气候温和湿润、四季分明，是极其适宜老年人颐养天年的宜居之所。', 'Zhè zuò yánhǎi hǎibīn xiǎozhèn qìhòu wēnhé shīrùn, sìjì fēnmíng, shì jíqí shìyí lǎoniánrén yíyǎng tiānnián de yíjū zhī suǒ.', 'Thị trấn ven biển này khí hậu ôn hòa ẩm ướt, bốn mùa phân minh, là nơi định cư vô cùng thích hợp cho người cao tuổi an dưỡng tuổi già.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'feacc51c-0ac4-4cde-850f-c6667bd02262'
);

-- [石油] (shíyóu): dầu mỏ
UPDATE public.vocabularies
SET example_hanzi = '作为现代重工业不可或缺的重要能源命脉，国际石油价格波动时刻牵动着全球经济。',
    example_pinyin = 'Zuòwéi xiàndài zhònggōngyè bùkě huòquē de zhòngyào néngyuán mìngmài, guójì shíyóu jiàgé bōdòng shíkè qiāndòng zhe quánqiú jīngjì.',
    example_vi = 'Là huyết mạch năng lượng trọng yếu không thể thiếu của ngành công nghiệp nặng hiện đại, biến động giá dầu mỏ quốc tế luôn làm chao đảo nền kinh tế toàn cầu.'
WHERE id = '4e92b08a-f0b6-4b5a-aff1-b157139372af' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4e92b08a-f0b6-4b5a-aff1-b157139372af', '作为现代重工业不可或缺的重要能源命脉，国际石油价格波动时刻牵动着全球经济。', 'Zuòwéi xiàndài zhònggōngyè bùkě huòquē de zhòngyào néngyuán mìngmài, guójì shíyóu jiàgé bōdòng shíkè qiāndòng zhe quánqiú jīngjì.', 'Là huyết mạch năng lượng trọng yếu không thể thiếu của ngành công nghiệp nặng hiện đại, biến động giá dầu mỏ quốc tế luôn làm chao đảo nền kinh tế toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4e92b08a-f0b6-4b5a-aff1-b157139372af'
);

-- [实质] (shízhì): thực chất, bản chất
UPDATE public.vocabularies
SET example_hanzi = '我们应当穿透事物表面纷繁复杂的表象，深刻把握隐藏其背后的内在规律与客观实质。',
    example_pinyin = 'Wǒmen yīngdāng chuāntòu shìwù biǎomiàn fēnfán-fùzá de biǎoxiàng, shēnkè bǎwò yǐncáng qí bèihòu de nèizài guīlǜ yǔ kèguān shízhì.',
    example_vi = 'Chúng ta cần xuyên thấu qua hiện tượng bề ngoài rườm rà phức tạp của sự vật, để nắm bắt sâu sắc quy luật nội tại và bản chất khách quan ẩn giấu đằng sau.'
WHERE id = 'af351776-31be-4a29-b5f6-d8ba5e41a78b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'af351776-31be-4a29-b5f6-d8ba5e41a78b', '我们应当穿透事物表面纷繁复杂的表象，深刻把握隐藏其背后的内在规律与客观实质。', 'Wǒmen yīngdāng chuāntòu shìwù biǎomiàn fēnfán-fùzá de biǎoxiàng, shēnkè bǎwò yǐncáng qí bèihòu de nèizài guīlǜ yǔ kèguān shízhì.', 'Chúng ta cần xuyên thấu qua hiện tượng bề ngoài rườm rà phức tạp của sự vật, để nắm bắt sâu sắc quy luật nội tại và bản chất khách quan ẩn giấu đằng sau.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'af351776-31be-4a29-b5f6-d8ba5e41a78b'
);

-- [狮子] (shīzi): sư tử
UPDATE public.vocabularies
SET example_hanzi = '在广袤无垠的非洲大草原上，雄壮威武的成年狮子是无可争议的顶级掠食王者。',
    example_pinyin = 'Zài guǎngmào-wúyín de Fēizhōu dà cǎoyuán shang, xióngzhuàng wēiwǔ de chéngnián shīzi shì wúkě zhēngyì de dǐngjí lüèshí wángzhě.',
    example_vi = 'Trên thảo nguyên châu Phi bao la bát ngát, con sư tử đực trưởng thành hùng tráng oai nghiêm là kẻ săn mồi thống trị đỉnh cao không thể tranh cãi.'
WHERE id = '4da8c247-0bfb-424f-8534-d70bc4be6e19' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4da8c247-0bfb-424f-8534-d70bc4be6e19', '在广袤无垠的非洲大草原上，雄壮威武的成年狮子是无可争议的顶级掠食王者。', 'Zài guǎngmào-wúyín de Fēizhōu dà cǎoyuán shang, xióngzhuàng wēiwǔ de chéngnián shīzi shì wúkě zhēngyì de dǐngjí lüèshí wángzhě.', 'Trên thảo nguyên châu Phi bao la bát ngát, con sư tử đực trưởng thành hùng tráng oai nghiêm là kẻ săn mồi thống trị đỉnh cao không thể tranh cãi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4da8c247-0bfb-424f-8534-d70bc4be6e19'
);

-- [十足] (shízú): tràn đầy, mười phần
UPDATE public.vocabularies
SET example_hanzi = '这位年轻优秀的新生代钢琴家在舞台上台风稳健，演奏起来更显得自信心十足。',
    example_pinyin = 'Zhè wèi niánqīng yōuxiù de xīnshēngdài gāngqínjiā zài wǔtái shang táifēng wěnjiàn, yǎnzòu qǐlái gèng xiǎnde zìxìnxīn shízú.',
    example_vi = 'Nghệ sĩ dương cầm thế hệ mới trẻ trung và xuất sắc này có phong thái sân khấu vững vàng, khi diễn tấu lại càng toát lên lòng tự tin mười phần.'
WHERE id = '5ff4748f-8dc5-45b1-a88b-24c2030fcd13' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5ff4748f-8dc5-45b1-a88b-24c2030fcd13', '这位年轻优秀的新生代钢琴家在舞台上台风稳健，演奏起来更显得自信心十足。', 'Zhè wèi niánqīng yōuxiù de xīnshēngdài gāngqínjiā zài wǔtái shang táifēng wěnjiàn, yǎnzòu qǐlái gèng xiǎnde zìxìnxīn shízú.', 'Nghệ sĩ dương cầm thế hệ mới trẻ trung và xuất sắc này có phong thái sân khấu vững vàng, khi diễn tấu lại càng toát lên lòng tự tin mười phần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5ff4748f-8dc5-45b1-a88b-24c2030fcd13'
);

-- [收藏] (shōucáng): sưu tập, cất giữ
UPDATE public.vocabularies
SET example_hanzi = '省立博物馆常年悉心收藏与公开展出数千件商周青铜器与宋代历朝名画艺术珍品。',
    example_pinyin = 'Shěnglì bówùguǎn chángnián xīxīn shōucáng yǔ gōngkāi zhǎnchū shù qiān jiàn shāng-zhōu qīngtóngqì yǔ sòngdài lìcháo mínghuà yìshù zhēnpǐn.',
    example_vi = 'Bảo tàng cấp tỉnh quanh năm lưu giữ cẩn trọng và triển lãm công khai hàng ngàn món đồ đồng Thương Chu và bảo vật nghệ thuật danh họa các triều đại thời Tống.'
WHERE id = '93395a04-ee82-4d23-b40f-c40093cb81f1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '93395a04-ee82-4d23-b40f-c40093cb81f1', '省立博物馆常年悉心收藏与公开展出数千件商周青铜器与宋代历朝名画艺术珍品。', 'Shěnglì bówùguǎn chángnián xīxīn shōucáng yǔ gōngkāi zhǎnchū shù qiān jiàn shāng-zhōu qīngtóngqì yǔ sòngdài lìcháo mínghuà yìshù zhēnpǐn.', 'Bảo tàng cấp tỉnh quanh năm lưu giữ cẩn trọng và triển lãm công khai hàng ngàn món đồ đồng Thương Chu và bảo vật nghệ thuật danh họa các triều đại thời Tống.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '93395a04-ee82-4d23-b40f-c40093cb81f1'
);

-- [手法] (shǒufǎ): thủ pháp, kỹ xảo, mánh khóe
UPDATE public.vocabularies
SET example_hanzi = '著名小说家运用高超精湛的心理描写手法，将主角内心深处的纠结挣扎刻画得入木三分。',
    example_pinyin = 'Zhùmíng xiǎoshuōjiā yùnyòng gāochāo jīngzhàn de xīnlǐ miáoxiě shǒufǎ, jiāng zhǔjué nèixīn shēncù de jiūjié zhēngzhá kèhuà de rùmù-sānfēn.',
    example_vi = 'Tiểu thuyết gia lừng danh sử dụng thủ pháp miêu tả tâm lý cao siêu điêu luyện, khắc họa sự giằng xé đấu tranh nơi sâu thẳm tâm can nhân vật chính sâu sắc thấu tận tâm can.'
WHERE id = 'a8fec3c5-00cf-4d71-824a-03bace2f875a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a8fec3c5-00cf-4d71-824a-03bace2f875a', '著名小说家运用高超精湛的心理描写手法，将主角内心深处的纠结挣扎刻画得入木三分。', 'Zhùmíng xiǎoshuōjiā yùnyòng gāochāo jīngzhàn de xīnlǐ miáoxiě shǒufǎ, jiāng zhǔjué nèixīn shēncù de jiūjié zhēngzhá kèhuà de rùmù-sānfēn.', 'Tiểu thuyết gia lừng danh sử dụng thủ pháp miêu tả tâm lý cao siêu điêu luyện, khắc họa sự giằng xé đấu tranh nơi sâu thẳm tâm can nhân vật chính sâu sắc thấu tận tâm can.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a8fec3c5-00cf-4d71-824a-03bace2f875a'
);

-- [寿命] (shòumìng): tuổi thọ
UPDATE public.vocabularies
SET example_hanzi = '随着现代医疗卫生水平的大幅提高与生活方式的改善，全国居民的人均预期寿命持续稳步延长。',
    example_pinyin = 'Suízhe xiàndài yīliáo wèishēng shuǐpíng de dàfú tígāo yǔ shēnghuó fāngshì de gǎishàn, quánguó jūmín de rénjūn yùqī shòumìng chíxù wěnbù yáncháng.',
    example_vi = 'Cùng với sự nâng cao vượt bậc của trình độ y tế vệ sinh hiện đại và sự cải thiện lối sống, tuổi thọ kỳ vọng bình quân của cư dân toàn quốc tiếp tục tăng lên một cách vững chắc.'
WHERE id = 'f38fa3d6-bb00-42d5-bf8e-acc70527d8c4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f38fa3d6-bb00-42d5-bf8e-acc70527d8c4', '随着现代医疗卫生水平的大幅提高与生活方式的改善，全国居民的人均预期寿命持续稳步延长。', 'Suízhe xiàndài yīliáo wèishēng shuǐpíng de dàfú tígāo yǔ shēnghuó fāngshì de gǎishàn, quánguó jūmín de rénjūn yùqī shòumìng chíxù wěnbù yáncháng.', 'Cùng với sự nâng cao vượt bậc của trình độ y tế vệ sinh hiện đại và sự cải thiện lối sống, tuổi thọ kỳ vọng bình quân của cư dân toàn quốc tiếp tục tăng lên một cách vững chắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f38fa3d6-bb00-42d5-bf8e-acc70527d8c4'
);

-- [手势] (shǒushì): cử chỉ, điệu bộ tay
UPDATE public.vocabularies
SET example_hanzi = '聋哑人教师站在讲台上，用熟练温和的手势语言向特殊儿童们传递着温暖人心的关爱与知识。',
    example_pinyin = 'Lóngyǎrén jiàoshī zhàn zài jiǎngtái shang, yòng shúliàn wēnhé de shǒushì yǔyán xiàng tèshū értóng men chuándì zhe wēnnuǎn rénxīn de guān''ài yǔ zhīshi.',
    example_vi = 'Giáo viên người khiếm thính đứng trên bục giảng, dùng ngôn ngữ thủ ngữ cử chỉ thuần thục ấm áp truyền tải tình yêu thương sưởi ấm lòng người và tri thức tới các em nhỏ đặc biệt.'
WHERE id = '06eaadc0-b712-48d7-a177-70f333caddf1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '06eaadc0-b712-48d7-a177-70f333caddf1', '聋哑人教师站在讲台上，用熟练温和的手势语言向特殊儿童们传递着温暖人心的关爱与知识。', 'Lóngyǎrén jiàoshī zhàn zài jiǎngtái shang, yòng shúliàn wēnhé de shǒushì yǔyán xiàng tèshū értóng men chuándì zhe wēnnuǎn rénxīn de guān''ài yǔ zhīshi.', 'Giáo viên người khiếm thính đứng trên bục giảng, dùng ngôn ngữ thủ ngữ cử chỉ thuần thục ấm áp truyền tải tình yêu thương sưởi ấm lòng người và tri thức tới các em nhỏ đặc biệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '06eaadc0-b712-48d7-a177-70f333caddf1'
);

-- [首要] (shǒuyào): hàng đầu, quan trọng nhất
UPDATE public.vocabularies
SET example_hanzi = '在应对突发公共安全危机时，全力确保人民群众的生命安全是首要任务。',
    example_pinyin = 'Zài yìngduì tūfā gōnggòng ānquán wēijī shí, quánlì quèbǎo rénmín qúnzhòng de shēngmìng ānquán shì shǒuyào rènwù.',
    example_vi = 'Khi ứng phó với khủng hoảng an toàn công cộng đột xuất, dốc toàn lực bảo đảm an toàn tính mạng của quần chúng nhân dân là nhiệm vụ hàng đầu.'
WHERE id = 'b4ab116e-5281-4423-a737-41a5a135b7f3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b4ab116e-5281-4423-a737-41a5a135b7f3', '在应对突发公共安全危机时，全力确保人民群众的生命安全是首要任务。', 'Zài yìngduì tūfā gōnggòng ānquán wēijī shí, quánlì quèbǎo rénmín qúnzhòng de shēngmìng ānquán shì shǒuyào rènwù.', 'Khi ứng phó với khủng hoảng an toàn công cộng đột xuất, dốc toàn lực bảo đảm an toàn tính mạng của quần chúng nhân dân là nhiệm vụ hàng đầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b4ab116e-5281-4423-a737-41a5a135b7f3'
);

-- [收益] (shōuyì): lợi nhuận, thu nhập
UPDATE public.vocabularies
SET example_hanzi = '该投资机构凭借科学多元的资产配置策略，为广大客户带来了长期稳健的投资收益。',
    example_pinyin = 'Gāi tóuzī jīgòu píngjiè kēxué duōyuán de zīchǎn pèizhì cèlüè, wèi guǎngdà kèhù dàilái le chángqī wěnjiàn de tóuzī shōuyì.',
    example_vi = 'Tổ chức đầu tư này dựa vào chiến lược phân bổ tài sản khoa học và đa dạng, đã đem lại lợi nhuận đầu tư ổn định lâu dài cho đông đảo khách hàng.'
WHERE id = '87859680-0a6e-4e46-903e-0e735c006156' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '87859680-0a6e-4e46-903e-0e735c006156', '该投资机构凭借科学多元的资产配置策略，为广大客户带来了长期稳健的投资收益。', 'Gāi tóuzī jīgòu píngjiè kēxué duōyuán de zīchǎn pèizhì cèlüè, wèi guǎngdà kèhù dàilái le chángqī wěnjiàn de tóuzī shōuyì.', 'Tổ chức đầu tư này dựa vào chiến lược phân bổ tài sản khoa học và đa dạng, đã đem lại lợi nhuận đầu tư ổn định lâu dài cho đông đảo khách hàng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '87859680-0a6e-4e46-903e-0e735c006156'
);

-- [竖] (shù): dựng thẳng, nét sổ
UPDATE public.vocabularies
SET example_hanzi = '听到这位无名英雄舍己救人的感人事迹，在场的每一个人都由衷地竖起了大拇指。',
    example_pinyin = 'Tīng dào zhè wèi wúmíng yīngxióng shějǐ-jiùrén de gǎnrén shìjì, zàichǎng de měi yí gè rén dōu yóuzhōng de shù qǐ le dàmǔzhǐ.',
    example_vi = 'Nghe câu chuyện cảm động hy sinh thân mình cứu người của vị anh hùng vô danh này, mỗi người có mặt đều từ đáy lòng giơ ngón tay cái thán phục.'
WHERE id = '443389ad-3b9b-45fd-98d8-cd754596665b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '443389ad-3b9b-45fd-98d8-cd754596665b', '听到这位无名英雄舍己救人的感人事迹，在场的每一个人都由衷地竖起了大拇指。', 'Tīng dào zhè wèi wúmíng yīngxióng shějǐ-jiùrén de gǎnrén shìjì, zàichǎng de měi yí gè rén dōu yóuzhōng de shù qǐ le dàmǔzhǐ.', 'Nghe câu chuyện cảm động hy sinh thân mình cứu người của vị anh hùng vô danh này, mỗi người có mặt đều từ đáy lòng giơ ngón tay cái thán phục.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '443389ad-3b9b-45fd-98d8-cd754596665b'
);

-- [书籍] (shū jí): sách vở
UPDATE public.vocabularies
SET example_hanzi = '这间古色古香的市立图书馆内珍藏着海量古今中外的经典书籍，是学术研究的宝库。',
    example_pinyin = 'Zhè jiān gǔsè-gǔxiāng de shìlì túshūguǎn nèi zhēncáng zhe hǎiliàng gǔjīn-zhōngwài de jīngdiǎn shūjí, shì xuéshù yánjiū de bǎokù.',
    example_vi = 'Bên trong thư viện thành phố mang phong vị cổ kính này trân tàng khối lượng lớn sách vở kinh điển kim cổ đông tây, là kho tàng của nghiên cứu học thuật.'
WHERE id = '83260977-63ca-40a6-bd57-4f16ba46ee0c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '83260977-63ca-40a6-bd57-4f16ba46ee0c', '这间古色古香的市立图书馆内珍藏着海量古今中外的经典书籍，是学术研究的宝库。', 'Zhè jiān gǔsè-gǔxiāng de shìlì túshūguǎn nèi zhēncáng zhe hǎiliàng gǔjīn-zhōngwài de jīngdiǎn shūjí, shì xuéshù yánjiū de bǎokù.', 'Bên trong thư viện thành phố mang phong vị cổ kính này trân tàng khối lượng lớn sách vở kinh điển kim cổ đông tây, là kho tàng của nghiên cứu học thuật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '83260977-63ca-40a6-bd57-4f16ba46ee0c'
);

-- [书面] (shū miàn): văn bản, viết trên giấy
UPDATE public.vocabularies
SET example_hanzi = '双方商务代表在经过多轮磋商达成共识后，正式签署了一式两份的书面合作协议。',
    example_pinyin = 'Shuāngfāng shāngwù dàibiǎo zài jīngguò duō lún cuōshāng dáchéng gòngshí hòu, zhèngshì qiānshǔ le yíshì-liǎngfèn de shūmiàn hézuò xiéyì.',
    example_vi = 'Đại diện thương vụ hai bên sau khi trải qua nhiều vòng hiệp thương đạt được đồng thuận, đã chính thức ký kết thỏa thuận hợp tác bằng văn bản gồm hai bản như một.'
WHERE id = 'f58da3a7-95dc-457b-b190-942f993da4ab' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f58da3a7-95dc-457b-b190-942f993da4ab', '双方商务代表在经过多轮磋商达成共识后，正式签署了一式两份的书面合作协议。', 'Shuāngfāng shāngwù dàibiǎo zài jīngguò duō lún cuōshāng dáchéng gòngshí hòu, zhèngshì qiānshǔ le yíshì-liǎngfèn de shūmiàn hézuò xiéyì.', 'Đại diện thương vụ hai bên sau khi trải qua nhiều vòng hiệp thương đạt được đồng thuận, đã chính thức ký kết thỏa thuận hợp tác bằng văn bản gồm hai bản như một.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f58da3a7-95dc-457b-b190-942f993da4ab'
);

-- [衰老] (shuāilǎo): già yếu, lão hóa
UPDATE public.vocabularies
SET example_hanzi = '保持规律均衡的健康作息与积极乐观的生活心态，是延缓人体机能自然衰老的重要秘诀。',
    example_pinyin = 'Bǎochí guīlǜ jūnhéng de jiànkāng zuòxī yǔ jījí lèguān de shēnghuó xīntài, shì yánhuǎn réntǐ jīnéng zìrán shuāilǎo de zhòngyào mìjué.',
    example_vi = 'Duy trì sinh hoạt làm việc nghỉ ngơi điều độ cân bằng và tâm thái sống tích cực lạc quan là bí quyết quan trọng làm chậm lại sự lão hóa tự nhiên của các cơ năng cơ thể.'
WHERE id = '5909d4e1-7891-449b-9ba6-782432bb800c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5909d4e1-7891-449b-9ba6-782432bb800c', '保持规律均衡的健康作息与积极乐观的生活心态，是延缓人体机能自然衰老的重要秘诀。', 'Bǎochí guīlǜ jūnhéng de jiànkāng zuòxī yǔ jījí lèguān de shēnghuó xīntài, shì yánhuǎn réntǐ jīnéng zìrán shuāilǎo de zhòngyào mìjué.', 'Duy trì sinh hoạt làm việc nghỉ ngơi điều độ cân bằng và tâm thái sống tích cực lạc quan là bí quyết quan trọng làm chậm lại sự lão hóa tự nhiên của các cơ năng cơ thể.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5909d4e1-7891-449b-9ba6-782432bb800c'
);

-- [率领] (shuàilǐng): dẫn dắt, thống lĩnh
UPDATE public.vocabularies
SET example_hanzi = '在突如其来的滔天洪水面前，年轻的支队长亲自率领突击抢险队员通宵达旦抢修堤坝。',
    example_pinyin = 'Zài tūrúqílái de tāotiān hóngshuǐ miànqián, niánqīng de zhīduìzhǎng qīnzì shuàilǐng tūjī qiǎngxiǎn duìyuán tōngxiāo-dádàn qiǎngxiū dībà.',
    example_vi = 'Trước dòng nước lũ dâng ngút trời bất ngờ ập đến, người đội trưởng chi đội trẻ tuổi đã đích thân dẫn dắt các đội viên xung kích cứu hộ thức suốt đêm gia cố bờ đê.'
WHERE id = '012b515d-aeb3-442e-880d-217ed6036f1c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '012b515d-aeb3-442e-880d-217ed6036f1c', '在突如其来的滔天洪水面前，年轻的支队长亲自率领突击抢险队员通宵达旦抢修堤坝。', 'Zài tūrúqílái de tāotiān hóngshuǐ miànqián, niánqīng de zhīduìzhǎng qīnzì shuàilǐng tūjī qiǎngxiǎn duìyuán tōngxiāo-dádàn qiǎngxiū dībà.', 'Trước dòng nước lũ dâng ngút trời bất ngờ ập đến, người đội trưởng chi đội trẻ tuổi đã đích thân dẫn dắt các đội viên xung kích cứu hộ thức suốt đêm gia cố bờ đê.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '012b515d-aeb3-442e-880d-217ed6036f1c'
);

-- [水泥] (shuǐní): xi măng
UPDATE public.vocabularies
SET example_hanzi = '作为现代高层建筑的基石材料，高质量的水泥与钢筋确保了整座宏伟大厦的坚固与安全。',
    example_pinyin = 'Zuòwéi xiàndài gāocéng jiànzhù de jīshí cáiliào, gāo zhìliàng de shuǐní yǔ gāngjīn quèbǎo le zhěng zuò hóngwěi dàshà de jiāngù yǔ ānquán.',
    example_vi = 'Là vật liệu nền tảng của các công trình cao tầng hiện đại, xi măng và cốt thép chất lượng cao bảo đảm sự vững chắc và an toàn cho toàn bộ tòa đại ốc nguy nga.'
WHERE id = '93219522-fea0-4cfc-b6b9-465e531dd8d2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '93219522-fea0-4cfc-b6b9-465e531dd8d2', '作为现代高层建筑的基石材料，高质量的水泥与钢筋确保了整座宏伟大厦的坚固与安全。', 'Zuòwéi xiàndài gāocéng jiànzhù de jīshí cáiliào, gāo zhìliàng de shuǐní yǔ gāngjīn quèbǎo le zhěng zuò hóngwěi dàshà de jiāngù yǔ ānquán.', 'Là vật liệu nền tảng của các công trình cao tầng hiện đại, xi măng và cốt thép chất lượng cao bảo đảm sự vững chắc và an toàn cho toàn bộ tòa đại ốc nguy nga.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '93219522-fea0-4cfc-b6b9-465e531dd8d2'
);

-- [树立] (shùlì): xây dựng, thiết lập
UPDATE public.vocabularies
SET example_hanzi = '学校和家庭应当密切配合，从小引导青少年树立正确崇高的人生观与世界观。',
    example_pinyin = 'Xuéxiào hé jiātíng yīngdāng mìqiè pèihé, cóngxiǎo yǐndǎo qīng-shàonián shùlì zhèngquè chónggāo de rénshēngguān yǔ shìjièguān.',
    example_vi = 'Nhà trường và gia đình nên phối hợp chặt chẽ, từ nhỏ dẫn dắt thanh thiếu niên thiết lập nhân sinh quan và thế giới quan đúng đắn cao đẹp.'
WHERE id = 'f771207c-c85e-4099-99fa-172575131c2c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f771207c-c85e-4099-99fa-172575131c2c', '学校和家庭应当密切配合，从小引导青少年树立正确崇高的人生观与世界观。', 'Xuéxiào hé jiātíng yīngdāng mìqiè pèihé, cóngxiǎo yǐndǎo qīng-shàonián shùlì zhèngquè chónggāo de rénshēngguān yǔ shìjièguān.', 'Nhà trường và gia đình nên phối hợp chặt chẽ, từ nhỏ dẫn dắt thanh thiếu niên thiết lập nhân sinh quan và thế giới quan đúng đắn cao đẹp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f771207c-c85e-4099-99fa-172575131c2c'
);

-- [瞬间] (shùnjiān): khoảnh khắc, trong nháy mắt
UPDATE public.vocabularies
SET example_hanzi = '当绚丽夺目的新年烟花在夜空中升腾绽放的瞬间，全场观众爆发出热烈欢呼。',
    example_pinyin = 'Dāng xuànlì duómù de xīnnián yānhuā zài yèkōng zhōng shēngténg zhànfàng de shùnjiān, quánchǎng guānzhòng bàofā chū rèliè huānhū.',
    example_vi = 'Khoảnh khắc những chùm pháo hoa năm mới lộng lẫy chói lọi bùng nở trên bầu trời đêm, toàn thể khán giả đồng loạt reo hò nhiệt liệt.'
WHERE id = 'd08a265b-a8db-47c7-ac24-54c0f18b8b1b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd08a265b-a8db-47c7-ac24-54c0f18b8b1b', '当绚丽夺目的新年烟花在夜空中升腾绽放的瞬间，全场观众爆发出热烈欢呼。', 'Dāng xuànlì duómù de xīnnián yānhuā zài yèkōng zhōng shēngténg zhànfàng de shùnjiān, quánchǎng guānzhòng bàofā chū rèliè huānhū.', 'Khoảnh khắc những chùm pháo hoa năm mới lộng lẫy chói lọi bùng nở trên bầu trời đêm, toàn thể khán giả đồng loạt reo hò nhiệt liệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd08a265b-a8db-47c7-ac24-54c0f18b8b1b'
);

-- [思念] (sī niàn): nhớ nhung
UPDATE public.vocabularies
SET example_hanzi = '每逢中秋佳节月圆之夜，远在万里异国他乡的海外游子总会涌起对故土亲人的无尽思念。',
    example_pinyin = 'Měi féng zhōngqiū jiājié yuèyuán zhī yè, yuǎn zài wàn lǐ yìguó-tāxiāng de hǎiwài yóuzǐ zǒng huì yǒng qǐ duì gùtǔ qīnrén de wújìn sīniàn.',
    example_vi = 'Mỗi dịp tết Trung thu đêm trăng tròn, những người con xa xứ cách xa vạn dặm nơi đất khách quê người lại dâng trào nỗi nhớ nhung bất tận với người thân nơi quê cha đất tổ.'
WHERE id = '13a3b5a2-2767-4ce7-b876-9baf819f52d9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '13a3b5a2-2767-4ce7-b876-9baf819f52d9', '每逢中秋佳节月圆之夜，远在万里异国他乡的海外游子总会涌起对故土亲人的无尽思念。', 'Měi féng zhōngqiū jiājié yuèyuán zhī yè, yuǎn zài wàn lǐ yìguó-tāxiāng de hǎiwài yóuzǐ zǒng huì yǒng qǐ duì gùtǔ qīnrén de wújìn sīniàn.', 'Mỗi dịp tết Trung thu đêm trăng tròn, những người con xa xứ cách xa vạn dặm nơi đất khách quê người lại dâng trào nỗi nhớ nhung bất tận với người thân nơi quê cha đất tổ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '13a3b5a2-2767-4ce7-b876-9baf819f52d9'
);

-- [死亡] (sǐwáng): tử vong, cái chết
UPDATE public.vocabularies
SET example_hanzi = '通过建立健全早诊早治筛查体系，这种恶性肿瘤的临床死亡率近年来已显著下降。',
    example_pinyin = 'Tōngguò jiànlì jiànquán zǎozhěn-zǎozhì shāichá xìtǒng, zhè zhǒng èxìng zhǒngliú de línchuáng sǐwáng lǜ jìnnián lái yǐ xiǎnzhù xiàjiàng.',
    example_vi = 'Thông qua việc xây dựng hoàn thiện hệ thống tầm soát chẩn đoán và điều trị sớm, tỷ lệ tử vong lâm sàng của chứng u ác tính này những năm gần đây đã giảm rõ rệt.'
WHERE id = '53185a70-6956-4b70-be47-95974ed50026' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '53185a70-6956-4b70-be47-95974ed50026', '通过建立健全早诊早治筛查体系，这种恶性肿瘤的临床死亡率近年来已显著下降。', 'Tōngguò jiànlì jiànquán zǎozhěn-zǎozhì shāichá xìtǒng, zhè zhǒng èxìng zhǒngliú de línchuáng sǐwáng lǜ jìnnián lái yǐ xiǎnzhù xiàjiàng.', 'Thông qua việc xây dựng hoàn thiện hệ thống tầm soát chẩn đoán và điều trị sớm, tỷ lệ tử vong lâm sàng của chứng u ác tính này những năm gần đây đã giảm rõ rệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '53185a70-6956-4b70-be47-95974ed50026'
);

-- [艘] (sōu): chiếc, con (tàu)
UPDATE public.vocabularies
SET example_hanzi = '这艘由我国自主研发设计建造的大型远洋科考船，即将启程开赴南极执行科学考察任务。',
    example_pinyin = 'Zhè sōu yóu wǒguó zìzhǔ yánfā shèjì jiànzào de dàxíng yuǎnyáng kēkǎochuán, jíjiāng qǐchéng kāifù Nánjí zhíxíng kēxué kǎochá rènwù.',
    example_vi = 'Con tàu khảo sát đại dương cỡ lớn do nước ta tự chủ nghiên cứu thiết kế và chế tạo này sắp sửa khởi hành tiến về Nam Cực thực hiện nhiệm vụ khảo sát khoa học.'
WHERE id = '4a5d4076-104a-4de3-a7a4-6bd466cba4e5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4a5d4076-104a-4de3-a7a4-6bd466cba4e5', '这艘由我国自主研发设计建造的大型远洋科考船，即将启程开赴南极执行科学考察任务。', 'Zhè sōu yóu wǒguó zìzhǔ yánfā shèjì jiànzào de dàxíng yuǎnyáng kēkǎochuán, jíjiāng qǐchéng kāifù Nánjí zhíxíng kēxué kǎochá rènwù.', 'Con tàu khảo sát đại dương cỡ lớn do nước ta tự chủ nghiên cứu thiết kế và chế tạo này sắp sửa khởi hành tiến về Nam Cực thực hiện nhiệm vụ khảo sát khoa học.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4a5d4076-104a-4de3-a7a4-6bd466cba4e5'
);

-- [岁月] (suì yuè): năm tháng, thời gian
UPDATE public.vocabularies
SET example_hanzi = '尽管无情的漫长岁月染白了双鬓，但老将军眼中那份坚毅笃定的军人光芒依旧熠熠生辉。',
    example_pinyin = 'Jǐnguǎn wúqíng de màncháng suìyuè rǎn bái le shuāngbìn, dàn lǎo jiāngjūn yǎn zhōng nà fèn jiānyì dǔdìng de jūnrén guāngmáng yījiù yìyì-shēnghuī.',
    example_vi = 'Mặc cho tháng năm dài đằng đẵng vô tình nhuộm trắng hai mái tóc mai, nhưng ánh mắt kiên nghị vững vàng của người lính trong mắt vị lão tướng quân vẫn tỏa sáng rạng ngời.'
WHERE id = '210033e4-89b9-433a-b2fc-6a189620fe71' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '210033e4-89b9-433a-b2fc-6a189620fe71', '尽管无情的漫长岁月染白了双鬓，但老将军眼中那份坚毅笃定的军人光芒依旧熠熠生辉。', 'Jǐnguǎn wúqíng de màncháng suìyuè rǎn bái le shuāngbìn, dàn lǎo jiāngjūn yǎn zhōng nà fèn jiānyì dǔdìng de jūnrén guāngmáng yījiù yìyì-shēnghuī.', 'Mặc cho tháng năm dài đằng đẵng vô tình nhuộm trắng hai mái tóc mai, nhưng ánh mắt kiên nghị vững vàng của người lính trong mắt vị lão tướng quân vẫn tỏa sáng rạng ngời.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '210033e4-89b9-433a-b2fc-6a189620fe71'
);

-- [损坏] (sǔn huài): hư hại, làm hỏng
UPDATE public.vocabularies
SET example_hanzi = '物流运输部门在搬运仪器时操作极为审慎，以严防精密光学设备在途中受到任何震动损坏。',
    example_pinyin = 'Wùliú yùnshū bùmén zài bānyùn yíqì shí cāozuò jíqí shěnshèn, yǐ yánfáng jīngmì guāngxué shèbèi zài túzhōng shòudào rènhé zhèndòng sǔnhuài.',
    example_vi = 'Bộ phận vận chuyển hậu cần khi di chuyển dụng cụ đã thao tác cực kỳ cẩn trọng nhằm nghiêm ngặt phòng ngừa thiết bị quang học chính xác bị va đập hư hại trên đường đi.'
WHERE id = '95419f11-245c-4329-8521-7c63ba08c67b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '95419f11-245c-4329-8521-7c63ba08c67b', '物流运输部门在搬运仪器时操作极为审慎，以严防精密光学设备在途中受到任何震动损坏。', 'Wùliú yùnshū bùmén zài bānyùn yíqì shí cāozuò jíqí shěnshèn, yǐ yánfáng jīngmì guāngxué shèbèi zài túzhōng shòudào rènhé zhèndòng sǔnhuài.', 'Bộ phận vận chuyển hậu cần khi di chuyển dụng cụ đã thao tác cực kỳ cẩn trọng nhằm nghiêm ngặt phòng ngừa thiết bị quang học chính xác bị va đập hư hại trên đường đi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '95419f11-245c-4329-8521-7c63ba08c67b'
);

-- [塑造] (sùzào): nhào nặn, đắp nặn, xây dựng hình tượng
UPDATE public.vocabularies
SET example_hanzi = '一位优秀的表演艺术家善于通过眼神与细微肢体语言，成功塑造出生动鲜活的人物形象。',
    example_pinyin = 'Yí wèi yōuxiù de biǎoyǎn yìshùjiā shànyú tōngguò yǎnshén yǔ xìwēi zhītǐ yǔyán, chénggōng sùzào chū shēngdòng xiānhuó de rénwù xíngxiàng.',
    example_vi = 'Một nghệ sĩ biểu diễn ưu tú luôn giỏi việc mượn ánh mắt và cử chỉ ngôn ngữ cơ thể tinh tế để đắp nặn thành công những hình tượng nhân vật sống động chân thực.'
WHERE id = 'ae57d3ec-cb7e-4c4a-be87-baeee0b37818' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ae57d3ec-cb7e-4c4a-be87-baeee0b37818', '一位优秀的表演艺术家善于通过眼神与细微肢体语言，成功塑造出生动鲜活的人物形象。', 'Yí wèi yōuxiù de biǎoyǎn yìshùjiā shànyú tōngguò yǎnshén yǔ xìwēi zhītǐ yǔyán, chénggōng sùzào chū shēngdòng xiānhuó de rénwù xíngxiàng.', 'Một nghệ sĩ biểu diễn ưu tú luôn giỏi việc mượn ánh mắt và cử chỉ ngôn ngữ cơ thể tinh tế để đắp nặn thành công những hình tượng nhân vật sống động chân thực.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ae57d3ec-cb7e-4c4a-be87-baeee0b37818'
);

-- [素质] (sùzhì): tố chất, phẩm chất
UPDATE public.vocabularies
SET example_hanzi = '全面提高国民的思想道德修养与科学文化综合素质，是国家实现长远现代化的坚实基石。',
    example_pinyin = 'Quánmiàn tígāo guómín de sīxiǎng dàodé xiūyǎng yǔ kēxué wénhuà zōnghé sùzhì, shì guójiā shíxiàn chángyuǎn xiàndàihuà de jiānshí jīshí.',
    example_vi = 'Nâng cao toàn diện tu dưỡng đạo đức tư tưởng và tố chất tổng hợp văn hóa khoa học của toàn dân là nền tảng vững chắc để quốc gia hiện thực hóa hiện đại hóa lâu dài.'
WHERE id = 'e875b0d1-9dd6-4f4e-8b7b-d0fd928eef5a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e875b0d1-9dd6-4f4e-8b7b-d0fd928eef5a', '全面提高国民的思想道德修养与科学文化综合素质，是国家实现长远现代化的坚实基石。', 'Quánmiàn tígāo guómín de sīxiǎng dàodé xiūyǎng yǔ kēxué wénhuà zōnghé sùzhì, shì guójiā shíxiàn chángyuǎn xiàndàihuà de jiānshí jīshí.', 'Nâng cao toàn diện tu dưỡng đạo đức tư tưởng và tố chất tổng hợp văn hóa khoa học của toàn dân là nền tảng vững chắc để quốc gia hiện thực hóa hiện đại hóa lâu dài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e875b0d1-9dd6-4f4e-8b7b-d0fd928eef5a'
);

-- [塔] (tǎ): tháp, chùa tháp
UPDATE public.vocabularies
SET example_hanzi = '这座巍峨挺拔的千年古佛塔耸立在江心半岛之上，历经无数风雨侵蚀依然傲然挺立。',
    example_pinyin = 'Zhè zuò wēi''é tǐngbá de qiānnián gǔ fótǎ sǒnglì zài jiāngxīn bàndǎo zhīshàng, lìjīng wúshù fēngyǔ qīnshí yīrán àorán tǐnglì.',
    example_vi = 'Tòa cổ tháp Phật giáo ngàn năm sừng sững cao vút đứng uy nghiêm trên bán đảo giữa sông, trải qua bao phong ba bão táp ăn mòn vẫn hiên ngang đứng vững.'
WHERE id = '667186a2-b17b-4726-976a-258291b82bc3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '667186a2-b17b-4726-976a-258291b82bc3', '这座巍峨挺拔的千年古佛塔耸立在江心半岛之上，历经无数风雨侵蚀依然傲然挺立。', 'Zhè zuò wēi''é tǐngbá de qiānnián gǔ fótǎ sǒnglì zài jiāngxīn bàndǎo zhīshàng, lìjīng wúshù fēngyǔ qīnshí yīrán àorán tǐnglì.', 'Tòa cổ tháp Phật giáo ngàn năm sừng sững cao vút đứng uy nghiêm trên bán đảo giữa sông, trải qua bao phong ba bão táp ăn mòn vẫn hiên ngang đứng vững.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '667186a2-b17b-4726-976a-258291b82bc3'
);

-- [台风] (táifēng): bão nhiệt đới
UPDATE public.vocabularies
SET example_hanzi = '气象部门及时发布了最高级别的暴雨红色预警，严密防范超强台风在沿海地区正面登陆。',
    example_pinyin = 'Qìxiàng bùmén jíshí fābù le zuìgāo jíbié de bàoyǔ hóngsè yùjǐng, yánmì fángfàn chāoqiáng táifēng zài yánhǎi dìqū zhèngmiàn dēnglù.',
    example_vi = 'Cơ quan khí tượng đã kịp thời phát cảnh báo mưa bão màu đỏ ở cấp độ cao nhất, phòng bị nghiêm ngặt siêu bão đổ bộ trực diện vào các khu vực ven biển.'
WHERE id = 'bc2333e5-344d-481e-a359-6a77f6bd4c17' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bc2333e5-344d-481e-a359-6a77f6bd4c17', '气象部门及时发布了最高级别的暴雨红色预警，严密防范超强台风在沿海地区正面登陆。', 'Qìxiàng bùmén jíshí fābù le zuìgāo jíbié de bàoyǔ hóngsè yùjǐng, yánmì fángfàn chāoqiáng táifēng zài yánhǎi dìqū zhèngmiàn dēnglù.', 'Cơ quan khí tượng đã kịp thời phát cảnh báo mưa bão màu đỏ ở cấp độ cao nhất, phòng bị nghiêm ngặt siêu bão đổ bộ trực diện vào các khu vực ven biển.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bc2333e5-344d-481e-a359-6a77f6bd4c17'
);

-- [太空] (tàikōng): vũ trụ, không gian vũ trụ
UPDATE public.vocabularies
SET example_hanzi = '我国多名航天员在环绕地球运行的空间站内顺利完成了多次精彩纷呈的太空授课。',
    example_pinyin = 'Wǒguó duō míng hángtiānyuán zài huánrào dìqiú yùnxíng de kōngjiānzhàn nèi shùnlì wánchéng le duō cì jīngcǎi-fēncéng de tàikōng shòukè.',
    example_vi = 'Nhiều phi hành gia nước ta trong trạm không gian quay quanh quỹ đạo Trái Đất đã hoàn thành xuất sắc nhiều tiết giảng dạy ngoài vũ trụ vô cùng đặc sắc.'
WHERE id = '171bc715-06ea-449c-af06-088371fea38d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '171bc715-06ea-449c-af06-088371fea38d', '我国多名航天员在环绕地球运行的空间站内顺利完成了多次精彩纷呈的太空授课。', 'Wǒguó duō míng hángtiānyuán zài huánrào dìqiú yùnxíng de kōngjiānzhàn nèi shùnlì wánchéng le duō cì jīngcǎi-fēncéng de tàikōng shòukè.', 'Nhiều phi hành gia nước ta trong trạm không gian quay quanh quỹ đạo Trái Đất đã hoàn thành xuất sắc nhiều tiết giảng dạy ngoài vũ trụ vô cùng đặc sắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '171bc715-06ea-449c-af06-088371fea38d'
);

-- [探索] (tàn suǒ): khám phá, tìm tòi
UPDATE public.vocabularies
SET example_hanzi = '人类对于浩瀚深海未知生态奥秘的勇敢探索与科学考察，至今从未停下前进的脚步。',
    example_pinyin = 'Rénlèi duìyú hàohàn shēnhǎi wèizhī shēngtài àomì de yǒnggǎn tànsuǒ yǔ kēxué kǎochá, zhìjīn cóngwèi tíng xià qiánjìn de jiǎobù.',
    example_vi = 'Sự khám phá dũng cảm và khảo sát khoa học của loài người đối với những bí ẩn sinh thái chưa từng biết nơi biển sâu bao la đến nay chưa từng dừng bước.'
WHERE id = 'e759856d-c3d7-4c31-aba7-4af2757036c6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e759856d-c3d7-4c31-aba7-4af2757036c6', '人类对于浩瀚深海未知生态奥秘的勇敢探索与科学考察，至今从未停下前进的脚步。', 'Rénlèi duìyú hàohàn shēnhǎi wèizhī shēngtài àomì de yǒnggǎn tànsuǒ yǔ kēxué kǎochá, zhìjīn cóngwèi tíng xià qiánjìn de jiǎobù.', 'Sự khám phá dũng cảm và khảo sát khoa học của loài người đối với những bí ẩn sinh thái chưa từng biết nơi biển sâu bao la đến nay chưa từng dừng bước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e759856d-c3d7-4c31-aba7-4af2757036c6'
);

-- [探讨] (tàn tǎo): thảo luận, bàn luận
UPDATE public.vocabularies
SET example_hanzi = '来自全球各地的权威经济学家齐聚国际论坛，深入探讨数字经济未来的可持续发展路径。',
    example_pinyin = 'Láizì quánqiú gèdì de quánwēi jīngjìxuéjiā qíjù guójì lùntán, shēnrù tàntǎo shùzì jīngjì wèilái de kěchíxù fāzhǎn lùjìng.',
    example_vi = 'Các nhà kinh tế học uy tín đến từ khắp nơi trên toàn cầu đã hội tụ tại diễn đàn quốc tế, đi sâu thảo luận về lộ trình phát triển bền vững trong tương lai của nền kinh tế số.'
WHERE id = '55b6aaa3-a29d-4b43-9bd1-60a878ec295e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '55b6aaa3-a29d-4b43-9bd1-60a878ec295e', '来自全球各地的权威经济学家齐聚国际论坛，深入探讨数字经济未来的可持续发展路径。', 'Láizì quánqiú gèdì de quánwēi jīngjìxuéjiā qíjù guójì lùntán, shēnrù tàntǎo shùzì jīngjì wèilái de kěchíxù fāzhǎn lùjìng.', 'Các nhà kinh tế học uy tín đến từ khắp nơi trên toàn cầu đã hội tụ tại diễn đàn quốc tế, đi sâu thảo luận về lộ trình phát triển bền vững trong tương lai của nền kinh tế số.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '55b6aaa3-a29d-4b43-9bd1-60a878ec295e'
);

-- [弹性] (tán xìng): tính đàn hồi, co giãn
UPDATE public.vocabularies
SET example_hanzi = '这种由高分子合成的新型记忆材料兼具卓越的拉伸弹性与令人惊叹的耐磨性能。',
    example_pinyin = 'Zhè zhǒng yóu gāofēnzǐ héchéng de xīnxíng jìyì cáiliào jiānjù zhuóyuè de lāshēn tánxìng yǔ lìngrén jīngtàn de nàimó xìngnéng.',
    example_vi = 'Vật liệu ghi nhớ mới tổng hợp từ phân tử cao này vừa có độ đàn hồi kéo giãn vượt trội vừa có tính năng chống mài mòn đáng kinh ngạc.'
WHERE id = 'd48f3669-e446-4d49-9cae-3aeaa34cadc6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd48f3669-e446-4d49-9cae-3aeaa34cadc6', '这种由高分子合成的新型记忆材料兼具卓越的拉伸弹性与令人惊叹的耐磨性能。', 'Zhè zhǒng yóu gāofēnzǐ héchéng de xīnxíng jìyì cáiliào jiānjù zhuóyuè de lāshēn tánxìng yǔ lìngrén jīngtàn de nàimó xìngnéng.', 'Vật liệu ghi nhớ mới tổng hợp từ phân tử cao này vừa có độ đàn hồi kéo giãn vượt trội vừa có tính năng chống mài mòn đáng kinh ngạc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd48f3669-e446-4d49-9cae-3aeaa34cadc6'
);

-- [烫] (tàng): bỏng, nóng, ủi
UPDATE public.vocabularies
SET example_hanzi = '端刚出锅的热汤时必须格外当心，千万不要烫到手指或者溅到同桌客人的衣服上。',
    example_pinyin = 'Duān gāng chūguō de rètāng shí bìxū géwài dāngxīn, qiānwàn bú yào tàng dào shǒuzhǐ huòzhě jiàn dào tóngzhuō kèrén de yīfu shang.',
    example_vi = 'Khi bưng bát súp nóng vừa nhấc ra khỏi bếp cần phải hết sức cẩn thận, tuyệt đối chớ làm bỏng ngón tay hoặc bắn vào quần áo của thực khách cùng bàn.'
WHERE id = '0b0554ab-d552-42ab-84cf-31c78b26a6a0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0b0554ab-d552-42ab-84cf-31c78b26a6a0', '端刚出锅的热汤时必须格外当心，千万不要烫到手指或者溅到同桌客人的衣服上。', 'Duān gāng chūguō de rètāng shí bìxū géwài dāngxīn, qiānwàn bú yào tàng dào shǒuzhǐ huòzhě jiàn dào tóngzhuō kèrén de yīfu shang.', 'Khi bưng bát súp nóng vừa nhấc ra khỏi bếp cần phải hết sức cẩn thận, tuyệt đối chớ làm bỏng ngón tay hoặc bắn vào quần áo của thực khách cùng bàn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0b0554ab-d552-42ab-84cf-31c78b26a6a0'
);

-- [谈判] (tánpàn): đàm phán
UPDATE public.vocabularies
SET example_hanzi = '经过连续长达数周艰苦卓绝的闭门磋商，双方终于在关键核心条款上达成了双赢的谈判成果。',
    example_pinyin = 'Jīngguò liánxù chángdá shù zhōu jiānkǔ-zhuójué de bìmén cuōshāng, shuāngfāng zhōngyú zài guānjiàn héxīn tiáokuǎn shang dáchéng le shuāngyíng de tánpàn chéngguǒ.',
    example_vi = 'Trải qua nhiều tuần đàm phán kín gian khổ không ngừng nghỉ, hai bên rốt cuộc đã đạt được kết quả đàm phán đôi bên cùng có lợi trên các điều khoản cốt lõi then chốt.'
WHERE id = '1dd85d74-9ce4-499b-9e5d-ba212144466b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1dd85d74-9ce4-499b-9e5d-ba212144466b', '经过连续长达数周艰苦卓绝的闭门磋商，双方终于在关键核心条款上达成了双赢的谈判成果。', 'Jīngguò liánxù chángdá shù zhōu jiānkǔ-zhuójué de bìmén cuōshāng, shuāngfāng zhōngyú zài guānjiàn héxīn tiáokuǎn shang dáchéng le shuāngyíng de tánpàn chéngguǒ.', 'Trải qua nhiều tuần đàm phán kín gian khổ không ngừng nghỉ, hai bên rốt cuộc đã đạt được kết quả đàm phán đôi bên cùng có lợi trên các điều khoản cốt lõi then chốt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1dd85d74-9ce4-499b-9e5d-ba212144466b'
);

-- [逃] (táo): trốn, chạy trốn
UPDATE public.vocabularies
SET example_hanzi = '机敏敏捷的野兔发现灌木丛中有猎犬潜伏逼近，立刻一跃而起飞速向茂密的森林深处逃去。',
    example_pinyin = 'Jīmǐn mǐnjié de yětù fāxiàn guānmùcóng zhōng yǒu lièquǎn qiánfú bījìn, lìkè yí yuè ér qǐ fēisù xiàng màomì de sēnlín shēncù táo qù.',
    example_vi = 'Con thỏ rừng nhanh nhẹn phát hiện trong bụi cây rậm có chó săn ẩn nấp áp sát, lập tức nhảy vọt lên phi nhanh trốn sâu vào cánh rừng rậm rạp.'
WHERE id = '96f39a30-e58b-4f34-8b4e-317575855a20' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '96f39a30-e58b-4f34-8b4e-317575855a20', '机敏敏捷的野兔发现灌木丛中有猎犬潜伏逼近，立刻一跃而起飞速向茂密的森林深处逃去。', 'Jīmǐn mǐnjié de yětù fāxiàn guānmùcóng zhōng yǒu lièquǎn qiánfú bījìn, lìkè yí yuè ér qǐ fēisù xiàng màomì de sēnlín shēncù táo qù.', 'Con thỏ rừng nhanh nhẹn phát hiện trong bụi cây rậm có chó săn ẩn nấp áp sát, lập tức nhảy vọt lên phi nhanh trốn sâu vào cánh rừng rậm rạp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '96f39a30-e58b-4f34-8b4e-317575855a20'
);

-- [掏] (tāo): móc, rút ra
UPDATE public.vocabularies
SET example_hanzi = '得知这位家境贫寒的特困学生无力支付重病手术费，好心的老校长立刻从内衣口袋里掏出了所有积蓄。',
    example_pinyin = 'Dézhī zhè wèi jiājìng pínhán de tèkùn xuésheng wúlì zhīfù zhòngbìng shǒushùfèi, hǎoxīn de lǎo xiàozhǎng lìkè cóng nèiyī kǒudài lǐ tāo chū le suǒyǒu jīxù.',
    example_vi = 'Biết tin em học sinh hoàn cảnh đặc biệt khó khăn không đủ sức chi trả viện phí phẫu thuật bệnh nặng, vị hiệu trưởng già tốt bụng lập tức móc hết tiền tiết kiệm trong túi áo trong ra.'
WHERE id = 'd4a9a44e-b856-4b09-81cd-ae181257af96' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd4a9a44e-b856-4b09-81cd-ae181257af96', '得知这位家境贫寒的特困学生无力支付重病手术费，好心的老校长立刻从内衣口袋里掏出了所有积蓄。', 'Dézhī zhè wèi jiājìng pínhán de tèkùn xuésheng wúlì zhīfù zhòngbìng shǒushùfèi, hǎoxīn de lǎo xiàozhǎng lìkè cóng nèiyī kǒudài lǐ tāo chū le suǒyǒu jīxù.', 'Biết tin em học sinh hoàn cảnh đặc biệt khó khăn không đủ sức chi trả viện phí phẫu thuật bệnh nặng, vị hiệu trưởng già tốt bụng lập tức móc hết tiền tiết kiệm trong túi áo trong ra.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd4a9a44e-b856-4b09-81cd-ae181257af96'
);

-- [淘气] (táoqì): nghịch ngợm
UPDATE public.vocabularies
SET example_hanzi = '那个生性机灵淘气的小男孩总是喜欢偷偷把家里的小猫藏进纸箱里，和家人们捉迷藏。',
    example_pinyin = 'Nà gè shēngxìng jīlíng táoqì de xiǎo nánhái zǒngshì xǐhuan tōutōu bǎ jiā lǐ de xiǎomāo cáng jìn zhǐxiāng lǐ, hé jiārén men zhuōmícáng.',
    example_vi = 'Cậu bé tính tình lanh lợi nghịch ngợm ấy luôn thích lén giấu chú mèo con trong nhà vào thùng carton để chơi trò trốn tìm với người nhà.'
WHERE id = 'bc6ab8e6-2e76-4bab-863a-9243808a62ff' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bc6ab8e6-2e76-4bab-863a-9243808a62ff', '那个生性机灵淘气的小男孩总是喜欢偷偷把家里的小猫藏进纸箱里，和家人们捉迷藏。', 'Nà gè shēngxìng jīlíng táoqì de xiǎo nánhái zǒngshì xǐhuan tōutōu bǎ jiā lǐ de xiǎomāo cáng jìn zhǐxiāng lǐ, hé jiārén men zhuōmícáng.', 'Cậu bé tính tình lanh lợi nghịch ngợm ấy luôn thích lén giấu chú mèo con trong nhà vào thùng carton để chơi trò trốn tìm với người nhà.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bc6ab8e6-2e76-4bab-863a-9243808a62ff'
);

-- [淘汰] (táotài): đào thải, loại bỏ
UPDATE public.vocabularies
SET example_hanzi = '在日新月异的技术革命浪潮中，那些固步自封、不愿创新的传统老旧作坊终将被市场无情淘汰。',
    example_pinyin = 'Zài rìxīn-yuèyì de jìshù gémìng làngcháo zhōng, nàxiē gùbù-zìfēng, bú yuàn chuàngxīn de chuántǒng lǎojiù zuòfang zhōng jiāng bèi shìchǎng wúqíng táotài.',
    example_vi = 'Trong làn sóng cách mạng công nghệ thay đổi từng ngày, những xưởng cũ truyền thống giẫm chân tại chỗ không chịu đổi mới cuối cùng sẽ bị thị trường đào thải không thương tiếc.'
WHERE id = 'b68e7c0f-cec8-4a1e-b29d-5bda320b4626' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b68e7c0f-cec8-4a1e-b29d-5bda320b4626', '在日新月异的技术革命浪潮中，那些固步自封、不愿创新的传统老旧作坊终将被市场无情淘汰。', 'Zài rìxīn-yuèyì de jìshù gémìng làngcháo zhōng, nàxiē gùbù-zìfēng, bú yuàn chuàngxīn de chuántǒng lǎojiù zuòfang zhōng jiāng bèi shìchǎng wúqíng táotài.', 'Trong làn sóng cách mạng công nghệ thay đổi từng ngày, những xưởng cũ truyền thống giẫm chân tại chỗ không chịu đổi mới cuối cùng sẽ bị thị trường đào thải không thương tiếc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b68e7c0f-cec8-4a1e-b29d-5bda320b4626'
);

-- [踏实] (tāshi): yên tâm, vững vàng
UPDATE public.vocabularies
SET example_hanzi = '唯有脚踏实地、一步一个脚印地去努力拼搏，所获得的丰硕学业成就才能让人感到真正心安踏实。',
    example_pinyin = 'Wéiyǒu jiǎotà-shídì, yíbù yí gè jiǎoyìn de qù nǔlì pīnbó, suǒ huòdé de fēngshuò xuéyè chéngjiù cáinéng ràng rén gǎndào zhēnzhèng xīn''ān tāshi.',
    example_vi = 'Chỉ có vững vàng bước đi thực tế, từng bước từng bước nỗ lực phấn đấu thì thành tựu học tập gặt hái được mới khiến con người cảm thấy thực sự an lòng vững vàng.'
WHERE id = '27b7760a-9aa2-4849-af2a-5efcae534a9c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '27b7760a-9aa2-4849-af2a-5efcae534a9c', '唯有脚踏实地、一步一个脚印地去努力拼搏，所获得的丰硕学业成就才能让人感到真正心安踏实。', 'Wéiyǒu jiǎotà-shídì, yíbù yí gè jiǎoyìn de qù nǔlì pīnbó, suǒ huòdé de fēngshuò xuéyè chéngjiù cáinéng ràng rén gǎndào zhēnzhèng xīn''ān tāshi.', 'Chỉ có vững vàng bước đi thực tế, từng bước từng bước nỗ lực phấn đấu thì thành tựu học tập gặt hái được mới khiến con người cảm thấy thực sự an lòng vững vàng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '27b7760a-9aa2-4849-af2a-5efcae534a9c'
);

-- [特长] (tècháng): sở trường, điểm mạnh
UPDATE public.vocabularies
SET example_hanzi = '学校鼓励每位学生根据自己的兴趣特长自主选择社团活动，以充分激发个人的潜能。',
    example_pinyin = 'Xuéxiào gǔlì měi wèi xuésheng gēnjù zìjǐ de xìngqù tècháng zìzhǔ xuǎnzé shètuán huódòng, yǐ chōngfèn jīfā gèrén de qiánnéng.',
    example_vi = 'Nhà trường khuyến khích mỗi học sinh căn cứ theo sở thích sở trường của bản thân tự chủ lựa chọn hoạt động câu lạc bộ nhằm phát huy trọn vẹn tiềm năng cá nhân.'
WHERE id = 'abefbd58-6305-4e9c-a7c7-63ec73045653' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'abefbd58-6305-4e9c-a7c7-63ec73045653', '学校鼓励每位学生根据自己的兴趣特长自主选择社团活动，以充分激发个人的潜能。', 'Xuéxiào gǔlì měi wèi xuésheng gēnjù zìjǐ de xìngqù tècháng zìzhǔ xuǎnzé shètuán huódòng, yǐ chōngfèn jīfā gèrén de qiánnéng.', 'Nhà trường khuyến khích mỗi học sinh căn cứ theo sở thích sở trường của bản thân tự chủ lựa chọn hoạt động câu lạc bộ nhằm phát huy trọn vẹn tiềm năng cá nhân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'abefbd58-6305-4e9c-a7c7-63ec73045653'
);

-- [特定] (tèdìng): cụ thể, đặc định
UPDATE public.vocabularies
SET example_hanzi = '某些具有强烈生物毒性的化学试剂，必须在特定温度与密封防爆的专门实验室内妥善保管。',
    example_pinyin = 'Mǒuxiē jùyǒu qiángliè shēngwù dúxìng de huàxué shìjì, bìxū zài tèdìng wēndù yǔ mìfēng fángbào de zhuānmén shíyànshì nèi tuǒshàn bǎoguǎn.',
    example_vi = 'Một số loại hóa chất có độc tính sinh học mạnh phải được bảo quản thỏa đáng ở nhiệt độ đặc định và bên trong phòng thí nghiệm chuyên dụng phòng nổ kín mít.'
WHERE id = '7b65d5f8-3bf9-48b6-bdbf-dea751bdf26d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7b65d5f8-3bf9-48b6-bdbf-dea751bdf26d', '某些具有强烈生物毒性的化学试剂，必须在特定温度与密封防爆的专门实验室内妥善保管。', 'Mǒuxiē jùyǒu qiángliè shēngwù dúxìng de huàxué shìjì, bìxū zài tèdìng wēndù yǔ mìfēng fángbào de zhuānmén shíyànshì nèi tuǒshàn bǎoguǎn.', 'Một số loại hóa chất có độc tính sinh học mạnh phải được bảo quản thỏa đáng ở nhiệt độ đặc định và bên trong phòng thí nghiệm chuyên dụng phòng nổ kín mít.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7b65d5f8-3bf9-48b6-bdbf-dea751bdf26d'
);

-- [特意] (tèyì): đặc biệt, có ý riêng
UPDATE public.vocabularies
SET example_hanzi = '得知恩师今天恰逢八十大寿，旅居海外多年的学生特意乘坐长途航班赶回母校登门祝贺。',
    example_pinyin = 'Dézhī ēnshī jīntiān qiàféng bāshí dàshòu, lǚjū hǎiwài duōnián de xuésheng tèyì chéngzuò chángtú hángbān gǎn huí mǔxiào dēngmén zhùhè.',
    example_vi = 'Biết tin hôm nay đúng dịp đại thọ tám mươi tuổi của người thầy ơn, học trò sinh sống ở nước ngoài nhiều năm đã đặc ý bắt chuyến bay đường dài trở về trường cũ đến tận nhà chúc mừng.'
WHERE id = 'f8bebb22-a080-4b4f-aee8-0253b98343de' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f8bebb22-a080-4b4f-aee8-0253b98343de', '得知恩师今天恰逢八十大寿，旅居海外多年的学生特意乘坐长途航班赶回母校登门祝贺。', 'Dézhī ēnshī jīntiān qiàféng bāshí dàshòu, lǚjū hǎiwài duōnián de xuésheng tèyì chéngzuò chángtú hángbān gǎn huí mǔxiào dēngmén zhùhè.', 'Biết tin hôm nay đúng dịp đại thọ tám mươi tuổi của người thầy ơn, học trò sinh sống ở nước ngoài nhiều năm đã đặc ý bắt chuyến bay đường dài trở về trường cũ đến tận nhà chúc mừng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f8bebb22-a080-4b4f-aee8-0253b98343de'
);

-- [提示] (tí shì): gợi ý, nhắc nhở
UPDATE public.vocabularies
SET example_hanzi = '车机智能导航系统在车辆即将驶入复杂匝道口前，会发出清晰准确的语音转向提示。',
    example_pinyin = 'Chējī zhìnéng dǎoháng xìtǒng zài chēliàng jíjiāng shǐrù fùzá zádàokǒu qián, huì fāchū qīngxī zhǔnquè de yǔyīn zhuǎnxiàng tíshì.',
    example_vi = 'Hệ thống định vị thông minh trên xe trước khi phương tiện sắp đi vào ngã rẽ nhánh phức tạp sẽ phát ra lời nhắc chuyển hướng bằng giọng nói rõ ràng chuẩn xác.'
WHERE id = 'a3db81f2-8e0f-4c17-80de-81e0ac522eee' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a3db81f2-8e0f-4c17-80de-81e0ac522eee', '车机智能导航系统在车辆即将驶入复杂匝道口前，会发出清晰准确的语音转向提示。', 'Chējī zhìnéng dǎoháng xìtǒng zài chēliàng jíjiāng shǐrù fùzá zádàokǒu qián, huì fāchū qīngxī zhǔnquè de yǔyīn zhuǎnxiàng tíshì.', 'Hệ thống định vị thông minh trên xe trước khi phương tiện sắp đi vào ngã rẽ nhánh phức tạp sẽ phát ra lời nhắc chuyển hướng bằng giọng nói rõ ràng chuẩn xác.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a3db81f2-8e0f-4c17-80de-81e0ac522eee'
);

-- [天才] (tiāncái): thiên tài
UPDATE public.vocabularies
SET example_hanzi = '世界上固然存在天赋异禀的旷世天才，但任何卓越成就的背后都离不开日复一日的汗水浇灌。',
    example_pinyin = 'Shìjiè shang gùrán cúnzài tiānfù-yìbǐng de kuàngshì tiāncái, dàn rènhé zhuóyuè chéngjiù de bèihòu dōu lí bù kāi rì-fù-yí-rì de hànshuǐ jiāoguàn.',
    example_vi = 'Trên thế giới dẫu có tồn tại những thiên tài hiếm có với thiên bẩm phi thường, nhưng đằng sau bất kỳ thành tựu trác việt nào cũng không thể tách rời việc tưới tắm mồ hôi ngày này qua ngày khác.'
WHERE id = '9fdb60a8-a97c-4e44-8fe6-29d3f0e2174d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9fdb60a8-a97c-4e44-8fe6-29d3f0e2174d', '世界上固然存在天赋异禀的旷世天才，但任何卓越成就的背后都离不开日复一日的汗水浇灌。', 'Shìjiè shang gùrán cúnzài tiānfù-yìbǐng de kuàngshì tiāncái, dàn rènhé zhuóyuè chéngjiù de bèihòu dōu lí bù kāi rì-fù-yí-rì de hànshuǐ jiāoguàn.', 'Trên thế giới dẫu có tồn tại những thiên tài hiếm có với thiên bẩm phi thường, nhưng đằng sau bất kỳ thành tựu trác việt nào cũng không thể tách rời việc tưới tắm mồ hôi ngày này qua ngày khác.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9fdb60a8-a97c-4e44-8fe6-29d3f0e2174d'
);

-- [田径] (tiánjìng): điền kinh
UPDATE public.vocabularies
SET example_hanzi = '在每四年举办一届的全国综合运动会上，扣人心弦的田径比赛始终是吸引无数目光的重头戏。',
    example_pinyin = 'Zài měi sì nián jǔbàn yí jiè de quánguó zōnghé yùndònghuì shang, kòurénxīnxuán de tiánjìng bǐsài shǐzhōng shì xīyǐn wúshù mùmǎ de zhòngtóuxì.',
    example_vi = 'Tại Đại hội thể thao tổng hợp toàn quốc tổ chức bốn năm một lần, các cuộc thi điền kinh gay cấn thắt nghẹt con tim luôn là tâm điểm hấp dẫn vô số ánh nhìn.'
WHERE id = 'fa261f05-4886-45e1-8b41-a220a21abe21' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fa261f05-4886-45e1-8b41-a220a21abe21', '在每四年举办一届的全国综合运动会上，扣人心弦的田径比赛始终是吸引无数目光的重头戏。', 'Zài měi sì nián jǔbàn yí jiè de quánguó zōnghé yùndònghuì shang, kòurénxīnxuán de tiánjìng bǐsài shǐzhōng shì xīyǐn wúshù mùmǎ de zhòngtóuxì.', 'Tại Đại hội thể thao tổng hợp toàn quốc tổ chức bốn năm một lần, các cuộc thi điền kinh gay cấn thắt nghẹt con tim luôn là tâm điểm hấp dẫn vô số ánh nhìn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fa261f05-4886-45e1-8b41-a220a21abe21'
);

-- [天然气] (tiānránqì): khí đốt thiên nhiên
UPDATE public.vocabularies
SET example_hanzi = '作为一种清洁高效的低碳化石燃料，天然气在城市民用供暖与工业生产中得到了广泛普及与应用。',
    example_pinyin = 'Zuòwéi yì zhǒng qīngjié gāoxiào de dītàn huàshí ránliào, tiānránqì zài chéngshì mínyòng gōngnuǎn yǔ gōngyè shēngchǎn zhōng dédào le guǎngfàn pǔjí yǔ yìngyòng.',
    example_vi = 'Là một loại nhiên liệu hóa thạch carbon thấp sạch và hiệu suất cao, khí đốt tự nhiên đã được phổ cập và ứng dụng rộng rãi trong sưởi ấm dân dụng đô thị và sản xuất công nghiệp.'
WHERE id = 'a3d89979-4212-463c-b3c6-41475823b916' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a3d89979-4212-463c-b3c6-41475823b916', '作为一种清洁高效的低碳化石燃料，天然气在城市民用供暖与工业生产中得到了广泛普及与应用。', 'Zuòwéi yì zhǒng qīngjié gāoxiào de dītàn huàshí ránliào, tiānránqì zài chéngshì mínyòng gōngnuǎn yǔ gōngyè shēngchǎn zhōng dédào le guǎngfàn pǔjí yǔ yìngyòng.', 'Là một loại nhiên liệu hóa thạch carbon thấp sạch và hiệu suất cao, khí đốt tự nhiên đã được phổ cập và ứng dụng rộng rãi trong sưởi ấm dân dụng đô thị và sản xuất công nghiệp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a3d89979-4212-463c-b3c6-41475823b916'
);

-- [天文] (tiānwén): thiên văn
UPDATE public.vocabularies
SET example_hanzi = '科学家通过架设在崇山峻岭之巅的射电望远镜，持续观测浩瀚宇宙深处的天文奇观。',
    example_pinyin = 'Kēxuéjiā tōngguò jiàshè zài chóngshān-jùnlǐng zhī diān de shèdiàn wàngyuǎnjìng, chíxù guāncè hàohàn yǔzhòu shēncù de tiānwén qíguān.',
    example_vi = 'Các nhà khoa học thông qua kính viễn vọng vô tuyến đặt trên đỉnh những dãy núi non trùng điệp đã liên tục quan trắc những kỳ quan thiên văn nơi sâu thẳm vũ trụ bao la.'
WHERE id = '242a714a-136f-470f-b000-2e7349c12b26' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '242a714a-136f-470f-b000-2e7349c12b26', '科学家通过架设在崇山峻岭之巅的射电望远镜，持续观测浩瀚宇宙深处的天文奇观。', 'Kēxuéjiā tōngguò jiàshè zài chóngshān-jùnlǐng zhī diān de shèdiàn wàngyuǎnjìng, chíxù guāncè hàohàn yǔzhòu shēncù de tiānwén qíguān.', 'Các nhà khoa học thông qua kính viễn vọng vô tuyến đặt trên đỉnh những dãy núi non trùng điệp đã liên tục quan trắc những kỳ quan thiên văn nơi sâu thẳm vũ trụ bao la.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '242a714a-136f-470f-b000-2e7349c12b26'
);

-- [天真] (tiānzhēn): ngây thơ, hồn nhiên
UPDATE public.vocabularies
SET example_hanzi = '幼儿园里到处回荡着孩子们天真烂漫的欢笑声，如同一缕缕清泉洗涤着成人的烦忧。',
    example_pinyin = 'YòU''éryuán lǐ dàochù huídàng zhe háizi men tiānzhēn-lànmàn de huānxiàoshēng, rútóng yì lǚlǚ qīngquán xǐdí zhe chéngrén de fányōu.',
    example_vi = 'Khắp nơi trong trường mẫu giáo vang vọng tiếng cười nói hồn nhiên ngây thơ của các em nhỏ, như từng dòng suối trong gột rửa những phiền muộn của người lớn.'
WHERE id = 'b060f64f-bae5-48c8-a8ce-e7cbb35a13ac' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b060f64f-bae5-48c8-a8ce-e7cbb35a13ac', '幼儿园里到处回荡着孩子们天真烂漫的欢笑声，如同一缕缕清泉洗涤着成人的烦忧。', 'YòU''éryuán lǐ dàochù huídàng zhe háizi men tiānzhēn-lànmàn de huānxiàoshēng, rútóng yì lǚlǚ qīngquán xǐdí zhe chéngrén de fányōu.', 'Khắp nơi trong trường mẫu giáo vang vọng tiếng cười nói hồn nhiên ngây thơ của các em nhỏ, như từng dòng suối trong gột rửa những phiền muộn của người lớn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b060f64f-bae5-48c8-a8ce-e7cbb35a13ac'
);

-- [调节] (tiáojié): điều chỉnh, điều tiết
UPDATE public.vocabularies
SET example_hanzi = '中央银行通过调整存贷款基准利率等货币政策工具，及时调节市场流动性与物价稳定。',
    example_pinyin = 'Zhōngyāng yínháng tōngguò tiáozhěng cún-dàikuǎn jīzhǔn lìlǜ děng huòbì zhèngcè gōngjù, jíshí tiáojié shìchǎng liúdòngxìng yǔ wùjià wěndìng.',
    example_vi = 'Ngân hàng trung ương thông qua các công cụ chính sách tiền tệ như điều chỉnh lãi suất cơ bản tiền gửi và cho vay để kịp thời điều tiết tính thanh khoản thị trường và bình ổn vật giá.'
WHERE id = '0b3fab5c-8188-4b5d-ad4d-7acbb6c3f1b8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0b3fab5c-8188-4b5d-ad4d-7acbb6c3f1b8', '中央银行通过调整存贷款基准利率等货币政策工具，及时调节市场流动性与物价稳定。', 'Zhōngyāng yínháng tōngguò tiáozhěng cún-dàikuǎn jīzhǔn lìlǜ děng huòbì zhèngcè gōngjù, jíshí tiáojié shìchǎng liúdòngxìng yǔ wùjià wěndìng.', 'Ngân hàng trung ương thông qua các công cụ chính sách tiền tệ như điều chỉnh lãi suất cơ bản tiền gửi và cho vay để kịp thời điều tiết tính thanh khoản thị trường và bình ổn vật giá.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0b3fab5c-8188-4b5d-ad4d-7acbb6c3f1b8'
);

-- [题材] (tícái): đề tài
UPDATE public.vocabularies
SET example_hanzi = '这位现实主义作家擅长从底层普通百姓的柴米油盐日常生活中发掘感人至深的文学题材。',
    example_pinyin = 'Zhè wèi xiànshí zhǔyì zuòjiā shàncháng cóng dǐcéng pǔtōng bǎixìng de chái-mǐ-yóu-yán rìcháng shēnghuó zhōng fājué gǎnrén zhì shēn de wénxué tícái.',
    example_vi = 'Nhà văn hiện thực chủ nghĩa này sở trường khai thác những đề tài văn học cảm động chạm sâu vào đáy lòng từ cuộc sống sinh hoạt củi gạo dầu muối hằng ngày của bách tính bình dân cơ tầng.'
WHERE id = 'a02f98a7-46e7-4fb0-98b8-ce66d963a25a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a02f98a7-46e7-4fb0-98b8-ce66d963a25a', '这位现实主义作家擅长从底层普通百姓的柴米油盐日常生活中发掘感人至深的文学题材。', 'Zhè wèi xiànshí zhǔyì zuòjiā shàncháng cóng dǐcéng pǔtōng bǎixìng de chái-mǐ-yóu-yán rìcháng shēnghuó zhōng fājué gǎnrén zhì shēn de wénxué tícái.', 'Nhà văn hiện thực chủ nghĩa này sở trường khai thác những đề tài văn học cảm động chạm sâu vào đáy lòng từ cuộc sống sinh hoạt củi gạo dầu muối hằng ngày của bách tính bình dân cơ tầng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a02f98a7-46e7-4fb0-98b8-ce66d963a25a'
);

-- [体积] (tǐjī): thể tích
UPDATE public.vocabularies
SET example_hanzi = '与老式笨重的台式电脑相比，现代超级笔记本电脑不仅体积大幅缩小，运算效能更成倍跃升。',
    example_pinyin = 'Yǔ lǎoshì bènzhòng de táishì diànnǎo xiāngbǐ, xiàndài chāojí bǐjìběn diànnǎo bùjǐn tǐjī dàfú suōxiǎo, yùnsuàn xiàonéng gèng chéngbèi yuèshēng.',
    example_vi = 'So với máy tính để bàn kiểu cũ cồng kềnh, máy tính xách tay siêu mỏng hiện đại không chỉ thể tích thu nhỏ đáng kể mà hiệu năng tính toán còn nhảy vọt gấp nhiều lần.'
WHERE id = '949a0a1e-af59-4660-8399-f763b54aefb2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '949a0a1e-af59-4660-8399-f763b54aefb2', '与老式笨重的台式电脑相比，现代超级笔记本电脑不仅体积大幅缩小，运算效能更成倍跃升。', 'Yǔ lǎoshì bènzhòng de táishì diànnǎo xiāngbǐ, xiàndài chāojí bǐjìběn diànnǎo bùjǐn tǐjī dàfú suōxiǎo, yùnsuàn xiàonéng gèng chéngbèi yuèshēng.', 'So với máy tính để bàn kiểu cũ cồng kềnh, máy tính xách tay siêu mỏng hiện đại không chỉ thể tích thu nhỏ đáng kể mà hiệu năng tính toán còn nhảy vọt gấp nhiều lần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '949a0a1e-af59-4660-8399-f763b54aefb2'
);

-- [体系] (tǐxì): hệ thống, thể hệ
UPDATE public.vocabularies
SET example_hanzi = '建立健全覆盖全体公民的高质量公共卫生防护体系，是维护国家生物安全的核心保障。',
    example_pinyin = 'Jiànlì jiànquán fùgài quántǐ gōngmín de gāo zhìliàng gōnggòng wèishēng fánghù tǐxì, shì wéihù guójiā shēngwù ānquán de héxīn bǎozhàng.',
    example_vi = 'Thiết lập hoàn thiện hệ thống phòng hộ vệ sinh công cộng chất lượng cao bao phủ toàn thể công dân là sự bảo đảm cốt lõi để giữ gìn an ninh sinh học quốc gia.'
WHERE id = 'aa2695e8-017b-4bf0-ac24-136444ae6a93' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'aa2695e8-017b-4bf0-ac24-136444ae6a93', '建立健全覆盖全体公民的高质量公共卫生防护体系，是维护国家生物安全的核心保障。', 'Jiànlì jiànquán fùgài quántǐ gōngmín de gāo zhìliàng gōnggòng wèishēng fánghù tǐxì, shì wéihù guójiā shēngwù ānquán de héxīn bǎozhàng.', 'Thiết lập hoàn thiện hệ thống phòng hộ vệ sinh công cộng chất lượng cao bao phủ toàn thể công dân là sự bảo đảm cốt lõi để giữ gìn an ninh sinh học quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'aa2695e8-017b-4bf0-ac24-136444ae6a93'
);

-- [铜] (tóng): đồng (kim loại)
UPDATE public.vocabularies
SET example_hanzi = '作为导电性能仅次于银的优良金属，金属铜在电力输送缆线与电机制造中具有无法取代的地位。',
    example_pinyin = 'Zuòwéi dǎodiàn xìngnéng jǐn cì yú yín de yōuliáng jīnshǔ, jīnshǔ tóng zài diànlì shūsòng lǎnxiàn yǔ diànjī zhìzào zhōng jùyǒu wúfǎ qǔdài de dìwèi.',
    example_vi = 'Là kim loại ưu lương có tính năng dẫn điện chỉ đứng sau bạc, đồng kim loại có vị thế không thể thay thế trong cáp truyền dẫn điện lực và chế tạo động cơ điện.'
WHERE id = 'ef6f399d-5ead-49d9-9a4b-7ed673539ec5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ef6f399d-5ead-49d9-9a4b-7ed673539ec5', '作为导电性能仅次于银的优良金属，金属铜在电力输送缆线与电机制造中具有无法取代的地位。', 'Zuòwéi dǎodiàn xìngnéng jǐn cì yú yín de yōuliáng jīnshǔ, jīnshǔ tóng zài diànlì shūsòng lǎnxiàn yǔ diànjī zhìzào zhōng jùyǒu wúfǎ qǔdài de dìwèi.', 'Là kim loại ưu lương có tính năng dẫn điện chỉ đứng sau bạc, đồng kim loại có vị thế không thể thay thế trong cáp truyền dẫn điện lực và chế tạo động cơ điện.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ef6f399d-5ead-49d9-9a4b-7ed673539ec5'
);

-- [童话] (tónghuà): truyện cổ tích
UPDATE public.vocabularies
SET example_hanzi = '安徒生经典童话故事不仅启迪了亿万儿童的纯真想象，也深深慰藉着许多成年人的心灵。',
    example_pinyin = 'Āntúsēng jīngdiǎn tónghuà gùshì bùjǐn qǐdí le yìwàn értóng de chúnzhēn xiǎngxiàng, yě shēnshēn wèijiè zhe xǔduō chéngrén de xīnlíng.',
    example_vi = 'Những câu chuyện cổ tích kinh điển của Andersen không chỉ khai sáng trí tưởng tượng thuần khiết của hàng trăm triệu trẻ thơ, mà còn an ủi sâu sắc tâm hồn của bao người trưởng thành.'
WHERE id = '49d83668-1614-409d-bbc8-1ba70201ee4b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '49d83668-1614-409d-bbc8-1ba70201ee4b', '安徒生经典童话故事不仅启迪了亿万儿童的纯真想象，也深深慰藉着许多成年人的心灵。', 'Āntúsēng jīngdiǎn tónghuà gùshì bùjǐn qǐdí le yìwàn értóng de chúnzhēn xiǎngxiàng, yě shēnshēn wèijiè zhe xǔduō chéngrén de xīnlíng.', 'Những câu chuyện cổ tích kinh điển của Andersen không chỉ khai sáng trí tưởng tượng thuần khiết của hàng trăm triệu trẻ thơ, mà còn an ủi sâu sắc tâm hồn của bao người trưởng thành.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '49d83668-1614-409d-bbc8-1ba70201ee4b'
);

-- [痛快] (tòngkuai): sảng khoái, vui sướng
UPDATE public.vocabularies
SET example_hanzi = '在炎热酷暑的盛夏午后痛痛快快地冲一个凉水澡，令人顿感神清气爽、身心格外痛快。',
    example_pinyin = 'Zài yánrè kùshǔ de shèngxià wǔhòu tòng-tòng-kuài-kuài de chōng yí gè liángshuǐ zǎo, lìngrén dùn gǎn shénqīng-qìshuǎng, shēnxīn géwài tòngkuai.',
    example_vi = 'Vào một buổi chiều hè oi bức bỏng rát được tắm một trận nước mát thật đã đời khiến con người ta lập tức cảm thấy tinh thần sảng khoái, tâm thân vô cùng thoải mái thống khoái.'
WHERE id = '2f6e70a0-0bc3-4773-8b81-072ac6c8a599' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2f6e70a0-0bc3-4773-8b81-072ac6c8a599', '在炎热酷暑的盛夏午后痛痛快快地冲一个凉水澡，令人顿感神清气爽、身心格外痛快。', 'Zài yánrè kùshǔ de shèngxià wǔhòu tòng-tòng-kuài-kuài de chōng yí gè liángshuǐ zǎo, lìngrén dùn gǎn shénqīng-qìshuǎng, shēnxīn géwài tòngkuai.', 'Vào một buổi chiều hè oi bức bỏng rát được tắm một trận nước mát thật đã đời khiến con người ta lập tức cảm thấy tinh thần sảng khoái, tâm thân vô cùng thoải mái thống khoái.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2f6e70a0-0bc3-4773-8b81-072ac6c8a599'
);

-- [通讯] (tōngxùn): thông tin, viễn thông
UPDATE public.vocabularies
SET example_hanzi = '第五代移动无线通讯网络的全面铺开，为自动驾驶与智能物联网产业提供了坚强技术底座。',
    example_pinyin = 'Dì wǔ dài yídòng wúxiàn tōngxùn wǎngluò de quánmiàn pūkāi, wèi zìdòng jiàshǐ yǔ zhìnéng wùliánwǎng chǎnyè tígōng le jiānqiáng jìshù dǐzuò.',
    example_vi = 'Việc mở rộng phủ sóng toàn diện mạng lưới viễn thông không dây di động thế hệ thứ năm đã cung cấp nền tảng công nghệ vững chắc cho ngành lái xe tự động và IoT thông minh.'
WHERE id = '6e9422c0-27cd-48b8-9d02-bca897d36d32' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6e9422c0-27cd-48b8-9d02-bca897d36d32', '第五代移动无线通讯网络的全面铺开，为自动驾驶与智能物联网产业提供了坚强技术底座。', 'Dì wǔ dài yídòng wúxiàn tōngxùn wǎngluò de quánmiàn pūkāi, wèi zìdòng jiàshǐ yǔ zhìnéng wùliánwǎng chǎnyè tígōng le jiānqiáng jìshù dǐzuò.', 'Việc mở rộng phủ sóng toàn diện mạng lưới viễn thông không dây di động thế hệ thứ năm đã cung cấp nền tảng công nghệ vững chắc cho ngành lái xe tự động và IoT thông minh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6e9422c0-27cd-48b8-9d02-bca897d36d32'
);

-- [通用] (tōngyòng): thông dụng, dùng chung
UPDATE public.vocabularies
SET example_hanzi = '这种全新设计的手机充电接口符合最新的国际通用标准，极大地方便了跨国商务旅客。',
    example_pinyin = 'Zhè zhǒng quánxīn shèjì de shǒujī chōngdiàn jiēkǒu fúhé zuìxīn de guójì tōngyòng biāozhǔn, jídà de fāngbiàn le kuàguó shāngwù lǚkè.',
    example_vi = 'Cổng cắm sạc điện thoại thiết kế hoàn toàn mới này phù hợp với tiêu chuẩn thông dụng quốc tế mới nhất, tạo thuận lợi cực lớn cho các hành khách thương vụ xuyên quốc gia.'
WHERE id = '708bc38d-eae7-447e-bbf9-4bfb38a75464' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '708bc38d-eae7-447e-bbf9-4bfb38a75464', '这种全新设计的手机充电接口符合最新的国际通用标准，极大地方便了跨国商务旅客。', 'Zhè zhǒng quánxīn shèjì de shǒujī chōngdiàn jiēkǒu fúhé zuìxīn de guójì tōngyòng biāozhǔn, jídà de fāngbiàn le kuàguó shāngwù lǚkè.', 'Cổng cắm sạc điện thoại thiết kế hoàn toàn mới này phù hợp với tiêu chuẩn thông dụng quốc tế mới nhất, tạo thuận lợi cực lớn cho các hành khách thương vụ xuyên quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '708bc38d-eae7-447e-bbf9-4bfb38a75464'
);

-- [偷] (tōu): trộm, cắp
UPDATE public.vocabularies
SET example_hanzi = '火车站广场上的广播不间断提醒旅客注意看管好随身贵重包裹，严防小偷趁人多拥挤下手行窃。',
    example_pinyin = 'Huǒchēzhàn guǎngchǎng shang de guǎngbō bù jiānduàn tíxǐng lǚkè zhùyì kānguǎn hǎo suíshēn guìzhòng bāoguǒ, yánfáng xiǎotōu chèn rén duō yōngjǐ xiàshǒu xíngqiè.',
    example_vi = 'Hệ thống loa phát thanh trên quảng trường ga tàu hỏa liên tục nhắc nhở hành khách chú ý trông coi hành lý quý giá bên mình, đề phòng kẻ trộm thừa lúc đông đúc chen lấn ra tay trộm cắp.'
WHERE id = '041ab754-fb05-464c-8e72-42e67cf79ba7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '041ab754-fb05-464c-8e72-42e67cf79ba7', '火车站广场上的广播不间断提醒旅客注意看管好随身贵重包裹，严防小偷趁人多拥挤下手行窃。', 'Huǒchēzhàn guǎngchǎng shang de guǎngbō bù jiānduàn tíxǐng lǚkè zhùyì kānguǎn hǎo suíshēn guìzhòng bāoguǒ, yánfáng xiǎotōu chèn rén duō yōngjǐ xiàshǒu xíngqiè.', 'Hệ thống loa phát thanh trên quảng trường ga tàu hỏa liên tục nhắc nhở hành khách chú ý trông coi hành lý quý giá bên mình, đề phòng kẻ trộm thừa lúc đông đúc chen lấn ra tay trộm cắp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '041ab754-fb05-464c-8e72-42e67cf79ba7'
);

-- [透露] (tòulù): tiết lộ, để lộ
UPDATE public.vocabularies
SET example_hanzi = '据内部知情核心人士透露，该跨国科技巨头即将于下周正式对外发布其旗舰级自研芯片。',
    example_pinyin = 'Jù nèibù zhīqíng héxīn rénshì tòulù, gāi kuàguó kējì jùtóu jíjiāng yú xià zhōu zhèngshì duìwài fābù qí qíjiànjí zìyán xīnpìan.',
    example_vi = 'Theo một nhân sự cốt cán nắm rõ nội tình tiết lộ, gã khổng lồ công nghệ đa quốc gia này sắp sửa chính thức công bố con chip đầu bảng tự nghiên cứu ra bên ngoài vào tuần sau.'
WHERE id = '0759a078-9d3e-4db7-b8cf-e9272e159115' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0759a078-9d3e-4db7-b8cf-e9272e159115', '据内部知情核心人士透露，该跨国科技巨头即将于下周正式对外发布其旗舰级自研芯片。', 'Jù nèibù zhīqíng héxīn rénshì tòulù, gāi kuàguó kējì jùtóu jíjiāng yú xià zhōu zhèngshì duìwài fābù qí qíjiànjí zìyán xīnpìan.', 'Theo một nhân sự cốt cán nắm rõ nội tình tiết lộ, gã khổng lồ công nghệ đa quốc gia này sắp sửa chính thức công bố con chip đầu bảng tự nghiên cứu ra bên ngoài vào tuần sau.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0759a078-9d3e-4db7-b8cf-e9272e159115'
);

-- [透明] (tòumíng): trong suốt, minh bạch
UPDATE public.vocabularies
SET example_hanzi = '该慈善公益基金会每季度都会主动向社会公布详细的善款收支明细账目，确保运营高度公开透明。',
    example_pinyin = 'Gāi císhàn gōngyì jījīnhuì měi jìdù dōu huì zhǔdòng xiàng shèhuì gōngbù xiángxì de shànkuǎn shōuzhī míngxì zhàngmù, quèbǎo yùnyíng gāodù gōngkāi tòumíng.',
    example_vi = 'Quỹ từ thiện công ích này mỗi quý đều chủ động công khai các khoản mục thu chi tiền quyên góp chi tiết ra toàn xã hội nhằm bảo đảm hoạt động vận hành công khai minh bạch cao độ.'
WHERE id = '979217f0-324c-4518-99f7-e368d7c2970e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '979217f0-324c-4518-99f7-e368d7c2970e', '该慈善公益基金会每季度都会主动向社会公布详细的善款收支明细账目，确保运营高度公开透明。', 'Gāi císhàn gōngyì jījīnhuì měi jìdù dōu huì zhǔdòng xiàng shèhuì gōngbù xiángxì de shànkuǎn shōuzhī míngxì zhàngmù, quèbǎo yùnyíng gāodù gōngkāi tòumíng.', 'Quỹ từ thiện công ích này mỗi quý đều chủ động công khai các khoản mục thu chi tiền quyên góp chi tiết ra toàn xã hội nhằm bảo đảm hoạt động vận hành công khai minh bạch cao độ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '979217f0-324c-4518-99f7-e368d7c2970e'
);

-- [投票] (tóupiào): bỏ phiếu
UPDATE public.vocabularies
SET example_hanzi = '在今天的业主代表大会上，全体与会业主依次走到投票箱前庄严投下了自己的一票。',
    example_pinyin = 'Zài jīntiān de yèzhǔ dàibiǎo dàhuì shang, quántǐ yùhuì yèzhǔ yīcì zǒu dào tóupiàoxiāng qián zhuāngyán tóuxià le zìjǐ de yí piào.',
    example_vi = 'Tại hội nghị đại biểu cư dân chủ hộ hôm nay, toàn thể các chủ hộ tham dự lần lượt bước tới trước hòm phiếu trang nghiêm bỏ lá phiếu của mình.'
WHERE id = '2ed108fd-41b7-4f05-935a-507447380558' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2ed108fd-41b7-4f05-935a-507447380558', '在今天的业主代表大会上，全体与会业主依次走到投票箱前庄严投下了自己的一票。', 'Zài jīntiān de yèzhǔ dàibiǎo dàhuì shang, quántǐ yùhuì yèzhǔ yīcì zǒu dào tóupiàoxiāng qián zhuāngyán tóuxià le zìjǐ de yí piào.', 'Tại hội nghị đại biểu cư dân chủ hộ hôm nay, toàn thể các chủ hộ tham dự lần lượt bước tới trước hòm phiếu trang nghiêm bỏ lá phiếu của mình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2ed108fd-41b7-4f05-935a-507447380558'
);

-- [投诉] (tóusù): khiếu nại, than phiền
UPDATE public.vocabularies
SET example_hanzi = '消费者权益保护委员会接到多起关于某电商平台虚假宣传与拒绝退货的消费者集体投诉。',
    example_pinyin = 'Xiāofèizhě quányì bǎohù wěiyuánhuì jiē dào duō qǐ guānyú mǒu diànshāng píngtái xūjiǎ xuānchuán yǔ jùjué tuìhuò de xiāofèizhě jítǐ tóusù.',
    example_vi = 'Ủy ban Bảo vệ Quyền lợi Người tiêu dùng đã tiếp nhận nhiều vụ khiếu nại tập thể của người tiêu dùng liên quan đến một sàn thương mại điện tử quảng cáo sai sự thật và từ chối đổi trả hàng.'
WHERE id = 'a2529b7a-89b8-4d12-a945-d981ad0b48ad' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a2529b7a-89b8-4d12-a945-d981ad0b48ad', '消费者权益保护委员会接到多起关于某电商平台虚假宣传与拒绝退货的消费者集体投诉。', 'Xiāofèizhě quányì bǎohù wěiyuánhuì jiē dào duō qǐ guānyú mǒu diànshāng píngtái xūjiǎ xuānchuán yǔ jùjué tuìhuò de xiāofèizhě jítǐ tóusù.', 'Ủy ban Bảo vệ Quyền lợi Người tiêu dùng đã tiếp nhận nhiều vụ khiếu nại tập thể của người tiêu dùng liên quan đến một sàn thương mại điện tử quảng cáo sai sự thật và từ chối đổi trả hàng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a2529b7a-89b8-4d12-a945-d981ad0b48ad'
);

-- [投资] (tóuzī): đầu tư
UPDATE public.vocabularies
SET example_hanzi = '市政府决定持续加大对基础科学研究与高新前沿技术产业的长期财政投资力度。',
    example_pinyin = 'Shìzhèngfǔ juédìng chíxù jiàdà duì jīchǔ kēxué yánjiū yǔ gāoxīn qiányán jìshù chǎnyè de chángqī cáizhèng tóuzī lìdù.',
    example_vi = 'Chính quyền thành phố quyết định tiếp tục gia tăng cường độ đầu tư tài chính dài hạn đối với các nghiên cứu khoa học cơ bản và các ngành công nghiệp công nghệ cao đi đầu.'
WHERE id = '9433f31b-71ed-411a-b5bb-c76fe1037f2a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9433f31b-71ed-411a-b5bb-c76fe1037f2a', '市政府决定持续加大对基础科学研究与高新前沿技术产业的长期财政投资力度。', 'Shìzhèngfǔ juédìng chíxù jiàdà duì jīchǔ kēxué yánjiū yǔ gāoxīn qiányán jìshù chǎnyè de chángqī cáizhèng tóuzī lìdù.', 'Chính quyền thành phố quyết định tiếp tục gia tăng cường độ đầu tư tài chính dài hạn đối với các nghiên cứu khoa học cơ bản và các ngành công nghiệp công nghệ cao đi đầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9433f31b-71ed-411a-b5bb-c76fe1037f2a'
);

-- [吐] (tù): nôn mửa, nhả ra
UPDATE public.vocabularies
SET example_hanzi = '客轮在狂风巨浪的大海上剧烈颠簸，不少初次乘船出海的乘客都感到头晕恶心、忍不住连连呕吐。',
    example_pinyin = 'Kèlún zài kuángfēng-jùlàng de dàhǎi shang jùliè diānbǒ, bù shǎo chūcì chéngchuán chūhǎi de chéngkè dōu gǎndào tóuyūn-ěxīn, rěnbuzhù liánlián ǒutù.',
    example_vi = 'Con tàu chở khách lắc lư dữ dội giữa biển cả sóng to gió lớn, không ít hành khách lần đầu đi thuyền ra khơi đều thấy chóng mặt buồn nôn, không nhịn được mà nôn mửa liên tục.'
WHERE id = 'a69a3278-0438-41ba-9349-c42f020a15a6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a69a3278-0438-41ba-9349-c42f020a15a6', '客轮在狂风巨浪的大海上剧烈颠簸，不少初次乘船出海的乘客都感到头晕恶心、忍不住连连呕吐。', 'Kèlún zài kuángfēng-jùlàng de dàhǎi shang jùliè diānbǒ, bù shǎo chūcì chéngchuán chūhǎi de chéngkè dōu gǎndào tóuyūn-ěxīn, rěnbuzhù liánlián ǒutù.', 'Con tàu chở khách lắc lư dữ dội giữa biển cả sóng to gió lớn, không ít hành khách lần đầu đi thuyền ra khơi đều thấy chóng mặt buồn nôn, không nhịn được mà nôn mửa liên tục.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a69a3278-0438-41ba-9349-c42f020a15a6'
);

-- [徒弟] (tú dì): đồ đệ, học trò
UPDATE public.vocabularies
SET example_hanzi = '这位工艺非凡的老木匠将毕生所悟的传统榫卯绝技，毫无保留地悉数传授给了年轻的徒弟。',
    example_pinyin = 'Zhè wèi gōngyì fēifán de lǎo mùjiàng jiāng bìshēng suǒ wù de chuántǒng sǔnmǎo juéjì, háowú-bǎoliú de xīshù chuánshòu gěi le niánqīng de túdì.',
    example_vi = 'Người thợ mộc già có tay nghề phi phàm đã đem tuyệt kỹ mộng gỗ truyền thống đúc kết cả đời truyền thụ trọn vẹn không hề giữ lại chút gì cho người đồ đệ trẻ.'
WHERE id = 'fd2ca17e-d4e3-4293-99a1-22fcc77c2582' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fd2ca17e-d4e3-4293-99a1-22fcc77c2582', '这位工艺非凡的老木匠将毕生所悟的传统榫卯绝技，毫无保留地悉数传授给了年轻的徒弟。', 'Zhè wèi gōngyì fēifán de lǎo mùjiàng jiāng bìshēng suǒ wù de chuántǒng sǔnmǎo juéjì, háowú-bǎoliú de xīshù chuánshòu gěi le niánqīng de túdì.', 'Người thợ mộc già có tay nghề phi phàm đã đem tuyệt kỹ mộng gỗ truyền thống đúc kết cả đời truyền thụ trọn vẹn không hề giữ lại chút gì cho người đồ đệ trẻ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fd2ca17e-d4e3-4293-99a1-22fcc77c2582'
);

-- [图案] (tú'àn): hoa văn, họa tiết
UPDATE public.vocabularies
SET example_hanzi = '这件出土的汉代精美丝绸织锦上，绣制着栩栩如生、寓意吉祥如意的精美传统云水图案。',
    example_pinyin = 'Zhè jiàn chūtǔ de hàndài jīngměi sīchóu zhījǐn shang, xiùzhì zhe xǔxǔ-rúshēng, yùyì jíxiáng-rúyì de jīngměi chuántǒng yúnshuǐ tú''àn.',
    example_vi = 'Trên mảnh thổ cẩm tơ lụa tinh xảo thời Hán được khai quật này có thêu họa tiết hoa văn mây nước truyền thống tinh mỹ, sống động như thật và ngụ ý cát tường như ý.'
WHERE id = '48258a42-79c3-4813-9a55-de9e3cdb0fa7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '48258a42-79c3-4813-9a55-de9e3cdb0fa7', '这件出土的汉代精美丝绸织锦上，绣制着栩栩如生、寓意吉祥如意的精美传统云水图案。', 'Zhè jiàn chūtǔ de hàndài jīngměi sīchóu zhījǐn shang, xiùzhì zhe xǔxǔ-rúshēng, yùyì jíxiáng-rúyì de jīngměi chuántǒng yúnshuǐ tú''àn.', 'Trên mảnh thổ cẩm tơ lụa tinh xảo thời Hán được khai quật này có thêu họa tiết hoa văn mây nước truyền thống tinh mỹ, sống động như thật và ngụ ý cát tường như ý.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '48258a42-79c3-4813-9a55-de9e3cdb0fa7'
);

-- [团结] (tuánjié): đoàn kết
UPDATE public.vocabularies
SET example_hanzi = '唯有全民族紧密团结一心，同甘共苦、守望相助，我们才能战胜前行道路上的一切艰难险阻。',
    example_pinyin = 'Wéiyǒu quán mínzú jǐnmì tuánjié yìxīn, tónggān-gòngkǔ, shǒuwàng-xiāngzhù, wǒmen cáinéng zhànshèng qiánxíng dàolù shang de yíqiè jiānnán-xiǎnzǔ.',
    example_vi = 'Chỉ khi toàn dân tộc đoàn kết chặt chẽ một lòng, đồng cam cộng khổ tương trợ đùm bọc lẫn nhau, chúng ta mới có thể chiến thắng mọi gian nan trắc trở trên con đường phía trước.'
WHERE id = '744cb41b-1573-4403-8dd1-652d5b729822' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '744cb41b-1573-4403-8dd1-652d5b729822', '唯有全民族紧密团结一心，同甘共苦、守望相助，我们才能战胜前行道路上的一切艰难险阻。', 'Wéiyǒu quán mínzú jǐnmì tuánjié yìxīn, tónggān-gòngkǔ, shǒuwàng-xiāngzhù, wǒmen cáinéng zhànshèng qiánxíng dàolù shang de yíqiè jiānnán-xiǎnzǔ.', 'Chỉ khi toàn dân tộc đoàn kết chặt chẽ một lòng, đồng cam cộng khổ tương trợ đùm bọc lẫn nhau, chúng ta mới có thể chiến thắng mọi gian nan trắc trở trên con đường phía trước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '744cb41b-1573-4403-8dd1-652d5b729822'
);

-- [团体] (tuántǐ): đoàn thể, tập thể
UPDATE public.vocabularies
SET example_hanzi = '来自数十个国家和地区的青年民间友好团体代表，在闭幕式上携手同台合唱友谊之歌。',
    example_pinyin = 'Láizì shùshí gè guójiā hé dìqū de qīngnián mínjiān yǒuhǎo tuántǐ dàibiǎo, zài bìmùshì shang xiéshǒu tóngtái héchàng yǒuyì zhī gē.',
    example_vi = 'Đại biểu các đoàn thể hữu nghị dân gian thanh niên đến từ hàng chục quốc gia và vùng lãnh thổ đã nắm tay nhau cùng lên sân khấu hòa vang khúc ca tình bạn trong lễ bế mạc.'
WHERE id = 'a6d912e4-b3d0-408a-813f-75539160b7c8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a6d912e4-b3d0-408a-813f-75539160b7c8', '来自数十个国家和地区的青年民间友好团体代表，在闭幕式上携手同台合唱友谊之歌。', 'Láizì shùshí gè guójiā hé dìqū de qīngnián mínjiān yǒuhǎo tuántǐ dàibiǎo, zài bìmùshì shang xiéshǒu tóngtái héchàng yǒuyì zhī gē.', 'Đại biểu các đoàn thể hữu nghị dân gian thanh niên đến từ hàng chục quốc gia và vùng lãnh thổ đã nắm tay nhau cùng lên sân khấu hòa vang khúc ca tình bạn trong lễ bế mạc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a6d912e4-b3d0-408a-813f-75539160b7c8'
);

-- [团圆] (tuányuán): đoàn viên, sum họp
UPDATE public.vocabularies
SET example_hanzi = '在万家灯火的除夕之夜，全家人围坐在一起吃热气腾腾的年夜饭，尽享天伦团圆的幸福温馨。',
    example_pinyin = 'Zài wànjiā dēnghuǒ de chúxī zhī yè, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de niányèfàn, jìnxiǎng tiānlún tuányuán de xìngfú wēnxīn.',
    example_vi = 'Trong đêm giao thừa muôn nhà rực sáng ánh đèn, cả gia đình quây quần bên nhau ăn bữa cơm tất niên nóng hổi, tận hưởng trọn vẹn sự ấm cúng hạnh phúc của cảnh đoàn viên sum họp.'
WHERE id = 'e3c975b8-e252-4770-a312-4bf315650ed8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e3c975b8-e252-4770-a312-4bf315650ed8', '在万家灯火的除夕之夜，全家人围坐在一起吃热气腾腾的年夜饭，尽享天伦团圆的幸福温馨。', 'Zài wànjiā dēnghuǒ de chúxī zhī yè, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de niányèfàn, jìnxiǎng tiānlún tuányuán de xìngfú wēnxīn.', 'Trong đêm giao thừa muôn nhà rực sáng ánh đèn, cả gia đình quây quần bên nhau ăn bữa cơm tất niên nóng hổi, tận hưởng trọn vẹn sự ấm cúng hạnh phúc của cảnh đoàn viên sum họp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e3c975b8-e252-4770-a312-4bf315650ed8'
);

-- [推测] (tuī cè): suy đoán, phỏng đoán
UPDATE public.vocabularies
SET example_hanzi = '考古学家根据古城遗址中发掘出的陶器与贝币纹理，推测该聚落可能起源于四千年前的新石器时代。',
    example_pinyin = 'Kǎogǔxuéjiā gēnjù gǔchéng yízhǐ zhōng fājué chū de táoqì yǔ bèibì wénlǐ, tuīcè gāi jùluò kěnéng qǐyuán yú sìqiān nián qián de xīnshíqì shídài.',
    example_vi = 'Các nhà khảo cổ căn cứ vào hoa văn đồ gốm và tiền vỏ sò khai quật được trong di chỉ thành cổ đã suy đoán rằng điểm tụ cư này có thể bắt nguồn từ thời kỳ đồ đá mới bốn ngàn năm trước.'
WHERE id = 'fabf91cd-cb2a-42a4-a5b8-fff0cf9d7d0c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fabf91cd-cb2a-42a4-a5b8-fff0cf9d7d0c', '考古学家根据古城遗址中发掘出的陶器与贝币纹理，推测该聚落可能起源于四千年前的新石器时代。', 'Kǎogǔxuéjiā gēnjù gǔchéng yízhǐ zhōng fājué chū de táoqì yǔ bèibì wénlǐ, tuīcè gāi jùluò kěnéng qǐyuán yú sìqiān nián qián de xīnshíqì shídài.', 'Các nhà khảo cổ căn cứ vào hoa văn đồ gốm và tiền vỏ sò khai quật được trong di chỉ thành cổ đã suy đoán rằng điểm tụ cư này có thể bắt nguồn từ thời kỳ đồ đá mới bốn ngàn năm trước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fabf91cd-cb2a-42a4-a5b8-fff0cf9d7d0c'
);

-- [推销] (tuī xiāo): tiếp thị, chào hàng
UPDATE public.vocabularies
SET example_hanzi = '这家初创公司派出多名干练的市场营销代表，在国际展会上积极向海外客户推销自主研发的新软件。',
    example_pinyin = 'Zhè jiā chūchuàng gōngsī pàichū duō míng gànliàn de shìchǎng yíngxiāo dàibiǎo, zài guójì zhǎnhuì shang jījí xiàng hǎiwài kèhù tuīxiāo zìzhǔ yánfā de xīn ruǎnjiàn.',
    example_vi = 'Công ty khởi nghiệp này đã cử nhiều đại diện tiếp thị thị trường tháo vát tích cực chào hàng phần mềm mới tự phát triển tới khách hàng hải ngoại tại hội chợ triển lãm quốc tế.'
WHERE id = 'b23ff246-9740-4e3e-b902-646d3a6bfaa7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b23ff246-9740-4e3e-b902-646d3a6bfaa7', '这家初创公司派出多名干练的市场营销代表，在国际展会上积极向海外客户推销自主研发的新软件。', 'Zhè jiā chūchuàng gōngsī pàichū duō míng gànliàn de shìchǎng yíngxiāo dàibiǎo, zài guójì zhǎnhuì shang jījí xiàng hǎiwài kèhù tuīxiāo zìzhǔ yánfā de xīn ruǎnjiàn.', 'Công ty khởi nghiệp này đã cử nhiều đại diện tiếp thị thị trường tháo vát tích cực chào hàng phần mềm mới tự phát triển tới khách hàng hải ngoại tại hội chợ triển lãm quốc tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b23ff246-9740-4e3e-b902-646d3a6bfaa7'
);

-- [途径] (tújìng): con đường, biện pháp
UPDATE public.vocabularies
SET example_hanzi = '通过发展高质量的职业教育与技能培训，是有效拓宽青年就业途径的重要举措。',
    example_pinyin = 'Tōngguò fāzhǎn gāo zhìliàng de zhíyè jiàoyù yǔ jìnéng péixùn, shì yǒuxiào tuòkuān qīngnián jiùyè tújìng de zhòngyào jǔcuò.',
    example_vi = 'Thông qua việc phát triển giáo dục nghề nghiệp và đào tạo kỹ năng chất lượng cao là biện pháp quan trọng nhằm mở rộng hữu hiệu con đường việc làm cho thanh niên.'
WHERE id = 'efe73951-5ff1-460e-be4f-d49a0655c04c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'efe73951-5ff1-460e-be4f-d49a0655c04c', '通过发展高质量的职业教育与技能培训，是有效拓宽青年就业途径的重要举措。', 'Tōngguò fāzhǎn gāo zhìliàng de zhíyè jiàoyù yǔ jìnéng péixùn, shì yǒuxiào tuòkuān qīngnián jiùyè tújìng de zhòngyào jǔcuò.', 'Thông qua việc phát triển giáo dục nghề nghiệp và đào tạo kỹ năng chất lượng cao là biện pháp quan trọng nhằm mở rộng hữu hiệu con đường việc làm cho thanh niên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'efe73951-5ff1-460e-be4f-d49a0655c04c'
);

-- [拖延] (tuōyán): trì hoãn, kéo dài thời gian
UPDATE public.vocabularies
SET example_hanzi = '遇到棘手的技术故障应当迎难而上、迅速处置，一味拖延只会让问题变得更加复杂棘手。',
    example_pinyin = 'Yù dào jíshǒu de jìshù gùzhàng yīngdāng yíngnán''érshàng, xùnsù chǔzhì, yíwèi tuōyán zhǐ huì ràng wèntí biànde gèngjiā fùzá jíshǒu.',
    example_vi = 'Gặp phải sự cố kỹ thuật hóc búa cần đương đầu xử lý nhanh chóng, mù quáng trì hoãn chỉ khiến vấn đề càng thêm phức tạp nan giải.'
WHERE id = '4855c3d7-4f09-429d-8e63-e3a2ca47d4e2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4855c3d7-4f09-429d-8e63-e3a2ca47d4e2', '遇到棘手的技术故障应当迎难而上、迅速处置，一味拖延只会让问题变得更加复杂棘手。', 'Yù dào jíshǒu de jìshù gùzhàng yīngdāng yíngnán''érshàng, xùnsù chǔzhì, yíwèi tuōyán zhǐ huì ràng wèntí biànde gèngjiā fùzá jíshǒu.', 'Gặp phải sự cố kỹ thuật hóc búa cần đương đầu xử lý nhanh chóng, mù quáng trì hoãn chỉ khiến vấn đề càng thêm phức tạp nan giải.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4855c3d7-4f09-429d-8e63-e3a2ca47d4e2'
);

-- [托运] (tuōyùn): ký gửi, gửi vận chuyển
UPDATE public.vocabularies
SET example_hanzi = '根据航空公司的严格安全规定，超重的大件旅行箱与危险液体必须在值机柜台办理托运。',
    example_pinyin = 'Gēnjù hángkōng gōngsī de yángé ānquán guīdìng, chāozhòng de dàjiàn lǚxíngxiāng yǔ wēixiǎn yètǐ bìxū zài zhíjī guìtái bànlǐ tuōyùn.',
    example_vi = 'Căn cứ theo quy định an toàn nghiêm ngặt của hãng hàng không, vali du lịch cỡ lớn quá cân và chất lỏng nguy hiểm bắt buộc phải làm thủ tục ký gửi tại quầy check-in.'
WHERE id = 'f6510cbb-716d-49af-91d9-0b7b10453c58' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f6510cbb-716d-49af-91d9-0b7b10453c58', '根据航空公司的严格安全规定，超重的大件旅行箱与危险液体必须在值机柜台办理托运。', 'Gēnjù hángkōng gōngsī de yángé ānquán guīdìng, chāozhòng de dàjiàn lǚxíngxiāng yǔ wēixiǎn yètǐ bìxū zài zhíjī guìtái bànlǐ tuōyùn.', 'Căn cứ theo quy định an toàn nghiêm ngặt của hãng hàng không, vali du lịch cỡ lớn quá cân và chất lỏng nguy hiểm bắt buộc phải làm thủ tục ký gửi tại quầy check-in.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f6510cbb-716d-49af-91d9-0b7b10453c58'
);

-- [突破] (tūpò): đột phá, chọc thủng
UPDATE public.vocabularies
SET example_hanzi = '科研团队经过历时五年的联合攻关，终于在量子计算核心芯片研发上取得了历史性重大突破。',
    example_pinyin = 'Kēyán tuánduì jīngguò lìshí wǔ nián de liánhé gōngguān, zhōngyú zài liàngzǐ jìsuàn héxīn xīnpìan yánfā shang qùdé le lìshǐxìng zhòngdà tūpò.',
    example_vi = 'Đội ngũ nghiên cứu khoa học sau năm năm phối hợp công phá cuối cùng đã giành được bước đột phá lịch sử trọng đại trong nghiên cứu phát triển chip cốt lõi điện toán lượng tử.'
WHERE id = '369849b0-a2bc-4c0a-8a1e-6f9ea1f4e1f8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '369849b0-a2bc-4c0a-8a1e-6f9ea1f4e1f8', '科研团队经过历时五年的联合攻关，终于在量子计算核心芯片研发上取得了历史性重大突破。', 'Kēyán tuánduì jīngguò lìshí wǔ nián de liánhé gōngguān, zhōngyú zài liàngzǐ jìsuàn héxīn xīnpìan yánfā shang qùdé le lìshǐxìng zhòngdà tūpò.', 'Đội ngũ nghiên cứu khoa học sau năm năm phối hợp công phá cuối cùng đã giành được bước đột phá lịch sử trọng đại trong nghiên cứu phát triển chip cốt lõi điện toán lượng tử.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '369849b0-a2bc-4c0a-8a1e-6f9ea1f4e1f8'
);

-- [土壤] (tǔrǎng): thổ nhưỡng, đất đai
UPDATE public.vocabularies
SET example_hanzi = '肥沃疏松且富含有机质的黑土地土壤，为当地农作物的丰收高产提供了得天独厚的优越条件。',
    example_pinyin = 'Féiwò shūsōng qiě fùhǒu yǒujīzhì de hēitǔdì tǔrǎng, wèi dāngdì nóngzuòwù de fēngshōu gāochǎn tígōng le détiāndúhòu de yōuyuè tiáojiàn.',
    example_vi = 'Thổ nhưỡng đất đen màu mỡ tơi xốp và giàu chất hữu cơ đã đem lại điều kiện ưu việt trời ban cho vụ mùa bội thu năng suất cao của cây trồng địa phương.'
WHERE id = 'ccc3ee61-6432-4720-9ad5-4d460b76dd6c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ccc3ee61-6432-4720-9ad5-4d460b76dd6c', '肥沃疏松且富含有机质的黑土地土壤，为当地农作物的丰收高产提供了得天独厚的优越条件。', 'Féiwò shūsōng qiě fùhǒu yǒujīzhì de hēitǔdì tǔrǎng, wèi dāngdì nóngzuòwù de fēngshōu gāochǎn tígōng le détiāndúhòu de yōuyuè tiáojiàn.', 'Thổ nhưỡng đất đen màu mỡ tơi xốp và giàu chất hữu cơ đã đem lại điều kiện ưu việt trời ban cho vụ mùa bội thu năng suất cao của cây trồng địa phương.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ccc3ee61-6432-4720-9ad5-4d460b76dd6c'
);

-- [哇] (wā): oa (khóc), chà (thán từ)
UPDATE public.vocabularies
SET example_hanzi = '当魔术师在万众瞩目下凭空变出一大束娇艳的红玫瑰时，台下的孩子们忍不住哇地一声惊呼起来。',
    example_pinyin = 'Dāng móshùshī zài wànzhòng zhǔmù xià píngkōng biàn chū yí dà shù jiāoyàn de hóng méiguī shí, táixià de háizi men rěnbuzhù wā de yì shēng jīnghū qǐlái.',
    example_vi = 'Khi ảo thuật gia biến ra một bó hoa hồng đỏ kiều diễm giữa không trung trước sự chú mục của vạn người, các em nhỏ dưới khán đài không kìm được mà òa lên một tiếng kinh ngạc.'
WHERE id = '21c5897c-7cfe-4170-8de3-fc79f2baa0a8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '21c5897c-7cfe-4170-8de3-fc79f2baa0a8', '当魔术师在万众瞩目下凭空变出一大束娇艳的红玫瑰时，台下的孩子们忍不住哇地一声惊呼起来。', 'Dāng móshùshī zài wànzhòng zhǔmù xià píngkōng biàn chū yí dà shù jiāoyàn de hóng méiguī shí, táixià de háizi men rěnbuzhù wā de yì shēng jīnghū qǐlái.', 'Khi ảo thuật gia biến ra một bó hoa hồng đỏ kiều diễm giữa không trung trước sự chú mục của vạn người, các em nhỏ dưới khán đài không kìm được mà òa lên một tiếng kinh ngạc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '21c5897c-7cfe-4170-8de3-fc79f2baa0a8'
);

-- [歪] (wāi): nghiêng, lệch
UPDATE public.vocabularies
SET example_hanzi = '那张挂在客厅主墙上的名贵水墨山水画稍微有点挂歪了，他走上前去小心翼翼地扶正。',
    example_pinyin = 'Nà zhāng guà zài kètīng zhǔ qiáng shang de míngguì shuǐmò shānshuǐhuà shāowēi yǒudiǎn guà wāi le, tā zǒu shàngqián qù xiǎoxīn-yìyì de fúzhèng.',
    example_vi = 'Bức tranh sơn thủy thủy mặc quý giá treo trên bức tường chính phòng khách hơi bị lệch một chút, anh bước tới cẩn thận từng li từng tí chỉnh lại cho ngay ngắn.'
WHERE id = '16380856-6eeb-4630-bd14-a61029aa0639' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '16380856-6eeb-4630-bd14-a61029aa0639', '那张挂在客厅主墙上的名贵水墨山水画稍微有点挂歪了，他走上前去小心翼翼地扶正。', 'Nà zhāng guà zài kètīng zhǔ qiáng shang de míngguì shuǐmò shānshuǐhuà shāowēi yǒudiǎn guà wāi le, tā zǒu shàngqián qù xiǎoxīn-yìyì de fúzhèng.', 'Bức tranh sơn thủy thủy mặc quý giá treo trên bức tường chính phòng khách hơi bị lệch một chút, anh bước tới cẩn thận từng li từng tí chỉnh lại cho ngay ngắn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '16380856-6eeb-4630-bd14-a61029aa0639'
);

-- [外表] (wàibiǎo): bề ngoài, diện mạo
UPDATE public.vocabularies
SET example_hanzi = '评价一个人的品格应当看其内在修养与实际担当，切不可仅凭光鲜亮丽的外表以貌取人。',
    example_pinyin = 'Píngjià yí gè rén de pǐngé yīngdāng kàn qí nèizài xiūyǎng yǔ shíjì dāndāng, qiè bùkě jǐn píng guāngxiān-liànglì de wàibiǎo yǐmào-qǔrén.',
    example_vi = 'Đánh giá phẩm cách của một con người cần nhìn vào tu dưỡng nội tâm và sự gánh vác thực tế của họ, tuyệt đối chớ chỉ dựa vào vẻ ngoài bảnh bao sáng láng mà trông mặt bắt hình dong.'
WHERE id = '3d6a9ad7-5b8b-4403-a36c-447bc176204d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3d6a9ad7-5b8b-4403-a36c-447bc176204d', '评价一个人的品格应当看其内在修养与实际担当，切不可仅凭光鲜亮丽的外表以貌取人。', 'Píngjià yí gè rén de pǐngé yīngdāng kàn qí nèizài xiūyǎng yǔ shíjì dāndāng, qiè bùkě jǐn píng guāngxiān-liànglì de wàibiǎo yǐmào-qǔrén.', 'Đánh giá phẩm cách của một con người cần nhìn vào tu dưỡng nội tâm và sự gánh vác thực tế của họ, tuyệt đối chớ chỉ dựa vào vẻ ngoài bảnh bao sáng láng mà trông mặt bắt hình dong.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3d6a9ad7-5b8b-4403-a36c-447bc176204d'
);

-- [外交] (wàijiāo): ngoại giao
UPDATE public.vocabularies
SET example_hanzi = '两国元首在本次高级别双边会晤中，就深化和平共处的外交关系达成了高度共识。',
    example_pinyin = 'Liǎng guó yuánshǒu zài běncì gāo jíbié shuāngbiān huìwù zhōng, jiù shēnhuà hépíng gòngchǔ de wàijiāo guānxì dáchéng le gāodù gòngshí.',
    example_vi = 'Nguyên thủ hai nước trong cuộc hội đàm song phương cấp cao lần này đã đạt được đồng thuận cao về việc làm sâu sắc mối quan hệ ngoại giao cùng chung sống hòa bình.'
WHERE id = '83bb70cb-41d3-48cc-b9ea-c0f9754a6481' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '83bb70cb-41d3-48cc-b9ea-c0f9754a6481', '两国元首在本次高级别双边会晤中，就深化和平共处的外交关系达成了高度共识。', 'Liǎng guó yuánshǒu zài běncì gāo jíbié shuāngbiān huìwù zhōng, jiù shēnhuà hépíng gòngchǔ de wàijiāo guānxì dáchéng le gāodù gòngshí.', 'Nguyên thủ hai nước trong cuộc hội đàm song phương cấp cao lần này đã đạt được đồng thuận cao về việc làm sâu sắc mối quan hệ ngoại giao cùng chung sống hòa bình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '83bb70cb-41d3-48cc-b9ea-c0f9754a6481'
);

-- [外界] (wàijiè): thế giới bên ngoài
UPDATE public.vocabularies
SET example_hanzi = '尽管面临着外界各种纷繁舆论的巨大压力，他依然坚定不移地坚守着自己的科研初心。',
    example_pinyin = 'Jǐnguǎn miànlín zhe wàijiè gè zhǒng fēnfán yúlùn de jùdà yālì, tā yīrán jiāndìng-bùyí de jiānshǒu zhe zìjǐ de kēyán chūxīn.',
    example_vi = 'Mặc dù phải đối mặt với áp lực to lớn từ đủ mọi luồng dư luận bề bộn của thế giới bên ngoài, ông vẫn kiên định không dời giữ vững tâm nguyện ban đầu với nghiên cứu khoa học.'
WHERE id = 'e880e557-0e75-4d5d-92f1-f68a7c23ac23' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e880e557-0e75-4d5d-92f1-f68a7c23ac23', '尽管面临着外界各种纷繁舆论的巨大压力，他依然坚定不移地坚守着自己的科研初心。', 'Jǐnguǎn miànlín zhe wàijiè gè zhǒng fēnfán yúlùn de jùdà yālì, tā yīrán jiāndìng-bùyí de jiānshǒu zhe zìjǐ de kēyán chūxīn.', 'Mặc dù phải đối mặt với áp lực to lớn từ đủ mọi luồng dư luận bề bộn của thế giới bên ngoài, ông vẫn kiên định không dời giữ vững tâm nguyện ban đầu với nghiên cứu khoa học.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e880e557-0e75-4d5d-92f1-f68a7c23ac23'
);

-- [王子] (wángzǐ): hoàng tử
UPDATE public.vocabularies
SET example_hanzi = '在经典的童话寓言传说中，英勇无畏的王子历经重重险阻最终战胜了恶龙。',
    example_pinyin = 'Zài jīngdiǎn de tónghuà yùyán chuánshuō zhōng, yīngyǒng-wúwèi de wángzǐ lìjīng chóngchóng xiǎnzǔ zuìzhōng zhànshèng le èlóng.',
    example_vi = 'Trong những câu chuyện ngụ ngôn cổ tích kinh điển, chàng hoàng tử dũng cảm không sợ hãi đã trải qua muôn trùng hiểm trở cuối cùng chiến thắng con rồng ác.'
WHERE id = 'f201a265-7105-41eb-a753-f7e184ce8998' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f201a265-7105-41eb-a753-f7e184ce8998', '在经典的童话寓言传说中，英勇无畏的王子历经重重险阻最终战胜了恶龙。', 'Zài jīngdiǎn de tónghuà yùyán chuánshuō zhōng, yīngyǒng-wúwèi de wángzǐ lìjīng chóngchóng xiǎnzǔ zuìzhōng zhànshèng le èlóng.', 'Trong những câu chuyện ngụ ngôn cổ tích kinh điển, chàng hoàng tử dũng cảm không sợ hãi đã trải qua muôn trùng hiểm trở cuối cùng chiến thắng con rồng ác.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f201a265-7105-41eb-a753-f7e184ce8998'
);

-- [顽强] (wánqiáng): kiên cường, ngoan cường
UPDATE public.vocabularies
SET example_hanzi = '身患残疾的运动员凭借着顽强不屈的坚毅毅力，在残奥会赛场上奋力拼搏并荣获金牌。',
    example_pinyin = 'Shēnhuàn cánjí de yùndòngyuán píngjiè zhe wánqiáng-bùqū de jiānyì yìlì, zài cán''àohuì sàichǎng shang fènlì pīnbó bìng rónghuò jīnpái.',
    example_vi = 'Vận động viên khuyết tật dựa vào nghị lực kiên định ngoan cường bất khuất đã dốc sức chiến đấu trên đấu trường Paralympic và vinh dự đoạt huy chương vàng.'
WHERE id = '8b3ecbe2-1480-40d9-99bc-911ee0bba3e8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8b3ecbe2-1480-40d9-99bc-911ee0bba3e8', '身患残疾的运动员凭借着顽强不屈的坚毅毅力，在残奥会赛场上奋力拼搏并荣获金牌。', 'Shēnhuàn cánjí de yùndòngyuán píngjiè zhe wánqiáng-bùqū de jiānyì yìlì, zài cán''àohuì sàichǎng shang fènlì pīnbó bìng rónghuò jīnpái.', 'Vận động viên khuyết tật dựa vào nghị lực kiên định ngoan cường bất khuất đã dốc sức chiến đấu trên đấu trường Paralympic và vinh dự đoạt huy chương vàng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8b3ecbe2-1480-40d9-99bc-911ee0bba3e8'
);

-- [娃娃] (wáwa): em bé, búp bê
UPDATE public.vocabularies
SET example_hanzi = '那个做工精巧、身穿民族传统华丽服饰的陶瓷洋娃娃，是小女孩童年最珍爱的玩伴。',
    example_pinyin = 'Nà gè zuògōng jīngqiǎo, shēn chuān mínzú chuántǒng huálì fúshì de táocí yángwáwa, shì xiǎo nǚhái tóngnián zuì zhēn''ài de wánbàn.',
    example_vi = 'Búp bê bằng gốm sứ được gia công tinh xảo, khoác trên mình bộ trang phục truyền thống dân tộc lộng lẫy ấy là người bạn chơi được cô bé nâng niu nhất thời thơ ấu.'
WHERE id = '958354aa-5b5c-4d81-b2f6-1f983572a303' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '958354aa-5b5c-4d81-b2f6-1f983572a303', '那个做工精巧、身穿民族传统华丽服饰的陶瓷洋娃娃，是小女孩童年最珍爱的玩伴。', 'Nà gè zuògōng jīngqiǎo, shēn chuān mínzú chuántǒng huálì fúshì de táocí yángwáwa, shì xiǎo nǚhái tóngnián zuì zhēn''ài de wánbàn.', 'Búp bê bằng gốm sứ được gia công tinh xảo, khoác trên mình bộ trang phục truyền thống dân tộc lộng lẫy ấy là người bạn chơi được cô bé nâng niu nhất thời thơ ấu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '958354aa-5b5c-4d81-b2f6-1f983572a303'
);

-- [维护] (wéi hù): bảo vệ, giữ gìn
UPDATE public.vocabularies
SET example_hanzi = '依法坚决维护国家主权、领土完整与核心发展利益，是全体中华儿女的共同神圣职责。',
    example_pinyin = 'Yīfǎ jiānjué wéihù guójiā zhǔquán, lǐngtǔ wánzhěng yǔ héxīn fāzhǎn lìyì, shì quántǐ zhōnghuá érnǚ de gòngtóng shénshèng zhízé.',
    example_vi = 'Kiên quyết bảo vệ chủ quyền quốc gia, toàn vẹn lãnh thổ và lợi ích phát triển cốt lõi theo đúng pháp luật là trách nhiệm thiêng liêng chung của toàn thể con dân đất nước.'
WHERE id = '71507b58-425a-494f-aa98-3f71e05aa577' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '71507b58-425a-494f-aa98-3f71e05aa577', '依法坚决维护国家主权、领土完整与核心发展利益，是全体中华儿女的共同神圣职责。', 'Yīfǎ jiānjué wéihù guójiā zhǔquán, lǐngtǔ wánzhěng yǔ héxīn fāzhǎn lìyì, shì quántǐ zhōnghuá érnǚ de gòngtóng shénshèng zhízé.', 'Kiên quyết bảo vệ chủ quyền quốc gia, toàn vẹn lãnh thổ và lợi ích phát triển cốt lõi theo đúng pháp luật là trách nhiệm thiêng liêng chung của toàn thể con dân đất nước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '71507b58-425a-494f-aa98-3f71e05aa577'
);

-- [为难] (wéi nán): khó xử, làm khó
UPDATE public.vocabularies
SET example_hanzi = '面对多年老友提出的违规借款要求，身为公职人员的他感到十分为难与纠结。',
    example_pinyin = 'Miànduì duōnián lǎoyǒu tíchū de wéiguī jièkuǎn yāoqiú, shēnwéi gōngzhí rényuán de tā gǎndào shífēn wéinán yǔ jiūjié.',
    example_vi = 'Đối mặt với yêu cầu vay tiền trái quy định do người bạn lâu năm đưa ra, với tư cách là người làm việc công vụ anh cảm thấy vô cùng khó xử và giằng xé.'
WHERE id = '848778c4-e112-47c9-a4b6-21b40fdc0cf7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '848778c4-e112-47c9-a4b6-21b40fdc0cf7', '面对多年老友提出的违规借款要求，身为公职人员的他感到十分为难与纠结。', 'Miànduì duōnián lǎoyǒu tíchū de wéiguī jièkuǎn yāoqiú, shēnwéi gōngzhí rényuán de tā gǎndào shífēn wéinán yǔ jiūjié.', 'Đối mặt với yêu cầu vay tiền trái quy định do người bạn lâu năm đưa ra, với tư cách là người làm việc công vụ anh cảm thấy vô cùng khó xử và giằng xé.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '848778c4-e112-47c9-a4b6-21b40fdc0cf7'
);

-- [为期] (wéi qī): có thời hạn là, kỳ hạn
UPDATE public.vocabularies
SET example_hanzi = '来自全球各地的青年学术骨干齐聚一堂，参加为期两周的前沿人工智能高级研修营。',
    example_pinyin = 'Láizì quánqiú gèdì de quánxīn xuéshù gǔgàn qíjù yìtáng, cānjiā wéiqī liǎng zhōu de qiányán réngōng zhìnéng gāojí yánxiūyíng.',
    example_vi = 'Các cán bộ học thuật nòng cốt trẻ tuổi từ khắp nơi trên toàn cầu đã hội tụ, tham gia trại nghiên cứu tu nghiệp cao cấp về trí tuệ nhân tạo đi đầu có thời hạn là hai tuần.'
WHERE id = '6face3f1-f6f6-4655-83e9-6b5d50767bb3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6face3f1-f6f6-4655-83e9-6b5d50767bb3', '来自全球各地的青年学术骨干齐聚一堂，参加为期两周的前沿人工智能高级研修营。', 'Láizì quánqiú gèdì de quánxīn xuéshù gǔgàn qíjù yìtáng, cānjiā wéiqī liǎng zhōu de qiányán réngōng zhìnéng gāojí yánxiūyíng.', 'Các cán bộ học thuật nòng cốt trẻ tuổi từ khắp nơi trên toàn cầu đã hội tụ, tham gia trại nghiên cứu tu nghiệp cao cấp về trí tuệ nhân tạo đi đầu có thời hạn là hai tuần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6face3f1-f6f6-4655-83e9-6b5d50767bb3'
);

-- [维生素] (wéi shēng sù): vitamin
UPDATE public.vocabularies
SET example_hanzi = '营养学专家建议广大上班族每日多摄入新鲜水果与绿叶蔬菜，以充分补充身体所需的维生素。',
    example_pinyin = 'Yíngyǎngxué zhuānjiā jiànyì guǎngdà shàngbānzú měirì duō shèrù xīnxiān shuǐguǒ yǔ lǜyè shūcài, yǐ chōngfèn bǔchōng shēntǐ suǒ xū de wéishēngsù.',
    example_vi = 'Chuyên gia dinh dưỡng khuyên đông đảo dân văn phòng mỗi ngày nên nạp nhiều hoa quả tươi và rau lá xanh để bổ sung đầy đủ vitamin cần thiết cho cơ thể.'
WHERE id = 'b732fbf9-75a5-447e-8c1a-bd89c4c47118' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b732fbf9-75a5-447e-8c1a-bd89c4c47118', '营养学专家建议广大上班族每日多摄入新鲜水果与绿叶蔬菜，以充分补充身体所需的维生素。', 'Yíngyǎngxué zhuānjiā jiànyì guǎngdà shàngbānzú měirì duō shèrù xīnxiān shuǐguǒ yǔ lǜyè shūcài, yǐ chōngfèn bǔchōng shēntǐ suǒ xū de wéishēngsù.', 'Chuyên gia dinh dưỡng khuyên đông đảo dân văn phòng mỗi ngày nên nạp nhiều hoa quả tươi và rau lá xanh để bổ sung đầy đủ vitamin cần thiết cho cơ thể.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b732fbf9-75a5-447e-8c1a-bd89c4c47118'
);

-- [未必] (wèibì): chưa chắc, chưa hẳn
UPDATE public.vocabularies
SET example_hanzi = '市场上售价最昂贵奢华的商品，其质量和使用体验未必就一定全面优于同类大众品牌。',
    example_pinyin = 'Shìchǎng shang shòujià zuì ángguì shēhuá de shāngpǐn, qí zhìliàng hé shǐyòng tǐyàn wèibì jiù yídìng quánmiàn yōuyú tónglèi dàzhòng pǐnpái.',
    example_vi = 'Sản phẩm có giá bán đắt đỏ xa xỉ nhất trên thị trường thì chất lượng và trải nghiệm sử dụng chưa hẳn đã hoàn toàn vượt trội hơn các thương hiệu đại chúng cùng loại.'
WHERE id = '2bc4f161-c7cb-421f-9102-cc38394ec069' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2bc4f161-c7cb-421f-9102-cc38394ec069', '市场上售价最昂贵奢华的商品，其质量和使用体验未必就一定全面优于同类大众品牌。', 'Shìchǎng shang shòujià zuì ángguì shēhuá de shāngpǐn, qí zhìliàng hé shǐyòng tǐyàn wèibì jiù yídìng quánmiàn yōuyú tónglèi dàzhòng pǐnpái.', 'Sản phẩm có giá bán đắt đỏ xa xỉ nhất trên thị trường thì chất lượng và trải nghiệm sử dụng chưa hẳn đã hoàn toàn vượt trội hơn các thương hiệu đại chúng cùng loại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2bc4f161-c7cb-421f-9102-cc38394ec069'
);

-- [危机] (wēijī): khủng hoảng, nguy cơ
UPDATE public.vocabularies
SET example_hanzi = '优秀的现代企业家应当具备极强的忧患防范意识，善于在潜在危机来临前化被动为主动。',
    example_pinyin = 'Yōuxiù de xiàndài qǐyèjiā yīngdāng jùbèi jíqiáng de yōuhuàn fángfàn yìshí, shànyú zài qiánzài wēijī láilín qián huà bèidòng wéi zhǔdòng.',
    example_vi = 'Doanh nhân hiện đại ưu tú cần phải có ý thức phòng ngừa lo toan cực kỳ nhạy bén, giỏi biến bị động thành chủ động trước khi nguy cơ tiềm ẩn ập đến.'
WHERE id = '8a7aa631-5f34-46eb-9139-ff23c23f7f1e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8a7aa631-5f34-46eb-9139-ff23c23f7f1e', '优秀的现代企业家应当具备极强的忧患防范意识，善于在潜在危机来临前化被动为主动。', 'Yōuxiù de xiàndài qǐyèjiā yīngdāng jùbèi jíqiáng de yōuhuàn fángfàn yìshí, shànyú zài qiánzài wēijī láilín qián huà bèidòng wéi zhǔdòng.', 'Doanh nhân hiện đại ưu tú cần phải có ý thức phòng ngừa lo toan cực kỳ nhạy bén, giỏi biến bị động thành chủ động trước khi nguy cơ tiềm ẩn ập đến.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8a7aa631-5f34-46eb-9139-ff23c23f7f1e'
);

-- [胃口] (wèikǒu): khẩu vị, sự thèm ăn
UPDATE public.vocabularies
SET example_hanzi = '经过连续几个小时的高强度徒步跋涉，面对香气四溢的农家土菜，大家的胃口格外好。',
    example_pinyin = 'Jīngguò liánxù jǐ gè xiǎoshí de gāo qiángdù túbù báshè, miànduì xiāngqì-sìyì de nóngjiā tǔcài, dàjiā de wèikǒu géwài hǎo.',
    example_vi = 'Sau nhiều giờ liền cuốc bộ dã ngoại cường độ cao, đối diện với những món ăn đồng quê thơm nức mũi, khẩu vị của mọi người vô cùng ngon miệng.'
WHERE id = 'c6a6f84e-e868-4855-9d79-6fd3a58820f5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c6a6f84e-e868-4855-9d79-6fd3a58820f5', '经过连续几个小时的高强度徒步跋涉，面对香气四溢的农家土菜，大家的胃口格外好。', 'Jīngguò liánxù jǐ gè xiǎoshí de gāo qiángdù túbù báshè, miànduì xiāngqì-sìyì de nóngjiā tǔcài, dàjiā de wèikǒu géwài hǎo.', 'Sau nhiều giờ liền cuốc bộ dã ngoại cường độ cao, đối diện với những món ăn đồng quê thơm nức mũi, khẩu vị của mọi người vô cùng ngon miệng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c6a6f84e-e868-4855-9d79-6fd3a58820f5'
);

-- [委屈] (wěiqu): oan ức, tủi thân
UPDATE public.vocabularies
SET example_hanzi = '明明是按规程认真履职却无端遭到了客户的严厉斥责，年轻的客服姑娘忍不住委屈地落泪。',
    example_pinyin = 'Míngmíng shì àn guīchéng rènzhēn lǚzhí què wūduān zāodào le kèhù de yánlì chìzé, niánqīng de kèfú gūniang rěnbuzhù wěiqu de luòlèi.',
    example_vi = 'Rõ ràng là làm đúng quy trình chức trách mà lại vô cớ bị khách hàng mắng mỏ gay gắt, cô gái nhân viên chăm sóc khách hàng trẻ tuổi không kìm được mà tủi thân rơi nước mắt.'
WHERE id = '4f561f05-6e09-4950-b50b-56d0dacdfb50' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4f561f05-6e09-4950-b50b-56d0dacdfb50', '明明是按规程认真履职却无端遭到了客户的严厉斥责，年轻的客服姑娘忍不住委屈地落泪。', 'Míngmíng shì àn guīchéng rènzhēn lǚzhí què wūduān zāodào le kèhù de yánlì chìzé, niánqīng de kèfú gūniang rěnbuzhù wěiqu de luòlèi.', 'Rõ ràng là làm đúng quy trình chức trách mà lại vô cớ bị khách hàng mắng mỏ gay gắt, cô gái nhân viên chăm sóc khách hàng trẻ tuổi không kìm được mà tủi thân rơi nước mắt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4f561f05-6e09-4950-b50b-56d0dacdfb50'
);

-- [委托] (wěituō): ủy thác, nhờ cậy
UPDATE public.vocabularies
SET example_hanzi = '董事会全票表决通过，正式委托这家国际知名会计师事务所对本年度财务报表进行独立审计。',
    example_pinyin = 'Dǒngshìhuì quánpiào biǎojué tōngguò, zhèngshì wěituō zhè jiā guójì zhīmíng kuàijìshī shìwùsuǒ duì běn niándù cáiwù bàobiǎo jìnxíng dúlì shěnjì.',
    example_vi = 'Hội đồng quản trị đã bỏ phiếu toàn thuận thông qua việc chính thức ủy thác cho công ty kiểm toán danh tiếng quốc tế này tiến hành kiểm toán độc lập báo cáo tài chính năm nay.'
WHERE id = 'a67b6807-fae8-4856-89c1-de886e36c2f5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a67b6807-fae8-4856-89c1-de886e36c2f5', '董事会全票表决通过，正式委托这家国际知名会计师事务所对本年度财务报表进行独立审计。', 'Dǒngshìhuì quánpiào biǎojué tōngguò, zhèngshì wěituō zhè jiā guójì zhīmíng kuàijìshī shìwùsuǒ duì běn niándù cáiwù bàobiǎo jìnxíng dúlì shěnjì.', 'Hội đồng quản trị đã bỏ phiếu toàn thuận thông qua việc chính thức ủy thác cho công ty kiểm toán danh tiếng quốc tế này tiến hành kiểm toán độc lập báo cáo tài chính năm nay.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a67b6807-fae8-4856-89c1-de886e36c2f5'
);

-- [温和] (wēnhé): ôn hòa, dịu dàng
UPDATE public.vocabularies
SET example_hanzi = '这位资深心理咨询专家在与焦虑来访者交流沟通时，语调始终保持得极其平缓而温和。',
    example_pinyin = 'Zhè wèi zīshēn xīnlǐ zīxún zhuānjiā zài yǔ jiāolǜ láifǎngzhě jiāoliú gōutōng shí, yǔdiào shǐzhōng bǎochí de jíqí pínghuǎn ér wēnhé.',
    example_vi = 'Vị chuyên gia tư vấn tâm lý thâm niên này khi giao lưu trò chuyện với người tìm đến đang lo âu thì ngữ điệu luôn giữ được sự êm ả và ôn hòa tột cùng.'
WHERE id = 'abffaa19-6f8a-4f1b-85c3-5c55f0000e73' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'abffaa19-6f8a-4f1b-85c3-5c55f0000e73', '这位资深心理咨询专家在与焦虑来访者交流沟通时，语调始终保持得极其平缓而温和。', 'Zhè wèi zīshēn xīnlǐ zīxún zhuānjiā zài yǔ jiāolǜ láifǎngzhě jiāoliú gōutōng shí, yǔdiào shǐzhōng bǎochí de jíqí pínghuǎn ér wēnhé.', 'Vị chuyên gia tư vấn tâm lý thâm niên này khi giao lưu trò chuyện với người tìm đến đang lo âu thì ngữ điệu luôn giữ được sự êm ả và ôn hòa tột cùng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'abffaa19-6f8a-4f1b-85c3-5c55f0000e73'
);

-- [文具] (wénjù): văn phòng phẩm
UPDATE public.vocabularies
SET example_hanzi = '每到开学季即将来临之际，各大商场文具专区的各类笔记本、钢笔和彩铅总是供不应求。',
    example_pinyin = 'Měi dào kāixuéjì jíjiāng láilín zhījì, gè dà shāngchǎng wénjù zhuānqū de gè lèi bǐjìběn, gāngbǐ hé cǎiqiān zǒngshì gōng-bù-yìng-qiú.',
    example_vi = 'Mỗi dịp mùa tựu trường sắp tới, các loại sổ tay, bút mực và bút chì màu tại khu chuyên doanh văn phòng phẩm ở các trung tâm mua sắm lớn luôn trong tình trạng cung không đủ cầu.'
WHERE id = '56291c28-8c3b-42bf-93fd-258300f06db7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '56291c28-8c3b-42bf-93fd-258300f06db7', '每到开学季即将来临之际，各大商场文具专区的各类笔记本、钢笔和彩铅总是供不应求。', 'Měi dào kāixuéjì jíjiāng láilín zhījì, gè dà shāngchǎng wénjù zhuānqū de gè lèi bǐjìběn, gāngbǐ hé cǎiqiān zǒngshì gōng-bù-yìng-qiú.', 'Mỗi dịp mùa tựu trường sắp tới, các loại sổ tay, bút mực và bút chì màu tại khu chuyên doanh văn phòng phẩm ở các trung tâm mua sắm lớn luôn trong tình trạng cung không đủ cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '56291c28-8c3b-42bf-93fd-258300f06db7'
);

-- [文明] (wénmíng): văn minh
UPDATE public.vocabularies
SET example_hanzi = '中华五千年悠久灿烂的古老文明生生不息，为整个人类精神文化宝库贡献了永恒智慧。',
    example_pinyin = 'Zhōnghuá wǔ qiān nián yōujiǔ cànlàn de gǔlǎo wénmíng shēngshēng-bùxī, wèi zhěnggè rénlèi jīngshén wénhuà bǎokù gòngxiàn le yǒnghéng zhìhuì.',
    example_vi = 'Nền văn minh cổ xưa rực rỡ lâu đời năm ngàn năm của Trung Hoa trường tồn sinh sôi nảy nở, đóng góp trí tuệ vĩnh cửu cho kho tàng văn hóa tinh thần của toàn nhân loại.'
WHERE id = '3fad96c3-efff-428c-ae3a-ea073e3f0b20' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3fad96c3-efff-428c-ae3a-ea073e3f0b20', '中华五千年悠久灿烂的古老文明生生不息，为整个人类精神文化宝库贡献了永恒智慧。', 'Zhōnghuá wǔ qiān nián yōujiǔ cànlàn de gǔlǎo wénmíng shēngshēng-bùxī, wèi zhěnggè rénlèi jīngshén wénhuà bǎokù gòngxiàn le yǒnghéng zhìhuì.', 'Nền văn minh cổ xưa rực rỡ lâu đời năm ngàn năm của Trung Hoa trường tồn sinh sôi nảy nở, đóng góp trí tuệ vĩnh cửu cho kho tàng văn hóa tinh thần của toàn nhân loại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3fad96c3-efff-428c-ae3a-ea073e3f0b20'
);

-- [温柔] (wēnróu): dịu dàng
UPDATE public.vocabularies
SET example_hanzi = '在摇曳温暖的床头橘黄色灯光下，母亲用极其温柔深情的声调为入睡的孩子读童话。',
    example_pinyin = 'Zài yáoyè wēnnuǎn de chuángtóu júhuángsè dēngguāng xià, mǔqīn yòng jíqí wēnróu shēnqíng de shēngdiào wèi rùshuì de háizi dú tónghuà.',
    example_vi = 'Dưới ánh đèn vàng cam ấm áp đầu giường chập chờn, người mẹ dùng giọng điệu cực kỳ dịu dàng đằm thắm đọc truyện cổ tích cho đứa con đang đi vào giấc ngủ.'
WHERE id = '4aaebff9-abae-46a1-9975-8ff59912d38a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4aaebff9-abae-46a1-9975-8ff59912d38a', '在摇曳温暖的床头橘黄色灯光下，母亲用极其温柔深情的声调为入睡的孩子读童话。', 'Zài yáoyè wēnnuǎn de chuángtóu júhuángsè dēngguāng xià, mǔqīn yòng jíqí wēnróu shēnqíng de shēngdiào wèi rùshuì de háizi dú tónghuà.', 'Dưới ánh đèn vàng cam ấm áp đầu giường chập chờn, người mẹ dùng giọng điệu cực kỳ dịu dàng đằm thắm đọc truyện cổ tích cho đứa con đang đi vào giấc ngủ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4aaebff9-abae-46a1-9975-8ff59912d38a'
);

-- [文物] (wénwù): di vật, cổ vật
UPDATE public.vocabularies
SET example_hanzi = '考古队在秦汉大型宫殿遗址的核心区域，抢救性发掘保护了数百件价值连城的珍贵国家级文物。',
    example_pinyin = 'Kǎogǔduì zài qín-hàn dàxíng gōngdiàn yízhǐ de héxīn qūyù, qiǎngjiùxìng fājué bǎohù le shù bǎi jiàn jiàzhí-liánchéng de zhēnguì guójiājí wénwù.',
    example_vi = 'Đội khảo cổ tại khu vực cốt lõi của di chỉ cung điện lớn thời Tần Hán đã khai quật bảo tồn cứu hộ hàng trăm món di vật cổ vật cấp quốc gia quý giá vô ngần.'
WHERE id = 'c43e5df9-97a3-418a-8382-a6ca5800de3a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c43e5df9-97a3-418a-8382-a6ca5800de3a', '考古队在秦汉大型宫殿遗址的核心区域，抢救性发掘保护了数百件价值连城的珍贵国家级文物。', 'Kǎogǔduì zài qín-hàn dàxíng gōngdiàn yízhǐ de héxīn qūyù, qiǎngjiùxìng fājué bǎohù le shù bǎi jiàn jiàzhí-liánchéng de zhēnguì guójiājí wénwù.', 'Đội khảo cổ tại khu vực cốt lõi của di chỉ cung điện lớn thời Tần Hán đã khai quật bảo tồn cứu hộ hàng trăm món di vật cổ vật cấp quốc gia quý giá vô ngần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c43e5df9-97a3-418a-8382-a6ca5800de3a'
);

-- [文献] (wénxiàn): văn kiện, tài liệu tham khảo
UPDATE public.vocabularies
SET example_hanzi = '青年学者在撰写高水平学术博士论文前，必须花费数月时间广泛查阅海内外前沿文献。',
    example_pinyin = 'Qīngnián xuézhě zài zhuànxiě gāo shuǐpíng xuéshù bóshì lùnwén qián, bìxū huāfèi shù yuè shíjiān guǎngfàn cháyuè hǎinèiwài qiányán wénxiàn.',
    example_vi = 'Các học giả trẻ trước khi chấp bút luận án tiến sĩ học thuật trình độ cao bắt buộc phải bỏ ra nhiều tháng trời tra cứu sâu rộng tài liệu văn kiện đi đầu trong và ngoài nước.'
WHERE id = 'e5ed9a57-f52d-44a4-ae5d-386f88714539' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e5ed9a57-f52d-44a4-ae5d-386f88714539', '青年学者在撰写高水平学术博士论文前，必须花费数月时间广泛查阅海内外前沿文献。', 'Qīngnián xuézhě zài zhuànxiě gāo shuǐpíng xuéshù bóshì lùnwén qián, bìxū huāfèi shù yuè shíjiān guǎngfàn cháyuè hǎinèiwài qiányán wénxiàn.', 'Các học giả trẻ trước khi chấp bút luận án tiến sĩ học thuật trình độ cao bắt buộc phải bỏ ra nhiều tháng trời tra cứu sâu rộng tài liệu văn kiện đi đầu trong và ngoài nước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e5ed9a57-f52d-44a4-ae5d-386f88714539'
);

-- [文艺] (wényì): văn nghệ
UPDATE public.vocabularies
SET example_hanzi = '每逢重大传统节日庆典，市民中心都会举办精彩纷呈的群众性大型文艺汇演与巡游活动。',
    example_pinyin = 'Měi féng zhòngdà chuántǒng jiérì qìngdiǎn, shìmín zhōngxīn dōu huì jǔbàn jīngcǎi-fēncéng de qúnzhòngxìng dàxíng wényì huìyǎn yǔ xúnyóu huódòng.',
    example_vi = 'Mỗi dịp kỷ niệm lễ hội truyền thống trọng đại, trung tâm công dân đều tổ chức các hoạt động diễu hành và hội diễn văn nghệ quần chúng cỡ lớn muôn màu muôn vẻ.'
WHERE id = '2d0e98f7-b929-40fb-aace-33b9549f1b43' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2d0e98f7-b929-40fb-aace-33b9549f1b43', '每逢重大传统节日庆典，市民中心都会举办精彩纷呈的群众性大型文艺汇演与巡游活动。', 'Měi féng zhòngdà chuántǒng jiérì qìngdiǎn, shìmín zhōngxīn dōu huì jǔbàn jīngcǎi-fēncéng de qúnzhòngxìng dàxíng wényì huìyǎn yǔ xúnyóu huódòng.', 'Mỗi dịp kỷ niệm lễ hội truyền thống trọng đại, trung tâm công dân đều tổ chức các hoạt động diễu hành và hội diễn văn nghệ quần chúng cỡ lớn muôn màu muôn vẻ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2d0e98f7-b929-40fb-aace-33b9549f1b43'
);

-- [误解] (wùjiě): hiểu lầm
UPDATE public.vocabularies
SET example_hanzi = '人与人之间若缺乏坦诚相待的深入沟通，原本微不足道的小事也极容易演变成深重的误解。',
    example_pinyin = 'Rén yǔ rén zhījiān ruò quēfá tǎnchéng-xiāngdài de shēnrù gōutōng, yuánběn wēibùzúdào de xiǎoshì yě jí róngyì yǎnbiàn chéng shēnzhòng de wùjiě.',
    example_vi = 'Giữa người với người nếu thiếu đi sự giao lưu sâu sắc thẳng thắn chân thành, chuyện nhỏ vốn không đáng kể ban đầu cũng rất dễ biến chuyển thành hiểu lầm sâu sắc.'
WHERE id = '4966fcde-7a79-4811-b1d5-f71790f01090' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4966fcde-7a79-4811-b1d5-f71790f01090', '人与人之间若缺乏坦诚相待的深入沟通，原本微不足道的小事也极容易演变成深重的误解。', 'Rén yǔ rén zhījiān ruò quēfá tǎnchéng-xiāngdài de shēnrù gōutōng, yuánběn wēibùzúdào de xiǎoshì yě jí róngyì yǎnbiàn chéng shēnzhòng de wùjiě.', 'Giữa người với người nếu thiếu đi sự giao lưu sâu sắc thẳng thắn chân thành, chuyện nhỏ vốn không đáng kể ban đầu cũng rất dễ biến chuyển thành hiểu lầm sâu sắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4966fcde-7a79-4811-b1d5-f71790f01090'
);

-- [武器] (wǔqì): vũ khí
UPDATE public.vocabularies
SET example_hanzi = '在现代化国防科技体系建设中，自主研发拥有先进性能的战略防御武器是维系和平的基石。',
    example_pinyin = 'Zài xiàndàihuà guófáng kējì tǐxì jiànshè zhōng, zìzhǔ yánfā yōngyǒu xiānjìn xìngnéng de zhànlüè fángyù wǔqì shì wéixì hépíng de jīshí.',
    example_vi = 'Trong xây dựng hệ thống khoa học công nghệ quốc phòng hiện đại hóa, tự chủ nghiên cứu phát triển các loại vũ khí phòng ngự chiến lược có tính năng tiên tiến là nền tảng duy trì hòa bình.'
WHERE id = '2e25f899-c8f7-4237-8ec3-8dde1d3f8c47' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2e25f899-c8f7-4237-8ec3-8dde1d3f8c47', '在现代化国防科技体系建设中，自主研发拥有先进性能的战略防御武器是维系和平的基石。', 'Zài xiàndàihuà guófáng kējì tǐxì jiànshè zhōng, zìzhǔ yánfā yōngyǒu xiānjìn xìngnéng de zhànlüè fángyù wǔqì shì wéixì hépíng de jīshí.', 'Trong xây dựng hệ thống khoa học công nghệ quốc phòng hiện đại hóa, tự chủ nghiên cứu phát triển các loại vũ khí phòng ngự chiến lược có tính năng tiên tiến là nền tảng duy trì hòa bình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2e25f899-c8f7-4237-8ec3-8dde1d3f8c47'
);

-- [无所谓] (wúsuǒwèi): không sao cả, không bận tâm
UPDATE public.vocabularies
SET example_hanzi = '面对生活中的一些细微得失与旁人的冷嘲热讽，保持豁达超脱、无所谓的从容心态格外重要。',
    example_pinyin = 'Miànduì shēnghuó zhōng de yìxiē xìwēi déshī yǔ pángrén de lěngcháo-rèfěng, bǎochí huòdá chāotuō, wúsuǒwèi de cóngróng xīntài géwài zhòngyào.',
    example_vi = 'Đối mặt với những được mất nhỏ nhặt trong đời và lời chế giễu mỉa mai của người bên cạnh, việc giữ được tâm thái ung dung cởi mở siêu thoát, không bận tâm là vô cùng quan trọng.'
WHERE id = 'db37d250-5400-4dce-97b7-9e29610ab723' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'db37d250-5400-4dce-97b7-9e29610ab723', '面对生活中的一些细微得失与旁人的冷嘲热讽，保持豁达超脱、无所谓的从容心态格外重要。', 'Miànduì shēnghuó zhōng de yìxiē xìwēi déshī yǔ pángrén de lěngcháo-rèfěng, bǎochí huòdá chāotuō, wúsuǒwèi de cóngróng xīntài géwài zhòngyào.', 'Đối mặt với những được mất nhỏ nhặt trong đời và lời chế giễu mỉa mai của người bên cạnh, việc giữ được tâm thái ung dung cởi mở siêu thoát, không bận tâm là vô cùng quan trọng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'db37d250-5400-4dce-97b7-9e29610ab723'
);

-- [习俗] (xí sú): phong tục, tập quán
UPDATE public.vocabularies
SET example_hanzi = '在江南水乡的传统端午佳节，家家户户门前悬挂艾草、江面赛龙舟是流传千年的古老习俗。',
    example_pinyin = 'Zài jiāngnán shuǐxiāng de chuántǒng duānwǔ jiājié, jiājiā-hùhù ménqián xuánguà àicǎo, jiāngmiàn sài lóngzhōu shì liúchuán qiānnián de gǔlǎo xísú.',
    example_vi = 'Vào dịp tết Đoan ngọ truyền thống ở miền sông nước Giang Nam, nhà nhà trước cửa treo cỏ ngải cứu, trên mặt sông đua thuyền rồng là phong tục tập quán cổ xưa lưu truyền ngàn năm.'
WHERE id = '029915ae-a6dd-4d95-85c0-341d6f1ae790' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '029915ae-a6dd-4d95-85c0-341d6f1ae790', '在江南水乡的传统端午佳节，家家户户门前悬挂艾草、江面赛龙舟是流传千年的古老习俗。', 'Zài jiāngnán shuǐxiāng de chuántǒng duānwǔ jiājié, jiājiā-hùhù ménqián xuánguà àicǎo, jiāngmiàn sài lóngzhōu shì liúchuán qiānnián de gǔlǎo xísú.', 'Vào dịp tết Đoan ngọ truyền thống ở miền sông nước Giang Nam, nhà nhà trước cửa treo cỏ ngải cứu, trên mặt sông đua thuyền rồng là phong tục tập quán cổ xưa lưu truyền ngàn năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '029915ae-a6dd-4d95-85c0-341d6f1ae790'
);

-- [吓] (xià): dọa, sợ hãi
UPDATE public.vocabularies
SET example_hanzi = '夜深人静时窗外突然传来一声凄厉怪异的猫叫声，着实把独自在家温习功课的女孩吓了一大跳。',
    example_pinyin = 'Yèshēn-rénjìng shí chuāngwài tūrán chuán lái yì shēng qīlì guàiyì de māojiào shēng, zhuóshí bǎ dúzì zài jiā wēnxí gōngkè de nǚhái xià le yí dà tiào.',
    example_vi = 'Lúc đêm khuya người vắng ngoài cửa sổ bất ngờ truyền lại tiếng mèo kêu ma quái thê lương, thực sự đã làm cô bé đang một mình ôn bài ở nhà bị dọa cho giật bắn mình.'
WHERE id = '7dfcdf55-6040-40bc-8818-a4b53d1727aa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7dfcdf55-6040-40bc-8818-a4b53d1727aa', '夜深人静时窗外突然传来一声凄厉怪异的猫叫声，着实把独自在家温习功课的女孩吓了一大跳。', 'Yèshēn-rénjìng shí chuāngwài tūrán chuán lái yì shēng qīlì guàiyì de māojiào shēng, zhuóshí bǎ dúzì zài jiā wēnxí gōngkè de nǚhái xià le yí dà tiào.', 'Lúc đêm khuya người vắng ngoài cửa sổ bất ngờ truyền lại tiếng mèo kêu ma quái thê lương, thực sự đã làm cô bé đang một mình ôn bài ở nhà bị dọa cho giật bắn mình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7dfcdf55-6040-40bc-8818-a4b53d1727aa'
);

-- [夏令营] (xiàlìngyíng): trại hè
UPDATE public.vocabularies
SET example_hanzi = '这所著名国际学校在暑期组织了科技与自然夏令营，让中小学生们在动手实践中领略科学魅力。',
    example_pinyin = 'Zhè suǒ zhùmíng guójì xuéxiào zài shǔqī zǔzhī le kējì yǔ zìrán xiàlìngyíng, ràng zhōng-xiǎoxuéshēng men zài dòngshǒu shíjiàn zhōng lǐnglüè kēxué mèilì.',
    example_vi = 'Ngôi trường quốc tế danh tiếng này vào kỳ nghỉ hè đã tổ chức trại hè khoa học và thiên nhiên, giúp các em học sinh phổ thông lĩnh hội sức hút của khoa học qua thực hành trực tiếp.'
WHERE id = '12b157b5-ab0a-4122-a2b2-db19e0e80e12' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '12b157b5-ab0a-4122-a2b2-db19e0e80e12', '这所著名国际学校在暑期组织了科技与自然夏令营，让中小学生们在动手实践中领略科学魅力。', 'Zhè suǒ zhùmíng guójì xuéxiào zài shǔqī zǔzhī le kējì yǔ zìrán xiàlìngyíng, ràng zhōng-xiǎoxuéshēng men zài dòngshǒu shíjiàn zhōng lǐnglüè kēxué mèilì.', 'Ngôi trường quốc tế danh tiếng này vào kỳ nghỉ hè đã tổ chức trại hè khoa học và thiên nhiên, giúp các em học sinh phổ thông lĩnh hội sức hút của khoa học qua thực hành trực tiếp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '12b157b5-ab0a-4122-a2b2-db19e0e80e12'
);

-- [嫌] (xián): chê, ghét, nghi ngờ
UPDATE public.vocabularies
SET example_hanzi = '这位年轻人做事向来脚踏实地、吃苦耐劳，从不嫌工作环境艰苦或者任务繁重棘手。',
    example_pinyin = 'Zhè wèi niánqīngrén zuòshì xiànglái jiǎotà-shídì, chīkǔ-nàiláo, cóng bù xián gōngzuò huánjìng jiānkǔ huòzhě rènwù fánzhòng jíshǒu.',
    example_vi = 'Chàng trai trẻ này làm việc xưa nay luôn chắc chắn thực tế, chịu thương chịu khó, chưa từng chê bai môi trường làm việc gian khổ hay nhiệm vụ nặng nề khó nhằn.'
WHERE id = '14f89c97-611e-4e9b-87d2-7dfd7167df13' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '14f89c97-611e-4e9b-87d2-7dfd7167df13', '这位年轻人做事向来脚踏实地、吃苦耐劳，从不嫌工作环境艰苦或者任务繁重棘手。', 'Zhè wèi niánqīngrén zuòshì xiànglái jiǎotà-shídì, chīkǔ-nàiláo, cóng bù xián gōngzuò huánjìng jiānkǔ huòzhě rènwù fánzhòng jíshǒu.', 'Chàng trai trẻ này làm việc xưa nay luôn chắc chắn thực tế, chịu thương chịu khó, chưa từng chê bai môi trường làm việc gian khổ hay nhiệm vụ nặng nề khó nhằn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '14f89c97-611e-4e9b-87d2-7dfd7167df13'
);

-- [相差] (xiāngchà): chênh lệch, khác nhau
UPDATE public.vocabularies
SET example_hanzi = '这两家制造企业虽然在产能规模上相差不多，但在自动化数字化技术水平上却存在明显差距。',
    example_pinyin = 'Zhè liǎng jiā zhìzào qǐyè suīrán zài chǎnnéng guīmó shang xiāngchà bù duō, dàn zài zìdònghuà shùzìhuà jìshù shuǐpíng shang què cúnzài míngxiǎn chājù.',
    example_vi = 'Hai doanh nghiệp chế tạo này mặc dù chênh lệch không nhiều về quy mô công suất sản xuất, nhưng ở trình độ công nghệ tự động hóa số hóa lại tồn tại khoảng cách rõ rệt.'
WHERE id = '1a9e5749-9df0-4220-a3a4-94f9a520be9c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1a9e5749-9df0-4220-a3a4-94f9a520be9c', '这两家制造企业虽然在产能规模上相差不多，但在自动化数字化技术水平上却存在明显差距。', 'Zhè liǎng jiā zhìzào qǐyè suīrán zài chǎnnéng guīmó shang xiāngchà bù duō, dàn zài zìdònghuà shùzìhuà jìshù shuǐpíng shang què cúnzài míngxiǎn chājù.', 'Hai doanh nghiệp chế tạo này mặc dù chênh lệch không nhiều về quy mô công suất sản xuất, nhưng ở trình độ công nghệ tự động hóa số hóa lại tồn tại khoảng cách rõ rệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1a9e5749-9df0-4220-a3a4-94f9a520be9c'
);

-- [香肠] (xiāngcháng): xúc xích, lạp xưởng
UPDATE public.vocabularies
SET example_hanzi = '这家老字号熟食铺手工熏制的风味香肠肥瘦适中、咸甜兼备，每逢节日前夕总会排起长龙购买。',
    example_pinyin = 'Zhè jiā lǎozìhào shúshí pù shǒugōng xūnzhì de fēngwèi xiāngcháng féishòu shìzhōng, xiántián jiānbèi, měi féng jiérì qiánxī zǒng huì pái qǐ chánglóng gòumǎi.',
    example_vi = 'Món xúc xích hun khói thủ công chuẩn vị của tiệm đồ chín lâu đời này nạc mỡ vừa vặn, mặn ngọt hài hòa, mỗi dịp trước thềm lễ hội luôn có hàng dài người xếp hàng mua.'
WHERE id = 'fbcb2cf8-09f1-46e3-bd61-f6af4a35bf91' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fbcb2cf8-09f1-46e3-bd61-f6af4a35bf91', '这家老字号熟食铺手工熏制的风味香肠肥瘦适中、咸甜兼备，每逢节日前夕总会排起长龙购买。', 'Zhè jiā lǎozìhào shúshí pù shǒugōng xūnzhì de fēngwèi xiāngcháng féishòu shìzhōng, xiántián jiānbèi, měi féng jiérì qiánxī zǒng huì pái qǐ chánglóng gòumǎi.', 'Món xúc xích hun khói thủ công chuẩn vị của tiệm đồ chín lâu đời này nạc mỡ vừa vặn, mặn ngọt hài hòa, mỗi dịp trước thềm lễ hội luôn có hàng dài người xếp hàng mua.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fbcb2cf8-09f1-46e3-bd61-f6af4a35bf91'
);

-- [相等] (xiāngděng): bằng nhau, tương đương
UPDATE public.vocabularies
SET example_hanzi = '在平面几何严谨的论证逻辑中，这两个全等三角形对应的边长与内角度数完全相等。',
    example_pinyin = 'Zài píngmiàn jǐhé yánjǐn de lùnzhèng luóji zhōng, zhè liǎng gè quánděng sānjiǎoxíng duìyìng de biāncháng yǔ nèijiǎo dùshù wánquán xiāngděng.',
    example_vi = 'Trong logic chứng minh nghiêm ngặt của hình học phẳng, độ dài cạnh và số đo góc trong tương ứng của hai tam giác bằng nhau này hoàn toàn bằng nhau.'
WHERE id = 'a2a8f2cb-7bee-4da8-8880-1b9a889567c4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a2a8f2cb-7bee-4da8-8880-1b9a889567c4', '在平面几何严谨的论证逻辑中，这两个全等三角形对应的边长与内角度数完全相等。', 'Zài píngmiàn jǐhé yánjǐn de lùnzhèng luóji zhōng, zhè liǎng gè quánděng sānjiǎoxíng duìyìng de biāncháng yǔ nèijiǎo dùshù wánquán xiāngděng.', 'Trong logic chứng minh nghiêm ngặt của hình học phẳng, độ dài cạnh và số đo góc trong tương ứng của hai tam giác bằng nhau này hoàn toàn bằng nhau.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a2a8f2cb-7bee-4da8-8880-1b9a889567c4'
);

-- [项链] (xiàngliàn): dây chuyền, vòng cổ
UPDATE public.vocabularies
SET example_hanzi = '在结婚三十周年珍珠婚纪念日当天，丈夫深情地为心爱的妻子戴上了一条温润典雅的珍珠项链。',
    example_pinyin = 'Zài jiéhūn sānshí zhōunián zhēnzhū hūn jìniànrì dāngtiān, zhàngfu shēnqíng de wèi xīn''ài de qīzǐ dài shàng le yì tiáo wēnrùn diǎnyǎ de zhēnzhū xiàngliàn.',
    example_vi = 'Vào đúng ngày kỷ niệm 30 năm đám cưới ngọc trai, người chồng trìu mến đeo lên cổ người vợ yêu quý một sợi dây chuyền ngọc trai óng ả nhã nhặn.'
WHERE id = '3e4eed6f-d291-474e-9b77-4be13b363cee' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3e4eed6f-d291-474e-9b77-4be13b363cee', '在结婚三十周年珍珠婚纪念日当天，丈夫深情地为心爱的妻子戴上了一条温润典雅的珍珠项链。', 'Zài jiéhūn sānshí zhōunián zhēnzhū hūn jìniànrì dāngtiān, zhàngfu shēnqíng de wèi xīn''ài de qīzǐ dài shàng le yì tiáo wēnrùn diǎnyǎ de zhēnzhū xiàngliàn.', 'Vào đúng ngày kỷ niệm 30 năm đám cưới ngọc trai, người chồng trìu mến đeo lên cổ người vợ yêu quý một sợi dây chuyền ngọc trai óng ả nhã nhặn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3e4eed6f-d291-474e-9b77-4be13b363cee'
);

-- [象棋] (xiàngqí): cờ tướng
UPDATE public.vocabularies
SET example_hanzi = '公园的石桌旁经常围满了棋迷观众，聚精会神地观赏两位白发老者在方寸象棋盘上的斗智斗勇。',
    example_pinyin = 'Gōngyuán de shízhūo páng jīngcháng wéimǎn le qímí guānzhòng, jùjīng-huìshén de guānshǎng liǎng wèi báfà lǎozhě zài fāngcùn xiàngqí pán shang de dòuzhì-dòuyǒng.',
    example_vi = 'Bên bàn đá công viên thường quây kín những người mê cờ, chăm chú theo dõi cuộc đấu trí so tài của hai cụ già tóc bạc trên bàn cờ tướng tấc vuông.'
WHERE id = '8f3203ec-a232-4aee-b77d-25f812364fa7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8f3203ec-a232-4aee-b77d-25f812364fa7', '公园的石桌旁经常围满了棋迷观众，聚精会神地观赏两位白发老者在方寸象棋盘上的斗智斗勇。', 'Gōngyuán de shízhūo páng jīngcháng wéimǎn le qímí guānzhòng, jùjīng-huìshén de guānshǎng liǎng wèi báfà lǎozhě zài fāngcùn xiàngqí pán shang de dòuzhì-dòuyǒng.', 'Bên bàn đá công viên thường quây kín những người mê cờ, chăm chú theo dõi cuộc đấu trí so tài của hai cụ già tóc bạc trên bàn cờ tướng tấc vuông.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8f3203ec-a232-4aee-b77d-25f812364fa7'
);

-- [相声] (xiàngsheng): tướng thanh (hài độc thoại/đối thoại)
UPDATE public.vocabularies
SET example_hanzi = '这对配合默契的相声演员在舞台上妙语连珠、包袱不断，逗得剧场全场观众捧腹大笑。',
    example_pinyin = 'Zhè duì pèihé mòqì de xiàngsheng yǎnyuán zài wǔtái shang miàoyǔ-liánzhū, bāofu búduàn, dòu de jùchǎng quánchǎng guānzhòng pěngfù-dàxiào.',
    example_vi = 'Cặp diễn viên hài tướng thanh phối hợp ăn ý này trên sân khấu lời lẽ dí dỏm duyên dáng tuôn trào, miếng hài liên tiếp khiến toàn thể khán giả trong nhà hát cười nghiêng ngả ôm bụng.'
WHERE id = '811ac7c0-2ca9-4e6d-a18c-519d452b4dea' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '811ac7c0-2ca9-4e6d-a18c-519d452b4dea', '这对配合默契的相声演员在舞台上妙语连珠、包袱不断，逗得剧场全场观众捧腹大笑。', 'Zhè duì pèihé mòqì de xiàngsheng yǎnyuán zài wǔtái shang miàoyǔ-liánzhū, bāofu búduàn, dòu de jùchǎng quánchǎng guānzhòng pěngfù-dàxiào.', 'Cặp diễn viên hài tướng thanh phối hợp ăn ý này trên sân khấu lời lẽ dí dỏm duyên dáng tuôn trào, miếng hài liên tiếp khiến toàn thể khán giả trong nhà hát cười nghiêng ngả ôm bụng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '811ac7c0-2ca9-4e6d-a18c-519d452b4dea'
);

-- [向往] (xiàngwǎng): hướng tới, khao khát
UPDATE public.vocabularies
SET example_hanzi = '远离都市嘈杂喧嚣、回归静谧幽雅的大自然，是许多现代职场人心中深切向往的田园生活。',
    example_pinyin = 'Yuǎnlí dūshì cáozá xuānxiāo, huíguī jìngmì yōuyǎ de dàzìrán, shì xǔduō xiàndài zhíchǎngrén xīnzhōng shēnqiè xiàngwǎng de tiányuán shēnghuó.',
    example_vi = 'Tránh xa sự ồn ào náo nhiệt của đô thị, quay trở về với thiên nhiên tĩnh mịch tao nhã là cuộc sống điền viên mà nhiều người đi làm hiện đại hằng khao khát trong lòng.'
WHERE id = '14c6a8a1-baba-424a-bf17-3774950e7ed6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '14c6a8a1-baba-424a-bf17-3774950e7ed6', '远离都市嘈杂喧嚣、回归静谧幽雅的大自然，是许多现代职场人心中深切向往的田园生活。', 'Yuǎnlí dūshì cáozá xuānxiāo, huíguī jìngmì yōuyǎ de dàzìrán, shì xǔduō xiàndài zhíchǎngrén xīnzhōng shēnqiè xiàngwǎng de tiányuán shēnghuó.', 'Tránh xa sự ồn ào náo nhiệt của đô thị, quay trở về với thiên nhiên tĩnh mịch tao nhã là cuộc sống điền viên mà nhiều người đi làm hiện đại hằng khao khát trong lòng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '14c6a8a1-baba-424a-bf17-3774950e7ed6'
);

-- [相应] (xiāngyìng): tương ứng
UPDATE public.vocabularies
SET example_hanzi = '随着国家全新技术法规标准的正式出台，各生产制造企业必须对质检流程做出相应调整。',
    example_pinyin = 'Suízhe guójiā quánxīn jìshù fǎguī biāozhǔn de zhèngshì chūtái, gè shēngchǎn zhìzào qǐyè bìxū duì zhìjiǎn liúchéng zuòchū xiāngyìng tiáozhěng.',
    example_vi = 'Cùng với sự ban hành chính thức tiêu chuẩn quy phạm kỹ thuật mới của quốc gia, các doanh nghiệp sản xuất chế tạo bắt buộc phải có những điều chỉnh tương ứng đối với quy trình kiểm tra chất lượng.'
WHERE id = '0064185b-17df-49e8-a669-927fcd239d79' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0064185b-17df-49e8-a669-927fcd239d79', '随着国家全新技术法规标准的正式出台，各生产制造企业必须对质检流程做出相应调整。', 'Suízhe guójiā quánxīn jìshù fǎguī biāozhǔn de zhèngshì chūtái, gè shēngchǎn zhìzào qǐyè bìxū duì zhìjiǎn liúchéng zuòchū xiāngyìng tiáozhěng.', 'Cùng với sự ban hành chính thức tiêu chuẩn quy phạm kỹ thuật mới của quốc gia, các doanh nghiệp sản xuất chế tạo bắt buộc phải có những điều chỉnh tương ứng đối với quy trình kiểm tra chất lượng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0064185b-17df-49e8-a669-927fcd239d79'
);

-- [鲜明] (xiānmíng): rõ nét, tươi sáng
UPDATE public.vocabularies
SET example_hanzi = '这部文学力作不仅具有鲜明独特的地域文化特色，更有力反映了波澜壮阔的时代历史变迁。',
    example_pinyin = 'Zhè bù wénxué lìzuò bùjǐn jùyǒu xiānmíng dútè de dìyù wénhuà tèsè, gèng yǒulì fǎnyìng le bōlán-zhuàngkuò de shídài lìshǐ biànqiān.',
    example_vi = 'Kiệt tác văn học này không chỉ mang đậm nét đặc sắc văn hóa vùng miền độc đáo rõ nét, mà còn phản ánh mạnh mẽ những biến thiên lịch sử thời đại cuộn sóng trào dâng.'
WHERE id = '0e0d5f1d-773c-4897-971a-d36732c17aa6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0e0d5f1d-773c-4897-971a-d36732c17aa6', '这部文学力作不仅具有鲜明独特的地域文化特色，更有力反映了波澜壮阔的时代历史变迁。', 'Zhè bù wénxué lìzuò bùjǐn jùyǒu xiānmíng dútè de dìyù wénhuà tèsè, gèng yǒulì fǎnyìng le bōlán-zhuàngkuò de shídài lìshǐ biànqiān.', 'Kiệt tác văn học này không chỉ mang đậm nét đặc sắc văn hóa vùng miền độc đáo rõ nét, mà còn phản ánh mạnh mẽ những biến thiên lịch sử thời đại cuộn sóng trào dâng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0e0d5f1d-773c-4897-971a-d36732c17aa6'
);

-- [先前] (xiānqián): trước kia, trước đây
UPDATE public.vocabularies
SET example_hanzi = '经过项目团队的连夜攻坚排查，先前在系统压力测试中偶然暴露出的几处隐藏漏洞已全部修复。',
    example_pinyin = 'Jīngguò xiàngmù tuánduì de liányè gōngjiān páichá, xiānqián zài xìtǒng yālì cèshì zhōng ǒurán bàolù chū de jǐ chù yǐncáng lòudòng yǐ quánbù xiūfù.',
    example_vi = 'Trải qua việc rà soát tập trung suốt đêm của đội ngũ dự án, mấy lỗ hổng tiềm ẩn trước đây ngẫu nhiên bộc lộ trong kiểm thử áp lực hệ thống đều đã được vá triệt để.'
WHERE id = 'd39dec9e-ee3f-48c5-81b1-b5eff7f8741b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd39dec9e-ee3f-48c5-81b1-b5eff7f8741b', '经过项目团队的连夜攻坚排查，先前在系统压力测试中偶然暴露出的几处隐藏漏洞已全部修复。', 'Jīngguò xiàngmù tuánduì de liányè gōngjiān páichá, xiānqián zài xìtǒng yālì cèshì zhōng ǒurán bàolù chū de jǐ chù yǐncáng lòudòng yǐ quánbù xiūfù.', 'Trải qua việc rà soát tập trung suốt đêm của đội ngũ dự án, mấy lỗ hổng tiềm ẩn trước đây ngẫu nhiên bộc lộ trong kiểm thử áp lực hệ thống đều đã được vá triệt để.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd39dec9e-ee3f-48c5-81b1-b5eff7f8741b'
);

-- [陷入] (xiànrù): rơi vào, lún sâu
UPDATE public.vocabularies
SET example_hanzi = '由于突遭国际上游核心原材料断供，这家原本蒸蒸日上的外贸企业一度陷入了严重的经营困境。',
    example_pinyin = 'Yóuyú tū zāo guójì shàngyóu héxīn yuáncáiliào duàngōng, zhè jiā yuánběn zhēngzhēng-rìshàng de wàimào qǐyè yídù xiànrù le yánzhòng de jīngyíng kùnjìng.',
    example_vi = 'Do bất ngờ gặp cảnh đứt gãy nguồn cung nguyên liệu thô thượng nguồn quốc tế, doanh nghiệp ngoại thương vốn đang trên đà phát triển này từng rơi vào cảnh khó khăn kinh doanh nghiêm trọng.'
WHERE id = '9b1e3e30-d8ae-405a-9af7-8bb34aeca81f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9b1e3e30-d8ae-405a-9af7-8bb34aeca81f', '由于突遭国际上游核心原材料断供，这家原本蒸蒸日上的外贸企业一度陷入了严重的经营困境。', 'Yóuyú tū zāo guójì shàngyóu héxīn yuáncáiliào duàngōng, zhè jiā yuánběn zhēngzhēng-rìshàng de wàimào qǐyè yídù xiànrù le yánzhòng de jīngyíng kùnjìng.', 'Do bất ngờ gặp cảnh đứt gãy nguồn cung nguyên liệu thô thượng nguồn quốc tế, doanh nghiệp ngoại thương vốn đang trên đà phát triển này từng rơi vào cảnh khó khăn kinh doanh nghiêm trọng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9b1e3e30-d8ae-405a-9af7-8bb34aeca81f'
);

-- [线索] (xiànsuǒ): manh mối
UPDATE public.vocabularies
SET example_hanzi = '经验丰富的老刑警凭借在案发现场勘验提取到的微量纤维线索，最终成功锁定了重大嫌疑人。',
    example_pinyin = 'Jīngyàn fēngfù de lǎo xíngjǐng píngjiè zài ànfā xiànchǎng kānyàn tíqǔ dào de wēiliàng xiānwéi xiànsuǒ, zuìzhōng chénggōng suǒdìng le zhòngdà xiányírén.',
    example_vi = 'Người cảnh sát hình sự kỳ cựu dựa vào manh mối sợi vi lượng thu thập khám nghiệm được tại hiện trường vụ án cuối cùng đã khóa chặt thành công nghi phạm trọng điểm.'
WHERE id = '5e3eeb00-fbc3-4727-91ae-0f827d2c3053' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5e3eeb00-fbc3-4727-91ae-0f827d2c3053', '经验丰富的老刑警凭借在案发现场勘验提取到的微量纤维线索，最终成功锁定了重大嫌疑人。', 'Jīngyàn fēngfù de lǎo xíngjǐng píngjiè zài ànfā xiànchǎng kānyàn tíqǔ dào de wēiliàng xiānwéi xiànsuǒ, zuìzhōng chénggōng suǒdìng le zhòngdà xiányírén.', 'Người cảnh sát hình sự kỳ cựu dựa vào manh mối sợi vi lượng thu thập khám nghiệm được tại hiện trường vụ án cuối cùng đã khóa chặt thành công nghi phạm trọng điểm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5e3eeb00-fbc3-4727-91ae-0f827d2c3053'
);

-- [鲜艳] (xiānyàn): tươi sáng, rực rỡ
UPDATE public.vocabularies
SET example_hanzi = '盛开在清晨阳光下的各色月季花色彩鲜艳夺目，引来了成群结队的彩蝶翩翩起舞。',
    example_pinyin = 'Shèngkāi zài qīngchén yángguāng xià de gè sè yuèjìhuā sècǎi xiānyàn duómù, yǐn lái le chéngqún-jiéduì de cǎidié piānpiān-qǐwǔ.',
    example_vi = 'Những bông hoa nguyệt quý đủ màu nở rộ dưới ánh nắng ban mai sắc màu tươi thắm rực rỡ, thu hút từng đàn bướm ngũ sắc dập dờn bay lượn.'
WHERE id = 'e3b22cdc-97a4-4ed4-812f-7d091308d7ea' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e3b22cdc-97a4-4ed4-812f-7d091308d7ea', '盛开在清晨阳光下的各色月季花色彩鲜艳夺目，引来了成群结队的彩蝶翩翩起舞。', 'Shèngkāi zài qīngchén yángguāng xià de gè sè yuèjìhuā sècǎi xiānyàn duómù, yǐn lái le chéngqún-jiéduì de cǎidié piānpiān-qǐwǔ.', 'Những bông hoa nguyệt quý đủ màu nở rộ dưới ánh nắng ban mai sắc màu tươi thắm rực rỡ, thu hút từng đàn bướm ngũ sắc dập dờn bay lượn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e3b22cdc-97a4-4ed4-812f-7d091308d7ea'
);

-- [显著] (xiǎnzhù): rõ rệt, nổi bật
UPDATE public.vocabularies
SET example_hanzi = '自从推行新一轮智慧医疗改革措施以来，公立医院的就诊等待时间有了极其显著的缩短。',
    example_pinyin = 'Zìcóng tuīxíng xīn yì lún zhìhuì yīliáo gǎigé cuòshī yǐlái, gōnglì yīyuàn de jiùzhěn děngdài shíjiān yǒu le jíqí xiǎnzhù de suōduǎn.',
    example_vi = 'Kể từ khi triển khai đợt biện pháp cải cách y tế thông minh mới, thời gian chờ khám bệnh tại các bệnh viện công lập đã rút ngắn vô cùng rõ rệt.'
WHERE id = '3db63b0f-5a70-4ae1-b086-a8a2bb3193fd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3db63b0f-5a70-4ae1-b086-a8a2bb3193fd', '自从推行新一轮智慧医疗改革措施以来，公立医院的就诊等待时间有了极其显著的缩短。', 'Zìcóng tuīxíng xīn yì lún zhìhuì yīliáo gǎigé cuòshī yǐlái, gōnglì yīyuàn de jiùzhěn děngdài shíjiān yǒu le jíqí xiǎnzhù de suōduǎn.', 'Kể từ khi triển khai đợt biện pháp cải cách y tế thông minh mới, thời gian chờ khám bệnh tại các bệnh viện công lập đã rút ngắn vô cùng rõ rệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3db63b0f-5a70-4ae1-b086-a8a2bb3193fd'
);

-- [消除] (xiāochú): xóa bỏ, loại trừ
UPDATE public.vocabularies
SET example_hanzi = '唯有通过真诚开诚布公的对话与务实平等的协作，才能逐步消除不同文明之间的猜忌与隔阂。',
    example_pinyin = 'Wéiyǒu tōngguò zhēnchéng kāichéng-bùgōng de duìhuà yǔ wùshí píngděng de xiézuò, cáinéng zhúbù xiāochú bùtóng wénmíng zhījiān de cāijì yǔ géhé.',
    example_vi = 'Chỉ thông qua đối thoại chân thành cởi mở và hợp tác thực chất bình đẳng mới có thể từng bước xóa bỏ nghi kỵ và rào cản ngăn cách giữa các nền văn minh khác nhau.'
WHERE id = '873fda25-7e34-4e49-a840-240442e0e277' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '873fda25-7e34-4e49-a840-240442e0e277', '唯有通过真诚开诚布公的对话与务实平等的协作，才能逐步消除不同文明之间的猜忌与隔阂。', 'Wéiyǒu tōngguò zhēnchéng kāichéng-bùgōng de duìhuà yǔ wùshí píngděng de xiézuò, cáinéng zhúbù xiāochú bùtóng wénmíng zhījiān de cāijì yǔ géhé.', 'Chỉ thông qua đối thoại chân thành cởi mở và hợp tác thực chất bình đẳng mới có thể từng bước xóa bỏ nghi kỵ và rào cản ngăn cách giữa các nền văn minh khác nhau.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '873fda25-7e34-4e49-a840-240442e0e277'
);

-- [消毒] (xiāodú): khử trùng, tiêu độc
UPDATE public.vocabularies
SET example_hanzi = '医院手术室与重症监护病房每天都必须进行多轮极其严格细致的空气紫外线与器械消毒。',
    example_pinyin = 'Yīyuàn shǒushùshì yǔ zhòngzhèng jiānhù bìngfáng měitiān dōu bìxū jìnxíng duō lún jíqí yángé xìzhì de kōngqì zǐwàixiàn yǔ qìxiè xiāodú.',
    example_vi = 'Phòng phẫu thuật bệnh viện và phòng hồi sức tích cực mỗi ngày đều phải tiến hành nhiều lượt khử trùng tia cực tím không khí và dụng cụ vô cùng nghiêm ngặt tỉ mỉ.'
WHERE id = '6747db81-0019-42f1-bee7-3d3db4f0f5f7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6747db81-0019-42f1-bee7-3d3db4f0f5f7', '医院手术室与重症监护病房每天都必须进行多轮极其严格细致的空气紫外线与器械消毒。', 'Yīyuàn shǒushùshì yǔ zhòngzhèng jiānhù bìngfáng měitiān dōu bìxū jìnxíng duō lún jíqí yángé xìzhì de kōngqì zǐwàixiàn yǔ qìxiè xiāodú.', 'Phòng phẫu thuật bệnh viện và phòng hồi sức tích cực mỗi ngày đều phải tiến hành nhiều lượt khử trùng tia cực tím không khí và dụng cụ vô cùng nghiêm ngặt tỉ mỉ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6747db81-0019-42f1-bee7-3d3db4f0f5f7'
);

-- [消防] (xiāofáng): phòng cháy chữa cháy
UPDATE public.vocabularies
SET example_hanzi = '高层住宅物业部门定期组织居民开展防灾演练，确保全楼所有消防通道时刻畅通无阻。',
    example_pinyin = 'Gāocéng zhùzhái wùyè bùmén dìngqī zǔzhī jūmín kāizhǎn fángzāi yǎnliàn, quèbǎo quán lóu suǒyǒu xiāofáng tōngdào shíkè chàngtōng-wúzǔ.',
    example_vi = 'Bộ phận quản lý tòa nhà chung cư cao tầng định kỳ tổ chức cư dân diễn tập phòng chống thảm họa nhằm bảo đảm mọi lối thoát hiểm phòng cháy chữa cháy toàn tòa nhà luôn thông thoáng không bị cản trở.'
WHERE id = 'f37a1b63-57bf-468b-9e68-6502197782b9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f37a1b63-57bf-468b-9e68-6502197782b9', '高层住宅物业部门定期组织居民开展防灾演练，确保全楼所有消防通道时刻畅通无阻。', 'Gāocéng zhùzhái wùyè bùmén dìngqī zǔzhī jūmín kāizhǎn fángzāi yǎnliàn, quèbǎo quán lóu suǒyǒu xiāofáng tōngdào shíkè chàngtōng-wúzǔ.', 'Bộ phận quản lý tòa nhà chung cư cao tầng định kỳ tổ chức cư dân diễn tập phòng chống thảm họa nhằm bảo đảm mọi lối thoát hiểm phòng cháy chữa cháy toàn tòa nhà luôn thông thoáng không bị cản trở.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f37a1b63-57bf-468b-9e68-6502197782b9'
);

-- [消耗] (xiāohào): tiêu hao
UPDATE public.vocabularies
SET example_hanzi = '马拉松长跑是一项极其考验意志力与体能储备的耐力运动，比赛全程会消耗运动员巨量的体能。',
    example_pinyin = 'Mǎlāsōng chángpǎo shì yí xiàng jíqí kǎoyàn yìzhìlì yǔ tǐnéng chǔbèi de nàilì yùndòng, bǐsài quánchéng huì xiāohào yùndòngyuán jùliàng de tǐnéng.',
    example_vi = 'Chạy marathon đường dài là môn thể thao sức bền thử thách tột cùng ý chí và dự trữ thể lực, toàn bộ cuộc đua sẽ tiêu hao lượng thể năng khổng lồ của vận động viên.'
WHERE id = 'f3166cfc-e28b-45a2-81f7-bb971ed5c1ff' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f3166cfc-e28b-45a2-81f7-bb971ed5c1ff', '马拉松长跑是一项极其考验意志力与体能储备的耐力运动，比赛全程会消耗运动员巨量的体能。', 'Mǎlāsōng chángpǎo shì yí xiàng jíqí kǎoyàn yìzhìlì yǔ tǐnéng chǔbèi de nàilì yùndòng, bǐsài quánchéng huì xiāohào yùndòngyuán jùliàng de tǐnéng.', 'Chạy marathon đường dài là môn thể thao sức bền thử thách tột cùng ý chí và dự trữ thể lực, toàn bộ cuộc đua sẽ tiêu hao lượng thể năng khổng lồ của vận động viên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f3166cfc-e28b-45a2-81f7-bb971ed5c1ff'
);

-- [小麦] (xiǎomài): lúa mì
UPDATE public.vocabularies
SET example_hanzi = '金秋时节北方广袤平原上掀起金色的麦浪，成熟饱满的小麦迎来了又一个鼓舞人心的丰收年。',
    example_pinyin = 'Jīnqiū shíjié běifāng guǎngmào píngyuán shang xiānqǐ jīnsè de màilàng, chéngshú bǎomǎn de xiǎomài yínglái le yòu yí gè gǔwǔ-rénxīn de fēngshōunián.',
    example_vi = 'Mùa thu vàng trên bình nguyên phương bắc bao la dậy lên từng làn sóng lúa mì óng ả, những bông lúa mì căng tròn chín mọng đón thêm một năm mùa bội thu nức lòng.'
WHERE id = '371d9864-3f97-42b9-b66d-583b945c4a6a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '371d9864-3f97-42b9-b66d-583b945c4a6a', '金秋时节北方广袤平原上掀起金色的麦浪，成熟饱满的小麦迎来了又一个鼓舞人心的丰收年。', 'Jīnqiū shíjié běifāng guǎngmào píngyuán shang xiānqǐ jīnsè de màilàng, chéngshú bǎomǎn de xiǎomài yínglái le yòu yí gè gǔwǔ-rénxīn de fēngshōunián.', 'Mùa thu vàng trên bình nguyên phương bắc bao la dậy lên từng làn sóng lúa mì óng ả, những bông lúa mì căng tròn chín mọng đón thêm một năm mùa bội thu nức lòng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '371d9864-3f97-42b9-b66d-583b945c4a6a'
);

-- [消灭] (xiāomiè): tiêu diệt
UPDATE public.vocabularies
SET example_hanzi = '经过几代公立卫生医疗工作者的持续不懈奋战，脊髓灰质炎等烈性传染病已被彻底消灭。',
    example_pinyin = 'Jīngguò jǐ dài gōnglì wèishēng yīliáo gōngzuòzhě de chíxù búxiè fènzhàn, jǐsuǐ-huīzhìyán děng lièxìng chuánrǎnbìng yǐ bèi chèdǐ xiāomiè.',
    example_vi = 'Trải qua cuộc chiến đấu kiên trì không ngơi nghỉ của nhiều thế hệ người làm công tác y tế vệ sinh công, những căn bệnh truyền nhiễm ác tính như bại liệt tủy sống đã bị tiêu diệt hoàn toàn.'
WHERE id = '96672561-8a1d-4774-b19c-0efcd083600f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '96672561-8a1d-4774-b19c-0efcd083600f', '经过几代公立卫生医疗工作者的持续不懈奋战，脊髓灰质炎等烈性传染病已被彻底消灭。', 'Jīngguò jǐ dài gōnglì wèishēng yīliáo gōngzuòzhě de chíxù búxiè fènzhàn, jǐsuǐ-huīzhìyán děng lièxìng chuánrǎnbìng yǐ bèi chèdǐ xiāomiè.', 'Trải qua cuộc chiến đấu kiên trì không ngơi nghỉ của nhiều thế hệ người làm công tác y tế vệ sinh công, những căn bệnh truyền nhiễm ác tính như bại liệt tủy sống đã bị tiêu diệt hoàn toàn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '96672561-8a1d-4774-b19c-0efcd083600f'
);

-- [小气] (xiǎoqi): keo kiệt, hẹp hòi
UPDATE public.vocabularies
SET example_hanzi = '他虽然平日里对自己省吃俭用，但在支援灾区救援与资助贫困学子时却从来毫不小气。',
    example_pinyin = 'Tā suīrán píngrì lǐ duì zìjǐ shěngchī-jiǎnyòng, dàn zài zhīyuán zāiqū jiùyuán yǔ zīzhù pínhán xuézǐ shí què cónglái háobù xiǎoqi.',
    example_vi = 'Ông ấy tuy ngày thường rất tằn tiện khắt khe với bản thân, nhưng khi chi viện cứu trợ vùng thiên tai và tài trợ học sinh nghèo thì chưa từng có chút keo kiệt hẹp hòi nào.'
WHERE id = '895d9584-10ca-4f62-a191-5ed177179b93' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '895d9584-10ca-4f62-a191-5ed177179b93', '他虽然平日里对自己省吃俭用，但在支援灾区救援与资助贫困学子时却从来毫不小气。', 'Tā suīrán píngrì lǐ duì zìjǐ shěngchī-jiǎnyòng, dàn zài zhīyuán zāiqū jiùyuán yǔ zīzhù pínhán xuézǐ shí què cónglái háobù xiǎoqi.', 'Ông ấy tuy ngày thường rất tằn tiện khắt khe với bản thân, nhưng khi chi viện cứu trợ vùng thiên tai và tài trợ học sinh nghèo thì chưa từng có chút keo kiệt hẹp hòi nào.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '895d9584-10ca-4f62-a191-5ed177179b93'
);

-- [细胞] (xìbāo): tế bào
UPDATE public.vocabularies
SET example_hanzi = '利用尖端冷冻电子显微镜技术，生物学家能够高精度清晰观测到活体动物神经细胞的超微精细结构。',
    example_pinyin = 'Lìyòng jiānduān lěngdòng diànzǐ xiǎnwéijìng jìshù, shēngwùxuéjiā nénggòu gāo jīngdù qīngxī guāncè dào huótǐ dòngwù shénjīng xìbāo de chāowēi jīngxì jiégòu.',
    example_vi = 'Nhờ công nghệ kính hiển vi điện tử nghiệm lạnh tiên tiến nhất, các nhà sinh học có thể quan sát rõ nét với độ chính xác cao cấu trúc siêu vi tinh tế của tế bào thần kinh động vật sống.'
WHERE id = '14a7c4f1-2e47-406e-800a-62bab0beb697' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '14a7c4f1-2e47-406e-800a-62bab0beb697', '利用尖端冷冻电子显微镜技术，生物学家能够高精度清晰观测到活体动物神经细胞的超微精细结构。', 'Lìyòng jiānduān lěngdòng diànzǐ xiǎnwéijìng jìshù, shēngwùxuéjiā nénggòu gāo jīngdù qīngxī guāncè dào huótǐ dòngwù shénjīng xìbāo de chāowēi jīngxì jiégòu.', 'Nhờ công nghệ kính hiển vi điện tử nghiệm lạnh tiên tiến nhất, các nhà sinh học có thể quan sát rõ nét với độ chính xác cao cấu trúc siêu vi tinh tế của tế bào thần kinh động vật sống.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '14a7c4f1-2e47-406e-800a-62bab0beb697'
);

-- [歇] (xiē): nghỉ ngơi
UPDATE public.vocabularies
SET example_hanzi = '烈日下挥汗如雨连续劳作了整整一个上午的农人们，纷纷来到路旁的大杨树荫下坐下来歇歇脚。',
    example_pinyin = 'Lièrì xià huīhàn-rúyǔ liánxù láozuò le zhěngzhěng yí gè shàngwǔ de nóngrén men, fēnfēn lái dào lùpáng de dà yángshù yīn xià zuò xiàlái xiē-xiē jiǎo.',
    example_vi = 'Những người nông dân mồ hôi rơi như mưa lao động liên tục suốt cả một buổi sáng dưới nắng gắt rủ nhau tới bóng râm cây dương lớn ven đường ngồi xuống nghỉ ngơi đôi chân.'
WHERE id = '7a1ec0f4-87b9-44e7-bb9e-6ecbcba207a4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7a1ec0f4-87b9-44e7-bb9e-6ecbcba207a4', '烈日下挥汗如雨连续劳作了整整一个上午的农人们，纷纷来到路旁的大杨树荫下坐下来歇歇脚。', 'Lièrì xià huīhàn-rúyǔ liánxù láozuò le zhěngzhěng yí gè shàngwǔ de nóngrén men, fēnfēn lái dào lùpáng de dà yángshù yīn xià zuò xiàlái xiē-xiē jiǎo.', 'Những người nông dân mồ hôi rơi như mưa lao động liên tục suốt cả một buổi sáng dưới nắng gắt rủ nhau tới bóng râm cây dương lớn ven đường ngồi xuống nghỉ ngơi đôi chân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7a1ec0f4-87b9-44e7-bb9e-6ecbcba207a4'
);

-- [携带] (xié dài): mang theo
UPDATE public.vocabularies
SET example_hanzi = '前往高原雪山徒步探险的旅行者，必须严格随身携带足量的应急氧气罐与保暖救生装备。',
    example_pinyin = 'Qiánwǎng gāoyuán xuěshān túbù tànxiǎn de lǚxíngzhě, bìxū yángé suíshēn xiédài zúliàng de yīngjí yǎngqìguàn yǔ bǎonuǎn jiùshēng zhuāngbèi.',
    example_vi = 'Những du khách tới cao nguyên núi tuyết cuốc bộ thám hiểm bắt buộc phải mang theo bên mình đầy đủ bình oxy cứu nạn khẩn cấp và trang thiết bị cứu sinh giữ ấm theo quy định nghiêm ngặt.'
WHERE id = '13ec341b-cc3d-46dc-ad32-86837e0cfdb1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '13ec341b-cc3d-46dc-ad32-86837e0cfdb1', '前往高原雪山徒步探险的旅行者，必须严格随身携带足量的应急氧气罐与保暖救生装备。', 'Qiánwǎng gāoyuán xuěshān túbù tànxiǎn de lǚxíngzhě, bìxū yángé suíshēn xiédài zúliàng de yīngjí yǎngqìguàn yǔ bǎonuǎn jiùshēng zhuāngbèi.', 'Những du khách tới cao nguyên núi tuyết cuốc bộ thám hiểm bắt buộc phải mang theo bên mình đầy đủ bình oxy cứu nạn khẩn cấp và trang thiết bị cứu sinh giữ ấm theo quy định nghiêm ngặt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '13ec341b-cc3d-46dc-ad32-86837e0cfdb1'
);

-- [协会] (xiéhuì): hiệp hội
UPDATE public.vocabularies
SET example_hanzi = '中国翻译协会在首都隆重举办年度行业峰会，表彰了为中外文化交流做出杰出贡献的翻译家。',
    example_pinyin = 'Zhōngguó fānyì xiéhuì zài shǒudū lóngzhòng jǔbàn niándù hángyè fēnghuì, biǎozhāng le wèi zhōng-wài wénhuà jiāoliú zuòchū jiéchū gòngxiàn de fānyìjiā.',
    example_vi = 'Hiệp hội Dịch thuật Trung Quốc đã long trọng tổ chức hội nghị thượng đỉnh ngành thường niên tại thủ đô, biểu dương các dịch giả có cống hiến kiệt xuất cho giao lưu văn hóa Trung - ngoại.'
WHERE id = 'fbada768-d18d-4502-9ecb-36a4135cb1c8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fbada768-d18d-4502-9ecb-36a4135cb1c8', '中国翻译协会在首都隆重举办年度行业峰会，表彰了为中外文化交流做出杰出贡献的翻译家。', 'Zhōngguó fānyì xiéhuì zài shǒudū lóngzhòng jǔbàn niándù hángyè fēnghuì, biǎozhāng le wèi zhōng-wài wénhuà jiāoliú zuòchū jiéchū gòngxiàn de fānyìjiā.', 'Hiệp hội Dịch thuật Trung Quốc đã long trọng tổ chức hội nghị thượng đỉnh ngành thường niên tại thủ đô, biểu dương các dịch giả có cống hiến kiệt xuất cho giao lưu văn hóa Trung - ngoại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fbada768-d18d-4502-9ecb-36a4135cb1c8'
);

-- [协调] (xiétiáo): hài hòa, điều phối
UPDATE public.vocabularies
SET example_hanzi = '跨部门联合执法工作小组必须紧密保持信息畅通，确保各项现场整治行动步调一致、密切协调。',
    example_pinyin = 'Kuà bùmén liánhé zhífǎ gōngzuò xiǎozǔ bìxū jǐnmì bǎochí xìnxī chàngtōng, quèbǎo gè xiàng xiànchǎng zhěngzhì xíngdòng bùdiào yízhì, mìqiè xiétiáo.',
    example_vi = 'Tổ công tác thực thi pháp luật liên ngành phải duy trì thông tin thông suốt chặt chẽ, bảo đảm mọi hành động chỉnh đốn tại hiện trường đều nhất quán nhịp nhàng và phối hợp điều phối khăng khít.'
WHERE id = 'c4ed45b1-00af-4266-a1db-58772d1e8775' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c4ed45b1-00af-4266-a1db-58772d1e8775', '跨部门联合执法工作小组必须紧密保持信息畅通，确保各项现场整治行动步调一致、密切协调。', 'Kuà bùmén liánhé zhífǎ gōngzuò xiǎozǔ bìxū jǐnmì bǎochí xìnxī chàngtōng, quèbǎo gè xiàng xiànchǎng zhěngzhì xíngdòng bùdiào yízhì, mìqiè xiétiáo.', 'Tổ công tác thực thi pháp luật liên ngành phải duy trì thông tin thông suốt chặt chẽ, bảo đảm mọi hành động chỉnh đốn tại hiện trường đều nhất quán nhịp nhàng và phối hợp điều phối khăng khít.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c4ed45b1-00af-4266-a1db-58772d1e8775'
);

COMMIT;
