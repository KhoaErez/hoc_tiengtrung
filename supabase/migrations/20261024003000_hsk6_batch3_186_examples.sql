-- ==============================================================================;
-- MIGRATION: 20261024003000_hsk6_batch3_186_examples.sql;
-- Nạp 186 câu ví dụ HSK 6 Đợt 3 (J - Q: 进展 -> 缺陷) vào vocabularies và vocabulary_examples;
-- Chuẩn đề cương HSK 3.0 (CTI 11/2025), câu ví dụ văn cảnh hiện đại, Pinyin có dấu, dịch chuẩn nghĩa;
-- ==============================================================================;

BEGIN;

-- [进展] (jìnzhǎn): tiến triển
UPDATE public.vocabularies
SET example_hanzi = '经过多轮深入技术攻关，我国可控核聚变前沿实验研究取得了突破性重大进展。',
    example_pinyin = 'Jīngguò duō lún shēnrù jìshù gōngguān, wǒ guó kěkòng héjùbiàn qiányán shíyàn yánjiū qǔdé le tūpòxìng zhòngdà jìnzhǎn.',
    example_vi = 'Trải qua nhiều vòng nghiên cứu kỹ thuật chuyên sâu, nghiên cứu thí nghiệm tiền phong phản ứng nhiệt hạch có kiểm soát của nước ta đã đạt được tiến triển đột phá trọng đại.'
WHERE id = 'b56f4b9c-4205-4a49-8567-03365f9dd99e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b56f4b9c-4205-4a49-8567-03365f9dd99e', '经过多轮深入技术攻关，我国可控核聚变前沿实验研究取得了突破性重大进展。', 'Jīngguò duō lún shēnrù jìshù gōngguān, wǒ guó kěkòng héjùbiàn qiányán shíyàn yánjiū qǔdé le tūpòxìng zhòngdà jìnzhǎn.', 'Trải qua nhiều vòng nghiên cứu kỹ thuật chuyên sâu, nghiên cứu thí nghiệm tiền phong phản ứng nhiệt hạch có kiểm soát của nước ta đã đạt được tiến triển đột phá trọng đại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b56f4b9c-4205-4a49-8567-03365f9dd99e'
);

-- [技巧] (jìqiǎo): kỹ xảo, kỹ năng
UPDATE public.vocabularies
SET example_hanzi = '这位资深演说家在讲台上游刃有余，熟练运用各种语言修辞与肢体表达技巧感染全场。',
    example_pinyin = 'Zhè wèi zīshēn yǎnshuōjiā zài jiǎngtái shang yóurèn-yǒuyú, shúliàn yùnyòng gè zhǒng yǔyán xiūcí yǔ zhītǐ biǎodá jìqiǎo gǎnrǎn quánchǎng.',
    example_vi = 'Nhà diễn thuyết kỳ cựu này trên bục giảng ung dung tự tại, vận dụng điêu luyện các kỹ năng tu từ ngôn ngữ và ngôn ngữ cơ thể truyền cảm lay động cả khán phòng.'
WHERE id = '70550535-6115-4df0-bd10-43c85040cf49' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '70550535-6115-4df0-bd10-43c85040cf49', '这位资深演说家在讲台上游刃有余，熟练运用各种语言修辞与肢体表达技巧感染全场。', 'Zhè wèi zīshēn yǎnshuōjiā zài jiǎngtái shang yóurèn-yǒuyú, shúliàn yùnyòng gè zhǒng yǔyán xiūcí yǔ zhītǐ biǎodá jìqiǎo gǎnrǎn quánchǎng.', 'Nhà diễn thuyết kỳ cựu này trên bục giảng ung dung tự tại, vận dụng điêu luyện các kỹ năng tu từ ngôn ngữ và ngôn ngữ cơ thể truyền cảm lay động cả khán phòng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '70550535-6115-4df0-bd10-43c85040cf49'
);

-- [激情] (jīqíng): nhiệt huyết, say mê, cảm xúc mãnh liệt
UPDATE public.vocabularies
SET example_hanzi = '年轻的创业团队满怀干事创业的炽热激情，全身心投入到人工智能前沿算法的自主开发中。',
    example_pinyin = 'Niánqīng de chuàngyè tuánduì mǎnhuái gànshì-chuàngyè de chìrè jīqíng, quánshēnxīn tóurù dào réngōng zhìnéng qiányán suànfǎ de zìzhǔ kāifā zhōng.',
    example_vi = 'Đội ngũ khởi nghiệp trẻ tuổi tràn đầy nhiệt huyết lập nghiệp nồng cháy, dốc toàn tâm toàn ý vào việc tự chủ phát triển các thuật toán tiên phong của trí tuệ nhân tạo.'
WHERE id = '369711d9-c8e8-40d6-bdb8-ead7eca36d2f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '369711d9-c8e8-40d6-bdb8-ead7eca36d2f', '年轻的创业团队满怀干事创业的炽热激情，全身心投入到人工智能前沿算法的自主开发中。', 'Niánqīng de chuàngyè tuánduì mǎnhuái gànshì-chuàngyè de chìrè jīqíng, quánshēnxīn tóurù dào réngōng zhìnéng qiányán suànfǎ de zìzhǔ kāifā zhōng.', 'Đội ngũ khởi nghiệp trẻ tuổi tràn đầy nhiệt huyết lập nghiệp nồng cháy, dốc toàn tâm toàn ý vào việc tự chủ phát triển các thuật toán tiên phong của trí tuệ nhân tạo.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '369711d9-c8e8-40d6-bdb8-ead7eca36d2f'
);

-- [集团] (jítuán): tập đoàn
UPDATE public.vocabularies
SET example_hanzi = '这家大型跨国制造集团在海外设立了数十个研发中心，产品远销全球上一百多个国家。',
    example_pinyin = 'Zhè jiā dàxíng kuàguó zhìzào jítuán zài hǎiwài shèlì le shùshí gè yánfā zhōngxīn, chǎnpǐn yuǎnxiāo quánqiú shàng yībǎi duō gè guójiā.',
    example_vi = 'Tập đoàn sản xuất xuyên quốc gia cỡ lớn này đã thành lập hàng chục trung tâm R&D ở nước ngoài, sản phẩm bán tới hơn 100 quốc gia trên toàn cầu.'
WHERE id = 'faed074e-adbe-485a-b38f-66dd6c647daf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'faed074e-adbe-485a-b38f-66dd6c647daf', '这家大型跨国制造集团在海外设立了数十个研发中心，产品远销全球上一百多个国家。', 'Zhè jiā dàxíng kuàguó zhìzào jítuán zài hǎiwài shèlì le shùshí gè yánfā zhōngxīn, chǎnpǐn yuǎnxiāo quánqiú shàng yībǎi duō gè guójiā.', 'Tập đoàn sản xuất xuyên quốc gia cỡ lớn này đã thành lập hàng chục trung tâm R&D ở nước ngoài, sản phẩm bán tới hơn 100 quốc gia trên toàn cầu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'faed074e-adbe-485a-b38f-66dd6c647daf'
);

-- [纠纷] (jiūfēn): tranh chấp, xích mích
UPDATE public.vocabularies
SET example_hanzi = '社区人民调解委员会耐心梳理矛盾根源，成功化解了一起因邻里房屋漏水引发的民事纠纷。',
    example_pinyin = 'Shèqū rénmín tiáojiě wěiyuánhuì nàixīn shūlǐ máodùn gēnyuán, chénggōng huàjiě le yì qǐ yīn línlǐ fángwū lòushuǐ yǐnfā de mínshì jiūfēn.',
    example_vi = 'Ban hòa giải nhân dân khu dân cư kiên nhẫn tháo gỡ căn nguyên mâu thuẫn, hóa giải thành công một vụ tranh chấp dân sự do nhà hàng xóm bị dột nước gây ra.'
WHERE id = '5ca48ce5-8ebc-47a5-b04e-31271174675c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5ca48ce5-8ebc-47a5-b04e-31271174675c', '社区人民调解委员会耐心梳理矛盾根源，成功化解了一起因邻里房屋漏水引发的民事纠纷。', 'Shèqū rénmín tiáojiě wěiyuánhuì nàixīn shūlǐ máodùn gēnyuán, chénggōng huàjiě le yì qǐ yīn línlǐ fángwū lòushuǐ yǐnfā de mínshì jiūfēn.', 'Ban hòa giải nhân dân khu dân cư kiên nhẫn tháo gỡ căn nguyên mâu thuẫn, hóa giải thành công một vụ tranh chấp dân sự do nhà hàng xóm bị dột nước gây ra.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5ca48ce5-8ebc-47a5-b04e-31271174675c'
);

-- [酒精] (jiǔjīng): cồn, rượu
UPDATE public.vocabularies
SET example_hanzi = '医院护士在为患者进行静脉穿刺采血之前，会用医用酒精棉球对局部皮肤进行细致消毒。',
    example_pinyin = 'Yīyuàn hùshi zài wèi huànzhě jìnxíng jìngmài chuāncì cǎixuè zhīqián, huì yòng yīyòng jiǔjīng miánqiú duì júbù pífū jìnxíng xìzhì xiāodú.',
    example_vi = 'Y tá bệnh viện trước khi chọc kim tĩnh mạch lấy máu cho bệnh nhân sẽ dùng bông cồn y tế khử khuẩn cẩn thận vùng da.'
WHERE id = '864c76a2-3605-4417-b498-8f4d45328755' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '864c76a2-3605-4417-b498-8f4d45328755', '医院护士在为患者进行静脉穿刺采血之前，会用医用酒精棉球对局部皮肤进行细致消毒。', 'Yīyuàn hùshi zài wèi huànzhě jìnxíng jìngmài chuāncì cǎixuè zhīqián, huì yòng yīyòng jiǔjīng miánqiú duì júbù pífū jìnxíng xìzhì xiāodú.', 'Y tá bệnh viện trước khi chọc kim tĩnh mạch lấy máu cho bệnh nhân sẽ dùng bông cồn y tế khử khuẩn cẩn thận vùng da.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '864c76a2-3605-4417-b498-8f4d45328755'
);

-- [舅舅] (jiùjiu): cậu (anh em mẹ)
UPDATE public.vocabularies
SET example_hanzi = '每年春节长假回老家探亲时，我和妈妈都会带上精选的新鲜年货专程前往舅舅家拜年。',
    example_pinyin = 'Měi nián chūnjié chángjià huí lǎojiā tànqīn shí, wǒ hé māma dōu huì dài shang jīngxuǎn de xīnxiān niánhuò zhuānchéng qiánwǎng jiùjiu jiā bàinián.',
    example_vi = 'Mỗi dịp nghỉ Tết về quê thăm người thân, tôi và mẹ đều mang theo những món quà Tết tươi ngon được chọn lọc đặc biệt đến nhà cậu chúc Tết.'
WHERE id = 'a9fc9adb-9898-49b8-b05f-cbd3d40f2f0b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a9fc9adb-9898-49b8-b05f-cbd3d40f2f0b', '每年春节长假回老家探亲时，我和妈妈都会带上精选的新鲜年货专程前往舅舅家拜年。', 'Měi nián chūnjié chángjià huí lǎojiā tànqīn shí, wǒ hé māma dōu huì dài shang jīngxuǎn de xīnxiān niánhuò zhuānchéng qiánwǎng jiùjiu jiā bàinián.', 'Mỗi dịp nghỉ Tết về quê thăm người thân, tôi và mẹ đều mang theo những món quà Tết tươi ngon được chọn lọc đặc biệt đến nhà cậu chúc Tết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a9fc9adb-9898-49b8-b05f-cbd3d40f2f0b'
);

-- [纠正] (jiūzhèng): sửa chữa, uốn nắn
UPDATE public.vocabularies
SET example_hanzi = '汉语发音辅导老师在早读课上逐字逐句倾听，耐心地帮助外国留学生纠正声调发音偏差。',
    example_pinyin = 'Hànyǔ fāyīn fǔdǎo lǎoshī zài zǎodú kè shang zhúzì-zhújù qīngtīng, nàixīn de bāngzhù wàiguó liúxuéshēng jiūzhèng shēngdiào fāyīn piānchā.',
    example_vi = 'Giáo viên phụ đạo phát âm tiếng Hán trong giờ đọc buổi sáng lắng nghe từng câu từng chữ, kiên nhẫn giúp lưu học sinh uốn nắn sửa chữa những lệch lạc về thanh điệu.'
WHERE id = '3159278d-dbbc-4d1b-9e7d-e33b0fcec373' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3159278d-dbbc-4d1b-9e7d-e33b0fcec373', '汉语发音辅导老师在早读课上逐字逐句倾听，耐心地帮助外国留学生纠正声调发音偏差。', 'Hànyǔ fāyīn fǔdǎo lǎoshī zài zǎodú kè shang zhúzì-zhújù qīngtīng, nàixīn de bāngzhù wàiguó liúxuéshēng jiūzhèng shēngdiào fāyīn piānchā.', 'Giáo viên phụ đạo phát âm tiếng Hán trong giờ đọc buổi sáng lắng nghe từng câu từng chữ, kiên nhẫn giúp lưu học sinh uốn nắn sửa chữa những lệch lạc về thanh điệu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3159278d-dbbc-4d1b-9e7d-e33b0fcec373'
);

-- [吉祥] (jíxiáng): cát tường, may mắn
UPDATE public.vocabularies
SET example_hanzi = '红彤彤的中国结和喜庆的窗花寓意着吉祥如意，寄托了人民对风调雨顺与美好生活的向往。',
    example_pinyin = 'Hóngtōngtōng de Zhōngguójié hé xǐqìng de chuānghuā yùyì zhe jíxiáng-rúyì, jìtuō le rénmín duì fēngtiáo-yǔshùn yǔ měihǎo shēnghuó de xiàngwǎng.',
    example_vi = 'Những chiếc nút thắt Trung Hoa đỏ thắm và hoa giấy dán cửa sổ tưng bừng ngụ ý cát tường như ý, gửi gắm ước vọng của nhân dân về mưa thuận gió hòa và cuộc sống ấm no.'
WHERE id = '80fde773-3d8b-423c-b92d-f371f0f338c0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '80fde773-3d8b-423c-b92d-f371f0f338c0', '红彤彤的中国结和喜庆的窗花寓意着吉祥如意，寄托了人民对风调雨顺与美好生活的向往。', 'Hóngtōngtōng de Zhōngguójié hé xǐqìng de chuānghuā yùyì zhe jíxiáng-rúyì, jìtuō le rénmín duì fēngtiáo-yǔshùn yǔ měihǎo shēnghuó de xiàngwǎng.', 'Những chiếc nút thắt Trung Hoa đỏ thắm và hoa giấy dán cửa sổ tưng bừng ngụ ý cát tường như ý, gửi gắm ước vọng của nhân dân về mưa thuận gió hòa và cuộc sống ấm no.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '80fde773-3d8b-423c-b92d-f371f0f338c0'
);

-- [机械] (jīxiè): máy móc, rập khuôn
UPDATE public.vocabularies
SET example_hanzi = '语言学习注重在真实情境中灵活运用与交流，绝不能仅仅停留在死记硬背单词的机械重复上。',
    example_pinyin = 'Yǔyán xuéxí zhùzhòng zài zhēnshí qíngjìng zhōng línghuó yùnyòng yǔ jiāoliú, jué bùnéng jǐnjǐn tíngliú zài sǐjì-yìngbèi dāncí de jīxiè chóngfù shang.',
    example_vi = 'Học ngôn ngữ chú trọng việc vận dụng và giao lưu linh hoạt trong tình huống thực tế, tuyệt đối không thể chỉ dừng lại ở việc lặp đi lặp lại một cách máy móc rập khuôn các từ vựng học vẹt.'
WHERE id = '12179d3c-fa28-49f9-99e7-1d2152d35a28' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '12179d3c-fa28-49f9-99e7-1d2152d35a28', '语言学习注重在真实情境中灵活运用与交流，绝不能仅仅停留在死记硬背单词的机械重复上。', 'Yǔyán xuéxí zhùzhòng zài zhēnshí qíngjìng zhōng línghuó yùnyòng yǔ jiāoliú, jué bùnéng jǐnjǐn tíngliú zài sǐjì-yìngbèi dāncí de jīxiè chóngfù shang.', 'Học ngôn ngữ chú trọng việc vận dụng và giao lưu linh hoạt trong tình huống thực tế, tuyệt đối không thể chỉ dừng lại ở việc lặp đi lặp lại một cách máy móc rập khuôn các từ vựng học vẹt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '12179d3c-fa28-49f9-99e7-1d2152d35a28'
);

-- [基因] (jīyīn): gen
UPDATE public.vocabularies
SET example_hanzi = '科学家通过高通量人类全基因组测序技术，深入探索了多种复杂罕见遗传性疾病的致病机制。',
    example_pinyin = 'Kēxuéjiā tōngguò gāotōngliàng rénlèi quán jīyīn zǔ cèxù jìshù, shēnrù tànsuǒ le duō zhǒng fùzá hǎnjiàn yíchuánxìng jíbìng de zhìbìng jīzhì.',
    example_vi = 'Các nhà khoa học thông qua công nghệ giải trình tự toàn bộ hệ gen người năng suất cao đã khám phá sâu sắc cơ chế gây bệnh của nhiều căn bệnh di truyền hiếm gặp phức tạp.'
WHERE id = 'be5d519c-7bcd-431d-b87d-85b4c8a781e9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'be5d519c-7bcd-431d-b87d-85b4c8a781e9', '科学家通过高通量人类全基因组测序技术，深入探索了多种复杂罕见遗传性疾病的致病机制。', 'Kēxuéjiā tōngguò gāotōngliàng rénlèi quán jīyīn zǔ cèxù jìshù, shēnrù tànsuǒ le duō zhǒng fùzá hǎnjiàn yíchuánxìng jíbìng de zhìbìng jīzhì.', 'Các nhà khoa học thông qua công nghệ giải trình tự toàn bộ hệ gen người năng suất cao đã khám phá sâu sắc cơ chế gây bệnh của nhiều căn bệnh di truyền hiếm gặp phức tạp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'be5d519c-7bcd-431d-b87d-85b4c8a781e9'
);

-- [给予] (jǐyǔ): cho, dành cho
UPDATE public.vocabularies
SET example_hanzi = '青年一代在面对挫折与迷茫时，社会各界与家庭应当给予他们更多的理解、宽容与真诚关爱。',
    example_pinyin = 'Qīngnián yídài zài miànduì cuòzhé yǔ mímáng shí, shèhuì gèjiè yǔ jiātíng yīngdāng jǐyǔ tāmen gèng duō de lǐjiě, kuānróng yǔ zhēnchéng guān''ài.',
    example_vi = 'Khi thế hệ trẻ đối mặt với trắc trở và hoang mang lạc lối, các giới xã hội và gia đình nên dành cho họ nhiều sự thấu hiểu, bao dung và quan tâm chân thành hơn.'
WHERE id = 'c4aa12b9-f7c4-4039-a186-2e72f3e881e6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c4aa12b9-f7c4-4039-a186-2e72f3e881e6', '青年一代在面对挫折与迷茫时，社会各界与家庭应当给予他们更多的理解、宽容与真诚关爱。', 'Qīngnián yídài zài miànduì cuòzhé yǔ mímáng shí, shèhuì gèjiè yǔ jiātíng yīngdāng jǐyǔ tāmen gèng duō de lǐjiě, kuānróng yǔ zhēnchéng guān''ài.', 'Khi thế hệ trẻ đối mặt với trắc trở và hoang mang lạc lối, các giới xã hội và gia đình nên dành cho họ nhiều sự thấu hiểu, bao dung và quan tâm chân thành hơn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c4aa12b9-f7c4-4039-a186-2e72f3e881e6'
);

-- [机遇] (jīyù): cơ hội, dịp may
UPDATE public.vocabularies
SET example_hanzi = '新一轮数字经济与人工智能浪潮的汹涌到来，为青年科技人才提供了前所未有的时代发展机遇。',
    example_pinyin = 'Xīn yì lún shùzì jīngjì yǔ réngōng zhìnéng làngcháo de xiōngyǒng dàolái, wèi qīngnián kējì réncái tígōng le qiánsuǒwèiyǒu de shídài fāzhǎn jīyù.',
    example_vi = 'Làn sóng kinh tế số và trí tuệ nhân tạo mới cuồn cuộn ập đến đã đem lại cơ hội thời vận phát triển chưa từng có cho những nhân tài khoa học công nghệ trẻ tuổi.'
WHERE id = '67094cfc-c453-4816-a8a5-96ac60883511' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '67094cfc-c453-4816-a8a5-96ac60883511', '新一轮数字经济与人工智能浪潮的汹涌到来，为青年科技人才提供了前所未有的时代发展机遇。', 'Xīn yì lún shùzì jīngjì yǔ réngōng zhìnéng làngcháo de xiōngyǒng dàolái, wèi qīngnián kējì réncái tígōng le qiánsuǒwèiyǒu de shídài fāzhǎn jīyù.', 'Làn sóng kinh tế số và trí tuệ nhân tạo mới cuồn cuộn ập đến đã đem lại cơ hội thời vận phát triển chưa từng có cho những nhân tài khoa học công nghệ trẻ tuổi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '67094cfc-c453-4816-a8a5-96ac60883511'
);

-- [举动] (jǔ dòng): hành động, cử chỉ
UPDATE public.vocabularies
SET example_hanzi = '在危急关头那位年轻小伙子跳入冰冷刺骨的河水中奋勇救起落水儿童的英勇举动，感动了无数市民。',
    example_pinyin = 'Zài wēijí guāntóu nà wèi niánqīng xiǎohuǒzi tiàorù bīnglěng cìgǔ de héshuǐ zhōng fènyǒng jiù qǐ luòshuǐ értóng de yīngyǒng jǔdòng, gǎndòng le wúshù shìmín.',
    example_vi = 'Hành động dũng cảm nhảy vào dòng nước sông buốt giá cứu sống đứa trẻ rơi xuống nước giữa lúc nguy kịch của chàng trai trẻ đã làm rung động hàng triệu người dân.'
WHERE id = '96a535fc-d0e4-430e-a123-42aabcdf082d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '96a535fc-d0e4-430e-a123-42aabcdf082d', '在危急关头那位年轻小伙子跳入冰冷刺骨的河水中奋勇救起落水儿童的英勇举动，感动了无数市民。', 'Zài wēijí guāntóu nà wèi niánqīng xiǎohuǒzi tiàorù bīnglěng cìgǔ de héshuǐ zhōng fènyǒng jiù qǐ luòshuǐ értóng de yīngyǒng jǔdòng, gǎndòng le wúshù shìmín.', 'Hành động dũng cảm nhảy vào dòng nước sông buốt giá cứu sống đứa trẻ rơi xuống nước giữa lúc nguy kịch của chàng trai trẻ đã làm rung động hàng triệu người dân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '96a535fc-d0e4-430e-a123-42aabcdf082d'
);

-- [局面] (jú miàn): cục diện, tình hình
UPDATE public.vocabularies
SET example_hanzi = '经过各级政府与全体科研攻关团队的协同奋战，该项核心芯片关键技术长期受制于人的被动局面终于被彻底打破。',
    example_pinyin = 'Jīngguò gè jí zhèngfǔ yǔ quántǐ kēyán gōngguān tuánduì de xiétóng fènzhàn, gāi xiàng héxīn xīnpiàn guānjiàn jìshù chángqī shòuzhìyú rén de bèidòng júmiàn zhōngyú bèi chèdǐ dǎpò.',
    example_vi = 'Trải qua sự chiến đấu hiệp đồng của các cấp chính quyền và toàn thể đội ngũ nghiên cứu mũi nhọn, cục diện bị động lâu nay của công nghệ chip then chốt bị lệ thuộc nước ngoài rốt cuộc đã bị phá vỡ hoàn toàn.'
WHERE id = 'd8d06555-0452-4fca-a288-1f6c6059b598' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd8d06555-0452-4fca-a288-1f6c6059b598', '经过各级政府与全体科研攻关团队的协同奋战，该项核心芯片关键技术长期受制于人的被动局面终于被彻底打破。', 'Jīngguò gè jí zhèngfǔ yǔ quántǐ kēyán gōngguān tuánduì de xiétóng fènzhàn, gāi xiàng héxīn xīnpiàn guānjiàn jìshù chángqī shòuzhìyú rén de bèidòng júmiàn zhōngyú bèi chèdǐ dǎpò.', 'Trải qua sự chiến đấu hiệp đồng của các cấp chính quyền và toàn thể đội ngũ nghiên cứu mũi nhọn, cục diện bị động lâu nay của công nghệ chip then chốt bị lệ thuộc nước ngoài rốt cuộc đã bị phá vỡ hoàn toàn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd8d06555-0452-4fca-a288-1f6c6059b598'
);

-- [局限] (jú xiàn): giới hạn, hạn chế
UPDATE public.vocabularies
SET example_hanzi = '做学问必须拥有开阔包容的宏观学术视野，绝不能仅仅局限于狭窄的单一专业领域之内。',
    example_pinyin = 'Zuò xuéwèn bìxū yōngyǒu kāikuò bāoróng de hóngguān xuéshù shìyě, jué bùnéng jǐnjǐn júxiàn yú xiázhǎi de dānyī zhuānyè lǐngyù zhī nèi.',
    example_vi = 'Làm học vấn phải sở hữu tầm nhìn học thuật vĩ mô rộng mở bao dung, tuyệt đối không thể chỉ giới hạn hạn chế trong phạm vi một chuyên ngành đơn lẻ chật hẹp.'
WHERE id = '43d1f916-3d52-416e-bdf7-ce25debecb71' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '43d1f916-3d52-416e-bdf7-ce25debecb71', '做学问必须拥有开阔包容的宏观学术视野，绝不能仅仅局限于狭窄的单一专业领域之内。', 'Zuò xuéwèn bìxū yōngyǒu kāikuò bāoróng de hóngguān xuéshù shìyě, jué bùnéng jǐnjǐn júxiàn yú xiázhǎi de dānyī zhuānyè lǐngyù zhī nèi.', 'Làm học vấn phải sở hữu tầm nhìn học thuật vĩ mô rộng mở bao dung, tuyệt đối không thể chỉ giới hạn hạn chế trong phạm vi một chuyên ngành đơn lẻ chật hẹp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '43d1f916-3d52-416e-bdf7-ce25debecb71'
);

-- [卷] (juǎn): cuộn, cuốn
UPDATE public.vocabularies
SET example_hanzi = '建筑设计师在工程项目评审例会上，缓缓展开了一卷长达五米的跨海特大桥总体布局规划图纸。',
    example_pinyin = 'Jiànzhù shèjìshī zài gōngchéng xiàngmù píngshěn lìhuì shang, huǎnhuǎn zhǎnkāi le yì juǎn cháng dá wǔ mǐ de kuàhǎi tèdàqiáo zǒngtǐ bùjú guīhuà túzhǐ.',
    example_vi = 'Kiến trúc sư trong cuộc họp thẩm định dự án công trình đã từ từ mở ra một cuộn bản vẽ quy hoạch bố cục tổng thể cầu vượt biển dài tới 5 mét.'
WHERE id = '0a2b0027-8224-4c7b-bf42-ca0ac2b6c8c6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0a2b0027-8224-4c7b-bf42-ca0ac2b6c8c6', '建筑设计师在工程项目评审例会上，缓缓展开了一卷长达五米的跨海特大桥总体布局规划图纸。', 'Jiànzhù shèjìshī zài gōngchéng xiàngmù píngshěn lìhuì shang, huǎnhuǎn zhǎnkāi le yì juǎn cháng dá wǔ mǐ de kuàhǎi tèdàqiáo zǒngtǐ bùjú guīhuà túzhǐ.', 'Kiến trúc sư trong cuộc họp thẩm định dự án công trình đã từ từ mở ra một cuộn bản vẽ quy hoạch bố cục tổng thể cầu vượt biển dài tới 5 mét.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0a2b0027-8224-4c7b-bf42-ca0ac2b6c8c6'
);

-- [剧本] (jùběn): kịch bản
UPDATE public.vocabularies
SET example_hanzi = '著名编剧历时整整三年、深入基层走访数百位抗战老兵，精心打磨完成了这部史诗级优秀电影剧本。',
    example_pinyin = 'Zhùmíng biānjù lìshí zhěngzhěng sān nián, shēnrù jīcéng zǒufǎng shùbǎi wèi kàngzhàn lǎobīng, jīngxīn dǎmó wánchéng le zhè bù shǐshījí yōuxiù diànyǐng jùběn.',
    example_vi = 'Biên kịch lừng danh mất trọn ba năm tiến sâu vào cơ sở phỏng vấn hàng trăm cựu chiến binh, dày công trau chuốt hoàn thành kịch bản điện ảnh xuất sắc tầm cỡ sử thi này.'
WHERE id = '612832c4-c648-4d35-ad93-13c8a5efa021' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '612832c4-c648-4d35-ad93-13c8a5efa021', '著名编剧历时整整三年、深入基层走访数百位抗战老兵，精心打磨完成了这部史诗级优秀电影剧本。', 'Zhùmíng biānjù lìshí zhěngzhěng sān nián, shēnrù jīcéng zǒufǎng shùbǎi wèi kàngzhàn lǎobīng, jīngxīn dǎmó wánchéng le zhè bù shǐshījí yōuxiù diànyǐng jùběn.', 'Biên kịch lừng danh mất trọn ba năm tiến sâu vào cơ sở phỏng vấn hàng trăm cựu chiến binh, dày công trau chuốt hoàn thành kịch bản điện ảnh xuất sắc tầm cỡ sử thi này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '612832c4-c648-4d35-ad93-13c8a5efa021'
);

-- [绝望] (jué wàng): tuyệt vọng
UPDATE public.vocabularies
SET example_hanzi = '面对地震突袭被废墟围困的危急险境，救援队员永不放弃的搜救呼喊点亮了被困者心中绝望里的希望之光。',
    example_pinyin = 'Miànduì dìzhèn tūxí bèi fèixū wéikùn de wēijí xiǎnjìng, jiùyuán duìyuán yǒng bù fàngqì de sōujiù hūhǎn diǎnliàng le bèikùnzhě xīn zhōng juéwàng lǐ de xīwàng zhī guāng.',
    example_vi = 'Trước tình cảnh hiểm nghèo bị mắc kẹt dưới đống đổ nát sau trận động đất bất ngờ, tiếng hô tìm kiếm không bao giờ bỏ cuộc của người cứu hộ đã thắp sáng ánh sáng hy vọng trong tột cùng tuyệt vọng của người gặp nạn.'
WHERE id = '521b901d-0ff9-4bb1-80ac-4ffc1ab6aace' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '521b901d-0ff9-4bb1-80ac-4ffc1ab6aace', '面对地震突袭被废墟围困的危急险境，救援队员永不放弃的搜救呼喊点亮了被困者心中绝望里的希望之光。', 'Miànduì dìzhèn tūxí bèi fèixū wéikùn de wēijí xiǎnjìng, jiùyuán duìyuán yǒng bù fàngqì de sōujiù hūhǎn diǎnliàng le bèikùnzhě xīn zhōng juéwàng lǐ de xīwàng zhī guāng.', 'Trước tình cảnh hiểm nghèo bị mắc kẹt dưới đống đổ nát sau trận động đất bất ngờ, tiếng hô tìm kiếm không bao giờ bỏ cuộc của người cứu hộ đã thắp sáng ánh sáng hy vọng trong tột cùng tuyệt vọng của người gặp nạn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '521b901d-0ff9-4bb1-80ac-4ffc1ab6aace'
);

-- [决策] (juécè): quyết sách, đưa ra quyết định
UPDATE public.vocabularies
SET example_hanzi = '在制定涉及千万民众民生福祉的重大公共政策之前，各级政府部门必须坚持科学决策、民主决策。',
    example_pinyin = 'Zài zhìdìng shèjí qiānwàn mínzhòng mínshēng fúzhǐ de zhòngdà gōnggòng zhèngcè zhīqián, gè jí zhèngfǔ bùmén bìxū jiānchí kēxué juécè, mínzhǔ juécè.',
    example_vi = 'Trước khi ban hành các chính sách công cộng trọng đại liên quan tới phúc lợi dân sinh của hàng vạn người dân, các cơ quan chính phủ phải kiên định ra quyết sách một cách khoa học và dân chủ.'
WHERE id = '8896c5e1-af0b-4809-9d23-29d5f0b195a3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8896c5e1-af0b-4809-9d23-29d5f0b195a3', '在制定涉及千万民众民生福祉的重大公共政策之前，各级政府部门必须坚持科学决策、民主决策。', 'Zài zhìdìng shèjí qiānwàn mínzhòng mínshēng fúzhǐ de zhòngdà gōnggòng zhèngcè zhīqián, gè jí zhèngfǔ bùmén bìxū jiānchí kēxué juécè, mínzhǔ juécè.', 'Trước khi ban hành các chính sách công cộng trọng đại liên quan tới phúc lợi dân sinh của hàng vạn người dân, các cơ quan chính phủ phải kiên định ra quyết sách một cách khoa học và dân chủ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8896c5e1-af0b-4809-9d23-29d5f0b195a3'
);

-- [俱乐部] (jùlèbù): câu lạc bộ
UPDATE public.vocabularies
SET example_hanzi = '大学校园里活跃着上百个特色学生兴趣俱乐部，为广大学子提供了施展文艺体育才能的广阔舞台。',
    example_pinyin = 'Dàxué xiàoyuán lǐ huóyuè zhe shàngbǎi gè tèsè xuésheng xìngqù jùlèbù, wèi guǎngdà xuézǐ tígōng le shīzhǎn wényì tǐyù cáinéng de guǎngkuò wǔtái.',
    example_vi = 'Trong khuôn viên trường đại học có hàng trăm câu lạc bộ sở thích sinh viên đặc sắc hoạt động sôi nổi, tạo nên sân khấu rộng lớn cho các bạn học sinh thi thố tài năng văn nghệ thể thao.'
WHERE id = 'd41368b0-b9ab-4b7b-a2d5-6e6f0b7e567e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd41368b0-b9ab-4b7b-a2d5-6e6f0b7e567e', '大学校园里活跃着上百个特色学生兴趣俱乐部，为广大学子提供了施展文艺体育才能的广阔舞台。', 'Dàxué xiàoyuán lǐ huóyuè zhe shàngbǎi gè tèsè xuésheng xìngqù jùlèbù, wèi guǎngdà xuézǐ tígōng le shīzhǎn wényì tǐyù cáinéng de guǎngkuò wǔtái.', 'Trong khuôn viên trường đại học có hàng trăm câu lạc bộ sở thích sinh viên đặc sắc hoạt động sôi nổi, tạo nên sân khấu rộng lớn cho các bạn học sinh thi thố tài năng văn nghệ thể thao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd41368b0-b9ab-4b7b-a2d5-6e6f0b7e567e'
);

-- [剧烈] (jùliè): kịch liệt, dữ dội
UPDATE public.vocabularies
SET example_hanzi = '医生特别嘱咐患有严重心脑血管慢性疾病的老年患者，在寒冷清晨外出晨练时严禁进行剧烈运动。',
    example_pinyin = 'Yīshēng tèbié zhǔfù huàn yǒu yánzhòng xīn-nǎoxiěguān mànxìng jíbìng de lǎonián huànzhě, zài hánlěng qīngchén wàichū chénliàn shí yánjìn jìnxíng jùliè yùndòng.',
    example_vi = 'Bác sĩ đặc biệt dặn dò những bệnh nhân cao tuổi mắc bệnh mãn tính tim mạch nghiêm trọng khi ra ngoài tập thể dục buổi sáng lạnh giá nghiêm cấm vận động kịch liệt dữ dội.'
WHERE id = '0c6de14d-329d-4344-88c4-b92fc98f2448' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0c6de14d-329d-4344-88c4-b92fc98f2448', '医生特别嘱咐患有严重心脑血管慢性疾病的老年患者，在寒冷清晨外出晨练时严禁进行剧烈运动。', 'Yīshēng tèbié zhǔfù huàn yǒu yánzhòng xīn-nǎoxiěguān mànxìng jíbìng de lǎonián huànzhě, zài hánlěng qīngchén wàichū chénliàn shí yánjìn jìnxíng jùliè yùndòng.', 'Bác sĩ đặc biệt dặn dò những bệnh nhân cao tuổi mắc bệnh mãn tính tim mạch nghiêm trọng khi ra ngoài tập thể dục buổi sáng lạnh giá nghiêm cấm vận động kịch liệt dữ dội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0c6de14d-329d-4344-88c4-b92fc98f2448'
);

-- [军队] (jūnduì): quân đội
UPDATE public.vocabularies
SET example_hanzi = '一支忠诚于国家与人民的现代化强大军队，是维护国家主权领土完整与保障世界长久和平的坚强柱石。',
    example_pinyin = 'Yì zhī zhōngchéng yú guójiā yǔ rénmín de xiàndàihuà qiángdà jūnduì, shì wéihù guójiā zhǔquán lǐngtǔ wánzhěng yǔ bǎozhàng shìjiè chángjiǔ hépíng de jiānqiáng zhùshí.',
    example_vi = 'Một đội quân hiện đại hóa hùng mạnh trung thành với tổ quốc và nhân dân là rường cột vững chắc bảo vệ toàn vẹn chủ quyền lãnh thổ quốc gia và bảo đảm hòa bình lâu dài của thế giới.'
WHERE id = 'd6f9e532-2685-441d-8a5f-0e347cfe6268' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd6f9e532-2685-441d-8a5f-0e347cfe6268', '一支忠诚于国家与人民的现代化强大军队，是维护国家主权领土完整与保障世界长久和平的坚强柱石。', 'Yì zhī zhōngchéng yú guójiā yǔ rénmín de xiàndàihuà qiángdà jūnduì, shì wéihù guójiā zhǔquán lǐngtǔ wánzhěng yǔ bǎozhàng shìjiè chángjiǔ hépíng de jiānqiáng zhùshí.', 'Một đội quân hiện đại hóa hùng mạnh trung thành với tổ quốc và nhân dân là rường cột vững chắc bảo vệ toàn vẹn chủ quyền lãnh thổ quốc gia và bảo đảm hòa bình lâu dài của thế giới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd6f9e532-2685-441d-8a5f-0e347cfe6268'
);

-- [均匀] (jūnyún): đều đặn, đồng đều
UPDATE public.vocabularies
SET example_hanzi = '烘焙师傅用木铲将香甜的发酵面团揉搓得柔软细腻，确保每一份手工面包都能均匀受热烘烤。',
    example_pinyin = 'Hōngbèi shīfu yòng mùchǎn jiāng xiāngtián de fājiào miàntuán róucuō de róuruǎn xìnì, quèbǎo měi yí fèn shǒugōng miànbāo dōu néng jūnyún shòurè hōngkǎo.',
    example_vi = 'Người thợ làm bánh dùng xẻng gỗ nhào nặn khối bột lên men thơm ngọt mềm mại mịn màng, bảo đảm mỗi chiếc bánh mì thủ công đều được nướng chín nóng đều đặn đồng đều.'
WHERE id = '1cba11db-1120-4930-81f8-fbf6e0e4704b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1cba11db-1120-4930-81f8-fbf6e0e4704b', '烘焙师傅用木铲将香甜的发酵面团揉搓得柔软细腻，确保每一份手工面包都能均匀受热烘烤。', 'Hōngbèi shīfu yòng mùchǎn jiāng xiāngtián de fājiào miàntuán róucuō de róuruǎn xìnì, quèbǎo měi yí fèn shǒugōng miànbāo dōu néng jūnyún shòurè hōngkǎo.', 'Người thợ làm bánh dùng xẻng gỗ nhào nặn khối bột lên men thơm ngọt mềm mại mịn màng, bảo đảm mỗi chiếc bánh mì thủ công đều được nướng chín nóng đều đặn đồng đều.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1cba11db-1120-4930-81f8-fbf6e0e4704b'
);

-- [砍] (kǎn): chặt, chém
UPDATE public.vocabularies
SET example_hanzi = '为了保护生态屏障与水土涵养功能，林业生态保护区严禁任何未经批准擅自砍伐原始林木的违法行为。',
    example_pinyin = 'Wèile bǎohù shēngtài píngzhàng yǔ shuǐtǔ hányǎng gōngnéng, línyè shēngtài bǎohùqū yánjìn rènhé wèijīng pīzhǔn shànzì kǎnfá yuánshǐ línmù de wéifǎ xíngwéi.',
    example_vi = 'Nhằm bảo vệ bức bình phong sinh thái và chức năng giữ nước giữ đất, khu bảo tồn sinh thái lâm nghiệp nghiêm cấm mọi hành vi chặt đốn cây gỗ rừng nguyên sinh trái phép chưa qua phê chuẩn.'
WHERE id = '94982e95-41f1-46aa-9914-f92039501b1f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '94982e95-41f1-46aa-9914-f92039501b1f', '为了保护生态屏障与水土涵养功能，林业生态保护区严禁任何未经批准擅自砍伐原始林木的违法行为。', 'Wèile bǎohù shēngtài píngzhàng yǔ shuǐtǔ hányǎng gōngnéng, línyè shēngtài bǎohùqū yánjìn rènhé wèijīng pīzhǔn shànzì kǎnfá yuánshǐ línmù de wéifǎ xíngwéi.', 'Nhằm bảo vệ bức bình phong sinh thái và chức năng giữ nước giữ đất, khu bảo tồn sinh thái lâm nghiệp nghiêm cấm mọi hành vi chặt đốn cây gỗ rừng nguyên sinh trái phép chưa qua phê chuẩn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '94982e95-41f1-46aa-9914-f92039501b1f'
);

-- [看不起] (kànbuqǐ): coi thường, khinh rẻ
UPDATE public.vocabularies
SET example_hanzi = '无论从事何种平凡普通的劳动岗位，只要勤劳守法都值得受到全社会尊重，绝不能看不起劳动者。',
    example_pinyin = 'Wúlùn cóngshì hé zhǒng píngfán pǔtōng de láodòng gǎngwèi, zhǐyào qínláo shǒufǎ dōu zhíde shòudào quán shèhuì zūnzhòng, jué bùnéng kànbuqǐ láodòngzhě.',
    example_vi = 'Dù làm việc ở bất kỳ vị trí lao động bình thường bình dị nào, chỉ cần cần cù tuân thủ pháp luật đều xứng đáng nhận được sự tôn trọng của xã hội, tuyệt đối không được coi thường khinh rẻ người lao động.'
WHERE id = 'e4dd98de-b8be-419d-8a98-8865275d429e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e4dd98de-b8be-419d-8a98-8865275d429e', '无论从事何种平凡普通的劳动岗位，只要勤劳守法都值得受到全社会尊重，绝不能看不起劳动者。', 'Wúlùn cóngshì hé zhǒng píngfán pǔtōng de láodòng gǎngwèi, zhǐyào qínláo shǒufǎ dōu zhíde shòudào quán shèhuì zūnzhòng, jué bùnéng kànbuqǐ láodòngzhě.', 'Dù làm việc ở bất kỳ vị trí lao động bình thường bình dị nào, chỉ cần cần cù tuân thủ pháp luật đều xứng đáng nhận được sự tôn trọng của xã hội, tuyệt đối không được coi thường khinh rẻ người lao động.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e4dd98de-b8be-419d-8a98-8865275d429e'
);

-- [看待] (kàndài): nhìn nhận, đối đãi
UPDATE public.vocabularies
SET example_hanzi = '青年学子在成长过程中难免会经历风雨坎坷，应当学会用辩证发展与包容豁达的宽广胸怀来看待暂时的挫折。',
    example_pinyin = 'Qīngnián xuézǐ zài chéngzhǎng guòchéng zhōng nánmiǎn huì jīnglì fēngyǔ kǎnkě, yīngdāng xuéhuì yòng biànzhèng fāzhǎn yǔ bāoróng huòdá de kuānguǎng xiōnghuái lái kàndài zànshí de cuòzhé.',
    example_vi = 'Các bạn trẻ trên đường đời trưởng thành khó tránh khỏi phong ba ghập ghềnh, nên học cách dùng tấm lòng rộng mở bao dung và phát triển biện chứng để nhìn nhận đối đãi với những thất bại tạm thời.'
WHERE id = '7133b9d8-7ca0-431c-b0fd-0fa6eff2535c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7133b9d8-7ca0-431c-b0fd-0fa6eff2535c', '青年学子在成长过程中难免会经历风雨坎坷，应当学会用辩证发展与包容豁达的宽广胸怀来看待暂时的挫折。', 'Qīngnián xuézǐ zài chéngzhǎng guòchéng zhōng nánmiǎn huì jīnglì fēngyǔ kǎnkě, yīngdāng xuéhuì yòng biànzhèng fāzhǎn yǔ bāoróng huòdá de kuānguǎng xiōnghuái lái kàndài zànshí de cuòzhé.', 'Các bạn trẻ trên đường đời trưởng thành khó tránh khỏi phong ba ghập ghềnh, nên học cách dùng tấm lòng rộng mở bao dung và phát triển biện chứng để nhìn nhận đối đãi với những thất bại tạm thời.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7133b9d8-7ca0-431c-b0fd-0fa6eff2535c'
);

-- [考察] (kǎo chá): khảo sát, nghiên cứu
UPDATE public.vocabularies
SET example_hanzi = '国家级生态科考队深入青藏高原三江源无人区，对高寒湿地植被生态与水文气候变化开展了系统性深入考察。',
    example_pinyin = 'Guójiājí shēngtài kěkǎoduì shēnrù Qīng-Zàng Gāoyuán Sānjiāngyuán wúrénqū, duì gāohán shīdì zhíbèi shēngtài yǔ shuǐwén qìhòu biànhuà kāizhǎn le xìtǒngxìng shēnrù kǎochá.',
    example_vi = 'Đoàn khảo sát sinh thái cấp quốc gia tiến sâu vào khu vực không bóng người Tam Giang Nguyên trên cao nguyên Thanh Tạng, triển khai khảo sát nghiên cứu chuyên sâu có hệ thống về thảm thực vật đầm lầy và biến đổi khí hậu thủy văn vùng lạnh cao.'
WHERE id = '2dade4f9-9806-4192-b6a1-c8032d6f3fa4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2dade4f9-9806-4192-b6a1-c8032d6f3fa4', '国家级生态科考队深入青藏高原三江源无人区，对高寒湿地植被生态与水文气候变化开展了系统性深入考察。', 'Guójiājí shēngtài kěkǎoduì shēnrù Qīng-Zàng Gāoyuán Sānjiāngyuán wúrénqū, duì gāohán shīdì zhíbèi shēngtài yǔ shuǐwén qìhòu biànhuà kāizhǎn le xìtǒngxìng shēnrù kǎochá.', 'Đoàn khảo sát sinh thái cấp quốc gia tiến sâu vào khu vực không bóng người Tam Giang Nguyên trên cao nguyên Thanh Tạng, triển khai khảo sát nghiên cứu chuyên sâu có hệ thống về thảm thực vật đầm lầy và biến đổi khí hậu thủy văn vùng lạnh cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2dade4f9-9806-4192-b6a1-c8032d6f3fa4'
);

-- [考古] (kǎo gǔ): khảo cổ
UPDATE public.vocabularies
SET example_hanzi = '中华文明探源工程重大考古发掘成果实证了中华五千多年连绵不绝、生生不息的文明璀璨历程。',
    example_pinyin = 'Zhōnghuá wénmíng tànyuán gōngchéng zhòngdà kǎogǔ fājué chéngguǒ shízhèng le Zhōnghuá wǔqiān duō nián liánmián-bùjué, shēngshēng-bùxī de wénmíng cuǐcàn lìchéng.',
    example_vi = 'Thành quả khai quật khảo cổ trọng đại của dự án thám hiểm nguồn gốc văn minh Trung Hoa đã minh chứng thực tế cho tiến trình rực rỡ hơn 5.000 năm lịch sử văn minh không ngừng đứt đoạn sinh sôi nảy nở.'
WHERE id = 'd16c0bdc-18ea-4eea-9d2c-7ba5547a4d2d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd16c0bdc-18ea-4eea-9d2c-7ba5547a4d2d', '中华文明探源工程重大考古发掘成果实证了中华五千多年连绵不绝、生生不息的文明璀璨历程。', 'Zhōnghuá wénmíng tànyuán gōngchéng zhòngdà kǎogǔ fājué chéngguǒ shízhèng le Zhōnghuá wǔqiān duō nián liánmián-bùjué, shēngshēng-bùxī de wénmíng cuǐcàn lìchéng.', 'Thành quả khai quật khảo cổ trọng đại của dự án thám hiểm nguồn gốc văn minh Trung Hoa đã minh chứng thực tế cho tiến trình rực rỡ hơn 5.000 năm lịch sử văn minh không ngừng đứt đoạn sinh sôi nảy nở.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd16c0bdc-18ea-4eea-9d2c-7ba5547a4d2d'
);

-- [考核] (kǎo hé): khảo hạch, kiểm tra đánh giá
UPDATE public.vocabularies
SET example_hanzi = '企业管理层建立了以工作实绩与创新能力为导向的科学评价机制，对全体员工进行公正全面的年度绩效考核。',
    example_pinyin = 'Qǐyè guǎnlǐcéng jiànlì le yǐ gōngzuò shíjì yǔ chuàngxīn nénglì wèi dǎoxiàng de kēxué píngjià jīzhì, duì quántǐ yuángōng jìnxíng gōngzhèng quánmiàn de niándù jìxiào kǎohé.',
    example_vi = 'Ban quản lý doanh nghiệp đã thiết lập cơ chế đánh giá khoa học dựa trên năng lực sáng tạo và thành tích công tác thực tế, tiến hành kiểm tra đánh giá khảo hạch hiệu quả công việc thường niên công bằng toàn diện cho nhân viên.'
WHERE id = 'a1f23bb7-8e51-4f35-9e32-1a4184f9bf9b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a1f23bb7-8e51-4f35-9e32-1a4184f9bf9b', '企业管理层建立了以工作实绩与创新能力为导向的科学评价机制，对全体员工进行公正全面的年度绩效考核。', 'Qǐyè guǎnlǐcéng jiànlì le yǐ gōngzuò shíjì yǔ chuàngxīn nénglì wèi dǎoxiàng de kēxué píngjià jīzhì, duì quántǐ yuángōng jìnxíng gōngzhèng quánmiàn de niándù jìxiào kǎohé.', 'Ban quản lý doanh nghiệp đã thiết lập cơ chế đánh giá khoa học dựa trên năng lực sáng tạo và thành tích công tác thực tế, tiến hành kiểm tra đánh giá khảo hạch hiệu quả công việc thường niên công bằng toàn diện cho nhân viên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a1f23bb7-8e51-4f35-9e32-1a4184f9bf9b'
);

-- [考验] (kǎo yàn): thử thách, kiểm nghiệm
UPDATE public.vocabularies
SET example_hanzi = '暴雪严寒与突发断电交织的紧急险情，对城市基础设施应急保障调度反应能力是一场极其严峻的考验。',
    example_pinyin = 'Bàoxuě yánhán yǔ tūfā duàndiàn jiāozhī de jǐnjí xiǎnqíng, duì chéngshì jīchǔ shèshī yìngjí bǎozhàng diàodù fǎnyìng nénglì shì yì chǎng jíqí yánjùn de kǎoyàn.',
    example_vi = 'Tình huống khẩn cấp bão tuyết giá rét đan xen mất điện đột ngột là một phép thử thử thách vô cùng khắc nghiệt đối với năng lực ứng phó điều tiết an sinh khẩn cấp cơ sở hạ tầng đô thị.'
WHERE id = '8a5e3504-3ed5-476a-b308-3ae9f89916a9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8a5e3504-3ed5-476a-b308-3ae9f89916a9', '暴雪严寒与突发断电交织的紧急险情，对城市基础设施应急保障调度反应能力是一场极其严峻的考验。', 'Bàoxuě yánhán yǔ tūfā duàndiàn jiāozhī de jǐnjí xiǎnqíng, duì chéngshì jīchǔ shèshī yìngjí bǎozhàng diàodù fǎnyìng nénglì shì yì chǎng jíqí yánjùn de kǎoyàn.', 'Tình huống khẩn cấp bão tuyết giá rét đan xen mất điện đột ngột là một phép thử thử thách vô cùng khắc nghiệt đối với năng lực ứng phó điều tiết an sinh khẩn cấp cơ sở hạ tầng đô thị.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8a5e3504-3ed5-476a-b308-3ae9f89916a9'
);

-- [可口] (kěkǒu): ngon miệng
UPDATE public.vocabularies
SET example_hanzi = '这家百年历史传统小吃店烹饪制作的糖醋松鼠鳜鱼外脆里嫩、酸甜可口，引来无数中外食客慕名前来品尝。',
    example_pinyin = 'Zhè jiā bǎinián lìshǐ chuántǒng xiǎochīdiàn pēngrèn zhìzuò de tángcù sōngshǔ guìyú wài cuì lǐ nèn, suāntián kěkǒu, yǐn lái wúshù zhōng-wài shíkè mùmíng qiánlái pǐncháng.',
    example_vi = 'Món cá quế chua ngọt dáng sóc do quán ăn vặt truyền thống trăm năm lịch sử này chế biến ngoài giòn trong mềm, chua ngọt vừa miệng thơm ngon, thu hút biết bao thực khách trong và ngoài nước ngưỡng mộ tìm đến nếm thử.'
WHERE id = '9e88fe3d-53b1-4fd7-8357-ce18ea4cbe21' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9e88fe3d-53b1-4fd7-8357-ce18ea4cbe21', '这家百年历史传统小吃店烹饪制作的糖醋松鼠鳜鱼外脆里嫩、酸甜可口，引来无数中外食客慕名前来品尝。', 'Zhè jiā bǎinián lìshǐ chuántǒng xiǎochīdiàn pēngrèn zhìzuò de tángcù sōngshǔ guìyú wài cuì lǐ nèn, suāntián kěkǒu, yǐn lái wúshù zhōng-wài shíkè mùmíng qiánlái pǐncháng.', 'Món cá quế chua ngọt dáng sóc do quán ăn vặt truyền thống trăm năm lịch sử này chế biến ngoài giòn trong mềm, chua ngọt vừa miệng thơm ngon, thu hút biết bao thực khách trong và ngoài nước ngưỡng mộ tìm đến nếm thử.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9e88fe3d-53b1-4fd7-8357-ce18ea4cbe21'
);

-- [科目] (kēmù): môn học, hạng mục
UPDATE public.vocabularies
SET example_hanzi = '在现代化大学教育课程体系中，高等数学与专业计算机编程语言是工科大学本科生必须精通的必修基础科目。',
    example_pinyin = 'Zài xiàndàihuà dàxué jiàoyù kèchéng tǐxì zhōng, gāoděng shùxué yǔ zhuānyè jìsuànjī biānchéng yǔyán shì gōngkē dàxué běnkēshēng bìxū jīngtōng de bìxiū jīchǔ kēmù.',
    example_vi = 'Trong hệ thống chương trình giáo dục đại học hiện đại, toán cao cấp và ngôn ngữ lập trình máy tính chuyên ngành là các môn học cơ sở bắt buộc mà sinh viên khối kỹ thuật phải tinh thông.'
WHERE id = '075fc113-7268-4057-b373-1cf60ff7476a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '075fc113-7268-4057-b373-1cf60ff7476a', '在现代化大学教育课程体系中，高等数学与专业计算机编程语言是工科大学本科生必须精通的必修基础科目。', 'Zài xiàndàihuà dàxué jiàoyù kèchéng tǐxì zhōng, gāoděng shùxué yǔ zhuānyè jìsuànjī biānchéng yǔyán shì gōngkē dàxué běnkēshēng bìxū jīngtōng de bìxiū jīchǔ kēmù.', 'Trong hệ thống chương trình giáo dục đại học hiện đại, toán cao cấp và ngôn ngữ lập trình máy tính chuyên ngành là các môn học cơ sở bắt buộc mà sinh viên khối kỹ thuật phải tinh thông.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '075fc113-7268-4057-b373-1cf60ff7476a'
);

-- [课题] (kètí): đề tài, chuyên đề
UPDATE public.vocabularies
SET example_hanzi = '国家重点实验室科研团队经过为期三年的严谨攻关，顺利完成了国家自然科学基金重大前沿研究课题。',
    example_pinyin = 'Guójiā zhòngdiǎn shíyànshì kēyán tuánduì jīngguò wéiqī sān nián de yánjǐn gōngguān, shùnlì wánchéng le guójiā zìrán kēxué jījīn zhòngdà qiányán yánjiū kètí.',
    example_vi = 'Đội ngũ nghiên cứu phòng thí nghiệm trọng điểm quốc gia qua 3 năm nỗ lực nghiên cứu nghiêm cẩn đã hoàn thành thuận lợi đề tài nghiên cứu tiên phong trọng đại của quỹ khoa học tự nhiên quốc gia.'
WHERE id = 'cfea4fee-0eff-49a9-9a86-ba21bf5c9dbf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cfea4fee-0eff-49a9-9a86-ba21bf5c9dbf', '国家重点实验室科研团队经过为期三年的严谨攻关，顺利完成了国家自然科学基金重大前沿研究课题。', 'Guójiā zhòngdiǎn shíyànshì kēyán tuánduì jīngguò wéiqī sān nián de yánjǐn gōngguān, shùnlì wánchéng le guójiā zìrán kēxué jījīn zhòngdà qiányán yánjiū kètí.', 'Đội ngũ nghiên cứu phòng thí nghiệm trọng điểm quốc gia qua 3 năm nỗ lực nghiên cứu nghiêm cẩn đã hoàn thành thuận lợi đề tài nghiên cứu tiên phong trọng đại của quỹ khoa học tự nhiên quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cfea4fee-0eff-49a9-9a86-ba21bf5c9dbf'
);

-- [渴望] (kěwàng): khát khao, khao khát
UPDATE public.vocabularies
SET example_hanzi = '偏远干旱山区的孩子们眼中闪烁着对知识的无比纯真与渴望，他们期盼着通过读书改变命运、建设家乡。',
    example_pinyin = 'Piānyuǎn gānhàn shānqū de háizi men yǎn zhōng shǎnshuò zhe duì zhīshi de wúbǐ chúnzhēn yǔ kěwàng, tāmen qīpàn zhe tōngguò dúshū gǎibiàn mìngyùn, jiànshè jiāxiāng.',
    example_vi = 'Ánh mắt những em nhỏ vùng núi khô hạn xa xôi ánh lên vẻ thuần khiết và khao khát vô bờ bến đối với tri thức, các em mong mỏi học tập thành tài để đổi thay số phận và xây dựng quê hương.'
WHERE id = '50ba8032-363d-4514-9559-99b3f598b78b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '50ba8032-363d-4514-9559-99b3f598b78b', '偏远干旱山区的孩子们眼中闪烁着对知识的无比纯真与渴望，他们期盼着通过读书改变命运、建设家乡。', 'Piānyuǎn gānhàn shānqū de háizi men yǎn zhōng shǎnshuò zhe duì zhīshi de wúbǐ chúnzhēn yǔ kěwàng, tāmen qīpàn zhe tōngguò dúshū gǎibiàn mìngyùn, jiànshè jiāxiāng.', 'Ánh mắt những em nhỏ vùng núi khô hạn xa xôi ánh lên vẻ thuần khiết và khao khát vô bờ bến đối với tri thức, các em mong mỏi học tập thành tài để đổi thay số phận và xây dựng quê hương.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '50ba8032-363d-4514-9559-99b3f598b78b'
);

-- [可行] (kěxíng): khả thi
UPDATE public.vocabularies
SET example_hanzi = '各领域评审专家经过对技术标准、经济成本与环境影响等各方面充分论证后，一致认为该项工程方案切实可行。',
    example_pinyin = 'Gè lǐngyù píngshěn zhuānjiā jīngguò duì jìshù biāozhǔn, jīngjì chéngběn yǔ huánjìng yǐngxiǎng děng gè fāngmiàn chōngfèn lùnzhèng hòu, yízhì rènwéi gāi xiàng gōngchéng fāng''àn qièshí kěxíng.',
    example_vi = 'Các chuyên gia thẩm định đa lĩnh vực sau khi luận chứng đầy đủ về tiêu chuẩn kỹ thuật, chi phí kinh tế và tác động môi trường đã nhất trí nhận định phương án công trình này hoàn toàn khả thi sát thực tế.'
WHERE id = '8e6d39f9-4077-41df-83ff-0947591f034f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8e6d39f9-4077-41df-83ff-0947591f034f', '各领域评审专家经过对技术标准、经济成本与环境影响等各方面充分论证后，一致认为该项工程方案切实可行。', 'Gè lǐngyù píngshěn zhuānjiā jīngguò duì jìshù biāozhǔn, jīngjì chéngběn yǔ huánjìng yǐngxiǎng děng gè fāngmiàn chōngfèn lùnzhèng hòu, yízhì rènwéi gāi xiàng gōngchéng fāng''àn qièshí kěxíng.', 'Các chuyên gia thẩm định đa lĩnh vực sau khi luận chứng đầy đủ về tiêu chuẩn kỹ thuật, chi phí kinh tế và tác động môi trường đã nhất trí nhận định phương án công trình này hoàn toàn khả thi sát thực tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8e6d39f9-4077-41df-83ff-0947591f034f'
);

-- [恐惧] (kǒng jù): sợ hãi
UPDATE public.vocabularies
SET example_hanzi = '面对生活道路上突如其来的挫折与严峻挑战，我们要敢于迎难而上，绝不能让内心的懦弱与恐惧束缚住前行的脚步。',
    example_pinyin = 'Miànduì shēnghuó dàolù shang tūrúqílái de cuòzhé yǔ yánjùn tiǎozhàn, wǒmen yào gǎnyú yíngnán''érshàng, jué bùnéng ràng nèixīn de nuòruò yǔ kǒngjù shùfù zhù qiánxíng de jiǎobù.',
    example_vi = 'Đối mặt với những thử thách gay gắt và thất bại bất ngờ trên đường đời, chúng ta phải dám đón đầu khó khăn vượt lên, tuyệt đối không để sự hèn yếu và sợ hãi trong lòng ghì trói bước chân tiến tới.'
WHERE id = 'eecc3768-1fb9-4e2b-b0bb-71b5146c2a5f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'eecc3768-1fb9-4e2b-b0bb-71b5146c2a5f', '面对生活道路上突如其来的挫折与严峻挑战，我们要敢于迎难而上，绝不能让内心的懦弱与恐惧束缚住前行的脚步。', 'Miànduì shēnghuó dàolù shang tūrúqílái de cuòzhé yǔ yánjùn tiǎozhàn, wǒmen yào gǎnyú yíngnán''érshàng, jué bùnéng ràng nèixīn de nuòruò yǔ kǒngjù shùfù zhù qiánxíng de jiǎobù.', 'Đối mặt với những thử thách gay gắt và thất bại bất ngờ trên đường đời, chúng ta phải dám đón đầu khó khăn vượt lên, tuyệt đối không để sự hèn yếu và sợ hãi trong lòng ghì trói bước chân tiến tới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'eecc3768-1fb9-4e2b-b0bb-71b5146c2a5f'
);

-- [空闲] (kòngxián): rảnh rỗi
UPDATE public.vocabularies
SET example_hanzi = '在周末繁重工作之余难得的空闲时光里，他最喜欢泡上一杯清茶，坐在书桌前静静读上几本古代经典文学名著。',
    example_pinyin = 'Zài zhōumò fánzhòng gōngzuò zhī yú nándé de kòngxián shíguāng lǐ, tā zuì xǐhuan pào shang yì bēi qīngchá, zuò zài shūzhuō qián jìngjìng dú shang jǐ běn gǔdài jīngdiǎn wénxué míngzhù.',
    example_vi = 'Trong những giây phút rảnh rỗi hiếm hoi ngoài giờ làm việc bận rộn cuối tuần, anh ấy thích nhất pha một tách trà thanh, ngồi trước bàn sách đọc mấy cuốn danh tác văn học cổ điển kinh điển.'
WHERE id = '858c85ae-8874-4806-aaa5-77429552d6ad' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '858c85ae-8874-4806-aaa5-77429552d6ad', '在周末繁重工作之余难得的空闲时光里，他最喜欢泡上一杯清茶，坐在书桌前静静读上几本古代经典文学名著。', 'Zài zhōumò fánzhòng gōngzuò zhī yú nándé de kòngxián shíguāng lǐ, tā zuì xǐhuan pào shang yì bēi qīngchá, zuò zài shūzhuō qián jìngjìng dú shang jǐ běn gǔdài jīngdiǎn wénxué míngzhù.', 'Trong những giây phút rảnh rỗi hiếm hoi ngoài giờ làm việc bận rộn cuối tuần, anh ấy thích nhất pha một tách trà thanh, ngồi trước bàn sách đọc mấy cuốn danh tác văn học cổ điển kinh điển.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '858c85ae-8874-4806-aaa5-77429552d6ad'
);

-- [扣] (kòu): khấu trừ, cài (nút), giữ lại
UPDATE public.vocabularies
SET example_hanzi = '出发前天气转冷寒风阵阵，妈妈细心地帮刚准备出门的小女孩把厚厚羽绒服领口上的纽扣紧紧扣好。',
    example_pinyin = 'Chūfā qián tiānqì zhuǎn lěng hánfēng zhènzhèn, māma xìxīn de bāng gāng zhǔnbèi chūmén de xiǎo nǚhái bǎ hòuhòu yǔróngfú lǐngkǒu shang de niǔkòu jǐnjǐn kòu hǎo.',
    example_vi = 'Trước lúc lên đường trời trở lạnh gió bấc từng cơn, mẹ cẩn thận giúp bé gái vừa chuẩn bị ra cửa cài nút áo khoác lông vũ dày dặn nơi cổ áo thật kín đáo.'
WHERE id = 'b560836a-e270-4aca-9c6a-289a33caf643' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b560836a-e270-4aca-9c6a-289a33caf643', '出发前天气转冷寒风阵阵，妈妈细心地帮刚准备出门的小女孩把厚厚羽绒服领口上的纽扣紧紧扣好。', 'Chūfā qián tiānqì zhuǎn lěng hánfēng zhènzhèn, māma xìxīn de bāng gāng zhǔnbèi chūmén de xiǎo nǚhái bǎ hòuhòu yǔróngfú lǐngkǒu shang de niǔkòu jǐnjǐn kòu hǎo.', 'Trước lúc lên đường trời trở lạnh gió bấc từng cơn, mẹ cẩn thận giúp bé gái vừa chuẩn bị ra cửa cài nút áo khoác lông vũ dày dặn nơi cổ áo thật kín đáo.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b560836a-e270-4aca-9c6a-289a33caf643'
);

-- [口腔] (kǒuqiāng): khoang miệng
UPDATE public.vocabularies
SET example_hanzi = '牙科医学专家建议大家养成每天早晚用含氟牙膏认真刷牙并使用牙线清洁的好习惯，以保持口腔卫生健康。',
    example_pinyin = 'Yákē yīxué zhuānjiā jiànyì dàjiā yǎngchéng měitiān zǎowǎn yòng hánfú yágāo rènzhēn shuāyá bìng shǐyòng yáxiàn qīngjié de hǎo xíguàn, yǐ bǎochí kǒuqiāng wèishēng jiànkāng.',
    example_vi = 'Chuyên gia y học nha khoa khuyến cáo mọi người hình thành thói quen tốt đánh răng bằng kem đánh răng có fluor mỗi sáng tối và dùng chỉ nha khoa làm sạch để duy trì vệ sinh khoang miệng khỏe mạnh.'
WHERE id = '2920671c-f804-4e5e-bd5a-a4b20c3bc6a3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2920671c-f804-4e5e-bd5a-a4b20c3bc6a3', '牙科医学专家建议大家养成每天早晚用含氟牙膏认真刷牙并使用牙线清洁的好习惯，以保持口腔卫生健康。', 'Yákē yīxué zhuānjiā jiànyì dàjiā yǎngchéng měitiān zǎowǎn yòng hánfú yágāo rènzhēn shuāyá bìng shǐyòng yáxiàn qīngjié de hǎo xíguàn, yǐ bǎochí kǒuqiāng wèishēng jiànkāng.', 'Chuyên gia y học nha khoa khuyến cáo mọi người hình thành thói quen tốt đánh răng bằng kem đánh răng có fluor mỗi sáng tối và dùng chỉ nha khoa làm sạch để duy trì vệ sinh khoang miệng khỏe mạnh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2920671c-f804-4e5e-bd5a-a4b20c3bc6a3'
);

-- [口头] (kǒutóu): bằng miệng, lời nói
UPDATE public.vocabularies
SET example_hanzi = '在商业重大合作洽谈与经济业务往来中，双方必须签订正式书面法律合同，切不可仅仅停留在口头约定层面。',
    example_pinyin = 'Zài shāngyè zhòngdà hézuò qiàtán yǔ jīngjì yèwù wǎnglái zhōng, shuāngfāng bìxū qiāndìng zhèngshì shūmiàn fǎlǜ hétong, qiè bùkě jǐnjǐn tíngliú zài kǒutóu yuēdìng céngmiàn.',
    example_vi = 'Trong đàm phán hợp tác thương mại trọng đại và giao dịch kinh tế, hai bên bắt buộc phải ký kết hợp đồng pháp lý văn bản chính thức, chớ nên chỉ dừng lại ở mức giao kèo thỏa thuận bằng miệng.'
WHERE id = 'd8e6e434-54a8-4e09-8b1d-5fd177442e38' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd8e6e434-54a8-4e09-8b1d-5fd177442e38', '在商业重大合作洽谈与经济业务往来中，双方必须签订正式书面法律合同，切不可仅仅停留在口头约定层面。', 'Zài shāngyè zhòngdà hézuò qiàtán yǔ jīngjì yèwù wǎnglái zhōng, shuāngfāng bìxū qiāndìng zhèngshì shūmiàn fǎlǜ hétong, qiè bùkě jǐnjǐn tíngliú zài kǒutóu yuēdìng céngmiàn.', 'Trong đàm phán hợp tác thương mại trọng đại và giao dịch kinh tế, hai bên bắt buộc phải ký kết hợp đồng pháp lý văn bản chính thức, chớ nên chỉ dừng lại ở mức giao kèo thỏa thuận bằng miệng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd8e6e434-54a8-4e09-8b1d-5fd177442e38'
);

-- [夸] (kuā): khen ngợi, khoe
UPDATE public.vocabularies
SET example_hanzi = '看到孩子凭借自己的勤奋刻苦在全省中学生数学竞赛中荣获一等奖，邻居们都纷纷竖起大拇指夸赞孩子有出息。',
    example_pinyin = 'Kàndào háizi píngjiè zìjǐ de qínfèn kèkǔ zài quánshěng zhōngxuésheng shùxué jìngsài zhōng rónghuò yīděngjiǎng, línjū men dōu fēnfēn shù qǐ dàmǔzhǐ kuāzàn háizi yǒu chūxi.',
    example_vi = 'Thấy con mình nhờ sự cần cù chịu khó đoạt giải nhất cuộc thi toán học sinh trung học toàn tỉnh, bà con hàng xóm ai nấy đều giơ ngón tay cái khen ngợi cháu bé có tiền đồ xán lạn.'
WHERE id = '4720be4a-41e9-4a91-8007-3d58caf567aa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4720be4a-41e9-4a91-8007-3d58caf567aa', '看到孩子凭借自己的勤奋刻苦在全省中学生数学竞赛中荣获一等奖，邻居们都纷纷竖起大拇指夸赞孩子有出息。', 'Kàndào háizi píngjiè zìjǐ de qínfèn kèkǔ zài quánshěng zhōngxuésheng shùxué jìngsài zhōng rónghuò yīděngjiǎng, línjū men dōu fēnfēn shù qǐ dàmǔzhǐ kuāzàn háizi yǒu chūxi.', 'Thấy con mình nhờ sự cần cù chịu khó đoạt giải nhất cuộc thi toán học sinh trung học toàn tỉnh, bà con hàng xóm ai nấy đều giơ ngón tay cái khen ngợi cháu bé có tiền đồ xán lạn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4720be4a-41e9-4a91-8007-3d58caf567aa'
);

-- [会计] (kuàijì): kế toán
UPDATE public.vocabularies
SET example_hanzi = '公司财务部门的资深注册会计师正在严格按照国家税法准则，对全年的各项经营收支凭证进行逐项核算。',
    example_pinyin = 'Gōngsī cáiwù bùmén de zīshēn zhùcè kuàijìshī zhèngzài yángé ànzhào guójiā shuìfǎ zhǔnzé, duì quánnián de gè xiàng jīngyíng shōuzhī píngzhèng jìnxíng zhúxiàng hésuàn.',
    example_vi = 'Kiểm toán viên kế toán công chứng kỳ cựu của phòng tài chính công ty đang dựa theo chuẩn mực luật thuế quốc gia rà soát quyết toán từng chứng từ thu chi kinh doanh cả năm.'
WHERE id = 'c3e4209c-8cec-4868-ace8-73873b1f8e99' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c3e4209c-8cec-4868-ace8-73873b1f8e99', '公司财务部门的资深注册会计师正在严格按照国家税法准则，对全年的各项经营收支凭证进行逐项核算。', 'Gōngsī cáiwù bùmén de zīshēn zhùcè kuàijìshī zhèngzài yángé ànzhào guójiā shuìfǎ zhǔnzé, duì quánnián de gè xiàng jīngyíng shōuzhī píngzhèng jìnxíng zhúxiàng hésuàn.', 'Kiểm toán viên kế toán công chứng kỳ cựu của phòng tài chính công ty đang dựa theo chuẩn mực luật thuế quốc gia rà soát quyết toán từng chứng từ thu chi kinh doanh cả năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c3e4209c-8cec-4868-ace8-73873b1f8e99'
);

-- [款式] (kuǎnshì): kiểu dáng, mẫu mã
UPDATE public.vocabularies
SET example_hanzi = '服装设计周展厅里陈列着由青年本土设计师巧妙融合非遗刺绣元素与现代时尚剪裁的多款新颖服装款式。',
    example_pinyin = 'Fúzhuāng shèjì zhōu zhǎntīng lǐ chénliè zhe yóu qīngnián běntǔ shèjìshī qiǎomiào rónghé fēiyí cìxiù yuánsù yǔ xiàndài shíshàng jiǎncái de duō kuǎn xīnyǐng fúzhuāng kuǎnshì.',
    example_vi = 'Trong sảnh triển lãm tuần lễ thiết kế thời trang trưng bày nhiều mẫu mã kiểu dáng trang phục mới lạ do nhà thiết kế trẻ bản địa kết hợp tài tình yếu tố thêu phi vật thể với đường cắt may thời trang hiện đại.'
WHERE id = 'b3f6b33c-5835-485a-84cc-c115d645890b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b3f6b33c-5835-485a-84cc-c115d645890b', '服装设计周展厅里陈列着由青年本土设计师巧妙融合非遗刺绣元素与现代时尚剪裁的多款新颖服装款式。', 'Fúzhuāng shèjì zhōu zhǎntīng lǐ chénliè zhe yóu qīngnián běntǔ shèjìshī qiǎomiào rónghé fēiyí cìxiù yuánsù yǔ xiàndài shíshàng jiǎncái de duō kuǎn xīnyǐng fúzhuāng kuǎnshì.', 'Trong sảnh triển lãm tuần lễ thiết kế thời trang trưng bày nhiều mẫu mã kiểu dáng trang phục mới lạ do nhà thiết kế trẻ bản địa kết hợp tài tình yếu tố thêu phi vật thể với đường cắt may thời trang hiện đại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b3f6b33c-5835-485a-84cc-c115d645890b'
);

-- [夸张] (kuāzhāng): khoa trương, phóng đại
UPDATE public.vocabularies
SET example_hanzi = '这部优秀的现实主义讽刺喜剧电影通过恰到好处、富有幽默感的艺术夸张手法，深刻揭示了盲目跟风消费的不良现象。',
    example_pinyin = 'Zhè bù yōuxiù de xiànshízhǔyì fěngcì xǐjù diànyǐng tōngguò qiàdào-hǎochù, fùyǒu yōumògǎn de yìshù kuāzhāng shǒufǎ, shēnrù jiēshì le mángmù gēnfēng xiāofèi de bùliáng xiànxiàng.',
    example_vi = 'Bộ phim hài châm biếm hiện thực xuất sắc này thông qua thủ pháp phóng đại khoa trương nghệ thuật vừa vặn giàu tính hài hước đã vạch trần sâu sắc hiện tượng chạy theo tiêu dùng mù quáng.'
WHERE id = '1844847c-7d31-4087-b6f5-ed63461e2383' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1844847c-7d31-4087-b6f5-ed63461e2383', '这部优秀的现实主义讽刺喜剧电影通过恰到好处、富有幽默感的艺术夸张手法，深刻揭示了盲目跟风消费的不良现象。', 'Zhè bù yōuxiù de xiànshízhǔyì fěngcì xǐjù diànyǐng tōngguò qiàdào-hǎochù, fùyǒu yōumògǎn de yìshù kuāzhāng shǒufǎ, shēnrù jiēshì le mángmù gēnfēng xiāofèi de bùliáng xiànxiàng.', 'Bộ phim hài châm biếm hiện thực xuất sắc này thông qua thủ pháp phóng đại khoa trương nghệ thuật vừa vặn giàu tính hài hước đã vạch trần sâu sắc hiện tượng chạy theo tiêu dùng mù quáng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1844847c-7d31-4087-b6f5-ed63461e2383'
);

-- [亏损] (kuīsǔn): thua lỗ
UPDATE public.vocabularies
SET example_hanzi = '面对原材料大幅涨价与激烈的市场同行竞争，企业积极推进产品研发转型升级，终于在年底彻底扭转了持续亏损的局面。',
    example_pinyin = 'Miànduì yuáncáiliào dàfú zhǎngjià yǔ jīliè de shìchǎng tóngháng jìngzhēng, qǐyè jījí tuījìn chǎnpǐn yánfā zhuǎnxíng shēngjí, zhōngyú zài niándǐ chèdǐ niǔzhuǎn le chíxù kuīsǔn de júmiàn.',
    example_vi = 'Trước việc nguyên vật liệu tăng giá mạnh và cạnh tranh khốc liệt của đối thủ, doanh nghiệp tích cực nghiên cứu chuyển đổi nâng cấp sản phẩm, cuối cùng đến cuối năm đã xoay chuyển hoàn toàn cục diện thua lỗ kéo dài.'
WHERE id = '689dbec0-8777-4558-8f27-f05af8eae699' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '689dbec0-8777-4558-8f27-f05af8eae699', '面对原材料大幅涨价与激烈的市场同行竞争，企业积极推进产品研发转型升级，终于在年底彻底扭转了持续亏损的局面。', 'Miànduì yuáncáiliào dàfú zhǎngjià yǔ jīliè de shìchǎng tóngháng jìngzhēng, qǐyè jījí tuījìn chǎnpǐn yánfā zhuǎnxíng shēngjí, zhōngyú zài niándǐ chèdǐ niǔzhuǎn le chíxù kuīsǔn de júmiàn.', 'Trước việc nguyên vật liệu tăng giá mạnh và cạnh tranh khốc liệt của đối thủ, doanh nghiệp tích cực nghiên cứu chuyển đổi nâng cấp sản phẩm, cuối cùng đến cuối năm đã xoay chuyển hoàn toàn cục diện thua lỗ kéo dài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '689dbec0-8777-4558-8f27-f05af8eae699'
);

-- [枯燥] (kūzào): khô khan, tẻ nhạt
UPDATE public.vocabularies
SET example_hanzi = '化学特级教师善于把原本枯燥抽象的微观分子反应理论知识，转化为生动有趣的课堂探究互动实验。',
    example_pinyin = 'Huàxué tèjí jiàoshī shànyú bǎ yuánběn kūzào chōuxiàng de wēiguān fēnzǐ fǎnyìng lǐlùn zhīshi, zhuǎnhuà wèi shēngdòng yǒuqù de kètáng tànjiū hùdòng shíyàn.',
    example_vi = 'Giáo viên hóa học xuất sắc rất giỏi chuyển hóa những tri thức lý thuyết phản ứng phân tử vi mô vốn dĩ khô khan trừu tượng thành các thí nghiệm tương tác khám phá sinh động thú vị trên lớp.'
WHERE id = '599aeb43-b149-40c2-af14-bb38701369c2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '599aeb43-b149-40c2-af14-bb38701369c2', '化学特级教师善于把原本枯燥抽象的微观分子反应理论知识，转化为生动有趣的课堂探究互动实验。', 'Huàxué tèjí jiàoshī shànyú bǎ yuánběn kūzào chōuxiàng de wēiguān fēnzǐ fǎnyìng lǐlùn zhīshi, zhuǎnhuà wèi shēngdòng yǒuqù de kètáng tànjiū hùdòng shíyàn.', 'Giáo viên hóa học xuất sắc rất giỏi chuyển hóa những tri thức lý thuyết phản ứng phân tử vi mô vốn dĩ khô khan trừu tượng thành các thí nghiệm tương tác khám phá sinh động thú vị trên lớp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '599aeb43-b149-40c2-af14-bb38701369c2'
);

-- [啦] (la): rồi, cơ mà (trợ từ)
UPDATE public.vocabularies
SET example_hanzi = '下课铃声清脆地敲响啦，操场上瞬间聚集满了欢笑着奔跑踢球、跳绳嬉戏的活泼孩子们。',
    example_pinyin = 'Xiàkè língshēng qīngcuì de qiāoxiǎng la, cāochǎng shang shùnjiān jùjí mǎn le huānxiào zhe bēnpǎo tīqiú, tiàoshéng xīxì de huópo háizi men.',
    example_vi = 'Hồi chuông tan học giòn giã vang lên rồi kìa, trên sân vận động chỉ trong chớp mắt đã tụ tập đông nghẹt những đứa trẻ hoạt bát vừa cười vừa chạy đá bóng, nhảy dây nô đùa.'
WHERE id = '315922ac-4cc7-4218-8705-606a3b23d057' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '315922ac-4cc7-4218-8705-606a3b23d057', '下课铃声清脆地敲响啦，操场上瞬间聚集满了欢笑着奔跑踢球、跳绳嬉戏的活泼孩子们。', 'Xiàkè língshēng qīngcuì de qiāoxiǎng la, cāochǎng shang shùnjiān jùjí mǎn le huānxiào zhe bēnpǎo tīqiú, tiàoshéng xīxì de huópo háizi men.', 'Hồi chuông tan học giòn giã vang lên rồi kìa, trên sân vận động chỉ trong chớp mắt đã tụ tập đông nghẹt những đứa trẻ hoạt bát vừa cười vừa chạy đá bóng, nhảy dây nô đùa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '315922ac-4cc7-4218-8705-606a3b23d057'
);

-- [辣椒] (làjiāo): ớt
UPDATE public.vocabularies
SET example_hanzi = '四川和湖南风味特色菜肴素来喜爱选用鲜辣醇厚的红辣椒与花椒作为调味原料，让人吃得大汗淋漓却直呼过瘾。',
    example_pinyin = 'Sìchuān hé Húnán fēngwèi tèsè càiyáo sùlái xǐ''ài xuǎnyòng xiānlà chúnhòu de hóng làjiāo yǔ huājiāo zuòwéi tiáowèi yuánliào, ràng rén chī de dàhàn-línlí què zhí hū guòyǐn.',
    example_vi = 'Các món ăn đặc sản Tứ Xuyên và Hồ Nam từ xưa đã ưa chuộng dùng ớt đỏ tươi cay nồng và hoa tiêu làm gia vị, khiến người ăn toát mồ hôi đầm đìa nhưng luôn miệng khen đã đời.'
WHERE id = '3fe99dc4-04e5-4218-98d4-c538e451d9d1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3fe99dc4-04e5-4218-98d4-c538e451d9d1', '四川和湖南风味特色菜肴素来喜爱选用鲜辣醇厚的红辣椒与花椒作为调味原料，让人吃得大汗淋漓却直呼过瘾。', 'Sìchuān hé Húnán fēngwèi tèsè càiyáo sùlái xǐ''ài xuǎnyòng xiānlà chúnhòu de hóng làjiāo yǔ huājiāo zuòwéi tiáowèi yuánliào, ràng rén chī de dàhàn-línlí què zhí hū guòyǐn.', 'Các món ăn đặc sản Tứ Xuyên và Hồ Nam từ xưa đã ưa chuộng dùng ớt đỏ tươi cay nồng và hoa tiêu làm gia vị, khiến người ăn toát mồ hôi đầm đìa nhưng luôn miệng khen đã đời.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3fe99dc4-04e5-4218-98d4-c538e451d9d1'
);

-- [拦] (lán): chặn, ngăn cản
UPDATE public.vocabularies
SET example_hanzi = '在水流湍急的长江三峡大峡谷之中，建设者们修筑了宏伟的三峡大坝将奔腾汹涌的江水拦腰截断。',
    example_pinyin = 'Zài shuǐliú tuānjí de Chángjiāng Sānxiá dà xiágǔ zhīzhōng, jiànshèzhě men xiūzhù le hóngwěi de Sānxiá Dàbà jiāng bēnténg xiōngyǒng de jiāngshuǐ lányāo jiéduàn.',
    example_vi = 'Giữa hẻm núi lớn Tam Hiệp Trường Giang dòng nước chảy xiết, những người thợ xây dựng đã xây nên đập Tam Hiệp hùng vĩ chặn ngang dòng nước sông cuộn trào dữ dội.'
WHERE id = '6e3f2a34-5d88-415f-9847-2b49494e0f0b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6e3f2a34-5d88-415f-9847-2b49494e0f0b', '在水流湍急的长江三峡大峡谷之中，建设者们修筑了宏伟的三峡大坝将奔腾汹涌的江水拦腰截断。', 'Zài shuǐliú tuānjí de Chángjiāng Sānxiá dà xiágǔ zhīzhōng, jiànshèzhě men xiūzhù le hóngwěi de Sānxiá Dàbà jiāng bēnténg xiōngyǒng de jiāngshuǐ lányāo jiéduàn.', 'Giữa hẻm núi lớn Tam Hiệp Trường Giang dòng nước chảy xiết, những người thợ xây dựng đã xây nên đập Tam Hiệp hùng vĩ chặn ngang dòng nước sông cuộn trào dữ dội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6e3f2a34-5d88-415f-9847-2b49494e0f0b'
);

-- [烂] (làn): nát, rách, thối rữa
UPDATE public.vocabularies
SET example_hanzi = '夏季高温闷热且湿度极大，如果不及时把买回来的新鲜水果放入冷藏保鲜冰箱，只要两天就会变质腐烂。',
    example_pinyin = 'Xiàjì gāowēn mēnrè qiě shīdù jídà, rúguǒ bù jíshí bǎ mǎi huílái de xīnxiān shuǐguǒ fàng rù lěngcáng bǎoxiān bīngxiāng, zhǐyào liǎng tiān jiù huì biànzhì fǔlàn.',
    example_vi = 'Mùa hè nhiệt độ cao oi bức và độ ẩm rất lớn, nếu không kịp thời cho hoa quả tươi mua về vào tủ lạnh giữ tươi thì chỉ cần hai ngày là sẽ biến chất thối rữa mục nát.'
WHERE id = '571f5705-78d5-4b28-8eee-4f0970aefed5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '571f5705-78d5-4b28-8eee-4f0970aefed5', '夏季高温闷热且湿度极大，如果不及时把买回来的新鲜水果放入冷藏保鲜冰箱，只要两天就会变质腐烂。', 'Xiàjì gāowēn mēnrè qiě shīdù jídà, rúguǒ bù jíshí bǎ mǎi huílái de xīnxiān shuǐguǒ fàng rù lěngcáng bǎoxiān bīngxiāng, zhǐyào liǎng tiān jiù huì biànzhì fǔlàn.', 'Mùa hè nhiệt độ cao oi bức và độ ẩm rất lớn, nếu không kịp thời cho hoa quả tươi mua về vào tủ lạnh giữ tươi thì chỉ cần hai ngày là sẽ biến chất thối rữa mục nát.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '571f5705-78d5-4b28-8eee-4f0970aefed5'
);

-- [朗读] (lǎngdú): đọc to, đọc diễn cảm
UPDATE public.vocabularies
SET example_hanzi = '语文课代表站在讲台前声音洪亮、声情并茂地朗读着朱自清先生的经典散文名篇《春》，深受全班同学赞赏。',
    example_pinyin = 'Yǔwén kèdàibiǎo zhàn zài jiǎngtái qián shēngyīn hóngliàng, shēngqíng-bìngmào de lǎngdú zhe Zhū Zìqīng xiānsheng de jīngdiǎn sǎnwén míngpiān "Chūn", shēn shòu quánbān tóngxué zànshǎng.',
    example_vi = 'Lớp phó môn ngữ văn đứng trước bục giảng cất giọng sang sảng, đọc to diễn cảm chứa chan tình cảm tác phẩm tản văn kinh điển "Mùa xuân" của tác giả Chu Tự Thanh, được cả lớp khen ngợi hết lời.'
WHERE id = '611073c2-ac75-4c70-a055-6becc8689bf8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '611073c2-ac75-4c70-a055-6becc8689bf8', '语文课代表站在讲台前声音洪亮、声情并茂地朗读着朱自清先生的经典散文名篇《春》，深受全班同学赞赏。', 'Yǔwén kèdàibiǎo zhàn zài jiǎngtái qián shēngyīn hóngliàng, shēngqíng-bìngmào de lǎngdú zhe Zhū Zìqīng xiānsheng de jīngdiǎn sǎnwén míngpiān "Chūn", shēn shòu quánbān tóngxué zànshǎng.', 'Lớp phó môn ngữ văn đứng trước bục giảng cất giọng sang sảng, đọc to diễn cảm chứa chan tình cảm tác phẩm tản văn kinh điển "Mùa xuân" của tác giả Chu Tự Thanh, được cả lớp khen ngợi hết lời.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '611073c2-ac75-4c70-a055-6becc8689bf8'
);

-- [老实] (lǎoshi): thành thật, thật thà
UPDATE public.vocabularies
SET example_hanzi = '做人做事应当老老实实、恪守诚信原则，靠弄虚作假谋求眼前私利终究无法立足于长远社会。',
    example_pinyin = 'Zuòrén zuòshì yīngdāng lǎolao-shíshí, kèshǒu chéngxìn yuánzé, kào nòngxū-zuòjiǎ móuqiú yǎnqián sīlì zhōngjiū wúfǎ lìzú yú chángyuǎn shèhuì.',
    example_vi = 'Làm người làm việc nên thật thà chất phác, giữ vững nguyên tắc thành tín trung thực, dựa vào gian dối mưu cầu lợi ích nhỏ nhen trước mắt rốt cuộc không thể đứng vững lâu dài trong xã hội.'
WHERE id = '655e2d99-f5d2-4244-be82-c3637ce9742e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '655e2d99-f5d2-4244-be82-c3637ce9742e', '做人做事应当老老实实、恪守诚信原则，靠弄虚作假谋求眼前私利终究无法立足于长远社会。', 'Zuòrén zuòshì yīngdāng lǎolao-shíshí, kèshǒu chéngxìn yuánzé, kào nòngxū-zuòjiǎ móuqiú yǎnqián sīlì zhōngjiū wúfǎ lìzú yú chángyuǎn shèhuì.', 'Làm người làm việc nên thật thà chất phác, giữ vững nguyên tắc thành tín trung thực, dựa vào gian dối mưu cầu lợi ích nhỏ nhen trước mắt rốt cuộc không thể đứng vững lâu dài trong xã hội.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '655e2d99-f5d2-4244-be82-c3637ce9742e'
);

-- [老鼠] (lǎoshǔ): chuột
UPDATE public.vocabularies
SET example_hanzi = '这只机警灵巧的花猫静静地在墙角粮仓阴暗处潜伏守候，一见到窜出来的狡猾老鼠便以迅雷不及掩耳之势扑了上去。',
    example_pinyin = 'Zhè zhī jījǐng língqiǎo de huāmāo jìngjìng de zài qiángjiǎo liángcāng yīn''àn chù qiánfú shǒuhòu, yí jiàn dào cuàn chūlai de jiǎohuá lǎoshǔ biàn yǐ xùnléi-bùjí-yǎněr zhī shì pū le shàngqù.',
    example_vi = 'Chú mèo hoa nhanh nhẹn cảnh giác nằm phục yên ắng ở góc tối kho thóc, vừa thấy con chuột gian xảo chạy vụt ra liền lao tới vồ lấy với tốc độ nhanh như chớp giật.'
WHERE id = 'e286c27b-a36b-4216-a128-a406262ebb48' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e286c27b-a36b-4216-a128-a406262ebb48', '这只机警灵巧的花猫静静地在墙角粮仓阴暗处潜伏守候，一见到窜出来的狡猾老鼠便以迅雷不及掩耳之势扑了上去。', 'Zhè zhī jījǐng língqiǎo de huāmāo jìngjìng de zài qiángjiǎo liángcāng yīn''àn chù qiánfú shǒuhòu, yí jiàn dào cuàn chūlai de jiǎohuá lǎoshǔ biàn yǐ xùnléi-bùjí-yǎněr zhī shì pū le shàngqù.', 'Chú mèo hoa nhanh nhẹn cảnh giác nằm phục yên ắng ở góc tối kho thóc, vừa thấy con chuột gian xảo chạy vụt ra liền lao tới vồ lấy với tốc độ nhanh như chớp giật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e286c27b-a36b-4216-a128-a406262ebb48'
);

-- [雷] (léi): sấm, sét
UPDATE public.vocabularies
SET example_hanzi = '炎炎夏日午后天空乌云翻滚，远处天际突然炸响了一声惊天动地的滚滚春雷，预示着一场大暴雨即将倾盆而下。',
    example_pinyin = 'Yányán xiàrì wǔhòu tiānkōng wūyún fāngǔn, yuǎnchù tiānjì tūrán zhàxiǎng le yì shēng jīngtiān-dòngdì de gǔngǔn chūnléi, yùshì zhe yì chǎng dà bàoyǔ jíjiāng qīngpén-érxià.',
    example_vi = 'Buổi chiều hè oi ả mây đen cuồn cuộn trên trời, phía chân trời xa đột nhiên nổ vang một tiếng sấm rền vang kinh thiên động địa, báo hiệu một cơn mưa rào lớn sắp trút nước xối xả.'
WHERE id = 'ac461117-a7cb-4477-b117-1143843412b5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ac461117-a7cb-4477-b117-1143843412b5', '炎炎夏日午后天空乌云翻滚，远处天际突然炸响了一声惊天动地的滚滚春雷，预示着一场大暴雨即将倾盆而下。', 'Yányán xiàrì wǔhòu tiānkōng wūyún fāngǔn, yuǎnchù tiānjì tūrán zhàxiǎng le yì shēng jīngtiān-dòngdì de gǔngǔn chūnléi, yùshì zhe yì chǎng dà bàoyǔ jíjiāng qīngpén-érxià.', 'Buổi chiều hè oi ả mây đen cuồn cuộn trên trời, phía chân trời xa đột nhiên nổ vang một tiếng sấm rền vang kinh thiên động địa, báo hiệu một cơn mưa rào lớn sắp trút nước xối xả.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ac461117-a7cb-4477-b117-1143843412b5'
);

-- [粒] (lì): hạt, viên
UPDATE public.vocabularies
SET example_hanzi = '每一粒饱满金黄的稻谷粮食都凝聚着农民伯伯面朝黄土背朝天的辛勤汗水，我们在日常生活中必须养成珍惜粮食的美德。',
    example_pinyin = 'Měi yí lì bǎomǎn jīnhuáng de dàogǔ liángshi dōu níngjù zhe nóngmín bóbo miàncháo-huángtǔ bèi cháo tiān de xīnqín hànshuǐ, wǒmen zài rìcháng shēnghuó zhōng bìxū yǎngchéng zhēnxī liángshi de měidé.',
    example_vi = 'Mỗi một hạt lúa mì vàng mẩy đều kết tinh mồ hôi vất vả bán mặt cho đất bán lưng cho trời của các bác nông dân, trong đời sống hàng ngày chúng ta nhất thiết phải rèn luyện đức tính quý trọng hạt gạo.'
WHERE id = '47d2a3ab-acaa-4e33-9d80-eeeaee6be6e1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '47d2a3ab-acaa-4e33-9d80-eeeaee6be6e1', '每一粒饱满金黄的稻谷粮食都凝聚着农民伯伯面朝黄土背朝天的辛勤汗水，我们在日常生活中必须养成珍惜粮食的美德。', 'Měi yí lì bǎomǎn jīnhuáng de dàogǔ liángshi dōu níngjù zhe nóngmín bóbo miàncháo-huángtǔ bèi cháo tiān de xīnqín hànshuǐ, wǒmen zài rìcháng shēnghuó zhōng bìxū yǎngchéng zhēnxī liángshi de měidé.', 'Mỗi một hạt lúa mì vàng mẩy đều kết tinh mồ hôi vất vả bán mặt cho đất bán lưng cho trời của các bác nông dân, trong đời sống hàng ngày chúng ta nhất thiết phải rèn luyện đức tính quý trọng hạt gạo.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '47d2a3ab-acaa-4e33-9d80-eeeaee6be6e1'
);

-- [联想] (lián xiǎng): liên tưởng
UPDATE public.vocabularies
SET example_hanzi = '文学创作需要作者拥有敏锐细腻的生活感知力与丰富的艺术联想力，从看似平凡普通的细微小事中发掘深刻的哲理。',
    example_pinyin = 'Wénxué chuàngzuò xūyào zuòzhě yōngyǒu mǐnruì xìnì de shēnghuó gǎnzhīlì yǔ fēngfù de yìshù liánxiǎnglì, cóng kànsì píngfán pǔtōng de xìwēi xiǎoshì zhōng fājué shēnkè de zhélǐ.',
    example_vi = 'Sáng tác văn học đòi hỏi người viết phải sở hữu năng lực cảm thụ cuộc sống nhạy bén tinh tế và trí tưởng tượng liên tưởng nghệ thuật phong phú, từ những việc nhỏ bé tưởng chừng bình dị khai phá ra triết lý sâu sắc.'
WHERE id = '4dccbcda-aa22-492d-bef2-91f791adbc70' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4dccbcda-aa22-492d-bef2-91f791adbc70', '文学创作需要作者拥有敏锐细腻的生活感知力与丰富的艺术联想力，从看似平凡普通的细微小事中发掘深刻的哲理。', 'Wénxué chuàngzuò xūyào zuòzhě yōngyǒu mǐnruì xìnì de shēnghuó gǎnzhīlì yǔ fēngfù de yìshù liánxiǎnglì, cóng kànsì píngfán pǔtōng de xìwēi xiǎoshì zhōng fājué shēnkè de zhélǐ.', 'Sáng tác văn học đòi hỏi người viết phải sở hữu năng lực cảm thụ cuộc sống nhạy bén tinh tế và trí tưởng tượng liên tưởng nghệ thuật phong phú, từ những việc nhỏ bé tưởng chừng bình dị khai phá ra triết lý sâu sắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4dccbcda-aa22-492d-bef2-91f791adbc70'
);

-- [晾] (liàng): phơi, hong gió
UPDATE public.vocabularies
SET example_hanzi = '趁着初夏阳光明媚晴空万里，母亲把洗得干干净净的一床床纯棉被褥搬到院子里的竹竿上晾晒。',
    example_pinyin = 'Chèn zhe chūxià yángguāng míngmèi qíngkōng-wànlǐ, mǔqīn bǎ xǐ de gāngān-jìngjìng de yì chuáng chuáng chúnmián bèirù bān dào yuànzi lǐ de zhúgān shang liàngshài.',
    example_vi = 'Nhân lúc đầu hè nắng vàng rực rỡ trời quang mây tạnh, người mẹ đem từng chiếc chăn đệm cotton nguyên chất đã giặt sạch bong ra phơi hong nắng trên sào tre ngoài sân.'
WHERE id = 'dc801ed9-8917-4c45-b522-5cf03d31bfe5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dc801ed9-8917-4c45-b522-5cf03d31bfe5', '趁着初夏阳光明媚晴空万里，母亲把洗得干干净净的一床床纯棉被褥搬到院子里的竹竿上晾晒。', 'Chèn zhe chūxià yángguāng míngmèi qíngkōng-wànlǐ, mǔqīn bǎ xǐ de gāngān-jìngjìng de yì chuáng chuáng chúnmián bèirù bān dào yuànzi lǐ de zhúgān shang liàngshài.', 'Nhân lúc đầu hè nắng vàng rực rỡ trời quang mây tạnh, người mẹ đem từng chiếc chăn đệm cotton nguyên chất đã giặt sạch bong ra phơi hong nắng trên sào tre ngoài sân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dc801ed9-8917-4c45-b522-5cf03d31bfe5'
);

-- [立场] (lìchǎng): lập trường
UPDATE public.vocabularies
SET example_hanzi = '在涉及国家主权完整与核心安全利益的重大原则问题上，各级外交部门必须保持清醒坚定、绝不退让的基本政治立场。',
    example_pinyin = 'Zài shèjí guójiā zhǔquán wánzhěng yǔ héxīn ānquán lìyì de zhòngdà yuánzé wèntí shang, gè jí wàijiāo bùmén bìxū bǎochí qīngxǐng jiāndìng, jué bú tuìràng de jīběn zhèngzhì lìchǎng.',
    example_vi = 'Trước các vấn đề nguyên tắc trọng đại liên quan tới chủ quyền toàn vẹn và lợi ích an ninh cốt lõi của quốc gia, các cơ quan ngoại giao phải duy trì lập trường chính trị cơ bản tỉnh táo kiên định và tuyệt đối không nhượng bộ.'
WHERE id = '2c093bf4-75b8-44e0-aa49-2798e923b755' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2c093bf4-75b8-44e0-aa49-2798e923b755', '在涉及国家主权完整与核心安全利益的重大原则问题上，各级外交部门必须保持清醒坚定、绝不退让的基本政治立场。', 'Zài shèjí guójiā zhǔquán wánzhěng yǔ héxīn ānquán lìyì de zhòngdà yuánzé wèntí shang, gè jí wàijiāo bùmén bìxū bǎochí qīngxǐng jiāndìng, jué bú tuìràng de jīběn zhèngzhì lìchǎng.', 'Trước các vấn đề nguyên tắc trọng đại liên quan tới chủ quyền toàn vẹn và lợi ích an ninh cốt lõi của quốc gia, các cơ quan ngoại giao phải duy trì lập trường chính trị cơ bản tỉnh táo kiên định và tuyệt đối không nhượng bộ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2c093bf4-75b8-44e0-aa49-2798e923b755'
);

-- [淋] (lín): dầm, tưới, ướt sũng
UPDATE public.vocabularies
SET example_hanzi = '由于放学回家路上突降特大暴雨且没带雨具，他整个人被冰冷的雨水从头到脚淋得浑身湿透。',
    example_pinyin = 'Yóuyú fàngxué huíjiā lùshang tū jiàng tédà bàoyǔ qiě méi dài yǔjù, tā zhěng gè rén bèi bīnglěng de yǔshuǐ cóng tóu dào jiǎo lín de húnshēn shītòu.',
    example_vi = 'Do trên đường tan học về nhà đột ngột trút cơn mưa rào lớn lại không mang theo áo mưa hay dù, cả người anh ấy bị nước mưa buốt giá dội xối từ đầu tới chân ướt sũng như chuột lột.'
WHERE id = '832f7324-253a-41c0-b37c-92aaf2a2eec7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '832f7324-253a-41c0-b37c-92aaf2a2eec7', '由于放学回家路上突降特大暴雨且没带雨具，他整个人被冰冷的雨水从头到脚淋得浑身湿透。', 'Yóuyú fàngxué huíjiā lùshang tū jiàng tédà bàoyǔ qiě méi dài yǔjù, tā zhěng gè rén bèi bīnglěng de yǔshuǐ cóng tóu dào jiǎo lín de húnshēn shītòu.', 'Do trên đường tan học về nhà đột ngột trút cơn mưa rào lớn lại không mang theo áo mưa hay dù, cả người anh ấy bị nước mưa buốt giá dội xối từ đầu tới chân ướt sũng như chuột lột.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '832f7324-253a-41c0-b37c-92aaf2a2eec7'
);

-- [凌晨] (língchén): rạng sáng
UPDATE public.vocabularies
SET example_hanzi = '每天凌晨四点半，环卫工人便已经迎着清冽的晨风穿行在寂静街头，辛勤清扫城市道路。',
    example_pinyin = 'Měitiān língchén sì diǎn bàn, huánwèi gōngrén biàn yǐjīng yíng zhe qīngliè de chénfēng chuānxíng zài jìjìng jiētóu, xīnqín qīngsǎo chéngshì dàolù.',
    example_vi = 'Mỗi ngày vào lúc 4h30 rạng sáng, công nhân vệ sinh môi trường đã đón gió sớm se lạnh đi lại trên những góc phố yên ắng, chăm chỉ quét dọn đường sá đô thị.'
WHERE id = 'ec772fb0-01e7-4f4f-a2b3-53dfdc7d32ca' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ec772fb0-01e7-4f4f-a2b3-53dfdc7d32ca', '每天凌晨四点半，环卫工人便已经迎着清冽的晨风穿行在寂静街头，辛勤清扫城市道路。', 'Měitiān língchén sì diǎn bàn, huánwèi gōngrén biàn yǐjīng yíng zhe qīngliè de chénfēng chuānxíng zài jìjìng jiētóu, xīnqín qīngsǎo chéngshì dàolù.', 'Mỗi ngày vào lúc 4h30 rạng sáng, công nhân vệ sinh môi trường đã đón gió sớm se lạnh đi lại trên những góc phố yên ắng, chăm chỉ quét dọn đường sá đô thị.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ec772fb0-01e7-4f4f-a2b3-53dfdc7d32ca'
);

-- [流通] (liútōng): lưu thông
UPDATE public.vocabularies
SET example_hanzi = '健全现代全国统一大市场商贸物流网络体系，能够有效降低大宗工业品与农产品流通交易成本。',
    example_pinyin = 'Jiànquán xiàndài quánguó tǒngyī dà shìchǎng shāngmào wùliú wǎngluò tǐxì, nénggòu yǒuxiào jiàngdī dàzōng gōngyèpǐn yǔ nóngchǎnpǐn liútōng jiāoyì chéngběn.',
    example_vi = 'Kiện toàn hệ thống mạng lưới hậu cần thương mại thị trường lớn thống nhất toàn quốc hiện đại có thể giảm thiểu hiệu quả chi phí giao dịch lưu thông hàng công nghiệp và nông sản khối lượng lớn.'
WHERE id = '9ae43667-74ac-4257-8006-fddfcb0b02f4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9ae43667-74ac-4257-8006-fddfcb0b02f4', '健全现代全国统一大市场商贸物流网络体系，能够有效降低大宗工业品与农产品流通交易成本。', 'Jiànquán xiàndài quánguó tǒngyī dà shìchǎng shāngmào wùliú wǎngluò tǐxì, nénggòu yǒuxiào jiàngdī dàzōng gōngyèpǐn yǔ nóngchǎnpǐn liútōng jiāoyì chéngběn.', 'Kiện toàn hệ thống mạng lưới hậu cần thương mại thị trường lớn thống nhất toàn quốc hiện đại có thể giảm thiểu hiệu quả chi phí giao dịch lưu thông hàng công nghiệp và nông sản khối lượng lớn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9ae43667-74ac-4257-8006-fddfcb0b02f4'
);

-- [例外] (lìwài): ngoại lệ
UPDATE public.vocabularies
SET example_hanzi = '国家法律法规面前人人平等，任何触犯刑律者都必须依法接受严肃审判，绝没有任何人可以享有特权例外。',
    example_pinyin = 'Guójiā fǎlǜ fǎguī miànqián rénrén-píngděng, rènhé chùfàn xínglǜ zhě dōu bìxū yīfǎ jiēshòu yánsù shěnpàn, jué méiyǒu rènhé rén kěyǐ xiǎngyǒu tèquán lìwài.',
    example_vi = 'Trước pháp luật và quy định của nhà nước mọi người đều bình đẳng, bất kỳ ai phạm luật hình sự đều phải tiếp nhận xét xử nghiêm minh theo luật, tuyệt đối không ai được hưởng đặc quyền ngoại lệ.'
WHERE id = 'e2096e25-15f4-4294-a02a-c36a7605f929' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e2096e25-15f4-4294-a02a-c36a7605f929', '国家法律法规面前人人平等，任何触犯刑律者都必须依法接受严肃审判，绝没有任何人可以享有特权例外。', 'Guójiā fǎlǜ fǎguī miànqián rénrén-píngděng, rènhé chùfàn xínglǜ zhě dōu bìxū yīfǎ jiēshòu yánsù shěnpàn, jué méiyǒu rènhé rén kěyǐ xiǎngyǒu tèquán lìwài.', 'Trước pháp luật và quy định của nhà nước mọi người đều bình đẳng, bất kỳ ai phạm luật hình sự đều phải tiếp nhận xét xử nghiêm minh theo luật, tuyệt đối không ai được hưởng đặc quyền ngoại lệ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e2096e25-15f4-4294-a02a-c36a7605f929'
);

-- [利息] (lìxī): tiền lãi, lãi suất
UPDATE public.vocabularies
SET example_hanzi = '银行针对新设立的中小微科技型民营企业，推出了执行优惠基准利息的专项扶持贷款政策。',
    example_pinyin = 'Yínháng zhēnduì xīn shèlì de zhōng-xiǎo-wēi kējìxíng míngyíng qǐyè, tuīchū le zhíxíng yōuhuì jīzhǔn lìxī de zhuānxiàng fúchí dàikuǎn zhèngcè.',
    example_vi = 'Ngân hàng nhắm tới các doanh nghiệp tư nhân công nghệ vừa và nhỏ mới thành lập đã tung ra chính sách cho vay hỗ trợ chuyên đề áp dụng tiền lãi suất cơ bản ưu đãi.'
WHERE id = '5dad64ff-ebb2-4341-8431-365e5330b8e5' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5dad64ff-ebb2-4341-8431-365e5330b8e5', '银行针对新设立的中小微科技型民营企业，推出了执行优惠基准利息的专项扶持贷款政策。', 'Yínháng zhēnduì xīn shèlì de zhōng-xiǎo-wēi kējìxíng míngyíng qǐyè, tuīchū le zhíxíng yōuhuì jīzhǔn lìxī de zhuānxiàng fúchí dàikuǎn zhèngcè.', 'Ngân hàng nhắm tới các doanh nghiệp tư nhân công nghệ vừa và nhỏ mới thành lập đã tung ra chính sách cho vay hỗ trợ chuyên đề áp dụng tiền lãi suất cơ bản ưu đãi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5dad64ff-ebb2-4341-8431-365e5330b8e5'
);

-- [履行] (lǚ xíng): thực hiện, thi hành
UPDATE public.vocabularies
SET example_hanzi = '在现代国际外交与国际经济合作事务中，签约各方必须恪守契约精神、切实履行各项条约法定义务。',
    example_pinyin = 'Zài xiàndài guójì wàijiāo yǔ guójì jīngjì hézuò shìwù zhōng, qiānyuē gè fāng bìxū kèshǒu qìyuē jīngshén, qièshí lǚxíng gè xiàng tiáoyuē fǎdìng yìwù.',
    example_vi = 'Trong các công việc ngoại giao quốc tế và hợp tác kinh tế quốc tế hiện đại, các bên ký kết phải giữ vững tinh thần khế ước, thực hiện thi hành các nghĩa vụ pháp định của điều ước một cách thực chất.'
WHERE id = '20b16a24-7e8e-4a3d-bc3f-d8c14250e231' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '20b16a24-7e8e-4a3d-bc3f-d8c14250e231', '在现代国际外交与国际经济合作事务中，签约各方必须恪守契约精神、切实履行各项条约法定义务。', 'Zài xiàndài guójì wàijiāo yǔ guójì jīngjì hézuò shìwù zhōng, qiānyuē gè fāng bìxū kèshǒu qìyuē jīngshén, qièshí lǚxíng gè xiàng tiáoyuē fǎdìng yìwù.', 'Trong các công việc ngoại giao quốc tế và hợp tác kinh tế quốc tế hiện đại, các bên ký kết phải giữ vững tinh thần khế ước, thực hiện thi hành các nghĩa vụ pháp định của điều ước một cách thực chất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '20b16a24-7e8e-4a3d-bc3f-d8c14250e231'
);

-- [轮船] (lúnchuán): tàu thủy
UPDATE public.vocabularies
SET example_hanzi = '汽笛长鸣声中，满载着数千名中外游客的现代化大型豪华国际观光轮船缓缓驶离了繁忙的母港码头。',
    example_pinyin = 'Qìdí chángmíng shēng zhōng, mǎnzài zhe shùqiān míng zhōng-wài yóukè de xiàndàihuà dàxíng háohuá guójì guānguāng lúnchuán huǎnhuǎn shǐlí le fánmáng de mǔgǎng mǎtou.',
    example_vi = 'Trong hồi còi tàu vang dội kéo dài, chiếc tàu thủy du lịch quốc tế sang trọng cỡ lớn hiện đại chở hàng ngàn du khách trong và ngoài nước từ từ rời bến cảng mẹ tấp nập.'
WHERE id = '2cfc1df0-0601-4277-ad0d-fe7baa0eedc3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2cfc1df0-0601-4277-ad0d-fe7baa0eedc3', '汽笛长鸣声中，满载着数千名中外游客的现代化大型豪华国际观光轮船缓缓驶离了繁忙的母港码头。', 'Qìdí chángmíng shēng zhōng, mǎnzài zhe shùqiān míng zhōng-wài yóukè de xiàndàihuà dàxíng háohuá guójì guānguāng lúnchuán huǎnhuǎn shǐlí le fánmáng de mǔgǎng mǎtou.', 'Trong hồi còi tàu vang dội kéo dài, chiếc tàu thủy du lịch quốc tế sang trọng cỡ lớn hiện đại chở hàng ngàn du khách trong và ngoài nước từ từ rời bến cảng mẹ tấp nập.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2cfc1df0-0601-4277-ad0d-fe7baa0eedc3'
);

-- [轮流] (lúnliú): luân phiên
UPDATE public.vocabularies
SET example_hanzi = '在野外地质科学考察过程中，全体队员分成四个小组，轮流承担夜间营地安全值班与仪器监测任务。',
    example_pinyin = 'Zài yěwài dìzhì kēxué kǎochá guòchéng zhōng, quántǐ duìyuán fēnchéng sì gè xiǎozǔ, lúnliú chéngdān yèjiān yíngdì ānquán zhíbān yǔ yíqì jiānkè rènwù.',
    example_vi = 'Trong quá trình khảo sát khoa học địa chất dã ngoại, toàn thể thành viên chia thành bốn tổ nhỏ, luân phiên nhau đảm đương nhiệm vụ trực ban an toàn doanh trại và quan trắc thiết bị ban đêm.'
WHERE id = '6483445a-c02d-4a9a-82b6-952b0df7bcb0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6483445a-c02d-4a9a-82b6-952b0df7bcb0', '在野外地质科学考察过程中，全体队员分成四个小组，轮流承担夜间营地安全值班与仪器监测任务。', 'Zài yěwài dìzhì kēxué kǎochá guòchéng zhōng, quántǐ duìyuán fēnchéng sì gè xiǎozǔ, lúnliú chéngdān yèjiān yíngdì ānquán zhíbān yǔ yíqì jiānkè rènwù.', 'Trong quá trình khảo sát khoa học địa chất dã ngoại, toàn thể thành viên chia thành bốn tổ nhỏ, luân phiên nhau đảm đương nhiệm vụ trực ban an toàn doanh trại và quan trắc thiết bị ban đêm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6483445a-c02d-4a9a-82b6-952b0df7bcb0'
);

-- [论坛] (lùntán): diễn đàn
UPDATE public.vocabularies
SET example_hanzi = '由联合国与多国科研机构共同举办的世界清洁能源可持续发展高端论坛，今天在国家会议中心隆重开幕。',
    example_pinyin = 'Yóu Liánhéguó yǔ duō guó kēyán jīgòu gòngtóng jǔbàn de shìjiè qīngjié néngyuán kéchíxù fāzhǎn gāoduān lùntán, jīntiān zài guójiā huìyì zhōngxīn lóngzhòng kāimù.',
    example_vi = 'Diễn đàn cấp cao về phát triển bền vững năng lượng sạch thế giới do Liên Hợp Quốc và viện nghiên cứu nhiều nước phối hợp tổ chức đã long trọng khai mạc hôm nay tại Trung tâm Hội nghị Quốc gia.'
WHERE id = 'dc468662-d277-49fe-a0de-bd33e4b626cd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'dc468662-d277-49fe-a0de-bd33e4b626cd', '由联合国与多国科研机构共同举办的世界清洁能源可持续发展高端论坛，今天在国家会议中心隆重开幕。', 'Yóu Liánhéguó yǔ duō guó kēyán jīgòu gòngtóng jǔbàn de shìjiè qīngjié néngyuán kéchíxù fāzhǎn gāoduān lùntán, jīntiān zài guójiā huìyì zhōngxīn lóngzhòng kāimù.', 'Diễn đàn cấp cao về phát triển bền vững năng lượng sạch thế giới do Liên Hợp Quốc và viện nghiên cứu nhiều nước phối hợp tổ chức đã long trọng khai mạc hôm nay tại Trung tâm Hội nghị Quốc gia.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'dc468662-d277-49fe-a0de-bd33e4b626cd'
);

-- [落后] (luòhòu): lạc hậu, tụt hậu
UPDATE public.vocabularies
SET example_hanzi = '一个国家或民族如果不跟上时代科学技术快速进步的步伐，思想闭塞封闭，就必然会在国际竞争中落后挨打。',
    example_pinyin = 'Yí gè guójiā huò mínzú rúguǒ bù gēn shang shídài kēxué jìshù kuàisù jìnbù de bùfá, sīxiǎng bìsè fēngbì, jiù bìrán huì zài guójì jìngzhēng zhōng luòhòu ái dǎ.',
    example_vi = 'Một quốc gia hay dân tộc nếu không theo kịp bước tiến vũ bão của khoa học công nghệ thời đại, tư tưởng bế quan tỏa cảng, thì tất yếu sẽ tụt hậu lạc hậu và chịu đòn trong cuộc cạnh tranh quốc tế.'
WHERE id = 'a188080b-677c-434b-a4a0-548fa655c3b2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a188080b-677c-434b-a4a0-548fa655c3b2', '一个国家或民族如果不跟上时代科学技术快速进步的步伐，思想闭塞封闭，就必然会在国际竞争中落后挨打。', 'Yí gè guójiā huò mínzú rúguǒ bù gēn shang shídài kēxué jìshù kuàisù jìnbù de bùfá, sīxiǎng bìsè fēngbì, jiù bìrán huì zài guójì jìngzhēng zhōng luòhòu ái dǎ.', 'Một quốc gia hay dân tộc nếu không theo kịp bước tiến vũ bão của khoa học công nghệ thời đại, tư tưởng bế quan tỏa cảng, thì tất yếu sẽ tụt hậu lạc hậu và chịu đòn trong cuộc cạnh tranh quốc tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a188080b-677c-434b-a4a0-548fa655c3b2'
);

-- [嘛] (ma): mà, chứ (trợ từ)
UPDATE public.vocabularies
SET example_hanzi = '年轻人初入职场遇到挫折是在所难免的嘛，及时总结经验、重拾信心，未来依然充满着无限可能。',
    example_pinyin = 'Niánqīngrén chū rù zhíchǎng yùdào cuòzhé shì zàisuǒnánmiǎn de ma, jíshí zǒngjié jīngyàn, chóngshí xìnxīn, wèilái yīrán chōngmǎn zhe wúxiàn kěnéng.',
    example_vi = 'Người trẻ mới bước chân vào chốn công sở gặp phải trắc trở là chuyện khó tránh khỏi mà, kịp thời đúc rút kinh nghiệm, lấy lại niềm tin thì tương lai vẫn tràn ngập tiềm năng vô hạn.'
WHERE id = '9f78e464-f81f-4f70-b444-09afa1db1337' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9f78e464-f81f-4f70-b444-09afa1db1337', '年轻人初入职场遇到挫折是在所难免的嘛，及时总结经验、重拾信心，未来依然充满着无限可能。', 'Niánqīngrén chū rù zhíchǎng yùdào cuòzhé shì zàisuǒnánmiǎn de ma, jíshí zǒngjié jīngyàn, chóngshí xìnxīn, wèilái yīrán chōngmǎn zhe wúxiàn kěnéng.', 'Người trẻ mới bước chân vào chốn công sở gặp phải trắc trở là chuyện khó tránh khỏi mà, kịp thời đúc rút kinh nghiệm, lấy lại niềm tin thì tương lai vẫn tràn ngập tiềm năng vô hạn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9f78e464-f81f-4f70-b444-09afa1db1337'
);

-- [迈] (mài): sải bước, bước
UPDATE public.vocabularies
SET example_hanzi = '伴随着雄壮激昂的国歌奏响，三军仪仗队迈着整齐划一、威武雄壮的正步走过天安门广场受阅台前。',
    example_pinyin = 'Bànsuí zhe xióngzhuàng jī''áng de guógē zòuxiǎng, sānjūn yízhàngduì mài zhe zhěngqí-huàyī, wēiwǔ xióngzhuàng de zhèngbù zǒu guò Tiān''ānmén guǎngchǎng shòuyuètái qián.',
    example_vi = 'Hòa cùng tiếng quốc ca hùng tráng vang lên, đội tiêu binh danh dự ba quân sải những bước duyệt binh uy vũ đều tăm tắp đi qua trước lễ đài quảng trường Thiên An Môn.'
WHERE id = '6c763587-d03f-452b-a82d-2214c0bb96eb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6c763587-d03f-452b-a82d-2214c0bb96eb', '伴随着雄壮激昂的国歌奏响，三军仪仗队迈着整齐划一、威武雄壮的正步走过天安门广场受阅台前。', 'Bànsuí zhe xióngzhuàng jī''áng de guógē zòuxiǎng, sānjūn yízhàngduì mài zhe zhěngqí-huàyī, wēiwǔ xióngzhuàng de zhèngbù zǒu guò Tiān''ānmén guǎngchǎng shòuyuètái qián.', 'Hòa cùng tiếng quốc ca hùng tráng vang lên, đội tiêu binh danh dự ba quân sải những bước duyệt binh uy vũ đều tăm tắp đi qua trước lễ đài quảng trường Thiên An Môn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6c763587-d03f-452b-a82d-2214c0bb96eb'
);

-- [麦克风] (màikèfēng): micrô
UPDATE public.vocabularies
SET example_hanzi = '在全国青年辩论大赛决赛现场，正反双方辩手手握麦克风据理力争，妙语连珠、气氛热烈非凡。',
    example_pinyin = 'Zài quánguó qīngnián biànlùn dàsài juésài xiànchǎng, zhèng-fǎn shuāngfāng biànshǒu shǒu wò màikèfēng jùlǐ-lìzhēng, miàoyǔ-liánzhū, qìfēn rèliè fēifán.',
    example_vi = 'Tại hiện trường chung kết giải tranh biện thanh niên toàn quốc, các tranh biện viên hai phe thuận nghịch cầm micrô phân bua lý lẽ, đối đáp sắc sảo lôi cuốn, bầu không khí sôi nổi lạ thường.'
WHERE id = '38ff6ef5-caab-48ec-81cc-78c11796aa35' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '38ff6ef5-caab-48ec-81cc-78c11796aa35', '在全国青年辩论大赛决赛现场，正反双方辩手手握麦克风据理力争，妙语连珠、气氛热烈非凡。', 'Zài quánguó qīngnián biànlùn dàsài juésài xiànchǎng, zhèng-fǎn shuāngfāng biànshǒu shǒu wò màikèfēng jùlǐ-lìzhēng, miàoyǔ-liánzhū, qìfēn rèliè fēifán.', 'Tại hiện trường chung kết giải tranh biện thanh niên toàn quốc, các tranh biện viên hai phe thuận nghịch cầm micrô phân bua lý lẽ, đối đáp sắc sảo lôi cuốn, bầu không khí sôi nổi lạ thường.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '38ff6ef5-caab-48ec-81cc-78c11796aa35'
);

-- [漫长] (màncháng): dài dằng dặc, lê thê
UPDATE public.vocabularies
SET example_hanzi = '任何一项具有划时代重大意义的基础科学重大发现，往往都凝结着几代科学家历经数十年漫长寂寞的潜心探索。',
    example_pinyin = 'Rènhé yí xiàng jùyǒu huàshídài zhòngdà yìyì de jīchǔ kēxué zhòngdà fāxiàn, wǎngwǎng dōu níngjié zhe jǐ dài kēxuéjiā lìjīng shùshí nián màncháng jìmò de qiǎnxīn tànsuǒ.',
    example_vi = 'Bất kỳ phát hiện khoa học cơ bản trọng đại mang ý nghĩa thời đại nào cũng thường kết tinh từ sự miệt mài khám phá qua hàng chục năm dài dằng dặc quạnh quẽ của mấy thế hệ nhà khoa học.'
WHERE id = '588a5231-401b-440d-a0cd-0b9c0c2ca8f2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '588a5231-401b-440d-a0cd-0b9c0c2ca8f2', '任何一项具有划时代重大意义的基础科学重大发现，往往都凝结着几代科学家历经数十年漫长寂寞的潜心探索。', 'Rènhé yí xiàng jùyǒu huàshídài zhòngdà yìyì de jīchǔ kēxué zhòngdà fāxiàn, wǎngwǎng dōu níngjié zhe jǐ dài kēxuéjiā lìjīng shùshí nián màncháng jìmò de qiǎnxīn tànsuǒ.', 'Bất kỳ phát hiện khoa học cơ bản trọng đại mang ý nghĩa thời đại nào cũng thường kết tinh từ sự miệt mài khám phá qua hàng chục năm dài dằng dặc quạnh quẽ của mấy thế hệ nhà khoa học.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '588a5231-401b-440d-a0cd-0b9c0c2ca8f2'
);

-- [漫画] (mànhuà): truyện tranh, tranh biếm họa
UPDATE public.vocabularies
SET example_hanzi = '青年漫画家以敏锐幽默的艺术洞察力创作了一组生动有趣的都市生活四格幽默短篇漫画。',
    example_pinyin = 'Qīngnián mànhuàjiā yǐ mǐnruì yōumò de yìshù dòngchálì chuàngzuò le yì zǔ shēngdòng yǒuqù de dūshì shēnghuó sìgé yōumò duǎnpiān mànhuà.',
    example_vi = 'Họa sĩ truyện tranh trẻ bằng khả năng quan sát nghệ thuật hóm hỉnh nhạy bén đã sáng tác một chùm tranh truyện tranh ngắn bốn khung hài hước sinh động về cuộc sống đô thị.'
WHERE id = '7af67c63-2db1-4317-a71b-cbcf3c2f3944' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7af67c63-2db1-4317-a71b-cbcf3c2f3944', '青年漫画家以敏锐幽默的艺术洞察力创作了一组生动有趣的都市生活四格幽默短篇漫画。', 'Qīngnián mànhuàjiā yǐ mǐnruì yōumò de yìshù dòngchálì chuàngzuò le yì zǔ shēngdòng yǒuqù de dūshì shēnghuó sìgé yōumò duǎnpiān mànhuà.', 'Họa sĩ truyện tranh trẻ bằng khả năng quan sát nghệ thuật hóm hỉnh nhạy bén đã sáng tác một chùm tranh truyện tranh ngắn bốn khung hài hước sinh động về cuộc sống đô thị.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7af67c63-2db1-4317-a71b-cbcf3c2f3944'
);

-- [冒险] (màoxiǎn): mạo hiểm
UPDATE public.vocabularies
SET example_hanzi = '登山探险队员在缺乏专业防寒保暖装备与卫星定位导航的情况下，绝不可盲目冒险攀登未知的雪山冰川。',
    example_pinyin = 'Dēngshān tànxiǎnduìyuán zài quēfá zhuānyè fánghán bǎonuǎn zhuāngbèi yǔ wèixīng dìngwèi dǎoháng de qíngkuàng xià, jué bùkě mángmù màoxiǎn pāndēng wèizhī de xuěshān bīngchuān.',
    example_vi = 'Các vận động viên leo núi thám hiểm khi thiếu trang bị giữ ấm chuyên nghiệp và định vị dẫn đường vệ tinh tuyệt đối không được mạo hiểm mù quáng leo lên những dòng sông băng đỉnh tuyết chưa rõ.'
WHERE id = 'df35b351-e6be-4821-9ffc-bfbc46d46805' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'df35b351-e6be-4821-9ffc-bfbc46d46805', '登山探险队员在缺乏专业防寒保暖装备与卫星定位导航的情况下，绝不可盲目冒险攀登未知的雪山冰川。', 'Dēngshān tànxiǎnduìyuán zài quēfá zhuānyè fánghán bǎonuǎn zhuāngbèi yǔ wèixīng dìngwèi dǎoháng de qíngkuàng xià, jué bùkě mángmù màoxiǎn pāndēng wèizhī de xuěshān bīngchuān.', 'Các vận động viên leo núi thám hiểm khi thiếu trang bị giữ ấm chuyên nghiệp và định vị dẫn đường vệ tinh tuyệt đối không được mạo hiểm mù quáng leo lên những dòng sông băng đỉnh tuyết chưa rõ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'df35b351-e6be-4821-9ffc-bfbc46d46805'
);

-- [贸易] (màoyì): thương mại
UPDATE public.vocabularies
SET example_hanzi = '共建一带一路倡议极大地促进了沿线国家和地区之间基础设施互联互通与多边国际商贸贸易繁荣。',
    example_pinyin = 'Gòngjiàn Yídài-Yílù chàngyì jídà de cùjìn le yánxiàn guójiā hé dìqū zhījiān jīchǔ shèshī hùlián-hùtōng yǔ duōbiān guójì shāngmào màoyì fánróng.',
    example_vi = 'Sáng kiến cùng xây dựng Vành đai và Con đường đã thúc đẩy mạnh mẽ sự kết nối cơ sở hạ tầng và phồn vinh mậu dịch thương mại quốc tế đa phương giữa các quốc gia và vùng lãnh thổ dọc tuyến.'
WHERE id = 'b7b79b72-110a-4493-8814-32cdf8eafb59' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b7b79b72-110a-4493-8814-32cdf8eafb59', '共建一带一路倡议极大地促进了沿线国家和地区之间基础设施互联互通与多边国际商贸贸易繁荣。', 'Gòngjiàn Yídài-Yílù chàngyì jídà de cùjìn le yánxiàn guójiā hé dìqū zhījiān jīchǔ shèshī hùlián-hùtōng yǔ duōbiān guójì shāngmào màoyì fánróng.', 'Sáng kiến cùng xây dựng Vành đai và Con đường đã thúc đẩy mạnh mẽ sự kết nối cơ sở hạ tầng và phồn vinh mậu dịch thương mại quốc tế đa phương giữa các quốc gia và vùng lãnh thổ dọc tuyến.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b7b79b72-110a-4493-8814-32cdf8eafb59'
);

-- [码头] (mǎtou): bến tàu, bến cảng
UPDATE public.vocabularies
SET example_hanzi = '晨曦微露时分，繁忙的渔港客运客货混装码头上已经排满了整装待发、准备出海捕捞作业的各种渔船。',
    example_pinyin = 'Chénxī wēilù shífēn, fánmáng de yúgǎng kèyùn kè-huò hùnzhuāng mǎtou shang yǐjīng pái mǎn le zhěngzhuāng-dàifā, zhǔnbèi chūhǎi bǔláo zuòyè de gè zhǒng yúchuán.',
    example_vi = 'Thời khắc bình minh hé rạng, trên bến tàu bốc dỡ hàng khách hỗn hợp tấp nập của cảng cá đã đỗ đầy các loại tàu đánh cá xếp hàng sẵn sàng ra khơi đánh bắt.'
WHERE id = '476908c2-e166-4123-8be3-d92003959ccd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '476908c2-e166-4123-8be3-d92003959ccd', '晨曦微露时分，繁忙的渔港客运客货混装码头上已经排满了整装待发、准备出海捕捞作业的各种渔船。', 'Chénxī wēilù shífēn, fánmáng de yúgǎng kèyùn kè-huò hùnzhuāng mǎtou shang yǐjīng pái mǎn le zhěngzhuāng-dàifā, zhǔnbèi chūhǎi bǔláo zuòyè de gè zhǒng yúchuán.', 'Thời khắc bình minh hé rạng, trên bến tàu bốc dỡ hàng khách hỗn hợp tấp nập của cảng cá đã đỗ đầy các loại tàu đánh cá xếp hàng sẵn sàng ra khơi đánh bắt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '476908c2-e166-4123-8be3-d92003959ccd'
);

-- [蚂蚁] (mǎyǐ): con kiến
UPDATE public.vocabularies
SET example_hanzi = '微小的蚂蚁在炎热夏日的泥土草丛间井然有序、不知疲倦地搬运着比自身体重重数倍的面包碎屑。',
    example_pinyin = 'Wēixiǎo de mǎyǐ zài yánrè xiàrì de nítǔ cǎocóng jiān jǐngrán-yǒuxù, bùzhī-píjuàn de bānyùn zhe bǐ zìshēn tǐzhòng zhòng shù bèi de miànbāo suìxiè.',
    example_vi = 'Những chú kiến bé nhỏ trong bụi cỏ đất cát ngày hè oi ả trật tự ngăn nắp, mải miết tha những mẩu vụn bánh mì nặng gấp nhiều lần trọng lượng cơ thể mình.'
WHERE id = '20f71df3-083b-4a15-8dd1-e6c86d52d0c1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '20f71df3-083b-4a15-8dd1-e6c86d52d0c1', '微小的蚂蚁在炎热夏日的泥土草丛间井然有序、不知疲倦地搬运着比自身体重重数倍的面包碎屑。', 'Wēixiǎo de mǎyǐ zài yánrè xiàrì de nítǔ cǎocóng jiān jǐngrán-yǒuxù, bùzhī-píjuàn de bānyùn zhe bǐ zìshēn tǐzhòng zhòng shù bèi de miànbāo suìxiè.', 'Những chú kiến bé nhỏ trong bụi cỏ đất cát ngày hè oi ả trật tự ngăn nắp, mải miết tha những mẩu vụn bánh mì nặng gấp nhiều lần trọng lượng cơ thể mình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '20f71df3-083b-4a15-8dd1-e6c86d52d0c1'
);

-- [美观] (měi guān): đẹp mắt, mỹ quan
UPDATE public.vocabularies
SET example_hanzi = '新落成的城市图书馆综合体建筑造型别致新颖，内部功能分区合理，既实用耐用又十分现代美观。',
    example_pinyin = 'Xīn luòchéng de chéngshì túshūguǎn zōnghétǐ jiànzhù zàoxíng biézhì xīnyǐng, nèibù gōngnéng fēnqū hélǐ, jì shíyòng nàiyòng yòu shífēn xiàndài měiguān.',
    example_vi = 'Tổ hợp công trình thư viện thành phố mới khánh thành tạo hình độc đáo mới lạ, phân khu chức năng bên trong hợp lý, vừa thiết thực bền bỉ lại vừa mang tính thẩm mỹ mỹ quan hiện đại.'
WHERE id = '86036014-90bb-4277-b09d-5d747ade2937' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '86036014-90bb-4277-b09d-5d747ade2937', '新落成的城市图书馆综合体建筑造型别致新颖，内部功能分区合理，既实用耐用又十分现代美观。', 'Xīn luòchéng de chéngshì túshūguǎn zōnghétǐ jiànzhù zàoxíng biézhì xīnyǐng, nèibù gōngnéng fēnqū hélǐ, jì shíyòng nàiyòng yòu shífēn xiàndài měiguān.', 'Tổ hợp công trình thư viện thành phố mới khánh thành tạo hình độc đáo mới lạ, phân khu chức năng bên trong hợp lý, vừa thiết thực bền bỉ lại vừa mang tính thẩm mỹ mỹ quan hiện đại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '86036014-90bb-4277-b09d-5d747ade2937'
);

-- [眉毛] (méimao): lông mày
UPDATE public.vocabularies
SET example_hanzi = '听到这个匪夷所思、破绽百出的荒谬借口，正在主持分析会的项目主管不由自主地微微皱起了两道浓密的眉毛。',
    example_pinyin = 'Tīngdào zhè gè fěiyísuǒsī, pòzhàn-bǎichū de huāngmiù jièkǒu, zhèngzài zhǔchí fēnxīhuì de xiàngmù zhǔguǎn bùyóu-zìzhǔ de wēiwēi zhòu qǐ le liǎng dào nóngmì de méimao.',
    example_vi = 'Nghe cái cớ hoang đường sơ hở trăm bề không thể tưởng tượng nổi này, người chủ quản dự án đang chủ trì cuộc họp phân tích bất giác hơi nhíu chặt đôi lông mày rậm rạp.'
WHERE id = 'bb2f532a-2507-4b53-ac85-e062e4acd137' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bb2f532a-2507-4b53-ac85-e062e4acd137', '听到这个匪夷所思、破绽百出的荒谬借口，正在主持分析会的项目主管不由自主地微微皱起了两道浓密的眉毛。', 'Tīngdào zhè gè fěiyísuǒsī, pòzhàn-bǎichū de huāngmiù jièkǒu, zhèngzài zhǔchí fēnxīhuì de xiàngmù zhǔguǎn bùyóu-zìzhǔ de wēiwēi zhòu qǐ le liǎng dào nóngmì de méimao.', 'Nghe cái cớ hoang đường sơ hở trăm bề không thể tưởng tượng nổi này, người chủ quản dự án đang chủ trì cuộc họp phân tích bất giác hơi nhíu chặt đôi lông mày rậm rạp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bb2f532a-2507-4b53-ac85-e062e4acd137'
);

-- [弥补] (mí bǔ): bù đắp
UPDATE public.vocabularies
SET example_hanzi = '唯有依靠后天日复一日坚持不懈的刻苦勤奋学习，才能有效弥补先天专业基础知识上的暂时薄弱差距。',
    example_pinyin = 'Wéiyǒu yīkào hòutiān rìfùyírì jiānchí-búxiè de kèkǔ qínfèn xuéxí, cái néng yǒuxiào míbǔ xiāntiān zhuānyè jīchǔ zhīshi shang de zànshí bóruò chājù.',
    example_vi = 'Chỉ có dựa vào sự học tập chăm chỉ cần cù kiên trì không ngừng nghỉ ngày này qua tháng khác mới có thể bù đắp hiệu quả khoảng cách yếu kém tạm thời về tri thức cơ sở chuyên môn bẩm sinh.'
WHERE id = '91ef748d-aa68-4ec5-bedf-3c69773e7d51' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '91ef748d-aa68-4ec5-bedf-3c69773e7d51', '唯有依靠后天日复一日坚持不懈的刻苦勤奋学习，才能有效弥补先天专业基础知识上的暂时薄弱差距。', 'Wéiyǒu yīkào hòutiān rìfùyírì jiānchí-búxiè de kèkǔ qínfèn xuéxí, cái néng yǒuxiào míbǔ xiāntiān zhuānyè jīchǔ zhīshi shang de zànshí bóruò chājù.', 'Chỉ có dựa vào sự học tập chăm chỉ cần cù kiên trì không ngừng nghỉ ngày này qua tháng khác mới có thể bù đắp hiệu quả khoảng cách yếu kém tạm thời về tri thức cơ sở chuyên môn bẩm sinh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '91ef748d-aa68-4ec5-bedf-3c69773e7d51'
);

-- [勉强] (miǎnqiǎng): miễn cưỡng, gượng gạo
UPDATE public.vocabularies
SET example_hanzi = '虽然身体感到有些疲惫困倦，但为了按时完成今晚必须提交的项目申报材料，他还是勉强支撑着加完了班。',
    example_pinyin = 'Suīrán shēntǐ gǎndào yǒuxiē píbèi kùnjuàn, dàn wèile ànshí wánchéng jīnwǎn bìxū tíjiāo de xiàngmù shēnbào cáiliào, tā háishì miǎnqiǎng zhīchēng zhe jiā wán le bān.',
    example_vi = 'Mặc dù cơ thể cảm thấy đôi chút mệt mỏi buồn ngủ, nhưng để hoàn thành đúng hạn tài liệu báo cáo dự án phải nộp tối nay, anh ấy vẫn gượng gạo miễn cưỡng gắng gượng làm thêm giờ xong xuôi.'
WHERE id = '2f281f34-8a21-4c59-9173-4739c22e738b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2f281f34-8a21-4c59-9173-4739c22e738b', '虽然身体感到有些疲惫困倦，但为了按时完成今晚必须提交的项目申报材料，他还是勉强支撑着加完了班。', 'Suīrán shēntǐ gǎndào yǒuxiē píbèi kùnjuàn, dàn wèile ànshí wánchéng jīnwǎn bìxū tíjiāo de xiàngmù shēnbào cáiliào, tā háishì miǎnqiǎng zhīchēng zhe jiā wán le bān.', 'Mặc dù cơ thể cảm thấy đôi chút mệt mỏi buồn ngủ, nhưng để hoàn thành đúng hạn tài liệu báo cáo dự án phải nộp tối nay, anh ấy vẫn gượng gạo miễn cưỡng gắng gượng làm thêm giờ xong xuôi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2f281f34-8a21-4c59-9173-4739c22e738b'
);

-- [免疫] (miǎnyì): miễn dịch
UPDATE public.vocabularies
SET example_hanzi = '儿童按照国家免疫规划程序定期接种各类疫苗，是筑牢群体公共卫生防线、有效抵御传染病的根本举措。',
    example_pinyin = 'Értóng ànzhào guójiā miǎnyì guīhuà chéngxù dìngqī jiēzhòng gè lèi yìmiáo, shì zhù láo qúntǐ gōnggòng wèishēng fángxiàn, yǒuxiào dǐyù chuánrǎnbìng de gēnběn jǔcuò.',
    example_vi = 'Trẻ em tiêm chủng định kỳ các loại vắc-xin theo quy trình tiêm chủng mở rộng quốc gia là giải pháp căn bản xây dựng phòng tuyến vệ sinh công cộng vững chắc để kháng cự phòng bệnh truyền nhiễm hiệu quả.'
WHERE id = 'c3762874-f168-456c-9c7b-525552da2583' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c3762874-f168-456c-9c7b-525552da2583', '儿童按照国家免疫规划程序定期接种各类疫苗，是筑牢群体公共卫生防线、有效抵御传染病的根本举措。', 'Értóng ànzhào guójiā miǎnyì guīhuà chéngxù dìngqī jiēzhòng gè lèi yìmiáo, shì zhù láo qúntǐ gōnggòng wèishēng fángxiàn, yǒuxiào dǐyù chuánrǎnbìng de gēnběn jǔcuò.', 'Trẻ em tiêm chủng định kỳ các loại vắc-xin theo quy trình tiêm chủng mở rộng quốc gia là giải pháp căn bản xây dựng phòng tuyến vệ sinh công cộng vững chắc để kháng cự phòng bệnh truyền nhiễm hiệu quả.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c3762874-f168-456c-9c7b-525552da2583'
);

-- [面子] (miànzi): thể diện, mặt mũi
UPDATE public.vocabularies
SET example_hanzi = '在处理重大家庭矛盾纠纷时应当讲究实事求是与理性沟通，绝不能单纯为了虚荣的面子而激化彼此隔阂。',
    example_pinyin = 'Zài chǔlǐ zhòngdà jiātíng máodùn jiūfēn shí yīngdāng jiǎngjiu shíshì-qiúshì yǔ lǐxìng gōutōng, jué bùnéng dānchún wèile xūróng de miànzi ér jīhuà bǐcǐ géhé.',
    example_vi = 'Khi giải quyết mâu thuẫn tranh chấp gia đình trọng đại cần chú trọng cầu thị và giao tiếp lý tính, tuyệt đối không thể đơn thuần vì sĩ diện thể diện hão huyền mà làm gay gắt thêm khoảng cách bất đồng.'
WHERE id = 'e3496c9c-a2cc-447a-84fd-8959bf078f40' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e3496c9c-a2cc-447a-84fd-8959bf078f40', '在处理重大家庭矛盾纠纷时应当讲究实事求是与理性沟通，绝不能单纯为了虚荣的面子而激化彼此隔阂。', 'Zài chǔlǐ zhòngdà jiātíng máodùn jiūfēn shí yīngdāng jiǎngjiu shíshì-qiúshì yǔ lǐxìng gōutōng, jué bùnéng dānchún wèile xūróng de miànzi ér jīhuà bǐcǐ géhé.', 'Khi giải quyết mâu thuẫn tranh chấp gia đình trọng đại cần chú trọng cầu thị và giao tiếp lý tính, tuyệt đối không thể đơn thuần vì sĩ diện thể diện hão huyền mà làm gay gắt thêm khoảng cách bất đồng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e3496c9c-a2cc-447a-84fd-8959bf078f40'
);

-- [描绘] (miáo huì): miêu tả, khắc họa
UPDATE public.vocabularies
SET example_hanzi = '长篇历史小说作者以生动细腻传神的生花妙笔，生动描绘了北宋都城汴京清明时节市井繁荣的风俗画卷。',
    example_pinyin = 'Chángpiān lìshǐ xiǎoshuō zuòzhě yǐ shēngdòng xìnì chuánshén de shēnghuā-miàobǐ, shēngdòng miáohuì le Běisòng dūchéng Biànjīng Qīngmíng shíjié shìjǐng fánróng de fēngsú huàjuàn.',
    example_vi = 'Tác giả tiểu thuyết lịch sử dài tập bằng ngòi bút thần kỳ sinh động tinh tế đã khắc họa miêu tả bức tranh phong tục phồn vinh nhộn nhịp nơi kinh đô Biện Kinh thời Bắc Tống vào tiết Thanh minh.'
WHERE id = '456b5518-33fb-440a-b640-1d6d7c9a4877' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '456b5518-33fb-440a-b640-1d6d7c9a4877', '长篇历史小说作者以生动细腻传神的生花妙笔，生动描绘了北宋都城汴京清明时节市井繁荣的风俗画卷。', 'Chángpiān lìshǐ xiǎoshuō zuòzhě yǐ shēngdòng xìnì chuánshén de shēnghuā-miàobǐ, shēngdòng miáohuì le Běisòng dūchéng Biànjīng Qīngmíng shíjié shìjǐng fánróng de fēngsú huàjuàn.', 'Tác giả tiểu thuyết lịch sử dài tập bằng ngòi bút thần kỳ sinh động tinh tế đã khắc họa miêu tả bức tranh phong tục phồn vinh nhộn nhịp nơi kinh đô Biện Kinh thời Bắc Tống vào tiết Thanh minh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '456b5518-33fb-440a-b640-1d6d7c9a4877'
);

-- [描写] (miáoxiě): miêu tả
UPDATE public.vocabularies
SET example_hanzi = '这篇抒情散文用细腻传神的优美文字，生动描写了江南水乡初春时节烟雨蒙蒙、杏花微雨的诗意画卷。',
    example_pinyin = 'Zhè piān shūqíng sǎnwén yòng xìnì chuánshén de yōuměi wénzì, shēngdòng miáoxiě le Jiāngnán shuǐxiāng chūchūn shíjié yānyǔ-méngméng, xìnghuā-wēiyǔ de shīyì huàjuàn.',
    example_vi = 'Bài tản văn trữ tình này bằng câu chữ trau chuốt tinh tế sinh động đã miêu tả khắc họa bức tranh thơ mộng mưa phùn giăng mắc hoa hạnh lất phất của miền sông nước Giang Nam thuở đầu xuân.'
WHERE id = 'edb6cded-725c-4d83-be55-520ba102dc44' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'edb6cded-725c-4d83-be55-520ba102dc44', '这篇抒情散文用细腻传神的优美文字，生动描写了江南水乡初春时节烟雨蒙蒙、杏花微雨的诗意画卷。', 'Zhè piān shūqíng sǎnwén yòng xìnì chuánshén de yōuměi wénzì, shēngdòng miáoxiě le Jiāngnán shuǐxiāng chūchūn shíjié yānyǔ-méngméng, xìnghuā-wēiyǔ de shīyì huàjuàn.', 'Bài tản văn trữ tình này bằng câu chữ trau chuốt tinh tế sinh động đã miêu tả khắc họa bức tranh thơ mộng mưa phùn giăng mắc hoa hạnh lất phất của miền sông nước Giang Nam thuở đầu xuân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'edb6cded-725c-4d83-be55-520ba102dc44'
);

-- [密度] (mìdù): mật độ
UPDATE public.vocabularies
SET example_hanzi = '超高层建筑地下基坑工程必须严格控制混凝土浇筑振捣密度，确保地基基础结构坚如磐石、万无一失。',
    example_pinyin = 'Chāo gāocéng jiànzhù dìxià jīkēng gōngchéng bìxū yángé kòngzhì hùnníngtǔ jiāozhù zhèndǎo mìdù, quèbǎo dìjī jīchǔ jiégòu jiānrúpánshí, wànwúyìshī.',
    example_vi = 'Công trình hố móng ngầm tòa nhà siêu cao tầng phải kiểm soát nghiêm ngặt mật độ đầm rung đổ bê tông nhằm bảo đảm kết cấu móng vững như bàn thạch không một chút sai sót.'
WHERE id = '0cd0e35c-5c44-4c81-bb93-438a300ff2dc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0cd0e35c-5c44-4c81-bb93-438a300ff2dc', '超高层建筑地下基坑工程必须严格控制混凝土浇筑振捣密度，确保地基基础结构坚如磐石、万无一失。', 'Chāo gāocéng jiànzhù dìxià jīkēng gōngchéng bìxū yángé kòngzhì hùnníngtǔ jiāozhù zhèndǎo mìdù, quèbǎo dìjī jīchǔ jiégòu jiānrúpánshí, wànwúyìshī.', 'Công trình hố móng ngầm tòa nhà siêu cao tầng phải kiểm soát nghiêm ngặt mật độ đầm rung đổ bê tông nhằm bảo đảm kết cấu móng vững như bàn thạch không một chút sai sót.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0cd0e35c-5c44-4c81-bb93-438a300ff2dc'
);

-- [蜜蜂] (mìfēng): con ong
UPDATE public.vocabularies
SET example_hanzi = '明媚温暖的春日清晨，成群结队勤劳的小蜜蜂在五彩斑斓的百花丛中忙碌地飞来飞去采集花粉。',
    example_pinyin = 'Míngmèi wēnnuǎn de chūnrì qīngchén, chéngqún-jiéduì qínláo de xiǎo mìfēng zài wǔcǎi-bānlán de bǎihuā cóng zhōng mánglù de fēilái-fēiqù cǎijí huāfěn.',
    example_vi = 'Sáng mùa xuân ấm áp rực rỡ, từng đàn ong mật chăm chỉ bay đi lượn lại tất bật giữa rừng hoa muôn màu muôn sắc để thu thập phấn hoa.'
WHERE id = 'df062d57-9a6a-4c2e-86a2-eefedaf93415' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'df062d57-9a6a-4c2e-86a2-eefedaf93415', '明媚温暖的春日清晨，成群结队勤劳的小蜜蜂在五彩斑斓的百花丛中忙碌地飞来飞去采集花粉。', 'Míngmèi wēnnuǎn de chūnrì qīngchén, chéngqún-jiéduì qínláo de xiǎo mìfēng zài wǔcǎi-bānlán de bǎihuā cóng zhōng mánglù de fēilái-fēiqù cǎijí huāfěn.', 'Sáng mùa xuân ấm áp rực rỡ, từng đàn ong mật chăm chỉ bay đi lượn lại tất bật giữa rừng hoa muôn màu muôn sắc để thu thập phấn hoa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'df062d57-9a6a-4c2e-86a2-eefedaf93415'
);

-- [名额] (míng'é): chỉ tiêu, suất
UPDATE public.vocabularies
SET example_hanzi = '由于今年全省高校优秀青年骨干教师出国公派访学名额十分有限，选拔评审竞争格外激烈。',
    example_pinyin = 'Yóuyú jīnnián quánshěng gāoxiào yōuxiù qīngnián gǔgàn jiàoshī chūguó gōngpài fǎngxué míng''é shífēn yǒuxiàn, xuǎnbá píngshěn jìngzhēng géwài jīliè.',
    example_vi = 'Do năm nay số lượng chỉ tiêu suất cử đi học tập nghiên cứu tại nước ngoài bằng ngân sách nhà nước của giảng viên trẻ ưu tú toàn tỉnh rất có hạn nên cuộc xét chọn cạnh tranh vô cùng khốc liệt.'
WHERE id = 'ee73f78a-b1fb-4c57-b09f-11e7f152a718' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ee73f78a-b1fb-4c57-b09f-11e7f152a718', '由于今年全省高校优秀青年骨干教师出国公派访学名额十分有限，选拔评审竞争格外激烈。', 'Yóuyú jīnnián quánshěng gāoxiào yōuxiù qīngnián gǔgàn jiàoshī chūguó gōngpài fǎngxué míng''é shífēn yǒuxiàn, xuǎnbá píngshěn jìngzhēng géwài jīliè.', 'Do năm nay số lượng chỉ tiêu suất cử đi học tập nghiên cứu tại nước ngoài bằng ngân sách nhà nước của giảng viên trẻ ưu tú toàn tỉnh rất có hạn nên cuộc xét chọn cạnh tranh vô cùng khốc liệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ee73f78a-b1fb-4c57-b09f-11e7f152a718'
);

-- [命令] (mìnglìng): mệnh lệnh, ra lệnh
UPDATE public.vocabularies
SET example_hanzi = '在执行重大森林火灾扑救抢险的危急关头，前方指挥部下达了立刻撤离危险火场的紧急疏散命令。',
    example_pinyin = 'Zài zhíxíng zhòngdà sēnlín huǒzāi pūjiù qiǎngxiǎn de wēijí guāntóu, qiánfāng zhǐhuībù xiàdá le lìkè chèlí wēixiǎn huǒchǎng de jǐnjí shūsàn mìnglìng.',
    example_vi = 'Giữa thời khắc nguy kịch triển khai dập tắt đám cháy rừng trọng đại, sở chỉ huy tiền phương đã ban hành mệnh lệnh sơ tán khẩn cấp rút lui ngay khỏi hiện trường nguy hiểm.'
WHERE id = 'c5412253-a81e-42f9-9bb4-9d8bac98bf60' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c5412253-a81e-42f9-9bb4-9d8bac98bf60', '在执行重大森林火灾扑救抢险的危急关头，前方指挥部下达了立刻撤离危险火场的紧急疏散命令。', 'Zài zhíxíng zhòngdà sēnlín huǒzāi pūjiù qiǎngxiǎn de wēijí guāntóu, qiánfāng zhǐhuībù xiàdá le lìkè chèlí wēixiǎn huǒchǎng de jǐnjí shūsàn mìnglìng.', 'Giữa thời khắc nguy kịch triển khai dập tắt đám cháy rừng trọng đại, sở chỉ huy tiền phương đã ban hành mệnh lệnh sơ tán khẩn cấp rút lui ngay khỏi hiện trường nguy hiểm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c5412253-a81e-42f9-9bb4-9d8bac98bf60'
);

-- [明明] (míngmíng): rõ ràng, rành rành
UPDATE public.vocabularies
SET example_hanzi = '出门前明明看见家门钥匙就端端正正放在玄关鞋柜上，这会儿翻遍了公文包却怎么也找不到了。',
    example_pinyin = 'Chūmén qián míngmíng kànjiàn jiāmén yàoshi jiù duānduān-zhèngzhèng fàng zài xuánguān xiéguì shang, zhè huìr fān biàn le gōngwénbāo què zěnme yě zhǎo bú dào le.',
    example_vi = 'Trước khi ra khỏi nhà rõ ràng rành rành trông thấy chìa khóa nhà đặt ngay ngắn trên tủ giày tiền sảnh, thế mà lúc này bới tung cả chiếc cặp đi làm lên lại chẳng thấy đâu.'
WHERE id = '116f12c5-1f4c-4dd0-a3ae-cb31dbb9a166' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '116f12c5-1f4c-4dd0-a3ae-cb31dbb9a166', '出门前明明看见家门钥匙就端端正正放在玄关鞋柜上，这会儿翻遍了公文包却怎么也找不到了。', 'Chūmén qián míngmíng kànjiàn jiāmén yàoshi jiù duānduān-zhèngzhèng fàng zài xuánguān xiéguì shang, zhè huìr fān biàn le gōngwénbāo què zěnme yě zhǎo bú dào le.', 'Trước khi ra khỏi nhà rõ ràng rành rành trông thấy chìa khóa nhà đặt ngay ngắn trên tủ giày tiền sảnh, thế mà lúc này bới tung cả chiếc cặp đi làm lên lại chẳng thấy đâu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '116f12c5-1f4c-4dd0-a3ae-cb31dbb9a166'
);

-- [命名] (mìngmíng): đặt tên
UPDATE public.vocabularies
SET example_hanzi = '国际天文学联合会正式将这颗新发现的小行星命名为中国科学家屠呦呦星，以表彰其卓越贡献。',
    example_pinyin = 'Guójì tiānwénxué liánhéhuì zhèngshì jiāng zhè kē xīn fāxiàn de xiǎoxíngxīng mìngmíng wèi Zhōngguó kēxuéjiā Tú Yōuyōu xīng, yǐ biǎozhāng qí zhuóyuè gòngxiàn.',
    example_vi = 'Hiệp hội Thiên văn Quốc tế đã chính thức đặt tên cho tiểu hành tinh mới phát hiện này là sao Đồ U U nhà khoa học Trung Quốc nhằm biểu dương những cống hiến kiệt xuất của bà.'
WHERE id = '2cb10681-3712-46a9-9f1c-69e82c76699a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2cb10681-3712-46a9-9f1c-69e82c76699a', '国际天文学联合会正式将这颗新发现的小行星命名为中国科学家屠呦呦星，以表彰其卓越贡献。', 'Guójì tiānwénxué liánhéhuì zhèngshì jiāng zhè kē xīn fāxiàn de xiǎoxíngxīng mìngmíng wèi Zhōngguó kēxuéjiā Tú Yōuyōu xīng, yǐ biǎozhāng qí zhuóyuè gòngxiàn.', 'Hiệp hội Thiên văn Quốc tế đã chính thức đặt tên cho tiểu hành tinh mới phát hiện này là sao Đồ U U nhà khoa học Trung Quốc nhằm biểu dương những cống hiến kiệt xuất của bà.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2cb10681-3712-46a9-9f1c-69e82c76699a'
);

-- [民间] (mínjiān): dân gian
UPDATE public.vocabularies
SET example_hanzi = '剪纸、皮影戏和陶瓷制作等优秀民间传统手工艺，承载着中华民族世代相传的深厚民俗文化底蕴。',
    example_pinyin = 'Jiǎnzhǐ, píyǐngxì hé táocí zhìzuò děng yōuxiù mínjiān chuántǒng shǒugōngyì, chéngzài zhe Zhōnghuá mínzú shìdài-xiāngchuán de shēnhòu mínsú wénhuà dǐyùn.',
    example_vi = 'Các nghề thủ công truyền thống dân gian ưu tú như cắt giấy, múa rối bóng và làm gốm sứ chuyên chở chiều sâu văn hóa phong tục tập quán lưu truyền qua nhiều đời của dân tộc Trung Hoa.'
WHERE id = '5ed96c62-69f6-4fd7-a61b-6bce07573ccd' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '5ed96c62-69f6-4fd7-a61b-6bce07573ccd', '剪纸、皮影戏和陶瓷制作等优秀民间传统手工艺，承载着中华民族世代相传的深厚民俗文化底蕴。', 'Jiǎnzhǐ, píyǐngxì hé táocí zhìzuò děng yōuxiù mínjiān chuántǒng shǒugōngyì, chéngzài zhe Zhōnghuá mínzú shìdài-xiāngchuán de shēnhòu mínsú wénhuà dǐyùn.', 'Các nghề thủ công truyền thống dân gian ưu tú như cắt giấy, múa rối bóng và làm gốm sứ chuyên chở chiều sâu văn hóa phong tục tập quán lưu truyền qua nhiều đời của dân tộc Trung Hoa.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '5ed96c62-69f6-4fd7-a61b-6bce07573ccd'
);

-- [民主] (mínzhǔ): dân chủ
UPDATE public.vocabularies
SET example_hanzi = '学校教职工代表大会充分发扬民主协商协商精神，群策群力审议通过了新一轮绩效工资分配方案。',
    example_pinyin = 'Xuéxiào jiàozhígōng dàibiǎo dàhuì chōngfèn fāyáng mínzhǔ xiéshāng jīngshén, qúncè-qúnlì shěnyì tōngguò le xīn yì lún jìxiào gōngzī fēnpèi fāng''àn.',
    example_vi = 'Đại hội đại biểu cán bộ giáo viên nhà trường đã phát huy đầy đủ tinh thần dân chủ hiệp thương, chung sức chung lòng thẩm tra thông qua phương án phân phối tiền lương theo hiệu quả công việc mới.'
WHERE id = '3a63111e-606b-4617-85e3-8ae1bf9bb84c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3a63111e-606b-4617-85e3-8ae1bf9bb84c', '学校教职工代表大会充分发扬民主协商协商精神，群策群力审议通过了新一轮绩效工资分配方案。', 'Xuéxiào jiàozhígōng dàibiǎo dàhuì chōngfèn fāyáng mínzhǔ xiéshāng jīngshén, qúncè-qúnlì shěnyì tōngguò le xīn yì lún jìxiào gōngzī fēnpèi fāng''àn.', 'Đại hội đại biểu cán bộ giáo viên nhà trường đã phát huy đầy đủ tinh thần dân chủ hiệp thương, chung sức chung lòng thẩm tra thông qua phương án phân phối tiền lương theo hiệu quả công việc mới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3a63111e-606b-4617-85e3-8ae1bf9bb84c'
);

-- [迷人] (mírén): mê người, quyến rũ
UPDATE public.vocabularies
SET example_hanzi = '夕阳西下的西湖两岸晚霞满天、轻舟荡漾，呈现出一幅令人流连忘返、如痴如醉的迷人黄昏画卷。',
    example_pinyin = 'Xīyáng xīxià de Xīhú liǎng''àn wǎnxiá mǎntiān, qīngzhōu dàngyàng, chéngxiàn chū yì fú lìngrén liúlián-wàngfǎn, rúchī-rúzuì de mírén huánghūn huàjuàn.',
    example_vi = 'Khi ánh tà dương buông xuống đôi bờ Tây Hồ ráng chiều ngập trời, thuyền nhỏ lững lờ trôi, hiện ra một bức tranh hoàng hôn mê đắm lòng người quyến rũ khiến ai nấy đều lưu luyến chẳng muốn rời.'
WHERE id = 'a829b1a7-c7e0-4254-85c9-3fee4d32a3bb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a829b1a7-c7e0-4254-85c9-3fee4d32a3bb', '夕阳西下的西湖两岸晚霞满天、轻舟荡漾，呈现出一幅令人流连忘返、如痴如醉的迷人黄昏画卷。', 'Xīyáng xīxià de Xīhú liǎng''àn wǎnxiá mǎntiān, qīngzhōu dàngyàng, chéngxiàn chū yì fú lìngrén liúlián-wàngfǎn, rúchī-rúzuì de mírén huánghūn huàjuàn.', 'Khi ánh tà dương buông xuống đôi bờ Tây Hồ ráng chiều ngập trời, thuyền nhỏ lững lờ trôi, hiện ra một bức tranh hoàng hôn mê đắm lòng người quyến rũ khiến ai nấy đều lưu luyến chẳng muốn rời.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a829b1a7-c7e0-4254-85c9-3fee4d32a3bb'
);

-- [模仿] (mófǎng): bắt chước, mô phỏng
UPDATE public.vocabularies
SET example_hanzi = '学龄前幼儿往往具有极强的模仿能力，家长在日常生活中应当言传身教、树立良好品德榜样。',
    example_pinyin = 'Xuélíngqián yòu''ér wǎngwǎng jùyǒu jí qiáng de mófǎng nénglì, jiāzhǎng zài rìcháng shēnghuó zhōng yīngdāng yánchuán-shēnjiào, shùlì liánghǎo pǐndé bǎngyàng.',
    example_vi = 'Trẻ em lứa tuổi mầm non thường sở hữu khả năng bắt chước mô phỏng cực kỳ mạnh mẽ, cha mẹ trong đời sống hàng ngày cần nêu gương bằng lời nói hành động để xây dựng tấm gương đạo đức tốt.'
WHERE id = '2ae6dff4-d853-4292-85ab-b70b92738aa1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2ae6dff4-d853-4292-85ab-b70b92738aa1', '学龄前幼儿往往具有极强的模仿能力，家长在日常生活中应当言传身教、树立良好品德榜样。', 'Xuélíngqián yòu''ér wǎngwǎng jùyǒu jí qiáng de mófǎng nénglì, jiāzhǎng zài rìcháng shēnghuó zhōng yīngdāng yánchuán-shēnjiào, shùlì liánghǎo pǐndé bǎngyàng.', 'Trẻ em lứa tuổi mầm non thường sở hữu khả năng bắt chước mô phỏng cực kỳ mạnh mẽ, cha mẹ trong đời sống hàng ngày cần nêu gương bằng lời nói hành động để xây dựng tấm gương đạo đức tốt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2ae6dff4-d853-4292-85ab-b70b92738aa1'
);

-- [默默] (mòmò): im lặng, lặng lẽ
UPDATE public.vocabularies
SET example_hanzi = '许多乡村邮递员几十年如一日骑着自行车穿行在崎岖大山深处，默默守护着大山深处的通信生命线。',
    example_pinyin = 'Xǔduō xiāngcūn yóudìyuán jǐshí nián rú yírì qí zhe zìxíngchē chuānxíng zài qíqū dàshān shēnchù, mòmò shǒuhù zhe dàshān shēnchù de tōngxìn shēngmìngxiàn.',
    example_vi = 'Biết bao người đưa thư nông thôn hàng chục năm như một đạp xe đi lại giữa chốn núi non gập ghềnh, lặng lẽ âm thầm bảo vệ tuyến đường huyết mạch thông tin sâu trong lòng núi thẳm.'
WHERE id = '331e7da7-d4a6-4d2c-86d3-0b4cb6c4c4ea' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '331e7da7-d4a6-4d2c-86d3-0b4cb6c4c4ea', '许多乡村邮递员几十年如一日骑着自行车穿行在崎岖大山深处，默默守护着大山深处的通信生命线。', 'Xǔduō xiāngcūn yóudìyuán jǐshí nián rú yírì qí zhe zìxíngchē chuānxíng zài qíqū dàshān shēnchù, mòmò shǒuhù zhe dàshān shēnchù de tōngxìn shēngmìngxiàn.', 'Biết bao người đưa thư nông thôn hàng chục năm như một đạp xe đi lại giữa chốn núi non gập ghềnh, lặng lẽ âm thầm bảo vệ tuyến đường huyết mạch thông tin sâu trong lòng núi thẳm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '331e7da7-d4a6-4d2c-86d3-0b4cb6c4c4ea'
);

-- [摩托车] (mótuōchē): xe máy
UPDATE public.vocabularies
SET example_hanzi = '交警部门严厉查处未按规定佩戴安全头盔以及无牌无证驾驶摩托车上路行驶等严重交通违法行为。',
    example_pinyin = 'Jiāojǐng bùmén yánlì cháchǔ wèi àn guīdìng pèidài ānquán tóukuī yǐjí wú pái wú zhèng jiàshǐ mótuōchē shànglù xíngshǐ děng yánzhòng jiāotōng wéifǎ xíngwéi.',
    example_vi = 'Ngành cảnh sát giao thông xử lý nghiêm các hành vi vi phạm giao thông nghiêm trọng như không đội mũ bảo hiểm theo quy định và điều khiển xe máy không biển số giấy tờ tham gia giao thông.'
WHERE id = '4a7104ed-b6bf-4bfc-8419-4466a5ae3206' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4a7104ed-b6bf-4bfc-8419-4466a5ae3206', '交警部门严厉查处未按规定佩戴安全头盔以及无牌无证驾驶摩托车上路行驶等严重交通违法行为。', 'Jiāojǐng bùmén yánlì cháchǔ wèi àn guīdìng pèidài ānquán tóukuī yǐjí wú pái wú zhèng jiàshǐ mótuōchē shànglù xíngshǐ děng yánzhòng jiāotōng wéifǎ xíngwéi.', 'Ngành cảnh sát giao thông xử lý nghiêm các hành vi vi phạm giao thông nghiêm trọng như không đội mũ bảo hiểm theo quy định và điều khiển xe máy không biển số giấy tờ tham gia giao thông.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4a7104ed-b6bf-4bfc-8419-4466a5ae3206'
);

-- [模型] (móxíng): mô hình
UPDATE public.vocabularies
SET example_hanzi = '建筑学专业师生利用先进的数字化三维建模软件，制作出了这座未来绿色低碳城市综合体的实体沙盘模型。',
    example_pinyin = 'Jiànzhùxué zhuānyè shīshēng lìyòng xiānjìn de shùzìhuà sānwéi jiànmó ruǎnjiàn, zhìzuò chū le zhè zuò wèilái lǜsè dītàn chéngshì zōnghétǐ de shítǐ shāpán móxíng.',
    example_vi = 'Thầy trò chuyên ngành kiến trúc dùng phần mềm mô hình hóa 3D số hóa tiên tiến đã tạo ra mô hình sa bàn thực thể của tổ hợp đô thị xanh ít carbon trong tương lai này.'
WHERE id = '0ad1e8f1-3475-490e-9047-6e1df00af0af' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0ad1e8f1-3475-490e-9047-6e1df00af0af', '建筑学专业师生利用先进的数字化三维建模软件，制作出了这座未来绿色低碳城市综合体的实体沙盘模型。', 'Jiànzhùxué zhuānyè shīshēng lìyòng xiānjìn de shùzìhuà sānwéi jiànmó ruǎnjiàn, zhìzuò chū le zhè zuò wèilái lǜsè dītàn chéngshì zōnghétǐ de shítǐ shāpán móxíng.', 'Thầy trò chuyên ngành kiến trúc dùng phần mềm mô hình hóa 3D số hóa tiên tiến đã tạo ra mô hình sa bàn thực thể của tổ hợp đô thị xanh ít carbon trong tương lai này.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0ad1e8f1-3475-490e-9047-6e1df00af0af'
);

-- [目录] (mùlù): mục lục
UPDATE public.vocabularies
SET example_hanzi = '在翻开一本厚重的大型学术学术工具书之前，读者最好先仔细查阅全书前方的详细章节目录导航。',
    example_pinyin = 'Zài fānkāi yì běn hòuzhòng de dàxíng xuéshù xuéshù gōngjùshū zhīqián, dúzhě zuìhǎo xiān zǐxì cháyuè quán shū qiánfāng de xiángxì zhāngjié mùlù dǎoháng.',
    example_vi = 'Trước khi lật mở một cuốn sách tra cứu học thuật cỡ lớn dày cộp, độc giả tốt nhất nên tra cứu kỹ mục lục chương mục chi tiết ở phần đầu cuốn sách.'
WHERE id = 'f9be2bfb-2ee5-4825-836e-78dddb817d86' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f9be2bfb-2ee5-4825-836e-78dddb817d86', '在翻开一本厚重的大型学术学术工具书之前，读者最好先仔细查阅全书前方的详细章节目录导航。', 'Zài fānkāi yì běn hòuzhòng de dàxíng xuéshù xuéshù gōngjùshū zhīqián, dúzhě zuìhǎo xiān zǐxì cháyuè quán shū qiánfāng de xiángxì zhāngjié mùlù dǎoháng.', 'Trước khi lật mở một cuốn sách tra cứu học thuật cỡ lớn dày cộp, độc giả tốt nhất nên tra cứu kỹ mục lục chương mục chi tiết ở phần đầu cuốn sách.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f9be2bfb-2ee5-4825-836e-78dddb817d86'
);

-- [模样] (múyàng): dáng vẻ, diện mạo
UPDATE public.vocabularies
SET example_hanzi = '虽然阔别家乡已经整整三十余年，但他脑海中依然清晰地浮现着母亲当年送别自己时那慈祥温暖的模样。',
    example_pinyin = 'Suīrán kuòbié jiāxiāng yǐjīng zhěngzhěng sānshí yú nián, dàn tā nǎohǎi zhōng yīrán qīngxī de fúxiàn zhe mǔqīn dāngnián sòngbié zìjǐ shí nà cíxiáng wēnnuǎn de múyàng.',
    example_vi = 'Mặc dù xa cách quê nhà đúng hơn ba mươi năm, song trong tâm trí anh vẫn hiện lên rõ mồn một dáng vẻ diện mạo hiền từ ấm áp của người mẹ lúc tiễn mình năm ấy.'
WHERE id = '97c4fce0-4046-45e4-8812-40c928cf30fb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '97c4fce0-4046-45e4-8812-40c928cf30fb', '虽然阔别家乡已经整整三十余年，但他脑海中依然清晰地浮现着母亲当年送别自己时那慈祥温暖的模样。', 'Suīrán kuòbié jiāxiāng yǐjīng zhěngzhěng sānshí yú nián, dàn tā nǎohǎi zhōng yīrán qīngxī de fúxiàn zhe mǔqīn dāngnián sòngbié zìjǐ shí nà cíxiáng wēnnuǎn de múyàng.', 'Mặc dù xa cách quê nhà đúng hơn ba mươi năm, song trong tâm trí anh vẫn hiện lên rõ mồn một dáng vẻ diện mạo hiền từ ấm áp của người mẹ lúc tiễn mình năm ấy.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '97c4fce0-4046-45e4-8812-40c928cf30fb'
);

-- [母语] (mǔyǔ): tiếng mẹ đẻ
UPDATE public.vocabularies
SET example_hanzi = '在外语习得过程中熟练掌握母语的语法规范与深层文化内涵，有助于培养更加敏锐的跨文化交流对比思维。',
    example_pinyin = 'Zài wàiyǔ xídé guòchéng zhōng shúliàn zhǎngwò mǔyǔ de yǔfǎ guīfàn yǔ shēncéng wénhuà nèihán, yǒuzhùyú péiyǎng gèngjiā mǐnruì de kuà wénhuà jiāoliú duìbǐ sīwéi.',
    example_vi = 'Trong quá trình tiếp thu ngoại ngữ, việc nắm vững chuẩn mực ngữ pháp và nội hàm văn hóa sâu sắc của tiếng mẹ đẻ giúp nuôi dưỡng tư duy đối chiếu giao lưu đa văn hóa nhạy bén hơn.'
WHERE id = '357ce3e6-d667-4643-929a-6780e00737e3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '357ce3e6-d667-4643-929a-6780e00737e3', '在外语习得过程中熟练掌握母语的语法规范与深层文化内涵，有助于培养更加敏锐的跨文化交流对比思维。', 'Zài wàiyǔ xídé guòchéng zhōng shúliàn zhǎngwò mǔyǔ de yǔfǎ guīfàn yǔ shēncéng wénhuà nèihán, yǒuzhùyú péiyǎng gèngjiā mǐnruì de kuà wénhuà jiāoliú duìbǐ sīwéi.', 'Trong quá trình tiếp thu ngoại ngữ, việc nắm vững chuẩn mực ngữ pháp và nội hàm văn hóa sâu sắc của tiếng mẹ đẻ giúp nuôi dưỡng tư duy đối chiếu giao lưu đa văn hóa nhạy bén hơn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '357ce3e6-d667-4643-929a-6780e00737e3'
);

-- [脑袋] (nǎodai): đầu, não
UPDATE public.vocabularies
SET example_hanzi = '经过连续几个小时高度紧张的计算机编程调试工作后，他揉了揉发胀的脑袋，起立走到阳台远眺放松。',
    example_pinyin = 'Jīngguò liánxù jǐ gè xiǎoshí gāodù jǐnzhāng de jìsuànjī biānchéng tiáoshì gōngzuò hòu, tā róu le róu fāzhàng de nǎodai, qǐlì zǒu dào yángtái yuǎntiào fàngsōng.',
    example_vi = 'Sau nhiều giờ đồng hồ lập trình sửa lỗi máy tính căng thẳng cao độ, anh ấy xoa xoa cái đầu đang căng tức, đứng dậy bước ra ban công nhìn xa thư giãn.'
WHERE id = 'ecb3153e-d41c-4517-8cb8-0c8a7271070c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ecb3153e-d41c-4517-8cb8-0c8a7271070c', '经过连续几个小时高度紧张的计算机编程调试工作后，他揉了揉发胀的脑袋，起立走到阳台远眺放松。', 'Jīngguò liánxù jǐ gè xiǎoshí gāodù jǐnzhāng de jìsuànjī biānchéng tiáoshì gōngzuò hòu, tā róu le róu fāzhàng de nǎodai, qǐlì zǒu dào yángtái yuǎntiào fàngsōng.', 'Sau nhiều giờ đồng hồ lập trình sửa lỗi máy tính căng thẳng cao độ, anh ấy xoa xoa cái đầu đang căng tức, đứng dậy bước ra ban công nhìn xa thư giãn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ecb3153e-d41c-4517-8cb8-0c8a7271070c'
);

-- [内涵] (nèihán): nội hàm, chiều sâu tư tưởng
UPDATE public.vocabularies
SET example_hanzi = '这部文学传世名作不仅语言生动传神，而且深刻揭示了人性的崇高与复杂，具有极其深厚博大的精神文化内涵。',
    example_pinyin = 'Zhè bù wénxué chuánshì míngzuò bùjǐn yǔyán shēngdòng chuánshén, érqiě shēnkè jiēshì le rénxìng de chónggāo yǔ fùzá, jùyǒu jíqí shēnhòu bódà de jīngshén wénhuà nèihán.',
    example_vi = 'Tác phẩm văn học danh tiếng lưu truyền hậu thế này không chỉ có ngôn từ sinh động mà còn bộc lộ sâu sắc vẻ cao cả và phức tạp của nhân tính, mang nội hàm văn hóa tinh thần cực kỳ sâu rộng.'
WHERE id = '6887eee6-a08a-4dbd-a075-376f41db1c73' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6887eee6-a08a-4dbd-a075-376f41db1c73', '这部文学传世名作不仅语言生动传神，而且深刻揭示了人性的崇高与复杂，具有极其深厚博大的精神文化内涵。', 'Zhè bù wénxué chuánshì míngzuò bùjǐn yǔyán shēngdòng chuánshén, érqiě shēnkè jiēshì le rénxìng de chónggāo yǔ fùzá, jùyǒu jíqí shēnhòu bódà de jīngshén wénhuà nèihán.', 'Tác phẩm văn học danh tiếng lưu truyền hậu thế này không chỉ có ngôn từ sinh động mà còn bộc lộ sâu sắc vẻ cao cả và phức tạp của nhân tính, mang nội hàm văn hóa tinh thần cực kỳ sâu rộng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6887eee6-a08a-4dbd-a075-376f41db1c73'
);

-- [内科] (nèikē): khoa nội
UPDATE public.vocabularies
SET example_hanzi = '综合性大医院的呼吸与心血管内科专家门诊室外，一大早便排满了前来就诊复查的老年慢性病患者。',
    example_pinyin = 'Zōnghéxìng dà yīyuàn de hūxī yǔ xīn-xiěguān nèikē zhuānjiā ménzhěn shì wài, yí dà zǎo biàn pái mǎn le qiánlái jiùzhěn fùchá de lǎonián mànxìngbìng huànzhě.',
    example_vi = 'Bên ngoài phòng khám chuyên gia khoa nội hô hấp và tim mạch của bệnh viện đa khoa lớn, từ sáng sớm đã xếp hàng đông kín những bệnh nhân cao tuổi mắc bệnh mãn tính đến khám và tái khám.'
WHERE id = 'edfbb27f-903c-4017-82b2-3e3b5634eaa9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'edfbb27f-903c-4017-82b2-3e3b5634eaa9', '综合性大医院的呼吸与心血管内科专家门诊室外，一大早便排满了前来就诊复查的老年慢性病患者。', 'Zōnghéxìng dà yīyuàn de hūxī yǔ xīn-xiěguān nèikē zhuānjiā ménzhěn shì wài, yí dà zǎo biàn pái mǎn le qiánlái jiùzhěn fùchá de lǎonián mànxìngbìng huànzhě.', 'Bên ngoài phòng khám chuyên gia khoa nội hô hấp và tim mạch của bệnh viện đa khoa lớn, từ sáng sớm đã xếp hàng đông kín những bệnh nhân cao tuổi mắc bệnh mãn tính đến khám và tái khám.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'edfbb27f-903c-4017-82b2-3e3b5634eaa9'
);

-- [能量] (néng liàng): năng lượng
UPDATE public.vocabularies
SET example_hanzi = '绿色植物通过叶绿体进行光合作用，能够将太阳光辐射能高效转化为储存在有机物中的生物化学能量。',
    example_pinyin = 'Lǜsè zhíwù tōngguò yèlǜtǐ jìnxíng guānghé zuòyòng, nénggòu jiāng tàiyángguāng fúshè néng gāoxiào zhuǎnhuà wèi chǔcún zài yǒujīwù zhōng de shēngwù huàxué néngliàng.',
    example_vi = 'Cây xanh thông qua lục lạp tiến hành quang hợp có thể chuyển hóa bức xạ ánh sáng mặt trời thành năng lượng sinh hóa học dự trữ trong chất hữu cơ một cách hiệu quả.'
WHERE id = '360d44bd-6688-43f6-88ed-bd11530fa59b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '360d44bd-6688-43f6-88ed-bd11530fa59b', '绿色植物通过叶绿体进行光合作用，能够将太阳光辐射能高效转化为储存在有机物中的生物化学能量。', 'Lǜsè zhíwù tōngguò yèlǜtǐ jìnxíng guānghé zuòyòng, nénggòu jiāng tàiyángguāng fúshè néng gāoxiào zhuǎnhuà wèi chǔcún zài yǒujīwù zhōng de shēngwù huàxué néngliàng.', 'Cây xanh thông qua lục lạp tiến hành quang hợp có thể chuyển hóa bức xạ ánh sáng mặt trời thành năng lượng sinh hóa học dự trữ trong chất hữu cơ một cách hiệu quả.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '360d44bd-6688-43f6-88ed-bd11530fa59b'
);

-- [能源] (néngyuán): năng lượng, nguồn năng lượng
UPDATE public.vocabularies
SET example_hanzi = '加快构建以风力发电、太阳能光伏与储能技术为支柱的新型清洁能源体系，是实现碳中和目标的战略支撑。',
    example_pinyin = 'Jiākuài gòujiàn yǐ fēnglì fādiàn, tàiyángnéng guāngfú yǔ chǔnéng jìshù wèi zhīzhù de xīnxíng qīngjié néngyuán tǐxì, shì shíxiàn tànzhōnghé mùbiāo de zhànlüè zhīchēng.',
    example_vi = 'Đẩy nhanh xây dựng hệ thống nguồn năng lượng sạch kiểu mới lấy điện gió, điện mặt trời và công nghệ tích trữ năng lượng làm trụ cột là điểm tựa chiến lược để đạt mục tiêu trung hòa carbon.'
WHERE id = '899e11d4-b083-429b-ae12-ff3448f659cb' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '899e11d4-b083-429b-ae12-ff3448f659cb', '加快构建以风力发电、太阳能光伏与储能技术为支柱的新型清洁能源体系，是实现碳中和目标的战略支撑。', 'Jiākuài gòujiàn yǐ fēnglì fādiàn, tàiyángnéng guāngfú yǔ chǔnéng jìshù wèi zhīzhù de xīnxíng qīngjié néngyuán tǐxì, shì shíxiàn tànzhōnghé mùbiāo de zhànlüè zhīchēng.', 'Đẩy nhanh xây dựng hệ thống nguồn năng lượng sạch kiểu mới lấy điện gió, điện mặt trời và công nghệ tích trữ năng lượng làm trụ cột là điểm tựa chiến lược để đạt mục tiêu trung hòa carbon.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '899e11d4-b083-429b-ae12-ff3448f659cb'
);

-- [年度] (nián dù): niên độ, năm
UPDATE public.vocabularies
SET example_hanzi = '集团董事会在年度工作总结表彰大会上，向在关键技术攻关中做出突出贡献的优秀团队颁发了年度创新特别大奖。',
    example_pinyin = 'Jítuán dǒngshìhuì zài niándù gōngzuò zǒngjié biǎozhāng dàhuì shang, xiàng zài guānjiàn jìshù gōngguān zhōng zuòchū tūchū gòngxiàn de yōuxiù tuánduì bānfā le niándù chuàngxīn tèbié dàjiǎng.',
    example_vi = 'Hội đồng quản trị tập đoàn trong đại hội tổng kết biểu dương công tác thường niên niên độ đã trao giải thưởng lớn đặc biệt sáng tạo của năm cho đội ngũ ưu tú có đóng góp nổi bật trong nghiên cứu công nghệ then chốt.'
WHERE id = 'db687251-d180-42bb-927a-86a7d5bf9f78' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'db687251-d180-42bb-927a-86a7d5bf9f78', '集团董事会在年度工作总结表彰大会上，向在关键技术攻关中做出突出贡献的优秀团队颁发了年度创新特别大奖。', 'Jítuán dǒngshìhuì zài niándù gōngzuò zǒngjié biǎozhāng dàhuì shang, xiàng zài guānjiàn jìshù gōngguān zhōng zuòchū tūchū gòngxiàn de yōuxiù tuánduì bānfā le niándù chuàngxīn tèbié dàjiǎng.', 'Hội đồng quản trị tập đoàn trong đại hội tổng kết biểu dương công tác thường niên niên độ đã trao giải thưởng lớn đặc biệt sáng tạo của năm cho đội ngũ ưu tú có đóng góp nổi bật trong nghiên cứu công nghệ then chốt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'db687251-d180-42bb-927a-86a7d5bf9f78'
);

-- [浓厚] (nónghòu): nồng hậu, đậm nét, sâu sắc
UPDATE public.vocabularies
SET example_hanzi = '漫步在有着千年历史的古老水乡小镇青石板街道上，扑面而来的是一股浓厚醇正的江南历史民俗文化气息。',
    example_pinyin = 'Mànbù zài yǒu zhe qiānnián lìshǐ de gǔlǎo shuǐxiāng xiǎozhèn qīngshíbǎn jiēdào shang, pūmiàn''érlái de shì yì gǔ nónghòu chúnzhèng de Jiāngnán lìshǐ mínsú wénhuà qìxī.',
    example_vi = 'Tản bộ trên con đường lát đá xanh của thị trấn sông nước cổ ngàn năm lịch sử, phả vào mặt là một bầu không khí văn hóa phong tục lịch sử Giang Nam nồng hậu đậm đà thuần khiết.'
WHERE id = '70d1b7f4-a36f-4116-8924-1a6d25ee5675' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '70d1b7f4-a36f-4116-8924-1a6d25ee5675', '漫步在有着千年历史的古老水乡小镇青石板街道上，扑面而来的是一股浓厚醇正的江南历史民俗文化气息。', 'Mànbù zài yǒu zhe qiānnián lìshǐ de gǔlǎo shuǐxiāng xiǎozhèn qīngshíbǎn jiēdào shang, pūmiàn''érlái de shì yì gǔ nónghòu chúnzhèng de Jiāngnán lìshǐ mínsú wénhuà qìxī.', 'Tản bộ trên con đường lát đá xanh của thị trấn sông nước cổ ngàn năm lịch sử, phả vào mặt là một bầu không khí văn hóa phong tục lịch sử Giang Nam nồng hậu đậm đà thuần khiết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '70d1b7f4-a36f-4116-8924-1a6d25ee5675'
);

-- [偶像] (ǒuxiàng): thần tượng
UPDATE public.vocabularies
SET example_hanzi = '当代青年应当把那些为国家国防科研与抢险救灾做出无私奉献的英模榜样作为自己一生追求的精神偶像。',
    example_pinyin = 'Dāngdài qīngnián yīngdāng bǎ nàxiē wèi guójiā guófáng kēyán yǔ qiǎngxiǎn jiùzāi zuòchū wúsī fèngxiàn de yīngmó bǎngyàng zuòwéi zìjǐ yì shēng zhuīqiú de jīngshén ǒuxiàng.',
    example_vi = 'Thanh niên đương đại nên lấy những tấm gương anh hùng kiểu mẫu hết lòng cống hiến vì nghiên cứu quốc phòng và cứu hộ thiên tai của đất nước làm thần tượng tinh thần theo đuổi suốt đời mình.'
WHERE id = 'cf2ee71e-f2ea-4e2e-922f-498d55aee9d3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cf2ee71e-f2ea-4e2e-922f-498d55aee9d3', '当代青年应当把那些为国家国防科研与抢险救灾做出无私奉献的英模榜样作为自己一生追求的精神偶像。', 'Dāngdài qīngnián yīngdāng bǎ nàxiē wèi guójiā guófáng kēyán yǔ qiǎngxiǎn jiùzāi zuòchū wúsī fèngxiàn de yīngmó bǎngyàng zuòwéi zìjǐ yì shēng zhuīqiú de jīngshén ǒuxiàng.', 'Thanh niên đương đại nên lấy những tấm gương anh hùng kiểu mẫu hết lòng cống hiến vì nghiên cứu quốc phòng và cứu hộ thiên tai của đất nước làm thần tượng tinh thần theo đuổi suốt đời mình.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cf2ee71e-f2ea-4e2e-922f-498d55aee9d3'
);

-- [排除] (pái chú): loại trừ, bài trừ
UPDATE public.vocabularies
SET example_hanzi = '燃气抢险抢修技术人员携带精密检测仪器深入管网排查，在短短半小时内彻底排除了一起地下管线微小漏气隐患。',
    example_pinyin = 'Ránqì qiǎngxiǎn qiǎngxīu jìshù rényuán xiédài jīngmì jiǎncè yíqì shēnrù guǎnwǎng páichá, zài duǎnduǎn bàn xiǎoshí nèi chèdǐ páichú le yì qǐ dìxià guǎnxiàn wēixiǎo lòuqì yǐnhuàn.',
    example_vi = 'Kỹ thuật viên cứu hộ khí đốt mang theo thiết bị dò đo chính xác đi sâu vào mạng lưới đường ống rà soát, chỉ trong nửa giờ đã loại trừ triệt để mối nguy rò rỉ khí nhỏ dưới lòng đất.'
WHERE id = '80d4b33f-351f-4d54-aca5-483a8967bf01' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '80d4b33f-351f-4d54-aca5-483a8967bf01', '燃气抢险抢修技术人员携带精密检测仪器深入管网排查，在短短半小时内彻底排除了一起地下管线微小漏气隐患。', 'Ránqì qiǎngxiǎn qiǎngxīu jìshù rényuán xiédài jīngmì jiǎncè yíqì shēnrù guǎnwǎng páichá, zài duǎnduǎn bàn xiǎoshí nèi chèdǐ páichú le yì qǐ dìxià guǎnxiàn wēixiǎo lòuqì yǐnhuàn.', 'Kỹ thuật viên cứu hộ khí đốt mang theo thiết bị dò đo chính xác đi sâu vào mạng lưới đường ống rà soát, chỉ trong nửa giờ đã loại trừ triệt để mối nguy rò rỉ khí nhỏ dưới lòng đất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '80d4b33f-351f-4d54-aca5-483a8967bf01'
);

-- [排放] (pái fàng): xả, thải (chất thải)
UPDATE public.vocabularies
SET example_hanzi = '环保执法部门对沿江工业园区安装了二十四小时排污在线自动监控系统，严禁工业废水与废气超标排放。',
    example_pinyin = 'Huánbǎo zhífǎ bùmén duì yánjiāng gōngyè yuánqū ānzhuāng le èrshísì xiǎoshí páiwū zàixiàn zìdòng jiānkòng xìtǒng, yánjìn gōngyè fèishuǐ yǔ fèiqì chāobiāo páifàng.',
    example_vi = 'Cơ quan hành pháp bảo vệ môi trường đã lắp đặt hệ thống giám sát tự động xả thải trực tuyến 24/24 cho khu công nghiệp ven sông, nghiêm cấm xả thải nước thải và khí thải công nghiệp vượt chuẩn.'
WHERE id = 'cf475538-5149-48b9-a988-9b989f7f8e40' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'cf475538-5149-48b9-a988-9b989f7f8e40', '环保执法部门对沿江工业园区安装了二十四小时排污在线自动监控系统，严禁工业废水与废气超标排放。', 'Huánbǎo zhífǎ bùmén duì yánjiāng gōngyè yuánqū ānzhuāng le èrshísì xiǎoshí páiwū zàixiàn zìdòng jiānkòng xìtǒng, yánjìn gōngyè fèishuǐ yǔ fèiqì chāobiāo páifàng.', 'Cơ quan hành pháp bảo vệ môi trường đã lắp đặt hệ thống giám sát tự động xả thải trực tuyến 24/24 cho khu công nghiệp ven sông, nghiêm cấm xả thải nước thải và khí thải công nghiệp vượt chuẩn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'cf475538-5149-48b9-a988-9b989f7f8e40'
);

-- [排练] (pái liàn): tập dượt, diễn tập
UPDATE public.vocabularies
SET example_hanzi = '民族交响乐团的全体演奏家们正在指挥家严格细致的指导下，全力排练即将在新年音乐会上演出的管弦乐交响套曲。',
    example_pinyin = 'Mínzú jiāoxiǎng yuètuán de quántǐ yǎnzòujiā men zhèngzài zhǐhuījiā yángé xìzhì de zhǐdǎo xià, quánlì páiliàn jíjiāng zài xīnnián yīnyuèhuì shang yǎnchū de guǎnxiányuè jiāoxiǎng tàoqǔ.',
    example_vi = 'Toàn thể các nhạc công của dàn nhạc giao hưởng dân tộc đang dưới sự hướng dẫn nghiêm ngặt tỉ mỉ của nhạc trưởng dốc sức tập dượt diễn tập khúc giao hưởng sắp biểu diễn tại buổi hòa nhạc năm mới.'
WHERE id = '095d7911-5e0b-4034-852a-de5f24ab81df' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '095d7911-5e0b-4034-852a-de5f24ab81df', '民族交响乐团的全体演奏家们正在指挥家严格细致的指导下，全力排练即将在新年音乐会上演出的管弦乐交响套曲。', 'Mínzú jiāoxiǎng yuètuán de quántǐ yǎnzòujiā men zhèngzài zhǐhuījiā yángé xìzhì de zhǐdǎo xià, quánlì páiliàn jíjiāng zài xīnnián yīnyuèhuì shang yǎnchū de guǎnxiányuè jiāoxiǎng tàoqǔ.', 'Toàn thể các nhạc công của dàn nhạc giao hưởng dân tộc đang dưới sự hướng dẫn nghiêm ngặt tỉ mỉ của nhạc trưởng dốc sức tập dượt diễn tập khúc giao hưởng sắp biểu diễn tại buổi hòa nhạc năm mới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '095d7911-5e0b-4034-852a-de5f24ab81df'
);

-- [庞大] (páng dà): khổng lồ, to lớn
UPDATE public.vocabularies
SET example_hanzi = '现代跨国现代物流供应链是一个庞大复杂的高效协同网络，涵盖了海运、空运、高铁与仓储分拨等多个核心环节。',
    example_pinyin = 'Xiàndài kuàguó xiàndài wùliú gōngyìngliàn shì yí gè pángdà fùzá de gāoxiào xiétóng wǎngluò, hángài le hǎiyùn, kōngyùn, gāotiě yǔ cāngchǔ fēnbō děng duō gè héxīn huánjié.',
    example_vi = 'Chuỗi cung ứng hậu cần xuyên quốc gia hiện đại là một mạng lưới hiệp đồng hiệu quả to lớn khổng lồ phức tạp, bao hàm nhiều khâu cốt lõi như đường biển, đường hàng không, đường sắt cao tốc và phân phối kho bãi.'
WHERE id = '6e988eb9-0c85-4add-9789-675f8ec879c3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6e988eb9-0c85-4add-9789-675f8ec879c3', '现代跨国现代物流供应链是一个庞大复杂的高效协同网络，涵盖了海运、空运、高铁与仓储分拨等多个核心环节。', 'Xiàndài kuàguó xiàndài wùliú gōngyìngliàn shì yí gè pángdà fùzá de gāoxiào xiétóng wǎngluò, hángài le hǎiyùn, kōngyùn, gāotiě yǔ cāngchǔ fēnbō děng duō gè héxīn huánjié.', 'Chuỗi cung ứng hậu cần xuyên quốc gia hiện đại là một mạng lưới hiệp đồng hiệu quả to lớn khổng lồ phức tạp, bao hàm nhiều khâu cốt lõi như đường biển, đường hàng không, đường sắt cao tốc và phân phối kho bãi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6e988eb9-0c85-4add-9789-675f8ec879c3'
);

-- [盼望] (pànwàng): trông mong, ngóng trông
UPDATE public.vocabularies
SET example_hanzi = '长年在外打工奔波的父母无时无刻不在深情盼望着春节返乡，能够早日与留守在家的小儿女团聚欢度佳节。',
    example_pinyin = 'Chángnián zàiwài dǎgōng bēnbō de fùmǔ wúshí-wúkè bú zài shēnqíng pànwàng zhe chūnjié fǎnxiāng, nénggòu zǎorì yǔ liúshǒu zàijiā de xiǎo érnǚ tuánjù huāndù jiājié.',
    example_vi = 'Cha mẹ quanh năm bôn ba làm thuê xa nhà không lúc nào là không tha thiết mong mỏi ngóng trông dịp Tết về quê để sớm được đoàn tụ vui vầy ngày lễ cùng con cái đang ngóng chờ ở nhà.'
WHERE id = '730cedf3-ae3d-430a-85fc-6d05691c6de2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '730cedf3-ae3d-430a-85fc-6d05691c6de2', '长年在外打工奔波的父母无时无刻不在深情盼望着春节返乡，能够早日与留守在家的小儿女团聚欢度佳节。', 'Chángnián zàiwài dǎgōng bēnbō de fùmǔ wúshí-wúkè bú zài shēnqíng pànwàng zhe chūnjié fǎnxiāng, nénggòu zǎorì yǔ liúshǒu zàijiā de xiǎo érnǚ tuánjù huāndù jiājié.', 'Cha mẹ quanh năm bôn ba làm thuê xa nhà không lúc nào là không tha thiết mong mỏi ngóng trông dịp Tết về quê để sớm được đoàn tụ vui vầy ngày lễ cùng con cái đang ngóng chờ ở nhà.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '730cedf3-ae3d-430a-85fc-6d05691c6de2'
);

-- [配备] (pèibèi): trang bị, bố trí
UPDATE public.vocabularies
SET example_hanzi = '为了确保高海拔山区森林防火救援反应敏捷，应急管理部门为森林特警大队配备了最新型多功能救援全地形车辆。',
    example_pinyin = 'Wèile quèbǎo gāo hǎibá shānqū sēnlín fánghuǒ jiùyuán fǎnyìng mǐnjié, yìngjí guǎnlǐ bùmén wèi sēnlín tèjǐng dàduì pèibèi le zuìxīn xíng duō gōngnéng jiùyuán quán dìxíng chēliàng.',
    example_vi = 'Nhằm bảo đảm công tác cứu hộ phòng cháy rừng vùng núi cao phản ứng nhanh nhạy, cơ quan quản lý khẩn cấp đã trang bị cho đội cảnh sát đặc nhiệm kiểm lâm xe địa hình cứu hộ đa năng mẫu mới nhất.'
WHERE id = '6ad928f4-a87a-49f5-a6ad-e7a37cb59d94' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6ad928f4-a87a-49f5-a6ad-e7a37cb59d94', '为了确保高海拔山区森林防火救援反应敏捷，应急管理部门为森林特警大队配备了最新型多功能救援全地形车辆。', 'Wèile quèbǎo gāo hǎibá shānqū sēnlín fánghuǒ jiùyuán fǎnyìng mǐnjié, yìngjí guǎnlǐ bùmén wèi sēnlín tèjǐng dàduì pèibèi le zuìxīn xíng duō gōngnéng jiùyuán quán dìxíng chēliàng.', 'Nhằm bảo đảm công tác cứu hộ phòng cháy rừng vùng núi cao phản ứng nhanh nhạy, cơ quan quản lý khẩn cấp đã trang bị cho đội cảnh sát đặc nhiệm kiểm lâm xe địa hình cứu hộ đa năng mẫu mới nhất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6ad928f4-a87a-49f5-a6ad-e7a37cb59d94'
);

-- [赔偿] (péicháng): bồi thường
UPDATE public.vocabularies
SET example_hanzi = '针对施工过程中由于操作失误造成地下供水管道破裂给居民带来的经济损失，工程施工单位依法主动承担并支付了全额赔偿。',
    example_pinyin = 'Zhēnduì shīgōng guòchéng zhōng yóuyú cāozuò shīwù zàochéng dìxià gōngshuǐ guǎndào pòliè gěi jūmín dài lái de jīngjì sǔnshī, gōngchéng shīgōng dānwèi yīfǎ zhǔdòng chéngdān bìng zhīfù le quán''é péicháng.',
    example_vi = 'Đối với thiệt hại kinh tế của người dân do vỡ đường ống cấp nước ngầm vì sơ suất thao tác trong thi công, đơn vị thi công đã chủ động nhận trách nhiệm và bồi thường toàn bộ theo luật.'
WHERE id = 'e19b9a05-2291-4c0d-b8eb-e78dd5d353c0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e19b9a05-2291-4c0d-b8eb-e78dd5d353c0', '针对施工过程中由于操作失误造成地下供水管道破裂给居民带来的经济损失，工程施工单位依法主动承担并支付了全额赔偿。', 'Zhēnduì shīgōng guòchéng zhōng yóuyú cāozuò shīwù zàochéng dìxià gōngshuǐ guǎndào pòliè gěi jūmín dài lái de jīngjì sǔnshī, gōngchéng shīgōng dānwèi yīfǎ zhǔdòng chéngdān bìng zhīfù le quán''é péicháng.', 'Đối với thiệt hại kinh tế của người dân do vỡ đường ống cấp nước ngầm vì sơ suất thao tác trong thi công, đơn vị thi công đã chủ động nhận trách nhiệm và bồi thường toàn bộ theo luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e19b9a05-2291-4c0d-b8eb-e78dd5d353c0'
);

-- [佩服] (pèifú): khâm phục
UPDATE public.vocabularies
SET example_hanzi = '老一辈地质科考队员在极其险峻的高原冰川绝壁上十年如一日默默奉献的顽强坚韧毅力，令在场的年轻后辈无不深感佩服。',
    example_pinyin = 'Lǎoyíbèi dìzhì kěkǎoduìyuán zài jíqí xiǎnjùn de gāoyuán bīngchuān juébì shang shí nián rú yírì mòmò fèngxiàn de wánqiáng jiānrèn yìlì, lìng zàichǎng de niánqīng hòubèi wúbù shēn gǎn pèifú.',
    example_vi = 'Nghị lực kiên cường dẻo dai của thế hệ đội viên khảo sát địa chất tiền bối cống hiến âm thầm mười năm như một trên vách đá sông băng cao nguyên hiểm trở khiến lớp hậu bối trẻ ai nấy đều khâm phục bội phần.'
WHERE id = 'd24fe306-65ab-4cad-912a-a006a854203b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd24fe306-65ab-4cad-912a-a006a854203b', '老一辈地质科考队员在极其险峻的高原冰川绝壁上十年如一日默默奉献的顽强坚韧毅力，令在场的年轻后辈无不深感佩服。', 'Lǎoyíbèi dìzhì kěkǎoduìyuán zài jíqí xiǎnjùn de gāoyuán bīngchuān juébì shang shí nián rú yírì mòmò fèngxiàn de wánqiáng jiānrèn yìlì, lìng zàichǎng de niánqīng hòubèi wúbù shēn gǎn pèifú.', 'Nghị lực kiên cường dẻo dai của thế hệ đội viên khảo sát địa chất tiền bối cống hiến âm thầm mười năm như một trên vách đá sông băng cao nguyên hiểm trở khiến lớp hậu bối trẻ ai nấy đều khâm phục bội phần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd24fe306-65ab-4cad-912a-a006a854203b'
);

-- [配套] (pèitào): đồng bộ, trọn bộ
UPDATE public.vocabularies
SET example_hanzi = '现代化新兴高新产业园区不仅建有标准化厂房与实验室，还同步规划建设了高品质人才公寓、幼儿园和商业等完善配套设施。',
    example_pinyin = 'Xiàndàihuà xīnxīng gāoxīn chǎnyè yuánqū bùjǐn jiàn yǒu biāozhǔnhuà chǎngfáng yǔ shíyànshì, hái tóngbù guīhuà jiànshè le gāo pǐnzhì réncái gōngyù, yòu''éryuán hé shāngyè děng wánshàn pèitào shèshī.',
    example_vi = 'Khu công nghiệp công nghệ cao hiện đại mới nổi không chỉ có xưởng sản xuất và phòng thí nghiệm chuẩn hóa mà còn quy hoạch đồng bộ xây dựng các tiện ích đồng bộ hoàn thiện như căn hộ chuyên gia cao cấp, trường mầm non và thương mại.'
WHERE id = 'f2ef1fe0-3b2f-4227-baa1-20069814a240' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f2ef1fe0-3b2f-4227-baa1-20069814a240', '现代化新兴高新产业园区不仅建有标准化厂房与实验室，还同步规划建设了高品质人才公寓、幼儿园和商业等完善配套设施。', 'Xiàndàihuà xīnxīng gāoxīn chǎnyè yuánqū bùjǐn jiàn yǒu biāozhǔnhuà chǎngfáng yǔ shíyànshì, hái tóngbù guīhuà jiànshè le gāo pǐnzhì réncái gōngyù, yòu''éryuán hé shāngyè děng wánshàn pèitào shèshī.', 'Khu công nghiệp công nghệ cao hiện đại mới nổi không chỉ có xưởng sản xuất và phòng thí nghiệm chuẩn hóa mà còn quy hoạch đồng bộ xây dựng các tiện ích đồng bộ hoàn thiện như căn hộ chuyên gia cao cấp, trường mầm non và thương mại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f2ef1fe0-3b2f-4227-baa1-20069814a240'
);

-- [培育] (péiyù): ươm trồng, bồi dưỡng
UPDATE public.vocabularies
SET example_hanzi = '农业科学院杂交水稻繁育实验基地的育种科研专家们扎根热带田野，历经十年艰辛终于成功培育出了耐盐碱高产优质新水稻品种。',
    example_pinyin = 'Nóngyè kēxuéyuàn zájiāo shuǐdào fányù shíyàn jīdì de yùzhǒng kēyán zhuānjiā men zhāgēn rèdài tiányě, lìjīng shí nián jiānxīn zhōngyú chénggōng péiyù chū le nài yán-jiǎn gāochǎn yōuzhì xīn shuǐdào pǐnzhǒng.',
    example_vi = 'Các chuyên gia nghiên cứu giống lúa tại cơ sở nhân giống lúa lai của Viện Khoa học Nông nghiệp cắm bản trên đồng ruộng nhiệt đới qua 10 năm gian khổ rốt cuộc đã ươm trồng lai tạo thành công giống lúa mới năng suất cao chịu mặn phèn.'
WHERE id = 'b13df53b-3ac2-4f16-ab16-ab22f8700b37' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b13df53b-3ac2-4f16-ab16-ab22f8700b37', '农业科学院杂交水稻繁育实验基地的育种科研专家们扎根热带田野，历经十年艰辛终于成功培育出了耐盐碱高产优质新水稻品种。', 'Nóngyè kēxuéyuàn zájiāo shuǐdào fányù shíyàn jīdì de yùzhǒng kēyán zhuānjiā men zhāgēn rèdài tiányě, lìjīng shí nián jiānxīn zhōngyú chénggōng péiyù chū le nài yán-jiǎn gāochǎn yōuzhì xīn shuǐdào pǐnzhǒng.', 'Các chuyên gia nghiên cứu giống lúa tại cơ sở nhân giống lúa lai của Viện Khoa học Nông nghiệp cắm bản trên đồng ruộng nhiệt đới qua 10 năm gian khổ rốt cuộc đã ươm trồng lai tạo thành công giống lúa mới năng suất cao chịu mặn phèn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b13df53b-3ac2-4f16-ab16-ab22f8700b37'
);

-- [捧] (pěng): bưng, nâng niu, tâng bốc
UPDATE public.vocabularies
SET example_hanzi = '载誉归来的奥运冠军手捧着鲜艳夺目的红玫瑰与金光灿灿的金牌，向机场热烈欢迎的家乡人民频频挥手致意。',
    example_pinyin = 'Zàiyù-guīlái de Àoyùn guànjūn shǒu pěng zhe xiānyàn duómù de hóng méiguī yǔ jīnguāng-càncàn de jīnpái, xiàng jīchǎng rèliè huānyíng de jiāxiāng rénmín pínpín huīshǒu zhìyì.',
    example_vi = 'Nhà vô địch Olympic vinh quang trở về hai tay nâng niu bó hoa hồng đỏ thắm rực rỡ và tấm huy chương vàng sáng chói, liên tục vẫy tay chào đồng bào quê nhà nồng nhiệt đón rước tại sân bay.'
WHERE id = '109e668f-86ad-4a94-9b4c-1eb791e28c46' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '109e668f-86ad-4a94-9b4c-1eb791e28c46', '载誉归来的奥运冠军手捧着鲜艳夺目的红玫瑰与金光灿灿的金牌，向机场热烈欢迎的家乡人民频频挥手致意。', 'Zàiyù-guīlái de Àoyùn guànjūn shǒu pěng zhe xiānyàn duómù de hóng méiguī yǔ jīnguāng-càncàn de jīnpái, xiàng jīchǎng rèliè huānyíng de jiāxiāng rénmín pínpín huīshǒu zhìyì.', 'Nhà vô địch Olympic vinh quang trở về hai tay nâng niu bó hoa hồng đỏ thắm rực rỡ và tấm huy chương vàng sáng chói, liên tục vẫy tay chào đồng bào quê nhà nồng nhiệt đón rước tại sân bay.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '109e668f-86ad-4a94-9b4c-1eb791e28c46'
);

-- [披] (pī): khoác, choàng
UPDATE public.vocabularies
SET example_hanzi = '深夜的高山气象观测站寒气逼人，值班气象员披上一件厚厚的防风棉大衣，推开房门顶着寒风记录气象数据。',
    example_pinyin = 'Shēnyè de gāoshān qìxiàng guāncèzhàn hánqì-bīrén, zhíbān qìxiàngyuán pī shang yí jiàn hòuhòu de fángfēng miándàyī, tuīkāi fángmén dǐng zhe hánfēng jìlù qìxiàng shùjù.',
    example_vi = 'Trạm quan trắc khí tượng trên núi cao đêm khuya khí lạnh thấu xương, nhân viên trực ban khoác lên mình chiếc áo khoác bông chắn gió dày dặn, đẩy cửa ra đội gió lạnh ghi chép số liệu thời tiết.'
WHERE id = 'bd396ef8-fc6c-4300-bf5b-8d403f522ed2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bd396ef8-fc6c-4300-bf5b-8d403f522ed2', '深夜的高山气象观测站寒气逼人，值班气象员披上一件厚厚的防风棉大衣，推开房门顶着寒风记录气象数据。', 'Shēnyè de gāoshān qìxiàng guāncèzhàn hánqì-bīrén, zhíbān qìxiàngyuán pī shang yí jiàn hòuhòu de fángfēng miándàyī, tuīkāi fángmén dǐng zhe hánfēng jìlù qìxiàng shùjù.', 'Trạm quan trắc khí tượng trên núi cao đêm khuya khí lạnh thấu xương, nhân viên trực ban khoác lên mình chiếc áo khoác bông chắn gió dày dặn, đẩy cửa ra đội gió lạnh ghi chép số liệu thời tiết.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bd396ef8-fc6c-4300-bf5b-8d403f522ed2'
);

-- [片刻] (piànkè): chốc lát, thoáng chốc
UPDATE public.vocabularies
SET example_hanzi = '在激烈的法庭辩论过程中，审判长宣布休庭片刻，合议庭法官前往评议室就案件新证据进行闭门研究。',
    example_pinyin = 'Zài jīliè de fǎtíng biànlùn guòchéng zhōng, shěnpànzhǎng xuānbù xiūtíng piànkè, héyìtíng fǎguān qiánwǎng píngyìshì jiù ànjiàn xīn zhèngjù jìnxíng bìmén yánjiū.',
    example_vi = 'Trong quá trình tranh tụng gay gắt tại phiên tòa, thẩm phán chủ tọa tuyên bố tạm nghỉ phiên tòa trong chốc lát thoáng chốc để hội đồng xét xử vào phòng kín hội ý về chứng cứ mới của vụ án.'
WHERE id = '749d5851-6fc0-4d1f-b943-8f53ad8c8c2a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '749d5851-6fc0-4d1f-b943-8f53ad8c8c2a', '在激烈的法庭辩论过程中，审判长宣布休庭片刻，合议庭法官前往评议室就案件新证据进行闭门研究。', 'Zài jīliè de fǎtíng biànlùn guòchéng zhōng, shěnpànzhǎng xuānbù xiūtíng piànkè, héyìtíng fǎguān qiánwǎng píngyìshì jiù ànjiàn xīn zhèngjù jìnxíng bìmén yánjiū.', 'Trong quá trình tranh tụng gay gắt tại phiên tòa, thẩm phán chủ tọa tuyên bố tạm nghỉ phiên tòa trong chốc lát thoáng chốc để hội đồng xét xử vào phòng kín hội ý về chứng cứ mới của vụ án.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '749d5851-6fc0-4d1f-b943-8f53ad8c8c2a'
);

-- [片面] (piànmiàn): phiến diện, một chiều
UPDATE public.vocabularies
SET example_hanzi = '评价一项复杂的公共政策成效应当坚持客观全面原则，切忌以偏概全、做出片面武断的不负责任结论。',
    example_pinyin = 'Píngjià yí xiàng fùzá de gōnggòng zhèngcè chéngxiào yīngdāng jiānchí kèguān quánmiàn yuánzé, qièjì yǐpiān-gàiquán, zuòchū piànmiàn wǔduàn de bú fùzérèn jiélùn.',
    example_vi = 'Đánh giá hiệu quả của một chính sách công cộng phức tạp cần kiên trì nguyên tắc khách quan toàn diện, chớ nên lấy một phần khái quát toàn thể mà đưa ra kết luận phiến diện một chiều vô trách nhiệm.'
WHERE id = 'f7573dd2-efcf-4ca4-90d7-1e53c34efd07' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f7573dd2-efcf-4ca4-90d7-1e53c34efd07', '评价一项复杂的公共政策成效应当坚持客观全面原则，切忌以偏概全、做出片面武断的不负责任结论。', 'Píngjià yí xiàng fùzá de gōnggòng zhèngcè chéngxiào yīngdāng jiānchí kèguān quánmiàn yuánzé, qièjì yǐpiān-gàiquán, zuòchū piànmiàn wǔduàn de bú fùzérèn jiélùn.', 'Đánh giá hiệu quả của một chính sách công cộng phức tạp cần kiên trì nguyên tắc khách quan toàn diện, chớ nên lấy một phần khái quát toàn thể mà đưa ra kết luận phiến diện một chiều vô trách nhiệm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f7573dd2-efcf-4ca4-90d7-1e53c34efd07'
);

-- [飘] (piāo): bay, trôi giạt
UPDATE public.vocabularies
SET example_hanzi = '初冬的第一场瑞雪纷纷扬扬地在古城灰瓦飞檐之间随风漫天飘舞，给千里江山披上了一层银装素裹的冬日画卷。',
    example_pinyin = 'Chūdōng de dì-yī chǎng ruìxuě fēnfēn-yángyáng de zài gǔchéng huīwǎ fēiyán zhījiān suí fēng màntiān piāowǔ, gěi qiānlǐ jiāngshān pī shang le yì céng yínzhuāng-sùguǒ de dōngrì huàjuàn.',
    example_vi = 'Trận tuyết lành đầu tiên của đầu đông lất phất bay theo gió lượn lờ giữa những mái ngói xám hiên cong của thành cổ, khoác lên giang sơn ngàn dặm bức tranh mùa đông tinh khôi tuyết trắng.'
WHERE id = '325f89d2-1ba7-4aee-9b67-e7c108300f7b' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '325f89d2-1ba7-4aee-9b67-e7c108300f7b', '初冬的第一场瑞雪纷纷扬扬地在古城灰瓦飞檐之间随风漫天飘舞，给千里江山披上了一层银装素裹的冬日画卷。', 'Chūdōng de dì-yī chǎng ruìxuě fēnfēn-yángyáng de zài gǔchéng huīwǎ fēiyán zhījiān suí fēng màntiān piāowǔ, gěi qiānlǐ jiāngshān pī shang le yì céng yínzhuāng-sùguǒ de dōngrì huàjuàn.', 'Trận tuyết lành đầu tiên của đầu đông lất phất bay theo gió lượn lờ giữa những mái ngói xám hiên cong của thành cổ, khoác lên giang sơn ngàn dặm bức tranh mùa đông tinh khôi tuyết trắng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '325f89d2-1ba7-4aee-9b67-e7c108300f7b'
);

-- [疲劳] (píláo): mệt mỏi, mệt nhọc
UPDATE public.vocabularies
SET example_hanzi = '长途长途驾驶车辆行驶在高速公路上极易产生视觉与身体疲劳，交通安全交警再三提醒驾驶员切勿疲劳驾驶。',
    example_pinyin = 'Chángtú chángtú jiàshǐ chēliàng xíngshǐ zài gāosù gōnglù shang jí yì chǎnshēng shìjué yǔ shēntǐ píláo, jiāotōng ānquán jiāojǐng zàisān tíxǐng jiàshǐyuán qièwù píláo jiàshǐ.',
    example_vi = 'Lái xe đường dài liên tục trên đường cao tốc rất dễ gây mỏi mắt mệt mỏi thể xác, cảnh sát an toàn giao thông nhắc đi nhắc lại các tài xế tuyệt đối chớ lái xe khi đang mệt nhọc.'
WHERE id = '6f5c67fb-7a43-40f2-8075-b9605bab3a85' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6f5c67fb-7a43-40f2-8075-b9605bab3a85', '长途长途驾驶车辆行驶在高速公路上极易产生视觉与身体疲劳，交通安全交警再三提醒驾驶员切勿疲劳驾驶。', 'Chángtú chángtú jiàshǐ chēliàng xíngshǐ zài gāosù gōnglù shang jí yì chǎnshēng shìjué yǔ shēntǐ píláo, jiāotōng ānquán jiāojǐng zàisān tíxǐng jiàshǐyuán qièwù píláo jiàshǐ.', 'Lái xe đường dài liên tục trên đường cao tốc rất dễ gây mỏi mắt mệt mỏi thể xác, cảnh sát an toàn giao thông nhắc đi nhắc lại các tài xế tuyệt đối chớ lái xe khi đang mệt nhọc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6f5c67fb-7a43-40f2-8075-b9605bab3a85'
);

-- [品尝] (pǐncháng): nếm, thưởng thức
UPDATE public.vocabularies
SET example_hanzi = '来自海内外的数万名游客漫步在历史文化美食名街上，兴致勃勃地品尝具有浓郁地方特色的各种传统风味小吃。',
    example_pinyin = 'Láizì hǎinèiwài de shùwàn míng yóukè mànbù zài lìshǐ wénhuà měishí míngjiē shang, xìngzhì-bóbó de pǐncháng jùyǒu nóngyù dìfāng tèsè de gè zhǒng chuántǒng fēngwèi xiǎochī.',
    example_vi = 'Hàng vạn du khách trong và ngoài nước tản bộ trên con phố ẩm thực văn hóa lịch sử nổi tiếng, hào hứng nếm thử thưởng thức các món ăn vặt truyền thống mang đậm hương vị đặc trưng địa phương.'
WHERE id = '3f00aabc-1138-4e8b-aa5d-bd633983cdd9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3f00aabc-1138-4e8b-aa5d-bd633983cdd9', '来自海内外的数万名游客漫步在历史文化美食名街上，兴致勃勃地品尝具有浓郁地方特色的各种传统风味小吃。', 'Láizì hǎinèiwài de shùwàn míng yóukè mànbù zài lìshǐ wénhuà měishí míngjiē shang, xìngzhì-bóbó de pǐncháng jùyǒu nóngyù dìfāng tèsè de gè zhǒng chuántǒng fēngwèi xiǎochī.', 'Hàng vạn du khách trong và ngoài nước tản bộ trên con phố ẩm thực văn hóa lịch sử nổi tiếng, hào hứng nếm thử thưởng thức các món ăn vặt truyền thống mang đậm hương vị đặc trưng địa phương.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3f00aabc-1138-4e8b-aa5d-bd633983cdd9'
);

-- [频道] (píndào): kênh (truyền hình)
UPDATE public.vocabularies
SET example_hanzi = '中央广播电视总台少儿与纪录片频道通过数字电视网络，为广大电视观众全天候转播精彩优质的科普益智文化节目。',
    example_pinyin = 'Zhōngyāng guǎngbō diànshì zǒngtái shào''ér yǔ jìlùpiàn píndào tōngguò shùzì diànshì wǎngluò, wèi guǎngdà diànshì guānzhòng quántiānhòu zhuǎnbō jīngcǎi yōuzhì de kěpǔ yìzhì wénhuà jiémù.',
    example_vi = 'Kênh thiếu nhi và phim tài liệu của Đài Phát thanh Truyền hình Trung ương thông qua mạng truyền hình số phát sóng 24/7 các chương trình văn hóa giải trí phổ biến khoa học chất lượng xuất sắc.'
WHERE id = 'f1ec4afe-bd3e-4d33-ac49-b4bfc167db43' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f1ec4afe-bd3e-4d33-ac49-b4bfc167db43', '中央广播电视总台少儿与纪录片频道通过数字电视网络，为广大电视观众全天候转播精彩优质的科普益智文化节目。', 'Zhōngyāng guǎngbō diànshì zǒngtái shào''ér yǔ jìlùpiàn píndào tōngguò shùzì diànshì wǎngluò, wèi guǎngdà diànshì guānzhòng quántiānhòu zhuǎnbō jīngcǎi yōuzhì de kěpǔ yìzhì wénhuà jiémù.', 'Kênh thiếu nhi và phim tài liệu của Đài Phát thanh Truyền hình Trung ương thông qua mạng truyền hình số phát sóng 24/7 các chương trình văn hóa giải trí phổ biến khoa học chất lượng xuất sắc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f1ec4afe-bd3e-4d33-ac49-b4bfc167db43'
);

-- [频繁] (pínfán): thường xuyên, dồn dập
UPDATE public.vocabularies
SET example_hanzi = '随着国际学术交流与多边科技合作日益频繁，越来越多优秀青年学者受邀赴海外出席高水平专业学术研讨会。',
    example_pinyin = 'Suízhe guójì xuéshù jiāoliú yǔ duōbiān kējì hézuò rìyì pínfán, yuèláiyuè duō yōuxiù qīngnián xuézhě shòuyāo fù hǎiwài chūxí gāo shuǐpíng zhuānyè xuéshù yántǎohuì.',
    example_vi = 'Cùng với việc giao lưu học thuật quốc tế và hợp tác khoa học công nghệ đa phương ngày càng thường xuyên dày đặc, ngày càng nhiều học giả trẻ ưu tú được mời ra nước ngoài tham dự các hội thảo chuyên ngành trình độ cao.'
WHERE id = '02aa87af-01df-4e91-873d-cce3812e90c2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '02aa87af-01df-4e91-873d-cce3812e90c2', '随着国际学术交流与多边科技合作日益频繁，越来越多优秀青年学者受邀赴海外出席高水平专业学术研讨会。', 'Suízhe guójì xuéshù jiāoliú yǔ duōbiān kējì hézuò rìyì pínfán, yuèláiyuè duō yōuxiù qīngnián xuézhě shòuyāo fù hǎiwài chūxí gāo shuǐpíng zhuānyè xuéshù yántǎohuì.', 'Cùng với việc giao lưu học thuật quốc tế và hợp tác khoa học công nghệ đa phương ngày càng thường xuyên dày đặc, ngày càng nhiều học giả trẻ ưu tú được mời ra nước ngoài tham dự các hội thảo chuyên ngành trình độ cao.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '02aa87af-01df-4e91-873d-cce3812e90c2'
);

-- [平凡] (píng fán): bình thường, bình phàm
UPDATE public.vocabularies
SET example_hanzi = '无数默默坚守在环卫、邮政、医疗第一线的普通劳动者，在极其平凡的工作岗位上书写着属于新时代的崇高与伟大。',
    example_pinyin = 'Wúshù mòmò jiānshǒu zài huánwèi, yóuzhèng, yīliáo dì-yīxiàn de pǔtōng láodòngzhě, zài jíqí píngfán de gōngzuò gǎngwèi shang shūxiě zhe shǔyú xīn shídài de chónggāo yǔ wěidà.',
    example_vi = 'Vô số người lao động bình dị âm thầm bám trụ nơi tuyến đầu môi trường, bưu chính, y tế, trên vị trí công tác hết sức bình thường bình phàm đã viết nên sự cao cả và vĩ đại của thời đại mới.'
WHERE id = '62483033-fa1c-401a-8e74-727efbd0f2d9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '62483033-fa1c-401a-8e74-727efbd0f2d9', '无数默默坚守在环卫、邮政、医疗第一线的普通劳动者，在极其平凡的工作岗位上书写着属于新时代的崇高与伟大。', 'Wúshù mòmò jiānshǒu zài huánwèi, yóuzhèng, yīliáo dì-yīxiàn de pǔtōng láodòngzhě, zài jíqí píngfán de gōngzuò gǎngwèi shang shūxiě zhe shǔyú xīn shídài de chónggāo yǔ wěidà.', 'Vô số người lao động bình dị âm thầm bám trụ nơi tuyến đầu môi trường, bưu chính, y tế, trên vị trí công tác hết sức bình thường bình phàm đã viết nên sự cao cả và vĩ đại của thời đại mới.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '62483033-fa1c-401a-8e74-727efbd0f2d9'
);

-- [平等] (píngděng): bình đẳng
UPDATE public.vocabularies
SET example_hanzi = '国家宪法明确赋予了各民族公民享有同等受教育、享有基本医疗与依法参与国家事务管理的崇高平等权利。',
    example_pinyin = 'Guójiā xiànfǎ míngquè fùyǔ le gè mínzú gōngmín xiǎngyǒu tóngděng shòu jiàoyù, xiǎngyǒu jīběn yīliáo yǔ yīfǎ cānyù guójiā shìwù guǎnlǐ de chónggāo píngděng quánlì.',
    example_vi = 'Hiến pháp quốc gia trao cho công dân các dân tộc quyền bình đẳng cao cả được học tập bình đẳng, hưởng y tế cơ bản và tham gia quản lý công việc đất nước theo pháp luật.'
WHERE id = '6e83085a-4ac9-41f4-a56d-a03dd4a0af3a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '6e83085a-4ac9-41f4-a56d-a03dd4a0af3a', '国家宪法明确赋予了各民族公民享有同等受教育、享有基本医疗与依法参与国家事务管理的崇高平等权利。', 'Guójiā xiànfǎ míngquè fùyǔ le gè mínzú gōngmín xiǎngyǒu tóngděng shòu jiàoyù, xiǎngyǒu jīběn yīliáo yǔ yīfǎ cānyù guójiā shìwù guǎnlǐ de chónggāo píngděng quánlì.', 'Hiến pháp quốc gia trao cho công dân các dân tộc quyền bình đẳng cao cả được học tập bình đẳng, hưởng y tế cơ bản và tham gia quản lý công việc đất nước theo pháp luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '6e83085a-4ac9-41f4-a56d-a03dd4a0af3a'
);

-- [平方] (píngfāng): bình phương, mét vuông
UPDATE public.vocabularies
SET example_hanzi = '新建成投入使用的国家数字科技展览馆总占地面积达数万平方米，成为全国最大的数字化科普展示基地之一。',
    example_pinyin = 'Xīn jiànchéng tóurù shǐyòng de guójiā shùzì kējì zhǎnlǎnguǎn zǒng zhàndì miànjī dá shùwàn píngfāngmǐ, chéngwéi quánguó zuì dà de shùzìhuà kěpǔ zhǎnshì jīdì zhī yī.',
    example_vi = 'Nhà triển lãm khoa học công nghệ số quốc gia mới xây dựng đưa vào sử dụng có tổng diện tích sàn lên tới hàng vạn mét vuông bình phương, trở thành một trong những cơ sở triển lãm phổ biến khoa học số lớn nhất cả nước.'
WHERE id = '643a2a18-6104-47cd-8582-d270184d540f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '643a2a18-6104-47cd-8582-d270184d540f', '新建成投入使用的国家数字科技展览馆总占地面积达数万平方米，成为全国最大的数字化科普展示基地之一。', 'Xīn jiànchéng tóurù shǐyòng de guójiā shùzì kējì zhǎnlǎnguǎn zǒng zhàndì miànjī dá shùwàn píngfāngmǐ, chéngwéi quánguó zuì dà de shùzìhuà kěpǔ zhǎnshì jīdì zhī yī.', 'Nhà triển lãm khoa học công nghệ số quốc gia mới xây dựng đưa vào sử dụng có tổng diện tích sàn lên tới hàng vạn mét vuông bình phương, trở thành một trong những cơ sở triển lãm phổ biến khoa học số lớn nhất cả nước.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '643a2a18-6104-47cd-8582-d270184d540f'
);

-- [评估] (pínggū): đánh giá, định giá
UPDATE public.vocabularies
SET example_hanzi = '第三方权威专业环境监测机构受委托对重大水利工程施工对沿线珍稀野生鱼类生态栖息地的影响进行了客观评估。',
    example_pinyin = 'Dì-sān fāng quánwēi zhuānyè huánjìng jiānkòng jīgòu shòu wěituō duì zhòngdà shuǐlì gōngchéng shīgōng duì yánxiàn zhēnxī yěshēng yúlèi shēngtài qīxīdì de yǐngxiǎng jìnxíng le kèguān pínggū.',
    example_vi = 'Cơ quan quan trắc môi trường chuyên nghiệp có uy tín bên thứ ba được ủy thác tiến hành đánh giá định giá khách quan tác động của việc thi công công trình thủy lợi trọng đại tới môi trường sống của các loài cá hoang dã quý hiếm.'
WHERE id = 'aef39cbb-aed0-4e9c-ac39-0b89e3cf8eb1' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'aef39cbb-aed0-4e9c-ac39-0b89e3cf8eb1', '第三方权威专业环境监测机构受委托对重大水利工程施工对沿线珍稀野生鱼类生态栖息地的影响进行了客观评估。', 'Dì-sān fāng quánwēi zhuānyè huánjìng jiānkòng jīgòu shòu wěituō duì zhòngdà shuǐlì gōngchéng shīgōng duì yánxiàn zhēnxī yěshēng yúlèi shēngtài qīxīdì de yǐngxiǎng jìnxíng le kèguān pínggū.', 'Cơ quan quan trắc môi trường chuyên nghiệp có uy tín bên thứ ba được ủy thác tiến hành đánh giá định giá khách quan tác động của việc thi công công trình thủy lợi trọng đại tới môi trường sống của các loài cá hoang dã quý hiếm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'aef39cbb-aed0-4e9c-ac39-0b89e3cf8eb1'
);

-- [评论] (pínglùn): bình luận
UPDATE public.vocabularies
SET example_hanzi = '这部深刻揭示人性格局与时代变迁的优秀现实主义文学力作，在主流文学报刊与学术期刊上赢得了各界学者的一致好评评论。',
    example_pinyin = 'Zhè bù shēnrù jiēshì rénxìng géjú yǔ shídài biànqiān de yōuxiù xiànshízhǔyì wénxué lìzuò, zài zhǔliú wénxué bàokān yǔ xuéshù qīkān shang yíngdé le gèjiè xuézhě de yízhì hǎopíng pínglùn.',
    example_vi = 'Tác phẩm văn học hiện thực xuất sắc vạch trần sâu sắc nhân tính và những biến thiên thời đại này đã nhận được những lời bình luận khen ngợi đồng lòng của các giới học giả trên các ấn phẩm văn học học thuật chính thống.'
WHERE id = 'b6794063-cf08-4b28-ba71-d024ca17de06' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'b6794063-cf08-4b28-ba71-d024ca17de06', '这部深刻揭示人性格局与时代变迁的优秀现实主义文学力作，在主流文学报刊与学术期刊上赢得了各界学者的一致好评评论。', 'Zhè bù shēnrù jiēshì rénxìng géjú yǔ shídài biànqiān de yōuxiù xiànshízhǔyì wénxué lìzuò, zài zhǔliú wénxué bàokān yǔ xuéshù qīkān shang yíngdé le gèjiè xuézhě de yízhì hǎopíng pínglùn.', 'Tác phẩm văn học hiện thực xuất sắc vạch trần sâu sắc nhân tính và những biến thiên thời đại này đã nhận được những lời bình luận khen ngợi đồng lòng của các giới học giả trên các ấn phẩm văn học học thuật chính thống.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'b6794063-cf08-4b28-ba71-d024ca17de06'
);

-- [贫困] (pínkùn): nghèo khó, bần cùng
UPDATE public.vocabularies
SET example_hanzi = '通过实施精准扶贫与乡村全面振兴战略，我国彻底消除了绝对贫困现象，实现了几代人为之奋斗的全面小康宏伟目标。',
    example_pinyin = 'Tōngguò shíshī jīngzhǔn fúpín yǔ xiāngcūn quánmiàn zhènxīng zhànlüè, wǒ guó chèdǐ xiāochú le juéduì pínkùn xiànxiàng, shíxiàn le jǐ dài rén wèizhī fèndòu de quánmiàn xiǎokāng hóngwěi mùbiāo.',
    example_vi = 'Thông qua triển khai chiến lược xóa đói giảm nghèo chính xác và chấn hưng toàn diện nông thôn, nước ta đã xóa bỏ triệt để hiện tượng nghèo khó bần cùng tuyệt đối, thực hiện mục tiêu vĩ đại ấm no toàn diện mà mấy thế hệ từng phấn đấu.'
WHERE id = 'bfba7a3c-fa65-4f1c-9a95-5a7513721959' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'bfba7a3c-fa65-4f1c-9a95-5a7513721959', '通过实施精准扶贫与乡村全面振兴战略，我国彻底消除了绝对贫困现象，实现了几代人为之奋斗的全面小康宏伟目标。', 'Tōngguò shíshī jīngzhǔn fúpín yǔ xiāngcūn quánmiàn zhènxīng zhànlüè, wǒ guó chèdǐ xiāochú le juéduì pínkùn xiànxiàng, shíxiàn le jǐ dài rén wèizhī fèndòu de quánmiàn xiǎokāng hóngwěi mùbiāo.', 'Thông qua triển khai chiến lược xóa đói giảm nghèo chính xác và chấn hưng toàn diện nông thôn, nước ta đã xóa bỏ triệt để hiện tượng nghèo khó bần cùng tuyệt đối, thực hiện mục tiêu vĩ đại ấm no toàn diện mà mấy thế hệ từng phấn đấu.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'bfba7a3c-fa65-4f1c-9a95-5a7513721959'
);

-- [频率] (pínlǜ): tần số, tần suất
UPDATE public.vocabularies
SET example_hanzi = '随着国际经贸往来的日益繁密，枢纽国际机场不断优化调整重点洲际商业航线的航班起降班次频率。',
    example_pinyin = 'Suízhe guójì jīngmào wǎnglái de rìyì fánmì, shūniǔ guójì jīchǎng búduàn yōuhuà tiáozhěng zhòngdiǎn zhōujì shāngyè hángxiàn de hángbān qǐjiàng bāncì pínlǜ.',
    example_vi = 'Cùng với việc giao thương quốc tế ngày một tấp nập, sân bay quốc tế đầu mối không ngừng tối ưu hóa điều chỉnh tần suất tần số cất hạ cánh các chuyến bay thương mại liên lục địa trọng điểm.'
WHERE id = '9859abef-1b54-41f5-bf68-ab497decacaa' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9859abef-1b54-41f5-bf68-ab497decacaa', '随着国际经贸往来的日益繁密，枢纽国际机场不断优化调整重点洲际商业航线的航班起降班次频率。', 'Suízhe guójì jīngmào wǎnglái de rìyì fánmì, shūniǔ guójì jīchǎng búduàn yōuhuà tiáozhěng zhòngdiǎn zhōujì shāngyè hángxiàn de hángbān qǐjiàng bāncì pínlǜ.', 'Cùng với việc giao thương quốc tế ngày một tấp nập, sân bay quốc tế đầu mối không ngừng tối ưu hóa điều chỉnh tần suất tần số cất hạ cánh các chuyến bay thương mại liên lục địa trọng điểm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9859abef-1b54-41f5-bf68-ab497decacaa'
);

-- [泼] (pō): hắt, tạt, dội
UPDATE public.vocabularies
SET example_hanzi = '云南西双版纳傣族自治州在每年清凉盛大的传统泼水节期间，各族群众欢聚一堂、互泼吉祥圣水表达美好祝福。',
    example_pinyin = 'Yúnnán Xīshuāngbǎnnà Dǎizú zìzhìzhōu zài měi nián qīngliáng shèngdà de chuántǒng pōshuǐjié qījiān, gè zú qúnzhòng huānjù-yìtáng, hù pō jíxiáng shèngshuǐ biǎodá měihǎo zhùfú.',
    example_vi = 'Châu tự trị dân tộc Thái Tây Song Bản Nạp Vân Nam mỗi dịp lễ hội té nước truyền thống mát lành tưng bừng hàng năm, đồng bào các dân tộc tụ họp té tạt nước thiêng cát tường vào nhau để chúc phúc tốt lành.'
WHERE id = '0cfcb575-1c04-4100-a9c6-00475b88715f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0cfcb575-1c04-4100-a9c6-00475b88715f', '云南西双版纳傣族自治州在每年清凉盛大的传统泼水节期间，各族群众欢聚一堂、互泼吉祥圣水表达美好祝福。', 'Yúnnán Xīshuāngbǎnnà Dǎizú zìzhìzhōu zài měi nián qīngliáng shèngdà de chuántǒng pōshuǐjié qījiān, gè zú qúnzhòng huānjù-yìtáng, hù pō jíxiáng shèngshuǐ biǎodá měihǎo zhùfú.', 'Châu tự trị dân tộc Thái Tây Song Bản Nạp Vân Nam mỗi dịp lễ hội té nước truyền thống mát lành tưng bừng hàng năm, đồng bào các dân tộc tụ họp té tạt nước thiêng cát tường vào nhau để chúc phúc tốt lành.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0cfcb575-1c04-4100-a9c6-00475b88715f'
);

-- [坡] (pō): dốc, sườn dốc
UPDATE public.vocabularies
SET example_hanzi = '地质监测技术人员在持续降雨的盘山公路陡坡地段安装了边坡位移监测雷达，防止山体滑坡灾害发生。',
    example_pinyin = 'Dìzhì jiānkè jìshù rényuán zài chíxù jiàngyǔ de pánshān gōnglù dǒupō dìduàn ānzhuāng le biānpō wèiyí jiānkòng léidá, fángzhǐ shāntǐ huápō zāihài fāshēng.',
    example_vi = 'Kỹ thuật viên quan trắc địa chất tại đoạn dốc đứng của đường đèo quanh co mưa dầm liên miên đã lắp đặt radar đo độ trượt sườn dốc để ngăn ngừa thiên tai sạt lở núi.'
WHERE id = '78d3c333-e8d1-4533-bd1b-0587e1493605' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '78d3c333-e8d1-4533-bd1b-0587e1493605', '地质监测技术人员在持续降雨的盘山公路陡坡地段安装了边坡位移监测雷达，防止山体滑坡灾害发生。', 'Dìzhì jiānkè jìshù rényuán zài chíxù jiàngyǔ de pánshān gōnglù dǒupō dìduàn ānzhuāng le biānpō wèiyí jiānkòng léidá, fángzhǐ shāntǐ huápō zāihài fāshēng.', 'Kỹ thuật viên quan trắc địa chất tại đoạn dốc đứng của đường đèo quanh co mưa dầm liên miên đã lắp đặt radar đo độ trượt sườn dốc để ngăn ngừa thiên tai sạt lở núi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '78d3c333-e8d1-4533-bd1b-0587e1493605'
);

-- [破产] (pòchǎn): phá sản
UPDATE public.vocabularies
SET example_hanzi = '由于长期盲目激进扩张且背负巨额高息债务，这家曾风光一时的跨国大型房地产开发企业最终依法宣告破产重组。',
    example_pinyin = 'Yóuyú chángqī mángmù jījìn kuòzhāng qiě bēifù jù''é gāoxī zhàiwù, zhè jiā céng fēngguāng yìshí de kuàguó dàxíng fángdìchǎn kāifā qǐyè zuìzhōng yīfǎ xuāngào pòchǎn chóngzǔ.',
    example_vi = 'Do mở rộng mù quáng liều lĩnh lâu ngày lại gánh vác nợ xấu lãi suất cao khổng lồ, tập đoàn phát triển bất động sản xuyên quốc gia từng một thời vang bóng rốt cuộc đã tuyên bố phá sản tái cơ cấu theo luật.'
WHERE id = 'a3d22d39-b7fd-4bbf-a60b-f85f5d5a95cf' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a3d22d39-b7fd-4bbf-a60b-f85f5d5a95cf', '由于长期盲目激进扩张且背负巨额高息债务，这家曾风光一时的跨国大型房地产开发企业最终依法宣告破产重组。', 'Yóuyú chángqī mángmù jījìn kuòzhāng qiě bēifù jù''é gāoxī zhàiwù, zhè jiā céng fēngguāng yìshí de kuàguó dàxíng fángdìchǎn kāifā qǐyè zuìzhōng yīfǎ xuāngào pòchǎn chóngzǔ.', 'Do mở rộng mù quáng liều lĩnh lâu ngày lại gánh vác nợ xấu lãi suất cao khổng lồ, tập đoàn phát triển bất động sản xuyên quốc gia từng một thời vang bóng rốt cuộc đã tuyên bố phá sản tái cơ cấu theo luật.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a3d22d39-b7fd-4bbf-a60b-f85f5d5a95cf'
);

-- [迫切] (pòqiè): cấp bách, bức thiết
UPDATE public.vocabularies
SET example_hanzi = '在全球气候变化极端严峻的宏观背景下，加速推进工业绿色能源转型与生态环境保护成为国际社会最为迫切的时代课题。',
    example_pinyin = 'Zài quánqiú qìhòu biànhuà jíduān yánjùn de hóngguān bèijǐng xià, jiāsù tuījìn gōngyè lǜsè néngyuán zhuǎnxíng yǔ shēngtài huánjìng bǎohù chéngwéi guójì shèhuì zuìwéi pòqiè de shídài kètí.',
    example_vi = 'Trong bối cảnh biến đổi khí hậu toàn cầu cực đoan gay gắt, đẩy nhanh chuyển đổi năng lượng xanh công nghiệp và bảo vệ môi trường sinh thái đã trở thành chuyên đề thời đại cấp bách bức thiết nhất của cộng đồng quốc tế.'
WHERE id = '92ac8d4c-a3c0-40d1-bfb2-f1bc282feaa6' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '92ac8d4c-a3c0-40d1-bfb2-f1bc282feaa6', '在全球气候变化极端严峻的宏观背景下，加速推进工业绿色能源转型与生态环境保护成为国际社会最为迫切的时代课题。', 'Zài quánqiú qìhòu biànhuà jíduān yánjùn de hóngguān bèijǐng xià, jiāsù tuījìn gōngyè lǜsè néngyuán zhuǎnxíng yǔ shēngtài huánjìng bǎohù chéngwéi guójì shèhuì zuìwéi pòqiè de shídài kètí.', 'Trong bối cảnh biến đổi khí hậu toàn cầu cực đoan gay gắt, đẩy nhanh chuyển đổi năng lượng xanh công nghiệp và bảo vệ môi trường sinh thái đã trở thành chuyên đề thời đại cấp bách bức thiết nhất của cộng đồng quốc tế.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '92ac8d4c-a3c0-40d1-bfb2-f1bc282feaa6'
);

-- [铺] (pū): trải, lát
UPDATE public.vocabularies
SET example_hanzi = '市政园林绿化工程施工队伍在宽阔的市民休闲广场步行道两侧，整整齐齐地铺上了一块块平整防滑的大理石板砖。',
    example_pinyin = 'Shìzhèng yuánlín lǜhuà gōngchéng shīgōng duìwǔ zài kuānkuò de shìmín xiūxián guǎngchǎng bùxíngdào liǎngcè, zhěngzhěng-qíqí de pū shang le yí kuài kuài píngzhěng fánghuá de dàlǐshí bǎnzhuān.',
    example_vi = 'Đội ngũ thi công công trình công viên cây xanh đô thị ở hai bên lối đi bộ quảng trường thư giãn rộng rãi của người dân đã lát trải ngay ngắn từng viên gạch cẩm thạch phẳng phiu chống trượt.'
WHERE id = '9b052b41-5125-4d72-8f58-7840d61edcc7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9b052b41-5125-4d72-8f58-7840d61edcc7', '市政园林绿化工程施工队伍在宽阔的市民休闲广场步行道两侧，整整齐齐地铺上了一块块平整防滑的大理石板砖。', 'Shìzhèng yuánlín lǜhuà gōngchéng shīgōng duìwǔ zài kuānkuò de shìmín xiūxián guǎngchǎng bùxíngdào liǎngcè, zhěngzhěng-qíqí de pū shang le yí kuài kuài píngzhěng fánghuá de dàlǐshí bǎnzhuān.', 'Đội ngũ thi công công trình công viên cây xanh đô thị ở hai bên lối đi bộ quảng trường thư giãn rộng rãi của người dân đã lát trải ngay ngắn từng viên gạch cẩm thạch phẳng phiu chống trượt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9b052b41-5125-4d72-8f58-7840d61edcc7'
);

-- [扑] (pū): vồ, lao tới, đập
UPDATE public.vocabularies
SET example_hanzi = '训练有素的搜救犬在茂密草丛中敏锐嗅到生命求救气息后，立刻像离弦之箭一般迅速向坍塌废墟深处扑了过去。',
    example_pinyin = 'Xùnliàn-yǒusù de sōujiùquǎn zài màomì cǎocóng zhōng mǐnruì xiù dào shēngmìng qiújiù qìxī hòu, lìkè xiàng líxián-zhī-jiàn yìbān xùnsù xiàng tāntā fèixū shēnchù pū le guòqù.',
    example_vi = 'Chú chó cứu hộ được huấn luyện thuần thục sau khi ngửi thấy hơi thở cầu cứu sự sống trong bụi cỏ rậm rạp đã lập tức như mũi tên bật khỏi dây cung lao vồ về phía sâu trong đống đổ nát.'
WHERE id = '97bce18e-a236-4680-97d6-51841f03aebc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '97bce18e-a236-4680-97d6-51841f03aebc', '训练有素的搜救犬在茂密草丛中敏锐嗅到生命求救气息后，立刻像离弦之箭一般迅速向坍塌废墟深处扑了过去。', 'Xùnliàn-yǒusù de sōujiùquǎn zài màomì cǎocóng zhōng mǐnruì xiù dào shēngmìng qiújiù qìxī hòu, lìkè xiàng líxián-zhī-jiàn yìbān xùnsù xiàng tāntā fèixū shēnchù pū le guòqù.', 'Chú chó cứu hộ được huấn luyện thuần thục sau khi ngửi thấy hơi thở cầu cứu sự sống trong bụi cỏ rậm rạp đã lập tức như mũi tên bật khỏi dây cung lao vồ về phía sâu trong đống đổ nát.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '97bce18e-a236-4680-97d6-51841f03aebc'
);

-- [朴素] (pǔsù): giản dị, mộc mạc
UPDATE public.vocabularies
SET example_hanzi = '这位著作等身、享誉海内外的中国科学院老院士，在日常生活中始终保持着省吃俭用、衣着朴素的优良学者作风。',
    example_pinyin = 'Zhè wèi zhùzuò-děngshēn, xiǎngyù hǎinèiwài de Zhōngguó Kēxuéyuàn lǎo yuànshì, zài rìcháng shēnghuó zhōng shǐzhōng bǎochí zhe shěngchī-jiǎnyòng, yīzhuó pǔsù de yōuliáng xuézhě zuòfēng.',
    example_vi = 'Vị viện sĩ lão thành Viện Hàn lâm Khoa học Trung Quốc công trình đầy mình nức tiếng gần xa trong đời sống thường ngày luôn giữ vững phong cách nhà học giả ưu tú ăn tiêu cần kiệm, ăn mặc mộc mạc giản dị.'
WHERE id = '7678c4a1-3d10-4d84-984e-e2260b55690f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7678c4a1-3d10-4d84-984e-e2260b55690f', '这位著作等身、享誉海内外的中国科学院老院士，在日常生活中始终保持着省吃俭用、衣着朴素的优良学者作风。', 'Zhè wèi zhùzuò-děngshēn, xiǎngyù hǎinèiwài de Zhōngguó Kēxuéyuàn lǎo yuànshì, zài rìcháng shēnghuó zhōng shǐzhōng bǎochí zhe shěngchī-jiǎnyòng, yīzhuó pǔsù de yōuliáng xuézhě zuòfēng.', 'Vị viện sĩ lão thành Viện Hàn lâm Khoa học Trung Quốc công trình đầy mình nức tiếng gần xa trong đời sống thường ngày luôn giữ vững phong cách nhà học giả ưu tú ăn tiêu cần kiệm, ăn mặc mộc mạc giản dị.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7678c4a1-3d10-4d84-984e-e2260b55690f'
);

-- [恰当] (qià dàng): thích đáng, phù hợp
UPDATE public.vocabularies
SET example_hanzi = '在与外宾进行高级商务与外交礼仪沟通时，外交官应当根据具体交往语境，选用恰当得体的礼貌用语与称谓。',
    example_pinyin = 'Zài yǔ wàibīn jìnxíng gāojí shāngwù yǔ wàijiāo lǐyí gōutōng shí, wàijiāoguān yīngdāng gēnjù jùtǐ jiāowǎng yǔjìng, xuǎnyòng qiàdàng détǐ de lǐmào yòngyǔ yǔ chēngwèi.',
    example_vi = 'Khi giao tiếp nghi lễ ngoại giao và thương mại cấp cao với khách nước ngoài, nhà ngoại giao nên căn cứ ngữ cảnh giao tiếp cụ thể chọn dùng từ ngữ lịch thiệp và xưng hô thích đáng đúng mực.'
WHERE id = '2c836217-209e-4519-b163-cd6cded4cb62' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2c836217-209e-4519-b163-cd6cded4cb62', '在与外宾进行高级商务与外交礼仪沟通时，外交官应当根据具体交往语境，选用恰当得体的礼貌用语与称谓。', 'Zài yǔ wàibīn jìnxíng gāojí shāngwù yǔ wàijiāo lǐyí gōutōng shí, wàijiāoguān yīngdāng gēnjù jùtǐ jiāowǎng yǔjìng, xuǎnyòng qiàdàng détǐ de lǐmào yòngyǔ yǔ chēngwèi.', 'Khi giao tiếp nghi lễ ngoại giao và thương mại cấp cao với khách nước ngoài, nhà ngoại giao nên căn cứ ngữ cảnh giao tiếp cụ thể chọn dùng từ ngữ lịch thiệp và xưng hô thích đáng đúng mực.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2c836217-209e-4519-b163-cd6cded4cb62'
);

-- [牵] (qiān): dắt, kéo
UPDATE public.vocabularies
SET example_hanzi = '夕阳余晖下，慈祥的爷爷手里紧紧牵着刚学会走路的小孙女稚嫩的小手，漫步在公园开满鲜花的石子小路上。',
    example_pinyin = 'Xīyáng yúhuī xià, cíxiáng de yéye shǒulǐ jǐnjǐn qiān zhe gāng xuéhuì zǒulù de xiǎo sūnnǚ zhìnèn de xiǎoshǒu, mànbù zài gōngyuán kāi mǎn xiānhuā de shízǐ xiǎolù shang.',
    example_vi = 'Dưới ánh hoàng hôn chiều tà, người ông hiền từ nắm dắt chặt bàn tay nhỏ nhắn non nớt của cô cháu gái vừa chập chững biết đi, tản bộ trên con đường sỏi đầy hoa nở trong công viên.'
WHERE id = '181be991-9dde-4f3e-89a4-743750297429' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '181be991-9dde-4f3e-89a4-743750297429', '夕阳余晖下，慈祥的爷爷手里紧紧牵着刚学会走路的小孙女稚嫩的小手，漫步在公园开满鲜花的石子小路上。', 'Xīyáng yúhuī xià, cíxiáng de yéye shǒulǐ jǐnjǐn qiān zhe gāng xuéhuì zǒulù de xiǎo sūnnǚ zhìnèn de xiǎoshǒu, mànbù zài gōngyuán kāi mǎn xiānhuā de shízǐ xiǎolù shang.', 'Dưới ánh hoàng hôn chiều tà, người ông hiền từ nắm dắt chặt bàn tay nhỏ nhắn non nớt của cô cháu gái vừa chập chững biết đi, tản bộ trên con đường sỏi đầy hoa nở trong công viên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '181be991-9dde-4f3e-89a4-743750297429'
);

-- [枪] (qiāng): khẩu súng
UPDATE public.vocabularies
SET example_hanzi = '在奥运会男子五十米步枪三姿决赛激烈角逐中，我国年轻神枪手沉着冷静击发最后一枪，成功逆转勇夺金牌。',
    example_pinyin = 'Zài Àoyùnhuì nánzǐ wǔshí mǐ bùqiāng sānzī juésài jīliè jiǎozhú zhōng, wǒ guó niánqīng shénqiāngshǒu chénzhuó-lěngjìng jīfā zuìhòu yì qiāng, chénggōng nìzhuǎn yǒngduó jīnpái.',
    example_vi = 'Trong cuộc so tài nảy lửa tại chung kết súng trường 50m ba tư thế nam Olympic, tay súng thần trẻ tuổi nước ta đã bình tĩnh siết phát súng cuối cùng, lội ngược dòng ngoạn mục đoạt huy chương vàng.'
WHERE id = '543de345-8d6a-41a1-bb15-32b1ce0a6e6a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '543de345-8d6a-41a1-bb15-32b1ce0a6e6a', '在奥运会男子五十米步枪三姿决赛激烈角逐中，我国年轻神枪手沉着冷静击发最后一枪，成功逆转勇夺金牌。', 'Zài Àoyùnhuì nánzǐ wǔshí mǐ bùqiāng sānzī juésài jīliè jiǎozhú zhōng, wǒ guó niánqīng shénqiāngshǒu chénzhuó-lěngjìng jīfā zuìhòu yì qiāng, chénggōng nìzhuǎn yǒngduó jīnpái.', 'Trong cuộc so tài nảy lửa tại chung kết súng trường 50m ba tư thế nam Olympic, tay súng thần trẻ tuổi nước ta đã bình tĩnh siết phát súng cuối cùng, lội ngược dòng ngoạn mục đoạt huy chương vàng.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '543de345-8d6a-41a1-bb15-32b1ce0a6e6a'
);

-- [强迫] (qiǎng pò): bắt buộc, ép buộc
UPDATE public.vocabularies
SET example_hanzi = '劳动法明确严厉禁止任何用人单位采取暴力、威胁或者非法限制人身自由等手段强迫劳动者进行超时超负荷劳动。',
    example_pinyin = 'Láodòngfǎ míngquè yánlì jìnzhǐ rènhé yòngrén dānwèi cǎiqǔ bàolì, wēixié huòzhě fēifǎ xiànzhì rénshēn zìyóu děng shǒuduàn qiǎngpò láodòngzhě jìnxíng chāoshí chāo-fùhè láodòng.',
    example_vi = 'Luật Lao động quy định rõ nghiêm cấm mọi đơn vị sử dụng lao động dùng bạo lực, đe dọa hoặc hạn chế tự do thân thể trái phép để ép buộc bắt buộc người lao động làm việc quá giờ quá tải.'
WHERE id = 'd666b077-236c-4052-8f39-952323b66eb4' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd666b077-236c-4052-8f39-952323b66eb4', '劳动法明确严厉禁止任何用人单位采取暴力、威胁或者非法限制人身自由等手段强迫劳动者进行超时超负荷劳动。', 'Láodòngfǎ míngquè yánlì jìnzhǐ rènhé yòngrén dānwèi cǎiqǔ bàolì, wēixié huòzhě fēifǎ xiànzhì rénshēn zìyóu děng shǒuduàn qiǎngpò láodòngzhě jìnxíng chāoshí chāo-fùhè láodòng.', 'Luật Lao động quy định rõ nghiêm cấm mọi đơn vị sử dụng lao động dùng bạo lực, đe dọa hoặc hạn chế tự do thân thể trái phép để ép buộc bắt buộc người lao động làm việc quá giờ quá tải.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd666b077-236c-4052-8f39-952323b66eb4'
);

-- [前景] (qiánjǐng): triển vọng, tiền cảnh
UPDATE public.vocabularies
SET example_hanzi = '随着全球清洁能源产业技术链的成熟与大规模落地推广，以太阳能与氢能为核心的绿色经济展现出无比广阔的投资前景。',
    example_pinyin = 'Suízhe quánqiú qīngjié néngyuán chǎnyè jìshùliàn de chéngshú yǔ dà guīmó luòdì tuīguǎng, yǐ tàiyángnéng yǔ qīngnéng wèi héxīn de lǜsè jīngjì zhǎnxiàn chū wúbǐ guǎngkuò de tóuzī qiánjǐng.',
    example_vi = 'Cùng với sự chín muồi và triển khai quy mô lớn của chuỗi công nghệ ngành năng lượng sạch toàn cầu, nền kinh tế xanh lấy năng lượng mặt trời và hydro làm cốt lõi mở ra triển vọng đầu tư vô cùng rộng lớn.'
WHERE id = '7ecee42e-0c2b-4eb8-96a5-ec50446dc9a8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7ecee42e-0c2b-4eb8-96a5-ec50446dc9a8', '随着全球清洁能源产业技术链的成熟与大规模落地推广，以太阳能与氢能为核心的绿色经济展现出无比广阔的投资前景。', 'Suízhe quánqiú qīngjié néngyuán chǎnyè jìshùliàn de chéngshú yǔ dà guīmó luòdì tuīguǎng, yǐ tàiyángnéng yǔ qīngnéng wèi héxīn de lǜsè jīngjì zhǎnxiàn chū wúbǐ guǎngkuò de tóuzī qiánjǐng.', 'Cùng với sự chín muồi và triển khai quy mô lớn của chuỗi công nghệ ngành năng lượng sạch toàn cầu, nền kinh tế xanh lấy năng lượng mặt trời và hydro làm cốt lõi mở ra triển vọng đầu tư vô cùng rộng lớn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7ecee42e-0c2b-4eb8-96a5-ec50446dc9a8'
);

-- [潜力] (qiánlì): tiềm lực, tiềm năng
UPDATE public.vocabularies
SET example_hanzi = '广阔的农村消费市场以及数字化电子商务的普及，展现出了推动国民经济长期高质量稳定增长的巨大内需潜力。',
    example_pinyin = 'Guǎngkuò de nóngcūn xiāofèi shìchǎng yǐjí shùzìhuà diànzǐ shāngwù de pǔjí, zhǎnxiàn chū le tuīdòng guómín jīngjì chángqī gāo zhìliàng wěndìng zēngzhǎng de jùdà nèixū qiánlì.',
    example_vi = 'Thị trường tiêu dùng nông thôn rộng lớn cùng sự phổ cập thương mại điện tử số hóa đã bộc lộ tiềm lực tiềm năng cầu nội địa khổng lồ thúc đẩy kinh tế quốc dân tăng trưởng ổn định chất lượng cao lâu dài.'
WHERE id = '060a301e-269d-4239-89cc-c70a308eafbe' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '060a301e-269d-4239-89cc-c70a308eafbe', '广阔的农村消费市场以及数字化电子商务的普及，展现出了推动国民经济长期高质量稳定增长的巨大内需潜力。', 'Guǎngkuò de nóngcūn xiāofèi shìchǎng yǐjí shùzìhuà diànzǐ shāngwù de pǔjí, zhǎnxiàn chū le tuīdòng guómín jīngjì chángqī gāo zhìliàng wěndìng zēngzhǎng de jùdà nèixū qiánlì.', 'Thị trường tiêu dùng nông thôn rộng lớn cùng sự phổ cập thương mại điện tử số hóa đã bộc lộ tiềm lực tiềm năng cầu nội địa khổng lồ thúc đẩy kinh tế quốc dân tăng trưởng ổn định chất lượng cao lâu dài.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '060a301e-269d-4239-89cc-c70a308eafbe'
);

-- [前提] (qiántí): tiền đề
UPDATE public.vocabularies
SET example_hanzi = '深入开展任何形式的双边与多边国际经贸务实合作，都必须建立在互相尊重国家主权与核心利益的根本政治前提之上。',
    example_pinyin = 'Shēnrù kāizhǎn rènhé xíngshì de shuāngbiān yǔ duōbiān guójì jīngmào wùshí hézuò, dōu bìxū jiànlì zài hùxiāng zūnzhòng guójiā zhǔquán yǔ héxīn lìyì de gēnběn zhèngzhì qiántí zhī shàng.',
    example_vi = 'Triển khai sâu rộng bất kỳ hình thức hợp tác kinh tế thương mại thực chất song phương hay đa phương quốc tế nào đều phải xây dựng trên tiền đề chính trị căn bản tôn trọng lẫn nhau về chủ quyền và lợi ích cốt lõi.'
WHERE id = '968d8735-b2b6-4f46-a792-984ee300ac23' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '968d8735-b2b6-4f46-a792-984ee300ac23', '深入开展任何形式的双边与多边国际经贸务实合作，都必须建立在互相尊重国家主权与核心利益的根本政治前提之上。', 'Shēnrù kāizhǎn rènhé xíngshì de shuāngbiān yǔ duōbiān guójì jīngmào wùshí hézuò, dōu bìxū jiànlì zài hùxiāng zūnzhòng guójiā zhǔquán yǔ héxīn lìyì de gēnběn zhèngzhì qiántí zhī shàng.', 'Triển khai sâu rộng bất kỳ hình thức hợp tác kinh tế thương mại thực chất song phương hay đa phương quốc tế nào đều phải xây dựng trên tiền đề chính trị căn bản tôn trọng lẫn nhau về chủ quyền và lợi ích cốt lõi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '968d8735-b2b6-4f46-a792-984ee300ac23'
);

-- [谦虚] (qiānxū): khiêm tốn
UPDATE public.vocabularies
SET example_hanzi = '真正有大才干、取得杰出成就的大学问家，在为人处世和对待年轻后辈时往往始终保持着虚怀若谷、十分谦虚的态度。',
    example_pinyin = 'Zhēnzhèng yǒu dà cáigàn, qǔdé jiéchū chéngjiù de dà xuéwènjiā, zài wéirén-chǔshì hé duìdài niánqīng hòubèi shí wǎngwǎng shǐzhōng bǎochí zhe xūhuáiruògǔ, shífēn qiānxū de tàidù.',
    example_vi = 'Những học giả lớn thực sự có tài năng uyên bác gặt hái thành tựu kiệt xuất trong đối nhân xử thế và ứng xử với thế hệ trẻ luôn giữ vững thái độ khiêm nhường khiêm tốn như thung lũng đón gió.'
WHERE id = '67b6a679-8def-4efb-bb9e-6fe026fca18f' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '67b6a679-8def-4efb-bb9e-6fe026fca18f', '真正有大才干、取得杰出成就的大学问家，在为人处世和对待年轻后辈时往往始终保持着虚怀若谷、十分谦虚的态度。', 'Zhēnzhèng yǒu dà cáigàn, qǔdé jiéchū chéngjiù de dà xuéwènjiā, zài wéirén-chǔshì hé duìdài niánqīng hòubèi shí wǎngwǎng shǐzhōng bǎochí zhe xūhuáiruògǔ, shífēn qiānxū de tàidù.', 'Những học giả lớn thực sự có tài năng uyên bác gặt hái thành tựu kiệt xuất trong đối nhân xử thế và ứng xử với thế hệ trẻ luôn giữ vững thái độ khiêm nhường khiêm tốn như thung lũng đón gió.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '67b6a679-8def-4efb-bb9e-6fe026fca18f'
);

-- [瞧] (qiáo): nhìn, xem
UPDATE public.vocabularies
SET example_hanzi = '瞧，那群英姿飒爽的少年海军军校学员迈着刚劲有力的矫健步伐走来，眼神中充满了保卫祖国海疆的坚定自信。',
    example_pinyin = 'Qiáo, nà qún yīngzī-sàshuǎng de shàonián hǎijūn jūnxiào xuéyuán mài zhe gāngjìn yǒulì de jiǎojiàn bùfá zǒu lái, yǎnshén zhōng chōngmǎn le bǎowèi zǔguó hǎijiāng de jiāndìng zìxìn.',
    example_vi = 'Nhìn kìa, đám học viên trường sĩ quan hải quân thiếu niên oai phong lẫm liệt đang rảo bước chân cứng cáp khỏe khoắn bước tới, trong ánh mắt ngập tràn sự tự tin kiên định bảo vệ biển trời tổ quốc.'
WHERE id = 'd7dc9e14-7532-48eb-8520-12da7d49eb1e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'd7dc9e14-7532-48eb-8520-12da7d49eb1e', '瞧，那群英姿飒爽的少年海军军校学员迈着刚劲有力的矫健步伐走来，眼神中充满了保卫祖国海疆的坚定自信。', 'Qiáo, nà qún yīngzī-sàshuǎng de shàonián hǎijūn jūnxiào xuéyuán mài zhe gāngjìn yǒulì de jiǎojiàn bùfá zǒu lái, yǎnshén zhōng chōngmǎn le bǎowèi zǔguó hǎijiāng de jiāndìng zìxìn.', 'Nhìn kìa, đám học viên trường sĩ quan hải quân thiếu niên oai phong lẫm liệt đang rảo bước chân cứng cáp khỏe khoắn bước tới, trong ánh mắt ngập tràn sự tự tin kiên định bảo vệ biển trời tổ quốc.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'd7dc9e14-7532-48eb-8520-12da7d49eb1e'
);

-- [桥梁] (qiáoliáng): cầu, cầu nối
UPDATE public.vocabularies
SET example_hanzi = '汉语言文字与中华优秀经典文化，是连接世界各国友好人民心灵互通、深化文明互鉴的极其重要纽带桥梁。',
    example_pinyin = 'Hànyǔ yán-wénzì yǔ Zhōnghuá yōuxiù jīngdiǎn wénhuà, shì liánjiē shìjiè gè guó yǒuhǎo rénmín xīnlíng hùtōng, shēnhuà wénmíng hùjiàn de jíqí zhòngyào niǔdài qiáoliáng.',
    example_vi = 'Ngôn ngữ văn tự tiếng Hán và văn hóa kinh điển ưu tú Trung Hoa là chiếc cầu nối nhịp cầu cực kỳ quan trọng kết nối tâm hồn nhân dân các nước bầu bạn trên thế giới và làm sâu sắc sự học hỏi lẫn nhau giữa các nền văn minh.'
WHERE id = '8d437489-0534-4945-88ab-9cf555d2be79' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8d437489-0534-4945-88ab-9cf555d2be79', '汉语言文字与中华优秀经典文化，是连接世界各国友好人民心灵互通、深化文明互鉴的极其重要纽带桥梁。', 'Hànyǔ yán-wénzì yǔ Zhōnghuá yōuxiù jīngdiǎn wénhuà, shì liánjiē shìjiè gè guó yǒuhǎo rénmín xīnlíng hùtōng, shēnhuà wénmíng hùjiàn de jíqí zhòngyào niǔdài qiáoliáng.', 'Ngôn ngữ văn tự tiếng Hán và văn hóa kinh điển ưu tú Trung Hoa là chiếc cầu nối nhịp cầu cực kỳ quan trọng kết nối tâm hồn nhân dân các nước bầu bạn trên thế giới và làm sâu sắc sự học hỏi lẫn nhau giữa các nền văn minh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8d437489-0534-4945-88ab-9cf555d2be79'
);

-- [巧妙] (qiǎomiào): khéo léo, tài tình
UPDATE public.vocabularies
SET example_hanzi = '建筑大师巧妙地把古典园林借景造景的东方哲学智慧，融入到了现代超高层生态智能建筑的空中花园设计之中。',
    example_pinyin = 'Jiànzhù dàshī qiǎomiào de bǎ gǔdiǎn yuánlín jièjǐng-zàojǐng de dōngfāng zhéxué zhìhuì, róngrù dào le xiàndài chāo gāocéng shēngtài zhìnéng jiànzhù de kōngzhōng huāyuán shèjì zhīzhōng.',
    example_vi = 'Bậc thầy kiến trúc đã lồng ghép một cách khéo léo tài tình trí tuệ triết học phương Đông về mượn cảnh tạo cảnh vườn cổ điển vào thiết kế vườn trên không của tòa nhà thông minh sinh thái siêu cao tầng hiện đại.'
WHERE id = '387b8256-432c-49a1-9927-2b8872cfbc41' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '387b8256-432c-49a1-9927-2b8872cfbc41', '建筑大师巧妙地把古典园林借景造景的东方哲学智慧，融入到了现代超高层生态智能建筑的空中花园设计之中。', 'Jiànzhù dàshī qiǎomiào de bǎ gǔdiǎn yuánlín jièjǐng-zàojǐng de dōngfāng zhéxué zhìhuì, róngrù dào le xiàndài chāo gāocéng shēngtài zhìnéng jiànzhù de kōngzhōng huāyuán shèjì zhīzhōng.', 'Bậc thầy kiến trúc đã lồng ghép một cách khéo léo tài tình trí tuệ triết học phương Đông về mượn cảnh tạo cảnh vườn cổ điển vào thiết kế vườn trên không của tòa nhà thông minh sinh thái siêu cao tầng hiện đại.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '387b8256-432c-49a1-9927-2b8872cfbc41'
);

-- [起初] (qǐchū): ban đầu, thoạt đầu
UPDATE public.vocabularies
SET example_hanzi = '虽然起初由于语言文化隔阂在跨国团队合作中产生过些许误会，但随着深入坦诚的沟通，大家很快建立起了高度信任。',
    example_pinyin = 'Suīrán qǐchū yóuyú yǔyán wénhuà géhé zài kuàguó tuánduì hézuò zhōng chǎnshēng guò xiēxǔ wùhuì, dàn suízhe shēnrù tǎnchéng de gōutōng, dàjiā hěn kuài jiànlì qǐ le gāodù xìnrèn.',
    example_vi = 'Mặc dù ban đầu thoạt đầu do rào cản ngôn ngữ và văn hóa đã nảy sinh đôi chút hiểu lầm trong hợp tác đội ngũ đa quốc gia, nhưng theo sự trao đổi thẳng thắn sâu sắc, mọi người đã nhanh chóng thiết lập lòng tin cậy cao độ.'
WHERE id = '1f6a871a-d23f-40ef-909c-fbce6cc8b780' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1f6a871a-d23f-40ef-909c-fbce6cc8b780', '虽然起初由于语言文化隔阂在跨国团队合作中产生过些许误会，但随着深入坦诚的沟通，大家很快建立起了高度信任。', 'Suīrán qǐchū yóuyú yǔyán wénhuà géhé zài kuàguó tuánduì hézuò zhōng chǎnshēng guò xiēxǔ wùhuì, dàn suízhe shēnrù tǎnchéng de gōutōng, dàjiā hěn kuài jiànlì qǐ le gāodù xìnrèn.', 'Mặc dù ban đầu thoạt đầu do rào cản ngôn ngữ và văn hóa đã nảy sinh đôi chút hiểu lầm trong hợp tác đội ngũ đa quốc gia, nhưng theo sự trao đổi thẳng thắn sâu sắc, mọi người đã nhanh chóng thiết lập lòng tin cậy cao độ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1f6a871a-d23f-40ef-909c-fbce6cc8b780'
);

-- [切实] (qièshí): thiết thực, sát thực
UPDATE public.vocabularies
SET example_hanzi = '各级教育行政管理部门必须出台切实管用的有力政策措施，切实减轻广大中小学生过重的校外培训课业负担。',
    example_pinyin = 'Gè jí jiàoyù xíngzhèng guǎnlǐ bùmén bìxū chūtái qièshí guǎnyòng de yǒulì zhèngcè cuòshī, qièshí jiǎnqīng guǎngdà zhōng-xiǎoxuésheng guòzhòng de xiàowài péixùn kèyè fùdān.',
    example_vi = 'Các cơ quan quản lý hành chính giáo dục các cấp phải ban hành những biện pháp chính sách có hiệu lực thiết thực sát sườn, giảm nhẹ gánh nặng bài vở học thêm ngoài nhà trường quá nặng cho học sinh phổ thông một cách thực chất.'
WHERE id = '1d7f6d19-7f69-4020-8af8-79ccfbf346c2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '1d7f6d19-7f69-4020-8af8-79ccfbf346c2', '各级教育行政管理部门必须出台切实管用的有力政策措施，切实减轻广大中小学生过重的校外培训课业负担。', 'Gè jí jiàoyù xíngzhèng guǎnlǐ bùmén bìxū chūtái qièshí guǎnyòng de yǒulì zhèngcè cuòshī, qièshí jiǎnqīng guǎngdà zhōng-xiǎoxuésheng guòzhòng de xiàowài péixùn kèyè fùdān.', 'Các cơ quan quản lý hành chính giáo dục các cấp phải ban hành những biện pháp chính sách có hiệu lực thiết thực sát sườn, giảm nhẹ gánh nặng bài vở học thêm ngoài nhà trường quá nặng cho học sinh phổ thông một cách thực chất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '1d7f6d19-7f69-4020-8af8-79ccfbf346c2'
);

-- [启发] (qǐfā): gợi mở, khơi dậy
UPDATE public.vocabularies
SET example_hanzi = '这位资深特级数学教师善于运用生活中的趣味常见现象进行循序渐进的启发式教学，深深激发了学生的独立思考潜能。',
    example_pinyin = 'Zhè wèi zīshēn tèjí shùxué jiàoshī shànyú yùnyòng shēnghuó zhōng de qùwèi chángjiàn xiànxiàng jìnxíng xúnxù-jiànjìn de qǐfāshì jiàoxué, shēnshēn jīfā le xuésheng de dúlì sīkǎo qiánnéng.',
    example_vi = 'Thầy giáo dạy toán xuất sắc kỳ cựu này rất giỏi vận dụng các hiện tượng thường thấy thú vị trong đời sống để giảng dạy gợi mở khơi gợi tuần tự từng bước, khơi dậy sâu sắc tiềm năng tư duy độc lập của học sinh.'
WHERE id = '3d4e5294-37cc-4960-9483-88dcf7bbb273' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3d4e5294-37cc-4960-9483-88dcf7bbb273', '这位资深特级数学教师善于运用生活中的趣味常见现象进行循序渐进的启发式教学，深深激发了学生的独立思考潜能。', 'Zhè wèi zīshēn tèjí shùxué jiàoshī shànyú yùnyòng shēnghuó zhōng de qùwèi chángjiàn xiànxiàng jìnxíng xúnxù-jiànjìn de qǐfāshì jiàoxué, shēnshēn jīfā le xuésheng de dúlì sīkǎo qiánnéng.', 'Thầy giáo dạy toán xuất sắc kỳ cựu này rất giỏi vận dụng các hiện tượng thường thấy thú vị trong đời sống để giảng dạy gợi mở khơi gợi tuần tự từng bước, khơi dậy sâu sắc tiềm năng tư duy độc lập của học sinh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3d4e5294-37cc-4960-9483-88dcf7bbb273'
);

-- [气氛] (qìfēn): bầu không khí
UPDATE public.vocabularies
SET example_hanzi = '在欢庆农历新春佳节的传统庙会上，锣鼓喧天、龙狮共舞，全场到处洋溢着极其喜庆祥和的热烈节日气氛。',
    example_pinyin = 'Zài huānqìng nónglì xīnchūn jiājié de chuántǒng miàohuì shang, luógǔ-xuāntiān, lóng-shī gòng wǔ, quánchǎng dàochù yángyì zhe jíqí xǐqìng xiánghé de rèliè jiérì qìfēn.',
    example_vi = 'Tại hội chợ đền chùa truyền thống mừng Tết Nguyên đán rộn ràng, tiếng chiêng trống vang trời, rồng sư cùng múa, khắp nơi tràn ngập bầu không khí ngày lễ tưng bừng ấm áp và rực rỡ niềm vui.'
WHERE id = '706377d0-1a6f-426d-bd78-8e698fe993a7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '706377d0-1a6f-426d-bd78-8e698fe993a7', '在欢庆农历新春佳节的传统庙会上，锣鼓喧天、龙狮共舞，全场到处洋溢着极其喜庆祥和的热烈节日气氛。', 'Zài huānqìng nónglì xīnchūn jiājié de chuántǒng miàohuì shang, luógǔ-xuāntiān, lóng-shī gòng wǔ, quánchǎng dàochù yángyì zhe jíqí xǐqìng xiánghé de rèliè jiérì qìfēn.', 'Tại hội chợ đền chùa truyền thống mừng Tết Nguyên đán rộn ràng, tiếng chiêng trống vang trời, rồng sư cùng múa, khắp nơi tràn ngập bầu không khí ngày lễ tưng bừng ấm áp và rực rỡ niềm vui.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '706377d0-1a6f-426d-bd78-8e698fe993a7'
);

-- [情节] (qíng jié): tình tiết
UPDATE public.vocabularies
SET example_hanzi = '这部扣人心弦的长篇悬疑侦探小说构思极其精巧、情节跌宕起伏环环相扣，牢牢吸引着广大推理小说爱好者的眼球。',
    example_pinyin = 'Zhè bù kòurénxīnxuán de chángpiān xuányí zhēntàn xiǎoshuō gòusī jíqí jīngqiǎo, qíngjié diēdàng-qǐfú huánhuán-xiāngkòu, láoláo xīyǐn zhe guǎngdà tuīlǐ xiǎoshuō àihàozhě de yǎnqiú.',
    example_vi = 'Cuốn tiểu thuyết trinh thám ly kỳ hồi hộp dài tập này kết cấu vô cùng tinh xảo, tình tiết thăng trầm gay cấn lớp lang móc xích chặt chẽ, cuốn hút trọn vẹn ánh nhìn của đông đảo độc giả say mê truyện trinh thám.'
WHERE id = '9703a07f-2fd0-477f-a818-e3e69c556282' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9703a07f-2fd0-477f-a818-e3e69c556282', '这部扣人心弦的长篇悬疑侦探小说构思极其精巧、情节跌宕起伏环环相扣，牢牢吸引着广大推理小说爱好者的眼球。', 'Zhè bù kòurénxīnxuán de chángpiān xuányí zhēntàn xiǎoshuō gòusī jíqí jīngqiǎo, qíngjié diēdàng-qǐfú huánhuán-xiāngkòu, láoláo xīyǐn zhe guǎngdà tuīlǐ xiǎoshuō àihàozhě de yǎnqiú.', 'Cuốn tiểu thuyết trinh thám ly kỳ hồi hộp dài tập này kết cấu vô cùng tinh xảo, tình tiết thăng trầm gay cấn lớp lang móc xích chặt chẽ, cuốn hút trọn vẹn ánh nhìn của đông đảo độc giả say mê truyện trinh thám.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9703a07f-2fd0-477f-a818-e3e69c556282'
);

-- [情形] (qíng xing): tình hình, sự việc
UPDATE public.vocabularies
SET example_hanzi = '在遇到森林突发火灾或地震等特大自然灾害险恶情形时，现场人员必须严格保持冷静并迅速按照应急逃生路线撤离。',
    example_pinyin = 'Zài yùdào sēnlín tūfā huǒzāi huò dìzhèn děng tédà zìrán zāihài xiǎn''è qíngxíng shí, xiànchǎng rényuán bìxū yángé bǎochí lěngjìng bìng xùnsù ànzhào yìngjí táoshēng lùxiàn chèlí.',
    example_vi = 'Khi gặp phải tình hình tình cảnh hiểm nghèo của thiên tai nghiêm trọng như cháy rừng đột ngột hay động đất, người có mặt tại hiện trường phải giữ bình tĩnh nghiêm ngặt và nhanh chóng sơ tán theo lộ trình thoát hiểm khẩn cấp.'
WHERE id = '3ab82b3a-232c-4642-a8ed-e9365bfd1a25' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3ab82b3a-232c-4642-a8ed-e9365bfd1a25', '在遇到森林突发火灾或地震等特大自然灾害险恶情形时，现场人员必须严格保持冷静并迅速按照应急逃生路线撤离。', 'Zài yùdào sēnlín tūfā huǒzāi huò dìzhèn děng tédà zìrán zāihài xiǎn''è qíngxíng shí, xiànchǎng rényuán bìxū yángé bǎochí lěngjìng bìng xùnsù ànzhào yìngjí táoshēng lùxiàn chèlí.', 'Khi gặp phải tình hình tình cảnh hiểm nghèo của thiên tai nghiêm trọng như cháy rừng đột ngột hay động đất, người có mặt tại hiện trường phải giữ bình tĩnh nghiêm ngặt và nhanh chóng sơ tán theo lộ trình thoát hiểm khẩn cấp.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3ab82b3a-232c-4642-a8ed-e9365bfd1a25'
);

-- [清晨] (qīngchén): sáng sớm
UPDATE public.vocabularies
SET example_hanzi = '初夏的清晨空气格外清新宜人，薄薄的晨雾笼罩在宁静的湖面之上，宛如一幅淡雅的水墨写意山水画卷。',
    example_pinyin = 'Chūxià de qīngchén kōngqì géwài qīngxīn yírén, báobáo de chénwù lǒngzhào zài níngjìng de húmiàn zhī shàng, wǎnrú yì fú dànyǎ de shuǐmò xièyì shānshuǐ huàjuàn.',
    example_vi = 'Sáng sớm đầu hè bầu không khí vô cùng trong lành dễ chịu, làn sương mỏng manh bao phủ trên mặt hồ tĩnh lặng, tựa như một bức tranh thủy mặc phong cảnh non nước hữu tình thanh nhã.'
WHERE id = '94542b9a-444c-4696-a573-e5e5a2588604' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '94542b9a-444c-4696-a573-e5e5a2588604', '初夏的清晨空气格外清新宜人，薄薄的晨雾笼罩在宁静的湖面之上，宛如一幅淡雅的水墨写意山水画卷。', 'Chūxià de qīngchén kōngqì géwài qīngxīn yírén, báobáo de chénwù lǒngzhào zài níngjìng de húmiàn zhī shàng, wǎnrú yì fú dànyǎ de shuǐmò xièyì shānshuǐ huàjuàn.', 'Sáng sớm đầu hè bầu không khí vô cùng trong lành dễ chịu, làn sương mỏng manh bao phủ trên mặt hồ tĩnh lặng, tựa như một bức tranh thủy mặc phong cảnh non nước hữu tình thanh nhã.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '94542b9a-444c-4696-a573-e5e5a2588604'
);

-- [青春] (qīngchūn): thanh xuân, tuổi trẻ
UPDATE public.vocabularies
SET example_hanzi = '青年人应当志存高远、脚踏实地，在推动国家科技现代化与社会进步的伟大实践中挥洒汗水、让青春绽放绚丽光彩。',
    example_pinyin = 'Qīngniánrén yīngdāng zhìcúngāoyuǎn, jiǎotà-shídì, zài tuīdòng guójiā kējì xiàndàihuà yǔ shèhuì jìnbù de wěidà shíjiàn zhōng huīsǎ hànshuǐ, ràng qīngchūn zhànfàng xuànlì guāngcǎi.',
    example_vi = 'Người trẻ tuổi nên nuôi chí lớn, vững vàng thực tế, đem mồ hôi cống hiến trong thực tiễn vĩ đại thúc đẩy hiện đại hóa công nghệ và tiến bộ xã hội của đất nước, để tuổi trẻ thanh xuân bừng nở sắc màu rực rỡ.'
WHERE id = '8b202770-0268-4e07-adc1-ef9adbd3fec8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '8b202770-0268-4e07-adc1-ef9adbd3fec8', '青年人应当志存高远、脚踏实地，在推动国家科技现代化与社会进步的伟大实践中挥洒汗水、让青春绽放绚丽光彩。', 'Qīngniánrén yīngdāng zhìcúngāoyuǎn, jiǎotà-shídì, zài tuīdòng guójiā kējì xiàndàihuà yǔ shèhuì jìnbù de wěidà shíjiàn zhōng huīsǎ hànshuǐ, ràng qīngchūn zhànfàng xuànlì guāngcǎi.', 'Người trẻ tuổi nên nuôi chí lớn, vững vàng thực tế, đem mồ hôi cống hiến trong thực tiễn vĩ đại thúc đẩy hiện đại hóa công nghệ và tiến bộ xã hội của đất nước, để tuổi trẻ thanh xuân bừng nở sắc màu rực rỡ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '8b202770-0268-4e07-adc1-ef9adbd3fec8'
);

-- [清淡] (qīngdàn): thanh đạm, vị nhạt
UPDATE public.vocabularies
SET example_hanzi = '临床营养医学专家建议夏季日常饮食应当以少油少盐、清淡爽口的蔬果杂粮为主，以有效减轻肠胃消化负担。',
    example_pinyin = 'Línchuáng yíngyǎng yīxué zhuānjiā jiànyì xiàjì rìcháng yǐnshí yīngdāng yǐ shǎo yóu shǎo yán, qīngdàn shuǎngkǒu de shū-guǒ záliáng wéizhǔ, yǐ yǒuxiào jiǎnqīng chángwèi xiāohuà fùdān.',
    example_vi = 'Các chuyên gia y học dinh dưỡng lâm sàng khuyến cáo chế độ ăn hàng ngày mùa hè nên lấy các loại rau củ ngũ cốc thanh đạm thanh nhạt ít muối ít dầu, vị nhạt sảng khoái làm chủ đạo để giảm nhẹ gánh nặng tiêu hóa dạ dày.'
WHERE id = '2eb8ca6f-c7d2-4d3e-a15a-af0364c37d7d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2eb8ca6f-c7d2-4d3e-a15a-af0364c37d7d', '临床营养医学专家建议夏季日常饮食应当以少油少盐、清淡爽口的蔬果杂粮为主，以有效减轻肠胃消化负担。', 'Línchuáng yíngyǎng yīxué zhuānjiā jiànyì xiàjì rìcháng yǐnshí yīngdāng yǐ shǎo yóu shǎo yán, qīngdàn shuǎngkǒu de shū-guǒ záliáng wéizhǔ, yǐ yǒuxiào jiǎnqīng chángwèi xiāohuà fùdān.', 'Các chuyên gia y học dinh dưỡng lâm sàng khuyến cáo chế độ ăn hàng ngày mùa hè nên lấy các loại rau củ ngũ cốc thanh đạm thanh nhạt ít muối ít dầu, vị nhạt sảng khoái làm chủ đạo để giảm nhẹ gánh nặng tiêu hóa dạ dày.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2eb8ca6f-c7d2-4d3e-a15a-af0364c37d7d'
);

-- [清洁] (qīngjié): sạch sẽ, thanh khiết
UPDATE public.vocabularies
SET example_hanzi = '积极发展风电光伏与水电等可再生清洁低碳能源，是减少大气污染物排放、打赢蓝天保卫战的根本之策。',
    example_pinyin = 'Jījí fāzhǎn fēngdiàn guāngfú yǔ shuǐdiàn děng kězàishēng qīngjié dītàn néngyuán, shì jiǎnshǎo dàqì wūrǎnwù páifàng, dǎyíng lántiān bǎowèizhàn de gēnběn zhī cè.',
    example_vi = 'Tích cực phát triển năng lượng tái tạo sạch sẽ ít carbon như điện gió, điện mặt trời và thủy điện là kế sách căn bản để giảm lượng phát thải chất ô nhiễm không khí và bảo vệ bầu trời trong xanh.'
WHERE id = '62a1e4f0-fe5a-4b33-a683-2ef89cd64bb0' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '62a1e4f0-fe5a-4b33-a683-2ef89cd64bb0', '积极发展风电光伏与水电等可再生清洁低碳能源，是减少大气污染物排放、打赢蓝天保卫战的根本之策。', 'Jījí fāzhǎn fēngdiàn guāngfú yǔ shuǐdiàn děng kězàishēng qīngjié dītàn néngyuán, shì jiǎnshǎo dàqì wūrǎnwù páifàng, dǎyíng lántiān bǎowèizhàn de gēnběn zhī cè.', 'Tích cực phát triển năng lượng tái tạo sạch sẽ ít carbon như điện gió, điện mặt trời và thủy điện là kế sách căn bản để giảm lượng phát thải chất ô nhiễm không khí và bảo vệ bầu trời trong xanh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '62a1e4f0-fe5a-4b33-a683-2ef89cd64bb0'
);

-- [晴朗] (qínglǎng): nắng ráo, trong xanh
UPDATE public.vocabularies
SET example_hanzi = '在天空湛蓝、阳光和煦明媚的晴朗周末，许多市民举家前往郊野森林公园露营野餐、尽情亲近大自然。',
    example_pinyin = 'Zài tiānkōng zhànlán, yángguāng héxù míngmèi de qínglǎng zhōumò, xǔduō shìmín jǔjiā qiánwǎng jiāoyě sēnlín gōngyuán lùyíng yěcān, jìnqíng qīnjìn dàzìrán.',
    example_vi = 'Vào một ngày cuối tuần nắng ráo trời trong xanh ngắt, ánh nắng chan hòa ấm áp, nhiều người dân cả nhà cùng nhau đến công viên rừng ngoại ô cắm trại dã ngoại, thỏa thích hòa mình vào thiên nhiên.'
WHERE id = '53585211-b143-4df6-b476-e80488770723' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '53585211-b143-4df6-b476-e80488770723', '在天空湛蓝、阳光和煦明媚的晴朗周末，许多市民举家前往郊野森林公园露营野餐、尽情亲近大自然。', 'Zài tiānkōng zhànlán, yángguāng héxù míngmèi de qínglǎng zhōumò, xǔduō shìmín jǔjiā qiánwǎng jiāoyě sēnlín gōngyuán lùyíng yěcān, jìnqíng qīnjìn dàzìrán.', 'Vào một ngày cuối tuần nắng ráo trời trong xanh ngắt, ánh nắng chan hòa ấm áp, nhiều người dân cả nhà cùng nhau đến công viên rừng ngoại ô cắm trại dã ngoại, thỏa thích hòa mình vào thiên nhiên.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '53585211-b143-4df6-b476-e80488770723'
);

-- [清理] (qīnglǐ): dọn dẹp, thanh lý
UPDATE public.vocabularies
SET example_hanzi = '城市防汛应急指挥部组织水务专业疏浚清障队伍，对全城雨水管网和河道下水道沉积淤泥进行了全面深入清理。',
    example_pinyin = 'Chéngshì fángxùn yìngjí zhǐhuībù zǔzhī shuǐwù zhuānyè shūjùn qīngzhàng duìwǔ, duì quán chéng yǔshuǐ guǎnwǎng hé hédào xiàshuǐdào chénjī yūní jìnxíng le quánmiàn shēnrù qīnglǐ.',
    example_vi = 'Sở chỉ huy phòng chống ngập lụt thành phố đã tổ chức đội ngũ nạo vét khơi thông chuyên nghiệp ngành nước tiến hành dọn dẹp nạo vét bùn lắng toàn diện sâu rộng tại mạng lưới cống thoát nước mưa và các dòng kênh ngầm nội thành.'
WHERE id = 'e88b7c97-d9d0-4a24-a5c8-e4dda623ead3' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e88b7c97-d9d0-4a24-a5c8-e4dda623ead3', '城市防汛应急指挥部组织水务专业疏浚清障队伍，对全城雨水管网和河道下水道沉积淤泥进行了全面深入清理。', 'Chéngshì fángxùn yìngjí zhǐhuībù zǔzhī shuǐwù zhuānyè shūjùn qīngzhàng duìwǔ, duì quán chéng yǔshuǐ guǎnwǎng hé hédào xiàshuǐdào chénjī yūní jìnxíng le quánmiàn shēnrù qīnglǐ.', 'Sở chỉ huy phòng chống ngập lụt thành phố đã tổ chức đội ngũ nạo vét khơi thông chuyên nghiệp ngành nước tiến hành dọn dẹp nạo vét bùn lắng toàn diện sâu rộng tại mạng lưới cống thoát nước mưa và các dòng kênh ngầm nội thành.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e88b7c97-d9d0-4a24-a5c8-e4dda623ead3'
);

-- [倾听] (qīngtīng): lắng nghe
UPDATE public.vocabularies
SET example_hanzi = '各级领导干部在深入基层一线调研走访时，应当放下架子、扑下身子，耐心倾听广大老百姓最真实的呼声与诉求。',
    example_pinyin = 'Gè jí lǐngdǎo gànbù zài shēnrù jīcéng yíxiàn diàoyán zǒufǎng shí, yīngdāng fàngxia jiàzi, pū xia shēnzi, nàixīn qīngtīng guǎngdà lǎobǎixìng zuì zhēnshí de hūshēng yǔ sùqiú.',
    example_vi = 'Cán bộ lãnh đạo các cấp khi đi sâu vào cơ sở tuyến đầu khảo sát nắm tình hình cần dẹp bỏ bộ tịch, hòa mình sát sao, kiên nhẫn lắng nghe những tiếng lòng và thỉnh cầu chân thực nhất của đông đảo người dân.'
WHERE id = '9338a926-e8c4-46aa-8547-2494b38120ec' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '9338a926-e8c4-46aa-8547-2494b38120ec', '各级领导干部在深入基层一线调研走访时，应当放下架子、扑下身子，耐心倾听广大老百姓最真实的呼声与诉求。', 'Gè jí lǐngdǎo gànbù zài shēnrù jīcéng yíxiàn diàoyán zǒufǎng shí, yīngdāng fàngxia jiàzi, pū xia shēnzi, nàixīn qīngtīng guǎngdà lǎobǎixìng zuì zhēnshí de hūshēng yǔ sùqiú.', 'Cán bộ lãnh đạo các cấp khi đi sâu vào cơ sở tuyến đầu khảo sát nắm tình hình cần dẹp bỏ bộ tịch, hòa mình sát sao, kiên nhẫn lắng nghe những tiếng lòng và thỉnh cầu chân thực nhất của đông đảo người dân.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '9338a926-e8c4-46aa-8547-2494b38120ec'
);

-- [清晰] (qīngxī): rõ ràng, rành mạch
UPDATE public.vocabularies
SET example_hanzi = '这部学术专著论证严谨缜密、逻辑条理分明，为解决该领域的长期争议问题勾勒出了一条极其清晰可行的研究路径。',
    example_pinyin = 'Zhè bù xuéshù zhuānzhù lùnzhèng yánjǐn zhěnmì, luójí tiáolǐ fēnmíng, wèi jiějué gāi lǐngyù de chángqī zhēngyì wèntí gōulè chū le yì tiáo jíqí qīngxī kěxíng de yánjiū lùjìng.',
    example_vi = 'Chuyên khảo học thuật này lập luận chặt chẽ thấu đáo, mạch lạc logic phân minh rõ ràng, đã phác thảo ra một con đường nghiên cứu vô cùng rành mạch rõ ràng khả thi để giải quyết vấn đề tranh cãi lâu nay trong ngành.'
WHERE id = '302e797b-cbdb-4949-8bbc-5790a8f7263e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '302e797b-cbdb-4949-8bbc-5790a8f7263e', '这部学术专著论证严谨缜密、逻辑条理分明，为解决该领域的长期争议问题勾勒出了一条极其清晰可行的研究路径。', 'Zhè bù xuéshù zhuānzhù lùnzhèng yánjǐn zhěnmì, luójí tiáolǐ fēnmíng, wèi jiějué gāi lǐngyù de chángqī zhēngyì wèntí gōulè chū le yì tiáo jíqí qīngxī kěxíng de yánjiū lùjìng.', 'Chuyên khảo học thuật này lập luận chặt chẽ thấu đáo, mạch lạc logic phân minh rõ ràng, đã phác thảo ra một con đường nghiên cứu vô cùng rành mạch rõ ràng khả thi để giải quyết vấn đề tranh cãi lâu nay trong ngành.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '302e797b-cbdb-4949-8bbc-5790a8f7263e'
);

-- [倾向] (qīngxiàng): xu hướng, thiên hướng
UPDATE public.vocabularies
SET example_hanzi = '权威第三方调研统计数据表明，当代年轻消费者在挑选日用品时越来越表现出倾向于选购本土优质国潮品牌的明显趋势。',
    example_pinyin = 'Quánwēi dì-sān fāng diàoyán tǒngjì shùjù biǎomíng, dāngdài niánqīng xiāofèizhě zài tiāoxuǎn rìyòngpǐn shí yuèláiyuè biǎoxiàn chū qīngxiàng yú xuǎngòu běntǔ yōuzhì guócháo pǐnpái de míngxiǎn qūshì.',
    example_vi = 'Số liệu thống kê điều tra bên thứ ba có thẩm quyền chỉ ra rằng người tiêu dùng trẻ đương đại khi chọn mua đồ gia dụng ngày càng bộc lộ xu hướng thiên hướng chọn mua các thương hiệu nội địa chất lượng cao một cách rõ rệt.'
WHERE id = '0102075b-ba3c-49c3-9ae5-65a627dd560a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0102075b-ba3c-49c3-9ae5-65a627dd560a', '权威第三方调研统计数据表明，当代年轻消费者在挑选日用品时越来越表现出倾向于选购本土优质国潮品牌的明显趋势。', 'Quánwēi dì-sān fāng diàoyán tǒngjì shùjù biǎomíng, dāngdài niánqīng xiāofèizhě zài tiāoxuǎn rìyòngpǐn shí yuèláiyuè biǎoxiàn chū qīngxiàng yú xuǎngòu běntǔ yōuzhì guócháo pǐnpái de míngxiǎn qūshì.', 'Số liệu thống kê điều tra bên thứ ba có thẩm quyền chỉ ra rằng người tiêu dùng trẻ đương đại khi chọn mua đồ gia dụng ngày càng bộc lộ xu hướng thiên hướng chọn mua các thương hiệu nội địa chất lượng cao một cách rõ rệt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0102075b-ba3c-49c3-9ae5-65a627dd560a'
);

-- [清醒] (qīngxǐng): tỉnh táo
UPDATE public.vocabularies
SET example_hanzi = '尽管我们在过去几年取得了举世瞩目的非凡建设成就，但在面对复杂的国际风云变幻时依然必须保持清醒冷静的战略定力。',
    example_pinyin = 'Jǐnguǎn wǒmen zài guòqù jǐ nián qǔdé le jǔshì-zhǔmù de fēifán jiànshè chéngjiù, dàn zài miànduì fùzá de guójì fēngyún biànhuàn shí yīrán bìxū bǎochí qīngxǐng lěngjìng de zhànlüè dìnglì.',
    example_vi = 'Dù chúng ta trong mấy năm qua đã gặt hái được những thành tựu xây dựng phi thường khiến cả thế giới khâm phục, nhưng trước những biến chuyển phong vân quốc tế phức tạp vẫn nhất thiết phải duy trì bản lĩnh chiến lược tỉnh táo sáng suốt.'
WHERE id = 'f976024a-94a2-47ad-80b4-48efabc949f2' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'f976024a-94a2-47ad-80b4-48efabc949f2', '尽管我们在过去几年取得了举世瞩目的非凡建设成就，但在面对复杂的国际风云变幻时依然必须保持清醒冷静的战略定力。', 'Jǐnguǎn wǒmen zài guòqù jǐ nián qǔdé le jǔshì-zhǔmù de fēifán jiànshè chéngjiù, dàn zài miànduì fùzá de guójì fēngyún biànhuàn shí yīrán bìxū bǎochí qīngxǐng lěngjìng de zhànlüè dìnglì.', 'Dù chúng ta trong mấy năm qua đã gặt hái được những thành tựu xây dựng phi thường khiến cả thế giới khâm phục, nhưng trước những biến chuyển phong vân quốc tế phức tạp vẫn nhất thiết phải duy trì bản lĩnh chiến lược tỉnh táo sáng suốt.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'f976024a-94a2-47ad-80b4-48efabc949f2'
);

-- [勤劳] (qínláo): cần cù, chăm chỉ
UPDATE public.vocabularies
SET example_hanzi = '千百年来，勤劳勇敢善良的中华各族儿女在广袤壮丽的神州大地上辛勤耕耘，创造出了辉煌灿烂的华夏农耕与工业文明。',
    example_pinyin = 'Qiān bǎi nián lái, qínláo yǒnggǎn shànliáng de Zhōnghuá gè zú érnǚ zài guǎngmào zhuànglì de shénzhōu dàdì shang xīnqín gēngyún, chuàngzào chū le huīhuáng cànlàn de Huáxià nónggēng yǔ gōngyè wénmíng.',
    example_vi = 'Hàng ngàn năm qua, con cháu các dân tộc Trung Hoa cần cù chăm chỉ dũng cảm lương thiện trên dải đất thần châu bao la tráng lệ đã dày công cày cấy, kiến tạo nên nền văn minh nông nghiệp và công nghiệp rực rỡ chói lọi.'
WHERE id = '51bb9253-16b8-4ee3-aa79-834f617569e9' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '51bb9253-16b8-4ee3-aa79-834f617569e9', '千百年来，勤劳勇敢善良的中华各族儿女在广袤壮丽的神州大地上辛勤耕耘，创造出了辉煌灿烂的华夏农耕与工业文明。', 'Qiān bǎi nián lái, qínláo yǒnggǎn shànliáng de Zhōnghuá gè zú érnǚ zài guǎngmào zhuànglì de shénzhōu dàdì shang xīnqín gēngyún, chuàngzào chū le huīhuáng cànlàn de Huáxià nónggēng yǔ gōngyè wénmíng.', 'Hàng ngàn năm qua, con cháu các dân tộc Trung Hoa cần cù chăm chỉ dũng cảm lương thiện trên dải đất thần châu bao la tráng lệ đã dày công cày cấy, kiến tạo nên nền văn minh nông nghiệp và công nghiệp rực rỡ chói lọi.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '51bb9253-16b8-4ee3-aa79-834f617569e9'
);

-- [亲密] (qīnmì): thân mật, gắn bó
UPDATE public.vocabularies
SET example_hanzi = '他们从小学同窗起便是形影不离的好朋友，这份历经数十年风雨考验的亲密无间友谊至今依然历久弥坚、坚如磐石。',
    example_pinyin = 'Tāmen cóng xiǎoxué tóngchuāng qǐ biàn shì xíngyǐng-bùlí de hǎo péngyou, zhè fèn lìjīng shùshí nián fēngyǔ kǎoyàn de qīnmì-wújiàn yǒuyì zhìjīn yīrán lìjiǔ-míjiān, jiānrúpánshí.',
    example_vi = 'Họ từ thuở bạn học cấp một đã là đôi bạn thân hình với bóng không rời, tình bạn gắn bó thân mật khăng khít trải qua thử thách mưa gió hàng chục năm này đến nay vẫn vững bền như thạch bàn.'
WHERE id = '210132f4-acfa-480e-adbb-23620cd4487d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '210132f4-acfa-480e-adbb-23620cd4487d', '他们从小学同窗起便是形影不离的好朋友，这份历经数十年风雨考验的亲密无间友谊至今依然历久弥坚、坚如磐石。', 'Tāmen cóng xiǎoxué tóngchuāng qǐ biàn shì xíngyǐng-bùlí de hǎo péngyou, zhè fèn lìjīng shùshí nián fēngyǔ kǎoyàn de qīnmì-wújiàn yǒuyì zhìjīn yīrán lìjiǔ-míjiān, jiānrúpánshí.', 'Họ từ thuở bạn học cấp một đã là đôi bạn thân hình với bóng không rời, tình bạn gắn bó thân mật khăng khít trải qua thử thách mưa gió hàng chục năm này đến nay vẫn vững bền như thạch bàn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '210132f4-acfa-480e-adbb-23620cd4487d'
);

-- [欺骗] (qīpiàn): lừa gạt, dối trá
UPDATE public.vocabularies
SET example_hanzi = '无论是在商业经贸往来中还是在日常人际交往里，任何采取弄虚作假、恶意欺骗他人以牟取非法暴利的行为都是极其可耻的。',
    example_pinyin = 'Wúlùn shì zài shāngyè jīngmào wǎnglái zhōng háishì zài rìcháng rénjì jiāowǎng lǐ, rènhé cǎiqǔ nòngxū-zuòjiǎ, è''yì qīpiàn tārén yǐ móuqǔ fēifǎ bàolì de xíngwéi dōu shì jíqí kěchǐ de.',
    example_vi = 'Dù trong giao thương kinh doanh buôn bán hay giao tiếp thường nhật giữa người với người, bất kỳ hành vi gian dối lừa dối lừa gạt người khác nhằm trục lợi bất chính đều là việc vô cùng đáng xấu hổ.'
WHERE id = 'a02e3cf1-e6c2-4d6c-8398-a15abf4c8486' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a02e3cf1-e6c2-4d6c-8398-a15abf4c8486', '无论是在商业经贸往来中还是在日常人际交往里，任何采取弄虚作假、恶意欺骗他人以牟取非法暴利的行为都是极其可耻的。', 'Wúlùn shì zài shāngyè jīngmào wǎnglái zhōng háishì zài rìcháng rénjì jiāowǎng lǐ, rènhé cǎiqǔ nòngxū-zuòjiǎ, è''yì qīpiàn tārén yǐ móuqǔ fēifǎ bàolì de xíngwéi dōu shì jíqí kěchǐ de.', 'Dù trong giao thương kinh doanh buôn bán hay giao tiếp thường nhật giữa người với người, bất kỳ hành vi gian dối lừa dối lừa gạt người khác nhằm trục lợi bất chính đều là việc vô cùng đáng xấu hổ.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a02e3cf1-e6c2-4d6c-8398-a15abf4c8486'
);

-- [齐全] (qíquán): đầy đủ, trọn vẹn
UPDATE public.vocabularies
SET example_hanzi = '这所新建投入使用的现代化实验中学不仅拥有崭新的教学楼，而且各类理化生实验精密仪器与体育设施设备一应俱全、十分齐全。',
    example_pinyin = 'Zhè suǒ xīn jiàn tóurù shǐyòng de xiàndàihuà shíyàn zhōngxué bùjǐn yōngyǒu zhǎnxīn de jiàoxuélóu, érqiě gè lèi lǐ-huà-shēng shíyàn jīngmì yíqì yǔ tǐyù shèshī shèbèi yìyīng-jùquán, shífēn qíquán.',
    example_vi = 'Trường trung học thực nghiệm hiện đại mới xây dựng đưa vào sử dụng không chỉ có dãy phòng học mới toanh mà các loại thiết bị chính xác thí nghiệm lý hóa sinh cùng cơ sở vật chất thể thao đều đầy đủ trọn vẹn tươm tất.'
WHERE id = 'c547531c-c077-4fee-bd90-bafed6129305' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c547531c-c077-4fee-bd90-bafed6129305', '这所新建投入使用的现代化实验中学不仅拥有崭新的教学楼，而且各类理化生实验精密仪器与体育设施设备一应俱全、十分齐全。', 'Zhè suǒ xīn jiàn tóurù shǐyòng de xiàndàihuà shíyàn zhōngxué bùjǐn yōngyǒu zhǎnxīn de jiàoxuélóu, érqiě gè lèi lǐ-huà-shēng shíyàn jīngmì yíqì yǔ tǐyù shèshī shèbèi yìyīng-jùquán, shífēn qíquán.', 'Trường trung học thực nghiệm hiện đại mới xây dựng đưa vào sử dụng không chỉ có dãy phòng học mới toanh mà các loại thiết bị chính xác thí nghiệm lý hóa sinh cùng cơ sở vật chất thể thao đều đầy đủ trọn vẹn tươm tất.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c547531c-c077-4fee-bd90-bafed6129305'
);

-- [启示] (qǐshì): gợi ý, bài học
UPDATE public.vocabularies
SET example_hanzi = '大自然中形形色色神奇精妙的生物演化构造，给现代仿生学工程师提供了源源不断、富有突破性的科研创新灵感与宝贵启示。',
    example_pinyin = 'Dàzìrán zhōng xíngxíng-sèsè shénqí jīngmiào de shēngwù yǎnhuà gòuzào, gěi xiàndài fǎngshēngxué gōngchéngshī tígōng le yuányuán-bùduàn, fùyǒu tūpòxìng de kēyán chuàngxīn línggǎn yǔ bǎoguì qǐshì.',
    example_vi = 'Cấu tạo tiến hóa sinh vật kỳ diệu muôn hình muôn vẻ trong tự nhiên đã đem đến cho các kỹ sư phỏng sinh học hiện đại nguồn cảm hứng sáng tạo và gợi ý bài học quý giá bất tận mang tính đột phá.'
WHERE id = '7eed8953-6db6-420d-b503-61425d7b7c4c' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '7eed8953-6db6-420d-b503-61425d7b7c4c', '大自然中形形色色神奇精妙的生物演化构造，给现代仿生学工程师提供了源源不断、富有突破性的科研创新灵感与宝贵启示。', 'Dàzìrán zhōng xíngxíng-sèsè shénqí jīngmiào de shēngwù yǎnhuà gòuzào, gěi xiàndài fǎngshēngxué gōngchéngshī tígōng le yuányuán-bùduàn, fùyǒu tūpòxìng de kēyán chuàngxīn línggǎn yǔ bǎoguì qǐshì.', 'Cấu tạo tiến hóa sinh vật kỳ diệu muôn hình muôn vẻ trong tự nhiên đã đem đến cho các kỹ sư phỏng sinh học hiện đại nguồn cảm hứng sáng tạo và gợi ý bài học quý giá bất tận mang tính đột phá.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '7eed8953-6db6-420d-b503-61425d7b7c4c'
);

-- [启事] (qǐshì): thông báo, cáo thị
UPDATE public.vocabularies
SET example_hanzi = '市民服务中心在官方网站与各社区宣传栏显著位置发布了一则关于公开招募大型国际马拉松赛志愿者的通知启事。',
    example_pinyin = 'Shìmín fúwù zhōngxīn zài guānfāng wǎngzhàn yǔ gè shèqū xuānchuánlán xiǎnzhù wèizhì fābù le yì zé guānyú gōngkāi zhāomù dàxíng guójì mǎlāsōng sài zhìyuànzhě de tōngzhī qǐshì.',
    example_vi = 'Trung tâm dịch vụ cư dân đã đăng tải một thông báo cáo thị trên trang web chính thức và bảng tin các khu dân cư về việc tuyển dụng công khai tình nguyện viên cho giải chạy marathon quốc tế quy mô lớn.'
WHERE id = '0c1c1285-4ddb-493d-9813-fe66dee21e31' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '0c1c1285-4ddb-493d-9813-fe66dee21e31', '市民服务中心在官方网站与各社区宣传栏显著位置发布了一则关于公开招募大型国际马拉松赛志愿者的通知启事。', 'Shìmín fúwù zhōngxīn zài guānfāng wǎngzhàn yǔ gè shèqū xuānchuánlán xiǎnzhù wèizhì fābù le yì zé guānyú gōngkāi zhāomù dàxíng guójì mǎlāsōng sài zhìyuànzhě de tōngzhī qǐshì.', 'Trung tâm dịch vụ cư dân đã đăng tải một thông báo cáo thị trên trang web chính thức và bảng tin các khu dân cư về việc tuyển dụng công khai tình nguyện viên cho giải chạy marathon quốc tế quy mô lớn.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '0c1c1285-4ddb-493d-9813-fe66dee21e31'
);

-- [期望] (qīwàng): kỳ vọng, mong mỏi
UPDATE public.vocabularies
SET example_hanzi = '全社会与广大人民群众无不殷切期望这批有远大理想抱负的优秀青年科技工作者能够勇挑重担，在基础科学研究中不断勇攀高峰。',
    example_pinyin = 'Quán shèhuì yǔ guǎngdà rénmín qúnzhòng wúbù yīnqiè qīwàng zhè pī yǒu yuǎndà lǐxiǎng bàofù de yōuxiù qīngnián kējì gōngzuòzhě nénggòu yǒng tiāo zhòngdàn, zài jīchǔ kēxué yánjiū zhōng búduàn yǒng pān gāofēng.',
    example_vi = 'Toàn xã hội và quần chúng nhân dân đều tha thiết kỳ vọng mong mỏi thế hệ cán bộ khoa học công nghệ trẻ ưu tú có lý tưởng hoài bão lớn lao dám gánh vác trọng trách, không ngừng dũng cảm leo lên các đỉnh cao nghiên cứu khoa học cơ bản.'
WHERE id = 'ef96e036-2ca7-4af3-911e-1ba3b3b3eb65' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'ef96e036-2ca7-4af3-911e-1ba3b3b3eb65', '全社会与广大人民群众无不殷切期望这批有远大理想抱负的优秀青年科技工作者能够勇挑重担，在基础科学研究中不断勇攀高峰。', 'Quán shèhuì yǔ guǎngdà rénmín qúnzhòng wúbù yīnqiè qīwàng zhè pī yǒu yuǎndà lǐxiǎng bàofù de yōuxiù qīngnián kējì gōngzuòzhě nénggòu yǒng tiāo zhòngdàn, zài jīchǔ kēxué yánjiū zhōng búduàn yǒng pān gāofēng.', 'Toàn xã hội và quần chúng nhân dân đều tha thiết kỳ vọng mong mỏi thế hệ cán bộ khoa học công nghệ trẻ ưu tú có lý tưởng hoài bão lớn lao dám gánh vác trọng trách, không ngừng dũng cảm leo lên các đỉnh cao nghiên cứu khoa học cơ bản.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'ef96e036-2ca7-4af3-911e-1ba3b3b3eb65'
);

-- [气味] (qìwèi): mùi vị
UPDATE public.vocabularies
SET example_hanzi = '漫步在雨后初霁的青翠松林之间，迎面扑来的是泥土与松针散发出的那一缕清纯湿润、令人心旷神怡的天然芬芳气味。',
    example_pinyin = 'Mànbù zài yǔhòu-chūjì de qīngcuì sōnglín zhījiān, yíngmiàn pū lái de shì nítǔ yǔ sōngzhēn sànfā chū de nà yì lǚ qīngchún shīrùn, lìngrén xīnkuàng-shényí de tiānrán fēnfāng qìwèi.',
    example_vi = 'Tản bộ giữa rừng thông xanh mướt sau cơn mưa tạnh, phả vào mặt là làn mùi hương tự nhiên thoang thoảng mát lành ẩm ướt của đất cát và lá thông khiến lòng người khoan khoái nhẹ nhõm.'
WHERE id = 'e86e19db-c303-4ade-95b2-59835454aea7' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e86e19db-c303-4ade-95b2-59835454aea7', '漫步在雨后初霁的青翠松林之间，迎面扑来的是泥土与松针散发出的那一缕清纯湿润、令人心旷神怡的天然芬芳气味。', 'Mànbù zài yǔhòu-chūjì de qīngcuì sōnglín zhījiān, yíngmiàn pū lái de shì nítǔ yǔ sōngzhēn sànfā chū de nà yì lǚ qīngchún shīrùn, lìngrén xīnkuàng-shényí de tiānrán fēnfāng qìwèi.', 'Tản bộ giữa rừng thông xanh mướt sau cơn mưa tạnh, phả vào mặt là làn mùi hương tự nhiên thoang thoảng mát lành ẩm ướt của đất cát và lá thông khiến lòng người khoan khoái nhẹ nhõm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e86e19db-c303-4ade-95b2-59835454aea7'
);

-- [期限] (qīxiàn): thời hạn
UPDATE public.vocabularies
SET example_hanzi = '根据双方依法签订的技术转让授权商业合同条款规定，本次关键专利使用授权的有效法定保护期限为整整十五年。',
    example_pinyin = 'Gēnjù shuāngfāng yīfǎ qiāndìng de jìshù zhuǎnràng shòuquán shāngyè hétong tiáokuǎn guīdìng, běncì guānjiàn zhuānlì shǐyòng shòuquán de yǒuxiào fǎdìng bǎohù qīxiàn wèi zhěngzhěng shíwǔ nián.',
    example_vi = 'Căn cứ theo điều khoản hợp đồng thương mại chuyển giao bản quyền công nghệ được hai bên ký kết hợp pháp, thời hạn bảo hộ pháp định có hiệu lực của bằng sáng chế then chốt lần này tròn đúng 15 năm.'
WHERE id = '3004494f-a334-4183-80fc-51ef8327df97' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '3004494f-a334-4183-80fc-51ef8327df97', '根据双方依法签订的技术转让授权商业合同条款规定，本次关键专利使用授权的有效法定保护期限为整整十五年。', 'Gēnjù shuāngfāng yīfǎ qiāndìng de jìshù zhuǎnràng shòuquán shāngyè hétong tiáokuǎn guīdìng, běncì guānjiàn zhuānlì shǐyòng shòuquán de yǒuxiào fǎdìng bǎohù qīxiàn wèi zhěngzhěng shíwǔ nián.', 'Căn cứ theo điều khoản hợp đồng thương mại chuyển giao bản quyền công nghệ được hai bên ký kết hợp pháp, thời hạn bảo hộ pháp định có hiệu lực của bằng sáng chế then chốt lần này tròn đúng 15 năm.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '3004494f-a334-4183-80fc-51ef8327df97'
);

-- [起源] (qǐyuán): nguồn gốc, bắt nguồn
UPDATE public.vocabularies
SET example_hanzi = '古人类学与现代分子生物学的大量严谨科考证据证实，华夏农耕文明与长江黄河两大母亲河流域的农业栽培起源密切相关。',
    example_pinyin = 'Gǔ-rénlèixué yǔ xiàndài fēnzǐ shēngwùxué de dàliàng yánjǐn kěkǎo zhèngjù zhèngshí, Huáxià nónggēng wénmíng yǔ Chángjiāng Huánghé liǎng dà mǔqīn hé liúyù de nóngyè zāipéi qǐyuán mìqiè xiāngguān.',
    example_vi = 'Nhiều bằng chứng khảo sát nghiêm cẩn của cổ nhân học và sinh học phân tử hiện đại đã xác thực nền văn minh nông nghiệp Hoa Hạ bắt nguồn nguồn gốc gắn bó mật thiết với nguồn gốc canh tác nông nghiệp lưu vực hai con sông mẹ Trường Giang và Hoàng Hà.'
WHERE id = '4db9a49b-0b97-43ea-82fe-56187af3b7d8' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '4db9a49b-0b97-43ea-82fe-56187af3b7d8', '古人类学与现代分子生物学的大量严谨科考证据证实，华夏农耕文明与长江黄河两大母亲河流域的农业栽培起源密切相关。', 'Gǔ-rénlèixué yǔ xiàndài fēnzǐ shēngwùxué de dàliàng yánjǐn kěkǎo zhèngjù zhèngshí, Huáxià nónggēng wénmíng yǔ Chángjiāng Huánghé liǎng dà mǔqīn hé liúyù de nóngyè zāipéi qǐyuán mìqiè xiāngguān.', 'Nhiều bằng chứng khảo sát nghiêm cẩn của cổ nhân học và sinh học phân tử hiện đại đã xác thực nền văn minh nông nghiệp Hoa Hạ bắt nguồn nguồn gốc gắn bó mật thiết với nguồn gốc canh tác nông nghiệp lưu vực hai con sông mẹ Trường Giang và Hoàng Hà.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '4db9a49b-0b97-43ea-82fe-56187af3b7d8'
);

-- [气质] (qìzhì): khí chất
UPDATE public.vocabularies
SET example_hanzi = '自幼研习中国传统书法与古典诗词的李老师言谈举止温文尔雅、从容淡定，举手投足间无不透出一种脱俗超凡的高雅书卷气质。',
    example_pinyin = 'Zìyòu yánxí Zhōngguó chuántǒng shūfǎ yǔ gǔdiǎn shīcí de Lǐ lǎoshī yántán-jǔzhǐ wēnwén''ěryǎ, cóngróng dàndìng, jǔshǒu-tóuzú jiān wúbù tòu chū yì zhǒng tuōsú chāofán de gāoyǎ shūjuàn qìzhì.',
    example_vi = 'Cô giáo Lý từ nhỏ nghiên cứu thư pháp cổ truyền và thơ ca cổ điển Trung Hoa ăn nói cử chỉ nho nhã từ tốn điềm đạm, mỗi cái nhấc tay nhấc chân đều toát lên một khí chất trí thức tao nhã thanh cao thoát tục.'
WHERE id = 'a4178d9c-313d-40d3-bfcc-85473a64e3bc' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'a4178d9c-313d-40d3-bfcc-85473a64e3bc', '自幼研习中国传统书法与古典诗词的李老师言谈举止温文尔雅、从容淡定，举手投足间无不透出一种脱俗超凡的高雅书卷气质。', 'Zìyòu yánxí Zhōngguó chuántǒng shūfǎ yǔ gǔdiǎn shīcí de Lǐ lǎoshī yántán-jǔzhǐ wēnwén''ěryǎ, cóngróng dàndìng, jǔshǒu-tóuzú jiān wúbù tòu chū yì zhǒng tuōsú chāofán de gāoyǎ shūjuàn qìzhì.', 'Cô giáo Lý từ nhỏ nghiên cứu thư pháp cổ truyền và thơ ca cổ điển Trung Hoa ăn nói cử chỉ nho nhã từ tốn điềm đạm, mỗi cái nhấc tay nhấc chân đều toát lên một khí chất trí thức tao nhã thanh cao thoát tục.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'a4178d9c-313d-40d3-bfcc-85473a64e3bc'
);

-- [娶] (qǔ): cưới (vợ), lấy (vợ)
UPDATE public.vocabularies
SET example_hanzi = '在这场隆重而又温馨的传统中式婚礼庆典上，新郎在亲朋好友的欢呼与祝福中，满怀深情与责任感迎娶了自己相恋多年的美丽新娘。',
    example_pinyin = 'Zài zhè chǎng lóngzhòng ér yòu wēnxīn de chuántǒng zhōngshì hūnlǐ qìngdiǎn shang, xīnláng zài qīnpéng-hǎoyǒu de huānhū yǔ zhùfú zhōng, mǎnhuái shēnqíng yǔ zérèngǎn yíngqǔ le zìjǐ xiāngliàn duō nián de měilì xīnniáng.',
    example_vi = 'Trong lễ kỷ niệm hôn lễ kiểu Trung Hoa truyền thống long trọng ấm áp này, chú rể trong tiếng reo mừng và chúc phúc của người thân bạn bè đã chứa chan tình cảm và trách nhiệm đón cưới cô dâu xinh đẹp yêu nhau nhiều năm về dinh.'
WHERE id = 'c6a6d9b8-1ac8-4089-adcf-9a6ac93af528' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'c6a6d9b8-1ac8-4089-adcf-9a6ac93af528', '在这场隆重而又温馨的传统中式婚礼庆典上，新郎在亲朋好友的欢呼与祝福中，满怀深情与责任感迎娶了自己相恋多年的美丽新娘。', 'Zài zhè chǎng lóngzhòng ér yòu wēnxīn de chuántǒng zhōngshì hūnlǐ qìngdiǎn shang, xīnláng zài qīnpéng-hǎoyǒu de huānhū yǔ zhùfú zhōng, mǎnhuái shēnqíng yǔ zérèngǎn yíngqǔ le zìjǐ xiāngliàn duō nián de měilì xīnniáng.', 'Trong lễ kỷ niệm hôn lễ kiểu Trung Hoa truyền thống long trọng ấm áp này, chú rể trong tiếng reo mừng và chúc phúc của người thân bạn bè đã chứa chan tình cảm và trách nhiệm đón cưới cô dâu xinh đẹp yêu nhau nhiều năm về dinh.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'c6a6d9b8-1ac8-4089-adcf-9a6ac93af528'
);

-- [圈] (quān): vòng tròn, khoanh tròn
UPDATE public.vocabularies
SET example_hanzi = '语文老师在为学生批改作文评析时，用鲜艳醒目的红笔在文章开头那句文采飞扬、立意深刻的开头点题句外面重重画了一个大大的红圆圈。',
    example_pinyin = 'Yǔwén lǎoshī zài wèi xuésheng pīgǎi zuòwén píngxī shí, yòng xiānyàn xǐngmù de hóngbǐ zài wénzhāng kāitóu nà jù wéncǎi-fēiyáng, lìyì shēnkè de kāitóu diǎntíjù wàimiàn zhòngzhòng huà le yí gè dàdà de hóng yuánquān.',
    example_vi = 'Cô giáo ngữ văn khi chấm bài làm văn của học sinh đã dùng cây bút đỏ rực rỡ nổi bật khoanh tròn một vòng tròn đỏ lớn đậm nét quanh câu văn mở bài sâu sắc bay bổng xuất thần.'
WHERE id = '2635ada4-51c0-47b9-a8a9-23e6b9c4e71a' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '2635ada4-51c0-47b9-a8a9-23e6b9c4e71a', '语文老师在为学生批改作文评析时，用鲜艳醒目的红笔在文章开头那句文采飞扬、立意深刻的开头点题句外面重重画了一个大大的红圆圈。', 'Yǔwén lǎoshī zài wèi xuésheng pīgǎi zuòwén píngxī shí, yòng xiānyàn xǐngmù de hóngbǐ zài wénzhāng kāitóu nà jù wéncǎi-fēiyáng, lìyì shēnkè de kāitóu diǎntíjù wàimiàn zhòngzhòng huà le yí gè dàdà de hóng yuánquān.', 'Cô giáo ngữ văn khi chấm bài làm văn của học sinh đã dùng cây bút đỏ rực rỡ nổi bật khoanh tròn một vòng tròn đỏ lớn đậm nét quanh câu văn mở bài sâu sắc bay bổng xuất thần.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '2635ada4-51c0-47b9-a8a9-23e6b9c4e71a'
);

-- [权力] (quánlì): quyền lực
UPDATE public.vocabularies
SET example_hanzi = '宪法法律明确规定，一切国家权力必须在法治阳光下规范运行，严格将行政权力关进制度法规的坚固笼子里，防止任何权力滥用。',
    example_pinyin = 'Xiànfǎ fǎlǜ míngquè guīdìng, yíqiè guójiā quánlì bìxū zài fǎzhì yángguāng xià guīfàn yùnxíng, yángé jiāng xíngzhèng quánlì guān jìn zhìdù fǎguī de jiāngù lóngzi lǐ, fángzhǐ rènhé quánlì lànyòng.',
    example_vi = 'Hiến pháp luật pháp quy định rõ ràng mọi quyền lực nhà nước phải vận hành chuẩn mực dưới ánh sáng pháp trị, nhốt chặt quyền lực hành chính vào chiếc lồng quy chế pháp luật để phòng ngừa mọi sự lạm quyền.'
WHERE id = 'e93e46b0-8541-40b3-acad-6eba6551f63e' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), 'e93e46b0-8541-40b3-acad-6eba6551f63e', '宪法法律明确规定，一切国家权力必须在法治阳光下规范运行，严格将行政权力关进制度法规的坚固笼子里，防止任何权力滥用。', 'Xiànfǎ fǎlǜ míngquè guīdìng, yíqiè guójiā quánlì bìxū zài fǎzhì yángguāng xià guīfàn yùnxíng, yángé jiāng xíngzhèng quánlì guān jìn zhìdù fǎguī de jiāngù lóngzi lǐ, fángzhǐ rènhé quánlì lànyòng.', 'Hiến pháp luật pháp quy định rõ ràng mọi quyền lực nhà nước phải vận hành chuẩn mực dưới ánh sáng pháp trị, nhốt chặt quyền lực hành chính vào chiếc lồng quy chế pháp luật để phòng ngừa mọi sự lạm quyền.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = 'e93e46b0-8541-40b3-acad-6eba6551f63e'
);

-- [渠道] (qúdào): kênh mương, kênh phân phối/thông tin
UPDATE public.vocabularies
SET example_hanzi = '随着跨境电子商务与现代数字贸易平台的飞速发展，我国广大外贸制造企业拓展海外国际市场的产品销售渠道变得更加便捷宽广与高效。',
    example_pinyin = 'Suízhe kuàjìng diànzǐ shāngwù yǔ xiàndài shùzì màoyì píngtái de fēisù fāzhǎn, wǒ guó guǎngdà wàimào zhìzào qǐyè tuòzhǎn hǎiwài guójì shìchǎng de chǎnpǐn xiāoshòu qúdào biàn de gèngjiā biànjié kuānguǎng yǔ gāoxiào.',
    example_vi = 'Cùng với sự phát triển thần tốc của thương mại điện tử xuyên biên giới và các nền tảng số hiện đại, kênh phân phối tiêu thụ sản phẩm mở rộng thị trường quốc tế của các doanh nghiệp sản xuất ngoại thương nước ta trở nên thuận tiện, rộng mở và hiệu quả hơn rất nhiều.'
WHERE id = '936a7a6b-426a-4c03-980c-a9a6988cc668' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '936a7a6b-426a-4c03-980c-a9a6988cc668', '随着跨境电子商务与现代数字贸易平台的飞速发展，我国广大外贸制造企业拓展海外国际市场的产品销售渠道变得更加便捷宽广与高效。', 'Suízhe kuàjìng diànzǐ shāngwù yǔ xiàndài shùzì màoyì píngtái de fēisù fāzhǎn, wǒ guó guǎngdà wàimào zhìzào qǐyè tuòzhǎn hǎiwài guójì shìchǎng de chǎnpǐn xiāoshòu qúdào biàn de gèngjiā biànjié kuānguǎng yǔ gāoxiào.', 'Cùng với sự phát triển thần tốc của thương mại điện tử xuyên biên giới và các nền tảng số hiện đại, kênh phân phối tiêu thụ sản phẩm mở rộng thị trường quốc tế của các doanh nghiệp sản xuất ngoại thương nước ta trở nên thuận tiện, rộng mở và hiệu quả hơn rất nhiều.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '936a7a6b-426a-4c03-980c-a9a6988cc668'
);

-- [缺陷] (quē xiàn): khuyết điểm, nhược điểm
UPDATE public.vocabularies
SET example_hanzi = '航空发动机研发团队通过数万次极限工况仿真模拟实验，在试飞前成功排查并彻底攻克了轴承结构设计中存在的两处微小隐蔽技术缺陷。',
    example_pinyin = 'Hángkōng fādòngjī yánfā tuánduì tōngguò shùwàn cì jíxiàn gōngkuàng fǎngzhēn mónǐ shíyàn, zài shìfēi qián chénggōng páichá bìng chèdǐ gōngkè le zhóuchéng jiégòu shèjì zhōng cúnzài de liǎng chù wēixiǎo yǐnbì jìshù quēxiàn.',
    example_vi = 'Đội ngũ nghiên cứu động cơ hàng không qua hàng vạn lần thí nghiệm mô phỏng điều kiện làm việc giới hạn trước khi bay thử đã rà soát và khắc phục triệt để hai nhược điểm khuyết tật kỹ thuật nhỏ ẩn giấu trong thiết kế kết cấu ổ trục.'
WHERE id = '85784ca1-ecac-4ea5-941a-25032747725d' AND hsk_level = 'HSK 6';

INSERT INTO public.vocabulary_examples (
  id, vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index
)
SELECT
  gen_random_uuid(), '85784ca1-ecac-4ea5-941a-25032747725d', '航空发动机研发团队通过数万次极限工况仿真模拟实验，在试飞前成功排查并彻底攻克了轴承结构设计中存在的两处微小隐蔽技术缺陷。', 'Hángkōng fādòngjī yánfā tuánduì tōngguò shùwàn cì jíxiàn gōngkuàng fǎngzhēn mónǐ shíyàn, zài shìfēi qián chénggōng páichá bìng chèdǐ gōngkè le zhóuchéng jiégòu shèjì zhōng cúnzài de liǎng chù wēixiǎo yǐnbì jìshù quēxiàn.', 'Đội ngũ nghiên cứu động cơ hàng không qua hàng vạn lần thí nghiệm mô phỏng điều kiện làm việc giới hạn trước khi bay thử đã rà soát và khắc phục triệt để hai nhược điểm khuyết tật kỹ thuật nhỏ ẩn giấu trong thiết kế kết cấu ổ trục.', 'standard', 1
WHERE NOT EXISTS (
  SELECT 1 FROM public.vocabulary_examples WHERE vocabulary_id = '85784ca1-ecac-4ea5-941a-25032747725d'
);

COMMIT;
