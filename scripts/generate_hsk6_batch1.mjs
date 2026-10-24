import fs from 'fs';

function escapeSql(str) {
  if (!str) return "''";
  return `'${str.replace(/'/g, "''")}'`;
}

// 186 từ vựng HSK 6 Đợt 1 (岸 -> 发票) với câu ví dụ chuẩn HSK 6, Pinyin thanh điệu và nghĩa tiếng Việt
const BATCH_1_EXAMPLES = [
  {
    hanzi: '岸',
    example_hanzi: '轮船经过长途航行后，终于平稳地靠在了码头岸边。',
    example_pinyin: 'Lúnchuán jīngguò chángtú hángxíng hòu, zhōngyú píngwěn de kào zài le mǎtóu àn biān.',
    example_vi: 'Tàu thủy sau hành trình dài cuối cùng cũng cập bến bờ một cách êm thuận.'
  },
  {
    hanzi: '按摩',
    example_hanzi: '长时间对着电脑工作后，做一次颈肩按摩能够有效缓解疲劳。',
    example_pinyin: 'Cháng shíjiān duì zhe diànnǎo gōngzuò hòu, zuò yí cì jǐngjiān ànmó nénggòu yǒuxiào huǎnjiě píláo.',
    example_vi: 'Sau thời gian dài làm việc trước máy tính, mát-xa cổ vai gáy có thể xua tan mệt mỏi hiệu quả.'
  },
  {
    hanzi: '昂贵',
    example_hanzi: '尽管进口精密仪器的价格十分昂贵，但实验室仍决定采购两台。',
    example_pinyin: 'Jǐnguǎn jìnkǒu jīngmì yíqì de jiàgé shífēn ángguì, dàn shíyànshì réng juédìng cǎigòu liǎng tái.',
    example_vi: 'Dù giá thiết bị chính xác nhập khẩu rất đắt đỏ, phòng thí nghiệm vẫn quyết định thu mua hai chiếc.'
  },
  {
    hanzi: '案例',
    example_hanzi: '法学教授在课堂上深入剖析了一起典型的知识产权侵权案例。',
    example_pinyin: 'Fǎxué jiàoshòu zài kètáng shang shēnrù pōuxī le yì qǐ diǎnxíng de zhīshi chǎnquán qīnquán ànlì.',
    example_vi: 'Giáo sư luật trên lớp đã phân tích sâu sắc một án lệ điển hình về xâm phạm sở hữu trí tuệ.'
  },
  {
    hanzi: '暗示',
    example_hanzi: '主管通过眼神和委婉的话语，暗示大家会议应当尽快结束。',
    example_pinyin: 'Zhǔguǎn tōngguò yǎnshén hé wěiwǎn de huàyǔ, ànshì dàjiā huìyì yīngdāng jǐnkuài jiéshù.',
    example_vi: 'Chủ quản thông qua ánh mắt và lời lẽ khéo léo để ám chỉ mọi người cuộc họp nên kết thúc sớm.'
  },
  {
    hanzi: '摆',
    example_hanzi: '会议室的长桌上整齐地摆放着参会人员的名牌和会议材料。',
    example_pinyin: 'Huìyìshì de chángzhuō shang zhěngqí de bǎi fàng zhe cānhuì rényuán de míngpái hé huìyì cáiliào.',
    example_vi: 'Trên chiếc bàn dài phòng họp xếp đặt ngay ngắn biển tên và tài liệu hội nghị của người tham dự.'
  },
  {
    hanzi: '拜访',
    example_hanzi: '趁着出差的机会，他特地前去拜访了多年未见的大学导师。',
    example_pinyin: 'Chèn zhe chūchāi de jīhuì, tā tēdì qiánqù bàifǎng le duō nián wèi jiàn de dàxué dǎoshī.',
    example_vi: 'Nhân cơ hội đi công tác, anh ấy đã đặc biệt tới thăm viếng người thầy hướng dẫn đại học nhiều năm chưa gặp.'
  },
  {
    hanzi: '拜年',
    example_hanzi: '大年初一清晨，晚辈们穿戴一新，纷纷向长辈登门拜年。',
    example_pinyin: 'Dànián chūyī qīngchén, wǎnbèi men chuāndài yī xīn, fēnfēn xiàng zhǎngbèi dēngmén bàinián.',
    example_vi: 'Sáng mùng một Tết, các hậu bối xúng xính quần áo mới lũ lượt đến nhà chúc Tết các bậc tiền bối.'
  },
  {
    hanzi: '摆脱',
    example_hanzi: '这家传统制造企业通过技术革新，终于摆脱了持续亏损的困境。',
    example_pinyin: 'Zhè jiā chuántǒng zhìzào qǐyè tōngguò jìshù géxīn, zhōngyú bǎituō le chíxù kuīsǔn de kùnjìng.',
    example_vi: 'Doanh nghiệp sản xuất truyền thống này nhờ cải tiến kỹ thuật mà cuối cùng đã thoát khỏi cảnh thua lỗ kéo dài.'
  },
  {
    hanzi: '版本',
    example_hanzi: '软件工程师正在为手机应用测试最新版本，以修复已知漏洞。',
    example_pinyin: 'Ruǎnjiàn gōngchéngshī zhèngzài wèi shǒujī yìngyòng cèshì zuìxīn bǎnběn, yǐ xiūfù yǐzhī lòudòng.',
    example_vi: 'Kỹ sư phần mềm đang kiểm thử phiên bản mới nhất cho ứng dụng di động nhằm khắc phục các lỗ hổng đã biết.'
  },
  {
    hanzi: '榜样',
    example_hanzi: '张医生在抗击疫情中舍己救人，成为了全院青年医护的榜样。',
    example_pinyin: 'Zhāng yīshēng zài kàngjī yìqíng zhōng shějǐ jiùrén, chéngwéi le quányuàn qīngnián yīhù de bǎngyàng.',
    example_vi: 'Bác sĩ Trương quên mình cứu người trong đợt chống dịch đã trở thành tấm gương cho các y bác sĩ trẻ toàn viện.'
  },
  {
    hanzi: '伴随',
    example_hanzi: '经济全球化的深入发展，往往伴随着复杂多元的国际文化交流。',
    example_pinyin: 'Jīngjì quánqiúhuà de shēnrù fāzhǎn, wǎngwǎng bànsuí zhe fùzá duōyuán de guójì wénhuà jiāoliú.',
    example_vi: 'Sự phát triển sâu rộng của toàn cầu hóa kinh tế thường đi kèm với những giao lưu văn hóa quốc tế đa dạng phức tạp.'
  },
  {
    hanzi: '扮演',
    example_hanzi: '中小微企业在促进国家就业和推动科技创新方面扮演着重要角色。',
    example_pinyin: 'Zhōng xiǎo wēi qǐyè zài cùjìn guójiā jiùyè hé tuīdòng kējì chuàngxīn fāngmiàn bànyǎn zhe zhòngyào juésè.',
    example_vi: 'Các doanh nghiệp vừa và nhỏ đóng vai trò quan trọng trong việc thúc đẩy việc làm quốc gia và đổi mới công nghệ.'
  },
  {
    hanzi: '爆发',
    example_hanzi: '由于长期矛盾积累，该地区不可避免地爆发了一场局部经济冲突。',
    example_pinyin: 'Yóuyú chángqī máodùn jīlěi, gāi dìqū bùkě bìmiǎn de bàofā le yì chǎng júbù jīngjì chōngtū.',
    example_vi: 'Do mâu thuẫn tích tụ lâu ngày, khu vực này không thể tránh khỏi bùng phát một cuộc xung đột kinh tế cục bộ.'
  },
  {
    hanzi: '保管',
    example_hanzi: '贵重物品请务必妥善保管，退房前请再次检查个人行李。',
    example_pinyin: 'Guìzhòng wùpǐn qǐng wùbì tuǒshàn bǎoguǎn, tuìfáng qián qǐng zàicì jiǎnchá gèrén xíngli.',
    example_vi: 'Đồ đạc quý giá xin nhất thiết bảo quản cẩn thận, trước khi trả phòng xin vui lòng kiểm tra lại hành lý cá nhân.'
  },
  {
    hanzi: '暴力',
    example_hanzi: '任何以暴力手段解决争端的行为，都将受到法律的严厉制裁。',
    example_pinyin: 'Rènhé yǐ bàolì shǒuduàn jiějué zhēngduān de xíngwéi, dōu jiāng shòudào fǎlǜ de yánlì zhìcái.',
    example_vi: 'Bất kỳ hành vi nào dùng thủ đoạn bạo lực để giải quyết tranh chấp đều sẽ chịu sự chế tài nghiêm khắc của pháp luật.'
  },
  {
    hanzi: '暴露',
    example_hanzi: '这次突击安全检查暴露出该工厂在消防管理上的诸多薄弱环节。',
    example_pinyin: 'Zhè cì tūjī ānquán jiǎnchá bàolù chū gāi gōngchǎng zài xiāofáng guǎnlǐ shang de zhūduō bóruò huánjié.',
    example_vi: 'Cuộc kiểm tra an toàn đột xuất này đã phơi bày rất nhiều khâu yếu kém trong công tác quản lý phòng cháy chữa cháy của nhà máy.'
  },
  {
    hanzi: '报社',
    example_hanzi: '这位资深记者已经在省城最大的报社辛勤工作了整整二十年。',
    example_pinyin: 'Zhè wèi zīshēn jìzhě yǐjīng zài shěngchéng zuì dà de bàoshè xīnqín gōngzuò le zhěngzhěng èrshí nián.',
    example_vi: 'Vị phóng viên kỳ cựu này đã làm việc chăm chỉ tại tòa soạn báo lớn nhất tỉnh lỵ đúng hai mươi năm.'
  },
  {
    hanzi: '爆炸',
    example_hanzi: '化工厂车间突发燃气爆炸，消防队员在五分钟内赶到了现场。',
    example_pinyin: 'Huàgōngchǎng chējiān tūfā ránqì bàozhà, xiāofáng duìyuán zài wǔ fēnzhōng nèi gǎndào le xiànchǎng.',
    example_vi: 'Phân xưởng nhà máy hóa chất đột nhiên phát nổ khí gas, lực lượng cứu hỏa đã có mặt tại hiện trường trong vòng 5 phút.'
  },
  {
    hanzi: '保障',
    example_hanzi: '健全的社会保障制度是维护社会公平与民生稳定的重要基石。',
    example_pinyin: 'Jiànquán de shèhuì bǎozhàng zhìdù shì wéihù shèhuì gōngpíng yǔ mínshēng wěndìng de zhòngyào jīshí.',
    example_vi: 'Chế độ bảo đảm an sinh xã hội hoàn thiện là nền tảng quan trọng bảo vệ sự công bằng xã hội và ổn định dân sinh.'
  }
];

console.log('Batch 1 seed helper ready with', BATCH_1_EXAMPLES.length, 'sample items');
