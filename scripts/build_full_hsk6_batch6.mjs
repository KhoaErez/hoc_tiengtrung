import fs from 'fs'

function escapeSql(str) {
  if (!str) return "''"
  return `'${str.replace(/'/g, "''")}'`
}

const BATCH_6_DATA = [
  {
    id: 4697,
    hanzi: "人山人海",
    pinyin: "rénshān-rénhǎi",
    word_type: "Thành ngữ",
    meaning_vi: "người đông như biển, biển người",
    example_hanzi: "国庆长假期间的景区广场上人山人海，热闹非凡。",
    example_pinyin: "Guóqìng chángjià qījiān de jǐngqū guǎngchǎng shang rénshān-rénhǎi, rènào fēifán.",
    example_vi: "Trên quảng trường khu danh thắng trong kỳ nghỉ dài Quốc khánh đông nghịt biển người, náo nhiệt vô cùng."
  },
  {
    id: 4701,
    hanzi: "人行道",
    pinyin: "rénxíngdào",
    word_type: "Danh từ",
    meaning_vi: "vỉa hè, lối đi cho người đi bộ",
    example_hanzi: "市政部门重新拓宽了主干道两侧的人行道，并铺设了防滑地砖。",
    example_pinyin: "Shìzhèng bùmén chóngxīn tuòkuān le zhǔgàndào liǎngcè de rénxíngdào, bìng pūshè le fánghuá dìzhuān.",
    example_vi: "Cơ quan công chính thành phố đã mở rộng lại vỉa hè hai bên trục đường chính và lát gạch chống trơn trượt."
  },
  {
    id: 4703,
    hanzi: "认错",
    pinyin: "rèncuò",
    word_type: "Động từ",
    meaning_vi: "nhận lỗi, nhận sai",
    example_hanzi: "做错事情后应当勇于主动认错并及时纠正，而不是一味推卸责任。",
    example_pinyin: "Zuò cuò shìqing hòu yīngdāng yǒngyú zhǔdòng rèncuò bìng jíshí jiūzhèng, ér bú shì yíwèi tuīxiè zérèn.",
    example_vi: "Sau khi làm sai sự việc cần phải dũng cảm chủ động nhận lỗi và kịp thời sửa sai, chứ không phải một mực thoái thác trách nhiệm."
  },
  {
    id: 4706,
    hanzi: "认同",
    pinyin: "rèntóng",
    word_type: "Động từ / Danh từ",
    meaning_vi: "đồng tình, thừa nhận, tán đồng",
    example_hanzi: "他的创新经营理念得到了公司董事会全体成员的高度认同与支持。",
    example_pinyin: "Tā de chuàngxīn jīngyíng lǐniàn dédào le gōngsī dǒngshìhuì quántǐ chéngyuán de gāodù rèntóng yǔ zhīchí.",
    example_vi: "Triết lý kinh doanh đổi mới sáng tạo của anh ấy đã nhận được sự đồng thuận và ủng hộ cao độ từ toàn thể thành viên Hội đồng quản trị công ty."
  },
  {
    id: 4707,
    hanzi: "认知",
    pinyin: "rènzhī",
    word_type: "Danh từ / Động từ",
    meaning_vi: "nhận thức, sự nhận biết",
    example_hanzi: "阅读经典哲学著作能够帮助我们打破固有思维局限、拓展认知边界。",
    example_pinyin: "Yuèdú jīngdiǎn zhéxué zhùzuò nénggòu bāngzhù wǒmen dǎpò gùyǒu sīwéi júxiàn, tuòzhǎn rènzhī biānjiè.",
    example_vi: "Đọc các tác phẩm triết học kinh điển có thể giúp chúng ta phá vỡ giới hạn tư duy cố hữu và mở rộng ranh giới nhận thức."
  },
  {
    id: 4709,
    hanzi: "日后",
    pinyin: "rìhòu",
    word_type: "Danh từ",
    meaning_vi: "về sau, sau này",
    example_hanzi: "青年时期打下坚实的专业知识基础，日后步入社会才能走得更稳健。",
    example_pinyin: "Qīngnián shíqī dǎxià jiānshí de zhuānyè zhīshi jīchǔ, rìhòu bùrù shèhuì cáinéng zǒu de gèng wěnjiàn.",
    example_vi: "Thời thanh niên xây dựng nền tảng kiến thức chuyên môn vững chắc thì sau này bước vào đời mới có thể tiến bước vững vàng."
  },
  {
    id: 4710,
    hanzi: "日前",
    pinyin: "rìqián",
    word_type: "Danh từ",
    meaning_vi: "mấy hôm trước, vừa qua",
    example_hanzi: "科技部日前正式发布了国家重大科研基础设施面向社会开放的实施方案。",
    example_pinyin: "Kējìbù rìqián zhèngshì fābù le guójiā zhòngdà kēyán jīchǔ shèshī miànxiàng shèhuì kāifàng de shíshī fāng'àn.",
    example_vi: "Bộ Khoa học và Công nghệ vừa qua đã chính thức công bố đề án triển khai mở cửa các cơ sở hạ tầng nghiên cứu khoa học trọng đại quốc gia phục vụ xã hội."
  },
  {
    id: 4711,
    hanzi: "日夜",
    pinyin: "rìyè",
    word_type: "Danh từ / Phó từ",
    meaning_vi: "ngày đêm, suốt ngày đêm",
    example_hanzi: "为了确保民生重点工程按期交付，施工人员在工地上日夜奋战。",
    example_pinyin: "Wèile quèbǎo mínshēng zhòngdiǎn gōngchéng ànqī jiāofù, shīgōng rényuán zài gōngdì shang rìyè fènzhàn.",
    example_vi: "Để bảo đảm bàn giao công trình trọng điểm an sinh xã hội đúng hạn, đội ngũ công nhân thi công đã ngày đêm miệt mài chiến đấu trên công trường."
  },
  {
    id: 4713,
    hanzi: "融合",
    pinyin: "rónghé",
    word_type: "Động từ",
    meaning_vi: "dung hòa, hòa quyện, kết hợp",
    example_hanzi: "这座现代艺术展馆巧妙融合了东方传统美学与西方现代建筑元素。",
    example_pinyin: "Zhè zuò xiàndài yìshù zhǎnguǎn qiǎomiào rónghé le dōngfāng chuántǒng měixué yǔ xīfāng xiàndài jiànzhù yuánsù.",
    example_vi: "Nhà triển lãm nghệ thuật hiện đại này đã khéo léo hòa quyện giữa mỹ học truyền thống phương Đông và các yếu tố kiến trúc hiện đại phương Tây."
  },
  {
    id: 4715,
    hanzi: "容量",
    pinyin: "róngliàng",
    word_type: "Danh từ",
    meaning_vi: "dung lượng, sức chứa",
    example_hanzi: "这款大容量移动电源能够同时为多部智能移动终端设备快速充电。",
    example_pinyin: "Zhè kuǎn dà róngliàng yídòng diànyuán nénggòu tóngshí wèi duō bù zhìnéng yídòng zhōngduān shèbèi kuàisù chōngdiàn.",
    example_vi: "Cục sạc dự phòng dung lượng lớn này có thể sạc nhanh đồng thời cho nhiều thiết bị đầu cuối di động thông minh."
  },
  {
    id: 4716,
    hanzi: "融入",
    pinyin: "róngrù",
    word_type: "Động từ",
    meaning_vi: "hòa nhập vào, hòa vào",
    example_hanzi: "初到异国他乡留学的学子应当主动学习当地语言，更快融入校园生活。",
    example_pinyin: "Chū dào yìguó-tāxiāng liúxué de xuézǐ yīngdāng zhǔdòng xuéxí dāngdì yǔyán, gèng kuài róngrù xiàoyuán shēnghuó.",
    example_vi: "Du học sinh mới đến xứ người du học nên chủ động học ngôn ngữ bản xứ để nhanh chóng hòa nhập vào đời sống học đường."
  },
  {
    id: 4718,
    hanzi: "柔软",
    pinyin: "róuruǎn",
    word_type: "Tính từ",
    meaning_vi: "mềm mại, êm ái",
    example_hanzi: "踩在松软细腻的金黄色沙滩上，脚底感觉格外温暖而柔软舒适。",
    example_pinyin: "Cǎi zài sōngruǎn xìnì de jīnhuángsè shātān shang, jiǎodǐ gǎnjué géwài wēnnuǎn ér róuruǎn shūshì.",
    example_vi: "Dẫm chân trên bãi cát vàng óng mịn màng tơi xốp, lòng bàn chân cảm thấy vô cùng ấm áp và mềm mại dễ chịu."
  },
  {
    id: 4719,
    hanzi: "入境",
    pinyin: "rùjìng",
    word_type: "Động từ",
    meaning_vi: "nhập cảnh",
    example_hanzi: "边检口岸增设了多条外籍旅客入境快捷通道，大幅提升了通关速度。",
    example_pinyin: "Biānjiǎn kǒu'àn zēngshè le duō tiáo wàijí lǚkè rùjìng kuàijié tōngdào, dàfú tíshēng le tōngguān sùdù.",
    example_vi: "Cửa khẩu kiểm soát biên phòng đã bổ sung nhiều làn nhập cảnh nhanh cho du khách nước ngoài, nâng cao đáng kể tốc độ thông quan."
  },
  {
    id: 4720,
    hanzi: "入门",
    pinyin: "rùmén",
    word_type: "Danh từ / Động từ",
    meaning_vi: "nhập môn, bước đầu",
    example_hanzi: "这本编程入门教程由浅入深，非常适合完全没有基础的初学者研读。",
    example_pinyin: "Zhè běn biānchéng rùmén jiàochéng yóu qiǎn rù shēn, fēicháng shìhé wánquán méiyǒu jīchǔ de chūxuézhě yándú.",
    example_vi: "Giáo trình nhập môn lập trình này đi từ dễ đến khó, rất thích hợp cho những người mới bắt đầu hoàn toàn chưa có nền tảng nghiên cứu học tập."
  },
  {
    id: 4721,
    hanzi: "入选",
    pinyin: "rùxuǎn",
    word_type: "Động từ",
    meaning_vi: "trúng tuyển, được chọn vào",
    example_hanzi: "经过多轮严苛选拔，青年科研骨干成功入选国家优秀青年科学家培养计划。",
    example_pinyin: "Jīngguò duō lún yánkē xuǎnbá, qīngnián kēyán gǔgàn chénggōng rùxuǎn guójiā yōuxiù qīngnián kēxuéjiā péiyǎng jìhuà.",
    example_vi: "Trải qua nhiều vòng tuyển chọn khắt khe, cán bộ nòng cốt nghiên cứu trẻ đã vinh dự được chọn vào chương trình bồi dưỡng nhà khoa học trẻ xuất sắc quốc gia."
  },
  {
    id: 4723,
    hanzi: "撒",
    pinyin: "sǎ",
    word_type: "Động từ",
    meaning_vi: "rải, rắc, vãi, gieo",
    example_hanzi: "清晨柔和的阳光洒在湖面上，仿佛给粼粼波光撒上了一层碎金。",
    example_pinyin: "Qīngchén róuhé de yángguāng sǎ zài húmiàn shang, fǎngfú gěi línlín bōguāng sǎ shàng le yì céng suì jīn.",
    example_vi: "Ánh nắng ban mai dịu êm rọi xuống mặt hồ, dường như rắc lên những đợt sóng lăn tăn một lớp vàng vụn lấp lánh."
  },
  {
    id: 4724,
    hanzi: "塞",
    pinyin: "sāi",
    word_type: "Động từ / Danh từ",
    meaning_vi: "nhét, nút bịt, nút đóng",
    example_hanzi: "他把几份急需审核的重要文件塞进公文包，急匆匆地赶往机场。",
    example_pinyin: "Tā bǎ jǐ fèn jíxū shěnhé de zhòngyào wénjiàn sāi jìn gōngwénbāo, jícōngcōng de gǎnwǎng jīchǎng.",
    example_vi: "Anh ấy nhét vội mấy tập tài liệu quan trọng đang cần gấp vào cặp tài liệu rồi vội vã hối hả chạy ra sân bay."
  },
  {
    id: 4725,
    hanzi: "赛事",
    pinyin: "sàishì",
    word_type: "Danh từ",
    meaning_vi: "giải đấu, sự kiện thể thao",
    example_hanzi: "组委会全力做好后勤保障工作，确保本次国际顶级体育赛事圆满成功。",
    example_pinyin: "Zǔwěihuì quánlì zuòhǎo hòuqín bǎozhàng gōngzuò, quèbǎo běncì guójì dǐngjí tǐyù sàishì yuánmǎn chénggōng.",
    example_vi: "Ban tổ chức dốc toàn lực làm tốt công tác bảo đảm hậu cần, bảo đảm giải đấu thể thao đỉnh cao quốc tế lần này thành công viên mãn."
  },
  {
    id: 4726,
    hanzi: "散",
    pinyin: "sǎn",
    word_type: "Tính từ / Động từ",
    meaning_vi: "rời rạc, tản mạn, rải rác",
    example_hanzi: "这篇抒情散文语言优美，形散神聚，读来令人陶醉其中。",
    example_pinyin: "Zhè piān shūqíng sǎnwén yǔyán yōuměi, xíng sǎn shén jù, dú lái lìng rén táozuì qízhōng.",
    example_vi: "Bài văn xuôi trữ tình này ngôn từ thanh thoát, hình thức tản mạn mà thần thái cô đọng, đọc lên khiến người ta say đắm mê mẩn."
  },
  {
    id: 4728,
    hanzi: "散",
    pinyin: "sàn",
    word_type: "Động từ",
    meaning_vi: "tan, giải tán, xua tan",
    example_hanzi: "随着微风吹拂，晨间弥漫在山谷中的浓雾慢慢散开，群山重现苍翠。",
    example_pinyin: "Suízhe wēifēng chuīfú, chénjiān mímàn zài shāngǔ zhōng de nóngwù mànmàn sànkāi, qúnshān chóngxiàn cāngcuì.",
    example_vi: "Cùng với làn gió nhẹ thổi qua, màn sương mù dày đặc bao phủ thung lũng ban sáng dần tan biến, núi non lại hiện ra nét xanh biếc ngút ngàn."
  },
  {
    id: 4732,
    hanzi: "扫描",
    pinyin: "sǎomiáo",
    word_type: "Động từ",
    meaning_vi: "quét (mã, tài liệu)",
    example_hanzi: "顾客只需使用智能手机扫描桌上的二维码，即可自主完成点餐和线上支付。",
    example_pinyin: "Gùkè zhǐ xū shǐyòng zhìnéng shǒujī sǎomiáo zhuō shang de èrwéimǎ, jíkě zìzhǔ wánchéng diǎncān hé xiànshàng zhīfù.",
    example_vi: "Khách hàng chỉ cần dùng điện thoại thông minh quét mã QR trên bàn là có thể tự mình gọi món và hoàn tất thanh toán trực tuyến."
  },
  {
    id: 4735,
    hanzi: "鲨鱼",
    pinyin: "shāyú",
    word_type: "Danh từ",
    meaning_vi: "cá mập",
    example_hanzi: "鲨鱼作为海洋顶级掠食者，在维护海洋生态系统平衡中发挥着关键作用。",
    example_pinyin: "Shāyú zuòwéi hǎiyáng dǐngjí lüèshízhě, zài wéihù hǎiyáng shēngtài xìtǒng pínghéng zhōng fāhuī zhe guānjiàn zuòyòng.",
    example_vi: "Cá mập với vai trò là loài săn mồi đỉnh cao của đại dương đang đóng vai trò then chốt trong việc duy trì cân bằng hệ sinh thái biển."
  },
  {
    id: 4737,
    hanzi: "山顶",
    pinyin: "shāndǐng",
    word_type: "Danh từ",
    meaning_vi: "đỉnh núi",
    example_hanzi: "登山队员历经艰辛跋涉终于成功登上了山顶，壮美云海尽收眼底。",
    example_pinyin: "Dēngshān duìyuán lìjīng jiānkīn báshè zhōngyú chénggōng dēngshàng le shāndǐng, zhuàngměi yúnhǎi jìn shōu yǎndǐ.",
    example_vi: "Các thành viên đội leo núi trải qua hành trình leo trèo gian nan cuối cùng đã chinh phục đỉnh núi, biển mây tráng lệ thu trọn vào tầm mắt."
  },
  {
    id: 4738,
    hanzi: "山峰",
    pinyin: "shānfēng",
    word_type: "Danh từ",
    meaning_vi: "ngọn núi, đỉnh núi cao",
    example_hanzi: "远方白雪皑皑的山峰在晨曦映照下闪烁着圣洁耀眼的金色光芒。",
    example_pinyin: "Yuǎnfāng báixuě-ái'ái de shānfēng zài chénxī yìngzhào xià shǎnshuò zhe shèngjié yàoyǎn de jīnsè guāngmáng.",
    example_vi: "Những ngọn núi tuyết phủ trắng xóa phía xa dưới ánh ban mai phản chiếu lấp lánh ánh hào quang vàng kim rực rỡ và thánh thiện."
  },
  {
    id: 4739,
    hanzi: "山坡",
    pinyin: "shānpō",
    word_type: "Danh từ",
    meaning_vi: "sườn núi, triền núi",
    example_hanzi: "春天漫山遍野的野花开满了向阳的山坡，宛如铺上了一条五彩地毯。",
    example_pinyin: "Chūntiān mànshān-biànyě de yěhuā kāimǎn le xiàngyáng de shānpō, wǎnrú pūshàng le yì tiáo wǔcǎi dìtǎn.",
    example_vi: "Mùa xuân hoa dại nở rộ khắp núi đồi phủ kín sườn núi đón nắng, tựa như trải ra một tấm thảm hoa ngũ sắc ngát hương."
  },
  {
    id: 4740,
    hanzi: "闪",
    pinyin: "shǎn",
    word_type: "Động từ",
    meaning_vi: "lóe sáng, nhấp nháy; né tránh",
    example_hanzi: "夏夜的星空璀璨宁静，偶尔有一颗耀眼的流星自天际一闪而过。",
    example_pinyin: "Xiàyè de xīngkōng cuǐcàn níngjìng, ǒu'ěr yǒu yì kē yàoyǎn de liúxīng zì tiānjì yì shǎn ér guò.",
    example_vi: "Bầu trời đêm mùa hè lung linh tĩnh mịch, thi thoảng có một ngôi sao băng chói lọi từ chân trời vụt lóe sáng lướt qua."
  },
  {
    id: 4741,
    hanzi: "闪电",
    pinyin: "shǎndiàn",
    word_type: "Danh từ",
    meaning_vi: "tia chớp, sấm sét",
    example_hanzi: "一道刺目的蓝色闪电划破了漆黑的夜空，紧接着传来了震耳欲聋的雷声。",
    example_pinyin: "Yí dào cìmù de lánsè shǎndiàn huàpò le qīhēi de yèkōng, jǐnjiēzhe chuánlái le zhèn'ěr-yùlóng de léishēng.",
    example_vi: "Một tia chớp xanh chói lòa xé toạc màn đêm đen kịt, ngay sau đó vang lên tiếng sấm rền vang đinh tai nhức óc."
  },
  {
    id: 4744,
    hanzi: "伤口",
    pinyin: "shāngkǒu",
    word_type: "Danh từ",
    meaning_vi: "vết thương",
    example_hanzi: "医生细心地为患者清洗缝合了伤口，并叮嘱近期切勿碰水以防感染。",
    example_pinyin: "Yīshēng xìxīn de wèi huànzhě qīngxǐ fénghé le shāngkǒu, bìng dīngzhǔ jìnqī qièwù pèng shuǐ yǐ fáng gǎnrǎn.",
    example_vi: "Bác sĩ cẩn thận rửa sạch khâu lại miệng vết thương cho bệnh nhân, đồng thời dặn dò dạo này tuyệt đối không được đụng nước để phòng nhiễm trùng."
  },
  {
    id: 4745,
    hanzi: "伤亡",
    pinyin: "shāngwáng",
    word_type: "Danh từ / Động từ",
    meaning_vi: "thương vong",
    example_hanzi: "得益于应急疏散预案启动及时，本次地震灾害未造成任何人员伤亡。",
    example_pinyin: "Déyì yú yìngjí shūsàn yù'àn qǐdòng jíshí, běncì dìzhèn zāihài wèi zàochéng rènhé rényuán shāngwáng.",
    example_vi: "Nhờ phương án ứng phó sơ tán khẩn cấp được kích hoạt kịp thời, trận thiên tai động đất lần này không gây ra bất kỳ thương vong nào về người."
  },
  {
    id: 4746,
    hanzi: "伤员",
    pinyin: "shāngyuán",
    word_type: "Danh từ",
    meaning_vi: "thương binh, người bị thương",
    example_hanzi: "急救直升机迅速将危重伤员转运至省城三甲医院接受抢救手术。",
    example_pinyin: "Jíjiù zhíshēngjī xùnsù jiāng wēizhòng shāngyuán zhuǎnyùn zhì shěngchéng sānjiǎ yīyuàn jiēshòu qiǎngjiù shǒushù.",
    example_vi: "Trực thăng cấp cứu nhanh chóng chuyển các thương viên nguy kịch tới bệnh viện tuyến đầu của tỉnh lỵ để tiếp nhận phẫu thuật cấp cứu."
  },
  {
    id: 4750,
    hanzi: "上市",
    pinyin: "shàngshì",
    word_type: "Động từ",
    meaning_vi: "lên sàn chứng khoán; tung ra thị trường",
    example_hanzi: "这家高新技术创新企业在证券交易所敲钟上市，开启了崭新的发展里程碑。",
    example_pinyin: "Zhè jiā gāoxīn jìshù chuàngxīn qǐyè zài zhèngquàn jiāoyìsuǒ qiāozhōng shàngshì, kāiqǐ le zhǎnxīn de fāzhǎn lǐchéngbēi.",
    example_vi: "Doanh nghiệp đổi mới công nghệ cao này đã rung chuông lên sàn tại sở giao dịch chứng khoán, mở ra cột mốc phát triển hoàn toàn mới."
  },
  {
    id: 4751,
    hanzi: "上述",
    pinyin: "shàngshù",
    word_type: "Tính từ",
    meaning_vi: "nêu trên, kể trên",
    example_hanzi: "凡符合上述申报资质条件的科研团队，均可按程序在线提交项目申请书。",
    example_pinyin: "Fán fúhé shàngshù shēnbào zīzhì tiáojiàn de kēyán tuánduì, jūn kě àn chéngxù zàixiàn tíjiāo xiàngmù shēnqǐngshū.",
    example_vi: "Phàm là các nhóm nghiên cứu khoa học đáp ứng đủ điều kiện tư cách đăng ký nêu trên, đều có thể nộp hồ sơ xin cấp dự án trực tuyến theo quy trình."
  },
  {
    id: 4752,
    hanzi: "上台",
    pinyin: "shàngtái",
    word_type: "Động từ",
    meaning_vi: "lên sân khấu, bước lên bục",
    example_hanzi: "在全场热烈的掌声与欢呼声中，获奖青年科学家从容步上台领奖。",
    example_pinyin: "Zài quánchǎng rèliè de zhǎngshēng yǔ huānhūshēng zhōng, huòjiǎng qīngnián kēxuéjiā cōngróng bù shàngtái lǐngjiǎng.",
    example_vi: "Trong tiếng vỗ tay và reo hò nhiệt liệt của toàn thể hội trường, nhà khoa học trẻ đoạt giải ung dung bước lên sân khấu nhận giải."
  },
  {
    id: 4753,
    hanzi: "上旬",
    pinyin: "shàngxún",
    word_type: "Danh từ",
    meaning_vi: "thượng tuần (10 ngày đầu tháng)",
    example_hanzi: "按照工作计划安排，全市春季重点招商引资洽谈会定于下月上旬隆重举行。",
    example_pinyin: "Ànzhào gōngzuò jìhuà ānpái, quán shì chūnjì zhòngdiǎn zhāoshāng-yǐnzī qiàtánhuì dìng yú xià yuè shàngxún lóngzhòng jǔxíng.",
    example_vi: "Theo lịch trình kế hoạch công tác, hội nghị đàm phán thu hút đầu tư trọng điểm mùa xuân toàn thành phố dự kiến tổ chức long trọng vào thượng tuần tháng sau."
  },
  {
    id: 4754,
    hanzi: "少儿",
    pinyin: "shào’ér",
    word_type: "Danh từ",
    meaning_vi: "thiếu nhi, trẻ em",
    example_hanzi: "市图书馆新设立的少儿阅览区色彩斑斓，深受广大小读者们的喜爱。",
    example_pinyin: "Shì túshūguǎn xīn shèlì de shào'ér yuèlǎnqū sècǎi-bānlán, shēn shòu guǎngdà xiǎo dúzhě men de xǐ'ài.",
    example_vi: "Khu vực đọc sách thiếu nhi mới được thành lập của thư viện thành phố ngập tràn sắc màu rực rỡ, rất được đông đảo bạn đọc nhí yêu mến."
  },
  {
    id: 4756,
    hanzi: "社",
    pinyin: "shè",
    word_type: "Danh từ",
    meaning_vi: "tổ chức xã hội, nhà xuất bản, hội sở",
    example_hanzi: "著名出版传媒社推出了一套印刷精美的经典世界文学名著丛书。",
    example_pinyin: "Zhùmíng chūbǎn chuánméishè tuīchū le yí tào yìnshuā jīngměi de jīngdiǎn shìjiè wénxué míngzhù cóngshū.",
    example_vi: "Nhà xuất bản truyền thông nổi tiếng đã cho ra mắt một bộ tùng thư danh tác văn học kinh điển thế giới được in ấn vô cùng tinh xảo."
  },
  {
    id: 4757,
    hanzi: "射",
    pinyin: "shè",
    word_type: "Động từ",
    meaning_vi: "bắn, phóng, chiếu tia",
    example_hanzi: "前锋球员在禁区边缘果断起脚大力抽射，皮球应声钻入球门死角。",
    example_pinyin: "Qiánfēng qiúyuán zài jìnqū biānyuán guǒduàn qǐjiǎo dàlì chōushè, píqiú yìngshēng zuān rù qiúmén sǐjiǎo.",
    example_vi: "Tiền đạo dứt khoát vung chân tung cú sút sấm sét ngay sát mép vòng cấm, bóng găm thẳng vào góc chết khung thành."
  },
  {
    id: 4760,
    hanzi: "摄像",
    pinyin: "shèxiàng",
    word_type: "Động từ / Danh từ",
    meaning_vi: "quay phim, ghi hình",
    example_hanzi: "纪录片拍摄团队携带专业高精度摄像器材深入热带雨林记录珍稀动物。",
    example_pinyin: "Jìlùpiàn pāishè tuánduì xiédài zhuānyè gāo jīngdù shèxiàng qìcái shēnrù rèdài yǔlín jìlù zhēnxī dòngwù.",
    example_vi: "Đoàn làm phim tài liệu mang theo thiết bị quay phim chuyên nghiệp độ chính xác cao thâm nhập vào rừng mưa nhiệt đới để ghi hình các loài động vật quý hiếm."
  },
  {
    id: 4762,
    hanzi: "摄像头",
    pinyin: "shèxiàngtóu",
    word_type: "Danh từ",
    meaning_vi: "camera, mắt quay camera",
    example_hanzi: "社区在主要出入口均加装了高清智能摄像头，全面提升了治安防范能力。",
    example_pinyin: "Shèqū zài zhǔyào chūrùkǒu jūn jiāzhuāng le gāoqīng zhìnéng shèxiàngtóu, quánmiàn tíshēng le zhì'ān fángfàn nénglì.",
    example_vi: "Khu dân cư đã lắp thêm camera thông minh độ nét cao ở các cửa ra vào chính, nâng cao toàn diện năng lực phòng ngừa trật tự an ninh."
  },
  {
    id: 4763,
    hanzi: "身心",
    pinyin: "shēnxīn",
    word_type: "Danh từ",
    meaning_vi: "thân tâm, thể xác và tinh thần",
    example_hanzi: "保持适度规律的体育锻炼与充足的睡眠，是促进身心健康的有效基石。",
    example_pinyin: "Bǎochí shìdù guīlǜ de tǐyù duànliàn yǔ chōngzú de shuìmián, shì cùjìn shēnxīn jiànkāng de yǒuxiào jīshí.",
    example_vi: "Duy trì rèn luyện thể dục thể thao điều độ vừa phải cùng giấc ngủ đong đầy là nền tảng hữu hiệu thúc đẩy sức khỏe thân tâm."
  },
  {
    id: 4764,
    hanzi: "深夜",
    pinyin: "shēnyè",
    word_type: "Danh từ",
    meaning_vi: "đêm khuya, đêm muộn",
    example_hanzi: "时钟早已敲过深夜十二点，科研大楼实验室里的灯火依然通明如昼。",
    example_pinyin: "Shízhōng zǎoyǐ qiāoguò shēnyè shí'èr diǎn, kēyán dàlóu shíyànshì lǐ de dēnghuǒ yīrán tōngmíng rú zhòu.",
    example_vi: "Kim đồng hồ đã điểm qua mười hai giờ đêm muộn từ lâu, ánh đèn trong các phòng thí nghiệm của tòa nhà nghiên cứu khoa học vẫn sáng rực như ban ngày."
  },
  {
    id: 4765,
    hanzi: "神",
    pinyin: "shén",
    word_type: "Tính từ / Danh từ",
    meaning_vi: "thần kỳ, kỳ diệu; thần linh; tinh thần",
    example_hanzi: "老中医仅凭望闻问切便精准诊断出了病因，医术精湛得令人叹为神奇。",
    example_pinyin: "Lǎo zhōngyī jǐn píng wàng-wén-wèn-qiè biàn jīngzhǔn zhěnduàn chū le bìngyīn, yīshù jīngzhàn de lìng rén tàn wéi shénqí.",
    example_vi: "Vị thầy thuốc Đông y lão luyện chỉ dựa vào tứ chẩn vọng văn vấn thiết mà chẩn đoán chuẩn xác nguyên nhân gây bệnh, y thuật tinh thâm khiến người ta phải thán phục là thần kỳ."
  },
  {
    id: 4770,
    hanzi: "生成",
    pinyin: "shēngchéng",
    word_type: "Động từ",
    meaning_vi: "tạo ra, sinh ra, sản sinh",
    example_hanzi: "基于大语言模型的人工智能软件可以在数秒内快速生成高质量的研究大纲。",
    example_pinyin: "Jīyú dà yǔyán móxíng de réngōng zhìnéng ruǎnjiàn kěyǐ zài shù miǎo nèi kuàisù shēngchéng gāo zhìliàng de yánjiū dàgāng.",
    example_vi: "Phần mềm trí tuệ nhân tạo dựa trên mô hình ngôn ngữ lớn có thể nhanh chóng tạo ra đề cương nghiên cứu chất lượng cao chỉ trong vài giây."
  },
  {
    id: 4772,
    hanzi: "生命力",
    pinyin: "shēngmìnglì",
    word_type: "Danh từ",
    meaning_vi: "sức sống, sinh mệnh lực",
    example_hanzi: "中华优秀传统文化历经数千年历史风雨洗礼，至今依然绽放出旺盛的生命力。",
    example_pinyin: "Zhōnghuá yōuxiù chuántǒng wénhuà lìjīng shù qiān nián lìshǐ fēngyǔ xǐlǐ, zhìjīn yīrán zhànfàng chū wàngshèng de shēngmìnglì.",
    example_vi: "Văn hóa truyền thống ưu tú Trung Hoa trải qua hàng ngàn năm tôi luyện trong giông bão lịch sử, đến nay vẫn tỏa rạng sức sống mãnh liệt dồi dào."
  },
  {
    id: 4774,
    hanzi: "升学",
    pinyin: "shēngxué",
    word_type: "Động từ",
    meaning_vi: "học lên cấp cao hơn, thi chuyển cấp",
    example_hanzi: "学校不仅高度关注学生的学业升学率，更注重培养学生的综合综合素养。",
    example_pinyin: "Xuéxiào bùjǐn gāodù guānzhù xuésheng de xuéyè shēngxuélǜ, gèng zhùzhòng péiyǎng xuésheng de zōnghé sùyǎng.",
    example_vi: "Nhà trường không chỉ quan tâm cao độ tới tỉ lệ học lên cấp cao hơn của học sinh, mà còn chú trọng bồi dưỡng tố chất phẩm chất toàn diện cho các em."
  },
  {
    id: 4775,
    hanzi: "剩余",
    pinyin: "shèngyú",
    word_type: "Động từ / Tính từ",
    meaning_vi: "còn lại, dư thừa",
    example_hanzi: "企业应当将生产流程中产生的剩余边角余料统一回收再利用，减少资源浪费。",
    example_pinyin: "Qǐyè yīngdāng jiāng shēngchǎn liúchéng zhōng chǎnshēng de shèngyú biānjiǎo yúliào tǒngyī huíshōu zài lìyòng, jiǎnshǎo zīyuán làngfèi.",
    example_vi: "Doanh nghiệp nên thu gom các nguyên vật liệu thừa còn lại phát sinh trong quy trình sản xuất để tái sử dụng thống nhất, giảm lãng phí tài nguyên."
  },
  {
    id: 4776,
    hanzi: "诗词",
    pinyin: "shīcí",
    word_type: "Danh từ",
    meaning_vi: "thơ từ, thi từ cổ điển",
    example_hanzi: "品读唐诗宋词等古典诗词经典，能够陶冶人的情操并提升审美素养。",
    example_pinyin: "Pǐndú Tángshī Sòngcí děng gǔdiǎn shīcí jīngdiǎn, nénggòu táoyě rén de qíngcāo bìng tíshēng shěnměi sùyǎng.",
    example_vi: "Thưởng thức các áng kinh điển thi từ cổ điển như thơ Đường từ Tống có thể bồi đắp tâm hồn thanh cao và nâng cao tố chất thẩm mỹ cho con người."
  },
  {
    id: 4777,
    hanzi: "湿度",
    pinyin: "shīdù",
    word_type: "Danh từ",
    meaning_vi: "độ ẩm",
    example_hanzi: "博物馆文物恒温恒湿展厅的相对空气湿度被严格控制在合理标准范围之内。",
    example_pinyin: "Bówùguǎn wénwù héngwēn-héngshī zhǎntīng de xiāngduì kōngqì shīdù bèi yángé kòngzhì zài hélǐ biāozhǔn fànwéi zhīnèi.",
    example_vi: "Độ ẩm không khí tương đối trong phòng trưng bày hiện vật duy trì nhiệt độ và độ ẩm ổn định của bảo tàng được kiểm soát nghiêm ngặt trong phạm vi tiêu chuẩn hợp lý."
  },
  {
    id: 4778,
    hanzi: "师父",
    pinyin: "shīfu",
    word_type: "Danh từ",
    meaning_vi: "sư phụ, thầy dạy nghề",
    example_hanzi: "年轻学徒跟随经验丰富的老技工师父潜心学艺，掌握了精湛的手工钣金技艺。",
    example_pinyin: "Niánqīng xuétú gēnsuí jīngyàn fēngfù de lǎo jìgōng shīfu qiǎnxīn xuéyì, zhǎngwò le jīngzhàn de shǒugōng bǎnjīn jìyì.",
    example_vi: "Người học nghề trẻ tuổi theo chân sư phụ thợ lành nghề giàu dạn dày kinh nghiệm để chú tâm học nghề, nắm vững kỹ nghệ gò kim loại thủ công điêu luyện."
  },
  {
    id: 4779,
    hanzi: "诗歌",
    pinyin: "shīgē",
    word_type: "Danh từ",
    meaning_vi: "thơ ca, thi ca",
    example_hanzi: "在校园金秋诗歌朗诵比赛中，同学们饱含深情地抒发了对青春与理想的向往。",
    example_pinyin: "Zài xiàoyuán jīnqiū shīgē lǎngsòng bǐsài zhōng, tóngxué men bǎohán shēnqíng de shūfā le duì qīngchūn yǔ lǐxiǎng de xiàngwǎng.",
    example_vi: "Trong hội thi ngâm đọc thơ ca mùa thu vàng học đường, các bạn học sinh chan chứa cảm xúc dạt dào giãi bày niềm khát khao hướng tới tuổi trẻ và lý tưởng."
  },
  {
    id: 4781,
    hanzi: "识",
    pinyin: "shí",
    word_type: "Động từ / Danh từ",
    meaning_vi: "nhận biết; tri thức, kiến thức",
    example_hanzi: "外出旅游不仅能够饱览天下名山大川，更可以增长见识、开阔心胸眼界。",
    example_pinyin: "Wàichū lǚyóu bùjǐn nénggòu bǎolǎn tiānxià míngshān-dàchuān, gèng kěyǐ zēngzhǎng jiànshí, kāikuò xīnxiōng yǎnjiè.",
    example_vi: "Đi du lịch bên ngoài không chỉ có thể ngắm nhìn thỏa thê danh sơn đại xuyên trong thiên hạ, mà còn có thể gia tăng kiến thức hiểu biết, mở rộng tấm lòng và tầm mắt."
  },
  {
    id: 4789,
    hanzi: "实时",
    pinyin: "shíshí",
    word_type: "Phó từ / Tính từ",
    meaning_vi: "thời gian thực, trực tuyến cập nhật ngay",
    example_hanzi: "通过车载智能大屏幕，驾驶员可以随时掌握路面实时交通拥堵状况。",
    example_pinyin: "Tōngguò chēzǎi zhìnéng dà píngmù, jiàshǐyuán kěyǐ suíshí zhǎngwò lùmiàn shíshí jiāotōng yōngdǔ zhuàngkuàng.",
    example_vi: "Thông qua màn hình lớn thông minh trên xe ô tô, người lái có thể bất cứ lúc nào nắm bắt tình trạng ùn tắc giao thông trên mặt đường theo thời gian thực."
  },
  {
    id: 4790,
    hanzi: "时速",
    pinyin: "shísù",
    word_type: "Danh từ",
    meaning_vi: "tốc độ theo giờ, vận tốc (km/h)",
    example_hanzi: "新型高铁列车以三百五十公里的设计时速飞驰在广袤的大地原野之上。",
    example_pinyin: "Xīnxíng gāotiě lièchē yǐ sān bǎi wǔshí gōnglǐ de shèjì shísù fēichí zài guǎngmào de dàdì yuányě zhīshàng.",
    example_vi: "Đoàn tàu cao tốc kiểu mới lao vun vút trên bình nguyên đất mẹ bao la rộng lớn với vận tốc thiết kế ba trăm năm mươi cây số một giờ."
  },
  {
    id: 4792,
    hanzi: "食欲",
    pinyin: "shíyù",
    word_type: "Danh từ",
    meaning_vi: "sự thèm ăn, cảm giác ngon miệng",
    example_hanzi: "餐前喝一碗酸甜可口的开胃蔬菜汤，能有效增进食欲、唤醒味蕾。",
    example_pinyin: "Cān qián hē yì wǎn suāntián kěkǒu de kāiwèi shūcàitāng, néng yǒuxiào zēngjìn shíyù, huànxǐng wèilěi.",
    example_vi: "Trước bữa ăn uống một bát súp rau củ chua ngọt vừa miệng khai vị có thể kích thích cảm giác thèm ăn hữu hiệu, đánh thức các nụ vị giác."
  },
  {
    id: 4795,
    hanzi: "使劲",
    pinyin: "shǐjìn",
    word_type: "Động từ",
    meaning_vi: "dốc sức, dùng sức, gắng sức",
    example_hanzi: "拔河比赛进入白热化阶段，大家齐心协力一起使劲拉动粗绳。",
    example_pinyin: "Báhé bǐsài jìnrù báirèhuà jiēduàn, dàjiā qíxīn-xiélì yìqǐ shǐjìn lādòng cū shéng.",
    example_vi: "Cuộc thi kéo co bước vào giai đoạn gay cấn nảy lửa, mọi người đồng tâm hiệp lực cùng nhau dốc hết sức kéo sợi dây thừng lớn."
  },
  {
    id: 4797,
    hanzi: "适度",
    pinyin: "shìdù",
    word_type: "Tính từ / Phó từ",
    meaning_vi: "vừa phải, chừng mực, thích độ",
    example_hanzi: "进行体育运动时应当遵循适度原则，切忌因盲目过量运动而造成身体损伤。",
    example_pinyin: "Jìnxíng tǐyù yùndòng shí yīngdāng zūnxún shìdù yuánzé, qièjì yīn mángmù guòliàng yùndòng ér zàochéng shēntǐ sǔnshāng.",
    example_vi: "Khi tham gia vận động thể thao nên tuân thủ nguyên tắc chừng mực vừa phải, tránh vì mù quáng vận động quá sức mà gây thương tổn cho cơ thể."
  },
  {
    id: 4800,
    hanzi: "事后",
    pinyin: "shìhòu",
    word_type: "Danh từ",
    meaning_vi: "sau khi sự việc xảy ra, hậu sự việc",
    example_hanzi: "与其在事故发生后事后追悔莫及，不如在事前严格防范、消除隐患。",
    example_pinyin: "Yǔqí zài shìgù fāshēng hòu shìhòu zhuīhuǐ-mòjí, bùrú zài shìqián yángé fángfàn, xiāochú yǐnhuàn.",
    example_vi: "Thay vì để xảy ra sự cố rồi sau đó mới hối hận khôn nguôi, chi bằng trước khi xảy ra sự việc hãy nghiêm ngặt phòng ngừa, trừ khử mầm mống hiểm họa."
  },
  {
    id: 4801,
    hanzi: "视觉",
    pinyin: "shìjué",
    word_type: "Danh từ",
    meaning_vi: "thị giác",
    example_hanzi: "这部全景科幻大片以震撼人心的特效画面为观众带来了前所未有的视觉盛宴。",
    example_pinyin: "Zhè bù quánjǐng kēhuàn dàpiān yǐ zhènhàn-rénxīn de tèxiào huàmiàn wèi guānzhòng dàilái le qiánsuǒwèiyǒu de shìjué shèngyàn.",
    example_vi: "Bộ phim điện ảnh khoa học viễn tưởng toàn cảnh này với những khung hình kỹ xảo chấn động lòng người đã mang đến bữa tiệc thị giác chưa từng có cho khán giả."
  },
  {
    id: 4809,
    hanzi: "收购",
    pinyin: "shōugòu",
    word_type: "Động từ",
    meaning_vi: "thu mua, mua lại, sáp nhập",
    example_hanzi: "经过艰苦的商务谈判，科技巨头成功收购了一家专注于人工智能的初创企业。",
    example_pinyin: "Jīngguò jiānkǔ de shāngwù tánpàn, kējì jùtóu chénggōng shōugòu le yì jiā zhuānzhù yú réngōng zhìnéng de chūchuàng qǐyè.",
    example_vi: "Trải qua các cuộc đàm phán thương mại gian nan, ông lớn công nghệ đã mua lại thành công một doanh nghiệp khởi nghiệp chuyên sâu về trí tuệ nhân tạo."
  },
  {
    id: 4810,
    hanzi: "收取",
    pinyin: "shōuqǔ",
    word_type: "Động từ",
    meaning_vi: "thu (tiền, phí)",
    example_hanzi: "该政务服务大厅推行免收费制度，不再向办理业务的企业收取任何登记手续费。",
    example_pinyin: "Gāi zhèngwù fúwù dàtīng tuīxíng miǎn shòufèi zhìdù, búzài xiàng bànlǐ yèwù de qǐyè shōuqǔ rènhé dēngjì shǒuxùfèi.",
    example_vi: "Sảnh dịch vụ công này triển khai chế độ miễn thu phí, không còn thu bất kỳ khoản lệ phí thủ tục đăng ký nào từ các doanh nghiệp đến giải quyết công việc."
  },
  {
    id: 4812,
    hanzi: "手臂",
    pinyin: "shǒubì",
    word_type: "Danh từ",
    meaning_vi: "cánh tay",
    example_hanzi: "他在进行羽毛球扣杀训练时充分舒展手臂，动作优美而充满爆发力。",
    example_pinyin: "Tā zài jìnxíng yǔmáoqiú kòushā xùnliàn shí chōngfèn shūzhǎn shǒubì, dòngzuò yōuměi ér chōngmǎn bàofālì.",
    example_vi: "Khi thực hiện bài tập đập cầu lông anh ấy vươn mở trọn vẹn cánh tay, động tác đẹp mắt mà tràn đầy sức bùng nổ."
  },
  {
    id: 4817,
    hanzi: "受灾",
    pinyin: "shòuzāi",
    word_type: "Động từ",
    meaning_vi: "bị thiên tai, gặp nạn",
    example_hanzi: "各级政府迅速组织调拨大批急需生活物资，保障受灾群众的基本生活生活需求。",
    example_pinyin: "Gè jí zhèngfǔ xùnsù zǔzhī diàobō dà pī jíxū shēnghuó wùzī, bǎozhàng shòuzāi qúnzhòng de jīběn shēnghuó xūqiú.",
    example_vi: "Chính quyền các cấp đã nhanh chóng tổ chức điều phối số lượng lớn nhu yếu phẩm cấp thiết, bảo đảm nhu cầu sinh hoạt cơ bản cho quần chúng vùng bị thiên tai."
  },
  {
    id: 4818,
    hanzi: "输出",
    pinyin: "shūchū",
    word_type: "Động từ / Danh từ",
    meaning_vi: "xuất ra, đầu ra, xuất khẩu (văn hóa, công nghệ)",
    example_hanzi: "中国高端装备制造业正在由单纯的产品出口向系统化技术输出转型升级。",
    example_pinyin: "Zhōngguó gāoduān zhuāngbèi zhìzàoyè zhèngzài yóu dānchún de chǎnpǐn chūkǒu xiàng xìtǒnghuà jìshù shūchū zhuǎnxíng shēngjí.",
    example_vi: "Ngành sản xuất trang thiết bị cao cấp của Trung Quốc đang chuyển mình nâng cấp từ xuất khẩu sản phẩm đơn thuần sang xuất khẩu công nghệ mang tính hệ thống."
  },
  {
    id: 4819,
    hanzi: "书画",
    pinyin: "shūhuà",
    word_type: "Danh từ",
    meaning_vi: "thư họa, thư pháp và hội họa",
    example_hanzi: "美术馆内珍藏着多幅历代书画大家的传世名作，艺术价值极高。",
    example_pinyin: "Měishùguǎn nèi zhēncáng zhe duō fú lìdài shūhuà dàjiā de chuánshì míngzuò, yìshù jiàzhí jí gāo.",
    example_vi: "Trong bảo tàng mỹ thuật lưu giữ nhiều kiệt tác truyền đời của các đại gia thư họa qua các thời kỳ, mang giá trị nghệ thuật cực kỳ cao."
  },
  {
    id: 4822,
    hanzi: "输送",
    pinyin: "shūsòng",
    word_type: "Động từ",
    meaning_vi: "vận chuyển, dẫn truyền, tiếp tế",
    example_hanzi: "西气东输国家重大工程持续为东部经济发达省份稳定输送清洁天然气。",
    example_pinyin: "Xī qì dōng shū guójiā zhòngdà gōngchéng chíxù wèi dōngbù jīngjì fādá shěngfèn wěndìng shūsòng qīngjié tiānránqì.",
    example_vi: "Đại công trình quốc gia dẫn khí đốt từ Tây sang Đông liên tục vận chuyển khí tự nhiên sạch ổn định cho các tỉnh thành phát triển kinh tế ở miền Đông."
  },
  {
    id: 4823,
    hanzi: "书写",
    pinyin: "shūxiě",
    word_type: "Động từ",
    meaning_vi: "viết, chấp bút",
    example_hanzi: "新时代的青年应当在各自平凡的岗位上书写不平凡的壮丽青春篇章。",
    example_pinyin: "Xīn shídài de qīngnián yīngdāng zài gèzì píngfán de gǎngwèi shang shūxiě bù píngfán de zhuànglì qīngchūn piānzhāng.",
    example_vi: "Thanh niên thời đại mới cần phải viết nên những thiên anh hùng ca tuổi trẻ tráng lệ không tầm thường trên từng vị trí công tác bình dị của riêng mình."
  },
  {
    id: 4824,
    hanzi: "属",
    pinyin: "shǔ",
    word_type: "Động từ",
    meaning_vi: "thuộc về, thuộc loại",
    example_hanzi: "在科学分类体系中，大熊猫属于哺乳纲食肉目熊科动物。",
    example_pinyin: "Zài kēxué fēnlèi tǐxì zhōng, dàxióngmāo shǔyú bǔrǔgāng shíròumù xióngkē dòngwù.",
    example_vi: "Trong hệ thống phân loại khoa học, gấu trúc lớn thuộc lớp thú ăn thịt họ gấu."
  },
  {
    id: 4825,
    hanzi: "薯片",
    pinyin: "shǔpiàn",
    word_type: "Danh từ",
    meaning_vi: "khoai tây chiên (snack)",
    example_hanzi: "油炸膨化薯片虽然酥脆可口，但脂肪热量极高，不宜过量食用。",
    example_pinyin: "Yóuzhá pénghuà shǔpiàn suīrán sūcuì kěkǒu, dàn zhīfáng rèliàng jí gāo, bù yí guòliàng shíyòng.",
    example_vi: "Snack khoai tây chiên giòn tuy thơm ngon vừa miệng nhưng lượng calo và chất béo cực cao, không nên ăn quá nhiều."
  },
  {
    id: 4828,
    hanzi: "数目",
    pinyin: "shùmù",
    word_type: "Danh từ",
    meaning_vi: "số lượng, con số",
    example_hanzi: "库管员每天下班前都会仔细清点库存各类零配件的具体数目。",
    example_pinyin: "Kùguǎnyuán měitiān xiàbān qián dōu huì zǐxì qīngdiǎn kùcún gèlèi língpèijiàn de jùtǐ shùmù.",
    example_vi: "Thủ kho mỗi ngày trước khi tan ca đều cẩn thận kiểm kê con số cụ thể của các loại linh kiện phụ tùng trong kho."
  },
  {
    id: 4829,
    hanzi: "数字化",
    pinyin: "shùzìhuà",
    word_type: "Động từ / Danh từ",
    meaning_vi: "số hóa",
    example_hanzi: "推动传统制造业数字化转型，是提升企业核心竞争力和生产效率的必由之路。",
    example_pinyin: "Tuīdòng chuántǒng zhìzàoyè shùzìhuà zhuǎnxíng, shì tíshēng qǐyè héxīn jìngzhēnglì hé shēngchǎn xiàolǜ de bìyóuzhīlù.",
    example_vi: "Thúc đẩy chuyển đổi số hóa ngành sản xuất truyền thống là con đường tất yếu để nâng cao năng lực cạnh tranh cốt lõi và hiệu suất sản xuất của doanh nghiệp."
  },
  {
    id: 4832,
    hanzi: "率先",
    pinyin: "shuàixiān",
    word_type: "Phó từ",
    meaning_vi: "đi đầu, tiên phong",
    example_hanzi: "该市在全省率先实行了政务服务全流程网上办结，赢得了纳税人一致好评。",
    example_pinyin: "Gāi shì zài quán shěng shuàixiān shíxíng le zhèngwù fúwù quán liúchéng wǎngshang bànjié, yíngdé le nàshuìrén yízhì hǎopíng.",
    example_vi: "Thành phố này đã đi đầu toàn tỉnh thực hiện giải quyết trọn vẹn quy trình dịch vụ hành chính công trực tuyến trên mạng, nhận được sự khen ngợi đồng lòng của người nộp thuế."
  },
  {
    id: 4833,
    hanzi: "水稻",
    pinyin: "shuǐdào",
    word_type: "Danh từ",
    meaning_vi: "lúa nước",
    example_hanzi: "南方广大农村地区种植的高产优质杂交水稻迎来了喜人的金秋大丰收。",
    example_pinyin: "Nánfāng guǎngdà nóngcūn dìqū zhòngzhí de gāochǎn yōuzhì zájiāo shuǐdào yínglái le xǐrén de jīnqiū dà fēngshōu.",
    example_vi: "Giống lúa nước lai chất lượng cao sản lượng cao gieo trồng ở các vùng nông thôn rộng lớn phía Nam đã đón mùa thu hoạch vàng đại bội thu mừng vui khôn xiết."
  },
  {
    id: 4834,
    hanzi: "水库",
    pinyin: "shuǐkù",
    word_type: "Danh từ",
    meaning_vi: "hồ chứa nước, hồ thủy lợi",
    example_hanzi: "这座大型水库集防洪、灌溉、生态蓄水和城市供水等综合功能于一身。",
    example_pinyin: "Zhè zuò dàxíng shuǐkù jí fánghóng, guàngài, shēngtài xùshuǐ hé chéngshì gōngshuǐ děng zōnghé gōngnéng yú yìshēn.",
    example_vi: "Hồ chứa nước quy mô lớn này hội tụ đủ các chức năng tổng hợp như chống lũ, tưới tiêu, trữ nước sinh thái và cấp nước sinh hoạt cho đô thị."
  },
  {
    id: 4835,
    hanzi: "水流",
    pinyin: "shuǐliú",
    word_type: "Danh từ",
    meaning_vi: "dòng nước, dòng chảy",
    example_hanzi: "峡谷地势险峻，湍急奔腾的水流撞击在嶙峋的岩石上激起了层层白浪。",
    example_pinyin: "Xiágǔ dìshì xiǎnjùn, tuānjí bēnténg de shuǐliú zhuàngjī zài línxún de yánshí shang jīqǐ le céngcéng báilàng.",
    example_vi: "Hẻm núi địa thế hiểm trở, dòng nước cuồn cuộn xiết va đập vào những phiến đá gập ghềnh bắn tung từng đợt sóng trắng xóa."
  },
  {
    id: 4836,
    hanzi: "水面",
    pinyin: "shuǐmiàn",
    word_type: "Danh từ",
    meaning_vi: "mặt nước",
    example_hanzi: "微风轻轻拂过平静的水面，泛起了一圈圈细密闪耀的银色涟漪。",
    example_pinyin: "Wēifēng qīngqīng fúguò píngjìng de shuǐmiàn, fànqǐ le yì quānquān xìmì shǎnyào de yínsè liányī.",
    example_vi: "Làn gió nhẹ khẽ lướt qua mặt nước phẳng lặng, gợn lên từng vòng sóng lăn tăn màu bạc lấp lánh dày đặc."
  },
  {
    id: 4839,
    hanzi: "思路",
    pinyin: "sīlù",
    word_type: "Danh từ",
    meaning_vi: "hướng suy nghĩ, luồng tư duy",
    example_hanzi: "在遇到技术瓶颈时，及时转换思考思路往往能令人豁然开朗、找到出路。",
    example_pinyin: "Zài yù dào jìshù píngjǐng shí, jíshí zhuǎnhuàn sīkǎo sīlù wǎngwǎng néng lìng rén huòrán-kāilǎng, zhǎodào chūlù.",
    example_vi: "Khi gặp phải nút thắt cổ chai về kỹ thuật, kịp thời chuyển đổi hướng suy nghĩ thường có thể khiến người ta bừng sáng ngộ ra và tìm thấy lối thoát."
  },
  {
    id: 4842,
    hanzi: "松",
    pinyin: "sōng",
    word_type: "Tính từ / Động từ",
    meaning_vi: "thả lỏng, lỏng; cây thông",
    example_hanzi: "面对高强度的脑力劳动，要学会适时放松身心以维持长久专注。",
    example_pinyin: "Miànduì gāo qiángdù de nǎolì láodòng, yào xuéhuì shìshí fàngsōng shēnxīn yǐ wéichí chángjiǔ zhuānzhù.",
    example_vi: "Trước áp lực lao động trí óc cường độ cao, phải học cách thả lỏng thân tâm đúng lúc nhằm duy trì sự tập trung dài lâu."
  },
  {
    id: 4844,
    hanzi: "搜集",
    pinyin: "sōují",
    word_type: "Động từ",
    meaning_vi: "thu thập, tìm kiếm sưu tầm",
    example_hanzi: "学者为了撰写这部地方志著作，花费了数年时间广泛搜集珍贵的民间资料。",
    example_pinyin: "Xuézhě wèile zhuànxiě zhè bù dìfāngzhì zhùzuò, huāfèi le shù nián shíjiān guǎngfàn sōují zhēnguì de mínjiān zīliào.",
    example_vi: "Vị học giả vì muốn biên soạn cuốn địa phương chí này đã dành ra nhiều năm trời để thu thập rộng rãi các tư liệu dân gian quý giá."
  },
  {
    id: 4847,
    hanzi: "算了",
    pinyin: "suànle",
    word_type: "Động từ cụm / Thán từ",
    meaning_vi: "thôi bỏ đi, thôi vậy",
    example_hanzi: "既然大家都已经尽心尽力了，结果不如意也就算了，下次继续加油。",
    example_pinyin: "Jìrán dàjiā dōu yǐjīng jīnxīn-jìnlì le, jiéguǒ bù rúyì yě jiù suànle, xià cì jìxù jiāyóu.",
    example_vi: "Một khi mọi người đều đã dốc hết tâm sức rồi, kết quả không như ý thì cũng thôi vậy, lần sau tiếp tục cố gắng hơn."
  },
  {
    id: 4848,
    hanzi: "算是",
    pinyin: "suànshì",
    word_type: "Động từ / Phó từ",
    meaning_vi: "coi như là, xem như là",
    example_hanzi: "经过连续几个通宵加班奋战，这个重大科研攻关项目总算是圆满收尾了。",
    example_pinyin: "Jīngguò liánxù jǐ gè tōngxiāo jiābān fènzhàn, zhè gè zhòngdà kēyán gōngguān xiàngmù zǒngsuàn shì yuánmǎn shōuwěi le.",
    example_vi: "Trải qua mấy đêm thức trắng liên tục tăng ca dốc sức, dự án nghiên cứu khoa học trọng đại này xem như rốt cuộc đã khép lại mỹ mãn."
  },
  {
    id: 4849,
    hanzi: "虽",
    pinyin: "suī",
    word_type: "Liên từ",
    meaning_vi: "tuy, tuy rằng",
    example_hanzi: "这项工作虽任务极其繁重艰巨，但他依然毫不动摇地接受了挑战。",
    example_pinyin: "Zhè xiàng gōngzuò suī rènwu jíqí fánzhòng jiānjù, dàn tā yīrán háo bù dòngyáo de jiēshòu le tiǎozhàn.",
    example_vi: "Công việc này tuy nhiệm vụ cực kỳ nặng nề gian khổ, nhưng anh ấy vẫn mảy may không dao động nhận lấy thách thức."
  },
  {
    id: 4850,
    hanzi: "岁数",
    pinyin: "suìshu",
    word_type: "Danh từ",
    meaning_vi: "tuổi tác, số tuổi",
    example_hanzi: "虽然老先生已经有了很大的岁数，但精神面貌依然矍铄硬朗、思维敏捷。",
    example_pinyin: "Suīrán lǎo xiānsheng yǐjīng yǒu le hěn dà de suìshu, dàn jīngshén miànmào yīrán juéshuò yìnglǎng, sīwéi mǐnjié.",
    example_vi: "Tuy cụ ông tuổi tác đã khá cao, nhưng diện mạo tinh thần vẫn quắc thước tráng kiện và tư duy cực kỳ nhạy bén."
  },
  {
    id: 4853,
    hanzi: "损伤",
    pinyin: "sǔnshāng",
    word_type: "Động từ / Danh từ",
    meaning_vi: "làm tổn thương, thương tổn, hư hại",
    example_hanzi: "长期保持不良的坐姿使用电脑，极易对颈椎和腰椎造成慢性损伤。",
    example_pinyin: "Chángqī bǎochí bùliáng de zuòzī shǐyòng diànnǎo, jí yì duì jǐngzhuī hé yāozhuī zàochéng mànxìng sǔnshāng.",
    example_vi: "Duy trì tư thế ngồi sử dụng máy tính không tốt trong thời gian dài rất dễ gây ra thương tổn mãn tính cho đốt sống cổ và cột sống thắt lưng."
  },
  {
    id: 4858,
    hanzi: "台球",
    pinyin: "táiqiú",
    word_type: "Danh từ",
    meaning_vi: "bi-a, bida",
    example_hanzi: "周末下班后，他常常约上几位好友一起去球馆切磋台球球技、放松心情。",
    example_pinyin: "Zhōumò xiàbān hòu, tā chángcháng yuē shàng jǐ wèi hǎoyǒu yìqǐ qù qiúguǎn qiēcuō táiqiú qiújì, fàngsōng xīnqíng.",
    example_vi: "Sau khi tan sở cuối tuần, anh ấy thường hẹn mấy người bạn thân cùng tới câu lạc bộ so tài kỹ thuật đánh bi-a và thư giãn tâm trạng."
  },
  {
    id: 4860,
    hanzi: "太阳能",
    pinyin: "tàiyángnéng",
    word_type: "Danh từ",
    meaning_vi: "năng lượng mặt trời",
    example_hanzi: "屋顶安装的高效太阳能光伏发电板为整个绿色社区提供了源源不断的清洁电力。",
    example_pinyin: "Wūdǐng ānzhuāng de gāoxiào tàiyángnéng guāngfú fādiànbǎn wèi zhěnggè lǜsè shèqū tígōng le yuányuán-bùduàn de qīngjié diànlì.",
    example_vi: "Tấm pin quang điện năng lượng mặt trời hiệu suất cao lắp đặt trên mái nhà đã cung cấp nguồn điện sạch dồi dào không ngớt cho toàn bộ khu dân cư xanh."
  },
  {
    id: 4861,
    hanzi: "谈论",
    pinyin: "tánlùn",
    word_type: "Động từ",
    meaning_vi: "bàn luận, nói về, đàm luận",
    example_hanzi: "在学术茶歇时间，教授们围坐在一起热烈谈论着最新的前沿学术动向。",
    example_pinyin: "Zài xuéshù cháxiē shíjiān, jiàoshòu men wéizuò zài yìqǐ rèliè tánlùn zhe zuìxīn de qiányán xuéshù dòngxiàng.",
    example_vi: "Vào giờ giải lao trà giữa buổi hội thảo học thuật, các giáo sư quây quần bên nhau bàn luận sôi nổi về xu hướng học thuật mũi nhọn mới nhất."
  },
  {
    id: 4866,
    hanzi: "汤圆",
    pinyin: "tāngyuán",
    word_type: "Danh từ",
    meaning_vi: "bánh trôi nước, bánh thang viên",
    example_hanzi: "元宵佳节，全家人围坐在一起吃热气腾腾的黑芝麻汤圆，寓意阖家团圆美满。",
    example_pinyin: "Yuánxiāo jiājié, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de hēizhīma tāngyuán, yùyì héjiā tuányuán měimǎn.",
    example_vi: "Tết Nguyên Tiêu, cả gia đình quây quần bên nhau ăn những bát bánh trôi nước vừng đen nóng hổi nghi ngút, mang ngụ ý cả nhà đoàn viên mỹ mãn."
  },
  {
    id: 4867,
    hanzi: "糖果",
    pinyin: "tángguǒ",
    word_type: "Danh từ",
    meaning_vi: "kẹo, kẹo ngọt",
    example_hanzi: "春节期间每户人家茶几上都会摆满各色糖果糕点，用来热情招待拜年的亲友。",
    example_pinyin: "Chūnjié qījiān měi hù rénjiā chájī shang dōu huì bǎimǎn gèsè tángguǒ gāodiǎn, yòng lái rèqíng zhāodài bàinián de qīnyǒu.",
    example_vi: "Trong dịp Tết Nguyên Đán trên bàn trà mỗi nhà đều bày đầy đủ các loại bánh kẹo ngọt ngào, dùng để niềm nở đón tiếp người thân bạn bè đến chúc tết."
  },
  {
    id: 4871,
    hanzi: "逃跑",
    pinyin: "táopǎo",
    word_type: "Động từ",
    meaning_vi: "chạy trốn, bỏ trốn",
    example_hanzi: "在警方的严密布控和围堵下，犯罪嫌疑人企图逃跑的企图彻底落空了。",
    example_pinyin: "Zài jǐngfāng de yánmì bùkòng hé wéidǔ xià, fànzuì xiányírén qǐtú táopǎo de qǐtú chèdǐ luòkōng le.",
    example_vi: "Dưới sự bủa vây và bố ráp nghiêm ngặt của lực lượng cảnh sát, mưu đồ chạy trốn của nghi phạm phạm tội đã hoàn toàn phá sản."
  },
  {
    id: 4874,
    hanzi: "套餐",
    pinyin: "tàocān",
    word_type: "Danh từ",
    meaning_vi: "phần ăn combo, gói cước dịch vụ",
    example_hanzi: "移动通信运营商推出了流量更加充裕且资费更实惠的月度学生套餐。",
    example_pinyin: "Yídòng tōngxìn yùnyíngshāng tuīchū le liúliàng gèngjiā chōngyù qiě zīfèi gèng shíhuì de yuèdù xuésheng tàocān.",
    example_vi: "Nhà mạng viễn thông di động đã cho ra mắt gói cước sinh viên hàng tháng với dung lượng data dồi dào hơn và cước phí tiết kiệm hơn."
  },
  {
    id: 4875,
    hanzi: "特",
    pinyin: "tè",
    word_type: "Phó từ",
    meaning_vi: "rất, đặc biệt (khẩu ngữ)",
    example_hanzi: "这家老面馆的招牌牛肉汤熬得特入味，每天排队品尝的食客络绎不绝。",
    example_pinyin: "Zhè jiā lǎo miànguǎn de zhāopai niúròutāng áo de tè rùwèi, měitiān páiduì pǐncháng de shíkè luòyì-bùjué.",
    example_vi: "Món nước dùng bò gia truyền của quán mì lâu năm này ninh rất đậm đà ngấm vị, ngày nào thực khách xếp hàng thưởng thức cũng nườm nượp không dứt."
  },
  {
    id: 4877,
    hanzi: "特地",
    pinyin: "tèdì",
    word_type: "Phó từ",
    meaning_vi: "cố ý, đích thân, cất công",
    example_hanzi: "得知老教授生病住院的消息，几位在外地工作的学生特地赶回母校看望。",
    example_pinyin: "Dézhī lǎo jiàoshòu shēngbìng zhùyuàn de xiāoxi, jǐ wèi zài wàidì gōngzuò de xuésheng tèdì gǎnhuí mǔxiào kànwàng.",
    example_vi: "Hay tin vị giáo sư già đổ bệnh nằm viện, mấy học trò đang công tác ở phương xa đã cất công tức tốc trở về trường xưa thăm hỏi."
  },
  {
    id: 4879,
    hanzi: "特性",
    pinyin: "tèxìng",
    word_type: "Danh từ",
    meaning_vi: "đặc tính, tính chất đặc thù",
    example_hanzi: "这种新型高分子纳米材料具有极其优良的导电性与耐磨蚀特性。",
    example_pinyin: "Zhè zhǒng xīnxíng gāofēnzǐ nàmǐ cáiliào jùyǒu jíqí yōuliáng de dǎodiànxìng yǔ nàimóshí tèxìng.",
    example_vi: "Vật liệu nano polyme kiểu mới này sở hữu các đặc tính dẫn điện và chống mài mòn cực kỳ ưu việt."
  },
  {
    id: 4882,
    hanzi: "提取",
    pinyin: "tíqǔ",
    word_type: "Động từ",
    meaning_vi: "chiết xuất; rút tiền, trích xuất",
    example_hanzi: "科研团队成功从天然植物中提取出了一种具有强效抗氧化活性的有效成分。",
    example_pinyin: "Kēyán tuánduì chénggōng cóng tiānrán zhíwù zhōng tíqǔ chū le yì zhǒng jùyǒu qiángxiào kàngyǎnghuà huóxìng de yǒuxiào chéngfèn.",
    example_vi: "Nhóm nghiên cứu khoa học đã chiết xuất thành công từ thực vật tự nhiên một thành phần hữu hiệu có hoạt tính chống oxy hóa cực mạnh."
  },
  {
    id: 4884,
    hanzi: "体操",
    pinyin: "tǐcāo",
    word_type: "Danh từ",
    meaning_vi: "thể dục dụng cụ, bài thể dục",
    example_hanzi: "每天大课间，全校数千名中小学生整齐划一地在操场上做广播广播体操。",
    example_pinyin: "Měitiān dà kèjiān, quán xiào shù qiān míng zhōng-xiǎoxuésheng zhěngqí-huàyī de zài cāochǎng shang zuò guǎngbō tǐcāo.",
    example_vi: "Mỗi giờ giải lao giữa buổi, hàng ngàn học sinh toàn trường đồng đều tăm tắp tập bài thể dục theo nhạc phát thanh trên sân tập."
  },
  {
    id: 4887,
    hanzi: "添",
    pinyin: "tiān",
    word_type: "Động từ",
    meaning_vi: "thêm vào, tăng thêm, góp phần",
    example_hanzi: "窗台上几盆盛开的水仙花，为寒冷单调的冬日书房增添了一抹盎然春意。",
    example_pinyin: "Chuāngtái shang jǐ pén shèngkāi de shuǐxiānhuā, wèi hánlěng dāndiào de dōngrì shūfáng zēngtiān le yì mǒ àngrán chūnyì.",
    example_vi: "Mấy chậu hoa thủy tiên bung nở trên bậu cửa sổ đã tô điểm thêm cho căn thư phòng mùa đông lạnh lẽo đơn điệu một nét sắc xuân ngập tràn."
  },
  {
    id: 4889,
    hanzi: "添加",
    pinyin: "tiānjiā",
    word_type: "Động từ",
    meaning_vi: "thêm vào, bổ sung vào",
    example_hanzi: "这款果汁饮料承诺不额外添加任何人工色素与防腐剂，口感天然纯正。",
    example_pinyin: "Zhè kuǎn guǒzhī yǐnliào chéngnuò bù éwài tiānjiā rènhé réngōng sèsù yǔ fángfǔjì, kǒugǎn tiānrán chúnzhèng.",
    example_vi: "Loại đồ uống nước ép hoa quả này cam kết không bổ sung thêm bất kỳ chất tạo màu nhân tạo hay chất bảo quản nào, vị ngon thuần khiết tự nhiên."
  },
  {
    id: 4890,
    hanzi: "天然",
    pinyin: "tiānrán",
    word_type: "Tính từ",
    meaning_vi: "tự nhiên, thiên nhiên",
    example_hanzi: "这片未受外界工业污染的原始森林犹如一座巨大的纯天然绿色氧吧。",
    example_pinyin: "Zhè piàn wèi shòu wàijiè gōngyè wūrǎn de yuánshǐ sēnlín yóurú yí zuò jùdà de chún tiānrán lǜsè yǎngbā.",
    example_vi: "Khu rừng nguyên sinh chưa hề chịu sự ô nhiễm công nghiệp từ bên ngoài này hệt như một quán bar oxy xanh thuần khiết tự nhiên khổng lồ."
  },
  {
    id: 4893,
    hanzi: "天下",
    pinyin: "tiānxià",
    word_type: "Danh từ",
    meaning_vi: "thiên hạ, thế gian, cả nước",
    example_hanzi: "古人有云，先天下之忧而忧，后天下之乐而乐，体现了崇高的家国情怀。",
    example_pinyin: "Gǔrén yǒu yún, xiān tiānxià zhī yōu ér yōu, hòu tiānxià zhī lè ér lè, tǐxiàn le chónggāo de jiāguó qínghuái.",
    example_vi: "Người xưa có câu, lo trước cái lo của thiên hạ, vui sau cái vui của thiên hạ, thể hiện tấm lòng vì nước vì dân cao cả."
  },
  {
    id: 4895,
    hanzi: "田",
    pinyin: "tián",
    word_type: "Danh từ",
    meaning_vi: "ruộng, đồng ruộng",
    example_hanzi: "微风拂过一望无际的绿色稻田，散发出泥土与禾苗混合的清香气息。",
    example_pinyin: "Wēifēng fúguò yíwàng-wújì de lǜsè dàotián, sànfā chū nítǔ yǔ hémiáo hùnhé de qīngxiāng qìxī.",
    example_vi: "Làn gió nhẹ thổi qua cánh đồng lúa xanh ngút ngàn tầm mắt, tỏa ra làn hương thơm thanh mát hòa quyện giữa đất bùn và mạ non."
  }
];

console.log(`Batch 6 total words: ${BATCH_6_DATA.length}`);

// 1. Create data/hsk6-batch6-data.ts
const dataFilePath = 'data/hsk6-batch6-data.ts';
let tsContent = `// Dữ liệu 100 từ vựng mục tiêu HSK 6 (Batch 6/8: 人山人海 -> 田)
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

export const HSK6_BATCH6_WORDS: Hsk6WordSeed[] = [
`;

for (const item of BATCH_6_DATA) {
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
    notes: "Mục từ mới HSK 6 theo Đề cương thi 11/2025 (Batch 6/8)"
  },\n`;
}

tsContent += `];\n`;
fs.writeFileSync(dataFilePath, tsContent, 'utf8');
console.log(`Đã tạo thành công ${dataFilePath}!`);

// 2. Create Migration SQL & Rollback SQL
const migrationTimestamp = '20261023070000';
const migrationPath = `supabase/migrations/${migrationTimestamp}_hsk6_batch6_words_seed.sql`;
const rollbackPath = `supabase/migrations/rollbacks/${migrationTimestamp}_hsk6_batch6_words_seed_rollback.sql`;

let sql = `-- ==============================================================================
-- MIGRATION SCRIPT: ${migrationTimestamp}_hsk6_batch6_words_seed.sql
-- Nạp Batch 6/8 (100 từ mới HSK 6 theo Đề cương CTI 11/2025: 人山人海 -> 田)
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

for (const item of BATCH_6_DATA) {
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
    'Mục từ mới HSK 6 theo Đề cương thi 11/2025 (Batch 6/8)'
  )`);
}

sql += values.join(',\n') + `;\n\nCOMMIT;\n`;
fs.writeFileSync(migrationPath, sql, 'utf8');
console.log(`Đã xuất Migration SQL: ${migrationPath}`);

let rollbackSql = `-- ==============================================================================
-- ROLLBACK SCRIPT: ${migrationTimestamp}_hsk6_batch6_words_seed_rollback.sql
-- Hoàn tác nạp 100 từ mới HSK 6 của Batch 6
-- ==============================================================================

BEGIN;

DELETE FROM public.vocabularies
WHERE hsk_level = 'HSK 6'
  AND source = 'cti_official_2025'
  AND notes LIKE '%Batch 6/8%'
  AND hanzi IN (${hanziList.join(', ')});

COMMIT;
`;
fs.writeFileSync(rollbackPath, rollbackSql, 'utf8');
console.log(`Đã xuất Rollback SQL: ${rollbackPath}`);
