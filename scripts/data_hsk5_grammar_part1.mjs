// ==============================================================================
// DATA: data_hsk5_grammar_part1.mjs
// HSK 5 GRAMMAR - PART 1: ĐIỂM 1 ĐẾN 28 (CHUẨN GF 0025-2021 APPENDIX A)
// Đại từ văn ngôn/chính luận, Ước lượng văn viết, Hệ thống Lượng từ chuyên biệt HSK 5
// ==============================================================================

export const HSK5_GRAMMAR_PART1 = [
  {
    order_index: 1,
    name: 'Đại từ văn ngôn chỉ định và sở thuộc "其" (Của nó / Trong đó / Họ)',
    pattern: '其 + Danh từ / 其中 / 其实 / 其余 / 极其 / 莫名其妙',
    category: 'Đại từ',
    explanation_vi: '"其" (qí) là đại từ nguồn gốc văn ngôn cổ được sử dụng rộng rãi trong tiếng Trung hiện đại, đặc biệt là văn viết chính luận, khoa học và báo chí. "其" tương đương với "他/她/它的" (của anh ấy/cô ấy/nó) hoặc "他们/它们" (của họ/chúng). Ngoài ra "其" tạo thành nhiều từ ghép cố định tối quan trọng như 其中 (trong đó), 其实 (thực ra), 其余 (phần còn lại), 极其 (cực kỳ).',
    examples: [
      {
        chinese: '任何事物的发展都有其自身的规律，我们不能急于求成。',
        pinyin: 'Rènhé shìwù de fāzhǎn dōu yǒu qí zìshēn de guīlǜ, wǒmen bù néng jíyúqiúchéng.',
        translation_vi: 'Sự phát triển của bất kỳ sự vật nào đều có quy luật của chính bản thân nó, chúng ta không thể nôn nóng muốn thành công ngay.',
        explanation: '"其自身" tương đương với "它自身" (chính bản thân nó), "其" thay thế cho "事物" tạo sắc thái văn phong triết lý sâu sắc.'
      },
      {
        chinese: '参加本次论坛的专家共有五十位，其中半数来自海外知名院校。',
        pinyin: 'Cānjiā běn cì lùntán de zhuānjiā gòng yǒu wǔshí wèi, qízhōng bànshù láizì hǎiwài zhīmíng yuànxiào.',
        translation_vi: 'Có tổng cộng 50 chuyên gia tham dự diễn đàn lần này, trong số đó một nửa đến từ các trường viện nổi tiếng ở nước ngoài.',
        explanation: '"其中" (trong số đó) là cụm từ cố định dẫn ra một bộ phận thành viên nằm trong tổng thể 50 chuyên gia.'
      }
    ]
  },
  {
    order_index: 2,
    name: 'Đại từ nghi vấn văn ngôn phản vấn "何" (Gì / Thế nào / Sao)',
    pattern: '何 + Động từ/Danh từ (何必 / 何况 / 何在 / 何尝 / 为何 / 任何)',
    category: 'Đại từ',
    explanation_vi: '"何" (hé) là đại từ nghi vấn văn ngôn tương đương với "什么" (cái gì), "为什么" (tại sao) hoặc "怎么" (thế nào). Trong tiếng Trung hiện đại HSK 5, "何" thường xuất hiện trong các kết cấu câu trang trọng hoặc các liên từ, phó từ phản vấn như 何必 (hà tất), 何况 (huống hồ), 为何 (vì sao), 何在 (ở đâu, nằm ở chỗ nào).',
    examples: [
      {
        chinese: '面对如此明显的错误事实，你又为何迟迟不肯当面承认呢？',
        pinyin: 'Miànduì rúcǐ míngxiǎn de cuòwù shìshí, nǐ yòu wèihé chíchí bù kěn dāngmiàn chéngrèn ne?',
        translation_vi: 'Đối mặt với sự thật sai sót rõ ràng như thế này, cậu lại vì cớ gì mà cứ chần chừ không chịu thừa nhận trước mặt chứ?',
        explanation: '"为何" là cách diễn đạt trang trọng của "为什么", biểu thị ngữ khí chất vấn nghiêm túc.'
      },
      {
        chinese: '企业要想在激烈的市场中立足，其核心竞争力究竟何在？',
        pinyin: 'Qǐyè yào xiǎng zài jīliè de shìchǎng zhōng lìzú, qí héxīn jìngzhēnglì jiūjìng hézài?',
        translation_vi: 'Doanh nghiệp muốn đứng vững trong thị trường cạnh tranh khốc liệt, sức cạnh tranh cốt lõi của nó rốt cuộc nằm ở đâu?',
        explanation: '"何在" tương đương với "在哪里" (nằm ở nơi đâu), đặt ra câu hỏi bản chất về năng lực cạnh tranh.'
      }
    ]
  },
  {
    order_index: 3,
    name: 'Đại từ nhân xưng xưng hô trang trọng tập thể "诸位" (Chư vị / Các vị)',
    pattern: '诸位 + (Danh từ xưng hô) / 诸位 + Xin hãy...',
    category: 'Đại từ',
    explanation_vi: '"诸位" (zhūwèi) là đại từ nhân xưng ngôi thứ hai số nhiều mang sắc thái vô cùng lịch thiệp, trang trọng (chư vị, các vị, quý vị). Thường được các diễn giả, người chủ trì hoặc lãnh đạo sử dụng khi mở đầu bài phát biểu, diễn thuyết trước cử tọa (như 诸位来宾, 诸位同事, 诸位朋友).',
    examples: [
      {
        chinese: '非常荣幸能与诸位专家学者共同探讨人工智能的未来趋势。',
        pinyin: 'Fēicháng róngxìng néng yǔ zhūwèi zhuānjiā xuézhě gòngtóng tàntǎo réngōng zhìnéng de wèilái qūshì.',
        translation_vi: 'Vô cùng vinh hạnh khi được cùng chư vị chuyên gia học giả thảo luận về xu thế tương lai của trí tuệ nhân tạo.',
        explanation: '"诸位专家学者" là cách xưng hô kính cẩn của diễn giả trước đông đảo các nhà khoa học.'
      },
      {
        chinese: '诸位请安静，今天的新闻发布会马上就要正式开始了。',
        pinyin: 'Zhūwèi qǐng ānjìng, jīntiān de xīnwén fābùhuì mǎshàng jiù yào zhèngshì kāishǐ le.',
        translation_vi: 'Xin chư vị hãy giữ trật tự, buổi họp báo tin tức hôm nay sắp sửa chính thức bắt đầu rồi.',
        explanation: '"诸位请安静" dùng đại từ xưng hô trang trọng để thu hút sự chú ý của toàn thể phóng viên trong khán phòng.'
      }
    ]
  },
  {
    order_index: 4,
    name: 'Đại từ văn ngôn phiếm chỉ bao quát "凡" (Phàm là / Hễ là / Toàn bộ)',
    pattern: '凡 + Danh từ/Mệnh đề, 皆 / 都 + Vị ngữ / 凡事 / 大凡',
    category: 'Đại từ',
    explanation_vi: '"凡" (fán) là đại từ phiếm chỉ bắt nguồn từ văn ngôn mang nghĩa "phàm là, hễ là, tất cả những ai/cái gì thuộc phạm vi đó". Trong HSK 5, "凡" thường kết hợp với "皆" (jiē - đều) trong văn cổ ngữ, hoặc kết hợp với "都" trong văn viết hiện đại, tạo nên các thành ngữ như "凡事" (mọi việc), "大凡" (đại phàm).',
    examples: [
      {
        chinese: '凡事预则立，不预则废，做任何工作都需要提前做好充分准备。',
        pinyin: 'Fánshì yù zé lì, bú yù zé fèi, zuò rènhé gōngzuò dōu xūyào tíqián zuò hǎo chōngfèn zhǔnbèi.',
        translation_vi: 'Phàm mọi việc có chuẩn bị trước thì ắt thành công, không chuẩn bị trước thì ắt thất bại, làm bất kỳ công việc gì cũng cần chuẩn bị chu đáo trước.',
        explanation: '"凡事" nghĩa là mọi việc, trích từ câu châm ngôn kinh điển nhấn mạnh tầm quan trọng của sự chuẩn bị.'
      },
      {
        chinese: '凡涉及国家机密的重要文件，一律不得通过公共互联网传输。',
        pinyin: 'Fán shèjí guójiā jīmì de zhòngyào wénjiàn, yílǜ bùdé tōngguò gōnggòng hùliánwǎng chuānshū.',
        translation_vi: 'Phàm là tài liệu quan trọng liên quan đến bí mật quốc gia, nhất loạt không được truyền qua mạng internet công cộng.',
        explanation: '"凡涉及..." bao quát toàn bộ tài liệu cơ mật theo quy định bảo mật an ninh thông tin.'
      }
    ]
  },
  {
    order_index: 5,
    name: 'Số từ văn ngôn chỉ tỉ lệ mười phần "成" (Phần mười / 10%)',
    pattern: 'Số từ + 成 (三成 = 30% / 七成 = 70% / 九成 / 几成)',
    category: 'Số từ',
    explanation_vi: '"成" (chéng) trong lĩnh vực kinh tế, tài chính và phân tích xã hội biểu thị đơn vị một phần mười (tương đương 10%). Ví dụ: 一成 = 10%, 三成 = 30%, 八成 = 80%. Ngoài ra, trong khẩu ngữ "八成" hoặc "九成" còn làm phó từ mang nghĩa "chắc chắn đến tám chín phần mười, khả năng rất cao".',
    examples: [
      {
        chinese: '今年我国新能源汽车的市场占有率已经成功突破了三成。',
        pinyin: 'Jīnnián wǒ guó xīn néngyuán qìchē de shìchǎng zhànyǒulǜ yǐjīng chénggōng tūpò le sān chéng.',
        translation_vi: 'Năm nay thị phần xe ô tô năng lượng mới của nước ta đã thành công vượt mốc 30% (ba phần mười).',
        explanation: '"三成" chỉ tỉ lệ 30% thị phần tiêu thụ trong phân tích kinh tế vĩ mô.'
      },
      {
        chinese: '看他今天满面春风的样子，这次面试八成是顺利通过了。',
        pinyin: 'Kàn tā jīntiān mǎnmiànchūnfēng de yàngzi, zhè cì miànshì bāchéng shì shùnlì tōngguò le.',
        translation_vi: 'Nhìn vẻ mặt hớn hở tràn đầy sức sống của anh ấy hôm nay, buổi phỏng vấn lần này đến tám chín phần mười là đã trót lọt đỗ rồi.',
        explanation: '"八成" ở đây đóng vai trò ước lượng xác suất cao (khoảng 80–90%) trong nhận định tâm lý.'
      }
    ]
  },
  {
    order_index: 6,
    name: 'Số từ phiếm chỉ số lượng không xác định "若干" (Một số / Mấy / Vài)',
    pattern: '若干 + (Lượng từ) + Danh từ / 划分为若干部分',
    category: 'Số từ',
    explanation_vi: '"若干" (ruògān) là số từ văn viết biểu thị một số lượng không xác định hoặc chưa tiện nêu con số cụ thể (khoảng một vài, một số, mấy). Thường dùng trong các văn kiện pháp quy, điều lệ, đề cương khoa học hoặc hợp đồng kinh tế.',
    examples: [
      {
        chinese: '为了便于深入研究，专家组将整个课题细分成了若干个子项目。',
        pinyin: 'Wèile biànyú shēnrù yánjiū, zhuānjiāzǔ jiǎng zhěng gè kètí xìfēn chéng le ruògān gè zǐxiàngmù.',
        translation_vi: 'Để tiện cho việc nghiên cứu chuyên sâu, tổ chuyên gia đã chia nhỏ toàn bộ đề tài thành một số dự án nhánh.',
        explanation: '"若干个子项目" chỉ một số dự án thành phần được chia tách có hệ thống.'
      },
      {
        chinese: '经过若干年的艰苦奋斗，这片曾经荒凉的戈壁滩变成了绿洲。',
        pinyin: 'Jīngguò ruògān nián de jiānkǔ fèndòu, zhè piàn céngjīng huāngliáng de gēbìtān biànchéng le lǜzhōu.',
        translation_vi: 'Sau mấy năm ròng phấn đấu gian khổ, vùng đất sa mạc từng cằn cỗi hoang vu này đã biến thành một ốc đảo xanh tươi.',
        explanation: '"若干年" chỉ khoảng thời gian nhiều năm phấn đấu kiên trì không ghi đích danh số năm.'
      }
    ]
  },
  {
    order_index: 7,
    name: 'Danh lượng từ chuyên dùng cho luồng khí, sức lực, mùi vị "股" (Luồng / Cơn / Dòng / Món)',
    pattern: 'Số từ + 股 + Danh từ (力量 / 气味 / 热流 / 暖意 / 热情 / 泉水 / 烟)',
    category: 'Lượng từ',
    explanation_vi: '"股" (gǔ) là lượng từ chuyên dùng cho: 1) Các hiện tượng vô hình hoặc chất khí có dòng chảy như mùi hương, luồng nhiệt, khói (一股清香, 一股热浪); 2) Cảm xúc, tinh thần hoặc sức lực bộc phát mạnh mẽ (一股力量, 一股劲儿); 3) Dòng người hoặc nhóm người di chuyển (一股势力, 一股土匪).',
    examples: [
      {
        chinese: '走进花园，迎面扑来一股淡淡的茉莉花清香。',
        pinyin: 'Zǒujìn huāyuán, yíngmiàn pūlái yì gǔ dàndàn de mòlìhuā qīngxiāng.',
        translation_vi: 'Bước vào hoa viên, phả thẳng vào mặt là một luồng hương hoa nhài thơm mát thoang thoảng.',
        explanation: '"一股...清香" dùng "股" định lượng cho dòng hương thơm dịu mát của hoa cỏ.'
      },
      {
        chinese: '看到大家毫无私心的支援，他心头顿时涌起了一股强烈的暖意。',
        pinyin: 'Kàndào dàjiā háowú sīxīn de zhīyuán, tā xīntóu dùnshí yǒngqǐ le yì gǔ qiángliè de nuǎnyì.',
        translation_vi: 'Nhìn thấy sự chi viện không chút vụ lợi của mọi người, trong lòng anh ấy lập tức dâng trào một luồng cảm giác ấm áp mãnh liệt.',
        explanation: '"一股强烈的暖意" dùng "股" miêu tả dòng cảm xúc ấm áp dạt dào trong tâm khảm.'
      }
    ]
  },
  {
    order_index: 8,
    name: 'Danh lượng từ & động lượng từ chỉ đợt, cơn ngắn "阵" (Cơn / Trận / Đợt)',
    pattern: '一 + 阵 + Danh từ (雨 / 风 / 掌声 / 欢呼声 / 剧痛) / 一阵阵',
    category: 'Lượng từ',
    explanation_vi: '"阵" (zhèn) biểu thị một khoảng thời gian ngắn hoặc một đợt bộc phát của hành động, hiện tượng tự nhiên hoặc âm thanh diễn ra trong chốc lát rồi ngớt (như 一阵风 - cơn gió, 一阵掌声 - một tràng pháo tay). Dạng trùng điệp "一阵阵" diễn tả các đợt sóng âm thanh hoặc cảm giác nối tiếp nhau dồn dập.',
    examples: [
      {
        chinese: '演出结束后，台下立刻爆发出一阵雷鸣般的掌声。',
        pinyin: 'Yǎnchū jiéshù hòu, táixià lìkè bàofā chū yí zhèn léimíng bān de zhǎngshēng.',
        translation_vi: 'Sau khi buổi diễn kết thúc, dưới khán đài lập tức bùng nổ một tràng pháo tay rộn rã như sấm rền.',
        explanation: '"一阵...掌声" định lượng cho tràng vỗ tay nhiệt liệt bùng lên từ khán giả.'
      },
      {
        chinese: '突然刮来了一阵刺骨的狂风，吹得树枝剧烈摇晃。',
        pinyin: 'Tūrán guālái le yí zhèn cìgǔ de kuángfēng, chuī de shùzhī jùliè yáohuàng.',
        translation_vi: 'Đột nhiên một cơn gió lốc buốt xương thổi tới, thổi khiến các cành cây rung lắc dữ dội.',
        explanation: '"一阵...狂风" diễn tả cơn gió lốc thổi mạnh đột ngột trong thời gian ngắn.'
      }
    ]
  },
  {
    order_index: 9,
    name: 'Danh lượng từ chỉ bó, chùm, tia "束" (Bó / Chùm / Tia)',
    pattern: 'Số từ + 束 + Danh từ (花 / 鲜花 / 光 / 阳光 / 激光)',
    category: 'Lượng từ',
    explanation_vi: '"束" (shù) dùng cho: 1) Các vật thể được bó lại, buộc túm lại thành chùm (như 一束鲜花 - một bó hoa tươi); 2) Chùm tia sáng tụ lại chiếu theo đường thẳng (như 一束光 - một chùm sáng, 一束阳光 - một tia nắng mặt trời).',
    examples: [
      {
        chinese: '他手捧着一束美丽的红玫瑰，微笑着走向新娘。',
        pinyin: 'Tā shǒu pěngzhe yí shù měilì de hóng méiguī, wēixiàozhe zǒuxiàng xīnniáng.',
        translation_vi: 'Anh ấy hai tay ôm một bó hoa hồng đỏ tươi đẹp, mỉm cười bước về phía cô dâu.',
        explanation: '"一束...红玫瑰" dùng "束" chỉ bó hoa cưới được kết trang trọng.'
      },
      {
        chinese: '清晨，一束温暖的阳光穿透窗帘，静静地洒在书桌上。',
        pinyin: 'Qīngchén, yí shù wēnnuǎn de yángguāng chuāntòu chuānglián, jìngjìng de sǎ zài shūzhuō shang.',
        translation_vi: 'Sáng sớm, một tia nắng ấm áp xuyên qua rèm cửa sổ, lặng lẽ rọi xuống mặt bàn học.',
        explanation: '"一束温暖的阳光" dùng "束" định lượng cho vạt nắng sáng sớm chiếu xuyên qua khe rèm.'
      }
    ]
  },
  {
    order_index: 10,
    name: 'Danh lượng từ chỉ xâu, chuỗi liên hoàn "串" (Xâu / Chuỗi / Dãy)',
    pattern: 'Số từ + 串 + Danh từ (钥匙 / 葡萄 / 珍珠 / 数字 / 问号 / 糖葫芦)',
    category: 'Lượng từ',
    explanation_vi: '"串" (chuàn) dùng cho các sự vật có cùng chủng loại được xâu nối tiếp liền nhau thành một đường dây (như 一串钥匙 - một chùm chìa khóa, 一串葡萄 - một chùm nho, 一串项链 - một chuỗi dây chuyền). Ngoài ra còn dùng ẩn dụ cho chuỗi trừu tượng (như 一连串问题 - một loạt vấn đề).',
    examples: [
      {
        chinese: '奶奶手里提着一串新鲜的紫葡萄，笑盈盈地递给了孙子。',
        pinyin: 'Nǎinai shǒulǐ tízhe yí chuàn xīnxiān de zǐ pútáo, xiàoyíngyíng de dìgěi le sūnzi.',
        translation_vi: 'Bà nội tay xách một chùm nho tím tươi ngon, cười tươi đon đả đưa cho cháu trai.',
        explanation: '"一串...紫葡萄" dùng "串" chỉ cả chùm quả nho bám tự nhiên trên cuống.'
      },
      {
        chinese: '这一连串突发的严重事故，引起了监管部门的高度警惕。',
        pinyin: 'Zhè yì lián chuàn tūfā de yánzhòng shìgù, yǐnqǐ le jiānguǎn bùmén de gāodù jǐngtì.',
        translation_vi: 'Một chuỗi những sự cố nghiêm trọng bộc phát liên tiếp này đã dấy lên sự cảnh giác cao độ của cơ quan giám sát.',
        explanation: '"一连串...事故" dùng "串" ẩn dụ cho hàng loạt vụ việc xảy ra liên hoàn dồn dập.'
      }
    ]
  },
  {
    order_index: 11,
    name: 'Danh lượng từ chuyên dùng cho hạng mục, công trình, quy định "项" (Hạng mục / Điều)',
    pattern: 'Số từ + 项 + Danh từ (任务 / 技术 / 制度 / 纪录 / 调查 / 研究 / 成果)',
    category: 'Lượng từ',
    explanation_vi: '"项" (xiàng) là lượng từ chuyên dùng cho các sự vụ, hạng mục quy mô, điều khoản luật pháp, kế hoạch nghiên cứu, hoặc thành tựu thể thao mang tính phân mục rõ ràng.',
    examples: [
      {
        chinese: '科学家们经过多年的探索，成功攻克了这这项重大的核心技术。',
        pinyin: 'Kēxuéjiāmen jīngguò duō nián de tànsuǒ, chénggōng gōngkè le zhè xiàng zhòngdà de héxīn jìshù.',
        translation_vi: 'Các nhà khoa học trải qua nhiều năm tìm tòi, đã thành công chinh phục được hạng mục công nghệ cốt lõi trọng đại này.',
        explanation: '"这项重大的核心技术" dùng "项" định lượng cho hạng mục công nghệ cấp quốc gia.'
      },
      {
        chinese: '在这届世界田径锦标赛上，他打破了一项尘封二十年的世界纪录。',
        pinyin: 'Zài zhè jiè shìjiè tiánjìng jǐnbiāosài shang, tā dǎpò le yí xiàng chénfēng èrshí nián de shìjiè jìlù.',
        translation_vi: 'Tại giải vô địch điền kinh thế giới lần này, anh ấy đã phá vỡ một kỷ lục thế giới bị phủ bụi suốt 20 năm.',
        explanation: '"一项...世界纪录" dùng "项" làm lượng từ chuẩn xác cho kỷ lục thể thao thành tích cao.'
      }
    ]
  },
  {
    order_index: 12,
    name: 'Danh lượng từ chỉ lô, đợt hàng hóa hoặc tốp người "批" (Lô / Đợt / Tốp)',
    pattern: 'Số từ + 批 + Danh từ (货物 / 产品 / 游客 / 学员 / 专家) / 第一批 / 分批',
    category: 'Lượng từ',
    explanation_vi: '"批" (pī) biểu thị một tập hợp số lượng lớn hàng hóa, sản phẩm được sản xuất/vận chuyển trong cùng một đợt, hoặc một nhóm đông người được tổ chức xuất phát/huấn luyện theo từng đợt.',
    examples: [
      {
        chinese: '海关工作人员正在对刚从欧洲进口的第一批医疗器械进行严格检验。',
        pinyin: 'Hǎiguān gōngzuò rényuán zhèngzài duì gāng cóng Ōuzhōu jìnkǒu de dì yī pī yīliáo qìxiè jìnxíng yángé jiǎnyàn.',
        translation_vi: 'Các nhân viên hải quan đang tiến hành kiểm nghiệm nghiêm ngặt lô thiết bị y tế đầu tiên vừa nhập khẩu từ châu Âu.',
        explanation: '"第一批医疗器械" chỉ lô hàng hóa thiết bị y tế đợt 1 cập cảng hải quan.'
      },
      {
        chinese: '景区采取了分批进入的限流措施，确保每批游客都能安全游览。',
        pinyin: 'Jǐngqū cǎiqǔ le fēnpī jìnrù de xiànliú cuòshī, quèbǎo měi pī yóukè dōu néng ānquán yóulǎn.',
        translation_vi: 'Khu danh lam thắng cảnh đã áp dụng biện pháp hạn chế dòng người theo từng tốp, bảo đảm mỗi tốp du khách đều có thể tham quan an toàn.',
        explanation: '"分批进入" và "每批游客" dùng "批" để chỉ từng nhóm đoàn người vào cổng luân phiên.'
      }
    ]
  },
  {
    order_index: 13,
    name: 'Danh lượng từ chỉ món tiền, vụ kiện, thương vụ lớn "宗" (Món / Vụ / Loại)',
    pattern: 'Số từ + 宗 + Danh từ (买卖 / 案件 / 交易 / 生意 / 大宗商品)',
    category: 'Lượng từ',
    explanation_vi: '"宗" (zōng) là lượng từ kinh tế, thương mại và tư pháp trang trọng, dùng cho các giao dịch quy mô lớn (như 一宗买卖 - một mối làm ăn lớn, 一宗交易 - một vụ giao dịch), hoặc các vụ án tư pháp (一宗案件). Thuật ngữ "大宗商品" chỉ hàng hóa rời nguyên liệu thô số lượng lớn.',
    examples: [
      {
        chinese: '两国跨国公司经过艰苦谈判，终于促成了一宗高达十亿美元的重大并购交易。',
        pinyin: 'Liǎng guó kuàguó gōngsī jīngguò jiānkǔ tánpàn, zhōngyú cùchéng le yì zōng gāodá shíyì měiyuán de zhòngdà bìnggòu jiāoyì.',
        translation_vi: 'Các công ty đa quốc gia hai nước sau các cuộc đàm phán gian nan, cuối cùng đã thúc đẩy thành công một vụ giao dịch sáp nhập trọng đại lên tới một tỷ đô la Mỹ.',
        explanation: '"一宗...并购交易" dùng "宗" định lượng cho thương vụ sáp nhập doanh nghiệp tài chính khổng lồ.'
      },
      {
        chinese: '警方历时三年不懈追踪，成功侦破了这宗性质极其恶劣的跨国诈骗案件。',
        pinyin: 'Jǐngfāng lìshí sān nián búxiè zhuīzōng, chénggōng zhēnpò le zhè zōng xìngzhì jíqí èliè de kuàguó zhàpiàn ànjiàn.',
        translation_vi: 'Lực lượng cảnh sát trải qua ba năm truy vết không ngừng nghỉ, đã phá thành công vụ án lừa đảo xuyên quốc gia có tính chất cực kỳ nghiêm trọng này.',
        explanation: '"这宗...案件" dùng "宗" làm lượng từ tư pháp chuẩn xác cho vụ án hình sự phức tạp.'
      }
    ]
  },
  {
    order_index: 14,
    name: 'Danh lượng từ chỉ tượng điêu khắc, thần phật trang nghiêm "尊" (Bức / Pho / Vị)',
    pattern: 'Số từ + 尊 + Danh từ (佛像 / 雕塑 / 大炮 / 铜像)',
    category: 'Lượng từ',
    explanation_vi: '"尊" (zūn) là lượng từ thể hiện sự tôn nghiêm, tôn kính cao quý, chuyên dùng cho các bức tượng Phật, pho tượng điêu khắc nghệ thuật cổ điển, tượng đồng vĩ nhân (như 一尊佛像, 一尊雕塑, 一尊青铜像).',
    examples: [
      {
        chinese: '在博物馆中央展厅里，陈列着一尊雕刻精湛的唐代石刻佛像。',
        pinyin: 'Zài bówùguǎn zhōngyāng zhǎntīng lǐ, chénlièzhe yì zūn diāokè jīngzhàn de Tángdài shíkè fóxiàng.',
        translation_vi: 'Ở phòng triển lãm trung tâm của bảo tàng có trưng bày một pho tượng Phật khắc đá thời Đường được chạm trổ tuyệt mỹ.',
        explanation: '"一尊...佛像" dùng "尊" thể hiện sự tôn kính và giá trị linh thiêng của bảo vật tôn giáo cổ.'
      },
      {
        chinese: '广场中央矗立着一尊高大的民族英雄青铜雕塑。',
        pinyin: 'Guǎngchǎng zhōngyāng chùlìzhe yì zūn gāodà de mínzú yīngxióng qīngtóng diāosù.',
        translation_vi: 'Giữa quảng trường sừng sững một bức tượng đồng anh hùng dân tộc uy nghi cao lớn.',
        explanation: '"一尊...青铜雕塑" dùng "尊" để thể hiện sự trang trọng, uy nghiêm của công trình đài tưởng niệm.'
      }
    ]
  },
  {
    order_index: 15,
    name: 'Danh lượng từ chuyên dùng cho tàu thuyền vận tải "艘" (Chiếc / Con tàu)',
    pattern: 'Số từ + 艘 + Danh từ (船 / 轮船 / 军舰 / 货轮 / 潜艇)',
    category: 'Lượng từ',
    explanation_vi: '"艘" (sōu) là lượng từ chuyên dụng dành riêng cho các phương tiện thủy cỡ lớn như tàu thủy, tàu chở hàng, tàu chiến, du thuyền, tàu ngầm (khác với "条" hoặc "只" thường dùng cho thuyền nhỏ dân dụng).',
    examples: [
      {
        chinese: '港口码头边停泊着一艘装满了集装箱的大型远洋货轮。',
        pinyin: 'Gǎngkǒu mǎtóu biān tíngbózhe yì sōu zhuāngmǎn le jízhuāngxiāng de dàxíng yuǎnyáng huòlún.',
        translation_vi: 'Bên cầu cảng có neo đậu một con tàu hàng viễn dương cỡ lớn chở đầy các thùng container.',
        explanation: '"一艘...远洋货轮" dùng "艘" làm lượng từ quy chuẩn cho tàu vận tải viễn dương quốc tế.'
      },
      {
        chinese: '经过严密的技术改造，这艘科考船即将启程前往南极进行深海科学考察。',
        pinyin: 'Jīngguò yánmì de jìshù gǎizào, zhè sōu kēkǎochuán jíjiāng qǐchéng qiánwǎng Nánjí jìnxíng shēnhǎi kēxué kǎochá.',
        translation_vi: 'Sau khi được cải tạo kỹ thuật nghiêm ngặt, con tàu khảo sát khoa học này sắp sửa lên đường tới Nam Cực tiến hành khảo sát khoa học biển sâu.',
        explanation: '"这艘科考船" dùng "艘" định lượng cho tàu chuyên dụng nghiên cứu đại dương.'
      }
    ]
  },
  {
    order_index: 16,
    name: 'Danh lượng từ chỉ tòa nhà, công trình đồ sộ "幢 / 栋" (Tòa / Căn / Dãy nhà)',
    pattern: 'Số từ + 幢 / 栋 + Danh từ (大楼 / 别墅 / 教学楼 / 建筑 / 公寓)',
    category: 'Lượng từ',
    explanation_vi: '"幢" (zhuàng) và "栋" (dòng) là lượng từ chuyên dùng cho các tòa nhà kiến trúc độc lập, nhà cao tầng, khu biệt thự hoặc khối nhà chung cư. "栋" phổ biến hơn trong giao tiếp đời sống và bất động sản, còn "幢" mang sắc thái văn phong miêu tả kiến trúc trang trọng.',
    examples: [
      {
        chinese: '市中心新建成了一幢高达三百米的地标性摩天大楼。',
        pinyin: 'Shìzhōngxīn xīn jiànchéng le yí zhuàng gāodá sān bǎi mǐ de dìbiāoxìng mótiāndàlóu.',
        translation_vi: 'Tại trung tâm thành phố vừa mới xây xong một tòa nhà chọc trời mang tính biểu tượng cao tới 300 mét.',
        explanation: '"一幢...摩天大楼" dùng "幢" định lượng cho tòa tháp chọc trời nguy nga.'
      },
      {
        chinese: '学校规划在湖畔为新引进的青年学者建造两栋现代化的教师公寓。',
        pinyin: 'Xuéxiào guīhuà zài húpàn wèi xīn yǐnjìn de qīngnián xuézhě jiànzào liǎng dòng xiàndàihuà de jiàoshī gōngyù.',
        translation_vi: 'Nhà trường quy hoạch xây dựng bên bờ hồ hai tòa nhà chung cư giáo viên hiện đại dành cho các học giả trẻ mới được thu hút về.',
        explanation: '"两栋...教师公寓" dùng "栋" chỉ hai khối nhà cư xá dành cho giảng viên.'
      }
    ]
  },
  {
    order_index: 17,
    name: 'Phó từ thừa nhận nhượng bộ trước khi chuyển ngoặt "固然" (Cố nhiên / Tuy rằng / Đành rằng)',
    pattern: 'A 固然... (但是 / 可是 / 也...) B',
    category: 'Phó từ',
    explanation_vi: '"固然" (gùrán) dùng để thừa nhận một sự thật, một ưu điểm hoặc thực tế hiển nhiên ở vế trước (đành rằng là như vậy, vốn dĩ đúng là thế), nhưng trọng tâm luận điểm thực sự nằm ở vế sau với quan hệ chuyển ngoặt (nhưng phương diện kia mới là mấu chốt quan trọng hơn).',
    examples: [
      {
        chinese: '工作赚钱固然重要，但是身体健康才是人生最根本的基石。',
        pinyin: 'Gōngzuò zhuànqián gùrán zhòngyào, dànshì shēntǐ jiànkāng cái shì rénshēng zuì gēnběn de jīshí.',
        translation_vi: 'Làm việc kiếm tiền đành rằng là quan trọng, nhưng sức khỏe mới là nền tảng căn bản nhất của đời người.',
        explanation: '"固然...但是..." thừa nhận giá trị của thu nhập để làm nổi bật tầm quan trọng tối cao của sức khỏe.'
      },
      {
        chinese: '引进先进技术固然能够解燃眉之急，但自主创新才拥有长远的未来。',
        pinyin: 'Yǐnjìn xiānjìn jìshù gùrán nénggòu jiě ránméizhījí, dàn zìzhǔ chuàngxīn cái yōngyǒu chángyuǎn de wèilái.',
        translation_vi: 'Du nhập công nghệ tiên tiến cố nhiên có thể giải quyết được nhu cầu cấp bách trước mắt, nhưng tự chủ sáng tạo mới nắm giữ tương lai lâu dài.',
        explanation: '"固然...但..." so sánh giữa giải pháp tình thế trước mắt và chiến lược tự chủ lâu dài.'
      }
    ]
  },
  {
    order_index: 18,
    name: 'Phó từ xác nhận sự thật chân thực "诚然" (Quả thực / Đúng là)',
    pattern: '诚然 + Sự thật thừa nhận, 但是 / 然而 + Luận điểm trọng tâm',
    category: 'Phó từ',
    explanation_vi: '"诚然" (chéngrán) là phó từ cao cấp tương đương với "固然", nhưng mang sắc thái chân thành, trang nghiêm và tính học thuật cao hơn (quả thực là, đúng là như vậy). Người viết thừa nhận một cách khách quan luận cứ của đối phương trước khi phản biện mở rộng.',
    examples: [
      {
        chinese: '这套方案诚然存在一定的执行风险，然而它所能带来的回报同样极其巨大。',
        pinyin: 'Zhè tào fāng\'àn chéngrán cúnzài yídìng de zhíxíng fēngxiǎn, rán\'ér tā suǒ néng dàilái de huíbào tóngyàng jíqí jùdà.',
        translation_vi: 'Phương án này quả thực tồn tại rủi ro thực thi nhất định, tuy nhiên lợi ích đền đáp mà nó có thể mang lại cũng cực kỳ to lớn.',
        explanation: '"诚然...然而..." thể hiện phong thái biện luận khách quan thừa nhận rủi ro song hành cùng cơ hội.'
      },
      {
        chinese: '传统手工业诚然无法与现代机器生产的速度相比，但它蕴含着独一无二的人文温度。',
        pinyin: 'Chuántǒng shǒugōngyè chéngrán wúfǎ yǔ xiàndài jīqì shēngchǎn de sùdù xiāngbǐ, dàn tā yùnhánzhe dúyīwú\'èr de rénwén wēndù.',
        translation_vi: 'Thủ công nghiệp truyền thống quả thực không thể sánh được với tốc độ sản xuất máy móc hiện đại, nhưng nó hàm chứa hơi ấm nhân văn độc nhất vô nhị.',
        explanation: '"诚然...但..." tôn vinh giá trị tinh thần của làng nghề truyền thống trước sức ép công nghiệp.'
      }
    ]
  },
  {
    order_index: 19,
    name: 'Phó từ kiên quyết phủ định lập trường "决不 / 绝不" (Tuyệt đối không / Quyết không)',
    pattern: 'Chủ ngữ + 决不 / 绝不 + Động từ/Tính từ (妥协 / 姑息 / 放弃 / 违背)',
    category: 'Phó từ',
    explanation_vi: '"决不" và "绝不" (juébù) là phó từ biểu thị ý chí sắt đá, quyết tâm sắt son không bao giờ làm một việc gì đó (tuyệt đối không, quyết không nhượng bộ). "决不" thiên về ý chí quyết định của chủ quan con người, còn "绝不" thiên về tính chất tuyệt đối không có ngoại lệ.',
    examples: [
      {
        chinese: '在事关国家领土和主权完整的原则问题上，我们决不作任何妥协。',
        pinyin: 'Zài shìguān guójiā lǐngtǔ hé zhǔquán wánzhěng de yuánzé wèntí shang, wǒmen juébù zuò rènhé tuǒxié.',
        translation_vi: 'Trên vấn đề nguyên tắc liên quan đến chủ quyền và toàn vẹn lãnh thổ quốc gia, chúng ta quyết không đưa ra bất kỳ sự thỏa hiệp nào.',
        explanation: '"决不作任何妥协" tuyên bố đanh thép bảo vệ chủ quyền quốc gia bất khả xâm phạm.'
      },
      {
        chinese: '无论面临多大的诱惑，一名法官都绝不能违背司法公正的职业底线。',
        pinyin: 'Wúlùn miànlín duō dà de yòuhuò, yì míng fǎguān dōu juébù néng wéibèi sīfǎ gōngzhèng de zhíyè dǐxiàn.',
        translation_vi: 'Bất luận đối mặt với cám dỗ lớn đến mức nào, một người thẩm phán đều tuyệt đối không thể làm trái lằn ranh đạo đức nghề nghiệp về sự công bằng tư pháp.',
        explanation: '"绝不能违背..." khẳng định ranh giới liêm chính tối thượng của người cầm cán cân công lý.'
      }
    ]
  },
  {
    order_index: 20,
    name: 'Phó từ dứt khoát kiên quyết không do dự "断然" (Dứt khoát / Kiên quyết)',
    pattern: 'Chủ ngữ + 断然 + Động từ (拒绝 / 采取措施 / 否定 / 采取行动)',
    category: 'Phó từ',
    explanation_vi: '"断然" (duànrán) biểu thị hành động được đưa ra một cách dứt khoát, mạnh mẽ, không một chút do dự hay nhân nhượng (dứt khoát, kiên quyết). Thường đi với các động từ có tính quyết định cao như 拒绝 (từ chối), 采取措施 (áp dụng biện pháp), 否定 (bác bỏ).',
    examples: [
      {
        chinese: '面对不法商人提出的无理要求，负责人断然拒绝了对方的行贿企图。',
        pinyin: 'Miànduì bùfǎ shāngrén tíchū de wúlǐ yāoqiú, fùzérén duànrán jùjué le duìfāng de xínghuì qǐtú.',
        translation_vi: 'Đối mặt với yêu sách vô lý mà thương nhân bất chính đưa ra, người phụ trách đã dứt khoát cự tuyệt mưu toan hối lộ của đối phương.',
        explanation: '"断然拒绝" miêu tả thái độ kiên quyết từ chối thẳng thừng hành vi phi pháp.'
      },
      {
        chinese: '为了防止疫情进一步扩散，有关部门断然采取了严格的封闭隔离措施。',
        pinyin: 'Wèile fángzhǐ yìqíng jìnyíbù kuòsàn, yǒuguān bùmén duànrán cǎiqǔ le yángé de fēngbì gélí cuòshī.',
        translation_vi: 'Để ngăn ngừa dịch bệnh lây lan thêm, các ban ngành hữu quan đã kiên quyết áp dụng các biện pháp phong tỏa cách ly nghiêm ngặt.',
        explanation: '"断然采取...措施" biểu thị hành động quyết đoán nhanh gọn vì an toàn cộng đồng.'
      }
    ]
  },
  {
    order_index: 21,
    name: 'Phó từ phủ định hoàn toàn triệt để "毫不" (Mảy may không / Không chút nào)',
    pattern: '毫不 + Động từ/Tính từ (犹豫 / 畏惧 / 客气 / 掩饰 / 动摇 / 逊色)',
    category: 'Phó từ',
    explanation_vi: '"毫不" (háobù) tương đương với "一点儿也不", biểu thị mức độ phủ định triệt để (không một chút nào, mảy may không). Thường kết hợp với các động từ tâm lý hoặc phẩm chất đạo đức để tạo thành các cụm từ bốn chữ cao cấp như 毫不犹豫 (không chút do dự), 毫不客气 (chẳng chút khách sáo), 毫不畏惧 (không hề sợ hãi).',
    examples: [
      {
        chinese: '当看到落水儿童命悬一线时，那位热心青年毫不犹豫地跳入冰冷的江水中救人。',
        pinyin: 'Dāng kàndào luòshuǐ értóng mìngxuányíxiàn shí, nà wèi rèxīn qīngnián háobù yóuyù de tiàorù bīnglěng de jiāngshuǐ zhōng jiùrén.',
        translation_vi: 'Khi nhìn thấy đứa trẻ rơi xuống nước ngàn cân treo sợi tóc, chàng thanh niên nhiệt huyết đã không chút do dự lao mình xuống dòng sông băng giá cứu người.',
        explanation: '"毫不犹豫地跳入..." ca ngợi hành động dũng cảm cứu người bất chấp hiểm nguy tức thời.'
      },
      {
        chinese: '在这场激烈的辩论赛中，新组建的校队表现得毫不逊色于卫冕冠军。',
        pinyin: 'Zài zhè chǎng jīliè de biànlùnsài zhōng, xīn zǔjiàn de xiàoduì biǎoxiàn de háobù xùnsè yú wèimiǎn guànjūn.',
        translation_vi: 'Trong trận thi đấu tranh biện gay cấn này, đội tuyển trường mới thành lập đã thể hiện mảy may không hề thua kém nhà đương kim vô địch.',
        explanation: '"毫不逊色" là cách nói văn học khẳng định năng lực xuất sắc ngang ngửa với đối thủ hàng đầu.'
      }
    ]
  },
  {
    order_index: 22,
    name: 'Phó từ chỉ mức độ đỉnh điểm trang trọng "极为" (Cực kỳ / Hết sức / Vô cùng)',
    pattern: '极为 + Tính từ song âm tiết / Động từ tâm lý (重要 / 复杂 / 丰富 / 关注 / 遗憾)',
    category: 'Phó từ',
    explanation_vi: '"极为" (jíwéi) là phó từ chỉ mức độ cao cấp trong văn viết và chính luận, tương đương với "非常" hoặc "极其", nhưng mang sắc thái học thuật và văn phong trang nhã hơn. "极为" thường đi liền với tính từ song âm tiết miêu tả tính chất quan trọng, khó khăn hoặc tâm trạng sâu sắc.',
    examples: [
      {
        chinese: '深海探测所获得的第一手地质样本，对地球演化研究具有极为重要的学术价值。',
        pinyin: 'Shēnhǎi tàncè suǒ huòdé de dìyīshǒu dìzhì yàngběn, duì dìqiú yǎnhuà yánjiū jùyǒu jíwéi zhòngyào de xuéshù jiàzhí.',
        translation_vi: 'Mẫu vật địa chất đầu tay thu được từ việc thăm dò biển sâu có giá trị học thuật cực kỳ quan trọng đối với nghiên cứu sự tiến hóa của Trái Đất.',
        explanation: '"极为重要的学术价值" dùng "极为" nhấn mạnh ý nghĩa khoa học đột phá của phát hiện.'
      },
      {
        chinese: '在如此极为恶劣的自然条件下，科考队员们依然坚韧不拔地完成了观测任务。',
        pinyin: 'Zài rúcǐ jíwéi èliè de zìrán tiáojiàn xià, kēkǎo duìyuánmen yīrán jiānrènbùbá de wánchéng le guāncè rènwu.',
        translation_vi: 'Dưới điều kiện tự nhiên khắc nghiệt cùng cực như vậy, các thành viên đội khảo sát khoa học vẫn kiên cường hoàn thành nhiệm vụ quan trắc.',
        explanation: '"极为恶劣" cực tả mức độ hiểm trở và nguy hiểm của khí hậu vùng cực.'
      }
    ]
  },
  {
    order_index: 23,
    name: 'Phó từ phán đoán không chắc chắn "未必" (Chưa hẳn / Chưa chắc)',
    pattern: 'Chủ ngữ + 未必 + (是/能/会/有) + Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"未必" (wèibì) là phó từ phủ định bán phần tương đương với "不一定" (chưa chắc, chưa hẳn). Dùng để phủ định sự võ đoán hoặc một định kiến chủ quan, nhắc nhở người nghe cần xem xét sự việc dưới góc nhìn đa chiều, khách quan hơn.',
    examples: [
      {
        chinese: '最昂贵的商品未必就是品质最好的，适合自己的才是最理想的。',
        pinyin: 'Zuì ángguì de shāngpǐn wèibì jiù shì pǐnzhì zuì hǎo de, shìhé zìjǐ de cái shì zuì lǐxiǎng de.',
        translation_vi: 'Mặt hàng đắt tiền nhất chưa hẳn đã là mặt hàng có chất lượng tốt nhất, cái phù hợp với bản thân mới là lý tưởng nhất.',
        explanation: '"未必就是..." phủ định quan niệm sai lầm đồng nhất giá tiền đắt đỏ với chất lượng hàng hóa.'
      },
      {
        chinese: '凭借一次考试的偶然失利，未必就能说明他在这个学科上缺乏天赋。',
        pinyin: 'Píngjiè yí cì kǎoshì de ǒurán shīlì, wèibì jiù néng shuōmíng tā zài zhè ge xuékē shang quēfá tiānfù.',
        translation_vi: 'Dựa vào một lần trượt kỳ thi ngẫu nhiên, chưa chắc đã có thể chứng minh cậu ấy thiếu năng khiếu ở môn học này.',
        explanation: '"未必就能说明..." khuyên nhủ không nên đánh giá tiềm năng cả đời của học sinh qua một thất bại ngắn hạn.'
      }
    ]
  },
  {
    order_index: 24,
    name: 'Phó từ chỉ kết quả tâm lý tự nhiên tất yếu "不免" (Không khỏi / Khó tránh)',
    pattern: 'Chủ ngữ + 不免 + (会/有点儿) + Động từ tâm lý / Tính từ',
    category: 'Phó từ',
    explanation_vi: '"不免" (bùmiǎn) dùng để diễn tả một cảm xúc, tâm trạng hoặc phản ứng tâm lý nảy sinh một cách hoàn toàn tự nhiên, khó lòng kiềm chế được trước một bối cảnh hay sự kiện cụ thể (không khỏi, khó lòng tránh được cảm giác đó). Thường đi với các từ chỉ cảm xúc như 担心, 难过, 遗憾, 紧张, 兴奋.',
    examples: [
      {
        chinese: '第一次站在上千人的讲台上公开发言，他心里不免感到有些紧张。',
        pinyin: 'Dì yī cì zhàn zài shàngqiān rén de jiǎngtái shang gōngkāi fāyán, tā xīnlǐ bùmiǎn gǎndào yǒuxiē jǐnzhāng.',
        translation_vi: 'Lần đầu tiên đứng trên bục giảng trước hàng nghìn người phát biểu công khai, trong lòng anh ấy không khỏi cảm thấy có đôi chút hồi hộp.',
        explanation: '"不免感到有些紧张" diễn tả tâm lý lo lắng hồi hộp rất con người khi đứng trước đám đông.'
      },
      {
        chinese: '看着老同学各奔前程的背影，离别之际大家心中不免涌起丝丝伤感。',
        pinyin: 'Kànzhe lǎotóngxué gèbènqiánchéng de bèiyǐng, líbié zhījì dàjiā xīnzhōng bùmiǎn yǒngqǐ sīsī shānggǎn.',
        translation_vi: 'Nhìn bóng lưng bạn học cũ mỗi người một ngả vì tương lai, giờ phút chia tay trong lòng mọi người không khỏi dâng lên niềm ngậm ngùi.',
        explanation: '"不免涌起丝丝伤感" miêu tả cảm xúc xúc động bùi ngùi tất yếu lúc tốt nghiệp chia tay.'
      }
    ]
  },
  {
    order_index: 25,
    name: 'Phó từ & Tính từ chỉ quy luật khách quan khó tránh "难免" (Khó tránh khỏi / Tất yếu xảy ra)',
    pattern: '难免 + 会 + Kết quả bất lợi / Làm việc gì đó, 难免 + Thiếu sót',
    category: 'Phó từ',
    explanation_vi: '"难免" (nánmiǎn) vừa là phó từ vừa là tính từ, biểu thị một hiện tượng hoặc kết quả tiêu cực/sai sót là khó lòng tránh khỏi do sự hạn chế của quy luật khách quan hoặc điều kiện thực tế (khó tránh, khó lòng tránh khỏi). Khác với "不免" (thiên về cảm xúc tâm lý), "难免" thiên về sai sót, va chạm hoặc sơ suất trong hành vi.',
    examples: [
      {
        chinese: '初学者在探索新领域时，难免会走一些弯路和犯一些小错误。',
        pinyin: 'Chūxuézhě zài tànsuǒ xīn lǐngyù shí, nánmiǎn huì zǒu yìxiē wānlù hé fàn yìxiē xiǎo cuòwù.',
        translation_vi: 'Người mới bắt đầu học khi tìm tòi khám phá lĩnh vực mới, khó tránh khỏi sẽ đi đường vòng và phạm phải một vài sai lầm nhỏ.',
        explanation: '"难免会走弯路" cảm thông với quy luật vấp ngã tất yếu trong quá trình tích lũy học tập.'
      },
      {
        chinese: '一家人朝夕相处生活在同一个屋檐下，摩擦和矛盾是难免的。',
        pinyin: 'Yì jiā rén zhāoxīxiāngchǔ shēnghuó zài tóng yí gè wūyán xià, mócā hé máodùn shì nánmiǎn de.',
        translation_vi: 'Cả gia đình sớm tối bên nhau sống chung dưới một mái nhà, va chạm và mâu thuẫn là điều khó tránh khỏi.',
        explanation: '"是难免的" dùng làm vị ngữ tính từ khẳng định va chạm đời sống là điều tất nhiên.'
      }
    ]
  },
  {
    order_index: 26,
    name: 'Phó từ suýt chút nữa gặp nạn "险些" (Suýt nữa / Suýt chút nữa)',
    pattern: 'Chủ ngữ + 险些 + (就) + Kết quả xấu / 险些 + Gặp nguy hiểm',
    category: 'Phó từ',
    explanation_vi: '"险些" (xiǎnxiē) là phó từ cao cấp tương đương với "差点儿", biểu thị một tình huống nguy hiểm hoặc kết quả xấu suýt nữa đã xảy ra, nhưng nhờ may mắn hoặc xử lý kịp thời mà thực tế đã không xảy ra (suýt nữa thì, suýt chút nữa). Thường dùng trong văn viết hoặc văn phong kể chuyện kịch tính.',
    examples: [
      {
        chinese: '由于地面结了厚厚一层暗冰，他脚下一滑，险些从台阶上摔了下去。',
        pinyin: 'Yóuyú dìmiàn jié le hòuhòu yì céng ànbīng, tā jiǎoxià yì huá, xiǎnxiē cóng táijiē shang shuāi le xiàqu.',
        translation_vi: 'Do mặt đất đóng một lớp băng trơn mỏng, chân anh ấy trượt một cái, suýt nữa thì ngã nhào từ trên bậc thang xuống.',
        explanation: '"险些...摔了下去" miêu tả cú trượt chân nguy hiểm suýt gây thương tích nhưng may mắn gượng lại kịp.'
      },
      {
        chinese: '大货车紧急变道避让，客车司机反应敏捷，险些酿成一场连环追尾惨剧。',
        pinyin: 'Dà huòchē jǐnjí biàndào bìràng, kèchē sījī fǎnyìng mǐnjié, xiǎnxiē niàngchéng yì chǎng liánhuán zhuīwěi cǎnjù.',
        translation_vi: 'Xe tải lớn đột ngột đổi làn né tránh, tài xế xe khách phản xạ nhanh nhạy, suýt chút nữa đã gây ra một thảm kịch đâm dồn đuôi xe liên hoàn.',
        explanation: '"险些酿成...惨剧" nhấn mạnh sự may mắn nhờ tay lái chuẩn xác tránh được tai nạn giao thông thảm khốc.'
      }
    ]
  },
  {
    order_index: 27,
    name: 'Liên từ/Phó từ tương phản đối lập "反之" (Ngược lại / Trái lại)',
    pattern: 'Mệnh đề thuận (nếu A thì B); 反之, Mệnh đề nghịch (nếu không A thì không B)',
    category: 'Phó từ',
    explanation_vi: '"反之" (fǎnzhī) là liên từ hoặc phó từ trang trọng trong văn viết nghị luận triết học, logic và pháp lý, mang nghĩa "nếu xét theo chiều hướng ngược lại thì...". Dùng để đối chiếu hai mặt thuận và nghịch của một quy luật hoặc giả thiết nhân quả.',
    examples: [
      {
        chinese: '坚持规律的作息有助于增强免疫力；反之，长期熬夜则会严重损害身体健康。',
        pinyin: 'Jiānchí guīlǜ de zuòxī yǒuzhùyú zēngqiáng miǎnyìlì; fǎnzhī, chángqī áoyè zé huì yánzhòng sǔnhài shēntǐ jiànkāng.',
        translation_vi: 'Kiên trì sinh hoạt điều độ góp phần tăng cường sức miễn dịch; ngược lại, thức đêm kéo dài sẽ hủy hoại nghiêm trọng sức khỏe thân thể.',
        explanation: '"反之" đứng đầu vế sau để đối chiếu hậu quả tiêu cực của việc thức khuya so với lối sống lành mạnh.'
      },
      {
        chinese: '企业尊重员工的创造力就能激发无限潜能；反之，僵化的管理只会压抑人才的积极性。',
        pinyin: 'Qǐyè zūnzhòng yuángōng de chuàngzàolì jiù néng jīfā wúxiàn qiánnéng; fǎnzhī, jiānghuà de guǎnlǐ zhǐ huì yāyì réncái de jījíxìng.',
        translation_vi: 'Doanh nghiệp tôn trọng sức sáng tạo của nhân viên sẽ khơi dậy tiềm năng vô hạn; ngược lại, cách quản lý xơ cứng chỉ kìm hãm tính tích cực của nhân tài.',
        explanation: '"反之" lập luận sắc sảo về hai phong cách quản trị doanh nghiệp đối nghịch nhau.'
      }
    ]
  },
  {
    order_index: 28,
    name: 'Phó từ tần suất cao lặp đi lặp lại "屡次" (Nhiều lần / Năm lần bảy lượt)',
    pattern: 'Chủ ngữ + 屡次 + Động từ (犯错 / 获奖 / 警告 / 试验 / 申明)',
    category: 'Phó từ',
    explanation_vi: '"屡次" (lǚcì) là phó từ cao cấp biểu thị một hành động hoặc sự việc diễn ra nhiều lần, lặp đi lặp lại (năm lần bảy lượt, lặp lại nhiều đợt). Thường dùng trong văn viết chính thức, có thể dùng cho sự thành công liên tục (屡次获奖) hoặc hành vi tái phạm lỗi cần phê phán (屡次违规).',
    examples: [
      {
        chinese: '该科研团队在极端恶劣的环境下屡次攻克难关，屡次荣获国家科技进步特等奖。',
        pinyin: 'Gāi kēyán tuánduì zài jíduān èliè de huánjìng xià lǚcì gōngkè nánguān, lǚcì rónghuò guójiā kējì jìnbù tèděngjiǎng.',
        translation_vi: 'Nhóm nghiên cứu khoa học này dưới môi trường cực kỳ khắc nghiệt đã nhiều lần vượt qua khó khăn, nhiều lần vinh dự nhận giải đặc biệt Tiến bộ Khoa học Kỹ thuật Quốc gia.',
        explanation: '"屡次攻克难关" tôn vinh sự bền bỉ gặt hái thành tựu lặp lại qua nhiều năm tháng.'
      },
      {
        chinese: '尽管学校老师已经屡次三番进行提醒，他依然未能改正上课迟到的坏毛病。',
        pinyin: 'Jǐnguǎn xuéxiào lǎoshī yǐjīng lǚcìsānfān jìnxíng tíxǐng, tā yīrán wèinéng gǎizhèng shàngkè chídào de huài máobìng.',
        translation_vi: 'Mặc dù thầy cô trong trường đã năm lần bảy lượt nhắc nhở, anh ta vẫn chưa thể sửa được tật xấu đi học muộn.',
        explanation: '"屡次三番" là quán dụng ngữ nhấn mạnh sự cảnh báo lặp đi lặp lại nhiều lần đối với lỗi vi phạm.'
      }
    ]
  }
];
