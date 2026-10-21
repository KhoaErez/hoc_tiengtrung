// data/hsk5-batch11-part1-data.ts
// 25 từ HSK 5: #3002 [胜利] -> #3026 [使得]

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

export const HSK5_BATCH11_PART1: VocabItem[] = [
  {
    id: 3002,
    hanzi: '胜利',
    pinyin: 'shènglì',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'thắng lợi, chiến thắng',
    examples: [
      {
        chinese: '经过顽强拼搏，校足球队在比赛最后一分钟攻入制胜进球并赢得了胜利。',
        pinyin: 'Jīngguò wánqiáng pīnbó, xiào zúqiúduì zài bǐsài zuìhòu yì fēnzhōng gōngrù zhìshèng jìnqiú bìng yíngdé le shènglì.',
        meaning_vi: 'Trải qua nỗ lực chiến đấu kiên cường, đội bóng đá của trường đã ghi bàn thắng quyết định ở phút cuối cùng của trận đấu và giành được thắng lợi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在抗击世纪疫情与恢复经济增长的复杂大考中，全体人民同舟共济赢得了决定性胜利。',
        pinyin: 'Zài kàngjī shìjì yiqíng yǔ huīfù jīngjì zēngzhǎng de fùzá dàkǎo zhōng, quántǐ rénmín tóngzhōu-gòngjì yíngdé le juédìngxìng shènglì.',
        meaning_vi: 'Trong cuộc sát hạch cam go phức tạp về đẩy lùi đại dịch thế kỷ và phục hồi tăng trưởng kinh tế, toàn thể nhân dân đồng lòng kề vai sát cánh đã giành được thắng lợi mang tính quyết định.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3003,
    hanzi: '诗',
    pinyin: 'shī',
    word_type: 'Danh từ',
    meaning_vi: 'thơ ca, bài thơ',
    examples: [
      {
        chinese: '语文老师要求同学们有感情地朗诵唐代大诗人李白的经典诗篇。',
        pinyin: 'Yǔwén lǎoshī yāoqiú tóngxuémen yǒu gǎnqíng de lǎngsòng Tángdài dà shīrén Lǐ Bái de jīngdiǎn shīpiān.',
        meaning_vi: 'Thầy giáo dạy ngữ văn yêu cầu các bạn học sinh diễn cảm ngâm đọc các bài thơ kinh điển của đại thi hào Lý Bạch thời Đường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中国古典诗词以格律严谨、意象深邃与气象万千著称，是中华优秀传统文化中最璀璨的艺术瑰宝。',
        pinyin: 'Zhōngguó gǔdiǎn shīcí yǐ gélǜ yánjǐn, yìxiàng shēnsuì yǔ qìxiàng-wànqiān zhùchēng, shì Zhōnghuá yōuxiù chuántǒng wénhuà zhōng zuì cuǐcàn de yìshù guībǎo.',
        meaning_vi: 'Thơ từ cổ điển Trung Hoa nổi tiếng bởi cách luật nghiêm cẩn, hình tượng ý niệm thâm thúy và khí tượng muôn màu muôn vẻ, là viên ngọc quý nghệ thuật rực rỡ nhất trong nền văn hóa truyền thống xuất sắc của Trung Hoa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3004,
    hanzi: '湿',
    pinyin: 'shī',
    word_type: 'Tính từ',
    meaning_vi: 'ẩm ướt, ướt át',
    examples: [
      {
        chinese: '今天下了一整天暴雨，路面很湿，开车外出一定要减速慢行。',
        pinyin: 'Jīntiān xià le yì zhěng tiān bàoyǔ, lùmiàn hěn shī, kāichē wàichū yídìng yào jiǎnsù mànxíng.',
        meaning_vi: 'Hôm nay trời đổ mưa to suốt cả ngày, mặt đường rất ướt, lái xe ra ngoài nhất định phải giảm tốc độ đi chậm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '沿海地区夏秋季节气候湿热，工业仓储必须严格实施温湿度智能监控以防止高精密精密元器件受潮霉变。',
        pinyin: 'Yánhǎi dìqū xiàqiū jìjié qìhòu shīrè, gōngyè cāngchǔ bìxū yángé shíshī wēn-shīdù zhìnéng jiānkòng yǐ fángzhǐ gāo-jīngmì jīngmì yuánqìjiàn shòucháo méibiàn.',
        meaning_vi: 'Khu vực ven biển vào mùa hè thu khí hậu nóng ẩm, kho bãi công nghiệp bắt buộc phải thực thi giám sát thông minh nhiệt độ và độ ẩm nghiêm ngặt để chống các linh kiện siêu chính xác bị ẩm mốc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3005,
    hanzi: '失恋',
    pinyin: 'shīliàn',
    word_type: 'Động từ',
    meaning_vi: 'thất tình, chia tay người yêu',
    examples: [
      {
        chinese: '面对失恋的痛苦，朋友们纷纷陪在他身边给予温暖的开导和安慰。',
        pinyin: 'Miànduì shīliàn de tòngkǔ, péngyoumen fēnfēn péi zài tā shēnbiān jǐyǔ wēnnuǎn de kāidǎo hé ānwèi.',
        meaning_vi: 'Đối mặt với nỗi đau thất tình, bạn bè tới tấp ở bên cạnh anh ấy để sẻ chia khuyên nhủ và an ủi ấm áp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '青年心理健康咨询中心开设情绪辅导专线，引导年轻人理性看待失恋挫折并重塑健康的自我认同。',
        pinyin: 'Qīngnián xīnlǐ jiànkāng zīxún zhōngxīn kāishè qíngxù fǔdǎo zhuānxiàn, yǐndǎo niánqīngrén lǐxìng kàndài shīliàn cuòzhé bìng chóngshù jiànkāng de zìwǒ rèntóng.',
        meaning_vi: 'Trung tâm tư vấn sức khỏe tâm lý thanh niên mở đường dây nóng hướng dẫn cảm xúc, định hướng người trẻ nhìn nhận trắc trở thất tình một cách lý trí và tái định hình sự tự công nhận bản thân lành mạnh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3006,
    hanzi: '失眠',
    pinyin: 'shīmián',
    word_type: 'Động từ',
    meaning_vi: 'mất ngủ, khó ngủ',
    examples: [
      {
        chinese: '最近由于期末备考压力较大，他连续好几天都处于失眠状态。',
        pinyin: 'Zuìjìn yóuyú qīmò bèikǎo yālì jiào dà, tā liánxù hǎo jǐ tiān dōu chǔyú shīmián zhuàngtài.',
        meaning_vi: 'Gần đây do áp lực ôn thi học kỳ khá lớn, anh ấy đã trải qua tình trạng mất ngủ suốt mấy ngày liền.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代快节奏高压职场环境引发慢性失眠群体比例攀升，医学专家建议通过睡眠卫生行为干预配合昼夜节律调节。',
        pinyin: 'Xiàndài kuài-jiézòu gāoyā zhíchǎng huánjìng yǐnfā mànxìng shīmián qúntǐ bǐlì pānshēng, yīxué zhuānjiā jiànyì tōngguò shuìmián wèishēng xíngwéi gānyù pèihé zhòuyè jiélǜ tiáojié.',
        meaning_vi: 'Môi trường nơi làm việc áp lực cao nhịp độ gấp gáp hiện đại khiến tỷ lệ nhóm người mất ngủ mãn tính tăng vọt, các chuyên gia y học khuyến nghị can thiệp hành vi vệ sinh giấc ngủ kết hợp điều hòa nhịp điệu sinh học ngày đêm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3007,
    hanzi: '诗人',
    pinyin: 'shīrén',
    word_type: 'Danh từ',
    meaning_vi: 'nhà thơ, thi sĩ',
    examples: [
      {
        chinese: '这位当代诗人用质朴动人的语言，抒发了对故土乡村深沉的眷恋。',
        pinyin: 'Zhè wèi dāngdài shīrén yòng zhìpǔ dòngrén de yǔyán, shūfā le duì gùtǔ xiāngcūn shēnchén de juànliàn.',
        meaning_vi: 'Nhà thơ đương đại này đã dùng ngôn từ mộc mạc lay động lòng người để bày tỏ nỗi luyến lưu sâu nặng đối với mảnh đất quê hương.',
        difficulty_level: 'basic'
      },
      {
        chinese: '古代爱国诗人屈原在《离骚》中展现的崇高人格追求与忧国忧民情怀，成为千百年来激励中华民族自强不息的精神图腾。',
        pinyin: 'Gǔdài àiguó shīrén Qū Yuán zài 《Lí Sāo》 zhōng zhǎnxiàn de chónggāo réngé zhuīqiú yǔ yōuguó-yōumín qínghuái, chéngwéi qiānbǎinián lái jīlì Zhōnghuá mínzú zìqiáng-bùxī de jīngshén túténg.',
        meaning_vi: 'Khát vọng nhân cách cao thượng cùng tấm lòng ưu quốc ưu dân mà nhà thơ yêu nước cổ đại Khuất Nguyên thể hiện trong tác phẩm "Ly Tao" đã trở thành biểu tượng tinh thần cổ vũ dân tộc Trung Hoa tự cường không ngừng nghỉ suốt hàng ngàn năm qua.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3008,
    hanzi: '失误',
    pinyin: 'shīwù',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'sai sót, sơ suất, lỗi lầm',
    examples: [
      {
        chinese: '在正式提交财务报表之前，会计师反复核对数据以防出现计算失误。',
        pinyin: 'Zài zhèngshì tíjiāo cáiwù bàobiǎo zhīqián, kuàijìshī fǎnfù héduì shùjù yǐ fáng chūxiàn jìsuàn shīwù.',
        meaning_vi: 'Trước khi chính thức nộp báo cáo tài chính, kế toán viên đã kiểm tra đối chiếu dữ liệu nhiều lần để phòng ngừa sai sót tính toán.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大型化工与高风险轨道交通调度系统必须设立多重冗余容错机制，将人为操作失误带来的安全隐患降至零。',
        pinyin: 'Dàxíng huàgōng yǔ gāo-fēngxiǎn guǐdào jiāotōng diàodù xìtǒng bìxū shèlì duōchóng rǒngyú róngcuò jīzhì, jiāng rénwéi cāozuò shīwù dài lái de ānquán yǐnhuàn jiàng zhì líng.',
        meaning_vi: 'Hệ thống điều độ giao thông đường sắt rủi ro cao và hóa chất quy mô lớn bắt buộc phải thiết lập cơ chế chịu lỗi dự phòng đa tầng, hạ thấp nguy cơ mất an toàn do sơ suất thao tác con người gây ra về mức bằng không.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3009,
    hanzi: '失业',
    pinyin: 'shīyè',
    word_type: 'Động từ',
    meaning_vi: 'thất nghiệp, mất việc làm',
    examples: [
      {
        chinese: '政府设立了专门的再就业服务中心，帮助失业人员免费参加技能培训。',
        pinyin: 'Zhèngfǔ shèlì le zhuānmén de zàijiùyè fúwù zhōngxīn, bāngzhù shīyè rényuán miǎnfèi cānjiā jìnéng péixùn.',
        meaning_vi: 'Chính quyền đã thành lập trung tâm dịch vụ tái tạo việc làm chuyên trách, hỗ trợ người thất nghiệp tham gia các khóa đào tạo kỹ năng nghề miễn phí.',
        difficulty_level: 'basic'
      },
      {
        chinese: '宏观经济政策强化就业优先导向，通过减税降费与援企稳岗等综合举措有效防范化解摩擦性与结构性失业风险。',
        pinyin: 'Hóngguān jīngjì zhèngcè qiánghuà jiùyè yōuxiān dǎoxiàng, tōngguò jiǎnshuì-jiàngfèi yǔ yuánqǐ-wěngǎng děng zōnghé jǔcuò yǒuxiào fángfàn huàjiě mócāxìng yǔ jiégòuxìng shīyè fēngxiǎn.',
        meaning_vi: 'Chính sách kinh tế vĩ mô củng cố định hướng ưu tiên việc làm, thông qua các giải pháp tổng hợp như giảm thuế giảm phí và hỗ trợ doanh nghiệp giữ việc làm để phòng ngừa và hóa giải hữu hiệu rủi ro thất nghiệp cơ cấu và thất nghiệp ma sát.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3010,
    hanzi: '时差',
    pinyin: 'shíchā',
    word_type: 'Danh từ',
    meaning_vi: 'chênh lệch múi giờ, mệt mỏi do lệch múi giờ',
    examples: [
      {
        chinese: '刚从欧洲坐长途飞机回国，这两天他一直在努力倒时差。',
        pinyin: 'Gāng cóng Ōuzhōu zuò chángtú fēijī huíguó, zhè liǎng tiān tā yìzhí zài nǔlì dǎo shíchā.',
        meaning_vi: 'Vừa đi chuyến bay đường dài từ châu Âu trở về nước, suốt hai ngày nay anh ấy luôn cố gắng thích nghi để đổi múi giờ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '跨大洲分布式跨国研发团队充分利用跨时区时差优势，构建了全天候二十四小时接力式的敏捷协作工作流。',
        pinyin: 'Kuà dàzhōu fēnbùshì kuàguó yánfā tuánduì chōngfèn lìyòng kuà-shíqū shíchā yōushì, gòujiàn le quán-tiānhòu èrshísì xiǎoshí jiēlìshì de mǐnjié xiézuò gōngzuòliú.',
        meaning_vi: 'Đội ngũ nghiên cứu phát triển xuyên quốc gia phân tán đa châu lục đã tận dụng triệt để lợi thế chênh lệch múi giờ liên múi giờ, xây dựng luồng công việc cộng tác linh hoạt dạng chạy tiếp sức suốt 24 giờ ngày đêm.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3011,
    hanzi: '时常',
    pinyin: 'shícháng',
    word_type: 'Phó từ',
    meaning_vi: 'thường thường, thỉnh thoảng, hay',
    examples: [
      {
        chinese: '离家在外工作的游子，心里时常惦记着家乡年迈的父母。',
        pinyin: 'Lí jiā zài wài gōngzuò de yóuzǐ, xīn lǐ shícháng diànjì zhe jiāxiāng niánmài de fùmǔ.',
        meaning_vi: 'Người con xa nhà đi làm nơi đất khách, trong lòng thường hay đau đáu nhớ về cha mẹ già nơi quê nhà.',
        difficulty_level: 'basic'
      },
      {
        chinese: '优秀的科研工作者时常反躬自问自己的研究方向是否真正面向国家重大战略需求与世界前沿难题。',
        pinyin: 'Yōuxiù de kēyán gōngzuòzhě shícháng fǎngōng-zìwèn zìjǐ de yánjiū fāngxiàng shìfǒu zhēnzhèng miànxiàng guójiā zhòngdà zhànlüè xūqiú yǔ shìjiè qiányán nándiǎn.',
        meaning_vi: 'Những nhà nghiên cứu khoa học xuất sắc thường xuyên tự vấn bản thân xem hướng nghiên cứu của mình liệu đã thực sự hướng tới các nhu cầu chiến lược trọng đại của quốc gia và bài toán hóc búa mũi nhọn của thế giới hay chưa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3012,
    hanzi: '时代',
    pinyin: 'shídài',
    word_type: 'Danh từ',
    meaning_vi: 'thời đại, kỷ nguyên',
    examples: [
      {
        chinese: '智能手机的普及标志着移动互联网时代已经全面到来。',
        pinyin: 'Zhìnéng shǒujī de pǔjí biāozhì zhe yídòng hùliánwǎng shídài yǐjīng quánmiàn dàolái.',
        meaning_vi: 'Sự phổ cập của điện thoại thông minh đánh dấu thời đại Internet di động đã hoàn toàn gõ cửa cuộc sống.',
        difficulty_level: 'basic'
      },
      {
        chinese: '站在数字化与低碳化交织的全新历史时代节点，广大青年科技人员当勇立潮头担负起科技强国的历史重任。',
        pinyin: 'Zhàn zài shùzìhuà yǔ dītànhuà jiāozhī de quánxīn lìshǐ shídài jiédiǎn, guǎngdà qīngnián kējì rényuán dāng yǒnglì-cháotóu dānfù qǐ kējì qiángguó de lìshǐ zhòngrèn.',
        meaning_vi: 'Đứng tại nút giao thời đại lịch sử hoàn toàn mới đan xen giữa số hóa và ít carbon, đông đảo nhân sự khoa học công nghệ trẻ tuổi cần phải dũng cảm đứng đầu ngọn sóng gánh vác trọng trách lịch sử đưa đất nước hùng cường bằng khoa học công nghệ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3013,
    hanzi: '实践',
    pinyin: 'shíjiàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'thực tiễn; thực hành, đem ra thực tế',
    examples: [
      {
        chinese: '只有把书本上学到的理论知识运用到工作实践中，才能转化为真正的能力。',
        pinyin: 'Zhǐyǒu bǎ shūběn shang xué dào de lǐlùn zhīshi yùnyòng dào gōngzuò shíjiàn zhōng, cái néng zhuǎnhuà wèi zhēnzhèng de nénglì.',
        meaning_vi: 'Chỉ khi vận dụng kiến thức lý thuyết đã học trong sách vở vào thực tiễn công việc thì mới có thể chuyển hóa thành năng lực thực sự.',
        difficulty_level: 'basic'
      },
      {
        chinese: '实践是检验真理的唯一标准，任何宏观经济制度设计与重大改革举措都必须经过一线社会实践的实证检验。',
        pinyin: 'Shíjiàn shì jiǎnyàn zhēnlǐ de wéiyī biāozhǔn, rènhé hóngguān jīngjì zhìdù shèjì yǔ zhòngdà gǎigé jǔcuò dōu bìxū jīngguò yíxiàn shèhuì shíjiàn de shízhèng jiǎnyàn.',
        meaning_vi: 'Thực tiễn là tiêu chuẩn duy nhất để kiểm nghiệm chân lý, bất kỳ thiết kế thể chế kinh tế vĩ mô và biện pháp cải cách trọng đại nào cũng bắt buộc phải trải qua sự kiểm nghiệm thực chứng của thực tiễn xã hội tuyến đầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3014,
    hanzi: '时刻',
    pinyin: 'shíkè',
    word_type: 'Danh từ / Phó từ',
    meaning_vi: 'thời khắc, thời điểm; luôn luôn, từng giờ từng phút',
    examples: [
      {
        chinese: '在比赛进入最后倒计时的关键时刻，队长沉着投中了压哨三分球。',
        pinyin: 'Zài bǐsài jìnrù zuìhòu dàojìshí de guānjiàn shíkè, duìzhǎng chénzhuó tóu zhòng le yāshào sānfēnqiú.',
        meaning_vi: 'Vào thời khắc then chốt khi trận đấu bước vào đếm ngược cuối cùng, đội trưởng đã điềm tĩnh ném trúng quả bóng ba điểm ấn định tỷ số.',
        difficulty_level: 'basic'
      },
      {
        chinese: '重大基础设施工程建设必须时刻绷紧施工质量与生产安全这根弦，坚决杜绝任何侥幸麻痹心理。',
        pinyin: 'Zhòngdà jīchǔ shèshī gōngchéng jiànshè bìxū shíkè bēngjǐn shīgōng zhìliàng yǔ shēngchǎn ānquán zhè gēn xián, jiānjué dùjué rènhé jiǎoxìng mábì xīnlǐ.',
        meaning_vi: 'Xây dựng công trình cơ sở hạ tầng trọng điểm phải luôn luôn kéo căng sợi dây chất lượng thi công và an toàn sản xuất, kiên quyết bài trừ mọi tâm lý ỷ lại chủ quan lơ là.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3015,
    hanzi: '实力',
    pinyin: 'shílì',
    word_type: 'Danh từ',
    meaning_vi: 'thực lực, sức mạnh thực sự',
    examples: [
      {
        chinese: '这两支决赛队伍整体实力相当，比赛过程异常激烈精彩。',
        pinyin: 'Zhè liǎng zhī juésài duìwu zhěngtǐ shílì xiāngdāng, bǐsài guòchéng yìcháng jīliè jīngcǎi.',
        meaning_vi: 'Hai đội tuyển vào chung kết này có thực lực tổng thể ngang tài ngang sức, diễn biến trận đấu vô cùng gay cấn đặc sắc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '强大的基础研究能力、完备的高端制造业门类与充沛的工程师红利，构成了国家综合科技实力的核心底盘。',
        pinyin: 'Qiángdà de jīchǔ yánjiū nénglì, wánbèi de gāoduān zhìzàoyè ménlèi yǔ chōngpèi de gōngchéngshī hónglì, gòuchéng le guójiā zōnghé kējì shílì de héxīn dǐpán.',
        meaning_vi: 'Năng lực nghiên cứu cơ bản hùng mạnh, danh mục ngành chế tạo cao cấp hoàn thiện và nguồn lợi tức kỹ sư dồi dào đã cấu thành nền tảng cốt lõi của thực lực khoa học công nghệ tổng hợp quốc gia.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3016,
    hanzi: '时期',
    pinyin: 'shíqī',
    word_type: 'Danh từ',
    meaning_vi: 'thời kỳ, giai đoạn',
    examples: [
      {
        chinese: '中学时期是青少年世界观、人生观和价值观形成的关键阶段。',
        pinyin: 'Zhōngxué shíqī shì qīng-shàonián shìjièguān, rénshēngguān hé jiàzhíguān xíngchéng de guānjiàn jiēduàn.',
        meaning_vi: 'Thời kỳ học trung học là giai đoạn then chốt hình thành thế giới quan, nhân sinh quan và giá trị quan của thanh thiếu niên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '当前我国经济正处于转变发展方式、优化经济结构与转换增长动力的关键攻坚时期。',
        pinyin: 'Dāngqián wǒguó jīngjì zhèng chǔyú zhuǎnbiàn fāzhǎn fāngshì, yōuhuà jīngjì jiégòu yǔ zhuǎnhuàn zēngzhǎng dònglì de guānjiàn gōngjiān shíqī.',
        meaning_vi: 'Hiện nay nền kinh tế nước ta đang ở vào thời kỳ then chốt đột phá về chuyển đổi phương thức phát triển, tối ưu hóa cơ cấu kinh tế và hoán chuyển động lực tăng trưởng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3017,
    hanzi: '实施',
    pinyin: 'shíshī',
    word_type: 'Động từ',
    meaning_vi: 'thực thi, thực hiện, triển khai',
    examples: [
      {
        chinese: '新修订的城市生活垃圾分类管理条例自下月起正式实施。',
        pinyin: 'Xīn xiūdìng de chéngshì shēnghuó lājī fēnlèi guǎnlǐ tiáolì zì xiàyuè qǐ zhèngshì shíshī.',
        meaning_vi: 'Điều lệ quản lý phân loại rác thải sinh hoạt đô thị mới sửa đổi sẽ chính thức thực thi từ tháng sau.',
        difficulty_level: 'basic'
      },
      {
        chinese: '全面实施自由贸易试验区提升战略，稳步扩大规则、规制、管理、标准等制度型开放。',
        pinyin: 'Quánmiàn shíshī zìyóu màoyì shìyànqū tíshēng zhànlüè, wěnbù kuòdà guīzé, guīzhì, guǎnlǐ, biāozhǔn děng zhìdùxíng kāifàng.',
        meaning_vi: 'Thực thi toàn diện chiến lược nâng cấp khu thí nghiệm thương mại tự do, mở rộng vững chắc độ mở cửa mang tính thể chế như quy tắc, quy chế, quản lý và tiêu chuẩn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3018,
    hanzi: '石头',
    pinyin: 'shítou',
    word_type: 'Danh từ',
    meaning_vi: 'hòn đá, tảng đá',
    examples: [
      {
        chinese: '小河边铺满了一块块被流水冲刷得十分圆润光滑的鹅卵石石头。',
        pinyin: 'Xiǎohé biān pūmǎn le yí kuàikuài bèi liúshuǐ chōngshuā de shífēn yuánrùn guānghua de éluǎnshí shítou.',
        meaning_vi: 'Ven con suối nhỏ rải đầy những hòn đá cuội được dòng nước xối mòn vô cùng tròn trịa trơn nhẵn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '地质科考队员深入高山峡谷，采集不同地质年代的典型沉积岩与变质岩石头岩心样本以解构板块构造演变史。',
        pinyin: 'Dìzhì kēkǎo duìyuán shēnrù gāoshān xiágǔ, cǎijí bùtóng dìzhì niándài de diǎnxíng chénjīyán yǔ biànzhìyán shítou yánxīn yàngběn yǐ jiěgòu bǎnkuài gòuzào yǎnbiànshǐ.',
        meaning_vi: 'Các thành viên đội khảo sát địa chất đi sâu vào các hẻm núi cao vút, thu thập các mẫu lõi đá trầm tích và đá biến chất điển hình thuộc các niên đại địa chất khác nhau nhằm giải mã lịch sử tiến hóa kiến tạo mảng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3019,
    hanzi: '实习',
    pinyin: 'shíxí',
    word_type: 'Động từ',
    meaning_vi: 'thực tập, đi thực tập',
    examples: [
      {
        chinese: '大四上学期，许多同学都前往各家知名企事业单位进行为期半年的岗位实习。',
        pinyin: 'Dàsì shàngxuéqī, xǔduō tóngxué dōu qiánwǎng gè jiā zhīmíng qǐ-shìyè dānwèi jìnxíng wéiqī bàn nián de gǎngwèi shíxí.',
        meaning_vi: 'Học kỳ một năm thứ tư, nhiều bạn sinh viên đã đến các cơ quan doanh nghiệp danh tiếng để thực tập vị trí việc làm trong thời hạn nửa năm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '医学院临床医学专业学生在三甲教学医院接受系统规范的住院医师规范化培训与全科临床轮转实习。',
        pinyin: 'Yīxuéyuàn línchuáng yīxué zhuānyè xuéshēng zài sānjiǎ jiàoxué yīyuàn jiēshòu xìtǒng guīfàn de zhùyuàn yīshī guīfànhuà péixùn yǔ quánkē línchuáng lúnzhuàn shíxí.',
        meaning_vi: 'Sinh viên chuyên ngành y học lâm sàng của trường đại học y tiếp nhận chương trình đào tạo chuẩn hóa bác sĩ nội trú quy củ có hệ thống và thực tập luân khoa lâm sàng đa khoa tại bệnh viện thực hành tuyến một.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3020,
    hanzi: '实现',
    pinyin: 'shíxiàn',
    word_type: 'Động từ',
    meaning_vi: 'thực hiện, hiện thực hóa, đạt được',
    examples: [
      {
        chinese: '只要付出坚持不懈的努力，每个人心中的理想都一定能够实现。',
        pinyin: 'Zhǐyào fùchū jiānchí-bùxiè de nǔlì, měi ge rén xīn zhōng de lǐxiǎng dōu yídìng nénggòu shíxiàn.',
        meaning_vi: 'Chỉ cần bỏ ra nỗ lực kiên trì bền bỉ, lý tưởng trong trái tim của mỗi người đều nhất định có thể trở thành hiện thực.',
        difficulty_level: 'basic'
      },
      {
        chinese: '以科技自立自强支撑引领现代化产业体系建设，是全面实现高质量发展与中国式现代化的战略基石。',
        pinyin: 'Yǐ kējì zìlì-zìqiáng zhīchēng yǐnlǐng xiàndàihuà chǎnyè tǐxì jiànshè, shì quánmiàn shíxiàn gāo-zhìliàng fāzhǎn yǔ Zhōngguóshì xiàndàihuà de zhànlüè jīshí.',
        meaning_vi: 'Lấy tự lực tự cường khoa học công nghệ làm trụ cột dẫn dắt xây dựng hệ thống sản xuất hiện đại là nền tảng chiến lược để hiện thực hóa toàn diện phát triển chất lượng cao và hiện đại hóa kiểu Trung Quốc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3021,
    hanzi: '实行',
    pinyin: 'shíxíng',
    word_type: 'Động từ',
    meaning_vi: 'thực hành, áp dụng, thi hành',
    examples: [
      {
        chinese: '该图书馆实行周一至周日全天候无休开放政策，方便读者随时借还书籍。',
        pinyin: 'Gāi túshūguǎn shíxíng zhōuyī zhì zhōurì quán-tiānhòu wú xiū kāifàng zhèngcè, fāngbiàn dúzhě suíshí jiè-huán shūjí.',
        meaning_vi: 'Thư viện này áp dụng chính sách mở cửa suốt ngày đêm không ngày nghỉ từ thứ Hai đến Chủ Nhật, tạo thuận tiện cho bạn đọc mượn trả sách bất kỳ lúc nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '资本市场全面实行股票发行注册制改革，强化以信息披露为核心的透明监管，推动市场资源配置功能高效发挥。',
        pinyin: 'Zīběn shìchǎng quánmiàn shíxíng gǔpiào fāxíng zhùcèzhì gǎigé, qiánghuà yǐ xìnxī pīlù wéi héxīn de tòumíng jiānguǎn, tuīdòng shìchǎng zīyuán pèizhì gōngnéng gāoxiào fāhuī.',
        meaning_vi: 'Thị trường vốn thực hiện toàn diện cải cách chế độ đăng ký phát hành cổ phiếu, củng cố sự giám sát minh bạch lấy công bố thông tin làm cốt lõi, thúc đẩy phát huy hiệu quả công năng phân bổ tài nguyên của thị trường.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3022,
    hanzi: '实验',
    pinyin: 'shíyàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'thí nghiệm, làm thí nghiệm; cuộc thí nghiệm',
    examples: [
      {
        chinese: '化学课上，同学们在老师的指导下小心翼翼地完成了酸碱中和反应实验。',
        pinyin: 'Huàxuékè shang, tóngxuémen zài lǎoshī de zhǐdǎo xià xiǎoxīn-yìyì de wánchéng le suān-jiǎn zhōnghé fǎnyìng shíyàn.',
        meaning_vi: 'Trong giờ hóa học, các bạn học sinh dưới sự hướng dẫn của thầy giáo đã cẩn thận hoàn thành thí nghiệm phản ứng trung hòa axit - bazơ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '量子保密通信实验卫星成功完成千公里级星地双向量子纠缠分发实验，证实了爱因斯坦广义相对论下的量子纠缠非定域性。',
        pinyin: 'Liàngzǐ bǎomì tōngxìn shíyàn wèixīng chénggōng wánchéng qiāngōnglǐ jí xīng-dì shuāngxiàng liàngzǐ jiūchán fēnfā shíyàn, zhèngshí le Àiyīnsītǎn guǎngyì xiāngduìlùn xià de liàngzǐ jiūchán fēi-dìngyùxìng.',
        meaning_vi: 'Vệ tinh thí nghiệm truyền thông bảo mật lượng tử đã hoàn thành thành công thí nghiệm phân phối vướng víu lượng tử hai chiều sao - đất cấp nghìn kilomet, chứng minh tính phi định xứ của vướng víu lượng tử dưới thuyết tương đối rộng của Einstein.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3023,
    hanzi: '实验室',
    pinyin: 'shíyànshì',
    word_type: 'Danh từ',
    meaning_vi: 'phòng thí nghiệm, phòng nghiên cứu',
    examples: [
      {
        chinese: '进入化学实验室前，所有人必须穿好白色实验服并戴好护目镜。',
        pinyin: 'Jìnrù huàxué shíyànshì qián, suǒyǒu rén bìxū chuān hǎo báisè shíyànfú bìng dài hǎo hùmùjìng.',
        meaning_vi: 'Trước khi bước vào phòng thí nghiệm hóa học, mọi người bắt buộc phải mặc áo blouse trắng và đeo kính bảo hộ cẩn thận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '重组国家重点实验室体系并优化基础学科前沿交叉布局，旨在打造世界一流的战略科技力量国家队。',
        pinyin: 'Chóngzǔ guójiā zhòngdiǎn shíyànshì tǐxì bìng yōuhuà jīchǔ xuékē qiányán jiāochā bùjú, zhǐ zài dǎzào shìjiè yīliú de zhànlüè kējì lìliàng guójiāduì.',
        meaning_vi: 'Tái cơ cấu hệ thống phòng thí nghiệm trọng điểm quốc gia và tối ưu hóa bố trí giao thoa mũi nhọn các ngành khoa học cơ bản nhằm mục tiêu xây dựng đội tuyển quốc gia lực lượng khoa học công nghệ chiến lược đẳng cấp thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3024,
    hanzi: '实用',
    pinyin: 'shíyòng',
    word_type: 'Tính từ',
    meaning_vi: 'thực dụng, có giá trị sử dụng cao, thiết thực',
    examples: [
      {
        chinese: '这本旅行指南不仅地图绘制得非常清晰，还包含许多实用的出行省钱小技巧。',
        pinyin: 'Zhè běn lǚxíng zhǐnán bùjǐn dìtú huìzhì de fēicháng qīngxī, hái bāohán xǔduō shíyòng de chūxíng shěngqián xiǎo jìqiǎo.',
        meaning_vi: 'Cuốn cẩm nang du lịch này không chỉ vẽ bản đồ rất rõ ràng mà còn chứa đựng rất nhiều mẹo nhỏ tiết kiệm chi phí đi lại vô cùng thiết thực.',
        difficulty_level: 'basic'
      },
      {
        chinese: '科技研发评价体系要摒弃片面追求论文发表数量的倾向，更加注重成果的实际工程应用价值与产业转化实用性。',
        pinyin: 'Kējì yánfā píngjià tǐxì yào bìngqì piànmiàn zhuīqiú lùnwén fābiǎo shùliàng de qīngxiàng, gèngjiā zhùzhòng chéngguǒ de shíjì gōngchéng yìngyòng jiàzhí yǔ chǎnyè zhuǎnhuà shíyòngxìng.',
        meaning_vi: 'Hệ thống đánh giá nghiên cứu phát triển khoa học công nghệ cần loại bỏ khuynh hướng chạy theo số lượng bài báo công bố một cách phiến diện, coi trọng hơn giá trị ứng dụng công trình thực tế và tính thực dụng trong chuyển giao sản xuất của thành quả.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3025,
    hanzi: '食用',
    pinyin: 'shíyòng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'ăn, dùng làm thực phẩm; thực phẩm ăn được',
    examples: [
      {
        chinese: '这种野生蘑菇含有剧毒，严禁采摘或烹饪食用。',
        pinyin: 'Zhè zhǒng yěshēng mógu hán yǒu jùdú, yánjìn cǎizhāi huò pēngrèn shíyòng.',
        meaning_vi: 'Loại nấm mọc hoang này có chứa chất kịch độc, nghiêm cấm hái lượm hoặc chế biến đem ăn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家食品安全标准严格界定食品级添加剂的安全残留限量，保障食用油、乳制品与婴幼儿配方食品的终极安全底线。',
        pinyin: 'Guójiā shípǐn ānquán biāozhǔn yángé jièdìng shípǐnjí tiānjiājì de ānquán cánliú xiànliàng, bǎozhàng shíyòngyóu, rǔzhìpǐn yǔ yīng-yòu’ér pèifāng shípǐn de zhōngjí ānquán dǐxiàn.',
        meaning_vi: 'Tiêu chuẩn an toàn thực phẩm quốc gia định rõ giới hạn dư lượng an toàn của các phụ gia cấp thực phẩm, bảo đảm giới hạn đỏ an toàn tuyệt đối cho dầu ăn, chế phẩm từ sữa và thực phẩm công thức cho trẻ sơ sinh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3026,
    hanzi: '使得',
    pinyin: 'shǐde',
    word_type: 'Động từ',
    meaning_vi: 'khiến cho, làm cho',
    examples: [
      {
        chinese: '突如其来的一场大雪，使得整个城市的高速公路不得不全线封闭。',
        pinyin: 'Tūrúqílái de yì chǎng dàxuě, shǐde zhěng ge chéngshì de gāosù gōnglù bùdébù quánxiàn fēngbì.',
        meaning_vi: 'Trận tuyết lớn bất ngờ ập đến đã khiến cho toàn bộ các tuyến đường cao tốc của cả thành phố buộc phải phong tỏa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '数字基础设施的持续完善与超算算力集群的普及，使得海量跨领域复杂科研数据的大规模并发模拟推演成为现实。',
        pinyin: 'Shùzì jīchǔ shèshī de chíxù wánshàn yǔ chāosuàn suànlì jǐqún de pǔjí, shǐde hǎiliàng kuà-lǐngyù fùzá kēyán shùjù de dà-guīmó bīngfā mónǐ tuīyǎn chéngwéi xiànshí.',
        meaning_vi: 'Sự hoàn thiện liên tục của cơ sở hạ tầng số cùng việc phổ cập cụm năng lực tính toán siêu máy tính đã khiến cho việc mô phỏng suy luận đồng thời quy mô lớn lượng dữ liệu nghiên cứu khoa học phức tạp liên lĩnh vực trở thành hiện thực.',
        difficulty_level: 'applied'
      }
    ]
  }
]
