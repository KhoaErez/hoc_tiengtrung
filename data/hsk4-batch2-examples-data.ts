// ====================================================================
// HSK 4 - BATCH 2: 100 TỪ VỰNG & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #1101 [此外] (cǐwài) -> #1200 [费用] (fèiyong)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin + Dịch TV
// ====================================================================

import type { Hsk4ExampleItem } from './hsk4-batch1-examples-data'

export const HSK4_BATCH2_EXAMPLES: Hsk4ExampleItem[] = [
  {
    hanzi: '此外',
    pinyin: 'cǐwài',
    word_type: 'Liên từ',
    meaning_vi: 'ngoài ra, hơn nữa',
    examples: [
      { chinese: '他精通英语，此外还会说一些日常法语。', pinyin: 'Tā jīngtōng Yīngyǔ, cǐwài hái huì shuō yìxiē rìcháng Fǎyǔ.', meaning_vi: 'Anh ấy thông thạo tiếng Anh, ngoài ra còn biết nói một chút tiếng Pháp giao tiếp hàng ngày.', difficulty_level: 'basic' },
      { chinese: '这份合作方案不仅能大幅削减运营成本，此外还能有效提高团队的跨部门协作效率。', pinyin: 'Zhè fèn hézuò fāng’àn bùjǐn néng dàfú xuējiǎn yùnyíng chéngběn, cǐwài hái néng yǒuxiào tígāo tuánduì de kuà-bùmén xiézuò xiàolǜ.', meaning_vi: 'Phương án hợp tác này không chỉ cắt giảm đáng kể chi phí vận hành, ngoài ra còn nâng cao hiệu quả phối hợp liên phòng ban của đội ngũ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '从此',
    pinyin: 'cóngcǐ',
    word_type: 'Phó từ',
    meaning_vi: 'từ đó, từ nay về sau',
    examples: [
      { chinese: '大学毕业后他留在了上海工作，从此定居在这座现代化大都市。', pinyin: 'Dàxué bìyè hòu tā liú zài le Shànghǎi gōngzuò, cóngcǐ dìngjū zài zhè zuò xiàndàihuà dà dūshì.', meaning_vi: 'Sau khi tốt nghiệp đại học anh ấy ở lại Thượng Hải làm việc, từ đó định cư tại đô thị hiện đại này.', difficulty_level: 'basic' },
      { chinese: '经历了那次惨痛的失败教训，他从此痛定思痛，做事变得格外严谨谨慎。', pinyin: 'Jīnglì le nà cì cǎntòng de shībài jiàoxùn, tā cóngcǐ tòngdìng-sītòng, zuò shì biàn de géwài yánjǐn jǐnshèn.', meaning_vi: 'Trải qua bài học thất bại cay đắng lần đó, từ đó về sau anh ấy rút kinh nghiệm sâu sắc, làm việc trở nên vô cùng cẩn trọng chu đáo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '从来',
    pinyin: 'cónglái',
    word_type: 'Phó từ',
    meaning_vi: 'từ trước đến nay, luôn luôn',
    examples: [
      { chinese: '他对待工作一向认真负责，从来不迟到早退。', pinyin: 'Tā duìdài gōngzuò yíxiàng rènzhēn fùzé, cónglái bù chídào zǎotuì.', meaning_vi: 'Anh ấy đối với công việc luôn nghiêm túc có trách nhiệm, từ trước đến nay không hề đi muộn về sớm.', difficulty_level: 'basic' },
      { chinese: '真正的成功从来不是一蹴而就的，它需要长年累月的坚持不懈与默默积累。', pinyin: 'Zhēnzhèng de chénggōng cónglái bú shì yícù’érjiù de, tā xūyào chángnián-lěiyuè de jiānchí-búxiè yǔ mòmò jīlěi.', meaning_vi: 'Thành công thực sự từ trước tới nay không bao giờ đạt được trong một sớm một chiều, nó đòi hỏi sự kiên trì bền bỉ và tích lũy âm thầm qua năm tháng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '从中',
    pinyin: 'cóngzhōng',
    word_type: 'Phó từ',
    meaning_vi: 'từ đó, trong đó',
    examples: [
      { chinese: '阅读优秀文学作品不仅能开阔眼界，更能让我们从中汲取丰富的人生智慧。', pinyin: 'Yuèdú yōuxiù wénxué zuòpǐn bùjǐn néng kāikuò yǎnjiè, gèng néng ràng wǒmen cóngzhōng jíqǔ fēngfù de rénshēng zhìhuì.', meaning_vi: 'Đọc các tác phẩm văn học ưu tú không chỉ mở rộng tầm mắt mà còn giúp chúng ta tiếp thu được trí tuệ nhân sinh phong phú từ trong đó.', difficulty_level: 'basic' },
      { chinese: '善于在复盘中总结失败的原因，并从中找到破局之策，是优秀管理者必备的素养。', pinyin: 'Shànyú zài fùpán zhōng zǒngjié shībài de yuányīn, bìng cóngzhōng zhǎodào pòjú zhī cè, shì yōuxiù guǎnlǐzhě bìbèi de sùyǎng.', meaning_vi: 'Biết tổng kết nguyên nhân thất bại sau mỗi lần nhìn nhận lại và tìm ra sách lược khai thông từ đó là tố chất cần có của nhà quản lý xuất sắc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '粗',
    pinyin: 'cū',
    word_type: 'Tính từ',
    meaning_vi: 'thô, to, dày, vụng về',
    examples: [
      { chinese: '院子里那棵参天大树的树干非常粗，两个人才能勉强合抱过来。', pinyin: 'Yuànzi lǐ nà kē cāntiān dàshù de shùgàn fēicháng cū, liǎng gè rén cái néng miǎnqiǎng hébào guòlái.', meaning_vi: 'Thân cây đại thụ chọc trời trong sân to lắm, phải hai người mới ôm xuể.', difficulty_level: 'basic' },
      { chinese: '做工粗糙的低劣产品很难在竞争日益激烈的国际高端市场上赢得立足之地。', pinyin: 'Zuògōng cūcāo de dīliè chǎnpǐn hěn nán zài jìngzhēng rìyì jīliè de guójì gāoduān shìchǎng shang yíngdé lìzú-zhīdì.', meaning_vi: 'Các sản phẩm chất lượng thấp gia công thô kệch rất khó có thể giành được chỗ đứng trên thị trường quốc tế cao cấp đang cạnh tranh ngày càng gay gắt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '粗心',
    pinyin: 'cūxīn',
    word_type: 'Tính từ',
    meaning_vi: 'sơ ý, cẩu thả, bất cẩn',
    examples: [
      { chinese: '因为考试时太粗心，他把一道很简单的数学计算题算错了。', pinyin: 'Yīnwèi kǎoshì shí tài cūxīn, tā bǎ yí dào hěn jiǎndān de shùxué jìsuàn tí suàn cuò le.', meaning_vi: 'Vì lúc thi quá bất cẩn, cậu ấy đã tính sai một câu tính toán toán học rất đơn giản.', difficulty_level: 'basic' },
      { chinese: '医疗和航天等高精密行业容不得半点粗心大意，细微的疏忽都可能引发难以挽回的灾难。', pinyin: 'Yīliáo hé hángtiān děng gāo jīngmì hángyè róng bu dé bàndiǎnr cūxīn-dàyì, xìwēi de shūhu dōu kěnéng yǐnfā nányǐ wǎnhuí de zāinàn.', meaning_vi: 'Các ngành có độ chính xác cao như y tế và hàng không vũ trụ không chấp nhận bất kỳ sự cẩu thả nào, một sơ suất nhỏ đều có thể gây ra thảm họa khôn lường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '村',
    pinyin: 'cūn',
    word_type: 'Danh từ',
    meaning_vi: 'làng, thôn, xã',
    examples: [
      { chinese: '我的爷爷奶奶一辈子都生活在宁静美丽的乡村里。', pinyin: 'Wǒ de yéye nǎinai yíbèizi dōu shēnghuó zài níngjìng měilì de xiāngcūn lǐ.', meaning_vi: 'Ông bà nội tôi cả đời đều sinh sống ở vùng làng quê thanh bình tươi đẹp.', difficulty_level: 'basic' },
      { chinese: '随着乡村振兴战略的稳步推进，许多偏远贫困的小山村如今通了公路，面貌焕然一新。', pinyin: 'Suízhe xiāngcūn zhènxīng zhànlüè de wěnbù tuījìn, xǔduō piānyuǎn pínkùn de xiǎoshāncūn rújīn tōng le gōnglù, miànmào huànrán-yìxīn.', meaning_vi: 'Cùng với sự thúc đẩy vững chắc của chiến lược phục hưng nông thôn, nhiều thôn bản miền núi hẻo lánh nay đã có đường nhựa, diện mạo đổi mới hoàn toàn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '存',
    pinyin: 'cún',
    word_type: 'Động từ',
    meaning_vi: 'gửi, cất, lưu trữ, để dành',
    examples: [
      { chinese: '每个月发了工资后，他都会存一部分钱到银行里。', pinyin: 'Měi gè yuè fā le gōngzī hòu, tā dōu huì cún yí bùfen qián dào yínháng lǐ.', meaning_vi: 'Mỗi tháng sau khi nhận lương, anh ấy đều gửi một phần tiền vào ngân hàng.', difficulty_level: 'basic' },
      { chinese: '在公共电脑上编辑完重要工作文档后，务必及时将其保存并备份到个人安全云盘。', pinyin: 'Zài gōnggòng diànnǎo shang biānjí wán zhòngyào gōngzuò wéndàng hòu, wùbì jíshí jiāng qí bǎocún bìng bèifèn dào gèrén ānquán yúnpán.', meaning_vi: 'Sau khi chỉnh sửa xong tài liệu công việc quan trọng trên máy tính công cộng, nhất định phải kịp thời lưu lại và sao lưu lên đám mây an toàn cá nhân.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '错过',
    pinyin: 'cuòguò',
    word_type: 'Động từ',
    meaning_vi: 'bỏ lỡ, để lỡ',
    examples: [
      { chinese: '路上堵车太严重，他最终错过了开往北京的高铁。', pinyin: 'Lù shang dǔchē tài yánzhòng, tā zuìzhōng cuòguò le kāi wǎng Běijīng de gāotiě.', meaning_vi: 'Đường tắc nghiêm trọng quá, cuối cùng cậu ấy đã bỏ lỡ chuyến tàu cao tốc đi Bắc Kinh.', difficulty_level: 'basic' },
      { chinese: '机不可失，失不再来，面对稍纵即逝的宝贵人生机遇，我们绝不能轻易错过。', pinyin: 'Jībùkěshī, shībúzàilái, miànduì shāozòng-jíshì de bǎoguì rénshēng jīyù, wǒmen jué bù néng qīngyì cuòguò.', meaning_vi: 'Thời cơ hiếm có, mất đi không lấy lại được, đứng trước cơ hội cuộc đời quý giá thoáng qua mau, chúng ta tuyệt đối không thể dễ dàng bỏ lỡ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '错误',
    pinyin: 'cuòwù',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'sai sót, lỗi lầm; sai',
    examples: [
      { chinese: '发现了试卷中的书写错误后，他立刻用橡皮擦掉并订正过来。', pinyin: 'Fāxiàn le shìjuàn zhōng de shūxiě cuòwù hòu, tā lìkè yòng xiàngpí cā diào bìng dìngzhèng guòlái.', meaning_vi: 'Sau khi phát hiện lỗi viết sai trong bài thi, cậu ấy lập tức dùng tẩy xóa đi và sửa lại cho đúng.', difficulty_level: 'basic' },
      { chinese: '勇于正视自身的缺点与错误，并从中汲取有益的成长营养，才是一个人走向成熟的标志。', pinyin: 'Yǒngyú zhèngshì zìshēn de quēdiǎn yǔ cuòwù, bìng cóngzhōng jíqǔ yǒuyì de chéngzhǎng yíngyǎng, cái shì yí gè rén zǒuxiàng chéngshú de biāozhì.', meaning_vi: 'Dũng cảm nhìn thẳng vào khuyết điểm lỗi lầm của bản thân và rút ra bài học phát triển từ đó mới là dấu hiệu một người bước tới sự trưởng thành.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '答应',
    pinyin: 'dāying',
    word_type: 'Động từ',
    meaning_vi: 'đồng ý, hứa; trả lời, đáp lại',
    examples: [
      { chinese: '既然你已经答应了别人的事情，就一定要信守诺言尽力做到。', pinyin: 'Jìrán nǐ yǐjīng dāying le biérén de shìqing, jiù yídìng yào xìnshǒu nuòyán jìnlì zuò dào.', meaning_vi: 'Một khi bạn đã hứa với người khác thì nhất định phải giữ lời và dốc sức làm cho bằng được.', difficulty_level: 'basic' },
      { chinese: '无论我在走廊这头怎么大声呼喊他的名字，他都全神贯注沉浸在实验中没有答应。', pinyin: 'Wúlùn wǒ zài zǒuláng zhè tóu zěnme dàshēng hūhǎn tā de míngzi, tā dōu quánshén-guànzhù chénjìn zài shíyàn zhōng méiyǒu dāying.', meaning_vi: 'Dù tôi ở đầu hành lang này gọi to tên anh ấy thế nào, anh ấy đều tập trung cao độ chìm đắm trong thí nghiệm mà không hề đáp lại.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '答',
    pinyin: 'dá',
    word_type: 'Động từ',
    meaning_vi: 'trả lời, hồi đáp, giải đáp',
    examples: [
      { chinese: '这道考题比较难，考场里大部分同学一时都答不上来。', pinyin: 'Zhè dào kǎotí bǐjiào nán, kǎochǎng lǐ dà bùfen tóngxué yìshí dōu dá bu shànglái.', meaning_vi: 'Câu hỏi thi này khá khó, phần lớn các bạn học trong phòng thi nhất thời đều không trả lời được.', difficulty_level: 'basic' },
      { chinese: '在新闻发布会上，新闻发言人沉着冷静地逐一回答了中外记者的关切提问。', pinyin: 'Zài xīnwén fābùhuì shang, xīnwén fāyánrén chénzhuó lěngjìng de zhúyī huídá le zhōng-wài jìzhě de guānqiè tíwèn.', meaning_vi: 'Tại buổi họp báo, người phát ngôn tin tức đã điềm đạm bình tĩnh trả lời từng câu hỏi chất vấn của các phóng viên trong và ngoài nước.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '答案',
    pinyin: 'dá’àn',
    word_type: 'Danh từ',
    meaning_vi: 'đáp án, câu trả lời',
    examples: [
      { chinese: '请把做完的练习题答案和课本附录对照一下。', pinyin: 'Qǐng bǎ zuò wán de liànxí tí dá’àn hé kèběn fùlù duìzhào yíxià.', meaning_vi: 'Xin hãy đối chiếu đáp án bài tập đã làm với phần phụ lục sách giáo khoa.', difficulty_level: 'basic' },
      { chinese: '面对复杂多变的商业竞争环境，并没有放之四海而皆准的唯一现成标准答案。', pinyin: 'Miànduì fùzá duōbiàn de shāngyè jìngzhēng huánjìng, bìng méiyǒu fàngzhīsìhǎi’érjiēzhǔn de wéiyī xiànchéng biāozhǔn dá’àn.', meaning_vi: 'Đứng trước môi trường cạnh tranh thương mại biến hóa khôn lường, không hề có đáp án chuẩn mực duy nhất nào đúng cho mọi trường hợp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '达到',
    pinyin: 'dádào',
    word_type: 'Động từ',
    meaning_vi: 'đạt được, đạt tới',
    examples: [
      { chinese: '经过全组员工的努力，公司的月销售额终于达到了既定目标。', pinyin: 'Jīngguò quán zǔ yuángōng de nǔlì, gōngsī de yuè xiāoshòu’é zhōngyú dádào le jìdìng mùbiāo.', meaning_vi: 'Nhờ nỗ lực của toàn thể nhân viên nhóm, doanh số tháng của công ty rốt cuộc đã đạt được mục tiêu đề ra.', difficulty_level: 'basic' },
      { chinese: '只有当汉语综合运用能力达到一定深度时，才能无障碍地阅读中国古典名著。', pinyin: 'Zhǐyào dāng Hànyǔ zōnghé yùnyòng nénglì dádào yídìng shēndù shí, cái néng wúzhàng’ài de yuèdú Zhōngguó gǔdiǎn míngzhù.', meaning_vi: 'Chỉ khi năng lực vận dụng tổng hợp Hán ngữ đạt tới độ sâu nhất định mới có thể đọc các danh tác cổ điển Trung Hoa mà không gặp rào cản.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打招呼',
    pinyin: 'dǎ zhāohu',
    word_type: 'Cụm từ / Động từ',
    meaning_vi: 'chào hỏi, chào',
    examples: [
      { chinese: '每天早晨在走廊里遇到老师和同学，他都会礼貌地微笑着打招呼。', pinyin: 'Měitiān zǎochén zài zǒuláng lǐ yùdào lǎoshī hé tóngxué, tā dōu huì lǐmào de wēixiào zhe dǎ zhāohu.', meaning_vi: 'Mỗi buổi sáng khi gặp thầy cô và bạn học ở hành lang, cậu ấy đều mỉm cười lễ phép chào hỏi.', difficulty_level: 'basic' },
      { chinese: '主动向邻里邻居热情打招呼不仅是礼貌的体现，更能拉近人与人之间的心灵距离。', pinyin: 'Zhǔdòng xiàng línlǐ línjū rèqíng dǎ zhāohu bùjǐn shì lǐmào de tǐxiàn, gèng néng lājìn rén yǔ rén zhījiān de xīnlíng jùlí.', meaning_vi: 'Chủ động nhiệt tình chào hỏi bà con lối xóm không chỉ là biểu hiện lịch sự mà còn kéo gần khoảng cách tâm hồn giữa người với người.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打败',
    pinyin: 'dǎbài',
    word_type: 'Động từ',
    meaning_vi: 'đánh bại',
    examples: [
      { chinese: '在这场激烈的乒乓球决赛中，年轻的小将以三比一的比分打败了卫冕冠军。', pinyin: 'Zài zhè chǎng jīliè de pīngpāngqiú juésài zhōng, niánqīng de xiǎojiàng yǐ sān bǐ yī de bǐfēn dǎbài le wèimiǎn guànjūn.', meaning_vi: 'Trong trận chung kết bóng bàn kịch tính này, tay vợt trẻ đã đánh bại đương kim vô địch với tỷ số ba-một.', difficulty_level: 'basic' },
      { chinese: '在人生的漫长赛道上，能够真正打败我们的往往不是强大的竞争对手，而是自身的怯懦与自满。', pinyin: 'Zài rénshēng de màncháng sàidào shang, nénggòu zhēnzhèng dǎbài wǒmen de wǎngwǎng bú shì qiángdà de jìngzhēng duìshǒu, ér shì zìshēn de qiènuò yǔ zìmǎn.', meaning_vi: 'Trên đường đua dài của cuộc đời, thứ có thể thực sự đánh bại chúng ta thường không phải đối thủ cạnh tranh mạnh mẽ mà chính là sự nhu nhược tự mãn của bản thân.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打工',
    pinyin: 'dǎgōng',
    word_type: 'Động từ',
    meaning_vi: 'làm thuê, làm thêm',
    examples: [
      { chinese: '许多大学生在周末和暑假期间去咖啡店打工以赚取生活费。', pinyin: 'Xǔduō dàxuéshēng zài zhōumò hé shǔjià qījiān qù kāfēidiàn dǎgōng yǐ zhuànqǔ shēnghuófèi.', meaning_vi: 'Nhiều sinh viên đại học vào cuối tuần và kỳ nghỉ hè đi làm thêm ở quán cà phê để trang trải chi phí sinh hoạt.', difficulty_level: 'basic' },
      { chinese: '课余适度打工不仅能够减轻家庭的经济负担，更是一次宝贵提前接触社会的实践经历。', pinyin: 'Kèyú shìdù dǎgōng bùjǐn nénggòu jiǎnqīng jiātíng de jīngjì fùdān, gèng shì yí cì bǎoguì tíqián jiēchù shèhuì de shíjiàn jīnglì.', meaning_vi: 'Đi làm thêm chừng mực ngoài giờ học không những san sẻ được gánh nặng kinh tế gia đình mà còn là một trải nghiệm thực tế quý giá giúp tiếp xúc sớm với xã hội.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打扰',
    pinyin: 'dǎrǎo',
    word_type: 'Động từ',
    meaning_vi: 'làm phiền, quấy rầy',
    examples: [
      { chinese: '真不好意思，百忙之中打扰您几分钟时间向您请教个问题。', pinyin: 'Zhēn bù hǎoyìsi, bǎimáng-zhīzhōng dǎrǎo nín jǐ fēnzhōng shíjiān xiàng nín qǐngjiào gè wèntí.', meaning_vi: 'Thực sự ngại quá, giữa lúc trăm công nghìn việc xin làm phiền anh vài phút để thỉnh giáo một vấn đề.', difficulty_level: 'basic' },
      { chinese: '图书馆是公共自主学习的安静场所，进出时请勿大声喧哗打扰他人阅读思考。', pinyin: 'Túshūguǎn shì gōnggòng zìzhǔ xuéxí de ānjìng chǎngsuǒ, jìn-chū shí qǐng wù dàshēng xuānhuá dǎrǎo tārén yuèdú sīkǎo.', meaning_vi: 'Thư viện là nơi chốn công cộng yên tĩnh để tự học, khi ra vào xin đừng làm ồn lớn tiếng quấy rầy người khác đọc sách tư duy.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打印',
    pinyin: 'dǎyìn',
    word_type: 'Động từ',
    meaning_vi: 'in ấn, in',
    examples: [
      { chinese: '请把这份明天会议要用到的发言材料打印十份。', pinyin: 'Qǐng bǎ zhè fèn míngtiān huìyì yào yòng dào de fāyán cáiliào dǎyìn shí fèn.', meaning_vi: 'Xin hãy in mười bản tài liệu phát biểu cần dùng cho cuộc họp ngày mai này.', difficulty_level: 'basic' },
      { chinese: '为了贯彻无纸化低碳绿色办公理念，非必要内部交流文件建议尽量不要打印纸质版本。', pinyin: 'Wèile guànchè wúzǐhuà dītàn lǜsè bàngōng lǐniàn, fēi bìyào nèibù jiāoliú wénjiàn jiànyì jǐnliàng bú yào dǎyìn zhǐzhì bǎnběn.', meaning_vi: 'Nhằm quán triệt tư tưởng văn phòng xanh giảm carbon không giấy tờ, những văn bản trao đổi nội bộ không cần thiết khuyến nghị hạn chế in ấn bản giấy.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打印机',
    pinyin: 'dǎyìnjī',
    word_type: 'Danh từ',
    meaning_vi: 'máy in',
    examples: [
      { chinese: '办公室的激光打印机没墨了，需要更换新的墨盒。', pinyin: 'Bàngōngshì de jīguāng dǎyìnjī méi mò le, xūyào gēnghuàn xīn de mòhé.', meaning_vi: 'Chiếc máy in laser ở văn phòng hết mực rồi, cần phải thay hộp mực mới.', difficulty_level: 'basic' },
      { chinese: '这台新型多功能一体化无线打印机集打印、扫描和彩色复印等多种功能于一身。', pinyin: 'Zhè tái xīnxíng duōgōngnéng yītǐhuà wúxiàn dǎyìnjī jí dǎyìn, sǎomiáo hé cǎisè fùyìn děng duō zhǒng gōngnéng yú yì shēn.', meaning_vi: 'Chiếc máy in không dây đa chức năng kiểu mới này tích hợp trọn vẹn nhiều tính năng như in ấn, scan và photocopy màu trong một thân máy.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打折',
    pinyin: 'dǎzhé',
    word_type: 'Động từ',
    meaning_vi: 'giảm giá, chiết khấu',
    examples: [
      { chinese: '商场正在举办换季大促销活动，全场男女服装一律打八折。', pinyin: 'Shāngchǎng zhèngzài jǔbàn huànjì dà cùxiāo huódòng, quánchǎng nán-nǚ fúzhuāng yílǜ dǎ bā zhé.', meaning_vi: 'Trung tâm mua sắm đang tổ chức đợt xả hàng lớn chuyển mùa, toàn bộ trang phục nam nữ đồng loạt giảm giá hai mươi phần trăm (tính tám mươi phần trăm giá gốc).', difficulty_level: 'basic' },
      { chinese: '虽然商品标价打折力度很大，但消费者在网购付款前仍需保持理性，避免盲目囤货。', pinyin: 'Suīrán shāngpǐn biāojià dǎzhé lìdù hěn dà, dàn xiāofèizhě zài wǎnggòu fùkuǎn qián réng xū bǎochí lǐxìng, bìmiǎn mángmù túnhuò.', meaning_vi: 'Dù mức độ giảm giá niêm yết của hàng hóa rất sâu, người tiêu dùng trước khi thanh toán mua hàng qua mạng vẫn cần giữ sự tỉnh táo, tránh tích trữ mù quáng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '打针',
    pinyin: 'dǎzhēn',
    word_type: 'Động từ',
    meaning_vi: 'tiêm thuốc, chích thuốc',
    examples: [
      { chinese: '小妹妹从小就很勇敢，去社区医院生病打针时从来不哭。', pinyin: 'Xiǎo mèimei cóngxiǎo jiù hěn yǒnggǎn, qù shèqū yīyuàn shēngbìng dǎzhēn shí cónglái bù kū.', meaning_vi: 'Em gái nhỏ từ bé đã rất dũng cảm, khi đi bệnh viện khu phố tiêm thuốc lúc ốm không bao giờ khóc.', difficulty_level: 'basic' },
      { chinese: '按时前往专业医疗卫生机构接种预防各类传染病的疫苗打针，是构筑群体免疫屏障的有力手段。', pinyin: 'Ànshí qiánwǎng zhuānyè yīliáo wèishēng jīgòu jiēzhòng yùfáng gè lèi chuánrǎnbìng de yìmiáo dǎzhēn, shì gòuzhù qúntǐ miǎnyì píngzhàng de yǒulì shǒuduàn.', meaning_vi: 'Đến các cơ sở y tế chuyên môn tiêm vắc xin phòng ngừa các bệnh truyền nhiễm đúng hẹn là biện pháp hữu hiệu để xây dựng lá chắn miễn dịch cộng đồng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大巴',
    pinyin: 'dàbā',
    word_type: 'Danh từ',
    meaning_vi: 'xe khách cỡ lớn, xe buýt du lịch',
    examples: [
      { chinese: '全体师生准时在校门口集合，乘坐豪华大巴前往野生动物园春游。', pinyin: 'Quántǐ shīshēng zhǔnshí zài xiàomén kǒu jíhé, chéngzuò háohuá dàbā qiánwǎng yěshēng dòngwùyuán chūnyóu.', meaning_vi: 'Toàn thể thầy trò tập trung đúng giờ ở cổng trường, lên xe khách du lịch sang trọng đi dã ngoại mùa xuân tại vườn thú hoang dã.', difficulty_level: 'basic' },
      { chinese: '为了方便偏远乡村村民往返县城，客运公司特意增开了每日多班次的惠民长途大巴。', pinyin: 'Wèile fāngbiàn piānyuǎn xiāngcūn cūnmín wǎngfǎn xiànchéng, kèyùn gōngsī tèyì zēngkāi le měirì duō bāncì de huìmín chángtú dàbā.', meaning_vi: 'Nhằm tạo thuận tiện cho bà con nông thôn vùng xa đi lại huyện lỵ, công ty vận tải hành khách đã tăng cường thêm nhiều chuyến xe khách đường dài trợ giá mỗi ngày.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大大',
    pinyin: 'dàdà',
    word_type: 'Phó từ',
    meaning_vi: 'rất lớn, vô cùng, hết sức',
    examples: [
      { chinese: '经过近两个月的高强度集中强化，他的汉语听力与阅读能力大大提高了。', pinyin: 'Jīngguò jìn liǎng gè yuè de gāoxiàngdù jízhōng qiánghuà, tā de Hànyǔ tīnglì yǔ yuèdú nénglì dàdà tígāo le.', meaning_vi: 'Trải qua gần hai tháng rèn luyện tập trung cường độ cao, năng lực nghe hiểu và đọc hiểu tiếng Trung của cậu ấy đã tiến bộ vượt bậc.', difficulty_level: 'basic' },
      { chinese: '高速铁路网络的密集覆盖与全线贯通，大大缩短了沿线各大城市之间的时空通勤距离。', pinyin: 'Gāosù tiělù wǎngluò de mìmí fùgài yǔ quánxiàn guàntōng, dàdà suōduǎn le yánxiàn gè dà chéngshì zhījiān de shíkōng tōngqín jùlí.', meaning_vi: 'Mạng lưới đường sắt cao tốc phủ kín và thông tuyến toàn diện đã rút ngắn rất nhiều khoảng cách thời gian đi lại giữa các đô thị lớn dọc tuyến.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大夫',
    pinyin: 'dàifu',
    word_type: 'Danh từ',
    meaning_vi: 'bác sĩ, thầy thuốc',
    examples: [
      { chinese: '张大夫医术精湛，对待每一位前来看病的病患都和蔼可亲。', pinyin: 'Zhāng dàifu yīshù jīngzhàn, duìdài měi yí wèi qiánlái kànbìng de bìnghuàn dōu hé’ǎi-kěqīn.', meaning_vi: 'Bác sĩ Trương y thuật cao minh, đối đãi với từng người bệnh tới khám đều hiền từ niềm nở.', difficulty_level: 'basic' },
      { chinese: '经过值班主治大夫与医护团队连夜数小时的争分夺秒全力抢救，危重病人终于脱离了生命危险。', pinyin: 'Jīngguò zhíbān zhǔzhì dàifu yǔ yīhù tuánduì liányè shù xiǎoshí de zhēngfēn-duómiǎo quánlì qiǎngjiù, wēizhòng bìngrén zhōngyú tuōlí le shēngmìng wēixiǎn.', meaning_vi: 'Trải qua nhiều giờ tranh thủ từng phút từng giây cấp cứu thâu đêm của bác sĩ trực ca và kíp điều dưỡng, bệnh nhân nguy kịch rốt cuộc đã qua cơn hiểm nghèo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大量',
    pinyin: 'dàliàng',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'số lượng lớn, nhiều',
    examples: [
      { chinese: '剧烈运动之后体内水分大量流失，需要及时补充淡盐水。', pinyin: 'Jùliè yùndòng zhīhòu tǐnèi shuǐfèn dàliàng liúshī, xūyào jíshí bǔchōng dàn yánshuǐ.', meaning_vi: 'Sau khi vận động mạnh lượng nước trong cơ thể thất thoát rất nhiều, cần bù đắp nước muối loãng kịp thời.', difficulty_level: 'basic' },
      { chinese: '该研究课题的深入开展必须建立在对海量历史文献和一手实地考察数据的大量科学分析之上。', pinyin: 'Gāi yánjiū kètí de shēnrù kāizhǎn bìxū jiànlì zài duì hǎiliàng lìshǐ wénxiàn hé yìshǒu shídì kǎochá shùjù de dàliàng kēxué fēnxī zhīshàng.', meaning_vi: 'Việc triển khai sâu rộng đề tài nghiên cứu này phải được xây dựng trên cơ sở phân tích khoa học khối lượng lớn đối với tư liệu lịch sử đồ sộ và số liệu khảo sát thực địa sơ cấp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大赛',
    pinyin: 'dàsài',
    word_type: 'Danh từ',
    meaning_vi: 'cuộc thi lớn, giải đấu lớn',
    examples: [
      { chinese: '来自全国顶尖高校的青年学子在这次创新创业大赛中大放异彩。', pinyin: 'Láizì quán guó dǐngjiān gāoxiào de qīngnián xuézǐ zài zhè cì chuàngxīn chuàngyè dàsài zhōng dà fàng yìcǎi.', meaning_vi: 'Các bạn trẻ sinh viên đến từ những trường đại học tốp đầu trên cả nước đã tỏa sáng rực rỡ tại giải thi đấu đổi mới khởi nghiệp lần này.', difficulty_level: 'basic' },
      { chinese: '四年一届的国际奥林匹克体育大赛是全人类弘扬和平友谊与拼搏竞技精神的共同盛会。', pinyin: 'Sì nián yí jiè de guójì àolínpǐkè tǐyù dàsài shì quán rénlèi hóngyáng hépíng yǒuyì yǔ pīnbó jìngjì jīngshén de gòngtóng shènghuì.', meaning_vi: 'Đại hội thể thao Olympic quốc tế bốn năm một lần là ngày hội chung của toàn nhân loại nhằm tôn vinh tình hữu nghị hòa bình và tinh thần thể thao thi đấu quả cảm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大厅',
    pinyin: 'dàtīng',
    word_type: 'Danh từ',
    meaning_vi: 'đại sảnh',
    examples: [
      { chinese: '宾馆一楼宽敞明亮的服务大厅里摆放着美丽的鲜花与舒适的沙发。', pinyin: 'Bīnguǎn yī lóu kuānchǎng míngliàng de fúwù dàtīng lǐ bǎifàng zhe měilì de xiānhuā yǔ shūshì de shāfā.', meaning_vi: 'Trong đại sảnh phục vụ rộng rãi sáng sủa tầng một khách sạn bài trí những bình hoa tươi đẹp mắt và ghế sofa êm ái.', difficulty_level: 'basic' },
      { chinese: '新落成的现代综合政务服务大厅推行全流程数字化导引，极大缩短了市民前来办事的等候时间。', pinyin: 'Xīn luòchéng de xiàndài zōnghé zhèngwù fúwù dàtīng tuīxíng quán liúchéng shùzìhuà dǎoyǐn, jídà suōduǎn le shìmín qiánlái bànshì de děnghòu shíjiān.', meaning_vi: 'Đại sảnh dịch vụ hành chính tổng hợp hiện đại mới hoàn thành áp dụng chỉ dẫn số hóa toàn bộ quy trình, rút ngắn đáng kể thời gian chờ đợi của người dân đến làm việc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大约',
    pinyin: 'dàyuē',
    word_type: 'Phó từ',
    meaning_vi: 'khoảng chừng, ước chừng',
    examples: [
      { chinese: '从我家步行到最近的地铁站大约需要十五分钟左右。', pinyin: 'Cóng wǒ jiā bùxíng dào zuì jìn de dìtiězhàn dàyuē xūyào shíwǔ fēnzhōng zuǒyòu.', meaning_vi: 'Từ nhà tôi đi bộ tới ga tàu điện ngầm gần nhất mất khoảng chừng mười lăm phút.', difficulty_level: 'basic' },
      { chinese: '根据最新的人口统计学普查报告显示，该市目前的常住外籍人员规模大约在五万人上下。', pinyin: 'Gēnjù zuìxīn de rénkǒu tǒngjìxué pǔchá bàogào xiǎnshì, gāi shì mùqián de chángzhù wàijí rényuán guīmó dàyuē zài wǔ wàn rén shàngxià.', meaning_vi: 'Theo báo cáo điều tra thống kê dân số mới nhất cho thấy, quy mô người nước ngoài thường trú tại thành phố này hiện nay vào khoảng chừng năm vạn người.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '大自然',
    pinyin: 'dàzìrán',
    word_type: 'Danh từ',
    meaning_vi: 'mẹ thiên nhiên, tự nhiên',
    examples: [
      { chinese: '周末远离城市的喧嚣，走进大自然呼吸新鲜空气能彻底放松身心。', pinyin: 'Zhōumò yuǎnlí chéngshì de xuānxiāo, zǒujìn dàzìrán hūxī xīnxiān kōngqì néng chèdǐ fàngsōng shēnxīn.', meaning_vi: 'Cuối tuần tránh xa tiếng ồn ào của thành phố, bước vào thiên nhiên hít thở không khí trong lành có thể thư giãn hoàn toàn cả thể xác lẫn tâm hồn.', difficulty_level: 'basic' },
      { chinese: '人类应当树立尊重自然、顺应自然与保护大自然的生态文明理念，走人与自然和谐共生的可持续发展道路。', pinyin: 'Rénlèi yīngdāng shùlì zūnzhòng zìrán, shùnyìng zìrán yǔ bǎohù dàzìrán de shēngtài wénmíng lǐniàn, zǒu rén yǔ zìrán héxié-gòngshēng de kěchíxù fāzhǎn dàolù.', meaning_vi: 'Con người cần xác lập quan niệm văn minh sinh thái tôn trọng tự nhiên, hòa hợp với tự nhiên và bảo vệ mẹ thiên nhiên, đi trên con đường phát triển bền vững người và tự nhiên chung sống hòa hợp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '待',
    pinyin: 'dāi',
    word_type: 'Động từ',
    meaning_vi: 'ở lại, lưu lại',
    examples: [
      { chinese: '北京的秋天景色太迷人了，他打算在这里多待一个星期再回国。', pinyin: 'Běijīng de qiūtiān jǐngsè tài mírén le, tā dǎsuàn zài zhèlǐ duō dāi yí gè xīngqī zài huíguó.', meaning_vi: 'Cảnh thu Bắc Kinh mê hoặc quá, anh ấy dự định ở lại đây thêm một tuần rồi mới về nước.', difficulty_level: 'basic' },
      { chinese: '整日足不出户待在狭窄房间里盯着电子屏幕容易产生心理疲劳，建议多去户外亲近阳光。', pinyin: 'Zhěngrì zúbùchūhù dāi zài xiázhǎi fángjiān lǐ dīng zhe diànzǐ píngmù róngyì chǎnshēng xīnlǐ píláo, jiànyì duō qù hùwài qīnjìn yángguāng.', meaning_vi: 'Suốt ngày ru rú trong nhà ở lì trong căn phòng chật chội nhìn chằm chằm màn hình điện tử rất dễ gây mệt mỏi tâm lý, khuyên nên ra ngoài trời gần gũi với ánh nắng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '戴',
    pinyin: 'dài',
    word_type: 'Động từ',
    meaning_vi: 'đeo, đội, mang (mũ, kính, găng tay, đồng hồ, trang sức)',
    examples: [
      { chinese: '冬天早晨骑自行车出门时，一定要戴好保暖的手套和帽子。', pinyin: 'Dōngtiān zǎochén qí zìxíngchē chūmén shí, yídìng yào dài hǎo bǎonuǎn de shǒutào hé màozi.', meaning_vi: 'Mùa đông buổi sáng đạp xe ra ngoài, nhất định phải đeo găng tay và đội mũ giữ ấm chu đáo.', difficulty_level: 'basic' },
      { chinese: '进入建筑施工现场，所有人员均必须严格按照安全规范全程佩戴安全头盔。', pinyin: 'Jìnrù jiànzhù shīgōng xiànchǎng, suǒyǒu rényuán jūn bìxū yángé ànzhào ānquán guīfàn quánchéng pèidài ānquán tóukuī.', meaning_vi: 'Khi đi vào công trường thi công xây dựng, toàn bộ nhân sự đều phải đội mũ bảo hiểm trong suốt thời gian theo đúng quy chuẩn an toàn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '袋子',
    pinyin: 'dàizi',
    word_type: 'Danh từ',
    meaning_vi: 'túi, bao, bì',
    examples: [
      { chinese: '去超市买菜时自己携带环保布袋子，既实用又能减少白色塑料污染。', pinyin: 'Qù chāoshì mǎi cài shí zìjǐ xiédài huánbǎo bù dàizi, jì shíyòng yòu néng jiǎnshǎo báisè sùliào wūrǎn.', meaning_vi: 'Khi đi siêu thị mua thức ăn tự mình mang theo túi vải thân thiện môi trường, vừa tiện dụng vừa giảm ô nhiễm rác thải nhựa trắng.', difficulty_level: 'basic' },
      { chinese: '他手里提着两个沉甸甸的大袋子，里面装满了老家父母亲手采摘的新鲜特产土产。', pinyin: 'Tā shǒu lǐ tí zhe liǎng gè chéndiàndiàn de dà dàizi, lǐmiàn zhuāng mǎn le lǎojiā fùmǔ qīnshǒu cǎizhāi de xīnxiān tèsǎn tǔchǎn.', meaning_vi: 'Trên tay anh ấy xách hai chiếc túi to nặng trĩu, bên trong đựng đầy đặc sản tươi ngon do chính tay bố mẹ ở quê nhà hái gửi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '单位',
    pinyin: 'dānwèi',
    word_type: 'Danh từ',
    meaning_vi: 'đơn vị, cơ quan; đơn vị đo lường',
    examples: [
      { chinese: '他在一家外资商业银行单位从事财务审计工作。', pinyin: 'Tā zài yì jiā wàizī shāngyè yínháng dānwèi cóngshì cáiwù shěnjì gōngzuò.', meaning_vi: 'Anh ấy làm công việc kiểm toán tài chính tại một cơ quan ngân hàng thương mại vốn nước ngoài.', difficulty_level: 'basic' },
      { chinese: '国际标准化组织统一制定了全球通用的物理度量衡计算单位，确保了跨国科学研究与工业生产的无缝对接。', pinyin: 'Guójì biāozhǔnhuà zǔzhī tǒngyī zhìdìng le quánqiú tōngyòng de wùlǐ dùliànghéng jìsuàn dānwèi, quèbǎo le kuàguó kēxué yánjiū yǔ gōngyè shēngchǎn de wúféng duìjiē.', meaning_vi: 'Tổ chức Tiêu chuẩn hóa Quốc tế đã thống nhất đặt ra các đơn vị tính toán đo lường vật lý dùng chung toàn cầu, bảo đảm sự khớp nối hoàn hảo trong nghiên cứu khoa học và sản xuất công nghiệp xuyên quốc gia.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '当',
    pinyin: 'dāng',
    word_type: 'Động từ / Giới từ',
    meaning_vi: 'làm, đảm nhiệm; khi, vào lúc',
    examples: [
      { chinese: '当清晨的第一缕金色阳光洒满大地时，整座城市渐渐苏醒过来。', pinyin: 'Dāng qīngchén de dì-yī lǚ jīnsè yángguāng sǎ mǎn dàdì shí, zhěng zuò chéngshì jiànjiàn sūxǐng guòlái.', meaning_vi: 'Khi tia nắng vàng đầu tiên của sớm mai rải khắp mặt đất, toàn bộ thành phố dần dần thức giấc.', difficulty_level: 'basic' },
      { chinese: '她立志在大学毕业后回到家乡山区当一名乡村教师，为贫困山区的教育事业贡献青春力量。', pinyin: 'Tā lìzhì zài dàxué bìyè hòu huí dào jiāxiāng shānqū dāng yì míng xiāngcūn jiàoshī, wèi pínkùn shānqū de jiàoyù shìyè gòngxiàn qīngchūn lìliang.', meaning_vi: 'Cô ấy lập chí sau khi tốt nghiệp đại học sẽ trở về vùng núi quê hương làm một giáo viên làng, cống hiến sức trẻ cho sự nghiệp giáo dục vùng núi nghèo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '当时',
    pinyin: 'dāngshí',
    word_type: 'Danh từ',
    meaning_vi: 'lúc đó, khi đó, đương thời',
    examples: [
      { chinese: '事发当时路上光线昏暗，没有目击证人看清肇事车辆的车牌号码。', pinyin: 'Shìfā dāngshí lù shang guāngxiàn hūn’àn, méiyǒu mùjī zhèngrén kàn qīng zhàoshì chēliàng de chēpái hàomǎ.', meaning_vi: 'Khi sự việc xảy ra ánh sáng trên đường nhá nhem tối, không có nhân chứng nào nhìn rõ biển số của chiếc xe gây tai nạn.', difficulty_level: 'basic' },
      { chinese: '面对当时极端复杂的国际金融危机风暴，政府果断出台了一系列行之有效的稳就业扩内需宏观调控政策。', pinyin: 'Miànduì dāngshí jíduān fùzá de guójì jīnróng wēijī fēngbào, zhèngfǔ guǒduàn chūtái le yí xìliè xíngzhīyǒuxiào de wěn jiùyè kuò nèixū hóngguān tiáokòng zhèngcè.', meaning_vi: 'Đứng trước cơn bão khủng hoảng tài chính quốc tế cực kỳ phức tạp vào thời điểm đó, chính phủ đã kiên quyết ban hành một loạt chính sách điều tiết vĩ mô ổn định việc làm và mở rộng tiêu dùng nội địa rất hiệu quả.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '刀',
    pinyin: 'dāo',
    word_type: 'Danh từ',
    meaning_vi: 'con dao, dao',
    examples: [
      { chinese: '切水果时请注意拿稳水果刀，小心别割伤了手指。', pinyin: 'Qiē shuǐguǒ shí qǐng zhùyì ná wěn shuǐguǒ dāo, xiǎoxīn bié gēshāng le shǒuzhǐ.', meaning_vi: 'Khi gọt hoa quả xin chú ý cầm chắc con dao gọt, cẩn thận đừng để cắt vào ngón tay.', difficulty_level: 'basic' },
      { chinese: '一把做工锋利精良的手术刀，在外科专家沉着精湛的操作下挽救了无数患者的生命。', pinyin: 'Yì bǎ zuògōng fēnglì jīngliáng de shǒushù dāo, zài wàikē zhuānjiā chénzhuó jīngzhàn de cāozuò xià wǎnjiù le wúshù huànzhě de shēngmìng.', meaning_vi: 'Một con dao mổ sắc bén tinh xảo, dưới thao tác điềm tĩnh thuần thục của chuyên gia ngoại khoa đã cứu vớt sinh mệnh của vô số bệnh nhân.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '导游',
    pinyin: 'dǎoyóu',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'hướng dẫn viên du lịch; dẫn tour',
    examples: [
      { chinese: '这位经验丰富的地接导游生动有趣地为大家讲解了古长城的修筑历史。', pinyin: 'Zhè wèi jīngyàn fēngfù de dìjiē dǎoyóu shēngdòng yǒuqù de wèi dàjiā jiǎngjiě le gǔ Chángchéng de xiūzhù lìshǐ.', meaning_vi: 'Người hướng dẫn viên du lịch địa phương dày dặn kinh nghiệm này đã giảng giải về lịch sử xây dựng Vạn Lý Trường Thành cổ cho mọi người một cách sinh động thú vị.', difficulty_level: 'basic' },
      { chinese: '一名合格优秀的涉外国际导游不仅需要精通两门以上外语，更需要深谙中外文化风俗礼仪。', pinyin: 'Yì míng hégé yōuxiù de shèwài guójì dǎoyóu bùjǐn xūyào jīngtōng liǎng mén yǐshàng wàiyǔ, gèng xūyào shēn’ān zhōng-wài wénhuà fēngsú lǐyí.', meaning_vi: 'Một hướng dẫn viên quốc tế đạt chuẩn ưu tú không chỉ cần thông thạo từ hai ngoại ngữ trở lên, mà càng cần am hiểu sâu sắc phong tục tập quán lễ nghi văn hóa trong và ngoài nước.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '倒',
    pinyin: 'dào',
    word_type: 'Động từ',
    meaning_vi: 'rót (nước), đổ (rác); lùi (xe); đảo ngược',
    examples: [
      { chinese: '客人进屋后，主人热情地上前为他倒了一杯热气腾腾的乌龙茶。', pinyin: 'Kèrén jìn wū hòu, zhǔrén rèqíng de shàngqián wèi tā dào le yì bēi rèqì-téngténg de wūlóngchá.', meaning_vi: 'Sau khi khách vào nhà, chủ nhà nhiệt tình bước tới rót cho anh ấy một chén trà Ô Long nóng hổi.', difficulty_level: 'basic' },
      { chinese: '出门上班前请顺手把厨房门口分类好的生活垃圾倒进小区的指定分类回收箱。', pinyin: 'Chūmén shàngbān qián qǐng shùnshǒu bǎ chúfáng ménkǒu fēnlèi hǎo de shēnghuó lājī dào jìn xiǎoqū de zhǐdìng fēnlèi huíshōuxiāng.', meaning_vi: 'Trước khi ra ngoài đi làm xin thuận tay mang rác sinh hoạt đã phân loại ở cửa bếp đổ vào thùng thu gom phân loại chỉ định của khu dân cư.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '道',
    pinyin: 'dào',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'con đường, đạo lý; món (ăn), câu (hỏi), vệt (ánh sáng)',
    examples: [
      { chinese: '今天的期末考试试卷上一共有五道综合应用数学大题。', pinyin: 'Jīntiān de qīmò kǎoshì shìjuàn shang yígòng yǒu wǔ dào zōnghé yìngyòng shùxué dàtí.', meaning_vi: 'Trên đề thi học kỳ hôm nay tổng cộng có năm câu hỏi toán học ứng dụng tổng hợp lớn.', difficulty_level: 'basic' },
      { chinese: '这家具有百年传承历史的鲁菜老字号餐馆，每一道传统名菜都讲究选料精良与火候纯正。', pinyin: 'Zhè jiā jùyǒu bǎinián chuánchéng lìshǐ de Lǔcài lǎozìhào cānguǎn, měi yí dào chuántǒng míngcài dōu jiǎngjiu xuǎnliào jīngliáng yǔ huǒhou chúnzhèng.', meaning_vi: 'Quán ăn ẩm thực Sơn Đông danh tiếng lâu đời hàng trăm năm này, mỗi một món ăn truyền thống nổi tiếng đều chú trọng nguyên liệu tinh chọn và độ lửa chuẩn mực.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '到底',
    pinyin: 'dàodǐ',
    word_type: 'Phó từ',
    meaning_vi: 'rốt cuộc, suy cho cùng; đến cùng',
    examples: [
      { chinese: '大家讨论了这么久，到底哪一种解决实施方案更加稳妥可行？', pinyin: 'Dàjiā tǎolùn le zhème jiǔ, dàodǐ nǎ yì zhǒng jiějué shíshī fāng’àn gèngjiā wěntuǒ kěxíng?', meaning_vi: 'Mọi người đã thảo luận lâu như vậy, rốt cuộc phương án thực hiện giải quyết nào ổn thỏa khả thi hơn?', difficulty_level: 'basic' },
      { chinese: '在追求科学真理与学术卓越的崎岖道路上，只有坚持到底永不轻言放弃的人才能领略巅峰的无限风光。', pinyin: 'Zài zhuīqiú kēxué zhēnlǐ yǔ xuéshù zhuóyuè de qíqū dàolù shang, zhǐyào jiānchí dàodǐ yǒng bù qīngyán fàngqì de rén cái néng lǐnglüè diānfēng de wúxiàn fēngguāng.', meaning_vi: 'Trên con đường gập ghềnh theo đuổi chân lý khoa học và sự xuất sắc học thuật, chỉ người kiên trì đến cùng không bao giờ nói từ bỏ mới có thể chiêm ngưỡng phong cảnh vô tận nơi đỉnh cao.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '到来',
    pinyin: 'dàolái',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'đến, tới (thời điểm, sự kiện)',
    examples: [
      { chinese: '春天的到来让漫山遍野的大地重新换上了生机勃勃的绿装。', pinyin: 'Chūntiān de dàolái ràng mànshān-biànyě de dàdì chóngxīn huàn shàng le shēngjī-bóbó de lǜzhuāng.', meaning_vi: 'Mùa xuân tới khiến mặt đất khắp núi đồi bạt ngàn lại khoác lên mình chiếc áo xanh căng tràn sức sống.', difficulty_level: 'basic' },
      { chinese: '全校师生满怀喜悦与激动之情，在礼堂热烈欢迎远道而来的国际友好交流代表团。', pinyin: 'Quán xiào shīshēng mǎnhuái xǐyuè yǔ jīdòng zhī qíng, zài lǐtáng rèliè huānyíng yuǎndào’érlái de guójì yǒuhǎo jiāoliú dàibiǎotuán.', meaning_vi: 'Toàn thể thầy trò trong trường tràn ngập niềm vui và sự xúc động, nồng nhiệt chào đón đoàn đại biểu giao lưu hữu nghị quốc tế từ phương xa tới thăm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '道路',
    pinyin: 'dàolù',
    word_type: 'Danh từ',
    meaning_vi: 'con đường, tuyến đường, lộ trình',
    examples: [
      { chinese: '暴风雪过后，市政除雪工人正在全力以赴清理道路上的结冰积雪。', pinyin: 'Bàofēngxuě guòhòu, shìzhèng chúxuě gōngrén zhèngzài quánlì-yǐfù qīnglǐ dàolù shang de jiébīng jīxuě.', meaning_vi: 'Sau trận bão tuyết, các công nhân dọn tuyết của đô thị đang dốc toàn lực dọn dẹp băng đóng và tuyết đọng trên mặt đường.', difficulty_level: 'basic' },
      { chinese: '中国坚定不移地奉行独立自主的和平外交政策，坚定不移走和平发展道路。', pinyin: 'Zhōngguó jiāndìng-bùyí de fèngxíng dúlì-zìzhǔ de hépíng wàijiāo zhèngcè, jiāndìng-bùyí zǒu hépíng fāzhǎn dàolù.', meaning_vi: 'Trung Quốc kiên định không dời thực thi chính sách đối ngoại hòa bình độc lập tự chủ, kiên định không dời bước đi trên con đường phát triển hòa bình.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '道歉',
    pinyin: 'dàoqiàn',
    word_type: 'Động từ',
    meaning_vi: 'xin lỗi, tạ lỗi',
    examples: [
      { chinese: '他不小心打碎了借来的花瓶，连忙向房东诚恳地道歉。', pinyin: 'Tā bù xiǎoxīn dǎ suì le jiè lái de huāpíng, liánmáng xiàng fángdōng chéngkěn de dàoqiàn.', meaning_vi: 'Cậu ấy lỡ tay làm vỡ chiếc bình hoa mượn của chủ nhà, vội vàng xin lỗi chân thành.', difficulty_level: 'basic' },
      { chinese: '主动向因自身过失而受到伤害的人公开赔礼道歉，不仅需要真诚的勇气，更是成熟担当的体现。', pinyin: 'Zhǔdòng xiàng yīn zìshēn guòshī ér shòudào shānghài de rén gōngkāi péilǐ dàoqiàn, bùjǐn xūyào zhēnchéng de yǒngqì, gèng shì chéngshú dāndāng de tǐxiàn.', meaning_vi: 'Chủ động công khai tạ lỗi xin lỗi với người bị tổn thương bởi sai sót của bản thân không chỉ đòi hỏi sự dũng cảm chân thành mà càng là biểu hiện của tinh thần gánh vác trưởng thành.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '得意',
    pinyin: 'déyì',
    word_type: 'Tính từ',
    meaning_vi: 'đắc ý, đắc chí, tự hào',
    examples: [
      { chinese: '看到自己的画作在比赛中荣获一等奖，他脸上露出了得意的笑容。', pinyin: 'Kàn dào zìjǐ de huàzuò zài bǐsài zhōng rónghuò yīděngjiǎng, tā liǎn shang lù chū le déyì de xiàoróng.', meaning_vi: 'Nhìn thấy tác phẩm hội họa của mình vinh dự đoạt giải nhất trong cuộc thi, trên gương mặt cậu ấy nở nụ cười đắc ý.', difficulty_level: 'basic' },
      { chinese: '取得阶段性的优异成绩固然可喜，但切不可骄傲自满忘乎所以，洋洋得意往往容易导致后劲不足。', pinyin: 'Qǔdé jiēduànxìng de yōuyì chéngjì gùrán kěxǐ, dàn qiè bù kě jiāo’ào-zìmǎn wànghū-suǒyǐ, yángyáng-déyì wǎngwǎng róngyì dǎozhì hòujìn bùzú.', meaning_vi: 'Đạt được thành tích xuất sắc giai đoạn dẫu đáng mừng, nhưng tuyệt đối không được kiêu ngạo tự mãn quên hết tất cả, đắc ý vênh váo thường dễ dẫn đến hụt hơi về sau.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '登机',
    pinyin: 'dēngjī',
    word_type: 'Động từ',
    meaning_vi: 'lên máy bay',
    examples: [
      { chinese: '请飞往东京的乘客携带好随身行李前往第十二号登机口登机。', pinyin: 'Qǐng fēi wǎng Dōngjīng de chéngkè xiédài hǎo suíshēn xíngli qiánwǎng dì shí’èr hào dēngjīkǒu dēngjī.', meaning_vi: 'Xin các hành khách bay đi Tokyo mang theo hành lý xách tay tới cửa số 12 để lên máy bay.', difficulty_level: 'basic' },
      { chinese: '国际航班通常在起飞前半小时准时关闭登机口，请各位旅客合理规划好市内交通时间提前到达机场。', pinyin: 'Guójì hángbān tōngcháng zài qǐfēi qián bàn xiǎoshí zhǔnshí guānbì dēngjīkǒu, qǐng gèwèi lǚkè hélǐ guīhuà hǎo shìnèi jiāotōng shíjiān tíqián dàodá jīchǎng.', meaning_vi: 'Các chuyến bay quốc tế thông thường sẽ đóng cửa lên máy bay trước giờ cất cánh nửa tiếng, xin quý khách thu xếp giờ giấc đi lại trong thành phố hợp lý để tới sân bay sớm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '等',
    pinyin: 'děng',
    word_type: 'Trợ từ / Động từ',
    meaning_vi: 'vân vân (liệt kê); đợi, chờ',
    examples: [
      { chinese: '超市里陈列着苹果、香蕉、橙子、西瓜等各种新鲜应季水果。', pinyin: 'Chāoshì lǐ chénliè zhe píngguǒ, xiāngjiāo, chéngzi, xīguā děng gè zhǒng xīnxiān yìngjì shuǐguǒ.', meaning_vi: 'Trong siêu thị bày la liệt các loại hoa quả tươi đúng mùa như táo, chuối, cam, dưa hấu, v.v.', difficulty_level: 'basic' },
      { chinese: '该学术研讨会深入探讨了人工智能、大数据、云计算等前沿数字技术在未来智慧医疗领域的创新融合应用。', pinyin: 'Gāi xuéshù yántǎohuì shēnrù tàntǎo le réngōng zhìnéng, dàshùjù, yúnjìsuàn děng qiányán shùzì jìshù zài wèilái zhìhuì yīliáo lǐngyù de chuàngxīn rónghé yìngyòng.', meaning_vi: 'Hội thảo học thuật này đã đi sâu thảo luận về sự ứng dụng tích hợp đổi mới sáng tạo của các công nghệ số tiên phong như trí tuệ nhân tạo, dữ liệu lớn, điện toán đám mây v.v. trong lĩnh vực y tế thông minh tương lai.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '等到',
    pinyin: 'děngdào',
    word_type: 'Giới từ',
    meaning_vi: 'đợi đến khi, chờ tới lúc',
    examples: [
      { chinese: '等到今年暑假放假的时候，我一定要回老家看望亲爱的爷爷奶奶。', pinyin: 'Děngdào jīnnián shǔjià fàngjià de shíhou, wǒ yídìng yào huí lǎojiā kànwàng qīn’ài de yéye nǎinai.', meaning_vi: 'Chờ đến khi kỳ nghỉ hè năm nay bắt đầu, tôi nhất định sẽ về quê thăm ông bà nội kính yêu.', difficulty_level: 'basic' },
      { chinese: '不要总是把重要的事情无限期拖延，不要等到问题积重难返才追悔莫及。', pinyin: 'Bú yào zǒngshì bǎ zhòngyào de shìqing wúxiànqī tuōyán, bú yào děngdào wèntí jīzhòng-nánfǎn cái zhuīhuǐ-mòjí.', meaning_vi: 'Đừng bao giờ trì hoãn những công việc trọng đại vô thời hạn, đừng chờ đến lúc vấn đề chồng chất khó giải quyết mới hối hận khôn nguôi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '低',
    pinyin: 'dī',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'thấp; cúi, hạ thấp',
    examples: [
      { chinese: '由于这几天气温很低，外出时一定要多穿几件防寒外套。', pinyin: 'Yóuyú zhè jǐ tiān qìwēn hěn dī, wàichū shí yídìng yào duō chuān jǐ jiàn fánghán wàitào.', meaning_vi: 'Do nhiệt độ mấy ngày nay rất thấp, khi ra ngoài nhất định phải mặc thêm vài chiếc áo khoác ấm.', difficulty_level: 'basic' },
      { chinese: '听到老师当众指出自己的缺点与失误，他惭愧地低下了头，下定决心努力改正。', pinyin: 'Tīng dào lǎoshī dāngzhòng zhǐchū zìjǐ de quēdiǎn yǔ shīwù, tā cánkuì de dī xià le tóu, xiàdìng juéxīn nǔlì gǎizhèng.', meaning_vi: 'Nghe thầy giáo chỉ ra khuyết điểm và sai sót của mình trước lớp, cậu ấy xấu hổ cúi gằm đầu xuống, hạ quyết tâm cố gắng sửa đổi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '低价',
    pinyin: 'dījià',
    word_type: 'Danh từ',
    meaning_vi: 'giá thấp, giá rẻ',
    examples: [
      { chinese: '这家批发市场以低价薄利多销的经营模式吸引了成千上万的小商贩。', pinyin: 'Zhè jiā pīfā shìchǎng yǐ dījià bólì-duōxiāo de jīngyíng móshì xīyǐn le chéngqiān-shàngwàn de xiǎoshāngfàn.', meaning_vi: 'Khu chợ đầu mối bán buôn này thu hút hàng ngàn hàng vạn tiểu thương nhờ mô hình kinh doanh giá rẻ lấy lãi ít bán nhiều.', difficulty_level: 'basic' },
      { chinese: '消费者在网上选购低价促销电子数码产品时，应当格外警惕假冒伪劣以及翻新机陷阱。', pinyin: 'Xiāofèizhě zài wǎngshang xuǎngòu dījià cùxiāo diànzǐ shùmǎ chǎnpǐn shí, yīngdāng géwài jǐngtì jiǎmào-wěiliè yǐjí fānxīnjī xiànjǐng.', meaning_vi: 'Người tiêu dùng khi chọn mua các sản phẩm kỹ thuật số điện tử giá rẻ khuyến mãi trên mạng nên hết sức cảnh giác với hàng giả hàng nhái cũng như cạm bẫy máy tân trang lại.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '低温',
    pinyin: 'dīwēn',
    word_type: 'Danh từ',
    meaning_vi: 'nhiệt độ thấp, nhiệt độ giá lạnh',
    examples: [
      { chinese: '北方地区入冬之后经常遭遇连续多天的零下极度低温严寒天气。', pinyin: 'Běifāng dìqū rù dōng zhīhòu jīngcháng zāoyù liánxù duō tiān de língxià jídù dīwēn yánhán tiānqì.', meaning_vi: 'Khu vực miền Bắc sau khi vào đông thường gặp phải thời tiết giá rét nhiệt độ cực thấp dưới 0 độ kéo dài nhiều ngày.', difficulty_level: 'basic' },
      { chinese: '这批生物医用疫苗在长途运输和仓储保管过程中，必须全程放置于零下七十度的特种低温冷链环境中。', pinyin: 'Zhè pī shēngwù yīyòng yìmiáo zài chángtú yùnshū hé cāngchǔ bǎoguǎn guòchéng zhōng, bìxū quánchéng fàngzhì yú língxià qīshí dù de tèzhǒng dīwēn lěngliàn huánjìng zhōng.', meaning_vi: 'Lô vắc xin y sinh này trong quá trình vận chuyển đường dài và lưu kho bảo quản bắt buộc phải đặt trong môi trường chuỗi lạnh nhiệt độ thấp đặc chủng âm bảy mươi độ C.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '低于',
    pinyin: 'dīyú',
    word_type: 'Động từ',
    meaning_vi: 'thấp hơn, dưới',
    examples: [
      { chinese: '今天夜间市区的最低气温预计将低于零摄氏度。', pinyin: 'Jīntiān yèjiān shìqū de zuìdī qìwēn yùjì jiāng dīyú líng shèshìdù.', meaning_vi: 'Dự báo nhiệt độ thấp nhất trong nội thành đêm nay sẽ xuống dưới không độ C.', difficulty_level: 'basic' },
      { chinese: '凡是考试综合总成绩低于及格基准线的考生，必须参加下学期初统一组织的重考补考。', pinyin: 'Fánshì kǎoshì zōnghé zǒng chéngjì dīyú jígé jīzhǔnxiàn de kǎoshēng, bìxū cānjiā xià xuéqī chū tǒngyī zǔzhī de chóngkǎo bǔkǎo.', meaning_vi: 'Hễ thí sinh nào có tổng điểm thi tổng hợp dưới điểm chuẩn đạt yêu cầu đều bắt buộc phải tham gia kỳ thi lại tổ chức tập trung vào đầu học kỳ sau.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '底',
    pinyin: 'dǐ',
    word_type: 'Danh từ',
    meaning_vi: 'đáy, phần dưới, cuối (tháng, năm)',
    examples: [
      { chinese: '清澈见底的湖水里，一群群五彩斑斓的小鱼正在欢快地游来游去。', pinyin: 'Qīngchè jiàn dǐ de húshuǐ lǐ, yì qúnqún wǔcǎi-bānlán de xiǎoyú zhèngzài huānkuài de yóulái-yóuqù.', meaning_vi: 'Trong làn nước hồ trong vắt nhìn thấu tận đáy, từng đàn cá nhỏ sặc sỡ sắc màu đang vui vẻ bơi qua bơi lại.', difficulty_level: 'basic' },
      { chinese: '每到接近年底的收尾阶段，公司财务部门都要连夜加班对全年的账目进行系统结算审计。', pinyin: 'Měi dào jiējìn niándǐ de shōuwěi jiēduàn, gōngsī cáiwù bùmén dōu yào liányè jiābān duì quán nián de zhàngmù jìnxíng xìtǒng jiésuàn shěnjì.', meaning_vi: 'Mỗi khi tới giai đoạn chốt sổ cuối năm, phòng tài chính công ty đều phải tăng ca thâu đêm để quyết toán kiểm toán có hệ thống các sổ sách cả năm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '底下',
    pinyin: 'dǐxia',
    word_type: 'Danh từ',
    meaning_vi: 'dưới, bên dưới, phía dưới',
    examples: [
      { chinese: '可爱的小花猫正蜷缩在客厅的木桌底下香甜地打瞌睡。', pinyin: 'Kě’ài de xiǎohuāmāo zhèng quánsuō zài kètīng de mùzhuō dǐxia xiāngtián de dǎkēshuì.', meaning_vi: 'Chú mèo hoa đáng yêu đang cuộn tròn dưới gầm bàn gỗ phòng khách ngủ gật ngon lành.', difficulty_level: 'basic' },
      { chinese: '烈日当空的中午，工人们坐在高大浓密的绿树底下乘凉避暑，畅谈着家长里短。', pinyin: 'Lièrì dāngkōng de zhōngwǔ, gōngrénmen zuò zài gāodà nóngmì de lǜshù dǐxia chéngliáng bìshǔ, chàngtán zhe jiācháng-lǐduǎn.', meaning_vi: 'Buổi trưa nắng gắt chang chang trên đầu, các công nhân ngồi dưới tán cây xanh rợp bóng mát mẻ hóng gió tránh nóng, rôm rả trò chuyện chuyện nhà chuyện cửa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '地球',
    pinyin: 'dìqiú',
    word_type: 'Danh từ',
    meaning_vi: 'Trái Đất, địa cầu',
    examples: [
      { chinese: '地球是目前已知全宇宙中唯一孕育着丰富智慧生命的蓝色星球。', pinyin: 'Dìqiú shì mùqián yǐzhī quán yǔzhòu zhōng wéiyī yùnyù zhe fēngfù zhìhuì shēngmìng de lánsè xīngqiú.', meaning_vi: 'Trái Đất là hành tinh xanh duy nhất nuôi dưỡng sự sống thông minh phong phú trong toàn vũ trụ được biết tới hiện nay.', difficulty_level: 'basic' },
      { chinese: '保护地球生态平衡是关乎人类文明兴衰存亡的宏伟伟业，需要全世界各国携手同舟共济。', pinyin: 'Bǎohù dìqiú shēngtài pínghéng shì guānhū rénlèi wénmíng xīngshuāi cúnwáng de hóngwěi wěiyè, xūyào quán shìjiè gè guó xiéshǒu tóngzhōu-gòngjì.', meaning_vi: 'Bảo vệ cân bằng sinh thái Trái Đất là sự nghiệp vĩ đại liên quan tới sự hưng vong mất còn của văn minh nhân loại, đòi hỏi các quốc gia trên toàn thế giới cùng chung tay đồng cam cộng khổ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '地址',
    pinyin: 'dìzhǐ',
    word_type: 'Danh từ',
    meaning_vi: 'địa chỉ',
    examples: [
      { chinese: '请把您接收快递包裹的详细家庭住址发送给我。', pinyin: 'Qǐng bǎ nín jiēshōu kuàidì bāoguǒ de xiángxì jiātíng zhùzhǐ fāsòng gěi wǒ.', meaning_vi: 'Xin hãy gửi địa chỉ nhà ở chi tiết để nhận bưu kiện chuyển phát nhanh cho tôi.', difficulty_level: 'basic' },
      { chinese: '在电商平台提交网购订单结算之前，务必仔细核对收件人姓名、联系电话以及送货具体地址。', pinyin: 'Zài diànshāng píngtái tíjiāo wǎnggòu dìngdān jiésuàn zhīqián, wùbì zǐxì héduì shōujiànrén xìngmíng, liánxì diànhuà yǐjí sònghuò jùtǐ dìzhǐ.', meaning_vi: 'Trước khi gửi đơn đặt hàng mua sắm qua mạng trên sàn thương mại điện tử để thanh toán, nhất thiết phải đối soát kỹ tên người nhận, số điện thoại liên hệ và địa chỉ giao hàng cụ thể.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '点名',
    pinyin: 'diǎnmíng',
    word_type: 'Động từ',
    meaning_vi: 'điểm danh; gọi tên đích danh',
    examples: [
      { chinese: '上课铃声响起后，任课老师开始按照学生花名册逐一点名。', pinyin: 'Shàngkè língshēng xiǎngqǐ hòu, rènkè lǎoshī kāishǐ ànzhào xuésheng huāmíngcè zhúyī diǎnmíng.', meaning_vi: 'Sau khi chuông vào lớp vang lên, thầy giáo phụ trách bắt đầu điểm danh từng người một theo danh sách học sinh.', difficulty_level: 'basic' },
      { chinese: '大型早会准时开始前，各部门负责人逐一核对员工到岗出勤情况并进行考勤点名。', pinyin: 'Dàxíng zǎohuì zhǔnshí kāishǐ qián, gè bùmén fùzérén zhúyī héduì yuángōng dàogǎng chūqín qíngkuàng bìng jìnxíng kǎoqín diǎnmíng.', meaning_vi: 'Trước khi cuộc họp giao ban sáng lớn bắt đầu đúng giờ, người phụ trách các bộ phận lần lượt kiểm tra tình hình nhân viên có mặt đi làm và tiến hành điểm danh chấm công.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '点头',
    pinyin: 'diǎntóu',
    word_type: 'Động từ',
    meaning_vi: 'gật đầu',
    examples: [
      { chinese: '听完我的建议后，他微笑着用力点了点头表示赞同。', pinyin: 'Tīng wán wǒ de jiànyì hòu, tā wēixiào zhe yònglì diǎn le diǎn tóu biǎoshì zàntóng.', meaning_vi: 'Nghe xong đề xuất của tôi, anh ấy mỉm cười gật gật đầu mạnh mẽ tỏ ý tán thành.', difficulty_level: 'basic' },
      { chinese: '在许多跨文化商务交流场合中，恰到好处的微笑与点头致意能够迅速化解彼此初次相识的尴尬。', pinyin: 'Zài xǔduō kuà-wénhuà shāngwù jiāoliú chǎnghé zhōng, qiàdàohǎochù de wēixiào yǔ diǎntóu zhìyì nénggòu xùnsù huàjiě bǐcǐ chūcì xiāngshí de gāngà.', meaning_vi: 'Trong nhiều hoàn cảnh giao tiếp thương mại xuyên văn hóa, nụ cười và cái gật đầu chào đúng mực có thể nhanh chóng xua tan sự ngượng ngùng khi lần đầu gặp gỡ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '电动车',
    pinyin: 'diàndòngchē',
    word_type: 'Danh từ',
    meaning_vi: 'xe đạp điện, xe máy điện, xe điện',
    examples: [
      { chinese: '他每天骑着小巧轻便的电动车穿梭于大街小巷上下班。', pinyin: 'Tā měitiān qí zhe xiǎoqiǎo qīngbiàn de diàndòngchē chuānsuō yú dàjiē-xiǎoxiàng shàng-xiàbān.', meaning_vi: 'Hàng ngày anh ấy đi chiếc xe điện nhỏ nhắn nhẹ nhàng luồn lách qua các phố lớn ngõ nhỏ đi làm.', difficulty_level: 'basic' },
      { chinese: '随着绿色低碳出行理念深入人心，以清洁电能为动力的两轮电动车已经成为市民短途通勤的主力工具。', pinyin: 'Suízhe lǜsè dītàn chūxíng lǐniàn shēnrù-rénxīn, yǐ qīngjié diànnéng wéi dònglì de liǎnglún diàndòngchē yǐjīng chéngwéi shìmín duǎntú tōngqín de zhǔlì gōngjù.', meaning_vi: 'Khi quan niệm đi lại xanh phát thải thấp thấm sâu vào lòng người, xe điện hai bánh chạy bằng điện năng sạch đã trở thành công cụ chủ lực đi lại cự ly ngắn của người dân.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '电视剧',
    pinyin: 'diànshìjù',
    word_type: 'Danh từ',
    meaning_vi: 'phim truyền hình, phim bộ',
    examples: [
      { chinese: '晚饭后一家人围坐在客厅电视机前看精彩的电视剧。', pinyin: 'Wǎnfàn hòu yì jiā rén wéizuò zài kètīng diànshìjī qián kàn jīngcǎi de diànshìjù.', meaning_vi: 'Sau bữa tối cả nhà quây quần ngồi trước chiếc ti vi phòng khách xem bộ phim truyền hình hấp dẫn.', difficulty_level: 'basic' },
      { chinese: '这部改编自同名畅销历史小说的长篇历史题材电视剧，剧情跌宕起伏，自开播以来收视率一路领跑。', pinyin: 'Zhè bù gǎibiān zì tóngmíng chàngxiāo lìshǐ xiǎoshuō de chángpiān lìshǐ tícái diànshìjù, jùqíng diēdàng-qǐfú, zì kāibō yǐlái shōushìlǜ yílù lǐngpǎo.', meaning_vi: 'Bộ phim truyền hình dài tập đề tài lịch sử được chuyển thể từ tiểu thuyết lịch sử ăn khách cùng tên này có cốt truyện thăng trầm lôi cuốn, kể từ khi phát sóng tỷ suất người xem luôn dẫn đầu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '掉',
    pinyin: 'diào',
    word_type: 'Động từ',
    meaning_vi: 'rơi, rớt; mất, tụt',
    examples: [
      { chinese: '秋风吹过，枯黄的树叶纷纷从枝头掉落下来。', pinyin: 'Qiūfēng chuī guò, kūhuáng de shùyè fēnfēn cóng zhītóu diàoluò xiàlái.', meaning_vi: 'Gió thu thổi qua, những chiếc lá vàng úa lần lượt từ trên cành cây rơi rụng xuống.', difficulty_level: 'basic' },
      { chinese: '由于平时忙于日常琐碎应酬而疏忽了系统复习，他的综合测试排名一下子掉了好几名。', pinyin: 'Yóuyú píngshí mángyú rìcháng suǒsuì yìngchóu ér shūhū le xìtǒng fùxí, tā de zōnghé cèshì páimíng yíxiàzi diào le hǎo jǐ míng.', meaning_vi: 'Do ngày thường bận rộn tiệc tùng tiếp khách vụn vặt mà lơ là việc ôn tập có hệ thống, thứ hạng kiểm tra tổng hợp của cậu ấy bỗng chốc tụt mất mấy bậc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '调查',
    pinyin: 'diàochá',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'điều tra, khảo sát; cuộc điều tra',
    examples: [
      { chinese: '市场研究团队正在针对消费者的购买习惯开展问卷调查。', pinyin: 'Shìchǎng yánjiū tuánduì zhèngzài zhēnduì xiāofèizhě de gòumǎi xíguàn kāizhǎn wènjuàn diàochá.', meaning_vi: 'Nhóm nghiên cứu thị trường đang triển khai cuộc khảo sát bằng bảng hỏi hướng tới thói quen mua sắm của người tiêu dùng.', difficulty_level: 'basic' },
      { chinese: '深入基层开展实事求是的实地调查研究，是制定切实可行宏观决策的重要先决前提。', pinyin: 'Shēnrù jīcéng kāizhǎn shíshìqiúshì de shídì diàochá yánjiū, shì zhìdìng qièshí kěxíng hóngguān juécè de zhòngyào xiānjué qiántí.', meaning_vi: 'Đi sâu xuống cơ sở triển khai điều tra nghiên cứu thực địa cầu thị là tiền đề tiên quyết trọng đại để hoạch định các quyết sách vĩ mô thiết thực khả thi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '订',
    pinyin: 'dìng',
    word_type: 'Động từ',
    meaning_vi: 'đặt trước (vé, phòng, hàng hóa)',
    examples: [
      { chinese: '我们已经提前在网上订好了下周去三亚度假的双人往返机票。', pinyin: 'Wǒmen yǐjīng tíqián zài wǎngshang dìng hǎo le xià zhōu qù Sānyà dùjià de shuāngrén wǎngfǎn jīpiào.', meaning_vi: 'Chúng tôi đã đặt trước trên mạng vé máy bay khứ hồi đôi đi Tam Á nghỉ mát tuần tới.', difficulty_level: 'basic' },
      { chinese: '黄金周旅游旺季来临之前，各大热门风景名胜区周边的高品质精品民宿早已被游客预订一空。', pinyin: 'Huángjīnzhōu lǚyóu wàngjì láilín zhīqián, gè dà rèmén fēngjǐng míngshèngqū zhōubiān de gāo pǐnzhì jīngpǐn mínsù zǎoyǐ bèi yóukè yùdìng yì kōng.', meaning_vi: 'Trước khi mùa cao điểm du lịch tuần lễ vàng tới, các homestay cao cấp tinh chọn quanh các danh lam thắng cảnh đắt khách từ lâu đã được du khách đặt trước sạch trơn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '定',
    pinyin: 'dìng',
    word_type: 'Động từ',
    meaning_vi: 'ấn định, quyết định, quy định',
    examples: [
      { chinese: '双方商定于下周三上午在公司会议室正式签署战略合作协议。', pinyin: 'Shuāngfāng shāngdìng yú xià zhōusān shàngwǔ zài gōngsī huìyìshì zhèngshì qiānshǔ zhànlüè hézuò xiéyì.', meaning_vi: 'Hai bên thỏa thuận ấn định sáng thứ Tư tuần sau sẽ chính thức ký kết thỏa thuận hợp tác chiến lược tại phòng họp công ty.', difficulty_level: 'basic' },
      { chinese: '面对突如其来的危机变故，领导者必须保持沉着定力，果断定夺整体处置大局。', pinyin: 'Miànduì tūrúqílái de wēijī biàngù, lǐngdǎozhě bìxū bǎochí chénzhuó dìnglì, guǒduàn dìngduó zhěngtǐ chǔzhì dàjú.', meaning_vi: 'Đứng trước biến cố khủng hoảng bất ngờ, người lãnh đạo phải giữ được định lực điềm tĩnh, quyết đoán định đoạt đại cục xử lý toàn diện.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '东部',
    pinyin: 'dōngbù',
    word_type: 'Danh từ',
    meaning_vi: 'miền đông, phía đông',
    examples: [
      { chinese: '中国东部沿海地区经济繁荣发达，对外贸易往来极其活跃。', pinyin: 'Zhōngguó dōngbù yánhǎi dìqū jīngjì fánróng fādá, duìwài màoyì wǎnglái jíqí huóyuè.', meaning_vi: 'Khu vực ven biển miền đông Trung Quốc kinh tế phồn vinh phát triển, giao thương ngoại thương vô cùng sôi động.', difficulty_level: 'basic' },
      { chinese: '随着东西部协作战略的深度推进，东部沿海发达省份向西部地区源源不断输送了大量优势产业与技术人才。', pinyin: 'Suízhe dōng-xībù xiézuò zhànlüè de shēndù tuījìn, dōngbù yánhǎi fādá shěngfèn xiàng xībù dìqū yuányuán-bùduàn shūsòng le dàliàng yōushì chǎnyè yǔ jìshù réncái.', meaning_vi: 'Cùng với sự thúc đẩy sâu rộng chiến lược phối hợp đông - tây, các tỉnh phát triển ven biển miền đông không ngừng truyền tải khối lượng lớn các ngành công nghiệp mũi nhọn và nhân tài kỹ thuật tới vùng miền tây.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '动车',
    pinyin: 'dòngchē',
    word_type: 'Danh từ',
    meaning_vi: 'tàu động lực phân tán (tàu cao tốc loại D)',
    examples: [
      { chinese: '为了节省出行预算，我们选择乘坐舒适快捷的动车二等座前往目的地。', pinyin: 'Wèile jiéshěng chūxíng yùsuàn, wǒmen xuǎnzé chéngzuò shūshì kuàijié de dòngchē èrděngzuò qiánwǎng mùdìdì.', meaning_vi: 'Nhằm tiết kiệm ngân sách đi lại, chúng tôi chọn đi ghế hạng hai của tàu cao tốc dòng D êm ái nhanh chóng tới điểm đến.', difficulty_level: 'basic' },
      { chinese: '密集的城际动车公交化高频次开行，极大地推动了省会与周边卫星城市之间半小时同城生活圈的形成。', pinyin: 'Mìmí de chéngjì dòngchē gōngjiāohuà gāopíncì kāixíng, jídà de tuīdòng le shěnghuì yǔ zhōubiān wèixīng chéngshì zhījiān bàn xiǎoshí tóngchéng shēnghuóquān de xíngchéng.', meaning_vi: 'Các đoàn tàu động lực liên tỉnh vận hành dày đặc tần suất cao như xe buýt đã thúc đẩy mạnh mẽ sự hình thành vòng tròn sinh hoạt cùng thành phố nửa tiếng giữa thủ phủ tỉnh và các đô thị vệ tinh xung quanh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '动作',
    pinyin: 'dòngzuò',
    word_type: 'Danh từ',
    meaning_vi: 'động tác, hành động',
    examples: [
      { chinese: '太极拳的每个动作都讲究行云流水、刚柔并济。', pinyin: 'Tàijíquán de měi gè dòngzuò dōu jiǎngjiu xíngyún-liúshuǐ, gāngróu-bìngjì.', meaning_vi: 'Mỗi một động tác của Thái Cực Quyền đều chú trọng mượt mà uyển chuyển, cương nhu kết hợp hài hòa.', difficulty_level: 'basic' },
      { chinese: '这位功夫演员在动作电影中完成了一系列令人叹为观止的高难度特技飞跃动作。', pinyin: 'Zhè wèi gōngfu yǎnyuán zài dòngzuò diànyǐng zhōng wánchéng le yí xìliè lìng rén tànwéiguānzhǐ de gāo nándù tèjì fēiyuè dòngzuò.', meaning_vi: 'Diễn viên võ thuật này đã hoàn thành một loạt động tác bay nhảy nhào lộn kỹ xảo độ khó cao khiến người xem phải trầm trồ thán phục trong phim hành động.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '读者',
    pinyin: 'dúzhě',
    word_type: 'Danh từ',
    meaning_vi: 'độc giả, bạn đọc',
    examples: [
      { chinese: '这本书自出版以来深受广大青年读者的热烈好评与喜爱。', pinyin: 'Zhè běn shū zì chūbǎn yǐlái shēn shòu guǎngdà qīngnián dúzhě de rèliè hǎopíng yǔ xǐ’ài.', meaning_vi: 'Cuốn sách này kể từ khi xuất bản tới nay nhận được sự đánh giá tích cực nồng nhiệt và yêu quý sâu sắc của đông đảo bạn đọc trẻ.', difficulty_level: 'basic' },
      { chinese: '知名作家在新书首发签售会上与来自全国各地的热心读者进行了面对面的深入互动交流。', pinyin: 'Zhīmíng zuòjiā zài xīn shū shǒufā qiānshòuhuì shang yǔ láizì quán guó gè dì de rèxīn dúzhě jìnxíng le miànduìmiàn de shēnrù hùdòng jiāoliú.', meaning_vi: 'Nhà văn tên tuổi trong buổi ký tặng ra mắt sách mới đã có buổi giao lưu tương tác sâu rộng trực tiếp mặt đối mặt với các độc giả nhiệt thành đến từ mọi miền đất nước.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '堵车',
    pinyin: 'dǔchē',
    word_type: 'Động từ',
    meaning_vi: 'tắc đường, kẹt xe',
    examples: [
      { chinese: '遇到周一早高峰严重堵车，许多上班族纷纷选择改乘地下铁道。', pinyin: 'Yù dào zhōuyī zǎogāofēng yánzhòng dǔchē, xǔduō shàngbānzú fēnfēn xuǎnzé gǎi chéng dìxià tiědào.', meaning_vi: 'Gặp kẹt xe nghiêm trọng vào giờ cao điểm sáng thứ Hai, nhiều dân công sở đồng loạt chọn chuyển sang đi tàu điện ngầm.', difficulty_level: 'basic' },
      { chinese: '为了有效缓解主干道在节假日进出城高峰时段的堵车拥堵顽疾，交管部门制定了精细化的分流引流应急预案。', pinyin: 'Wèile yǒuxiào huǎnjiě zhǔgàndào zài jiéjiàrì jìn-chū chéng gāofēng shíduàn de dǔchē yōngdǔ wánjí, jiāoguǎn bùmén zhìdìng le jīngxìhuà de fēnliú yǐnliú yīngjí yù’àn.', meaning_vi: 'Nhằm giải quyết hiệu quả căn bệnh trầm kha tắc đường ùn ứ trên các trục đường huyết mạch vào giờ cao điểm ra vào thành phố dịp lễ tết, lực lượng quản lý giao thông đã lập phương án khẩn cấp phân luồng chi tiết.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '度假',
    pinyin: 'dùjià',
    word_type: 'Động từ',
    meaning_vi: 'đi nghỉ mát, đi nghỉ dưỡng',
    examples: [
      { chinese: '我们一家人打算趁着暑假前往云南丽江古城度假两周。', pinyin: 'Wǒmen yì jiā rén dǎsuàn chèn zhe shǔjià qiánwǎng Yúnnán Lìjiāng gǔchéng dùjià liǎng zhōu.', meaning_vi: 'Gia đình chúng tôi dự định nhân dịp nghỉ hè sẽ tới cổ thành Lệ Giang tỉnh Vân Nam nghỉ mát hai tuần.', difficulty_level: 'basic' },
      { chinese: '随着大众健康休闲理念的升级，越来越多都市白领热衷于前往生态森林氧吧度假，远离职场疲惫。', pinyin: 'Suízhe dàzhòng jiànkāng xiūxián lǐniàn de shēngjí, yuè lái yuè duō dūshì báilǐng rèzhōng yú qiánwǎng shēngtài sēnlín yǎngba dùjià, yuǎnlí zhíchǎng píbèi.', meaning_vi: 'Cùng với sự nâng tầm quan niệm thư giãn sức khỏe của đại chúng, ngày càng nhiều nhân viên văn phòng thành thị chuộng đi nghỉ dưỡng tại các "quán oxy" rừng sinh thái, tránh xa nỗi mệt mỏi chốn công sở.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '肚子',
    pinyin: 'dùzi',
    word_type: 'Danh từ',
    meaning_vi: 'bụng',
    examples: [
      { chinese: '他可能吃了不干净的街头小吃，下午肚子一直隐隐作痛。', pinyin: 'Tā kěnéng chī le bù gānjìng de jiētóu xiǎochī, xiàwǔ dùzi yìzhí yǐnyǐn-zuòtòng.', meaning_vi: 'Cậu ấy có thể đã ăn phải đồ ăn vặt vỉa hè không sạch sẽ, buổi chiều bụng cứ đau âm ỉ suốt.', difficulty_level: 'basic' },
      { chinese: '听了他讲的那段滑稽风趣的小品包袱，全场观众都笑得前仰后合、肚子发疼。', pinyin: 'Tīng le tā jiǎng de nà duàn huájī fēngqù de xiǎopǐn bāofu, quánchǎng guānzhòng dōu xiào de qiányǎng-hòuhé, dùzi fā téng.', meaning_vi: 'Nghe xong mảng miếng hài hước hóm hỉnh trong tiểu phẩm của anh ấy, toàn bộ khán giả trong khán phòng đều cười nghiêng ngả, đau cả ruột.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '短信',
    pinyin: 'duǎnxìn',
    word_type: 'Danh từ',
    meaning_vi: 'tin nhắn (SMS)',
    examples: [
      { chinese: '你收到银行发送过来的网上支付验证码短信了吗？', pinyin: 'Nǐ shōudào yínháng fāsòng guòlái de wǎngshang zhīfù yànzhèngmǎ duǎnxìn le ma?', meaning_vi: 'Bạn đã nhận được tin nhắn SMS mã xác thực thanh toán trực tuyến do ngân hàng gửi tới chưa?', difficulty_level: 'basic' },
      { chinese: '尽管各类即时通讯社交软件日益普及，但政务通知与金融安全验证短信依然扮演着不可替代的角色。', pinyin: 'Jǐnguǎn gè lèi jíshí tōngxùn shèjiāo ruǎnjiàn rìyì pǔjí, dàn zhèngwù tōngzhī yǔ jīnróng ānquán yànzhèng duǎnxìn yīrán bànyǎn zhe bù kě tìdài de juésè.', meaning_vi: 'Dù các loại phần mềm mạng xã hội nhắn tin tức thì ngày càng phổ biến, tin nhắn SMS thông báo dịch vụ công và xác thực an toàn tài chính vẫn giữ vai trò không thể thay thế.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '队',
    pinyin: 'duì',
    word_type: 'Danh từ',
    meaning_vi: 'đội, hàng',
    examples: [
      { chinese: '请买票的游客自觉在检票口外排成一队依次进场。', pinyin: 'Qǐng mǎi piào de yóukè zìjué zài jiǎnpiàokǒu wài pái chéng yí duì yīcì jìnchǎng.', meaning_vi: 'Xin các du khách mua vé tự giác xếp thành một hàng bên ngoài cửa soát vé để lần lượt vào rạp.', difficulty_level: 'basic' },
      { chinese: '一支具备强大战斗力与坚定信念的优秀科研攻坚队，总能在核心关键技术卡脖子领域取得重大突破。', pinyin: 'Yì zhī jùbèi qiángdà zhàndòulì yǔ jiāndìng xìnniàn de yōuxiù kēyán gōngjiānduì, zǒng néng zài héxīn guānjiàn jìshù qiǎbózi lǐngyù qǔdé zhòngdà tūpò.', meaning_vi: 'Một đội ngũ mũi nhọn nghiên cứu khoa học xuất sắc sở hữu sức chiến đấu mạnh mẽ và niềm tin kiên định luôn có thể tạo nên đột phá trọng đại tại các lĩnh vực công nghệ then chốt bị nghẽn cổ chai.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '对方',
    pinyin: 'duìfāng',
    word_type: 'Danh từ',
    meaning_vi: 'đối phương, bên kia',
    examples: [
      { chinese: '在商务谈判过程中，我们应当耐心倾听对方提出的合理诉求。', pinyin: 'Zài shāngwù tánpàn guòchéng zhōng, wǒmen yīngdāng nàixīn qīngtīng duìfāng tíchū de hélǐ sùqiú.', meaning_vi: 'Trong quá trình đàm phán thương mại, chúng ta nên kiên nhẫn lắng nghe những nguyện vọng yêu cầu hợp lý do đối phương đưa ra.', difficulty_level: 'basic' },
      { chinese: '无论发生何种分歧摩擦，唯有站在对方的角度设身处地换位思考，才能真正化解心结达成共赢。', pinyin: 'Wúlùn fāshēng hé zhǒng fēnqí mócā, wéiyǒu zhàn zài duìfāng de jiǎodù shèshēnchǔdì huànwèi sīkǎo, cái néng zhēnzhèng huàjiě xīnjié dáchéng gòngyíng.', meaning_vi: 'Cho dù xảy ra bất đồng va chạm gì, chỉ khi đứng trên góc độ của đối phương đặt mình vào vị trí người khác suy ngẫm mới có thể thực sự cởi bỏ nút thắt trong lòng để đạt tới cùng thắng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '对面',
    pinyin: 'duìmiàn',
    word_type: 'Danh từ',
    meaning_vi: 'đối diện, phía đối diện',
    examples: [
      { chinese: '马路对面新开了一家环境优雅的书店兼咖啡馆。', pinyin: 'Mǎlù duìmiàn xīn kāi le yì jiā huánjìng yōuyǎ de shūdiàn jiān kāfēiguǎn.', meaning_vi: 'Đối diện bên kia đường mới mở một tiệm sách kết hợp quán cà phê không gian thanh nhã.', difficulty_level: 'basic' },
      { chinese: '我们就坐在彼此对面静静品味着香浓的热茶，窗外车水马龙的繁华闹市丝毫不影响屋内的宁静祥和。', pinyin: 'Wǒmen jiù zuò zài bǐcǐ duìmiàn jìngjìng pǐnwèi zhe xiāngnóng de rè chá, chuāngwài chēshuǐ-mǎlóng de fánhuá nàoshì sīháo bù yǐngxiǎng wū nèi de níngjìng xiánghé.', meaning_vi: 'Chúng tôi ngồi đối diện nhau lặng lẽ thưởng thức tách trà nóng thơm nồng, phố thị phồn hoa xe cộ tấp nập ngoài cửa sổ mảy may không làm xáo trộn vẻ thanh bình an yên bên trong căn phòng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '对于',
    pinyin: 'duìyú',
    word_type: 'Giới từ',
    meaning_vi: 'đối với, về phần',
    examples: [
      { chinese: '对于初学中文的外国朋友来说，准确掌握汉字的声调至关重要。', pinyin: 'Duìyú chūxué Zhōngwén de wàiguó péngyou lái shuō, zhǔnquè zhǎngwò Hànzì de shēngdiào zhìguān zhòngyào.', meaning_vi: 'Đối với những người bạn nước ngoài mới học tiếng Trung, nắm vững chuẩn xác thanh điệu chữ Hán là vô cùng then chốt.', difficulty_level: 'basic' },
      { chinese: '对于企业而言，持续的技术创新与诚信立业的良好口碑是其在市场惊涛骇浪中基业长青的立身之本。', pinyin: 'Duìyú qǐyè éryán, chíxù de jìshù chuàngxīn yǔ chéngxìn lìyè de liánghǎo kǒubēi shì qí zài shìchǎng jīngtāo-hàilàng zhōng jīyè-chángqīng de lìshēn zhī běn.', meaning_vi: 'Đối với doanh nghiệp mà nói, đổi mới công nghệ liên tục và uy tín tiếng lành lập nghiệp bằng chữ tín là gốc rễ giữ vững sự trường tồn của cơ nghiệp giữa sóng to gió lớn thương trường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '队员',
    pinyin: 'duìyuán',
    word_type: 'Danh từ',
    meaning_vi: 'đội viên, thành viên đội',
    examples: [
      { chinese: '足球队的全体队员每天下午都要进行高强度的体能体魄集训。', pinyin: 'Zúqiúduì de quántǐ duìyuán měitiān xiàwǔ dōu yào jìnxíng gāoxiàngdù de tǐnéng tǐpò jíxùn.', meaning_vi: 'Toàn thể đội viên đội bóng đá mỗi buổi chiều đều phải tập huấn thể lực thể hình cường độ cao.', difficulty_level: 'basic' },
      { chinese: '救援队的青年队员们冒着狂风暴雨挺进灾区一线，不分昼夜搜寻受困群众，彰显了无私大爱。', pinyin: 'Jiùyuánduì de qīngnián duìyuánmen mào zhe kuángfēng-bàoyǔ tǐngjìn zāiqū yīxiàn, bù fēn zhòuyè sōuxún shòukùn qúnzhòng, zhāngxiǎn le wúsī dà’ài.', meaning_vi: 'Các đội viên trẻ của đội cứu hộ đội mưa to gió lớn tiến vào tuyến đầu vùng thiên tai, không quản ngày đêm tìm kiếm quần chúng bị cô lập, ngời sáng tình yêu thương bao la vị tha.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '队长',
    pinyin: 'duìzhǎng',
    word_type: 'Danh từ',
    meaning_vi: 'đội trưởng',
    examples: [
      { chinese: '在队长的带领下，我们篮球队在最后的读秒绝杀中逆转赢得了总冠军。', pinyin: 'Zài duìzhǎng de dàilǐng xià, wǒmen lánqiúduì zài zuìhòu de dǒumiǎo juésā zhōng nìzhuǎn yíngdé le zǒng guànjūn.', meaning_vi: 'Dưới sự dẫn dắt của đội trưởng, đội bóng rổ chúng tôi đã lội ngược dòng giành ngôi vô địch chung cuộc trong giây phút ném bóng quyết định cuối cùng.', difficulty_level: 'basic' },
      { chinese: '作为一名合格出色的登山探险队长，不仅需要掌握精湛的专业户外生存技能，更要在生死关头果断决断全队去留。', pinyin: 'Zuòwéi yì míng hégé chūsè de dēngshān tànxiǎn duìzhǎng, bùjǐn xūyào zhǎngwò jīngzhàn de zhuānyè hùwài shēngcún jìnéng, gèng yào zài shēngsǐ guāntóu guǒduàn juéduàn quánduì qù-liú.', meaning_vi: 'Với tư cách là một người đội trưởng thám hiểm leo núi tài giỏi đạt chuẩn, không những cần nắm vững kỹ năng sinh tồn ngoài trời chuyên nghiệp đỉnh cao mà càng phải quyết đoán quyết định sự an nguy đi ở của toàn đội trong thời khắc sinh tử.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '顿',
    pinyin: 'dùn',
    word_type: 'Lượng từ',
    meaning_vi: 'bữa (ăn); trận (mắng, đòn)',
    examples: [
      { chinese: '无论工作有多么繁忙，每天也要按时吃上一顿热乎乎的健康午餐。', pinyin: 'Wúlùn gōngzuò yǒu duōme fánmáng, měitiān yě yào ànshí chī shàng yí dùn rèhūhū de jiànkāng wǔcān.', meaning_vi: 'Cho dù công việc có bận rộn đến đâu, mỗi ngày cũng phải ăn đúng giờ một bữa trưa ấm nóng lành mạnh.', difficulty_level: 'basic' },
      { chinese: '因为考试粗心大意涂错了答题卡，小明回家后被严厉的父亲狠狠地训斥了一顿。', pinyin: 'Yīnwèi kǎoshì cūxīn-dàyì tú cuò le dǎtíkǎ, Xiǎomíng huí jiā hòu bèi yánlì de fùqīn hěnhěn de xùnchì le yí dùn.', meaning_vi: 'Vì đi thi cẩu thả bất cẩn tô nhầm phiếu trả lời trắc nghiệm, sau khi về nhà Tiểu Minh đã bị người cha nghiêm khắc mắng mỏ cho một trận tơi bời.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '多么',
    pinyin: 'duōme',
    word_type: 'Phó từ',
    meaning_vi: 'biết bao, dường nào, xiết bao',
    examples: [
      { chinese: '站在这座高山之巅放眼远眺，祖国的大好河山是多么壮丽辽阔啊！', pinyin: 'Zhàn zài zhè zuò gāoshān zhī diān fàngyǎn yuǎntiào, zǔguó de dàhǎo héshān shì duōme zhuànglì liáokuò a!', meaning_vi: 'Đứng trên đỉnh ngọn núi cao này phóng tầm mắt nhìn xa, non sông gấm vóc của tổ quốc tráng lệ bao la biết nhường nào!', difficulty_level: 'basic' },
      { chinese: '在外漂泊打拼多年的游子，每逢万家团聚的中秋佳节，心里是多么渴望早日回到温暖的故土家园啊！', pinyin: 'Zài wài piāobó dǎpīn duō nián de yóuzǐ, měiféng wànjiā tuánjù de Zhōngqiū jiājié, xīnlǐ shì duōme kěwàng zǎorì huí dào wēnnuǎn de gùtǔ jiāyuán a!', meaning_vi: 'Người con xa xứ bươn chải nổi trôi phương xa nhiều năm, mỗi dịp Tết Trung Thu muôn nhà sum vầy, trong lòng tha thiết mong mỏi sớm được trở về mái ấm quê hương xiết bao!', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '多数',
    pinyin: 'duōshù',
    word_type: 'Danh từ',
    meaning_vi: 'đa số, phần lớn',
    examples: [
      { chinese: '经过全班举手表决，绝大多数同学赞同在下周六组织一次郊游烧烤活动。', pinyin: 'Jīngguò quán bān jǔshǒu biǎojué, jué dàduōshù tóngxué zàntóng zài xià zhōuliù zǔzhī yí cì jiāoyóu shāokǎo huódòng.', meaning_vi: 'Sau khi toàn lớp biểu quyết giơ tay, tuyệt đại đa số các bạn học đều đồng ý tổ chức một buổi dã ngoại nướng thịt vào thứ Bảy tuần tới.', difficulty_level: 'basic' },
      { chinese: '民主决策机制的精髓在于既要充分尊重大多数人的意愿诉求，同时也要切实保护少数群体的合法正当权益。', pinyin: 'Mínzhǔ juécè jīzhì de jīngsuǐ zàiyú jì yào chōngfèn zūnzhòng dàduōshù rén de yìyuàn sùqiú, tóngshí yě yào qièshí bǎohù shǎoshù qúntǐ de héfǎ zhèngdàng quányì.', meaning_vi: 'Tinh hoa của cơ chế quyết sách dân chủ nằm ở chỗ vừa phải tôn trọng đầy đủ nguyện vọng yêu cầu của đại đa số người, đồng thời cũng phải bảo vệ thiết thực quyền lợi hợp pháp chính đáng của nhóm thiểu số.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '多样',
    pinyin: 'duōyàng',
    word_type: 'Tính từ',
    meaning_vi: 'đa dạng, nhiều kiểu dáng/chủng loại',
    examples: [
      { chinese: '这家自助餐厅提供的菜品风格多样，既有传统中餐也有西方西点。', pinyin: 'Zhè jiā zìzhù cāntīng tígōng de càipǐn fēnggé duōyàng, jì yǒu chuántǒng Zhōngcān yě yǒu xīfāng xīdiǎn.', meaning_vi: 'Các món ăn mà nhà hàng buffet này phục vụ có phong cách đa dạng, vừa có đồ ăn Trung Hoa truyền thống lại vừa có bánh ngọt phương Tây.', difficulty_level: 'basic' },
      { chinese: '保持地球生物物种的多样性与生态系统结构的多样化，是维护全球生态安全防线的重要战略基石。', pinyin: 'Bǎochí dìqiú shēngwù wùzhǒng de duōyàngxìng yǔ shēngtài xìtǒng jiégòu de duōyànghuà, shì wéihù quánqiú shēngtài ānquán fángxiàn de zhòngyào zhànlüè jīshí.', meaning_vi: 'Gìn giữ tính đa dạng của các loài sinh vật trên Trái Đất và sự đa dạng hóa cấu trúc hệ sinh thái là nền tảng chiến lược trọng yếu để bảo vệ phòng tuyến an toàn sinh thái toàn cầu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '而',
    pinyin: 'ér',
    word_type: 'Liên từ',
    meaning_vi: 'và, mà, nhưng (liên từ nối biểu thị đẳng lập hoặc chuyển biến)',
    examples: [
      { chinese: '学好一门外语不仅需要浓厚的兴趣，而且更要靠持之以恒的练习。', pinyin: 'Xué hǎo yì mén wàiyǔ bùjǐn xūyào nónghòu de xìngqù, érqiě gèng yào kào chízhīyǐhéng de liànxí.', meaning_vi: 'Học tốt một ngoại ngữ không chỉ cần sự hứng thú đậm đà, mà hơn nữa càng phải dựa vào sự luyện tập kiên trì không ngừng nghỉ.', difficulty_level: 'basic' },
      { chinese: '有的人表面看似平凡质朴，而内心却蕴藏着无穷的智慧与坚不可摧的力量。', pinyin: 'Yǒu de rén biǎomiàn kànsì píngfán zhìpǔ, ér nèixīn què yùncáng zhe wúqióng de zhìhuì yǔ jiānbùkěcuī de lìliang.', meaning_vi: 'Có những người bề ngoài trông có vẻ bình dị mộc mạc, nhưng trong thâm tâm lại ẩn chứa trí tuệ vô biên và nguồn sức mạnh không thể phá vỡ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '儿童',
    pinyin: 'értóng',
    word_type: 'Danh từ',
    meaning_vi: 'nhi đồng, trẻ em',
    examples: [
      { chinese: '六月一日国际儿童节是全世界所有小朋友共同的快乐节日。', pinyin: 'Liù yuè yī rì guójì értóngjié shì quán shìjiè suǒyǒu xiǎopéngyou gòngtóng de kuàilè jiérì.', meaning_vi: 'Ngày 1 tháng 6 Tết Thiếu nhi Quốc tế là ngày lễ vui vẻ chung của tất cả các bạn nhỏ trên toàn thế giới.', difficulty_level: 'basic' },
      { chinese: '全社会都应当高度重视儿童的身心健康成长，为其营造充满阳光、关爱与安全的良好社会环境。', pinyin: 'Quán shèhuì dōu yīngdāng gāodù zhòngshì értóng de shēnxīn jiànkāng chéngzhǎng, wèi qí yíngzào chōngmǎn yángguāng, guān’ài yǔ ānquán de liánghǎo shèhuì huánjìng.', meaning_vi: 'Toàn xã hội đều nên hết sức coi trọng sự phát triển sức khỏe thể chất và tâm hồn của trẻ em, tạo dựng cho các em một môi trường xã hội lành mạnh ngập tràn ánh nắng, tình yêu thương và sự an toàn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '发出',
    pinyin: 'fāchū',
    word_type: 'Động từ',
    meaning_vi: 'phát ra, gửi đi, ban bố',
    examples: [
      { chinese: '求职信发出之后，他耐心地等待着招聘公司的面试回复。', pinyin: 'Qiúzhíxìn fāchū zhīhòu, tā nàixīn de děngdài zhe zhāopìn gōngsī de miànshì huífù.', meaning_vi: 'Sau khi thư xin việc được gửi đi, anh ấy kiên nhẫn chờ đợi phản hồi phỏng vấn của công ty tuyển dụng.', difficulty_level: 'basic' },
      { chinese: '气象预警中心针对即将登陆的特大强台风，紧急向沿海各大港口及渔船发出了最高级别红色预警信号。', pinyin: 'Qìxiàng yùjǐng zhōngxīn zhēnduì jíjiāng dēnglù de tèdà qiáng táifēng, jǐnjí xiàng yánhǎi gè dà gǎngkǒu jí yúcchuán fāchū le zuìgāo jíbié hóngsè yùjǐng xìnhào.', meaning_vi: 'Trung tâm cảnh báo khí tượng hướng tới cơn bão cực mạnh sắp đổ bộ đã khẩn cấp phát đi tín hiệu cảnh báo màu đỏ cấp cao nhất tới các cảng biển và tàu thuyền đánh cá ven biển.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '发送',
    pinyin: 'fāsòng',
    word_type: 'Động từ',
    meaning_vi: 'gửi, gửi đi, truyền tải',
    examples: [
      { chinese: '我已经把修改后的项目合同电子文件通过电子邮件发送到了您的邮箱。', pinyin: 'Wǒ yǐjīng bǎ xiūgǎi hòu de xiàngmù hétong diànzǐ wénjiàn tōngguò diànzǐ yóujiàn fāsòng dào le nín de yóuxiāng.', meaning_vi: 'Tôi đã gửi tập tin điện tử hợp đồng dự án sau khi chỉnh sửa qua thư điện tử tới hòm thư của ngài.', difficulty_level: 'basic' },
      { chinese: '遥感通信卫星能够将太空中拍摄的高分辨率对地观测数据实时精准地发送回地面接收总站。', pinyin: 'Yáogǎn tōngxùn wèixīng nénggòu jiāng tàikōng zhōng pāishè de gāo fēnbànlǜ duì dì guāncè shùjù shíshí jīngzhǔn de fāsòng huí dìmiàn jiēshōu zǒngzhàn.', meaning_vi: 'Vệ tinh viễn thông viễn thám có thể gửi dữ liệu quan trắc mặt đất độ phân giải cao chụp từ không gian về trạm tiếp nhận mặt đất theo thời gian thực một cách chuẩn xác.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '法',
    pinyin: 'fǎ',
    word_type: 'Danh từ',
    meaning_vi: 'pháp luật; phương pháp, cách thức',
    examples: [
      { chinese: '我们做任何事情都必须在国家法律法规允许的框架内进行，决不能违法。', pinyin: 'Wǒmen zuò rènhé shìqing dōu bìxū zài guójiā fǎlǜ fǎguī yǔnxǔ de kuàngjià nèi jìnxíng, jué bù néng wéifǎ.', meaning_vi: 'Chúng ta làm bất kỳ điều gì cũng đều phải tiến hành trong khuôn khổ cho phép của pháp luật quy định nhà nước, tuyệt đối không được phạm pháp.', difficulty_level: 'basic' },
      { chinese: '面对复杂疑难的科研命题，必须打破陈旧观念束缚，大胆摸索创新解题之法。', pinyin: 'Miànduì fùzá yínán de kēyán mìngtí, bìxū dǎpò chénjiù guānniàn shùfù, dàdǎn mōsuǒ chuàngxīn jiětí zhī fǎ.', meaning_vi: 'Đứng trước các đề bài nghiên cứu khoa học phức tạp khó nhằn, bắt buộc phải phá bỏ xiềng xích quan niệm cũ kỹ, mạnh dạn tìm tòi phương pháp giải đề đổi mới.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '法律',
    pinyin: 'fǎlǜ',
    word_type: 'Danh từ',
    meaning_vi: 'pháp luật',
    examples: [
      { chinese: '每个人在法律面前都是一律平等的，没有任何超越法律的特权。', pinyin: 'Měi gè rén zài fǎlǜ miànqián dōu shì yílǜ píngděng de, méiyǒu rènhé chāoyuè fǎlǜ de tèquán.', meaning_vi: 'Mỗi một con người trước pháp luật đều bình đẳng như nhau, không có bất kỳ đặc quyền nào vượt trên pháp luật.', difficulty_level: 'basic' },
      { chinese: '增强全民学法、知法、守法、用法的法律意识，是全面推进依法治国战略的坚固基石。', pinyin: 'Zēngqiáng quánmín xué fǎ, zhī fǎ, shǒu fǎ, yòng fǎ de fǎlǜ yìshí, shì quánmiàn tuījìn yīfǎ-zhìguó zhànlüè de jiāngù jīshí.', meaning_vi: 'Nâng cao ý thức pháp luật học luật, hiểu luật, chấp hành luật và dùng luật của toàn dân là nền tảng vững chắc để thúc đẩy toàn diện chiến lược thượng tôn pháp luật quản trị đất nước.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '翻译',
    pinyin: 'fānyì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'dịch thuật, phiên dịch; dịch giả, bản dịch',
    examples: [
      { chinese: '请把这段精彩的中文成语典故翻译成流利地道的英语。', pinyin: 'Qǐng bǎ zhè duàn jīngcǎi de Zhōngwén chéngyǔ diǎngù fānyì chéng liúlì dìdao de Yīngyǔ.', meaning_vi: 'Xin hãy dịch đoạn điển cố thành ngữ tiếng Trung đặc sắc này sang tiếng Anh lưu loát bản ngữ.', difficulty_level: 'basic' },
      { chinese: '一名优秀资深的高级同声传译翻译，不仅需要具备敏捷过人的双语转换反应，更需要博闻强识的百科全书式知识储备。', pinyin: 'Yì míng yōuxiù zīshēn de gāojí tóngshēng-chuányì fānyì, bùjǐn xūyào jùbèi mǐnjié guòrén de shuāngyǔ zhuǎnhuàn fǎnyìng, gèng xūyào bówén-qiángzhì de bǎikē-quánshū shì zhīshi chǔbèi.', meaning_vi: 'Một phiên dịch viên cabin dịch song song cao cấp dày dặn ưu tú không chỉ cần có phản xạ chuyển đổi song ngữ nhanh nhạy hơn người, mà càng cần kho tàng kiến thức bách khoa toàn thư uyên thâm hiểu rộng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '烦',
    pinyin: 'fán',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'phiền muộn, chán ngấy; làm phiền',
    examples: [
      { chinese: '外面下了一整天连绵不断的阴雨，让人心里觉得格外心烦。', pinyin: 'Wàimiàn xià le yì zhěng tiān liánmián-búduàn de yīnyǔ, ràng rén xīnlǐ juéde géwài xīnfán.', meaning_vi: 'Bên ngoài trút cơn mưa dầm dề suốt cả ngày, khiến trong lòng người ta cảm thấy buồn bực phiền não lạ thường.', difficulty_level: 'basic' },
      { chinese: '他正在专注地排查一段极其复杂的程序底层代码，请大家先别去烦他。', pinyin: 'Tā zhèngzài zhuānzhù de páichá yí duàn jíqí fùzá de chéngxù dǐcéng dàimǎ, qǐng dàjiā xiān bié qù fán tā.', meaning_vi: 'Anh ấy đang chuyên chú rà soát một đoạn mã nguồn tầng đáy chương trình cực kỳ phức tạp, xin mọi người trước mắt đừng tới làm phiền anh ấy.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '烦恼',
    pinyin: 'fánnǎo',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'phiền muộn, phiền não, nỗi lo',
    examples: [
      { chinese: '生活中有许多微不足道的烦恼，笑一笑就都会随风消散。', pinyin: 'Shēnghuó zhōng yǒu xǔduō wēibùzúdào de fánnǎo, xiào yí xiào jiù dōu huì suí fēng xiāosàn.', meaning_vi: 'Trong cuộc sống có rất nhiều nỗi phiền muộn cỏn con, chỉ cần cười một tiếng là tất thảy đều tan theo làn gió.', difficulty_level: 'basic' },
      { chinese: '面对成长路上的种种困惑与烦恼，多向值得信赖的师长朋友倾诉交流是舒缓心理压力的良方。', pinyin: 'Miànduì chéngzhǎng lù shang de zhǒngzhǒng kùnhuò yǔ fánnǎo, duō xiàng zhídé xìnlài de shīzhǎng péngyou qīngsù jiāoliú shì shūhuǎn xīnlǐ yālì de liángfāng.', meaning_vi: 'Đối mặt với những băn khoăn phiền muộn trên đường trưởng thành, tâm sự sẻ chia với thầy cô bạn bè đáng tin cậy là liều thuốc hữu hiệu để xoa dịu áp lực tâm lý.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '反对',
    pinyin: 'fǎnduì',
    word_type: 'Động từ',
    meaning_vi: 'phản đối',
    examples: [
      { chinese: '大部分居民坚决反对在生活小区附近修建高污染的化工厂。', pinyin: 'Dà bùfen jūmín jiānjué fǎnduì zài shēnghuó xiǎoqū fùjìn xiūjiàn gāo wūrǎn de huàgōngchǎng.', meaning_vi: 'Phần lớn người dân kiên quyết phản đối việc xây dựng nhà máy hóa chất gây ô nhiễm cao gần khu dân cư sinh sống.', difficulty_level: 'basic' },
      { chinese: '国际社会绝大多数正义力量一致严正反对任何形式的单边霸凌霸道行径，坚定捍卫联合国宪章宗旨。', pinyin: 'Guójì shèhuì jué dàduōshù zhèngyì lìliang yízhì yánzhèng fǎnduì rènhé xíngshì de dānbiān bàlíng bàdào xíngjìng, jiāndìng hànwèi Liánhéguó xiànzhāng zōngzhǐ.', meaning_vi: 'Tuyệt đại đa số các lực lượng chính nghĩa trong cộng đồng quốc tế nhất trí nghiêm khắc phản đối bất kỳ hành vi bắt nạt đơn phương bá quyền nào, kiên định bảo vệ tôn chỉ của Hiến chương Liên Hợp Quốc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '方面',
    pinyin: 'fāngmiàn',
    word_type: 'Danh từ',
    meaning_vi: 'phương diện, mặt, khía cạnh',
    examples: [
      { chinese: '他在语言学习和体育运动方面都展现出了非凡过人的天赋。', pinyin: 'Tā zài yǔyán xuéxí hé tǐyù yùndòng fāngmiàn dōu zhǎnxiàn chū le fēifán guòrén de tiānfù.', meaning_vi: 'Cậu ấy ở cả hai phương diện học ngôn ngữ và vận động thể thao đều bộc lộ năng khiếu phi phàm hơn người.', difficulty_level: 'basic' },
      { chinese: '在评估重大投资合作项目时，必须统筹综合考量其在经济收益、社会效益以及生态环境等多方面的综合影响。', pinyin: 'Zài pínggū zhòngdà tóuzī hézuò xiàngmù shí, bìxū tǒngchóu zōnghé kǎoliàng qí zài jīngjì shōuyì, shèhuì xiàoyì yǐjí shēngtài huánjìng děng duō fāngmiàn de zōnghé yǐngxiǎng.', meaning_vi: 'Khi đánh giá một dự án hợp tác đầu tư trọng đại, bắt buộc phải tính toán bao quát tổng hợp ảnh hưởng trên nhiều phương diện như lợi ích kinh tế, hiệu quả xã hội cũng như môi trường sinh thái.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '方式',
    pinyin: 'fāngshì',
    word_type: 'Danh từ',
    meaning_vi: 'phương thức, cách thức',
    examples: [
      { chinese: '步行和骑自行车出行是现代都市人非常推崇的绿色健康生活方式。', pinyin: 'Bùxíng hé qí zìxíngchē chūxíng shì xiàndài dūshìrén fēicháng tuīchóng de lǜsè jiànkāng shēnghuó fāngshì.', meaning_vi: 'Đi bộ và đạp xe là lối sống lành mạnh xanh mà người thành thị hiện đại vô cùng ưa chuộng.', difficulty_level: 'basic' },
      { chinese: '随着移动互联网的高速普及，移动扫码支付已经彻底改变了传统纸币现金交易的日常生活消费方式。', pinyin: 'Suízhe yídòng hùliánwǎng de gāosù pǔjí, yídòng sǎomǎ zhīfù yǐjīng chèdǐ gǎibiàn le chuántǒng zhǐbì xiànjīn jiāoyì de rìcháng shēnghuó xiāofèi fāngshì.', meaning_vi: 'Cùng với sự phổ biến nhanh chóng của internet di động, thanh toán quét mã trên điện thoại đã thay đổi triệt để phương thức tiêu dùng sinh hoạt hàng ngày bằng tiền mặt giấy truyền thống.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '房东',
    pinyin: 'fángdōng',
    word_type: 'Danh từ',
    meaning_vi: 'chủ nhà (cho thuê nhà)',
    examples: [
      { chinese: '我们的房东是一位十分和善热心的大妈，逢年过节总给我们送自制的水饺。', pinyin: 'Wǒmen de fángdōng shì yí wèi shífēn héshàn rèxīn de dàmā, féngnián-guòjié zǒng gěi wǒmen sòng zìzhì de shuǐjiǎo.', meaning_vi: 'Bác chủ nhà của chúng tôi là một bác gái rất hòa nhã nhiệt tình, mỗi dịp lễ tết luôn mang sang cho chúng tôi bánh sủi cảo tự làm.', difficulty_level: 'basic' },
      { chinese: '租房双方在正式签约前，应当就房屋日常设施维保责任与房租支付节点同房东协商达成一致。', pinyin: 'Zūfáng shuāngfāng zài zhèngshì qiānyuē qián, yīngdāng jiù fángwū rìcháng shèshī wéibǎo zérèn yǔ fángzū zhīfù jiédiǎn tóng fángdōng xiéshāng dáchéng yízhì.', meaning_vi: 'Hai bên thuê nhà trước khi chính thức ký hợp đồng nên hiệp thương đạt sự thống nhất với chủ nhà về trách nhiệm bảo trì tiện nghi hàng ngày và kỳ hạn trả tiền thuê nhà.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '房租',
    pinyin: 'fángzū',
    word_type: 'Danh từ',
    meaning_vi: 'tiền thuê nhà',
    examples: [
      { chinese: '每个月五号之前，他都会准时通过网银转账向房东交付房租。', pinyin: 'Měi gè yuè wǔ hào zhīqián, tā dōu huì zhǔnshí tōngguò wǎngyín zhuǎnzhàng xiàng fángdōng jiāofù fángzū.', meaning_vi: 'Trước ngày mồng năm hàng tháng, cậu ấy đều chuyển khoản ngân hàng trả tiền thuê nhà cho chủ nhà đúng hẹn.', difficulty_level: 'basic' },
      { chinese: '大城市中心地段高昂的房租成本，是刚踏入社会的年轻大学毕业生面临的一大现实经济挑战。', pinyin: 'Dà chéngshì zhōngxīn dìduàn gāo’áng de fángzū chéngběn, shì gāng tàrù shèhuì de niánqīng dàxué bìyèshēng miànlín de yí dà xiànshí jīngjì tiǎozhàn.', meaning_vi: 'Chi phí thuê nhà đắt đỏ tại các vị trí trung tâm thành phố lớn là một thách thức kinh tế thực tế lớn mà những sinh viên đại học trẻ mới bước vào đời phải đối mặt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '放弃',
    pinyin: 'fàngqì',
    word_type: 'Động từ',
    meaning_vi: 'từ bỏ, buông xuôi',
    examples: [
      { chinese: '只要心中怀揣梦想，就永远不要在遇到困难时轻易说放弃。', pinyin: 'Zhǐyào xīn zhōng huáichuāi mèngxiǎng, jiù yǒngyuǎn bú yào zài yù dào kùnnan shí qīngyì shuō fàngqì.', meaning_vi: 'Chỉ cần trong lòng ấp ủ ước mơ thì vĩnh viễn đừng bao giờ dễ dàng nói từ bỏ khi gặp phải khó khăn.', difficulty_level: 'basic' },
      { chinese: '经历过无数次实验失败与挫折，科研人员凭借顽强坚毅的毅力始终未曾放弃对真理的探索。', pinyin: 'Jīnglì guò wúshù cì shíyàn shībài yǔ cuòzhé, kēyán rényuán píngjiè wánqiáng jiānyì de yìlì shǐzhōng wèicéng fàngqì duì zhēnlǐ de tànsuǒ.', meaning_vi: 'Trải qua vô số lần thí nghiệm thất bại và trắc trở, những người làm nghiên cứu khoa học dựa vào ý chí kiên định ngoan cường chưa bao giờ từ bỏ việc tìm kiếm chân lý.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '放松',
    pinyin: 'fàngsōng',
    word_type: 'Động từ',
    meaning_vi: 'thư giãn, thả lỏng',
    examples: [
      { chinese: '经过一整天紧张忙碌的高压工作，听听舒缓的轻音乐有助于放松身心。', pinyin: 'Jīngguò yì zhěng tiān jǐnzhāng mánglù de gāoyā gōngzuò, tīngting shūhuǎn de qīngyīnyuè yǒuzhùyú fàngsōng shēnxīn.', meaning_vi: 'Sau cả ngày làm việc áp lực cao bận rộn căng thẳng, nghe chút nhạc nhẹ êm dịu rất có ích để thả lỏng thể xác và tinh thần.', difficulty_level: 'basic' },
      { chinese: '在重大体育赛事或关键考试登场前，保持适度放松的良好心态往往比盲目焦虑更能发挥出最佳竞技水平。', pinyin: 'Zài zhòngdà tǐyù sàishì huò guānjiàn kǎoshì dēngchǎng qián, bǎochí shìdù fàngsōng de liánghǎo xīntài wǎngwǎng bǐ mángmù jiāolǜ gèng néng fāhuī chū zuì jiā jìngjì shuǐpíng.', meaning_vi: 'Trước khi bước vào trận đấu thể thao lớn hay kỳ thi trọng đại, giữ vững tâm thái thả lỏng vừa phải thường phát huy được phong độ thi đấu đỉnh cao hơn nhiều so với việc lo lắng mù quáng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '费',
    pinyin: 'fèi',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'tiền phí, lệ phí; tiêu tốn, hao tốn',
    examples: [
      { chinese: '每个月他都要在手机软件上按时缴纳家里的水费和电费。', pinyin: 'Měi gè yuè tā dōu yào zài shǒujī ruǎnjiàn shang ànshí jiǎonà jiālǐ de shuǐfèi hé diànfèi.', meaning_vi: 'Mỗi tháng anh ấy đều phải đóng tiền điện và tiền nước của gia đình đúng hạn trên ứng dụng di động.', difficulty_level: 'basic' },
      { chinese: '这项极其精密复杂的技术攻关费尽了全体研发工程师长达两年的心血与精力。', pinyin: 'Zhè xiàng jíqí jīngmì fùzá de jìshù gōngguān fèi jìn le quántǐ yánfā gōngchéngshī cháng dá liǎng nián de xīnxuè yǔ jīnglì.', meaning_vi: 'Đợt đột phá kỹ thuật cực kỳ tinh vi phức tạp này đã tiêu tốn biết bao tâm huyết và công sức suốt hai năm ròng của toàn thể kỹ sư nghiên cứu phát triển.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '费用',
    pinyin: 'fèiyong',
    word_type: 'Danh từ',
    meaning_vi: 'chi phí, kinh phí',
    examples: [
      { chinese: '出差归来之后，他第一时间把交通和住宿的相关费用发票整理报销。', pinyin: 'Chūchāi guīlái zhīhòu, tā dì-yī shíjiān bǎ jiāotōng hé zhùsù de xiāngguān fèiyong fāpiào zhěnglǐ bàoxiāo.', meaning_vi: 'Sau khi đi công tác trở về, anh ấy lập tức sắp xếp hóa đơn các chi phí liên quan đến ăn ở và đi lại để thanh toán.', difficulty_level: 'basic' },
      { chinese: '在制定新财年年度财务预算时，管理团队对各项市场推广及研发运营费用进行了严格精细的核算审查。', pinyin: 'Zài zhìdìng xīn cái nián niándù cáiwù yùsuàn shí, guǎnlǐ tuánduì duì gè xiàng shìchǎng tuīguǎng jí yánfā yùnyíng fèiyong jìnxíng le yángé jīngxì de hésuàn shěnchá.', meaning_vi: 'Khi lập dự toán tài chính thường niên cho năm tài khóa mới, đội ngũ quản lý đã tiến hành hạch toán thẩm định chặt chẽ chi tiết đối với mọi khoản chi phí xúc tiến thị trường cũng như vận hành nghiên cứu phát triển.', difficulty_level: 'applied' }
    ]
  }
]

console.log('HSK 4 Batch 2 loaded successfully with 100 items and 200 examples!')
