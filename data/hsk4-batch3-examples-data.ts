// ====================================================================
// HSK 4 - BATCH 3: 100 TỪ VỰNG & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #1201 [分数] (fēnshù) -> #1300 [护士] (hùshi)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin + Dịch TV
// ====================================================================

import type { Hsk4ExampleItem } from './hsk4-batch1-examples-data'

export const HSK4_BATCH3_EXAMPLES: Hsk4ExampleItem[] = [
  // 1201. 分数
  {
    hanzi: '分数',
    pinyin: 'fēnshù',
    word_type: 'Danh từ',
    meaning_vi: 'điểm số, điểm thi',
    examples: [
      { chinese: '这次期末考试他的汉语听力拿到了满分的高分数。', pinyin: 'Zhè cì qīmò kǎoshì tā de Hànyǔ tīnglì ná dào le mǎnfēn de gāo fēnshù.', meaning_vi: 'Kỳ thi cuối kỳ lần này điểm thi nghe tiếng Trung của anh ấy đạt điểm tuyệt đối.', difficulty_level: 'basic' },
      { chinese: '学校评价学生的综合素养时，不应该仅仅单纯看卷面考试分数，更要注重实践创新能力。', pinyin: 'Xuéxiào píngjià xuésheng de zōnghé sùyǎng shí, bù yīnggāi jǐnjǐn dānchún kàn juànmiàn kǎoshì fēnshù, gèng yào zhùzhòng shíjiàn chuàngxīn nénglì.', meaning_vi: 'Khi nhà trường đánh giá tố chất tổng hợp của học sinh, không nên chỉ đơn thuần nhìn vào điểm số bài thi trên giấy, mà càng phải coi trọng năng lực thực hành đổi mới sáng tạo.', difficulty_level: 'applied' }
    ]
  },
  // 1202. 分为
  {
    hanzi: '分为',
    pinyin: 'fēnwéi',
    word_type: 'Động từ',
    meaning_vi: 'chia thành, phân làm',
    examples: [
      { chinese: '这篇课文一共分为三个自然段，请大家朗读第一段。', pinyin: 'Zhè piān kèwén yígòng fēnwéi sān gè zìránduàn, qǐng dàjiā lǎngdú dì-yī duàn.', meaning_vi: 'Bài khóa này được chia thành tất cả ba đoạn văn tự nhiên, mời mọi người đọc to đoạn thứ nhất.', difficulty_level: 'basic' },
      { chinese: '该培训项目根据学员的语言实际水平分为初级、中级与高级三个递进阶段。', pinyin: 'Gāi péixùn xiàngmù gēnjù xuéyuán de yǔyán shíjì shuǐpíng fēnwéi chūjí, zhōngjí yǔ gāojí sān gè dìjìn jiēduàn.', meaning_vi: 'Dự án đào tạo này căn cứ theo trình độ ngôn ngữ thực tế của học viên để chia thành ba giai đoạn tịnh tiến: sơ cấp, trung cấp và cao cấp.', difficulty_level: 'applied' }
    ]
  },
  // 1203. 份
  {
    hanzi: '份',
    pinyin: 'fèn',
    word_type: 'Lượng từ',
    meaning_vi: 'phần, bản, suất (suất ăn, bản hợp đồng)',
    examples: [
      { chinese: '服务员，请帮我们再加一份米饭和两份餐具。', pinyin: 'Fúwùyuán, qǐng bāng wǒmen zài jiā yí fèn mǐfàn hé liǎng fèn cānjù.', meaning_vi: 'Phục vụ ơi, vui lòng cho chúng tôi thêm một suất cơm và hai bộ bát đũa.', difficulty_level: 'basic' },
      { chinese: '请把这份刚刚起草完成的商业合作意向书打印三份并送交总经理审阅。', pinyin: 'Qǐng bǎ zhè fèn gānggāng qǐcǎo wánchéng de shāngyè hézuò yìxiàngshū dǎyìn sān fèn bìng sòngjiāo zǒngjīnglǐ shěnyuè.', meaning_vi: 'Xin hãy in ba bản thư ngỏ ý hợp tác kinh doanh vừa mới soạn thảo này và gửi lên tổng giám đốc xét duyệt.', difficulty_level: 'applied' }
    ]
  },
  // 1204. 丰富
  {
    hanzi: '丰富',
    pinyin: 'fēngfù',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'phong phú, dồi dào; làm phong phú',
    examples: [
      { chinese: '图书馆里收藏了非常丰富的中外文学书籍。', pinyin: 'Túshūguǎn lǐ shōucáng le fēicháng fēngfù de zhōngwài wénxué shūjí.', meaning_vi: 'Trong thư viện lưu trữ những đầu sách văn học Trung Quốc và nước ngoài vô cùng phong phú.', difficulty_level: 'basic' },
      { chinese: '利用业余时间多参加公益志愿活动，不仅能拓宽人际视野，还能极大丰富人生阅历。', pinyin: 'Lìyòng yèyú shíjiān duō cānjiā gōngyì zhìyuàn huódòng, bùjǐn néng tuòkuān rénjì shìyě, hái néng jídà fēngfù rénshēng yuèlì.', meaning_vi: 'Tận dụng thời gian rảnh rỗi tham gia nhiều hoạt động tình nguyện công ích không chỉ mở rộng tầm nhìn giao tiếp, mà còn làm phong phú đáng kể trải nghiệm cuộc đời.', difficulty_level: 'applied' }
    ]
  },
  // 1205. 风景
  {
    hanzi: '风景',
    pinyin: 'fēngjǐng',
    word_type: 'Danh từ',
    meaning_vi: 'phong cảnh, cảnh đẹp',
    examples: [
      { chinese: '西湖的优美风景吸引了成千上万的海内外游客。', pinyin: 'Xīhú de yōuměi fēngjǐng xīyǐn le chéngqiān-shàngwàn de hǎinèiwài yóukè.', meaning_vi: 'Phong cảnh tuyệt đẹp của Tây Hồ đã thu hút hàng vạn du khách trong và ngoài nước.', difficulty_level: 'basic' },
      { chinese: '登上山顶极目远眺，层峦叠嶂与蓝天白云相映成趣，眼前的自然风景令人心旷神怡。', pinyin: 'Dēng shàng shāndǐng jímù yuǎntiào, céngluán-diézhàng yǔ lántiān-báiyún xiāngyìng-chéngqù, yǎnqián de zìrán fēngjǐng lìng rén xīnxuàng-shényí.', meaning_vi: 'Lên đến đỉnh núi phóng tầm mắt ra xa, các tầng núi điệp trùng cùng trời xanh mây trắng hòa quyện tuyệt đẹp, cảnh quan thiên nhiên trước mắt khiến lòng người khoan khoái nhẹ nhõm.', difficulty_level: 'applied' }
    ]
  },
  // 1206. 否则
  {
    hanzi: '否则',
    pinyin: 'fǒuzé',
    word_type: 'Liên từ',
    meaning_vi: 'nếu không thì, bằng không',
    examples: [
      { chinese: '我们必须马上动身出发，否则就赶不上最后一趟高铁了。', pinyin: 'Wǒmen bìxū mǎshàng dòngshēn chūfā, fǒuzé jiù gǎnbushàng zuìhòu yí tàng gāotiě le.', meaning_vi: 'Chúng ta phải lập tức lên đường khởi hành, nếu không thì sẽ không kịp chuyến tàu cao tốc cuối cùng.', difficulty_level: 'basic' },
      { chinese: '合同文本在正式签署前务必交由法务团队严谨审核，否则一旦发生法律纠纷将难以维权。', pinyin: 'Hétong wénběn zài zhèngshì qiānshǔ qián wùbì jiāo yóu fǎwù tuánduì yánjǐn shěnhé, fǒuzé yídàn fāshēng fǎlǜ jiūfēn jiāng nányǐ wéiquán.', meaning_vi: 'Văn bản hợp đồng trước khi ký kết chính thức nhất thiết phải giao cho đội ngũ pháp chế rà soát cẩn thận, bằng không một khi phát sinh tranh chấp pháp lý sẽ rất khó bảo vệ quyền lợi.', difficulty_level: 'applied' }
    ]
  },
  // 1207. 幅
  {
    hanzi: '幅',
    pinyin: 'fú',
    word_type: 'Lượng từ',
    meaning_vi: 'bức, tấm (tranh, ảnh, khẩu hiệu)',
    examples: [
      { chinese: '客厅的白墙上挂着一幅充满中国韵味的水墨山水画。', pinyin: 'Kètīng de bái qiáng shang guà zhe yì fú chōngmǎn Zhōngguó yùnwèi de shuǐmò shānshuǐhuà.', meaning_vi: 'Trên bức tường trắng phòng khách treo một bức tranh sơn thủy thủy mặc đậm đà phong vị Trung Hoa.', difficulty_level: 'basic' },
      { chinese: '这幅出自当代著名艺术大师之手的油画杰作，在国际艺术品拍卖会上拍出了创纪录的天价。', pinyin: 'Zhè fú chūzì dāngdài zhùmíng yìshù dàshī zhī shǒu de yóuhuà jiézuò, zài guójì yìshùpǐn pàimàihuì shang pāi chū le chuàng jìlù de tiānjià.', meaning_vi: 'Kiệt tác tranh sơn dầu xuất phát từ tay đại sư nghệ thuật đương đại nổi tiếng này đã được đấu giá mức kỷ lục trên sàn đấu giá tác phẩm nghệ thuật quốc tế.', difficulty_level: 'applied' }
    ]
  },
  // 1208. 符合
  {
    hanzi: '符合',
    pinyin: 'fúhé',
    word_type: 'Động từ',
    meaning_vi: 'phù hợp, khớp với, đáp ứng',
    examples: [
      { chinese: '他的专业技能完全符合这家外资公司的招聘条件。', pinyin: 'Tā de zhuānyè jìnéng wánquán fúhé zhè jiā wàizī gōngsī de zhāopìn tiáojiàn.', meaning_vi: 'Kỹ năng chuyên môn của anh ấy hoàn toàn phù hợp với điều kiện tuyển dụng của công ty vốn nước ngoài này.', difficulty_level: 'basic' },
      { chinese: '新推出的这一系列环保智能产品严格符合国家最新出台的绿色能耗标准。', pinyin: 'Xīn tuīchū de zhè yí xìliè huánbǎo zhìnéng chǎnpǐn yángé fúhé guójiā zuìxīn chūtái de lǜsè nénghào biāozhǔn.', meaning_vi: 'Dòng sản phẩm thông minh bảo vệ môi trường mới ra mắt này hoàn toàn đáp ứng nghiêm ngặt các tiêu chuẩn tiêu hao năng lượng xanh mới ban hành của quốc gia.', difficulty_level: 'applied' }
    ]
  },
  // 1209. 付
  {
    hanzi: '付',
    pinyin: 'fù',
    word_type: 'Động từ',
    meaning_vi: 'trả, chi trả, thanh toán',
    examples: [
      { chinese: '结账的时候，你可以选择用手机微信扫码付钱。', pinyin: 'Jiézhàng de shíhou, nǐ kěyǐ xuǎnzé yòng shǒujī Wēixìn sǎomǎ fù qián.', meaning_vi: 'Lúc thanh toán tiền, bạn có thể chọn quét mã WeChat trên điện thoại di động để trả tiền.', difficulty_level: 'basic' },
      { chinese: '为了如期实现企业的战略转型与自主研发突破，他们付出了巨大的时间与资金代价。', pinyin: 'Wèile rúqī shíxiàn qǐyè de zhànlüè zhuǎnxíng yǔ zìzhǔ yánfā tūpò, tāmen fùchū le jùdà de shíjiān yǔ zījīn dàijià.', meaning_vi: 'Để đạt được chuyển đổi chiến lược và đột phá nghiên cứu độc lập đúng kỳ hạn của doanh nghiệp, họ đã phải trả cái giá rất lớn về thời gian và vốn đầu tư.', difficulty_level: 'applied' }
    ]
  },
  // 1210. 父母
  {
    hanzi: '父母',
    pinyin: 'fùmǔ',
    word_type: 'Danh từ',
    meaning_vi: 'cha mẹ, bố mẹ, phụ mẫu',
    examples: [
      { chinese: '无论工作有多忙碌，周末他都会抽空陪伴年迈的父母。', pinyin: 'Wúlùn gōngzuò yǒu duō mánglù, zhōumò tā dōu huì chōukòng péibàn niánmài de fùmǔ.', meaning_vi: 'Bất kể công việc bận rộn đến đâu, cuối tuần anh ấy đều tranh thủ thời gian bầu bạn với cha mẹ già.', difficulty_level: 'basic' },
      { chinese: '父母良好的言传身教对于孩子健全人格与独立思维的培养起着至关重要的启蒙作用。', pinyin: 'Fùmǔ liánghǎo de yánchuán-shēnjiào duìyú háizi jiànquán réngé yǔ dúlì sīwéi de péiyǎng qǐ zhe zhìguān zhòngyào de qǐméng zuòyòng.', meaning_vi: 'Lời dạy bảo và hành động gương mẫu tốt đẹp của cha mẹ đóng vai trò khai sáng vô cùng thiết yếu đối với việc bồi dưỡng nhân cách toàn diện và tư duy độc lập của con trẻ.', difficulty_level: 'applied' }
    ]
  },
  // 1211. 父女
  {
    hanzi: '父女',
    pinyin: 'fùnǚ',
    word_type: 'Danh từ',
    meaning_vi: 'cha và con gái, bố con gái',
    examples: [
      { chinese: '他们父女俩长得很像，笑起来都有两个可爱的小酒窝。', pinyin: 'Tāmen fùnǚ liǎ zhǎng de hěn xiàng, xiào qǐlai dōu yǒu liǎng gè kě’ài de xiǎo jiǔwō.', meaning_vi: 'Hai cha con họ trông rất giống nhau, khi cười đều có hai má lúm đồng tiền rất đáng yêu.', difficulty_level: 'basic' },
      { chinese: '即使分隔大洋两岸多年，深深的父女深情与默契并没有因时间和空间的距离而减弱分毫。', pinyin: 'Jíshǐ fēngé dàyáng liǎng’àn duō nián, shēnshēn de fùnǚ shēnqíng yǔ mòqì bìng méiyǒu yīn shíjiān hé kōngjiān de jùlí ér jiǎnruò fēnháo.', meaning_vi: 'Dẫu cho xa cách hai bờ đại dương nhiều năm, tình cảm cha con sâu đậm và sự thấu hiểu ngầm không hề giảm bớt chút nào bởi khoảng cách thời gian và không gian.', difficulty_level: 'applied' }
    ]
  },
  // 1212. 父亲
  {
    hanzi: '父亲',
    pinyin: 'fùqīn',
    word_type: 'Danh từ',
    meaning_vi: 'cha, người cha, thân phụ',
    examples: [
      { chinese: '在我的印象中，父亲是一位性格温和且十分有耐心的长辈。', pinyin: 'Zài wǒ de yìnxiàng zhōng, fùqīn shì yí wèi xìnggé wēnhé qiě shífēn yǒu nàixīn de zhǎngbèi.', meaning_vi: 'Trong ấn tượng của tôi, cha là một bậc trưởng bối tính cách hiền hòa và hết sức kiên nhẫn.', difficulty_level: 'basic' },
      { chinese: '父亲常常告诫我们在为人处世上要秉持诚信正直的品格，不可因眼前蝇头微利而丧失原则底线。', pinyin: 'Fùqīn chángcháng gàojiè wǒmen zài wéirén-chǔshì shang yào bǐngchí chéngxìn zhèngzhí de pǐngé, bù kě yīn yǎnqián yíngtóu wēilì ér sàngshī yuánzé dǐxiàn.', meaning_vi: 'Cha thường răn dạy chúng tôi trong việc đối nhân xử thế phải giữ vững phẩm cách chân thành chính trực, không được vì chút món lợi nhỏ trước mắt mà đánh mất nguyên tắc đạo đức.', difficulty_level: 'applied' }
    ]
  },
  // 1213. 复印
  {
    hanzi: '复印',
    pinyin: 'fùyìn',
    word_type: 'Động từ',
    meaning_vi: 'photocopy, sao chụp văn bản',
    examples: [
      { chinese: '请把身份证正面和反面都复印在一张白纸上。', pinyin: 'Qǐng bǎ shēnfènzhèng zhèngmiàn hé fǎnmiàn dōu fùyìn zài yì zhāng bái zhǐ shang.', meaning_vi: 'Xin hãy photo cả mặt trước lẫn mặt sau chứng minh thư lên trên một tờ giấy trắng.', difficulty_level: 'basic' },
      { chinese: '办理跨国业务签证时，使馆要求申请人提供所有财务资信证明材料的清晰复印件并加盖公章。', pinyin: 'Bànlǐ kuàguó yèwù qiānzhèng shí, shǐguǎn yāoqiú shēnqǐngrén tígōng suǒyǒu cáiwù zīxìn zhèngmíng cáiliào de qīngxī fùyìnjiàn bìng jiā gài gōngzhāng.', meaning_vi: 'Khi làm thủ tục xin visa công tác đa quốc gia, đại sứ quán yêu cầu người nộp đơn cung cấp bản photo rõ nét tất cả giấy tờ chứng minh năng lực tài chính và đóng dấu giáp lai.', difficulty_level: 'applied' }
    ]
  },
  // 1214. 复杂
  {
    hanzi: '复杂',
    pinyin: 'fùzá',
    word_type: 'Tính từ',
    meaning_vi: 'phức tạp, rắc rối',
    examples: [
      { chinese: '这个问题背后的原因相当复杂，不是三言两语能解释清楚的。', pinyin: 'Zhè gè wèntí bèihòu de yuányīn xiāngdāng fùzá, bú shì sānyán-liǎngyǔ néng jiěshì qīngchu de.', meaning_vi: 'Nguyên nhân đằng sau vấn đề này tương đối phức tạp, không phải ba lời hai câu là có thể giải thích rõ ràng được.', difficulty_level: 'basic' },
      { chinese: '面对复杂多变的国际宏观经济环境，外贸企业需要提高抗风险能力并积极拓宽多元化市场。', pinyin: 'Miànduì fùzá duōbiàn de guójì hóngguān jīngjì huánjìng, wàimào qǐyè xūyào tígāo kàng-fēngxiǎn nénglì bìng jījí tuòkuān duōyuánhuà shìchǎng.', difficulty_level: 'applied', meaning_vi: 'Đối mặt với môi trường kinh tế vĩ mô quốc tế phức tạp nhiều biến động, các doanh nghiệp ngoại thương cần nâng cao năng lực chống chịu rủi ro và tích cực mở rộng thị trường đa dạng hóa.' }
    ]
  },
  // 1215. 负责
  {
    hanzi: '负责',
    pinyin: 'fùzé',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'phụ trách, chịu trách nhiệm; có tinh thần trách nhiệm',
    examples: [
      { chinese: '王经理负责整个华东区域的销售与客户服务业务。', pinyin: 'Wáng jīnglǐ fùzé zhěnggè Huádōng qūyù de xiāoshòu yǔ kèhù fúwù yèwù.', meaning_vi: 'Giám đốc Vương phụ trách toàn bộ hoạt động bán hàng và dịch vụ khách hàng khu vực Hoa Đông.', difficulty_level: 'basic' },
      { chinese: '一个真正负责任的团队主管，在遇到意外突发状况时会主动担当并迅速提出应急解决方案。', pinyin: 'Yí gè zhēnzhèng fùzérèn de tuánduì zhǔguǎn, zài yù dào yìwài tūfā zhuàngkuàng shí huì zhǔdòng dāndāng bìng xùnsù tíchū yìngjí jiějué fāng’àn.', meaning_vi: 'Một người trưởng nhóm thực sự có trách nhiệm, khi gặp phải tình huống phát sinh ngoài ý muốn sẽ chủ động gánh vác và nhanh chóng đưa ra giải pháp ứng phó khẩn cấp.', difficulty_level: 'applied' }
    ]
  },
  // 1216. 负责人
  {
    hanzi: '负责人',
    pinyin: 'fùzérén',
    word_type: 'Danh từ',
    meaning_vi: 'người phụ trách, người đứng đầu',
    examples: [
      { chinese: '请问谁是这个展会的现场负责人？我有重要的事情要反映。', pinyin: 'Qǐngwèn shéi shì zhè gè zhǎnhuì de xiànchǎng fùzérén? Wǒ yǒu zhòngyào de shìqing yào fǎnyìng.', meaning_vi: 'Xin hỏi ai là người phụ trách hiện trường của hội chợ triển lãm này? Tôi có việc quan trọng cần phản ánh.', difficulty_level: 'basic' },
      { chinese: '各业务部门负责人应在每月初定期向执行董事会提交详细的工作进度汇报及风险评估报告。', pinyin: 'Gè yèwù bùmén fùzérén yīng zài měi yuèchū dìngqī xiàng zhíxíng dǒngshìhuì tíjiāo xiángxì de gōngzuò jìndù huìbào jí fēngxiǎn pínggū bàogào.', meaning_vi: 'Người phụ trách các bộ phận kinh doanh cần định kỳ nộp báo cáo tiến độ công việc chi tiết và báo cáo đánh giá rủi ro lên Hội đồng quản trị điều hành vào đầu mỗi tháng.', difficulty_level: 'applied' }
    ]
  },
  // 1217. 父子
  {
    hanzi: '父子',
    pinyin: 'fùzǐ',
    word_type: 'Danh từ',
    meaning_vi: 'cha và con trai, bố con trai',
    examples: [
      { chinese: '星期天下午，他们父子俩常常在小区的球场上一起踢足球。', pinyin: 'Xīngqītiān xiàwǔ, tāmen fùzǐ liǎ chángcháng zài xiǎoqū de qiúchǎng shang yìqǐ tī zúqiú.', meaning_vi: 'Chiều Chủ nhật, hai cha con họ thường cùng nhau đá bóng trên sân bóng khu chung cư.', difficulty_level: 'basic' },
      { chinese: '经过多年并肩创业打拼，这对父子不仅把家族传统手工艺作坊成功打造成了现代化驰名企业，还建立了深厚的信任。', pinyin: 'Jīngguò duō nián bìngjiān chuàngyè dǎpīn, zhè duì fùzǐ bùjǐn bǎ jiāzú chuántǒng shǒugōngyì zuòfang chénggōng dǎzào chéng le xiàndàihuà chímíng qǐyè, hái jiànlì le shēnhòu de xìnrèn.', meaning_vi: 'Trải qua nhiều năm kề vai sát cánh khởi nghiệp bươn chải, hai cha con này không những xây dựng thành công xưởng thủ công truyền thống của gia tộc thành doanh nghiệp nức tiếng hiện đại, mà còn gây dựng được niềm tin sâu sắc.', difficulty_level: 'applied' }
    ]
  },
  // 1218. 改
  {
    hanzi: '改',
    pinyin: 'gǎi',
    word_type: 'Động từ',
    meaning_vi: 'sửa, thay đổi, đổi sang',
    examples: [
      { chinese: '因为突然下大雨，原定今天下午的户外活动改到了明天进行。', pinyin: 'Yīnwèi tūrán xià dàyǔ, yuándìng jīntiān xiàwǔ de hùwài huódòng gǎi dào le míngtiān jìnxíng.', meaning_vi: 'Do trời bất ngờ đổ mưa to, hoạt động ngoài trời dự kiến chiều nay đã được đổi sang tiến hành vào ngày mai.', difficulty_level: 'basic' },
      { chinese: '作者根据特邀审稿专家的建设性修改意见，对学术论文的核心论证部分进行了大幅修改与完善。', pinyin: 'Zuòzhě gēnjù tèyāo shěngǎo zhuānjiā de jiànshèxìng xiūgǎi yìjiàn, duì xuéshù lùnwén de héxīn lùnzhèng bùfen jìnxíng le dàfú xiūgǎi yǔ wánshàn.', meaning_vi: 'Tác giả dựa theo các ý kiến sửa đổi mang tính xây dựng của chuyên gia thẩm định đặc biệt để tiến hành sửa đổi và hoàn thiện đáng kể phần lập luận cốt lõi của luận văn học thuật.', difficulty_level: 'applied' }
    ]
  },
  // 1219. 改变
  {
    hanzi: '改变',
    pinyin: 'gǎibiàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'thay đổi, chuyển biến',
    examples: [
      { chinese: '移动互联网的飞速普及彻底改变了人们的日常生活习惯。', pinyin: 'Yídòng hùliánwǎng de fēisù pǔjí chèdǐ gǎibiàn le rénmen de rìcháng shēnghuó xíguàn.', meaning_vi: 'Sự phổ cập thần tốc của internet di động đã thay đổi hoàn toàn thói quen sinh hoạt hàng ngày của con người.', difficulty_level: 'basic' },
      { chinese: '在这个知识爆炸与人工智能时代，唯有坚持终身学习才能积极应对环境变化并改变个人职业发展轨迹。', pinyin: 'Zài zhè gè zhīshi bàozhà yǔ réngōng zhìnéng shídài, wéiyǒu jiānchí zhōngshēn xuéxí cái néng jījí yìngduì huánjìng biànhuà bìng gǎibiàn gèrén zhíyè fāzhǎn guǐjì.', meaning_vi: 'Trong thời đại bùng nổ tri thức và trí tuệ nhân tạo này, chỉ có kiên trì học tập suốt đời mới có thể chủ động thích ứng với biến chuyển môi trường và thay đổi quỹ đạo phát triển nghề nghiệp cá nhân.', difficulty_level: 'applied' }
    ]
  },
  // 1220. 干
  {
    hanzi: '干',
    pinyin: 'gān',
    word_type: 'Tính từ',
    meaning_vi: 'khô, cạn, ráo',
    examples: [
      { chinese: '今天天气晴朗而且风很大，挂在阳台上的衣服很快就晒干了。', pinyin: 'Jīntiān tiānqì qínglǎng érqiě fēng hěn dà, guà zài yángtái shang de yīfu hěn kuài jiù shài gān le.', meaning_vi: 'Hôm nay thời tiết nắng ráo lại có gió to, quần áo phơi ngoài ban công rất nhanh đã khô rồi.', difficulty_level: 'basic' },
      { chinese: '北方冬季的气候十分干燥寒冷，室内通常需要开启加湿器以缓解皮肤干裂和呼吸道不适。', pinyin: 'Běifāng dōngjì de qìhòu shífēn gānzào hánlěng, shìnèi tōngcháng xūyào kāiqǐ jiāshīqì yǐ huǎnjiě pífū gānliè hé hūxīdào bùshì.', meaning_vi: 'Khí hậu mùa đông ở miền Bắc vô cùng khô hanh và lạnh giá, trong phòng thường cần bật máy tạo ẩm để làm dịu tình trạng nứt nẻ da và khó chịu đường hô hấp.', difficulty_level: 'applied' }
    ]
  },
  // 1221. 干杯
  {
    hanzi: '干杯',
    pinyin: 'gānbēi',
    word_type: 'Động từ',
    meaning_vi: 'cạn ly, cụng ly, chúc mừng (cheers)',
    examples: [
      { chinese: '为了庆祝你顺利通过HSK考试，让我们一起举杯干杯！', pinyin: 'Wèile qìngzhù nǐ shùnlì tōngguò HSK kǎoshì, ràng wǒmen yìqǐ jǔbēi gānbēi!', meaning_vi: 'Để chúc mừng bạn vượt qua kỳ thi HSK thuận lợi, chúng ta hãy cùng nâng ly cạn chén!', difficulty_level: 'basic' },
      { chinese: '在隆重热烈的年终晚宴上，公司董事长向全体辛勤付出的员工敬酒干杯并致以最诚挚的新春祝福。', pinyin: 'Zài lóngzhòng rèliè de niánzhōng wǎnyàn shang, gōngsī dǒngshìzhǎng xiàng quántǐ xīnqín fùchū de yuángōng jìngjiǔ gānbēi bìng zhì yǐ zuì chéngzhì de xīnchūn zhùfú.', meaning_vi: 'Trong buổi tiệc tất niên trang trọng và ấm cúng, Chủ tịch hội đồng quản trị công ty đã nâng ly cụng chén chúc rượu toàn thể nhân viên đã cống hiến hết mình và gửi lời chúc mừng năm mới chân thành nhất.', difficulty_level: 'applied' }
    ]
  },
  // 1222. 赶
  {
    hanzi: '赶',
    pinyin: 'gǎn',
    word_type: 'Động từ',
    meaning_vi: 'đuổi theo, vội vã, chạy đua (thời gian, tiến độ)',
    examples: [
      { chinese: '你起得太晚了，现在得赶紧跑去地铁站才能赶上早班车。', pinyin: 'Nǐ qǐ de tài wǎn le, xiànzài děi gǎnjǐn pǎo qù dìtiězhàn cái néng gǎnshang zǎobānchē.', meaning_vi: 'Bạn dậy muộn quá rồi, bây giờ phải vội vàng chạy ra ga tàu điện ngầm mới kịp chuyến xe sớm.', difficulty_level: 'basic' },
      { chinese: '为了在客户规定的截止日期前完成项目交付，全体工程师连续加班加点赶工期。', pinyin: 'Wèile zài kèhù guīdìng de jiézhǐ rìqī qián wánchéng xiàngmù jiāofù, quántǐ gōngchéngshī liánxù jiābān-jiādiǎn gǎn gōngqī.', meaning_vi: 'Để hoàn thành bàn giao dự án trước thời hạn chót khách hàng quy định, toàn thể kỹ sư đã liên tục tăng ca dồn sức chạy đua với tiến độ công trình.', difficulty_level: 'applied' }
    ]
  },
  // 1223. 敢
  {
    hanzi: '敢',
    pinyin: 'gǎn',
    word_type: 'Động từ năng nguyện',
    meaning_vi: 'dám',
    examples: [
      { chinese: '他性格比较内向害羞，在公共场合不敢当众公开发言。', pinyin: 'Tā xìnggé bǐjiào nèixiàng hàixiū, zài gōnggòng chǎnghé bù gǎn dāngzhòng gōngkāi fāyán.', meaning_vi: 'Tính tình anh ấy khá hướng nội e thẹn, ở nơi công cộng không dám phát biểu công khai trước đám đông.', difficulty_level: 'basic' },
      { chinese: '真正的创新者要有敢为人先的开拓魄力，敢于跳出固有思维框架尝试未经检验的全新路径。', pinyin: 'Zhēnzhèng de chuàngxīnzhě yào yǒu gǎnwéirénxiān de kāituò pòlì, gǎnyú tiàochū gùyǒu sīwéi kuàngjià chángshì wèijīng jiǎnyàn de quánxīn lùjìng.', meaning_vi: 'Người đổi mới sáng tạo thực sự cần có khí phách dám đi tiên phong, dám bứt phá khỏi khuôn khổ tư duy lối mòn để thử nghiệm những lộ trình hoàn toàn mới chưa từng qua kiểm chứng.', difficulty_level: 'applied' }
    ]
  },
  // 1224. 感
  {
    hanzi: '感',
    pinyin: 'gǎn',
    word_type: 'Hậu tố / Động từ',
    meaning_vi: 'cảm giác, cảm thấy, ý thức (trách nhiệm, thành tựu)',
    examples: [
      { chinese: '圆满完成这项艰巨的任务后，他内心油然而生一种强烈的自豪感。', pinyin: 'Yuánmǎn wánchéng zhè xiàng jiānjù de rènwu hòu, tā nèixīn yóurán’érshēng yì zhǒng qiángliè de zìháogǎn.', meaning_vi: 'Sau khi hoàn thành viên mãn nhiệm vụ gian truân này, trong lòng anh ấy dâng trào một cảm giác tự hào mạnh mẽ.', difficulty_level: 'basic' },
      { chinese: '卓越的领导者善于培养团队成员的归属感与使命感，激发大家为共同战略目标而拼搏。', pinyin: 'Zhuóyuè de lǐngdǎozhě shànyú péiyǎng tuánduì chéngyuán de guīshǔgǎn yǔ shǐmìnggǎn, jīfā dàjiā wèi gòngtóng zhànlüè mùbiāo ér pīnbó.', meaning_vi: 'Người lãnh đạo kiệt xuất rất giỏi vun đắp cảm giác thuộc về tập thể và ý thức sứ mệnh cho các thành viên, khích lệ mọi người cùng dốc sức phấn đấu vì mục tiêu chiến lược chung.', difficulty_level: 'applied' }
    ]
  },
  // 1225. 感动
  {
    hanzi: '感动',
    pinyin: 'gǎndòng',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'cảm động, xúc động; làm xúc động',
    examples: [
      { chinese: '听到朋友们为他精心准备的生日祝福，他感动得热泪盈眶。', pinyin: 'Tīng dào péngyoumen wèi tā jīngxīn zhǔnbèi de shēngrì zhùfú, tā gǎndòng de rèlèi-yíngkuàng.', meaning_vi: 'Nghe những lời chúc sinh nhật bạn bè đã dày công chuẩn bị cho mình, anh ấy xúc động đến rơm rớm nước mắt.', difficulty_level: 'basic' },
      { chinese: '支教老师扎根偏远山区十几年默默奉献的感人事迹，深深感动了全社会的无数公众。', pinyin: 'Zhījiào lǎoshī zhāgēn piānyuǎn shānqū shí jǐ nián mòmò fèngxiàn de gǎnrén shìjì, shēnshēn gǎndòng le quán shèhuì de wúshù gōngzhòng.', meaning_vi: 'Hành động xúc động của người giáo viên tình nguyện gắn bó cống hiến thầm lặng hơn mười năm nơi vùng núi hẻo lánh đã làm rung động sâu sắc vô số người dân trong toàn xã hội.', difficulty_level: 'applied' }
    ]
  },

  // 1226. 赶紧
  {
    hanzi: '赶紧',
    pinyin: 'gǎnjǐn',
    word_type: 'Phó từ',
    meaning_vi: 'mau chóng, gấp rút, nhanh chóng',
    examples: [
      { chinese: '天快要下暴雨了，你赶紧把晾在外面的衣服收进来。', pinyin: 'Tiān kuài yào xià bàoyǔ le, nǐ gǎnjǐn bǎ liàng zài wàimiàn de yīfu shōu jìnlái.', meaning_vi: 'Trời sắp đổ mưa to rồi, bạn mau chóng thu quần áo đang phơi ngoài trời vào đi.', difficulty_level: 'basic' },
      { chinese: '发现线上系统出现数据异常漏洞后，技术运维团队赶紧启动了最高级别应急修复预案。', pinyin: 'Fāxiàn xiànshàng xìtǒng chūxiàn shùjù yìcháng lòudòng hòu, jìshù yùnwéi tuánduì gǎnjǐn qǐdòng le zuì gāo jíbié yìngjí xiūfù yù’àn.', meaning_vi: 'Sau khi phát hiện hệ thống trực tuyến có lỗ hổng dữ liệu bất thường, đội ngũ vận hành kỹ thuật đã gấp rút kích hoạt phương án sửa chữa khẩn cấp cấp độ cao nhất.', difficulty_level: 'applied' }
    ]
  },
  // 1227. 感觉
  {
    hanzi: '感觉',
    pinyin: 'gǎnjué',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'cảm giác; cảm thấy',
    examples: [
      { chinese: '吃完感冒药并睡了一觉之后，我感觉身体轻松多了。', pinyin: 'Chī wán gǎnmàoyào bìng shuì le yí jiào zhīhòu, wǒ gǎnjué shēntǐ qīngsōng duō le.', meaning_vi: 'Sau khi uống thuốc cảm và ngủ một giấc, tôi cảm thấy cơ thể nhẹ nhõm hơn nhiều.', difficulty_level: 'basic' },
      { chinese: '这家科技旗舰店的室内空间设计极具未来感，带给进店顾客极其舒适惬意的沉浸式体验。', pinyin: 'Zhè jiā kējì qíjiàndiàn de shìnèi kōngjiān shèjì jí jù wèiláigǎn, dài gěi jìn diàn gùkè jíqí shūshì qièyì de chénjìnshì tǐyàn.', meaning_vi: 'Thiết kế không gian nội thất của cửa hàng công nghệ cao này đậm chất tương lai, mang lại cho khách hàng bước vào cảm giác trải nghiệm đắm chìm vô cùng thoải mái và dễ chịu.', difficulty_level: 'applied' }
    ]
  },
  // 1228. 赶快
  {
    hanzi: '赶快',
    pinyin: 'gǎnkuài',
    word_type: 'Phó từ',
    meaning_vi: 'nhanh chóng, khẩn trương',
    examples: [
      { chinese: '电影马上就要开场了，我们赶快检票进放映厅吧。', pinyin: 'Diànyǐng mǎshàng jiù yào kāichǎng le, wǒmen gǎnkuài jiǎnpiào jìn fàngyìngtīng ba.', meaning_vi: 'Bộ phim sắp sửa chiếu rồi, chúng ta nhanh chóng soát vé vào rạp chiếu thôi.', difficulty_level: 'basic' },
      { chinese: '新政策出台后的政策红利期非常短暂，企业必须赶快调整产品战略以抢占市场先机。', pinyin: 'Xīn zhèngcè chūtái hòu de zhèngcè hónglì qī fēicháng duǎnzàn, qǐyè bìxū gǎnkuài tiáozhěng chǎnpǐn zhànlüè yǐ qiǎngzhàn shìchǎng xiānjī.', meaning_vi: 'Giai đoạn hưởng lợi chính sách sau khi quy định mới ban hành rất ngắn ngủi, doanh nghiệp phải khẩn trương điều chỉnh chiến lược sản phẩm để chớp lấy thời cơ thị trường.', difficulty_level: 'applied' }
    ]
  },
  // 1229. 感情
  {
    hanzi: '感情',
    pinyin: 'gǎnqíng',
    word_type: 'Danh từ',
    meaning_vi: 'tình cảm, cảm xúc',
    examples: [
      { chinese: '他们两人从小一起长大，彼此之间的感情深厚如亲兄弟。', pinyin: 'Tāmen liǎng rén cóngxiǎo yìqǐ zhǎngdà, bǐcǐ zhījiān de gǎnqíng shēnhòu rú qīn xiōngdì.', meaning_vi: 'Hai người họ từ nhỏ cùng lớn lên với nhau, tình cảm gắn bó giữa họ sâu nặng như anh em ruột.', difficulty_level: 'basic' },
      { chinese: '在商业谈判中既要以专业理性的数据为基准，也要注重顾及双方长期建立的合作感情与互信。', pinyin: 'Zài shāngyè tánpàn zhōng jì yào yǐ zhuānyè lǐxìng de shùjù wéi jīzhǔn, yě yào zhùzhòng gùjí shuāngfāng chángqī jiànlì de hézuò gǎnqíng yǔ hùxìn.', meaning_vi: 'Trong đàm phán thương mại vừa cần lấy số liệu lý tính chuyên nghiệp làm chuẩn tắc, vừa cần chú trọng bồi đắp tình cảm hợp tác và sự tin tưởng lẫn nhau đã xây dựng lâu dài giữa hai bên.', difficulty_level: 'applied' }
    ]
  },
  // 1230. 感人
  {
    hanzi: '感人',
    pinyin: 'gǎnrén',
    word_type: 'Tính từ',
    meaning_vi: 'cảm động, truyền cảm hứng',
    examples: [
      { chinese: '这部电影讲述了一个十分感人的关于亲情守护的故事。', pinyin: 'Zhè bù diànyǐng jiǎngshù le yí gè shífēn gǎnrén de guānyú qīnqíng shǒuhù de gùshi.', meaning_vi: 'Bộ phim này kể về một câu chuyện hết sức cảm động xoay quanh sự chở che của tình thân gia đình.', difficulty_level: 'basic' },
      { chinese: '他在毕业典礼上发表了一篇真情实感、极具感染力的感人演讲，赢得全场师生雷鸣般的掌声。', pinyin: 'Tā zài bìyè diǎnlǐ shang fābiǎo le yì piān zhēnqíng-shígǎn, jí jù gǎnrǎnlì de gǎnrén yǎnjiǎng, yíngdé quánchǎng shīshēng léimíng bān de zhǎngshēng.', meaning_vi: 'Anh ấy đã có một bài phát biểu cảm động đầy ắp chân tình và sức lan tỏa mạnh mẽ trong lễ tốt nghiệp, giành được tràng pháo tay giòn giã như sấm của toàn thể thầy trò.', difficulty_level: 'applied' }
    ]
  },
  // 1231. 赶上
  {
    hanzi: '赶上',
    pinyin: 'gǎnshàng',
    word_type: 'Động từ',
    meaning_vi: 'đuổi kịp, bắt kịp; gặp dịp, rơi vào dịp',
    examples: [
      { chinese: '路上虽然堵车严重，但他跑步前进，终于还是赶上了航班登机。', pinyin: 'Lùshang suīrán dǔchē yánzhòng, dàn tā pǎobù qiánjìn, zhōngyú hái shì gǎnshàng le hángbān dēngjī.', meaning_vi: 'Dọc đường tuy tắc đường nghiêm trọng nhưng anh ấy đã chạy bộ tới, cuối cùng vẫn kịp giờ lên máy bay.', difficulty_level: 'basic' },
      { chinese: '中国新能源汽车产业抓住了技术变革的关键机遇，在核心电池与智能驾驶领域已经成功赶上甚至超越了国际前列。', pinyin: 'Zhōngguó xīnnéngyuán qìchē chǎnyè zhuāzhù le jìshù biàngé de guānjiàn jīyù, zài héxīn diànchí yǔ zhìnéng jiàshǐ lǐngyù yǐjīng chénggōng gǎnshàng shènzhì chāoyuè le guójì qiánliè.', meaning_vi: 'Ngành công nghiệp ô tô năng lượng mới của Trung Quốc đã nắm bắt cơ hội then chốt của đổi mới công nghệ, thành công bắt kịp thậm chí vượt lên hàng đầu quốc tế trong lĩnh vực pin cốt lõi và lái tự động.', difficulty_level: 'applied' }
    ]
  },
  // 1232. 感受
  {
    hanzi: '感受',
    pinyin: 'gǎnshòu',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'cảm nhận, trải nghiệm; cảm nghĩ',
    examples: [
      { chinese: '来到这座历史文化名城，能切身感受到浓厚深沉的古老韵味。', pinyin: 'Lái dào zhè zuò lìshǐ wénhuà míngchéng, néng qièshēn gǎnshòu dào nónghòu shēnchén de gǔlǎo yùnwèi.', meaning_vi: 'Đến với thành phố danh tiếng lịch sử văn hóa này, người ta có thể đích thân cảm nhận được phong vị cổ xưa trầm mặc đậm đà.', difficulty_level: 'basic' },
      { chinese: '产品经理必须经常站在终端真实用户的视角去换位思考，深刻体会并照顾使用者的切身感受。', pinyin: 'Chǎnpǐn jīnglǐ bìxū chángcháng zhàn zài zhōngduān zhēnshí yònghù de shìjiǎo qù huànwèi sīkǎo, shēnkè tǐhuì bìng zhàogù shǐyòngzhě de qièshēn gǎnshòu.', meaning_vi: 'Giám đốc sản phẩm cần thường xuyên đứng ở góc nhìn của người dùng thực tế cuối cùng để đổi vị trí suy nghĩ, thấu hiểu sâu sắc và quan tâm đến cảm nhận trực tiếp của người sử dụng.', difficulty_level: 'applied' }
    ]
  },
  // 1233. 感谢
  {
    hanzi: '感谢',
    pinyin: 'gǎnxiè',
    word_type: 'Động từ',
    meaning_vi: 'cảm ơn, tri ân, biết ơn',
    examples: [
      { chinese: '非常感谢您在过去一年里对我工作的大力支持与热心帮助。', pinyin: 'Fēicháng gǎnxiè nín zài guòqù yì nián lǐ duì wǒ gōngzuò de dàlì zhīchí yǔ rèxīn bāngzhù.', meaning_vi: 'Vô cùng cảm ơn anh đã hết lòng ủng hộ và nhiệt tình giúp đỡ công việc của tôi trong suốt một năm qua.', difficulty_level: 'basic' },
      { chinese: '借此公司成立十周年庆典之际，我们向所有长期风雨同舟的战略合作伙伴致以最诚挚的感谢。', pinyin: 'Jiè cǐ gōngsī chénglì shí zhōunián qìngdiǎn zhī jì, wǒmen xiàng suǒyǒu chángqī fēngyǔ-tóngzhōu de zhànlüè hézuò huǒbàn zhì yǐ zuì chéngzhì de gǎnxiè.', meaning_vi: 'Nhân dịp đại lễ kỷ niệm mười năm thành lập công ty lần này, chúng tôi xin gửi lời cảm ơn chân thành sâu sắc nhất tới toàn thể đối tác chiến lược đã cùng kề vai vượt khó suốt thời gian qua.', difficulty_level: 'applied' }
    ]
  },
  // 1234. 干活儿
  {
    hanzi: '干活儿',
    pinyin: 'gànhuór',
    word_type: 'Động từ',
    meaning_vi: 'làm việc, làm lụng việc tay chân',
    examples: [
      { chinese: '工人们一大早就顶着朝阳在建筑工地上忙碌地干活儿了。', pinyin: 'Gōngrénmen yí dà zǎo jiù dǐng zhe zhāoyáng zài jiànzhù gōngdì shang mánglù de gànhuór le.', meaning_vi: 'Các công nhân từ sáng sớm tinh mơ đã đón ánh ban mai bận rộn làm việc trên công trường xây dựng.', difficulty_level: 'basic' },
      { chinese: '他为人踏实稳重，在车间一线干活儿总是手脚麻利且精益求精，多次荣获年度劳模称号。', pinyin: 'Tā wéirén tāshi wěnzhòng, zài chējiān yīxiàn gànhuór zǒngshì shǒujiǎo máli qiě jīngyìqiújīng, duō cì rónghuò niándù láomó chēnghào.', meaning_vi: 'Anh ấy làm người chắc chắn vững vàng, làm việc trực tiếp nơi tuyến đầu phân xưởng luôn thoăn thoắt khéo léo và không ngừng cầu toàn, nhiều lần đạt danh hiệu lao động tiên tiến của năm.', difficulty_level: 'applied' }
    ]
  },
  // 1235. 钢琴
  {
    hanzi: '钢琴',
    pinyin: 'gāngqín',
    word_type: 'Danh từ',
    meaning_vi: 'đàn piano, dương cầm',
    examples: [
      { chinese: '妹妹从六岁起就开始坚持每天练习弹钢琴。', pinyin: 'Mèimei cóng liù suì qǐ jiù kāishǐ jiānchí měitiān liànxí tán gāngqín.', meaning_vi: 'Em gái từ lúc sáu tuổi đã bắt đầu kiên trì luyện tập đánh đàn piano mỗi ngày.', difficulty_level: 'basic' },
      { chinese: '这位青年演奏家在维也纳音乐金色大厅成功举办了独奏音乐会，黑白钢琴键盘在他指尖流淌出天籁之音。', pinyin: 'Zhè wèi qīngnián yǎnzòujiā zài Wéiyěnà yīnyuè Jīnsè Dàtīng chénggōng jǔbàn le dúzòu yīnyuèhuì, hēibái gāngqín jiànpán zài tā zhǐjiān liútǎng chū tiānlài zhī yīn.', meaning_vi: 'Nghệ sĩ biểu diễn trẻ tuổi này đã tổ chức thành công buổi hòa nhạc độc tấu tại Phòng hòa nhạc Vàng Vienna, từng phím đàn piano đen trắng dưới ngón tay anh tuôn trào những âm thanh tuyệt diệu.', difficulty_level: 'applied' }
    ]
  },
  // 1236. 高价
  {
    hanzi: '高价',
    pinyin: 'gāojià',
    word_type: 'Danh từ',
    meaning_vi: 'giá cao, giá đắt đỏ',
    examples: [
      { chinese: '节假日旅游旺季期间，热门景区的酒店常常开出极高的高价。', pinyin: 'Jiéjiàrì lǚyóu wàngjì qījiān, rèmén jǐngqū de jiǔdiàn chángcháng kāi chū jí gāo de gāojià.', meaning_vi: 'Trong mùa cao điểm du lịch dịp lễ tết, các khách sạn tại khu thắng cảnh nổi tiếng thường đưa ra mức giá rất cao.', difficulty_level: 'basic' },
      { chinese: '尽管这家跨国制药企业为收购核心专利技术支付了不菲的高价，但从长远市场战略来看十分划算。', pinyin: 'Jǐnguǎn zhè jiā kuàguó zhìyào qǐyè wèi shōugòu héxīn zhuānlì jìshù zhīfù le bùfěi de gāojià, dàn cóng chángyuǎn shìchǎng zhànlüè lái kàn shífēn huásuàn.', meaning_vi: 'Dù cho doanh nghiệp dược phẩm đa quốc gia này phải trả mức giá rất cao để mua lại công nghệ sáng chế cốt lõi, nhưng xét từ chiến lược thị trường lâu dài thì vô cùng xứng đáng.', difficulty_level: 'applied' }
    ]
  },
  // 1237. 高考
  {
    hanzi: '高考',
    pinyin: 'gāokǎo',
    word_type: 'Danh từ',
    meaning_vi: 'kỳ thi tuyển sinh đại học (gaokao)',
    examples: [
      { chinese: '高三同学们正在争分夺秒地复习，准备迎接即将到来的全国高考。', pinyin: 'Gāosān tóngxuémen zhèngzài zhēngfēn-duómiǎo de fùxí, zhǔnbèi yíngjiē jíjiāng dàolái de quánguó gāokǎo.', meaning_vi: 'Các bạn học sinh lớp 12 đang tranh thủ từng phút từng giây ôn tập chuẩn bị nghênh đón kỳ thi tuyển sinh đại học toàn quốc sắp tới.', difficulty_level: 'basic' },
      { chinese: '高考不仅是检验高中阶段学业知识的决定性考试，更是锤炼青少年心理素质与意志毅力的重要人生节点。', pinyin: 'Gāokǎo bùjǐn shì jiǎnyàn gāozhōng jiēduàn xuéyè zhīshi de juédìngxìng kǎoshì, gèng shì chuíliàn qīngshàonián xīnlǐ sùzhì yǔ yìzhì yìlì de zhòngyào rénshēng jiédiǎn.', meaning_vi: 'Kỳ thi đại học không chỉ là bài kiểm tra mang tính quyết định đo lường kiến thức học tập bậc THPT, mà còn là mốc son cuộc đời quan trọng tôi luyện tố chất tâm lý và ý chí kiên định của tuổi trẻ.', difficulty_level: 'applied' }
    ]
  },
  // 1238. 高速
  {
    hanzi: '高速',
    pinyin: 'gāosù',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'tốc độ cao; đường cao tốc (gọi tắt của 高速公路)',
    examples: [
      { chinese: '上了高速公路以后，汽车行驶的速度就明显快多了。', pinyin: 'Shàng le gāosù gōnglù yǐhòu, qìchē xíngshǐ de sùdù jiù míngxiǎn kuài duō le.', meaning_vi: 'Sau khi lên đường cao tốc, tốc độ lưu thông của xe ô tô nhanh hơn trông thấy.', difficulty_level: 'basic' },
      { chinese: '随着新一代高速宽带与5G通信技术的全面覆盖，远程数字办公与高清流媒体传输变得前所未有的流畅。', pinyin: 'Suízhe xīn yídài gāosù kuāndài yǔ wǔ-G tōngxìn jìshù de quánmiàn fùgài, yuǎnchéng shùzì bàngōng yǔ gāoqīng liúméitǐ chuānshū biàn de qiánsuǒwèiyǒu de liúchàng.', meaning_vi: 'Cùng với sự phủ sóng toàn diện của mạng băng thông rộng tốc độ cao thế hệ mới và công nghệ truyền thông 5G, làm việc kỹ thuật số từ xa và truyền phát đa phương tiện độ nét cao đã trở nên mượt mà chưa từng có.', difficulty_level: 'applied' }
    ]
  },
  // 1239. 高温
  {
    hanzi: '高温',
    pinyin: 'gāowēn',
    word_type: 'Danh từ',
    meaning_vi: 'nhiệt độ cao, thời tiết nắng nóng gay gắt',
    examples: [
      { chinese: '气象台今天发布了红色高温预警，户外气温高达四十度。', pinyin: 'Qìxiàngtái jīntiān fābù le hóngsè gāowēn yùjǐng, hùwài qìwēn gāo dá sìshí dù.', meaning_vi: 'Đài khí tượng hôm nay đã phát cảnh báo nhiệt độ cao cấp độ màu đỏ, nhiệt độ ngoài trời lên tới bốn mươi độ C.', difficulty_level: 'basic' },
      { chinese: '在持续极端高温酷暑天气下，工厂管理部门应当合理缩短户外露天作业时长并为职工发放防暑降温物资。', pinyin: 'Zài chíxù jíduān gāowēn kùshǔ tiānqì xià, gōngchǎng guǎnlǐ bùmén yīngdāng hélǐ suōduǎn hùwài lùtiān zuòyè shícháng bìng wèi zhígōng fāfàng fángshǔ jiàngwēn wùzī.', meaning_vi: 'Dưới thời tiết nắng nóng gay gắt cực đoan kéo dài, bộ phận quản lý nhà máy cần rút ngắn thời gian làm việc ngoài trời một cách hợp lý và phát đồ bảo hộ phòng chống say nắng cho công nhân viên.', difficulty_level: 'applied' }
    ]
  },
  // 1240. 高于
  {
    hanzi: '高于',
    pinyin: 'gāoyú',
    word_type: 'Động từ',
    meaning_vi: 'cao hơn',
    examples: [
      { chinese: '今年公司的销售额明显高于去年同期的水平。', pinyin: 'Jīnnián gōngsī de xiāoshòu’é míngxiǎn gāoyú qùnián tóngqī de shuǐpíng.', meaning_vi: 'Doanh số bán hàng năm nay của công ty cao hơn rõ rệt so với mức cùng kỳ năm ngoái.', difficulty_level: 'basic' },
      { chinese: '科技创新型企业的研发投入占总营业收入比重，往往显著高于传统劳动密集型制造行业。', pinyin: 'Kējì chuàngxīnxíng qǐyè de yánfā tóurù zhàn zǒng yíngyè shōurù bǐzhòng, wǎngwǎng xiǎnzhù gāoyú chuántǒng láodòng mìjíxíng zhìzàohángyè.', meaning_vi: 'Tỷ trọng đầu tư cho nghiên cứu phát triển trên tổng doanh thu hoạt động của doanh nghiệp đổi mới công nghệ thường cao hơn rõ rệt so với ngành sản xuất thâm dụng lao động truyền thống.', difficulty_level: 'applied' }
    ]
  },
  // 1241. 胳膊
  {
    hanzi: '胳膊',
    pinyin: 'gēbo',
    word_type: 'Danh từ',
    meaning_vi: 'cánh tay',
    examples: [
      { chinese: '他昨天打篮球时不小心摔倒，扭伤了左胳膊。', pinyin: 'Tā zuótiān dǎ lánqiú shí bù xiǎoxīn shuāidǎo, niǔshāng le zuǒ gēbo.', meaning_vi: 'Hôm qua khi chơi bóng rổ anh ấy sơ ý ngã, bị trật khớp cánh tay trái.', difficulty_level: 'basic' },
      { chinese: '医生在仔细检查并拍摄X光片后确认他的右胳膊只是肌肉拉伤，骨骼并未发生骨折，只需静养两周。', pinyin: 'Yīshēng zài zǐxì jiǎnchá bìng pāishè X-guāng piàn hòu quèrèn tā de yòu gēbo zhǐ shì jīròu lāshāng, gǔgé bìng wèi fāshēng gǔzhé, zhǐ xū jìngyǎng liǎng zhōu.', meaning_vi: 'Bác sĩ sau khi khám kỹ lưỡng và chụp X-quang xác nhận cánh tay phải của anh ấy chỉ bị căng cơ, xương cốt không hề rạn gãy, chỉ cần nghỉ ngơi dưỡng sức hai tuần.', difficulty_level: 'applied' }
    ]
  },
  // 1242. 歌声
  {
    hanzi: '歌声',
    pinyin: 'gēshēng',
    word_type: 'Danh từ',
    meaning_vi: 'tiếng hát, tiếng ca',
    examples: [
      { chinese: '从邻居家飘来一阵悠扬动听的歌声。', pinyin: 'Cóng línjū jiā piāo lái yí zhèn yōuyáng dòngtīng de gēshēng.', meaning_vi: 'Từ nhà người hàng xóm thoảng bay tới một làn điệu tiếng hát du dương êm tai.', difficulty_level: 'basic' },
      { chinese: '当舞台灯光缓缓暗下，深情婉转的歌声在现代化音乐厅穹顶回荡，令全场数千名听众如痴如醉。', pinyin: 'Dāng wǔtái dēngguāng huǎnhuǎn àn xià, shēnqíng wǎnzhuǎn de gēshēng zài xiàndàihuà yīnyuètīng qióngdǐng huídàng, lìng quánchǎng shù qiān míng tīngzhòng rúchī-rúzuì.', meaning_vi: 'Khi ánh đèn sân khấu từ từ dịu xuống, tiếng hát trầm bổng da diết vang vọng dưới vòm sảnh hòa nhạc hiện đại, làm say đắm hàng nghìn thính giả có mặt trong khán phòng.', difficulty_level: 'applied' }
    ]
  },
  // 1243. 歌手
  {
    hanzi: '歌手',
    pinyin: 'gēshǒu',
    word_type: 'Danh từ',
    meaning_vi: 'ca sĩ',
    examples: [
      { chinese: '她是一位非常有才华的新人原创流行歌手。', pinyin: 'Tā shì yí wèi fēicháng yǒu cáihuá de xīnrén yuánchuàng liúxíng gēshǒu.', meaning_vi: 'Cô ấy là một nữ ca sĩ nhạc pop trẻ tuổi đầy tài năng kiêm sáng tác.', difficulty_level: 'basic' },
      { chinese: '这位实力派独立歌手凭借卓越的唱功和深刻的词曲创作，荣获了本届华语流行音乐金曲大奖。', pinyin: 'Zhè wèi shílìpài dúlì gēshǒu píngjiè zhuóyuè de chànggōng hé shēnkè de cíqǔ chuàngzuò, rónghuò le běn jiè Huáyǔ liúxíng yīnyuè Jīnqǔ dàjiǎng.', meaning_vi: 'Ca sĩ độc lập trường phái thực lực này nhờ vào kỹ thuật thanh nhạc xuất sắc cùng khả năng sáng tác ca từ sâu lắng đã vinh dự giành giải thưởng Ca khúc Vàng nhạc Pop Hoa ngữ kỳ này.', difficulty_level: 'applied' }
    ]
  },
  // 1244. 各
  {
    hanzi: '各',
    pinyin: 'gè',
    word_type: 'Đại từ / Phó từ',
    meaning_vi: 'các, mỗi (các giới, mỗi bên)',
    examples: [
      { chinese: '大家各抒己见，会议室里的讨论气氛非常热烈。', pinyin: 'Dàjiā gèshū-jǐjiàn, huìyìshì lǐ de tǎolùn qìfēn fēicháng rèliè.', meaning_vi: 'Mọi người mỗi người một ý bày tỏ quan điểm riêng, không khí thảo luận trong phòng họp rất sôi nổi.', difficulty_level: 'basic' },
      { chinese: '在签署框架协议后，各合作方应根据合同细则严格履行各自承担的法定义务与投资责任。', pinyin: 'Zài qiānshǔ kuàngjià xiéyì hòu, gè hézuò fāng yīng gēnjù hétong xìzé yángé lǚxíng gèzì chéngdān de fǎdìng yiwù yǔ tóuzī zérèn.', meaning_vi: 'Sau khi ký kết thỏa thuận khung, các bên hợp tác cần căn cứ theo điều khoản hợp đồng thực hiện nghiêm ngặt các nghĩa vụ pháp lý và trách nhiệm đầu tư do mỗi bên đảm nhiệm.', difficulty_level: 'applied' }
    ]
  },
  // 1245. 各地
  {
    hanzi: '各地',
    pinyin: 'gèdì',
    word_type: 'Danh từ',
    meaning_vi: 'các nơi, khắp nơi, mọi miền',
    examples: [
      { chinese: '每年春天，来自全国各地的游客都会去武汉观赏樱花。', pinyin: 'Měi nián chūntiān, láizì quánguó gèdì de yóukè dōu huì qù Wǔhàn guānshǎng yīnghuā.', meaning_vi: 'Mỗi năm vào mùa xuân, du khách đến từ khắp mọi miền đất nước đều tới Vũ Hán để ngắm hoa anh đào.', difficulty_level: 'basic' },
      { chinese: '跨国电商物流网络的健全完善，使得世界各地的优质特色商品能够高效快捷地配送至普通消费者手中。', pinyin: 'Kuàguó diànshāng wùliú wǎngluò de jiànquán wánshàn, shǐde shìjiè gèdì de yōuzhì tèsè shāngpǐn nénggòu gāoxiào kuàijié de pèisòng zhì pǔtōng xiāofèizhě shǒuzhōng.', meaning_vi: 'Mạng lưới logistics thương mại điện tử xuyên biên giới hoàn thiện kiện toàn đã giúp các mặt hàng đặc sản chất lượng cao từ khắp nơi trên thế giới được giao đến tay người tiêu dùng bình dân một cách hiệu quả và mau chóng.', difficulty_level: 'applied' }
    ]
  },
  // 1246. 各个
  {
    hanzi: '各个',
    pinyin: 'gègè',
    word_type: 'Đại từ / Phó từ',
    meaning_vi: 'từng cái, mỗi một, các',
    examples: [
      { chinese: '老师逐一检查了各个小组提交的作业。', pinyin: 'Lǎoshī zhúyī jiǎnchá le gègè xiǎozǔ tíjiāo de zuòyè.', meaning_vi: 'Thầy giáo đã lần lượt kiểm tra bài tập nộp lên của từng nhóm một.', difficulty_level: 'basic' },
      { chinese: '在推进数字化转型的全流程中，企业必须对各个业务环节的数据安全隐患开展地毯式排查。', pinyin: 'Zài tuījìn shùzìhuà zhuǎnxíng de quán liúchéng zhōng, qǐyè bìxū duì gègè yèwù huánjié de shùjù ānquán yǐnhuàn kāizhǎn dìtǎnshì páichá.', meaning_vi: 'Trong toàn bộ quy trình đẩy mạnh chuyển đổi số, doanh nghiệp phải triển khai rà soát toàn diện từng mắt xích nghiệp vụ về những nguy cơ tiềm ẩn đối với an toàn dữ liệu.', difficulty_level: 'applied' }
    ]
  },
  // 1247. 各位
  {
    hanzi: '各位',
    pinyin: 'gèwèi',
    word_type: 'Đại từ',
    meaning_vi: 'các vị, quý vị, mọi người',
    examples: [
      { chinese: '各位来宾、各位朋友，大家晚上好！', pinyin: 'Gèwèi láibīn, gèwèi péngyou, dàjiā wǎnshang hǎo!', meaning_vi: 'Kính thưa quý vị quan khách, các bạn hữu, chúc mọi người một buổi tối tốt lành!', difficulty_level: 'basic' },
      { chinese: '各位与会代表在年度股东大会上就集团未来的全球并购战略展开了充分而深入的探讨。', pinyin: 'Gèwèi yùhuì dàibiǎo zài niándù gǔdōng dàhuì shang jiù jítuán wèilái de quánqiú bìnggòu zhànlüè zhānkāi le chōngfèn ér shēnrù de tàntǎo.', meaning_vi: 'Các đại biểu tham dự hội nghị tại Đại hội cổ đông thường niên đã tiến hành thảo luận đầy đủ và sâu sắc về chiến lược mua bán sáp nhập toàn cầu trong tương lai của tập đoàn.', difficulty_level: 'applied' }
    ]
  },
  // 1248. 各种
  {
    hanzi: '各种',
    pinyin: 'gèzhǒng',
    word_type: 'Đại từ',
    meaning_vi: 'các loại, đủ loại, các thứ',
    examples: [
      { chinese: '这家大型超市里摆满了各种各样的新鲜热带水果。', pinyin: 'Zhè jiā dàxíng chāoshì lǐ bǎi mǎn le gèzhǒng-gèyàng de xīnxiān rèdài shuǐguǒ.', meaning_vi: 'Trong siêu thị quy mô lớn này bày đầy đủ các loại hoa quả nhiệt đới tươi ngon.', difficulty_level: 'basic' },
      { chinese: '面对复杂市场环境中出现的各种不可预见风险，企业应当建立健全敏捷高效的危机应对机制。', pinyin: 'Miànduì fùzá shìchǎng huánjìng zhōng chūxiàn de gèzhǒng bùkě-yùjiàn fēngxiǎn, qǐyè yīngdāng jiànlì jiànquán mǐnjié gāoxiào de wēijī yìngduì jīzhì.', meaning_vi: 'Đối mặt với các loại rủi ro khôn lường xuất hiện trong môi trường thị trường phức tạp, doanh nghiệp cần thiết lập kiện toàn cơ chế phản ứng khủng hoảng linh hoạt và hiệu quả.', difficulty_level: 'applied' }
    ]
  },
  // 1249. 更加
  {
    hanzi: '更加',
    pinyin: 'gèngjiā',
    word_type: 'Phó từ',
    meaning_vi: 'càng, càng thêm, hơn nữa',
    examples: [
      { chinese: '经过几个月的刻苦锻炼，他的身体变得更加强壮健康了。', pinyin: 'Jīngguò jǐ gè yuè de kèkǔ duànliàn, tā de shēntǐ biàn de gèngjiā qiángzhuàng jiànkāng le.', meaning_vi: 'Trải qua mấy tháng khổ luyện, cơ thể của anh ấy đã trở nên cường tráng khỏe mạnh hơn hẳn.', difficulty_level: 'basic' },
      { chinese: '引入先进的人工智能算法后，该平台的数据检索与智能推荐精度得到了更加显著的提升。', pinyin: 'Yǐnrù xiānjìn de réngōng zhìnéng suànfǎ hòu, gāi píngtái de shùjù jiǎnsuǒ yǔ zhìnéng tuījiàn jīngdù dédào le gèngjiā xiǎnzhù de tíshēng.', meaning_vi: 'Sau khi đưa vào các thuật toán trí tuệ nhân tạo tiên tiến, độ chuẩn xác trong việc truy xuất dữ liệu và đề xuất thông minh của nền tảng đã đạt được sự nâng tầm càng thêm rõ nét.', difficulty_level: 'applied' }
    ]
  },
  // 1250. 工厂
  {
    hanzi: '工厂',
    pinyin: 'gōngchǎng',
    word_type: 'Danh từ',
    meaning_vi: 'nhà máy, xưởng sản xuất',
    examples: [
      { chinese: '这家汽车制造工厂坐落在城市郊区的工业开发区内。', pinyin: 'Zhè jiā qìchē zhìzào gōngchǎng zuòluò zài chéngshì jiāoqū de gōngyè kāifāqū nèi.', meaning_vi: 'Nhà máy sản xuất xe hơi này tọa lạc trong khu phát triển công nghiệp ở vùng ngoại ô thành phố.', difficulty_level: 'basic' },
      { chinese: '为了提高产能并降低废弃物排放，该现代智能工厂全面部署了自动化工业机器人生产线。', pinyin: 'Wèile tígāo chǎnnéng bìng jiàngdī fèiqìwù páifàng, gāi xiàndài zhìnéng gōngchǎng quánmiàn bùshǔ le zìdònghuà gōngyè jīqìrén shēngchǎnxiàn.', meaning_vi: 'Để nâng cao năng lực sản xuất và hạ thấp lượng xả thải chất thải, nhà máy thông minh hiện đại này đã triển khai toàn diện dây chuyền sản xuất robot công nghiệp tự động hóa.', difficulty_level: 'applied' }
    ]
  },

  // 1251. 功夫
  {
    hanzi: '功夫',
    pinyin: 'gōngfu',
    word_type: 'Danh từ',
    meaning_vi: 'kung fu, võ thuật; công phu, công sức bỏ ra',
    examples: [
      { chinese: '许多外国朋友是因为喜爱中国功夫而开始学习汉语的。', pinyin: 'Xǔduō wàiguó péngyou shì yīnwèi xǐ’ài Zhōngguó gōngfu ér kāishǐ xuéxí Hànyǔ de.', meaning_vi: 'Rất nhiều người bạn nước ngoài vì yêu mến kung fu Trung Hoa mà bắt đầu học tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '俗话说“只要功夫深，铁杵磨成针”，任何专业技能的精通都离不开日复一日的刻苦磨砺。', pinyin: 'Súhuà shuō “zhǐyào gōngfu shēn, tiěchǔ mó chéng zhēn”, rènhé zhuānyè jìnéng de jīngtōng dōu líbukāi rìfùyírì de kèkǔ mólì.', meaning_vi: 'Tục ngữ có câu "Có công mài sắt, có ngày nên kim", sự tinh thông của bất kỳ kỹ năng chuyên môn nào cũng đều gắn liền với sự trau dồi khổ luyện ngày này qua tháng khác.', difficulty_level: 'applied' }
    ]
  },
  // 1252. 公共
  {
    hanzi: '公共',
    pinyin: 'gōnggòng',
    word_type: 'Tính từ',
    meaning_vi: 'công cộng, chung',
    examples: [
      { chinese: '在图书馆和医院等公共场所，我们应当保持安静。', pinyin: 'Zài túshūguǎn hé yīyuàn děng gōnggòng chǎngsuǒ, wǒmen yīngdāng bǎochí ānjìng.', meaning_vi: 'Tại các địa điểm công cộng như thư viện và bệnh viện, chúng ta nên giữ trật tự im lặng.', difficulty_level: 'basic' },
      { chinese: '完善城市公共交通网络不仅能缓解交通拥堵，更是践行绿色低碳环保出行的核心举措。', pinyin: 'Wánshàn chéngshì gōnggòng jiāotōng wǎngluò bùjǐn néng huǎnjiě jiāotōng yōngdǔ, gèng shì jiànxíng lǜsè dītàn huánbǎo chūxíng de héxīn jǔcuò.', meaning_vi: 'Kiện toàn mạng lưới giao thông công cộng đô thị không chỉ xoa dịu ùn tắc đường xá, mà còn là giải pháp cốt lõi để hiện thực hóa việc đi lại xanh, giảm phát thải carbon và thân thiện với môi trường.', difficulty_level: 'applied' }
    ]
  },
  // 1253. 功课
  {
    hanzi: '功课',
    pinyin: 'gōngkè',
    word_type: 'Danh từ',
    meaning_vi: 'bài vở, bài tập ở trường; sự chuẩn bị tìm hiểu kỹ',
    examples: [
      { chinese: '每天放学回家后，小明都会按时把当天的功课认真做完。', pinyin: 'Měitiān fàngxué huí jiā hòu, Xiǎomíng dōu huì ànshí bǎ dāngtiān de gōngkè rènzhēn zuò wán.', meaning_vi: 'Mỗi ngày sau khi tan học về nhà, Tiểu Minh đều đúng giờ hoàn thành nghiêm túc bài vở của ngày hôm đó.', difficulty_level: 'basic' },
      { chinese: '在参加这次重要的海外商务考察之前，团队提前做足了针对当地市场法律环境的功课。', pinyin: 'Zài cānjiā zhè cì zhòngyào de hǎiwài shāngyè kǎochá zhīqián, tuánduì tíqián zuò zú le zhēnduì dāngdì shìchǎng fǎlǜ huánjìng de gōngkè.', meaning_vi: 'Trước khi tham gia chuyến khảo sát thương mại hải ngoại quan trọng lần này, đội ngũ đã làm bài tập tìm hiểu chuẩn bị vô cùng kỹ lưỡng về môi trường pháp lý của thị trường sở tại.', difficulty_level: 'applied' }
    ]
  },
  // 1254. 公里
  {
    hanzi: '公里',
    pinyin: 'gōnglǐ',
    word_type: 'Lượng từ / Danh từ',
    meaning_vi: 'ki-lô-mét (km)',
    examples: [
      { chinese: '学校离我住的地方大约有五公里路程。', pinyin: 'Xuéxiào lí wǒ zhù de dìfang dàyuē yǒu wǔ gōnglǐ lùchéng.', meaning_vi: 'Trường học cách nơi tôi ở khoảng chừng năm cây số.', difficulty_level: 'basic' },
      { chinese: '中国高速铁路列车的最高商业运营时速已达每小时三百五十公里，极大地缩短了城际通行时间。', pinyin: 'Zhōngguó gāosù tiělù lièchē de zuì gāo shāngyè yùnyíng shísù yǐ dá měi xiǎoshí sān bǎi wǔshí gōnglǐ, jí dà de suōduǎn le chéngjì tōngxíng shíjiān.', meaning_vi: 'Vận tốc vận hành thương mại tối đa của các đoàn tàu đường sắt cao tốc Trung Quốc đã đạt tới 350 km/h, rút ngắn đáng kể thời gian di chuyển liên thành phố.', difficulty_level: 'applied' }
    ]
  },
  // 1255. 公路
  {
    hanzi: '公路',
    pinyin: 'gōnglù',
    word_type: 'Danh từ',
    meaning_vi: 'đường quốc lộ, đường bộ, đường cái',
    examples: [
      { chinese: '沿着这条盘山公路一直往前开，就能到达风景优美的山顶观景台。', pinyin: 'Yánzhe zhè tiáo pánshān gōnglù yìzhí wǎng qián kāi, jiù néng dàodá fēngjǐng yōuměi de shāndǐng guānjǐngtái.', meaning_vi: 'Cứ lái men theo con đường quanh núi này đi thẳng về phía trước là có thể đến đài ngắm cảnh phong cảnh tuyệt đẹp trên đỉnh núi.', difficulty_level: 'basic' },
      { chinese: '国家近年来持续加大对中西部偏远乡村公路基础设施建设的资金扶持力度，畅通了农村特色农产品物流运输通道。', pinyin: 'Guójiā jìnniánlái chíxù jiàdà duì zhōng-xībù piānyuǎn xiāngcūn gōnglù jīchǔ shèshī jiànshè de zījīn fúchí lìdù, chàngtōng le nóngcūn tèsè nóngchǎnpǐn wùliú yùnshū tōngdào.', meaning_vi: 'Những năm gần đây nhà nước không ngừng tăng cường nguồn vốn hỗ trợ xây dựng cơ sở hạ tầng đường bộ nông thôn vùng sâu vùng xa miền Trung Tây, thông suốt các tuyến đường vận tải logistics nông sản đặc sản vùng miền.', difficulty_level: 'applied' }
    ]
  },
  // 1256. 工人
  {
    hanzi: '工人',
    pinyin: 'gōngrén',
    word_type: 'Danh từ',
    meaning_vi: 'công nhân, người lao động',
    examples: [
      { chinese: '车间里的工人们正在熟练地操作机器组装电子元件。', pinyin: 'Chējiān lǐ de gōngrénmen zhèngzài shúliàn de cāozuò jīqì zǔzhuāng diànzǐ yuánjiàn.', meaning_vi: 'Các công nhân trong phân xưởng đang thuần thục thao tác máy móc lắp ráp linh kiện điện tử.', difficulty_level: 'basic' },
      { chinese: '企业不仅要为技术工人提供公平合理的薪酬福利待遇，更要建立畅通的技术晋升与职业培训通道。', pinyin: 'Qǐyè bùjǐn yào wèi jìshù gōngrén tígōng gōngpíng hélǐ de xīnchóu fúlì dàiyù, gèng yào jiànlì chàngtōng de jìshù jìnshēng yǔ zhíyè péixùn tōngdào.', meaning_vi: 'Doanh nghiệp không những cần đem lại chế độ đãi ngộ lương bổng và phúc lợi công bằng hợp lý cho công nhân kỹ thuật, mà còn phải thiết lập lộ trình đào tạo nghề và thăng tiến kỹ thuật thông suốt.', difficulty_level: 'applied' }
    ]
  },
  // 1257. 工资
  {
    hanzi: '工资',
    pinyin: 'gōngzī',
    word_type: 'Danh từ',
    meaning_vi: 'tiền lương, tiền công',
    examples: [
      { chinese: '公司通常在每个月的十号准时发放员工工资。', pinyin: 'Gōngsī tōngcháng zài měi gè yuè de shí hào zhǔnshí fāfàng yuángōng gōngzī.', meaning_vi: 'Công ty thường phát tiền lương cho nhân viên đúng hẹn vào ngày mùng 10 hàng tháng.', difficulty_level: 'basic' },
      { chinese: '在这项全面薪酬改革方案中，员工的绩效奖金与基本基本工资紧密挂钩，以充分激发团队的创新活力。', pinyin: 'Zài zhè xiàng quánmiàn xīnchóu gǎigé fāng’àn zhōng, yuángōng de jìxiào jiǎngjīn yǔ jīběn gōngzī jǐnmì guàgōu, yǐ chōngfèn jīfā tuánduì de chuàngxīn huólì.', meaning_vi: 'Trong phương án cải cách tiền lương toàn diện này, tiền thưởng hiệu suất của nhân viên gắn kết chặt chẽ với mức lương cơ bản, nhằm khơi dậy trọn vẹn sức sống đổi mới sáng tạo của đội ngũ.', difficulty_level: 'applied' }
    ]
  },
  // 1258. 共
  {
    hanzi: '共',
    pinyin: 'gòng',
    word_type: 'Phó từ',
    meaning_vi: 'tổng cộng, cùng nhau',
    examples: [
      { chinese: '这本书一共有二十个单元，适合作为中级精读教材。', pinyin: 'Zhè běn shū yígòng yǒu èrshí gè dānyuán, shìhé zuòwéi zhōngjí jīngdú jiàocái.', meaning_vi: 'Cuốn sách này có tổng cộng hai mươi bài, thích hợp làm giáo trình đọc hiểu chuyên sâu trình độ trung cấp.', difficulty_level: 'basic' },
      { chinese: '此次跨国科技交流峰会共有来自全球五十多个国家和地区的顶尖行业学者与商界领袖出席。', pinyin: 'Cǐ cì kuàguó kējì jiāoliú fēnghuì gòng yǒu láizì quánqiú wǔshí duō gè guójiā hé dìqū de dǐngjiān hángyè xuézhě yǔ shāngjiè lǐngxiù chūxí.', meaning_vi: 'Hội nghị thượng đỉnh giao lưu khoa học công nghệ xuyên quốc gia lần này có tổng cộng các học giả hàng đầu ngành và giới lãnh đạo thương trường đến từ hơn 50 quốc gia và vùng lãnh thổ trên thế giới tham dự.', difficulty_level: 'applied' }
    ]
  },
  // 1259. 共同
  {
    hanzi: '共同',
    pinyin: 'gòngtóng',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'chung, cùng nhau',
    examples: [
      { chinese: '保护地球生态环境是我们全人类共同的责任。', pinyin: 'Bǎohù Dìqiú shēngtài huánjìng shì wǒmen quán rénlèi gòngtóng de zérèn.', meaning_vi: 'Bảo vệ môi trường sinh thái Trái đất là trách nhiệm chung của toàn thể nhân loại chúng ta.', difficulty_level: 'basic' },
      { chinese: '双方企业基于互利共赢的原则签署了战略协议，旨在共同研发新一代环保低碳新能源电池。', pinyin: 'Shuāngfāng qǐyè jīyú hùlì-gòngyíng de yuánzé qiānshǔ le zhànlüè xiéyì, zhǐ zài gòngtóng yánfā xīn yídài huánbǎo dītàn xīnnéngyuán diànchí.', meaning_vi: 'Doanh nghiệp hai bên trên nguyên tắc đôi bên cùng có lợi đã ký kết thỏa thuận chiến lược, hướng tới mục tiêu cùng nhau hợp tác nghiên cứu phát triển thế hệ pin năng lượng mới giảm phát thải thân thiện với môi trường.', difficulty_level: 'applied' }
    ]
  },
  // 1260. 够
  {
    hanzi: '够',
    pinyin: 'gòu',
    word_type: 'Động từ / Phó từ',
    meaning_vi: 'đủ; khá, chán',
    examples: [
      { chinese: '桌上的饭菜已经够大家吃了，不用再加菜了。', pinyin: 'Zhuō shang de fàncài yǐjīng gòu dàjiā chī le, bú yòng zài jiā cài le.', meaning_vi: 'Cơm canh trên bàn đã đủ cho mọi người ăn rồi, không cần gọi thêm món nữa đâu.', difficulty_level: 'basic' },
      { chinese: '要想在竞争异常激烈的商业竞争中立于不败之地，光有雄厚的资本运作是远远不够的，还必须具备持续的技术创新壁垒。', pinyin: 'Yào xiǎng zài jìngzhēng yìcháng jīliè de shāngyè jìngzhēng zhōng lìyú-búbàizhīdì, guāng yǒu xiónghòu de zīběn yùnzuò shì yuǎnyuǎn bú gòu de, hái bìxū jùbèi chíxù de jìshù chuàngxīn bìlěi.', meaning_vi: 'Muốn đứng vững ở thế bất bại trong cuộc cạnh tranh thương trường khốc liệt khôn cùng, chỉ có vận hành nguồn vốn dồi dào thôi thì còn lâu mới đủ, mà còn phải có rào cản đổi mới công nghệ liên tục.', difficulty_level: 'applied' }
    ]
  },
  // 1261. 购买
  {
    hanzi: '购买',
    pinyin: 'gòumǎi',
    word_type: 'Động từ',
    meaning_vi: 'mua, thu mua, mua sắm',
    examples: [
      { chinese: '很多年轻人习惯在网络电商平台上购买生活日用品。', pinyin: 'Hěn duō qīngniánrén xíguàn zài wǎngluò diànshāng píngtái shang gòumǎi shēnghuó rìyòngpǐn.', meaning_vi: 'Rất nhiều người trẻ tuổi quen mua sắm đồ dùng thiết yếu hàng ngày trên các nền tảng thương mại điện tử trực tuyến.', difficulty_level: 'basic' },
      { chinese: '消费者在购买大额商业保险产品时，应当逐条仔细核对合同保险责任与免责除外条款。', pinyin: 'Xiāofèizhě zài gòumǎi dà’é shāngyè bǎoxiǎn chǎnpǐn shí, yīngdāng zhútáo zǐxì héduì hétong bǎoxiǎn zérèn yǔ miǎnzé chúwài tiáokuǎn.', meaning_vi: 'Người tiêu dùng khi mua các gói sản phẩm bảo hiểm thương mại giá trị lớn cần đối chiếu kỹ từng điều khoản trách nhiệm bảo hiểm và trường hợp loại trừ miễn trừ trách nhiệm.', difficulty_level: 'applied' }
    ]
  },
  // 1262. 购物
  {
    hanzi: '购物',
    pinyin: 'gòuwù',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'mua sắm, shopping',
    examples: [
      { chinese: '周末市中心的商业街上到处都是出来购物逛街的人潮。', pinyin: 'Zhōumò shìzhōngxīn de shāngyèjiē shang dàochù dōu shì chūlái gòuwù guàngjiē de réncháo.', meaning_vi: 'Cuối tuần trên phố thương mại ở trung tâm thành phố đâu đâu cũng là dòng người đi mua sắm dạo phố.', difficulty_level: 'basic' },
      { chinese: '现代大型城市综合体将购物消费、文化娱乐以及特色餐饮深度融合，为消费者提供了全方位的沉浸式体验。', pinyin: 'Xiàndài dàxíng chéngshì zōnghétǐ jiāng gòuwù xiāofèi, wénhuà yúlè yǐjí tèsè cānyǐn shēndù rónghé, wèi xiāofèizhě tígōng le quánfāngwèi de chénjìnshì tǐyàn.', meaning_vi: 'Khu phức hợp đô thị quy mô lớn hiện đại kết hợp sâu sắc giữa tiêu dùng mua sắm, giải trí văn hóa cũng như ẩm thực đặc sản, đem lại trải nghiệm đắm chìm toàn diện cho người tiêu dùng.', difficulty_level: 'applied' }
    ]
  },
  // 1263. 估计
  {
    hanzi: '估计',
    pinyin: 'gūjì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'ước tính, dự đoán; sự ước lượng',
    examples: [
      { chinese: '路上有点堵车，我估计半个小时以后才能赶到餐厅。', pinyin: 'Lùshang yǒudiǎn dǔchē, wǒ gūjì bàn gè xiǎoshí yǐhòu cái néng gǎndào cāntīng.', meaning_vi: 'Dọc đường hơi tắc xe, tôi ước tính nửa tiếng nữa mới có thể đến được nhà hàng.', difficulty_level: 'basic' },
      { chinese: '据权威国际金融机构保守估计，该高科技行业的全球市场规模在未来五年内将保持两位数的复合增长率。', pinyin: 'Jù quánwēi guójì jīnróng jīgòu bǎoshǒu gūjì, gāi gāokējì hángyè de quánqiú shìchǎng guīmó zài wèilái wǔ nián nèi jiāng bǎochí liǎngwèishù de fùhé zēngzhǎnglǜ.', meaning_vi: 'Theo ước tính dè dặt của cơ quan tài chính quốc tế uy tín, quy mô thị trường toàn cầu của ngành công nghệ cao này trong 5 năm tới sẽ duy trì tốc độ tăng trưởng kép hai con số.', difficulty_level: 'applied' }
    ]
  },
  // 1264. 姑娘
  {
    hanzi: '姑娘',
    pinyin: 'gūniang',
    word_type: 'Danh từ',
    meaning_vi: 'cô gái, thiếu nữ, cô nương',
    examples: [
      { chinese: '那位在图书馆认真读书的年轻姑娘笑起来十分甜美。', pinyin: 'Nà wèi zài túshūguǎn rènzhēn dúshū de niánqīng gūniang xiào qǐlai shífēn tiánměi.', meaning_vi: 'Cô gái trẻ đang chăm chú đọc sách trong thư viện đó khi cười trông vô cùng ngọt ngào.', difficulty_level: 'basic' },
      { chinese: '这位来自乡村的年轻姑娘凭借自强不息的拼搏精神考取了名牌大学博士，成为全村人的骄傲。', pinyin: 'Zhè wèi láizì xiāngcūn de niánqīng gūniang píngjiè zìqiáng-bùxī de pīnbó jīngshén kǎoqǔ le míngpái dàxué bóshì, chéngwéi quán cūnrén de jiāo’ào.', meaning_vi: 'Cô gái trẻ đến từ vùng nông thôn này nhờ vào tinh thần tự lực tự cường phấn đấu không ngừng nghỉ đã đỗ tiến sĩ trường đại học danh tiếng, trở thành niềm tự hào của cả làng.', difficulty_level: 'applied' }
    ]
  },
  // 1265. 鼓励
  {
    hanzi: '鼓励',
    pinyin: 'gǔlì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'khích lệ, động viên; lời cổ vũ',
    examples: [
      { chinese: '在老师和父母的热情鼓励下，他终于勇敢地报了名参加演讲比赛。', pinyin: 'Zài lǎoshī hé fùmǔ de rèqíng gǔlì xià, tā zhōngyú yǒnggǎn de bào le míng cānjiā yǎnjiǎng bǐsài.', meaning_vi: 'Dưới sự động viên nhiệt tình của thầy cô và cha mẹ, cuối cùng cậu ấy đã dũng cảm đăng ký tham gia cuộc thi diễn thuyết.', difficulty_level: 'basic' },
      { chinese: '政府出台了一系列税收优惠与资金补贴政策，积极鼓励中小微科技型企业加大自主研发创新投入。', pinyin: 'Zhèngfǔ chūtái le yí xìliè shuìshōu yōuhuì yǔ zījīn bǔtiē zhèngcè, jījí gǔlì zhōng-xiǎo-wēi kējìxíng qǐyè jiàdà zìzhǔ yánfā chuàngxīn tóurù.', meaning_vi: 'Chính phủ đã ban hành một loạt chính sách ưu đãi thuế và trợ cấp tài chính, tích cực khuyến khích các doanh nghiệp công nghệ vừa, nhỏ và siêu nhỏ gia tăng đầu tư nghiên cứu phát triển đổi mới độc lập.', difficulty_level: 'applied' }
    ]
  },
  // 1266. 顾客
  {
    hanzi: '顾客',
    pinyin: 'gùkè',
    word_type: 'Danh từ',
    meaning_vi: 'khách hàng, người mua hàng',
    examples: [
      { chinese: '服务员耐心地向顾客解答关于手机各项功能的疑问。', pinyin: 'Fúwùyuán nàixīn de xiàng gùkè jiědá guānyú shǒujī gè xiàng gōngnéng de yíwèn.', meaning_vi: 'Nhân viên phục vụ kiên nhẫn giải đáp thắc mắc của khách hàng về từng tính năng của chiếc điện thoại di động.', difficulty_level: 'basic' },
      { chinese: '优秀的服务型企业始终践行“顾客至上”的服务理念，致力于为每一位顾客提供个性化的高品质体验。', pinyin: 'Yōuxiù de fúwùxíng qǐyè shǐzhōng jiànxíng “gùkè zhìshàng” de fúwù lǐniàn, zhìlìyú wèi měi yí wèi gùkè tígōng gèxìnghuà de gāo pǐnzhì tǐyàn.', meaning_vi: 'Doanh nghiệp dịch vụ xuất sắc luôn thực thi triết lý phục vụ "Khách hàng là thượng đế", dốc lòng đem lại trải nghiệm cá nhân hóa chất lượng cao cho từng khách hàng.', difficulty_level: 'applied' }
    ]
  },
  // 1267. 故意
  {
    hanzi: '故意',
    pinyin: 'gùyì',
    word_type: 'Phó từ',
    meaning_vi: 'cố ý, cố tình',
    examples: [
      { chinese: '对不起，我刚才真不是故意踩到你的脚的。', pinyin: 'Duìbuqǐ, wǒ gāngcái zhēn bú shì gùyì cǎi dào nǐ de jiǎo de.', meaning_vi: 'Xin lỗi nhé, lúc nãy tôi thật sự không phải cố ý dẫm trúng chân bạn đâu.', difficulty_level: 'basic' },
      { chinese: '经监管部门核查证实，该上市公司存在故意隐瞒重大资产亏损的违规行为，依法将面临巨额行政处罚。', pinyin: 'Jīng jiānguǎn bùmén héchá zhèngshí, gāi shàngshì gōngsī cúnzài gùyì yǐnmán zhòngdà zīchǎn kuīsǔn de wéiguī xíngwéi, yīfǎ jiāng miànlín jù’é xíngzhèng chǔfá.', meaning_vi: 'Qua xác minh của cơ quan giám sát, công ty niêm yết này có hành vi vi phạm cố tình che giấu thua lỗ tài sản nghiêm trọng, theo pháp luật sẽ phải đối mặt với mức xử phạt hành chính khổng lồ.', difficulty_level: 'applied' }
    ]
  },
  // 1268. 挂
  {
    hanzi: '挂',
    pinyin: 'guà',
    word_type: 'Động từ',
    meaning_vi: 'treo; cúp máy (điện thoại); đăng ký khám (挂号)',
    examples: [
      { chinese: '回到家后，他顺手把外套挂在门后的衣帽架上。', pinyin: 'Huí dào jiā hòu, tā shùnshǒu bǎ wàitào guà zài mén hòu de yīmàojià shang.', meaning_vi: 'Sau khi về tới nhà, anh ấy thuận tay treo chiếc áo khoác lên cây treo mũ áo phía sau cánh cửa.', difficulty_level: 'basic' },
      { chinese: '在就医数字化改革推行后，市民只需在手机应用上提前预约挂号，便能避免排队拥挤。', pinyin: 'Zài jiùyī shùzìhuà gǎigé tuīxíng hòu, shìmín zhǐ xū zài shǒujī yìngyòng shang tíqián yùyuē guàhào, biàn néng bìmiǎn páiduì yōngjǐ.', meaning_vi: 'Sau khi cải cách số hóa quy trình khám chữa bệnh được triển khai, người dân chỉ cần đăng ký lấy số khám trước trên ứng dụng di động là có thể tránh được cảnh xếp hàng chen chúc.', difficulty_level: 'applied' }
    ]
  },
  // 1269. 关键
  {
    hanzi: '关键',
    pinyin: 'guānjiàn',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'then chốt, mấu chốt, điểm mấu chốt',
    examples: [
      { chinese: '掌握科学的学习方法是提高汉语水平的关键所在。', pinyin: 'Zhǎngwò kēxué de xuéxí fāngfǎ shì tígāo Hànyǔ shuǐpíng de guānjiàn suǒzài.', meaning_vi: 'Nắm vững phương pháp học tập khoa học chính là then chốt để nâng cao trình độ tiếng Trung.', difficulty_level: 'basic' },
      { chinese: '在决定企业未来生存走向的关键时刻，管理团队果断做出了剥离低效传统资产的战略抉择。', pinyin: 'Zài juédìng qǐyè wèilái shēngcún zǒuxiàng de guānjiàn shíkè, guǎnlǐ tuánduì guǒduàn zuò chū le bōlí dīxiào chuántǒng zīchǎn de zhànlüè juézé.', meaning_vi: 'Ở thời khắc mấu chốt quyết định hướng đi sinh tồn tương lai của doanh nghiệp, ban điều hành đã dứt khoát đưa ra quyết sách chiến lược thoái vốn khỏi các tài sản truyền thống kém hiệu quả.', difficulty_level: 'applied' }
    ]
  },
  // 1270. 观看
  {
    hanzi: '观看',
    pinyin: 'guānkàn',
    word_type: 'Động từ',
    meaning_vi: 'xem, theo dõi, quan sát',
    examples: [
      { chinese: '昨晚全家人围坐在客厅的电视机前观看精彩的足球比赛。', pinyin: 'Zuówǎn quán jiā rén wéizuò zài kètīng de diànshìjī qián guānkàn jīngcǎi de zúqiú bǐsài.', meaning_vi: 'Tối qua cả gia đình quây quần ngồi trước màn hình tivi phòng khách theo dõi trận bóng đá đặc sắc.', difficulty_level: 'basic' },
      { chinese: '数以亿计的全球观众通过高清网络直播同步观看了国际冬季奥运会盛大的开幕式。', pinyin: 'Shù yǐ yì jì de quánqiú guānzhòng tōngguò gāoqīng wǎngluò zhībō tóngbù guānkàn le guójì Dōngjì Àoyùnhuì shèngdà de kāimùshì.', meaning_vi: 'Hàng trăm triệu khán giả trên toàn cầu đã đồng thời xem lễ khai mạc hoành tráng của Thế vận hội Mùa đông quốc tế qua phát sóng trực tiếp trực tuyến độ nét cao.', difficulty_level: 'applied' }
    ]
  },
  // 1271. 观众
  {
    hanzi: '观众',
    pinyin: 'guānzhòng',
    word_type: 'Danh từ',
    meaning_vi: 'khán giả, người xem',
    examples: [
      { chinese: '精彩的话剧表演结束后，台下的观众爆发出热烈的掌声。', pinyin: 'Jīngcǎi de huàjù biǎoyǎn jiéshù hòu, tái xià de guānzhòng bàofā chū rèliè de zhǎngshēng.', meaning_vi: 'Sau khi buổi biểu diễn kịch nói đặc sắc khép lại, khán giả dưới khán phòng đã bùng nổ những tràng pháo tay nhiệt liệt.', difficulty_level: 'basic' },
      { chinese: '这部电影凭借深邃深刻的人文关怀与出色的视听特效，赢得了专业影评人与普通观众的一致赞誉。', pinyin: 'Zhè bù diànyǐng píngjiè shēnsuì shēnkè de rénwén guānhuái yǔ chūsè de shìtīng tèxiào, yíngdé le zhuānyè yǐngpíngrén yǔ pǔtōng guānzhòng de yízhì zànyù.', meaning_vi: 'Bộ phim này nhờ vào sự quan tâm nhân văn sâu sắc cùng hiệu ứng nghe nhìn xuất sắc đã giành được lời ngợi khen đồng thuận từ giới phê bình phim chuyên nghiệp lẫn khán giả đại chúng.', difficulty_level: 'applied' }
    ]
  },
  // 1272. 管
  {
    hanzi: '管',
    pinyin: 'guǎn',
    word_type: 'Động từ',
    meaning_vi: 'quản, quản lý, trông nom; bận tâm',
    examples: [
      { chinese: '李阿姨平时不仅要忙自己的工作，还要负责管家里的生活开支。', pinyin: 'Lǐ āyí píngshí bùjǐn yào máng zìjǐ de gōngzuò, hái yào fùzé guǎn jiā lǐ de shēnghuó kāizhī.', meaning_vi: 'Dì Lý ngày thường không chỉ bận việc riêng mà còn phải phụ trách quản lý mọi khoản chi tiêu sinh hoạt trong gia đình.', difficulty_level: 'basic' },
      { chinese: '作为资深项目总监，他不仅管整个研发团队的日常工作，更要对交付成果的质量全权把关。', pinyin: 'Zuòwéi zīshēn xiàngmù zǒngjiān, tā bùjǐn guǎn zhěnggè yánfā tuánduì de rìcháng gōngzuò, gèng yào duì jiāofù chéngguǒ de zhìliàng quánquán bǎguān.', meaning_vi: 'Với tư cách là giám đốc dự án kỳ cựu, anh ấy không chỉ quản lý công việc hàng ngày của toàn bộ đội ngũ R&D, mà còn toàn quyền kiểm soát gác cổng chất lượng cho thành quả bàn giao.', difficulty_level: 'applied' }
    ]
  },
  // 1273. 管理
  {
    hanzi: '管理',
    pinyin: 'guǎnlǐ',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'quản lý; ban quản trị',
    examples: [
      { chinese: '她在大学里攻读的是工商企业管理专业。', pinyin: 'Tā zài dàxué lǐ gōngdú de shì gōngshāng qǐyè guǎnlǐ zhuānyè.', meaning_vi: 'Ở trường đại học, cô ấy theo học chuyên ngành Quản trị kinh doanh doanh nghiệp.', difficulty_level: 'basic' },
      { chinese: '现代企业应当引入精益管理理念，通过数字化流程优化全面消除各个环节的资源浪费。', pinyin: 'Xiàndài qǐyè yīngdāng yǐnrù jīngyì guǎnlǐ lǐniàn, tōngguò shùzìhuà liúchéng yōuhuà quánmiàn xiāochú gègè huánjié de zīyuán làngfèi.', meaning_vi: 'Doanh nghiệp hiện đại cần đưa vào triết lý quản lý tinh gọn (lean management), thông qua tối ưu hóa quy trình số hóa để xóa bỏ triệt để sự lãng phí tài nguyên ở mọi mắt xích.', difficulty_level: 'applied' }
    ]
  },
  // 1274. 光
  {
    hanzi: '光',
    pinyin: 'guāng',
    word_type: 'Danh từ / Phó từ / Tính từ',
    meaning_vi: 'ánh sáng; chỉ, riêng; hết sạch; trọc',
    examples: [
      { chinese: '清晨温暖柔和的阳光洒在绿色的草坪上。', pinyin: 'Qīngchén wēnnuǎn róuhé de yángguāng sǎ zài lǜsè de cǎopíng shang.', meaning_vi: 'Ánh nắng ban mai ấm áp dịu dàng rải trên thảm cỏ xanh mướt.', difficulty_level: 'basic' },
      { chinese: '学好一门外语光靠死记硬背单词是行不通的，必须在真实的语境中高频输入与实践输出。', pinyin: 'Xué hǎo yì mén wàiyǔ guāng kào sǐjì-yìngbèi dāncí shì xíngbutōng de, bìxū zài zhēnshí de yǔjìng zhōng gāopín shūrù yǔ shíjiàn shūchū.', meaning_vi: 'Học giỏi một ngoại ngữ nếu chỉ dựa vào học vẹt từ vựng thì không ăn thua, bắt buộc phải nạp vào liên tục với tần suất cao và thực hành diễn đạt trong ngữ cảnh đời thực.', difficulty_level: 'applied' }
    ]
  },
  // 1275. 广播
  {
    hanzi: '广播',
    pinyin: 'guǎngbō',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'phát thanh, truyền thanh; đài phát thanh',
    examples: [
      { chinese: '车站的大厅里响起了提醒乘客检票上车的中文广播。', pinyin: 'Chēzhàn de dàtīng lǐ xiǎngqǐ le tíxǐng chéngkè jiǎnpiào shàng chē de Zhōngwén guǎngbō.', meaning_vi: 'Trong đại sảnh nhà ga vang lên tiếng phát thanh bằng tiếng Trung nhắc nhở hành khách soát vé lên tàu.', difficulty_level: 'basic' },
      { chinese: '尽管融媒体时代网络资讯极其丰富，但在偏远山区或突发自然灾害时，无线电应急广播依然是最可靠的信息生命线。', pinyin: 'Jǐnguǎn róngméitǐ shídài wǎngluò zīxùn jíqí fēngfù, dàn zài piānyuǎn shānqū huò tūfā zìrán zāihài shí, wúxiàndiàn yìngjí guǎngbō yīrán shì zuì kěkào de xìnxī shēngmìngxiàn.', meaning_vi: 'Dù cho trong thời đại truyền thông tích hợp thông tin trực tuyến vô cùng phong phú, nhưng tại các vùng núi xa xôi hoặc khi xảy ra thiên tai bất ngờ, phát thanh vô tuyến khẩn cấp vẫn là đường dây thông tin huyết mạch đáng tin cậy nhất.', difficulty_level: 'applied' }
    ]
  },

  // 1276. 广告
  {
    hanzi: '广告',
    pinyin: 'guǎnggào',
    word_type: 'Danh từ',
    meaning_vi: 'quảng cáo',
    examples: [
      { chinese: '地铁车厢的屏幕上正在循环播放这款新手机的宣传广告。', pinyin: 'Dìtiě chēxiāng de píngmù shang zhèngzài xúnhuán bōfàng zhè kuǎn xīn shǒujī de xuānchuán guǎnggào.', meaning_vi: 'Trên màn hình toa tàu điện ngầm đang phát lặp lại đoạn quảng cáo tuyên truyền của mẫu điện thoại mới này.', difficulty_level: 'basic' },
      { chinese: '品牌营销团队在各大主流社交媒体平台精准投放数字化广告，使得新品上市当季的曝光量与转化率大幅攀升。', pinyin: 'Pǐnpái yíngxiāo tuánduì zài gè dà zhǔliú shèjiāo méitǐ píngtái jīngzhǔn tóufàng shùzìhuà guǎnggào, shǐde xīnpǐn shàngshì dāngjì de bàoguāngliàng yǔ zhuǎnhuàlǜ dàfú pānshēng.', meaning_vi: 'Đội ngũ tiếp thị thương hiệu đã đặt quảng cáo số hóa chính xác trên các nền tảng mạng xã hội chủ lưu, giúp lượng hiển thị và tỷ lệ chuyển đổi của sản phẩm mới trong quý ra mắt tăng vọt đáng kể.', difficulty_level: 'applied' }
    ]
  },
  // 1277. 逛
  {
    hanzi: '逛',
    pinyin: 'guàng',
    word_type: 'Động từ',
    meaning_vi: 'dạo, đi dạo, lượn phố, dạo chơi',
    examples: [
      { chinese: '周末我常常和好朋友一起去公园散步，或者去附近的商场逛逛。', pinyin: 'Zhōumò wǒ chángcháng hé hǎo péngyou yìqǐ qù gōngyuán sànbù, huòzhě qù fùjìn de shāngchǎng guàngguang.', meaning_vi: 'Cuối tuần tôi thường cùng bạn thân đi dạo công viên, hoặc đến trung tâm thương mại gần đó dạo chơi mua sắm.', difficulty_level: 'basic' },
      { chinese: '漫步在具有数百年历史的古老水乡小镇，游客们悠闲地逛着青石板街两旁琳琅满目的手工艺品小店。', pinyin: 'Mànbù zài jùyǒu shù bǎi nián lìshǐ de gǔlǎo shuǐxiāng xiǎozhèn, yóukèmen yōuxián de guàng zhe qīngshíbǎn jiē liǎngpáng línláng-mǎnmù de shǒugōngyìpǐn xiǎodiàn.', meaning_vi: 'Rảo bước trên thị trấn sông nước cổ kính có lịch sử hàng trăm năm, du khách thong thả dạo ngắm những cửa tiệm thủ công mỹ nghệ phong phú đa dạng ở hai bên con phố lát đá xanh.', difficulty_level: 'applied' }
    ]
  },
  // 1278. 规定
  {
    hanzi: '规定',
    pinyin: 'guīdìng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'quy định; đặt ra quy định',
    examples: [
      { chinese: '图书馆明文规定馆内严禁吸烟和大声喧哗。', pinyin: 'Túshūguǎn míngwén guīdìng guǎn nèi yánjìn xīyān hé dàshēng xuānhuá.', meaning_vi: 'Thư viện quy định rõ bằng văn bản nghiêm cấm hút thuốc và làm ồn lớn tiếng trong khuôn viên.', difficulty_level: 'basic' },
      { chinese: '依据最新出台的网络数据安全管理规定，所有互联网科技企业必须严格保护消费者的个人敏感隐私信息。', pinyin: 'Yījù zuìxīn chūtái de wǎngluò shùjù ānquán guǎnlǐ guīdìng, suǒyǒu hùliánwǎng kējì qǐyè bìxū yángé bǎohù xiāofèizhě de gèrén mǐngǎn yǐnsī xìnxī.', meaning_vi: 'Căn cứ theo quy định quản lý an toàn dữ liệu mạng mới ban hành, tất cả doanh nghiệp công nghệ internet phải bảo vệ nghiêm ngặt thông tin đời tư nhạy cảm của người tiêu dùng.', difficulty_level: 'applied' }
    ]
  },
  // 1279. 国籍
  {
    hanzi: '国籍',
    pinyin: 'guójí',
    word_type: 'Danh từ',
    meaning_vi: 'quốc tịch',
    examples: [
      { chinese: '填写入境登记卡的时候，请务必准确写明自己的姓名和国籍。', pinyin: 'Tiánxiě rùjìng dēngjìkǎ de shíhou, qǐng wùbì zhǔnquè xiěmíng zìjǐ de xìngmíng hé guójí.', meaning_vi: 'Khi điền vào tờ khai nhập cảnh, xin quý vị hãy ghi rõ chính xác họ tên và quốc tịch của mình.', difficulty_level: 'basic' },
      { chinese: '在这所著名国际学校里，师生来自三十多个不同的国籍，多元文化在此交流互鉴融合共生。', pinyin: 'Zài zhè suǒ zhùmíng guójì xuéxiào lǐ, shīshēng láizì sānshí duō gè bùtóng de guójí, duōyuán wénhuà zài cǐ jiāoliú hùjiàn rónghé gòngshēng.', meaning_vi: 'Tại ngôi trường quốc tế danh tiếng này, thầy trò đến từ hơn 30 quốc tịch khác nhau, các nền văn hóa đa dạng tại đây giao lưu học hỏi và hòa quyện cùng phát triển.', difficulty_level: 'applied' }
    ]
  },
  // 1280. 国际
  {
    hanzi: '国际',
    pinyin: 'guójì',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'quốc tế',
    examples: [
      { chinese: '北京首都国际机场每天起降数百架次往返世界各地的航班。', pinyin: 'Běijīng Shǒudū Guójì Jīchǎng měitiān qǐjiàng shù bǎi jiàcì wǎngfǎn shìjiè gèdì de hángbān.', meaning_vi: 'Sân bay Quốc tế Thủ đô Bắc Kinh mỗi ngày có hàng trăm lượt chuyến bay cất hạ cánh đi và đến khắp nơi trên thế giới.', difficulty_level: 'basic' },
      { chinese: '中国积极推动构建人类命运共同体，并在维护多边贸易体制与应对全球气候变化中发挥着负责任的国际大国作用。', pinyin: 'Zhōngguó jījí tuīdòng gòujiàn rénlèi mìngyùn gòngtóngtǐ, bìng zài wéihù duōbiān màoyì tǐzhì yǔ yìngduì quánqiú qìhòu biànhuà zhōng fāhuī zhe fùzérèn de guójì dàguó zuòyòng.', meaning_vi: 'Trung Quốc tích cực thúc đẩy xây dựng cộng đồng chung vận mệnh nhân loại, và phát huy vai trò nước lớn quốc tế có trách nhiệm trong việc duy trì thể chế thương mại đa phương và ứng phó với biến đổi khí hậu toàn cầu.', difficulty_level: 'applied' }
    ]
  },
  // 1281. 果汁
  {
    hanzi: '果汁',
    pinyin: 'guǒzhī',
    word_type: 'Danh từ',
    meaning_vi: 'nước ép trái cây, nước hoa quả',
    examples: [
      { chinese: '夏天喝一杯冰镇鲜榨橙子果汁，感觉非常清凉解渴。', pinyin: 'Xiàtiān hē yì bēi bīngzhèn xiānzhà chéngzi guǒzhī, gǎnjué fēicháng qīngliáng jiěkě.', meaning_vi: 'Mùa hè uống một ly nước ép cam tươi ướp lạnh, cảm thấy vô cùng thanh mát đã khát.', difficulty_level: 'basic' },
      { chinese: '随着当代公众健康养生意识的不断增强，不添加任何人工糖分与防腐剂的百分之百纯鲜果汁在市场上越来越受青睐。', pinyin: 'Suízhe dāngdài gōngzhòng jiànkāng yǎngshēng yìshí de bùduàn zēngqiáng, bù tiānjiā rènhé réngōng tángfèn yǔ fángfǔjì de bǎifēnzhībǎi chún xiān guǒzhī zài shìchǎng shang yuèláiyuè shòu qīnglài.', meaning_vi: 'Cùng với ý thức dưỡng sinh chăm sóc sức khỏe của công chúng đương đại ngày càng nâng cao, nước ép hoa quả tươi nguyên chất 100% không chứa đường nhân tạo và chất bảo quản ngày càng được ưa chuộng trên thị trường.', difficulty_level: 'applied' }
    ]
  },
  // 1282. 过程
  {
    hanzi: '过程',
    pinyin: 'guòchéng',
    word_type: 'Danh từ',
    meaning_vi: 'quá trình, tiến trình',
    examples: [
      { chinese: '学习语言是一个需要持之以恒、循序渐进的长期过程。', pinyin: 'Xuéxí yǔyán shì yí gè xūyào chízhīyǐhéng, xúnxù-jiànjìn de chángqī guòchéng.', meaning_vi: 'Học tập ngôn ngữ là một quá trình lâu dài đòi hỏi phải kiên trì bền bỉ và tuần tự từng bước một.', difficulty_level: 'basic' },
      { chinese: '在重大工程项目的研发全过程中，项目经理必须对每一个关键节点的测试验收数据实施严格全流程质量监控。', pinyin: 'Zài zhòngdà gōngchéng xiàngmù de yánfā quán guòchéng zhōng, xiàngmù jīnglǐ bìxū duì měi yí gè guānjiàn jiédiǎn de cèshì yànshōu shùjù shíshī yángé quán liúchéng zhìliàng jiānkòng.', meaning_vi: 'Trong toàn bộ quá trình nghiên cứu phát triển dự án công trình trọng điểm, giám đốc dự án phải thực thi giám sát chất lượng toàn quy trình chặt chẽ đối với số liệu nghiệm thu kiểm thử tại từng mắt xích then chốt.', difficulty_level: 'applied' }
    ]
  },
  // 1283. 海洋
  {
    hanzi: '海洋',
    pinyin: 'hǎiyáng',
    word_type: 'Danh từ',
    meaning_vi: 'đại dương, biển cả',
    examples: [
      { chinese: '辽阔深邃的海洋里生活着成千上万种神奇的动植物。', pinyin: 'Liáokuò shēnsuì de hǎiyáng lǐ shēnghuó zhe chéngqiān-shàngwàn zhǒng shénqí de dòngzhíwù.', meaning_vi: 'Nơi đại dương mênh mông sâu thẳm có hàng vạn loài động thực vật kỳ diệu sinh sống.', difficulty_level: 'basic' },
      { chinese: '国际社会呼吁各国通力协作减少塑料垃圾入海排放，切实保护珍贵脆弱的海洋生态环境与生物多样性。', pinyin: 'Guójì shèhuì hūyù gè guó tōnglì xiézuò jiǎnshǎo sùliào lājī rù hǎi páifàng, qièshí bǎohù zhēnguì cuìruò de hǎiyáng shēngtài huánjìng yǔ shēngwù duōyàngxìng.', meaning_vi: 'Cộng đồng quốc tế kêu gọi các nước chung tay hợp tác giảm xả rác thải nhựa ra biển, bảo vệ thiết thực môi trường sinh thái đại dương và sự đa dạng sinh học vô cùng quý giá và mong manh.', difficulty_level: 'applied' }
    ]
  },
  // 1284. 害羞
  {
    hanzi: '害羞',
    pinyin: 'hàixiū',
    word_type: 'Tính từ',
    meaning_vi: 'ngại ngùng, thẹn thùng, e thẹn',
    examples: [
      { chinese: '小女孩一见到生人就有些害羞，悄悄躲到了妈妈的身后。', pinyin: 'Xiǎo nǚhái yí jiàn dào shēngrén jiù yǒuxiē hàixiū, qiāoqiāo duǒ dào le māma de shēnhòu.', meaning_vi: 'Bé gái hễ gặp người lạ là có phần thẹn thùng, khẽ nép mình trốn sau lưng mẹ.', difficulty_level: 'basic' },
      { chinese: '在跨文化商务沟通场合，初入职场的新人应当克服害羞畏缩的心理，自信大方地展示个人专业见解。', pinyin: 'Zài kuà-wénhuà shāngwù gōutōng chǎnghé, chū rù zhíchǎng de xīnrén yīngdāng kèfú hàixiū wèisuō de xīnlǐ, zìxìn dàfāng de zhǎnshì gèrén zhuānyè jiànjiě.', meaning_vi: 'Trong các dịp giao tiếp thương mại đa văn hóa, người mới bước chân vào chốn công sở nên khắc phục tâm lý ngại ngùng rụt rè, tự tin đĩnh đạc thể hiện kiến giải chuyên môn của bản thân.', difficulty_level: 'applied' }
    ]
  },
  // 1285. 寒假
  {
    hanzi: '寒假',
    pinyin: 'hánjià',
    word_type: 'Danh từ',
    meaning_vi: 'kỳ nghỉ đông',
    examples: [
      { chinese: '今年寒假我打算去北方著名的冰城哈尔滨看冰雕展览。', pinyin: 'Jīnnián hánjià wǒ dǎsuàn qù běifāng zhùmíng de bīngchéng Hā’ěrbīn kàn bīngdiāo zhǎnlǎn.', meaning_vi: 'Kỳ nghỉ đông năm nay tôi dự định đi thành phố băng Cáp Nhĩ Tân nổi tiếng ở phương Bắc để xem triển lãm điêu khắc băng tuyết.', difficulty_level: 'basic' },
      { chinese: '许多大学生选择在充实的寒假期间前往知名企业参与专业实习，以此积累宝贵的行业职场实践经验。', pinyin: 'Xǔduō dàxuésheng xuǎnzé zài chōngshí de hánjià qījiān qiánwǎng zhìmíng qǐyè cānyù zhuānyè shíxí, yǐ cǐ jīlěi bǎoguì de hángyè zhíchǎng shíjiàn jīngyàn.', meaning_vi: 'Nhiều sinh viên đại học lựa chọn đến các doanh nghiệp nổi tiếng tham gia thực tập chuyên ngành trong kỳ nghỉ đông bổ ích, nhằm tích lũy kinh nghiệm thực tế quý báu nơi thương trường công sở.', difficulty_level: 'applied' }
    ]
  },
  // 1286. 寒冷
  {
    hanzi: '寒冷',
    pinyin: 'hánlěng',
    word_type: 'Tính từ',
    meaning_vi: 'lạnh giá, rét buốt',
    examples: [
      { chinese: '冬天的早晨非常寒冷，河面上已经结了一层厚厚的冰。', pinyin: 'Dōngtiān de zǎochén fēicháng hánlěng, hémiàn shang yǐjīng jié le yì céng hòuhòu de bīng.', meaning_vi: 'Buổi sáng mùa đông vô cùng lạnh giá, trên mặt sông đã đóng một lớp băng dày.', difficulty_level: 'basic' },
      { chinese: '在常年极度寒冷的极地科学考察站，科研人员凭借坚韧不拔的钢铁毅力开展了一系列前沿科学探测。', pinyin: 'Zài chángnián jídù hánlěng de jídì kēxué kǎocházhàn, kēyán rényuán píngjiè jiānrèn-bùbá de gāngtiě yìlì kāizhǎn le yí xìliè qiányán kēxué tàncè.', meaning_vi: 'Tại trạm khảo sát khoa học vùng cực quanh năm cực kỳ rét buốt, các nhà nghiên cứu khoa học nhờ vào ý chí gang thép kiên cường bất khuất đã triển khai một loạt thăm dò khoa học tiên phong.', difficulty_level: 'applied' }
    ]
  },
  // 1287. 喊
  {
    hanzi: '喊',
    pinyin: 'hǎn',
    word_type: 'Động từ',
    meaning_vi: 'hét, la to, gọi to',
    examples: [
      { chinese: '球场上的观众大声为自己支持的球队加油呐喊。', pinyin: 'Qiúchǎng shang de guānzhòng dàshēng wèi zìjǐ zhīchí de qiúduì jiāyóu nàhǎn.', meaning_vi: 'Khán giả trên sân vận động lớn tiếng hô to hò reo cổ vũ cho đội bóng mà mình ủng hộ.', difficulty_level: 'basic' },
      { chinese: '在喧闹嘈杂的火灾救援现场，消防指挥员拿着扩音喇叭大声喊着疏散指令，引导被困群众有序安全撤离。', pinyin: 'Zài xuānnào cáozá de huǒzāi jiùyuán xiànchǎng, xiāofáng zhǐhuīyuán názhe kuòyīn lǎba dàshēng hǎn zhe shūsàn zhǐlìng, yǐndǎo bèikùn qúnzhòng yǒuxù ānquán chèlí.', meaning_vi: 'Tại hiện trường cứu nạn hỏa hoạn ồn ào hỗn loạn, người chỉ huy phòng cháy cầm loa phóng thanh hét lớn các mệnh lệnh sơ tán, hướng dẫn người dân bị kẹt rút lui an toàn có trật tự.', difficulty_level: 'applied' }
    ]
  },
  // 1288. 汗
  {
    hanzi: '汗',
    pinyin: 'hàn',
    word_type: 'Danh từ',
    meaning_vi: 'mồ hôi',
    examples: [
      { chinese: '在炎热的太阳底下跑步跑了半小时，他浑身都出了大汗。', pinyin: 'Zài yánrè de tàiyáng dǐxià pǎobù pǎo le bàn xiǎoshí, tā húnshēn dōu chū le dà hàn.', meaning_vi: 'Chạy bộ dưới ánh mặt trời gay gắt suốt nửa tiếng đồng hồ, khắp người anh ấy toát đầy mồ hôi.', difficulty_level: 'basic' },
      { chinese: '每一座拔地而起的现代化宏伟建筑，无不凝结着千千万万普通一线建设者辛勤耕耘的辛劳汗水与智慧心血。', pinyin: 'Měi yí zuò bádì’érqǐ de xiàndàihuà hóngwěi jiànzhù, wúbù níngjié zhe qiānqiān-wànwàn pǔtōng yīxiàn jiànshèzhě xīnqín gēngyún de xīnláo hànshuǐ yǔ zhìhuì xīnxuè.', meaning_vi: 'Mỗi công trình kiến trúc hiện đại nguy nga mọc lên từ mặt đất, không nơi nào là không kết tinh từ những giọt mồ hôi lao khổ và tâm huyết trí tuệ miệt mài của muôn vàn người thợ xây dựng tuyến đầu bình dị.', difficulty_level: 'applied' }
    ]
  },
  // 1289. 航班
  {
    hanzi: '航班',
    pinyin: 'hángbān',
    word_type: 'Danh từ',
    meaning_vi: 'chuyến bay',
    examples: [
      { chinese: '请旅客朋友们注意，飞往上海的CA1835次航班现在开始登机了。', pinyin: 'Qǐng lǚkè péngyoumen zhùyì, fēi wǎng Shànghǎi de CA1835 cì hángbān xiànzài kāishǐ dēngjī le.', meaning_vi: 'Xin quý hành khách chú ý, chuyến bay số hiệu CA1835 bay tới Thượng Hải hiện tại bắt đầu lên máy bay.', difficulty_level: 'basic' },
      { chinese: '由于目的地机场出现突发强雷暴极端恶劣天气，航空公司不得不临时取消或推迟部分国际客运航班。', pinyin: 'Yóuyú mùdìdì jīchǎng chūxiàn tūfā qiáng léibào jíduān èliè tiānqì, hángkōng gōngsī bùdébù línshí qǔxiāo huò tuīchí bùfen guójì kèyùn hángbān.', meaning_vi: 'Do sân bay điểm đến bất ngờ xuất hiện thời tiết cực đoan giông bão mạnh, hãng hàng không buộc phải tạm thời hủy hoặc lùi giờ một số chuyến bay chở khách quốc tế.', difficulty_level: 'applied' }
    ]
  },
  // 1290. 好处
  {
    hanzi: '好处',
    pinyin: 'hǎochù',
    word_type: 'Danh từ',
    meaning_vi: 'lợi ích, điểm tốt, điểm có lợi',
    examples: [
      { chinese: '养成早睡早起的好习惯对身体健康有极大的好处。', pinyin: 'Yǎngchéng zǎoshuì-zǎoqǐ de hǎo xíguàn duì shēntǐ jiànkāng yǒu jídà de hǎochù.', meaning_vi: 'Rèn luyện thói quen tốt ngủ sớm dậy sớm có lợi ích vô cùng to lớn đối với sức khỏe thể chất.', difficulty_level: 'basic' },
      { chinese: '引入全自动化现代智能流水线，不仅能大幅降低企业的人力用工成本，更长远的好处在于全面提升产品良品率与质量稳定性。', pinyin: 'Yǐnrù quán zìdònghuà xiàndài zhìnéng liúshuǐxiàn, bùjǐn néng dàfú jiàngdī qǐyè de rénlì yònggōng chéngběn, gèng chángyuǎn de hǎochù zàiyú quánmiàn tíshēng chǎnpǐn liángpǐnlǜ yǔ zhìliàng wěndìngxìng.', meaning_vi: 'Đưa vào dây chuyền thông minh hiện đại hoàn toàn tự động không chỉ cắt giảm đáng kể chi phí nhân công của doanh nghiệp, mà điểm có lợi lâu dài hơn là nâng cao toàn diện tỷ lệ đạt chuẩn của sản phẩm và độ ổn định chất lượng.', difficulty_level: 'applied' }
    ]
  },
  // 1291. 好好
  {
    hanzi: '好好',
    pinyin: 'hǎohǎo',
    word_type: 'Phó từ / Tính từ',
    meaning_vi: 'tử tế, cẩn thận, chu đáo, hết mình (làm tốt)',
    examples: [
      { chinese: '周末你辛苦工作了一周，应该在家里好好休息放松一下。', pinyin: 'Zhōumò nǐ xīnkǔ gōngzuò le yì zhōu, yīnggāi zài jiā lǐ hǎohǎo xiūxi fàngsōng yíxià.', meaning_vi: 'Cuối tuần bạn đã làm việc vất vả suốt cả tuần, nên ở nhà nghỉ ngơi thư giãn thật tử tế một chút.', difficulty_level: 'basic' },
      { chinese: '在正式向投资人路演之前，创业团队应当好好梳理商业计划书中的核心商业模式与财务预测数据。', pinyin: 'Zài zhèngshì xiàng tóuzīrén lùyǎn zhīqián, chuàngyè tuánduì yīngdāng hǎohǎo shūlǐ shāngyè jìhuàshū zhōng de héxīn shāngyè móshì yǔ cáiwù yùcè shùjù.', meaning_vi: 'Trước khi chính thức thuyết trình gọi vốn trước các nhà đầu tư, nhóm khởi nghiệp nên rà soát thật kỹ lưỡng mô hình kinh doanh cốt lõi và số liệu dự báo tài chính trong bản kế hoạch kinh doanh.', difficulty_level: 'applied' }
    ]
  },
  // 1292. 好笑
  {
    hanzi: '好笑',
    pinyin: 'hǎoxiào',
    word_type: 'Tính từ',
    meaning_vi: 'buồn cười, nực cười, hài hước',
    examples: [
      { chinese: '他刚才讲的那个幽默笑话实在太好笑了，把全班同学都逗乐了。', pinyin: 'Tā gāngcái jiǎng de nà gè yōumò xiàohua shízài tài hǎoxiào le, bǎ quán bān tóngxué dōu dòulè le.', meaning_vi: 'Câu chuyện cười hài hước anh ấy vừa kể thực sự quá buồn cười, khiến cả lớp ai nấy đều bật cười khoái chí.', difficulty_level: 'basic' },
      { chinese: '这部喜剧电影通过一系列荒诞好笑的情节反差，深刻讽刺了现实生活中盲目跟风与虚荣浮夸的社会现象。', pinyin: 'Zhè bù xǐjù diànyǐng tōngguò yí xìliè huāngdàn hǎoxiào de qíngjié fǎnchà, shēnkè fěngcì le xiànshí shēnghuó zhōng mángmù gēnfēng yǔ xūróng fúkuā de shèhuì xiànxiàng.', meaning_vi: 'Bộ phim hài kịch này thông qua một loạt tình tiết tương phản hoang đường buồn cười đã châm biếm sâu cay hiện tượng xã hội a dua mù quáng và khoe khoang phù phiếm trong đời sống thực tế.', difficulty_level: 'applied' }
    ]
  },
  // 1293. 合格
  {
    hanzi: '合格',
    pinyin: 'hégé',
    word_type: 'Tính từ',
    meaning_vi: 'đạt chuẩn, hợp cách, đủ tiêu chuẩn',
    examples: [
      { chinese: '经过三个月的岗前培训与考核，他终于成为了一名合格的软件工程师。', pinyin: 'Jīngguò sān gè yuè de gǎngqián péixùn yǔ kǎohé, tā zhōngyú chéngwéi le yì míng hégé de ruǎnjiàn gōngchéngshī.', meaning_vi: 'Trải qua ba tháng đào tạo tiền công tác và sát hạch, cuối cùng anh ấy đã trở thành một kỹ sư phần mềm đạt chuẩn.', difficulty_level: 'basic' },
      { chinese: '出厂检验部门严格把控产品品质，任何未达到国家安全卫生标准的不合格产品一律严禁流入消费市场。', pinyin: 'Chūchǎng jiǎnyàn bùmén yángé bǎkòng chǎnpǐn pǐnzhì, rènhé wèi dádào guójiā ānquán wèishēng biāozhǔn de bù hégé chǎnpǐn yílǜ yánjìn liúrù xiāofèi shìchǎng.', meaning_vi: 'Bộ phận kiểm nghiệm xuất xưởng kiểm soát chặt chẽ phẩm chất sản phẩm, bất kỳ sản phẩm không đạt chuẩn nào chưa đáp ứng tiêu chuẩn an toàn vệ sinh quốc gia đều bị nghiêm cấm tuồn ra thị trường tiêu dùng.', difficulty_level: 'applied' }
    ]
  },
  // 1294. 盒子
  {
    hanzi: '盒子',
    pinyin: 'hézi',
    word_type: 'Danh từ',
    meaning_vi: 'cái hộp, chiếc hộp',
    examples: [
      { chinese: '他把精美的项链小心翼翼地放进了一个红色的首饰盒子里。', pinyin: 'Tā bǎ jīngměi de xiàngliàn xiǎoxīn-yìyì de fàng jìn le yí gè hóngsè de shǒushì hézi lǐ.', meaning_vi: 'Anh ấy cẩn thận từng li từng tí đặt chiếc dây chuyền tinh xảo vào trong một chiếc hộp trang sức màu đỏ.', difficulty_level: 'basic' },
      { chinese: '这家高端糕点品牌特别设计了融入中国传统剪纸艺术元素的精美礼品包装盒子，深受节日送礼市场的欢迎。', pinyin: 'Zhè jiā gāoduān gāodiǎn pǐnpái tèbié shèjì le róngrù Zhōngguó chuántǒng jiǎnzhǐ yìshù yuánsù de jīngměi lǐpǐn bāozhuāng hézi, shēn shòu jiérì sònglǐ shìchǎng de huānyíng.', meaning_vi: 'Thương hiệu bánh ngọt cao cấp này đã đặc biệt thiết kế chiếc hộp bao bì quà tặng tinh xảo lồng ghép các yếu tố nghệ thuật cắt giấy truyền thống Trung Hoa, rất được thị trường quà biếu lễ tết hoan nghênh.', difficulty_level: 'applied' }
    ]
  },
  // 1295. 红包
  {
    hanzi: '红包',
    pinyin: 'hóngbāo',
    word_type: 'Danh từ',
    meaning_vi: 'lì xì, phong bao đỏ, tiền mừng tuổi',
    examples: [
      { chinese: '每年除夕夜，长辈们都会给小孩子们发装满压岁钱的红包。', pinyin: 'Měi nián chúxīyè, zhǎngbèimen dōu huì gěi xiǎoháizimen fā zhuāng mǎn yàsuìqián de hóngbāo.', meaning_vi: 'Vào đêm giao thừa mỗi năm, các bậc trưởng bối đều phát phong bao lì xì đựng đầy tiền mừng tuổi cho con cháu nhỏ.', difficulty_level: 'basic' },
      { chinese: '在互联网时代，除夕春晚期间在手机社交软件上抢数字电子红包，已经演变成当代中国家庭极具趣味的新民俗。', pinyin: 'Zài hùliánwǎng shídài, chúxī chūnwǎn qījiān zài shǒujī shèjiāo ruǎnjiàn shang qiǎng shùzì diànzǐ hóngbāo, yǐjīng yǎnbiàn chéng dāngdài Zhōngguó jiātíng jí jù qùwèi de xīn mínsú.', meaning_vi: 'Trong thời đại internet, việc giật bao lì xì điện tử kỹ thuật số trên ứng dụng mạng xã hội điện thoại trong chương trình Gala đêm giao thừa đã phát triển thành một phong tục tập quán mới đầy thú vị của các gia đình Trung Quốc đương đại.', difficulty_level: 'applied' }
    ]
  },
  // 1296. 厚
  {
    hanzi: '厚',
    pinyin: 'hòu',
    word_type: 'Tính từ',
    meaning_vi: 'dày; sâu đậm (tình cảm)',
    examples: [
      { chinese: '冬天出门的时候要多穿一件厚外套，注意防寒保暖。', pinyin: 'Dōngtiān chūmén de shíhou yào duō chuān yí jiàn hòu wàitào, zhùyì fánghán bǎonuǎn.', meaning_vi: 'Mùa đông khi ra ngoài phải mặc thêm một chiếc áo khoác dày, chú ý chống rét giữ ấm.', difficulty_level: 'basic' },
      { chinese: '这本地理学术专著足足有七百多页厚，详尽系统地记录了我国近半个世纪以来地质变迁的第一手珍贵观测数据。', pinyin: 'Zhè běn dìlǐ xuéshù zhuānzhù zúzú yǒu qī bǎi duō yè hòu, xiángjìn xìtǒng de jìlù le wǒ guó jìn bàn gè shìjì yǐlái dìzhì biànqiān de dì-yī shǒu zhēnguì guāncè shùjù.', meaning_vi: 'Cuốn chuyên khảo học thuật địa lý này dày tới hơn 700 trang, ghi chép một cách tường tận có hệ thống những số liệu quan sát quý giá trực tiếp về biến đổi địa chất nước ta trong suốt gần nửa thế kỷ qua.', difficulty_level: 'applied' }
    ]
  },
  // 1297. 后悔
  {
    hanzi: '后悔',
    pinyin: 'hòuhuǐ',
    word_type: 'Động từ',
    meaning_vi: 'hối hận, ân hận',
    examples: [
      { chinese: '他非常后悔当初没有听从父母和老师的善意劝告。', pinyin: 'Tā fēicháng hòuhuǐ dāngchū méiyǒu tīngcóng fùmǔ hé lǎoshī de shànyì quàngào.', meaning_vi: 'Anh ấy vô cùng hối hận vì lúc ban đầu đã không nghe theo lời khuyên bảo thiện chí của cha mẹ và thầy cô.', difficulty_level: 'basic' },
      { chinese: '青年人在做重大的职业抉择与人生规划时应当深思熟虑，切忌盲目跟风盲从，免得日后追悔莫及。', pinyin: 'Qīngniánrén zài zuò zhòngdà de zhíyè juézé yǔ rénshēng guīhuà shí yīngdāng shēnsī-shúlǜ, qièjì mángmù gēnfēng mángcóng, miǎnde rìhòu zhuīhuǐ-mòjí.', meaning_vi: 'Người trẻ tuổi khi đưa ra những quyết sách nghề nghiệp và định hướng cuộc đời trọng đại cần suy nghĩ chín chắn thấu đáo, tránh học đòi a dua mù quáng kẻo sau này hối hận không kịp.', difficulty_level: 'applied' }
    ]
  },
  // 1298. 忽然
  {
    hanzi: '忽然',
    pinyin: 'hūrán',
    word_type: 'Phó từ',
    meaning_vi: 'đột nhiên, bỗng nhiên, bỗng chốc',
    examples: [
      { chinese: '刚才还是晴空万里，忽然天空中刮起了一阵狂风。', pinyin: 'Gāngcái hái shì qíngkōng-wànlǐ, hūrán tiānkōng zhōng guā qǐ le yí zhèn kuángfēng.', meaning_vi: 'Mới ban nãy bầu trời còn quang đãng vạn dặm, bỗng nhiên giữa tầng không nổi lên một cơn cuồng phong.', difficulty_level: 'basic' },
      { chinese: '在实验室通宵达旦反复攻关的关键时刻，他脑海中忽然闪现出一个全新算法的灵感，从而一举攻克了核心技术难题。', pinyin: 'Zài shíyànshì tōngxiāo-dádàn fǎnfù gōngguān de guānjiàn shíkè, tā nǎohǎi zhōng hūrán shǎnxiàn chū yí gè quánxīn suànfǎ de línggǎn, cóng’ér yījǔ gōngkè le héxīn jìshù nántí.', meaning_vi: 'Vào thời khắc then chốt thức thâu đêm suốt sáng liên tục đột phá trong phòng thí nghiệm, trong tâm trí anh ấy bỗng lóe lên nguồn cảm hứng về một thuật toán hoàn toàn mới, nhờ đó đánh bại được vấn đề kỹ thuật cốt lõi trong một lần.', difficulty_level: 'applied' }
    ]
  },
  // 1299. 互联网
  {
    hanzi: '互联网',
    pinyin: 'hùliánwǎng',
    word_type: 'Danh từ',
    meaning_vi: 'internet, mạng internet',
    examples: [
      { chinese: '如今人们足不出户就可以通过互联网轻松购物和浏览新闻。', pinyin: 'Rújīn rénmen zúbùchūhù jiù kěyǐ tōngguò hùliánwǎng qīngsōng gòuwù hé liúlǎn xīnwén.', meaning_vi: 'Ngày nay người ta không cần bước chân ra khỏi cửa là đã có thể dễ dàng mua sắm và đọc tin tức qua mạng internet.', difficulty_level: 'basic' },
      { chinese: '“互联网+”与实体经济的深度融合，正在深刻重塑传统制造业、现代物流业以及金融服务的产业生态模式。', pinyin: '“Hùliánwǎng jia” yǔ shítǐ jīngjì de shēndù rónghé, zhèngzài shēnkè chóngsù chuántǒng zhìzàoyè, xiàndài wùliúyè yǐjí jīnróng fúwù de chǎnyè shēngtài móshì.', meaning_vi: 'Sự kết hợp sâu sắc giữa "Internet+" và nền kinh tế thực đang tái định hình sâu rộng mô hình hệ sinh thái công nghiệp của ngành sản xuất truyền thống, logistics hiện đại cũng như dịch vụ tài chính.', difficulty_level: 'applied' }
    ]
  },
  // 1300. 护士
  {
    hanzi: '护士',
    pinyin: 'hùshi',
    word_type: 'Danh từ',
    meaning_vi: 'y tá, điều dưỡng viên',
    examples: [
      { chinese: '病房里的护士态度非常温和耐心，细致地为病人测量体温和换药。', pinyin: 'Bìngfáng lǐ de hùshi tàidu fēicháng wēnhé nàixīn, xìzhì de wèi bìngrén cèliáng tǐwēn hé huànyào.', meaning_vi: 'Y tá trong phòng bệnh thái độ vô cùng hòa nhã kiên nhẫn, tỉ mỉ đo nhiệt độ và thay thuốc cho người bệnh.', difficulty_level: 'basic' },
      { chinese: '广大医务工作者特别是临床一线护士在疫情防控与危重症救治中不畏艰险白衣执甲，践行了崇高的救死扶伤人道主义精神。', pinyin: 'Guǎngdà yīwù gōngzuòzhě tèbié shì línchuáng yīxiàn hùshi zài yìqíng fángkòng yǔ wēizhòngzhèng jiùzhì zhōng bú wèi jiānxiǎn bái yī zhí jiǎ, jiànxíng le chónggāo de jiùsǐ-fúshāng réndàozhǔyì jīngshén.', meaning_vi: 'Đông đảo cán bộ nhân viên y tế đặc biệt là điều dưỡng viên tuyến đầu lâm sàng trong công tác phòng chống dịch bệnh và cứu chữa bệnh nặng nguy kịch không quản ngại hiểm nguy khoác áo blouse trắng xông pha, hiện thực hóa tinh thần nhân đạo cứu người cao quý.', difficulty_level: 'applied' }
    ]
  }
]

console.log('HSK 4 Batch 3 loaded successfully with 100 items and 200 examples!')
