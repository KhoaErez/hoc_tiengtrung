// ====================================================================
// HSK 4 - BATCH 1: 100 TỪ VỰNG & 200 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0
// Phạm vi: #1001 [啊] (ā) -> #1100 [此次] (cǐ cì)
// Mỗi từ vựng có: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng thực tế) kèm Pinyin + Dịch TV
// ====================================================================

export interface Hsk4ExampleItem {
  hanzi: string
  pinyin: string
  word_type: string
  meaning_vi: string
  examples: [
    {
      chinese: string
      pinyin: string
      meaning_vi: string
      difficulty_level: 'basic' | 'applied'
    },
    {
      chinese: string
      pinyin: string
      meaning_vi: string
      difficulty_level: 'basic' | 'applied'
    }
  ]
}

export const HSK4_BATCH1_EXAMPLES: Hsk4ExampleItem[] = [
  {
    hanzi: '啊',
    pinyin: 'ā',
    word_type: 'Thán từ',
    meaning_vi: 'a, chao ôi (thán từ ngạc nhiên, cảm thán)',
    examples: [
      { chinese: '啊，这里的风景真漂亮！', pinyin: 'Ā, zhèlǐ de fēngjǐng zhēn piàoliang!', meaning_vi: 'Chao ôi, phong cảnh ở đây đẹp thật đấy!', difficulty_level: 'basic' },
      { chinese: '啊，我想起来了，原来昨天在地铁上遇到的人是你！', pinyin: 'Ā, wǒ xiǎng qǐlái le, yuánlái zuótiān zài dìtiě shang yùdào de rén shì nǐ!', meaning_vi: 'A, tôi nhớ ra rồi, hóa ra người gặp trên tàu điện ngầm hôm qua chính là bạn!', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '爱情',
    pinyin: 'àiqíng',
    word_type: 'Danh từ',
    meaning_vi: 'tình yêu',
    examples: [
      { chinese: '他们俩经历了十年的爱情长跑，终于走进了婚姻的殿堂。', pinyin: 'Tāmen liǎ jīnglì le shí nián de àiqíng chángpǎo, zhōngyú zǒujìn le hūnyīn de diàntáng.', meaning_vi: 'Hai người họ trải qua mối tình kéo dài mười năm, cuối cùng đã bước vào lễ đường hôn nhân.', difficulty_level: 'basic' },
      { chinese: '真挚美好的爱情不仅需要彼此倾心，更需要漫长岁月里的互相理解与包容。', pinyin: 'Zhēnzhì měihǎo de àiqíng bùjǐn xūyào bǐcǐ qīngxīn, gèng xūyào màncháng suìyuè lǐ de hùxiāng lǐjiě yǔ bāoróng.', meaning_vi: 'Tình yêu chân thành tốt đẹp không chỉ cần sự say đắm của đôi bên, mà càng cần sự thấu hiểu và bao dung lẫn nhau qua năm tháng dài lâu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '爱心',
    pinyin: 'àixīn',
    word_type: 'Danh từ',
    meaning_vi: 'lòng nhân ái, tấm lòng yêu thương',
    examples: [
      { chinese: '全校师生为灾区小朋友们献出了一份爱心。', pinyin: 'Quán xiào shīshēng wèi zāiqū xiǎopéngyoumen xiànchū le yí fèn àixīn.', meaning_vi: 'Toàn thể thầy trò trong trường đã trao gửi một tấm lòng yêu thương tới các em nhỏ vùng thiên tai.', difficulty_level: 'basic' },
      { chinese: '这家慈善机构呼吁全社会奉献爱心，关爱那些需要帮助的孤寡老人。', pinyin: 'Zhè jiā císhàn jīgòu hūyù quán shèhuì fèngxiàn àixīn, guān’ài nàxiē xūyào bāngzhù de gūguǎ lǎorén.', meaning_vi: 'Cơ quan từ thiện này kêu gọi toàn xã hội chung tay đóng góp tình yêu thương, chăm lo cho những người già neo đơn cần được giúp đỡ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '安检',
    pinyin: 'ānjiǎn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'kiểm tra an ninh',
    examples: [
      { chinese: '进入机场登机口前，所有旅客都要配合进行严格的安检。', pinyin: 'Jìnrù jīchǎng dēngjīkǒu qián, suǒyǒu lǚkè dōu yào pèihé jìnxíng yángé de ānjiǎn.', meaning_vi: 'Trước khi vào cửa lên máy bay ở sân bay, tất cả hành khách đều phải phối hợp kiểm tra an ninh nghiêm ngặt.', difficulty_level: 'basic' },
      { chinese: '高峰期乘坐地铁时请尽量少带大件行李，以便迅速通过安检通道。', pinyin: 'Gāofēngqī chéngzuò dìtiě shí qǐng jǐnliàng shǎo dài dàjiàn xíngli, yǐbiàn xùnsù tōngguò ānjiǎn tōngdào.', meaning_vi: 'Khi đi tàu điện ngầm vào giờ cao điểm xin hãy hạn chế mang hành lý cồng kềnh để nhanh chóng đi qua lối kiểm tra an ninh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '安排',
    pinyin: 'ānpái',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'sắp xếp, thu xếp; kế hoạch',
    examples: [
      { chinese: '经理把这次商务洽谈的接待工作安排得井井有条。', pinyin: 'Jīnglǐ bǎ zhè cì shāngwù qiàtán de jiēdài gōngzuò ānpái de jǐngjǐng-yǒutiáo.', meaning_vi: 'Giám đốc đã thu xếp công việc tiếp đón đàm phán thương mại lần này vô cùng ngăn nắp chu đáo.', difficulty_level: 'basic' },
      { chinese: '合理的日程安排不仅能显著提高工作效率，还能留出充足的时间陪伴家人。', pinyin: 'Hélǐ de rìchéng ānpái bùjǐn néng xiǎnzhù tígāo gōngzuò xiàolǜ, hái néng liú chū chōngzú de shíjiān péibàn jiārén.', meaning_vi: 'Sắp xếp lịch trình hợp lý không những nâng cao rõ rệt hiệu quả công việc mà còn dành ra được đủ thời gian bên gia đình.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '按',
    pinyin: 'àn',
    word_type: 'Động từ / Giới từ',
    meaning_vi: 'ấn, bấm; theo, căn cứ vào',
    examples: [
      { chinese: '请按下电梯右侧的按钮前往五层。', pinyin: 'Qǐng àn xià diàntī yòucè de ànniǔ qiánwǎng wǔ céng.', meaning_vi: 'Xin hãy bấm nút bấm bên phải thang máy để lên tầng năm.', difficulty_level: 'basic' },
      { chinese: '我们应该严格按合同规定的条款履行各自的责任与义务。', pinyin: 'Wǒmen yīnggāi yángé àn hétong guīdìng de tiáokuǎn lǚxíng gèzì de zérèn yǔ yìwù.', meaning_vi: 'Chúng ta nên thực hiện nghiêm túc trách nhiệm và nghĩa vụ của mỗi bên căn cứ theo các điều khoản trong hợp đồng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '按时',
    pinyin: 'ànshí',
    word_type: 'Phó từ',
    meaning_vi: 'đúng giờ',
    examples: [
      { chinese: '生病吃药一定要按时按量，切不可随意停药。', pinyin: 'Shēngbìng chī yào yídìng yào ànshí ànliàng, qiè bù kě suíyì tíng yào.', meaning_vi: 'Bị ốm uống thuốc nhất định phải đúng giờ đúng liều lượng, tuyệt đối không được tự ý ngừng thuốc.', difficulty_level: 'basic' },
      { chinese: '团队成员齐心协力赶进度，最终按时向客户交付了高质量的产品。', pinyin: 'Tuánduì chéngyuán qíxīn-xiélì gǎn jìndù, zuìzhōng ànshí xiàng kèhù jiāofù le gāo zhìliàng de chǎnpǐn.', meaning_vi: 'Các thành viên trong nhóm đồng lòng đẩy nhanh tiến độ, cuối cùng đã bàn giao sản phẩm chất lượng cao cho khách hàng đúng hạn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '按照',
    pinyin: 'ànzhào',
    word_type: 'Giới từ',
    meaning_vi: 'dựa theo, chiếu theo',
    examples: [
      { chinese: '请大家按照老师指导的步骤一步一步做实验。', pinyin: 'Qǐng dàjiā ànzhào lǎoshī zhǐdǎo de bùzhòu yí bù yí bù zuò shíyàn.', meaning_vi: 'Xin mọi người hãy làm thí nghiệm từng bước một theo đúng các bước thầy giáo đã hướng dẫn.', difficulty_level: 'basic' },
      { chinese: '公司各项财务报销必须严格按照最新的财务制度执行。', pinyin: 'Gōngsī gè xiàng cáiwù bàoxiāo bìxū yángé ànzhào zuìxīn de cáiwù zhìdù zhíxíng.', meaning_vi: 'Mọi khoản thanh toán tài chính của công ty đều phải chấp hành nghiêm ngặt theo quy chế tài chính mới nhất.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '白酒',
    pinyin: 'báijiǔ',
    word_type: 'Danh từ',
    meaning_vi: 'rượu trắng',
    examples: [
      { chinese: '中国传统宴席上往往少不了香醇浓厚的白酒。', pinyin: 'Zhōngguó chuántǒng yànxí shang wǎngwǎng shǎobuliǎo xiāngchún nónghòu de báijiǔ.', meaning_vi: 'Trên các bữa tiệc truyền thống Trung Hoa thường không thể thiếu món rượu trắng thơm nồng đậm đà.', difficulty_level: 'basic' },
      { chinese: '虽然逢年过节饮用白酒有助兴的习俗，但为了身体健康仍需适量少饮。', pinyin: 'Suīrán féngnián-guòjié yǐnyòng báijiǔ yǒu zhùxìng de xísú, dàn wèile shēntǐ jiànkāng réng xū shìliàng shǎo yǐn.', meaning_vi: 'Dù ngày Tết có phong tục uống rượu trắng góp vui, nhưng vì sức khỏe vẫn nên uống chừng mực ít lại.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '办公',
    pinyin: 'bàngōng',
    word_type: 'Động từ',
    meaning_vi: 'làm việc tại văn phòng, xử lý công vụ',
    examples: [
      { chinese: '王主任正在楼上的办公室办公，请您稍等片刻。', pinyin: 'Wáng zhǔrèn zhèngzài lóushang de bàngōngshì bàngōng, qǐng nín shāoděng piànkè.', meaning_vi: 'Chủ nhiệm Vương đang xử lý công vụ trong phòng làm việc trên tầng, xin ông đợi chốc lát.', difficulty_level: 'basic' },
      { chinese: '随着移动互联网技术的普及，越来越多企业开始推行灵活高效的远程居家办公模式。', pinyin: 'Suízhe yídòng hùliánwǎng jìshù de pǔjí, yuè lái yuè duō qǐyè kāishǐ tuīxíng línghuó gāoxiào de yuǎnchéng jūjiā bàngōng móshì.', meaning_vi: 'Cùng với sự phổ biến của công nghệ internet di động, ngày càng nhiều doanh nghiệp bắt đầu áp dụng mô hình làm việc từ xa tại nhà linh hoạt và hiệu quả.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '办理',
    pinyin: 'bànlǐ',
    word_type: 'Động từ',
    meaning_vi: 'xử lý, giải quyết, làm thủ tục',
    examples: [
      { chinese: '请您带好身份证前往前台办理入住登记手续。', pinyin: 'Qǐng nín dài hǎo shēnfènzhèng qiánwǎng qiántái bànlǐ rùzhù dēngjì shǒuxù.', meaning_vi: 'Xin quý khách mang theo chứng minh thư tới quầy lễ tân để làm thủ tục đăng ký nhận phòng.', difficulty_level: 'basic' },
      { chinese: '出国留学前，务必要提前准备好各项材料以便顺利办理签证。', pinyin: 'Chūguó liúxué qián, wùbì yào tíqián zhǔnbèi hǎo gè xiàng cáiliào yǐbiàn shùnlì bànlǐ qiānzhèng.', meaning_vi: 'Trước khi đi du học nước ngoài, nhất định phải chuẩn bị sẵn sàng các loại giấy tờ để làm visa thuận lợi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '办事',
    pinyin: 'bànshì',
    word_type: 'Động từ',
    meaning_vi: 'làm việc, giải quyết công việc',
    examples: [
      { chinese: '他为人沉稳老练，办事一向非常认真踏实。', pinyin: 'Tā wéirén chénwěn lǎoliàn, bànshì yíxiàng fēicháng rènzhēn tāshi.', meaning_vi: 'Anh ấy đối nhân xử thế điềm đạm từng trải, làm việc luôn hết sức cẩn thận vững vàng.', difficulty_level: 'basic' },
      { chinese: '市民服务中心推行一站式服务，极大地方便了广大群众前来办事。', pinyin: 'Shìmín fúwù zhōngxīn tuīxíng yízhànshì fúwù, jídà de fāngbiàn le guǎngdà qúnzhòng qiánlái bànshì.', meaning_vi: 'Trung tâm dịch vụ công người dân triển khai dịch vụ một cửa, tạo thuận tiện tối đa cho đông đảo quần chúng tới giải quyết thủ tục hành chính.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '棒',
    pinyin: 'bàng',
    word_type: 'Tính từ',
    meaning_vi: 'giỏi, cừ, tuyệt vời; cây gậy',
    examples: [
      { chinese: '你在今天的汉语演讲比赛中表现得太棒了！', pinyin: 'Nǐ zài jīntiān de Hànyǔ yǎnjiǎng bǐsài zhōng biǎoxiàn de tài bàng le!', meaning_vi: 'Hôm nay bạn thể hiện trong cuộc thi hùng biện tiếng Trung cừ khôi quá!', difficulty_level: 'basic' },
      { chinese: '他不仅学习成绩拔尖，体育运动方面也很棒，是大家公认的榜样。', pinyin: 'Tā bùjǐn xuéxí chéngjì bájiān, tǐyù yùndòng fāngmiàn yě hěn bàng, shì dàjiā gōngrèn de bǎngyàng.', meaning_vi: 'Cậu ấy không chỉ có thành tích học tập xuất sắc mà phương diện thể thao cũng rất cừ, là tấm gương mẫu mực được mọi người công nhận.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '保护',
    pinyin: 'bǎohù',
    word_type: 'Động từ',
    meaning_vi: 'bảo vệ',
    examples: [
      { chinese: '爱护树木、保护生态环境是每个公民应尽的责任。', pinyin: 'Àihù shùmù, bǎohù shēngtài huánjìng shì měi gè gōngmín yīng jìn de zérèn.', meaning_vi: 'Yêu quý cây xanh, bảo vệ môi trường sinh thái là trách nhiệm mà mỗi công dân cần thực hiện.', difficulty_level: 'basic' },
      { chinese: '日常使用手机和电脑时要注意用眼卫生，切实保护好自己的视力。', pinyin: 'Rìcháng shǐyòng shǒujī hé diànnǎo shí yào zhùyì yòngyǎn wèishēng, qièshí bǎohù hǎo zìjǐ de shìlì.', meaning_vi: 'Hàng ngày khi dùng điện thoại và máy tính cần chú ý vệ sinh mắt để bảo vệ tốt thị lực của mình.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '保证',
    pinyin: 'bǎozhèng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'bảo đảm, cam đoan; sự bảo đảm',
    examples: [
      { chinese: '我向大家保证，一定会在规定期限内保质保量完成任务。', pinyin: 'Wǒ xiàng dàjiā bǎozhèng, yídìng huì zài guīdìng qīxiàn nèi bǎozhì-bǎoliàng wánchéng rènwu.', meaning_vi: 'Tôi bảo đảm với mọi người, nhất định sẽ hoàn thành nhiệm vụ đúng hạn định cả về chất lẫn lượng.', difficulty_level: 'basic' },
      { chinese: '充足的睡眠和均衡的饮食是维持身体健康的最基本保证。', pinyin: 'Chōngzú de shuìmián hé jūnhéng de yǐnshí shì wéichí shēntǐ jiànkāng de zuì jīběn bǎozhèng.', meaning_vi: 'Giấc ngủ đầy đủ và chế độ ăn uống cân bằng là sự bảo đảm cơ bản nhất để duy trì sức khỏe cơ thể.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '抱',
    pinyin: 'bào',
    word_type: 'Động từ',
    meaning_vi: 'ôm, ẵm, bế',
    examples: [
      { chinese: '母亲温柔地把哭泣的婴儿抱在怀里轻声哄着。', pinyin: 'Mǔqīn wēnróu de bǎ kūqì de yīng’ér bào zài huái lǐ qīngshēng hǒng zhe.', meaning_vi: 'Người mẹ dịu dàng ôm đứa trẻ sơ sinh đang khóc vào lòng khẽ dỗ dành.', difficulty_level: 'basic' },
      { chinese: '久别重逢的两位挚友激动地紧紧拥抱在一起，久久不愿分开。', pinyin: 'Jiǔbié-chóngféng de liǎng wèi zhìyǒu jīdòng de jǐnjǐn yōngbào zài yìqǐ, jiǔjiǔ bú yuàn fēnkāi.', meaning_vi: 'Hai người bạn thân lâu ngày hội ngộ xúc động ôm chặt lấy nhau, mãi không nỡ rời.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '报考',
    pinyin: 'bàokǎo',
    word_type: 'Động từ',
    meaning_vi: 'đăng ký dự thi',
    examples: [
      { chinese: '高中毕业后，他决定报考北京大学的中文系。', pinyin: 'Gāozhōng bìyè hòu, tā juédìng bàokǎo Běijīng Dàxué de Zhōngwén xì.', meaning_vi: 'Sau khi tốt nghiệp cấp ba, anh ấy quyết định đăng ký dự thi vào khoa Trung văn trường Đại học Bắc Kinh.', difficulty_level: 'basic' },
      { chinese: '考生在报考研究生专业前，应当结合自身的学术兴趣和长远职业规划慎重抉择。', pinyin: 'Kǎoshēng zài bàokǎo yánjiūshēng zhuānyè qián, yīngdāng jiéhé zìshēn de xuéshù xìngqù hé chángyuǎn zhíyè guīhuà shènzhòng juézé.', meaning_vi: 'Thí sinh trước khi đăng ký dự thi chuyên ngành cao học nên kết hợp sở thích học thuật của bản thân và định hướng nghề nghiệp lâu dài để lựa chọn thận trọng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '报名',
    pinyin: 'bàomíng',
    word_type: 'Động từ',
    meaning_vi: 'ghi danh, đăng ký',
    examples: [
      { chinese: '新学期的书法兴趣班明天上午开始正式报名。', pinyin: 'Xīn xuéqī de shūfǎ xìngqù bān míngtiān shàngwǔ kāishǐ zhèngshì bàomíng.', meaning_vi: 'Lớp học thư pháp năng khiếu của học kỳ mới sáng mai bắt đầu chính thức nhận đăng ký.', difficulty_level: 'basic' },
      { chinese: '听说了这次国际马拉松赛事的举办消息，许多运动爱好者纷纷踊跃报名参加。', pinyin: 'Tīngshuō le zhè cì guójì mǎlāsōng sàishì de jǔbàn xiāoxi, xǔduō yùndòng àihàozhě fēnfēn yǒngyuè bàomíng cānjiā.', meaning_vi: 'Nghe tin giải chạy marathon quốc tế lần này được tổ chức, đông đảo người yêu thể thao đã nô nức ghi danh tham gia.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '抱歉',
    pinyin: 'bàoqiàn',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'xin lỗi, áy náy',
    examples: [
      { chinese: '非常抱歉，路上堵车耽误了时间，让您久等了。', pinyin: 'Fēicháng bàoqiàn, lù shang dǔchē dānwu le shíjiān, ràng nín jiǔ děng le.', meaning_vi: 'Vô cùng xin lỗi, trên đường kẹt xe làm lỡ mất thời gian khiến anh phải đợi lâu.', difficulty_level: 'basic' },
      { chinese: '由于天气突变导致航班延误，航空公司向全体乘客深表抱歉并妥善安排了食宿。', pinyin: 'Yóuyú tiānqì tūbiàn dǎozhì hángbān yánwù, hángkōng gōngsī xiàng quántǐ chéngkè shēn biǎo bàoqiàn bìng tuǒshàn ānpái le shí-sù.', meaning_vi: 'Do thời tiết thay đổi đột ngột làm chuyến bay bị hoãn, hãng hàng không bày tỏ sự xin lỗi sâu sắc tới toàn thể hành khách và thu xếp ăn ở chu đáo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '背',
    pinyin: 'bēi',
    word_type: 'Động từ',
    meaning_vi: 'cõng, đeo, mang trên lưng',
    examples: [
      { chinese: '小学生们每天早晨背着书包开开心心去上学。', pinyin: 'Xiǎoxuéshēngmen měitiān zǎochén bēi zhe shūbāo kāikāi-xīnxīn qù shàngxué.', meaning_vi: 'Các em học sinh tiểu học mỗi sáng đeo ba lô vui vẻ tới trường.', difficulty_level: 'basic' },
      { chinese: '父亲背着年幼发烧的孩子冒着大雨匆匆赶往医院看急诊。', pinyin: 'Fùqīn bēi zhe niányòu fāshāo de háizi mào zhe dàyǔ cōngcōng gǎnwǎng yīyuàn kàn jízhěn.', meaning_vi: 'Người cha cõng đứa con nhỏ đang phát sốt đội mưa vội vã chạy tới bệnh viện cấp cứu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '背包',
    pinyin: 'bēibāo',
    word_type: 'Danh từ',
    meaning_vi: 'ba lô, túi đeo lưng',
    examples: [
      { chinese: '这个黑色双肩背包容量很大，适合旅行时使用。', pinyin: 'Zhè gè hēisè shuāngjiān bēibāo róngliàng hěn dà, shìhé lǚxíng shí shǐyòng.', meaning_vi: 'Chiếc ba lô hai quai màu đen này dung tích rất lớn, thích hợp dùng khi đi du lịch.', difficulty_level: 'basic' },
      { chinese: '出门徒步远足前，一定要仔细检查背包里的水壶、急救药品和充电宝是否带齐。', pinyin: 'Chūmén túbù yuǎnzú qián, yídìng yào zǐxì jiǎnchá bēibāo lǐ de shuǐhú, jíjiù yàopǐn hé chōngdiànbǎo shìfǒu dài qí.', meaning_vi: 'Trước khi ra ngoài đi bộ đường dài, nhất định phải kiểm tra kỹ lưỡng bình nước, thuốc sơ cứu và sạc dự phòng trong ba lô đã mang đủ chưa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '北部',
    pinyin: 'běibù',
    word_type: 'Danh từ',
    meaning_vi: 'miền bắc, phía bắc',
    examples: [
      { chinese: '中国北部的冬天雪景壮丽，银装素裹。', pinyin: 'Zhōngguó běibù de dōngtiān xuějǐng zhuànglì, yínzhuāng-sùguǒ.', meaning_vi: 'Mùa đông miền bắc Trung Quốc cảnh tuyết hùng vĩ, khoác lên mình chiếc áo trắng bạc.', difficulty_level: 'basic' },
      { chinese: '这家科技企业计划在国家北部各大重点城市设立区域研发中心。', pinyin: 'Zhè jiā kējì qǐyè jìhuà zài guójiā běibù gè dà zhòngdiǎn chéngshì shèlì qūyù yánfā zhōngxīn.', meaning_vi: 'Doanh nghiệp công nghệ này dự định thành lập các trung tâm nghiên cứu phát triển vùng tại các thành phố trọng điểm phía bắc đất nước.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '倍',
    pinyin: 'bèi',
    word_type: 'Lượng từ',
    meaning_vi: 'lần, gấp bội (lượng từ số lần gấp)',
    examples: [
      { chinese: '今年我们果园的水果产量比去年增加了一倍。', pinyin: 'Jīnnián wǒmen guǒyuán de shuǐguǒ chǎnliàng bǐ qùnián zēngjiā le yí bèi.', meaning_vi: 'Sản lượng hoa quả của vườn chúng tôi năm nay tăng gấp đôi so với năm ngoái.', difficulty_level: 'basic' },
      { chinese: '采用新型自动化流水线之后，工人们的生产效率整整提高了三倍。', pinyin: 'Cǎiyòng xīnxíng zìdònghuà liúshuǐxiàn zhīhòu, gōngrénmen de shēngchǎn xiàolǜ zhěngzhěng tígāo le sān bèi.', meaning_vi: 'Sau khi áp dụng dây chuyền tự động hóa kiểu mới, năng suất sản xuất của công nhân đã tăng trọn vẹn gấp ba lần.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '本科',
    pinyin: 'běnkē',
    word_type: 'Danh từ',
    meaning_vi: 'đại học chính quy, hệ cử nhân',
    examples: [
      { chinese: '完成四年本科学习后，他打算继续攻读硕士研究生。', pinyin: 'Wánchéng sì nián běnkē xuéxí hòu, tā dǎsuàn jìxù gōngdú shuòshì yánjiūshēng.', meaning_vi: 'Sau khi hoàn thành bốn năm học đại học chính quy, cậu ấy dự định tiếp tục học thạc sĩ.', difficulty_level: 'basic' },
      { chinese: '这所知名综合性大学的本科教学注重理论基础与科研实践的有机结合。', pinyin: 'Zhè suǒ zhīmíng zōnghéxìng dàxué de běnkē jiàoxué zhùzhòng lǐlùn jīchǔ yǔ kēyán shíjiàn de yǒujī jiéhé.', meaning_vi: 'Chương trình giảng dạy hệ cử nhân của trường đại học tổng hợp danh tiếng này chú trọng sự kết hợp hữu cơ giữa nền tảng lý thuyết và thực hành nghiên cứu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '本来',
    pinyin: 'běnlái',
    word_type: 'Phó từ / Tính từ',
    meaning_vi: 'vốn dĩ, ban đầu',
    examples: [
      { chinese: '我本来打算今天去郊游，可是突如其来的大雨打乱了计划。', pinyin: 'Wǒ běnlái dǎsuàn jīntiān qù jiāoyóu, kěshì tūrúqílái de dàyǔ dǎluàn le jìhuà.', meaning_vi: 'Tôi vốn định đi dã ngoại hôm nay, nhưng cơn mưa lớn bất ngờ đã làm đảo lộn kế hoạch.', difficulty_level: 'basic' },
      { chinese: '这件事情本来并不复杂，由于各方沟通不畅才演变成现在的僵局。', pinyin: 'Zhè jiàn shìqing běnlái bìng bù fùzá, yóuyú gè fāng gōutōng bú chàng cái yǎnbiàn chéng xiànzài de jiāngjú.', meaning_vi: 'Chuyện này vốn không hề phức tạp, do các bên trao đổi không thông suốt mới biến thành cục diện bế tắc hiện nay.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '笨',
    pinyin: 'bèn',
    word_type: 'Tính từ',
    meaning_vi: 'ngốc, vụng về, chậm chạp',
    examples: [
      { chinese: '不要总觉得自己笨，只要肯下苦功夫就一定能学好。', pinyin: 'Bú yào zǒng juéde zìjǐ bèn, zhǐyào kěn xià kǔ gōngfu jiù yídìng néng xué hǎo.', meaning_vi: 'Đừng luôn nghĩ rằng mình ngốc, chỉ cần chịu khó khổ luyện thì nhất định sẽ học giỏi.', difficulty_level: 'basic' },
      { chinese: '“笨鸟先飞早入林”，天资不够聪颖的人更应当凭借勤奋努力赢得成功。', pinyin: '“Bènniǎo-xiānfēi zǎo rù lín”, tiānzī bú gòu cōngyǐng de rén gèng yīngdāng píngjiè qínfèn nǔlì yíngdé chénggōng.', meaning_vi: '"Chim chậm bay trước vào rừng sớm", người có thiên tư chưa đủ thông minh càng nên dựa vào sự siêng năng cần cù để giành lấy thành công.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '鼻子',
    pinyin: 'bízi',
    word_type: 'Danh từ',
    meaning_vi: 'mũi',
    examples: [
      { chinese: '他感冒了，鼻子一直堵着很不舒服。', pinyin: 'Tā gǎnmào le, bízi yìzhí dǔ zhe hěn bù shūfu.', meaning_vi: 'Cậu ấy bị cảm cúm, mũi cứ nghẹt suốt rất khó chịu.', difficulty_level: 'basic' },
      { chinese: '警犬的鼻子拥有极其敏锐的嗅觉，能够迅速搜寻出隐藏的违禁物品。', pinyin: 'Jǐngquǎn de bízi yōngyǒu jíqí mǐnruì de xiùjué, nénggòu xùnsù sōuxún chū yǐncáng de wéijìn wùpǐn.', meaning_vi: 'Chiếc mũi của chó nghiệp vụ sở hữu khứu giác cực kỳ nhạy bén, có thể nhanh chóng đánh hơi ra các đồ vật cấm được giấu kỹ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '笔试',
    pinyin: 'bǐshì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'thi viết, bài thi viết',
    examples: [
      { chinese: '通过了第一轮笔试之后，他收到了下周面试的通知。', pinyin: 'Tōngguò le dì-yī lún bǐshì zhīhòu, tā shōudào le xià zhōu miànshì de tōngzhī.', meaning_vi: 'Sau khi qua vòng thi viết đầu tiên, anh ấy đã nhận được thông báo phỏng vấn vào tuần tới.', difficulty_level: 'basic' },
      { chinese: '这次公务员招聘考核分为专业笔试和综合面试两个主要环节。', pinyin: 'Zhè cì gōngwùyuán zhāopìn kǎohé fēnwéi zhuānyè bǐshì hé zōnghé miànshì liǎng gè zhǔyào huánjié.', meaning_vi: 'Kỳ thi tuyển dụng công chức lần này được chia thành hai khâu then chốt: thi viết chuyên môn và phỏng vấn tổng hợp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '毕业',
    pinyin: 'bìyè',
    word_type: 'Động từ',
    meaning_vi: 'tốt nghiệp',
    examples: [
      { chinese: '同学们穿着学士服在图书馆门前拍毕业合影。', pinyin: 'Tóngxuémen chuān zhe xuéshìfú zài túshūguǎn ménqián pāi bìyè héyǐng.', meaning_vi: 'Các bạn học sinh viên mặc áo cử nhân chụp ảnh kỷ yếu tốt nghiệp trước cửa thư viện.', difficulty_level: 'basic' },
      { chinese: '大学毕业不仅标志着一段学习生涯的结束，更意味着正式开启崭新的人生职场旅程。', pinyin: 'Dàxué bìyè bùjǐn biāozhì zhe yí duàn xuéxí shēngyá de jiéshù, gèng yìwèizhe zhèngshì kāiqǐ zhǎnxīn de rénshēng zhíchǎng lǚchéng.', meaning_vi: 'Tốt nghiệp đại học không chỉ đánh dấu kết thúc một chặng đường học tập, mà càng có ý nghĩa chính thức mở ra hành trình sự nghiệp đời người mới toanh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '毕业生',
    pinyin: 'bìyèshēng',
    word_type: 'Danh từ',
    meaning_vi: 'sinh viên / học sinh tốt nghiệp',
    examples: [
      { chinese: '每年六月份，高校毕业生们都会迎来繁忙的求职季。', pinyin: 'Měinián liù yuèfèn, gāoxiào bìyèshēngmen dōu huì yínglái fánmáng de qiúzhí jì.', meaning_vi: 'Vào tháng sáu hàng năm, các sinh viên tốt nghiệp đại học đều đón mùa tìm việc làm bận rộn.', difficulty_level: 'basic' },
      { chinese: '为了促进优秀毕业生就业，学校特意邀请了上百家知名企业举办大型双选招聘会。', pinyin: 'Wèile cùjìn yōuxiù bìyèshēng jiùyè, xuéxiào tèyì yāoqǐng le shàngbǎi jiā zhīmíng qǐyè jǔbàn dàxíng shuāngxuǎn zhāopìnhuì.', meaning_vi: 'Nhằm thúc đẩy việc làm cho sinh viên tốt nghiệp ưu tú, nhà trường đã đặc biệt mời hàng trăm doanh nghiệp tên tuổi tổ chức hội chợ việc làm quy mô lớn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '便于',
    pinyin: 'biànyú',
    word_type: 'Động từ',
    meaning_vi: 'thuận tiện cho, tiện bề',
    examples: [
      { chinese: '请把生词按照首字母顺序排列，便于日后查找复习。', pinyin: 'Qǐng bǎ shēngcí ànzhào shǒuzìmǔ shùnxù páiliè, biànyú rìhòu cházhǎo fùxí.', meaning_vi: 'Xin hãy xếp từ mới theo thứ tự chữ cái đầu tiên để thuận tiện cho việc tra cứu ôn tập sau này.', difficulty_level: 'basic' },
      { chinese: '城市规划应当优先完善公共交通网络，以便于广大居民绿色低碳出行。', pinyin: 'Chéngshì guīhuà yīngdāng yōuxiān wánshàn gōnggòng jiāotōng wǎngluò, yǐ biànyú guǎngdà jūmín lǜsè dītàn chūxíng.', meaning_vi: 'Quy hoạch đô thị nên ưu tiên hoàn thiện mạng lưới giao thông công cộng nhằm tạo thuận tiện cho người dân đi lại xanh và giảm phát thải.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '标准',
    pinyin: 'biāozhǔn',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'tiêu chuẩn, chuẩn mực; chuẩn',
    examples: [
      { chinese: '他的普通话发音非常标准，听起来就像播音员一样。', pinyin: 'Tā de pǔtōnghuà fāyīn fēicháng biāozhǔn, tīng qǐlái jiù xiàng bōyīnyuán yíyàng.', meaning_vi: 'Phát âm tiếng phổ thông của anh ấy rất chuẩn xác, nghe hệt như phát thanh viên vậy.', difficulty_level: 'basic' },
      { chinese: '严格的质量检验标准是企业赢得海内外客户长期信赖的核心保障。', pinyin: 'Yángé de zhìliàng jiǎnyàn biāozhǔn shì qǐyè yíngdé hǎinèiwài kèhù chángqī xìnlài de héxīn bǎozhàng.', meaning_vi: 'Tiêu chuẩn kiểm định chất lượng nghiêm ngặt là bảo đảm cốt lõi giúp doanh nghiệp chiếm trọn niềm tin lâu dài của khách hàng trong và ngoài nước.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '表',
    pinyin: 'biǎo',
    word_type: 'Danh từ',
    meaning_vi: 'đồng hồ; biểu mẫu, bảng kê',
    examples: [
      { chinese: '我的手表慢了五分钟，需要校对一下时间。', pinyin: 'Wǒ de shǒubiǎo màn le wǔ fēnzhōng, xūyào jiàoduì yíxià shíjiān.', meaning_vi: 'Đồng hồ đeo tay của tôi bị chậm năm phút, cần phải chỉnh lại giờ.', difficulty_level: 'basic' },
      { chinese: '请新入职的员工仔细核对个人信息登记表中的各项内容。', pinyin: 'Qǐng xīn rùzhí de yuángōng zǐxì héduì gèrén xìnxī dēngjì biǎo zhōng de gè xiàng nèiróng.', meaning_vi: 'Xin các nhân viên mới vào làm kiểm tra kỹ các mục nội dung trong biểu mẫu đăng ký thông tin cá nhân.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '表格',
    pinyin: 'biǎogé',
    word_type: 'Danh từ',
    meaning_vi: 'bảng biểu, mẫu đơn',
    examples: [
      { chinese: '请在十分钟内把这张报名表格填写完整。', pinyin: 'Qǐng zài shí fēnzhōng nèi bǎ zhè zhāng bàomíng biǎogé tiánxiě wánzhěng.', meaning_vi: 'Xin hãy điền hoàn chỉnh mẫu đơn đăng ký này trong vòng mười phút.', difficulty_level: 'basic' },
      { chinese: '财务人员使用电子表格软件对全年的收支数据进行了系统的汇总与分析。', pinyin: 'Cáiwù rényuán shǐyòng diànzǐ biǎogé ruǎnjiàn duì quán nián de shōuzhī shùjù jìnxíng le xìtǒng de huìzǒng yǔ fēnxī.', meaning_vi: 'Nhân viên kế toán đã dùng phần mềm bảng tính điện tử để tổng hợp và phân tích có hệ thống số liệu thu chi cả năm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '表示',
    pinyin: 'biǎoshì',
    word_type: 'Động từ',
    meaning_vi: 'bày tỏ, biểu thị, cho thấy',
    examples: [
      { chinese: '客人们微笑着点头，对主人的热情款待表示由衷的感谢。', pinyin: 'Kèrénmen wēixiào zhe diǎntóu, duì zhǔrén de rèqíng kuǎndài biǎoshì yóuzhōng de gǎnxiè.', meaning_vi: 'Những vị khách mỉm cười gật đầu, bày tỏ lòng cảm ơn chân thành trước sự tiếp đãi nhiệt tình của chủ nhà.', difficulty_level: 'basic' },
      { chinese: '专家在会上表示，只有坚持科技自主创新，才能在国际竞争中立于不败之地。', pinyin: 'Zhuānjiā zài huì shang biǎoshì, zhǐyào jiānchí kējì zìzhǔ chuàngxīn, cái néng zài guójì jìngzhēng zhōng lìyú-búbàizhīdì.', meaning_vi: 'Chuyên gia phát biểu tại hội nghị cho biết, chỉ khi kiên trì đổi mới công nghệ tự chủ mới có thể đứng vững trong cạnh tranh quốc tế.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '表现',
    pinyin: 'biǎoxiàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'thể hiện, biểu hiện',
    examples: [
      { chinese: '他在这学期的几次中文测试中都表现得十分优异。', pinyin: 'Tā zài zhè xuéqī de jǐ cì Zhōngwén cèshì zhōng dōu biǎoxiàn de shífēn yōuyì.', meaning_vi: 'Cậu ấy trong các đợt kiểm tra tiếng Trung học kỳ này đều thể hiện vô cùng xuất sắc.', difficulty_level: 'basic' },
      { chinese: '面对突如其来的紧急状况，机组人员临危不乱，表现出了极高的专业素养。', pinyin: 'Miànduì tūrúqílái de jǐnjí zhuàngkuàng, jīzǔ rényuán línwēi-búluàn, biǎoxiàn chū le jí gāo de zhuānyè sùyǎng.', meaning_vi: 'Trước tình huống khẩn cấp bất ngờ xảy ra, phi hành đoàn bình tĩnh ứng phó, thể hiện tố chất chuyên môn cực kỳ cao.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '表扬',
    pinyin: 'biǎoyáng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'khen ngợi, biểu dương',
    examples: [
      { chinese: '老师在全班同学面前表扬了他助人为乐的精神。', pinyin: 'Lǎoshī zài quán bān tóngxué miànqián biǎoyáng le tā zhùrén-wéilè de jīngshén.', meaning_vi: 'Thầy giáo biểu dương tinh thần sẵn lòng giúp đỡ người khác của cậu ấy trước toàn thể lớp.', difficulty_level: 'basic' },
      { chinese: '受到领导的公开表扬之后，小李的工作积极性和责任感有了进一步提升。', pinyin: 'Shòudào lǐngdǎo de gōngkāi biǎoyáng zhīhòu, Xiǎo Lǐ de gōngzuò jījíxìng hé zérèngǎn yǒu le jìn yí bù tíshēng.', meaning_vi: 'Sau khi được lãnh đạo công khai khen ngợi, tính chủ động tích cực và tinh thần trách nhiệm trong công việc của Tiểu Lý lại càng được nâng cao.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '饼干',
    pinyin: 'bǐnggān',
    word_type: 'Danh từ',
    meaning_vi: 'bánh quy',
    examples: [
      { chinese: '下午茶时间，吃几块酥脆的饼干配上一杯红茶非常惬意。', pinyin: 'Xiàwǔchá shíjiān, chī jǐ kuài sūcuì de bǐnggān pèi shàng yì bēi hóngchá fēicháng qièyì.', meaning_vi: 'Vào giờ trà chiều, ăn vài chiếc bánh quy giòn tan kèm một ly hồng trà thật khoan khoái dễ chịu.', difficulty_level: 'basic' },
      { chinese: '妈妈亲手烘焙的巧克力夹心饼干香气扑鼻，深受邻里小朋友们的喜爱。', pinyin: 'Māma qīnshǒu hōngbèi de qiǎokèlì jiāxīn bǐnggān xiāngqì pūbí, shēn shòu línlǐ xiǎopéngyoumen de xǐ’ài.', meaning_vi: 'Mẻ bánh quy kẹp sô-cô-la do mẹ tự tay nướng thơm lừng nức mũi, được các em nhỏ hàng xóm rất yêu thích.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '并',
    pinyin: 'bìng',
    word_type: 'Phó từ / Liên từ',
    meaning_vi: 'đồng thời; thực sự, hoàn toàn (nhấn mạnh phủ định)',
    examples: [
      { chinese: '这件事情并没有想象中那么复杂，放平心态就好。', pinyin: 'Zhè jiàn shìqing bìng méiyǒu xiǎngxiàng zhōng nàme fùzá, fàng píng xīntài jiù hǎo.', meaning_vi: 'Chuyện này thực sự không phức tạp như tưởng tượng, cứ giữ tâm thái bình thản là được.', difficulty_level: 'basic' },
      { chinese: '大会认真总结了过去一年的辉煌成就，并明确制定了下一阶段的战略发展目标。', pinyin: 'Dàhuì rènzhēn zǒngjié le guòqù yì nián de huīhuáng chéngjiù, bìng míngquè zhìdìng le xià yí jiēduàn de zhànlüè fāzhǎn mùbiāo.', meaning_vi: 'Đại hội đã nghiêm túc tổng kết những thành tựu rực rỡ năm vừa qua, đồng thời xác lập rõ mục tiêu phát triển chiến lược cho giai đoạn kế tiếp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '并且',
    pinyin: 'bìngqiě',
    word_type: 'Liên từ',
    meaning_vi: 'đồng thời, hơn nữa',
    examples: [
      { chinese: '她不仅工作能力强，并且对待同事总是热情和善。', pinyin: 'Tā bùjǐn gōngzuò nénglì qiáng, bìngqiě duìdài tóngshì zǒngshì rèqíng héshàn.', meaning_vi: 'Cô ấy không chỉ năng lực công việc giỏi giang, mà hơn nữa đối xử với đồng nghiệp luôn nhiệt tình hòa nhã.', difficulty_level: 'basic' },
      { chinese: '项目团队在规定时间内圆满完成了研发任务，并且各项性能指标均超出了原定预期。', pinyin: 'Xiàngmù tuánduì zài guīdìng shíjiān nèi yuánmǎn wánchéng le yánfā rènwu, bìngqiě gè xiàng xìngnéng zhǐbiāo jūn chāochū le yuándìng yùqī.', meaning_vi: 'Nhóm dự án đã hoàn thành xuất sắc nhiệm vụ nghiên cứu phát triển trong thời gian quy định, đồng thời mọi chỉ số tính năng đều vượt mức kỳ vọng ban đầu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '播放',
    pinyin: 'bōfàng',
    word_type: 'Động từ',
    meaning_vi: 'phát sóng, mở (nhạc, video)',
    examples: [
      { chinese: '广播电台正在播放一首优美舒缓的古典轻音乐。', pinyin: 'Guǎngbō diàntái zhèngzài bōfàng yì shǒu yōuměi shūhuǎn de gǔdiǎn qīngyīnyuè.', meaning_vi: 'Đài phát thanh đang phát một bản nhạc nhẹ cổ điển êm đềm du dương.', difficulty_level: 'basic' },
      { chinese: '在历史课开始前，老师利用多媒体设备播放了一部生动精彩的纪录片。', pinyin: 'Zài lìshǐ kè kāishǐ qián, lǎoshī lìyòng duōméitǐ shèbèi bōfàng le yí bù shēngdòng jīngcǎi de jìlùpiàn.', meaning_vi: 'Trước khi tiết học lịch sử bắt đầu, thầy giáo dùng thiết bị đa phương tiện chiếu một bộ phim tài liệu sinh động hấp dẫn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '博士',
    pinyin: 'bóshì',
    word_type: 'Danh từ',
    meaning_vi: 'tiến sĩ',
    examples: [
      { chinese: '李博士在人工智能领域发表了许多具有国际影响力的高水平论文。', pinyin: 'Lǐ bóshì zài réngōng zhìnéng lǐngyù fābiǎo le xǔduō jùyǒu guójì yǐngxiǎnglì de gāo shuǐpíng lùnwén.', meaning_vi: 'Tiến sĩ Lý đã công bố nhiều bài báo khoa học chất lượng cao có tầm ảnh hưởng quốc tế trong lĩnh vực trí tuệ nhân tạo.', difficulty_level: 'basic' },
      { chinese: '攻读博士学位不仅需要扎实深厚的学术功底，更需要长年累月潜心钻研的毅力。', pinyin: 'Gōngdú bóshì xuéwèi bùjǐn xūyào zhāshi shēnhòu de xuéshù gōngdǐ, gèng xūyào chángnián-lěiyuè qiánxīn zuānyán de yìlì.', meaning_vi: 'Học lấy bằng tiến sĩ không chỉ đòi hỏi nền tảng học thuật vững chắc sâu dày, mà càng cần nghị lực miệt mài nghiên cứu tháng ngày.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不必',
    pinyin: 'búbì',
    word_type: 'Phó từ',
    meaning_vi: 'không cần thiết, không cần',
    examples: [
      { chinese: '这只是一件微不足道的小事，你完全不必放在心上。', pinyin: 'Zhè zhǐ shì yí jiàn wēibùzúdào de xiǎoshì, nǐ wánquán búbì fàng zài xīn shang.', meaning_vi: 'Đây chỉ là chuyện nhỏ không đáng bận tâm, bạn hoàn toàn không cần phải để bụng.', difficulty_level: 'basic' },
      { chinese: '大家既然已经是多年的老朋友了，见面时就不必再如此拘谨客气。', pinyin: 'Dàjiā jìrán yǐjīng shì duō nián de lǎo péngyou le, jiànmiàn shí jiù búbì zài rúcǐ jūjǐn kèqi.', meaning_vi: 'Mọi người đã là bạn thân nhiều năm rồi, khi gặp mặt không cần phải câu nệ khách sáo đến thế nữa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不便',
    pinyin: 'búbiàn',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'bất tiện, không thuận tiện',
    examples: [
      { chinese: '道路施工期间给周边居民出行带来了诸多不便，敬请谅解。', pinyin: 'Dàolù shīgōng qījiān gěi zhōubiān jūmín chūxíng dài lái le zhūduō búbiàn, jìng qǐng liàngjiě.', meaning_vi: 'Trong thời gian thi công đường xá mang lại nhiều bất tiện cho việc đi lại của cư dân xung quanh, kính mong thông cảm.', difficulty_level: 'basic' },
      { chinese: '老奶奶腿脚不便，邻居们经常主动帮她采购日常米面蔬菜。', pinyin: 'Lǎonǎinai tuǐjiǎo búbiàn, línjūmen jīngcháng zhǔdòng bāng tā cǎigòu rìcháng mǐ-miàn shūcài.', meaning_vi: 'Bà cụ chân cẳng đi lại bất tiện, hàng xóm thường chủ động giúp bà mua sắm gạo mì rau củ hàng ngày.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不断',
    pinyin: 'búduàn',
    word_type: 'Phó từ / Động từ',
    meaning_vi: 'không ngừng, liên tục',
    examples: [
      { chinese: '社会在不断发展进步，我们每个人也必须终身学习。', pinyin: 'Shèhuì zài búduàn fāzhǎn jìnbù, wǒmen měi gè rén yě bìxū zhōngshēn xuéxí.', meaning_vi: 'Xã hội đang không ngừng phát triển tiến bộ, mỗi chúng ta cũng phải học tập suốt đời.', difficulty_level: 'basic' },
      { chinese: '经过多年不断的探索与技术改进，我国新能源汽车产业取得了举世瞩目的成就。', pinyin: 'Jīngguò duō nián búduàn de tànsuǒ yǔ jìshù gǎijìn, wǒguó xīnnéngyuán qìchē chǎnyè qǔdé le jǔshì-zhǔmù de chéngjiù.', meaning_vi: 'Trải qua nhiều năm không ngừng tìm tòi và cải tiến kỹ thuật, ngành công nghiệp xe năng lượng mới của nước ta đã đạt được những thành tựu khiến cả thế giới dõi theo.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不够',
    pinyin: 'búgòu',
    word_type: 'Động từ / Phó từ',
    meaning_vi: 'không đủ, chưa đủ',
    examples: [
      { chinese: '他今天的准备工作显然做得还不够充分。', pinyin: 'Tā jīntiān de zhǔnbèi gōngzuò xiǎnrán zuò de hái búgòu chōngfèn.', meaning_vi: 'Công tác chuẩn bị hôm nay của anh ấy rõ ràng làm vẫn chưa đủ chu tất.', difficulty_level: 'basic' },
      { chinese: '如果仅仅掌握书本上的理论知识而缺乏一线实操经验，那是远远不够的。', pinyin: 'Rúguǒ jǐnjǐn zhǎngwò shūběn shang de lǐlùn zhīshi ér quēfá yīxiàn shícāo jīngyàn, nà shì yuǎnyuǎn búgòu de.', meaning_vi: 'Nếu chỉ nắm vững kiến thức lý thuyết trong sách vở mà thiếu kinh nghiệm thao tác thực tế tuyến đầu thì còn xa mới đủ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不过',
    pinyin: 'búguò',
    word_type: 'Liên từ',
    meaning_vi: 'nhưng, tuy nhiên; chẳng qua',
    examples: [
      { chinese: '这件衣服版型很合身，不过价格稍微有点儿贵。', pinyin: 'Zhè jiàn yīfu bǎnxíng hěn héshēn, búguò jiàgé shāowēi yǒudiǎnr guì.', meaning_vi: 'Bộ quần áo này phom dáng rất vừa vặn, có điều giá cả hơi đắt một chút.', difficulty_level: 'basic' },
      { chinese: '虽然前进的道路上充满了艰难险阻，不过大家对达成最终目标依然充满信心。', pinyin: 'Suīrán qiánjìn de dàolù shang chōngmǎn le jiānnán-xiǎnzǔ, búguò dàjiā duì dáchéng zuìzhōng mùbiāo yīrán chōngmǎn xìnxīn.', meaning_vi: 'Tuy con đường phía trước tràn ngập gian nan trắc trở, thế nhưng mọi người vẫn tràn đầy niềm tin vào việc đạt được mục tiêu sau cùng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不论',
    pinyin: 'búlùn',
    word_type: 'Liên từ',
    meaning_vi: 'bất kể, cho dù',
    examples: [
      { chinese: '不论严寒酷暑，环卫工人们每天天不亮就走上街头清扫卫生。', pinyin: 'Búlùn yánhán kùshǔ, huánwèi gōngrénmen měitiān tiān bú liàng jiù zǒu shàng jiētóu qīngsǎo wèishēng.', meaning_vi: 'Bất kể đông lạnh hay hè gắt, những công nhân vệ sinh môi trường mỗi ngày trời chưa sáng đã ra đường quét dọn.', difficulty_level: 'basic' },
      { chinese: '不论遇到多么复杂的棘手难题，他总能冷静理智地分析并找到妥善的破解方法。', pinyin: 'Búlùn yù dào duōme fùzá de jíshǒu nántí, tā zǒng néng lěngjìng lǐzhì de fēnxī bìng zhǎodào tuǒshàn de pòjiě fāngfǎ.', meaning_vi: 'Cho dù gặp bài toán hóc búa phức tạp đến đâu, anh ấy luôn có thể bình tĩnh sáng suốt phân tích và tìm ra phương án tháo gỡ ổn thỏa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '步',
    pinyin: 'bù',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'bước, bước chân, bước đi',
    examples: [
      { chinese: '千里之行，始于足下，迈出第一步是最关键的。', pinyin: 'Qiān lǐ zhī xíng, shǐ yú zú xià, mài chū dì-yī bù shì zuì guānjiàn de.', meaning_vi: 'Hành trình ngàn dặm khởi đầu từ một bước chân, bước ra bước đầu tiên là then chốt nhất.', difficulty_level: 'basic' },
      { chinese: '医生建议老年人每天饭后散步五千步，有助于强身健体促进消化。', pinyin: 'Yīshēng jiànyì lǎoniánrén měitiān fànhòu sànbù wǔqiān bù, yǒuzhùyú qiángshēn-jiàntǐ cùjìn xiāohuà.', meaning_vi: 'Bác sĩ khuyên người cao tuổi mỗi ngày sau bữa ăn đi bộ năm nghìn bước, rất có ích cho việc rèn luyện thân thể và thúc đẩy tiêu hóa.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '部',
    pinyin: 'bù',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'bộ phận; bộ (lượng từ phim ảnh, tiểu thuyết, xe cộ, máy móc)',
    examples: [
      { chinese: '他今年主演的那部科幻电影在全国各大影院反响热烈。', pinyin: 'Tā jīnnián zhǔyǎn de nà bù kēhuàn diànyǐng zài quán guó gè dà yǐngyuàn fǎnxiǎng rèliè.', meaning_vi: 'Bộ phim khoa học viễn tưởng do anh ấy đóng chính năm nay đã tạo được tiếng vang lớn tại các rạp chiếu phim trên cả nước.', difficulty_level: 'basic' },
      { chinese: '该学术著作共分上中下三部，系统梳理了汉字数千年的演变历史。', pinyin: 'Gāi xuéshù zhùzuò gòng fēn shàng zhōng xià sān bù, xìtǒng shūlǐ le Hànzì shù qiān nián de yǎnbiàn lìshǐ.', meaning_vi: 'Công trình học thuật này chia làm ba bộ thượng trung hạ, tổng kết có hệ thống lịch sử biến đổi hàng ngàn năm của chữ Hán.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不得不',
    pinyin: 'bùdébù',
    word_type: 'Phó từ',
    meaning_vi: 'buộc phải, không thể không',
    examples: [
      { chinese: '因为突发强台风，学校不得不暂时停课一天。', pinyin: 'Yīnwèi tūfā qiáng táifēng, xuéxiào bùdébù zànshí tíngkè yì tiān.', meaning_vi: 'Vì bão lớn đổ bộ bất ngờ, nhà trường buộc phải tạm thời cho nghỉ học một ngày.', difficulty_level: 'basic' },
      { chinese: '面对不可反驳的确凿事实与详实证据，对方不得不承认了自身的重大疏漏。', pinyin: 'Miànduì bù kě fǎnbó de quèzáo shìshí yǔ xiángshí zhèngjù, duìfāng bùdébù chéngrèn le zìshēn de zhòngdà shūlòu.', meaning_vi: 'Trước những sự thật chuẩn xác và bằng chứng chi tiết không thể chối cãi, đối phương buộc phải thừa nhận sai sót nghiêm trọng của chính mình.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '部分',
    pinyin: 'bùfen',
    word_type: 'Danh từ',
    meaning_vi: 'bộ phận, phần',
    examples: [
      { chinese: '今天课堂上讲的第一部分内容大家都听懂了吗？', pinyin: 'Jīntiān kètáng shang jiǎng de dì-yī bùfen nèiróng dàjiā dōu tīng dǒng le ma?', meaning_vi: 'Nội dung phần thứ nhất giảng trên lớp hôm nay mọi người đều đã hiểu hết chưa?', difficulty_level: 'basic' },
      { chinese: '阅读理解是HSK四级考试中占据分值很大的一部分核心题型。', pinyin: 'Yuèdú lǐjiě shì HSK sì jí kǎoshì zhōng zhànjù fēnzhí hěn dà de yí bùfen héxīn tíxíng.', meaning_vi: 'Đọc hiểu là một dạng bài trọng tâm chiếm tỷ trọng điểm số rất lớn trong kỳ thi HSK 4.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不管',
    pinyin: 'bùguǎn',
    word_type: 'Liên từ',
    meaning_vi: 'bất kể, dù cho',
    examples: [
      { chinese: '不管明天天气好坏，我们的公益植树活动都会照常举行。', pinyin: 'Bùguǎn míngtiān tiānqì hǎo huài, wǒmen de gōngyì zhíshù huódòng dōu huì zhàocháng jǔxíng.', meaning_vi: 'Bất kể thời tiết ngày mai đẹp hay xấu, hoạt động trồng cây công ích của chúng tôi vẫn sẽ diễn ra như thường lệ.', difficulty_level: 'basic' },
      { chinese: '不管遇到多大的挫折与委屈，回到温馨的家中总能感受到家人给予的无穷力量。', pinyin: 'Bùguǎn yù dào duō dà de cuòzhé yǔ wěiqu, huí dào wēnxīn de jiā zhōng zǒng néng gǎnshòu dào jiārén jǐyǔ de wúqióng lìliang.', meaning_vi: 'Dù gặp phải bao trắc trở hay ấm ức ngoài đời, khi trở về mái ấm gia đình luôn cảm nhận được nguồn sức mạnh vô bờ bến do người thân trao gửi.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不光',
    pinyin: 'bùguāng',
    word_type: 'Phó từ / Liên từ',
    meaning_vi: 'không chỉ, không riêng',
    examples: [
      { chinese: '这道菜不光外观色泽诱人，味道也非常可口鲜美。', pinyin: 'Zhè dào cài bùguāng wàiguān sèzé yòurén, wèidào yě fēicháng kěkǒu xiānměi.', meaning_vi: 'Món ăn này không chỉ hình thức màu sắc bắt mắt, mà hương vị cũng rất thơm ngon ngon miệng.', difficulty_level: 'basic' },
      { chinese: '学习中文不光能够开阔国际视野，更能为未来的职场竞争增添一份独特优势。', pinyin: 'Xuéxí Zhōngwén bùguāng nénggòu kāikuò guójì shìyě, gèng néng wèi wèilái de zhíchǎng jìngzhēng zēngtiān yí fèn dútè yōushì.', meaning_vi: 'Học tiếng Trung không chỉ giúp mở rộng tầm nhìn quốc tế, mà càng tạo thêm lợi thế độc đáo cho sự cạnh tranh nghề nghiệp trong tương lai.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不仅',
    pinyin: 'bùjǐn',
    word_type: 'Liên từ',
    meaning_vi: 'không những, không chỉ',
    examples: [
      { chinese: '他不仅汉语口语表达流利，而且汉字书写也十分优美规范。', pinyin: 'Tā bùjǐn Hànyǔ kǒuyǔ biǎodá liúlì, érqiě Hànzì shūxiě yě shífēn yōuměi guīfàn.', meaning_vi: 'Cậu ấy không những diễn đạt khẩu ngữ tiếng Trung lưu loát, mà chữ viết Hán tự cũng rất đẹp mắt chuẩn mực.', difficulty_level: 'basic' },
      { chinese: '多参与社会志愿服务活动，不仅能够帮助弱势群体，而且能极大丰富自己的人生阅历。', pinyin: 'Duō cānyù shèhuì zhìyuàn fúwù huódòng, bùjǐn nénggòu bāngzhù ruòshì qúntǐ, érqiě néng jídà fēngfù zìjǐ de rénshēng yuèlì.', meaning_vi: 'Tích cực tham gia các hoạt động tình nguyện xã hội không chỉ giúp đỡ được những nhóm người yếu thế mà còn làm phong phú đáng kể vốn sống đời người.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不满',
    pinyin: 'bùmǎn',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'bất mãn, không hài lòng; chưa đầy',
    examples: [
      { chinese: '顾客对商场个别服务员冷漠怠慢的态度表示强烈不满。', pinyin: 'Gùkè duì shāngchǎng gèbié fúwùyuán lěngmò dàimàn de tàidu biǎoshì qiángliè bùmǎn.', meaning_vi: 'Khách hàng bày tỏ sự bất mãn gay gắt trước thái độ thờ ơ chểnh mảng của cá biệt nhân viên phục vụ tại trung tâm thương mại.', difficulty_level: 'basic' },
      { chinese: '面对员工提出的合理意见与不满情绪，管理层应当主动倾听并积极改进。', pinyin: 'Miànduì yuángōng tíchū de hélǐ yìjiàn yǔ bùmǎn qíngxù, guǎnlǐcéng yīngdāng zhǔdòng qīngtīng bìng jījí gǎijìn.', meaning_vi: 'Trước những ý kiến hợp lý và cảm xúc bất mãn của nhân viên, ban quản lý nên chủ động lắng nghe và tích cực cải thiện.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '部门',
    pinyin: 'bùmén',
    word_type: 'Danh từ',
    meaning_vi: 'phòng ban, bộ phận',
    examples: [
      { chinese: '他是我们公司市场营销部门的核心骨干成员。', pinyin: 'Tā shì wǒmen gōngsī shìchǎng yíngxiāo bùmén de héxīn gǔgàn chéngyuán.', meaning_vi: 'Anh ấy là thành viên nòng cốt hạt nhân của bộ phận tiếp thị thị trường công ty chúng tôi.', difficulty_level: 'basic' },
      { chinese: '大型跨国企业内部各业务部门之间的高效协同与顺畅沟通至关重要。', pinyin: 'Dàxíng kuàguó qǐyè nèibù gè yèwù bùmén zhījiān de gāoxiào xiétóng yǔ shùnchàng gōutōng zhìguān zhòngyào.', meaning_vi: 'Sự phối hợp hiệu quả và thông suốt giữa các phòng ban nghiệp vụ bên trong doanh nghiệp đa quốc gia lớn có ý nghĩa vô cùng sống còn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '不如',
    pinyin: 'bùrú',
    word_type: 'Động từ',
    meaning_vi: 'không bằng; chi bằng',
    examples: [
      { chinese: '与其在家里无聊看手机，不如约上朋友去户外打球运动。', pinyin: 'Yǐqí zài jiālǐ wúliáo kàn shǒujī, bùrú yuē shàng péngyou qù hùwài dǎqiú yùndòng.', meaning_vi: 'Thay vì ở nhà lướt điện thoại chán ngắt, chi bằng rủ bạn bè ra ngoài trời chơi bóng vận động.', difficulty_level: 'basic' },
      { chinese: '俗话说“百闻不如一见”，只有亲自到实地考察调研，才能掌握最真实的一手数据。', pinyin: 'Súhuà shuō “bǎi wén bùrú yí jiàn”, zhǐyào qīnzì dào shídì kǎochá diàoyán, cái néng zhǎngwò zuì zhēnshí de yìshǒu shùjù.', meaning_vi: 'Tục ngữ có câu "Trăm nghe không bằng một thấy", chỉ khi đích thân đến tận nơi khảo sát nghiên cứu mới nắm bắt được số liệu thực tế sơ cấp chính xác nhất.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '擦',
    pinyin: 'cā',
    word_type: 'Động từ',
    meaning_vi: 'lau, chùi, cọ sát',
    examples: [
      { chinese: '下课后，值日生认真地把黑板上的粉笔字擦得干干净净。', pinyin: 'Xiàkè hòu, zhírìshēng rènzhēn de bǎ hēibǎn shang de fěnbǐ zì cā de gāngānjìngjìng.', meaning_vi: 'Sau giờ học, học sinh trực nhật cẩn thận lau sạch bóng những nét phấn trên bảng đen.', difficulty_level: 'basic' },
      { chinese: '运动出汗后记得及时用毛巾擦干汗水，以免吹风受凉引起感冒。', pinyin: 'Yùndòng chūhàn hòu jìde jíshí yòng máojīn cā gān hànshuǐ, yǐmiǎn chuīfēng shòuliáng yǐnqǐ gǎnmào.', meaning_vi: 'Sau khi vận động toát mồ hôi nhớ dùng khăn lau khô mồ hôi kịp thời, kẻo bị trúng gió nhiễm lạnh dẫn đến cảm cúm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '猜',
    pinyin: 'cāi',
    word_type: 'Động từ',
    meaning_vi: 'đoán',
    examples: [
      { chinese: '你猜猜看我身后藏着的神秘礼物到底是什么？', pinyin: 'Nǐ cāicai kàn wǒ shēnhòu cáng zhe de shénmì lǐwù dàodǐ shì shénme?', meaning_vi: 'Bạn đoán thử xem món quà bí mật giấu sau lưng tôi rốt cuộc là cái gì nào?', difficulty_level: 'basic' },
      { chinese: '没有确凿的事实证据之前，请不要随意胡乱猜测他人的动机。', pinyin: 'Méiyǒu quèzáo de shìshí zhèngjù zhīqián, qǐng bú yào suíyì húluàn cāicè tārén de dòngjī.', meaning_vi: 'Trước khi chưa có chứng cứ thực tế xác thực, xin đừng tự tiện đoán mò bừa bãi động cơ của người khác.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '材料',
    pinyin: 'cáiliào',
    word_type: 'Danh từ',
    meaning_vi: 'tài liệu; vật liệu, nguyên liệu',
    examples: [
      { chinese: '办理签证前必须将所有申请材料准备齐全。', pinyin: 'Bànlǐ qiānzhèng qián bìxū jiāng suǒyǒu shēnqǐng cáiliào zhǔnbèi qíquán.', meaning_vi: 'Trước khi xin visa nhất thiết phải chuẩn bị đầy đủ toàn bộ hồ sơ tài liệu xin cấp.', difficulty_level: 'basic' },
      { chinese: '这座新建的现代图书馆主体建筑广泛使用了绿色环保的新型建筑材料。', pinyin: 'Zhè zuò xīnjiàn de xiàndài túshūguǎn zhǔtǐ jiànzhù guǎngfàn shǐyòng le lǜsè huánbǎo de xīnxíng jiànzhù cáiliào.', meaning_vi: 'Công trình kiến trúc chính của thư viện hiện đại mới xây này sử dụng rộng rãi các loại vật liệu xây dựng mẫu mới thân thiện môi trường.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '参观',
    pinyin: 'cānguān',
    word_type: 'Động từ',
    meaning_vi: 'tham quan',
    examples: [
      { chinese: '周末老师带领留学生们去故宫博物院参观展览。', pinyin: 'Zhōumò lǎoshī dàilǐng liúxuéshēngmen qù Gùgōng Bówùyuàn cānguān zhǎnlǎn.', meaning_vi: 'Cuối tuần thầy giáo dẫn các bạn du học sinh đi Bảo tàng Cố Cung tham quan triển lãm.', difficulty_level: 'basic' },
      { chinese: '代表团一行先后深入参观了科技园区内的多家知名高新技术企业。', pinyin: 'Dàibiǎotuán yì xíng xiānhòu shēnrù cānguān le kējì yuánqū nèi de duō jiā zhīmíng gāoxīn-jìshù qǐyè.', meaning_vi: 'Đoàn đại biểu đã lần lượt đi sâu tham quan nhiều doanh nghiệp công nghệ cao tên tuổi bên trong khu công viên công nghệ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '参赛',
    pinyin: 'cānsài',
    word_type: 'Động từ',
    meaning_vi: 'tham gia thi đấu',
    examples: [
      { chinese: '来自全国三十所高校的优秀辩手参加了此次辩论赛。', pinyin: 'Láizì quán guó sānshí suǒ gāoxiào de yōuxiù biànshǒu cānjiā le cǐ cì biànlùnsài.', meaning_vi: 'Các tranh biện viên ưu tú đến từ ba mươi trường đại học trên cả nước đã tham gia thi đấu tại giải tranh biện lần này.', difficulty_level: 'basic' },
      { chinese: '组委会在赛前为所有参赛选手详细解读了比赛的具体规则与安全注意事项。', pinyin: 'Zǔwěihuì zài sài qián wèi suǒyǒu cānsài xuǎnshǒu xiángxì jiědú le bǐsài de jùtǐ guīzé yǔ ānquán zhùyì shìxiàng.', meaning_vi: 'Ban tổ chức trước trận đấu đã giải thích cặn kẽ cho toàn thể tuyển thủ dự thi về luật thi đấu cụ thể và các điều cần lưu ý an toàn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '餐厅',
    pinyin: 'cāntīng',
    word_type: 'Danh từ',
    meaning_vi: 'nhà hàng, phòng ăn',
    examples: [
      { chinese: '这家中餐厅做出的北京烤鸭味道极为地道正宗。', pinyin: 'Zhè jiā Zhōngcāntīng zuò chū de Běijīng kǎoyā wèidào jíwéi dìdao zhèngzōng.', meaning_vi: 'Món vịt quay Bắc Kinh do nhà hàng Trung Hoa này làm ra mang hương vị cực kỳ chuẩn vị chính tông.', difficulty_level: 'basic' },
      { chinese: '每逢节假日的就餐高峰期，市中心几家知名特色餐厅门口总是排着长长的等位队伍。', pinyin: 'Měiféng jiéjiàrì de jiùcān gāofēngqī, shìzhōngxīn jǐ jiā zhīmíng tèsè cāntīng ménkǒu zǒngshì pái zhe chángcháng de děngwèi duìwǔ.', meaning_vi: 'Mỗi dịp giờ ăn cao điểm ngày lễ tết, trước cửa vài nhà hàng đặc sản danh tiếng ở trung tâm thành phố lúc nào cũng xếp hàng dài đợi bàn.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '操场',
    pinyin: 'cāochǎng',
    word_type: 'Danh từ',
    meaning_vi: 'sân tập thể thao, sân trường',
    examples: [
      { chinese: '每天下午放学后，很多同学都在操场上跑步踢球。', pinyin: 'Měitiān xiàwǔ fàngxué hòu, hěnduō tóngxué dōu zài cāochǎng shang pǎobù tīqiú.', meaning_vi: 'Mỗi buổi chiều sau khi tan học, rất nhiều bạn học đều ở trên sân thể thao chạy bộ đá bóng.', difficulty_level: 'basic' },
      { chinese: '学校新建的塑胶操场不仅平整舒适，而且大大降低了学生运动时摔倒受伤的风险。', pinyin: 'Xuéxiào xīnjiàn de sùjiāo cāochǎng bùjǐn píngzhěng shūshì, érqiě dàdà jiàngdī le xuésheng yùndòng shí shuāidǎo shòushāng de fēngxiǎn.', meaning_vi: 'Sân tập phủ nhựa tổng hợp mới xây của trường không chỉ bằng phẳng êm chân mà còn giảm thiểu đáng kể nguy cơ học sinh ngã bị thương khi vận động.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '厕所',
    pinyin: 'cèsuǒ',
    word_type: 'Danh từ',
    meaning_vi: 'nhà vệ sinh, toilet',
    examples: [
      { chinese: '请问商场二层的公共厕所在哪个方向？', pinyin: 'Qǐngwèn shāngchǎng èr céng de gōnggòng cèsuǒ zài nǎ gè fāngxiàng?', meaning_vi: 'Xin hỏi nhà vệ sinh công cộng ở tầng hai trung tâm thương mại nằm ở hướng nào vậy?', difficulty_level: 'basic' },
      { chinese: '高铁列车上的无障碍卫生间设施齐全，充分考虑了残障人士的使用需求。', pinyin: 'Gāotiě lièchē shang de wúzhàng’ài wèishēngjiān shèshī qíquán, chōngfèn kǎolǜ le cánzhàng rénshì de shǐyòng xūqiú.', meaning_vi: 'Nhà vệ sinh không rào cản trên tàu cao tốc tiện nghi đầy đủ, tính đến trọn vẹn nhu cầu sử dụng của người khuyết tật.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '查看',
    pinyin: 'chákàn',
    word_type: 'Động từ',
    meaning_vi: 'xem xét, kiểm tra',
    examples: [
      { chinese: '医生正在仔细查看患者拍下的胸部X光片。', pinyin: 'Yīshēng zhèngzài zǐxì chákàn huànzhě pāi xià de xiōngbù X guāng piàn.', meaning_vi: 'Bác sĩ đang chăm chú xem xét tấm phim chụp X-quang lồng ngực của người bệnh.', difficulty_level: 'basic' },
      { chinese: '你可以随时登录手机银行应用程序，实时查看账户的每一笔收支明细。', pinyin: 'Nǐ kěyǐ suíshí dēnglù shǒujī yínháng yìngyòng chéngxù, shíshí chákàn zhànghù de měi yì bǐ shōuzhī míngxì.', meaning_vi: 'Bạn có thể đăng nhập ứng dụng ngân hàng di động mọi lúc để tra cứu thời gian thực từng giao dịch thu chi của tài khoản.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '茶叶',
    pinyin: 'cháyè',
    word_type: 'Danh từ',
    meaning_vi: 'lá trà, búp chè',
    examples: [
      { chinese: '西湖龙井是中国最具代表性的名贵绿茶茶叶之一。', pinyin: 'Xīhú lóngjǐng shì Zhōngguó zuì jù dàibiǎoxìng de míngguì lǜchá cháyè zhī yī.', meaning_vi: 'Long Tỉnh Tây Hồ là một trong những loại lá trà xanh quý giá mang tính đại diện nhất của Trung Quốc.', difficulty_level: 'basic' },
      { chinese: '上好的茶叶不仅冲泡出来的汤色清澈碧绿，而且入口回甘，令人回味悠长。', pinyin: 'Shànghǎo de cháyè bùjǐn chōngpào chūlái de tāngsè qīngchè bìlǜ, érqiě rùkǒu huígān, lìng rén huíwèi yōucháng.', meaning_vi: 'Lá trà thượng hạng không chỉ pha ra nước trà trong vắt xanh biếc mà khi nhấp vào miệng còn ngọt hậu, khiến người ta dư ba lắng đọng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '查找',
    pinyin: 'cházhǎo',
    word_type: 'Động từ',
    meaning_vi: 'tìm kiếm, tra cứu',
    examples: [
      { chinese: '在写毕业论文时，他花了两周时间在图书馆查找参考资料。', pinyin: 'Zài xiě bìyè lùnwén shí, tā huā le liǎng zhōu shíjiān zài túshūguǎn cházhǎo cānkǎo zīliào.', meaning_vi: 'Khi viết luận văn tốt nghiệp, cậu ấy đã dành hai tuần ở thư viện tra cứu tài liệu tham khảo.', difficulty_level: 'basic' },
      { chinese: '利用现代数字数据库的关键词检索功能，研究人员能够极其高效地查找相关学术文献。', pinyin: 'Lìyòng xiàndài shùzì shùjùkù de guānjiàncí jiǎnsuǒ gōngnéng, yánjiū rényuán nénggòu jíqí gāoxiào de cházhǎo xiāngguān xuéshù wénxiàn.', meaning_vi: 'Nhờ tính năng tra cứu từ khóa của các cơ sở dữ liệu số hiện đại, các nhà nghiên cứu có thể tìm kiếm tài liệu học thuật liên quan cực kỳ hiệu quả.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '差点儿',
    pinyin: 'chàdiǎnr',
    word_type: 'Phó từ',
    meaning_vi: 'suýt nữa, suýt chút nữa',
    examples: [
      { chinese: '今天早晨路上太堵了，我差点儿就赶不上这班高铁。', pinyin: 'Jīntiān zǎochén lù shang tài dǔ le, wǒ chàdiǎnr jiù gǎn bu shàng zhè bān gāotiě.', meaning_vi: 'Sáng nay đường tắc quá, tôi suýt chút nữa thì không kịp bắt chuyến tàu cao tốc này.', difficulty_level: 'basic' },
      { chinese: '地面结了厚厚一层暗冰，走在前面的行人脚下一滑，差点儿摔倒在台阶上。', pinyin: 'Dìmiàn jié le hòuhòu yì céng ànbīng, zǒu zài qiánmiàn de xíngrén jiǎoxià yì huá, chàdiǎnr shuāidǎo zài táijiē shang.', meaning_vi: 'Mặt đất đóng một lớp băng mỏng trơn trượt, người đi bộ phía trước trượt chân một cái, suýt nữa ngã nhào trên bậc thang.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '产生',
    pinyin: 'chǎnshēng',
    word_type: 'Động từ',
    meaning_vi: 'sinh ra, nảy sinh, xuất hiện',
    examples: [
      { chinese: '经过长期的文化交流，两国青年之间产生了深厚的友谊。', pinyin: 'Jīngguò chángqī de wénhuà jiāoliú, liǎng guó qīngnián zhījiān chǎnshēng le shēnhòu de yǒuyì.', meaning_vi: 'Trải qua giao lưu văn hóa lâu dài, giữa thanh niên hai nước đã nảy sinh tình bạn sâu sắc.', difficulty_level: 'basic' },
      { chinese: '不合理的城市发展模式会对周边的水资源和生态系统产生不可逆转的负面影响。', pinyin: 'Bù hélǐ de chéngshì fāzhǎn móshì huì duì zhōubiān de shuǐzīyuán hé shēngtài xìtǒng chǎnshēng bù kě nìzhuǎn de fùmiàn yǐngxiǎng.', meaning_vi: 'Mô hình phát triển đô thị bất hợp lý sẽ gây ra những tác động tiêu cực không thể đảo ngược đối với nguồn nước và hệ sinh thái xung quanh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '厂',
    pinyin: 'chǎng',
    word_type: 'Danh từ',
    meaning_vi: 'nhà máy, xưởng',
    examples: [
      { chinese: '他的父亲在一家大型钢铁厂工作了三十多年。', pinyin: 'Tā de fùqīn zài yì jiā dàxíng gāngtiěchǎng gōngzuò le sānshí duō nián.', meaning_vi: 'Bố của anh ấy đã làm việc tại một nhà máy gang thép lớn suốt hơn ba mươi năm.', difficulty_level: 'basic' },
      { chinese: '该电子配件制造厂全面引进智能机器人，使车间的自动化生产水平迈上了新台阶。', pinyin: 'Gāi diànzǐ pèijiàn zhìzàochǎng quánmiàn yǐnjìn zhìnéng jīqìrén, shǐ chējiān de zìdònghuà shēngchǎn shuǐpíng mài shàng le xīn táijiē.', meaning_vi: 'Nhà máy chế tạo linh kiện điện tử này đã đưa vào sử dụng toàn diện robot thông minh, đưa trình độ tự động hóa phân xưởng lên tầm cao mới.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '场',
    pinyin: 'chǎng',
    word_type: 'Lượng từ / Danh từ',
    meaning_vi: 'trận, buổi (lượng từ trận đấu, cơn mưa, vở kịch); sân bãi',
    examples: [
      { chinese: '昨天下午的那场足球比赛竞争异常激烈。', pinyin: 'Zuótiān xiàwǔ de nà chǎng zúqiú bǐsài jìngzhēng yìcháng jīliè.', meaning_vi: 'Trận bóng đá chiều hôm qua cạnh tranh kịch tính vô cùng.', difficulty_level: 'basic' },
      { chinese: '久旱逢甘霖，昨夜下了一场及时的大透雨，彻底缓解了当地严重的旱情。', pinyin: 'Jiǔhàn-fénggānlín, zuóyè xià le yì chǎng jíshí de dà tòuyǔ, chèdǐ huǎnjiě le dāngdì yánzhòng de hànqíng.', meaning_vi: 'Hạn hán lâu ngày gặp mưa rào, đêm qua trút xuống một trận mưa to kịp thời đã giải tỏa triệt để tình trạng hạn hán nghiêm trọng nơi đây.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '超过',
    pinyin: 'chāoguò',
    word_type: 'Động từ',
    meaning_vi: 'vượt qua, vượt quá',
    examples: [
      { chinese: '今天市区的最高气温已经超过了三十八摄氏度。', pinyin: 'Jīntiān shìqū de zuìgāo qìwēn yǐjīng chāoguò le sānshíbā shèshìdù.', meaning_vi: 'Nhiệt độ cao nhất trong nội thành hôm nay đã vượt quá ba mươi tám độ C.', difficulty_level: 'basic' },
      { chinese: '经过不懈奋斗，该高新技术企业的年销售额首次突破并超过了百亿元大关。', pinyin: 'Jīngguò búxiè fèndòu, gāi gāoxīn-jìshù qǐyè de nián xiāoshòu’é shǒucì tūpò bìng chāoguò le bǎi yì yuán dàguān.', meaning_vi: 'Nhờ nỗ lực không ngừng nghỉ, doanh số năm của doanh nghiệp công nghệ cao này lần đầu tiên bứt phá và vượt qua mốc chục tỷ nhân dân tệ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '车速',
    pinyin: 'chēsù',
    word_type: 'Danh từ',
    meaning_vi: 'tốc độ xe',
    examples: [
      { chinese: '雨天路滑，司机应当主动降低车速，保持安全车距。', pinyin: 'Yǔtiān lù huá, sījī yīngdāng zhǔdòng jiàngdī chēsù, bǎochí ānquán chējù.', meaning_vi: 'Trời mưa đường trơn, tài xế nên chủ động giảm tốc độ xe và giữ khoảng cách an toàn.', difficulty_level: 'basic' },
      { chinese: '高速公路上安装了精密测速摄像头，严厉查处任何超过规定车速的危险驾驶行为。', pinyin: 'Gāosù gōnglù shang ānzhuāng le jīngmì cèsù shèxiàngtóu, yánlì cháchǔ rènhé chāoguò guīdìng chēsù de wēixiǎn jiàshǐ xíngwéi.', meaning_vi: 'Trên đường cao tốc lắp đặt camera đo tốc độ tinh vi, xử lý nghiêm minh mọi hành vi lái xe nguy hiểm vượt quá tốc độ quy định.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '车位',
    pinyin: 'chēwèi',
    word_type: 'Danh từ',
    meaning_vi: 'chỗ đỗ xe, vị trí đỗ xe',
    examples: [
      { chinese: '地下停车场里还有不少空余的车位可以停靠。', pinyin: 'Dìxià tíngchēchǎng lǐ hái yǒu bùshǎo kōngyú de chēwèi kěyǐ tíngkào.', meaning_vi: 'Trong bãi đỗ xe dưới tầng hầm vẫn còn khá nhiều vị trí trống có thể đỗ xe.', difficulty_level: 'basic' },
      { chinese: '随着私家车保有量的激增，老旧小区的车位短缺问题成为了社区治理的一大难题。', pinyin: 'Suízhe sījiāchē bǎoyǒuliàng de jīzēng, lǎojiù xiǎoqū de chēwèi duǎnquē wèntí chéngwéi le shèqū zhìlǐ de yí dà nántí.', meaning_vi: 'Cùng với sự gia tăng đột biến của lượng xe hơi cá nhân, bài toán thiếu chỗ đỗ xe tại các khu chung cư cũ đã trở thành vấn đề nan giải trong quản trị khu dân cư.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '城',
    pinyin: 'chéng',
    word_type: 'Danh từ',
    meaning_vi: 'thành phố, đô thị, tường thành',
    examples: [
      { chinese: '西安是一座拥有数千年悠久历史的古城。', pinyin: 'Xī’ān shì yí zuò yōngyǒu shù qiān nián yōujiǔ lìshǐ de gǔchéng.', meaning_vi: 'Tây An là một cổ thành sở hữu lịch sử lâu đời hàng ngàn năm.', difficulty_level: 'basic' },
      { chinese: '昔日偏僻落后的小渔村如今已经蜕变成了一座充满活力与现代气息的海滨新城。', pinyin: 'Xīrì piānpì luòhòu de xiǎoyúcūn rújīn yǐjīng tuìbiàn chéng le yí zuò chōngmǎn huólì yǔ xiàndài qìxī de hǎibīn xīnhchéng.', meaning_vi: 'Làng chài nhỏ hẻo lánh lạc hậu thuở nào nay đã lột xác thành một đô thị biển mới mẻ ngập tràn sức sống và hơi thở hiện đại.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '乘',
    pinyin: 'chéng',
    word_type: 'Động từ',
    meaning_vi: 'đi, đón (phương tiện); nhân (toán học); nhân cơ hội',
    examples: [
      { chinese: '他每天早晨乘地铁去金融街上班。', pinyin: 'Tā měitiān zǎochén chéng dìtiě qù Jīnróngjiē shàngbān.', meaning_vi: 'Mỗi sáng anh ấy đều đi tàu điện ngầm đến Phố Tài Chính làm việc.', difficulty_level: 'basic' },
      { chinese: '我们要乘着国家大力支持科技创新的东风，乘势而上加快自主研发步伐。', pinyin: 'Wǒmen yào chéng zhe guójiā dàlì zhīchí kējì chuàngxīn de dōngfēng, chéngshì-érshàng jiākuài zìzhǔ yánfā bùfá.', meaning_vi: 'Chúng ta phải nhân ngọn gió đông nhà nước dốc sức ủng hộ đổi mới công nghệ, thuận đà vươn lên đẩy nhanh bước tiến tự chủ nghiên cứu phát triển.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '成功',
    pinyin: 'chénggōng',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'thành công',
    examples: [
      { chinese: '经过无数次实验与摸索，科学家们终于取得了成功。', pinyin: 'Jīngguò wúshù cì shíyàn yǔ mōsuǒ, kēxuéjiāmen zhōngyú qǔdé le chénggōng.', meaning_vi: 'Trải qua vô số lần thí nghiệm và tìm tòi, các nhà khoa học cuối cùng đã giành được thành công.', difficulty_level: 'basic' },
      { chinese: '每一次成功的背后都凝聚着无数个日夜默默挥洒的汗水与持之以恒的坚持。', pinyin: 'Měi yí cì chénggōng de bèihòu dōu níngjù zhe wúshù gè rì-yè mòmò huīsǎ de hànshuǐ yǔ chízhīyǐhéng de jiānchí.', meaning_vi: 'Đằng sau mỗi lần thành công đều ngưng kết bao mồ hôi âm thầm tuôn rơi ngày đêm và sự kiên trì bền bỉ không dứt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '乘客',
    pinyin: 'chéngkè',
    word_type: 'Danh từ',
    meaning_vi: 'hành khách',
    examples: [
      { chinese: '请各位乘客在上车后主动往车厢中段走。', pinyin: 'Qǐng gèwèi chéngkè zài shàngchē hòu zhǔdòng wǎng chēxiāng zhōngduàn zǒu.', meaning_vi: 'Xin quý hành khách sau khi lên xe hãy chủ động tiến về phía giữa toa xe.', difficulty_level: 'basic' },
      { chinese: '列车长带领乘务组热心细致地为每一位有特殊困难的旅客提供周到的爱心服务。', pinyin: 'Lièchēzhǎng dàilǐng chéngwùzǔ rèxīn xìzhì de wèi měi yí wèi yǒu tèshū kùnnan de lǚkè tígōng zhōudào de àixīn fúwù.', meaning_vi: 'Trưởng tàu dẫn dắt đội tiếp viên nhiệt tình tỉ mỉ cung cấp dịch vụ yêu thương chu đáo cho mỗi hành khách gặp khó khăn đặc biệt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '诚实',
    pinyin: 'chéngshí',
    word_type: 'Tính từ',
    meaning_vi: 'thành thật, trung thực',
    examples: [
      { chinese: '诚实守信是做人立足于社会最宝贵的美德。', pinyin: 'Chéngshí shǒuxìn shì zuòrén lìzú yú shèhuì zuì bǎoguì de měidé.', meaning_vi: 'Trung thực giữ chữ tín là đức tính quý báu nhất để làm người đứng vững trong xã hội.', difficulty_level: 'basic' },
      { chinese: '面对自己无意犯下的过失，勇敢坦承错误远比编造谎言更能赢得他人的尊重与谅解。', pinyin: 'Miànduì zìjǐ wúyì fànxià de guòshī, yǒnggǎn tǎnchéng cuòwù yuǎn bǐ biānzào huǎngyán gèng néng yíngdé tārén de zūnzhòng yǔ liàngjiě.', meaning_vi: 'Đứng trước sai sót vô tình phạm phải, dũng cảm nhận lỗi tốt hơn nhiều so với việc thêu dệt lời nói dối để nhận lại sự tôn trọng và thứ tha của người khác.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '成为',
    pinyin: 'chéngwéi',
    word_type: 'Động từ',
    meaning_vi: 'trở thành, trở nên',
    examples: [
      { chinese: '他的童年梦想是长大后成为一名杰出的宇航员。', pinyin: 'Tā de tóngnián mèngxiǎng shì zhǎngdà hòu chéngwéi yì míng jiéchū de yǔhángyuán.', meaning_vi: 'Ước mơ tuổi thơ của cậu ấy là lớn lên trở thành một phi hành gia kiệt xuất.', difficulty_level: 'basic' },
      { chinese: '经过十几年的快速发展，这座沿海港口城市已经成为了具有全球影响力的国际航运中心。', pinyin: 'Jīngguò shí jǐ nián de kuàisù fāzhǎn, zhè zuò yánhǎi gǎngkǒu chéngshì yǐjīng chéngwéi le jùyǒu quánqiú yǐngxiǎnglì de guójì hángyùn zhōngxīn.', meaning_vi: 'Trải qua mười mấy năm phát triển nhanh chóng, thành phố cảng ven biển này đã trở thành một trung tâm vận tải biển quốc tế mang tầm ảnh hưởng toàn cầu.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '乘坐',
    pinyin: 'chéngzuò',
    word_type: 'Động từ',
    meaning_vi: 'đi, ngồi (tàu xe, máy bay)',
    examples: [
      { chinese: '乘坐高铁从北京到上海只需要四个多小时。', pinyin: 'Chéngzuò gāotiě cóng Běijīng dào Shànghǎi zhǐ xūyào sì gè duō xiǎoshí.', meaning_vi: 'Đi tàu cao tốc từ Bắc Kinh đến Thượng Hải chỉ mất hơn bốn tiếng đồng hồ.', difficulty_level: 'basic' },
      { chinese: '在乘坐观光游轮夜游黄浦江时，两岸绚丽璀璨的摩天大楼夜景令人流连忘返。', pinyin: 'Zài chéngzuò guānguāng yóulún yèyóu Huángpǔ Jiāng shí, liǎng’àn xuànlì cuǐcàn de mótiān-dàlóu yèjǐng lìng rén liúlián-wàngfǎn.', meaning_vi: 'Khi đi du thuyền ngắm cảnh đêm trên sông Hoàng Phố, cảnh đêm rực rỡ lộng lẫy của các tòa nhà chọc trời hai bên bờ khiến lòng người xao xuyến không muốn rời.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '吃惊',
    pinyin: 'chījīng',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'kinh ngạc, giật mình, sửng sốt',
    examples: [
      { chinese: '听到这个令人意外的比赛结果，大家都感到十分吃惊。', pinyin: 'Tīng dào zhè gè lìng rén yìwài de bǐsài jiéguǒ, dàjiā dōu gǎndào shífēn chījīng.', meaning_vi: 'Nghe kết quả thi đấu bất ngờ này, mọi người đều cảm thấy hết sức ngạc nhiên.', difficulty_level: 'basic' },
      { chinese: '他在这短短半年内取得的巨大中文学习进步，确实让所有授课老师大为吃惊。', pinyin: 'Tā zài zhè duǎnduǎn bàn nián nèi qǔdé de jùdà Zhōngwén xuéxí jìnbù, quèshí ràng suǒyǒu shòukè lǎoshī dàwéi chījīng.', meaning_vi: 'Tiến bộ vượt bậc trong việc học tiếng Trung mà cậu ấy đạt được chỉ trong nửa năm ngắn ngủi thực sự làm tất cả thầy cô giảng dạy phải vô cùng kinh ngạc.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '迟',
    pinyin: 'chí',
    word_type: 'Tính từ',
    meaning_vi: 'chậm, muộn, trễ',
    examples: [
      { chinese: '现在开始努力学习任何知识都不算迟。', pinyin: 'Xiànzài kāishǐ nǔlì xuéxí rènhé zhīshi dōu bú suàn chí.', meaning_vi: 'Bây giờ bắt đầu chăm chỉ học bất kỳ kiến thức nào cũng chưa coi là muộn.', difficulty_level: 'basic' },
      { chinese: '因为突降大暴雨导致航班起飞延误，我们到达目的地酒店时已经是深夜迟暮了。', pinyin: 'Yīnwèi tū jiàng dàbàoyǔ dǎozhì hángbān qǐfēi yánwù, wǒmen dàodá mùdìdì jiǔdiàn shí yǐjīng shì shēnyè chímù le.', meaning_vi: 'Do mưa to bất ngờ trút xuống làm chuyến bay hoãn cất cánh, khi chúng tôi tới khách sạn đích thì trời đã vào đêm khuya muộn màng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '重',
    pinyin: 'chóng',
    word_type: 'Phó từ',
    meaning_vi: 'lại, một lần nữa; trùng điệp',
    examples: [
      { chinese: '电脑系统崩溃了，我们需要重新启动机器。', pinyin: 'Diànnǎo xìtǒng bēngkuì le, wǒmen xūyào chóngxīn qǐdòng jīqì.', meaning_vi: 'Hệ thống máy tính bị sập rồi, chúng ta cần phải khởi động lại máy.', difficulty_level: 'basic' },
      { chinese: '虽然历经重重艰难挫折，但这支坚强的科研团队依然重整旗鼓迎难而上。', pinyin: 'Suīrán lìjīng chóngchóng jiānnán cuòzhé, dàn zhè zhī jiānqiáng de kēyán tuánduì yīrán chóngzhěng-qígǔ yíngnán’érshàng.', meaning_vi: 'Tuy trải qua muôn trùng gian nan trắc trở, đội ngũ nghiên cứu khoa học kiên cường này vẫn củng cố lực lượng xốc lại tinh thần đương đầu vượt khó.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '重新',
    pinyin: 'chóngxīn',
    word_type: 'Phó từ',
    meaning_vi: 'làm lại từ đầu, làm lại',
    examples: [
      { chinese: '老师建议他把这篇结构松散的文章重新修改一遍。', pinyin: 'Lǎoshī jiànyì tā bǎ zhè piān jiégòu sōngsǎn de wénzhāng chóngxīn xiūgǎi yí biàn.', meaning_vi: 'Thầy giáo khuyên cậu ấy nên chỉnh sửa lại một lượt bài văn có kết cấu lỏng lẻo này.', difficulty_level: 'basic' },
      { chinese: '跌倒了并不可怕，拍拍身上的尘土，调整好心态重新出发才是真正的强者。', pinyin: 'Diēdǎo le bìng bù kěpà, pāipai shēn shang de chéntǔ, tiáozhěng hǎo xīntài chóngxīn chūfā cái shì zhēnzhèng de qiángzhě.', meaning_vi: 'Vấp ngã không hề đáng sợ, phủi sạch bụi cát trên người, ổn định lại tâm thái để bắt đầu lại từ đầu mới thực sự là kẻ mạnh.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出差',
    pinyin: 'chūchāi',
    word_type: 'Động từ',
    meaning_vi: 'đi công tác',
    examples: [
      { chinese: '李经理下周一要前往广州分公司出差三天。', pinyin: 'Lǐ jīnglǐ xià zhōuyī yào qiánwǎng Guǎngzhōu fēngōngsī chūchāi sān tiān.', meaning_vi: 'Thứ Hai tuần tới Giám đốc Lý phải đi chi nhánh Quảng Châu công tác ba ngày.', difficulty_level: 'basic' },
      { chinese: '外贸部门的业务员们一年到头频繁出差，足迹遍布各大海外新兴市场。', pinyin: 'Wàimào bùmén de yèwùyuánmen yì nián dào tóu pínfán chūchāi, zújì biànbù gè dà hǎiwài xīnxīng shìchǎng.', meaning_vi: 'Các nhân viên kinh doanh của bộ phận ngoại thương quanh năm đi công tác triền miên, dấu chân in khắp các thị trường mới nổi ở nước ngoài.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出口',
    pinyin: 'chūkǒu',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'cửa ra; xuất khẩu',
    examples: [
      { chinese: '沿着这条走廊直走到头就是地铁站的A出口。', pinyin: 'Yánzhe zhè tiáo zǒuláng zhí zǒu dào tóu jiù shì dìtiězhàn de A chūkǒu.', meaning_vi: 'Đi thẳng hết lối hành lang này chính là cửa ra A của ga tàu điện ngầm.', difficulty_level: 'basic' },
      { chinese: '近年来我国高科技电子产品和绿色新能源汽车的海外出口总额持续攀升。', pinyin: 'Jìnniánlái wǒguó gāokējì diànzǐ chǎnpǐn hé lǜsè xīnnéngyuán qìchē de hǎiwài chūkǒu zǒng’é chíxù pānshēng.', meaning_vi: 'Những năm gần đây tổng kim ngạch xuất khẩu ra nước ngoài của các sản phẩm điện tử công nghệ cao và xe năng lượng mới xanh của nước ta liên tục tăng vọt.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出现',
    pinyin: 'chūxiàn',
    word_type: 'Động từ',
    meaning_vi: 'xuất hiện, nảy sinh',
    examples: [
      { chinese: '雨过天晴，天空中出现了一道美丽的七色彩虹。', pinyin: 'Yǔguò-tiānqíng, tiānkōng zhōng chūxiàn le yí dào měilì de qīsè cǎihóng.', meaning_vi: 'Mưa tạnh trời quang, giữa bầu trời xuất hiện một dải cầu vồng bảy sắc lung linh.', difficulty_level: 'basic' },
      { chinese: '当项目开发过程中出现不可预见的技术故障时，工程师们总能在第一时间排查解决。', pinyin: 'Dāng xiàngmù kāifā guòchéng zhōng chūxiàn bù kě yùjiàn de jìshù gùzhàng shí, gōngchéngshīmen zǒng néng zài dì-yī shíjiān páichá jiějué.', meaning_vi: 'Khi trong quá trình phát triển dự án phát sinh sự cố kỹ thuật khó lường trước, các kỹ sư luôn có thể điều tra khắc phục ngay lập tức.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出行',
    pinyin: 'chūxíng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'đi lại, xuất hành',
    examples: [
      { chinese: '国庆长假期间各大交通枢纽迎来了市民出行的客流高峰。', pinyin: 'Guóqìng chángjià qījiān gè dà jiāotōng shūniǔ yínglái le shìmín chūxíng de kèliú gāofēng.', meaning_vi: 'Trong kỳ nghỉ lễ Quốc khánh dài ngày, các đầu mối giao thông lớn đón đợt cao điểm hành khách đi lại của người dân.', difficulty_level: 'basic' },
      { chinese: '完善的城市无障碍通道建设为老年人和行动不便人士的自主安全出行提供了有力保障。', pinyin: 'Wánshàn de chéngshì wúzhàng’ài tōngdào jiànshè wèi lǎoniánrén hé xíngdòng búbiàn rénshì de zìzhǔ ānquán chūxíng tígōng le yǒulì bǎozhàng.', meaning_vi: 'Việc xây dựng hoàn thiện lối đi không rào cản đô thị đã mang lại sự bảo đảm vững chắc cho việc đi lại an toàn tự chủ của người cao tuổi và người khó khăn vận động.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '出租',
    pinyin: 'chūzū',
    word_type: 'Động từ',
    meaning_vi: 'cho thuê',
    examples: [
      { chinese: '房东打算把这套两室一厅的公寓长期出租给爱干净的租客。', pinyin: 'Fángdōng dǎsuàn bǎ zhè tào liǎngshì-yìtīng de gōngyù chángqī chūzū gěi ài gānjìng de zūkè.', meaning_vi: 'Chủ nhà định cho khách thuê chuộng sạch sẽ thuê lâu dài căn hộ hai phòng ngủ một phòng khách này.', difficulty_level: 'basic' },
      { chinese: '我们在三亚旅游度假期间特意向汽车租赁公司出租了一辆敞篷越野车。', pinyin: 'Wǒmen zài Sānyà lǚyóu dùjià qījiān tèyì xiàng qìchē zūlìn gōngsī chūzū le yí liàng chǎngpéng yuèyěchē.', meaning_vi: 'Trong thời gian du lịch nghỉ mát ở Tam Á, chúng tôi đã thuê từ công ty cho thuê xe một chiếc xe việt dã mui trần.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '厨房',
    pinyin: 'chúfáng',
    word_type: 'Danh từ',
    meaning_vi: 'nhà bếp, phòng bếp',
    examples: [
      { chinese: '妈妈正在厨房里忙着用砂锅煲一锅营养美味的鸡汤。', pinyin: 'Māma zhèngzài chúfáng lǐ máng zhe yòng shāguō bāo yì guō yíngyǎng měiwèi de jītāng.', meaning_vi: 'Mẹ đang bận rộn trong bếp dùng nồi đất hầm một nồi canh gà bổ dưỡng thơm ngon.', difficulty_level: 'basic' },
      { chinese: '现代开放式厨房设计不仅大幅拓展了视觉空间，更增进了家人烹饪过程中的温馨互动。', pinyin: 'Xiàndài kāifàngshì chúfáng shèjì bùjǐn dàfú tuòzhǎn le shìjué kōngjiān, gèng zēngjìn le jiārén pēngrèn guòchéng zhōng de wēnxīn hùdòng.', meaning_vi: 'Thiết kế bếp mở hiện đại không những mở rộng không gian thị giác đáng kể mà còn tăng thêm sự tương tác ấm áp của cả nhà trong lúc nấu nướng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '厨师',
    pinyin: 'chúshī',
    word_type: 'Danh từ',
    meaning_vi: 'đầu bếp',
    examples: [
      { chinese: '这家饭店聘请了特级川菜厨师主勺掌厨。', pinyin: 'Zhè jiā fàndiàn pìnqǐng le tèjí Chuāncài chúshī zhǔsháo zhǎngchú.', meaning_vi: 'Nhà hàng này đã thuê đầu bếp món Tứ Xuyên bậc đặc biệt về làm bếp trưởng.', difficulty_level: 'basic' },
      { chinese: '经验丰富的资深厨师不仅刀工精湛娴熟，更能巧妙运用各类香料激发食材的原汁原味。', pinyin: 'Jīngyàn fēngfù de zīshēn chúshī bùjǐn dāogōng jīngzhàn xiánshú, gèng néng qiǎomiào yùnyòng gè lèi xiāngliào jīfā shícái de yuánzhī-yuánwèi.', meaning_vi: 'Người đầu bếp kỳ cựu dày dặn kinh nghiệm không chỉ có kỹ nghệ dao thớt điêu luyện thuần thục, mà còn khéo léo dùng các loại gia vị để đánh thức vị nguyên bản của thực phẩm.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '窗',
    pinyin: 'chuāng',
    word_type: 'Danh từ',
    meaning_vi: 'cửa sổ',
    examples: [
      { chinese: '推开窗，一阵清新芬芳的花草香气扑面而来。', pinyin: 'Tuī kāi chuāng, yí zhèn qīngxīn fēnfāng de huācǎo xiāngqì pūmiàn’érlái.', meaning_vi: 'Đẩy mở cánh cửa sổ, một làn hương hoa cỏ thơm ngát thanh khiết ùa vào.', difficulty_level: 'basic' },
      { chinese: '“眼睛是心灵的窗”，透过一个人清澈真挚的目光往往能窥见其善良纯洁的内心世界。', pinyin: '“Yǎnjing shì xīnlíng de chuāng”, tòuguò yí gè rén qīngchè zhēnzhì de mùguāng wǎngwǎng néng kuījiàn qí shànliáng chúnjié de nèixīn shìjiè.', meaning_vi: '"Đôi mắt là cửa sổ tâm hồn", xuyên qua ánh nhìn trong trẻo chân thành của một con người thường có thể thấu tỏ thế giới nội tâm thiện lương thuần khiết của họ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '窗户',
    pinyin: 'chuānghu',
    word_type: 'Danh từ',
    meaning_vi: 'cửa sổ',
    examples: [
      { chinese: '房间里有点儿闷热，快把窗户打开通通风吧。', pinyin: 'Fángjiān lǐ yǒudiǎnr mēnrè, kuài bǎ chuānghu dǎkāi tōngtōngfēng ba.', meaning_vi: 'Trong phòng hơi ngột ngạt nóng nực, mau mở cửa sổ ra cho thoáng gió đi.', difficulty_level: 'basic' },
      { chinese: '擦得一尘不染的明亮玻璃窗户，将冬日午后温暖金黄的阳光尽数迎入室内。', pinyin: 'Cā de yìchén-bùrǎn de míngliàng bōli chuānghu, jiāng dōngrì wǔhòu wēnnuǎn jīnhuáng de yángguāng jìnshù yíng rù shìnèi.', meaning_vi: 'Cửa sổ kính sáng choang lau sạch không tì vết đón trọn ánh nắng vàng óng ấm áp ban trưa mùa đông vào bên trong phòng.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '吹',
    pinyin: 'chuī',
    word_type: 'Động từ',
    meaning_vi: 'thổi; chia tay (tình cảm); đổ bể (kế hoạch)',
    examples: [
      { chinese: '晚饭后漫步在海边，迎面吹来的海风格外凉爽惬意。', pinyin: 'Wǎnfàn hòu mànbù zài hǎibiān, yíngmiàn chuī lái de hǎifēng géwài liángshuǎng qièyì.', meaning_vi: 'Sau bữa tối đi dạo bờ biển, làn gió biển phả vào mặt mát rượi khoan khoái lạ thường.', difficulty_level: 'basic' },
      { chinese: '蜡烛被寿星一口气吹灭，在场的所有亲朋好友纷纷鼓掌送上真挚的生日祝福。', pinyin: 'Làzhú bèi shòuxīng yì kǒu qì chuī miè, zàichǎng de suǒyǒu qīnpéng-hǎoyǒu fēnfēn gǔzhǎng sòng shàng zhēnzhì de shēngrì zhùfú.', meaning_vi: 'Ngọn nến được chủ nhân bữa tiệc sinh nhật thổi tắt chỉ trong một hơi thở, toàn thể bạn bè người thân có mặt đồng loạt vỗ tay gửi lời chúc mừng sinh nhật chân thành.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '词语',
    pinyin: 'cíyǔ',
    word_type: 'Danh từ',
    meaning_vi: 'từ ngữ',
    examples: [
      { chinese: '掌握丰富的核心词语是写出优美流畅中文作文的基石。', pinyin: 'Zhǎngwò fēngfù de héxīn cíyǔ shì xiě chū yōuměi liúchàng Zhōngwén zuòwén de jīshí.', meaning_vi: 'Nắm vững vốn từ ngữ trọng tâm phong phú là nền tảng để viết nên những bài văn tiếng Trung trau chuốt lưu loát.', difficulty_level: 'basic' },
      { chinese: '在具体语境中准确辨析近义词语的细微差异，是提升高级汉语水平的关键所在。', pinyin: 'Zài jùtǐ yǔjìng zhōng zhǔnquè biànxī jìnyì cíyǔ de xìwēi chāyì, shì tíshēng gāojí Hànyǔ shuǐpíng de guānjiàn suǒzài.', meaning_vi: 'Phân biệt chuẩn xác sự khác biệt tinh tế của các từ ngữ gần nghĩa trong ngữ cảnh cụ thể là điểm then chốt để nâng cao trình độ Hán ngữ cao cấp.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '此',
    pinyin: 'cǐ',
    word_type: 'Đại từ',
    meaning_vi: 'này, đây',
    examples: [
      { chinese: '此地山清水秀，风景如画，吸引了众多远方游客。', pinyin: 'Cǐ dì shānqīng-shuǐxiù, fēngjǐng-rúhuà, xīyǐn le zhòngduō yuǎnfāng yóukè.', meaning_vi: 'Nơi này non xanh nước biếc, cảnh sắc như tranh vẽ, thu hút đông đảo du khách phương xa.', difficulty_level: 'basic' },
      { chinese: '鉴于此项目的战略重要性，董事会决定追加专项资金支持其技术攻坚。', pinyin: 'Jiànyú cǐ xiàngmù de zhànlüè zhòngyàoxìng, dǒngshìhuì juédìng zhuījiā zhuānxiàng zījīn zhīchí qí jìshù gōngjiān.', meaning_vi: 'Xét đến tầm quan trọng chiến lược của dự án này, hội đồng quản trị quyết định cấp thêm nguồn vốn chuyên biệt để hỗ trợ đột phá công nghệ.', difficulty_level: 'applied' }
    ]
  },
  {
    hanzi: '此次',
    pinyin: 'cǐ cì',
    word_type: 'Cụm từ',
    meaning_vi: 'lần này',
    examples: [
      { chinese: '此次国际文化交流节共有来自五十多个国家的青年代表参加。', pinyin: 'Cǐ cì guójì wénhuà jiāoliú jié gòng yǒu láizì wǔshí duō gè guójiā de qīngnián dàibiǎo cānjiā.', meaning_vi: 'Ngày hội giao lưu văn hóa quốc tế lần này có tổng cộng đại diện thanh niên đến từ hơn năm mươi quốc gia tham dự.', difficulty_level: 'basic' },
      { chinese: '此次实地考察调研不仅加深了双方的了解，更为下一阶段的深度经贸合作奠定了坚实的基础。', pinyin: 'Cǐ cì shídì kǎochá diàoyán bùjǐn jiāshēn le shuāngfāng de liǎojiě, gèng wèi xià yí jiēduàn de shēndù jīngmào hézuò diàndìng le jiānshí de jīchǔ.', meaning_vi: 'Chuyến khảo sát nghiên cứu thực địa lần này không chỉ làm sâu sắc thêm hiểu biết của đôi bên mà càng đặt nền móng vững chắc cho sự hợp tác kinh tế thương mại sâu rộng trong giai đoạn tiếp theo.', difficulty_level: 'applied' }
    ]
  }
]

console.log('HSK 4 Batch 1 loaded successfully with 100 items and 200 examples!')
