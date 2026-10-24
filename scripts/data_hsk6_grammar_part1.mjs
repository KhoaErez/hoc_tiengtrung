// ==============================================================================
// DATA: data_hsk6_grammar_part1.mjs
// HSK 6 GRAMMAR - PART 1: ĐIỂM 1 ĐẾN 31 (CHUẨN GF 0025-2021 APPENDIX A)
// Đại từ văn ngôn cổ nhã, Xưng hô ngoại giao nghi lễ, Lượng từ thi ca & nghệ thuật HSK 6
// ==============================================================================

export const HSK6_GRAMMAR_PART1 = [
  {
    order_index: 1,
    name: 'Đại từ văn ngôn tân ngữ & sở thuộc "之" (Nó / Của nó / Họ / Điều đó)',
    pattern: 'Động từ + 之 / Danh từ + 之 + Danh từ / 之所以...是因为... / ...之一 / 忘之 / 避之不及',
    category: 'Đại từ',
    explanation_vi: '"之" (zhī) là một trong những hư từ văn ngôn quan trọng nhất trong tiếng Trung cổ và hiện đại. Trong HSK 6, "之" đóng vai trò đại từ làm tân ngữ trực tiếp thay thế cho người, vật hoặc sự việc vừa được nhắc tới (tương đương với "他/她/它" hoặc "他们"). Ngoài ra "之" làm trợ từ sở thuộc tương đương "的", xuất hiện trong các cấu trúc kinh điển như "之所以...是因为...", "取之于民，用之于民".',
    examples: [
      {
        chinese: '优秀的文化传统是民族的血脉，我们应当倍加珍惜之、弘扬之。',
        pinyin: 'Yōuxiù de wénhuà chuántǒng shì mínzú de xuèmài, wǒmen yīngdāng bèijiā zhēnxī zhī, hóngyáng zhī.',
        translation_vi: 'Truyền thống văn hóa xuất sắc là huyết mạch của dân tộc, chúng ta cần phải hết sức trân trọng nó, phát huy nó.',
        explanation: '"珍惜之、弘扬之" dùng "之" làm tân ngữ thay thế trực tiếp cho "优秀的文化传统", mang lại nhịp điệu biền ngẫu trang nghiêm.'
      },
      {
        chinese: '政府设立这项专项基金的根本初衷，就在于取之于民并全额用之于民。',
        pinyin: 'Zhèngfǔ shèlì zhè xiàng zhuānxiàng jījīn de gēnběn chūzhōng, jiù zàiyú qǔ zhī yú mín bìng quán\'é yòng zhī yú mín.',
        translation_vi: 'Ý định ban đầu căn bản của chính phủ khi thành lập quỹ chuyên dùng này chính là lấy của dân và dùng toàn bộ phục vụ nhân dân.',
        explanation: '"取之于民，用之于民" là châm ngôn quản trị quốc gia kinh điển thể hiện trách nhiệm tài chính công đối với nhân dân.'
      }
    ]
  },
  {
    order_index: 2,
    name: 'Đại từ nhân xưng & chỉ thị văn ngôn "尔" (Ngươi / Mày / Như thế / Thế thôi)',
    pattern: '尔等 (các ngươi) / 尔后 (sau đó) / 不过尔尔 (chẳng qua chỉ có vậy)',
    category: 'Đại từ',
    explanation_vi: '"尔" (ěr) là đại từ nhân xưng ngôi thứ hai văn ngôn (ngươi, các ngươi) hoặc mang nghĩa chỉ thị "như thế, ngần ấy" (tương đương "如此, 罢了"). Thành ngữ HSK 6 "不过尔尔" miêu tả sự vật tầm thường, bình thường chẳng qua chỉ đến thế mà thôi.',
    examples: [
      {
        chinese: '原以为这家号称百年老字号的餐馆菜肴非同凡响，实地品尝后才发现水平不过尔尔。',
        pinyin: 'Yuán yǐwéi zhè jiā hàochēng bǎinián lǎozìhào de cānguǎn càiyáo fēitóngfánxiǎng, shídì pǐncháng hòu cái fāxiàn shuǐpíng búguò\'ěr\'ěr.',
        translation_vi: 'Cứ ngỡ món ăn của nhà hàng tự xưng trăm năm danh tiếng này xuất chúng phi phàm, sau khi thưởng thức thực tế mới phát hiện trình độ cũng chỉ bình thường đến thế mà thôi.',
        explanation: '"不过尔尔" thể hiện sự thất vọng tinh tế đối với chất lượng không tương xứng với danh tiếng đồn thổi.'
      },
      {
        chinese: '双方就停火协议达成初步共识，尔后将展开关于战后重建细节的深入磋商。',
        pinyin: 'Shuāngfāng jiù tínghuǒ xiéyì dáchéng chūbù gòngshí, ěrhòu jiāng zhǎnkāi guānyú zhànhòu chóngjiàn xìjié de shēnrù cuōshāng.',
        translation_vi: 'Đôi bên đã đạt được đồng thuận sơ bộ về thỏa thuận ngừng bắn, sau đó sẽ triển khai tham vấn sâu rộng về các chi tiết tái thiết hậu chiến.',
        explanation: '"尔后" là từ nối văn ngôn trang trọng biểu thị mốc thời gian nối tiếp tương đương với "此后, 以后".'
      }
    ]
  },
  {
    order_index: 3,
    name: 'Đại từ văn ngôn chỉ định tập hợp số nhiều "诸" (Chư / Các / Mọi)',
    pattern: '诸 + Danh từ / 诸位 / 诸如此类 / 付诸实施 / 付诸东流',
    category: 'Đại từ',
    explanation_vi: '"诸" (zhū) có hai công năng cốt lõi trong HSK 6: 1) Đại từ văn ngôn chỉ số nhiều (các, chư, nhiều), như 诸位 (chư vị), 诸子百家 (chư tử bách gia), 诸事 (mọi việc); 2) Kiêm từ văn ngôn gộp của "之于" (đối với nó, vào đó) trong các kết cấu: 付诸实施 (đưa vào thực thi), 付诸东流 (đổ sông đổ biển).',
    examples: [
      {
        chinese: '宏伟的规划如果仅仅停留在纸面上而不付诸实施，终究不过是一纸空谈。',
        pinyin: 'Hóngwěi de guīhuà rúguǒ jǐnjǐn tíngliú zài zhǐmiàn shang ér bú fù zhū shíshī, zhōngjiū búguò shì yì zhǐ kōngtán.',
        translation_vi: 'Quy hoạch hùng vĩ nếu như chỉ dừng lại trên mặt giấy tờ mà không đưa vào thực thi, rốt cuộc cũng chẳng qua chỉ là một tờ giấy sáo rỗng.',
        explanation: '"付诸实施" mang cấu trúc "付之于实施" (đem nó áp dụng vào thực tiễn), là quán dụng ngữ chính trị cao cấp.'
      },
      {
        chinese: '商场里摆满了智能手表、无线耳机、扫地机器人诸如此类的高科技消费品。',
        pinyin: 'Shāngchǎng lǐ bǎimǎn le zhìnéng shǒubiǎo, wúxiàn ěrjī, sǎodì jīqìrén zhū rúcǐ lèi de gāo kējì xiāofèipǐn.',
        translation_vi: 'Trong trung tâm thương mại bày đầy đồng hồ thông minh, tai nghe không dây, robot hút bụi cùng các loại sản phẩm tiêu dùng công nghệ cao đại loại như thế.',
        explanation: '"诸如此类" là thành ngữ ngữ pháp hóa liệt kê đại từ tương đương với "等等此类" (các loại như vậy).'
      }
    ]
  },
  {
    order_index: 4,
    name: 'Đại từ xưng hô tôn kính ngoại giao đỉnh cao "阁下" (Các hạ / Ngài)',
    pattern: '阁下 + Lời chào nghi lễ / Tổng thống / Thủ tướng + 阁下',
    category: 'Đại từ',
    explanation_vi: '"阁下" (géxià) là đại từ xưng hô nghi lễ ngoại giao cấp cao nhất dành cho nguyên thủ quốc gia, thủ tướng, đại sứ đặc mệnh toàn quyền hoặc các yếu nhân quốc tế (Các hạ, Kính thưa Ngài).',
    examples: [
      {
        chinese: '尊敬的总统阁下，我谨代表全体中国人民向您及贵国人民致以最诚挚的祝贺。',
        pinyin: 'Zūnjìng de zǒngtǒng géxià, wǒ jǐn dàibiǎo quántǐ Zhōngguó rénmín xiàng nín jí guìguó rénmín zhìyǐ zuì chéngzhì de zhùhè.',
        translation_vi: 'Kính thưa Tổng thống Các hạ, tôi xin trân trọng đại diện cho toàn thể nhân dân Trung Quốc gửi tới Ngài cùng nhân dân quý quốc lời chúc mừng chân thành nhất.',
        explanation: '"总统阁下" là nghi thức xưng hô ngoại giao nguyên thủ quốc gia tối cao theo công pháp quốc tế.'
      },
      {
        chinese: '大使阁下在任期内为增进两国人民之间的传统友谊作出了不可磨灭的历史贡献。',
        pinyin: 'Dàshǐ géxià zài rènqī nèi wèi zēngjìn liǎng guó rénmín zhījiān de chuántǒng yǒuyì zuòchū le bùkě mómì de lìshǐ gòngxiàn.',
        translation_vi: 'Đại sứ Các hạ trong nhiệm kỳ của mình đã đóng góp những cống hiến lịch sử không thể phai mờ vào việc thắt chặt tình hữu nghị truyền thống giữa nhân dân hai nước.',
        explanation: '"大使阁下" thể hiện sự tôn vinh cao quý dành cho vị trưởng đoàn ngoại giao nước bạn.'
      }
    ]
  },
  {
    order_index: 5,
    name: 'Cụm đại từ văn ngôn bao quát tổng kết "凡此种种" (Phàm tất thảy những điều đó)',
    pattern: 'Liệt kê các hiện tượng phức tạp... 凡此种种, 皆 / 都 + Kết luận quy nạp',
    category: 'Đại từ',
    explanation_vi: '"凡此种种" (fán cǐ zhǒngzhǒng) là cụm từ văn ngôn quy nạp độc lập đứng ở đầu phân câu kết luận, có nghĩa là "phàm tất thảy những hiện tượng, nguyên nhân đa dạng vừa được liệt kê ở trên". Dùng để thâu tóm toàn bộ dữ kiện thành một nhận định bản chất.',
    examples: [
      {
        chinese: '缺乏科学规划、盲目投资扩张、内部管理松懈，凡此种种，最终导致了企业的破产重组。',
        pinyin: 'Quēfá kēxué guīhuà, mángmù tóuzī kuòzhāng, nèibù guǎnlǐ sōngxiè, fán cǐ zhǒngzhǒng, zuìzhōng dǎozhì le qǐyè de pòchǎn chóngzǔ.',
        translation_vi: 'Thiếu quy hoạch khoa học, mù quáng đầu tư bành trướng, quản lý nội bộ lỏng lẻo, phàm tất thảy những điều đó, cuối cùng đã dẫn tới việc doanh nghiệp phá sản tái cơ cấu.',
        explanation: '"凡此种种" thâu tóm toàn bộ 3 căn nguyên sai lầm quản trị dẫn tới kết cục sụp đổ của công ty.'
      },
      {
        chinese: '民俗文化的传承、民间工艺的保护、非遗技艺的弘扬，凡此种种，皆需要全社会共同关注。',
        pinyin: 'Mínsú wénhuà de chuánchéng, mínjiān gōngyì de bǎohù, fēiyí jìyì de hóngyáng, fán cǐ zhǒngzhǒng, jiē xūyào quán shèhuì gòngtóng guānzhù.',
        translation_vi: 'Sự kế thừa văn hóa dân gian, sự bảo tồn nghề thủ công làng quê, sự phát huy kỹ nghệ phi vật thể, phàm tất cả những điều đó, đều cần sự chung tay quan tâm của toàn xã hội.',
        explanation: '"凡此种种，皆需要..." quy nạp các nhánh di sản văn hóa vào mối quan tâm chung của toàn dân.'
      }
    ]
  },
  {
    order_index: 6,
    name: 'Danh lượng từ thi ca chỉ làn, luồng tơ mỏng manh "缕" (Làn / Luồng / Sợi / Tia)',
    pattern: 'Số từ + 缕 + Danh từ (清风 / 阳光 / 炊烟 / 哀思 / 思绪 / 幽香)',
    category: 'Lượng từ',
    explanation_vi: '"缕" (lǚ) là lượng từ thi ca cực kỳ tinh tế, dùng cho: 1) Các hiện tượng tự nhiên thanh thoát, nhẹ nhàng như sợi tơ (một làn gió mát, một luồng khói bếp, một tia nắng sớm); 2) Cảm xúc, tâm tư hoặc nỗi niềm vương vấn trong lòng (một niềm tiếc thương, một mối tơ lòng).',
    examples: [
      {
        chinese: '清晨，一缕金色的阳光穿过茂密的松林，在青翠的草地上洒下了斑驳的林荫。',
        pinyin: 'Qīngchén, yì lǚ jīnsè de yángguāng chuānguò màomì de sōnglín, zài qīngcuì de cǎodì shang sǎxià le bānbó de línyīn.',
        translation_vi: 'Sáng sớm, một tia nắng vàng rực rỡ xuyên qua rừng thông rậm rạp, rọi bóng cây lốm đốm xuống thảm cỏ xanh mướt.',
        explanation: '"一缕金色的阳光" dùng "缕" đặc tả tia nắng mai mềm mại xuyên qua kẽ lá.'
      },
      {
        chinese: '微风徐徐吹过湖面，送来了一缕沁人心脾的荷花幽香。',
        pinyin: 'Wēifēng xúxú chuīguò húmiàn, sònglái le yì lǚ qìnrénxīnpí de héhuā yōuxiāng.',
        translation_vi: 'Làn gió nhẹ từ từ lướt qua mặt hồ, mang theo một làn hương hoa sen thanh tao làm mát tận lòng người.',
        explanation: '"一缕...荷花幽香" định lượng cho làn hương sen thoang thoảng dịu êm.'
      }
    ]
  },
  {
    order_index: 7,
    name: 'Danh lượng từ hội họa chỉ vệt màu, nét cười "抹" (Vệt / Vạt / Nét)',
    pattern: 'Số từ + 抹 + Danh từ (晚霞 / 微笑 / 斜阳 / 亮色 / 忧伤)',
    category: 'Lượng từ',
    explanation_vi: '"抹" (mǒ) có nguồn gốc từ động từ quệt màu, quét sơn trong hội họa. Khi làm lượng từ, "抹" chuyên dùng cho những mảng màu sắc trên nền trời tự nhiên (như 一抹晚霞 - một vạt ráng chiều) hoặc biểu cảm thoảng qua trên khuôn mặt con người (như 一抹微笑 - một nét cười thoáng qua).',
    examples: [
      {
        chinese: '夕阳西下，天边残留着一抹绚烂如锦的火红晚霞。',
        pinyin: 'Xīyáng xīxià, tiānbiān cánliúzhe yì mǒ xuànlàn rújǐn de huǒhóng wǎnxiá.',
        translation_vi: 'Mặt trời lặn về tây, nơi chân trời còn sót lại một vạt ráng chiều đỏ rực rỡ đẹp tựa gấm thêu.',
        explanation: '"一抹...晚霞" dùng "抹" định lượng cho dải mây chiều lộng lẫy nơi góc trời hoàng hôn.'
      },
      {
        chinese: '得知考试合格的好消息，她紧绷的嘴角边终于浮现出了一抹舒心的微笑。',
        pinyin: 'Dézhī kǎoshì hégé de hǎo xiāoxi, tā jǐnbēng de zuǐjiǎobiān zhōngyú fúxiàn chū le yì mǒ shūxīn de wēixiào.',
        translation_vi: 'Được tin kỳ thi đã qua môn, khóe miệng đang căng thẳng của cô cuối cùng đã hé nở một nét cười thanh thản.',
        explanation: '"一抹舒心的微笑" miêu tả nét cười nhẹ nhõm thoáng hiện trên nét mặt xua tan lo lắng.'
      }
    ]
  },
  {
    order_index: 8,
    name: 'Danh lượng từ nghệ thuật cổ chỉ bức tranh cuộn trục "轴" (Trục / Cuộn / Bức tranh cuộn)',
    pattern: 'Số từ + 轴 + Danh từ (画卷 / 山水画 / 长卷 / 史诗)',
    category: 'Lượng từ',
    explanation_vi: '"轴" (zhóu) là lượng từ chuyên dùng cho tranh thủy mạc, tranh thư pháp cổ truyền Trung Hoa được gắn trục cuốn lại thành cuộn dài (như 一轴山水画 - một bức tranh cuộn sơn thủy, 一轴长卷). Thường dùng ẩn dụ cho bức tranh lịch sử hào hùng (như 一轴波澜壮阔的历史画卷).',
    examples: [
      {
        chinese: '展厅正中央徐徐展开了一轴传世千年的北宋青绿山水古画长卷。',
        pinyin: 'Zhǎntīng zhèng zhōngyāng xúxú zhǎnkāi le yì zhóu chuánshì qiānnián de Běisòng qīnglǜ shānshuǐ gǔhuà chángjuàn.',
        translation_vi: 'Chính giữa phòng triển lãm từ từ mở ra một cuộn tranh dài sơn thủy thanh lục thời Bắc Tống truyền đời ngàn năm.',
        explanation: '"一轴...古画长卷" dùng "轴" định lượng cho bức thư họa cổ trang quý báu cuộn trên trục gỗ.'
      },
      {
        chinese: '新时代的发展进程宛如一轴波澜壮阔的历史宏伟长卷，记录着人民奋斗的足迹。',
        pinyin: 'Xīn shídài de fāzhǎn jìnchéng wǎnrú yì zhóu bōlánzhuàngkuò de lìshǐ hóngwěi chángjuàn, jìlùzhe rénmín fèndòu de zújì.',
        translation_vi: 'Tiến trình phát triển của thời đại mới ví tựa một bức tranh cuộn lịch sử tráng lệ sóng gió muôn trùng, ghi lại những dấu chân phấn đấu của nhân dân.',
        explanation: '"一轴...历史画卷" dùng "轴" theo nghĩa ẩn dụ thi ca tôn vinh sự nghiệp đổi mới của đất nước.'
      }
    ]
  },
  {
    order_index: 9,
    name: 'Danh lượng từ điện ảnh & nhiếp ảnh chỉ khung hình "帧" (Khung hình / Tấm)',
    pattern: 'Số từ + 帧 + Danh từ (画面 / 胶片 / 照片 / 影像)',
    category: 'Lượng từ',
    explanation_vi: '"帧" (zhēn) là lượng từ chuyên môn trong nghệ thuật điện ảnh, truyền hình số và nhiếp ảnh, biểu thị một khung hình ảnh đơn lẻ (frame) trong một chuỗi phim chuyển động hoặc một bức ảnh nghệ thuật tĩnh vật cao cấp (như 一帧画面, 每一帧 đều là kiệt tác).',
    examples: [
      {
        chinese: '这部纪录片的拍摄构图极其考究，可以说电影里的每一帧画面都美得令人窒息。',
        pinyin: 'Zhè bù jìlùpiàn de pāishè gòutú jíqí kǎojiu, kěyǐ shuō diànyǐng lǐ de měi yì zhēn huàmiàn dōu měi de lìngrénzhìxī.',
        translation_vi: 'Bố cục quay phim của bộ phim tài liệu này cực kỳ tinh tế, có thể nói từng khung hình trong phim đều đẹp đến ngạt thở.',
        explanation: '"每一帧画面" ca ngợi nghệ thuật thị giác đỉnh cao của tác phẩm điện ảnh.'
      },
      {
        chinese: '高速摄像机以每秒一千帧的惊人速度，清晰捕捉到了雨滴落入水面的微观瞬间。',
        pinyin: 'Gāosù shèxiàngjī yǐ měi miǎo yìqiān zhēn de jīngrén sùdù, qīngxī bǔzhuō dào le yǔdī luòrù shuǐmiàn de wēiguān shùnjiān.',
        translation_vi: 'Chiếc máy quay tốc độ cao với tốc độ đáng kinh ngạc 1000 khung hình/giây đã bắt trọn rõ nét khoảnh khắc vi mô hạt mưa rơi chạm mặt nước.',
        explanation: '"每秒一千帧" dùng "帧" làm đơn vị đo lường tần số quét khung hình công nghệ cao.'
      }
    ]
  },
  {
    order_index: 10,
    name: 'Danh lượng từ y học cổ truyền chỉ liều, thang thuốc "剂" (Liều / Thang / Liều thuốc)',
    pattern: 'Số từ + 剂 + Danh từ (良药 / 补药 / 强心针 / 疫苗 / 镇静剂)',
    category: 'Lượng từ',
    explanation_vi: '"剂" (jì) là lượng từ y dược chuyên dùng cho một thang thuốc thang hoàn chỉnh, một liều vắc-xin tiêm chủng (như 一剂疫苗), hoặc dùng theo nghĩa ẩn dụ triết học cho một lời khuyên chân thành thức tỉnh con người (như 一剂良药 - một liều thuốc tốt đắng miệng, 一剂强心针 - một liều thuốc trợ tim cổ vũ tinh thần).',
    examples: [
      {
        chinese: '这篇针砭时弊的犀利评论宛如一剂苦口良药，振聋发聩地警醒了迷茫中的年轻人。',
        pinyin: 'Zhè piān zhēnbiānshíbì de xīlì pínglùn wǎnrú yí jì kǔkǒu liángyào, zhènlóngfākuì de jǐngxǐng le mímáng zhōng de niánqīngrén.',
        translation_vi: 'Bài bình luận sắc sảo châm thẳng vào tệ nạn thời thế này ví tựa một thang thuốc đắng dã tật, đã gióng lên hồi chuông cảnh tỉnh người trẻ đang hoang mang lạc lối.',
        explanation: '"一剂苦口良药" dùng "剂" ẩn dụ cho bài học đạo đức nghiêm khắc nhưng cứu rỗi nhận thức.'
      },
      {
        chinese: '政府及时出台的减税降费纾困政策，为陷入低谷的实体经济注入了一剂强心针。',
        pinyin: 'Zhèngfǔ jíshí chūtái de jiǎnshuì jiàngfèi shūkùn zhèngcè, wèi xiànrù dīgǔ de shítǐ jīngjì zhùrù le yí jì qiángxīnzhēn.',
        translation_vi: 'Chính sách giảm thuế hạ phí tháo gỡ khó khăn kịp thời của chính phủ đã tiêm một liều thuốc trợ tim cho nền kinh tế thực thể đang chìm trong đáy vực.',
        explanation: '"注入了一剂强心针" là lối nói kinh tế quen thuộc chỉ gói kích thích tài khóa cứu nguy doanh nghiệp.'
      }
    ]
  },
  {
    order_index: 11,
    name: 'Danh lượng từ thi ca cổ điển chỉ bài từ, khúc hát "阕" (Khúc / Bài từ / Bài ca)',
    pattern: 'Số từ + 阕 + Danh từ (宋词 / 词 / 乐曲 / 绝唱)',
    category: 'Lượng từ',
    explanation_vi: '"阕" (què) là lượng từ văn học cổ điển chuyên biệt dành riêng cho các bài Tống từ (宋词) hoặc các khúc nhạc điệu nhã nhạc cung đình (như 一阕宋词, 上阕, 下阕). Thể hiện phong thái uyên bác, phong lưu của học giả văn phong cổ điển.',
    examples: [
      {
        chinese: '在中秋皓月当空之夜，文人墨客常常轻吟苏东坡那阕千古流传的水调歌头。',
        pinyin: 'Zài zhōngqiū hàoyuè dāngkōng zhī yè, wénrénmòkè chángcháng qīngyín Sū Dōngpō nà què qiāngǔ liúchuán de Shuǐdiàogētóu.',
        translation_vi: 'Vào đêm trung thu trăng sáng vằng vặc trên không trung, các bậc văn nhân thi sĩ thường ngâm nga bài từ "Thủy Điệu Ca Đầu" truyền tụng ngàn thu của Tô Đông Pha.',
        explanation: '"那一阕...水调歌头" dùng "阕" làm lượng từ chuẩn mực cao quý cho kiệt tác Tống từ.'
      },
      {
        chinese: '古琴名家抚琴弹奏了一阕清幽旷远的古曲，令在场听众如痴如醉。',
        pinyin: 'Gǔqín míngjiā fǔqín tánzòu le yí què qīngyōu kuàngyuǎn de gǔqǔ, lìng zàichǎng tīngzhòng rúchīrúzuì.',
        translation_vi: 'Nghệ nhân đàn cổ cầm gảy tấu lên một khúc cổ nhạc thanh u khoáng đạt khiến khán giả có mặt đều mê mẩn ngất ngây.',
        explanation: '"一阕...古曲" định lượng cho khúc nhạc thính phòng tao nhã xưa.'
      }
    ]
  },
  {
    order_index: 12,
    name: 'Danh lượng từ chỉ vụ việc, cọc tâm sự phức tạp "桩" (Vụ / Mối / Chuyện)',
    pattern: 'Số từ + 桩 + Danh từ (心事 / 婚事 / 惨案 / 交易 / 疑案)',
    category: 'Lượng từ',
    explanation_vi: '"桩" (zhuāng) có nguồn gốc từ cọc gỗ đóng đất. Khi dùng làm lượng từ, "桩" chuyên dùng cho các sự kiện, vụ án ly kỳ, hoặc các mối tâm tư, hôn sự lớn trong đời người (như 一桩心事 - một mối tâm sự nặng trĩu, 一桩婚姻 - một mối hôn sự, 一桩悬案 - một vụ kỳ án chưa có lời giải).',
    examples: [
      {
        chinese: '看到唯一的女儿顺利成家立业，老两口心头的一桩大心事终于落地了。',
        pinyin: 'Kàndào wéiyī de nǚ\'ér shùnlì chéngjiālìyè, lǎo liǎngkǒu xīntóu de yì zhuāng dà xīnshì zhōngyú luòdì le.',
        translation_vi: 'Nhìn thấy cô con gái độc nhất yên bề gia thất lập nghiệp vững vàng, một mối tâm sự lớn trong lòng hai ông bà già cuối cùng cũng đã được trút bỏ.',
        explanation: '"一桩大心事" dùng "桩" định lượng cho mối âu lo đăm đăm nuôi dạy con cái của cha mẹ.'
      },
      {
        chinese: '这桩轰动全国的长达三十年的历史悬案，经过现代DNA技术的比对终于水落石出。',
        pinyin: 'Zhè zhuāng hōngdòng quánguó de chángdá sānshí nián de lìshǐ xuán\'àn, jīngguò xiàndài DNA jìshù de bǐduì zhōngyú shuǐluòshíchū.',
        translation_vi: 'Vụ án tồn đọng lịch sử kéo dài suốt 30 năm gây chấn động cả nước này, qua đối chiếu kỹ thuật DNA hiện đại cuối cùng đã sáng tỏ chân tướng.',
        explanation: '"这桩...历史悬案" dùng "桩" làm lượng từ tư pháp chuẩn mực cho vụ án hình sự phức tạp.'
      }
    ]
  },
  {
    order_index: 13,
    name: 'Danh lượng từ thi vị chỉ vầng trăng khuyết hình cánh cung "弯" (Mảnh / Vầng trăng cong)',
    pattern: '一 + 弯 + Danh từ (新月 / 残月 / 月亮 / 清泉)',
    category: 'Lượng từ',
    explanation_vi: '"弯" (wān) vốn là tính từ/động từ cong, uốn cong. Khi làm lượng từ nghệ thuật, "弯" chuyên dùng cho mảnh trăng non đầu tháng hoặc trăng tàn cuối tháng hình lưỡi liềm uốn cong thanh tú (như 一弯新月 - một mảnh trăng non).',
    examples: [
      {
        chinese: '夜幕初垂，深蓝色的天幕上静静地挂着一弯皎洁明亮的新月。',
        pinyin: 'Yèmù chūchuí, shēnlánsè de tiānmù shang jìngjìng de guàzhe yì wān jiǎojié míngliàng de xīnyuè.',
        translation_vi: 'Màn đêm vừa buông xuống, trên bức màn trời xanh thẳm lặng lẽ treo một mảnh trăng non trong sáng vằng vặc.',
        explanation: '"一弯...新月" miêu tả hình ảnh trăng khuyết lưỡi liềm thanh tao trên bầu trời đêm yên tĩnh.'
      },
      {
        chinese: '山谷深处环绕着一弯碧绿澄澈的天然清泉，倒映着四周秀丽的奇峰。',
        pinyin: 'Shāngǔ shēnchù huánràozhe yì wān bìlǜ chéngchè de tiānrán qīngquán, dàoyìngzhe sìzhōu xiùlì de qífēng.',
        translation_vi: 'Nơi sâu trong thung lũng uốn quanh một dòng suối trong tự nhiên xanh biếc trong vắt, in bóng non ngút ngàn kỳ vĩ bốn bề.',
        explanation: '"一弯...清泉" dùng "弯" định lượng cho dòng suối uốn lượn hình cánh cung mềm mại.'
      }
    ]
  },
  {
    order_index: 14,
    name: 'Danh lượng từ chỉ cảnh tượng, khí thế bao trùm "派" (Cảnh / Vẻ / Khí thế)',
    pattern: '一 + 派 + Danh từ cảnh tượng/không khí (生机 / 祥和 / 欣欣向荣 / 繁荣景象)',
    category: 'Lượng từ',
    explanation_vi: '"派" (pài) khi làm lượng từ biểu thị một bầu không khí, cảnh tượng toàn cảnh hoặc một phong cách khí thế bao trùm khắp không gian (như 一派生机 - một vùng tràn đầy sức sống, 一派祥和 - một cảnh tượng an lành thái bình, 一派胡言 - toàn lời nói nhảm).',
    examples: [
      {
        chinese: '春回大地，万物复苏，田野山川到处呈现出一派生机勃勃的欣欣向荣景象。',
        pinyin: 'Chūnhuídàdì, wànwù fùsū, tiányě shānchuān dàochù chéngxiàn chū yí pài shēngjībóbó de xīnxīnxiàngróng jǐngxiàng.',
        translation_vi: 'Xuân về trên đất mẹ, muôn vật hồi sinh, đồng ruộng núi sông khắp nơi hiện ra một cảnh tượng dạt dào sức sống phồn vinh mơn mởn.',
        explanation: '"一派生机勃勃的景象" miêu tả toàn cảnh không gian thiên nhiên trỗi dậy mãnh liệt vào mùa xuân.'
      },
      {
        chinese: '逢年过节，大街小巷张灯结彩，呈现出一派欢天喜地、安定祥和的节日氛围。',
        pinyin: 'Féngniánguòjié, dàjiēxiǎoxiàng zhāngdēngjiécǎi, chéngxiàn chū yí pài huāntiānxǐdì, āndìng xiánghé de jiérì fènwéi.',
        translation_vi: 'Mỗi độ tết đến xuân về, phố lớn ngõ nhỏ giăng đèn kết hoa, hiện ra một bầu không khí lễ hội vui vẻ rộn ràng, thanh bình an lạc.',
        explanation: '"一派...节日氛围" đặc tả bầu không khí tưng bừng phấn khởi bao trùm khắp phố phường.'
      }
    ]
  },
  {
    order_index: 15,
    name: 'Danh lượng từ thi vị chỉ cánh hoa, múi và tấm lòng "瓣" (Cánh / Múi / Mảnh)',
    pattern: 'Số từ + 瓣 + Danh từ (花瓣 / 蒜 / 橘子 / 心香 / 心意)',
    category: 'Lượng từ',
    explanation_vi: '"瓣" (bàn) dùng cho cánh hoa, múi quả (như 一瓣橘子 - một múi quýt, 一瓣大蒜 - một nhánh tỏi). Trong văn học tao nhã HSK 6, "一瓣心香" là thành ngữ ngữ pháp hóa ẩn dụ cho tấm lòng thành kính, trong sạch và tôn kính dâng lên bề trên.',
    examples: [
      {
        chinese: '春风拂过，枝头的粉红桃花纷纷飘落，将几瓣残红轻轻落在了旅人的肩头。',
        pinyin: 'Chūnfēng fúguò, zhītóu de fěnhóng táohuā fēnfēn piāoluò, jiāng jǐ bàn cánhóng qīngqīng luò zài le lǚrén de jiāntóu.',
        translation_vi: 'Gió xuân thổi qua, hoa đào phớt hồng trên đầu cành đua nhau rụng xuống, thả nhẹ mấy cánh hoa phai lên bờ vai người lữ thứ.',
        explanation: '"几瓣残红" dùng "瓣" định lượng cho những cánh hoa đào rơi rụng theo gió xuân.'
      },
      {
        chinese: '临别之际无以为赠，谨奉上一瓣心香，遥祝恩师健康长寿、福泽绵长。',
        pinyin: 'Línbié zhījì wúyǐwéizèng, jǐn fèngshàng yí bàn xīnxiāng, yáozhù ēnshī jiànkāng chángshòu, fúzé miáncháng.',
        translation_vi: 'Giờ phút chia tay chẳng có gì để tặng, kính dâng một tấm lòng thành kính tựa nén tâm hương, từ phương xa kính chúc ân sư sức khỏe trường thọ, phúc trạch dài lâu.',
        explanation: '"一瓣心香" là cách nói văn hóa nho nhã bày tỏ sự tri ân kính trọng sâu nặng với người thầy.'
      }
    ]
  },
  {
    order_index: 16,
    name: 'Danh lượng từ thực vật & địa lý chỉ khóm, bụi, cụm "丛" (Bụi / Khóm / Cụm)',
    pattern: 'Số từ + 丛 + Danh từ (灌木 / 鲜花 / 杂草 / 绿竹)',
    category: 'Lượng từ',
    explanation_vi: '"丛" (cóng) là lượng từ tập hợp dành cho các loài cây cỏ, hoa lá mọc tụ họp dày đặc sát cạnh nhau từ một gốc hoặc một cụm đất (như 一丛灌木 - một bụi cây bụi, 一丛野花 - một khóm hoa dại).',
    examples: [
      {
        chinese: '在悬崖峭壁的岩石缝隙里，顽强地生长着一丛傲雪凌霜的野菊花。',
        pinyin: 'Zài xuányáqiàobì de yánshí fèngxì lǐ, wánqiáng de shēngzhǎngzhe yì cóng àoxuělíngshuāng de yějúhuā.',
        translation_vi: 'Nơi khe nứt của vách đá cheo leo, kiên cường sinh trưởng một khóm cúc dại ngạo nghễ đạp tuyết khinh sương.',
        explanation: '"一丛...野菊花" dùng "丛" định lượng cho cụm hoa cúc dại vươn mình giữa đá núi hiểm trở.'
      },
      {
        chinese: '院子角落里种着一丛翠绿挺拔的修竹，为整个庭院平添了几分幽雅静谧。',
        pinyin: 'Yuànzi jiǎoluò lǐ zhòngzhe yì cóng cuìlǜ tǐngbá de xiūzhú, wèi zhěng gè tíngyuàn píngtiān le jǐ fēn yōuyǎ jìngmì.',
        translation_vi: 'Ở góc sân có trồng một bụi trúc xanh biếc thẳng tắp, điểm xuyết thêm cho cả khu vườn vài phần thanh nhã tĩnh mịch.',
        explanation: '"一丛翠绿挺拔的修竹" miêu tả bụi tre trúc cảnh trang trí sân vườn phương Đông.'
      }
    ]
  },
  {
    order_index: 17,
    name: 'Danh lượng từ chỉ nhúm nhỏ, nắm tay hoặc nhóm cực nhỏ "撮" (Nhúm / Dúm / Nhóm nhỏ)',
    pattern: '一 + 撮 + Danh từ (土 / 盐 / 头发) / 一小撮 + Đối tượng tiêu cực (阴谋分子 / 暴徒)',
    category: 'Lượng từ',
    explanation_vi: '"撮" (cuō) có hai cách dùng: 1) Lượng từ chỉ lượng rất ít có thể dùng các đầu ngón tay nhón lấy (như 一撮盐 - một nhúm muối, 一撮土 - một nắm đất); 2) Dùng trong chính trị chỉ một nhóm cực nhỏ những phần tử xấu, manh động bị xã hội cô lập (như 一小撮坏人, 一小撮分裂分子).',
    examples: [
      {
        chinese: '考古队员小心翼翼地用刷子扫起一撮古墓地层深处的灰烬样本进行年代测定。',
        pinyin: 'Kǎogǔ duìyuán xiǎoxīnyìyì de yòng shuāzi sǎoqǐ yì cuō gǔmù dìcéng shēnchù de huījìn yàngběn jìnxíng niándài cèdìng.',
        translation_vi: 'Cán bộ khảo cổ cẩn thận dùng cọ quét lấy một nhúm mẫu tro tàn nơi tầng sâu ngôi mộ cổ để tiến hành đo niên đại.',
        explanation: '"一撮...灰烬样本" dùng "撮" định lượng cho lượng mẫu tro cực nhỏ phục vụ xét nghiệm khoa học.'
      },
      {
        chinese: '那一小撮企图破坏边疆民族团结与社会繁荣的极端分子，终将受到法律的威严制裁。',
        pinyin: 'Nà yì xiǎocuō qǐtú pòhuài biānjiāng mínzú tuánjié yǔ shèhuì fánróng de jíduān fènzǐ, zhōng jiāng shòudào fǎlǜ de wēiyán zhìcái.',
        translation_vi: 'Một nhóm nhỏ những phần tử cực đoan mưu toan phá hoại đoàn kết dân tộc và sự phồn vinh xã hội nơi biên ải, cuối cùng sẽ phải chịu sự trừng phạt uy nghiêm của pháp luật.',
        explanation: '"一小撮...极端分子" là thuật ngữ chính luận lột tả sự cô lập thiểu số của phần tử phá hoại.'
      }
    ]
  },
  {
    order_index: 18,
    name: 'Phó từ văn ngôn chỉ sự tiếp diễn chưa dứt "尚" (Còn / Hãy còn / Vẫn / Chưa)',
    pattern: '尚 + Động từ/Tính từ (尚可 / 尚无定论 / 尚未可知 / 尚待研究 / 尚有)',
    category: 'Phó từ',
    explanation_vi: '"尚" (shàng) là phó từ văn ngôn tương đương với "还" (vẫn còn), nhưng mang phong cách trang trọng hàn lâm. Thường kết hợp trong các thành ngữ bốn chữ biểu thị sự việc đang trong quá trình tiếp diễn chưa ngã ngũ: 尚未 (chưa từng), 尚待 (còn chờ xem xét), 尚未可知 (vẫn chưa thể biết trước), 尚有欠缺 (vẫn còn khiếm khuyết).',
    examples: [
      {
        chinese: '该项假说在国际学术界尚存激烈争议，其客观真实性目前尚未得到最终确证。',
        pinyin: 'Gāi xiàng jiǎshuō zài guójì xuéshùjiè shàng cún jīliè zhēngyì, qí kèguān zhēnshíxìng mùqián shàngwèi dédào zuìzhōng quèzhèng.',
        translation_vi: 'Giả thuyết này trong giới học thuật quốc tế vẫn còn tồn tại tranh cãi gay gắt, tính chân thực khách quan của nó hiện tại vẫn chưa nhận được sự xác chứng cuối cùng.',
        explanation: '"尚存争议" và "尚未得到确证" thể hiện thái độ thận trọng khoa học đối với vấn đề chưa được chứng minh.'
      },
      {
        chinese: '经过紧急抢修，目前通信主干线尚可维持基本通话，全面修复尚需两到三天。',
        pinyin: 'Jīngguò jǐnjí qiǎngxiū, mùqián tōngxìn zhǔgànxiàn shàngkě wéichí jīběn tōnghuà, quánmiàn xiūfù shàng xū liǎng dào sān tiān.',
        translation_vi: 'Sau khi cấp tốc sửa chữa khẩn cấp, hiện tại tuyến trục thông tin hãy còn có thể duy trì đàm thoại cơ bản, việc khôi phục toàn diện vẫn cần từ hai tới ba ngày.',
        explanation: '"尚可维持" và "尚需..." thông báo tiến độ khắc phục sự cố thông tin liên lạc.'
      }
    ]
  },
  {
    order_index: 19,
    name: 'Cấu trúc liên từ tăng tiến nhượng bộ cực hạn "尚且...何况/况且..." (Ngay cả... huống chi...)',
    pattern: 'Trường hợp thông thường/mạnh 尚且 + Như thế nào, 何况 / 况且 + Trường hợp yếu/đặc biệt',
    category: 'Liên từ',
    explanation_vi: '"尚且...何况..." (shàngqiě... hékuàng...) là mẫu câu tăng tiến lập luận tu từ đỉnh cao: vế trước đưa ra đối tượng mạnh mẽ, điều kiện thuận lợi hoặc mức chuẩn tối thiểu mà "ngay cả đối tượng đó còn không làm nổi / còn gặp khó khăn", vế sau dùng "何况" để khẳng định đối tượng yếu kém hơn chắc chắn càng không thể.',
    examples: [
      {
        chinese: '经验老到的资深探险家在此恶劣环境下尚且步步惊心，何况毫无野外生存经验的普通游客呢？',
        pinyin: 'Jīngyàn lǎodào de zīshēn tànxiǎnjiā zài cǐ èliè huánjìng xià shàngqiě bùbùjīngxīn, hékuàng háowú yěwài shēngcún jīngyàn de pǔtōng yóukè ne?',
        translation_vi: 'Những nhà thám hiểm kỳ cựu dày dạn kinh nghiệm dưới môi trường khắc nghiệt này ngay cả họ còn từng bước thót tim, huống chi là du khách thông thường hoàn toàn không có kinh nghiệm sinh tồn nơi hoang dã chứ?',
        explanation: '"尚且...何况...呢" dùng thử thách của chuyên gia để cảnh báo nguy cơ tử thần đối với người nghiệp dư.'
      },
      {
        chinese: '身居高位的古代君王尚且虚心求教于田野贤士，我们作为普通人又怎能骄傲自满呢？',
        pinyin: 'Shēnjū gāowèi de gǔdài jūnwáng shàngqiě xūxīn qiújiào yú tiányě xiánshì, wǒmen zuòwéi pǔtōngrén yòu zěn néng jiāo\'àozìmǎn ne?',
        translation_vi: 'Những vị quân vương cổ đại ở ngôi vị tối cao ngay cả họ còn khiêm tốn thỉnh giáo các bậc hiền tài nơi đồng nội, chúng ta với tư cách là người bình thường sao có thể kiêu ngạo tự mãn chứ?',
        explanation: '"君王尚且...怎能..." lấy tấm gương của bậc đế vương răn dạy đức tính khiêm tốn cầu thị.'
      }
    ]
  },
  {
    order_index: 20,
    name: 'Phó từ thời gian văn ngôn khởi đầu "甫" (Vừa mới / Thoạt vừa mới)',
    pattern: '甫 + Động từ (甫一上市 / 甫一亮相 / 甫一出场 / 惊魂甫定)',
    category: 'Phó từ',
    explanation_vi: '"甫" (fǔ) là phó từ thời gian văn ngôn cổ xưa tương đương với "刚刚" (vừa mới), chuyên dùng miêu tả thời điểm một sự vật hoặc nhân vật vừa mới xuất hiện thì lập tức gây chấn động hoặc tạo nên phản ứng tức thì (như 甫一上市 - vừa mới tung ra thị trường, 惊魂甫定 - hồn phách vừa mới định thần lại).',
    examples: [
      {
        chinese: '该款自主研发的折叠屏旗舰手机甫一亮相，便在全球科技展会上引起了极大的轰动。',
        pinyin: 'Gāi kuǎn zìzhǔ yánfā de zhédiépíng qíjiàn shǒujī fǔyí liàngxiàng, biàn zài quánqiú kējì zhǎnhuì shang yǐnqǐ le jídà de hōngdòng.',
        translation_vi: 'Chiếc điện thoại đầu bảng màn hình gập tự chủ nghiên cứu phát triển này thoạt vừa mới ra mắt đã lập tức gây chấn động cực lớn tại triển lãm công nghệ toàn cầu.',
        explanation: '"甫一亮相，便引起轰动" là cách viết thời sự kinh điển miêu tả sức hút mãnh liệt tức thì của sản phẩm mới.'
      },
      {
        chinese: '大巴车司机在惊魂甫定之后，迅速组织全体乘客有序撤离到高速公路护栏外。',
        pinyin: 'Dàbāchē sījī zài jīnghúnfǔdìng zhīhòu, xùnsù zǔzhī quántǐ chéngkè yǒuxù chèlí dào gāosù gōnglù hùlán wài.',
        translation_vi: 'Tài xế xe buýt sau khi vừa mới hoàn hồn định thần lại sau cơn hoảng loạn, đã nhanh chóng tổ chức toàn thể hành khách sơ tán có trật tự ra ngoài dải phân cách đường cao tốc.',
        explanation: '"惊魂甫定" là thành ngữ miêu tả tâm trạng vừa kịp trấn tĩnh lại sau cú sốc tai nạn giao thông.'
      }
    ]
  },
  {
    order_index: 21,
    name: 'Phó từ hoàn thành pháp lý lịch sử "业已" (Đã / Đã từng hoàn tất)',
    pattern: 'Chủ ngữ + 业已 + Động từ song âm tiết (完成 / 生效 / 查明 / 达成 / 告竣)',
    category: 'Phó từ',
    explanation_vi: '"业已" (yèyǐ) là phó từ ngoại giao và pháp lý cao cấp tương đương với "已经", biểu thị một hiệp ước, công trình hoặc quy trình điều tra đã được hoàn thành triệt để trong quá khứ và hiện đang phát sinh hiệu lực đầy đủ (như 业已生效 - đã chính thức có hiệu lực, 业已查明 - đã điều tra làm rõ).',
    examples: [
      {
        chinese: '两国议会正式批准的双边投资保护协定业已于今日凌晨起全面生效。',
        pinyin: 'Liǎng guó yìhuì zhèngshì pīzhǔn de shuāngbiān tóuzī bǎohù xiéyì yèyǐ yú jīnrì língchén qǐ quánmiàn shēngxiào.',
        translation_vi: 'Hiệp định bảo hộ đầu tư song phương do nghị viện hai nước chính thức phê chuẩn đã chính thức phát sinh hiệu lực toàn diện kể từ rạng sáng hôm nay.',
        explanation: '"业已...全面生效" là thuật ngữ công pháp ngoại giao tuyên bố mốc hiệu lực của điều ước quốc tế.'
      },
      {
        chinese: '经过跨部门专案组的不懈努力，事故发生的直接诱因及责任链条业已彻底查明。',
        pinyin: 'Jīngguò kuà bùmén zhuān\'ànzǔ de búxiè nǔlì, shìgù fāshēng de zhíjiē yòuyīn jí zérèn liàntiáo yèyǐ chèdǐ chámíng.',
        translation_vi: 'Qua sự nỗ lực không ngừng nghỉ của ban chuyên án liên ngành, nguyên nhân trực tiếp châm ngòi và chuỗi trách nhiệm của vụ tai nạn đã được điều tra làm rõ triệt để.',
        explanation: '"业已彻底查明" khẳng định kết quả điều tra đã ngã ngũ rõ ràng không còn uẩn khúc.'
      }
    ]
  },
  {
    order_index: 22,
    name: 'Phó từ cấp bách không thể trì hoãn "亟待" (Cực kỳ cấp thiết cần phải / Cần kíp)',
    pattern: 'Vấn đề nhức nhối / Tồn đọng + 亟待 + Động từ song âm tiết (解决 / 完善 / 澄清 / 规范 / 拯救)',
    category: 'Phó từ',
    explanation_vi: '"亟待" (jídài) kết hợp chữ "亟" (jí - khẩn cấp, gấp gáp) và "待" (dài - chờ đợi, cần phải), mang nghĩa "vô cùng khẩn thiết, cấp bách đòi hỏi phải hành động ngay lập tức không thể chậm trễ thêm một giây phút nào" (cực kỳ cấp bách cần giải quyết). Thường dùng trong các thông điệp cảnh báo xã hội.',
    examples: [
      {
        chinese: '传统手工造纸技艺面临着后继无人的濒危严峻困境，这一非遗项目亟待抢救性保护。',
        pinyin: 'Chuántǒng shǒugōng zàozhǐ jìyì miànlínzhe hòujìwúrén de bīnwēi yánjùn kùnjìng, zhè yì fēiyí xiàngmù jídài qiǎngjiùxìng bǎohù.',
        translation_vi: 'Nghề làm giấy thủ công truyền thống đang đối mặt với nghịch cảnh ngặt nghèo không người kế nghiệp, dự án di sản phi vật thể này đang hết sức cấp bách cần được bảo vệ khẩn cấp mang tính giải cứu.',
        explanation: '"亟待抢救性保护" phát đi thông điệp cấp bách bảo tồn nghề cổ truyền trước nguy cơ thất truyền.'
      },
      {
        chinese: '网络未成年人打赏巨额资金的社会乱象屡禁不绝，相关监管法律漏洞亟待立法完善。',
        pinyin: 'Wǎngluò wèichéngniánrén dǎshǎng jù\'é zījīn de shèhuì luànxiàng lǚjìnbùjué, xiāngguān jiānguǎn fǎlǜ lòudòng jídài lìfǎ wánshàn.',
        translation_vi: 'Vấn nạn xã hội trẻ vị thành niên nạp thưởng số tiền khổng lồ trên mạng cấm mãi không dứt, các lỗ hổng luật pháp giám sát liên quan hết sức cấp bách cần được hoàn thiện bằng công tác lập pháp.',
        explanation: '"亟待立法完善" chỉ ra yêu cầu khẩn cấp của việc hoàn thiện thể chế pháp lý.'
      }
    ]
  },
  {
    order_index: 23,
    name: 'Phó từ biến đổi dốc đứng đột ngột "陡然" (Đột ngột / Đùng một cái / Dốc đứng)',
    pattern: 'Chủ ngữ + 陡然 + Động từ/Tính từ biến đổi (增加 / 下降 / 紧张 / 升温 / 变色)',
    category: 'Phó từ',
    explanation_vi: '"陡然" (dǒurán) có gốc từ chữ "陡" (dốc đứng, hiểm trở). Biểu thị số liệu, nhiệt độ, áp lực hoặc bầu không khí biến đổi đột ngột như một vách đá dựng đứng, khiến mọi người không kịp trở tay (đột ngột thay đổi chóng mặt).',
    examples: [
      {
        chinese: '突如其来的国际金融动荡，让这家外贸企业的资金链压力陡然剧增。',
        pinyin: 'Tūrúqílái de guójì jīnróng dòngdàng, ràng zhè jiā wàimào qǐyè de zījīnliàn yālì dǒurán jùzēng.',
        translation_vi: 'Biến động tài chính quốc tế bất ngờ ập đến đã khiến áp lực dòng tiền của doanh nghiệp ngoại thương này đột ngột tăng vọt lên chóng mặt.',
        explanation: '"压力陡然剧增" miêu tả mức độ căng thẳng tài chính tăng vọt dữ dội ngoài tầm kiểm soát.'
      },
      {
        chinese: '原本平静和谐的谈判会场，因对方突然提出苛刻要求而使气氛陡然紧张了起来。',
        pinyin: 'Yuánběn píngjìng héxié de tánpàn huìchǎng, yīn duìfāng tūrán tíchū kēkè yāoqiú ér shǐ qìfēn dǒurán jǐnzhāng le qǐlái.',
        translation_vi: 'Hội trường đàm phán vốn dĩ đang yên ắng hòa hợp bỗng vì đối phương đột ngột đưa ra yêu sách hà khắc mà khiến bầu không khí bỗng chốc căng thẳng tột độ.',
        explanation: '"气氛陡然紧张" diễn tả sự chuyển biến tâm lý đối đầu kịch tính trong đàm phán ngoại giao.'
      }
    ]
  },
  {
    order_index: 24,
    name: 'Phó từ thời tiết và âm thanh bùng phát đột ngột "骤然" (Đột nhiên bùng phát / Bất thình lình)',
    pattern: 'Chủ ngữ + 骤然 + Động từ/Tính từ (降温 / 响起了 / 停止 / 狂风大作 / 亮起)',
    category: 'Phó từ',
    explanation_vi: '"骤然" (zhòurán) kết hợp chữ "骤" (chạy nước đại, đột ngột), biểu thị một hiện tượng thiên nhiên (gió bão, nhiệt độ) hoặc âm thanh, ánh sáng bộc phát nhanh và mạnh mẽ như một cơn lốc bất ngờ (đột ngột, bất thình lình bùng lên).',
    examples: [
      {
        chinese: '受北方强冷空气南下袭击影响，该地区的气温在短短半天内骤然下降了十五摄氏度。',
        pinyin: 'Shòu běifāng qiáng lěngkōngqì nánxià xíjī yǐngxiǎng, gāi dìqū de qìwēn zài duǎnduǎn bàn tiān nèi zhòurán xiàjiàng le shíwǔ shèshìdù.',
        translation_vi: 'Chịu ảnh hưởng bởi đợt không khí lạnh mạnh từ phương Bắc tràn xuống tấn công, nhiệt độ của khu vực này chỉ trong vòng nửa ngày ngắn ngủi đã đột ngột giảm mạnh 15 độ C.',
        explanation: '"气温...骤然下降" miêu tả hiện tượng rét đậm ập đến cực nhanh theo quy luật thời tiết cực đoan.'
      },
      {
        chinese: '寂静无声的深夜里，走廊深处骤然响起了一阵急促而惊慌的敲门声。',
        pinyin: 'Jìjìngwúshēng de shēnyè lǐ, zǒuláng shēnchù zhòurán xiǎngqǐ le yí zhèn jícù ér jīnghuāng de qiāomén shēng.',
        translation_vi: 'Nơi đêm khuya thanh vắng tĩnh mịch không một tiếng động, sâu trong hành lang bỗng nhiên bất thình lình vang lên một hồi tiếng gõ cửa dồn dập đầy hoảng sợ.',
        explanation: '"骤然响起敲门声" tạo bầu không khí kịch tính, hồi hộp trong văn phong tiểu thuyết trinh thám.'
      }
    ]
  },
  {
    order_index: 25,
    name: 'Thành ngữ ngữ pháp hóa chỉ sự bí mật êm ả "悄无声息" (Lặng lẽ không một tiếng động)',
    pattern: 'Chủ ngữ + 悄无声息地 + Động từ (蔓延 / 潜入 / 发生 / 改变 / 离去)',
    category: 'Phó từ',
    explanation_vi: '"悄无声息" (qiǎowúshēngxī) mang ý nghĩa tuyệt đối yên ắng, không phát ra một chút âm thanh hay tiếng động nhỏ nào, làm cho người khác hoàn toàn không hay biết (lặng lẽ không một tiếng động, âm thầm không ai hay). Thường dùng làm trạng ngữ miêu tả sự xâm nhập bí mật hoặc dòng chảy thời gian trôi đi.',
    examples: [
      {
        chinese: '一场以人工智能大模型为标志的全新工业革命，正在各行各业悄无声息地全面蔓延。',
        pinyin: 'Yì chǎng yǐ réngōng zhìnéng dà móxíng wéi biāozhì de quánxīn gōngyè gémìng, zhèngzài gèhánggèyè qiǎowúshēngxī de quánmiàn mànyán.',
        translation_vi: 'Một cuộc cách mạng công nghiệp hoàn toàn mới lấy mô hình trí tuệ nhân tạo lớn làm dấu mốc đang âm thầm lan tỏa không một tiếng động trong mọi ngành nghề.',
        explanation: '"悄无声息地蔓延" ẩn dụ cho sự thâm nhập tất yếu, sâu sắc của công nghệ vào nền kinh tế số.'
      },
      {
        chinese: '特警队员在夜幕的掩护下，悄无声息地包围了犯罪团伙藏匿的废弃仓库。',
        pinyin: 'Tèjǐng duìyuán zài yèmù de yǎnhù xià, qiǎowúshēngxī de bāowéi le fànzuì tuánhuǒ cángnì de fèiqì cāngkù.',
        translation_vi: 'Dưới sự che chở của màn đêm, các chiến sĩ cảnh sát đặc nhiệm đã bí mật lặng lẽ khép chặt vòng vây kho hàng bỏ hoang nơi băng nhóm tội phạm ẩn náu.',
        explanation: '"悄无声息地包围" miêu tả chiến thuật đột kích tuyệt mật chuyên nghiệp của lực lượng đặc nhiệm.'
      }
    ]
  },
  {
    order_index: 26,
    name: 'Động từ/Phó từ duyên kỳ ngộ đúng dịp may mắn "适逢" (Đúng dịp / Vừa khéo gặp / Trùng phùng)',
    pattern: '适逢 + Dịp đại lễ/Sự kiện trọng đại / 适逢其会',
    category: 'Phó từ',
    explanation_vi: '"适逢" (shìféng) kết hợp chữ "适" (vừa vặn, đúng lúc) và "逢" (gặp gỡ), mang nghĩa "vừa vặn trùng hợp đúng vào thời điểm hoặc dịp lễ hội, sự kiện tốt đẹp" (đúng vào dịp, may mắn trùng phùng). Thành ngữ "适逢其会" chỉ việc vừa khéo có mặt đúng vào thời điểm thuận lợi nhất.',
    examples: [
      {
        chinese: '代表团这次访问适逢该国建国七十周年盛大庆典，因此受到了东道国最高规格的礼遇。',
        pinyin: 'Dàibiǎotuán zhè cì fǎngwèn shìféng gāi guó jiànguó qīshí zhōunián shèngdà qìngdiǎn, yīncǐ shòudào le dōngdàoguó zuì gāo guīgé de lǐyù.',
        translation_vi: 'Chuyến thăm lần này của đoàn đại biểu đúng vào dịp đại lễ kỷ niệm 70 năm lập quốc của đất nước này, do đó đã nhận được sự đón tiếp theo quy chuẩn lễ nghi cao nhất của nước chủ nhà.',
        explanation: '"适逢...盛大庆典" liên kết sự trùng hợp tốt đẹp về thời điểm lịch sử với quy cách đón tiếp trang trọng.'
      },
      {
        chinese: '青年一代生逢其时、适逢其会，必将在这个伟大的时代大有作为。',
        pinyin: 'Qīngnián yídài shēngféngqíshí, shìféngqíhuì, bìjiāng zài zhè ge wěidà de shídài dàyǒuzuòwéi.',
        translation_vi: 'Thế hệ trẻ sinh ra đúng thời, gặp đúng thời cơ lịch sử, nhất định sẽ làm nên những sự nghiệp vĩ đại trong thời đại huy hoàng này.',
        explanation: '"生逢其时、适逢其会" là cặp thành ngữ truyền cảm hứng cổ vũ thanh niên nắm bắt vận hội non sông.'
      }
    ]
  },
  {
    order_index: 27,
    name: 'Phó từ thời gian nối tiếp thần tốc "旋即" (Liền ngay sau đó / Nhanh chóng tiếp nối)',
    pattern: 'Hành động 1 bộc phát, 旋即 + Hành động 2 / Kết quả phản hồi tức thì',
    category: 'Phó từ',
    explanation_vi: '"旋即" (xuánjí) là phó từ văn ngôn cổ nhã tương đương với "随即" hoặc "转身立刻", biểu thị một sự biến đổi hoặc phản ứng diễn ra cực nhanh, chớp nhoáng nối liền ngay sau sự việc thứ nhất (ngay sau đó, thoắt cái liền). Mang sắc thái văn phong bác học.',
    examples: [
      {
        chinese: '爆炸发生后，附近驻军部队闻令而动，旋即奔赴现场展开了紧急的抢险救援。',
        pinyin: 'Bàozhà fāshēng hòu, fùjìn zhùjūn bùduì wénlìng\'érdòng, xuánjí bēnfù xiànchǎng zhǎnkāi le jǐnjí de qiǎngxiǎn jiùyuán.',
        translation_vi: 'Sau khi vụ nổ xảy ra, lực lượng quân đội đóng quân gần đó nghe lệnh lập tức hành động, ngay tắp lự đã lao tới hiện trường triển khai công tác cứu hộ khẩn cấp.',
        explanation: '"旋即奔赴现场" đặc tả tốc độ phản ứng điều binh thần tốc của quân đội trước thảm họa.'
      },
      {
        chinese: '公司发布的辟谣声明言之凿凿，旋即平息了网络上持续数日的恶意造谣风波。',
        pinyin: 'Gōngsī fābù de pìyáo shēngmíng yánzhīzàozào, xuánjí píngxī le wǎngluò shang chíxù shù rì de èyì zàoyáo fēngbō.',
        translation_vi: 'Thông cáo đính chính bác bỏ tin đồn của công ty đưa ra đầy đủ bằng chứng xác thực, ngay lập tức đã dập tắt cơn sóng gió bịa đặt ác ý kéo dài suốt nhiều ngày trên mạng.',
        explanation: '"旋即平息了...风波" nhấn mạnh hiệu quả trấn an dư luận tức thời của thông điệp minh bạch.'
      }
    ]
  },
  {
    order_index: 28,
    name: 'Liên từ lựa chọn văn ngôn cổ kính "抑或" (Hoặc là / Hay là)',
    pattern: 'Lựa chọn A, 抑或 + Lựa chọn B (mang tính triết lý, suy tư sâu xa)',
    category: 'Liên từ',
    explanation_vi: '"抑或" (yìhuò) là liên từ lựa chọn bắt nguồn từ Hán ngữ cổ đại tương đương với "还是" hoặc "或者是", nhưng mang đậm phong vị suy tư triết học, chất vấn lịch sử hoặc phong cách tùy bút văn học thâm trầm (hay là, hoặc giả là).',
    examples: [
      {
        chinese: '人类探索浩瀚太空的终极驱动力，究竟是源于对未知世界的好奇，抑或是为了寻求文明未来的生存空间？',
        pinyin: 'Rénlèi tànsuǒ hàohàn tàikōng de zhōngjí qūdònglì, jiūjìng shì yuányú duì wèizhī shìjiè de hàoqí, yìhuò shì wèile xúnqiú wénmíng wèilái de shēngcún kōngjiān?',
        translation_vi: 'Động lực tối thượng thúc đẩy nhân loại khám phá vũ trụ bao la, rốt cuộc là bắt nguồn từ trí tò mò đối với thế giới chưa biết, hay là nhằm tìm kiếm không gian sinh tồn tương lai cho nền văn minh?',
        explanation: '"究竟是...抑或是..." đặt ra câu hỏi triết học sâu xa về sứ mệnh chinh phục vũ trụ của nhân loại.'
      },
      {
        chinese: '这场长达百年的历史论战，究竟是一场学术立场的交锋，抑或是一场意识形态的较量？',
        pinyin: 'Zhè chǎng chángdá bǎinián de lìshǐ lùnzhàn, jiūjìng shì yì chǎng xuéshù lìchǎng de jiāofēng, yìhuò shì yì chǎng yìshíxíngtài de jiàoliàng?',
        translation_vi: 'Cuộc luận chiến lịch sử kéo dài suốt trăm năm này, rốt cuộc là một cuộc so găng về lập trường học thuật, hay là một cuộc đọ sức về hình thái ý thức?',
        explanation: '"抑或" đưa ra hai giả thuyết sâu sắc để mổ xẻ bản chất của cuộc tranh biện lịch sử.'
      }
    ]
  },
  {
    order_index: 29,
    name: 'Phó từ phỏng đoán tu từ hoài nghi "莫非" (Lẽ nào / Chẳng lẽ / Hay là)',
    pattern: '莫非 + Phỏng đoán nghi hoặc + (不成 / 吗 / 呢)？',
    category: 'Phó từ',
    explanation_vi: '"莫非" (mòfēi) dùng trong câu hỏi phỏng đoán để biểu thị sự nghi hoặc, ngạc nhiên trước một tình huống bất thường (lẽ nào, chẳng lẽ). Cuối câu thường kết hợp với quán dụng ngữ "不成" tạo thành cấu trúc tu từ "莫非...不成？" (chẳng lẽ... hay sao?).',
    examples: [
      {
        chinese: '大门紧锁且屋内一片漆黑，莫非他们全家都去外地度假了不成？',
        pinyin: 'Dàmén jǐnsuǒ qiě wūnèi yí piàn qīhēi, mòfēi tāmen quán jiā dōu qù wàidì dùjià le bùchéng?',
        translation_vi: 'Cửa chính khóa chặt và trong nhà tối om không một bóng đèn, chẳng lẽ cả nhà họ đều đã đi nơi khác nghỉ dưỡng rồi hay sao?',
        explanation: '"莫非...不成？" đưa ra phán đoán phỏng đoán trước hiện trường ngôi nhà vắng vẻ.'
      },
      {
        chinese: '平时最守时的人今天居然迟到了一个小时，莫非路上遇到了什么突发险情？',
        pinyin: 'Píngshí zuì shǒushí de rén jīntiān jūrán chídào le yí gè xiǎoshí, mòfēi lùshang yùdào le shénme tūfā xiǎnqíng?',
        translation_vi: 'Người bình thường đúng giờ nhất hôm nay không ngờ lại đến muộn một tiếng đồng hồ, lẽ nào trên đường đã gặp phải tình huống nguy hiểm bất trắc gì rồi sao?',
        explanation: '"莫非..." biểu thị sự lo lắng cho an nguy của người bạn khi xuất hiện sự bất thường.'
      }
    ]
  },
  {
    order_index: 30,
    name: 'Phó từ phủ định kép khẳng định tính phổ quát "莫不" (Không ai là không / Không gì là không)',
    pattern: 'Mọi người / Mọi sự vật + 莫不 + Động từ/Tính từ (称赞 / 感慨 / 欣喜 / 为之动容)',
    category: 'Phó từ',
    explanation_vi: '"莫不" (mòbù) là phó từ văn ngôn kết hợp chữ 莫 (không ai, không có gì) và 不 (không), tạo thành phủ định kép khẳng định 100% tính phổ quát tuyệt đối của hiện tượng (không ai là không như vậy, ai nấy đều, không gì là không). Mang sắc thái ngợi ca hoặc thán phục trang nghiêm.',
    examples: [
      {
        chinese: '凡是亲眼目睹过这位老红军英雄事迹报告的听众，无不热泪盈眶，莫不为之深深动容。',
        pinyin: 'Fánshì qīnyǎn mùdǔguo zhè wèi lǎohóngjūn yīngxióng shìjì bàogào de tīngzhòng, wúbù rèlèiyíngkuàng, mòbù wéizhī shēnshēn dòngróng.',
        translation_vi: 'Phàm là người nghe từng tận mắt chứng kiến báo cáo thành tích anh hùng của người chiến sĩ Hồng quân già này, không ai là không ngấn lệ, không một ai là không vì thế mà xúc động sâu sắc.',
        explanation: '"莫不为之动容" cực tả sức lay động lòng người mãnh liệt của câu chuyện anh hùng cách mạng.'
      },
      {
        chinese: '历代登临泰山玉皇顶极目远眺的文人骚客，莫不被其雄浑壮阔的巍峨气象所震撼。',
        pinyin: 'Lìdài dēnglín Tàishān Yùhuángdǐng jímù yuǎntiào de wénrénsāokè, mòbù bèi qí xiónghún zhuàngkuò de wēi\'é qìxiàng suǒ zhènhàn.',
        translation_vi: 'Các bậc văn nhân thi khách qua các thời đại khi bước lên đỉnh Ngọc Hoàng của núi Thái Sơn phóng tầm mắt nhìn xa, không một ai là không bị khí tượng nguy nga hùng vĩ tráng lệ của nó làm cho chấn động.',
        explanation: '"莫不被...所震撼" dùng phủ định kép văn ngôn khẳng định sự sùng kính của tiền nhân trước ngọn núi thiêng.'
      }
    ]
  },
  {
    order_index: 31,
    name: 'Phó từ văn ngôn phủ định không cần thiết "毋庸" (Không cần / Khỏi phải / Không cần bàn cãi)',
    pattern: '毋庸 + Động từ song âm tiết (置疑 / 讳言 / 多言 / 细述 / 赘述)',
    category: 'Phó từ',
    explanation_vi: '"毋庸" (wúyōng) kết hợp chữ "毋" (không) và "庸" (cần), mang nghĩa "hoàn toàn không cần thiết phải làm, không cần phải nói thêm" (khỏi phải, không cần). Tạo thành các thành ngữ học thuật bất hủ trong HSK 6: "毋庸置疑" (không còn nghi ngờ gì nữa), "毋庸讳言" (thẳng thắn không cần giấu giếm, nói thẳng thắn), "毋庸赘述" (không cần nói rườm rà thêm).',
    examples: [
      {
        chinese: '创新对于现代高科技产业生存发展的决定性引领作用，是毋庸置疑的。',
        pinyin: 'Chuàngxīn duìyú xiàndài gāo kējì chǎnyè shēngcún fāzhǎn de juédìngxìng yǐnlǐng zuòyòng, shì wúyōngzhìyí de.',
        translation_vi: 'Tác dụng dẫn dắt mang tính quyết định của đổi mới sáng tạo đối với sự sinh tồn phát triển của ngành công nghệ cao hiện đại là điều khỏi cần nghi ngờ.',
        explanation: '"是毋庸置疑的" khẳng định tính chân lý không thể lay chuyển của yếu tố đổi mới công nghệ.'
      },
      {
        chinese: '毋庸讳言，我们在前期的市场调研中确实存在着一定的盲目乐观与经验主义倾向。',
        pinyin: 'Wúyōnghuìyán, wǒmen zài qiánqī de shìchǎng diàoyán zhōng quèshí cúnzài zhe yídìng de mángmù lèguān yǔ jīngyànzhǔyì qīngxiàng.',
        translation_vi: 'Thẳng thắn không cần giấu giếm, chúng tôi trong khâu khảo sát thị trường giai đoạn ban đầu quả thực có tồn tại khuynh hướng lạc quan mù quáng và chủ nghĩa kinh nghiệm nhất định.',
        explanation: '"毋庸讳言" thể hiện tinh thần dũng cảm nhìn thẳng vào khuyết điểm và tự phê bình nghiêm túc.'
      }
    ]
  }
];
