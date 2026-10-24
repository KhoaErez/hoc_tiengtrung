// ==============================================================================
// DATA: data_hsk4_grammar_part3.mjs
// HSK 4 GRAMMAR - PART 3: ĐIỂM 53 ĐẾN 78 (CHUẨN GF 0025-2021 APPENDIX A)
// Giới từ nâng cao & Hệ thống Liên từ phức hợp / Cặp từ nối logic HSK 4
// ==============================================================================

export const HSK4_GRAMMAR_PART3 = [
  {
    order_index: 53,
    name: 'Giới từ chỉ phạm vi đối tượng đề cập "关于" (Về / Liên quan đến)',
    pattern: '关于 + Danh từ / Đoản ngữ, Chủ ngữ + Vị ngữ / Về... (Định ngữ + 的 + Danh từ)',
    category: 'Giới từ',
    explanation_vi: '"关于" (guānyú) dùng để dẫn ra phạm vi sự vật, vấn đề cần nói tới hoặc tìm hiểu (liên quan đến, về vấn đề). Thường đứng ở đầu câu ngăn cách bằng dấu phẩy, hoặc làm định ngữ bổ nghĩa cho danh từ có chữ "的" (ví dụ: 关于这个问题的看法).',
    examples: [
      {
        chinese: '关于这次留学申请的具体流程，你可以参考招生简章。',
        pinyin: 'Guānyú zhè cì liúxué shēnqǐng de jùtǐ liúchéng, nǐ kěyǐ cānkǎo zhāoshēng jiǎnzhāng.',
        translation_vi: 'Về quy trình cụ thể của đợt nộp hồ sơ du học lần này, bạn có thể tham khảo đề án tuyển sinh.',
        explanation: '"关于这次留学申请..." đứng đầu câu xác lập chủ đề thảo luận về các bước nộp hồ sơ du học.'
      },
      {
        chinese: '王教授刚刚发表了一本关于中国传统文化的新书。',
        pinyin: 'Wáng jiàoshòu gānggāng fābiǎo le yì běn guānyú Zhōngguó chuántǒng wénhuà de xīn shū.',
        translation_vi: 'Giáo sư Vương vừa mới xuất bản một cuốn sách mới về văn hóa truyền thống Trung Quốc.',
        explanation: 'Cụm giới tân "关于中国传统文化" làm định ngữ có "的" hạn định nội dung chủ đề của cuốn sách.'
      }
    ]
  },
  {
    order_index: 54,
    name: 'Giới từ chỉ đối tượng tiếp nhận hành vi "对于" (Đối với / Về mặt)',
    pattern: '对于 + Đối tượng, Chủ ngữ + Vị ngữ / Chủ ngữ + 对于 + Đối tượng + Vị ngữ',
    category: 'Giới từ',
    explanation_vi: '"对于" (duìyú) chỉ đối tượng được nhắm tới, tiếp nhận sự đối đãi, thái độ, hoặc hành vi nhận thức (đối với). Khác với "关于" (chỉ phạm vi đề tài, sách báo, hội nghị), "对于" nhấn mạnh quan hệ tác động trực tiếp hoặc thái độ tâm lý (như 对于这件事我很重视).',
    examples: [
      {
        chinese: '对于大家提出的宝贵建议，公司领导层表示高度重视。',
        pinyin: 'Duìyú dàjiā tíchū de bǎoguì jiànyì, gōngsī lǐngdǎocéng biǎoshì gāodù zhòngshì.',
        translation_vi: 'Đối với những kiến nghị quý báu mà mọi người nêu ra, ban lãnh đạo công ty bày tỏ sự coi trọng cao độ.',
        explanation: '"对于大家提出的宝贵建议" là đối tượng được ban lãnh đạo tiếp nhận và xem xét nghiêm túc.'
      },
      {
        chinese: '多做模拟题对于提高汉语考试成绩有极大的帮助。',
        pinyin: 'Duō zuò mónǐ tí duìyú tígāo hànyǔ kǎoshì chéngjì yǒu jídà de bāngzhù.',
        translation_vi: 'Làm nhiều đề thi thử đối với việc nâng cao thành tích thi tiếng Trung có sự trợ giúp rất lớn.',
        explanation: '"对于提高...成绩" là đối tượng hưởng lợi ích từ việc luyện đề thi thử.'
      }
    ]
  },
  {
    order_index: 55,
    name: 'Giới từ/Liên từ chuyển mạch chủ đề "至于" (Còn về / Đến mức)',
    pattern: 'Chủ đề 1..., 至于 + Chủ đề 2 + Mệnh đề / 不至于 + Kết quả xấu',
    category: 'Giới từ',
    explanation_vi: '"至于" (zhìyú) có hai cách dùng quan trọng: 1) Đứng đầu vế câu sau để chuyển hướng câu chuyện sang một đối tượng hoặc chủ đề khác (còn về, còn đối với); 2) Biểu thị đạt đến mức độ nghiêm trọng (thường dùng ở dạng phủ định "不至于" - không đến nỗi, không đến mức).',
    examples: [
      {
        chinese: '这几个大问题我们已经解决了，至于具体的细节，明天再讨论。',
        pinyin: 'Zhè jǐ gè dà wèntí wǒmen yǐjīng jiějué le, zhìyú jùtǐ de xìjié, míngtiān zài tǎolùn.',
        translation_vi: 'Mấy vấn đề lớn này chúng ta đã giải quyết xong rồi, còn về chi tiết cụ thể, ngày mai sẽ thảo luận tiếp.',
        explanation: '"至于具体的细节" chuyển mạch bàn luận từ vấn đề tổng thể sang các tiểu tiết kỹ thuật.'
      },
      {
        chinese: '虽然这次比赛没有拿到冠军，但我们也不至于感到绝望。',
        pinyin: 'Suīrán zhè cì bǐsài méiyǒu nádào guànjūn, dàn wǒmen yě bú zhìyú gǎndào juéwàng.',
        translation_vi: 'Tuy rằng cuộc thi lần này không đoạt cúp vô địch, nhưng chúng tôi cũng không đến mức cảm thấy tuyệt vọng.',
        explanation: '"不至于" biểu thị mức độ thất vọng vẫn nằm trong tầm kiểm soát, chưa đến bờ vực bi quan cực đoan.'
      }
    ]
  },
  {
    order_index: 56,
    name: 'Giới từ chỉ căn cứ chuẩn mực "按照" (Căn cứ vào / Theo / Chiểu theo)',
    pattern: '按照 + Tiêu chuẩn/Quy định/Kế hoạch + Động từ + Tân ngữ',
    category: 'Giới từ',
    explanation_vi: '"按照" (ànzhào) biểu thị việc tiến hành một hành động tuân thủ nghiêm ngặt theo một tiêu chuẩn, quy tắc, chỉ thị, hoặc thỏa thuận có sẵn (căn cứ theo, làm theo). Thường đi với các từ như 规定, 计划, 要求, 标准, 顺序.',
    examples: [
      {
        chinese: '所有参赛选手都必须按照比赛规则按时提交作品。',
        pinyin: 'Suǒyǒu cànsài xuǎnshǒu dōu bìxū ànzhào bǐsài guīzé ànshí tíjiāo zuòpǐn.',
        translation_vi: 'Tất cả các thí sinh dự thi đều phải nộp tác phẩm đúng hạn căn cứ theo quy chế cuộc thi.',
        explanation: '"按照比赛规则" xác lập chuẩn mực pháp lý buộc thí sinh phải chấp hành giờ giấc.'
      },
      {
        chinese: '工程队正在按照原定计划抓紧施工，确保按期完工。',
        pinyin: 'Gōngchéngduì zhèngzài ànzhào yuándìng jìhuà zhuājǐn shīgōng, quèbǎo ànqī wángōng.',
        translation_vi: 'Đội thi công đang khẩn trương xây dựng theo kế hoạch định sẵn, bảo đảm hoàn thành đúng tiến độ.',
        explanation: '"按照原定计划" làm rõ việc thi công tuân thủ đúng lộ trình tiến độ ban đầu.'
      }
    ]
  },
  {
    order_index: 57,
    name: 'Giới từ chỉ cơ sở lập luận thực tế "根据" (Căn cứ vào / Dựa trên)',
    pattern: '根据 + Dữ liệu/Khảo sát/Tình hình thực tế, Mệnh đề phán đoán',
    category: 'Giới từ',
    explanation_vi: '"根据" (gēnjù) vừa là giới từ vừa là danh từ. Khi làm giới từ, nó dẫn ra căn cứ khách quan, sự thật, số liệu điều tra hoặc dữ kiện thực tế để làm cơ sở cho một phán đoán, kết luận hoặc hành động. So với "按照" (thiên về quy định chuẩn mực con người đặt ra), "根据" thiên về sự kiện thực tế và nghiên cứu khoa học.',
    examples: [
      {
        chinese: '根据气象部门发布的最新预报，今天傍晚将有雷阵雨。',
        pinyin: 'Gēnjù qìxiàng bùmén fābù de zuìxīn yùbào, jīntiān bàngwǎn jiāng yǒu léizhènyǔ.',
        translation_vi: 'Dựa trên dự báo mới nhất do cơ quan khí tượng công bố, chiều tối nay sẽ có mưa dông.',
        explanation: '"根据...最新预报" dẫn ra nguồn tin tức khoa học xác thực làm căn cứ nhận định thời tiết.'
      },
      {
        chinese: '医生会根据每位病人的身体状况制定最合适的治疗方案。',
        pinyin: 'Yīshēng huì gēnjù měi wèi bìngrén de shēntǐ zhuàngkuàng zhìdìng zuì héshì de zhìliáo fāng\'àn.',
        translation_vi: 'Bác sĩ sẽ căn cứ vào tình trạng sức khỏe của từng bệnh nhân để lập ra phác đồ điều trị phù hợp nhất.',
        explanation: '"根据每位病人的身体状况" cho thấy việc trị liệu dựa sát vào tình trạng thực tế cá thể hóa.'
      }
    ]
  },
  {
    order_index: 58,
    name: 'Giới từ chỉ tinh thần và phương châm chỉ đạo "本着" (Trên tinh thần / Dựa trên nguyên tắc)',
    pattern: '本着 + Nguyên tắc/Phương châm/Tinh thần + 的原则/态度, Mệnh đề',
    category: 'Giới từ',
    explanation_vi: '"本着" (běnzhe) là giới từ trang trọng trong văn viết chính luận, thương mại và pháp lý, mang nghĩa là xuất phát từ hoặc lấy một phương châm, tôn chỉ, nguyên tắc chỉ đạo tốt đẹp nào đó làm kim chỉ nam cho hành động.',
    examples: [
      {
        chinese: '双方本着平等互利的原则，签署了长期战略合作协议。',
        pinyin: 'Shuāngfāng běnzhe píngděng hùlì de yuánzé, qiānshǔ le chángqī zhànlüè hézuò xiéyì.',
        translation_vi: 'Đôi bên trên tinh thần nguyên tắc bình đẳng cùng có lợi, đã ký kết thỏa thuận hợp tác chiến lược dài hạn.',
        explanation: '"本着平等互利的原则" là phương châm chỉ đạo chuẩn mực trong đàm phán hợp đồng kinh tế quốc tế.'
      },
      {
        chinese: '我们本着对消费者负责的态度，对这批产品进行了全面复检。',
        pinyin: 'Wǒmen běnzhe duì xiāofèizhě fùzé de tàidu, duì zhè pī chǎnpǐn jìnxíng le quánmiàn fùjiǎn.',
        translation_vi: 'Chúng tôi với thái độ chịu trách nhiệm đối với người tiêu dùng, đã tiến hành kiểm tra lại toàn diện lô hàng này.',
        explanation: '"本着...的态度" thể hiện tinh thần trách nhiệm cao của nhà sản xuất.'
      }
    ]
  },
  {
    order_index: 59,
    name: 'Giới từ dựa vào năng lực hoặc bằng chứng "凭" (Dựa vào / Dựa trên / Bằng)',
    pattern: '凭 + Năng lực/Kinh nghiệm/Giấy tờ + Động từ + Tân ngữ',
    category: 'Giới từ',
    explanation_vi: '"凭" (píng) biểu thị hành động được thực hiện dựa vào một kỹ năng chủ quan (kinh nghiệm, cảm giác, năng lực), hoặc dựa vào một điều kiện giấy tờ/bằng chứng khách quan (vé vào cửa, chứng minh nhân dân, giấy thông hành).',
    examples: [
      {
        chinese: '他凭着丰富的实践经验，很快就排除了这台机器的故障。',
        pinyin: 'Tā píngzhe fēngfù de shíjiàn jīngyàn, hěn kuài jiù páichú le zhè tái jīqì de gùzhàng.',
        translation_vi: 'Nhờ dựa vào kinh nghiệm thực tiễn phong phú, anh ấy đã rất nhanh chóng loại trừ được sự cố của cỗ máy này.',
        explanation: '"凭着丰富的实践经验" làm rõ yếu tố giúp người thợ kỹ thuật giải quyết hỏng hóc máy móc.'
      },
      {
        chinese: '进入音乐厅前，请各位观众凭门票到入口处检票入场。',
        pinyin: 'Jìnrù yīnyuètīng qián, qǐng gèwèi guānzhòng píng ménpiào dào rùkǒuchù jiǎnpiào rùchǎng.',
        translation_vi: 'Trước khi vào phòng hòa nhạc, xin quý vị khán giả xuất trình vé để soát vé vào cửa.',
        explanation: '"凭门票" (dựa vào vé) là điều kiện thủ tục bắt buộc để được phép vào khán phòng.'
      }
    ]
  },
  {
    order_index: 60,
    name: 'Giới từ chỉ chủ thể phụ trách hoặc nguồn gốc "由" (Do / Bởi / Từ)',
    pattern: '由 + Chủ thể phụ trách + Động từ + Tân ngữ / 由...组成',
    category: 'Giới từ',
    explanation_vi: '"由" (yóu) có hai cách dùng chính: 1) Dẫn ra người hoặc cơ quan chịu trách nhiệm thực hiện, chi trả, hoặc phụ trách một việc (như 由他负责, 由学校出资); 2) Biểu thị thành phần cấu tạo nên một chỉnh thể (như 由三部分组成 - do ba phần cấu thành).',
    examples: [
      {
        chinese: '这次国际学术研讨会的所有接待工作由外事办公室全权负责。',
        pinyin: 'Zhè cì guójì xuéshù yántǎohuì de suǒyǒu jiēdài gōngzuò yóu wàishì bàngōngshì quánquán fùzé.',
        translation_vi: 'Toàn bộ công tác đón tiếp của hội thảo học thuật quốc tế lần này do văn phòng đối ngoại toàn quyền phụ trách.',
        explanation: '"由外事办公室...负责" chỉ rõ cơ quan có thẩm quyền và trách nhiệm tổ chức sự kiện.'
      },
      {
        chinese: '这个科研小组是由十位来自不同学科的年轻博士组成的。',
        pinyin: 'Zhè ge kēyán xiǎozǔ shì yóu shí wèi láizì bùtóng xuékē de niánqīng bóshì zǔchéng de.',
        translation_vi: 'Tổ nghiên cứu khoa học này do mười vị tiến sĩ trẻ đến từ các ngành học khác nhau tạo thành.',
        explanation: '"由...组成" là cấu trúc biểu thị các thành viên cấu tạo nên một tổ chức nghiên cứu.'
      }
    ]
  },
  {
    order_index: 61,
    name: 'Giới từ mốc thời gian khởi điểm "自从" (Kể từ khi / Từ lúc)',
    pattern: '自从 + Mốc thời gian/Sự kiện, Chủ ngữ + Đã/Luôn + Vị ngữ',
    category: 'Giới từ',
    explanation_vi: '"自从" (zìcóng) chỉ mốc thời gian bắt đầu xảy ra một trạng thái hay quá trình liên tục kéo dài cho đến tận thời điểm hiện tại hoặc thời điểm đang nói tới (từ khi, kể từ sau khi). So với "从", "自从" chỉ dùng cho thời gian trong quá khứ, không dùng cho địa điểm không gian.',
    examples: [
      {
        chinese: '自从上了大学以后，他学会了独立安排自己的日常生活。',
        pinyin: 'Zìcóng shàng le dàxué yǐhòu, tā xuéhuì le dúlì ānpái zìjǐ de rìcháng shēnghuó.',
        translation_vi: 'Kể từ sau khi bước chân vào đại học, cậu ấy đã học được cách tự lập sắp xếp đời sống hằng ngày của mình.',
        explanation: '"自从上了大学以后" xác định mốc biến cố quan trọng mở đầu cho quá trình trưởng thành tự lập.'
      },
      {
        chinese: '自从搬进这套新公寓，他的睡眠质量有了明显的改善。',
        pinyin: 'Zìcóng bānjìn zhè tào xīn gōngyù, tā de shuìmián zhìliàng yǒu le míngxiǎn de gǎishàn.',
        translation_vi: 'Kể từ khi dọn vào căn hộ mới này, chất lượng giấc ngủ của anh ấy đã có sự cải thiện rõ rệt.',
        explanation: '"自从..." liên kết thời điểm chuyển nhà với chuỗi biến đổi tích cực về sức khỏe.'
      }
    ]
  },
  {
    order_index: 62,
    name: 'Giới từ nắm bắt thời cơ thuận lợi "趁" (Nhân dịp / Thừa cơ / Tiện lúc)',
    pattern: '趁 + Cơ hội/Thời gian thuận lợi, Chủ ngữ + Động từ + Tân ngữ',
    category: 'Giới từ',
    explanation_vi: '"趁" (chèn) biểu thị việc tranh thủ hoặc nắm bắt một điều kiện thời gian, hoàn cảnh hoặc trạng thái thuận lợi đang diễn ra để thực hiện một hành động trước khi điều kiện đó qua đi (thừa dịp, nhân lúc). Thường gặp: 趁热 (nhân lúc còn nóng), 趁机 (thừa cơ), 趁年轻 (nhân lúc còn trẻ).',
    examples: [
      {
        chinese: '饺子刚刚煮好，你快趁热吃吧，凉了就不好吃了。',
        pinyin: 'Jiǎozi gānggāng zhǔhǎo, nǐ kuài chèn rè chī ba, liáng le jiù bù hǎochī le.',
        translation_vi: 'Bánh sủi cảo vừa mới luộc chín xong, cậu hãy mau ăn lúc còn nóng đi, nguội rồi sẽ không ngon nữa.',
        explanation: '"趁热吃" là cách nói văn hóa quen thuộc nhắc nhở thưởng thức món ăn khi nhiệt độ thơm ngon nhất.'
      },
      {
        chinese: '我们应该趁着年轻多学一些实用的知识和专业技能。',
        pinyin: 'Wǒmen yīnggāi chènzhe niánqīng duō xué yìxiē shíyòng de zhīshi hé zhuānyè jìnéng.',
        translation_vi: 'Chúng ta nên nhân lúc còn trẻ học thêm nhiều kiến thức thực tế và kỹ năng chuyên môn.',
        explanation: '"趁着年轻" khuyên nhủ nắm bắt thời thanh xuân tràn đầy năng lượng để tích lũy học vấn.'
      }
    ]
  },
  {
    order_index: 63,
    name: 'Giới từ định hướng mục tiêu "朝" (Hướng về / Về phía)',
    pattern: 'Chủ ngữ + 朝 + Phương hướng/Đối tượng + Động từ (走/看/跑/挥手)',
    category: 'Giới từ',
    explanation_vi: '"朝" (cháo) là giới từ biểu thị hướng quay mặt hoặc phương hướng chuyển động của hành động nhắm tới (về phía, hướng tới). Thường đi với các động từ chỉ động thái như 走, 看, 望, 挥手, 拜, 笑. Khác với "往", "朝" nhấn mạnh góc quay hoặc đối tượng đối diện.',
    examples: [
      {
        chinese: '列车缓缓启动了，站台上的亲友们纷纷朝车窗挥手告别。',
        pinyin: 'Lièchē huǎnhuǎn qǐdòng le, zhàntái shang de qīnyǒumen fēnfēn cháo chēchuāng huīshǒu gàobié.',
        translation_vi: 'Đoàn tàu từ từ lăn bánh, người thân và bạn bè trên sân ga đồng loạt vẫy tay về phía cửa sổ toa tàu để từ biệt.',
        explanation: '"朝车窗挥手" chỉ động tác vẫy tay hướng về phía khung cửa sổ tàu hỏa.'
      },
      {
        chinese: '出了地铁站之后，一直朝前走两百米就能看到那家书店。',
        pinyin: 'Chū le dìtiězhàn zhīhòu, yìzhí cháo qián zǒu liǎng bǎi mǐ jiù néng kàndào nà jiā shūdiàn.',
        translation_vi: 'Sau khi ra khỏi ga tàu điện ngầm, cứ đi thẳng về phía trước 200 mét là có thể nhìn thấy hiệu sách đó.',
        explanation: '"朝前走" chỉ dẫn phương hướng tiến lên phía trước.'
      }
    ]
  },
  {
    order_index: 64,
    name: 'Giới từ thay mặt hoặc vì lợi ích của người khác "替" (Thay cho / Giúp)',
    pattern: 'Chủ ngữ + 替 + Người khác + Động từ + Tân ngữ',
    category: 'Giới từ',
    explanation_vi: '"替" (tì) có hai nghĩa chính: 1) Đại diện hoặc thay thế vị trí cho ai đó làm một việc gì (như 替他请假 - xin nghỉ hộ anh ấy); 2) Đứng về phía tình cảm hoặc lợi ích của người khác để đồng cảm (như 替你高兴 - mừng thay cho cậu, 替他担心 - lo lắng cho anh ấy).',
    examples: [
      {
        chinese: '听到你顺利通过高级汉语考试的消息，大家都很替你高兴。',
        pinyin: 'Tīngdào nǐ shùnlì tōngguò gāojí hànyǔ kǎoshì de xiāoxi, dàjiā dōu hěn tì nǐ gāoxìng.',
        translation_vi: 'Nghe tin cậu đã thuận lợi vượt qua kỳ thi tiếng Hán cao cấp, mọi người đều rất mừng cho cậu.',
        explanation: '"替你高兴" thể hiện sự chia sẻ niềm vui chân thành đứng trên cương vị người bạn.'
      },
      {
        chinese: '如果明天下午你有急事去不了，我可以替你去参加开幕式。',
        pinyin: 'Rúguǒ míngtiān xiàwǔ nǐ yǒu jíshì qù bù liǎo, wǒ kěyǐ tì nǐ qù cānjiā kāimùshì.',
        translation_vi: 'Nếu chiều mai cậu có việc bận gấp không đi được, mình có thể thay cậu đi tham dự lễ khai mạc.',
        explanation: '"替你去参加" là hành động đi thay mặt, đại diện dự sự kiện.'
      }
    ]
  },
  {
    order_index: 65,
    name: 'Cặp liên từ tăng tiến đa tầng "不仅...而且..." (Không những... mà còn...)',
    pattern: 'Chủ ngữ + 不仅...而且... / 不但...而且... / 不仅 A, 而且 B',
    category: 'Liên từ',
    explanation_vi: 'Cặp liên từ "不仅...而且..." (bùjǐn... érqiě...) biểu thị quan hệ tăng tiến từ tầng nghĩa cơ sở lên tầng nghĩa sâu hơn hoặc rộng lớn hơn. Nếu hai vế cùng một chủ ngữ thì chủ ngữ đứng trước "不仅"; nếu hai vế khác chủ ngữ thì mỗi chủ ngữ đứng sau "不仅" và "而且".',
    examples: [
      {
        chinese: '多吃新鲜蔬菜水果不仅有益健康，而且能有效保持皮肤光泽。',
        pinyin: 'Duō chī xīnxiān shūcài shuǐguǒ bùjǐn yǒuyì jiànkāng, érqiě néng yǒuxiào bǎochí pífū guāngzé.',
        translation_vi: 'Ăn nhiều rau quả tươi chẳng những có lợi cho sức khỏe mà còn duy trì hiệu quả độ sáng bóng của làn da.',
        explanation: '"不仅...而且..." cùng chung chủ ngữ, nâng cao tác dụng từ sức khỏe tổng quát lên tới sắc đẹp làn da.'
      },
      {
        chinese: '不仅老师赞扬了他的勇敢举动，而且同学们也纷纷向他学习。',
        pinyin: 'Bùjǐn lǎoshī zànyáng le tā de yǒnggǎn jǔdòng, érqiě tóngxuémen yě fēnfēn xiàng tā xuéxí.',
        translation_vi: 'Không chỉ thầy cô ngợi khen hành động dũng cảm của cậu ấy, mà các bạn học sinh cũng đồng loạt noi gương học tập.',
        explanation: 'Khác chủ ngữ ("老师" và "同学们"), "不仅" đứng đầu vế một và "而且" đứng đầu vế hai.'
      }
    ]
  },
  {
    order_index: 66,
    name: 'Liên từ tăng tiến cực hạn "甚至" (Thậm chí / Ngay cả)',
    pattern: 'Vế 1, 甚至 + (连...) + Vế 2 / A, B, 甚至 C',
    category: 'Liên từ',
    explanation_vi: '"甚至" (shènzhì) nêu ra một trường hợp hoặc ví dụ cực đoan, nổi bật nhất để nhấn mạnh mức độ tăng tiến phi thường của sự việc. Có thể dùng để liên kết các từ, ngữ hoặc các phân câu độc lập.',
    examples: [
      {
        chinese: '这道数学题太难了，很多大学生都做不出来，甚至连老师都答不上来。',
        pinyin: 'Zhè dào shùxué tí tài nán le, hěn duō dàxuéshēng dōu zuò bù chūlái, shènzhì lián lǎoshī dōu dá bú shànglái.',
        translation_vi: 'Bài toán này quá khó, rất nhiều sinh viên đại học đều không giải được, thậm chí ngay cả giáo viên cũng không trả lời nổi.',
        explanation: '"甚至连老师..." đẩy độ khó lên mức cực hạn, vượt quá tầm kiến thức thông thường.'
      },
      {
        chinese: '为了赶工期，工人们经常加班到深夜，有时候甚至彻夜不眠。',
        pinyin: 'Wèile gǎn gōngqī, gōngrénmen jīngcháng jiābān dào shēnyè, yǒu shíhou shènzhì chèyè bù mián.',
        translation_vi: 'Để kịp tiến độ thi công, các công nhân thường tăng ca đến tận đêm khuya, có lúc thậm chí thức trắng suốt đêm.',
        explanation: '"甚至彻夜不眠" tăng tiến cường độ lao động vất vả từ đêm muộn đến trắng đêm.'
      }
    ]
  },
  {
    order_index: 67,
    name: 'Liên từ bổ sung lý do xác đáng "况且" (Hơn nữa / Vả lại)',
    pattern: 'Lý do 1, 况且 + Lý do 2 (thuyết phục hơn) + Kết luận',
    category: 'Liên từ',
    explanation_vi: '"况且" (kuàngqiě) dùng ở vế sau để bổ sung thêm một lý do hoặc điều kiện hiển nhiên khác, làm cho luận điểm hoặc quyết định được đưa ra càng thêm vững chắc, có sức thuyết phục cao hơn (vả lại, hơn nữa).',
    examples: [
      {
        chinese: '现在下着大暴雨，况且路灯也坏了，你一个人走夜路太危险了。',
        pinyin: 'Xiànzài xiàzhe dà bàoyǔ, kuàngqiě lùdēng yě huài le, nǐ yí gè rén zǒu yèlù tài wēixiǎn le.',
        translation_vi: 'Bây giờ trời đang mưa to tầm tã, hơn nữa đèn đường cũng hỏng rồi, bạn đi đường đêm một mình quá nguy hiểm.',
        explanation: '"况且路灯也坏了" bổ sung thêm lý do thứ hai thuyết phục đối phương không nên ra đường ban đêm.'
      },
      {
        chinese: '我们已经准备了整整三个月，况且大家经验丰富，一定能圆满完成任务。',
        pinyin: 'Wǒmen yǐjīng zhǔnbèi le zhěngzhěng sān gè yuè, kuàngqiě dàjiā jīngyàn fēngfù, yídìng néng yuánmǎn wánchéng rènwu.',
        translation_vi: 'Chúng ta đã chuẩn bị tròn ba tháng ròng, hơn nữa mọi người lại giàu kinh nghiệm, nhất định sẽ hoàn thành mỹ mãn nhiệm vụ.',
        explanation: '"况且" củng cố niềm tin thành công bằng việc viện dẫn kinh nghiệm dày dạn của đội ngũ.'
      }
    ]
  },
  {
    order_index: 68,
    name: 'Liên từ tăng tiến tương phản ngụ ý "何况" (Huống hồ / Huống chi)',
    pattern: 'Tình huống A (dễ/gần) + Còn như vậy, 何况 + Tình huống B (khó/xa)',
    category: 'Liên từ',
    explanation_vi: '"何况" (hékuàng) biểu thị ý nghĩa: ngay cả trường hợp thông thường, đối tượng mạnh mẽ/dễ hơn còn như vậy thì huống chi trường hợp đặc biệt, đối tượng yếu hơn (huống hồ, huống chi). Thường dùng trong so sánh ngầm mang tính tu từ mạnh mẽ.',
    examples: [
      {
        chinese: '成年人走这么陡峭的山路都很吃力，何况是几岁的小孩子呢？',
        pinyin: 'Chéngniánrén zǒu zhème dǒuqìao de shānlù dōu hěn chīlì, hékuàng shì jǐ suì de xiǎoháizi ne?',
        translation_vi: 'Người lớn đi con đường núi dốc đứng thế này còn rất tốn sức, huống chi là đứa trẻ con mấy tuổi đầu chứ?',
        explanation: 'Cấu trúc so sánh tương phản ngụ ý: người lớn còn chịu không nổi thì trẻ nhỏ càng không thể.'
      },
      {
        chinese: '本地人都经常在这座立交桥上迷路，何况你是第一次来这里的游客。',
        pinyin: 'Běndìrén dōu jīngcháng zài zhè zuò lìjiāoqiáo shang mílù, hékuàng nǐ shì dì yī cì lái zhèlǐ de yóukè.',
        translation_vi: 'Người bản xứ còn thường xuyên bị lạc đường trên cây cầu vượt này, huống hồ cậu lại là du khách lần đầu tiên đến đây.',
        explanation: '"何况" cảm thông cho việc lạc đường của du khách bằng cách đối chiếu với người bản địa.'
      }
    ]
  },
  {
    order_index: 69,
    name: 'Liên từ chỉ hệ quả và bước tiến tiếp theo "从而" (Do đó mà / Nhờ đó mà)',
    pattern: 'Biện pháp/Hành động, 从而 + Kết quả/Ý nghĩa tiến bộ',
    category: 'Liên từ',
    explanation_vi: '"从而" (cóng\'ér) là liên từ trang trọng nối liền nguyên nhân/biện pháp ở vế trước với kết quả, mục đích hoặc bước phát triển tất yếu ở vế sau (do đó mà, nhờ vậy mà). Vế sau thường là một kết quả tích cực, nâng cao chất lượng hoặc đạt được mục tiêu lớn.',
    examples: [
      {
        chinese: '公司引进了最先进的自动化设备，从而大幅降低了生产成本。',
        pinyin: 'Gōngsī yǐnjìn le zuì xiānjìn de zìdònghuà shèbèi, cóng\'ér dàfú jiàngdī le shēngchǎn chéngběn.',
        translation_vi: 'Công ty đã du nhập thiết bị tự động hóa tiên tiến nhất, nhờ đó mà giảm mạnh chi phí sản xuất.',
        explanation: '"从而大幅降低..." nối liền biện pháp cải tiến công nghệ với thành quả kinh tế to lớn đạt được.'
      },
      {
        chinese: '坚持每天阅读可以开阔视野，从而提高个人的综合文化修养。',
        pinyin: 'Jiānchí měitiān yuèdú kěyǐ kāikuò shìyě, cóng\'ér tígāo gèrén de zōnghé wénhuà xiūyǎng.',
        translation_vi: 'Kiên trì đọc sách mỗi ngày có thể mở rộng tầm mắt, nhờ đó nâng cao tu dưỡng văn hóa tổng hợp của cá nhân.',
        explanation: '"从而" diễn tả bước tiến nâng cao phẩm chất tinh thần xuất phát từ thói quen đọc sách.'
      }
    ]
  },
  {
    order_index: 70,
    name: 'Liên từ suy luận kết quả tự nhiên "因而" (Vì vậy / Cho nên)',
    pattern: 'Nguyên nhân thực tế, 因而 + Kết quả tất yếu',
    category: 'Liên từ',
    explanation_vi: '"因而" (yīn\'ér) là liên từ kết hợp "因" (vì) và "而" (thì/cho nên), tương đương với "因此" hoặc "所以", dùng trong văn viết và phong cách nghị luận trang trọng để kết nối mối quan hệ nhân quả logic.',
    examples: [
      {
        chinese: '他在科学实验中付出了极大的心血，因而取得了举世瞩目的成就。',
        pinyin: 'Tā zài kēxué shíyàn zhōng fùchū le jídà de xīnxuè, yīn\'ér qǔdé le jǔshì zhǔmù de chéngjiù.',
        translation_vi: 'Ông đã bỏ ra tâm huyết to lớn trong các thí nghiệm khoa học, vì vậy đã gặt hái được những thành tựu khiến cả thế giới dõi theo.',
        explanation: '"因而取得了..." là kết quả xứng đáng đền đáp cho công lao nghiên cứu kiên trì.'
      },
      {
        chinese: '由于双方观点存在根本分歧，因而这次商务洽谈未能达成最终共识。',
        pinyin: 'Yóuyú shuāngfāng guāndiǎn cúnzài gēnběn fēnqí, yīn\'ér zhè cì shāngwù qiàtán wèinéng dáchéng zuìzhōng gòngshí.',
        translation_vi: 'Do quan điểm của đôi bên tồn tại bất đồng căn bản, vì vậy cuộc đàm phán thương mại lần này đã không thể đạt được đồng thuận cuối cùng.',
        explanation: '"因而" liên kết sự bất đồng quan điểm với kết quả đàm phán bất thành.'
      }
    ]
  },
  {
    order_index: 71,
    name: 'Cặp liên từ tiền đề hiển nhiên "既然...就..." (Đã... thì...)',
    pattern: '既然 + Sự thật đã rồi / Tiền đề được thừa nhận, (Chủ ngữ) + 就 + Kết luận/Hành động',
    category: 'Liên từ',
    explanation_vi: '"既然...就..." (jìrán... jiù...) dùng khi sự việc ở vế trước đã là một thực tế hiển nhiên, được cả người nói và người nghe thừa nhận, từ đó vế sau đưa ra quyết định, giải pháp hoặc lời khuyên hợp tình hợp lý (đã thế thì hãy làm thế).',
    examples: [
      {
        chinese: '既然大家对此都没有异议，我们就按照这个方案开始执行吧。',
        pinyin: 'Jìrán dàjiā duì cǐ dōu méiyǒu yìyì, wǒmen jiù ànzhào zhè ge fāng\'àn kāishǐ zhíxíng ba.',
        translation_vi: 'Đã mọi người đều không có dị nghị gì về điều này, thì chúng ta hãy bắt đầu triển khai theo phương án này đi.',
        explanation: '"既然...就..." dựa trên tiền đề mọi người đồng thuận để đưa ra quyết định khởi động dự án.'
      },
      {
        chinese: '既然你身体不舒服，就留在宿舍里好好休息，别去跑步了。',
        pinyin: 'Jìrán nǐ shēntǐ bù shūfu, jiù liú zài sùshè lǐ hǎohǎo xiūxi, bié qù pǎobù le.',
        translation_vi: 'Đã cậu cảm thấy trong người không khỏe, thì hãy ở lại ký túc xá nghỉ ngơi thật tốt, đừng đi chạy bộ nữa.',
        explanation: '"既然" thừa nhận trạng thái mệt mỏi của người bạn để đưa ra lời khuyên nghỉ ngơi hợp lý.'
      }
    ]
  },
  {
    order_index: 72,
    name: 'Cặp liên từ giả thiết nhượng bộ tột bực "哪怕...也..." (Dù cho... cũng...)',
    pattern: '哪怕 + Điều kiện cực đoan/Khó khăn nhất, 主语 + 也 + Quyết tâm/Hành vi',
    category: 'Liên từ',
    explanation_vi: '"哪怕...也..." (nǎpà... yě...) biểu thị sự nhượng bộ giả định đối với một điều kiện cực đoan, khó khăn nhất có thể tưởng tượng ra, nhưng kết quả hoặc quyết tâm ở vế sau vẫn kiên định không hề lay chuyển (cho dù... cũng vẫn cứ).',
    examples: [
      {
        chinese: '哪怕前方的道路再艰难，我们也绝不会放弃自己的梦想。',
        pinyin: 'Nǎpà qiánfāng de dàolù zài jiānnán, wǒmen yě jué bú huì fàngqì zìjǐ de mèngxiǎng.',
        translation_vi: 'Dù cho con đường phía trước có gian nan đến mấy, chúng tôi cũng tuyệt đối không từ bỏ ước mơ của mình.',
        explanation: '"哪怕...也绝不会放弃" khẳng định quyết tâm theo đuổi lý tưởng bất chấp muôn trùng chông gai.'
      },
      {
        chinese: '哪怕只剩下一线希望，医生们也会竭尽全力抢救这名伤员。',
        pinyin: 'Nǎpà zhǐ shèngxià yí xiàn xīwàng, yīshēngmen yě huì jiéjìn quánlì qiǎngjiù zhè míng shāngyuán.',
        translation_vi: 'Dù cho chỉ còn lại một tia hy vọng mong manh, các bác sĩ cũng sẽ dốc hết toàn lực cứu chữa người bị thương này.',
        explanation: '"哪怕只剩下一线希望" thể hiện y đức cao cả không bỏ cuộc trước sự sống.'
      }
    ]
  },
  {
    order_index: 73,
    name: 'Cặp liên từ nhượng bộ trang trọng "即便...也..." (Cho dù... cũng...)',
    pattern: '即便 + Tình huống giả thiết bất lợi, 主语 + 也 + Vị ngữ',
    category: 'Liên từ',
    explanation_vi: '"即便...也..." (jíbiàn... yě...) tương đương với "即使...也...", nhưng mang sắc thái trang nhã, văn phong uyển chuyển và học thuật hơn (cho dù... thì vẫn cứ). Thường dùng để biện luận trong văn viết chính luận.',
    examples: [
      {
        chinese: '即便在最困难的岁月里，他也始终没有丧失对未来的信心。',
        pinyin: 'Jíbiàn zài zuì kùnnan de suìyuè lǐ, tā yě shǐzhōng méiyǒu sàngshī duì wèilái de xìnxīn.',
        translation_vi: 'Cho dù ở vào những năm tháng khó khăn nhất, ông ấy cũng luôn luôn không đánh mất niềm tin vào tương lai.',
        explanation: '"即便...也..." diễn tả nghị lực phi thường giữ trọn niềm tin qua thử thách khắc nghiệt.'
      },
      {
        chinese: '即便这项技术目前还不成熟，我们也有必要进行深入的预先研究。',
        pinyin: 'Jíbiàn zhè xiàng jìshù mùqián hái bù chéngshú, wǒmen yě yǒu bìyào jìnxíng shēnrù de yùxiān yánjiū.',
        translation_vi: 'Cho dù công nghệ này hiện tại vẫn chưa hoàn thiện, chúng ta cũng cần thiết phải tiến hành nghiên cứu đón đầu chuyên sâu.',
        explanation: '"即便...也有必要" bảo vệ tính cần thiết của việc đón đầu công nghệ tương lai.'
      }
    ]
  },
  {
    order_index: 74,
    name: 'Cặp liên từ chuyển ngoặt hiện thực "尽管...但是/却..." (Mặc dù... nhưng...)',
    pattern: '尽管 + Sự thật khách quan, 但是 / 可是 / 却 + Kết quả tương phản',
    category: 'Liên từ',
    explanation_vi: '"尽管...但是..." (jǐnguǎn... dànshì...) biểu thị quan hệ chuyển ngoặt trên cơ sở sự thật đã xảy ra hoặc đang tồn tại (khác với "即使" dùng cho giả thiết chưa xảy ra). Vế đầu thừa nhận một thực tế cản trở, vế sau dùng "但是" hoặc "却" nêu ra kết quả bất ngờ trái ngược.',
    examples: [
      {
        chinese: '尽管外面的天气非常严寒，但是大厅里的气氛却格外热烈。',
        pinyin: 'Jǐnguǎn wàimiàn de tiānqì fēicháng yánhán, dànshì dàtīng lǐ de qìfēn què géwài rèliè.',
        translation_vi: 'Mặc dù thời tiết bên ngoài vô cùng giá rét, nhưng bầu không khí bên trong đại sảnh lại hết sức ấm cúng náo nhiệt.',
        explanation: '"尽管...但是...却" làm nổi bật sự đối lập sinh động giữa nhiệt độ ngoài trời và không khí trong hội trường.'
      },
      {
        chinese: '尽管遇到了许多意料之外的挑战，团队最终还是按时交付了产品。',
        pinyin: 'Jǐnguǎn yùdào le xǔduō yìliào zhīwài de tiǎozhàn, tuánduì zuìzhōng háishì ànshí jiāofù le chǎnpǐn.',
        translation_vi: 'Mặc dù đã gặp phải rất nhiều thách thức ngoài dự liệu, đội ngũ cuối cùng vẫn bàn giao sản phẩm đúng hạn.',
        explanation: '"尽管..." ghi nhận sự gian khổ của tập thể để tôn vinh kết quả bàn giao dự án xuất sắc.'
      }
    ]
  },
  {
    order_index: 75,
    name: 'Cấu trúc lựa chọn xả thân nhượng bộ "宁可...也不..." (Thà rằng... chứ không...)',
    pattern: 'Chủ ngữ + 宁可 + Phương án hy sinh/chấp nhận thiệt thòi, 也不 + Phương án vi phạm nguyên tắc',
    category: 'Liên từ',
    explanation_vi: '"宁可...也不..." (nìngkě... yě bù...) biểu thị sự so sánh giữa hai khả năng bất lợi, trong đó chủ thể tình nguyện chấp nhận phương án thứ nhất (dù gian khổ, tốn kém hoặc chịu thiệt thòi) chứ quyết không bao giờ chấp nhận phương án thứ hai (vì vi phạm đạo đức, nguyên tắc hoặc phẩm giá cá nhân).',
    examples: [
      {
        chinese: '他宁可自己多吃点儿苦，也绝不给别人添麻烦。',
        pinyin: 'Tā nìngkě zìjǐ duō chī diǎnr kǔ, yě jué bù gěi biérén tiān máfan.',
        translation_vi: 'Anh ấy thà rằng bản thân chịu khổ thêm một chút, chứ quyết không gây phiền hà cho người khác.',
        explanation: '"宁可...也绝不..." thể hiện phẩm chất tự trọng cao, sẵn sàng chịu vất vả vì tập thể.'
      },
      {
        chinese: '我们宁可在前期调研中多花时间，也不能盲目上马未经论证的项目。',
        pinyin: 'Wǒmen nìngkě zài qiánqī diàoyán zhōng duō huā shíjiān, yě bù néng mángmù shàngmǎ wèijīng lùnzhèng de xiàngmù.',
        translation_vi: 'Chúng ta thà rằng dành nhiều thời gian hơn trong khâu khảo sát ban đầu, chứ không thể mù quáng triển khai dự án chưa qua kiểm định.',
        explanation: '"宁可...也不能..." nhấn mạnh nguyên tắc thận trọng khoa học trong quản lý dự án.'
      }
    ]
  },
  {
    order_index: 76,
    name: 'Cấu trúc lựa chọn thông minh ưu việt "与其...不如..." (Thà rằng... còn hơn / Thay vì... thì nên...)',
    pattern: '与其 + Phương án kém hiệu quả/thụ động, 不如 + Phương án sáng suốt/chủ động',
    category: 'Liên từ',
    explanation_vi: '"与其...不如..." (yǔqí... bùrú...) dùng để so sánh hai phương án giải quyết vấn đề, nhằm khuyên bảo hoặc quyết định từ bỏ phương án ở vế trước (thụ động, tốn công vô ích) để lựa chọn phương án ở vế sau (thông minh, tích cực và có lợi hơn nhiều).',
    examples: [
      {
        chinese: '与其坐在家里无谓地抱怨生活，不如站起来用行动改变现状。',
        pinyin: 'Yǔqí zuò zài jiālǐ wúwèi de bàoyuàn shēnghuó, bùrú zhàn qǐlái yòng xíngdòng gǎibiàn xiànzhuàng.',
        translation_vi: 'Thay vì ngồi ở nhà than vãn về cuộc sống một cách vô ích, thà rằng đứng dậy dùng hành động để thay đổi hiện trạng.',
        explanation: '"与其...不如..." khuyên đối phương chuyển hóa năng lượng tiêu cực thành hành động thiết thực.'
      },
      {
        chinese: '与其花大价钱买昂贵的补品，真不如平时养成规律作息的健康习惯。',
        pinyin: 'Yǔqí huā dà jiàqian mǎi ángguì de bǔpǐn, zhēn bùrú píngshí yǎngchéng guīlǜ zuòxī de jiànkāng xíguàn.',
        translation_vi: 'Thay vì bỏ số tiền lớn mua đồ bổ đắt đỏ, thật chẳng thà rèn luyện thói quen sinh hoạt điều độ hằng ngày.',
        explanation: '"与其...真不如..." so sánh sự vượt trội về giá trị của lối sống lành mạnh so với việc lạm dụng thực phẩm chức năng.'
      }
    ]
  },
  {
    order_index: 77,
    name: 'Cấu trúc điều kiện bắt buộc duy nhất "除非...否则..." (Trừ phi... nếu không...)',
    pattern: '除非 + Điều kiện tiên quyết duy nhất, 否则 / 不然 + Hậu quả tiêu cực tất yếu',
    category: 'Liên từ',
    explanation_vi: '"除非...否则..." (chúfēi... fǒuzé...) chỉ ra điều kiện duy nhất bắt buộc phải thực hiện để ngăn chặn một hậu quả xấu (trừ phi... nếu không thì). Vế "除非" đưa ra lối thoát duy nhất, vế "否则" nêu rõ kết cục không mong muốn nếu điều kiện đó không được đáp ứng.',
    examples: [
      {
        chinese: '除非双方都作出实质性的让步，否则这次和谈很难取得成功。',
        pinyin: 'Chúfēi shuāngfāng dōu zuòchū shízhìxìng de ràngbù, fǒuzé zhè cì hétán hěn nán qǔdé chénggōng.',
        translation_vi: 'Trừ phi cả hai bên đều đưa ra sự nhượng bộ thực chất, nếu không thì cuộc hòa đàm này rất khó giành được thành công.',
        explanation: '"除非...否则..." khẳng định sự nhượng bộ lẫn nhau là chìa khóa duy nhất cứu vãn cuộc đàm phán.'
      },
      {
        chinese: '除非你有医院开具的假条，否则这次缺席将被记作旷课。',
        pinyin: 'Chúfēi nǐ yǒu yīyuàn kāijù de jiàtiáo, fǒuzé zhè cì quēxí jiāng bèi jìzuò kuàngkè.',
        translation_vi: 'Trừ phi em có giấy xin phép nghỉ của bệnh viện cấp, nếu không buổi vắng mặt này sẽ bị tính là trốn học.',
        explanation: '"除非...否则..." nêu rõ quy chế quản lý điểm danh học đường nghiêm khắc.'
      }
    ]
  },
  {
    order_index: 78,
    name: 'Cấu trúc lựa chọn loại trừ nhị phân "要么...要么..." (Hoặc là... hoặc là...)',
    pattern: '要么 + Phương án A, 要么 + Phương án B (buộc chọn 1 trong 2)',
    category: 'Liên từ',
    explanation_vi: '"要么...要么..." (yàome... yàome...) đưa ra hai phương án loại trừ lẫn nhau, bắt buộc chủ thể chỉ được chọn một trong hai chứ không thể cùng lúc thực hiện cả hai hoặc không chọn phương án nào (hoặc là... hoặc là).',
    examples: [
      {
        chinese: '面对严峻的考验，我们要么勇敢向前冲，要么被竞争彻底淘汰。',
        pinyin: 'Miànduì yánjùn de kǎoyàn, wǒmen yàome yǒnggǎn xiàng qián chōng, yàome bèi jìngzhēng chèdǐ táotài.',
        translation_vi: 'Đối mặt với thử thách gay gắt, chúng ta hoặc là dũng cảm xông về phía trước, hoặc là bị quy luật cạnh tranh đào thải hoàn toàn.',
        explanation: '"要么...要么..." đặt ra thế trận bắt buộc phải chiến đấu sinh tồn trong môi trường cạnh tranh.'
      },
      {
        chinese: '放假期间，他要么在图书馆静心读书，要么去健身房锻炼身体。',
        pinyin: 'Fàngjià qījiān, tā yàome zài túshūguǎn jìngxīn dúshū, yàome qù jiànshēnfáng duànliàn shēntǐ.',
        translation_vi: 'Trong suốt kỳ nghỉ, cậu ấy hoặc là ở trong thư viện tĩnh tâm đọc sách, hoặc là đến phòng gym rèn luyện thân thể.',
        explanation: '"要么...要么..." liệt kê hai hoạt động giải trí lành mạnh duy nhất được luân phiên chọn lựa.'
      }
    ]
  }
];
