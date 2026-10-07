-- Migration for Giao tiếp Curriculum (With Examples)

DELETE FROM public.lessons WHERE hsk_level = 'Giao tiếp' AND is_system = true;

INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('66c346d5-64ef-4b09-b8f9-48bcfc3edf78', '你好', 'nǐ hǎo', 'xin chào', 'Giao tiếp', '你好，很高兴见到你！', 'Nǐ hǎo, hěn gāoxìng jiàn dào nǐ!', 'Xin chào, rất vui được gặp bạn!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f802d5d0-1a76-4a61-811b-06b2aefa4a6f', '谢谢', 'xièxie', 'cảm ơn', 'Giao tiếp', '谢谢你的帮助。', 'Xièxie nǐ de bāngzhù.', 'Cảm ơn sự giúp đỡ của bạn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f5f55a51-35a3-4eb3-bbbc-f10460f98bd5', '不客气', 'bú kèqi', 'không có chi, đừng khách sáo', 'Giao tiếp', '不用谢，不客气！', 'Bú yòng xiè, bú kèqi!', 'Không cần cảm ơn, đừng khách sáo!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3e632c84-fb6d-4c75-963b-16b9c717417e', '对不起', 'duìbuqǐ', 'xin lỗi', 'Giao tiếp', '对不起，我迟到了。', 'Duìbuqǐ, wǒ chídào le.', 'Xin lỗi, tôi đến muộn rồi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('fbfc574c-84ad-41d2-a06e-6152dac965a7', '没关系', 'méi guānxi', 'không sao đâu', 'Giao tiếp', '没关系，我也刚到。', 'Méi guānxi, wǒ yě gāng dào.', 'Không sao đâu, tôi cũng vừa mới đến.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7247c5ab-fb92-48e0-8aac-4dbab0221cd8', '再见', 'zàijiàn', 'tạm biệt', 'Giao tiếp', '明天见，再见！', 'Míngtiān jiàn, zàijiàn!', 'Mai gặp nhé, tạm biệt!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('249ed511-1c87-4641-9e64-4773907f9de6', '叫', 'jiào', 'tên là, gọi là', 'Giao tiếp', '我叫阮明英。', 'Wǒ jiào Ruǎn Míngyīng.', 'Tôi tên là Nguyễn Minh Anh.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9acbbe22-550b-41a0-ae36-9408a5e6b293', '名字', 'míngzi', 'tên', 'Giao tiếp', '你叫什么名字？', 'Nǐ jiào shénme míngzi?', 'Bạn tên là gì?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d91bdede-826a-4811-bc06-842d2413f8cd', '什么', 'shénme', 'cái gì', 'Giao tiếp', '这是什么？', 'Zhè shì shénme?', 'Đây là cái gì?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d2db3f98-d343-4fbb-95c3-a4d8faefc790', '是', 'shì', 'là, vâng, phải', 'Giao tiếp', '我是越南人。', 'Wǒ shì Yuènán rén.', 'Tôi là người Việt Nam.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('8d2c244e-7bb4-4f67-bd4b-25a73f3a1335', '哪国人', 'nǎ guó rén', 'người nước nào', 'Giao tiếp', '你是哪国人？', 'Nǐ shì nǎ guó rén?', 'Bạn là người nước nào?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('fa56ac6e-5635-4cf8-969c-0cb7de1afcf0', '认识', 'rènshi', 'quen biết, nhận biết', 'Giao tiếp', '很高兴认识你。', 'Hěn gāoxìng rènshi nǐ.', 'Rất vui được làm quen với bạn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('cecee261-9e9f-4760-ad17-48415c46f9a5', '高兴', 'gāoxìng', 'vui mừng, vui vẻ', 'Giao tiếp', '今天我很高兴。', 'Jīntiān wǒ hěn gāoxìng.', 'Hôm nay tôi rất vui.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5b93cd84-80d2-4714-aa49-7a2e588848f3', '请问', 'qǐngwèn', 'xin hỏi, làm ơn cho hỏi', 'Giao tiếp', '请问，洗手间在哪儿？', 'Qǐngwèn, xǐshǒujiān zài nǎr?', 'Xin hỏi, nhà vệ sinh ở đâu ạ?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e8aaa1a7-d908-4b6c-aacc-a2dcc01544f2', '贵姓', 'guìxìng', 'quý danh, họ (lịch sự)', 'Giao tiếp', '请问您贵姓？', 'Qǐngwèn nín guìxìng?', 'Xin hỏi quý danh của ngài là gì?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('98f69970-39d1-424e-8748-fbe9d4d501bf', '现在', 'xiànzài', 'bây giờ, hiện tại', 'Giao tiếp', '现在几点了？', 'Xiànzài jǐ diǎn le?', 'Bây giờ là mấy giờ rồi?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c15339c3-0405-4ace-89de-56647d6e90fe', '点', 'diǎn', 'giờ', 'Giao tiếp', '现在上午八点整。', 'Xiànzài shàngwǔ bā diǎn zhěng.', 'Bây giờ là tám giờ đúng buổi sáng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ff9b88f6-fdb4-4bc2-9eb5-2c721ff8ef38', '分', 'fēn', 'phút', 'Giao tiếp', '还有十分钟上课。', 'Hái yǒu shí fēnzhōng shàngkè.', 'Còn mười phút nữa vào lớp.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5b99804e-adc7-4651-b722-01148a76a293', '早上', 'zǎoshang', 'buổi sáng', 'Giao tiếp', '我早上喝一杯咖啡。', 'Wǒ zǎoshang hē yì bēi kāfēi.', 'Buổi sáng tôi uống một ly cà phê.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c787f7ab-a80b-4206-8807-91ce80a99828', '晚上', 'wǎnshang', 'buổi tối', 'Giao tiếp', '晚上你通常做什么？', 'Wǎnshang nǐ tōngcháng zuò shénme?', 'Buổi tối bạn thường làm gì?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('03fd6041-4f72-4925-9b94-c5feb9bcd590', '起床', 'qǐchuáng', 'thức dậy', 'Giao tiếp', '我每天早上六点起床。', 'Wǒ měitiān zǎoshang liù diǎn qǐchuáng.', 'Mỗi sáng tôi thức dậy lúc sáu giờ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3cc94182-35d1-41d4-b118-68d2828cb3cc', '睡觉', 'shuìjiào', 'đi ngủ', 'Giao tiếp', '早点儿睡觉吧，明天还要工作。', 'Zǎo diǎnr shuìjiào ba, míngtiān hái yào gōngzuò.', 'Đi ngủ sớm đi, mai còn phải làm việc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d6cbc4f9-5440-4946-930e-a0525a2b9128', '吃早饭', 'chī zǎofàn', 'ăn bữa sáng', 'Giao tiếp', '你吃早饭了吗？', 'Nǐ chī zǎofàn le ma?', 'Bạn ăn sáng chưa?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6125f111-d7f5-46b9-ba69-a0abfb4b24ae', '上班', 'shàngbān', 'đi làm', 'Giao tiếp', '他八点半去上班。', 'Tā bā diǎn bàn qù shàngbān.', 'Anh ấy đi làm lúc tám rưỡi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('44d15b3b-80fa-4b17-bd76-50c96a5fe79d', '下班', 'xiàbān', 'tan làm', 'Giao tiếp', '你今天几点下班？', 'Nǐ jīntiān jǐ diǎn xiàbān?', 'Hôm nay mấy giờ bạn tan làm?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a697d512-7729-4ebb-97a0-23689439aa3a', '忙', 'máng', 'bận rộn', 'Giao tiếp', '最近工作特别忙。', 'Zuìjìn gōngzuò tèbié máng.', 'Dạo này công việc đặc biệt bận rộn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0647e795-c658-4b63-84f5-6f013fd4dd67', '什么时候', 'shénme shíhou', 'khi nào, lúc nào', 'Giao tiếp', '你什么时候回家？', 'Nǐ shénme shíhou huíjiā?', 'Khi nào bạn về nhà?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('dd05f2c9-3dcb-48e6-9b1c-4f0e92f0ceb3', '每天', 'měitiān', 'mỗi ngày, hàng ngày', 'Giao tiếp', '他每天都坚持锻炼身体。', 'Tā měitiān dōu jiānchí duànliàn shēntǐ.', 'Anh ấy kiên trì tập thể dục mỗi ngày.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('caf8b565-2c93-4a5b-a83b-7df11e23de8c', '休息', 'xiūxi', 'nghỉ ngơi', 'Giao tiếp', '累了就休息一会儿吧。', 'Lèi le jiù xiūxi yíhuìr ba.', 'Mệt rồi thì nghỉ ngơi một chút đi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('623643d0-40ec-4ae6-ae9c-3d2a1a2decb8', '周末', 'zhōumò', 'cuối tuần', 'Giao tiếp', '周末你打算去哪儿玩？', 'Zhōumò nǐ dǎsuàn qù nǎr wán?', 'Cuối tuần bạn dự định đi đâu chơi?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1e096ebc-90e3-4228-baf4-31d4745169cb', '服务员', 'fúwùyuán', 'nhân viên phục vụ', 'Giao tiếp', '服务员，请给我们拿一份菜单。', 'Fúwùyuán, qǐng gěi wǒmen ná yí fèn càidān.', 'Phục vụ ơi, vui lòng cho chúng tôi một cuốn thực đơn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e80ede85-ce9e-48a7-aad2-a22c22c3691c', '菜单', 'càidān', 'thực đơn', 'Giao tiếp', '这是本店的特色菜单。', 'Zhè shì běndiàn de tèsè càidān.', 'Đây là thực đơn đặc sản của quán.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('95eb7a2b-1552-4610-8a4b-a9909df16ddb', '点菜', 'diǎncài', 'gọi món', 'Giao tiếp', '两位想点什么菜？', 'Liǎng wèi xiǎng diǎn shénme cài?', 'Hai vị muốn gọi món gì ạ?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5281545e-7936-4192-8c7e-74878d9a81bf', '喝', 'hē', 'uống', 'Giao tiếp', '你想喝热茶还是冰水？', 'Nǐ xiǎng hē rè chá háishì bīng shuǐ?', 'Bạn muốn uống trà nóng hay nước đá?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('64b8f855-5358-4039-8a5a-5a0e2d3d87bd', '水', 'shuǐ', 'nước', 'Giao tiếp', '请给我一杯温水。', 'Qǐng gěi wǒ yì bēi wēn shuǐ.', 'Làm ơn cho tôi một cốc nước ấm.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a76bcd3d-d8ed-4521-baba-6e2edc8f7589', '米饭', 'mǐfàn', 'cơm trắng', 'Giao tiếp', '我们要两碗米饭。', 'Wǒmen yào liǎng wǎn mǐfàn.', 'Chúng tôi cần hai bát cơm trắng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4417b01b-a15a-4392-88b1-ad935b1a903a', '面条', 'miàntiáo', 'mì sợi, mì', 'Giao tiếp', '这里的牛肉面条很有名。', 'Zhèlǐ de niúròu miàntiáo hěn yǒumíng.', 'Mì bò ở đây rất nổi tiếng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d58d2970-2f2f-4475-9490-188575c3bd77', '好吃', 'hǎochī', 'ngon', 'Giao tiếp', '这个菜真好吃！', 'Zhège cài zhēn hǎochī!', 'Món này thật sự rất ngon!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4af30cbc-3999-437c-b9d1-25009e5713a2', '辣', 'là', 'cay', 'Giao tiếp', '我不能吃太辣的菜。', 'Wǒ bù néng chī tài là de cài.', 'Tôi không ăn được cay nhiều.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6f726009-7913-4895-a844-fb5dcf81d083', '买单', 'mǎidān', 'thanh toán, tính tiền', 'Giao tiếp', '服务员，我们这桌买单。', 'Fúwùyuán, wǒmen zhè zhuō mǎidān.', 'Phục vụ ơi, bàn chúng tôi tính tiền.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7979e2d5-80ac-4eb8-b430-d5acc87f5709', '打包', 'dǎbāo', 'gói mang về', 'Giao tiếp', '吃不完的菜可以打包吗？', 'Chī bù wán de cài kěyǐ dǎbāo ma?', 'Đồ ăn ăn không hết có thể gói mang về không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('957a94ac-1d63-4d4f-a0d7-064d39baedbe', '一共', 'yígòng', 'tổng cộng', 'Giao tiếp', '请问一共多少钱？', 'Qǐngwèn yígòng duōshǎo qián?', 'Xin hỏi tổng cộng hết bao nhiêu tiền?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('bd02ebdd-b39e-457b-a4c7-c78418b42940', '稍等', 'shāoděng', 'chờ một lát', 'Giao tiếp', '您的菜马上来，请稍等。', 'Nín de cài mǎshàng lái, qǐng shāoděng.', 'Món ăn của quý khách sẽ ra ngay, vui lòng chờ một lát.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('47403b39-76f0-46b2-ae48-1ccdeb804e2a', '推荐', 'tuījiàn', 'giới thiệu, gợi ý', 'Giao tiếp', '能给我推荐一个招牌菜吗？', 'Néng gěi wǒ tuījiàn yí gè zhāopái cài ma?', 'Có thể gợi ý cho tôi một món ăn đặc trưng của quán không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('cc13310a-7440-4f33-b7ba-48dce60486d2', '筷子', 'kuàizi', 'đũa', 'Giao tiếp', '我的筷子掉了，能换一双吗？', 'Wǒ de kuàizi diào le, néng huàn yì shuāng ma?', 'Đũa của tôi bị rơi rồi, có thể đổi đôi khác được không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a5351723-ff3c-40c6-88c6-2709ab01a286', '买', 'mǎi', 'mua', 'Giao tiếp', '你想买什么？', 'Nǐ xiǎng mǎi shénme?', 'Bạn muốn mua cái gì?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c902851e-3110-4d84-a524-b75eded66f4c', '多少钱', 'duōshao qián', 'bao nhiêu tiền', 'Giao tiếp', '这件衣服多少钱？', 'Zhè jiàn yīfu duōshao qián?', 'Chiếc áo này bao nhiêu tiền?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a1e761c8-391f-4db3-ab47-35881cdfc887', '太...了', 'tài...le', 'quá... rồi', 'Giao tiếp', '太贵了，能不能便宜一点儿？', 'Tài guì le, néng bu néng piányi yìdiǎnr?', 'Đắt quá rồi, có thể rẻ hơn một chút được không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b8e2bf3d-639a-42ee-bb31-d240e33abbf1', '贵', 'guì', 'đắt, mắc', 'Giao tiếp', '有点儿贵，我不要了。', 'Yǒudiǎnr guì, wǒ bú yào le.', 'Hơi đắt một chút, tôi không lấy nữa đâu.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e0c696e0-56a3-4b8f-9657-574e19c5afa7', '便宜', 'piányi', 'rẻ', 'Giao tiếp', '这里的苹果很便宜。', 'Zhèlǐ de píngguǒ hěn piányi.', 'Táo ở đây rất rẻ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('aa71b89e-2ccc-4840-82b0-8114b59b8ef1', '一点儿', 'yìdiǎnr', 'một chút, một ít', 'Giao tiếp', '请便宜一点儿吧。', 'Qǐng piányi yìdiǎnr ba.', 'Bớt một chút đi mà.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('de573e4d-51ef-434f-bb18-82a305c954ca', '打折', 'dǎzhé', 'giảm giá, chiết khấu', 'Giao tiếp', '今天商场打折吗？', 'Jīntiān shāngchǎng dǎzhé ma?', 'Hôm nay trung tâm thương mại có giảm giá không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d7629a6b-03de-42fb-a147-cee1d1b7ed56', '试', 'shì', 'thử', 'Giao tiếp', '我可以试一下这双鞋吗？', 'Wǒ kěyǐ shì yíxià zhè shuāng xié ma?', 'Tôi có thể thử đôi giày này một chút không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5347cca8-b76b-4154-86df-1f4e9530f6b6', '件', 'jiàn', 'chiếc, cái (lượng từ cho áo, quần áo)', 'Giao tiếp', '我买了一件白色的衬衫。', 'Wǒ mǎile yí jiàn báisè de chènshān.', 'Tôi đã mua một chiếc áo sơ mi màu trắng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('60a8879c-87a3-4094-b8e4-5a7e5cb774ae', '颜色', 'yánsè', 'màu sắc', 'Giao tiếp', '你喜欢什么颜色？', 'Nǐ xǐhuan shénme yánsè?', 'Bạn thích màu gì?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('793f2ef4-14ab-465b-8145-48a7cc5bc064', '大', 'dà', 'to, lớn, rộng', 'Giao tiếp', '这件衣服太大了，有小一点儿的吗？', 'Zhè jiàn yīfu tài dà le, yǒu xiǎo yìdiǎnr de ma?', 'Cái áo này to quá, có cái nhỏ hơn một chút không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c279e8f9-2ac5-4ca3-b00e-95585c6e8ae1', '刷卡', 'shuākǎ', 'quẹt thẻ', 'Giao tiếp', '这里可以刷卡吗？', 'Zhèlǐ kěyǐ shuākǎ ma?', 'Ở đây có thể quẹt thẻ không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('972525ff-2051-4d68-b2a7-30bdefb71ff8', '现金', 'xiànjīn', 'tiền mặt', 'Giao tiếp', '我用现金付钱。', 'Wǒ yòng xiànjīn fùqián.', 'Tôi trả tiền bằng tiền mặt.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c7214193-ffde-49b6-b637-bd277084a1e4', '扫码', 'sǎomǎ', 'quét mã (thanh toán)', 'Giao tiếp', '请扫这里付款。', 'Qǐng sǎo zhèlǐ fùkuǎn.', 'Xin mời quét mã ở đây để thanh toán.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1c34b254-e1cc-412d-8b8e-458923ae6f50', '找钱', 'zhǎoqián', 'thối lại tiền, trả tiền thừa', 'Giao tiếp', '找您二十块钱。', 'Zhǎo nín èrshí kuài qián.', 'Thối lại bạn hai mươi tệ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('fa470c00-254e-448b-b379-af1f1f2c6f15', '在哪儿', 'zài nǎr', 'ở đâu', 'Giao tiếp', '请问，洗手间在哪儿？', 'Qǐngwèn, xǐshǒujiān zài nǎr?', 'Xin hỏi, nhà vệ sinh ở đâu vậy?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6302f452-d0e6-445b-bfec-3d42c4c4669c', '怎么走', 'zěnme zǒu', 'đi như thế nào', 'Giao tiếp', '去故宫怎么走？', 'Qù Gùgōng zěnme zǒu?', 'Đi đến Cố Cung đi như thế nào?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c28bfa16-8ea9-41f0-a12b-bb09620ded3a', '一直走', 'yìzhí zǒu', 'đi thẳng', 'Giao tiếp', '往前一直走就到了。', 'Wǎng qián yìzhí zǒu jiù dào le.', 'Đi thẳng về phía trước là tới nơi rồi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('af99b330-2f67-45be-a89a-b5cdabb49427', '往', 'wǎng', 'hướng về, quẹo về', 'Giao tiếp', '往右拐，银行就在旁边。', 'Wǎng yòu guǎi, yínháng jiù zài pángbiān.', 'Rẽ về bên phải, ngân hàng ở ngay bên cạnh.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5e45122e-9f19-4cd9-aa06-2b0107890fb2', '左拐', 'zuǒ guǎi', 'rẽ trái', 'Giao tiếp', '在红绿灯处左拐。', 'Zài hónglǜdēng chù zuǒ guǎi.', 'Rẽ trái ở chỗ đèn giao thông.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1a92026b-aac0-40de-90f4-bfb46e9207c1', '右拐', 'yòu guǎi', 'rẽ phải', 'Giao tiếp', '往前走一百米，然后右拐。', 'Wǎng qián zǒu yìbǎi mǐ, ránhòu yòu guǎi.', 'Đi thẳng một trăm mét, sau đó rẽ phải.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('20c10359-1f4a-404d-8437-bb73446255f6', '远', 'yuǎn', 'xa', 'Giao tiếp', '这里离机场很远。', 'Zhèlǐ lí jīchǎng hěn yuǎn.', 'Nơi này cách sân bay rất xa.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c7594547-4a27-48ff-b112-c99dcda5b55a', '近', 'jìn', 'gần', 'Giao tiếp', '超市离我家很近。', 'Chāoshì lí wǒ jiā hěn jìn.', 'Siêu thị cách nhà tôi rất gần.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f56a50de-ec7b-4c39-ba58-d3e8f0a28184', '地铁', 'dìtiě', 'tàu điện ngầm', 'Giao tiếp', '我们坐地铁去吧。', 'Wǒmen zuò dìtiě qù ba.', 'Chúng ta đi tàu điện ngầm nhé.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0df4c86f-6551-4ae8-8612-427dbedd6914', '公交车', 'gōngjiāochē', 'xe buýt', 'Giao tiếp', '你在哪儿坐公交车？', 'Nǐ zài nǎr zuò gōngjiāochē?', 'Bạn đón xe buýt ở đâu?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6878f9a1-6e06-48e3-a4b1-88b81690be04', '出租车', 'chūzūchē', 'xe taxi', 'Giao tiếp', '今天下雨，我们打出租车吧。', 'Jīntiān xiàyǔ, wǒmen dǎ chūzūchē ba.', 'Hôm nay trời mưa, chúng ta bắt taxi đi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('303f4414-a741-4417-a431-b7b099afb3e4', '站', 'zhàn', 'trạm, bến, nhà ga', 'Giao tiếp', '下一站是北京南站。', 'Xià yí zhàn shì Běijīng Nán Zhàn.', 'Trạm tiếp theo là ga Nam Bắc Kinh.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d145d64a-7fc9-4f43-a607-cf82ec3f0791', '换乘', 'huànchéng', 'chuyển tuyến, đổi tàu/xe', 'Giao tiếp', '请在下一站换乘二号线。', 'Qǐng zài xià yí zhàn huànchéng Èrhào Xiàn.', 'Xin vui lòng chuyển sang tuyến số 2 ở trạm tiếp theo.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f103e969-5b97-4340-85b9-14fa2de76362', '师傅', 'shīfu', 'bác tài, sư phụ (cách gọi lịch sự tài xế/thợ)', 'Giao tiếp', '师傅，我去火车站。', 'Shīfu, wǒ qù huǒchēzhàn.', 'Bác tài ơi, tôi đi ga xe lửa.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5d7e5baa-6e62-499d-8138-7e360e4fd644', '迷路', 'mílù', 'lạc đường', 'Giao tiếp', '不好意思，我迷路了。', 'Bù hǎoyìsi, wǒ mílù le.', 'Ngại quá, tôi bị lạc đường rồi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1ca637ff-d78f-4e62-9243-3958370be1da', '爱好', 'àihào', 'sở thích', 'Giao tiếp', '你的爱好是什么？', 'Nǐ de àihào shì shénme?', 'Sở thích của bạn là gì?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('196d3230-9ff2-44ed-825d-e18f1d28a1f7', '喜欢', 'xǐhuan', 'thích', 'Giao tiếp', '我很喜欢中国文化。', 'Wǒ hěn xǐhuan Zhōngguó wénhuà.', 'Tôi rất thích văn hóa Trung Quốc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3af29bc9-39f4-42f6-b804-129e58a37c0b', '看电影', 'kàn diànyǐng', 'xem phim', 'Giao tiếp', '周末你想去看电影吗？', 'Zhōumò nǐ xiǎng qù kàn diànyǐng ma?', 'Cuối tuần bạn có muốn đi xem phim không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('194eeeec-888e-4493-aa2e-a04adc234127', '听音乐', 'tīng yīnyuè', 'nghe nhạc', 'Giao tiếp', '我喜欢边做饭边听音乐。', 'Wǒ xǐhuan biān zuòfàn biān tīng yīnyuè.', 'Tôi thích vừa nấu cơm vừa nghe nhạc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c73efb4d-4a79-430c-92d2-890c01309673', '运动', 'yùndòng', 'thể thao, vận động', 'Giao tiếp', '你平时喜欢什么运动？', 'Nǐ píngshí xǐhuan shénme yùndòng?', 'Bình thường bạn thích môn thể thao nào?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f19cb816-72a7-426d-a0be-7d4d2ed6a109', '踢足球', 'tī zúqiú', 'đá bóng', 'Giao tiếp', '他踢足球踢得非常好。', 'Tā tī zúqiú tī de fēicháng hǎo.', 'Anh ấy đá bóng rất cừ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('23a6a478-3d67-49af-bd83-893ff4f88b8c', '游泳', 'yóuyǒng', 'bơi lội', 'Giao tiếp', '夏天我常常去游泳。', 'Xiàtiān wǒ chángcháng qù yóuyǒng.', 'Mùa hè tôi thường đi bơi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e2c7bde3-2aae-4170-9ef1-d652fb3ad014', '旅游', 'lǚyóu', 'du lịch', 'Giao tiếp', '我打算下个月去上海旅游。', 'Wǒ dǎsuàn xià ge yuè qù Shànghǎi lǚyóu.', 'Tôi dự định tháng sau đi Thượng Hải du lịch.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4b7d6db6-4661-4e65-86f9-72149f063365', '玩游戏', 'wán yóuxì', 'chơi trò chơi, chơi game', 'Giao tiếp', '他下班后喜欢玩游戏。', 'Tā xiàbān hòu xǐhuan wán yóuxì.', 'Sau khi tan làm anh ấy thích chơi game.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('fc095087-4943-4c83-b7db-3e374638ee83', '常', 'cháng', 'thường, hay', 'Giao tiếp', '我不常去健身房。', 'Wǒ bù cháng qù jiànshēnfáng.', 'Tôi không thường đi phòng tập gym.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('cee90c7e-d2d0-4bb1-b8ea-783fcea2a231', '周末', 'zhōumò', 'cuối tuần', 'Giao tiếp', '周末愉快！', 'Zhōumò yúkuài!', 'Cuối tuần vui vẻ nhé!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5c8f6991-4e07-45ed-a998-ebce11127c2c', '一起', 'yìqǐ', 'cùng nhau', 'Giao tiếp', '我们一起去喝咖啡吧。', 'Wǒmen yìqǐ qù hē kāfēi ba.', 'Chúng mình cùng đi uống cà phê đi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2b630738-a688-4d44-9d06-42222b8cf610', '有空', 'yǒu kòng', 'rảnh rỗi, có thời gian rảnh', 'Giao tiếp', '明天晚上你有空吗？', 'Míngtiān wǎnshang nǐ yǒu kòng ma?', 'Tối mai bạn có rảnh không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('fd7f45b9-4b1c-41a7-8955-416e7d835bce', '聊天', 'liáotiān', 'trò chuyện, tán gẫu', 'Giao tiếp', '我们一边喝茶一边聊天。', 'Wǒmen yìbiān hē chá yìbiān liáotiān.', 'Chúng tôi vừa uống trà vừa tán gẫu.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b59e1c9b-3bf1-4cfb-831e-a973b1265606', '拍照', 'pāizhào', 'chụp ảnh', 'Giao tiếp', '你能帮我们拍张照吗？', 'Nǐ néng bāng wǒmen pāi zhāng zhào ma?', 'Bạn có thể chụp giúp chúng tôi một bức ảnh không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('789244b2-412a-4480-9b53-44c9254b5529', '天气', 'tiānqì', 'thời tiết', 'Giao tiếp', '今天天气很好。', 'Jīntiān tiānqì hěn hǎo.', 'Hôm nay thời tiết rất đẹp.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0a5d38d9-7891-4e0d-8eb7-f68b7afc6047', '怎么样', 'zěnmeyàng', 'như thế nào, ra sao', 'Giao tiếp', '明天天气怎么样？', 'Míngtiān tiānqì zěnmeyàng?', 'Thời tiết ngày mai thế nào?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4c99f8d5-0de5-43d4-9868-f1b94868d8fd', '热', 'rè', 'nóng', 'Giao tiếp', '今天太热了，我想喝冰水。', 'Jīntiān tài rè le, wǒ xiǎng hē bīngshuǐ.', 'Hôm nay nóng quá, tôi muốn uống nước đá.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e512fe06-53c4-4ef8-9c08-9cf8a65eedb6', '冷', 'lěng', 'lạnh', 'Giao tiếp', '外边很冷，多穿点衣服吧。', 'Wàibian hěn lěng, duō chuān diǎn yīfu ba.', 'Bên ngoài rất lạnh, mặc thêm áo vào nhé.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a7c49bcd-1ba4-4643-a5de-e038f31dec46', '下雨', 'xià yǔ', 'mưa, trời mưa', 'Giao tiếp', '出门记得带伞，要下雨了。', 'Chūmén jìde dài sǎn, yào xià yǔ le.', 'Ra ngoài nhớ mang ô, sắp mưa rồi đấy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7e703bc8-8718-48e2-abc9-ebb8d3fb497f', '晴天', 'qíngtiān', 'ngày nắng, trời nắng', 'Giao tiếp', '周末是晴天，我们去公园吧。', 'Zhōumò shì qíngtiān, wǒmen qù gōngyuán ba.', 'Cuối tuần trời nắng, chúng mình đi công viên nhé.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('cf3bfaa9-a835-4151-88d5-6f992b306f54', '阴天', 'yīntiān', 'trời râm, u ám', 'Giao tiếp', '今天一直是阴天，没有太阳。', 'Jīntiān yìzhí shì yīntiān, méiyǒu tàiyáng.', 'Hôm nay trời suốt ngày râm mát, không có mặt trời.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e9e24b34-44a5-4005-a5e5-ad76f9863aa3', '刮风', 'guā fēng', 'nổi gió, có gió', 'Giao tiếp', '外面刮风了，把窗户关上吧。', 'Wàimiàn guā fēng le, bǎ chuānghu guānshang ba.', 'Bên ngoài nổi gió rồi, đóng cửa sổ lại đi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4568f2ba-4faa-498f-88dd-a6a4b50311eb', '下雪', 'xià xuě', 'tuyết rơi', 'Giao tiếp', '北京冬天经常下雪吗？', 'Běijīng dōngtiān jīngcháng xià xuě ma?', 'Mùa đông ở Bắc Kinh có thường có tuyết rơi không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a663c64a-2516-4978-9b43-369effe92843', '温度', 'wēndù', 'nhiệt độ', 'Giao tiếp', '今天的最高温度是三十度。', 'Jīntiān de zuìgāo wēndù shì sānshí dù.', 'Nhiệt độ cao nhất hôm nay là 30 độ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ae700441-0412-4708-98b4-e33dbe31ee34', '预报', 'yùbào', 'dự báo', 'Giao tiếp', '天气预报说下午有大雨。', 'Tiānqì yùbào shuō xiàwǔ yǒu dàyǔ.', 'Dự báo thời tiết nói chiều nay có mưa to.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b666e149-586d-4a1e-bd49-84aace2ac7da', '春天', 'chūntiān', 'mùa xuân', 'Giao tiếp', '这里的春天非常暖和。', 'Zhèlǐ de chūntiān fēicháng nuǎnhuo.', 'Mùa xuân ở đây vô cùng ấm áp.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a7219a49-a3d5-4f89-a9d2-2d475d78a186', '夏天', 'xiàtiān', 'mùa hè', 'Giao tiếp', '我不喜欢夏天，因为太热了。', 'Wǒ bù xǐhuan xiàtiān, yīnwèi tài rè le.', 'Tôi không thích mùa hè vì trời quá nóng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('930bc9db-b7d6-47b1-be15-d59bc1efe9d0', '秋天', 'qiūtiān', 'mùa thu', 'Giao tiếp', '秋天是旅游最好的季节。', 'Qiūtiān shì lǚyóu zuì hǎo de jìjié.', 'Mùa thu là mùa tuyệt vời nhất để đi du lịch.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('09492e3c-0b20-4404-a6ed-454a2d460967', '冬天', 'dōngtiān', 'mùa đông', 'Giao tiếp', '河内的冬天也很冷。', 'Hénèi de dōngtiān yě hěn lěng.', 'Mùa đông ở Hà Nội cũng rất lạnh.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2f7a4f68-9639-4242-879a-75920902640a', '舒服', 'shūfu', 'dễ chịu, thoải mái, khỏe mạnh', 'Giao tiếp', '我今天身体有点儿不舒服。', 'Wǒ jīntiān shēntǐ yǒudiǎnr bù shūfu.', 'Hôm nay người tôi hơi khó chịu trong người.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('604bd831-9bb9-439f-9a17-3bd13a9cbe2f', '感冒', 'gǎnmào', 'cảm cúm', 'Giao tiếp', '我可能感冒了，一直流鼻涕。', 'Wǒ kěnéng gǎnmào le, yìzhí liú bítì.', 'Có lẽ tôi bị cảm cúm rồi, cứ sổ mũi suốt.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('89273e97-02cb-439b-aa56-de5902748005', '发烧', 'fāshāo', 'phát sốt, sốt', 'Giao tiếp', '他发烧三十八度五，得去医院。', 'Tā fāshāo sānshíbā dù wǔ, děi qù yīyuàn.', 'Anh ấy sốt 38 độ 5, phải đi bệnh viện thôi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c9416558-1b64-4a27-be8f-624e3dd2f053', '头疼', 'tóuténg', 'đau đầu', 'Giao tiếp', '我昨晚没睡好，现在头很疼。', 'Wǒ zuówǎn méi shuì hǎo, xiànzài tóu hěn téng.', 'Tối qua tôi ngủ không ngon, giờ đầu đau lắm.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3499d439-d11d-479e-a7af-d96471201cea', '咳嗽', 'késou', 'ho', 'Giao tiếp', '你咳嗽好几天了，去看医生吧。', 'Nǐ késou hǎo jǐ tiān le, qù kàn yīshēng ba.', 'Bạn ho mấy ngày nay rồi, đi khám bác sĩ đi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('44966a19-a4b4-4a2e-a57e-a44bc839dd5b', '肚子疼', 'dùzi téng', 'đau bụng', 'Giao tiếp', '我吃了海鲜以后肚子很疼。', 'Wǒ chī le hǎixiān yǐhòu dùzi hěn téng.', 'Sau khi ăn hải sản tôi bị đau bụng dữ dội.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2ee6f6e3-6fbc-4347-9dcf-ef5fc8a1724f', '医院', 'yīyuàn', 'bệnh viện', 'Giao tiếp', '离这里最近的医院在哪儿？', 'Lí zhèlǐ zuì jìn de yīyuàn zài nǎr?', 'Bệnh viện gần đây nhất ở đâu vậy?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b8977158-a96e-4fd8-b92c-4ad71f95680a', '医生', 'yīshēng', 'bác sĩ', 'Giao tiếp', '医生说我只是普通的感冒。', 'Yīshēng shuō wǒ zhǐshì pǔtōng de gǎnmào.', 'Bác sĩ bảo tôi chỉ bị cảm cúm thông thường thôi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('017f0f50-7177-4c8b-a277-e09dab7032f8', '检查', 'jiǎnchá', 'kiểm tra, khám', 'Giao tiếp', '请坐下，我给你检查一下。', 'Qǐng zuòxià, wǒ gěi nǐ jiǎnchá yíxià.', 'Xin mời ngồi xuống, tôi khám cho bạn một chút.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('23e57b83-2ced-48ad-88b7-4798fcfab4c1', '药', 'yào', 'thuốc', 'Giao tiếp', '这个药一天吃三次，饭后吃。', 'Zhège yào yì tiān chī sān cì, fànhòu chī.', 'Thuốc này ngày uống ba lần, uống sau bữa ăn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5bde70aa-bf91-49bf-8c68-404f505acc65', '打针', 'dǎzhēn', 'tiêm, chích thuốc', 'Giao tiếp', '病情有点严重，你需要打针。', 'Bìngqíng yǒudiǎnr yánzhòng, nǐ xūyào dǎzhēn.', 'Tình hình hơi nghiêm trọng một chút, bạn cần phải tiêm.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('fe3e9174-95b9-4c33-af8c-fa6bc1d64324', '休息', 'xiūxi', 'nghỉ ngơi', 'Giao tiếp', '多喝热水，好好休息几天。', 'Duō hē rèshuǐ, hǎohǎo xiūxi jǐ tiān.', 'Uống nhiều nước ấm và nghỉ ngơi thật tốt vài ngày nhé.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d2533064-f299-426b-93c0-6414f26f6fba', '请假', 'qǐngjià', 'xin nghỉ phép', 'Giao tiếp', '我今天生病了，想请假一天。', 'Wǒ jīntiān shēngbìng le, xiǎng qǐngjià yì tiān.', 'Hôm nay tôi bị ốm, muốn xin nghỉ phép một ngày.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('72ed4c2e-eda7-4317-8a90-9996a2653b76', '嗓子', 'sǎngzi', 'cổ họng, họng', 'Giao tiếp', '我嗓子疼，说不出话来。', 'Wǒ sǎngzi téng, shuō buchū huà lái.', 'Cổ họng tôi bị đau, không nói nên lời.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('94fdcab9-954e-4711-9eb9-2aaa6ca91060', '严重', 'yánzhòng', 'nghiêm trọng, nặng', 'Giao tiếp', '别担心，你的病不严重。', 'Bié dānxīn, nǐ de bìng bù yánzhòng.', 'Đừng lo lắng, bệnh của bạn không nghiêm trọng đâu.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a997bcd9-1a00-488d-a0c6-a82899cef1dd', '旅游', 'lǚyóu', 'du lịch', 'Giao tiếp', '我想下个月去中国旅游。', 'Wǒ xiǎng xià ge yuè qù Zhōngguó lǚyóu.', 'Tôi muốn tháng sau đi du lịch Trung Quốc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2377383e-162c-43f4-8cb5-236f81fb562a', '预订', 'yùdìng', 'đặt trước', 'Giao tiếp', '我在网上预订了一个房间。', 'Wǒ zài wǎngshang yùdìng le yí ge fángjiān.', 'Tôi đã đặt trước một phòng ở trên mạng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1ad3d02d-a9f2-4d95-801f-7fc6f1ae0134', '酒店', 'jiǔdiàn', 'khách sạn', 'Giao tiếp', '这家酒店离海边很近。', 'Zhè jiā jiǔdiàn lí hǎibiān hěn jìn.', 'Khách sạn này cách bờ biển rất gần.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6e70c567-4b6a-49bb-aa44-e40463093a43', '单人间', 'dānrénjiān', 'phòng đơn', 'Giao tiếp', '请问还有单人间吗？', 'Qǐngwèn hái yǒu dānrénjiān ma?', 'Xin hỏi còn phòng đơn không ạ?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f2797097-48ec-414c-8c1e-7a7c3037e8db', '标准间', 'biāozhǔnjiān', 'phòng đôi tiêu chuẩn (hai giường đơn)', 'Giao tiếp', '我们要住两晚标准间。', 'Wǒmen yào zhù liǎng wǎn biāozhǔnjiān.', 'Chúng tôi muốn ở hai đêm phòng tiêu chuẩn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('37f00a1b-1f0e-40e5-8ec7-935124649d8a', '入住', 'rùzhù', 'nhận phòng, check-in', 'Giao tiếp', '您好，我来办理入住手续。', 'Nínhǎo, wǒ lái bànlǐ rùzhù shǒuxù.', 'Xin chào, tôi đến làm thủ tục nhận phòng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3f2257ed-a44b-4970-8cc9-982e4fc34773', '退房', 'tuìfáng', 'trả phòng, check-out', 'Giao tiếp', '请问最晚几点退房？', 'Qǐngwèn zuì wǎn jǐ diǎn tuìfáng?', 'Xin hỏi muộn nhất là mấy giờ trả phòng?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e66ed50a-9a7d-42dc-8407-1816a9b8ff1f', '护照', 'hùzhào', 'hộ chiếu', 'Giao tiếp', '办理登记需要出示您的护照。', 'Bànlǐ dēngjì xūyào chūshì nín de hùzhào.', 'Làm thủ tục đăng ký cần xuất trình hộ chiếu của bạn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('66eb4de8-31d0-4fe8-87cd-54528ae60bf2', '房卡', 'fángkǎ', 'thẻ phòng', 'Giao tiếp', '这是您的房卡，在六楼608房。', 'Zhè shì nín de fángkǎ, zài liù lóu liù-líng-bā fáng.', 'Đây là thẻ phòng của bạn, ở phòng 608 trên tầng 6.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e3f72cf9-a389-4f59-b0b1-18a17919090c', '押金', 'yājīn', 'tiền đặt cọc', 'Giao tiếp', '入住需要交两百块押金。', 'Rùzhù xūyào jiāo liǎngbǎi kuài yājīn.', 'Nhận phòng cần nộp hai trăm tệ tiền cọc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0ceb5cc5-4937-4fd2-a0b2-080801ab848a', '行李', 'xíngli', 'hành lý', 'Giao tiếp', '可以帮我拿一下行李吗？', 'Kěyǐ bāng wǒ ná yíxià xíngli ma?', 'Có thể giúp tôi xách hành lý một chút được không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('49457134-1806-40a4-b738-a48587f5d4a4', '免费', 'miǎnfèi', 'miễn phí', 'Giao tiếp', '房间里的矿泉水是免费的。', 'Fángjiān lǐ de kuàngquánshuǐ shì miǎnfèi de.', 'Nước khoáng trong phòng là miễn phí.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('822eda65-f834-47b9-a21c-9e7205d795e9', '无线网', 'wúxiànwǎng', 'mạng không dây, Wi-Fi', 'Giao tiếp', '请问无线网的密码是多少？', 'Qǐngwèn wúxiànwǎng de mìmǎ shì duōshǎo?', 'Xin hỏi mật khẩu Wi-Fi là bao nhiêu?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d47bfbca-03dd-4f09-9f2f-c07847e789a9', '含', 'hán', 'bao gồm', 'Giao tiếp', '房费含早餐吗？', 'Fángfèi hán zǎocān ma?', 'Giá phòng có bao gồm bữa sáng không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2aab0f65-988f-42ba-9925-3c10a0887702', '风景', 'fēngjǐng', 'phong cảnh', 'Giao tiếp', '窗外的风景真漂亮！', 'Chuāngwài de fēngjǐng zhēn piàoliang!', 'Phong cảnh bên ngoài cửa sổ thật là đẹp!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('72caa89e-1bd1-40ce-be56-f4d99e9db9e5', '喂', 'wèi', 'a-lô', 'Giao tiếp', '喂，请问张经理在吗？', 'Wèi, qǐngwèn Zhāng jīnglǐ zài ma?', 'A-lô, cho hỏi giám đốc Trương có ở đó không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5a83ab4e-51b6-4161-9917-da5966b711ee', '打电话', 'dǎ diànhuà', 'gọi điện thoại', 'Giao tiếp', '我晚上给你打电话。', 'Wǒ wǎnshang gěi nǐ dǎ diànhuà.', 'Tối nay tôi sẽ gọi điện thoại cho bạn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0fde1b54-817d-4965-8e91-e092b817bccc', '接电话', 'jiē diànhuà', 'nghe điện thoại / bắt máy', 'Giao tiếp', '他在开会，不能接电话。', 'Tā zài kāihuì, bù néng jiē diànhuà.', 'Anh ấy đang họp, không thể nghe điện thoại.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0f762d4e-7082-4bd2-a712-50ee186af9a3', '发信息', 'fā xìnxī', 'gửi tin nhắn', 'Giao tiếp', '有什么事就给我发信息吧。', 'Yǒu shénme shì jiù gěi wǒ fā xìnxī ba.', 'Có việc gì thì cứ gửi tin nhắn cho tôi nhé.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('49dd9ca5-5cd9-413f-9e42-67fc8a50e065', '留言', 'liúyán', 'để lại lời nhắn', 'Giao tiếp', '您可以给他留言，他回来后会联系您。', 'Nín kěyǐ gěi tā liúyán, tā huílái hòu huì liánxì nín.', 'Ngài có thể để lại lời nhắn, sau khi về anh ấy sẽ liên lạc lại.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('14cccc9e-4321-4f73-a9a2-ac21ed0cd07c', '约会', 'yuēhuì', 'cuộc hẹn / hẹn gặp', 'Giao tiếp', '我今天下午有一个重要的约会。', 'Wǒ jīntiān xiàwǔ yǒu yí gè zhòngyào de yuēhuì.', 'Chiều nay tôi có một cuộc hẹn quan trọng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d454a336-b68d-4c23-af61-3c073c4d933b', '有空', 'yǒu kòng', 'rảnh rỗi / có thời gian rảnh', 'Giao tiếp', '你周末有空吗？我们一起去喝咖啡。', 'Nǐ zhōumò yǒu kòng ma? Wǒmen yìqǐ qù hē kāfēi.', 'Cuối tuần này bạn có rảnh không? Chúng mình cùng đi uống cà phê.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('34a5b1a0-3231-4d6e-92c0-d73013ff11c1', '见面', 'jiànmiàn', 'gặp mặt', 'Giao tiếp', '我们在学校门口见面吧。', 'Wǒmen zài xuéxiào ménkǒu jiànmiàn ba.', 'Chúng ta gặp nhau ở cổng trường nhé.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b646f7dc-1883-455a-8498-dcd6ccceca3a', '改天', 'gǎitiān', 'hôm khác / bữa khác', 'Giao tiếp', '今天太忙了，我们改天再聊吧。', 'Jīntiān tài máng le, wǒmen gǎitiān zài liáo ba.', 'Hôm nay bận quá, chúng ta để hôm khác nói chuyện tiếp nhé.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('8b3add25-10e5-452e-90bb-367ba694d71e', '推迟', 'tuīchí', 'hoãn lại / dời lại', 'Giao tiếp', '会议推迟到明天上午了。', 'Huìyì tuīchí dào míngtiān shàngwǔ le.', 'Cuộc họp đã được hoãn sang sáng mai rồi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('62264893-cdff-45d5-a31c-565b45e87b7f', '准时', 'zhǔnshí', 'đúng giờ', 'Giao tiếp', '请大家明天准时到达。', 'Qǐng dàjiā míngtiān zhǔnshí dàodá.', 'Xin mời mọi người ngày mai đến đúng giờ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7e4746a3-02d9-419c-90a0-90223d0cc2b0', '占线', 'zhànxiàn', 'máy bận', 'Giao tiếp', '我打了几次，他的电话一直占线。', 'Wǒ dǎ le jǐ cì, tā de diànhuà yìzhí zhànxiàn.', 'Tôi gọi mấy lần mà máy của anh ấy cứ bận suốt.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f4b381af-109b-4495-b15d-14237f5bc1dc', '挂断', 'guàduàn', 'cúp máy', 'Giao tiếp', '先别挂断，我还有一句话要说。', 'Xiān bié guàduàn, wǒ hái yǒu yí jù huà yào shuō.', 'Đừng cúp máy vội, tôi còn một câu muốn nói.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5582c641-4e30-412e-9b4b-6477ba620624', '信号', 'xìnhào', 'tín hiệu / sóng điện thoại', 'Giao tiếp', '这里的信号不太好，听不清楚。', 'Zhèlǐ de xìnhào bú tài hǎo, tīng bù qīngchu.', 'Sóng ở đây không tốt lắm, nghe không rõ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f8157f82-1d57-407d-aabe-bb7bf6390973', '不见不散', 'bú jiàn bú sàn', 'không gặp không về', 'Giao tiếp', '明天晚上七点老地方，不见不散！', 'Míngtiān wǎnshang qī diǎn lǎo dìfang, bú jiàn bú sàn!', 'Tối mai 7 giờ chỗ cũ, không gặp không về nhé!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f5957431-f015-4985-b81b-87726faef989', '租房', 'zū fáng', 'thuê nhà / thuê phòng', 'Giao tiếp', '我想在公司附近租房。', 'Wǒ xiǎng zài gōngsī fùjìn zū fáng.', 'Tôi muốn thuê phòng ở gần công ty.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4fcb424c-7795-4a4f-aa54-81b30301703e', '房东', 'fángdōng', 'chủ nhà', 'Giao tiếp', '房东人很好，很热情。', 'Fángdōng rén hěn hǎo, hěn rèqíng.', 'Chủ nhà tính rất tốt và nhiệt tình.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0cde6036-ebc9-4ae6-898e-6ab08af1616e', '房租', 'fángzū', 'tiền thuê nhà', 'Giao tiếp', '这里的房租每个月两千块。', 'Zhèlǐ de fángzū měi gè yuè liǎng qiān kuài.', 'Tiền thuê nhà ở đây mỗi tháng là hai nghìn tệ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0b87ab90-322d-4e14-ad01-47d66fd4ba04', '押金', 'yājīn', 'tiền đặt cọc', 'Giao tiếp', '租房通常需要交一个月的押金。', 'Zū fáng tōngcháng xūyào jiāo yí gè yuè de yājīn.', 'Thuê nhà thường phải nộp tiền đặt cọc một tháng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c1b904fd-7892-46b7-90e7-1c57c87ed7ed', '合同', 'hétong', 'hợp đồng', 'Giao tiếp', '请你在签合同前仔细看一遍。', 'Qǐng nǐ zài qiān hétong qián zǐxì kàn yí biàn.', 'Xin hãy đọc kỹ một lượt trước khi ký hợp đồng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4d5bb90e-4ad6-4211-826e-4d350b690f2b', '搬家', 'bānjiā', 'chuyển nhà', 'Giao tiếp', '我下个周末打算搬家。', 'Wǒ xià gè zhōumò dǎsuàn bānjiā.', 'Cuối tuần sau tôi dự định chuyển nhà.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('726242e9-ae0f-4df4-a276-c1f578dcb94e', '家具', 'jiājù', 'đồ nội thất', 'Giao tiếp', '房间里有家具吗？', 'Fángjiān lǐ yǒu jiājù ma?', 'Trong phòng có sẵn đồ nội thất không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('cc473949-15ba-4ea2-8a02-825a5a3db62e', '水电费', 'shuǐdiànfèi', 'tiền điện nước', 'Giao tiếp', '房租包含水电费吗？', 'Fángzū bāohán shuǐdiànfèi ma?', 'Tiền nhà đã bao gồm tiền điện nước chưa?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('84d13d8e-5b63-4171-8365-02564472b838', '空调', 'kōngtiáo', 'máy điều hòa', 'Giao tiếp', '夏天太热了，房间需要开空调。', 'Xiàtiān tài rè le, fángjiān xūyào kāi kōngtiáo.', 'Mùa hè nóng quá, trong phòng phải bật điều hòa.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5688c823-3741-4707-9d06-a9521b0cefb3', '洗衣机', 'xǐyījī', 'máy giặt', 'Giao tiếp', '这台洗衣机怎么用？', 'Zhè tái xǐyījī zěnme yòng?', 'Cái máy giặt này sử dụng như thế nào?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('bc0d5ef0-ed50-4dc5-bf8b-0d3dc5aeff7d', '厨房', 'chúfáng', 'nhà bếp', 'Giao tiếp', '厨房里可以做饭吗？', 'Chúfáng lǐ kěyǐ zuòfàn ma?', 'Trong bếp có được nấu cơm không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('97d20393-889b-4c69-b8c6-5f65c2857524', '卫生间', 'wèishēngjiān', 'nhà vệ sinh / phòng tắm', 'Giao tiếp', '这个房间有独立的卫生间。', 'Zhège fángjiān yǒu dúlì de wèishēngjiān.', 'Căn phòng này có nhà vệ sinh riêng khép kín.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('51e84b4a-d2ee-497a-8f9c-d29b79613fce', '阳台', 'yángtái', 'ban công', 'Giao tiếp', '衣服可以晒在阳台上。', 'Yīfu kěyǐ shài zài yángtái shang.', 'Quần áo có thể phơi ngoài ban công.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a721ff1a-6a62-4abb-aa5f-bef99893c08e', '邻居', 'línjū', 'hàng xóm', 'Giao tiếp', '我的邻居都很安静、友好。', 'Wǒ de línjū dōu hěn ānjìng, yǒuhǎo.', 'Hàng xóm của tôi đều rất yên tĩnh và thân thiện.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('bbb1537a-9080-4d9b-8871-e6ed0091be11', '满意', 'mǎnyì', 'hài lòng', 'Giao tiếp', '我对这个房子的环境很满意。', 'Wǒ duì zhège fángzi de huánjìng hěn mǎnyì.', 'Tôi rất hài lòng với môi trường sống của căn nhà này.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2bdd2e05-e952-4b23-a62f-8a21e807c4c0', '上班', 'shàngbān', 'đi làm', 'Giao tiếp', '你每天几点上班？', 'Nǐ měitiān jǐ diǎn shàngbān?', 'Mỗi ngày mấy giờ bạn đi làm?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3665a127-fd94-4d90-985f-fb19e52f0cdb', '下班', 'xiàbān', 'tan làm', 'Giao tiếp', '下班后我们去吃火锅吧。', 'Xiàbān hòu wǒmen qù chī huǒguō ba.', 'Tan làm xong chúng ta đi ăn lẩu đi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('852931f1-07ab-4c52-839f-495b847a1aee', '加班', 'jiābān', 'tăng ca / làm thêm giờ', 'Giao tiếp', '今天事情太多了，我必须加班。', 'Jīntiān shìqing tài duō le, wǒ bìxū jiābān.', 'Hôm nay nhiều việc quá, tôi buộc phải tăng ca.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('771647aa-fb7b-4601-80f1-06b75b39c7eb', '同事', 'tóngshì', 'đồng nghiệp', 'Giao tiếp', '大家都是同事，应该互相帮助。', 'Dàjiā dōu shì tóngshì, yīnggāi hùxiāng bāngzhù.', 'Mọi người đều là đồng nghiệp, nên giúp đỡ lẫn nhau.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('655161d7-ec36-4e63-862d-934956b82e00', '领导', 'lǐngdǎo', 'lãnh đạo / sếp', 'Giao tiếp', '领导同意了这个方案。', 'Lǐngdǎo tóngyì le zhège fāng''àn.', 'Lãnh đạo đã đồng ý phương án này rồi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ae40ae80-e798-45c4-a0b0-0c1f777bae9b', '开会', 'kāihuì', 'họp / mở cuộc họp', 'Giao tiếp', '我们上午十点要开会讨论新计划。', 'Wǒmen shàngwǔ shí diǎn yào kāihuì tǎolùn xīn jìhuà.', '10 giờ sáng chúng tôi phải họp thảo luận kế hoạch mới.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7123ffda-2ecf-4a8c-a6c1-084056ae507e', '请假', 'qǐngjià', 'xin nghỉ phép', 'Giao tiếp', '我身体不舒服，想请一天假。', 'Wǒ shēntǐ bù shūfu, xiǎng qǐng yì tiān jià.', 'Người tôi không khỏe, muốn xin nghỉ một ngày.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('041964b2-9703-4614-9cb2-e2c00503b1a6', '迟到', 'chídào', 'đến muộn / đi trễ', 'Giao tiếp', '因为堵车，他今天迟到了十分钟。', 'Yīnwèi dǔchē, tā jīntiān chídào le shí fēnzhōng.', 'Vì tắc đường nên hôm nay anh ấy đi muộn mười phút.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7e72e4b2-4086-476e-9f59-939926e4010b', '任务', 'rènwu', 'nhiệm vụ', 'Giao tiếp', '这项任务必须在本周内完成。', 'Zhè xiàng rènwu bìxū zài běn zhōu nèi wánchéng.', 'Nhiệm vụ này bắt buộc phải hoàn thành trong tuần này.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e2ffd562-ceda-4fa3-a47b-97d9fd30df44', '项目', 'xiàngmù', 'dự án', 'Giao tiếp', '我们的项目进行得很顺利。', 'Wǒmen de xiàngmù jìnxíng de hěn shùnlì.', 'Dự án của chúng tôi đang tiến triển rất thuận lợi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d733907c-4ba4-4ec2-83b1-27de91710696', '报告', 'bàogào', 'báo cáo', 'Giao tiếp', '我已经把报告发到您的邮箱了。', 'Wǒ yǐjīng bǎ bàogào fā dào nín de yóuxiāng le.', 'Tôi đã gửi báo cáo vào hòm thư của ngài rồi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c65ab344-95f1-4779-aadc-aa1d67903f5f', '邮件', 'yóujiàn', 'thư điện tử / email', 'Giao tiếp', '请查收我刚才发的邮件。', 'Qǐng cháchōu wǒ gāngcái fā de yóujiàn.', 'Vui lòng kiểm tra email tôi vừa mới gửi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('19b7fe9d-21b0-42a3-b172-46500e571a6c', '出差', 'chūchāi', 'đi công tác', 'Giao tiếp', '他下星期要出差去上海。', 'Tā xià xīngqī yào chūchāi qù Shànghǎi.', 'Tuần sau anh ấy phải đi công tác ở Thượng Hải.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b111957f-dade-4e32-8e64-bf296dae8422', '工资', 'gōngzī', 'tiền lương', 'Giao tiếp', '每个月十号发工资。', 'Měi gè yuè shí hào fā gōngzī.', 'Ngày 10 hàng tháng là phát lương.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9bab000a-a59d-421a-a42e-caaca0624945', '合作', 'hézuò', 'hợp tác', 'Giao tiếp', '非常高兴能与贵公司合作。', 'Fēicháng gāoxìng néng yǔ guì gōngsī hézuò.', 'Rất vui khi được hợp tác với quý công ty.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('81173a04-67a8-40b3-b3e8-5f63ac9328ea', '家人', 'jiārén', 'người nhà, gia đình', 'Giao tiếp', '周末我通常和家人在一起。', 'Zhōumò wǒ tōngcháng hé jiārén zài yìqǐ.', 'Cuối tuần tôi thường ở bên người nhà.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('08f18bac-d1e3-4c01-9cd2-6d042223faf3', '父母', 'fùmǔ', 'bố mẹ, cha mẹ', 'Giao tiếp', '我的父母身体都很好。', 'Wǒ de fùmǔ shēntǐ dōu hěn hǎo.', 'Bố mẹ tôi sức khỏe đều rất tốt.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4b841e3d-417c-482e-b64c-c1b5945a97f2', '父亲', 'fùqīn', 'cha, bố', 'Giao tiếp', '我父亲是一名工程师。', 'Wǒ fùqīn shì yì míng gōngchéngshī.', 'Bố tôi là một kỹ sư.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3ff2a543-3cbd-4a20-aa35-d1a0b4ec7503', '母亲', 'mǔqīn', 'mẹ', 'Giao tiếp', '母亲做的菜总是最好吃的。', 'Mǔqīn zuò de cài zǒngshì zuì hǎochī de.', 'Món ăn mẹ nấu luôn là ngon nhất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('40aa6c83-17d2-4363-90f7-8b086c71e8c9', '兄弟姐妹', 'xiōngdì jiěmèi', 'anh chị em', 'Giao tiếp', '你有兄弟姐妹吗？', 'Nǐ yǒu xiōngdì jiěmèi ma?', 'Bạn có anh chị em không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('55a0218b-b756-460e-a0ce-c8aee5d0afa9', '丈夫', 'zhàngfu', 'chồng', 'Giao tiếp', '她丈夫在一家外企工作。', 'Tā zhàngfu zài yì jiā wàiqǐ gōngzuò.', 'Chồng cô ấy làm việc ở một doanh nghiệp nước ngoài.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1cd5333a-49b7-4859-8545-7bc966e1f2c7', '妻子', 'qīzi', 'vợ', 'Giao tiếp', '我和妻子结婚五年了。', 'Wǒ hé qīzi jiéhūn wǔ nián le.', 'Tôi và vợ đã kết hôn được 5 năm.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3950eda3-e014-4011-8b78-de0a1eef716e', '孩子', 'háizi', 'con cái, đứa trẻ', 'Giao tiếp', '他们有两个孩子，一男一女。', 'Tāmen yǒu liǎng gè háizi, yì nán yì nǚ.', 'Họ có hai đứa con, một trai một gái.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('60a39e91-ed54-4edd-8a06-b4aebbfe6c53', '爷爷', 'yéye', 'ông nội', 'Giao tiếp', '爷爷每天早上都去公园散步。', 'Yéye měitiān zǎoshang dōu qù gōngyuán sànbù.', 'Ông nội mỗi sáng đều đi công viên dạo bộ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('85736b2b-cb59-4ccc-adc3-d17f482dac93', '奶奶', 'nǎinai', 'bà nội', 'Giao tiếp', '奶奶很喜欢讲小时候的故事。', 'Nǎinai hěn xǐhuan jiǎng xiǎoshíhòu de gùshì.', 'Bà nội rất thích kể chuyện thời thơ ấu.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9bb1a5e1-5465-42d2-b200-a8f780805f66', '结婚', 'jiéhūn', 'kết hôn, lấy vợ/chồng', 'Giao tiếp', '下个月我哥哥要结婚了。', 'Xià gè yuè wǒ gēge yào jiéhūn le.', 'Tháng sau anh trai tôi sẽ kết hôn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2251d5ad-a552-499a-8350-706285ce95ee', '亲戚', 'qīnqi', 'họ hàng, bà con', 'Giao tiếp', '过年的时候我们会去走亲戚。', 'Guònián de shíhou wǒmen huì qù zǒu qīnqi.', 'Lúc Tết chúng tôi sẽ đi chúc Tết họ hàng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a81e4870-4ef2-454c-ba71-8d10a87e6dee', '独生子', 'dúshēngzǐ', 'con trai một', 'Giao tiếp', '我是家里的独生子。', 'Wǒ shì jiālǐ de dúshēngzǐ.', 'Tôi là con trai một trong nhà.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9a52ba1f-2600-4e40-bc2b-7184ce59ee8e', '照顾', 'zhàogù', 'chăm sóc', 'Giao tiếp', '下班后他要回家照顾孩子。', 'Xiàbān hòu tā yào huíjiā zhàogù háizi.', 'Tan làm anh ấy phải về nhà chăm sóc con cái.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('831cc9da-bd03-41a1-8a58-74cb368bac89', '幸福', 'xìngfú', 'hạnh phúc', 'Giao tiếp', '祝你们全家生活幸福！', 'Zhù nǐmen quánjiā shēnghuó xìngfú!', 'Chúc cả gia đình bạn cuộc sống hạnh phúc!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3da303d6-9988-45a5-a79d-f7645925878e', '银行', 'yínháng', 'ngân hàng', 'Giao tiếp', '请问附近的银行几点开门？', 'Qǐngwèn fùjìn de yínháng jǐ diǎn kāimén?', 'Xin hỏi ngân hàng gần đây mấy giờ mở cửa?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9d964b36-7ee4-412d-8a4c-1d98eb3c5c63', '开户', 'kāihù', 'mở tài khoản', 'Giao tiếp', '我想办一张银行卡，怎么开户？', 'Wǒ xiǎng bàn yì zhāng yínhángkǎ, zěnme kāihù?', 'Tôi muốn làm một chiếc thẻ ngân hàng, mở tài khoản thế nào?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d680e002-9d72-4c8f-8d70-4ee515b29a75', '存钱', 'cúnqián', 'gửi tiền, nộp tiền', 'Giao tiếp', '我想把这些现金存进去。', 'Wǒ xiǎng bǎ zhèxiē xiànjīn cún jìnqù.', 'Tôi muốn gửi số tiền mặt này vào.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ccb22b09-6ba8-40b9-b781-127dd19821fc', '取钱', 'qǔqián', 'rút tiền', 'Giao tiếp', '我去自动取款机取钱。', 'Wǒ qù zìdòng qǔkuǎnjī qǔqián.', 'Tôi đi cây ATM để rút tiền.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9b319f40-516a-4023-81c4-aedb74d9d954', '汇款', 'huìkuǎn', 'chuyển tiền, chuyển khoản', 'Giao tiếp', '我想往这个账号汇款。', 'Wǒ xiǎng wǎng zhège zhànghào huìkuǎn.', 'Tôi muốn chuyển tiền vào số tài khoản này.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d514e064-6863-44e4-9af5-03b07c014ff2', '换钱', 'huànqián', 'đổi tiền, đổi ngoại tệ', 'Giao tiếp', '这里可以用美元换人民币吗？', 'Zhèlǐ kěyǐ yòng Měiyuán huàn Rénmínbì ma?', 'Ở đây có thể dùng USD đổi sang Nhân dân tệ không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('37af6377-41a1-47b6-8f05-d4ef3ebe81c3', '现金', 'xiànjīn', 'tiền mặt', 'Giao tiếp', '不好意思，我现在身上没有现金。', 'Bù hǎoyìsi, wǒ xiànzài shēnshang méiyǒu xiànjīn.', 'Ngại quá, trên người tôi bây giờ không có tiền mặt.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d0c52155-ba25-481f-a805-b074752580b9', '信用卡', 'xìnyòngkǎ', 'thẻ tín dụng', 'Giao tiếp', '这家店可以刷信用卡吗？', 'Zhè jiā diàn kěyǐ shuā xìnyòngkǎ ma?', 'Cửa hàng này có thể quẹt thẻ tín dụng không?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4dcc2122-171f-4e60-a9ca-d6282577edb4', '密码', 'mìmǎ', 'mật khẩu', 'Giao tiếp', '请输入您的六位密码。', 'Qǐng shūrù nín de liù wèi mìmǎ.', 'Vui lòng nhập mật khẩu gồm 6 chữ số của bạn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('914c00fb-2b26-49d1-98ad-1bbd7b39611e', '扫码', 'sǎomǎ', 'quét mã (QR)', 'Giao tiếp', '你可以扫这个二维码付款。', 'Nǐ kěyǐ sǎo zhège èrwéimǎ fùkuǎn.', 'Bạn có thể quét mã QR này để thanh toán.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('8083f050-24b2-45eb-851e-2af80629347a', '微信支付', 'Wēixìn zhīfù', 'thanh toán WeChat Pay', 'Giao tiếp', '中国很多人出门只用微信支付。', 'Zhōngguó hěn duō rén chūmén zhǐ yòng Wēixìn zhīfù.', 'Ở Trung Quốc nhiều người ra ngoài chỉ dùng WeChat Pay.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('640217de-9c9f-4140-84a4-c5fa97cb1351', '支付宝', 'Zhīfùbǎo', 'ví Alipay', 'Giao tiếp', '我用支付宝把钱转给你吧。', 'Wǒ yòng Zhīfùbǎo bǎ qián zhuǎn gěi nǐ ba.', 'Để tôi dùng Alipay chuyển tiền cho bạn nhé.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a048486e-e284-4e53-8e2b-a435199fcdce', '快递', 'kuàidì', 'chuyển phát nhanh, bưu phẩm', 'Giao tiếp', '你有两件快递到了，快去拿吧。', 'Nǐ yǒu liǎng jiàn kuàidì dào le, kuài qù ná ba.', 'Bạn có hai đơn hàng chuyển phát nhanh đến rồi, mau đi lấy đi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7c98d30b-e49a-45dd-8ea7-c75cdca52637', '包裹', 'bāoguǒ', 'bưu kiện, gói bưu phẩm', 'Giao tiếp', '我想寄一个包裹回越南。', 'Wǒ xiǎng jì yí gè bāoguǒ huí Yuènán.', 'Tôi muốn gửi một bưu kiện về Việt Nam.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0318f35e-683b-40e0-a633-ac8aee1faeb7', '签收', 'qiānshōu', 'ký nhận', 'Giao tiếp', '请在这里签字确认签收。', 'Qǐng zài zhèlǐ qiānzì quèrèn qiānshōu.', 'Vui lòng ký tên vào đây để xác nhận ký nhận.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1610f251-5513-4779-9a94-1cfeafa106aa', '节日', 'jiérì', 'ngày lễ, ngày hội', 'Giao tiếp', '中秋节是中国传统的节日。', 'Zhōngqiūjié shì Zhōngguó chuántǒng de jiérì.', 'Tết Trung thu là ngày lễ truyền thống của Trung Quốc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('23897407-a450-4ffb-b1e1-f5b145e9db1c', '春节', 'Chūnjié', 'Tết Nguyên Đán', 'Giao tiếp', '春节是中国人最重要的节日。', 'Chūnjié shì Zhōngguórén zuì zhòngyào de jiérì.', 'Tết Nguyên Đán là ngày lễ quan trọng nhất của người Trung Quốc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('58ab0e7c-4c34-4bf1-9aa8-f0699fb4f670', '中秋节', 'Zhōngqiūjié', 'Tết Trung Thu', 'Giao tiếp', '中秋节那天大家一起吃月饼赏月。', 'Zhōngqiūjié nà tiān dàjiā yìqǐ chī yuèbǐng shǎng yuè.', 'Vào ngày Tết Trung thu mọi người cùng nhau ăn bánh trung thu ngắm trăng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5e896618-c068-4cb8-b2a3-d904be9017e2', '聚会', 'jùhuì', 'tụ họp, tụ tập', 'Giao tiếp', '今晚我们班有一个同学聚会。', 'Jīnwǎn wǒmen bān yǒu yí gè tóngxué jùhuì.', 'Tối nay lớp chúng tôi có một buổi họp mặt bạn học.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ff515e7f-956a-442e-bf62-8fb5392bd1d5', '庆祝', 'qìngzhù', 'chúc mừng, ăn mừng', 'Giao tiếp', '我们打算去餐馆庆祝他的生日。', 'Wǒmen dǎsuàn qù cānguǎn qìngzhù tā de shēngrì.', 'Chúng tôi dự định đến nhà hàng ăn mừng sinh nhật của anh ấy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b0fb9bd9-5244-4994-96f2-c5103d441db1', '邀请', 'yāoqǐng', 'mời, lời mời', 'Giao tiếp', '谢谢你的邀请，我一定会去。', 'Xièxie nǐ de yāoqǐng, wǒ yídìng huì qù.', 'Cảm ơn lời mời của bạn, tôi nhất định sẽ đến.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('29072eb7-aedd-4456-b8d3-5a09e0b03014', '礼物', 'lǐwù', 'quà tặng, món quà', 'Giao tiếp', '这是我为你准备的生日礼物。', 'Zhè shì wǒ wèi nǐ zhǔnbèi de shēngrì lǐwù.', 'Đây là món quà sinh nhật tôi chuẩn bị cho bạn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2021af17-c5e6-45cd-9807-2d79934c6dab', '干杯', 'gānbēi', 'cạn ly, nâng ly', 'Giao tiếp', '为了我们的友谊，干杯！', 'Wèile wǒmen de yǒuyì, gānbēi!', 'Vì tình bạn của chúng ta, cạn ly!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a032d487-8390-4895-8ba6-4645af7d1eb7', '恭喜', 'gōngxǐ', 'chúc mừng', 'Giao tiếp', '听说你升职了，恭喜恭喜！', 'Tīngshuō nǐ shēngzhí le, gōngxǐ gōngxǐ!', 'Nghe nói bạn được thăng chức rồi, chúc mừng chúc mừng!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('8034369c-6805-4ba1-bae6-283081135ca3', '祝贺', 'zhùhè', 'chúc mừng (trang trọng)', 'Giao tiếp', '祝贺你顺利通过了考试！', 'Zhùhè nǐ shùnlì tōngguò le kǎoshì!', 'Chúc mừng bạn đã thuận lợi vượt qua kỳ thi!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1297a39f-dca0-4ce6-9251-f27bcc0932d7', '生日快乐', 'shēngrì kuàilè', 'chúc mừng sinh nhật', 'Giao tiếp', '祝你生日快乐，天天开心！', 'Zhù nǐ shēngrì kuàilè, tiāntiān kāixīn!', 'Chúc bạn sinh nhật vui vẻ, mỗi ngày đều vui tươi!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5d4d45c6-5c2b-45a2-aa67-c9b4c3853fec', '新年好', 'xīnnián hǎo', 'chúc mừng năm mới', 'Giao tiếp', '新年好！祝您万事如意！', 'Xīnnián hǎo! Zhù nín wànshì rúyì!', 'Chúc mừng năm mới! Chúc ngài vạn sự như ý!')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('8b9e8c1d-c964-47cd-9fb4-db72eb74f4d9', '顺利', 'shùnlì', 'thuận lợi, suôn sẻ', 'Giao tiếp', '祝你工作顺利，一切平安。', 'Zhù nǐ gōngzuò shùnlì, yíqiè píng''ān.', 'Chúc bạn công việc thuận lợi, mọi sự bình an.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('557968b3-b9f8-40f7-8a6b-be0e3b6383db', '红包', 'hóngbāo', 'bao lì xì, tiền mừng', 'Giao tiếp', '长辈会在过年时给孩子们发红包。', 'Zhǎngbèi huì zài guònián shí gěi háizimen fā hóngbāo.', 'Bậc trưởng bối sẽ phát bao lì xì cho trẻ nhỏ vào dịp Tết.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('93904c19-da39-4279-a6f5-195d7624586e', '保重', 'bǎozhòng', 'bảo trọng, giữ gìn sức khỏe', 'Giao tiếp', '天气冷了，你出门在外要多保重。', 'Tiānqì lěng le, nǐ chūmén zàiwài yào duō bǎozhòng.', 'Trời lạnh rồi, bạn đi xa nhớ bảo trọng sức khỏe.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;

-- Insert Lessons and Mappings
INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('bf4c7dcd-e5c3-4885-988c-6e4797f33a98', 'Bài 1 - Chào hỏi và Làm quen', 'Cách chào hỏi cơ bản, tự giới thiệu bản thân và hỏi tên, quốc tịch trong lần đầu gặp gỡ.', 'Giao tiếp', 1, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT 'bf4c7dcd-e5c3-4885-988c-6e4797f33a98', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('你好', '谢谢', '不客气', '对不起', '没关系', '再见', '叫', '名字', '什么', '是', '哪国人', '认识', '高兴', '请问', '贵姓');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('140fc7b3-093c-46a6-8507-2e4338f2a434', 'Bài 2 - Thời gian và Sinh hoạt Hàng ngày', 'Cách hỏi giờ giấc, nói về lịch trình sinh hoạt cá nhân và thói quen mỗi ngày.', 'Giao tiếp', 2, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '140fc7b3-093c-46a6-8507-2e4338f2a434', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('现在', '点', '分', '早上', '晚上', '起床', '睡觉', '吃早饭', '上班', '下班', '忙', '什么时候', '每天', '休息', '周末');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('69b7aaf2-b3e1-439b-9c7b-c7c4468738e0', 'Bài 3 - Ăn uống và Gọi món', 'Các mẫu câu và từ vựng dùng trong nhà hàng, quán ăn, cách gọi món và thanh toán hóa đơn.', 'Giao tiếp', 3, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '69b7aaf2-b3e1-439b-9c7b-c7c4468738e0', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('服务员', '菜单', '点菜', '喝', '水', '米饭', '面条', '好吃', '辣', '买单', '打包', '一共', '稍等', '推荐', '筷子');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('52e31ef6-2fa0-44b4-a221-d6b4d59d121d', 'Bài 4 - Mua sắm và Trả giá', 'Học cách hỏi giá, mặc cả, thử đồ và các phương thức thanh toán phổ biến khi đi mua sắm.', 'Giao tiếp', 4, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '52e31ef6-2fa0-44b4-a221-d6b4d59d121d', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('买', '多少钱', '太...了', '贵', '便宜', '一点儿', '打折', '试', '件', '颜色', '大', '刷卡', '现金', '扫码', '找钱');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6037eccd-be97-4a0f-b619-99efe983d4b7', 'Bài 5 - Hỏi đường và Giao thông', 'Cách hỏi và chỉ đường, nhận biết phương hướng và sử dụng các phương tiện giao thông công cộng.', 'Giao tiếp', 5, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '6037eccd-be97-4a0f-b619-99efe983d4b7', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('在哪儿', '怎么走', '一直走', '往', '左拐', '右拐', '远', '近', '地铁', '公交车', '出租车', '站', '换乘', '师傅', '迷路');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5c0e20f3-5f4a-4248-a5f2-46b0ae9beda1', 'Bài 6 - Sở thích và Thời gian Rảnh rỗi', 'Nói về sở thích cá nhân, các hoạt động giải trí cuối tuần và mời bạn bè tham gia.', 'Giao tiếp', 6, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '5c0e20f3-5f4a-4248-a5f2-46b0ae9beda1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('爱好', '喜欢', '看电影', '听音乐', '运动', '踢足球', '游泳', '旅游', '玩游戏', '常', '周末', '一起', '有空', '聊天', '拍照');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d216a948-e11d-4cc4-a675-36f7e8f4b6d1', 'Bài 7 - Thời tiết và Bốn mùa', 'Cách hỏi và miêu tả thời tiết, nhiệt độ cũng như các mùa trong năm.', 'Giao tiếp', 7, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT 'd216a948-e11d-4cc4-a675-36f7e8f4b6d1', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('天气', '怎么样', '热', '冷', '下雨', '晴天', '阴天', '刮风', '下雪', '温度', '预报', '春天', '夏天', '秋天', '冬天');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0b061dfa-a921-4c1e-801f-8dc57f4d487e', 'Bài 8 - Sức khỏe và Đi khám bệnh', 'Các từ vựng và câu giao tiếp khi bị ốm, mệt mỏi và đi khám bác sĩ.', 'Giao tiếp', 8, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '0b061dfa-a921-4c1e-801f-8dc57f4d487e', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('舒服', '感冒', '发烧', '头疼', '咳嗽', '肚子疼', '医院', '医生', '检查', '药', '打针', '休息', '请假', '嗓子', '严重');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8b9b9a4f-6abc-418e-9f00-8b91423ba024', 'Bài 9 - Du lịch và Đặt phòng Khách sạn', 'Các mẫu câu và từ vựng khi đi du lịch, nhận phòng và trả phòng tại khách sạn.', 'Giao tiếp', 9, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '8b9b9a4f-6abc-418e-9f00-8b91423ba024', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('旅游', '预订', '酒店', '单人间', '标准间', '入住', '退房', '护照', '房卡', '押金', '行李', '免费', '无线网', '含', '风景');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('87550373-a731-4aa9-9444-3aef8e07136a', 'Bài 10 - Gọi điện thoại và Hẹn gặp', 'Cách gọi điện thoại, để lại tin nhắn, sắp xếp lịch hẹn và thay đổi thời gian gặp mặt.', 'Giao tiếp', 10, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '87550373-a731-4aa9-9444-3aef8e07136a', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('喂', '打电话', '接电话', '发信息', '留言', '约会', '有空', '见面', '改天', '推迟', '准时', '占线', '挂断', '信号', '不见不散');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('90551adc-b04c-4900-bf1c-6a651500c829', 'Bài 11 - Nhà cửa và Thuê trọ', 'Từ vựng và giao tiếp khi tìm nhà, hỏi điều kiện thuê phòng, ký hợp đồng và đồ dùng gia đình.', 'Giao tiếp', 11, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '90551adc-b04c-4900-bf1c-6a651500c829', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('租房', '房东', '房租', '押金', '合同', '搬家', '家具', '水电费', '空调', '洗衣机', '厨房', '卫生间', '阳台', '邻居', '满意');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('a053521b-0a27-4466-8171-f6a696871668', 'Bài 12 - Công việc và Môi trường Công sở', 'Các từ vựng và câu giao tiếp thường ngày tại nơi làm việc, bàn công việc và trao đổi với đồng nghiệp.', 'Giao tiếp', 12, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT 'a053521b-0a27-4466-8171-f6a696871668', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('上班', '下班', '加班', '同事', '领导', '开会', '请假', '迟到', '任务', '项目', '报告', '邮件', '出差', '工资', '合作');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('19759d1a-be5c-468a-8ca1-6871ede08ded', 'Bài 13 - Gia đình và Mối quan hệ', 'Từ vựng và mẫu câu giới thiệu về các thành viên gia đình, tình trạng hôn nhân và các mối quan hệ thân thiết.', 'Giao tiếp', 13, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '19759d1a-be5c-468a-8ca1-6871ede08ded', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('家人', '父母', '父亲', '母亲', '兄弟姐妹', '丈夫', '妻子', '孩子', '爷爷', '奶奶', '结婚', '亲戚', '独生子', '照顾', '幸福');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('944254a4-6313-4ad9-a2cf-fc497432d7fe', 'Bài 14 - Ngân hàng và Thanh toán Điện tử', 'Giao dịch tài chính, đổi tiền, mở tài khoản và sử dụng thanh toán di động, gửi nhận bưu phẩm.', 'Giao tiếp', 14, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '944254a4-6313-4ad9-a2cf-fc497432d7fe', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('银行', '开户', '存钱', '取钱', '汇款', '换钱', '现金', '信用卡', '密码', '扫码', '微信支付', '支付宝', '快递', '包裹', '签收');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8f660dd8-7fb0-449c-b5ba-49b630f1b701', 'Bài 15 - Lễ hội, Tiệc tùng và Lời chúc', 'Giao tiếp trong các dịp lễ tết, tham gia tiệc tùng liên hoan và gửi những lời chúc tụng tốt đẹp.', 'Giao tiếp', 15, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '8f660dd8-7fb0-449c-b5ba-49b630f1b701', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('节日', '春节', '中秋节', '聚会', '庆祝', '邀请', '礼物', '干杯', '恭喜', '祝贺', '生日快乐', '新年好', '顺利', '红包', '保重');

