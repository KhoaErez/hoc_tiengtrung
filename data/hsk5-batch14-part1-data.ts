// data/hsk5-batch14-part1-data.ts
// 25 từ HSK 5: #3302 [休闲] -> #3326 [延长]

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

export const HSK5_BATCH14_PART1: VocabItem[] = [
  {
    id: 3302,
    hanzi: '休闲',
    pinyin: 'xiūxián',
    word_type: 'Động từ / Danh từ / Tính từ',
    meaning_vi: 'nghỉ ngơi, an dưỡng; thư giãn, giải trí',
    examples: [
      {
        chinese: '经过一周紧张忙碌的工作，周末去郊野森林公园漫步是一种极好的休闲方式。',
        pinyin: 'Jīngguò yī zhōu jǐnzhāng mánglù de gōngzuò, zhōumò qù jiāoyě sēnlín gōngyuán mànbù shì yī zhǒng jí hǎo de xiūxián fāngshì.',
        meaning_vi: 'Trải qua một tuần làm việc căng thẳng và bận rộn, đi dạo ở công viên rừng ngoại ô vào dịp cuối tuần là một cách thư giãn giải trí vô cùng tuyệt vời.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着国民消费结构持续优化升级，生态旅游、健康养生与户外探险等高品质现代休闲产业迎来广阔的发展机遇。',
        pinyin: 'Suízhe guómín xiāofèi jiégòu chíxù yòuhuà shēngjí, shēngtài lǚyóu, jiànkāng yǎngshēng yǔ hùwài tànxiǎn děng gāopǐnzhì xiàndài xiūxián chǎnyè yínglái guǎngkuò de fāzhǎn jīyù.',
        meaning_vi: 'Cùng với sự tối ưu hóa và nâng cấp liên tục của cơ cấu tiêu dùng quốc dân, các ngành công nghiệp giải trí hiện đại chất lượng cao như du lịch sinh thái, chăm sóc sức khỏe và thám hiểm ngoài trời đang đón nhận những cơ hội phát triển rộng mở.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3303,
    hanzi: '需',
    pinyin: 'xū',
    word_type: 'Động từ',
    meaning_vi: 'cần, đòi hỏi, yêu cầu',
    examples: [
      {
        chinese: '如需进一步咨询有关课程的具体安排，请随时拨打教务处办公室的热线电话。',
        pinyin: 'Rú xū jìnyībù zīxún yǒuguān kèchéng de jùtǐ ānpái, qǐng suíshí bōdǎ jiàowùchù bàngōngshì de rèxiàn diànhuà.',
        meaning_vi: 'Nếu cần tư vấn thêm về các sắp xếp cụ thể của khóa học, xin vui lòng gọi vào đường dây nóng của văn phòng phòng đào tạo bất cứ lúc nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '先进制程高算力芯片研制需历经数万次物理仿真验证与严苛环境可靠性考核，方能满足航天级工业标准。',
        pinyin: 'Xiānjìn zhìchéng gāo-suànlì xīnpiàn yánzhì xū lìjīng shù wàn cì wùlǐ fāngzhēn yànzhèng yǔ yánkē huánjìng kěkàoxìng kǎohé, fāng néng mǎnzú hángtiānjí gōngyè biāozhǔn.',
        meaning_vi: 'Nghiên cứu chế tạo chip năng lực tính toán cao với quy trình tiên tiến đòi hỏi phải trải qua hàng vạn lần xác minh mô phỏng vật lý và khảo hạch độ tin cậy trong môi trường khắc nghiệt thì mới có thể đáp ứng được tiêu chuẩn công nghiệp cấp hàng không vũ trụ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3304,
    hanzi: '需求',
    pinyin: 'xūqiú',
    word_type: 'Danh từ',
    meaning_vi: 'nhu cầu',
    examples: [
      {
        chinese: '企业研发新产品应当始终以市场为导向，深入了解并切实满足消费者的多元化需求。',
        pinyin: 'Qǐyè yánfā xīn chǎnpǐn yīngdāng shǐzhōng yǐ shìchǎng wéi dǎoxiàng, shēnrù liǎojiě bìng qièshí mǎnzú xiāofèizhě de duōyuánhuà xūqiú.',
        meaning_vi: 'Doanh nghiệp khi nghiên cứu phát triển sản phẩm mới cần luôn lấy thị trường làm định hướng, tìm hiểu sâu sắc và đáp ứng thiết thực các nhu cầu đa dạng hóa của người tiêu dùng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '宏观调控部门围绕扩大有效投资与培育新型数字消费双向发力，切实解决国内有效需求不足的深层次结构性矛盾。',
        pinyin: 'Hóngguān tiáokòng bùmén wéirào kuòdà yǒuxiào tóuzī yǔ péiyù xīnxíng shùzì xiāofèi shuāngxiàng fālì, qièshí jiějué guónèi yǒuxiào xūqiú bùzú de shēncéngcì jiégòuxìng máodùn.',
        meaning_vi: 'Bộ phận điều tiết vĩ mô cùng lúc dồn lực vào việc mở rộng đầu tư hiệu quả và nuôi dưỡng tiêu dùng kỹ thuật số kiểu mới, giải quyết dứt điểm mâu thuẫn mang tính cơ cấu tầng sâu về việc thiếu hụt tổng cầu hiệu dụng trong nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3305,
    hanzi: '虚心',
    pinyin: 'xūxīn',
    word_type: 'Tính từ',
    meaning_vi: 'khiêm tốn, cầu thị, biết lắng nghe',
    examples: [
      {
        chinese: '“虚心使人进步，骄傲使人落后”，青年人在学业与工作中必须始终保持谦虚谨慎的态度。',
        pinyin: '“Xūxīn shǐ rén jìnbù, jiāo’ào shǐ rén luòhòu”, qīngniánrén zài xuéyè yǔ gōngzuò zhōng bìxū shǐzhōng bǎochí qiānxū jǐnshèn de tàidù.',
        meaning_vi: '"Khiêm tốn giúp người ta tiến bộ, kiêu ngạo làm người ta tụt lùi", thanh niên trong học tập và công tác bắt buộc phải luôn giữ vững thái độ khiêm nhường và thận trọng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '顶尖科研团队领军学者始终秉持虚心求知的学术胸襟，积极吸纳跨学科创新思想并勇于打破传统科学认知藩篱。',
        pinyin: 'Dǐngjiān kēyán tuánduì lǐngjūn xuézhě shǐzhōng bǐngchí xūxīn qiúzhī de xuéshù xiōngjīn, jījí xīnà kuà-xuékē chuàngxīn sīxiǎng bìng yǒngyú dǎpò chuántǒng kēxué rènzhī fānlí.',
        meaning_vi: 'Học giả đầu ngành dẫn dắt đội ngũ nghiên cứu đỉnh cao luôn giữ vững tâm thế học thuật khiêm tốn cầu thị, tích cực tiếp thu các luồng tư tưởng đổi mới liên ngành và dũng cảm đập tan các rào cản nhận thức khoa học truyền thống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3306,
    hanzi: '宣布',
    pinyin: 'xuānbù',
    word_type: 'Động từ',
    meaning_vi: 'tuyên bố, công bố',
    examples: [
      {
        chinese: '校长在全校师生开学典礼上庄严宣布，本届校园科技文化节正式拉开帷幕。',
        pinyin: 'Xiàozhǎng zài quánxiào shīshēng kāixué diǎnlǐ shàng zhuāngyán xuānbù, běnjiè xiàoyuán kējì wénhuàjié zhèngshì lākāi wéimù.',
        meaning_vi: 'Hiệu trưởng tại buổi lễ khai giảng của toàn thể thầy trò nhà trường đã trang trọng tuyên bố, ngày hội văn hóa khoa học công nghệ học đường năm nay chính thức mở màn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际顶尖科学学会正式宣布，由我国科学家主导的深空探测团队在火星地下水冰层结构探测中取得了里程碑式的重大科学发现。',
        pinyin: 'Guójì dǐngjí kēxué xuéhuì zhèngshì xuānbù, yóu wǒguó kēxuéjiā zhǔdǎo de shēnkōng tàncè tuánduì zài Huǒxīng dìxià shuǐbīngcéng jiégòu tàncè zhōng qǔdé le lǐchéngbēishì de zhòngdà kēxué fāxiàn.',
        meaning_vi: 'Hiệp hội khoa học đỉnh cao quốc tế chính thức tuyên bố, đội ngũ thám trắc không gian sâu do các nhà khoa học nước ta dẫn đầu đã đạt được phát hiện khoa học trọng đại mang tính cột mốc trong việc thăm dò cấu trúc tầng băng nước ngầm trên Sao Hỏa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3307,
    hanzi: '宣传',
    pinyin: 'xuānchuán',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'tuyên truyền, quảng bá',
    examples: [
      {
        chinese: '社区志愿者通过在各个楼道张贴宣传海报和发放折页，积极向居民普及垃圾分类知识。',
        pinyin: 'Shèqū zhìyuànzhě tōngguò zài gègè lóudào zhāngtiē xuānchuán hǎibào hé fāfàng zhéyè, jījí xiàng jūmín pǔjí lājī fēnlèi zhīshi.',
        meaning_vi: 'Các tình nguyện viên cộng đồng thông qua việc dán áp phích tuyên truyền ở các hành lang tòa nhà và phát tờ gấp đã tích cực phổ biến kiến thức phân loại rác cho cư dân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家卫生健康部门深入开展全国防灾减灾与健康素养宣传周活动，有力推动了突发公共卫生事件应急自救互救知识家喻户晓。',
        pinyin: 'Guójiā wèishēng jiànkāng bùmén shēnrù kāizhǎn quánguó fángzāi-jiǎnzāi yǔ jiànkāng sùyǎng xuānchuánzhōu huódòng, yǒulì tuīdòng le tūfā gōnggòng wèishēng shìjiàn yìngjí zìjiù-hùjiù zhīshi jiāyù-hùxiǎo.',
        meaning_vi: 'Cơ quan y tế và sức khỏe quốc gia đã triển khai sâu rộng tuần lễ tuyên truyền về phòng chống giảm nhẹ thiên tai và tố chất sức khỏe trên toàn quốc, thúc đẩy mạnh mẽ để kiến thức tự cứu và cứu giúp lẫn nhau trong các tình huống y tế công cộng khẩn cấp được mọi nhà mọi người thấu hiểu sâu sắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3308,
    hanzi: '选手',
    pinyin: 'xuǎnshǒu',
    word_type: 'Danh từ',
    meaning_vi: 'tuyển thủ, thí sinh tham gia thi đấu',
    examples: [
      {
        chinese: '来自全国数十所高校的优秀青年选手在创新创业大赛全国总决赛中展开了激烈角逐。',
        pinyin: 'Láizì quánguó shù shí suǒ gāoxiào de yōuxiù qīngnián xuǎnshǒu zài chuàngxīn chuàngyè dàsài quánguó zǒngjuésài zhōng zhǎnkāi le jīliè juézhú.',
        meaning_vi: 'Các thí sinh thanh niên ưu tú đến từ hàng chục trường đại học trên cả nước đã mở màn cuộc tranh tài nảy lửa tại vòng chung kết toàn quốc cuộc thi đổi mới khởi nghiệp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '经过严酷极限过载耐受、深水失重训练以及心理素质综合考核，数名优秀航天员选手入选载人登月关键工程飞行乘组梯队。',
        pinyin: 'Jīngguò yánkù jíduān guòzài nàishòu, shēnshuǐ shīzhòng xùnliàn yǐjí xīnlǐ sùzhì zōnghé kǎohé, shù míng yōuxiù hángtiānyuán xuǎnshǒu rùxuǎn zàirén dēngyuè guānjiàn gōngchéng fēixíng chéngzǔ tīduì.',
        meaning_vi: 'Trải qua các kỳ sát hạch tổng hợp về chịu đựng tải trọng quá mức cực đoan khắc nghiệt, huấn luyện không trọng lượng dưới nước sâu và phẩm chất tâm lý, nhiều tuyển thủ phi hành gia ưu tú đã trúng tuyển vào đội hình phi hành đoàn cho công trình trọng điểm đưa người đổ bộ lên mặt trăng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3309,
    hanzi: '学分',
    pinyin: 'xuéfēn',
    word_type: 'Danh từ',
    meaning_vi: 'tín chỉ học tập, điểm học phần',
    examples: [
      {
        chinese: '本科生必须在规定的四至六年弹性学制之内，修满专业培养方案所要求的全部必修与选修学分。',
        pinyin: 'Běnkēshēng bìxū zài guīdìng de sì zhì liù nián tánxìng xuézhì zhīnèi, xiū mǎn zhuānyè péiyǎng fāng’àn suǒ yāoqiú de quánbù bìxiū yǔ xuǎnxiū xuéfēn.',
        meaning_vi: 'Sinh viên đại học chính quy bắt buộc phải tích lũy đủ toàn bộ số tín chỉ bắt buộc và tự chọn theo yêu cầu của chương trình đào tạo chuyên ngành trong khung thời gian đào tạo mềm dẻo từ 4 đến 6 năm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '一流大学联盟全面推行跨校跨学科课程资源互选与学分互认机制，为复合型基础拔尖科研人才的自由成长拆除专业壁垒。',
        pinyin: 'Yīliú dàxué liánméng quánmiàn tuīxíng kuà-xiào kuà-xuékē kèchéng zīyuán hùxuǎn yǔ xuéfēn hùrèn jīzhì, wèi fùhéxíng jīchǔ bájiān kēyán réncái de zìyóu chéngzhǎng chāichú zhuānyè bìlěi.',
        meaning_vi: 'Liên minh các trường đại học hàng đầu triển khai toàn diện cơ chế chọn môn học chéo giữa các trường và liên ngành cùng công nhận tín chỉ lẫn nhau, gỡ bỏ các rào cản chuyên ngành để các tài nhân nghiên cứu khoa học xuất sắc đa lĩnh vực phát triển tự do.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3310,
    hanzi: '学科',
    pinyin: 'xuékē',
    word_type: 'Danh từ',
    meaning_vi: 'ngành học, môn học, bộ môn khoa học',
    examples: [
      {
        chinese: '他在大学期间主修软件工程，课余时间还自主选修了应用心理学与管理学等跨领域学科。',
        pinyin: 'Tā zài dàxué qījiān zhǔxiū ruǎnjiàn gōngchéng, kèyú shíjiān hái zìzhǔ xuǎnxiū le yìngyòng xīnlǐxué yǔ guǎnlǐxué děng kuà-lǐngyù xuékē.',
        meaning_vi: 'Thời đại học anh ấy theo học chuyên ngành chính là kỹ thuật phần mềm, thời gian ngoài giờ còn tự giác chọn học thêm các môn học liên lĩnh vực như tâm lý học ứng dụng và khoa học quản lý.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家“双一流”战略全面统筹推进基础前沿学科、战略新兴交叉学科与关键急需工程学科的一体化协同发展与布局。',
        pinyin: 'Guójiā “shuāng-yīliú” zhànlüè quánmiàn tǒngchóu tuījìn jīchǔ qiányán xuékē, zhànlüè xīnxīng jiāochā xuékē yǔ guānjiàn jíxū gōngchéng xuékē de yītǐhuà xiétóng fāzhǎn yǔ bùjú.',
        meaning_vi: 'Chiến lược "Song nhất lưu" quốc gia quy hoạch điều phối toàn diện sự phát triển hiệp đồng và bố trí tích hợp giữa các ngành học cơ sở tiền duyên, ngành học giao thoa mới nổi mang tính chiến lược và các ngành kỹ thuật công trình trọng điểm cấp thiết.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3311,
    hanzi: '学历',
    pinyin: 'xuélì',
    word_type: 'Danh từ',
    meaning_vi: 'trình độ học vấn, văn bằng chứng chỉ',
    examples: [
      {
        chinese: '在选拔优秀人才时，用人单位既要考察应聘者的学历文凭，更要综合评估其实际工作技能与职业素养。',
        pinyin: 'Zài xuǎnbá yōuxiù réncái shí, yòngrén dānwèi jì yào kǎochá yìngpìnzhě de xuélì wénpíng, gèng yào zōnghé pínggū qí shíjì gōngzuò jìnéng yǔ zhíyè sùyǎng.',
        meaning_vi: 'Khi tuyển chọn nhân tài ưu tú, đơn vị tuyển dụng vừa cần xem xét văn bằng học vấn của ứng viên, lại càng phải đánh giá tổng hợp về kỹ năng làm việc thực tế và tố chất nghề nghiệp của họ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代科技人才评价改革坚决破除唯论文、唯帽子、唯职称、唯学历的固化痼疾，建立健全以实际创新贡献为核心的科学导向。',
        pinyin: 'Xiàndài kējì réncái píngjià gǎigé jiānjué pòchú wéi lùnwén, wéi màozi, wéi zhíchēng, wéi xuélì de gùhuà gùjí, jiànlì jiànquán yǐ shíjì chuàngxīn gòngxiàn wéi héxīn de kēxué dǎoxiàng.',
        meaning_vi: 'Cải cách đánh giá nhân tài khoa học công nghệ hiện đại kiên quyết xóa bỏ các căn bệnh cố hữu coi trọng duy nhất luận văn, học hàm, chức danh, bằng cấp học vấn, xây dựng hoàn thiện định hướng khoa học lấy đóng góp đổi mới sáng tạo thực tế làm hạt nhân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3312,
    hanzi: '学年',
    pinyin: 'xuénián',
    word_type: 'Danh từ',
    meaning_vi: 'năm học, niên khóa',
    examples: [
      {
        chinese: '崭新的学年伊始，大学校园里迎来了数千名满怀青春理想与求知热忱的青年新生。',
        pinyin: 'Zhǎnxīn de xuénián yīshǐ, dàxué xiàoyuán lǐ yínglái le shù qiān míng mǎnhuái qīngchūn lǐxiǎng yǔ qiúzhī rèchén de qīngnián xīnshēng.',
        meaning_vi: 'Niên khóa mới toanh vừa bắt đầu, khuôn viên trường đại học đã đón chào hàng nghìn bạn tân sinh viên trẻ tuổi ngập tràn lý tưởng thanh xuân và nhiệt huyết cầu tri thức.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高校在每一学年终了全面实施教学质量全要素常态化评估，紧密跟踪学科课程设置的实际前沿适应性与师生满意度。',
        pinyin: 'Gāoxiào zài měi yī xuénián zhōngliǎo quánmiàn shíshī jiàoxué zhìliàng quán-yàosù chángtàihuà pínggū, jǐnmì gēnzōng xuékē kèchéng shèzhì de shíjì qiányán shìyìngxìng yǔ shī-shēng mǎnyìdù.',
        meaning_vi: 'Các trường đại học khi kết thúc mỗi năm học đều thực thi toàn diện việc đánh giá thường thái hóa mọi yếu tố chất lượng giảng dạy, theo dõi sát sao tính thích ứng tiền duyên thực tế của chương trình môn học và mức độ hài lòng của giảng viên, sinh viên.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3313,
    hanzi: '学术',
    pinyin: 'xuéshù',
    word_type: 'Danh từ',
    meaning_vi: 'học thuật, nghiên cứu học thuật',
    examples: [
      {
        chinese: '这场高规格的国际学术研讨会汇聚了来自海内外数十所顶尖高校的权威教授与优秀学者。',
        pinyin: 'Zhè chǎng gāoguīgé de guójì xuéshù yántǎohuì huìjù le láizì hǎinèiwài shù shí suǒ dǐngjiān gāoxiào de quánwēi jiàoshòu yǔ yōuxiù xuézhě.',
        meaning_vi: 'Hội thảo học thuật quốc tế quy mô cao này quy tụ các giáo sư uy tín và học giả ưu tú đến từ hàng chục trường đại học hàng đầu trong và ngoài nước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高等学术研究机构必须坚守严谨求实的科学精神与学术道德底线，对任何抄袭造假等学术不端行为实行一票否决制。',
        pinyin: 'Gāoděng xuéshù yánjiū jīgòu bìxū jiānshǒu yánjǐn qiúshí de kēxué jīngshén yǔ xuéshù dàodé dǐxiàn, duì rènhé chāoxí zàojiǎ děng xuéshù bùduān xíngwéi shíxíng yīpiào fǒujuézhì.',
        meaning_vi: 'Các viện cơ quan nghiên cứu học thuật bậc cao bắt buộc phải giữ vững tinh thần khoa học cẩn trọng thực tế và lằn ranh đỏ đạo đức học thuật, thực thi cơ chế một phiếu phủ quyết đối với mọi hành vi sai trái trong học thuật như đạo văn hay ngụy tạo số liệu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3314,
    hanzi: '学者',
    pinyin: 'xuézhě',
    word_type: 'Danh từ',
    meaning_vi: 'học giả, nhà nghiên cứu',
    examples: [
      {
        chinese: '这位德高望重的老学者毕生潜心于中国古代文史典籍的整理与考据，著作等身。',
        pinyin: 'Zhè wèi dégāo-wàngzhòng de lǎo xuézhě bìshēng qiǎnxīn yú Zhōngguó gǔdài wén-shǐ diǎnjí de zhěnglǐ yǔ kǎojù, zhùzuò-děngshēn.',
        meaning_vi: 'Vị học giả lão thành đức cao vọng trọng này cả đời dốc lòng cho công tác chỉnh lý và khảo chứng văn tịch lịch sử cổ đại Trung Hoa, tác phẩm xuất bản nhiều khôn xiết.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际宏观经济论坛邀请全球一流经济学家与资深战略学者开展跨界圆桌对话，为全球产业链供应链韧性提升贡献智慧方案。',
        pinyin: 'Guójì hóngguān jīngjì lùntán yāoqǐng quánqiú yīliú jīngjìxuéjiā yǔ zīshēn zhànlüè xuézhě kāizhǎn kuàjiè yuánzhuō duìhuà, wèi quánqiú chǎnyèliàn gōngyìngliàn rènxìng tíshēng gòngxiàn zhìhuì fāng’àn.',
        meaning_vi: 'Diễn đàn kinh tế vĩ mô quốc tế mời các nhà kinh tế học hạng nhất toàn cầu và các học giả chiến lược lâu năm mở màn cuộc đối thoại bàn tròn xuyên biên giới, đóng góp các phương án trí tuệ để nâng cao độ bền vững cho chuỗi cung ứng và chuỗi công nghiệp thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3315,
    hanzi: '雪糕',
    pinyin: 'xuěgāo',
    word_type: 'Danh từ',
    meaning_vi: 'que kem, kem cây, kem que',
    examples: [
      {
        chinese: '炎热难耐的夏日午后，吃上一根清凉甜润的鲜奶雪糕总能让人瞬间感到无比惬意。',
        pinyin: 'Yánrè nánnài de xiàrì wǔhòu, chī shàng yī gēn qīngliáng tiánrùn de xiānnǎi xuěgāo zǒng néng ràng rén shùnjiān gǎndào wúbǐ qièyì.',
        meaning_vi: 'Buổi trưa hè nóng nực khó chịu, ăn một que kem sữa tươi thanh mát ngọt dịu luôn khiến người ta ngay lập tức cảm thấy vô cùng khoan khoái.',
        difficulty_level: 'basic'
      },
      {
        chinese: '传统冷饮制造龙头企业深度融合天然草本果萃与现代低温锁鲜工艺，创新推出了多款富含益生菌且低糖低脂的健康文创国风雪糕。',
        pinyin: 'Chuántǒng lěngyǐn zhìzào lóngtóu qǐyè shēndù rónghé tiānrán cǎoběn guǒcuì yǔ xiàndài dīwēn suǒxiān gōngyì, chuàngxīn tuīchū le duō kuǎn fùhán yìshēngjùn qiě dītáng dīzhī de jiànkāng wénchuàng guófēng xuěgāo.',
        meaning_vi: 'Doanh nghiệp đầu ngành sản xuất đồ uống lạnh truyền thống kết hợp sâu sắc chiết xuất trái cây thảo mộc tự nhiên với công nghệ khóa tươi nhiệt độ thấp hiện đại, cho ra mắt nhiều mẫu kem que phong cách văn hóa truyền thống tốt cho sức khỏe giàu men vi sinh, ít đường và ít béo.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3316,
    hanzi: '询问',
    pinyin: 'xúnwèn',
    word_type: 'Động từ',
    meaning_vi: 'hỏi thăm, tra hỏi, dò hỏi, thăm hỏi',
    examples: [
      {
        chinese: '初次到访这座陌生城市的游客走上前台，礼貌地向工作人员询问前往地铁枢纽的步行路线。',
        pinyin: 'Chūcì dàofǎng zhè zuò mòshēng chéngshì de yóukè zǒu shàng qiántái, lǐmào de xiàng gōngzuò rényuán xúnwèn qiánwǎng dìtiě shūniǔ de bùxíng lùxiàn.',
        meaning_vi: 'Du khách lần đầu tới thăm thành phố xa lạ này bước lên quầy tiếp tân, lịch sự hỏi thăm nhân viên về tuyến đường đi bộ đến đầu mối tàu điện ngầm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '临床资深专科主治医师在接诊罕见病患者时极其耐心细致地询问其家族遗传史与用药史，为制定个性化精准靶向治疗策略掌握一手依据。',
        pinyin: 'Línchuáng zīshēn zhuānkē zhǔzhì yīshī zài jiēzhěn hǎnjiànbìng huànzhě shí jíqí nàixīn xìzhì de xúnwèn qí jiāzú yíchuánshǐ yǔ yòngyàoshǐ, wèi zhìdìng gèxìnghuà jīngzhǔn bǎxiàng zhìliáo cèlüè zhǎngwò yīshǒu yījù.',
        meaning_vi: 'Bác sĩ chuyên khoa chính giàu kinh nghiệm lâm sàng khi tiếp nhận bệnh nhân mắc bệnh hiếm đã vô cùng kiên nhẫn và tỉ mỉ thăm hỏi về tiền sử di truyền gia đình và tiền sử dùng thuốc, nhằm nắm bắt căn cứ thực tế trực tiếp để đưa ra chiến lược điều trị đích chính xác mang tính cá nhân hóa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3317,
    hanzi: '寻找',
    pinyin: 'xúnzhǎo',
    word_type: 'Động từ',
    meaning_vi: 'tìm kiếm, tìm tòi',
    examples: [
      {
        chinese: '面对充满未知的职业生涯未来，青年人应当在踏实的社会实践中不断寻找属于自己的人生奋斗方向。',
        pinyin: 'Miànduì chōngmǎn wèizhī de zhíyè shēngyá wèilái, qīngniánrén yīngdāng zài tàshi de shèhuì shíjiàn zhōng bùduàn xúnzhǎo shǔyú zìjǐ de rénshēng fèndòu fāngxiàng.',
        meaning_vi: 'Trước tương lai sự nghiệp đầy những điều chưa biết, thanh niên nên liên tục tìm kiếm phương hướng phấn đấu cuộc đời thuộc về chính mình trong các hoạt động thực tiễn xã hội vững chắc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '射电天文学国际合作团队利用五百米口径球面射电望远镜，在浩瀚宇宙深处持续寻找并系统证认超高精度毫秒脉冲星。',
        pinyin: 'Shèdiàn tiānwénxué guójì hézuò tuánduì lìyòng wǔbǎi mǐ kǒujìng qiúmiàn shèdiàn wàngyuǎnjìng, zài hàohàn yǔzhòu shēncù chíxù xúnzhǎo bìng xìtǒng zhèngrèn chāogāojīngdù háomiǎo màichōngxīng.',
        meaning_vi: 'Đội ngũ hợp tác quốc tế về thiên văn vô tuyến tận dụng kính thiên văn vô tuyến hình cầu khẩu độ 500 mét (FAST) để liên tục tìm kiếm và kiểm chứng có hệ thống các pulsar mili giây độ chính xác siêu cao nơi sâu thẳm vũ trụ bao la.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3318,
    hanzi: '训练',
    pinyin: 'xùnliàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'huấn luyện, rèn luyện; bài tập huấn luyện',
    examples: [
      {
        chinese: '国家体育代表队选手每天清晨都会在运动场上坚持进行长达数小时的高强度体能与战术战役训练。',
        pinyin: 'Guójiā tǐyù dàibiǎoduì xuǎnshǒu měitiān qīngchén dōu huì zài yùndòngchǎng shàng jiānchí jìnxíng chángdá shù xiǎoshí de gāomiángdù tǐnéng yǔ zhànshù zhànyì xùnliàn.',
        meaning_vi: 'Các tuyển thủ đội tuyển thể thao quốc gia mỗi sáng sớm đều kiên trì rèn luyện thể lực cường độ cao và kỹ chiến thuật kéo dài nhiều giờ liền trên sân vận động.',
        difficulty_level: 'basic'
      },
      {
        chinese: '人工智能基础大模型研发团队依托万卡异构算力集群，通过千亿级高质量多模态语料对通用深度学习网络模型展开分布式预训练。',
        pinyin: 'Réngōng zhìnéng jīchǔ dà móxíng yánfā tuánduì yītuō wànkǎ yìgòu suànlì jíqún, tōngguò qiān-yì jí gāozhìliàng duōmótài yǔliào duì tōngyòng shēndù xuéxí wǎngluò móxíng zhǎnkāi fēnbùshì yù-xùnliàn.',
        meaning_vi: 'Đội ngũ R&D mô hình nền tảng trí tuệ nhân tạo lớn dựa vào cụm tính toán dị cấu hàng vạn GPU, sử dụng kho ngữ liệu đa phương thức chất lượng cao cấp hàng trăm tỷ để triển khai tiền huấn luyện phân tán cho mô hình mạng học sâu đa năng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3319,
    hanzi: '迅速',
    pinyin: 'xùnsù',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'nhanh chóng, mau lẹ, thần tốc',
    examples: [
      {
        chinese: '突发火情报警电话打响之后，专业消防救援支队迅速出警赶赴现场，仅用十多分钟就扑灭了火势。',
        pinyin: 'Tūfā huǒqíng bàojǐng diànhuà dǎxiǎng zhīhòu, zhuānyè xiāofáng jiùyuán zhīduì xùnsù chūjǐng gǎnfù xiànchǎng, jǐn yòng shí duō fēnzhōng jiù pūmiè le huǒshì.',
        meaning_vi: 'Sau khi cuộc gọi báo cháy khẩn cấp đổ chuông, chi đội cứu hỏa cứu nạn chuyên nghiệp đã nhanh chóng xuất kích tới hiện trường, chỉ mất hơn mười phút đã dập tắt ngọn lửa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对严峻复杂的全球产业链断供潜在风险，高科技制造领军企业迅速启动核心零部件多源冗余备份采购与国产化替代方案。',
        pinyin: 'Miànduì yánjùn fùzá de quánqiú chǎnyèliàn duàngōng qiánzài fēngxiǎn, gāokējì zhìzào lǐngjūn qǐyè xùnsù qǐdòng héxīn língbùjiàn duōyuán rǒngyú bèifèn cǎigòu yǔ guóchǎnhuà tìdài fāng’àn.',
        meaning_vi: 'Trước rủi ro tiềm ẩn đứt gãy chuỗi công nghiệp toàn cầu gay gắt phức tạp, doanh nghiệp dẫn đầu chế tạo công nghệ cao đã nhanh chóng kích hoạt phương án thu mua dự phòng đa nguồn linh kiện cốt lõi và lộ trình thay thế nội địa hóa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3320,
    hanzi: '呀',
    pinyin: 'yā',
    word_type: 'Thán từ',
    meaning_vi: 'a, á, ôi (thán từ biểu thị ngạc nhiên, cảm thán)',
    examples: [
      {
        chinese: '呀，今天的清晨空气如此清新甜润，正是约上朋友去郊外绿道骑行的好时光！',
        pinyin: 'Yā, jīntiān de qīngchén kōngqì rúcǐ qīngxīn tiánrùn, zhèng shì yuē shàng péngyou qù jiāowài lǜdào qíxíng de hǎo shíguāng!',
        meaning_vi: 'A, không khí sáng sớm hôm nay trong lành và mát mẻ quá đỗi, đúng là khoảng thời gian tuyệt vời để hẹn bạn bè đạp xe trên đường xanh ngoại ô!',
        difficulty_level: 'basic'
      },
      {
        chinese: '呀，实验舱的超快激光光谱反馈数值居然与经典理论模型存在显著量级跃迁偏差，科研人员当即决定连夜复核校准实验设备！',
        pinyin: 'Yā, shíyàncāng de chāokuài jīguāng guāngpǔ fǎnkuì shùzhí jūrán yǔ jīngdiǎn lǐlùn móxíng cúnzài xiǎnzhù liàngjí yuèqiān piānchā, kēyán rényuán dāngjí juédìng liányè fùhé jiàozhǔn shíyàn shèbèi!',
        meaning_vi: 'Á, chỉ số phản hồi quang phổ laser siêu nhanh trong khoang thí nghiệm vậy mà lại sai lệch một cấp độ đáng kể so với mô hình lý thuyết kinh điển, các nhà khoa học lập tức quyết định thức thâu đêm để kiểm tra lại và hiệu chuẩn thiết bị thí nghiệm!',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3321,
    hanzi: '押金',
    pinyin: 'yājīn',
    word_type: 'Danh từ',
    meaning_vi: 'tiền đặt cọc, tiền thế chân',
    examples: [
      {
        chinese: '在办理公寓租赁手续或租借户外骑行设备时，通常需要向管理方预先支付一定数额的押金。',
        pinyin: 'Zài bànlǐ gōngyù zūlìn shǒuxù huò zūjiè hùwài qíxíng shèbèi shí, tōngcháng xūyào xiàng guǎnlǐfāng yùxiān zhīfù yīdìng shù’é de yājīn.',
        meaning_vi: 'Khi làm thủ tục thuê căn hộ hoặc thuê dụng cụ đạp xe ngoài trời, thông thường cần phải trả trước một khoản tiền đặt cọc nhất định cho ban quản lý.',
        difficulty_level: 'basic'
      },
      {
        chinese: '住房租赁行业综合治理法规明确规定，长租公寓运营机构向承租人收取的租金与押金必须全额存入指定商业银行的第三方专项监管账户。',
        pinyin: 'Zhùfáng zūlìn hángyè zōnghé zhìlǐ fǎguī míngquè guīdìng, chángzū gōngyù yùnyíng jīgòu xiàng chéngzūrén shōuqǔ de zūjīn yǔ yājīn bìxū quán’é cúnrù zhǐdìng shāngyè yínháng de dìsānfāng zhuānxiàng jiānguǎn zhànghù.',
        meaning_vi: 'Quy chuẩn pháp lý quản trị tổng hợp ngành cho thuê nhà ở quy định rõ ràng, tiền thuê và tiền cọc mà đơn vị vận hành căn hộ cho thuê dài hạn thu từ bên thuê bắt buộc phải nộp toàn bộ vào tài khoản giám sát chuyên dụng của bên thứ ba tại ngân hàng thương mại được chỉ định.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3322,
    hanzi: '压岁钱',
    pinyin: 'yāsuìqián',
    word_type: 'Danh từ',
    meaning_vi: 'tiền mừng tuổi, tiền lì xì đầu năm',
    examples: [
      {
        chinese: '除夕夜吃完团圆年夜饭之后，长辈们按照传统习俗将崭新的压岁钱装在喜庆的红信封里送给孩子们。',
        pinyin: 'Chúxīyè chī wán tuányuán niányèfàn zhīhòu, zhǎngbèimen ànzhào chuántǒng xísú jiāng zhǎnxīn de yāsuìqián zhuāng zài xǐqìng de hóng xìnfēng lǐ sòng gěi háizimen.',
        meaning_vi: 'Đêm giao thừa sau khi ăn xong bữa cơm tất niên đoàn viên, các bậc tiền bối theo phong tục truyền thống bỏ những tờ tiền mừng tuổi mới tinh vào phong bao đỏ mừng vui gửi tặng cho các cháu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '金融机构针对未成年人财商启蒙教育研发专属亲子理财定投账户，科学引导青少年将春节收到的压岁钱合理配置于长周期教育储蓄。',
        pinyin: 'Jīnróng jīgòu zhènduì wèichéngniánrén cáishāng qǐméng jiàoyù yánfā zhuānshǔ qīnzǐ lǐcái dìngtóu zhànghù, kēxué yǐndǎo qīngshàonián jiāng Chúnjié shōudào de yāsuìqián hélǐ pèizhì yú cháng-zhōuqī jiàoyù chǔxù.',
        meaning_vi: 'Các tổ chức tài chính đã nghiên cứu phát triển tài khoản đầu tư định kỳ quản lý tài chính cha mẹ - con cái chuyên biệt nhằm khai sáng giáo dục tư duy tài chính cho người chưa thành niên, hướng dẫn khoa học để thanh thiếu niên phân bổ hợp lý số tiền mừng tuổi nhận được trong dịp Tết vào các quỹ tiết kiệm giáo dục chu kỳ dài.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3323,
    hanzi: '鸭子',
    pinyin: 'yāzi',
    word_type: 'Danh từ',
    meaning_vi: 'con vịt',
    examples: [
      {
        chinese: '初春暖阳照耀下的湖面上水波粼粼，一群活泼可爱的小鸭子正欢快地在荷叶间游来游去觅食。',
        pinyin: 'Chūchūn nuǎnyáng zhàoyào xià de húmiàn shàng shuǐbō línlín, yī qún huópo kě’ài de xiǎo yāzi zhèng huānkuài de zài héyè jiān yóu lái yóu qù mìshí.',
        meaning_vi: 'Mặt hồ lấp lánh sóng nước dưới ánh nắng xuân ấm áp, một đàn vịt con hoạt bát đáng yêu đang tung tăng bơi qua bơi lại giữa các tán lá sen để kiếm mồi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代生态循环农业示范基地大力推行“稻鸭共生”高效生态农业模式，利用鸭子全天候啄食害虫与杂草，全面降低农药与化肥投入。',
        pinyin: 'Xiàndài shēngtài xúnhuán nóngyè shìfàn jīdì dàlì tuīxíng “dào-yā gòngshēng” gāoxiào shēngtài nóngyè móshì, lìyòng yāzi quántiānhòu zhuóshí hàichóng yǔ záocǎo, quánmiàn jiàngdī nóngyào yǔ huàféi tóurù.',
        meaning_vi: 'Khu căn cứ kiểu mẫu nông nghiệp tuần hoàn sinh thái hiện đại đẩy mạnh nhân rộng mô hình nông nghiệp sinh thái hiệu quả cao "lúa - vịt cùng sinh", tận dụng vịt ăn sâu bọ hại lúa và cỏ dại suốt ngày đêm, cắt giảm toàn diện lượng phân bón hóa học và thuốc bảo vệ thực vật đầu vào.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3324,
    hanzi: '牙齿',
    pinyin: 'yáchǐ',
    word_type: 'Danh từ',
    meaning_vi: 'răng, hàm răng',
    examples: [
      {
        chinese: '每天早晚认真用软毛牙刷刷牙并配合使用牙线清洁牙缝，是保护牙齿健康、预防口腔疾病的根本方法。',
        pinyin: 'Měitiān zǎowǎn rènzhēn yòng ruǎnmáo yáshuā shuāyá bìng pèihé shǐyòng yáxiàn qīngjié yáfèng, shì bǎohù yáchǐ jiànkāng, yùfáng kǒuqiāng jíbìng de gēnběn fāngfǎ.',
        meaning_vi: 'Mỗi ngày sáng tối đánh răng kỹ lưỡng bằng bàn chải lông mềm và kết hợp dùng chỉ nha khoa làm sạch kẽ răng chính là phương pháp căn bản để bảo vệ sức khỏe hàm răng và phòng ngừa các bệnh răng miệng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代数字化口腔修复临床广泛应用口内高精度三维激光扫描与全瓷义齿微雕技术，实现了缺损牙齿的微创解剖形态重建与生物力学仿生。',
        pinyin: 'Xiàndài shùzìhuà kǒuqiāng xiūfù línchuáng guǎngfàn yìngyòng kǒunèi gāojīngdù sānwéi jīguāng sǎomiáo yǔ quáncí yìchǐ wēidiāo jìshù, shíxiàn le quēsǔn yáchǐ de wēichuàng jiěpōu xíngtài chóngjiàn yǔ shēngwùlìxué fǎngshēng.',
        meaning_vi: 'Lâm sàng phục hình răng miệng số hóa hiện đại ứng dụng rộng rãi công nghệ quét laser 3D độ chính xác cao trong khoang miệng và kỹ thuật vi điêu khắc răng giả toàn sứ, giúp hiện thực hóa việc tái tạo giải phẫu hình thái xâm lấn tối thiểu và phỏng sinh học cơ sinh học cho răng bị tổn khuyết.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3325,
    hanzi: '沿',
    pinyin: 'yán',
    word_type: 'Giới từ / Động từ / Danh từ',
    meaning_vi: 'men theo, dọc theo; bờ, mép',
    examples: [
      {
        chinese: '傍晚夕阳西下，三三两两的市民们喜欢沿风景秀美的江滨景观长廊悠闲散步。',
        pinyin: 'Bàngwǎn xīyáng xī xià, sānsānlǐǎnglǐǎng de shìmínmen xǐhuan yán fēngjǐng xiùměi de jiāngbīn jǐngguān chángláng yōuxián sànbù.',
        meaning_vi: 'Chiều tà bóng hoàng hôn dần lặn về tây, từng tốp hai ba người dân thành phố thích thú tản bộ dọc theo hành lang cảnh quan ven sông phong cảnh tú lệ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高水平对外开放战略深度赋能我国沿边沿海经济开放带建设，依托自贸试验区制度集成创新打造海陆内外联动的新发展格局。',
        pinyin: 'Gāoshuǐpíng duìwài kāifàng zhànlüè shēndù fùnéng wǒguó yánbiān yánhǎi jīngjì kāifàngdài jiànshè, yītuō zìmào shìyànqū zhìdù jíchéng chuàngxīn dǎzào hǎilù nèiwài liándòng de xīn fāzhǎn géjú.',
        meaning_vi: 'Chiến lược mở cửa đối ngoại tiêu chuẩn cao tạo động lực sâu sắc cho việc xây dựng vành đai mở cửa kinh tế ven biển ven biên giới của nước ta, dựa vào đổi mới tích hợp thể chế của khu thương mại tự do thí điểm để kiến tạo cục diện phát triển mới liên kết trong ngoài trên biển dưới đất liền.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3326,
    hanzi: '延长',
    pinyin: 'yáncháng',
    word_type: 'Động từ',
    meaning_vi: 'kéo dài, gia hạn, tăng thêm thời gian',
    examples: [
      {
        chinese: '为了极大方便市民在重大节假日期间的夜间出行，城市公共交通部门决定将地铁末班车运营时间延长一小时。',
        pinyin: 'Wèile jídà biànlì shìmín zài zhòngdà jiérì qījiān de yèjiān chūxíng, chéngshì gōnggòng jiāotōng bùmén juédìng jiāng dìtiě mòbānchē yùnyíng shíjiān yáncháng yī xiǎoshí.',
        meaning_vi: 'Nhằm tạo thuận lợi tối đa cho việc đi lại ban đêm của người dân trong các dịp lễ tết trọng đại, cơ quan giao thông công cộng thành phố quyết định kéo dài thời gian vận hành chuyến tàu điện ngầm cuối cùng thêm một giờ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家知识产权行政主管机关依法批准，对用于治疗重大难治性疾病的自主原研创新靶向药物发明专利权给予最长五年的期限补偿延长。',
        pinyin: 'Guójiā zhīshi chǎnquán xíngzhèng zhǔguǎn jīgòu yīfǎ pīzhǔn, duì yòng yú zhìliáo zhòngdà nánzhìxìng jíbìng de zìzhǔ yuányán chuàngxīn bǎxiàng yàowù fāmíng zhuānlìquán jǐyǔ zuì cháng wǔ nián de qīxiàn bǔcháng yáncháng.',
        meaning_vi: 'Cơ quan quản lý hành chính sở hữu trí tuệ quốc gia căn cứ theo pháp luật phê chuẩn việc cấp bù gia hạn thời hạn bảo hộ quyền sáng chế tối đa năm năm cho các bằng sáng chế thuốc trúng đích đổi mới nguyên bản tự chủ dùng trong điều trị các căn bệnh nan y trọng đại.',
        difficulty_level: 'applied'
      }
    ]
  }
]
