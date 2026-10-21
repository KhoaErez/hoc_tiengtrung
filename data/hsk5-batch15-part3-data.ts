// data/hsk5-batch15-part3-data.ts
// 25 từ HSK 5: #3452 [早已] -> #3476 [账户]

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

export const HSK5_BATCH15_PART3: VocabItem[] = [
  {
    id: 3452,
    hanzi: '早已',
    pinyin: 'zǎoyǐ',
    word_type: 'Phó từ',
    meaning_vi: 'đã... từ lâu, sớm đã',
    examples: [
      {
        chinese: '当他匆匆赶到火车站候车大厅时，那趟前往北京的高铁列车早已停止检票了。',
        pinyin: 'Dāng tā cōngcōng gǎndào huǒchēzhàn hòuchē dàtīng shí, nà tàng qiánwǎng Běijīng de gāotiě lièchē zǎoyǐ tíngzhǐ jiǎnpiào le.',
        meaning_vi: 'Khi anh ấy vội vàng đến đại sảnh chờ của ga tàu hỏa, chuyến tàu cao tốc đi Bắc Kinh đó sớm đã ngừng soát vé rồi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '领先的跨国科技集团早已在下一代量子计算与可控核聚变前沿基础研究领域完成了深度战略布局。',
        pinyin: 'Lǐngxiān de kuàguó kējì jítuán zǎoyǐ zài xià-yídài liàngzǐ jìsuàn yǔ kěkòng hé-jùbiàn qiányán jīchǔ yánjiū lǐngyù wánchéng le shēndù zhànlüè bùjú.',
        meaning_vi: 'Tập đoàn công nghệ xuyên quốc gia hàng đầu từ lâu đã hoàn tất việc bố cục chiến lược sâu rộng trong các lĩnh vực nghiên cứu cơ bản mũi nhọn như điện toán lượng tử thế hệ mới và nhiệt hạch có thể kiểm soát.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3453,
    hanzi: '造',
    pinyin: 'zào',
    word_type: 'Động từ',
    meaning_vi: 'tạo, chế tạo, tạo dựng; gây nên',
    examples: [
      {
        chinese: '为了改善乡村地区的交通条件，政府决定在蜿蜒的小河上造一座结实的石拱桥。',
        pinyin: 'Wèile gǎishàn xiāngcūn dìqū de jiāotōng tiáojiàn, zhèngfǔ juédìng zài wānyán de xiǎohé shang zào yí zuò jiēshi de shí gǒngqiáo.',
        meaning_vi: 'Để cải thiện điều kiện giao thông của vùng nông thôn, chính quyền đã quyết định xây dựng một cây cầu vòm đá chắc chắn bắc qua con sông nhỏ uốn lượn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '工业互联网赋能制造业打造柔性智能生产线，实现根据全球客户碎片化定制需求即时造出高精设备的能力。',
        pinyin: 'Gōngyè hùliánwǎng fùnéng zhìzàoyè dǎzào róuxìng zhìnéng shēngchǎnxiàn, shíxiàn gēnjù quánqiú kèhù suìpiànhuà dìngzhì xūqiú jíshí zào chū gāojīng shèbèi de nénglì.',
        meaning_vi: 'Internet công nghiệp tiếp sức cho ngành chế tạo xây dựng dây chuyền sản xuất thông minh linh hoạt, hiện thực hóa năng lực chế tạo tức thì các thiết bị có độ chính xác cao dựa trên nhu cầu tùy biến phân mảnh của khách hàng toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3454,
    hanzi: '造成',
    pinyin: 'zàochéng',
    word_type: 'Động từ',
    meaning_vi: 'gây ra, tạo thành, dẫn đến (kết quả xấu)',
    examples: [
      {
        chinese: '暴风雨天气导致路面积水严重，给早高峰期间出行的市民造成了极大的不便。',
        pinyin: 'Bàofēngyǔ tiānqì dǎozhì lùmiàn jīshuǐ yánzhòng, gěi zǎogāofēng qījiān chūxíng de shìmín zàochéng le jí dà de búbiàn.',
        meaning_vi: 'Thời tiết mưa bão dữ dội đã dẫn đến tình trạng ngập úng mặt đường nghiêm trọng, gây ra bất tiện vô cùng lớn cho người dân đi lại trong khung giờ cao điểm buổi sáng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '数据中心核心交换机未经安全审计的固件漏洞，极有可能对整个跨国金融清算网络造成灾难性瘫痪。',
        pinyin: 'Shùjù zhōngxīn héxīn jiāohuànjī wèijīng ānquán shěnjì de gùjiàn lòudòng, jí yǒu kěnéng duì zhěnggè kuàguó jīnróng qīngsuàn wǎngluò zàochéng zāinànxìng tānhuàn.',
        meaning_vi: 'Lỗ hổng phần sụn chưa qua kiểm toán an ninh trên thiết bị chuyển mạch cốt lõi của trung tâm dữ liệu rất có thể sẽ gây ra tình trạng tê liệt mang tính thảm họa đối với toàn bộ mạng lưới thanh toán bù trừ tài chính xuyên quốc gia.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3455,
    hanzi: '增',
    pinyin: 'zēng',
    word_type: 'Động từ',
    meaning_vi: 'tăng, tăng thêm, gia tăng',
    examples: [
      {
        chinese: '随着初冬气温逐渐下降，医院门诊部患呼吸道感染的就诊人数有明显增多的趋势。',
        pinyin: 'Suízhe chūdōng qìwēn zhújiàn xiàjiàng, yīyuàn ménzhěnbù huàn hūxīdào gǎnrǎn de jiùzhěn rénshù yǒu míngxiǎn zēng duō de qūshì.',
        meaning_vi: 'Cùng với sự sụt giảm dần của nhiệt độ đầu đông, số lượng người đến khoa khám bệnh của bệnh viện vì nhiễm trùng đường hô hấp có xu hướng tăng rõ rệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家外汇管理局最新公布的数据表明，主权投资基金在全球多元化资产配置组合中稳步增持高评级绿色债券。',
        pinyin: 'Guójiā Wàihuì Guǎnlǐjú zuìxīn gōngbù de shùjù biǎomíng, zhǔquán tóuzī jījīn zài quánqiú duōyuánhuà zīchǎn pèizhì zǔhé zhōng wěnbù zēng chí gāo-píngjí lǜsè zhàoquàn.',
        meaning_vi: 'Số liệu mới nhất do Cục Quản lý Ngoại hối Quốc gia công bố chỉ rõ rằng quỹ đầu tư chủ quyền quốc gia đang gia tăng nắm giữ vững chắc các trái phiếu xanh xếp hạng tín nhiệm cao trong danh mục phân bổ tài sản đa dạng hóa toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3456,
    hanzi: '增进',
    pinyin: 'zēngjìn',
    word_type: 'Động từ',
    meaning_vi: 'tăng tiến, thúc đẩy, nâng cao (hiểu biết, tình hữu nghị)',
    examples: [
      {
        chinese: '两校青年学生联合举办的文化交流夏令营，极大地增进了彼此之间的相互了解与深厚友谊。',
        pinyin: 'Liǎng xiào qīngnián xuésheng liánhé jǔbàn de wénhuà jiāoliú xiàlìngyíng, jídà de zēngjìn le bǐcǐ zhījiān de xiānghù liǎojiě yǔ shēnhòu yǒuyì.',
        meaning_vi: 'Trại hè giao lưu văn hóa do học sinh thanh niên hai trường phối hợp tổ chức đã tăng cường rất lớn sự hiểu biết lẫn nhau và tình bạn sâu đậm giữa đôi bên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '常态化的高级别民间智库学术对话机制，对于消除地缘政治战略误判、增进大国战略互信发挥着不可替代的建设性作用。',
        pinyin: 'Chángtàihuà de gāojíbié mínjiān zhìkù xuéshù duìhuà jīzhì, duìyú xiāochú dìyuán zhèngzhì zhànlüè wùpàn, zēngjìn dàguó zhànlüè hùxìn fāhuī zhe bùkě-tìdài de jiànshèxìng zuòyòng.',
        meaning_vi: 'Cơ chế đối thoại học thuật viện chính sách phi chính phủ cấp cao được bình thường hóa phát huy vai trò mang tính xây dựng không thể thay thế đối với việc xóa bỏ sự phán đoán sai lầm chiến lược địa chính trị và củng cố sự tin cậy chiến lược lẫn nhau giữa các nước lớn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3457,
    hanzi: '增强',
    pinyin: 'zēngqiáng',
    word_type: 'Động từ',
    meaning_vi: 'tăng cường, củng cố, nâng cao (năng lực, thể chất)',
    examples: [
      {
        chinese: '坚持每天进行半小时的有氧慢跑和规律作息，能够有效增强人体的新陈代谢与免疫力。',
        pinyin: 'Jiānchí měitiān jìnxíng bàn xiǎoshí de yǒuyǎng mànpǎo hé guīlǜ zuòxī, nénggòu yǒuxiào zēngqiáng réntǐ de xīnchén-dàixiè yǔ miǎnyìlì.',
        meaning_vi: 'Kiên trì chạy bộ chậm có oxy nửa giờ mỗi ngày cùng chế độ nghỉ ngơi sinh hoạt điều độ có thể tăng cường trao đổi chất và khả năng miễn dịch của cơ thể con người một cách hiệu quả.',
        difficulty_level: 'basic'
      },
      {
        chinese: '深化关键核心技术攻关是增强产业链供应链自主可控能力、抵御外部单边断供风险的根本战略举措。',
        pinyin: 'Shēnhuà guānjiàn héxīn jìshù gōngguān shì zēngqiáng chǎnyèliàn gōngyìngliàn zìzhǔ kěkòng nénglì, dǐyù wàibù dānbiān duàngōng fēngxiǎn de gēnběn zhànlüè jǔcuò.',
        meaning_vi: 'Đào sâu nghiên cứu đột phá công nghệ cốt lõi then chốt là biện pháp chiến lược căn bản nhằm tăng cường năng lực tự chủ kiểm soát được của chuỗi công nghiệp và chuỗi cung ứng, chống lại rủi ro bị cắt nguồn cung đơn phương từ bên ngoài.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3458,
    hanzi: '赠',
    pinyin: 'zèng',
    word_type: 'Động từ',
    meaning_vi: 'tặng, biếu, tặng kèm',
    examples: [
      {
        chinese: '在书店举办的新书签售会上，知名作者亲笔在扉页上题字并赠给远道而来的读者。',
        pinyin: 'Zài shūdiàn jǔbàn de xīnshū qiānshòuhuì shang, zhīmíng zuòzhě qīnbǐ zài fēiyè shang tízì bìng zèng gěi yuǎndào-érlái de dúzhě.',
        meaning_vi: 'Tại buổi ký tặng sách mới tổ chức ở hiệu sách, tác giả nổi tiếng đã tự tay đề chữ lên trang lót và tặng cho người độc giả lặn lội từ xa tới.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该高新技术企业向国家重点实验室无偿捐赠一套价值千万的高精度电子显微成像检测系统，专项用于纳米材料科研攻坚。',
        pinyin: 'Gāi gāoxīn-jìshù qǐyè xiàng guójiā zhòngdiǎn shíyànshì wúcháng juānzèng yí tào jiàzhí qiānwàn de gāojīngdù diànzǐ xiǎnwēi chéngxiàng jiǎncè xìtǒng, zhuānxiàng yòngyú nàmǐ cáiliào kēyán gōngjiān.',
        meaning_vi: 'Doanh nghiệp công nghệ cao đó đã hiến tặng miễn phí cho phòng thí nghiệm trọng điểm quốc gia một hệ thống kiểm nghiệm chụp ảnh kính hiển vi điện tử độ chính xác cao trị giá hàng chục triệu tệ, chuyên dùng cho việc đột phá nghiên cứu vật liệu nano.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3459,
    hanzi: '赠送',
    pinyin: 'zèngsòng',
    word_type: 'Động từ',
    meaning_vi: 'trao tặng, gửi tặng, biếu tặng',
    examples: [
      {
        chinese: '凡是在本次商场店庆周末消费满五百元的顾客，均可获赠一套精美的陶瓷餐具礼盒。',
        pinyin: 'Fánshì zài běncì shāngchǎng diànqìng zhōumò xiāofèi mǎn wǔbǎi yuán de gùkè, jūnkě huò zèngsòng yí tào jīngměi de táocí cānjù lǐhé.',
        meaning_vi: 'Tất cả quý khách hàng tiêu dùng từ 500 tệ trở lên trong dịp cuối tuần kỷ niệm thành lập trung tâm thương mại lần này đều được tặng một bộ hộp quà đồ sứ gia dụng tinh xảo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '代表团在结束正式友好访问时，向东道国国家博物馆正式赠送了代表本国非物质文化遗产顶尖工艺的双面丝绸刺绣艺术品。',
        pinyin: 'Dàibiǎotuán zài jiéshù zhèngshì yǒuhǎo fǎngwèn shí, xiàng dōngdàoguó guójiā bówùguǎn zhèngshì zèngsòng le dàibiǎo běnguó fēi-wùzhì wénhuà yíchǎn dǐngjiān gōngyì de shuāngmiàn sīchóu cìxiù yìshùpǐn.',
        meaning_vi: 'Đoàn đại biểu khi kết thúc chuyến thăm hữu nghị chính thức đã trao tặng chính thức cho viện bảo tàng quốc gia của nước chủ nhà tác phẩm nghệ thuật thêu tơ tằm hai mặt đại diện cho kỹ nghệ đỉnh cao di sản văn hóa phi vật thể của nước mình.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3460,
    hanzi: '炸',
    pinyin: 'zhá',
    word_type: 'Động từ',
    meaning_vi: 'chiên, rán (ngập dầu)',
    examples: [
      {
        chinese: '这家街头小吃店刚出锅的香脆炸鸡块外焦里嫩，每天傍晚都吸引很多食客排队购买。',
        pinyin: 'Zhè jiā jiētóu xiǎochīdiàn gāng chūguō de xiāngcuì zhájī kuài wàijiāo-lǐnèn, měitiān bàngwǎn dōu xīyǐn hěn duō shíkè páiduì gòumǎi.',
        meaning_vi: 'Món thịt gà rán giòn rụm vừa mới vớt ra khỏi chảo của quán ăn vặt đường phố này bên ngoài giòn rụm bên trong mềm thơm, chiều tối nào cũng thu hút rất đông thực khách xếp hàng mua.',
        difficulty_level: 'basic'
      },
      {
        chinese: '工业级食品油炸生产线通过智能传感器精确控制油温与油炸时长，严格抑制煎炸食用油脂中丙烯酰胺等副产物的过度生成。',
        pinyin: 'Gōngyèjí shípǐn yóuzhá shēngchǎnxiàn tōngguò zhìnéng chuángǎnqì jīngquè kòngzhì yóuwēn yǔ yóuzhá shícháng, yángé yìzhì jiānzhá shíyòng yóuzhǐ zhōng bǐngxīxiān\'àn děng fùchǎnwù de guòdù shēngchéng.',
        meaning_vi: 'Dây chuyền chiên thực phẩm cấp công nghiệp thông qua cảm biến thông minh kiểm soát chuẩn xác nhiệt độ dầu và thời gian chiên rán, ức chế nghiêm ngặt sự sản sinh quá mức các phụ phẩm như acrylamide trong dầu mỡ ăn chiên rán.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3461,
    hanzi: '摘',
    pinyin: 'zhāi',
    word_type: 'Động từ',
    meaning_vi: 'hái, ngắt, tháo, trích dẫn',
    examples: [
      {
        chinese: '金秋十月，果园里的苹果挂满枝头，农户们正抓紧晴好天气摘下一箱箱甜脆的水果。',
        pinyin: 'Jīnqiū shíyuè, guǒyuán lǐ de píngguǒ guà mǎn zhītóu, nónghùmen zhèng zhuājǐn qínghǎo tiānqì zhāi xià yì xiāng xiāng tiáncuì de shuǐguǒ.',
        meaning_vi: 'Tháng Mười mùa thu vàng, táo trong vườn trĩu trĩu cành cây, bà con nông dân đang tranh thủ thời tiết nắng đẹp hái xuống từng thùng trái cây ngọt giòn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '学术论文写作要求作者在直接引用他人实验数据或学术论点时，必须如实摘录并逐一注明出处以恪守学术道德。',
        pinyin: 'Xuéshù lùnwén xiězuò yāoqiú zuòzhě zài zhíjiē yǐnyòng tārén shíyàn shùjù huò xuéshù lùndiǎn shí, bìxū rúshí zhāilù bìng zhúyī zhùmíng chūchù yǐ kèshǒu xuéshù dàodé.',
        meaning_vi: 'Viết luận văn học thuật đòi hỏi tác giả khi trích dẫn trực tiếp số liệu thực nghiệm hoặc luận điểm học thuật của người khác bắt buộc phải trích sao trung thực và chú thích rõ nguồn gốc từng mục nhằm nghiêm cẩn tuân thủ đạo đức học thuật.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3462,
    hanzi: '窄',
    pinyin: 'zhǎi',
    word_type: 'Tính từ',
    meaning_vi: 'hẹp, chật hẹp, eo hẹp',
    examples: [
      {
        chinese: '老城区里这条巷道非常狭窄，不仅私家汽车无法驶入，就连两辆自行车交会都很困难。',
        pinyin: 'Lǎo chéngqū lǐ zhè tiáo xiàngdào fēicháng xiázhǎi, bù jǐn sījiā qìchē wúfǎ shǐrù, jiù lián liǎng liàng zìxíngchē jiāohuì dōu hěn kùnnan.',
        meaning_vi: 'Con ngõ này trong khu phố cổ vô cùng chật hẹp, không những ô tô riêng không thể chạy vào, mà ngay cả hai chiếc xe đạp tránh nhau cũng rất khó khăn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '如果商业银行长期过度依赖传统的存贷款利差业务，其未来的盈利成长通道与抗风险边界必将变得极其狭窄。',
        pinyin: 'Rúguǒ shāngyè yínháng chángqī guòdù yīlài chuántǒng de cún-dàikuǎn lìchā yèwù, qí wèilái de yínglì chéngzhǎng tōngdào yǔ kàng-fēngxiǎn biānjiè bìjiāng biàn de jíqí xiázhǎi.',
        meaning_vi: 'Nếu ngân hàng thương mại phụ thuộc quá mức trong thời gian dài vào nghiệp vụ chênh lệch lãi suất tiền gửi và cho vay truyền thống, thì hành lang tăng trưởng lợi nhuận và biên độ chống chịu rủi ro trong tương lai của ngân hàng đó chắc chắn sẽ trở nên vô cùng eo hẹp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3463,
    hanzi: '展出',
    pinyin: 'zhǎnchū',
    word_type: 'Động từ',
    meaning_vi: 'trưng bày, triển lãm',
    examples: [
      {
        chinese: '市美术馆本周正在展出当代著名画家的数十幅山水油画力作，吸引了成百上千位艺术爱好者前来参观。',
        pinyin: 'Shì měishùguǎn běnzhōu zhèngzài zhǎnchū dāngdài zhùmíng huàjiā de shùshí fú shānshuǐ yóuhuà lìzuò, xīyǐn le chéngbǎi-shàngqiān wèi yìshù àihàozhě qiánlái cānguān.',
        meaning_vi: 'Bảo tàng mỹ thuật thành phố tuần này đang trưng bày hàng chục tác phẩm tranh sơn dầu phong cảnh kiệt xuất của các họa sĩ đương đại nổi tiếng, thu hút hàng trăm hàng nghìn người yêu nghệ thuật đến tham quan.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在国际防务科技装备博览会上，我国自主研制的第六代隐身战斗机全尺寸概念模型首次向全球公众正式展出。',
        pinyin: 'Zài guójì fángwù kējì zhuāngbèi bólǎnhuì shang, wǒguó zìzhǔ yánzhì de dì-liù dài yǐnshēn zhàndòujī quán-chǐcùn gèiniàn móxíng shǒucì xiàng quánqiú gōngzhòng zhèngshì zhǎnchū.',
        meaning_vi: 'Tại hội chợ triển lãm thiết bị khoa học công nghệ quốc phòng quốc tế, mô hình ý niệm kích thước thực tế của máy bay chiến đấu tàng hình thế hệ thứ sáu do nước ta tự chủ nghiên cứu chế tạo lần đầu tiên được triển lãm chính thức trước công chúng toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3464,
    hanzi: '展开',
    pinyin: 'zhǎnkāi',
    word_type: 'Động từ',
    meaning_vi: 'triển khai, mở rộng, phát động; xòe ra',
    examples: [
      {
        chinese: '班主任微笑着展开手中的奖状，在全班同学热烈的掌声中向获得第一名的学习小组颁发荣誉证书。',
        pinyin: 'Bānzhǔrèn wēixiào zhe zhǎnkāi shǒuzhōng de jiǎngzhuàng, zài quán bān tóngxué rèliè de zhǎngshēng zhōng xiàng huòdé dì-yī míng de xuéxí xiǎozǔ bānfā róngyù zhèngshū.',
        meaning_vi: 'Giáo viên chủ nhiệm mỉm cười mở tấm bằng khen trong tay ra, trao giấy chứng nhận danh dự cho nhóm học tập đạt giải nhất trong tiếng vỗ tay nồng nhiệt của cả lớp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '多国联合深海科考队借助深潜器，在马里亚纳海沟底部万米极限深渊全面展开了地质构造采样与未知微生物勘探。',
        pinyin: 'Duōguó liánhé shēnhǎi kēkǎoduì jièzhù shēnqiǎnqì, zài Mǎlǐyànà Hǎigōu dǐbù wànmǐ jíxiàn shēnyuān quánmiàn zhǎnkāi le dìzhì gòuzào cǎiyàng yǔ wèizhī wēishēngwù kāntàn.',
        meaning_vi: 'Đội khảo sát khoa học biển sâu liên hợp đa quốc gia nhờ có tàu lặn sâu đã triển khai toàn diện việc lấy mẫu cấu tạo địa chất và thăm dò vi sinh vật chưa từng biết dưới vực sâu cực hạn một vạn mét ở đáy rãnh Mariana.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3465,
    hanzi: '展览',
    pinyin: 'zhǎnlǎn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'triển lãm, trưng bày',
    examples: [
      {
        chinese: '科技馆下个月将举办一场关于太空探索与火箭发射的互动式科普展览，非常适合中小学生前来体验。',
        pinyin: 'Kējìguǎn xià ge yuè jiāng jǔbàn yì chǎng guānyú tàikōng tànsuǒ yǔ huǒjiàn fāshè de hùdòngshì kēpǔ zhǎnlǎn, fēicháng shìhé zhōng-xiǎoxuésheng qiánlái tǐyàn.',
        meaning_vi: 'Bảo tàng khoa học công nghệ tháng tới sẽ tổ chức một triển lãm phổ biến khoa học dạng tương tác về khám phá vũ trụ và phóng tên lửa, rất thích hợp cho học sinh tiểu học và trung học đến trải nghiệm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '进博会设立了前沿生物医药创新技术核心展览专区，集中呈现了全球数十款突破性靶向抗癌创新药与基因编辑治疗设备。',
        pinyin: 'Jìnbóhuì shèlì le qiányán shēngwù yīyào chuàngxīn jìshù héxīn zhǎnlǎn zhuānqū, jízhōng chéngxiàn le quánqiú shùshí kuǎn tūpòxìng bǎxiàng kàng\'ái chuàngxīnyào yǔ jīyīn biānjí zhìliáo shèbèi.',
        meaning_vi: 'Hội chợ nhập khẩu quốc tế đã thành lập khu chuyên đề triển lãm cốt lõi về công nghệ đổi mới y dược sinh học tiên phong, hội tụ trưng bày hàng chục loại thuốc kháng ung thư nhắm trúng đích đột phá và thiết bị điều trị chỉnh sửa gen trên toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3466,
    hanzi: '展示',
    pinyin: 'zhǎnshì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'trưng bày, thể hiện, phô diễn',
    examples: [
      {
        chinese: '在今天下午的年终汇报会议上，小王用精心制作的幻灯片向客户生动展示了项目取得的丰硕成果。',
        pinyin: 'Zài jīntiān xiàwǔ de niánzhōng huìbào huìyì shang, Xiǎo Wáng yòng jīngxīn zhìzuò de huàndēngpiàn xiàng kèhù shēngdòng zhǎnshì le xiàngmù qǔdé de fēngshuò chéngguǒ.',
        meaning_vi: 'Trong cuộc họp báo cáo cuối năm chiều nay, Tiểu Vương đã dùng các slide trình chiếu chuẩn bị kỹ càng để trình diễn sinh động trước khách hàng những thành quả bội thu mà dự án đạt được.',
        difficulty_level: 'basic'
      },
      {
        chinese: '智能网联新能源概念车在车展上集中展示了厘米级激光雷达多传感器融合、全场景自动泊车与端到端大模型赋能的高阶智驾系统。',
        pinyin: 'Zhìnéng wǎnglián xīnnéngyuán gèiniànchē zài chēzhǎn shang jízhōng zhǎnshì le límǐjí jīguāng léidá duō-chuángǎnqì rónghé, quán-chǎnjǐng zìdòng bōchē yǔ duāndàoduān dà-móxíng fùnéng de gāojiē zhìjià xìtǒng.',
        meaning_vi: 'Mẫu xe ý niệm năng lượng mới kết nối mạng thông minh tại triển lãm ô tô đã phô diễn tập trung hệ thống lái thông minh bậc cao được tiếp sức bởi mô hình lớn đầu cuối kết hợp đa cảm biến LiDAR cấp centimet và tự động đỗ xe toàn cảnh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3467,
    hanzi: '展现',
    pinyin: 'zhǎnxiàn',
    word_type: 'Động từ',
    meaning_vi: 'thể hiện, bộc lộ, mở ra, phô bày',
    examples: [
      {
        chinese: '年轻一代运动员在奥运赛场上顽强拼搏、永不放弃，展现出了充满朝气与活力的青春风采。',
        pinyin: 'Niánqīng yídài yùndòngyuán zài Àoyùn sàichǎng shang wánqiáng pīnbó, yǒng bù fàngqì, zhǎnxiàn chū le chōngmǎn zhāoqì yǔ huólì de qīngchūn fēngcǎi.',
        meaning_vi: 'Thế hệ vận động viên trẻ kiên cường nỗ lực thi đấu trên đấu trường Olympic, không bao giờ bỏ cuộc, thể hiện phong thái thanh xuân tràn đầy sức sống và sinh lực.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大型全景历史纪录片运用超高清航拍与逼真三维特效，波澜壮阔地展现了古代海上丝绸之路繁荣多元的文明互鉴历史图景。',
        pinyin: 'Dàxíng quánjǐng lìshǐ jìlùpiàn yùnyòng chāo-gāoqīng hángpāi yǔ bīzhēn sānwéi tèxiào, bōlán-zhuàngkuò de zhǎnxiàn le gǔdài hǎishàng sīchóuzhīlù fánróng duōyuán de wénmíng hùjiàn lìshǐ tújǐng.',
        meaning_vi: 'Bộ phim tài liệu lịch sử toàn cảnh quy mô lớn vận dụng flycam siêu nét và kỹ xảo 3D chân thực, tái hiện lại một cách hoành tráng bức tranh lịch sử giao lưu học hỏi lẫn nhau của các nền văn minh phồn vinh đa nguyên trên con đường tơ lụa trên biển thời cổ đại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3468,
    hanzi: '占',
    pinyin: 'zhàn',
    word_type: 'Động từ',
    meaning_vi: 'chiếm, chiếm lĩnh, chiếm cứ',
    examples: [
      {
        chinese: '这台笨重的大衣柜立在小卧室里太占地方，导致连一张简易书桌都摆放不下了。',
        pinyin: 'Zhè tái bènzhòng de dà yīguì lì zài xiǎo wòshì lǐ tài zhàn dìfang, dǎozhì lián yì zhāng jiǎnyì shūzhuō dōu bǎifàng bu xià le.',
        meaning_vi: 'Chiếc tủ quần áo cồng kềnh thô kệch này kê trong phòng ngủ nhỏ quá chiếm diện tích, dẫn đến việc ngay cả một chiếc bàn học đơn giản cũng không kê vừa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高技术制造业增加值在全部规模以上工业增加值中所占的比重持续提升，成为拉动国民经济高质量平稳增长的新引擎。',
        pinyin: 'Gāojìshù zhìzàoyè zēngjiāzhí zài quánbù guīmó yǐshàng gōngyè zēngjiāzhí zhōng suǒ zhàn de bǐzhòng chíxù tíshēng, chéngwéi lādòng guómín jīngjì gāozhìliàng píngwěn zēngzhǎng de xīn yǐnqíng.',
        meaning_vi: 'Tỷ trọng giá trị gia tăng của ngành công nghiệp chế tạo công nghệ cao trong toàn bộ giá trị gia tăng công nghiệp quy mô lớn liên tục tăng lên, trở thành động cơ mới kéo nền kinh tế quốc dân tăng trưởng chất lượng cao và vững chắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3469,
    hanzi: '站台',
    pinyin: 'zhàntái',
    word_type: 'Danh từ',
    meaning_vi: 'sân ga, ke ga (tàu hỏa, tàu điện ngầm)',
    examples: [
      {
        chinese: '列车即将进站，火车站广播反复提醒站台上的候车旅客退到黄色安全警戒线以内等候。',
        pinyin: 'Lièchē jíjiāng jìnzhàn, huǒchēzhàn guǎngbō fǎnfù tíxǐng zhàntái shang de hòuchē lǚkè tuì dào huángsè ānquán jǐngjièxiàn yǐnèi děnghòu.',
        meaning_vi: 'Tàu hỏa sắp vào ga, loa phát thanh của ga tàu hỏa liên tục nhắc nhở hành khách đứng đợi trên sân ga lùi vào phía trong vạch cảnh giới an toàn màu vàng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代化综合智慧交通枢纽在地下高铁站台全面加装全封闭智能安全屏蔽门与毫米波客流防挤压监测传感装置。',
        pinyin: 'Xiàndàihuà zōnghé zhìhuì jiāotōng shūniǔ zài dìxià gāotiě zhàntái quánmiàn jiāzhuāng quán-fēngbì zhìnéng ānquán píngbìmén yǔ háomǐbō kèliú fáng-jǐyā jiāncè chuángǎn zhuāngzhì.',
        meaning_vi: 'Đầu mối giao thông thông minh tổng hợp hiện đại đã lắp đặt toàn diện cửa chắn an toàn thông minh khép kín hoàn toàn và thiết bị cảm biến giám sát chống chèn ép luồng hành khách bằng sóng milimet tại ke ga đường sắt cao tốc dưới lòng đất.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3470,
    hanzi: '占线',
    pinyin: 'zhànxiàn',
    word_type: 'Động từ',
    meaning_vi: 'máy bận, đường dây bận',
    examples: [
      {
        chinese: '我今天下午连续给经理打了好几个电话想要汇报工作，但话筒那端一直提示对方正在占线中。',
        pinyin: 'Wǒ jīntiān xiàwǔ liánxù gěi jīnglǐ dǎ le hǎo jǐ ge diànhuà xiǎng yào huìbào gōngzuò, dàn huàtǒng nà duān yìzhí tíshì duìfāng zhèngzài zhànxiàn zhōng.',
        meaning_vi: 'Chiều nay tôi liên tục gọi mấy cuộc điện thoại cho giám đốc muốn báo cáo công việc, nhưng đầu máy bên kia cứ liên tục thông báo đối phương đang bận máy.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在极端灾害天气引发电网故障的报修高峰期，智能云呼叫中心通过弹性动态话务路由分配策略，彻底消除了传统热线大面积占线拥堵难题。',
        pinyin: 'Zài jíduān zāihài tiānqì yǐnfā diànwǎng gùzhàng de bàoxiū gāofēngqī, zhìnéng yún-hūjiào zhōngxīn tōngguò tánxìng dòngtài huàwù lùyóu fēnpèi cèlüè, chèdǐ xiāochú le chuántǒng rèxiàn dà-miànjī zhànxiàn yōngdǔ nántí.',
        meaning_vi: 'Vào đợt cao điểm báo hỏng do thời tiết thiên tai cực đoan làm phát sinh sự cố lưới điện, trung tâm điều hành cuộc gọi đám mây thông minh thông qua chiến lược định tuyến lưu lượng cuộc gọi động co giãn linh hoạt đã loại bỏ triệt để vấn nạn nghẽn mạng bận máy diện rộng của đường dây nóng truyền thống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3471,
    hanzi: '涨',
    pinyin: 'zhǎng',
    word_type: 'Động từ',
    meaning_vi: 'tăng lên, dâng lên (giá cả, con nước)',
    examples: [
      {
        chinese: '经过连续几天的大暴雨，村头原本清澈见底的小河水位突然猛涨，漫过了两岸的堤坝。',
        pinyin: 'Jīngguò liánxù jǐ tiān de dà bàoyǔ, cūntóu yuánběn qīngchè-jiàndǐ de xiǎohé shuǐwèi tūrán měng zhǎng, màn guò le liǎng\'àn de dībà.',
        meaning_vi: 'Trải qua mấy ngày mưa to liên tục, mực nước con sông nhỏ vốn trong vắt nhìn thấy đáy ở đầu thôn bỗng dâng vọt dữ dội, tràn qua bờ đê hai bên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在全球通胀高企与地缘冲突加剧的双重影响下，国际原油与工业有色金属期货结算价格呈现跳空暴涨态势。',
        pinyin: 'Zài quánqiú tōngzhàng gāoqǐ yǔ dìyuán chōngtū jiājù de shuāngzhòng yǐngxiǎng xià, guójì yuányóu yǔ gōngyè yǒusè jīnshǔ qīhuò jiésuàn jiàgé chéngxiàn tiàokōng bàozhǎng tàishì.',
        meaning_vi: 'Dưới tác động kép của lạm phát toàn cầu neo cao và xung đột địa chính trị leo thang, giá thanh toán hợp đồng tương lai dầu thô và kim loại màu công nghiệp quốc tế xuất hiện thế tăng dựng đứng bùng nổ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3472,
    hanzi: '涨价',
    pinyin: 'zhǎngjià',
    word_type: 'Động từ',
    meaning_vi: 'tăng giá, lên giá',
    examples: [
      {
        chinese: '这家老字号面馆在店门口张贴告示，由于近期面粉和食用油成本上升，所有面食从下周起每碗涨价两元。',
        pinyin: 'Zhè jiā lǎozìhào miànguǎn zài diàn ménkǒu zhāngtiē gàoshì, yóuyú jìnqī miànfěn hé shíyòngyóu chéngběn shàngshēng, suǒyǒu miànshí cóng xià zhōu qǐ měi wǎn zhǎngjià liǎng yuán.',
        meaning_vi: 'Quán mì lâu đời này dán thông báo ở cửa tiệm, do chi phí bột mì và dầu ăn gần đây tăng lên, từ tuần sau tất cả các món mì mỗi bát sẽ tăng giá thêm hai tệ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '半导体先进制程晶圆代工制造巨头正式向全球芯片设计客户发出全线涨价通知，以此转嫁上游关键特种化学材料与光刻机折旧压力。',
        pinyin: 'Bàndǎotǐ xiānjìn zhìchéng jīngyuán dàigōng zhìzào jùtóu zhèngshì xiàng quánqiú xīnpiàn shèjì kèhù fāchū quánxiàn zhǎngjià tōngzhī, yǐcǐ zhuǎnjià shàngyóu guānjiàn tèzhǒng huàxué cáiliào yǔ guāngkèjī zhéjiù yālì.',
        meaning_vi: 'Gã khổng lồ chế tạo gia công tấm bán dẫn tiến trình tiên tiến đã chính thức gửi thông báo tăng giá toàn diện tới các khách hàng thiết kế chip toàn cầu, nhằm chuyển giao áp lực khấu hao máy quang khắc và hóa chất đặc chủng then chốt ở thượng nguồn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3473,
    hanzi: '掌声',
    pinyin: 'zhǎngshēng',
    word_type: 'Danh từ',
    meaning_vi: 'tiếng vỗ tay, tràng pháo tay',
    examples: [
      {
        chinese: '当钢琴演奏家深情弹完最后一个音符并优雅起身鞠躬致谢时，音乐厅里响起了经久不息的热烈掌声。',
        pinyin: 'Dāng gāngqín yǎnzòujiā shēnqíng tán wán zuìhòu yí ge yīnfú bìng yōuyǎ qǐshēn jūgōng zhìxiè shí, yīnyuètīng lǐ xiǎng qǐ le jīngjiǔ-bùxī de rèliè zhǎngshēng.',
        meaning_vi: 'Khi nghệ sĩ dương cầm dạt dào cảm xúc đánh xong nốt nhạc cuối cùng và tao nhã đứng dậy cúi đầu cảm tạ, thính phòng âm nhạc vang lên những tràng pháo tay nồng nhiệt kéo dài không ngớt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在联合国气候峰会闭幕全体会议上，具有里程碑意义的历史性减排共识决议草案获得全场代表起立致敬与雷鸣般的掌声通过。',
        pinyin: 'Zài Liánhéguó qìhòu fēnghuì bìmù quántǐ huìyì shang, jùyǒu lǐchéngbēi yìyì de lìshǐxìng jiǎnpái gòngshí juéyì cǎo\'àn huòdé quánchǎng dàibiǎo qǐlì zhìjìng yǔ léimíng bānde zhǎngshēng tōngguò.',
        meaning_vi: 'Tại phiên bế mạc toàn thể hội nghị thượng đỉnh khí hậu của Liên Hợp Quốc, dự thảo nghị quyết đồng thuận cắt giảm phát thải mang tính lịch sử và có ý nghĩa cột mốc đã được toàn thể đại biểu đứng dậy bày tỏ lòng kính trọng và thông qua trong tiếng vỗ tay như sấm rền.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3474,
    hanzi: '掌握',
    pinyin: 'zhǎngwò',
    word_type: 'Động từ',
    meaning_vi: 'nắm vững, làm chủ, kiểm soát',
    examples: [
      {
        chinese: '想要在激烈的就业市场中找到一份称心如意的工作，首先要扎实掌握自己的专业核心知识与技能。',
        pinyin: 'Xiǎng yào zài jīliè de jiùyè shìchǎng zhōng zhǎodào yí fèn chènxīn-rúyì de gōngzuò, shǒuxiān yào zhāshi zhǎngwò zìjǐ de zhuānyè héxīn zhīshi yǔ jìnéng.',
        meaning_vi: 'Muốn tìm được một công việc vừa ý trong thị trường việc làm cạnh tranh khốc liệt, trước tiên phải nắm vững thật chắc chắn kiến thức và kỹ năng chuyên môn cốt lõi của bản thân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家唯有牢牢掌握深空通信与自主可控航天测控网络核心技术，才能确保星际深空探测器在亿万公里之外的精确测控与指令执行。',
        pinyin: 'Guójiā wéiyǒu láoláo zhǎngwò shēnkōng tōngxìn yǔ zìzhǔ kěkòng hángtiān cèkòng wǎngluò héxīn jìshù, cáinéng quèbǎo xīngjì shēnkōng tàncèqì zài yìwàn gōnglǐ zhīwài de jīngquè cèkòng yǔ zhǐlìng zhíxíng.',
        meaning_vi: 'Quốc gia chỉ khi nắm vững chắc chắn công nghệ cốt lõi của mạng lưới đo kiểm điều khiển vũ trụ tự chủ kiểm soát và thông tin vũ trụ sâu, mới có thể bảo đảm việc đo kiểm điều khiển chính xác và thực thi mệnh lệnh của tàu thăm dò không gian liên sao cách xa hàng ức cây số.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3475,
    hanzi: '账号',
    pinyin: 'zhànghào',
    word_type: 'Danh từ',
    meaning_vi: 'số tài khoản, tên tài khoản (người dùng/đăng nhập)',
    examples: [
      {
        chinese: '为了保障您的个人财产与社交隐私安全，请切勿将您的网站登录账号和密码轻易透露给任何陌生人。',
        pinyin: 'Wèile bǎozhàng nín de gèrén cáichǎn yǔ shèjiāo yǐnsī ānquán, qǐng qièwù jiāng nín de wǎngzhàn dēnglù zhànghào hé mìmǎ qīngyì tòulù gěi rènhé mòshēngrén.',
        meaning_vi: 'Để bảo đảm an toàn tài sản cá nhân và quyền riêng tư mạng xã hội của quý vị, xin tuyệt đối đừng tùy tiện tiết lộ tài khoản đăng nhập và mật khẩu trang web của mình cho bất kỳ người lạ nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业级零信任安全体系强制对特权管理账号实施基于硬件密匙的多因子身份认证与基于行为基线的动态权限审计。',
        pinyin: 'Qǐyèjí líng-xìnrèn ānquán tǐxì qiángzhì duì tèquán guǎnlǐ zhànghào shíshī jīyú yìngjiàn mìshí de duō-yīnzǐ shēnfèn rènzhèng yǔ jīyú xíngwéi jīxiàn de dòngtài quánxián shěnjì.',
        meaning_vi: 'Hệ thống an ninh không tin cậy (Zero Trust) cấp doanh nghiệp bắt buộc thực thi xác thực danh tính đa yếu tố dựa trên khóa cứng vật lý và kiểm toán phân quyền động dựa trên hành vi cơ sở đối với các tài khoản quản trị đặc quyền.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3476,
    hanzi: '账户',
    pinyin: 'zhànghù',
    word_type: 'Danh từ',
    meaning_vi: 'tài khoản (ngân hàng, tài chính, thanh toán)',
    examples: [
      {
        chinese: '如果需要将每个月的工资自动转入存折，你可以去银行柜台办理一张联名储蓄账户。',
        pinyin: 'Rúguǒ xūyào jiāng měi ge yuè de gōngzī zìdòng zhuǎnrù cúnzhé, nǐ kěyǐ qù yínháng guìtái bànlǐ yì zhāng liánmíng chǔxù zhànghù.',
        meaning_vi: 'Nếu cần tự động chuyển tiền lương hàng tháng vào sổ tiết kiệm, bạn có thể đến quầy giao dịch ngân hàng làm một tài khoản tiết kiệm đồng sở hữu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '反洗钱监管中心利用图神经网络算法对涉嫌离岸洗钱的大额异常资金账户往来流水进行全链路实时穿透式追踪。',
        pinyin: 'Fǎn-xǐqián jiānguǎn zhōngxīn lìyòng tú-shénjīng-wǎngluò suànfǎ duì shèxián lí\'àn xǐqián de dà\'é yìcháng zījīn zhànghù wǎnglái liúshuǐ jìnxíng quán-liànlù shíshí chuāntòushì zhuīzōng.',
        meaning_vi: 'Trung tâm giám sát chống rửa tiền vận dụng thuật toán mạng nơ-ron đồ thị để thực hiện truy vết xuyên thấu theo thời gian thực trên toàn chuỗi đối với các dòng chu chuyển tài khoản vốn bất thường số lượng lớn nghi ngờ rửa tiền ở nước ngoài.',
        difficulty_level: 'applied'
      }
    ]
  }
]
