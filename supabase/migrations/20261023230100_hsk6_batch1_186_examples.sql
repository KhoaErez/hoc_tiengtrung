-- ==============================================================================;
-- MIGRATION: 20261023230100_hsk6_batch1_186_examples.sql;
-- Nạp 186 câu ví dụ HSK 6 Đợt 1 (A - C: 岸 -> 发票) vào vocabularies và vocabulary_examples;
-- Chuẩn đề cương HSK 3.0 (CTI 11/2025), câu ví dụ văn cảnh hiện đại, Pinyin có dấu, dịch chuẩn nghĩa;
-- ==============================================================================;

BEGIN;

-- [岸] (àn): bờ
UPDATE public.vocabularies
SET example_hanzi = '轮船经过长途航行后，终于平稳地靠在了码头岸边。',
    example_pinyin = 'Lúnchuán jīngguò chángtú hángxíng hòu, zhōngyú píngwěn de kào zài le mǎtóu àn biān.',
    example_vi = 'Tàu thủy sau hành trình dài cuối cùng cũng cập bến bờ một cách êm thuận.'
WHERE id = '2294259d-924e-46a7-a036-971daab12eea' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2294259d-924e-46a7-a036-971daab12eea', '轮船经过长途航行后，终于平稳地靠在了码头岸边。', 'Lúnchuán jīngguò chángtú hángxíng hòu, zhōngyú píngwěn de kào zài le mǎtóu àn biān.', 'Tàu thủy sau hành trình dài cuối cùng cũng cập bến bờ một cách êm thuận.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2294259d-924e-46a7-a036-971daab12eea'
);

-- [按摩] (àn mó): mát-xa, xoa bóp
UPDATE public.vocabularies
SET example_hanzi = '长时间对着电脑工作后，做一次颈肩按摩能够有效缓解疲劳。',
    example_pinyin = 'Cháng shíjiān duì zhe diànnǎo gōngzuò hòu, zuò yí cì jǐngjiān ànmó nénggòu yǒuxiào huǎnjiě píláo.',
    example_vi = 'Sau thời gian dài làm việc trước máy tính, mát-xa cổ vai gáy có thể xua tan mệt mỏi hiệu quả.'
WHERE id = 'def97bb2-764f-4efd-bd4a-37e7c9258119' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'def97bb2-764f-4efd-bd4a-37e7c9258119', '长时间对着电脑工作后，做一次颈肩按摩能够有效缓解疲劳。', 'Cháng shíjiān duì zhe diànnǎo gōngzuò hòu, zuò yí cì jǐngjiān ànmó nénggòu yǒuxiào huǎnjiě píláo.', 'Sau thời gian dài làm việc trước máy tính, mát-xa cổ vai gáy có thể xua tan mệt mỏi hiệu quả.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'def97bb2-764f-4efd-bd4a-37e7c9258119'
);

-- [昂贵] (ángguì): đắt đỏ, giá cao
UPDATE public.vocabularies
SET example_hanzi = '尽管进口精密仪器的价格十分昂贵，但实验室仍决定采购两台。',
    example_pinyin = 'Jǐnguǎn jìnkǒu jīngmì yíqì de jiàgé shífēn ángguì, dàn shíyànshì réng juédìng cǎigòu liǎng tái.',
    example_vi = 'Dù giá thiết bị chính xác nhập khẩu rất đắt đỏ, phòng thí nghiệm vẫn quyết định thu mua hai chiếc.'
WHERE id = '762f59d3-6487-486f-b624-6e2b4401f091' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '762f59d3-6487-486f-b624-6e2b4401f091', '尽管进口精密仪器的价格十分昂贵，但实验室仍决定采购两台。', 'Jǐnguǎn jìnkǒu jīngmì yíqì de jiàgé shífēn ángguì, dàn shíyànshì réng juédìng cǎigòu liǎng tái.', 'Dù giá thiết bị chính xác nhập khẩu rất đắt đỏ, phòng thí nghiệm vẫn quyết định thu mua hai chiếc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '762f59d3-6487-486f-b624-6e2b4401f091'
);

-- [案例] (ànlì): án lệ, trường hợp thực tế
UPDATE public.vocabularies
SET example_hanzi = '法学教授在课堂上深入剖析了一起典型的知识产权侵权案例。',
    example_pinyin = 'Fǎxué jiàoshòu zài kètáng shang shēnrù pōuxī le yì qǐ diǎnxíng de zhīshi chǎnquán qīnquán ànlì.',
    example_vi = 'Giáo sư luật trên lớp đã phân tích sâu sắc một án lệ điển hình về xâm phạm sở hữu trí tuệ.'
WHERE id = '154dfad9-9853-4eda-b6d2-1474d04b8c9f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '154dfad9-9853-4eda-b6d2-1474d04b8c9f', '法学教授在课堂上深入剖析了一起典型的知识产权侵权案例。', 'Fǎxué jiàoshòu zài kètáng shang shēnrù pōuxī le yì qǐ diǎnxíng de zhīshi chǎnquán qīnquán ànlì.', 'Giáo sư luật trên lớp đã phân tích sâu sắc một án lệ điển hình về xâm phạm sở hữu trí tuệ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '154dfad9-9853-4eda-b6d2-1474d04b8c9f'
);

-- [暗示] (ànshì): ám chỉ, gợi ý
UPDATE public.vocabularies
SET example_hanzi = '主管通过眼神和委婉的话语，暗示大家会议应当尽快结束。',
    example_pinyin = 'Zhǔguǎn tōngguò yǎnshén hé wěiwǎn de huàyǔ, ànshì dàjiā huìyì yīngdāng jǐnkuài jiéshù.',
    example_vi = 'Chủ quản thông qua ánh mắt và lời lẽ khéo léo để ám chỉ mọi người cuộc họp nên kết thúc sớm.'
WHERE id = 'c2a3200d-dcc4-4293-88c1-8bf9a12c26fd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c2a3200d-dcc4-4293-88c1-8bf9a12c26fd', '主管通过眼神和委婉的话语，暗示大家会议应当尽快结束。', 'Zhǔguǎn tōngguò yǎnshén hé wěiwǎn de huàyǔ, ànshì dàjiā huìyì yīngdāng jǐnkuài jiéshù.', 'Chủ quản thông qua ánh mắt và lời lẽ khéo léo để ám chỉ mọi người cuộc họp nên kết thúc sớm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c2a3200d-dcc4-4293-88c1-8bf9a12c26fd'
);

-- [摆] (bǎi): bày, đặt, đung đưa
UPDATE public.vocabularies
SET example_hanzi = '会议室的长桌上整齐地摆放着参会人员的名牌和会议材料。',
    example_pinyin = 'Huìyìshì de chángzhuō shang zhěngqí de bǎi fàng zhe cānhuì rényuán de míngpái hé huìyì cáiliào.',
    example_vi = 'Trên chiếc bàn dài phòng họp xếp đặt ngay ngắn biển tên và tài liệu hội nghị của người tham dự.'
WHERE id = '0f2c9c6c-a51d-4acf-8b74-86f6130e5b91' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0f2c9c6c-a51d-4acf-8b74-86f6130e5b91', '会议室的长桌上整齐地摆放着参会人员的名牌和会议材料。', 'Huìyìshì de chángzhuō shang zhěngqí de bǎi fàng zhe cānhuì rényuán de míngpái hé huìyì cáiliào.', 'Trên chiếc bàn dài phòng họp xếp đặt ngay ngắn biển tên và tài liệu hội nghị của người tham dự.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0f2c9c6c-a51d-4acf-8b74-86f6130e5b91'
);

-- [拜访] (bài fǎng): thăm viếng
UPDATE public.vocabularies
SET example_hanzi = '趁着出差的机会，他特地前去拜访了多年未见的大学导师。',
    example_pinyin = 'Chèn zhe chūchāi de jīhuì, tā tēdì qiánqù bàifǎng le duō nián wèi jiàn de dàxué dǎoshī.',
    example_vi = 'Nhân cơ hội đi công tác, anh ấy đã đặc biệt tới thăm viếng người thầy hướng dẫn đại học nhiều năm chưa gặp.'
WHERE id = 'a33fdfcb-82fd-4861-a4bc-f7a04d07f7b5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a33fdfcb-82fd-4861-a4bc-f7a04d07f7b5', '趁着出差的机会，他特地前去拜访了多年未见的大学导师。', 'Chèn zhe chūchāi de jīhuì, tā tēdì qiánqù bàifǎng le duō nián wèi jiàn de dàxué dǎoshī.', 'Nhân cơ hội đi công tác, anh ấy đã đặc biệt tới thăm viếng người thầy hướng dẫn đại học nhiều năm chưa gặp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a33fdfcb-82fd-4861-a4bc-f7a04d07f7b5'
);

-- [拜年] (bài nián): chúc Tết
UPDATE public.vocabularies
SET example_hanzi = '大年初一清晨，晚辈们穿戴一新，纷纷向长辈登门拜年。',
    example_pinyin = 'Dànián chūyī qīngchén, wǎnbèi men chuāndài yī xīn, fēnfēn xiàng zhǎngbèi dēngmén bàinián.',
    example_vi = 'Sáng mùng một Tết, các hậu bối xúng xính quần áo mới lũ lượt đến nhà chúc Tết các bậc tiền bối.'
WHERE id = '37a08168-1937-4352-802e-d798eb332b99' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '37a08168-1937-4352-802e-d798eb332b99', '大年初一清晨，晚辈们穿戴一新，纷纷向长辈登门拜年。', 'Dànián chūyī qīngchén, wǎnbèi men chuāndài yī xīn, fēnfēn xiàng zhǎngbèi dēngmén bàinián.', 'Sáng mùng một Tết, các hậu bối xúng xính quần áo mới lũ lượt đến nhà chúc Tết các bậc tiền bối.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '37a08168-1937-4352-802e-d798eb332b99'
);

-- [摆脱] (bǎi tuō): thoát khỏi, dứt ra
UPDATE public.vocabularies
SET example_hanzi = '这家传统制造企业通过技术革新，终于摆脱了持续亏损的困境。',
    example_pinyin = 'Zhè jiā chuántǒng zhìzào qǐyè tōngguò jìshù géxīn, zhōngyú bǎituō le chíxù kuīsǔn de kùnjìng.',
    example_vi = 'Doanh nghiệp sản xuất truyền thống này nhờ cải tiến kỹ thuật mà cuối cùng đã thoát khỏi cảnh thua lỗ kéo dài.'
WHERE id = '6f390446-733b-4d8a-aa7f-82fa83f86834' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6f390446-733b-4d8a-aa7f-82fa83f86834', '这家传统制造企业通过技术革新，终于摆脱了持续亏损的困境。', 'Zhè jiā chuántǒng zhìzào qǐyè tōngguò jìshù géxīn, zhōngyú bǎituō le chíxù kuīsǔn de kùnjìng.', 'Doanh nghiệp sản xuất truyền thống này nhờ cải tiến kỹ thuật mà cuối cùng đã thoát khỏi cảnh thua lỗ kéo dài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6f390446-733b-4d8a-aa7f-82fa83f86834'
);

-- [版本] (bǎnběn): phiên bản
UPDATE public.vocabularies
SET example_hanzi = '软件工程师正在为手机应用测试最新版本，以修复已知漏洞。',
    example_pinyin = 'Ruǎnjiàn gōngchéngshī zhèngzài wèi shǒujī yìngyòng cèshì zuìxīn bǎnběn, yǐ xiūfù yǐzhī lòudòng.',
    example_vi = 'Kỹ sư phần mềm đang kiểm thử phiên bản mới nhất cho ứng dụng di động nhằm khắc phục các lỗ hổng đã biết.'
WHERE id = 'c255ba5a-dff6-4bd2-a1bd-a9781fd3407c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c255ba5a-dff6-4bd2-a1bd-a9781fd3407c', '软件工程师正在为手机应用测试最新版本，以修复已知漏洞。', 'Ruǎnjiàn gōngchéngshī zhèngzài wèi shǒujī yìngyòng cèshì zuìxīn bǎnběn, yǐ xiūfù yǐzhī lòudòng.', 'Kỹ sư phần mềm đang kiểm thử phiên bản mới nhất cho ứng dụng di động nhằm khắc phục các lỗ hổng đã biết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c255ba5a-dff6-4bd2-a1bd-a9781fd3407c'
);

-- [榜样] (bǎngyàng): tấm gương, hình mẫu
UPDATE public.vocabularies
SET example_hanzi = '张医生在抗击疫情中舍己救人，成为了全院青年医护的榜样。',
    example_pinyin = 'Zhāng yīshēng zài kàngjī yìqíng zhōng shějǐ jiùrén, chéngwéi le quányuàn qīngnián yīhù de bǎngyàng.',
    example_vi = 'Bác sĩ Trương quên mình cứu người trong đợt chống dịch đã trở thành tấm gương cho các y bác sĩ trẻ toàn viện.'
WHERE id = 'e47139b7-d6ca-4d4e-8ca2-e9398a62c2bf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e47139b7-d6ca-4d4e-8ca2-e9398a62c2bf', '张医生在抗击疫情中舍己救人，成为了全院青年医护的榜样。', 'Zhāng yīshēng zài kàngjī yìqíng zhōng shějǐ jiùrén, chéngwéi le quányuàn qīngnián yīhù de bǎngyàng.', 'Bác sĩ Trương quên mình cứu người trong đợt chống dịch đã trở thành tấm gương cho các y bác sĩ trẻ toàn viện.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e47139b7-d6ca-4d4e-8ca2-e9398a62c2bf'
);

-- [伴随] (bànsuí): đi kèm, kèm theo, đi cùng
UPDATE public.vocabularies
SET example_hanzi = '经济全球化的深入发展，往往伴随着复杂多元的国际文化交流。',
    example_pinyin = 'Jīngjì quánqiúhuà de shēnrù fāzhǎn, wǎngwǎng bànsuí zhe fùzá duōyuán de guójì wénhuà jiāoliú.',
    example_vi = 'Sự phát triển sâu rộng của toàn cầu hóa kinh tế thường đi kèm với những giao lưu văn hóa quốc tế đa dạng phức tạp.'
WHERE id = 'a16118f3-b623-4264-87a9-6f829825b852' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a16118f3-b623-4264-87a9-6f829825b852', '经济全球化的深入发展，往往伴随着复杂多元的国际文化交流。', 'Jīngjì quánqiúhuà de shēnrù fāzhǎn, wǎngwǎng bànsuí zhe fùzá duōyuán de guójì wénhuà jiāoliú.', 'Sự phát triển sâu rộng của toàn cầu hóa kinh tế thường đi kèm với những giao lưu văn hóa quốc tế đa dạng phức tạp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a16118f3-b623-4264-87a9-6f829825b852'
);

-- [扮演] (bànyǎn): đóng vai, sắm vai
UPDATE public.vocabularies
SET example_hanzi = '中小微企业在促进国家就业和推动科技创新方面扮演着重要角色。',
    example_pinyin = 'Zhōng xiǎo wēi qǐyè zài cùjìn guójiā jiùyè hé tuīdòng kējì chuàngxīn fāngmiàn bànyǎn zhe zhòngyào juésè.',
    example_vi = 'Các doanh nghiệp vừa và nhỏ đóng vai trò quan trọng trong việc thúc đẩy việc làm quốc gia và đổi mới công nghệ.'
WHERE id = 'c6d30d9d-66ca-4862-a4d3-79c83f72c376' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c6d30d9d-66ca-4862-a4d3-79c83f72c376', '中小微企业在促进国家就业和推动科技创新方面扮演着重要角色。', 'Zhōng xiǎo wēi qǐyè zài cùjìn guójiā jiùyè hé tuīdòng kējì chuàngxīn fāngmiàn bànyǎn zhe zhòngyào juésè.', 'Các doanh nghiệp vừa và nhỏ đóng vai trò quan trọng trong việc thúc đẩy việc làm quốc gia và đổi mới công nghệ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c6d30d9d-66ca-4862-a4d3-79c83f72c376'
);

-- [爆发] (bàofā): bùng nổ, bùng phát
UPDATE public.vocabularies
SET example_hanzi = '由于长期矛盾积累，该地区不可避免地爆发了一场局部经济冲突。',
    example_pinyin = 'Yóuyú chángqī máodùn jīlěi, gāi dìqū bùkě bìmiǎn de bàofā le yì chǎng júbù jīngjì chōngtū.',
    example_vi = 'Do mâu thuẫn tích tụ lâu ngày, khu vực này không thể tránh khỏi bùng phát một cuộc xung đột kinh tế cục bộ.'
WHERE id = '8032b80e-b5fd-4cea-9270-2dbdcfe50d7b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8032b80e-b5fd-4cea-9270-2dbdcfe50d7b', '由于长期矛盾积累，该地区不可避免地爆发了一场局部经济冲突。', 'Yóuyú chángqī máodùn jīlěi, gāi dìqū bùkě bìmiǎn de bàofā le yì chǎng júbù jīngjì chōngtū.', 'Do mâu thuẫn tích tụ lâu ngày, khu vực này không thể tránh khỏi bùng phát một cuộc xung đột kinh tế cục bộ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8032b80e-b5fd-4cea-9270-2dbdcfe50d7b'
);

-- [保管] (bǎoguǎn): bảo quản, trông coi; chắc chắn
UPDATE public.vocabularies
SET example_hanzi = '贵重物品请务必妥善保管，退房前请再次检查个人行李。',
    example_pinyin = 'Guìzhòng wùpǐn qǐng wùbì tuǒshàn bǎoguǎn, tuìfáng qián qǐng zàicì jiǎnchá gèrén xíngli.',
    example_vi = 'Đồ đạc quý giá xin nhất thiết bảo quản cẩn thận, trước khi trả phòng xin vui lòng kiểm tra lại hành lý cá nhân.'
WHERE id = 'bc632413-6c9b-48ab-a2ac-37067e214889' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bc632413-6c9b-48ab-a2ac-37067e214889', '贵重物品请务必妥善保管，退房前请再次检查个人行李。', 'Guìzhòng wùpǐn qǐng wùbì tuǒshàn bǎoguǎn, tuìfáng qián qǐng zàicì jiǎnchá gèrén xíngli.', 'Đồ đạc quý giá xin nhất thiết bảo quản cẩn thận, trước khi trả phòng xin vui lòng kiểm tra lại hành lý cá nhân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bc632413-6c9b-48ab-a2ac-37067e214889'
);

-- [暴力] (bàolì): bạo lực
UPDATE public.vocabularies
SET example_hanzi = '任何以暴力手段解决争端的行为，都将受到法律的严厉制裁。',
    example_pinyin = 'Rènhé yǐ bàolì shǒuduàn jiějué zhēngduān de xíngwéi, dōu jiāng shòudào fǎlǜ de yánlì zhìcái.',
    example_vi = 'Bất kỳ hành vi nào dùng thủ đoạn bạo lực để giải quyết tranh chấp đều sẽ chịu sự chế tài nghiêm khắc của pháp luật.'
WHERE id = 'c0a41487-4b3e-453a-ab57-0b17e1653105' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c0a41487-4b3e-453a-ab57-0b17e1653105', '任何以暴力手段解决争端的行为，都将受到法律的严厉制裁。', 'Rènhé yǐ bàolì shǒuduàn jiějué zhēngduān de xíngwéi, dōu jiāng shòudào fǎlǜ de yánlì zhìcái.', 'Bất kỳ hành vi nào dùng thủ đoạn bạo lực để giải quyết tranh chấp đều sẽ chịu sự chế tài nghiêm khắc của pháp luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c0a41487-4b3e-453a-ab57-0b17e1653105'
);

-- [暴露] (bàolù): bộc lộ, phơi bày
UPDATE public.vocabularies
SET example_hanzi = '这次突击安全检查暴露出该工厂在消防管理上的诸多薄弱环节。',
    example_pinyin = 'Zhè cì tūjī ānquán jiǎnchá bàolù chū gāi gōngchǎng zài xiāofáng guǎnlǐ shang de zhūduō bóruò huánjié.',
    example_vi = 'Cuộc kiểm tra an toàn đột xuất này đã phơi bày rất nhiều khâu yếu kém trong công tác quản lý phòng cháy chữa cháy của nhà máy.'
WHERE id = '44f2af56-cceb-4f92-bf5c-0bcd7b686cfc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '44f2af56-cceb-4f92-bf5c-0bcd7b686cfc', '这次突击安全检查暴露出该工厂在消防管理上的诸多薄弱环节。', 'Zhè cì tūjī ānquán jiǎnchá bàolù chū gāi gōngchǎng zài xiāofáng guǎnlǐ shang de zhūduō bóruò huánjié.', 'Cuộc kiểm tra an toàn đột xuất này đã phơi bày rất nhiều khâu yếu kém trong công tác quản lý phòng cháy chữa cháy của nhà máy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '44f2af56-cceb-4f92-bf5c-0bcd7b686cfc'
);

-- [报社] (bàoshè): tòa soạn báo
UPDATE public.vocabularies
SET example_hanzi = '这位资深记者已经在省城最大的报社辛勤工作了整整二十年。',
    example_pinyin = 'Zhè wèi zīshēn jìzhě yǐjīng zài shěngchéng zuì dà de bàoshè xīnqín gōngzuò le zhěngzhěng èrshí nián.',
    example_vi = 'Vị phóng viên kỳ cựu này đã làm việc chăm chỉ tại tòa soạn báo lớn nhất tỉnh lỵ đúng hai mươi năm.'
WHERE id = '305f532b-f3f7-42cd-8f71-f8591e2ba947' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '305f532b-f3f7-42cd-8f71-f8591e2ba947', '这位资深记者已经在省城最大的报社辛勤工作了整整二十年。', 'Zhè wèi zīshēn jìzhě yǐjīng zài shěngchéng zuì dà de bàoshè xīnqín gōngzuò le zhěngzhěng èrshí nián.', 'Vị phóng viên kỳ cựu này đã làm việc chăm chỉ tại tòa soạn báo lớn nhất tỉnh lỵ đúng hai mươi năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '305f532b-f3f7-42cd-8f71-f8591e2ba947'
);

-- [爆炸] (bàozhà): nổ tung
UPDATE public.vocabularies
SET example_hanzi = '化工厂车间突发燃气爆炸，消防队员在五分钟内赶到了现场。',
    example_pinyin = 'Huàgōngchǎng chējiān tūfā ránqì bàozhà, xiāofáng duìyuán zài wǔ fēnzhōng nèi gǎndào le xiànchǎng.',
    example_vi = 'Phân xưởng nhà máy hóa chất đột nhiên phát nổ khí gas, lực lượng cứu hỏa đã có mặt tại hiện trường trong vòng 5 phút.'
WHERE id = 'd4b8eadd-7f03-4abc-838c-688660b9ac53' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd4b8eadd-7f03-4abc-838c-688660b9ac53', '化工厂车间突发燃气爆炸，消防队员在五分钟内赶到了现场。', 'Huàgōngchǎng chējiān tūfā ránqì bàozhà, xiāofáng duìyuán zài wǔ fēnzhōng nèi gǎndào le xiànchǎng.', 'Phân xưởng nhà máy hóa chất đột nhiên phát nổ khí gas, lực lượng cứu hỏa đã có mặt tại hiện trường trong vòng 5 phút.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd4b8eadd-7f03-4abc-838c-688660b9ac53'
);

-- [保障] (bǎozhàng): bảo đảm, bảo hộ
UPDATE public.vocabularies
SET example_hanzi = '健全的社会保障制度是维护社会公平与民生稳定的重要基石。',
    example_pinyin = 'Jiànquán de shèhuì bǎozhàng zhìdù shì wéihù shèhuì gōngpíng yǔ mínshēng wěndìng de zhòngyào jīshí.',
    example_vi = 'Chế độ bảo đảm an sinh xã hội hoàn thiện là nền tảng quan trọng bảo vệ sự công bằng xã hội và ổn định dân sinh.'
WHERE id = '6ecea74b-00cf-4261-b647-06a75483c12e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6ecea74b-00cf-4261-b647-06a75483c12e', '健全的社会保障制度是维护社会公平与民生稳定的重要基石。', 'Jiànquán de shèhuì bǎozhàng zhìdù shì wéihù shèhuì gōngpíng yǔ mínshēng wěndìng de zhòngyào jīshí.', 'Chế độ bảo đảm an sinh xã hội hoàn thiện là nền tảng quan trọng bảo vệ sự công bằng xã hội và ổn định dân sinh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6ecea74b-00cf-4261-b647-06a75483c12e'
);

-- [被动] (bèidòng): bị động
UPDATE public.vocabularies
SET example_hanzi = '在激烈的市场竞争中，企业若不主动求变，就会陷入被动局面。',
    example_pinyin = 'Zài jīliè de shìchǎng jìngzhēng zhōng, qǐyè ruò bù zhǔdòng qiúbiàn, jiù huì xiànrù bèidòng júmiàn.',
    example_vi = 'Trong cuộc cạnh tranh thị trường gay gắt, doanh nghiệp nếu không chủ động đổi mới thì sẽ rơi vào tình thế bị động.'
WHERE id = 'c9cdd411-9b17-4fa1-b8cf-fb15f4c1ac21' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c9cdd411-9b17-4fa1-b8cf-fb15f4c1ac21', '在激烈的市场竞争中，企业若不主动求变，就会陷入被动局面。', 'Zài jīliè de shìchǎng jìngzhēng zhōng, qǐyè ruò bù zhǔdòng qiúbiàn, jiù huì xiànrù bèidòng júmiàn.', 'Trong cuộc cạnh tranh thị trường gay gắt, doanh nghiệp nếu không chủ động đổi mới thì sẽ rơi vào tình thế bị động.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c9cdd411-9b17-4fa1-b8cf-fb15f4c1ac21'
);

-- [悲观] (bēiguān): bi quan
UPDATE public.vocabularies
SET example_hanzi = '面对创业过程中的挫折，我们应当保持乐观积极，绝不能过于悲观。',
    example_pinyin = 'Miànduì chuàngyè guòchéng zhōng de cuòzhé, wǒmen yīngdāng bǎochí lèguān jījí, jué bùnéng guòyú bēiguān.',
    example_vi = 'Đối mặt với những trắc trở trong quá trình lập nghiệp, chúng ta nên giữ tinh thần lạc quan tích cực, tuyệt đối không nên quá bi quan.'
WHERE id = '1109c957-c5e6-4121-b5ef-7b43fbc23127' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1109c957-c5e6-4121-b5ef-7b43fbc23127', '面对创业过程中的挫折，我们应当保持乐观积极，绝不能过于悲观。', 'Miànduì chuàngyè guòchéng zhōng de cuòzhé, wǒmen yīngdāng bǎochí lèguān jījí, jué bùnéng guòyú bēiguān.', 'Đối mặt với những trắc trở trong quá trình lập nghiệp, chúng ta nên giữ tinh thần lạc quan tích cực, tuyệt đối không nên quá bi quan.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1109c957-c5e6-4121-b5ef-7b43fbc23127'
);

-- [北极] (Běijí): Bắc cực
UPDATE public.vocabularies
SET example_hanzi = '由于全球气候持续变暖，北极地区的冰川正在以惊人的速度消融。',
    example_pinyin = 'Yóuyú quánqiú qìhòu chíxù biànnuǎn, Běijí dìqū de bīngchuān zhèngzài yǐ jīngrén de sùdù xiāoróng.',
    example_vi = 'Do khí hậu toàn cầu tiếp tục ấm lên, các dòng sông băng ở vùng Bắc cực đang tan chảy với tốc độ đáng kinh ngạc.'
WHERE id = 'f54e0be3-1f68-4ea3-bab0-0ef4e9336ab5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f54e0be3-1f68-4ea3-bab0-0ef4e9336ab5', '由于全球气候持续变暖，北极地区的冰川正在以惊人的速度消融。', 'Yóuyú quánqiú qìhòu chíxù biànnuǎn, Běijí dìqū de bīngchuān zhèngzài yǐ jīngrén de sùdù xiāoróng.', 'Do khí hậu toàn cầu tiếp tục ấm lên, các dòng sông băng ở vùng Bắc cực đang tan chảy với tốc độ đáng kinh ngạc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f54e0be3-1f68-4ea3-bab0-0ef4e9336ab5'
);

-- [本能] (běnnéng): bản năng
UPDATE public.vocabularies
SET example_hanzi = '保护年幼的孩子不受伤害，是每一位母亲出于母爱的本能反应。',
    example_pinyin = 'Bǎohù niányòu de háizi bú shòu shānghài, shì měi yí wèi mǔqīn chūyú mǔ''ài de běnnéng fǎnyìng.',
    example_vi = 'Bảo vệ đứa con thơ khỏi bị thương tổn là phản ứng bản năng xuất phát từ tình mẫu tử của mỗi người mẹ.'
WHERE id = '632603dd-d929-4463-8456-85dbb6ef8091' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '632603dd-d929-4463-8456-85dbb6ef8091', '保护年幼的孩子不受伤害，是每一位母亲出于母爱的本能反应。', 'Bǎohù niányòu de háizi bú shòu shānghài, shì měi yí wèi mǔqīn chūyú mǔ''ài de běnnéng fǎnyìng.', 'Bảo vệ đứa con thơ khỏi bị thương tổn là phản ứng bản năng xuất phát từ tình mẫu tử của mỗi người mẹ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '632603dd-d929-4463-8456-85dbb6ef8091'
);

-- [本身] (běnshēn): bản thân, tự nó
UPDATE public.vocabularies
SET example_hanzi = '这项科学研究本身并不复杂，关键在于实验数据的精准度和严谨性。',
    example_pinyin = 'Zhè xiàng kēxué yánjiū běnshēn bìng bù fùzá, guānjiàn zàiyú shíyàn shùjù de jīngzhǔndù hé yánjǐnxìng.',
    example_vi = 'Bản thân công trình nghiên cứu khoa học này không phức tạp, mấu chốt nằm ở độ chuẩn xác và tính nghiêm ngặt của số liệu thí nghiệm.'
WHERE id = 'e4382e0e-7c5e-4652-881e-f350a75d3714' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e4382e0e-7c5e-4652-881e-f350a75d3714', '这项科学研究本身并不复杂，关键在于实验数据的精准度和严谨性。', 'Zhè xiàng kēxué yánjiū běnshēn bìng bù fùzá, guānjiàn zàiyú shíyàn shùjù de jīngzhǔndù hé yánjǐnxìng.', 'Bản thân công trình nghiên cứu khoa học này không phức tạp, mấu chốt nằm ở độ chuẩn xác và tính nghiêm ngặt của số liệu thí nghiệm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e4382e0e-7c5e-4652-881e-f350a75d3714'
);

-- [编辑] (biānjí): biên tập, biên tập viên
UPDATE public.vocabularies
SET example_hanzi = '出版社的资深编辑正在对这部长篇学术专著的初稿进行全面校对。',
    example_pinyin = 'Chūbǎnshè de zīshēn biānjí zhèngzài duì zhè bù chángpiān xuéshù zhuānzhù de chūgǎo jìnxíng quánmiàn jiàoduì.',
    example_vi = 'Biên tập viên kỳ cựu của nhà xuất bản đang tiến hành hiệu đính toàn diện bản thảo đầu tiên của chuyên khảo học thuật dài tập này.'
WHERE id = '3a46cb0a-bfab-4385-a6a9-2334505b053b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3a46cb0a-bfab-4385-a6a9-2334505b053b', '出版社的资深编辑正在对这部长篇学术专著的初稿进行全面校对。', 'Chūbǎnshè de zīshēn biānjí zhèngzài duì zhè bù chángpiān xuéshù zhuānzhù de chūgǎo jìnxíng quánmiàn jiàoduì.', 'Biên tập viên kỳ cựu của nhà xuất bản đang tiến hành hiệu đính toàn diện bản thảo đầu tiên của chuyên khảo học thuật dài tập này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3a46cb0a-bfab-4385-a6a9-2334505b053b'
);

-- [变质] (biànzhì): biến chất, ôi thiu
UPDATE public.vocabularies
SET example_hanzi = '夏天高温潮湿，吃剩的饭菜如果放在常温下极容易腐烂变质。',
    example_pinyin = 'Xiàtiān gāowēn cháoshī, chī shèng de fàncài rúguǒ fàng zài chángwēn xià jí róngyì fǔlàn biànzhì.',
    example_vi = 'Mùa hè nhiệt độ cao và ẩm ướt, thức ăn thừa nếu để ở nhiệt độ thường rất dễ ôi thiu biến chất.'
WHERE id = '3636ef74-8c51-4bbb-9426-83424ecf0216' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3636ef74-8c51-4bbb-9426-83424ecf0216', '夏天高温潮湿，吃剩的饭菜如果放在常温下极容易腐烂变质。', 'Xiàtiān gāowēn cháoshī, chī shèng de fàncài rúguǒ fàng zài chángwēn xià jí róngyì fǔlàn biànzhì.', 'Mùa hè nhiệt độ cao và ẩm ướt, thức ăn thừa nếu để ở nhiệt độ thường rất dễ ôi thiu biến chất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3636ef74-8c51-4bbb-9426-83424ecf0216'
);

-- [比方] (bǐfang): ví dụ, ví von
UPDATE public.vocabularies
SET example_hanzi = '为了让大家更容易理解相对论，老师在黑板上打了一个生动的比方。',
    example_pinyin = 'Wèile ràng dàjiā gèng róngyì lǐjiě xiāngduìlùn, lǎoshī zài hēibǎn shang dǎ le yí gè shēngdòng de bǐfang.',
    example_vi = 'Để mọi người dễ hiểu thuyết tương đối hơn, thầy giáo đã đưa ra một ví von sinh động trên bảng đen.'
WHERE id = '92fa37c1-09cb-43ab-8682-9671f933cd4f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '92fa37c1-09cb-43ab-8682-9671f933cd4f', '为了让大家更容易理解相对论，老师在黑板上打了一个生动的比方。', 'Wèile ràng dàjiā gèng róngyì lǐjiě xiāngduìlùn, lǎoshī zài hēibǎn shang dǎ le yí gè shēngdòng de bǐfang.', 'Để mọi người dễ hiểu thuyết tương đối hơn, thầy giáo đã đưa ra một ví von sinh động trên bảng đen.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '92fa37c1-09cb-43ab-8682-9671f933cd4f'
);

-- [病毒] (bìngdú): vi-rút
UPDATE public.vocabularies
SET example_hanzi = '医学研究所正在全力攻关，研制针对这种新型呼吸道病毒的疫苗。',
    example_pinyin = 'Yīxué yánjiūsuǒ zhèngzài quánlì gōngguān, yánzhì zhēnduì zhè zhǒng xīnxíng hūxīdào bìngdú de yìmiáo.',
    example_vi = 'Viện nghiên cứu y học đang dốc toàn lực nghiên cứu phát triển vắc-xin phòng chống loại vi-rút đường hô hấp mới này.'
WHERE id = 'ca13b11d-76d4-4672-a09f-16af1e356cc8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ca13b11d-76d4-4672-a09f-16af1e356cc8', '医学研究所正在全力攻关，研制针对这种新型呼吸道病毒的疫苗。', 'Yīxué yánjiūsuǒ zhèngzài quánlì gōngguān, yánzhì zhēnduì zhè zhǒng xīnxíng hūxīdào bìngdú de yìmiáo.', 'Viện nghiên cứu y học đang dốc toàn lực nghiên cứu phát triển vắc-xin phòng chống loại vi-rút đường hô hấp mới này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ca13b11d-76d4-4672-a09f-16af1e356cc8'
);

-- [比重] (bǐzhòng): tỷ trọng
UPDATE public.vocabularies
SET example_hanzi = '随着高新技术产业的飞速发展，服务业在国民经济中的比重逐年提高。',
    example_pinyin = 'Suízhe gāoxīn jìshù chǎnyè de fēisù fāzhǎn, fúwùyè zài guómín jīngjì zhōng de bǐzhòng zhúnián tígāo.',
    example_vi = 'Cùng với sự phát triển thần tốc của ngành công nghệ cao, tỷ trọng ngành dịch vụ trong nền kinh tế quốc dân tăng lên từng năm.'
WHERE id = 'c715871d-d36f-492d-9297-cfe49e022b15' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c715871d-d36f-492d-9297-cfe49e022b15', '随着高新技术产业的飞速发展，服务业在国民经济中的比重逐年提高。', 'Suízhe gāoxīn jìshù chǎnyè de fēisù fāzhǎn, fúwùyè zài guómín jīngjì zhōng de bǐzhòng zhúnián tígāo.', 'Cùng với sự phát triển thần tốc của ngành công nghệ cao, tỷ trọng ngành dịch vụ trong nền kinh tế quốc dân tăng lên từng năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c715871d-d36f-492d-9297-cfe49e022b15'
);

-- [博览会] (bólǎnhuì): hội chợ triển lãm
UPDATE public.vocabularies
SET example_hanzi = '来自全球五十多个国家和地区的企业代表参加了本次国际进口博览会。',
    example_pinyin = 'Láizì quánqiú wǔshí duō gè guójiā hé dìqū de qǐyè dàibiǎo cānjiā le běncì guójì jìnkǒu bólǎnhuì.',
    example_vi = 'Đại diện doanh nghiệp đến từ hơn 50 quốc gia và vùng lãnh thổ trên toàn cầu đã tham gia hội chợ triển lãm nhập khẩu quốc tế lần này.'
WHERE id = '7ec4ddc9-b64e-409d-a241-e82088f41b22' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7ec4ddc9-b64e-409d-a241-e82088f41b22', '来自全球五十多个国家和地区的企业代表参加了本次国际进口博览会。', 'Láizì quánqiú wǔshí duō gè guójiā hé dìqū de qǐyè dàibiǎo cānjiā le běncì guójì jìnkǒu bólǎnhuì.', 'Đại diện doanh nghiệp đến từ hơn 50 quốc gia và vùng lãnh thổ trên toàn cầu đã tham gia hội chợ triển lãm nhập khẩu quốc tế lần này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7ec4ddc9-b64e-409d-a241-e82088f41b22'
);

-- [薄弱] (bóruò): yếu kém, mỏng manh
UPDATE public.vocabularies
SET example_hanzi = '乡村学校的基础设施较为薄弱，需要社会各界给予更多的资源倾斜。',
    example_pinyin = 'Xiāngcūn xuéxiào de jīchǔ shèshī jiàowéi bóruò, xūyào shèhuì gèjiè jǐyǔ gèng duō de zīyuán qīngxié.',
    example_vi = 'Cơ sở hạ tầng của các trường học nông thôn còn tương đối mỏng manh yếu kém, cần các giới trong xã hội dành thêm nhiều nguồn lực hỗ trợ.'
WHERE id = '7e78cd6c-2410-4c4b-b179-395b3b6dbca5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7e78cd6c-2410-4c4b-b179-395b3b6dbca5', '乡村学校的基础设施较为薄弱，需要社会各界给予更多的资源倾斜。', 'Xiāngcūn xuéxiào de jīchǔ shèshī jiàowéi bóruò, xūyào shèhuì gèjiè jǐyǔ gèng duō de zīyuán qīngxié.', 'Cơ sở hạ tầng của các trường học nông thôn còn tương đối mỏng manh yếu kém, cần các giới trong xã hội dành thêm nhiều nguồn lực hỗ trợ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7e78cd6c-2410-4c4b-b179-395b3b6dbca5'
);

-- [播种] (bōzhòng): gieo hạt, gieo giống
UPDATE public.vocabularies
SET example_hanzi = '春回大地，勤劳的农民抢抓农时，在广阔的田野上辛勤播种希望。',
    example_pinyin = 'Chūnhuí-dàdì, qínláo de nóngmín qiǎng zhuā nóngshí, zài guǎngkuò de tiányě shang xīnqín bōzhòng xīwàng.',
    example_vi = 'Xuân về trên đất mẹ, những người nông dân cần cù tranh thủ mùa vụ, chăm chỉ gieo hạt giống niềm tin trên những cánh đồng rộng lớn.'
WHERE id = '6f75bd5d-02a1-4230-bbda-087962de4a1d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6f75bd5d-02a1-4230-bbda-087962de4a1d', '春回大地，勤劳的农民抢抓农时，在广阔的田野上辛勤播种希望。', 'Chūnhuí-dàdì, qínláo de nóngmín qiǎng zhuā nóngshí, zài guǎngkuò de tiányě shang xīnqín bōzhòng xīwàng.', 'Xuân về trên đất mẹ, những người nông dân cần cù tranh thủ mùa vụ, chăm chỉ gieo hạt giống niềm tin trên những cánh đồng rộng lớn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6f75bd5d-02a1-4230-bbda-087962de4a1d'
);

-- [脖子] (bózi): cổ
UPDATE public.vocabularies
SET example_hanzi = '冬天寒风刺骨，出门前她特地系上了一条保暖的羊毛围巾护住脖子。',
    example_pinyin = 'Dōngtiān hánfēng cìgǔ, chūmén qián tā tēdì jì shang le yì tiáo bǎonuǎn de yángmáo wéijīn hù zhù bózi.',
    example_vi = 'Mùa đông gió lạnh thấu xương, trước khi ra ngoài cô ấy đặc biệt quàng một chiếc khăn len ấm áp để che chắn cổ.'
WHERE id = '90df21ad-bf6f-4e72-a73f-e770c2fc8a7a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '90df21ad-bf6f-4e72-a73f-e770c2fc8a7a', '冬天寒风刺骨，出门前她特地系上了一条保暖的羊毛围巾护住脖子。', 'Dōngtiān hánfēng cìgǔ, chūmén qián tā tēdì jì shang le yì tiáo bǎonuǎn de yángmáo wéijīn hù zhù bózi.', 'Mùa đông gió lạnh thấu xương, trước khi ra ngoài cô ấy đặc biệt quàng một chiếc khăn len ấm áp để che chắn cổ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '90df21ad-bf6f-4e72-a73f-e770c2fc8a7a'
);

-- [布] (bù): vải
UPDATE public.vocabularies
SET example_hanzi = '老裁缝用这匹质地细腻的纯棉布料，为客人定做了一套合身的长衫。',
    example_pinyin = 'Lǎo cáifeng yòng zhè pǐ zhìdì xìnì de chúnmián bùliào, wèi kèrén dìngzuò le yí tào héshēn de chángshān.',
    example_vi = 'Người thợ may già dùng sấp vải cotton nguyên chất mịn màng này may đo cho khách một bộ áo dài vừa vặn.'
WHERE id = '9af4758b-66f9-410f-8cad-6365c075ee7c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9af4758b-66f9-410f-8cad-6365c075ee7c', '老裁缝用这匹质地细腻的纯棉布料，为客人定做了一套合身的长衫。', 'Lǎo cáifeng yòng zhè pǐ zhìdì xìnì de chúnmián bùliào, wèi kèrén dìngzuò le yí tào héshēn de chángshān.', 'Người thợ may già dùng sấp vải cotton nguyên chất mịn màng này may đo cho khách một bộ áo dài vừa vặn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9af4758b-66f9-410f-8cad-6365c075ee7c'
);

-- [不顾] (bú gù): bất chấp, không màng
UPDATE public.vocabularies
SET example_hanzi = '年轻的消防员不顾个人安危，冒着滚滚浓烟三次冲入火场搜救群众。',
    example_pinyin = 'Niánqīng de xiāofángyuán búgù gèrén ānwēi, mào zhe gǔngǔn nóngyān sān cì chōng rù huǒchǎng sōujiù qúnzhòng.',
    example_vi = 'Người lính cứu hỏa trẻ tuổi không màng an nguy bản thân, xông pha vào làn khói cuồn cuộn ba lần để tìm kiếm cứu nạn quần chúng.'
WHERE id = '6fe36171-711c-407e-92fe-96233c7009cc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6fe36171-711c-407e-92fe-96233c7009cc', '年轻的消防员不顾个人安危，冒着滚滚浓烟三次冲入火场搜救群众。', 'Niánqīng de xiāofángyuán búgù gèrén ānwēi, mào zhe gǔngǔn nóngyān sān cì chōng rù huǒchǎng sōujiù qúnzhòng.', 'Người lính cứu hỏa trẻ tuổi không màng an nguy bản thân, xông pha vào làn khói cuồn cuộn ba lần để tìm kiếm cứu nạn quần chúng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6fe36171-711c-407e-92fe-96233c7009cc'
);

-- [不禁] (bù jīn): không kìm được, bất giác
UPDATE public.vocabularies
SET example_hanzi = '看到老朋友在异国他乡取得如此巨大的成就，大家不禁为他拍手喝彩。',
    example_pinyin = 'Kàndào lǎo péngyou zài yìguó tāxiāng qǔdé rúcǐ jùdà de chéngjiù, dàjiā bùjīn wèi tā pāishǒu hècǎi.',
    example_vi = 'Nhìn thấy người bạn cũ nơi xứ người gặt hái được thành tựu to lớn nhường ấy, mọi người bất giác vỗ tay reo hò chúc mừng.'
WHERE id = '9abb54d5-2542-4065-a622-e727de8b5e5e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9abb54d5-2542-4065-a622-e727de8b5e5e', '看到老朋友在异国他乡取得如此巨大的成就，大家不禁为他拍手喝彩。', 'Kàndào lǎo péngyou zài yìguó tāxiāng qǔdé rúcǐ jùdà de chéngjiù, dàjiā bùjīn wèi tā pāishǒu hècǎi.', 'Nhìn thấy người bạn cũ nơi xứ người gặt hái được thành tựu to lớn nhường ấy, mọi người bất giác vỗ tay reo hò chúc mừng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9abb54d5-2542-4065-a622-e727de8b5e5e'
);

-- [不料] (bú liào): không ngờ, chẳng ngờ
UPDATE public.vocabularies
SET example_hanzi = '今天早晨天空本来晴空万里，不料午后突然电闪雷鸣下起了暴雨。',
    example_pinyin = 'Jīntiān zǎochén tiānkōng běnlái qíngkōng-wànlǐ, búliào wǔhòu tūrán diànshǎn-léimíng xià qǐ le bàoyǔ.',
    example_vi = 'Sáng nay trời vốn trong xanh không gợn bóng mây, chẳng ngờ sau buổi trưa đột ngột sấm chớp rền vang trút cơn mưa rào.'
WHERE id = '0bfde4c6-0a28-4e13-bc8a-7d3386b48a6e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0bfde4c6-0a28-4e13-bc8a-7d3386b48a6e', '今天早晨天空本来晴空万里，不料午后突然电闪雷鸣下起了暴雨。', 'Jīntiān zǎochén tiānkōng běnlái qíngkōng-wànlǐ, búliào wǔhòu tūrán diànshǎn-léimíng xià qǐ le bàoyǔ.', 'Sáng nay trời vốn trong xanh không gợn bóng mây, chẳng ngờ sau buổi trưa đột ngột sấm chớp rền vang trút cơn mưa rào.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0bfde4c6-0a28-4e13-bc8a-7d3386b48a6e'
);

-- [不时] (bù shí): thường xuyên, thỉnh thoảng, chốc chốc
UPDATE public.vocabularies
SET example_hanzi = '台上的相声演员风趣幽默，精彩的表演引得台下观众不时爆发出笑声。',
    example_pinyin = 'Tái shang de xiàngsheng yǎnyuán fēngqù yōumò, jīngcǎi de biǎoyǎn yǐn de tái xià guānzhòng bùshí bàofā chū xiàoshēng.',
    example_vi = 'Diễn viên tấu hài trên sân khấu hóm hỉnh duyên dáng, màn trình diễn xuất sắc khiến khán giả bên dưới chốc chốc lại bật cười sảng khoái.'
WHERE id = '19a003c9-38e9-4bfc-b27b-90a0b83900a2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '19a003c9-38e9-4bfc-b27b-90a0b83900a2', '台上的相声演员风趣幽默，精彩的表演引得台下观众不时爆发出笑声。', 'Tái shang de xiàngsheng yǎnyuán fēngqù yōumò, jīngcǎi de biǎoyǎn yǐn de tái xià guānzhòng bùshí bàofā chū xiàoshēng.', 'Diễn viên tấu hài trên sân khấu hóm hỉnh duyên dáng, màn trình diễn xuất sắc khiến khán giả bên dưới chốc chốc lại bật cười sảng khoái.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '19a003c9-38e9-4bfc-b27b-90a0b83900a2'
);

-- [布置] (bù zhì): bố trí, sắp đặt; phân công
UPDATE public.vocabularies
SET example_hanzi = '老师在下课前向全班同学认真布置了本周的课后阅读与写作作业。',
    example_pinyin = 'Lǎoshī zài xiàkè qián xiàng quánbān tóngxué rènzhēn bùzhì le běn zhōu de kèhòu yuèdú yǔ xiězuò zuòyè.',
    example_vi = 'Trước khi tan học, giáo viên đã ân cần phân công và dặn dò toàn lớp bài tập đọc hiểu và viết luận tuần này.'
WHERE id = '2b06b461-5833-4a16-9887-fb393bde43df' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2b06b461-5833-4a16-9887-fb393bde43df', '老师在下课前向全班同学认真布置了本周的课后阅读与写作作业。', 'Lǎoshī zài xiàkè qián xiàng quánbān tóngxué rènzhēn bùzhì le běn zhōu de kèhòu yuèdú yǔ xiězuò zuòyè.', 'Trước khi tan học, giáo viên đã ân cần phân công và dặn dò toàn lớp bài tập đọc hiểu và viết luận tuần này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2b06b461-5833-4a16-9887-fb393bde43df'
);

-- [不止] (bù zhǐ): không chỉ, không ngừng
UPDATE public.vocabularies
SET example_hanzi = '这家历史悠久的中华老字号药铺，其传承历史至少不止三百年。',
    example_pinyin = 'Zhè jiā lìshǐ yōujiǔ de zhōnghuá lǎozìhào yàopù, qí chuánchéng lìshǐ zhìshǎo bùzhǐ sānbǎi nián.',
    example_vi = 'Tiệm thuốc bắc cổ truyền lâu đời nức tiếng Trung Hoa này có lịch sử kế thừa ít nhất không dưới ba trăm năm.'
WHERE id = '910b6bce-6870-4475-85e7-09b3d9322899' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '910b6bce-6870-4475-85e7-09b3d9322899', '这家历史悠久的中华老字号药铺，其传承历史至少不止三百年。', 'Zhè jiā lìshǐ yōujiǔ de zhōnghuá lǎozìhào yàopù, qí chuánchéng lìshǐ zhìshǎo bùzhǐ sānbǎi nián.', 'Tiệm thuốc bắc cổ truyền lâu đời nức tiếng Trung Hoa này có lịch sử kế thừa ít nhất không dưới ba trăm năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '910b6bce-6870-4475-85e7-09b3d9322899'
);

-- [不安] (bù'ān): bất an, lo lắng
UPDATE public.vocabularies
SET example_hanzi = '考试成绩公布前夕，他躺在床上翻来覆去，内心感到十分焦虑不安。',
    example_pinyin = 'Kǎoshì chéngjì gōngbù qiánxī, tā tǎng zài chuáng shang fānlái-fùqù, nèixīn gǎndào shífēn jiāolǜ bù''ān.',
    example_vi = 'Đêm trước ngày công bố điểm thi, anh ấy nằm trên giường trằn trọc thao thức, trong lòng cảm thấy vô cùng lo âu bất an.'
WHERE id = '0aceb97a-acbe-434f-b248-33c7e450fa77' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0aceb97a-acbe-434f-b248-33c7e450fa77', '考试成绩公布前夕，他躺在床上翻来覆去，内心感到十分焦虑不安。', 'Kǎoshì chéngjì gōngbù qiánxī, tā tǎng zài chuáng shang fānlái-fùqù, nèixīn gǎndào shífēn jiāolǜ bù''ān.', 'Đêm trước ngày công bố điểm thi, anh ấy nằm trên giường trằn trọc thao thức, trong lòng cảm thấy vô cùng lo âu bất an.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0aceb97a-acbe-434f-b248-33c7e450fa77'
);

-- [补偿] (bǔcháng): bồi thường, bù đắp
UPDATE public.vocabularies
SET example_hanzi = '工程施工给周边居民带来了噪音影响，施工方依法给予了合理的经济补偿。',
    example_pinyin = 'Gōngchéng shīgōng gěi zhōubiān jūmín dài lái le zàoyīn yǐngxiǎng, shīgōng fāng yīfǎ jǐyǔ le hélǐ de jīngjì bǔcháng.',
    example_vi = 'Việc thi công công trình gây ảnh hưởng tiếng ồn tới cư dân xung quanh, phía thi công đã bồi thường kinh tế thỏa đáng theo luật.'
WHERE id = 'c636b429-5ae7-435d-beec-37cbab0d2632' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c636b429-5ae7-435d-beec-37cbab0d2632', '工程施工给周边居民带来了噪音影响，施工方依法给予了合理的经济补偿。', 'Gōngchéng shīgōng gěi zhōubiān jūmín dài lái le zàoyīn yǐngxiǎng, shīgōng fāng yīfǎ jǐyǔ le hélǐ de jīngjì bǔcháng.', 'Việc thi công công trình gây ảnh hưởng tiếng ồn tới cư dân xung quanh, phía thi công đã bồi thường kinh tế thỏa đáng theo luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c636b429-5ae7-435d-beec-37cbab0d2632'
);

-- [不耐烦] (búnàifán): mất kiên nhẫn, sốt ruột
UPDATE public.vocabularies
SET example_hanzi = '在炎热的烈日下排队等候了一个多小时，人群中有人开始显得不耐烦。',
    example_pinyin = 'Zài yánrè de lièrì xià páiduì děnghòu le yí gè duō xiǎoshí, rénqún zhōng yǒurén kāishǐ xiǎn de búnàifán.',
    example_vi = 'Xếp hàng chờ đợi dưới trời nắng gắt hơn một tiếng đồng hồ, trong đám đông đã có người bắt đầu tỏ vẻ mất kiên nhẫn sốt ruột.'
WHERE id = '2291b30a-a77b-4e50-b32f-a98ead4f5e38' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2291b30a-a77b-4e50-b32f-a98ead4f5e38', '在炎热的烈日下排队等候了一个多小时，人群中有人开始显得不耐烦。', 'Zài yánrè de lièrì xià páiduì děnghòu le yí gè duō xiǎoshí, rénqún zhōng yǒurén kāishǐ xiǎn de búnàifán.', 'Xếp hàng chờ đợi dưới trời nắng gắt hơn một tiếng đồng hồ, trong đám đông đã có người bắt đầu tỏ vẻ mất kiên nhẫn sốt ruột.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2291b30a-a77b-4e50-b32f-a98ead4f5e38'
);

-- [补贴] (bǔtiē): trợ cấp, phụ cấp
UPDATE public.vocabularies
SET example_hanzi = '为了鼓励新能源汽车消费，地方政府出台了针对购车车主的新一轮财政补贴。',
    example_pinyin = 'Wèile gǔlì xīnnéngyuán qìchē xiāofèi, dìfāng zhèngfǔ chūtái le zhēnduì gòuchē chēzhǔ de xīn yì lún cáizhèng bǔtiē.',
    example_vi = 'Để khuyến khích tiêu dùng xe năng lượng mới, chính quyền địa phương đã ban hành đợt trợ cấp tài chính mới cho chủ xe.'
WHERE id = 'c13e1486-c5b5-4347-8868-b2f07164f690' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c13e1486-c5b5-4347-8868-b2f07164f690', '为了鼓励新能源汽车消费，地方政府出台了针对购车车主的新一轮财政补贴。', 'Wèile gǔlì xīnnéngyuán qìchē xiāofèi, dìfāng zhèngfǔ chūtái le zhēnduì gòuchē chēzhǔ de xīn yì lún cáizhèng bǔtiē.', 'Để khuyến khích tiêu dùng xe năng lượng mới, chính quyền địa phương đã ban hành đợt trợ cấp tài chính mới cho chủ xe.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c13e1486-c5b5-4347-8868-b2f07164f690'
);

-- [部位] (bùwèi): bộ phận, vị trí
UPDATE public.vocabularies
SET example_hanzi = '体检报告明确指出，病灶主要集中在肺部的上叶部位，需遵医嘱复查。',
    example_pinyin = 'Tǐjiǎn bàogào míngquè zhǐchū, bìngzào zhǔyào jízhōng zài fèibù de shàngyè bùwèi, xū zūn yīzhǔ fùchá.',
    example_vi = 'Báo cáo khám sức khỏe chỉ rõ ổ bệnh chủ yếu tập trung ở vị trí thùy trên của phổi, cần tái khám theo chỉ định bác sĩ.'
WHERE id = '301178f0-a7a7-4b2b-8f73-dff7b3e0bdcc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '301178f0-a7a7-4b2b-8f73-dff7b3e0bdcc', '体检报告明确指出，病灶主要集中在肺部的上叶部位，需遵医嘱复查。', 'Tǐjiǎn bàogào míngquè zhǐchū, bìngzào zhǔyào jízhōng zài fèibù de shàngyè bùwèi, xū zūn yīzhǔ fùchá.', 'Báo cáo khám sức khỏe chỉ rõ ổ bệnh chủ yếu tập trung ở vị trí thùy trên của phổi, cần tái khám theo chỉ định bác sĩ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '301178f0-a7a7-4b2b-8f73-dff7b3e0bdcc'
);

-- [步骤] (bùzhòu): các bước, trình tự
UPDATE public.vocabularies
SET example_hanzi = '化学实验必须严格按照操作步骤规范进行，任何疏忽都可能导致事故。',
    example_pinyin = 'Huàxué shíyàn bìxū yángé ànzhào cāozuò bùzhòu guīfàn jìnxíng, rènhé shūhu dōu kěnéng dǎozhì shìgù.',
    example_vi = 'Thí nghiệm hóa học phải được tiến hành chuẩn mực theo đúng các bước thao tác, bất kỳ sơ suất nào cũng có thể gây ra tai nạn.'
WHERE id = '3f8d733f-7216-4328-82ad-d17a6b91b210' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3f8d733f-7216-4328-82ad-d17a6b91b210', '化学实验必须严格按照操作步骤规范进行，任何疏忽都可能导致事故。', 'Huàxué shíyàn bìxū yángé ànzhào cāozuò bùzhòu guīfàn jìnxíng, rènhé shūhu dōu kěnéng dǎozhì shìgù.', 'Thí nghiệm hóa học phải được tiến hành chuẩn mực theo đúng các bước thao tác, bất kỳ sơ suất nào cũng có thể gây ra tai nạn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3f8d733f-7216-4328-82ad-d17a6b91b210'
);

-- [踩] (cǎi): giẫm, đạp
UPDATE public.vocabularies
SET example_hanzi = '下雨天地滑，走在泥泞的小路上一定要格外小心，千万别踩空摔倒。',
    example_pinyin = 'Xiàyǔtiān dì huá, zǒu zài nínìng de xiǎolù shang yídìng yào géwài xiǎoxīn, qiānwàn bié cǎi kōng shuāidǎo.',
    example_vi = 'Trời mưa đất trơn, đi trên con đường nhỏ lầy lội nhất định phải hết sức cẩn thận, tuyệt đối chớ giẫm hụt ngã nhào.'
WHERE id = '8e7604a1-fdd0-452a-9725-3ce5dac0e661' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8e7604a1-fdd0-452a-9725-3ce5dac0e661', '下雨天地滑，走在泥泞的小路上一定要格外小心，千万别踩空摔倒。', 'Xiàyǔtiān dì huá, zǒu zài nínìng de xiǎolù shang yídìng yào géwài xiǎoxīn, qiānwàn bié cǎi kōng shuāidǎo.', 'Trời mưa đất trơn, đi trên con đường nhỏ lầy lội nhất định phải hết sức cẩn thận, tuyệt đối chớ giẫm hụt ngã nhào.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8e7604a1-fdd0-452a-9725-3ce5dac0e661'
);

-- [彩票] (cǎi piào): vé số
UPDATE public.vocabularies
SET example_hanzi = '他偶尔买一张公益彩票支持慈善事业，并不会把发财的希望寄托在上面。',
    example_pinyin = 'Tā ǒu''ěr mǎi yì zhāng gōngyì cǎipiào zhīchí císhàn shìyè, bìng bú huì bǎ fācái de xīwàng jìtuō zài shàngmiàn.',
    example_vi = 'Anh ấy thỉnh thoảng mua một tờ vé số phúc lợi công cộng để ủng hộ từ thiện, chứ không hề gửi gắm hy vọng làm giàu vào đó.'
WHERE id = 'bc0b9358-3991-4be7-9fdc-81c524d47331' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bc0b9358-3991-4be7-9fdc-81c524d47331', '他偶尔买一张公益彩票支持慈善事业，并不会把发财的希望寄托在上面。', 'Tā ǒu''ěr mǎi yì zhāng gōngyì cǎipiào zhīchí císhàn shìyè, bìng bú huì bǎ fācái de xīwàng jìtuō zài shàngmiàn.', 'Anh ấy thỉnh thoảng mua một tờ vé số phúc lợi công cộng để ủng hộ từ thiện, chứ không hề gửi gắm hy vọng làm giàu vào đó.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bc0b9358-3991-4be7-9fdc-81c524d47331'
);

-- [财产] (cáichǎn): tài sản
UPDATE public.vocabularies
SET example_hanzi = '宪法明确规定，公民合法的私有财产不受侵犯，依法受到国家保护。',
    example_pinyin = 'Xiànfǎ míngquè guīdìng, gōngmín héfǎ de sīyǒu cáichǎn bú shòu qīnfàn, yīfǎ shòudào guójiā bǎohù.',
    example_vi = 'Hiến pháp quy định rõ tài sản tư hữu hợp pháp của công dân là bất khả xâm phạm, được nhà nước bảo hộ theo pháp luật.'
WHERE id = 'fcab81b2-b6fb-484f-824d-743476c46c98' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fcab81b2-b6fb-484f-824d-743476c46c98', '宪法明确规定，公民合法的私有财产不受侵犯，依法受到国家保护。', 'Xiànfǎ míngquè guīdìng, gōngmín héfǎ de sīyǒu cáichǎn bú shòu qīnfàn, yīfǎ shòudào guójiā bǎohù.', 'Hiến pháp quy định rõ tài sản tư hữu hợp pháp của công dân là bất khả xâm phạm, được nhà nước bảo hộ theo pháp luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fcab81b2-b6fb-484f-824d-743476c46c98'
);

-- [财富] (cáifù): của cải, tài sản
UPDATE public.vocabularies
SET example_hanzi = '健康是人生最宝贵的财富，拥有健全的体魄才能更好地创造未来。',
    example_pinyin = 'Jiànkāng shì rénshēng zuì bǎoguì de cáifù, yōngyǒu jiànquán de tǐpò cái néng gèng hǎo de chuàngzào wèilái.',
    example_vi = 'Sức khỏe là của cải quý báu nhất của đời người, có được thể chất khỏe mạnh mới có thể kiến tạo tương lai tốt đẹp hơn.'
WHERE id = '8e09b594-b5f1-4dd0-ade4-52f0a697bbb1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8e09b594-b5f1-4dd0-ade4-52f0a697bbb1', '健康是人生最宝贵的财富，拥有健全的体魄才能更好地创造未来。', 'Jiànkāng shì rénshēng zuì bǎoguì de cáifù, yōngyǒu jiànquán de tǐpò cái néng gèng hǎo de chuàngzào wèilái.', 'Sức khỏe là của cải quý báu nhất của đời người, có được thể chất khỏe mạnh mới có thể kiến tạo tương lai tốt đẹp hơn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8e09b594-b5f1-4dd0-ade4-52f0a697bbb1'
);

-- [采购] (cǎigòu): thu mua, mua sắm
UPDATE public.vocabularies
SET example_hanzi = '学校后勤部门每逢开学前夕，都会集中采购一批高质量的教学设备。',
    example_pinyin = 'Xuéxiào hòuqín bùmén měi féng kāixué qiánxī, dōu huì jízhōng cǎigòu yì pī gāo zhìliàng de jiàoxué shèbèi.',
    example_vi = 'Bộ phận hậu cần của trường học trước thềm năm học mới đều tập trung thu mua một lô thiết bị dạy học chất lượng cao.'
WHERE id = 'e46e63ec-30b7-4a20-a0a6-a7b829576062' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e46e63ec-30b7-4a20-a0a6-a7b829576062', '学校后勤部门每逢开学前夕，都会集中采购一批高质量的教学设备。', 'Xuéxiào hòuqín bùmén měi féng kāixué qiánxī, dōu huì jízhōng cǎigòu yì pī gāo zhìliàng de jiàoxué shèbèi.', 'Bộ phận hậu cần của trường học trước thềm năm học mới đều tập trung thu mua một lô thiết bị dạy học chất lượng cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e46e63ec-30b7-4a20-a0a6-a7b829576062'
);

-- [彩虹] (cǎihóng): cầu vồng
UPDATE public.vocabularies
SET example_hanzi = '暴风雨过后，西方的天空中挂起了一道色彩绚丽、横跨天际的彩虹。',
    example_pinyin = 'Bàofēngyǔ guòhòu, xīfāng de tiānkōng zhōng guà qǐ le yí dào sècǎi xuànlì, héngkuà tiānjì de cǎihóng.',
    example_vi = 'Sau cơn giông bão, trên bầu trời phía tây xuất hiện một dải cầu vồng rực rỡ sắc màu vắt ngang chân trời.'
WHERE id = '17add1d8-b3d2-420d-9d63-7285e3ca4c8f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '17add1d8-b3d2-420d-9d63-7285e3ca4c8f', '暴风雨过后，西方的天空中挂起了一道色彩绚丽、横跨天际的彩虹。', 'Bàofēngyǔ guòhòu, xīfāng de tiānkōng zhōng guà qǐ le yí dào sècǎi xuànlì, héngkuà tiānjì de cǎihóng.', 'Sau cơn giông bão, trên bầu trời phía tây xuất hiện một dải cầu vồng rực rỡ sắc màu vắt ngang chân trời.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '17add1d8-b3d2-420d-9d63-7285e3ca4c8f'
);

-- [采集] (cǎijí): thu thập, hái lượm
UPDATE public.vocabularies
SET example_hanzi = '植物学家深入崇山峻岭，采集了许多珍稀濒危野生植物标本。',
    example_pinyin = 'Zhíwùxuéjiā shēnrù chóngshān-jùnlǐng, cǎijí le xǔduō zhēnxī bīnwēi yěshēng zhíwù biāoběn.',
    example_vi = 'Nhà thực vật học đã tiến sâu vào vùng núi non trùng điệp thu thập rất nhiều mẫu tiêu bản thực vật hoang dã quý hiếm có nguy cơ tuyệt chủng.'
WHERE id = '0e5b428d-df64-42a5-ae88-495ec3c8a663' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0e5b428d-df64-42a5-ae88-495ec3c8a663', '植物学家深入崇山峻岭，采集了许多珍稀濒危野生植物标本。', 'Zhíwùxuéjiā shēnrù chóngshān-jùnlǐng, cǎijí le xǔduō zhēnxī bīnwēi yěshēng zhíwù biāoběn.', 'Nhà thực vật học đã tiến sâu vào vùng núi non trùng điệp thu thập rất nhiều mẫu tiêu bản thực vật hoang dã quý hiếm có nguy cơ tuyệt chủng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0e5b428d-df64-42a5-ae88-495ec3c8a663'
);

-- [采纳] (cǎinà): tiếp thu, chấp nhận
UPDATE public.vocabularies
SET example_hanzi = '管理层虚心倾听员工意见，并积极采纳了关于优化办公流程的合理建议。',
    example_pinyin = 'Guǎnlǐcéng xūxīn qīngtīng yuángōng yìjiàn, bìng jījí cǎinà le guānyú yōuhuà bàngōng liúchéng de hélǐ jiànyì.',
    example_vi = 'Ban quản lý khiêm tốn lắng nghe ý kiến nhân viên và tích cực tiếp thu các đề xuất hợp lý về việc tối ưu hóa quy trình làm việc.'
WHERE id = '598e6273-d02c-4168-b014-2cd1b98f2089' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '598e6273-d02c-4168-b014-2cd1b98f2089', '管理层虚心倾听员工意见，并积极采纳了关于优化办公流程的合理建议。', 'Guǎnlǐcéng xūxīn qīngtīng yuángōng yìjiàn, bìng jījí cǎinà le guānyú yōuhuà bàngōng liúchéng de hélǐ jiànyì.', 'Ban quản lý khiêm tốn lắng nghe ý kiến nhân viên và tích cực tiếp thu các đề xuất hợp lý về việc tối ưu hóa quy trình làm việc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '598e6273-d02c-4168-b014-2cd1b98f2089'
);

-- [财务] (cáiwù): tài vụ, tài chính
UPDATE public.vocabularies
SET example_hanzi = '公司每年底都会聘请专业审计机构对全年的财务状况进行全面审计。',
    example_pinyin = 'Gōngsī měi niándǐ dōu huì pìnqǐng zhuānyè shěnjì jīgòu duì quánnián de cáiwù zhuàngkuàng jìnxíng quánmiàn shěnjì.',
    example_vi = 'Công ty vào cuối mỗi năm đều thuê cơ quan kiểm toán chuyên nghiệp kiểm toán toàn diện tình hình tài chính cả năm.'
WHERE id = 'fbf6d08f-c07a-46a2-84f5-75b3b3706617' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fbf6d08f-c07a-46a2-84f5-75b3b3706617', '公司每年底都会聘请专业审计机构对全年的财务状况进行全面审计。', 'Gōngsī měi niándǐ dōu huì pìnqǐng zhuānyè shěnjì jīgòu duì quánnián de cáiwù zhuàngkuàng jìnxíng quánmiàn shěnjì.', 'Công ty vào cuối mỗi năm đều thuê cơ quan kiểm toán chuyên nghiệp kiểm toán toàn diện tình hình tài chính cả năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fbf6d08f-c07a-46a2-84f5-75b3b3706617'
);

-- [仓库] (cāngkù): nhà kho, kho bãi
UPDATE public.vocabularies
SET example_hanzi = '物流园区的现代化立体仓库里，智能搬运机器人正在高效地分拣货物。',
    example_pinyin = 'Wùliú yuánqū de xiàndàihuà lìtǐ cāngkù lǐ, zhìnéng bānyùn jīqìrén zhèngzài gāoxiào de fēnjiǎn huòwù.',
    example_vi = 'Trong nhà kho lập thể hiện đại của khu hậu cần, robot vận chuyển thông minh đang phân loại hàng hóa với hiệu suất cao.'
WHERE id = 'deb17956-2e93-49cc-9074-b0b04839301a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'deb17956-2e93-49cc-9074-b0b04839301a', '物流园区的现代化立体仓库里，智能搬运机器人正在高效地分拣货物。', 'Wùliú yuánqū de xiàndàihuà lìtǐ cāngkù lǐ, zhìnéng bānyùn jīqìrén zhèngzài gāoxiào de fēnjiǎn huòwù.', 'Trong nhà kho lập thể hiện đại của khu hậu cần, robot vận chuyển thông minh đang phân loại hàng hóa với hiệu suất cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'deb17956-2e93-49cc-9074-b0b04839301a'
);

-- [残疾] (cánjí): tàn tật, khuyết tật
UPDATE public.vocabularies
SET example_hanzi = '全社会应当共同营造无障碍环境，关爱并尊重身体残疾人士的合法权益。',
    example_pinyin = 'Quán shèhuì yīngdāng gòngtóng yíngzào wú zhàng''ài huánjìng, guān''ài bìng zūnzhòng shēntǐ cánjí rénshì de héfǎ quányì.',
    example_vi = 'Toàn xã hội cần chung tay xây dựng môi trường không rào cản, quan tâm và tôn trọng quyền lợi hợp pháp của người khuyết tật.'
WHERE id = '9f501377-d081-4732-938d-fdf142259d24' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9f501377-d081-4732-938d-fdf142259d24', '全社会应当共同营造无障碍环境，关爱并尊重身体残疾人士的合法权益。', 'Quán shèhuì yīngdāng gòngtóng yíngzào wú zhàng''ài huánjìng, guān''ài bìng zūnzhòng shēntǐ cánjí rénshì de héfǎ quányì.', 'Toàn xã hội cần chung tay xây dựng môi trường không rào cản, quan tâm và tôn trọng quyền lợi hợp pháp của người khuyết tật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9f501377-d081-4732-938d-fdf142259d24'
);

-- [策划] (cèhuà): hoạch định, lên kế hoạch
UPDATE public.vocabularies
SET example_hanzi = '市场部团队精心策划的年度新品发布会，获得了业界同行的一致好评。',
    example_pinyin = 'Shìchǎngbù tuánduì jīngxīn cèhuà de niándù xīnpǐn fābùhuì, huòdé le yèjiè tóngháng de yízhì hǎopíng.',
    example_vi = 'Buổi họp báo ra mắt sản phẩm mới thường niên do đội ngũ phòng thị trường dày công hoạch định đã nhận được sự khen ngợi đồng lòng từ giới chuyên môn.'
WHERE id = 'ab10e468-3a1d-4bf9-8877-e717ab2e0a07' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ab10e468-3a1d-4bf9-8877-e717ab2e0a07', '市场部团队精心策划的年度新品发布会，获得了业界同行的一致好评。', 'Shìchǎngbù tuánduì jīngxīn cèhuà de niándù xīnpǐn fābùhuì, huòdé le yèjiè tóngháng de yízhì hǎopíng.', 'Buổi họp báo ra mắt sản phẩm mới thường niên do đội ngũ phòng thị trường dày công hoạch định đã nhận được sự khen ngợi đồng lòng từ giới chuyên môn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ab10e468-3a1d-4bf9-8877-e717ab2e0a07'
);

-- [测量] (cèliáng): đo đạc, đo lường
UPDATE public.vocabularies
SET example_hanzi = '地质勘探队员顶着烈日，在险峻的山坡上用高精度仪器测量地形数据。',
    example_pinyin = 'Dìzhì kāntànduìyuán dǐng zhe lièrì, zài xiǎnjùn de shānpō shang yòng gāo jīngdù yíqì cèliáng dìxíng shùjù.',
    example_vi = 'Đội thăm dò địa chất đội nắng gắt trên sườn núi hiểm trở dùng thiết bị độ chính xác cao đo đạc các số liệu địa hình.'
WHERE id = '9f0c40e6-d304-46b2-8b39-0861ffad8c35' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9f0c40e6-d304-46b2-8b39-0861ffad8c35', '地质勘探队员顶着烈日，在险峻的山坡上用高精度仪器测量地形数据。', 'Dìzhì kāntànduìyuán dǐng zhe lièrì, zài xiǎnjùn de shānpō shang yòng gāo jīngdù yíqì cèliáng dìxíng shùjù.', 'Đội thăm dò địa chất đội nắng gắt trên sườn núi hiểm trở dùng thiết bị độ chính xác cao đo đạc các số liệu địa hình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9f0c40e6-d304-46b2-8b39-0861ffad8c35'
);

-- [策略] (cèlüè): sách lược, chiến lược
UPDATE public.vocabularies
SET example_hanzi = '面对复杂多变的市场环境，企业及时调整了海外市场的营销策略。',
    example_pinyin = 'Miànduì fùzá duōbiàn de shìchǎng huánjìng, qǐyè jíshí tiáozhěng le hǎiwài shìchǎng de yíngxiāo cèlüè.',
    example_vi = 'Đối mặt với môi trường thị trường biến đổi phức tạp, doanh nghiệp đã kịp thời điều chỉnh chiến lược tiếp thị thị trường nước ngoài.'
WHERE id = 'a6ee19e9-cb80-456a-ac39-f10c52f2413f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a6ee19e9-cb80-456a-ac39-f10c52f2413f', '面对复杂多变的市场环境，企业及时调整了海外市场的营销策略。', 'Miànduì fùzá duōbiàn de shìchǎng huánjìng, qǐyè jíshí tiáozhěng le hǎiwài shìchǎng de yíngxiāo cèlüè.', 'Đối mặt với môi trường thị trường biến đổi phức tạp, doanh nghiệp đã kịp thời điều chỉnh chiến lược tiếp thị thị trường nước ngoài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a6ee19e9-cb80-456a-ac39-f10c52f2413f'
);

-- [层次] (céng cì): tầng thứ, thứ bậc
UPDATE public.vocabularies
SET example_hanzi = '这篇文章结构严密、逻辑清晰，论述问题的层次非常分明。',
    example_pinyin = 'Zhè piān wénzhāng jiégòu yánmì, luójí qīngxī, lùnshù wèntí de céngcì fēicháng fēnmíng.',
    example_vi = 'Bài viết này kết cấu chặt chẽ, mạch lạc rõ ràng, các tầng thứ tầng nấc lập luận vấn đề vô cùng rành mạch.'
WHERE id = 'ddb1c2b0-e1c0-432c-a50f-135c43fd3fce' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ddb1c2b0-e1c0-432c-a50f-135c43fd3fce', '这篇文章结构严密、逻辑清晰，论述问题的层次非常分明。', 'Zhè piān wénzhāng jiégòu yánmì, luójí qīngxī, lùnshù wèntí de céngcì fēicháng fēnmíng.', 'Bài viết này kết cấu chặt chẽ, mạch lạc rõ ràng, các tầng thứ tầng nấc lập luận vấn đề vô cùng rành mạch.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ddb1c2b0-e1c0-432c-a50f-135c43fd3fce'
);

-- [插座] (chā zuò): ổ cắm điện
UPDATE public.vocabularies
SET example_hanzi = '书桌旁边的墙壁上安装了多功能插座，方便为各种电子设备充电。',
    example_pinyin = 'Shūzhuō pángbiān de qiángbì shang ānzhuāng le duō gōngnéng chāzuò, fāngbiàn wèi gè zhǒng diànzǐ shèbèi chōngdiàn.',
    example_vi = 'Trên bức tường bên cạnh bàn làm việc có lắp ổ cắm đa năng, thuận tiện sạc pin cho các thiết bị điện tử.'
WHERE id = '8ec7c5dd-5f3e-4247-be9b-712130139318' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8ec7c5dd-5f3e-4247-be9b-712130139318', '书桌旁边的墙壁上安装了多功能插座，方便为各种电子设备充电。', 'Shūzhuō pángbiān de qiángbì shang ānzhuāng le duō gōngnéng chāzuò, fāngbiàn wèi gè zhǒng diànzǐ shèbèi chōngdiàn.', 'Trên bức tường bên cạnh bàn làm việc có lắp ổ cắm đa năng, thuận tiện sạc pin cho các thiết bị điện tử.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8ec7c5dd-5f3e-4247-be9b-712130139318'
);

-- [场合] (chǎnghé): trường hợp, hoàn cảnh
UPDATE public.vocabularies
SET example_hanzi = '在正式的外交场合，外交官的言谈举止都代表着国家形象与尊严。',
    example_pinyin = 'Zài zhèngshì de wàijiāo chǎnghé, wàijiāoguān de yántán-jǔzhǐ dōu dàibiǎo zhe guójiā xíngxiàng yǔ zūnyán.',
    example_vi = 'Trong những dịp ngoại giao chính thức, lời ăn tiếng nói và cử chỉ của nhà ngoại giao đều đại diện cho thể diện và tôn nghiêm quốc gia.'
WHERE id = 'f9f8d9da-ac0e-4bdf-8694-7d809c75ef02' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f9f8d9da-ac0e-4bdf-8694-7d809c75ef02', '在正式的外交场合，外交官的言谈举止都代表着国家形象与尊严。', 'Zài zhèngshì de wàijiāo chǎnghé, wàijiāoguān de yántán-jǔzhǐ dōu dàibiǎo zhe guójiā xíngxiàng yǔ zūnyán.', 'Trong những dịp ngoại giao chính thức, lời ăn tiếng nói và cử chỉ của nhà ngoại giao đều đại diện cho thể diện và tôn nghiêm quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f9f8d9da-ac0e-4bdf-8694-7d809c75ef02'
);

-- [场面] (chǎngmiàn): cảnh tượng, thể diện
UPDATE public.vocabularies
SET example_hanzi = '运动会开幕式上，上千名青年学生同台起舞，场面十分宏大壮观。',
    example_pinyin = 'Yùndònghuì kāimùshì shang, shàng qiān míng qīngnián xuésheng tóngtái qǐwǔ, chǎngmiàn shífēn hóngdà zhuàngguān.',
    example_vi = 'Tại lễ khai mạc đại hội thể thao, hàng ngàn học sinh thanh niên cùng múa trên sân khấu, cảnh tượng vô cùng hoành tráng.'
WHERE id = 'f3ee782b-383f-4c95-ba30-7b2ec9f3626f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f3ee782b-383f-4c95-ba30-7b2ec9f3626f', '运动会开幕式上，上千名青年学生同台起舞，场面十分宏大壮观。', 'Yùndònghuì kāimùshì shang, shàng qiān míng qīngnián xuésheng tóngtái qǐwǔ, chǎngmiàn shífēn hóngdà zhuàngguān.', 'Tại lễ khai mạc đại hội thể thao, hàng ngàn học sinh thanh niên cùng múa trên sân khấu, cảnh tượng vô cùng hoành tráng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f3ee782b-383f-4c95-ba30-7b2ec9f3626f'
);

-- [畅通] (chàngtōng): thông suốt, hanh thông
UPDATE public.vocabularies
SET example_hanzi = '交通交警部门全力疏导车辆，确保春运期间全省高速公路畅通无阻。',
    example_pinyin = 'Jiāotōng jiāojǐng bùmén quánlì shūdǎo chēliàng, quèbǎo chūnyùn qījiān quánshěng gāosù gōnglù chàngtōng-wúzǔ.',
    example_vi = 'Lực lượng cảnh sát giao thông dốc sức phân luồng phương tiện, bảo đảm đường cao tốc toàn tỉnh thông suốt không ách tắc trong đợt cao điểm Tết.'
WHERE id = 'c9f83e9b-3cd4-417f-b11e-79ae26fd0cbf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c9f83e9b-3cd4-417f-b11e-79ae26fd0cbf', '交通交警部门全力疏导车辆，确保春运期间全省高速公路畅通无阻。', 'Jiāotōng jiāojǐng bùmén quánlì shūdǎo chēliàng, quèbǎo chūnyùn qījiān quánshěng gāosù gōnglù chàngtōng-wúzǔ.', 'Lực lượng cảnh sát giao thông dốc sức phân luồng phương tiện, bảo đảm đường cao tốc toàn tỉnh thông suốt không ách tắc trong đợt cao điểm Tết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c9f83e9b-3cd4-417f-b11e-79ae26fd0cbf'
);

-- [畅销] (chàngxiāo): bán chạy
UPDATE public.vocabularies
SET example_hanzi = '这部深入浅出普及人工智能知识的科普读物，上市仅一个月便成为畅销书。',
    example_pinyin = 'Zhè bù shēnrù-qiǎnchū pǔjí réngōng zhìnéng zhīshi de kěpǔ dúwù, shàngshì jǐn yí gè yuè biàn chéngwéi chàngxiāoshū.',
    example_vi = 'Cuốn sách phổ biến kiến thức trí tuệ nhân tạo dễ hiểu này chỉ mới lên kệ một tháng đã trở thành sách bán chạy.'
WHERE id = '839d6864-80d1-4ee8-9524-97d27d4a6859' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '839d6864-80d1-4ee8-9524-97d27d4a6859', '这部深入浅出普及人工智能知识的科普读物，上市仅一个月便成为畅销书。', 'Zhè bù shēnrù-qiǎnchū pǔjí réngōng zhìnéng zhīshi de kěpǔ dúwù, shàngshì jǐn yí gè yuè biàn chéngwéi chàngxiāoshū.', 'Cuốn sách phổ biến kiến thức trí tuệ nhân tạo dễ hiểu này chỉ mới lên kệ một tháng đã trở thành sách bán chạy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '839d6864-80d1-4ee8-9524-97d27d4a6859'
);

-- [抄] (chāo): chép, sao chép
UPDATE public.vocabularies
SET example_hanzi = '学术研究必须恪守诚信底线，绝不能抄袭他人的论文成果。',
    example_pinyin = 'Xuéshù yánjiū bìxū kèshǒu chéngxìn dǐxiàn, jué bùnéng chāoxí tārén de lùnwén chéngguǒ.',
    example_vi = 'Nghiên cứu học thuật nhất thiết phải giữ vững chuẩn mực trung thực, tuyệt đối không được sao chép thành quả luận văn của người khác.'
WHERE id = '1c25d9fb-cfa7-444e-a535-4c49f5931350' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1c25d9fb-cfa7-444e-a535-4c49f5931350', '学术研究必须恪守诚信底线，绝不能抄袭他人的论文成果。', 'Xuéshù yánjiū bìxū kèshǒu chéngxìn dǐxiàn, jué bùnéng chāoxí tārén de lùnwén chéngguǒ.', 'Nghiên cứu học thuật nhất thiết phải giữ vững chuẩn mực trung thực, tuyệt đối không được sao chép thành quả luận văn của người khác.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1c25d9fb-cfa7-444e-a535-4c49f5931350'
);

-- [朝代] (cháodài): triều đại
UPDATE public.vocabularies
SET example_hanzi = '唐朝是中国历史上政治开明、文化繁荣的辉煌朝代之一。',
    example_pinyin = 'Tángcháo shì Zhōngguó lìshǐ shang zhèngzhì kāimíng, wénhuà fánróng de huīhuáng cháodài zhī yī.',
    example_vi = 'Triều đại nhà Đường là một trong những triều đại huy hoàng có nền chính trị khai sáng và văn hóa phồn thịnh trong lịch sử Trung Quốc.'
WHERE id = 'aaf6b94b-e1c2-48cb-8861-2d256ff9e7b5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'aaf6b94b-e1c2-48cb-8861-2d256ff9e7b5', '唐朝是中国历史上政治开明、文化繁荣的辉煌朝代之一。', 'Tángcháo shì Zhōngguó lìshǐ shang zhèngzhì kāimíng, wénhuà fánróng de huīhuáng cháodài zhī yī.', 'Triều đại nhà Đường là một trong những triều đại huy hoàng có nền chính trị khai sáng và văn hóa phồn thịnh trong lịch sử Trung Quốc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'aaf6b94b-e1c2-48cb-8861-2d256ff9e7b5'
);

-- [吵架] (chǎojià): cãi nhau
UPDATE public.vocabularies
SET example_hanzi = '夫妻之间应当多沟通体谅，遇到分歧时要冷静商量，切忌冲动吵架。',
    example_pinyin = 'Fūqī zhījiān yīngdāng duō gōutōng tǐliàng, yùdào fēnqí shí yào lěngjìng shāngliang, qièjì chōngdòng chǎojià.',
    example_vi = 'Vợ chồng với nhau nên giao tiếp thấu hiểu nhiều hơn, khi gặp bất đồng cần bình tĩnh bàn bạc, chớ nên bốc đồng cãi vã.'
WHERE id = 'e0f20a8c-2b8c-4ccd-af2d-bab2a1d77241' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e0f20a8c-2b8c-4ccd-af2d-bab2a1d77241', '夫妻之间应当多沟通体谅，遇到分歧时要冷静商量，切忌冲动吵架。', 'Fūqī zhījiān yīngdāng duō gōutōng tǐliàng, yùdào fēnqí shí yào lěngjìng shāngliang, qièjì chōngdòng chǎojià.', 'Vợ chồng với nhau nên giao tiếp thấu hiểu nhiều hơn, khi gặp bất đồng cần bình tĩnh bàn bạc, chớ nên bốc đồng cãi vã.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e0f20a8c-2b8c-4ccd-af2d-bab2a1d77241'
);

-- [潮流] (cháoliú): trào lưu, xu hướng
UPDATE public.vocabularies
SET example_hanzi = '绿色低碳和可持续发展，已成为当今国际经济转型的主流潮流。',
    example_pinyin = 'Lǜsè dītàn hé kéchíxù fāzhǎn, yǐ chéngwéi dāngjīn guójì jīngjì zhuǎnxíng de zhǔliú cháoliú.',
    example_vi = 'Xanh hóa ít carbon và phát triển bền vững đã trở thành trào lưu xu hướng chủ lưu trong chuyển đổi kinh tế quốc tế ngày nay.'
WHERE id = '30c07891-91ab-45ec-98f0-90814b01a58f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '30c07891-91ab-45ec-98f0-90814b01a58f', '绿色低碳和可持续发展，已成为当今国际经济转型的主流潮流。', 'Lǜsè dītàn hé kéchíxù fāzhǎn, yǐ chéngwéi dāngjīn guójì jīngjì zhuǎnxíng de zhǔliú cháoliú.', 'Xanh hóa ít carbon và phát triển bền vững đã trở thành trào lưu xu hướng chủ lưu trong chuyển đổi kinh tế quốc tế ngày nay.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '30c07891-91ab-45ec-98f0-90814b01a58f'
);

-- [潮湿] (cháoshī): ẩm ướt
UPDATE public.vocabularies
SET example_hanzi = '南方梅雨季节气候潮湿，衣物洗完后往往需要用烘干机烘干。',
    example_pinyin = 'Nánfāng méiyǔ jìjié qìhòu cháoshī, yīwù xǐ wán hòu wǎngwǎng xūyào yòng hōnggānjī hōnggān.',
    example_vi = 'Mùa mưa dầm ở miền nam khí hậu rất ẩm ướt, quần áo giặt xong thường phải dùng máy sấy để sấy khô.'
WHERE id = '5edd9ef2-57fd-4e56-b25b-f7486388425a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5edd9ef2-57fd-4e56-b25b-f7486388425a', '南方梅雨季节气候潮湿，衣物洗完后往往需要用烘干机烘干。', 'Nánfāng méiyǔ jìjié qìhòu cháoshī, yīwù xǐ wán hòu wǎngwǎng xūyào yòng hōnggānjī hōnggān.', 'Mùa mưa dầm ở miền nam khí hậu rất ẩm ướt, quần áo giặt xong thường phải dùng máy sấy để sấy khô.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5edd9ef2-57fd-4e56-b25b-f7486388425a'
);

-- [嘲笑] (cháoxiào): cười nhạo, châm chọc
UPDATE public.vocabularies
SET example_hanzi = '我们要尊重每一位努力奋斗的人，绝不应该嘲笑别人的暂时失败。',
    example_pinyin = 'Wǒmen yào zūnzhòng měi yí wèi nǔlì fèndòu de rén, jué bù yīnggāi cháoxiào biérén de zànshí shībài.',
    example_vi = 'Chúng ta phải tôn trọng mỗi người đang nỗ lực phấn đấu, tuyệt đối không nên cười nhạo thất bại tạm thời của người khác.'
WHERE id = 'f83dd7ba-3c85-4c8a-908b-8e69a803110d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f83dd7ba-3c85-4c8a-908b-8e69a803110d', '我们要尊重每一位努力奋斗的人，绝不应该嘲笑别人的暂时失败。', 'Wǒmen yào zūnzhòng měi yí wèi nǔlì fèndòu de rén, jué bù yīnggāi cháoxiào biérén de zànshí shībài.', 'Chúng ta phải tôn trọng mỗi người đang nỗ lực phấn đấu, tuyệt đối không nên cười nhạo thất bại tạm thời của người khác.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f83dd7ba-3c85-4c8a-908b-8e69a803110d'
);

-- [超越] (chāoyuè): vượt qua, vượt trội
UPDATE public.vocabularies
SET example_hanzi = '优秀的运动员在赛场上敢于突破自我，不断挑战并超越历史极限。',
    example_pinyin = 'Yōuxiù de yùndòngyuán zài sàichǎng shang gǎnyú tūpò zìwǒ, búduàn tiǎozhàn bìng chāoyuè lìshǐ jíxiàn.',
    example_vi = 'Những vận động viên xuất sắc trên đấu trường luôn dám bứt phá bản thân, không ngừng thử thách và vượt qua giới hạn lịch sử.'
WHERE id = 'd7f8eb39-63f6-4eb5-ad51-72b95d6110ac' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd7f8eb39-63f6-4eb5-ad51-72b95d6110ac', '优秀的运动员在赛场上敢于突破自我，不断挑战并超越历史极限。', 'Yōuxiù de yùndòngyuán zài sàichǎng shang gǎnyú tūpò zìwǒ, búduàn tiǎozhàn bìng chāoyuè lìshǐ jíxiàn.', 'Những vận động viên xuất sắc trên đấu trường luôn dám bứt phá bản thân, không ngừng thử thách và vượt qua giới hạn lịch sử.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd7f8eb39-63f6-4eb5-ad51-72b95d6110ac'
);

-- [趁] (chèn): nhân dịp, nhân lúc
UPDATE public.vocabularies
SET example_hanzi = '趁着今天天气晴朗微风和煦，爷爷把储藏室里的旧书籍拿出来晾晒。',
    example_pinyin = 'Chèn zhe jīntiān tiānqì qínglǎng wēifēng héxù, yéye bǎ chǔcángshì lǐ de jiù shūjí ná chūlai liàngshài.',
    example_vi = 'Nhân lúc hôm nay trời trong xanh gió nhẹ ấm áp, ông nội đem những cuốn sách cũ trong phòng kho ra hong phơi.'
WHERE id = '20ca7cd6-f288-40a8-9e9b-cc4b4454a959' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '20ca7cd6-f288-40a8-9e9b-cc4b4454a959', '趁着今天天气晴朗微风和煦，爷爷把储藏室里的旧书籍拿出来晾晒。', 'Chèn zhe jīntiān tiānqì qínglǎng wēifēng héxù, yéye bǎ chǔcángshì lǐ de jiù shūjí ná chūlai liàngshài.', 'Nhân lúc hôm nay trời trong xanh gió nhẹ ấm áp, ông nội đem những cuốn sách cũ trong phòng kho ra hong phơi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '20ca7cd6-f288-40a8-9e9b-cc4b4454a959'
);

-- [乘] (chéng): ngồi (xe, tàu); nhân; tận dụng
UPDATE public.vocabularies
SET example_hanzi = '旅客们有序排队乘坐在站台等候的高速列车，前往首都北京。',
    example_pinyin = 'Lǚkè men yǒuxù páiduì chéngzuò zài zhàntái děnghòu de gāosù lièchē, qiánwǎng shǒudū Běijīng.',
    example_vi = 'Hành khách trật tự xếp hàng lên ngồi đoàn tàu cao tốc đang đợi ở sân ga để đi tới thủ đô Bắc Kinh.'
WHERE id = 'e8089b10-dcb1-443e-9f1d-e9578d277c15' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e8089b10-dcb1-443e-9f1d-e9578d277c15', '旅客们有序排队乘坐在站台等候的高速列车，前往首都北京。', 'Lǚkè men yǒuxù páiduì chéngzuò zài zhàntái děnghòu de gāosù lièchē, qiánwǎng shǒudū Běijīng.', 'Hành khách trật tự xếp hàng lên ngồi đoàn tàu cao tốc đang đợi ở sân ga để đi tới thủ đô Bắc Kinh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e8089b10-dcb1-443e-9f1d-e9578d277c15'
);

-- [惩罚] (chéng fá): trừng phạt
UPDATE public.vocabularies
SET example_hanzi = '任何人触犯了国家的刑事法律，都必须接受法律的公正惩罚。',
    example_pinyin = 'Rènhé rén chùfàn le guójiā de xíngshì fǎlǜ, dōu bìxū jiēshòu fǎlǜ de gōngzhèng chéngfá.',
    example_vi = 'Bất cứ ai vi phạm luật hình sự của quốc gia đều phải chấp nhận sự trừng phạt công minh của pháp luật.'
WHERE id = 'cfc61921-f3f1-44c1-8b62-517a89a38a08' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cfc61921-f3f1-44c1-8b62-517a89a38a08', '任何人触犯了国家的刑事法律，都必须接受法律的公正惩罚。', 'Rènhé rén chùfàn le guójiā de xíngshì fǎlǜ, dōu bìxū jiēshòu fǎlǜ de gōngzhèng chéngfá.', 'Bất cứ ai vi phạm luật hình sự của quốc gia đều phải chấp nhận sự trừng phạt công minh của pháp luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cfc61921-f3f1-44c1-8b62-517a89a38a08'
);

-- [承办] (chéngbàn): đảm đương, đứng ra giải quyết
UPDATE public.vocabularies
SET example_hanzi = '本市成功承办了第十五届全国水上运动会，赛事组织工作井然有序。',
    example_pinyin = 'Běn shì chénggōng chéngbàn le dì-shíwǔ jiè quánguó shuǐshàng yùndònghuì, sàishì zǔzhī gōngzuò jǐngrán-yǒuxù.',
    example_vi = 'Thành phố đã đảm đương đăng cai thành công Đại hội thể thao dưới nước toàn quốc lần thứ 15, công tác tổ chức giải diễn ra ngăn nắp trật tự.'
WHERE id = '75360ddb-b60c-426e-bd74-d78b8ad5aded' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '75360ddb-b60c-426e-bd74-d78b8ad5aded', '本市成功承办了第十五届全国水上运动会，赛事组织工作井然有序。', 'Běn shì chénggōng chéngbàn le dì-shíwǔ jiè quánguó shuǐshàng yùndònghuì, sàishì zǔzhī gōngzuò jǐngrán-yǒuxù.', 'Thành phố đã đảm đương đăng cai thành công Đại hội thể thao dưới nước toàn quốc lần thứ 15, công tác tổ chức giải diễn ra ngăn nắp trật tự.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '75360ddb-b60c-426e-bd74-d78b8ad5aded'
);

-- [称号] (chēnghào): danh hiệu
UPDATE public.vocabularies
SET example_hanzi = '李老师由于教学成绩突出，被教育部门授予了优秀人民教师的光荣称号。',
    example_pinyin = 'Lǐ lǎoshī yóuyú jiàoxué chéngjì tūchū, bèi jiàoyù bùmén shòuyǔ le yōuxiù rénmín jiàoshī de guāngróng chēnghào.',
    example_vi = 'Thầy giáo Lý nhờ thành tích giảng dạy nổi bật đã được ngành giáo dục trao tặng danh hiệu cao quý Nhà giáo nhân dân ưu tú.'
WHERE id = 'cac47e21-7c65-4422-8b0c-671f8305ae51' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cac47e21-7c65-4422-8b0c-671f8305ae51', '李老师由于教学成绩突出，被教育部门授予了优秀人民教师的光荣称号。', 'Lǐ lǎoshī yóuyú jiàoxué chéngjì tūchū, bèi jiàoyù bùmén shòuyǔ le yōuxiù rénmín jiàoshī de guāngróng chēnghào.', 'Thầy giáo Lý nhờ thành tích giảng dạy nổi bật đã được ngành giáo dục trao tặng danh hiệu cao quý Nhà giáo nhân dân ưu tú.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cac47e21-7c65-4422-8b0c-671f8305ae51'
);

-- [称呼] (chēnghu): xưng hô, gọi là
UPDATE public.vocabularies
SET example_hanzi = '在初次与外国客户见面时，应当使用规范恰当的商务称呼以示敬重。',
    example_pinyin = 'Zài chūcì yǔ wàiguó kèhù jiànmiàn shí, yīngdāng shǐyòng guīfàn qiàdàng de shāngwù chēnghu yǐ shì jìngzhòng.',
    example_vi = 'Khi lần đầu gặp gỡ khách hàng nước ngoài, nên dùng cách xưng hô thương mại chuẩn mực thỏa đáng để tỏ lòng kính trọng.'
WHERE id = 'c2a03e99-63e9-4a28-91fc-190e1ce0b812' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c2a03e99-63e9-4a28-91fc-190e1ce0b812', '在初次与外国客户见面时，应当使用规范恰当的商务称呼以示敬重。', 'Zài chūcì yǔ wàiguó kèhù jiànmiàn shí, yīngdāng shǐyòng guīfàn qiàdàng de shāngwù chēnghu yǐ shì jìngzhòng.', 'Khi lần đầu gặp gỡ khách hàng nước ngoài, nên dùng cách xưng hô thương mại chuẩn mực thỏa đáng để tỏ lòng kính trọng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c2a03e99-63e9-4a28-91fc-190e1ce0b812'
);

-- [成交] (chéngjiāo): giao dịch thành công, chốt đơn
UPDATE public.vocabularies
SET example_hanzi = '经过为期三天的商务洽谈，两家跨国企业成功成交了一笔巨额订单。',
    example_pinyin = 'Jīngguò wéiqī sān tiān de shāngwù qiàtán, liǎng jiā kuàguó qǐyè chénggōng chéngjiāo le yì bǐ jù''é dìngdān.',
    example_vi = 'Trải qua ba ngày đàm phán thương mại, hai doanh nghiệp xuyên quốc gia đã chốt giao dịch thành công một đơn hàng trị giá lớn.'
WHERE id = '4fc1b6f6-0d28-4f4f-b39b-e8d2d881601a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4fc1b6f6-0d28-4f4f-b39b-e8d2d881601a', '经过为期三天的商务洽谈，两家跨国企业成功成交了一笔巨额订单。', 'Jīngguò wéiqī sān tiān de shāngwù qiàtán, liǎng jiā kuàguó qǐyè chénggōng chéngjiāo le yì bǐ jù''é dìngdān.', 'Trải qua ba ngày đàm phán thương mại, hai doanh nghiệp xuyên quốc gia đã chốt giao dịch thành công một đơn hàng trị giá lớn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4fc1b6f6-0d28-4f4f-b39b-e8d2d881601a'
);

-- [承诺] (chéngnuò): cam kết, lời hứa
UPDATE public.vocabularies
SET example_hanzi = '信守诺言是做人的根本准则，一旦向客户做出承诺就必须坚决兑现。',
    example_pinyin = 'Xìnshǒu nuòyán shì zuòrén de gēnběn zhǔnzé, yídàn xiàng kèhù zuòchū chéngnuò jiù bìxū jiānjué duìxiàn.',
    example_vi = 'Giữ đúng lời hứa là nguyên tắc cơ bản làm người, một khi đã cam kết với khách hàng thì phải kiên quyết thực hiện.'
WHERE id = '4977e8a9-2ca6-4aa9-aa58-d901baaaeb36' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4977e8a9-2ca6-4aa9-aa58-d901baaaeb36', '信守诺言是做人的根本准则，一旦向客户做出承诺就必须坚决兑现。', 'Xìnshǒu nuòyán shì zuòrén de gēnběn zhǔnzé, yídàn xiàng kèhù zuòchū chéngnuò jiù bìxū jiānjué duìxiàn.', 'Giữ đúng lời hứa là nguyên tắc cơ bản làm người, một khi đã cam kết với khách hàng thì phải kiên quyết thực hiện.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4977e8a9-2ca6-4aa9-aa58-d901baaaeb36'
);

-- [呈现] (chéngxiàn): hiện ra, xuất hiện
UPDATE public.vocabularies
SET example_hanzi = '春天的植物园里百花竞放，呈现出一派生机盎然的蓬勃景象。',
    example_pinyin = 'Chūntiān de zhíwùyuán lǐ bǎihuā-jìngfàng, chéngxiàn chū yí pài shēngjī-àngrán de péngbó jǐngxiàng.',
    example_vi = 'Vườn bách thảo vào mùa xuân trăm hoa đua nở, hiện ra một cảnh tượng bừng bừng sức sống dạt dào.'
WHERE id = '443e2be6-e714-4f14-b065-372132f97bc4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '443e2be6-e714-4f14-b065-372132f97bc4', '春天的植物园里百花竞放，呈现出一派生机盎然的蓬勃景象。', 'Chūntiān de zhíwùyuán lǐ bǎihuā-jìngfàng, chéngxiàn chū yí pài shēngjī-àngrán de péngbó jǐngxiàng.', 'Vườn bách thảo vào mùa xuân trăm hoa đua nở, hiện ra một cảnh tượng bừng bừng sức sống dạt dào.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '443e2be6-e714-4f14-b065-372132f97bc4'
);

-- [成效] (chéngxiào): hiệu quả, kết quả
UPDATE public.vocabularies
SET example_hanzi = '政府推行节能减排政策三年以来，空气质量改善取得了显著成效。',
    example_pinyin = 'Zhèngfǔ tuīxíng jiénéng jiǎnpái zhèngcè sān nián yǐlái, kōngqì zhìliàng gǎishàn qǔdé le xiǎnzhù chéngxiào.',
    example_vi = 'Chính phủ triển khai chính sách tiết kiệm năng lượng giảm phát thải ba năm qua, việc cải thiện chất lượng không khí đã đạt hiệu quả rõ rệt.'
WHERE id = '21eb5881-792d-4806-befa-a685a095a630' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '21eb5881-792d-4806-befa-a685a095a630', '政府推行节能减排政策三年以来，空气质量改善取得了显著成效。', 'Zhèngfǔ tuīxíng jiénéng jiǎnpái zhèngcè sān nián yǐlái, kōngqì zhìliàng gǎishàn qǔdé le xiǎnzhù chéngxiào.', 'Chính phủ triển khai chính sách tiết kiệm năng lượng giảm phát thải ba năm qua, việc cải thiện chất lượng không khí đã đạt hiệu quả rõ rệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '21eb5881-792d-4806-befa-a685a095a630'
);

-- [成语] (chéngyǔ): thành ngữ
UPDATE public.vocabularies
SET example_hanzi = '汉语成语往往言简意赅，背后蕴含着丰富深刻的历史典故与哲学智慧。',
    example_pinyin = 'Hànyǔ chéngyǔ wǎngwǎng yánjiǎn-yìgāi, bèihòu yùnhán zhe fēngfù shēnkè de lìshǐ diǎngù yǔ zhéxué zhìhuì.',
    example_vi = 'Thành ngữ tiếng Hán thường lời ít ý nhiều, đằng sau ẩn chứa những điển cố lịch sử và trí tuệ triết học phong phú sâu sắc.'
WHERE id = '82723c28-6a60-4527-bed2-7fa88e910101' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '82723c28-6a60-4527-bed2-7fa88e910101', '汉语成语往往言简意赅，背后蕴含着丰富深刻的历史典故与哲学智慧。', 'Hànyǔ chéngyǔ wǎngwǎng yánjiǎn-yìgāi, bèihòu yùnhán zhe fēngfù shēnkè de lìshǐ diǎngù yǔ zhéxué zhìhuì.', 'Thành ngữ tiếng Hán thường lời ít ý nhiều, đằng sau ẩn chứa những điển cố lịch sử và trí tuệ triết học phong phú sâu sắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '82723c28-6a60-4527-bed2-7fa88e910101'
);

-- [沉重] (chénzhòng): nặng nề, trầm trọng
UPDATE public.vocabularies
SET example_hanzi = '得知灾区同胞遭受洪涝灾害的不幸消息，大家的心情格外沉重。',
    example_pinyin = 'Dézhī zāiqū tóngbāo zāoshòu hónglào zāihài de búxìng xiāoxi, dàjiā de xīnqíng géwài chénzhòng.',
    example_vi = 'Hay tin đồng bào vùng lũ hứng chịu thiên tai ngập úng không may, tâm trạng của mọi người vô cùng nặng nề.'
WHERE id = 'bab8f1f2-681f-409a-91d9-3809408fb377' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bab8f1f2-681f-409a-91d9-3809408fb377', '得知灾区同胞遭受洪涝灾害的不幸消息，大家的心情格外沉重。', 'Dézhī zāiqū tóngbāo zāoshòu hónglào zāihài de búxìng xiāoxi, dàjiā de xīnqíng géwài chénzhòng.', 'Hay tin đồng bào vùng lũ hứng chịu thiên tai ngập úng không may, tâm trạng của mọi người vô cùng nặng nề.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bab8f1f2-681f-409a-91d9-3809408fb377'
);

-- [撤销] (chèxiāo): hủy bỏ, thu hồi
UPDATE public.vocabularies
SET example_hanzi = '因该公司存在严重虚报财务数据的欺诈行为，监管部门依法撤销了其营业执照。',
    example_pinyin = 'Yīn gāi gōngsī cúnzài yánzhòng xūbào cáiwù shùjù de qīzhà xíngwéi, jiānguǎn bùmén yīfǎ chèxiāo le qí yíngyè zhízhào.',
    example_vi = 'Do công ty này có hành vi gian lận khai man số liệu tài chính nghiêm trọng, cơ quan giám sát đã hủy bỏ giấy phép kinh doanh theo luật.'
WHERE id = '3fd87adb-ef30-48f1-87ed-d12f8644e378' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3fd87adb-ef30-48f1-87ed-d12f8644e378', '因该公司存在严重虚报财务数据的欺诈行为，监管部门依法撤销了其营业执照。', 'Yīn gāi gōngsī cúnzài yánzhòng xūbào cáiwù shùjù de qīzhà xíngwéi, jiānguǎn bùmén yīfǎ chèxiāo le qí yíngyè zhízhào.', 'Do công ty này có hành vi gian lận khai man số liệu tài chính nghiêm trọng, cơ quan giám sát đã hủy bỏ giấy phép kinh doanh theo luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3fd87adb-ef30-48f1-87ed-d12f8644e378'
);

-- [持久] (chí jiǔ): lâu bền, bền bỉ
UPDATE public.vocabularies
SET example_hanzi = '唯有依靠扎实的技术积累和过硬的产品质量，品牌才能保持持久的竞争力。',
    example_pinyin = 'Wéiyǒu yīkào zhāshi de jìshù jīlěi hé guòyìng de chǎnpǐn zhìliàng, pǐnpái cái néng bǎochí chíjiǔ de jìngzhēnglì.',
    example_vi = 'Chỉ có dựa vào sự tích lũy công nghệ vững vàng và chất lượng sản phẩm chuẩn xác, thương hiệu mới duy trì được sức cạnh tranh lâu bền.'
WHERE id = '4b4d0885-3fab-44c6-9082-8a80dab85036' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4b4d0885-3fab-44c6-9082-8a80dab85036', '唯有依靠扎实的技术积累和过硬的产品质量，品牌才能保持持久的竞争力。', 'Wéiyǒu yīkào zhāshi de jìshù jīlěi hé guòyìng de chǎnpǐn zhìliàng, pǐnpái cái néng bǎochí chíjiǔ de jìngzhēnglì.', 'Chỉ có dựa vào sự tích lũy công nghệ vững vàng và chất lượng sản phẩm chuẩn xác, thương hiệu mới duy trì được sức cạnh tranh lâu bền.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4b4d0885-3fab-44c6-9082-8a80dab85036'
);

-- [崇拜] (chóng bài): sùng bái
UPDATE public.vocabularies
SET example_hanzi = '很多年轻人十分崇拜这位凭借刻苦钻研打破世界纪录的杰出科学家。',
    example_pinyin = 'Hěn duō niánqīngrén shífēn chóngbài zhè wèi píngjiè kèkǔ zuānyán dǎpò shìjiè jìlù de jiéchū kēxuéjiā.',
    example_vi = 'Rất nhiều người trẻ tuổi vô cùng sùng bái nhà khoa học kiệt xuất đã nhờ dày công nghiên cứu mà phá vỡ kỷ lục thế giới.'
WHERE id = '7593bb61-b2a1-4c40-95c9-7731e0a2fced' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7593bb61-b2a1-4c40-95c9-7731e0a2fced', '很多年轻人十分崇拜这位凭借刻苦钻研打破世界纪录的杰出科学家。', 'Hěn duō niánqīngrén shífēn chóngbài zhè wèi píngjiè kèkǔ zuānyán dǎpò shìjiè jìlù de jiéchū kēxuéjiā.', 'Rất nhiều người trẻ tuổi vô cùng sùng bái nhà khoa học kiệt xuất đã nhờ dày công nghiên cứu mà phá vỡ kỷ lục thế giới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7593bb61-b2a1-4c40-95c9-7731e0a2fced'
);

-- [冲动] (chōngdòng): bốc đồng, kích động
UPDATE public.vocabularies
SET example_hanzi = '遇到突发纠纷时切忌情绪冲动，理性克制才能找到最妥善的解决办法。',
    example_pinyin = 'Yùdào tūfā jiūfēn shí qièjì qíngxù chōngdòng, lǐxìng kèzhì cái néng zhǎodào zuì tuǒshàn de jiějué bànfǎ.',
    example_vi = 'Khi gặp tranh chấp bất ngờ tuyệt đối chớ để cảm xúc bốc đồng, kiềm chế lý trí mới có thể tìm ra phương án giải quyết thỏa đáng nhất.'
WHERE id = 'f7a69563-4851-4ca7-9181-12519163bf71' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f7a69563-4851-4ca7-9181-12519163bf71', '遇到突发纠纷时切忌情绪冲动，理性克制才能找到最妥善的解决办法。', 'Yùdào tūfā jiūfēn shí qièjì qíngxù chōngdòng, lǐxìng kèzhì cái néng zhǎodào zuì tuǒshàn de jiějué bànfǎ.', 'Khi gặp tranh chấp bất ngờ tuyệt đối chớ để cảm xúc bốc đồng, kiềm chế lý trí mới có thể tìm ra phương án giải quyết thỏa đáng nhất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f7a69563-4851-4ca7-9181-12519163bf71'
);

-- [冲击] (chōngjī): tác động mạnh, va chạm, xung kích
UPDATE public.vocabularies
SET example_hanzi = '互联网电子商务的迅速普及，给传统实体零售店铺带来了巨大的市场冲击。',
    example_pinyin = 'Hùliánwǎng diànzǐ shāngwù de xùnsù pǔjí, gěi chuántǒng shítǐ língshòu diànpù dài lái le jùdà de shìchǎng chōngjī.',
    example_vi = 'Sự phổ cập nhanh chóng của thương mại điện tử internet đã mang đến sự tác động xung kích to lớn cho các cửa hàng bán lẻ truyền thống.'
WHERE id = '572378a8-6701-4684-9ea1-8539ddf5d2ac' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '572378a8-6701-4684-9ea1-8539ddf5d2ac', '互联网电子商务的迅速普及，给传统实体零售店铺带来了巨大的市场冲击。', 'Hùliánwǎng diànzǐ shāngwù de xùnsù pǔjí, gěi chuántǒng shítǐ língshòu diànpù dài lái le jùdà de shìchǎng chōngjī.', 'Sự phổ cập nhanh chóng của thương mại điện tử internet đã mang đến sự tác động xung kích to lớn cho các cửa hàng bán lẻ truyền thống.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '572378a8-6701-4684-9ea1-8539ddf5d2ac'
);

-- [充实] (chōngshí): dồi dào, phong phú, làm đầy
UPDATE public.vocabularies
SET example_hanzi = '利用假期阅读经典名著和参与社会实践，能让大学生的课余生活变得格外充实。',
    example_pinyin = 'Lìyòng jiàqī yuèdú jīngdiǎn míngzhù hé cānyù shèhuì shíjiàn, néng ràng dàxuésheng de kèyú shēnghuó biàn de géwài chōngshí.',
    example_vi = 'Tận dụng kỳ nghỉ đọc danh tác kinh điển và tham gia trải nghiệm xã hội có thể khiến cuộc sống ngoại khóa của sinh viên trở nên vô cùng phong phú.'
WHERE id = '10e3cdc7-481a-4d1d-b5bc-fe4ce0f62d6e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '10e3cdc7-481a-4d1d-b5bc-fe4ce0f62d6e', '利用假期阅读经典名著和参与社会实践，能让大学生的课余生活变得格外充实。', 'Lìyòng jiàqī yuèdú jīngdiǎn míngzhù hé cānyù shèhuì shíjiàn, néng ràng dàxuésheng de kèyú shēnghuó biàn de géwài chōngshí.', 'Tận dụng kỳ nghỉ đọc danh tác kinh điển và tham gia trải nghiệm xã hội có thể khiến cuộc sống ngoại khóa của sinh viên trở nên vô cùng phong phú.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '10e3cdc7-481a-4d1d-b5bc-fe4ce0f62d6e'
);

-- [冲突] (chōngtū): xung đột, va chạm
UPDATE public.vocabularies
SET example_hanzi = '在跨文化团队协作中，各方应尊重彼此习俗，避免因沟通不畅引发文化冲突。',
    example_pinyin = 'Zài kuà wénhuà tuánduì xiézuò zhōng, gè fāng yīng zūnzhòng bǐcǐ xísú, bìmiǎn yīn gōutōng bú chàng yǐnfā wénhuà chōngtū.',
    example_vi = 'Trong hợp tác đội ngũ đa văn hóa, các bên nên tôn trọng phong tục của nhau, tránh vì giao tiếp chưa thông mà gây ra xung đột văn hóa.'
WHERE id = '968481da-df61-47da-9e2a-5344c2ee10f5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '968481da-df61-47da-9e2a-5344c2ee10f5', '在跨文化团队协作中，各方应尊重彼此习俗，避免因沟通不畅引发文化冲突。', 'Zài kuà wénhuà tuánduì xiézuò zhōng, gè fāng yīng zūnzhòng bǐcǐ xísú, bìmiǎn yīn gōutōng bú chàng yǐnfā wénhuà chōngtū.', 'Trong hợp tác đội ngũ đa văn hóa, các bên nên tôn trọng phong tục của nhau, tránh vì giao tiếp chưa thông mà gây ra xung đột văn hóa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '968481da-df61-47da-9e2a-5344c2ee10f5'
);

-- [筹备] (chóubèi): chuẩn bị, trù bị
UPDATE public.vocabularies
SET example_hanzi = '组委会经过长达半年的周密筹备，国际青年文化交流节终于隆重拉开帷幕。',
    example_pinyin = 'Zǔwěihuì jīngguò cháng dá bàn nián de zhōumì chóubèi, guójì qīngnián wénhuà jiāoliú jié zhōngyú lóngzhòng lākāi wéimù.',
    example_vi = 'Ban tổ chức qua nửa năm trù bị chu đáo, Lễ hội giao lưu văn hóa thanh niên quốc tế cuối cùng cũng long trọng mở màn.'
WHERE id = '48af543d-7382-4b9d-8de7-b5c8bc9c80c2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '48af543d-7382-4b9d-8de7-b5c8bc9c80c2', '组委会经过长达半年的周密筹备，国际青年文化交流节终于隆重拉开帷幕。', 'Zǔwěihuì jīngguò cháng dá bàn nián de zhōumì chóubèi, guójì qīngnián wénhuà jiāoliú jié zhōngyú lóngzhòng lākāi wéimù.', 'Ban tổ chức qua nửa năm trù bị chu đáo, Lễ hội giao lưu văn hóa thanh niên quốc tế cuối cùng cũng long trọng mở màn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '48af543d-7382-4b9d-8de7-b5c8bc9c80c2'
);

-- [抽象] (chōuxiàng): trừu tượng
UPDATE public.vocabularies
SET example_hanzi = '高阶数学概念往往较为抽象，老师常用几何图形帮助大家直观理解。',
    example_pinyin = 'Gāojiē shùxué gàiniàn wǎngwǎng jiàowéi chōuxiàng, lǎoshī cháng yòng jǐhé túxíng bāngzhù dàjiā zhíguān lǐjiě.',
    example_vi = 'Các khái niệm toán học bậc cao thường khá trừu tượng, giáo viên thường dùng hình học để giúp học sinh nắm bắt trực quan.'
WHERE id = '8fbca0d3-2ae3-433e-825f-cee55c442ea0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8fbca0d3-2ae3-433e-825f-cee55c442ea0', '高阶数学概念往往较为抽象，老师常用几何图形帮助大家直观理解。', 'Gāojiē shùxué gàiniàn wǎngwǎng jiàowéi chōuxiàng, lǎoshī cháng yòng jǐhé túxíng bāngzhù dàjiā zhíguān lǐjiě.', 'Các khái niệm toán học bậc cao thường khá trừu tượng, giáo viên thường dùng hình học để giúp học sinh nắm bắt trực quan.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8fbca0d3-2ae3-433e-825f-cee55c442ea0'
);

-- [除] (chú): trừ, ngoại trừ
UPDATE public.vocabularies
SET example_hanzi = '除星期天闭馆检修设备外，市图书馆每天从早晨八点向市民开放借阅。',
    example_pinyin = 'Chú xīngqītiān bìguǎn jiǎnxiū shèbèi wài, shì túshūguǎn měitiān cóng zǎochén bā diǎn xiàng shìmín kāifàng jièyuè.',
    example_vi = 'Trừ ngày chủ nhật đóng cửa bảo trì thiết bị ra, thư viện thành phố mở cửa phục vụ bạn đọc từ tám giờ sáng mỗi ngày.'
WHERE id = 'f1dadc28-6424-4341-95af-3271bbbf7eb9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f1dadc28-6424-4341-95af-3271bbbf7eb9', '除星期天闭馆检修设备外，市图书馆每天从早晨八点向市民开放借阅。', 'Chú xīngqītiān bìguǎn jiǎnxiū shèbèi wài, shì túshūguǎn měitiān cóng zǎochén bā diǎn xiàng shìmín kāifàng jièyuè.', 'Trừ ngày chủ nhật đóng cửa bảo trì thiết bị ra, thư viện thành phố mở cửa phục vụ bạn đọc từ tám giờ sáng mỗi ngày.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f1dadc28-6424-4341-95af-3271bbbf7eb9'
);

-- [串] (chuàn): xâu, chuỗi; kết nối
UPDATE public.vocabularies
SET example_hanzi = '走在老街集市上，孩子们手里拿着一串晶莹剔透、酸甜可口的糖葫芦。',
    example_pinyin = 'Zǒu zài lǎojiē jíshì shang, háizi men shǒulǐ ná zhe yí chuàn jīngyíng-tītòu, suāntián kěkǒu de tánghúlu.',
    example_vi = 'Đi trên chợ phố cổ, trong tay lũ trẻ cầm một xâu kẹo hồ lô óng ánh trong veo, chua ngọt thơm ngon.'
WHERE id = '1351d455-11b4-49a4-8369-207ee453a3ad' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1351d455-11b4-49a4-8369-207ee453a3ad', '走在老街集市上，孩子们手里拿着一串晶莹剔透、酸甜可口的糖葫芦。', 'Zǒu zài lǎojiē jíshì shang, háizi men shǒulǐ ná zhe yí chuàn jīngyíng-tītòu, suāntián kěkǒu de tánghúlu.', 'Đi trên chợ phố cổ, trong tay lũ trẻ cầm một xâu kẹo hồ lô óng ánh trong veo, chua ngọt thơm ngon.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1351d455-11b4-49a4-8369-207ee453a3ad'
);

-- [传达] (chuándá): truyền đạt, thông báo
UPDATE public.vocabularies
SET example_hanzi = '办公室主任迅速将上级关于安全生产的紧急指示准确传达给各部门。',
    example_pinyin = 'Bàngōngshì zhǔrèn xùnsù jiāng shàngjí guānyú ānquán shēngchǎn de jǐnjí zhǐshì zhǔnquè chuándá gěi gè bùmén.',
    example_vi = 'Chánh văn phòng nhanh chóng truyền đạt chính xác chỉ thị khẩn cấp về an toàn sản xuất của cấp trên tới các phòng ban.'
WHERE id = 'dc702185-d99e-4c06-81ab-52c8a7debebf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dc702185-d99e-4c06-81ab-52c8a7debebf', '办公室主任迅速将上级关于安全生产的紧急指示准确传达给各部门。', 'Bàngōngshì zhǔrèn xùnsù jiāng shàngjí guānyú ānquán shēngchǎn de jǐnjí zhǐshì zhǔnquè chuándá gěi gè bùmén.', 'Chánh văn phòng nhanh chóng truyền đạt chính xác chỉ thị khẩn cấp về an toàn sản xuất của cấp trên tới các phòng ban.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dc702185-d99e-4c06-81ab-52c8a7debebf'
);

-- [创立] (chuànglì): sáng lập, thành lập
UPDATE public.vocabularies
SET example_hanzi = '这位富有远见的年轻企业家在大学毕业那年创立了自己的生物制药公司。',
    example_pinyin = 'Zhè wèi fùyǒu yuǎnjiàn de niánqīng qǐyèjiā zài dàxué bìyè nà nián chuànglì le zìjǐ de shēngwù zhìyào gōngsī.',
    example_vi = 'Nhà doanh nghiệp trẻ đầy viễn kiến này vào năm tốt nghiệp đại học đã sáng lập công ty sản xuất dược sinh học của riêng mình.'
WHERE id = '30c0b436-a84f-4d9a-b8c3-32f17668dad7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '30c0b436-a84f-4d9a-b8c3-32f17668dad7', '这位富有远见的年轻企业家在大学毕业那年创立了自己的生物制药公司。', 'Zhè wèi fùyǒu yuǎnjiàn de niánqīng qǐyèjiā zài dàxué bìyè nà nián chuànglì le zìjǐ de shēngwù zhìyào gōngsī.', 'Nhà doanh nghiệp trẻ đầy viễn kiến này vào năm tốt nghiệp đại học đã sáng lập công ty sản xuất dược sinh học của riêng mình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '30c0b436-a84f-4d9a-b8c3-32f17668dad7'
);

-- [传染] (chuánrǎn): truyền nhiễm, lây nhiễm
UPDATE public.vocabularies
SET example_hanzi = '秋末冬初是流感等呼吸道传染病的高发季节，公共场所应加强通风消毒。',
    example_pinyin = 'Qiūmò dōngchū shì liúgǎn děng hūxīdào chuánrǎnbìng de gāofā jìjié, gōnggòng chǎngsuǒ yīng jiāqiáng tōngfēng xiāodú.',
    example_vi = 'Cuối thu đầu đông là mùa cao điểm của các bệnh truyền nhiễm đường hô hấp như cúm mùa, nơi công cộng nên tăng cường thông gió khử khuẩn.'
WHERE id = 'b06cbc16-978d-4875-9ea2-6a512cba61b2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b06cbc16-978d-4875-9ea2-6a512cba61b2', '秋末冬初是流感等呼吸道传染病的高发季节，公共场所应加强通风消毒。', 'Qiūmò dōngchū shì liúgǎn děng hūxīdào chuánrǎnbìng de gāofā jìjié, gōnggòng chǎngsuǒ yīng jiāqiáng tōngfēng xiāodú.', 'Cuối thu đầu đông là mùa cao điểm của các bệnh truyền nhiễm đường hô hấp như cúm mùa, nơi công cộng nên tăng cường thông gió khử khuẩn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b06cbc16-978d-4875-9ea2-6a512cba61b2'
);

-- [传授] (chuánshòu): truyền thụ, truyền dạy
UPDATE public.vocabularies
SET example_hanzi = '老工艺师毫无保留地把家族世代相传的陶瓷雕刻技艺传授给青年学徒。',
    example_pinyin = 'Lǎo gōngyìshī háowú bǎoliú de bǎ jiāzú shìdài-xiāngchuán de táocí diāokè jìyì chuánshòu gěi qīngnián xuétú.',
    example_vi = 'Nghệ nhân già không hề giấu nghề, đem bí quyết điêu khắc gốm sứ gia truyền nhiều đời truyền dạy cho các học việc trẻ.'
WHERE id = '442f36b4-3a14-4c6a-89cb-b65f3c2d0e7f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '442f36b4-3a14-4c6a-89cb-b65f3c2d0e7f', '老工艺师毫无保留地把家族世代相传的陶瓷雕刻技艺传授给青年学徒。', 'Lǎo gōngyìshī háowú bǎoliú de bǎ jiāzú shìdài-xiāngchuán de táocí diāokè jìyì chuánshòu gěi qīngnián xuétú.', 'Nghệ nhân già không hề giấu nghề, đem bí quyết điêu khắc gốm sứ gia truyền nhiều đời truyền dạy cho các học việc trẻ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '442f36b4-3a14-4c6a-89cb-b65f3c2d0e7f'
);

-- [初步] (chūbù): sơ bộ, bước đầu
UPDATE public.vocabularies
SET example_hanzi = '两家科研机构经过友好协商，就共同开发清洁能源达成了初步合作意向。',
    example_pinyin = 'Liǎng jiā kēyán jīgòu jīngguò yǒuhǎo xiéshāng, jiù gòngtóng kāifā qīngjié néngyuán dáchéng le chūbù hézuò yìxiàng.',
    example_vi = 'Hai viện nghiên cứu khoa học qua đàm phán hữu nghị đã đạt được ý định hợp tác sơ bộ về việc cùng phát triển năng lượng sạch.'
WHERE id = '20ce3759-c9eb-47b8-af0a-6912c7150442' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '20ce3759-c9eb-47b8-af0a-6912c7150442', '两家科研机构经过友好协商，就共同开发清洁能源达成了初步合作意向。', 'Liǎng jiā kēyán jīgòu jīngguò yǒuhǎo xiéshāng, jiù gòngtóng kāifā qīngjié néngyuán dáchéng le chūbù hézuò yìxiàng.', 'Hai viện nghiên cứu khoa học qua đàm phán hữu nghị đã đạt được ý định hợp tác sơ bộ về việc cùng phát triển năng lượng sạch.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '20ce3759-c9eb-47b8-af0a-6912c7150442'
);

-- [储存] (chǔcún): lưu trữ, tích trữ
UPDATE public.vocabularies
SET example_hanzi = '国家粮食储备库配备了智能化温湿度监控系统，确保粮食储存安全无忧。',
    example_pinyin = 'Guójiā liángshi chǔbèikù pèibèi le zhìnénghuà wēn-shīdù jiānkòng xìtǒng, quèbǎo liángshi chǔcún ānquán wúyōu.',
    example_vi = 'Kho dự trữ lương thực quốc gia được trang bị hệ thống giám sát nhiệt độ và độ ẩm thông minh, bảo đảm việc tích trữ lương thực an toàn tuyệt đối.'
WHERE id = 'b49c2b27-825e-4ac5-bda7-2f5174d1fc4b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b49c2b27-825e-4ac5-bda7-2f5174d1fc4b', '国家粮食储备库配备了智能化温湿度监控系统，确保粮食储存安全无忧。', 'Guójiā liángshi chǔbèikù pèibèi le zhìnénghuà wēn-shīdù jiānkòng xìtǒng, quèbǎo liángshi chǔcún ānquán wúyōu.', 'Kho dự trữ lương thực quốc gia được trang bị hệ thống giám sát nhiệt độ và độ ẩm thông minh, bảo đảm việc tích trữ lương thực an toàn tuyệt đối.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b49c2b27-825e-4ac5-bda7-2f5174d1fc4b'
);

-- [垂直] (chuízhí): thẳng đứng, vuông góc
UPDATE public.vocabularies
SET example_hanzi = '在精密工程建设中，施工人员利用激光准直仪确保钢梁结构严格保持垂直。',
    example_pinyin = 'Zài jīngmì gōngchéng jiànshè zhōng, shīgōng rényuán lìyòng jīguāng zhǔnzhíyí quèbǎo gāngliáng jiégòu yángé bǎochí chuízhí.',
    example_vi = 'Trong xây dựng công trình chính xác, nhân viên thi công sử dụng máy cân bằng laser bảo đảm dầm thép duy trì phương thẳng đứng nghiêm ngặt.'
WHERE id = 'e93db931-7c82-4f52-ade1-e0263bd02c4a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e93db931-7c82-4f52-ade1-e0263bd02c4a', '在精密工程建设中，施工人员利用激光准直仪确保钢梁结构严格保持垂直。', 'Zài jīngmì gōngchéng jiànshè zhōng, shīgōng rényuán lìyòng jīguāng zhǔnzhíyí quèbǎo gāngliáng jiégòu yángé bǎochí chuízhí.', 'Trong xây dựng công trình chính xác, nhân viên thi công sử dụng máy cân bằng laser bảo đảm dầm thép duy trì phương thẳng đứng nghiêm ngặt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e93db931-7c82-4f52-ade1-e0263bd02c4a'
);

-- [出示] (chūshì): xuất trình, đưa ra
UPDATE public.vocabularies
SET example_hanzi = '旅客通过海关入境检查通道时，请提前出示本人有效护照及登机牌。',
    example_pinyin = 'Lǚkè tōngguò hǎiguān rùjìng jiǎnchá tōngdào shí, qǐng tíqián chūshì běnrén yǒuxiào hùzhào jí dēngjīpái.',
    example_vi = 'Khi hành khách đi qua cửa kiểm tra nhập cảnh hải quan, xin vui lòng xuất trình hộ chiếu hợp lệ và thẻ lên máy bay từ trước.'
WHERE id = 'a8c58e2c-5458-463f-b073-166ee77e502b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a8c58e2c-5458-463f-b073-166ee77e502b', '旅客通过海关入境检查通道时，请提前出示本人有效护照及登机牌。', 'Lǚkè tōngguò hǎiguān rùjìng jiǎnchá tōngdào shí, qǐng tíqián chūshì běnrén yǒuxiào hùzhào jí dēngjīpái.', 'Khi hành khách đi qua cửa kiểm tra nhập cảnh hải quan, xin vui lòng xuất trình hộ chiếu hợp lệ và thẻ lên máy bay từ trước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a8c58e2c-5458-463f-b073-166ee77e502b'
);

-- [储蓄] (chǔxù): tiết kiệm, gửi tiết kiệm
UPDATE public.vocabularies
SET example_hanzi = '养成每月定期储蓄的良好财务习惯，能够为未来应对突发情况提供坚实保障。',
    example_pinyin = 'Yǎngchéng měi yuè dìngqī chǔxù de liánghǎo cáiwù xíguàn, nénggòu wèi wèilái yìngduì tūfā qíngkuàng tígōng jiānshí bǎozhàng.',
    example_vi = 'Xây dựng thói quen tài chính tốt gửi tiết kiệm định kỳ hàng tháng có thể cung cấp điểm tựa vững chắc để ứng phó rủi ro bất ngờ trong tương lai.'
WHERE id = '2297d47e-670e-4be3-af1e-c0566e1f318a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2297d47e-670e-4be3-af1e-c0566e1f318a', '养成每月定期储蓄的良好财务习惯，能够为未来应对突发情况提供坚实保障。', 'Yǎngchéng měi yuè dìngqī chǔxù de liánghǎo cáiwù xíguàn, nénggòu wèi wèilái yìngduì tūfā qíngkuàng tígōng jiānshí bǎozhàng.', 'Xây dựng thói quen tài chính tốt gửi tiết kiệm định kỳ hàng tháng có thể cung cấp điểm tựa vững chắc để ứng phó rủi ro bất ngờ trong tương lai.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2297d47e-670e-4be3-af1e-c0566e1f318a'
);

-- [刺] (cì): gai; đâm, chích
UPDATE public.vocabularies
SET example_hanzi = '院子里盛开的玫瑰花虽然娇艳动人，但是枝条上长满了锋利的小刺。',
    example_pinyin = 'Yuànzi lǐ shèngkāi de méiguīhuā suīrán jiāoyàn dòngrén, dànshì zhītiáo shang zhǎng mǎn le fēnglì de xiǎocì.',
    example_vi = 'Hoa hồng nở rộ trong vườn tuy kiều diễm say đắm lòng người, nhưng trên cành lại mọc đầy những chiếc gai nhỏ sắc nhọn.'
WHERE id = '438d1bbc-c135-4a25-b944-1e3d595025d0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '438d1bbc-c135-4a25-b944-1e3d595025d0', '院子里盛开的玫瑰花虽然娇艳动人，但是枝条上长满了锋利的小刺。', 'Yuànzi lǐ shèngkāi de méiguīhuā suīrán jiāoyàn dòngrén, dànshì zhītiáo shang zhǎng mǎn le fēnglì de xiǎocì.', 'Hoa hồng nở rộ trong vườn tuy kiều diễm say đắm lòng người, nhưng trên cành lại mọc đầy những chiếc gai nhỏ sắc nhọn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '438d1bbc-c135-4a25-b944-1e3d595025d0'
);

-- [匆忙] (cōngmáng): vội vã, gấp gáp
UPDATE public.vocabularies
SET example_hanzi = '由于早上闹钟没有响，他匆忙吃了一片面包便抓起公文包跑出了家门。',
    example_pinyin = 'Yóuyú zǎoshang nàozhōng méiyǒu xiǎng, tā cōngmáng chī le yí piàn miànbāo biàn zhuā qǐ gōngwénbāo pǎo chū le jiāmén.',
    example_vi = 'Do chuông báo thức buổi sáng không reo, anh ấy vội vã ăn miếng bánh mì rồi xách cặp chạy vội ra khỏi cửa.'
WHERE id = 'cb93b5e9-bcc6-4192-b1c2-ca1bb013d5b7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cb93b5e9-bcc6-4192-b1c2-ca1bb013d5b7', '由于早上闹钟没有响，他匆忙吃了一片面包便抓起公文包跑出了家门。', 'Yóuyú zǎoshang nàozhōng méiyǒu xiǎng, tā cōngmáng chī le yí piàn miànbāo biàn zhuā qǐ gōngwénbāo pǎo chū le jiāmén.', 'Do chuông báo thức buổi sáng không reo, anh ấy vội vã ăn miếng bánh mì rồi xách cặp chạy vội ra khỏi cửa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cb93b5e9-bcc6-4192-b1c2-ca1bb013d5b7'
);

-- [脆弱] (cuì ruò): yếu đuối, mong manh
UPDATE public.vocabularies
SET example_hanzi = '高原荒漠地区的生态环境极其脆弱，一旦遭到破坏往往数十年都难以恢复。',
    example_pinyin = 'Gāoyuán huāngmò dìqū de shēngtài huánjìng jíqí cuìruò, yídàn zāodào pòhuài wǎngwǎng shùshí nián dōu nányǐ huīfù.',
    example_vi = 'Môi trường sinh thái vùng sa mạc cao nguyên cực kỳ mong manh dễ tổn thương, một khi bị hủy hoại thì hàng chục năm cũng khó hồi phục.'
WHERE id = 'c1ca6ad9-c70d-4438-a1e3-5bff54355392' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c1ca6ad9-c70d-4438-a1e3-5bff54355392', '高原荒漠地区的生态环境极其脆弱，一旦遭到破坏往往数十年都难以恢复。', 'Gāoyuán huāngmò dìqū de shēngtài huánjìng jíqí cuìruò, yídàn zāodào pòhuài wǎngwǎng shùshí nián dōu nányǐ huīfù.', 'Môi trường sinh thái vùng sa mạc cao nguyên cực kỳ mong manh dễ tổn thương, một khi bị hủy hoại thì hàng chục năm cũng khó hồi phục.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c1ca6ad9-c70d-4438-a1e3-5bff54355392'
);

-- [挫折] (cuò zhé): trắc trở, thất bại
UPDATE public.vocabularies
SET example_hanzi = '人生道路难免遇到挫折，只要百折不挠，每一次坎坷都将成为前进的垫脚石。',
    example_pinyin = 'Rénshēng dàolù nánmiǎn yùdào cuòzhé, zhǐyào bǎizhé-bùnáo, měi yí cì kǎnkě dōu jiāng chéngwéi qiánjìn de diànjiǎoshí.',
    example_vi = 'Đường đời khó tránh khỏi trắc trở, chỉ cần kiên định không sờn lòng thì mỗi lần ghập ghềnh đều sẽ trở thành viên đá lót đường tiến bước.'
WHERE id = '3ad882c0-a694-4e31-b2e6-83d812a5a65d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3ad882c0-a694-4e31-b2e6-83d812a5a65d', '人生道路难免遇到挫折，只要百折不挠，每一次坎坷都将成为前进的垫脚石。', 'Rénshēng dàolù nánmiǎn yùdào cuòzhé, zhǐyào bǎizhé-bùnáo, měi yí cì kǎnkě dōu jiāng chéngwéi qiánjìn de diànjiǎoshí.', 'Đường đời khó tránh khỏi trắc trở, chỉ cần kiên định không sờn lòng thì mỗi lần ghập ghềnh đều sẽ trở thành viên đá lót đường tiến bước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3ad882c0-a694-4e31-b2e6-83d812a5a65d'
);

-- [搭] (dā): dựng lên, đi nhờ, khớp
UPDATE public.vocabularies
SET example_hanzi = '村民们齐心协力在湍急的溪流上方搭建了一座结实安全的木桥。',
    example_pinyin = 'Cūnmín men qíxīn-xiélì zài tuānjí de xīliú shàngfāng dājiàn le yí zuò jiēshi ānquán de mùqiáo.',
    example_vi = 'Dân làng đồng lòng chung sức dựng lên một cây cầu gỗ chắc chắn an toàn bắc qua dòng suối chảy xiết.'
WHERE id = '0b7948a7-46c7-4c4b-82f7-2cd46380e8d5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0b7948a7-46c7-4c4b-82f7-2cd46380e8d5', '村民们齐心协力在湍急的溪流上方搭建了一座结实安全的木桥。', 'Cūnmín men qíxīn-xiélì zài tuānjí de xīliú shàngfāng dājiàn le yí zuò jiēshi ānquán de mùqiáo.', 'Dân làng đồng lòng chung sức dựng lên một cây cầu gỗ chắc chắn an toàn bắc qua dòng suối chảy xiết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0b7948a7-46c7-4c4b-82f7-2cd46380e8d5'
);

-- [打交道] (dǎ jiāodao): tiếp xúc, giao thiệp
UPDATE public.vocabularies
SET example_hanzi = '作为一名资深外贸业务员，他每天都需要与形形色色的国际客户打交道。',
    example_pinyin = 'Zuòwéi yì míng zīshēn wàimào yèwùyuán, tā měitiān dōu xūyào yǔ xíngxíng-sèsè de guójì kèhù dǎ jiāodao.',
    example_vi = 'Với tư cách là một nhân viên kinh doanh ngoại thương kỳ cựu, anh ấy mỗi ngày đều phải tiếp xúc giao thiệp với đủ kiểu khách hàng quốc tế.'
WHERE id = 'bf923e46-ba01-4e01-9597-8ef98586fde6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bf923e46-ba01-4e01-9597-8ef98586fde6', '作为一名资深外贸业务员，他每天都需要与形形色色的国际客户打交道。', 'Zuòwéi yì míng zīshēn wàimào yèwùyuán, tā měitiān dōu xūyào yǔ xíngxíng-sèsè de guójì kèhù dǎ jiāodao.', 'Với tư cách là một nhân viên kinh doanh ngoại thương kỳ cựu, anh ấy mỗi ngày đều phải tiếp xúc giao thiệp với đủ kiểu khách hàng quốc tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bf923e46-ba01-4e01-9597-8ef98586fde6'
);

-- [搭配] (dā pèi): kết hợp, phối hợp
UPDATE public.vocabularies
SET example_hanzi = '营养学家建议日常饮食要注意荤素合理搭配，保证营养摄入的全面均衡。',
    example_pinyin = 'Yíngyǎngxuéjiā jiànyì rìcháng yǐnshí yào zhùyì hūn-sù hélǐ dāpèi, bǎozhèng yíngyǎng shèrù de quánmiàn jūnhéng.',
    example_vi = 'Các chuyên gia dinh dưỡng khuyến cáo khẩu phần ăn hằng ngày cần chú ý phối hợp mặn chay hợp lý, đảm bảo hấp thu dinh dưỡng cân bằng toàn diện.'
WHERE id = 'fcd0503b-3469-4692-b237-38a686186f7a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fcd0503b-3469-4692-b237-38a686186f7a', '营养学家建议日常饮食要注意荤素合理搭配，保证营养摄入的全面均衡。', 'Yíngyǎngxuéjiā jiànyì rìcháng yǐnshí yào zhùyì hūn-sù hélǐ dāpèi, bǎozhèng yíngyǎng shèrù de quánmiàn jūnhéng.', 'Các chuyên gia dinh dưỡng khuyến cáo khẩu phần ăn hằng ngày cần chú ý phối hợp mặn chay hợp lý, đảm bảo hấp thu dinh dưỡng cân bằng toàn diện.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fcd0503b-3469-4692-b237-38a686186f7a'
);

-- [大臣] (dàchén): đại thần, quan lớn
UPDATE public.vocabularies
SET example_hanzi = '历史剧中国王正在宫殿内召集各位大臣，商讨抵御外敌入侵的防御大计。',
    example_pinyin = 'Lìshǐjù zhōng guówáng zhèngzài gōngdiàn nèi zhàojí gèwèi dàchén, shāngtǎo dǐyù wàidí rùqīn de fángyù dàjì.',
    example_vi = 'Trong phim lịch sử, nhà vua đang triệu tập các vị đại thần trong cung điện để bàn thảo đại kế phòng thủ chống ngoại xâm.'
WHERE id = 'bb1a9453-03d7-4f86-88e5-44d2ed3f16a7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bb1a9453-03d7-4f86-88e5-44d2ed3f16a7', '历史剧中国王正在宫殿内召集各位大臣，商讨抵御外敌入侵的防御大计。', 'Lìshǐjù zhōng guówáng zhèngzài gōngdiàn nèi zhàojí gèwèi dàchén, shāngtǎo dǐyù wàidí rùqīn de fángyù dàjì.', 'Trong phim lịch sử, nhà vua đang triệu tập các vị đại thần trong cung điện để bàn thảo đại kế phòng thủ chống ngoại xâm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bb1a9453-03d7-4f86-88e5-44d2ed3f16a7'
);

-- [大方] (dàfang): hào phóng, tự nhiên
UPDATE public.vocabularies
SET example_hanzi = '这位主持人举止典雅大方，语言幽默得体，深受全国广大电视观众喜爱。',
    example_pinyin = 'Zhè wèi zhǔchírén jǔzhǐ diǎnyǎ dàfang, yǔyán yōumò détǐ, shēn shòu quánguó guǎngdà diànshì guānzhòng xǐ''ài.',
    example_vi = 'Người dẫn chương trình này phong thái nho nhã tự nhiên, ngôn ngữ hóm hỉnh đúng mực, được đông đảo khán giả truyền hình cả nước yêu mến.'
WHERE id = '31e8c893-bac8-40c7-98a7-bc63d3a48ee5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '31e8c893-bac8-40c7-98a7-bc63d3a48ee5', '这位主持人举止典雅大方，语言幽默得体，深受全国广大电视观众喜爱。', 'Zhè wèi zhǔchírén jǔzhǐ diǎnyǎ dàfang, yǔyán yōumò détǐ, shēn shòu quánguó guǎngdà diànshì guānzhòng xǐ''ài.', 'Người dẫn chương trình này phong thái nho nhã tự nhiên, ngôn ngữ hóm hỉnh đúng mực, được đông đảo khán giả truyền hình cả nước yêu mến.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '31e8c893-bac8-40c7-98a7-bc63d3a48ee5'
);

-- [答复] (dáfù): trả lời, giải đáp
UPDATE public.vocabularies
SET example_hanzi = '对于客户提出的产品定制需求，售后团队承诺将在二十四小时内予以正式答复。',
    example_pinyin = 'Duìyú kèhù tíchū de chǎnpǐn dìngzhì xūqiú, shòuhòu tuánduì chéngnuò jiāng zài èrshísì xiǎoshí nèi yǔyǐ zhèngshì dáfù.',
    example_vi = 'Đối với nhu cầu đặt may riêng sản phẩm của khách hàng, đội ngũ hậu mãi cam kết sẽ phản hồi giải đáp chính thức trong 24 giờ.'
WHERE id = '1e52a9e5-91fb-474c-8e8e-6a44b181da0a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1e52a9e5-91fb-474c-8e8e-6a44b181da0a', '对于客户提出的产品定制需求，售后团队承诺将在二十四小时内予以正式答复。', 'Duìyú kèhù tíchū de chǎnpǐn dìngzhì xūqiú, shòuhòu tuánduì chéngnuò jiāng zài èrshísì xiǎoshí nèi yǔyǐ zhèngshì dáfù.', 'Đối với nhu cầu đặt may riêng sản phẩm của khách hàng, đội ngũ hậu mãi cam kết sẽ phản hồi giải đáp chính thức trong 24 giờ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1e52a9e5-91fb-474c-8e8e-6a44b181da0a'
);

-- [大伙儿] (dàhuǒr): mọi người, chúng ta
UPDATE public.vocabularies
SET example_hanzi = '听到我们团队荣获全国科技创新大赛一等奖的喜讯，大伙儿都兴奋地欢呼起来。',
    example_pinyin = 'Tīngdào wǒmen tuánduì rónghuò quánguó kējì chuàngxīn dàsài yīděngjiǎng de xǐxùn, dàhuǒr dōu xīngfèn de huānhū qǐlai.',
    example_vi = 'Nghe tin vui đội mình đoạt giải nhất cuộc thi sáng tạo khoa học công nghệ toàn quốc, mọi người chúng tôi đều phấn khởi hò reo.'
WHERE id = '73909ff3-035d-419f-9f1a-973ebbce47c6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '73909ff3-035d-419f-9f1a-973ebbce47c6', '听到我们团队荣获全国科技创新大赛一等奖的喜讯，大伙儿都兴奋地欢呼起来。', 'Tīngdào wǒmen tuánduì rónghuò quánguó kējì chuàngxīn dàsài yīděngjiǎng de xǐxùn, dàhuǒr dōu xīngfèn de huānhū qǐlai.', 'Nghe tin vui đội mình đoạt giải nhất cuộc thi sáng tạo khoa học công nghệ toàn quốc, mọi người chúng tôi đều phấn khởi hò reo.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '73909ff3-035d-419f-9f1a-973ebbce47c6'
);

-- [呆] (dāi): ngẩn ngơ; ở lại
UPDATE public.vocabularies
SET example_hanzi = '听到这个突如其来的意外噩耗，他整个人愣在原地呆了足足半分钟。',
    example_pinyin = 'Tīngdào zhè gè tūrúqílái de yìwài èhào, tā zhěng gè rén lèng zài yuándì dāi le zúzú bàn fēnzhōng.',
    example_vi = 'Nghe thấy tin dữ ập đến bất ngờ, cả người anh ấy sững sờ tại chỗ ngẩn ngơ suốt nửa phút đồng hồ.'
WHERE id = '9f11e27a-1184-4a18-8d3f-25d2c9d65e4f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9f11e27a-1184-4a18-8d3f-25d2c9d65e4f', '听到这个突如其来的意外噩耗，他整个人愣在原地呆了足足半分钟。', 'Tīngdào zhè gè tūrúqílái de yìwài èhào, tā zhěng gè rén lèng zài yuándì dāi le zúzú bàn fēnzhōng.', 'Nghe thấy tin dữ ập đến bất ngờ, cả người anh ấy sững sờ tại chỗ ngẩn ngơ suốt nửa phút đồng hồ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9f11e27a-1184-4a18-8d3f-25d2c9d65e4f'
);

-- [带领] (dài lǐng): dẫn dắt, lãnh đạo
UPDATE public.vocabularies
SET example_hanzi = '在经验丰富的项目经理带领下，攻关小组克服重重困难顺利完成了软件上线。',
    example_pinyin = 'Zài jīngyàn fēngfù de xiàngmù jīnglǐ dàilǐng xià, gōngguān xiǎozǔ kèfú chóngchóng kùnnan shùnlì wánchéng le ruǎnjiàn shàngxiàn.',
    example_vi = 'Dưới sự dẫn dắt của giám đốc dự án giàu kinh nghiệm, nhóm mũi nhọn đã vượt qua muôn vàn khó khăn đưa phần mềm vận hành suôn sẻ.'
WHERE id = 'c9b99b49-1f2d-46ce-af9c-d1dd033870fd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c9b99b49-1f2d-46ce-af9c-d1dd033870fd', '在经验丰富的项目经理带领下，攻关小组克服重重困难顺利完成了软件上线。', 'Zài jīngyàn fēngfù de xiàngmù jīnglǐ dàilǐng xià, gōngguān xiǎozǔ kèfú chóngchóng kùnnan shùnlì wánchéng le ruǎnjiàn shàngxiàn.', 'Dưới sự dẫn dắt của giám đốc dự án giàu kinh nghiệm, nhóm mũi nhọn đã vượt qua muôn vàn khó khăn đưa phần mềm vận hành suôn sẻ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c9b99b49-1f2d-46ce-af9c-d1dd033870fd'
);

-- [代价] (dàijià): cái giá, giá đắt
UPDATE public.vocabularies
SET example_hanzi = '为了保护这片珍贵的原始森林生态，当地政府宁可付出经济增速放缓的巨大代价。',
    example_pinyin = 'Wèile bǎohù zhè piàn zhēnguì de yuánshǐ sēnlín shēngtài, dāngdì zhèngfǔ nìngkě fùchū jīngjì zēngsù fànghuǎn de jùdà dàijià.',
    example_vi = 'Để bảo vệ sinh thái khu rừng nguyên sinh quý giá này, chính quyền sở tại thà trả cái giá rất lớn là tốc độ tăng trưởng kinh tế chậm lại.'
WHERE id = 'cc97d498-fd8f-44d6-8f8b-c5633849d9b8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cc97d498-fd8f-44d6-8f8b-c5633849d9b8', '为了保护这片珍贵的原始森林生态，当地政府宁可付出经济增速放缓的巨大代价。', 'Wèile bǎohù zhè piàn zhēnguì de yuánshǐ sēnlín shēngtài, dāngdì zhèngfǔ nìngkě fùchū jīngjì zēngsù fànghuǎn de jùdà dàijià.', 'Để bảo vệ sinh thái khu rừng nguyên sinh quý giá này, chính quyền sở tại thà trả cái giá rất lớn là tốc độ tăng trưởng kinh tế chậm lại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cc97d498-fd8f-44d6-8f8b-c5633849d9b8'
);

-- [贷款] (dàikuǎn): khoản vay, cho vay
UPDATE public.vocabularies
SET example_hanzi = '为了支持青年科技人才创新创业，银行推出了免抵押低利息专项创业贷款。',
    example_pinyin = 'Wèile zhīchí qīngnián kējì réncái chuàngxīn chuàngyè, yínháng tuīchū le miǎn dǐyā dī lìxī zhuānxiàng chuàngyè dàikuǎn.',
    example_vi = 'Để hỗ trợ nhân tài khoa học công nghệ trẻ lập nghiệp, ngân hàng đã tung ra gói khoản vay khởi nghiệp lãi suất thấp không cần thế chấp.'
WHERE id = '92d002a9-4c17-4a95-ab91-e1ba272d38aa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '92d002a9-4c17-4a95-ab91-e1ba272d38aa', '为了支持青年科技人才创新创业，银行推出了免抵押低利息专项创业贷款。', 'Wèile zhīchí qīngnián kējì réncái chuàngxīn chuàngyè, yínháng tuīchū le miǎn dǐyā dī lìxī zhuānxiàng chuàngyè dàikuǎn.', 'Để hỗ trợ nhân tài khoa học công nghệ trẻ lập nghiệp, ngân hàng đã tung ra gói khoản vay khởi nghiệp lãi suất thấp không cần thế chấp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '92d002a9-4c17-4a95-ab91-e1ba272d38aa'
);

-- [代理] (dàilǐ): đại lý, đại diện
UPDATE public.vocabularies
SET example_hanzi = '经总公司严格资质审核，这家商贸企业成功获得了该国际品牌在华东地区的独家代理权。',
    example_pinyin = 'Jīng zǒnggōngsī yángé zīzhì shěnhé, zhè jiā shāngmào qǐyè chénggōng huòdé le gāi guójì pǐnpái zài Huádōng dìqū de dújiā dàilǐ quán.',
    example_vi = 'Qua sự thẩm định năng lực nghiêm ngặt của tổng công ty, doanh nghiệp thương mại này đã giành được quyền đại lý độc quyền của thương hiệu quốc tế tại khu vực Hoa Đông.'
WHERE id = '9b457512-2b22-4b2f-9917-59016a87dc89' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9b457512-2b22-4b2f-9917-59016a87dc89', '经总公司严格资质审核，这家商贸企业成功获得了该国际品牌在华东地区的独家代理权。', 'Jīng zǒnggōngsī yángé zīzhì shěnhé, zhè jiā shāngmào qǐyè chénggōng huòdé le gāi guójì pǐnpái zài Huádōng dìqū de dújiā dàilǐ quán.', 'Qua sự thẩm định năng lực nghiêm ngặt của tổng công ty, doanh nghiệp thương mại này đã giành được quyền đại lý độc quyền của thương hiệu quốc tế tại khu vực Hoa Đông.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9b457512-2b22-4b2f-9917-59016a87dc89'
);

-- [打击] (dǎjī): đả kích, tấn công
UPDATE public.vocabularies
SET example_hanzi = '公安机关持续严厉打击电信网络诈骗犯罪活动，切实守护广大人民群众的财产安全。',
    example_pinyin = 'Gōng''ān jīgān chíxù yánlì dǎjī diànxìn wǎngluò zhàpiàn fànzuì huódòng, qièshí shǒuhù guǎngdà rénmín qúnzhòng de cáichǎn ānquán.',
    example_vi = 'Cơ quan công an kiên quyết tấn công trấn áp tội phạm lừa đảo viễn thông qua mạng, bảo vệ an toàn tài sản của nhân dân.'
WHERE id = 'dfc77d22-d836-4aa4-9a7e-b2257eaef997' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dfc77d22-d836-4aa4-9a7e-b2257eaef997', '公安机关持续严厉打击电信网络诈骗犯罪活动，切实守护广大人民群众的财产安全。', 'Gōng''ān jīgān chíxù yánlì dǎjī diànxìn wǎngluò zhàpiàn fànzuì huódòng, qièshí shǒuhù guǎngdà rénmín qúnzhòng de cáichǎn ānquán.', 'Cơ quan công an kiên quyết tấn công trấn áp tội phạm lừa đảo viễn thông qua mạng, bảo vệ an toàn tài sản của nhân dân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dfc77d22-d836-4aa4-9a7e-b2257eaef997'
);

-- [打架] (dǎjià): đánh nhau
UPDATE public.vocabularies
SET example_hanzi = '学校明确制定校规严禁学生在校内外打架斗殴，倡导同学之间互敬互爱、友好相处。',
    example_pinyin = 'Xuéxiào míngquè zhìdìng xiàoguī yánjìn xuésheng zài xiàonèi-xiàowài dǎjià dòu''ōu, chàngdǎo tóngxué zhījiān hùjìng-hù''ài, yǒuhǎo xiāngchǔ.',
    example_vi = 'Nhà trường quy định rõ nội quy nghiêm cấm học sinh đánh nhau gây rối trong và ngoài trường, kêu gọi bạn bè tôn trọng và sống chan hòa với nhau.'
WHERE id = '9a64ce9e-479d-4652-98e4-6338cc8e10af' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9a64ce9e-479d-4652-98e4-6338cc8e10af', '学校明确制定校规严禁学生在校内外打架斗殴，倡导同学之间互敬互爱、友好相处。', 'Xuéxiào míngquè zhìdìng xiàoguī yánjìn xuésheng zài xiàonèi-xiàowài dǎjià dòu''ōu, chàngdǎo tóngxué zhījiān hùjìng-hù''ài, yǒuhǎo xiāngchǔ.', 'Nhà trường quy định rõ nội quy nghiêm cấm học sinh đánh nhau gây rối trong và ngoài trường, kêu gọi bạn bè tôn trọng và sống chan hòa với nhau.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9a64ce9e-479d-4652-98e4-6338cc8e10af'
);

-- [蛋白质] (dànbáizhì): chất đạm, protein
UPDATE public.vocabularies
SET example_hanzi = '鸡蛋、豆制品和深海鱼肉中富含优质蛋白质，是人体组织修补与维持免疫力的重要营养源。',
    example_pinyin = 'Jīdàn, dòuzhìpǐn hé shēnhǎi yúròu zhōng fùhán yōuzhì dànbáizhì, shì réntǐ zǔzhī xiūbǔ yǔ wéichí miǎnyìlì de zhòngyào yíngyǎng yuán.',
    example_vi = 'Trứng gà, đậu phụ và cá biển sâu chứa hàm lượng protein chất lượng cao, là nguồn dinh dưỡng quan trọng giúp phục hồi tế bào và duy trì miễn dịch.'
WHERE id = '6934b1b8-f727-4373-a0cd-c5d8c3f6194c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6934b1b8-f727-4373-a0cd-c5d8c3f6194c', '鸡蛋、豆制品和深海鱼肉中富含优质蛋白质，是人体组织修补与维持免疫力的重要营养源。', 'Jīdàn, dòuzhìpǐn hé shēnhǎi yúròu zhōng fùhán yōuzhì dànbáizhì, shì réntǐ zǔzhī xiūbǔ yǔ wéichí miǎnyìlì de zhòngyào yíngyǎng yuán.', 'Trứng gà, đậu phụ và cá biển sâu chứa hàm lượng protein chất lượng cao, là nguồn dinh dưỡng quan trọng giúp phục hồi tế bào và duy trì miễn dịch.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6934b1b8-f727-4373-a0cd-c5d8c3f6194c'
);

-- [单纯] (dānchún): đơn thuần, ngây thơ
UPDATE public.vocabularies
SET example_hanzi = '这个从小在山村长大的小姑娘性格十分单纯善良，眼睛里透着清澈纯真的光芒。',
    example_pinyin = 'Zhè gè cóngxiǎo zài shāncūn zhǎngdà de xiǎo gūniang xìnggé shífēn dānchún shànliáng, yǎnjing lǐ tòu zhe qīngchè chúnzhēn de guāngmáng.',
    example_vi = 'Cô bé từ nhỏ lớn lên ở làng núi này tính tình vô cùng đơn thuần lương thiện, trong ánh mắt ánh lên vẻ trong veo thuần khiết.'
WHERE id = 'b022bfa6-e22c-4810-a478-fb8c35db8ffd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b022bfa6-e22c-4810-a478-fb8c35db8ffd', '这个从小在山村长大的小姑娘性格十分单纯善良，眼睛里透着清澈纯真的光芒。', 'Zhè gè cóngxiǎo zài shāncūn zhǎngdà de xiǎo gūniang xìnggé shífēn dānchún shànliáng, yǎnjing lǐ tòu zhe qīngchè chúnzhēn de guāngmáng.', 'Cô bé từ nhỏ lớn lên ở làng núi này tính tình vô cùng đơn thuần lương thiện, trong ánh mắt ánh lên vẻ trong veo thuần khiết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b022bfa6-e22c-4810-a478-fb8c35db8ffd'
);

-- [单调] (dāndiào): đơn điệu, tẻ nhạt
UPDATE public.vocabularies
SET example_hanzi = '每天重复机械琐碎的流水线工作难免让人感到单调乏味，需要培养业余爱好丰富精神生活。',
    example_pinyin = 'Měitiān chóngfù jīxiè suǒsuì de liúshuǐxiàn gōngzuò nánmiǎn ràng rén gǎndào dāndiào fáwèi, xūyào péiyǎng yèyú àihào fēngfù jīngshén shēnghuó.',
    example_vi = 'Mỗi ngày lặp đi lặp lại công việc dây chuyền vụn vặt máy móc khó tránh khiến người ta thấy đơn điệu tẻ nhạt, cần bồi dưỡng sở thích để làm phong phú đời sống tinh thần.'
WHERE id = 'ad7289ed-bb74-4333-aa2d-bab77ec9acaf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ad7289ed-bb74-4333-aa2d-bab77ec9acaf', '每天重复机械琐碎的流水线工作难免让人感到单调乏味，需要培养业余爱好丰富精神生活。', 'Měitiān chóngfù jīxiè suǒsuì de liúshuǐxiàn gōngzuò nánmiǎn ràng rén gǎndào dāndiào fáwèi, xūyào péiyǎng yèyú àihào fēngfù jīngshén shēnghuó.', 'Mỗi ngày lặp đi lặp lại công việc dây chuyền vụn vặt máy móc khó tránh khiến người ta thấy đơn điệu tẻ nhạt, cần bồi dưỡng sở thích để làm phong phú đời sống tinh thần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ad7289ed-bb74-4333-aa2d-bab77ec9acaf'
);

-- [当场] (dāng chǎng): tại chỗ, tại trận
UPDATE public.vocabularies
SET example_hanzi = '警方在掌握确凿证据后迅速采取行动，当场抓获了企图销毁账目证据的嫌疑人。',
    example_pinyin = 'Jǐngfāng zài zhǎngwò quèzáo zhèngjù hòu xùnsù cǎiqǔ xíngdòng, dāngchǎng zhuāhuò le qǐtú xiāohuǐ zhàngmù zhèngjù de xiányírén.',
    example_vi = 'Cảnh sát sau khi nắm chắc chứng cứ xác thực đã nhanh chóng hành động, bắt giữ tại trận nghi phạm đang có mưu đồ tiêu hủy sổ sách chứng từ.'
WHERE id = '37c5f3ca-dff2-498a-9dbc-abd0c6f4bcac' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '37c5f3ca-dff2-498a-9dbc-abd0c6f4bcac', '警方在掌握确凿证据后迅速采取行动，当场抓获了企图销毁账目证据的嫌疑人。', 'Jǐngfāng zài zhǎngwò quèzáo zhèngjù hòu xùnsù cǎiqǔ xíngdòng, dāngchǎng zhuāhuò le qǐtú xiāohuǐ zhàngmù zhèngjù de xiányírén.', 'Cảnh sát sau khi nắm chắc chứng cứ xác thực đã nhanh chóng hành động, bắt giữ tại trận nghi phạm đang có mưu đồ tiêu hủy sổ sách chứng từ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '37c5f3ca-dff2-498a-9dbc-abd0c6f4bcac'
);

-- [当初] (dāng chū): lúc đầu, ban đầu
UPDATE public.vocabularies
SET example_hanzi = '回想起当初白手起家创业时的艰难困苦，公司的几位创始人至今依然感慨万千。',
    example_pinyin = 'Huíxiǎng qǐ dāngchū báishǒu-qǐjiā chuàngyè shí de jiānnán kùnkǔ, gōngsī de jǐ wèi chuàngshǐrén zhìjīn yīrán gǎnkǎi wànqiān.',
    example_vi = 'Nhớ lại những gian lao vất vả thuở ban đầu lập nghiệp từ hai bàn tay trắng, mấy vị sáng lập công ty đến nay vẫn ngập tràn xúc động.'
WHERE id = 'f87912f5-1fc4-437b-b1a6-b4284f61cf5d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f87912f5-1fc4-437b-b1a6-b4284f61cf5d', '回想起当初白手起家创业时的艰难困苦，公司的几位创始人至今依然感慨万千。', 'Huíxiǎng qǐ dāngchū báishǒu-qǐjiā chuàngyè shí de jiānnán kùnkǔ, gōngsī de jǐ wèi chuàngshǐrén zhìjīn yīrán gǎnkǎi wànqiān.', 'Nhớ lại những gian lao vất vả thuở ban đầu lập nghiệp từ hai bàn tay trắng, mấy vị sáng lập công ty đến nay vẫn ngập tràn xúc động.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f87912f5-1fc4-437b-b1a6-b4284f61cf5d'
);

-- [当代] (dāng dài): đương đại
UPDATE public.vocabularies
SET example_hanzi = '当代青年应当树立远大的人生理想，勇于承担起推动科技进步和社会发展的时代重任。',
    example_pinyin = 'Dāngdài qīngnián yīngdāng shùlì yuǎndà de rénshēng lǐxiǎng, yǒngyú chéngdān qǐ tuīdòng kējì jìnbù hé shèhuì fāzhǎn de shídài zhòngrèn.',
    example_vi = 'Thanh niên đương đại nên xác lập lý tưởng nhân sinh cao đẹp, dũng cảm gánh vác trọng trách thời đại thúc đẩy tiến bộ khoa học và phát triển xã hội.'
WHERE id = '7b82b982-bdfd-402b-91e9-963e7dd2f316' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7b82b982-bdfd-402b-91e9-963e7dd2f316', '当代青年应当树立远大的人生理想，勇于承担起推动科技进步和社会发展的时代重任。', 'Dāngdài qīngnián yīngdāng shùlì yuǎndà de rénshēng lǐxiǎng, yǒngyú chéngdān qǐ tuīdòng kējì jìnbù hé shèhuì fāzhǎn de shídài zhòngrèn.', 'Thanh niên đương đại nên xác lập lý tưởng nhân sinh cao đẹp, dũng cảm gánh vác trọng trách thời đại thúc đẩy tiến bộ khoa học và phát triển xã hội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7b82b982-bdfd-402b-91e9-963e7dd2f316'
);

-- [当面] (dāng miàn): trực tiếp, trước mặt
UPDATE public.vocabularies
SET example_hanzi = '如果有任何意见或者不同看法，欢迎大家在例会上当面提出，共同探讨解决方案。',
    example_pinyin = 'Rúguǒ yǒu rènhé yìjiàn huòzhě bùtóng kànfǎ, huānyíng dàjiā zài lìhuì shang dāngmiàn tíchū, gòngtóng tàntǎo jiějué fāng''àn.',
    example_vi = 'Nếu có bất kỳ ý kiến hoặc góc nhìn khác, hoan nghênh mọi người nêu ra trực tiếp trước mặt trong cuộc họp định kỳ để cùng thảo luận phương án.'
WHERE id = '6becbbf8-711f-475f-aedc-2878d96a71d3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6becbbf8-711f-475f-aedc-2878d96a71d3', '如果有任何意见或者不同看法，欢迎大家在例会上当面提出，共同探讨解决方案。', 'Rúguǒ yǒu rènhé yìjiàn huòzhě bùtóng kànfǎ, huānyíng dàjiā zài lìhuì shang dāngmiàn tíchū, gòngtóng tàntǎo jiějué fāng''àn.', 'Nếu có bất kỳ ý kiến hoặc góc nhìn khác, hoan nghênh mọi người nêu ra trực tiếp trước mặt trong cuộc họp định kỳ để cùng thảo luận phương án.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6becbbf8-711f-475f-aedc-2878d96a71d3'
);

-- [当选] (dāng xuǎn): trúng cử
UPDATE public.vocabularies
SET example_hanzi = '凭借在社区治理中脚踏实地的奉献精神，老张在本次居民委员会换届中高票当选主任。',
    example_pinyin = 'Píngjiè zài shèqū zhìlǐ zhōng jiǎotà-shídì de fèngxiàn jīngshén, Lǎo Zhāng zài běncì jūmín wěiyuánhuì huànjiè zhōng gāopiào dāngxuǎn zhǔrèn.',
    example_vi = 'Nhờ tinh thần cống hiến thực tế trong quản lý khu dân cư, bác Trương đã trúng cử chức trưởng ban với số phiếu cao trong kỳ đại hội này.'
WHERE id = '742e6bed-4207-4062-be41-787365957123' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '742e6bed-4207-4062-be41-787365957123', '凭借在社区治理中脚踏实地的奉献精神，老张在本次居民委员会换届中高票当选主任。', 'Píngjiè zài shèqū zhìlǐ zhōng jiǎotà-shídì de fèngxiàn jīngshén, Lǎo Zhāng zài běncì jūmín wěiyuánhuì huànjiè zhōng gāopiào dāngxuǎn zhǔrèn.', 'Nhờ tinh thần cống hiến thực tế trong quản lý khu dân cư, bác Trương đã trúng cử chức trưởng ban với số phiếu cao trong kỳ đại hội này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '742e6bed-4207-4062-be41-787365957123'
);

-- [档案] (dàng'àn): hồ sơ, tư liệu
UPDATE public.vocabularies
SET example_hanzi = '人事部门正在对新入职员工的学籍与工作履历档案进行严格的审核与数字化归档。',
    example_pinyin = 'Rénshì bùmén zhèngzài duì xīn rùzhí yuángōng de xuéjí yǔ gōngzuò lǚlì dàng''àn jìnxíng yángé de shěnhé yǔ shùzìhuà guīdàng.',
    example_vi = 'Phòng nhân sự đang tiến hành thẩm định nghiêm ngặt và lưu trữ số hóa hồ sơ học bạ cùng quá trình công tác của nhân viên mới.'
WHERE id = '8e2a8a25-2303-4628-b381-edc2e53d1f93' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8e2a8a25-2303-4628-b381-edc2e53d1f93', '人事部门正在对新入职员工的学籍与工作履历档案进行严格的审核与数字化归档。', 'Rénshì bùmén zhèngzài duì xīn rùzhí yuángōng de xuéjí yǔ gōngzuò lǚlì dàng''àn jìnxíng yángé de shěnhé yǔ shùzìhuà guīdàng.', 'Phòng nhân sự đang tiến hành thẩm định nghiêm ngặt và lưu trữ số hóa hồ sơ học bạ cùng quá trình công tác của nhân viên mới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8e2a8a25-2303-4628-b381-edc2e53d1f93'
);

-- [诞生] (dànshēng): ra đời, sinh ra
UPDATE public.vocabularies
SET example_hanzi = '世界上第一台现代电子计算机的诞生，标志着人类文明正式跨入了信息时代。',
    example_pinyin = 'Shìjiè shang dì-yī tái xiàndài diànzǐ jìsuànjī de dànshēng, biāozhì zhe rénlèi wénmíng zhèngshì kuàrù le xìnxī shídài.',
    example_vi = 'Sự ra đời của chiếc máy tính điện tử hiện đại đầu tiên trên thế giới đánh dấu nền văn minh nhân loại chính thức bước vào kỷ nguyên thông tin.'
WHERE id = 'dfb6e6d5-07d1-491c-908d-a2f98585dffe' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dfb6e6d5-07d1-491c-908d-a2f98585dffe', '世界上第一台现代电子计算机的诞生，标志着人类文明正式跨入了信息时代。', 'Shìjiè shang dì-yī tái xiàndài diànzǐ jìsuànjī de dànshēng, biāozhì zhe rénlèi wénmíng zhèngshì kuàrù le xìnxī shídài.', 'Sự ra đời của chiếc máy tính điện tử hiện đại đầu tiên trên thế giới đánh dấu nền văn minh nhân loại chính thức bước vào kỷ nguyên thông tin.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dfb6e6d5-07d1-491c-908d-a2f98585dffe'
);

-- [耽误] (dānwu): làm lỡ dở, chậm trễ
UPDATE public.vocabularies
SET example_hanzi = '由于路上发生了突发交通事故，导致他耽误了前往机场搭乘国际航班的时间。',
    example_pinyin = 'Yóuyú lùshang fāshēng le tūfā jiāotōng shìgù, dǎozhì tā dānwu le qiánwǎng jīchǎng dāchéng guójì hángbān de shíjiān.',
    example_vi = 'Do trên đường xảy ra tai nạn giao thông bất ngờ nên đã làm lỡ dở thời gian anh ấy ra sân bay bắt chuyến bay quốc tế.'
WHERE id = 'd4becd76-7502-4d87-bbd0-f17f102a1b15' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd4becd76-7502-4d87-bbd0-f17f102a1b15', '由于路上发生了突发交通事故，导致他耽误了前往机场搭乘国际航班的时间。', 'Yóuyú lùshang fāshēng le tūfā jiāotōng shìgù, dǎozhì tā dānwu le qiánwǎng jīchǎng dāchéng guójì hángbān de shíjiān.', 'Do trên đường xảy ra tai nạn giao thông bất ngờ nên đã làm lỡ dở thời gian anh ấy ra sân bay bắt chuyến bay quốc tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd4becd76-7502-4d87-bbd0-f17f102a1b15'
);

-- [倒闭] (dǎobì): phá sản, đóng cửa
UPDATE public.vocabularies
SET example_hanzi = '由于长期缺乏技术创新且资金链断裂，这家曾经辉煌一时的老百货商场最终宣告倒闭。',
    example_pinyin = 'Yóuyú chángqī quēfá jìshù chuàngxīn qiě zījīnliàn duànliè, zhè jiā céngjīng huīhuáng yìshí de lǎo bǎihuò shāngchǎng zuìzhōng xuāngào dǎobì.',
    example_vi = 'Do lâu ngày thiếu đổi mới kỹ thuật và đứt gãy dòng tiền, khu thương xá bách hóa từng một thời huy hoàng này rốt cuộc phải tuyên bố phá sản.'
WHERE id = 'f694e63f-14ff-415a-afc3-7dcd6f071788' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f694e63f-14ff-415a-afc3-7dcd6f071788', '由于长期缺乏技术创新且资金链断裂，这家曾经辉煌一时的老百货商场最终宣告倒闭。', 'Yóuyú chángqī quēfá jìshù chuàngxīn qiě zījīnliàn duànliè, zhè jiā céngjīng huīhuáng yìshí de lǎo bǎihuò shāngchǎng zuìzhōng xuāngào dǎobì.', 'Do lâu ngày thiếu đổi mới kỹ thuật và đứt gãy dòng tiền, khu thương xá bách hóa từng một thời huy hoàng này rốt cuộc phải tuyên bố phá sản.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f694e63f-14ff-415a-afc3-7dcd6f071788'
);

-- [打仗] (dǎzhàng): đánh trận, đánh nhau
UPDATE public.vocabularies
SET example_hanzi = '战争给人类社会带来的只有苦难与毁灭，经历过战火的老战士更加深知和平打仗的残酷。',
    example_pinyin = 'Zhànzhēng gěi rénlèi shèhuì dài lái de zhǐyǒu kǔnàn yǔ huǐmiè, jīnglì guò zhànhuǒ de lǎo zhànshì gèngjiā shēnzhī hépíng dǎzhàng de chánkù.',
    example_vi = 'Chiến tranh mang lại cho xã hội loài người chỉ có đau thương và tàn phá, người lính già từng đi qua lửa đạn càng hiểu sâu sắc sự tàn khốc của việc đánh nhau.'
WHERE id = '2c39fddd-4404-4eab-8b23-b12948fd4cda' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2c39fddd-4404-4eab-8b23-b12948fd4cda', '战争给人类社会带来的只有苦难与毁灭，经历过战火的老战士更加深知和平打仗的残酷。', 'Zhànzhēng gěi rénlèi shèhuì dài lái de zhǐyǒu kǔnàn yǔ huǐmiè, jīnglì guò zhànhuǒ de lǎo zhànshì gèngjiā shēnzhī hépíng dǎzhàng de chánkù.', 'Chiến tranh mang lại cho xã hội loài người chỉ có đau thương và tàn phá, người lính già từng đi qua lửa đạn càng hiểu sâu sắc sự tàn khốc của việc đánh nhau.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2c39fddd-4404-4eab-8b23-b12948fd4cda'
);

-- [大致] (dàzhì): đại khái, khoảng chừng
UPDATE public.vocabularies
SET example_hanzi = '虽然双方还没敲定所有合同细节，但对于合作框架的核心条款已经达成了大致共识。',
    example_pinyin = 'Suīrán shuāngfāng hái méi qiāodìng suǒyǒu hétong xìjié, dàn duìyú hézuò kuàngjià de héxīn tiáokuǎn yǐjīng dáchéng le dàzhì gòngshí.',
    example_vi = 'Mặc dù hai bên chưa chốt xong mọi chi tiết hợp đồng, song đã đạt được đồng thuận đại khái về các điều khoản cốt lõi của khung hợp tác.'
WHERE id = '66766dd6-551a-481a-b317-2d7fa0ac222f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '66766dd6-551a-481a-b317-2d7fa0ac222f', '虽然双方还没敲定所有合同细节，但对于合作框架的核心条款已经达成了大致共识。', 'Suīrán shuāngfāng hái méi qiāodìng suǒyǒu hétong xìjié, dàn duìyú hézuò kuàngjià de héxīn tiáokuǎn yǐjīng dáchéng le dàzhì gòngshí.', 'Mặc dù hai bên chưa chốt xong mọi chi tiết hợp đồng, song đã đạt được đồng thuận đại khái về các điều khoản cốt lõi của khung hợp tác.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '66766dd6-551a-481a-b317-2d7fa0ac222f'
);

-- [等级] (děngjí): đẳng cấp, cấp bậc
UPDATE public.vocabularies
SET example_hanzi = '医院按照医疗质量、技术水平和科室建设等综合指标，被评定为三级甲等最高等级。',
    example_pinyin = 'Yīyuàn ànzhào yīliáo zhìliàng, jìshù shuǐpíng hé kēshì jiànshè děng zōnghé zhǐbiāo, bèi píngdìng wèi sān jí jiǎ děng zuì gāo děngjí.',
    example_vi = 'Bệnh viện căn cứ vào các chỉ tiêu tổng hợp như chất lượng khám chữa bệnh, trình độ kỹ thuật đã được xếp hạng cấp bậc cao nhất là hạng 3A.'
WHERE id = '89d51e6a-f652-44bf-be5e-318db2b4dcfb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '89d51e6a-f652-44bf-be5e-318db2b4dcfb', '医院按照医疗质量、技术水平和科室建设等综合指标，被评定为三级甲等最高等级。', 'Yīyuàn ànzhào yīliáo zhìliàng, jìshù shuǐpíng hé kēshì jiànshè děng zōnghé zhǐbiāo, bèi píngdìng wèi sān jí jiǎ děng zuì gāo děngjí.', 'Bệnh viện căn cứ vào các chỉ tiêu tổng hợp như chất lượng khám chữa bệnh, trình độ kỹ thuật đã được xếp hạng cấp bậc cao nhất là hạng 3A.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '89d51e6a-f652-44bf-be5e-318db2b4dcfb'
);

-- [灯笼] (dēnglong): đèn lồng
UPDATE public.vocabularies
SET example_hanzi = '每逢元宵佳节，古城的大街小巷都挂满了火红的纸灯笼，洋溢着喜庆祥和的节日气氛。',
    example_pinyin = 'Měi féng Yuánxiāo jiājié, gǔchéng de dàjiē-xiǎoxiàng dōu guà mǎn le huǒhóng de zhǐ dēnglong, yángyì zhe xǐqìng xiánghé de jiérì qìfēn.',
    example_vi = 'Mỗi dịp tết Nguyên tiêu, đường to ngõ nhỏ khắp phố cổ đều treo đầy đèn lồng giấy đỏ rực, tràn ngập không khí ngày lễ tưng bừng an lành.'
WHERE id = '9c1c16f6-714e-40ec-b862-45f9a12b28cb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9c1c16f6-714e-40ec-b862-45f9a12b28cb', '每逢元宵佳节，古城的大街小巷都挂满了火红的纸灯笼，洋溢着喜庆祥和的节日气氛。', 'Měi féng Yuánxiāo jiājié, gǔchéng de dàjiē-xiǎoxiàng dōu guà mǎn le huǒhóng de zhǐ dēnglong, yángyì zhe xǐqìng xiánghé de jiérì qìfēn.', 'Mỗi dịp tết Nguyên tiêu, đường to ngõ nhỏ khắp phố cổ đều treo đầy đèn lồng giấy đỏ rực, tràn ngập không khí ngày lễ tưng bừng an lành.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9c1c16f6-714e-40ec-b862-45f9a12b28cb'
);

-- [滴] (dī): giọt, nhỏ giọt
UPDATE public.vocabularies
SET example_hanzi = '每一滴清澈的水珠汇聚在一起，便能汇成奔腾不息、波澜壮阔的滔滔江河。',
    example_pinyin = 'Měi yì dī qīngchè de shuǐzhū huìjù zài yìqǐ, biàn néng huìchéng bēnténg-bùxī, bōlán-zhuàngkuò de tāotāo jiānghé.',
    example_vi = 'Từng giọt nước trong vắt tụ lại với nhau có thể hợp thành những dòng sông cuồn cuộn chảy mãi không ngừng đầy sóng gió tráng lệ.'
WHERE id = '999f1e56-6eb4-4c73-a347-935347b3539f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '999f1e56-6eb4-4c73-a347-935347b3539f', '每一滴清澈的水珠汇聚在一起，便能汇成奔腾不息、波澜壮阔的滔滔江河。', 'Měi yì dī qīngchè de shuǐzhū huìjù zài yìqǐ, biàn néng huìchéng bēnténg-bùxī, bōlán-zhuàngkuò de tāotāo jiānghé.', 'Từng giọt nước trong vắt tụ lại với nhau có thể hợp thành những dòng sông cuồn cuộn chảy mãi không ngừng đầy sóng gió tráng lệ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '999f1e56-6eb4-4c73-a347-935347b3539f'
);

-- [典礼] (diǎnlǐ): buổi lễ, nghi lễ
UPDATE public.vocabularies
SET example_hanzi = '大学毕业典礼在庄严隆重的大礼堂举行，校长亲自为每一位毕业生拨穗授予学位证书。',
    example_pinyin = 'Dàxué bìyè diǎnlǐ zài zhuāngyán lóngzhòng de dà lǐtáng jǔxíng, xiàozhǎng qīnzì wèi měi yí wèi bìyèshēng bōsuì shòuyǔ xuéwèi zhèngshū.',
    example_vi = 'Lễ tốt nghiệp đại học diễn ra tại đại lễ đường trang nghiêm long trọng, hiệu trưởng đích thân gạt tua mũ trao bằng cho từng tân cử nhân.'
WHERE id = '46acb8b5-3811-4a98-959e-e12617acdd81' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '46acb8b5-3811-4a98-959e-e12617acdd81', '大学毕业典礼在庄严隆重的大礼堂举行，校长亲自为每一位毕业生拨穗授予学位证书。', 'Dàxué bìyè diǎnlǐ zài zhuāngyán lóngzhòng de dà lǐtáng jǔxíng, xiàozhǎng qīnzì wèi měi yí wèi bìyèshēng bōsuì shòuyǔ xuéwèi zhèngshū.', 'Lễ tốt nghiệp đại học diễn ra tại đại lễ đường trang nghiêm long trọng, hiệu trưởng đích thân gạt tua mũ trao bằng cho từng tân cử nhân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '46acb8b5-3811-4a98-959e-e12617acdd81'
);

-- [典型] (diǎnxíng): điển hình
UPDATE public.vocabularies
SET example_hanzi = '专家学者们一致认为，该市通过生态修复带动绿色旅游的做法是一个十分典型的成功样本。',
    example_pinyin = 'Zhuānjiā xuézhě men yízhì rènwéi, gāi shì tōngguò shēngtài xiūfù dàidòng lǜsè lǚyóu de zuòfǎ shì yí gè shífēn diǎnxíng de chénggōng yàngběn.',
    example_vi = 'Các chuyên gia học giả nhất trí cho rằng cách làm phục hồi sinh thái để kéo theo du lịch xanh của thành phố này là một hình mẫu thành công rất điển hình.'
WHERE id = '8e7e5146-7940-4a4b-a13d-d14fdbd9a8d8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8e7e5146-7940-4a4b-a13d-d14fdbd9a8d8', '专家学者们一致认为，该市通过生态修复带动绿色旅游的做法是一个十分典型的成功样本。', 'Zhuānjiā xuézhě men yízhì rènwéi, gāi shì tōngguò shēngtài xiūfù dàidòng lǜsè lǚyóu de zuòfǎ shì yí gè shífēn diǎnxíng de chénggōng yàngběn.', 'Các chuyên gia học giả nhất trí cho rằng cách làm phục hồi sinh thái để kéo theo du lịch xanh của thành phố này là một hình mẫu thành công rất điển hình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8e7e5146-7940-4a4b-a13d-d14fdbd9a8d8'
);

-- [电源] (diànyuán): nguồn điện
UPDATE public.vocabularies
SET example_hanzi = '在对损坏的家用电器进行拆卸检修之前，务必先彻底切断设备的总电源以防触电危险。',
    example_pinyin = 'Zài duì sǔnhuài de jiāyòng diànqì jìnxíng chāixiè jiǎnxiū zhīqián, wùbì xiān chèdǐ qiēduàn shèbèi de zǒng diànyuán yǐ fáng chùdiàn wēixiǎn.',
    example_vi = 'Trước khi tháo dỡ sửa chữa thiết bị điện gia dụng bị hỏng, nhất thiết phải ngắt hoàn toàn nguồn điện tổng của thiết bị để phòng nguy hiểm giật điện.'
WHERE id = '85ae2479-5e5c-4363-8b51-4e90c429ec62' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '85ae2479-5e5c-4363-8b51-4e90c429ec62', '在对损坏的家用电器进行拆卸检修之前，务必先彻底切断设备的总电源以防触电危险。', 'Zài duì sǔnhuài de jiāyòng diànqì jìnxíng chāixiè jiǎnxiū zhīqián, wùbì xiān chèdǐ qiēduàn shèbèi de zǒng diànyuán yǐ fáng chùdiàn wēixiǎn.', 'Trước khi tháo dỡ sửa chữa thiết bị điện gia dụng bị hỏng, nhất thiết phải ngắt hoàn toàn nguồn điện tổng của thiết bị để phòng nguy hiểm giật điện.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '85ae2479-5e5c-4363-8b51-4e90c429ec62'
);

-- [吊] (diào): treo, dòng xuống, điếu
UPDATE public.vocabularies
SET example_hanzi = '大型起重机正稳稳地将沉重的钢筋水泥构件吊装到数十米高的建筑高空作业面上。',
    example_pinyin = 'Dàxíng qǐzhòngjī zhèng wěnwěn de jiāng chénzhòng de gāngjīn shuǐní gòujiàn diàozhuāng dào shùshí mǐ gāo de jiànzhù gāokōng zuòyè miàn shang.',
    example_vi = 'Cần cẩu cỡ lớn đang dòng treo nâng vững vàng cấu kiện bê tông cốt thép nặng nề lên bề mặt thi công trên cao hàng chục mét.'
WHERE id = '23eaa405-469e-4e56-952f-4be8354ec9c0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '23eaa405-469e-4e56-952f-4be8354ec9c0', '大型起重机正稳稳地将沉重的钢筋水泥构件吊装到数十米高的建筑高空作业面上。', 'Dàxíng qǐzhòngjī zhèng wěnwěn de jiāng chénzhòng de gāngjīn shuǐní gòujiàn diàozhuāng dào shùshí mǐ gāo de jiànzhù gāokōng zuòyè miàn shang.', 'Cần cẩu cỡ lớn đang dòng treo nâng vững vàng cấu kiện bê tông cốt thép nặng nề lên bề mặt thi công trên cao hàng chục mét.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '23eaa405-469e-4e56-952f-4be8354ec9c0'
);

-- [调动] (diàodòng): điều động
UPDATE public.vocabularies
SET example_hanzi = '企业通过建立公平透明的激励机制，充分调动了全体科研技术人员的创新积极性。',
    example_pinyin = 'Qǐyè tōngguò jiànlì gōngpíng tòumíng de jīlì jīzhì, chōngfèn diàodòng le quántǐ kēyán jìshù rényuán de chuàngxīn jījíxìng.',
    example_vi = 'Doanh nghiệp thông qua thiết lập cơ chế đãi ngộ công bằng minh bạch đã điều động phát huy đầy đủ tính tích cực sáng tạo của toàn thể nhân viên kỹ thuật.'
WHERE id = '84420fbb-96fc-43f4-a9d2-56ecd33e1d92' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '84420fbb-96fc-43f4-a9d2-56ecd33e1d92', '企业通过建立公平透明的激励机制，充分调动了全体科研技术人员的创新积极性。', 'Qǐyè tōngguò jiànlì gōngpíng tòumíng de jīlì jīzhì, chōngfèn diàodòng le quántǐ kēyán jìshù rényuán de chuàngxīn jījíxìng.', 'Doanh nghiệp thông qua thiết lập cơ chế đãi ngộ công bằng minh bạch đã điều động phát huy đầy đủ tính tích cực sáng tạo của toàn thể nhân viên kỹ thuật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '84420fbb-96fc-43f4-a9d2-56ecd33e1d92'
);

-- [抵达] (dǐdá): đến nơi, tới nơi
UPDATE public.vocabularies
SET example_hanzi = '满载救援物资的车队历经十余个小时的风雨兼程，终于在清晨安全抵达地震灾区。',
    example_pinyin = 'Mǎnzài jiùyuán wùzī de chēduì lìjīng shí yú gè xiǎoshí de fēngyǔ-jiānchéng, zhōngyú zài qīngchén ānquán dǐdá dìzhèn zāiqū.',
    example_vi = 'Đoàn xe chở đầy hàng cứu trợ sau hơn mười tiếng dầm mưa dãi nắng cuối cùng cũng đã đến nơi an toàn tại vùng động đất vào buổi sớm mai.'
WHERE id = '550bc1cb-2a75-4062-a15b-0a7d0c16267d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '550bc1cb-2a75-4062-a15b-0a7d0c16267d', '满载救援物资的车队历经十余个小时的风雨兼程，终于在清晨安全抵达地震灾区。', 'Mǎnzài jiùyuán wùzī de chēduì lìjīng shí yú gè xiǎoshí de fēngyǔ-jiānchéng, zhōngyú zài qīngchén ānquán dǐdá dìzhèn zāiqū.', 'Đoàn xe chở đầy hàng cứu trợ sau hơn mười tiếng dầm mưa dãi nắng cuối cùng cũng đã đến nơi an toàn tại vùng động đất vào buổi sớm mai.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '550bc1cb-2a75-4062-a15b-0a7d0c16267d'
);

-- [地道] (dìdao): chuẩn, chính cống
UPDATE public.vocabularies
SET example_hanzi = '这位常年在北京生活工作的外国留学生，说起普通话来口音十分纯正地道。',
    example_pinyin = 'Zhè wèi chángnián zài Běijīng shēnghuó gōngzuò de wàiguó liúxuéshēng, shuō qǐ pǔtōnghuà lái kǒuyīn shífēn chúnzhèng dìdao.',
    example_vi = 'Lưu học sinh nước ngoài quanh năm sống và làm việc tại Bắc Kinh này nói tiếng phổ thông với khẩu âm vô cùng chuẩn xác chính cống.'
WHERE id = '69b42613-063b-4daf-9a2f-a733f7c41e81' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '69b42613-063b-4daf-9a2f-a733f7c41e81', '这位常年在北京生活工作的外国留学生，说起普通话来口音十分纯正地道。', 'Zhè wèi chángnián zài Běijīng shēnghuó gōngzuò de wàiguó liúxuéshēng, shuō qǐ pǔtōnghuà lái kǒuyīn shífēn chúnzhèng dìdao.', 'Lưu học sinh nước ngoài quanh năm sống và làm việc tại Bắc Kinh này nói tiếng phổ thông với khẩu âm vô cùng chuẩn xác chính cống.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '69b42613-063b-4daf-9a2f-a733f7c41e81'
);

-- [跌] (diē): ngã, sụt giảm
UPDATE public.vocabularies
SET example_hanzi = '受国际能源供应形势大幅波动的影响，原油期货交易市场价格今天连续第二天下跌。',
    example_pinyin = 'Shòu guójì néngyuán gōngyìng xíngshì dàfú bōdòng de yǐngxiǎng, yuányóu qīhuò jiāoyì shìchǎng jiàgé jīntiān liánxù dì-èr tiān diē.',
    example_vi = 'Chịu ảnh hưởng bởi biến động lớn của tình hình cung ứng năng lượng quốc tế, giá thị trường tương lai dầu thô hôm nay đã sụt giảm ngày thứ hai liên tiếp.'
WHERE id = '088ec908-6c03-4209-ba7c-3d7e96e323ce' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '088ec908-6c03-4209-ba7c-3d7e96e323ce', '受国际能源供应形势大幅波动的影响，原油期货交易市场价格今天连续第二天下跌。', 'Shòu guójì néngyuán gōngyìng xíngshì dàfú bōdòng de yǐngxiǎng, yuányóu qīhuò jiāoyì shìchǎng jiàgé jīntiān liánxù dì-èr tiān diē.', 'Chịu ảnh hưởng bởi biến động lớn của tình hình cung ứng năng lượng quốc tế, giá thị trường tương lai dầu thô hôm nay đã sụt giảm ngày thứ hai liên tiếp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '088ec908-6c03-4209-ba7c-3d7e96e323ce'
);

-- [抵抗] (dǐkàng): đề kháng, kháng cự
UPDATE public.vocabularies
SET example_hanzi = '坚持适度规律的体育锻炼与合理作息，有助于显著增强身体免疫力以抵抗细菌感染。',
    example_pinyin = 'Jiānchí shìdù guīlǜ de tǐyù duànliàn yǔ hélǐ zuòxī, yǒuzhùyú xiǎnzhù zēngqiáng shēntǐ miǎnyìlì yǐ dǐkàng xìjūn gǎnrǎn.',
    example_vi = 'Kiên trì rèn luyện thể thao điều độ và sinh hoạt hợp lý giúp tăng cường rõ rệt khả năng miễn dịch để kháng cự nhiễm khuẩn.'
WHERE id = '49b2dbb1-dc17-4819-a1ed-533bf4aa89fe' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '49b2dbb1-dc17-4819-a1ed-533bf4aa89fe', '坚持适度规律的体育锻炼与合理作息，有助于显著增强身体免疫力以抵抗细菌感染。', 'Jiānchí shìdù guīlǜ de tǐyù duànliàn yǔ hélǐ zuòxī, yǒuzhùyú xiǎnzhù zēngqiáng shēntǐ miǎnyìlì yǐ dǐkàng xìjūn gǎnrǎn.', 'Kiên trì rèn luyện thể thao điều độ và sinh hoạt hợp lý giúp tăng cường rõ rệt khả năng miễn dịch để kháng cự nhiễm khuẩn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '49b2dbb1-dc17-4819-a1ed-533bf4aa89fe'
);

-- [顶] (dǐng): đỉnh, đội, chống cự
UPDATE public.vocabularies
SET example_hanzi = '地质科考队员顶着呼啸刺骨的高原严寒与稀薄氧气，历经艰难终于成功登上雪山山顶。',
    example_pinyin = 'Dìzhì kěkǎoduìyuán dǐng zhe hūxiào cìgǔ de gāoyuán yánhán yǔ xībó yǎngqì, lìjīng jiānnán zhōngyú chénggōng dēngshang xuěshān shāndǐng.',
    example_vi = 'Đoàn khảo sát địa chất chống chọi với cái lạnh thấu xương và dưỡng khí loãng trên cao nguyên, vượt bao gian nan cuối cùng đã lên tới đỉnh núi tuyết.'
WHERE id = '1d8cbc56-0e6d-47ff-82fd-1926184d6070' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1d8cbc56-0e6d-47ff-82fd-1926184d6070', '地质科考队员顶着呼啸刺骨的高原严寒与稀薄氧气，历经艰难终于成功登上雪山山顶。', 'Dìzhì kěkǎoduìyuán dǐng zhe hūxiào cìgǔ de gāoyuán yánhán yǔ xībó yǎngqì, lìjīng jiānnán zhōngyú chénggōng dēngshang xuěshān shāndǐng.', 'Đoàn khảo sát địa chất chống chọi với cái lạnh thấu xương và dưỡng khí loãng trên cao nguyên, vượt bao gian nan cuối cùng đã lên tới đỉnh núi tuyết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1d8cbc56-0e6d-47ff-82fd-1926184d6070'
);

-- [定义] (dìngyì): định nghĩa
UPDATE public.vocabularies
SET example_hanzi = '在撰写学术论文时，作者应当首先对文中所涉及的核心专业概念给出清晰准确的科学定义。',
    example_pinyin = 'Zài zhuànxiě xuéshù lùnwén shí, zuòzhě yīngdāng shǒuxiān duì wén zhōng suǒ shèjí de héxīn zhuānyè gàiniàn gěichū qīngxī zhǔnquè de kēxué dìngyì.',
    example_vi = 'Khi viết luận văn học thuật, tác giả trước hết cần đưa ra định nghĩa khoa học rõ ràng chuẩn xác cho các khái niệm chuyên môn cốt lõi đề cập trong bài.'
WHERE id = 'baa02802-6b43-4d0b-a11a-48c13b765e40' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'baa02802-6b43-4d0b-a11a-48c13b765e40', '在撰写学术论文时，作者应当首先对文中所涉及的核心专业概念给出清晰准确的科学定义。', 'Zài zhuànxiě xuéshù lùnwén shí, zuòzhě yīngdāng shǒuxiān duì wén zhōng suǒ shèjí de héxīn zhuānyè gàiniàn gěichū qīngxī zhǔnquè de kēxué dìngyì.', 'Khi viết luận văn học thuật, tác giả trước hết cần đưa ra định nghĩa khoa học rõ ràng chuẩn xác cho các khái niệm chuyên môn cốt lõi đề cập trong bài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'baa02802-6b43-4d0b-a11a-48c13b765e40'
);

-- [地质] (dìzhì): địa chất
UPDATE public.vocabularies
SET example_hanzi = '勘测工程师通过提取岩石钻孔样本，深入分析了该山区隧道施工沿线的地质断层构造。',
    example_pinyin = 'Kāncè gōngchéngshī tōngguò tíqǔ yánshí zuānkǒng yàngběn, shēnrù fēnxī le gāi shānqū suìdào shīgōng yánxiàn de dìzhì duàncéng gòuzào.',
    example_vi = 'Kỹ sư trắc địa thông qua việc lấy mẫu lõi khoan đá đã phân tích sâu cấu tạo đứt gãy địa chất dọc tuyến thi công đường hầm miền núi.'
WHERE id = 'e72d560b-0a51-47c4-b851-22eaaa5502c1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e72d560b-0a51-47c4-b851-22eaaa5502c1', '勘测工程师通过提取岩石钻孔样本，深入分析了该山区隧道施工沿线的地质断层构造。', 'Kāncè gōngchéngshī tōngguò tíqǔ yánshí zuānkǒng yàngběn, shēnrù fēnxī le gāi shānqū suìdào shīgōng yánxiàn de dìzhì duàncéng gòuzào.', 'Kỹ sư trắc địa thông qua việc lấy mẫu lõi khoan đá đã phân tích sâu cấu tạo đứt gãy địa chất dọc tuyến thi công đường hầm miền núi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e72d560b-0a51-47c4-b851-22eaaa5502c1'
);

-- [栋] (dòng): tòa, căn (nhà)
UPDATE public.vocabularies
SET example_hanzi = '大学新校区依山傍水，绿树掩映之中矗立着一栋栋现代化的教学楼和实验大楼。',
    example_pinyin = 'Dàxué xīn xiàoqū yīshān-bàngshuǐ, lǜshù yǎnyìng zhīzhōng chùlì zhe yí dòng dòng xiàndàihuà de jiàoxuélóu hé shíyàn dàlóu.',
    example_vi = 'Khu trường mới tựa lưng vào núi hướng ra mặt nước, ẩn hiện giữa rặng cây xanh là từng tòa nhà giảng dạy và phòng thí nghiệm hiện đại.'
WHERE id = 'e3dc90b7-5c44-48d2-bd12-6c72130eab74' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e3dc90b7-5c44-48d2-bd12-6c72130eab74', '大学新校区依山傍水，绿树掩映之中矗立着一栋栋现代化的教学楼和实验大楼。', 'Dàxué xīn xiàoqū yīshān-bàngshuǐ, lǜshù yǎnyìng zhīzhōng chùlì zhe yí dòng dòng xiàndàihuà de jiàoxuélóu hé shíyàn dàlóu.', 'Khu trường mới tựa lưng vào núi hướng ra mặt nước, ẩn hiện giữa rặng cây xanh là từng tòa nhà giảng dạy và phòng thí nghiệm hiện đại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e3dc90b7-5c44-48d2-bd12-6c72130eab74'
);

-- [动机] (dòngjī): động cơ, mục đích
UPDATE public.vocabularies
SET example_hanzi = '警方经过深入调查与心理画像分析，最终彻底查明了犯罪嫌疑人作案的真实动机。',
    example_pinyin = 'Jǐngfāng jīngguò shēnrù diàochá yǔ xīnlǐ huàxiàng fēnxī, zuìzhōng chèdǐ chámíng le fànzuì xiányírén zuò''àn de zhēnshí dòngjī.',
    example_vi = 'Cảnh sát qua điều tra chuyên sâu và phân tích họa đồ tâm lý cuối cùng đã làm rõ động cơ phạm tội thực sự của kẻ tình nghi.'
WHERE id = 'df0c7863-a98e-44f1-a8d3-a820fd6d282e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'df0c7863-a98e-44f1-a8d3-a820fd6d282e', '警方经过深入调查与心理画像分析，最终彻底查明了犯罪嫌疑人作案的真实动机。', 'Jǐngfāng jīngguò shēnrù diàochá yǔ xīnlǐ huàxiàng fēnxī, zuìzhōng chèdǐ chámíng le fànzuì xiányírén zuò''àn de zhēnshí dòngjī.', 'Cảnh sát qua điều tra chuyên sâu và phân tích họa đồ tâm lý cuối cùng đã làm rõ động cơ phạm tội thực sự của kẻ tình nghi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'df0c7863-a98e-44f1-a8d3-a820fd6d282e'
);

-- [动力] (dònglì): động lực
UPDATE public.vocabularies
SET example_hanzi = '对未知世界的强烈好奇心与探索欲，始终是推动人类科学技术不断向前发展的核心动力。',
    example_pinyin = 'Duì wèizhī shìjiè de qiángliè hàoqíxīn yǔ tànsuǒyù, shǐzhōng shì tuīdòng rénlèi kēxué jìshù búduàn xiàng qián fāzhǎn de héxīn dònglì.',
    example_vi = 'Lòng hiếu kỳ mạnh mẽ và khát khao khám phá thế giới chưa biết luôn là động lực cốt lõi thúc đẩy khoa học kỹ thuật nhân loại không ngừng tiến bước.'
WHERE id = 'fd1107e7-43e2-491b-8e6a-6952009735d3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fd1107e7-43e2-491b-8e6a-6952009735d3', '对未知世界的强烈好奇心与探索欲，始终是推动人类科学技术不断向前发展的核心动力。', 'Duì wèizhī shìjiè de qiángliè hàoqíxīn yǔ tànsuǒyù, shǐzhōng shì tuīdòng rénlèi kēxué jìshù búduàn xiàng qián fāzhǎn de héxīn dònglì.', 'Lòng hiếu kỳ mạnh mẽ và khát khao khám phá thế giới chưa biết luôn là động lực cốt lõi thúc đẩy khoa học kỹ thuật nhân loại không ngừng tiến bước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fd1107e7-43e2-491b-8e6a-6952009735d3'
);

-- [动态] (dòngtài): động thái, tình hình
UPDATE public.vocabularies
SET example_hanzi = '金融分析师通过实时行情图表，严密追踪全球股票和外汇市场的最新交易动态。',
    example_pinyin = 'Jīnróng fēnxīshī tōngguò shíshí hángqíng túbiǎo, yánmì zhuīzōng quánqiú gǔpiào hé wàihuì shìchǎng de zuìxīn jiāoyì dòngtài.',
    example_vi = 'Chuyên viên phân tích tài chính thông qua biểu đồ thị trường thời gian thực bám sát tình hình động thái giao dịch mới nhất trên thị trường cổ phiếu và ngoại hối.'
WHERE id = '206607de-670b-464a-8710-3c6838aa72ea' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '206607de-670b-464a-8710-3c6838aa72ea', '金融分析师通过实时行情图表，严密追踪全球股票和外汇市场的最新交易动态。', 'Jīnróng fēnxīshī tōngguò shíshí hángqíng túbiǎo, yánmì zhuīzōng quánqiú gǔpiào hé wàihuì shìchǎng de zuìxīn jiāoyì dòngtài.', 'Chuyên viên phân tích tài chính thông qua biểu đồ thị trường thời gian thực bám sát tình hình động thái giao dịch mới nhất trên thị trường cổ phiếu và ngoại hối.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '206607de-670b-464a-8710-3c6838aa72ea'
);

-- [逗] (dòu): trêu chọc, buồn cười
UPDATE public.vocabularies
SET example_hanzi = '舞台上的滑稽小丑戴着夸张的红鼻子，几个幽默滑稽的动作逗得全场观众哈哈大笑。',
    example_pinyin = 'Wǔtái shang de huájī xiǎochǒu dài zhe kuāzhāng de hóng bízi, jǐ gè yōumò huájī de dòngzuò dòu de quánchǎng guānzhòng hāhā dàxiào.',
    example_vi = 'Chú hề trên sân khấu đeo chiếc mũi đỏ phóng đại, mấy động tác hài hước đã trêu đùa chọc cười khán giả cả khán phòng cười nắc nẻ.'
WHERE id = 'c829c335-81ee-40c6-9993-44927fe2fa0e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c829c335-81ee-40c6-9993-44927fe2fa0e', '舞台上的滑稽小丑戴着夸张的红鼻子，几个幽默滑稽的动作逗得全场观众哈哈大笑。', 'Wǔtái shang de huájī xiǎochǒu dài zhe kuāzhāng de hóng bízi, jǐ gè yōumò huájī de dòngzuò dòu de quánchǎng guānzhòng hāhā dàxiào.', 'Chú hề trên sân khấu đeo chiếc mũi đỏ phóng đại, mấy động tác hài hước đã trêu đùa chọc cười khán giả cả khán phòng cười nắc nẻ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c829c335-81ee-40c6-9993-44927fe2fa0e'
);

-- [斗争] (dòuzhēng): đấu tranh
UPDATE public.vocabularies
SET example_hanzi = '老一辈革命家为了争取民族独立与人民解放，同国内外侵略势力进行了艰苦卓绝的英勇斗争。',
    example_pinyin = 'Lǎoyíbèi gémìngjiā wèile zhēngqǔ mínzú dúlì yǔ rénmín jiěfàng, tóng guónèi-wài qīnlüè shìlì jìnxíng le jiānkǔ-zhuójué de yīngyǒng dòuzhēng.',
    example_vi = 'Thế hệ nhà cách mạng tiền bối vì giành độc lập dân tộc và giải phóng nhân dân đã tiến hành cuộc đấu tranh anh dũng kiên cường chống lại các thế lực xâm lược.'
WHERE id = '00824429-c915-4de4-a2c7-6ef11f9cdbb3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '00824429-c915-4de4-a2c7-6ef11f9cdbb3', '老一辈革命家为了争取民族独立与人民解放，同国内外侵略势力进行了艰苦卓绝的英勇斗争。', 'Lǎoyíbèi gémìngjiā wèile zhēngqǔ mínzú dúlì yǔ rénmín jiěfàng, tóng guónèi-wài qīnlüè shìlì jìnxíng le jiānkǔ-zhuójué de yīngyǒng dòuzhēng.', 'Thế hệ nhà cách mạng tiền bối vì giành độc lập dân tộc và giải phóng nhân dân đã tiến hành cuộc đấu tranh anh dũng kiên cường chống lại các thế lực xâm lược.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '00824429-c915-4de4-a2c7-6ef11f9cdbb3'
);

-- [端] (duān): bưng, bê, đầu mút, ngay thẳng
UPDATE public.vocabularies
SET example_hanzi = '服务员面带微笑，动作轻盈稳妥地给每一桌客人端上刚出锅的热腾腾特色菜肴。',
    example_pinyin = 'Fúwùyuán miàn dài wēixiào, dòngzuò qīngyíng wěntuǒ de gěi měi yì zhuō kèrén duān shang gāng chūguō de rèténgténg tèsè càiyáo.',
    example_vi = 'Nhân viên phục vụ nở nụ cười tươi tắn, động tác nhẹ nhàng khéo léo bưng lên từng bàn món ăn đặc sắc nóng hổi vừa mới ra lò.'
WHERE id = 'd35466a9-7a86-4851-936a-bac91fcbd0fa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd35466a9-7a86-4851-936a-bac91fcbd0fa', '服务员面带微笑，动作轻盈稳妥地给每一桌客人端上刚出锅的热腾腾特色菜肴。', 'Fúwùyuán miàn dài wēixiào, dòngzuò qīngyíng wěntuǒ de gěi měi yì zhuō kèrén duān shang gāng chūguō de rèténgténg tèsè càiyáo.', 'Nhân viên phục vụ nở nụ cười tươi tắn, động tác nhẹ nhàng khéo léo bưng lên từng bàn món ăn đặc sắc nóng hổi vừa mới ra lò.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd35466a9-7a86-4851-936a-bac91fcbd0fa'
);

-- [对称] (duìchèn): đối xứng
UPDATE public.vocabularies
SET example_hanzi = '中国古代宫殿建筑格外注重轴线布局，飞檐斗拱和殿堂门窗往往呈现严谨的对称之美。',
    example_pinyin = 'Zhōngguó gǔdài gōngdiàn jiànzhù géwài zhùzhòng zhóuxiàn bùjú, fēiyán-dǒugǒng hé diàntáng ménchuāng wǎngwǎng chéngxiàn yánjǐn de duìchèn zhī měi.',
    example_vi = 'Kiến trúc cung điện cổ đại Trung Hoa rất chú trọng bố cục trục giữa, mái hiên uốn cong cùng cửa nẻo điện đường luôn toát lên vẻ đẹp đối xứng nghiêm cẩn.'
WHERE id = 'f7b98c6a-4a5e-4ef4-9411-48f5b0f13f03' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f7b98c6a-4a5e-4ef4-9411-48f5b0f13f03', '中国古代宫殿建筑格外注重轴线布局，飞檐斗拱和殿堂门窗往往呈现严谨的对称之美。', 'Zhōngguó gǔdài gōngdiàn jiànzhù géwài zhùzhòng zhóuxiàn bùjú, fēiyán-dǒugǒng hé diàntáng ménchuāng wǎngwǎng chéngxiàn yánjǐn de duìchèn zhī měi.', 'Kiến trúc cung điện cổ đại Trung Hoa rất chú trọng bố cục trục giữa, mái hiên uốn cong cùng cửa nẻo điện đường luôn toát lên vẻ đẹp đối xứng nghiêm cẩn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f7b98c6a-4a5e-4ef4-9411-48f5b0f13f03'
);

-- [对抗] (duìkàng): đối kháng, chống lại
UPDATE public.vocabularies
SET example_hanzi = '和平与发展是不可阻挡的历史大势，国际社会各方应摒弃冷战对抗思维、深化合作共赢。',
    example_pinyin = 'Hépíng yǔ fāzhǎn shì bùkě zǔdǎng de lìshǐ dàshì, guójì shèhuì gè fāng yīng bìngqì lěngzhàn duìkàng sīwéi, shēnhuà hézuò gòngyíng.',
    example_vi = 'Hòa bình và phát triển là xu thế lịch sử không thể ngăn cản, các bên trong cộng đồng quốc tế nên gạt bỏ tư duy đối kháng chiến tranh lạnh để làm sâu sắc hợp tác cùng thắng.'
WHERE id = '57d9fcf5-6ff9-46b5-8111-4a3fdee2a896' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '57d9fcf5-6ff9-46b5-8111-4a3fdee2a896', '和平与发展是不可阻挡的历史大势，国际社会各方应摒弃冷战对抗思维、深化合作共赢。', 'Hépíng yǔ fāzhǎn shì bùkě zǔdǎng de lìshǐ dàshì, guójì shèhuì gè fāng yīng bìngqì lěngzhàn duìkàng sīwéi, shēnhuà hézuò gòngyíng.', 'Hòa bình và phát triển là xu thế lịch sử không thể ngăn cản, các bên trong cộng đồng quốc tế nên gạt bỏ tư duy đối kháng chiến tranh lạnh để làm sâu sắc hợp tác cùng thắng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '57d9fcf5-6ff9-46b5-8111-4a3fdee2a896'
);

-- [对立] (duìlì): đối lập
UPDATE public.vocabularies
SET example_hanzi = '在学术自由讨论中，哪怕持有完全对立的理论观点，学者之间也应当相互尊重与理性对话。',
    example_pinyin = 'Zài xuéshù zìyóu tǎolùn zhōng, nǎpà chíyǒu wánquán duìlì de lǐlùn guāndiǎn, xuézhě zhījiān yě yīngdāng xiānghù zūnzhòng yǔ lǐxìng duìhuà.',
    example_vi = 'Trong tranh luận học thuật tự do, dù cho giữ quan điểm lý luận đối lập hoàn toàn thì giữa các học giả vẫn nên tôn trọng lẫn nhau và đối thoại lý tính.'
WHERE id = '6a2ce0d5-d1cb-45e7-bfe2-217e1a5f6f8d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6a2ce0d5-d1cb-45e7-bfe2-217e1a5f6f8d', '在学术自由讨论中，哪怕持有完全对立的理论观点，学者之间也应当相互尊重与理性对话。', 'Zài xuéshù zìyóu tǎolùn zhōng, nǎpà chíyǒu wánquán duìlì de lǐlùn guāndiǎn, xuézhě zhījiān yě yīngdāng xiānghù zūnzhòng yǔ lǐxìng duìhuà.', 'Trong tranh luận học thuật tự do, dù cho giữ quan điểm lý luận đối lập hoàn toàn thì giữa các học giả vẫn nên tôn trọng lẫn nhau và đối thoại lý tính.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6a2ce0d5-d1cb-45e7-bfe2-217e1a5f6f8d'
);

-- [对应] (duìyìng): tương ứng
UPDATE public.vocabularies
SET example_hanzi = '在这套双语词典中，每一个生僻外语词汇都标注了汉语释义以及相对应的典型例句。',
    example_pinyin = 'Zài zhè tào shuāngyǔ cídiǎn zhōng, měi yí gè shēngpì wàiyǔ cíhuì dōu biāozhù le Hànyǔ shìyì yǐjí xiāng duìyìng de diǎnxíng lìjù.',
    example_vi = 'Trong bộ từ điển song ngữ này, mỗi từ vựng ngoại ngữ mới đều được chú thích nghĩa tiếng Hán cùng các câu ví dụ điển hình tương ứng.'
WHERE id = 'fc76dda8-d402-4f77-945f-fbf7fb568b36' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fc76dda8-d402-4f77-945f-fbf7fb568b36', '在这套双语词典中，每一个生僻外语词汇都标注了汉语释义以及相对应的典型例句。', 'Zài zhè tào shuāngyǔ cídiǎn zhōng, měi yí gè shēngpì wàiyǔ cíhuì dōu biāozhù le Hànyǔ shìyì yǐjí xiāng duìyìng de diǎnxíng lìjù.', 'Trong bộ từ điển song ngữ này, mỗi từ vựng ngoại ngữ mới đều được chú thích nghĩa tiếng Hán cùng các câu ví dụ điển hình tương ứng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fc76dda8-d402-4f77-945f-fbf7fb568b36'
);

-- [蹲] (dūn): ngồi xổm
UPDATE public.vocabularies
SET example_hanzi = '小男孩轻轻蹲在花坛旁边，全神贯注地观察一只小蚂蚁如何吃力地搬运面包碎屑。',
    example_pinyin = 'Xiǎo nánhái qīngqīng dūn zài huātán pángbiān, quánshén-guànzhù de guānchá yì zhī xiǎo mǎyǐ rúhé chīlì de bānyùn miànbāo suìxiè.',
    example_vi = 'Cậu bé ngồi xổm nhẹ nhàng bên bồn hoa, chăm chú quan sát một chú kiến nhỏ đang vất vả tha mẩu vụn bánh mì.'
WHERE id = '70b3d139-b4fd-47b8-a3a0-5d00042801d9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '70b3d139-b4fd-47b8-a3a0-5d00042801d9', '小男孩轻轻蹲在花坛旁边，全神贯注地观察一只小蚂蚁如何吃力地搬运面包碎屑。', 'Xiǎo nánhái qīngqīng dūn zài huātán pángbiān, quánshén-guànzhù de guānchá yì zhī xiǎo mǎyǐ rúhé chīlì de bānyùn miànbāo suìxiè.', 'Cậu bé ngồi xổm nhẹ nhàng bên bồn hoa, chăm chú quan sát một chú kiến nhỏ đang vất vả tha mẩu vụn bánh mì.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '70b3d139-b4fd-47b8-a3a0-5d00042801d9'
);

-- [顿时] (dùnshí): ngay lập tức, bỗng chốc
UPDATE public.vocabularies
SET example_hanzi = '当主裁判吹响比赛结束的清脆哨音，全场数万名主场球迷顿时爆发出雷鸣般的欢呼。',
    example_pinyin = 'Dāng zhǔcàipàn chuīxiǎng bǐsài jiéshù de qīngcuì shàoyīn, quánchǎng shùwàn míng zhǔchǎng qiúmí dùnshí bàofā chū léimíng bān de huānhū.',
    example_vi = 'Khi trọng tài chính thổi hồi còi giòn giã kết thúc trận đấu, hàng vạn người hâm mộ đội nhà trên sân bỗng chốc vỡ òa reo hò như sấm dậy.'
WHERE id = '2e895462-7a45-4de6-b54c-f739380da2d4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2e895462-7a45-4de6-b54c-f739380da2d4', '当主裁判吹响比赛结束的清脆哨音，全场数万名主场球迷顿时爆发出雷鸣般的欢呼。', 'Dāng zhǔcàipàn chuīxiǎng bǐsài jiéshù de qīngcuì shàoyīn, quánchǎng shùwàn míng zhǔchǎng qiúmí dùnshí bàofā chū léimíng bān de huānhū.', 'Khi trọng tài chính thổi hồi còi giòn giã kết thúc trận đấu, hàng vạn người hâm mộ đội nhà trên sân bỗng chốc vỡ òa reo hò như sấm dậy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2e895462-7a45-4de6-b54c-f739380da2d4'
);

-- [多亏] (duōkuī): may mà, nhờ có
UPDATE public.vocabularies
SET example_hanzi = '今天多亏有经验丰富的老船长果断掌舵，我们的游船才在暴风雨来临前平安靠港。',
    example_pinyin = 'Jīntiān duōkuī yǒu jīngyàn fēngfù de lǎo chuánzhǎng guǒduàn zhǎngduò, wǒmen de yóuchuán cái zài bàofēngyǔ láilín qián píng''ān kàogǎng.',
    example_vi = 'Hôm nay may mà có vị thuyền trưởng già dạn dày kinh nghiệm vững tay lái, tàu du lịch của chúng tôi mới cập bến an toàn trước khi cơn bão ập tới.'
WHERE id = 'ab2996bb-882a-45d3-b2a1-eb20469c29f5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ab2996bb-882a-45d3-b2a1-eb20469c29f5', '今天多亏有经验丰富的老船长果断掌舵，我们的游船才在暴风雨来临前平安靠港。', 'Jīntiān duōkuī yǒu jīngyàn fēngfù de lǎo chuánzhǎng guǒduàn zhǎngduò, wǒmen de yóuchuán cái zài bàofēngyǔ láilín qián píng''ān kàogǎng.', 'Hôm nay may mà có vị thuyền trưởng già dạn dày kinh nghiệm vững tay lái, tàu du lịch của chúng tôi mới cập bến an toàn trước khi cơn bão ập tới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ab2996bb-882a-45d3-b2a1-eb20469c29f5'
);

-- [多余] (duōyú): dư thừa
UPDATE public.vocabularies
SET example_hanzi = '这篇议论文立意深刻、文字精炼，没有任何一句与中心思想无关的多余废话。',
    example_pinyin = 'Zhè piān yìlùnwén lìyì shēnkè, wénzì jīngliàn, méiyǒu rènhé yí jù yǔ zhōngxīn sīxiǎng wúguān de duōyú fèihuà.',
    example_vi = 'Bài văn nghị luận này xác lập ý tứ sâu sắc, câu chữ cô đọng súc tích, không hề có bất kỳ câu nói thừa thãi nào xa rời tư tưởng chủ đề.'
WHERE id = '1ade2559-4230-48ca-91e8-6a48120ab24b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1ade2559-4230-48ca-91e8-6a48120ab24b', '这篇议论文立意深刻、文字精炼，没有任何一句与中心思想无关的多余废话。', 'Zhè piān yìlùnwén lìyì shēnkè, wénzì jīngliàn, méiyǒu rènhé yí jù yǔ zhōngxīn sīxiǎng wúguān de duōyú fèihuà.', 'Bài văn nghị luận này xác lập ý tứ sâu sắc, câu chữ cô đọng súc tích, không hề có bất kỳ câu nói thừa thãi nào xa rời tư tưởng chủ đề.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1ade2559-4230-48ca-91e8-6a48120ab24b'
);

-- [恶心] (ě xin): buồn nôn, ghê tởm
UPDATE public.vocabularies
SET example_hanzi = '第一次乘海轮遇到大风大浪，不少原本身体健康的乘客都开始感到头晕恶心想吐。',
    example_pinyin = 'Dì-yī cì chéng hǎilún yùdào dàfēng-dàlàng, bùshǎo yuánběn shēntǐ jiànkāng de chéngkè dōu kāishǐ gǎndào tóuyūn ěxin xiǎng tù.',
    example_vi = 'Lần đầu đi tàu biển gặp sóng to gió lớn, không ít hành khách vốn khỏe mạnh đều bắt đầu thấy hoa mắt chóng mặt buồn nôn muốn ói.'
WHERE id = 'eb248ce7-8b4b-4317-90de-70954190aea6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'eb248ce7-8b4b-4317-90de-70954190aea6', '第一次乘海轮遇到大风大浪，不少原本身体健康的乘客都开始感到头晕恶心想吐。', 'Dì-yī cì chéng hǎilún yùdào dàfēng-dàlàng, bùshǎo yuánběn shēntǐ jiànkāng de chéngkè dōu kāishǐ gǎndào tóuyūn ěxin xiǎng tù.', 'Lần đầu đi tàu biển gặp sóng to gió lớn, không ít hành khách vốn khỏe mạnh đều bắt đầu thấy hoa mắt chóng mặt buồn nôn muốn ói.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'eb248ce7-8b4b-4317-90de-70954190aea6'
);

-- [恶劣] (èliè): tồi tệ, khắc nghiệt
UPDATE public.vocabularies
SET example_hanzi = '尽管边疆哨所的气候条件十分恶劣，年轻的边防战士们依然日夜警惕地保卫着祖国边疆。',
    example_pinyin = 'Jǐnguǎn biānjiāng shàosuǒ de qìhòu tiáojiàn shífēn èliè, niánqīng de biānfáng zhànshì men yīrán rìyè jǐngtì de bǎowèi zhe zǔguó biānjiāng.',
    example_vi = 'Dẫu cho điều kiện khí hậu nơi trạm gác biên cương vô cùng khắc nghiệt tồi tệ, các chiến sĩ biên phòng trẻ tuổi vẫn ngày đêm cảnh giác bảo vệ biên cương tổ quốc.'
WHERE id = 'b1128a43-86a2-4f96-a8b8-a449bfdc2db6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b1128a43-86a2-4f96-a8b8-a449bfdc2db6', '尽管边疆哨所的气候条件十分恶劣，年轻的边防战士们依然日夜警惕地保卫着祖国边疆。', 'Jǐnguǎn biānjiāng shàosuǒ de qìhòu tiáojiàn shífēn èliè, niánqīng de biānfáng zhànshì men yīrán rìyè jǐngtì de bǎowèi zhe zǔguó biānjiāng.', 'Dẫu cho điều kiện khí hậu nơi trạm gác biên cương vô cùng khắc nghiệt tồi tệ, các chiến sĩ biên phòng trẻ tuổi vẫn ngày đêm cảnh giác bảo vệ biên cương tổ quốc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b1128a43-86a2-4f96-a8b8-a449bfdc2db6'
);

-- [耳环] (ěrhuán): bông tai, khuyên tai
UPDATE public.vocabularies
SET example_hanzi = '在隆重的晚宴上，她戴着一对精致的珍珠耳环，整个人显得格外优雅高贵。',
    example_pinyin = 'Zài lóngzhòng de wǎnyàn shang, tā dài zhe yí duì jīngzhì de zhēnzhū ěrhuán, zhěng gè rén xiǎn de géwài yōuyǎ gāoguì.',
    example_vi = 'Tại bữa tiệc tối long trọng, cô ấy đeo một đôi hoa tai ngọc trai tinh xảo, toát lên phong thái vô cùng thanh lịch cao quý.'
WHERE id = '86024e42-d24c-47a8-9499-6c6b51673771' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '86024e42-d24c-47a8-9499-6c6b51673771', '在隆重的晚宴上，她戴着一对精致的珍珠耳环，整个人显得格外优雅高贵。', 'Zài lóngzhòng de wǎnyàn shang, tā dài zhe yí duì jīngzhì de zhēnzhū ěrhuán, zhěng gè rén xiǎn de géwài yōuyǎ gāoguì.', 'Tại bữa tiệc tối long trọng, cô ấy đeo một đôi hoa tai ngọc trai tinh xảo, toát lên phong thái vô cùng thanh lịch cao quý.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '86024e42-d24c-47a8-9499-6c6b51673771'
);

-- [二氧化碳] (èryǎnghuàtàn): khí cacbonic, CO2
UPDATE public.vocabularies
SET example_hanzi = '绿色植物通过光合作用吸收空气中的二氧化碳，并释放出维持生命必需的氧气。',
    example_pinyin = 'Lǜsè zhíwù tōngguò guānghé zuòyòng xīshōu kōngqì zhōng de èryǎnghuàtàn, bìng shìfàng chū wéichí shēngmìng bìxū de yǎngqì.',
    example_vi = 'Cây xanh thông qua quang hợp hấp thụ khí carbonic trong không khí và giải phóng khí oxy thiết yếu để duy trì sự sống.'
WHERE id = '3531942a-c54e-47c9-b9aa-e0dd1efb40b8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3531942a-c54e-47c9-b9aa-e0dd1efb40b8', '绿色植物通过光合作用吸收空气中的二氧化碳，并释放出维持生命必需的氧气。', 'Lǜsè zhíwù tōngguò guānghé zuòyòng xīshōu kōngqì zhōng de èryǎnghuàtàn, bìng shìfàng chū wéichí shēngmìng bìxū de yǎngqì.', 'Cây xanh thông qua quang hợp hấp thụ khí carbonic trong không khí và giải phóng khí oxy thiết yếu để duy trì sự sống.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3531942a-c54e-47c9-b9aa-e0dd1efb40b8'
);

-- [发愁] (fāchóu): lo lắng, lo buồn
UPDATE public.vocabularies
SET example_hanzi = '眼看麦田就要到了收获的季节却连日降雨，田边的老农夫正站在田埂上为收割发愁。',
    example_pinyin = 'Yǎnkàn màitián jiù yào dào le shōuhuò de jìjié què liánrì jiàngyǔ, tiánbiān de lǎo nóngfū zhèng zhàn zài tiángěng shang wèi shōugē fāchóu.',
    example_vi = 'Mắt thấy ruộng lúa mì sắp đến vụ thu hoạch mà mưa dầm liên miên, bác nông dân già đang đứng trên bờ ruộng rầu rĩ lo âu vì việc gặt hái.'
WHERE id = '18bbb34e-d6ac-415b-b8e8-2a987b1301aa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '18bbb34e-d6ac-415b-b8e8-2a987b1301aa', '眼看麦田就要到了收获的季节却连日降雨，田边的老农夫正站在田埂上为收割发愁。', 'Yǎnkàn màitián jiù yào dào le shōuhuò de jìjié què liánrì jiàngyǔ, tiánbiān de lǎo nóngfū zhèng zhàn zài tiángěng shang wèi shōugē fāchóu.', 'Mắt thấy ruộng lúa mì sắp đến vụ thu hoạch mà mưa dầm liên miên, bác nông dân già đang đứng trên bờ ruộng rầu rĩ lo âu vì việc gặt hái.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '18bbb34e-d6ac-415b-b8e8-2a987b1301aa'
);

-- [发动] (fādòng): phát động, khởi động
UPDATE public.vocabularies
SET example_hanzi = '社区居委会积极发动全体居民参与周末绿化植树活动，共同美化家园环境。',
    example_pinyin = 'Shèqū jūwěihuì jījí fādòng quántǐ jūmín cānyù zhōumò lǜhuà zhíshù huódòng, gòngtóng měihuà jiāyuán huánjìng.',
    example_vi = 'Ban quản trị khu dân cư tích cực phát động toàn thể cư dân tham gia hoạt động trồng cây xanh cuối tuần để cùng làm đẹp môi trường sống.'
WHERE id = '3715f7a0-af22-4b49-bb25-e21d861ace72' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3715f7a0-af22-4b49-bb25-e21d861ace72', '社区居委会积极发动全体居民参与周末绿化植树活动，共同美化家园环境。', 'Shèqū jūwěihuì jījí fādòng quántǐ jūmín cānyù zhōumò lǜhuà zhíshù huódòng, gòngtóng měihuà jiāyuán huánjìng.', 'Ban quản trị khu dân cư tích cực phát động toàn thể cư dân tham gia hoạt động trồng cây xanh cuối tuần để cùng làm đẹp môi trường sống.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3715f7a0-af22-4b49-bb25-e21d861ace72'
);

-- [番] (fān): lần, lượt, phen
UPDATE public.vocabularies
SET example_hanzi = '经过全院专家的一番紧急会诊与抢救，突发心脏病的危重病人终于转危为安。',
    example_pinyin = 'Jīngguò quányuàn zhuānjiā de yì fān jǐnjí huìzhěn yǔ qiǎngjiù, tūfā xīnzàngbìng de wēizhòng bìngrén zhōngyú zhuǎnwēi-wéi''ān.',
    example_vi = 'Trải qua một phen hội chẩn cấp cứu khẩn trương của các chuyên gia toàn viện, bệnh nhân nguy kịch đột quỵ tim cuối cùng đã qua cơn hiểm nghèo.'
WHERE id = '5fec446f-b0f3-436b-bcb4-2308229b671a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5fec446f-b0f3-436b-bcb4-2308229b671a', '经过全院专家的一番紧急会诊与抢救，突发心脏病的危重病人终于转危为安。', 'Jīngguò quányuàn zhuānjiā de yì fān jǐnjí huìzhěn yǔ qiǎngjiù, tūfā xīnzàngbìng de wēizhòng bìngrén zhōngyú zhuǎnwēi-wéi''ān.', 'Trải qua một phen hội chẩn cấp cứu khẩn trương của các chuyên gia toàn viện, bệnh nhân nguy kịch đột quỵ tim cuối cùng đã qua cơn hiểm nghèo.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5fec446f-b0f3-436b-bcb4-2308229b671a'
);

-- [妨碍] (fáng'ài): cản trở, gây trở ngại
UPDATE public.vocabularies
SET example_hanzi = '走廊通道属于公共消防逃生通道，请勿随意堆放杂物以免妨碍他人正常通行。',
    example_pinyin = 'Zǒuláng tōngdào shǔyú gōnggòng xiāofáng táoshēng tōngdào, qǐng wù suíyì duīfàng záwù yǐmiǎn fáng''ài tārén zhèngcháng tōngxíng.',
    example_vi = 'Lối đi hành lang là lối thoát hiểm phòng cháy công cộng, xin đừng tùy tiện chất đồ bừa bãi kẻo gây cản trở người khác đi lại bình thường.'
WHERE id = 'f894dc2d-9c55-4fe9-a972-7eed0c414b3e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f894dc2d-9c55-4fe9-a972-7eed0c414b3e', '走廊通道属于公共消防逃生通道，请勿随意堆放杂物以免妨碍他人正常通行。', 'Zǒuláng tōngdào shǔyú gōnggòng xiāofáng táoshēng tōngdào, qǐng wù suíyì duīfàng záwù yǐmiǎn fáng''ài tārén zhèngcháng tōngxíng.', 'Lối đi hành lang là lối thoát hiểm phòng cháy công cộng, xin đừng tùy tiện chất đồ bừa bãi kẻo gây cản trở người khác đi lại bình thường.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f894dc2d-9c55-4fe9-a972-7eed0c414b3e'
);

-- [放大] (fàngdà): phóng to, mở rộng
UPDATE public.vocabularies
SET example_hanzi = '科学家利用高倍电子显微镜将生物细胞样本放大了数万倍，清晰观察到了细胞核结构。',
    example_pinyin = 'Kēxuéjiā lìyòng gāobèi diànzǐ xiǎnwéijìng jiāng shēngwù xìbāo yàngběn fàngdà le shùwàn bèi, qīngxī guānchá dào le xìbāohé jiégòu.',
    example_vi = 'Nhà khoa học dùng kính hiển vi điện tử độ phóng đại cao phóng to mẫu tế bào sinh vật lên hàng vạn lần, quan sát rõ ràng cấu trúc nhân tế bào.'
WHERE id = '20425981-d60f-4c2c-9003-9301bf7c3986' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '20425981-d60f-4c2c-9003-9301bf7c3986', '科学家利用高倍电子显微镜将生物细胞样本放大了数万倍，清晰观察到了细胞核结构。', 'Kēxuéjiā lìyòng gāobèi diànzǐ xiǎnwéijìng jiāng shēngwù xìbāo yàngběn fàngdà le shùwàn bèi, qīngxī guānchá dào le xìbāohé jiégòu.', 'Nhà khoa học dùng kính hiển vi điện tử độ phóng đại cao phóng to mẫu tế bào sinh vật lên hàng vạn lần, quan sát rõ ràng cấu trúc nhân tế bào.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '20425981-d60f-4c2c-9003-9301bf7c3986'
);

-- [方位] (fāngwèi): phương vị, phương hướng
UPDATE public.vocabularies
SET example_hanzi = '在茂密无边的大森林中迷路时，野外生存者可以用指南针或北极星来准确辨别方位。',
    example_pinyin = 'Zài màomì wúbiān de dà sēnlín zhōng mílù shí, yěwài shēngcúnzhě kěyǐ yòng zhǐnánzhēn huò Běijíxīng lái zhǔnquè biànbié fāngwèi.',
    example_vi = 'Khi bị lạc trong khu rừng rậm bạt ngàn, người sinh tồn nơi hoang dã có thể dùng la bàn hoặc sao Bắc cực để xác định chính xác phương hướng.'
WHERE id = '0acfb37e-922e-49ae-9650-e4e39e29ac24' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0acfb37e-922e-49ae-9650-e4e39e29ac24', '在茂密无边的大森林中迷路时，野外生存者可以用指南针或北极星来准确辨别方位。', 'Zài màomì wúbiān de dà sēnlín zhōng mílù shí, yěwài shēngcúnzhě kěyǐ yòng zhǐnánzhēn huò Běijíxīng lái zhǔnquè biànbié fāngwèi.', 'Khi bị lạc trong khu rừng rậm bạt ngàn, người sinh tồn nơi hoang dã có thể dùng la bàn hoặc sao Bắc cực để xác định chính xác phương hướng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0acfb37e-922e-49ae-9650-e4e39e29ac24'
);

-- [方言] (fāngyán): tiếng địa phương, phương ngôn
UPDATE public.vocabularies
SET example_hanzi = '中国各省的地域方言丰富多彩，承载着各个地方深厚独特的历史民俗文化。',
    example_pinyin = 'Zhōngguó gè shěng de dìyù fāngyán fēngfù-duōcǎi, chéngzài zhe gè ge dìfāng shēnhòu dútè de lìshǐ mínsú wénhuà.',
    example_vi = 'Phương ngôn địa phương của các tỉnh Trung Quốc muôn màu muôn vẻ, chuyên chở nền văn hóa phong tục tập quán lịch sử sâu đậm đặc sắc của từng vùng.'
WHERE id = 'b187ca98-1f11-437c-abc7-ac5f15ed3b83' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b187ca98-1f11-437c-abc7-ac5f15ed3b83', '中国各省的地域方言丰富多彩，承载着各个地方深厚独特的历史民俗文化。', 'Zhōngguó gè shěng de dìyù fāngyán fēngfù-duōcǎi, chéngzài zhe gè ge dìfāng shēnhòu dútè de lìshǐ mínsú wénhuà.', 'Phương ngôn địa phương của các tỉnh Trung Quốc muôn màu muôn vẻ, chuyên chở nền văn hóa phong tục tập quán lịch sử sâu đậm đặc sắc của từng vùng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b187ca98-1f11-437c-abc7-ac5f15ed3b83'
);

-- [防治] (fángzhì): phòng và chữa trị
UPDATE public.vocabularies
SET example_hanzi = '林业科研人员坚持生物防治与化学防治相结合，有效遏制了松树林病虫害的蔓延。',
    example_pinyin = 'Línyè kēyán rényuán jiānchí shēngwù fángzhì yǔ huàxué fángzhì xiāng jiéhé, yǒuxiào èzhì le sōngshùlín bìngchónghài de mànyán.',
    example_vi = 'Cán bộ khoa học lâm nghiệp kiên trì kết hợp phòng trừ sinh học với hóa học, ngăn chặn hiệu quả sự lây lan của sâu bệnh hại rừng thông.'
WHERE id = '5117f0ae-4307-4909-986d-cdbc2d6b9975' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5117f0ae-4307-4909-986d-cdbc2d6b9975', '林业科研人员坚持生物防治与化学防治相结合，有效遏制了松树林病虫害的蔓延。', 'Línyè kēyán rényuán jiānchí shēngwù fángzhì yǔ huàxué fángzhì xiāng jiéhé, yǒuxiào èzhì le sōngshùlín bìngchónghài de mànyán.', 'Cán bộ khoa học lâm nghiệp kiên trì kết hợp phòng trừ sinh học với hóa học, ngăn chặn hiệu quả sự lây lan của sâu bệnh hại rừng thông.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5117f0ae-4307-4909-986d-cdbc2d6b9975'
);

-- [反馈] (fǎnkuì): phản hồi
UPDATE public.vocabularies
SET example_hanzi = '软件开发团队认真搜集用户的在线体验反馈，并迅速发布了修复补丁以优化使用体验。',
    example_pinyin = 'Ruǎnjiàn kāifā tuánduì rènzhēn sōují yònghù de zàixiàn tǐyàn fǎnkuì, bìng xùnsù fābù le xiūfù bǔdīng yǐ yōuhuà shǐyòng tǐyàn.',
    example_vi = 'Đội ngũ phát triển phần mềm chăm chú thu thập phản hồi trải nghiệm trực tuyến của người dùng và kịp thời phát hành bản vá sửa lỗi để nâng cấp trải nghiệm.'
WHERE id = '0cdbfc8c-d9e6-4b35-8b0a-4c1ed9362dc8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0cdbfc8c-d9e6-4b35-8b0a-4c1ed9362dc8', '软件开发团队认真搜集用户的在线体验反馈，并迅速发布了修复补丁以优化使用体验。', 'Ruǎnjiàn kāifā tuánduì rènzhēn sōují yònghù de zàixiàn tǐyàn fǎnkuì, bìng xùnsù fābù le xiūfù bǔdīng yǐ yōuhuà shǐyòng tǐyàn.', 'Đội ngũ phát triển phần mềm chăm chú thu thập phản hồi trải nghiệm trực tuyến của người dùng và kịp thời phát hành bản vá sửa lỗi để nâng cấp trải nghiệm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0cdbfc8c-d9e6-4b35-8b0a-4c1ed9362dc8'
);

-- [繁忙] (fánmáng): bận rộn
UPDATE public.vocabularies
SET example_hanzi = '作为国际航运枢纽大港，这里的货运码头昼夜运转，呈现出一派十分繁忙有序的吞吐景象。',
    example_pinyin = 'Zuòwéi guójì hángyùn shūniǔ dàgǎng, zhèlǐ de huòyùn mǎtóu zhòuyè yùnzhuǎn, chéngxiàn chū yí pài shífēn fánmáng yǒuxù de tūntǔ jǐngxiàng.',
    example_vi = 'Là cảng đầu mối vận tải quốc tế, bến cảng hàng hóa nơi đây vận hành ngày đêm, hiện ra cảnh tượng bốc xếp vô cùng tấp nập bận rộn nhưng có trật tự.'
WHERE id = 'f2aee802-4521-4459-8aab-e77a40288faf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f2aee802-4521-4459-8aab-e77a40288faf', '作为国际航运枢纽大港，这里的货运码头昼夜运转，呈现出一派十分繁忙有序的吞吐景象。', 'Zuòwéi guójì hángyùn shūniǔ dàgǎng, zhèlǐ de huòyùn mǎtóu zhòuyè yùnzhuǎn, chéngxiàn chū yí pài shífēn fánmáng yǒuxù de tūntǔ jǐngxiàng.', 'Là cảng đầu mối vận tải quốc tế, bến cảng hàng hóa nơi đây vận hành ngày đêm, hiện ra cảnh tượng bốc xếp vô cùng tấp nập bận rộn nhưng có trật tự.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f2aee802-4521-4459-8aab-e77a40288faf'
);

-- [凡是] (fánshì): phàm là, hễ là
UPDATE public.vocabularies
SET example_hanzi = '凡是涉及食品药品安全与公众生命健康的大事，各级监管部门都必须以零容忍态度严格检查。',
    example_pinyin = 'Fánshì shèjí shípǐn yàopǐn ānquán yǔ gōngzhòng shēngmìng jiànkāng de dàshì, gè jí jiānguǎn bùmén dōu bìxū yǐ líng róngrěn tàidù yángé jiǎnchá.',
    example_vi = 'Phàm là việc lớn liên quan đến an toàn thực phẩm dược phẩm và tính mạng sức khỏe cộng đồng, các cơ quan giám sát đều phải thanh tra nghiêm ngặt với thái độ không khoan nhượng.'
WHERE id = '57e754f8-c1e7-4da4-bda5-1d7efa5db78d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '57e754f8-c1e7-4da4-bda5-1d7efa5db78d', '凡是涉及食品药品安全与公众生命健康的大事，各级监管部门都必须以零容忍态度严格检查。', 'Fánshì shèjí shípǐn yàopǐn ānquán yǔ gōngzhòng shēngmìng jiànkāng de dàshì, gè jí jiānguǎn bùmén dōu bìxū yǐ líng róngrěn tàidù yángé jiǎnchá.', 'Phàm là việc lớn liên quan đến an toàn thực phẩm dược phẩm và tính mạng sức khỏe cộng đồng, các cơ quan giám sát đều phải thanh tra nghiêm ngặt với thái độ không khoan nhượng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '57e754f8-c1e7-4da4-bda5-1d7efa5db78d'
);

-- [反思] (fǎnsī): suy ngẫm, tự kiểm điểm
UPDATE public.vocabularies
SET example_hanzi = '在遭遇项目失败之后，团队成员坐在一起深刻反思工作不足，吸取宝贵经验教训。',
    example_pinyin = 'Zài zāoyù xiàngmù shībài zhīhòu, tuánduì chéngyuán zuò zài yìqǐ shēnkè fǎnsī gōngzuò bùzú, xīqǔ bǎoguì jīngyàn jiàoxun.',
    example_vi = 'Sau khi trải qua thất bại dự án, các thành viên đội ngũ đã ngồi lại với nhau tự kiểm điểm sâu sắc những thiếu sót trong công việc và rút ra bài học kinh nghiệm quý giá.'
WHERE id = '1038d3c4-7e29-421c-aaae-d46841454d81' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1038d3c4-7e29-421c-aaae-d46841454d81', '在遭遇项目失败之后，团队成员坐在一起深刻反思工作不足，吸取宝贵经验教训。', 'Zài zāoyù xiàngmù shībài zhīhòu, tuánduì chéngyuán zuò zài yìqǐ shēnkè fǎnsī gōngzuò bùzú, xīqǔ bǎoguì jīngyàn jiàoxun.', 'Sau khi trải qua thất bại dự án, các thành viên đội ngũ đã ngồi lại với nhau tự kiểm điểm sâu sắc những thiếu sót trong công việc và rút ra bài học kinh nghiệm quý giá.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1038d3c4-7e29-421c-aaae-d46841454d81'
);

-- [繁殖] (fánzhí): sinh sôi, sinh sản
UPDATE public.vocabularies
SET example_hanzi = '每年春末夏初气温回升时，许多候鸟都会飞回湿地保护区筑巢安家、繁殖后代。',
    example_pinyin = 'Měi nián chūnmò xiàchū qìwēn huíshēng shí, xǔduō hòuniǎo dōu huì fēi huí shīdì bǎohùqū zhùcháo-ānjiā, fánzhí hòudài.',
    example_vi = 'Mỗi độ cuối xuân đầu hè khi nhiệt độ ấm dần lên, nhiều loài chim di cư lại bay về khu bảo tồn đất ngập nước làm tổ sinh sôi nảy nở.'
WHERE id = 'f99f274b-5c4f-4efe-a864-ae92934958ad' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f99f274b-5c4f-4efe-a864-ae92934958ad', '每年春末夏初气温回升时，许多候鸟都会飞回湿地保护区筑巢安家、繁殖后代。', 'Měi nián chūnmò xiàchū qìwēn huíshēng shí, xǔduō hòuniǎo dōu huì fēi huí shīdì bǎohùqū zhùcháo-ānjiā, fánzhí hòudài.', 'Mỗi độ cuối xuân đầu hè khi nhiệt độ ấm dần lên, nhiều loài chim di cư lại bay về khu bảo tồn đất ngập nước làm tổ sinh sôi nảy nở.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f99f274b-5c4f-4efe-a864-ae92934958ad'
);

-- [发票] (fāpiào): hóa đơn
UPDATE public.vocabularies
SET example_hanzi = '在超市购物结账后请主动索取正式电子发票，以作为日后退换商品或依法维权的有效凭证。',
    example_pinyin = 'Zài chāoshì gòuwù jiézhàng hòu qǐng zhǔdòng suǒqǔ zhèngshì diànzǐ fāpiào, yǐ zuòwéi rìhòu tuìhuàn shāngpǐn huò yīfǎ wéiquán de yǒuxiào píngzhèng.',
    example_vi = 'Khi mua sắm thanh toán tại siêu thị xin chủ động lấy hóa đơn điện tử chính thức để làm căn cứ hợp lệ đổi trả hàng hoặc bảo vệ quyền lợi sau này.'
WHERE id = '4b5b8a22-4da3-4d46-88c7-f91087a7ee15' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4b5b8a22-4da3-4d46-88c7-f91087a7ee15', '在超市购物结账后请主动索取正式电子发票，以作为日后退换商品或依法维权的有效凭证。', 'Zài chāoshì gòuwù jiézhàng hòu qǐng zhǔdòng suǒqǔ zhèngshì diànzǐ fāpiào, yǐ zuòwéi rìhòu tuìhuàn shāngpǐn huò yīfǎ wéiquán de yǒuxiào píngzhèng.', 'Khi mua sắm thanh toán tại siêu thị xin chủ động lấy hóa đơn điện tử chính thức để làm căn cứ hợp lệ đổi trả hàng hoặc bảo vệ quyền lợi sau này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4b5b8a22-4da3-4d46-88c7-f91087a7ee15'
);

COMMIT;
