-- ==============================================================================;
-- MIGRATION: 20261024013000_hsk6_batch5_186_examples.sql;
-- Nạp 186 câu ví dụ HSK 6 Đợt 5 (X - Z: 协助 -> 足以) vào vocabularies và vocabulary_examples;
-- Chuẩn đề cương HSK 3.0 (CTI 11/2025), câu ví dụ văn cảnh hiện đại, Pinyin có dấu, dịch chuẩn nghĩa;
-- HOÀN TẤT 100% TOÀN BỘ 930 TỪ VỰNG HSK 6 CÒN THIẾU!
-- ==============================================================================;

BEGIN;

-- [协助] (xiézhù): giúp đỡ, hỗ trợ
UPDATE public.vocabularies
SET example_hanzi = '社区志愿者们积极协助医护人员，井然有序地为辖区老年居民进行健康体检与建档。',
    example_pinyin = 'Shèqū zhìyuànzhě men jījí xiézhù yīhù rényuán, jǐngrán-yǒuxù de wèi xiáqū lǎonián jūmín jìnxíng jiànkāng tǐjiǎn yǔ jiàndàng.',
    example_vi = 'Các tình nguyện viên cộng đồng tích cực hỗ trợ nhân viên y tế, tiến hành khám sức khỏe và lập hồ sơ cho người cao tuổi trong khu vực một cách trật tự ngăn nắp.'
WHERE id = 'a7f031f2-70f4-4461-a172-3d6704420cd7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a7f031f2-70f4-4461-a172-3d6704420cd7', '社区志愿者们积极协助医护人员，井然有序地为辖区老年居民进行健康体检与建档。', 'Shèqū zhìyuànzhě men jījí xiézhù yīhù rényuán, jǐngrán-yǒuxù de wèi xiáqū lǎonián jūmín jìnxíng jiànkāng tǐjiǎn yǔ jiàndàng.', 'Các tình nguyện viên cộng đồng tích cực hỗ trợ nhân viên y tế, tiến hành khám sức khỏe và lập hồ sơ cho người cao tuổi trong khu vực một cách trật tự ngăn nắp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a7f031f2-70f4-4461-a172-3d6704420cd7'
);

-- [媳妇] (xífù): con dâu, vợ
UPDATE public.vocabularies
SET example_hanzi = '这位通情达理的婆婆与勤劳善良的儿媳妇相处得极为融洽，邻里之间无不交口称赞。',
    example_pinyin = 'Zhè wèi tōngqíng-dálǐ de pópo yǔ qínláo shànliáng de ér xífù xiāngchǔ de jíqí róngqià, línlǐ zhījiān wúbù jiāokǒu-chēngzàn.',
    example_vi = 'Người mẹ chồng hiểu lý lẽ này và cô con dâu chăm chỉ hiền lành chung sống vô cùng hòa thuận, bà con chòm xóm ai nấy đều hết lời khen ngợi.'
WHERE id = '15bbf804-0881-43df-afd1-4752fdd4df71' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '15bbf804-0881-43df-afd1-4752fdd4df71', '这位通情达理的婆婆与勤劳善良的儿媳妇相处得极为融洽，邻里之间无不交口称赞。', 'Zhè wèi tōngqíng-dálǐ de pópo yǔ qínláo shànliáng de ér xífù xiāngchǔ de jíqí róngqià, línlǐ zhījiān wúbù jiāokǒu-chēngzàn.', 'Người mẹ chồng hiểu lý lẽ này và cô con dâu chăm chỉ hiền lành chung sống vô cùng hòa thuận, bà con chòm xóm ai nấy đều hết lời khen ngợi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '15bbf804-0881-43df-afd1-4752fdd4df71'
);

-- [细菌] (xìjūn): vi khuẩn
UPDATE public.vocabularies
SET example_hanzi = '微生物实验室研究人员利用新型培养皿，深入探究有益益生菌与有害致病细菌的相互作用机制。',
    example_pinyin = 'Wēishēngwù shíyànshì yánjiū rényuán lìyòng xīnxíng péiyǎngmǐn, shēnrù tànjiū yǒuyì yìshēngjūn yǔ yǒuhài zhìbìng xìjūn de xiānghù zuòyòng jīzhì.',
    example_vi = 'Các nhà nghiên cứu trong phòng thí nghiệm vi sinh đã dùng đĩa nuôi cấy kiểu mới để đi sâu tìm hiểu cơ chế tương tác giữa lợi khuẩn có ích và vi khuẩn gây bệnh có hại.'
WHERE id = '99507cc2-b4ff-4d26-97c1-e2ae850515a5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '99507cc2-b4ff-4d26-97c1-e2ae850515a5', '微生物实验室研究人员利用新型培养皿，深入探究有益益生菌与有害致病细菌的相互作用机制。', 'Wēishēngwù shíyànshì yánjiū rényuán lìyòng xīnxíng péiyǎngmǐn, shēnrù tànjiū yǒuyì yìshēngjūn yǔ yǒuhài zhìbìng xìjūn de xiānghù zuòyòng jīzhì.', 'Các nhà nghiên cứu trong phòng thí nghiệm vi sinh đã dùng đĩa nuôi cấy kiểu mới để đi sâu tìm hiểu cơ chế tương tác giữa lợi khuẩn có ích và vi khuẩn gây bệnh có hại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '99507cc2-b4ff-4d26-97c1-e2ae850515a5'
);

-- [系列] (xìliè): chuỗi, loạt, series
UPDATE public.vocabularies
SET example_hanzi = '该国家级科研所近期陆续推出了一系列关于清洁能源与生态保护的高水平学术专著。',
    example_pinyin = 'Gāi guójiājí kēyánsuǒ jìnqī lùxù tuīchū le yí xìliè guānyú qīngjié néngyuán yǔ shēngtài bǎohù de gāo shuǐpíng xuéshù zhuānzhù.',
    example_vi = 'Viện nghiên cứu khoa học cấp quốc gia này gần đây đã liên tục cho ra mắt một loạt chuyên khảo học thuật trình độ cao về năng lượng sạch và bảo vệ sinh thái.'
WHERE id = 'f31d4d7c-3e45-4407-9c07-554bdfd418ae' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f31d4d7c-3e45-4407-9c07-554bdfd418ae', '该国家级科研所近期陆续推出了一系列关于清洁能源与生态保护的高水平学术专著。', 'Gāi guójiājí kēyánsuǒ jìnqī lùxù tuīchū le yí xìliè guānyú qīngjié néngyuán yǔ shēngtài bǎohù de gāo shuǐpíng xuéshù zhuānzhù.', 'Viện nghiên cứu khoa học cấp quốc gia này gần đây đã liên tục cho ra mắt một loạt chuyên khảo học thuật trình độ cao về năng lượng sạch và bảo vệ sinh thái.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f31d4d7c-3e45-4407-9c07-554bdfd418ae'
);

-- [心灵] (xīn líng): tâm hồn, tâm linh
UPDATE public.vocabularies
SET example_hanzi = '优秀的经典文学名著如同清澈甘冽的山泉，能够洗涤浮躁、深刻启迪人们的心灵世界。',
    example_pinyin = 'Yōuxiù de jīngdiǎn wénxué míngzhù rútóng qīngchè gānliè de shānquán, nénggòu xǐdí fúzào, shēnkè qǐdí rénmen de xīnlíng shìjiè.',
    example_vi = 'Các danh tác văn học kinh điển ưu tú như dòng suối núi trong trẻo ngọt lành, có thể gột rửa thói bốc đồng nóng vội và khai sáng sâu sắc thế giới tâm hồn con người.'
WHERE id = '7629a6aa-bf09-4ec7-9f37-a23dd6ccc844' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7629a6aa-bf09-4ec7-9f37-a23dd6ccc844', '优秀的经典文学名著如同清澈甘冽的山泉，能够洗涤浮躁、深刻启迪人们的心灵世界。', 'Yōuxiù de jīngdiǎn wénxué míngzhù rútóng qīngchè gānliè de shānquán, nénggòu xǐdí fúzào, shēnkè qǐdí rénmen de xīnlíng shìjiè.', 'Các danh tác văn học kinh điển ưu tú như dòng suối núi trong trẻo ngọt lành, có thể gột rửa thói bốc đồng nóng vội và khai sáng sâu sắc thế giới tâm hồn con người.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7629a6aa-bf09-4ec7-9f37-a23dd6ccc844'
);

-- [心疼] (xīn téng): đau lòng, xót xa
UPDATE public.vocabularies
SET example_hanzi = '看到女儿为了备战全国技能大赛日夜苦读、熬红了双眼，做母亲的感到无比心疼。',
    example_pinyin = 'Kàn dào nǚ''ér wèile bèizhàn quánguó jìnéng dàsài rìyè kǔdú, áohóng le shuāngyǎn, zuò mǔqīn de gǎndào wúbǐ xīnténg.',
    example_vi = 'Nhìn thấy con gái vì chuẩn bị cho kỳ thi kỹ năng toàn quốc mà ngày đêm miệt mài thức trắng đỏ hoe cả mắt, người mẹ cảm thấy vô cùng xót xa đau lòng.'
WHERE id = '5b023c21-0150-4581-a42d-e83be97efb12' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5b023c21-0150-4581-a42d-e83be97efb12', '看到女儿为了备战全国技能大赛日夜苦读、熬红了双眼，做母亲的感到无比心疼。', 'Kàn dào nǚ''ér wèile bèizhàn quánguó jìnéng dàsài rìyè kǔdú, áohóng le shuāngyǎn, zuò mǔqīn de gǎndào wúbǐ xīnténg.', 'Nhìn thấy con gái vì chuẩn bị cho kỳ thi kỹ năng toàn quốc mà ngày đêm miệt mài thức trắng đỏ hoe cả mắt, người mẹ cảm thấy vô cùng xót xa đau lòng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5b023c21-0150-4581-a42d-e83be97efb12'
);

-- [性能] (xìng néng): tính năng, hiệu năng
UPDATE public.vocabularies
SET example_hanzi = '经过多轮严苛的高温极寒极端环境测试，这台国产航空发动机展现出极为优异可靠的整体性能。',
    example_pinyin = 'Jīngguò duō lún yánkē de gāowēn jíhán jíduān huánjìng cèshì, zhè tái guóchǎn hángkōng fādòngjī zhǎnxiàn chū jíqí yōuyì kěkào de zhěngtǐ xìngnéng.',
    example_vi = 'Sau nhiều đợt thử nghiệm môi trường khắc nghiệt nóng gắt lạnh giá nghiêm ngặt, cỗ động cơ hàng không nội địa này đã thể hiện tính năng tổng thể vô cùng ưu việt và đáng tin cậy.'
WHERE id = 'a3f0cb49-bc91-4378-9cde-bd35d27663e7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a3f0cb49-bc91-4378-9cde-bd35d27663e7', '经过多轮严苛的高温极寒极端环境测试，这台国产航空发动机展现出极为优异可靠的整体性能。', 'Jīngguò duō lún yánkē de gāowēn jíhán jíduān huánjìng cèshì, zhè tái guóchǎn hángkōng fādòngjī zhǎnxiàn chū jíqí yōuyì kěkào de zhěngtǐ xìngnéng.', 'Sau nhiều đợt thử nghiệm môi trường khắc nghiệt nóng gắt lạnh giá nghiêm ngặt, cỗ động cơ hàng không nội địa này đã thể hiện tính năng tổng thể vô cùng ưu việt và đáng tin cậy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a3f0cb49-bc91-4378-9cde-bd35d27663e7'
);

-- [形态] (xíng tài): hình thái
UPDATE public.vocabularies
SET example_hanzi = '随着数字科技与实体产业的深度交融，当今文化创意产业正在孕育出崭新的组织形态与商业模式。',
    example_pinyin = 'Suízhe shùzì kējì yǔ shítǐ chǎnyè de shēndù jiāoróng, dāngjīn wénhuà chuàngyì chǎnyè zhèngzài yùnyù chū zhǎnxīn de zǔzhī xíngtài yǔ shāngyè móshì.',
    example_vi = 'Cùng với sự giao thoa sâu sắc giữa công nghệ số và các ngành công nghiệp thực thể, ngành công nghiệp sáng tạo văn hóa ngày nay đang ấp ủ những hình thái tổ chức và mô hình kinh doanh hoàn toàn mới.'
WHERE id = 'd2d3f4e9-2331-474a-af9a-247852762f2b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd2d3f4e9-2331-474a-af9a-247852762f2b', '随着数字科技与实体产业的深度交融，当今文化创意产业正在孕育出崭新的组织形态与商业模式。', 'Suízhe shùzì kējì yǔ shítǐ chǎnyè de shēndù jiāoróng, dāngjīn wénhuà chuàngyì chǎnyè zhèngzài yùnyù chū zhǎnxīn de zǔzhī xíngtài yǔ shāngyè móshì.', 'Cùng với sự giao thoa sâu sắc giữa công nghệ số và các ngành công nghiệp thực thể, ngành công nghiệp sáng tạo văn hóa ngày nay đang ấp ủ những hình thái tổ chức và mô hình kinh doanh hoàn toàn mới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd2d3f4e9-2331-474a-af9a-247852762f2b'
);

-- [信赖] (xìnlài): tin cậy, tín nhiệm
UPDATE public.vocabularies
SET example_hanzi = '这家拥有百年历史的老字号制药企业，凭借严把质量关赢得了海内外广大患者的深厚信赖。',
    example_pinyin = 'Zhè jiā yōngyǒu bǎinián lìshǐ de lǎozìhào zhìyào qǐyè, píngjiè yánbǎ zhìliàngguān yíngdé le hǎinèiwài guǎngdà huànzhě de shēnhòu xìnlài.',
    example_vi = 'Doanh nghiệp dược phẩm lâu đời với lịch sử trăm năm này nhờ việc kiểm soát chất lượng nghiêm ngặt đã giành được sự tin cậy sâu sắc của đông đảo người bệnh trong và ngoài nước.'
WHERE id = '557fd945-3a58-4bc4-9ecf-717ef7c22e44' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '557fd945-3a58-4bc4-9ecf-717ef7c22e44', '这家拥有百年历史的老字号制药企业，凭借严把质量关赢得了海内外广大患者的深厚信赖。', 'Zhè jiā yōngyǒu bǎinián lìshǐ de lǎozìhào zhìyào qǐyè, píngjiè yánbǎ zhìliàngguān yíngdé le hǎinèiwài guǎngdà huànzhě de shēnhòu xìnlài.', 'Doanh nghiệp dược phẩm lâu đời với lịch sử trăm năm này nhờ việc kiểm soát chất lượng nghiêm ngặt đã giành được sự tin cậy sâu sắc của đông đảo người bệnh trong và ngoài nước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '557fd945-3a58-4bc4-9ecf-717ef7c22e44'
);

-- [信念] (xìnniàn): lòng tin, niềm tin
UPDATE public.vocabularies
SET example_hanzi = '正是凭借着为全人类探索浩瀚太空的崇高信念，一代代航天科学家战胜了无数无法想象的困难阻碍。',
    example_pinyin = 'Zhèngshì píngjiè zhe wèi quán rénlèi tànsuǒ hàohàn tàikōng de chónggāo xìnniàn, yídàidài hángtiān kēxuéjiā zhànshèng le wúshù wúfǎ xiǎngxiàng de kùnnán zǔ''ài.',
    example_vi = 'Chính nhờ vào niềm tin cao đẹp khám phá vũ trụ bao la vì toàn thể nhân loại mà bao thế hệ nhà khoa học hàng không vũ trụ đã vượt qua vô vàn khó khăn trở ngại không thể tưởng tượng nổi.'
WHERE id = 'bde82186-56ad-41db-b544-1ea3bcb82601' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bde82186-56ad-41db-b544-1ea3bcb82601', '正是凭借着为全人类探索浩瀚太空的崇高信念，一代代航天科学家战胜了无数无法想象的困难阻碍。', 'Zhèngshì píngjiè zhe wèi quán rénlèi tànsuǒ hàohàn tàikōng de chónggāo xìnniàn, yídàidài hángtiān kēxuéjiā zhànshèng le wúshù wúfǎ xiǎngxiàng de kùnnán zǔ''ài.', 'Chính nhờ vào niềm tin cao đẹp khám phá vũ trụ bao la vì toàn thể nhân loại mà bao thế hệ nhà khoa học hàng không vũ trụ đã vượt qua vô vàn khó khăn trở ngại không thể tưởng tượng nổi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bde82186-56ad-41db-b544-1ea3bcb82601'
);

-- [薪水] (xīnshui): tiền lương
UPDATE public.vocabularies
SET example_hanzi = '除了丰厚优渥的薪水待遇外，现代年轻人求职时也十分看重公司的晋升空间与企业文化氛围。',
    example_pinyin = 'Chúle fēnghòu yōuwò de xīnshui dàiyù wài, xiàndài niánqīngrén qiúzhí shí yě shífēn kànzhòng gōngsī de jìnshēng kōngjiān yǔ qǐyè wénhuà fēnwéi.',
    example_vi = 'Bên cạnh chế độ tiền lương đãi ngộ hậu hĩnh dồi dào, giới trẻ ngày nay khi tìm việc cũng hết sức coi trọng không gian thăng tiến của công ty và bầu không khí văn hóa doanh nghiệp.'
WHERE id = '55c67234-46e4-4b18-90a9-bf75140b7884' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '55c67234-46e4-4b18-90a9-bf75140b7884', '除了丰厚优渥的薪水待遇外，现代年轻人求职时也十分看重公司的晋升空间与企业文化氛围。', 'Chúle fēnghòu yōuwò de xīnshui dàiyù wài, xiàndài niánqīngrén qiúzhí shí yě shífēn kànzhòng gōngsī de jìnshēng kōngjiān yǔ qǐyè wénhuà fēnwéi.', 'Bên cạnh chế độ tiền lương đãi ngộ hậu hĩnh dồi dào, giới trẻ ngày nay khi tìm việc cũng hết sức coi trọng không gian thăng tiến của công ty và bầu không khí văn hóa doanh nghiệp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '55c67234-46e4-4b18-90a9-bf75140b7884'
);

-- [新颖] (xīnyǐng): mới mẻ, mới lạ
UPDATE public.vocabularies
SET example_hanzi = '这位年轻建筑设计师构思新颖独特，巧妙地将传统江南园林的水乡意境融入到了现代大厦之中。',
    example_pinyin = 'Zhè wèi niánqīng jiànzhù shèjìshī gòusī xīnyǐng dútè, qiǎomiào de jiāng chuántǒng jiāngnán yuánlín de shuǐxiāng yìjìng róngrù dào le xiàndài dàshà zhīzhōng.',
    example_vi = 'Kiến trúc sư trẻ tuổi này có ý tưởng thiết kế mới mẻ độc đáo, khéo léo hòa quyện ý cảnh miền sông nước của vườn cảnh Giang Nam truyền thống vào trong tòa cao ốc hiện đại.'
WHERE id = '3445a702-9645-4d60-9b54-9dfd51b5051f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3445a702-9645-4d60-9b54-9dfd51b5051f', '这位年轻建筑设计师构思新颖独特，巧妙地将传统江南园林的水乡意境融入到了现代大厦之中。', 'Zhè wèi niánqīng jiànzhù shèjìshī gòusī xīnyǐng dútè, qiǎomiào de jiāng chuántǒng jiāngnán yuánlín de shuǐxiāng yìjìng róngrù dào le xiàndài dàshà zhīzhōng.', 'Kiến trúc sư trẻ tuổi này có ý tưởng thiết kế mới mẻ độc đáo, khéo léo hòa quyện ý cảnh miền sông nước của vườn cảnh Giang Nam truyền thống vào trong tòa cao ốc hiện đại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3445a702-9645-4d60-9b54-9dfd51b5051f'
);

-- [心脏] (xīnzàng): trái tim
UPDATE public.vocabularies
SET example_hanzi = '作为人体循环系统至关重要的动力核心，心脏每分每秒都在不停歇地跳动以输送富氧血液。',
    example_pinyin = 'Zuòwéi réntǐ xúnhuán xìtǒng zhìguān zhòngyào de dònglì héxīn, xīnzàng měifēn-měimiǎo dōu zài bù tíngxiē de tiàodòng yǐ shūsòng fùyǎng xuèyè.',
    example_vi = 'Là trung tâm động lực tối quan trọng của hệ tuần hoàn cơ thể người, trái tim từng phút từng giây đều không ngừng đập để vận chuyển dòng máu giàu oxy.'
WHERE id = '4d2cdf1b-7f31-40c8-b566-42000242c464' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4d2cdf1b-7f31-40c8-b566-42000242c464', '作为人体循环系统至关重要的动力核心，心脏每分每秒都在不停歇地跳动以输送富氧血液。', 'Zuòwéi réntǐ xúnhuán xìtǒng zhìguān zhòngyào de dònglì héxīn, xīnzàng měifēn-měimiǎo dōu zài bù tíngxiē de tiàodòng yǐ shūsòng fùyǎng xuèyè.', 'Là trung tâm động lực tối quan trọng của hệ tuần hoàn cơ thể người, trái tim từng phút từng giây đều không ngừng đập để vận chuyển dòng máu giàu oxy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4d2cdf1b-7f31-40c8-b566-42000242c464'
);

-- [胸] (xiōng): ngực
UPDATE public.vocabularies
SET example_hanzi = '面对生活中的挫折与旁人的非议，我们应当挺起胸膛勇敢向前，以包容宽广的胸怀面对世界。',
    example_pinyin = 'Miànduì shēnghuó zhōng de cuòzhé yǔ pángrén de fēiyì, wǒmen yīngdāng tǐng qǐ xiōngtáng yǒnggǎn xiàngqián, yǐ bāoróng kuānguǎng de xiōnghuái miànduì shìjiè.',
    example_vi = 'Đối diện với những trắc trở trong cuộc sống và lời dị nghị của người ngoài, chúng ta cần ưỡn ngực dũng cảm tiến lên phía trước, dùng lồng ngực rộng mở bao dung đối diện với thế giới.'
WHERE id = 'dfc93b0d-bd87-432d-952f-a368e8451a49' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dfc93b0d-bd87-432d-952f-a368e8451a49', '面对生活中的挫折与旁人的非议，我们应当挺起胸膛勇敢向前，以包容宽广的胸怀面对世界。', 'Miànduì shēnghuó zhōng de cuòzhé yǔ pángrén de fēiyì, wǒmen yīngdāng tǐng qǐ xiōngtáng yǒnggǎn xiàngqián, yǐ bāoróng kuānguǎng de xiōnghuái miànduì shìjiè.', 'Đối diện với những trắc trở trong cuộc sống và lời dị nghị của người ngoài, chúng ta cần ưỡn ngực dũng cảm tiến lên phía trước, dùng lồng ngực rộng mở bao dung đối diện với thế giới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dfc93b0d-bd87-432d-952f-a368e8451a49'
);

-- [吸取] (xīqǔ): hút lấy, rút ra (kinh nghiệm)
UPDATE public.vocabularies
SET example_hanzi = '从失败的项目经验中认真分析总结、吸取教训，是科研团队实现未来技术攻坚反超的关键所在。',
    example_pinyin = 'Cóng shībài de xiàngmù jīngyàn zhōng rènzhēn fēnxī zǒngjié, xīqǔ jiàoxùn, shì kēyán tuánduì shíxiàn wèilái jìshù gōngjiān fǎnchāo de guānjiàn suǒzài.',
    example_vi = 'Nghiêm túc phân tích đúc kết và rút ra bài học từ kinh nghiệm dự án thất bại là điểm mấu chốt then chốt để đội ngũ nghiên cứu hiện thực hóa việc bứt phá vượt lên trong công phá kỹ thuật tương lai.'
WHERE id = '62dee053-a32a-4ccc-8e9a-b6bb6fd4a5aa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '62dee053-a32a-4ccc-8e9a-b6bb6fd4a5aa', '从失败的项目经验中认真分析总结、吸取教训，是科研团队实现未来技术攻坚反超的关键所在。', 'Cóng shībài de xiàngmù jīngyàn zhōng rènzhēn fēnxī zǒngjié, xīqǔ jiàoxùn, shì kēyán tuánduì shíxiàn wèilái jìshù gōngjiān fǎnchāo de guānjiàn suǒzài.', 'Nghiêm túc phân tích đúc kết và rút ra bài học từ kinh nghiệm dự án thất bại là điểm mấu chốt then chốt để đội ngũ nghiên cứu hiện thực hóa việc bứt phá vượt lên trong công phá kỹ thuật tương lai.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '62dee053-a32a-4ccc-8e9a-b6bb6fd4a5aa'
);

-- [修复] (xiūfù): phục hồi, tu sửa
UPDATE public.vocabularies
SET example_hanzi = '文保专家耗费整整三年心血，终于成功修复了这幅在漫长历史岁月中受损严重的名贵绢本古画。',
    example_pinyin = 'Wénbǎo zhuānjiā hàofèi zhěngzhěng sān nián xīnxuè, zhōngyú chénggōng xiūfù le zhè fú zài màncháng lìshǐ suìyuè zhōng shòusǔn yánzhòng de míngguì juànběn gǔhuà.',
    example_vi = 'Các chuyên gia bảo tồn di sản đã hao tốn trọn ba năm tâm huyết, cuối cùng đã phục hồi thành công bức cổ họa lụa quý giá bị tổn hại nghiêm trọng qua năm tháng lịch sử dài đằng đẵng này.'
WHERE id = 'bd835187-2f06-4caf-9146-87d75995b5ac' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bd835187-2f06-4caf-9146-87d75995b5ac', '文保专家耗费整整三年心血，终于成功修复了这幅在漫长历史岁月中受损严重的名贵绢本古画。', 'Wénbǎo zhuānjiā hàofèi zhěngzhěng sān nián xīnxuè, zhōngyú chénggōng xiūfù le zhè fú zài màncháng lìshǐ suìyuè zhōng shòusǔn yánzhòng de míngguì juànběn gǔhuà.', 'Các chuyên gia bảo tồn di sản đã hao tốn trọn ba năm tâm huyết, cuối cùng đã phục hồi thành công bức cổ họa lụa quý giá bị tổn hại nghiêm trọng qua năm tháng lịch sử dài đằng đẵng này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bd835187-2f06-4caf-9146-87d75995b5ac'
);

-- [细致] (xìzhì): tỉ mỉ, kỹ lưỡng
UPDATE public.vocabularies
SET example_hanzi = '由于前期进行了极其周密细致的市场调研与实地走访，该重大招商引资项目得以顺利高效落地。',
    example_pinyin = 'Yóuyú qiánqī jìnxíng le jíqí zhōumì xìzhì de shìchǎng diàoyán yǔ shídì zǒufǎng, gāi zhòngdà zhāoshāng-yǐnzī xiàngmù déyǐ shùnlì gāoxiào luòdì.',
    example_vi = 'Nhờ giai đoạn trước đã tiến hành điều tra thị trường và khảo sát thực tế vô cùng chu đáo tỉ mỉ, dự án thu hút đầu tư trọng đại này đã được triển khai thuận lợi và đạt hiệu quả cao.'
WHERE id = '447662a1-3c0f-4855-b0e1-70f54509df18' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '447662a1-3c0f-4855-b0e1-70f54509df18', '由于前期进行了极其周密细致的市场调研与实地走访，该重大招商引资项目得以顺利高效落地。', 'Yóuyú qiánqī jìnxíng le jíqí zhōumì xìzhì de shìchǎng diàoyán yǔ shídì zǒufǎng, gāi zhòngdà zhāoshāng-yǐnzī xiàngmù déyǐ shùnlì gāoxiào luòdì.', 'Nhờ giai đoạn trước đã tiến hành điều tra thị trường và khảo sát thực tế vô cùng chu đáo tỉ mỉ, dự án thu hút đầu tư trọng đại này đã được triển khai thuận lợi và đạt hiệu quả cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '447662a1-3c0f-4855-b0e1-70f54509df18'
);

-- [选拔] (xuǎnbá): tuyển chọn
UPDATE public.vocabularies
SET example_hanzi = '经过层层严格的体能测验、心理测试与外语考核，二十名优秀空军飞行员被选拔进入预备航天员梯队。',
    example_pinyin = 'Jīngguò céngcéng yángé de tǐnéng cèyàn, xīnlǐ cèshì yǔ wàiyǔ kǎohé, èrshí míng yōuxiù kōngjūn fēixíngyuán bèi xuǎnbá jìnrù yùbèi hángtiānyuán tīduì.',
    example_vi = 'Trải qua các tầng kiểm tra thể lực, bài trắc nghiệm tâm lý và sát hạch ngoại ngữ nghiêm ngặt, 20 phi công không quân ưu tú đã được tuyển chọn bước vào lực lượng phi hành gia dự bị.'
WHERE id = 'c32a9a01-28bc-4e59-b818-859b6d016d04' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c32a9a01-28bc-4e59-b818-859b6d016d04', '经过层层严格的体能测验、心理测试与外语考核，二十名优秀空军飞行员被选拔进入预备航天员梯队。', 'Jīngguò céngcéng yángé de tǐnéng cèyàn, xīnlǐ cèshì yǔ wàiyǔ kǎohé, èrshí míng yōuxiù kōngjūn fēixíngyuán bèi xuǎnbá jìnrù yùbèi hángtiānyuán tīduì.', 'Trải qua các tầng kiểm tra thể lực, bài trắc nghiệm tâm lý và sát hạch ngoại ngữ nghiêm ngặt, 20 phi công không quân ưu tú đã được tuyển chọn bước vào lực lượng phi hành gia dự bị.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c32a9a01-28bc-4e59-b818-859b6d016d04'
);

-- [旋转] (xuánzhuǎn): xoay quanh, quay tròn
UPDATE public.vocabularies
SET example_hanzi = '芭蕾舞演员在舞台中央伴随着优美轻快的交响乐旋律轻盈起舞，连续完成了多次高难度的单腿旋转。',
    example_pinyin = 'Bālěiwǔ yǎnyuán zài wǔtái zhōngyāng bànsuí zhe yōuměi qīngkuài de jiāoxiǎngyuè xuánlǜ qīngyíng qǐwǔ, liánxù wánchéng le duō cì gāonándù de dāntuǐ xuánzhuǎn.',
    example_vi = 'Diễn viên múa ba lê ở giữa sân khấu hòa cùng giai điệu giao hưởng nhẹ nhàng êm ái uyển chuyển cất bước, liên tiếp hoàn thành nhiều vòng xoay tròn trên một chân có độ khó cao.'
WHERE id = '6216b3db-b1ca-4996-8ea7-59361a25a53f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6216b3db-b1ca-4996-8ea7-59361a25a53f', '芭蕾舞演员在舞台中央伴随着优美轻快的交响乐旋律轻盈起舞，连续完成了多次高难度的单腿旋转。', 'Bālěiwǔ yǎnyuán zài wǔtái zhōngyāng bànsuí zhe yōuměi qīngkuài de jiāoxiǎngyuè xuánlǜ qīngyíng qǐwǔ, liánxù wánchéng le duō cì gāonándù de dāntuǐ xuánzhuǎn.', 'Diễn viên múa ba lê ở giữa sân khấu hòa cùng giai điệu giao hưởng nhẹ nhàng êm ái uyển chuyển cất bước, liên tiếp hoàn thành nhiều vòng xoay tròn trên một chân có độ khó cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6216b3db-b1ca-4996-8ea7-59361a25a53f'
);

-- [学位] (xuéwèi): học vị
UPDATE public.vocabularies
SET example_hanzi = '经过四年的勤奋攻读与严格考核，他不仅顺利获得了工程学学士学位，还赢得了全额奖学金。',
    example_pinyin = 'Jīngguò sì nián de qínfèn gōngdú yǔ yángé kǎohé, tā bùjǐn shùnlì huòdé le gōngchéngxué xuéshì xuéwèi, hái yíngdé le quán''é jiǎngxuéjīn.',
    example_vi = 'Trải qua bốn năm miệt mài dùi mài và khảo hạch nghiêm ngặt, anh ấy không chỉ thuận lợi lấy được học vị cử nhân ngành kỹ thuật công trình mà còn giành được học bổng toàn phần.'
WHERE id = '9952d8cd-b20a-41dc-9e2e-d2b895aaaa29' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9952d8cd-b20a-41dc-9e2e-d2b895aaaa29', '经过四年的勤奋攻读与严格考核，他不仅顺利获得了工程学学士学位，还赢得了全额奖学金。', 'Jīngguò sì nián de qínfèn gōngdú yǔ yángé kǎohé, tā bùjǐn shùnlì huòdé le gōngchéngxué xuéshì xuéwèi, hái yíngdé le quán''é jiǎngxuéjīn.', 'Trải qua bốn năm miệt mài dùi mài và khảo hạch nghiêm ngặt, anh ấy không chỉ thuận lợi lấy được học vị cử nhân ngành kỹ thuật công trình mà còn giành được học bổng toàn phần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9952d8cd-b20a-41dc-9e2e-d2b895aaaa29'
);

-- [学问] (xuéwen): học vấn, kiến thức
UPDATE public.vocabularies
SET example_hanzi = '做学问不仅需要坐得住冷板凳的坚韧定力，更需要始终保持独立思考与严谨求实的治学精神。',
    example_pinyin = 'Zuò xuéwen bùjǐn xūyào zuò de zhù lěngbǎndèng de jiānrèn dìnglì, gèng xūyào shǐzhōng bǎochí dúlì sīkǎo yǔ yánjǐn qiúshí de zhìxué jīngshén.',
    example_vi = 'Làm học vấn không chỉ đòi hỏi định lực kiên cường có thể ngồi yên trên chiếc ghế lạnh, mà càng cần luôn duy trì tư duy độc lập và tinh thần học thuật nghiêm cẩn cầu thị.'
WHERE id = '288ae17d-8d8f-4c1a-9802-1f9850ca9f63' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '288ae17d-8d8f-4c1a-9802-1f9850ca9f63', '做学问不仅需要坐得住冷板凳的坚韧定力，更需要始终保持独立思考与严谨求实的治学精神。', 'Zuò xuéwen bùjǐn xūyào zuò de zhù lěngbǎndèng de jiānrèn dìnglì, gèng xūyào shǐzhōng bǎochí dúlì sīkǎo yǔ yánjǐn qiúshí de zhìxué jīngshén.', 'Làm học vấn không chỉ đòi hỏi định lực kiên cường có thể ngồi yên trên chiếc ghế lạnh, mà càng cần luôn duy trì tư duy độc lập và tinh thần học thuật nghiêm cẩn cầu thị.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '288ae17d-8d8f-4c1a-9802-1f9850ca9f63'
);

-- [血压] (xuèyā): huyết áp
UPDATE public.vocabularies
SET example_hanzi = '心血管专家建议高血压患者坚持每日定时监测血压，并保持低盐少油的清淡饮食习惯。',
    example_pinyin = 'Xīnxuèguǎn zhuānjiā jiànyì gāoxuèyā huànzhě jiānchí měirì dìngshí jiāncè xuèyā, bìng bǎochí dīyán shǎoyóu de qīngdàn yǐnshí xíguàn.',
    example_vi = 'Chuyên gia tim mạch khuyên bệnh nhân huyết áp cao nên kiên trì theo dõi huyết áp định kỳ hằng ngày, đồng thời duy trì thói quen ăn uống thanh đạm ít muối ít dầu mỡ.'
WHERE id = '9def950b-043c-48c7-8783-8878b9a6e5cc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9def950b-043c-48c7-8783-8878b9a6e5cc', '心血管专家建议高血压患者坚持每日定时监测血压，并保持低盐少油的清淡饮食习惯。', 'Xīnxuèguǎn zhuānjiā jiànyì gāoxuèyā huànzhě jiānchí měirì dìngshí jiāncè xuèyā, bìng bǎochí dīyán shǎoyóu de qīngdàn yǐnshí xíguàn.', 'Chuyên gia tim mạch khuyên bệnh nhân huyết áp cao nên kiên trì theo dõi huyết áp định kỳ hằng ngày, đồng thời duy trì thói quen ăn uống thanh đạm ít muối ít dầu mỡ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9def950b-043c-48c7-8783-8878b9a6e5cc'
);

-- [许可] (xǔkě): cho phép
UPDATE public.vocabularies
SET example_hanzi = '任何企业在未获得国家环境保护部门的正式排放许可之前，严禁擅自开工排放工业废水。',
    example_pinyin = 'Rènhé qǐyè zài wèi huòdé guójiā huánjìng bǎohù bùmén de zhèngshì páifàng xǔkě zhīqián, yánjìn shànzì kāigōng páifàng gōngyè fèishuǐ.',
    example_vi = 'Bất kỳ doanh nghiệp nào trước khi nhận được giấy phép xả thải chính thức từ cơ quan bảo vệ môi trường quốc gia đều bị nghiêm cấm tự tiện xả nước thải công nghiệp.'
WHERE id = '4b478efc-a5c8-43d8-bd86-cb11022b92e7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4b478efc-a5c8-43d8-bd86-cb11022b92e7', '任何企业在未获得国家环境保护部门的正式排放许可之前，严禁擅自开工排放工业废水。', 'Rènhé qǐyè zài wèi huòdé guójiā huánjìng bǎohù bùmén de zhèngshì páifàng xǔkě zhīqián, yánjìn shànzì kāigōng páifàng gōngyè fèishuǐ.', 'Bất kỳ doanh nghiệp nào trước khi nhận được giấy phép xả thải chính thức từ cơ quan bảo vệ môi trường quốc gia đều bị nghiêm cấm tự tiện xả nước thải công nghiệp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4b478efc-a5c8-43d8-bd86-cb11022b92e7'
);

-- [循环] (xún huán): tuần hoàn
UPDATE public.vocabularies
SET example_hanzi = '现代生态农业示范园区通过将农作物秸秆转化为生物有机肥，成功实现了资源的高效绿色循环。',
    example_pinyin = 'Xiàndài shēngtài nóngyè shìfàn yuánqū tōngguò jiāng nóngzuòwù jiēgǎn zhuǎnhuà wéi shēngwù yǒujīféi, chénggōng shíxiàn le zīyuán de gāoxiào lǜsè xúnhuán.',
    example_vi = 'Khu vườn mẫu nông nghiệp sinh thái hiện đại thông qua việc chuyển hóa rơm rạ cây trồng thành phân bón hữu cơ sinh học đã thực hiện thành công việc tuần hoàn xanh hiệu quả cao nguồn tài nguyên.'
WHERE id = '383794c6-6026-418b-8363-4d75c32a29b2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '383794c6-6026-418b-8363-4d75c32a29b2', '现代生态农业示范园区通过将农作物秸秆转化为生物有机肥，成功实现了资源的高效绿色循环。', 'Xiàndài shēngtài nóngyè shìfàn yuánqū tōngguò jiāng nóngzuòwù jiēgǎn zhuǎnhuà wéi shēngwù yǒujīféi, chénggōng shíxiàn le zīyuán de gāoxiào lǜsè xúnhuán.', 'Khu vườn mẫu nông nghiệp sinh thái hiện đại thông qua việc chuyển hóa rơm rạ cây trồng thành phân bón hữu cơ sinh học đã thực hiện thành công việc tuần hoàn xanh hiệu quả cao nguồn tài nguyên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '383794c6-6026-418b-8363-4d75c32a29b2'
);

-- [叙述] (xùshù): kể lại, thuật lại
UPDATE public.vocabularies
SET example_hanzi = '作者运用平实细腻的文字生动叙述了祖孙三代在时代大潮中的沧桑变迁与奋斗历程。',
    example_pinyin = 'Zuòzhě yùnyòng píngshí xìnì de wénzì shēngdòng xùshù le zǔsūn sāndài zài shídài dàcháo zhōng de cāngsāng biànqiān yǔ fèndòu lìchéng.',
    example_vi = 'Tác giả sử dụng câu chữ mộc mạc tinh tế kể lại một cách sinh động những biến thiên dâu bể và chặng đường phấn đấu của ba thế hệ ông cháu trong làn sóng thời đại.'
WHERE id = '2d910af8-3004-4f16-a49a-4c9b063fe341' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2d910af8-3004-4f16-a49a-4c9b063fe341', '作者运用平实细腻的文字生动叙述了祖孙三代在时代大潮中的沧桑变迁与奋斗历程。', 'Zuòzhě yùnyòng píngshí xìnì de wénzì shēngdòng xùshù le zǔsūn sāndài zài shídài dàcháo zhōng de cāngsāng biànqiān yǔ fèndòu lìchéng.', 'Tác giả sử dụng câu chữ mộc mạc tinh tế kể lại một cách sinh động những biến thiên dâu bể và chặng đường phấn đấu của ba thế hệ ông cháu trong làn sóng thời đại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2d910af8-3004-4f16-a49a-4c9b063fe341'
);

-- [亚军] (yàjūn): á quân, giải nhì
UPDATE public.vocabularies
SET example_hanzi = '在强手如林的国际女子排球锦标赛总决赛中，姑娘们顽强拼搏到底，虽屈居亚军仍旧赢得了国人的掌声。',
    example_pinyin = 'Zài qiángshǒu-rúlín de guójì nǚzǐ páiqiú jǐnbiāosài zǒngjuésài zhōng, gūniang men wánqiáng pīnbó dàodǐ, suī qūjū yàjūn réngjiù yíngdé le guórén de zhǎngshēng.',
    example_vi = 'Tại trận chung kết giải vô địch bóng chuyền nữ quốc tế đầy rẫy các đối thủ mạnh, các cô gái đã ngoan cường chiến đấu đến cùng, dù chỉ về nhì đoạt chức á quân nhưng vẫn nhận được tràng pháo tay của đồng bào.'
WHERE id = '3b7daa9e-d850-4f0a-ae5c-b239981b24d8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3b7daa9e-d850-4f0a-ae5c-b239981b24d8', '在强手如林的国际女子排球锦标赛总决赛中，姑娘们顽强拼搏到底，虽屈居亚军仍旧赢得了国人的掌声。', 'Zài qiángshǒu-rúlín de guójì nǚzǐ páiqiú jǐnbiāosài zǒngjuésài zhōng, gūniang men wánqiáng pīnbó dàodǐ, suī qūjū yàjūn réngjiù yíngdé le guórén de zhǎngshēng.', 'Tại trận chung kết giải vô địch bóng chuyền nữ quốc tế đầy rẫy các đối thủ mạnh, các cô gái đã ngoan cường chiến đấu đến cùng, dù chỉ về nhì đoạt chức á quân nhưng vẫn nhận được tràng pháo tay của đồng bào.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3b7daa9e-d850-4f0a-ae5c-b239981b24d8'
);

-- [严寒] (yán hán): giá rét, rét đậm
UPDATE public.vocabularies
SET example_hanzi = '哪怕是在零下四十度的极端严寒暴风雪天气下，边防战士们依然坚守在巡逻的第一线。',
    example_pinyin = 'Nǎpà shì zài língxià sìshí dù de jíduān yánhán bàofēngxuě tiānqì xià, biānfáng zhànshì men yīrán jiānshǒu zài xúnluó de dìyīxiàn.',
    example_vi = 'Dù cho là dưới thời tiết bão tuyết giá rét khắc nghiệt âm 40 độ, các chiến sĩ biên phòng vẫn kiên định bám trụ nơi tuyến đầu tuần tra.'
WHERE id = 'd016778c-d91b-47f7-83a5-35f1f8277307' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd016778c-d91b-47f7-83a5-35f1f8277307', '哪怕是在零下四十度的极端严寒暴风雪天气下，边防战士们依然坚守在巡逻的第一线。', 'Nǎpà shì zài língxià sìshí dù de jíduān yánhán bàofēngxuě tiānqì xià, biānfáng zhànshì men yīrán jiānshǒu zài xúnluó de dìyīxiàn.', 'Dù cho là dưới thời tiết bão tuyết giá rét khắc nghiệt âm 40 độ, các chiến sĩ biên phòng vẫn kiên định bám trụ nơi tuyến đầu tuần tra.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd016778c-d91b-47f7-83a5-35f1f8277307'
);

-- [严禁] (yán jìn): nghiêm cấm
UPDATE public.vocabularies
SET example_hanzi = '为了切实保障广大人民群众的生命财产安全，森林防火区域内严禁携带任何火种进入。',
    example_pinyin = 'Wèile qièshí bǎozhàng guǎngdà rénmín qúnzhòng de shēngmìng cáichǎn ānquán, sēnlín fánghuǒ qūyù nèi yánjìn xiédài rènhé huǒzhǒng jìnrù.',
    example_vi = 'Nhằm bảo đảm an toàn tính mạng và tài sản cho quần chúng nhân dân một cách thiết thực, trong khu vực phòng cháy rừng nghiêm cấm mang theo bất kỳ nguồn lửa nào vào trong.'
WHERE id = 'c7f24268-35e7-4f58-8471-c36e81bd50cc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c7f24268-35e7-4f58-8471-c36e81bd50cc', '为了切实保障广大人民群众的生命财产安全，森林防火区域内严禁携带任何火种进入。', 'Wèile qièshí bǎozhàng guǎngdà rénmín qúnzhòng de shēngmìng cáichǎn ānquán, sēnlín fánghuǒ qūyù nèi yánjìn xiédài rènhé huǒzhǒng jìnrù.', 'Nhằm bảo đảm an toàn tính mạng và tài sản cho quần chúng nhân dân một cách thiết thực, trong khu vực phòng cháy rừng nghiêm cấm mang theo bất kỳ nguồn lửa nào vào trong.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c7f24268-35e7-4f58-8471-c36e81bd50cc'
);

-- [严厉] (yán lì): nghiêm khắc, nghiêm trị
UPDATE public.vocabularies
SET example_hanzi = '司法机关坚决依法对危害食品药品的违法犯罪行为予以最为严厉的法律制裁与惩戒。',
    example_pinyin = 'Sīfǎ jīgòu jiānjué yīfǎ duì wēihài shípǐn yàopǐn de wéifǎ fànzuì xíngwéi yǔyǐ zuìwéi yánlì de fǎlǜ zhìcái yǔ chéngjiè.',
    example_vi = 'Cơ quan tư pháp kiên quyết áp dụng chế tài pháp luật và hình phạt nghiêm khắc trừng trị nhất theo đúng quy định đối với các hành vi tội phạm xâm hại an toàn thực phẩm thuốc men.'
WHERE id = '2dec6488-757b-43e2-9285-35afad9a087a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2dec6488-757b-43e2-9285-35afad9a087a', '司法机关坚决依法对危害食品药品的违法犯罪行为予以最为严厉的法律制裁与惩戒。', 'Sīfǎ jīgòu jiānjué yīfǎ duì wēihài shípǐn yàopǐn de wéifǎ fànzuì xíngwéi yǔyǐ zuìwéi yánlì de fǎlǜ zhìcái yǔ chéngjiè.', 'Cơ quan tư pháp kiên quyết áp dụng chế tài pháp luật và hình phạt nghiêm khắc trừng trị nhất theo đúng quy định đối với các hành vi tội phạm xâm hại an toàn thực phẩm thuốc men.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2dec6488-757b-43e2-9285-35afad9a087a'
);

-- [延期] (yán qī): hoãn lại, gia hạn
UPDATE public.vocabularies
SET example_hanzi = '鉴于恶劣强降雪天气导致机场跑道结冰严重，组委会决定将原定于今天召开的闭门研讨会延期举办。',
    example_pinyin = 'Jiànyú èliè qiáng jiàngxuě tiānqì dǎozhì jīchǎng pǎodào jiébīng yánzhòng, zǔwěihuì juédìng jiāng yuándìng yú jīntiān zhàokāi de bìmén yántǎohuì yánqī jǔbàn.',
    example_vi = 'Xét thấy thời tiết tuyết rơi dày đặc khiến đường băng sân bay đóng băng nghiêm trọng, ban tổ chức đã quyết định hoãn lại thời gian tổ chức buổi hội thảo kín dự định diễn ra hôm nay.'
WHERE id = '6358313f-0ec8-43cf-9f0a-5eea69060c1d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6358313f-0ec8-43cf-9f0a-5eea69060c1d', '鉴于恶劣强降雪天气导致机场跑道结冰严重，组委会决定将原定于今天召开的闭门研讨会延期举办。', 'Jiànyú èliè qiáng jiàngxuě tiānqì dǎozhì jīchǎng pǎodào jiébīng yánzhòng, zǔwěihuì juédìng jiāng yuándìng yú jīntiān zhàokāi de bìmén yántǎohuì yánqī jǔbàn.', 'Xét thấy thời tiết tuyết rơi dày đặc khiến đường băng sân bay đóng băng nghiêm trọng, ban tổ chức đã quyết định hoãn lại thời gian tổ chức buổi hội thảo kín dự định diễn ra hôm nay.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6358313f-0ec8-43cf-9f0a-5eea69060c1d'
);

-- [延伸] (yán shēn): kéo dài, mở rộng
UPDATE public.vocabularies
SET example_hanzi = '这条刚刚全线通车的高速铁路不仅方便了沿线百姓出行，更将经济辐射带进一步向内陆纵深延伸。',
    example_pinyin = 'Zhè tiáo gānggāng quánxiàn tōngchē de gāosù tiělù bùjǐn fāngbiàn le yánxiàn bǎixìng chūxíng, gèng jiāng jīngjì fúshèdài jìnyíbù xiàng nèilù zòngshēn yánshēn.',
    example_vi = 'Tuyến đường sắt cao tốc vừa mới thông xe toàn tuyến này không chỉ tạo thuận lợi cho người dân dọc tuyến đi lại, mà còn mở rộng vành đai lan tỏa kinh tế sâu hơn vào nội địa.'
WHERE id = '64e7d59d-2e28-4bae-b047-3e84f1697b6d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '64e7d59d-2e28-4bae-b047-3e84f1697b6d', '这条刚刚全线通车的高速铁路不仅方便了沿线百姓出行，更将经济辐射带进一步向内陆纵深延伸。', 'Zhè tiáo gānggāng quánxiàn tōngchē de gāosù tiělù bùjǐn fāngbiàn le yánxiàn bǎixìng chūxíng, gèng jiāng jīngjì fúshèdài jìnyíbù xiàng nèilù zòngshēn yánshēn.', 'Tuyến đường sắt cao tốc vừa mới thông xe toàn tuyến này không chỉ tạo thuận lợi cho người dân dọc tuyến đi lại, mà còn mở rộng vành đai lan tỏa kinh tế sâu hơn vào nội địa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '64e7d59d-2e28-4bae-b047-3e84f1697b6d'
);

-- [延续] (yán xù): kéo dài liên tục, tiếp nối
UPDATE public.vocabularies
SET example_hanzi = '优秀的中华优秀传统家风家训一代代薪火相传，在当代社会依然保持着强大的生命力并不断延续。',
    example_pinyin = 'Yōuxiù de zhōnghuá yōuxiù chuántǒng jiāfēng jiāxùn yídàidài xīnhuǒ-xiāngchuán, zài dāngdài shèhuì yīrán bǎochí zhe qiángdà de shēngmìnglì bìng bùduàn yánxù.',
    example_vi = 'Gia phong và gia huấn truyền thống ưu tú của Trung Hoa được truyền nối như ngọn lửa qua bao thế hệ, trong xã hội đương đại vẫn duy trì sức sống mãnh liệt và không ngừng tiếp nối kéo dài.'
WHERE id = 'd97122f2-432c-4337-88c4-f1723830e5ea' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd97122f2-432c-4337-88c4-f1723830e5ea', '优秀的中华优秀传统家风家训一代代薪火相传，在当代社会依然保持着强大的生命力并不断延续。', 'Yōuxiù de zhōnghuá yōuxiù chuántǒng jiāfēng jiāxùn yídàidài xīnhuǒ-xiāngchuán, zài dāngdài shèhuì yīrán bǎochí zhe qiángdà de shēngmìnglì bìng bùduàn yánxù.', 'Gia phong và gia huấn truyền thống ưu tú của Trung Hoa được truyền nối như ngọn lửa qua bao thế hệ, trong xã hội đương đại vẫn duy trì sức sống mãnh liệt và không ngừng tiếp nối kéo dài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd97122f2-432c-4337-88c4-f1723830e5ea'
);

-- [痒] (yǎng): ngứa
UPDATE public.vocabularies
SET example_hanzi = '夏天在户外草地上游玩时如果不小心被蚊虫叮咬，皮肤上红肿发痒的部位切忌用力抓挠。',
    example_pinyin = 'Xiàtiān zài hùwài cǎodì shang yóuwán shí rúguǒ bù xiǎoxīn bèi wénchóng dīngyǎo, pífū shang hóngzhǒng fā yǎng de bùwèi qièjì yònglì zhuānáo.',
    example_vi = 'Mùa hè khi vui chơi trên bãi cỏ ngoài trời nếu lỡ bị côn trùng muỗi cắn, chỗ da bị sưng đỏ phát ngứa tuyệt đối tránh cào gãi mạnh tay.'
WHERE id = 'ee4d5a02-423d-4d0a-846a-dedfc6843c77' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ee4d5a02-423d-4d0a-846a-dedfc6843c77', '夏天在户外草地上游玩时如果不小心被蚊虫叮咬，皮肤上红肿发痒的部位切忌用力抓挠。', 'Xiàtiān zài hùwài cǎodì shang yóuwán shí rúguǒ bù xiǎoxīn bèi wénchóng dīngyǎo, pífū shang hóngzhǒng fā yǎng de bùwèi qièjì yònglì zhuānáo.', 'Mùa hè khi vui chơi trên bãi cỏ ngoài trời nếu lỡ bị côn trùng muỗi cắn, chỗ da bị sưng đỏ phát ngứa tuyệt đối tránh cào gãi mạnh tay.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ee4d5a02-423d-4d0a-846a-dedfc6843c77'
);

-- [氧气] (yǎngqì): khí oxy
UPDATE public.vocabularies
SET example_hanzi = '登山队员在向海拔八千米以上的雪山极峰冲刺时，必须随身携带足量的医用应急便携氧气罐。',
    example_pinyin = 'Dēngshān duìyuán zài xiàng hǎibá bāqiān mǐ yǐshàng de xuěshān jí fēng chōngcì shí, bìxū suíshēn xiédài zúliàng de yīyòng yīngjí biànxié yǎngqìguàn.',
    example_vi = 'Các thành viên đội leo núi khi bứt tốc chinh phục đỉnh núi tuyết có độ cao trên 8.000 mét so với mực nước biển bắt buộc phải mang theo đầy đủ bình oxy y tế khẩn cấp xách tay bên mình.'
WHERE id = 'c0869a9c-d611-4b80-ab46-b062fdf26d75' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c0869a9c-d611-4b80-ab46-b062fdf26d75', '登山队员在向海拔八千米以上的雪山极峰冲刺时，必须随身携带足量的医用应急便携氧气罐。', 'Dēngshān duìyuán zài xiàng hǎibá bāqiān mǐ yǐshàng de xuěshān jí fēng chōngcì shí, bìxū suíshēn xiédài zúliàng de yīyòng yīngjí biànxié yǎngqìguàn.', 'Các thành viên đội leo núi khi bứt tốc chinh phục đỉnh núi tuyết có độ cao trên 8.000 mét so với mực nước biển bắt buộc phải mang theo đầy đủ bình oxy y tế khẩn cấp xách tay bên mình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c0869a9c-d611-4b80-ab46-b062fdf26d75'
);

-- [眼光] (yǎnguāng): ánh mắt, tầm nhìn
UPDATE public.vocabularies
SET example_hanzi = '一位真正杰出高明的战略投资家，总是以极具前瞻性的长远眼光去布局具有颠覆性的前沿科技赛道。',
    example_pinyin = 'Yí wèi zhēnzhèng jiéchū gāomíng de zhànlüè tóuzījiā, zǒngshì yǐ jíbǐng qiánzhānxìng de chángyuǎn yǎnguāng qù bùjú jùyǒu diānfùxìng de qiányán kējì sàidào.',
    example_vi = 'Một nhà đầu tư chiến lược thực sự kiệt xuất và cao minh luôn dùng tầm nhìn xa trông rộng mang tính đón đầu để bố trí vào các đường đua công nghệ đi đầu có tính đột phá thay đổi cục diện.'
WHERE id = '96b7b114-aa38-4c46-8e4b-f4f7cd891164' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '96b7b114-aa38-4c46-8e4b-f4f7cd891164', '一位真正杰出高明的战略投资家，总是以极具前瞻性的长远眼光去布局具有颠覆性的前沿科技赛道。', 'Yí wèi zhēnzhèng jiéchū gāomíng de zhànlüè tóuzījiā, zǒngshì yǐ jíbǐng qiánzhānxìng de chángyuǎn yǎnguāng qù bùjú jùyǒu diānfùxìng de qiányán kējì sàidào.', 'Một nhà đầu tư chiến lược thực sự kiệt xuất và cao minh luôn dùng tầm nhìn xa trông rộng mang tính đón đầu để bố trí vào các đường đua công nghệ đi đầu có tính đột phá thay đổi cục diện.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '96b7b114-aa38-4c46-8e4b-f4f7cd891164'
);

-- [沿海] (yánhǎi): ven biển, duyên hải
UPDATE public.vocabularies
SET example_hanzi = '作为我国改革开放的最前沿阵地，东部沿海经济特区在科技创新与对外贸易中扮演着领头羊的角色。',
    example_pinyin = 'Zuòwéi wǒguó gǎigé-kāifàng de zuì qiányán zhèndì, dōngbù yánhǎi jīngjì tèqū zài kējì chuàngxīn yǔ duìwài màoyì zhōng bànyǎn zhe lǐngtóuyáng de juésè.',
    example_vi = 'Là trận địa đi đầu trong công cuộc cải cách mở cửa của nước ta, các đặc khu kinh tế ven biển phía Đông đóng vai trò đầu tàu trong đổi mới công nghệ và thương mại đối ngoại.'
WHERE id = 'ac3b7955-cee1-4065-b107-00fed7fc50c7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ac3b7955-cee1-4065-b107-00fed7fc50c7', '作为我国改革开放的最前沿阵地，东部沿海经济特区在科技创新与对外贸易中扮演着领头羊的角色。', 'Zuòwéi wǒguó gǎigé-kāifàng de zuì qiányán zhèndì, dōngbù yánhǎi jīngjì tèqū zài kējì chuàngxīn yǔ duìwài màoyì zhōng bànyǎn zhe lǐngtóuyáng de juésè.', 'Là trận địa đi đầu trong công cuộc cải cách mở cửa của nước ta, các đặc khu kinh tế ven biển phía Đông đóng vai trò đầu tàu trong đổi mới công nghệ và thương mại đối ngoại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ac3b7955-cee1-4065-b107-00fed7fc50c7'
);

-- [宴会] (yànhuì): yến tiệc, tiệc
UPDATE public.vocabularies
SET example_hanzi = '为了热烈欢迎远道而来的外国元首代表团，国家大剧院多功能厅今晚举行了一场隆重优雅的国宾宴会。',
    example_pinyin = 'Wèile rèliè huānyíng yuǎndào''érlái de wàiguó yuánshǒu dàibiǎotuán, guójiā dà jùyuàn duō gōngnéng tīng jīnwǎn jǔxíng le yì chǎng lóngzhòng yōuyǎ de guóbīn yànhuì.',
    example_vi = 'Để nhiệt liệt hoan nghênh đoàn đại biểu nguyên thủ quốc gia nước ngoài từ phương xa tới, sảnh đa năng Nhà hát Lớn Quốc gia tối nay đã tổ chức một buổi quốc yến trang trọng tao nhã.'
WHERE id = 'f5525966-d318-4a8d-a713-b976c34e94aa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f5525966-d318-4a8d-a713-b976c34e94aa', '为了热烈欢迎远道而来的外国元首代表团，国家大剧院多功能厅今晚举行了一场隆重优雅的国宾宴会。', 'Wèile rèliè huānyíng yuǎndào''érlái de wàiguó yuánshǒu dàibiǎotuán, guójiā dà jùyuàn duō gōngnéng tīng jīnwǎn jǔxíng le yì chǎng lóngzhòng yōuyǎ de guóbīn yànhuì.', 'Để nhiệt liệt hoan nghênh đoàn đại biểu nguyên thủ quốc gia nước ngoài từ phương xa tới, sảnh đa năng Nhà hát Lớn Quốc gia tối nay đã tổ chức một buổi quốc yến trang trọng tao nhã.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f5525966-d318-4a8d-a713-b976c34e94aa'
);

-- [淹没] (yānmò): chìm ngập, nhấn chìm
UPDATE public.vocabularies
SET example_hanzi = '持续连降数日的百年不遇暴雨引发了山洪暴发，下游低洼地带的许多农田与村庄瞬间被洪水泥沙淹没。',
    example_pinyin = 'Chíxù liánjiàng shù rì de bǎinián-bùyù bàoyǔ yǐnfā le shānhóng bàofā, xiàyóu dīwā dìdài de xǔduō nóngtián yǔ cūnzhuāng shùnjiān bèi hóngshuǐ nǐshā yānmò.',
    example_vi = 'Mưa lớn trăm năm mới gặp liên tiếp kéo dài nhiều ngày đã gây ra lũ quét, nhiều cánh đồng và thôn bản tại vùng trũng thấp hạ lưu trong nháy mắt đã bị nước lũ bùn cát nhấn chìm ngập lụt.'
WHERE id = '74c45691-459e-4404-8bda-832240035bc0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '74c45691-459e-4404-8bda-832240035bc0', '持续连降数日的百年不遇暴雨引发了山洪暴发，下游低洼地带的许多农田与村庄瞬间被洪水泥沙淹没。', 'Chíxù liánjiàng shù rì de bǎinián-bùyù bàoyǔ yǐnfā le shānhóng bàofā, xiàyóu dīwā dìdài de xǔduō nóngtián yǔ cūnzhuāng shùnjiān bèi hóngshuǐ nǐshā yānmò.', 'Mưa lớn trăm năm mới gặp liên tiếp kéo dài nhiều ngày đã gây ra lũ quét, nhiều cánh đồng và thôn bản tại vùng trũng thấp hạ lưu trong nháy mắt đã bị nước lũ bùn cát nhấn chìm ngập lụt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '74c45691-459e-4404-8bda-832240035bc0'
);

-- [炎热] (yánrè): nóng bức, oi ả
UPDATE public.vocabularies
SET example_hanzi = '在盛夏炎热酷暑的骄阳炙烤之下，环卫工人们依然坚守岗位、挥洒汗水打扫着城市的街头巷尾。',
    example_pinyin = 'Zài shèngxià yánrè kùshǔ de jiāoyáng zhìkǎo zhīxià, huánwèi gōngrén men yīrán jiānshǒu gǎngwèi, huīsǎ hànshuǐ dǎsǎo zhe chéngshì de jiētóu-xiàngwěi.',
    example_vi = 'Dưới ánh nắng gay gắt thiêu đốt của mùa hè oi ả nóng bức, các công nhân vệ sinh môi trường vẫn kiên định bám trụ vị trí, đổ mồ hôi quét dọn từng ngõ ngách đầu đường thành phố.'
WHERE id = '73e09a1f-6e05-4887-b95d-4378d01f42b1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '73e09a1f-6e05-4887-b95d-4378d01f42b1', '在盛夏炎热酷暑的骄阳炙烤之下，环卫工人们依然坚守岗位、挥洒汗水打扫着城市的街头巷尾。', 'Zài shèngxià yánrè kùshǔ de jiāoyáng zhìkǎo zhīxià, huánwèi gōngrén men yīrán jiānshǒu gǎngwèi, huīsǎ hànshuǐ dǎsǎo zhe chéngshì de jiētóu-xiàngwěi.', 'Dưới ánh nắng gay gắt thiêu đốt của mùa hè oi ả nóng bức, các công nhân vệ sinh môi trường vẫn kiên định bám trụ vị trí, đổ mồ hôi quét dọn từng ngõ ngách đầu đường thành phố.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '73e09a1f-6e05-4887-b95d-4378d01f42b1'
);

-- [验证] (yànzhèng): kiểm chứng, xác minh
UPDATE public.vocabularies
SET example_hanzi = '科学家提出的这一崭新物理假说，最终在欧洲大型强子对撞机的高能粒子实验中得到了确凿验证。',
    example_pinyin = 'Kēxuéjiā tíchū de zhè yì zhǎnxīn wùlǐ jiǎshuō, zuìzhōng zài Ōuzhōu dàxíng qiángzǐ duìzhuàngjī de gāonéng lìzǐ shíyàn zhōng dédào le quèzáo yànzhèng.',
    example_vi = 'Giả thuyết vật lý hoàn toàn mới do nhà khoa học đề xuất cuối cùng đã được kiểm chứng xác thực trong thí nghiệm hạt năng lượng cao trên máy gia tốc hạt lớn châu Âu.'
WHERE id = 'e242de6e-f747-47e0-9c82-c77ea976fcd7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e242de6e-f747-47e0-9c82-c77ea976fcd7', '科学家提出的这一崭新物理假说，最终在欧洲大型强子对撞机的高能粒子实验中得到了确凿验证。', 'Kēxuéjiā tíchū de zhè yì zhǎnxīn wùlǐ jiǎshuō, zuìzhōng zài Ōuzhōu dàxíng qiángzǐ duìzhuàngjī de gāonéng lìzǐ shíyàn zhōng dédào le quèzáo yànzhèng.', 'Giả thuyết vật lý hoàn toàn mới do nhà khoa học đề xuất cuối cùng đã được kiểm chứng xác thực trong thí nghiệm hạt năng lượng cao trên máy gia tốc hạt lớn châu Âu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e242de6e-f747-47e0-9c82-c77ea976fcd7'
);

-- [演奏] (yǎnzòu): diễn tấu, trình diễn nhạc
UPDATE public.vocabularies
SET example_hanzi = '著名交响乐团在维也纳金色大厅为全球音乐爱好者们深情演奏了贝多芬第九交响曲《欢乐颂》。',
    example_pinyin = 'Zhùmíng jiāoxiǎng yuètuán zài Wéiyěnà jīnsè dàtīng wèi quánqiú yīnyuè àihàozhě men shēnqíng yǎnzòu le Bèiduōfēn dì jiǔ jiāoxiǎngqǔ 《Huānlè Sòng》.',
    example_vi = 'Dàn nhạc giao hưởng danh tiếng đã biểu diễn diễn tấu bản Giao hưởng số 9 ''Khải hoàn ca'' của Beethoven đầy truyền cảm tại Đại sảnh Vàng Vienna cho giới yêu âm nhạc toàn cầu.'
WHERE id = '65691b6c-abd1-4d1c-bb1a-ad479d77bfdb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '65691b6c-abd1-4d1c-bb1a-ad479d77bfdb', '著名交响乐团在维也纳金色大厅为全球音乐爱好者们深情演奏了贝多芬第九交响曲《欢乐颂》。', 'Zhùmíng jiāoxiǎng yuètuán zài Wéiyěnà jīnsè dàtīng wèi quánqiú yīnyuè àihàozhě men shēnqíng yǎnzòu le Bèiduōfēn dì jiǔ jiāoxiǎngqǔ 《Huānlè Sòng》.', 'Dàn nhạc giao hưởng danh tiếng đã biểu diễn diễn tấu bản Giao hưởng số 9 ''Khải hoàn ca'' của Beethoven đầy truyền cảm tại Đại sảnh Vàng Vienna cho giới yêu âm nhạc toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '65691b6c-abd1-4d1c-bb1a-ad479d77bfdb'
);

-- [要点] (yàodiǎn): điểm trọng yếu, điểm chính
UPDATE public.vocabularies
SET example_hanzi = '在期末高难度综合考试冲刺前夕，任课教授在辅导课上高屋建瓴地梳理归纳了整门课程的核心复习要点。',
    example_pinyin = 'Zài qīmò gāonándù zōnghé kǎoshì chōngcì qiánxī, rènkè jiàoshòu zài fǔdǎokè shang gāowū-jiànlíng de shūlǐ guīnà le zhěng mén kèchéng de héxīn fùxí yàodiǎn.',
    example_vi = 'Trước thềm bứt tốc ôn thi tổng hợp cuối kỳ độ khó cao, giáo sư phụ trách lớp đã khái quát tổng hợp lại các điểm trọng yếu ôn tập cốt lõi của toàn bộ học phần trong buổi phụ đạo.'
WHERE id = '14fc9098-72f9-49f0-b9a1-c9dffb2590a3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '14fc9098-72f9-49f0-b9a1-c9dffb2590a3', '在期末高难度综合考试冲刺前夕，任课教授在辅导课上高屋建瓴地梳理归纳了整门课程的核心复习要点。', 'Zài qīmò gāonándù zōnghé kǎoshì chōngcì qiánxī, rènkè jiàoshòu zài fǔdǎokè shang gāowū-jiànlíng de shūlǐ guīnà le zhěng mén kèchéng de héxīn fùxí yàodiǎn.', 'Trước thềm bứt tốc ôn thi tổng hợp cuối kỳ độ khó cao, giáo sư phụ trách lớp đã khái quát tổng hợp lại các điểm trọng yếu ôn tập cốt lõi của toàn bộ học phần trong buổi phụ đạo.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '14fc9098-72f9-49f0-b9a1-c9dffb2590a3'
);

-- [要素] (yàosù): yếu tố
UPDATE public.vocabularies
SET example_hanzi = '人才、资本、技术与数据是驱动现代高新科技产业蓬勃发展、实现高质量跃升不可或缺的四大核心要素。',
    example_pinyin = 'Réncái, zīběn, jìshù yǔ shùjù shì qūdòng xiàndài gāoxīn kējì chǎnyè péngbó fāzhǎn, shíxiàn gāo zhìliàng yuèshēng bùkě huòquē de sì dà héxīn yàosù.',
    example_vi = 'Nhân tài, tư bản, công nghệ và dữ liệu là bốn yếu tố cốt lõi không thể thiếu thúc đẩy ngành công nghệ cao hiện đại phát triển bừng bừng và hiện thực hóa bước nhảy vọt chất lượng cao.'
WHERE id = '42875f3e-174b-4386-b709-da1998a6e523' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '42875f3e-174b-4386-b709-da1998a6e523', '人才、资本、技术与数据是驱动现代高新科技产业蓬勃发展、实现高质量跃升不可或缺的四大核心要素。', 'Réncái, zīběn, jìshù yǔ shùjù shì qūdòng xiàndài gāoxīn kējì chǎnyè péngbó fāzhǎn, shíxiàn gāo zhìliàng yuèshēng bùkě huòquē de sì dà héxīn yàosù.', 'Nhân tài, tư bản, công nghệ và dữ liệu là bốn yếu tố cốt lõi không thể thiếu thúc đẩy ngành công nghệ cao hiện đại phát triển bừng bừng và hiện thực hóa bước nhảy vọt chất lượng cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '42875f3e-174b-4386-b709-da1998a6e523'
);

-- [遥远] (yáoyuǎn): xa xôi
UPDATE public.vocabularies
SET example_hanzi = '虽然他的家乡地处祖国遥远偏僻的西北边陲小村，但他始终心系故土并经常捐资兴建乡村小学。',
    example_pinyin = 'Suīrán tā de jiāxiāng dìchǔ zǔguó yáoyuǎn piānpì de xīběi biānchuí xiǎocūn, dàn tā shǐzhōng xīnxì gùtǔ bìng jīngcháng juānzī xīngjiàn xiāngcūn xiǎoxué.',
    example_vi = 'Mặc dù quê hương của ông nằm ở một ngôi làng nhỏ nơi biên thùy Tây Bắc xa xôi hẻo lánh của Tổ quốc, nhưng ông luôn hướng về quê cha và thường xuyên quyên góp xây dựng trường tiểu học nông thôn.'
WHERE id = '6b0d178f-4660-4cb4-8666-3fc9a107e6da' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6b0d178f-4660-4cb4-8666-3fc9a107e6da', '虽然他的家乡地处祖国遥远偏僻的西北边陲小村，但他始终心系故土并经常捐资兴建乡村小学。', 'Suīrán tā de jiāxiāng dìchǔ zǔguó yáoyuǎn piānpì de xīběi biānchuí xiǎocūn, dàn tā shǐzhōng xīnxì gùtǔ bìng jīngcháng juānzī xīngjiàn xiāngcūn xiǎoxué.', 'Mặc dù quê hương của ông nằm ở một ngôi làng nhỏ nơi biên thùy Tây Bắc xa xôi hẻo lánh của Tổ quốc, nhưng ông luôn hướng về quê cha và thường xuyên quyên góp xây dựng trường tiểu học nông thôn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6b0d178f-4660-4cb4-8666-3fc9a107e6da'
);

-- [压缩] (yāsuō): nén, rút gọn
UPDATE public.vocabularies
SET example_hanzi = '为了进一步提高办公运转效率，市政府通过数字化审批流程将项目立项审批周期压缩了三分之二。',
    example_pinyin = 'Wèile jìnyíbù tígāo bàngōng yùnzhuǎn xiàolǜ, shìzhèngfǔ tōngguò shùzìhuà shěnpī liúchéng jiāng xiàngmù lìxiàng shěnpī zhōuqī yāsuō le sān fēn zhī èr.',
    example_vi = 'Để nâng cao hơn nữa hiệu suất vận hành công sở, chính quyền thành phố thông qua quy trình phê duyệt số hóa đã rút gọn nén chu kỳ phê duyệt lập dự án xuống hai phần ba.'
WHERE id = '7ad44a08-5457-4f69-9442-5c04611864c3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7ad44a08-5457-4f69-9442-5c04611864c3', '为了进一步提高办公运转效率，市政府通过数字化审批流程将项目立项审批周期压缩了三分之二。', 'Wèile jìnyíbù tígāo bàngōng yùnzhuǎn xiàolǜ, shìzhèngfǔ tōngguò shùzìhuà shěnpī liúchéng jiāng xiàngmù lìxiàng shěnpī zhōuqī yāsuō le sān fēn zhī èr.', 'Để nâng cao hơn nữa hiệu suất vận hành công sở, chính quyền thành phố thông qua quy trình phê duyệt số hóa đã rút gọn nén chu kỳ phê duyệt lập dự án xuống hai phần ba.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7ad44a08-5457-4f69-9442-5c04611864c3'
);

-- [液体] (yètǐ): chất lỏng
UPDATE public.vocabularies
SET example_hanzi = '化学科研人员在做剧烈放热实验时必须穿戴防护面罩，以严防具有强腐蚀性的酸性液体意外飞溅。',
    example_pinyin = 'Huàxué kēyán rényuán zài zuò jùliè fàngrè shíyàn shí bìxū chuāndài fánghù miànzhào, yǐ yánfáng jùyǒu qiáng fǔshíxìng de suānxìng yètǐ yìwài fēijiàn.',
    example_vi = 'Các nhân viên nghiên cứu hóa học khi làm thí nghiệm tỏa nhiệt mãnh liệt bắt buộc phải đeo mặt nạ bảo hộ nhằm nghiêm ngặt đề phòng chất lỏng có tính axit ăn mòn mạnh bất ngờ bắn vào.'
WHERE id = 'd158ec46-fb91-40ab-9ca6-67479734e3a1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd158ec46-fb91-40ab-9ca6-67479734e3a1', '化学科研人员在做剧烈放热实验时必须穿戴防护面罩，以严防具有强腐蚀性的酸性液体意外飞溅。', 'Huàxué kēyán rényuán zài zuò jùliè fàngrè shíyàn shí bìxū chuāndài fánghù miànzhào, yǐ yánfáng jùyǒu qiáng fǔshíxìng de suānxìng yètǐ yìwài fēijiàn.', 'Các nhân viên nghiên cứu hóa học khi làm thí nghiệm tỏa nhiệt mãnh liệt bắt buộc phải đeo mặt nạ bảo hộ nhằm nghiêm ngặt đề phòng chất lỏng có tính axit ăn mòn mạnh bất ngờ bắn vào.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd158ec46-fb91-40ab-9ca6-67479734e3a1'
);

-- [异常] (yì cháng): bất thường, vô cùng
UPDATE public.vocabularies
SET example_hanzi = '大型数据监控中心的工作人员凭借敏锐的专业直觉，在第一时间准确捕捉到了服务器网络流量的异常波动。',
    example_pinyin = 'Dàxíng shùjù jiānkòng zhōngxīn de gōngzuò rényuán píngjiè mǐnruì de zhuānyè zhíjué, zài dìyī shíjiān zhǔnquè bǔzhuō dào le fúwùqì wǎngluò liúliàng de yìcháng bōdòng.',
    example_vi = 'Nhân viên làm việc tại trung tâm giám sát dữ liệu cỡ lớn dựa vào trực giác chuyên môn nhạy bén đã kịp thời bắt trọn biến động bất thường của lưu lượng mạng máy chủ ngay từ thời khắc đầu tiên.'
WHERE id = 'e5df6282-da92-4ac6-99ac-4acecaf3f413' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e5df6282-da92-4ac6-99ac-4acecaf3f413', '大型数据监控中心的工作人员凭借敏锐的专业直觉，在第一时间准确捕捉到了服务器网络流量的异常波动。', 'Dàxíng shùjù jiānkòng zhōngxīn de gōngzuò rényuán píngjiè mǐnruì de zhuānyè zhíjué, zài dìyī shíjiān zhǔnquè bǔzhuō dào le fúwùqì wǎngluò liúliàng de yìcháng bōdòng.', 'Nhân viên làm việc tại trung tâm giám sát dữ liệu cỡ lớn dựa vào trực giác chuyên môn nhạy bén đã kịp thời bắt trọn biến động bất thường của lưu lượng mạng máy chủ ngay từ thời khắc đầu tiên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e5df6282-da92-4ac6-99ac-4acecaf3f413'
);

-- [一帆风顺] (yì fān fēng shùn): thuận buồm xuôi gió
UPDATE public.vocabularies
SET example_hanzi = '人生的漫长旅途绝不可能永远是一帆风顺的坦途，唯有直面风雨坎坷才能铸就非凡坚毅的人格。',
    example_pinyin = 'Rénshēng de màncháng lǚtú jué bù kěnéng yǒngyuǎn shì yìfān-fēngshùn de tǎntú, wéiyǒu zhímiàn fēngyǔ kǎnkě cáinéng zhùjiù fēifán jiānyì de réngé.',
    example_vi = 'Chặng đường dài của đời người tuyệt đối không thể nào mãi là con đường bằng phẳng thuận buồm xuôi gió, chỉ có trực diện với mưa gió gập ghềnh mới đúc kết nên nhân cách kiên định phi thường.'
WHERE id = '69efaa2e-41eb-4ad3-9e1a-98c5a4097a30' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '69efaa2e-41eb-4ad3-9e1a-98c5a4097a30', '人生的漫长旅途绝不可能永远是一帆风顺的坦途，唯有直面风雨坎坷才能铸就非凡坚毅的人格。', 'Rénshēng de màncháng lǚtú jué bù kěnéng yǒngyuǎn shì yìfān-fēngshùn de tǎntú, wéiyǒu zhímiàn fēngyǔ kǎnkě cáinéng zhùjiù fēifán jiānyì de réngé.', 'Chặng đường dài của đời người tuyệt đối không thể nào mãi là con đường bằng phẳng thuận buồm xuôi gió, chỉ có trực diện với mưa gió gập ghềnh mới đúc kết nên nhân cách kiên định phi thường.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '69efaa2e-41eb-4ad3-9e1a-98c5a4097a30'
);

-- [一贯] (yí guàn): nhất quán, trước sau như một
UPDATE public.vocabularies
SET example_hanzi = '在国际交往事务中，我国始终恪守和平共处五项原则，这是一贯坚持且绝不动摇的外交基本方针。',
    example_pinyin = 'Zài guójì jiāowǎng shìwù zhōng, wǒguó shǐzhōng kèshǒu hépíng gòngchǔ wǔ xiàng yuánzé, zhè shì yíguàn jiānchí qiě jué bú dòngyáo de wàijiāo jīběn fāngzhēn.',
    example_vi = 'Trong các công việc giao lưu quốc tế, nước ta luôn tuân thủ Năm nguyên tắc cùng tồn tại hòa bình, đây là phương châm ngoại giao cơ bản nhất quán kiên trì và tuyệt đối không lay chuyển.'
WHERE id = '57fc7819-b3e5-4dfc-bf19-aef113ff8413' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '57fc7819-b3e5-4dfc-bf19-aef113ff8413', '在国际交往事务中，我国始终恪守和平共处五项原则，这是一贯坚持且绝不动摇的外交基本方针。', 'Zài guójì jiāowǎng shìwù zhōng, wǒguó shǐzhōng kèshǒu hépíng gòngchǔ wǔ xiàng yuánzé, zhè shì yíguàn jiānchí qiě jué bú dòngyáo de wàijiāo jīběn fāngzhēn.', 'Trong các công việc giao lưu quốc tế, nước ta luôn tuân thủ Năm nguyên tắc cùng tồn tại hòa bình, đây là phương châm ngoại giao cơ bản nhất quán kiên trì và tuyệt đối không lay chuyển.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '57fc7819-b3e5-4dfc-bf19-aef113ff8413'
);

-- [一流] (yī liú): hàng đầu, bậc nhất
UPDATE public.vocabularies
SET example_hanzi = '这所享誉全球的高等学府不仅拥有国际一流的师资与科研实验平台，更为全球培养了无数杰出栋梁。',
    example_pinyin = 'Zhè suǒ xiǎngyù quánqiú de gāoděng xuéfǔ bùjǐn yōngyǒu guójì yīliú de shīzī yǔ kēyán shíyàn píngtái, gèng wèi quánqiú péiyǎng le wúshù jiéchū dòngliáng.',
    example_vi = 'Ngôi trường đại học danh tiếng toàn cầu này không chỉ sở hữu đội ngũ giảng viên và nền tảng thí nghiệm nghiên cứu khoa học bậc nhất quốc tế, mà còn đào tạo cho thế giới vô số bậc nhân tài rường cột.'
WHERE id = 'a6dd753d-bb09-4283-a2ba-69f3f2b63d6a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a6dd753d-bb09-4283-a2ba-69f3f2b63d6a', '这所享誉全球的高等学府不仅拥有国际一流的师资与科研实验平台，更为全球培养了无数杰出栋梁。', 'Zhè suǒ xiǎngyù quánqiú de gāoděng xuéfǔ bùjǐn yōngyǒu guójì yīliú de shīzī yǔ kēyán shíyàn píngtái, gèng wèi quánqiú péiyǎng le wúshù jiéchū dòngliáng.', 'Ngôi trường đại học danh tiếng toàn cầu này không chỉ sở hữu đội ngũ giảng viên và nền tảng thí nghiệm nghiên cứu khoa học bậc nhất quốc tế, mà còn đào tạo cho thế giới vô số bậc nhân tài rường cột.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a6dd753d-bb09-4283-a2ba-69f3f2b63d6a'
);

-- [一向] (yí xiàng): từ trước đến nay, xưa nay
UPDATE public.vocabularies
SET example_hanzi = '这位老科学家为人谦逊低调、治学严谨求实，在学术界同行与历届学生心目中一向享有极高口碑。',
    example_pinyin = 'Zhè wèi lǎo kēxuéjiā wéirén qiānxùn dīdiào, zhìxué yánjǐn qiúshí, zài xuéshùjiè tóngháng yǔ lìjiè xuésheng xīnmù zhōng yíxiàng xiǎngyǒu jígāo kǒubēi.',
    example_vi = 'Nhà khoa học lão thành này đối nhân xử thế khiêm tốn kín tiếng, nghiên cứu nghiêm cẩn cầu thị, từ trước đến nay luôn được hưởng danh tiếng truyền miệng cực cao trong lòng đồng nghiệp học thuật và các khóa học trò.'
WHERE id = '0c2fdfde-f146-4e24-b2e2-d231d3d32354' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0c2fdfde-f146-4e24-b2e2-d231d3d32354', '这位老科学家为人谦逊低调、治学严谨求实，在学术界同行与历届学生心目中一向享有极高口碑。', 'Zhè wèi lǎo kēxuéjiā wéirén qiānxùn dīdiào, zhìxué yánjǐn qiúshí, zài xuéshùjiè tóngháng yǔ lìjiè xuésheng xīnmù zhōng yíxiàng xiǎngyǒu jígāo kǒubēi.', 'Nhà khoa học lão thành này đối nhân xử thế khiêm tốn kín tiếng, nghiên cứu nghiêm cẩn cầu thị, từ trước đến nay luôn được hưởng danh tiếng truyền miệng cực cao trong lòng đồng nghiệp học thuật và các khóa học trò.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0c2fdfde-f146-4e24-b2e2-d231d3d32354'
);

-- [一辈子] (yíbèizi): cả đời, suốt đời
UPDATE public.vocabularies
SET example_hanzi = '这位乡村女教师在偏远贫困大山深处默默无闻奉献了一辈子，用知识的光芒改变了无数穷苦山里孩子的命运。',
    example_pinyin = 'Zhè wèi xiāngcūn nǚ jiàoshī zài piānyuǎn pínhán dàshān shēncù mòmò-wúwén fèngxiàn le yíbèizi, yòng zhīshi de guāngmáng gǎibiàn le wúshù qióngkǔ shānlǐ háizi de mìngyùn.',
    example_vi = 'Cô giáo làng này đã thầm lặng cống hiến suốt cả một đời nơi hẻo lánh sâu trong núi non nghèo khó, dùng ánh sáng tri thức thay đổi số phận của biết bao đứa trẻ nghèo nơi miền núi.'
WHERE id = 'd6911fca-e301-4cba-b4e6-4806d7ef7487' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd6911fca-e301-4cba-b4e6-4806d7ef7487', '这位乡村女教师在偏远贫困大山深处默默无闻奉献了一辈子，用知识的光芒改变了无数穷苦山里孩子的命运。', 'Zhè wèi xiāngcūn nǚ jiàoshī zài piānyuǎn pínhán dàshān shēncù mòmò-wúwén fèngxiàn le yíbèizi, yòng zhīshi de guāngmáng gǎibiàn le wúshù qióngkǔ shānlǐ háizi de mìngyùn.', 'Cô giáo làng này đã thầm lặng cống hiến suốt cả một đời nơi hẻo lánh sâu trong núi non nghèo khó, dùng ánh sáng tri thức thay đổi số phận của biết bao đứa trẻ nghèo nơi miền núi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd6911fca-e301-4cba-b4e6-4806d7ef7487'
);

-- [以便] (yǐbiàn): để, nhằm thuận tiện
UPDATE public.vocabularies
SET example_hanzi = '会务组织方提前在官方网站发布了详细的会议日程与交通指南，以便参会代表提前做好行程规划。',
    example_pinyin = 'Huìwù zǔzhīfāng tíqián zài guānfāng wǎngzhàn fābù le xiángxì de huìyì rìchéng yǔ jiāotōng zhǐnán, yǐbiàn cānhuì dàibiǎo tíqián zuò hǎo xíngchéng guīhuà.',
    example_vi = 'Đơn vị tổ chức hội nghị đã công bố sớm lịch trình hội nghị và hướng dẫn giao thông chi tiết trên website chính thức để các đại biểu tham dự chuẩn bị tốt kế hoạch lịch trình từ trước.'
WHERE id = 'ab51c900-2820-4977-ab39-cc43eafc7cde' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ab51c900-2820-4977-ab39-cc43eafc7cde', '会务组织方提前在官方网站发布了详细的会议日程与交通指南，以便参会代表提前做好行程规划。', 'Huìwù zǔzhīfāng tíqián zài guānfāng wǎngzhàn fābù le xiángxì de huìyì rìchéng yǔ jiāotōng zhǐnán, yǐbiàn cānhuì dàibiǎo tíqián zuò hǎo xíngchéng guīhuà.', 'Đơn vị tổ chức hội nghị đã công bố sớm lịch trình hội nghị và hướng dẫn giao thông chi tiết trên website chính thức để các đại biểu tham dự chuẩn bị tốt kế hoạch lịch trình từ trước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ab51c900-2820-4977-ab39-cc43eafc7cde'
);

-- [遗产] (yíchǎn): di sản
UPDATE public.vocabularies
SET example_hanzi = '长城和故宫作为举世瞩目的世界文化遗产，不仅承载着中华民族的精神脊梁，也是人类共同的璀璨瑰宝。',
    example_pinyin = 'Chángchéng hé Gùgōng zuòwéi jǔshì-zhǔmù de shìjiè wénhuà yíchǎn, bùjǐn chéngzài zhe zhōnghuá mínzú de jīngshén jǐliáng, yě shì rénlèi gòngtóng de cuǐcàn guībǎo.',
    example_vi = 'Trường Thành và Cố Cung với tư cách là di sản văn hóa thế giới được toàn nhân loại dõi theo, không chỉ gánh vác rường cột tinh thần của dân tộc Trung Hoa mà còn là bảo vật rực rỡ chung của toàn loài người.'
WHERE id = 'dafd81f3-ce5b-451f-8258-59eef97185a8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dafd81f3-ce5b-451f-8258-59eef97185a8', '长城和故宫作为举世瞩目的世界文化遗产，不仅承载着中华民族的精神脊梁，也是人类共同的璀璨瑰宝。', 'Chángchéng hé Gùgōng zuòwéi jǔshì-zhǔmù de shìjiè wénhuà yíchǎn, bùjǐn chéngzài zhe zhōnghuá mínzú de jīngshén jǐliáng, yě shì rénlèi gòngtóng de cuǐcàn guībǎo.', 'Trường Thành và Cố Cung với tư cách là di sản văn hóa thế giới được toàn nhân loại dõi theo, không chỉ gánh vác rường cột tinh thần của dân tộc Trung Hoa mà còn là bảo vật rực rỡ chung của toàn loài người.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dafd81f3-ce5b-451f-8258-59eef97185a8'
);

-- [遗传] (yíchuán): di truyền
UPDATE public.vocabularies
SET example_hanzi = '现代分子生物学研究表明，许多复杂疾病的发病几率与人类个体的基因突变和家族遗传密码密切相关。',
    example_pinyin = 'Xiàndài fēnzǐ shēngwùxué yánjiū biǎomíng, xǔduō fùzá jíbìng de fābìng jīlǜ yǔ rénlèi gètǐ de jīyīn tūbiàn hé jiāzú yíchuán mìmǎ mìqiè xiāngguān.',
    example_vi = 'Nghiên cứu sinh học phân tử hiện đại chứng minh rằng, xác suất phát bệnh của nhiều chứng bệnh phức tạp có liên quan mật thiết đến đột biến gen của cá thể con người và mã di truyền dòng họ.'
WHERE id = '766abba8-91d8-4335-ae21-996b71754521' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '766abba8-91d8-4335-ae21-996b71754521', '现代分子生物学研究表明，许多复杂疾病的发病几率与人类个体的基因突变和家族遗传密码密切相关。', 'Xiàndài fēnzǐ shēngwùxué yánjiū biǎomíng, xǔduō fùzá jíbìng de fābìng jīlǜ yǔ rénlèi gètǐ de jīyīn tūbiàn hé jiāzú yíchuán mìmǎ mìqiè xiāngguān.', 'Nghiên cứu sinh học phân tử hiện đại chứng minh rằng, xác suất phát bệnh của nhiều chứng bệnh phức tạp có liên quan mật thiết đến đột biến gen của cá thể con người và mã di truyền dòng họ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '766abba8-91d8-4335-ae21-996b71754521'
);

-- [疑惑] (yíhuò): nghi ngờ, hoài nghi
UPDATE public.vocabularies
SET example_hanzi = '面对复杂的数学难题与同学们的重重困惑，支教老师通过深入浅出的生动板书耐心解开了大家心中的疑惑。',
    example_pinyin = 'Miànduì fùzá de shùxué nántí yǔ tóngxué men de chóngchóng kùnhuò, zhījiào lǎoshī tōngguò shēnrù-qiǎnchū de shēngdòng bǎnshū nàixīn jiěkāi le dàjiā xīnzhōng de yíhuò.',
    example_vi = 'Đối diện với bài toán học khó phức tạp và muôn vàn trăn trở của học sinh, thầy giáo tình nguyện qua nét chữ bảng sinh động dễ hiểu đã kiên nhẫn tháo gỡ mối nghi ngờ hoài nghi trong lòng mọi người.'
WHERE id = '324b6caa-4c54-4bef-9269-e599482235a3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '324b6caa-4c54-4bef-9269-e599482235a3', '面对复杂的数学难题与同学们的重重困惑，支教老师通过深入浅出的生动板书耐心解开了大家心中的疑惑。', 'Miànduì fùzá de shùxué nántí yǔ tóngxué men de chóngchóng kùnhuò, zhījiào lǎoshī tōngguò shēnrù-qiǎnchū de shēngdòng bǎnshū nàixīn jiěkāi le dàjiā xīnzhōng de yíhuò.', 'Đối diện với bài toán học khó phức tạp và muôn vàn trăn trở của học sinh, thầy giáo tình nguyện qua nét chữ bảng sinh động dễ hiểu đã kiên nhẫn tháo gỡ mối nghi ngờ hoài nghi trong lòng mọi người.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '324b6caa-4c54-4bef-9269-e599482235a3'
);

-- [依旧] (yījiù): vẫn như cũ, như xưa
UPDATE public.vocabularies
SET example_hanzi = '尽管离开了母校已有整整三十个春秋，但在白发苍苍的老校友心中，未名湖畔的朗朗书声依旧清晰可辨。',
    example_pinyin = 'Jǐnguǎn líkāi le mǔxiào yǐ yǒu zhěngzhěng sānshí gè chūnqiū, dàn zài báfà-cāngcāng de lǎo xiàoyǒu xīnzhōng, wèimíng húpàn de lǎnglǎng shūshēng yījiù qīngxī-kěbiàn.',
    example_vi = 'Dẫu rằng đã rời xa mái trường cũ tròn ba mươi mùa xuân thu, nhưng trong lòng cựu học sinh tóc hoa râm, tiếng đọc sách sang sảng bên bờ hồ Vị Minh vẫn như xưa rõ ràng nghe rõ.'
WHERE id = '07f437fc-6a11-4a94-b390-90311fb513d7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '07f437fc-6a11-4a94-b390-90311fb513d7', '尽管离开了母校已有整整三十个春秋，但在白发苍苍的老校友心中，未名湖畔的朗朗书声依旧清晰可辨。', 'Jǐnguǎn líkāi le mǔxiào yǐ yǒu zhěngzhěng sānshí gè chūnqiū, dàn zài báfà-cāngcāng de lǎo xiàoyǒu xīnzhōng, wèimíng húpàn de lǎnglǎng shūshēng yījiù qīngxī-kěbiàn.', 'Dẫu rằng đã rời xa mái trường cũ tròn ba mươi mùa xuân thu, nhưng trong lòng cựu học sinh tóc hoa râm, tiếng đọc sách sang sảng bên bờ hồ Vị Minh vẫn như xưa rõ ràng nghe rõ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '07f437fc-6a11-4a94-b390-90311fb513d7'
);

-- [依赖] (yīlài): phụ thuộc, ỷ lại
UPDATE public.vocabularies
SET example_hanzi = '核心技术是买不来也求不来的，高科技企业唯有坚持自立自强，才能彻底摆脱对国外关键元器件的技术依赖。',
    example_pinyin = 'Héxīn jìshù shì mǎi bù lái yě qiú bù lái de, gāokējì qǐyè wéiyǒu jiānchí zìlì-zìqiáng, cáinéng chèdǐ bǎituō duì guówài guānjiàn yuánqìjiàn de jìshù yīlài.',
    example_vi = 'Công nghệ cốt lõi không thể mua cũng chẳng thể cầu xin mà có, doanh nghiệp công nghệ cao chỉ có kiên trì tự lực tự cường mới có thể thoát khỏi hoàn toàn sự phụ thuộc ỷ lại công nghệ vào linh kiện then chốt của nước ngoài.'
WHERE id = '9bc7400a-0a22-4e3b-9500-5e566bd1246e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9bc7400a-0a22-4e3b-9500-5e566bd1246e', '核心技术是买不来也求不来的，高科技企业唯有坚持自立自强，才能彻底摆脱对国外关键元器件的技术依赖。', 'Héxīn jìshù shì mǎi bù lái yě qiú bù lái de, gāokējì qǐyè wéiyǒu jiānchí zìlì-zìqiáng, cáinéng chèdǐ bǎituō duì guówài guānjiàn yuánqìjiàn de jìshù yīlài.', 'Công nghệ cốt lõi không thể mua cũng chẳng thể cầu xin mà có, doanh nghiệp công nghệ cao chỉ có kiên trì tự lực tự cường mới có thể thoát khỏi hoàn toàn sự phụ thuộc ỷ lại công nghệ vào linh kiện then chốt của nước ngoài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9bc7400a-0a22-4e3b-9500-5e566bd1246e'
);

-- [一律] (yílǜ): đồng loạt, như nhau
UPDATE public.vocabularies
SET example_hanzi = '根据考场严格的纪律防作弊规定，考生携带的所有电子通讯设备在开考前必须一律关闭并统一交由监考老师保管。',
    example_pinyin = 'Gēnjù kǎochǎng yángé de jìlǜ fáng zuòbì guīdìng, kǎoshēng xiédài de suǒyǒu diànzǐ tōngxùn shèbèi zài kāikǎo qián bìxū yílǜ guānbì bìng tǒngyī jiāoyóu jiānkǎo lǎoshī bǎoguǎn.',
    example_vi = 'Căn cứ theo quy định phòng chống gian lận kỷ luật nghiêm ngặt tại phòng thi, mọi thiết bị viễn thông điện tử do thí sinh mang theo trước khi phát đề đều phải đồng loạt tắt nguồn và nộp chung cho giám thị giữ.'
WHERE id = 'ecce46c2-911a-4b9a-b4b0-82e8acbcd13c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ecce46c2-911a-4b9a-b4b0-82e8acbcd13c', '根据考场严格的纪律防作弊规定，考生携带的所有电子通讯设备在开考前必须一律关闭并统一交由监考老师保管。', 'Gēnjù kǎochǎng yángé de jìlǜ fáng zuòbì guīdìng, kǎoshēng xiédài de suǒyǒu diànzǐ tōngxùn shèbèi zài kāikǎo qián bìxū yílǜ guānbì bìng tǒngyī jiāoyóu jiānkǎo lǎoshī bǎoguǎn.', 'Căn cứ theo quy định phòng chống gian lận kỷ luật nghiêm ngặt tại phòng thi, mọi thiết bị viễn thông điện tử do thí sinh mang theo trước khi phát đề đều phải đồng loạt tắt nguồn và nộp chung cho giám thị giữ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ecce46c2-911a-4b9a-b4b0-82e8acbcd13c'
);

-- [议论] (yìlùn): bàn luận, thảo luận
UPDATE public.vocabularies
SET example_hanzi = '这部引发全社会广泛关注的现实主义题材电影一经上映，立刻在各大社交平台引发了热烈深入的议论。',
    example_pinyin = 'Zhè bù yǐnfā quán shèhuì guǎngfàn guānzhù de xiànshí zhǔyì tícái diànyǐng yījīng shàngyìng, lìkè zài gè dà shèjiāo píngtái yǐnfā le rèliè shēnrù de yìlùn.',
    example_vi = 'Bộ phim điện ảnh đề tài hiện thực chủ nghĩa thu hút sự chú ý rộng rãi của toàn xã hội này vừa mới công chiếu đã lập tức làm dấy lên những cuộc bàn luận thảo luận sôi nổi sâu sắc trên các diễn đàn mạng xã hội.'
WHERE id = '842b1599-ae58-4e75-ade9-d620e2a78bbe' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '842b1599-ae58-4e75-ade9-d620e2a78bbe', '这部引发全社会广泛关注的现实主义题材电影一经上映，立刻在各大社交平台引发了热烈深入的议论。', 'Zhè bù yǐnfā quán shèhuì guǎngfàn guānzhù de xiànshí zhǔyì tícái diànyǐng yījīng shàngyìng, lìkè zài gè dà shèjiāo píngtái yǐnfā le rèliè shēnrù de yìlùn.', 'Bộ phim điện ảnh đề tài hiện thực chủ nghĩa thu hút sự chú ý rộng rãi của toàn xã hội này vừa mới công chiếu đã lập tức làm dấy lên những cuộc bàn luận thảo luận sôi nổi sâu sắc trên các diễn đàn mạng xã hội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '842b1599-ae58-4e75-ade9-d620e2a78bbe'
);

-- [以免] (yǐmiǎn): để tránh, nhằm tránh
UPDATE public.vocabularies
SET example_hanzi = '在潮湿雨季保存贵重的电子设备与精密镜头时，箱内务必放置足量的干燥剂包，以免仪器受潮霉变。',
    example_pinyin = 'Zài cháoshī yǔjì bǎocún guìzhòng de diànzǐ shèbèi yǔ jīngmì jìngtóu shí, xiāngnèi wùbì fàngzhì zúliàng de gānzàojì bāo, yǐmiǎn yíqì shòucháo méibiàn.',
    example_vi = 'Khi bảo quản thiết bị điện tử đắt tiền và ống kính chính xác trong mùa mưa ẩm ướt, trong hộp nhất định phải đặt đủ túi hút ẩm để tránh thiết bị bị ẩm mốc hư hại.'
WHERE id = '071f1d80-bf3e-4606-b505-ec870962afb6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '071f1d80-bf3e-4606-b505-ec870962afb6', '在潮湿雨季保存贵重的电子设备与精密镜头时，箱内务必放置足量的干燥剂包，以免仪器受潮霉变。', 'Zài cháoshī yǔjì bǎocún guìzhòng de diànzǐ shèbèi yǔ jīngmì jìngtóu shí, xiāngnèi wùbì fàngzhì zúliàng de gānzàojì bāo, yǐmiǎn yíqì shòucháo méibiàn.', 'Khi bảo quản thiết bị điện tử đắt tiền và ống kính chính xác trong mùa mưa ẩm ướt, trong hộp nhất định phải đặt đủ túi hút ẩm để tránh thiết bị bị ẩm mốc hư hại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '071f1d80-bf3e-4606-b505-ec870962afb6'
);

-- [移民] (yímín): di dân, nhập cư
UPDATE public.vocabularies
SET example_hanzi = '这片拥有包容多元文化魅力的现代化新兴港口城市，吸引了来自世界各地的数万名高素质海外技术移民。',
    example_pinyin = 'Zhè piàn yōngyǒu bāoróng duōyuán wénhuà mèilì de xiàndàihuà xīnxīng gǎngkǒu chéngshì, xīyǐn le láizì shìjiè gèdì de shù wàn míng gāo sùzhì hǎiwài jìshù yímín.',
    example_vi = 'Thành phố cảng mới nổi hiện đại mang sức hút văn hóa đa nguyên bao dung này đã thu hút hàng vạn người nhập cư di dân kỹ thuật tay nghề hải ngoại có tố chất cao đến từ khắp nơi trên thế giới.'
WHERE id = '558d661a-f6b1-4a1f-858c-0ff2088ddb32' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '558d661a-f6b1-4a1f-858c-0ff2088ddb32', '这片拥有包容多元文化魅力的现代化新兴港口城市，吸引了来自世界各地的数万名高素质海外技术移民。', 'Zhè piàn yōngyǒu bāoróng duōyuán wénhuà mèilì de xiàndàihuà xīnxīng gǎngkǒu chéngshì, xīyǐn le láizì shìjiè gèdì de shù wàn míng gāo sùzhì hǎiwài jìshù yímín.', 'Thành phố cảng mới nổi hiện đại mang sức hút văn hóa đa nguyên bao dung này đã thu hút hàng vạn người nhập cư di dân kỹ thuật tay nghề hải ngoại có tố chất cao đến từ khắp nơi trên thế giới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '558d661a-f6b1-4a1f-858c-0ff2088ddb32'
);

-- [引导] (yǐn dǎo): hướng dẫn, dẫn dắt
UPDATE public.vocabularies
SET example_hanzi = '优秀的导师善于通过启发式的提问，循循善诱地引导研究生独立发现问题并攻克科研难关。',
    example_pinyin = 'Yōuxiù de dǎoshī shànyú tōngguò qǐfāshì de tíwèn, xúnxún-shànyòu de yǐndǎo yánjiūshēng dúlì fāxiàn wèntí bìng gōngkè kēyán nánguān.',
    example_vi = 'Người hướng dẫn ưu tú giỏi dùng những câu hỏi mang tính gợi mở, khéo léo dẫn dắt nghiên cứu sinh độc lập phát hiện vấn đề và vượt qua cửa ải khó khăn nghiên cứu khoa học.'
WHERE id = '32c1f522-51b7-49fc-9376-db649ac701e6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '32c1f522-51b7-49fc-9376-db649ac701e6', '优秀的导师善于通过启发式的提问，循循善诱地引导研究生独立发现问题并攻克科研难关。', 'Yōuxiù de dǎoshī shànyú tōngguò qǐfāshì de tíwèn, xúnxún-shànyòu de yǐndǎo yánjiūshēng dúlì fāxiàn wèntí bìng gōngkè kēyán nánguān.', 'Người hướng dẫn ưu tú giỏi dùng những câu hỏi mang tính gợi mở, khéo léo dẫn dắt nghiên cứu sinh độc lập phát hiện vấn đề và vượt qua cửa ải khó khăn nghiên cứu khoa học.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '32c1f522-51b7-49fc-9376-db649ac701e6'
);

-- [婴儿] (yīng'ér): trẻ sơ sinh
UPDATE public.vocabularies
SET example_hanzi = '妇幼保健院的专业护士用极其轻柔熟练的手法，悉心为初生刚满月的健康婴儿洗澡抚触。',
    example_pinyin = 'Fùyòu bǎojiànyuàn de zhuānyè hùshi yòng jíqí qīngróu shúliàn de shǒufǎ, xīxīn wèi chūshēng gāng mǎnyuè de jiànkāng yīng''ér xǐzǎo fǔchù.',
    example_vi = 'Y tá chuyên nghiệp của Viện Bảo vệ Sức khỏe Bà mẹ và Trẻ em dùng thủ pháp cực kỳ êm dịu thuần thục, chăm sóc tỉ mỉ tắm rửa xoa bóp cho trẻ sơ sinh khỏe mạnh vừa tròn tháng.'
WHERE id = 'a5c70adc-ded8-450d-b93c-c40f19c120bc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a5c70adc-ded8-450d-b93c-c40f19c120bc', '妇幼保健院的专业护士用极其轻柔熟练的手法，悉心为初生刚满月的健康婴儿洗澡抚触。', 'Fùyòu bǎojiànyuàn de zhuānyè hùshi yòng jíqí qīngróu shúliàn de shǒufǎ, xīxīn wèi chūshēng gāng mǎnyuè de jiànkāng yīng''ér xǐzǎo fǔchù.', 'Y tá chuyên nghiệp của Viện Bảo vệ Sức khỏe Bà mẹ và Trẻ em dùng thủ pháp cực kỳ êm dịu thuần thục, chăm sóc tỉ mỉ tắm rửa xoa bóp cho trẻ sơ sinh khỏe mạnh vừa tròn tháng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a5c70adc-ded8-450d-b93c-c40f19c120bc'
);

-- [英雄] (yīngxióng): anh hùng
UPDATE public.vocabularies
SET example_hanzi = '在突发特大森林火灾的危急关头，年轻的消防战士们舍生忘死逆行而上，是人民心目中的平民英雄。',
    example_pinyin = 'Zài tūfā tèdà sēnlín huǒzāi de wēijí guāntóu, niánqīng de xiāofáng zhànshì men shěshēng-wàngsǐ nìxíng-érshàng, shì rénmín xīnmù zhōng de píngmín yīngxióng.',
    example_vi = 'Vào thời khắc nguy cấp của đám cháy rừng đặc biệt nghiêm trọng đột ngột bùng phát, các chiến sĩ cứu hỏa trẻ tuổi xả thân quên mình lao ngược vào hiểm nguy, là người anh hùng bình dân trong lòng nhân dân.'
WHERE id = '5cdf1ead-53e1-46fb-9c4e-1f14c022f2a3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5cdf1ead-53e1-46fb-9c4e-1f14c022f2a3', '在突发特大森林火灾的危急关头，年轻的消防战士们舍生忘死逆行而上，是人民心目中的平民英雄。', 'Zài tūfā tèdà sēnlín huǒzāi de wēijí guāntóu, niánqīng de xiāofáng zhànshì men shěshēng-wàngsǐ nìxíng-érshàng, shì rénmín xīnmù zhōng de píngmín yīngxióng.', 'Vào thời khắc nguy cấp của đám cháy rừng đặc biệt nghiêm trọng đột ngột bùng phát, các chiến sĩ cứu hỏa trẻ tuổi xả thân quên mình lao ngược vào hiểm nguy, là người anh hùng bình dân trong lòng nhân dân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5cdf1ead-53e1-46fb-9c4e-1f14c022f2a3'
);

-- [影子] (yǐngzi): cái bóng
UPDATE public.vocabularies
SET example_hanzi = '在夕阳西下那抹温暖柔和的橘红余晖映照下，放学归来的母子俩在青石小路上拉出了长长的影子。',
    example_pinyin = 'Zài xīyáng xīxià nà mǒ wēnnuǎn róuhé de júhóng yúhuī yìngzhào xià, fàngxué guīlái de mǔzǐ liǎ zài qīngshí xiǎolù shang lā chū le chángcháng de yǐngzi.',
    example_vi = 'Dưới vệt ánh tà dương cam đỏ ấm áp dịu dàng khi hoàng hôn buông xuống, hai mẹ con tan học trở về đổ chiếc bóng dài thướt tha trên con đường đá xanh nhỏ.'
WHERE id = 'f2d0baca-29dc-46ff-9654-34c0f739464b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f2d0baca-29dc-46ff-9654-34c0f739464b', '在夕阳西下那抹温暖柔和的橘红余晖映照下，放学归来的母子俩在青石小路上拉出了长长的影子。', 'Zài xīyáng xīxià nà mǒ wēnnuǎn róuhé de júhóng yúhuī yìngzhào xià, fàngxué guīlái de mǔzǐ liǎ zài qīngshí xiǎolù shang lā chū le chángcháng de yǐngzi.', 'Dưới vệt ánh tà dương cam đỏ ấm áp dịu dàng khi hoàng hôn buông xuống, hai mẹ con tan học trở về đổ chiếc bóng dài thướt tha trên con đường đá xanh nhỏ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f2d0baca-29dc-46ff-9654-34c0f739464b'
);

-- [隐私] (yǐnsī): đời tư, sự riêng tư
UPDATE public.vocabularies
SET example_hanzi = '互联网科技企业在开发人工智能算法时，必须严格遵守数据安全法律法规，切实保护用户的个人隐私。',
    example_pinyin = 'Hùliánwǎng kējì qǐyè zài kāifā réngōng zhìnéng suànfǎ shí, bìxū yángé zūnshǒu shùjù ānquán fǎlǜ fǎguī, qièshí bǎohù yònghù de gèrén yǐnsī.',
    example_vi = 'Các doanh nghiệp công nghệ Internet khi phát triển thuật toán trí tuệ nhân tạo bắt buộc phải tuân thủ nghiêm ngặt luật lệ an toàn dữ liệu, bảo vệ thiết thực sự riêng tư cá nhân của người dùng.'
WHERE id = '2e5e780d-12ba-4c8f-972b-b92ffd1eaba8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2e5e780d-12ba-4c8f-972b-b92ffd1eaba8', '互联网科技企业在开发人工智能算法时，必须严格遵守数据安全法律法规，切实保护用户的个人隐私。', 'Hùliánwǎng kējì qǐyè zài kāifā réngōng zhìnéng suànfǎ shí, bìxū yángé zūnshǒu shùjù ānquán fǎlǜ fǎguī, qièshí bǎohù yònghù de gèrén yǐnsī.', 'Các doanh nghiệp công nghệ Internet khi phát triển thuật toán trí tuệ nhân tạo bắt buộc phải tuân thủ nghiêm ngặt luật lệ an toàn dữ liệu, bảo vệ thiết thực sự riêng tư cá nhân của người dùng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2e5e780d-12ba-4c8f-972b-b92ffd1eaba8'
);

-- [仪器] (yíqì): khí cụ, thiết bị, dụng cụ đo
UPDATE public.vocabularies
SET example_hanzi = '这批刚刚从海外引进的尖端分析仪器精度极高，能准确探测出水中十亿分之一浓度的微量重金属杂质。',
    example_pinyin = 'Zhè pī gānggāng cóng hǎiwài yǐnjìn de jiānduān fēnxī yíqì jīngdù jígāo, néng zhǔnquè tàncè chū shuǐ zhōng shíyì fēn zhī yī nóngdù de wēiliàng zhòngjīnshǔ zázhì.',
    example_vi = 'Lô thiết bị phân tích đi đầu vừa nhập khẩu từ nước ngoài này có độ chính xác cực cao, có thể phát hiện chuẩn xác tạp chất kim loại nặng vi lượng ở nồng độ một phần tỷ trong nước.'
WHERE id = '9ee7c9a2-9811-4785-a714-bbd408b75e25' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9ee7c9a2-9811-4785-a714-bbd408b75e25', '这批刚刚从海外引进的尖端分析仪器精度极高，能准确探测出水中十亿分之一浓度的微量重金属杂质。', 'Zhè pī gānggāng cóng hǎiwài yǐnjìn de jiānduān fēnxī yíqì jīngdù jígāo, néng zhǔnquè tàncè chū shuǐ zhōng shíyì fēn zhī yī nóngdù de wēiliàng zhòngjīnshǔ zázhì.', 'Lô thiết bị phân tích đi đầu vừa nhập khẩu từ nước ngoài này có độ chính xác cực cao, có thể phát hiện chuẩn xác tạp chất kim loại nặng vi lượng ở nồng độ một phần tỷ trong nước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9ee7c9a2-9811-4785-a714-bbd408b75e25'
);

-- [仪式] (yíshì): nghi thức, buổi lễ
UPDATE public.vocabularies
SET example_hanzi = '在雄壮激昂的国歌声中，全校三千余名师生肃立在操场上，庄严举行每周一清晨的升国旗仪式。',
    example_pinyin = 'Zài xióngzhuàng jī''áng de guógē shēng zhōng, quánxiào sān qiān yú míng shīshēng sùlì zài cāochǎng shang, zhuāngyán jǔxíng měi zhōuyī qīngchén de shēng guóqí yíshì.',
    example_vi = 'Trong tiếng quốc ca hùng tráng sôi nổi, hơn ba ngàn thầy trò toàn trường đứng nghiêm trang trên sân vận động, long trọng cử hành nghi thức lễ thượng cờ vào mỗi sáng sớm thứ Hai.'
WHERE id = 'f89ab022-fd86-4931-865e-17dbae751063' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f89ab022-fd86-4931-865e-17dbae751063', '在雄壮激昂的国歌声中，全校三千余名师生肃立在操场上，庄严举行每周一清晨的升国旗仪式。', 'Zài xióngzhuàng jī''áng de guógē shēng zhōng, quánxiào sān qiān yú míng shīshēng sùlì zài cāochǎng shang, zhuāngyán jǔxíng měi zhōuyī qīngchén de shēng guóqí yíshì.', 'Trong tiếng quốc ca hùng tráng sôi nổi, hơn ba ngàn thầy trò toàn trường đứng nghiêm trang trên sân vận động, long trọng cử hành nghi thức lễ thượng cờ vào mỗi sáng sớm thứ Hai.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f89ab022-fd86-4931-865e-17dbae751063'
);

-- [以往] (yǐwǎng): trước đây, trước kia
UPDATE public.vocabularies
SET example_hanzi = '与以往主要依靠大量人力手工筛查的传统模式相比，现在的智能化审计系统极大地提高了稽查准确率。',
    example_pinyin = 'Yǔ yǐwǎng zhǔyào yīkào dàliàng rénlì shǒugōng shāichá de chuántǒng móshì xiāngbǐ, xiànzài de zhìnénghuà shěnjì xìtǒng jídà de tígāo le jīchá zhǔnquèlǜ.',
    example_vi = 'So với mô hình truyền thống trước đây chủ yếu dựa vào lượng lớn nhân lực rà soát thủ công, hệ thống kiểm toán thông minh hóa hiện nay đã nâng cao vượt bậc tỷ lệ chính xác của công tác thanh tra.'
WHERE id = '038dee83-d8aa-493a-98e8-7fb1112473e9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '038dee83-d8aa-493a-98e8-7fb1112473e9', '与以往主要依靠大量人力手工筛查的传统模式相比，现在的智能化审计系统极大地提高了稽查准确率。', 'Yǔ yǐwǎng zhǔyào yīkào dàliàng rénlì shǒugōng shāichá de chuántǒng móshì xiāngbǐ, xiànzài de zhìnénghuà shěnjì xìtǒng jídà de tígāo le jīchá zhǔnquèlǜ.', 'So với mô hình truyền thống trước đây chủ yếu dựa vào lượng lớn nhân lực rà soát thủ công, hệ thống kiểm toán thông minh hóa hiện nay đã nâng cao vượt bậc tỷ lệ chính xác của công tác thanh tra.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '038dee83-d8aa-493a-98e8-7fb1112473e9'
);

-- [一再] (yízài): lặp đi lặp lại
UPDATE public.vocabularies
SET example_hanzi = '尽管医生和家属一再耐心叮嘱他要遵医嘱按时服药并多加静养，但他一投入工作就把休息抛在脑后。',
    example_pinyin = 'Jǐnguǎn yīshēng hé jiāshǔ yízài nàixīn dīngzhǔ tā yào zūnyīzhǔ ànshí fúyào bìng duōjiā jìngyǎng, dàn tā yì tóurù gōngzuò jiù bǎ xiūxi pāo zài nǎohòu.',
    example_vi = 'Mặc dù bác sĩ và người nhà nhiều lần kiên nhẫn dặn dò ông phải theo y lệnh uống thuốc đúng giờ và tĩnh dưỡng nhiều hơn, nhưng hễ cứ lao vào công việc là ông lại quẳng chuyện nghỉ ngơi ra sau đầu.'
WHERE id = '2f70b49e-eea0-4212-b366-86d50c97768a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2f70b49e-eea0-4212-b366-86d50c97768a', '尽管医生和家属一再耐心叮嘱他要遵医嘱按时服药并多加静养，但他一投入工作就把休息抛在脑后。', 'Jǐnguǎn yīshēng hé jiāshǔ yízài nàixīn dīngzhǔ tā yào zūnyīzhǔ ànshí fúyào bìng duōjiā jìngyǎng, dàn tā yì tóurù gōngzuò jiù bǎ xiūxi pāo zài nǎohòu.', 'Mặc dù bác sĩ và người nhà nhiều lần kiên nhẫn dặn dò ông phải theo y lệnh uống thuốc đúng giờ và tĩnh dưỡng nhiều hơn, nhưng hễ cứ lao vào công việc là ông lại quẳng chuyện nghỉ ngơi ra sau đầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2f70b49e-eea0-4212-b366-86d50c97768a'
);

-- [用功] (yònggōng): chăm chỉ, nỗ lực
UPDATE public.vocabularies
SET example_hanzi = '凭借平时夜以继日的刻苦用功与扎实基础，这名农家出身的青年学子在高考中一举夺魁并考入名校。',
    example_pinyin = 'Píngjiè píngshí yèyǐjìrì de kèkǔ yònggōng yǔ zhāshi jīchǔ, zhè míng nóngjiā chūshēn de qīngnián xuézǐ zài gāokǎo zhōng yījǔ-duókuí bìng kǎorù míngxiào.',
    example_vi = 'Dựa vào việc chăm chỉ khổ luyện ngày đêm thường ngày và nền tảng vững chắc, chàng sĩ tử xuất thân nhà nông này đã xuất sắc đỗ thủ khoa trong kỳ thi đại học và bước chân vào trường đại học danh tiếng.'
WHERE id = 'ec349c33-cf0e-4b05-b403-da22ad628fe0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ec349c33-cf0e-4b05-b403-da22ad628fe0', '凭借平时夜以继日的刻苦用功与扎实基础，这名农家出身的青年学子在高考中一举夺魁并考入名校。', 'Píngjiè píngshí yèyǐjìrì de kèkǔ yònggōng yǔ zhāshi jīchǔ, zhè míng nóngjiā chūshēn de qīngnián xuézǐ zài gāokǎo zhōng yījǔ-duókuí bìng kǎorù míngxiào.', 'Dựa vào việc chăm chỉ khổ luyện ngày đêm thường ngày và nền tảng vững chắc, chàng sĩ tử xuất thân nhà nông này đã xuất sắc đỗ thủ khoa trong kỳ thi đại học và bước chân vào trường đại học danh tiếng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ec349c33-cf0e-4b05-b403-da22ad628fe0'
);

-- [拥挤] (yōngjǐ): chen chúc, đông đúc
UPDATE public.vocabularies
SET example_hanzi = '每到早晚上下班的高峰拥挤时段，地铁换乘大厅内总是人头攒动、川流不息。',
    example_pinyin = 'Měi dào zǎowǎn shàng-xiàbān de gāofēng yōngjǐ shíduàn, dìtiě huànchéng dàtīng nèi zǒngshì réntóu-cuán dòng, chuānliú-bùxī.',
    example_vi = 'Mỗi dịp khung giờ cao điểm đi làm và tan tầm buổi sáng và tối đông đúc chen chúc, bên trong sảnh chuyển tuyến tàu điện ngầm luôn đông nghịt người, dòng người nối nhau nườm nượp không ngớt.'
WHERE id = 'aefb864b-836b-4a7e-b176-5c439f2f02a8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'aefb864b-836b-4a7e-b176-5c439f2f02a8', '每到早晚上下班的高峰拥挤时段，地铁换乘大厅内总是人头攒动、川流不息。', 'Měi dào zǎowǎn shàng-xiàbān de gāofēng yōngjǐ shíduàn, dìtiě huànchéng dàtīng nèi zǒngshì réntóu-cuán dòng, chuānliú-bùxī.', 'Mỗi dịp khung giờ cao điểm đi làm và tan tầm buổi sáng và tối đông đúc chen chúc, bên trong sảnh chuyển tuyến tàu điện ngầm luôn đông nghịt người, dòng người nối nhau nườm nượp không ngớt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'aefb864b-836b-4a7e-b176-5c439f2f02a8'
);

-- [涌现] (yǒngxiàn): xuất hiện dồn dập, trào ra
UPDATE public.vocabularies
SET example_hanzi = '伴随着国家对创新创业扶持政策的深入实施，高新技术产业开发区内涌现出了一大批独角兽领军企业。',
    example_pinyin = 'Bànsuí zhe guójiā duì chuàngxīn chuàngyè fúchí zhèngcè de shēnrù shíshī, gāoxīn jìshù chǎnyè kāifāqū nèi yǒngxiàn chū le yí dà pī dújiǎoshòu lǐngjūn qǐyè.',
    example_vi = 'Cùng với việc triển khai sâu rộng các chính sách hỗ trợ đổi mới sáng tạo khởi nghiệp của quốc gia, bên trong khu phát triển công nghiệp công nghệ cao đã xuất hiện trào ra hàng loạt doanh nghiệp kỳ lân dẫn đầu.'
WHERE id = '8650e074-cbe7-4d41-a104-1f2bb76595e2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8650e074-cbe7-4d41-a104-1f2bb76595e2', '伴随着国家对创新创业扶持政策的深入实施，高新技术产业开发区内涌现出了一大批独角兽领军企业。', 'Bànsuí zhe guójiā duì chuàngxīn chuàngyè fúchí zhèngcè de shēnrù shíshī, gāoxīn jìshù chǎnyè kāifāqū nèi yǒngxiàn chū le yí dà pī dújiǎoshòu lǐngjūn qǐyè.', 'Cùng với việc triển khai sâu rộng các chính sách hỗ trợ đổi mới sáng tạo khởi nghiệp của quốc gia, bên trong khu phát triển công nghiệp công nghệ cao đã xuất hiện trào ra hàng loạt doanh nghiệp kỳ lân dẫn đầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8650e074-cbe7-4d41-a104-1f2bb76595e2'
);

-- [勇于] (yǒngyú): dũng cảm, dám
UPDATE public.vocabularies
SET example_hanzi = '青年学者应当敢于打破传统思维的框架束缚，勇于探索未知的学术无人区并提出独创性见解。',
    example_pinyin = 'Qīngnián xuézhě yīngdāng gǎnyú dǎpò chuántǒng sīwéi de kuàngjià shùfù, yǒngyú tànsuǒ wèizhī de xuéshù wúrénqū bìng tíchū dúchuàngxìng jiànjiě.',
    example_vi = 'Các học giả trẻ cần dám phá bỏ xiềng xích khuôn mẫu tư duy truyền thống, dũng cảm khám phá những vùng đất học thuật chưa ai đặt chân tới và đưa ra những kiến giải độc sáng.'
WHERE id = 'dc538617-6d82-447b-af3c-00528998d6aa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dc538617-6d82-447b-af3c-00528998d6aa', '青年学者应当敢于打破传统思维的框架束缚，勇于探索未知的学术无人区并提出独创性见解。', 'Qīngnián xuézhě yīngdāng gǎnyú dǎpò chuántǒng sīwéi de kuàngjià shùfù, yǒngyú tànsuǒ wèizhī de xuéshù wúrénqū bìng tíchū dúchuàngxìng jiànjiě.', 'Các học giả trẻ cần dám phá bỏ xiềng xích khuôn mẫu tư duy truyền thống, dũng cảm khám phá những vùng đất học thuật chưa ai đặt chân tới và đưa ra những kiến giải độc sáng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dc538617-6d82-447b-af3c-00528998d6aa'
);

-- [犹如] (yóurú): giống như, tựa như
UPDATE public.vocabularies
SET example_hanzi = '那轮倒映在风平浪静湖面上的皎洁明月，犹如一块晶莹剔透的美玉无瑕，令人心旷神怡。',
    example_pinyin = 'Nà lún dàoyìng zài fēngpíng-làngjìng húmiàn shang de jiǎojié míngyuè, yóurú yí kuài jīngyíng-tītòu de měiyù wúxiá, lìngrén xīnlàng-shényí.',
    example_vi = 'Vầng trăng sáng vằng vặc soi bóng trên mặt hồ gió lặng sóng yên tựa như một viên ngọc bích không tì vết long lanh trong suốt, khiến lòng người thư thái khoan khoái.'
WHERE id = '78286fcf-5edc-4e52-b64d-eeb608f5d32f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '78286fcf-5edc-4e52-b64d-eeb608f5d32f', '那轮倒映在风平浪静湖面上的皎洁明月，犹如一块晶莹剔透的美玉无瑕，令人心旷神怡。', 'Nà lún dàoyìng zài fēngpíng-làngjìng húmiàn shang de jiǎojié míngyuè, yóurú yí kuài jīngyíng-tītòu de měiyù wúxiá, lìngrén xīnlàng-shényí.', 'Vầng trăng sáng vằng vặc soi bóng trên mặt hồ gió lặng sóng yên tựa như một viên ngọc bích không tì vết long lanh trong suốt, khiến lòng người thư thái khoan khoái.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '78286fcf-5edc-4e52-b64d-eeb608f5d32f'
);

-- [优先] (yōuxiān): ưu tiên
UPDATE public.vocabularies
SET example_hanzi = '在安排新一轮城市更新与财政民生预算时，市委市政府明确要求优先解决城中村老旧小区的供暖改造。',
    example_pinyin = 'Zài ānpái xīn yì lún chéngshì gēngxīn yǔ cáizhèng mínshēng yùsuàn shí, shìwěi shìzhèngfǔ míngquè yāoqiú yōuxiān jiějué chéngzhōngcūn lǎojiù xiǎoqū de gōngnuǎn gǎizào.',
    example_vi = 'Khi sắp xếp đợt cải tạo đô thị mới và dự toán ngân sách dân sinh, thành ủy và chính quyền thành phố yêu cầu rõ ràng phải ưu tiên giải quyết việc cải tạo sưởi ấm cho các khu tập thể cũ trong làng nội thành.'
WHERE id = '6d1ce70b-932c-4205-8b62-8622f80a0cdb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6d1ce70b-932c-4205-8b62-8622f80a0cdb', '在安排新一轮城市更新与财政民生预算时，市委市政府明确要求优先解决城中村老旧小区的供暖改造。', 'Zài ānpái xīn yì lún chéngshì gēngxīn yǔ cáizhèng mínshēng yùsuàn shí, shìwěi shìzhèngfǔ míngquè yāoqiú yōuxiān jiějué chéngzhōngcūn lǎojiù xiǎoqū de gōngnuǎn gǎizào.', 'Khi sắp xếp đợt cải tạo đô thị mới và dự toán ngân sách dân sinh, thành ủy và chính quyền thành phố yêu cầu rõ ràng phải ưu tiên giải quyết việc cải tạo sưởi ấm cho các khu tập thể cũ trong làng nội thành.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6d1ce70b-932c-4205-8b62-8622f80a0cdb'
);

-- [优异] (yōuyì): xuất sắc, vượt trội
UPDATE public.vocabularies
SET example_hanzi = '这位年轻的研究生凭借优异的科研成绩与多篇高水平国际顶刊论文，顺利斩获了国家级特等奖学金。',
    example_pinyin = 'Zhè wèi niánqīng de yánjiūshēng píngjiè yōuyì de kēyán chéngjì yǔ duō piān gāo shuǐpíng guójì dǐngkān lùnwén, shùnlì zhǎnhuò le guójiājí tèděng jiǎngxuéjīn.',
    example_vi = 'Nghiên cứu sinh trẻ tuổi này dựa vào thành tích nghiên cứu khoa học xuất sắc cùng nhiều bài báo trình độ cao trên các tạp chí quốc tế hàng đầu đã thuận lợi đoạt được học bổng đặc biệt cấp quốc gia.'
WHERE id = '953a6598-46ef-47f5-be4f-3b055e90775a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '953a6598-46ef-47f5-be4f-3b055e90775a', '这位年轻的研究生凭借优异的科研成绩与多篇高水平国际顶刊论文，顺利斩获了国家级特等奖学金。', 'Zhè wèi niánqīng de yánjiūshēng píngjiè yōuyì de kēyán chéngjì yǔ duō piān gāo shuǐpíng guójì dǐngkān lùnwén, shùnlì zhǎnhuò le guójiājí tèděng jiǎngxuéjīn.', 'Nghiên cứu sinh trẻ tuổi này dựa vào thành tích nghiên cứu khoa học xuất sắc cùng nhiều bài báo trình độ cao trên các tạp chí quốc tế hàng đầu đã thuận lợi đoạt được học bổng đặc biệt cấp quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '953a6598-46ef-47f5-be4f-3b055e90775a'
);

-- [羽绒服] (yǔ róng fú): áo lông vũ
UPDATE public.vocabularies
SET example_hanzi = '面对北方寒冬动辄零下二十度的刺骨朔风，一件保暖性能优良的厚实羽绒服是必不可少的御寒装备。',
    example_pinyin = 'Miànduì běifāng hándōng dòngzhé língxià èrshí dù de cìgǔ shuòfēng, yí jiàn bǎonuǎn xìngnéng yōuliáng de hòushí yǔróngfú shì bìbùkěshǎo de yùhán zhuāngbèi.',
    example_vi = 'Đối mặt với ngọn gió bấc buốt thấu xương thường xuyên âm hai mươi độ của mùa đông phương Bắc, một chiếc áo lông vũ dày dặn giữ ấm tốt là trang bị chống rét không thể thiếu.'
WHERE id = 'e7b34b46-89a2-4529-b30d-507e99f40155' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e7b34b46-89a2-4529-b30d-507e99f40155', '面对北方寒冬动辄零下二十度的刺骨朔风，一件保暖性能优良的厚实羽绒服是必不可少的御寒装备。', 'Miànduì běifāng hándōng dòngzhé língxià èrshí dù de cìgǔ shuòfēng, yí jiàn bǎonuǎn xìngnéng yōuliáng de hòushí yǔróngfú shì bìbùkěshǎo de yùhán zhuāngbèi.', 'Đối mặt với ngọn gió bấc buốt thấu xương thường xuyên âm hai mươi độ của mùa đông phương Bắc, một chiếc áo lông vũ dày dặn giữ ấm tốt là trang bị chống rét không thể thiếu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e7b34b46-89a2-4529-b30d-507e99f40155'
);

-- [原理] (yuánlǐ): nguyên lý
UPDATE public.vocabularies
SET example_hanzi = '中学物理教师在课堂上通过自制小滑轮模型，直观生动地向学生们讲解了省力杠杆的工作原理。',
    example_pinyin = 'Zhōngxué wùlǐ jiàoshī zài kètáng shang tōngguò zìzhì xiǎo huálún móxíng, zhíguān shēngdòng de xiàng xuésheng men jiǎngjiě le shěnglì gànggǎn de gōngzuò yuánlǐ.',
    example_vi = 'Thầy giáo vật lý cấp hai trên lớp thông qua mô hình ròng rọc nhỏ tự chế đã giải thích trực quan sinh động nguyên lý làm việc của đòn bẩy tiết kiệm lực cho học sinh.'
WHERE id = '9418e054-e126-421f-b48e-e7ec4c6c1414' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9418e054-e126-421f-b48e-e7ec4c6c1414', '中学物理教师在课堂上通过自制小滑轮模型，直观生动地向学生们讲解了省力杠杆的工作原理。', 'Zhōngxué wùlǐ jiàoshī zài kètáng shang tōngguò zìzhì xiǎo huálún móxíng, zhíguān shēngdòng de xiàng xuésheng men jiǎngjiě le shěnglì gànggǎn de gōngzuò yuánlǐ.', 'Thầy giáo vật lý cấp hai trên lớp thông qua mô hình ròng rọc nhỏ tự chế đã giải thích trực quan sinh động nguyên lý làm việc của đòn bẩy tiết kiệm lực cho học sinh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9418e054-e126-421f-b48e-e7ec4c6c1414'
);

-- [原料] (yuánliào): nguyên liệu
UPDATE public.vocabularies
SET example_hanzi = '这家高端有机食品加工厂全部精选无污染深山农场种植的新鲜谷物，作为产品生产的天然原料。',
    example_pinyin = 'Zhè jiā gāoduān yǒujī shípǐn jiāgōngchǎng quánbù jīngxuǎn wú wūrǎn shēnshān nóngchǎng zhòngzhí de xīnxiān gǔwù, zuòwéi chǎnpǐn shēngchǎn de tiānrán yuánliào.',
    example_vi = 'Nhà máy chế biến thực phẩm hữu cơ cao cấp này toàn bộ tuyển chọn ngũ cốc tươi trồng tại các trang trại núi sâu không bị ô nhiễm làm nguyên liệu tự nhiên cho sản xuất sản phẩm.'
WHERE id = '5a99101f-bf5d-4de0-83fc-55b901efe65c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5a99101f-bf5d-4de0-83fc-55b901efe65c', '这家高端有机食品加工厂全部精选无污染深山农场种植的新鲜谷物，作为产品生产的天然原料。', 'Zhè jiā gāoduān yǒujī shípǐn jiāgōngchǎng quánbù jīngxuǎn wú wūrǎn shēnshān nóngchǎng zhòngzhí de xīnxiān gǔwù, zuòwéi chǎnpǐn shēngchǎn de tiānrán yuánliào.', 'Nhà máy chế biến thực phẩm hữu cơ cao cấp này toàn bộ tuyển chọn ngũ cốc tươi trồng tại các trang trại núi sâu không bị ô nhiễm làm nguyên liệu tự nhiên cho sản xuất sản phẩm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5a99101f-bf5d-4de0-83fc-55b901efe65c'
);

-- [园林] (yuánlín): vườn hoa, lâm viên
UPDATE public.vocabularies
SET example_hanzi = '苏州古典园林移步换景、巧夺天工，将亭台楼阁、假山池塘与花木葱茏融为一体，堪称东方美学典范。',
    example_pinyin = 'Sūzhōu gǔdiǎn yuánlín yíbù-huànjǐng, qiǎoduó-tiāngōng, jiāng tíngtái-lóugé, jiǎshān chítáng yǔ huāmù cōnglóng róng wéi yītǐ, kānchēng dōngfāng měixué diǎnfàn.',
    example_vi = 'Vườn cảnh cổ điển Tô Châu mỗi bước chuyển dời một cảnh đẹp, khéo léo đoạt công trời, hòa quyện đình đài lầu gác non bộ hồ nước và cây cỏ xanh tươi thành một thể thống nhất, xứng đáng là khuôn mẫu thẩm mỹ phương Đông.'
WHERE id = '12769c0a-b885-4da3-9e15-39d1c3664599' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '12769c0a-b885-4da3-9e15-39d1c3664599', '苏州古典园林移步换景、巧夺天工，将亭台楼阁、假山池塘与花木葱茏融为一体，堪称东方美学典范。', 'Sūzhōu gǔdiǎn yuánlín yíbù-huànjǐng, qiǎoduó-tiāngōng, jiāng tíngtái-lóugé, jiǎshān chítáng yǔ huāmù cōnglóng róng wéi yītǐ, kānchēng dōngfāng měixué diǎnfàn.', 'Vườn cảnh cổ điển Tô Châu mỗi bước chuyển dời một cảnh đẹp, khéo léo đoạt công trời, hòa quyện đình đài lầu gác non bộ hồ nước và cây cỏ xanh tươi thành một thể thống nhất, xứng đáng là khuôn mẫu thẩm mỹ phương Đông.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '12769c0a-b885-4da3-9e15-39d1c3664599'
);

-- [圆满] (yuánmǎn): viên mãn, hoàn hảo
UPDATE public.vocabularies
SET example_hanzi = '历时三天的首届全球人工智能发展论坛在与会各方达成具有里程碑意义的联合宣言后，圆满落下帷幕。',
    example_pinyin = 'Lìshí sān tiān de shǒujiè quánqiú réngōng zhìnéng fāzhǎn lùntán zài yùhuì gèfāng dáchéng jùyǒu lǐchéngbēi yìyì de liánhé xuānyán hòu, yuánmǎn luòxià wéimù.',
    example_vi = 'Diễn đàn Phát triển Trí tuệ Nhân tạo Toàn cầu lần thứ nhất kéo dài ba ngày sau khi các bên tham dự đạt được tuyên bố chung mang ý nghĩa cột mốc đã khép lại một cách viên mãn hoàn hảo.'
WHERE id = '0b60a7bd-1d14-48ff-a9eb-55375ad07e3c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0b60a7bd-1d14-48ff-a9eb-55375ad07e3c', '历时三天的首届全球人工智能发展论坛在与会各方达成具有里程碑意义的联合宣言后，圆满落下帷幕。', 'Lìshí sān tiān de shǒujiè quánqiú réngōng zhìnéng fāzhǎn lùntán zài yùhuì gèfāng dáchéng jùyǒu lǐchéngbēi yìyì de liánhé xuānyán hòu, yuánmǎn luòxià wéimù.', 'Diễn đàn Phát triển Trí tuệ Nhân tạo Toàn cầu lần thứ nhất kéo dài ba ngày sau khi các bên tham dự đạt được tuyên bố chung mang ý nghĩa cột mốc đã khép lại một cách viên mãn hoàn hảo.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0b60a7bd-1d14-48ff-a9eb-55375ad07e3c'
);

-- [原始] (yuánshǐ): nguyên thủy, ban sơ
UPDATE public.vocabularies
SET example_hanzi = '科考队员深入西双版纳浩瀚的热带原始森林深处，成功探秘并记录了多种珍稀野生动植物的生存状态。',
    example_pinyin = 'Kēkǎo duìyuán shēnrù Xīshuāngbǎnnà hàohàn de rèdài yuánshǐ sēnlín shēncù, chénggōng tànmì bìng jìlù le duō zhǒng zhēnxī yěshēng dòng-zhíwù de shēngcún zhuàngtài.',
    example_vi = 'Các thành viên đoàn khảo sát khoa học tiến sâu vào nơi rừng rậm nguyên sinh nhiệt đới bao la của Tây Song Bản Nạp, khám phá thành công và ghi chép lại tình trạng sinh tồn của nhiều loài động thực vật hoang dã quý hiếm.'
WHERE id = '0c3c9d18-b824-4780-80c5-e13ba104f5d0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0c3c9d18-b824-4780-80c5-e13ba104f5d0', '科考队员深入西双版纳浩瀚的热带原始森林深处，成功探秘并记录了多种珍稀野生动植物的生存状态。', 'Kēkǎo duìyuán shēnrù Xīshuāngbǎnnà hàohàn de rèdài yuánshǐ sēnlín shēncù, chénggōng tànmì bìng jìlù le duō zhǒng zhēnxī yěshēng dòng-zhíwù de shēngcún zhuàngtài.', 'Các thành viên đoàn khảo sát khoa học tiến sâu vào nơi rừng rậm nguyên sinh nhiệt đới bao la của Tây Song Bản Nạp, khám phá thành công và ghi chép lại tình trạng sinh tồn của nhiều loài động thực vật hoang dã quý hiếm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0c3c9d18-b824-4780-80c5-e13ba104f5d0'
);

-- [元素] (yuánsù): nguyên tố, yếu tố
UPDATE public.vocabularies
SET example_hanzi = '这位年轻的先锋服装设计师巧妙提炼中国传统京剧脸谱元素，创作出风靡国际时尚秀场的全新国潮服饰。',
    example_pinyin = 'Zhè wèi niánqīng de xiānfēng fúzhuāng shèjìshī qiǎomiào tíliàn zhōngguó chuántǒng jīngjù liǎnpǔ yuánsù, chuàngzuò chū fēngmí guójì shíshàng xiùchǎng de quánxīn guócháo fúshì.',
    example_vi = 'Nhà thiết kế trang phục tiên phong trẻ tuổi này đã khéo léo chắt lọc những yếu tố mặt nạ Kinh kịch truyền thống Trung Hoa, sáng tạo nên bộ sưu tập trang phục trào lưu dân tộc mới làm mưa làm gió trên sàn diễn thời trang quốc tế.'
WHERE id = '6b17b148-1a1d-42cc-b287-86586817a75a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6b17b148-1a1d-42cc-b287-86586817a75a', '这位年轻的先锋服装设计师巧妙提炼中国传统京剧脸谱元素，创作出风靡国际时尚秀场的全新国潮服饰。', 'Zhè wèi niánqīng de xiānfēng fúzhuāng shèjìshī qiǎomiào tíliàn zhōngguó chuántǒng jīngjù liǎnpǔ yuánsù, chuàngzuò chū fēngmí guójì shíshàng xiùchǎng de quánxīn guócháo fúshì.', 'Nhà thiết kế trang phục tiên phong trẻ tuổi này đã khéo léo chắt lọc những yếu tố mặt nạ Kinh kịch truyền thống Trung Hoa, sáng tạo nên bộ sưu tập trang phục trào lưu dân tộc mới làm mưa làm gió trên sàn diễn thời trang quốc tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6b17b148-1a1d-42cc-b287-86586817a75a'
);

-- [原先] (yuánxiān): ban đầu, trước kia
UPDATE public.vocabularies
SET example_hanzi = '原先规划用于商业综合体开发的沿江闲置空地，在广泛听取市民建议后被改建成了环境优美的亲水市民公园。',
    example_pinyin = 'Yuánxiān guīhuà yòngyú shāngyè zōnghétǐ kāifā de yánjiāng xiánzhì kōngdì, zài guǎngfàn tīngqǔ shìmín jiànyì hòu bèi gǎijiàn chéng le huánjìng yōuměi de qīnshuǐ shìmín gōngyuán.',
    example_vi = 'Khu đất trống ven sông trước kia quy hoạch để phát triển tổ hợp thương mại, sau khi lắng nghe rộng rãi ý kiến của người dân đã được cải tạo thành công viên sinh thái công cộng ven mặt nước tuyệt đẹp.'
WHERE id = 'ff82afc9-348b-429d-9761-4f20cb494bee' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ff82afc9-348b-429d-9761-4f20cb494bee', '原先规划用于商业综合体开发的沿江闲置空地，在广泛听取市民建议后被改建成了环境优美的亲水市民公园。', 'Yuánxiān guīhuà yòngyú shāngyè zōnghétǐ kāifā de yánjiāng xiánzhì kōngdì, zài guǎngfàn tīngqǔ shìmín jiànyì hòu bèi gǎijiàn chéng le huánjìng yōuměi de qīnshuǐ shìmín gōngyuán.', 'Khu đất trống ven sông trước kia quy hoạch để phát triển tổ hợp thương mại, sau khi lắng nghe rộng rãi ý kiến của người dân đã được cải tạo thành công viên sinh thái công cộng ven mặt nước tuyệt đẹp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ff82afc9-348b-429d-9761-4f20cb494bee'
);

-- [乐器] (yuèqì): nhạc cụ
UPDATE public.vocabularies
SET example_hanzi = '民族乐团在金色大厅演出时，二胡、琵琶、古筝等传统民族乐器奏响的悠扬旋律深深震撼了全场海外听众。',
    example_pinyin = 'Mínzú yuètuán zài jīnsè dàtīng yǎnchū shí, èrhú, pípá, gǔzhēng děng chuántǒng mínzú yuèqì zòuxiǎng de yōuyáng xuánlǜ shēnshēn zhènhàn le quánchǎng hǎiwài tīngzhòng.',
    example_vi = 'Khi đoàn ca múa nhạc dân tộc biểu diễn tại Đại sảnh Vàng, những giai điệu du dương do các nhạc cụ dân tộc truyền thống như đàn nhị, tỳ bà, đàn tranh tấu lên đã làm rung động sâu sắc toàn thể thính giả nước ngoài.'
WHERE id = '67eb8501-794b-4546-bae0-39dae65749bb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '67eb8501-794b-4546-bae0-39dae65749bb', '民族乐团在金色大厅演出时，二胡、琵琶、古筝等传统民族乐器奏响的悠扬旋律深深震撼了全场海外听众。', 'Mínzú yuètuán zài jīnsè dàtīng yǎnchū shí, èrhú, pípá, gǔzhēng děng chuántǒng mínzú yuèqì zòuxiǎng de yōuyáng xuánlǜ shēnshēn zhènhàn le quánchǎng hǎiwài tīngzhòng.', 'Khi đoàn ca múa nhạc dân tộc biểu diễn tại Đại sảnh Vàng, những giai điệu du dương do các nhạc cụ dân tộc truyền thống như đàn nhị, tỳ bà, đàn tranh tấu lên đã làm rung động sâu sắc toàn thể thính giả nước ngoài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '67eb8501-794b-4546-bae0-39dae65749bb'
);

-- [约束] (yuēshù): ràng buộc, kiềm chế
UPDATE public.vocabularies
SET example_hanzi = '现代文明法治社会的健康良性运转，既需要健全法律法规的刚性约束，也离不开公民道德风尚的自觉坚守。',
    example_pinyin = 'Xiàndài wénmíng fǎzhì shèhuì de jiànkāng liángxìng yùnzhuǎn, jì xūyào jiànquán fǎlǜ fǎguī de gāngxìng yuēshù, yě lí bù kāi gōngmín dàodé fēngshàng de zìjué jiānshǒu.',
    example_vi = 'Sự vận hành lành mạnh đúng đắn của một xã hội pháp quyền văn minh hiện đại vừa cần sự ràng buộc kiềm chế cứng rắn của hệ thống luật pháp hoàn thiện, vừa không thể tách rời sự tự giác giữ gìn chuẩn mực đạo đức của công dân.'
WHERE id = '85f70447-8254-4d69-827d-b31cd5bb4206' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '85f70447-8254-4d69-827d-b31cd5bb4206', '现代文明法治社会的健康良性运转，既需要健全法律法规的刚性约束，也离不开公民道德风尚的自觉坚守。', 'Xiàndài wénmíng fǎzhì shèhuì de jiànkāng liángxìng yùnzhuǎn, jì xūyào jiànquán fǎlǜ fǎguī de gāngxìng yuēshù, yě lí bù kāi gōngmín dàodé fēngshàng de zìjué jiānshǒu.', 'Sự vận hành lành mạnh đúng đắn của một xã hội pháp quyền văn minh hiện đại vừa cần sự ràng buộc kiềm chế cứng rắn của hệ thống luật pháp hoàn thiện, vừa không thể tách rời sự tự giác giữ gìn chuẩn mực đạo đức của công dân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '85f70447-8254-4d69-827d-b31cd5bb4206'
);

-- [预料] (yùliào): dự liệu, đoán trước
UPDATE public.vocabularies
SET example_hanzi = '正如气象专家事先所准确预料的那样，这场突如其来的罕见冷空气使得华北地区气温一夜之间骤降十几度。',
    example_pinyin = 'Zhèngrú qìxiàng zhuānjiā shìxiān suǒ zhǔnquè yùliào de nàyàng, zhè chǎng tūrúqílái de hǎnjiàn lěngkōngqì shǐde Huáběi dìqū qìwēn yí yè zhījiān zhòujiàng shí jǐ dù.',
    example_vi = 'Đúng như dự liệu chuẩn xác từ trước của các chuyên gia khí tượng, đợt không khí lạnh hiếm thấy bất ngờ ập đến này đã khiến nhiệt độ khu vực Hoa Bắc chỉ sau một đêm giảm đột ngột hơn mười độ.'
WHERE id = '61dd947e-7bf9-4c36-be62-aa0077cec768' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '61dd947e-7bf9-4c36-be62-aa0077cec768', '正如气象专家事先所准确预料的那样，这场突如其来的罕见冷空气使得华北地区气温一夜之间骤降十几度。', 'Zhèngrú qìxiàng zhuānjiā shìxiān suǒ zhǔnquè yùliào de nàyàng, zhè chǎng tūrúqílái de hǎnjiàn lěngkōngqì shǐde Huáběi dìqū qìwēn yí yè zhījiān zhòujiàng shí jǐ dù.', 'Đúng như dự liệu chuẩn xác từ trước của các chuyên gia khí tượng, đợt không khí lạnh hiếm thấy bất ngờ ập đến này đã khiến nhiệt độ khu vực Hoa Bắc chỉ sau một đêm giảm đột ngột hơn mười độ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '61dd947e-7bf9-4c36-be62-aa0077cec768'
);

-- [晕] (yūn): chóng mặt, ngất xỉu
UPDATE public.vocabularies
SET example_hanzi = '在波涛汹涌、狂风大作的海面上航行了整整两天两夜，几位年轻科考队员脸色苍白、晕船呕吐得十分难受。',
    example_pinyin = 'Zài bōtāo-xiōngyǒng, kuángfēng-dàzuò de hǎimiàn shang hángxíng le zhěngzhěng liǎng tiān liǎng yè, jǐ wèi niánqīng kēkǎo duìyuán liǎnsè cāngbái, yùnchuán ǒutù de shífēn nánshòu.',
    example_vi = 'Đi trên mặt biển sóng to gió lớn gào thét suốt tròn hai ngày hai đêm, mấy thành viên đoàn khảo sát trẻ tuổi sắc mặt trắng bệch, say sóng nôn nao vô cùng khó chịu.'
WHERE id = 'afb16f85-c0e3-4f28-9505-bf922a266f05' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'afb16f85-c0e3-4f28-9505-bf922a266f05', '在波涛汹涌、狂风大作的海面上航行了整整两天两夜，几位年轻科考队员脸色苍白、晕船呕吐得十分难受。', 'Zài bōtāo-xiōngyǒng, kuángfēng-dàzuò de hǎimiàn shang hángxíng le zhěngzhěng liǎng tiān liǎng yè, jǐ wèi niánqīng kēkǎo duìyuán liǎnsè cāngbái, yùnchuán ǒutù de shífēn nánshòu.', 'Đi trên mặt biển sóng to gió lớn gào thét suốt tròn hai ngày hai đêm, mấy thành viên đoàn khảo sát trẻ tuổi sắc mặt trắng bệch, say sóng nôn nao vô cùng khó chịu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'afb16f85-c0e3-4f28-9505-bf922a266f05'
);

-- [运行] (yùnxíng): vận hành, chuyển động
UPDATE public.vocabularies
SET example_hanzi = '高速铁路全线配备的智能调度列车控制系统日夜安全稳定运行，为数以亿计旅客的平安出行保驾护航。',
    example_pinyin = 'Gāosù tiělù quánxiàn pèibèi de zhìnéng diàodù lièchē kòngzhì xìtǒng rìyè ānquán wěndìng yùnxíng, wèi shù yǐ yì jì lǚkè de píng''ān chūxíng bǎojià-hùháng.',
    example_vi = 'Hệ thống điều độ điều khiển tàu thông minh trang bị toàn tuyến đường sắt cao tốc ngày đêm vận hành an toàn ổn định, hộ tống bảo vệ cho sự đi lại bình an của hàng trăm triệu lượt hành khách.'
WHERE id = 'b66e9b75-8823-412e-910b-5eb620fcf18b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b66e9b75-8823-412e-910b-5eb620fcf18b', '高速铁路全线配备的智能调度列车控制系统日夜安全稳定运行，为数以亿计旅客的平安出行保驾护航。', 'Gāosù tiělù quánxiàn pèibèi de zhìnéng diàodù lièchē kòngzhì xìtǒng rìyè ānquán wěndìng yùnxíng, wèi shù yǐ yì jì lǚkè de píng''ān chūxíng bǎojià-hùháng.', 'Hệ thống điều độ điều khiển tàu thông minh trang bị toàn tuyến đường sắt cao tốc ngày đêm vận hành an toàn ổn định, hộ tống bảo vệ cho sự đi lại bình an của hàng trăm triệu lượt hành khách.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b66e9b75-8823-412e-910b-5eb620fcf18b'
);

-- [预期] (yùqī): dự kiến, kỳ vọng
UPDATE public.vocabularies
SET example_hanzi = '随着一系列积极稳健的宏观经济扶持政策相继出台，本季度工业生产与外贸进出口总额全面超越了市场普遍预期。',
    example_pinyin = 'Suízhe yí xìliè jījí wěnjiàn de hóngguān jīngjì fúchí zhèngcè xiāngjì chūtái, běn jìdù gōngyè shēngchǎn yǔ wàimào jìn-chūkǒu zǒng''é quánmiàn chāoyuè le shìchǎng pǔbiàn yùqī.',
    example_vi = 'Cùng với một loạt chính sách hỗ trợ kinh tế vĩ mô tích cực và ổn định lần lượt ban hành, sản xuất công nghiệp và tổng kim ngạch xuất nhập khẩu ngoại thương quý này đã vượt qua toàn diện kỳ vọng chung của thị trường.'
WHERE id = 'e365f81e-4b0e-4689-a48f-8d2db3cff8b5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e365f81e-4b0e-4689-a48f-8d2db3cff8b5', '随着一系列积极稳健的宏观经济扶持政策相继出台，本季度工业生产与外贸进出口总额全面超越了市场普遍预期。', 'Suízhe yí xìliè jījí wěnjiàn de hóngguān jīngjì fúchí zhèngcè xiāngjì chūtái, běn jìdù gōngyè shēngchǎn yǔ wàimào jìn-chūkǒu zǒng''é quánmiàn chāoyuè le shìchǎng pǔbiàn yùqī.', 'Cùng với một loạt chính sách hỗ trợ kinh tế vĩ mô tích cực và ổn định lần lượt ban hành, sản xuất công nghiệp và tổng kim ngạch xuất nhập khẩu ngoại thương quý này đã vượt qua toàn diện kỳ vọng chung của thị trường.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e365f81e-4b0e-4689-a48f-8d2db3cff8b5'
);

-- [与其] (yǔqí): thay vì, thà rằng
UPDATE public.vocabularies
SET example_hanzi = '与其在面对困境与挫折时一味怨天尤人、消极等待，不如立刻振作精神、脚踏实地寻找解决问题的切实办法。',
    example_pinyin = 'Yǔqí zài miànduì kùnjìng yǔ cuòzhé shí yíwèi yuàntiān-yóurén, xiāojí děngdài, bùrú lìkè zhènzuò jīngshén, jiǎotà-shídì xúnzhǎo jiějué wèntí de qièshí bànfǎ.',
    example_vi = 'Thay vì khi đối mặt với nghịch cảnh và trắc trở cứ mù quáng than trời trách người tiêu cực chờ đợi, thà rằng hãy lập tức chấn chỉnh tinh thần, bắt tay thực tế tìm kiếm biện pháp thiết thực để giải quyết vấn đề.'
WHERE id = '03b27e22-7766-4a64-821e-c90907f4f50b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '03b27e22-7766-4a64-821e-c90907f4f50b', '与其在面对困境与挫折时一味怨天尤人、消极等待，不如立刻振作精神、脚踏实地寻找解决问题的切实办法。', 'Yǔqí zài miànduì kùnjìng yǔ cuòzhé shí yíwèi yuàntiān-yóurén, xiāojí děngdài, bùrú lìkè zhènzuò jīngshén, jiǎotà-shídì xúnzhǎo jiějué wèntí de qièshí bànfǎ.', 'Thay vì khi đối mặt với nghịch cảnh và trắc trở cứ mù quáng than trời trách người tiêu cực chờ đợi, thà rằng hãy lập tức chấn chỉnh tinh thần, bắt tay thực tế tìm kiếm biện pháp thiết thực để giải quyết vấn đề.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '03b27e22-7766-4a64-821e-c90907f4f50b'
);

-- [欲望] (yùwàng): dục vọng, ham muốn
UPDATE public.vocabularies
SET example_hanzi = '一个真正自律且思想成熟的人，懂得如何理性克制盲目攀比与过度消费的冲动，绝不做不良欲望的奴隶。',
    example_pinyin = 'Yí gè zhēnzhèng zìlǜ qiě sīxiǎng chéngshú de rén, dǒngde rúhé lǐxìng kèzhì mángmù pānbǐ yǔ guòdù xiāofèi de chōngdòng, jué bú zuò bùliáng yùwàng de núlì.',
    example_vi = 'Một người thực sự kỷ luật tự giác và có tư tưởng chín chắn hiểu được cách khắc chế lý tính sự bốc đồng đua đòi mù quáng và tiêu dùng quá đà, tuyệt đối không làm nô lệ cho những ham muốn dục vọng xấu xa.'
WHERE id = '044f78e5-cb8d-44f7-969d-db2ada0b30ce' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '044f78e5-cb8d-44f7-969d-db2ada0b30ce', '一个真正自律且思想成熟的人，懂得如何理性克制盲目攀比与过度消费的冲动，绝不做不良欲望的奴隶。', 'Yí gè zhēnzhèng zìlǜ qiě sīxiǎng chéngshú de rén, dǒngde rúhé lǐxìng kèzhì mángmù pānbǐ yǔ guòdù xiāofèi de chōngdòng, jué bú zuò bùliáng yùwàng de núlì.', 'Một người thực sự kỷ luật tự giác và có tư tưởng chín chắn hiểu được cách khắc chế lý tính sự bốc đồng đua đòi mù quáng và tiêu dùng quá đà, tuyệt đối không làm nô lệ cho những ham muốn dục vọng xấu xa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '044f78e5-cb8d-44f7-969d-db2ada0b30ce'
);

-- [灾害] (zāihài): tai họa, thảm họa
UPDATE public.vocabularies
SET example_hanzi = '通过建立空天地一体化卫星遥感监测预警网络，国家防灾减灾救灾指挥中心能极为高效地应对各类自然灾害。',
    example_pinyin = 'Tōngguò jiànlì kōng-tiān-dì yītǐhuà wèixīng yáogǎn jiāncè yùjǐng wǎngluò, guójiā fángzāi jiǎnzāi jiùzāi zhǐhuī zhōngxīn néng jíqí gāoxiào de yìngduì gè lèi zìrán zāihài.',
    example_vi = 'Thông qua việc xây dựng mạng lưới cảnh báo giám sát viễn thám vệ tinh tích hợp không - vũ trụ - mặt đất, Trung tâm Chỉ huy Phòng chống Giảm nhẹ Thiên tai Quốc gia có thể ứng phó cực kỳ hiệu quả với mọi loại thảm họa tai ương tự nhiên.'
WHERE id = 'c0f07afd-c137-46f9-9d7b-8218d4b30010' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c0f07afd-c137-46f9-9d7b-8218d4b30010', '通过建立空天地一体化卫星遥感监测预警网络，国家防灾减灾救灾指挥中心能极为高效地应对各类自然灾害。', 'Tōngguò jiànlì kōng-tiān-dì yītǐhuà wèixīng yáogǎn jiāncè yùjǐng wǎngluò, guójiā fángzāi jiǎnzāi jiùzāi zhǐhuī zhōngxīn néng jíqí gāoxiào de yìngduì gè lèi zìrán zāihài.', 'Thông qua việc xây dựng mạng lưới cảnh báo giám sát viễn thám vệ tinh tích hợp không - vũ trụ - mặt đất, Trung tâm Chỉ huy Phòng chống Giảm nhẹ Thiên tai Quốc gia có thể ứng phó cực kỳ hiệu quả với mọi loại thảm họa tai ương tự nhiên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c0f07afd-c137-46f9-9d7b-8218d4b30010'
);

-- [灾难] (zāinàn): tai họa, thảm họa
UPDATE public.vocabularies
SET example_hanzi = '在那场突如其来的强烈大地震灾难发生后，全国上下八方支援、众志成城，迅速展开了感天动地的生死大救援。',
    example_pinyin = 'Zài nà chǎng tūrúqílái de qiángliè dà dìzhèn zāinàn fāshēng hòu, quánguó shàngxià bāfāng-zhīyuán, zhòngzhì-chéngchéng, xùnsù zhǎnkāi le gǎntiān-dòngdì de shēngsǐ dà jiùyuán.',
    example_vi = 'Sau khi thảm họa trận động đất lớn dữ dội bất ngờ xảy ra, trên dưới toàn quốc bốn phương chi viện muôn người như một, nhanh chóng mở ra chiến dịch đại cứu hộ sinh tử làm lay động cả đất trời.'
WHERE id = '114209f0-a77e-4cdc-80b9-ad0692705b55' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '114209f0-a77e-4cdc-80b9-ad0692705b55', '在那场突如其来的强烈大地震灾难发生后，全国上下八方支援、众志成城，迅速展开了感天动地的生死大救援。', 'Zài nà chǎng tūrúqílái de qiángliè dà dìzhèn zāinàn fāshēng hòu, quánguó shàngxià bāfāng-zhīyuán, zhòngzhì-chéngchéng, xùnsù zhǎnkāi le gǎntiān-dòngdì de shēngsǐ dà jiùyuán.', 'Sau khi thảm họa trận động đất lớn dữ dội bất ngờ xảy ra, trên dưới toàn quốc bốn phương chi viện muôn người như một, nhanh chóng mở ra chiến dịch đại cứu hộ sinh tử làm lay động cả đất trời.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '114209f0-a77e-4cdc-80b9-ad0692705b55'
);

-- [再三] (zàisān): nhiều lần, lặp đi lặp lại
UPDATE public.vocabularies
SET example_hanzi = '在与外商正式签署涉及数十亿美元的重大战略并购合同之前，法务顾问专家组再三仔细推敲每个条款细节。',
    example_pinyin = 'Zài yǔ wàishāng zhèngshì qiānshǔ shèjí shùshí yì měiyuán de zhòngdà zhànlüè bìnggòu hétong zhīqián, fǎwù gùwèn zhuānjiā zǔ zàisān zǐxì tuīqiāo měi gè tiáokuǎn xìjié.',
    example_vi = 'Trước khi chính thức ký kết hợp đồng sáp nhập chiến lược trọng đại trị giá hàng tỷ USD với đối tác nước ngoài, tổ chuyên gia cố vấn pháp lý đã nhiều lần lặp đi lặp lại cẩn thận cân nhắc từng chi tiết điều khoản.'
WHERE id = 'd6a54def-5aa4-4388-a20f-2e429b535cf9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd6a54def-5aa4-4388-a20f-2e429b535cf9', '在与外商正式签署涉及数十亿美元的重大战略并购合同之前，法务顾问专家组再三仔细推敲每个条款细节。', 'Zài yǔ wàishāng zhèngshì qiānshǔ shèjí shùshí yì měiyuán de zhòngdà zhànlüè bìnggòu hétong zhīqián, fǎwù gùwèn zhuānjiā zǔ zàisān zǐxì tuīqiāo měi gè tiáokuǎn xìjié.', 'Trước khi chính thức ký kết hợp đồng sáp nhập chiến lược trọng đại trị giá hàng tỷ USD với đối tác nước ngoài, tổ chuyên gia cố vấn pháp lý đã nhiều lần lặp đi lặp lại cẩn thận cân nhắc từng chi tiết điều khoản.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd6a54def-5aa4-4388-a20f-2e429b535cf9'
);

-- [在意] (zàiyì): để ý, bận tâm
UPDATE public.vocabularies
SET example_hanzi = '只要我们问心无愧并且朝着正确崇高的目标笃定前行，又何必过于在意旁人偶尔投来的不理解目光呢。',
    example_pinyin = 'Zhǐyào wǒmen wènxīn-wúkuì bìngqiě cháozhe zhèngquè chónggāo de mùbiāo dǔdìng qiánxíng, yòu hébì guòyú zàiyì pángrén ǒu''ěr tóulái de bù lǐjiě mùguāng ne.',
    example_vi = 'Chỉ cần chúng ta không thẹn với lòng và vững vàng tiến về phía mục tiêu cao đẹp đúng đắn, thì cớ sao phải quá để ý bận tâm đến ánh mắt thiếu thấu hiểu thi thoảng của người bên cạnh.'
WHERE id = '2ad899d5-f22b-4b41-976d-47110d869761' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2ad899d5-f22b-4b41-976d-47110d869761', '只要我们问心无愧并且朝着正确崇高的目标笃定前行，又何必过于在意旁人偶尔投来的不理解目光呢。', 'Zhǐyào wǒmen wènxīn-wúkuì bìngqiě cháozhe zhèngquè chónggāo de mùbiāo dǔdìng qiánxíng, yòu hébì guòyú zàiyì pángrén ǒu''ěr tóulái de bù lǐjiě mùguāng ne.', 'Chỉ cần chúng ta không thẹn với lòng và vững vàng tiến về phía mục tiêu cao đẹp đúng đắn, thì cớ sao phải quá để ý bận tâm đến ánh mắt thiếu thấu hiểu thi thoảng của người bên cạnh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2ad899d5-f22b-4b41-976d-47110d869761'
);

-- [遭受] (zāoshòu): chịu đựng, gặp phải
UPDATE public.vocabularies
SET example_hanzi = '尽管这家百年老店在突如其来的罕见洪涝灾害中遭受了严重的财产损失，但全体职工同舟共济迅速恢复了营业。',
    example_pinyin = 'Jǐnguǎn zhè jiā bǎinián lǎodiàn zài tūrúqílái de hǎnjiàn hónglào zāihài zhōng zāoshòu le yánzhòng de cáichǎn sǔnshī, dàn quántǐ zhígōng tóngzhōu-gòngjì xùnsù huīfù le yíngyè.',
    example_vi = 'Mặc dù cửa hiệu trăm năm này trong thảm họa mưa lũ ngập lụt hiếm thấy ập đến đã phải gánh chịu thiệt hại tài sản nghiêm trọng, nhưng toàn thể nhân viên đồng lòng chung sức đã nhanh chóng khôi phục hoạt động kinh doanh.'
WHERE id = 'd727347a-109a-4ea5-aeea-13313facd48e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd727347a-109a-4ea5-aeea-13313facd48e', '尽管这家百年老店在突如其来的罕见洪涝灾害中遭受了严重的财产损失，但全体职工同舟共济迅速恢复了营业。', 'Jǐnguǎn zhè jiā bǎinián lǎodiàn zài tūrúqílái de hǎnjiàn hónglào zāihài zhōng zāoshòu le yánzhòng de cáichǎn sǔnshī, dàn quántǐ zhígōng tóngzhōu-gòngjì xùnsù huīfù le yíngyè.', 'Mặc dù cửa hiệu trăm năm này trong thảm họa mưa lũ ngập lụt hiếm thấy ập đến đã phải gánh chịu thiệt hại tài sản nghiêm trọng, nhưng toàn thể nhân viên đồng lòng chung sức đã nhanh chóng khôi phục hoạt động kinh doanh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd727347a-109a-4ea5-aeea-13313facd48e'
);

-- [造型] (zàoxíng): tạo hình, kiểu dáng
UPDATE public.vocabularies
SET example_hanzi = '新近落成启用的市文化艺术中心外观造型犹如一朵盛开在江畔的巨大莲花，极具现代建筑的视觉冲击力。',
    example_pinyin = 'Xīnjìn luòchéng qǐyòng de shì wénhuà yìshù zhōngxīn wàiguān zàoxíng yóurú yì duǒ shèngkāi zài jiāngpàn de jùdà liánhuā, jíbǐng xiàndài jiànzhù de shìjué chōngjīlì.',
    example_vi = 'Trung tâm Văn hóa Nghệ thuật thành phố mới hoàn thành đưa vào sử dụng có hình dáng tạo hình bề ngoài tựa như một đóa hoa sen khổng lồ nở rộ bên bờ sông, mang sức mạnh thị giác cực lớn của kiến trúc hiện đại.'
WHERE id = '2db23ec0-e7e9-4a07-a776-b7a15a961d21' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2db23ec0-e7e9-4a07-a776-b7a15a961d21', '新近落成启用的市文化艺术中心外观造型犹如一朵盛开在江畔的巨大莲花，极具现代建筑的视觉冲击力。', 'Xīnjìn luòchéng qǐyòng de shì wénhuà yìshù zhōngxīn wàiguān zàoxíng yóurú yì duǒ shèngkāi zài jiāngpàn de jùdà liánhuā, jíbǐng xiàndài jiànzhù de shìjué chōngjīlì.', 'Trung tâm Văn hóa Nghệ thuật thành phố mới hoàn thành đưa vào sử dụng có hình dáng tạo hình bề ngoài tựa như một đóa hoa sen khổng lồ nở rộ bên bờ sông, mang sức mạnh thị giác cực lớn của kiến trúc hiện đại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2db23ec0-e7e9-4a07-a776-b7a15a961d21'
);

-- [遭遇] (zāoyù): gặp phải, cảnh ngộ
UPDATE public.vocabularies
SET example_hanzi = '这位身处逆境却自强不息的青年作家，将自己童年时代所经历的坎坷辛酸遭遇写成了一部轰动文坛的自传体小说。',
    example_pinyin = 'Zhè wèi shēnchǔ nìjìng què zìqiáng-bùxī de qīngnián zuòjiā, jiāng zìjǐ tóngnián shídài suǒ jīnglì de kǎnkě xīnsuān zāoyù xiě chéng le yí bù hōngdòng wéntán de zìzhuàntǐ xiǎoshuō.',
    example_vi = 'Nhà văn trẻ tuổi ở trong nghịch cảnh mà không ngừng vươn lên này đã viết cảnh ngộ gian truân cay đắng trải qua thời thơ ấu thành cuốn tiểu thuyết tự truyện làm chấn động văn đàn.'
WHERE id = '2a6ed424-fe27-426a-a33a-a4bde3b65c61' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2a6ed424-fe27-426a-a33a-a4bde3b65c61', '这位身处逆境却自强不息的青年作家，将自己童年时代所经历的坎坷辛酸遭遇写成了一部轰动文坛的自传体小说。', 'Zhè wèi shēnchǔ nìjìng què zìqiáng-bùxī de qīngnián zuòjiā, jiāng zìjǐ tóngnián shídài suǒ jīnglì de kǎnkě xīnsuān zāoyù xiě chéng le yí bù hōngdòng wéntán de zìzhuàntǐ xiǎoshuō.', 'Nhà văn trẻ tuổi ở trong nghịch cảnh mà không ngừng vươn lên này đã viết cảnh ngộ gian truân cay đắng trải qua thời thơ ấu thành cuốn tiểu thuyết tự truyện làm chấn động văn đàn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2a6ed424-fe27-426a-a33a-a4bde3b65c61'
);

-- [则] (zé): thì, quy tắc, bài/mẩu
UPDATE public.vocabularies
SET example_hanzi = '在本次辩论赛中，正方观点主张科技创新应当重在颠覆突破，反方观点则强调必须筑牢技术伦理与安全底线。',
    example_pinyin = 'Zài běncì biànlùnsài zhōng, zhèngfāng guāndiǎn zhǔzhāng kējì chuàngxīn yīngdāng zhòng zài diānfù tūpò, fǎnfāng guāndiǎn zé qiángdiào bìxū zhùláo jìshù lúnlǐ yǔ ānquán dǐxiàn.',
    example_vi = 'Tại cuộc thi tranh biện lần này, quan điểm của bên thuận chủ trương đổi mới công nghệ nên trọng tâm vào đột phá thay đổi cục diện, quan điểm bên nghịch thì nhấn mạnh cần đắp vững giới hạn đạo đức và an toàn kỹ thuật.'
WHERE id = '0155c434-074b-4c8d-8bc9-0b4616ea3acb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0155c434-074b-4c8d-8bc9-0b4616ea3acb', '在本次辩论赛中，正方观点主张科技创新应当重在颠覆突破，反方观点则强调必须筑牢技术伦理与安全底线。', 'Zài běncì biànlùnsài zhōng, zhèngfāng guāndiǎn zhǔzhāng kējì chuàngxīn yīngdāng zhòng zài diānfù tūpò, fǎnfāng guāndiǎn zé qiángdiào bìxū zhùláo jìshù lúnlǐ yǔ ānquán dǐxiàn.', 'Tại cuộc thi tranh biện lần này, quan điểm của bên thuận chủ trương đổi mới công nghệ nên trọng tâm vào đột phá thay đổi cục diện, quan điểm bên nghịch thì nhấn mạnh cần đắp vững giới hạn đạo đức và an toàn kỹ thuật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0155c434-074b-4c8d-8bc9-0b4616ea3acb'
);

-- [扎] (zhā): châm, đâm, cắm
UPDATE public.vocabularies
SET example_hanzi = '老中医在仔细号脉并问清病情后，取出银针沉稳精准地在患者膝关节穴位上扎了几针，疼痛随即大为缓解。',
    example_pinyin = 'Lǎo zhōngyī zài zǐxì hàomài bìng wènqīng bìngqíng hòu, qǔchū yínzhēn chénwěn jīngzhǔn de zài huànzhě xīguānjié xuéwèi shang zhā le jǐ zhēn, téngtòng suíjí dàwéi huǎnjiě.',
    example_vi = 'Thầy thuốc đông y lão thành sau khi bắt mạch kỹ lưỡng và hỏi rõ bệnh tình đã lấy kim bạc châm cứu trầm tĩnh chuẩn xác vài mũi vào huyệt vị khớp gối người bệnh, cơn đau lập tức thuyên giảm phần nhiều.'
WHERE id = '2dba889c-e79d-4cf6-909a-2bb015efec9b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2dba889c-e79d-4cf6-909a-2bb015efec9b', '老中医在仔细号脉并问清病情后，取出银针沉稳精准地在患者膝关节穴位上扎了几针，疼痛随即大为缓解。', 'Lǎo zhōngyī zài zǐxì hàomài bìng wènqīng bìngqíng hòu, qǔchū yínzhēn chénwěn jīngzhǔn de zài huànzhě xīguānjié xuéwèi shang zhā le jǐ zhēn, téngtòng suíjí dàwéi huǎnjiě.', 'Thầy thuốc đông y lão thành sau khi bắt mạch kỹ lưỡng và hỏi rõ bệnh tình đã lấy kim bạc châm cứu trầm tĩnh chuẩn xác vài mũi vào huyệt vị khớp gối người bệnh, cơn đau lập tức thuyên giảm phần nhiều.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2dba889c-e79d-4cf6-909a-2bb015efec9b'
);

-- [崭新] (zhǎn xīn): mới tinh, hoàn toàn mới
UPDATE public.vocabularies
SET example_hanzi = '跨入新时代，伴随着以新能源与人工智能为代表的产业革命，人类社会正在昂首迈入一个崭新的历史阶段。',
    example_pinyin = 'Kuàrù xīn shídài, bànsuí zhe yǐ xīn néngyuán yǔ réngōng zhìnéng wéi dàibiǎo de chǎnyè gémìng, rénlèi shèhuì zhèngzài ángshǒu màirù yí gè zhǎnxīn de lìshǐ jiēduàn.',
    example_vi = 'Bước vào thời đại mới, cùng với cuộc cách mạng công nghiệp đại diện bởi năng lượng mới và trí tuệ nhân tạo, xã hội loài người đang ngẩng cao đầu tiến bước vào một giai đoạn lịch sử hoàn toàn mới.'
WHERE id = 'd3cfa923-f192-466b-b213-3cf171d09cb2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd3cfa923-f192-466b-b213-3cf171d09cb2', '跨入新时代，伴随着以新能源与人工智能为代表的产业革命，人类社会正在昂首迈入一个崭新的历史阶段。', 'Kuàrù xīn shídài, bànsuí zhe yǐ xīn néngyuán yǔ réngōng zhìnéng wéi dàibiǎo de chǎnyè gémìng, rénlèi shèhuì zhèngzài ángshǒu màirù yí gè zhǎnxīn de lìshǐ jiēduàn.', 'Bước vào thời đại mới, cùng với cuộc cách mạng công nghiệp đại diện bởi năng lượng mới và trí tuệ nhân tạo, xã hội loài người đang ngẩng cao đầu tiến bước vào một giai đoạn lịch sử hoàn toàn mới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd3cfa923-f192-466b-b213-3cf171d09cb2'
);

-- [战斗] (zhàndòu): chiến đấu
UPDATE public.vocabularies
SET example_hanzi = '在这场抗击突发重大传染病疫情的严峻考验中，广大白衣天使夜以继日战斗在抢救危重症患者的最前沿阵地。',
    example_pinyin = 'Zài zhè chǎng kàngjī tūfā zhòngdà chuánrǎnbìng yìqíng de yánjùn kǎoyàn zhōng, guǎngdà báiyī tiānshǐ yèyǐjìrì zhàndòu zài qiǎngjiù wēizhòngzhèng huànzhě de zuì qiányán zhèndì.',
    example_vi = 'Trong thử thách gay gắt của trận chiến chống lại dịch bệnh truyền nhiễm nghiêm trọng bất ngờ ập đến này, đông đảo thiên thần áo trắng ngày đêm chiến đấu nơi tuyến đầu cấp cứu bệnh nhân nguy kịch.'
WHERE id = '2d433c8c-7730-4cd0-adb3-9322c636ff26' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2d433c8c-7730-4cd0-adb3-9322c636ff26', '在这场抗击突发重大传染病疫情的严峻考验中，广大白衣天使夜以继日战斗在抢救危重症患者的最前沿阵地。', 'Zài zhè chǎng kàngjī tūfā zhòngdà chuánrǎnbìng yìqíng de yánjùn kǎoyàn zhōng, guǎngdà báiyī tiānshǐ yèyǐjìrì zhàndòu zài qiǎngjiù wēizhòngzhèng huànzhě de zuì qiányán zhèndì.', 'Trong thử thách gay gắt của trận chiến chống lại dịch bệnh truyền nhiễm nghiêm trọng bất ngờ ập đến này, đông đảo thiên thần áo trắng ngày đêm chiến đấu nơi tuyến đầu cấp cứu bệnh nhân nguy kịch.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2d433c8c-7730-4cd0-adb3-9322c636ff26'
);

-- [障碍] (zhàng'ài): chướng ngại, rào cản
UPDATE public.vocabularies
SET example_hanzi = '为了切实方便残障人士与老年人独立出行，各城市市政交通部门在所有公共场所全面清除了无障碍通行的物理障碍。',
    example_pinyin = 'Wèile qièshí fāngbiàn cánzhàng rénshì yǔ lǎoniánrén dúlì chūxíng, gè chéngshì shìzhèng jiāotōng bùmén zài suǒyǒu gōnggòng chǎngsuǒ quánmiàn qīngchú le wúzhàng''ài tōngxíng de wùlǐ zhàng''ài.',
    example_vi = 'Để tạo thuận lợi thiết thực cho người khuyết tật và người cao tuổi đi lại độc lập, ngành giao thông đô thị các thành phố tại mọi nơi công cộng đã dẹp bỏ toàn diện các rào cản vật lý cản trở đi lại không rào cản.'
WHERE id = '7afba4cf-2f7d-41de-ab6e-4ea7cad94e5f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7afba4cf-2f7d-41de-ab6e-4ea7cad94e5f', '为了切实方便残障人士与老年人独立出行，各城市市政交通部门在所有公共场所全面清除了无障碍通行的物理障碍。', 'Wèile qièshí fāngbiàn cánzhàng rénshì yǔ lǎoniánrén dúlì chūxíng, gè chéngshì shìzhèng jiāotōng bùmén zài suǒyǒu gōnggòng chǎngsuǒ quánmiàn qīngchú le wúzhàng''ài tōngxíng de wùlǐ zhàng''ài.', 'Để tạo thuận lợi thiết thực cho người khuyết tật và người cao tuổi đi lại độc lập, ngành giao thông đô thị các thành phố tại mọi nơi công cộng đã dẹp bỏ toàn diện các rào cản vật lý cản trở đi lại không rào cản.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7afba4cf-2f7d-41de-ab6e-4ea7cad94e5f'
);

-- [占据] (zhànjù): chiếm cứ, chiếm giữ
UPDATE public.vocabularies
SET example_hanzi = '凭借在全固态电池领域取得的重大核心专利突破，该跨国高新技术企业牢牢占据了全球产业链的制高点。',
    example_pinyin = 'Píngjiè zài quán gùtài diànchí lǐngyù qùdé de zhòngdà héxīn zhuānlì tūpò, gāi kuàguó gāoxīn jìshù qǐyè láoláo zhànjù le quánqiú chǎnyèliàn de zhìgāodiǎn.',
    example_vi = 'Nhờ vào đột phá bằng sáng chế cốt lõi trọng đại giành được trong lĩnh vực pin thể rắn hoàn toàn, doanh nghiệp công nghệ cao đa quốc gia này đã chiếm giữ vững chắc điểm cao nhất của chuỗi công nghiệp toàn cầu.'
WHERE id = '6cc3d2e7-6f61-4c76-b106-ee3620c2150a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6cc3d2e7-6f61-4c76-b106-ee3620c2150a', '凭借在全固态电池领域取得的重大核心专利突破，该跨国高新技术企业牢牢占据了全球产业链的制高点。', 'Píngjiè zài quán gùtài diànchí lǐngyù qùdé de zhòngdà héxīn zhuānlì tūpò, gāi kuàguó gāoxīn jìshù qǐyè láoláo zhànjù le quánqiú chǎnyèliàn de zhìgāodiǎn.', 'Nhờ vào đột phá bằng sáng chế cốt lõi trọng đại giành được trong lĩnh vực pin thể rắn hoàn toàn, doanh nghiệp công nghệ cao đa quốc gia này đã chiếm giữ vững chắc điểm cao nhất của chuỗi công nghiệp toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6cc3d2e7-6f61-4c76-b106-ee3620c2150a'
);

-- [粘贴] (zhāntiē): dán
UPDATE public.vocabularies
SET example_hanzi = '档案管理员在将重要纸质历史文书进行分类归档整理后，在每个牛皮纸档案盒封面上规范粘贴了检索条形码。',
    example_pinyin = 'Dàng''àn guǎnlǐyuán zài jiāng zhòngyào zhǐzhì lìshǐ wénshū jìnxíng fēnlèi guīdàng zhěnglǐ hòu, zài měi gè niúpízhǐ dàng''àn hé fēngmiàn shang guīfàn zhāntiē le jiǎnsuǒ tiáoxíngmǎ.',
    example_vi = 'Nhân viên quản lý hồ sơ lưu trữ sau khi phân loại sắp xếp văn thư lịch sử bằng giấy quan trọng vào kho đã dán mã vạch tra cứu theo quy chuẩn lên bìa mỗi hộp hồ sơ giấy xi măng.'
WHERE id = '0038611a-e4e0-4666-82c8-eb29b86b5f93' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0038611a-e4e0-4666-82c8-eb29b86b5f93', '档案管理员在将重要纸质历史文书进行分类归档整理后，在每个牛皮纸档案盒封面上规范粘贴了检索条形码。', 'Dàng''àn guǎnlǐyuán zài jiāng zhòngyào zhǐzhì lìshǐ wénshū jìnxíng fēnlèi guīdàng zhěnglǐ hòu, zài měi gè niúpízhǐ dàng''àn hé fēngmiàn shang guīfàn zhāntiē le jiǎnsuǒ tiáoxíngmǎ.', 'Nhân viên quản lý hồ sơ lưu trữ sau khi phân loại sắp xếp văn thư lịch sử bằng giấy quan trọng vào kho đã dán mã vạch tra cứu theo quy chuẩn lên bìa mỗi hộp hồ sơ giấy xi măng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0038611a-e4e0-4666-82c8-eb29b86b5f93'
);

-- [战争] (zhànzhēng): chiến tranh
UPDATE public.vocabularies
SET example_hanzi = '饱受战乱之苦的平民深知和平生活的来之不易，全世界爱好和平的人民始终坚决反对任何形式的非正义侵略战争。',
    example_pinyin = 'Bǎoshòu zhànluàn zhī kǔ de píngmín shēnzhī hépíng shēnghuó de láizhī-bùyì, quán shìjiè àihào hépíng de rénmín shǐzhōng jiānjué fǎnduì rènhé xíngshì de fēizhèngyì qīnlüè zhànzhēng.',
    example_vi = 'Những thường dân nếm trải nỗi đau của loạn lạc chiến tranh hiểu sâu sắc cuộc sống hòa bình đáng quý biết chừng nào, nhân dân yêu chuộng hòa bình toàn thế giới luôn kiên quyết phản đối chiến tranh xâm lược phi nghĩa dưới mọi hình thức.'
WHERE id = 'cdd1806a-c80e-4cdf-a32e-6d5e2096c823' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cdd1806a-c80e-4cdf-a32e-6d5e2096c823', '饱受战乱之苦的平民深知和平生活的来之不易，全世界爱好和平的人民始终坚决反对任何形式的非正义侵略战争。', 'Bǎoshòu zhànluàn zhī kǔ de píngmín shēnzhī hépíng shēnghuó de láizhī-bùyì, quán shìjiè àihào hépíng de rénmín shǐzhōng jiānjué fǎnduì rènhé xíngshì de fēizhèngyì qīnlüè zhànzhēng.', 'Những thường dân nếm trải nỗi đau của loạn lạc chiến tranh hiểu sâu sắc cuộc sống hòa bình đáng quý biết chừng nào, nhân dân yêu chuộng hòa bình toàn thế giới luôn kiên quyết phản đối chiến tranh xâm lược phi nghĩa dưới mọi hình thức.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cdd1806a-c80e-4cdf-a32e-6d5e2096c823'
);

-- [招待] (zhāodài): chiêu đãi, tiếp đãi
UPDATE public.vocabularies
SET example_hanzi = '好客质朴的草原牧民拿出自家刚刚烤制得金黄酥脆的羊腿和喷香醇厚的奶茶，热情真诚地招待远道而来的尊贵客人。',
    example_pinyin = 'Hàokè zhìpǔ de cǎoyuán mùmín ná chū zìjiā gānggāng kǎozhì de jīnhuáng-sūcuì de yángtuǐ hé pènxiāng-chúnhòu de nǎichá, rèqíng zhēnchéng de zhāodài yuǎndào''érlái de zūnguì kèrén.',
    example_vi = 'Những người du mục thảo nguyên hiếu khách chất phác mang đùi cừu vừa nướng vàng rộm giòn tan của nhà mình cùng trà sữa thơm lừng béo ngậy ra nhiệt tình chân thành chiêu đãi tiếp đãi vị khách quý từ phương xa tới.'
WHERE id = '6cc8bbb5-6d38-43aa-8cda-38f31873483b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6cc8bbb5-6d38-43aa-8cda-38f31873483b', '好客质朴的草原牧民拿出自家刚刚烤制得金黄酥脆的羊腿和喷香醇厚的奶茶，热情真诚地招待远道而来的尊贵客人。', 'Hàokè zhìpǔ de cǎoyuán mùmín ná chū zìjiā gānggāng kǎozhì de jīnhuáng-sūcuì de yángtuǐ hé pènxiāng-chúnhòu de nǎichá, rèqíng zhēnchéng de zhāodài yuǎndào''érlái de zūnguì kèrén.', 'Những người du mục thảo nguyên hiếu khách chất phác mang đùi cừu vừa nướng vàng rộm giòn tan của nhà mình cùng trà sữa thơm lừng béo ngậy ra nhiệt tình chân thành chiêu đãi tiếp đãi vị khách quý từ phương xa tới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6cc8bbb5-6d38-43aa-8cda-38f31873483b'
);

-- [招收] (zhāoshōu): chiêu sinh, tuyển nhận
UPDATE public.vocabularies
SET example_hanzi = '这所享有极高声誉的国家级重点实验室今年面向全国高校，公开择优招收三十名优秀免试直博研究生。',
    example_pinyin = 'Zhè suǒ xiǎngyǒu jígāo shēngyù de guójiājí zhòngdiǎn shíyànshì jīnnián miànxiàng quánguó gāoxiào, gōngkāi zéyōu zhāoshōu sānshí míng yōuxiù miǎnshì zhíbó yánjiūshēng.',
    example_vi = 'Phòng thí nghiệm trọng điểm cấp quốc gia được hưởng danh tiếng cực cao này năm nay hướng về các trường đại học toàn quốc, tuyển chọn công khai 30 nghiên cứu sinh trực tiếp làm tiến sĩ miễn thi ưu tú.'
WHERE id = 'a5aca4e9-67db-4fdb-8453-5306fef5a7e5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a5aca4e9-67db-4fdb-8453-5306fef5a7e5', '这所享有极高声誉的国家级重点实验室今年面向全国高校，公开择优招收三十名优秀免试直博研究生。', 'Zhè suǒ xiǎngyǒu jígāo shēngyù de guójiājí zhòngdiǎn shíyànshì jīnnián miànxiàng quánguó gāoxiào, gōngkāi zéyōu zhāoshōu sānshí míng yōuxiù miǎnshì zhíbó yánjiūshēng.', 'Phòng thí nghiệm trọng điểm cấp quốc gia được hưởng danh tiếng cực cao này năm nay hướng về các trường đại học toàn quốc, tuyển chọn công khai 30 nghiên cứu sinh trực tiếp làm tiến sĩ miễn thi ưu tú.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a5aca4e9-67db-4fdb-8453-5306fef5a7e5'
);

-- [折] (zhé): gập, gãy, chiết khấu
UPDATE public.vocabularies
SET example_hanzi = '为了庆祝商场开业十周年纪念日，今天全场所有国际知名品牌服装一律按五折的超大优惠力度倾情回馈消费者。',
    example_pinyin = 'Wèile qìngzhù shāngchǎng kāiyè shí zhōunián jìniànrì, jīntiān quánchǎng suǒyǒu guójì zhīmíng pǐnpái fúzhuāng yílǜ àn wǔ zhé de chāodà yōuhuì lìdù qīngqíng huíkuì xiāofèizhě.',
    example_vi = 'Để chào mừng ngày kỷ niệm mười năm khai trương trung tâm mua sắm, hôm nay toàn bộ trang phục hàng hiệu nổi tiếng quốc tế đều đồng loạt giảm giá chiết khấu tới 50% để tri ân người tiêu dùng hết lòng.'
WHERE id = 'ecb5152c-254e-4939-bc84-2115127c916d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ecb5152c-254e-4939-bc84-2115127c916d', '为了庆祝商场开业十周年纪念日，今天全场所有国际知名品牌服装一律按五折的超大优惠力度倾情回馈消费者。', 'Wèile qìngzhù shāngchǎng kāiyè shí zhōunián jìniànrì, jīntiān quánchǎng suǒyǒu guójì zhīmíng pǐnpái fúzhuāng yílǜ àn wǔ zhé de chāodà yōuhuì lìdù qīngqíng huíkuì xiāofèizhě.', 'Để chào mừng ngày kỷ niệm mười năm khai trương trung tâm mua sắm, hôm nay toàn bộ trang phục hàng hiệu nổi tiếng quốc tế đều đồng loạt giảm giá chiết khấu tới 50% để tri ân người tiêu dùng hết lòng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ecb5152c-254e-4939-bc84-2115127c916d'
);

-- [睁] (zhēng): mở (mắt)
UPDATE public.vocabularies
SET example_hanzi = '清晨当第一缕明媚温暖的阳光穿透窗帘洒在床头时，睡眼惺忪的小男孩慢慢睁开双眼迎来了崭新的一天。',
    example_pinyin = 'Qīngchén dāng dìyī lǚ míngmèi wēnnuǎn de yángguāng chuāntòu chuānglián sǎ zài chuángtóu shí, shuìyǎn-xīngsōng de xiǎo nánhái mànmàn zhēng kāi shuāngyǎn yínglái le zhǎnxīn de yì tiān.',
    example_vi = 'Sáng sớm khi tia nắng mai rực rỡ ấm áp đầu tiên xuyên qua rèm cửa rọi lên đầu giường, cậu bé mắt vẫn còn mơ màng ngái ngủ từ từ mở hai mắt đón chào một ngày mới toanh.'
WHERE id = '7b5e9ba0-908b-465d-95cf-1a180000e814' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7b5e9ba0-908b-465d-95cf-1a180000e814', '清晨当第一缕明媚温暖的阳光穿透窗帘洒在床头时，睡眼惺忪的小男孩慢慢睁开双眼迎来了崭新的一天。', 'Qīngchén dāng dìyī lǚ míngmèi wēnnuǎn de yángguāng chuāntòu chuānglián sǎ zài chuángtóu shí, shuìyǎn-xīngsōng de xiǎo nánhái mànmàn zhēng kāi shuāngyǎn yínglái le zhǎnxīn de yì tiān.', 'Sáng sớm khi tia nắng mai rực rỡ ấm áp đầu tiên xuyên qua rèm cửa rọi lên đầu giường, cậu bé mắt vẫn còn mơ màng ngái ngủ từ từ mở hai mắt đón chào một ngày mới toanh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7b5e9ba0-908b-465d-95cf-1a180000e814'
);

-- [争夺] (zhēng duó): tranh đoạt, giành giật
UPDATE public.vocabularies
SET example_hanzi = '在奥运会男子百米飞人大战的决赛跑道上，来自全球顶尖的世界级短跑名将展开了扣人心弦的金牌争夺。',
    example_pinyin = 'Zài àoyùnhuì nánzǐ bǎimǐ fēirén dàzhàn de juésài pǎodào shang, láizì quánqiú dǐngjiān de shìjièjí duǎnpǎo míngjiàng zhǎnkāi le kòurénxīnxuán de jīnpái zhēngduó.',
    example_vi = 'Trên đường chạy chung kết đại chiến người bay 100 mét nam Thế vận hội Olympic, các danh tướng chạy nước rút đẳng cấp thế giới đỉnh cao toàn cầu đã mở ra cuộc tranh đoạt tấm huy chương vàng gay cấn nghẹt thở.'
WHERE id = 'be2d9d51-66b9-455a-972c-1bc4f3269584' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'be2d9d51-66b9-455a-972c-1bc4f3269584', '在奥运会男子百米飞人大战的决赛跑道上，来自全球顶尖的世界级短跑名将展开了扣人心弦的金牌争夺。', 'Zài àoyùnhuì nánzǐ bǎimǐ fēirén dàzhàn de juésài pǎodào shang, láizì quánqiú dǐngjiān de shìjièjí duǎnpǎo míngjiàng zhǎnkāi le kòurénxīnxuán de jīnpái zhēngduó.', 'Trên đường chạy chung kết đại chiến người bay 100 mét nam Thế vận hội Olympic, các danh tướng chạy nước rút đẳng cấp thế giới đỉnh cao toàn cầu đã mở ra cuộc tranh đoạt tấm huy chương vàng gay cấn nghẹt thở.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'be2d9d51-66b9-455a-972c-1bc4f3269584'
);

-- [争议] (zhēng yì): tranh cãi, bất đồng ý kiến
UPDATE public.vocabularies
SET example_hanzi = '这项涉及旧城区整体商业拆迁与历史古建筑保护的城市规划草案，在学术界与市民代表中引发了激烈的公开争议。',
    example_pinyin = 'Zhè xiàng shèjí jiù chéngqū zhěngtǐ shāngyè chāiqiān yǔ lìshǐ gǔ jiànzhù bǎohù de chéngshì guīhuà cǎo''àn, zài xuéshùjiè yǔ shìmín dàibiǎo zhōng yǐnfā le jīliè de gōngkāi zhēngyì.',
    example_vi = 'Dự thảo quy hoạch đô thị liên quan đến việc di dời thương mại tổng thể khu phố cổ và bảo tồn kiến trúc cổ lịch sử này đã làm dấy lên cuộc tranh cãi bất đồng công khai gay gắt giữa giới học thuật và đại biểu cư dân.'
WHERE id = 'bc9f8e8c-869b-4802-b6f8-a6f615d1bc64' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bc9f8e8c-869b-4802-b6f8-a6f615d1bc64', '这项涉及旧城区整体商业拆迁与历史古建筑保护的城市规划草案，在学术界与市民代表中引发了激烈的公开争议。', 'Zhè xiàng shèjí jiù chéngqū zhěngtǐ shāngyè chāiqiān yǔ lìshǐ gǔ jiànzhù bǎohù de chéngshì guīhuà cǎo''àn, zài xuéshùjiè yǔ shìmín dàibiǎo zhōng yǐnfā le jīliè de gōngkāi zhēngyì.', 'Dự thảo quy hoạch đô thị liên quan đến việc di dời thương mại tổng thể khu phố cổ và bảo tồn kiến trúc cổ lịch sử này đã làm dấy lên cuộc tranh cãi bất đồng công khai gay gắt giữa giới học thuật và đại biểu cư dân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bc9f8e8c-869b-4802-b6f8-a6f615d1bc64'
);

-- [政策] (zhèngcè): chính sách
UPDATE public.vocabularies
SET example_hanzi = '国家出台了一系列针对高新技术初创企业的税收减免与科研补贴政策，极大地提振了民营经济发展信心。',
    example_pinyin = 'Guójiā chūtái le yí xìliè zhēnduì gāoxīn jìshù chūchuàng qǐyè de shuìshōu jiǎnmiǎn yǔ kēyán bǔtiē zhèngcè, jídà de tízhèn le mínyíng jīngjì fāzhǎn xìnxīn.',
    example_vi = 'Nhà nước đã ban hành một loạt chính sách miễn giảm thuế và trợ cấp nghiên cứu khoa học hướng vào các doanh nghiệp khởi nghiệp công nghệ cao, nâng cao niềm tin phát triển kinh tế tư nhân vượt bậc.'
WHERE id = 'b0e4a6e9-2ef6-4af0-a96a-d1fd798b280f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b0e4a6e9-2ef6-4af0-a96a-d1fd798b280f', '国家出台了一系列针对高新技术初创企业的税收减免与科研补贴政策，极大地提振了民营经济发展信心。', 'Guójiā chūtái le yí xìliè zhēnduì gāoxīn jìshù chūchuàng qǐyè de shuìshōu jiǎnmiǎn yǔ kēyán bǔtiē zhèngcè, jídà de tízhèn le mínyíng jīngjì fāzhǎn xìnxīn.', 'Nhà nước đã ban hành một loạt chính sách miễn giảm thuế và trợ cấp nghiên cứu khoa học hướng vào các doanh nghiệp khởi nghiệp công nghệ cao, nâng cao niềm tin phát triển kinh tế tư nhân vượt bậc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b0e4a6e9-2ef6-4af0-a96a-d1fd798b280f'
);

-- [正规] (zhèngguī): chính quy
UPDATE public.vocabularies
SET example_hanzi = '卫生健康监督部门郑重提醒广大患者，就医看病必须前往具有正规医疗执业资质的公立或大型综合医院。',
    example_pinyin = 'Wèishēng jiànkāng jiāndū bùmén zhèngzhòng tíxǐng guǎngdà huànzhě, jiùyī kànbìng bìxū qiánwǎng jùyǒu zhèngguī yīliáo zhíyè zīzhì de gōnglì huò dàxíng zōnghé yīyuàn.',
    example_vi = 'Cơ quan giám sát vệ sinh sức khỏe thiết tha nhắc nhở đông đảo người bệnh, khi khám chữa bệnh bắt buộc phải đến các bệnh viện công lập hoặc bệnh viện đa khoa lớn có tư cách hành nghề y tế chính quy.'
WHERE id = '1f4dd95a-3f6d-4d73-99c1-89825854d4d4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1f4dd95a-3f6d-4d73-99c1-89825854d4d4', '卫生健康监督部门郑重提醒广大患者，就医看病必须前往具有正规医疗执业资质的公立或大型综合医院。', 'Wèishēng jiànkāng jiāndū bùmén zhèngzhòng tíxǐng guǎngdà huànzhě, jiùyī kànbìng bìxū qiánwǎng jùyǒu zhèngguī yīliáo zhíyè zīzhì de gōnglì huò dàxíng zōnghé yīyuàn.', 'Cơ quan giám sát vệ sinh sức khỏe thiết tha nhắc nhở đông đảo người bệnh, khi khám chữa bệnh bắt buộc phải đến các bệnh viện công lập hoặc bệnh viện đa khoa lớn có tư cách hành nghề y tế chính quy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1f4dd95a-3f6d-4d73-99c1-89825854d4d4'
);

-- [争论] (zhēnglùn): tranh luận
UPDATE public.vocabularies
SET example_hanzi = '在长达三个小时的学术专题研讨会上，学者们就新出土战国竹简的年代断定与文字释读展开了充分而友善的争论。',
    example_pinyin = 'Zài chángdá sān gè xiǎoshí de xuéshù zhuāntí yántǎohuì shang, xuézhě men jiù xīn chūtǔ zhànguó zhújiǎn de niándài duàndìng yǔ wénzì shìdú zhǎnkāi le chōngfèn ér yǒushàn de zhēnglùn.',
    example_vi = 'Tại buổi hội thảo chuyên đề học thuật kéo dài suốt ba tiếng đồng hồ, các học giả đã mở ra cuộc tranh luận cởi mở và thân thiện về việc giám định niên đại và diễn giải văn tự các thẻ tre thời Chiến Quốc mới được khai quật.'
WHERE id = '3197638f-4c8d-452c-baab-8c816c4e846b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3197638f-4c8d-452c-baab-8c816c4e846b', '在长达三个小时的学术专题研讨会上，学者们就新出土战国竹简的年代断定与文字释读展开了充分而友善的争论。', 'Zài chángdá sān gè xiǎoshí de xuéshù zhuāntí yántǎohuì shang, xuézhě men jiù xīn chūtǔ zhànguó zhújiǎn de niándài duàndìng yǔ wénzì shìdú zhǎnkāi le chōngfèn ér yǒushàn de zhēnglùn.', 'Tại buổi hội thảo chuyên đề học thuật kéo dài suốt ba tiếng đồng hồ, các học giả đã mở ra cuộc tranh luận cởi mở và thân thiện về việc giám định niên đại và diễn giải văn tự các thẻ tre thời Chiến Quốc mới được khai quật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3197638f-4c8d-452c-baab-8c816c4e846b'
);

-- [征求] (zhēngqiú): trưng cầu, xin ý kiến
UPDATE public.vocabularies
SET example_hanzi = '在重大民生法规草案正式提交人大常委会审议表决前，立法工作专班面向社会各界广泛深入征求修法意见。',
    example_pinyin = 'Zài zhòngdà mínshēng fǎguī cǎo''àn zhèngshì tíjiāo réndà chángwěihuì shěnyì biǎojué qián, lìfǎ gōngzuò zhuānbān miànxiàng shèhuì gèjiè guǎngfàn shēnrù zhēngqiú xiūfǎ yìjiàn.',
    example_vi = 'Trước khi dự thảo quy phạm pháp luật dân sinh trọng đại chính thức được trình lên Thường vụ Nhân đại xem xét biểu quyết, tổ công tác lập pháp đã tiến hành trưng cầu xin ý kiến sửa luật sâu rộng tới các tầng lớp xã hội.'
WHERE id = 'd2f38937-e0ab-4a89-9393-6836fe7de7c6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd2f38937-e0ab-4a89-9393-6836fe7de7c6', '在重大民生法规草案正式提交人大常委会审议表决前，立法工作专班面向社会各界广泛深入征求修法意见。', 'Zài zhòngdà mínshēng fǎguī cǎo''àn zhèngshì tíjiāo réndà chángwěihuì shěnyì biǎojué qián, lìfǎ gōngzuò zhuānbān miànxiàng shèhuì gèjiè guǎngfàn shēnrù zhēngqiú xiūfǎ yìjiàn.', 'Trước khi dự thảo quy phạm pháp luật dân sinh trọng đại chính thức được trình lên Thường vụ Nhân đại xem xét biểu quyết, tổ công tác lập pháp đã tiến hành trưng cầu xin ý kiến sửa luật sâu rộng tới các tầng lớp xã hội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd2f38937-e0ab-4a89-9393-6836fe7de7c6'
);

-- [证实] (zhèngshí): chứng thực, xác nhận
UPDATE public.vocabularies
SET example_hanzi = '经过多国权威天文科研团队利用全球多台大型望远镜进行联合交叉比对，这一罕见天体合并现象被彻底证实。',
    example_pinyin = 'Jīngguò duō guó quánwēi tiānwén kēyán tuánduì lìyòng quánqiú duō tái dàxíng wàngyuǎnjìng jìnxíng liánhé jiāochā bǐduì, zhè yì hǎnjiàn tiāntǐ hébìng xiànxiàng bèi chèdǐ zhèngshí.',
    example_vi = 'Trải qua việc các đội nghiên cứu thiên văn uy tín của nhiều nước dùng nhiều kính viễn vọng cỡ lớn toàn cầu tiến hành đối chiếu chéo liên hợp, hiện tượng hợp nhất thiên thể hiếm thấy này đã được chứng thực hoàn toàn.'
WHERE id = 'b404b106-0a97-4505-ade0-76953e41caa2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b404b106-0a97-4505-ade0-76953e41caa2', '经过多国权威天文科研团队利用全球多台大型望远镜进行联合交叉比对，这一罕见天体合并现象被彻底证实。', 'Jīngguò duō guó quánwēi tiānwén kēyán tuánduì lìyòng quánqiú duō tái dàxíng wàngyuǎnjìng jìnxíng liánhé jiāochā bǐduì, zhè yì hǎnjiàn tiāntǐ hébìng xiànxiàng bèi chèdǐ zhèngshí.', 'Trải qua việc các đội nghiên cứu thiên văn uy tín của nhiều nước dùng nhiều kính viễn vọng cỡ lớn toàn cầu tiến hành đối chiếu chéo liên hợp, hiện tượng hợp nhất thiên thể hiếm thấy này đã được chứng thực hoàn toàn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b404b106-0a97-4505-ade0-76953e41caa2'
);

-- [正义] (zhèngyì): chính nghĩa, công lý
UPDATE public.vocabularies
SET example_hanzi = '人民法院在审理涉及公众切身利益的重大民商事纠纷时，始终严格恪守司法中立，用判决捍卫社会的公平与正义。',
    example_pinyin = 'Rénmín fǎyuàn zài shěnlǐ shèjí gōngzhòng qièshēn lìyì de zhòngdà mínshāngshì jiūfēn shí, shǐzhōng yángé kèshǒu sīfǎ zhōnglì, yòng pànjué hànwèi shèhuì de gōngpíng yǔ zhèngyì.',
    example_vi = 'Tòa án Nhân dân khi xét xử các tranh chấp dân sự thương mại trọng đại liên quan đến lợi ích thiết thân của công chúng luôn tuân thủ nghiêm ngặt sự trung lập tư pháp, dùng phán quyết bảo vệ sự công bằng và chính nghĩa công lý của xã hội.'
WHERE id = '71ff245e-a859-49fc-9442-7131bb3d6075' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '71ff245e-a859-49fc-9442-7131bb3d6075', '人民法院在审理涉及公众切身利益的重大民商事纠纷时，始终严格恪守司法中立，用判决捍卫社会的公平与正义。', 'Rénmín fǎyuàn zài shěnlǐ shèjí gōngzhòng qièshēn lìyì de zhòngdà mínshāngshì jiūfēn shí, shǐzhōng yángé kèshǒu sīfǎ zhōnglì, yòng pànjué hànwèi shèhuì de gōngpíng yǔ zhèngyì.', 'Tòa án Nhân dân khi xét xử các tranh chấp dân sự thương mại trọng đại liên quan đến lợi ích thiết thân của công chúng luôn tuân thủ nghiêm ngặt sự trung lập tư pháp, dùng phán quyết bảo vệ sự công bằng và chính nghĩa công lý của xã hội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '71ff245e-a859-49fc-9442-7131bb3d6075'
);

-- [症状] (zhèngzhuàng): triệu chứng
UPDATE public.vocabularies
SET example_hanzi = '感染新型呼吸道流感病毒后，患者通常会出现持续高热、全身肌肉酸痛与剧烈干咳等典型临床症状。',
    example_pinyin = 'Gǎnrǎn xīnxíng hūxīdào liúgǎn bìngdú hòu, huànzhě tōngcháng huì chūxiàn chíxù gāorè, quánshēn jīròu suāntòng yǔ jùliè gānké děng diǎnxíng línchuáng zhèngzhuàng.',
    example_vi = 'Sau khi nhiễm virus cúm đường hô hấp chủng mới, người bệnh thông thường sẽ xuất hiện các triệu chứng lâm sàng điển hình như sốt cao liên tục, đau nhức mỏi cơ toàn thân và ho khan dữ dội.'
WHERE id = '2e7e74b4-a0ee-4f73-9f0a-8b9a3df98811' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2e7e74b4-a0ee-4f73-9f0a-8b9a3df98811', '感染新型呼吸道流感病毒后，患者通常会出现持续高热、全身肌肉酸痛与剧烈干咳等典型临床症状。', 'Gǎnrǎn xīnxíng hūxīdào liúgǎn bìngdú hòu, huànzhě tōngcháng huì chūxiàn chíxù gāorè, quánshēn jīròu suāntòng yǔ jùliè gānké děng diǎnxíng línchuáng zhèngzhuàng.', 'Sau khi nhiễm virus cúm đường hô hấp chủng mới, người bệnh thông thường sẽ xuất hiện các triệu chứng lâm sàng điển hình như sốt cao liên tục, đau nhức mỏi cơ toàn thân và ho khan dữ dội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2e7e74b4-a0ee-4f73-9f0a-8b9a3df98811'
);

-- [枕头] (zhěntou): cái gối
UPDATE public.vocabularies
SET example_hanzi = '为了有效缓解伏案工作引起的颈椎不适，他在医生的建议下选购了一款符合人体工学高度的乳胶枕头。',
    example_pinyin = 'Wèile yǒuxiào huǎnjiě fú''àn gōngzuò yǐnqǐ de jǐngzhuī bùshì, tā zài yīshēng de jiànyì xià xuǎngòu le yì kuǎn fúhé réntǐ gōngxué gāodù de rǔjiāo zhěntou.',
    example_vi = 'Để xoa dịu hiệu quả sự khó chịu ở đốt sống cổ do ngồi bàn làm việc lâu gây ra, theo lời khuyên của bác sĩ anh đã chọn mua một chiếc gối cao su non có độ cao phù hợp công thái học cơ thể người.'
WHERE id = '08ddcdee-3b13-40c1-9cd1-310426e054d6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '08ddcdee-3b13-40c1-9cd1-310426e054d6', '为了有效缓解伏案工作引起的颈椎不适，他在医生的建议下选购了一款符合人体工学高度的乳胶枕头。', 'Wèile yǒuxiào huǎnjiě fú''àn gōngzuò yǐnqǐ de jǐngzhuī bùshì, tā zài yīshēng de jiànyì xià xuǎngòu le yì kuǎn fúhé réntǐ gōngxué gāodù de rǔjiāo zhěntou.', 'Để xoa dịu hiệu quả sự khó chịu ở đốt sống cổ do ngồi bàn làm việc lâu gây ra, theo lời khuyên của bác sĩ anh đã chọn mua một chiếc gối cao su non có độ cao phù hợp công thái học cơ thể người.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '08ddcdee-3b13-40c1-9cd1-310426e054d6'
);

-- [真相] (zhēnxiàng): chân tướng, sự thật
UPDATE public.vocabularies
SET example_hanzi = '在高度负责的刑侦技术专家持之以恒的物证勘验与走访排查下，这桩尘封多年的悬案真相终于大白于天下。',
    example_pinyin = 'Zài gāodù fùzé de xíngzhēn jìshù zhuānjiā chízhi-yǐhéng de wùzhèng kānyàn yǔ zǒufǎng páichá xià, zhè zhuāng chénfēng duōnián de xuán''àn zhēnxiàng zhōngyú dàbái-yú-tiānxià.',
    example_vi = 'Nhờ sự kiên trì khảo sát vật chứng và rà soát thực địa không ngừng nghỉ của các chuyên gia kỹ thuật hình sự đầy tinh thần trách nhiệm cao, chân tướng sự thật của vụ án mạng treo phủ bụi nhiều năm cuối cùng đã sáng tỏ trước bàn dân thiên hạ.'
WHERE id = '640a8322-b288-4d39-9a2f-2b6e950e2f22' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '640a8322-b288-4d39-9a2f-2b6e950e2f22', '在高度负责的刑侦技术专家持之以恒的物证勘验与走访排查下，这桩尘封多年的悬案真相终于大白于天下。', 'Zài gāodù fùzé de xíngzhēn jìshù zhuānjiā chízhi-yǐhéng de wùzhèng kānyàn yǔ zǒufǎng páichá xià, zhè zhuāng chénfēng duōnián de xuán''àn zhēnxiàng zhōngyú dàbái-yú-tiānxià.', 'Nhờ sự kiên trì khảo sát vật chứng và rà soát thực địa không ngừng nghỉ của các chuyên gia kỹ thuật hình sự đầy tinh thần trách nhiệm cao, chân tướng sự thật của vụ án mạng treo phủ bụi nhiều năm cuối cùng đã sáng tỏ trước bàn dân thiên hạ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '640a8322-b288-4d39-9a2f-2b6e950e2f22'
);

-- [珍珠] (zhēnzhū): ngọc trai, trân châu
UPDATE public.vocabularies
SET example_hanzi = '在结婚三十周年纪念日那天，丈夫深情地为相濡以沫的妻子戴上了一串光彩夺目的南洋天然珍珠项链。',
    example_pinyin = 'Zài jiéhūn sānshí zhōunián jìniànrì nà tiān, zhàngfu shēnqíng de wèi xiāngrú-yǐmò de qīzǐ dài shàng le yí chuàn guāngcǎi-duómù de Nányáng tiānrán zhēnzhū xiàngliàn.',
    example_vi = 'Vào đúng ngày kỷ niệm ba mươi năm ngày cưới, người chồng tha thiết đeo lên cổ người vợ cùng sẻ chia cay ngọt một chuỗi dây chuyền ngọc trai tự nhiên Nam Dương tỏa sáng rạng ngời.'
WHERE id = '4795601f-863a-4b05-9f5f-bf3f5305aa9e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4795601f-863a-4b05-9f5f-bf3f5305aa9e', '在结婚三十周年纪念日那天，丈夫深情地为相濡以沫的妻子戴上了一串光彩夺目的南洋天然珍珠项链。', 'Zài jiéhūn sānshí zhōunián jìniànrì nà tiān, zhàngfu shēnqíng de wèi xiāngrú-yǐmò de qīzǐ dài shàng le yí chuàn guāngcǎi-duómù de Nányáng tiānrán zhēnzhū xiàngliàn.', 'Vào đúng ngày kỷ niệm ba mươi năm ngày cưới, người chồng tha thiết đeo lên cổ người vợ cùng sẻ chia cay ngọt một chuỗi dây chuyền ngọc trai tự nhiên Nam Dương tỏa sáng rạng ngời.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4795601f-863a-4b05-9f5f-bf3f5305aa9e'
);

-- [枝] (zhī): cành, nhánh
UPDATE public.vocabularies
SET example_hanzi = '春回大地，庭院墙角那株历经严冬的老梅树枝头悄然吐出了一簇簇清香扑鼻的嫩白花苞。',
    example_pinyin = 'Chūnhuí-dàdì, tíngyuàn qiángjiǎo nà zhū lìjīng yándōng de lǎo méishù zhītóu qiǎorán tǔ chū le yì cùcù qīngxiāng-pūbí de nènbái huābāo.',
    example_vi = 'Xuân về trên đất mẹ, đầu cành của cây mai già nơi góc tường sân vườn trải qua mùa đông giá rét đã lặng lẽ trổ ra từng chùm nụ hoa trắng nõn thơm ngát ngập tràn.'
WHERE id = 'b02f7867-ee75-4589-910b-7c23a8bbb4a0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b02f7867-ee75-4589-910b-7c23a8bbb4a0', '春回大地，庭院墙角那株历经严冬的老梅树枝头悄然吐出了一簇簇清香扑鼻的嫩白花苞。', 'Chūnhuí-dàdì, tíngyuàn qiángjiǎo nà zhū lìjīng yándōng de lǎo méishù zhītóu qiǎorán tǔ chū le yì cùcù qīngxiāng-pūbí de nènbái huābāo.', 'Xuân về trên đất mẹ, đầu cành của cây mai già nơi góc tường sân vườn trải qua mùa đông giá rét đã lặng lẽ trổ ra từng chùm nụ hoa trắng nõn thơm ngát ngập tràn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b02f7867-ee75-4589-910b-7c23a8bbb4a0'
);

-- [指定] (zhǐ dìng): chỉ định
UPDATE public.vocabularies
SET example_hanzi = '根据全国统一考试严格的保密规程，考生必须在监考人员指定的准考证考位上对号入座。',
    example_pinyin = 'Gēnjù quánguó tǒngyī kǎoshì yángé de bǎomì guīchéng, kǎoshēng bìxū zài jiānkǎo rényuán zhǐdìng de zhǔnkǎozhèng kǎowèi shang duìhào-rùzuò.',
    example_vi = 'Theo quy trình bảo mật nghiêm ngặt của kỳ thi thống nhất toàn quốc, thí sinh bắt buộc phải ngồi đúng vị trí phòng thi do giám thị chỉ định trên thẻ dự thi.'
WHERE id = '65573f55-e315-407a-8f06-329a4a670ee4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '65573f55-e315-407a-8f06-329a4a670ee4', '根据全国统一考试严格的保密规程，考生必须在监考人员指定的准考证考位上对号入座。', 'Gēnjù quánguó tǒngyī kǎoshì yángé de bǎomì guīchéng, kǎoshēng bìxū zài jiānkǎo rényuán zhǐdìng de zhǔnkǎozhèng kǎowèi shang duìhào-rùzuò.', 'Theo quy trình bảo mật nghiêm ngặt của kỳ thi thống nhất toàn quốc, thí sinh bắt buộc phải ngồi đúng vị trí phòng thi do giám thị chỉ định trên thẻ dự thi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '65573f55-e315-407a-8f06-329a4a670ee4'
);

-- [脂肪] (zhī fáng): chất béo, mỡ
UPDATE public.vocabularies
SET example_hanzi = '营养学专家建议广大慢性病患者合理控制每日高热量食物的摄入，少吃富含饱和脂肪的油炸食品。',
    example_pinyin = 'Yíngyǎngxué zhuānjiā jiànyì guǎngdà mànxìngbìng huànzhě hélǐ kòngzhì měirì gāo rèliàng shíwù de shèrù, shǎo chī fùhǎn bǎohé zhīfáng de yóuzhá shípǐn.',
    example_vi = 'Các chuyên gia dinh dưỡng khuyên đông đảo người mắc bệnh mạn tính nên kiểm soát hợp lý lượng thức ăn nhiều calo nạp vào hằng ngày, bớt ăn đồ chiên rán nhiều chất béo bão hòa.'
WHERE id = '0a854068-59c3-4dc2-927e-989d13594e8d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0a854068-59c3-4dc2-927e-989d13594e8d', '营养学专家建议广大慢性病患者合理控制每日高热量食物的摄入，少吃富含饱和脂肪的油炸食品。', 'Yíngyǎngxué zhuānjiā jiànyì guǎngdà mànxìngbìng huànzhě hélǐ kòngzhì měirì gāo rèliàng shíwù de shèrù, shǎo chī fùhǎn bǎohé zhīfáng de yóuzhá shípǐn.', 'Các chuyên gia dinh dưỡng khuyên đông đảo người mắc bệnh mạn tính nên kiểm soát hợp lý lượng thức ăn nhiều calo nạp vào hằng ngày, bớt ăn đồ chiên rán nhiều chất béo bão hòa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0a854068-59c3-4dc2-927e-989d13594e8d'
);

-- [指示] (zhǐ shì): chỉ thị, hướng dẫn
UPDATE public.vocabularies
SET example_hanzi = '救援指挥部根据前线无人机航拍传回的实时灾情画面，迅速向下属抢险突击队下达了精准搜救指示。',
    example_pinyin = 'Jiùyuán zhǐhuībù gēnjù qiánxiàn wúrénjī hángpāi chuánhuí de shíshí zāiqíng huàmiàn, xùnsù xiàng xiàshǔ qiǎngxiǎn tūjīduì xiàdá le jīngzhǔn sōujiù zhǐshì.',
    example_vi = 'Sở chỉ huy cứu hộ căn cứ vào hình ảnh thảm họa theo thời gian thực do máy bay không người lái tuyến đầu truyền về đã nhanh chóng ban hành chỉ thị tìm kiếm cứu nạn chuẩn xác xuống các đội xung kích cấp dưới.'
WHERE id = 'e68f2421-8b9c-4e7d-82ee-aa626269c4f9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e68f2421-8b9c-4e7d-82ee-aa626269c4f9', '救援指挥部根据前线无人机航拍传回的实时灾情画面，迅速向下属抢险突击队下达了精准搜救指示。', 'Jiùyuán zhǐhuībù gēnjù qiánxiàn wúrénjī hángpāi chuánhuí de shíshí zāiqíng huàmiàn, xùnsù xiàng xiàshǔ qiǎngxiǎn tūjīduì xiàdá le jīngzhǔn sōujiù zhǐshì.', 'Sở chỉ huy cứu hộ căn cứ vào hình ảnh thảm họa theo thời gian thực do máy bay không người lái tuyến đầu truyền về đã nhanh chóng ban hành chỉ thị tìm kiếm cứu nạn chuẩn xác xuống các đội xung kích cấp dưới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e68f2421-8b9c-4e7d-82ee-aa626269c4f9'
);

-- [职位] (zhí wèi): chức vị, vị trí làm việc
UPDATE public.vocabularies
SET example_hanzi = '经过多轮极其严格的外语沟通能力测试与综合专业背景面试，他成功获得了这家跨国科技企业的高级架构师职位。',
    example_pinyin = 'Jīngguò duō lún jíqí yángé de wàiyǔ gōutōng nénglì cèshì yǔ zōnghé zhuānyè bèijǐng miànshì, tā chénggōng huòdé le zhè jiā kuàguó kējì qǐyè de gāojí jiàgòushī zhíwèi.',
    example_vi = 'Trải qua nhiều vòng kiểm tra năng lực giao tiếp ngoại ngữ và phỏng vấn nền tảng chuyên môn tổng hợp vô cùng nghiêm ngặt, anh đã giành được vị trí kiến trúc sư cao cấp của doanh nghiệp công nghệ đa quốc gia này.'
WHERE id = '0dff6ae5-6a75-4004-bc38-7dd82f41e75d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0dff6ae5-6a75-4004-bc38-7dd82f41e75d', '经过多轮极其严格的外语沟通能力测试与综合专业背景面试，他成功获得了这家跨国科技企业的高级架构师职位。', 'Jīngguò duō lún jíqí yángé de wàiyǔ gōutōng nénglì cèshì yǔ zōnghé zhuānyè bèijǐng miànshì, tā chénggōng huòdé le zhè jiā kuàguó kējì qǐyè de gāojí jiàgòushī zhíwèi.', 'Trải qua nhiều vòng kiểm tra năng lực giao tiếp ngoại ngữ và phỏng vấn nền tảng chuyên môn tổng hợp vô cùng nghiêm ngặt, anh đã giành được vị trí kiến trúc sư cao cấp của doanh nghiệp công nghệ đa quốc gia này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0dff6ae5-6a75-4004-bc38-7dd82f41e75d'
);

-- [职务] (zhí wù): chức vụ
UPDATE public.vocabularies
SET example_hanzi = '身为基层政府的领导干部，必须严以律己、廉洁奉公，决不允许利用手中职权与职务便利谋取任何私利。',
    example_pinyin = 'Shēnwéi jīcéng zhèngfǔ de lǐngdǎo gànbù, bìxū yán yǐ lǜ jǐ, liánjié fèng gōng, jué bù yǔnxǔ lìyòng shǒuzhōng zhíquán yǔ zhíwù biànlì móuqǔ rènhé sīlì.',
    example_vi = 'Là cán bộ lãnh đạo của chính quyền cơ sở, bắt buộc phải nghiêm khắc với bản thân, liêm khiết vì công, tuyệt đối không cho phép lợi dụng quyền hạn và sự thuận tiện của chức vụ để mưu cầu tư lợi.'
WHERE id = '9e62d988-3071-4e52-ba5c-28a9afeb9a33' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9e62d988-3071-4e52-ba5c-28a9afeb9a33', '身为基层政府的领导干部，必须严以律己、廉洁奉公，决不允许利用手中职权与职务便利谋取任何私利。', 'Shēnwéi jīcéng zhèngfǔ de lǐngdǎo gànbù, bìxū yán yǐ lǜ jǐ, liánjié fèng gōng, jué bù yǔnxǔ lìyòng shǒuzhōng zhíquán yǔ zhíwù biànlì móuqǔ rènhé sīlì.', 'Là cán bộ lãnh đạo của chính quyền cơ sở, bắt buộc phải nghiêm khắc với bản thân, liêm khiết vì công, tuyệt đối không cho phép lợi dụng quyền hạn và sự thuận tiện của chức vụ để mưu cầu tư lợi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9e62d988-3071-4e52-ba5c-28a9afeb9a33'
);

-- [指责] (zhǐ zé): chỉ trích, khiển trách
UPDATE public.vocabularies
SET example_hanzi = '在出现项目技术故障时，团队成员之间应当同心协力排查原因，而不是毫无建设性地相互推诿与指责。',
    example_pinyin = 'Zài chūxiàn xiàngmù jìshù gùzhàng shí, tuánduì chéngyuán zhījiān yīngdāng tóngxīn-xiélì páichá yuányīn, ér bú shì háowú jiànshèxìng de xiānghù tuīwěi yǔ zhǐzé.',
    example_vi = 'Khi xuất hiện sự cố kỹ thuật trong dự án, giữa các thành viên trong đội ngũ cần đồng lòng chung sức rà soát nguyên nhân, chứ không phải đùn đẩy và chỉ trích lẫn nhau một cách thiếu tính xây dựng.'
WHERE id = '8beb8e44-22ae-4c25-8275-01d035b0b6cb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8beb8e44-22ae-4c25-8275-01d035b0b6cb', '在出现项目技术故障时，团队成员之间应当同心协力排查原因，而不是毫无建设性地相互推诿与指责。', 'Zài chūxiàn xiàngmù jìshù gùzhàng shí, tuánduì chéngyuán zhījiān yīngdāng tóngxīn-xiélì páichá yuányīn, ér bú shì háowú jiànshèxìng de xiānghù tuīwěi yǔ zhǐzé.', 'Khi xuất hiện sự cố kỹ thuật trong dự án, giữa các thành viên trong đội ngũ cần đồng lòng chung sức rà soát nguyên nhân, chứ không phải đùn đẩy và chỉ trích lẫn nhau một cách thiếu tính xây dựng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8beb8e44-22ae-4c25-8275-01d035b0b6cb'
);

-- [值班] (zhíbān): trực ban, trực ca
UPDATE public.vocabularies
SET example_hanzi = '在举国欢度新春佳节的除夕之夜，综合医院急诊科的大夫和护士们依然精神饱满地坚守在值班岗位上。',
    example_pinyin = 'Zài jǔguó huāndù xīnchūn jiājié de chúxī zhī yè, zōnghé yīyuàn jízhěnkē de dàifu hé hùshi men yīrán jīngshén bǎomǎn de jiānshǒu zài zhíbān gǎngwèi shang.',
    example_vi = 'Trong đêm giao thừa toàn dân vui đón tết xuân, các bác sĩ và y tá khoa cấp cứu bệnh viện đa khoa vẫn tràn đầy tinh thần bám trụ trên cương vị ca trực trực ban.'
WHERE id = '04e7f8b1-7010-4bed-a2a1-be573c2bc08e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '04e7f8b1-7010-4bed-a2a1-be573c2bc08e', '在举国欢度新春佳节的除夕之夜，综合医院急诊科的大夫和护士们依然精神饱满地坚守在值班岗位上。', 'Zài jǔguó huāndù xīnchūn jiājié de chúxī zhī yè, zōnghé yīyuàn jízhěnkē de dàifu hé hùshi men yīrán jīngshén bǎomǎn de jiānshǒu zài zhíbān gǎngwèi shang.', 'Trong đêm giao thừa toàn dân vui đón tết xuân, các bác sĩ và y tá khoa cấp cứu bệnh viện đa khoa vẫn tràn đầy tinh thần bám trụ trên cương vị ca trực trực ban.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '04e7f8b1-7010-4bed-a2a1-be573c2bc08e'
);

-- [支撑] (zhīchēng): chống đỡ, nâng đỡ
UPDATE public.vocabularies
SET example_hanzi = '正是凭借着对科学探索事业的无比热爱与坚定信念，这位残疾科学家克服了常人难以想象的病痛支撑到了今天。',
    example_pinyin = 'Zhèngshì píngjiè zhe duì kēxué tànsuǒ shìyè de wúbǐ rè''ài yǔ jiāndìng xìnniàn, zhè wèi cánjí kēxuéjiā kèfú le chángrén nányǐ xiǎngxiàng de bìngtòng zhīchēng dào le jīntiān.',
    example_vi = 'Chính nhờ vào lòng yêu say đắm vô bờ bến và niềm tin kiên định với sự nghiệp khám phá khoa học, nhà khoa học khuyết tật này đã vượt qua nỗi đau đớn bệnh tật người thường khó tưởng tượng để chống đỡ kiên cường cho tới hôm nay.'
WHERE id = '3ba2f788-1a92-4486-ac42-2ffbcbf21f39' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3ba2f788-1a92-4486-ac42-2ffbcbf21f39', '正是凭借着对科学探索事业的无比热爱与坚定信念，这位残疾科学家克服了常人难以想象的病痛支撑到了今天。', 'Zhèngshì píngjiè zhe duì kēxué tànsuǒ shìyè de wúbǐ rè''ài yǔ jiāndìng xìnniàn, zhè wèi cánjí kēxuéjiā kèfú le chángrén nányǐ xiǎngxiàng de bìngtòng zhīchēng dào le jīntiān.', 'Chính nhờ vào lòng yêu say đắm vô bờ bến và niềm tin kiên định với sự nghiệp khám phá khoa học, nhà khoa học khuyết tật này đã vượt qua nỗi đau đớn bệnh tật người thường khó tưởng tượng để chống đỡ kiên cường cho tới hôm nay.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3ba2f788-1a92-4486-ac42-2ffbcbf21f39'
);

-- [支出] (zhīchū): chi tiêu, chi ra
UPDATE public.vocabularies
SET example_hanzi = '市政府在新一年度的财政预算草案中明确规定，将持续大幅增加对农村义务教育与基层医疗卫生的财政支出。',
    example_pinyin = 'Shìzhèngfǔ zài xīn yí niándù de cáizhèng yùsuàn cǎo''àn zhōng míngquè guīdìng, jiāng chíxù dàfú zēngjiā duì nóngcūn yìwù jiàoyù yǔ jīcéng yīliáo wèishēng de cáizhèng zhīchū.',
    example_vi = 'Chính quyền thành phố trong dự thảo dự toán ngân sách tài chính năm mới đã quy định rõ ràng, sẽ tiếp tục tăng mạnh chi tiêu tài chính cho giáo dục bắt buộc ở nông thôn và y tế vệ sinh cơ sở.'
WHERE id = 'c32a6d13-bc9c-4348-9a7e-528035fb33b3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c32a6d13-bc9c-4348-9a7e-528035fb33b3', '市政府在新一年度的财政预算草案中明确规定，将持续大幅增加对农村义务教育与基层医疗卫生的财政支出。', 'Shìzhèngfǔ zài xīn yí niándù de cáizhèng yùsuàn cǎo''àn zhōng míngquè guīdìng, jiāng chíxù dàfú zēngjiā duì nóngcūn yìwù jiàoyù yǔ jīcéng yīliáo wèishēng de cáizhèng zhīchū.', 'Chính quyền thành phố trong dự thảo dự toán ngân sách tài chính năm mới đã quy định rõ ràng, sẽ tiếp tục tăng mạnh chi tiêu tài chính cho giáo dục bắt buộc ở nông thôn và y tế vệ sinh cơ sở.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c32a6d13-bc9c-4348-9a7e-528035fb33b3'
);

-- [指挥] (zhǐhuī): chỉ huy
UPDATE public.vocabularies
SET example_hanzi = '伴随着著名老指挥家手中那根指挥棒充满激情与韵律的舞动，全场交响乐团奏响了雄浑壮阔的命运交响曲。',
    example_pinyin = 'Bànsuí zhe zhùmíng lǎo zhǐhuījiā shǒuzhōng nà gēn zhǐhuībàng chōngmǎn jīqíng yǔ yùnlǜ de wǔdòng, quánchǎng jiāoxiǎng yuètuán zòuxiǎng le xiónghún-zhuàngkuò de mìngyùn jiāoxiǎngqǔ.',
    example_vi = 'Cùng với sự vung vẩy đầy nhiệt huyết và nhịp điệu của cây gậy chỉ huy trong tay vị nhạc trưởng chỉ huy lão thành danh tiếng, toàn bộ dàn nhạc giao hưởng đã tấu lên bản Giao hưởng Định mệnh hùng tráng nguy nga.'
WHERE id = '36a9a586-44bf-46d0-a0b9-1742f75f6e18' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '36a9a586-44bf-46d0-a0b9-1742f75f6e18', '伴随着著名老指挥家手中那根指挥棒充满激情与韵律的舞动，全场交响乐团奏响了雄浑壮阔的命运交响曲。', 'Bànsuí zhe zhùmíng lǎo zhǐhuījiā shǒuzhōng nà gēn zhǐhuībàng chōngmǎn jīqíng yǔ yùnlǜ de wǔdòng, quánchǎng jiāoxiǎng yuètuán zòuxiǎng le xiónghún-zhuàngkuò de mìngyùn jiāoxiǎngqǔ.', 'Cùng với sự vung vẩy đầy nhiệt huyết và nhịp điệu của cây gậy chỉ huy trong tay vị nhạc trưởng chỉ huy lão thành danh tiếng, toàn bộ dàn nhạc giao hưởng đã tấu lên bản Giao hưởng Định mệnh hùng tráng nguy nga.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '36a9a586-44bf-46d0-a0b9-1742f75f6e18'
);

-- [智力] (zhìlì): trí tuệ, trí lực
UPDATE public.vocabularies
SET example_hanzi = '这套专门面向学龄前儿童设计的趣味益智玩具，能极其有效地促进幼儿空间想象力与早期智力开发。',
    example_pinyin = 'Zhè tào zhuānmén miànxiàng xuélíngqián értóng shèjì de qùwèi yìzhì wánjù, néng jíqí yǒuxiào de cùjìn yòu''ér kōngjiān xiǎngxiànglì yǔ zǎoqī zhìlì kāifā.',
    example_vi = 'Bộ đồ chơi thông minh thú vị được thiết kế chuyên biệt cho trẻ lứa tuổi mầm non này có thể thúc đẩy cực kỳ hiệu quả trí tưởng tượng không gian và sự phát triển trí tuệ sớm của trẻ nhỏ.'
WHERE id = 'bc24dd10-14d4-4b00-8f4b-1f64ce66c7e8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bc24dd10-14d4-4b00-8f4b-1f64ce66c7e8', '这套专门面向学龄前儿童设计的趣味益智玩具，能极其有效地促进幼儿空间想象力与早期智力开发。', 'Zhè tào zhuānmén miànxiàng xuélíngqián értóng shèjì de qùwèi yìzhì wánjù, néng jíqí yǒuxiào de cùjìn yòu''ér kōngjiān xiǎngxiànglì yǔ zǎoqī zhìlì kāifā.', 'Bộ đồ chơi thông minh thú vị được thiết kế chuyên biệt cho trẻ lứa tuổi mầm non này có thể thúc đẩy cực kỳ hiệu quả trí tưởng tượng không gian và sự phát triển trí tuệ sớm của trẻ nhỏ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bc24dd10-14d4-4b00-8f4b-1f64ce66c7e8'
);

-- [治理] (zhìlǐ): quản lý, xử lý, trị vì
UPDATE public.vocabularies
SET example_hanzi = '经过沿河流域各省市长达十年的联合综合生态治理，曾经污染严重的工业母亲河如今重现碧波荡漾、水清岸绿。',
    example_pinyin = 'Jīngguò yánhé liúyù gè shěngshì chángdá shí nián de liánhé zōnghé shēngtài zhìlǐ, céngjīng wūrǎn yánzhòng de gōngyè mǔqīnhé rújīn chóngxiàn bìbō-dàngyàng, shuǐqīng-ànlǜ.',
    example_vi = 'Trải qua mười năm liên kết xử lý sinh thái tổng hợp của các tỉnh thành dọc lưu vực sông, con sông mẹ công nghiệp từng bị ô nhiễm nghiêm trọng ngày nay đã tái hiện làn sóng xanh biếc dập dờn, nước trong đôi bờ xanh ngát.'
WHERE id = 'c7fe3364-ec66-4e61-952c-28d0490d3e52' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c7fe3364-ec66-4e61-952c-28d0490d3e52', '经过沿河流域各省市长达十年的联合综合生态治理，曾经污染严重的工业母亲河如今重现碧波荡漾、水清岸绿。', 'Jīngguò yánhé liúyù gè shěngshì chángdá shí nián de liánhé zōnghé shēngtài zhìlǐ, céngjīng wūrǎn yánzhòng de gōngyè mǔqīnhé rújīn chóngxiàn bìbō-dàngyàng, shuǐqīng-ànlǜ.', 'Trải qua mười năm liên kết xử lý sinh thái tổng hợp của các tỉnh thành dọc lưu vực sông, con sông mẹ công nghiệp từng bị ô nhiễm nghiêm trọng ngày nay đã tái hiện làn sóng xanh biếc dập dờn, nước trong đôi bờ xanh ngát.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c7fe3364-ec66-4e61-952c-28d0490d3e52'
);

-- [秩序] (zhìxù): trật tự
UPDATE public.vocabularies
SET example_hanzi = '尽管火车站候车大厅内聚集了数以万计的返乡春运旅客，但在青年志愿者的耐心引导下，现场始终井然有序、保持着优良秩序。',
    example_pinyin = 'Jǐnguǎn huǒchēzhàn hòuchē dàtīng nèi jùjí le shù yǐ wàn jì de fǎnxiāng chūnyùn lǚkè, dàn zài qīngnián zhìyuànzhě de nàixīn yǐndǎo xià, xiànchǎng shǐzhōng jǐngrán-yǒuxù, bǎochí zhe yōuliáng zhìxù.',
    example_vi = 'Mặc dù bên trong phòng chờ ga tàu hỏa quy tụ hàng vạn hành khách đi đợt cao điểm tết về quê, nhưng dưới sự dẫn dắt kiên nhẫn của các bạn tình nguyện viên trẻ tuổi, hiện trường luôn ngay ngắn và duy trì trật tự tuyệt vời.'
WHERE id = 'ea085838-5daf-461f-a2e6-384ba2a42ccd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ea085838-5daf-461f-a2e6-384ba2a42ccd', '尽管火车站候车大厅内聚集了数以万计的返乡春运旅客，但在青年志愿者的耐心引导下，现场始终井然有序、保持着优良秩序。', 'Jǐnguǎn huǒchēzhàn hòuchē dàtīng nèi jùjí le shù yǐ wàn jì de fǎnxiāng chūnyùn lǚkè, dàn zài qīngnián zhìyuànzhě de nàixīn yǐndǎo xià, xiànchǎng shǐzhōng jǐngrán-yǒuxù, bǎochí zhe yōuliáng zhìxù.', 'Mặc dù bên trong phòng chờ ga tàu hỏa quy tụ hàng vạn hành khách đi đợt cao điểm tết về quê, nhưng dưới sự dẫn dắt kiên nhẫn của các bạn tình nguyện viên trẻ tuổi, hiện trường luôn ngay ngắn và duy trì trật tự tuyệt vời.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ea085838-5daf-461f-a2e6-384ba2a42ccd'
);

-- [至于] (zhìyú): còn về, đến mức
UPDATE public.vocabularies
SET example_hanzi = '公司管理层已就核心业务方向的调整达成了全面共识，至于各个具体执行细则，将在下周部门例会上逐项细化落实。',
    example_pinyin = 'Gōngsī guǎnlǐcéng yǐ jiù héxīn yèwù fāngxiàng de tiáozhěng dáchéng le quánmiàn gòngshí, zhìyú gè gè jùtǐ zhíxíng xìzé, jiāng zài xià zhōu bùmén lìhuì shang zhúxiàng xìhuà luòshí.',
    example_vi = 'Tầng lớp quản lý công ty đã đạt được đồng thuận toàn diện về việc điều chỉnh định hướng nghiệp vụ cốt lõi, còn về từng quy tắc chi tiết thực hiện cụ thể sẽ được chi tiết hóa và triển khai từng mục trong cuộc họp định kỳ của các bộ phận vào tuần tới.'
WHERE id = '75b1c256-895d-44c0-8fbe-5e33a17fb3a0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '75b1c256-895d-44c0-8fbe-5e33a17fb3a0', '公司管理层已就核心业务方向的调整达成了全面共识，至于各个具体执行细则，将在下周部门例会上逐项细化落实。', 'Gōngsī guǎnlǐcéng yǐ jiù héxīn yèwù fāngxiàng de tiáozhěng dáchéng le quánmiàn gòngshí, zhìyú gè gè jùtǐ zhíxíng xìzé, jiāng zài xià zhōu bùmén lìhuì shang zhúxiàng xìhuà luòshí.', 'Tầng lớp quản lý công ty đã đạt được đồng thuận toàn diện về việc điều chỉnh định hướng nghiệp vụ cốt lõi, còn về từng quy tắc chi tiết thực hiện cụ thể sẽ được chi tiết hóa và triển khai từng mục trong cuộc họp định kỳ của các bộ phận vào tuần tới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '75b1c256-895d-44c0-8fbe-5e33a17fb3a0'
);

-- [侄子] (zhízi): cháu trai (con của anh/em trai)
UPDATE public.vocabularies
SET example_hanzi = '得知在远方省城重点大学刻苦攻读博士学位的亲侄子顺利通过了论文答辩，做叔叔的高兴得合不拢嘴。',
    example_pinyin = 'Dézhī zài yuǎnfāng shěngchéng zhòngdiǎn dàxué kèkǔ gōngdú bóshì xuéwèi de qīn zhízi shùnlì tōngguò le lùnwén dábiàn, zuò shūshu de gāoxìng de hébulǒngzuǐ.',
    example_vi = 'Biết tin người cháu trai ruột đang miệt mài học tiến sĩ tại trường đại học trọng điểm ở thành phố tỉnh xa đã bảo vệ luận án thành công, người làm chú vui mừng không khép nổi miệng.'
WHERE id = 'ad2e35ba-aee5-4dcf-a5ab-dfc3ed1d7d3b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ad2e35ba-aee5-4dcf-a5ab-dfc3ed1d7d3b', '得知在远方省城重点大学刻苦攻读博士学位的亲侄子顺利通过了论文答辩，做叔叔的高兴得合不拢嘴。', 'Dézhī zài yuǎnfāng shěngchéng zhòngdiǎn dàxué kèkǔ gōngdú bóshì xuéwèi de qīn zhízi shùnlì tōngguò le lùnwén dábiàn, zuò shūshu de gāoxìng de hébulǒngzuǐ.', 'Biết tin người cháu trai ruột đang miệt mài học tiến sĩ tại trường đại học trọng điểm ở thành phố tỉnh xa đã bảo vệ luận án thành công, người làm chú vui mừng không khép nổi miệng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ad2e35ba-aee5-4dcf-a5ab-dfc3ed1d7d3b'
);

-- [中断] (zhōng duàn): gián đoạn, đứt quãng
UPDATE public.vocabularies
SET example_hanzi = '受台风暴雨引发的突发山体泥石流滑坡险情影响，这条山区干线公路的道路通行被迫暂时中断。',
    example_pinyin = 'Shòu táifēng bàoyǔ yǐnfā de tūfā shāntǐ níshíliú huápō xiǎnqíng yǐngxiǎng, zhè tiáo shānqū gànxiàn gōnglù de dàolù tōngxíng bèi pò zànshí zhōngduàn.',
    example_vi = 'Do ảnh hưởng của vụ trượt lở đất đá bùn núi đột ngột nguy hiểm do bão mưa lớn gây ra, giao thông lưu thông trên tuyến đường bộ trục chính miền núi này buộc phải tạm thời gián đoạn đứt quãng.'
WHERE id = '15c675a5-2357-439e-86ec-b409b59b208d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '15c675a5-2357-439e-86ec-b409b59b208d', '受台风暴雨引发的突发山体泥石流滑坡险情影响，这条山区干线公路的道路通行被迫暂时中断。', 'Shòu táifēng bàoyǔ yǐnfā de tūfā shāntǐ níshíliú huápō xiǎnqíng yǐngxiǎng, zhè tiáo shānqū gànxiàn gōnglù de dàolù tōngxíng bèi pò zànshí zhōngduàn.', 'Do ảnh hưởng của vụ trượt lở đất đá bùn núi đột ngột nguy hiểm do bão mưa lớn gây ra, giao thông lưu thông trên tuyến đường bộ trục chính miền núi này buộc phải tạm thời gián đoạn đứt quãng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '15c675a5-2357-439e-86ec-b409b59b208d'
);

-- [中央] (zhōng yāng): trung ương, trung tâm
UPDATE public.vocabularies
SET example_hanzi = '在这座雄伟现代的音乐厅舞台中央，那架价值不菲的九尺顶级斯坦威三角钢琴在聚光灯照射下熠熠生辉。',
    example_pinyin = 'Zài zhè zuò xióngwěi xiàndài de yīnyuètīng wǔtái zhōngyāng, nà jià jiàzhí-bùfěi de jiǔ chǐ dǐngjí sītǎnwēi sānjiǎo gāngqín zài jùguāngdēng zhàoshè xià yìyì-shēnghuī.',
    example_vi = 'Tại chính giữa trung tâm sân khấu của phòng hòa nhạc hiện đại hùng vĩ này, cây đàn đại dương cầm Steinway chín thước hàng đầu giá trị đắt đỏ tỏa sáng rạng ngời dưới ánh đèn chiếu điểm.'
WHERE id = 'f1a2e8e8-9676-41d3-954a-5f69a1555b47' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f1a2e8e8-9676-41d3-954a-5f69a1555b47', '在这座雄伟现代的音乐厅舞台中央，那架价值不菲的九尺顶级斯坦威三角钢琴在聚光灯照射下熠熠生辉。', 'Zài zhè zuò xióngwěi xiàndài de yīnyuètīng wǔtái zhōngyāng, nà jià jiàzhí-bùfěi de jiǔ chǐ dǐngjí sītǎnwēi sānjiǎo gāngqín zài jùguāngdēng zhàoshè xià yìyì-shēnghuī.', 'Tại chính giữa trung tâm sân khấu của phòng hòa nhạc hiện đại hùng vĩ này, cây đàn đại dương cầm Steinway chín thước hàng đầu giá trị đắt đỏ tỏa sáng rạng ngời dưới ánh đèn chiếu điểm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f1a2e8e8-9676-41d3-954a-5f69a1555b47'
);

-- [终点] (zhōngdiǎn): điểm đích, vạch đích
UPDATE public.vocabularies
SET example_hanzi = '当精疲力竭却意志顽强的马拉松冠军选手率先冲过终点线的那一刹那，全场数万名观众爆发出了雷鸣般的欢呼喝彩。',
    example_pinyin = 'Dāng jīngpí-lìjié què yìzhì wánqiáng de mǎlāsōng guànjūn xuǎnshǒu shuàixiān chōngguò zhōngdiǎn xiàn de nà yí chànà, quánchǎng shù wàn míng guānzhòng bàofā chū le léimíng-bānde huānhū hècǎi.',
    example_vi = 'Vào đúng khoảnh khắc tuyển thủ quán quân marathon kiệt sức nhưng ý chí ngoan cường dẫn đầu lao qua vạch đích, hàng vạn khán giả toàn trường đã bùng nổ những tràng reo hò cổ vũ như sấm dậy.'
WHERE id = '48258f7b-615c-4539-b4c2-67d07712cb41' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '48258f7b-615c-4539-b4c2-67d07712cb41', '当精疲力竭却意志顽强的马拉松冠军选手率先冲过终点线的那一刹那，全场数万名观众爆发出了雷鸣般的欢呼喝彩。', 'Dāng jīngpí-lìjié què yìzhì wánqiáng de mǎlāsōng guànjūn xuǎnshǒu shuàixiān chōngguò zhōngdiǎn xiàn de nà yí chànà, quánchǎng shù wàn míng guānzhòng bàofā chū le léimíng-bānde huānhū hècǎi.', 'Vào đúng khoảnh khắc tuyển thủ quán quân marathon kiệt sức nhưng ý chí ngoan cường dẫn đầu lao qua vạch đích, hàng vạn khán giả toàn trường đã bùng nổ những tràng reo hò cổ vũ như sấm dậy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '48258f7b-615c-4539-b4c2-67d07712cb41'
);

-- [终身] (zhōngshēn): cả đời, suốt đời
UPDATE public.vocabularies
SET example_hanzi = '这位为国家最高国防科技工程隐姓埋名奉献了毕生精力的老院士，被正式授予了国家最高荣誉终身成就奖。',
    example_pinyin = 'Zhè wèi wèi guójiā zuìgāo guófáng kējì gōngchéng yǐnxìng-máimíng fèngxiàn le bìshēng jīnglì de lǎo yuànshì, bèi zhèngshì shòuyǔ le guójiā zuìgāo róngyù zhōngshēn chéngjiù jiǎng.',
    example_vi = 'Vị viện sĩ lão thành đã ẩn danh cống hiến trọn vẹn sức lực cả đời cho công trình khoa học công nghệ quốc phòng tối cao của đất nước này đã được chính thức trao tặng Giải thưởng Thành tựu Trọn đời vinh dự tối cao của quốc gia.'
WHERE id = '29b06ad9-7bcf-40c8-8c3e-128f0666d938' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '29b06ad9-7bcf-40c8-8c3e-128f0666d938', '这位为国家最高国防科技工程隐姓埋名奉献了毕生精力的老院士，被正式授予了国家最高荣誉终身成就奖。', 'Zhè wèi wèi guójiā zuìgāo guófáng kējì gōngchéng yǐnxìng-máimíng fèngxiàn le bìshēng jīnglì de lǎo yuànshì, bèi zhèngshì shòuyǔ le guójiā zuìgāo róngyù zhōngshēn chéngjiù jiǎng.', 'Vị viện sĩ lão thành đã ẩn danh cống hiến trọn vẹn sức lực cả đời cho công trình khoa học công nghệ quốc phòng tối cao của đất nước này đã được chính thức trao tặng Giải thưởng Thành tựu Trọn đời vinh dự tối cao của quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '29b06ad9-7bcf-40c8-8c3e-128f0666d938'
);

-- [众所周知] (zhòngsuǒzhōuzhī): mọi người đều biết, ai cũng biết
UPDATE public.vocabularies
SET example_hanzi = '众所周知，充足的高质量深度睡眠与均衡合理的日常膳食营养，是维持人体免疫系统强健不可或缺的双重支柱。',
    example_pinyin = 'Zhòngsuǒzhōuzhī, chōngzú de gāo zhìliàng shēndù shuìmián yǔ jūnhéng hélǐ de rìcháng shànshí yíngyǎng, shì wéichí réntǐ miǎnyì xìtǒng qiángjiàn bùkě huòquē de shuāngchóng zhīzhù.',
    example_vi = 'Ai cũng biết rằng, giấc ngủ sâu chất lượng cao đầy đủ và dinh dưỡng bữa ăn hằng ngày cân bằng hợp lý là hai trụ cột không thể thiếu để duy trì hệ miễn dịch cơ thể khỏe mạnh.'
WHERE id = '10b35b40-8d7e-4bd5-aa1c-73691e6e8c36' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '10b35b40-8d7e-4bd5-aa1c-73691e6e8c36', '众所周知，充足的高质量深度睡眠与均衡合理的日常膳食营养，是维持人体免疫系统强健不可或缺的双重支柱。', 'Zhòngsuǒzhōuzhī, chōngzú de gāo zhìliàng shēndù shuìmián yǔ jūnhéng hélǐ de rìcháng shànshí yíngyǎng, shì wéichí réntǐ miǎnyì xìtǒng qiángjiàn bùkě huòquē de shuāngchóng zhīzhù.', 'Ai cũng biết rằng, giấc ngủ sâu chất lượng cao đầy đủ và dinh dưỡng bữa ăn hằng ngày cân bằng hợp lý là hai trụ cột không thể thiếu để duy trì hệ miễn dịch cơ thể khỏe mạnh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '10b35b40-8d7e-4bd5-aa1c-73691e6e8c36'
);

-- [重心] (zhòngxīn): trọng tâm
UPDATE public.vocabularies
SET example_hanzi = '随着新一轮企业全球化战略的正式确立，集团总部决定将未来五年的业务发展重心全面转向绿色新能源与储能赛道。',
    example_pinyin = 'Suízhe xīn yì lún qǐyè quánqiúhuà zhànlüè de zhèngshì quèlì, jítuán zǒngbù juédìng jiāng wèilái wǔ nián de yèwù fāzhǎn zhòngxīn quánmiàn zhuǎnxiàng lǜsè xīn néngyuán yǔ chǔnéng sàidào.',
    example_vi = 'Cùng với sự xác lập chính thức chiến lược toàn cầu hóa doanh nghiệp đợt mới, trụ sở tập đoàn quyết định sẽ chuyển dịch toàn diện trọng tâm phát triển nghiệp vụ 5 năm tới sang đường đua năng lượng mới xanh và tích trữ năng lượng.'
WHERE id = '69481eae-0ea2-4fb7-9239-a8a4cf941e3a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '69481eae-0ea2-4fb7-9239-a8a4cf941e3a', '随着新一轮企业全球化战略的正式确立，集团总部决定将未来五年的业务发展重心全面转向绿色新能源与储能赛道。', 'Suízhe xīn yì lún qǐyè quánqiúhuà zhànlüè de zhèngshì quèlì, jítuán zǒngbù juédìng jiāng wèilái wǔ nián de yèwù fāzhǎn zhòngxīn quánmiàn zhuǎnxiàng lǜsè xīn néngyuán yǔ chǔnéng sàidào.', 'Cùng với sự xác lập chính thức chiến lược toàn cầu hóa doanh nghiệp đợt mới, trụ sở tập đoàn quyết định sẽ chuyển dịch toàn diện trọng tâm phát triển nghiệp vụ 5 năm tới sang đường đua năng lượng mới xanh và tích trữ năng lượng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '69481eae-0ea2-4fb7-9239-a8a4cf941e3a'
);

-- [中旬] (zhōngxún): trung tuần (từ ngày 11-20)
UPDATE public.vocabularies
SET example_hanzi = '根据国际学术交流协会的正式官方通知，本届世界语言学高端研讨会定于今年十一月中旬在首都国家会议中心如期举行。',
    example_pinyin = 'Gēnjù guójì xuéshù jiāoliú xiéhuì de zhèngshì guānfāng tōngzhī, běnjiè shìjiè yǔyánxué gāoduān yántǎohuì dìng yú jīnnián shíyī yuè zhōngxún zài shǒudū guójiā huìyì zhōngxīn rúqī jǔxíng.',
    example_vi = 'Theo thông báo chính thức của Hiệp hội Giao lưu Học thuật Quốc tế, Hội thảo cao cấp Ngôn ngữ học Thế giới lần này được ấn định sẽ diễn ra đúng hạn vào trung tuần tháng 11 năm nay tại Trung tâm Hội nghị Quốc gia thủ đô.'
WHERE id = 'c2c53ac7-3c02-46f4-b9c1-3a33f776418e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c2c53ac7-3c02-46f4-b9c1-3a33f776418e', '根据国际学术交流协会的正式官方通知，本届世界语言学高端研讨会定于今年十一月中旬在首都国家会议中心如期举行。', 'Gēnjù guójì xuéshù jiāoliú xiéhuì de zhèngshì guānfāng tōngzhī, běnjiè shìjiè yǔyánxué gāoduān yántǎohuì dìng yú jīnnián shíyī yuè zhōngxún zài shǒudū guójiā huìyì zhōngxīn rúqī jǔxíng.', 'Theo thông báo chính thức của Hiệp hội Giao lưu Học thuật Quốc tế, Hội thảo cao cấp Ngôn ngữ học Thế giới lần này được ấn định sẽ diễn ra đúng hạn vào trung tuần tháng 11 năm nay tại Trung tâm Hội nghị Quốc gia thủ đô.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c2c53ac7-3c02-46f4-b9c1-3a33f776418e'
);

-- [粥] (zhōu): cháo
UPDATE public.vocabularies
SET example_hanzi = '在寒冬腊月的清晨，喝上一碗用红枣、桂圆、莲子与糯米小火慢炖得软糯香甜的八宝热粥，浑身都充满了暖意。',
    example_pinyin = 'Zài hándōng-làyuè de qīngchén, hē shàng yì wǎn yòng hóngzǎo, guìyuán, liánzǐ yǔ nuòmǐ xiǎohuǒ màn dùn de ruǎnnuò xiāngtián de bābǎo rèzhōu, húnshēn dōu chōngmǎn le nuǎnyì.',
    example_vi = 'Vào sáng sớm tháng Chạp mùa đông lạnh giá, húp một bát cháo bát bảo nóng hổi ngọt thơm dẻo quánh ninh nhỏ lửa từ táo đỏ, nhãn nhục, hạt sen và gạo nếp thì cả người đều ngập tràn hơi ấm.'
WHERE id = '5f3631b6-1143-44be-899d-e33060756c07' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5f3631b6-1143-44be-899d-e33060756c07', '在寒冬腊月的清晨，喝上一碗用红枣、桂圆、莲子与糯米小火慢炖得软糯香甜的八宝热粥，浑身都充满了暖意。', 'Zài hándōng-làyuè de qīngchén, hē shàng yì wǎn yòng hóngzǎo, guìyuán, liánzǐ yǔ nuòmǐ xiǎohuǒ màn dùn de ruǎnnuò xiāngtián de bābǎo rèzhōu, húnshēn dōu chōngmǎn le nuǎnyì.', 'Vào sáng sớm tháng Chạp mùa đông lạnh giá, húp một bát cháo bát bảo nóng hổi ngọt thơm dẻo quánh ninh nhỏ lửa từ táo đỏ, nhãn nhục, hạt sen và gạo nếp thì cả người đều ngập tràn hơi ấm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5f3631b6-1143-44be-899d-e33060756c07'
);

-- [州] (zhōu): châu, bang
UPDATE public.vocabularies
SET example_hanzi = '为了进一步保护这片珍稀水禽栖息地，当地自治州政府依法将整片高山湖泊湿地设立为了国家级自然生态保护区。',
    example_pinyin = 'Wèile jìnyíbù bǎohù zhè piàn zhēnxī shuǐqín qīxīdì, dāngdì zìzhìzhōu zhèngfǔ yīfǎ jiāng zhěng piàn gāoshān húpò shīdì shèlì wéi le guójiājí zìrán shēngtài bǎohùqū.',
    example_vi = 'Để bảo vệ hơn nữa nơi cư trú của các loài thủy cầm quý hiếm này, chính quyền châu tự trị địa phương đã thành lập toàn bộ vùng đất ngập nước hồ trên núi cao thành khu bảo tồn sinh thái tự nhiên cấp quốc gia theo pháp luật.'
WHERE id = 'a520abde-c998-4eed-840e-2ff3235b9810' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a520abde-c998-4eed-840e-2ff3235b9810', '为了进一步保护这片珍稀水禽栖息地，当地自治州政府依法将整片高山湖泊湿地设立为了国家级自然生态保护区。', 'Wèile jìnyíbù bǎohù zhè piàn zhēnxī shuǐqín qīxīdì, dāngdì zìzhìzhōu zhèngfǔ yīfǎ jiāng zhěng piàn gāoshān húpò shīdì shèlì wéi le guójiājí zìrán shēngtài bǎohùqū.', 'Để bảo vệ hơn nữa nơi cư trú của các loài thủy cầm quý hiếm này, chính quyền châu tự trị địa phương đã thành lập toàn bộ vùng đất ngập nước hồ trên núi cao thành khu bảo tồn sinh thái tự nhiên cấp quốc gia theo pháp luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a520abde-c998-4eed-840e-2ff3235b9810'
);

-- [周边] (zhōubiān): xung quanh, vùng ven
UPDATE public.vocabularies
SET example_hanzi = '随着新国际机场综合交通枢纽的全面竣工通车，周边数十平方公里区域内的临空经济产业园区迅速崛起腾飞。',
    example_pinyin = 'Suízhe xīn guójì jīchǎng zōnghé jiāotōng shūniǔ de quánmiàn jùngōng tōngchē, zhōubiān shùshí píngfāng gōnglǐ qūyù nèi de línkōng jīngjì chǎnyè yuánqū xùnsù juéqǐ téngfēi.',
    example_vi = 'Cùng với việc khánh thành thông xe toàn diện đầu mối giao thông tổng hợp sân bay quốc tế mới, khu công nghiệp kinh tế phụ cận sân bay trong phạm vi hàng chục kilomet vuông xung quanh đã trỗi dậy cất cánh nhanh chóng.'
WHERE id = '589c1c25-047b-4e64-bda3-553121dd5618' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '589c1c25-047b-4e64-bda3-553121dd5618', '随着新国际机场综合交通枢纽的全面竣工通车，周边数十平方公里区域内的临空经济产业园区迅速崛起腾飞。', 'Suízhe xīn guójì jīchǎng zōnghé jiāotōng shūniǔ de quánmiàn jùngōng tōngchē, zhōubiān shùshí píngfāng gōnglǐ qūyù nèi de línkōng jīngjì chǎnyè yuánqū xùnsù juéqǐ téngfēi.', 'Cùng với việc khánh thành thông xe toàn diện đầu mối giao thông tổng hợp sân bay quốc tế mới, khu công nghiệp kinh tế phụ cận sân bay trong phạm vi hàng chục kilomet vuông xung quanh đã trỗi dậy cất cánh nhanh chóng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '589c1c25-047b-4e64-bda3-553121dd5618'
);

-- [周到] (zhōudào): chu đáo
UPDATE public.vocabularies
SET example_hanzi = '这家五星级精品酒店不仅客房设施豪华舒适，其二十四小时全天候贴心细致的服务更是让每一位宾客感到无微不至的周到。',
    example_pinyin = 'Zhè jiā wǔxīngjí jīngpǐn jiǔdiàn bùjǐn kèfáng shèshī huáohá shūshì, qí èrshísì xiǎoshí quántiānhòu tiēxīn xìzhì de fúwù gèng shì ràng měi yí wèi bīnkè gǎndào wúwēi-búzhì de zhōudào.',
    example_vi = 'Khách sạn chất lượng cao năm sao này không chỉ tiện nghi phòng ốc sang trọng thoải mái, mà dịch vụ chăm sóc tận tình tỉ mỉ 24/24 suốt ngày đêm lại càng khiến mỗi vị khách cảm nhận được sự chu đáo tỉ mỉ đến từng chi tiết.'
WHERE id = 'b016b3e7-f483-4606-a3cf-f01c351e59a0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b016b3e7-f483-4606-a3cf-f01c351e59a0', '这家五星级精品酒店不仅客房设施豪华舒适，其二十四小时全天候贴心细致的服务更是让每一位宾客感到无微不至的周到。', 'Zhè jiā wǔxīngjí jīngpǐn jiǔdiàn bùjǐn kèfáng shèshī huáohá shūshì, qí èrshísì xiǎoshí quántiānhòu tiēxīn xìzhì de fúwù gèng shì ràng měi yí wèi bīnkè gǎndào wúwēi-búzhì de zhōudào.', 'Khách sạn chất lượng cao năm sao này không chỉ tiện nghi phòng ốc sang trọng thoải mái, mà dịch vụ chăm sóc tận tình tỉ mỉ 24/24 suốt ngày đêm lại càng khiến mỗi vị khách cảm nhận được sự chu đáo tỉ mỉ đến từng chi tiết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b016b3e7-f483-4606-a3cf-f01c351e59a0'
);

-- [周期] (zhōuqī): chu kỳ
UPDATE public.vocabularies
SET example_hanzi = '一位经验老到成熟的基金经理，善于在复杂的宏观经济波动周期中敏锐捕捉具有长期增长潜力的行业逆周期机会。',
    example_pinyin = 'Yí wèi jīngyàn-lǎodào chéngshú de jījīn jīnglǐ, shànyú zài fùzá de hóngguān jīngjì bōdòng zhōuqī zhōng mǐnruì bǔzhuō jùyǒu chángqī zēngzhǎng qiánlì de hángyè nì zhōuqī jīhuì.',
    example_vi = 'Một nhà quản lý quỹ già dặn kinh nghiệm và chín chắn luôn giỏi việc nắm bắt nhạy bén cơ hội ngược chu kỳ của ngành có tiềm năng tăng trưởng lâu dài giữa chu kỳ biến động kinh tế vĩ mô phức tạp.'
WHERE id = 'd8d463c3-b660-41c0-8548-0fc3f5a62838' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd8d463c3-b660-41c0-8548-0fc3f5a62838', '一位经验老到成熟的基金经理，善于在复杂的宏观经济波动周期中敏锐捕捉具有长期增长潜力的行业逆周期机会。', 'Yí wèi jīngyàn-lǎodào chéngshú de jījīn jīnglǐ, shànyú zài fùzá de hóngguān jīngjì bōdòng zhōuqī zhōng mǐnruì bǔzhuō jùyǒu chángqī zēngzhǎng qiánlì de hángyè nì zhōuqī jīhuì.', 'Một nhà quản lý quỹ già dặn kinh nghiệm và chín chắn luôn giỏi việc nắm bắt nhạy bén cơ hội ngược chu kỳ của ngành có tiềm năng tăng trưởng lâu dài giữa chu kỳ biến động kinh tế vĩ mô phức tạp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd8d463c3-b660-41c0-8548-0fc3f5a62838'
);

-- [株] (zhū): cây, gốc (lượng từ)
UPDATE public.vocabularies
SET example_hanzi = '植物学科考团队在人迹罕至的秦岭原始深山峡谷中，惊喜地发现了一株树龄超过千年的珍稀野生红豆杉古树。',
    example_pinyin = 'Zhíwùxué kēkǎo tuánduì zài rénjì-hǎnjià de Qínlǐng yuánshǐ shēnshān xiágǔ zhōng, jīngxǐ de fāxiàn le yì zhū shùlíng chàoguò qiānnián de zhēnxī yěshēng hóngdòushān gǔshù.',
    example_vi = 'Đoàn khảo sát thực vật học tại hẻm núi sâu nguyên sinh ít dấu chân người của dãy Tần Lĩnh đã bất ngờ phát hiện một cây cổ thụ thông đỏ hoang dã quý hiếm có tuổi thọ trên ngàn năm.'
WHERE id = '66739e63-a0e4-4b3d-934f-60522f0256a4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '66739e63-a0e4-4b3d-934f-60522f0256a4', '植物学科考团队在人迹罕至的秦岭原始深山峡谷中，惊喜地发现了一株树龄超过千年的珍稀野生红豆杉古树。', 'Zhíwùxué kēkǎo tuánduì zài rénjì-hǎnjià de Qínlǐng yuánshǐ shēnshān xiágǔ zhōng, jīngxǐ de fāxiàn le yì zhū shùlíng chàoguò qiānnián de zhēnxī yěshēng hóngdòushān gǔshù.', 'Đoàn khảo sát thực vật học tại hẻm núi sâu nguyên sinh ít dấu chân người của dãy Tần Lĩnh đã bất ngờ phát hiện một cây cổ thụ thông đỏ hoang dã quý hiếm có tuổi thọ trên ngàn năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '66739e63-a0e4-4b3d-934f-60522f0256a4'
);

-- [主办] (zhǔ bàn): chủ trì, tổ chức
UPDATE public.vocabularies
SET example_hanzi = '由科技部和中国科学院联合主办的全国青少年科技创新大赛，吸引了全国数万名具有发明创造潜力的优秀中小学生。',
    example_pinyin = 'Yóu kējìbù hé Zhōngguó Kēxuéyuàn liánhé zhǔbàn de quánguó qīng-shàonián kējì chuàngxīn dàsài, xīyǐn le quánguó shù wàn míng jùyǒu fāmíng chuàngzào qiánlì de yōuxiù zhōng-xiǎoxuéshēng.',
    example_vi = 'Cuộc thi Sáng tạo Khoa học Kỹ thuật Thanh thiếu niên toàn quốc do Bộ Khoa học Công nghệ và Viện Hàn lâm Khoa học Trung Quốc phối hợp tổ chức chủ trì đã thu hút hàng vạn học sinh phổ thông ưu tú có tiềm năng phát minh sáng tạo trên khắp cả nước.'
WHERE id = 'e3467cdb-5ca8-482a-af69-41c9cdf66e9b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e3467cdb-5ca8-482a-af69-41c9cdf66e9b', '由科技部和中国科学院联合主办的全国青少年科技创新大赛，吸引了全国数万名具有发明创造潜力的优秀中小学生。', 'Yóu kējìbù hé Zhōngguó Kēxuéyuàn liánhé zhǔbàn de quánguó qīng-shàonián kējì chuàngxīn dàsài, xīyǐn le quánguó shù wàn míng jùyǒu fāmíng chuàngzào qiánlì de yōuxiù zhōng-xiǎoxuéshēng.', 'Cuộc thi Sáng tạo Khoa học Kỹ thuật Thanh thiếu niên toàn quốc do Bộ Khoa học Công nghệ và Viện Hàn lâm Khoa học Trung Quốc phối hợp tổ chức chủ trì đã thu hút hàng vạn học sinh phổ thông ưu tú có tiềm năng phát minh sáng tạo trên khắp cả nước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e3467cdb-5ca8-482a-af69-41c9cdf66e9b'
);

-- [主导] (zhǔ dǎo): chủ đạo, vai trò quyết định
UPDATE public.vocabularies
SET example_hanzi = '在这场深刻影响全球产业格局的数字技术变革浪潮中，谁能掌握核心前沿专利，谁就能在国际标准制定中发挥主导作用。',
    example_pinyin = 'Zài zhè chǎng shēnkè yǐngxiǎng quánqiú chǎnyè géjú de shùzì jìshù biàngé làngcháo zhōng, shéi néng zhǎngwò héxīn qiányán zhuānlì, shéi jiù néng zài guójì biāozhǔn zhìdìng zhōng fāhuī zhǔdǎo zuòyòng.',
    example_vi = 'Trong làn sóng biến cách công nghệ số ảnh hưởng sâu sắc đến cục diện ngành nghề toàn cầu này, ai có thể nắm giữ bằng sáng chế đi đầu cốt lõi thì người đó sẽ phát huy vai trò chủ đạo trong việc xây dựng các tiêu chuẩn quốc tế.'
WHERE id = 'e0dd4add-398f-48ef-aced-77fc9ab94638' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e0dd4add-398f-48ef-aced-77fc9ab94638', '在这场深刻影响全球产业格局的数字技术变革浪潮中，谁能掌握核心前沿专利，谁就能在国际标准制定中发挥主导作用。', 'Zài zhè chǎng shēnkè yǐngxiǎng quánqiú chǎnyè géjú de shùzì jìshù biàngé làngcháo zhōng, shéi néng zhǎngwò héxīn qiányán zhuānlì, shéi jiù néng zài guójì biāozhǔn zhìdìng zhōng fāhuī zhǔdǎo zuòyòng.', 'Trong làn sóng biến cách công nghệ số ảnh hưởng sâu sắc đến cục diện ngành nghề toàn cầu này, ai có thể nắm giữ bằng sáng chế đi đầu cốt lõi thì người đó sẽ phát huy vai trò chủ đạo trong việc xây dựng các tiêu chuẩn quốc tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e0dd4add-398f-48ef-aced-77fc9ab94638'
);

-- [主管] (zhǔ guǎn): quản lý, phụ trách, chủ quản
UPDATE public.vocabularies
SET example_hanzi = '各级行政执法机关在推行重大公共监管决策前，必须报请上级业务主管行政部门进行严格合规审查与备案批准。',
    example_pinyin = 'Gè jí xíngzhèng zhífǎ jīgòu zài tuīxíng zhòngdà gōnggòng jiānguǎn juécè qián, bìxū bào qǐng shàngjí yèwù zhǔguǎn xíngzhèng bùmén jìnxíng yángé hégīu shěnchá yǔ bèi''àn pīzhǔn.',
    example_vi = 'Cơ quan thực thi pháp luật hành chính các cấp trước khi triển khai các quyết sách giám sát quản lý công cộng trọng đại bắt buộc phải báo cáo xin cơ quan hành chính chủ quản nghiệp vụ cấp trên tiến hành rà soát hợp quy nghiêm ngặt và phê chuẩn lưu hồ sơ.'
WHERE id = '6c9a1768-ddd3-4b17-8cfd-ef3ed6113634' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6c9a1768-ddd3-4b17-8cfd-ef3ed6113634', '各级行政执法机关在推行重大公共监管决策前，必须报请上级业务主管行政部门进行严格合规审查与备案批准。', 'Gè jí xíngzhèng zhífǎ jīgòu zài tuīxíng zhòngdà gōnggòng jiānguǎn juécè qián, bìxū bào qǐng shàngjí yèwù zhǔguǎn xíngzhèng bùmén jìnxíng yángé hégīu shěnchá yǔ bèi''àn pīzhǔn.', 'Cơ quan thực thi pháp luật hành chính các cấp trước khi triển khai các quyết sách giám sát quản lý công cộng trọng đại bắt buộc phải báo cáo xin cơ quan hành chính chủ quản nghiệp vụ cấp trên tiến hành rà soát hợp quy nghiêm ngặt và phê chuẩn lưu hồ sơ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6c9a1768-ddd3-4b17-8cfd-ef3ed6113634'
);

-- [主流] (zhǔ liú): dòng chính, xu thế chủ đạo
UPDATE public.vocabularies
SET example_hanzi = '随着全社会对绿色低碳环保理念的普遍认同，节能低耗的新能源电动汽车已逐步成为城市日常出行的绝对主流趋势。',
    example_pinyin = 'Suízhe quán shèhuì duì lǜsè dītàn huánbǎo lǐniàn de pǔbiàn rèntóng, jiénéng dīhào de xīn néngyuán diàndòng qìchē yǐ zhúbù chéngwéi chéngshì rìcháng chūxíng de juéduì zhǔliú qūshì.',
    example_vi = 'Cùng với sự đồng thuận phổ biến của toàn xã hội đối với triết lý bảo vệ môi trường xanh carbon thấp, xe ô tô điện năng lượng mới tiết kiệm năng lượng tiêu hao thấp đã từng bước trở thành xu thế dòng chính tuyệt đối của việc đi lại hằng ngày nơi đô thị.'
WHERE id = '63cb8815-d99c-4739-bec7-a7dfdeab3874' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '63cb8815-d99c-4739-bec7-a7dfdeab3874', '随着全社会对绿色低碳环保理念的普遍认同，节能低耗的新能源电动汽车已逐步成为城市日常出行的绝对主流趋势。', 'Suízhe quán shèhuì duì lǜsè dītàn huánbǎo lǐniàn de pǔbiàn rèntóng, jiénéng dīhào de xīn néngyuán diàndòng qìchē yǐ zhúbù chéngwéi chéngshì rìcháng chūxíng de juéduì zhǔliú qūshì.', 'Cùng với sự đồng thuận phổ biến của toàn xã hội đối với triết lý bảo vệ môi trường xanh carbon thấp, xe ô tô điện năng lượng mới tiết kiệm năng lượng tiêu hao thấp đã từng bước trở thành xu thế dòng chính tuyệt đối của việc đi lại hằng ngày nơi đô thị.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '63cb8815-d99c-4739-bec7-a7dfdeab3874'
);

-- [砖] (zhuān): viên gạch
UPDATE public.vocabularies
SET example_hanzi = '修缮长城国家文化公园的文保工匠们严格遵循修旧如旧的古法工艺，采用原产地烧制的青灰巨砖进行精细加固补强。',
    example_pinyin = 'Xiūshàn chángchéng guójiā wénhuà gōngyuán de wénbǎo gōngjiàng men yángé zūnxún xiūjiù-rújìu de gǔfǎ gōngyì, cǎiyòng yuánchǎndì shāozhì de qīnghuī jùzhuān jìnxíng jīngxì jiāgù bǔqiáng.',
    example_vi = 'Các nghệ nhân bảo tồn di sản trùng tu Công viên Văn hóa Quốc gia Trường Thành tuân thủ nghiêm ngặt kỹ nghệ cổ pháp ''sửa cũ như cũ'', dùng những viên gạch khổng lồ màu xám xanh nung tại nơi xuất xứ gốc để gia cố bồi đắp tinh vi.'
WHERE id = 'e9a693d6-0fd4-49a2-93d9-901601eb9342' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e9a693d6-0fd4-49a2-93d9-901601eb9342', '修缮长城国家文化公园的文保工匠们严格遵循修旧如旧的古法工艺，采用原产地烧制的青灰巨砖进行精细加固补强。', 'Xiūshàn chángchéng guójiā wénhuà gōngyuán de wénbǎo gōngjiàng men yángé zūnxún xiūjiù-rújìu de gǔfǎ gōngyì, cǎiyòng yuánchǎndì shāozhì de qīnghuī jùzhuān jìnxíng jīngxì jiāgù bǔqiáng.', 'Các nghệ nhân bảo tồn di sản trùng tu Công viên Văn hóa Quốc gia Trường Thành tuân thủ nghiêm ngặt kỹ nghệ cổ pháp ''sửa cũ như cũ'', dùng những viên gạch khổng lồ màu xám xanh nung tại nơi xuất xứ gốc để gia cố bồi đắp tinh vi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e9a693d6-0fd4-49a2-93d9-901601eb9342'
);

-- [专利] (zhuān lì): bằng sáng chế, độc quyền
UPDATE public.vocabularies
SET example_hanzi = '该生物医药高新技术企业通过坚持不懈的自主原始创新，在抗癌靶向药物合成领域成功斩获了数十项国际核心发明专利。',
    example_pinyin = 'Gāi shēngwù yīyào gāoxīn jìshù qǐyè tōngguò jiānchí-búxiè de zìzhǔ yuánshǐ chuàngxīn, zài kàng''ái bǎxiàng yàowù héchéng lǐngyù chénggōng zhǎnhuò le shùshí xiàng guójì héxīn fāmíng zhuānlì.',
    example_vi = 'Doanh nghiệp công nghệ cao y dược sinh học này thông qua sự đổi mới nguyên bản tự chủ kiên trì không ngơi nghỉ đã xuất sắc giành được hàng chục bằng sáng chế phát minh cốt lõi quốc tế trong lĩnh vực tổng hợp thuốc nhắm trúng đích chống ung thư.'
WHERE id = '286dcb07-7327-4195-a161-1edffaa3f152' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '286dcb07-7327-4195-a161-1edffaa3f152', '该生物医药高新技术企业通过坚持不懈的自主原始创新，在抗癌靶向药物合成领域成功斩获了数十项国际核心发明专利。', 'Gāi shēngwù yīyào gāoxīn jìshù qǐyè tōngguò jiānchí-búxiè de zìzhǔ yuánshǐ chuàngxīn, zài kàng''ái bǎxiàng yàowù héchéng lǐngyù chénggōng zhǎnhuò le shùshí xiàng guójì héxīn fāmíng zhuānlì.', 'Doanh nghiệp công nghệ cao y dược sinh học này thông qua sự đổi mới nguyên bản tự chủ kiên trì không ngơi nghỉ đã xuất sắc giành được hàng chục bằng sáng chế phát minh cốt lõi quốc tế trong lĩnh vực tổng hợp thuốc nhắm trúng đích chống ung thư.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '286dcb07-7327-4195-a161-1edffaa3f152'
);

-- [专题] (zhuān tí): chuyên đề
UPDATE public.vocabularies
SET example_hanzi = '主流中央媒体在全国两会期间开设了聚焦区域协调发展与共同富裕的高规格专题专栏，引发了广大受众的热烈共鸣。',
    example_pinyin = 'Zhǔliú zhōngyāng méitǐ zài quánguó liǎnghuì qījiān kāishè le jùjiāo qūyù xiétiáo fāzhǎn yǔ gòngtóng fùyù de gāoguīgé zhuāntí zhuānlán, yǐnfā le guǎngdà shòuzhòng de rèliè gòngmíng.',
    example_vi = 'Cơ quan truyền thông trung ương dòng chính trong thời gian kỳ họp Lưỡng hội toàn quốc đã mở chuyên mục chuyên đề quy cách cao tập trung vào phát triển hài hòa khu vực và cùng nhau giàu có, làm dấy lên sự đồng cảm nhiệt liệt của đông đảo công chúng khán giả.'
WHERE id = 'a012f5d6-eb50-4b38-9fe6-dcdeeef982be' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a012f5d6-eb50-4b38-9fe6-dcdeeef982be', '主流中央媒体在全国两会期间开设了聚焦区域协调发展与共同富裕的高规格专题专栏，引发了广大受众的热烈共鸣。', 'Zhǔliú zhōngyāng méitǐ zài quánguó liǎnghuì qījiān kāishè le jùjiāo qūyù xiétiáo fāzhǎn yǔ gòngtóng fùyù de gāoguīgé zhuāntí zhuānlán, yǐnfā le guǎngdà shòuzhòng de rèliè gòngmíng.', 'Cơ quan truyền thông trung ương dòng chính trong thời gian kỳ họp Lưỡng hội toàn quốc đã mở chuyên mục chuyên đề quy cách cao tập trung vào phát triển hài hòa khu vực và cùng nhau giàu có, làm dấy lên sự đồng cảm nhiệt liệt của đông đảo công chúng khán giả.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a012f5d6-eb50-4b38-9fe6-dcdeeef982be'
);

-- [庄稼] (zhuāng jia): hoa màu, cây trồng
UPDATE public.vocabularies
SET example_hanzi = '在一场久旱逢甘霖的透雨滋润之后，广袤无垠的万亩良田里泛着油绿生机的各种秋熟庄稼展现出欣欣向荣的丰收气象。',
    example_pinyin = 'Zài yì chǎng jiǔhàn-féng-gānlín de tòuyǔ zīrùn zhīhòu, guǎngmào-wúyín de wàn mǔ liángtián lǐ fàn zhe yóulǜ shēngjī de gè zhǒng qiūshú zhuāngjia zhǎnxiàn chū xīnxīn-xiàngróng de fēngshōu qìxiàng.',
    example_vi = 'Sau một trận mưa rào rỉ rả tưới tắm như hạn hán lâu ngày gặp mưa lành, muôn loài hoa màu vụ thu ngập tràn sức sống xanh mướt trên vạn mẫu ruộng phì nhiêu bao la bát ngát đã thể hiện khí thế vụ mùa bội thu bừng bừng sức sống.'
WHERE id = '921be5b6-0cfc-4fb7-99d3-055a1c075640' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '921be5b6-0cfc-4fb7-99d3-055a1c075640', '在一场久旱逢甘霖的透雨滋润之后，广袤无垠的万亩良田里泛着油绿生机的各种秋熟庄稼展现出欣欣向荣的丰收气象。', 'Zài yì chǎng jiǔhàn-féng-gānlín de tòuyǔ zīrùn zhīhòu, guǎngmào-wúyín de wàn mǔ liángtián lǐ fàn zhe yóulǜ shēngjī de gè zhǒng qiūshú zhuāngjia zhǎnxiàn chū xīnxīn-xiàngróng de fēngshōu qìxiàng.', 'Sau một trận mưa rào rỉ rả tưới tắm như hạn hán lâu ngày gặp mưa lành, muôn loài hoa màu vụ thu ngập tràn sức sống xanh mướt trên vạn mẫu ruộng phì nhiêu bao la bát ngát đã thể hiện khí thế vụ mùa bội thu bừng bừng sức sống.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '921be5b6-0cfc-4fb7-99d3-055a1c075640'
);

-- [装备] (zhuāngbèi): trang bị
UPDATE public.vocabularies
SET example_hanzi = '由我国自主研发制造的高铁盾构机与深水钻井平台等一批世界级重型工业大国重器装备，达到了国际顶尖领先水平。',
    example_pinyin = 'Yóu wǒguó zìzhǔ yánfā zhìzào de gāotiě dùngòujī yǔ shēnshuǐ zuānjǐng píngtái děng yì pī shìjièjí zhòngxíng gōngyè dàguó zhòngqì zhuāngbèi, dádào le guójì dǐngjiān lǐngxiān shuǐpíng.',
    example_vi = 'Một loạt trang bị đại khí quốc gia công nghiệp nặng đẳng cấp thế giới như máy đào hầm khiên chắn đường sắt cao tốc và giàn khoan nước sâu do nước ta tự chủ nghiên cứu phát triển chế tạo đã đạt tới trình độ dẫn đầu đỉnh cao quốc tế.'
WHERE id = '6de2c21b-f08e-4790-8817-36efeae8b910' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6de2c21b-f08e-4790-8817-36efeae8b910', '由我国自主研发制造的高铁盾构机与深水钻井平台等一批世界级重型工业大国重器装备，达到了国际顶尖领先水平。', 'Yóu wǒguó zìzhǔ yánfā zhìzào de gāotiě dùngòujī yǔ shēnshuǐ zuānjǐng píngtái děng yì pī shìjièjí zhòngxíng gōngyè dàguó zhòngqì zhuāngbèi, dádào le guójì dǐngjiān lǐngxiān shuǐpíng.', 'Một loạt trang bị đại khí quốc gia công nghiệp nặng đẳng cấp thế giới như máy đào hầm khiên chắn đường sắt cao tốc và giàn khoan nước sâu do nước ta tự chủ nghiên cứu phát triển chế tạo đã đạt tới trình độ dẫn đầu đỉnh cao quốc tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6de2c21b-f08e-4790-8817-36efeae8b910'
);

-- [转让] (zhuǎnràng): chuyển nhượng
UPDATE public.vocabularies
SET example_hanzi = '该高科技科研团队依法将其历时五年研发成功的两项重大工业环保发明专利成果，以公开拍卖的形式正式转让给了产业化龙头企业。',
    example_pinyin = 'Gāi gāokējì kēyán tuánduì yīfǎ jiāng qí lìshí wǔ nián yánfā chénggōng de liǎng xiàng zhòngdà gōngyè huánbǎo fāmíng zhuānlì chéngguǒ, yǐ gōngkāi pāimài de xíngshì zhèngshì zhuǎnràng gěi le chǎnyèhuà lóngtóu qǐyè.',
    example_vi = 'Đội ngũ nghiên cứu công nghệ cao theo đúng pháp luật đã chính thức chuyển nhượng hai thành quả bằng sáng chế phát minh bảo vệ môi trường công nghiệp trọng đại do mình nghiên cứu thành công suốt 5 năm cho doanh nghiệp đầu ngành công nghiệp hóa dưới hình thức đấu giá công khai.'
WHERE id = '0f3a9efd-408f-4b53-a8e5-d6a4632ae75b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0f3a9efd-408f-4b53-a8e5-d6a4632ae75b', '该高科技科研团队依法将其历时五年研发成功的两项重大工业环保发明专利成果，以公开拍卖的形式正式转让给了产业化龙头企业。', 'Gāi gāokējì kēyán tuánduì yīfǎ jiāng qí lìshí wǔ nián yánfā chénggōng de liǎng xiàng zhòngdà gōngyè huánbǎo fāmíng zhuānlì chéngguǒ, yǐ gōngkāi pāimài de xíngshì zhèngshì zhuǎnràng gěi le chǎnyèhuà lóngtóu qǐyè.', 'Đội ngũ nghiên cứu công nghệ cao theo đúng pháp luật đã chính thức chuyển nhượng hai thành quả bằng sáng chế phát minh bảo vệ môi trường công nghiệp trọng đại do mình nghiên cứu thành công suốt 5 năm cho doanh nghiệp đầu ngành công nghiệp hóa dưới hình thức đấu giá công khai.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0f3a9efd-408f-4b53-a8e5-d6a4632ae75b'
);

-- [转移] (zhuǎnyí): chuyển dịch, di dời
UPDATE public.vocabularies
SET example_hanzi = '在突发超强台风登陆来临前数小时，当地防汛抢险应急指挥部紧急调集数百辆大巴车，迅速将低洼险区的上万名群众安全转移到了避险安置点。',
    example_pinyin = 'Zài tūfā chāoqiáng táifēng dēnglù láilín qián shù xiǎoshí, dāngdì fángxùn qiǎngxiǎn yīngjí zhǐhuībù jǐnjí diàojí shù bǎi liàng dàbāchē, xùnsù jiāng dīwā xiǎnqū de shàng wàn míng qúnzhòng ānquán zhuǎnyí dào le bìxiǎn ānzhìdiǎn.',
    example_vi = 'Vài giờ trước khi siêu bão bất ngờ đổ bộ, sở chỉ huy ứng phó khẩn cấp phòng chống lũ cứu hộ địa phương đã khẩn cấp điều động hàng trăm chiếc xe khách, nhanh chóng di dời an toàn hơn một vạn người dân ở vùng trũng hiểm trở đến các điểm sơ tán lánh nạn.'
WHERE id = 'f0133a43-9c0d-40e9-85ad-6bc150021f55' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f0133a43-9c0d-40e9-85ad-6bc150021f55', '在突发超强台风登陆来临前数小时，当地防汛抢险应急指挥部紧急调集数百辆大巴车，迅速将低洼险区的上万名群众安全转移到了避险安置点。', 'Zài tūfā chāoqiáng táifēng dēnglù láilín qián shù xiǎoshí, dāngdì fángxùn qiǎngxiǎn yīngjí zhǐhuībù jǐnjí diàojí shù bǎi liàng dàbāchē, xùnsù jiāng dīwā xiǎnqū de shàng wàn míng qúnzhòng ānquán zhuǎnyí dào le bìxiǎn ānzhìdiǎn.', 'Vài giờ trước khi siêu bão bất ngờ đổ bộ, sở chỉ huy ứng phó khẩn cấp phòng chống lũ cứu hộ địa phương đã khẩn cấp điều động hàng trăm chiếc xe khách, nhanh chóng di dời an toàn hơn một vạn người dân ở vùng trũng hiểm trở đến các điểm sơ tán lánh nạn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f0133a43-9c0d-40e9-85ad-6bc150021f55'
);

-- [祝福] (zhùfú): chúc phúc, cầu chúc
UPDATE public.vocabularies
SET example_hanzi = '在金秋十月举行的隆重集体婚礼盛典上，全场亲朋好友怀着由衷的喜悦与感动，齐声为三十对步入婚姻殿堂的新人送上了最美好的真挚祝福。',
    example_pinyin = 'Zài jīnqiū shíyuè jǔxíng de lóngzhòng jítǐ hūnlǐ shèngdiǎn shang, quánchǎng qīnpéng-hǎoyǒu huáizhe yóuzhōng de xǐyuè yǔ gǎndòng, qíshēng wèi sānshí duì bùrù hūnyīn diàntáng de xīnrén sòng shàng le zuì měihǎo de zhēnzhì zhùfú.',
    example_vi = 'Tại buổi đại lễ đám cưới tập thể long trọng tổ chức vào tháng Mười mùa thu vàng, toàn thể bạn bè thân hữu mang niềm hân hoan và xúc động từ đáy lòng, đồng thanh gửi tới ba mươi cặp đôi bước vào ngưỡng cửa hôn nhân những lời chúc phúc chân thành đẹp đẽ nhất.'
WHERE id = 'f15b4c30-33c2-4785-8114-93519afb0466' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f15b4c30-33c2-4785-8114-93519afb0466', '在金秋十月举行的隆重集体婚礼盛典上，全场亲朋好友怀着由衷的喜悦与感动，齐声为三十对步入婚姻殿堂的新人送上了最美好的真挚祝福。', 'Zài jīnqiū shíyuè jǔxíng de lóngzhòng jítǐ hūnlǐ shèngdiǎn shang, quánchǎng qīnpéng-hǎoyǒu huáizhe yóuzhōng de xǐyuè yǔ gǎndòng, qíshēng wèi sānshí duì bùrù hūnyīn diàntáng de xīnrén sòng shàng le zuì měihǎo de zhēnzhì zhùfú.', 'Tại buổi đại lễ đám cưới tập thể long trọng tổ chức vào tháng Mười mùa thu vàng, toàn thể bạn bè thân hữu mang niềm hân hoan và xúc động từ đáy lòng, đồng thanh gửi tới ba mươi cặp đôi bước vào ngưỡng cửa hôn nhân những lời chúc phúc chân thành đẹp đẽ nhất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f15b4c30-33c2-4785-8114-93519afb0466'
);

-- [追究] (zhuījiū): truy cứu, điều tra
UPDATE public.vocabularies
SET example_hanzi = '国家环境保护综合行政执法局郑重声明，对任何非法恶意偷排有毒有害工业废水的违规责任企业，必将一查到底并依法严厉追究刑事法律责任。',
    example_pinyin = 'Guójiā huánjìng bǎohù zōnghé xíngzhèng zhífǎjú zhèngzhòng shēngmíng, duì rènhé fēifǎ èyì tōupái yǒudú yǒuhài gōngyè fèishuǐ de wéiguī zérèn qǐyè, bì jiāng yìchá-dàodǐ bìng yīfǎ yánlì zhuījiū xíngshì fǎlǜ zérèn.',
    example_vi = 'Cục Thực thi Pháp luật Hành chính Tổng hợp Bảo vệ Môi trường Quốc gia tuyên bố trang nghiêm rằng, đối với bất kỳ doanh nghiệp trách nhiệm vi phạm nào xả trộm phi pháp độc hại nước thải công nghiệp đều sẽ điều tra tới cùng và truy cứu nghiêm trị trách nhiệm pháp lý hình sự theo đúng quy định.'
WHERE id = 'bc0f9d01-ced9-4e46-a66a-a7f63e30f9c2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bc0f9d01-ced9-4e46-a66a-a7f63e30f9c2', '国家环境保护综合行政执法局郑重声明，对任何非法恶意偷排有毒有害工业废水的违规责任企业，必将一查到底并依法严厉追究刑事法律责任。', 'Guójiā huánjìng bǎohù zōnghé xíngzhèng zhífǎjú zhèngzhòng shēngmíng, duì rènhé fēifǎ èyì tōupái yǒudú yǒuhài gōngyè fèishuǐ de wéiguī zérèn qǐyè, bì jiāng yìchá-dàodǐ bìng yīfǎ yánlì zhuījiū xíngshì fǎlǜ zérèn.', 'Cục Thực thi Pháp luật Hành chính Tổng hợp Bảo vệ Môi trường Quốc gia tuyên bố trang nghiêm rằng, đối với bất kỳ doanh nghiệp trách nhiệm vi phạm nào xả trộm phi pháp độc hại nước thải công nghiệp đều sẽ điều tra tới cùng và truy cứu nghiêm trị trách nhiệm pháp lý hình sự theo đúng quy định.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bc0f9d01-ced9-4e46-a66a-a7f63e30f9c2'
);

-- [助理] (zhùlǐ): trợ lý
UPDATE public.vocabularies
SET example_hanzi = '这位踏实能干、工作严谨高效的年轻总经理行政助理，不仅能够妥善细致地安排各项高端商务行程，还善于在跨国多语种会议中精准起草要件。',
    example_pinyin = 'Zhè wèi tāshi nénggàn, gōngzuò yánjǐn gāoxiào de niánqīng zǒngjīnglǐ xíngzhèng zhùlǐ, bùjǐn nénggòu tuǒshàn xìzhì de ānpái gè xiàng gāoduān shāngwù xíngchéng, hái shànyú zài kuàguó duō yǔzhǒng huìyì zhōng jīngzhǔn qǐcǎo yàojiàn.',
    example_vi = 'Vị trợ lý hành chính tổng giám đốc trẻ tuổi làm việc chắc chắn tháo vát, nghiêm cẩn và hiệu quả cao này không chỉ có thể sắp xếp thỏa đáng tỉ mỉ mọi lịch trình thương vụ cao cấp, mà còn giỏi soạn thảo văn kiện chuẩn xác trong các cuộc họp đa ngôn ngữ xuyên quốc gia.'
WHERE id = '78c1080a-e612-4deb-9b74-c9deee1c2a34' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '78c1080a-e612-4deb-9b74-c9deee1c2a34', '这位踏实能干、工作严谨高效的年轻总经理行政助理，不仅能够妥善细致地安排各项高端商务行程，还善于在跨国多语种会议中精准起草要件。', 'Zhè wèi tāshi nénggàn, gōngzuò yánjǐn gāoxiào de niánqīng zǒngjīnglǐ xíngzhèng zhùlǐ, bùjǐn nénggòu tuǒshàn xìzhì de ānpái gè xiàng gāoduān shāngwù xíngchéng, hái shànyú zài kuàguó duō yǔzhǒng huìyì zhōng jīngzhǔn qǐcǎo yàojiàn.', 'Vị trợ lý hành chính tổng giám đốc trẻ tuổi làm việc chắc chắn tháo vát, nghiêm cẩn và hiệu quả cao này không chỉ có thể sắp xếp thỏa đáng tỉ mỉ mọi lịch trình thương vụ cao cấp, mà còn giỏi soạn thảo văn kiện chuẩn xác trong các cuộc họp đa ngôn ngữ xuyên quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '78c1080a-e612-4deb-9b74-c9deee1c2a34'
);

-- [助手] (zhùshǒu): trợ thủ, người giúp việc
UPDATE public.vocabularies
SET example_hanzi = '主刀心外科教授与站在手术台旁的青年助手配合得极其默契娴熟，在长达八个小时的惊心动魄复杂手术中成功挽救了危重患者的年轻生命。',
    example_pinyin = 'Zhǔdāo xīnwàikē jiàoshòu yǔ zhàn zài shǒushùtái páng de niánqīng zhùshǒu pèihé de jíqí mòqì xiánshú, zài chángdá bā gè xiǎoshí de jīngxīn-dòngpò fùzá shǒushù zhōng chénggōng wǎnjiù le wēizhòng huànzhě de niánqīng shēngmìng.',
    example_vi = 'Giáo sư ngoại tim mạch mổ chính và người trợ thủ trẻ tuổi đứng bên bàn mổ phối hợp vô cùng ăn ý thuần thục, trong ca phẫu thuật phức tạp thót tim kéo dài suốt tám tiếng đồng hồ đã cứu sống thành công sinh mạng trẻ của bệnh nhân nguy kịch.'
WHERE id = '33fc22f2-aac1-4489-a904-ce144def5416' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '33fc22f2-aac1-4489-a904-ce144def5416', '主刀心外科教授与站在手术台旁的青年助手配合得极其默契娴熟，在长达八个小时的惊心动魄复杂手术中成功挽救了危重患者的年轻生命。', 'Zhǔdāo xīnwàikē jiàoshòu yǔ zhàn zài shǒushùtái páng de niánqīng zhùshǒu pèihé de jíqí mòqì xiánshú, zài chángdá bā gè xiǎoshí de jīngxīn-dòngpò fùzá shǒushù zhōng chénggōng wǎnjiù le wēizhòng huànzhě de niánqīng shēngmìng.', 'Giáo sư ngoại tim mạch mổ chính và người trợ thủ trẻ tuổi đứng bên bàn mổ phối hợp vô cùng ăn ý thuần thục, trong ca phẫu thuật phức tạp thót tim kéo dài suốt tám tiếng đồng hồ đã cứu sống thành công sinh mạng trẻ của bệnh nhân nguy kịch.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '33fc22f2-aac1-4489-a904-ce144def5416'
);

-- [住宅] (zhùzhái): nhà ở, nơi cư trú
UPDATE public.vocabularies
SET example_hanzi = '市政府启动的新型保障性绿色住宅示范小区项目，不仅全部按照最高级别的节能降碳标准设计建造，更极大地圆了数千户低收入工薪家庭的安居之梦。',
    example_pinyin = 'Shìzhèngfǔ qǐdòng de xīnxíng bǎozhàngxìng lǜsè zhùzhái shìfàn xiǎoqū xiàngmù, bùjǐn quánbù ànzhào zuìgāo jíbié de jiénéng jiàngtàn biāozhǔn shèjì jiànzào, gèng jídà de yuán le shù qiān hù dī shōurù gōngxīn jiātíng de ānjū zhī mèng.',
    example_vi = 'Dự án khu tập thể mẫu nhà ở xanh mang tính bảo đảm an sinh kiểu mới do chính quyền thành phố khởi động không chỉ toàn bộ thiết kế xây dựng theo tiêu chuẩn tiết kiệm năng lượng giảm carbon cấp cao nhất, mà còn thực hiện hóa giấc mơ an cư của hàng ngàn hộ gia đình ăn lương có thu nhập thấp.'
WHERE id = '6a1358dc-54f6-4a19-9ded-d71c985af8d0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6a1358dc-54f6-4a19-9ded-d71c985af8d0', '市政府启动的新型保障性绿色住宅示范小区项目，不仅全部按照最高级别的节能降碳标准设计建造，更极大地圆了数千户低收入工薪家庭的安居之梦。', 'Shìzhèngfǔ qǐdòng de xīnxíng bǎozhàngxìng lǜsè zhùzhái shìfàn xiǎoqū xiàngmù, bùjǐn quánbù ànzhào zuìgāo jíbié de jiénéng jiàngtàn biāozhǔn shèjì jiànzào, gèng jídà de yuán le shù qiān hù dī shōurù gōngxīn jiātíng de ānjū zhī mèng.', 'Dự án khu tập thể mẫu nhà ở xanh mang tính bảo đảm an sinh kiểu mới do chính quyền thành phố khởi động không chỉ toàn bộ thiết kế xây dựng theo tiêu chuẩn tiết kiệm năng lượng giảm carbon cấp cao nhất, mà còn thực hiện hóa giấc mơ an cư của hàng ngàn hộ gia đình ăn lương có thu nhập thấp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6a1358dc-54f6-4a19-9ded-d71c985af8d0'
);

-- [主张] (zhǔzhāng): chủ trương, quan điểm
UPDATE public.vocabularies
SET example_hanzi = '在应对全球气候急剧变暖这一重大人类共同挑战的国际峰会上，广大发展中国家一致坚定主张发达国家应当切实履行减排承诺并提供资金技术援助。',
    example_pinyin = 'Zài yìngduì quánqiú qìhòu jíjù biànnuǎn zhè yí zhòngdà rénlèi gòngtóng tiǎozhàn de guójì fēnghuì shang, guǎngdà fāzhǎnzhōng guójiā yízhì jiāndìng zhǔzhāng fādá guójiā yīngdāng qièshí lǚxíng jiǎnpái chéngnuò bìng tígōng zījīn jìshù yuánzhù.',
    example_vi = 'Tại hội nghị thượng đỉnh quốc tế ứng phó với thách thức chung lớn của toàn nhân loại là biến đổi khí hậu toàn cầu ấm lên nhanh chóng, đông đảo các nước đang phát triển đồng thanh kiên định chủ trương các nước phát triển cần thực hiện thiết thực cam kết cắt giảm khí thải và viện trợ vốn cùng công nghệ.'
WHERE id = 'c19ab951-68dd-4868-92d1-daefe185bf06' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c19ab951-68dd-4868-92d1-daefe185bf06', '在应对全球气候急剧变暖这一重大人类共同挑战的国际峰会上，广大发展中国家一致坚定主张发达国家应当切实履行减排承诺并提供资金技术援助。', 'Zài yìngduì quánqiú qìhòu jíjù biànnuǎn zhè yí zhòngdà rénlèi gòngtóng tiǎozhàn de guójì fēnghuì shang, guǎngdà fāzhǎnzhōng guójiā yízhì jiāndìng zhǔzhāng fādá guójiā yīngdāng qièshí lǚxíng jiǎnpái chéngnuò bìng tígōng zījīn jìshù yuánzhù.', 'Tại hội nghị thượng đỉnh quốc tế ứng phó với thách thức chung lớn của toàn nhân loại là biến đổi khí hậu toàn cầu ấm lên nhanh chóng, đông đảo các nước đang phát triển đồng thanh kiên định chủ trương các nước phát triển cần thực hiện thiết thực cam kết cắt giảm khí thải và viện trợ vốn cùng công nghệ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c19ab951-68dd-4868-92d1-daefe185bf06'
);

-- [著作] (zhùzuò): tác phẩm, trước tác
UPDATE public.vocabularies
SET example_hanzi = '这位德高望重的历史学泰斗在耄耋之年终于完成了这部长达两百万字、融贯东西方文明交流史的学术宏篇著作，赢得了海内外学术界的由衷赞赏。',
    example_pinyin = 'Zhè wèi dégāo-wàngzhòng de lìshǐxué tàidǒu zài màodié zhī nián zhōngyú wánchéng le zhè bù chángdá liǎngbǎi wàn zì, róngguàn dōng-xīfāng wénmíng jiāoliúshǐ de xuéshù hóngpiān zhùzuò, yíngdé le hǎinèiwài xuéshùjiè de yóuzhōng zànshǎng.',
    example_vi = 'Vị thái đấu lịch sử học đức cao vọng trọng này vào tuổi bát tuần cuối cùng đã hoàn thành tác phẩm trước tác học thuật đồ sộ dài hai triệu chữ quán triệt lịch sử giao lưu văn minh Đông - Tây, giành được sự tán thưởng xuất phát từ đáy lòng của giới học thuật trong và ngoài nước.'
WHERE id = 'afbc2211-0fd9-4d42-90fd-1edcd6848eb0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'afbc2211-0fd9-4d42-90fd-1edcd6848eb0', '这位德高望重的历史学泰斗在耄耋之年终于完成了这部长达两百万字、融贯东西方文明交流史的学术宏篇著作，赢得了海内外学术界的由衷赞赏。', 'Zhè wèi dégāo-wàngzhòng de lìshǐxué tàidǒu zài màodié zhī nián zhōngyú wánchéng le zhè bù chángdá liǎngbǎi wàn zì, róngguàn dōng-xīfāng wénmíng jiāoliúshǐ de xuéshù hóngpiān zhùzuò, yíngdé le hǎinèiwài xuéshùjiè de yóuzhōng zànshǎng.', 'Vị thái đấu lịch sử học đức cao vọng trọng này vào tuổi bát tuần cuối cùng đã hoàn thành tác phẩm trước tác học thuật đồ sộ dài hai triệu chữ quán triệt lịch sử giao lưu văn minh Đông - Tây, giành được sự tán thưởng xuất phát từ đáy lòng của giới học thuật trong và ngoài nước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'afbc2211-0fd9-4d42-90fd-1edcd6848eb0'
);

-- [资本] (zīběn): vốn, tư bản
UPDATE public.vocabularies
SET example_hanzi = '依法规范引导金融资本健康有序发展并让金融活水精准滴灌实体经济与科技创新企业，是防范系统性金融风险、推动国家高质量发展的必由之路。',
    example_pinyin = 'Yīfǎ guīfàn yǐndǎo jīnróng zīběn jiànkāng yǒuxù fāzhǎn bìng ràng jīnróng huóshuǐ jīngzhǔn dīguàn shítǐ jīngjì yǔ kējì chuàngxīn qǐyè, shì fángfàn xìtǒngxìng jīnróng fēngxiǎn, tuīdòng guójiā gāo zhìliàng fāzhǎn de bìyóuzhīlù.',
    example_vi = 'Quy phạm hóa dẫn dắt tư bản vốn tài chính phát triển lành mạnh có trật tự theo pháp luật và để nguồn nước sống tài chính tưới nhỏ giọt chuẩn xác cho nền kinh tế thực cùng doanh nghiệp đổi mới công nghệ là con đường tất yếu để phòng ngừa rủi ro tài chính mang tính hệ thống và thúc đẩy đất nước phát triển chất lượng cao.'
WHERE id = 'a43a5942-02a0-4706-a9eb-217ed2c1aa28' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a43a5942-02a0-4706-a9eb-217ed2c1aa28', '依法规范引导金融资本健康有序发展并让金融活水精准滴灌实体经济与科技创新企业，是防范系统性金融风险、推动国家高质量发展的必由之路。', 'Yīfǎ guīfàn yǐndǎo jīnróng zīběn jiànkāng yǒuxù fāzhǎn bìng ràng jīnróng huóshuǐ jīngzhǔn dīguàn shítǐ jīngjì yǔ kējì chuàngxīn qǐyè, shì fángfàn xìtǒngxìng jīnróng fēngxiǎn, tuīdòng guójiā gāo zhìliàng fāzhǎn de bìyóuzhīlù.', 'Quy phạm hóa dẫn dắt tư bản vốn tài chính phát triển lành mạnh có trật tự theo pháp luật và để nguồn nước sống tài chính tưới nhỏ giọt chuẩn xác cho nền kinh tế thực cùng doanh nghiệp đổi mới công nghệ là con đường tất yếu để phòng ngừa rủi ro tài chính mang tính hệ thống và thúc đẩy đất nước phát triển chất lượng cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a43a5942-02a0-4706-a9eb-217ed2c1aa28'
);

-- [资产] (zīchǎn): tài sản
UPDATE public.vocabularies
SET example_hanzi = '这家拥有雄厚综合实力的跨国银行凭借先进的数字化风险控制系统，为数以百万计的个人与机构客户提供全方位的优质资产托管与增值保值服务。',
    example_pinyin = 'Zhè jiā yōngyǒu xiónghòu zōnghé shílì de kuàguó yínháng píngjiè xiānjìn de shùzìhuà fēngxiǎn kòngzhì xìtǒng, wèi shù yǐ bǎiwàn jì de gèrén yǔ jīgòu kèhù tígōng quánfāngwèi de yōuzhì zīchǎn tuōguǎn yǔ zēngzhí bǎozhí fúwù.',
    example_vi = 'Ngân hàng đa quốc gia có thực lực tổng hợp hùng hậu này dựa vào hệ thống kiểm soát rủi ro số hóa tiên tiến đã cung cấp dịch vụ quản thác tài sản và bảo toàn gia tăng giá trị tài sản chất lượng cao toàn diện cho hàng triệu khách hàng cá nhân và tổ chức.'
WHERE id = '65b3cc3b-60bf-47a6-9fbc-c8d8d73f9d60' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '65b3cc3b-60bf-47a6-9fbc-c8d8d73f9d60', '这家拥有雄厚综合实力的跨国银行凭借先进的数字化风险控制系统，为数以百万计的个人与机构客户提供全方位的优质资产托管与增值保值服务。', 'Zhè jiā yōngyǒu xiónghòu zōnghé shílì de kuàguó yínháng píngjiè xiānjìn de shùzìhuà fēngxiǎn kòngzhì xìtǒng, wèi shù yǐ bǎiwàn jì de gèrén yǔ jīgòu kèhù tígōng quánfāngwèi de yōuzhì zīchǎn tuōguǎn yǔ zēngzhí bǎozhí fúwù.', 'Ngân hàng đa quốc gia có thực lực tổng hợp hùng hậu này dựa vào hệ thống kiểm soát rủi ro số hóa tiên tiến đã cung cấp dịch vụ quản thác tài sản và bảo toàn gia tăng giá trị tài sản chất lượng cao toàn diện cho hàng triệu khách hàng cá nhân và tổ chức.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '65b3cc3b-60bf-47a6-9fbc-c8d8d73f9d60'
);

-- [自豪] (zìháo): tự hào
UPDATE public.vocabularies
SET example_hanzi = '当鲜艳夺目的五星红旗在国际奥林匹克运动会颁奖典礼现场伴随着雄壮国歌冉冉升起的那一刻，站在最高领奖台上的奥运冠军眼中噙满了幸福而自豪的泪花。',
    example_pinyin = 'Dāng xiānyàn-duómù de wǔxīng hóngqí zài guójì àolínpǐkè yùndònghuì bānjiǎng diǎnlǐ xiànchǎng bànsuí zhe xióngzhuàng guógē rǎnrǎn shēngqǐ de nà yí kè, zhàn zài zuìgāo lǐngjiǎngtái shang de àoyùn guànjūn yǎn zhōng qín mǎn le xìngfú ér zìháo de lèihuā.',
    example_vi = 'Vào giây phút lá cờ đỏ năm sao rực rỡ chói lọi từ từ bay lên theo điệu quốc ca hùng tráng tại lễ trao giải Thế vận hội Olympic quốc tế, trong mắt người quán quân Olympic đứng trên bục vinh quang cao nhất ngấn trọn những giọt lệ hạnh phúc và tự hào.'
WHERE id = '8a983bec-9582-44fe-a1b5-8acf3b0353b2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8a983bec-9582-44fe-a1b5-8acf3b0353b2', '当鲜艳夺目的五星红旗在国际奥林匹克运动会颁奖典礼现场伴随着雄壮国歌冉冉升起的那一刻，站在最高领奖台上的奥运冠军眼中噙满了幸福而自豪的泪花。', 'Dāng xiānyàn-duómù de wǔxīng hóngqí zài guójì àolínpǐkè yùndònghuì bānjiǎng diǎnlǐ xiànchǎng bànsuí zhe xióngzhuàng guógē rǎnrǎn shēngqǐ de nà yí kè, zhàn zài zuìgāo lǐngjiǎngtái shang de àoyùn guànjūn yǎn zhōng qín mǎn le xìngfú ér zìháo de lèihuā.', 'Vào giây phút lá cờ đỏ năm sao rực rỡ chói lọi từ từ bay lên theo điệu quốc ca hùng tráng tại lễ trao giải Thế vận hội Olympic quốc tế, trong mắt người quán quân Olympic đứng trên bục vinh quang cao nhất ngấn trọn những giọt lệ hạnh phúc và tự hào.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8a983bec-9582-44fe-a1b5-8acf3b0353b2'
);

-- [字幕] (zìmù): phụ đề
UPDATE public.vocabularies
SET example_hanzi = '市电视台在所有热播纪录片中均配发了高清晰度同步字幕，极大方便了听障观众。',
    example_pinyin = 'Shì diànshìtái zài suǒyǒu rèbō jìlùpiàn zhōng jūn pèifā le gāo qīngxīdù tóngbù zìmù, jídà fāngbiàn le tīngzhàng guānzhòng.',
    example_vi = 'Đài truyền hình thành phố tại mọi phim tài liệu ăn khách đều phát kèm phụ đề đồng bộ độ nét cao, tạo thuận lợi lớn cho khán giả khiếm thính.'
WHERE id = 'fc8fbde6-ab24-4780-87c5-88a74920869f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'fc8fbde6-ab24-4780-87c5-88a74920869f', '市电视台在所有热播纪录片中均配发了高清晰度同步字幕，极大方便了听障观众。', 'Shì diànshìtái zài suǒyǒu rèbō jìlùpiàn zhōng jūn pèifā le gāo qīngxīdù tóngbù zìmù, jídà fāngbiàn le tīngzhàng guānzhòng.', 'Đài truyền hình thành phố tại mọi phim tài liệu ăn khách đều phát kèm phụ đề đồng bộ độ nét cao, tạo thuận lợi lớn cho khán giả khiếm thính.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'fc8fbde6-ab24-4780-87c5-88a74920869f'
);

-- [自愿] (zìyuàn): tự nguyện
UPDATE public.vocabularies
SET example_hanzi = '来自全国数十所高等院校的五百余名朝气蓬勃的青年大学生，积极自愿报名参加了为期两年的支援西部山区基础教育乡村振兴志愿支教计划。',
    example_pinyin = 'Láizì quánguó shùshí suǒ gāoděng yuànxiào de wǔbǎi yú míng zhāoqì-péngbó de qīngnián dàxuéshēng, jījí zìyuàn bàomíng cānjiā le wéiqī liǎng nián de zhīyuán xībù shānqū jīchǔ jiàoyù xiāngcūn zhènxīng zhìyuàn zhījiào jìhuà.',
    example_vi = 'Hơn năm trăm sinh viên đại học trẻ trung căng tràn nhựa sống đến từ hàng chục trường đại học trên toàn quốc đã tích cực tự nguyện đăng ký tham gia kế hoạch tình nguyện chi viện giảng dạy giáo dục cơ sở chấn hưng nông thôn vùng núi miền Tây có thời hạn là hai năm.'
WHERE id = '5bc37cf0-50aa-4d79-a662-57183d64180f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5bc37cf0-50aa-4d79-a662-57183d64180f', '来自全国数十所高等院校的五百余名朝气蓬勃的青年大学生，积极自愿报名参加了为期两年的支援西部山区基础教育乡村振兴志愿支教计划。', 'Láizì quánguó shùshí suǒ gāoděng yuànxiào de wǔbǎi yú míng zhāoqì-péngbó de qīngnián dàxuéshēng, jījí zìyuàn bàomíng cānjiā le wéiqī liǎng nián de zhīyuán xībù shānqū jīchǔ jiàoyù xiāngcūn zhènxīng zhìyuàn zhījiào jìhuà.', 'Hơn năm trăm sinh viên đại học trẻ trung căng tràn nhựa sống đến từ hàng chục trường đại học trên toàn quốc đã tích cực tự nguyện đăng ký tham gia kế hoạch tình nguyện chi viện giảng dạy giáo dục cơ sở chấn hưng nông thôn vùng núi miền Tây có thời hạn là hai năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5bc37cf0-50aa-4d79-a662-57183d64180f'
);

-- [总裁] (zǒngcái): tổng giám đốc, chủ tịch
UPDATE public.vocabularies
SET example_hanzi = '在这家跨国新能源科技企业年度全球战略创新峰会上，集团轮值全球执行总裁发表了主题为《以颠覆性清洁科技重塑绿色未来》的重磅主旨演讲。',
    example_pinyin = 'Zài zhè jiā kuàguó xīn néngyuán kējì qǐyè niándù quánqiú zhànlüè chuàngxīn fēnghuì shang, jítuán lúnzhí quánqiú zhíxíng zǒngcái fābiǎo le zhǔtí wéi 《Yǐ diānfùxìng qīngjié kējì chóngsù lǜsè wèilái》 de zhòngbàng zhǔzhǐ yǎnjiǎng.',
    example_vi = 'Tại hội nghị thượng đỉnh đổi mới chiến lược toàn cầu thường niên của doanh nghiệp công nghệ năng lượng mới đa quốc gia này, Tổng giám đốc điều hành toàn cầu luân phiên của tập đoàn đã có bài diễn văn chủ đề trọng lượng mang tên ''Dùng công nghệ sạch mang tính đột phá để tái định hình tương lai xanh''.'
WHERE id = 'a5aea389-88d7-4c01-bfc9-56c39ab0e95c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a5aea389-88d7-4c01-bfc9-56c39ab0e95c', '在这家跨国新能源科技企业年度全球战略创新峰会上，集团轮值全球执行总裁发表了主题为《以颠覆性清洁科技重塑绿色未来》的重磅主旨演讲。', 'Zài zhè jiā kuàguó xīn néngyuán kējì qǐyè niándù quánqiú zhànlüè chuàngxīn fēnghuì shang, jítuán lúnzhí quánqiú zhíxíng zǒngcái fābiǎo le zhǔtí wéi 《Yǐ diānfùxìng qīngjié kējì chóngsù lǜsè wèilái》 de zhòngbàng zhǔzhǐ yǎnjiǎng.', 'Tại hội nghị thượng đỉnh đổi mới chiến lược toàn cầu thường niên của doanh nghiệp công nghệ năng lượng mới đa quốc gia này, Tổng giám đốc điều hành toàn cầu luân phiên của tập đoàn đã có bài diễn văn chủ đề trọng lượng mang tên ''Dùng công nghệ sạch mang tính đột phá để tái định hình tương lai xanh''.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a5aea389-88d7-4c01-bfc9-56c39ab0e95c'
);

-- [总理] (zǒnglǐ): thủ tướng
UPDATE public.vocabularies
SET example_hanzi = '在两国隆重举行的双边高级别战略伙伴关系会谈结束后，国务院总理与远道而来的外国政府总理共同出席了涉及经贸科技合作的一揽子双边协定签字仪式。',
    example_pinyin = 'Zài liǎng guó lóngzhòng jǔxíng de shuāngbiān gāojíbié zhànlüè huǒbàn guānxì huìtán jiéshù hòu, Guówùyuàn Zǒnglǐ yǔ yuǎndào''érlái de wàiguó zhèngfǔ zǒnglǐ gòngtóng chūxí le shèjí jīngmào kējì hézuò de yìlǎnzǐ shuāngbiān xiédìng qiānzì yíshì.',
    example_vi = 'Sau khi cuộc hội đàm quan hệ đối tác chiến lược cấp cao song phương long trọng của hai nước kết thúc, Thủ tướng Quốc vụ viện cùng Thủ tướng chính phủ nước ngoài từ phương xa tới đã cùng tham dự lễ ký kết một gói hiệp định song phương liên quan đến hợp tác kinh tế thương mại và công nghệ.'
WHERE id = '1e560e04-25f6-4028-8566-27506b50e4fc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1e560e04-25f6-4028-8566-27506b50e4fc', '在两国隆重举行的双边高级别战略伙伴关系会谈结束后，国务院总理与远道而来的外国政府总理共同出席了涉及经贸科技合作的一揽子双边协定签字仪式。', 'Zài liǎng guó lóngzhòng jǔxíng de shuāngbiān gāojíbié zhànlüè huǒbàn guānxì huìtán jiéshù hòu, Guówùyuàn Zǒnglǐ yǔ yuǎndào''érlái de wàiguó zhèngfǔ zǒnglǐ gòngtóng chūxí le shèjí jīngmào kējì hézuò de yìlǎnzǐ shuāngbiān xiédìng qiānzì yíshì.', 'Sau khi cuộc hội đàm quan hệ đối tác chiến lược cấp cao song phương long trọng của hai nước kết thúc, Thủ tướng Quốc vụ viện cùng Thủ tướng chính phủ nước ngoài từ phương xa tới đã cùng tham dự lễ ký kết một gói hiệp định song phương liên quan đến hợp tác kinh tế thương mại và công nghệ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1e560e04-25f6-4028-8566-27506b50e4fc'
);

-- [棕色] (zōngsè): màu nâu
UPDATE public.vocabularies
SET example_hanzi = '这位手艺精湛的老木匠选用上等珍贵的百年天然胡桃木，经过十余道纯手工打磨抛光工序，精心打造出了一套散发着温润光泽的深棕色古典实木书桌椅。',
    example_pinyin = 'Zhè wèi shǒuyì jīngzhàn de lǎo mùjiàng xuǎnyòng shàngděng zhēnguì de bǎinián tiānrán hútáomù, jīngguò shí yú dào chún shǒugōng dǎmó pāoguāng gōngxù, jīngxīn dǎzào chū le yí tào sànfā zhe wēnrùn guāngzé de shēnzōngsè gǔdiǎn shímù shūzhuō-yǐ.',
    example_vi = 'Người thợ mộc già có tay nghề tinh xảo này đã tuyển chọn loại gỗ óc chó tự nhiên trăm năm thượng hạng quý giá, trải qua hơn mười công đoạn mài bóng thủ công thuần túy, kỳ công chế tác nên một bộ bàn ghế đọc sách bằng gỗ thật cổ điển màu nâu sẫm tỏa ra ánh sáng ấm áp bóng bẩy.'
WHERE id = 'ca91b56a-8c15-491a-8247-1a9a82a7bc37' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ca91b56a-8c15-491a-8247-1a9a82a7bc37', '这位手艺精湛的老木匠选用上等珍贵的百年天然胡桃木，经过十余道纯手工打磨抛光工序，精心打造出了一套散发着温润光泽的深棕色古典实木书桌椅。', 'Zhè wèi shǒuyì jīngzhàn de lǎo mùjiàng xuǎnyòng shàngděng zhēnguì de bǎinián tiānrán hútáomù, jīngguò shí yú dào chún shǒugōng dǎmó pāoguāng gōngxù, jīngxīn dǎzào chū le yí tào sànfā zhe wēnrùn guāngzé de shēnzōngsè gǔdiǎn shímù shūzhuō-yǐ.', 'Người thợ mộc già có tay nghề tinh xảo này đã tuyển chọn loại gỗ óc chó tự nhiên trăm năm thượng hạng quý giá, trải qua hơn mười công đoạn mài bóng thủ công thuần túy, kỳ công chế tác nên một bộ bàn ghế đọc sách bằng gỗ thật cổ điển màu nâu sẫm tỏa ra ánh sáng ấm áp bóng bẩy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ca91b56a-8c15-491a-8247-1a9a82a7bc37'
);

-- [总算] (zǒngsuàn): cuối cùng cũng
UPDATE public.vocabularies
SET example_hanzi = '历经长达三年无数个不眠之夜的严密试验与反复调试攻关，这个由我国青年科研团队自主研发的深空探测核心载荷今天总算顺利通过了国家级终审验收。',
    example_pinyin = 'Lìjīng chángdá sān nián wúshù gè bùmián zhī yè de yánmì shìyàn yǔ fǎnfù tiáoshì gōngguān, zhè gè yóu wǒguó qīngnián kēyán tuánduì zìzhǔ yánfā de shēnkōng tàncè héxīn zàihè jīntiān zǒngsuàn shùnlì tōngguò le guójiājí zhōngshěn yànshōu.',
    example_vi = 'Trải qua suốt ba năm với vô số đêm không ngủ thử nghiệm nghiêm ngặt và tinh chỉnh công phá nhiều lần, tải trọng cốt lõi thăm dò không gian sâu do đội ngũ nghiên cứu trẻ nước ta tự chủ phát triển hôm nay cuối cùng cũng đã thuận lợi vượt qua nghiệm thu chung thẩm cấp quốc gia.'
WHERE id = 'd856ed5d-42a3-4433-87f2-384b99857396' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd856ed5d-42a3-4433-87f2-384b99857396', '历经长达三年无数个不眠之夜的严密试验与反复调试攻关，这个由我国青年科研团队自主研发的深空探测核心载荷今天总算顺利通过了国家级终审验收。', 'Lìjīng chángdá sān nián wúshù gè bùmián zhī yè de yánmì shìyàn yǔ fǎnfù tiáoshì gōngguān, zhè gè yóu wǒguó qīngnián kēyán tuánduì zìzhǔ yánfā de shēnkōng tàncè héxīn zàihè jīntiān zǒngsuàn shùnlì tōngguò le guójiājí zhōngshěn yànshōu.', 'Trải qua suốt ba năm với vô số đêm không ngủ thử nghiệm nghiêm ngặt và tinh chỉnh công phá nhiều lần, tải trọng cốt lõi thăm dò không gian sâu do đội ngũ nghiên cứu trẻ nước ta tự chủ phát triển hôm nay cuối cùng cũng đã thuận lợi vượt qua nghiệm thu chung thẩm cấp quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd856ed5d-42a3-4433-87f2-384b99857396'
);

-- [走廊] (zǒuláng): hành lang
UPDATE public.vocabularies
SET example_hanzi = '这所具有深厚百年历史底蕴的重点中学校园教学楼内，宽敞明亮的走廊两侧文化墙上挂满了杰出历届校友的名言警句与前沿科学发明成果介绍展板。',
    example_pinyin = 'Zhè suǒ jùyǒu shēnhòu bǎinián lìshǐ dǐyùn de zhòngdiǎn zhōngxué xiàoyuán jiàoxuélóu nèi, kuānchǎng míngliàng de zǒuláng liǎngcè wénhuàqiáng shang guàmǎn le jiéchū lìjiè xiàoyǒu de míngyán-jǐngjù yǔ qiányán kēxué fāmíng chéngguǒ jièshào zhǎnbǎn.',
    example_vi = 'Bên trong tòa nhà giảng đường khuôn viên trường trung học trọng điểm có bề dày lịch sử trăm năm sâu đậm này, trên bức tường văn hóa ở hai bên hành lang rộng rãi sáng sủa treo kín những danh ngôn cảnh báo của các cựu học sinh ưu tú cùng bảng triển lãm giới thiệu thành quả phát minh khoa học đi đầu.'
WHERE id = '3c9ee2b0-9f44-4faa-8312-85703eace44b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3c9ee2b0-9f44-4faa-8312-85703eace44b', '这所具有深厚百年历史底蕴的重点中学校园教学楼内，宽敞明亮的走廊两侧文化墙上挂满了杰出历届校友的名言警句与前沿科学发明成果介绍展板。', 'Zhè suǒ jùyǒu shēnhòu bǎinián lìshǐ dǐyùn de zhòngdiǎn zhōngxué xiàoyuán jiàoxuélóu nèi, kuānchǎng míngliàng de zǒuláng liǎngcè wénhuàqiáng shang guàmǎn le jiéchū lìjiè xiàoyǒu de míngyán-jǐngjù yǔ qiányán kēxué fāmíng chéngguǒ jièshào zhǎnbǎn.', 'Bên trong tòa nhà giảng đường khuôn viên trường trung học trọng điểm có bề dày lịch sử trăm năm sâu đậm này, trên bức tường văn hóa ở hai bên hành lang rộng rãi sáng sủa treo kín những danh ngôn cảnh báo của các cựu học sinh ưu tú cùng bảng triển lãm giới thiệu thành quả phát minh khoa học đi đầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3c9ee2b0-9f44-4faa-8312-85703eace44b'
);

-- [阻碍] (zǔ'ài): cản trở, trở ngại
UPDATE public.vocabularies
SET example_hanzi = '全面深化各领域改革开放必须以壮士断腕的巨大政治勇气破除既得利益群体的固化藩篱，坚决破除一切阻碍经济社会创新繁荣发展的体制机制障碍弊端。',
    example_pinyin = 'Quánmiàn shēnhuà gè lǐngyù gǎigé-kāifàng bìxū yǐ zhuàngshì-duànwàn de jùdà zhèngzhì yǒngqì pòchú jìdé lìyì qúntǐ de gùhuà fānlí, jiānjué pòchú yíqiè zǔ''ài jīngjì shèhuì chuàngxīn fánróng fāzhǎn de tǐzhì jīzhì zhàng''ài bìduān.',
    example_vi = 'Cải cách mở cửa sâu rộng toàn diện trên các lĩnh vực bắt buộc phải dùng dũng khí chính trị to lớn tráng sĩ chặt tay để phá bỏ rào giậu kiên cố của các nhóm lợi ích cục bộ, kiên quyết dẹp bỏ mọi rào cản tệ đoan về cơ chế thể chế cản trở sự phát triển thịnh vượng đổi mới kinh tế xã hội.'
WHERE id = '293c6f93-3f73-4d74-8061-6d4deffdf25c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '293c6f93-3f73-4d74-8061-6d4deffdf25c', '全面深化各领域改革开放必须以壮士断腕的巨大政治勇气破除既得利益群体的固化藩篱，坚决破除一切阻碍经济社会创新繁荣发展的体制机制障碍弊端。', 'Quánmiàn shēnhuà gè lǐngyù gǎigé-kāifàng bìxū yǐ zhuàngshì-duànwàn de jùdà zhèngzhì yǒngqì pòchú jìdé lìyì qúntǐ de gùhuà fānlí, jiānjué pòchú yíqiè zǔ''ài jīngjì shèhuì chuàngxīn fánróng fāzhǎn de tǐzhì jīzhì zhàng''ài bìduān.', 'Cải cách mở cửa sâu rộng toàn diện trên các lĩnh vực bắt buộc phải dùng dũng khí chính trị to lớn tráng sĩ chặt tay để phá bỏ rào giậu kiên cố của các nhóm lợi ích cục bộ, kiên quyết dẹp bỏ mọi rào cản tệ đoan về cơ chế thể chế cản trở sự phát triển thịnh vượng đổi mới kinh tế xã hội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '293c6f93-3f73-4d74-8061-6d4deffdf25c'
);

-- [祖国] (zǔguó): tổ quốc
UPDATE public.vocabularies
SET example_hanzi = '无论身处世界哪个遥远的国度与角落，广大心系桑梓的海外华侨华人始终心系祖国的繁荣富强，并用实际行动积极为家乡的高质量建设添砖加瓦。',
    example_pinyin = 'Wúlùn shēnchǔ shìjiè nǎ gè yáoyuǎn de guódù yǔ jiǎoluò, guǎngdà xīnxì sāngzǐ de hǎiwài huáqiáo huárén shǐzhōng xīnxì zǔguó de fánróng-fùqiáng, bìng yòng shíjì xíngdòng jījí wèi jiāxiāng de gāo zhìliàng jiànshè tiānzhuān-jiāwǎ.',
    example_vi = 'Dù cho ở bất kỳ góc biển chân trời xa xôi nào trên thế giới, đông đảo kiều bào và người gốc Hoa luôn hướng về cội nguồn quê hương, đau đáu nhớ về sự phồn vinh giàu mạnh của Tổ quốc và dùng hành động thực tế tích cực góp gạch dựng xây quê nhà phát triển chất lượng cao.'
WHERE id = '19ecee2e-30f0-45e8-a803-e0764526c919' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '19ecee2e-30f0-45e8-a803-e0764526c919', '无论身处世界哪个遥远的国度与角落，广大心系桑梓的海外华侨华人始终心系祖国的繁荣富强，并用实际行动积极为家乡的高质量建设添砖加瓦。', 'Wúlùn shēnchǔ shìjiè nǎ gè yáoyuǎn de guódù yǔ jiǎoluò, guǎngdà xīnxì sāngzǐ de hǎiwài huáqiáo huárén shǐzhōng xīnxì zǔguó de fánróng-fùqiáng, bìng yòng shíjì xíngdòng jījí wèi jiāxiāng de gāo zhìliàng jiànshè tiānzhuān-jiāwǎ.', 'Dù cho ở bất kỳ góc biển chân trời xa xôi nào trên thế giới, đông đảo kiều bào và người gốc Hoa luôn hướng về cội nguồn quê hương, đau đáu nhớ về sự phồn vinh giàu mạnh của Tổ quốc và dùng hành động thực tế tích cực góp gạch dựng xây quê nhà phát triển chất lượng cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '19ecee2e-30f0-45e8-a803-e0764526c919'
);

-- [祖先] (zǔxiān): tổ tiên
UPDATE public.vocabularies
SET example_hanzi = '考古学家在这片距今五千余年的良渚史前古城遗址中，发掘出土了大量精美绝伦的祭祀玉器，生动再现了华夏祖先巧夺天工的卓越高超智慧与精神崇拜。',
    example_pinyin = 'Kǎogǔxuéjiā zài zhè piàn jùjīn wǔqiān yú nián de Liángzhǔ shǐqián gǔchéng yízhǐ zhōng, fājué chūtǔ le dàliàng jīngměi-juélún de jìsì yùqì, shēngdòng zàixiàn le huáxià zǔxiān qiǎoduó-tiāngōng de zhuóyuè gāochāo zhìhuì yǔ jīngshén chóngbài.',
    example_vi = 'Các nhà khảo cổ học tại di chỉ thành cổ tiền sử Lương Chử cách ngày nay hơn 5.000 năm này đã khai quật phát lộ số lượng lớn ngọc khí tế tự tinh xảo tuyệt luân, tái hiện sinh động trí tuệ trác việt cao siêu khéo đoạt công trời và sự sùng bái tinh thần của tổ tiên Hoa Hạ.'
WHERE id = 'f14870a4-0deb-43d8-9dcc-aa44134ceb84' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f14870a4-0deb-43d8-9dcc-aa44134ceb84', '考古学家在这片距今五千余年的良渚史前古城遗址中，发掘出土了大量精美绝伦的祭祀玉器，生动再现了华夏祖先巧夺天工的卓越高超智慧与精神崇拜。', 'Kǎogǔxuéjiā zài zhè piàn jùjīn wǔqiān yú nián de Liángzhǔ shǐqián gǔchéng yízhǐ zhōng, fājué chūtǔ le dàliàng jīngměi-juélún de jìsì yùqì, shēngdòng zàixiàn le huáxià zǔxiān qiǎoduó-tiāngōng de zhuóyuè gāochāo zhìhuì yǔ jīngshén chóngbài.', 'Các nhà khảo cổ học tại di chỉ thành cổ tiền sử Lương Chử cách ngày nay hơn 5.000 năm này đã khai quật phát lộ số lượng lớn ngọc khí tế tự tinh xảo tuyệt luân, tái hiện sinh động trí tuệ trác việt cao siêu khéo đoạt công trời và sự sùng bái tinh thần của tổ tiên Hoa Hạ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f14870a4-0deb-43d8-9dcc-aa44134ceb84'
);

-- [足以] (zúyǐ): đủ để
UPDATE public.vocabularies
SET example_hanzi = '现代射电天文学家借助深空巨型射电望远镜收集到的海量脉冲星高精度观测数据，其精度与丰富度足以颠覆并重塑人类对宇宙早期演化规律的传统科学认知。',
    example_pinyin = 'Xiàndài shèdiàn tiānwénxuéjiā jièzhù shēnkōng jùxíng shèdiàn wàngyuǎnjìng shōují dào de hǎiliàng màichōngxīng gāo jīngdù guāncè shùjù, qí jīngdù yǔ fēngfùdù zúyǐ diānfù bìng chóngsù rénlèi duì yǔzhòu zǎoqī yǎnhuà guīlǜ de chuántǒng kēxué rènzhī.',
    example_vi = 'Các nhà thiên văn vô tuyến hiện đại nhờ vào khối lượng dữ liệu quan trắc sao xung độ chính xác cao khổng lồ thu thập được từ kính viễn vọng vô tuyến khổng lồ không gian sâu, độ chuẩn xác và tính phong phú của nó đủ để lật đổ và tái định hình nhận thức khoa học truyền thống của loài người về quy luật tiến hóa sơ khai của vũ trụ.'
WHERE id = 'f2800dad-8651-475c-bf85-19c4413b64cc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f2800dad-8651-475c-bf85-19c4413b64cc', '现代射电天文学家借助深空巨型射电望远镜收集到的海量脉冲星高精度观测数据，其精度与丰富度足以颠覆并重塑人类对宇宙早期演化规律的传统科学认知。', 'Xiàndài shèdiàn tiānwénxuéjiā jièzhù shēnkōng jùxíng shèdiàn wàngyuǎnjìng shōují dào de hǎiliàng màichōngxīng gāo jīngdù guāncè shùjù, qí jīngdù yǔ fēngfùdù zúyǐ diānfù bìng chóngsù rénlèi duì yǔzhòu zǎoqī yǎnhuà guīlǜ de chuántǒng kēxué rènzhī.', 'Các nhà thiên văn vô tuyến hiện đại nhờ vào khối lượng dữ liệu quan trắc sao xung độ chính xác cao khổng lồ thu thập được từ kính viễn vọng vô tuyến khổng lồ không gian sâu, độ chuẩn xác và tính phong phú của nó đủ để lật đổ và tái định hình nhận thức khoa học truyền thống của loài người về quy luật tiến hóa sơ khai của vũ trụ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f2800dad-8651-475c-bf85-19c4413b64cc'
);

COMMIT;
