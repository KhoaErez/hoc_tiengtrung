-- Migration: 20261024053000_patch_hsk6_8_examples.sql
-- Description: Chuẩn hóa 8 câu ví dụ HSK 6 để chứa trực tiếp 100% mục từ chữ Hán mục tiêu
-- Target Words: 从业, 稿子, 国旗, 奖牌, 通话, 下功夫, 中奖, 可怜

BEGIN;

-- 1. Lưu backup trạng thái cũ của 8 từ vào bảng data_audit_logs
INSERT INTO public.data_audit_logs (table_name, record_id, field_name, old_value, new_value, reason, migration_tag)
SELECT 
  'vocabularies', 
  id, 
  'example_hanzi', 
  example_hanzi, 
  'patch_keyword_exact_containment', 
  'Vá lỗi câu ví dụ chưa chứa trực tiếp từ vựng mục tiêu',
  '20261024053000_patch_hsk6_8_examples'
FROM public.vocabularies
WHERE id IN (
  '4365f148-b1c2-4a97-8889-df0549d490ab',
  'ebd82653-b30e-4e50-990e-da859304d5d7',
  'e11826fc-a697-45e9-bd7f-c9df7e49bbe9',
  '386836b6-61d0-4a5f-9248-6ace63a22d06',
  '1a86e414-4daf-4a78-9ed0-9c6a99cf7256',
  '02e4707a-ff73-4d07-92dd-f04e7dacb5a4',
  'babc0bf1-7b03-45e3-9aaa-9974476a56d9',
  '3d43eecb-e61d-4cac-b1a8-4a11ebd0d933'
);

-- 2. Cập nhật 8 câu ví dụ trong vocabularies
-- 1. 从业
UPDATE public.vocabularies
SET 
  example_hanzi = '想要在金融证券领域长期从业，不仅需要扎实的专业知识，还要严格遵守职业道德。',
  example_pinyin = 'Xiǎngyào zài jīnróng zhèngquàn lǐngyù chángqī cóngyè, bùjǐn xūyào zhāshi de zhuānyè zhīshi, hái yào yángé zūnshǒu zhíyè dàodé.',
  example_vi = 'Muốn hành nghề lâu dài trong lĩnh vực tài chính chứng khoán, không chỉ cần kiến thức chuyên môn vững chắc mà còn phải tuân thủ nghiêm ngặt đạo đức nghề nghiệp.'
WHERE id = '4365f148-b1c2-4a97-8889-df0549d490ab';

-- 2. 稿子
UPDATE public.vocabularies
SET 
  example_hanzi = '他在发言之前认真审核并修改了稿子，确保每一个论据都真实准确。',
  example_pinyin = 'Tā zài fāyán zhīqián rènzhēn shěnhè bìng xiūgǎi le gǎozi, quèbǎo měi yí gè lùnjù dōu zhēnshí zhǔnquè.',
  example_vi = 'Trước khi phát biểu, anh ấy đã cẩn thận kiểm duyệt và sửa lại bản thảo để đảm bảo mỗi luận cứ đều xác thực và chính xác.'
WHERE id = 'ebd82653-b30e-4e50-990e-da859304d5d7';

-- 3. 国旗
UPDATE public.vocabularies
SET 
  example_hanzi = '每当庄严的国旗在国际赛场上缓缓升起，在场的所有观众都会肃然起敬。',
  example_pinyin = 'Měidāng zhuāngyán de guóqí zài guójì sàichǎng shang huǎnhuǎn shēng qǐ, zài chǎng de suǒyǒu guānzhòng dōuhuì sùrán-qǐjìng.',
  example_vi = 'Mỗi khi lá quốc kỳ trang nghiêm từ từ được kéo lên trên đấu trường quốc tế, tất cả khán giả có mặt đều nghiêng mình kính cẩn.'
WHERE id = 'e11826fc-a697-45e9-bd7f-c9df7e49bbe9';

-- 4. 奖牌
UPDATE public.vocabularies
SET 
  example_hanzi = '经过多年的刻苦训练，这位年轻运动员终于在世界锦标赛上荣获了宝贵的金质奖牌。',
  example_pinyin = 'Jīngguò duō nián de kèkǔ xùnliàn, zhè wèi niánqīng yùndòngyuán zhōngyú zài shìjiè jǐnbiàosài shang rónghuò le bǎoguì de jīnhzì jiǎngpái.',
  example_vi = 'Sau nhiều năm khổ luyện kiên trì, vận động viên trẻ này cuối cùng đã giành được tấm huy chương vàng quý giá tại giải vô địch thế giới.'
WHERE id = '386836b6-61d0-4a5f-9248-6ace63a22d06';

-- 5. 通话
UPDATE public.vocabularies
SET 
  example_hanzi = '两国最高领导人昨晚进行了长达一个小时的亲切通话，就双边经贸合作深入交换了意见。',
  example_pinyin = 'Liǎng guó zuìgāo lǐngdǎorén zuówǎn jìnxíng le chángdá yí gè xiǎoshí de qīnqiè tōnghuà, jiù shuāngbiān jīng-mào hézuò shēnrù jiāohuàn le yìjiàn.',
  example_vi = 'Lãnh đạo cấp cao hai nước tối qua đã có cuộc điện đàm thân mật kéo dài một tiếng đồng hồ, trao đổi ý kiến sâu rộng về hợp tác kinh tế thương mại song phương.'
WHERE id = '1a86e414-4daf-4a78-9ed0-9c6a99cf7256';

-- 6. 下功夫
UPDATE public.vocabularies
SET 
  example_hanzi = '学习一门外语如果不肯静下心来下功夫，就很难真正掌握其精髓。',
  example_pinyin = 'Xuéxí yì mén wàiyǔ rúguǒ bù kěn jìng xià xīn lai xià gōngfu, jiù hěn nán zhēnzhèng zhǎngwò qí jīngsuǐ.',
  example_vi = 'Học một ngoại ngữ nếu không chịu tĩnh tâm bỏ công sức kiên trì, thì rất khó nắm bắt được thực sự tinh hoa của nó.'
WHERE id = '02e4707a-ff73-4d07-92dd-f04e7dacb5a4';

-- 7. 中奖
UPDATE public.vocabularies
SET 
  example_hanzi = '商场的年终促销活动吸引了众多顾客，大家都希望自己能够幸运中奖。',
  example_pinyin = 'Shāngchǎng de niánzhōng cùxiāo huódòng xīyǐn le zhòngduō gùkè, dàjiā dōu xīwàng zìjǐ nénggòu xìngyùn zhòngjiǎng.',
  example_vi = 'Chương trình khuyến mãi cuối năm của trung tâm thương mại thu hút đông đảo khách hàng, ai nấy đều hy vọng mình sẽ may mắn trúng thưởng.'
WHERE id = 'babc0bf1-7b03-45e3-9aaa-9974476a56d9';

-- 8. 可怜
UPDATE public.vocabularies
SET 
  example_hanzi = '看到那只在寒冬风雨中瑟瑟发抖的流浪小猫，大家都觉得它十分可怜。',
  example_pinyin = 'Kàndào nà zhī zài hándōng fēngyǔ zhōng sèsè fādǒu de liúlàng xiǎomāo, dàjiā dōu juéde tā shífēn kělián.',
  example_vi = 'Nhìn thấy chú mèo con hoang run rẩy trong mưa gió mùa đông buốt giá, mọi người đều cảm thấy nó vô cùng đáng thương.'
WHERE id = '3d43eecb-e61d-4cac-b1a8-4a11ebd0d933';

-- 3. Cập nhật bảng vocabulary_examples tương ứng
UPDATE public.vocabulary_examples ve
SET 
  chinese = v.example_hanzi,
  pinyin = v.example_pinyin,
  meaning_vi = v.example_vi
FROM public.vocabularies v
WHERE ve.vocabulary_id = v.id
  AND v.id IN (
    '4365f148-b1c2-4a97-8889-df0549d490ab',
    'ebd82653-b30e-4e50-990e-da859304d5d7',
    'e11826fc-a697-45e9-bd7f-c9df7e49bbe9',
    '386836b6-61d0-4a5f-9248-6ace63a22d06',
    '1a86e414-4daf-4a78-9ed0-9c6a99cf7256',
    '02e4707a-ff73-4d07-92dd-f04e7dacb5a4',
    'babc0bf1-7b03-45e3-9aaa-9974476a56d9',
    '3d43eecb-e61d-4cac-b1a8-4a11ebd0d933'
  )
  AND ve.order_index = 1;

COMMIT;
