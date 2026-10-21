// data/hsk5-batch16-part2-data.ts
// 25 từ HSK 5: #3527 [中药] -> #3551 [住宿]

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

export const HSK5_BATCH16_PART2: VocabItem[] = [
  {
    id: 3527,
    hanzi: '中药',
    pinyin: 'zhōngyào',
    word_type: 'Danh từ',
    meaning_vi: 'thuốc Đông y, thuốc bắc',
    examples: [
      {
        chinese: '老中医开具的这几副中药具有清热解毒、润肺止咳的良好温补功效。',
        pinyin: 'Lǎo zhōngyī kāijù de zhè jǐ fù zhōngyào jùyǒu qīngrè-jiědú, rùnfèi-zhǐké de liánghǎo wēnbǔ gōngxiào.',
        meaning_vi: 'Mấy thang thuốc Đông y do vị thầy thuốc đông y cao tuổi kê đơn có công hiệu thanh nhiệt giải độc, nhuận phổi ngừng ho bổ dưỡng ôn hòa rất tốt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家药监局加速推进传统经典名方中药复方制剂的标准化质量控制与现代药理活性成分现代化循证医学评价。',
        pinyin: 'Guójiā Yàojiānjú jiāsù tuījìn chuántǒng jīngdiǎn míngfāng zhōngyào fùfāng zhìjì de biāozhǔnhuà zhìliàng kòngzhì yǔ xiàndài yàolǐ huóxìng chéngfèn xiàndàihuà xúnzhèng yīxué pínggū.',
        meaning_vi: 'Cục Quản lý Dược phẩm Quốc gia đẩy nhanh kiểm soát chất lượng chuẩn hóa đối với các chế phẩm thuốc Đông y bài thuốc cổ phương kinh điển truyền thống và đánh giá y học thực chứng hiện đại hóa về các thành phần hoạt tính dược lý hiện đại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3528,
    hanzi: '中医',
    pinyin: 'zhōngyī',
    word_type: 'Danh từ',
    meaning_vi: 'Đông y, y học cổ truyền Trung Quốc, thầy thuốc Đông y',
    examples: [
      {
        chinese: '这位经验丰富的老中医仅仅通过搭脉与观察舌苔，就能准确说出患者平时的身体调理弱项。',
        pinyin: 'Zhè wèi jīngyàn fēngfù de lǎo zhōngyī jǐnjǐn tōngguò dāmài yǔ guānchá shétāi, jiù néng zhǔnquè shuō chū huànzhě píngshí de shēntǐ tiáolǐ ruòxiàng.',
        meaning_vi: 'Vị thầy thuốc Đông y giàu kinh nghiệm này chỉ qua việc bắt mạch và xem rêu lưỡi là đã có thể nói chính xác điểm yếu cần điều dưỡng cơ thể thường ngày của người bệnh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中西医结合重症救治协作机制在疑难杂症与急性感染病防治中充分发挥了中医治未病与整体调理的独特临床优势。',
        pinyin: 'Zhōng-xīyī jiéhé zhòngzhèng jiùzhì xiézuò jīzhì zài yínán-zázhèng yǔ jíxìng gǎnrǎnbìng fángzhì zhōng chōngfèn fāhuī le zhōngyī zhìwèibìng yǔ zhěngtǐ tiáolǐ de dútè línchuáng yōushì.',
        meaning_vi: 'Cơ chế hiệp đồng cấp cứu điều trị ca bệnh nặng kết hợp Đông - Tây y đã phát huy đầy đủ ưu thế lâm sàng độc đáo của Đông y về phòng bệnh từ sớm khi chưa phát và điều hòa cơ thể mang tính tổng thể trong phòng chống các ca bệnh nan y phức tạp và bệnh nhiễm trùng cấp tính.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3529,
    hanzi: '种类',
    pinyin: 'zhǒnglèi',
    word_type: 'Danh từ',
    meaning_vi: 'chủng loại, thể loại',
    examples: [
      {
        chinese: '这家大型进口水果连锁超市销售的热带水果种类繁多，涵盖了榴莲、芒果和红毛丹等数十个品种。',
        pinyin: 'Zhè jiā dàxíng jìnkǒu shuǐguǒ liánsuǒ chāoshì xiāoshòu de rèdài shuǐguǒ zhǒnglèi fánduō, hángài le liúlián, mángguǒ hé hóngmáodān děng shùshí ge pǐnzhǒng.',
        meaning_vi: 'Chuỗi siêu thị hoa quả nhập khẩu quy mô lớn này bày bán chủng loại trái cây nhiệt đới vô cùng phong phú, bao gồm hàng chục giống quả như sầu riêng, xoài và chôm chôm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '热带雨林是全球生物多样性最富集的基因宝库，保存着数以百万计尚未被人类科学界明确分类描述的珍稀动植物种类。',
        pinyin: 'Rèdài yǔlín shì quánqiú shēngwù duōyàngxìng zuì fùjí de jīyīn bǎokù, bǎocún zhe shù yǐ bǎiwàn jì shàngwèi bèi rénlèi kēxuéjiè míngquè fēnlèi miáoshù de zhēnxī dòng-zhíwù zhǒnglèi.',
        meaning_vi: 'Rừng mưa nhiệt đới là kho báu gen giàu có tập trung đa dạng sinh học nhất toàn cầu, lưu giữ hàng triệu chủng loại động thực vật quý hiếm chưa từng được giới khoa học nhân loại phân loại và miêu tả rõ ràng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3530,
    hanzi: '种子',
    pinyin: 'zhǒngzi',
    word_type: 'Danh từ',
    meaning_vi: 'hạt giống, mầm mống',
    examples: [
      {
        chinese: '春天正是播种的最好季节，农民伯伯在湿润肥沃的田地里播撒下一粒粒饱满的玉米种子。',
        pinyin: 'Chūntiān zhèng shì bōzhǒng de zuì hǎo jìjié, nóngmín bóbo zài shīrùn féiwò de tiándì lǐ bōsǎ xià yílìlì bǎomǎn de yùmǐ zhǒngzi.',
        meaning_vi: 'Mùa xuân chính là mùa gieo hạt tốt nhất, các bác nông dân gieo từng hạt giống ngô căng mẩy xuống những mảnh ruộng ẩm ướt màu mỡ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '种业振兴行动方案明确要求把种质资源安全上升到国家战略高度，坚决打赢核心农作物种子关键育种技术的翻身仗。',
        pinyin: 'Zhǒngyè zhènxīng xíngdòng fāng\'àn míngquè yāoqiú bǎ zhǒngzhì zīyuán ānquán shàngshēng dào guójiā zhànlüè gāodù, jiānjué dǎ yíng héxīn nóngzuòwù zhǒngzi guānjiàn yùzhǒng jìshù de fānshēnzhàng.',
        meaning_vi: 'Phương án hành động chấn hưng ngành giống cây trồng yêu cầu rõ ràng việc nâng mức an toàn nguồn tài nguyên giống lên tầm cao chiến lược quốc gia, kiên quyết đánh thắng trận chiến chuyển mình về công nghệ tạo giống then chốt đối với hạt giống cây trồng nông nghiệp cốt lõi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3531,
    hanzi: '重大',
    pinyin: 'zhòngdà',
    word_type: 'Tính từ',
    meaning_vi: 'trọng đại, to lớn',
    examples: [
      {
        chinese: '面对关乎未来职业发展前景的重大抉择，我们一定要保持冷静理性的心态认真分析。',
        pinyin: 'Miànduì guānhū wèilái zhíyè fāzhǎn qiánjǐng de zhòngdà juézé, wǒmen yídìng yào bǎochí lěngjìng lǐxìng de xīntài rènzhēn fēnxī.',
        meaning_vi: 'Đứng trước sự lựa chọn trọng đại liên quan đến tiền đồ phát triển sự nghiệp tương lai, chúng ta nhất định phải giữ tâm thế bình tĩnh và lý tính để phân tích cẩn thận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家超级计算中心在多核异构处理器并行算力架构研发中取得了重大原创突破，大幅提升了极端气候模拟预测算力效率。',
        pinyin: 'Guójiā chāojí jìsuàn zhōngxīn zài duōhé yìgòu chǔlǐqì bìngxíng suànlì jiàgòu yánfā zhōng qǔdé le zhòngdà yuánchuàng tūpò, dàfú tíshēng le jíduān qìhòu mónǐ yùcè suànlì xiàolǜ.',
        meaning_vi: 'Trung tâm siêu máy tính quốc gia đã đạt được bước đột phá nguyên bản trọng đại trong nghiên cứu phát triển kiến trúc sức mạnh tính toán song song bộ xử lý đa nhân dị thể, nâng cao vượt bậc hiệu suất năng lực tính toán dự báo mô phỏng khí hậu cực đoan.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3532,
    hanzi: '众多',
    pinyin: 'zhòngduō',
    word_type: 'Tính từ',
    meaning_vi: 'đông đảo, nhiều, vô số',
    examples: [
      {
        chinese: '在市中心刚刚开业的大型购物商场里，汇聚了海内外众多知名时尚品牌服装店。',
        pinyin: 'Zài shìzhōngxīn gānggāng kāiyè de dàxíng gòuwù shāngchǎng lǐ, huìjù le hǎinèiwài zhòngduō zhīmíng shíshàng pǐnpái fúzhuāngdiàn.',
        meaning_vi: 'Bên trong trung tâm mua sắm lớn vừa mới khai trương ở trung tâm thành phố đã hội tụ đông đảo cửa hàng quần áo thương hiệu thời trang nổi tiếng trong và ngoài nước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '开源大模型开发者生态凭借其透明的代码架构与低成本调用接口，迅速吸纳了全球数以万计的企业与众多独立开发者加入。',
        pinyin: 'Kāiyuán dà-móxíng kāifāzhě shēngtài píngjiè qí tòumíng de dàimǎ jiàgòu yǔ dī-chéngběn diàoyòng jiēkǒu, xùnsù xīnà le quánqiú shù yǐ wàn jì de qǐyè yǔ zhòngduō dúlì kāifāzhě jiārù.',
        meaning_vi: 'Hệ sinh thái nhà phát triển mô hình lớn mã nguồn mở nhờ kiến trúc mã minh bạch và giao diện gọi API chi phí thấp đã nhanh chóng thu hút hàng vạn doanh nghiệp và đông đảo nhà phát triển độc lập trên toàn cầu tham gia.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3533,
    hanzi: '重量',
    pinyin: 'zhòngliàng',
    word_type: 'Danh từ',
    meaning_vi: 'trọng lượng, sức nặng',
    examples: [
      {
        chinese: '在乘坐国际民航客机托运行李时，地勤工作人员会仔细称量每一件箱包的实际重量。',
        pinyin: 'Zài chéngzuò guójì mínháng kèjī tuōyùn xíngli shí, dìqín gōngzuò rényuán huì zǐxì chēngliáng měi yí jiàn xiāngbāo de shíjì zhòngliàng.',
        meaning_vi: 'Khi đi máy bay chở khách hàng không dân dụng quốc tế gửi hành lý ký gửi, nhân viên mặt đất sẽ cẩn thận cân đo trọng lượng thực tế của từng kiện vali túi xách.',
        difficulty_level: 'basic'
      },
      {
        chinese: '新一代民用大型客机广泛采用先进碳纤维复合材料替代传统航空铝合金，在显著降低机身结构重量的同时极大提升了燃油经济性。',
        pinyin: 'Xīn-yídài mínyòng dàxíng kèjī guǎngfàn cǎiyòng xiānjìn tàn-xiānwéi fùhé cáiliào tìdài chuántǒng hángkōng lǚhégīn, zài xiǎnzhù jiàngdī jīshēn jiégòu zhòngliàng de tóngshí jídà tíshēng le rányóu jīngjìxìng.',
        meaning_vi: 'Máy bay chở khách cỡ lớn dân dụng thế hệ mới áp dụng rộng rãi vật liệu composite sợi carbon tiên tiến thay thế hợp kim nhôm hàng không truyền thống, cùng lúc hạ giảm rõ rệt trọng lượng cấu trúc thân máy bay đã nâng cao vượt bậc tính kinh tế nhiên liệu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3534,
    hanzi: '种植',
    pinyin: 'zhòngzhí',
    word_type: 'Động từ',
    meaning_vi: 'trồng trọt, canh tác',
    examples: [
      {
        chinese: '为了绿化美化庭院环境，他在小花园的围栏旁种植了几株花期很长的爬藤月季花。',
        pinyin: 'Wèile lǜhuà měihuà tíngyuàn huánjìng, tā zài xiǎo huāyuán de wéilán páng zhòngzhí le jǐ zhū huāqī hěn cháng de páténg yuèjìhuā.',
        meaning_vi: 'Để phủ xanh làm đẹp môi trường sân vườn, anh ấy đã trồng mấy gốc hoa hồng leo có thời gian nở hoa rất dài bên cạnh hàng rào vườn hoa nhỏ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代数字农业示范园区采用无土栽培与智能精准滴灌水肥一体化技术，实现了特色高附加值果蔬的工厂化周年种植。',
        pinyin: 'Xiàndài shùzì nóngyè shìfàn yuánqū cǎiyòng wútǔ zāipéi yǔ zhìnéng jīngzhǔn dīguàn shuǐ-féi yītǐhuà jìshù, shíxiàn le tèsè gāo-fùjiāzhí guǒshū de gōngchǎnghuà zhōunián zhòngzhí.',
        meaning_vi: 'Khu công viên trình diễn nông nghiệp số hiện đại áp dụng công nghệ thủy canh không cần đất và tưới nhỏ giọt thông minh chuẩn xác nhất thể hóa phân bón - nước, hiện thực hóa việc trồng trọt rau quả đặc sản giá trị gia tăng cao dạng nhà máy quanh năm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3535,
    hanzi: '周年',
    pinyin: 'zhōunián',
    word_type: 'Danh từ',
    meaning_vi: 'chu niên, tròn năm, ngày kỷ niệm năm',
    examples: [
      {
        chinese: '这所历史悠久的全国知名大学将于下个月隆重举行建校一百周年的庆典大会。',
        pinyin: 'Zhè suǒ lìshǐ yōujiǔ de quánguó zhīmíng dàxué jiāng yú xià ge yuè lóngzhòng jǔxíng jiànxiào yìbǎi zhōunián de qìngdiǎn dàhuì.',
        meaning_vi: 'Trường đại học nổi tiếng toàn quốc có lịch sử lâu đời này sẽ long trọng tổ chức đại lễ kỷ niệm 100 năm thành lập trường vào tháng tới.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在两国建交五十周年纪念峰会上，双方领导人共同签署了深化全天候全面战略伙伴关系的联合声明与多项经贸合作协定。',
        pinyin: 'Zài liǎng guó jiànjiāo wǔshí zhōunián jìniàn fēnghuì shang, shuāngfāng lǐngdǎorén gòngtóng qiānshǔ le shēnhuà quántiānhòu quánmiàn zhànlüè huǒbàn guānxì de liánhé shēngmíng yǔ duō xiàng jīng-mào hézuò xiédìng.',
        meaning_vi: 'Tại hội nghị thượng đỉnh kỷ niệm 50 năm thiết lập quan hệ ngoại giao giữa hai nước, các nhà lãnh đạo hai bên đã cùng ký tuyên bố chung và nhiều hiệp định hợp tác kinh tế thương mại làm sâu sắc thêm quan hệ đối tác chiến lược toàn diện mọi thời tiết.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3536,
    hanzi: '猪',
    pinyin: 'zhū',
    word_type: 'Danh từ',
    meaning_vi: 'con lợn, con heo',
    examples: [
      {
        chinese: '农家小院的围栏里养着几头肥壮的小花猪，每天吃着天然饲料长得非常健康。',
        pinyin: 'Nóngjiā xiǎoyuàn de wéilán lǐ yǎng zhe jǐ tóu féizhuàng de xiǎohuāzhū, měitiān chī zhe tiānrán sìliào zhǎng de fēicháng jiànkāng.',
        meaning_vi: 'Trong hàng rào sân nhỏ nhà nông có nuôi mấy chú lợn khoang mập mạp, ngày ngày ăn thức ăn tự nhiên lớn lên rất khỏe mạnh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代化生猪立体生态养殖示范基地全面配备智能巡检机器人、温湿度自动环控与粪污全量资源化沼气发电闭环系统。',
        pinyin: 'Xiàndàihuà shēngzhū lìtǐ shēngtài yǎngzhí shìfàn jīdì quánmiàn pèibèi zhìnéng xúnjiǎn jīqìrén, wēn-shīdù zìdòng huánkòng yǔ fènwū quánliàng zīyuánhuà zhǎoqì fādiàn bìhuán xìtǒng.',
        meaning_vi: 'Căn cứ trình diễn nuôi lợn thịt sinh thái đa tầng hiện đại hóa được trang bị toàn diện robot tuần tra kiểm tra thông minh, hệ thống kiểm soát môi trường nhiệt độ - độ ẩm tự động và vòng tuần hoàn phát điện khí sinh học tận dụng toàn bộ chất thải làm tài nguyên.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3537,
    hanzi: '逐步',
    pinyin: 'zhúbù',
    word_type: 'Phó từ',
    meaning_vi: 'từng bước một, tuần tự',
    examples: [
      {
        chinese: '通过持续不断的词汇积累与口语练习，他的中文表达能力正在逐步得到提高。',
        pinyin: 'Tōngguò chíxù-búduàn de cíhuì jīlěi yǔ kǒuyǔ liànxí, tā de Zhōngwén biǎodá nénglì zhèngzài zhúbù dédào tígāo.',
        meaning_vi: 'Thông qua việc không ngừng tích lũy từ vựng và luyện tập khẩu ngữ, khả năng diễn đạt tiếng Trung của anh ấy đang từng bước được nâng cao.',
        difficulty_level: 'basic'
      },
      {
        chinese: '金融监管部门坚持审慎稳健原则，稳妥推进本币国际化并逐步放开合格境外机构投资者的境内资本市场投资额度限制。',
        pinyin: 'Jīnróng jiānguǎn bùmén jiānchí shěnshèn wěnjiàn yuánzé, wěntuǒ tuījìn běnbì guójìhuà bìng zhúbù fàngkāi hégé jìngwài jīgòu tóuzīzhě de jìngnèi zīběn shìchǎng tóuzī édù xiànzhì.',
        meaning_vi: 'Cơ quan giám sát tài chính kiên trì nguyên tắc thận trọng vững chắc, đẩy mạnh vững vàng việc quốc tế hóa đồng nội tệ và từng bước nới lỏng giới hạn hạn mức đầu tư vào thị trường vốn trong nước đối với các nhà đầu tư tổ chức nước ngoài đủ điều kiện.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3538,
    hanzi: '逐渐',
    pinyin: 'zhújiàn',
    word_type: 'Phó từ',
    meaning_vi: 'dần dần, từ từ',
    examples: [
      {
        chinese: '太阳下山以后，原本热闹喧嚣的海滨沙滩逐渐恢复了宁静与安详。',
        pinyin: 'Tàiyáng xiàshān yǐhòu, yuánběn rènao xuānxiāo de hǎibīn shātān zhújiàn huīfù le níngjìng yǔ ānxiáng.',
        meaning_vi: 'Sau khi mặt trời lặn xuống núi, bãi cát ven biển vốn náo nhiệt ồn ào dần dần khôi phục lại vẻ yên tĩnh và thanh bình.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着可再生清洁能源装机规模的井喷式增长，传统化石能源在国家总体能源消耗结构中的主导地位正在逐渐被绿电所替代。',
        pinyin: 'Suízhe kězàishēng qīngjié néngyuán zhuāngjī guīmó de jǐngpēnshì zēngzhǎng, chuántǒng huàshí néngyuán zài guójiā zǒngtǐ néngyuán xiāohào jiégòu zhōng de zhǔdǎo dìwèi zhèngzài zhújiàn bèi lǜdiàn suǒ tìdài.',
        meaning_vi: 'Cùng với sự tăng trưởng bùng nổ theo kiểu phun trào về quy mô công suất lắp đặt năng lượng sạch tái tạo, vị thế chủ đạo của năng lượng hóa thạch truyền thống trong cơ cấu tiêu thụ năng lượng tổng thể quốc gia đang dần dần được thay thế bằng điện xanh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3539,
    hanzi: '竹子',
    pinyin: 'zhúzi',
    word_type: 'Danh từ',
    meaning_vi: 'cây tre, cây trúc',
    examples: [
      {
        chinese: '大熊猫非常喜欢吃清脆新鲜的竹子，每天大部分时间都在悠闲地咀嚼竹叶和竹笋。',
        pinyin: 'Dàxióngmāo fēicháng xǐhuan chī qīngcuì xīnxiān de zhúzi, měitiān dà bùfen shíjiān dōu zài yōuxián de jǔjué zhúyè hé zhúsǔn.',
        meaning_vi: 'Gấu trúc khổng lồ rất thích ăn tre trúc tươi giòn, phần lớn thời gian mỗi ngày đều ung dung nhai lá tre và măng tre.',
        difficulty_level: 'basic'
      },
      {
        chinese: '以竹代塑产业创新联盟通过先进纳米生物改性技术，将速生竹子资源深度加工成高强度全生物降解环保包装与结构材料。',
        pinyin: 'Yǐ-zhú-dài-sù chǎnyè chuàngxīn liánméng tōngguò xiānjìn nàmǐ shēngwù gǎixìng jìshù, jiāng sùshēng zhúzi zīyuán shēndù jiāgōng chéng gāogiángdù quán-shēngwù-jiàngjiě huánbǎo bāozhuāng yǔ jiégòu cáiliào.',
        meaning_vi: 'Liên minh đổi mới công nghiệp "lấy tre thay nhựa" thông qua công nghệ biến tính sinh học nano tiên tiến đã gia công sâu nguồn tài nguyên tre sinh trưởng nhanh thành bao bì bảo vệ môi trường phân hủy sinh học hoàn toàn và vật liệu kết cấu có độ bền cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3540,
    hanzi: '煮',
    pinyin: 'zhǔ',
    word_type: 'Động từ',
    meaning_vi: 'nấu, luộc, đun sôi',
    examples: [
      {
        chinese: '冬天的早晨，妈妈早早起床在厨房里为全家人煮了一锅热气腾腾的红枣小米粥。',
        pinyin: 'Dōngtiān de zǎochén, māma zǎozǎo qǐchuáng zài chúfáng lǐ wèi quánjiārén zhǔ le yì guō rèqì-téngténg de hóngzǎo xiǎomǐzhōu.',
        meaning_vi: 'Buổi sáng mùa đông, mẹ thức dậy từ sớm ở trong bếp nấu cho cả gia đình một nồi cháo kê táo đỏ nóng hôi hổi bốc khói nghi ngút.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代食品工业真空低温蒸煮技术精确锁定肉制品的肌原纤维蛋白多肽结构，完美保留了食材的原生风味与天然营养成分。',
        pinyin: 'Xiàndài shípǐn gōngyè zhēnkōng dīwēn zhēngzhǔ jìshù jīngquè suǒdìng ròuzhìpǐn de jīyuán-xiānwéi dànbái duōtài jiégòu, wánměi bǎoliú le shícái de yuánshēng fēngwèi yǔ tiānrán yíngyǎng chéngfèn.',
        meaning_vi: 'Công nghệ hấp nấu chân không nhiệt độ thấp của công nghiệp thực phẩm hiện đại khóa chuẩn xác cấu trúc polypeptide protein sợi cơ của sản phẩm thịt, lưu giữ hoàn hảo hương vị nguyên bản và thành phần dinh dưỡng tự nhiên của nguyên liệu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3541,
    hanzi: '主持',
    pinyin: 'zhǔchí',
    word_type: 'Động từ',
    meaning_vi: 'chủ trì, dẫn chương trình, đảm đương',
    examples: [
      {
        chinese: '这位年轻的女主持人台风大方优雅、普通话标准，成功主持了本次校园歌手大赛。',
        pinyin: 'Zhè wèi niánqīng de nǚ zhǔchírén táifēng dàfang yōuyǎ, pǔtōnghuà biāozhǔn, chénggōng zhǔchí le běncì xiàoyuán gēshǒu dàsài.',
        meaning_vi: 'Cô nữ dẫn chương trình trẻ tuổi này phong thái sân khấu đĩnh đạc tao nhã, phát âm tiếng phổ thông chuẩn mực, đã dẫn chương trình thành công cuộc thi ca sĩ học đường lần này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际货币基金组织总裁主持召开了多边主权债务重组高级别圆桌闭门会议，积极协调各主权债权国共同防范发展中国家系统性债务违约。',
        pinyin: 'Guójì Huòbì Jījīn Zǔzhī zǒngcái zhǔchí zhàokāi le duōbiān zhǔquán zhàiwù chóngzǔ gāojíbié yuánzhuō bìmén huìyì, jījí xiétiáo gè zhǔquán zhàiquánguó gòngtóng fángfàn fāzhǎnzhōng guójiā xìtǒngxìng zhàiwù wéiyuē.',
        meaning_vi: 'Tổng giám đốc Quỹ Tiền tệ Quốc tế đã chủ trì cuộc họp bàn tròn kín cấp cao về tái cơ cấu nợ chủ quyền đa phương, tích cực điều phối các quốc gia chủ nợ cùng phòng chống vỡ nợ mang tính hệ thống của các quốc gia đang phát triển.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3542,
    hanzi: '主动',
    pinyin: 'zhǔdòng',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'chủ động',
    examples: [
      {
        chinese: '在新的工作环境中，我们要主动与同事沟通交流，积极融入整个团队大家庭。',
        pinyin: 'Zài xīn de gōngzuò huánjìng zhōng, wǒmen yào zhǔdòng yǔ tóngshì gōutōng jiāoliú, jījí róngrù zhěnggè tuánduì dàjiātíng.',
        meaning_vi: 'Trong môi trường làm việc mới, chúng ta cần chủ động trao đổi giao lưu với các đồng nghiệp, tích cực hòa nhập vào đại gia đình toàn đội ngũ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对国际经贸规则的深刻调整，我国坚定不移主动对接国际高标准经贸规则，稳步扩大制度型开放以赢得未来全球竞争主动权。',
        pinyin: 'Miànduì guójì jīng-mào guīzé de shēndù tiáozhěng, wǒguó jiāndìng-bùyí zhǔdòng duìjiē guójì gāobiāozhǔn jīng-mào guīzé, wěnbù kuòdà zhìdùxíng kāifàng yǐ yíngdé wèilái quánqiú jìngzhēng zhǔdòngquán.',
        meaning_vi: 'Đứng trước sự điều chỉnh sâu sắc của các quy tắc kinh tế thương mại quốc tế, nước ta kiên định không dời chủ động kết nối với các quy tắc thương mại tiêu chuẩn cao quốc tế, mở rộng vững chắc sự mở cửa dạng thể chế nhằm giành quyền chủ động cạnh tranh toàn cầu trong tương lai.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3543,
    hanzi: '主观',
    pinyin: 'zhǔguān',
    word_type: 'Tính từ',
    meaning_vi: 'chủ quan',
    examples: [
      {
        chinese: '我们在评价一个人的工作表现时，应当摆事实讲道理，不能掺杂过多个人主观偏见。',
        pinyin: 'Wǒmen zài píngjià yí ge rén de gōngzuò biǎoxiàn shí, yīngdāng bǎi shìshí jiǎng dàolǐ, bù néng chānzá guòduō gèrén zhǔguān piānjiàn.',
        meaning_vi: 'Chúng ta khi đánh giá biểu hiện công tác của một con người cần phải đưa ra sự thật nói rõ lý lẽ, không thể pha trộn quá nhiều thành kiến chủ quan cá nhân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '宏观金融风险评估体系必须依赖可量化的大数据客观压力测试模型，有效规避人工研判中易于产生的经验主义与主观臆断误差。',
        pinyin: 'Hóngguān jīnróng fēngxiǎn pínggū tǐxì bìxū yīlài kě-liànghuà de dà-shùjù kèguān yālì cèshì móxíng, yǒuxiào guībì réngōng yánpàn zhōng yìyú chǎnshēng de jīngyànzhǔyì yǔ zhǔguān yìduàn wùchā.',
        meaning_vi: 'Hệ thống đánh giá rủi ro tài chính vĩ mô bắt buộc phải phụ thuộc vào các mô hình kiểm tra sức chịu tải khách quan dữ liệu lớn có thể lượng hóa, né tránh một cách hiệu quả sai số suy đoán chủ quan và chủ nghĩa kinh nghiệm dễ nảy sinh trong phán đoán thủ công bằng con người.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3544,
    hanzi: '主人',
    pinyin: 'zhǔrén',
    word_type: 'Danh từ',
    meaning_vi: 'chủ nhân, chủ nhà',
    examples: [
      {
        chinese: '每当有远道而来的客人登门拜访，热情好客的房主人总是会端出香浓的清茶招待。',
        pinyin: 'Měidāng yǒu yuǎndào-érlái de kèrén dēngmén bàifǎng, rèqíng-hàokè de fángzhǔrén zǒngshì huì duān chū xiāngnóng de qīngchá zhāodài.',
        meaning_vi: 'Mỗi khi có khách từ phương xa đến thăm nhà, người chủ nhà nhiệt tình mến khách bao giờ cũng bưng ra chén trà thanh thơm ngát thết đãi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全过程人民民主深刻保障了广大人民群众作为国家和社会主人的崇高政治地位，实现最广泛而真实的民主权利。',
        pinyin: 'Quán-guòchéng rénmín mínzhǔ shēndù bǎozhàng le guǎngdà rénmín qúnzhòng zuòwéi guójiā hé shèhuì zhǔrén de chónggāo zhèngzhì dìwèi, shíxiàn zuì guǎngfàn ér zhēnshí de mínzhǔ quánlì.',
        meaning_vi: 'Nền dân chủ nhân dân toàn quá trình đã bảo đảm sâu sắc vị thế chính trị cao cả của đông đảo quần chúng nhân dân với tư cách là chủ nhân của đất nước và xã hội, hiện thực hóa các quyền dân chủ chân thực và rộng rãi nhất.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3545,
    hanzi: '主任',
    pinyin: 'zhǔrèn',
    word_type: 'Danh từ',
    meaning_vi: 'chủ nhiệm, trưởng phòng',
    examples: [
      {
        chinese: '医院内科门诊部的张主任从医三十余年，凭借精湛的医术深受广大患者的信赖。',
        pinyin: 'Yīyuàn nèikē ménzhěnbù de Zhāng zhǔrèn cóngyī sānshí yú nián, píngjiè jīngzhàn de yīshù shēnshòu guǎngdà huànzhě de xìnlài.',
        meaning_vi: 'Bác sĩ chủ nhiệm Trương của khoa nội phòng khám bệnh viện hành nghề y hơn ba mươi năm, nhờ y thuật tinh xảo mà nhận được sự tin yêu sâu sắc của đông đảo bệnh nhân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家发展改革委相关职能司局主任在新闻发布会上全面解读了关于促进民营经济发展壮大的多项重大政策举措。',
        pinyin: 'Guójiā Fāzhǎn Gǎigé Wěi xiāngguān zhínéng sījú zhǔrèn zài xīnwén fābùhuì shang quánmiàn jiědú le guānyú cùjìn mínyíng jīngjì fāzhǎn zhuàngdà de duō xiàng zhòngdà zhèngcè jǔcuò.',
        meaning_vi: 'Chủ nhiệm cục vụ chức năng liên quan thuộc Ủy ban Cải cách và Phát triển Quốc gia tại buổi họp báo đã diễn giải toàn diện nhiều biện pháp chính sách trọng đại về việc thúc đẩy kinh tế tư nhân phát triển lớn mạnh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3546,
    hanzi: '主食',
    pinyin: 'zhǔshí',
    word_type: 'Danh từ',
    meaning_vi: 'món ăn chính, lương thực chính (cơm, mì, bánh mì...)',
    examples: [
      {
        chinese: '在中国北方地区，人们习惯把馒头、面条和饺子等面食当作一日三餐的主食。',
        pinyin: 'Zài Zhōngguó běifāng dìqū, rénmen xíguàn bǎ mántou, miàntiáo hé jiǎozi děng miànshí dàngzuò yírì-sāncān de zhǔshí.',
        meaning_vi: 'Ở khu vực miền bắc Trung Quốc, mọi người có thói quen lấy các món làm từ bột mì như bánh bao chay, mì sợi và sủi cảo làm món ăn chính trong ba bữa mỗi ngày.',
        difficulty_level: 'basic'
      },
      {
        chinese: '临床营养学与慢性病代谢研究表明，合理提升全谷物与低升糖指数杂粮在日常主食中的摄入比例，有助于显著降低心血管与糖尿病患病风险。',
        pinyin: 'Línchuáng yíngyǎngxué yǔ mànxìngbìng dàixiè yánjiū biǎomíng, hélǐ tíshēng quán-gǔwù yǔ dī-shēngtáng-zhǐshù záliáng zài rìcháng zhǔshí zhōng de shèrù bǐlì, yǒu zhùyú xiǎnzhù jiàngdī xīnxuèguǎn yǔ tángniàobìng huànbìng fēngxiǎn.',
        meaning_vi: 'Nghiên cứu chuyển hóa bệnh mãn tính và dinh dưỡng lâm sàng chỉ ra rằng việc nâng cao hợp lý tỷ lệ nạp ngũ cốc nguyên hạt và các loại hạt thô có chỉ số đường huyết thấp trong món ăn chính hàng ngày có tác dụng hạ giảm rõ rệt nguy cơ mắc bệnh tim mạch và tiểu đường.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3547,
    hanzi: '主题',
    pinyin: 'zhǔtí',
    word_type: 'Danh từ',
    meaning_vi: 'chủ đề',
    examples: [
      {
        chinese: '本次校园英语演讲比赛的主题是青年与时代使命，吸引了来自全校各个院系的选手参与。',
        pinyin: 'Běncì xiàoyuán Yīngyǔ yǎnjiǎng bǐsài de zhǔtí shì qīngnián yǔ shídài shǐmìng, xīyǐn le láizì quán xiào gè ge yuànxì de xuǎnshǒu cānyù.',
        meaning_vi: 'Chủ đề của cuộc thi hùng biện tiếng Anh học đường lần này là thanh niên và sứ mệnh thời đại, đã thu hút các thí sinh đến từ khắp các khoa viện trong toàn trường tham gia.',
        difficulty_level: 'basic'
      },
      {
        chinese: '达沃斯世界经济论坛年会围绕推动全球经济在分化中实现包容性韧性增长的主题展开了多场高级别闭门战略对话。',
        pinyin: 'Dáwòsī Shìjiè Jīngjì Lùntán niánhuì wéirào tuīdòng quánqiú jīngjì zài fēnhuà zhōng shíxiàn bāoróngxìng rènxìng zēngzhǎng de zhǔtí zhǎnkāi le duō chǎng gāojíbié bìmén zhànlüè duìhuà.',
        meaning_vi: 'Hội nghị thường niên Diễn đàn Kinh tế Thế giới Davos xoay quanh chủ đề thúc đẩy nền kinh tế toàn cầu đạt được mức tăng trưởng kiên cường bao trùm giữa bối cảnh phân hóa đã triển khai nhiều phiên đối thoại chiến lược kín cấp cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3548,
    hanzi: '主席',
    pinyin: 'zhǔxí',
    word_type: 'Danh từ',
    meaning_vi: 'chủ tịch',
    examples: [
      {
        chinese: '在今天下午召开的班委会换届选举中，李明同学以高票当选为新一届班级学生会主席。',
        pinyin: 'Zài jīntiān xiàwǔ zhàokāi de bānwěihuì huànjiè xuǎnjǔ zhōng, Lǐ Míng tóngxué yǐ gāopiào dāngxuǎn wéi xīn-yí-jiè bānjí xuéshenghuì zhǔxí.',
        meaning_vi: 'Trong cuộc bầu cử chuyển giao nhiệm kỳ ban cán sự lớp triệu tập chiều nay, bạn Lý Minh đã trúng cử làm chủ tịch hội sinh viên lớp khóa mới với số phiếu cao.',
        difficulty_level: 'basic'
      },
      {
        chinese: '二十国集团轮值主席国领导人在峰会开幕致辞中呼吁各成员国摒弃零和博弈思维，深化全球宏观经济政策协同与绿色转型投资。',
        pinyin: 'Èrshí Guó Jítuán lúnzhí zhǔxíguó lǐngdǎorén zài fēnghuì kāimù zhìcí zhōng hūyù gè chéngyuánguó bìngqì línghé-bóyì sīwéi, shēnhuà quánqiú hóngguān jīngjì zhèngcè xiétóng yǔ lǜsè zhuǎnxíng tóuzī.',
        meaning_vi: 'Nhà lãnh đạo quốc gia chủ tịch luân phiên G20 trong bài phát biểu khai mạc hội nghị thượng đỉnh đã kêu gọi các nước thành viên gạt bỏ tư duy được mất tổng bằng không, làm sâu sắc thêm sự phối hợp chính sách kinh tế vĩ mô toàn cầu và đầu tư chuyển đổi xanh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3549,
    hanzi: '注册',
    pinyin: 'zhùcè',
    word_type: 'Động từ',
    meaning_vi: 'đăng ký, đăng kiểm, ghi danh',
    examples: [
      {
        chinese: '新学期开学第一天，同学们都需要携带学生证到教务处大厅办理学籍报到与注册手续。',
        pinyin: 'Xīn-xuéqī kāixué dì-yī tiān, tóngxuémen dōu xūyào xiédài xuéshengzhèng dào jiàowùchù dàtīng bànlǐ xuéjí bàodào yǔ zhùcè shǒuxù.',
        meaning_vi: 'Ngày đầu tiên khai giảng học kỳ mới, các bạn học sinh đều cần mang theo thẻ học sinh đến đại sảnh phòng giáo vụ làm thủ tục báo danh và đăng ký học tịch.',
        difficulty_level: 'basic'
      },
      {
        chinese: '资本市场全面实行股票发行注册制改革，将企业发行上市的选择权真正交给市场，强化全流程信息披露与退市常态化监管。',
        pinyin: 'Zīběn shìchǎng quánmiàn shíxíng gǔpiào fāxíng zhùcèzhì gǎigé, jiāng qǐyè fāxíng shàngshì de xuǎnzéquán zhēnzhèng jiāo gěi shìchǎng, qiánghuà quán-liúchéng xìnxī pīlù yǔ tuìshì chángtàihuà jiānguǎn.',
        meaning_vi: 'Thị trường vốn thực hiện toàn diện cải cách chế độ đăng ký phát hành cổ phiếu, thực sự trao quyền lựa chọn phát hành niêm yết của doanh nghiệp cho thị trường, tăng cường công bố thông tin toàn quy trình và giám sát bình thường hóa việc hủy niêm yết.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3550,
    hanzi: '住房',
    pinyin: 'zhùfáng',
    word_type: 'Danh từ',
    meaning_vi: 'nhà ở, chỗ ở',
    examples: [
      {
        chinese: '为了减轻年轻大学毕业生的租房压力，市政府专门兴建了一批租金优惠的人才保障性住房。',
        pinyin: 'Wèile jiǎnqīng niánqīng dàxué bìyèshēng de zūfáng yālì, shì zhèngfǔ zhuānmén xīngjiàn le yì pī zūjīn yōuhuì de réncái bǎozhàngxìng zhùfáng.',
        meaning_vi: 'Để giảm bớt áp lực thuê nhà cho các sinh viên đại học trẻ mới tốt nghiệp, chính quyền thành phố đã đặc biệt xây dựng một đợt nhà ở xã hội bảo đảm cho nhân tài có giá thuê ưu đãi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '健全租购并举的住房制度并加快构建房地产发展新模式，是有效化解高杠杆房企债务风险与实现住有所居的核心制度设计。',
        pinyin: 'Jiànquán zū-gòu bìngjǔ de zhùfáng zhìdù bìng jiākuài gòujiàn fángdìchǎn fāzhǎn xīn móshì, shì yǒuxiào huàjiě gāo-gànggǎn fángqǐ zhàiwù fēngxiǎn yǔ shíxiàn zhùyǒusuǒjū de héxīn zhìdù shèjì.',
        meaning_vi: 'Hoàn thiện chế độ nhà ở kết hợp đồng thời giữa thuê và mua cùng việc đẩy nhanh xây dựng mô hình phát triển bất động sản mới là thiết kế thể chế cốt lõi nhằm giải tỏa hiệu quả rủi ro nợ của doanh nghiệp bất động sản đòn bẩy cao và hiện thực hóa mục tiêu an cư lạc nghiệp cho người dân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3551,
    hanzi: '住宿',
    pinyin: 'zhùsù',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'trọ lại, lưu trú, chỗ ở',
    examples: [
      {
        chinese: '我们在出发去海滨风景区旅行之前，已经在网上提前预订好了三晚的酒店住宿。',
        pinyin: 'Wǒmen zài chūfā qù hǎibīn fēngjǐngqū lǚxíng zhīqián, yǐjīng zài wǎngshang tíqián yùdìng hǎo le sān wǎn de jiǔdiàn zhùsù.',
        meaning_vi: 'Trước khi xuất phát đi du lịch ở khu thắng cảnh ven biển, chúng tôi đã đặt trước ba đêm lưu trú tại khách sạn trên mạng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际青年交流营地为来自全球数十个国家的留学生提供完备的餐饮、多功能学术研讨空间与高品质无障碍住宿设施。',
        pinyin: 'Guójì qīngnián jiāoliú yíngdì wèi láizì quánqiú shùshí ge guójiā de liúxuéshēng tígōng wánbèi de cānyǐn, duō-gōngnéng xuéshù yántǎo kōngjiān yǔ gāopǐnzhì wú-zhàng\'ài zhùsù shèshī.',
        meaning_vi: 'Khu trại giao lưu thanh niên quốc tế cung cấp dịch vụ ăn uống hoàn bị, không gian hội thảo học thuật đa chức năng cùng các tiện nghi lưu trú không rào cản chất lượng cao cho lưu học sinh đến từ hàng chục quốc gia trên toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  }
]
