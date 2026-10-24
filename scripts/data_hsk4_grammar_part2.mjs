// ==============================================================================
// DATA: data_hsk4_grammar_part2.mjs
// HSK 4 GRAMMAR - PART 2: ĐIỂM 27 ĐẾN 52 (CHUẨN GF 0025-2021 APPENDIX A)
// Hệ thống Phó từ HSK 4: Ngữ khí, Nhấn mạnh, Thời gian, Tần suất & Phương thức
// ==============================================================================

export const HSK4_GRAMMAR_PART2 = [
  {
    order_index: 27,
    name: 'Phó từ đích thân chủ thể "亲自" (Đích thân / Tự mình)',
    pattern: 'Chủ ngữ + 亲自 + Động từ (+ Tân ngữ)',
    category: 'Phó từ',
    explanation_vi: '"亲自" (qīnzì) biểu thị chính bản thân người đó (thường là cấp trên, bậc trưởng bối, hoặc người có vị trí quan trọng) trực tiếp tham gia hoặc thực hiện hành động, chứ không thông qua người khác hay trung gian ủy quyền.',
    examples: [
      {
        chinese: '为了表示对客人的尊敬，总经理亲自去机场迎接。',
        pinyin: 'Wèile biǎoshì duì kèrén de zūnjìng, zǒngjīnglǐ qīnzì qù jīchǎng yíngjiē.',
        translation_vi: 'Để thể hiện sự tôn trọng đối với khách quý, tổng giám đốc đã đích thân ra sân bay đón tiếp.',
        explanation: '"亲自" đứng trước "去机场迎接" nhấn mạnh sự trịnh trọng và tôn kính khi người lãnh đạo tự mình đi đón khách.'
      },
      {
        chinese: '这道特色菜是妈妈亲自下厨为我做的，味道格外鲜美。',
        pinyin: 'Zhè dào tèsè cài shì māma qīnzì xiàchú wèi wǒ zuò de, wèidào géwài xiānměi.',
        translation_vi: 'Món ăn đặc sản này là mẹ đích thân vào bếp nấu cho tôi, hương vị vô cùng thơm ngon.',
        explanation: '"亲自下厨" thể hiện tấm lòng yêu thương khi chính người mẹ tự tay nấu nướng.'
      }
    ]
  },
  {
    order_index: 28,
    name: 'Phó từ có chủ ý đặc biệt "特意" (Đặc biệt / Cố ý dành riêng)',
    pattern: 'Chủ ngữ + 特意 + Động từ (+ Tân ngữ)',
    category: 'Phó từ',
    explanation_vi: '"特意" (tèyì) biểu thị chủ thể có một mục đích cụ thể rõ ràng và dành riêng thời gian, công sức hoặc tâm huyết để thực hiện một việc gì đó (thường mang ý nghĩa tích cực, thể hiện sự quan tâm chu đáo).',
    examples: [
      {
        chinese: '今天是你的生日，我特意为你定做了一个精美的蛋糕。',
        pinyin: 'Jīntiān shì nǐ de shēngrì, wǒ tèyì wèi nǐ dìngzuò le yí gè jīngměi de dàngāo.',
        translation_vi: 'Hôm nay là sinh nhật cậu, mình đã đặc biệt đặt riêng cho cậu một chiếc bánh gato tinh xảo.',
        explanation: '"特意为你定做" biểu thị việc đặt bánh là hành động có chủ đích chu đáo dành riêng cho bạn nhân dịp sinh nhật.'
      },
      {
        chinese: '听说老朋友身体不适，他特意请假前去医院探望。',
        pinyin: 'Tīngshuō lǎopéngyou shēntǐ búlì, tā tèyì qǐngjià qiánqù yīyuàn tànwàng.',
        translation_vi: 'Nghe tin bạn cũ sức khỏe không tốt, anh ấy đã đặc biệt xin nghỉ phép để đến bệnh viện thăm hỏi.',
        explanation: '"特意请假" nhấn mạnh hành động xin nghỉ việc xuất phát từ sự trân trọng tình bạn.'
      }
    ]
  },
  {
    order_index: 29,
    name: 'Phó từ cố ý có chủ đích "故意" (Cố ý / Cố tình)',
    pattern: 'Chủ ngữ + 故意 + Động từ / 故意 + Làm ra hành động',
    category: 'Phó từ',
    explanation_vi: '"故意" (gùyì) biểu thị hành động được thực hiện có ý thức, có toan tính từ trước (thường dùng cho những hành vi tiêu cực, gây phiền hà, trêu chọc hoặc vi phạm quy định). Khác với "特意" (mang sắc thái chu đáo, tốt đẹp), "故意" thường dùng để phê phán hoặc thanh minh (như "我不是故意的" - tôi không cố tình).',
    examples: [
      {
        chinese: '对不起，刚才我不小心碰翻了水杯，我真的不是故意的。',
        pinyin: 'Duìbuqǐ, gāngcái wǒ bù xiǎoxīn pèngfān le shuǐbēi, wǒ zhēnde bú shì gùyì de.',
        translation_vi: 'Xin lỗi, vừa nãy tôi không cẩn thận va đổ cốc nước, tôi thực sự không phải cố ý đâu.',
        explanation: '"不是故意的" là câu xin lỗi kinh điển giải thích hành động xảy ra ngoài ý muốn sơ suất.'
      },
      {
        chinese: '他明明知道开会的时间，却故意迟到了半个小时。',
        pinyin: 'Tā míngmíng zhīdào kāihuì de shíjiān, què gùyì chídào le bàn gè xiǎoshí.',
        translation_vi: 'Anh ta rõ ràng biết thời gian họp, nhưng lại cố tình đến muộn nửa tiếng đồng hồ.',
        explanation: '"故意迟到" phê phán thái độ thiếu nghiêm túc biết rõ giờ giấc nhưng vẫn cố ý vi phạm.'
      }
    ]
  },
  {
    order_index: 30,
    name: 'Phó từ may mắn thoát nạn "幸亏" (May mà / May mắn thay)',
    pattern: '幸亏 + Mệnh đề may mắn, 要不然 / 否则 + Hậu quả xấu',
    category: 'Phó từ',
    explanation_vi: '"幸亏" (xìngkuī) dùng để biểu thị một tình huống thuận lợi hoặc sự trợ giúp kịp thời đã giúp tránh được một kết quả không mong muốn hoặc nguy hiểm nghiêm trọng (may mà, may mắn thay). Thường đi kèm với "要不然" hoặc "否则" ở vế sau để nêu ra hậu quả suýt xảy ra.',
    examples: [
      {
        chinese: '幸亏医生抢救及时，病人才脱离了生命危险。',
        pinyin: 'Xìngkuī yīshēng qiǎngjiù jíshí, bìngrén cái tuōlí le shēngmìng wēixiǎn.',
        translation_vi: 'May mà bác sĩ cấp cứu kịp thời, bệnh nhân mới qua khỏi cơn nguy kịch.',
        explanation: '"幸亏" chỉ điều kiện may mắn (bác sĩ cấp cứu kịp) đã ngăn chặn được hậu quả nguy hiểm đến tính mạng.'
      },
      {
        chinese: '今天出门幸亏带了雨伞，否则肯定会被淋成落汤鸡。',
        pinyin: 'Jīntiān chūmén xìngkuī dài le yǔsǎn, fǒuzé kěndìng huì bèi línchéng luòtāngjī.',
        translation_vi: 'Hôm nay ra khỏi nhà may mà mang theo ô, nếu không chắc chắn đã bị ướt như chuột lột.',
        explanation: 'Cấu trúc "幸亏...否则..." làm nổi bật sự may mắn nhờ mang ô tránh được cơn mưa rào.'
      }
    ]
  },
  {
    order_index: 31,
    name: 'Phó từ biểu thị điểm may mắn "好在" (May mà / Cũng may là)',
    pattern: '好在 + Tình hình tích cực / Mệnh đề 1, 好在 + Mệnh đề 2',
    category: 'Phó từ',
    explanation_vi: '"好在" (hǎozài) mang sắc thái khẩu ngữ tương tự "幸亏", biểu thị nhờ có một yếu tố thuận lợi mà giảm thiểu được rủi ro, tổn thất hoặc làm cho tình hình không đến mức quá tồi tệ (may ở chỗ, cũng may là).',
    examples: [
      {
        chinese: '路上遇到大堵车，好在面试地点就在地铁站旁边，我才没迟到。',
        pinyin: 'Lùshang yùdào dà dǔchē, hǎozài miànshì dìdiǎn jiù zài dìtiězhàn pángbiān, wǒ cái méi chídào.',
        translation_vi: 'Trên đường bị tắc xe nghiêm trọng, may mà địa điểm phỏng vấn nằm ngay cạnh ga tàu điện ngầm nên tôi mới không bị muộn.',
        explanation: '"好在" nêu ra yếu tố thuận lợi về vị trí địa lý cứu vãn tình thế tắc đường.'
      },
      {
        chinese: '昨晚风吹得很大，好在大家都把窗户关严了，没有造成什么损失。',
        pinyin: 'Zuówǎn fēng chuī de hěn dà, hǎozài dàjiā dōu bǎ chuānghu guānyán le, méiyǒu zàochéng shénme sǔnshī.',
        translation_vi: 'Đêm qua gió thổi rất to, may mà mọi người đều đóng chặt cửa sổ nên không gây ra thiệt hại gì.',
        explanation: '"好在" khẳng định sự phòng ngừa đúng đắn giúp giữ an toàn cho ngôi nhà.'
      }
    ]
  },
  {
    order_index: 32,
    name: 'Phó từ phỏng đoán kèm lo lắng "恐怕" (E rằng / Sợ rằng)',
    pattern: 'Chủ ngữ + 恐怕 + Vị ngữ / 恐怕 + Mệnh đề phỏng đoán',
    category: 'Phó từ',
    explanation_vi: '"恐怕" (kǒngpà) dùng để đưa ra ước đoán, nhận định về một khả năng có thể xảy ra trong tương lai, nhưng khả năng này thường không có lợi, gây thất vọng hoặc nằm ngoài ý muốn của người nói (e rằng, sợ rằng). Thường dùng để biểu đạt ý kiến một cách nhã nhặn, uyển chuyển.',
    examples: [
      {
        chinese: '现在的机票十分紧张，下周出发恐怕已经买不到票了。',
        pinyin: 'Xiànzài de jīpiào shífēn jǐnzhāng, xià zhōu chūfā kǒngpà yǐjīng mǎi bú dào piào le.',
        translation_vi: 'Hiện tại vé máy bay rất khan hiếm, tuần sau khởi hành e rằng đã không thể mua được vé nữa.',
        explanation: '"恐怕" giảm nhẹ giọng điệu từ chối hoặc đưa ra phỏng đoán bất lợi về việc hết vé.'
      },
      {
        chinese: '今天的工作量太大，仅靠他一个人恐怕很难按时完成。',
        pinyin: 'Jīntiān de gōngzuòliàng tài dà, jǐn kào tā yí gè rén kǒngpà hěn nán ànshí wánchéng.',
        translation_vi: 'Khối lượng công việc hôm nay quá lớn, chỉ dựa vào một mình anh ấy e rằng rất khó hoàn thành đúng hạn.',
        explanation: '"恐怕很难按时完成" đưa ra dự đoán e dè về tiến độ công việc nhằm đề xuất hỗ trợ.'
      }
    ]
  },
  {
    order_index: 33,
    name: 'Phó từ trớ trêu ngoài dự tính "偏偏" (Trớ trêu thay / Ngặt nỗi / Cứ khăng khăng)',
    pattern: 'Chủ ngữ + 偏偏 + Động từ / 偏偏 + Mệnh đề nghịch cảnh',
    category: 'Phó từ',
    explanation_vi: '"偏偏" (piānpiān) có hai cách dùng: 1) Diễn tả sự việc diễn ra hoàn toàn trái ngược với nguyện vọng, dự kiến trong hoàn cảnh trớ trêu (ngặt nỗi, oái oăm thay); 2) Biểu thị sự bướng bỉnh, khăng khăng làm một việc ngược lại với ý muốn của người khác.',
    examples: [
      {
        chinese: '今天我有非常重要的考试，偏偏早上闹钟坏了没有响。',
        pinyin: 'Jīntiān wǒ yǒu fēicháng zhòngyào de kǎoshì, piānpiān zǎoshang nàozhōng huài le méiyǒu xiǎng.',
        translation_vi: 'Hôm nay tôi có kỳ thi vô cùng quan trọng, trớ trêu thay sáng nay đồng hồ báo thức lại hỏng không kêu.',
        explanation: '"偏偏" thể hiện sự không may xảy ra đúng vào thời điểm quan trọng nhất.'
      },
      {
        chinese: '大家都劝他要冷静考虑，他偏偏不听，执意要辞职。',
        pinyin: 'Dàjiā dōu quàn tā yào lěngjìng kǎolǜ, tā piānpiān bù tīng, zhíyì yào cízhí.',
        translation_vi: 'Mọi người đều khuyên anh ấy nên suy nghĩ bình tĩnh, anh ấy cứ khăng khăng không nghe, nhất quyết đòi từ chức.',
        explanation: '"偏偏不听" diễn tả tính khí bướng bỉnh làm ngược lại lời khuyên bảo của mọi người.'
      }
    ]
  },
  {
    order_index: 34,
    name: 'Phó từ phản đề tương phản "反而" (Trái lại / Ngược lại)',
    pattern: 'Vế 1 (dự kiến/lẽ thường), Vế 2 (反而 + Động từ/Tính từ)',
    category: 'Phó từ',
    explanation_vi: '"反而" (fǎn\'ér) biểu thị kết quả của sự việc xảy ra hoàn toàn trái ngược với lẽ thường, quy luật tự nhiên hoặc dự đoán thông thường. Vế đầu nêu lý do hoặc tác động, vế sau dùng "反而" để nêu phản ứng trái ngược.',
    examples: [
      {
        chinese: '吃了药之后，他的头痛不仅没有减轻，反而更加厉害了。',
        pinyin: 'Chī le yào zhīhòu, tā de tóutòng bùjǐn méiyǒu jiǎnqīng, fǎn\'ér gèngjiā lìhai le.',
        translation_vi: 'Sau khi uống thuốc, chứng đau đầu của anh ấy chẳng những không thuyên giảm mà ngược lại càng dữ dội hơn.',
        explanation: '"反而更加厉害" biểu thị kết quả trái ngược hẳn với tác dụng kỳ vọng của việc uống thuốc.'
      },
      {
        chinese: '受到批评之后，他没有灰心，反而激发了更大的学习斗志。',
        pinyin: 'Shòudào pīpíng zhīhòu, tā méiyǒu huīxīn, fǎn\'ér jīfā le gèng dà de xuéxí dòuzhì.',
        translation_vi: 'Sau khi bị phê bình, anh ấy không nản lòng mà trái lại còn khơi dậy ý chí học tập mãnh liệt hơn.',
        explanation: '"反而" nhấn mạnh phản ứng tích cực bất ngờ vượt ngoài tâm lý chán nản thông thường.'
      }
    ]
  },
  {
    order_index: 35,
    name: 'Phó từ phản phục khẩu ngữ "反倒" (Trái lại / Ngược lại)',
    pattern: 'Vế trước, Chủ ngữ + 反倒 + Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"反倒" (fǎndào) đồng nghĩa với "反而", biểu thị sự chuyển ngoặt trái ngược với lẽ thường, thường dùng nhiều trong văn nói khẩu ngữ hoặc phong cách kể chuyện sinh động.',
    examples: [
      {
        chinese: '我本来是一片好心想去帮他，没想到他反倒嫌我多管闲事。',
        pinyin: 'Wǒ běnlái shì yí piàn hǎoxīn xiǎng qù bāng tā, méi xiǎngdào tā fǎndào xián wǒ duō guǎn xiánshì.',
        translation_vi: 'Tôi vốn mang tấm lòng tốt muốn đến giúp anh ta, không ngờ anh ta trái lại còn chê tôi lo chuyện bao đồng.',
        explanation: '"反倒嫌我多管闲事" thể hiện phản ứng bất ngờ, vô lý của đối phương đối với lòng tốt.'
      },
      {
        chinese: '年纪大的人每天睡得少，年轻人反倒经常觉得睡不够。',
        pinyin: 'Niánjì dà de rén měitiān shuì de shǎo, niánqīngrén fǎndào jīngcháng juéde shuì bú gòu.',
        translation_vi: 'Người lớn tuổi mỗi ngày ngủ ít, người trẻ tuổi ngược lại thường cảm thấy ngủ không đủ giấc.',
        explanation: '"反倒" nêu bật sự tương phản thú vị giữa thói quen giấc ngủ của hai thế hệ.'
      }
    ]
  },
  {
    order_index: 36,
    name: 'Phó từ phản vấn phủ định "何必" (Hà tất / Việc gì phải / Cần gì)',
    pattern: '何必 + Động từ / 何必 + Cụm từ + 呢',
    category: 'Phó từ',
    explanation_vi: '"何必" (hébì) dùng trong câu hỏi tu từ để biểu thị ý nghĩa không cần thiết phải làm một việc gì đó (hà tất, cần gì, việc gì phải thế). Thường dùng để khuyên nhủ, an ủi hoặc khuyên can đối phương bớt nóng giận, lo âu. Cuối câu thường có trợ từ ngữ khí "呢".',
    examples: [
      {
        chinese: '这不过是一件微不足道的小事，你何必为它发那么大脾气呢？',
        pinyin: 'Zhè búguò shì yí jiàn wēibùzúdào de xiǎoshì, nǐ hébì wèi tā fā nàme dà píqi ne?',
        translation_vi: 'Đây chẳng qua chỉ là một chuyện nhỏ không đáng kể, cậu hà tất phải nổi trận lôi đình vì nó làm gì chứ?',
        explanation: 'Cấu trúc "何必...呢" mang ngữ khí khuyên can đối phương không nên lãng phí cảm xúc giận dữ vì chuyện vặt vãnh.'
      },
      {
        chinese: '既然双方都有诚意合作，又何必在细节问题上寸步不让呢？',
        pinyin: 'Jìrán shuāngfāng dōu yǒu chéngyì hézuò, yòu hébì zài xìjié wèntí shang cùnbù bú ràng ne?',
        translation_vi: 'Đã đôi bên đều có thành ý hợp tác, vậy cần gì phải so đo từng bước ở những vấn đề tiểu tiết chứ?',
        explanation: '"何必" thúc đẩy sự nhượng bộ để đạt được đại cục hợp tác suôn sẻ.'
      }
    ]
  },
  {
    order_index: 37,
    name: 'Phó từ câu hỏi tu từ chất vấn "难道" (Lẽ nào / Chẳng lẽ)',
    pattern: '难道 + Chủ ngữ + Vị ngữ + 吗 / 难道 + Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"难道" (nándào) dùng trong câu hỏi tu từ để nhấn mạnh ngữ khí chất vấn hoặc phản bác mạnh mẽ (chẳng lẽ, lẽ nào). Nếu câu ở dạng khẳng định thì mang ý phủ định, và ngược lại nếu dùng phủ định (难道不...) thì biểu thị khẳng định mạnh mẽ.',
    examples: [
      {
        chinese: '这么简单的交通规则，难道你连这都不明白吗？',
        pinyin: 'Zhème jiǎndān de jiāotōng guīzé, nándào nǐ lián zhè dōu bù míngbai ma?',
        translation_vi: 'Quy tắc giao thông đơn giản như thế này, chẳng lẽ cậu ngay cả điều đó cũng không hiểu sao?',
        explanation: '"难道...吗" tăng cường sự trách cứ, chất vấn sự thiếu hiểu biết đối với quy tắc cơ bản.'
      },
      {
        chinese: '大家为这个项目付出了那么多心血，难道我们能轻易放弃吗？',
        pinyin: 'Dàjiā wèi zhè ge xiàngmù fùchū le nàme duō xīnxuè, nándào wǒmen néng qīngyì fàngqì ma?',
        translation_vi: 'Mọi người đã bỏ ra bao nhiêu tâm huyết vì dự án này, lẽ nào chúng ta lại có thể dễ dàng từ bỏ hay sao?',
        explanation: '"难道能轻易放弃吗" dùng câu hỏi tu từ để khẳng định tuyệt đối không thể bỏ cuộc.'
      }
    ]
  },
  {
    order_index: 38,
    name: 'Phó từ dứt khoát đưa ra giải pháp "索性" (Dứt khoát / Thà rằng / Thẳng thừng)',
    pattern: 'Chủ ngữ + 索性 + Động từ + Tân ngữ',
    category: 'Phó từ',
    explanation_vi: '"索性" (suǒxìng) biểu thị khi đối mặt với một tình huống khó xử, trì hoãn hoặc phiền phức, chủ thể dứt khoát đưa ra một quyết định triệt để, đơn giản hóa vấn đề mà không còn đắn đo suy nghĩ nữa.',
    examples: [
      {
        chinese: '外面的雨越下越大，车也打不到，我们索性在朋友家住了一晚。',
        pinyin: 'Wàimiàn de yǔ yuè xià yuè dà, chē yě dǎ bú dào, wǒmen suǒxìng zài péngyou jiā zhù le yì wǎn.',
        translation_vi: 'Mưa bên ngoài càng lúc càng to, xe cũng không gọi được, chúng tôi dứt khoát ở lại nhà bạn một đêm.',
        explanation: '"索性" thể hiện quyết định nhanh gọn ở lại qua đêm khi các phương án di chuyển đều bế tắc.'
      },
      {
        chinese: '既然这台电脑修起来费用那么高，他索性直接买了一台新的。',
        pinyin: 'Jìrán zhè tái diànnǎo xiū qǐlái fèiyong nàme gāo, tā suǒxìng zhíjiē mǎi le yì tái xīn de.',
        translation_vi: 'Đã chi phí sửa chiếc máy tính này cao đến thế, anh ấy thà rằng mua thẳng luôn một chiếc máy mới.',
        explanation: '"索性直接买新的" diễn tả sự dứt khoát thay mới thay vì tốn tiền sửa chữa máy cũ.'
      }
    ]
  },
  {
    order_index: 39,
    name: 'Phó từ kinh ngạc vượt ngoài mong đợi "居然" (Không ngờ / Lại)',
    pattern: 'Chủ ngữ + 居然 + Động từ / 居然 + Mệnh đề kinh ngạc',
    category: 'Phó từ',
    explanation_vi: '"居然" (jūrán) biểu thị sự việc xảy ra hoàn toàn bất ngờ, khác xa hoặc vượt quá hẳn dự tính thông thường (vậy mà, lại, không ngờ rằng). Thường mang sắc thái kinh ngạc, khâm phục hoặc bất ngờ trước một kết quả hiếm có.',
    examples: [
      {
        chinese: '他平时很少参加体育锻炼，这次居然跑了全班第一名。',
        pinyin: 'Tā píngshí hěn shǎo cānjiā tǐyù duànliàn, zhè cì jūrán pǎo le quán bān dì yī míng.',
        translation_vi: 'Bình thường anh ấy rất ít khi tập luyện thể thao, lần này không ngờ lại chạy về đích thứ nhất toàn lớp.',
        explanation: '"居然跑了第一名" nhấn mạnh sự ngạc nhiên tột cùng trước thành tích chạy đáng kinh ngạc.'
      },
      {
        chinese: '那对双胞胎姐妹分开生活了二十年，性格居然一模一样。',
        pinyin: 'Nà duì shuāngbāotāi jiěmèi fēnkāi shēnghuó le èrshí nián, xìnggé jūrán yìmúyíyàng.',
        translation_vi: 'Cặp chị em sinh đôi đó sống tách biệt suốt 20 năm, tính cách không ngờ lại giống hệt như đúc.',
        explanation: '"居然一模一样" thể hiện sự kỳ diệu và kinh ngạc trước sự tương đồng tính cách.'
      }
    ]
  },
  {
    order_index: 40,
    name: 'Phó từ ngoài ý muốn mạnh mẽ "竟然" (Lại / Không ngờ rằng)',
    pattern: 'Chủ ngữ + 竟然 + Động từ / Tính từ',
    category: 'Phó từ',
    explanation_vi: '"竟然" (jìngrán) mang ý nghĩa tương tự như "居然", chỉ sự việc xảy ra nằm ngoài dự kiến (không ngờ, lại). Tuy nhiên, "竟然" thường được dùng nhiều hơn trong các ngữ cảnh mang tính tiêu cực, phản cảm hoặc khó tin về mặt đạo đức/hành vi.',
    examples: [
      {
        chinese: '我一直把他当作最好的朋友，他竟然在背后说我的坏话。',
        pinyin: 'Wǒ yìzhí bǎ tā dàngzuò zuì hǎo de péngyou, tā jìngrán zài bèihòu shuō wǒ de huàihuà.',
        translation_vi: 'Tôi luôn coi anh ta là người bạn tốt nhất, anh ta thế mà lại nói xấu sau lưng tôi.',
        explanation: '"竟然在背后说坏话" thể hiện nỗi thất vọng và kinh ngạc trước sự phản bội của bạn bè.'
      },
      {
        chinese: '这项看起来非常复杂的任务，他竟然只用半天就完成了。',
        pinyin: 'Zhè xiàng kàn qǐlái fēicháng fùzá de rènwu, tā jìngrán zhǐ yòng bàn tiān jiù wánchéng le.',
        translation_vi: 'Nhiệm vụ trông có vẻ vô cùng phức tạp này, anh ấy thế mà chỉ dùng nửa ngày đã hoàn thành xong.',
        explanation: '"竟然只用半天" biểu thị sự thán phục trước tốc độ xử lý công việc thần tốc ngoài dự đoán.'
      }
    ]
  },
  {
    order_index: 41,
    name: 'Phó từ phán đoán căn cứ rõ ràng "显然" (Rõ ràng / Hiển nhiên)',
    pattern: '显然 + Mệnh đề / Chủ ngữ + 显然 + Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"显然" (xiǎnrán) dùng để khẳng định một sự việc, tình huống là hiển nhiên, dễ thấy, ai cũng có thể nhận ra mà không cần phải tranh cãi. Có thể đứng ở đầu câu làm trạng ngữ cho cả câu hoặc đứng trước vị ngữ.',
    examples: [
      {
        chinese: '从目前的谈判进展来看，对方显然缺乏足够的合作诚意。',
        pinyin: 'Cóng mùqián de tánpàn jìnzhǎn lái kàn, duìfāng xiǎnrán quēfá zúgòu de hézuò chéngyì.',
        translation_vi: 'Nhìn từ tiến trình đàm phán hiện tại, đối phương rõ ràng là thiếu thành ý hợp tác thỏa đáng.',
        explanation: '"显然缺乏" đưa ra nhận định dứt khoát dựa trên các dữ kiện thực tế của buổi đàm phán.'
      },
      {
        chinese: '这个问题显然没有大家想象的那么简单，需要深入研究。',
        pinyin: 'Zhè ge wèntí xiǎnrán méiyǒu dàjiā xiǎngxiàng de nàme jiǎndān, xūyào shēnrù yánjiū.',
        translation_vi: 'Vấn đề này hiển nhiên không đơn giản như mọi người tưởng tượng, cần phải nghiên cứu sâu hơn.',
        explanation: '"显然没有...那么简单" làm sáng tỏ bản chất phức tạp của vấn đề.'
      }
    ]
  },
  {
    order_index: 42,
    name: 'Phó từ đánh giá có phần quá đáng "未免" (Khó tránh / Hơi bị / Quá ư)',
    pattern: 'Chủ ngữ + 未免 + (太/有点儿) + Tính từ / Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"未免" (wèimiǎn) dùng để đưa ra lời nhận xét, đánh giá phê bình một cách tế nhị, cho rằng hành vi hoặc tình huống nào đó có phần hơi quá đáng, không thỏa đáng hoặc khó tránh khỏi bị chê trách (thật là hơi bị, khó tránh khỏi). Thường kết hợp với "太", "过分", "有点儿".',
    examples: [
      {
        chinese: '只因为一点小小的失误就开除员工，这样做未免太严厉了。',
        pinyin: 'Zhǐ yīnwèi yì diǎn xiǎoxiǎo de shīwù jiù kāichú yuángōng, zhèyàng zuò wèimiǎn tài yánlì le.',
        translation_vi: 'Chỉ vì một sơ suất nhỏ mà sa thải nhân viên, làm như vậy thật là có phần quá khắt khe.',
        explanation: '"未免太严厉了" phê bình mức độ xử phạt quá nặng nề so với tính chất của lỗi vi phạm.'
      },
      {
        chinese: '还没经过实地调查就下结论，这个决定未免有点儿草率。',
        pinyin: 'Hái méi jīngguò shídì diàochá jiù xià jiélùn, zhè ge juédìng wèimiǎn yǒudiǎnr cǎoshuài.',
        translation_vi: 'Còn chưa qua điều tra thực tế mà đã vội kết luận, quyết định này e là có phần hơi vội vàng hấp tấp.',
        explanation: '"未免有点儿草率" nhận xét một cách uyển chuyển về sự thiếu cẩn trọng trong quyết định.'
      }
    ]
  },
  {
    order_index: 43,
    name: 'Phó từ phủ định tuyệt đối không chút nào "毫无" (Mảy may không / Hoàn toàn không)',
    pattern: '毫无 + Danh từ song âm tiết (毫无疑问 / 毫无经验 / 毫无准备 / 毫无关系)',
    category: 'Phó từ',
    explanation_vi: '"毫无" (háowú) có nghĩa là mảy may không có, hoàn toàn không có một chút nào (毫 biểu thị đơn vị cực nhỏ; 无 là không có). "毫无" thường đi kèm trực tiếp với danh từ trừu tượng song âm tiết như 疑问, 意义, 价值, 准备, 关系, 经验.',
    examples: [
      {
        chinese: '凭借他在行业内的杰出贡献，获得这项荣誉是毫无疑问的。',
        pinyin: 'Píngjiè tā zài hángyè nèi de jiéchū gòngxiàn, huòdé zhè xiàng róngyù shì háowú yíwèn de.',
        translation_vi: 'Nhờ vào những cống hiến kiệt xuất của ông trong ngành, việc nhận được danh hiệu này là hoàn toàn không còn nghi ngờ gì nữa.',
        explanation: '"毫无疑问" là cụm từ cố định khẳng định tính xác thực 100% không thể bàn cãi.'
      },
      {
        chinese: '对于刚刚大学毕业的新人来说，他们对实际工作往往毫无经验。',
        pinyin: 'Duìyú gānggāng dàxué bìyè de xīnrén láishuō, tāmen duì shíjì gōngzuò wǎngwǎng háowú jīngyàn.',
        translation_vi: 'Đối với những người mới vừa tốt nghiệp đại học, họ đối với công việc thực tế thường hoàn toàn không có kinh nghiệm gì.',
        explanation: '"毫无经验" chỉ tình trạng thiếu hụt 100% kinh nghiệm thực chiến.'
      }
    ]
  },
  {
    order_index: 44,
    name: 'Phó từ lặp lại từ đầu "重新" (Lại từ đầu / Làm lại)',
    pattern: 'Chủ ngữ + 重新 + Động từ + Tân ngữ',
    category: 'Phó từ',
    explanation_vi: '"重新" (chóngxīn) biểu thị một hành động được thực hiện lại từ đầu, thường là sau khi gặp thất bại, sai sót, hoặc muốn có một khởi đầu mới với chất lượng tốt hơn. Khác với "又" (lặp lại tự nhiên) và "再" (lặp lại tiếp diễn), "重新" nhấn mạnh tính chất bắt đầu lại toàn bộ quy trình từ điểm xuất phát.',
    examples: [
      {
        chinese: '方案虽然被客户否定了，但我们大家有信心重新设计出一套新方案。',
        pinyin: 'Fāng\'àn suīrán bèi kèhù fǒudìng le, dàn wǒmen dàjiā yǒu xìnxīn chóngxīn shèjì chū yí tào xīn fāng\'àn.',
        translation_vi: 'Phương án tuy bị khách hàng từ chối, nhưng mọi người chúng tôi đều có niềm tin thiết kế lại từ đầu một bộ phương án mới.',
        explanation: '"重新设计" nhấn mạnh quá trình bắt tay làm lại từ vạch xuất phát.'
      },
      {
        chinese: '计算机死机之后，他只能按下电源键重新启动系统。',
        pinyin: 'Jìsuànjī sǐjī zhīhòu, tā zhǐ néng ànxià diànyuán jiàn chóngxīn qǐdòng xìtǒng.',
        translation_vi: 'Sau khi máy tính bị treo, anh ấy chỉ còn cách bấm nút nguồn để khởi động lại hệ thống.',
        explanation: '"重新启动" chỉ thao tác khởi động lại thiết bị từ trạng thái tắt.'
      }
    ]
  },
  {
    order_index: 45,
    name: 'Phó từ hành động lặng lẽ kín đáo "悄悄" (Lén lút / Lặng lẽ / Nhè nhẹ)',
    pattern: 'Chủ ngữ + 悄悄(地) + Động từ + Tân ngữ',
    category: 'Phó từ',
    explanation_vi: '"悄悄" (qiāoqiāo) diễn tả hành động được thực hiện một cách cực kỳ êm ái, yên ắng, không phát ra tiếng động, hoặc diễn ra kín đáo, lén lút để không làm kinh động đến người khác.',
    examples: [
      {
        chinese: '夜深了，孩子已经熟睡，妈妈悄悄地关上门走出了卧室。',
        pinyin: 'Yè shēn le, háizi yǐjīng shúshuì, māma qiāoqiāo de guānshàng mén zǒuchū le wòshì.',
        translation_vi: 'Đêm đã khuya, con đã ngủ say, người mẹ nhẹ nhàng đóng cửa bước ra khỏi phòng ngủ.',
        explanation: '"悄悄地关上门" diễn tả động tác khép cửa nhẹ nhàng để không làm thức giấc em bé.'
      },
      {
        chinese: '趁大家都在专注看比赛，他悄悄地溜出了会议室。',
        pinyin: 'Chèn dàjiā dōu zài zhuānzhù kàn bǐsài, tā qiāoqiāo de liūchū le huìyìshì.',
        translation_vi: 'Nhân lúc mọi người đang mải mê xem trận đấu, anh ta đã lén lút chuồn ra khỏi phòng họp.',
        explanation: '"悄悄地溜出" miêu tả hành vi rời đi bí mật không để người khác phát hiện.'
      }
    ]
  },
  {
    order_index: 46,
    name: 'Phó từ tiến hành theo trình tự bài bản "逐步" (Từng bước / Từng chặng)',
    pattern: 'Chủ ngữ + 逐步 + Động từ song âm tiết / 逐步 + Đạt được trạng thái',
    category: 'Phó từ',
    explanation_vi: '"逐步" (zhúbù) biểu thị sự việc tiến triển theo từng bước, từng giai đoạn có kế hoạch rõ ràng và có sự can thiệp của ý chí con người. Thường kết hợp với các động từ biến đổi như 提高, 完善, 落实, 改善.',
    examples: [
      {
        chinese: '随着经济的发展，人民的生活水平正在逐步提高。',
        pinyin: 'Suízhe jīngjì de fāzhǎn, rénmín de shēnghuó shuǐpíng zhèngzài zhúbù tígāo.',
        translation_vi: 'Cùng với sự phát triển của kinh tế, mức sống của nhân dân đang từng bước được nâng cao.',
        explanation: '"逐步提高" thể hiện sự cải thiện từng giai đoạn có định hướng trong đời sống người dân.'
      },
      {
        chinese: '学校将逐步完善各项规章制度，为师生创造更好的环境。',
        pinyin: 'Xuéxiào jiāng zhúbù wánshàn gè xiàng guīzhāng zhìdù, wèi shīshēng chuàngzào gèng hǎo de huánjìng.',
        translation_vi: 'Nhà trường sẽ từng bước hoàn thiện các nội quy quy chế, tạo môi trường tốt hơn cho thầy và trò.',
        explanation: '"逐步完善" chỉ tiến trình hoàn thiện thể chế theo từng bước kế hoạch.'
      }
    ]
  },
  {
    order_index: 47,
    name: 'Phó từ biến đổi tiệm tiến tự nhiên "逐渐" (Dần dần / Từ từ)',
    pattern: 'Chủ ngữ + 逐渐 + Động từ / Tính từ',
    category: 'Phó từ',
    explanation_vi: '"逐渐" (zhújiàn) biểu thị mức độ hoặc số lượng biến đổi dần dần theo thời gian, thường là diễn biến tự nhiên không phụ thuộc vào các bước kế hoạch cứng nhắc. So với "逐步", "逐渐" áp dụng rộng rãi hơn cho cả các hiện tượng tự nhiên và tâm lý con người.',
    examples: [
      {
        chinese: '春天来了，天气逐渐变暖，小草也渐渐露出了嫩绿的芽。',
        pinyin: 'Chūntiān lái le, tiānqì zhújiàn biàn nuǎn, xiǎocǎo yě jiànjiàn lùchū le nènlǜ de yá.',
        translation_vi: 'Mùa xuân đến rồi, thời tiết dần dần ấm lên, ngọn cỏ non cũng từ từ nhú mầm xanh biếc.',
        explanation: '"逐渐变暖" miêu tả sự ấm dần lên của khí hậu theo quy luật chuyển mùa tự nhiên.'
      },
      {
        chinese: '来到新城市生活几个月后，他逐渐适应了这里的生活节奏。',
        pinyin: 'Láidào xīn chéngshì shēnghuó jǐ gè yuè hòu, tā zhújiàn shìyìng le zhèlǐ de shēnghuó jiézòu.',
        translation_vi: 'Sau mấy tháng chuyển đến thành phố mới sinh sống, anh ấy đã dần dần thích nghi với nhịp sống nơi đây.',
        explanation: '"逐渐适应" chỉ quá trình hòa nhập tự nhiên qua thời gian.'
      }
    ]
  },
  {
    order_index: 48,
    name: 'Phó từ tổng quát hóa điều kiện "凡是" (Phàm là / Hễ là / Mọi)',
    pattern: '凡是 + Đối tượng/Điều kiện + 都 / 也 + Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"凡是" (fánshì) dùng ở đầu câu hoặc đầu vế câu để bao quát toàn bộ mọi thành viên hoặc sự vật nằm trong một phạm vi xác định (phàm là, hễ là, tất cả những ai/cái gì). Vế sau luôn đi kèm với phó từ "都" hoặc "也" để khẳng định tính phổ quát tuyệt đối.',
    examples: [
      {
        chinese: '凡是参加本次汉语比赛的选手，都可以获得一份精美的纪念品。',
        pinyin: 'Fánshì cānjiā běn cì hànyǔ bǐsài de xuǎnshǒu, dōu kěyǐ huòdé yí fèn jīngměi de jìnìanpǐn.',
        translation_vi: 'Phàm là thí sinh tham gia cuộc thi tiếng Hán lần này đều có thể nhận được một phần quà lưu niệm tinh xảo.',
        explanation: '"凡是...都..." xác định toàn bộ người tham gia cuộc thi đều có quyền lợi nhận quà.'
      },
      {
        chinese: '凡是符合国家规定的企业，都可以申请这项科技创新补贴。',
        pinyin: 'Fánshì fúhé guójiā guīdìng de qǐyè, dōu kěyǐ shēnqǐng zhè xiàng kējì chuàngxīn bǔtiē.',
        translation_vi: 'Hễ là doanh nghiệp phù hợp với quy định của nhà nước, đều có thể nộp hồ sơ xin khoản trợ cấp đổi mới khoa học kỹ thuật này.',
        explanation: '"凡是...都..." bao quát đối tượng đủ tiêu chuẩn theo quy định pháp lý.'
      }
    ]
  },
  {
    order_index: 49,
    name: 'Phó từ tác động qua lại "互相" (Lẫn nhau / Cùng nhau)',
    pattern: 'Chủ ngữ (số nhiều) + 互相 + Động từ song âm tiết',
    category: 'Phó từ',
    explanation_vi: '"互相" (hùxiāng) là phó từ biểu thị hành động qua lại hai chiều giữa các cá nhân hoặc các bên đối tác (lẫn nhau). Lưu ý: "互相" là phó từ nên chỉ làm trạng ngữ đứng trước động từ (thường là động từ song âm tiết như 帮助, 学习, 理解, 尊重), không thể trực tiếp làm chủ ngữ hay tân ngữ.',
    examples: [
      {
        chinese: '同学之间应该互相帮助，共同克服学习中遇到的困难。',
        pinyin: 'Tóngxué zhījiān yīnggāi hùxiāng bāngzhù, gòngtóng kèfú xuéxí zhōng yùdào de kùnnan.',
        translation_vi: 'Giữa các bạn học nên giúp đỡ lẫn nhau, cùng nhau khắc phục những khó khăn gặp phải trong học tập.',
        explanation: '"互相帮助" là trạng ngữ + động từ biểu thị mối quan hệ tương trợ hai chiều giữa học sinh.'
      },
      {
        chinese: '两国领导人就双边合作深入交换了意见，达成了互相理解。',
        pinyin: 'Liǎng guó lǐngdǎorén jiù shuāngbiān hézuò shēnrù jiāohuàn le yìjiàn, dáchéng le hùxiāng lǐjiě.',
        translation_vi: 'Lãnh đạo hai nước đã trao đổi ý kiến sâu rộng về hợp tác song phương, đạt được sự thấu hiểu lẫn nhau.',
        explanation: '"互相理解" chỉ sự hiểu biết và đồng thuận từ cả hai phía đối tác ngoại giao.'
      }
    ]
  },
  {
    order_index: 50,
    name: 'Phó từ kín đáo trong tâm lý "暗暗" (Thầm / Ngầm / Trong lòng)',
    pattern: 'Chủ ngữ + 暗暗 + (下决心 / 高兴 / 佩服 / 担心 / 努力)',
    category: 'Phó từ',
    explanation_vi: '"暗暗" (àn\'àn) biểu thị hoạt động tâm lý, cảm xúc hoặc nỗ lực diễn ra thầm kín bên trong lòng, không bộc lộ ra ngoài cho người khác thấy (ngầm, thầm, trong bụng). Thường kết hợp với các từ ngữ biểu thị tâm tư như 下决心, 庆祝, 佩服, 赞叹, 担忧.',
    examples: [
      {
        chinese: '听到自己被心仪的公司录取的喜讯，他心里暗暗高兴。',
        pinyin: 'Tīngdào zìjǐ bèi xīnyí de gōngsī lùqǔ de xǐxùn, tā xīnli àn\'àn gāoxìng.',
        translation_vi: 'Nghe được tin mừng mình đã được công ty mơ ước trúng tuyển, trong lòng anh ấy thầm mừng rỡ.',
        explanation: '"暗暗高兴" diễn tả niềm vui sướng âm thầm dâng trào trong nội tâm.'
      },
      {
        chinese: '面对强大的竞争对手，他在心底暗暗下定决心一定要全力以赴。',
        pinyin: 'Miànduì qiángdà de jìngzhēng duìshǒu, tā zài xīndǐ àn\'àn xiàdìng juéxīn yídìng yào quánlì yǐ fù.',
        translation_vi: 'Đối mặt với đối thủ cạnh tranh mạnh mẽ, anh ấy đã thầm hạ quyết tâm trong lòng nhất định phải dốc hết toàn lực.',
        explanation: '"暗暗下定决心" chỉ ý chí quyết tâm được nung nấu trong thâm tâm.'
      }
    ]
  },
  {
    order_index: 51,
    name: 'Phó từ kiên định xuyên suốt "始终" (Từ đầu đến cuối / Luôn luôn)',
    pattern: 'Chủ ngữ + 始终 + Phủ định/Khẳng định + Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"始终" (shǐzhōng) kết hợp chữ "始" (bắt đầu) và "终" (kết thúc), biểu thị một trạng thái, nguyên tắc hoặc hành vi duy trì liên tục từ đầu đến cuối không hề suy suyển hay thay đổi. Thường mang sắc thái tán thưởng ý chí kiên định hoặc miêu tả sự bế tắc kéo dài.',
    examples: [
      {
        chinese: '无论经历多少风雨，他始终保持着对科学探索的热情。',
        pinyin: 'Wúlùn jīnglì duōshao fēngyǔ, tā shǐzhōng bǎochízhe duì kēxué tànsuǒ de rèqíng.',
        translation_vi: 'Bất luận trải qua bao nhiêu phong ba, ông ấy luôn luôn giữ vững niềm nhiệt huyết đối với nghiên cứu khoa học.',
        explanation: '"始终保持着" nhấn mạnh tinh thần đam mê bất di bất dịch xuyên suốt nhiều năm tháng.'
      },
      {
        chinese: '对于这次事故的原因，相关责任部门始终没有给出合理的解释。',
        pinyin: 'Duìyú zhè cì shìgù de yuányīn, xiāngguān zérèn bùmén shǐzhōng méiyǒu gěichū hélǐ de jiěshì.',
        translation_vi: 'Đối với nguyên nhân của vụ tai nạn lần này, bộ phận chịu trách nhiệm liên quan từ đầu đến cuối vẫn chưa đưa ra lời giải thích thỏa đáng.',
        explanation: '"始终没有给出" phê phán sự né tránh trách nhiệm kéo dài liên tục.'
      }
    ]
  },
  {
    order_index: 52,
    name: 'Phó từ thời điểm linh hoạt bất định "随时" (Bất cứ lúc nào / Sẵn sàng mọi lúc)',
    pattern: 'Chủ ngữ + 随时 + Động từ + Tân ngữ',
    category: 'Phó từ',
    explanation_vi: '"随时" (suíshí) biểu thị một hành động hoặc trạng thái có thể xảy ra hoặc sẵn sàng thực hiện ở bất kỳ thời điểm nào, không bị gò bó bởi thời gian cụ thể (bất cứ khi nào, mọi lúc).',
    examples: [
      {
        chinese: '如果有任何问题，您可以随时通过微信或电话与我联系。',
        pinyin: 'Rúguǒ yǒu rènhé wèntí, nín kěyǐ suíshí tōngguò wēixìn huò diànhuà yǔ wǒ liánxì.',
        translation_vi: 'Nếu có bất kỳ câu hỏi nào, quý khách có thể liên hệ với tôi bất cứ lúc nào qua WeChat hoặc điện thoại.',
        explanation: '"随时...联系" là lời hẹn lịch thiệp thể hiện sự sẵn sàng hỗ trợ khách hàng 24/7.'
      },
      {
        chinese: '山区的气候多变，随时都可能下起倾盆大雨，出行需带好雨具。',
        pinyin: 'Shānqū de qìhòu duōbiàn, suíshí dōu kěnéng xiàqǐ qīngpén dàyǔ, chūxíng xū dài hǎo yǔjù.',
        translation_vi: 'Khí hậu vùng núi thay đổi thất thường, bất cứ lúc nào cũng có thể đổ mưa rào xối xả, đi lại cần mang sẵn đồ che mưa.',
        explanation: '"随时都可能" diễn tả khả năng thời tiết biến đổi đột ngột bất chợt.'
      }
    ]
  }
];
