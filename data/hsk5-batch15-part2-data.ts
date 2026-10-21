// data/hsk5-batch15-part2-data.ts
// 25 từ HSK 5: #3427 [预约] -> #3451 [早晚]

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

export const HSK5_BATCH15_PART2: VocabItem[] = [
  {
    id: 3427,
    hanzi: '预约',
    pinyin: 'yùyuē',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'hẹn trước, đặt lịch hẹn, đặt chỗ trước',
    examples: [
      {
        chinese: '如果你打算去那家三甲医院看专科门诊，一定要提前在手机应用程序上进行挂号预约。',
        pinyin: 'Rúguǒ nǐ dǎsuàn qù nà jiā sānjiǎ yīyuàn kàn zhuānkē ménzhěn, yídìng yào tíqián zài shǒujī yìngyòng chéngxù shang jìnxíng guàhào yùyuē.',
        meaning_vi: 'Nếu bạn có ý định đến bệnh viện hạng ba tuyến đầu đó khám chuyên khoa, nhất định phải đặt lịch hẹn đăng ký khám trước trên ứng dụng điện thoại di động.',
        difficulty_level: 'basic'
      },
      {
        chinese: '高端商务会所全面推行实名制高端私密专享预约制度，以确保为跨国企业高管提供安全且高效的洽谈环境。',
        pinyin: 'Gāoduān shāngwù huìsuǒ quánmiàn tuīxíng shímíngzhì gāoduān sīmì zhuānxiǎng yùyuē zhìdù, yǐ quèbǎo wèi kuàguó qǐyè gāoguǎn tígōng ānquán qiě gāoxiào de qiàtán huánjìng.',
        meaning_vi: 'Câu lạc bộ thương mại cao cấp triển khai toàn diện chế độ đặt lịch hẹn riêng tư bảo mật danh tính định danh, nhằm bảo đảm cung cấp môi trường đàm phán an toàn và hiệu quả cao cho các nhà quản lý cấp cao của doanh nghiệp đa quốc gia.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3428,
    hanzi: '原',
    pinyin: 'yuán',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'nguyên bản, ban đầu, gốc; bình nguyên',
    examples: [
      {
        chinese: '由于项目需求发生了紧急变更，我们不得不废弃上个月制定的原设计方案。',
        pinyin: 'Yóuyú xiàngmù xūqiú fāshēng le jǐnjí biàngēng, wǒmen bùdébù fèiqì shàng ge yuè zhìdìng de yuán shèjì fāng\'àn.',
        meaning_vi: 'Do nhu cầu dự án phát sinh thay đổi khẩn cấp, chúng tôi buộc phải hủy bỏ phương án thiết kế ban đầu đã xây dựng từ tháng trước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '分子遗传学实验证实，该稀有植物种群保留了大量未经人工杂交的野生原生态优良基因组特征。',
        pinyin: 'Fēnzǐ yíchuánxué shíyàn zhèngshí, gāi xīyǒu zhíwù zhǒngqún bǎoliú le dàliàng wèijīng réngōng zájiāo de yěshēng yuán-shēngtài yōuliáng jīyīnzǔ tèzhēng.',
        meaning_vi: 'Thí nghiệm di truyền học phân tử đã xác nhận rằng quần thể thực vật quý hiếm này vẫn lưu giữ một lượng lớn đặc trưng bộ gen ưu lương nguyên sinh thái hoang dã chưa từng trải qua lai tạo nhân tạo.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3429,
    hanzi: '圆',
    pinyin: 'yuán',
    word_type: 'Tính từ / Danh từ',
    meaning_vi: 'tròn, hình tròn, trọn vẹn, viên mãn',
    examples: [
      {
        chinese: '中秋节的夜晚，一家人围坐在院子里一边欣赏皎洁的圆月，一边品尝美味的月饼。',
        pinyin: 'Zhōngqiūjié de yèwǎn, yìjiārén wéizuò zài yuànzi lǐ yìbiān xīnshǎng jiǎojié de yuányuè, yìbiān pǐncháng měiwèi de yuèbǐng.',
        meaning_vi: 'Đêm Tết Trung thu, cả gia đình quây quần ngồi trong sân vừa ngắm vầng trăng tròn vằng vặc vừa thưởng thức bánh trung thu thơm ngon.',
        difficulty_level: 'basic'
      },
      {
        chinese: '经过长达三轮艰难的跨国商务谈判，双方代表终于就关键条款达成共识，使合作项目画上了圆满的句号。',
        pinyin: 'Jīngguò chángdá sān lún jiānnán de kuàguó shāngwù tánpàn, shuāngfāng dàibiǎo zhōngyú jiù guānjiàn tiáokuǎn dáchéng gòngshí, shǐ hézuò xiàngmù huà shàng le yuánmǎn de jùhào.',
        meaning_vi: 'Trải qua ba vòng đàm phán thương mại xuyên quốc gia kéo dài và gian nan, đại diện hai bên rốt cuộc đã đạt được đồng thuận về các điều khoản then chốt, đặt dấu chấm hết trọn vẹn viên mãn cho dự án hợp tác.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3430,
    hanzi: '原有',
    pinyin: 'yuányǒu',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'vốn có, sẵn có, nguyên có',
    examples: [
      {
        chinese: '为了满足广大市民的休闲运动需求，市政部门决定在原有公园绿地的基础上扩建跑道。',
        pinyin: 'Wèile mǎnzú guǎngdà shìmín de xiūxián yùndòng xūqiú, shìzhèng bùmén juédìng zài yuányǒu gōngyuán lǜdì de jīchǔ shang kuòjiàn pǎodào.',
        meaning_vi: 'Để đáp ứng nhu cầu tập luyện thể thao giải trí của đông đảo người dân, cơ quan quản lý đô thị đã quyết định mở rộng đường chạy trên cơ sở mảng xanh công viên vốn có.',
        difficulty_level: 'basic'
      },
      {
        chinese: '产业数字化转型不是彻底推翻原有实体工业体系，而是通过新一代信息技术对其进行全方位重塑与赋能。',
        pinyin: 'Chǎnyè shùzìhuà zhuǎnxíng bú shì chèdǐ tuīfān yuányǒu shítǐ gōngyè tǐxì, ér shì tōngguò xīn-yídài xìnxī jìshù duì qí jìnxíng quán-fāngwèi chóngsù yǔ fùnéng.',
        meaning_vi: 'Chuyển đổi số công nghiệp không phải là lật đổ hoàn toàn hệ thống công nghiệp thực thể vốn có, mà là thông qua công nghệ thông tin thế hệ mới để tái định hình và tiếp thêm sức mạnh toàn diện cho hệ thống đó.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3431,
    hanzi: '元旦',
    pinyin: 'Yuándàn',
    word_type: 'Danh từ',
    meaning_vi: 'Tết Dương lịch, ngày đầu năm mới',
    examples: [
      {
        chinese: '元旦假期的第一天早晨，大街小巷都挂满了鲜艳的红旗和漂亮的彩灯，洋溢着节日的喜庆气氛。',
        pinyin: 'Yuándàn jiàqī de dì-yī tiān zǎochén, dàjiē-xiǎoxiàng dōu guà mǎn le xiānyàn de hóngqí hé piàoliang de cǎidēng, yángyì zhe jiérì de xǐqìng qìfēn.',
        meaning_vi: 'Sáng ngày đầu tiên của kỳ nghỉ Tết Dương lịch, khắp phố lớn ngõ nhỏ đều treo đầy cờ đỏ rực rỡ và đèn lồng hoa lệ, ngập tràn bầu không khí hân hoan của ngày lễ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国家统计局公布的元旦假期消费监测数据显示，文旅演艺、主题餐饮与冰雪旅游等文旅板块呈现强劲复苏势头。',
        pinyin: 'Guójiā tǒngjìjú gōngbù de Yuándàn jiàqī xiāofèi jiāncè shùjù xiǎnshì, wénlǚ yǎnyì, zhǔtí cānyǐn yǔ bīngxuě lǚyóu děng wénlǚ bǎnkuài chéngxiàn qiángjìn fùsū shìtóu.',
        meaning_vi: 'Số liệu giám sát tiêu dùng kỳ nghỉ Tết Dương lịch do Cục Thống kê Quốc gia công bố cho thấy các phân khúc văn hóa du lịch như biểu diễn nghệ thuật, ẩm thực chủ đề và du lịch băng tuyết thể hiện đà phục hồi mạnh mẽ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3432,
    hanzi: '员工',
    pinyin: 'yuángōng',
    word_type: 'Danh từ',
    meaning_vi: 'nhân viên, cán bộ công nhân viên',
    examples: [
      {
        chinese: '为了激发全体员工的工作积极性，公司管理层决定在年底设立优秀员工特别表彰奖项。',
        pinyin: 'Wèile jīfā quántǐ yuángōng de gōngzuò jījíxìng, gōngsī guǎnlǐcéng juédìng zài niándǐ shèlì yōuxiù yuángōng tèbié biǎozhāng jiǎngxiàng.',
        meaning_vi: 'Để khơi dậy tính tích cực làm việc của toàn thể nhân viên, ban lãnh đạo công ty đã quyết định thiết lập giải thưởng biểu dương đặc biệt dành cho nhân viên xuất sắc vào cuối năm.',
        difficulty_level: 'basic'
      },
      {
        chinese: '集团人力资源战略委员会建立了覆盖员工全职业生涯发展周期的技能培训与敏捷晋升双通道评估机制。',
        pinyin: 'Jítuán rénlì zīyuán zhànlüè wěiyuánhuì jiànlì le fùgài yuángōng quán zhíyè shēngyá fāzhǎn zhōuqī de jìnéng péixùn yǔ mǐnjié jìnshēng shuāng-tōngdào pínggū jīzhì.',
        meaning_vi: 'Hội đồng chiến lược nhân sự của tập đoàn đã thiết lập cơ chế đánh giá song lộ trình thăng tiến linh hoạt và đào tạo kỹ năng bao phủ toàn bộ vòng đời phát triển sự nghiệp của nhân viên.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3433,
    hanzi: '原则',
    pinyin: 'yuánzé',
    word_type: 'Danh từ',
    meaning_vi: 'nguyên tắc',
    examples: [
      {
        chinese: '无论在职场中遇到多么棘手的人际关系冲突，我们都要坚持实事求是的基本做人原则。',
        pinyin: 'Wúlùn zài zhíchǎng zhōng yù dào duōme jíshǒu de rénjì guānxì chōngtū, wǒmen dōu yào jiānchí shíshì-qiúshì de jīběn zuòrén yuánzé.',
        meaning_vi: 'Bất luận gặp phải xung đột quan hệ nhân sinh gai góc đến mức nào ở nơi làm việc, chúng ta đều phải kiên trì nguyên tắc làm người cơ bản là cầu thị, tôn trọng sự thật.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业必须严格遵循透明合规、数据最小化以及用户知情同意的法定原则，防范人工智能算法歧视与隐私泄露风险。',
        pinyin: 'Qǐyè bìxū yángé zūnxún tòumíng hégūi, shùjù zuìxiǎohuà yǐjí yònghù zhīqíng tóngyì de fǎdìng yuánzé, fángfàn réngōng zhìnéng suànfǎ qíshì yǔ yǐnsī xièlòu fēngxiǎn.',
        meaning_vi: 'Doanh nghiệp bắt buộc phải tuân thủ nghiêm ngặt các nguyên tắc pháp định về minh bạch tuân thủ, tối thiểu hóa dữ liệu và sự đồng ý sau khi được thông báo của người dùng, phòng ngừa rủi ro phân biệt đối xử thuật toán AI và rò rỉ quyền riêng tư.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3434,
    hanzi: '愿',
    pinyin: 'yuàn',
    word_type: 'Động từ',
    meaning_vi: 'nguyện, mong muốn, sẵn lòng',
    examples: [
      {
        chinese: '毕业离别之际，同学们在纪念册上写下最真挚的祝福：愿你历经千帆，归来仍是少年。',
        pinyin: 'Bìyè líbié zhī jì, tóngxuémen zài jìniàncè shang xiě xià zuì zhēnzhì de zhùfú: Yuàn nǐ lì jīng qiān fān, guīlái réng shì shàonián.',
        meaning_vi: 'Thời khắc chia tay tốt nghiệp, các bạn học cùng viết lại lời chúc chân thành nhất trên lưu bút: Nguyện chúc bạn trải qua muôn vàn cánh buồm sóng gió, khi trở về vẫn giữ trọn nét trẻ trung nhiệt huyết ngày nào.',
        difficulty_level: 'basic'
      },
      {
        chinese: '只要双方具备互利共赢的诚意，我方愿与贵国科研机构在深海勘探与绿色低碳能源领域开展全方位务实合作。',
        pinyin: 'Zhǐyào shuāngfāng jùbèi hùlì gòngyíng de chéngyì, wǒfāng yuàn yǔ guìguó kēyán jīgòu zài shēnhǎi kāntàn yǔ lǜsè dītàn néngyuán lǐngyù kāizhǎn quán-fāngwèi wùshí hézuò.',
        meaning_vi: 'Chỉ cần hai bên có thiện chí đôi bên cùng có lợi, phía chúng tôi sẵn lòng triển khai hợp tác thực chất toàn diện với cơ quan nghiên cứu khoa học của quý quốc trong các lĩnh vực thăm dò biển sâu và năng lượng carbon thấp xanh.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3435,
    hanzi: '愿望',
    pinyin: 'yuànwàng',
    word_type: 'Danh từ',
    meaning_vi: 'nguyện vọng, ước mơ, mong ước',
    examples: [
      {
        chinese: '经过连续三年的勤奋备考，他终于实现了考入理想重点大学计算机科学系的强烈愿望。',
        pinyin: 'Jīngguò liánxù sān nián de qínfèn bèikǎo, tā zhōngyú shíxiàn le kǎorù lǐxiǎng zhòngdiǎn dàxué jìsuànjī kēxué xì de qiángliè yuànwàng.',
        meaning_vi: 'Trải qua ba năm liên tục ôn thi cần cù, anh ấy cuối cùng đã thực hiện được nguyện vọng cháy bỏng là đỗ vào khoa khoa học máy tính của trường đại học trọng điểm mơ ước.',
        difficulty_level: 'basic'
      },
      {
        chinese: '消除贫困并实现社会公平正义，是人类自古以来追求美好和平生活的共同崇高愿望。',
        pinyin: 'Xiāochú pínkùn bìng shíxiàn shèhuì gōngpíng zhèngyì, shì rénlèi zìgǔ yǐlái zhuīqiú měihǎo hépíng shēnghuó de gòngtóng chónggāo yuànwàng.',
        meaning_vi: 'Xóa bỏ đói nghèo và hiện thực hóa công bằng chính trực xã hội là nguyện vọng cao cả chung của nhân loại từ xưa đến nay trong hành trình mưu cầu cuộc sống hòa bình tươi đẹp.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3436,
    hanzi: '约定',
    pinyin: 'yuēdìng',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'hẹn ước, quy ước, thỏa thuận',
    examples: [
      {
        chinese: '我和几位大学老同学约定好，每个周六下午都在市中心的体育馆一起打羽毛球健身。',
        pinyin: 'Wǒ hé jǐ wèi dàxué lǎo tóngxué yuēdìng hǎo, měi ge zhōuliù xiàwǔ dōu zài shìzhōngxīn de tǐyùguǎn yìqǐ dǎ yǔmáoqiú jiànshēn.',
        meaning_vi: 'Tôi và mấy người bạn đại học cũ đã thỏa thuận hẹn nhau, mỗi chiều thứ Bảy đều đến nhà thi đấu ở trung tâm thành phố để cùng chơi cầu lông rèn luyện sức khỏe.',
        difficulty_level: 'basic'
      },
      {
        chinese: '合同双方未就知识产权归属作出明确约定的，受托人交付的研发成果知识产权依法推定归受托方所有。',
        pinyin: 'Hétong shuāngfāng wèi jiù zhīshi chǎnquán guīshǔ zuòchū míngquè yuēdìng de, shòutuōrén jiāofù de yánfā chéngguǒ zhīshi chǎnquán yīfǎ tuīdìng guī shòutuōfāng suǒyǒu.',
        meaning_vi: 'Trường hợp các bên trong hợp đồng không đưa ra thỏa thuận rõ ràng về quyền sở hữu quyền sở hữu trí tuệ, quyền sở hữu trí tuệ đối với thành quả nghiên cứu phát triển do bên nhận ủy thác bàn giao được suy đoán theo pháp luật là thuộc về bên nhận ủy thác.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3437,
    hanzi: '运',
    pinyin: 'yùn',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'vận chuyển, vận hành; vận may, thời vận',
    examples: [
      {
        chinese: '工人们正在码头上忙碌地将成箱的新鲜热带水果从大型货船上卸下并运往冷链仓库。',
        pinyin: 'Gōngrénmen zhèngzài mǎtou shang mánglù de jiāng chéng xiāng de xīnxiān rèdài shuǐguǒ cóng dàxíng huòchuán shang xiè xià bìng yùn wǎng lěngliàn cāngkù.',
        meaning_vi: 'Các công nhân đang tất bật bốc dỡ từng thùng hoa quả nhiệt đới tươi ngon từ tàu chở hàng cỡ lớn xuống bến cảng và vận chuyển vào kho chuỗi cung ứng lạnh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '跨国供应链的核心竞争力不仅在于能否将物资安全运达目的地，更在于如何通过数字化算法精准调配全球多式联运资源。',
        pinyin: 'Kuàguó gōngyìngliàn de héxīn jìngzhēnglì bù jǐn zàiyú néng fǒu jiāng wùzī ānquán yùn dá mùdìdì, gèng zàiyú rúhé tōngguò shùzìhuà suànfǎ jīngzhǔn diàopèi quánqiú duō-shì-liányùn zīyuán.',
        meaning_vi: 'Năng lực cạnh tranh cốt lõi của chuỗi cung ứng xuyên quốc gia không chỉ nằm ở việc có thể vận chuyển hàng hóa an toàn tới điểm đến hay không, mà quan trọng hơn là làm thế nào điều phối chuẩn xác các nguồn lực vận tải đa phương thức toàn cầu thông qua thuật toán số hóa.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3438,
    hanzi: '运费',
    pinyin: 'yùnfèi',
    word_type: 'Danh từ',
    meaning_vi: 'cước vận chuyển, phí vận chuyển',
    examples: [
      {
        chinese: '这家电商平台正在举行年终促销活动，只要订单总额满九十九元就可以免除全部国内运费。',
        pinyin: 'Zhè jiā diànshāng píngtái zhèngzài jǔxíng niánzhōng cùxiāo huódòng, zhǐyào dìngdān zǒng\'é mǎn jiǔshíjiǔ yuán jiù kěyǐ miǎnchú quánbù guónèi yùnfèi.',
        meaning_vi: 'Sàn thương mại điện tử này đang tổ chức đợt khuyến mãi cuối năm, chỉ cần tổng giá trị đơn hàng đạt từ 99 tệ trở lên là có thể được miễn toàn bộ phí vận chuyển nội địa.',
        difficulty_level: 'basic'
      },
      {
        chinese: '国际航运燃油附加费的大幅上涨直接推高了跨境集装箱的海运运费成本，对制造出口企业的利润空间造成了明显挤压。',
        pinyin: 'Guójì hángyùn rányóu fùjiāfèi de dàfú shàngzhǎng zhíjiē tuīgāo le kuàjìng jízhuāngxiāng de hǎiyùn yùnfèi chéngběn, duì zhìzào chūkǒu qǐyè de lìrùn kōngjiān zàochéng le míngxiǎn jǐyā.',
        meaning_vi: 'Việc phụ phí nhiên liệu vận tải biển quốc tế tăng vọt đã trực tiếp đẩy chi phí cước vận chuyển đường biển container xuyên biên giới lên cao, gây sức ép rõ rệt lên biên độ lợi nhuận của các doanh nghiệp sản xuất xuất khẩu.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3439,
    hanzi: '运气',
    pinyin: 'yùnqi',
    word_type: 'Danh từ',
    meaning_vi: 'vận may, số may, vận khí',
    examples: [
      {
        chinese: '他今天在超市抽奖活动中幸运地抽中了一等奖，大家都羡慕他的好运气。',
        pinyin: 'Tā jīntiān zài chāoshì chōujiǎng huódòng zhōng xìngyùn de chōu zhòng le yīděngjiǎng, dàjiā dōu xiànmù tā de hǎo yùnqi.',
        meaning_vi: 'Hôm nay trong hoạt động bốc thăm trúng thưởng ở siêu thị anh ấy may mắn trúng giải nhất, mọi người đều ngưỡng mộ vận may lớn của anh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '创业者的商业成功固然离不开时代赋予的发展机遇与运气，但起决定性作用的始终是长期的战略定力与坚韧执行力。',
        pinyin: 'Chuàngyèzhě de shāngyè chénggōng gùrán lí bù kāi shídài fùyǔ de fāzhǎn jīyù yǔ yùnqi, dàn qǐ juédìngxìng zuòyòng de shǐzhōng shì chángqī de zhànlüè dìnglì yǔ jiānrèn zhíxínglì.',
        meaning_vi: 'Sự thành công trong kinh doanh của người khởi nghiệp tuy không thể tách rời thời cơ phát triển và vận may mà thời đại ban tặng, nhưng đóng vai trò mang tính quyết định vẫn luôn là định lực chiến lược dài hạn và năng lực thực thi bền bỉ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3440,
    hanzi: '运输',
    pinyin: 'yùnshū',
    word_type: 'Động từ / Danh từ',
    meaning_vi: 'vận tải, chuyên chở, vận chuyển',
    examples: [
      {
        chinese: '铁路部门在春运期间增开了多趟临时旅客列车，全力保障广大返乡旅客的安全运输。',
        pinyin: 'Tiělù bùmén zài chūnyùn qījiān zēngkāi le duō tàng línshí lǚkè lièchē, quánlì bǎozhàng guǎngdà fǎnxiāng lǚkè de ānquán yùnshū.',
        meaning_vi: 'Ngành đường sắt đã tăng cường thêm nhiều chuyến tàu khách tạm thời trong dịp cao điểm Tết, dốc toàn lực bảo đảm việc vận chuyển an toàn cho đông đảo hành khách về quê.',
        difficulty_level: 'basic'
      },
      {
        chinese: '液化天然气超低温专用运输船的核心绝热保温围护系统建造难度极高，代表着现代造船工业的顶尖工艺技术水准。',
        pinyin: 'Yèhuà tiānránqì chāo-dīwēn zhuānyòng yùnshūchuán de héxīn juérè bǎowēn wéihù xìtǒng jiànzào nándù jí gāo, dàibiǎo zhe xiàndài zàochuán gōngyè de dǐngjiān gōngyì jìshù shuǐzhǔn.',
        meaning_vi: 'Hệ thống bao che cách nhiệt giữ ấm cốt lõi của tàu chuyên dụng vận chuyển khí thiên nhiên hóa lỏng nhiệt độ siêu thấp có độ khó thi công cực cao, đại diện cho trình độ công nghệ kỹ thuật đỉnh cao của nền công nghiệp đóng tàu hiện đại.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3441,
    hanzi: '运用',
    pinyin: 'yùnyòng',
    word_type: 'Động từ',
    meaning_vi: 'vận dụng, áp dụng, sử dụng',
    examples: [
      {
        chinese: '学完这些基本的语法知识之后，同学们应该多加练习，熟练运用到日常口语交流当中。',
        pinyin: 'Xué wán zhèxiē jīběn de yǔfǎ zhīshi zhīhòu, tóngxuémen yīnggāi duō jiā liànxí, shúliàn yùnyòng dào rìcháng kǒuyǔ jiāoliú dāngzhōng.',
        meaning_vi: 'Sau khi học xong những kiến thức ngữ pháp cơ bản này, các bạn học sinh nên tăng cường luyện tập, vận dụng thành thạo vào giao tiếp khẩu ngữ hằng ngày.',
        difficulty_level: 'basic'
      },
      {
        chinese: '宏观经济决策智库综合运用计量经济模型与大数据因果推断方法，对未来产业政策的实施效应进行多维情景模拟。',
        pinyin: 'Hóngguān jīngjì juécè zhìkù zōnghé yùnyòng jìliàng jīngjì móxíng yǔ dà-shùjù yīnguǒ tuīduàn fāngfǎ, duì wèilái chǎnyè zhèngcè de shíshī xiàoyìng jìnxíng duō-wéi qíngjǐng mónǐ.',
        meaning_vi: 'Viện nghiên cứu chính sách kinh tế vĩ mô đã vận dụng tổng hợp mô hình kinh tế lượng và phương pháp suy luận nhân quả dữ liệu lớn để tiến hành mô phỏng kịch bản đa chiều về hiệu ứng thực thi chính sách công nghiệp tương lai.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3442,
    hanzi: '在场',
    pinyin: 'zàichǎng',
    word_type: 'Động từ',
    meaning_vi: 'có mặt, hiện diện tại hiện trường/tại chỗ',
    examples: [
      {
        chinese: '当主持人宣布最终的比赛获奖结果时，在场的所有观众和评委都情不自禁地起立鼓掌。',
        pinyin: 'Dāng zhǔchírén xuānbù zuìzhōng de bǐsài huòjiǎng jiéguǒ shí, zàichǎng de suǒyǒu guānzhòng hé píngwěi dōu qíngbùzìjīn de qǐlì gǔzhǎng.',
        meaning_vi: 'Khi người dẫn chương trình công bố kết quả đoạt giải chung cuộc của cuộc thi, tất cả khán giả và ban giám khảo có mặt tại hội trường đều không kìm được đã đứng dậy vỗ tay.',
        difficulty_level: 'basic'
      },
      {
        chinese: '涉及重大公司股权处置的公证法定程序，必须要求双方具备民事行为能力的法定代表人与独立见证律师同时在场签署。',
        pinyin: 'Shèjí zhòngdà gōngsī gǔquán chǔzhì de gōngzhèng fǎdìng chéngxù, bìxū yāoqiú shuāngfāng jùbèi mínshì xíngwéi nénglì de fǎdìng dàibiǎorén yǔ dúlì jiànzhèng lǜshī tóngshí zàichǎng qiānshǔ.',
        meaning_vi: 'Quy trình pháp định công chứng liên quan đến định đoạt cổ phần công ty trọng đại bắt buộc phải yêu cầu đại diện pháp luật có đủ năng lực hành vi dân sự của hai bên cùng luật sư làm chứng độc lập đồng thời có mặt tại chỗ để ký kết.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3443,
    hanzi: '在乎',
    pinyin: 'zàihu',
    word_type: 'Động từ',
    meaning_vi: 'để tâm, bận tâm, coi trọng',
    examples: [
      {
        chinese: '既然你已经为了梦想全力以赴，就不要太在乎个别人的冷言冷语和片面评价。',
        pinyin: 'Jìrán nǐ yǐjīng wèile mèngxiǎng quánlì-yǐfù, jiù bú yào tài zàihu gèbié rén de lěngyán-lěngyǔ hé piànmiàn píngjià.',
        meaning_vi: 'Một khi bạn đã dốc toàn lực vì ước mơ, thì đừng quá bận tâm đến những lời mỉa mai lạnh lùng hay những lời đánh giá phiến diện của vài cá nhân.',
        difficulty_level: 'basic'
      },
      {
        chinese: '优秀的品牌建设战略极其在乎消费者的长期信任与情感共鸣，绝不会为追求短期眼前暴利而牺牲核心产品质量底线。',
        pinyin: 'Yōuxiù de pǐnpái jiànshè zhànlüè jíqí zàihu xiāofèizhě de chángqī xìnrèn yǔ qínggǎn gòngmíng, jué bú huì wèi zhuīqiú duǎnqī yǎnqián bàolì ér xīshēng héxīn chǎnpǐn zhìliàng dǐxiàn.',
        meaning_vi: 'Chiến lược xây dựng thương hiệu xuất sắc cực kỳ coi trọng sự tin tưởng dài hạn và sự đồng cảm cảm xúc của người tiêu dùng, tuyệt đối không vì mưu cầu món siêu lợi nhuận ngắn hạn trước mắt mà hy sinh ranh giới đáy về chất lượng sản phẩm cốt lõi.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3444,
    hanzi: '在内',
    pinyin: 'zàinèi',
    word_type: 'Cụm từ / Giới từ',
    meaning_vi: 'bao gồm bên trong, tính cả, kể cả',
    examples: [
      {
        chinese: '这次户外徒步登山活动的全部费用，包括往返旅游巴士车票与午餐在内，每人一共需要交纳一百五十元。',
        pinyin: 'Zhè cì hùwài túbù dēngshān huódòng de quánbù fèiyong, bāokuò wǎngfǎn lǚyóu bāshì chēpiào yǔ wǔcān zàinèi, měi rén yígòng xūyào jiāonà yībǎi wǔshí yuán.',
        meaning_vi: 'Toàn bộ chi phí của hoạt động đi bộ leo núi ngoài trời lần này, bao gồm cả vé xe buýt du lịch khứ hồi và bữa trưa bên trong, mỗi người cần nộp tổng cộng 150 tệ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '世界贸易组织多边贸易协定框架要求各成员国全面履行关税减让承诺，将工业制造品与大宗农产品在内的上千种品类纳入平等待遇清单。',
        pinyin: 'Shìjiè Màoyì Zǔzhī duōbiān màoyì xiédìng kuàngjià yāoqiú gè chéngyuánguó quánmiàn lǚxíng guānshuì jiǎnràng chéngnuò, jiāng gōngyè zhìzàopǐn yǔ dàzōng nóngchǎnpǐn zàinèi de shàng qiān zhǒng pǐnlèi nàrù píngděng dàiyù qīngdān.',
        meaning_vi: 'Khung hiệp định thương mại đa phương của Tổ chức Thương mại Thế giới yêu cầu các quốc gia thành viên thực hiện toàn diện cam kết cắt giảm thuế quan, đưa hàng nghìn chủng loại hàng hóa kể cả sản phẩm công nghiệp chế tạo và nông sản số lượng lớn vào danh mục đãi ngộ bình đẳng.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3445,
    hanzi: '在线',
    pinyin: 'zàixiàn',
    word_type: 'Tính từ / Động từ',
    meaning_vi: 'trực tuyến, online',
    examples: [
      {
        chinese: '你如果对这款新手机的功能有任何疑问，可以随时联系全天二十四小时在线的官方客服人员。',
        pinyin: 'Nǐ rúguǒ duì zhè kuǎn xīn shǒujī de gōngnéng yǒu rènhé yíwèn, kěyǐ suíshí liánxì quántiān èrshísì xiǎoshí zàixiàn de guānfāng kèfù rényuán.',
        meaning_vi: 'Nếu bạn có bất kỳ thắc mắc nào về tính năng của chiếc điện thoại di động mới này, bạn có thể liên hệ bất cứ lúc nào với nhân viên chăm sóc khách hàng chính thức trực tuyến 24/7.',
        difficulty_level: 'basic'
      },
      {
        chinese: '金融云服务架构通过多中心双活集群部署与毫秒级容灾切换机制，保障了海量并发在线支付系统的高可用性与业务连续性。',
        pinyin: 'Jīnróng yún-fúwù jiàgòu tōngguò duō-zhōngxīn shuānghuó jíqún bùshǔ yǔ háomiǎojí róngzāi qiēhuàn jīzhì, bǎozhàng le hǎiliàng bīngfā zàixiàn zhīfù xìtǒng de gāo kěyòngxìng yǔ yèwù liánxùxìng.',
        meaning_vi: 'Kiến trúc dịch vụ đám mây tài chính thông qua việc triển khai cụm song hoạt đa trung tâm cùng cơ chế chuyển đổi dự phòng thảm họa cấp mili giây, đã bảo đảm tính sẵn sàng cao và tính liên tục nghiệp vụ cho hệ thống thanh toán trực tuyến đồng thời dung lượng lớn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3446,
    hanzi: '在于',
    pinyin: 'zàiyú',
    word_type: 'Động từ',
    meaning_vi: 'cốt ở, nằm ở, do ở',
    examples: [
      {
        chinese: '读书的真正意义不仅在于获取应付考试的分数，更在于开阔个人的视野与涵养高尚的情操。',
        pinyin: 'Dúshū de zhēnzhèng yìyì bù jǐn zàiyú huòqǔ yìngfu kǎoshì de fēnshù, gèng zàiyú kāikuò gèrén de shìyě yǔ hányǎng gāoshàng de qíngcāo.',
        meaning_vi: 'Ý nghĩa chân chính của việc đọc sách không chỉ nằm ở việc đạt điểm số để ứng phó thi cử, mà quan trọng hơn là cốt ở việc mở rộng tầm nhìn cá nhân và bồi đắp tư tưởng tình cảm cao đẹp.',
        difficulty_level: 'basic'
      },
      {
        chinese: '企业技术创新战略的成败核心在于能否突破基础科学核心原理，并将其敏捷转化为具备全球市场定价权的自主终端产品。',
        pinyin: 'Qǐyè jìshù chuàngxīn zhànlüè de chéngbài héxīn zàiyú néng fǒu tūpò jīchǔ kēxué héxīn yuánlǐ, bìng jiāng qí mǐnjié zhuǎnhuà wéi jùbèi quánqiú shìchǎng dìngjiàquán de zìzhǔ zhōngduān chǎnpǐn.',
        meaning_vi: 'Cốt lõi quyết định sự thành bại trong chiến lược đổi mới công nghệ của doanh nghiệp nằm ở việc liệu có thể bứt phá nguyên lý cốt lõi của khoa học cơ bản và chuyển đổi linh hoạt thành sản phẩm đầu cuối tự chủ có quyền định giá trên thị trường toàn cầu hay không.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3447,
    hanzi: '赞成',
    pinyin: 'zànchéng',
    word_type: 'Động từ',
    meaning_vi: 'tán thành, đồng ý, ủng hộ',
    examples: [
      {
        chinese: '在今天下午召开的班级全体会议上，大多数同学都举手赞成周末去郊外森林公园举行野餐活动。',
        pinyin: 'Zài jīntiān xiàwǔ zhàokāi de bānjí quántǐ huìyì shang, dàduōshù tóngxué dōu jǔshǒu zànchéng zhōumò qù jiāowài sēnlín gōngyuán jǔxíng yěcān huódòng.',
        meaning_vi: 'Trong cuộc họp toàn thể lớp học triệu tập chiều nay, đa số các bạn học đều giơ tay tán thành việc cuối tuần đi công viên rừng ngoại ô tổ chức buổi dã ngoại.',
        difficulty_level: 'basic'
      },
      {
        chinese: '公司董事会以全体赞成的表决结果审议通过了对高新技术研发中心追加两亿元资本性投入的专项议案。',
        pinyin: 'Gōngsī dǒngshìhuì yǐ quántǐ zànchéng de biǎojué jiéguǒ shěnyì tōngguò le duì gāoxīn-jìshù yánfā zhōngxīn zhuījiā liǎng yì yuán zīběnxìng tóurù de zhuānxiàng yì\'àn.',
        meaning_vi: 'Hội đồng quản trị công ty với kết quả biểu quyết 100% tán thành đã thẩm nghị thông qua nghị quyết chuyên đề về việc rót thêm hai trăm triệu nhân dân tệ đầu tư mang tính vốn hóa cho trung tâm nghiên cứu phát triển công nghệ cao.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3448,
    hanzi: '糟',
    pinyin: 'zāo',
    word_type: 'Tính từ',
    meaning_vi: 'hỏng, tồi tệ, nát bét; ôi thiu',
    examples: [
      {
        chinese: '出门时我突然发现天空中下起了倾盆大雨，而自己却忘记带雨伞，情况真是不巧又很糟。',
        pinyin: 'Chūmén shí wǒ tūrán fāxiàn tiānkōng zhōng xià qǐ le qīngpén dàyǔ, ér zìjǐ què wàngjì dài yǔsǎn, qíngkuàng zhēn shì bùqiǎo yòu hěn zāo.',
        meaning_vi: 'Lúc bước ra khỏi cửa tôi chợt phát hiện trời đổ cơn mưa như trút nước, mà bản thân lại quên mang theo ô dù, tình huống thật chẳng khéo mà lại quá tồi tệ.',
        difficulty_level: 'basic'
      },
      {
        chinese: '在极端复杂的多方博弈谈判局势下，决策团队即便面对最糟的市场预期与制裁冲击，也必须制定周密的底线应急预案。',
        pinyin: 'Zài jíduān fùzá de duōfāng bóyì tánpàn júshì xià, juécè tuánduì jíbiàn miànduì zuì zāo de shìchǎng yùqī yǔ zhìcái chōngjī, yě bìxū zhìdìng zhōumì de dǐxiàn yīngjí yù\'àn.',
        meaning_vi: 'Dưới cục diện đàm phán cờ bạc chiến lược đa bên cực kỳ phức tạp, đội ngũ ra quyết định dẫu phải đối mặt với dự báo thị trường tồi tệ nhất cùng cú sốc cấm vận trừng phạt, vẫn bắt buộc phải lập sẵn phương án ứng phó khẩn cấp ranh giới đỏ chu toàn.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3449,
    hanzi: '糟糕',
    pinyin: 'zāogāo',
    word_type: 'Tính từ',
    meaning_vi: 'gay go, tồi tệ, hỏng bét',
    examples: [
      {
        chinese: '太糟糕了！我刚才由于匆忙下出租车，不小心将装有身份证与重要护照的文件包落在了后座上。',
        pinyin: 'Tài zāogāo le! Wǒ gāngcái yóuyú cōngmáng xià chūzūchē, bù xiǎoxīn jiāng zhuāng yǒu shēnfènzhèng yǔ zhòngyào hùzhào de wénjiànbāo là zài le hòuzuò shang.',
        meaning_vi: 'Gay go quá rồi! Vừa nãy do vội vã bước xuống xe taxi, tôi sơ ý để quên chiếc túi tài liệu đựng thẻ căn cước và hộ chiếu quan trọng ở ghế sau.',
        difficulty_level: 'basic'
      },
      {
        chinese: '供应链突发中断叠加原材料价格剧烈震荡，使得该制造业龙头企业遭遇了近十年来最糟糕的单季度盈利衰退。',
        pinyin: 'Gōngyìngliàn tūfā zhōngduàn diéjiā yuáncáiliào jiàgé jùliè zhèndàng, shǐde gāi zhìzàoyè lóngtóu qǐyè zāoyù le jìn shí nián lái zuì zāogāo de dān jìdù yínglì shuāituì.',
        meaning_vi: 'Sự cố đứt gãy bất ngờ của chuỗi cung ứng cộng hưởng với biến động dữ dội của giá nguyên vật liệu thô đã khiến doanh nghiệp đầu ngành chế tạo này hứng chịu đợt suy thoái lợi nhuận quý tồi tệ nhất trong gần một thập kỷ qua.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3450,
    hanzi: '早期',
    pinyin: 'zǎoqī',
    word_type: 'Danh từ',
    meaning_vi: 'thời kỳ đầu, giai đoạn đầu',
    examples: [
      {
        chinese: '医生再三叮嘱大家，绝大多数慢性疾病在早期阶段如果能够做到早发现、早干预，康复的概率就会大大提高。',
        pinyin: 'Yīshēng zàisān dīngzhǔ dàjiā, jué dàduōshù mànxìng jíbìng zài zǎoqī jiēduàn rúguǒ nénggòu zuò dào zǎo fāxiàn, zǎo gānyù, kāngfù de gàilǜ jiù huì dàdà tígāo.',
        meaning_vi: 'Bác sĩ dặn dò mọi người hết lần này đến lần khác, tuyệt đại đa số các bệnh mãn tính trong giai đoạn đầu nếu phát hiện sớm, can thiệp sớm thì xác suất hồi phục sẽ tăng lên rất nhiều.',
        difficulty_level: 'basic'
      },
      {
        chinese: '创业投资基金主要聚焦于硬科技领域的早期初创企业，为处于技术孵化阶段的科研成果转化提供至关重要的耐性资本支持。',
        pinyin: 'Chuàngyè tóuzī jījīn zhǔyào jùjiāo yú yìng-kējì lǐngyù de zǎoqī chūchuàng qǐyè, wèi chǔyú jìshù fūhuà jiēduàn de kēyán chéngguǒ zhuǎnhuà tígōng zhìguān zhòngyào de nàixìng zīběn zhīchí.',
        meaning_vi: 'Quỹ đầu tư mạo hiểm khởi nghiệp chủ yếu tập trung vào các doanh nghiệp khởi nghiệp giai đoạn đầu trong lĩnh vực công nghệ lõi cứng, cung cấp nguồn vốn kiên nhẫn tối quan trọng cho việc chuyển giao thành quả nghiên cứu khoa học đang trong giai đoạn ươm mầm công nghệ.',
        difficulty_level: 'applied'
      }
    ]
  },
  {
    id: 3451,
    hanzi: '早晚',
    pinyin: 'zǎowǎn',
    word_type: 'Danh từ / Phó từ',
    meaning_vi: 'sớm muộn; sáng tối',
    examples: [
      {
        chinese: '现在正值深秋换季时节，早晚温差比较大，大家出门时记得及时添一件保暖外套以防感冒。',
        pinyin: 'Xiànzài zhèng zhí shēnqiū huànjì shíjié, zǎowǎn wēnchā bǐjiào dà, dàjiā chūmén shí jìde jíshí tiān yí jiàn bǎonuǎn wàitào yǐfáng gǎnmào.',
        meaning_vi: 'Hiện nay đang đúng vào dịp chuyển mùa cuối thu, chênh lệch nhiệt độ sáng tối tương đối lớn, mọi người khi ra ngoài hãy nhớ mặc thêm một chiếc áo khoác ấm kịp thời để phòng ngừa cảm lạnh.',
        difficulty_level: 'basic'
      },
      {
        chinese: '不合规且漠视劳动者合法权益的高杠杆粗放扩张商业模式，在日益健全的法治监管和市场理性面前早晚会被彻底淘汰。',
        pinyin: 'Bù hégūi qiě mòshì láodòngzhě héfǎ quányì de gāo-gànggǎn cūfàng kuòzhāng shāngyè móshì, zài rìyì jiànquán de fǎzhì jiānguǎn hé shìchǎng lǐxìng miànqián zǎowǎn huì bèi chèdǐ táotài.',
        meaning_vi: 'Mô hình kinh doanh mở rộng tràn lan bằng đòn bẩy tài chính cao, không tuân thủ quy chuẩn và coi thường quyền lợi hợp pháp của người lao động, trước sự giám sát pháp trị ngày càng hoàn thiện và tính duy lý của thị trường sớm muộn cũng sẽ bị đào thải hoàn toàn.',
        difficulty_level: 'applied'
      }
    ]
  }
]
