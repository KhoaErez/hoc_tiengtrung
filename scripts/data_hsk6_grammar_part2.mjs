// ==============================================================================
// DATA: data_hsk6_grammar_part2.mjs
// HSK 6 GRAMMAR - PART 2: ĐIỂM 32 ĐẾN 62 (CHUẨN GF 0025-2021 APPENDIX A)
// Hệ thống Phó từ văn ngôn, Ngữ khí cao cấp, Thời gian, Tần suất & Biểu đạt tu từ HSK 6
// ==============================================================================

export const HSK6_GRAMMAR_PART2 = [
  {
    order_index: 32,
    name: 'Phó từ văn ngôn phủ định nhu cầu "毋须 / 无须" (Không cần thiết / Chẳng cần phải)',
    pattern: 'Chủ ngữ + 毋须 / 无须 + Động từ (多言 / 担忧 / 介意 / 恐慌)',
    category: 'Phó từ',
    explanation_vi: '"毋须" và "无须" (wúxū) là các phó từ văn ngôn tương đương với "不需要" hoặc "不必", mang sắc thái trang nhã, điềm đạm và dứt khoát (không cần thiết phải làm, chẳng cần bận tâm). Thường dùng trong các thông cáo ngoại giao hoặc lời khuyên nhủ học thuật.',
    examples: [
      {
        chinese: '事实真相早已大白于天下，公道自在人心，我们毋须再作多余的无谓辩解。',
        pinyin: 'Shìshí zhēnxiàng zǎoyǐ dàbái yú tiānxià, gōngdào zì zài rénxīn, wǒmen wúxū zài zuò duōyú de wúwèi biànjiě.',
        translation_vi: 'Sự thật chân tướng từ lâu đã sáng tỏ dưới thanh thiên bạch nhật, lẽ công bằng tự ở trong lòng người, chúng ta không cần thiết phải giải thích vô ích thêm thừa thãi nữa.',
        explanation: '"毋须再作多余的辩解" thể hiện phong thái tự tin vững vàng khi sự thật đã rõ ràng mười mươi.'
      },
      {
        chinese: '两国在此领域的合作完全符合国际法规范，外界对此无须产生任何不必要的过度猜忌。',
        pinyin: 'Liǎng guó zài cǐ lǐngyù de hézuò wánquán fúhé guójìfǎ guīfàn, wàijiè duì cǐ wúxū chǎnshēng rènhé bú bìyào de guòdù cāijì.',
        translation_vi: 'Sự hợp tác giữa hai nước trong lĩnh vực này hoàn toàn phù hợp với quy phạm luật pháp quốc tế, bên ngoài đối với điều này chẳng cần nảy sinh bất kỳ sự nghi kỵ thái quá không cần thiết nào.',
        explanation: '"无须产生...猜忌" là phát ngôn ngoại giao chính thức trấn an các đồn đoán thất thiệt.'
      }
    ]
  },
  {
    order_index: 33,
    name: 'Phó từ văn ngôn chỉ mức độ ngạc nhiên và thảng thốt "殊" (Rất / Thật là / Đâu ngờ)',
    pattern: '殊 + Tính từ (殊为不易 / 殊不知 / 殊途同归)',
    category: 'Phó từ',
    explanation_vi: '"殊" (shū) là phó từ văn ngôn mang hai nghĩa chính trong HSK 6: 1) Tương đương với "很, 极" (rất, thật là), như 殊为不易 (thực sự hết sức khó khăn không dễ chút nào); 2) Biểu thị sự bất ngờ hoàn toàn nằm ngoài dự liệu, tương đương với "哪里知道" (nào ngờ đâu, đâu biết rằng), như thành ngữ ngữ pháp hóa "殊不知".',
    examples: [
      {
        chinese: '在完全缺乏现成技术资料的前提下攻克这项世界级难关，其探索过程殊为不易。',
        pinyin: 'Zài wánquán quēfá xiànchéng jìshù zīliào de qiántí xià gōngkè zhè xiàng shìjièjí nánguān, qí tànsuǒ guòchéng shū wéi bùyì.',
        translation_vi: 'Dưới tiền đề hoàn toàn thiếu thốn tài liệu kỹ thuật có sẵn mà chinh phục được ải khó cấp thế giới này, quá trình tìm tòi của nó thực sự vô cùng không dễ dàng chút nào.',
        explanation: '"殊为不易" dùng "殊" làm phó từ mức độ văn ngôn trang trọng cực tả sự gian truân của nhóm nghiên cứu.'
      },
      {
        chinese: '许多人以为熬夜后补觉就能抵消身体损伤，殊不知长期昼夜颠倒会对生物钟造成不可逆的破坏。',
        pinyin: 'Xǔduō rén yǐwéi áoyè hòu bǔjiào jiù néng dǐxiāo shēntǐ sǔnshāng, shūbùzhī chángqī zhòuyèdiāndǎo huì duì shēngwùzhōng zàochéng bùkěnì de pòhuài.',
        translation_vi: 'Nhiều người ngỡ rằng sau khi thức đêm ngủ bù là có thể triệt tiêu tổn thương thể xác, đâu biết rằng việc ngày đêm đảo lộn lâu dài sẽ gây ra sự hủy hoại không thể đảo ngược đối với đồng hồ sinh học.',
        explanation: '"殊不知..." lật mở một chân lý y học đối nghịch với nhận thức sai lầm thông thường của đại chúng.'
      }
    ]
  },
  {
    order_index: 34,
    name: 'Phó từ mức độ văn ngôn cực hạn "甚" (Rất / Quá đỗi / Thậm chí)',
    pattern: '甚 + Tính từ song âm tiết / 甚为 / 甚或 / 欺人太甚 / 甚嚣尘上',
    category: 'Phó từ',
    explanation_vi: '"甚" (shèn) là phó từ văn ngôn tương đương với "很, 非常" (rất, hết sức) hoặc "甚至" (thậm chí). Thường gặp: "甚为" (rất đỗi: 甚为满意, 甚为欣慰), "甚或" (thậm chí hoặc là), "过甚" (quá đáng).',
    examples: [
      {
        chinese: '听到青年科研团队在量子计算领域取得突破性进展的喜报，老院士甚为欣慰。',
        pinyin: 'Tīngdào qīngnián kēyán tuánduì zài liàngzǐ jìsuàn lǐngyù qǔdé tūpòxìng jìnzhǎn de xǐbào, lǎo yuànshì shènwéi xīnwèi.',
        translation_vi: 'Nghe tin vui nhóm nghiên cứu khoa học trẻ đạt được bước tiến đột phá trong lĩnh vực tính toán lượng tử, vị viện sĩ già cảm thấy hết sức ấm lòng mừng rỡ.',
        explanation: '"甚为欣慰" thể hiện sự hài lòng sâu sắc của thế hệ đi trước trước sự trưởng thành của lớp trẻ.'
      },
      {
        chinese: '这种极端自私的行径不仅会伤害身边的朋友，甚或可能触犯国家的刑事法律。',
        pinyin: 'Zhè zhǒng jíduān zìsī de xíngjìng bùjǐn huì shānghài shēnbiān de péngyou, shènhuò kěnéng chùfàn guójiā de xíngshì fǎlǜ.',
        translation_vi: 'Hành vi ích kỷ cực đoan này không chỉ làm tổn thương bạn bè xung quanh, thậm chí hoặc là có thể xúc phạm tới luật pháp hình sự của quốc gia.',
        explanation: '"甚或可能..." tăng tiến mức độ nguy hại từ phạm trù đạo đức cá nhân lên tới lằn ranh vi phạm pháp luật.'
      }
    ]
  },
  {
    order_index: 35,
    name: 'Cụm phó từ mức độ tăng tiến tương phản "尤甚" (Càng dữ dội hơn / Lại càng thậm tệ)',
    pattern: 'Hiện tượng A nghiêm trọng, mà Hiện tượng B + 尤甚',
    category: 'Phó từ',
    explanation_vi: '"尤甚" (yóushèn) kết hợp chữ "尤" (đặc biệt, càng) và "甚" (dữ dội, nghiêm trọng), mang nghĩa "so với các trường hợp khác thì đối tượng này lại càng thêm gay gắt, dữ dội hơn một bậc" (càng thêm thậm tệ, lại càng dữ dội hơn). Thường đứng cuối phân câu thứ hai.',
    examples: [
      {
        chinese: '全球气候异常给发展中国家带来了巨大挑战，而极度干旱贫瘠的非洲内陆地区受灾尤甚。',
        pinyin: 'Quánqiú qìhòu yìcháng gěi fāzhǎnzhōng guójiā dàilái le jùdà tiǎozhàn, ér jídù gānhàn pínjí de Fēizhōu nèilù dìqū shòuzāi yóushèn.',
        translation_vi: 'Khí hậu toàn cầu dị thường đã đem lại thách thức khổng lồ cho các nước đang phát triển, mà vùng nội lục châu Phi khô hạn cằn cỗi cùng cực chịu ảnh hưởng thiên tai lại càng thậm tệ hơn.',
        explanation: '"受灾尤甚" làm nổi bật mức độ tổn thương nặng nề nhất của khu vực dễ bị tổn thương.'
      },
      {
        chinese: '现代都市人普遍面临着失眠焦虑的困扰，而处于高强度竞争中的IT从业人员尤甚。',
        pinyin: 'Xiàndài dūshìrén pǔbiàn miànlínzhe shīmián jiāolǜ de kùnrǎo, ér chǔyú gāoqiángdù jìngzhēng zhōng de IT cóngyè rényuán yóushèn.',
        translation_vi: 'Người dân đô thị hiện đại phổ biến đang đối mặt với nỗi phiền muộn lo âu mất ngủ, mà nhân sự làm nghề công nghệ thông tin trong môi trường cạnh tranh cường độ cao lại càng nặng nề hơn nữa.',
        explanation: '"尤甚" so sánh giữa diện rộng cư dân thành phố với nhóm ngành nghề chịu áp lực đặc thù.'
      }
    ]
  },
  {
    order_index: 36,
    name: 'Phó từ cấm đoán và nguyên tắc thép "断不可" (Quyết không thể / Dứt khoát không được)',
    pattern: '面对... / 在...面前, 断不可 + Động từ (大意 / 妥协 / 姑息 / 违背)',
    category: 'Phó từ',
    explanation_vi: '"断不可" (duànbùkě) là phó từ cấm chỉ văn ngôn đanh thép tương đương với "绝对不能" hoặc "万万不可" (dứt khoát không được, quyết không thể). Dùng trong các huấn thị quân sự, quy chế an toàn hoặc di huấn răn dạy con cháu.',
    examples: [
      {
        chinese: '安全生产重于泰山，在任何细小环节上都断不可抱有丝毫侥幸麻痹心理。',
        pinyin: 'Ānquán shēngchǎn zhòngyú Tàishān, zài rènhé xìxiǎo huánjié shang dōu duànbùkě bàoyǒu sīháo jiǎoxìng mábì xīnlǐ.',
        translation_vi: 'An toàn sản xuất nặng hơn núi Thái Sơn, ở bất kỳ khâu tiểu tiết nào cũng dứt khoát không được ôm giữ mảy may tâm lý cầu may mất cảnh giác.',
        explanation: '"断不可抱有丝毫侥幸心理" là mệnh lệnh kỷ luật an toàn lao động bất di bất dịch.'
      },
      {
        chinese: '做学问当持严谨求实之态度，抄袭剽窃他人成果的学术不端行径断不可为。',
        pinyin: 'Zuò xuéwèn dāng chí yánjǐn qiúshí zhī tàidu, chāoxí piāoqiè tārén chéngguǒ de xuéshù bùduān xíngjìng duànbùkě wéi.',
        translation_vi: 'Làm học vấn phải giữ thái độ cẩn trọng cầu thị, hành vi bất chính học thuật sao chép đạo văn thành quả của người khác dứt khoát không thể làm.',
        explanation: '"断不可为" nghiêm cấm tuyệt đối các hành vi vi phạm đạo đức học thuật.'
      }
    ]
  },
  {
    order_index: 37,
    name: 'Phó từ đặc tả hiển lộ sừng sững đập vào mắt "赫然" (Sừng sững / Đập vào mắt / Nổi bật)',
    pattern: '赫然 + Động từ (矗立 / 出现 / 显露 / 印着 / 映入眼帘)',
    category: 'Phó từ',
    explanation_vi: '"赫然" (hèrán) là phó từ miêu tả thị giác mạnh mẽ, biểu thị một vật thể to lớn, một dòng chữ lớn gây sốc, hoặc một nhân vật uy nghi đột nhiên đập ngay vào mắt người nhìn với khí thế nổi bật, khiến người ta kinh ngạc hoặc giật mình (sừng sững, đập ngay vào mắt).',
    examples: [
      {
        chinese: '转过幽暗的山崖转角，眼前赫然矗立着一座高达数十米的千年古佛石雕。',
        pinyin: 'Zhuǎnguò yōu\'àn de shānyá zhuǎnjiǎo, yǎnqián hèrán chùlìzhe yí zuò gāodá shùshí mǐ de qiānnián gǔfó shídiāo.',
        translation_vi: 'Vòng qua khúc quanh vách núi u ám, trước mắt sừng sững một pho tượng đá cổ nghìn năm cao tới mấy chục mét đập ngay vào tầm mắt.',
        explanation: '"眼前赫然矗立着..." khắc họa cảm giác ngỡ ngàng thán phục khi bất ngờ diện kiến kỳ quan điêu khắc khổng lồ.'
      },
      {
        chinese: '在解密档案的死难者名单头版上，赫然印着他苦苦寻找了半个世纪的父亲的名字。',
        pinyin: 'Zài jiěmì dàng\'àn de sǐnànzhě míngdān tóubǎn shang, hèrán yìnzhe tā kǔkǔ xúnzhǎo le bàn gè shìjì de fùqīn de míngzi.',
        translation_vi: 'Trên trang đầu danh sách người tử nạn trong hồ sơ giải mật, đập ngay vào mắt là dòng chữ in tên người cha mà ông đã khổ công tìm kiếm suốt nửa thế kỷ.',
        explanation: '"赫然印着..." đặc tả cảm xúc bàng hoàng nghẹn ngào khi tìm thấy tên người thân trong tài liệu lịch sử.'
      }
    ]
  },
  {
    order_index: 38,
    name: 'Phó từ mô phỏng phong thái giống hệt "俨然" (Hệt như / Đường hoàng như là / Ra vẻ)',
    pattern: 'Chủ ngữ + 俨然 + (是 / 成了 / 一位) + Danh từ (专家 / 统帅 / 小主人 / 世外桃源)',
    category: 'Phó từ',
    explanation_vi: '"俨然" (yǎnrán) có hai nghĩa chính: 1) Miêu tả phong thái, khí chất hoặc hành vi của một người trông đường hoàng, chững chạc giống hệt như một chức danh hay vai vế nào đó (như 俨然成了一位专家 - ra dáng hệt như một chuyên gia); 2) Miêu tả cảnh sắc đẹp đẽ, trật tự ngay ngắn như bồng lai (như 俨然一座世外桃源).',
    examples: [
      {
        chinese: '年仅十二岁的小选手在棋盘前沉着落子、神态自若，俨然是一位久经沙场的国际特级大师。',
        pinyin: 'Nián jǐn shí\'èr suì de xiǎo xuǎnshǒu zài qípán qián chénzhuó luòzǐ, shéntài zìruò, yǎnrán shì yí wèi jiǔjīngshāchǎng de guójì tèjí dàshī.',
        translation_vi: 'Kỳ thủ nhí mới 12 tuổi ngồi trước bàn cờ điềm tĩnh hạ cờ, thần thái tự tin đĩnh đạc, trông đường hoàng hệt như một đại kiện tướng quốc tế đã trải trăm trận trường kỳ.',
        explanation: '"俨然是一位...大师" ca ngợi bản lĩnh chững chạc vượt tuổi tác của thần đồng cờ vua.'
      },
      {
        chinese: '春雪过后，粉妆玉砌的古城屋檐错落有致，俨然一幅意境悠远的淡雅水墨画。',
        pinyin: 'Chūnxuě zhīhòu, fěnzhuāngyùqì de gǔchéng wūyán cuòluòyǒuzhì, yǎnrán yì fú yìjìng yōuyuǎn de dànyǎ shuǐmòhuà.',
        translation_vi: 'Sau cơn tuyết xuân, những mái ngói thành cổ tráng tuyết ngọc đan xen ngăn nắp, trông hệt như một bức tranh thủy mạc thanh nhã có ý cảnh xa xăm.',
        explanation: '"俨然一幅...水墨画" dùng "俨然" so sánh ví von cảnh sắc thành cổ đẹp như tranh vẽ.'
      }
    ]
  },
  {
    order_index: 39,
    name: 'Phó từ phân định ranh giới rành rọt "截然" (Rành rọt / Hoàn toàn khác biệt / Dứt khoát)',
    pattern: '截然 + Tính từ song âm tiết (截然不同 / 截然相反 / 截然两样 / 截然划分)',
    category: 'Phó từ',
    explanation_vi: '"截然" (jiérán) có gốc từ động từ "截" (cắt đứt, phân chia rõ rệt). Dùng để chỉ hai sự vật, quan điểm hoặc tính cách đối lập nhau một cách tuyệt đối, có ranh giới rành rọt như dùng dao cắt đôi (hoàn toàn khác biệt, rành rọt tách bạch). Hai thành ngữ chuẩn thi cử HSK 6: "截然不同" (hoàn toàn khác nhau) và "截然相反" (hoàn toàn trái ngược nhau).',
    examples: [
      {
        chinese: '对于同一历史人物的历史功过，两位资深历史学家给出了截然相反的学术评价。',
        pinyin: 'Duìyú tóng yí lìshǐ rénwù de lìshǐ gōngguò, liǎng wèi zīshēn lìshǐxuéjiā gěichū le jiérán xiāngfǎn de xuéshù píngjià.',
        translation_vi: 'Đối với công và tội của cùng một nhân vật lịch sử, hai nhà sử học kỳ cựu đã đưa ra những đánh giá học thuật hoàn toàn trái ngược nhau.',
        explanation: '"截然相反的评价" miêu tả sự đối lập 180 độ trong quan điểm phân tích lịch sử.'
      },
      {
        chinese: '这对双胞胎兄弟在成长轨迹上展现出了截然不同的性格特征与职业追求。',
        pinyin: 'Zhè duì shuāngbāotāi xiōngdì zài chéngzhǎng guǐjì shang zhǎnxiàn chū le jiérán bùtóng de xìnggé tèzhēng yǔ zhíyè zhuīqiú.',
        translation_vi: 'Cặp anh em sinh đôi này trên quỹ đạo trưởng thành đã bộc lộ những nét tính cách và định hướng nghề nghiệp hoàn toàn khác biệt nhau.',
        explanation: '"截然不同" phân định ranh giới rành rẽ giữa hai lối đi cuộc đời của cặp song sinh.'
      }
    ]
  },
  {
    order_index: 40,
    name: 'Phó từ kết cục uổng phí cay đắng "枉然" (Uổng công / Hoài công / Vô ích)',
    pattern: 'Nỗ lực không đúng phương pháp, 终归是 / 一切都是 + 枉然 / 徒劳枉然',
    category: 'Phó từ',
    explanation_vi: '"枉然" (wǎngrán) kết hợp chữ "枉" (uổng, oan uổng) và "然", mang nghĩa "mọi công sức, tâm huyết, hy sinh đã bỏ ra cuối cùng hoàn toàn tan biến thành con số không, không thu lại được một kết quả nào (uổng công hoài phí). Mang sắc thái cay đắng, xót xa sâu sắc hơn "徒劳".',
    examples: [
      {
        chinese: '做任何工作如果脱离了实事求是的根本原则，付出再多心血终究也不过是枉然。',
        pinyin: 'Zuò rènhé gōngzuò rúguǒ tuōlí le shíshìqiúshì de gēnběn yuánzé, fùchū zài duō xīnxuè zhōngjiū bùguò shì wǎngrán.',
        translation_vi: 'Làm bất kỳ công việc nào nếu tách rời nguyên tắc căn bản thực sự cầu thị, có bỏ ra bao nhiêu tâm huyết đi chăng nữa rốt cuộc cũng chẳng qua chỉ là hoài công vô ích.',
        explanation: '"终究不过是枉然" cảnh báo cái giá của việc làm trái quy luật khách quan.'
      },
      {
        chinese: '既然对方缺乏最基本的签约诚意，我们此前所作的一切磋商努力均告枉然。',
        pinyin: 'Jìrán duìfāng quēfá zuì jīběn de qiānyuē chéngyì, wǒmen cǐqián suǒ zuò de yíqiè cuōshāng nǔlì jūn gào wǎngrán.',
        translation_vi: 'Đã đối phương thiếu thành ý ký kết cơ bản nhất thì mọi nỗ lực đàm phán mà chúng ta đã bỏ ra trước đó đều xem như uổng công phí sức.',
        explanation: '"均告枉然" là cách nói thương mại ngoại giao đúc kết sự thất bại đáng tiếc của vòng đàm phán.'
      }
    ]
  },
  {
    order_index: 41,
    name: 'Phó từ thời gian vụt tắt cực nhanh "倏忽" (Thoắt cái / Vút qua trong chớp mắt)',
    pattern: '倏忽间, Mệnh đề / 时间 + 倏忽而逝 / 倏忽万里',
    category: 'Phó từ',
    explanation_vi: '"倏忽" (shūhū) là phó từ văn học cổ xưa miêu tả tốc độ trôi đi của thời gian hoặc chuyển động của một vật thể diễn ra nhanh đến mức chỉ như một cái chớp mắt (thoắt cái, vụt qua trong chốc lát). Thường dùng than thở về sự ngắn ngủi của đời người hoặc tuổi xuân.',
    examples: [
      {
        chinese: '回首往昔峥嵘岁月，青春年华倏忽而逝，唯有那份坚守初心的信念历久弥新。',
        pinyin: 'Huíshǒu wǎngxī zhēngróng suìyuè, qīngchūn niánhuá shūhū ér shì, wéiyǒu nà fèn jiānshǒu chūxīn de xìnniàn lìjiǔmíxīn.',
        translation_vi: 'Ngoảnh đầu nhìn lại năm tháng oanh liệt xưa kia, tuổi thanh xuân thoắt cái đã vụt trôi qua, duy chỉ có niềm tin kiên định thuở ban đầu là càng trải qua thời gian lại càng thêm tươi mới.',
        explanation: '"青春年华倏忽而逝" than thở về bước chân thời gian trôi nhanh như tên bắn.'
      },
      {
        chinese: '倏忽间，疾驰的高铁列车已经穿过了连绵起伏的秦岭崇山峻岭。',
        pinyin: 'Shūhū jiān, jíchí de gāotiě lièchē yǐjīng chuānguò le liánmián qǐfú de Qínlǐng chóngshānjùnlǐng.',
        translation_vi: 'Thoắt cái trong chớp mắt, đoàn tàu cao tốc lao vun vút đã vượt qua dãy núi Tần Lĩnh trùng điệp nhấp nhô hiểm trở.',
        explanation: '"倏忽间" đặc tả tốc độ di chuyển thần tốc của phương tiện giao thông hiện đại.'
      }
    ]
  },
  {
    order_index: 42,
    name: 'Phó từ bừng tỉnh bất chợt "蓦然" (Chợt / Bất chợt / Sực nhận ra)',
    pattern: '蓦然 + Động từ (回首 / 发现 / 醒悟 / 惊觉)',
    category: 'Phó từ',
    explanation_vi: '"蓦然" (mòrán) có nguồn gốc từ câu từ cổ điển "蓦然回首，那人却在灯火阑珊处", mang nghĩa bất chợt, đột nhiên trong một khoảnh khắc ngộ ra chân lý hoặc sực nhận thấy một điều kỳ diệu mà bấy lâu nay mình vô tình bỏ quên (bất giác, sực nhớ, chợt nhận ra).',
    examples: [
      {
        chinese: '在异国他乡漫步街头，蓦然听到熟悉的小提琴乡音，他不禁热泪潸然。',
        pinyin: 'Zài yìguó tāxiāng mànbù jiētóu, mòrán tīngdào shúxī de xiǎotíqín xiāngyīn, tā bùjīn rèlèishānrán.',
        translation_vi: 'Dạo bước trên đường phố nơi đất khách quê người, bất chợt nghe thấy âm vang giai điệu quê hương quen thuộc của cây vĩ cầm, anh ấy bất giác rơi nước mắt.',
        explanation: '"蓦然听到..." miêu tả khoảnh khắc xúc động bất ngờ chạm vào nỗi nhớ nhà da diết.'
      },
      {
        chinese: '直到白发悄悄爬上鬓角，他才蓦然醒悟陪伴家人才是生命中最珍贵的幸福。',
        pinyin: 'Zhídào báifà qiāoqiāo páshàng bìnjiǎo, tā cái mòrán xǐngwù péibàn jiārén cái shì shēngmìng zhōng zuì zhēnguì de xìngfú.',
        translation_vi: 'Mãi tới khi tóc bạc lặng lẽ len lỏi lên khóe mai, ông mới bừng tỉnh sực ngộ ra rằng ở bên gia đình mới là niềm hạnh phúc quý báu nhất trong cuộc đời.',
        explanation: '"蓦然醒悟" diễn tả sự giác ngộ triết lý nhân sinh muộn màng nhưng sâu sắc.'
      }
    ]
  },
  {
    order_index: 43,
    name: 'Phó từ biến cố đột ngột ập tới "猝然" (Đột ngột / Bất thình lình ập tới)',
    pattern: '猝然 + Động từ biến cố (发生 / 降临 / 长逝 / 离世 / 发难)',
    category: 'Phó từ',
    explanation_vi: '"猝然" (cùrán) kết hợp chữ "猝" (cù - bất ngờ, không kịp trở tay), chuyên dùng cho các tai họa, cái chết hoặc biến cố bất ngờ ập đến khiến con người hoàn toàn không có sự phòng bị tâm lý (đột ngột qua đời, bất ngờ ập xuống). Thành ngữ cao cấp: "猝然长逝" (đột ngột tạ thế).',
    examples: [
      {
        chinese: '这位德高望重的功勋老科学家在实验岗位上猝然长逝，令全国科技界悲痛万分。',
        pinyin: 'Zhè wèi dégāowàngzhòng de gōngxūn lǎo kēxuéjiā zài shíyàn gǎngwèi shang cùrán chángshì, lìng quánguó kējìjiè bēitòng wànfēn.',
        translation_vi: 'Vị nhà khoa học già có công huân đức cao vọng trọng này đã đột ngột tạ thế ngay trên cương vị nghiên cứu, khiến toàn thể giới khoa học công nghệ cả nước đau buồn khôn xiết.',
        explanation: '"猝然长逝" là thành ngữ trang trọng nhất biểu thị sự ra đi đột ngột cống hiến tới hơi thở cuối cùng.'
      },
      {
        chinese: '面对猝然降临的特大暴雨山洪灾害，当地党委政府紧急启动了一级应急响应机制。',
        pinyin: 'Miànduì cùrán jiànglín de tèdà bàoyǔ shānhóng zāihài, dāngdì dǎngwěi zhèngfǔ jǐnjí qǐdòng le yījí yìngjí xiǎngyìng jīzhì.',
        translation_vi: 'Đối mặt với thảm họa lũ quét mưa bão cực lớn bất thình lình ập xuống, cấp ủy chính quyền địa phương đã khẩn cấp kích hoạt cơ chế ứng phó khẩn cấp cấp độ 1.',
        explanation: '"面对猝然降临的...灾害" phản ánh tính bất ngờ hung hãn của thảm họa thiên nhiên.'
      }
    ]
  },
  {
    order_index: 44,
    name: 'Phó từ quy nạp kết quả tối hậu "终归" (Rốt cuộc thì / Chung quy lại)',
    pattern: 'Chủ ngữ + 终归 + (会 / 是 / 要) + Kết quả quy nạp tất yếu',
    category: 'Phó từ',
    explanation_vi: '"终归" (zhōngguī) là phó từ cao cấp tương đương với "到底" hoặc "终究", mang ý nghĩa sau khi trải qua muôn vàn biến thiên, quanh co khúc khuỷu, sự việc nhất định sẽ quay trở về với bản chất hoặc kết quả tất yếu của nó theo quy luật (chung quy lại, rốt cuộc thì vẫn cứ).',
    examples: [
      {
        chinese: '任何谎言无论编造得多么巧妙，在铁一般的历史事实面前终归是要破产的。',
        pinyin: 'Rènhé huǎngyán wúlùn biānzào de duōme qiǎomiào, zài tiě yībān de lìshǐ shìshí miànqián zhōngguī shì yào pòchǎn de.',
        translation_vi: 'Bất kỳ lời nói dối nào cho dù thêu dệt khéo léo đến đâu, trước sự thật lịch sử vững như sắt thép rốt cuộc thì cũng phải phá sản.',
        explanation: '"终归是要破产的" khẳng định chân lý tất thắng của sự thật trước mọi thủ đoạn lừa dối.'
      },
      {
        chinese: '漂泊在外的游子无论走过多远的风雨路程，其心灵深处的精神根脉终归在故乡。',
        pinyin: 'Piāobó zài wài de yóuzǐ wúlùn zǒuguo duō yuǎn de fēngyǔ lùchéng, qí xīnlíng shēnchù de jīngshén gēnmài zhōngguī zài gùxiāng.',
        translation_vi: 'Người con phiêu bạt bên ngoài bất kể đã đi qua chặng đường mưa gió bao xa, cội rễ tinh thần nơi sâu thẳm tâm hồn rốt cuộc vẫn thuộc về cố hương.',
        explanation: '"终归在故乡" lột tả tình cảm gắn bó thiêng liêng vĩnh cửu của con người với mảnh đất chôn rau cắt rốn.'
      }
    ]
  },
  {
    order_index: 45,
    name: 'Phó từ cảm thán mức độ tột cùng "何其" (Biết bao / Dường nào / Xiết bao)',
    pattern: '何其 + Tính từ song âm tiết (相似 / 艰难 / 幸运 / 壮烈 / 荒谬) !',
    category: 'Phó từ',
    explanation_vi: '"何其" (héqí) là phó từ tu từ cảm thán văn ngôn kết hợp chữ "何" (sao, thế nào) và "其", mang nghĩa "mức độ cao đến nhường nào, biết bao, xiết bao". Thường dùng trong câu cảm thán hoặc nghị luận đanh thép để bộc lộ cảm xúc thán phục, kinh ngạc hoặc phẫn nộ tột độ.',
    examples: [
      {
        chinese: '历史的进程在某些关键转折点上，其内在逻辑表现得何其相似啊！',
        pinyin: 'Lìshǐ de jìnchéng zài mǒuxiē guānjiàn zhuǎnzhédiǎn shang, qí nèizài luójí biǎoxiàn de héqí xiāngsì a!',
        translation_vi: 'Tiến trình lịch sử tại một số bước ngoặt the chốt, logic nội tại của nó thể hiện ra giống nhau đến dường nào!',
        explanation: '"表现得何其相似" cảm thán về quy luật lặp lại kỳ diệu của các bài học lịch sử.'
      },
      {
        chinese: '老一辈革命先烈在风雨如晦的年代开辟救国救民之路，其探索历程何其艰难卓绝！',
        pinyin: 'Lǎoyíbèi gémìng xiānliè zài fēngyǔrúhuì de niándài kāipì jiùguójiùmín zhī lù, qí tànsuǒ lìchéng héqí jiānnánzhuójué!',
        translation_vi: 'Các bậc tiền liệt cách mạng tiền bối vào thời đại gió mưa mịt mù đã mở ra con đường cứu nước cứu dân, chặng đường tìm tòi ấy gian nan khôn xiết biết bao!',
        explanation: '"何其艰难卓绝" ca ngợi tinh thần kiên cường bất khuất vượt qua muôn trùng thử thách của cha ông.'
      }
    ]
  },
  {
    order_index: 46,
    name: 'Cụm liên từ dẫn xuất sự thật xác thực "诚如" (Đúng như / Thật đúng như)',
    pattern: '诚如 + Nhân vật uy tín / Danh ngôn / Lời khẳng định (所言 / 所料 / 大家所见), Mệnh đề',
    category: 'Liên từ',
    explanation_vi: '"诚如" (chéngrú) kết hợp chữ "诚" (chân thực, quả thật) và "如" (như), mang nghĩa "thực tế diễn ra hoàn toàn đúng y như lời nhận định, dự báo hoặc danh ngôn của ai đó" (đúng như đã nói, quả đúng như dự liệu). Dùng để trích dẫn lập luận củng cố uy tín học thuật.',
    examples: [
      {
        chinese: '诚如爱因斯坦所言，想象力远比单纯的知识记忆更加重要，因为它是科学探索的源泉。',
        pinyin: 'Chéngrú Àiyīnsītǎn suǒ yán, xiǎngxiànglì yuǎn bǐ dānchún de zhīshi jìyì gèngjiā zhòngyào, yīnwèi tā shì kēxué tànsuǒ de yuánquán.',
        translation_vi: 'Đúng như Einstein từng nói, trí tưởng tượng còn quan trọng hơn nhiều so với việc ghi nhớ kiến thức đơn thuần, bởi vì nó là suối nguồn của sự tìm tòi khoa học.',
        explanation: '"诚如...所言" trích dẫn lời vĩ nhân để nâng cao sức nặng luận điểm cho bài viết.'
      },
      {
        chinese: '诚如专家们此前所料，这项重大金融改革举措的出台极大稳定了市场信心。',
        pinyin: 'Chéngrú zhuānjiāmen cǐqián suǒ liào, zhè xiàng zhòngdà jīnróng gǎigé jǔcuò de chūtái jídà wěndìng le shìchǎng xìnxīn.',
        translation_vi: 'Đúng như các chuyên gia đã dự liệu trước đó, việc ban hành biện pháp cải cách tài chính trọng đại này đã làm ổn định mạnh mẽ niềm tin thị trường.',
        explanation: '"诚如...所料" khẳng định sự chuẩn xác trong công tác dự báo kinh tế của giới học giả.'
      }
    ]
  },
  {
    order_index: 47,
    name: 'Động từ/Phó từ tỉ dụ thi ca tráng lệ "宛如" (Ví tựa như / Giống hệt như)',
    pattern: 'Chủ ngữ + 宛如 + Cảnh tượng/Hình ảnh thi ca hoa lệ',
    category: 'Phó từ',
    explanation_vi: '"宛如" (wǎnrú) là từ tỉ dụ so sánh mang phẩm cách thi ca trang nhã bậc nhất trong HSK 6, tương đương với "好似" hoặc "仿佛", nhưng thường đi liền với những bức tranh phong cảnh thiên nhiên tráng lệ hoặc hình tượng nghệ thuật lung linh kỳ vĩ (ví tựa như, dường như).',
    examples: [
      {
        chinese: '夜晚从空中俯瞰维多利亚港，两岸璀璨绚丽的万家灯火宛如银河跌落人间。',
        pinyin: 'Yèwǎn cóng kōngzhōng fǔkàn Wéiduōlìyǎ Gǎng, liǎng\'àn cuǐcàn xuànlì de wànjiādēnghuǒ wǎnrú yínhé diēluò rénjiān.',
        translation_vi: 'Ban đêm từ trên không trung nhìn xuống cảng Victoria, muôn ánh đèn lung linh rực rỡ hai bên bờ ví tựa dải Ngân Hà rơi xuống cõi nhân gian.',
        explanation: '"宛如银河跌落人间" là câu văn so sánh tuyệt mỹ miêu tả cảnh đêm bến cảng phồn hoa.'
      },
      {
        chinese: '大漠深处的月牙泉宛如一颗镶嵌在金黄色沙海中的璀璨绿宝石，神奇而静谧。',
        pinyin: 'Dàmò shēnchù de Yuèyáquán wǎnrú yì kē xiāngqiàn zài jīnhuángsè shāhǎi zhōng de cuǐcàn lǜbǎoshí, shénqí ér jìngmì.',
        translation_vi: 'Suối Nguyệt Nha nơi sâu thẳm chốn sa mạc ví tựa như một viên ngọc bích rực rỡ khảm vào giữa biển cát vàng óng ả, kỳ diệu và tĩnh mịch.',
        explanation: '"宛如一颗...绿宝石" khắc họa vẻ đẹp độc nhất vô nhị của ốc đảo sa mạc.'
      }
    ]
  },
  {
    order_index: 48,
    name: 'Động từ/Phó từ so sánh tương đồng khách quan "犹如" (Tựa như / Dường như)',
    pattern: 'Chủ ngữ + 犹如 + Biểu tượng so sánh sâu sắc',
    category: 'Phó từ',
    explanation_vi: '"犹如" (yóurú) có nguồn gốc văn ngôn tương tự "宛如", nhưng thiên về việc so sánh giữa các hiện tượng triết học, ý niệm trừu tượng với các quy luật tự nhiên (tựa như, giống như). Thường dùng trong văn phong nghị luận sâu lắng.',
    examples: [
      {
        chinese: '一位杰出的思想导师犹如黑夜航行中的明亮灯塔，指引着学子们迷茫的心灵。',
        pinyin: 'Yí wèi jiéchū de sīxiǎng dǎoshī yóurú hēiyè hángxíng zhōng de míngliàng dēngtǎ, zhǐyǐnzhe xuézǐmen mímáng de xīnlíng.',
        translation_vi: 'Một người thầy tư tưởng kiệt xuất tựa như ngọn hải đăng sáng rực trong đêm đen hải trình, dẫn lối cho tâm hồn đang hoang mang của các học trò.',
        explanation: '"犹如...明亮灯塔" ví người thầy với ngọn hải đăng soi sáng con đường tri thức.'
      },
      {
        chinese: '逆水行舟用力撑，一篙松劲退千寻，学业的追求犹如逆水行舟，不进则退。',
        pinyin: 'Nìshuǐ xíng zhōu yònglì chēng, yì gāo sōngjìn tuì qiānxún, xuéyè de zhuīqiú yóurú nìshuǐxíngzhōu, bújìnzétuì.',
        translation_vi: 'Chèo thuyền ngược dòng phải dốc sức chống, lơi tay một sào ắt lùi ngàn tầm, sự theo đuổi học nghiệp tựa như chèo thuyền ngược nước, không tiến ắt lùi.',
        explanation: '"犹如逆水行舟" trích dẫn thành ngữ kinh điển răn dạy sự khổ học không được buông lỏng.'
      }
    ]
  },
  {
    order_index: 49,
    name: 'Liên từ lựa chọn văn ngôn thà rằng "毋宁" (Thà rằng / Chi bằng / Đúng hơn là)',
    pattern: '与其 A, 毋宁 B (B mới là sự lựa chọn hoặc định nghĩa chuẩn xác)',
    category: 'Liên từ',
    explanation_vi: '"毋宁" (wúnìng) là liên từ văn ngôn cổ kính tương đương với "不如" hoặc "宁肯", biểu thị thái độ thà rằng chọn phương án B còn hơn phương án A, hoặc khẳng định cách gọi B mới phản ánh đúng chân lý hơn (chi bằng, thà rằng, đúng hơn là). Thường kết hợp với "与其".',
    examples: [
      {
        chinese: '与其苟且偷生而出卖自己的人格尊严，毋宁为了捍卫正义而英勇就义。',
        pinyin: 'Yǔqí gǒuqiětōushēng ér chūmài zìjǐ de réngé zūnyán, wúnìng wèile hànwèi zhèngyì ér yīngyǒngjiùyì.',
        translation_vi: 'Thay vì sống tạm bợ hèn nhát mà bán rẻ phẩm giá nhân cách của bản thân, thà rằng anh dũng hy sinh vì sự nghiệp bảo vệ chính nghĩa.',
        explanation: '"与其...毋宁..." thể hiện khí tiết trung liệt cao cả thà chết vinh còn hơn sống nhục.'
      },
      {
        chinese: '这项重大的科学发现与其说是个人智慧的灵光一现，毋宁说是无数前人垫脚石堆叠的必然产物。',
        pinyin: 'Zhè xiàng zhòngdà de kēxué fāxiàn yǔqí shuō shì gèrén zhìhuì de língguāngyíxiàn, wúnìng shuō shì wúshù qiánrén diànjiǎoshí duīdié de bìrán chǎnwù.',
        translation_vi: 'Phát hiện khoa học trọng đại này thay vì nói là sự lóe sáng của trí tuệ cá nhân, đúng hơn nên nói là sản vật tất yếu được đắp bồi từ những hòn đá lót đường của vô số tiền nhân đi trước.',
        explanation: '"毋宁说是..." khiêm tốn ghi nhận công lao tích lũy của nhiều thế hệ khoa học tiền bối.'
      }
    ]
  },
  {
    order_index: 50,
    name: 'Cụm phó từ khẳng định không thể tranh cãi "不容置疑" (Không được phép hoài nghi)',
    pattern: 'Chủ quyền / Sự thật / Nguyên tắc + 是不容置疑的',
    category: 'Cấu trúc cố định',
    explanation_vi: '"不容置疑" (bùróng zhìyí) kết hợp chữ 不容 (không cho phép) và 置疑 (đặt câu hỏi hoài nghi), biểu thị một sự thật, một nguyên tắc hoặc chủ quyền thiêng liêng tuyệt đối không cho phép bất kỳ ai được nghi ngờ, xuyên tạc hay bàn cãi (hoàn toàn không được phép nghi ngờ). Thường dùng trong tuyên ngôn ngoại giao quốc gia.',
    examples: [
      {
        chinese: '中国对包括钓鱼岛及其附属岛屿在内的领土拥有无可争辩的主权，这是不容置疑的历史事实。',
        pinyin: 'Zhōngguó duì bāokuò Diàoyúdǎo jí qí fùshǔ dǎoyǔ zài nèi de lǐngtǔ yōngyǒu wúkězhēngbiàn de zhǔquán, zhè shì bùróngzhìyí de lìshǐ shìshí.',
        translation_vi: 'Trung Quốc có chủ quyền không thể tranh cãi đối với lãnh thổ bao gồm đảo Điếu Ngư cùng các đảo phụ cận, đây là sự thật lịch sử không cho phép hoài nghi.',
        explanation: '"是不容置疑的历史事实" khẳng định lập trường chủ quyền quốc gia vững như bàn thạch.'
      },
      {
        chinese: '法律面前人人平等是现代法治文明的基本准则，任何特权阶层的存在都是不容置疑的违法行为。',
        pinyin: 'Fǎlǜ miànqián rénrén píngděng shì xiàndài fǎzhì wénmíng de jīběn zhǔnzé, rènhé tèquán jiēcéng de cúnzài dōu shì bùróngzhìyí de wéifǎ xíngwéi.',
        translation_vi: 'Mọi người đều bình đẳng trước pháp luật là chuẩn tắc cơ bản của văn minh pháp quyền hiện đại, sự tồn tại của bất kỳ tầng lớp đặc quyền nào đều là hành vi vi phạm pháp luật không thể bàn cãi.',
        explanation: '"是不容置疑的..." bảo vệ nguyên tắc công bằng tư pháp tối thượng.'
      }
    ]
  },
  {
    order_index: 51,
    name: 'Cụm phó từ cảnh báo không thể xem nhẹ "不容忽视" (Không được phép xem nhẹ / Bỏ qua)',
    pattern: 'Vấn đề / Nguy cơ tiềm ẩn / Tác dụng + 是不容忽视的',
    category: 'Cấu trúc cố định',
    explanation_vi: '"不容忽视" (bùróng hūshì) biểu thị một hiện tượng, một nguy cơ tiềm ẩn hoặc tác động tiêu cực có tầm vóc vô cùng nghiêm trọng, bắt buộc toàn xã hội phải cảnh giác cao độ và nghiêm túc xử lý, tuyệt đối không được lơ là xem nhẹ (không thể xem thường).',
    examples: [
      {
        chinese: '电子产品的过度使用对少年儿童视力健康造成的长期负面影响，是绝对不容忽视的。',
        pinyin: 'Diànzǐ chǎnpǐn de guòdù shǐyòng duì shàonián értóng shìlì jiànkāng zàochéng de chángqī fùmiàn yǐngxiǎng, shì juéduì bùróng hūshì de.',
        translation_vi: 'Tác động tiêu cực dài hạn của việc lạm dụng thiết bị điện tử đối với sức khỏe thị lực của trẻ em và thanh thiếu niên là điều tuyệt đối không được phép xem nhẹ.',
        explanation: '"是不容忽视的" gióng lên hồi chuông cảnh báo tới các bậc phụ huynh và nhà trường.'
      },
      {
        chinese: '中小企业在吸纳社会劳动力就业和激发市场创新活力方面所起的独特作用，不容忽视。',
        pinyin: 'Zhōngxiǎo qǐyè zài xīnà shèhuì láodònglì jiùyè hé jīfā shìchǎng chuàngxīn huólì fāngmiàn suǒ qǐ de dútè zuòyòng, bùróng hūshì.',
        translation_vi: 'Tác dụng độc đáo của các doanh nghiệp vừa và nhỏ trong việc thu hút việc làm cho lực lượng lao động xã hội và khơi dậy sức sống sáng tạo thị trường là điều không thể xem thường.',
        explanation: '"不容忽视" khẳng định vị thế xương sống của khối doanh nghiệp vừa và nhỏ trong nền kinh tế.'
      }
    ]
  },
  {
    order_index: 52,
    name: 'Cấu trúc quy luật hành động bắt buộc "势在必行" (Thế tất phải làm / Bắt buộc phải tiến hành)',
    pattern: 'Việc cải cách/xử lý vấn đề + 势在必行',
    category: 'Cấu trúc cố định',
    explanation_vi: '"势在必行" (shì zài bì xíng) kết hợp chữ 势 (xu thế), 必 (tất yếu) và 行 (hành động), biểu thị một cuộc cải cách, chuyển đổi thể chế hoặc giải pháp cấp bách đã chín muồi về mặt xu thế khách quan, bắt buộc phải tiến hành thực hiện ngay lập tức chứ không thể trì hoãn thêm (thế tất phải làm, việc không thể không làm).',
    examples: [
      {
        chinese: '面对严峻的能源危机与环境保护重任，加快推进传统工业的绿色低碳改造势在必行。',
        pinyin: 'Miànduì yánjùn de néngyuán wēijī yǔ huánjìng bǎohù zhòngrèn, jiākuài tuījìn chuántǒng gōngyè de lǜsè dītàn gǎizào shìzàibìxíng.',
        translation_vi: 'Đối mặt với cuộc khủng hoảng năng lượng ngặt nghèo và trọng trách bảo vệ môi trường, việc đẩy nhanh thúc đẩy cải tạo xanh giảm thiểu carbon đối với công nghiệp truyền thống là điều thế tất phải làm.',
        explanation: '"势在必行" khẳng định tính cấp bách không thể đảo ngược của chiến lược chuyển đổi năng lượng xanh.'
      },
      {
        chinese: '为了破除阻碍科技成果转化的体制机制障碍，新一轮深化科研评价制度改革势在必行。',
        pinyin: 'Wèile pòchú zǔ\'ài kējì chéngguǒ zhuǎnhuà de tǐzhì jīzhì zhàng\'ài, xīn yì lún shēnhuà kēyán píngjià zhìdù gǎigé shìzàibìxíng.',
        translation_vi: 'Để xóa bỏ các rào cản thể chế cơ chế cản trở việc chuyển hóa thành quả khoa học công nghệ, đợt cải cách sâu rộng chế độ đánh giá nghiên cứu khoa học mới là điều bắt buộc phải tiến hành.',
        explanation: '"改革势在必行" thể hiện quyết tâm chính trị mạnh mẽ tháo gỡ điểm nghẽn cho giới nghiên cứu.'
      }
    ]
  },
  {
    order_index: 53,
    name: 'Cấu trúc tình thế nguy cấp sát sườn "迫在眉睫" (Cấp bách trước mắt / Nước sôi lửa bỏng)',
    pattern: 'Nhiệm vụ / Hiểm họa / Vấn đề + 迫在眉睫',
    category: 'Cấu trúc cố định',
    explanation_vi: '"迫在眉睫" (pò zài méijié) là thành ngữ ngữ pháp hóa miêu tả tình huống khẩn cấp đến mức lửa cháy sát tới tận lông mày và lông mi (gần ngay trước mắt, ngàn cân treo sợi tóc, vô cùng cấp bách).',
    examples: [
      {
        chinese: '洪水即将漫过堤坝，紧急转移低洼地带数万被困群众的任务迫在眉睫。',
        pinyin: 'Hóngshuǐ jíjiāng mànguò dībà, jǐnjí zhuǎnyí dīwā dìdài shù wàn bèikùn qúnzhòng de rènwu pòzàiméijié.',
        translation_vi: 'Nước lũ sắp sửa tràn qua mặt đê, nhiệm vụ khẩn cấp sơ tán hàng vạn quần chúng đang mắc kẹt ở vùng trũng thấp đang cấp bách trước mắt.',
        explanation: '"任务迫在眉睫" đặc tả tính chất sinh tử của nhiệm vụ sơ tán lũ lụt từng giây từng phút.'
      },
      {
        chinese: '全球生物多样性急剧衰退的危机迫在眉睫，国际社会必须立即采取联合拯救行动。',
        pinyin: 'Quánqiú shēngwù duōyàngxìng jíjù shuāituì de wēijī pòzàiméijié, guójì shèhuì bìxū lìjí cǎiqǔ liánhé zhěngjiù xíngdòng.',
        translation_vi: 'Cuộc khủng hoảng suy thoái nghiêm trọng của đa dạng sinh học toàn cầu đang cấp bách ngay trước mắt, cộng đồng quốc tế bắt buộc phải hành động giải cứu phối hợp ngay tức thì.',
        explanation: '"危机迫在眉睫" thôi thúc toàn cầu chung tay ngăn chặn thảm họa tuyệt chủng sinh vật.'
      }
    ]
  },
  {
    order_index: 54,
    name: 'Cấu trúc trọng lượng chi phối cán cân cục diện "举足轻重" (Có sức nặng quyết định / Cân bằng cục diện)',
    pattern: 'Chủ ngữ + 在...中起着 / 占据着 + 举足轻重的地位 / 作用',
    category: 'Cấu trúc cố định',
    explanation_vi: '"举足轻重" (jǔzúqīngzhòng) có nguồn gốc từ binh thư cổ đại: mỗi bước chân di chuyển của một thế lực đều làm lệch cán cân sức mạnh của toàn cuộc diện. Dùng để chỉ một nhân vật, quốc gia hoặc ngành công nghiệp có vai trò rường cột, mang tính quyết định chi phối đại cục (giữ vị trí then chốt, nhất cử nhất động làm rung chuyển cục diện).',
    examples: [
      {
        chinese: '芯片制造业作为现代数字经济的心脏，在全球高科技产业链中具有举足轻重的战略地位。',
        pinyin: 'Xīnpiàn zhìzàoyè zuòwéi xiàndài shùzì jīngjì de xīnzàng, zài quánqiú gāo kējì chǎnyèliàn zhōng jùyǒu jǔzúqīngzhòng de zhànlüè dìwèi.',
        translation_vi: 'Ngành sản xuất chip bán dẫn với tư cách là trái tim của nền kinh tế số hiện đại có vị thế chiến lược mang tính quyết định chi phối trong chuỗi ngành công nghệ cao toàn cầu.',
        explanation: '"具有举足轻重的战略地位" làm rõ vai trò yết hầu của vi mạch điện tử trong thế giới hiện đại.'
      },
      {
        chinese: '他在该跨国并购案中凭借深厚的法律造诣和谈判技巧，起到了举足轻重的关键推动作用。',
        pinyin: 'Tā zài gāi kuàguó bìnggòu\'àn zhōng píngjiè shēnhòu de fǎlǜ zàoyì hé tánpàn jìqiǎo, qǐdào le jǔzúqīngzhòng de guānjiàn tuīdòng zuòyòng.',
        translation_vi: 'Anh ấy trong thương vụ sáp nhập xuyên quốc gia này nhờ vào học vấn pháp lý thâm sâu và kỹ năng đàm phán đã đóng vai trò then chốt có sức nặng quyết định thúc đẩy thành công.',
        explanation: '"起到了举足轻重的作用" ca ngợi tài năng đàm phán xoay chuyển cục diện của luật sư trưởng.'
      }
    ]
  },
  {
    order_index: 55,
    name: 'Cấu trúc liên hệ hữu cơ sống còn "息息相关" (Liên quan mật thiết / Hơi thở liền kề)',
    pattern: 'A 与 / 和 B + 息息相关 (như hơi thở gắn liền sự sống)',
    category: 'Cấu trúc cố định',
    explanation_vi: '"息息相关" (xīxī xiāngguān) kết hợp chữ "息" (hơi thở), biểu thị hai sự vật gắn bó chặt chẽ với nhau tới mức từng nhịp thở đều hòa làm một, lợi hại tương quan mật thiết không thể tách rời (liên quan mật thiết, gắn bó máu thịt).',
    examples: [
      {
        chinese: '物价稳定和食品安全直接关系到千家万户的切身福祉，与人民群众的幸福感息息相关。',
        pinyin: 'Wùjià wěndìng hé shípǐn ānquán zhíjiē guānxì dào qiānjiāwànhù de qiēshēn fúzhǐ, yǔ rénmín qúnzhòng de xìngfúgǎn xīxīxiāngguān.',
        translation_vi: 'Giá cả ổn định và an toàn thực phẩm liên quan trực tiếp tới phúc lợi thiết thân của hàng vạn gia đình, gắn bó mật thiết tới cảm giác hạnh phúc của quần chúng nhân dân.',
        explanation: '"与...幸福感息息相关" nêu rõ mối quan hệ khăng khít giữa kinh tế đời sống và chỉ số hạnh phúc xã hội.'
      },
      {
        chinese: '生态环境质量的好坏，与整个人类社会未来的可持续繁衍息息相关。',
        pinyin: 'Shēngtài huánjìng zhìliàng de hǎohuài, yǔ zhěng gè rénlèi shèhuì wèilái de kěchíxù fányǎn xīxīxiāngguān.',
        translation_vi: 'Chất lượng môi trường sinh thái tốt hay xấu gắn bó mật thiết với sự sinh sôi phát triển bền vững tương lai của toàn bộ xã hội loài người.',
        explanation: '"与...繁衍息息相关" liên kết sự bảo vệ tự nhiên với tương lai tồn vong của giống nòi nhân loại.'
      }
    ]
  },
  {
    order_index: 56,
    name: 'Cấu trúc chia ngọt sẻ bùi đồng cam cộng khổ "休戚与共" (Cùng chung chia sẻ buồn vui / Hoạn nạn có nhau)',
    pattern: 'A 与 B + 形成 / 建设 + 休戚与共的命运共同体',
    category: 'Cấu trúc cố định',
    explanation_vi: '"休戚与共" (xiūqī yǔgòng) kết hợp chữ "休" (điều mừng, hoan lạc) và "戚" (nỗi buồn, hoạn nạn), mang ý nghĩa cùng nhau chia sẻ mọi niềm vui lẫn nỗi buồn, kề vai sát cánh sống chết có nhau trong cùng một vận mệnh (đồng cam cộng khổ, hoạn nạn chia bùi). Mẫu câu chuẩn mực xây dựng "Cộng đồng chung vận mệnh nhân loại".',
    examples: [
      {
        chinese: '在这个全球深度互联的信息时代，世界各国同乘一条大船，早已结成了休戚与共的命运共同体。',
        pinyin: 'Zài zhè ge quánqiú shēndù hùlián de xìnxī shídài, shìjiè gèguó tóng chéng yì tiáo dàchuán, zǎoyǐ jiéchéng le xiūqīyǔgòng de mìngyùn gòngtóngtǐ.',
        translation_vi: 'Trong thời đại thông tin kết nối sâu sắc toàn cầu này, các quốc gia trên thế giới cùng ngồi chung một con thuyền lớn, từ lâu đã kết thành một cộng đồng chung vận mệnh đồng cam cộng khổ.',
        explanation: '"休戚与共的命运共同体" là khẩu hiệu ngoại giao toàn cầu thể hiện tính tương trợ quốc tế.'
      },
      {
        chinese: '军民休戚与共、生死相依的光荣传统，是我们战胜一切艰难险阻的最坚固长城。',
        pinyin: 'Jūnmín xiūqīyǔgòng, shēngsǐxiāngyī de guāngróng chuántǒng, shì wǒmen zhànshèng yíqiè jiānnánxiǎnzǔ de zuì jiāngù chángchéng.',
        translation_vi: 'Truyền thống vẻ vang quân dân đồng cam cộng khổ, sống chết có nhau chính là bức Vạn Lý Trường Thành vững chắc nhất giúp chúng ta chiến thắng mọi gian nan hiểm trở.',
        explanation: '"军民休戚与共" ca ngợi tình cảm gắn bó keo sơn như cá với nước giữa quân đội và nhân dân.'
      }
    ]
  },
  {
    order_index: 57,
    name: 'Cấu trúc cố định tổng kết văn kiện chính thức: "综上所述"',
    pattern: 'Phân tích các luận điểm chi tiết. 综上所述, Kết luận quy nạp toàn diện',
    category: 'Cấu trúc cố định',
    explanation_vi: '"综上所述" (zōng shàng suǒ shù) kết hợp chữ 综 (tổng hợp), 上 (ở trên), 所述 (những điều đã trình bày), mang nghĩa "tổng hợp lại toàn bộ những sự thật, số liệu và lập luận đã được nêu ra ở các đoạn trên". Là từ mở màn đoạn kết chuẩn mực tuyệt đối trong luận án tiến sĩ, báo cáo kiểm toán và bản cáo trạng tòa án.',
    examples: [
      {
        chinese: '综上所述，该研发项目不仅技术路径完全可行，而且预期经济效益显著，建议董事会立即批准立项。',
        pinyin: 'Zōngshàngsuǒshù, gāi yánfā xiàngmù bùjǐn jìshù lùjìng wánquán kěxíng, érqiě yùqī jīngjì xiàoyì xiǎnzhù, jiànyì dǒngshìhuì lìjí pīzhǔn lìxiàng.',
        translation_vi: 'Tổng hợp những điều đã trình bày ở trên, dự án nghiên cứu phát triển này không chỉ có lộ trình công nghệ hoàn toàn khả thi, mà hiệu quả kinh tế kỳ vọng lại hết sức rõ rệt, kiến nghị hội đồng quản trị lập tức phê chuẩn khởi động dự án.',
        explanation: '"综上所述..." đúc kết thẩm định dự án thuyết phục đưa ra kiến nghị quyết sách đầu tư.'
      },
      {
        chinese: '综上所述，原告提交的各项证据确凿充分，被告侵犯商业机密的事实清楚，应当承担全部民事赔偿责任。',
        pinyin: 'Zōngshàngsuǒshù, yuángào tíjiāo de gè xiàng zhèngjù quèzáo chōngfèn, bèigào qīnfàn shāngyè jīmì de shìshí qīngchu, yīngdāng chéngdān quánbù mínshì péicháng zérèn.',
        translation_vi: 'Tổng hợp lại những điều đã trình bày ở trên, các bằng chứng mà nguyên đơn nộp lên là xác thực đầy đủ, sự thật bị đơn xâm phạm bí mật thương mại là rõ ràng, phải chịu toàn bộ trách nhiệm bồi thường dân sự.',
        explanation: '"综上所述..." là lời luận tội và lập luận kết án mẫu mực của luật sư trong phiên tòa dân sự.'
      }
    ]
  },
  {
    order_index: 58,
    name: 'Cấu trúc cố định dẫn chiếu tài liệu đính kèm: "详见附录 / 详见下文"',
    pattern: 'Khái quát ngắn gọn (详见附录 A / 具体技术参数详见下文表格)',
    category: 'Cấu trúc cố định',
    explanation_vi: '"详见" (xiángjiàn) kết hợp chữ "详" (chi tiết, tường tận) và "见" (xem, tra cứu), dùng trong các văn bản học thuật khoa học, tài liệu kỹ thuật hoặc phụ lục hợp đồng để hướng dẫn người đọc tra cứu bảng biểu dữ liệu chi tiết (xem chi tiết tại phụ lục / xem cụ thể ở phần văn bản bên dưới).',
    examples: [
      {
        chinese: '关于本次实验的具体化学试剂配比及安全操作细则，详见本报告附录三。',
        pinyin: 'Guānyú běn cì shíyàn de jùtǐ huàxué shìjì pèibǐ jí ānquán cāozuò xìzé, xiángjiàn běn bàogào fùlù sān.',
        translation_vi: 'Về tỷ lệ pha chế hóa chất cụ thể và quy tắc thao tác an toàn của thí nghiệm lần này, xem chi tiết tại Phụ lục 3 của báo cáo này.',
        explanation: '"详见本报告附录三" chỉ dẫn nguồn dữ liệu kỹ thuật chuẩn xác trong văn bản khoa học.'
      },
      {
        chinese: '各类参赛作品的投稿规格要求及评奖评分细则，详见大赛官方网站下文通告。',
        pinyin: 'Gèlèi cànsài zuòpǐn de tóugǎo guīgé yāoqiú jí píngjiǎng píngfēn xìzé, xiángjiàn dàsài guānfāng wǎngzhàn xiàwén tōnggào.',
        translation_vi: 'Yêu cầu quy chuẩn gửi bài dự thi của các thể loại tác phẩm cùng chi tiết chấm điểm trao giải, xin xem chi tiết thông báo bên dưới trên trang web chính thức của cuộc thi.',
        explanation: '"详见...下文通告" hướng dẫn thí sinh theo dõi chi tiết thể lệ cuộc thi.'
      }
    ]
  },
  {
    order_index: 59,
    name: 'Cấu trúc văn ngôn đúc kết bài học lịch sử "鉴往知来" (Soi xét quá khứ thấu hiểu tương lai)',
    pattern: '鉴往知来, Chủ ngữ + Cần phải tổng kết kinh nghiệm lịch sử',
    category: 'Cấu trúc cố định',
    explanation_vi: '"鉴往知来" (jiàn wǎng zhī lái) kết hợp chữ 鉴 (soi gương, xem xét), 往 (quá khứ), 知 (biết), 来 (tương lai), mang ý nghĩa lấy lịch sử quá khứ làm tấm gương soi chiếu để rút ra bài học kinh nghiệm dẫn đường cho tương lai (ôn nghèo nhớ khổ, soi xưa đoán nay). Thường dùng trong các thông điệp giáo dục truyền thống.',
    examples: [
      {
        chinese: '历史是最好的教科书，我们只有鉴往知来，才能在复兴的新征程上行稳致远。',
        pinyin: 'Lìshǐ shì zuì hǎo de jiàokēshū, wǒmen zhǐyǒu jiànwǎngzhīlái, cái néng zài fùxīng de xīn zhēngchéng shang xíngwěnzhìyuǎn.',
        translation_vi: 'Lịch sử là cuốn sách giáo khoa tốt nhất, chúng ta chỉ khi biết soi xét quá khứ để định hướng tương lai thì mới có thể vững bước tiến xa trên chặng đường phục hưng mới.',
        explanation: '"鉴往知来，行稳致远" là cặp đối ngữ chính luận lịch sử kinh điển định hướng cho tương lai.'
      },
      {
        chinese: '回顾人类历次公共卫生危机的演变规律，鉴往知来，对于完善当代全球疾病防控体系具有重大启示。',
        pinyin: 'Huígù rénlèi lìcì gōnggòng wèishēng wēijī de yǎnbiàn guīlǜ, jiànwǎngzhīlái, duìyú wánshàn dāngdài quánqiú jíbìng fángkòng tǐxì jùyǒu zhòngdà qǐshì.',
        translation_vi: 'Nhìn lại quy luật diễn biến của các cuộc khủng hoảng y tế công cộng qua các thời kỳ của nhân loại, soi xét quá khứ để hiểu tương lai có gợi mở to lớn đối với việc hoàn thiện hệ thống phòng chống dịch bệnh toàn cầu đương đại.',
        explanation: '"鉴往知来" đúc kết bài học dịch tễ học lịch sử để ứng phó với đại dịch tương lai.'
      }
    ]
  },
  {
    order_index: 60,
    name: 'Cấu trúc cố định trạng thái chờ hoàn thiện: "有待于"',
    pattern: 'Vấn đề phức tạp + 尚 / 仍 + 有待于 + Động từ song âm tiết (解决 / 验证 / 考证 / 澄清 / 完善)',
    category: 'Cấu trúc cố định',
    explanation_vi: '"有待于" (yǒudàiyú) kết hợp chữ 有待 (còn chờ đợi, còn cần phải) và 于 (đối với), mang nghĩa một vấn đề học thuật hoặc vướng mắc xã hội hiện tại vẫn chưa hoàn tất, còn cần phải tiếp tục nghiên cứu, thẩm định hoặc nỗ lực giải quyết thêm trong tương lai (còn cần phải, vẫn còn đợi). Thường đi kèm với phó từ "尚" hoặc "仍".',
    examples: [
      {
        chinese: '尽管初步临床试验展现出了良好效果，但该药品的长期安全性仍有待于更大样本的跟踪验证。',
        pinyin: 'Jǐnguǎn chūbù línchuáng shìyàn zhǎnxiàn chū le liánghǎo xiàoguǒ, dàn gāi yàopǐn de chángqī ānquánxìng réng yǒudàiyú gèng dà yàngběn de gēnzōng yànzhèng.',
        translation_vi: 'Tuy rằng thử nghiệm lâm sàng bước đầu đã bộc lộ hiệu quả khả quan, nhưng độ an toàn lâu dài của dược phẩm này vẫn còn cần phải theo dõi xác chứng với quy mô mẫu lớn hơn.',
        explanation: '"仍有待于...跟踪验证" thể hiện đạo đức khoa học thận trọng nghiêm ngặt của ngành y dược.'
      },
      {
        chinese: '出土竹简中记录的这几条古老律法条文的确切含义，学术界尚有待于进一步深入考证。',
        pinyin: 'Chūtǔ zhújiǎn zhōng jìlù de zhè jǐ tiáo gǔlǎo lǜfǎ tiáowén de quèqiè hányì, xuéshùjiè shàng yǒudàiyú jìnyíbù shēnrù kǎozhèng.',
        translation_vi: 'Ý nghĩa chuẩn xác của mấy điều khoản luật pháp cổ xưa ghi trên thẻ tre khai quật được, giới học thuật vẫn còn phải chờ đợi sự khảo cứu sâu hơn nữa.',
        explanation: '"尚有待于进一步考证" xác lập tính mở trong công tác nghiên cứu khảo cổ học.'
      }
    ]
  },
  {
    order_index: 61,
    name: 'Cấu trúc cố định cống hiến tâm sức trọn vẹn: "致力于"',
    pattern: 'Chủ ngữ + 长期 / 始终 + 致力于 + Sự nghiệp vĩ đại / Mục tiêu cao cả',
    category: 'Cấu trúc cố định',
    explanation_vi: '"致力于" (zhìlìyú) kết hợp chữ "致" (dốc hết, tận lực), "力" (sức lực) và "于", mang nghĩa cống hiến toàn bộ tâm trí, sức lực và thời gian vào việc theo đuổi một sự nghiệp cao cả, hòa bình, khoa học hoặc giáo dục (hết lòng dốc sức vào, tận tâm cống hiến cho).',
    examples: [
      {
        chinese: '这位诺贝尔和平奖得主毕生致力于消除全球贫困与促进跨文明平等对话。',
        pinyin: 'Zhè wèi Nuòbèi\'ěr hépíngjiǎng dézhǔ bìshēng zhìlìyú xiāochú quánqiú pínkùn yǔ cùjìn kuà wénmíng píngděng duìhuà.',
        translation_vi: 'Chủ nhân giải Nobel Hòa bình này suốt cả đời đã hết lòng dốc sức vào sự nghiệp xóa đói giảm nghèo toàn cầu và thúc đẩy đối thoại bình đẳng xuyên các nền văn minh.',
        explanation: '"毕生致力于..." ca ngợi lý tưởng nhân đạo cao cả dâng hiến trọn đời vì hòa bình nhân loại.'
      },
      {
        chinese: '中国政府始终坚定不移地致力于维护多边主义国际秩序与促进共同繁荣。',
        pinyin: 'Zhōngguó zhèngfǔ shǐzhōng jiāndìngbùyí de zhìlìyú wéihù duōbiānzhǔyì guójì zhìxù yǔ cùjìn gòngtóng fánróng.',
        translation_vi: 'Chính phủ Trung Quốc luôn kiên định không dời dốc sức vào việc bảo vệ trật tự quốc tế chủ nghĩa đa phương và thúc đẩy sự phồn vinh chung.',
        explanation: '"致力于维护...秩序" là lời cam kết ngoại giao cấp cao nhất về trách nhiệm nước lớn.'
      }
    ]
  },
  {
    order_index: 62,
    name: 'Động từ/Cấu trúc cố định chứng nhân lịch sử: "见证了"',
    pattern: 'Di tích / Thế hệ tiền bối / Công trình + 见证了 + Biến thiên lịch sử / Kỳ tích',
    category: 'Cấu trúc cố định',
    explanation_vi: '"见证" (jiànzhèng) là động từ cao cấp chỉ việc một nhân vật, một tòa nhà di tích lịch sử hoặc một dòng sông đã tận mắt chứng kiến, ghi dấu lại toàn bộ sự biến đổi thăng trầm hoặc sự ra đời của những kỳ tích vĩ đại qua năm tháng (làm nhân chứng, chứng kiến sự ra đời).',
    examples: [
      {
        chinese: '这座横跨长江的现代化大桥不仅连通了两岸交通，更见证了中国基建工业腾飞的奇迹历程。',
        pinyin: 'Zhè zuò héngkuà Chángjiāng de xiàndàihuà dàqiáo bùjǐn liántōng le liǎng\'àn jiāotōng, gèng jiànzhèng le Zhōngguó jījiàn gōngyè téngfēi de qíjì lìchéng.',
        translation_vi: 'Cây cầu lớn hiện đại bắc qua sông Trường Giang này không chỉ kết nối giao thông hai bên bờ, mà càng chứng kiến chặng đường kỳ tích cất cánh của ngành công nghiệp xây dựng hạ tầng Trung Quốc.',
        explanation: '"见证了...奇迹历程" nhân hóa cây cầu thành chứng nhân sống động cho sự trỗi dậy của đất nước.'
      },
      {
        chinese: '几代地质勘探队员扎根荒原六十年，亲眼见证了这片不毛之地崛起为现代化石油新城的沧桑巨变。',
        pinyin: 'Jǐ dài dìzhì kāntàn duìyuán zhāgēn huāngyuán liùshí nián, qīnyǎn jiànzhèng le zhè piàn bùmáozhīdì juéqǐ wéi xiàndàihuà shíyóu xīnchéng de cāngsāngjùbiàn.',
        translation_vi: 'Mấy thế hệ cán bộ thăm dò địa chất cắm rễ nơi hoang mạc suốt 60 năm, tận mắt chứng kiến sự đổi thay dâu bể của vùng đất không ngọn cỏ này vươn mình thành một đô thị dầu khí hiện đại.',
        explanation: '"见证了...沧桑巨变" ca ngợi công lao của những người mở đường khai phá mỏ dầu.'
      }
    ]
  }
];
