// data/hsk5-batch8-part1-data.ts
// 25 từ HSK 5: #2702 [里头] -> #2726 [领带]

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

export const HSK5_BATCH8_PART1: VocabItem[] = [
  {
    id: 2702,
    hanzi: '里头',
    pinyin: 'lǐtou',
    word_type: 'Danh từ',
    meaning_vi: 'bên trong, phía trong',
    examples: [
      {
        chinese: '打开这个木盒子，里头整整齐齐地放着一套精美的茶具。',
        pinyin: 'Dǎkāi zhè gè mù hézi, lǐtou zhěngzhěng-qíqí de fàng zhe yí tào jīngměi de chájù.',
        meaning_vi: 'Mở chiếc hộp gỗ này ra, bên trong đặt ngay ngắn một bộ ấm chén pha trà tinh xảo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '这项看似寻常的产业技术改造工程，其实里头大有学问，涉及材料力学与高精度流体力学的深度融合。',
        pinyin: 'Zhè xiàng kànsì xúncháng de chǎnyè jìshù gǎizào gōngchéng, qíshí lǐtou dàyǒu-xuéwen, shèjí cáiliào lìxué yǔ gāo jīngdù liútǐ lìxué de shēndù rónghé.',
        meaning_vi: 'Công trình cải tạo kỹ thuật công nghiệp thoạt nhìn tưởng như bình thường này, thực ra bên trong ẩn chứa rất nhiều tri thức sâu xa, liên quan đến sự kết hợp sâu rộng giữa cơ học vật liệu và cơ học chất lưu độ chính xác cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2703,
    hanzi: '理由',
    pinyin: 'lǐyóu',
    word_type: 'Danh từ',
    meaning_vi: 'lý do, nguyên cớ',
    examples: [
      {
        chinese: '他因突发高烧不能参加期末考试，并向教务处提交了医院的请假理由证明。',
        pinyin: 'Tā yīn tūfā gāoshāo bùnéng cānjiā qīmò kǎoshì, bìng xiàng jiàowùchù tíjiāo le yīyuàn de qǐngjià lǐyóu zhèngmíng.',
        meaning_vi: 'Anh ấy do đột ngột sốt cao không thể tham gia thi cuối kỳ, và đã nộp giấy chứng nhận lý do xin nghỉ phép của bệnh viện cho phòng đào tạo.',
        difficulty_level: 'basic'
      },
      {
        chinese: '司法裁判文书必须全面阐述法官采纳或排除各项核心证据的法理理由，以确保司法审判的透明度与公信力。',
        pinyin: 'Sīfǎ cáipàn wénshū bìxū quánmiàn chǎnshù fǎguān cǎinà huò páichú gè xiàng héxīn zhèngjù de fǎlǐ lǐyóu, yǐ quèbǎo sīfǎ shěnpàn de tòumíngdù yǔ gōngxìnlì.',
        meaning_vi: 'Văn bản phán quyết tư pháp phải trình bày toàn diện lý lẽ pháp lý của thẩm phán khi chấp nhận hoặc loại bỏ các chứng cứ cốt lõi, nhằm bảo đảm tính minh bạch và uy tín công quyền của xét xử tư pháp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2704,
    hanzi: '力',
    pinyin: 'lì',
    word_type: 'Danh từ',
    meaning_vi: 'sức, lực, sức lực, năng lực',
    examples: [
      {
        chinese: '搬运重物时要注意用力均匀，以免拉伤腰部肌肉。',
        pinyin: 'Bānyùn zhòngwù shí yào zhùyì yòng lì jūnyún, yǐmiǎn lāshāng yāobù jīròu.',
        meaning_vi: 'Khi bốc vác đồ vật nặng cần chú ý dùng lực đều đặn để tránh làm căng rách cơ lưng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在激烈的全球高科技产业竞争中，企业唯有全面提升自主创新力、品牌竞争力和国际抗风险力，方能立于不败之地。',
        pinyin: 'Zài jīliè de quánqiú gāo kējì chǎnyè jìngzhēng zhōng, qǐyè wéiyǒu quánmiàn tíshēng zìzhǔ chuàngxīnlì, pǐnpái jìngzhēnglì hé guójì kàng fēngxiǎnlì, fāng néng lìyú búbàizhīdì.',
        meaning_vi: 'Trong cuộc cạnh tranh công nghiệp công nghệ cao khốc liệt toàn cầu, doanh nghiệp chỉ có nâng cao toàn diện năng lực đổi mới tự chủ, sức cạnh tranh thương hiệu và khả năng kháng cự rủi ro quốc tế thì mới có thể đứng vững ở vị thế bất bại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2705,
    hanzi: '立即',
    pinyin: 'lìjí',
    word_type: 'Phó từ',
    meaning_vi: 'ngay lập tức, tức khắc',
    examples: [
      {
        chinese: '接到火灾报警电话后，消防队员们立即穿好防护服奔赴事故现场。',
        pinyin: 'Jiēdào huǒzāi bàojǐng diànhuà hòu, xiāofáng duìyuánmen lìjí chuān hǎo fánghùfú bēnfù shìgù xiànchǎng.',
        meaning_vi: 'Sau khi nhận được điện thoại báo cháy, các chiến sĩ cứu hỏa ngay lập tức mặc trang phục bảo hộ và lao tới hiện trường vụ việc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对突发的跨境金融网络黑客攻击，网络安全应急响应小组立即切断外网连接并实施全网防御阻断策略。',
        pinyin: 'Miànduì tūfā de kuàjìng jīnróng wǎngluò hēikè gōngjī, wǎngluò ānquán yìngjí xiǎngyìng xiǎozǔ lìjí qiēduàn wàiwǎng liánjiē bìng shíshī quánwǎng fángyù zǔduàn cèlüè.',
        meaning_vi: 'Đối mặt với cuộc tấn công mạng của tin tặc vào hệ thống tài chính xuyên biên giới nổ ra bất ngờ, tổ ứng cứu khẩn cấp an ninh mạng đã lập tức ngắt kết nối mạng ngoài và triển khai chiến lược phòng thủ chặn lọc toàn mạng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2706,
    hanzi: '立刻',
    pinyin: 'lìkè',
    word_type: 'Phó từ',
    meaning_vi: 'tức khắc, ngay tức khắc, liền',
    examples: [
      {
        chinese: '看到老人摔倒在马路上，几名热心路人立刻上前将他小心扶起。',
        pinyin: 'Kàndào lǎorén shuāidǎo zài mǎlù shang, jǐ míng rèxīn lùrén lìkè shàngqián jiāng tā xiǎoxīn fúqǐ.',
        meaning_vi: 'Nhìn thấy cụ già vấp ngã trên đường, vài người đi đường tốt bụng liền lập tức tiến tới cẩn thận đỡ cụ dậy.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在监测到地质滑坡预警信号的第一时间，现场指挥部立刻下达了全员撤离指令，成功避免了重大人员伤亡。',
        pinyin: 'Zài jiāncè dào dìzhì huápō yùjǐng xìnhào de dì-yī shíjiān, xiànchǎng zhǐhuībù lìkè xiàdá le quányuán chèlí zhǐlìng, chénggōng bìmǐan le zhòngdà rényuán shāngwáng.',
        meaning_vi: 'Ngay khoảnh khắc phát hiện tín hiệu cảnh báo sạt lở địa chất, ban chỉ huy hiện trường lập tức ban bố lệnh sơ tán toàn bộ lực lượng, ngăn chặn thành công thương vong nghiêm trọng về người.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2707,
    hanzi: '力量',
    pinyin: 'lìliàng',
    word_type: 'Danh từ',
    meaning_vi: 'sức mạnh, lực lượng',
    examples: [
      {
        chinese: '团结就是力量，只要全班同学齐心协力就一定能夺取比赛冠军。',
        pinyin: 'Tuánjié jiùshì lìliàng, zhǐyào quán bān tóngxué qíxīn-xiélì jiù yídìng néng duóqǔ bǐsài guànjūn.',
        meaning_vi: 'Đoàn kết chính là sức mạnh, chỉ cần cả lớp đồng lòng chung sức nhất định sẽ giành được cúp vô địch cuộc thi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在推进国家高水平科技自立自强的历史征程中，国家实验室与国家科研机构构成了核心战略科技力量。',
        pinyin: 'Zài tuījìn guójiā gāo shuǐpíng kējì zìlì-zìqiáng de lìshǐ zhēngchéng zhōng, guójiā shíyànshì yǔ guójiā kēyán jīgòu gòuchéng le héxīn zhànlüè kējì lìliàng.',
        meaning_vi: 'Trong hành trình lịch sử thúc đẩy khoa học công nghệ quốc gia tự lực tự cường trình độ cao, các phòng thí nghiệm quốc gia cùng viện nghiên cứu quốc gia tạo nên lực lượng khoa học công nghệ chiến lược cốt lõi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2708,
    hanzi: '利润',
    pinyin: 'lìrùn',
    word_type: 'Danh từ',
    meaning_vi: 'lợi nhuận',
    examples: [
      {
        chinese: '这家服装店通过严格控制进货成本，去年实现了可观的利润。',
        pinyin: 'Zhè jiā fúzhuāngdiàn tōngguò yángé kòngzhì jìnhuò chéngběn, qùnián shíxiàn le kěguān de lìrùn.',
        meaning_vi: 'Cửa hàng quần áo này nhờ kiểm soát nghiêm ngặt chi phí nhập hàng nên năm ngoái đã đạt được mức lợi nhuận đáng kể.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业在追求商业利润合理增长的同时，必须严格恪守环保法律法规并切实履行节能减排的社会责任。',
        pinyin: 'Qǐyè zài zhuīqiú shāngyè lìrùn hélǐ zēngzhǎng de tóngshí, bìxū yángé kèshǒu huánbǎo fǎlǜ fǎguī bìng qièshí lǚxíng jiénéng-jiǎnpái de shèhuì zérèn.',
        meaning_vi: 'Doanh nghiệp trong khi theo đuổi sự tăng trưởng lợi nhuận thương mại hợp lý, bắt buộc phải nghiêm chỉnh tuân thủ các quy định pháp luật môi trường và thực hiện thiết thực trách nhiệm xã hội về tiết kiệm năng lượng giảm phát thải.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2709,
    hanzi: '利益',
    pinyin: 'lìyì',
    word_type: 'Danh từ',
    meaning_vi: 'lợi ích, quyền lợi',
    examples: [
      {
        chinese: '在团队合作中，大家应当顾全大局，不能只顾及个人的一己私利。',
        pinyin: 'Zài tuánduì hézuò zhōng, dàjiā yīngdāng gùquán-dàjú, bùnéng zhǐ gùjí gèrén de yìjǐ-sīlì.',
        meaning_vi: 'Trong làm việc nhóm, mọi người nên nghĩ đến đại cục chung, không thể chỉ chăm chăm nghĩ tới tư lợi cá nhân của riêng mình.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在深化多边国际经贸谈判中，各国代表团应当兼顾各方核心利益关切，寻求互利共赢的最大公约数。',
        pinyin: 'Zài shēnhuà duōbiān guójì jīngmào tánpàn zhōng, gè guó dàibiǎotuán yīngdāng jiāngù gèfāng héxīn lìyì guānqiè, xúnqiú hùlì-gòngyíng de zuìdà gōngyuēshù.',
        meaning_vi: 'Trong việc làm sâu sắc đàm phán kinh tế thương mại quốc tế đa phương, đoàn đại biểu các nước nên xem xét dung hòa những mối quan tâm lợi ích cốt lõi của các bên, tìm kiếm mẫu số chung lớn nhất về hợp tác đôi bên cùng có lợi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2710,
    hanzi: '利用',
    pinyin: 'lìyòng',
    word_type: 'Động từ',
    meaning_vi: 'tận dụng, sử dụng, khai thác',
    examples: [
      {
        chinese: '我们可以充分利用周末空闲时间来学习一门新的计算机语言。',
        pinyin: 'Wǒmen kěyǐ chōngfèn lìyòng zhōumò kòngxián shíjiān lái xuéxí yì mén xīn de jìsuànjī yǔyán.',
        meaning_vi: 'Chúng ta có thể tận dụng triệt để thời gian rảnh rỗi cuối tuần để học một ngôn ngữ lập trình máy tính mới.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大力发展循环经济的关键在于全面提升工业固体废弃物与工业副产石膏的无害化综合利用水平。',
        pinyin: 'Dàlì fāzhǎn xúnhuán jīngjì de guānjiàn zàiyú quánmiàn tíshēng gōngyè gùtǐ fèiqìwù yǔ gōngyè fùchǎn shígāo de wúhàihuà zōnghé lìyòng shuǐpíng.',
        meaning_vi: 'Mấu chốt của việc đẩy mạnh phát triển kinh tế tuần hoàn nằm ở việc nâng cao toàn diện trình độ tận dụng tổng hợp không gây hại đối với chất thải rắn công nghiệp và thạch cao phụ phẩm công nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2711,
    hanzi: '联合',
    pinyin: 'liánhé',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'liên hợp, liên minh, phối hợp; chung',
    examples: [
      {
        chinese: '两所大学联合举办了一年一度的大学生中文辩论邀请赛。',
        pinyin: 'Liǎng suǒ dàxué liánhé jǔbàn le yì nián yí dù de dàxuésheng Zhōngwén biànlùn yāoqǐngsài.',
        meaning_vi: 'Hai trường đại học đã phối hợp liên kết tổ chức giải đấu tranh biện tiếng Trung sinh viên thường niên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '三国海警部门定期开展跨国水域联合巡航与海上反恐搜救演练，共同维护国际航运主通道的安全畅通。',
        pinyin: 'Sān guó hǎijǐng bùmén dìngqī kāizhǎn kuàguó shuǐyù liánhé xúnháng yǔ hǎishàng fǎnkǒng sōujiù yǎnliàn, gòngtóng wéihù guójì hángyùn zhǔ tōngdào de ānquán chàngtōng.',
        meaning_vi: 'Lực lượng cảnh sát biển ba nước định kỳ triển khai tuần tra chung tại vùng biển liên quốc gia cùng diễn tập chống khủng bố tìm kiếm cứu nạn trên biển, chung tay giữ gìn an toàn thông suốt cho tuyến hàng hải quốc tế huyết mạch.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2712,
    hanzi: '连接',
    pinyin: 'liánjiē',
    word_type: 'Động từ',
    meaning_vi: 'kết nối, nối liền, liên kết',
    examples: [
      {
        chinese: '只要把电脑连接到无线网络上，就可以畅快地浏览各类学术资料。',
        pinyin: 'Zhǐyào bǎ diànnǎo liánjiē dào wúxiàn wǎngluò shang, jiù kěyǐ chàngkuài de liúlǎn gèlèi xuéshù zīliào.',
        meaning_vi: 'Chỉ cần kết nối máy tính vào mạng không dây là có thể thoải mái tra cứu duyệt xem các loại tài liệu học thuật.',
        difficulty_level: 'basic'
      },
      {
        chinese: '这座跨海公铁两用特大桥梁将珠三角核心城市群与粤西沿海经济带紧紧连接在一起，重塑了区域经济发展新格局。',
        pinyin: 'Zhè zuò kuàhǎi gōng-tiě liǎngyòng tèdà qiáoliáng jiāng Zhūsānjiǎo héxīn chéngshìqún yǔ Yuèxī yánhǎi jīngjìdài jǐnjǐn liánjiē zài yìqǐ, chóngsù le qūyù jīngjì fāzhǎn xīn géjú.',
        meaning_vi: 'Cây cầu vượt biển siêu lớn kết hợp đường bộ và đường sắt này đã liên kết chặt chẽ cụm đô thị cốt lõi Đồng bằng Châu Giang cùng vành đai kinh tế ven biển Tây Quảng Đông, tái định hình cục diện phát triển kinh tế vùng mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2713,
    hanzi: '连忙',
    pinyin: 'liánmáng',
    word_type: 'Phó từ',
    meaning_vi: 'vội vàng, vội vã, mau lẹ',
    examples: [
      {
        chinese: '看见老奶奶提着沉重的东西上楼，他连忙走上前去帮忙。',
        pinyin: 'Kànjiàn lǎonǎinai tízhe chénzhòng de dōngxi shàng lóu, tā liánmáng zǒushàngqián qù bāngmáng.',
        meaning_vi: 'Thấy bà cụ xách đồ nặng bước lên cầu thang, anh ấy vội vàng bước tới giúp đỡ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在巡检中发现天然气管道存在微小渗漏隐患后，维保技术人员连忙关闭上游控制阀门并迅速开展带压封堵作业。',
        pinyin: 'Zài xúnjiǎn zhōng fāxiàn tiānránqì guǎndào cúnzài wēixiǎo shènlòu yǐnhuàn hòu, wéibǎo jìshù rényuán liánmáng guānbì shàngyóu kòngzhì fámén bìng xùnsù kāizhǎn dàiyā fēngdǔ zuòyè.',
        meaning_vi: 'Sau khi phát hiện nguy cơ rò rỉ khí đốt tự nhiên mức độ nhỏ trong lúc đi tuần tra, nhân viên kỹ thuật bảo trì vội vàng khóa van điều khiển thượng nguồn và nhanh chóng triển khai thao tác bịt kín chịu áp lực.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2714,
    hanzi: '连续',
    pinyin: 'liánxù',
    word_type: 'Động từ / Phó từ',
    meaning_vi: 'liên tục, liên tiếp',
    examples: [
      {
        chinese: '为了赶在截止日期前提交设计方案，他连续加了三个晚上的班。',
        pinyin: 'Wèile gǎn zài jiézhǐ rìqī qián tíjiāo shèjì fāng’àn, tā liánxù jiā le sān gè wǎnshang de bān.',
        meaning_vi: 'Để kịp nộp phương án thiết kế trước ngày hạn chót, anh ấy đã tăng ca liên tiếp suốt 3 buổi tối.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高精度数控机床在无人值守的自动化车间里连续无故障稳定运行上千小时，充分展现了国产工业母机卓越的机械耐久性。',
        pinyin: 'Gāo jīngmìdù shùkòng jīchuáng zài wúrén-zhíshǒu de zìdònghuà chējiān lǐ liánxù wú gùzhàng wěndìng yùnxíng shàng qiān xiǎoshí, chōngfèn zhǎnxiàn le guóchǎn gōngyè mǔjī zhuóyuè de jīxiè nàijiǔxìng.',
        meaning_vi: 'Máy công cụ CNC độ chính xác cao trong phân xưởng tự động hóa không người trực đã vận hành ổn định không lỗi liên tục hàng nghìn giờ đồng hồ, thể hiện trọn vẹn độ bền cơ học xuất sắc của máy công cụ nguồn nội địa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2715,
    hanzi: '脸色',
    pinyin: 'liǎnsè',
    word_type: 'Danh từ',
    meaning_vi: 'sắc mặt, nét mặt',
    examples: [
      {
        chinese: '你今天脸色看起来有些苍白，是不是身体不舒服？',
        pinyin: 'Nǐ jīntiān liǎnsè kàn qǐlái yǒuxiē cāngbái, shì bushì shēntǐ bù shūfu?',
        meaning_vi: 'Hôm nay sắc mặt bạn trông có phần nhợt nhạt, có phải trong người thấy không khỏe không?',
        difficulty_level: 'basic'
      },
      {
        chinese: '在激烈的跨国并购谈判桌前，首席谈判代表时刻保持从容沉静的神情，决不轻易让对手从自己的脸色中窥见商业底线。',
        pinyin: 'Zài jīliè de kuàguó bìnggòu tánpànzhuō qián, shǒuxí tánpàn dàibiǎo shíkè bǎochí cóngróng chénjìng de shénqíng, jué bù qīngyì ràng duìshǒu cóng zìjǐ de liǎnsè zhōng kuījiàn shāngyè dǐxiàn.',
        meaning_vi: 'Trước bàn đàm phán mua bán sáp nhập xuyên quốc gia khốc liệt, trưởng đoàn đàm phán luôn giữ thần sắc điềm tĩnh ung dung, tuyệt đối không dễ dàng để đối phương nhìn qua nét mặt mà dò xét được lằn ranh đỏ thương mại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2716,
    hanzi: '恋爱',
    pinyin: 'liàn’ài',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'yêu đương, chuyện tình cảm, tình yêu',
    examples: [
      {
        chinese: '他们俩从大学时期就开始谈恋爱，如今已经携手走进了婚姻的殿堂。',
        pinyin: 'Tāmen liǎ cóng dàxué shíqī jiù kāishǐ tán liàn’ài, rújīn yǐjīng xiéshǒu zǒujìn le hūnyīn de diàntáng.',
        meaning_vi: 'Hai người họ từ thời đại học đã bắt đầu yêu nhau, đến nay đã cùng nắm tay nhau bước vào ngưỡng cửa hôn nhân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '青年一代应当树立成熟理性、相互尊重和平等包容的现代恋爱观，让纯真的爱情成为彼此共同成长与追求人生理想的精神动力。',
        pinyin: 'Qīngnián yídài yīngdāng shùlì chéngshú lǐxìng, xiānghù zūnzhòng hé píngděng bāoróng de xiàndài liàn’àiguān, ràng chúnzhēn de àiqíng chéngwéi bǐcǐ gòngtóng chéngzhǎng yǔ zhuīqiú rénshēng lǐxiǎng de jīngshén dònglì.',
        meaning_vi: 'Thế hệ trẻ nên xây dựng quan niệm tình yêu hiện đại chín chắn lý trí, tôn trọng lẫn nhau và bình đẳng bao dung, để tình yêu trong sáng trở thành động lực tinh thần thúc đẩy đôi bên cùng trưởng thành và theo đuổi lý tưởng cuộc đời.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2717,
    hanzi: '良好',
    pinyin: 'liánghǎo',
    word_type: 'Tính từ',
    meaning_vi: 'tốt đẹp, khả quan, thuận lợi',
    examples: [
      {
        chinese: '养成良好的阅读习惯和规律的作息时间对青少年的身心健康大有裨益。',
        pinyin: 'Yǎngchéng liánghǎo de yuèdú xíguàn hé guīlǜ de zuòxī shíjiān duì qīngshàonián de shēnxīn jiànkāng dàyǒu-bìyì.',
        meaning_vi: 'Rèn luyện thói quen đọc sách tốt đẹp và thời gian biểu sinh hoạt điều độ mang lại rất nhiều lợi ích cho sức khỏe thể chất và tinh thần của thanh thiếu niên.',
        difficulty_level: 'basic'
      },
      {
        chinese: '持续优化法治化、国际化、市场化的一流营商环境，是稳定跨国资本预期并吸引外资长期扎根投资兴业的良好土壤。',
        pinyin: 'Chíxù yōuhuà fǎzhìhuà, guójìhuà, shìchǎnghuà de yīliú yíngshāng huánjìng, shì wěndìng kuàguó zīběn yùqī bìng xīyǐn wàizī chángqī zhāgēn tóuzī xīngyè de liánghǎo tǔrǎng.',
        meaning_vi: 'Liên tục tối ưu hóa môi trường kinh doanh hàng đầu mang tính pháp trị hóa, quốc tế hóa và thị trường hóa là mảnh đất màu mỡ tốt đẹp nhằm ổn định kỳ vọng của dòng vốn xuyên quốc gia và thu hút vốn ngoại cắm rễ lâu dài đầu tư phát triển sự nghiệp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2718,
    hanzi: '粮食',
    pinyin: 'liángshi',
    word_type: 'Danh từ',
    meaning_vi: 'lương thực, thóc lúa ngũ cốc',
    examples: [
      {
        chinese: '“谁知盘中餐，粒粒皆辛苦”，我们要自觉节约粮食，杜绝餐桌浪费。',
        pinyin: '“Shuí zhī pán zhōng cān, lì lì jiē xīnkǔ”, wǒmen yào zìjué jiéyuē liángshi, dùjué cānzhuō làngfèi.',
        meaning_vi: '"Ai hay cơm trong đĩa, hạt hạt đều gian lao", chúng ta cần tự giác tiết kiệm lương thực, bài trừ nạn lãng phí đồ ăn trên bàn ăn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家坚持藏粮于地、藏粮于技战略，严守十八亿亩耕地红线，坚决将中国人的饭碗牢牢端在自己手中，夯实国家粮食安全根基。',
        pinyin: 'Guójiā jiānchí cáng liáng yú dì, cáng liáng yú jì zhànlüè, yánshǒu shíbā yì mǔ gēngdì hóngxiàn, jiānjué jiāng Zhōngguórén de fànwǎn láoláo duān zài zìjǐ shǒuzhōng, hāngshí guójiā liángshi ānquán gēnjī.',
        meaning_vi: 'Nhà nước kiên trì chiến lược giữ lúa trong đất, trữ lúa trong công nghệ, giữ vững lằn ranh đỏ 1,8 tỷ mẫu đất canh tác, kiên quyết giữ chắc bát cơm của người Trung Quốc trong tay mình, bồi đắp vững chắc nền tảng an ninh lương thực quốc gia.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2719,
    hanzi: '量',
    pinyin: 'liàng',
    word_type: 'Danh từ',
    meaning_vi: 'lượng, số lượng, khối lượng, dung lượng',
    examples: [
      {
        chinese: '运动出汗过多后，应当适量补充含有微量电解质的淡盐水。',
        pinyin: 'Yùndòng chūhàn guòduō hòu, yīngdāng shìliàng bǔchōng hányǒu wēiliàng diànjiězì de dànyánshuǐ.',
        meaning_vi: 'Sau khi vận động ra quá nhiều mồ hôi, nên bổ sung một lượng nước muối loãng vừa phải có chứa chất điện giải vi lượng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对井喷式增长的海量非结构化多模态数据，分布式云存储集群通过自适应压缩与冷热分级存储，大幅提升了数据吞吐量与处理效能。',
        pinyin: 'Miànduì jǐngpēnshì zēngzhǎng de hǎiliàng fēijiégòuhuà duōmótài shùjù, fēnbùshì yún cúnchǔ jíqún tōngguò zìshìyìng yāsuō yǔ lěng-rè fēnjí cúnchǔ, dàfú tíshēng le shùjù tūntǔliàng yǔ chǔlǐ xiàonéng.',
        meaning_vi: 'Đối mặt với lượng dữ liệu phi cấu trúc đa phương thức khổng lồ tăng vọt như phun trào, cụm lưu trữ đám mây phân tán thông qua nén tự thích ứng và phân tầng lưu trữ nóng lạnh đã nâng cao đáng kể thông lượng dữ liệu và hiệu năng xử lý.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2720,
    hanzi: '了不起',
    pinyin: 'liǎobuqǐ',
    word_type: 'Tính từ',
    meaning_vi: 'tài ba, phi thường, đáng khâm phục',
    examples: [
      {
        chinese: '他凭借顽强的毅力自学成才并考上了名牌大学，真是一个了不起的青年。',
        pinyin: 'Tā píngjiè wánqiáng de yìlì zìxué-chéngcái bìng kǎoshàng le míngpái dàxué, zhēn shì yí gè liǎobuqǐ de qīngnián.',
        meaning_vi: 'Cậu ấy dựa vào nghị lực kiên cường tự học thành tài và thi đỗ vào trường đại học danh tiếng, thật là một thanh niên đáng khâm phục.',
        difficulty_level: 'basic'
      },
      {
        chinese: '中国航天科技工作者独立自主攻克空间站组装建造与长期驻留等一系列世界级技术难题，创造了举世瞩目的了不起航天奇迹。',
        pinyin: 'Zhōngguó hángtiān kējì gōngzuòzhě dúlì-zìzhǔ gōngkè kōngjiānzhàn zǔzhuāng jiànzào yǔ chángqī zhùliú děng yí xìliè shìjièjí jìshù nántí, chuàngzào le jǔshì-zhǔmù de liǎobuqǐ hángtiān qíjì.',
        meaning_vi: 'Đội ngũ cán bộ khoa học hàng không vũ trụ Trung Quốc đã độc lập tự chủ chinh phục một loạt các bài toán kỹ thuật tầm cỡ thế giới như lắp ráp xây dựng trạm không gian và đồn trú dài ngày, tạo nên kỳ tích vũ trụ phi thường khiến toàn thế giới phải dõi mắt khâm phục.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2721,
    hanzi: '列车',
    pinyin: 'lièchē',
    word_type: 'Danh từ',
    meaning_vi: 'đoàn tàu, đoàn xe lửa',
    examples: [
      {
        chinese: '各位旅客请注意，开往北京方向的高速动车组列车马上就要进站了。',
        pinyin: 'Gèwèi lǚkè qǐng zhùyì, kāiwǎng Běijīng fāngxiàng de gāosù dòngchēzǔ lièchē mǎshàng jiù yào jìnzhàn le.',
        meaning_vi: 'Kính mời quý hành khách chú ý, đoàn tàu cao tốc động lực phân tán hướng đi Bắc Kinh sắp sửa tiến vào sân ga.',
        difficulty_level: 'basic'
      },
      {
        chinese: '时速三百五十公里的复兴号智能动车组列车实现了全自动驾驶辅助与全车物联网故障自诊断，成为彰显中国制造业创新实力的闪亮名片。',
        pinyin: 'Shísù sānbǎi wǔshí gōnglǐ de Fùxīnghào zhìnéng dòngchēzǔ lièchē shíxiàn le quán zìdòng jiàshǐ fǔzhù yǔ quán chē wùliánwǎng gùzhàng zì zhěnduàn, chéngwéi zhāngxiǎn Zhōngguó zhìzàoyè chuàngxīn shílì de shǎnliàng míngpiàn.',
        meaning_vi: 'Đoàn tàu điện thông minh Phục Hưng vận tốc 350 km/h đã hiện thực hóa việc hỗ trợ tự lái hoàn toàn và tự chẩn đoán sự cố IoT toàn tàu, trở thành tấm danh thiếp rực rỡ thể hiện năng lực đổi mới sáng tạo của ngành chế tạo Trung Quốc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2722,
    hanzi: '临时',
    pinyin: 'línshí',
    word_type: 'Phó từ / Tính từ',
    meaning_vi: 'tạm thời, lâm thời, nhất thời',
    examples: [
      {
        chinese: '由于原定会议室设备出现故障，会议临时改到三楼多功能学术报告厅举行。',
        pinyin: 'Yóuyú yuándìng huìyìshì shèbèi chūxiàn gùzhàng, huìyì línshí gǎi dào sān lóu duōgōngnéng xuéshù bàogàotīng jǔxíng.',
        meaning_vi: 'Do trang thiết bị phòng họp dự kiến ban đầu gặp sự cố, cuộc họp tạm thời được chuyển sang tổ chức tại hội trường báo cáo học thuật đa năng tầng 3.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在特大洪涝灾害发生后，救援指挥部火速调集活动板房与医疗物资，仅用两天时间便在安全高地搭建起可容纳数千名受灾群众的临时安置点。',
        pinyin: 'Zài tèdà hónglào zāihài fāshēng hòu, jiùyuán zhǐhuībù huǒsù diàojí huódòng bǎnfáng yǔ yīliáo wùzī, jǐn yòng liǎng tiān shíjiān biàn zài ānquán gāodì dājiàn qǐ kě róngnà shù qiān míng shòuzāi qúnzhòng de línshí ānzhìdiǎn.',
        meaning_vi: 'Sau khi trận lũ lụt lớn xảy ra, ban chỉ huy cứu hộ đã hỏa tốc điều động nhà lắp ghép cùng vật tư y tế, chỉ trong 2 ngày đã dựng nên một khu tái định cư tạm thời trên vùng đất cao an toàn có thể dung nạp hàng nghìn bà con bị ảnh hưởng bởi thiên tai.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2723,
    hanzi: '铃',
    pinyin: 'líng',
    word_type: 'Danh từ',
    meaning_vi: 'chuông, cái chuông',
    examples: [
      {
        chinese: '清脆的下课铃声一响，操场上立刻充满了同学们的欢声笑语。',
        pinyin: 'Qīngcuì de xiàkè língshēng yì xiǎng, cǎochǎng shang lìkè chōngmǎn le tóngxuémen de huānshēng-xiàoyǔ.',
        meaning_vi: 'Tiếng chuông tan học trong trẻo vừa vang lên, trên sân trường lập tức tràn ngập tiếng cười nói rộn rã của các bạn học sinh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在金融交易所数字化监控中心，高频交易异常风控警报电铃能够在毫秒内捕捉到恶意违规大单报价并触发系统自动熔断。',
        pinyin: 'Zài jīnróng jiāoyìsuǒ shùzìhuà jiānkòng zhōngxīn, gāopín jiāoyì yìcháng fēngkòng jǐngbào diànlíng nénggòu zài háomiǎo nèi bǔzhuō dào èyì wéiguī dà dān bàojià bìng chùfā xìtǒng zìdòng róngduàn.',
        meaning_vi: 'Tại trung tâm giám sát số hóa của sàn giao dịch tài chính, chuông báo động kiểm soát rủi ro giao dịch bất thường tần suất cao có thể trong tích tắc mili giây bắt trọn lệnh đặt giá lớn vi phạm quy chế độc hại và kích hoạt cơ chế tự động ngắt mạch giao dịch.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2724,
    hanzi: '灵活',
    pinyin: 'línghuó',
    word_type: 'Tính từ',
    meaning_vi: 'linh hoạt, nhanh nhẹn, uyển chuyển',
    examples: [
      {
        chinese: '遇到突发问题时，不能死板照搬教条，而要学会灵活变通处理。',
        pinyin: 'Yùdào tūfā wèntí shí, bùnéng sǐbǎn zhàobān jiàotiáo, ér yào xuéhuì línghuó biàntōng chǔlǐ.',
        meaning_vi: 'Khi gặp phải vấn đề phát sinh đột xuất, không thể rập khuôn máy móc theo giáo điều, mà phải học cách linh hoạt biến chuyển xử lý.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对高度分化且快速迭代的细分市场，柔性制造系统允许生产线在数分钟内灵活切换不同规格的复杂零件加工任务。',
        pinyin: 'Miànduì gāodù fēnhuà qiě kuàisù diédài de xìfēn shìchǎng, róuxìng zhìzào xìtǒng yǔnxǔ shēngchǎnxiàn zài shù fēnzhōng nèi línghuó qiēhuàn bùtóng guīgé de fùzá língjiàn jiāgōng rènwu.',
        meaning_vi: 'Đối mặt với một thị trường ngách phân hóa cao độ và cải tiến nhanh chóng, hệ thống chế tạo linh hoạt cho phép dây chuyền sản xuất chỉ trong vài phút có thể chuyển đổi uyển chuyển nhiệm vụ gia công các linh kiện phức tạp với các quy cách khác nhau.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2725,
    hanzi: '领',
    pinyin: 'lǐng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'dẫn đầu, dẫn dắt; nhận, lĩnh; cổ áo',
    examples: [
      {
        chinese: '班长领着新转来的同学熟悉校园环境和各学科教室。',
        pinyin: 'Bānzhǎng lǐng zhe xīn zhuǎnlái de tóngxué shúxī xiàoyuán huánjìng hé gè xuékē jiàoshì.',
        meaning_vi: 'Lớp trưởng dẫn bạn học mới chuyển tới làm quen với khuôn viên trường và phòng học của các môn học.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在国家高水平科技攻坚行动中，战略科学家与顶尖技术领军人才领衔主持重大攻关课题，充分发挥了科技领头羊的关键牵引作用。',
        pinyin: 'Zài guójiā gāo shuǐpíng kējì gōngjiān xíngdòng zhōng, zhànlüè kēxuéjiā yǔ dǐngjiān jìshù lǐngjūn réncái lǐngxián zhǔchí zhòngdà gōngguān kètí, chōngfèn fāhuī le kējì lǐngtóuyáng de guānjiàn qiānyǐn zuòyòng.',
        meaning_vi: 'Trong chiến dịch đột phá khoa học công nghệ trình độ cao cấp quốc gia, các nhà khoa học chiến lược cùng nhân tài dẫn đầu công nghệ đỉnh cao đã đứng đầu chủ trì các đề tài mũi nhọn trọng đại, phát huy trọn vẹn vai trò dẫn dắt then chốt như cánh chim đầu đàn công nghệ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2726,
    hanzi: '领带',
    pinyin: 'lǐngdài',
    word_type: 'Danh từ',
    meaning_vi: 'cà vạt, ca-vát',
    examples: [
      {
        chinese: '参加正式商务宴会时，男士通常会穿上深色西装并系上一条雅致的领带。',
        pinyin: 'Cānjiā zhèngshì shāngwù yànhuì shí, nánshì tōngcháng huì chuān shàng shēnsè xīzhuāng bìng jì shàng yì tiáo yǎzhì de lǐngdài.',
        meaning_vi: 'Khi tham gia tiệc chiêu đãi thương mại chính thức, nam giới thông thường sẽ mặc âu phục sẫm màu và thắt một chiếc cà vạt trang nhã.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在国际多边外交互访与元首峰会的外交礼仪中，服饰细节、西装版型以及领带领结的色系搭配，均严格契合格调典雅的国际惯例礼仪规范。',
        pinyin: 'Zài guójì duōbiān wàijiāo hùfǎng yǔ yuánshǒu fēnghuì de wàijiāo lǐyí zhōng, fúshì xìjié, xīzhuāng bǎnxíng yǐjí lǐngdài lǐngjié de sèxì dāpèi, jūn yángé qìhé gédiào diǎnyǎ de guójì guànlì lǐyí guīfàn.',
        meaning_vi: 'Trong nghi thức ngoại giao của các chuyến thăm ngoại giao đa phương quốc tế và hội nghị thượng đỉnh nguyên thủ, từng chi tiết trang phục, phom dáng âu phục cùng việc phối tông màu cà vạt hay nơ đều tuân thủ nghiêm ngặt chuẩn mực lễ tân quốc tế sang trọng và nhã nhặn.',
        difficulty_level: 'applied'
      }
    ]
  }
]
