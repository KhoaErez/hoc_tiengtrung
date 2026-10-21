// data/hsk5-batch15-part4-data.ts
// 25 từ HSK 5: #3477 [着凉] -> #3501 [直]

export interface ExampleItem {
  chinese: string
  pinyin: string
  meaning_vi: string
  difficulty_level: 'basic' | 'applied'
}

export interface VocabItem {
  id: number
  hanzi: string
  pinyin: string
  word_type: string
  meaning_vi: string
  examples: ExampleItem[]
}

export const HSK5_BATCH15_PART4: VocabItem[] = [
  {
    id: 3477,
    hanzi: '着凉',
    pinyin: 'zháoliáng',
    word_type: 'Động từ',
    meaning_vi: 'bị cảm lạnh, nhiễm lạnh',
    examples: [
      {
        chinese: '昨晚睡觉时他忘记关上卧室的窗户，夜里吹了冷风，今早起来就有些着凉流鼻涕。',
        pinyin: 'Zuówǎn shuìjiào shí tā wàngjì guān shang wòshì de chuānghu, yè lǐ chuī le lěngfēng, jīnzǎo qǐlái jiù yǒuxiē zháoliáng liú bítì.',
        meaning_vi: 'Đêm qua lúc ngủ anh ấy quên đóng cửa sổ phòng ngủ, trong đêm bị gió lạnh thổi vào, sáng nay thức dậy đã bị cảm lạnh và chảy nước mũi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '野外地质勘探队在高原严寒无遮蔽环境下作业时，必须严格执行防寒保暖规程以防队员因失温与着凉引发肺水肿等高原重症。',
        pinyin: 'Yěwài dìzhì kāntànduì zài gāoyuán yánhán wú-zhēbì huánjìng xià zuòyè shí, bìxū yángé zhíxíng fánghán bǎonuǎn guīchéng yǐfáng duìyuán yīn shīwēn yǔ zháoliáng yǐnfā fèishuǐzhǒng děng gāoyuán zhòngzhèng.',
        meaning_vi: 'Đội thăm dò địa chất dã ngoại khi tác nghiệp trong môi trường giá rét không nơi che chắn ở vùng cao nguyên bắt buộc phải chấp hành nghiêm ngặt quy trình giữ ấm chống rét để phòng ngừa thành viên do hạ thân nhiệt và nhiễm lạnh mà phát sinh các bệnh hiểm nghèo vùng cao như phù phổi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3478,
    hanzi: '召开',
    pinyin: 'zhàokāi',
    word_type: 'Động từ',
    meaning_vi: 'triệu tập, tổ chức (hội nghị, đại hội)',
    examples: [
      {
        chinese: '学校定于明天下午三点在学术报告厅召开新学期全体教职工大会，部署教学任务。',
        pinyin: 'Xuéxiào dìng yú míngtiān xiàwǔ sān diǎn zài xuéshù bàogàotīng zhàokāi xīn-xuéqī quántǐ jiàozhígōng dàhuì, bùshǔ jiàoxué rènwù.',
        meaning_vi: 'Nhà trường ấn định vào ba giờ chiều mai tại hội trường báo cáo học thuật sẽ triệu tập đại hội toàn thể cán bộ giảng viên nhân viên học kỳ mới để triển khai nhiệm vụ giảng dạy.',
        difficulty_level: 'basic'
      },
      {
        chinese: '联合国安全理事会应轮值主席国请求紧急召开闭门磋商会议，全面评估地区冲突升级对全球和平稳定的重大威胁。',
        pinyin: 'Liánhéguó Ānquán Lǐshìhuì yīng lúnzhí zhǔxíguó qǐngqiú jǐnjí zhàokāi bìmén cuōshāng huìyì, quánmiàn pínggū dìqū chōngtū shēngjí duì quánqiú hépíng wěndìng de zhòngdà wēixié.',
        meaning_vi: 'Hội đồng Bảo an Liên Hợp Quốc đáp ứng yêu cầu của quốc gia chủ tịch luân phiên đã triệu tập khẩn cấp cuộc họp tham vấn kín, nhằm đánh giá toàn diện mối đe dọa trọng đại của sự leo thang xung đột khu vực đối với hòa bình và ổn định toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3479,
    hanzi: '折扣',
    pinyin: 'zhékòu',
    word_type: 'Danh từ',
    meaning_vi: 'mức chiết khấu, giảm giá',
    examples: [
      {
        chinese: '这家品牌专卖店在周末开展促销活动，会员凭借积分卡可以享受全场服装八折的优惠折扣。',
        pinyin: 'Zhè jiā pǐnpái zhuānmàidiàn zài zhōumò kāizhǎn cùxiāo huódòng, huìyuán píngjiè jīfēnkǎ kěyǐ xiǎngshòu quánchǎng fúzhuāng bā zhé de yōuhuì zhékòu.',
        meaning_vi: 'Cửa hàng chuyên doanh thương hiệu này cuối tuần triển khai hoạt động khuyến mãi, hội viên dựa vào thẻ tích điểm có thể được hưởng mức chiết khấu ưu đãi giảm giá 20% cho toàn bộ trang phục.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业大宗采购框架合同中明确设定了阶梯式商业折扣比率，以采购总量的规模经济效应换取供应链的最优单价。',
        pinyin: 'Qǐyè dàzōng cǎigòu kuàngjià hétong zhōng míngquè shèdìng le jiētīshì shāngyè zhékòu bǐlǜ, yǐ cǎigòu zǒngliàng de guīmó jīngjì xiàoyìng huànqǔ gōngyìngliàn de zuìyōu dānjià.',
        meaning_vi: 'Hợp đồng khung mua sắm số lượng lớn của doanh nghiệp đã thiết lập rõ ràng tỷ lệ chiết khấu thương mại dạng bậc thang, lấy hiệu ứng kinh tế theo quy mô của tổng lượng mua để đổi lấy mức đơn giá tối ưu của chuỗi cung ứng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3480,
    hanzi: '哲学',
    pinyin: 'zhéxué',
    word_type: 'Danh từ',
    meaning_vi: 'triết học',
    examples: [
      {
        chinese: '他在大学期间选修了西方哲学概论课程，学会了用批判性思维去审视日常生活中的各种问题。',
        pinyin: 'Tā zài dàxué qījiān xuǎnxiū le xīfāng zhéxué gàilùn kèchéng, xuéhuì le yòng pīpànxìng sīwéi qù shěnshì rìcháng shēnghuó zhōng de gèzhǒng wèntí.',
        meaning_vi: 'Trong thời gian học đại học anh ấy đã học tự chọn môn khái luận triết học phương Tây, học được cách dùng tư duy phản biện để xem xét các vấn đề trong cuộc sống thường nhật.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代科技伦理学从哲学本体论的高度反思人工智能的发展边界，旨在构建以人类尊严为核心的技术向善演进路径。',
        pinyin: 'Xiàndài kējì lúnlǐxué cóng zhéxué běntǐlùn de gāodù fǎnsī réngōng zhìnéng de fāzhǎn biānjiè, zhǐzài gòujiàn yǐ rénlèi zūnyán wéi héxīn de jìshù xiàngshàn yǎnjìn lùjìng.',
        meaning_vi: 'Đạo đức học khoa học công nghệ hiện đại từ tầm cao bản thể luận triết học đã suy ngẫm sâu sắc về ranh giới phát triển của trí tuệ nhân tạo, nhằm xây dựng lộ trình tiến hóa công nghệ hướng thiện lấy phẩm giá con người làm cốt lõi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3481,
    hanzi: '真诚',
    pinyin: 'zhēnchéng',
    word_type: 'Tính từ',
    meaning_vi: 'chân thành, thành thật',
    examples: [
      {
        chinese: '在与朋友交往的过程中，只有保持一颗真诚待人的心，才能收获长久而深厚的友谊。',
        pinyin: 'Zài yǔ péngyou jiāowǎng de guòchéng zhōng, zhǐyǒu bǎochí yì kē zhēnchéng dài rén de xīn, cáinéng shōuhuò chángjiǔ ér shēnhòu de yǒuyì.',
        meaning_vi: 'Trong quá trình giao lưu kết bạn với mọi người, chỉ khi giữ một tấm lòng đối đãi chân thành, ta mới có thể gặt hái được tình bạn lâu dài và sâu đậm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业在面临公共危机公关舆情冲击时，迅速主动公开事实真相并展现真诚担当，是重建公众信任与社会美誉度的关键支点。',
        pinyin: 'Qǐyè zài miànlín gōnggòng wēijī gōngguān yúqíng chōngjī shí, xùnsù zhǔdòng gōngkāi shìshí zhēnxiàng bìng zhǎnxiàn zhēnchéng dāndāng, shì chóngjiàn gōngzhòng xìnrèn yǔ shèhuì měiyùdù de guānjiàn zhīdiǎn.',
        meaning_vi: 'Doanh nghiệp khi đứng trước cú sốc dư luận quan hệ công chúng khủng hoảng cộng đồng, việc nhanh chóng chủ động công khai sự thật và thể hiện tinh thần gánh vác chân thành là điểm tựa then chốt để tái thiết lập lòng tin của công chúng cùng uy tín xã hội.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3482,
    hanzi: '针对',
    pinyin: 'zhēnduì',
    word_type: 'Động từ / Giới từ',
    meaning_vi: 'nhằm vào, hướng tới, căn cứ vào',
    examples: [
      {
        chinese: '老师针对同学们在期中考试中普遍犯错的几何证明题，利用晚自习时间进行了详尽的针对性辅导。',
        pinyin: 'Lǎoshī zhēnduì tóngxuémen zài qīzhōng kǎoshì zhōng pǔbiàn fàncuò de jǐhé zhèngmíngtí, lìyòng wǎnzìxí shíjiān jìnxíng le xiángjìn de zhēnduìxìng fǔdǎo.',
        meaning_vi: 'Thầy giáo căn cứ vào những bài toán chứng minh hình học mà các em học sinh thường mắc lỗi trong kỳ thi giữa kỳ, đã tận dụng giờ tự học buổi tối để hướng dẫn bổ trợ chi tiết có mục tiêu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '商务部针对部分进口商品低价倾销扰乱国内市场秩序的不正当竞争行为，依法依规启动了反倾销立案调查程序。',
        pinyin: 'Shāngwùbù zhēnduì bùfen jìnkǒu shāngpǐn dījià qīngxiāo rǎoluàn guónèi shìchǎng zhìxù de bú-zhèngdàng jìngzhēng xíngwéi, yīfǎ-yīguī qǐdòng le fǎn-qīngxiāo lì\'àn diàochá chéngxù.',
        meaning_vi: 'Bộ Thương mại nhằm vào hành vi cạnh tranh không lành mạnh bán phá giá giá thấp làm rối loạn trật tự thị trường nội địa của một bộ phận hàng hóa nhập khẩu, đã khởi động quy trình lập án điều tra chống bán phá giá theo đúng pháp luật và quy chuẩn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3483,
    hanzi: '珍贵',
    pinyin: 'zhēnguì',
    word_type: 'Tính từ',
    meaning_vi: 'quý giá, trân quý',
    examples: [
      {
        chinese: '爷爷珍藏着一张几十年前的老战友合影照片，对他而言这是一份无比珍贵的青春记忆。',
        pinyin: 'Yéye zhēncáng zhe yì zhāng jǐshí nián qián de lǎo zhànyǒu héyǐng zhàopiàn, duì tā éryán zhè shì yí fèn wúbǐ zhēnguì de qīngchūn jìyì.',
        meaning_vi: 'Ông nội trân quý cất giữ một bức ảnh chụp chung với những đồng đội cũ từ mấy chục năm trước, đối với ông đó là một kỷ niệm thanh xuân quý giá khôn xiết.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家重大科学装置获取的高能粒子对撞实验珍贵原始物理数据，由全球数十家科研院所组成的国际合作组实行开源共享。',
        pinyin: 'Guójiā zhòngdà kēxué zhuāngzhì huòqǔ de gāonéng lìzǐ duìzhuàng shíyàn zhēnguì yuánshǐ wùlǐ shùjù, yóu quánqiú shùshí jiā kēyán yuànsuǒ zǔchéng de guójì hézuòzǔ shíxíng kāiyuán gòngxiǎng.',
        meaning_vi: 'Dữ liệu vật lý gốc quý giá từ thí nghiệm va chạm hạt năng lượng cao thu thập được bởi thiết bị khoa học trọng đại quốc gia được nhóm hợp tác quốc tế gồm hàng chục viện nghiên cứu toàn cầu thực hiện chia sẻ mã nguồn mở.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3484,
    hanzi: '真实',
    pinyin: 'zhēnshí',
    word_type: 'Tính từ',
    meaning_vi: 'chân thực, chân thật, có thật',
    examples: [
      {
        chinese: '这部根据真实历史事件改编的励志电影情节感人至深，给现场所有观众带来了巨大的心灵震撼。',
        pinyin: 'Zhè bù gēnjù zhēnshí lìshǐ shìjiàn gǎibiān de lìzhì diànyǐng qíngjié gǎnrén zhì shēn, gěi xiànchǎng suǒyǒu guānzhòng dài lái le jùdà de xīnlíng zhènhàn.',
        meaning_vi: 'Bộ phim truyền cảm hứng được cải biên dựa trên sự kiện lịch sử có thật này tình tiết vô cùng cảm động, đem lại chấn động tâm can to lớn cho toàn bộ khán giả tại rạp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '上市公司必须确保对外披露的财务报表与经营业绩信息真实、准确、完整，严禁任何形式的会计造假与虚假陈述。',
        pinyin: 'Shàngshì gōngsī bìxū quèbǎo duìwài pīlù de cáiwù bàobiǎo yǔ jīngyíng yèjì xìnxī zhēnshí, zhǔnquè, wánzhěng, yánjìn rènhé xíngshì de kuàijì zàojiǎ yǔ xūjiǎ chénshù.',
        meaning_vi: 'Công ty niêm yết bắt buộc phải bảo đảm các báo cáo tài chính và thông tin kết quả kinh doanh công bố ra bên ngoài là chân thực, chuẩn xác và đầy đủ, nghiêm cấm mọi hình thức gian lận làm giả kế toán và trình bày khống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3485,
    hanzi: '珍惜',
    pinyin: 'zhēnxī',
    word_type: 'Động từ',
    meaning_vi: 'trân trọng, quý trọng, giữ gìn',
    examples: [
      {
        chinese: '青春年华转瞬即逝，我们应该珍惜在校园里潜心求学的宝贵时光，努力提升自己。',
        pinyin: 'Qīngchūn niánhuá zhuǎnshùn-jíshì, wǒmen yīnggāi zhēnxī zài xiàoyuán lǐ qiánxīn qiúxué de bǎoguì shíguāng, nǔlì tíshēng zìjǐ.',
        meaning_vi: 'Năm tháng tuổi trẻ thoáng qua như chớp mắt, chúng ta nên trân trọng quãng thời gian quý báu chuyên tâm học tập nơi giảng đường để nỗ lực hoàn thiện bản thân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际社会呼吁各国珍惜难能可贵的和平发展环境，通过平等对话化解安全分歧，共同维护多边贸易体制与全球供应链稳定。',
        pinyin: 'Guójì shèhuì hūyù gèguó zhēnxī nánnéng-kěguì de hépíng fāzhǎn huánjìng, tōngguò píngděng duìhuà huàjiě ānquán fēnqí, gòngtóng wéihù duōbiān màoyì tǐzhì yǔ quánqiú gōngyìngliàn wěndìng.',
        meaning_vi: 'Cộng đồng quốc tế kêu gọi các quốc gia trân trọng môi trường phát triển hòa bình quý báu hiếm có, thông qua đối thoại bình đẳng để hóa giải bất đồng an ninh, cùng nhau gìn giữ thể chế thương mại đa phương và sự ổn định của chuỗi cung ứng toàn cầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3486,
    hanzi: '诊断',
    pinyin: 'zhěnduàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'chẩn đoán (bệnh lý, lỗi kỹ thuật)',
    examples: [
      {
        chinese: '经过血液生化常规化验与胸部CT扫描，主治医师最终给出了非常明确的病情诊断结果。',
        pinyin: 'Jīngguò xiěyè shēnghuà chángguī huàyàn yǔ xiōngbù CT sǎomiáo, zhǔzhì yīshī zuìzhōng gěichū le fēicháng míngquè de bìngqíng zhěnduàn jiéguǒ.',
        meaning_vi: 'Trải qua xét nghiệm sinh hóa máu thông thường và chụp cắt lớp CT lồng ngực, bác sĩ điều trị chính cuối cùng đã đưa ra kết quả chẩn đoán bệnh trạng rất rõ ràng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '工业物联网设备搭载多轴高频振动传感器与AI声纹算法，能够实现对核电机组高速主轴轴承微米级磨损的远程智能在线早期诊断。',
        pinyin: 'Gōngyè wùliánwǎng shèbèi dāzài duō-zhóu gāopín zhèndòng chuángǎnqì yǔ AI shēngwén suànfǎ, nénggòu shíxiàn duì hédiàn jīzǔ gāosù zhǔzhóu zhóuchéng wēimǐjí mósǔn de yuǎnchéng zhìnéng zàixiàn zǎoqī zhěnduàn.',
        meaning_vi: 'Thiết bị IoT công nghiệp tích hợp cảm biến rung động cao tần đa trục và thuật toán vân âm thanh AI, có thể hiện thực hóa việc chẩn đoán sớm trực tuyến thông minh từ xa đối với độ hao mòn cấp micromet của vòng bi trục chính tốc độ cao trên tổ máy điện hạt nhân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3487,
    hanzi: '阵',
    pinyin: 'zhèn',
    word_type: 'Lượng từ / Danh từ',
    meaning_vi: 'trận, cơn, hồi (sự việc diễn ra trong thời gian ngắn)',
    examples: [
      {
        chinese: '午后天空突然乌云密布，伴随着一阵电闪雷鸣，窗外下起了一场痛痛快快的雷阵雨。',
        pinyin: 'Wǔhòu tiānkōng tūrán wūyún-mìbù, bànsuí zhe yí zhèn diànshǎn-léimíng, chuāngwài xià qǐ le yì chǎng tòngtòng-kuàikuài de léizhènyǔ.',
        meaning_vi: 'Sau buổi trưa bầu trời bỗng chốc mây đen giăng kín, kèm theo một hồi sấm chớp chớp nhoáng, ngoài cửa sổ đổ xuống một trận mưa rào sấm sét sảng khoái.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家级天文台射电望远镜阵列成功捕捉到了来自遥远深空脉冲星的一阵高能快速射电暴信号，为揭开恒星演化之谜提供了关键观测证据。',
        pinyin: 'Guójiājí tiānwéntái shèdiàn wàngyuǎnjìng zhènliè chénggōng bǔzhuō dào le láizì yáoyuǎn shēnkōng màichōngxīng de yí zhèn gāonéng kuàisù shèdiànbào xìnhào, wèi jiēkāi héngxīng yǎnhuà zhī mǐ tígōng le guānjiàn guāncè zhèngjù.',
        meaning_vi: 'Mảng kính viễn vọng vô tuyến của đài thiên văn cấp quốc gia đã thu nhận thành công một đợt bùng nổ vô tuyến nhanh năng lượng cao đến từ ngôi sao xung ở vũ trụ xa xôi, cung cấp bằng chứng quan sát then chốt cho việc giải mã bí ẩn tiến hóa sao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3488,
    hanzi: '争',
    pinyin: 'zhēng',
    word_type: 'Động từ',
    meaning_vi: 'tranh, tranh giành, phấn đấu, tranh cãi',
    examples: [
      {
        chinese: '同学们在课堂讨论中各抒己见，争着回答老师提出的问题，课堂气氛十分活跃。',
        pinyin: 'Tóngxuémen zài kètáng tǎolùn zhōng gèshū-jǐjiàn, zhēng zhe huídá lǎoshī tíchū de wèntí, kètáng qìfēn shífēn huóyuè.',
        meaning_vi: 'Các bạn học sinh trong buổi thảo luận trên lớp thi nhau bày tỏ quan điểm riêng, tranh nhau trả lời câu hỏi thầy giáo đưa ra, bầu không khí lớp học vô cùng sôi nổi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在全球新一轮科技革命中，主要经济体都在分秒必争地加大在人工智能芯片与量子信息等未来前沿产业的核心技术投入。',
        pinyin: 'Zài quánqiú xīn-yì-lún kējì gémìng zhōng, zhǔyào jīngjìtǐ dōu zài fēnjiǎo-bìzhēng de jiādà zài réngōng zhìnéng xīnpiàn yǔ liàngzǐ xìnxī děng wèilái qiányán chǎnyè de héxīn jìshù tóurù.',
        meaning_vi: 'Trong làn sóng cách mạng khoa học công nghệ mới toàn cầu, các nền kinh tế chủ chốt đều đang tranh từng phút từng giây tăng cường đầu tư công nghệ cốt lõi vào các ngành công nghiệp mũi nhọn tương lai như chip AI và thông tin lượng tử.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3489,
    hanzi: '争取',
    pinyin: 'zhēngqǔ',
    word_type: 'Động từ',
    meaning_vi: 'tranh thủ, nỗ lực đạt được, phấn đấu giành lấy',
    examples: [
      {
        chinese: '既然报名前提条件已经完全符合，你就应该努力争取这次公派出国交流访学的难得机会。',
        pinyin: 'Jìrán bàomíng qiántí tiáojiàn yǐjīng wánquán fúhé, nǐ jiù yīnggāi nǔlì zhēngqǔ zhè cì gōngpài chūguó jiāoliú fǎngxué de nándé jīhuì.',
        meaning_vi: 'Một khi điều kiện tiên quyết đăng ký đã hoàn toàn đáp ứng, bạn nên nỗ lực tranh thủ cơ hội hiếm có này để được cử đi giao lưu học thuật ở nước ngoài bằng ngân sách nhà nước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '项目团队正分秒必争地推进核心代码自动化测试与系统集成，争取在下周一前全面上线跨境支付新版本系统。',
        pinyin: 'Xiàngmù tuánduì zhèng fēnjiǎo-bìzhēng de tuījìn héxīn dàimǎ zìdònghuà cèshì yǔ xìtǒng jíchéng, zhēngqǔ zài xià zhōuyī qián quánmiàn shàngxiàn kuàjìng zhīfù xīn-bǎnběn xìtǒng.',
        meaning_vi: 'Đội ngũ dự án đang tranh thủ từng giây từng phút đẩy mạnh việc kiểm thử tự động mã nguồn cốt lõi và tích hợp hệ thống, nỗ lực đưa hệ thống phiên bản mới về thanh toán xuyên biên giới lên mạng hoàn chỉnh trước thứ Hai tuần sau.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3490,
    hanzi: '整齐',
    pinyin: 'zhěngqí',
    word_type: 'Tính từ',
    meaning_vi: 'ngay ngắn, gọn gàng, ngăn nắp, đồng đều',
    examples: [
      {
        chinese: '图书管理员把阅览室书架上的所有参考书籍都摆放得整整齐齐，极大方便了师生们借阅查找。',
        pinyin: 'Túshū guǎnlǐyuán bǎ yuèlǎnshì shūjià shang de suǒyǒu cānkǎo shūjí dōu bǎifàng de zhěngzhěng-qíqí, jídà fāngbiàn le shīshēngmen jièyuè cházhǎo.',
        meaning_vi: 'Người quản thư sắp xếp toàn bộ sách tham khảo trên giá sách trong phòng đọc một cách ngay ngắn gọn gàng, tạo thuận lợi rất lớn cho thầy trò mượn đọc tra cứu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '超洁净现代化半导体晶圆制造车间内，数百台自动化天车机械臂正在整齐划一的轨道上高效运送高精度光刻晶圆载具。',
        pinyin: 'Chāo-jiéjìng xiàndàihuà bàndǎotǐ jīngyuán zhìzào chējiān nèi, shùbǎi tái zìdònghuà tiānchē jīxièbì zhèngzài zhěngqí-huàyī de guǐdào shang gāoxiào yùnsòng gāojīngdù guāngkè jīngyuán zàijù.',
        meaning_vi: 'Bên trong phân xưởng chế tạo tấm wafer bán dẫn hiện đại siêu sạch, hàng trăm cánh tay robot xe trục tự động đang vận chuyển hộp chứa wafer quang khắc độ chính xác cao một cách hiệu quả trên các đường ray ngay ngắn tăm tắp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3491,
    hanzi: '整体',
    pinyin: 'zhěngtǐ',
    word_type: 'Danh từ',
    meaning_vi: 'chỉnh thể, toàn bộ, tổng thể',
    examples: [
      {
        chinese: '室内设计师在装修房屋时不仅注重局部细节的美观，更强调家具颜色与房屋整体风格的和谐统一。',
        pinyin: 'Shìnèi shèjìshī zài zhuāngxiū fángwū shí bù jǐn zhùzhòng júbù xìjié de měiguān, gèng qiángdiào jiājù yánsè yǔ fángwū zhěngtǐ fēnggé de héxié tǒngyī.',
        meaning_vi: 'Nhà thiết kế nội thất khi trang trí nhà cửa không chỉ chú trọng đến vẻ đẹp thẩm mỹ của từng chi tiết cục bộ, mà còn đặc biệt nhấn mạnh sự hài hòa thống nhất giữa màu sắc đồ nội thất với phong cách tổng thể của ngôi nhà.',
        difficulty_level: 'basic'
      },
      {
        chinese: '推进国家现代化治理体系建设必须树立全国一盘棋思维，强化跨部门跨层级跨区域的整体协同与宏观政策取向一致性。',
        pinyin: 'Tuījìn guójiā xiàndàihuà zhìlǐ tǐxì jiànshè bìxū shùlì quánguó-yìpánqí sīwéi, qiánghuà kuà-bùmén kuà-céngjí kuà-qūyù de zhěngtǐ xiétóng yǔ hóngguān zhèngcè qǔxiàng yízhìxìng.',
        meaning_vi: 'Đẩy mạnh xây dựng hệ thống quản trị hiện đại hóa quốc gia bắt buộc phải xác lập tư duy toàn quốc một bàn cờ, tăng cường sự phối hợp tổng thể xuyên ban ngành, xuyên cấp bậc, xuyên vùng miền và tính nhất quán trong định hướng chính sách vĩ mô.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3492,
    hanzi: '整整',
    pinyin: 'zhěngzhěng',
    word_type: 'Phó từ',
    meaning_vi: 'tròn trĩnh, ròng rã, đúng trọn',
    examples: [
      {
        chinese: '为了撰写完成这篇高质量的高中毕业论文，他在市图书馆查阅资料整整坐了一个下午。',
        pinyin: 'Wèile zhuànxiě wánchéng zhè piān gāozhìliàng de gāozhōng bìyè lùnwén, tā zài shì túshūguǎn chàyuè zīliào zhěngzhěng zuò le yí ge xiàwǔ.',
        meaning_vi: 'Để hoàn thành bài luận văn tốt nghiệp trung học phổ thông chất lượng cao này, anh ấy đã ngồi tra cứu tài liệu trong thư viện thành phố ròng rã suốt một buổi chiều.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科研攻坚团队在荒无人烟的沙漠试验基地历经整整五年封闭攻关，终于成功研制出具有世界领先水平的新型耐高温航空复合材料。',
        pinyin: 'Kēyán gōngjiān tuánduì zài huāngwúrényān de shāmò shìyàn jīdì lìjīng zhěngzhěng wǔ nián fēngbì gōngguān, zhōngyú chénggōng yánzhì chū jùyǒu shìjiè lǐngxiān shuǐpíng de xīnxíng nài-gāowēn hángkōng fùhé cáiliào.',
        meaning_vi: 'Đội ngũ nghiên cứu khoa học đột phá tại căn cứ thử nghiệm giữa sa mạc không một bóng người đã trải qua ròng rã tròn năm năm nghiên cứu biệt lập khép kín, rốt cuộc đã chế tạo thành công loại vật liệu composite hàng không chịu nhiệt độ cao kiểu mới có trình độ dẫn đầu thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3493,
    hanzi: '挣',
    pinyin: 'zhèng',
    word_type: 'Động từ',
    meaning_vi: 'kiếm (tiền), kiếm sống',
    examples: [
      {
        chinese: '许多大学生利用寒暑假在咖啡店或辅导机构做兼职，以此挣一些零花钱来补贴学费。',
        pinyin: 'Xǔduō dàxuéshēng lìyòng hán-shǔjià zài kāfēidiàn huò fǔdǎo jīgòu zuò jiānzhí, yǐcǐ zhèng yìxiē línghuāqián lái bǔtiē xuéfèi.',
        meaning_vi: 'Nhiều sinh viên đại học tận dụng kỳ nghỉ đông và hè để làm thêm tại các quán cà phê hoặc trung tâm gia sư, qua đó kiếm thêm một chút tiền tiêu vặt bù đắp học phí.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代科技型企业必须彻底摆脱依靠消耗廉价劳动力和低端代工挣微薄辛苦钱的粗放模式，坚定转向以自主核心专利获取高技术溢价。',
        pinyin: 'Xiàndài kējìxíng qǐyè bìxū chèdǐ bǎituō yīlài xiāohào liánjià láodònglì hé dīduān dàigōng zhèng wēibó xīnkǔqián de cūfàng móshì, jiāndìng zhuǎnhuàng yǐ zìzhǔ héxīn zhuānlì huòqǔ gāojìshù yìjià.',
        meaning_vi: 'Doanh nghiệp thuộc loại hình khoa học công nghệ hiện đại bắt buộc phải thoát khỏi hoàn toàn mô hình thô sơ dựa vào tiêu hao lao động giá rẻ và gia công cấp thấp kiếm đồng tiền còm cõi nhọc nhằn, kiên định chuyển sang việc dùng sáng chế độc quyền cốt lõi tự chủ để thu về giá trị gia tăng công nghệ cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3494,
    hanzi: '政府',
    pinyin: 'zhèngfǔ',
    word_type: 'Danh từ',
    meaning_vi: 'chính phủ, chính quyền',
    examples: [
      {
        chinese: '当地政府近年来大力投资兴建乡村硬化公路和自来水管网，显著改善了偏远村民的生活条件。',
        pinyin: 'Dāngdì zhèngfǔ jìnnián lái dàlì tóuzī xīngjiàn xiāngcūn yìnghuà gōnglù hé zìláishuǐ guǎnwǎng, xiǎnzhù gǎishàn le piānyuǎn cūnmín de shēnghuó tiáojiàn.',
        meaning_vi: 'Chính quyền địa phương những năm gần đây đã đầu tư mạnh mẽ xây dựng đường nhựa bê tông nông thôn và mạng lưới đường ống nước máy, cải thiện rõ rệt điều kiện sống của dân làng vùng sâu vùng xa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '多国政府在联合国框架下联合签署了具有法律约束力的全球海洋塑料污染防治公约，承诺建立全生命周期的塑料废物循环回收法定监管机制。',
        pinyin: 'Duōguó zhèngfǔ zài Liánhéguó kuàngjià xià liánhé qiānshǔ le jùyǒu fǎlǜ yuēshùlì de quánqiú hǎiyáng sùliào wūrǎn fángzhì gōngyuē, chéngnuò jiànlì quán-shēngmìng-zhōuqī de sùliào fèiwù xúnhuán huíshōu fǎdìng jiānguǎn jīzhì.',
        meaning_vi: 'Chính phủ nhiều quốc gia dưới khuôn khổ Liên Hợp Quốc đã cùng ký kết công ước toàn cầu về phòng chống ô nhiễm rác thải nhựa đại dương có tính ràng buộc pháp lý, cam kết thiết lập cơ chế giám sát pháp định về thu gom tái chế rác thải nhựa trong toàn bộ vòng đời.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3495,
    hanzi: '证据',
    pinyin: 'zhèngjù',
    word_type: 'Danh từ',
    meaning_vi: 'chứng cứ, bằng chứng',
    examples: [
      {
        chinese: '交通警察调取了路口的高清监控录像，作为判定这起交通事故全责方的关键直接证据。',
        pinyin: 'Jiāotōng jǐngchá diàoqǔ le lùkǒu de gāoqīng jiānkòng lùxiàng, zuòwéi pàndìng zhè qǐ jiāotōng shìgù quánzéfāng de guānjiàn zhíjiē zhèngjù.',
        meaning_vi: 'Cảnh sát giao thông đã trích xuất đoạn video giám sát độ nét cao ở ngã tư, dùng làm bằng chứng trực tiếp then chốt để phán định bên chịu toàn bộ trách nhiệm trong vụ tai nạn giao thông này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际司法仲裁严格坚持法定证据裁判原则，排除一切通过非法手段获取或缺乏合法区块链时间戳校验的电子取证证据。',
        pinyin: 'Guójì sīfǎ zhòngcái yángé jiānchí fǎdìng zhèngjù cáipàn yuánzé, páichú yíqiè tōngguò fēifǎ shǒuduàn huòqǔ huò quēfá héfǎ qūkuàiliàn shíjiānchuō jiàoyàn de diànzǐ qǔzhèng zhèngjù.',
        meaning_vi: 'Trọng tài tư pháp quốc tế kiên trì thực hiện nghiêm ngặt nguyên tắc phán quyết dựa trên bằng chứng theo luật định, loại trừ mọi chứng cứ thu thập điện tử thu được thông qua thủ đoạn phi pháp hoặc thiếu sự đối chiếu tem thời gian chuỗi khối hợp pháp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3496,
    hanzi: '正如',
    pinyin: 'zhèngrú',
    word_type: 'Động từ',
    meaning_vi: 'đúng như, hệt như, giống như',
    examples: [
      {
        chinese: '天气预报正如播报员所预测的那样，午后果然下起了入冬以来的第一场洁白大雪。',
        pinyin: 'Tiānqì yùbào zhèngrú bōbàoyuán suǒ yùcè de nàyàng, wǔhòu guǒrán xià qǐ le rùdōng yǐlái de dì-yī chǎng jiébái dàxuě.',
        meaning_vi: 'Dự báo thời tiết đúng như những gì phát thanh viên đã dự đoán, sau buổi trưa quả nhiên đã đổ xuống trận tuyết trắng xóa lớn đầu tiên kể từ khi vào đông.',
        difficulty_level: 'basic'
      },
      {
        chinese: '正如著名经济学家在年度宏观展望报告中所断言的那样，数字经济与实体经济的深度融合正成为驱动产业跨越式发展的最核心引擎。',
        pinyin: 'Zhèngrú zhùmíng jīngjìxuéjiā zài niándù hóngguān zhǎnwàng bàogào zhōng suǒ duànyán de nàyàng, shùzì jīngjì yǔ shítǐ jīngjì de shēndù rónghé zhèng chéngwéi qūdòng chǎnyè kuàyuèshì fāzhǎn de zuì héxīn yǐnqíng.',
        meaning_vi: 'Đúng như những gì nhà kinh tế học nổi tiếng đã khẳng định trong báo cáo triển vọng vĩ mô thường niên, sự dung hợp sâu sắc giữa kinh tế số và kinh tế thực thể đang trở thành động cơ cốt lõi nhất thúc đẩy sự phát triển nhảy vọt của ngành công nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3497,
    hanzi: '证书',
    pinyin: 'zhèngshū',
    word_type: 'Danh từ',
    meaning_vi: 'chứng thư, văn bằng, giấy chứng nhận',
    examples: [
      {
        chinese: '经过半年的刻苦自学与模拟练习，他顺利通过了全国翻译专业资格考试并拿到了职业资格证书。',
        pinyin: 'Jīngguò bàn nián de kèkǔ zìxué yǔ mónǐ liànxí, tā shùnlì tōngguò le quánguó fānyì zhuānyè zīgé kǎoshì bìng ná dào le zhíyè zīgé zhèngshū.',
        meaning_vi: 'Trải qua nửa năm tự học khổ công và luyện thi thử, anh ấy đã vượt qua kỳ thi sát hạch tư cách chuyên ngành dịch thuật toàn quốc một cách thuận lợi và nhận được chứng chỉ hành nghề.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际公钥基础设施体系通过多级数字根证书信任链加密与在线证书状态协议，确保跨国金融机构间敏感交易指令的防篡改与不可抵赖。',
        pinyin: 'Guójì gōngyào jīchǔ shèshī tǐxì tōngguò duōjí shùzì gēn-zhèngshū xìnrènliàn jiāmì yǔ zàixiàn zhèngshū zhuàngtài xiédìng, quèbǎo kuàguó jīnróng jīgòu jiān mǐngǎn jiāoyì zhǐlìng de fáng-cuàngǎi yǔ bùkě-dǐlài.',
        meaning_vi: 'Hệ thống hạ tầng khóa công khai quốc tế thông qua mã hóa chuỗi ủy thác chứng thư gốc số đa cấp và giao thức trạng thái chứng thư trực tuyến, bảo đảm lệnh giao dịch nhạy cảm giữa các tổ chức tài chính xuyên quốc gia có khả năng chống giả mạo và không thể chối bỏ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3498,
    hanzi: '政治',
    pinyin: 'zhèngzhì',
    word_type: 'Danh từ',
    meaning_vi: 'chính trị',
    examples: [
      {
        chinese: '作为当代大学生，不仅要在专业课堂上学好专业知识，也要关心国家政治与社会民生大事。',
        pinyin: 'Zuòwéi dāngdài dàxuéshēng, bù jǐn yào zài zhuānyè kètáng shang xué hǎo zhuānyè zhīshi, yě yào guānxīn guójiā zhèngzhì yǔ shèhuì mínshēng dàshì.',
        meaning_vi: 'Là sinh viên đại học đương đại, không chỉ cần học tốt kiến thức chuyên môn trên giảng đường chuyên ngành, mà còn phải quan tâm đến những vấn đề lớn về chính trị quốc gia và dân sinh xã hội.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在全球地缘政治格局深刻重塑的复杂背景下，坚持多边主义与维护以国际法为基础的国际秩序成为捍卫世界和平的核心共识。',
        pinyin: 'Zài quánqiú dìyuán zhèngzhì géjú shēndù chóngsù de fùzá bèijǐng xià, jiānchí duōbiānzhǔyì yǔ wéihù yǐ guójìfǎ wéi jīchǔ de guójì zhìxù chéngwéi hànwèi shìjiè hépíng de héxīn gòngshí.',
        meaning_vi: 'Trong bối cảnh phức tạp của sự tái định hình sâu sắc cục diện địa chính trị toàn cầu, kiên trì chủ nghĩa đa phương và gìn giữ trật tự quốc tế trên cơ sở luật pháp quốc tế trở thành đồng thuận cốt lõi bảo vệ hòa bình thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3499,
    hanzi: '支',
    pinyin: 'zhī',
    word_type: 'Lượng từ / Động từ',
    meaning_vi: 'cây, que; chi đội; chi trả, chống đỡ',
    examples: [
      {
        chinese: '这支黑色的签字笔不仅出水流畅、手感舒适，而且写出来的字迹清晰不容易褪色。',
        pinyin: 'Zhè zhī hēisè de qiānzìbǐ bù jǐn chūshuǐ liúchàng, shǒugǎn shūshì, érqiě xiě chūlái de zìjì qīngxī bù róngyì tuìsè.',
        meaning_vi: 'Cây bút ký màu đen này không chỉ ra mực trơn tru, cầm vừa tay dễ chịu, mà chữ viết ra còn sắc nét và khó phai màu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家紧急从全国抽调了一支由顶尖流行病学家与重症医学专家组成的国家级医疗队，日夜兼程奔赴震灾前线指导抢险救援。',
        pinyin: 'Guójiā jǐnjí cóng quánguó chōudiào le yì zhī yóu dǐngjiān liúxíngbìngxuéjiā yǔ zhòngzhèng yīxué zhuānjiā zǔchéng de guójiājí yīliáoduì, rìyè-jiānchéng bēnfù zhènzāi qiánxiàn zhǐdǎo qiǎngxiǎn jiùyuán.',
        meaning_vi: 'Nhà nước đã khẩn cấp điều động một đội ngũ y tế cấp quốc gia gồm các nhà dịch tễ học và chuyên gia y học hồi sức cấp cứu hàng đầu, ngày đêm không ngừng chạy đua tới tiền tuyến vùng thảm họa động đất để chỉ đạo công tác cứu hộ khẩn cấp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3500,
    hanzi: '知名',
    pinyin: 'zhīmíng',
    word_type: 'Tính từ',
    meaning_vi: 'nổi tiếng, có tiếng tăm, lừng danh',
    examples: [
      {
        chinese: '几位国际知名建筑设计师受邀参与了市中心新地标博物馆的设计竞标方案评审。',
        pinyin: 'Jǐ wèi guójì zhīmíng jiànzhù shèjìshī shòuyāo cānyù le shìzhōngxīn xīn-dìbiāo bówùguǎn de shèjì jìngbiāo fāng\'àn píngshěn.',
        meaning_vi: 'Mấy vị kiến trúc sư nổi tiếng quốc tế đã nhận lời mời tham gia buổi chấm điểm phương án đấu thầu thiết kế bảo tàng biểu tượng mới ở trung tâm thành phố.',
        difficulty_level: 'basic'
      },
      {
        chinese: '知名跨国科技巨头设立的开源基础软件基金会，致力于资助全球开发者社区共同维护核心编译器与分布式操作系统内核。',
        pinyin: 'Zhīmíng kuàguó kējì jùtóu shèlì de kāiyuán jīchǔ ruǎnjiàn jījīnhuì, zhìlì yú zīzhù quánqiú kāifāzhě shèqū gòngtóng wéihù héxīn biānyìqì yǔ fēnbùshì cāozuò xìtǒng nèihé.',
        meaning_vi: 'Quỹ phần mềm nền tảng mã nguồn mở do tập đoàn công nghệ xuyên quốc gia lừng danh thành lập chuyên tâm tài trợ cộng đồng các nhà phát triển toàn cầu cùng duy trì trình biên dịch cốt lõi và nhân hệ điều hành phân tán.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3501,
    hanzi: '直',
    pinyin: 'zhí',
    word_type: 'Tính từ / Động từ / Phó từ',
    meaning_vi: 'thẳng; trực tiếp; cứ mãi, thẳng thắn',
    examples: [
      {
        chinese: '沿着这条宽阔的人行道一直往东走五百米，你就能看到那座造型壮观的现代图书馆了。',
        pinyin: 'Yán zhe zhè tiáo kuānkuò de rénxíngdào yìzhí wǎng dōng zǒu wǔbǎi mǐ, nǐ jiù néng kàndào nà zuò zàoxíng zhuàngguān de xiàndài túshūguǎn le.',
        meaning_vi: 'Cứ men theo lối đi bộ rộng rãi này đi thẳng về hướng đông năm trăm mét, bạn sẽ thấy được thư viện hiện đại với tạo hình hoành tráng đó.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该高新技术产业园区的直通高速物流通道实现了海关通关与国际空港口岸的直连直通，极大压缩了企业跨境进出口的物流周转周期。',
        pinyin: 'Gāi gāoxīn-jìshù chǎnyè yuánqū de zhítōng gāosù wùliú tōngdào shíxiàn le hǎiguān tōngguān yǔ guójì kōnggǎng kǒu\'àn de zhílián-zhítōng, jídà yāsuō le qǐyè kuàjìng jìn-chūkǒu de wùliú zhōuzhuǎn zhōuqī.',
        meaning_vi: 'Hành lang logistics cao tốc thông suốt của khu công nghiệp công nghệ cao này đã hiện thực hóa việc kết nối thẳng trực tiếp giữa thông quan hải quan và cửa khẩu cảng hàng không quốc tế, rút ngắn rất lớn chu kỳ luân chuyển logistics xuất nhập khẩu xuyên biên giới của doanh nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  }
]
