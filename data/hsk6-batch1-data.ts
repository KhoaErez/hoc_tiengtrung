// ==============================================================================
// DANH MỤC TỪ MỚI HSK 6 (ĐỀ CƯƠNG THI HSK 3.0 CHÍNH THỨC - CTI 11/2025)
// BATCH 1: 100 TỪ ĐẦU TIÊN (TỪ MỤC 3606 ĐẾN 3738)
// Mỗi từ vựng gồm: Chữ Hán, Pinyin có dấu, Loại từ, Nghĩa tiếng Việt,
// và câu ví dụ chuẩn dùng chung cho chức năng Luyện đánh máy (/typing)
// ==============================================================================

export interface Hsk6WordItem {
  id: number
  hanzi: string
  pinyin: string
  word_type: string
  meaning_vi: string
  example_hanzi: string
  example_pinyin: string
  example_vi: string
}

export const HSK6_BATCH1_DATA: Hsk6WordItem[] = [
  {
    "id": 3606,
    "hanzi": "白白",
    "pinyin": "báibái",
    "word_type": "Phó từ",
    "meaning_vi": "uổng công, vô ích, lãng phí",
    "example_hanzi": "如果不早点出发，前期的准备工作就白白浪费了。",
    "example_pinyin": "Rúguǒ bù zǎodiǎn chūfā, qiánqī de zhǔnbèi gōngzuò jiù báibái làngfèi le.",
    "example_vi": "Nếu không xuất phát sớm hơn, công sức chuẩn bị giai đoạn đầu sẽ bị lãng phí uổng công."
  },
  {
    "id": 3607,
    "hanzi": "白领",
    "pinyin": "báilǐng",
    "word_type": "Danh từ",
    "meaning_vi": "nhân viên văn phòng, giới cổ cồn trắng",
    "example_hanzi": "许多在大城市工作的年轻白领平时工作压力很大。",
    "example_pinyin": "Xǔduō zài dà chéngshì gōngzuò de niánqīng báilǐng píngshí gōngzuò yālì hěn dà.",
    "example_vi": "Nhiều nhân viên văn phòng trẻ tuổi làm việc ở thành phố lớn thường ngày chịu áp lực công việc rất lớn."
  },
  {
    "id": 3610,
    "hanzi": "百分点",
    "pinyin": "bǎifēndiǎn",
    "word_type": "Danh từ",
    "meaning_vi": "điểm phần trăm",
    "example_hanzi": "今年第一季度该公司的营业额比去年同期增长了三个百分点。",
    "example_pinyin": "Jīnnián dì-yī jìdù gāi gōngsī de yíngyè’é bǐ qùnián tóngqī zēngzhǎng le sān gè bǎifēndiǎn.",
    "example_vi": "Quý đầu năm nay doanh thu của công ty này đã tăng ba điểm phần trăm so với cùng kỳ năm ngoái."
  },
  {
    "id": 3611,
    "hanzi": "百货",
    "pinyin": "bǎihuò",
    "word_type": "Danh từ",
    "meaning_vi": "hàng bách hóa, hàng tạp hóa",
    "example_hanzi": "市中心新开了一家大型百货商场，商品种类非常齐全。",
    "example_pinyin": "Shì zhōngxīn xīn kāi le yì jiā dàxíng bǎihuò shāngchǎng, shāngpǐn zhǒnglèi fēicháng qíquán.",
    "example_vi": "Ở trung tâm thành phố mới mở một trung tâm thương mại bách hóa lớn, chủng loại hàng hóa vô cùng đầy đủ."
  },
  {
    "id": 3613,
    "hanzi": "败",
    "pinyin": "bài",
    "word_type": "Động từ",
    "meaning_vi": "thua, thất bại, bại trận",
    "example_hanzi": "在最后的决赛中，主队以微弱的分数差遗憾败给了对手。",
    "example_pinyin": "Zài zuìhòu de juésài zhōng, zhǔduì yǐ wēiruò de fēnshù chā yíhàn bài gěi le duìshǒu.",
    "example_vi": "Trong trận chung kết cuối cùng, đội chủ nhà đã tiếc nuối để thua đối thủ với cách biệt điểm số sít sao."
  },
  {
    "id": 3616,
    "hanzi": "版",
    "pinyin": "bǎn",
    "word_type": "Danh từ / Lượng từ",
    "meaning_vi": "bản, phiên bản; trang báo",
    "example_hanzi": "这部经典词典的最新修订版增补了大量现代科技词汇。",
    "example_pinyin": "Zhè bù jīngdiǎn cídiǎn de zuìxīn xiūdìngbǎn zēngbǔ le dàliàng xiàndài kējì cíhuì.",
    "example_vi": "Phiên bản sửa đổi mới nhất của cuốn từ điển kinh điển này đã bổ sung rất nhiều từ vựng công nghệ hiện đại."
  },
  {
    "id": 3621,
    "hanzi": "棒球",
    "pinyin": "bàngqiú",
    "word_type": "Danh từ",
    "meaning_vi": "môn bóng chày; quả bóng chày",
    "example_hanzi": "学校棒球队在今年的全国大学生运动会上夺得了冠军。",
    "example_pinyin": "Xuéxiào bàngqiúduì zài jīnnián de quánguó dàxuéshēng yùndònghuì shang duódé le guànjūn.",
    "example_vi": "Đội bóng chày của trường đã đoạt chức vô địch tại Đại hội Thể thao Sinh viên Toàn quốc năm nay."
  },
  {
    "id": 3623,
    "hanzi": "保健",
    "pinyin": "bǎojiàn",
    "word_type": "Động từ / Danh từ",
    "meaning_vi": "chăm sóc sức khỏe, bảo vệ sức khỏe",
    "example_hanzi": "老年人应当根据医生的科学建议选择合适的保健方法。",
    "example_pinyin": "Lǎoniánrén yīngdāng gēnjù yīshēng de kēxué jiànyì xuǎnzé héshì de bǎojiàn fāngfǎ.",
    "example_vi": "Người cao tuổi nên lựa chọn phương pháp chăm sóc sức khỏe phù hợp dựa trên lời khuyên khoa học của bác sĩ."
  },
  {
    "id": 3624,
    "hanzi": "保暖",
    "pinyin": "bǎonuǎn",
    "word_type": "Động từ / Tính từ",
    "meaning_vi": "giữ ấm, giữ nhiệt",
    "example_hanzi": "冬天出门前一定要穿好保暖外套，避免感冒。",
    "example_pinyin": "Dōngtiān chūmén qián yídìng yào chuān hǎo bǎonuǎn wàitào, bìmiǎn gǎnmào.",
    "example_vi": "Mùa đông trước khi ra khỏi nhà nhất định phải mặc áo khoác giữ ấm cẩn thận để tránh bị cảm lạnh."
  },
  {
    "id": 3625,
    "hanzi": "保修",
    "pinyin": "bǎoxiū",
    "word_type": "Động từ",
    "meaning_vi": "bảo hành (thiết bị, máy móc)",
    "example_hanzi": "这台笔记本电脑享受全国联保服务，保修期为三年。",
    "example_pinyin": "Zhè tái bǐjìběn diànnǎo xiǎngshòu quánguó liánbǎo fúwù, bǎoxiūqī wéi sān nián.",
    "example_vi": "Chiếc máy tính xách tay này được hưởng dịch vụ bảo hành toàn quốc với thời hạn bảo hành là ba năm."
  },
  {
    "id": 3627,
    "hanzi": "爆",
    "pinyin": "bào",
    "word_type": "Động từ / Tính từ",
    "meaning_vi": "nổ, vỡ tung; bùng nổ, đông nghẹt",
    "example_hanzi": "这条突发科技新闻发布后，网络平台的阅读量瞬间爆满。",
    "example_pinyin": "Zhè tiáo tūfā kējì xīnwén fābù hòu, wǎngluò píngtái de yuèdúliàng shùnjiān bàomǎn.",
    "example_vi": "Sau khi tin tức công nghệ đột xuất này được đăng tải, lượng đọc trên nền tảng mạng xã hội ngay lập tức bùng nổ."
  },
  {
    "id": 3629,
    "hanzi": "报刊",
    "pinyin": "bàokān",
    "word_type": "Danh từ",
    "meaning_vi": "báo chí, báo và tạp chí",
    "example_hanzi": "即使在数字化时代，依然有不少读者坚持阅读纸质报刊。",
    "example_pinyin": "Jíshǐ zài shùzìhuà shídài, yīrán yǒu bù shǎo dúzhě jiānchí yuèdú zhǐzhì bàokān.",
    "example_vi": "Ngay cả trong thời đại số hóa, vẫn có không ít độc giả kiên trì đọc báo và tạp chí giấy."
  },
  {
    "id": 3631,
    "hanzi": "悲剧",
    "pinyin": "bēijù",
    "word_type": "Danh từ",
    "meaning_vi": "bi kịch, câu chuyện đau thương",
    "example_hanzi": "这部戏剧深刻展现了一场由误会引发的家庭悲剧。",
    "example_pinyin": "Zhè bù xìjù shēnkè zhǎnxiàn le yì chǎng yóu wùhuì yǐnfā de jiātíng bēijù.",
    "example_vi": "Vở kịch này đã thể hiện sâu sắc một bi kịch gia đình bắt nguồn từ sự hiểu lầm."
  },
  {
    "id": 3632,
    "hanzi": "悲伤",
    "pinyin": "bēishāng",
    "word_type": "Tính từ",
    "meaning_vi": "đau buồn, bi thương",
    "example_hanzi": "听到老朋友病逝的消息，他内心感到无比悲伤。",
    "example_pinyin": "Tīng dào lǎo péngyou bìngshì de xiāoxi, tā nèixīn gǎndào wúbǐ bēishāng.",
    "example_vi": "Khi nghe tin người bạn già qua đời vì bệnh, trong lòng anh ấy cảm thấy vô cùng đau buồn."
  },
  {
    "id": 3633,
    "hanzi": "北美洲",
    "pinyin": "Běiměizhōu",
    "word_type": "Danh từ riêng",
    "meaning_vi": "Bắc Mỹ, châu Bắc Mỹ",
    "example_hanzi": "许多跨国企业都在北美洲设立了研发中心和分支机构。",
    "example_pinyin": "Xǔduō kuàguó qǐyè dōu zài Běiměizhōu shèlì le yánfā zhōngxīn hé fēnzhī jīgòu.",
    "example_vi": "Nhiều doanh nghiệp xuyên quốc gia đều thành lập trung tâm nghiên cứu và chi nhánh tại Bắc Mỹ."
  },
  {
    "id": 3634,
    "hanzi": "被迫",
    "pinyin": "bèipò",
    "word_type": "Động từ",
    "meaning_vi": "bị buộc, buộc phải",
    "example_hanzi": "由于恶劣的暴雨天气，原定的露天航班被迫延误。",
    "example_pinyin": "Yóuyú èliè de bàoyǔ tiānqì, yuándìng de lùtiān hángbān bèipò yánwù.",
    "example_vi": "Do thời tiết mưa bão khắc nghiệt, chuyến bay dự kiến ban đầu đã buộc phải hoãn lại."
  },
  {
    "id": 3635,
    "hanzi": "背心",
    "pinyin": "bèixīn",
    "word_type": "Danh từ",
    "meaning_vi": "áo ba lỗ, áo may ô, áo ghi-lê",
    "example_hanzi": "夏天在户外跑步时，他通常喜欢穿一件轻便透气的运动背心。",
    "example_pinyin": "Xiàtiān zài hùwài pǎobù shí, tā tōngcháng xǐhuan chuān yí jiàn qīngbiàn tòuqì de yùndòng bèixīn.",
    "example_vi": "Vào mùa hè khi chạy bộ ngoài trời, anh ấy thường thích mặc một chiếc áo ba lỗ thể thao nhẹ nhàng thoáng khí."
  },
  {
    "id": 3637,
    "hanzi": "备用",
    "pinyin": "bèiyòng",
    "word_type": "Động từ / Tính từ",
    "meaning_vi": "dự phòng, để dự trữ sử dụng",
    "example_hanzi": "长途旅行之前，建议随身多带一块备用手机电池。",
    "example_pinyin": "Chángtú lǚxíng zhīqián, jiànyì suíshēn duō dài yí kuài bèiyòng shǒujī diànchí.",
    "example_vi": "Trước chuyến đi du lịch đường dài, nên mang theo bên mình thêm một viên pin điện thoại dự phòng."
  },
  {
    "id": 3638,
    "hanzi": "倍增",
    "pinyin": "bèizēng",
    "word_type": "Động từ",
    "meaning_vi": "tăng gấp bội, tăng mạnh",
    "example_hanzi": "有了团队成员的热情支持，让大家的工作信心倍增。",
    "example_pinyin": "Yǒu le tuánduì chéngyuán de rèqíng zhīchí, ràng dàjiā de gōngzuò xìnxīn bèizēng.",
    "example_vi": "Có được sự ủng hộ nhiệt tình của các thành viên trong nhóm, niềm tin vào công việc của mọi người đã tăng lên gấp bội."
  },
  {
    "id": 3640,
    "hanzi": "奔跑",
    "pinyin": "bēnpǎo",
    "word_type": "Động từ",
    "meaning_vi": "chạy, sải bước chạy nhanh",
    "example_hanzi": "孩子们在宽阔的绿茵草地上欢快地自由奔跑。",
    "example_pinyin": "Háizimen zài kuānkuò de lùyīn cǎodì shang huānkuài de zìyóu bēnpǎo.",
    "example_vi": "Lũ trẻ vui vẻ chạy nhảy tự do trên bãi cỏ xanh ngát rộng lớn."
  },
  {
    "id": 3642,
    "hanzi": "本土",
    "pinyin": "běntǔ",
    "word_type": "Danh từ / Tính từ",
    "meaning_vi": "bản địa, trong nước, bản xứ",
    "example_hanzi": "这家国际品牌在进入中国市场时非常重视本土化策略。",
    "example_pinyin": "Zhè jiā guójì pǐnpái zài jìnrù Zhōngguó shìchǎng shí fēicháng zhòngshì běntǔhuà cèlüè.",
    "example_vi": "Thương hiệu quốc tế này khi bước vào thị trường Trung Quốc rất coi trọng chiến lược bản địa hóa."
  },
  {
    "id": 3644,
    "hanzi": "逼",
    "pinyin": "bī",
    "word_type": "Động từ",
    "meaning_vi": "ép buộc, dồn ép, thúc ép",
    "example_hanzi": "父母不应当过分逼迫孩子去报过多的课外培训班。",
    "example_pinyin": "Fùmǔ bù yīngdāng guòfèn bīpò háizi qù bào guòduō de kèwài péixùnbān.",
    "example_vi": "Cha mẹ không nên ép buộc con cái quá mức để đăng ký quá nhiều lớp học thêm ngoại khóa."
  },
  {
    "id": 3645,
    "hanzi": "闭",
    "pinyin": "bì",
    "word_type": "Động từ",
    "meaning_vi": "đóng, nhắm (mắt, cửa)",
    "example_hanzi": "听音乐的时候，他喜欢闭上双眼静静感受旋律的起伏。",
    "example_pinyin": "Tīng yīnyuè de shíhou, tā xǐhuan bì shang shuāngyǎn jìngjìng gǎnshòu xuánlǜ de qǐfú.",
    "example_vi": "Khi nghe nhạc, anh ấy thích nhắm nghiền đôi mắt để tĩnh lặng cảm nhận sự thăng trầm của giai điệu."
  },
  {
    "id": 3646,
    "hanzi": "避",
    "pinyin": "bì",
    "word_type": "Động từ",
    "meaning_vi": "tránh, né tránh, trú ẩn",
    "example_hanzi": "遇到突如其来的雷暴雨时，千万不要站在大树下避雨。",
    "example_pinyin": "Yù dào tūrúqílái de léibàoyǔ shí, qiānwàn bú yào zhàn zài dàshù xià bì yǔ.",
    "example_vi": "Khi gặp cơn mưa dông bất ngờ, tuyệt đối không được đứng dưới gốc cây to để trú mưa."
  },
  {
    "id": 3647,
    "hanzi": "必修",
    "pinyin": "bìxiū",
    "word_type": "Động từ / Tính từ",
    "meaning_vi": "bắt buộc học, môn học bắt buộc",
    "example_hanzi": "高级汉语语法是本专业所有留学生的必修课程之一。",
    "example_pinyin": "Gāojí Hànyǔ yǔfǎ shì běn zhuānyè suǒyǒu liúxuéshēng de bìxiū kèchéng zhīyī.",
    "example_vi": "Ngữ pháp tiếng Trung cao cấp là một trong những môn học bắt buộc đối với tất cả lưu học sinh chuyên ngành này."
  },
  {
    "id": 3649,
    "hanzi": "编",
    "pinyin": "biān",
    "word_type": "Động từ",
    "meaning_vi": "đan, tết; biên soạn, bịa chuyện",
    "example_hanzi": "老奶奶用竹条编出来的竹篮既美观又结实耐用。",
    "example_pinyin": "Lǎonǎinai yòng zhútiáo biān chūlái de zhúlán jì měiguān yòu jiēshi nàiyòng.",
    "example_vi": "Chiếc giỏ tre do bà cụ đan bằng nan tre vừa đẹp mắt lại vừa chắc chắn và bền bỉ."
  },
  {
    "id": 3650,
    "hanzi": "编写",
    "pinyin": "biānxiě",
    "word_type": "Động từ",
    "meaning_vi": "biên soạn, viết (sách, tài liệu, mã nguồn)",
    "example_hanzi": "几位资深汉语教师历时两年编写了这套全新的实用教材。",
    "example_pinyin": "Jǐ wèi zīshēn Hànyǔ jiàoshī lìshí liǎng nián biānxiě le zhè tào quánxīn de shíyòng jiàocái.",
    "example_vi": "Một số giảng viên tiếng Trung giàu kinh nghiệm đã mất hai năm để biên soạn bộ giáo trình thực dụng hoàn toàn mới này."
  },
  {
    "id": 3652,
    "hanzi": "遍地",
    "pinyin": "biàndì",
    "word_type": "Phó từ / Danh từ",
    "meaning_vi": "khắp nơi, đầy đất, đầy đồng",
    "example_hanzi": "秋天到了，果园里遍地都是金黄成熟的果实。",
    "example_pinyin": "Qiūtiān dào le, guǒyuán lǐ biàndì dōu shì jīnhuáng chéngshú de guǒshí.",
    "example_vi": "Mùa thu đã đến, khắp nơi trong vườn cây ăn quả đều là những quả chín vàng ruộm."
  },
  {
    "id": 3653,
    "hanzi": "便捷",
    "pinyin": "biànjié",
    "word_type": "Tính từ",
    "meaning_vi": "tiện lợi, nhanh chóng, thuận tiện",
    "example_hanzi": "移动支付的快速普及让人们的日常消费变得更加便捷。",
    "example_pinyin": "Yídòng zhīfù de kuàisù pǔjí ràng rénmen de rìcháng xiāofèi biàn de gèngjiā biànjié.",
    "example_vi": "Sự phổ cập nhanh chóng của thanh toán di động khiến việc tiêu dùng hàng ngày của người dân trở nên thuận tiện hơn rất nhiều."
  },
  {
    "id": 3654,
    "hanzi": "兵",
    "pinyin": "bīng",
    "word_type": "Danh từ",
    "meaning_vi": "binh lính, quân đội, chiến sĩ",
    "example_hanzi": "经过严格的军事训练，新兵们的意志变得更加坚强。",
    "example_pinyin": "Jīngguò yángé de jūnshì xùnliàn, xīnbīngmen de yìzhì biàn de gèngjiā jiānqiáng.",
    "example_vi": "Trải qua quá trình huấn luyện quân sự nghiêm ngặt, ý chí của các tân binh đã trở nên kiên cường hơn."
  },
  {
    "id": 3656,
    "hanzi": "播",
    "pinyin": "bō",
    "word_type": "Động từ",
    "meaning_vi": "phát sóng, truyền phát; gieo hạt",
    "example_hanzi": "中央广播电台每晚七点都会准时播送新闻节目。",
    "example_pinyin": "Zhōngyāng guǎngbō diàntái měi wǎn qī diǎn dōu huì zhǔnshí bōsòng xīnwén jiémù.",
    "example_vi": "Đài phát thanh trung ương vào bảy giờ tối mỗi ngày đều phát sóng chương trình thời sự đúng giờ."
  },
  {
    "id": 3658,
    "hanzi": "不适",
    "pinyin": "búshì",
    "word_type": "Tính từ / Động từ",
    "meaning_vi": "khó chịu, không khỏe, không thoải mái",
    "example_hanzi": "如果服药后身体出现轻微不适，应当立即就医咨询。",
    "example_pinyin": "Rúguǒ fúyào hòu shēntǐ chūxiàn qīngwēi búshì, yīngdāng lìjí jiùyī zīxún.",
    "example_vi": "Nếu sau khi uống thuốc cơ thể xuất hiện triệu chứng khó chịu nhẹ, cần lập tức đi khám bác sĩ để tư vấn."
  },
  {
    "id": 3660,
    "hanzi": "不至于",
    "pinyin": "búzhìyú",
    "word_type": "Động từ / Liên từ",
    "meaning_vi": "không đến mức, không đến nỗi",
    "example_hanzi": "这只是一次小失误，事情还不至于严重到无法挽回的地步。",
    "example_pinyin": "Zhè zhǐ shì yí cì xiǎo shīwù, shìqing hái búzhìyú yánzhòng dào wúfǎ wǎnhuí de dìbù.",
    "example_vi": "Đây chỉ là một sai sót nhỏ, sự việc vẫn chưa đến mức nghiêm trọng tới mức không thể cứu vãn."
  },
  {
    "id": 3661,
    "hanzi": "补",
    "pinyin": "bǔ",
    "word_type": "Động từ",
    "meaning_vi": "vá, bổ sung, bù đắp",
    "example_hanzi": "请大家在提交报告前把漏掉的数据及时补上。",
    "example_pinyin": "Qǐng dàjiā zài tíjiāo bàogào qián bǎ lòudiào de shùjù jíshí bǔ shang.",
    "example_vi": "Xin mọi người trước khi nộp báo cáo hãy kịp thời bổ sung những số liệu bị bỏ sót."
  },
  {
    "id": 3662,
    "hanzi": "捕",
    "pinyin": "bǔ",
    "word_type": "Động từ",
    "meaning_vi": "bắt, săn bắt, tóm bắt",
    "example_hanzi": "渔民们一大早就出海捕鱼，直到傍晚才满载而归。",
    "example_pinyin": "Yúmínmen yídàzǎo jiù chū hǎi bǔ yú, zhídào bàngwǎn cái mǎnzài-érguī.",
    "example_vi": "Những người ngư dân vừa sáng sớm đã ra khơi đánh bắt cá, mãi đến chập tối mới chở đầy cá trở về."
  },
  {
    "id": 3663,
    "hanzi": "补课",
    "pinyin": "bǔkè",
    "word_type": "Động từ",
    "meaning_vi": "học bù, dạy bù (tiết học bị lỡ)",
    "example_hanzi": "由于上周生病请假，老师特意安排在周末为他补课。",
    "example_pinyin": "Yóuyú shàng zhōu shēngbìng qǐngjià, lǎoshī tèyì ānpái zài zhōumò wèi tā bǔkè.",
    "example_vi": "Do tuần trước bị ốm phải xin nghỉ, thầy giáo đã đặc biệt sắp xếp dạy bù cho cậu ấy vào cuối tuần."
  },
  {
    "id": 3664,
    "hanzi": "补习",
    "pinyin": "bǔxí",
    "word_type": "Động từ / Danh từ",
    "meaning_vi": "bổ túc, phụ đạo, học thêm",
    "example_hanzi": "为了顺利通过毕业考试，他每天晚上都去补习数学。",
    "example_pinyin": "Wèile shùnlì tōngguò bìyè kǎoshì, tā měitiān wǎnshang dōu qù bǔxí shùxué.",
    "example_vi": "Để thuận lợi vượt qua kỳ thi tốt nghiệp, mỗi tối cậu ấy đều đi học thêm môn toán."
  },
  {
    "id": 3666,
    "hanzi": "不曾",
    "pinyin": "bùcéng",
    "word_type": "Phó từ",
    "meaning_vi": "chưa từng, chưa bao giờ",
    "example_hanzi": "离开故乡三十多年，他心中却不曾忘记家乡的一草一木。",
    "example_pinyin": "Líkāi gùxiāng sānshí duō nián, tā xīnzhōng què bùcéng wàngjì jiāxiāng de yì cǎo yí mù.",
    "example_vi": "Rời xa quê hương hơn ba mươi năm, nhưng trong lòng ông chưa từng quên một nhành cây ngọn cỏ nơi quê nhà."
  },
  {
    "id": 3667,
    "hanzi": "不成",
    "pinyin": "bùchéng",
    "word_type": "Động từ / Trợ từ",
    "meaning_vi": "không thành; chẳng lẽ... hay sao",
    "example_hanzi": "难道因为遇到一点点挫折，我们就要放弃梦想不成？",
    "example_pinyin": "Nándào yīnwèi yù dào yìdiǎndiǎn cuòzhé, wǒmen jiù yào fàngqì mèngxiǎng bùchéng?",
    "example_vi": "Chẳng lẽ chỉ vì gặp một chút trắc trở mà chúng ta lại từ bỏ ước mơ hay sao?"
  },
  {
    "id": 3668,
    "hanzi": "不得",
    "pinyin": "bùdé",
    "word_type": "Động từ",
    "meaning_vi": "không được phép, không thể",
    "example_hanzi": "实验室属于高度机密区域，未经许可任何人不得入内。",
    "example_pinyin": "Shíyànshì shǔyú gāodù jīmì qūyù, wèijīng xǔkě rènhé rén bùdé rùnèi.",
    "example_vi": "Phòng thí nghiệm là khu vực tuyệt mật, khi chưa có sự cho phép thì bất kỳ ai cũng không được phép vào trong."
  },
  {
    "id": 3669,
    "hanzi": "部队",
    "pinyin": "bùduì",
    "word_type": "Danh từ",
    "meaning_vi": "quân đội, đơn vị bộ đội",
    "example_hanzi": "年轻人在部队服役期间培养了极强的纪律性和责任感。",
    "example_pinyin": "Niánqīngrén zài bùduì fúyì qījiān péiyǎng le jí qiáng de jìlùxìng hé zérèngǎn.",
    "example_vi": "Thanh niên trong thời gian phục vụ quân ngũ đã rèn luyện được tính kỷ luật và tinh thần trách nhiệm cực kỳ cao."
  },
  {
    "id": 3672,
    "hanzi": "不许",
    "pinyin": "bùxǔ",
    "word_type": "Động từ",
    "meaning_vi": "không cho phép, không được",
    "example_hanzi": "考场内严格规定考生不许携带任何电子通讯设备。",
    "example_pinyin": "Kǎochǎng nèi yángé guīdìng kǎoshēng bùxǔ xiédài rènhé diànzǐ tōngxùn shèbèi.",
    "example_vi": "Trong phòng thi có quy định nghiêm ngặt thí sinh không được mang theo bất kỳ thiết bị thông tin điện tử nào."
  },
  {
    "id": 3674,
    "hanzi": "不宜",
    "pinyin": "bùyí",
    "word_type": "Tính từ",
    "meaning_vi": "không thích hợp, không nên",
    "example_hanzi": "患有心脏病的患者平时不宜进行过于剧烈的体育运动。",
    "example_pinyin": "Huàn yǒu xīnzàngbìng de huànzhě píngshí bùyí jìnxíng guòyú jùliè de tǐyù yùndòng.",
    "example_vi": "Những bệnh nhân mắc bệnh tim thông thường không nên tham gia các hoạt động thể thao quá mức kịch liệt."
  },
  {
    "id": 3675,
    "hanzi": "不已",
    "pinyin": "bùyǐ",
    "word_type": "Động từ / Phó từ",
    "meaning_vi": "không thôi, không ngớt, mãi không dứt",
    "example_hanzi": "得知中国队在奥运会上再次夺金，全场观众兴奋不已。",
    "example_pinyin": "Dézhī Zhōngguóduì zài Àoyùnhuì shang zàicì duó jīn, quánchǎng guānzhòng xīngfèn bùyǐ.",
    "example_vi": "Khi biết tin đội tuyển Trung Quốc một lần nữa đoạt huy chương vàng tại Thế vận hội, toàn thể khán giả hưng phấn không thôi."
  },
  {
    "id": 3677,
    "hanzi": "猜测",
    "pinyin": "cāicè",
    "word_type": "Động từ / Danh từ",
    "meaning_vi": "phỏng đoán, suy đoán",
    "example_hanzi": "在没有确凿事实依据之前，大家不要随意主观猜测。",
    "example_pinyin": "Zài méiyǒu quèzáo shìshí yījù zhīqián, dàjiā bú yào suíyì zhǔguān cāicè.",
    "example_vi": "Trước khi có căn cứ sự thật xác thực, mọi người không nên tùy tiện suy đoán chủ quan."
  },
  {
    "id": 3678,
    "hanzi": "才华",
    "pinyin": "cáihuá",
    "word_type": "Danh từ",
    "meaning_vi": "tài hoa, tài năng nổi trội",
    "example_hanzi": "这位年轻画家的艺术才华受到了业内专家的高度赞赏。",
    "example_pinyin": "Zhè wèi niánqīng huàjiā de yìshù cáihuá shòudào le yènèi zhuānjiā de gāodù zànshǎng.",
    "example_vi": "Tài hoa nghệ thuật của họa sĩ trẻ này đã nhận được sự tán thưởng rất cao từ các chuyên gia trong ngành."
  },
  {
    "id": 3679,
    "hanzi": "才能",
    "pinyin": "cáinéng",
    "word_type": "Danh từ",
    "meaning_vi": "tài năng, năng lực",
    "example_hanzi": "良好的公司管理制度能够充分激发每一位员工的潜在才能。",
    "example_pinyin": "Liánghǎo de gōngsī guǎnlǐ zhìdù nénggòu chōngfèn jīfā měi yí wèi yuángōng de qiánzài cáinéng.",
    "example_vi": "Chế độ quản lý công ty tốt có thể khơi dậy trọn vẹn tài năng tiềm ẩn của mỗi một nhân viên."
  },
  {
    "id": 3680,
    "hanzi": "财物",
    "pinyin": "cáiwù",
    "word_type": "Danh từ",
    "meaning_vi": "tài sản, của cải",
    "example_hanzi": "在公共场所游玩时，请大家务必妥善保管好个人随身财物。",
    "example_pinyin": "Zài gōnggòng chǎngsuǒ yóuwán shí, qǐng dàjiā wùbì tuǒshàn bǎoguǎn hǎo gèrén suíshēn cáiwù.",
    "example_vi": "Khi vui chơi ở nơi công cộng, xin mọi người nhất định phải bảo quản chu đáo tài sản mang theo bên mình."
  },
  {
    "id": 3681,
    "hanzi": "材质",
    "pinyin": "cáizhì",
    "word_type": "Danh từ",
    "meaning_vi": "chất liệu, vật liệu chế tạo",
    "example_hanzi": "这款高档办公桌采用纯天然实木材质，手感温润厚重。",
    "example_pinyin": "Zhè kuǎn gāodàng bàngōngzhuō cǎiyòng chún tiānrán shímù cáizhì, shǒugǎn wēnrùn hòuzhòng.",
    "example_vi": "Mẫu bàn làm việc cao cấp này sử dụng chất liệu gỗ tự nhiên nguyên khối, sờ vào cảm thấy mịn màng và đầm tay."
  },
  {
    "id": 3682,
    "hanzi": "参展",
    "pinyin": "cānzhǎn",
    "word_type": "Động từ",
    "meaning_vi": "tham gia triển lãm",
    "example_hanzi": "今年将有来自全球五十多个国家的三千家企业报名参展。",
    "example_pinyin": "Jīnnián jiāng yǒu láizì quánqiú wǔshí duō gè guójiā de sānqiān jiā qǐyè bàomíng cānzhǎn.",
    "example_vi": "Năm nay sẽ có ba nghìn doanh nghiệp đến từ hơn năm mươi quốc gia trên toàn cầu đăng ký tham gia triển lãm."
  },
  {
    "id": 3683,
    "hanzi": "草原",
    "pinyin": "cǎoyuán",
    "word_type": "Danh từ",
    "meaning_vi": "thảo nguyên, đồng cỏ",
    "example_hanzi": "内蒙古的大草原一望无际，牛羊在蓝天下悠闲地吃草。",
    "example_pinyin": "Nèiměnggǔ de dà cǎoyuán yíwàng-wújì, niúyáng zài lántiān xià yōuxián de chī cǎo.",
    "example_vi": "Đại thảo nguyên Nội Mông trải dài ngút ngàn, bò cừu nhởn nhơ gặm cỏ dưới trời xanh."
  },
  {
    "id": 3684,
    "hanzi": "侧",
    "pinyin": "cè",
    "word_type": "Danh từ / Động từ",
    "meaning_vi": "bên cạnh, mặt bên; nghiêng người",
    "example_hanzi": "请大家站在道路右侧，留出中间通道让急救车辆通行。",
    "example_pinyin": "Qǐng dàjiā zhàn zài dàolù yòucè, liúchū zhōngjiān tōngdào ràng jíjiù chēliàng tōngxíng.",
    "example_vi": "Xin mọi người đứng ở bên phải con đường, chừa lối đi ở giữa cho xe cứu thương lưu thông."
  },
  {
    "id": 3685,
    "hanzi": "层面",
    "pinyin": "céngmiàn",
    "word_type": "Danh từ",
    "meaning_vi": "tầng diện, khía cạnh, bình diện",
    "example_hanzi": "这个问题不仅涉及经济层面，更关系到社会文化的发展。",
    "example_pinyin": "Zhè gè wèntí bùjǐn shèjí jīngjì céngmiàn, gèng guānxì dào shèhuì wénhuà de fāzhǎn.",
    "example_vi": "Vấn đề này không chỉ liên quan tới bình diện kinh tế, mà còn gắn liền với sự phát triển văn hóa xã hội."
  },
  {
    "id": 3686,
    "hanzi": "叉",
    "pinyin": "chā",
    "word_type": "Danh từ / Động từ",
    "meaning_vi": "cái nĩa, cái chạc; cắm nĩa vào, đan chéo",
    "example_hanzi": "吃西餐时，通常习惯左手拿叉，右手拿刀。",
    "example_pinyin": "Chī xīcān shí, tōngcháng xíguàn zuǒshǒu ná chā, yòushǒu ná dāo.",
    "example_vi": "Khi ăn món Tây, thông thường người ta quen tay trái cầm nĩa, tay phải cầm dao."
  },
  {
    "id": 3688,
    "hanzi": "差异",
    "pinyin": "chāyì",
    "word_type": "Danh từ",
    "meaning_vi": "sự khác biệt, sai khác",
    "example_hanzi": "不同国家之间的文化差异需要通过深入交流来互相理解。",
    "example_pinyin": "Bùtóng guójiā zhījiān de wénhuà chāyì xūyào tōngguò shēnrù jiāoliú lái hùxiāng lǐjiě.",
    "example_vi": "Sự khác biệt văn hóa giữa các quốc gia khác nhau cần thông qua giao lưu sâu rộng để thấu hiểu lẫn nhau."
  },
  {
    "id": 3689,
    "hanzi": "查询",
    "pinyin": "cháxún",
    "word_type": "Động từ",
    "meaning_vi": "tra cứu, tìm kiếm thông tin",
    "example_hanzi": "旅客可以通过手机官方软件随时查询列车的正晚点信息。",
    "example_pinyin": "Lǚkè kěyǐ tōngguò shǒujī guānfāng ruǎnjiàn suíshí cháxún lièchē de zhèngwǎndiǎn xìnxī.",
    "example_vi": "Hành khách có thể thông qua ứng dụng chính thức trên điện thoại để tra cứu thông tin đúng giờ hay chậm giờ của tàu hoả bất cứ lúc nào."
  },
  {
    "id": 3690,
    "hanzi": "拆除",
    "pinyin": "chāichú",
    "word_type": "Động từ",
    "meaning_vi": "tháo dỡ, dỡ bỏ (công trình cũ)",
    "example_hanzi": "为了城市道路拓宽改造，这批老旧危房将在本月底前彻底拆除。",
    "example_pinyin": "Wèile chéngshì dàolù tuòkuān gǎizào, zhè pī lǎojiù wēifáng jiāng zài běn yuèdǐ qián chèdǐ chāichú.",
    "example_vi": "Để phục vụ cải tạo mở rộng đường phố, lô nhà cũ xuống cấp nguy hiểm này sẽ được tháo dỡ triệt để trước cuối tháng này."
  },
  {
    "id": 3691,
    "hanzi": "产出",
    "pinyin": "chǎnchū",
    "word_type": "Động từ / Danh từ",
    "meaning_vi": "sản lượng, sản xuất ra, đầu ra",
    "example_hanzi": "采用高科技农业技术后，这片试验田的粮食产出显著提高。",
    "example_pinyin": "Cǎiyòng gāokējì nóngyè jìshù hòu, zhè piàn shìyàntián de liángshi chǎnchū xiǎnzhù tígāo.",
    "example_vi": "Sau khi áp dụng kỹ thuật nông nghiệp công nghệ cao, sản lượng lương thực của thửa ruộng thí nghiệm này đã tăng lên rõ rệt."
  },
  {
    "id": 3692,
    "hanzi": "产地",
    "pinyin": "chǎndì",
    "word_type": "Danh từ",
    "meaning_vi": "nơi sản xuất, xuất xứ, nơi khởi nguồn",
    "example_hanzi": "买水果的时候，很多消费者都特别关注产地是否正宗。",
    "example_pinyin": "Mǎi shuǐguǒ de shíhou, hěn duō xiāofèizhě dōu tèbié guānzhù chǎndì shìfǒu zhèngzōng.",
    "example_vi": "Khi mua hoa quả, rất nhiều người tiêu dùng đặc biệt quan tâm tới việc nơi sản xuất có chính gốc hay không."
  },
  {
    "id": 3693,
    "hanzi": "肠",
    "pinyin": "cháng",
    "word_type": "Danh từ",
    "meaning_vi": "ruột (bộ phận cơ thể), lòng",
    "example_hanzi": "多吃富含膳食纤维的新鲜蔬菜有利于保护肠胃健康。",
    "example_pinyin": "Duō chī fùhán shànshí xiānwéi de xīnxiān shūcài yǒulì yú bǎohù chángwèi jiànkāng.",
    "example_vi": "Ăn nhiều rau tươi giàu chất xơ có lợi cho việc bảo vệ sức khỏe đường ruột và dạ dày."
  },
  {
    "id": 3694,
    "hanzi": "长短",
    "pinyin": "chángduǎn",
    "word_type": "Danh từ",
    "meaning_vi": "độ dài, dài ngắn; tai nạn bất trắc",
    "example_hanzi": "这件新买的裤子长短刚好合适，不需要拿到裁缝店修改。",
    "example_pinyin": "Zhè jiàn xīn mǎi de kùzi chángduǎn gānghǎo héshì, bù xūyào ná dào cáifengdiàn xiūgǎi.",
    "example_vi": "Chiếc quần mới mua này độ dài vừa vặn, không cần phải mang ra tiệm may để sửa."
  },
  {
    "id": 3696,
    "hanzi": "常规",
    "pinyin": "chángguī",
    "word_type": "Danh từ / Tính từ",
    "meaning_vi": "thông thường, quy ước thường quy",
    "example_hanzi": "每年定期进行常规身体检查是预防潜在疾病的有效方法。",
    "example_pinyin": "Měi nián dìngqī jìnxíng chángguī shēntǐ jiǎnchá shì yùfáng qiánzài jíbìng de yǒuxiào fāngfǎ.",
    "example_vi": "Hàng năm định kỳ khám sức khỏe tổng quát thông thường là phương pháp hữu hiệu để phòng ngừa các bệnh tiềm ẩn."
  },
  {
    "id": 3697,
    "hanzi": "常年",
    "pinyin": "chángnián",
    "word_type": "Phó từ / Danh từ",
    "meaning_vi": "quanh năm suốt tháng, nhiều năm liền",
    "example_hanzi": "张工程师常年在边远山区的水利工程现场辛勤工作。",
    "example_pinyin": "Zhāng gōngchéngshī chángnián zài biānyuǎn shānqū de shuǐlì gōngchéng xiànchǎng xīnqín gōngzuò.",
    "example_vi": "Kỹ sư Trương quanh năm suốt tháng làm việc cần cù tại hiện trường công trình thủy lợi nơi vùng núi xa xôi."
  },
  {
    "id": 3698,
    "hanzi": "长寿",
    "pinyin": "chángshòu",
    "word_type": "Tính từ / Động từ",
    "meaning_vi": "trường thọ, sống lâu",
    "example_hanzi": "保持乐观豁达的心态和规律的生活作息是老人长寿的秘诀。",
    "example_pinyin": "Bǎochí lèguān huòdá de xīntài hé guīlǜ de shēnghuó zuòxī shì lǎorén chángshòu de mìjué.",
    "example_vi": "Giữ tinh thần lạc quan khoáng đạt và nếp sống sinh hoạt điều độ là bí quyết sống trường thọ của người già."
  },
  {
    "id": 3699,
    "hanzi": "常温",
    "pinyin": "chángwēn",
    "word_type": "Danh từ",
    "meaning_vi": "nhiệt độ thường (phòng)",
    "example_hanzi": "这种鲜牛奶在常温下只能保存两天，开封后请尽早饮用。",
    "example_pinyin": "Zhè zhǒng xiān niúnǎi zài chángwēn xià zhǐ néng bǎocún liǎng tiān, kāifēng hòu qǐng jǐnzǎo yǐnyòng.",
    "example_vi": "Loại sữa tươi này ở nhiệt độ thường chỉ có thể bảo quản trong hai ngày, sau khi mở nắp xin hãy uống sớm."
  },
  {
    "id": 3700,
    "hanzi": "场次",
    "pinyin": "chǎngcì",
    "word_type": "Danh từ",
    "meaning_vi": "suất chiếu, ca diễn, buổi diễn",
    "example_hanzi": "周末电影院增加了多部热门电影的放映场次以满足观众需求。",
    "example_pinyin": "Zhōumò diànyǐngyuàn zēngjiā le duō bù rèmén diànyǐng de fàngyìng chǎngcì yǐ mǎnzú guānzhòng xūqiú.",
    "example_vi": "Cuối tuần rạp chiếu phim đã tăng thêm nhiều suất chiếu cho các bộ phim ăn khách nhằm đáp ứng nhu cầu của khán giả."
  },
  {
    "id": 3701,
    "hanzi": "场地",
    "pinyin": "chǎngdì",
    "word_type": "Danh từ",
    "meaning_vi": "địa điểm, mặt bằng, sân bãi",
    "example_hanzi": "举办大型户外音乐节需要提前向市政部门申请合规的场地。",
    "example_pinyin": "Jǔbàn dàxíng hùwài yīnyuèjié xūyào tíqián xiàng shìzhèng bùmén shēnqǐng héguī de chǎngdì.",
    "example_vi": "Tổ chức lễ hội âm nhạc ngoài trời quy mô lớn cần nộp đơn xin địa điểm hợp chuẩn từ cơ quan chính quyền thành phố trước."
  },
  {
    "id": 3702,
    "hanzi": "场馆",
    "pinyin": "chǎngguǎn",
    "word_type": "Danh từ",
    "meaning_vi": "nhà thi đấu, cung thể thao, hội trường",
    "example_hanzi": "新建的综合体育场馆配备了国际一流的灯光和音响设施。",
    "example_pinyin": "Xīnjiàn de zōnghé tǐyù chǎngguǎn pèibèi le guójì yīliú de dēngguāng hé yīnxiǎng shèshī.",
    "example_vi": "Nhà thi đấu thể thao tổng hợp mới xây dựng được trang bị cơ sở hạ tầng âm thanh và ánh sáng hàng đầu quốc tế."
  },
  {
    "id": 3703,
    "hanzi": "厂家",
    "pinyin": "chǎngjiā",
    "word_type": "Danh từ",
    "meaning_vi": "nhà sản xuất, hãng sản xuất",
    "example_hanzi": "消费者在官方旗舰店购买商品能够享受厂家直接提供的售后服务。",
    "example_pinyin": "Xiāofèizhě zài guānfāng qíjiàndiàn gòumǎi shāngpǐn nénggòu xiǎngshòu chǎngjiā zhíjiē tígōng de shòuhòu fúwù.",
    "example_vi": "Người tiêu dùng mua hàng tại gian hàng chính hãng có thể tận hưởng dịch vụ hậu mãi do nhà sản xuất cung cấp trực tiếp."
  },
  {
    "id": 3704,
    "hanzi": "场景",
    "pinyin": "chǎngjǐng",
    "word_type": "Danh từ",
    "meaning_vi": "bối cảnh, cảnh tượng, phân cảnh",
    "example_hanzi": "电影中男女主角在雨中重逢的感人场景令全场观众潸然泪下。",
    "example_pinyin": "Diànyǐng zhōng nánnǚ zhǔjiǎo zài yǔ zhōng chóngféng de gǎnrén chǎngjǐng lìng quánchǎng guānzhòng shānráu-lèixià.",
    "example_vi": "Cảnh tượng cảm động khi hai nhân vật chính gặp lại nhau trong mưa trong phim đã khiến toàn bộ khán giả rơi lệ."
  },
  {
    "id": 3705,
    "hanzi": "厂商",
    "pinyin": "chǎngshāng",
    "word_type": "Danh từ",
    "meaning_vi": "hãng kinh doanh sản xuất, nhà cung cấp",
    "example_hanzi": "各大汽车厂商纷纷宣布加快在新能源电动车领域的研发步伐。",
    "example_pinyin": "Gè dà qìchē chǎngshāng fēnfēn xuānbù jiākuài zài xīnnéngyuán diàndòngchē lǐngyù de yánfā bùfá.",
    "example_vi": "Các hãng sản xuất ô tô lớn đều lần lượt tuyên bố đẩy nhanh bước tiến nghiên cứu phát triển trong lĩnh vực xe điện năng lượng mới."
  },
  {
    "id": 3706,
    "hanzi": "炒股",
    "pinyin": "chǎogǔ",
    "word_type": "Động từ",
    "meaning_vi": "chơi chứng khoán, đầu tư cổ phiếu",
    "example_hanzi": "盲目借钱炒股存在极大的市场风险，投资者一定要保持理性。",
    "example_pinyin": "Mángmù jiè qián chǎogǔ cúnzài jí dà de shìchǎng fēngxiǎn, tóuzīzhě yídìng yào bǎochí lǐxìng.",
    "example_vi": "Mù quáng vay tiền chơi chứng khoán tiềm ẩn rủi ro thị trường cực lớn, nhà đầu tư nhất định phải giữ sự lý trí."
  },
  {
    "id": 3707,
    "hanzi": "撤回",
    "pinyin": "chèhuí",
    "word_type": "Động từ",
    "meaning_vi": "rút về, thu hồi (lời nói, thông báo, đơn từ)",
    "example_hanzi": "发现合同条款存在漏洞后，法务团队决定暂时撤回该份协议。",
    "example_pinyin": "Fāxiàn hétong tiáokuǎn cúnzài lòudòng hòu, fǎwù tuánduì juédìng zànshí chèhuí gāi fèn xiéyì.",
    "example_vi": "Sau khi phát hiện điều khoản hợp đồng có kẽ hở, đội ngũ pháp chế đã quyết định tạm thời thu hồi bản thỏa thuận đó."
  },
  {
    "id": 3708,
    "hanzi": "撑",
    "pinyin": "chēng",
    "word_type": "Động từ",
    "meaning_vi": "chống đỡ, giương ô; quá no",
    "example_hanzi": "尽管创业过程面临很多困难，他们依然咬牙紧紧撑了下来。",
    "example_pinyin": "Jǐnguǎn chuàngyè guòchéng miànlín hěn duō kùnnan, tāmen yīrán yǎoyá jǐnjǐn chēng le xiàlái.",
    "example_vi": "Dù quá trình khởi nghiệp đối mặt với vô vàn khó khăn, họ vẫn cắn răng kiên trì chống chọi vượt qua."
  },
  {
    "id": 3709,
    "hanzi": "称作",
    "pinyin": "chēngzuò",
    "word_type": "Động từ",
    "meaning_vi": "gọi là, được xưng là",
    "example_hanzi": "这片湿地生态环境优美，因而被当地人亲切地称作城市之肺。",
    "example_pinyin": "Zhè piàn shīdì shēngtài huánjìng yōuměi, yīn’ér bèi dāngdìrén qīnqiè de chēngzuò chéngshì zhī fèi.",
    "example_vi": "Khu đất ngập nước này có môi trường sinh thái tuyệt đẹp, do đó được người dân địa phương trìu mến gọi là lá phổi của thành phố."
  },
  {
    "id": 3711,
    "hanzi": "成",
    "pinyin": "chéng",
    "word_type": "Lượng từ / Số từ",
    "meaning_vi": "phần mười (1成 = 10%)",
    "example_hanzi": "调查显示，有近八成的受访青年愿意尝试自由职业。",
    "example_pinyin": "Diàochá xiǎnshì, yǒu jìn bā chéng de shòufǎng qīngnián yuànyì chángshì zìyóu zhíyè.",
    "example_vi": "Điều tra cho thấy, có tới gần tám mươi phần trăm (tám phần) thanh niên được phỏng vấn sẵn lòng thử sức với nghề tự do."
  },
  {
    "id": 3712,
    "hanzi": "成千上万",
    "pinyin": "chéngqiān-shàngwàn",
    "word_type": "Cụm thành ngữ",
    "meaning_vi": "hàng ngàn hàng vạn, vô số kể",
    "example_hanzi": "每到候鸟迁徙的季节，成千上万只水鸟就会聚集在这片湖泊。",
    "example_pinyin": "Měi dào hòuniǎo qiānxǐ de jìjié, chéngqiān-shàngwàn zhī shuǐniǎo jiù huì jùjí zài zhè piàn húpò.",
    "example_vi": "Mỗi mùa chim di cư tới, hàng ngàn hàng vạn con chim nước lại tụ hội bên hồ nước này."
  },
  {
    "id": 3713,
    "hanzi": "诚信",
    "pinyin": "chéngxìn",
    "word_type": "Danh từ / Tính từ",
    "meaning_vi": "thành tín, trung thực và uy tín",
    "example_hanzi": "诚信不仅是商业合作的坚固基石，更是为人处世的基本底线。",
    "example_pinyin": "Chéngxìn bùjǐn shì shāngyè hézuò de jiāngù jīshí, gèng shì wéirén-chǔshì de jīběn dǐxiàn.",
    "example_vi": "Thành tín không chỉ là nền tảng vững chắc trong hợp tác thương mại, mà còn là ranh giới cơ bản trong đối nhân xử thế."
  },
  {
    "id": 3714,
    "hanzi": "城镇",
    "pinyin": "chéngzhèn",
    "word_type": "Danh từ",
    "meaning_vi": "thị trấn, đô thị nhỏ",
    "example_hanzi": "随着高铁网络的开通，许多偏远城镇迎来了旅游经济繁荣。",
    "example_pinyin": "Suízhe gāotiě wǎngluò de kāitōng, xǔduō piānyuǎn chéngzhèn yínglái le lǚyóu jīngjì fánróng.",
    "example_vi": "Cùng với việc mạng lưới đường sắt cao tốc thông xe, nhiều thị trấn hẻo lánh đã đón nhận sự phồn vinh của kinh tế du lịch."
  },
  {
    "id": 3715,
    "hanzi": "持有",
    "pinyin": "chíyǒu",
    "word_type": "Động từ",
    "meaning_vi": "nắm giữ, sở hữu (chứng chỉ, cổ phần, quan điểm)",
    "example_hanzi": "只有持有有效护照和签证的旅客才被允许进入国际出发区。",
    "example_pinyin": "Zhǐyǒu chíyǒu yǒuxiào hùzhào hé qiānzhèng de lǚkè cái bèi yǔnxǔ jìnrù guójì chūfā qū.",
    "example_vi": "Chỉ những hành khách sở hữu hộ chiếu và thị thực còn hiệu lực mới được phép vào khu vực xuất phát quốc tế."
  },
  {
    "id": 3716,
    "hanzi": "尺",
    "pinyin": "chǐ",
    "word_type": "Danh từ / Lượng từ",
    "meaning_vi": "thước đo; đơn vị xích (1 thước TQ ≈ 33.3cm)",
    "example_hanzi": "木工师傅拿出一把卷尺，仔细测量着书架各隔板的具体尺寸。",
    "example_pinyin": "Mùgōng shīfu ná chū yì bǎ juǎnchǐ, zǐxì cèliáng zhe shūjià gè gébǎn de jùtǐ chǐcun.",
    "example_vi": "Bác thợ mộc rút ra một chiếc thước cuộn, cẩn thận đo đạc kích thước cụ thể của từng ngăn trên giá sách."
  },
  {
    "id": 3717,
    "hanzi": "重建",
    "pinyin": "chóngjiàn",
    "word_type": "Động từ",
    "meaning_vi": "tái thiết, xây dựng lại",
    "example_hanzi": "地震灾害平息后，当地政府迅速组织居民展开家园重建工作。",
    "example_pinyin": "Dìzhèn zāihài píngxī hòu, dāngdì zhèngfǔ xùnsù zǔzhī jūmín zhǎnkāi jiāyuán chóngjiàn gōngzuò.",
    "example_vi": "Sau khi thảm họa động đất lắng xuống, chính quyền địa phương đã nhanh chóng tổ chức người dân triển khai công tác tái thiết quê hương."
  },
  {
    "id": 3719,
    "hanzi": "抽奖",
    "pinyin": "chōujiǎng",
    "word_type": "Động từ / Danh từ",
    "meaning_vi": "bốc thăm trúng thưởng, quay số may mắn",
    "example_hanzi": "商场周年庆典期间，每位消费满额的顾客都可以参加一次抽奖。",
    "example_pinyin": "Shāngchǎng zhōunián qìngdiǎn qījiān, měi wèi xiāofèi mǎn’é de gùkè dōu kěyǐ cānjiā yí cì chōujiǎng.",
    "example_vi": "Trong dịp đại lễ kỷ niệm một năm của trung tâm mua sắm, mỗi khách hàng tiêu dùng đủ định mức đều có thể tham gia quay số trúng thưởng một lần."
  },
  {
    "id": 3720,
    "hanzi": "愁",
    "pinyin": "chóu",
    "word_type": "Động từ / Tính từ",
    "meaning_vi": "lo âu, sầu muộn, bận tâm",
    "example_hanzi": "遇到暂时的挫折别发愁，静下心来总能想到妥善的解决之道。",
    "example_pinyin": "Yù dào zànshí de cuòzhé bié fāchóu, jìng xià xīn lái zǒng néng xiǎng dào tuǒshàn de jiějué zhī dào.",
    "example_vi": "Gặp phải trắc trở tạm thời đừng lo âu phiền muộn, bình tâm lại ắt sẽ nghĩ ra cách giải quyết chu toàn."
  },
  {
    "id": 3721,
    "hanzi": "出场",
    "pinyin": "chūchǎng",
    "word_type": "Động từ",
    "meaning_vi": "ra sân, xuất hiện trên sàn đấu / sân khấu",
    "example_hanzi": "当著名钢琴演奏家优雅出场时，全场观众报以极其热烈的掌声。",
    "example_pinyin": "Dāng zhùmíng gāngqín yǎnzòujiā yōuyǎ chūchǎng shí, quánchǎng guānzhòng bào yǐ jíqí rèliè de zhǎngshēng.",
    "example_vi": "Khi nghệ sĩ dương cầm trứ danh tao nhã bước ra sân khấu, toàn thể khán giả đã dành một tràng pháo tay cực kỳ nồng nhiệt."
  },
  {
    "id": 3722,
    "hanzi": "初等",
    "pinyin": "chūděng",
    "word_type": "Tính từ",
    "meaning_vi": "sơ đẳng, sơ cấp, ban đầu",
    "example_hanzi": "普及初等义务教育是提升全民族文化素养不可或缺的重要一步。",
    "example_pinyin": "Pǔjí chūděng yìwù jiàoyù shì tíshēng quán mínzú wénhuà sùyǎng bùkě huòquē de zhòngyào yíbù.",
    "example_vi": "Phổ cập giáo dục nghĩa vụ sơ đẳng là một bước đi quan trọng không thể thiếu để nâng cao tố chất văn hóa của toàn dân tộc."
  },
  {
    "id": 3723,
    "hanzi": "出境",
    "pinyin": "chūjìng",
    "word_type": "Động từ",
    "meaning_vi": "xuất cảnh, rời khỏi biên giới",
    "example_hanzi": "由于涉及经济纠纷诉讼，该涉案人员被依法限制出境。",
    "example_pinyin": "Yóuyú shèjí jīngjì jiūfēn sùsòng, gāi shè'àn rényuán bèi yīfǎ xiànzhì chūjìng.",
    "example_vi": "Do liên quan đến vụ kiện tụng tranh chấp kinh tế, người có liên quan tới vụ án này đã bị hạn chế xuất cảnh theo quy định pháp luật."
  },
  {
    "id": 3724,
    "hanzi": "出力",
    "pinyin": "chūlì",
    "word_type": "Động từ",
    "meaning_vi": "góp sức, bỏ công sức",
    "example_hanzi": "只要大家齐心协力一起出力，社区环境就一定会变得更加整洁。",
    "example_pinyin": "Zhǐyào dàjiā qíxīn-xiélì yìqǐ chūlì, shèqū huánjìng jiù yídìng huì biàn de gèngjiā zhěngjié.",
    "example_vi": "Chỉ cần mọi người đồng lòng góp sức cùng nhau, môi trường sống của khu dân cư nhất định sẽ trở nên ngăn nắp sạch đẹp hơn."
  },
  {
    "id": 3725,
    "hanzi": "出名",
    "pinyin": "chūmíng",
    "word_type": "Tính từ / Động từ",
    "meaning_vi": "nổi tiếng, có tiếng tăm",
    "example_hanzi": "这座江南古镇凭借其幽静的小桥流水和悠久历史而在全国出名。",
    "example_pinyin": "Zhè zuò Jiāngnán gǔzhèn píngjiè qí yōujìng de xiǎoqiáo-liúshuǐ hé yōujiǔ lìshǐ ér zài quánguó chūmíng.",
    "example_vi": "Cổ trấn vùng Giang Nam này nổi tiếng khắp cả nước nhờ vào cảnh sắc cầu nhỏ nước chảy thanh tịnh và lịch sử lâu đời."
  },
  {
    "id": 3726,
    "hanzi": "出入",
    "pinyin": "chūrù",
    "word_type": "Danh từ / Động từ",
    "meaning_vi": "ra vào; sự chênh lệch sai biệt",
    "example_hanzi": "小区门禁系统严格管理，非本小区居民出入必须登记身份信息。",
    "example_pinyin": "Xiǎoqū ménjìn xìtǒng yángé guǎnlǐ, fēi běn xiǎoqū jūmín chūrù bìxū dēngjì shēnfèn xìnxī.",
    "example_vi": "Hệ thống kiểm soát cửa ra vào của khu chung cư quản lý rất nghiêm ngặt, người không phải cư dân khi ra vào bắt buộc phải đăng ký thông tin cá nhân."
  },
  {
    "id": 3728,
    "hanzi": "出游",
    "pinyin": "chūyóu",
    "word_type": "Động từ",
    "meaning_vi": "đi du ngoạn, đi chơi dã ngoại",
    "example_hanzi": "趁着春暖花开的好时节，不少家庭选择周末开车出门出游踏青。",
    "example_pinyin": "Chènzhe chūnnuǎn-huākāi de hǎo shíjié, bù shǎo jiātíng xuǎnzé zhōumò kāichē chūmén chūyóu tàqīng.",
    "example_vi": "Nhân tiết trời xuân ấm hoa nở tươi đẹp, không ít gia đình chọn lái xe ra ngoài du ngoạn ngắm cảnh vào dịp cuối tuần."
  },
  {
    "id": 3729,
    "hanzi": "出于",
    "pinyin": "chūyú",
    "word_type": "Giới từ / Động từ",
    "meaning_vi": "xuất phát từ, bắt nguồn từ (động cơ, mục đích)",
    "example_hanzi": "他所提出的一切建议完全是出于对整个团队长远利益的关切。",
    "example_pinyin": "Tā suǒ tíchū de yíqiè jiànyì wánquán shì chūyú duì zhěnggè tuánduì chángyuǎn lìyì de guānqiè.",
    "example_vi": "Tất cả những kiến nghị mà anh ấy đưa ra hoàn toàn xuất phát từ sự quan tâm tới lợi ích lâu dài của cả tập thể."
  },
  {
    "id": 3730,
    "hanzi": "除非",
    "pinyin": "chúfēi",
    "word_type": "Liên từ",
    "meaning_vi": "trừ phi, trừ khi",
    "example_hanzi": "除非双方都愿意做出妥协让步，否则这场谈判很难达成共识。",
    "example_pinyin": "Chúfēi shuāngfāng dōu yuànyì zuòchū tuǒxié ràngbù, fǒuzé zhè chǎng tánpàn hěn nán dáchéng gòngshí.",
    "example_vi": "Trừ phi cả hai bên đều sẵn lòng thỏa hiệp nhượng bộ, nếu không cuộc đàm phán này rất khó đạt được đồng thuận chung."
  },
  {
    "id": 3731,
    "hanzi": "处罚",
    "pinyin": "chǔfá",
    "word_type": "Động từ / Danh từ",
    "meaning_vi": "xử phạt, hình phạt kỷ luật",
    "example_hanzi": "交通管理部门将对在高速公路上超速行驶的行为进行严厉处罚。",
    "example_pinyin": "Jiāotōng guǎnlǐ bùmén jiāng duì zài gāosù gōnglù shang chāosù xíngshǐ de xíngwéi jìnxíng yánlì chǔfá.",
    "example_vi": "Cơ quan quản lý giao thông sẽ tiến hành xử phạt nghiêm khắc đối với hành vi điều khiển phương tiện chạy quá tốc độ trên đường cao tốc."
  },
  {
    "id": 3732,
    "hanzi": "处处",
    "pinyin": "chùchù",
    "word_type": "Phó từ",
    "meaning_vi": "khắp nơi, mọi nơi mọi lúc",
    "example_hanzi": "只要你留心观察生活，身边处处都可以发现令人感动的人文之美。",
    "example_pinyin": "Zhǐyào nǐ liúxīn guānchá shēnghuó, shēnbiān chùchù dōu kěyǐ fāxiàn lìng rén gǎndòng de rénwén zhī měi.",
    "example_vi": "Chỉ cần bạn để tâm quan sát cuộc sống, xung quanh bạn khắp mọi nơi đều có thể khám phá thấy nét đẹp nhân văn làm rung động lòng người."
  },
  {
    "id": 3734,
    "hanzi": "穿过",
    "pinyin": "chuānguò",
    "word_type": "Động từ",
    "meaning_vi": "băng qua, xuyên qua, vượt qua",
    "example_hanzi": "穿过这条繁华狭窄的古老小巷，眼前便豁然开朗看到广阔的江面。",
    "example_pinyin": "Chuānguò zhè tiáo fánhuá xiázǎi de gǔlǎo xiǎoxiàng, yǎnqián biàn huòrán-kāilǎng kàn dào guǎngkuò de jiāngmiàn.",
    "example_vi": "Băng qua con hẻm cổ kính nhỏ hẹp nhộn nhịp này, trước mắt liền mở ra thoáng đãng nhìn thấy mặt sông rộng bao la."
  },
  {
    "id": 3735,
    "hanzi": "传承",
    "pinyin": "chuánchéng",
    "word_type": "Động từ",
    "meaning_vi": "kế thừa và phát huy, lưu truyền",
    "example_hanzi": "保护好非物质文化遗产是让古老民族技艺代代传承的重要使命。",
    "example_pinyin": "Bǎohù hǎo fēiwùzhí wénhuà yíchǎn shì ràng gǔlǎo mínzú jìyì dàidài chuánchéng de zhòngyào shǐmìng.",
    "example_vi": "Bảo tồn tốt các di sản văn hóa phi vật thể là sứ mệnh quan trọng để kỹ nghệ dân tộc cổ xưa được lưu truyền từ thế hệ này sang thế hệ khác."
  },
  {
    "id": 3736,
    "hanzi": "传染病",
    "pinyin": "chuánrǎnbìng",
    "word_type": "Danh từ",
    "meaning_vi": "bệnh truyền nhiễm",
    "example_hanzi": "建立健全的公共卫生预警体系是有效防控急性传染病的关键所在。",
    "example_pinyin": "Jiànlì jiànquán de gōnggòng wèishēng yùjǐng tǐxì shì yǒuxiào fángkòng jíxìng chuánrǎnbìng de guānjiàn suǒzài.",
    "example_vi": "Thiết lập hệ thống cảnh báo sớm y tế công cộng hoàn thiện là mấu chốt then chốt để phòng chống hiệu quả các bệnh truyền nhiễm cấp tính."
  },
  {
    "id": 3737,
    "hanzi": "传输",
    "pinyin": "chuánshū",
    "word_type": "Động từ",
    "meaning_vi": "truyền tải, truyền dẫn (dữ liệu, tín hiệu)",
    "example_hanzi": "光纤宽带网络的全面升级大幅提升了海量数字数据的传输速度。",
    "example_pinyin": "Guāngxiān kuāndài wǎngluò de quánmiàn shēngjí dàfú tíshēng le hǎiliàng shùzì shùjù de chuánshū sùdù.",
    "example_vi": "Việc nâng cấp toàn diện mạng băng thông rộng cáp quang đã nâng cao đáng kể tốc độ truyền tải các khối dữ liệu kỹ thuật số khổng lồ."
  },
  {
    "id": 3738,
    "hanzi": "船只",
    "pinyin": "chuánzhī",
    "word_type": "Danh từ (Tập hợp)",
    "meaning_vi": "tàu thuyền, thuyền bè",
    "example_hanzi": "由于台风即将来袭，沿海港口所有作业船只均已回港避风。",
    "example_pinyin": "Yóuyú táifēng jíjiāng láixí, yánhǎi gǎngkǒu suǒyǒu zuòyè chuánzhī jūn yǐ huí gǎng bì fēng.",
    "example_vi": "Do cơn bão sắp sửa đổ bộ, toàn bộ tàu thuyền hoạt động tại cảng ven biển đều đã trở về âu thuyền tránh gió."
  }
];
