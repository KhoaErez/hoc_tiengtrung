// data/hsk5-batch16-part3-data.ts
// 25 từ HSK 5: #3552 [住址] -> #3576 [自觉]

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

export const HSK5_BATCH16_PART3: VocabItem[] = [
  {
    id: 3552,
    hanzi: '住址',
    pinyin: 'zhùzhǐ',
    word_type: 'Danh từ',
    meaning_vi: 'địa chỉ nhà, nơi cư trú',
    examples: [
      {
        chinese: '在填写快递寄件单时，请务必核对好收件人的姓名、电话号码和详细住址。',
        pinyin: 'Zài tiánxiě kuàidì jìjiàndān shí, qǐng wùbì héduì hǎo shōujiànrén de xìngmíng, diànhuà hàomǎ hé xiángxì zhùzhǐ.',
        meaning_vi: 'Khi điền phiếu gửi bưu phẩm chuyển phát nhanh, xin bạn hãy đối chiếu kỹ họ tên, số điện thoại và địa chỉ nhà chi tiết của người nhận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '不动产登记中心严格规范权利人住址与身份证件信息的动态关联变更流程，确保产权法律证书与实体现状完全吻合。',
        pinyin: 'Búdòngchǎn dēngjì zhōngxīn yángé guīfàn quánlìrén zhùzhǐ yǔ shēnfèn zhèngjiàn xìnxī de dòngtài guānlián biàngēng liúchéng, quèbǎo chǎnquán fǎlǜ zhèngshū yǔ shítǐ xiànzhuàng wánquán wěnhé.',
        meaning_vi: 'Trung tâm đăng ký bất động sản quy chuẩn nghiêm ngặt quy trình liên kết thay đổi động giữa thông tin giấy tờ tùy thân và địa chỉ cư trú của người có quyền sở hữu, bảo đảm văn bằng pháp lý chủ quyền ăn khớp hoàn toàn với hiện trạng thực thể.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3553,
    hanzi: '注重',
    pinyin: 'zhùzhòng',
    word_type: 'Động từ',
    meaning_vi: 'chú trọng, coi trọng',
    examples: [
      {
        chinese: '现代人越来越注重日常饮食的营养均衡，不仅要吃饱而且要吃得健康。',
        pinyin: 'Xiàndàirén yuèláiyuè zhùzhòng rìcháng yǐnshí de yíngyǎng jūnhéng, bù jǐn yào chībǎo érqiě yào chī de jiànkāng.',
        meaning_vi: 'Con người hiện đại ngày càng coi trọng sự cân bằng dinh dưỡng trong bữa ăn hằng ngày, không những phải ăn no mà còn phải ăn sao cho có lợi cho sức khỏe.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业高质量可持续发展战略注重平衡当期商业利润回报与中长期环境、社会及治理核心指标的稳步提升。',
        pinyin: 'Qǐyè gāozhìliàng kěchíxù fāzhǎn zhànlüè zhùzhòng pínghéng dāngqī shāngyè lìrùn huíbào yǔ zhōng-chángqī huánjìng, shèhuì jí zhìlǐ héxīn zhǐbiāo de wěnbù tíshēng.',
        meaning_vi: 'Chiến lược phát triển bền vững chất lượng cao của doanh nghiệp chú trọng cân bằng giữa lợi nhuận kinh doanh hoàn vốn kỳ hiện tại với việc nâng cao vững chắc các chỉ số cốt lõi về môi trường, xã hội và quản trị trong trung và dài hạn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3554,
    hanzi: '抓',
    pinyin: 'zhuā',
    word_type: 'Động từ',
    meaning_vi: 'bắt, chộp, tóm, túm lấy; nắm bắt',
    examples: [
      {
        chinese: '小猫警觉地蹲在墙角草丛中，猛地往前一扑，敏捷地抓住了那只乱窜的小老鼠。',
        pinyin: 'Xiǎomāo jǐngjué de dūn zài qiángjiǎo cǎocóng zhōng, měngde wǎng qián yì pū, mǐnjié de zhuā zhù le nà zhī luàncuàn de xiǎolǎoshǔ.',
        meaning_vi: 'Chú mèo con cảnh giác nép mình trong bụi cỏ góc tường, đột ngột vồ mạnh về phía trước, nhanh nhẹn tóm gọn chú chuột nhắt đang chạy loạn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '各级政府职能部门牢牢抓紧抓实重大工程建设项目施工安全生产责任制，坚决防范遏制重特大安全事故发生。',
        pinyin: 'Gè jí zhèngfǔ zhínéng bùmén láoláo zhuājǐn zhuāshí zhòngdà gōngchéng jiànshè xiàngmù shīgōng ānquán shēngchǎn zérènzhì, jiānjué fángfàn èzhì zhòng-tèdà ānquán shìgù fāshēng.',
        meaning_vi: 'Các cơ quan chức năng chính quyền các cấp nắm chắc siết chặt chế độ trách nhiệm sản xuất an toàn thi công các dự án xây dựng công trình trọng đại, kiên quyết phòng ngừa ngăn chặn các sự cố an toàn đặc biệt nghiêm trọng xảy ra.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3555,
    hanzi: '抓紧',
    pinyin: 'zhuājǐn',
    word_type: 'Động từ',
    meaning_vi: 'tranh thủ, nắm chắc, khẩn trương',
    examples: [
      {
        chinese: '距离期末考试只剩下最后两周时间了，大家都在抓紧每分每秒查漏补缺。',
        pinyin: 'Jùlí qīmò kǎoshì zhǐ shèng xià zuìhòu liǎng zhōu shíjiān le, dàjiā dōu zài zhuājǐn měi fēn měi miǎo chá-lòu-bǔ-quē.',
        meaning_vi: 'Cách kỳ thi cuối kỳ chỉ còn lại đúng hai tuần cuối cùng, mọi người đều đang tranh thủ từng phút từng giây để bù đắp các lỗ hổng kiến thức.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科研攻坚团队正抓紧推进第六代移动通信关键核心射频芯片在超低温极端环境下的可靠性封装测试。',
        pinyin: 'Kēyán gōngjiān tuánduì zhèng zhuājǐn tuījìn dì-liù dài yídòng tōngxìn guānjiàn héxīn shèpín xīnpiàn zài chāo-dīwēn jíduān huánjìng xià de kěkàoxìng fēngzhuāng cèshì.',
        meaning_vi: 'Đội ngũ nghiên cứu khoa học đột phá đang khẩn trương đẩy mạnh thử nghiệm đóng gói độ tin cậy của chip vô tuyến then chốt cốt lõi viễn thông di động thế hệ thứ sáu dưới môi trường cực hạn siêu nhiệt độ thấp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3556,
    hanzi: '专家',
    pinyin: 'zhuānjiā',
    word_type: 'Danh từ',
    meaning_vi: 'chuyên gia',
    examples: [
      {
        chinese: '为了确保大型跨海大桥的施工质量，工程指挥部专门邀请了数位知名桥梁工程专家亲临现场指导。',
        pinyin: 'Wèile quèbǎo dàxíng kuàhǎi dàqiáo de shīgōng zhìliàng, gōngchéng zhǐhuībù zhuānmén yāoqǐng le shù wèi zhīmíng qiáoliáng gōngchéng zhuānjiā qīnlín xiànchǎng zhǐdǎo.',
        meaning_vi: 'Để bảo đảm chất lượng thi công cầu lớn vượt biển quy mô lớn, ban chỉ huy công trình đã đặc biệt mời mấy vị chuyên gia kỹ thuật cầu đường nổi tiếng đích thân tới hiện trường chỉ đạo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '多边国际气候谈判代表团设立了由顶级生态学与气象学专家组成的独立咨询委员会，为温室气体减排履约提供客观科学基准。',
        pinyin: 'Duōbiān guójì qìhòu tánpàn dàibiǎotuán shèlì le yóu dǐngjí shēngtàixué yǔ qìxiàngxué zhuānjiā zǔchéng de dúlì zīxún wěiyuánhuì, wèi wēnshì qìtǐ jiǎnpái lǚyuē tígōng kèguān kēxué jīzhǔn.',
        meaning_vi: 'Đoàn đại biểu đàm phán khí hậu quốc tế đa phương đã thành lập ủy ban tư vấn độc lập gồm các chuyên gia hàng đầu về sinh thái học và khí tượng học, cung cấp chuẩn mực khoa học khách quan cho việc thực thi cam kết cắt giảm khí nhà kính.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3557,
    hanzi: '专心',
    pinyin: 'zhuānxīn',
    word_type: 'Tính từ',
    meaning_vi: 'chuyên tâm, tập trung, chú tâm',
    examples: [
      {
        chinese: '只要你在课堂上专心听讲并认真做好笔记，课后复习起来就会感觉轻松许多。',
        pinyin: 'Zhǐyào nǐ zài kètáng shang zhuānxīn tīngjiǎng bìng rènzhēn zuò hǎo bǐjì, kèhòu fùxí qǐlái jiù huì gǎnjué qīngsōng xǔduō.',
        meaning_vi: 'Chỉ cần bạn chuyên tâm nghe giảng trong lớp và cẩn thận ghi chép bài đầy đủ, khi ôn tập sau giờ học sẽ cảm thấy nhẹ nhàng hơn rất nhiều.',
        difficulty_level: 'basic'
      },
      {
        chinese: '顶尖基础科学研究需要科研工作者克服外界浮躁诱惑，专心致志地扎根冷门基础理论攻关长达数十载。',
        pinyin: 'Dǐngjiān jīchǔ kēxué yánjiū xūyào kēyán gōngzuòzhě kèfú wàijiè fúzào yòuhuò, zhuānxīn-zhìzhì de zhāgēn lěngmén jīchǔ lǐlùn gōngguān chángdá shùshí zǎi.',
        meaning_vi: 'Nghiên cứu khoa học cơ bản đỉnh cao đòi hỏi các cán bộ nghiên cứu phải khắc phục những cám dỗ phù phiếm từ bên ngoài, chuyên tâm dốc chí cắm rễ vào các đột phá lý thuyết cơ bản ít người theo đuổi ròng rã suốt hàng chục năm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3558,
    hanzi: '转变',
    pinyin: 'zhuǎnbiàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'chuyển biến, biến đổi, chuyển hướng',
    examples: [
      {
        chinese: '通过与老师的一番促膝长谈，他的思想观念发生了积极的转变，开始主动努力学习。',
        pinyin: 'Tōngguò yǔ lǎoshī de yì fān cùxī-chángtán, tā de sīxiǎng guānniàn fāshēng le jījí de zhuǎnbiàn, kāishǐ zhǔdòng nǔlì xuéxí.',
        meaning_vi: 'Thông qua một hồi tâm sự cởi mở với thầy giáo, quan niệm tư tưởng của anh ấy đã phát sinh chuyển biến tích cực, bắt đầu chủ động nỗ lực học tập.',
        difficulty_level: 'basic'
      },
      {
        chinese: '推动经济发展方式由传统的要素驱动粗放扩张向全要素生产率驱动的高质量创新发展方式转变，是构建新发展格局的核心支撑。',
        pinyin: 'Tuīdòng jīngjì fāzhǎn fāngshì yóu chuántǒng de yàosù qūdòng cūfàng kuòzhāng xiàng quán-yàosù shēngchǎnlǜ qūdòng de gāozhìliàng chuàngxīn fāzhǎn fāngshì zhuǎnbiàn, shì gòujiàn xīn fāzhǎn géjú de héxīn zhīchēng.',
        meaning_vi: 'Thúc đẩy phương thức phát triển kinh tế chuyển biến từ việc mở rộng tràn lan bằng dẫn dắt các yếu tố truyền thống sang phương thức phát triển đổi mới sáng tạo chất lượng cao do năng suất tổng nhân tố dẫn dắt là trụ cột cốt lõi để xây dựng cục diện phát triển mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3559,
    hanzi: '转告',
    pinyin: 'zhuǎngào',
    word_type: 'Động từ',
    meaning_vi: 'chuyển lời, nhắn lại, nói lại',
    examples: [
      {
        chinese: '如果明天早晨王经理先到办公室，麻烦您转告他项目合同原件已经放在他的办公桌上了。',
        pinyin: 'Rúguǒ míngtiān zǎochén Wáng jīnglǐ xiān dào bàngōngshì, máfan nín zhuǎngào tā xiàngmù hétong yuánjiàn yǐjīng fàng zài tā de bàngōngzhuō shang le.',
        meaning_vi: 'Nếu sáng mai giám đốc Vương đến văn phòng trước, làm phiền bạn chuyển lời nhắn với ông ấy rằng bản gốc hợp đồng dự án đã được để sẵn trên bàn làm việc của ông rồi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '特使在结束闭门斡旋会晤后，郑重请东道国外长向国家元首转告关于立即停火并开启无条件多边人道主义走廊谈判的正式倡议。',
        pinyin: 'Tèshǐ zài jiéshù bìmén wòxuán huìwù hòu, zhèngzhòng qǐng dōngdàoguó wàizhǎng xiàng guójiā yuánshǒu zhuǎngào guānyú lìjí tínghuǒ bìng kāiqǐ wú-tiáojiàn duōbiān réndàozhǔyì zǒuláng tánpàn de zhèngshì chàngyì.',
        meaning_vi: 'Đặc phái viên sau khi kết thúc cuộc hội đàm hòa giải kín đã trịnh trọng nhờ Ngoại trưởng nước chủ nhà chuyển lời tới Nguyên thủ quốc gia về sáng kiến chính thức ngừng bắn ngay lập tức và mở đàm phán hành lang nhân đạo đa phương không kèm điều kiện.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3560,
    hanzi: '装饰',
    pinyin: 'zhuāngshì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'trang trí, đồ trang trí',
    examples: [
      {
        chinese: '新春佳节来临之前，各家各户都在门窗上贴满了漂亮的红色窗花与福字来进行节日装饰。',
        pinyin: 'Xīnchūn jiājié láilín zhīqián, gèjiā-gèhù dōu zài ménchuāng shang tiē mǎn le piàoliang de hóngsè chuānghuā yǔ fúzì lái jìnxíng jiérì zhuāngshì.',
        meaning_vi: 'Trước khi dịp Tết cổ truyền đến, nhà nhà đều dán kín những bông hoa giấy đỏ cắt hoa văn tinh xảo và chữ Phúc lên cửa ra vào và cửa sổ để trang trí ngày lễ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家大剧院主音乐厅内壁采用非对称微穿孔声学反射装饰面板，完美兼顾了古典建筑美学视觉享受与极佳的声场扩散效果。',
        pinyin: 'Guójiā Dà Jùyuàn zhǔ yīnyuètīng nèibì cǎiyòng fēi-duìchèn wēi-chuānkǒng shēngxué fǎnshè zhuāngshì miànbǎn, wánměi jiāngù le gǔdiǎn jiànzhù měixué shìjué xiǎngshòu yǔ jí jiā de shēngchǎng kuòsàn xiàoguǒ.',
        meaning_vi: 'Vách trong khán phòng âm nhạc chính của Nhà hát Lớn Quốc gia sử dụng tấm ốp trang trí phản xạ âm thanh đục vi lỗ bất đối xứng, kết hợp hoàn hảo giữa thưởng thức thị giác thẩm mỹ kiến trúc cổ điển với hiệu ứng khuếch tán trường âm cực kỳ xuất sắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3561,
    hanzi: '装修',
    pinyin: 'zhuāngxiū',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'trang hoàng, sửa sang nội thất, decor',
    examples: [
      {
        chinese: '他们刚刚购买了一套二手公寓，正忙着挑选环保建材和家具准备在下个月开始装修。',
        pinyin: 'Tāmen gānggāng gòumǎi le yí tào èrshǒu gōngyù, zhèng máng zhe tiāoxuǎn huánbǎo jiàncái hé jiājù zhǔnbèi zài xià ge yuè kāishǐ zhuāngxiū.',
        meaning_vi: 'Họ vừa mới mua một căn hộ chung cư thứ cấp, đang tất bật lựa chọn vật liệu xây dựng thân thiện môi trường và đồ nội thất chuẩn bị khởi công sang sửa nội thất vào tháng tới.',
        difficulty_level: 'basic'
      },
      {
        chinese: '绿色建筑装饰工程行业标准强制要求室内装修所使用的黏合剂与涂料释放物全面达到超低甲醛与挥发性有机化合物限值。',
        pinyin: 'Lǜsè jiànzhù zhuāngshì gōngchéng hángyè biāozhǔn qiángzhì yāoqiú shìnèi zhuāngxiū suǒ shǐyòng de niánhéjì yǔ túliào shìfàngwù quánmiàn dádào chāo-dī jiǎquán yǔ huīfāxìng yǒujī huàhéwù xiànzhí.',
        meaning_vi: 'Tiêu chuẩn ngành công trình trang trí kiến trúc xanh bắt buộc yêu cầu chất kết dính và sơn phủ sử dụng trong sửa sang nội thất phải đạt chuẩn ranh giới phát thải formaldehyde siêu thấp và các hợp chất hữu cơ dễ bay hơi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3562,
    hanzi: '撞',
    pinyin: 'zhuàng',
    word_type: 'Động từ',
    meaning_vi: 'va chạm, đâm, va phải',
    examples: [
      {
        chinese: '他在走廊拐角处只顾着低头看手机，不小心一下子撞在了迎面走来的同事身上。',
        pinyin: 'Tā zài zǒuláng guǎijiǎochù zhǐ gù zhe dītóu kàn shǒujī, bù xiǎoxīn yíxiàzi zhuàng zài le yíngmiàn zǒu lái de tóngshì shēnshang.',
        meaning_vi: 'Ở khúc ngoặt hành lang anh ấy chỉ mải cúi đầu nhìn điện thoại, vô ý một cái đâm sầm vào người người đồng nghiệp đang đi đón đầu tới.',
        difficulty_level: 'basic'
      },
      {
        chinese: '汽车主动安全防碰撞预警系统基于毫米波雷达与前视双目摄像头的多模态感知算法，在毫秒级内自动触发全速域紧急制动以规避车辆追尾。',
        pinyin: 'Qìchē zhǔdòng ānquán fáng-pèngzhuàng yùjǐng xìtǒng jīyú háomǐbō léidá yǔ qiánshì shuāngmù shèxiàngtóu de duō-mótài gǎnzhī suànfǎ, zài háomiǎojí nèi zìdòng chùfā quán-sùyù jǐnjí zhìdòng yǐ guībì chēliàng zhuīwěi.',
        meaning_vi: 'Hệ thống cảnh báo an toàn chủ động phòng va chạm của ô tô dựa trên thuật toán nhận thức đa phương thức của radar sóng milimet và camera kép nhìn trước, trong cấp mili giây tự động kích hoạt phanh khẩn cấp trên toàn dải tốc độ nhằm né tránh va quẹt đâm đuôi xe.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3563,
    hanzi: '状况',
    pinyin: 'zhuàngkuàng',
    word_type: 'Danh từ',
    meaning_vi: 'tình trạng, tình hình (kinh tế, sức khỏe, giao thông)',
    examples: [
      {
        chinese: '爷爷在做完心脏搭桥手术之后一直坚持每天散步，目前身体恢复状况非常良好。',
        pinyin: 'Yéye zài zuò wán xīnzàng dāqiáo shǒushù zhīhòu yìzhí jiānchí měitiān sànbù, mùqián shēntǐ huīfù zhuàngkuàng fēicháng liánghǎo.',
        meaning_vi: 'Ông nội sau khi làm xong phẫu thuật bắc cầu mạch vành luôn kiên trì đi bộ hằng ngày, hiện tại tình trạng hồi phục thể trạng của ông rất tốt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中央银行发布的区域金融运行监测报告指出，中小法人金融机构资本充足率与流动性监管指标整体处于稳健安全状况。',
        pinyin: 'Zhōngyāng yínháng fābù de qūyù jīnróng yùnxíng jiāncè bàogào zhǐchū, zhōng-xiǎo fǎrén jīnróng jīgòu zīběn chōngzúlǜ yǔ liúdòngxìng jiānguǎn zhǐbiāo zhěngtǐ chǔyú wěnjiàn ānquán zhuàngkuàng.',
        meaning_vi: 'Báo cáo giám sát vận hành tài chính khu vực do ngân hàng trung ương công bố chỉ rõ rằng tỷ lệ an toàn vốn và các chỉ tiêu giám sát thanh khoản của các tổ chức tài chính pháp nhân vừa và nhỏ nhìn chung đang ở trong tình trạng an toàn và vững chắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3564,
    hanzi: '状态',
    pinyin: 'zhuàngtài',
    word_type: 'Danh từ',
    meaning_vi: 'trạng thái',
    examples: [
      {
        chinese: '运动员在赛前一定要调整好自己的作息与心理，努力让自己在比赛当天处于最佳竞技状态。',
        pinyin: 'Yùndòngyuán zài sàiqián yídìng yào tiáozhěng hǎo zìjǐ de zuòxī yǔ xīnlǐ, nǔlì ràng zìjǐ zài bǐsài dāngtiān chǔyú zuìjiā jìngjì zhuàngtài.',
        meaning_vi: 'Vận động viên trước khi thi đấu nhất định phải điều chỉnh tốt chế độ nghỉ ngơi sinh hoạt và tâm lý của bản thân, nỗ lực giúp mình đạt trạng thái thi đấu đỉnh cao trong ngày tranh tài.',
        difficulty_level: 'basic'
      },
      {
        chinese: '量子计算机利用超导量子比特的叠加态与纠缠态等量子力学奇异状态，在特定复杂组合优化问题求解上展现出经典算力无法比拟的计算效率。',
        pinyin: 'Liàngzǐ jìsuànjī lìyòng chāodǎo liàngzǐ bǐtè de diéjiātài yǔ jiūchántài děng liàngzǐ lìxué qíyì zhuàngtài, zài tèdìng fùzá zǔhé yōuhuà wèntí qiújiě shang zhǎnxiàn chū jīngdiǎn suànlì wúfǎ bǐnǐ de jìsuàn xiàolǜ.',
        meaning_vi: 'Máy tính lượng tử tận dụng các trạng thái kỳ dị của cơ học lượng tử như trạng thái chồng chất và trạng thái vướng víu của qubit siêu dẫn, đã thể hiện hiệu suất tính toán mà sức mạnh tính toán cổ điển không thể sánh kịp trong giải các bài toán tối ưu hóa tổ hợp phức tạp đặc thù.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3565,
    hanzi: '追',
    pinyin: 'zhuī',
    word_type: 'Động từ',
    meaning_vi: 'đuổi theo, đuổi bắt, truy đuổi',
    examples: [
      {
        chinese: '他看见老奶奶把刚买的蔬菜遗落在了菜摊上，连忙拿起塑料袋一路追了上去。',
        pinyin: 'Tā kànjiàn lǎonǎinai bǎ gāng mǎi de shūcài yíluò zài le càitān shang, liánmáng ná qǐ sùliàodài yílù zhuī le shàngqu.',
        meaning_vi: 'Anh ấy nhìn thấy bà cụ để quên rau vừa mua ở sạp rau, liền vội vã cầm túi ni lông chạy đuổi theo suốt một đoạn đường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '我国在深空探测与可控核聚变领域奋起直追，成功实现了从长期并跑向引领全球重大前沿科学基础设施建设的历史性跨越。',
        pinyin: 'Wǒguó zài shēnkōng tàncè yǔ kěkòng hé-jùbiàn lǐngyù fènqǐ-zhízhuī, chénggōng shíxiàn le cóng chángqī bìngpǎo xiàng yǐnlǐng quánqiú zhòngdà qiányán kēxué jīchǔ-shèshī jiànshè de lìshǐxìng kuàyuè.',
        meaning_vi: 'Nước ta trong các lĩnh vực thăm dò vũ trụ sâu và nhiệt hạch có thể kiểm soát đã vươn lên đuổi kịp mạnh mẽ, thành công hiện thực hóa bước nhảy vọt lịch sử từ việc chạy song hành trường kỳ tiến tới dẫn dắt xây dựng các cơ sở hạ tầng khoa học mũi nhọn trọng đại toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3566,
    hanzi: '追求',
    pinyin: 'zhuīqiú',
    word_type: 'Động từ',
    meaning_vi: 'theo đuổi, mưu cầu',
    examples: [
      {
        chinese: '青年人应当树立远大崇高的人生理想，勇于追求自己的梦想而不畏惧途中的艰难险阻。',
        pinyin: 'Qīngniánrén yīngdāng shùlì yuǎndà chónggāo de rénshēng lǐxiǎng, yǒngyú zhuīqiú zìjǐ de mèngxiǎng ér bú wèijù túzhōng de jiānnán-xiǎnzǔ.',
        meaning_vi: 'Thanh niên nên xác lập lý tưởng nhân sinh cao đẹp và rộng lớn, dũng cảm theo đuổi ước mơ của mình mà không hề khiếp sợ những gian lao trắc trở trên đường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代法治文明追求实体公正与程序正义的内在统一，保障每一个公民在司法审判案件中都能切实感受到公平正义。',
        pinyin: 'Xiàndài fǎzhì wénmíng zhuīqiú shítǐ gōngzhèng yǔ chéngxù zhèngyì de nèizài tǒngyī, bǎozhàng měi yí ge gōngmín zài sīfǎ shěnpàn ànjiàn zhōng dōu néng qièshí gǎnshòu dào gōngpíng zhèngyì.',
        meaning_vi: 'Văn minh pháp trị hiện đại theo đuổi sự thống nhất nội tại giữa công lý thực thể và công lý quy trình, bảo đảm mỗi một công dân trong các vụ án xét xử tư pháp đều có thể cảm nhận thực chất sự công bằng và chính nghĩa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3567,
    hanzi: '资格',
    pinyin: 'zīgé',
    word_type: 'Danh từ',
    meaning_vi: 'tư cách, điều kiện, tiêu chuẩn',
    examples: [
      {
        chinese: '只有按时修满规定的大学本科学分并通过毕业答辩的学生，才具备申请学士学位的法定资格。',
        pinyin: 'Zhǐyǒu ànshí xiū mǎn guīdìng de dàxué běnkē xuéfēn bìng tōngguò bìyè dábbiàn de xuésheng, cái jùbèi shēnqǐng xuéshì xuéwèi de fǎdìng zīgé.',
        meaning_vi: 'Chỉ có những sinh viên hoàn thành đúng hạn các tín chỉ đại học chính quy theo quy định và vượt qua bảo vệ khóa luận tốt nghiệp mới có đủ tư cách pháp định để xin cấp bằng cử nhân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '金融监管委员会对申请从事跨境衍生金融工具交易的期货经纪商实行穿透式净资本与风控能力准入资格动态审查。',
        pinyin: 'Jīnróng jiānguǎn wěiyuánhuì duì shēnqǐng cóngshì kuàjìng yǎnshēng jīnróng gōngjù jiāoyì de qīhuò jīngjìshāng shíxíng chuāntòushì jìng-zīběn yǔ fēngkòng nénglì zhǔnrù zīgé dòngtài shěnchá.',
        meaning_vi: 'Ủy ban giám sát tài chính thực thi việc thẩm tra động tư cách gia nhập thị trường về năng lực quản trị rủi ro và vốn tự có ròng mang tính xuyên thấu đối với các công ty môi giới phái sinh xin phép kinh doanh giao dịch công cụ tài chính phái sinh xuyên biên giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3568,
    hanzi: '资金',
    pinyin: 'zījīn',
    word_type: 'Danh từ',
    meaning_vi: 'vốn, nguồn vốn, tiền vốn',
    examples: [
      {
        chinese: '这家初创科技团队凭借出色的智能算法原型设计，在第一轮融资中成功筹集到了五百万元创业资金。',
        pinyin: 'Zhè jiā chūchuàng kējì tuánduì píngjiè chūsè de zhìnéng suànfǎ yuánxíng shèjì, zài dì-yī lún róngzī zhōng chénggōng chóují dào le wǔbǎi wàn yuán chuàngyè zījīn.',
        meaning_vi: 'Đội ngũ công nghệ khởi nghiệp này dựa vào thiết kế nguyên mẫu thuật toán thông minh xuất sắc đã gọi vốn thành công năm triệu nhân dân tệ tiền vốn khởi nghiệp trong vòng cấp vốn đầu tiên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家引导长期耐性资本与主权养老保障基金以股权投资方式精准注入国家重大科学装置与基础软件研发核心项目，保障研发资金链的稳固韧性。',
        pinyin: 'Guójiā yǐndǎo chángqī nàixìng zīběn yǔ zhǔquán yǎnglǎo bǎozhàng jījīn yǐ gǔquán tóuzī fāngshì jīngzhǔn zhùrù guójiā zhòngdà kēxué zhuāngzhì yǔ jīchǔ ruǎnjiàn yánfā héxīn xiàngmù, bǎozhàng yánfā zījīnliàn de wěngù rènxìng.',
        meaning_vi: 'Nhà nước định hướng dòng vốn kiên nhẫn dài hạn và quỹ bảo hiểm hưu trí chủ quyền rót vốn chuẩn xác dưới hình thức đầu tư cổ phần vào các trang thiết bị khoa học trọng đại quốc gia và dự án cốt lõi nghiên cứu phát triển phần mềm nền tảng, bảo đảm độ kiên cố và dẻo dai của chuỗi vốn R&D.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3569,
    hanzi: '姿势',
    pinyin: 'zīshì',
    word_type: 'Danh từ',
    meaning_vi: 'tư thế, dáng điệu',
    examples: [
      {
        chinese: '长时间坐在电脑前伏案办公的人，一定要保持端正的坐立姿势以防颈椎和腰椎受到劳损。',
        pinyin: 'Cháng shíjiān zuò zài diànnǎo qián fú\'àn bàngōng de rén, yídìng yào bǎochí duānzhèng de zuò-lì zīshì yǐfáng jǐngzhuī hé yāozhuī shòudào láosǔn.',
        meaning_vi: 'Những người ngồi làm việc trước máy tính trong thời gian dài nhất định phải duy trì tư thế ngồi đứng ngay ngắn để phòng ngừa đốt sống cổ và thắt lưng bị tổn thương thoái hóa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高精度人体姿态估计计算机视觉算法通过深度神经网络实时捕捉多关节三维空间坐标，被广泛应用于骨科康复评估与高端运动医学指导。',
        pinyin: 'Gāojīngdù réntǐ zītài gūjì jìsuànjī shìjué suànfǎ tōngguò shēndù shénjīng-wǎngluò shíshí bǔzhuō duō-guānjié sānwéi kōngjiān zuòbiāo, bèi guǎngfàn yìngyòng yú gǔkē kāngfù pínggū yǔ gāoduān yùndòng yīxué zhǐdǎo.',
        meaning_vi: 'Thuật toán thị giác máy tính ước lượng tư thế cơ thể người độ chính xác cao thông qua mạng nơ-ron sâu chụp lại tọa độ không gian ba chiều đa khớp theo thời gian thực, được ứng dụng rộng rãi trong đánh giá phục hồi chức năng chỉnh hình và chỉ đạo y học thể thao cao cấp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3570,
    hanzi: '咨询',
    pinyin: 'zīxún',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'tư vấn, tham vấn',
    examples: [
      {
        chinese: '如果你对大学志愿填报流程或者专业录取分数线有任何疑问，可以随时拨打招生咨询热线电话。',
        pinyin: 'Rúguǒ nǐ duì dàxué zhìyuàn tiánbào liúchéng huòzhě zhuānyè lùqǔ fēnshùxiàn yǒu rènhé yíwèn, kěyǐ suíshí bōdǎ zhāoshēng zīxún rèxiàn diànhuà.',
        meaning_vi: 'Nếu bạn có bất kỳ thắc mắc nào về quy trình đăng ký nguyện vọng đại học hay điểm chuẩn tuyển sinh chuyên ngành, bạn có thể gọi điện tới đường dây nóng tư vấn tuyển sinh bất cứ lúc nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '知名跨国战略管理咨询机构为该传统汽车制造巨头量身定制了向智能纯电新能源整体转型的五年实施路线图。',
        pinyin: 'Zhīmíng kuàguó zhànlüè guǎnlǐ zīxún jīgòu wèi gāi chuántǒng qìchē zhìzào jùtóu liàngshēn dìngzhì le xiàng zhìnéng chún-diàn xīn-néngyuán zhěngtǐ zhuǎnxíng de wǔ nián shíshī lùxiàntú.',
        meaning_vi: 'Cơ quan tư vấn quản lý chiến lược xuyên quốc gia nổi tiếng đã thiết kế riêng cho gã khổng lồ sản xuất ô tô truyền thống đó bản lộ trình thực thi năm năm về việc chuyển đổi tổng thể sang dòng xe năng lượng mới thuần điện thông minh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3571,
    hanzi: '资源',
    pinyin: 'zīyuán',
    word_type: 'Danh từ',
    meaning_vi: 'tài nguyên, nguồn lực',
    examples: [
      {
        chinese: '水资源是地球上所有生命不可或缺的宝贵物质基础，我们每个人在日常生活中都要养成节约用水的好习惯。',
        pinyin: 'Shuǐ zīyuán shì dìqiú shang suǒyǒu shēngmìng bùkě-huòquē de bǎoguì wùzhì jīchǔ, wǒmen měi ge rén zài rìcháng shēnghuó zhōng dōu yào yǎngchéng jiéyuē yòngshuǐ de hǎo xíguàn.',
        meaning_vi: 'Tài nguyên nước là cơ sở vật chất quý báu không thể thiếu của mọi sự sống trên Trái Đất, mỗi người chúng ta trong cuộc sống hằng ngày đều phải hình thành thói quen tốt tiết kiệm nước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '健全自然资源资产产权制度与生态产品价值实现机制，是统筹推进资源全面节约和集约循环利用的根本战略保障。',
        pinyin: 'Jiànquán zìrán zīyuán zīchǎn chǎnquán zhìdù yǔ shēngtài chǎnpǐn jiàzhí shíxiàn jīzhì, shì tǒngchóu tuījìn zīyuán quánmiàn jiéyuē hé jíyuē xúnhuán lìyòng de gēnběn zhànlüè bǎozhàng.',
        meaning_vi: 'Hoàn thiện chế độ quyền tài sản đối với tài sản tài nguyên thiên nhiên và cơ chế hiện thực hóa giá trị sản phẩm sinh thái là sự bảo đảm chiến lược căn bản để quy hoạch tổng thể thúc đẩy tiết kiệm toàn diện và sử dụng tuần hoàn tập trung tài nguyên.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3572,
    hanzi: '紫',
    pinyin: 'zǐ',
    word_type: 'Tính từ',
    meaning_vi: 'màu tím, tím',
    examples: [
      {
        chinese: '秋天到来时，公园小湖边的草地上盛开着一大片清新雅致的淡紫色薰衣草花海。',
        pinyin: 'Qiūtiān dàolái shí, gōngyuán xiǎohú biān de cǎodì shang shèngkāi zhe yí dà piàn qīngxīn yǎzhì de dànzǐsè xūnyīcǎo huāhǎi.',
        meaning_vi: 'Khi mùa thu đến, trên bãi cỏ ven hồ nhỏ công viên nở rộ một biển hoa oải hương màu tím nhạt thanh tân tao nhã.',
        difficulty_level: 'basic'
      },
      {
        chinese: '极紫外光刻机采用十三点五纳米极短波长脉冲等离子体光源，代表着人类超大规模集成电路制造工艺的巅峰技术水平。',
        pinyin: 'Jí-zǐwài guāngkèjī cǎiyòng shísān diǎn wǔ nàmǐ jí duǎn bōcháng màichōng děnglǐzǐtǐ guāngyuán, dàibiǎo zhe rénlèi chāo-dà-guīmó jíchéng-diànlù zhìzào gōngyì de diānfēng jìshù shuǐpíng.',
        meaning_vi: 'Máy quang khắc cực tím (EUV) sử dụng nguồn sáng plasma xung bước sóng cực ngắn 13.5 nanomet, đại diện cho trình độ công nghệ kỹ thuật đỉnh cao trong quy trình chế tạo mạch tích hợp quy mô siêu lớn của nhân loại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3573,
    hanzi: '子女',
    pinyin: 'zǐnǚ',
    word_type: 'Danh từ',
    meaning_vi: 'con cái, con trai con gái',
    examples: [
      {
        chinese: '父母含辛茹苦将子女抚养成人，作为子女理应常回家看看并孝敬长辈。',
        pinyin: 'Fùmǔ hánxīn-rǔkǔ jiāng zǐnǚ fǔyǎng chéngrén, zuòwéi zǐnǚ lǐyīng cháng huíjiā kànkan bìng xiàojìng zhǎngbèi.',
        meaning_vi: 'Cha mẹ ngậm đắng nuốt cay nuôi nấng con cái nên người, phận làm con lẽ đương nhiên phải thường xuyên về nhà thăm nom và hiếu kính các bậc bề trên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '完善生育支持政策体系包括大力发展普惠托育服务体系并全面减轻家庭在子女养育与优质教育方面的综合负担。',
        pinyin: 'Wánshàn shēngyù zhīchí zhèngcè tǐxì bāokuò dàlì fāzhǎn pǔhuì tuōyù fúwù tǐxì bìng quánmiàn jiǎnqīng jiātíng zài zǐnǚ yǎngyù yǔ yōuzhì jiàoyù fāngmiàn de zōnghé fùdān.',
        meaning_vi: 'Hoàn thiện hệ thống chính sách hỗ trợ sinh sản bao gồm việc phát triển mạnh mẽ hệ thống dịch vụ chăm sóc trẻ hòa nhập và giảm nhẹ toàn diện gánh nặng tổng hợp của gia đình trong nuôi dưỡng và giáo dục chất lượng cao cho con cái.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3574,
    hanzi: '自从',
    pinyin: 'zìcóng',
    word_type: 'Giới từ',
    meaning_vi: 'từ khi, kể từ khi',
    examples: [
      {
        chinese: '自从去年夏天参加了长跑健身俱乐部以后，他的体质明显变强了，很少再生病感冒。',
        pinyin: 'Zìcóng qùnián xiàtiān cānjiā le chángpǎo jiànshēn jùlèbù yǐhòu, tā de tǐzhì míngxiǎn biàn qiáng le, hěn shǎo zài shēngbìng gǎnmào.',
        meaning_vi: 'Kể từ khi tham gia câu lạc bộ thể hình chạy đường dài vào mùa hè năm ngoái, thể chất của anh ấy đã mạnh lên rõ rệt, rất ít khi còn bị ốm đau cảm cúm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '自从世界贸易组织确立多边争端解决机制以来，基于规则的国际经贸争端仲裁对防止全球单边贸易制裁升级起到了极其重要的护栏作用。',
        pinyin: 'Zìcóng Shìjiè Màoyì Zǔzhī quèlì duōbiān zhēngduān jiějué jīzhì yǐlái, jīyú guīzé de guójì jīng-mào zhēngduān zhòngcái duì fángzhǐ quánqiú dānbiān màoyì zhìcái shēngjí qǐdào le jíqí zhòngyào de hùlán zuòyòng.',
        meaning_vi: 'Kể từ khi Tổ chức Thương mại Thế giới xác lập cơ chế giải quyết tranh chấp đa phương, trọng tài tranh chấp kinh tế thương mại quốc tế dựa trên quy tắc đã phát huy tác dụng rào chắn bảo vệ cực kỳ quan trọng đối với việc ngăn ngừa sự leo thang cấm vận thương mại đơn phương toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3575,
    hanzi: '自动',
    pinyin: 'zìdòng',
    word_type: 'Phó từ / Tính từ',
    meaning_vi: 'tự động',
    examples: [
      {
        chinese: '商场入口处安装的感应式自动玻璃门极大方便了顾客推着购物车进出大厅。',
        pinyin: 'Shāngchǎng rùkǒuchù ānzhuāng de gǎnyìngshì zìdòng bōlímén jídà fāngbiàn le gùkè tuī zhe gòuwùchē jìnchū dàtīng.',
        meaning_vi: 'Cửa kính tự động dạng cảm ứng lắp đặt ở lối vào trung tâm thương mại đã tạo thuận lợi lớn cho khách hàng đẩy xe mua sắm ra vào sảnh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '深海油气开采浮式生产储卸油平台配备了全自动动态定位系统与井下紧急自动关断切断安全阀，确保在超强台风等恶劣海况下的作业安全性。',
        pinyin: 'Shēnhǎi yóu-qì kāicǎi fúshì shēngchǎn chǔ-xiè yóu píngtái pèibèi le quán-zìdòng dòngtài dìngwèi xìtǒng yǔ jǐngxià jǐnjí zìdòng guānduàn qiēduàn ānquánfá, quèbǎo zài chāo-qiáng táifēng děng èliè hǎikuàng xià de zuòyè ānquánxìng.',
        meaning_vi: 'Giàn khoan nổi sản xuất chứa và xuất dầu khí biển sâu được trang bị hệ thống định vị động học hoàn toàn tự động và van an toàn tự động ngắt khẩn cấp dưới giếng, bảo đảm an toàn tác nghiệp trong điều kiện biển động khắc nghiệt như siêu bão.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3576,
    hanzi: '自觉',
    pinyin: 'zìjué',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'tự giác, tự ý thức',
    examples: [
      {
        chinese: '在没有老师监考的情况下，同学们依然自觉遵守考场纪律，安静认真地答卷。',
        pinyin: 'Zài méiyǒu lǎoshī jiānkǎo de qíngkuàng xià, tóngxuémen yīrán zìjué zūnshǒu kǎochǎng jìlǜ, ānjìng rènzhēn de dájuàn.',
        meaning_vi: 'Trong tình huống không có giáo viên giám thị, các bạn học sinh vẫn tự giác tuân thủ kỷ luật phòng thi, làm bài một cách yên lặng và nghiêm túc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全体党员干部必须把纪律规矩挺在前面，强化自我约束意识并自觉接受党内监督、社会舆论监督和广大人民群众监督。',
        pinyin: 'Quántǐ dǎngyuán gànbù bìxū bǎ jìlǜ guīju tǐng zài qiánmiàn, qiánghuà zìwǒ yuēshù yìshí bìng zìjué jiēshòu dǎngrèi jiāndū, shèhuì yúlùn jiāndū hé guǎngdà rénmín qúnzhòng jiāndū.',
        meaning_vi: 'Toàn thể cán bộ đảng viên bắt buộc phải đặt kỷ luật kỷ cương lên hàng đầu, tăng cường ý thức tự kiềm chế và tự giác chấp nhận sự giám sát trong nội bộ Đảng, giám sát dư luận xã hội cùng sự giám sát của đông đảo quần chúng nhân dân.',
        difficulty_level: 'applied'
      }
    ]
  }
]
