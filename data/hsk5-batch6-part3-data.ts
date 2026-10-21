// data/hsk5-batch6-part3-data.ts
// 25 từ HSK 5: #2552 [家电] -> #2576 [键盘]

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

export const HSK5_BATCH6_PART3: VocabItem[] = [
  {
    id: 2552,
    hanzi: '家电',
    pinyin: 'jiādiàn',
    word_type: 'Danh từ',
    meaning_vi: 'đồ điện gia dụng, thiết bị điện gia đình',
    examples: [
      {
        chinese: '新搬进公寓后，我们添置了冰箱、洗衣机和微波炉等常用家电。',
        pinyin: 'Xīn bānjìn gōngyù hòu, wǒmen tiānzhì le bīngxiāng, xǐyījī hé wēibōlú děng chángyòng jiādiàn.',
        meaning_vi: 'Sau khi dọn về căn hộ mới, chúng tôi đã mua sắm thêm các đồ điện gia dụng quen thuộc như tủ lạnh, máy giặt và lò vi sóng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家出台的绿色智能家电以旧换新补贴政策，有效激发了消费者的换机意愿，带动了绿色循环经济的发展。',
        pinyin: 'Guójiā chūtái de lǜsè zhìnéng jiādiàn yǐjiù-huànxīn bǔtiē zhèngcè, yǒuxiào jīfā le xiāofèizhě de huànjī yìyuàn, dàidòng le lǜsè xúnhuán jīngjì de fāzhǎn.',
        meaning_vi: 'Chính sách trợ cấp đổi đồ cũ lấy mới thiết bị điện gia dụng xanh và thông minh do nhà nước ban hành đã kích thích hiệu quả nhu cầu đổi mới của người tiêu dùng, thúc đẩy sự phát triển của nền kinh tế tuần hoàn xanh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2553,
    hanzi: '加工',
    pinyin: 'jiāgōng',
    word_type: 'Động từ',
    meaning_vi: 'gia công, chế biến, chế tạo',
    examples: [
      {
        chinese: '这些新鲜采摘的草莓将被直接运往食品厂加工成可口的果酱。',
        pinyin: 'Zhèxiē xīnxiān cǎizhāi de cǎoméi jiāng bèi zhíjiē yùnwǎng shípǐnchǎng jiāgōng chéng kěkǒu de guǒjiàng.',
        meaning_vi: 'Những quả dâu tây mới hái này sẽ được vận chuyển thẳng tới nhà máy thực phẩm để gia công thành mứt hoa quả thơm ngon.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该高新技术产业园区正致力于摆脱传统低附加值的来料加工模式，转向以高精尖工业母机精密机械加工为核心的高端价值链。',
        pinyin: 'Gāi gāoxīnjìshù chǎnyè yuánqū zhèng zhìlìyú bǎituō chuántǒng dī fùjiāzhí de láiliào jiāgōng móshì, zhuǎnxiàng yǐ gāojīngjiān gōngyè mǔjī jīngmì jīxiè jiāgōng wéi héxīn de gāoduān jiàzhíliàn.',
        meaning_vi: 'Khu công nghiệp công nghệ cao này đang nỗ lực thoát khỏi mô hình gia công nhận nguyên liệu truyền thống có giá trị gia tăng thấp, chuyển sang chuỗi giá trị cao cấp lấy gia công cơ khí chính xác của máy công cụ đầu ngành làm hạt nhân.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2554,
    hanzi: '加热',
    pinyin: 'jiārè',
    word_type: 'Động từ',
    meaning_vi: 'làm nóng, hâm nóng, gia nhiệt',
    examples: [
      {
        chinese: '饭菜凉了，你放在微波炉里加热两分钟就可以吃了。',
        pinyin: 'Fàncài liáng le, nǐ fàng zài wēibōlú lǐ jiārè liǎng fēnzhōng jiù kěyǐ chī le.',
        meaning_vi: 'Cơm canh nguội rồi, cậu để vào lò vi sóng hâm nóng hai phút là có thể dùng được ngay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在特种合金钢冶炼过程中，必须通过高频电磁感应精准控制加热温度曲线，以确保金属晶粒组织的均匀致密。',
        pinyin: 'Zài tèzhǒng héjīngāng yěliàn guòchéng zhōng, bìxū tōngguò gāopín diàncí gǎnyìng jīngzhǔn kòngzhì jiārè wēndù qūxiàn, yǐ quèbǎo jīnshǔ jīnglì zǔzhī de jūnyún zhìmì.',
        meaning_vi: 'Trong quy trình luyện thép hợp kim đặc chủng, bắt buộc phải kiểm soát chuẩn xác đường cong nhiệt độ nung qua cảm ứng điện từ cao tần để bảo đảm cấu trúc hạt tinh thể kim loại đồng đều và chặt chẽ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2555,
    hanzi: '加深',
    pinyin: 'jiāshēn',
    word_type: 'Động từ',
    meaning_vi: 'làm sâu thêm, làm sâu sắc thêm, khắc sâu',
    examples: [
      {
        chinese: '通过这次面对面的坦诚沟通，我们彼此加深了了解与友谊。',
        pinyin: 'Tōngguò zhè cì miànduìmiàn de tǎnchéng gōutōng, wǒmen bǐcǐ jiāshēn le liǎojiě yǔ yǒuyì.',
        meaning_vi: 'Thông qua cuộc đối thoại trực diện chân thành lần này, chúng tôi đã hiểu biết sâu sắc hơn về nhau và gắn kết tình bạn thêm bền chặt.',
        difficulty_level: 'basic'
      },
      {
        chinese: '两国外交代表团围绕地缘政治、能源安全等重大议题举行战略对话，进一步加深了双方在多边舞台上的互信与协作。',
        pinyin: 'Liǎng guó wàijiāo dàibiǎotuán wéirào dìyuán zhèngzhì, néngyuán ānquán děng zhòngdà yìtí jǔxíng zhànlüè duìhuà, jìnyíbù jiāshēn le shuāngfāng zài duōbiān wǔtái shang de hùxìn yǔ xiézuò.',
        meaning_vi: 'Đoàn đại biểu ngoại giao hai nước đã tiến hành đối thoại chiến lược xoay quanh các chủ đề trọng đại như địa chính trị và an ninh năng lượng, làm sâu sắc hơn nữa sự tin cậy lẫn nhau và phối hợp trên trường quốc tế đa phương.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2556,
    hanzi: '加速',
    pinyin: 'jiāsù',
    word_type: 'Động từ',
    meaning_vi: 'gia tốc, tăng tốc, đẩy nhanh tiến độ',
    examples: [
      {
        chinese: '司机踩下了油门，汽车开始在高速公路上加速向前飞驰。',
        pinyin: 'Sījī cǎixià le yóumén, qìchē kāishǐ zài gāosù gōnglù shang jiāsù xiàng qián fēichí.',
        meaning_vi: 'Tài xế nhấn chân ga, chiếc ô tô bắt đầu tăng tốc lao nhanh về phía trước trên đường cao tốc.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着新一轮科技革命的到来，数字技术与实体经济深度融合正加速赋能传统产业转型升级。',
        pinyin: 'Suízhe xīn yì lún kējì gémìng de dàolái, shùzì jìshù yǔ shítǐ jīngjì shēndù rónghé zhèng jiāsù fùnéng chuántǒng chǎnyè zhuǎnxíng shēngjí.',
        meaning_vi: 'Cùng với sự xuất hiện của cuộc cách mạng khoa học công nghệ mới, sự hội nhập sâu rộng giữa công nghệ số và kinh tế thực thể đang tăng tốc trợ lực cho sự chuyển đổi và nâng cấp của các ngành công nghiệp truyền thống.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2557,
    hanzi: '家务',
    pinyin: 'jiāwù',
    word_type: 'Danh từ',
    meaning_vi: 'việc nhà, công việc nội trợ',
    examples: [
      {
        chinese: '周末的时候，夫妻俩分工合作，一起打扫卫生、做家务。',
        pinyin: 'Zhōumò de shíhou, fūqī liǎ fēngōng hézuò, yìqǐ dǎsǎo wèishēng, zuò jiāwù.',
        meaning_vi: 'Vào cuối tuần, hai vợ chồng cùng phân công hợp tác, vừa quét dọn vệ sinh vừa làm các việc nội trợ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '智能洗碗机、扫地机器人及烘干机等智能家电的普及，极大地减轻了现代职场家庭繁重的家务负担。',
        pinyin: 'Zhìnéng xǐwǎnjī, sǎodì jīqìrén jí hōnggānjī děng zhìnéng jiādiàn de pǔjí, jídà de jiǎnqīng le xiàndài zhíchǎng jiātíng fánzhòng de jiāwù fùdān.',
        meaning_vi: 'Việc phổ cập các thiết bị gia dụng thông minh như máy rửa bát, robot hút bụi và máy sấy quần áo đã giảm nhẹ đáng kể gánh nặng việc nhà bề bộn cho các gia đình công sở hiện đại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2558,
    hanzi: '甲',
    pinyin: 'jiǎ',
    word_type: 'Danh từ / Tính từ',
    meaning_vi: 'Giáp (thiên can thứ nhất), loại A, hạng nhất; bên A; áo giáp, móng (móng tay)',
    examples: [
      {
        chinese: '在商务合作合同中，通常将出资方或者委托方称为甲方。',
        pinyin: 'Zài shāngwù hézuò hétong zhōng, tōngcháng jiāng chūzīfāng huòzhě wěituōfāng chēngwéi Jiǎfāng.',
        meaning_vi: 'Trong các hợp đồng hợp tác thương mại, bên cấp vốn hoặc bên ủy thác thường được gọi là Bên A.',
        difficulty_level: 'basic'
      },
      {
        chinese: '该医疗中心经过严谨的国家评审，成功获批成为具有最高综合诊疗水平的三级甲等综合医院。',
        pinyin: 'Gāi yīliáo zhōngxīn jīngguò yánjǐn de guójiā píngshěn, chénggōng huòpī chéngwéi jùyǒu zuì gāo zōnghé zhěnliáo shuǐpíng de sān jí jiǎ děng zōnghé yīyuàn.',
        meaning_vi: 'Trung tâm y tế này qua quá trình thẩm định nghiêm ngặt cấp quốc gia đã được phê duyệt thành công trở thành bệnh viện đa khoa tuyến 3 hạng A (cấp cao nhất) với năng lực khám chữa bệnh tổng hợp hàng đầu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2559,
    hanzi: '假如',
    pinyin: 'jiǎrú',
    word_type: 'Liên từ',
    meaning_vi: 'nếu như, giả sử, ví như',
    examples: [
      {
        chinese: '假如明天天气晴朗无风，我们就去郊外的森林公园露营。',
        pinyin: 'Jiǎrú míngtiān tiānqì qínglǎng wú fēng, wǒmen jiù qù jiāowài de sēnlín gōngyuán lùyíng.',
        meaning_vi: 'Nếu như ngày mai trời nắng đẹp không có gió, chúng ta sẽ đi cắm trại ở công viên rừng ngoại ô.',
        difficulty_level: 'basic'
      },
      {
        chinese: '假如不能在关键核心软硬件技术上实现真正的自主可控，企业在未来的国际产业链重构中就极易陷入受制于人的被动境地。',
        pinyin: 'Jiǎrú bùnéng zài guānjiàn héxīn ruǎnyìngjiàn jìshù shang shíxiàn zhēnzhèng de zìzhǔ kěkòng, qǐyè zài wèilái de guójì chǎnyèliàn chónggòu zhōng jiù jí yì xiànrù shòuzhìyúrén de bèidòng jìngdì.',
        meaning_vi: 'Giả sử không thể thực hiện được việc tự chủ kiểm soát thực chất ở các công nghệ phần cứng và phần mềm then chốt, doanh nghiệp trong tương lai sẽ rất dễ rơi vào thế bị động phụ thuộc khi chuỗi cung ứng công nghiệp toàn cầu tái cấu trúc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2560,
    hanzi: '架',
    pinyin: 'jià',
    word_type: 'Danh từ / Động từ / Lượng từ',
    meaning_vi: 'giá, khung, giàn; bắc, gác; cỗ, chiếc (máy bay, piano); cãi lộn, đánh nhau',
    examples: [
      {
        chinese: '书房的墙边整齐摆放着一个高大的实木书架。',
        pinyin: 'Shūfáng de qiángbiān zhěngqí bǎifàng zhe yí gè gāodà de shímù shūjià.',
        meaning_vi: 'Bên bức tường phòng sách bài trí ngay ngắn một chiếc giá sách gỗ thịt cao lớn.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在这片崇山峻岭之间，桥梁工程师们凭借高超技术成功架设起了一座跨越千米深谷的特大型悬索大桥。',
        pinyin: 'Zài zhè piàn chóngshān-jùnlǐng zhījiān, qiáoliáng gōngchéngshīmen píngjiè gāochāo jìshù chénggōng jiàshè qǐ le yí zuò kuàyuè qiān mǐ shēngǔ de tèdàxíng xuánsuǒ dàqiáo.',
        meaning_vi: 'Giữa những dãy núi non trùng điệp này, các kỹ sư cầu đường bằng kỹ thuật siêu việt đã bắc dựng thành công một cây cầu treo dây võng cỡ siêu lớn bắc qua hẻm vực sâu hàng nghìn mét.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2561,
    hanzi: '驾驶',
    pinyin: 'jiàshǐ',
    word_type: 'Động từ',
    meaning_vi: 'lái xe, điều khiển, vận hành (phương tiện giao thông)',
    examples: [
      {
        chinese: '为了确保交通安全，驾驶员在开车途中严禁使用手机。',
        pinyin: 'Wèile quèbǎo jiāotōng ānquán, jiàshǐyuán zài kāichē túzhōng yánjìn shǐyòng shǒujī.',
        meaning_vi: 'Để bảo đảm an toàn giao thông, tài xế bị nghiêm cấm sử dụng điện thoại khi đang lái xe.',
        difficulty_level: 'basic'
      },
      {
        chinese: '基于激光雷达与高精地图的L4级别自动驾驶汽车，已在国内多个先行先试智慧城市示范区展开常态化道路载客测试。',
        pinyin: 'Jīyú jīguāng léidá yǔ gāojīng dìtú de L4 jíbié zìdòng jiàshǐ qìchē, yǐ zài guónèi duō gè xiānxíng-xiānshì zhìhuì chéngshì shìfànqū zhǎnkāi chángtàihuà dàolù zàikè cèshì.',
        meaning_vi: 'Xe ô tô tự hành cấp độ L4 dựa trên cảm biến lidar và bản đồ độ chính xác cao đã bắt đầu triển khai thử nghiệm chở khách trên đường phố định kỳ tại nhiều khu đô thị thông minh thí điểm tiên phong trong nước.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2562,
    hanzi: '驾照',
    pinyin: 'jiàzhào',
    word_type: 'Danh từ',
    meaning_vi: 'bằng lái xe, giấy phép lái xe',
    examples: [
      {
        chinese: '他经过三个月的刻苦练习，终于顺利考取了小型汽车驾照。',
        pinyin: 'Tā jīngguò sān gè yuè de kèkǔ liànxí, zhōngyú shùnlì kǎoqǔ le xiǎoxíng qìchē jiàzhào.',
        meaning_vi: 'Qua 3 tháng khổ luyện, anh ấy cuối cùng đã thuận lợi thi đỗ bằng lái xe ô tô con.',
        difficulty_level: 'basic'
      },
      {
        chinese: '公安交管部门全面推行电子驾照互认与网上年审服务，极大地方便了跨省市出差与租车出行的广大群众。',
        pinyin: 'Gōng’ān jiāoguǎn bùmén quánmiàn tuīxíng diànzǐ jiàzhào hùrèn yǔ wǎngshang niánshěn fúwù, jídà de fāngbiàn le kuà shěng-shì chūchāi yǔ zūchē chūxíng de guǎngdà qúnzhòng.',
        meaning_vi: 'Cơ quan quản lý giao thông công an đã triển khai toàn diện việc công nhận bằng lái xe điện tử liên tỉnh và dịch vụ kiểm định online, tạo thuận tiện rất lớn cho đông đảo người dân đi công tác và thuê xe đi lại liên tỉnh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2563,
    hanzi: '价值',
    pinyin: 'jiàzhí',
    word_type: 'Danh từ',
    meaning_vi: 'giá trị, ý nghĩa',
    examples: [
      {
        chinese: '这本古籍具有极高的历史文化研究价值。',
        pinyin: 'Zhè běn gǔjí jùyǒu jí gāo de lìshǐ wénhuà yánjiū jiàzhí.',
        meaning_vi: 'Cuốn sách cổ này có giá trị nghiên cứu lịch sử văn hóa vô cùng cao.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业不仅要追求短期的经济效益，更应当积极承担社会责任，从而为全体股东与社会各界创造可持续的长期综合价值。',
        pinyin: 'Qǐyè bùjǐn yào zhuīqiú duǎnqī de jīngjì xiàoyì, gèng yīngdāng jījí chéngdān shèhuì zérèn, cóng’ér wèi quántǐ gǔdōng yǔ shèhuì gèjiè chuàngzào kěchíxù de chángqī zōnghé jiàzhí.',
        meaning_vi: 'Doanh nghiệp không chỉ theo đuổi lợi ích kinh tế trước mắt, mà càng nên tích cực gánh vác trách nhiệm xã hội, qua đó kiến tạo giá trị tổng hợp lâu dài bền vững cho toàn thể cổ đông và cộng đồng xã hội.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2564,
    hanzi: '艰苦',
    pinyin: 'jiānkǔ',
    word_type: 'Tính từ',
    meaning_vi: 'gian khổ, gian nan, khó nhọc',
    examples: [
      {
        chinese: '老一辈建设者在十分艰苦的自然条件下开辟出了这片绿洲。',
        pinyin: 'Lǎoyíbèi jiànshèzhě zài shífēn jiānkǔ de zìrán tiáojiàn xià kāipì chū le zhè piàn lǜzhōu.',
        meaning_vi: 'Thế hệ những người kiến thiết đi trước đã khai phá nên ốc đảo này giữa những điều kiện tự nhiên vô cùng gian khổ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '地质科研勘探队员们发扬艰苦奋斗、勇攀高峰的奉献精神，常年在海拔数千米的高原荒漠腹地开展矿产资源勘测。',
        pinyin: 'Dìzhì kēyán kāntànduìyuánmen fāyáng jiānkǔ-fèndòu, yǒngpān-gāofēng de fèngxiàn jīngshén, chángnián zài hǎibá shù qiān mǐ de gāoyuán huāngmò fùdì kāizhǎn kuàngchǎn zīyuán kāncè.',
        meaning_vi: 'Các thành viên đội thăm dò nghiên cứu địa chất đã phát huy tinh thần cống hiến gian khổ phấn đấu dũng cảm trèo lên đỉnh cao, quanh năm bám trụ sâu trong lòng sa mạc cao nguyên hàng nghìn mét so với mực nước biển để khảo sát tài nguyên khoáng sản.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2565,
    hanzi: '坚强',
    pinyin: 'jiānqiáng',
    word_type: 'Tính từ',
    meaning_vi: 'kiên cường, bất khuất, vững vàng',
    examples: [
      {
        chinese: '她是一个坚强的女孩，面对生活中的挫折从不轻言放弃。',
        pinyin: 'Tā shì yí gè jiānqiáng de nǚhái, miànduì shēnghuó zhōng de cuòzhé cóngbù qīngyán fàngqì.',
        meaning_vi: 'Cô ấy là một cô gái kiên cường, đối mặt với những trắc trở trong cuộc sống không bao giờ dễ dàng buông xuôi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在抗击重大自然灾害的危急关头，党组织始终是凝聚各方力量、带领灾区群众战胜一切险阻的最坚强战斗堡垒。',
        pinyin: 'Zài kàngjī zhòngdà zìrán zāihài de wēijí guāntóu, dǎngzǔzhī shǐzhōng shì níngjù gèfāng lìliàng, dàilǐng zāiqū qúnzhòng zhànshèng yíqiè xiǎnzǔ de zuì jiānqiáng zhàndòu bǎolěi.',
        meaning_vi: 'Trong thời khắc hiểm nghèo chống chọi với thiên tai nghiêm trọng, tổ chức luôn là pháo đài chiến đấu kiên cường nhất quy tụ mọi nguồn lực, dẫn dắt đồng bào vùng thiên tai vượt qua mọi hiểm nguy trắc trở.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2566,
    hanzi: '捡',
    pinyin: 'jiǎn',
    word_type: 'Động từ',
    meaning_vi: 'nhặt, lượm',
    examples: [
      {
        chinese: '他在操场上跑步时，顺手捡起了一串别人不慎遗落的钥匙。',
        pinyin: 'Tā zài cǎochǎng shang pǎobù shí, shùnshǒu jiǎnqǐ le yí chuàn biérén búshèn yíluò de yàoshi.',
        meaning_vi: 'Khi chạy bộ trên sân thể dục, anh ấy tiện tay nhặt được một chùm chìa khóa do người khác sơ ý đánh rơi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '小学生们利用周末课余时间在海滩开展环保公益行动，弯腰捡起游客丢弃的塑料垃圾，以此唤醒公众的海洋环保意识。',
        pinyin: 'Xiǎoxuéshēngmen lìyòng zhōumò kèyú shíjiān zài hǎitān kāizhǎn huánbǎo gōngyì xíngdòng, wānyāo jiǎnqǐ yóukè diūqì de sùliào lājī, yǐcǐ huànxǐng gōngzhòng de hǎiyáng huánbǎo yìshí.',
        meaning_vi: 'Các em học sinh tiểu học đã tranh thủ thời gian rảnh rỗi cuối tuần tổ chức hoạt động công ích bảo vệ môi trường trên bờ biển, cúi người nhặt từng chiếc rác nhựa du khách vứt lại, qua đó đánh thức ý thức bảo vệ đại dương của cộng đồng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2567,
    hanzi: '剪',
    pinyin: 'jiǎn',
    word_type: 'Động từ',
    meaning_vi: 'cắt (bằng kéo), tỉa, xén',
    examples: [
      {
        chinese: '理发师正在专注而细致地为顾客修剪刘海。',
        pinyin: 'Lǐfàshī zhèngzài zhuānzhù ér xìzhì de wèi gùkè xiūjiǎn liúhǎi.',
        meaning_vi: 'Người thợ cắt tóc đang chăm chú và tỉ mỉ cắt tỉa phần tóc mái cho khách hàng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '作为国家级非物质文化遗产，剪纸艺人仅凭一把剪刀和一张红纸，便能灵巧地剪出惟妙惟肖、寓意吉祥的传统民俗图案。',
        pinyin: 'Zuòwéi guójiājí fēiwùzhì wénhuà yíchǎn, jiǎnzhǐ yìrén jǐn píng yì bǎ jiǎndāo hé yì zhāng hóngzhǐ, biàn néng língqiǎo de jiǎn chū wéimiào-wéixiào, yùyì jíxiáng de chuántǒng mínsú tú’àn.',
        meaning_vi: 'Là di sản văn hóa phi vật thể cấp quốc gia, nghệ nhân cắt giấy chỉ bằng một cây kéo và một tờ giấy đỏ đã có thể khéo léo cắt tỉa ra những hoa văn dân gian truyền thống sống động như thật mang ngụ ý cát tường.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2568,
    hanzi: '剪刀',
    pinyin: 'jiǎndāo',
    word_type: 'Danh từ',
    meaning_vi: 'cây kéo, cái kéo',
    examples: [
      {
        chinese: '做手工时请小心使用剪刀，注意不要划伤手指。',
        pinyin: 'Zuò shǒugōng shí qǐng xiǎoxīn shǐyòng jiǎndāo, zhùyì bú yào huáshāng shǒuzhǐ.',
        meaning_vi: 'Khi làm đồ thủ công xin hãy cẩn thận khi dùng kéo, chú ý không để cứa vào ngón tay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '现代外科手术所使用的高频超声手术剪刀，能够在精准分离人体细微软组织的同时实现快速止血，极大降低了术中风险。',
        pinyin: 'Xiàndài wàikē shǒushù suǒ shǐyòng de gāopín chāoshēng shǒushù jiǎndāo, nénggòu zài jīngzhǔn fēnlí réntǐ xìwēi ruǎnzǔzhī de tóngshí shíxiàn kuàisù zhǐxiě, jídà jiàngdī le shùzhōng fēngxiǎn.',
        meaning_vi: 'Kéo phẫu thuật siêu âm cao tần dùng trong phẫu thuật ngoại khoa hiện đại có thể cầm máu nhanh chóng đồng thời với việc bóc tách chính xác các mô mềm tinh vi của cơ thể người, giảm thiểu đáng kể rủi ro trong ca mổ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2569,
    hanzi: '减肥',
    pinyin: 'jiǎnféi',
    word_type: 'Động từ',
    meaning_vi: 'giảm cân, giảm béo',
    examples: [
      {
        chinese: '健康减肥应当靠合理控制饮食搭配规律体育锻炼，切忌盲目节食。',
        pinyin: 'Jiànkāng jiǎnféi yīngdāng kào hélǐ kòngzhì yǐnshí dāpèi guīlǜ tǐyù duànliàn, qièjì mángmù jiéshí.',
        meaning_vi: 'Giảm cân lành mạnh nên dựa vào việc kiểm soát hợp lý chế độ ăn kết hợp rèn luyện thể dục thể thao đều đặn, tuyệt đối tránh nhịn ăn mù quáng.',
        difficulty_level: 'basic'
      },
      {
        chinese: '医学专家指出，科学减重不仅是为了身材美观，更核心的意义在于通过降低体脂率与内脏脂肪，有效预防二型糖尿病和脂肪肝等代谢综合征。',
        pinyin: 'Yīxué zhuānjiā zhǐchū, kēxué jiǎnzhòng bùjǐn shì wèile shēncái měiguān, gèng héxīn de yìyì zàiyú tōngguò jiàngdī tǐzhǐlǜ yǔ nèizàng zhīfáng, yǒuxiào yùfáng èr xíng tángniàobìng hé zhīfánggān děng dàixiè zōnghézhēng.',
        meaning_vi: 'Các chuyên gia y học chỉ ra rằng, việc giảm cân khoa học không chỉ nhằm vóc dáng thẩm mỹ, mà ý nghĩa cốt lõi hơn là thông qua việc hạ thấp tỷ lệ mỡ cơ thể và mỡ nội tạng để phòng ngừa hiệu quả hội chứng chuyển hóa như tiểu đường tuýp 2 và gan nhiễm mỡ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2570,
    hanzi: '简历',
    pinyin: 'jiǎnlì',
    word_type: 'Danh từ',
    meaning_vi: 'sơ yếu lý lịch, CV, hồ sơ xin việc',
    examples: [
      {
        chinese: '求职前，请把个人简历制作得简洁美观且重点突出。',
        pinyin: 'Qiúzhí qián, qǐng bǎ gèrén jiǎnlì zhìzuò de jiǎnjié měiguān qiě zhòngdiǎn tūchū.',
        meaning_vi: 'Trước khi đi xin việc, hãy chuẩn bị một bản sơ yếu lý lịch cá nhân thật ngắn gọn, thẩm mỹ và làm nổi bật những điểm trọng tâm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在大型跨国企业的人才选拔中，人力资源部门通常利用智能化筛选系统对成千上万份求职简历进行多维度关键词匹配与量化评估。',
        pinyin: 'Zài dàxíng kuàguó qǐyè de réncái xuǎnbá zhōng, rénlì zīyuán bùmén tōngcháng lìyòng zhìnénghuà shāixuǎn xìtǒng duì chéngqiān-shàngwàn fèn qiúzhí jiǎnlì jìnxíng duō wéidù guānjiàncí pǐpèi yǔ liànghuà pínggū.',
        meaning_vi: 'Trong khâu tuyển chọn nhân tài của các doanh nghiệp đa quốc gia lớn, bộ phận nhân sự thường vận dụng hệ thống sàng lọc thông minh để đối sánh từ khóa đa chiều và đánh giá định lượng hàng vạn bản CV xin việc.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2571,
    hanzi: '简直',
    pinyin: 'jiǎnzhí',
    word_type: 'Phó từ',
    meaning_vi: 'quả là, gần như, tưởng chừng như, quả thật',
    examples: [
      {
        chinese: '他能在这么短的时间内把任务完成得如此完美，简直令人难以置信。',
        pinyin: 'Tā néng zài zhème duǎn de shíjiān nèi bǎ rènwu wánchéng de rúcǐ wánměi, jiǎnzhí lìngrén nányǐ zhìxìn.',
        meaning_vi: 'Anh ấy có thể hoàn thành xuất sắc nhiệm vụ trong thời gian ngắn như vậy, quả thật khiến người ta khó mà tin nổi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '面对突如其来的全球供应链断裂危机，该企业凭借灵活的本土替代方案化险为夷，其应对速度简直创造了行业奇迹。',
        pinyin: 'Miànduì tūrúqílái de quánqiú gōngyìngliàn duànliè wēijī, gāi qǐyè píngjiè línghuó de běntǔ tìdài fāng’àn huàxiǎnwéiyí, qí yìngduì sùdù jiǎnzhí chuàngzào le hángyè qíjì.',
        meaning_vi: 'Đối mặt với cuộc khủng hoảng đứt gãy chuỗi cung ứng toàn cầu ập tới bất ngờ, doanh nghiệp này nhờ vào phương án thay thế nội địa linh hoạt đã chuyển nguy thành an, tốc độ phản ứng của họ tưởng chừng như đã tạo nên một kỳ tích trong ngành.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2572,
    hanzi: '建',
    pinyin: 'jiàn',
    word_type: 'Động từ',
    meaning_vi: 'xây, xây dựng, kiến thiết, dựng lập',
    examples: [
      {
        chinese: '政府计划在城市东郊新建一所现代化的综合性大型医院。',
        pinyin: 'Zhèngfǔ jìhuà zài chéngshì dōngjiāo xīn jiàn yì suǒ xiàndàihuà de zōnghéxìng dàxíng yīyuàn.',
        meaning_vi: 'Chính quyền có kế hoạch xây dựng mới một bệnh viện đa khoa lớn hiện đại ở vùng ngoại ô phía đông thành phố.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为深入推进全国统一大市场建设，有关部门加快构建高标准市场体系与多层次数字物流骨干网络。',
        pinyin: 'Wèi shēnrù tuījìn quánguó tǒngyī dà shìchǎng jiànshè, yǒuguān bùmén jiākuài gòujiàn gāo biāozhǔn shìchǎng tǐxì yǔ duō céngcì shùzì wùliú gǔgàn wǎngluò.',
        meaning_vi: 'Nhằm đẩy mạnh việc xây dựng thị trường lớn thống nhất toàn quốc, các ban ngành hữu quan đang tăng tốc thiết lập hệ thống thị trường tiêu chuẩn cao và mạng lưới vận tải số xương sống đa tầng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2573,
    hanzi: '键',
    pinyin: 'jiàn',
    word_type: 'Danh từ',
    meaning_vi: 'phím (bàn phím), nút bấm; then chốt, mấu chốt',
    examples: [
      {
        chinese: '按一下电脑键盘上的回车键，就可以发送这条消息了。',
        pinyin: 'Àn yíxià diànnǎo jiànpán shang de huíchē jiàn, jiù kěyǐ fāsòng zhè tiáo xiāoxi le.',
        meaning_vi: 'Nhấn một cái vào phím Enter trên bàn phím máy tính là có thể gửi tin nhắn này đi.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在现代网络通信加密技术中，高强度非对称公钥与私钥密钥对是确保跨境数据安全传输不可或缺的核心安全机制。',
        pinyin: 'Zài xiàndài wǎngluò tōngxìn jiāmì jìshù zhōng, gāo qiángdù fēiduìchèn gōngyào yǔ sīyào mìyào duì shì quèbǎo kuàjìng shùjù ānquán chuānshū bùkě-huòquē de héxīn ānquán jīzhì.',
        meaning_vi: 'Trong công nghệ mã hóa truyền thông mạng hiện đại, cặp khóa công khai và bí mật bất đối xứng cường độ cao là cơ chế an ninh cốt lõi không thể thiếu bảo đảm sự truyền dẫn an toàn cho dữ liệu xuyên biên giới.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2574,
    hanzi: '渐渐',
    pinyin: 'jiànjiàn',
    word_type: 'Phó từ',
    meaning_vi: 'dần dần, từ từ',
    examples: [
      {
        chinese: '春天来了，天气渐渐变暖，公园里的百花也竞相盛开。',
        pinyin: 'Chūntiān lái le, tiānqì jiànjiàn biàn nuǎn, gōngyuán lǐ de bǎihuā yě jìngxiāng shèngkāi.',
        meaning_vi: 'Mùa xuân đến rồi, tiết trời dần dần ấm lên, trăm hoa trong công viên đua nhau khoe sắc nở rộ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着长期文化交融与经济互补，边境两国民众在日常生活与思想观念上的隔阂正渐渐消弭。',
        pinyin: 'Suízhe chángqī wénhuà jiāoróng yǔ jīngjì hùbǔ, biānjìng liǎng guó mínzhòng zài rìcháng shēnghuó yǔ sīxiǎng guānniàn shang de géhé zhèng jiànjiàn xiāomǐ.',
        meaning_vi: 'Cùng với sự giao thoa văn hóa lâu đời và bổ sung kinh tế cho nhau, những rào cản ngăn cách trong đời sống thường nhật và quan niệm tư tưởng của người dân hai nước vùng biên đang dần dần được xóa nhòa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2575,
    hanzi: '建立',
    pinyin: 'jiànlì',
    word_type: 'Động từ',
    meaning_vi: 'thành lập, xây dựng, xác lập, thiết lập',
    examples: [
      {
        chinese: '两所大学正式签署合作办学协议，建立了长期稳定的学术交流机制。',
        pinyin: 'Liǎng suǒ dàxué zhèngshì qiānshǔ hézuò bànxué xiéyì, jiànlì le chángqī wěndìng de xuéshù jiāoliú jīzhì.',
        meaning_vi: 'Hai trường đại học chính thức ký kết thỏa thuận liên kết đào tạo, thiết lập cơ chế giao lưu học thuật lâu dài và ổn định.',
        difficulty_level: 'basic'
      },
      {
        chinese: '为防范化解金融系统性风险，监管机构加快建立起覆盖全面、穿透精准、响应迅速的宏观审慎金融监管框架。',
        pinyin: 'Wèi fángfàn huàjiě jīnróng xìtǒngxìng fēngxiǎn, jiānguǎn jīgòu jiākuài jiànlì qǐ fùgài quánmiàn, chuāntòu jīngzhǔn, xiǎngyìng xùnsù de hóngguān shěnshèn jīnróng jiānguǎn kuàngjià.',
        meaning_vi: 'Nhằm phòng ngừa và hóa giải rủi ro hệ thống tài chính, các cơ quan giám sát đang khẩn trương thiết lập khung giám sát tài chính cẩn trọng vĩ mô có độ bao phủ toàn diện, khả năng xuyên thấu chính xác và phản ứng nhanh nhạy.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 2576,
    hanzi: '键盘',
    pinyin: 'jiànpán',
    word_type: 'Danh từ',
    meaning_vi: 'bàn phím (máy tính, nhạc cụ)',
    examples: [
      {
        chinese: '程序员每天长时间使用键盘敲代码，最好选用符合人体工学设计的机械键盘。',
        pinyin: 'Chéngxùyuán měi tiān cháng shíjiān shǐyòng jiànpán qiāo dàimǎ, zuìhǎo xuǎnyòng fúhé réntǐ gōngxué shèjì de jīxiè jiànpán.',
        meaning_vi: 'Lập trình viên mỗi ngày gõ code trong thời gian dài trên bàn phím, tốt nhất nên lựa chọn bàn phím cơ được thiết kế theo công thái học.',
        difficulty_level: 'basic'
      },
      {
        chinese: '随着无障碍信息技术的发展，支持盲文触觉反馈与眼球追踪的智能虚拟键盘为视障及残障人士顺畅使用数字设备带来了极大便利。',
        pinyin: 'Suízhe wúzhàng’ài xìnxī jìshù de fāzhǎn, zhīchí mángwén chùjué fǎnduì yǔ yǎnqiú zhuīzōng de zhìnéng xūnǐ jiànpán wèi shìzhàng jí cánzhàng rénshì shùnchàng shǐyòng shùzì shèbèi dàilái le jídà biànlì.',
        meaning_vi: 'Cùng với sự phát triển của công nghệ thông tin không rào cản, bàn phím ảo thông minh hỗ trợ xúc giác phản hồi chữ nổi Braille và theo dõi ánh mắt đã mang lại sự thuận tiện to lớn cho người khiếm thị và người khuyết tật khi tiếp cận các thiết bị số.',
        difficulty_level: 'applied'
      }
    ]
  }
]
