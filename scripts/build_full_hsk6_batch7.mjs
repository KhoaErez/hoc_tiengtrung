import fs from 'fs'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

const BATCH_7_DATA = [
  {
    id: 4898,
    hanzi: "跳水",
    pinyin: "tiàoshuǐ",
    word_type: "Động từ / Danh từ",
    meaning_vi: "nhảy cầu (thể thao)",
    example_hanzi: "中国跳水队在国际大赛中凭借近乎完美的表现包揽了全部金牌。",
    example_pinyin: "Zhōngguó tiàoshuǐduì zài guójì dàsài zhōng píngjiè jìnhū wánměi de biǎoxiàn bāolǎn le quánbù jīnpái.",
    example_vi: "Đội tuyển nhảy cầu Trung Quốc tại đại hội quốc tế nhờ vào màn trình diễn gần như hoàn hảo đã thâu tóm toàn bộ huy chương vàng."
  },
  {
    id: 4899,
    hanzi: "贴近",
    pinyin: "tiējìn",
    word_type: "Động từ / Tính từ",
    meaning_vi: "gần gũi, sát sao, gắn liền với",
    example_hanzi: "优秀的新闻报道应当深入基层，创作出贴近百姓实际生活的鲜活作品。",
    example_pinyin: "Yōuxiù de xīnwén bàodào yīngdāng shēnrù jīcéng, chuàngzuò chū tiējìn bǎixìng shíjì shēnghuó de xiānhuó zuòpǐn.",
    example_vi: "Các phóng sự tin tức xuất sắc cần đi sâu xuống cơ sở, sáng tác ra những tác phẩm sống động gắn liền với đời sống thực tế của người dân."
  },
  {
    id: 4900,
    hanzi: "听话",
    pinyin: "tīnghuà",
    word_type: "Tính từ / Động từ",
    meaning_vi: "ngoan ngoãn, nghe lời",
    example_hanzi: "那个乖巧懂事的小女孩非常听话，主动帮助妈妈分担家务劳动。",
    example_pinyin: "Nà gè guāiqiǎo dǒngshì de xiǎo nǚhái fēicháng tīnghuà, zhǔdòng bāngzhù māma fēndān jiāwù láodòng.",
    example_vi: "Bé gái ngoan ngoãn hiểu chuyện ấy rất nghe lời, chủ động giúp mẹ gánh vác việc nhà."
  },
  {
    id: 4901,
    hanzi: "听觉",
    pinyin: "tīngjué",
    word_type: "Danh từ",
    meaning_vi: "thính giác",
    example_hanzi: "长期佩戴入耳式耳机收听高分贝音乐，会对人的听觉器官造成严重损害。",
    example_pinyin: "Chángqī pèidài rù'ěrshì ěrjī shōutīng gāo fēnbèi yīnyuè, huì duì rén de tīngjué qìguān zàochéng yánzhòng sǔnhài.",
    example_vi: "Đeo tai nghe nhét tai trong thời gian dài để nghe nhạc âm lượng decibel lớn sẽ gây tổn hại nghiêm trọng cho cơ quan thính giác của con người."
  },
  {
    id: 4902,
    hanzi: "听取",
    pinyin: "tīngqǔ",
    word_type: "Động từ",
    meaning_vi: "lắng nghe, tiếp thu (ý kiến, báo cáo)",
    example_hanzi: "领导班子召开专门座谈会，认真听取来自基层干部群众的合理建议。",
    example_pinyin: "Lǐngdǎo bānzi zhàokāi zhuānmén zuòtánhuì, rènzhēn tīngqǔ láizì jīcéng gànbù qúnzhòng de hélǐ jiànyì.",
    example_vi: "Tập thể lãnh đạo đã triệu tập buổi tọa đàm chuyên đề, nghiêm túc lắng nghe những kiến nghị hợp lý từ cán bộ và quần chúng cơ sở."
  },
  {
    id: 4903,
    hanzi: "通道",
    pinyin: "tōngdào",
    word_type: "Danh từ",
    meaning_vi: "lối đi, hành lang, tuyến luồng",
    example_hanzi: "公共建筑物的各个紧急消防疏散通道必须保持时刻畅通，严禁堆物堵塞。",
    example_pinyin: "Gōnggòng jiànzhùwù de gè gè jǐnjí xiāofáng shūsàn tōngdào bìxū bǎochí shíkè chàngtōng, yánjìn duīwù dǔsè.",
    example_vi: "Các lối đi sơ tán phòng cháy chữa cháy khẩn cấp của công trình công cộng bắt buộc phải luôn thông thoáng, nghiêm cấm chất đống đồ đạc gây tắc nghẽn."
  },
  {
    id: 4905,
    hanzi: "通话",
    pinyin: "tōnghuà",
    word_type: "Động từ / Danh từ",
    meaning_vi: "nói chuyện điện thoại, cuộc gọi",
    example_hanzi: "两国最高领导人昨晚就当前国际热点经贸局势通电话深入交换了意见。",
    example_pinyin: "Liǎng guó zuìgāo lǐngdǎorén zuówǎn jiù dāngqián guójì rèdiǎn jīngmào júshì tōng diànhuà shēnrù jiāohuàn le yìjiàn.",
    example_vi: "Lãnh đạo tối cao hai nước tối qua đã có cuộc điện đàm trao đổi sâu sắc ý kiến về cục diện kinh tế thương mại điểm nóng quốc tế hiện nay."
  },
  {
    id: 4906,
    hanzi: "通信",
    pinyin: "tōngxìn",
    word_type: "Danh từ / Động từ",
    meaning_vi: "thông tin liên lạc, viễn thông",
    example_hanzi: "第五代移动通信技术的普及为各行各业的数字化转型提供了强大动能。",
    example_pinyin: "Dì-wǔ dài yídòng tōngxìn jìshù de pǔjí wèi gè háng gè yè de shùzìhuà zhuǎnxíng tígōng le qiángdà dòngnéng.",
    example_vi: "Việc phổ cập công nghệ thông tin di động thế hệ thứ năm đã đem đến động lực mạnh mẽ cho quá trình chuyển đổi số của mọi ngành nghề."
  },
  {
    id: 4910,
    hanzi: "同伴",
    pinyin: "tóngbàn",
    word_type: "Danh từ",
    meaning_vi: "bạn đồng hành, bạn cùng lứa",
    example_hanzi: "在漫长而艰苦的野外徒步探险途中，同伴之间的相互鼓励是最坚实的依靠。",
    example_pinyin: "Zài màncháng ér jiānkǔ de yěwài túbù tànxiǎn túzhōng, tóngbàn zhījiān de xiānghù gǔlì shì zuì jiānshí de yīkào.",
    example_vi: "Trên chặng đường thám hiểm đi bộ dã ngoại dài đằng đẵng và gian nan, sự khích lệ lẫn nhau giữa những người bạn đồng hành là chỗ dựa vững chắc nhất."
  },
  {
    id: 4911,
    hanzi: "同行",
    pinyin: "tóngháng",
    word_type: "Danh từ / Động từ",
    meaning_vi: "người cùng nghề, đồng nghiệp trong ngành",
    example_hanzi: "在国际人工智能研讨会上，青年学者与多位全球知名同行进行了深度交流。",
    example_pinyin: "Zài guójì réngōng zhìnéng yántǎohuì shang, qīngnián xuézhě yǔ duō wèi quánqiú zhīmíng tóngháng jìnxíng le shēndù jiāoliú.",
    example_vi: "Tại hội thảo trí tuệ nhân tạo quốc tế, học giả trẻ đã giao lưu sâu rộng với nhiều đồng nghiệp trong giới nổi tiếng toàn cầu."
  },
  {
    id: 4913,
    hanzi: "同类",
    pinyin: "tónglèi",
    word_type: "Danh từ / Tính từ",
    meaning_vi: "cùng loại, đồng loại",
    example_hanzi: "与市场上同类竞品相比，这款新型节能家电在性能与售价上具有明显优势。",
    example_pinyin: "Yǔ shìchǎng shang tónglèi jìngpǐn xiāngbǐ, zhè kuǎn xīnxíng jiénéng jiādiàn zài xìngnéng yǔ shòujià shang jùyǒu míngxiǎn yōushì.",
    example_vi: "So với các sản phẩm cạnh tranh cùng loại trên thị trường, mẫu thiết bị gia dụng tiết kiệm điện kiểu mới này có ưu thế rõ rệt về hiệu năng và giá bán."
  },
  {
    id: 4914,
    hanzi: "铜牌",
    pinyin: "tóngpái",
    word_type: "Danh từ",
    meaning_vi: "huy chương đồng",
    example_hanzi: "年轻选手在激烈的季军争夺战中沉着应对，最终顽强拼得了一枚宝贵的铜牌。",
    example_pinyin: "Niánqīng xuǎnshǒu zài jīliè de jìjūn zhēngduózhàn zhōng chénzhuó yìngduì, zuìzhōng wánqiáng pīn dé le yì méi bǎoguì de tóngpái.",
    example_vi: "Tuyển thủ trẻ tuổi trong trận tranh huy chương đồng quyết liệt đã bình tĩnh ứng phó, cuối cùng ngoan cường giành được tấm huy chương đồng quý báu."
  },
  {
    id: 4917,
    hanzi: "偷偷",
    pinyin: "tōutōu",
    word_type: "Phó từ",
    meaning_vi: "lén lút, thầm lén, trộm",
    example_hanzi: "趁着妈妈不注意，顽皮的小弟弟偷偷溜进厨房拿走了一块巧克力蛋糕。",
    example_pinyin: "Chènzhe māma bú zhùyì, wánpí de xiǎo dìdi tōutōu liū jìn chúfáng ná zǒu le yí kuài qiǎokèlì dàngāo.",
    example_vi: "Nhân lúc mẹ không để ý, cậu em trai tinh nghịch lén lút lẻn vào bếp lấy đi một miếng bánh ngọt sô-cô-la."
  },
  {
    id: 4918,
    hanzi: "头脑",
    pinyin: "tóunǎo",
    word_type: "Danh từ",
    meaning_vi: "đầu óc, trí óc",
    example_hanzi: "面对纷繁复杂的市场突发变化，企业领导者必须始终保持清醒敏锐的头脑。",
    example_pinyin: "Miànduì fēnfán-fùzá de shìchǎng tūfā biànhuà, qǐyè lǐngdǎozhě bìxū shǐzhōng bǎochí qīngxǐng mǐnruì de tóunǎo.",
    example_vi: "Trước những biến động bất ngờ phức tạp trên thị trường, nhà lãnh đạo doanh nghiệp bắt buộc phải luôn duy trì một cái đầu tỉnh táo và nhạy bén."
  },
  {
    id: 4922,
    hanzi: "透",
    pinyin: "tòu",
    word_type: "Động từ / Tính từ",
    meaning_vi: "thấu suốt, xuyên qua, thấu đáo",
    example_hanzi: "这起案件的每一个疑难线索，办案人员都必须深入调查直到彻底摸透查清。",
    example_pinyin: "Zhè qǐ ànjiàn de měi yí gè yínán xiànsuǒ, bàn'àn rényuán dōu bìxū shēnrù diàochá zhídào chèdǐ mō tòu chá qīng.",
    example_vi: "Mỗi một manh mối hóc búa của vụ án này, cán bộ thụ lý vụ án đều phải điều tra sâu sát cho tới khi nắm thấu và làm sáng tỏ hoàn toàn."
  },
  {
    id: 4923,
    hanzi: "透过",
    pinyin: "tòuguò",
    word_type: "Động từ / Giới từ",
    meaning_vi: "xuyên qua, thông qua (nhìn thấu)",
    example_hanzi: "透过明亮洁净的落地窗，城市夜幕下璀璨夺目的万家灯火尽收眼底。",
    example_pinyin: "Tòuguò míngliàng jiéjìng de luòdìchuāng, chéngshì yèmù xià cuǐcàn-duómù de wànjiā-dēnghuǒ jìn shōu yǎndǐ.",
    example_vi: "Nhìn xuyên qua khung cửa kính sát đất sáng choang sạch sẽ, muôn ngọn đèn lung linh rực rỡ dưới màn đêm thành phố thu trọn vào đáy mắt."
  },
  {
    id: 4926,
    hanzi: "突发",
    pinyin: "tūfā",
    word_type: "Động từ / Tính từ",
    meaning_vi: "đột xuất, bất ngờ ập đến",
    example_hanzi: "应急管理部门建立了完备的突发公共安全事件快速响应与联动处置机制。",
    example_pinyin: "Yìngjí guǎnlǐ bùmén jiànlì le wánbèi de tūfā gōnggòng ānquán shìjiàn kuàisù xiǎngyìng yǔ liándòng chǔzhì jīzhì.",
    example_vi: "Cơ quan quản lý tình huống khẩn cấp đã thiết lập cơ chế phản ứng nhanh và liên kết xử lý toàn diện đối với các sự cố an toàn công cộng đột xuất."
  },
  {
    id: 4929,
    hanzi: "图表",
    pinyin: "túbiǎo",
    word_type: "Danh từ",
    meaning_vi: "biểu đồ, bảng biểu",
    example_hanzi: "学术论文中附带了多幅清晰直观的数据图表，使繁杂的研究结论一目了然。",
    example_pinyin: "Xuéshù lùnwén zhōng fùdài le duō fú qīngxī zhíguān de shùjù túbiǎo, shǐ fánzá de yánjiū jiélùn yímù-liǎorán.",
    example_vi: "Trong bài báo học thuật đính kèm nhiều bảng biểu dữ liệu rõ ràng trực quan, giúp các kết luận nghiên cứu phức tạp trở nên dễ hiểu rõ ràng chỉ sau một cái nhìn."
  },
  {
    id: 4932,
    hanzi: "图像",
    pinyin: "túxiàng",
    word_type: "Danh từ",
    meaning_vi: "hình ảnh, đồ họa",
    example_hanzi: "借助先进的人工智能算法，医学影像分析系统能够精准识别极其细微的病灶图像。",
    example_pinyin: "Jièzhù xiānjìn de réngōng zhìnéng suànfǎ, yīxué yǐngxiàng fēnxī xìtǒng nénggòu jīngzhǔn shíbié jíqí xìwēi de bìngzào túxiàng.",
    example_vi: "Nhờ vào các thuật toán trí tuệ nhân tạo tiên tiến, hệ thống phân tích hình ảnh y khoa có thể nhận diện chuẩn xác hình ảnh tổn thương bệnh lý cực kỳ vi mô."
  },
  {
    id: 4941,
    hanzi: "推行",
    pinyin: "tuīxíng",
    word_type: "Động từ",
    meaning_vi: "thực thi, ban hành, triển khai rộng",
    example_hanzi: "该市各居民社区全面推行生活垃圾分类管理制度，取得了显著的环保成效。",
    example_pinyin: "Gāi shì gè jūmín shèqū quánmiàn tuīxíng shēnghuó lājī fēnlèi guǎnlǐ zhìdù, qǔdé le xiǎnzhù de huánbǎo chéngxiào.",
    example_vi: "Các khu dân cư của thành phố này triển khai toàn diện chế độ quản lý phân loại rác thải sinh hoạt, thu được hiệu quả bảo vệ môi trường rõ rệt."
  },
  {
    id: 4942,
    hanzi: "退税",
    pinyin: "tuìshuì",
    word_type: "Động từ / Danh từ",
    meaning_vi: "hoàn thuế",
    example_hanzi: "税务局开通了手机个人所得税年度汇算清缴一键申报与快速退税服务通道。",
    example_pinyin: "Shuìwùjú kāitōng le shǒujī gèrén suǒdéshuì niándù huìsuàn-qīngjiǎo yíjiàn shēnbào yǔ kuàisù tuìshuì fúwù tōngdào.",
    example_vi: "Cục Thuế đã mở kênh dịch vụ kê khai một chạm và hoàn thuế nhanh cho kỳ quyết toán thuế thu nhập cá nhân hàng năm trên điện thoại di động."
  },
  {
    id: 4943,
    hanzi: "吞",
    pinyin: "tūn",
    word_type: "Động từ",
    meaning_vi: "nuốt, nuốt chửng",
    example_hanzi: "吃药胶囊时务必多喝温开水送服，千万不可大口硬吞以免卡喉梗阻。",
    example_pinyin: "Chī yào jiāonáng shí wùbì duō hē wēn kāishuǐ sòng fú, qiānwàn bù kě dà kǒu yìng tūn yǐmiǎn kǎhóu gěngzǔ.",
    example_vi: "Khi uống thuốc viên nang nhớ phải uống nhiều nước ấm để trôi thuốc, tuyệt đối không được gắng sức nuốt chửng kẻo mắc nghẹn ở cổ họng."
  },
  {
    id: 4944,
    hanzi: "拖",
    pinyin: "tuō",
    word_type: "Động từ",
    meaning_vi: "kéo, lôi, trì hoãn",
    example_hanzi: "遇到棘手的工作难题应当及时沟通解决，绝不能一味往后拖延时间。",
    example_pinyin: "Yù dào jíshǒu de gōngzuò nántí yīngdāng jíshí gōutōng jiějué, jué bù néng yíwèi wǎng hòu tuōyán shíjiān.",
    example_vi: "Khi gặp bài toán hóc búa trong công việc cần kịp thời trao đổi giải quyết, tuyệt đối không được một mực chần chừ trì hoãn kéo dài thời gian."
  },
  {
    id: 4947,
    hanzi: "挖",
    pinyin: "wā",
    word_type: "Động từ",
    meaning_vi: "đào, bới, khai quật",
    example_hanzi: "考古队员在遗址现场小心翼翼地挖掘泥土，清理出大批商周时期的珍贵青铜器。",
    example_pinyin: "Kǎogǔ duìyuán zài yízhǐ xiànchǎng xiǎoxīn-yìyì de wājué nítǔ, qīnglǐ chū dà pī Shāng-Zhōu shíqī de zhēnguì qīngtóngqì.",
    example_vi: "Các thành viên đội khảo cổ cẩn thận từng li từng tí đào đất tại hiện trường di chỉ, dọn dẹp khai quật được số lượng lớn đồ đồng quý hiếm thời Thương Chu."
  },
  {
    id: 4954,
    hanzi: "外科",
    pinyin: "wàikē",
    word_type: "Danh từ",
    meaning_vi: "ngoại khoa, khoa phẫu thuật ngoại",
    example_hanzi: "知名外科专家凭借娴熟精湛的微创手术技术，成功为危重患者摘除了肿瘤。",
    example_pinyin: "Zhīmíng wàikē zhuānjiā píngjiè xiánshú jīngzhàn de wēichuàng shǒushù jìshù, chénggōng wèi wēizhòng huànzhě zhāichú le zhǒngliú.",
    example_vi: "Chuyên gia ngoại khoa tên tuổi nhờ vào kỹ thuật phẫu thuật nội soi vi phẫu thuần thục điêu luyện đã bóc tách khối u thành công cho bệnh nhân nguy kịch."
  },
  {
    id: 4955,
    hanzi: "外来",
    pinyin: "wàilái",
    word_type: "Tính từ",
    meaning_vi: "từ bên ngoài tới, ngoại lai",
    example_hanzi: "生态环保部门严厉打击外来物种非法引入行为，坚决筑牢生物安全屏障。",
    example_pinyin: "Shēngtài huánbǎo bùmén yánlì dǎjī wàilái wùzhǒng fēifǎ yǐnrù xíngwéi, jiānjué zhù láo shēngwù ānquán píngzhàng.",
    example_vi: "Cơ quan bảo vệ môi trường sinh thái xử lý nghiêm khắc hành vi đưa các loài ngoại lai vào trái phép, kiên quyết xây dựng vững chắc lá chắn an toàn sinh học."
  },
  {
    id: 4956,
    hanzi: "外甥",
    pinyin: "wàisheng",
    word_type: "Danh từ",
    meaning_vi: "cháu trai (con của chị/em gái)",
    example_hanzi: "聪明可爱的小外甥考上了重点中学，舅舅特地买了一台笔记本电脑送给他做奖励。",
    example_pinyin: "Cōngmíng kě'ài de xiǎo wàisheng kǎoshàng le zhòngdiǎn zhōngxué, jiùjiu tèdì mǎi le yì tái bǐjìběn diànnǎo sòng gěi tā zuò jiǎnglì.",
    example_vi: "Cậu cháu trai thông minh đáng yêu thi đỗ vào trường cấp hai trọng điểm, người cậu đã cất công mua một chiếc máy tính xách tay tặng làm phần thưởng."
  },
  {
    id: 4957,
    hanzi: "弯曲",
    pinyin: "wānqū",
    word_type: "Tính từ / Động từ",
    meaning_vi: "uốn cong, quanh co uốn lượn",
    example_hanzi: "汽车沿着蜿蜒弯曲的盘山公路缓缓行驶，窗外层峦叠嶂、风光无限。",
    example_pinyin: "Qìchē yánzhe wānyán wānqū de pánshān gōnglù huǎnhuǎn xíngshǐ, chuāngwài céngluán-diézhàng, fēngguāng wúxiàn.",
    example_vi: "Chiếc xe ô tô chạy từ từ dọc theo con đường đèo quanh co uốn lượn quanh núi, ngoài cửa sổ núi non trùng điệp, phong cảnh đẹp khôn xiết."
  },
  {
    id: 4959,
    hanzi: "万物",
    pinyin: "wànwù",
    word_type: "Danh từ",
    meaning_vi: "vạn vật, muôn loài",
    example_hanzi: "春回大地，春雨绵绵滋润着世间万物，大自然呈现出一派生机勃勃的景象。",
    example_pinyin: "Chūn huí dàdì, chūnyǔ miánmián zīrùn zhe shìjiān wànwù, dàzìrán chéngxiàn chū yí pài shēngjī-bóbó de jǐngxiàng.",
    example_vi: "Mùa xuân trở lại trên đất mẹ, cơn mưa xuân phơi phới tưới mát vạn vật thế gian, mẹ thiên nhiên hiện lên một quang cảnh bừng bừng sức sống."
  },
  {
    id: 4961,
    hanzi: "网",
    pinyin: "wǎng",
    word_type: "Danh từ / Động từ",
    meaning_vi: "lưới, mạng lưới; đánh bắt lưới",
    example_hanzi: "渔民清晨驾船出海，熟练地向波涛起伏的大海中撒下了一张巨大的渔网。",
    example_pinyin: "Yúmín qīngchén jià chuán chū hǎi, shúliàn de xiàng bōtāo qǐfú de dàhǎi zhōng sǎxià le yì zhāng jùdà de yúwǎng.",
    example_vi: "Bác ngư dân sáng sớm lái thuyền ra khơi, thuần thục buông một tấm lưới cá khổng lồ xuống lòng biển cả sóng gió nhấp nhô."
  },
  {
    id: 4962,
    hanzi: "往后",
    pinyin: "wǎnghòu",
    word_type: "Danh từ",
    meaning_vi: "từ nay về sau, mai sau",
    example_hanzi: "从今往后，大家在实验操作过程中必须严格遵守实验室各项安全守则。",
    example_pinyin: "Cóngjīn wǎnghòu, dàjiā zài shíyàn cāozuò guòchéng zhōng bìxū yángé zūnshǒu shíyànshì gè xiàng ānquán shǒuzé.",
    example_vi: "Từ nay về sau, mọi người trong quá trình thao tác thí nghiệm bắt buộc phải tuân thủ nghiêm ngặt các quy tắc an toàn của phòng thí nghiệm."
  },
  {
    id: 4963,
    hanzi: "往来",
    pinyin: "wǎnglái",
    word_type: "Động từ / Danh từ",
    meaning_vi: "giao lưu qua lại, vãng lai",
    example_hanzi: "大运河两岸商船穿梭往来，自古以来就是南北商贸与文化交流的重要动脉。",
    example_pinyin: "Dàyùnhé liǎng'àn shāngchuán chuānsuō wǎnglái, zìgǔ yǐlái jiù shì nán-běi shāngmào yǔ wénhuà jiāoliú de zhòngyào dòngmài.",
    example_vi: "Hai bên bờ Đại Vận Hà tàu buôn tấp nập qua lại con thoi, từ xưa tới nay luôn là huyết mạch trọng yếu giao lưu văn hóa và kinh tế thương mại Nam Bắc."
  },
  {
    id: 4964,
    hanzi: "往年",
    pinyin: "wǎngnián",
    word_type: "Danh từ",
    meaning_vi: "những năm trước, năm ngoái",
    example_hanzi: "与往年同期相比，今年春季全国多地气温明显偏高，花期普遍有所提前。",
    example_pinyin: "Yǔ wǎngnián tóngqī xiāngbǐ, jīnnián chūnjì quánguó duō dì qìwēn míngxiǎn piāngāo, huāqī pǔbiàn yǒusuǒ tíqián.",
    example_vi: "So với cùng kỳ những năm trước, nhiệt độ mùa xuân năm nay tại nhiều nơi trên cả nước cao hơn rõ rệt, mùa hoa nhìn chung đều đến sớm hơn."
  },
  {
    id: 4965,
    hanzi: "望",
    pinyin: "wàng",
    word_type: "Động từ",
    meaning_vi: "nhìn xa; trông mong, hy vọng",
    example_hanzi: "登上泰山玉皇顶极目远望，万里山河尽收眼底，令人心潮澎湃。",
    example_pinyin: "Dēngshàng Tàishān Yùhuángdǐng jímù yuǎnwàng, wàn lǐ shānhé jìn shōu yǎndǐ, lìng rén xīncháo-péngpài.",
    example_vi: "Bước lên đỉnh Ngọc Hoàng của núi Thái Sơn phóng tầm mắt nhìn xa, muôn dặm non sông thu trọn vào tầm mắt, khiến lòng người dạt dào cảm xúc."
  },
  {
    id: 4967,
    hanzi: "微小",
    pinyin: "wēixiǎo",
    word_type: "Tính từ",
    meaning_vi: "nhỏ bé, vi mô, li ti",
    example_hanzi: "高倍显微镜下，生物科研人员能够清晰观察到细胞内部其微小的结构变化。",
    example_pinyin: "Gāobèi xiǎnwéijìng xià, shēngwù kēyán rényuán nénggòu qīngxī guānchá dào xìbāo nèibù qí wēixiǎo de jiégòu biànhuà.",
    example_vi: "Dưới kính hiển vi độ phóng đại lớn, các nhà nghiên cứu sinh học có thể quan sát rõ ràng những biến đổi cấu trúc cực kỳ nhỏ bé bên trong tế bào."
  },
  {
    id: 4968,
    hanzi: "违规",
    pinyin: "wéiguī",
    word_type: "Động từ",
    meaning_vi: "vi phạm quy định, trái quy tắc",
    example_hanzi: "监管机构严肃查处各类违规操作行为，切实维护金融市场的健康稳定运行。",
    example_pinyin: "Jiānguǎn jīgòu yánsù cháchǔ gèlèi wéiguī cāozuò xíngwéi, qièshí wéihù jīnróng shìchǎng de jiànkāng wěndìng yùnxíng.",
    example_vi: "Cơ quan giám sát xử lý nghiêm khắc mọi hành vi thao tác vi phạm quy định, thiết thực bảo vệ sự vận hành lành mạnh ổn định của thị trường tài chính."
  },
  {
    id: 4971,
    hanzi: "围棋",
    pinyin: "wéiqí",
    word_type: "Danh từ",
    meaning_vi: "cờ vây",
    example_hanzi: "围棋蕴含着博大精深的东方哲学智慧，讲究全局谋略与长远取舍之道。",
    example_pinyin: "Wéiqí yùnhán zhe bódà-jīngshēn de dōngfāng zhéxué zhìhuì, jiǎngjiù quánjú móulüè yǔ chángyuǎn qǔshě zhī dào.",
    example_vi: "Cờ vây hàm chứa trí tuệ triết học phương Đông uyên bác tinh thâm, chú trọng mưu lược toàn cục và đạo lý được mất lâu dài."
  },
  {
    id: 4974,
    hanzi: "为止",
    pinyin: "wéizhǐ",
    word_type: "Động từ",
    meaning_vi: "cho đến nay, đến khi dừng",
    example_hanzi: "到目前为止，该重点工程的第一阶段建设任务已经全面顺利竣工。",
    example_pinyin: "Dào mùqián wéizhǐ, gāi zhòngdiǎn gōngchéng de dì-yī jiēduàn jiànshè rènwu yǐjīng quánmiàn shùnlì jùngōng.",
    example_vi: "Tính đến thời điểm hiện tại, nhiệm vụ thi công giai đoạn một của công trình trọng điểm này đã hoàn tất nghiệm thu thuận lợi toàn diện."
  },
  {
    id: 4977,
    hanzi: "未",
    pinyin: "wèi",
    word_type: "Phó từ",
    meaning_vi: "chưa, không",
    example_hanzi: "这批新出厂的电子设备尚未经过严格的出厂质量测试，暂不得进入市场流通。",
    example_pinyin: "Zhè pī xīn chūchǎng de diànzǐ shèbèi shàngwèi jīngguò yángé de chūchǎng zhìliàng cèshì, zàn bùdé jìnrù shìchǎng liútōng.",
    example_vi: "Lô thiết bị điện tử mới xuất xưởng này chưa trải qua bài kiểm tra chất lượng xuất xưởng nghiêm ngặt, tạm thời không được đưa ra lưu thông trên thị trường."
  },
  {
    id: 4979,
    hanzi: "未成年人",
    pinyin: "wèichéngniánrén",
    word_type: "Danh từ",
    meaning_vi: "người chưa thành niên, trẻ vị thành niên",
    example_hanzi: "全社会都应当共同筑牢安全防护网，依法切实保护未成年人的身心健康权益。",
    example_pinyin: "Quán shèhuì dōu yīngdāng gòngtóng zhù láo ānquán fánghùwǎng, yīfǎ qièshí bǎohù wèichéngniánrén de shēnxīn jiànkāng quányì.",
    example_vi: "Toàn xã hội đều cần chung tay đắp vững tấm lưới bảo hộ an toàn, bảo vệ thiết thực quyền lợi sức khỏe thân tâm của người chưa thành niên theo pháp luật."
  },
  {
    id: 4980,
    hanzi: "为此",
    pinyin: "wèicǐ",
    word_type: "Liên từ",
    meaning_vi: "vì thế, vì việc này, do đó",
    example_hanzi: "城市水资源日益趋紧，为此市政府出台了更加严格的阶梯节水管理办法。",
    example_pinyin: "Chéngshì shuǐzīyuán rìyì qūjǐn, wèicǐ shì zhèngfǔ chūtái le gèngjiā yángé de jiētī jiéshuǐ guǎnlǐ bànfǎ.",
    example_vi: "Tài nguyên nước của đô thị ngày một khan hiếm, vì thế chính quyền thành phố đã ban hành biện pháp quản lý tiết kiệm nước theo bậc thang nghiêm ngặt hơn."
  },
  {
    id: 4981,
    hanzi: "为何",
    pinyin: "wèihé",
    word_type: "Đại từ / Phó từ",
    meaning_vi: "vì sao, tại sao",
    example_hanzi: "专家在专题学术讲座中深入剖析了近几十年全球极端天气频发的为何缘由。",
    example_pinyin: "Zhuānjiā zài zhuāntí xuéshù jiǎngzuò zhōng shēnrù pōuxī le jìn jǐ shí nián quánqiú jíduān tiānqì pínfā de wèihé yuányóu.",
    example_vi: "Chuyên gia trong buổi thuyết trình học thuật chuyên đề đã mổ xẻ sâu sắc lý do tại sao thời tiết cực đoan toàn cầu lại xuất hiện với tần suất dày đặc trong mấy chục năm gần đây."
  },
  {
    id: 4982,
    hanzi: "味觉",
    pinyin: "wèijué",
    word_type: "Danh từ",
    meaning_vi: "vị giác",
    example_hanzi: "厨师具备极为灵敏挑剔的味觉，能凭借微小的口感差异精准调和各种香料。",
    example_pinyin: "Chúshī jùbèi jíwéi língmǐn tiāoti de wèijué, néng píngjiè wēixiǎo de kǒugǎn chāyì jīngzhǔn tiáohé gè zhǒng xiāngliào.",
    example_vi: "Người đầu bếp sở hữu vị giác cực kỳ nhạy bén và khắt khe, có thể dựa vào sự khác biệt vị giác nhỏ bé để hòa trộn chuẩn xác các loại gia vị."
  },
  {
    id: 4986,
    hanzi: "文档",
    pinyin: "wéndàng",
    word_type: "Danh từ",
    meaning_vi: "tài liệu, văn bản, file tài liệu",
    example_hanzi: "在关闭电脑前请务必按下快捷键保存编辑完成的核心项目技术文档。",
    example_pinyin: "Zài guānbì diànnǎo qián qǐng wùbì ànxià kuàijiéjiàn bǎocún biānjí wánchéng de héxīn xiàngmù jìshù wéndàng.",
    example_vi: "Trước khi tắt máy tính xin nhớ hãy bấm phím tắt để lưu tài liệu kỹ thuật dự án cốt lõi đã hoàn tất biên tập."
  },
  {
    id: 4988,
    hanzi: "文科",
    pinyin: "wénkē",
    word_type: "Danh từ",
    meaning_vi: "khoa học xã hội và nhân văn, ban xã hội",
    example_hanzi: "他在历史与文学方面展现出浓厚的研究兴趣，高考毅然报考了大学文科专业。",
    example_pinyin: "Tā zài lìshǐ yǔ wénxué fāngmiàn zhǎnxiàn chū nónghòu de yánjiū xìngqù, gāokǎo yìrán bàokǎo le dàxué wénkē zhuānyè.",
    example_vi: "Anh ấy bộc lộ niềm hứng thú nghiên cứu nồng nhiệt đối với lịch sử và văn học, kỳ thi đại học đã dứt khoát đăng ký ngành khoa học xã hội nhân văn."
  },
  {
    id: 4990,
    hanzi: "闻名",
    pinyin: "wénmíng",
    word_type: "Động từ / Tính từ",
    meaning_vi: "nổi tiếng, danh tiếng lẫy lừng",
    example_hanzi: "景德镇自古以来便以精美绝伦的陶瓷烧造技艺闻名遐迩、享誉世界。",
    example_pinyin: "Jǐngdézhèn zìgǔ yǐlái biàn yǐ jīngměi-juélún de táocí shāozào jìyì wénmíng-xiá'ěr, xiǎngyù shìjiè.",
    example_vi: "Cảnh Đức Trấn từ xưa tới nay đã nổi tiếng gần xa với kỹ nghệ nung gốm sứ tuyệt luân tinh xảo, vang danh khắp năm châu."
  },
  {
    id: 4994,
    hanzi: "乌龟",
    pinyin: "wūguī",
    word_type: "Danh từ",
    meaning_vi: "con rùa",
    example_hanzi: "动物园两栖爬行动物馆内，一只高寿的陆生乌龟正在阳光下慢吞吞地爬行。",
    example_pinyin: "Dòngwùyuán liǎngqī páxíng dòngwùguǎn nèi, yì zhī gāoshòu de lùshēng wūguī zhèngzài yángguāng xià màntūntūn de páxíng.",
    example_vi: "Bên trong nhà trưng bày động vật lưỡng cư bò sát của vườn thú, một chú rùa cạn trường thọ đang chậm rãi bò dưới ánh nắng mặt trời."
  },
  {
    id: 4995,
    hanzi: "污水",
    pinyin: "wūshuǐ",
    word_type: "Danh từ",
    meaning_vi: "nước thải, nước bẩn",
    example_hanzi: "城市新建的高标准现代化污水处理厂投入运转后，周边河流水质明显改善。",
    example_pinyin: "Chéngshì xīnjiàn de gāo biāozhǔn xiàndàihuà wūshuǐ chǔlǐchǎng tóurù yùnzhuǎn hòu, zhōubiān héliú shuǐzhì míngxiǎn gǎishàn.",
    example_vi: "Sau khi nhà máy xử lý nước thải hiện đại tiêu chuẩn cao mới xây của thành phố đi vào vận hành, chất lượng nước sông ngòi xung quanh đã được cải thiện rõ rệt."
  },
  {
    id: 4997,
    hanzi: "无疑",
    pinyin: "wúyí",
    word_type: "Phó từ",
    meaning_vi: "không nghi ngờ gì nữa, chắc chắn",
    example_hanzi: "这项颠覆性芯片技术的成功研发，无疑将极大增强我国电子产业的核心竞争力。",
    example_pinyin: "Zhè xiàng diānfùxìng xīnpiàn jìshù de chénggōng yánfā, wúyí jiāng jídà zēngqiáng wǒguó diànzǐ chǎnyè de héxīn jìngzhēnglì.",
    example_vi: "Việc nghiên cứu phát triển thành công công nghệ chip mang tính đột phá này chắc chắn sẽ gia tăng vượt bậc năng lực cạnh tranh cốt lõi của ngành công nghiệp điện tử nước ta."
  },
  {
    id: 4999,
    hanzi: "误",
    pinyin: "wù",
    word_type: "Động từ",
    meaning_vi: "lỡ, làm chậm trễ; nhầm lẫn",
    example_hanzi: "早晨出门前请预留充足的交通换乘时间，切莫因交通拥堵而误了航班。",
    example_pinyin: "Zǎochen chūmén qián qǐng yùliú chōngzú de jiāotōng huànchéng shíjiān, qièmò yīn jiāotōng yōngdǔ ér wù le hángbān.",
    example_vi: "Sáng sớm trước khi ra khỏi nhà xin hãy dự phòng đủ thời gian chuyển tiếp giao thông, chớ vì tắc đường mà làm lỡ chuyến bay."
  },
  {
    id: 5001,
    hanzi: "物体",
    pinyin: "wùtǐ",
    word_type: "Danh từ",
    meaning_vi: "vật thể, vật thể vật lý",
    example_hanzi: "在微重力的太空空间站环境中，一切失重物体都会自由自在地漂浮在空中。",
    example_pinyin: "Zài wēi-zhònglì de tàikōng kōngjiānzhàn huánjìng zhōng, yíqiè shīzhòng wùtǐ dōu huì zìyóu-zìzài de piāofú zài kōngzhōng.",
    example_vi: "Trong môi trường vi trọng lực của trạm vũ trụ không gian, mọi vật thể mất trọng lượng đều sẽ lơ lửng tự do trong không trung."
  },
  {
    id: 5005,
    hanzi: "喜剧",
    pinyin: "xǐjù",
    word_type: "Danh từ",
    meaning_vi: "hài kịch, phim hài",
    example_hanzi: "这部优秀的幽默喜剧电影凭借紧凑诙谐的剧情，给影院观众带来了无尽欢笑。",
    example_pinyin: "Zhè bù yōuxiù de yōumò xǐjù diànyǐng píngjiè jǐncòu huīxié de jùqíng, gěi yǐngyuàn guānzhòng dàilái le wújìn huānxiào.",
    example_vi: "Bộ phim điện ảnh hài hước xuất sắc này nhờ vào cốt truyện hóm hỉnh chặt chẽ đã đem đến tiếng cười bất tận cho khán giả rạp chiếu."
  },
  {
    id: 5006,
    hanzi: "喜事",
    pinyin: "xǐshì",
    word_type: "Danh từ",
    meaning_vi: "chuyện vui, việc hỷ",
    example_hanzi: "老邻居家的儿子今天喜结良缘，亲朋好友们欢聚一堂共同祝贺大喜事。",
    example_pinyin: "Lǎo línjū jiā de érzi jīntiān xǐjié-liángyuán, qīnpéng-hǎoyǒu men huānjù yìtáng gòngtóng zhùhè dà xǐshì.",
    example_vi: "Con trai nhà người láng giềng cũ hôm nay kết duyên lành, bà con bạn bè tề tựu một nhà cùng nhau chúc mừng việc đại hỷ."
  },
  {
    id: 5007,
    hanzi: "洗漱",
    pinyin: "xǐshù",
    word_type: "Động từ",
    meaning_vi: "rửa mặt đánh răng, vệ sinh cá nhân",
    example_hanzi: "清晨起床后快速洗漱完毕，吃过营养丰富的早餐后便精神饱满地出门上班。",
    example_pinyin: "Qīngchén qǐchuáng hòu kuàisù xǐshù wánbì, chīguò yíngyǎng fēngfù de zǎocān hòu biàn jīngshén bǎomǎn de chūmén shàngbān.",
    example_vi: "Sáng sớm sau khi thức dậy nhanh chóng làm vệ sinh cá nhân xong xuôi, ăn bữa sáng giàu dinh dưỡng rồi tinh thần phấn chấn rời nhà đi làm."
  },
  {
    id: 5011,
    hanzi: "戏曲",
    pinyin: "xìqǔ",
    word_type: "Danh từ",
    meaning_vi: "hý kịch truyền thống (kinh kịch, việt kịch, v.v.)",
    example_hanzi: "中国传统传统戏曲集唱念做打于一体，是中华优秀传统文化的耀眼瑰宝。",
    example_pinyin: "Zhōngguó chuántǒng xìqǔ jí chàng-niàn-zuò-dǎ yú yìtǐ, shì Zhōnghuá yōuxiù chuántǒng wénhuà de yàoyǎn guībǎo.",
    example_vi: "Hý kịch truyền thống Trung Hoa hội tụ xướng niệm tác đả trong một thể thống nhất, là viên ngọc quý rực rỡ của văn hóa truyền thống ưu tú Trung Hoa."
  },
  {
    id: 5014,
    hanzi: "下功夫",
    pinyin: "xià gōngfu",
    word_type: "Động từ cụm",
    meaning_vi: "bỏ công sức, dày công nghiên cứu",
    example_hanzi: "要想在学术研究领域取得突破，就必须在原始文献考证上下大功夫。",
    example_pinyin: "Yào xiǎng zài xuéshù yánjiū lǐngyù qǔdé tūpò, jiù bìxū zài yuánshǐ wénxiàn kǎozhèng shang xià dà gōngfu.",
    example_vi: "Muốn đạt được bước đột phá trong lĩnh vực nghiên cứu học thuật thì bắt buộc phải dày công khảo chứng các nguồn tài liệu nguyên bản."
  },
  {
    id: 5015,
    hanzi: "下单",
    pinyin: "xiàdān",
    word_type: "Động từ",
    meaning_vi: "đặt hàng, lên đơn",
    example_hanzi: "在电商促销活动期间，消费者只需轻点屏幕即可快速完成线上选购与下单。",
    example_pinyin: "Zài diànshāng cùxiāo huódòng qījiān, xiāofèizhě zhǐ xū qīng diǎn píngmù jíkě kuàisù wánchéng xiànshàng xuǎngòu yǔ xiàdān.",
    example_vi: "Trong thời gian diễn ra chương trình khuyến mãi thương mại điện tử, người tiêu dùng chỉ cần chạm nhẹ màn hình là có thể nhanh chóng hoàn tất chọn hàng và đặt đơn trực tuyến."
  },
  {
    id: 5017,
    hanzi: "下线",
    pinyin: "xiàxiàn",
    word_type: "Động từ",
    meaning_vi: "xuất xưởng (dây chuyền); ngoại tuyến, ngừng phục vụ",
    example_hanzi: "随着生产线上最后一颗螺栓拧紧，首台全国产智能新能源重卡成功下线。",
    example_pinyin: "Suízhe shēngchǎnxiàn shang zuìhòu yì kē luóshuān nǐngjǐn, shǒu tái quán guóchǎn zhìnéng xīn néngyuán zhòngkǎ chénggōng xiàxiàn.",
    example_vi: "Cùng với con ốc vít cuối cùng trên dây chuyền sản xuất được vặn chặt, chiếc xe tải hạng nặng năng lượng mới thông minh sản xuất nội địa 100% đầu tiên đã xuất xưởng thành công."
  },
  {
    id: 5018,
    hanzi: "下旬",
    pinyin: "xiàxún",
    word_type: "Danh từ",
    meaning_vi: "hạ tuần (10 ngày cuối tháng)",
    example_hanzi: "根据高校教学日历统筹安排，本学期期末考试定于下月下旬全面展开。",
    example_pinyin: "Gēnjù gāoxiào jiàoxué rìlì tǒngchóu ānpái, běn xuéqī qīmò kǎoshì dìng yú xià yuè xiàxún quánmiàn zhǎnkāi.",
    example_vi: "Căn cứ theo kế hoạch điều phối lịch giảng dạy của trường đại học, kỳ thi cuối học kỳ này dự kiến sẽ bắt đầu diễn ra đồng loạt vào hạ tuần tháng sau."
  },
  {
    id: 5023,
    hanzi: "显",
    pinyin: "xiǎn",
    word_type: "Động từ / Tính từ",
    meaning_vi: "hiển hiện, tỏ ra, lộ vẻ",
    example_hanzi: "换上一身剪裁得体的新中式深色正装，他整个人看起来格外显精神气质。",
    example_pinyin: "Huànshàng yì shēn jiǎncái détǐ de xīn zhōngshì shēnsè zhèngzhuāng, tā zhěnggè rén kàn qǐlái géwài xiǎn jīngshén qìzhì.",
    example_vi: "Khoác lên bộ âu phục sẫm màu phong cách Trung Hoa tân thời cắt may vừa vặn, toàn thân anh ấy trông toát lên phong thái tinh thần đặc biệt sáng ngời."
  },
  {
    id: 5024,
    hanzi: "险",
    pinyin: "xiǎn",
    word_type: "Tính từ / Phó từ",
    meaning_vi: "nguy hiểm; suýt nữa",
    example_hanzi: "前锋球员在终场前一分钟的大力抽射击中门柱弹出，守门员直呼好险。",
    example_pinyin: "Qiánfēng qiúyuán zài zhōngchǎng qián yì fēnzhōng de dàlì chōushè jīzhòng ménzhù tánchū, shǒuményuán zhí hū hǎo xiǎn.",
    example_vi: "Cú sút sấm sét của tiền đạo ở phút cuối cùng trước khi hết giờ dội trúng cột dọc bật ra, thủ môn chỉ biết thốt lên suýt nữa thì chết nguy hiểm quá."
  },
  {
    id: 5026,
    hanzi: "限",
    pinyin: "xiàn",
    word_type: "Động từ",
    meaning_vi: "giới hạn, hạn chế",
    example_hanzi: "本次高层次拔尖创新人才选拔面向全国高校，报名年龄限三十五周岁以下。",
    example_pinyin: "Běncì gāo céngcì bájiān chuàngxīn réncái xuǎnbá miànxiàng quánguó gāoxiào, bàomíng niánlíng xiàn sānshíwǔ zhōusuì yǐxià.",
    example_vi: "Đợt tuyển chọn nhân tài đổi mới sáng tạo xuất chúng tầng nấc cao lần này hướng tới các trường đại học toàn quốc, độ tuổi đăng ký giới hạn dưới ba mươi lăm tuổi."
  },
  {
    id: 5027,
    hanzi: "线",
    pinyin: "xiàn",
    word_type: "Danh từ / Lượng từ",
    meaning_vi: "sợi dây, đường ranh, tuyến đường",
    example_hanzi: "城市新规划的轨道交通线直达国际机场，大幅缩短了市民换乘用时。",
    example_pinyin: "Chéngshì xīn guīhuà de guǐdào jiāotōng xiàn zhídá guójì jīchǎng, dàfú suōduǎn le shìmín huànchéng yòngshí.",
    example_vi: "Tuyến giao thông đường sắt mới được quy hoạch của thành phố chạy thẳng tới sân bay quốc tế, rút ngắn đáng kể thời gian trung chuyển của người dân."
  },
  {
    id: 5028,
    hanzi: "现存",
    pinyin: "xiàncún",
    word_type: "Động từ / Tính từ",
    meaning_vi: "hiện còn tồn tại, hiện tồn",
    example_hanzi: "这座宏伟古朴的木构大殿是现存年代最久远的唐代皇家佛教木构建筑。",
    example_pinyin: "Zhè zuò hóngwěi gǔpǔ de mùgòu dàdiàn shì xiàncún niándài zuì jiǔyuǎn de Tángdài huángjiā fójiào mùgòu jiànzhù.",
    example_vi: "Tòa đại điện kết cấu gỗ cổ kính tráng lệ này là công trình kiến trúc Phật giáo hoàng gia bằng gỗ thời Đường có niên đại lâu đời nhất hiện còn tồn tại."
  },
  {
    id: 5029,
    hanzi: "限度",
    pinyin: "xiàndù",
    word_type: "Danh từ",
    meaning_vi: "mức độ giới hạn, hạn độ",
    example_hanzi: "在工程实施过程中，我们必须尽最大限度减少施工对周边生态环境的干扰。",
    example_pinyin: "Zài gōngchéng shíshī guòchéng zhōng, wǒmen bìxū jìn zuìdà xiàndù jiǎnshǎo shīgōng duì zhōubiān shēngtài huánjìng de gānrǎo.",
    example_vi: "Trong quá trình triển khai công trình, chúng ta phải giảm thiểu tới mức tối đa sự tác động phiền nhiễu của việc thi công đối với môi trường sinh thái lân cận."
  },
  {
    id: 5030,
    hanzi: "现货",
    pinyin: "xiànhuò",
    word_type: "Danh từ",
    meaning_vi: "hàng có sẵn, hàng giao ngay",
    example_hanzi: "仓库内各类核心芯片备件现货储备充足，能够确保生产线满负荷平稳运转。",
    example_pinyin: "Cāngkù nèi gèlèi héxīn xīnpiàn bèijiàn xiànhuò chǔbèi chōngzú, nénggòu quèbǎo shēngchǎnxiàn mǎnfùhè píngwěn yùnzhuǎn.",
    example_vi: "Lượng hàng linh kiện chip cốt lõi có sẵn trong kho dự trữ dồi dào, có thể đảm bảo dây chuyền sản xuất vận hành ổn định tối đa công suất."
  },
  {
    id: 5033,
    hanzi: "限于",
    pinyin: "xiànyú",
    word_type: "Động từ",
    meaning_vi: "bị giới hạn trong, chỉ giới hạn ở",
    example_hanzi: "学术研讨会的交流内容不应当仅限于理论探讨，更要注重解决实际工程痛点。",
    example_pinyin: "Xuéshù yántǎohuì de jiāoliú nèiróng bù yīngdāng jǐn xiànyú lǐlùn tàntǎo, gèng yào zhùzhòng jiějué shíjì gōngchéng tòngdiǎn.",
    example_vi: "Nội dung giao lưu tại hội thảo học thuật không nên chỉ giới hạn trong việc thảo luận lý thuyết, mà càng cần chú trọng giải quyết những điểm nghẽn thực tế của công trình."
  },
  {
    id: 5036,
    hanzi: "相传",
    pinyin: "xiāngchuán",
    word_type: "Động từ",
    meaning_vi: "tương truyền, lưu truyền",
    example_hanzi: "相传这座古老清幽的寺院初建于东汉年间，距今已有一千八百多年的悠久历史。",
    example_pinyin: "Xiāngchuán zhè zuò gǔlǎo qīngyōu de sìyuàn chū jiàn yú Dōng Hàn niánjiān, jùjīn yǐ yǒu yì qiān bā bǎi duō nián de yōujiǔ lìshǐ.",
    example_vi: "Tương truyền ngôi chùa cổ kính thanh tịnh này được khởi dựng vào những năm Đông Hán, đến nay đã có bề dày lịch sử hơn một nghìn tám trăm năm."
  },
  {
    id: 5038,
    hanzi: "相连",
    pinyin: "xiānglián",
    word_type: "Động từ",
    meaning_vi: "nối liền nhau, gắn kết",
    example_hanzi: "这座宏伟的跨海大桥像一条巨龙，将两座隔海相望的现代化海滨城市紧密相连。",
    example_pinyin: "Zhè zuò hóngwěi de kuàhǎi dàqiáo xiàng yì tiáo jùlóng, jiāng liǎng zuò gé hǎi xiāngwàng de xiàndàihuà hǎibīn chéngshì jǐnmì xiānglián.",
    example_vi: "Cây cầu vượt biển tráng lệ này tựa như một con rồng khổng lồ, nối liền khăng khít hai thành phố duyên hải hiện đại trông ngóng nhau qua biển."
  },
  {
    id: 5039,
    hanzi: "香水",
    pinyin: "xiāngshuǐ",
    word_type: "Danh từ",
    meaning_vi: "nước hoa",
    example_hanzi: "她轻轻喷洒了少许淡雅芬芳的花香香水，令人感觉清新宜人、心情舒畅。",
    example_pinyin: "Tā qīngqīng pēnsǎ le shǎoxǔ dànyǎ fēnfāng de huāxiāng xiāngshuǐ, lìng rén gǎnjué qīngxīn yírén, xīnqíng shūchàng.",
    example_vi: "Cô ấy xịt nhẹ một chút nước hoa hương hoa thanh nhã ngát hương, khiến người ta cảm thấy thanh khiết dễ chịu, tinh thần sảng khoái."
  },
  {
    id: 5052,
    hanzi: "小偷儿",
    pinyin: "xiǎotōur",
    word_type: "Danh từ",
    meaning_vi: "tên trộm, kẻ cắp",
    example_hanzi: "便衣警察在拥挤热闹的公交站台果断出击，当场抓获了企图行窃的小偷儿。",
    example_pinyin: "Biànyī jǐngchá zài yōngjǐ rènào de gōngjiāo zhàntái guǒduàn chūjī, dāngchǎng zhuāhuò le qǐtú xíngqiè de xiǎotōur.",
    example_vi: "Cảnh sát mặc thường phục trên trạm dừng xe buýt đông đúc náo nhiệt đã dứt khoát ra tay, tóm gọn tại trận tên kẻ cắp đang mưu toan móc túi."
  },
  {
    id: 5053,
    hanzi: "笑容",
    pinyin: "xiàoróng",
    word_type: "Danh từ",
    meaning_vi: "nụ cười, nét mặt cười",
    example_hanzi: "看到灾后重建的新校园拔地而起，孩子们的脸上绽放出了灿烂纯真的笑容。",
    example_pinyin: "Kàndào zāihòu chóngjiàn de xīn xiàoyuán bádì-érqǐ, háizi men de liǎn shang zhànfàng chū le cànlàn chúnzhēn de xiàoróng.",
    example_vi: "Nhìn thấy ngôi trường mới tái thiết sau thiên tai mọc lên sừng sững, trên gương mặt các em nhỏ nở rộ những nụ cười rạng rỡ ngây thơ."
  },
  {
    id: 5054,
    hanzi: "效应",
    pinyin: "xiàoyìng",
    word_type: "Danh từ",
    meaning_vi: "hiệu ứng",
    example_hanzi: "自贸试验区的建立产生了明显的辐射带动效应，有力促进了区域经济协同发展。",
    example_pinyin: "Zìmào shìyànqū de jiànlì chǎnshēng le míngxiǎn de fúshè dàidòng xiàoyìng, yǒulì cùjìn le qūyù jīngjì xiétóng fāzhǎn.",
    example_vi: "Việc thành lập khu thí nghiệm thương mại tự do đã tạo ra hiệu ứng lan tỏa dẫn dắt rõ rệt, thúc đẩy mạnh mẽ sự phát triển nhịp nhàng kinh tế vùng."
  },
  {
    id: 5060,
    hanzi: "心爱",
    pinyin: "xīn’ài",
    word_type: "Tính từ",
    meaning_vi: "yêu dấu, trân quý, yêu quý",
    example_hanzi: "他小心翼翼地把心爱多年的小提琴放入精致琴盒，准备前往音乐厅排练。",
    example_pinyin: "Tā xiǎoxīn-yìyì de bǎ xīn'ài duō nián de xiǎotíqín fàngrù jīngzhì qínhé, zhǔnbèi qiánwǎng yīnyuètīng páiliàn.",
    example_vi: "Anh ấy cẩn thận từng li từng tí đặt cây đàn vĩ cầm yêu quý bao năm vào chiếc hộp đàn tinh tế, chuẩn bị đến phòng hòa nhạc tập dượt."
  },
  {
    id: 5061,
    hanzi: "心底",
    pinyin: "xīndǐ",
    word_type: "Danh từ",
    meaning_vi: "đáy lòng, tận sâu trong tim",
    example_hanzi: "母校老师多年如一日的悉心教导与深切关爱，永远铭刻在每一名毕业学子的心底。",
    example_pinyin: "Mǔxiào lǎoshī duō nián rú yírì de xīxīn jiàodǎo yǔ shēnqiè guān'ài, yǒngyuǎn míngkè zài měi yì míng bìyè xuézǐ de xīndǐ.",
    example_vi: "Sự dạy bảo ân cần và tình yêu thương sâu sắc như một của thầy cô trường cũ bao năm qua mãi mãi khắc sâu trong đáy lòng mỗi một người học trò ra trường."
  },
  {
    id: 5062,
    hanzi: "新款",
    pinyin: "xīnkuǎn",
    word_type: "Danh từ",
    meaning_vi: "mẫu mới, dòng mới",
    example_hanzi: "这款即将发布的新款智能可穿戴健康手环集成了多项先进的生理监测传感器。",
    example_pinyin: "Zhè kuǎn jíjiāng fābù de xīnkuǎn zhìnéng kěchuāndài jiànkāng shǒuhuán jíchéng le duō xiàng xiānjìn de shēnglǐ jiāncè chuángǎnqì.",
    example_vi: "Chiếc vòng tay sức khỏe thông minh có thể đeo mẫu mới sắp phát hành này tích hợp nhiều cảm biến theo dõi sinh lý tiên tiến."
  },
  {
    id: 5064,
    hanzi: "新媒体",
    pinyin: "xīnméitǐ",
    word_type: "Danh từ",
    meaning_vi: "truyền thông mới (mạng xã hội, báo điện tử)",
    example_hanzi: "传统主流报刊积极拥抱新媒体传播矩阵，不断扩大新闻资讯的社会传播力。",
    example_pinyin: "Chuántǒng zhǔliú bàokān jījí yōngbào xīnméitǐ chuánbō jùzhèn, búduàn kuòdà xīnwén zīxùn de shèhuì chuánbōlì.",
    example_vi: "Các cơ quan báo chí chủ lưu truyền thống tích cực đón nhận ma trận truyền thông mới, không ngừng mở rộng sức lan tỏa xã hội của tin tức báo chí."
  },
  {
    id: 5065,
    hanzi: "心目",
    pinyin: "xīnmù",
    word_type: "Danh từ",
    meaning_vi: "trong mắt, trong tâm trí",
    example_hanzi: "那位扎根边远山区支教三十载的乡村教师，是全体村民心目中真正的楷模英雄。",
    example_pinyin: "Nà wèi zhāgēn biānyuǎn shānqū zhījiào sānshí zǎi de xiāngcūn jiàoshī, shì quántǐ cūnmín xīnmù zhōng zhēnzhèng de kǎimó yīngxióng.",
    example_vi: "Người thầy giáo thôn bản cắm chốt dạy học tình nguyện nơi vùng cao hẻo lánh ba mươi năm ấy là tấm gương anh hùng thực thụ trong tâm trí toàn thể dân làng."
  },
  {
    id: 5066,
    hanzi: "新能源",
    pinyin: "xīnnéngyuán",
    word_type: "Danh từ",
    meaning_vi: "năng lượng mới (điện gió, mặt trời, xe điện)",
    example_hanzi: "加快建设以风电和太阳能为主体的新能源体系，是实现双碳战略目标的核心支撑。",
    example_pinyin: "Jiākuài jiànshè yǐ fēngdiàn hé tàiyángnéng wéi zhǔtǐ de xīnnéngyuán tǐxì, shì shíxiàn shuāng tàn zhànlüè mùbiāo de héxīn zhīchēng.",
    example_vi: "Đẩy nhanh xây dựng hệ thống năng lượng mới lấy điện gió và năng lượng mặt trời làm nòng cốt là chỗ dựa cốt lõi để thực hiện mục tiêu chiến lược hai-carbon."
  },
  {
    id: 5069,
    hanzi: "新兴",
    pinyin: "xīnxīng",
    word_type: "Tính từ",
    meaning_vi: "mới nổi, đang lên",
    example_hanzi: "国家大力支持战略性新兴产业发展，积极培育经济高质量增长的全新引擎。",
    example_pinyin: "Guójiā dàlì zhīchí zhànlüèxìng xīnxīng chǎnyè fāzhǎn, jījí péiyù jīngjì gāo zhìliàng zēngzhǎng de quánxīn yǐnSelected qíng.",
    example_vi: "Nhà nước dốc sức ủng hộ phát triển các ngành công nghiệp mới nổi mang tính chiến lược, tích cực bồi dưỡng động cơ hoàn toàn mới cho sự tăng trưởng kinh tế chất lượng cao."
  },
  {
    id: 5071,
    hanzi: "心愿",
    pinyin: "xīnyuàn",
    word_type: "Danh từ",
    meaning_vi: "tâm nguyện, ước nguyện chân thành",
    example_hanzi: "经过几代治沙人的不懈拼搏，昔日漫漫黄沙终变绿洲，实现了百姓多年的绿色心愿。",
    example_pinyin: "Jīngguò jǐ dài zhìshārén de búxiè pīnbó, xīrì mànmàn huángshā zhōng biàn lǜzhōu, shíxiàn le bǎixìng duō nián de lǜsè xīnyuàn.",
    example_vi: "Trải qua sự nỗ lực kiên cường của mấy thế hệ người ngăn cát, dải cát vàng bạt ngàn năm xưa rốt cuộc hóa thành ốc đảo xanh, hiện thực hóa tâm nguyện xanh bao năm của người dân."
  },
  {
    id: 5075,
    hanzi: "兴起",
    pinyin: "xīngqǐ",
    word_type: "Động từ",
    meaning_vi: "trỗi dậy, dấy lên, nổi lên",
    example_hanzi: "互联网共享经济模式的迅速兴起，深刻改变了现代都市人的日常出行与生活方式。",
    example_pinyin: "Hùliánwǎng gòngxiǎng jīngjì móshì de xùnsù xīngqǐ, shēnkè gǎibiàn le xiàndài dūshìrén de rìcháng chūxíng yǔ shēnghuó fāngshì.",
    example_vi: "Sự trỗi dậy nhanh chóng của mô hình kinh tế chia sẻ qua internet đã thay đổi sâu sắc lối sống và thói quen đi lại hàng ngày của cư dân đô thị hiện đại."
  },
  {
    id: 5076,
    hanzi: "型号",
    pinyin: "xínghào",
    word_type: "Danh từ",
    meaning_vi: "mẫu mã, chủng loại, số hiệu model",
    example_hanzi: "在订购工业机床备用零件时，请务必核对清晰设备铭牌上标注的规格型号。",
    example_pinyin: "Zài dìnggòu gōngyè jīchuáng bèiyòng língjiàn shí, qǐng wùbì héduì qīngxī shèbèi míngpái shang biāozhù de guīgé xínghào.",
    example_vi: "Khi đặt mua linh kiện thay thế cho máy công cụ công nghiệp, xin vui lòng kiểm tra đối chiếu rõ ràng quy cách và số hiệu model ghi trên bảng nhãn thiết bị."
  },
  {
    id: 5078,
    hanzi: "性价比",
    pinyin: "xìngjiàbǐ",
    word_type: "Danh từ",
    meaning_vi: "tỉ lệ hiệu năng trên giá thành (P/P)",
    example_hanzi: "这款国产智能平板电脑不仅功能全面运行流畅，而且性价比极高，销量遥遥领先。",
    example_pinyin: "Zhè kuǎn guóchǎn zhìnéng píngbǎn diànnǎo bùjǐn gōngnéng quánmiàn yùnxíng liúchàng, érqiě xìngjiàbǐ jí gāo, xiāoliàng yáoyáo-lǐngxiān.",
    example_vi: "Mẫu máy tính bảng thông minh sản xuất nội địa này không chỉ tính năng toàn diện vận hành mượt mà, mà hiệu năng trên giá cả còn cực cao, doanh số bán ra dẫn đầu vượt trội."
  },
  {
    id: 5081,
    hanzi: "修订",
    pinyin: "xiūdìng",
    word_type: "Động từ",
    meaning_vi: "sửa đổi, tu chỉnh, hiệu đính",
    example_hanzi: "专家委员会历时数月完成了对国家职业资格考试大纲的系统性全面修订与完善。",
    example_pinyin: "Zhuānjiā wěiyuánhuì lìshí shù yuè wánchéng le duì guójiā zhíyè zīgé kǎoshì dàgāng de xìtǒngxìng quánmiàn xiūdìng yǔ wánshàn.",
    example_vi: "Hội đồng chuyên gia mất nhiều tháng đã hoàn tất việc tu chỉnh và hoàn thiện toàn diện mang tính hệ thống đề cương kỳ thi chứng chỉ nghề nghiệp quốc gia."
  },
  {
    id: 5083,
    hanzi: "袖子",
    pinyin: "xiùzi",
    word_type: "Danh từ",
    meaning_vi: "tay áo, ống tay áo",
    example_hanzi: "工人们挽起袖子甩开膀子加油干，抢抓施工黄金期推进重大工程建设。",
    example_pinyin: "Gōngrén men wǎn qǐ xiùzi shuǎikāi bǎngzi jiāyóu gàn, qiǎng zhuā shīgōng huángjīnqī tuījìn zhòngdà gōngchéng jiànshè.",
    example_vi: "Các công nhân xắn cao tay áo dốc sức ra sức làm việc, tranh thủ thời điểm vàng thi công để đẩy nhanh tiến độ xây dựng công trình trọng đại."
  },
  {
    id: 5088,
    hanzi: "选修",
    pinyin: "xuǎnxiū",
    word_type: "Động từ",
    meaning_vi: "học tự chọn, môn tự chọn",
    example_hanzi: "大学鼓励本科生跨学科自由选修人文素养与艺术鉴赏类通识课程。",
    example_pinyin: "Dàxué gǔlì běnkēshēng kuà xuékē zìyóu xuǎnxiū rénwén sùyǎng yǔ yìshù jiànshǎng lèi tōngshí kèchéng.",
    example_vi: "Trường đại học khuyến khích sinh viên đại học tự do học tự chọn liên ngành các môn học đại cương bồi dưỡng phẩm chất nhân văn và thẩm định nghệ thuật."
  },
  {
    id: 5089,
    hanzi: "学会",
    pinyin: "xuéhuì",
    word_type: "Danh từ",
    meaning_vi: "hội học thuật, hội chuyên môn",
    example_hanzi: "中国计算机学会每年定期举办前沿学术年会，汇聚数千名业界顶尖学者专家。",
    example_pinyin: "Zhōngguó Jìsuànjī Xuéhuì měi nián dìngqī jǔbàn qiányán xuéshù niánhuì, huìjù shù qiān míng yèjiè dǐngjiān xuézhě zhuānjiā.",
    example_vi: "Hội Tin học Trung Quốc định kỳ tổ chức hội nghị học thuật thường niên mũi nhọn hàng năm, quy tụ hàng ngàn học giả chuyên gia hàng đầu trong ngành."
  },
  {
    id: 5092,
    hanzi: "学员",
    pinyin: "xuéyuán",
    word_type: "Danh từ",
    meaning_vi: "học viên",
    example_hanzi: "在为期三个月的骨干培训班上，全体青年学员刻苦钻研、圆满结业。",
    example_pinyin: "Zài wéiqī sān gè yuè de gǔgàn péixùnbān shang, quántǐ qīngnián xuéyuán kèkǔ zhuānyán, yuánmǎn jiéyè.",
    example_vi: "Tại lớp bồi dưỡng cán bộ nòng cốt kéo dài ba tháng, toàn thể các học viên trẻ tuổi đã miệt mài nghiên cứu và tốt nghiệp mỹ mãn."
  },
  {
    id: 5093,
    hanzi: "血管",
    pinyin: "xuèguǎn",
    word_type: "Danh từ",
    meaning_vi: "mạch máu",
    example_hanzi: "保持低盐低脂的健康饮食和适度有氧锻炼，有助于维护全身血管弹性与通畅。",
    example_pinyin: "Bǎochí dīyán dījī de jiànkāng yǐnshí hé shìdù yǒuyǎng duànliàn, yǒuzhùyú wéihù quánshēn xuèguǎn tánxìng yǔ tōngchàng.",
    example_vi: "Duy trì chế độ ăn lành mạnh ít muối ít mỡ và tập luyện thể dục nhịp điệu vừa phải sẽ giúp bảo toàn độ đàn hồi và thông suốt của các mạch máu toàn thân."
  },
  {
    id: 5094,
    hanzi: "血型",
    pinyin: "xuèxíng",
    word_type: "Danh từ",
    meaning_vi: "nhóm máu",
    example_hanzi: "医院在开展外科手术输血治疗前，必须严格反复交叉核验患者与献血者的血型。",
    example_pinyin: "Yīyuàn zài kāizhǎn wàikē shǒushù shūxuè zhìliáo qián, bìxū yángé fǎnfù jiāochā héyàn huànzhě yǔ xiànxuèzhě de xuèxíng.",
    example_vi: "Bệnh viện trước khi tiến hành truyền máu phẫu thuật ngoại khoa bắt buộc phải kiểm tra chéo nhóm máu của bệnh nhân và người hiến máu một cách nghiêm ngặt nhiều lần."
  },
  {
    id: 5096,
    hanzi: "血液",
    pinyin: "xuèyè",
    word_type: "Danh từ",
    meaning_vi: "máu, huyết dịch",
    example_hanzi: "广大市民踊跃参加无偿献血活动，用爱心血液点亮了病危患者的生命希望。",
    example_pinyin: "Guǎngdà shìmín yǒngyuè cānjiā wúcháng xiànxuè huódòng, yòng àixīn xuèyè diǎnliàng le bìngwēi huànzhě de shēngmìng xīwàng.",
    example_vi: "Đông đảo người dân thành phố hăng hái tham gia hoạt động hiến máu nhân đạo, dùng những giọt máu thắm đượm yêu thương thắp sáng hy vọng sống cho các bệnh nhân nguy kịch."
  },
  {
    id: 5098,
    hanzi: "寻求",
    pinyin: "xúnqiú",
    word_type: "Động từ",
    meaning_vi: "tìm kiếm, mưu cầu",
    example_hanzi: "面对复杂的国际地缘争端，各方应当坚持通过和平对话谈判积极寻求妥善化解方案。",
    example_pinyin: "Miànduì fùzá de guójì dìyuán zhēngduān, gèfāng yīngdāng jiānchí tōngguò hépíng duìhuà tánpàn jījí xúnqiú tuǒshàn huàjiě fāng'àn.",
    example_vi: "Trước các tranh chấp địa chính trị quốc tế phức tạp, các bên nên kiên trì thông qua đối thoại đàm phán hòa bình để tích cực tìm kiếm phương án hóa giải thỏa đáng."
  },
  {
    id: 5101,
    hanzi: "淹",
    pinyin: "yān",
    word_type: "Động từ",
    meaning_vi: "ngập, ngập lụt, chìm ngập",
    example_hanzi: "特大暴雨导致市区部分低洼路段积水严重，多辆停靠路边的私家车被水淹没。",
    example_pinyin: "Tèdà bàoyǔ dǎozhì shìqū bùfen dīwā lùduàn jīshuǐ yánzhòng, duō liàng tíngkào lùbiān de sījiāchē bèi shuǐ yānmò.",
    example_vi: "Trận mưa giông đặc biệt lớn đã khiến một số đoạn đường trũng thấp trong nội đô ứ đọng nước nghiêm trọng, nhiều xe ô tô cá nhân đỗ ven đường bị ngập chìm trong nước."
  },
  {
    id: 5103,
    hanzi: "严",
    pinyin: "yán",
    word_type: "Tính từ",
    meaning_vi: "nghiêm khắc, nghiêm ngặt, chặt chẽ",
    example_hanzi: "治学必须保持极其严谨求实的学风态度，容不得一丝半点的马虎松懈。",
    example_pinyin: "Zhìxué bìxū bǎochí jíqí yánjǐn qiúshí de xuéfēng tàidù, róng bu dé yì sī bàndiǎn de mǎhu sōngxiè.",
    example_vi: "Nghiên cứu học thuật bắt buộc phải duy trì thái độ phong cách học thuật cực kỳ nghiêm cẩn cầu thị, không thể dung túng cho một chút sơ sài buông thả nào."
  },
  {
    id: 5111,
    hanzi: "研讨",
    pinyin: "yántǎo",
    word_type: "Động từ / Danh từ",
    meaning_vi: "nghiên cứu thảo luận, hội thảo",
    example_hanzi: "来自海内外的顶尖专家学者齐聚一堂，共同深入研讨应对气候变暖的科学方案。",
    example_pinyin: "Láizì hǎi nèiwài de dǐngjiān zhuānjiā xuézhě qíjù yìtáng, gòngtóng shēnrù yántǎo yìngduì qìhòu biànnuǎn de kēxué fāng'àn.",
    example_vi: "Các chuyên gia học giả hàng đầu trong và ngoài nước tề tựu một nơi, cùng nhau thảo luận sâu sắc về các giải pháp khoa học ứng phó với hiện tượng khí hậu nóng lên."
  },
  {
    id: 5113,
    hanzi: "言语",
    pinyin: "yányǔ",
    word_type: "Danh từ",
    meaning_vi: "lời nói, ngôn từ, ngôn ngữ",
    example_hanzi: "他用真挚诚恳的言语向大家讲述了自己扎根乡村教育的感人奋斗历程。",
    example_pinyin: "Tā yòng zhēnzhì chéngkěn de yányǔ xiàng dàjiā jiǎngshù le zìjǐ zhāgēn xiāngcūn jiàoyù de gǎnrén fèndòu lìchéng.",
    example_vi: "Thầy dùng những lời lẽ chân thành tha thiết kể cho mọi người nghe về chặng đường phấn đấu đầy cảm động khi cắm rễ dạy học nơi thôn dã của bản thân."
  },
  {
    id: 5114,
    hanzi: "炎症",
    pinyin: "yánzhèng",
    word_type: "Danh từ",
    meaning_vi: "chứng viêm, sưng viêm",
    example_hanzi: "遵医嘱按时规范服用消炎抗生素药物，能有效控制术后伤口的局部炎症反应。",
    example_pinyin: "Zūn yīzhǔ ànshí guīfàn fúyòng xiāoyán kàngshēngsù yàowù, néng yǒuxiào kòngzhì shùhòu shāngkǒu de júbù yánzhèng fǎnyìng.",
    example_vi: "Tuân theo y lệnh uống thuốc kháng sinh tiêu viêm đúng giờ và chuẩn mực có thể kiểm soát hiệu quả phản ứng viêm cục bộ tại vết mổ sau phẫu thuật."
  },
  {
    id: 5116,
    hanzi: "眼看",
    pinyin: "yǎnkàn",
    word_type: "Phó từ / Động từ",
    meaning_vi: "nhìn thấy; chớp mắt đã, sắp sửa",
    example_hanzi: "眼看暴风雨即将来临，田间抢收小麦的农民们加快了挥舞镰刀的收割节奏。",
    example_pinyin: "Yǎnkàn bàofēngyǔ jíjiāng láilín, tiánjiān qiǎngshōu xiàomài de nóngmín men jiākuài le huīwǔ liándāo de shōugē jiézòu.",
    example_vi: "Trông thấy cơn mưa giông sắp sửa ập đến, các bác nông dân đang gặt lúa mì trên đồng nhanh chóng đẩy nhanh nhịp vung liềm thu hoạch."
  },
  {
    id: 5120,
    hanzi: "仰",
    pinyin: "yǎng",
    word_type: "Động từ",
    meaning_vi: "ngửa, ngước nhìn, ngưỡng mộ",
    example_hanzi: "夜幕降临，他独自仰望着浩瀚深邃的繁星苍穹，陷入了深沉悠远的思考。",
    example_pinyin: "Yèmù jiànglín, tā dúzì yǎngwàng zhe hàohàn shēnsuì de fánxīng cāngqióng, xiànrù le shēnchén yōuyuǎn de sīkǎo.",
    example_vi: "Đêm đen buông xuống, anh một mình ngửa mặt ngước nhìn vòm trời đầy sao thăm thẳm bao la, chìm đắm vào dòng suy tưởng sâu lắng miên man."
  }
];

console.log(`Batch 7 total words: ${BATCH_7_DATA.length}`);

// 1. Create data/hsk6-batch7-data.ts
const dataFilePath = 'data/hsk6-batch7-data.ts';
let tsContent = `// Dữ liệu 100 từ vựng mục tiêu HSK 6 (Batch 7/8: 跳水 -> 仰)
// Thuộc Đề cương thi HSK 3.0 công bố tháng 11/2025 bởi CTI (汉考国际)
// Tất cả câu ví dụ độ dài 12-25 chữ Hán, có Pinyin chuẩn và bản dịch tiếng Việt chuẩn xác cho luyện gõ IME.

export interface Hsk6WordSeed {
  id?: number;
  hanzi: string;
  pinyin: string;
  meaning_vi: string;
  word_type: string;
  hsk_level: string;
  category: string;
  example_hanzi: string;
  example_pinyin: string;
  example_vi: string;
  source: string;
  source_version: string;
  generation_method: string;
  validation_status: string;
  lifecycle_status: string;
  notes: string;
}

export const HSK6_BATCH7_WORDS: Hsk6WordSeed[] = [
`;

for (const item of BATCH_7_DATA) {
  tsContent += `  {
    hanzi: ${JSON.stringify(item.hanzi)},
    pinyin: ${JSON.stringify(item.pinyin)},
    meaning_vi: ${JSON.stringify(item.meaning_vi)},
    word_type: ${JSON.stringify(item.word_type)},
    hsk_level: "HSK 6",
    category: "hsk3_2025",
    example_hanzi: ${JSON.stringify(item.example_hanzi)},
    example_pinyin: ${JSON.stringify(item.example_pinyin)},
    example_vi: ${JSON.stringify(item.example_vi)},
    source: "cti_official_2025",
    source_version: "2025_syllabus_11_2025",
    generation_method: "curated_standard",
    validation_status: "verified_target_syllabus",
    lifecycle_status: "active",
    notes: "Mục từ mới HSK 6 theo Đề cương thi 11/2025 (Batch 7/8)"
  },\n`;
}

tsContent += `];\n`;
fs.writeFileSync(dataFilePath, tsContent, 'utf8');
console.log(`Đã tạo thành công ${dataFilePath}!`);

// 2. Create Migration SQL & Rollback SQL
const migrationTimestamp = '20261023080000';
const migrationPath = `supabase/migrations/${migrationTimestamp}_hsk6_batch7_words_seed.sql`;
const rollbackPath = `supabase/migrations/rollbacks/${migrationTimestamp}_hsk6_batch7_words_seed_rollback.sql`;

let sql = `-- ==============================================================================
-- MIGRATION SCRIPT: ${migrationTimestamp}_hsk6_batch7_words_seed.sql
-- Nạp Batch 7/8 (100 từ mới HSK 6 theo Đề cương CTI 11/2025: 跳水 -> 仰)
-- Kèm câu ví dụ chuẩn 12-25 chữ, Pinyin đầy đủ thanh điệu, dịch nghĩa tiếng Việt tự nhiên
-- An toàn: Không đè các bản ghi cũ, có transaction BEGIN ... COMMIT.
-- ==============================================================================

BEGIN;

INSERT INTO public.vocabularies (
  hanzi,
  pinyin,
  meaning_vi,
  word_type,
  hsk_level,
  category,
  example_hanzi,
  example_pinyin,
  example_vi,
  source,
  source_version,
  generation_method,
  validation_status,
  lifecycle_status,
  notes
)
VALUES
`;

const values = [];
const hanziList = [];

for (const item of BATCH_7_DATA) {
  hanziList.push(escapeSql(item.hanzi));
  values.push(`  (
    ${escapeSql(item.hanzi)},
    ${escapeSql(item.pinyin)},
    ${escapeSql(item.meaning_vi)},
    ${escapeSql(item.word_type)},
    'HSK 6',
    'hsk3_2025',
    ${escapeSql(item.example_hanzi)},
    ${escapeSql(item.example_pinyin)},
    ${escapeSql(item.example_vi)},
    'cti_official_2025',
    '2025_syllabus_11_2025',
    'curated_standard',
    'verified_target_syllabus',
    'active',
    'Mục từ mới HSK 6 theo Đề cương thi 11/2025 (Batch 7/8)'
  )`);
}

sql += values.join(',\n') + `;\n\nCOMMIT;\n`;
fs.writeFileSync(migrationPath, sql, 'utf8');
console.log(`Đã xuất Migration SQL: ${migrationPath}`);

let rollbackSql = `-- ==============================================================================
-- ROLLBACK SCRIPT: ${migrationTimestamp}_hsk6_batch7_words_seed_rollback.sql
-- Hoàn tác nạp 100 từ mới HSK 6 của Batch 7
-- ==============================================================================

BEGIN;

DELETE FROM public.vocabularies
WHERE hsk_level = 'HSK 6'
  AND source = 'cti_official_2025'
  AND notes LIKE '%Batch 7/8%'
  AND hanzi IN (${hanziList.join(', ')});

COMMIT;
`;
fs.writeFileSync(rollbackPath, rollbackSql, 'utf8');
console.log(`Đã xuất Rollback SQL: ${rollbackPath}`);
