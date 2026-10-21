// data/hsk5-batch10-part1-data.ts
// 25 từ HSK 5: #2902 [全体] -> #2926 [人体]

export interface ExampleItem {
  chinese: string
  pinyin: string
  meaning_vi: string
  difficulty_level: 'basic' | 'applied'
}

export interface VocabItem {
  id: number
  hanzi: string
  pinyin: string
  word_type: string
  meaning_vi: string
  examples: ExampleItem[]
}

export const HSK5_BATCH10_PART1: VocabItem[] = [
  {
    id: 2902,
    hanzi: '全体',
    pinyin: 'quántǐ',
    word_type: 'Danh từ',
    meaning_vi: 'toàn thể, tất cả thành viên',
    examples: [
      {
        chinese: '大会开幕时，全体与会代表起立齐唱国歌。',
        pinyin: 'Dàhuì kāimù shí, quántǐ yùhuì dàibiǎo qǐlì qíchàng guógē.',
        meaning_vi: 'Khi đại hội khai mạc, toàn thể đại biểu tham dự đứng dậy cùng hát vang quốc ca.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在全体研发人员夜以继日的协同攻关下，核心操作系统原型测试获得圆满成功。',
        pinyin: 'Zài quántǐ yánfā rényuán yèyǐjìrì de xiétóng gōngguān xià, héxīn cāozuò xìtǒng yuánxíng cèshì huòdé yuánmǎn chénggōng.',
        meaning_vi: 'Dưới nỗ lực hiệp đồng khắc phục khó khăn ngày đêm của toàn thể đội ngũ nghiên cứu phát triển, việc thử nghiệm nguyên mẫu hệ điều hành cốt lõi đã đạt thành công viên mãn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2903,
    hanzi: '全新',
    pinyin: 'quánxīn',
    word_type: 'Tính từ',
    meaning_vi: 'hoàn toàn mới, mới toanh',
    examples: [
      {
        chinese: '新学期开始后，校园里呈现出一片全新而充满活力的气象。',
        pinyin: 'Xīn xuéqī kāishǐ hòu, xiàoyuán lǐ chéngxiàn chū yí piàn quánxīn ér chōngmǎn huólì de qìxiàng.',
        meaning_vi: 'Sau khi học kỳ mới bắt đầu, trong khuôn viên trường hiện lên một bầu không khí hoàn toàn mới và tràn đầy sức sống.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业依托自主前沿科技推出了全新一代智能化生产制造系统，大幅提升了产线柔性与运行能效。',
        pinyin: 'Qǐyè yītuō zìzhǔ qiányán kējì tuīchū le quánxīn yí dài zhìnénghuà shēngchǎn zhìzào xìtǒng, dàfú tíshēng le chǎnxiàn róuxìng yǔ yùnxíng néngxiào.',
        meaning_vi: 'Doanh nghiệp dựa vào khoa học công nghệ mũi nhọn tự chủ đã cho ra mắt hệ thống sản xuất chế tạo thông minh thế hệ hoàn toàn mới, nâng cao đáng kể độ linh hoạt và hiệu suất năng lượng của dây chuyền.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2904,
    hanzi: '劝',
    pinyin: 'quàn',
    word_type: 'Động từ',
    meaning_vi: 'khuyên bảo, can ngăn, khuyên giải',
    examples: [
      {
        chinese: '医生再三劝他戒烟戒酒，平时要多注意饮食健康。',
        pinyin: 'Yīshēng zàisān quàn tā jièyān-jièjiǔ, píngshí yào duō zhùyì yǐnshí jiànkāng.',
        meaning_vi: 'Bác sĩ nhiều lần khuyên anh ấy bỏ thuốc lá cai rượu bia, ngày thường nên chú ý ăn uống lành mạnh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对情绪激动的争议双方，人民调解员以法释理、耐心规劝，最终促使双方握手言和达成和解。',
        pinyin: 'Miànduì qíngxù jīdòng de zhēngyì shuāngfāng, rénmín tiáojiěyuán yǐ fǎ shì lǐ, nàixīn guīquàn, zuìzhōng cùshǐ shuāngfāng wòshǒu-yánhé dáchéng héjiě.',
        meaning_vi: 'Đối mặt với đôi bên tranh chấp đang xúc động mất bình tĩnh, hòa giải viên nhân dân lấy luật giải thích lý lẽ, kiên nhẫn khuyên giải, cuối cùng thúc đẩy hai bên bắt tay làm hòa đạt được thỏa thuận giải quyết.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2905,
    hanzi: '缺乏',
    pinyin: 'quēfá',
    word_type: 'Động từ',
    meaning_vi: 'thiếu thốn, thiếu hụt, không đủ',
    examples: [
      {
        chinese: '长期缺乏体育锻炼会导致身体抵抗力明显下降。',
        pinyin: 'Chángqī quēfá tǐyù duànliàn huì dǎozhì shēntǐ dǐkànglì míngxiǎn xiàjiàng.',
        meaning_vi: 'Lâu ngày thiếu rèn luyện thể dục thể thao sẽ dẫn đến sức đề kháng của cơ thể sụt giảm rõ rệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '部分初创科技企业虽有优秀创意，但因缺乏充足的资本积累与产业化落地经验而陷入成长困局。',
        pinyin: 'Bùfen chūchuàng kējì qǐyè suī yǒu yōuxiù chuàngyì, dàn yīn quēfá chōngzú de zīběn jīlěi yǔ chǎnyèhuà luòdì jīngyàn ér xiànrù chéngzhǎng kùnjú.',
        meaning_vi: 'Một số doanh nghiệp khởi nghiệp công nghệ tuy có ý tưởng sáng tạo tuyệt vời nhưng vì thiếu tích lũy nguồn vốn đầy đủ và thiếu kinh nghiệm triển khai sản xuất thực tế nên rơi vào bế tắc tăng trưởng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2906,
    hanzi: '确保',
    pinyin: 'quèbǎo',
    word_type: 'Động từ',
    meaning_vi: 'bảo đảm, chắc chắn, giữ gìn chắc',
    examples: [
      {
        chinese: '学校食堂每天严格消毒餐具，确保广大师生的饮食卫生安全。',
        pinyin: 'Xuéxiào shítáng měitiān yángé xiāodú cānjù, quèbǎo guǎngdà shīshēng de yǐnshí wèishēng ānquán.',
        meaning_vi: 'Căng tin trường học mỗi ngày đều khử trùng nghiêm ngặt đồ dùng ăn uống, bảo đảm an toàn vệ sinh ăn uống cho đông đảo thầy trò.',
        difficulty_level: 'basic'
      },
      {
        chinese: '水利工程指挥部科学调度沿线防洪枢纽与分洪通道，确保大江大河在特大暴雨汛期安澜无恙。',
        pinyin: 'Shuǐlì gōngchéng zhǐhuībù kēxué diàodù yánxiàn fánghóng shūniǔ yǔ fēnhóng tōngdào, quèbǎo dàjiāng-dàhé zài tèdà bàoyǔ xùnqī ānlán-wúyàng.',
        meaning_vi: 'Ban chỉ huy công trình thủy lợi điều tiết khoa học các đầu mối chống lũ và phân lũ dọc tuyến, bảo đảm các dòng sông lớn bình yên an toàn trong mùa lũ mưa bão đặc biệt nghiêm trọng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2907,
    hanzi: '确定',
    pinyin: 'quèdìng',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'xác định, khẳng định; chắc chắn',
    examples: [
      {
        chinese: '经过多次协商，大家终于确定了周末集体出游的具体时间和路线。',
        pinyin: 'Jīngguò duō cì xiéshāng, dàjiā zhōngyú quèdìng le zhōumò jítǐ chūyóu de jùtǐ shíjiān hé lùxiàn.',
        meaning_vi: 'Sau nhiều lần bàn bạc, mọi người cuối cùng đã xác định được thời gian và tuyến đường cụ thể của chuyến đi chơi tập thể cuối tuần.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在制定新一轮城市综合交通总体规划前，专家组必须科学确定客流走廊与关键轨道交通骨干网络。',
        pinyin: 'Zài zhìdìng xīn yì lún chéngshì zōnghé jiāotōng zǒngtǐ guīhuà qián, zhuānjiāzǔ bìxū kēxué quèdìng kèliú zǒuláng yǔ guānjiàn guǐdào jiāotōng gǔgàn wǎngluò.',
        meaning_vi: 'Trước khi xây dựng quy hoạch tổng thể giao thông tích hợp đô thị vòng mới, tổ chuyên gia bắt buộc phải xác định một cách khoa học các hành lang luồng hành khách và mạng lưới đường sắt đô thị trục then chốt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2908,
    hanzi: '确认',
    pinyin: 'quèrèn',
    word_type: 'Động từ',
    meaning_vi: 'xác nhận, khẳng định lại',
    examples: [
      {
        chinese: '网上支付成功后，手机屏幕上立即弹出了订单确认的提示信息。',
        pinyin: 'Wǎngshàng zhīfù chénggōng hòu, shǒujī píngmù shang lìjí tán chū le dìngdān quèrèn de tíshì xìnxī.',
        meaning_vi: 'Sau khi thanh toán trực tuyến thành công, màn hình điện thoại lập tức hiển thị thông tin nhắc nhở xác nhận đơn hàng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '买卖双方授权代表签署书面交付清单，正式确认大型成套工业设备已按合同标准验收合格。',
        pinyin: 'Mǎimài shuāngfāng shòuquán dàibiǎo qiānshǔ shūmiàn jiāofù qīngdān, zhèngshì quèrèn dàxíng chéngtào gōngyè shèbèi yǐ àn hétong biāozhǔn yànshōu hégé.',
        meaning_vi: 'Đại diện được ủy quyền của hai bên mua bán đã ký biên bản bàn giao bằng văn bản, chính thức xác nhận toàn bộ thiết bị công nghiệp đồng bộ quy mô lớn đã được nghiệm thu đạt chuẩn theo hợp đồng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2909,
    hanzi: '群',
    pinyin: 'qún',
    word_type: 'Lượng từ / Danh từ',
    meaning_vi: 'bầy, đàn, nhóm, tốp',
    examples: [
      {
        chinese: '蔚蓝的天空中飞过一群候鸟，朝着温暖的南方展翅翱翔。',
        pinyin: 'Wèilán de tiānkōng zhōng fēi guò yì qún hòuniǎo, cháozhe wēnnuǎn de nánfāng zhǎnchì áoxiáng.',
        meaning_vi: 'Trên bầu trời xanh biếc bay qua một đàn chim di cư, sải cánh bay lượn về phía phương Nam ấm áp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '围绕国家重点实验室建设高水平青年学者创新群，是加速前沿基础理论研究突破的重要组织范式。',
        pinyin: 'Wéirào guójiā zhòngdiǎn shíyànshì jiànshè gāo-shuǐpíng qīngnián xuézhě chuàngxīn qún, shì jiāsù qiányán jīchǔ lǐlùn yánjiū tūpò de zhòngyào zǔzhī fànshì.',
        meaning_vi: 'Xoay quanh việc xây dựng phòng thí nghiệm trọng điểm quốc gia để thiết lập nhóm học giả trẻ sáng tạo trình độ cao là chuẩn thức tổ chức quan trọng nhằm thúc đẩy đột phá nghiên cứu lý thuyết cơ bản mũi nhọn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2910,
    hanzi: '群体',
    pinyin: 'qúntǐ',
    word_type: 'Danh từ',
    meaning_vi: 'quần thể, nhóm người, tập thể đối tượng',
    examples: [
      {
        chinese: '关爱老年人群体和残障人士是衡量社会文明进步的重要尺度。',
        pinyin: 'Guān’ài lǎoniánrén qúntǐ hé cánzhàng rénshì shì héngliáng shèhuì wénmíng jìnbù de zhòngyào chǐdù.',
        meaning_vi: 'Quan tâm chăm sóc nhóm người cao tuổi và người khuyết tật là thước đo quan trọng để đánh giá sự tiến bộ văn minh của xã hội.',
        difficulty_level: 'basic'
      },
      {
        chinese: '流行病学专家借助大数据轨迹分析，对特定易感人群群体开展靶向精准筛查与动态免疫保护。',
        pinyin: 'Liúxíngbìngxué zhuānjiā jièzhù dà-shùjù guǐjì fēnxī, duì tèdìng yìgǎn rénqún qúntǐ kāizhǎn bǎxiàng jīngzhǔn shāichá yǔ dòngtài miǎnyì bǎohù.',
        meaning_vi: 'Các chuyên gia dịch tễ học nhờ phân tích dấu vết dữ liệu lớn đã triển khai sàng lọc chính xác trúng đích và bảo vệ miễn dịch động đối với quần thể người có nguy cơ cảm nhiễm cao cụ thể.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2911,
    hanzi: '燃烧',
    pinyin: 'ránshāo',
    word_type: 'Động từ',
    meaning_vi: 'cháy, đốt cháy, bốc hỏa',
    examples: [
      {
        chinese: '寒冷的冬夜里，壁炉中干柴烈火旺盛地燃烧着，给整间屋子带来了融融暖意。',
        pinyin: 'Hánlěng de dōngyè lǐ, bìlú zhōng gānchái-lièhuǒ wàngshèng de ránshāo zhe, gěi zhěng jiān wūzi dài lái le róngróng nuǎnyì.',
        meaning_vi: 'Trong đêm đông giá lạnh, củi khô trong lò sưởi bốc cháy bập bùng dữ dội, mang lại hơi ấm ngập tràn cho cả căn phòng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '新型重型运载火箭采用液氧煤油高压补燃循环发动机，实现了极佳的燃烧效率与超高推进推力。',
        pinyin: 'Xīnxíng zhòngxíng yùnzài huǒjiàn cǎiyòng yèyǎng méiyóu gāoyā bǔrán xúnhuán fādòngjī, shíxiàn le jí jiā de ránshāo xiàolǜ yǔ chāo-gāo tuījìn tuīlì.',
        meaning_vi: 'Tên lửa đẩy hạng nặng kiểu mới ứng dụng động cơ chu trình đốt bổ sung cao áp oxy lỏng - dầu hỏa, đạt được hiệu suất cháy cực tốt cùng lực đẩy phản lực siêu lớn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2912,
    hanzi: '绕',
    pinyin: 'rào',
    word_type: 'Động từ',
    meaning_vi: 'đi vòng, uốn lượn, quấn quanh',
    examples: [
      {
        chinese: '前方路段正在施工维修，司机师傅只好驾驶汽车绕道而行。',
        pinyin: 'Qiánfāng lùduàn zhèngzài shīgōng wéixiū, sījī shīfu zhǐhǎo jiàshǐ qìchē ràodào ér xíng.',
        meaning_vi: 'Đoạn đường phía trước đang thi công sửa chữa, bác tài xế đành phải lái xe đi đường vòng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '月球探测器在完成变轨机动后，顺利进入距离月面一百公里的近圆形环月绕飞轨道运行。',
        pinyin: 'Yuèqiú tàncèqì zài wánchéng biànguǐ jīdòng hòu, shùnlì jìnrù jùlí yuèmiàn yìbǎi gōnglǐ de jìn-yuánxíng huányuè ràofēi guǐdào yùnxíng.',
        meaning_vi: 'Tàu thăm dò mặt trăng sau khi hoàn thành thao tác đổi quỹ đạo đã thuận lợi tiến vào vận hành trên quỹ đạo bay lượn quanh mặt trăng gần hình tròn cách bề mặt mặt trăng một trăm kilomet.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2913,
    hanzi: '热爱',
    pinyin: 'rè’ài',
    word_type: 'Động từ',
    meaning_vi: 'yêu tha thiết, nồng nhiệt yêu',
    examples: [
      {
        chinese: '他从小就非常热爱绘画，立志将来成为一名优秀的插画艺术家。',
        pinyin: 'Tā cóngxiǎo jiù fēicháng rè’ài huìhuà, lìzhì jiānglái chéngwéi yì míng yōuxiù de chāhuà yìshùjiā.',
        meaning_vi: 'Từ nhỏ anh ấy đã rất say mê hội họa, lập chí sau này trở thành một nghệ sĩ vẽ tranh minh họa xuất sắc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '无论面对多么艰苦卓绝的边远野外考察环境，老一辈地质学家始终深沉热爱着脚下辽阔的祖国山河。',
        pinyin: 'Wúlùn miànduì duōme jiānkǔ-zhuójué de biānyuǎn yěwài kǎochá huánjìng, lǎoyíbèi dìzhìxuéjiā shǐzhōng shēnchén rè’ài zhe jiǎoxià liáokuò de zǔguó shānhé.',
        meaning_vi: 'Bất luận phải đối mặt với môi trường khảo sát dã ngoại biên cương gian khổ khốc liệt đến mức nào, thế hệ các nhà địa chất đi trước vẫn luôn yêu thương sâu nặng từng tấc giang sơn gấm vóc dưới chân mình.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2914,
    hanzi: '热量',
    pinyin: 'rèliàng',
    word_type: 'Danh từ',
    meaning_vi: 'nhiệt lượng, lượng calo',
    examples: [
      {
        chinese: '油炸食品和含糖奶茶热量很高，经常食用容易导致身体发胖。',
        pinyin: 'Yóuzhá shípǐn hé hán táng nǎichá rèliàng hěn gāo, chángcháng shíyòng róngyì dǎozhì shēntǐ fāpàng.',
        meaning_vi: 'Đồ ăn chiên rán và trà sữa nhiều đường có lượng calo rất cao, thường xuyên ăn dùng dễ dẫn đến tăng cân béo phì.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在工业热工水力系统中，精准计算流体传热系数与核心热量耗散速率是优化反应堆安全边界的前提。',
        pinyin: 'Zài gōngyè règōng shuǐlì xìtǒng zhōng, jīngzhǔn jìsuàn liútǐ chuánrè xìshù yǔ héxīn rèliàng hàosàn sùlǜ shì yōuhuà fǎnyìngduī ānquán biānjiè de qiántí.',
        meaning_vi: 'Trong hệ thống nhiệt thủy lực công nghiệp, việc tính toán chuẩn xác hệ số truyền nhiệt chất lưu và tốc độ tiêu tán nhiệt lượng vùng lõi là tiền đề để tối ưu hóa ranh giới an toàn của lò phản ứng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2915,
    hanzi: '热烈',
    pinyin: 'rèliè',
    word_type: 'Tính từ',
    meaning_vi: 'nhiệt liệt, sôi nổi, nồng nhiệt',
    examples: [
      {
        chinese: '精彩的杂技表演刚一结束，台下就响起了经久不息的热烈掌声。',
        pinyin: 'Jīngcǎi de zájì biǎoyǎn gāng yì jiéshù, tái xià jiù xiǎng qǐ le jīngjiǔ-bùxī de rèliè zhǎngshēng.',
        meaning_vi: 'Tiết mục xiếc đặc sắc vừa kết thúc, dưới khán đài liền vang lên tràng pháo tay nhiệt liệt kéo dài không ngớt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '围绕人工智能伦理治理新准则，来自全球法学界与科技产业界的青年领军学者展开了异常热烈的圆桌辩论。',
        pinyin: 'Wéirào réngōng zhìnéng lúnlǐ zhìlǐ xīn zhǔnzé, láizì quánqiú fǎxuéjiè yǔ kējì chǎnyèjiè de qīngnián lǐngjūn xuézhě zhǎnkāi le yìcháng rèliè de yuánzhuō biànlùn.',
        meaning_vi: 'Xoay quanh chuẩn tắc quản trị đạo đức trí tuệ nhân tạo mới, các học giả trẻ dẫn đầu đến từ giới luật học và công nghiệp công nghệ toàn cầu đã triển khai cuộc tranh biện bàn tròn hết sức sôi nổi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2916,
    hanzi: '热心',
    pinyin: 'rèxīn',
    word_type: 'Tính từ',
    meaning_vi: 'nhiệt tình, sốt sắng, hăng hái',
    examples: [
      {
        chinese: '邻居王阿姨平时非常热心，总是主动帮社区孤寡老人买菜送药。',
        pinyin: 'Línjū Wáng āyí píngshí fēicháng rèxīn, zǒngshì zhǔdòng bāng shèqū gūguǎ lǎorén mǎi cài sòng yào.',
        meaning_vi: 'Bác Vương hàng xóm ngày thường rất nhiệt tình, luôn chủ động giúp đỡ người già neo đơn trong khu phố đi chợ mua rau mua thuốc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '广大热心公益的爱心志愿者队伍风雨无阻深入偏远山区，为农村留守儿童带去温暖关爱与丰富多彩的书籍文具。',
        pinyin: 'Guǎngdà rèxīn gōngyì de àixīn zhìyuànzhě duìwu fēngyǔ-wúzǔ shēnrù piānyuǎn shāncūn, wèi nóngcūn liúshǒu értóng dài qù wēnnuǎn guān’ài yǔ fēngfù-duōcǎi de shūjí wénjù.',
        meaning_vi: 'Đội ngũ tình nguyện viên giàu lòng nhân ái nhiệt tình với các hoạt động thiện nguyện không quản mưa nắng đi sâu vào các vùng núi hẻo lánh, mang tới tình yêu thương ấm áp cùng sách vở đồ dùng học tập phong phú cho trẻ em nông thôn xa cha mẹ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2917,
    hanzi: '人才',
    pinyin: 'réncái',
    word_type: 'Danh từ',
    meaning_vi: 'nhân tài, người tài giỏi',
    examples: [
      {
        chinese: '一流大学不仅要传授专业知识，更要努力为国家培养各行各业的栋梁人才。',
        pinyin: 'Yīliú dàxué bùjǐn yào chuánshòu zhuānyè zhīshi, gèng yào nǔlì wèi guójiā péiyǎng gè háng gè yè de dòngliáng réncái.',
        meaning_vi: 'Trường đại học hàng đầu không chỉ cần truyền thụ kiến thức chuyên môn mà còn phải nỗ lực đào tạo những nhân tài rường cột cho mọi ngành nghề của đất nước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高新技术产业开发区实施更加开放包容的全球引才引智战略，着力构筑具有国际竞争力的高素质科研人才集聚高地。',
        pinyin: 'Gāoxīn jìshù chǎnyè kāifāqū shíshī gèngjiā kāifàng bāoróng de quánqiú yǐncái yǐnzhì zhànlüè, zhuólì gòuzhù jùyǒu guójì jìngzhēnglì de gāo-sùzhì kēyán réncái jíjù gāodì.',
        meaning_vi: 'Khu công nghiệp kỹ thuật cao triển khai chiến lược thu hút nhân tài và trí tuệ toàn cầu cởi mở và bao dung hơn, tập trung xây dựng mảnh đất màu mỡ tập hợp nhân tài nghiên cứu khoa học chất lượng cao có sức cạnh tranh quốc tế.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2918,
    hanzi: '人工',
    pinyin: 'réngōng',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'nhân tạo, làm thủ công, công thợ',
    examples: [
      {
        chinese: '公园中心有一个清澈美丽的人工湖，周围环绕着垂柳与鹅卵石步道。',
        pinyin: 'Gōngyuán zhōngxīn yǒu yí ge qīngchè měilì de réngōnghú, zhōuwéi huánrào zhe chuíliǔ yǔ éluǎnshí bùdào.',
        meaning_vi: 'Trung tâm công viên có một hồ nước nhân tạo trong lành xinh đẹp, xung quanh có rặng liễu rủ và lối đi lát đá cuội bao quanh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '将生成式人工智能算法与高端工业机器人相结合，正促使传统流水线生产迈向高度自适应智能作业。',
        pinyin: 'Jiāng shēngchéngxìng réngōng zhìnéng suànfǎ yǔ gāoduān gōngyè jīqìrén xiāng jiéhé, zhèng cùshǐ chuántǒng liúshuǐxiàn shēngchǎn mài xiàng gāodù zìshìyìng zhìnéng zuòyè.',
        meaning_vi: 'Việc kết hợp thuật toán trí tuệ nhân tạo tạo sinh với robot công nghiệp cao cấp đang thúc đẩy sản xuất dây chuyền truyền thống tiến bước tới vận hành thông minh có khả năng tự thích ứng cao độ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2919,
    hanzi: '人际',
    pinyin: 'rénjì',
    word_type: 'Tính từ',
    meaning_vi: 'giữa người với người, giao tế, nhân tế',
    examples: [
      {
        chinese: '初入职场的年轻人除了提升专业技能，还要学会处理好良好的人际关系。',
        pinyin: 'Chū rù zhíchǎng de niánqīngrén chúle tíshēng zhuānyè jìnéng, hái yào xuéhuì chǔlǐ hǎo liánghǎo de rénjì guānxì.',
        meaning_vi: 'Người trẻ tuổi mới bước chân vào nơi làm việc ngoài nâng cao kỹ năng chuyên môn còn phải học cách xử lý tốt các mối quan hệ giao tiếp nhân tế lành mạnh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '跨文化沟通能力与人际同理心，已成为全球化跨国企业高管团队领导力模型中的核心考核指标。',
        pinyin: 'Kuà-wénhuà gōutōng nénglì yǔ rénjì tónglǐxīn, yǐ chéngwéi quánqiúhuà kuàguó qǐyè gāoguǎn tuánduì lǐngdǎolì móxíng zhōng de héxīn kǎohé zhǐbiāo.',
        meaning_vi: 'Năng lực giao tiếp liên văn hóa và sự thấu cảm trong quan hệ giữa các cá nhân đã trở thành chỉ số đánh giá cốt lõi trong mô hình năng lực lãnh đạo đội ngũ quản trị cấp cao tại các tập đoàn đa quốc gia toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2920,
    hanzi: '人口',
    pinyin: 'rénkǒu',
    word_type: 'Danh từ',
    meaning_vi: 'dân số, số dân',
    examples: [
      {
        chinese: '随着城市经济的繁荣发展，该地区常住人口近年来呈现平稳增长态势。',
        pinyin: 'Suízhe chéngshì jīngjì de fánróng fāzhǎn, gāi dìqū chángzhù rénkǒu jìnniánlái chéngxiàn píngwěn zēngzhǎng tàishì.',
        meaning_vi: 'Cùng với sự phát triển phồn vinh của kinh tế đô thị, dân số thường trú của khu vực này những năm gần đây có chiều hướng tăng trưởng vững chắc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '积极应对人口深度老龄化国家战略要求全面构建多层次养老保障体系，推动实现人口高质量发展。',
        pinyin: 'Jījí yìngduì rénkǒu shēndù lǎolínghuà guójiā zhànlüè yāoqiú quánmiàn gòujiàn duō-céngcì yǎnglǎo bǎozhàng tǐxì, tuīdòng shíxiàn rénkǒu gāo-zhìliàng fāzhǎn.',
        meaning_vi: 'Chiến lược quốc gia tích cực ứng phó tình trạng dân số già hóa sâu sắc đòi hỏi phải xây dựng toàn diện hệ thống an sinh dưỡng lão đa tầng nấc, thúc đẩy thực hiện phát triển dân số chất lượng cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2921,
    hanzi: '人类',
    pinyin: 'rénlèi',
    word_type: 'Danh từ',
    meaning_vi: 'nhân loại, loài người',
    examples: [
      {
        chinese: '保护地球生态环境，是全人类共同的责任与义务。',
        pinyin: 'Bǎohù Dìqiú shēngtài huánjìng, shì quán rénlèi gòngtóng de zérèn yǔ yìwù.',
        meaning_vi: 'Bảo vệ môi trường sinh thái Trái Đất là trách nhiệm và nghĩa vụ chung của toàn thể nhân loại.',
        difficulty_level: 'basic'
      },
      {
        chinese: '深空深海探测不仅拓展了人类对未知宇宙物理规律的科学认知，而且促进了跨代际前沿尖端工程技术的集成突破。',
        pinyin: 'Shēnkōng shēnhǎi tàncè bùjǐn tuòzhǎn le rénlèi duì wèizhī yǔzhòu wùlǐ guīlǜ de kēxué rènzhī, érqiě cùjìn le kuà-dàijì qiányán jiānduān gōngchéng jìshù de jíchéng tūpò.',
        meaning_vi: 'Thám hiểm không gian sâu và biển sâu không chỉ mở rộng nhận thức khoa học của nhân loại về các quy luật vật lý vũ trụ chưa biết mà còn thúc đẩy đột phá tích hợp công nghệ kỹ thuật tiên tiến vượt thế hệ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2922,
    hanzi: '人力',
    pinyin: 'rénlì',
    word_type: 'Danh từ',
    meaning_vi: 'nhân lực, sức người, nguồn nhân lực',
    examples: [
      {
        chinese: '为了确保大桥工程如期完工，施工单位紧急调配了充足的人力和物资。',
        pinyin: 'Wèile quèbǎo dàqiáo gōngchéng rúqī wángōng, shīgōng dānwèi jǐnjí diàopèi le chōngzú de rénlì yǔ wùzī.',
        meaning_vi: 'Để bảo đảm công trình cầu lớn hoàn thành đúng hạn, đơn vị thi công đã khẩn cấp điều phối đầy đủ nhân lực và vật tư.',
        difficulty_level: 'basic'
      },
      {
        chinese: '人力资本投资是推动全要素生产率持续提升的核心源泉，必须加大对基础教育和终身职业技能培训的公共投入。',
        pinyin: 'Rénlì zīběn tóuzī shì tuīdòng quán-yàosù shēngchǎnlǜ chíxù tíshēng de héxīn yuánquán, bìxū jiàdà duì jīchǔ jiàoyù hé zhōngshēn zhíyè jìnéng péixùn de gōnggòng tóurù.',
        meaning_vi: 'Đầu tư nguồn vốn nhân lực là ngọn nguồn cốt lõi thúc đẩy năng suất nhân tố tổng hợp tăng trưởng bền vững, bắt buộc phải tăng cường đầu tư công vào giáo dục cơ sở và đào tạo kỹ năng nghề trọn đời.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2923,
    hanzi: '人民',
    pinyin: 'rénmín',
    word_type: 'Danh từ',
    meaning_vi: 'nhân dân, người dân',
    examples: [
      {
        chinese: '一切工作的出发点和落脚点，都是为了实现好、维护好人民的切身利益。',
        pinyin: 'Yíqiè gōngzuò de chūfādiǎn hé luòjiǎodiǎn, dōu shì wèile shíxiàn hǎo, wéihù hǎo rénmín de qièshēn lìyì.',
        meaning_vi: 'Điểm xuất phát và đích đến của mọi công tác đều là vì thực hiện tốt và bảo vệ tốt lợi ích thiết thân của nhân dân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '坚持以人民为中心的发展思想，着力解决好人民群众在就业、教育、医疗等关键领域的急难愁盼问题。',
        pinyin: 'Jiānchí yǐ rénmín wéi zhōngxīn de fāzhǎn sīxiǎng, zhuólì jiějué hǎo rénmín qúnzhòng zài jiùyè, jiàoyù, yīliáo děng guānjiàn lǐngyù de jínán-chóupàn wèntí.',
        meaning_vi: 'Kiên trì tư tưởng phát triển lấy nhân dân làm trung tâm, tập trung giải quyết thỏa đáng các vấn đề cấp bách thiết thân nhất của quần chúng nhân dân trong các lĩnh vực then chốt như việc làm, giáo dục và y tế.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2924,
    hanzi: '人民币',
    pinyin: 'rénmínbì',
    word_type: 'Danh từ',
    meaning_vi: 'đồng Nhân dân tệ (RMB)',
    examples: [
      {
        chinese: '外国游客到达机场后，可以在外币兑换窗口将美元兑换成人民币。',
        pinyin: 'Wàiguó yóukè dàodá jīchǎng hòu, kěyǐ zài wàibì duìhuàn chuāngkǒu jiāng měiyuán duìhuàn chéng rénmínbì.',
        meaning_vi: 'Du khách nước ngoài sau khi tới sân bay có thể đổi đồng đô la Mỹ sang đồng Nhân dân tệ tại quầy đổi ngoại tệ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '有序推进人民币跨境支付系统建设与多边双边本币互换，稳慎扎实提升人民币国际储备与贸易结算份额。',
        pinyin: 'Yǒuxù tuījìn Rénmínbì kuàjìng zhīfù xìtǒng jiànshè yǔ duōbiān shuāngbiān běnbì hùhuàn, wěnshèn zhāshi tíshēng Rénmínbì guójì chǔbèi yǔ màoyì jiésuàn fèn’é.',
        meaning_vi: 'Thúc đẩy có trật tự việc xây dựng hệ thống thanh toán xuyên biên giới bằng đồng Nhân dân tệ và hoán đổi đồng bản tệ đa phương song phương, nâng cao một cách vững chắc thận trọng tỷ trọng dự trữ quốc tế và quyết toán thương mại của đồng Nhân dân tệ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2925,
    hanzi: '人群',
    pinyin: 'rénqún',
    word_type: 'Danh từ',
    meaning_vi: 'đám đông, dòng người, nhóm người',
    examples: [
      {
        chinese: '节日期间的步行街上张灯结彩，熙熙攘攘的人群川流不息。',
        pinyin: 'Jiérì qījiān de bùxíngjiē shang zhāngdēng-jiécǎi, xīxī-rǎngrǎng de rénqún chuānliú-bùxī.',
        meaning_vi: 'Phố đi bộ trong dịp lễ hội giăng đèn kết hoa, dòng người tấp nập nhộn nhịp đi lại không ngớt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大型交通枢纽安装了高精度智能客流疏导感知系统，防止节假日极端高峰时段发生危险的人群拥挤踩踏事故。',
        pinyin: 'Dàxíng jiāotōng shūniǔ ānzhuāng le gāo-jīngdù zhìnéng kèliú shūdǎo gǎnzhī xìtǒng, fángzhǐ jiéjiàrì jíduān gāofēng shíduàn fāshēng wēixiǎn de rénqún yōngjǐ cǎità shìgù.',
        meaning_vi: 'Đầu mối giao thông quy mô lớn đã lắp đặt hệ thống cảm biến phân luồng hành khách thông minh độ chính xác cao nhằm ngăn ngừa sự cố chen lấn giẫm đạp đám đông nguy hiểm trong các khung giờ cao điểm cực độ của kỳ nghỉ lễ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2926,
    hanzi: '人体',
    pinyin: 'réntǐ',
    word_type: 'Danh từ',
    meaning_vi: 'cơ thể người, thân thể người',
    examples: [
      {
        chinese: '水约占成年人体重的百分之六十到七十，是维持生命不可或缺的成分。',
        pinyin: 'Shuǐ yuē zhàn chéngnián réntǐ zhòng de bǎifēnzhī liùshí dào qīshí, shì wéichí shēngmìng bùkě huòquē de chéngfèn.',
        meaning_vi: 'Nước chiếm khoảng 60% đến 70% trọng lượng cơ thể người trưởng thành, là thành phần không thể thiếu để duy trì sự sống.',
        difficulty_level: 'basic'
      },
      {
        chinese: '生物医用植入材料必须经过严格的生物相容性与降解代谢毒理学评价，确保对人体组织无任何排异与潜在致畸危害。',
        pinyin: 'Shēngwù yīyòng zhírù cáiliào bìxū jīngguò yángé de shēngwù xiāngróngxìng yǔ jiàngjiě dàixiè dúlǐxué píngjià, quèbǎo duì réntǐ zǔzhī wú rènhé páiyì yǔ qiánzài zhìjī wēihài.',
        meaning_vi: 'Vật liệu cấy ghép y sinh bắt buộc phải trải qua đánh giá độc chất học thoái hóa trao đổi chất và tương thích sinh học nghiêm ngặt, bảo đảm không có bất kỳ phản ứng thải ghép hay nguy hại tiềm ẩn gây dị tật nào đối với các mô của cơ thể người.',
        difficulty_level: 'applied'
      }
    ]
  }
]
