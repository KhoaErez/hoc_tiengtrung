// ==============================================================================
// DATA: data_hsk5_grammar_part2.mjs
// HSK 5 GRAMMAR - PART 2: ĐIỂM 29 ĐẾN 56 (CHUẨN GF 0025-2021 APPENDIX A)
// Phó từ ngữ khí chuyên sâu, Thời gian, Phạm vi & Giới từ nguyên nhân nền tảng HSK 5
// ==============================================================================

export const HSK5_GRAMMAR_PART2 = [
  {
    order_index: 29,
    name: 'Phó từ quy chuẩn bình đẳng tuyệt đối "一律" (Nhất loạt / Tất cả như nhau)',
    pattern: 'Chủ ngữ (số nhiều/phạm vi) + 一律 + Động từ / Tính từ',
    category: 'Phó từ',
    explanation_vi: '"一律" (yílǜ) là phó từ mang tính quy phạm pháp lý và thể chế cao cấp, biểu thị toàn bộ mọi đối tượng, trường hợp trong phạm vi quy định đều được đối xử hoặc thực hiện hoàn toàn giống nhau, tuyệt đối không có bất kỳ ngoại lệ hay sự phân biệt nào (nhất loạt, đều như nhau). Thường dùng trong các thông báo, nội quy, nghị định chính thức.',
    examples: [
      {
        chinese: '根据考场纪律，所有考生的电子通信设备一律关机并统一存放。',
        pinyin: 'Gēnjù kǎochǎng jìlǜ, suǒyǒu kǎoshēng de diànzǐ tōngxìn shèbèi yílǜ guānjī bìng tǒngyī cúnfàng.',
        translation_vi: 'Căn cứ theo kỷ luật phòng thi, thiết bị thông tin điện tử của tất cả thí sinh nhất loạt phải tắt nguồn và nộp lưu giữ tập trung.',
        explanation: '"一律关机" thể hiện tính nghiêm minh không có bất kỳ ngoại lệ nào trong quy chế phòng thi.'
      },
      {
        chinese: '本商场在周年庆期间，全场商品一律享受八五折优惠。',
        pinyin: 'Běn shāngchǎng zài zhōuniánqìng qījiān, quán chǎng shāngpǐn yílǜ xiǎngshòu bāwǔzhé yōuhuì.',
        translation_vi: 'Trung tâm thương mại này trong thời gian đại lễ kỷ niệm, toàn bộ hàng hóa nhất loạt được hưởng ưu đãi giảm giá 15%.',
        explanation: '"一律享受..." áp dụng mức ưu đãi bình đẳng đồng loạt cho mọi sản phẩm.'
      }
    ]
  },
  {
    order_index: 30,
    name: 'Phó từ bao quát triệt để không sót "统统" (Toàn bộ / Tuốt tuột / Tất thảy)',
    pattern: 'Chủ ngữ / Tân ngữ đảo + 统统 + Động từ (扔掉 / 交出来 / 忘记)',
    category: 'Phó từ',
    explanation_vi: '"统统" (tǒngtǒng) là phó từ tương đương với "全都" (tất cả, toàn bộ), nhưng mang sắc thái dứt khoát, triệt để và sinh động hơn, biểu thị không chừa lại một cá thể hay đồ vật nào (toàn bộ, tuốt tuột). Thường dùng khi thu dọn đồ đạc, giao nộp hoặc gạt bỏ cảm xúc.',
    examples: [
      {
        chinese: '搬家前夕，他把那些积累多年的旧报纸和破箱子统统扔掉了。',
        pinyin: 'Bānjiā qiánxī, tā bǎ nàxiē jīlěi duō nián de jiù bàozhǐ hé pò xiāngzi tǒngtǒng rēngdiào le.',
        translation_vi: 'Vào đêm trước ngày chuyển nhà, anh ấy đã vứt tuốt tuột đống báo cũ và thùng giấy hỏng tích tụ nhiều năm.',
        explanation: '"统统扔掉" diễn tả hành động dọn dẹp sạch sẽ dứt khoát không giữ lại thứ gì.'
      },
      {
        chinese: '经过一个星期的封闭集训，学员们统统掌握了急救的基本操作规范。',
        pinyin: 'Jīngguò yí gè xīngqī de fēngbì jíxùn, xuéyuánmen tǒngtǒng zhǎowò le jíjiù de jīběn cāozuò guīfàn.',
        translation_vi: 'Sau một tuần huấn luyện tập trung khép kín, các học viên đều nắm vững toàn bộ quy chuẩn thao tác sơ cứu cơ bản.',
        explanation: '"统统掌握了" biểu thị 100% học viên đều đạt tiêu chuẩn đầu ra huấn luyện y tế.'
      }
    ]
  },
  {
    order_index: 31,
    name: 'Phó từ hoãn binh tạm thời "暂且" (Tạm thời / Trước mắt cứ gác lại)',
    pattern: 'Chủ ngữ + 暂且 + Động từ + (不/放/搁/等) / 暂且不论',
    category: 'Phó từ',
    explanation_vi: '"暂且" (zànqiě) là phó từ văn viết trang trọng tương đương với "姑且" hoặc "暂时", mang ý nghĩa hoãn lại một sự việc, hành động để tập trung giải quyết vấn đề cấp bách hơn trước mắt (tạm thời cứ thế, trước mắt tạm gác sang một bên). Cụm từ cố định kinh điển: "暂且不论" (tạm thời chưa bàn tới khía cạnh này).',
    examples: [
      {
        chinese: '这笔资金的后续来源暂且不论，眼下当务之急是先把工程材料采购到位。',
        pinyin: 'Zhè bǐ zījīn de hòuxù láiyuán zànqiě búlùn, yǎnxià dāngwùzhījí shì xiān bǎ gōngchéng cáiliào cǎigòu dàowèi.',
        translation_vi: 'Nguồn gốc tiếp theo của khoản vốn này tạm thời chưa bàn tới, nhiệm vụ cấp bách trước mắt là phải mua sắm đầy đủ vật liệu công trình trước.',
        explanation: '"暂且不论" phân định rõ việc nào nên gác lại để ưu tiên việc sống còn trước mắt.'
      },
      {
        chinese: '天色已经很晚了，关于这个方案的分歧我们暂且搁置，明天再作定夺。',
        pinyin: 'Tiānsè yǐjīng hěn wǎn le, guānyú zhè ge fāng\'àn de fēnqí wǒmen zànqiě gēzhì, míngtiān zài zuò dìngduó.',
        translation_vi: 'Trời đã rất muộn rồi, về những bất đồng của phương án này chúng ta tạm thời gác lại, ngày mai hãy đưa ra quyết định cuối cùng.',
        explanation: '"暂且搁置" biểu thị quyết định thông minh tạm hoãn tranh luận để nghỉ ngơi hồi phục trí lực.'
      }
    ]
  },
  {
    order_index: 32,
    name: 'Phó từ chấp nhận giả định tạm thời "姑且" (Tạm thời coi như / Hãy cứ)',
    pattern: '姑且 + Động từ (相信 / 试一试 / 承认 / 听之 / 算作)',
    category: 'Phó từ',
    explanation_vi: '"姑且" (gūqiě) mang ý nghĩa người nói dù chưa hoàn toàn tin tưởng hoặc chưa chắc chắn 100%, nhưng trong hoàn cảnh hiện tại sẵn sàng tạm thời chấp nhận, thử nghiệm hoặc nhượng bộ một bước để quan sát diễn biến tiếp theo (hãy cứ coi như, tạm thời hãy thử xem sao).',
    examples: [
      {
        chinese: '虽然他的理由听起来有些牵强，但我们姑且相信他一次，给他一个机会。',
        pinyin: 'Suīrán tā de lǐyóu tīng qǐlai yǒuxiē qiānqiǎng, dàn wǒmen gūqiě xiāngxìn tā yí cì, gěi tā yí gè jīhuì.',
        translation_vi: 'Tuy rằng lý do của anh ta nghe chừng có phần gượng gạo, nhưng chúng ta hãy cứ tạm tin anh ta một lần, cho anh ta một cơ hội.',
        explanation: '"姑且相信他一次" thể hiện sự bao dung thử thách lòng tin dù đối phương đưa ra lý do chưa thuyết phục.'
      },
      {
        chinese: '这个新颖的设计思路虽然还不成熟，我们姑且可以在实验室里小规模测试一下。',
        pinyin: 'Zhè ge xīnyǐng de shèjì sīlù suīrán hái bù chéngshú, wǒmen gūqiě kěyǐ zài shíyànshì lǐ xiǎoguīmó cèshì yíxià.',
        translation_vi: 'Ý tưởng thiết kế mới mẻ này tuy rằng chưa hoàn thiện, chúng ta hãy cứ thử nghiệm quy mô nhỏ trong phòng thí nghiệm xem sao.',
        explanation: '"姑且可以在...测试" biểu thị thái độ cởi mở chấp nhận thử nghiệm ý tưởng khoa học mới.'
      }
    ]
  },
  {
    order_index: 33,
    name: 'Phó từ dấn thân quả cảm không màng gian khổ "毅然" (Kiên quyết / Quả quyết / Dứt khoát dấn thân)',
    pattern: 'Chủ ngữ + 毅然 + Động từ (放弃 / 决定 / 投身 / 踏上 / 回国)',
    category: 'Phó từ',
    explanation_vi: '"毅然" (yìrán) miêu tả một quyết định dũng cảm, dứt khoát dấn thân làm một việc lớn lao hoặc từ bỏ điều kiện êm ấm để hy sinh vì lý tưởng, nghĩa vụ hoặc quốc gia (kiên quyết, dũng cảm quyết định). Thường dùng trong các văn cảnh ca ngợi nhân cách cao đẹp như 毅然回国 (kiên quyết về nước), 毅然投身 (quả quyết dấn thân).',
    examples: [
      {
        chinese: '完成学业后，他毅然放弃了国外优厚的生活待遇，回国投身西部乡村教育。',
        pinyin: 'Wánchéng xuéyè hòu, tā yìrán fàngqì le guówài yōuhòu de shēnghuó dàiyù, huíguó tóushēn xībù xiāngcūn jiàoyù.',
        translation_vi: 'Sau khi hoàn thành chương trình học, anh ấy đã kiên quyết từ bỏ chế độ đãi ngộ hậu hĩnh ở nước ngoài, trở về nước dấn thân vào sự nghiệp giáo dục nông thôn miền Tây.',
        explanation: '"毅然放弃...回国投身..." tôn vinh lý tưởng cống hiến quên mình của người trí thức trẻ.'
      },
      {
        chinese: '在国家最危难的历史时刻，无数热血青年毅然奔赴抗战前线。',
        pinyin: 'Zài guójiā zuì wēinàn de lìshǐ shíkè, wúshù rèxiè qīngnián yìrán bēnfù kàngzhàn qiánxiàn.',
        translation_vi: 'Vào thời khắc lịch sử nguy nan nhất của đất nước, vô số thanh niên nhiệt huyết đã quả quyết xông pha ra tiền tuyến kháng chiến.',
        explanation: '"毅然奔赴前线" khắc họa ý chí kiên cường xả thân cứu nước của cả một thế hệ.'
      }
    ]
  },
  {
    order_index: 34,
    name: 'Phó từ sực tỉnh hoặc chuyển biến bất ngờ "猛然" (Đột nhiên / Sực tỉnh / Giật mình)',
    pattern: 'Chủ ngữ + 猛然 + Động từ (醒悟 / 发现 / 意识到 / 回过头 / 站起来)',
    category: 'Phó từ',
    explanation_vi: '"猛然" (měngrán) biểu thị hành động hoặc hoạt động nhận thức biến đổi đột ngột với cường độ mạnh mẽ, bất ngờ trong một khoảnh khắc rất ngắn (sực nhớ ra, bừng tỉnh, giật mình thảng thốt). Khác với "突然", "猛然" nhấn mạnh sự đột ngột của cú sốc tinh thần hoặc sự sực nhận ra chân tướng.',
    examples: [
      {
        chinese: '听到远处传来的急刹车声，他猛然停下脚步并机警地回头看去。',
        pinyin: 'Tīngdào yuǎnchù chuánlái de jíshāchē shēng, tā měngrán tíngxià jiǎobù bìng jījǐng de huítóu kàn qù.',
        translation_vi: 'Nghe thấy tiếng phanh xe gấp từ đằng xa vọng lại, anh ấy giật mình dừng phắt bước chân và cảnh giác quay đầu nhìn lại.',
        explanation: '"猛然停下脚步" miêu tả phản ứng dừng lại đột ngột trước âm thanh nguy hiểm.'
      },
      {
        chinese: '直到翻出泛黄的旧相册，他才猛然意识到岁月已经悄悄溜走了三十年。',
        pinyin: 'Zhídào fānchū fànhuáng de jiù xiàngcè, tā cái měngrán yìshídào suìyuè yǐjīng qiāoqiāo liūzǒu le sānshí nián.',
        translation_vi: 'Mãi tới khi lật giở cuốn album ảnh cũ ngả vàng, ông ấy mới sực nhận ra năm tháng đã lặng lẽ trôi qua 30 năm ròng.',
        explanation: '"猛然意识到" diễn tả cảm xúc thảng thốt bừng ngộ về sự trôi chảy của thời gian.'
      }
    ]
  },
  {
    order_index: 35,
    name: 'Phó từ quy luật tất yếu không thể đảo ngược "势必" (Ắt hẳn / Thế tất / Chắc chắn sẽ)',
    pattern: 'Hành động hiện tại sai lầm/thiếu sót, 势必 + 会 + Hậu quả xấu tất yếu',
    category: 'Phó từ',
    explanation_vi: '"势必" (shìbì) là phó từ cao cấp kết hợp chữ "势" (thế thế, xu thế) và "必" (ắt, nhất định), mang nghĩa "dựa theo xu thế phát triển khách quan thì chắc chắn tất yếu sẽ dẫn tới một hệ quả nghiêm trọng nào đó" (thế tất, ắt hẳn). Thường dùng trong phân tích chiến lược, cảnh báo chính sách.',
    examples: [
      {
        chinese: '如果不加节制地过度开采地下水资源，势必会引发严重的地面沉降危机。',
        pinyin: 'Rúguǒ bù jiā jiézhì de guòdù kāicǎi dìxiàshuǐ zīyuán, shìbì huì yǐnfā yánzhòng de dìmiàn chénjiàng wēijī.',
        translation_vi: 'Nếu khai thác nước ngầm quá mức không kiêng dè, ắt hẳn sẽ châm ngòi cho cuộc khủng hoảng sụt lún mặt đất nghiêm trọng.',
        explanation: '"势必会引发..." cảnh báo hệ lụy môi trường tất yếu không thể tránh khỏi nếu hủy hoại tài nguyên.'
      },
      {
        chinese: '单方面撕毁国际贸易协定，势必会遭到国际社会的广泛谴责与反制。',
        pinyin: 'Dān fāngmiàn sīhuǐ guójì màoyì xiédìng, shìbì huì zāodào guójì shèhuì de guǎngfàn qiǎnzé yǔ fǎnzhì.',
        translation_vi: 'Đơn phương xé bỏ hiệp định thương mại quốc tế, thế tất sẽ gặp phải sự lên án và trả đũa rộng rãi của cộng đồng quốc tế.',
        explanation: '"势必会遭到..." dự báo kết cục ngoại giao tất yếu của hành vi vi phạm thỏa ước.'
      }
    ]
  },
  {
    order_index: 36,
    name: 'Phó từ phản vấn phủ định lịch sử "何尝" (Nào có / Đâu phải là không / Từng bao giờ)',
    pattern: '何尝 + Phủ định (不想 / 不是 / 不知道) / 何尝 + Khẳng định + 呢',
    category: 'Phó từ',
    explanation_vi: '"何尝" (hécháng) dùng trong câu hỏi tu từ để biểu thị sự thanh minh hoặc khẳng định gián tiếp: 1) "何尝不..." (nào có phải là không) mang ý nghĩa khẳng định mãnh liệt nhưng bất lực (thực tế rất muốn, rất hiểu, nhưng hoàn cảnh trói buộc); 2) "何尝...呢" mang nghĩa phủ định (nào đã từng như vậy bao giờ).',
    examples: [
      {
        chinese: '面对年迈生病的父母，身在异乡打拼的他何尝不想早点儿回家陪伴呢？',
        pinyin: 'Miànduì niánmài shēngbìng de fùmǔ, shēn zài yìxiāng dǎpīn de tā hécháng bù xiǎng zǎodiǎnr huíjiā péibàn ne?',
        translation_vi: 'Đối mặt với cha mẹ già yếu ốm đau, người con đang bươn chải nơi đất khách quê người như anh ấy nào có phải không muốn sớm về nhà bầu bạn cơ chứ?',
        explanation: '"何尝不想...呢" bộc lộ nỗi lòng xót xa của người con xa xứ: thực lòng vô cùng muốn về nhưng bất khả kháng.'
      },
      {
        chinese: '在漫长的创业征程中，我们何尝经历过如此严峻的资金断裂危机？',
        pinyin: 'Zài màncháng de chuàngyè zhēngchéng zhōng, wǒmen hécháng jīnglìguo rúcǐ yánjùn de zījīn duànliè wēijī?',
        translation_vi: 'Trong chặng đường khởi nghiệp dài đằng đẵng, chúng tôi nào đã từng trải qua cuộc khủng hoảng đứt gãy dòng tiền ngặt nghèo đến nhường này?',
        explanation: '"何尝经历过" dùng câu hỏi tu từ khẳng định đây là lần đầu tiên công ty gặp thử thách khốc liệt chưa từng có.'
      }
    ]
  },
  {
    order_index: 37,
    name: 'Phó từ khẳng định uyển chuyển khiêm nhường "未尝" (Chưa từng / Vị tất không phải là)',
    pattern: '未尝 + Phủ định (不可 / 不是 / 没有) / 未尝 + Động từ',
    category: 'Phó từ',
    explanation_vi: '"未尝" (wèicháng) là phó từ văn ngôn cao cấp mang nghĩa "chưa từng" (kết hợp 未: chưa, 尝: từng). Khi kết hợp ở dạng phủ định kép như "未尝不可" (chưa hẳn là không được / cũng có thể chấp nhận), nó biểu đạt một ý kiến nhượng bộ, đồng tình một cách thận trọng, lịch thiệp và sâu sắc.',
    examples: [
      {
        chinese: '如果传统模式走不通，换一个全新的跨界视角未尝不是一种积极的尝试。',
        pinyin: 'Rúguǒ chuántǒng móshì zǒu bù tōng, huàn yí gè quánxīn de kuàjiè shìjiǎo wèicháng bú shì yì zhǒng jījí de chángshì.',
        translation_vi: 'Nếu mô hình truyền thống đi vào bế tắc, đổi sang một góc nhìn xuyên ngành hoàn toàn mới vị tất không phải là một sự thử nghiệm tích cực.',
        explanation: '"未尝不是..." là cấu trúc phủ định kép nhã nhặn khẳng định đổi mới sáng tạo là hướng đi đúng đắn.'
      },
      {
        chinese: '对于年轻人的大胆构想，在严格控制风险的前提下，让他们放手一试也未尝不可。',
        pinyin: 'Duìyú niánqīngrén de dàdǎn gòuxiǎng, zài yángé kòngzhì fēngxiǎn de qiántí xià, ràng tāmen fàngshǒu yí shì yě wèicháng bùkě.',
        translation_vi: 'Đối với ý tưởng táo bạo của người trẻ, dưới tiền đề kiểm soát rủi ro chặt chẽ, để họ tự do thử sức cũng chẳng phải là không được.',
        explanation: '"未尝不可" thể hiện sự cởi mở, đồng ý cho cấp dưới thử nghiệm cơ hội mới.'
      }
    ]
  },
  {
    order_index: 38,
    name: 'Phó từ chỉ sự giới hạn duy nhất "无非" (Chẳng qua là / Không ngoài)',
    pattern: 'Chủ ngữ + 无非是 + Danh từ/Mệnh đề / 无非 + Động từ (想/为了)',
    category: 'Phó từ',
    explanation_vi: '"无非" (wúfēi) tương đương với "不过是" hoặc "只是", mang nghĩa "chẳng qua chỉ là, không ngoài mục đích gì khác". Thường dùng để chỉ rõ bản chất đơn giản của một hiện tượng tưởng chừng phức tạp, hoặc hạ thấp tính chất nghiêm trọng của vấn đề.',
    examples: [
      {
        chinese: '他之所以整天拼命工作加班，无非是想为家人创造一个更好的生活条件。',
        pinyin: 'Tā zhīsuǒyǐ zhěngtiān pīnmìng gōngzuò jiābān, wúfēi shì xiǎng wèi jiārén chuàngzào yí gè gèng hǎo de shēnghuó tiáojiàn.',
        translation_vi: 'Sở dĩ anh ấy suốt ngày làm việc tăng ca bán mạng, chẳng qua cũng chỉ là muốn tạo dựng cho gia đình một điều kiện sống tốt hơn.',
        explanation: '"无非是想..." giải thích động cơ giản dị và nhân văn đằng sau sự vất vả của người trụ cột gia đình.'
      },
      {
        chinese: '商家炒作这些花哨的概念，无非是为了吸引年轻消费者的眼球从而增加销量。',
        pinyin: 'Shāngjiā chǎozuò zhèxiē huāshào de gàiniàn, wúfēi shì wèile xīyǐn niánqīng xiāofèizhě de yǎnqiú cóng\'ér zēngjiā xiàoliàng.',
        translation_vi: 'Thương gia thổi phồng những khái niệm hào nhoáng này, chẳng qua cũng chỉ là nhằm thu hút sự chú ý của người tiêu dùng trẻ để tăng doanh số.',
        explanation: '"无非是为了..." bóc trần mục đích thương mại thuần túy đằng sau chiêu trò quảng cáo.'
      }
    ]
  },
  {
    order_index: 39,
    name: 'Phó từ hành động thẳng mạch không vòng vo "径直" (Đi thẳng / Thẳng một mạch)',
    pattern: 'Chủ ngữ + 径直 + Động từ di chuyển/Hành động (走 / 走向 / 穿过 / 离开)',
    category: 'Phó từ',
    explanation_vi: '"径直" (jìngzhí) biểu thị việc di chuyển thẳng tắp tới một đích đến xác định mà không dừng lại, không rẽ ngang rẽ tắt dọc đường; hoặc biểu thị tiến hành ngay một việc mà không cần trải qua các thủ tục trung gian rườm rà (thẳng một mạch, đi thẳng tới).',
    examples: [
      {
        chinese: '走进办公大楼后，他没有在接待处停留，而是径直朝董事长的办公室走去。',
        pinyin: 'Zǒujìn bàngōng dàlóu hòu, tā méiyǒu zài jiēdàichù tíngliú, érshì jìngzhí cháo dǒngshìzhǎng de bàngōngshì zǒu qù.',
        translation_vi: 'Sau khi bước vào tòa nhà văn phòng, anh ấy không dừng chân ở bàn tiếp tân mà đi thẳng một mạch về phía phòng làm việc của chủ tịch hội đồng quản trị.',
        explanation: '"径直朝...走去" miêu tả bước chân dứt khoát không ngập ngừng tiến thẳng tới phòng lãnh đạo.'
      },
      {
        chinese: '辩论结束后，代表团团长神情凝重，径直穿过记者包围圈乘车离开了会场。',
        pinyin: 'Biànlùn jiéshù hòu, dàibiǎotuán tuánzhǎng shénqíng níngzhòng, jìngzhí chuānguò jìzhě bāowéiquān chéngchē líkāi le huìchǎng.',
        translation_vi: 'Sau khi cuộc tranh luận kết thúc, trưởng đoàn đại biểu nét mặt trang nghiêm, đi thẳng xuyên qua vòng vây nhà báo để lên xe rời khỏi hội trường.',
        explanation: '"径直穿过..." thể hiện hành động di chuyển dứt khoát né tránh phỏng vấn báo chí.'
      }
    ]
  },
  {
    order_index: 40,
    name: 'Phó từ nỗ lực vô ích không kết quả "徒然" (Uổng công / Vô ích / Lãng phí)',
    pattern: 'Chủ ngữ + 徒然 + Động từ (浪费 / 消耗 / 挣扎 / 叹息 / 耗费)',
    category: 'Phó từ',
    explanation_vi: '"徒然" (túrán) là phó từ văn học mang ý nghĩa "chỉ làm một cách vô ích, uổng phí công sức, thời gian mà không thu lại bất kỳ kết quả hay ý nghĩa thiết thực nào" (uổng công vô ích, chỉ tổ phí hoài). Thường mang sắc thái tiếc nuối sâu sắc.',
    examples: [
      {
        chinese: '如果缺乏科学的复习方法，仅仅靠熬夜死记硬背只会徒然消耗宝贵的时间和精力。',
        pinyin: 'Rúguǒ quēfá kēxué de fùxí fāngfǎ, jǐnjǐn kào áoyè sǐjìyìngbèi zhǐ huì túrán xiāohào bǎoguì de shíjiān hé jīnglì.',
        translation_vi: 'Nếu thiếu phương pháp ôn tập khoa học, chỉ dựa vào việc thức đêm học vẹt chỉ làm uổng công tiêu hao thời gian và tinh thần quý báu.',
        explanation: '"徒然消耗..." cảnh báo việc học vẹt không có phương pháp sẽ khiến công sức đổ sông đổ biển.'
      },
      {
        chinese: '与其坐在废墟前徒然悲伤落泪，不如擦干眼泪重整旗鼓重建家园。',
        pinyin: 'Yǔqí zuò zài fèixū qián túrán bēishāng luòlèi, bùrú cāgān yǎnlèi chóngzhěngqígǔ chóngjiàn jiāyuán.',
        translation_vi: 'Thay vì ngồi trước đống tro tàn đổ nát đau buồn rơi lệ trong vô vọng, chi bằng hãy lau khô nước mắt sốc lại tinh thần tái thiết quê hương.',
        explanation: '"徒然悲伤落泪" khuyên người dân biến đau thương thành hành động thực tế xây dựng lại đời sống.'
      }
    ]
  },
  {
    order_index: 41,
    name: 'Phó từ tần suất diễn biến dồn dập "屡屡" (Liên tiếp / Nhiều lần / Dồn dập)',
    pattern: 'Chủ ngữ + 屡屡 + Động từ (获奖 / 受挫 / 创下新高 / 发生)',
    category: 'Phó từ',
    explanation_vi: '"屡屡" (lǚlǚ) là dạng trùng điệp cao cấp của "屡", diễn tả hành động hoặc hiện tượng xuất hiện liên tiếp với tần suất rất cao trong một thời đoạn ngắn (liên tục, dồn dập, nhiều lần). Thường dùng trong tin tức tài chính, thể thao và báo cáo thời sự.',
    examples: [
      {
        chinese: '在这届世界大学生运动会上，我国游泳健儿表现出色，屡屡打破赛事纪录。',
        pinyin: 'Zài zhè jiè shìjiè dàxuéshēng yùndònghuì shang, wǒ guó yóuyǒng jiàn\'ér biǎoxiàn chūsè, lǚlǚ dǎpò sàishì jìlù.',
        translation_vi: 'Tại Đại hội Thể thao Sinh viên Thế giới lần này, các kình ngư nước ta thi đấu xuất sắc, liên tiếp phá vỡ các kỷ lục của giải đấu.',
        explanation: '"屡屡打破纪录" miêu tả chuỗi chiến thắng vang dội nối tiếp nhau của đoàn thể thao.'
      },
      {
        chinese: '国际原油市场受地缘局势影响剧烈波动，期货交易价格屡屡创下历史新高。',
        pinyin: 'Guójì yuányóu shìchǎng shòu dìyuán júshì yǐngxiǎng jùliè bōdòng, qīhuò jiāoyì jiàgé lǚlǚ chuàngxià lìshǐ xīngāo.',
        translation_vi: 'Thị trường dầu thô quốc tế chịu ảnh hưởng của cục diện địa chính trị biến động dữ dội, giá giao dịch hợp đồng tương lai liên tiếp lập đỉnh cao lịch sử mới.',
        explanation: '"屡屡创下新高" phản ánh chuỗi tăng giá dồn dập nhiều phiên liên tục.'
      }
    ]
  },
  {
    order_index: 42,
    name: 'Phó từ biến đổi âm thầm không một tiếng động "悄然" (Lặng lẽ / Âm thầm / Kín đáo)',
    pattern: 'Chủ ngữ + 悄然 + Động từ (发生 / 兴起 / 来临 / 离去 / 改变)',
    category: 'Phó từ',
    explanation_vi: '"悄然" (qiǎorán) là phó từ mang phong vị văn học đậm nét, biểu thị một hiện tượng, sự việc hoặc một trào lưu xã hội diễn ra, lan tỏa một cách vô cùng êm ả, kín đáo, không ồn ào khoa trương mà tự nhiên thấm sâu vào đời sống (âm thầm, lặng lẽ). Khác với "悄悄" (khẩu ngữ đời thường), "悄然" dùng cho sự chuyển dịch của thời gian, mùa màng hoặc phong cách sống.',
    examples: [
      {
        chinese: '随着移动互联网技术的飞速普及，一种绿色低碳的生活方式正在全社会悄然兴起。',
        pinyin: 'Suízhe yídòng hùliánwǎng jìshù de fēisù pǔjí, yì zhǒng lǜsè dītàn de shēnghuó fāngshì zhèngzài quán shèhuì qiǎorán xīngqǐ.',
        translation_vi: 'Cùng với sự phổ cập thần tốc của công nghệ internet di động, một lối sống xanh giảm thiểu carbon đang âm thầm trỗi dậy trong toàn xã hội.',
        explanation: '"悄然兴起" miêu tả xu hướng văn minh đô thị lan tỏa tự nhiên, êm dịu không cần hô hào khẩu hiệu.'
      },
      {
        chinese: '不知不觉中，秋天已经悄然来临，公园里的枫叶逐渐染上了绚烂的红色。',
        pinyin: 'Bùzhībùjué zhōng, qiūtiān yǐjīng qiǎorán láilín, gōngyuán lǐ de fēngyè zhújiàn rǎnshàng le xuànlàn de hóngsè.',
        translation_vi: 'Trong sự vô thức không nhận ra, mùa thu đã lặng lẽ tới tự bao giờ, lá phong trong công viên dần nhuộm sắc đỏ rực rỡ.',
        explanation: '"悄然来临" khắc họa bước chân chuyển mùa nhẹ nhàng của thiên nhiên vũ trụ.'
      }
    ]
  },
  {
    order_index: 43,
    name: 'Phó từ chỉ sự biến đổi trạng thái tức thì "顿时" (Lập tức / Tức khắc / Thoắt cái)',
    pattern: 'Biến cố xuất hiện, Chủ ngữ / Không gian + 顿时 + Động từ/Tính từ (沸腾 / 安静 / 亮了起来)',
    category: 'Phó từ',
    explanation_vi: '"顿时" (dùnshí) là phó từ chỉ thời gian trong quá khứ hoặc hiện thực, biểu thị ngay sau khi một kích thích hoặc biến cố xảy ra, toàn bộ cục diện, bầu không khí hoặc trạng thái tâm lý lập tức thay đổi toàn diện trong nháy mắt (tức thì, thoắt cái). Khác với "立刻", "顿时" chuyên dùng miêu tả bầu không khí và cảnh tượng tập thể.',
    examples: [
      {
        chinese: '当舞台上的灯光骤然亮起时，喧闹的剧场大厅顿时变得鸦雀无声。',
        pinyin: 'Dāng wǔtái shang de dēngguāng zhòurán liàngqǐ shí, xuānnào de jùchǎng dàtīng dùnshí biànde yāquèwúshēng.',
        translation_vi: 'Khi ánh đèn trên sân khấu đột ngột bừng sáng, đại sảnh nhà hát đang ồn ào thoắt cái trở nên im phăng phắc không một tiếng động.',
        explanation: '"顿时变得鸦雀无声" miêu tả sự biến đổi chuyển trạng thái âm thanh tức thì của cả khán phòng.'
      },
      {
        chinese: '听到航天飞船成功着陆的播报，指挥控制中心顿时沸腾了起来。',
        pinyin: 'Tīngdào hángtiān fēichuán chénggōng zhuólù de bōbào, zhǐhuī kòngzhì zhōngxīn dùnshí fèiténg le qǐlái.',
        translation_vi: 'Nghe bản tin tàu vũ trụ đã hạ cánh thành công, trung tâm chỉ huy điều khiển lập tức vỡ òa sôi động hẳn lên.',
        explanation: '"顿时沸腾了起来" lột tả bầu không khí vỡ òa sung sướng bùng nổ của toàn thể kỹ sư.'
      }
    ]
  },
  {
    order_index: 44,
    name: 'Cụm phó từ khoảnh khắc cực ngắn "刹那间" (Trong chớp mắt / Trong khoảnh khắc)',
    pattern: '刹那间, Mệnh đề biến cố / Chủ ngữ + 刹那间 + Vị ngữ',
    category: 'Phó từ',
    explanation_vi: '"刹那间" (chànàjiān) có nguồn gốc từ thuật ngữ Phật giáo "sát-na" (khoảnh khắc thời gian ngắn nhất chớp mắt). Dùng để đặc tả một sự kiện diễn ra nhanh như tia chớp, vượt quá tốc độ phản xạ thông thường của mắt người, tạo ấn tượng kịch tính phi thường.',
    examples: [
      {
        chinese: '一道耀眼的闪电撕破了夜空，刹那间照亮了整座沉睡中的城市。',
        pinyin: 'Yí dào yàoyǎn de shǎndiàn sīpò le yèkōng, chànàjiān zhàoliàng le zhěng zuò chénshuì zhōng de chéngshì.',
        translation_vi: 'Một tia chớp chói lòa xé toạc màn trời đêm, trong chớp mắt đã rọi sáng rực toàn bộ thành phố đang say ngủ.',
        explanation: '"刹那间照亮..." đặc tả ánh sáng sấm sét lóe lên cực nhanh chiếu rọi không gian vạn vật.'
      },
      {
        chinese: '听到自己名字被宣布为获奖者的一瞬间，他脑海中刹那间闪过无数奋斗的日夜。',
        pinyin: 'Tīngdào zìjǐ míngzi bèi xuānbù wéi huòjiǎngzhě de yí shùnjiān, tā nǎohǎi zhōng chànàjiān shǎnguò wúshù fèndòu de rìyè.',
        translation_vi: 'Ngay khoảnh khắc nghe thấy tên mình được xướng lên là người đoạt giải, trong tâm trí anh ấy chỉ trong một chớp mắt đã vụt qua vô số ngày đêm phấn đấu.',
        explanation: '"刹那间闪过..." diễn tả dòng hồi ức hiện về nhanh như một cuốn phim tua tốc độ cao.'
      }
    ]
  },
  {
    order_index: 45,
    name: 'Phó từ liên tục tiếp diễn thời gian "随即" (Liền ngay sau đó / Ngay tắp lự)',
    pattern: 'Hành động 1 hoàn thành, (Chủ ngữ) + 随即 + Hành động 2',
    category: 'Phó từ',
    explanation_vi: '"随即" (suíjí) là phó từ cao cấp tương đương với "接着" hoặc "立刻", biểu thị hành động thứ hai diễn ra liền ngay sau khi hành động thứ nhất vừa kết thúc mà không có bất kỳ khoảng trống thời gian gián đoạn nào (ngay sau đó, lập tức tiếp theo). Thường dùng trong báo cáo công tác và tin tức chính thức.',
    examples: [
      {
        chinese: '两国元首举行了亲切友好的正式会晤，随即共同出席了联合记者招待会。',
        pinyin: 'Liǎng guó yuánshǒu jǔxíng le qīnqiè yǒuhǎo de zhèngshì huìwù, suíjí gòngtóng chūxí le liánhé jìzhě zhāodàihuì.',
        translation_vi: 'Nguyên thủ hai nước đã tiến hành cuộc hội đàm chính thức thân mật và hữu nghị, ngay sau đó đã cùng nhau tham dự buổi họp báo chung với các phóng viên.',
        explanation: '"随即共同出席..." liên kết nhịp nhàng hai lịch trình đối ngoại ngoại giao cấp cao nối tiếp nhau.'
      },
      {
        chinese: '救援人员迅速将伤员从废墟中救出，随即用直升机转运往最近的急救中心。',
        pinyin: 'Jiùyuán rényuán xùnsù jiāng shāngyuán cóng fèixū zhōng jiùchū, suíjí yòng zhíshēngjī zhuǎnyùn wǎng zuì jìn de jíjiù zhōngxīn.',
        translation_vi: 'Lực lượng cứu hộ nhanh chóng cứu người bị thương ra khỏi đống đổ nát, ngay sau đó đã dùng trực thăng chuyển thẳng tới trung tâm cấp cứu gần nhất.',
        explanation: '"随即用直升机转运" thể hiện quy trình cấp cứu khẩn cấp chạy đua với thời gian liên tục.'
      }
    ]
  },
  {
    order_index: 46,
    name: 'Phó từ xu thế tương lai chắc chắn xảy ra "迟早" (Sớm muộn gì / Không sớm thì muộn)',
    pattern: 'Chủ ngữ + 迟早 + (会 / 要) + Kết quả tất yếu',
    category: 'Phó từ',
    explanation_vi: '"迟早" (chízǎo) kết hợp hai chữ "迟" (muộn) và "早" (sớm), biểu thị một kết quả hoặc hiện tượng dù hiện tại chưa xuất hiện nhưng trong tương lai nhất định sẽ xảy ra theo quy luật nhân quả tất yếu (sớm muộn gì cũng, chẳng sớm thì muộn). Thường dùng để khuyên răn, cảnh báo hoặc bày tỏ niềm tin kiên định.',
    examples: [
      {
        chinese: '只要坚持脚踏实地努力付出，你的才华迟早会得到社会的公正认可。',
        pinyin: 'Zhǐyào jiānchí jiǎotàshídì nǔlì fùchū, nǐ de cáihuá chízǎo huì dédào shèhuì de gōngzhèng rènkě.',
        translation_vi: 'Chỉ cần kiên trì nỗ lực hết mình từng bước vững chắc, tài năng của bạn sớm muộn gì cũng sẽ nhận được sự công nhận công bằng của xã hội.',
        explanation: '"迟早会得到..." động viên người trẻ kiên định niềm tin vào giá trị bản thân trong tương lai.'
      },
      {
        chinese: '任何企图掩盖真相的不法行为，迟早会被法律的利剑公之于众并受到严惩。',
        pinyin: 'Rènhé qǐtú yǎngài zhēnxiàng de bùfǎ xíngwéi, chízǎo huì bèi fǎlǜ de lìjiàn gōngzhīyúzhòng bìng shòudào yánchéng.',
        translation_vi: 'Bất kỳ hành vi phi pháp nào mưu toan che đậy sự thật, sớm muộn gì cũng sẽ bị thanh gươm pháp luật phơi bày trước công chúng và trừng trị thích đáng.',
        explanation: '"迟早会被..." khẳng định công lý tất thắng và sự trừng phạt tất yếu của pháp luật.'
      }
    ]
  },
  {
    order_index: 47,
    name: 'Giới từ xem xét tình hình thực tế "鉴于" (Xét thấy / Nhận thấy / Do thấy)',
    pattern: '鉴于 + Tình hình thực tế / Bối cảnh khách quan, Mệnh đề quyết định chính sách',
    category: 'Giới từ',
    explanation_vi: '"鉴于" (jiànyú) là giới từ chính luận cao cấp dùng ở đầu câu, dẫn ra một thực trạng, một nguyên nhân khách quan hoặc một kinh nghiệm quá khứ làm căn cứ quan trọng để cơ quan, tổ chức đưa ra một chính sách, biện pháp ứng phó phù hợp (xét thấy tình hình này, do nhận thấy bối cảnh trên).',
    examples: [
      {
        chinese: '鉴于近期沿海地区台风活动频繁，海事部门发布了全线禁航的安全警示。',
        pinyin: 'Jiànyú jìnqī yánhǎi dìqū táifēng huódòng pínfán, hǎishì bùmén fābù le quánxiàn jìnháng de ānquán jǐngshì.',
        translation_vi: 'Xét thấy thời gian gần đây bão tại các vùng ven biển hoạt động dồn dập, cơ quan hải sự đã ban bố cảnh báo an toàn cấm tàu bè ra khơi trên toàn tuyến.',
        explanation: '"鉴于近期沿海地区台风活动频繁" nêu ra căn cứ thời tiết khách quan để ban hành lệnh cấm tàu bè.'
      },
      {
        chinese: '鉴于该员工在过去一年中的突出业务贡献，董事会决定破格提拔其为部门总监。',
        pinyin: 'Jiànyú gāi yuángōng zài guòqù yì nián zhōng de tūchū yèwù gòngxiàn, dǒngshìhuì juédìng pògé tíbá qí wéi bùmén zǒngjiān.',
        translation_vi: 'Xét thấy những cống hiến nghiệp vụ xuất chúng của nhân viên này trong một năm qua, hội đồng quản trị đã quyết định đặc cách cất nhắc anh làm giám đốc bộ phận.',
        explanation: '"鉴于...突出业务贡献" là lý do chính đáng để doanh nghiệp bổ nhiệm nhân tài vượt cấp.'
      }
    ]
  },
  {
    order_index: 48,
    name: 'Giới từ xây dựng trên nền tảng lý luận "基于" (Dựa trên / Căn cứ vào / Trên cơ sở)',
    pattern: '基于 + Nền tảng lý luận / Dữ liệu nghiên cứu / Khảo sát, Mệnh đề kết luận',
    category: 'Giới từ',
    explanation_vi: '"基于" (jīyú) chỉ cơ sở khoa học, nền tảng lý luận, số liệu thống kê hoặc mô hình thực nghiệm làm bệ phóng để xây dựng phương án, giải thuật hoặc kết luận nghiên cứu (dựa trên nền tảng, căn cứ trên cơ sở). Khác với "鉴于" (thiên về thời thế, rủi ro), "基于" thiên về dữ liệu và học thuật.',
    examples: [
      {
        chinese: '该科研团队基于海量临床实验数据，研发出了一种全新的抗癌靶向药物。',
        pinyin: 'Gāi kēyán tuánduì jīyú hǎiliàng línchuáng shíyàn shùjù, yánfā chū le yì zhǒng quánxīn de kàng\'ái bǎxiàng yàowù.',
        translation_vi: 'Nhóm nghiên cứu khoa học này dựa trên nguồn dữ liệu thử nghiệm lâm sàng khổng lồ, đã nghiên cứu phát triển thành công một loại thuốc nhắm trúng đích chống ung thư hoàn toàn mới.',
        explanation: '"基于海量临床实验数据" khẳng định nền tảng khoa học thực nghiệm vững chắc của phát minh dược phẩm.'
      },
      {
        chinese: '基于对全球消费市场长期趋势的深入分析，公司制定了未来五年的出海战略。',
        pinyin: 'Jīyú duì quánqiú xiāofèi shìchǎng chángqī qūshì de shēnrù fēnxī, gōngsī zhìdìng le wèilái wǔ nián de chūhǎi zhànlüè.',
        translation_vi: 'Dựa trên sự phân tích sâu sắc đối với xu thế dài hạn của thị trường tiêu dùng toàn cầu, công ty đã đề ra chiến lược vươn ra biển lớn trong 5 năm tới.',
        explanation: '"基于对...深入分析" làm rõ việc lập kế hoạch kinh doanh xuất phát từ dữ liệu nghiên cứu thị trường bài bản.'
      }
    ]
  },
  {
    order_index: 49,
    name: 'Giới từ xuất phát từ động cơ tâm lý "出于" (Xuất phát từ / Do / Vì)',
    pattern: '出于 + Động cơ/Mục đích (好意 / 好奇 / 同情 / 安全考虑 / 礼貌), Mệnh đề',
    category: 'Giới từ',
    explanation_vi: '"出于" (chūyú) dẫn ra động cơ nội tâm, ý định ban đầu hoặc sự cân nhắc xuất phát từ tấm lòng, sự đồng cảm hoặc đạo đức nghề nghiệp của con người (xuất phát từ, vì lý do). Thường kết hợp với các từ như 好奇, 好心, 礼貌, 谨慎, 责任感, 人道主义.',
    examples: [
      {
        chinese: '他当时之所以伸出援手，完全是出于一位普通公民最本能的善良与同情心。',
        pinyin: 'Tā dāngshí zhīsuǒyǐ shēnchū yuánshǒu, wánquán shì chūyú yí wèi pǔtōng gōngmín zuì běnnéng de shànliáng yǔ tóngqíngxīn.',
        translation_vi: 'Sở dĩ lúc đó anh ấy đưa tay giúp đỡ, hoàn toàn là xuất phát từ lòng lương thiện và sự đồng cảm bản năng nhất của một công dân bình thường.',
        explanation: '"出于...善良与同情心" làm sáng tỏ động cơ nhân văn cao đẹp của nghĩa cử cứu giúp người khác.'
      },
      {
        chinese: '出于保护未成年人身心健康的考虑，国家严格限制了网络游戏的服务时长。',
        pinyin: 'Chūyú bǎohù wèichéngniánrén shēnxīn jiànkāng de kǎolǜ, guójiā yángé xiànzhì le wǎngluò yóuxì de fúwù shícháng.',
        translation_vi: 'Xuất phát từ sự cân nhắc bảo vệ sức khỏe thể chất và tinh thần của trẻ vị thành niên, nhà nước đã hạn chế nghiêm ngặt thời lượng phục vụ của trò chơi điện tử trực tuyến.',
        explanation: '"出于保护...的考虑" giải thích nguyên nhân nhân văn đằng sau chính sách giới hạn giờ chơi game.'
      }
    ]
  },
  {
    order_index: 50,
    name: 'Giới từ men theo tuyến đường địa lý "沿着" (Men theo / Dọc theo)',
    pattern: 'Chủ ngữ + 沿着 + Tuyến đường/Dòng sông/Bờ biển + Động từ di chuyển (走/跑/巡逻/行驶)',
    category: 'Giới từ',
    explanation_vi: '"沿着" (yánzhe) biểu thị hành động di chuyển tuân thủ bám sát theo một tuyến đường dài có sẵn như dòng sông, bờ biển, con đường, đường ray hoặc tuyến cáp (men theo, dọc theo con đường). Ngoài ra còn dùng ẩn dụ: "沿着...道路前进" (tiến bước theo con đường lý tưởng).',
    examples: [
      {
        chinese: '夏日的傍晚，许多市民喜欢沿着风景秀丽的江边绿道散步乘凉。',
        pinyin: 'Xiàrì de bàngwǎn, xǔduō shìmín xǐhuan yánzhe fēngjǐng xiùlì de jiāngbiān lǜdào sànbù chéngliáng.',
        translation_vi: 'Vào chiều tối mùa hè, rất nhiều người dân thành phố thích đi dạo hóng mát men theo con đường xanh ven sông phong cảnh tươi đẹp.',
        explanation: '"沿着...江边绿道散步" miêu tả lộ trình đi dạo bám sát cảnh quan bờ sông mát rượi.'
      },
      {
        chinese: '全体官兵将始终坚定不移地沿着中国特色强军之路奋勇向前。',
        pinyin: 'Quántǐ guānbīng jiāng shǐzhōng jiāndìngbùyí de yánzhe Zhōngguó tèsè qiángjūn zhī lù fènyǒng xiàngqián.',
        translation_vi: 'Toàn thể cán bộ chiến sĩ sẽ luôn kiên định không dời vững bước tiến lên dọc theo con đường xây dựng quân đội hùng mạnh mang đặc sắc Trung Quốc.',
        explanation: '"沿着...之路奋勇向前" dùng "沿着" theo nghĩa ẩn dụ chính luận về con đường lý tưởng cách mạng.'
      }
    ]
  },
  {
    order_index: 51,
    name: 'Giới từ lần theo manh mối hoặc xuôi chiều "顺着" (Xuôi theo / Lần theo / Thuận theo)',
    pattern: '顺着 + Hướng dòng chảy / Manh mối / Tiếng động, Chủ ngữ + Động từ',
    category: 'Giới từ',
    explanation_vi: '"顺着" (shùnzhe) có ba nghĩa chính: 1) Thuận theo hướng chuyển động tự nhiên (như 顺着水流 - xuôi theo dòng nước, 顺着风向 - thuận theo chiều gió); 2) Lần theo dấu vết, âm thanh hoặc manh mối để tìm kiếm (như 顺着声音看去 - nhìn theo hướng âm thanh); 3) Chiều theo ý người khác (như 顺着他的脾气).',
    examples: [
      {
        chinese: '刑警顺着现场遗留的一点蛛丝马迹，最终成功锁定了犯罪嫌疑人的藏身之地。',
        pinyin: 'Xíngjǐng shùnzhe xiànchǎng yíliú de yì diǎn zhūsīmǎjì, zuìzhōng chénggōng suǒdìng le fànzuì xiányírén de cángshēn zhī dì.',
        translation_vi: 'Cảnh sát hình sự lần theo một chút manh mối li ti còn sót lại tại hiện trường, cuối cùng đã khóa chặt thành công nơi ẩn náu của nghi phạm.',
        explanation: '"顺着现场遗留的蛛丝马迹" miêu tả quá trình phá án bám sát từng dấu vết nghiệp vụ.'
      },
      {
        chinese: '竹筏顺着湍急的溪流飞速而下，两岸奇峰耸立，令人目不暇接。',
        pinyin: 'Zhúfá shùnzhe tuānjí de xīliú fēisù ér xià, liǎng\'àn qífēng sǒnglì, lìng rén mùbùxiájiē.',
        translation_vi: 'Bè tre xuôi theo dòng suối chảy xiết lao vun vút xuống dưới, hai bên bờ núi non kỳ vĩ sừng sững khiến người ta nhìn không xuể mắt.',
        explanation: '"顺着湍急的溪流" miêu tả chuyển động trôi tự nhiên của con bè nương theo sức nước con suối.'
      }
    ]
  },
  {
    order_index: 52,
    name: 'Giới từ nhân dịp hoặc mượn phương tiện "借" (Nhân dịp / Nhờ vào / Mượn cơ hội)',
    pattern: '借 + Cơ hội/Dịp tốt / 借...之机, Chủ ngữ + Động từ + Tân ngữ',
    category: 'Giới từ',
    explanation_vi: '"借" (jiè) trong tiếng Trung HSK 5 ngoài nghĩa động từ "vay, mượn" còn được dùng như một giới từ chỉ phương thức hoặc thời cơ thuận lợi (nhân dịp này, mượn cớ, dựa vào sức mạnh bên ngoài để hành sự). Thường dùng trong ngoại giao và văn hóa xã giao: "借此机会" (nhân cơ hội này), "借题发挥" (mượn đề tài để mở rộng).',
    examples: [
      {
        chinese: '值此新春佳节来临之际，我借此机会向全体员工及家属致以最诚挚的节日问候。',
        pinyin: 'Zhícǐ xīnchūn jiājié láilín zhījì, wǒ jiè cǐ jīhuì xiàng quántǐ yuángōng jí jiāshǔ zhìyǐ zuì chéngzhì de jiérì wènhòu.',
        translation_vi: 'Nhân dịp Tết đến xuân về này, tôi mượn cơ hội này xin gửi tới toàn thể nhân viên cùng gia quyến lời thăm hỏi ngày lễ chân thành nhất.',
        explanation: '"借此机会" là khẩu ngữ nghi lễ trang trọng quen thuộc mở đầu bức thư chúc mừng năm mới.'
      },
      {
        chinese: '风筝正是借着大风的托举之力，才能在湛蓝的高空中自由翱翔。',
        pinyin: 'Fēngzheng zhèng shì jièzhe dàfēng de tuōjǔ zhī lì, cái néng zài zhànlán de gāokōng zhōng zìyóu áoxiáng.',
        translation_vi: 'Con diều chính là nhờ nương vào lực nâng của ngọn gió lớn mới có thể tự do chao lượn trên bầu trời xanh thẳm.',
        explanation: '"借着大风的托举之力" giải thích quy luật vật lý dựa vào sức gió để bay cao.'
      }
    ]
  },
  {
    order_index: 53,
    name: 'Giới từ mốc quá trình thẩm định hoàn tất "经" (Qua / Sau khi qua / Trải qua)',
    pattern: '经 + Động từ song âm tiết (批准 / 调查 / 研究 / 核实 / 专家评审), Mệnh đề kết luận',
    category: 'Giới từ',
    explanation_vi: '"经" (jīng) là giới từ văn thư hành chính cao cấp, mang nghĩa "sau khi đã trải qua một thủ tục thẩm định, xem xét hoặc nghiên cứu kỹ lưỡng" (qua khảo sát, sau khi được cấp phép). Thường kết hợp với các động từ hai chữ như 批准 (phê chuẩn), 调查 (điều tra), 讨论 (thảo luận), 审核 (thẩm duyệt).',
    examples: [
      {
        chinese: '经上级教育主管部门严格批准，该校将从下学期起正式开设人工智能实验班。',
        pinyin: 'Jīng shàngjí jiàoyù zhǔguǎn bùmén yángé pīzhǔn, gāi xiào jiāng cóng xià xuéqī qǐ zhèngshì kāishè réngōng zhìnéng shíyànbān.',
        translation_vi: 'Sau khi được cơ quan chủ quản giáo dục cấp trên phê chuẩn nghiêm ngặt, ngôi trường này sẽ chính thức mở lớp thực nghiệm trí tuệ nhân tạo từ học kỳ tới.',
        explanation: '"经...严格批准" xác lập tính pháp lý hoàn thiện cho việc mở mã ngành đào tạo mới.'
      },
      {
        chinese: '经公安机关缜密的技术核实，网络上热传的那段事故视频系后期恶意剪辑合成。',
        pinyin: 'Jīng gōng\'ān jīguān zhěnmì de jìshù héshí, wǎngluò shang rèchuán de nà duàn shìgù shìpín xì hòuqī èyì jiǎnjí héchéng.',
        translation_vi: 'Qua sự xác minh kỹ thuật cẩn trọng của cơ quan công an, đoạn video tai nạn đang lan truyền rầm rộ trên mạng là sản phẩm cắt ghép ác ý giai đoạn hậu kỳ.',
        explanation: '"经...缜密核实" công bố kết luận điều tra chính thức bác bỏ tin giả thất thiệt.'
      }
    ]
  },
  {
    order_index: 54,
    name: 'Giới từ xác lập chủ đề hội đàm chính trị "就" (Về / Nhân / Đứng trên phương diện)',
    pattern: '就 + Chủ đề/Vấn đề trọng đại + Động từ (达成协议 / 发表看法 / 交换意见 / 展开磋商)',
    category: 'Giới từ',
    explanation_vi: '"就" (jiù) trong ngoại giao và thời sự chính trị đóng vai trò như một giới từ chỉ phạm vi chủ đề được đưa ra bàn thảo (về vấn đề, liên quan tới phương diện). Thường đi với các cặp kết hợp: "就...达成共识" (đạt được đồng thuận về...), "就...交换意见" (trao đổi ý kiến về...). Khác với "对", "就" mang sắc thái nghi lễ đối ngoại ngoại giao cao hơn.',
    examples: [
      {
        chinese: '两国经贸代表团在日内瓦就知识产权保护问题达成了广泛的共识。',
        pinyin: 'Liǎng guó jīngmào dàibiǎotuán zài Rìnèiwǎ jiù zhīshi chǎnquán bǎohù wèntí dáchéng le guǎngfàn de gòngshí.',
        translation_vi: 'Đoàn đại biểu kinh tế thương mại hai nước tại Geneva đã đạt được sự đồng thuận rộng rãi về vấn đề bảo hộ quyền sở hữu trí tuệ.',
        explanation: '"就...达成共识" là công thức ngoại giao chuẩn mực xác định kết quả của vòng đàm phán quốc tế.'
      },
      {
        chinese: '新闻发言人就近期国际社会的关切问题逐一作出了权威、详尽的官方回应。',
        pinyin: 'Xīnwén fāyánrén jiù jìnqī guójì shèhuì de guānqiè wèntí zhúyī zuòchū le quánwēi, xiángjìn de guānfāng huíyìng.',
        translation_vi: 'Người phát ngôn tin tức đã lần lượt đưa ra những phản hồi chính thức đầy thẩm quyền và chi tiết về các vấn đề mà cộng đồng quốc tế quan tâm gần đây.',
        explanation: '"就...作出了回应" xác lập mục tiêu đối thoại rõ ràng trong buổi họp báo quốc tế.'
      }
    ]
  },
  {
    order_index: 55,
    name: 'Giới từ tuân thủ chỉ thị và mệnh lệnh "遵照" (Tuân theo / Làm đúng theo)',
    pattern: '遵照 + Chỉ thị/Chỉ đạo/Lời dặn/Pháp luật + Động từ thực hiện',
    category: 'Giới từ',
    explanation_vi: '"遵照" (zūnzhào) biểu thị việc chấp hành tuyệt đối và nghiêm túc theo lời dặn, chỉ thị của cấp trên, di nguyện của tiền nhân, hoặc quy định của pháp luật (tuân theo, làm đúng theo chỉ đạo). Mang sắc thái kính cẩn, phục tùng và trách nhiệm pháp lý cao.',
    examples: [
      {
        chinese: '医护人员严格遵照世界卫生组织的操作指南，有条不紊地开展感染防控工作。',
        pinyin: 'Yīhù rényuán yángé zūnzhào Shìjiè Wèishēng Zǔzhī de cāozuò zhǐnán, yǒutiáobùwěn de kāizhǎn gǎnrǎn fángkòng gōngzuò.',
        translation_vi: 'Các nhân viên y tế tuân thủ nghiêm ngặt theo hướng dẫn thao tác của Tổ chức Y tế Thế giới, triển khai công tác phòng chống nhiễm trùng một cách ngăn nắp tuần tự.',
        explanation: '"严格遵照...操作指南" làm rõ hành động tuân thủ tiêu chuẩn y khoa quốc tế.'
      },
      {
        chinese: '他遵照已故老科学家的生前遗嘱，将毕生积蓄全额捐赠给了贫困山区学校。',
        pinyin: 'Tā zūnzhào yǐgù lǎo kēxuéjiā de shēngqián yízhǔ, jiāng bìshēng jīxù quán\'é juānzèng gěi le pínkùn shānqū xuéxiào.',
        translation_vi: 'Anh ấy làm đúng theo di chúc lúc sinh thời của cố nhà khoa học già, đem toàn bộ tiền tích lũy cả đời quyên tặng cho các trường học vùng núi nghèo khó.',
        explanation: '"遵照...生前遗嘱" thể hiện lòng trung thực và sự kính trọng đối với tâm nguyện của người đã khuất.'
      }
    ]
  },
  {
    order_index: 56,
    name: 'Phân biệt ba giới từ chính luận cốt lõi: "鉴于" vs "基于" vs "出于"',
    pattern: '鉴于 (Tình hình khách quan/Kinh nghiệm) vs 基于 (Cơ sở dữ liệu/Lý luận) vs 出于 (Động cơ nội tâm)',
    category: 'Giới từ',
    explanation_vi: 'Ba giới từ chữ "于" này phân định rõ ranh giới ngữ pháp học thuật: 1) "鉴于" (xét thấy) dẫn ra hiện thực khách quan, tình huống khẩn cấp hoặc bài học quá khứ để đưa ra cảnh báo/quyết sách; 2) "基于" (dựa trên) dẫn ra căn cứ dữ liệu, tài liệu, lý thuyết mô hình để rút ra kết luận khoa học; 3) "出于" (xuất phát từ) dẫn ra động cơ tâm lý, tình cảm, thiện chí hoặc nguyên tắc đạo đức nội tại của con người.',
    examples: [
      {
        chinese: '鉴于天气突变，基于雷达监测数据，出于安全考虑，机长决定返航。',
        pinyin: 'Jiànyú tiānqì tūbiàn, jīyú léidá jiāncè shùjù, chūyú ānquán kǎolǜ, jīzhǎng juédìng fǎnháng.',
        translation_vi: 'Xét thấy thời tiết đột biến, dựa trên dữ liệu giám sát ra-đa, xuất phát từ sự cân nhắc an toàn, cơ trưởng đã quyết định bay quay đầu về.',
        explanation: 'Câu kinh điển phối hợp cả 3 giới từ làm nổi bật rõ ranh giới chức năng của từng từ trong tình huống hàng không.'
      },
      {
        chinese: '这项新规划基于长期的科学论证，旨在彻底消除各种潜在的安全隐患。',
        pinyin: 'Zhè xiàng xīn guīhuà jīyú chángqī de kēxué lùnzhèng, zhǐzài chèdǐ xiāochú gè zhǒng qiánzài de ānquán yǐnhuàn.',
        translation_vi: 'Quy hoạch mới này được xây dựng trên cơ sở thẩm định khoa học lâu dài, nhằm triệt tiêu hoàn toàn các mối hiểm họa an toàn tiềm ẩn.',
        explanation: '"基于长期的科学论证" làm nổi bật tính vững chắc về mặt học thuật của quy hoạch dự án.'
      }
    ]
  }
];
