// ==============================================================================
// DATA: data_hsk4_grammar_part4.mjs
// HSK 4 GRAMMAR - PART 4: ĐIỂM 79 ĐẾN 104 (CHUẨN GF 0025-2021 APPENDIX A)
// Bổ ngữ xu hướng/kết quả phái sinh, Câu chữ 把 & 被 nâng cao, So sánh & Cấu trúc cố định
// ==============================================================================

export const HSK4_GRAMMAR_PART4 = [
  {
    order_index: 79,
    name: 'Cấu trúc liệt kê song song hai phương diện "一方面...另一方面..." (Một mặt... mặt khác...)',
    pattern: 'Chủ ngữ + 一方面..., 另一方面... / 一方面 + Mệnh đề 1, 另一方面 + Mệnh đề 2',
    category: 'Liên từ',
    explanation_vi: '"一方面...另一方面..." (yī fāngmiàn... lìng yī fāngmiàn...) dùng để phân tích hai khía cạnh, hai nguyên nhân hoặc hai mục đích song hành của một vấn đề. Hai phương diện này có thể bổ sung cho nhau hoặc tương phản nhau nhằm tạo ra cái nhìn toàn diện.',
    examples: [
      {
        chinese: '利用假期去企业实习，一方面可以积累工作经验，另一方面也能赚取零花钱。',
        pinyin: 'Lìyòng jiàqī qù qǐyè shíxí, yì fāngmiàn kěyǐ jīlěi gōngzuò jīngyàn, lìng yì fāngmiàn yě néng zhuànqǔ línghuāqián.',
        translation_vi: 'Tận dụng kỳ nghỉ đi thực tập tại doanh nghiệp, một mặt có thể tích lũy kinh nghiệm làm việc, mặt khác cũng kiếm thêm được tiền tiêu vặt.',
        explanation: '"一方面...另一方面..." phân tích hai lợi ích song hành thiết thực của việc đi thực tập hè.'
      },
      {
        chinese: '这项新政策一方面鼓励科技创新，另一方面加大了对知识产权的保护力度。',
        pinyin: 'Zhè xiàng xīn zhèngcè yì fāngmiàn gǔlì kējì chuàngxīn, lìng yì fāngmiàn jiādà le duì zhīshi chǎnquán de bǎohù lìdù.',
        translation_vi: 'Chính sách mới này một mặt khuyến khích đổi mới công nghệ, mặt khác tăng cường cường độ bảo hộ quyền sở hữu trí tuệ.',
        explanation: 'Cấu trúc nêu rõ hai mũi nhọn chiến lược bổ trợ lẫn nhau của chính sách nhà nước.'
      }
    ]
  },
  {
    order_index: 80,
    name: 'Cấu trúc nhấn mạnh cực hạn "连...也/都..." (Ngay cả... cũng...)',
    pattern: '连 + Thành phần cực đoan (Chủ ngữ/Tân ngữ) + 也 / 都 + Vị ngữ',
    category: 'Cấu trúc cố định',
    explanation_vi: '"连...也/都..." (lián... yě/dōu...) đưa ra một đối tượng hoặc tình huống cực đoan, dễ thấy hoặc tối thiểu nhất để làm đòn bẩy nhấn mạnh ý nghĩa: đối tượng tối thiểu này còn như vậy thì những đối tượng khác hiển nhiên càng như thế.',
    examples: [
      {
        chinese: '这道菜的味道实在太辣了，连平时最喜欢吃辣椒的四川朋友都受不了。',
        pinyin: 'Zhè dào cài de wèidào shízài tài là le, lián píngshí zuì xǐhuan chī làjiāo de Sìchuān péngyou dōu shòubùliǎo.',
        translation_vi: 'Món ăn này vị cay quá chừng, ngay cả người bạn Tứ Xuyên bình thường thích ăn ớt nhất cũng không chịu nổi.',
        explanation: '"连...四川朋友都..." dùng thói quen ăn cay nổi tiếng của người Tứ Xuyên làm thước đo nhấn mạnh độ cay tột bực.'
      },
      {
        chinese: '他今天工作忙得不可开交，连中午饭都顾不上吃。',
        pinyin: 'Tā jīntiān gōngzuò máng de bùkěkāijiāo, lián zhōngwǔfàn dōu gùbushàng chī.',
        translation_vi: 'Hôm nay anh ấy bận đến mức tối mắt tối mũi, ngay cả cơm trưa cũng chẳng đoái hoài ăn được.',
        explanation: '"连中午饭都..." đưa bữa trưa (nhu cầu sinh học cơ bản) ra làm ví dụ cực tả mức độ bận rộn.'
      }
    ]
  },
  {
    order_index: 81,
    name: 'Phân biệt câu điều kiện đủ "只要...就..." và điều kiện cần "只有...才..."',
    pattern: '只要 + Điều kiện đủ + 就 + Kết quả / 只有 + Điều kiện duy nhất + 才 + Kết quả',
    category: 'Liên từ',
    explanation_vi: '"只要...就..." (zhǐyào... jiù...) biểu thị điều kiện thỏa mãn là đủ để tạo ra kết quả (chỉ cần có điều kiện này là có kết quả ngay); trong khi "只有...才..." (zhǐyǒu... cái...) biểu thị điều kiện bắt buộc, tiên quyết và duy nhất (chỉ khi nào có điều kiện này thì mới đạt được kết quả, không có nó thì không thể).',
    examples: [
      {
        chinese: '只要我们齐心协力互相配合，就一定能够战胜眼前的困难。',
        pinyin: 'Zhǐyào wǒmen qíxīnxiélì hùxiāng pèihé, jiù yídìng nénggòu zhànshèng yǎnqián de kùnnan.',
        translation_vi: 'Chỉ cần chúng ta đồng tâm hiệp lực phối hợp với nhau thì nhất định sẽ có thể chiến thắng khó khăn trước mắt.',
        explanation: '"只要...就..." khẳng định sự đoàn kết là điều kiện đầy đủ để đạt được thắng lợi vẻ vang.'
      },
      {
        chinese: '只有不断学习新知识，才能在日新月异的信息时代保持竞争力。',
        pinyin: 'Zhǐyǒu búduàn xuéxí xīn zhīshi, cái néng zài rìxīnyuèyì de xìnxī shídài bǎochí jìngzhēnglì.',
        translation_vi: 'Chỉ khi không ngừng học hỏi kiến thức mới thì mới có thể duy trì sức cạnh tranh trong thời đại thông tin đổi mới từng ngày.',
        explanation: '"只有...才能..." xác định việc học tập liên tục là con đường duy nhất để giữ vững ưu thế.'
      }
    ]
  },
  {
    order_index: 82,
    name: 'Cấu trúc điều kiện phiếm chỉ toàn diện "无论/不管...都/也..." (Bất luận / Bất kể... đều...)',
    pattern: '无论 / 不管 + Từ để hỏi / A 还是 B / Chính phản + 都 / 也 + Vị ngữ',
    category: 'Liên từ',
    explanation_vi: '"无论/不管...都/也..." (wúlùn/bùguǎn... dōu/yě...) biểu thị trong bất kỳ tình huống, điều kiện hoặc sự lựa chọn nào thì kết quả hay hành vi ở vế sau vẫn bất biến, không hề chịu ảnh hưởng (dù thế nào chăng nữa thì vẫn cứ). Vế trước bắt buộc phải chứa hình thức lựa chọn, từ để hỏi nghi vấn hoặc cặp đối lập.',
    examples: [
      {
        chinese: '不管外界环境发生什么变化，我们都必须坚持诚信经营的理念。',
        pinyin: 'Bùguǎn wàijiè huánjìng fāshēng shénme biànhuà, wǒmen dōu bìxū jiānchí chéngxìn jīngyíng de lǐniàn.',
        translation_vi: 'Bất kể môi trường bên ngoài phát sinh biến đổi gì, chúng ta đều phải kiên trì quan niệm kinh doanh chữ tín hàng đầu.',
        explanation: '"不管...什么变化...都..." nhấn mạnh nguyên tắc đạo đức kinh doanh không đổi trước mọi biến động thương trường.'
      },
      {
        chinese: '无论是刮风还是下雨，交警同志都会坚守在交通指挥岗位上。',
        pinyin: 'Wúlùn shì guāfēng háishì xiàyǔ, jiāojǐng tóngzhì dōu huì jiānshǒu zài jiāotōng zhǐhuī gǎngwèi shang.',
        translation_vi: 'Bất luận là giông gió hay mưa tuôn, các chiến sĩ cảnh sát giao thông đều bám trụ trên vị trí điều tiết giao thông.',
        explanation: '"无论是...还是...都..." bao quát cả hai điều kiện thời tiết xấu để ca ngợi tinh thần trách nhiệm của cảnh sát.'
      }
    ]
  },
  {
    order_index: 83,
    name: 'Bổ ngữ xu hướng kép phái sinh "起来" (Bắt đầu và tiếp diễn / Đánh giá nhận định)',
    pattern: 'Động từ + 起来 (Bắt đầu và tiếp diễn) / Động từ (看/听/想/尝) + 起来 (Đánh giá)',
    category: 'Bổ ngữ',
    explanation_vi: '"起来" (qilai) mang hai nghĩa phái sinh đặc thù quan trọng ở HSK 4: 1) Biểu thị hành động hoặc trạng thái bắt đầu phát sinh và tiếp tục phát triển (như 唱起来, 哭起来, 热闹起来); 2) Đứng sau các động từ tri giác (看, 听, 尝, 闻, 想) để đưa ra nhận xét, đánh giá từ góc độ của giác quan đó (như 看起来 - trông có vẻ, 听起来 - nghe chừng).',
    examples: [
      {
        chinese: '听到这个令人振奋的好消息，整个办公室顿时欢呼起来。',
        pinyin: 'Tīngdào zhè ge lìng rén zhènfèn de hǎo xiāoxi, zhěng gè bàngōngshì dùnshí huānhū qǐlai.',
        translation_vi: 'Nghe được tin mừng đầy phấn khởi này, toàn bộ văn phòng lập tức reo hò rộn ràng lên.',
        explanation: '"欢呼起来" biểu thị động tác reo hò bắt đầu bùng nổ và tiếp diễn náo nhiệt.'
      },
      {
        chinese: '这首古典音乐旋律优美，听起来让人感觉非常放松舒适。',
        pinyin: 'Zhè shǒu gǔdiǎn yīnyuè xuánlǜ yōuměi, tīng qǐlai ràng rén gǎnjué fēicháng fàngsōng shūshì.',
        translation_vi: 'Khúc nhạc cổ điển này giai điệu êm ái, nghe chừng khiến cho con người cảm thấy rất thư thái dễ chịu.',
        explanation: '"听起来" dùng giác quan thính giác làm cơ sở đánh giá chất lượng và cảm xúc âm nhạc mang lại.'
      }
    ]
  },
  {
    order_index: 84,
    name: 'Bổ ngữ xu hướng kép phái sinh "下去" (Tiếp tục duy trì sang tương lai)',
    pattern: 'Động từ + 下去 (坚持 / 学 / 活 / 走 / 讲 / 读 + 下去)',
    category: 'Bổ ngữ',
    explanation_vi: '"下去" (xiàqu) khi làm bổ ngữ phái sinh biểu thị một hành động hoặc trạng thái vốn đang được tiến hành sẽ tiếp tục duy trì, kéo dài từ thời điểm hiện tại hướng về tương lai (làm tiếp đi, duy trì tiếp). Thường dùng ở dạng khẳng định động viên hoặc phủ định "V + 不下去" (không thể tiếp tục nổi).',
    examples: [
      {
        chinese: '既然你选择了学习中文，就要克服一切困难坚持学下去。',
        pinyin: 'Jìrán nǐ xuǎnzé le xuéxí zhōngwén, jiù yào kèfú yíqiè kùnnan jiānchí xué xiàqu.',
        translation_vi: 'Đã cậu chọn học tiếng Trung thì phải khắc phục mọi khó khăn để kiên trì học tiếp.',
        explanation: '"坚持学下去" cổ vũ đối phương giữ vững ý chí kiên định duy trì việc học tập trong tương lai dài lâu.'
      },
      {
        chinese: '会议时间太长，如果再这样争论下去，恐怕今天很难得出结论。',
        pinyin: 'Huìyì shíjiān tài cháng, rúguǒ zài zhèyàng zhēnglùn xiàqu, kǒngpà jīntiān hěn nán déchū jiélùn.',
        translation_vi: 'Thời gian cuộc họp quá dài rồi, nếu còn tiếp tục tranh cãi mãi như thế này, e rằng hôm nay khó đưa ra được kết luận.',
        explanation: '"再这样争论下去" cảnh báo việc kéo dài tranh cãi vô ích sẽ làm đình trệ công việc.'
      }
    ]
  },
  {
    order_index: 85,
    name: 'Bổ ngữ xu hướng kép phái sinh "下来" (Cố định, lưu giữ / Kéo dài từ quá khứ)',
    pattern: 'Động từ + 下来 (记 / 写 / 停 / 留 / 传承 + 下来)',
    category: 'Bổ ngữ',
    explanation_vi: '"下来" (xialai) mang hai nghĩa phái sinh chính: 1) Biểu thị hành động làm cho sự vật chuyển từ động sang tĩnh, cố định lại hoặc lưu giữ lại một thông tin, hình ảnh (như 记下来 - ghi chép lại, 拍下来 - chụp lại, 留下来 - ở lại); 2) Biểu thị hành động hoặc truyền thống được tiếp nối từ quá khứ đến hiện tại (như 传下来 - lưu truyền lại).',
    examples: [
      {
        chinese: '老师讲的重要考点，请大家一定要在笔记本上完整地记下来。',
        pinyin: 'Lǎoshī jiǎng de zhòngyào kǎodiǎn, qǐng dàjiā yídìng yào zài bǐjìběn shang wánzhěng de jì xialai.',
        translation_vi: 'Những trọng điểm thi quan trọng thầy giáo giảng, xin mọi người nhất định phải ghi chép lại đầy đủ vào vở.',
        explanation: '"完整地记下来" dùng "下来" thể hiện hành động ghi chép lưu giữ kiến thức trên giấy tờ.'
      },
      {
        chinese: '这项古老的民间手工艺是由老一辈手艺人一代代流传下来的。',
        pinyin: 'Zhè xiàng gǔlǎo de mínjiān shǒugōngyì shì yóu lǎoyíbèi shǒuyìrén yídàidài liúchuán xialai de.',
        translation_vi: 'Kỹ nghệ thủ công dân gian cổ xưa này là do những người thợ thế hệ đi trước truyền lại từ đời này sang đời khác.',
        explanation: '"流传下来" thể hiện dòng chảy văn hóa tiếp nối từ lịch sử xa xưa tới hiện đại.'
      }
    ]
  },
  {
    order_index: 86,
    name: 'Bổ ngữ xu hướng kép phái sinh "出来" (Từ ẩn sang hiện / Nhận diện / Sáng tạo)',
    pattern: 'Động từ + 出来 (看 / 认 / 想 / 听 / 制作 + 出来)',
    category: 'Bổ ngữ',
    explanation_vi: '"出来" (chulai) làm bổ ngữ phái sinh có ba trường hợp tiêu biểu: 1) Sự vật từ trạng thái ẩn giấu, vô hình chuyển thành hiển lộ, nhìn thấy rõ ràng (như 太阳钻出来了); 2) Năng lực phân biệt, nhận diện rõ người hoặc vật qua tri giác (như 认出来 - nhận ra, 看出来 - nhìn ra được sự việc); 3) Hoàn thành một sản phẩm sáng tạo từ chỗ chưa có (như 想出办法来, 制作出来).',
    examples: [
      {
        chinese: '虽然他戴着帽子和口罩，但我还是一眼就认出了他。',
        pinyin: 'Suīrán tā dàizhe màozi hé kǒuzhào, dàn wǒ háishì yìyǎn jiù rènchū le tā.',
        translation_vi: 'Tuy rằng anh ấy đội mũ và đeo khẩu trang, nhưng tôi vẫn nhận ngay ra anh ấy chỉ bằng một ánh nhìn.',
        explanation: '"认出来" biểu thị năng lực nhận biết chính xác người quen bất chấp việc cải trang.'
      },
      {
        chinese: '经过三天三夜的反复讨论，工程师们终于想出了解决故障的好方案。',
        pinyin: 'Jīngguò sān tiān sān yè de fǎnfù tǎolùn, gōngchéngshīmen zhōngyú xiǎngchū le jiějué gùzhàng de hǎo fāng\'àn.',
        translation_vi: 'Sau ba ngày ba đêm thảo luận liên tục, các kỹ sư cuối cùng đã nghĩ ra được phương án tuyệt vời giải quyết sự cố.',
        explanation: '"想出来" diễn tả thành quả tư duy sáng tạo từ chỗ bế tắc đến khi nảy ra giải pháp mới.'
      }
    ]
  },
  {
    order_index: 87,
    name: 'Bổ ngữ xu hướng kép phái sinh "过来" (Hồi phục trạng thái bình thường)',
    pattern: 'Động từ + 过来 (醒 / 明白 / 反应 / 改 / 缓 + 过来)',
    category: 'Bổ ngữ',
    explanation_vi: '"过来" (guolai) khi mang nghĩa phái sinh biểu thị sự hồi phục hoặc chuyển biến từ một trạng thái tiêu cực, sai lệch hoặc bất thường trở về trạng thái tỉnh táo, chuẩn mực và tích cực ban đầu (như 醒过来 - tỉnh lại, 明白过来 - hiểu ra, 改过来 - sửa đúng lại, 缓过劲来 - hồi sức lại).',
    examples: [
      {
        chinese: '医生全力抢救了几个小时，昏迷的伤员终于慢慢醒过来了。',
        pinyin: 'Yīshēng quánlì qiǎngjiù le jǐ gè xiǎoshí, hūnmí de shāngyuán zhōngyú mànmàn xǐng guolai le.',
        translation_vi: 'Bác sĩ dốc sức cấp cứu mấy tiếng đồng hồ, người bị thương hôn mê cuối cùng đã từ từ tỉnh lại.',
        explanation: '"醒过来" chỉ sự hồi phục ý thức từ trạng thái hôn mê sâu nguy kịch trở về trạng thái tỉnh táo.'
      },
      {
        chinese: '听了老师耐心的启发，他才猛然明白过来自己错在哪里。',
        pinyin: 'Tīng le lǎoshī nàixīn de qǐfā, tā cái měngrán míngbai guolai zìjǐ cuò zài nǎlǐ.',
        translation_vi: 'Nghe lời khuyên bảo kiên trì của thầy giáo, cậu ấy mới bừng tỉnh hiểu ra mình sai ở chỗ nào.',
        explanation: '"明白过来" diễn tả sự chuyển biến nhận thức từ u mê, mơ hồ sang thấu tỏ bản chất.'
      }
    ]
  },
  {
    order_index: 88,
    name: 'Bổ ngữ xu hướng kép phái sinh "过去" (Rơi vào trạng thái bất tỉnh hoặc bất lợi)',
    pattern: 'Động từ + 过去 (晕 / 昏 / 昏厥 + 过去)',
    category: 'Bổ ngữ',
    explanation_vi: '"过去" (guoqu) là phản nghĩa của "过来", khi làm bổ ngữ phái sinh diễn tả trạng thái con người bị mất ý thức, ngất lịm, rời xa trạng thái bình thường (rơi vào hôn mê, ngất đi) hoặc chỉ sự vật bị suy vong, chết đi.',
    examples: [
      {
        chinese: '听到这个突如其来的噩耗，老奶奶经受不住打击，直接晕了过去。',
        pinyin: 'Tīngdào zhè ge tūrúqílái de èhào, lǎonǎinai jīngshòu bú zhù dǎjī, zhíjiē yūn le guoqu.',
        translation_vi: 'Nghe tin dữ đột ngột ập đến này, người bà không chịu nổi cú sốc, đã ngất lịm đi ngay tại chỗ.',
        explanation: '"晕了过去" miêu tả tình trạng ngất xỉu, mất hoàn toàn tri giác trước cú sốc tinh thần quá lớn.'
      },
      {
        chinese: '运动员由于严重脱水和体力透支，冲过终点线后瞬间昏了过去。',
        pinyin: 'Yùndòngyuán yóuyú yánzhòng tuōshuǐ hé tǐlì tòuzhī, chōngguò zhōngdiǎnxiàn hòu shùnjiān hūn le guoqu.',
        translation_vi: 'Vận động viên do mất nước nghiêm trọng và kiệt sức, sau khi lao qua vạch đích đã lập tức ngất đi.',
        explanation: '"昏了过去" ghi nhận trạng thái hôn mê do suy kiệt thể lực tột cùng trên đường đua.'
      }
    ]
  },
  {
    order_index: 89,
    name: 'Bổ ngữ kết quả phái sinh "上" (Gắn kết, tiếp xúc, đạt mục tiêu)',
    pattern: 'Động từ + 上 (关 / 穿 / 锁 / 考 / 爱 / 谈 / 遇 + 上)',
    category: 'Bổ ngữ',
    explanation_vi: '"上" (shang) làm bổ ngữ kết quả mang các nghĩa phái sinh đặc thù: 1) Hai vật thể tiếp xúc dính liền, khép kín lại với nhau (như 关上门, 穿上衣服, 锁上柜子); 2) Đạt được một mục đích hoặc kết quả mong muốn (như 考上大学 - thi đỗ đại học); 3) Bắt đầu nảy sinh một mối quan hệ tình cảm hoặc sự kiện (như 爱上 - yêu, 遇上 - gặp gỡ).',
    examples: [
      {
        chinese: '功夫不负有心人，经过刻苦努力他终于考上了心仪的名牌大学。',
        pinyin: 'Gōngfu bú fù yǒuxīnrén, jīngguò kèkǔ nǔlì tā zhōngyú kǎoshàng le xīnyí de míngpái dàxué.',
        translation_vi: 'Công phu không phụ lòng người, sau bao nỗ lực gian khổ cuối cùng anh ấy đã thi đỗ vào trường đại học danh tiếng ước mơ.',
        explanation: '"考上大学" dùng "上" làm bổ ngữ kết quả biểu thị việc đạt được mục tiêu thi cử thành công rực rỡ.'
      },
      {
        chinese: '出门前请检查水龙头和电源，并记得随手把大门锁上。',
        pinyin: 'Chūmén qián qǐng jiǎnchá shuǐlóngtóu hé diànyuán, bìng jìde suíshǒu bǎ dàmén suǒshang.',
        translation_vi: 'Trước khi ra khỏi nhà xin hãy kiểm tra vòi nước và nguồn điện, đồng thời nhớ tiện tay khóa chặt cửa chính lại.',
        explanation: '"锁上" biểu thị hành động tra chìa khóa làm cho hai cánh cửa gắn chặt đóng kín an toàn.'
      }
    ]
  },
  {
    order_index: 90,
    name: 'Bổ ngữ kết quả phái sinh "开" (Tách rời, mở rộng, dàn trải)',
    pattern: 'Động từ + 开 (打 / 分 / 走 / 离 / 散 / 展 + 开)',
    category: 'Bổ ngữ',
    explanation_vi: '"开" (kāi) làm bổ ngữ kết quả mang nghĩa phân tách, làm cho các bộ phận đang gắn kết tách rời xa nhau ra (như 分开, 离开), hoặc làm cho không gian được mở rộng, bung tỏa ra các hướng (như 打开窗户, 散开, 展开调查).',
    examples: [
      {
        chinese: '请大家在考场内保持安静，并把书本和文具整齐地分开摆放。',
        pinyin: 'Qǐng dàjiā zài kǎochǎng nèi bǎochí ānjìng, bìng bǎ shūběn hé wénjù zhěngqí de fēnkāi bǎifàng.',
        translation_vi: 'Xin mọi người hãy giữ trật tự trong phòng thi, và để tách riêng sách vở với đồ dùng học tập một cách ngay ngắn.',
        explanation: '"分开摆放" dùng "开" thể hiện trạng thái phân cách không để đồ dùng chồng chéo lên nhau.'
      },
      {
        chinese: '下课铃响了，操场上的学生们欢笑着迅速向四周散开。',
        pinyin: 'Xiàkè líng xiǎng le, cāochǎng shang de xuéshengmen huānxiàozhe xùnsù xiàng sìzhōu sànkāi.',
        translation_vi: 'Chuông tan học reo rồi, học sinh trên sân trường vừa cười nói vừa nhanh chóng tản ra bốn phía.',
        explanation: '"散开" miêu tả đám đông di chuyển tản mát về các phương hướng khác nhau.'
      }
    ]
  },
  {
    order_index: 91,
    name: 'Bổ ngữ trạng thái phức tạp dẫn mệnh đề "得" (Mức độ cực tả)',
    pattern: 'Chủ ngữ + Động từ/Tính từ + 得 + Cụm chủ vị / Mệnh đề miêu tả',
    category: 'Bổ ngữ',
    explanation_vi: 'Ở trình độ HSK 4, thành phần đứng sau trợ từ "得" (de) không chỉ là tính từ đơn lẻ mà phát triển thành một cụm chủ vị hoặc mệnh đề hoàn chỉnh để miêu tả sinh động, cụ thể hóa trạng thái hoặc hệ quả của hành vi đạt tới mức độ kinh ngạc (đến mức mà, đến nỗi mà).',
    examples: [
      {
        chinese: '小丑滑稽幽默的表演逗得全场观众哈哈大笑。',
        pinyin: 'Xiǎochǒu huájī yōumò de biǎoyǎn dòu de quánchǎng guānzhòng hāhā dàxiào.',
        translation_vi: 'Màn biểu diễn hài hước dí dỏm của chú hề chọc cho toàn thể khán giả cười nghiêng ngả.',
        explanation: '"逗得全场观众哈哈大笑" dùng cả cụm chủ vị "全场观众哈哈大笑" làm bổ ngữ trạng thái miêu tả sức hút của tiết mục xiếc.'
      },
      {
        chinese: '听完老爷爷感人的战斗经历，大家感动得眼泪夺眶而出。',
        pinyin: 'Tīngwán lǎoyéye gǎnrén de zhàndòu jīnglì, dàjiā gǎndòng de yǎnlèi duókuàng ér chū.',
        translation_vi: 'Nghe xong trải nghiệm chiến đấu xúc động của cụ già, mọi người cảm động đến mức nước mắt trào ra khóe mi.',
        explanation: '"感动得眼泪夺眶而出" cực tả mức độ xúc động sâu sắc đến rơi lệ của người nghe.'
      }
    ]
  },
  {
    order_index: 92,
    name: 'Câu chữ 把 nâng cao kết hợp vị trí chuyển dịch: "把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成"',
    pattern: 'Chủ ngữ + 把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成 + Nơi chốn / Người nhận / Kết quả',
    category: 'Câu chữ 把',
    explanation_vi: 'Đây là dạng nâng cao cực kỳ quan trọng của câu chữ 把 trong HSK 4, biểu thị hành vi xử lý làm cho tân ngữ chuyển dịch vị trí (放到... / 留在...), chuyển giao quyền sở hữu (借给... / 送给...), hoặc biến đổi bản chất thành dạng thức mới (翻译成... / 改变成...).',
    examples: [
      {
        chinese: '请大家把填好的调查问卷交到前面的工作人员手里。',
        pinyin: 'Qǐng dàjiā bǎ tiánhǎo de diàochá wènjuàn jiāodào qiánmiàn de gōngzuò rényuán shǒulǐ.',
        translation_vi: 'Xin mọi người hãy nộp phiếu khảo sát đã điền xong vào tay các nhân viên công tác phía trước.',
        explanation: 'Cấu trúc "把问卷交到...手里" thể hiện sự chuyển dời địa điểm vật lý của tờ phiếu khảo sát.'
      },
      {
        chinese: '翻译官十分熟练地把这篇中文发言稿翻译成了流利的英文。',
        pinyin: 'Fānyìguān shífēn shúliàn de bǎ zhè piān zhōngwén fāyángǎo fānyì chéng le liúlì de yīngwén.',
        translation_vi: 'Viên phiên dịch viên hết sức thành thạo dịch bài phát biểu tiếng Trung này thành tiếng Anh lưu loát.',
        explanation: 'Cấu trúc "把发言稿翻译成英文" thể hiện sự chuyển hóa hình thức ngôn ngữ của văn bản.'
      }
    ]
  },
  {
    order_index: 93,
    name: 'Vị trí từ phủ định và động từ năng nguyện trong câu chữ 把',
    pattern: 'Chủ ngữ + 不/没/别/应该/想/愿意 + 把 + Tân ngữ + Động từ + Thành phần khác',
    category: 'Câu chữ 把',
    explanation_vi: 'Quy tắc vàng ngữ pháp tiếng Trung: Từ phủ định (不, 没, 别) và động từ năng nguyện (想, 愿意, 应该, 能够) bắt buộc phải đứng TRƯỚC giới từ "把", tuyệt đối không được chen vào giữa "把" và tân ngữ hoặc sau động từ chính.',
    examples: [
      {
        chinese: '你千万不要把这么机密的文件随手放在公共桌子上。',
        pinyin: 'Nǐ qiānwàn bú yào bǎ zhème jīmì de wénjiàn suíshǒu fàng zài gōnggòng zhuōzi shang.',
        translation_vi: 'Cậu tuyệt đối đừng tiện tay đặt tài liệu cơ mật như thế này trên bàn làm việc chung.',
        explanation: 'Phó từ khuyên răn phủ định "千万不要" đứng trước "把" tuân thủ chuẩn xác quy tắc ngữ pháp.'
      },
      {
        chinese: '他平时非常细心，从来没有把客户的联系电话记错。',
        pinyin: 'Tā píngshí fēicháng xìxīn, cónglái méiyǒu bǎ kèhù de liánxì diànhuà jìcuò.',
        translation_vi: 'Anh ấy bình thường rất cẩn thận, chưa bao giờ ghi nhầm số điện thoại liên lạc của khách hàng.',
        explanation: '"从来没有" là trạng ngữ phủ định đứng trước "把", bảo đảm vị trí chuẩn xác trong câu.'
      }
    ]
  },
  {
    order_index: 94,
    name: 'Câu chữ 把 kết hợp bổ ngữ kết quả và bổ ngữ xu hướng phức hợp',
    pattern: 'Chủ ngữ + 把 + Tân ngữ + Động từ + Bổ ngữ kết quả / Bổ ngữ xu hướng kép',
    category: 'Câu chữ 把',
    explanation_vi: 'Trong câu chữ 把, động từ không bao giờ đứng trơ trọi một mình mà bắt buộc phải có thành phần bổ trợ phía sau, phổ biến nhất ở HSK 4 là bổ ngữ kết quả (như 弄坏, 擦干净, 准备好) hoặc bổ ngữ xu hướng kép (như 拿出来, 搬进去, 送回去).',
    examples: [
      {
        chinese: '清洁工人用高压水枪把整条街道冲洗得干干净净。',
        pinyin: 'Qīngjié gōngrén yòng gāoyā shuǐqiāng bǎ zhěng tiáo jiēdào chōngxǐ de gāngānjìngjìng.',
        translation_vi: 'Công nhân vệ sinh dùng vòi xịt nước áp lực cao xối rửa cả con đường sạch bóng không một vết bẩn.',
        explanation: '"把街道冲洗得干干净净" kết hợp câu chữ 把 với bổ ngữ trạng thái miêu tả kết quả sạch sẽ tinh tươm.'
      },
      {
        chinese: '请同学们把书包里的课本和练习册迅速拿出来。',
        pinyin: 'Qǐng tóngxuémen bǎ shūbāo lǐ de kèběn hé liànxícè xùnsù ná chūlái.',
        translation_vi: 'Xin các em học sinh hãy nhanh chóng lấy sách giáo khoa và vở bài tập trong cặp ra.',
        explanation: '"把课本...拿出来" kết hợp câu chữ 把 với bổ ngữ xu hướng kép "出来" biểu thị hướng chuyển động của sách vở.'
      }
    ]
  },
  {
    order_index: 95,
    name: 'Câu bị động nâng cao có tác nhân và ẩn tác nhân với "被"',
    pattern: 'Chủ ngữ + 被 + (Tác nhân thực hiện) + Động từ + Thành phần khác',
    category: 'Câu bị động',
    explanation_vi: 'Trong câu bị động chữ "被" ở trình độ HSK 4: 1) Có thể nêu rõ tác nhân gây ra hành động (như 行李被雨淋湿了); 2) Tác nhân có thể được tỉnh lược (ẩn tác nhân) khi không rõ ai làm hoặc muốn nhấn mạnh bản thân đối tượng bị tác động (như 自行车被偷了 - Xe đạp bị trộm mất). Động từ sau "被" cũng bắt buộc phải có thành phần khác kèm theo.',
    examples: [
      {
        chinese: '那篇优秀的调查报道被几家主流新闻媒体在头版转载。',
        pinyin: 'Nà piān yōuxiù de diàochá bàodào bèi jǐ jiā zhǔliú xīnwén méitǐ zài tóubǎn zhuǎnzǎi.',
        translation_vi: 'Bài phóng sự điều tra xuất sắc đó đã được mấy cơ quan truyền thông báo chí chính thống đăng lại trên trang nhất.',
        explanation: 'Câu bị động nêu rõ tác nhân "几家主流新闻媒体" làm rõ cơ quan báo chí đứng ra tái bản bài báo.'
      },
      {
        chinese: '放在阳台上的几盆鲜花被昨晚的大暴雨砸坏了。',
        pinyin: 'Fàng zài yángtái shang de jǐ pén xiānhuā bèi zuówǎn de dà bàoyǔ záhuài le.',
        translation_vi: 'Mấy chậu hoa tươi đặt ở ban công đã bị cơn mưa rào lớn đêm qua dập nát hỏng hết.',
        explanation: '"被大暴雨砸坏了" kết hợp câu bị động với bổ ngữ kết quả "坏", tác nhân gây hại là thời tiết mưa to.'
      }
    ]
  },
  {
    order_index: 96,
    name: 'Câu biểu thị bị động cảm thụ và đón nhận với "受" (Được / Bị)',
    pattern: 'Chủ ngữ + 受到 / 受 + Danh từ/Động từ (欢迎 / 尊重 / 感动 / 骗 / 惩罚)',
    category: 'Câu bị động',
    explanation_vi: 'Ngoài chữ "被", tiếng Trung HSK 4 thường dùng "受" (shòu) hoặc "受到" để tạo thành câu bị động mang tính cảm thụ. Khi kết hợp với từ ngữ tích cực (欢迎, 尊重, 表扬), nó mang nghĩa là "được"; khi kết hợp với từ ngữ tiêu cực (骗, 处分, 惩罚), nó mang nghĩa là "bị".',
    examples: [
      {
        chinese: '王老师讲课幽默生动，在学校里受到了全体学生的热烈欢迎。',
        pinyin: 'Wáng lǎoshī jiǎngkè yōumò shēngdòng, zài xuéxiào lǐ shòudào le quántǐ xuésheng de rèliè huānyíng.',
        translation_vi: 'Thầy Vương giảng bài hài hước sinh động, ở trường được toàn thể học sinh nhiệt liệt hoan nghênh.',
        explanation: '"受到了...热烈欢迎" biểu thị câu bị động thụ hưởng sự mến mộ tích cực từ học trò.'
      },
      {
        chinese: '由于轻信了网络上的虚假投资广告，他上当受骗损失了一大笔钱。',
        pinyin: 'Yóuyú qīngxìn le wǎngluò shang de xūjiǎ tóuzī guǎnggào, tā shàngdàng shòupiàn sǔnshī le yí dà bǐ qián.',
        translation_vi: 'Do nhẹ dạ tin vào quảng cáo đầu tư giả mạo trên mạng, anh ta đã sập bẫy bị lừa mất một khoản tiền lớn.',
        explanation: '"上当受骗" là cách dùng bị động mang ý nghĩa tiêu cực khi bị kẻ gian lừa gạt tài sản.'
      }
    ]
  },
  {
    order_index: 97,
    name: 'Câu so sánh hơn nâng cao kèm lượng từ sai biệt cụ thể',
    pattern: 'A 比 B + Tính từ + 得多 / 多了 / 一些 / 一点儿 / Số từ + Lượng từ',
    category: 'Câu so sánh',
    explanation_vi: 'Trong câu so sánh chữ "比" ở trình độ HSK 4, để diễn đạt mức độ sai biệt giữa hai đối tượng, ta đặt thành phần đo lường ở SAU tính từ: 1) Sai biệt lớn: Tính từ + 得多 / 多了; 2) Sai biệt nhỏ: Tính từ + 一些 / 一点儿; 3) Sai biệt chuẩn xác: Tính từ + Số từ + Lượng từ (như 大五岁, 贵二十块).',
    examples: [
      {
        chinese: '坐高铁从北京到上海比坐普通火车快得多，节省了整整八个小时。',
        pinyin: 'Zuò gāotiě cóng Běijīng dào Shànghǎi bǐ zuò pǔtōng huǒchē kuài de duō, jiéshěng le zhěngzhěng bā gè xiǎoshí.',
        translation_vi: 'Đi tàu cao tốc từ Bắc Kinh đến Thượng Hải nhanh hơn nhiều so với tàu hỏa thường, tiết kiệm trọn vẹn 8 tiếng.',
        explanation: '"快得多" đặt sau tính từ "快" biểu thị khoảng cách chênh lệch tốc độ vượt trội của đường sắt cao tốc.'
      },
      {
        chinese: '弟弟今年刚满十八岁，足足比他的表哥高了五厘米。',
        pinyin: 'Dìdi jīnnián gāng mǎn shíbā suì, zúzú bǐ tā de biǎogē gāo le wǔ límǐ.',
        translation_vi: 'Em trai năm nay vừa tròn 18 tuổi, đã cao hơn người anh họ của mình tròn 5 centimet.',
        explanation: '"高了五厘米" dùng lượng từ số lượng cụ thể "五厘米" để đo lường độ chênh lệch chiều cao.'
      }
    ]
  },
  {
    order_index: 98,
    name: 'Câu so sánh hơn tăng tiến có phó từ "更" / "还"',
    pattern: 'A 比 B + 更 / 还 + Tính từ (B vốn đã có tính chất đó, A lại vượt trội hơn)',
    category: 'Câu so sánh',
    explanation_vi: 'Khi muốn diễn đạt đối tượng B vốn dĩ đã mang một đặc tính ở mức độ cao, nhưng đối tượng A thậm chí còn vượt trội hơn B nữa, ta thêm phó từ "更" hoặc "还" vào trước tính từ vị ngữ trong câu so sánh chữ 比. Lưu ý tuyệt đối không dùng "很", "真", "非常" trong câu chữ 比.',
    examples: [
      {
        chinese: '这篇课文生词很多，但下一篇课文的语法比这篇还要复杂。',
        pinyin: 'Zhè piān kèwén shēngcí hěn duō, dàn xià yì piān kèwén de yǔfǎ bǐ zhè piān hái yào fùzá.',
        translation_vi: 'Bài khóa này từ mới rất nhiều, nhưng ngữ pháp của bài khóa tiếp theo còn phức tạp hơn cả bài này nữa.',
        explanation: '"还要复杂" tiền giả định bài khóa 1 đã khó, bài khóa 2 mức độ phức tạp càng được đẩy lên tầng cao hơn.'
      },
      {
        chinese: '在激烈的市场竞争中，企业的创新能力比资金实力更为重要。',
        pinyin: 'Zài jīliè de shìchǎng jìngzhēng zhōng, qǐyè de chuàngxīn nénglì bǐ zījīn shílì gèng wéi zhòngyào.',
        translation_vi: 'Trong cạnh tranh thị trường khốc liệt, năng lực đổi mới sáng tạo của doanh nghiệp còn quan trọng hơn cả tiềm lực tài chính.',
        explanation: '"更为重要" so sánh hai nhân tố quan trọng để khẳng định yếu tố sáng tạo mang tính sống còn.'
      }
    ]
  },
  {
    order_index: 99,
    name: 'Phân biệt thể phủ định của câu so sánh: "A 不比 B" vs "A 没有/不如 B"',
    pattern: 'A 不比 B + Tính từ (A không kém gì B / ngang ngửa B) vs A 没有/不如 B + Tính từ (A thua kém B)',
    category: 'Câu so sánh',
    explanation_vi: '"A 不比 B + Tính từ" mang hàm ý bác bỏ quan điểm cho rằng A thua kém B, ngụ ý A ngang ngửa hoặc thậm chí hơn B (không kém gì). Trong khi đó, "A 没有 / 不如 B + Tính từ" là so sánh thua kém đơn thuần, thừa nhận mức độ của A thấp hơn B.',
    examples: [
      {
        chinese: '我们虽然是刚创办的小公司，但在产品质量上绝不比大品牌差。',
        pinyin: 'Wǒmen suīrán shì gāng chuàngbàn de xiǎo gōngsī, dàn zài chǎnpǐn zhìliàng shang jué bù bǐ dà pǐnpái chà.',
        translation_vi: 'Chúng tôi tuy là công ty nhỏ mới thành lập, nhưng về chất lượng sản phẩm quyết không thua kém gì các thương hiệu lớn.',
        explanation: '"不比大品牌差" tự tin khẳng định chất lượng đạt chuẩn ngang hàng với các ông lớn đầu ngành.'
      },
      {
        chinese: '在实际工作经验方面，刚刚入职的新人确实不如老员工丰富。',
        pinyin: 'Zài shíjì gōngzuò jīngyàn fāngmiàn, gānggāng rùzhí de xīnrén quèshí bùrú lǎoyuángōng fēngfù.',
        translation_vi: 'Về mặt kinh nghiệm làm việc thực tế, người mới vừa vào công ty quả thực không dồi dào bằng nhân viên kỳ cựu.',
        explanation: '"不如老员工丰富" thừa nhận khoảng cách kinh nghiệm khách quan giữa lính mới và nhân viên lâu năm.'
      }
    ]
  },
  {
    order_index: 100,
    name: 'Cấu trúc so sánh phát triển theo biến số: "越来越..." vs "越...越..."',
    pattern: 'Chủ ngữ + 越来越 + Tính từ / 越 + Điều kiện A + 越 + Kết quả B',
    category: 'Cấu trúc cố định',
    explanation_vi: '"越来越..." (yuè lái yuè...) chỉ sự biến đổi của mức độ theo thời gian tự nhiên (càng ngày càng...); trong khi "越...越..." (yuè... yuè...) là cấu trúc có điều kiện: mức độ của vế sau biến thiên tỷ lệ thuận hoặc phụ thuộc trực tiếp vào mức độ phát triển của hành động/điều kiện ở vế trước (càng... thì càng...).',
    examples: [
      {
        chinese: '随着城市绿化工程的推进，这里的空气质量变得越来越好。',
        pinyin: 'Suízhe chéngshì lǜhuà gōngchéng de tuījìn, zhèlǐ de kōngqì zhìliàng biànde yuè lái yuè hǎo.',
        translation_vi: 'Cùng với sự thúc đẩy của công trình phủ xanh đô thị, chất lượng không khí nơi đây trở nên ngày một tốt hơn.',
        explanation: '"越来越好" miêu tả sự tiến bộ dần đều của môi trường sống theo dòng thời gian.'
      },
      {
        chinese: '这本书的内容非常引人入胜，让人越读越觉得有意思。',
        pinyin: 'Zhè běn shū de nèiróng fēicháng yǐnrénrùshèng, ràng rén yuè dú yuè juéde yǒu yìsi.',
        translation_vi: 'Nội dung cuốn sách này vô cùng lôi cuốn, khiến người ta càng đọc càng cảm thấy thú vị.',
        explanation: '"越读越觉得有意思" thể hiện mức độ say mê tăng dần theo từng trang sách được mở ra.'
      }
    ]
  },
  {
    order_index: 101,
    name: 'Cấu trúc cố định dẫn nguồn thông tin khách quan: "据..." (Theo như / Căn cứ vào)',
    pattern: '据 + Nguồn tin (说 / 统计 / 报道 / 专家介绍 / 我所知), Mệnh đề tin tức',
    category: 'Cấu trúc cố định',
    explanation_vi: '"据" (jù) là giới từ trang trọng dẫn xuất nguồn gốc của thông tin, số liệu hoặc báo cáo báo chí (theo như, căn cứ theo). Các cụm từ cố định thường gặp trong HSK 4 gồm: 据说 (nghe nói), 据统计 (theo thống kê), 据报道 (theo đưa tin), 据了解 (theo tìm hiểu), 据我所知 (theo như tôi được biết).',
    examples: [
      {
        chinese: '据官方权威数据统计，今年该地区的游客接待量突破了五千万人次。',
        pinyin: 'Jù guānfāng quánwēi shùjù tǒngjì, jīnnián gāi dìqū de yóukè jiēdàiliàng tūpò le wǔqiān wàn réncì.',
        translation_vi: 'Theo thống kê số liệu có thẩm quyền chính thức, lượng đón khách du lịch của khu vực này năm nay đã vượt mốc 50 triệu lượt người.',
        explanation: '"据官方权威数据统计" nâng cao độ tin cậy và chuẩn xác khoa học cho con số du lịch.'
      },
      {
        chinese: '据当地气象台报道，未来三天将有一股强冷空气席卷华北地区。',
        pinyin: 'Jù dāngdì qìxiàngtái bàodào, wèilái sān tiān jiāng yǒu yì gǔ qiáng lěngkōngqì xíjuǎn Huáběi dìqū.',
        translation_vi: 'Theo đài khí tượng địa phương đưa tin, trong ba ngày tới sẽ có một đợt không khí lạnh mạnh tràn qua khu vực Hoa Bắc.',
        explanation: '"据...报道" trích dẫn nguồn tin báo chí khí tượng chính thống để cảnh báo rét đậm.'
      }
    ]
  },
  {
    order_index: 102,
    name: 'Cấu trúc cố định nêu quan điểm nhận định: "在我看来" / "从...来看" / "总的来说"',
    pattern: '在我看来, Mệnh đề / 从 + Góc độ + 来看, Mệnh đề / 总的来说, Mệnh đề',
    category: 'Cấu trúc cố định',
    explanation_vi: 'Đây là các mẫu câu định vị góc nhìn và quy nạp luận điểm chuẩn mực trong văn phong nghị luận tiếng Trung: 1) "在我看来" (theo quan điểm cá nhân tôi); 2) "从...来看" (xét từ góc độ khách quan nào đó); 3) "总的来说" (tổng kết lại, nói một cách tổng quát).',
    examples: [
      {
        chinese: '在我看来，健康和快乐是人生中最值得珍惜的宝贵财富。',
        pinyin: 'Zài wǒ kànlái, jiànkāng hé kuàilè shì rénshēng zhōng zuì zhíde zhēnxī de bǎoguì cáifù.',
        translation_vi: 'Theo quan điểm của tôi, sức khỏe và niềm vui là tài sản quý báu đáng trân trọng nhất trong cuộc đời.',
        explanation: '"在我看来" mở đầu một cách nhã nhặn để trình bày nhân sinh quan cá nhân về hạnh phúc.'
      },
      {
        chinese: '总的来说，这次文化交流活动不仅增进了友谊，也取得了丰硕的成果。',
        pinyin: 'Zǒng de lái shuō, zhè cì wénhuà jiāoliú huódòng bùjǐn zēngjìn le yǒuyì, yě qǔdé le fēngshuò de chéngguǒ.',
        translation_vi: 'Nhìn chung mà nói, hoạt động giao lưu văn hóa lần này chẳng những thắt chặt tình hữu nghị mà còn đạt được những thành quả phong phú.',
        explanation: '"总的来说" đứng đầu câu để đúc kết toàn diện thành công của chuyến giao lưu.'
      }
    ]
  },
  {
    order_index: 103,
    name: 'Cấu trúc cố định phân tích dẫn chứng điển hình: "拿...来说" (Lấy... làm ví dụ / Xét về)',
    pattern: '拿 + Ví dụ điển hình + 来说, Mệnh đề phân tích chi tiết',
    category: 'Cấu trúc cố định',
    explanation_vi: '"拿...来说" (ná... lái shuō) dùng để dẫn ra một cá nhân, sự việc hoặc ví dụ điển hình tiêu biểu nhất để minh họa sinh động cho một luận điểm, quy luật chung vừa được nêu ra trước đó (lấy... làm ví dụ mà nói, xét riêng trường hợp...).',
    examples: [
      {
        chinese: '中国这几年的移动支付发展极为迅速，拿老年人来说，他们出门买菜也用手机扫码。',
        pinyin: 'Zhōngguó zhè jǐ nián de yídòng zhīfù fāzhǎn jíwéi xùnsù, ná lǎoniánrén láishuō, tāmen chūmén mǎicài yě yòng shǒujī sǎomǎ.',
        translation_vi: 'Thanh toán di động những năm gần đây của Trung Quốc phát triển cực kỳ nhanh chóng, lấy người cao tuổi làm ví dụ, họ ra ngoài mua rau cũng dùng điện thoại quét mã.',
        explanation: '"拿老年人来说" chọn nhóm người cao tuổi làm minh chứng thuyết phục cho sự phổ cập của công nghệ.'
      },
      {
        chinese: '学习外语需要持之以恒，拿背单词来说，三天打鱼两天晒网是很难记牢的。',
        pinyin: 'Xuéxí wàiyǔ xūyào chízhīyǐhéng, ná bèi dāncí láishuō, sān tiān dǎ yú liǎng tiān shài wǎng shì hěn nán jì láo de.',
        translation_vi: 'Học ngoại ngữ cần sự kiên trì bền bỉ, xét về khâu học thuộc từ vựng, nếu bữa đực bữa cái thì rất khó ghi nhớ lâu bền.',
        explanation: '"拿背单词来说" lấy công đoạn học từ vựng cụ thể làm ví dụ chứng minh sự cần thiết của tính kiên trì.'
      }
    ]
  },
  {
    order_index: 104,
    name: 'Cấu trúc cố định định danh và giải thích bản chất: "所谓的..." & "也就是说..."',
    pattern: '所谓的 + Danh từ/Khái niệm + 就是... / Mệnh đề 1, 也就是说, Mệnh đề 2 (giải thích tương đương)',
    category: 'Cấu trúc cố định',
    explanation_vi: '"所谓的..." (suǒwèi de...) dùng để đưa ra hoặc định nghĩa một thuật ngữ, khái niệm chuyên môn (cái gọi là...); trong khi "也就是说..." (yějiùshìshuō) đóng vai trò diễn giải lại câu nói hoặc mệnh đề phía trước bằng từ ngữ đơn giản, dễ hiểu hơn hoặc rút ra kết luận trực tiếp (tức là, nói cách khác).',
    examples: [
      {
        chinese: '所谓的团队合作，就是每个成员都发挥自己的特长并密切配合。',
        pinyin: 'Suǒwèi de tuánduì hézuò, jiù shì měi gè chéngyuán dōu fāhuī zìjǐ de tècháng bìng mìqiè pèihé.',
        translation_vi: 'Cái gọi là tinh thần làm việc nhóm, chính là mỗi thành viên đều phát huy sở trường của mình và phối hợp chặt chẽ.',
        explanation: '"所谓的团队合作..." định nghĩa và làm sáng tỏ bản chất cốt lõi của khái niệm hợp tác tập thể.'
      },
      {
        chinese: '考试成绩达到六十分才算及格，也就是说，五十九分也必须重新补考。',
        pinyin: 'Kǎoshì chéngjì dádào liùshí fēn cái suàn jígé, yějiùshìshuō, wǔshíjiǔ fēn yě bìxū chóngxīn bǔkǎo.',
        translation_vi: 'Điểm thi đạt 60 điểm mới tính là qua môn, tức là nói, 59 điểm cũng bắt buộc phải thi lại.',
        explanation: '"也就是说..." giải thích hệ quả trực tiếp cụ thể hóa của quy định điểm sàn.'
      }
    ]
  }
];
