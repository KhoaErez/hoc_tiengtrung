import fs from 'fs'

// Dữ liệu biên soạn 100 từ vựng đầu tiên của HSK 6 (Đề cương thi 11/2025)
// Mỗi từ vựng có: hanzi, pinyin, word_type, meaning_vi, example_hanzi, example_pinyin, example_vi
const BATCH_1_DATA = [
  {
    id: 3606,
    hanzi: "白白",
    pinyin: "báibái",
    word_type: "Phó từ",
    meaning_vi: "uổng công, vô ích, lãng phí",
    example_hanzi: "如果不早点出发，前期的准备工作就白白浪费了。",
    example_pinyin: "Rúguǒ bù zǎodiǎn chūfā, qiánqī de zhǔnbèi gōngzuò jiù báibái làngfèi le.",
    example_vi: "Nếu không xuất phát sớm hơn, công sức chuẩn bị giai đoạn đầu sẽ bị lãng phí uổng công."
  },
  {
    id: 3607,
    hanzi: "白领",
    pinyin: "báilǐng",
    word_type: "Danh từ",
    meaning_vi: "nhân viên văn phòng, giới cổ cồn trắng",
    example_hanzi: "许多在大城市工作的年轻白领平时工作压力很大。",
    example_pinyin: "Xǔduō zài dà chéngshì gōngzuò de niánqīng báilǐng píngshí gōngzuò yālì hěn dà.",
    example_vi: "Nhiều nhân viên văn phòng trẻ tuổi làm việc ở thành phố lớn thường ngày chịu áp lực công việc rất lớn."
  },
  {
    id: 3610,
    hanzi: "百分点",
    pinyin: "bǎifēndiǎn",
    word_type: "Danh từ",
    meaning_vi: "điểm phần trăm",
    example_hanzi: "今年第一季度该公司的营业额比去年同期增长了三个百分点。",
    example_pinyin: "Jīnnián dì-yī jìdù gāi gōngsī de yíngyè’é bǐ qùnián tóngqī zēngzhǎng le sān gè bǎifēndiǎn.",
    example_vi: "Quý đầu năm nay doanh thu của công ty này đã tăng ba điểm phần trăm so với cùng kỳ năm ngoái."
  },
  {
    id: 3611,
    hanzi: "百货",
    pinyin: "bǎihuò",
    word_type: "Danh từ",
    meaning_vi: "hàng bách hóa, hàng tạp hóa",
    example_hanzi: "市中心新开了一家大型百货商场，商品种类非常齐全。",
    example_pinyin: "Shì zhōngxīn xīn kāi le yì jiā dàxíng bǎihuò shāngchǎng, shāngpǐn zhǒnglèi fēicháng qíquán.",
    example_vi: "Ở trung tâm thành phố mới mở một trung tâm thương mại bách hóa lớn, chủng loại hàng hóa vô cùng đầy đủ."
  },
  {
    id: 3613,
    hanzi: "败",
    pinyin: "bài",
    word_type: "Động từ",
    meaning_vi: "thua, thất bại, bại trận",
    example_hanzi: "在最后的决赛中，主队以微弱的分数差遗憾败给了对手。",
    example_pinyin: "Zài zuìhòu de juésài zhōng, zhǔduì yǐ wēiruò de fēnshù chā yíhàn bài gěi le duìshǒu.",
    example_vi: "Trong trận chung kết cuối cùng, đội chủ nhà đã tiếc nuối để thua đối thủ với cách biệt điểm số sít sao."
  },
  {
    id: 3616,
    hanzi: "版",
    pinyin: "bǎn",
    word_type: "Danh từ / Lượng từ",
    meaning_vi: "bản, phiên bản; trang báo",
    example_hanzi: "这部经典词典的最新修订版增补了大量现代科技词汇。",
    example_pinyin: "Zhè bù jīngdiǎn cídiǎn de zuìxīn xiūdìngbǎn zēngbǔ le dàliàng xiàndài kējì cíhuì.",
    example_vi: "Phiên bản sửa đổi mới nhất của cuốn từ điển kinh điển này đã bổ sung rất nhiều từ vựng công nghệ hiện đại."
  },
  {
    id: 3621,
    hanzi: "棒球",
    pinyin: "bàngqiú",
    word_type: "Danh từ",
    meaning_vi: "môn bóng chày; quả bóng chày",
    example_hanzi: "学校棒球队在今年的全国大学生运动会上夺得了冠军。",
    example_pinyin: "Xuéxiào bàngqiúduì zài jīnnián de quánguó dàxuéshēng yùndònghuì shang duódé le guànjūn.",
    example_vi: "Đội bóng chày của trường đã đoạt chức vô địch tại Đại hội Thể thao Sinh viên Toàn quốc năm nay."
  },
  {
    id: 3623,
    hanzi: "保健",
    pinyin: "bǎojiàn",
    word_type: "Động từ / Danh từ",
    meaning_vi: "chăm sóc sức khỏe, bảo vệ sức khỏe",
    example_hanzi: "老年人应当根据医生的科学建议选择合适的保健方法。",
    example_pinyin: "Lǎoniánrén yīngdāng gēnjù yīshēng de kēxué jiànyì xuǎnzé héshì de bǎojiàn fāngfǎ.",
    example_vi: "Người cao tuổi nên lựa chọn phương pháp chăm sóc sức khỏe phù hợp dựa trên lời khuyên khoa học của bác sĩ."
  },
  {
    id: 3624,
    hanzi: "保暖",
    pinyin: "bǎonuǎn",
    word_type: "Động từ / Tính từ",
    meaning_vi: "giữ ấm, giữ nhiệt",
    example_hanzi: "冬天出门前一定要穿好保暖外套，避免感冒。",
    example_pinyin: "Dōngtiān chūmén qián yídìng yào chuān hǎo bǎonuǎn wàitào, bìmiǎn gǎnmào.",
    example_vi: "Mùa đông trước khi ra khỏi nhà nhất định phải mặc áo khoác giữ ấm cẩn thận để tránh bị cảm lạnh."
  },
  {
    id: 3625,
    hanzi: "保修",
    pinyin: "bǎoxiū",
    word_type: "Động từ",
    meaning_vi: "bảo hành (thiết bị, máy móc)",
    example_hanzi: "这台笔记本电脑享受全国联保服务，保修期为三年。",
    example_pinyin: "Zhè tái bǐjìběn diànnǎo xiǎngshòu quánguó liánbǎo fúwù, bǎoxiūqī wéi sān nián.",
    example_vi: "Chiếc máy tính xách tay này được hưởng dịch vụ bảo hành toàn quốc với thời hạn bảo hành là ba năm."
  },
  {
    id: 3627,
    hanzi: "爆",
    pinyin: "bào",
    word_type: "Động từ / Tính từ",
    meaning_vi: "nổ, vỡ tung; bùng nổ, đông nghẹt",
    example_hanzi: "这条突发科技新闻发布后，网络平台的阅读量瞬间爆满。",
    example_pinyin: "Zhè tiáo tūfā kējì xīnwén fābù hòu, wǎngluò píngtái de yuèdúliàng shùnjiān bàomǎn.",
    example_vi: "Sau khi tin tức công nghệ đột xuất này được đăng tải, lượng đọc trên nền tảng mạng xã hội ngay lập tức bùng nổ."
  },
  {
    id: 3629,
    hanzi: "报刊",
    pinyin: "bàokān",
    word_type: "Danh từ",
    meaning_vi: "báo chí, báo và tạp chí",
    example_hanzi: "即使在数字化时代，依然有不少读者坚持阅读纸质报刊。",
    example_pinyin: "Jíshǐ zài shùzìhuà shídài, yīrán yǒu bù shǎo dúzhě jiānchí yuèdú zhǐzhì bàokān.",
    example_vi: "Ngay cả trong thời đại số hóa, vẫn có không ít độc giả kiên trì đọc báo và tạp chí giấy."
  },
  {
    id: 3631,
    hanzi: "悲剧",
    pinyin: "bēijù",
    word_type: "Danh từ",
    meaning_vi: "bi kịch, câu chuyện đau thương",
    example_hanzi: "这部戏剧深刻展现了一场由误会引发的家庭悲剧。",
    example_pinyin: "Zhè bù xìjù shēnkè zhǎnxiàn le yì chǎng yóu wùhuì yǐnfā de jiātíng bēijù.",
    example_vi: "Vở kịch này đã thể hiện sâu sắc một bi kịch gia đình bắt nguồn từ sự hiểu lầm."
  },
  {
    id: 3632,
    hanzi: "悲伤",
    pinyin: "bēishāng",
    word_type: "Tính từ",
    meaning_vi: "đau buồn, bi thương",
    example_hanzi: "听到老朋友病逝的消息，他内心感到无比悲伤。",
    example_pinyin: "Tīng dào lǎo péngyou bìngshì de xiāoxi, tā nèixīn gǎndào wúbǐ bēishāng.",
    example_vi: "Khi nghe tin người bạn già qua đời vì bệnh, trong lòng anh ấy cảm thấy vô cùng đau buồn."
  },
  {
    id: 3633,
    hanzi: "北美洲",
    pinyin: "Běiměizhōu",
    word_type: "Danh từ riêng",
    meaning_vi: "Bắc Mỹ, châu Bắc Mỹ",
    example_hanzi: "许多跨国企业都在北美洲设立了研发中心和分支机构。",
    example_pinyin: "Xǔduō kuàguó qǐyè dōu zài Běiměizhōu shèlì le yánfā zhōngxīn hé fēnzhī jīgòu.",
    example_vi: "Nhiều doanh nghiệp xuyên quốc gia đều thành lập trung tâm nghiên cứu và chi nhánh tại Bắc Mỹ."
  },
  {
    id: 3634,
    hanzi: "被迫",
    pinyin: "bèipò",
    word_type: "Động từ",
    meaning_vi: "bị buộc, buộc phải",
    example_hanzi: "由于恶劣的暴雨天气，原定的露天航班被迫延误。",
    example_pinyin: "Yóuyú èliè de bàoyǔ tiānqì, yuándìng de lùtiān hángbān bèipò yánwù.",
    example_vi: "Do thời tiết mưa bão khắc nghiệt, chuyến bay dự kiến ban đầu đã buộc phải hoãn lại."
  },
  {
    id: 3635,
    hanzi: "背心",
    pinyin: "bèixīn",
    word_type: "Danh từ",
    meaning_vi: "áo ba lỗ, áo may ô, áo ghi-lê",
    example_hanzi: "夏天在户外跑步时，他通常喜欢穿一件轻便透气的运动背心。",
    example_pinyin: "Xiàtiān zài hùwài pǎobù shí, tā tōngcháng xǐhuan chuān yí jiàn qīngbiàn tòuqì de yùndòng bèixīn.",
    example_vi: "Vào mùa hè khi chạy bộ ngoài trời, anh ấy thường thích mặc một chiếc áo ba lỗ thể thao nhẹ nhàng thoáng khí."
  },
  {
    id: 3637,
    hanzi: "备用",
    pinyin: "bèiyòng",
    word_type: "Động từ / Tính từ",
    meaning_vi: "dự phòng, để dự trữ sử dụng",
    example_hanzi: "长途旅行之前，建议随身多带一块备用手机电池。",
    example_pinyin: "Chángtú lǚxíng zhīqián, jiànyì suíshēn duō dài yí kuài bèiyòng shǒujī diànchí.",
    example_vi: "Trước chuyến đi du lịch đường dài, nên mang theo bên mình thêm một viên pin điện thoại dự phòng."
  },
  {
    id: 3638,
    hanzi: "倍增",
    pinyin: "bèizēng",
    word_type: "Động từ",
    meaning_vi: "tăng gấp bội, tăng mạnh",
    example_hanzi: "有了团队成员的热情支持，让大家的工作信心倍增。",
    example_pinyin: "Yǒu le tuánduì chéngyuán de rèqíng zhīchí, ràng dàjiā de gōngzuò xìnxīn bèizēng.",
    example_vi: "Có được sự ủng hộ nhiệt tình của các thành viên trong nhóm, niềm tin vào công việc của mọi người đã tăng lên gấp bội."
  },
  {
    id: 3640,
    hanzi: "奔跑",
    pinyin: "bēnpǎo",
    word_type: "Động từ",
    meaning_vi: "chạy, sải bước chạy nhanh",
    example_hanzi: "孩子们在宽阔的绿茵草地上欢快地自由奔跑。",
    example_pinyin: "Háizimen zài kuānkuò de lùyīn cǎodì shang huānkuài de zìyóu bēnpǎo.",
    example_vi: "Lũ trẻ vui vẻ chạy nhảy tự do trên bãi cỏ xanh ngát rộng lớn."
  },
  {
    id: 3642,
    hanzi: "本土",
    pinyin: "běntǔ",
    word_type: "Danh từ / Tính từ",
    meaning_vi: "bản địa, trong nước, bản xứ",
    example_hanzi: "这家国际品牌在进入中国市场时非常重视本土化策略。",
    example_pinyin: "Zhè jiā guójì pǐnpái zài jìnrù Zhōngguó shìchǎng shí fēicháng zhòngshì běntǔhuà cèlüè.",
    example_vi: "Thương hiệu quốc tế này khi bước vào thị trường Trung Quốc rất coi trọng chiến lược bản địa hóa."
  },
  {
    id: 3644,
    hanzi: "逼",
    pinyin: "bī",
    word_type: "Động từ",
    meaning_vi: "ép buộc, dồn ép, thúc ép",
    example_hanzi: "父母不应当过分逼迫孩子去报过多的课外培训班。",
    example_pinyin: "Fùmǔ bù yīngdāng guòfèn bīpò háizi qù bào guòduō de kèwài péixùnbān.",
    example_vi: "Cha mẹ không nên ép buộc con cái quá mức để đăng ký quá nhiều lớp học thêm ngoại khóa."
  },
  {
    id: 3645,
    hanzi: "闭",
    pinyin: "bì",
    word_type: "Động từ",
    meaning_vi: "đóng, nhắm (mắt, cửa)",
    example_hanzi: "听音乐的时候，他喜欢闭上双眼静静感受旋律的起伏。",
    example_pinyin: "Tīng yīnyuè de shíhou, tā xǐhuan bì shang shuāngyǎn jìngjìng gǎnshòu xuánlǜ de qǐfú.",
    example_vi: "Khi nghe nhạc, anh ấy thích nhắm nghiền đôi mắt để tĩnh lặng cảm nhận sự thăng trầm của giai điệu."
  },
  {
    id: 3646,
    hanzi: "避",
    pinyin: "bì",
    word_type: "Động từ",
    meaning_vi: "tránh, né tránh, trú ẩn",
    example_hanzi: "遇到突如其来的雷暴雨时，千万不要站在大树下避雨。",
    example_pinyin: "Yù dào tūrúqílái de léibàoyǔ shí, qiānwàn bú yào zhàn zài dàshù xià bì yǔ.",
    example_vi: "Khi gặp cơn mưa dông bất ngờ, tuyệt đối không được đứng dưới gốc cây to để trú mưa."
  },
  {
    id: 3647,
    hanzi: "必修",
    pinyin: "bìxiū",
    word_type: "Động từ / Tính từ",
    meaning_vi: "bắt buộc học, môn học bắt buộc",
    example_hanzi: "高级汉语语法是本专业所有留学生的必修课程之一。",
    example_pinyin: "Gāojí Hànyǔ yǔfǎ shì běn zhuānyè suǒyǒu liúxuéshēng de bìxiū kèchéng zhīyī.",
    example_vi: "Ngữ pháp tiếng Trung cao cấp là một trong những môn học bắt buộc đối với tất cả lưu học sinh chuyên ngành này."
  },
  {
    id: 3649,
    hanzi: "编",
    pinyin: "biān",
    word_type: "Động từ",
    meaning_vi: "đan, tết; biên soạn, bịa chuyện",
    example_hanzi: "老奶奶用竹条编出来的竹篮既美观又结实耐用。",
    example_pinyin: "Lǎonǎinai yòng zhútiáo biān chūlái de zhúlán jì měiguān yòu jiēshi nàiyòng.",
    example_vi: "Chiếc giỏ tre do bà cụ đan bằng nan tre vừa đẹp mắt lại vừa chắc chắn và bền bỉ."
  },
  {
    id: 3650,
    hanzi: "编写",
    pinyin: "biānxiě",
    word_type: "Động từ",
    meaning_vi: "biên soạn, viết (sách, tài liệu, mã nguồn)",
    example_hanzi: "几位资深汉语教师历时两年编写了这套全新的实用教材。",
    example_pinyin: "Jǐ wèi zīshēn Hànyǔ jiàoshī lìshí liǎng nián biānxiě le zhè tào quánxīn de shíyòng jiàocái.",
    example_vi: "Một số giảng viên tiếng Trung giàu kinh nghiệm đã mất hai năm để biên soạn bộ giáo trình thực dụng hoàn toàn mới này."
  },
  {
    id: 3652,
    hanzi: "遍地",
    pinyin: "biàndì",
    word_type: "Phó từ / Danh từ",
    meaning_vi: "khắp nơi, đầy đất, đầy đồng",
    example_hanzi: "秋天到了，果园里遍地都是金黄成熟的果实。",
    example_pinyin: "Qiūtiān dào le, guǒyuán lǐ biàndì dōu shì jīnhuáng chéngshú de guǒshí.",
    example_vi: "Mùa thu đã đến, khắp nơi trong vườn cây ăn quả đều là những quả chín vàng ruộm."
  },
  {
    id: 3653,
    hanzi: "便捷",
    pinyin: "biànjié",
    word_type: "Tính từ",
    meaning_vi: "tiện lợi, nhanh chóng, thuận tiện",
    example_hanzi: "移动支付的快速普及让人们的日常消费变得更加便捷。",
    example_pinyin: "Yídòng zhīfù de kuàisù pǔjí ràng rénmen de rìcháng xiāofèi biàn de gèngjiā biànjié.",
    example_vi: "Sự phổ cập nhanh chóng của thanh toán di động khiến việc tiêu dùng hàng ngày của người dân trở nên thuận tiện hơn rất nhiều."
  },
  {
    id: 3654,
    hanzi: "兵",
    pinyin: "bīng",
    word_type: "Danh từ",
    meaning_vi: "binh lính, quân đội, chiến sĩ",
    example_hanzi: "经过严格的军事训练，新兵们的意志变得更加坚强。",
    example_pinyin: "Jīngguò yángé de jūnshì xùnliàn, xīnbīngmen de yìzhì biàn de gèngjiā jiānqiáng.",
    example_vi: "Trải qua quá trình huấn luyện quân sự nghiêm ngặt, ý chí của các tân binh đã trở nên kiên cường hơn."
  },
  {
    id: 3656,
    hanzi: "播",
    pinyin: "bō",
    word_type: "Động từ",
    meaning_vi: "phát sóng, truyền phát; gieo hạt",
    example_hanzi: "中央广播电台每晚七点都会准时播送新闻节目。",
    example_pinyin: "Zhōngyāng guǎngbō diàntái měi wǎn qī diǎn dōu huì zhǔnshí bōsòng xīnwén jiémù.",
    example_vi: "Đài phát thanh trung ương vào bảy giờ tối mỗi ngày đều phát sóng chương trình thời sự đúng giờ."
  },
  {
    id: 3658,
    hanzi: "不适",
    pinyin: "búshì",
    word_type: "Tính từ / Động từ",
    meaning_vi: "khó chịu, không khỏe, không thoải mái",
    example_hanzi: "如果服药后身体出现轻微不适，应当立即就医咨询。",
    example_pinyin: "Rúguǒ fúyào hòu shēntǐ chūxiàn qīngwēi búshì, yīngdāng lìjí jiùyī zīxún.",
    example_vi: "Nếu sau khi uống thuốc cơ thể xuất hiện triệu chứng khó chịu nhẹ, cần lập tức đi khám bác sĩ để tư vấn."
  },
  {
    id: 3660,
    hanzi: "不至于",
    pinyin: "búzhìyú",
    word_type: "Động từ / Liên từ",
    meaning_vi: "không đến mức, không đến nỗi",
    example_hanzi: "这只是一次小失误，事情还不至于严重到无法挽回的地步。",
    example_pinyin: "Zhè zhǐ shì yí cì xiǎo shīwù, shìqing hái búzhìyú yánzhòng dào wúfǎ wǎnhuí de dìbù.",
    example_vi: "Đây chỉ là một sai sót nhỏ, sự việc vẫn chưa đến mức nghiêm trọng tới mức không thể cứu vãn."
  },
  {
    id: 3661,
    hanzi: "补",
    pinyin: "bǔ",
    word_type: "Động từ",
    meaning_vi: "vá, bổ sung, bù đắp",
    example_hanzi: "请大家在提交报告前把漏掉的数据及时补上。",
    example_pinyin: "Qǐng dàjiā zài tíjiāo bàogào qián bǎ lòudiào de shùjù jíshí bǔ shang.",
    example_vi: "Xin mọi người trước khi nộp báo cáo hãy kịp thời bổ sung những số liệu bị bỏ sót."
  },
  {
    id: 3662,
    hanzi: "捕",
    pinyin: "bǔ",
    word_type: "Động từ",
    meaning_vi: "bắt, săn bắt, tóm bắt",
    example_hanzi: "渔民们一大早就出海捕鱼，直到傍晚才满载而归。",
    example_pinyin: "Yúmínmen yídàzǎo jiù chū hǎi bǔ yú, zhídào bàngwǎn cái mǎnzài-érguī.",
    example_vi: "Những người ngư dân vừa sáng sớm đã ra khơi đánh bắt cá, mãi đến chập tối mới chở đầy cá trở về."
  },
  {
    id: 3663,
    hanzi: "补课",
    pinyin: "bǔkè",
    word_type: "Động từ",
    meaning_vi: "học bù, dạy bù (tiết học bị lỡ)",
    example_hanzi: "由于上周生病请假，老师特意安排在周末为他补课。",
    example_pinyin: "Yóuyú shàng zhōu shēngbìng qǐngjià, lǎoshī tèyì ānpái zài zhōumò wèi tā bǔkè.",
    example_vi: "Do tuần trước bị ốm phải xin nghỉ, thầy giáo đã đặc biệt sắp xếp dạy bù cho cậu ấy vào cuối tuần."
  },
  {
    id: 3664,
    hanzi: "补习",
    pinyin: "bǔxí",
    word_type: "Động từ / Danh từ",
    meaning_vi: "bổ túc, phụ đạo, học thêm",
    example_hanzi: "为了顺利通过毕业考试，他每天晚上都去补习数学。",
    example_pinyin: "Wèile shùnlì tōngguò bìyè kǎoshì, tā měitiān wǎnshang dōu qù bǔxí shùxué.",
    example_vi: "Để thuận lợi vượt qua kỳ thi tốt nghiệp, mỗi tối cậu ấy đều đi học thêm môn toán."
  },
  {
    id: 3666,
    hanzi: "不曾",
    pinyin: "bùcéng",
    word_type: "Phó từ",
    meaning_vi: "chưa từng, chưa bao giờ",
    example_hanzi: "离开故乡三十多年，他心中却不曾忘记家乡的一草一木。",
    example_pinyin: "Líkāi gùxiāng sānshí duō nián, tā xīnzhōng què bùcéng wàngjì jiāxiāng de yì cǎo yí mù.",
    example_vi: "Rời xa quê hương hơn ba mươi năm, nhưng trong lòng ông chưa từng quên một nhành cây ngọn cỏ nơi quê nhà."
  },
  {
    id: 3667,
    hanzi: "不成",
    pinyin: "bùchéng",
    word_type: "Động từ / Trợ từ",
    meaning_vi: "không thành; chẳng lẽ... hay sao",
    example_hanzi: "难道因为遇到一点点挫折，我们就要放弃梦想不成？",
    example_pinyin: "Nándào yīnwèi yù dào yìdiǎndiǎn cuòzhé, wǒmen jiù yào fàngqì mèngxiǎng bùchéng?",
    example_vi: "Chẳng lẽ chỉ vì gặp một chút trắc trở mà chúng ta lại từ bỏ ước mơ hay sao?"
  },
  {
    id: 3668,
    hanzi: "不得",
    pinyin: "bùdé",
    word_type: "Động từ",
    meaning_vi: "không được phép, không thể",
    example_hanzi: "实验室属于高度机密区域，未经许可任何人不得入内。",
    example_pinyin: "Shíyànshì shǔyú gāodù jīmì qūyù, wèijīng xǔkě rènhé rén bùdé rùnèi.",
    example_vi: "Phòng thí nghiệm là khu vực tuyệt mật, khi chưa có sự cho phép thì bất kỳ ai cũng không được phép vào trong."
  },
  {
    id: 3669,
    hanzi: "部队",
    pinyin: "bùduì",
    word_type: "Danh từ",
    meaning_vi: "quân đội, đơn vị bộ đội",
    example_hanzi: "年轻人在部队服役期间培养了极强的纪律性和责任感。",
    example_pinyin: "Niánqīngrén zài bùduì fúyì qījiān péiyǎng le jí qiáng de jìlùxìng hé zérèngǎn.",
    example_vi: "Thanh niên trong thời gian phục vụ quân ngũ đã rèn luyện được tính kỷ luật và tinh thần trách nhiệm cực kỳ cao."
  },
  {
    id: 3672,
    hanzi: "不许",
    pinyin: "bùxǔ",
    word_type: "Động từ",
    meaning_vi: "không cho phép, không được",
    example_hanzi: "考场内严格规定考生不许携带任何电子通讯设备。",
    example_pinyin: "Kǎochǎng nèi yángé guīdìng kǎoshēng bùxǔ xiédài rènhé diànzǐ tōngxùn shèbèi.",
    example_vi: "Trong phòng thi có quy định nghiêm ngặt thí sinh không được mang theo bất kỳ thiết bị thông tin điện tử nào."
  },
  {
    id: 3674,
    hanzi: "不宜",
    pinyin: "bùyí",
    word_type: "Tính từ",
    meaning_vi: "không thích hợp, không nên",
    example_hanzi: "患有心脏病的患者平时不宜进行过于剧烈的体育运动。",
    example_pinyin: "Huàn yǒu xīnzàngbìng de huànzhě píngshí bùyí jìnxíng guòyú jùliè de tǐyù yùndòng.",
    example_vi: "Những bệnh nhân mắc bệnh tim thông thường không nên tham gia các hoạt động thể thao quá mức kịch liệt."
  },
  {
    id: 3675,
    hanzi: "不已",
    pinyin: "bùyǐ",
    word_type: "Động từ / Phó từ",
    meaning_vi: "không thôi, không ngớt, mãi không dứt",
    example_hanzi: "得知中国队在奥运会上再次夺金，全场观众兴奋不已。",
    example_pinyin: "Dézhī Zhōngguóduì zài Àoyùnhuì shang zàicì duó jīn, quánchǎng guānzhòng xīngfèn bùyǐ.",
    example_vi: "Khi biết tin đội tuyển Trung Quốc một lần nữa đoạt huy chương vàng tại Thế vận hội, toàn thể khán giả hưng phấn không thôi."
  },
  {
    id: 3677,
    hanzi: "猜测",
    pinyin: "cāicè",
    word_type: "Động từ / Danh từ",
    meaning_vi: "phỏng đoán, suy đoán",
    example_hanzi: "在没有确凿事实依据之前，大家不要随意主观猜测。",
    example_pinyin: "Zài méiyǒu quèzáo shìshí yījù zhīqián, dàjiā bú yào suíyì zhǔguān cāicè.",
    example_vi: "Trước khi có căn cứ sự thật xác thực, mọi người không nên tùy tiện suy đoán chủ quan."
  },
  {
    id: 3678,
    hanzi: "才华",
    pinyin: "cáihuá",
    word_type: "Danh từ",
    meaning_vi: "tài hoa, tài năng nổi trội",
    example_hanzi: "这位年轻画家的艺术才华受到了业内专家的高度赞赏。",
    example_pinyin: "Zhè wèi niánqīng huàjiā de yìshù cáihuá shòudào le yènèi zhuānjiā de gāodù zànshǎng.",
    example_vi: "Tài hoa nghệ thuật của họa sĩ trẻ này đã nhận được sự tán thưởng rất cao từ các chuyên gia trong ngành."
  },
  {
    id: 3679,
    hanzi: "才能",
    pinyin: "cáinéng",
    word_type: "Danh từ",
    meaning_vi: "tài năng, năng lực",
    example_hanzi: "良好的公司管理制度能够充分激发每一位员工的潜在才能。",
    example_pinyin: "Liánghǎo de gōngsī guǎnlǐ zhìdù nénggòu chōngfèn jīfā měi yí wèi yuángōng de qiánzài cáinéng.",
    example_vi: "Chế độ quản lý công ty tốt có thể khơi dậy trọn vẹn tài năng tiềm ẩn của mỗi một nhân viên."
  },
  {
    id: 3680,
    hanzi: "财物",
    pinyin: "cáiwù",
    word_type: "Danh từ",
    meaning_vi: "tài sản, của cải",
    example_hanzi: "在公共场所游玩时，请大家务必妥善保管好个人随身财物。",
    example_pinyin: "Zài gōnggòng chǎngsuǒ yóuwán shí, qǐng dàjiā wùbì tuǒshàn bǎoguǎn hǎo gèrén suíshēn cáiwù.",
    example_vi: "Khi vui chơi ở nơi công cộng, xin mọi người nhất định phải bảo quản chu đáo tài sản mang theo bên mình."
  },
  {
    id: 3681,
    hanzi: "材质",
    pinyin: "cáizhì",
    word_type: "Danh từ",
    meaning_vi: "chất liệu, vật liệu chế tạo",
    example_hanzi: "这款高档办公桌采用纯天然实木材质，手感温润厚重。",
    example_pinyin: "Zhè kuǎn gāodàng bàngōngzhuō cǎiyòng chún tiānrán shímù cáizhì, shǒugǎn wēnrùn hòuzhòng.",
    example_vi: "Mẫu bàn làm việc cao cấp này sử dụng chất liệu gỗ tự nhiên nguyên khối, sờ vào cảm thấy mịn màng và đầm tay."
  },
  {
    id: 3682,
    hanzi: "参展",
    pinyin: "cānzhǎn",
    word_type: "Động từ",
    meaning_vi: "tham gia triển lãm",
    example_hanzi: "今年将有来自全球五十多个国家的三千家企业报名参展。",
    example_pinyin: "Jīnnián jiāng yǒu láizì quánqiú wǔshí duō gè guójiā de sānqiān jiā qǐyè bàomíng cānzhǎn.",
    example_vi: "Năm nay sẽ có ba nghìn doanh nghiệp đến từ hơn năm mươi quốc gia trên toàn cầu đăng ký tham gia triển lãm."
  }
];

console.log("Đã tải xong mẫu dữ liệu ban đầu cho Batch 1:", BATCH_1_DATA.length);
fs.writeFileSync('scratch/hsk6_batch1_sample.json', JSON.stringify(BATCH_1_DATA, null, 2));
