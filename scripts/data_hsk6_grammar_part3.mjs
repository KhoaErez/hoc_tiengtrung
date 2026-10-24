// ==============================================================================
// DATA: data_hsk6_grammar_part3.mjs
// HSK 6 GRAMMAR - PART 3: ĐIỂM 63 ĐẾN 93 (CHUẨN GF 0025-2021 APPENDIX A)
// Giới từ văn ngôn cổ phong đa năng (于, 以, 依, 因, 藉, 偕), Liên từ triết học & Thành ngữ ngữ pháp hóa HSK 6
// ==============================================================================

export const HSK6_GRAMMAR_PART3 = [
  {
    order_index: 63,
    name: 'Giới từ văn ngôn chỉ địa điểm nơi chốn "于" (Ở / Tại / Nơi)',
    pattern: 'Động từ + 于 + Địa điểm không gian (生于 / 处于 / 止于 / 见于 / 位于)',
    category: 'Giới từ',
    explanation_vi: '"于" (yú) là giới từ văn ngôn đa năng quan trọng nhất trong tiếng Hán. Khi chỉ không gian, "于" đứng sau động từ tương đương với "在" (ở, tại, nơi). Thường gặp: 生于 (sinh tại), 位于 (tọa lạc tại), 处于 (đang ở vào thế), 见于 (thấy xuất hiện tại sách báo/di tích).',
    examples: [
      {
        chinese: '这位享誉海内外的著名物理学家出生于江苏无锡的一个书香门第。',
        pinyin: 'Zhè wèi xiǎngyù hǎinèiwài de zhùmíng wùlǐxuéjiā chūshēng yú Jiāngsū Wúxī de yí gè shūxiāngméndì.',
        translation_vi: 'Vị nhà vật lý học nổi tiếng danh thơm trong ngoài nước này sinh ra tại một gia đình dòng dõi thư hương ở Vô Tích, Giang Tô.',
        explanation: '"出生于..." dùng "于" làm giới từ chỉ nơi chốn nơi vị khoa học gia cất tiếng khóc chào đời.'
      },
      {
        chinese: '当前世界经济正处于深刻转型的关键十字路口，面临诸多不确定因素。',
        pinyin: 'Dāngqián shìjiè jīngjì zhèng chǔyú shēnkè zhuǎnxíng de guānjiàn shízìlùkǒu, miànlín zhūduō bùquèdìngxìng yīnsù.',
        translation_vi: 'Kinh tế thế giới hiện nay đang ở vào ngã tư đường then chốt của sự chuyển dịch sâu sắc, đối mặt với muôn vàn nhân tố bất định.',
        explanation: '"处于...十字路口" là hình ảnh ẩn dụ không gian vị thế của cục diện kinh tế toàn cầu.'
      }
    ]
  },
  {
    order_index: 64,
    name: 'Giới từ văn ngôn chỉ thời gian & khởi điểm "于" (Vào lúc / Bắt đầu từ / Đến lúc)',
    pattern: '于 + Thời gian / Động từ + 于 + Thời điểm lịch sử (始于 / 终于 / 成立于)',
    category: 'Giới từ',
    explanation_vi: '"于" (yú) đứng trước hoặc sau các mốc thời gian lịch sử tương đương với "在...的时候" (vào năm, vào ngày). Thường dùng: 始于 (bắt đầu từ), 终于 (kết thúc vào), 成立于 (được thành lập vào năm).',
    examples: [
      {
        chinese: '中华文明源远流长，其农耕文明的发轫最早可追溯于数千年前的仰韶文化时期。',
        pinyin: 'Zhōnghuá wénmíng yuányuǎnliúcháng, qí nónggēng wénmíng de fārèn zuì zǎo kě zhuīsù yú shù qiān nián qián de Yǎngsháo wénhuà shíqī.',
        translation_vi: 'Văn minh Trung Hoa nguồn xa dòng dài, sự khởi đầu của nền văn minh nông nghiệp của nó sớm nhất có thể ngược dòng về thời kỳ văn hóa Ngưỡng Thiều cách đây mấy nghìn năm.',
        explanation: '"追溯于...时期" dùng "于" dẫn ra mốc khởi điểm xa xưa của nền văn minh lúa nước.'
      },
      {
        chinese: '中国自主设计建造的第一座核电站于一九九一年底顺利并网发电。',
        pinyin: 'Zhōngguó zìzhǔ shèjì jiànzào de dì yī zuò hédiànzhàn yú yījiǔjiǔyī niándǐ shùnlì bìngwǎng fādiàn.',
        translation_vi: 'Nhà máy điện hạt nhân đầu tiên do Trung Quốc tự chủ thiết kế xây dựng đã thuận lợi hòa lưới phát điện vào cuối năm 1991.',
        explanation: '"于一九九一年底" làm trạng ngữ chỉ mốc thời gian lịch sử trọng đại trong công nghiệp năng lượng.'
      }
    ]
  },
  {
    order_index: 65,
    name: 'Giới từ văn ngôn chỉ đối tượng tiếp nhận & hướng tới "于" (Đối với / Hướng về / Cho)',
    pattern: 'Động từ + 于 + Đối tượng (忠于 / 善于 / 勇于 / 归咎于 / 寄希望于)',
    category: 'Giới từ',
    explanation_vi: '"于" (yú) đứng sau các tính từ hoặc động từ tâm lý để dẫn ra đối tượng được hướng tới hoặc tiếp nhận hành vi, tương đương với "对" hoặc "向" (đối với ai, hướng tới ai). Thường gặp: 忠于祖国 (trung với tổ quốc), 善于思考 (giỏi suy nghĩ), 寄希望于青年 (đặt kỳ vọng vào giới trẻ).',
    examples: [
      {
        chinese: '全体国家工作人员必须时刻牢记宪法誓言，始终忠于祖国、忠于人民、恪尽职守。',
        pinyin: 'Quántǐ guójiā gōngzuò rényuán bìxū shíkè láojì xiànfǎ shìyán, shǐzhōng zhōngyú zǔguó, zhōngyú rénmín, kèjìnzhíshǒu.',
        translation_vi: 'Toàn thể cán bộ công chức nhà nước phải luôn ghi nhớ lời tuyên thệ hiến pháp, luôn luôn trung thành với tổ quốc, trung thành với nhân dân, tận tụy mẫn cán với chức trách.',
        explanation: '"忠于祖国、忠于人民" dùng "于" dẫn ra hai đối tượng phụng sự tối cao của người làm công bộc.'
      },
      {
        chinese: '中华民族的伟大复兴与科技自立自强，寄希望于朝气蓬勃的新一代青年学子。',
        pinyin: 'Zhōnghuá mínzú de wěidà fùxīng yǔ kējì zìlìzìqiáng, jì xīwàng yú zhāoqìpéngbó de xīn yídài qīngnián xuézǐ.',
        translation_vi: 'Sự phục hưng vĩ đại và tinh thần tự lực tự cường khoa học công nghệ của dân tộc Trung Hoa gửi gắm hy vọng vào thế hệ học sinh sinh viên trẻ tuổi tràn đầy sức sống.',
        explanation: '"寄希望于..." thể hiện sự trao gửi niềm tin và trọng trách lịch sử lên vai thế hệ măng non.'
      }
    ]
  },
  {
    order_index: 66,
    name: 'Giới từ văn ngôn trong so sánh hơn "于" (Hơn / Vượt trội hơn)',
    pattern: 'Tính từ / Động từ + 于 + Tiêu chuẩn so sánh (高于 / 大于 / 重于 / 优于 / 胜于)',
    category: 'Giới từ',
    explanation_vi: '"于" (yú) đứng sau tính từ tương đương với chữ "比" (hơn, vượt trội hơn so với). Đây là cấu trúc so sánh cổ xưa kinh điển: "青出于蓝而胜于蓝" (xanh từ chàm mà đậm hơn chàm), "人固有一死，或重于泰山，或轻于鸿毛" (người ta ai cũng một lần chết, có cái chết nặng hơn núi Thái Sơn, có cái chết nhẹ tựa lông hồng).',
    examples: [
      {
        chinese: '人固有一死，或重于泰山，或轻于鸿毛，为人民利益而死，就比泰山还重。',
        pinyin: 'Rén gù yǒu yì sǐ, huò zhòng yú Tàishān, huò qīng yú hóngmáo, wèi rénmín lìyì ér sǐ, jiù bǐ Tàishān hái zhòng.',
        translation_vi: 'Đời người ai chẳng có một lần chết, hoặc là chết nặng hơn núi Thái Sơn, hoặc là chết nhẹ hơn chiếc lông hồng, vì lợi ích của nhân dân mà hy sinh thì nặng hơn cả núi Thái Sơn.',
        explanation: '"重于泰山，轻于鸿毛" là danh ngôn tư tưởng Tư Mã Thiên dùng "于" so sánh nhân phẩm đỉnh cao.'
      },
      {
        chinese: '这家年轻企业生产的高精度光学传感器，在核心抗震性能指标上明显优于国外同类竞品。',
        pinyin: 'Zhè jiā niánqīng qǐyè shēngchǎn de gāojīngdù guāngxué chuángǎnqì, zài héxīn kàngzhèn xìngnéng zhǐbiāo shang míngxiǎn yōuyú guówài tónglèi jìngpǐn.',
        translation_vi: 'Cảm biến quang học độ chính xác cao do doanh nghiệp trẻ này sản xuất trên các chỉ số tính năng chống rung cốt lõi vượt trội hơn hẳn các sản phẩm cạnh tranh cùng loại của nước ngoài.',
        explanation: '"优于国外竞品" dùng "优于" so sánh hơn làm nổi bật năng lực cạnh tranh công nghệ nội địa.'
      }
    ]
  },
  {
    order_index: 67,
    name: 'Giới từ văn ngôn trong câu bị động "于" (Bị / Chịu sự tác động bởi)',
    pattern: 'Động từ + 于 + Tác nhân gây hại (见笑于 / 受制于 / 困于 / 败于)',
    category: 'Giới từ',
    explanation_vi: '"于" (yú) đứng sau động từ dẫn ra tác nhân gây ra hành động tương đương với chữ "被" (bị ai làm cho, chịu sự trói buộc của). Thường gặp: 见笑于大方之家 (bị các bậc uyên bác chê cười), 受制于人 (bị người khác kìm kẹp, chế ngự).',
    examples: [
      {
        chinese: '核心技术如果不牢牢掌握在自己手里，国家的产业安全就随时可能受制于人。',
        pinyin: 'Héxīn jìshù rúguǒ bù láoláo zhǎowò zài zìjǐ shǒulǐ, guójiā de chǎnyè ānquán jiù suíshí kěnéng shòuzhìyúrén.',
        translation_vi: 'Công nghệ cốt lõi nếu không nắm chắc trong tay mình thì an ninh ngành công nghiệp quốc gia bất cứ lúc nào cũng có thể bị kẻ khác khống chế kìm kẹp.',
        explanation: '"受制于人" là cấu trúc bị động văn ngôn cảnh báo hiểm họa của sự lệ thuộc công nghệ nước ngoài.'
      },
      {
        chinese: '在学术研究中如果不讲究严谨实证而信口开河，势必会见笑于真正的大方之家。',
        pinyin: 'Zài xuéshù yánjiū zhōng rúguǒ bù jiǎngjiu yánjǐn shízhèng ér xìnkǒukāihé, shìbì huì jiànxiào yú zhēnzhèng de dàfāngzhījiā.',
        translation_vi: 'Trong nghiên cứu học thuật nếu không coi trọng thực chứng cẩn trọng mà nói năng tùy tiện, thế tất sẽ bị các bậc học giả uyên bác thực sự chê cười.',
        explanation: '"见笑于大方之家" kết hợp chữ "见" và "于" tạo thành mẫu câu bị động văn ngôn kinh điển.'
      }
    ]
  },
  {
    order_index: 68,
    name: 'Giới từ văn ngôn phương thức & công cụ "以" (Dùng / Lấy / Bằng)',
    pattern: '以 + Công cụ/Phương thức/Nguyên tắc + 为 + Trọng tâm/Mục tiêu (以科技为引擎 / 以人为本 / 以事实为依据)',
    category: 'Giới từ',
    explanation_vi: '"以" (yǐ) là giới từ văn ngôn nguồn cội chỉ phương tiện, căn cứ hoặc công cụ hành động, tương đương với "用" hoặc "拿" (lấy... làm..., dùng... để...). Thường xuất hiện trong cấu trúc triết luận chính trị tối cao: "以...为..." (lấy A làm B, coi A là B).',
    examples: [
      {
        chinese: '我们的城市建设必须坚持以人为本，切实把居民的宜居度作为最重要的考核指标。',
        pinyin: 'Wǒmen de chéngshì jiànshè bìxū jiānchí yǐrénwéiběn, qièshí bǎ jūmín de yíjūdù zuòwéi zuì zhòngyào de kǎohé zhǐbiāo.',
        translation_vi: 'Công cuộc xây dựng đô thị của chúng ta bắt buộc phải kiên trì lấy con người làm gốc, thiết thực coi mức độ đáng sống của cư dân là chỉ số đánh giá quan trọng nhất.',
        explanation: '"以人为本" là tôn chỉ nhân văn tối cao lấy hạnh phúc nhân dân làm gốc rễ phát triển.'
      },
      {
        chinese: '人民法院审理各类民刑案件，必须坚持以事实为依据、以法律为准绳的客观公正原则。',
        pinyin: 'Rénmín fǎyuàn shěnlǐ gèlèi mínxíng ànjiàn, bìxū jiānchí yǐ shìshí wéi yījù, yǐ fǎlǜ wéi zhǔnshéng de kèguān gōngzhèng yuánzé.',
        translation_vi: 'Tòa án Nhân dân khi xét xử các loại án dân sự và hình sự bắt buộc phải kiên trì nguyên tắc khách quan công bằng lấy sự thật làm căn cứ, lấy pháp luật làm thước đo.',
        explanation: '"以事实为依据、以法律为准绳" là kim chỉ nam xét xử tư pháp chuẩn mực quốc gia.'
      }
    ]
  },
  {
    order_index: 69,
    name: 'Giới từ/Liên từ mục đích văn ngôn "以" (Để / Nhằm / Nhằm mục đích)',
    pattern: 'Hành động tích cực, 以 + Đạt được mục tiêu (以期 / 以防 / 以飨 / 予以 / 以求)',
    category: 'Giới từ',
    explanation_vi: '"以" (yǐ) đứng giữa hai vế câu làm liên từ chỉ mục đích tương đương với "用来, 为了" (để, nhằm). Thường kết hợp trong các từ ghép chỉ mục đích: "以期" (nhằm hy vọng), "以防" (nhằm phòng ngừa), "以求" (nhằm mưu cầu).',
    examples: [
      {
        chinese: '博物馆在暑假期间免费延长开放两小时，以期满足广大中小学生假期的文化需求。',
        pinyin: 'Bówùguǎn zài shǔjià qījiān miǎnfèi yáncháng kāifàng liǎng xiǎoshí, yǐqī mǎnzú guǎngdà zhōngxiǎoxuéshēng jiàqī de wénhuà xūqiú.',
        translation_vi: 'Bảo tàng trong dịp nghỉ hè miễn phí kéo dài thời gian mở cửa thêm 2 tiếng, nhằm hy vọng đáp ứng nhu cầu văn hóa trong kỳ nghỉ của đông đảo học sinh.',
        explanation: '"以期满足..." nêu rõ mục đích xã hội cao đẹp của việc nới rộng giờ phục vụ công cộng.'
      },
      {
        chinese: '登山队员们在冰川营地储备了充足的氧气和高能食品，以防恶劣风雪天气封锁下山路线。',
        pinyin: 'Dēngshānduìyuánmen zài bīngchuān yíngdì chǔbèi le chōngzú de yǎngqì hé gāonéng shípǐn, yǐfáng èliè fēngxuě tiānqì fēngsuǒ xiàshān lùxiàn.',
        translation_vi: 'Các thành viên đội leo núi đã dự trữ đầy đủ oxy và thực phẩm giàu năng lượng tại doanh trại sông băng, nhằm phòng ngừa thời tiết mưa tuyết khắc nghiệt phong tỏa tuyến đường xuống núi.',
        explanation: '"以防..." nêu rõ rủi ro cần phòng bị trước điều kiện thiên nhiên vùng núi tuyết.'
      }
    ]
  },
  {
    order_index: 70,
    name: 'Cấu trúc giới từ xác lập tư cách đại diện: "以...身份 / 以...名义"',
    pattern: 'Chủ ngữ + 以 + Tư cách/Danh nghĩa/Chức vụ + Động từ (出席 / 签署 / 呼吁 / 发表声明)',
    category: 'Giới từ',
    explanation_vi: '"以...身份" và "以...名义" dùng để xác lập tư cách pháp lý, địa vị xã hội hoặc danh nghĩa đại diện khi một cá nhân hoặc tổ chức tham gia hoạt động ngoại giao, ký kết hợp đồng hoặc công bố tuyên ngôn chính thức (với tư cách là, nhân danh).',
    examples: [
      {
        chinese: '这位资深外交官以联合国特别顾问的身份，出席了本次关于中东和平进程的国际会议。',
        pinyin: 'Zhè wèi zīshēn wàijiāoguān yǐ Liánhéguó tèbié gùwèn de shēnfèn, chūxí le běn cì guānyú Zhōngdōng hépíng jìnchéng de guójì huìyì.',
        translation_vi: 'Vị nhà ngoại giao kỳ cựu này với tư cách là cố vấn đặc biệt của Liên Hợp Quốc đã tham dự hội nghị quốc tế lần này về tiến trình hòa bình Trung Đông.',
        explanation: '"以...身份出席" xác định tư cách đại diện phái đoàn quốc tế hợp pháp của nhà ngoại giao.'
      },
      {
        chinese: '他以全资控股企业法人的名义，与当地政府正式签署了总投资五十亿元的新能源汽车产业园合作协议。',
        pinyin: 'Tā yǐ quánzī kònggǔ qǐyè fǎrén de míngyì, yǔ dāngdì zhèngfǔ zhèngshì qiānshǔ le zǒng tóuzī wǔshí yì yuán de xīn néngyuán qìchē chǎnyèyuán hézuò xiéyì.',
        translation_vi: 'Ông ấy nhân danh pháp nhân doanh nghiệp nắm giữ 100% vốn đã chính thức ký kết với chính quyền địa phương thỏa thuận hợp tác khu công nghiệp xe ô tô năng lượng mới với tổng vốn đầu tư 5 tỷ nhân dân tệ.',
        explanation: '"以...法人的名义" xác lập năng lực chủ thể ký kết hợp đồng kinh tế theo luật doanh nghiệp.'
      }
    ]
  },
  {
    order_index: 71,
    name: 'Giới từ căn cứ chuẩn tắc trang trọng "依" (Căn cứ vào / Chiểu theo / Nương theo)',
    pattern: '依 + Căn cứ/Ý kiến (依我之见 / 依法 / 依规 / 依此类推 / 依我看)',
    category: 'Giới từ',
    explanation_vi: '"依" (yī) là giới từ văn ngôn trang trọng mang nghĩa "căn cứ vào, chiểu theo, dựa trên cơ sở" (tương đương với 按照 hoặc 根据). Thường gặp trong các cấu trúc kinh điển: "依我之见" (theo thiển kiến của tôi), "依法治国" (quản lý đất nước theo pháp luật), "依此类推" (cứ theo loại này mà suy luận tiếp).',
    examples: [
      {
        chinese: '依我之见，解决这一国际争端的唯一正途，依然在于通过平等坦诚的政治外交谈判。',
        pinyin: 'Yī wǒ zhī jiàn, jiějué zhè yì guójì zhēngduān de wéiyī zhèngtú, yīrán zàiyú tōngguò píngděng tǎnchéng de zhèngzhì wàijiāo tánpàn.',
        translation_vi: 'Theo thiển kiến của tôi, con đường đúng đắn duy nhất để giải quyết tranh chấp quốc tế này vẫn nằm ở việc thông qua đàm phán chính trị ngoại giao bình đẳng và thẳng thắn.',
        explanation: '"依我之见" là cách mở đầu học thuật uyên bác đưa ra quan điểm phân tích thời sự sắc sảo.'
      },
      {
        chinese: '执法机关必须严格做到依法行政，绝不允许任何人在法定权限之外滥用权力。',
        pinyin: 'Zhífǎ jīguān bìxū yángé zuòdào yīfǎ xíngzhèng, jué bù yǔnxǔ rènhé rén zài fǎdìng quánxiàn zhīwài lànyòng quánlì.',
        translation_vi: 'Cơ quan hành pháp bắt buộc phải thực hiện nghiêm ngặt hành chính theo đúng pháp luật, tuyệt đối không cho phép bất kỳ ai lạm dụng quyền lực ngoài quyền hạn luật định.',
        explanation: '"依法行政" dùng "依" xác lập nguyên tắc thượng tôn pháp luật trong quản lý nhà nước.'
      }
    ]
  },
  {
    order_index: 72,
    name: 'Giới từ nhân duyên cơ hội & tùy biến "因" (Vì / Nhân cơ hội / Dựa theo sự khác biệt)',
    pattern: '因 + Điều kiện địa phương/con người/thời thế (因地制宜 / 因人而异 / 因势利导)',
    category: 'Giới từ',
    explanation_vi: '"因" (yīn) trong HSK 6 ngoài nghĩa nguyên nhân "vì" còn là giới từ chỉ phương thức tùy biến nương theo hoàn cảnh khách quan để hành động linh hoạt (dựa theo, tùy thuộc vào). Tạo thành các thành ngữ triết lý quản trị tuyệt đỉnh: "因地制宜" (tùy theo điều kiện địa phương mà đề ra giải pháp), "因人而异" (tùy từng người mà khác nhau), "因势利导" (nương theo thế mà dẫn dắt khéo léo).',
    examples: [
      {
        chinese: '乡村振兴战略必须坚持因地制宜，绝不能脱离当地自然资源禀赋而盲目机械照搬别处模式。',
        pinyin: 'Xiāngcūn zhènxīng zhànlüè bìxū jiānchí yīndìzhìyí, jué bù néng tuōlí dāngdì zìrán zīyuán bǐngfù ér mángmù jīxiè zhàobān biéchù móshì.',
        translation_vi: 'Chiến lược phục hưng nông thôn bắt buộc phải kiên trì căn cứ theo đặc thù từng địa phương, tuyệt đối không thể tách rời nguồn lực tài nguyên thiên nhiên sẵn có mà mù quáng sao chép máy móc mô hình nơi khác.',
        explanation: '"因地制宜" là nguyên tắc quản trị chiến lược phát triển kinh tế phù hợp với thổ nhưỡng.'
      },
      {
        chinese: '经验丰富的名医给患者开药方总是因人而异，精准把握每个人的体质特异性。',
        pinyin: 'Jīngyàn fēngfù de míngyī gěi huànzhě kāi yàofāng zǒngshì yīnrén\'éryì, jīngzhǔn bǎwò měi gè rén de tǐzhì tèyìxìng.',
        translation_vi: 'Bậc danh y giàu kinh nghiệm khi bốc đơn thuốc cho người bệnh luôn tùy theo thể trạng từng người mà biến hóa, nắm bắt chuẩn xác tính dị biệt thể chất của mỗi người.',
        explanation: '"因人而异" phản ánh triết lý y học cổ truyền điều trị cá thể hóa.'
      }
    ]
  },
  {
    order_index: 73,
    name: 'Giới từ mượn cớ nương nhờ văn ngôn "藉 / 借" (Mượn cơ hội / Nhờ cậy / Nhằm)',
    pattern: 'Chủ ngữ + 藉 / 借 + Cớ/Công cụ + 以 + Đạt được mục đích ngầm (藉以 / 藉此)',
    category: 'Giới từ',
    explanation_vi: '"藉" (jiè) là dạng chữ cổ của "借", khi làm giới từ mang nghĩa "mượn cớ, nương vào một cơ hội hay hình thức để đạt tới một mục đích cụ thể". Cấu trúc kinh điển: "藉以..." (nhằm lấy đó để...), "藉此机会" (nhân cơ hội này).',
    examples: [
      {
        chinese: '不法分子企图藉虚构的投资项目非法集资，广大群众对此务必提高防范警惕。',
        pinyin: 'Bùfǎ fènzǐ qǐtú jiè xūgòu de tóuzī xiàngmù fēifǎ jízī, guǎngdà qúnzhòng duì cǐ wùbì tígāo fángfàn jǐngtì.',
        translation_vi: 'Những phần tử bất chính mưu toan mượn các dự án đầu tư hư cấu để huy động vốn phi pháp, đông đảo quần chúng nhân dân đối với điều này nhất thiết phải nâng cao tinh thần cảnh giác phòng ngừa.',
        explanation: '"藉虚构的投资项目" dùng "藉" vạch trần vỏ bọc che đậy thủ đoạn lừa đảo tài chính.'
      },
      {
        chinese: '两国元首在峰会期间举行了非正式漫步茶叙，藉以增进私人互信与战略沟通。',
        pinyin: 'Liǎng guó yuánshǒu zài fēnghuì qījiān jǔxíng le fēizhèngshì mànbù cháxù, jièyǐ zēngjìn sīrén hùxìn yǔ zhànlüè gōutōng.',
        translation_vi: 'Nguyên thủ hai nước trong thời gian hội nghị thượng đỉnh đã tiến hành cuộc đi dạo uống trà không chính thức, nhằm lấy đó làm cầu nối tăng cường sự tin cậy cá nhân và giao lưu chiến lược.',
        explanation: '"藉以增进..." thể hiện nghệ thuật ngoại giao mềm mại thắt chặt quan hệ quốc tế.'
      }
    ]
  },
  {
    order_index: 74,
    name: 'Giới từ ngoại giao lễ nghi cùng đi "偕同" (Cùng đi với / Cùng với)',
    pattern: 'Lãnh đạo / VIP + 偕同 + Phu nhân / Quan chức cấp cao + Động từ (访华 / 抵达 / 出席)',
    category: 'Giới từ',
    explanation_vi: '"偕同" (xiétóng) là giới từ ngoại giao nhà nước cực kỳ trang trọng tương đương với "一起, 带着" (cùng với, dẫn theo), chuyên dùng khi đưa tin về nguyên thủ quốc gia hoặc thủ tướng đi công du cùng phu nhân hoặc đoàn đại biểu cấp cao (như 偕同夫人 - cùng phu nhân tới thăm).',
    examples: [
      {
        chinese: '应国家主席邀请，法国总统偕同夫人于今日下午乘专机抵达北京开始进行国事访问。',
        pinyin: 'Yìng guójiā zhǔxí yāoqǐng, Fǎguó zǒngtǒng xiétóng fūrén yú jīnrì xiàwǔ chéng zhuānjī dǐdá Běijīng kāishǐ jìnxíng guóshì fǎngwèn.',
        translation_vi: 'Nhận lời mời của Chủ tịch nước, Tổng thống Pháp cùng phu nhân đã đáp chuyên cơ tới Bắc Kinh vào chiều nay bắt đầu chuyến thăm cấp nhà nước.',
        explanation: '"总统偕同夫人" là nghi thức xưng hô ngoại giao nghi lễ nhà nước chuẩn mực trong bản tin đối ngoại.'
      },
      {
        chinese: '联合国秘书长偕同主要随行高级官员，亲赴灾区实地视察难民救援安置营地。',
        pinyin: 'Liánhéguó mìshūzhǎng xiétóng zhǔyào suíxíng gāojí guānyuán, qīnfù zāiqū shídì shìchá nànmín jiùyuán ānzhì yíngdì.',
        translation_vi: 'Tổng thư ký Liên Hợp Quốc cùng các quan chức cấp cao tháp tùng chủ chốt đã đích thân tới vùng thiên tai khảo sát thực tế khu trại cứu trợ tái định cư người tị nạn.',
        explanation: '"偕同...高级官员" thể hiện sự nghiêm cẩn trong tường thuật chuyến công tác quốc tế.'
      }
    ]
  },
  {
    order_index: 75,
    name: 'Liên từ tăng tiến quy mô vĩ mô "乃至" (Cho đến / Thậm chí đến mức)',
    pattern: 'Phạm vi hẹp / Nhỏ, 乃至 + Phạm vi rộng lớn / Toàn cầu (本省乃至全国 / 全国乃至全世界)',
    category: 'Liên từ',
    explanation_vi: '"乃至" (nǎizhì) là liên từ tăng tiến chính luận trang trọng tương đương với "甚至, 以及", dùng để mở rộng quy mô từ phạm vi một khu vực, một quốc gia nâng cấp lên tới tầm vóc toàn cầu, hoặc từ một cá nhân nâng lên cả nhân loại (cho đến tận, thậm chí đến).',
    examples: [
      {
        chinese: '这不仅关乎本地区的发展繁荣，更直接影响到亚洲乃至整个世界的长治久安。',
        pinyin: 'Zhè bùjǐn guānhū běn dìqū de fāzhǎn fánróng, gèng zhíjiē yǐngxiǎng dào Yàzhōu nǎizhì zhěng gè shìjiè de chángzhìjiǔ\'ān.',
        translation_vi: 'Điều này không chỉ liên quan tới sự phát triển phồn vinh của khu vực này, mà càng trực tiếp ảnh hưởng tới sự bình yên ổn định lâu dài của châu Á cho tới cả toàn thế giới.',
        explanation: '"亚洲乃至整个世界" nâng tầm ảnh hưởng an ninh từ cấp độ châu lục lên quy mô toàn cầu.'
      },
      {
        chinese: '该项原始创新成果的问世，必将深刻重塑当前行业格局乃至整个人类社会的生产方式。',
        pinyin: 'Gāi xiàng yuánshǐ chuàngxīn chéngguǒ de wènshì, bìjiāng shēnkè zhòngsù dāngqián hángyè géjú nǎizhì zhěng gè rénlèi shèhuì de shēngchǎn fāngshì.',
        translation_vi: 'Sự ra đời của thành quả sáng tạo gốc này nhất định sẽ định hình lại sâu sắc cục diện ngành nghề hiện tại cho tới cả phương thức sản xuất của toàn thể xã hội loài người.',
        explanation: '"行业格局乃至人类社会" làm nổi bật sức tác động mang tính cách mạng của công nghệ mới.'
      }
    ]
  },
  {
    order_index: 76,
    name: 'Liên từ bổ sung lý do văn ngôn "兼之" (Lại thêm / Vả lại / Huống hồ)',
    pattern: 'Nguyên nhân 1, 兼之 + Nguyên nhân 2 (phức tạp hơn) + Dẫn đến kết quả',
    category: 'Liên từ',
    explanation_vi: '"兼之" (jiānzhī) là liên từ văn ngôn cổ nhã tương đương với "加之" hoặc "况且", dùng ở đầu phân câu sau để bổ sung thêm một lý do khách quan phụ họa vào lý do trước, làm cho kết quả xảy ra càng thêm tất yếu và hợp lý (lại thêm vào đó, vả lại).',
    examples: [
      {
        chinese: '山高路险车辆难行，兼之暴雨连绵道路塌方，救援队伍只能徒步艰难挺进震中。',
        pinyin: 'Shāngāo lùxiǎn chēliàng nánxíng, jiānzhī bàoyǔ liánmián dàolù tāfāng, jiùyuán duìwù zhǐ néng túbù jiānnán tǐngjìn zhènzhōng.',
        translation_vi: 'Núi cao đường hiểm xe cộ khó đi, lại thêm mưa bão kéo dài sạt lở đường sá, đội cứu hộ chỉ đành đi bộ gian nan hành quân vào tâm chấn.',
        explanation: '"兼之暴雨连绵..." bổ sung thêm điều kiện thời tiết khắc nghiệt giải thích sự khó khăn của công tác cứu hộ.'
      },
      {
        chinese: '他自幼聪慧过人勤奋好学，兼之名师悉心指点点拨，年纪轻轻便在画坛崭露头角。',
        pinyin: 'Tā zìyòu cōnghuì guòrén qínfèn hàoxué, jiānzhī míngshī xīxīn zhǐdiǎn diǎnbō, niánjì qīngqīng biàn zài huàtán zhǎnlùtóujiǎo.',
        translation_vi: 'Anh từ nhỏ đã thông minh hơn người lại chăm chỉ hiếu học, lại thêm được danh sư ân cần chỉ bảo khai sáng, tuổi đời còn trẻ đã sớm nổi danh trên thi họa đàn.',
        explanation: '"兼之名师悉心指点" kết hợp thiên bẩm cá nhân với sự chỉ dạy của thầy giỏi làm nên thành tài.'
      }
    ]
  },
  {
    order_index: 77,
    name: 'Cấu trúc nối tiếp hành động bài bản "继之以..." (Nối tiếp theo bằng...)',
    pattern: 'Giai đoạn 1 tiến hành, 继之以 + Biện pháp giai đoạn 2 hoàn thiện',
    category: 'Cấu trúc cố định',
    explanation_vi: '"继之以..." (jì zhī yǐ...) là cấu trúc văn ngôn cao cấp biểu thị sau khi một hành động ban đầu kết thúc, chủ thể lập tức tiếp nối bằng một hành động khác có tính kế thừa hoặc nâng cao hơn để hoàn thiện chu trình (nối tiếp bằng cái gì, tiếp theo sau đó là biện pháp gì).',
    examples: [
      {
        chinese: '在考古发掘中，专家们先是进行精细的表层泥土剥离，继之以高科技的三维数字化建模扫描。',
        pinyin: 'Zài kǎogǔ fājué zhōng, zhuānjiāmen xiān shì jìnxíng jīngxì de biǎocéng nítǔ bōlí, jì zhī yǐ gāokējì de sānwéi shùzìhuà jiànmó sǎomiáo.',
        translation_vi: 'Trong công tác khai quật khảo cổ, các chuyên gia thoạt tiên tiến hành bóc tách tinh vi lớp đất mặt, nối tiếp theo đó bằng thao tác quét mô hình kỹ thuật số 3D công nghệ cao.',
        explanation: '"继之以三维建模" kết hợp tuần tự nhịp nhàng giữa phương pháp khảo cổ truyền thống và công nghệ số.'
      },
      {
        chinese: '对于受灾群众的救助，首先当保障饮食饮水等温饱问题，继之以全面的灾后心理疏导与家园重建。',
        pinyin: 'Duìyú shòuzāi qúnzhòng de jiùzhù, shǒuxiān dāng bǎozhàng yǐnshí yǐnshuǐ děng wēnbǎo wèntí, jì zhī yǐ quánmiàn de zāihòu xīnlǐ shūdǎo yǔ jiāyuán chóngjiàn.',
        translation_vi: 'Đối với việc cứu trợ quần chúng vùng thiên tai, trước hết cần bảo đảm vấn đề no ấm ăn uống, tiếp nối sau đó bằng sự khai thông tâm lý sau thảm họa toàn diện và tái thiết quê hương.',
        explanation: '"继之以心理疏导..." phân định lộ trình cứu trợ từ vật chất cấp bách đến chăm sóc tinh thần lâu dài.'
      }
    ]
  },
  {
    order_index: 78,
    name: 'Cấu trúc nhượng bộ văn ngôn chặt chẽ "虽...亦..." (Tuy... nhưng cũng...)',
    pattern: '虽 + Điều kiện khó khăn / Nhỏ bé, 亦 + Vẫn giữ nguyên giá trị / Quyết tâm',
    category: 'Liên từ',
    explanation_vi: '"虽...亦..." (suī... yì...) là cặp từ nối nhượng bộ Hán ngữ cổ đại tương đương với "虽然...但也...", nhưng mang tính hàm súc, biền ngẫu ngắn gọn (tuy rằng... thì cũng vẫn cứ). Thường dùng trong các câu danh ngôn chí hướng, thơ văn tự sự.',
    examples: [
      {
        chinese: '前行道路虽千难万险，我们亦当一往无前、义无反顾。',
        pinyin: 'Qiánxíng dàolù suī qiānnánwànxiǎn, wǒmen yì dāng yìwǎngwúqián, yìwúfǎngù.',
        translation_vi: 'Con đường tiến bước phía trước tuy muôn vàn gian nan nguy hiểm, chúng ta cũng phải dũng cảm tiến lên, quyết không chùn bước.',
        explanation: '"虽千难万险，亦当一往无前" thể hiện khí phách anh hùng không sợ hiểm nguy.'
      },
      {
        chinese: '个人的力量虽微不足道，但若汇聚到集体的大潮之中，亦能激荡起磅礴的伟力。',
        pinyin: 'Gèrén de lìliàng suī wēibùzúdào, dàn ruò huìjù dào jítǐ de dàcháo zhīzhōng, yì néng jīdàng qǐ pángbó de wěilì.',
        translation_vi: 'Sức mạnh của cá nhân tuy nhỏ bé không đáng kể, nhưng nếu hòa vào làn sóng chung của tập thể, cũng có thể tạo nên sức mạnh vĩ đại dạt dào.',
        explanation: '"虽微不足道...亦能..." khẳng định giá trị to lớn của tinh thần đoàn kết tập thể.'
      }
    ]
  },
  {
    order_index: 79,
    name: 'Cấu trúc giả thiết tột bực văn ngôn "纵使...亦..." (Dẫu cho... cũng vẫn...)',
    pattern: '纵使 + Giả thiết khắc nghiệt nhất, (主语) 亦 + Kiên định lập trường / Bất biến',
    category: 'Liên từ',
    explanation_vi: '"纵使...亦..." (zòngshǐ... yì...) tương đương với "即使...也...", nhưng mang phong vị cổ điển bi tráng. Đặt ra một giả thiết hiểm nguy hoặc bất lợi tột cùng để làm nổi bật ý chí sắt son không hề lay chuyển (cho dù là thế... thì vẫn cứ).',
    examples: [
      {
        chinese: '纵使历经沧海桑田的岁月变迁，中华民族对和平安宁的向往亦从未改变。',
        pinyin: 'Zòngshǐ lìjīng cānghǎisāngtián de suìyuè biànqiān, Zhōnghuá mínzú duì hépíng ānníng de xiàngwǎng yì cóngwèi gǎibiàn.',
        translation_vi: 'Dẫu cho trải qua những biến thiên năm tháng dâu bể khôn lường, khát vọng của dân tộc Trung Hoa đối với hòa bình an lành cũng chưa từng thay đổi.',
        explanation: '"纵使...亦从未改变" khẳng định ước mơ hòa bình thiên niên kỷ bất biến của dân tộc.'
      },
      {
        chinese: '纵使面临千夫所指的巨大舆论压力，追求客观真理的勇士亦绝不后退半步。',
        pinyin: 'Zòngshǐ miànlín qiānfūsuǒzhǐ de jùdà yúlùn yālì, zhuīqiú kèguān zhēnlǐ de yǒngshì yì jué bú hòutuì bàn bù.',
        translation_vi: 'Dẫu cho đối mặt với áp lực dư luận khổng lồ vạn người chỉ trích, người dũng sĩ mưu cầu chân lý khách quan cũng tuyệt đối không lùi nửa bước.',
        explanation: '"纵使...亦绝不后退" ca ngợi lòng quả cảm bảo vệ chân lý trước định kiến thời đại.'
      }
    ]
  },
  {
    order_index: 80,
    name: 'Cấu trúc lựa chọn khí tiết văn ngôn "宁...毋..." (Thà rằng... chứ không...)',
    pattern: '宁 + Chấp nhận mất mát vật chất, 毋 + Làm tổn hại đạo đức / Nguyên tắc',
    category: 'Liên từ',
    explanation_vi: '"宁...毋..." (nìng... wú...) là dạng văn ngôn cổ kính của "宁可...也不...", thể hiện thái độ dứt khoát thà chấp nhận hy sinh quyền lợi chứ quyết không làm điều trái đạo lý (chữ 毋 nghĩa là chớ, không). Danh ngôn kinh điển: "宁缺毋滥" (thà thiếu chứ không lấy ẩu, thà ít mà chất lượng).',
    examples: [
      {
        chinese: '选拔高精尖专业人才必须秉持严格标准，宁缺毋滥，确保队伍的高质量。',
        pinyin: 'Xuǎnbá gāojīngjiān zhuānyè réncái bìxū bǐngchí yángé biāozhǔn, nìngquēwúlàn, quèbǎo duìwù de gāo zhìliàng.',
        translation_vi: 'Tuyển chọn nhân tài chuyên môn đỉnh cao tinh hoa bắt buộc phải giữ vững tiêu chuẩn nghiêm ngặt, thà thiếu còn hơn chọn ẩu, bảo đảm chất lượng cao của đội ngũ.',
        explanation: '"宁缺毋滥" là tiêu chuẩn vàng rèn quân chọn tướng của các tập đoàn hàng đầu.'
      },
      {
        chinese: '学者撰写论文当求字字有据，宁慢毋错，严防浮躁虚假风气滋生。',
        pinyin: 'Xuézhě zhuànxiě lùnwén dāng qiú zìzìyǒujù, nìng màn wú cuò, yánfáng fúzào xūjiǎ fēngqì zīshēng.',
        translation_vi: 'Học giả khi viết luận văn phải cầu từng chữ đều có chứng cớ, thà chậm chứ không được sai, nghiêm phòng thói bốc đồng giả dối nảy sinh.',
        explanation: '"宁慢毋错" răn dạy đức tính cẩn trọng tỉ mỉ từng chi tiết trong nghiên cứu học thuật.'
      }
    ]
  },
  {
    order_index: 81,
    name: 'Cấu trúc tăng tiến phủ định văn phong học thuật "非但...而且..." (Chẳng những... mà còn...)',
    pattern: 'Chủ ngữ + 非但 + Không bị cản trở, 而且 / 反而 + Phát triển mạnh mẽ hơn',
    category: 'Liên từ',
    explanation_vi: '"非但...而且..." (fēidàn... érqiě...) có chữ "非但" là dạng văn ngôn của "不但/不仅". Dùng trong các bài nghị luận chính trị xã hội để bác bỏ quan niệm nghi ngờ trước khi chỉ ra sự phát triển vượt bậc (chẳng những không... mà còn...).',
    examples: [
      {
        chinese: '外部的风雨施压非但没有压垮中国经济的筋骨，而且倒逼我们加快了科技自主创新的步伐。',
        pinyin: 'Wàibù de fēngyǔ shīyā fēidàn méiyǒu yākuǎ Zhōngguó jīngjì de jīngǔ, érqiě dàobī wǒmen jiākuài le kējì zìzhǔ chuàngxīn de bùfá.',
        translation_vi: 'Những áp lực gió mưa chèn ép từ bên ngoài chẳng những không đè bẹp được gân cốt của kinh tế Trung Quốc, mà còn ép chúng ta đẩy nhanh bước chân đổi mới sáng tạo tự chủ công nghệ.',
        explanation: '"非但没有...而且倒逼..." khẳng định sức bền nội tại và khả năng biến thách thức thành động lực.'
      },
      {
        chinese: '严格的环保监管标准非但没有降低企业的利润，而且促使其提前完成了产业智能化绿色升级。',
        pinyin: 'Yángé de huánbǎo jiānguǎn biāozhǔn fēidàn méiyǒu jiàngdī qǐyè de lìrùn, érqiě cùshǐ qí tíqián wánchéng le chǎnyè zhìnénghuà lǜsè shēngjí.',
        translation_vi: 'Tiêu chuẩn giám sát bảo vệ môi trường nghiêm ngặt chẳng những không làm giảm lợi nhuận của doanh nghiệp, mà còn thúc đẩy doanh nghiệp hoàn thành sớm việc nâng cấp xanh thông minh hóa ngành nghề.',
        explanation: '"非但没有...而且促使..." giải tỏa hiểu lầm cho rằng bảo vệ môi trường kìm hãm lợi nhuận.'
      }
    ]
  },
  {
    order_index: 82,
    name: 'Cấu trúc kiểm chứng xác thực giả định "果真...就..." (Nếu quả thật... thì...)',
    pattern: '果真 + Như dự đoán/thực tế, 主语 + 就 + Hành động tương ứng',
    category: 'Liên từ',
    explanation_vi: '"果真" (guǒzhēn) vừa là liên từ giả định vừa là phó từ xác thực, tương đương với "如果真的, 果然" (nếu quả thực đúng như vậy). Dùng khi muốn đưa ra một hành động, quyết định dựa trên điều kiện tình huống được kiểm chứng là hoàn toàn có thật.',
    examples: [
      {
        chinese: '如果技术参数果真能达到实验室预设的标准，这项产品就完全具备了颠覆市场的潜力。',
        pinyin: 'Rúguǒ jìshù cānshù guǒzhēn néng dádào shíyànshì yùshè de biāozhǔn, zhè xiàng chǎnpǐn jiù wánquán jùbèi le diānfù shìchǎng de qiánlì.',
        translation_vi: 'Nếu thông số kỹ thuật quả thực có thể đạt tới tiêu chuẩn dự kiến trong phòng thí nghiệm, sản phẩm này liền hoàn toàn hội tụ tiềm năng làm đảo lộn thị trường.',
        explanation: '"果真能达到...就具备..." đặt ra điều kiện kiểm định tính năng trước khi đánh giá tiềm năng thương mại.'
      },
      {
        chinese: '事情果真如你所说的那样顺利，我们明天就可以提前召开项目结项庆功会了。',
        pinyin: 'Shìqing guǒzhēn rú nǐ suǒ shuō de nàyàng shùnlì, wǒmen míngtiān jiù kěyǐ tíqián zhàokāi xiàngmù jiéxiàng qìnggōnghuì le.',
        translation_vi: 'Sự việc nếu quả thật suôn sẻ đúng như lời cậu nói, chúng ta ngày mai liền có thể mở tiệc mừng công tổng kết dự án sớm hơn dự kiến rồi.',
        explanation: '"果真如你所说..." thể hiện sự kiểm chứng tin tức với niềm vui mừng chờ đón.'
      }
    ]
  },
  {
    order_index: 83,
    name: 'Cấu trúc câu hỏi tu từ khuyên can "既然...何必..." (Đã... hà tất phải...)',
    pattern: '既然 + Sự thật đã ngã ngũ rõ ràng, 又 / 也 + 何必 + Làm điều thừa thãi/tổn thương + 呢？',
    category: 'Cấu trúc cố định',
    explanation_vi: '"既然...何必..." (jìrán... hébì...) phối hợp liên từ tiền đề "既然" và phó từ phản vấn "何必", tạo thành mẫu câu khuyên can thấu tình đạt lý: đã là một sự thật hiển nhiên hoặc đôi bên đều đã hiểu rõ nhau, vậy thì cần gì phải so đo, tranh cãi hay làm khổ nhau làm gì nữa.',
    examples: [
      {
        chinese: '既然双方都怀揣着真诚的合作愿望，又何必在枝节问题上寸土必争以致伤了和气呢？',
        pinyin: 'Jìrán shuāngfāng dōu huáichuǎizhe zhēnchéng de hézuò yuànwàng, yòu hébì zài zhījié wèntí shang cùntǔbìzhēng yǐzhì shāng le héqì ne?',
        translation_vi: 'Đã đôi bên đều ấp ủ nguyện vọng hợp tác chân thành, vậy cần gì phải tranh giành từng tấc trên những vấn đề râu ria đến nỗi làm tổn thương hòa khí chứ?',
        explanation: '"既然...又何必...呢？" khuyên nhủ sự nhượng bộ đại cục tránh tổn hại quan hệ ngoại giao đối tác.'
      },
      {
        chinese: '往事既然已经随风而逝无法挽回，我们又何必整天沉溺在过去的自责与痛苦之中呢？',
        pinyin: 'Wǎngshì jìrán yǐjīng suífēng\'érshì wúfǎ wǎnhuí, wǒmen yòu hébì zhěngtiān chénnì zài guòqù de zìzé yǔ tòngkǔ zhīzhōng ne?',
        translation_vi: 'Chuyện xưa đã theo gió thoảng trôi qua không thể cứu vãn, chúng ta cần gì phải suốt ngày chìm đắm trong nỗi tự trách và đau khổ của quá khứ cơ chứ?',
        explanation: '"又何必...呢" là lời an ủi tâm lý động viên đối phương buông bỏ gánh nặng quá khứ hướng về tương lai.'
      }
    ]
  },
  {
    order_index: 84,
    name: 'Cấu trúc tương sinh bổ trợ hoàn mỹ "相辅相成" (Hỗ trợ bổ sung cho nhau / Song hành phát triển)',
    pattern: 'A 与 / 和 B + 相辅相成, 缺一不可',
    category: 'Cấu trúc cố định',
    explanation_vi: '"相辅相成" (xiāngfǔ xiāngchéng) kết hợp chữ 辅 (giúp đỡ, tương trợ) và 成 (hoàn thành, phát triển), biểu thị hai sự vật hoặc phương diện bổ sung, nương tựa và thúc đẩy lẫn nhau cùng hoàn thiện, thiếu một trong hai thì bên kia không thể đứng vững (hỗ trợ lẫn nhau, tương sinh tương hợp). Thường đi với cụm "缺一不可".',
    examples: [
      {
        chinese: '经济的高质量发展与生态环境的高水平保护是相辅相成的辩证统一关系。',
        pinyin: 'Jīngjì de gāozhìliàng fāzhǎn yǔ shēngtài huánjìng de gāoshuǐpíng bǎohù shì xiāngfǔxiāngchéng de biànzhèng tǒngyī guānxì.',
        translation_vi: 'Sự phát triển kinh tế chất lượng cao và việc bảo vệ môi trường sinh thái mức độ cao là mối quan hệ thống nhất biện chứng hỗ trợ bổ sung cho nhau.',
        explanation: '"相辅相成" làm sáng tỏ triết lý không đánh đổi môi trường lấy kinh tế ngắn hạn.'
      },
      {
        chinese: '扎实的理论知识传授与生动的动手实践操作相辅相成，共同构成了现代高等工程教育的基石。',
        pinyin: 'Zhāshi de lǐlùn zhīshi chuánshòu yǔ shēngdòng de dòngshǒu shíjiàn cāozuò xiāngfǔxiāngchéng, gòngtóng gòuchéng le xiàndài gāoděng gōngchéng jiàoyù de jīshí.',
        translation_vi: 'Việc truyền thụ kiến thức lý luận vững chắc và thao tác thực hành sinh động hỗ trợ bổ sung cho nhau, cùng nhau cấu thành nền tảng của giáo dục kỹ thuật công trình đại học hiện đại.',
        explanation: '"相辅相成" kết hợp nhuần nhuyễn giữa học lý thuyết và hành thực tế trong đào tạo kỹ sư.'
      }
    ]
  },
  {
    order_index: 85,
    name: 'Cấu trúc tương phản đối nghịch đi ngược chiều "背道而驰" (Đi ngược lại hoàn toàn / Trái chiều)',
    pattern: 'Hành vi thực tế + 与 + Mục tiêu ban đầu / Xu thế thời đại + 背道而驰',
    category: 'Cấu trúc cố định',
    explanation_vi: '"背道而驰" (bèidào\'érchí) kết hợp chữ 背 (quay lưng), 道 (con đường), 驰 (chạy ngựa), miêu tả hành động thực tế chạy theo hướng hoàn toàn trái ngược với mục tiêu, phương châm hoặc quy luật tiến bộ chung của thời đại (đi ngược lại, trái chiều hoàn toàn). Mang sắc thái phê phán mạnh mẽ.',
    examples: [
      {
        chinese: '某些国家搞单边保护主义的逆流，与全球化深度发展的历史潮流显然是背道而驰的。',
        pinyin: 'Mǒuxiē guójiā gǎo dānbiān bǎohùzhǔyì de nìliú, yǔ quánqiúhuà shēndù fāzhǎn de lìshǐ cháoliú xiǎnrán shì bèidào\'érchí de.',
        translation_vi: 'Dòng nước ngược chủ nghĩa bảo hộ đơn phương của một số quốc gia rõ ràng là đi ngược lại hoàn toàn với trào lưu lịch sử phát triển sâu sắc của toàn cầu hóa.',
        explanation: '"与...潮流背道而驰" là lời bình luận quốc tế sắc sảo phê phán chính sách bảo hộ mậu dịch.'
      },
      {
        chinese: '如果口头上高喊减负口号，背地里却不断加码考试难度，这种做法完全与教育初衷背道而驰。',
        pinyin: 'Rúguǒ kǒutóushang gāohǎn jiǎnfù kǒuhào, bèidìlǐ què búduàn jiāmǎ kǎoshì nándù, zhè zhǒng zuòfǎ wánquán yǔ jiàoyù chūzhōng bèidào\'érchí.',
        translation_vi: 'Nếu ngoài miệng hô hào khẩu hiệu giảm tải áp lực, nhưng sau lưng lại không ngừng tăng độ khó của các kỳ thi, cách làm này hoàn toàn đi ngược lại ý định ban đầu của giáo dục.',
        explanation: '"与教育初衷背道而驰" vạch trần mâu thuẫn giữa khẩu hiệu và hành động thực tế trong nhà trường.'
      }
    ]
  },
  {
    order_index: 86,
    name: 'Cấu trúc quy nạp đồng quy trăm sông về biển "殊途同归" (Khác đường cùng đích / Đều hướng về một mục tiêu)',
    pattern: 'Phương pháp A và Phương pháp B tuy khác nhau, nhưng + 殊途同归',
    category: 'Cấu trúc cố định',
    explanation_vi: '"殊途同归" (shūtú tóngguī) kết hợp chữ 殊 (khác nhau), 途 (con đường), 同 (cùng), 归 (quy về một mối), mang nghĩa đi bằng những con đường, giải pháp, góc nhìn khác nhau nhưng cuối cùng đều dẫn tới cùng một kết quả hoặc chân lý tốt đẹp (khác đường cùng đích, trăm sông đổ về một biển).',
    examples: [
      {
        chinese: '世界各大古老文明虽然起源地理环境迥异，但在追求人类社会公平正义的道德准则上却是殊途同归。',
        pinyin: 'Shìjiè gè dà gǔlǎo wénmíng suīrán qǐyuán dìlǐ huánjìng jiǒngyì, dàn zài zhuīqiú rénlèi shèhuì gōngpíng zhèngyì de dàodé zhǔnzé shang què shì shūtútóngguī.',
        translation_vi: 'Các nền văn minh cổ đại lớn trên thế giới tuy môi trường địa lý khởi nguồn hoàn toàn khác biệt, nhưng trên chuẩn tắc đạo đức mưu cầu công bằng chính nghĩa cho xã hội loài người lại đều hướng về cùng một đích đến.',
        explanation: '"殊途同归" làm nổi bật sự hội tụ giá trị nhân loại phổ quát xuyên qua các nền văn minh.'
      },
      {
        chinese: '中西医在治病救人的机理体系上虽然各有侧重，但其维护人类生命健康的崇高使命殊途同归。',
        pinyin: 'Zhōngxīyī zài zhìbìngjiùrén de jīlǐ tǐxì shang suīrán gè yǒu cèzhòng, dàn qí wéihù rénlèi shēngmìng jiànkāng de chónggāo shǐmìng shūtútóngguī.',
        translation_vi: 'Đông y và Tây y trên hệ thống cơ chế trị bệnh cứu người tuy mỗi bên có điểm nhấn riêng, nhưng sứ mệnh cao cả bảo vệ sức khỏe tính mạng nhân loại của đôi bên lại cùng hướng về một mục tiêu.',
        explanation: '"使命殊途同归" khẳng định sự giao thoa hài hòa giữa y học cổ truyền và y học hiện đại.'
      }
    ]
  },
  {
    order_index: 87,
    name: 'Cấu trúc quy luật phát triển bài bản khoa học "循序渐进" (Tuần tự tiến bước / Theo trình tự khoa học)',
    pattern: 'Học tập / Cải cách + 必须 + 循序渐进, 不可操之过急',
    category: 'Cấu trúc cố định',
    explanation_vi: '"循序渐进" (xúnxù jiànjìn) kết hợp chữ 循 (tuân theo), 序 (trình tự), 渐 (dần dần), 进 (tiến lên), biểu thị việc học tập, rèn luyện hoặc cải cách thể chế bắt buộc phải tiến hành từng bước theo đúng quy luật phát triển từ dễ đến khó, từ thấp đến cao, không được nôn nóng đốt cháy giai đoạn (tuần tự từng bước). Thường đi với "不可操之过急".',
    examples: [
      {
        chinese: '掌握一门高难度外语必须遵循循序渐进的科学规律，绝不可能靠突击几天便一蹴而就。',
        pinyin: 'Zhǎowò yì mén gāonándù wàiyǔ bìxū zūnxún xúnxùjiànjìn de kēxué guīlǜ, jué bù kěnéng kào tūjī jǐ tiān biàn yícù\'érjiù.',
        translation_vi: 'Nắm vững một ngoại ngữ có độ khó cao bắt buộc phải tuân theo quy luật khoa học tuần tự từng bước, tuyệt đối không thể dựa vào vài ngày học nhồi nhét cấp tốc mà một bước thành tài ngay được.',
        explanation: '"遵循循序渐进的规律" răn dạy sự kiên nhẫn tích lũy trong việc tiếp thu ngôn ngữ.'
      },
      {
        chinese: '资本市场的全面对外开放当坚持稳中求进、循序渐进，有效防范跨境金融风险传染。',
        pinyin: 'Zīběn shìchǎng de quánmiàn duìwài kāifàng dāng jiānchí wěnzhōngqiújìn, xúnxùjiànjìn, yǒuxiào fángfàn kuàjìng jīnróng fēngxiǎn chuánrǎn.',
        translation_vi: 'Việc mở cửa toàn diện thị trường vốn với bên ngoài cần kiên trì phương châm tìm kiếm tiến bộ trong sự ổn định, tuần tự từng bước, phòng ngừa hiệu quả sự lây lan rủi ro tài chính xuyên biên giới.',
        explanation: '"循序渐进" xác lập nguyên tắc thận trọng mở cửa hội nhập tài chính an toàn.'
      }
    ]
  },
  {
    order_index: 88,
    name: 'Cấu trúc phán đoán lẽ tự nhiên đạo lý "理所当然" (Đương nhiên / Lẽ tất nhiên phải vậy)',
    pattern: 'Chủ ngữ + 享受权利 / 履行义务, 是理所当然的',
    category: 'Cấu trúc cố định',
    explanation_vi: '"理所当然" (lǐ suǒ dāng rán) kết hợp chữ 理 (đạo lý), 当 (phải, nên), 然 (như vậy), mang nghĩa xét về mặt quy luật, đạo đức hoặc khế ước thì sự việc diễn ra như thế là hoàn toàn hợp tình hợp lý, hiển nhiên không cần phải bàn cãi (lẽ tất nhiên, đương nhiên là phải thế).',
    examples: [
      {
        chinese: '子女在成年后赡养照顾年迈体弱的父母，无论从伦理道德还是法律义务上讲都是理所当然的。',
        pinyin: 'Zǐnǚ zài chéngnián hòu shànyǎng zhàogù niánmài tǐruò de fùmǔ, wúlùn cóng lúnlǐ dàodé háishì fǎlǜ yìwù shang jiǎng dōu shì lǐsuǒdāngrán de.',
        translation_vi: 'Con cái sau khi trưởng thành phụng dưỡng chăm sóc cha mẹ già yếu, bất luận xét từ góc độ luân lý đạo đức hay nghĩa vụ pháp luật đều là điều hiển nhiên đương nhiên phải làm.',
        explanation: '"是理所当然的" khẳng định đạo hiếu phụng dưỡng cha mẹ là thiên chức đạo đức bất biến.'
      },
      {
        chinese: '在知识经济时代，创新者通过合法的知识产权保护获取商业回报是理所当然的权利。',
        pinyin: 'Zài zhīshi jīngjì shídài, chuàngxīnzhě tōngguò héfǎ de zhīshi chǎnquán bǎohù huòqǔ shāngyè huíbào shì lǐsuǒdāngrán de quánlì.',
        translation_vi: 'Trong thời đại kinh tế tri thức, người đổi mới sáng tạo thông qua việc bảo hộ quyền sở hữu trí tuệ hợp pháp thu về lợi ích thương mại là quyền lợi đương nhiên chính đáng.',
        explanation: '"理所当然的权利" bảo vệ quyền sở hữu trí tuệ của nhà phát minh sáng chế.'
      }
    ]
  },
  {
    order_index: 89,
    name: 'Cấu trúc phê phán hành vi trái quy luật tự nhiên "缘木求鱼" (Leo cây tìm cá / Làm chuyện ngược đời)',
    pattern: 'Phương pháp sai lầm + 无异于 / 等同于 + 缘木求鱼',
    category: 'Cấu trúc cố định',
    explanation_vi: '"缘木求鱼" (yuán mù qiú yú) là tích xưa Mạnh Tử: leo lên cây để bắt cá (chữ 缘 nghĩa là leo). Dùng để chỉ phương hướng hoặc phương pháp tiếp cận hoàn toàn sai lầm, trái với quy luật khách quan nên vĩnh viễn không bao giờ đạt được mục đích (leo cây tìm cá, làm chuyện hão huyền trái quy luật).',
    examples: [
      {
        chinese: '企图不经过刻苦踏实的日常积累而单凭考前突击押题取得优异成绩，无异于缘木求鱼。',
        pinyin: 'Qǐtú bù jīngguò kèkǔ tāshi de rìcháng jīlěi ér dān píng kǎoqián tūjī yātí qǔdé yōuyì chéngjì, wúyìyú yuánmùqiúyú.',
        translation_vi: 'Mưu toan không qua sự tích lũy chăm chỉ vững chắc thường ngày mà chỉ dựa vào việc học tủ đoán đề trước thi để đạt thành tích xuất sắc, chẳng khác nào leo cây tìm cá.',
        explanation: '"无异于缘木求鱼" phê phán tâm lý ỷ lại vào học tủ may rủi trong thi cử.'
      },
      {
        chinese: '脱离群众的真实生活关切而关起门来搞所谓的文学艺术创作，终究只能是缘木求鱼。',
        pinyin: 'Tuōlí qúnzhòng de zhēnshí shēnghuó guānqiè ér guānqǐ mén lái gǎo suǒwèi de wénxué yìshù chuàngzuò, zhōngjiū zhǐ néng shì yuánmùqiúyú.',
        translation_vi: 'Tách rời sự quan tâm đời sống chân thực của quần chúng mà đóng kín cửa làm cái gọi là sáng tác văn học nghệ thuật, rốt cuộc cũng chỉ có thể là leo cây tìm cá mà thôi.',
        explanation: '"终究只能是缘木求鱼" răn dạy nghệ sĩ không được thoát ly hiện thực đời sống nhân dân.'
      }
    ]
  },
  {
    order_index: 90,
    name: 'Cấu trúc phòng ngừa rủi ro từ trong trứng nước "防患于未然" (Phòng ngừa hiểm họa từ lúc chưa phát sinh)',
    pattern: '必须 + 建立健全机制 / 提高警惕, 防患于未然',
    category: 'Cấu trúc cố định',
    explanation_vi: '"防患于未然" (fáng huàn yú wèi rán) kết hợp chữ 防 (phòng ngừa), 患 (tai họa), 于 (ở, tại), 未然 (khi chưa xảy ra), mang nghĩa áp dụng mọi biện pháp phòng ngừa nghiêm ngặt trước khi sự cố hay thảm họa bộc phát để triệt tiêu mọi mầm mống rủi ro (phòng ngừa hiểm họa từ lúc chưa phát sinh, lo toan chu đáo trước).',
    examples: [
      {
        chinese: '安全生产重在日常预防，企业必须建立全覆盖的排查监管机制，切实防患于未然。',
        pinyin: 'Ānquán shēngchǎn zhòng zài rìcháng yùfáng, qǐyè bìxū jiànlì quán fùgài de páichá jiānguǎn jīzhì, qièshí fánghuànyúwèirán.',
        translation_vi: 'An toàn sản xuất cốt ở việc phòng ngừa thường nhật, doanh nghiệp bắt buộc phải thiết lập cơ chế rà soát giám sát bao phủ toàn diện, thiết thực phòng ngừa hiểm họa từ lúc chưa phát sinh.',
        explanation: '"防患于未然" là kim chỉ nam an toàn lao động trong quản lý sản xuất công nghiệp.'
      },
      {
        chinese: '在汛期到来之前提前加固水利大堤并疏浚河道，才能未雨绸缪、防患于未然。',
        pinyin: 'Zài xùnqī dàolái zhīqián tíqián jiāgù shuǐlì dàdī bìng shūjùn hédào, cái néng wèiyǔchóumóu, fánghuànyúwèirán.',
        translation_vi: 'Trước khi mùa mưa lũ kéo tới gia cố trước đê điều thủy lợi và nạo vét lòng sông thì mới có thể lo toan chu đáo trước lúc mưa giông, phòng ngừa hiểm họa từ lúc chưa bùng phát.',
        explanation: '"未雨绸缪、防患于未然" là cặp thành ngữ đôi miêu tả nghệ thuật phòng chống thiên tai chủ động.'
      }
    ]
  },
  {
    order_index: 91,
    name: 'Cấu trúc linh hoạt thích ứng tình huống "随机应变" (Tùy cơ ứng biến / Linh hoạt thích nghi)',
    pattern: '面对瞬息万变的局势, 必须 + 善于 / 沉着 + 随机应变',
    category: 'Cấu trúc cố định',
    explanation_vi: '"随机应变" (suí jī yìng biàn) kết hợp chữ 随 (nương theo), 机 (thời cơ, hoàn cảnh biến đổi), 应变 (ứng phó với sự biến), biểu thị năng lực tư duy nhạy bén, biết tùy theo sự thay đổi của tình thế khách quan mà linh hoạt điều chỉnh chiến thuật hành động thích hợp, không dập khuôn máy móc.',
    examples: [
      {
        chinese: '商场如战场，面对瞬息万变的市场供需形势，企业家必须具备沉着冷静、随机应变的高超指挥艺术。',
        pinyin: 'Shāngchǎng rú zhànchǎng, miànduì shùnxīwànbiàn de shìchǎng gōngxū xíngshì, qǐyèjiā bìxū jùbèi chénzhuó lěngjìng, suíjīyìngbiàn de gāochāo zhǐhuī yìshù.',
        translation_vi: 'Thương trường như chiến trường, đối mặt với tình thế cung cầu thị trường biến đổi trong từng hơi thở, nhà doanh nghiệp bắt buộc phải hội tụ nghệ thuật chỉ huy tài ba trầm tĩnh bình thản và tùy cơ ứng biến.',
        explanation: '"随机应变的高超指挥艺术" tôn vinh sự linh hoạt nhạy bén của lãnh đạo doanh nghiệp.'
      },
      {
        chinese: '在野外突发恶劣极端天气时，领队要善于根据地形和风向随机应变，迅速带领队伍避险。',
        pinyin: 'Zài yěwài tūfā èliè jíduān tiānqì shí, lǐngduì yào shànyú gēnjù dìxíng hé fēngxiàng suíjīyìngbiàn, xùnsù dàilǐng duìwù bìxiǎn.',
        translation_vi: 'Khi nơi hoang dã đột phát thời tiết cực đoan khắc nghiệt, người trưởng đoàn phải giỏi căn cứ theo địa hình và hướng gió để tùy cơ ứng biến, nhanh chóng dẫn dắt đoàn lánh nạn.',
        explanation: '"善于...随机应变" là kỹ năng sinh tồn then chốt bảo vệ an toàn tính mạng nơi thiên nhiên hoang dã.'
      }
    ]
  },
  {
    order_index: 92,
    name: 'Cấu trúc tương khắc không thể dung hòa "水火不容" (Như nước với lửa / Tuyệt đối không đội trời chung)',
    pattern: 'A 与 B + 犹如水火不容 / 矛盾双方 + 势同水火',
    category: 'Cấu trúc cố định',
    explanation_vi: '"水火不容" (shuǐ huǒ bù róng) dùng hình ảnh nước và lửa tương khắc triệt tiêu lẫn nhau để ẩn dụ cho hai lập trường, quan điểm hoặc hệ giá trị đối kháng gay gắt, mâu thuẫn đối kháng sâu sắc đến mức tuyệt đối không thể cùng tồn tại song hành hay dung hòa lẫn nhau.',
    examples: [
      {
        chinese: '坚守公平正义的职业良知与追逐不正当私利的贪腐念头，是水火不容、绝不相容的。',
        pinyin: 'Jiānshǒu gōngpíng zhèngyì de zhíyè liángzhī yǔ zhuīzhú búzhengdàng sīlì de tānfǔ niàntou, shì shuǐhuǒbùróng, jué bù xiāngróng de.',
        translation_vi: 'Lương tâm nghề nghiệp kiên định bảo vệ công bằng chính nghĩa và ý niệm tham nhũng theo đuổi tư lợi bất chính là điều như nước với lửa, tuyệt đối không thể dung hòa.',
        explanation: '"水火不容" phân định ranh giới đạo đức liêm chính không thể nhân nhượng.'
      },
      {
        chinese: '真正的学术自由探索与学术不端抄袭剽窃行为，本质上是势同水火、不可调和的。',
        pinyin: 'Zhēnzhèng de xuéshù zìyóu tànsuǒ yǔ xuéshù bùduān chāoxí piāoqiè xíngwéi, běnzhì shang shì shìtóngshuǐhuǒ, bùkě tiáohé de.',
        translation_vi: 'Sự tự do tìm tòi học thuật chân chính và hành vi bất lương sao chép đạo văn học thuật về bản chất là như nước với lửa, không thể điều hòa.',
        explanation: '"势同水火" khẳng định sự đối lập tận gốc rễ giữa nghiên cứu chân chính và hành vi đạo văn.'
      }
    ]
  },
  {
    order_index: 93,
    name: 'Cấu trúc đồng cam vinh nhục máu thịt "荣辱与共" (Vinh nhục có nhau / Cùng chia sẻ vinh quang và cay đắng)',
    pattern: 'A 与 B + 风雨同舟, 荣辱与共',
    category: 'Cấu trúc cố định',
    explanation_vi: '"荣辱与共" (róngrǔ yǔgòng) kết hợp chữ 荣 (vinh quang), 辱 (tủi nhục, hoạn nạn), 与共 (cùng chia sẻ), mang nghĩa cùng nhau gánh vác mọi thành bại, cùng chia sẻ ánh hào quang vinh dự lẫn lúc chịu đựng gian nan thử thách (vinh nhục có nhau, chung lưng đấu cật). Thường đi với "风雨同舟".',
    examples: [
      {
        chinese: '几十年来，各民主党派与中国共产党风雨同舟、荣辱与共，共同谱写了爱国统一战线的光辉篇章。',
        pinyin: 'Jǐshí nián lái, gè mínzhǔ dǎngpài yǔ Zhōngguó Gòngchǎndǎng fēngyǔtóngzhōu, róngrǔyǔgòng, gòngtóng pǔxiě le àiguó tǒngyī zhànxiàn de guānghuī piānzhāng.',
        translation_vi: 'Mấy chục năm qua, các đảng phái dân chủ cùng Đảng Cộng sản Trung Quốc kề vai sát cánh cùng chung một con thuyền, vinh nhục có nhau, cùng viết nên thiên trang vẻ vang của mặt trận thống nhất yêu nước.',
        explanation: '"风雨同舟、荣辱与共" là phương châm hợp tác chính trị đa đảng đoàn kết thống nhất.'
      },
      {
        chinese: '全体员工同心协力把企业视作自己的大家庭，在市场风浪中与公司荣辱与共、患难相恤。',
        pinyin: 'Quántǐ yuángōng tóngxīnxiélì bǎ qǐyè shìzuò zìjǐ de dàjiātíng, zài shìchǎng fēnglàng zhōng yǔ gōngsī róngrǔyǔgòng, huànnàn xiāngxù.',
        translation_vi: 'Toàn thể nhân viên đồng tâm hiệp lực coi doanh nghiệp như đại gia đình của mình, trước sóng gió thương trường cùng công ty vinh nhục có nhau, hoạn nạn đùm bọc lẫn nhau.',
        explanation: '"与公司荣辱与共" thể hiện sự gắn bó son sắt trung thành giữa người lao động và tập thể doanh nghiệp.'
      }
    ]
  }
];
