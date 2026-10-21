// data/hsk5-batch8-part4-data.ts
// 25 từ HSK 5: #2777 [明显] -> #2801 [念]

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

export const HSK5_BATCH8_PART4: VocabItem[] = [
  {
    id: 2777,
    hanzi: '明显',
    pinyin: 'míngxiǎn',
    word_type: 'Tính từ',
    meaning_vi: 'rõ rệt, hiển nhiên, rõ ràng',
    examples: [
      {
        chinese: '经过一个月的系统锻炼，他的体能状态有了明显的改善。',
        pinyin: 'Jīngguò yí gè yuè de xìtǒng duànliàn, tā de tǐnéng zhuàngtài yǒu le míngxiǎn de gǎishàn.',
        meaning_vi: 'Qua một tháng rèn luyện có hệ thống, thể lực của anh ấy đã có sự cải thiện rõ rệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '统计数据显示，高附加值绿色低碳产业对规上工业增加值增长的拉动作用呈现出明显的提速态势。',
        pinyin: 'Tǒngjì shùjù xiǎnshì, gāo fùjiāzhí lǜsè dītàn chǎnyè duì guīshàng gōngyè zēngjiāzhí zēngzhǎng de lādòng zuòyòng chéngxiàn chū míngxiǎn de tísù tàishì.',
        meaning_vi: 'Số liệu thống kê chỉ ra rằng, tác động thúc đẩy của các ngành công nghiệp xanh ít carbon có giá trị gia tăng cao đối với đà tăng trưởng giá trị gia tăng công nghiệp quy mô lớn đang thể hiện xu thế tăng tốc rõ rệt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2778,
    hanzi: '明星',
    pinyin: 'míngxīng',
    word_type: 'Danh từ',
    meaning_vi: 'ngôi sao, minh tinh, nhân vật xuất chúng',
    examples: [
      {
        chinese: '他在全国青年田径锦标赛中一战成名，成为了大家心目中的体育明星。',
        pinyin: 'Tā zài quánguó qīngnián tiánjìng jǐnbiāosài zhōng yízhàn-chéngmíng, chéngwéi le dàjiā xīnmù zhōng de tǐyù míngxīng.',
        meaning_vi: 'Anh ấy chỉ sau một trận đấu tại giải vô địch điền kinh thanh niên toàn quốc đã nổi danh, trở thành ngôi sao thể thao trong mắt mọi người.',
        difficulty_level: 'basic'
      },
      {
        chinese: '公众人物与演艺明星应当自觉珍惜自身社会声誉，带头践行社会主义核心价值观并积极投身公益事业，发挥良好的示范表率作用。',
        pinyin: 'Gōngzhòng rénwù yǔ yǎnyì míngxīng yīngdāng zìjué zhēnxī zìshēn shèhuì shēngyù, dàitóu jiànxíng shèhuì zhǔyì héxīn jiàzhíguān bìng jījí tóushēn gōngyì shìyè, fāhuī liánghǎo de shìfàn biǎoshuài zuòyòng.',
        meaning_vi: 'Người của công chúng và các ngôi sao nghệ thuật biểu diễn nên tự giác trân quý danh tiếng xã hội của bản thân, đi đầu thực hành các giá trị cốt lõi và tích cực tham gia các hoạt động thiện nguyện công ích, phát huy vai trò nêu gương sáng tốt đẹp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2779,
    hanzi: '命',
    pinyin: 'mìng',
    word_type: 'Danh từ',
    meaning_vi: 'tính mạng, mạng sống; mệnh, số phận; mệnh lệnh',
    examples: [
      {
        chinese: '在抗击自然灾害中，救援队伍始终坚持人民至上、生命至上。',
        pinyin: 'Zài kàngjī zìrán zāihài zhōng, jiùyuán duìwù shǐzhōng jiānchí rénmín zhìshàng, shēngmìng zhìshàng.',
        meaning_vi: 'Trong công cuộc chống chọi thiên tai, lực lượng cứu hộ luôn kiên trì đặt nhân dân lên trên hết, tính mạng sinh mạng con người là trên hết.',
        difficulty_level: 'basic'
      },
      {
        chinese: '当代有为青年应当勇于打破所谓的宿命论桎梏，坚信我命由我不由天，在拼搏奉献中把前途命运牢牢掌握在自己手中。',
        pinyin: 'Dāngdài yǒuwéi qīngnián yīngdāng yǒngyú dǎpò suǒwèi de sùmìnglùn zhìgù, jiānxìn wǒ mìng yóu wǒ bù yóu tiān, zài pīnbó fèngxiàn zhōng bǎ qiántú mìngyùn láoláo zhǎngwò zài zìjǐ shǒuzhōng.',
        meaning_vi: 'Thanh niên có chí hướng thời nay cần dũng cảm đập tan xiềng xích của cái gọi là thuyết định mệnh, vững tin rằng mệnh do ta chứ không do trời định, trong nỗ lực cống hiến nắm chắc tiền đồ vận mệnh trong tay mình.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2780,
    hanzi: '命运',
    pinyin: 'mìngyùn',
    word_type: 'Danh từ',
    meaning_vi: 'vận mệnh, số phận',
    examples: [
      {
        chinese: '刻苦读书与掌握一技之长是偏远山区孩子改变自身命运的重要途径。',
        pinyin: 'Kèkǔ dúshū yǔ zhǎngwò yíjìzhīcháng shì piānyuǎn shānqū háizi gǎibiàn zìshēn mìngyùn de zhòngyào tújìng.',
        meaning_vi: 'Chăm chỉ học hành và nắm vững một kỹ năng nghề nghiệp là con đường quan trọng để trẻ em vùng cao hẻo lánh thay đổi số phận bản thân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '人类同处一个地球村，面对气候变暖、粮食安全等全球性危机，各国唯有同舟共济，才能携手构建休戚与共的人类命运共同体。',
        pinyin: 'Rénlèi tóng chǔ yí gè dìqiúcūn, miànduì qìhòu biànnuǎn, liángshi ānquán děng quánqiúxìng wēijī, gè guó wéiyǒu tóngzhōu-gòngjì, cáinéng xiéshǒu gòujiàn xiūqī-yǔgòng de rénlèi mìngyùn gòngtóngtǐ.',
        meaning_vi: 'Nhân loại cùng sống trong một ngôi làng Trái Đất, trước các cuộc khủng hoảng toàn cầu như biến đổi khí hậu ấm lên và an ninh lương thực, các quốc gia chỉ có cùng chung một con thuyền mới có thể chung tay dựng xây cộng đồng chung vận mệnh nhân loại cùng chung vui buồn hoạn nạn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2781,
    hanzi: '摸',
    pinyin: 'mō',
    word_type: 'Động từ',
    meaning_vi: 'sờ, sờ soạng, mò mẫm, tìm hiểu',
    examples: [
      {
        chinese: '这件真丝衬衫摸起来手感非常柔软光滑。',
        pinyin: 'Zhè jiàn zhēnsī chènshān mō qǐlái shǒugǎn fēicháng róuruǎn guānghuá.',
        meaning_vi: 'Chiếc áo sơ mi lụa tơ tằm này sờ vào cảm giác tay vô cùng mềm mại và trơn láng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中国改革开放初期正是依靠“摸着石头过河”的务实探索精神，敢闯敢试，成功开创了一条具有中国特色的社会主义现代化道路。',
        pinyin: 'Zhōngguó gǎigé-kāifàng chūqī zhèngshì yīkào “mō zhe shítou guò hé” de wùshí tànsuǒ jīngshén, gǎn chuǎng gǎn shì, chénggōng kāichuàng le yì tiáo jùyǒu Zhōngguó tèsè de shèhuì zhǔyì xiàndàihuà dàolù.',
        meaning_vi: 'Thời kỳ đầu cải cách mở cửa của Trung Quốc chính là nhờ vào tinh thần tìm tòi thực tế "dò đá qua sông", dám nghĩ dám làm, đã mở ra thành công con đường hiện đại hóa xã hội chủ nghĩa mang đặc sắc Trung Quốc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2782,
    hanzi: '模糊',
    pinyin: 'móhu',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'mờ mịt, mơ hồ, nhòe; làm mờ',
    examples: [
      {
        chinese: '大雨淋湿了汽车的前挡风玻璃，外面的街景变得一片模糊。',
        pinyin: 'Dàyǔ línshī le qìchē de qián dǎngfēng bōli, wàimiàn de jiējǐng biànde yí piàn móhu.',
        meaning_vi: 'Mưa lớn làm ướt sũng kính chắn gió phía trước của xe ô tô, cảnh quan đường phố bên ngoài trở nên mờ mịt một màu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在起草具有法律约束力的商业合同时，对违约责任的界定必须精确严密，决不能留下任何模棱两可的模糊表述。',
        pinyin: 'Zài qǐcǎo jùyǒu fǎlǜ yuēshùlì de shāngyè hétong shí, duì wéiyuē zérèn de jièdìng bìxū jīngquè yánmì, jué bùnéng liúxià rènhé móléng-liǎngkě de móhu biǎoshù.',
        meaning_vi: 'Khi soạn thảo hợp đồng thương mại có giá trị ràng buộc pháp lý, việc phân định trách nhiệm vi phạm hợp đồng phải thật chính xác chặt chẽ, tuyệt đối không được để lại bất kỳ cách diễn đạt mơ hồ nước đôi nào.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2783,
    hanzi: '模式',
    pinyin: 'móshì',
    word_type: 'Danh từ',
    meaning_vi: 'mô hình, khuôn mẫu, phương thức',
    examples: [
      {
        chinese: '这所学校推行的小班互动式教学模式深受广大学生与家长的欢迎。',
        pinyin: 'Zhè suǒ xuéxiào tuīxíng de xiǎobān hùdòngshì jiàoxué móshì shēnshòu guǎngdà xuésheng yǔ jiāzhǎng de huānyíng.',
        meaning_vi: 'Mô hình giảng dạy tương tác lớp nhỏ do ngôi trường này áp dụng rất được đông đảo học sinh và phụ huynh đón nhận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '以数字平台为依托的共享经济新商业模式，极大降低了交易边际成本并促进了社会闲置资源的跨区域优化配置。',
        pinyin: 'Yǐ shùzì píngtái wéi yītuō de gòngxiǎng jīngjì xīn shāngyè móshì, jídà jiàngdī le jiāoyì biānjì chéngběn bìng cùjìn le shèhuì xiánzhì zīyuán de kuà qūyù yōuhuà pèizhì.',
        meaning_vi: 'Mô hình kinh doanh mới về kinh tế chia sẻ dựa trên nền tảng kỹ thuật số đã giảm thiểu tối đa chi phí biên giao dịch và thúc đẩy việc phân bổ tối ưu các nguồn lực dư thừa trong xã hội xuyên khu vực.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2784,
    hanzi: '陌生',
    pinyin: 'mòshēng',
    word_type: 'Tính từ',
    meaning_vi: 'xa lạ, lạ lẫm, không quen biết',
    examples: [
      {
        chinese: '刚到一个陌生的城市上大学，小王起初在生活上有些不太习惯。',
        pinyin: 'Gāng dào yí gè mòshēng de chéngshì shàng dàxué, Xiǎo Wáng qǐchū zài shēnghuó shang yǒuxiē bú tài xíguàn.',
        meaning_vi: 'Vừa tới một thành phố xa lạ để học đại học, Tiểu Vương ban đầu có phần chưa quen lắm trong nếp sinh hoạt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '社区工作者以高度的亲和力走进素不相识的陌生家庭，耐心宣讲惠民医疗政策，架起了党群干群之间的连心桥。',
        pinyin: 'Shèqū gōngzuòzhě yǐ gāodù de qīnhélì zǒujìn sùbù-xiāngshí de mòshēng jiātíng, nàixīn xuānjiǎng huìmín yīliáo zhèngcè, jiàqǐ le dǎng-qún gàn-qún zhījiān de liánxīnqiáo.',
        meaning_vi: 'Các cán bộ làm công tác cộng đồng với sự gần gũi cao độ đã bước vào những gia đình xa lạ vốn chưa từng quen biết, kiên nhẫn tuyên truyền chính sách y tế vì dân, bắc nên nhịp cầu nối liền trái tim giữa cán bộ và quần chúng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2785,
    hanzi: '某',
    pinyin: 'mǒu',
    word_type: 'Đại từ',
    meaning_vi: 'mỗ, nào đó, người nào đó, cái nào đó',
    examples: [
      {
        chinese: '这篇案例分析以南方某知名高新技术企业为样本展开了深入研究。',
        pinyin: 'Zhè piān ànlì fēnxī yǐ nánfāng mǒu zhīmíng gāoxīnjìshù qǐyè wéi yàngběn zhǎnkāi le shēnrù yánjiū.',
        meaning_vi: 'Bài phân tích tình huống này đã lấy một doanh nghiệp công nghệ cao nổi tiếng nào đó ở miền Nam làm mẫu thử để triển khai nghiên cứu chuyên sâu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '新闻报道在披露涉及未成年人合法权益的司法案件时，一律依法隐去当事人的真实姓名而以某某代替，切实履行未成年人司法保护职责。',
        pinyin: 'Xīnwén bàodào zài pīlù shèjí wèichéngniánrén héfǎ quányì de sīfǎ ànjiàn shí, yílǜ yīfǎ yǐnqù dāngshìrén de zhēnshí xìngmíng ér yǐ mǒumǒu dàitì, qièshí lǚxíng wèichéngniánrén sīfǎ bǎohù zhízé.',
        meaning_vi: 'Các bản tin báo chí khi đưa tin về các vụ án tư pháp liên quan đến quyền lợi hợp pháp của trẻ vị thành niên đều theo luật ẩn danh tính thật của đương sự và thay bằng ông/bà mỗ, thực hiện thiết thực trách nhiệm bảo vệ tư pháp người chưa thành niên.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2786,
    hanzi: '目光',
    pinyin: 'mùguāng',
    word_type: 'Danh từ',
    meaning_vi: 'ánh mắt, ánh nhìn; tầm nhìn, tầm mắt',
    examples: [
      {
        chinese: '当台上主持人宣布比赛结果时，全场观众的目光瞬间齐刷刷投向了大屏幕。',
        pinyin: 'Dāng táishang zhǔchírén xuānbù bǐsài jiéguǒ shí, quánchǎng guānzhòng de mùguāng shùnjiān qíshuāshuā tóuxiàng le dà píngmù.',
        meaning_vi: 'Khi người dẫn chương trình trên sân khấu tuyên bố kết quả cuộc thi, ánh mắt của toàn thể khán giả lập tức đồng loạt hướng về màn hình lớn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '优秀的战略决策者不能仅仅将目光局限于眼前的季度财报利润，更要把目光投向未来十年的产业变革大趋势。',
        pinyin: 'Yōuxiù de zhànlüè juécèzhě bùnéng jǐnjǐn jiāng mùguāng júxiàn yú yǎnqián de jìdù cáibào lìrùn, gèng yào bǎ mùguāng tóuxiàng wèilái shí nián de chǎnyè biàngé dà qūshì.',
        meaning_vi: 'Người ra quyết định chiến lược xuất sắc không thể chỉ hạn hẹp tầm nhìn vào lợi nhuận báo cáo tài chính hàng quý trước mắt, mà càng phải phóng tầm mắt tới xu thế cải cách ngành công nghiệp to lớn trong 10 năm tới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2787,
    hanzi: '木头',
    pinyin: 'mùtou',
    word_type: 'Danh từ',
    meaning_vi: 'gỗ, khúc gỗ, thanh gỗ',
    examples: [
      {
        chinese: '工匠师傅正熟练地用锯子将这块优质红木木头切割成桌面板材。',
        pinyin: 'Gōngjiàng shīfu zhèng shúliàn de yòng jùzi jiāng zhè kuài yōuzhì hóngmù mùtou qiēgē chéng zhuōmiàn bǎncái.',
        meaning_vi: 'Bác thợ thủ công đang thuần thục dùng cưa xẻ khúc gỗ hồng mộc hảo hạng này thành tấm ván mặt bàn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中国传统古建筑采用榫卯结构，通体全靠木头之间的凹凸咬合严丝合缝，历经千年风雨地震依然稳固屹立。',
        pinyin: 'Zhōngguó chuántǒng gǔ jiànzhù cǎiyòng sǔnmǎo jiégòu, tōngtǐ quán kào mùtou zhījiān de āotū yǎohé yánsī-héfèng, lìjīng qiān nián fēngyǔ dìzhèn yīrán wěngù yìlì.',
        meaning_vi: 'Kiến trúc cổ truyền thống Trung Hoa sử dụng kết cấu mộng ngàm, toàn thân hoàn toàn dựa vào sự khớp nối lồi lõm khít khao giữa các thanh gỗ với nhau, dẫu trải qua nghìn năm mưa gió động đất vẫn vững chãi đứng sừng sững.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2788,
    hanzi: '哪怕',
    pinyin: 'nǎpà',
    word_type: 'Liên từ',
    meaning_vi: 'dẫu cho, cho dù, cho dẫu',
    examples: [
      {
        chinese: '哪怕前方的道路再艰难曲折，我们也要坚持不懈地走下去。',
        pinyin: 'Nǎpà qiánfāng de dàolù zài jiānnán qūzhé, wǒmen yě yào jiānchí-búxiè de zǒu xiàqù.',
        meaning_vi: 'Dẫu cho con đường phía trước có gian nan khúc khuỷu đến đâu, chúng ta cũng phải kiên trì bền bỉ bước tiếp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科研攻关往往需要坐冷板凳数十年，哪怕遭遇成百上千次的实验挫折，科学家们也依然百折不挠勇攀世界科学高峰。',
        pinyin: 'Kēyán gōngguān wǎngwǎng xūyào zuò lěngbǎndèng shù shí nián, nǎpà zāoyù chéngbǎi-shàngqiān cì de shíyàn cuòzhé, kēxuéjiāmen yě yīrán bǎizhé-bùnáo yǒngpān shìjiè kēxué gāofēng.',
        meaning_vi: 'Nghiên cứu khoa học mũi nhọn thường đòi hỏi phải ngồi ghế lạnh suốt mấy chục năm ròng, dẫu cho gặp phải hàng trăm hàng nghìn lần thất bại thực nghiệm, các nhà khoa học vẫn kiên cường bất khuất dũng cảm trèo lên đỉnh cao khoa học thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2789,
    hanzi: '难得',
    pinyin: 'nándé',
    word_type: 'Tính từ / Phó từ',
    meaning_vi: 'hiếm có, đáng quý, khó gặp',
    examples: [
      {
        chinese: '今天难得全家人都放假聚在一起，妈妈特地做了一桌丰盛可口的饭菜。',
        pinyin: 'Jīntiān nándé quán jiārén dōu fàngjià jù zài yìqǐ, māma tēdì zuò le yì zhuō fēngshèng kěkǒu de fàncài.',
        meaning_vi: 'Hôm nay hiếm có dịp cả nhà đều được nghỉ quây quần bên nhau, mẹ đã đặc biệt nấu một bàn cơm canh thịnh soạn ngon lành.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在百年变局加速演进的当下，中国展现出强劲的经济发展韧性与长期政治社会稳定，这是极为宝贵且难得的确定性发展环境。',
        pinyin: 'Zài bǎi nián biànjú jiāsù yǎnjìn de dāngxià, Zhōngguó zhǎnxiàn chū qiángjìn de jīngjì fāzhǎn rènxìng yǔ chángqī zhèngzhì shèhuì wěndìng, zhè shì jíwéi bǎoguì qiě nándé de quèdìngxìng fāzhǎn huánjìng.',
        meaning_vi: 'Giữa thời điểm cục diện trăm năm đang gia tốc đổi thay, Trung Quốc thể hiện sức bền phát triển kinh tế mạnh mẽ và sự ổn định chính trị xã hội lâu dài, đây là một môi trường phát triển có tính xác định vô cùng quý báu và hiếm có.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2790,
    hanzi: '难度',
    pinyin: 'nándù',
    word_type: 'Danh từ',
    meaning_vi: 'độ khó, mức độ khó khăn',
    examples: [
      {
        chinese: '体操运动员在单杠决赛中挑战了一套极高难度的动作组合。',
        pinyin: 'Tǐcāo yùndòngyuán zài dāngàng juésài zhōng tiǎozhàn le yí tào jí gāo nándù de dòngzuò zǔhé.',
        meaning_vi: 'Vận động viên thể dục dụng cụ trong trận chung kết xà đơn đã thử thách một tổ hợp động tác có độ khó cực cao.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在海底超深水强压高腐蚀极端地质条件下钻探开采天然气水合物，其工程施工技术难度堪称世界能源开采史之最。',
        pinyin: 'Zài hǎidǐ chāoshēnshuǐ qiángyā gāo fǔshí jíduān dìzhì tiáojiàn xià zuàntàn kāicǎi tiānránqì shuǐhèwù, qí gōngchéng shīgōng jìshù nándù kānchēng shìjiè néngyuán kāicǎi shǐ zhī zuì.',
        meaning_vi: 'Khoan thăm dò và khai thác băng cháy trong điều kiện địa chất cực đoan dưới đáy biển sâu với áp suất cực lớn và độ ăn mòn cao, mức độ khó khăn kỹ thuật thi công của nó được xem là kỷ lục hàng đầu trong lịch sử khai thác năng lượng thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2791,
    hanzi: '难以',
    pinyin: 'nányǐ',
    word_type: 'Động từ / Phó từ',
    meaning_vi: 'khó mà, khó lòng, không thể',
    examples: [
      {
        chinese: '听闻老朋友突发意外离世的消息，大家心中的悲痛心情难以言表。',
        pinyin: 'Tīngwén lǎo péngyou tūfā yìwài líshì de xiāoxi, dàjiā xīnzhōng de bēitòng xīnqíng nányǐ yánbiǎo.',
        meaning_vi: 'Nghe tin người bạn cũ đột ngột qua đời vì tai nạn, nỗi niềm đau xót trong lòng mọi người khó mà diễn tả thành lời.',
        difficulty_level: 'basic'
      },
      {
        chinese: '如果不能在底层基础研究与原始创新上取得自主突破，关键产业核心零部件长期受制于人的被动局面将难以从根本上扭转。',
        pinyin: 'Rúguǒ bùnéng zài dǐcéng jīchǔ yánjiū yǔ yuánshǐ chuàngxīn shang qǔdé zìzhǔ tūpò, guānjiàn chǎnyè héxīn língbùjiàn chángqī shòuzhìyúrén de bèidòng júmiàn jiāng nányǐ cóng gēnběn shang niǔzhuǎn.',
        meaning_vi: 'Nếu không thể đạt được đột phá tự chủ trong nghiên cứu cơ bản nền tảng và sáng tạo nguyên bản, thì cục diện bị động phụ thuộc vào người khác suốt thời gian dài của các linh kiện cốt lõi trong ngành công nghiệp then chốt sẽ khó lòng xoay chuyển từ gốc rễ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2792,
    hanzi: '男子',
    pinyin: 'nánzǐ',
    word_type: 'Danh từ',
    meaning_vi: 'nam giới, nam tử, đàn ông',
    examples: [
      {
        chinese: '我国短跑运动员在奥运会男子一百米半决赛中跑出了优异成绩。',
        pinyin: 'Wǒ guó duǎnpǎo yùndòngyuán zài Àoyùnhuì nánzǐ yībǎimǐ bànjuésài zhōng pǎochū le yōuyì chéngjì.',
        meaning_vi: 'Vận động viên chạy cự ly ngắn nước ta đã đạt thành tích xuất sắc tại vòng bán kết cự ly 100m nam Thế vận hội Olympic.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中华传统文化崇尚顶天立地、保家卫国的堂堂男子汉气概，激励着一代代热血青年在国家危难时刻挺身而出。',
        pinyin: 'Zhōnghuá chuántǒng wénhuà chóngshàng dǐngtiān-lìdì, bǎojiā-wèiguó de tángtáng nánzǐhàn qìgài, jīlì zhe yídàidài rèxiè qīngnián zài guójiā wēinàn shíkè tǐngshēn-érchū.',
        meaning_vi: 'Văn hóa truyền thống Trung Hoa tôn vinh khí phách đấng nam nhi đường hoàng đầu đội trời chân đạp đất xả thân bảo vệ quê hương đất nước, khích lệ từng thế hệ thanh niên nhiệt huyết dám xông pha trong thời khắc quốc gia nguy nan.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2793,
    hanzi: '闹',
    pinyin: 'nào',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'ồn ào, náo nhiệt; làm ầm ĩ; phát sinh (bệnh, tai họa, đói kém)',
    examples: [
      {
        chinese: '大街上车水马龙，到处都是热闹喧哗的人流。',
        pinyin: 'Dàjiē shang chēshuǐ-mǎlóng, dàochù dōu shì rènao xuānhuá de rénliú.',
        meaning_vi: 'Trên phố lớn xe cộ nườm nượp như nước chảy ngựa phi, đâu đâu cũng là dòng người ồn ào náo nhiệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对局部地区突发的洪涝灾害与病虫害侵袭，农业农村部门迅速组织专家深入田间地头指导农户科学补种抗灾，坚决防范闹荒减产风险。',
        pinyin: 'Miànduì júbù dìqū tūfā de hónglào zāihài yǔ bìngchónghài qīnxí, nóngyè nóngcūn bùmén xùnsù zǔzhī zhuānjiā shēnrù tiánjiān-dìtóu zhǐdǎo nónghù kēxué bǔzhòng kàngzāi, jiānjué fángfàn nàohuāng jiǎnchǎn fēngxiǎn.',
        meaning_vi: 'Đối mặt với thiên tai lũ lụt và sâu bệnh đột ngột tấn công cục bộ, cơ quan nông nghiệp nông thôn nhanh chóng tổ chức chuyên gia xuống tận đồng ruộng hướng dẫn bà con trồng dặm khoa học chống hạn chống úng, kiên quyết ngăn ngừa rủi ro mất mùa giảm sản lượng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2794,
    hanzi: '闹钟',
    pinyin: 'nàozhōng',
    word_type: 'Danh từ',
    meaning_vi: 'đồng hồ báo thức',
    examples: [
      {
        chinese: '他把手机闹钟设置在清晨六点半，以便起床晨跑锻炼身体。',
        pinyin: 'Tā bǎ shǒujī nàozhōng shèzhì zài qīngchén liù diǎn bàn, yǐbiàn qǐchuáng chénpǎo duànliàn shēntǐ.',
        meaning_vi: 'Anh ấy cài đặt đồng hồ báo thức điện thoại vào lúc 6 giờ 30 sáng để thức dậy chạy bộ buổi sáng rèn luyện thân thể.',
        difficulty_level: 'basic'
      },
      {
        chinese: '突发的重大自然灾害给全社会的生态保护意识敲响了长鸣的警示闹钟，警醒人们决不能以牺牲自然生态为代价换取短期的经济利益。',
        pinyin: 'Tūfā de zhòngdà zìrán zāihài gěi quán shèhuì de shēngtài bǎohù yìshí qiāoxiǎng le chángmíng de jǐngshì nàozhōng, jǐngxǐng rénmen jué bùnéng yǐ xīshēng zìrán shēngtài wéi dàijià huànqǔ duǎnqī de jīngjì lìyì.',
        meaning_vi: 'Thiên tai thảm họa nghiêm trọng bất ngờ xảy ra đã gióng lên hồi chuông báo thức cảnh tỉnh ngân vang cho ý thức bảo vệ sinh thái của toàn xã hội, cảnh tỉnh con người tuyệt đối không thể lấy việc đánh đổi sinh thái tự nhiên làm cái giá để đổi lấy lợi ích kinh tế trước mắt.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2795,
    hanzi: '内部',
    pinyin: 'nèibù',
    word_type: 'Danh từ',
    meaning_vi: 'nội bộ, bên trong',
    examples: [
      {
        chinese: '公司定期召开内部员工交流分享会，促进各业务部门之间的协同合作。',
        pinyin: 'Gōngsī dìngqī zhàokāi nèibù yuángōng jiāoliú fēnxiǎnghuì, cùjìn gè yèwù bùmén zhījiān de xiétóng hézuò.',
        meaning_vi: 'Công ty định kỳ tổ chức các buổi giao lưu chia sẻ cho nhân viên nội bộ, thúc đẩy sự phối hợp hiệp đồng giữa các phòng ban nghiệp vụ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为防范化解金融系统性风险，商业银行必须加快建立健全穿透式内部风控审计体系与权责清晰的现代企业内部法人治理结构。',
        pinyin: 'Wèi fángfàn huàjiě jīnróng xìtǒngxìng fēngxiǎn, shāngyè yínháng bìxū jiākuài jiànlì jiànquán chuāntòushì nèibù fēngkòng shěnjì tǐxì yǔ quánzé qīngxī de xiàndài qǐyè nèibù fǎrén zhìlǐ jiégòu.',
        meaning_vi: 'Nhằm phòng ngừa và hóa giải rủi ro hệ thống tài chính, các ngân hàng thương mại phải khẩn trương hoàn thiện hệ thống kiểm toán kiểm soát rủi ro nội bộ có tính xuyên thấu cùng cơ cấu quản trị pháp nhân nội bộ doanh nghiệp hiện đại có quyền hạn trách nhiệm rõ ràng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2796,
    hanzi: '能干',
    pinyin: 'nénggàn',
    word_type: 'Tính từ',
    meaning_vi: 'tháo vát, đảm đang, giỏi giang, tài giỏi',
    examples: [
      {
        chinese: '小李工作勤快又善于解决复杂问题，是大家公认的能干助手。',
        pinyin: 'Xiǎo Lǐ gōngzuò qínkuài yòu shànyú jiějué fùzá wèntí, shì dàjiā gōngrèn de nénggàn zhùshǒu.',
        meaning_vi: 'Tiểu Lý làm việc nhanh nhẹn lại giỏi giải quyết các vấn đề phức tạp, là một trợ thủ tháo vát tài ba được mọi người công nhận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在基层治理一线，一大批政治过硬、作风扎实且极具实干担当精神的能干青年基层干部，正带领乡亲们在乡村振兴大道上阔步前行。',
        pinyin: 'Zài jīcéng zhìlǐ yíxiàn, yí dà pī zhèngzhì guòyìng, zuòfēng zhāshi qiě jí jù shígàn dāndāng jīngshén de nénggàn qīngnián jīcéng gànbù, zhèng dàilǐng xiāngqīnmen zài xiāngcūn zhènxīng dàdào shang kuòbù qiánxíng.',
        meaning_vi: 'Nơi tuyến đầu quản trị cơ sở, một lượng lớn cán bộ trẻ cơ sở tài giỏi có bản lĩnh chính trị vững vàng, tác phong sâu sát và tinh thần gánh vác dám nghĩ dám làm, đang dẫn dắt bà con sải bước vững vàng trên con đường chấn hưng nông thôn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2797,
    hanzi: '年初',
    pinyin: 'niánchū',
    word_type: 'Danh từ',
    meaning_vi: 'đầu năm, thời điểm đầu năm',
    examples: [
      {
        chinese: '每年年初，公司董事会都会制定并公布全年的核心经营业绩目标。',
        pinyin: 'Měi nián niánchū, gōngsī dǒngshìhuì dōu huì zhìdìng bìng gōngbù quán nián de héxīn jīngyíng yèjì mùbiāo.',
        meaning_vi: 'Vào đầu mỗi năm, hội đồng quản trị công ty đều xây dựng và công bố các mục tiêu thành tích kinh doanh cốt lõi của cả năm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '从年初国家统筹出台的一揽子增量宏观调控政策来看，扩大有效益的投资与激发有潜能的消费始终是贯穿全年的宏观主基调。',
        pinyin: 'Cóng niánchū guójiā tǒngchóu chūtái de yì lǎnzi zēngliàng hóngguān tiáokòng zhèngcè lái kàn, kuòdà yǒu xiàoyì de tóuzī yǔ jīfā yǒu qiánnéng de xiāofèi shǐzhōng shì guànchuān quán nián de hóngguān zhǔ jīdiào.',
        meaning_vi: 'Nhìn từ gói chính sách điều tiết vĩ mô gia tăng đồng bộ được nhà nước ban hành từ đầu năm, việc mở rộng đầu tư có hiệu quả và kích thích tiêu dùng có tiềm năng luôn là âm hưởng chủ đạo vĩ mô xuyên suốt cả năm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2798,
    hanzi: '年代',
    pinyin: 'niándài',
    word_type: 'Danh từ',
    meaning_vi: 'thập niên, niên đại, thời đại',
    examples: [
      {
        chinese: '上世纪八十年代流行的经典老歌，至今听起来依然感人至深。',
        pinyin: 'Shàng shìjì bāshí niándài liúxíng de jīngdiǎn lǎogē, zhìjīn tīng qǐlái yīrán gǎnrén-zhìshēn.',
        meaning_vi: 'Những bài hát kinh điển thịnh hành vào những năm 80 của thế kỷ trước, cho đến nay nghe lại vẫn vô cùng xúc động lòng người.',
        difficulty_level: 'basic'
      },
      {
        chinese: '那是一个激情燃烧的火红年代，老一辈科学家隐姓埋名于戈壁大漠，以“两弹一星”的惊世功勋挺起了新中国的民族脊梁。',
        pinyin: 'Nà shì yí gè jīqíng ránshāo de huǒhóng niándài, lǎoyíbèi kēxuéjiā yǐnxìng-máimíng yú gēbì dàmò, yǐ “liǎngtàn-yīxīng” de jīngshì gōngxūn tǐngqǐ le xīn Zhōngguó de mínzú jǐliáng.',
        meaning_vi: 'Đó là một thời đại rực lửa ngập tràn nhiệt huyết sôi trào, thế hệ các nhà khoa học đi trước ẩn danh chôn tích giữa sa mạc Gobi hoang vu, bằng chiến công chấn động thế giới "hai quả bom một vệ tinh" đã dựng đứng cột sống dân tộc của nước Trung Hoa mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2799,
    hanzi: '年纪',
    pinyin: 'niánjì',
    word_type: 'Danh từ',
    meaning_vi: 'tuổi tác, tuổi đời',
    examples: [
      {
        chinese: '奶奶虽然上了年纪，但走起路来依然精神矍铄脚步轻快。',
        pinyin: 'Nǎinai suīrán shàng le niánjì, dàn zǒu qǐ lù lai yīrán jīngshén-juéshuò jiǎobù qīngkuài.',
        meaning_vi: 'Bà nội tuy tuổi tác đã cao, nhưng đi lại vẫn quắc thước tinh anh và bước chân thoăn thoắt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '终身学习是抵御时代信息迭代焦虑的最佳良药，一个人无论处于何等年纪，只要保持对求知的渴望，人生便永远充满无限可能。',
        pinyin: 'Zhōngshēn xuéxí shì dǐyù shídài xìnxī diédài jiāolǜ de zuìjiā liángyào, yí gè rén wúlùn chǔyú héděng niánjì, zhǐyào bǎochí duì qiúzhī de kěwàng, rénshēng biàn yǒngyuǎn chōngmǎn wúxiàn kěnéng.',
        meaning_vi: 'Học tập suốt đời là liều thuốc bổ hữu hiệu nhất chống lại nỗi lo âu trước sự cải tiến thông tin của thời đại, một con người dẫu đang ở độ tuổi nào, chỉ cần giữ vững niềm khát khao tri thức thì cuộc đời sẽ luôn tràn đầy những tiềm năng vô tận.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2800,
    hanzi: '年夜饭',
    pinyin: 'niányèfàn',
    word_type: 'Danh từ',
    meaning_vi: 'bữa cơm tất niên, bữa cơm giao thừa',
    examples: [
      {
        chinese: '除夕之夜，全家人围坐在一起吃热气腾腾的年夜饭并收看春晚。',
        pinyin: 'Chúxī zhī yè, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de niányèfàn bìng shōukàn chūnwǎn.',
        meaning_vi: 'Vào đêm 30 Tết giao thừa, cả nhà quây quần bên nhau ăn bữa cơm tất niên bốc khói nghi ngút và đón xem chương trình đại hội mùa xuân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '一桌承载着家国温情的丰盛年夜饭，不仅是中华民族辞旧迎新最重要的仪式寄托，更是融化在海内外华人血脉深处的文化基因图景。',
        pinyin: 'Yì zhuō chéngzài zhe jiāguó wēnqíng de fēngshèng niányèfàn, bùjǐn shì Zhōnghuá mínzú cíjiù-yíngxīn zuì zhòngyào de yíshì jìtuō, gèngshì rónghuà zài hǎinèiwài Huárén xuèmài shēnchù de wénhuà jīyīn tújǐng.',
        meaning_vi: 'Một mâm cơm tất niên thịnh soạn chuyên chở hơi ấm tình cảm gia đình và quê hương không chỉ là điểm tựa nghi thức quan trọng nhất tống cựu nghinh tân của dân tộc Trung Hoa, mà còn là bức tranh gen văn hóa hòa tan sâu lắng trong huyết mạch của người Hoa khắp năm châu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2801,
    hanzi: '念',
    pinyin: 'niàn',
    word_type: 'Động từ',
    meaning_vi: 'đọc (thành tiếng); học tập; tưởng nhớ, nhớ nhung; niệm',
    examples: [
      {
        chinese: '语文老师请小明大声朗读课文里的第三个自然段。',
        pinyin: 'Yǔwén lǎoshī qǐng Xiǎo Míng dàshēng lǎngdú kèwén lǐ de dì-sān gè zìránduàn.',
        meaning_vi: 'Cô giáo dạy ngữ văn mời Tiểu Minh đọc to đoạn văn tự nhiên thứ ba trong bài học.',
        difficulty_level: 'basic'
      },
      {
        chinese: '身居海外的华侨华人始终心系故土，深切念想着祖国的繁荣富强，并以赤子之心积极投身于支持家乡建设的崇高事业之中。',
        pinyin: 'Shēnjū hǎiwài de huáqiáo-huárén shǐzhōng xīn xì gùtǔ, shēnqiè niànxiǎng zhe zǔguó de fánróng-fùqiáng, bìng yǐ chìzǐzhīxīn jījí tóushēn yú zhīchí jiāxiāng jiànshè de chónggāo shìyè zhīzhōng.',
        meaning_vi: 'Kiều bào sinh sống ở nước ngoài luôn hướng trọn trái tim về mảnh đất quê hương, tha thiết tưởng nhớ sự phồn vinh giàu mạnh của tổ quốc, và với tấm lòng son sắt đã tích cực dấn thân vào sự nghiệp cao cả ủng hộ xây dựng quê nhà.',
        difficulty_level: 'applied'
      }
    ]
  }
]
