// ==============================================================================
// DATA: data_hsk5_grammar_part3.mjs
// HSK 5 GRAMMAR - PART 3: ĐIỂM 57 ĐẾN 84 (CHUẨN GF 0025-2021 APPENDIX A)
// Liên từ đa tầng, Cặp từ nối logic chính luận & Hệ thống biểu đạt Mục đích - Hệ quả HSK 5
// ==============================================================================

export const HSK5_GRAMMAR_PART3 = [
  {
    order_index: 57,
    name: 'Cấu trúc phản đề phủ định tăng tiến "不仅不...反而..." (Chẳng những không... trái lại còn...)',
    pattern: 'Chủ ngữ + 不仅不 / 不但没 + Hành động mong đợi, 反而 + Hành động/Kết quả trái ngược',
    category: 'Liên từ',
    explanation_vi: '"不仅不...反而..." (bùjǐn bù... fǎn\'ér...) kết hợp quan hệ tăng tiến và phản đề: vế trước phủ định việc hành vi thông thường hay kỳ vọng diễn ra, vế sau dùng "反而" để đẩy kết quả sang chiều hướng hoàn toàn đối lập với dự đoán hoặc gây bất ngờ lớn (chẳng những không... mà trái lại còn...).',
    examples: [
      {
        chinese: '面对大家的诚恳批评，他不仅不虚心接受，反而蛮不讲理地大发雷霆。',
        pinyin: 'Miànduì dàjiā de chéngkěn pīpíng, tā bùjǐn bù xūxīn jiēshòu, fǎn\'ér mánbùjiǎnglǐ de dàfāléitíng.',
        translation_vi: 'Đối mặt với lời phê bình chân thành của mọi người, anh ta chẳng những không khiêm tốn tiếp thu, mà trái lại còn vô lý nổi trận lôi đình.',
        explanation: '"不仅不虚心接受，反而..." làm nổi bật thái độ ngang ngược trái ngược hoàn toàn với tinh thần cầu thị.'
      },
      {
        chinese: '受到对手的故意挑衅后，他不仅没有慌乱，反而冷静沉着地打出了制胜一球。',
        pinyin: 'Shòudào duìshǒu de gùyì tiǎoxìn hòu, tā bùjǐn méiyǒu huāngluàn, fǎn\'ér lěngjìng chénzhuó de dǎchū le zhìshèng yì qiú.',
        translation_vi: 'Sau khi bị đối thủ cố ý khiêu khích, anh ấy chẳng những không hề rối loạn, mà trái lại còn bình tĩnh điềm đạm đánh ra cú bóng quyết định chiến thắng.',
        explanation: '"不仅没有...反而..." tôn vinh bản lĩnh thép kiên cường trước sự khiêu khích trên sân đấu.'
      }
    ]
  },
  {
    order_index: 58,
    name: 'Liên từ tăng tiến nâng cao bậc hành động "进而" (Tiến thêm một bước / Hơn thế nữa)',
    pattern: 'Hành động cấp 1, 进而 + Hành động cấp 2 (sâu hơn, rộng hơn hoặc đạt mục tiêu cao hơn)',
    category: 'Liên từ',
    explanation_vi: '"进而" (jìn\'ér) là liên từ chính luận cao cấp nối hai hành động hoặc giai đoạn phát triển, trong đó hành động ở vế sau dựa trên cơ sở của vế trước để tiến thêm một bước sâu hơn, quy mô lớn hơn hoặc đạt tới tầm cao mới (từ đó tiến tới, hơn thế nữa). Khác với "从而" (chỉ kết quả tự nhiên), "进而" nhấn mạnh sự nỗ lực chủ động tiến cấp.',
    examples: [
      {
        chinese: '我们要先掌握扎实的理论基础知识，进而培养独立分析和解决复杂问题的科研能力。',
        pinyin: 'Wǒmen yào xiān zhǎowò zhāshi de lǐlùn jīchǔ zhīshi, jìn\'ér péiyǎng dúlì fēnxī hé jiějué fùzá wèntí de kēyán nénglì.',
        translation_vi: 'Chúng ta cần nắm vững kiến thức nền tảng lý luận vững chắc trước, từ đó tiến tới bồi dưỡng năng lực nghiên cứu khoa học độc lập phân tích và giải quyết vấn đề phức tạp.',
        explanation: '"进而培养..." thể hiện bước tiến nâng cấp từ tích lũy kiến thức cơ bản lên năng lực sáng tạo đỉnh cao.'
      },
      {
        chinese: '企业通过并购地方龙头品牌打开了区域销路，进而实现了进军全国大市场的战略宏图。',
        pinyin: 'Qǐyè tōngguò bìnggòu dìfāng lóngtóu pǐnpái dǎkāi le qūyù xiāolù, jìn\'ér shíxiàn le jìnjūn quánguó dà shìchǎng de zhànlüè hóngtú.',
        translation_vi: 'Doanh nghiệp thông qua việc sáp nhập thương hiệu đầu ngành địa phương đã mở toang đầu ra tiêu thụ theo vùng, từ đó tiến tới hiện thực hóa đại đồ chiến lược tiến quân vào thị trường lớn cả nước.',
        explanation: '"进而实现了..." miêu tả bước nhảy vọt quy mô thị trường từ phạm vi địa phương sang toàn quốc.'
      }
    ]
  },
  {
    order_index: 59,
    name: 'Liên từ chỉ chuỗi thời gian tuần tự của sự kiện "继而" (Tiếp đó / Sau đó không lâu)',
    pattern: 'Sự kiện 1 phát sinh, 继而 + Sự kiện 2 nối tiếp',
    category: 'Liên từ',
    explanation_vi: '"继而" (jì\'ér) là liên từ biểu thị quan hệ thời gian nối tiếp chặt chẽ: một sự việc hoặc hiện tượng xảy ra xong, tiếp liền sau đó phát sinh một sự việc khác (tiếp đó, nối tiếp theo sau). Khác với "进而" (tăng tiến về chất và mức độ), "继而" thuần túy chỉ thứ tự trước sau về mặt thời gian.',
    examples: [
      {
        chinese: '天空中先是响起了沉闷的雷声，继而下起了瓢泼大雨。',
        pinyin: 'Tiānkōng zhōng xiān shì xiǎngqǐ le chénmèn de léishēng, jì\'ér xiàqǐ le piáopō dàyǔ.',
        translation_vi: 'Trên bầu trời thoạt tiên vang lên tiếng sấm rền trầm đục, tiếp đó đổ xuống trận mưa rào như trút nước.',
        explanation: '"先是...继而..." diễn tả thứ tự thời gian tự nhiên: tiếng sấm dội trước rồi cơn mưa ập đến ngay sau đó.'
      },
      {
        chinese: '双方最初只是在学术观点上产生口角争执，继而演变成了激烈的言语人身攻击。',
        pinyin: 'Shuāngfāng zuìchū zhǐshì zài xuéshù guāndiǎn shang chǎnshēng kǒujiǎo zhēngzhí, jì\'ér yǎnbiàn chéng le jīliè de yányǔ rénshēn gōngjī.',
        translation_vi: 'Đôi bên ban đầu chỉ là cãi vã đôi co về quan điểm học thuật, tiếp đó đã biến tướng thành những lời công kích cá nhân gay gắt.',
        explanation: '"继而演变..." ghi nhận sự biến tướng leo thang nối tiếp nhau của mâu thuẫn giao tiếp.'
      }
    ]
  },
  {
    order_index: 60,
    name: 'Phân biệt chuẩn xác cặp liên từ học thuật: "进而" vs "继而"',
    pattern: '进而 (Tăng tiến bản chất/bước tiến sâu hơn) vs 继而 (Nối tiếp tuần tự thời gian)',
    category: 'Liên từ',
    explanation_vi: 'Điểm mấu chốt để phân biệt: 1) "进而" (jìn\'ér) biểu thị quan hệ tăng tiến (遞進): bước sau sâu sắc hơn, có chủ đích phát triển nâng cao hơn bước trước; 2) "继而" (jì\'ér) biểu thị quan hệ nối tiếp thời gian (承接): sự việc sau xảy ra liền kề sau sự việc trước theo dòng thời gian, không nhất thiết có ý nghĩa nâng cao về chất.',
    examples: [
      {
        chinese: '我们先调查掌握了第一手事实，进而深入剖析了问题的根源。',
        pinyin: 'Wǒmen xiān diàochá zhǎowò le dìyīshǒu shìshí, jìn\'ér shēnrù pōuxī le wèntí de gēnyuán.',
        translation_vi: 'Chúng tôi trước hết điều tra nắm vững sự thật đầu tay, từ đó tiến thêm một bước mổ xẻ sâu sắc nguồn cơn của vấn đề.',
        explanation: '"进而深入剖析" thể hiện bước tiến nhận thức sâu sắc hơn từ việc thu thập dữ liệu thô sang phân tích bản chất.'
      },
      {
        chinese: '人群中首先传出低微的啜泣声，继而演化为全场悲痛的痛哭。',
        pinyin: 'Rénqún zhōng shǒuxiān chuánchū dīwēi de chuòqì shēng, jì\'ér yǎnhuà wéi quánchǎng bēitòng de tòngkū.',
        translation_vi: 'Trong đám đông trước tiên phát ra tiếng khóc thút thít nghẹn ngào, tiếp đó biến thành tiếng khóc than bi thương của toàn hội trường.',
        explanation: '"继而演化..." miêu tả sự lan truyền nối tiếp của âm thanh tiếng khóc theo trình tự thời gian.'
      }
    ]
  },
  {
    order_index: 61,
    name: 'Liên từ giả thiết trang trọng văn ngôn "假使" (Giả sử / Ví bằng)',
    pattern: '假使 + Tình huống giả định, (那么) 主语 + Cũng/Sẽ + Kết quả',
    category: 'Liên từ',
    explanation_vi: '"假使" (jiǎshǐ) là liên từ giả thiết cao cấp tương đương với "如果" hoặc "假如", nhưng mang sắc thái trang nghiêm, triết luận và đậm tính học thuật văn học cổ điển (giả sử như, ví phỏng). Thường dùng khi đặt ra các giả thiết logic để phản biện hoặc chứng minh một chân lý.',
    examples: [
      {
        chinese: '假使世界上没有了阳光和水源，一切生命都将彻底失去生存的可能。',
        pinyin: 'Jiǎshǐ shìjiè shang méiyǒu le yángguāng hé shuǐyuán, yíqiè shēngmìng dōu jiāng chèdǐ shīqù shēngcún de kěnéng.',
        translation_vi: 'Giả sử trên thế giới không còn ánh nắng và nguồn nước, toàn bộ sinh linh đều sẽ mất đi hoàn toàn khả năng sinh tồn.',
        explanation: '"假使...都将..." đặt ra giả thiết triết học cực đoan nhằm khẳng định vai trò sống còn của thiên nhiên.'
      },
      {
        chinese: '假使当初我们没有坚持核心技术的自主研发，今天势必会处处受制于人。',
        pinyin: 'Jiǎshǐ dāngchū wǒmen méiyǒu jiānchí héxīn jìshù de zìzhǔ yánfā, jīntiān shìbì huì chùchù shòuzhìyúrén.',
        translation_vi: 'Ví phỏng thuở ban đầu chúng ta không kiên trì tự chủ nghiên cứu phát triển công nghệ cốt lõi, ngày hôm nay ắt hẳn sẽ nơi nơi đều bị người khác kìm kẹp.',
        explanation: '"假使...势必..." nhìn lại quyết định lịch sử đúng đắn cứu doanh nghiệp khỏi sự phụ thuộc.'
      }
    ]
  },
  {
    order_index: 62,
    name: 'Liên từ giả thiết giàu sắc thái văn học "倘若" (Nếu như / Ví thử)',
    pattern: '倘若 + Giả thiết giàu cảm xúc, 主语 + 便 / 就 + Kết quả',
    category: 'Liên từ',
    explanation_vi: '"倘若" (tǎngruò) là liên từ giả định văn học tao nhã tương đương với "要是" hoặc "如果", thường xuất hiện trong các tác phẩm văn xuôi, tùy bút, hoặc những lập luận giàu chất thơ và triết lý nhân sinh (ví thử, nếu như mà). Vế sau thường kết hợp với "便" hoặc "就".',
    examples: [
      {
        chinese: '人生倘若没有崇高的追求与梦想，生活便会沦为一片乏味的荒漠。',
        pinyin: 'Rénshēng tǎngruò méiyǒu chónggāo de zhuīqiú yǔ mèngxiǎng, shēnghuó biàn huì lúnwéi yí piàn fáwèi de huāngmò.',
        translation_vi: 'Đời người ví thử không có những hoài bão và ước mơ cao đẹp, cuộc sống ắt sẽ biến thành một sa mạc cằn cỗi nhạt nhẽo.',
        explanation: '"倘若...便会..." là cấu trúc giả thiết nhân sinh giàu chất thơ so sánh cuộc sống với hoang mạc.'
      },
      {
        chinese: '倘若明天天气晴朗无风，我们便可如期扬帆起航前往海岛写生。',
        pinyin: 'Tǎngruò míngtiān tiānqì qínglǎng wú fēng, wǒmen biàn kě rúqī yángfān qǐháng qiánwǎng hǎidǎo xiěshēng.',
        translation_vi: 'Nếu như ngày mai tiết trời quang đãng không gió, chúng ta liền có thể giương buồm ra khơi tới hòn đảo vẽ ký họa đúng như dự định.',
        explanation: '"倘若...便可..." dùng giả thiết tao nhã trong câu chuyện du ngoạn nghệ thuật.'
      }
    ]
  },
  {
    order_index: 63,
    name: 'Liên từ phản thực tế biết ơn hoặc tiếc nuối "要不是" (Nếu không nhờ / Nếu không vì)',
    pattern: '要不是 + Yếu tố cứu cánh/cản trở, 主语 + 早就 / 已经 + Hậu quả xấu / Kết quả khác',
    category: 'Liên từ',
    explanation_vi: '"要不是" (yàobúshì) là liên từ biểu thị điều kiện phản thực tế (counterfactual): trên thực tế điều đó ĐÃ xảy ra hoặc ĐÃ có mặt, nhưng người nói giả định tình huống ngược lại "nếu như không có nó thì sự việc đã dẫn tới hậu quả hoàn toàn khác" (nếu không nhờ có, nếu không vì). Thường dùng để bày tỏ sự cảm ơn sâu sắc hoặc niềm tiếc nuối.',
    examples: [
      {
        chinese: '今天路上要不是交警同志及时疏通引导，我肯定赶不上这趟国际航班了。',
        pinyin: 'Jīntiān lùshang yàobúshì jiāojǐng tóngzhì jíshí shūtōng yǐndǎo, wǒ kěndìng gǎnbushàng zhè tàng guójì hángbān le.',
        translation_vi: 'Hôm nay trên đường nếu không nhờ có đồng chí cảnh sát giao thông kịp thời phân luồng chỉ dẫn, tôi chắc chắn đã không kịp chuyến bay quốc tế này rồi.',
        explanation: '"要不是...肯定赶不上..." bày tỏ lòng biết ơn sâu sắc đối với sự hỗ trợ của cảnh sát giao thông.'
      },
      {
        chinese: '要不是突如其来的伤病困扰，这位天才射手本可以在本届世界杯上大放异彩。',
        pinyin: 'Yàobúshì tūrúqílái de shāngbìng kùnrǎo, zhè wèi tiāncái shèshǒu běn kěyǐ zài běn jiè shìjièbēi shang dàfàngyìcǎi.',
        translation_vi: 'Nếu không vì chấn thương bất ngờ ập đến quấy rầy, tay săn bàn thiên tài này vốn dĩ đã có thể tỏa sáng rực rỡ tại kỳ World Cup lần này.',
        explanation: '"要不是...本可以..." bày tỏ niềm tiếc nuối vô hạn cho sự nghiệp của vận động viên tài năng.'
      }
    ]
  },
  {
    order_index: 64,
    name: 'Liên từ mục đích phòng ngừa hậu quả xấu "以免" (Để tránh / Kẻo)',
    pattern: 'Biện pháp phòng ngừa tích cực, 以免 + Hậu quả tiêu cực phát sinh',
    category: 'Liên từ',
    explanation_vi: '"以免" (yǐmiǎn) là liên từ chỉ mục đích trong văn viết, đứng ở vế sau để nêu ra một kết quả xấu hoặc tình huống bất lợi mà người nói muốn ngăn ngừa, phòng tránh (để tránh, kẻo). Vế trước luôn là một hành động, biện pháp cẩn trọng được tiến hành chủ động.',
    examples: [
      {
        chinese: '请大家在离开实验室前仔细关好水电设备，以免发生火灾等安全事故。',
        pinyin: 'Qǐng dàjiā zài líkāi shíyànshì qián zǐxì guān hǎo shuǐdiàn shèbèi, yǐmiǎn fāshēng huǒzāi děng ānquán shìgù.',
        translation_vi: 'Xin mọi người trước khi rời phòng thí nghiệm hãy tắt cẩn thận các thiết bị điện nước, để tránh xảy ra sự cố an toàn hỏa hoạn.',
        explanation: '"以免发生火灾" nêu rõ mục đích an toàn của hành động kiểm tra thiết bị trước khi ra về.'
      },
      {
        chinese: '重要文件请务必保存在云端并备份，以免因电脑硬盘损坏而丢失数据。',
        pinyin: 'Zhòngyào wénjiàn qǐng wùbì bǎocún zài yúnduān bìng bèifèn, yǐmiǎn yīn diànnǎo yìngpán sǔnhuài ér diūshī shùjù.',
        translation_vi: 'Tài liệu quan trọng xin hãy nhớ lưu trữ trên đám mây và sao lưu dự phòng, kẻo mất dữ liệu do ổ cứng máy tính bị hỏng hóc.',
        explanation: '"以免...丢失数据" chỉ rõ rủi ro mất tài liệu cần phòng ngừa bằng giải pháp sao lưu đám mây.'
      }
    ]
  },
  {
    order_index: 65,
    name: 'Liên từ khẩu ngữ phòng ngừa phiền toái "免得" (Để đỡ phải / Kẻo mà)',
    pattern: 'Hành vi chuẩn bị trước, 免得 + Phiền hà / Rắc rối phát sinh',
    category: 'Liên từ',
    explanation_vi: '"免得" (miǎnde) là dạng khẩu ngữ sinh động của "以免", mang ý nghĩa làm trước một việc chu đáo để sau này đỡ phải tốn công giải quyết phiền toái, rắc rối (để đỡ phải, kẻo mà).',
    examples: [
      {
        chinese: '明天去露营你最好多带一件厚外套，免得晚上山顶起风着凉感冒。',
        pinyin: 'Míngtiān qù lùyíng nǐ zuì hǎo duō dài yí jiàn hòu wàitào, miǎnde wǎnshang shāndǐng qǐfēng zháoliáng gǎnmào.',
        translation_vi: 'Ngày mai đi cắm trại cậu tốt nhất hãy mang thêm một chiếc áo khoác dày, để đỡ bị nhiễm lạnh cảm cúm khi đỉnh núi nổi gió về đêm.',
        explanation: '"免得...着凉感冒" nhắc nhở người bạn mang thêm áo ấm phòng ngừa bị ốm khi đi chơi xa.'
      },
      {
        chinese: '出门前把钥匙和门禁卡放进固定口袋里，免得到处翻找耽误时间。',
        pinyin: 'Chūmén qián bǎ yàoshi hé ménjìnkǎ fàngjìn gùdìng kǒudài lǐ, miǎnde dàochù fānzhǎo dānwù shíjiān.',
        translation_vi: 'Trước khi ra khỏi nhà hãy cất chìa khóa và thẻ từ vào túi cố định, để khỏi phải lục lọi khắp nơi làm lỡ dở thời gian.',
        explanation: '"免得到处翻找" khuyên nhủ thói quen ngăn nắp để tránh lãng phí thời gian tìm kiếm.'
      }
    ]
  },
  {
    order_index: 66,
    name: 'Liên từ tiết kiệm công sức và chi phí "省得" (Để đỡ / Đỡ tốn công / Khỏi phải)',
    pattern: 'Lựa chọn phương án tiện lợi, 省得 + Tốn công/tốn tiền/mệt mỏi',
    category: 'Liên từ',
    explanation_vi: '"省得" (shěngde) kết hợp chữ "省" (tiết kiệm, đỡ tốn) mang nghĩa "nhằm tránh phát sinh thêm chi phí, sức lực, thời gian hoặc sự mệt mỏi không cần thiết" (để đỡ tốn công, đỡ mất tiền, khỏi phải). Mang sắc thái khẩu ngữ dân dã, thực tế.',
    examples: [
      {
        chinese: '咱们今天就在手机上买好返程的高铁票吧，省得到时候火车站窗口排长队。',
        pinyin: 'Zánmen jīntiān jiù zài shǒujī shang mǎihǎo fǎnchéng de gāotiěpiào ba, shěngde dào shíhou huǒchēzhàn chuāngkǒu pái cháng duì.',
        translation_vi: 'Chúng ta hôm nay mua sẵn vé tàu cao tốc lượt về trên điện thoại luôn đi, để đỡ phải xếp hàng dài ở quầy vé nhà ga lúc đó.',
        explanation: '"省得到时候...排长队" giải thích lợi ích tiết kiệm thời gian chờ đợi nhờ mua vé online.'
      },
      {
        chinese: '有什么话当面一次性说清楚，省得日后大家在背地里互相猜疑。',
        pinyin: 'Yǒu shénme huà dāngmiàn yícìxìng shuō qīngchu, shěngde rìhòu dàjiā zài bèidìlǐ hùxiāng cāiyí.',
        translation_vi: 'Có chuyện gì hãy nói rõ ràng thẳng thắn một lần trước mặt nhau, để đỡ phải ngày sau mọi người nghi kỵ lẫn nhau sau lưng.',
        explanation: '"省得日后...互相猜疑" khuyên giải giao tiếp minh bạch để tránh mâu thuẫn nội bộ về sau.'
      }
    ]
  },
  {
    order_index: 67,
    name: 'Liên từ mục đích tạo thuận lợi tích cực "以便" (Để tiện / Nhằm tạo điều kiện)',
    pattern: 'Chuẩn bị điều kiện thuận lợi, 以便 + Hành vi tiếp theo tiến hành dễ dàng',
    category: 'Liên từ',
    explanation_vi: '"以便" (yǐbiàn) là liên từ mục đích tích cực trong văn bản hành chính, thương mại và giao dịch (kết hợp 以: để, 便: thuận tiện). Vế trước tạo ra tiền đề, cung cấp thông tin hoặc công cụ; vế sau dùng "以便" để chỉ rõ mục đích tạo sự dễ dàng, thuận lợi cho hành động tiếp theo (để tiện cho việc, nhằm giúp cho).',
    examples: [
      {
        chinese: '请各位参会代表务必在签到表上留下手机号，以便会务组随时通知最新议程。',
        pinyin: 'Qǐng gèwèi cānhuì dàibiǎo wùbì zài qiāndàobiǎo shang liúxià shǒujīhào, yǐbiàn huìwùzǔ suíshí tōngzhī zuìxīn yìchéng.',
        translation_vi: 'Xin các vị đại biểu tham dự hội nghị nhất thiết hãy để lại số điện thoại trên bảng điểm danh, để tiện cho ban tổ chức hội vụ thông báo lịch trình mới nhất bất cứ lúc nào.',
        explanation: '"以便会务组随时通知..." nêu rõ mục đích thu thập số điện thoại nhằm phục vụ liên lạc thông suốt.'
      },
      {
        chinese: '公司在官网上发布了详细的操作视频教程，以便新用户快速上手使用软件。',
        pinyin: 'Gōngsī zài guānwǎng shang fābù le xiángxì de cāozuò shìpín jiàochéng, yǐbiàn xīn yònghù kuàisù shàngshǒu shǐyòng ruǎnjiàn.',
        translation_vi: 'Công ty đã đăng tải video hướng dẫn thao tác chi tiết trên trang web chính thức, để người dùng mới tiện làm quen sử dụng phần mềm nhanh chóng.',
        explanation: '"以便新用户快速上手..." thể hiện tôn chỉ thiết kế dịch vụ hỗ trợ khách hàng thuận tiện.'
      }
    ]
  },
  {
    order_index: 68,
    name: 'Liên từ chỉ hệ quả tiêu cực nghiêm trọng "以致" (Dẫn đến / Gây ra hậu quả)',
    pattern: 'Nguyên nhân sai lầm/sơ suất, 以致(于) + Hậu quả xấu nghiêm trọng',
    category: 'Liên từ',
    explanation_vi: '"以致" (yǐzhì) là liên từ nối kết quả bắt buộc phải là một kết cục xấu, một thất bại, tổn thất hoặc tình huống đáng tiếc xảy ra do nguyên nhân ở vế trước gây nên (dẫn đến hậu quả, làm cho, đến nỗi). Tuyệt đối không dùng "以致" cho các kết quả tốt đẹp hay thành công.',
    examples: [
      {
        chinese: '项目负责人在前期论证中严重低估了施工难度，以致整个工程延期了半年之久。',
        pinyin: 'Xiàngmù fùzérén zài qiánqī lùnzhèng zhōng yánzhòng dīgū le shīgōng nándù, yǐzhì zhěng gè gōngchéng yánqī le bàn nián zhī jiǔ.',
        translation_vi: 'Người phụ trách dự án trong khâu kiểm định ban đầu đã đánh giá quá thấp độ khó thi công, dẫn đến toàn bộ công trình bị chậm tiến độ tới nửa năm ròng.',
        explanation: '"以致整个工程延期..." chỉ rõ hậu quả đình trệ công trình do sai lầm đánh giá chủ quan gây ra.'
      },
      {
        chinese: '他在平时工作中马虎大意屡教不改，以致酿成了一起重大的生产安全责任事故。',
        pinyin: 'Tā zài píngshí gōngzuò zhōng mǎhudàyì lǚjiàobùgǎi, yǐzhì niàngchéng le yì qǐ zhòngdà de shēngchǎn ānquán zérèn shìgù.',
        translation_vi: 'Anh ta trong công việc hằng ngày làm việc cẩu thả nhắc nhở mãi không sửa, đến nỗi đã gây ra một vụ tai nạn trách nhiệm an toàn sản xuất nghiêm trọng.',
        explanation: '"以致酿成了...事故" liên kết tính cẩu thả với hậu quả tai nạn lao động đau lòng.'
      }
    ]
  },
  {
    order_index: 69,
    name: 'Liên từ chỉ mức độ cực đại hoặc phạm vi phát triển "以至 / 以至于" (Đến mức / Đến nỗi / Cho tới tận)',
    pattern: 'Mức độ tăng cao, 以至(于) + Đạt tới mức độ phi thường / Mở rộng phạm vi',
    category: 'Liên từ',
    explanation_vi: '"以至" hoặc "以至于" (yǐzhìyú) biểu thị mức độ, số lượng, thời gian hoặc phạm vi sự vật phát triển sâu rộng, mở rộng liên tục cho tới khi đạt tới một mốc giới hạn phi thường nào đó (đến mức mà, cho tới tận). Kết quả sau "以至" có thể là trung tính, tích cực hoặc tiêu cực.',
    examples: [
      {
        chinese: '这本历史小说的人物塑造极其生动，以至于读者们常常把虚构人物当作真人。',
        pinyin: 'Zhè běn lìshǐ xiǎoshuō de rénwù sùzào jíqí shēngdòng, yǐzhìyú dúzhěmen chángcháng bǎ xūgòu rénwù dàngzuò zhēnrén.',
        translation_vi: 'Việc xây dựng nhân vật của cuốn tiểu thuyết lịch sử này sống động đến mức độc giả thường coi nhân vật hư cấu như người thật ngoài đời.',
        explanation: '"以至于读者们常常..." ca ngợi bút pháp khắc họa nhân vật đạt tới đỉnh cao nghệ thuật lôi cuốn.'
      },
      {
        chinese: '现代数字技术已经深度渗透到工业、农业、以至普通百姓日常生活的方方面面。',
        pinyin: 'Xiàndài shùzì jìshù yǐjīng shēndù shèntòu dào gōngyè, nóngyè, yǐzhì pǔtōng bǎixìng rìcháng shēnghuó de fāngfāngmiànmiàn.',
        translation_vi: 'Công nghệ số hiện đại đã thâm nhập sâu rộng vào công nghiệp, nông nghiệp, cho tới tận mọi ngóc ngách đời sống thường nhật của người dân bình thường.',
        explanation: '"以至..." mở rộng phạm vi ứng dụng từ các ngành sản xuất lớn đến tận đời sống sinh hoạt dân sinh.'
      }
    ]
  },
  {
    order_index: 70,
    name: 'Phân biệt kinh điển chuẩn mực thi cử: "以致" vs "以至 / 以至于"',
    pattern: '以致 (Chỉ dùng cho Hậu quả xấu/thất bại) vs 以至/以至于 (Chỉ Mức độ cực hạn hoặc Mở rộng phạm vi)',
    category: 'Liên từ',
    explanation_vi: 'Quy tắc phân biệt vàng trong HSK 5: 1) "以致" (chữ 致 mang nghĩa dẫn tới hậu quả) CHỈ DÙNG khi vế sau là kết cục tiêu cực, sai sót, thất bại, tổn hại (không bao giờ dùng cho điều tốt); 2) "以至 / 以至于" (chữ 至 mang nghĩa đạt tới mốc) dùng khi biểu thị sự nâng cao về mức độ (đến mức mà...) hoặc sự nối dài về phạm vi thời gian, không gian, đối tượng (từ A đến B cho tới tận C).',
    examples: [
      {
        chinese: '因为准备工作极其充分，以至于整个发布会进行得异常顺利。',
        pinyin: 'Yīnwèi zhǔnbèi gōngzuò jíqí chōngfèn, yǐzhìyú zhěng gè fābùhuì jìnxíng de yìcháng shùnlì.',
        translation_vi: 'Bởi vì công tác chuẩn bị cực kỳ chu đáo, đến mức toàn bộ buổi họp báo diễn ra suôn sẻ lạ thường.',
        explanation: 'Kết quả tốt đẹp ("顺利") bắt buộc phải dùng "以至于", tuyệt đối không được dùng "以致".'
      },
      {
        chinese: '司机疲劳驾驶注意力涣散，以致车辆失控撞上了路边的护栏。',
        pinyin: 'Sījī píláo jiàshǐ zhùyìlì huànsàn, yǐzhì chēliàng shīkòng zhuàngshàng le lùbiān de hùlán.',
        translation_vi: 'Tài xế lái xe trong tình trạng mệt mỏi mất tập trung, dẫn đến chiếc xe mất lái đâm vào dải phân cách ven đường.',
        explanation: 'Hậu quả tai nạn giao thông nghiêm trọng bắt buộc dùng "以致".'
      }
    ]
  },
  {
    order_index: 71,
    name: 'Cụm liên từ suy luận logic từ hiện thực "既然如此" (Đã như vậy / Trong tình thế đó)',
    pattern: 'Sự thật đã được xác nhận. 既然如此, (那么) Chủ ngữ + Nên/Sẽ + Quyết định',
    category: 'Liên từ',
    explanation_vi: '"既然如此" (jìrán rúcǐ) là cụm liên từ độc lập đứng đầu câu, dùng khi một tình huống, thực tế hoặc quan điểm vừa được phân tích và cả hai bên đều đã công nhận tính xác thực của nó, từ đó dẫn ra kết luận hoặc quyết sách hợp lý tiếp theo (đã là như thế thì, trong bối cảnh đó).',
    examples: [
      {
        chinese: '双方在价格条款上已经无法达成一致，既然如此，我们不如暂时终止本次谈判。',
        pinyin: 'Shuāngfāng zài jiàgé tiáokuǎn shang yǐjīng wúfǎ dáchéng yízhì, jìrán rúcǐ, wǒmen bùrú zànshí zhōngzhǐ běn cì tánpàn.',
        translation_vi: 'Đôi bên trên điều khoản giá cả đã không thể đạt được sự nhất trí, đã như vậy, chúng ta chi bằng hãy tạm dừng cuộc đàm phán lần này lại.',
        explanation: '"既然如此" thừa nhận sự bế tắc trong đàm phán giá cả để đưa ra giải pháp tạm hoãn thông minh.'
      },
      {
        chinese: '天气预报显示暴风雪即将来临，既然如此，原定的登山拉练计划只能取消了。',
        pinyin: 'Tiānqì yùbào xiǎnshì bàofēngxuě jíjiāng láilín, jìrán rúcǐ, yuándìng de dēngshān lāliàn jìhuà zhǐ néng qǔxiāo le.',
        translation_vi: 'Dự báo thời tiết cho thấy bão tuyết sắp ập tới, đã là như vậy thì kế hoạch rèn luyện leo núi định sẵn chỉ đành phải hủy bỏ thôi.',
        explanation: '"既然如此" làm bản lề chuyển tiếp từ tin tức bão tuyết sang quyết định hủy chuyến đi an toàn.'
      }
    ]
  },
  {
    order_index: 72,
    name: 'Cấu trúc lựa chọn chủ quan tự nguyện "宁愿...也不..." (Thà rằng... chứ không...)',
    pattern: 'Chủ ngữ + 宁愿 + Phương án chịu khổ/hy sinh, 也不 / 决不 + Phương án vi phạm nhân cách',
    category: 'Liên từ',
    explanation_vi: '"宁愿...也不..." (nìngyuàn... yě bù...) tương tự như "宁可...也不...", nhưng nhấn mạnh hơn nữa ý chí chủ quan, nguyện vọng tha thiết từ đáy lòng của chủ thể (tự nguyện thà rằng chọn con đường gian nan, chứ quyết không chấp nhận điều trái với lương tâm).',
    examples: [
      {
        chinese: '老艺术家宁愿过着清贫的生活，也绝不肯为了迎合低俗市场而粗制滥造作品。',
        pinyin: 'Lǎo yìshùjiā nìngyuàn guòzhe qīngpín de shēnghuó, yě jué bù kěn wèile yínghé dīsú shìchǎng ér cūzhìlànzào zuòpǐn.',
        translation_vi: 'Người nghệ sĩ già thà rằng sống cuộc đời thanh bần, chứ quyết không chịu vì hùa theo thị hiếu thị trường tầm thường mà sản xuất tác phẩm cẩu thả bừa bãi.',
        explanation: '"宁愿...也绝不肯..." khắc họa khí tiết thanh cao và lương tâm sáng tạo của người làm nghệ thuật chân chính.'
      },
      {
        chinese: '很多年轻人宁愿留在大城市里承受巨大的竞争压力，也不愿意回到安逸的小县城。',
        pinyin: 'Hěn duō niánqīngrén nìngyuàn liú zài dà chéngshì lǐ chéngshòu jùdà de jìngzhēng yālì, yě bú yuànyì huídào ānyì de xiǎo xiànchéng.',
        translation_vi: 'Rất nhiều người trẻ thà rằng ở lại thành phố lớn chịu đựng áp lực cạnh tranh khổng lồ, chứ không cam lòng quay về thị trấn nhỏ an phận êm đềm.',
        explanation: '"宁愿...也不愿意..." phản ánh khát vọng vươn lên tìm kiếm cơ hội bứt phá của thanh niên hiện đại.'
      }
    ]
  },
  {
    order_index: 73,
    name: 'Cấu trúc định nghĩa chính xác bản chất "与其说...不如说..." (Thay vì nói là... đúng hơn là nói...)',
    pattern: '与其说 A, 不如说 B (B mới là cách mô tả chính xác thực chất của vấn đề)',
    category: 'Liên từ',
    explanation_vi: '"与其说...不如说..." (yǔqí shuō... bùrú shuō...) dùng để điều chỉnh lại cách hiểu hoặc cách diễn đạt chưa thật sự chuẩn xác về một sự việc: vế trước nêu cách nhìn bề ngoài thông thường (A), vế sau khẳng định cách nhìn (B) mới phản ánh đúng bản chất chân thực, sâu sắc nhất của sự vật.',
    examples: [
      {
        chinese: '这件精美的艺术品与其说是商品，不如说是一位民间大师倾注毕生心血的灵魂结晶。',
        pinyin: 'Zhè jiàn jīngměi de yìshùpǐn yǔqí shuō shì shāngpǐn, bùrú shuō shì yí wèi mínjiān dàshī qīngzhù bìshēng xīnxuè de línghún jiéjīng.',
        translation_vi: 'Tác phẩm nghệ thuật tinh xảo này thay vì nói là một món hàng hóa, đúng hơn nên nói là sự kết tinh tâm hồn mà một bậc thầy dân gian đã dồn trọn tâm huyết cả đời vào đó.',
        explanation: '"与其说是商品，不如说..." nâng tầm giá trị của tác phẩm từ góc độ thương mại lên tầm vóc kiệt tác văn hóa.'
      },
      {
        chinese: '这次团队的成功与其说是依靠好运气，不如说是全体成员多年默默坚持的必然结果。',
        pinyin: 'Zhè cì tuánduì de chénggōng yǔqí shuō shì yīkào hǎo yùnqi, bùrú shuō shì quántǐ chéngyuán duō nián mòmò jiānchí de bìrán jiéguǒ.',
        translation_vi: 'Thành công của đội ngũ lần này thay vì nói là nhờ vào vận may tốt, đúng hơn nên nói là kết quả tất yếu của sự kiên trì âm thầm suốt nhiều năm của toàn thể thành viên.',
        explanation: '"与其说是...不如说是..." bác bỏ yếu tố may rủi để khẳng định chân lý của sự khổ luyện bền bỉ.'
      }
    ]
  },
  {
    order_index: 74,
    name: 'Liên từ tăng tiến chính luận đa diện "不单...而且/并且..." (Không chỉ... mà còn...)',
    pattern: 'Chủ ngữ + 不单...而且 / 并且 / 甚至 + Vị ngữ',
    category: 'Liên từ',
    explanation_vi: '"不单" (bùdān) đồng nghĩa với "不仅" và "不但", nhưng trong văn phong HSK 5 thường xuất hiện trong các bài bình luận xã hội hoặc diễn thuyết kinh tế để liên kết các vế câu có tính chất bổ trợ đa chiều và nâng tầm tính chất của vấn đề.',
    examples: [
      {
        chinese: '这项教育改革不单关系到千家万户的切身利益，并且直接影响到国家未来人才的储备。',
        pinyin: 'Zhè xiàng jiàoyù gǎigé bùdān guānxì dào qiānjiāwànhù de qiēshēn lìyì, bìngqiě zhíjiē yǐngxiǎng dào guójiā wèilái réncái de chǔbèi.',
        translation_vi: 'Cuộc cải cách giáo dục này không chỉ liên quan tới lợi ích thiết thân của hàng vạn gia đình, mà còn trực tiếp ảnh hưởng tới nguồn dự trữ nhân tài tương lai của đất nước.',
        explanation: '"不单...并且..." nâng tầm ảnh hưởng từ cấp độ hộ gia đình lên quy mô chiến lược quốc gia.'
      },
      {
        chinese: '他待人接物不单谦虚有礼，并且在专业业务领域表现出了极高的领悟力。',
        pinyin: 'Tā dàirénjiēwù bùdān qiānxū yǒulǐ, bìngqiě zài zhuānyè yèwù lǐngyù biǎoxiàn chū le jí gāo de lǐngwùlì.',
        translation_vi: 'Anh ấy đối nhân xử thế không chỉ khiêm nhường lễ độ, mà còn thể hiện khả năng lĩnh hội cực kỳ cao trong lĩnh vực nghiệp vụ chuyên môn.',
        explanation: '"不单...并且..." ca ngợi toàn diện cả về phẩm chất đạo đức lẫn tài năng trí tuệ của nhân vật.'
      }
    ]
  },
  {
    order_index: 75,
    name: 'Cụm liên từ nối chuyển tiếp đoạn văn "不仅如此" (Chẳng những vậy / Không những thế)',
    pattern: 'Đoạn văn 1. 不仅如此, Đoạn văn 2 (bổ sung luận cứ/thành tựu tầng cao hơn)',
    category: 'Liên từ',
    explanation_vi: '"不仅如此" (bùjǐn rúcǐ) là cụm từ chuyển tiếp đoạn văn quan trọng bậc nhất trong văn nghị luận HSK 5. Nó đứng ở đầu câu hoặc đầu đoạn văn mới để tổng kết và thừa nhận toàn bộ thành tựu/hiện tượng ở đoạn trước, sau đó mở ra một tầng nghĩa còn quan trọng hoặc chấn động hơn nữa ở đoạn sau.',
    examples: [
      {
        chinese: '该项新技术大幅度提高了生产效率。不仅如此，它还彻底解决了高能耗污染的难题。',
        pinyin: 'Gāi xiàng xīn jìshù dàfúdù tígāo le shēngchǎn xiàolǜ. Bùjǐn rúcǐ, tā hái chèdǐ jiějué le gāo nénghào wūrǎn de nándí.',
        translation_vi: 'Công nghệ mới này đã nâng cao mạnh mẽ hiệu suất sản xuất. Chẳng những thế, nó còn giải quyết triệt để bài toán khó về ô nhiễm tiêu hao năng lượng cao.',
        explanation: '"不仅如此" chuyển tiếp mượt mà từ thành tựu năng suất sang cống hiến bảo vệ môi trường sinh thái.'
      },
      {
        chinese: '这位青年志愿者经常无偿献血。不仅如此，他还利用业余时间长期义务照顾社区里的孤寡老人。',
        pinyin: 'Zhè wèi qīngnián zhìyuànzhě jīngcháng wúcháng xiànxiè. Bùjǐn rúcǐ, tā hái lìyòng yèyú shíjiān chángqī yìwù zhàogù shèqū lǐ de gūguǎ lǎorén.',
        translation_vi: 'Chàng thanh niên tình nguyện viên này thường xuyên hiến máu nhân đạo miễn phí. Không những thế, anh còn tận dụng thời gian rảnh rỗi chăm sóc thiện nguyện lâu dài các cụ già neo đơn trong khu dân cư.',
        explanation: '"不仅如此" tôn vinh liên hoàn các nghĩa cử cao đẹp vì cộng đồng của tấm gương thanh niên tốt.'
      }
    ]
  },
  {
    order_index: 76,
    name: 'Cụm liên từ khẳng định quyết tâm tuyệt đối "无论如何" (Bất luận thế nào / Dù sao đi nữa)',
    pattern: '无论如何, 主语 + 都要 / 也不能 + Vị ngữ',
    category: 'Liên từ',
    explanation_vi: '"无论如何" (wúlùn rúhé) là cụm phó từ/liên từ đứng độc lập ở đầu câu hoặc trước động từ, biểu thị trong bất kỳ tình huống, điều kiện hoặc trước bất kỳ trở ngại nào đi chăng nữa thì một nghĩa vụ, nguyên tắc hoặc quyết tâm bắt buộc phải được thực hiện (dù thế nào đi nữa, bằng mọi giá).',
    examples: [
      {
        chinese: '这次任务事关重大，无论如何我们都要在明天天亮之前赶到指定地点集结。',
        pinyin: 'Zhè cì rènwu shìguān zhòngdà, wúlùn rúhé wǒmen dōu yào zài míngtiān tiānliàng zhīqián gǎndào zhǐdìng dìdiǎn jíjié.',
        translation_vi: 'Nhiệm vụ lần này vô cùng trọng đại, bất luận thế nào chúng ta cũng phải có mặt tập kết tại địa điểm chỉ định trước khi trời sáng mai.',
        explanation: '"无论如何...都要..." thể hiện mệnh lệnh quân sự khẩn cấp bắt buộc phải hoàn thành đúng giờ bằng mọi giá.'
      },
      {
        chinese: '无论如何，你都绝不能把这一份涉及客户核心商业隐私的数据泄露出去。',
        pinyin: 'Wúlùn rúhé, nǐ dōu jué bù néng bǎ zhè yí fèn shèjí kèhù héxīn shāngyè yǐnsī de shùjù xièlòu chūqù.',
        translation_vi: 'Dù trong bất kỳ hoàn cảnh nào, cậu cũng tuyệt đối không được để lộ phần dữ liệu liên quan tới bí mật thương mại cốt lõi của khách hàng này ra ngoài.',
        explanation: '"无论如何...绝不能..." là lời răn đe nghiêm khắc về trách nhiệm bảo mật thông tin tối mật.'
      }
    ]
  },
  {
    order_index: 77,
    name: 'Cấu trúc giả thiết mốc thời khắc biến đổi "一旦...就..." (Một khi... thì...)',
    pattern: '一旦 + Thời khắc điều kiện kích hoạt, 主语 + 就 + Chuỗi hệ quả tất yếu',
    category: 'Liên từ',
    explanation_vi: '"一旦...就..." (yídàn... jiù...) dùng để chỉ ra một thời điểm hoặc điều kiện mang tính bước ngoặt: "một khi" sự việc đó xảy ra thì nó sẽ lập tức kích hoạt một chuỗi phản ứng hoặc hệ quả tất yếu khó lòng cứu vãn hoặc làm thay đổi hoàn toàn cục diện ban đầu.',
    examples: [
      {
        chinese: '信誉是企业的生命线，一旦失去客户的信任，想要重新建立就难如登天。',
        pinyin: 'Xìnyù shì qǐyè de shēngmìngxiàn, yídàn shīqù kèhù de xìnrèn, xiǎng yào chóngxīn jiànlì jiù nánrúdēngtiān.',
        translation_vi: 'Uy tín là sinh mệnh của doanh nghiệp, một khi đánh mất niềm tin của khách hàng thì muốn gầy dựng lại sẽ khó như lên trời.',
        explanation: '"一旦失去...就难如登天" cảnh báo cái giá quá đắt của việc đánh mất chữ tín thương trường.'
      },
      {
        chinese: '这项前沿技术一旦实现商业化量产，就将彻底颠覆现有的传统能源工业格局。',
        pinyin: 'Zhè xiàng qiányán jìshù yídàn shíxiàn shāngyèhuà liàngchǎn, jiù jiāng chèdǐ diānfù xiànyǒu de chuántǒng néngyuán gōngyè géjú.',
        translation_vi: 'Công nghệ tiên phong này một khi thực hiện được sản xuất thương mại hàng loạt thì sẽ đảo lộn hoàn toàn cục diện công nghiệp năng lượng truyền thống hiện có.',
        explanation: '"一旦实现...就将彻底颠覆..." dự báo bước ngoặt cách mạng công nghiệp khi công nghệ mới được thương mại hóa.'
      }
    ]
  },
  {
    order_index: 78,
    name: 'Cấu trúc quy nạp lập trường dứt khoát "不管...总之..." (Bất kể... tóm lại là...)',
    pattern: '不管 + Các tình huống giả thiết phức tạp, 总之 + Kết luận quy nạp cốt lõi',
    category: 'Liên từ',
    explanation_vi: '"不管...总之..." (bùguǎn... zǒngzhī...) dùng khi vế trước liệt kê hàng loạt các điều kiện hoặc khả năng có thể phát sinh, vế sau dùng "总之" để gạt bỏ các yếu tố rườm rà nhằm đưa ra một nguyên tắc, thái độ hoặc kết luận cốt lõi, bất biến duy nhất (bất kể thế nào, tóm lại là).',
    examples: [
      {
        chinese: '不管前方的道路有多少未知挑战，总之我们既然出发了就绝没有后退的道理。',
        pinyin: 'Bùguǎn qiánfāng de dàolù yǒu duōshao wèizhī tiǎozhàn, zǒngzhī wǒmen jìrán chūfā le jiù jué méiyǒu hòutuì de dàolǐ.',
        translation_vi: 'Bất kể con đường phía trước có bao nhiêu thử thách chưa biết, tóm lại chúng ta đã xuất phát rồi thì tuyệt đối không có đạo lý lùi bước.',
        explanation: '"不管...总之..." khẳng định ý chí quyết tâm sắt đá không hề lay chuyển trước khó khăn.'
      },
      {
        chinese: '不管别人在私底下如何议论，总之把自己的本职工作做好才是立足的根本。',
        pinyin: 'Bùguǎn biérén zài sīdǐxia rúhé yìlùn, zǒngzhī bǎ zìjǐ de běnzhí gōngzuò zuò hǎo cái shì lìzú de gēnběn.',
        translation_vi: 'Bất kể người khác bàn tán sau lưng như thế nào, tóm lại làm tốt công việc bổn phận của mình mới là gốc rễ để đứng vững.',
        explanation: '"总之..." đúc kết kinh nghiệm sống thực tế: tập trung vào chuyên môn thay vì bận tâm thị phi bên ngoài.'
      }
    ]
  },
  {
    order_index: 79,
    name: 'Cấu trúc điều kiện duy nhất văn ngôn trang nghiêm "唯有...方能..." (Duy chỉ có... mới có thể...)',
    pattern: '唯有 + Con đường/Điều kiện tiên quyết duy nhất, 方能 + Đạt được thành tựu vĩ đại',
    category: 'Liên từ',
    explanation_vi: '"唯有...方能..." (wéiyǒu... fāngnéng...) là cấu trúc văn ngôn cao cấp tương đương với "只有...才能...", nhưng mang âm hưởng hùng tráng, nghiêm cẩn và triết lý sâu sắc (duy chỉ có... mới có thể). "唯" nghĩa là duy nhất; "方" nghĩa là mới (cái). Thường xuất hiện trong các bài phát biểu nguyên thủ, tuyên ngôn lý tưởng.',
    examples: [
      {
        chinese: '唯有勇于直面自身的不足并坚持改革创新，一个民族方能始终屹立于世界民族之林。',
        pinyin: 'Wéiyǒu yǒngyú zhímiàn zìshēn de bùzú bìng jiānchí gǎigé chuàngxīn, yí gè mínzú fāngnéng shǐzhōng yìlì yú shìjiè mínzú zhī lín.',
        translation_vi: 'Duy chỉ có dũng cảm đối mặt với những thiếu sót của bản thân và kiên trì đổi mới sáng tạo, một dân tộc mới có thể luôn luôn đứng vững hiên ngang trong hàng ngũ các dân tộc trên thế giới.',
        explanation: '"唯有...方能..." diễn đạt tư tưởng chính trị tầm vóc lịch sử về sức sống trường tồn của một quốc gia.'
      },
      {
        chinese: '唯有经历过狂风暴雨的无情洗礼，雄鹰方能展翅翱翔于高远的天际。',
        pinyin: 'Wéiyǒu jīnglìguo kuángfēngbàoyǔ de wúqíng xǐlǐ, xióngyīng fāngnéng zhǎnchì áoxiáng yú gāoyuǎn de tiānjì.',
        translation_vi: 'Duy chỉ có trải qua sự tôi luyện gội rửa không tình cảm của mưa giông bão táp, chim ưng mới có thể tung cánh chao lượn trên bầu trời cao rộng.',
        explanation: '"唯有...方能..." dùng hình tượng chim ưng vượt qua bão táp làm ẩn dụ cho sự thành tài qua gian khó.'
      }
    ]
  },
  {
    order_index: 80,
    name: 'Cấu trúc thừa nhận hai thuộc tính song hành "固然...也..." (Đành rằng... nhưng cũng...)',
    pattern: 'Khía cạnh A 固然... (hợp lý), (但是) Khía cạnh B 也... (không thể xem nhẹ)',
    category: 'Liên từ',
    explanation_vi: '"固然...也..." (gùrán... yě...) biểu thị sự thừa nhận một phương diện khách quan là có thật hoặc hợp lý, đồng thời khẳng định phương diện còn lại cũng tồn tại song hành và quan trọng không kém (đành rằng như thế, nhưng cái kia cũng...). Dùng để lập luận biện chứng tránh sự phiến diện.',
    examples: [
      {
        chinese: '追求经济效益固然必不可少，但维护生态平衡也绝不容丝毫懈怠。',
        pinyin: 'Zhuīqiú jīngjì xiàoyì gùrán bìbùkěshǎo, dàn wéihù shēngtài pínghéng yě jué bùróng sīháo xièdài.',
        translation_vi: 'Mưu cầu lợi ích kinh tế đành rằng là điều tất yếu không thể thiếu, nhưng bảo vệ cân bằng sinh thái cũng tuyệt đối không cho phép buông lỏng lơ là mảy may.',
        explanation: '"固然...也..." cân bằng hài hòa giữa bài toán phát triển kinh tế và bảo vệ môi trường tự nhiên.'
      },
      {
        chinese: '严格的管理规章固然能够保障工作秩序，但充满人文关怀的沟通也同样必不可少。',
        pinyin: 'Yángé de guǎnlǐ guīzhāng gùrán nénggòu bǎozhàng gōngzuò zhìxù, dàn chōngmǎn rénwén guānhuái de gōutōng yě tóngyàng bìbùkěshǎo.',
        translation_vi: 'Quy chế quản lý nghiêm ngặt đành rằng có thể bảo đảm trật tự làm việc, nhưng sự giao tiếp chan chứa tình cảm quan tâm con người cũng cần thiết không kém.',
        explanation: '"固然...也..." kết hợp nghệ thuật quản lý giữa kỷ cương thép và tình yêu thương.'
      }
    ]
  },
  {
    order_index: 81,
    name: 'Cụm liên từ chính sách tổng kết bối cảnh "有鉴于此" (Nhận thấy điều đó / Xét thấy tình hình này)',
    pattern: 'Phân tích bối cảnh/nguy cơ. 有鉴于此, Cơ quan/Chủ thể + Quyết định đưa ra giải pháp',
    category: 'Liên từ',
    explanation_vi: '"有鉴于此" (yǒu jiàn yú cǐ) là cụm liên từ hành chính cao cấp đứng đầu câu kết luận, có nghĩa là "sau khi đã xem xét và đánh giá đầy đủ tình hình/nguy cơ vừa nêu ở trên, xuất phát từ thực tế đó". Đây là cấu trúc tiêu chuẩn mở đầu cho các nghị quyết hoặc phương án xử lý khủng hoảng.',
    examples: [
      {
        chinese: '近期网络诈骗手段不断翻新且隐蔽性极高。有鉴于此，公安部门紧急升级了反诈预警系统。',
        pinyin: 'Jìnqī wǎngluò zhàpiàn shǒuduàn búduàn fānxīn qiě yǐnbìxìng jí gāo. Yǒujiànyúcǐ, gōng\'ān bùmén jǐnjí shēngjí le fǎnzhà yùjǐng xìtǒng.',
        translation_vi: 'Thời gian gần đây thủ đoạn lừa đảo qua mạng liên tục biến tướng và có tính ẩn giấu cực kỳ cao. Nhận thấy tình hình đó, cơ quan công an đã khẩn cấp nâng cấp hệ thống cảnh báo chống lừa đảo.',
        explanation: '"有鉴于此" là mắt xích liên kết giữa thủ đoạn tội phạm tinh vi với giải pháp kỹ thuật nâng cấp an ninh.'
      },
      {
        chinese: '老龄化社会的到来对医疗照护体系提出了全新挑战。有鉴于此，市政府出台了居家养老补贴政策。',
        pinyin: 'Lǎolínghuà shèhuì de dàolái duì yīliáo zhàohù tǐxì tíchū le quánxīn tiǎozhàn. Yǒujiànyúcǐ, shì zhèngfǔ chūtái le jūjiā yǎnglǎo bǔtiē zhèngcè.',
        translation_vi: 'Sự xuất hiện của xã hội già hóa dân số đã đặt ra thách thức hoàn toàn mới cho hệ thống chăm sóc y tế. Xét thấy điều đó, chính quyền thành phố đã ban hành chính sách trợ cấp dưỡng lão tại nhà.',
        explanation: '"有鉴于此" giải thích căn cứ thực tiễn để chính quyền ban hành quyết sách phúc lợi an sinh xã hội.'
      }
    ]
  },
  {
    order_index: 82,
    name: 'Cấu trúc song song nâng cao với thành ngữ 4 chữ "既...又..."',
    pattern: 'Chủ ngữ + 既 + Thành ngữ 4 chữ/Cụm từ cao cấp + 又 + Thành ngữ 4 chữ song hành',
    category: 'Liên từ',
    explanation_vi: 'Ở trình độ HSK 5, cấu trúc "既...又..." (jì... yòu...) không chỉ kết hợp các tính từ đơn giản mà thường ghép đôi hai thành ngữ bốn chữ đối xứng hoặc hai cụm động tân trừu tượng để biểu thị hai phẩm chất, tính năng hoặc trạng thái cùng hội tụ một cách hoàn mỹ.',
    examples: [
      {
        chinese: '这栋现代建筑既保留了中国古典园林的古朴典雅，又展现了国际前沿设计的简洁明快。',
        pinyin: 'Zhè dòng xiàndài jiànzhù jì bǎoliú le Zhōngguó gǔdiǎn yuánlín de gǔpǔ diǎnyǎ, yòu zhǎnxiàn le guójì qiányán shèjì de jiǎnjié míngkuài.',
        translation_vi: 'Tòa kiến trúc hiện đại này vừa bảo lưu nét cổ phác thanh nhã của hoa viên cổ điển Trung Hoa, lại vừa thể hiện sự tinh gọn sáng sủa của thiết kế tiên phong quốc tế.',
        explanation: '"既保留...又展现..." kết hợp đối xứng hoàn mỹ giữa giá trị truyền thống và ngôn ngữ thiết kế đương đại.'
      },
      {
        chinese: '他在会议上的即兴发言既高屋建瓴，又紧密联系基层实际，博得了阵阵热烈喝彩。',
        pinyin: 'Tā zài huìyì shang de jíxìng fāyán jì gāowūjiànlíng, yòu jǐnmì liánxì jīcéng shíjì, bódé le zhènzhèn rèliè hècǎi.',
        translation_vi: 'Bài phát biểu ngẫu hứng của ông tại cuộc họp vừa mang tầm nhìn chiến lược bao quát cao độ, lại vừa gắn bó mật thiết với thực tiễn cơ sở, đã nhận được từng tràng hoan nghênh nhiệt liệt.',
        explanation: '"既高屋建瓴，又紧密联系..." ca ngợi tài năng hùng biện vừa có chiều sâu vĩ mô vừa sát sườn thực tiễn.'
      }
    ]
  },
  {
    order_index: 83,
    name: 'Cấu trúc liên từ dẫn ra ngoại lệ duy nhất "除了...以外, 唯独..."',
    pattern: '除了...以外, 唯独 + Đối tượng đặc biệt + Vị ngữ khác biệt',
    category: 'Liên từ',
    explanation_vi: '"唯独" (wéidú) mang nghĩa "duy nhất, chỉ riêng một mình đối tượng đó". Khi kết hợp với "除了...以外" tạo thành cấu trúc nêu bật đối tượng cá biệt có hành vi hoặc trạng thái hoàn toàn khác với tập thể còn lại.',
    examples: [
      {
        chinese: '全班同学都积极踊跃地报名参加了这次志愿者活动，唯独他借口身体不适拒绝参加。',
        pinyin: 'Quán bān tóngxué dōu jījí yǒngyuè de bàomíng cānjiā le zhè cì zhìyuànzhě huódòng, wéidú tā jièkǒu shēntǐ búlì jùjué cānjiā.',
        translation_vi: 'Toàn thể học sinh trong lớp đều hăng hái nhiệt tình đăng ký tham gia hoạt động tình nguyện lần này, duy chỉ có anh ta viện cớ người không khỏe từ chối tham gia.',
        explanation: '"唯独他..." tách biệt cá nhân có thái độ thiếu tích cực khỏi phong trào tập thể sôi nổi.'
      },
      {
        chinese: '柜子里摆满了各种精致的现代工艺品，唯独这枚古朴的怀表是爷爷亲手传给他的传家宝。',
        pinyin: 'Guìzi lǐ bǎimǎn le gè zhǒng jīngzhì de xiàndài gōngyìpǐn, wéidú zhè méi gǔpǔ de huáibiǎo shì yéye qīnshǒu chuángěi tā de chuánjiābǎo.',
        translation_vi: 'Trong tủ bày đầy đủ loại đồ thủ công mỹ nghệ hiện đại tinh xảo, duy chỉ có chiếc đồng hồ quả quýt cổ kính này là bảo vật gia truyền mà ông nội đích thân trao lại cho anh.',
        explanation: '"唯独这枚怀表" làm nổi bật giá trị tinh thần thiêng liêng độc nhất của kỷ vật gia đình.'
      }
    ]
  },
  {
    order_index: 84,
    name: 'Cấu trúc phủ định tương phản tuyệt đối "决非...而是..." (Tuyệt không phải... mà là...)',
    pattern: 'Chủ ngữ + 决非 / 绝非 + Nguyên nhân/Bản chất sai lầm, 而是 + Bản chất đích thực',
    category: 'Liên từ',
    explanation_vi: '"决非...而是..." (juéfēi... érshì...) là cấu trúc phản biện chính luận mạnh mẽ: vế trước dùng "决非" (tuyệt đối không phải là) để bác bỏ dứt khoát một quan niệm lệch lạc hoặc một ngộ nhận sai lầm, vế sau dùng "而是" để khẳng định chân lý bản chất thực sự của sự vật.',
    examples: [
      {
        chinese: '我们今天所取得的巨大飞跃决非凭空而来的奇迹，而是几代科研人员前赴后继艰苦奋斗的结晶。',
        pinyin: 'Wǒmen jīntiān suǒ qǔdé de jùdà fēiyuè juéfēi píngkōng\'érlái de qíjì, érshì jǐ dài kēyán rényuán qiánfùhòujì jiānkǔ fèndòu de jiéjīng.',
        translation_vi: 'Bước nhảy vọt to lớn mà chúng ta đạt được ngày hôm nay tuyệt không phải là phép màu từ trên trời rơi xuống, mà là sự kết tinh của sự phấn đấu gian khổ lớp này nối tiếp lớp khác của nhiều thế hệ cán bộ khoa học.',
        explanation: '"决非...而是..." bác bỏ tư tưởng ỷ lại vào may mắn để tôn vinh sự hy sinh xương máu của các nhà khoa học.'
      },
      {
        chinese: '他提出这套严格的规章制度决非故意为难员工，而是为了防患于未然确保生产绝对安全。',
        pinyin: 'Tā tíchū zhè tào yángé de guīzhāng zhìdù juéfēi gùyì wéinán yuángōng, érshì wèile fánghuànyúwèirán quèbǎo shēngchǎn juéduì ānquán.',
        translation_vi: 'Ông ấy đề xuất bộ nội quy chế tài nghiêm ngặt này tuyệt không phải là cố tình làm khó nhân viên, mà là để phòng ngừa rủi ro từ trong trứng nước, bảo đảm an toàn sản xuất tuyệt đối.',
        explanation: '"决非故意为难...而是为了..." giải tỏa định kiến của cấp dưới về sự khắt khe của kỷ luật an toàn lao động.'
      }
    ]
  }
];
