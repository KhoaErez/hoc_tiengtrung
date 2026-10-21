// data/hsk5-batch6-part4-data.ts
// 25 từ HSK 5: #2577 [建设] -> #2601 [结构]

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

export const HSK5_BATCH6_PART4: VocabItem[] = [
  {
    id: 2577,
    hanzi: '建设',
    pinyin: 'jiànshè',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'xây dựng, kiến thiết; công cuộc xây dựng',
    examples: [
      {
        chinese: '全镇居民正齐心协力投入到美丽乡村的建设当中。',
        pinyin: 'Quán zhèn jūmín zhèng qíxīn-xiélì tóurù dào měilì xiāngcūn de jiànshè dāngzhōng.',
        meaning_vi: 'Toàn thể cư dân trong thị trấn đang đồng lòng chung sức dấn thân vào công cuộc xây dựng nông thôn tươi đẹp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家统筹推进新型数字基础设施建设，加快布局第五代移动通信基站、超算中心与工业互联网平台。',
        pinyin: 'Guójiā tǒngchóu tuījìn xīnxíng shùzì jīchǔ shèshī jiànshè, jiākuài bùjú dì-wǔ dài yídòng tōngxìn jīzhàn, chāosuàn zhōngxīn yǔ gōngyè hùliánwǎng píngtái.',
        meaning_vi: 'Nhà nước quy hoạch tổng thể đẩy mạnh việc xây dựng hạ tầng cơ sở kỹ thuật số kiểu mới, đẩy nhanh bố trí các trạm phát sóng 5G, trung tâm siêu tính toán và nền tảng Internet công nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2578,
    hanzi: '建造',
    pinyin: 'jiànzào',
    word_type: 'Động từ',
    meaning_vi: 'xây dựng, chế tạo, đóng (tàu, công trình)',
    examples: [
      {
        chinese: '工人们仅用了半年时间就建造好了一座宽敞现代的体育场馆。',
        pinyin: 'Gōngrénmen jǐn yòng le bàn nián shíjiān jiù jiànzào hǎo le yí zuò kuānchǎng xiàndài de tǐyù chǎngguǎn.',
        meaning_vi: 'Các công nhân chỉ mất nửa năm đã thi công hoàn tất một sân vận động hiện đại và rộng rãi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '我国自主设计并建造的首艘国产大型豪华邮轮顺利交付，标志着高端海洋船舶建造工业实现了历史性突破。',
        pinyin: 'Wǒ guó zìzhǔ shèjì bìng jiànzào de shǒu sōu guóchǎn dàxíng háohuá yóulún shùnlì jiāofù, biāozhì zhe gāoduān hǎiyáng chuánbó jiànzào gōngyè shíxiàn le lìshǐxìng tūpò.',
        meaning_vi: 'Chiếc du thuyền siêu sang cỡ lớn nội địa đầu tiên do nước ta tự chủ thiết kế và đóng mới đã được bàn giao thuận lợi, đánh dấu ngành công nghiệp đóng tàu biển cao cấp đã đạt được bước đột phá mang tính lịch sử.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2579,
    hanzi: '建筑',
    pinyin: 'jiànzhù',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'kiến trúc, công trình kiến trúc; xây cất',
    examples: [
      {
        chinese: '漫步在上海外滩，可以看到许多风格独特的近代历史建筑。',
        pinyin: 'Mànbù zài Shànghǎi Wàitān, kěyǐ kàndào xǔduō fēnggé dútè de jìndài lìshǐ jiànzhù.',
        meaning_vi: 'Tản bộ trên Bến Thượng Hải, người ta có thể chiêm ngưỡng rất nhiều công trình kiến trúc lịch sử cận đại mang phong cách độc đáo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代绿色生态建筑倡导将自然采光、雨水循环回收及太阳能光伏系统与建筑本体结构有机融为一体。',
        pinyin: 'Xiàndài lǜsè shēngtài jiànzhù chàngdǎo jiāng zìrán cǎiguāng, yǔshuǐ xúnhuán huíshōu jí tàiyángnéng guāngfú xìtǒng yǔ jiànzhù běntǐ jiégòu yǒujī róng wéi yītǐ.',
        meaning_vi: 'Kiến trúc sinh thái xanh hiện đại chủ trương dung hợp hữu cơ việc đón sáng tự nhiên, tuần hoàn tái sử dụng nước mưa và hệ thống điện mặt trời áp mái vào cùng kết cấu thân công trình kiến trúc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2580,
    hanzi: '将近',
    pinyin: 'jiāngjìn',
    word_type: 'Phó từ',
    meaning_vi: 'gần, ngót, xấp xỉ, ngót nghét',
    examples: [
      {
        chinese: '他在外地工作了将近五年，终于调回老家与父母团聚。',
        pinyin: 'Tā zài wàidì gōngzuò le jiāngjìn wǔ nián, zhōngyú diàohuí lǎojiā yǔ fùmǔ tuánjù.',
        meaning_vi: 'Anh ấy làm việc ở nơi khác ngót nghét 5 năm, cuối cùng đã được điều chuyển về quê nhà sum vầy cùng bố mẹ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该科研团队历经将近十年的潜心攻关与反复实验验证，终于攻克了关键芯片光刻胶配方的核心制备技术。',
        pinyin: 'Gāi kēyán tuánduì lìjīng jiāngjìn shí nián de qiǎnxīn gōngguān yǔ fǎnfù shíyàn yànzhèng, zhōngyú gōngkè le guānjiàn xīnpiàn guāngkèjiāo pèifāng de héxīn zhìbèi jìshù.',
        meaning_vi: 'Đội ngũ nghiên cứu khoa học này trải qua gần mười năm miệt mài nghiên cứu đột phá và kiểm chứng thực nghiệm lặp đi lặp lại, cuối cùng đã chinh phục được kỹ thuật bào chế cốt lõi của công thức chất cản quang cho chip then chốt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2581,
    hanzi: '讲话',
    pinyin: 'jiǎnghuà',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'nói chuyện, phát biểu; bài phát biểu, lời phát biểu',
    examples: [
      {
        chinese: '在开学典礼上，校长发表了热情洋溢的讲话，勉励新生刻苦求知。',
        pinyin: 'Zài kāixué diǎnlǐ shang, xiàozhǎng fābiǎo le rèqíng-yángyì de jiǎnghuà, miǎnlì xīnshēng kèkǔ qiúzhī.',
        meaning_vi: 'Tại lễ khai giảng, hiệu trưởng đã có bài phát biểu tràn đầy nhiệt huyết, khích lệ tân sinh viên chăm chỉ học tập tìm tòi tri thức.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际货币基金组织总裁在年会开幕式上的主旨讲话中强调，各国必须加强多边政策协调以共同防范全球债务外溢风险。',
        pinyin: 'Guójì Huòbì Jījīnzǔzhī zǒngcái zài niánhuì kāimùshì shang de zhǔzhǐ jiǎnghuà zhōng qiángdiào, gè guó bìxū jiāqiáng duōbiān zhèngcè xiétiáo yǐ gòngtóng fángfàn quánqiú zhàiwù wàiyì fēngxiǎn.',
        meaning_vi: 'Tổng giám đốc Quỹ Tiền tệ Quốc tế trong bài phát biểu chủ đề tại lễ khai mạc hội nghị thường niên đã nhấn mạnh rằng, các quốc gia phải tăng cường điều phối chính sách đa phương nhằm cùng phòng ngừa rủi ro lan truyền nợ công toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2582,
    hanzi: '讲究',
    pinyin: 'jiǎngjiu',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'chú trọng, cầu kỳ, tinh tế; điều cần lưu ý',
    examples: [
      {
        chinese: '泡好一杯中国名茶，对水质、水温和冲泡手法都非常讲究。',
        pinyin: 'Pào hǎo yì bēi Zhōngguó míngchá, duì shuǐzhì, shuǐwēn hé chōngpào shǒufǎ dōu fēicháng jiǎngjiu.',
        meaning_vi: 'Để pha được một chén danh trà Trung Hoa ngon, người ta vô cùng chú trọng đến phẩm chất nước, nhiệt độ nước và thủ pháp pha trà.',
        difficulty_level: 'basic'
      },
      {
        chinese: '传统手工苏绣艺术不仅在丝线劈丝上极度讲究，其配色运针更是讲究虚实相映、气韵生动。',
        pinyin: 'Chuántǒng shǒugōng Sūxiù yìshù bùjǐn zài sīxiàn pīsī shang jídù jiǎngjiu, qí pèisè yùnzhēn gèngshì jiǎngjiu xū-shí xiāngyìng, qìyùn shēngdòng.',
        meaning_vi: 'Nghệ thuật thêu tay truyền thống Tô Châu không chỉ cực kỳ cầu kỳ trong thao tác tách tơ sợi, mà khâu phối màu và đường kim mũi chỉ càng chú trọng sự tương phản hư thực, khí vận sinh động.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2583,
    hanzi: '奖励',
    pinyin: 'jiǎnglì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'khen thưởng, phần thưởng, giải thưởng',
    examples: [
      {
        chinese: '学校对在本学期期末考试中成绩名列前茅的优秀学生给予了表彰和奖励。',
        pinyin: 'Xuéxiào duì zài běn xuéqī qīmò kǎoshì zhōng chéngjì míngliè-qiánmáo de yōuxiù xuésheng jǐyǔ le biǎozhāng hé jiǎnglì.',
        meaning_vi: 'Nhà trường đã tuyên dương và trao phần thưởng cho những học sinh xuất sắc đứng trong top đầu ở kỳ thi cuối kỳ đợt này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该高新技术企业建立了股权激励与科研转化特别奖励机制，重奖在关键核心算法攻坚中做出卓越贡献的技术带头人。',
        pinyin: 'Gāi gāoxīnjìshù qǐyè jiànlì le gǔquán jīlì yǔ kēyán zhuǎnhuà tèbié jiǎnglì jīzhì, zhòngjiǎng zài guānjiàn héxīn suànfǎ gōngjiān zhōng zuòchū zhuóyuè gòngxiàn de jìshù dàitóurén.',
        meaning_vi: 'Doanh nghiệp công nghệ cao này đã thiết lập cơ chế khích lệ bằng cổ phần và khen thưởng đặc biệt đối với việc chuyển hóa nghiên cứu khoa học, trọng thưởng cho các thủ lĩnh kỹ thuật có cống hiến vượt trội trong việc giải quyết thuật toán cốt lõi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2584,
    hanzi: '讲述',
    pinyin: 'jiǎngshù',
    word_type: 'Động từ',
    meaning_vi: 'kể lại, thuật lại, trình bày',
    examples: [
      {
        chinese: '老红军爷爷神情动容地为少先队员们讲述当年的战斗故事。',
        pinyin: 'Lǎo hóngjūn yéye shénqíng dòngróng de wèi shàoxiān-duìyuánmen jiǎngshù dāngnián de zhàndòu gùshì.',
        meaning_vi: 'Người cựu chiến binh Hồng quân với nét mặt xúc động đã kể lại cho các bạn đội viên thiếu niên câu chuyện chiến đấu oanh liệt năm nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '纪录片生动讲述了三代塞罕坝务林人历经数十载风霜雨雪，将昔日飞沙走石的荒原变成万顷浩瀚林海的塞罕坝奇迹。',
        pinyin: 'Jìlùpiàn shēngdòng jiǎngshù le sān dài Sàihǎnbà wùlínrén lìjīng shùshí zǎi fēngshuāng-yǔxuě, jiāng xīrì fēishā-zǒushí de huāngyuán biànchéng wànqǐng hàohàn línhǎi de Sàihǎnbà qíjì.',
        meaning_vi: 'Bộ phim tài liệu đã thuật lại sinh động câu chuyện ba thế hệ người làm rừng Saihanba vượt qua hàng chục năm dãi dầu sương tuyết gió mưa, biến vùng hoang mạc sỏi cát bay ngày nào thành kỳ tích biển rừng bạt ngàn hàng vạn mẫu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2585,
    hanzi: '讲座',
    pinyin: 'jiǎngzuò',
    word_type: 'Danh từ',
    meaning_vi: 'buổi tọa đàm, thuyết trình, bài giảng chuyên đề',
    examples: [
      {
        chinese: '今天下午大学礼堂有一场关于跨文化交际的学术讲座，欢迎同学们积极参加。',
        pinyin: 'Jīntiān xiàwǔ dàxué lǐtáng yǒu yì chǎng guānyú kuà wénhuà jiāojì de xuéshù jiǎngzuò, huānyíng tóngxuémen jījí cānjiā.',
        meaning_vi: 'Chiều hôm nay tại giảng đường đại học có một buổi tọa đàm học thuật về giao tiếp liên văn hóa, hoan nghênh các bạn sinh viên tích cực tham gia.',
        difficulty_level: 'basic'
      },
      {
        chinese: '知名经济学家受邀走进商学院大师讲堂，开展了一场题为全球宏观经济重构与企业出海战略深度剖析的高端前沿讲座。',
        pinyin: 'Zhīmíng jīngjìxuéjiā shòuyāo zǒujìn shāngxuéyuàn dàshī jiǎngtáng, kāizhǎn le yì chǎng tíwéi quánqiú hóngguān jīngjì chónggòu yǔ qǐyè chūhǎi zhànlüè shēndù pōuxī de gāoduān qiányán jiǎngzuò.',
        meaning_vi: 'Nhà kinh tế học nổi tiếng được mời đến giảng đường bậc thầy của trường kinh doanh, đã thực hiện một buổi thuyết trình chuyên đề đỉnh cao phân tích sâu sắc về tái cấu trúc kinh tế vĩ mô toàn cầu và chiến lược vươn ra biển lớn của doanh nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2586,
    hanzi: '降水',
    pinyin: 'jiàngshuǐ',
    word_type: 'Danh từ',
    meaning_vi: 'lượng mưa, giáng thủy (mưa tuyết rơi xuống)',
    examples: [
      {
        chinese: '气象预报显示，本周末南方大部分地区将迎来新一轮明显降水天气。',
        pinyin: 'Qìxiàng yùbào xiǎnshì, běn zhōumò nánfāng dàbùfen dìqū jiāng yínglái xīn yì lún míngxiǎn jiàngshuǐ tiānqì.',
        meaning_vi: 'Dự báo khí tượng cho thấy cuối tuần này phần lớn các khu vực phía Nam sẽ đón nhận một đợt thời tiết có mưa rõ rệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全球气候变暖导致极端天气事件发生频率上升，局部地区短时强降水极易诱发山洪暴发与城市内涝等次生衍生灾害。',
        pinyin: 'Quánqiú qìhòu biànnuǎn dǎozhì jíduān tiānqì shìjiàn fāshēng pínlǜ shàngshēng, júbù dìqū duǎnshí qiáng jiàngshuǐ jí yì yòufā shānhóng bàofā yǔ chéngshì nèilào děng cìshēng yǎnshēng zāihài.',
        meaning_vi: 'Biến đổi khí hậu nóng lên toàn cầu dẫn đến tần suất các hiện tượng thời tiết cực đoan gia tăng, mưa lớn ngắn hạn cục bộ rất dễ gây ra lũ quét vùng núi và ngập úng đô thị cùng các hiểm họa thứ cấp đi kèm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2587,
    hanzi: '浇',
    pinyin: 'jiāo',
    word_type: 'Động từ',
    meaning_vi: 'tưới (nước), dội, đúc (bê tông)',
    examples: [
      {
        chinese: '阳台上的这盆绿萝需要每隔两天给它浇一次水。',
        pinyin: 'Yángtái shang de zhè pén lǜluó xūyào měi gé liǎng tiān gěi tā jiāo yí cì shuǐ.',
        meaning_vi: 'Chậu trầu bà xanh trên ban công này cần cứ cách hai ngày lại tưới nước cho nó một lần.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在大桥主墩基础工程施工现场，工程技术人员冒着风雨连续作业十余个小时，顺利完成了特大承台混凝土的浇筑任务。',
        pinyin: 'Zài dàqiáo zhǔdūn jīchǔ gōngchéng shīgōng xiànchǎng, gōngchéng jìshù rényuán màozhe fēngyǔ liánxù zuòyè shí yú gè xiǎoshí, shùnlì wánchéng le tèdà chéngtái hùnníngtǔ de jiāozhù rènwu.',
        meaning_vi: 'Tại hiện trường thi công móng trụ chính của cây đại cầu, đội ngũ nhân viên kỹ thuật công trình đã đội mưa gió làm việc liên tục hơn mười tiếng đồng hồ, hoàn thành thuận lợi nhiệm vụ đổ bê tông bệ mố siêu lớn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2588,
    hanzi: '交换',
    pinyin: 'jiāohuàn',
    word_type: 'Động từ',
    meaning_vi: 'trao đổi, đổi chác, đổi chỗ',
    examples: [
      {
        chinese: '会议休息期间，来自不同行业的参会代表们互相交换了名片并亲切交谈。',
        pinyin: 'Huìyì xiūxi qījiān, láizì bùtóng hángyè de cānhuì dàibiǎomen hùxiāng jiāohuàn le míngpiàn bìng qīnqiè jiāotán.',
        meaning_vi: 'Trong giờ nghỉ giải lao của hội nghị, các đại biểu tham dự đến từ các ngành nghề khác nhau đã trao đổi danh thiếp và trò chuyện thân mật.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在两国元首会谈中，双方就国际多边治理、能源绿色转型以及双边经贸合作全面深入地交换了意见，达成了广泛战略共识。',
        pinyin: 'Zài liǎng guó yuánshǒu huìtán zhōng, shuāngfāng jiù guójì duōbiān zhìlǐ, néngyuán lǜsè zhuǎnxíng yǐjí shuāngbiān jīngmào hézuò quánmiàn shēnrù de jiāohuàn le yìjiàn, dáchéng le guǎnfàn zhànlüè gòngshí.',
        meaning_vi: 'Trong cuộc hội đàm giữa nguyên thủ hai nước, hai bên đã trao đổi ý kiến toàn diện sâu sắc về quản trị đa phương quốc tế, chuyển dịch năng lượng xanh và hợp tác kinh tế thương mại song phương, đạt được nhiều đồng thuận chiến lược rộng rãi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2589,
    hanzi: '交往',
    pinyin: 'jiāowǎng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'giao thiệp, qua lại, tương tác, giao lưu',
    examples: [
      {
        chinese: '与人交往时，真诚与尊重是最能打动人心的品质。',
        pinyin: 'Yǔ rén jiāowǎng shí, zhēnchéng yǔ zūnzhòng shì zuì néng dǎdòng rénxīn de pǐnzhì.',
        meaning_vi: 'Khi giao tiếp qua lại với người khác, sự chân thành và tôn trọng là những phẩm chất dễ làm lay động lòng người nhất.',
        difficulty_level: 'basic'
      },
      {
        chinese: '两国间频繁的民间文化交流与青年学者互访，为筑牢双边友好交往的民意基础发挥了极其重要的纽带作用。',
        pinyin: 'Liǎng guó jiān pínfán de mínjiān wénhuà jiāoliú yǔ qīngnián xuézhě hùfǎng, wèi zhùláo shuāngbiān yǒuhǎo jiāowǎng de mínyì jīchǔ fāhuī le jíqí zhòngyào de niǔdài zuòyòng.',
        meaning_vi: 'Những hoạt động giao lưu văn hóa dân gian và trao đổi học giả trẻ diễn ra thường xuyên giữa hai nước đã phát huy vai trò cầu nối hết sức quan trọng nhằm đắp bồi vững chắc nền tảng dư luận nhân dân cho mối bang giao hữu nghị song phương.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2590,
    hanzi: '交易',
    pinyin: 'jiāoyì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'giao dịch, mua bán',
    examples: [
      {
        chinese: '现在很多人都习惯通过手机应用完成日常的小额转账与线上交易。',
        pinyin: 'Xiànzài hěn duō rén dōu xíguàn tōngguò shǒujī yìngyòng wánchéng rìcháng de xiǎo’é zhuǎnzhàng yǔ xiànshàng jiāoyì.',
        meaning_vi: 'Hiện nay rất nhiều người đã quen chuyển khoản số tiền nhỏ và thực hiện các giao dịch mua sắm trực tuyến thông qua ứng dụng điện thoại.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全国碳排放权交易市场的上线与稳健扩容，通过市场化定价机制有效引导控排高耗能企业主动开展节能降碳改造。',
        pinyin: 'Quánguó tàn páifàngquán jiāoyì shìchǎng de shàngxiàn yǔ wěnjiàn kuòróng, tōngguò shìchǎnghuà dìngjià jīzhì yǒuxiào yǐndǎo kòngpái gāo hàonéng qǐyè zhǔdòng kāizhǎn jiénéng-jiàngtàn gǎizào.',
        meaning_vi: 'Sự ra mắt và mở rộng ổn định của thị trường giao dịch hạn ngạch phát thải carbon toàn quốc thông qua cơ chế định giá thị trường đã dẫn dắt hiệu quả các doanh nghiệp tiêu hao nhiều năng lượng chủ động cải tạo tiết kiệm năng lượng và giảm phát thải carbon.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2591,
    hanzi: '脚步',
    pinyin: 'jiǎobù',
    word_type: 'Danh từ',
    meaning_vi: 'bước chân, nhịp bước, bước đi',
    examples: [
      {
        chinese: '听到门外传来熟悉的脚步声，孩子高兴地跑去开门。',
        pinyin: 'Tīngdào ménwài chuánlái shúxī de jiǎobù shēng, háizi gāoxìng de pǎo qù kāimén.',
        meaning_vi: 'Nghe thấy tiếng bước chân quen thuộc truyền lại ngoài cửa, đứa bé thích thú chạy ra mở cửa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对世界百年未有之大变局，我们必须紧跟时代发展的脉搏，决不能放慢自主创新与改革攻坚的脚步。',
        pinyin: 'Miànduì shìjiè bǎi nián wèiyǒu zhī dà biànjú, wǒmen bìxū jǐngēn shídài fāzhǎn de màibó, jué bùnéng fàngmàn zìzhǔ chuàngxīn yǔ gǎigé gōngjiān de jiǎobù.',
        meaning_vi: 'Đứng trước những biến đổi to lớn trăm năm chưa từng có của thế giới, chúng ta cần theo sát từng nhịp đập phát triển của thời đại, quyết không thể chậm lại bước chân đổi mới sáng tạo tự chủ và cải cách đột phá.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2592,
    hanzi: '角度',
    pinyin: 'jiǎodù',
    word_type: 'Danh từ',
    meaning_vi: 'góc độ, góc nhìn, phương diện',
    examples: [
      {
        chinese: '遇到矛盾的时候，如果能换一个角度思考，问题往往会迎刃而解。',
        pinyin: 'Yùdào máodùn de shíhou, rúguǒ néng huàn yí gè jiǎodù sīkǎo, wèntí wǎngwǎng huì yíngrèn’érjiě.',
        meaning_vi: 'Khi gặp phải mâu thuẫn, nếu có thể đổi một góc độ khác để suy nghĩ thì vấn đề thường sẽ được giải quyết dễ dàng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '专家学者们从经济学、社会学以及生态法学等多学科交叉角度，深入剖析了绿色低碳转型中资源再分配的公平性问题。',
        pinyin: 'Zhuānjiā xuézhěmen cóng jīngjìxué, shèhuìxué yǐjí shēngtài fǎxué děng duō xuékē jiāochā jiǎodù, shēnrù pōuxī le lǜsè dītàn zhuǎnxíng zhōng zīyuán zàifēnpèi de gōngpíngxìng wèntí.',
        meaning_vi: 'Các chuyên gia và học giả từ góc nhìn giao thoa đa ngành như kinh tế học, xã hội học và luật học sinh thái đã mổ xẻ sâu sắc bài toán công bằng trong việc tái phân bổ nguồn lực trong tiến trình chuyển đổi xanh ít carbon.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2593,
    hanzi: '较',
    pinyin: 'jiào',
    word_type: 'Phó từ',
    meaning_vi: 'khá, tương đối; so với (so sánh)',
    examples: [
      {
        chinese: '今年春季当地的气温较往年同期明显偏高。',
        pinyin: 'Jīnnián chūnjì dāngdì de qìwēn jiào wǎngnián tóngqī míngxiǎn piāngāo.',
        meaning_vi: 'Nhiệt độ mùa xuân năm nay ở địa phương tương đối cao hơn rõ rệt so với cùng kỳ các năm trước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '得益于精益生产管理与高度智能化的柔性流水线，该工厂的生产效率较传统车间提升了近百分之四十。',
        pinyin: 'Déyì yú jīngyì shēngchǎn guǎnlǐ yǔ gāodù zhìnénghuà de róuxìng liúshuǐxiàn, gāi gōngchǎng de shēngchǎn xiàolǜ jiào chuántǒng chējiān tíshēng le jìn bǎifēnzhī sìshí.',
        meaning_vi: 'Nhờ vào phương thức quản trị sản xuất tinh gọn và dây chuyền lắp ráp linh hoạt thông minh hóa cao độ, hiệu suất sản xuất của nhà máy này so với các phân xưởng truyền thống đã tăng lên gần 40%.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2594,
    hanzi: '教材',
    pinyin: 'jiàocái',
    word_type: 'Danh từ',
    meaning_vi: 'giáo trình, tài liệu giảng dạy, sách giáo khoa',
    examples: [
      {
        chinese: '新学期伊始，同学们都领到了印刷精美的新教材。',
        pinyin: 'Xīn xuéqī yīshǐ, tóngxuémen dōu lǐngdào le yìnshuā jīngměi de xīn jiàocái.',
        meaning_vi: 'Bắt đầu học kỳ mới, các bạn học sinh đều đã nhận được những cuốn sách giáo trình mới in ấn tinh mỹ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '教育部组织全国一流专家学者统一审定编写的高校思想政治理论课通用教材，体现了深厚的理论逻辑与鲜明的时代特征。',
        pinyin: 'Jiàoyùbù zǔzhī quánguó yīliú zhuānjiā xuézhě tǒngyī shěndìng biānxiě de gāoxiào sīxiǎng zhèngzhì lǐlùnkè tōngyòng jiàocái, tǐxiàn le shēnhòu de lǐlùn luójí yǔ xiānmíng de shídài tèzhēng.',
        meaning_vi: 'Bộ Giáo dục đã quy tụ các chuyên gia học giả hàng đầu cả nước thống nhất thẩm định biên soạn bộ giáo trình môn lý luận chính trị tư tưởng dùng chung cho các trường đại học, thể hiện tư duy lý luận sâu sắc cùng đặc trưng thời đại rõ nét.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2595,
    hanzi: '接触',
    pinyin: 'jiēchù',
    word_type: 'Động từ',
    meaning_vi: 'tiếp xúc, va chạm, tiếp cận, giao lưu',
    examples: [
      {
        chinese: '在日常人际交往中，他总是给人一种容易接触、平易近人的亲切感。',
        pinyin: 'Zài rìcháng rénjì jiāowǎng zhōng, tā zǒngshì gěi rén yì zhǒng róngyì jiēchù, píngyì-jìnrén de qīnqiègǎn.',
        meaning_vi: 'Trong giao tiếp hàng ngày giữa người với người, anh ấy luôn mang lại cho mọi người cảm giác dễ gần, dễ tiếp xúc và bình dị.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高校通过组织大学生深入偏远乡村与基层工厂开展社会实践，让他们更直接地接触真实的国情社情并强化责任担当。',
        pinyin: 'Gāoxiào tōngguò zǔzhī dàxuésheng shēnrù piānyuǎn xiāngcūn yǔ jīcéng gōngchǎng kāizhǎn shèhuì shíjiàn, ràng tāmen gèng zhíjiē de jiēchù zhēnshí de guóqíng shèqíng bìng qiánghuà zérèn dāndāng.',
        meaning_vi: 'Các trường đại học thông qua việc tổ chức cho sinh viên đi sâu về các làng quê hẻo lánh và nhà máy cơ sở để hoạt động thực tế xã hội, giúp các bạn tiếp xúc trực diện hơn với tình hình đất nước và xã hội thực tế, đồng thời tôi luyện tinh thần trách nhiệm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2596,
    hanzi: '接待',
    pinyin: 'jiēdài',
    word_type: 'Động từ',
    meaning_vi: 'tiếp đãi, đón tiếp, chiêu đãi',
    examples: [
      {
        chinese: '前台工作人员礼貌热情地接待了前来咨询业务的每一位客户。',
        pinyin: 'Qiántái gōngzuò rényuán lǐmào rèqíng de jiēdài le qiánlái zīxún yèwù de měi yí wèi kèhù.',
        meaning_vi: 'Nhân viên lễ tân lịch thiệp và nhiệt tình đón tiếp từng khách hàng đến hỏi thông tin nghiệp vụ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为保障跨国投资洽谈峰会的圆满举行，会务组精心制定了涵盖机场迎接、多语种翻译和外宾安保的高规格接待工作方案。',
        pinyin: 'Wèi bǎozhàng kuàguó tóuzī qiàtán fēnghuì de yuánmǎn jǔxíng, huìwùzǔ jīngxīn zhìdìng le hángài jīchǎng yíngjiē, duō yǔzhǒng fānyì hé wàibīn ānbǎo de gāo guīgé jiēdài gōngzuò fāng’àn.',
        meaning_vi: 'Nhằm đảm bảo hội nghị thượng đỉnh đàm phán đầu tư xuyên quốc gia diễn ra tốt đẹp, ban tổ chức hội nghị đã công phu xây dựng phương án đón tiếp chuẩn mực cao bao gồm đón rước tại sân bay, phiên dịch đa ngôn ngữ và bảo an cho khách quốc tế.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2597,
    hanzi: '阶段',
    pinyin: 'jiēduàn',
    word_type: 'Danh từ',
    meaning_vi: 'giai đoạn, thời kỳ, chặng',
    examples: [
      {
        chinese: '这项大型科研攻关项目目前已经顺利进入了实质性的临床试验阶段。',
        pinyin: 'Zhè xiàng dàxíng kēyán gōngguān xiàngmù mùqián yǐjīng shùnlì jìnrù le shízhìxìng de línchuáng shìyàn jiēduàn.',
        meaning_vi: 'Dự án nghiên cứu khoa học quy mô lớn này hiện tại đã thuận lợi bước vào giai đoạn thử nghiệm lâm sàng thực chất.',
        difficulty_level: 'basic'
      },
      {
        chinese: '我国经济已由高速增长阶段转向高质量发展阶段，必须更加坚定不移地贯彻创新、协调、绿色、开放、共享的新发展理念。',
        pinyin: 'Wǒ guó jīngjì yǐ yóu gāosù zēngzhǎng jiēduàn zhuǎnxiàng gāo zhìliàng fāzhǎn jiēduàn, bìxū gèngjiā jiāndìng-bùyí de guànchè chuàngxīn, xiétiáo, lǜsè, kāifàng, gòngxiǎng de xīn fāzhǎn lǐniàn.',
        meaning_vi: 'Nền kinh tế nước ta đã chuyển từ giai đoạn tăng trưởng tốc độ cao sang giai đoạn phát triển chất lượng cao, cần phải kiên định quán triệt sâu sắc hơn nữa triết lý phát triển mới gồm đổi mới sáng tạo, hài hòa, xanh, cởi mở và chia sẻ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2598,
    hanzi: '接近',
    pinyin: 'jiējìn',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'tiếp cận, đến gần, xấp xỉ; gần gũi',
    examples: [
      {
        chinese: '随着下班时间的渐渐接近，办公室里的气氛开始轻松起来。',
        pinyin: 'Suízhe xiàbān shíjiān de jiànjiàn jiējìn, bàngōngshì lǐ de qìfēn kāishǐ qīngsōng qǐlái.',
        meaning_vi: 'Cùng với thời điểm tan làm dần dần đến gần, bầu không khí trong văn phòng bắt đầu trở nên thoải mái hơn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '最新统计报告表明，我国清洁能源消费占能源消费总量的比重已接近百分之三十，能源结构绿色转型成效显著。',
        pinyin: 'Zuìxīn tǒngjì bàogào biǎomíng, wǒ guó qīngjié néngyuán xiāofèi zhàn néngyuán xiāofèi zǒngliàng de bǐzhòng yǐ jiējìn bǎifēnzhī sānshí, néngyuán jiégòu lǜsè zhuǎnxíng chéngxiào xiǎnzhù.',
        meaning_vi: 'Báo cáo thống kê mới nhất chỉ ra rằng, tỷ trọng tiêu thụ năng lượng sạch trong tổng lượng tiêu thụ năng lượng của nước ta đã xấp xỉ 30%, hiệu quả chuyển dịch xanh trong cơ cấu năng lượng đạt kết quả rõ rệt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2599,
    hanzi: '接收',
    pinyin: 'jiēshōu',
    word_type: 'Động từ',
    meaning_vi: 'tiếp nhận, nhận, thu nhận (tín hiệu, người, tài sản)',
    examples: [
      {
        chinese: '由于山区信号较差，手机在这个深山峡谷里暂时无法接收到网络信号。',
        pinyin: 'Yóuyú shānqū xìnhào jiào chà, shǒujī zài zhè gè shēnshān xiágǔ lǐ zànshí wúfǎ jiēshōu dào wǎngluò xìnhào.',
        meaning_vi: 'Do tín hiệu vùng đồi núi khá kém, điện thoại di động tạm thời không thể nhận được sóng mạng trong hẻm núi sâu này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '地面卫星测控站依靠大型高增益相控阵天线，能够全天候稳定接收深空探测器从数亿公里外传回的高清科学遥测数据。',
        pinyin: 'Dìmiàn wèixīng cèkòngzhàn yīkào dàxíng gāo zēngyì xiāngkòngzhèn tiānxiàn, nénggòu quántiānhòu wěndìng jiēshōu shēnkōng tàncèqì cóng shù yì gōnglǐ wài chuánhuí de gāoqīng kēxué yáocè shùjù.',
        meaning_vi: 'Trạm điều khiển đo lường vệ tinh mặt đất dựa vào ăng-ten mảng pha độ lợi cao quy mô lớn, có thể tiếp nhận ổn định suốt ngày đêm các dữ liệu đo xa khoa học độ nét cao truyền về từ tàu thăm dò không gian sâu cách xa hàng trăm triệu kilomet.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2600,
    hanzi: '结',
    pinyin: 'jié',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'thắt, buộc, kết (nút, tình bạn, quả); nút thắt, mối thắt',
    examples: [
      {
        chinese: '小女孩的手很灵巧，用一条红丝带打了一个非常漂亮的蝴蝶结。',
        pinyin: 'Xiǎo nǚhái de shǒu hěn língqiǎo, yòng yì tiáo hóng sīdài dǎ le yí gè fēicháng piàoliang de húdiéjié.',
        meaning_vi: 'Đôi tay của cô bé rất khéo léo, đã dùng một sợi ruy băng đỏ thắt thành một chiếc nơ con bướm vô cùng xinh xắn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对复杂的历史遗留纷争，唯有秉持求同存异、务实对话的政治智慧，才能真正解开困扰各方的死结并实现持久和平。',
        pinyin: 'Miànduì fùzá de lìshǐ yíliú fēnzhēng, wéiyǒu bǐngchí qiútóng-cúnyì, wùshí duìhuà de zhèngzhì zhìhuì, cáinéng zhēnzhèng jiěkāi kùnrǎo gèfāng de sǐjié bìng shíxiàn chíchǐ hépíng.',
        meaning_vi: 'Đối mặt với những tranh chấp phức tạp do lịch sử để lại, chỉ có giữ vững trí tuệ chính trị cầu đồng tồn dị và đối thoại thực chất mới có thể thực sự tháo gỡ nút thắt khó gỡ đang vướng bận các bên và hiện thực hóa nền hòa bình lâu dài.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2601,
    hanzi: '结构',
    pinyin: 'jiégòu',
    word_type: 'Danh từ',
    meaning_vi: 'kết cấu, cấu trúc, cơ cấu',
    examples: [
      {
        chinese: '这篇文章层次分明，逻辑十分严密，整体结构非常清晰。',
        pinyin: 'Zhè piān wénzhāng céngcì fēnmíng, luójí shífēn yánmì, zhěngtǐ jiégòu fēicháng qīngxī.',
        meaning_vi: 'Bài viết này các tầng lang mạch lạc, tư duy logic vô cùng chặt chẽ, cấu trúc tổng thể hết sức rõ ràng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为推动经济实现质的有效提升和量的合理增长，国家必须持续优化升级产业结构、能源结构与区域经济布局。',
        pinyin: 'Wèi tuīdòng jīngjì shíxiàn zhì de yǒuxiào tíshēng hé liàng de hélǐ zēngzhǎng, guójiā bìxū chíxù yōuhuà shēngjí chǎnyè jiégòu, néngyuán jiégòu yǔ qūyù jīngjì bùjú.',
        meaning_vi: 'Nhằm thúc đẩy nền kinh tế nâng cao hiệu quả về chất và tăng trưởng hợp lý về lượng, quốc gia cần liên tục tối ưu hóa và nâng cấp cơ cấu ngành nghề, cơ cấu năng lượng và phân bố không gian kinh tế vùng.',
        difficulty_level: 'applied'
      }
    ]
  }
]
