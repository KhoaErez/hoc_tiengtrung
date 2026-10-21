// data/hsk5-batch6-part2-data.ts
// 25 từ HSK 5: #2527 [集] -> #2551 [嘉宾]

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

export const HSK5_BATCH6_PART2: VocabItem[] = [
  {
    id: 2527,
    hanzi: '集',
    pinyin: 'jí',
    word_type: 'Danh từ / Lượng từ',
    meaning_vi: 'tập (phim, sách); chợ phiên, tập hợp',
    examples: [
      {
        chinese: '这部历史电视剧一共有四十集，剧情跌宕起伏引人入胜。',
        pinyin: 'Zhè bù lìshǐ diànshìjù yígòng yǒu sìshí jí, jùqíng diēdàng-qǐfú yǐnrén-rùshèng.',
        meaning_vi: 'Bộ phim truyền hình lịch sử này gồm tất cả 40 tập, tình tiết thăng trầm lôi cuốn người xem.',
        difficulty_level: 'basic'
      },
      {
        chinese: '出版社精心编纂出版了这套学术论文集，全面展示了该学科近十年来的核心研究成果。',
        pinyin: 'Chūbǎnshè jīngxīn biānzuǎn chūbǎn le zhè tào xuéshù lùnwénjí, quánmiàn zhǎnshì le gāi xuékē jìn shí nián lái de héxīn yánjiū chéngguǒ.',
        meaning_vi: 'Nhà xuất bản đã biên soạn công phu và ấn hành tập kỷ yếu luận văn học thuật này, thể hiện toàn diện các thành quả nghiên cứu cốt lõi của ngành học trong suốt 10 năm qua.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2528,
    hanzi: '疾病',
    pinyin: 'jíbìng',
    word_type: 'Danh từ',
    meaning_vi: 'bệnh tật, căn bệnh',
    examples: [
      {
        chinese: '保持良好的作息习惯和合理的饮食能够预防许多常见疾病。',
        pinyin: 'Bǎochí liánghǎo de zuòxī xíguàn hé hélǐ de yǐnshí nénggòu yùfáng xǔduō chángjiàn jíbìng.',
        meaning_vi: 'Duy trì thói quen sinh hoạt tốt và ăn uống hợp lý có thể phòng ngừa nhiều căn bệnh thường gặp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '早期基因筛查与定期靶向体检，为慢性心血管疾病及恶性肿瘤的早发现、早干预提供了坚实的技术保障。',
        pinyin: 'Zǎoqī jīyīn shāichá yǔ dìngqī bǎxiàng tǐjiǎn, wèi mànxìng xīn-xiěguǎn jíbìng jí èxìng zhǒngliú de zǎo fāxiàn, zǎo gānyù tígōng le jiānshí de jìshù bǎozhàng.',
        meaning_vi: 'Tầm soát gen sớm và khám sức khỏe định kỳ có mục tiêu đã cung cấp bảo đảm kỹ thuật vững chắc cho việc phát hiện và can thiệp sớm các bệnh tim mạch mạn tính cũng như khối u ác tính.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2529,
    hanzi: '及格',
    pinyin: 'jígé',
    word_type: 'Động từ',
    meaning_vi: 'đạt điểm chuẩn, đủ điểm đỗ, đạt yêu cầu',
    examples: [
      {
        chinese: '经过老师的辅导和自己的刻苦复习，他的期末数学成绩终于及格了。',
        pinyin: 'Jīngguò lǎoshī de fǔdǎo hé zìjǐ de kèkǔ fùxí, tā de qīmò shùxué chéngjì zhōngyú jígé le.',
        meaning_vi: 'Qua sự phụ đạo của thầy cô và sự nỗ lực ôn tập của bản thân, điểm môn Toán cuối kỳ của cậu ấy cuối cùng đã đạt điểm chuẩn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '对于高端制造业而言，合格率仅仅达到及格线是远远不够的，必须追求零缺陷与极致的工艺品质。',
        pinyin: 'Duìyú gāoduān zhìzàoyè ér yán, hégélǜ jǐnjǐn dádào jígéxiàn shì yuǎnyuǎn bú gòu de, bìxū zhuīqiú líng quēxiàn yǔ jízhì de gōngyì pǐnzhì.',
        meaning_vi: 'Đối với ngành chế tạo cao cấp mà nói, tỷ lệ hợp chuẩn chỉ đạt mức vừa đủ qua chuẩn là hoàn toàn không đủ, mà phải theo đuổi tỷ lệ không lỗi và phẩm chất gia công đỉnh cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2530,
    hanzi: '集合',
    pinyin: 'jíhé',
    word_type: 'Động từ',
    meaning_vi: 'tập hợp, tụ họp, tập trung lại',
    examples: [
      {
        chinese: '明天早上七点半，全班同学在学校正大门口集合乘车。',
        pinyin: 'Míngtiān zǎoshang qī diǎn bàn, quán bān tóngxué zài xuéxiào zhèng dàménkǒu jíhé chéngchē.',
        meaning_vi: '7 giờ 30 sáng mai, cả lớp tập trung tại cổng chính của trường để lên xe.',
        difficulty_level: 'basic'
      },
      {
        chinese: '应急指挥中心在接到重大灾情通报后，仅用二十分钟便迅速完成了专业救援人员与急救物资的集结整备。',
        pinyin: 'Yìngjí zhǐhuī zhōngxīn zài jiēdào zhòngdà zāiqíng tōngbào hòu, jǐn yòng èrshí fēnzhōng biàn xùnsù wánchéng le zhuānyè jiùyuán rényuán yǔ jíjiù wùzī de jíjié zhěngbèi.',
        meaning_vi: 'Trung tâm chỉ huy cứu hộ khẩn cấp sau khi nhận được thông báo thiên tai nghiêm trọng, chỉ mất đúng 20 phút đã nhanh chóng hoàn tất việc tập kết và chuẩn bị đội ngũ cứu hộ chuyên môn cùng vật tư cứu nạn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2531,
    hanzi: '即将',
    pinyin: 'jíjiāng',
    word_type: 'Phó từ',
    meaning_vi: 'sắp sửa, sắp tới, chuẩn bị',
    examples: [
      {
        chinese: '大学生活即将结束，同学们都在忙着准备毕业论文和找工作。',
        pinyin: 'Dàxué shēnghuó jíjiāng jiéshù, tóngxuémen dōu zài máng zhe zhǔnbèi bìyè lùnwén hé zhǎo gōngzuò.',
        meaning_vi: 'Quãng đời sinh viên đại học sắp sửa kết thúc, các bạn học sinh đều đang bận rộn chuẩn bị khóa luận tốt nghiệp và tìm việc làm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '连接两座经济重镇的高铁干线即将全线开通运营，这对于促进区域协同发展具有极为深远的战略意义。',
        pinyin: 'Liánjiē liǎng zuò jīngjì zhòngzhèn de gāotiě gànxiàn jíjiāng quánxiàn kāitōng yùnyíng, zhè duìyú cùjìn qūyù xiétóng fāzhǎn jùyǒu jíwéi shēnyuǎn de zhànlüè yìyì.',
        meaning_vi: 'Tuyến đường sắt cao tốc huyết mạch nối liền hai trung tâm kinh tế trọng điểm sắp sửa được đưa vào vận hành toàn tuyến, điều này có ý nghĩa chiến lược vô cùng sâu rộng đối với việc thúc đẩy sự phát triển liên kết vùng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2532,
    hanzi: '急忙',
    pinyin: 'jímáng',
    word_type: 'Phó từ',
    meaning_vi: 'vội vã, cuống cuồng, hớt hải',
    examples: [
      {
        chinese: '眼看要下大雨了，行人们急忙收起摊位或者快步跑向屋檐下躲雨。',
        pinyin: 'Yǎnkàn yào xià dàyǔ le, xíngrénmen jímáng shōuqǐ tānwèi huòzhě kuàibù pǎoxiàng wūyán xià duǒyǔ.',
        meaning_vi: 'Trông thấy trời sắp đổ mưa rào, người đi đường vội vã thu dọn sạp hàng hoặc rảo bước chạy vào dưới mái hiên để trú mưa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在突发网络安全威胁通报发出后，系统工程师团队急忙登录云端服务器并连夜部署紧急补丁程序。',
        pinyin: 'Zài tūfā wǎngluò ānquán wēixié tōngbào fāchū hòu, xìtǒng gōngchéngshī tuánduì jímáng dēnglù yúnduān fúwùqì bìng liányè bùshǔ jǐnjí bǔdīng chéngxù.',
        meaning_vi: 'Sau khi thông báo về mối đe dọa an ninh mạng đột xuất được ban bố, đội ngũ kỹ sư hệ thống đã vội vã đăng nhập vào máy chủ đám mây và thức trắng đêm triển khai bản vá khẩn cấp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2533,
    hanzi: '极其',
    pinyin: 'jíqí',
    word_type: 'Phó từ',
    meaning_vi: 'cực kỳ, hết sức, vô cùng',
    examples: [
      {
        chinese: '他在工作中极其认真负责，每一个细节都会仔细核实。',
        pinyin: 'Tā zài gōngzuò zhōng jíqí rènzhēn fùzé, měi yí gè xìjié dōu huì zǐxì héshí.',
        meaning_vi: 'Anh ấy cực kỳ nghiêm túc và có trách nhiệm trong công việc, từng chi tiết một đều được kiểm chứng kỹ lưỡng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '深海科考探测处于高压、严寒与完全黑暗的极端物理环境下，对潜水器的耐压材质提出了极其苛刻的要求。',
        pinyin: 'Shēnhǎi kěkǎo tàncè chǔyú gāoyā, yánhán yǔ wánquán hēi’àn de jíduān wùlǐ huánjìng xià, duì qiánshuǐqì de nàiyā cáizhì tíchū le jíqí kīkè de yāoqiú.',
        meaning_vi: 'Hoạt động nghiên cứu thám hiểm biển sâu diễn ra trong môi trường vật lý cực đoan với áp suất cực lớn, giá lạnh và bóng tối hoàn toàn, đặt ra những yêu cầu hết sức khắt khe đối với vật liệu chịu áp suất của tàu lặn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2534,
    hanzi: '集体',
    pinyin: 'jítǐ',
    word_type: 'Danh từ',
    meaning_vi: 'tập thể, đoàn thể',
    examples: [
      {
        chinese: '这次活动的成功举办，离不开全班集体的共同付出与紧密合作。',
        pinyin: 'Zhè cì huódòng de chénggōng jǔbàn, lìbùkāi quán bān jítǐ de gòngtóng fùchū yǔ jǐnmì hézuò.',
        meaning_vi: 'Sự tổ chức thành công của hoạt động lần này không thể tách rời sự đóng góp chung và phối hợp chặt chẽ của cả tập thể lớp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '公司提倡将个人职业理想融入企业集体奋斗目标之中，依托集体智慧不断突破行业关键核心技术瓶颈。',
        pinyin: 'Gōngsī tíchàng jiāng gèrén zhíyè lǐxiǎng róngrù qǐyè jítǐ fèndòu mùbiāo zhīzhōng, yītuō jítǐ zhìhuì búduàn tūpò hángyè guānjiàn héxīn jìshù píngjǐng.',
        meaning_vi: 'Công ty chủ trương hòa quyện lý tưởng sự nghiệp cá nhân vào mục tiêu phấn đấu tập thể của doanh nghiệp, dựa vào trí tuệ tập thể để không ngừng đột phá những điểm nghẽn công nghệ cốt lõi của ngành.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2535,
    hanzi: '急需',
    pinyin: 'jíxū',
    word_type: 'Động từ',
    meaning_vi: 'rất cần, khẩn cấp cần đến',
    examples: [
      {
        chinese: '灾区群众目前急需帐篷、保暖棉被和干净的饮用水。',
        pinyin: 'Zāiqū qúnzhòng mùqián jíxū zhàngpeng, bǎonuǎn miánbèi hé gānjìng de yǐnyòngshuǐ.',
        meaning_vi: 'Bà con vùng thiên tai hiện tại đang rất cần lều bạt, chăn bông giữ ấm và nước uống sạch.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着半导体集成电路产业的加速升级，国内高精尖芯片设计与制造领域正急需大量具有实操经验的领军技术人才。',
        pinyin: 'Suízhe bàndǎotǐ jíchéng diànlù chǎnyè de jiāsù shēngjí, guónèi gāojīngjiān xīanpiàn shèjì yǔ zhìzào lǐngyù zhèng jíxū dàliàng jùyǒu shícāo jīngyàn de lǐngjūn jìshù réncái.',
        meaning_vi: 'Cùng với sự nâng cấp nhanh chóng của ngành mạch tích hợp bán dẫn, lĩnh vực thiết kế và sản xuất chip công nghệ cao trong nước đang rất cần lượng lớn các nhân tài kỹ thuật dẫn đầu có kinh nghiệm thực chiến.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2536,
    hanzi: '急诊',
    pinyin: 'jízhěn',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'cấp cứu, phòng cấp cứu; khám cấp cứu',
    examples: [
      {
        chinese: '孩子突发高烧不退，爸爸赶紧开车送他去医院看急诊。',
        pinyin: 'Háizi tūfā gāoshāo bú tuì, bàba gǎnjǐn kāichē sòng tā qù yīyuàn kàn jízhěn.',
        meaning_vi: 'Đứa bé đột ngột sốt cao không hạ, người cha liền vội vã lái xe đưa con vào bệnh viện khám cấp cứu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '三甲医院建立了完善的胸痛与卒中绿色急诊通道，确保危急重症患者在黄金抢救时间内获得最高水平的多学科协同救治。',
        pinyin: 'Sānjiǎ yīyuàn jiànlì le wánshàn de xiōngtòng yǔ cùzhòng lǜsè jízhěn tōngdào, quèbǎo wēijí-zhòngzhèng huànzhě zài huángjīn qiǎngjiù shíjiān nèi huòdé zuì gāo shuǐpíng de duōxuékē xiétóng jiùzhì.',
        meaning_vi: 'Bệnh viện tuyến đầu đã thiết lập luồng cấp cứu xanh hoàn chỉnh cho các ca đau ngực và đột quỵ, bảo đảm bệnh nhân nguy kịch được điều trị phối hợp đa chuyên khoa ở trình độ cao nhất ngay trong thời gian vàng cấp cứu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2537,
    hanzi: '集中',
    pinyin: 'jízhōng',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'tập trung; dồn sức',
    examples: [
      {
        chinese: '上课的时候一定要集中注意力，认真听讲并做好笔记。',
        pinyin: 'Shàngkè de shíhou yídìng yào jízhōng zhùyìlì, rènzhēn tīngjiǎng bìng zuò hǎo bǐjì.',
        meaning_vi: 'Trong giờ học nhất định phải tập trung chú ý, chăm chú nghe giảng và ghi chép cẩn thận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该经济特区实行集中审批与全流程数字监管模式，显著提升了招商引资项目落地建设的行政审批效率。',
        pinyin: 'Gāi jīngjì tèqū shíxíng jízhōng shěnpī yǔ quánliúchéng shùzì jiānguǎn móshì, xiǎnzhù tíshēng le zhāoshāng yǐnzī xiàngmù luòdì jiànshè de xíngzhèng shěnpī xiàolǜ.',
        meaning_vi: 'Khu đặc quyền kinh tế này thực thi mô hình thẩm định tập trung và giám sát số toàn bộ quy trình, nâng cao rõ rệt hiệu quả phê duyệt hành chính đối với việc triển khai xây dựng các dự án thu hút đầu tư.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2538,
    hanzi: '挤',
    pinyin: 'jǐ',
    word_type: 'Động từ / Tính từ',
    meaning_vi: 'chen chúc, chen lấn; vắt, ép; đông đúc, chật chội',
    examples: [
      {
        chinese: '早高峰时期的地铁车厢里总是挤满了赶着去上班的人群。',
        pinyin: 'Zǎogāofēng shíqī de dìtiě chēxiāng lǐ zǒngshì jǐmǎn le gǎn zhe qù shàngbān de rénqún.',
        meaning_vi: 'Trong toa tàu điện ngầm vào giờ cao điểm buổi sáng lúc nào cũng chật ních dòng người đang vội vã đi làm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '初创公司在巨头林立的红海市场中，必须依靠敏锐的市场洞察与差异化创新产品，才能成功挤出属于自己的一席之地。',
        pinyin: 'Chūchuàng gōngsī zài jùtóu línlì de hónghǎi shìchǎng zhōng, bìxū yīkào mǐnruì de shìchǎng dòngchá yǔ chāyìhuà chuàngxīn chǎnpǐn, cáinéng chénggōng jǐ chū shǔyú zìjǐ de yì xí zhī dì.',
        meaning_vi: 'Doanh nghiệp khởi nghiệp giữa thị trường biển đỏ đầy rẫy các ông lớn buộc phải dựa vào sự thấu thị thị trường nhạy bén và sản phẩm đổi mới khác biệt hóa thì mới có thể thành công chen chân tìm được một chỗ đứng cho riêng mình.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2539,
    hanzi: '系',
    pinyin: 'jì',
    word_type: 'Động từ',
    meaning_vi: 'thắt, buộc, cài (dây an toàn, cà vạt, dây giày)',
    examples: [
      {
        chinese: '汽车行驶前，司机和乘车人员都应当自觉系好安全带。',
        pinyin: 'Qìchē xíngshǐ qián, sījī hé chéngchē rényuán dōu yīngdāng zìjué jì hǎo ānquándài.',
        meaning_vi: 'Trước khi xe lăn bánh, người lái và hành khách trên xe đều nên tự giác thắt dây an toàn cẩn thận.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在高空作业与悬崖攀爬救援过程中，专业人员必须严格规范系牢主副双重安全绳锁以防发生意外。',
        pinyin: 'Zài gāokōng zuòyè yǔ xuányá pānpá jiùyuán guòchéng zhōng, zhuānyè rényuán bìxū yángé guīfàn jì láo zhǔ-fù shuāngchóng ānquán shéngsuǒ yǐ fáng fāshēng yìwài.',
        meaning_vi: 'Trong quá trình thi công trên cao và cứu hộ leo vách đá, nhân viên chuyên môn cần tuân thủ nghiêm ngặt quy định thắt chặt cả khóa dây an toàn chính lẫn phụ để đề phòng tai nạn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2540,
    hanzi: '季度',
    pinyin: 'jìdù',
    word_type: 'Danh từ',
    meaning_vi: 'quý (khoảng thời gian 3 tháng)',
    examples: [
      {
        chinese: '公司每个季度末都会组织各部门召开一次全面的业务总结大会。',
        pinyin: 'Gōngsī měi gè jìdù mò dōu huì zǔzhī gè bùmén zhàokāi yí cì quánmiàn de yèwù zǒngjié dàhuì.',
        meaning_vi: 'Vào cuối mỗi quý, công ty đều tổ chức cho các phòng ban họp đại hội tổng kết nghiệp vụ toàn diện một lần.',
        difficulty_level: 'basic'
      },
      {
        chinese: '根据国家统计局公布的宏观数据，第三季度国内生产总值与对外贸易总额均实现了超预期的稳步增长。',
        pinyin: 'Gēnjù guójiā tǒngjìjú gōngbù de hóngguān shùjù, dì-sān jìdù guónèi shēngchǎn zǒngzhí yǔ duìwài màoyì zǒng’é jūn shíxiàn le chāo yùqī de wěnbù zēngzhǎng.',
        meaning_vi: 'Theo số liệu vĩ mô do Tổng cục Thống kê công bố, trong quý 3 cả tổng sản phẩm quốc nội lẫn kim ngạch ngoại thương đều đạt mức tăng trưởng vững chắc vượt dự kiến.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2541,
    hanzi: '记录',
    pinyin: 'jìlù',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'ghi chép, ghi lại; biên bản, nhật ký, bản ghi',
    examples: [
      {
        chinese: '秘书在会议上快速记录下每位领导发表的核心意见。',
        pinyin: 'Mìshū zài huìyì shang kuàisù jìlù xià měi wèi lǐngdǎo fābiǎo de héxīn yìjiàn.',
        meaning_vi: 'Thư ký trong cuộc họp nhanh chóng ghi lại những ý kiến cốt lõi do từng vị lãnh đạo phát biểu.',
        difficulty_level: 'basic'
      },
      {
        chinese: '实验人员必须详尽记录每一个化学反应阶段的温度、压力与物料配比参数，确保科学实验数据的完整性与可复现性。',
        pinyin: 'Shíyàn rényuán bìxū xiángjìn jìlù měi yí gè huàxué fǎnyìng jiēduàn de wēndù, yālì yǔ wùliào pèibǐ cānshù, quèbǎo kēxué shíyàn shùjù de wánzhěngxìng yǔ kě fùxiànxìng.',
        meaning_vi: 'Nhân viên thí nghiệm phải ghi chép chi tiết các thông số nhiệt độ, áp suất và tỷ lệ phối liệu trong từng giai đoạn phản ứng hóa học, bảo đảm tính toàn vẹn và khả năng tái lập của dữ liệu thí nghiệm khoa học.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2542,
    hanzi: '纪录',
    pinyin: 'jìlù',
    word_type: 'Danh từ',
    meaning_vi: 'kỷ lục (thành tích cao nhất)',
    examples: [
      {
        chinese: '他在百米赛跑中跑出了九秒九八的好成绩，打破了全校纪录。',
        pinyin: 'Tā zài bǎimǐ sàipǎo zhōng pǎochū le jiǔ miǎo jiǔ bā de hǎo chéngjì, dǎpò le quán xiào jìlù.',
        meaning_vi: 'Anh ấy đã đạt thành tích 9 giây 98 ở cự ly chạy 100m, phá vỡ kỷ lục của toàn trường.',
        difficulty_level: 'basic'
      },
      {
        chinese: '这位短跑名将凭借顽强的毅力与科学的训练体系，在世界田径锦标赛上再次刷新了由自己保持的男子百米世界纪录。',
        pinyin: 'Zhè wèi duǎnpǎo míngjiàng píngjiè wánqiáng de yìlì yǔ kēxué de xùnliàn tǐxì, zài shìjiè tiánjìng jǐnbiāosài shang zàicì shuāxīn le yóu zìjǐ bǎochí de nánzǐ bǎimǐ shìjiè jìlù.',
        meaning_vi: 'Ngôi sao chạy cự ly ngắn này nhờ vào nghị lực ngoan cường cùng hệ thống huấn luyện khoa học, một lần nữa phá vỡ kỷ lục thế giới 100m nam do chính mình nắm giữ tại Giải vô địch Điền kinh thế giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2543,
    hanzi: '纪录片',
    pinyin: 'jìlùpiàn',
    word_type: 'Danh từ',
    meaning_vi: 'phim tài liệu',
    examples: [
      {
        chinese: '这部关于非洲野生动物生存现状的纪录片拍摄得非常震撼。',
        pinyin: 'Zhè bù guānyú Fēizhōu yěshēng dòngwù shēngcún xiànzhuàng de jìlùpiàn pāishè de fēicháng zhènhàn.',
        meaning_vi: 'Bộ phim tài liệu về thực trạng sinh tồn của động vật hoang dã châu Phi này được quay vô cùng ấn tượng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '大型人文历史纪录片《舌尖上的中国》以美食为生动载体，多维度呈现了中华农耕文明的博大精深与人间烟火温情。',
        pinyin: 'Dàxíng rénwén lìshǐ jìlùpiàn 《Shéjiān shang de Zhōngguó》 yǐ měishí wéi shēngdòng zàitǐ, duō wéidù chéngxiàn le Zhōnghuá nónggēng wénmíng de bódà-jīngshēn yǔ rénjiān yānhuǒ wēnqíng.',
        meaning_vi: 'Bộ phim tài liệu lịch sử nhân văn quy mô lớn "Mỹ vị Trung Hoa" lấy ẩm thực làm phương tiện chuyển tải sống động, tái hiện đa chiều sự uyên thâm của nền văn minh nông nghiệp Trung Hoa cùng hơi thở ấm áp đời thường.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2544,
    hanzi: '技能',
    pinyin: 'jìnéng',
    word_type: 'Danh từ',
    meaning_vi: 'kỹ năng, tay nghề',
    examples: [
      {
        chinese: '熟练掌握一门外语和计算机软件应用是一项非常有用的职业技能。',
        pinyin: 'Shúliàn zhǎngwò yì mén wàiyǔ hé jìsuànjī ruǎnjiàn yìngyòng shì yí xiàng fēicháng yǒuyòng de zhíyè jìnéng.',
        meaning_vi: 'Nắm vững thành thạo một ngoại ngữ và ứng dụng phần mềm máy tính là một kỹ năng nghề nghiệp vô cùng hữu ích.',
        difficulty_level: 'basic'
      },
      {
        chinese: '职业技术教育必须紧密对接现代产业体系转型需求，重点培养兼具深厚理论素养与卓越实操技能的复合型工匠人才。',
        pinyin: 'Zhíyè jìshù jiàoyù bìxū jǐnmì duìjiē xiàndài chǎnyè tǐxì zhuǎnxíng xūqiú, zhòngdiǎn péiyǎng jiānjù shēnhòu lǐlùn sùyǎng yǔ zhuóyuè shícāo jìnéng de fùhéxíng gōngjiàng réncái.',
        meaning_vi: 'Giáo dục kỹ thuật nghề nghiệp cần kết nối chặt chẽ với nhu cầu chuyển đổi hệ thống ngành nghề hiện đại, chú trọng bồi dưỡng đội ngũ nghệ nhân thợ lành nghề đa năng kết hợp tố chất lý thuyết vững vàng cùng kỹ năng thực hành xuất sắc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2545,
    hanzi: '纪念',
    pinyin: 'jìniàn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'kỷ niệm, tưởng nhớ; đồ lưu niệm',
    examples: [
      {
        chinese: '临别前，同学们相互赠送了精美的小礼品留作纪念。',
        pinyin: 'Línbié qián, tóngxuémen xiānghù zèngsòng le jīngměi de xiǎo lǐpǐn liú zuò jìniàn.',
        meaning_vi: 'Trước khi chia tay, các bạn học sinh tặng nhau những món quà nhỏ tinh xảo để làm kỷ niệm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '社会各界代表在烈士纪念碑前肃立默哀并敬献花篮，深切纪念为国家独立和民族解放英勇献身的先烈们。',
        pinyin: 'Shèhuì gèjiè dàibiǎo zài lièshì jìniànbēi qián sùlì mò’āi bìng jìngxiàn huālán, shēnqiè jìniàn wèi guójiā dúlì hé mínzú jiěfàng yīngyǒng xiànshēn de xiānlièmen.',
        meaning_vi: 'Đại biểu các giới xã hội đứng trang nghiêm mặc niệm và dâng hoa trước bia tưởng niệm liệt sĩ, thành kính tưởng nhớ những bậc tiền bối anh dũng hy sinh vì độc lập dân tộc và tự do đất nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2546,
    hanzi: '纪念日',
    pinyin: 'jìniànrì',
    word_type: 'Danh từ',
    meaning_vi: 'ngày kỷ niệm',
    examples: [
      {
        chinese: '今天是他们结婚十周年的纪念日，全家人一起吃了一顿丰盛的晚餐。',
        pinyin: 'Jīntiān shì tāmen jiéhūn shí zhōunián de jìniànrì, quán jiārén yìqǐ chī le yí dùn fēngshèng de wǎncān.',
        meaning_vi: 'Hôm nay là ngày kỷ niệm 10 năm ngày cưới của họ, cả nhà cùng ăn một bữa tối thịnh soạn bên nhau.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在世界环境日与国际生物多样性纪念日来临之际，众多环保公益组织携手发起了一系列倡导低碳生活的大型公益宣传活动。',
        pinyin: 'Zài Shìjiè Huánjìng Rì yǔ Guójì Shēngwù Duōyàngxìng Jìniànrì láilín zhījì, zhòngduō huánbǎo gōngyì zǔzhī xiéshǒu fāqǐ le yí xìliè chàngdǎo dītàn shēnghuó de dàxíng gōngyì xuānchuán huódòng.',
        meaning_vi: 'Nhân dịp Ngày Môi trường Thế giới và Ngày Quốc tế Đa dạng sinh học, nhiều tổ chức bảo vệ môi trường đã chung tay phát động một chuỗi các hoạt động tuyên truyền cộng đồng quy mô lớn cổ vũ lối sống ít phát thải carbon.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2547,
    hanzi: '计算',
    pinyin: 'jìsuàn',
    word_type: 'Động từ',
    meaning_vi: 'tính toán, dự tính',
    examples: [
      {
        chinese: '请同学们用草稿纸仔细计算这道数学题的最终答案。',
        pinyin: 'Qǐng tóngxuémen yòng cǎogǎozhǐ zǐxì jìsuàn zhè dào shùxuétí de zuìzhōng dá’àn.',
        meaning_vi: 'Xin các bạn học sinh dùng giấy nháp tính toán thật cẩn thận đáp án cuối cùng của bài toán này.',
        difficulty_level: 'basic'
      },
      {
        chinese: '量子计算机利用量子叠加与纠缠原理，能够在极短时间内完成传统超级计算机需要耗费数百年才能算出的复杂高维矩阵计算。',
        pinyin: 'Liàngzǐ jìsuànjī lìyòng liàngzǐ diéjiā yǔ jiūchán yuánlǐ, nénggòu zài jí duǎn shíjiān nèi wánchéng chuántǒng chāojí jìsuànjī xūyào hàofèi shù bǎi nián cáinéng suànchū de fùzá gāowéi jùzhèn jìsuàn.',
        meaning_vi: 'Máy tính lượng tử ứng dụng nguyên lý chồng chập và rối lượng tử, có khả năng giải quyết trong nháy mắt những phép tính ma trận nhiều chiều phức tạp mà siêu máy tính truyền thống phải mất hàng trăm năm mới tính nổi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2548,
    hanzi: '计算机',
    pinyin: 'jìsuànjī',
    word_type: 'Danh từ',
    meaning_vi: 'máy tính, máy vi tính',
    examples: [
      {
        chinese: '图书馆里配备了多台计算机，方便学生们查询各类图书资料。',
        pinyin: 'Túshūguǎn lǐ pèibèi le duō tái jìsuànjī, fāngbiàn xuéshengmen cháxún gèlèi túshū zīliào.',
        meaning_vi: 'Trong thư viện được trang bị nhiều dàn máy tính, tạo thuận tiện cho sinh viên tra cứu các loại tài liệu sách vở.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高性能超级计算机群作为国家基础科研的重要战略重器，在气候模拟、航天工程动力学以及新药分子靶点筛选中发挥着无可替代的核心作用。',
        pinyin: 'Gāo xìngnéng chāojí jìsuànjī qún zuòwéi guójiā jīchǔ kēyán de zhòngyào zhànlüè zhòngqì, zài qìhòu mónǐ, hángtiān gōngchéng dònglìxué yǐjí xīnyào fēnzǐ bǎdiǎn shāixuǎn zhōng fāhuī zhe wúkě tìdài de héxīn zuòyòng.',
        meaning_vi: 'Hệ thống cụm siêu máy tính hiệu năng cao với tư cách là bảo bối chiến lược quan trọng của nghiên cứu khoa học cơ bản quốc gia, đóng vai trò cốt lõi không thể thay thế trong mô phỏng khí hậu, khí động lực học hàng không vũ trụ và sàng lọc phân tử đích phát triển thuốc mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2549,
    hanzi: '记忆',
    pinyin: 'jìyì',
    word_type: 'Danh từ / Động từ',
    meaning_vi: 'ký ức, trí nhớ; ghi nhớ',
    examples: [
      {
        chinese: '故乡门前的那条清澈小河，留下了我童年最美好的记忆。',
        pinyin: 'Gùxiāng ménqián de nà tiáo qīngchè xiǎohé, liúxià le wǒ tóngnián zuì měihǎo de jìyì.',
        meaning_vi: 'Dòng sông nhỏ trong vắt trước cửa quê nhà đã lưu giữ những ký ức tuổi thơ tươi đẹp nhất của tôi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '神经科学研究表明，规律的深度睡眠和科学的联想记忆法，能显著增强大脑海马体对新信息的长时程记忆巩固。',
        pinyin: 'Shénjīng kēxué yánjiū biǎomíng, guīlǜ de shēndù shuìmián hé kēxué de liánxiǎng jìyìfǎ, néng xiǎnzhù zēngqiáng dànǎo hǎimǎtǐ duì xīn xìnxī de chángshíchéng jìyì gǒnggù.',
        meaning_vi: 'Nghiên cứu khoa học thần kinh chỉ ra rằng, giấc ngủ sâu điều độ và phương pháp liên tưởng ghi nhớ khoa học có thể nâng cao rõ rệt sự củng cố trí nhớ dài hạn của hồi hải mã não bộ đối với thông tin mới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2550,
    hanzi: '记载',
    pinyin: 'jìzǎi',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'ghi chép lại, ghi vào sử sách; sách ghi chép',
    examples: [
      {
        chinese: '这部地方县志里详细记载了该古镇数百年的历史变迁。',
        pinyin: 'Zhè bù dìfāng xiànzhì lǐ xiángxì jìzǎi le gāi gǔzhèn shù bǎi nián de lìshǐ biànqiān.',
        meaning_vi: 'Trong cuốn huyện chí địa phương này đã ghi chép chi tiết những đổi thay lịch sử suốt mấy trăm năm của thị trấn cổ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '据古籍文献明确记载，早在两千多年前的汉代，古丝绸之路就已成为连接东西方商贸往来与文明互鉴的重要桥梁。',
        pinyin: 'Jù gǔjí wénxiàn míngquè jìzǎi, zǎozài liǎng qiān duō nián qián de Hàndài, gǔ Sīchóu zhī Lù jiù yǐ chéngwéi liánjiē dōng-xīfāng shāngmào wǎnglái yǔ wénmíng hùjiàn de zhòngyào qiáoliáng.',
        meaning_vi: 'Theo ghi chép rõ ràng trong các tài liệu cổ tịch, ngay từ thời nhà Hán hơn 2000 năm trước, Con đường Tơ lụa cổ đại đã trở thành chiếc cầu nối trọng yếu liên kết giao thương buôn bán và học hỏi lẫn nhau giữa các nền văn minh Đông - Tây.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2551,
    hanzi: '嘉宾',
    pinyin: 'jiābīn',
    word_type: 'Danh từ',
    meaning_vi: 'khách quý, khách mời danh dự',
    examples: [
      {
        chinese: '晚会开始前，主持人和工作人员热情欢迎各位特邀嘉宾的到来。',
        pinyin: 'Wǎnhuì kāishǐ qián, zhǔchírén hé gōngzuò rényuán rèqíng huānyíng gèwèi tèyāo jiābīn de dàolái.',
        meaning_vi: 'Trước khi đêm hội bắt đầu, người dẫn chương trình và các nhân viên nhiệt tình chào đón sự hiện diện của các vị khách quý đặc biệt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '本届国际人工智能高端峰会汇聚了来自联合国机构、世界顶尖高校及科技巨头的数百位重量级演讲嘉宾。',
        pinyin: 'Běn jiè guójì réngōng zhìnéng gāoduān fēnghuì huìjù le láizì Liánhéguó jīgòu, shìjiè dǐngjiān gāoxiào jí kējì jùtóu de shù bǎi wèi zhòngliàngjí yǎnjiǎng jiābīn.',
        meaning_vi: 'Hội nghị thượng đỉnh trí tuệ nhân tạo quốc tế kỳ này quy tụ hàng trăm vị diễn giả khách mời tầm cỡ đến từ các cơ quan Liên Hợp Quốc, các trường đại học hàng đầu thế giới cùng các gã khổng lồ công nghệ.',
        difficulty_level: 'applied'
      }
    ]
  }
]
