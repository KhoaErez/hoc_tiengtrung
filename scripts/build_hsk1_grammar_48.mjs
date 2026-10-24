import fs from 'fs';
import path from 'path';

function escapeSql(str) {
  if (!str) return "''";
  return `'${str.replace(/'/g, "''")}'`;
}

// 48 Điểm ngữ pháp chuẩn HSK 1 theo tiêu chuẩn GF 0025-2021
const HSK1_GRAMMAR_POINTS = [
  {
    order_index: 1,
    name: 'Đại từ nhân xưng (人称代词)',
    pattern: '我 / 你 / 他 / 她 / 我们 / 你们 / 他们 / 她们',
    category: 'Đại từ',
    explanation_vi: 'Đại từ nhân xưng dùng để xưng hô chỉ người. Số ít gồm: 我 (tôi), 你 (bạn), 他 (anh ấy - nam), 她 (cô ấy - nữ). Để tạo số nhiều, chỉ cần thêm hậu tố "们" (men) vào sau: 我们 (chúng tôi), 你们 (các bạn), 他们 (họ - nam hoặc chung), 她们 (họ - toàn nữ).',
    examples: [
      {
        chinese: '我是越南人，他是中国人。',
        pinyin: 'Wǒ shì Yuènánrén, tā shì Zhōngguórén.',
        translation_vi: 'Tôi là người Việt Nam, anh ấy là người Trung Quốc.',
        explanation: 'Sử dụng đại từ "我" (tôi) và "他" (anh ấy) làm chủ ngữ trong câu phán đoán.'
      },
      {
        chinese: '我们都是汉语班的同学生。',
        pinyin: 'Wǒmen dōu shì hànyǔ bān de tóngxué.',
        translation_vi: 'Chúng tôi đều là bạn học cùng lớp tiếng Trung.',
        explanation: '"我们" biểu thị ngôi thứ nhất số nhiều (chúng tôi), kết hợp với phó từ "都" (đều).'
      }
    ]
  },
  {
    order_index: 2,
    name: 'Đại từ chỉ thị (指示代词: 这 / 那)',
    pattern: '这 (này/đây) / 那 (kia/đó) + (Lượng từ) + Danh từ',
    category: 'Đại từ',
    explanation_vi: '"这" (zhè) chỉ người hoặc vật ở cự ly gần người nói (đây/này). "那" (nà) chỉ người hoặc vật ở cự ly xa người nói (kia/đó). Khi kết hợp với danh từ đếm được, thường phải thêm lượng từ ở giữa (这 + Lượng từ + Danh từ).',
    examples: [
      {
        chinese: '这是我的汉语老师。',
        pinyin: 'Zhè shì wǒ de hànyǔ lǎoshī.',
        translation_vi: 'Đây là giáo viên tiếng Trung của tôi.',
        explanation: '"这" làm chủ ngữ đứng đầu câu để giới thiệu người ở gần.'
      },
      {
        chinese: '那本书不是我的，是他买的。',
        pinyin: 'Nà běn shū bú shì wǒ de, shì tā mǎi de.',
        translation_vi: 'Quyển sách kia không phải của tôi, là của anh ấy mua.',
        explanation: '"那" kết hợp với lượng từ "本" trước danh từ "书" để chỉ quyển sách ở xa.'
      }
    ]
  },
  {
    order_index: 3,
    name: 'Đại từ chỉ nơi chốn (这儿 / 那儿 / 哪儿)',
    pattern: '这儿 (ở đây) / 那儿 (ở kia) / 哪儿 (ở đâu)',
    category: 'Đại từ',
    explanation_vi: 'Thêm âm uốn lưỡi "儿" (hoặc "里") vào sau đại từ chỉ thị để tạo thành đại từ chỉ nơi chốn: 这儿/这里 (chỗ này, ở đây), 那儿/那里 (chỗ kia, ở đó). Từ nghi vấn để hỏi nơi chốn là 哪儿/哪里 (ở đâu?).',
    examples: [
      {
        chinese: '我在这儿等你，你快来吧。',
        pinyin: 'Wǒ zài zhèr děng nǐ, nǐ kuài lái ba.',
        translation_vi: 'Tôi đợi bạn ở đây, bạn đến mau nhé.',
        explanation: '"这儿" chỉ vị trí người nói đang đứng.'
      },
      {
        chinese: '你的手机在哪儿？在桌子上。',
        pinyin: 'Nǐ de shǒujī zài nǎr? Zài zhuōzi shang.',
        translation_vi: 'Điện thoại của bạn ở đâu? Ở trên bàn.',
        explanation: '"哪儿" dùng trong câu hỏi vị trí nơi chốn.'
      }
    ]
  },
  {
    order_index: 4,
    name: 'Đại từ nghi vấn "谁" (Hỏi người: Ai?)',
    pattern: '谁 + V...? / S + 是 + 谁？',
    category: 'Đại từ',
    explanation_vi: '"谁" (shéi hoặc shuí) dùng để hỏi về người ("ai?"). Trong tiếng Trung, vị trí của đại từ nghi vấn đặt đúng vào vị trí của thành phần cần hỏi trong câu trần thuật, không cần đảo ngữ ra đầu câu như tiếng Anh.',
    examples: [
      {
        chinese: '那个高个子的男生是谁？',
        pinyin: 'Nà gè gāo gèzi de nánshēng shì shéi?',
        translation_vi: 'Bạn nam dáng người cao kia là ai vậy?',
        explanation: '"谁" đóng vai trò vị ngữ trong câu chữ "是".'
      },
      {
        chinese: '今天谁去超市买水果？',
        pinyin: 'Jīntiān shéi qù chāoshì mǎi shuǐguǒ?',
        translation_vi: 'Hôm nay ai đi siêu thị mua hoa quả?',
        explanation: '"谁" đóng vai trò chủ ngữ hỏi người thực hiện hành động.'
      }
    ]
  },
  {
    order_index: 5,
    name: 'Đại từ nghi vấn "什么" (Hỏi vật: Cái gì / Gì?)',
    pattern: 'V + 什么？ / 什么 + Danh từ？',
    category: 'Đại từ',
    explanation_vi: '"什么" (shénme) dùng để hỏi về đồ vật, sự việc ("cái gì?"). Khi đứng trước danh từ, nó mang nghĩa "gì / nào" (ví dụ: 什么书 - sách gì, 什么名字 - tên gì, 什么时候 - khi nào).',
    examples: [
      {
        chinese: '你在看什么书呢？',
        pinyin: 'Nǐ zài kàn shénme shū ne?',
        translation_vi: 'Bạn đang đọc sách gì thế?',
        explanation: '"什么" bổ nghĩa cho danh từ "书" hỏi tên loại sách.'
      },
      {
        chinese: '请问，你叫什么名字？',
        pinyin: 'Qǐngwèn, nǐ jiào shénme míngzi?',
        translation_vi: 'Xin hỏi, bạn tên là gì?',
        explanation: 'Mẫu câu chào hỏi cơ bản nhất hỏi tên người.'
      }
    ]
  },
  {
    order_index: 6,
    name: 'Đại từ nghi vấn "哪" (Hỏi lựa chọn: Nào?)',
    pattern: '哪 + Lượng từ + Danh từ？ / 哪国人？',
    category: 'Đại từ',
    explanation_vi: '"哪" (nǎ) dùng để hỏi về sự lựa chọn ("nào?"). Thường dùng theo công thức: "哪 + Lượng từ + Danh từ" (ví dụ: 哪本书 - quyển sách nào, 哪个杯子 - cái cốc nào) hoặc hỏi quốc tịch: "哪国人" (người nước nào).',
    examples: [
      {
        chinese: '请问你是哪国人？我是法国人。',
        pinyin: 'Qǐngwèn nǐ shì nǎ guó rén? Wǒ shì Fǎguórén.',
        translation_vi: 'Xin hỏi bạn là người nước nào? Tôi là người Pháp.',
        explanation: '"哪国人" là cấu trúc tiêu chuẩn để hỏi quốc tịch.'
      },
      {
        chinese: '你想买哪件衣服？',
        pinyin: 'Nǐ xiǎng mǎi nǎ jiàn yīfu?',
        translation_vi: 'Bạn muốn mua bộ quần áo nào?',
        explanation: '"哪 + 件 (lượng từ) + 衣服" hỏi sự lựa chọn cụ thể.'
      }
    ]
  },
  {
    order_index: 7,
    name: 'Đại từ nghi vấn "几" và "多少" (Hỏi số lượng: Mấy & Bao nhiêu)',
    pattern: '几 + Lượng từ + N (dưới 10) / 多少 + (Lượng từ) + N (trên 10)',
    category: 'Đại từ',
    explanation_vi: '"几" (jǐ) dùng khi ước chừng số lượng ít (dưới 10) và bắt buộc phải có lượng từ đi kèm (几个人, 几本书). "多少" (duōshao) dùng khi số lượng nhiều (trên 10) hoặc không giới hạn, lượng từ có thể có hoặc không (多少钱, 多少(个)学生).',
    examples: [
      {
        chinese: '你家里有几口人？我家有四口人。',
        pinyin: 'Nǐ jiā lǐ yǒu jǐ kǒu rén? Wǒ jiā yǒu sì kǒu rén.',
        translation_vi: 'Nhà bạn có mấy người? Nhà tôi có bốn người.',
        explanation: 'Hỏi thành viên gia đình dưới 10 người dùng "几" kèm lượng từ "口".'
      },
      {
        chinese: '请问这件黑色大衣多少钱？',
        pinyin: 'Qǐngwèn zhè jiàn hēisè dàyī duōshao qián?',
        translation_vi: 'Xin hỏi chiếc áo khoác đen này bao nhiêu tiền?',
        explanation: 'Hỏi giá tiền dùng "多少钱", không dùng "几钱".'
      }
    ]
  },
  {
    order_index: 8,
    name: 'Đại từ nghi vấn "怎么" (Hỏi phương thức / nguyên nhân: Thế nào / Làm sao)',
    pattern: '怎么 + Động từ？ (Hỏi cách làm) / 怎么了？ (Hỏi tình hình)',
    category: 'Đại từ',
    explanation_vi: '"怎么" (zěnme) đứng trước động từ để hỏi về cách thức tiến hành hành động ("làm như thế nào?"). Cụm "怎么了" dùng để hỏi thăm tình hình khi thấy ai đó có biểu hiện bất thường ("Sao thế? Có chuyện gì vậy?").',
    examples: [
      {
        chinese: '请问这个汉字怎么读？',
        pinyin: 'Qǐngwèn zhè gè hànzì zěnme dú?',
        translation_vi: 'Xin hỏi chữ Hán này đọc như thế nào?',
        explanation: '"怎么读" hỏi phương thức phát âm của chữ Hán.'
      },
      {
        chinese: '你今天怎么没来上课？',
        pinyin: 'Nǐ jīntiān zěnme méi lái shàngkè?',
        translation_vi: 'Hôm nay làm sao mà bạn không đến lớp học?',
        explanation: '"怎么" dùng hỏi nguyên nhân với sắc thái ngạc nhiên nhẹ.'
      }
    ]
  },
  {
    order_index: 9,
    name: 'Đại từ nghi vấn "怎么样" (Hỏi tính chất / Ý kiến: Như thế nào)',
    pattern: 'Chủ ngữ + 怎么样？ / ..., 怎么样？',
    category: 'Đại từ',
    explanation_vi: '"怎么样" (zěnmeyàng) dùng để hỏi về tính chất, tình trạng của người/sự vật ("thế nào?"), hoặc đặt ở cuối câu để thăm dò ý kiến, rủ rê đề nghị ("...thì thế nào? Có được không?").',
    examples: [
      {
        chinese: '你最近工作怎么样？挺忙的。',
        pinyin: 'Nǐ zuìjìn gōngzuò zěnmeyàng? Tǐng máng de.',
        translation_vi: 'Dạo này công việc của bạn thế nào? Khá bận rộn.',
        explanation: 'Dùng hỏi về tình hình, trạng thái công việc gần đây.'
      },
      {
        chinese: '我们明天下午去喝咖啡，怎么样？',
        pinyin: 'Wǒmen míngtiān xiàwǔ qù hē kāfēi, zěnmeyàng?',
        translation_vi: 'Chiều mai chúng ta đi uống cà phê nhé, thấy thế nào?',
        explanation: 'Đặt ở cuối câu để tham khảo ý kiến người nghe.'
      }
    ]
  },
  {
    order_index: 10,
    name: 'Số từ cơ bản và cách đọc số đếm (数词 0 - 100)',
    pattern: '零, 一, 二, 三, 四, 五, 六, 七, 八, 九, 十 ... 百',
    category: 'Số từ',
    explanation_vi: 'Quy tắc ghép số tiếng Trung: Hàng chục ghép từ "十" (10) đến "九十九" (99): 11 là 十一, 20 là 二十, 25 là 二十五. Số 100 là 一百 (yìbǎi). Khi đọc số phòng hoặc số điện thoại, số "1" thường đọc chệch thành "yāo" (yêu) để tránh nhầm với "7" (qī).',
    examples: [
      {
        chinese: '我的房间号码是三零一号。',
        pinyin: 'Wǒ de fángjiān hàomǎ shì sān líng yāo hào.',
        translation_vi: 'Số phòng của tôi là phòng số 301.',
        explanation: 'Số 1 trong số phòng được đọc là "yāo", số 0 đọc là "líng".'
      },
      {
        chinese: '我们学校有八十五位中国留学生。',
        pinyin: 'Wǒmen xuéxiào yǒu bāshíwǔ wèi Zhōngguó liúxuéshēng.',
        translation_vi: 'Trường chúng tôi có 85 bạn du học sinh Trung Quốc.',
        explanation: 'Số đếm "八十五" ghép từ 八 (8) + 十 (10) + 五 (5).'
      }
    ]
  },
  {
    order_index: 11,
    name: 'Lượng từ thông dụng "个" (个字量词)',
    pattern: 'Số từ / Đại từ + 个 + Danh từ',
    category: 'Lượng từ',
    explanation_vi: '"个" (ge) là lượng từ phổ biến và đa năng nhất trong tiếng Trung. Nó dùng cho người (一个人), đồ vật không có lượng từ riêng hoặc lượng từ thông dụng trong sinh hoạt (一个苹果, 一个月, 这个问题). Thường phát âm thanh nhẹ.',
    examples: [
      {
        chinese: '我今天在超市买了三个大苹果。',
        pinyin: 'Wǒ jīntiān zài chāoshì mǎi le sān gè dà píngguǒ.',
        translation_vi: 'Hôm nay tôi đã mua ba quả táo lớn ở siêu thị.',
        explanation: '"个" làm lượng từ cho danh từ hoa quả "苹果".'
      },
      {
        chinese: '这个月我们班来了两位新同学。',
        pinyin: 'Zhè gè yuè wǒmen bān lái le liǎng wèi xīn tóngxué.',
        translation_vi: 'Tháng này lớp chúng tôi có thêm hai bạn học sinh mới.',
        explanation: '"这个月" (tháng này) sử dụng "个" làm lượng từ cho "月".'
      }
    ]
  },
  {
    order_index: 12,
    name: 'Lượng từ chuyên dụng cơ bản: 本, 张, 只, 件, 杯',
    pattern: 'Số từ + 本 (sách) / 张 (bề mặt phẳng) / 只 (động vật) / 件 (áo) / 杯 (cốc) + Danh từ',
    category: 'Lượng từ',
    explanation_vi: 'Tiếng Trung có lượng từ riêng cho từng nhóm đồ vật có hình dáng đặc thù: "本" (běn) cho sách vở có gáy, "张" (zhāng) cho vật bề mặt phẳng mỏng như bàn, giấy, vé, giường; "只" (zhī) cho động vật nhỏ hoặc một bên trong cặp; "件" (jiàn) cho áo, sự việc; "杯" (bēi) cho cốc, ly đồ uống.',
    examples: [
      {
        chinese: '桌子上有两本新汉语词典。',
        pinyin: 'Zhuōzi shang yǒu liǎng běn xīn hànyǔ cídiǎn.',
        translation_vi: 'Trên bàn có hai quyển từ điển tiếng Trung mới.',
        explanation: 'Dùng lượng từ "本" cho sách và từ điển (chú ý số 2 dùng "两").'
      },
      {
        chinese: '服务员，请给我来一杯热绿茶。',
        pinyin: 'Fúwùyuán, qǐng gěi wǒ lái yì bēi rè lǜchá.',
        translation_vi: 'Phục vụ ơi, xin cho tôi một tách trà xanh nóng.',
        explanation: '"杯" vừa là danh từ cái cốc, vừa đóng vai trò lượng từ đo lường đồ uống.'
      }
    ]
  },
  {
    order_index: 13,
    name: 'Lượng từ đo lường thời gian: 岁, 年, 天, 星期, 分钟',
    pattern: 'Số từ + 岁 (tuổi) / 年 (năm) / 天 (ngày) / 星期 (tuần)',
    category: 'Lượng từ',
    explanation_vi: 'Trong tiếng Trung, "年" (năm) và "天" (ngày) vừa là danh từ vừa kiêm lượng từ, đứng trực tiếp sau số từ không cần chèn "个" (ví dụ: 一天, 三年). Ngược lại, "星期" (tuần) và "月" (tháng) khi nói về số lượng khoảng thời gian bắt buộc phải có lượng từ "个" (ví dụ: 一个星期, 三个月). "岁" dùng sau số từ để biểu thị tuổi tác.',
    examples: [
      {
        chinese: '李老师的女儿今年刚好五岁了。',
        pinyin: 'Lǐ lǎoshī de nǚ\'ér jīnnián gānghǎo wǔ suì le.',
        translation_vi: 'Con gái của thầy Lý năm nay vừa tròn năm tuổi rồi.',
        explanation: '"岁" làm lượng từ chỉ số tuổi sau số từ "五".'
      },
      {
        chinese: '他在北京大学学习了整整两年汉语。',
        pinyin: 'Tā zài Běijīng Dàxué xuéxí le zhěngzhěng liǎng nián hànyǔ.',
        translation_vi: 'Anh ấy đã học tiếng Trung tại Đại học Bắc Kinh tròn hai năm.',
        explanation: '"两年" đi trực tiếp với số từ "两", không nói "两个年".'
      }
    ]
  },
  {
    order_index: 14,
    name: 'Phó từ phủ định "不" (不字否定)',
    pattern: '不 + Động từ / Tính từ',
    category: 'Phó từ',
    explanation_vi: '"不" (bù) dùng để phủ định hành động ở hiện tại, tương lai, thói quen thường nhật, hoặc phủ định tính chất của tính từ. Mang tính chủ quan của người nói ("không muốn, không làm"). Lưu ý biến điệu: "不" đọc thanh 2 (bú) khi đứng trước từ mang thanh 4.',
    examples: [
      {
        chinese: '我今天身体不舒服，不想去上班。',
        pinyin: 'Wǒ jīntiān shēntǐ bù shūfu, bù xiǎng qù shàngbān.',
        translation_vi: 'Hôm nay người tôi không khỏe, không muốn đi làm.',
        explanation: '"不" phủ định tính từ "舒服" và động từ năng nguyện "想".'
      },
      {
        chinese: '他是韩国人，不是日本留学生。',
        pinyin: 'Tā shì Hánguórén, bú shì Rìběn liúxuéshēng.',
        translation_vi: 'Anh ấy là người Hàn Quốc, không phải du học sinh Nhật Bản.',
        explanation: '"不" đứng trước "是" (thanh 4) biến điệu đọc thành "bú shì".'
      }
    ]
  },
  {
    order_index: 15,
    name: 'Phó từ phủ định "没 / 没有" (没字否定)',
    pattern: '没 / 没有 + Động từ / Danh từ',
    category: 'Phó từ',
    explanation_vi: '"没" hoặc "没有" (méiyǒu) dùng để: 1. Phủ định sở hữu ("không có gì": 没有钱, 没有时间). 2. Phủ định hành động chưa xảy ra hoặc chưa hoàn thành trong quá khứ ("chưa làm gì"). Tuyệt đối không dùng "不" để phủ định cho "有" (không có "不有").',
    examples: [
      {
        chinese: '我昨天感冒了，没有去学校上课。',
        pinyin: 'Wǒ zuótiān gǎnmào le, méiyǒu qù xuéxiào shàngkè.',
        translation_vi: 'Hôm qua tôi bị cảm cúm, không đi học ở trường.',
        explanation: '"没有去" phủ định hành động trong quá khứ ngày hôm qua.'
      },
      {
        chinese: '书包里只有书本，没有钱包。',
        pinyin: 'Shūbāo lǐ zhǐyǒu shūběn, méiyǒu qiánbāo.',
        translation_vi: 'Trong cặp sách chỉ có sách vở, không có ví tiền.',
        explanation: '"没有" biểu thị sự không tồn tại/không sở hữu ví tiền.'
      }
    ]
  },
  {
    order_index: 16,
    name: 'Phó từ mức độ "很" (很字副词)',
    pattern: 'S + 很 + Tính từ',
    category: 'Phó từ',
    explanation_vi: '"很" (hěn) là phó từ chỉ mức độ ("rất"). Trong câu vị ngữ tính từ tiếng Trung, "很" thường được thêm vào trước tính từ như một từ nối ngữ pháp đệm để câu không bị cộc lốc, khi đó nghĩa "rất" bị mờ nhạt đi và không cần dịch ra tiếng Việt.',
    examples: [
      {
        chinese: '汉语虽然声调难，但是汉字很有趣。',
        pinyin: 'Hànyǔ suīrán shēngdiào nán, dànshì hànzì hěn yǒuqù.',
        translation_vi: 'Tiếng Trung tuy thanh điệu khó, nhưng chữ Hán rất thú vị.',
        explanation: '"很有趣" dùng "很" đứng trước tính từ biểu thị mức độ cao.'
      },
      {
        chinese: '我今天工作很忙。',
        pinyin: 'Wǒ jīntiān gōngzuò hěn máng.',
        translation_vi: 'Hôm nay công việc của tôi (rất) bận.',
        explanation: '"很" đóng vai trò liên kết ngữ pháp đệm trước tính từ "忙".'
      }
    ]
  },
  {
    order_index: 17,
    name: 'Cấu trúc cảm thán "太...了" (太字结构)',
    pattern: '太 + Tính từ / Tâm lý động từ + 了',
    category: 'Phó từ',
    explanation_vi: 'Cấu trúc "太...了" (tài... le) dùng để biểu thị mức độ cực cao hoặc cảm thán ("quá... rồi!"). Khi ở thể phủ định "不太..." thì bỏ "了", mang nghĩa "không... lắm" (ví dụ: 不太好 - không tốt lắm).',
    examples: [
      {
        chinese: '北京烤鸭的味道太好吃了！',
        pinyin: 'Běijīng kǎoyā de wèidao tài hǎochī le!',
        translation_vi: 'Mùi vị của món vịt quay Bắc Kinh quá ngon rồi!',
        explanation: 'Biểu thị ngữ khí khen ngợi cảm thán cao độ.'
      },
      {
        chinese: '这家饭馆的菜味道不太咸，很适合我。',
        pinyin: 'Zhè jiā fànguǎn de cài wèidao bú tài xián, hěn shìhé wǒ.',
        translation_vi: 'Món ăn của quán này vị không mặn lắm, rất hợp với tôi.',
        explanation: 'Dạng phủ định "不太 + Tính từ" biểu thị mức độ nhẹ nhàng.'
      }
    ]
  },
  {
    order_index: 18,
    name: 'Phó từ phạm vi "都" (都字副词: Đều)',
    pattern: 'Chủ ngữ (số nhiều) + 都 + V / Adj',
    category: 'Phó từ',
    explanation_vi: '"都" (dōu) là phó từ biểu thị toàn bộ đối tượng được nhắc đến trước đó ("đều"). Chủ ngữ đứng trước "都" bắt buộc phải là số nhiều hoặc mang tính tập hợp (chúng tôi, bọn họ, mọi người, tất cả).',
    examples: [
      {
        chinese: '他们俩都是河内国家大学的学生。',
        pinyin: 'Tāmen liǎ dōu shì Hénèi Guójiā Dàxué de xuésheng.',
        translation_vi: 'Hai người bọn họ đều là sinh viên Đại học Quốc gia Hà Nội.',
        explanation: '"都" bao quát cả hai người "他们俩".'
      },
      {
        chinese: '这些中国菜都很好吃。',
        pinyin: 'Zhèxiē Zhōngguócài dōu hěn hǎochī.',
        translation_vi: 'Những món ăn Trung Quốc này đều rất ngon miệng.',
        explanation: '"都" đứng trước cụm vị ngữ "很好吃".'
      }
    ]
  },
  {
    order_index: 19,
    name: 'Phó từ tương đồng "也" (也字副词: Cũng)',
    pattern: 'Chủ ngữ + 也 + V / Adj',
    category: 'Phó từ',
    explanation_vi: '"也" (yě) là phó từ biểu thị sự tương đồng, đồng nhất ("cũng"). "也" đứng trước động từ hoặc tính từ, đứng sau chủ ngữ. Nếu trong câu vừa có "也" vừa có "都", vị trí chuẩn mực là: "也 + 都" (ví dụ: 我们也都去 - chúng tôi cũng đều đi).',
    examples: [
      {
        chinese: '你会说汉语，我也会说一点儿。',
        pinyin: 'Nǐ huì shuō hànyǔ, wǒ yě huì shuō yìdiǎnr.',
        translation_vi: 'Bạn biết nói tiếng Trung, tôi cũng biết nói một chút.',
        explanation: '"也" thể hiện sự tương đồng về khả năng nói tiếng Trung.'
      },
      {
        chinese: '明天是周末，我们也都休息。',
        pinyin: 'Míngtiān shì zhōumò, wǒmen yě dōu xiūxi.',
        translation_vi: 'Ngày mai là cuối tuần, chúng tôi cũng đều được nghỉ.',
        explanation: 'Trật tự kết hợp chuẩn: "也" đứng trước "都".'
      }
    ]
  },
  {
    order_index: 20,
    name: 'Câu chữ "是" phán đoán (是字句)',
    pattern: 'Khẳng định: A + 是 + B / Phủ định: A + 不是 + B',
    category: 'Cấu trúc câu',
    explanation_vi: 'Động từ "是" (shì) biểu thị sự phán đoán, xác nhận danh tính, quốc tịch hoặc quan hệ tương đương giữa chủ ngữ và tân ngữ ("A là B"). Thể phủ định là "不是" (bú shì).',
    examples: [
      {
        chinese: '她是我的好朋友，也是一名护士。',
        pinyin: 'Tā shì wǒ de hǎo péngyou, yě shì yì míng hùshi.',
        translation_vi: 'Cô ấy là bạn thân của tôi, cũng là một y tá.',
        explanation: 'Sử dụng "是" để xác nhận thân phận và nghề nghiệp.'
      },
      {
        chinese: '这支钢笔不是我的，是我同桌的。',
        pinyin: 'Zhè zhī gāngbǐ bú shì wǒ de, shì wǒ tóngzhuō de.',
        translation_vi: 'Chiếc bút máy này không phải của tôi, là của bạn cùng bàn tôi.',
        explanation: '"不是" phủ định quan hệ sở hữu.'
      }
    ]
  },
  {
    order_index: 21,
    name: 'Câu chữ "有" biểu thị sở hữu và tồn tại (有字句)',
    pattern: 'Sở hữu: Chủ ngữ + 有 + Tân ngữ / Tồn tại: Nơi chốn + 有 + Danh từ',
    category: 'Cấu trúc câu',
    explanation_vi: 'Động từ "有" (yǒu) có 2 công dụng chính: 1. Biểu thị quyền sở hữu (Tôi có sách - 我有书). 2. Biểu thị sự tồn tại khách quan tại một địa điểm (Trên bàn có một quả táo - 桌子上有个苹果). Thể phủ định bắt buộc dùng "没有", không được dùng "不有".',
    examples: [
      {
        chinese: '我家有一只非常可爱的白色小狗。',
        pinyin: 'Wǒ jiā yǒu yì zhī fēicháng kě\'ài de báisè xiǎogǒu.',
        translation_vi: 'Nhà tôi có một chú chó nhỏ màu trắng vô cùng đáng yêu.',
        explanation: '"有" biểu thị quan hệ sở hữu vật nuôi.'
      },
      {
        chinese: '学校大门口有一家很大的书店。',
        pinyin: 'Xuéxiào dàménkǒu yǒu yì jiā hěn dà de shūdiàn.',
        translation_vi: 'Ở cổng lớn của trường học có một hiệu sách rất to.',
        explanation: '"有" biểu thị sự tồn tại nơi chốn ở cổng trường.'
      }
    ]
  },
  {
    order_index: 22,
    name: 'Động từ vị trí "在" (在作动词)',
    pattern: 'Người / Vật + 在 + Nơi chốn / Phương vị từ',
    category: 'Động từ',
    explanation_vi: 'Khi "在" đóng vai trò vị ngữ chính trong câu, nó biểu thị người hoặc đồ vật đang ở tại một vị trí, địa điểm cụ thể ("ở, tại"). Thể phủ định dùng "不在" (không ở).',
    examples: [
      {
        chinese: '请问王经理在办公室吗？他现在不在。',
        pinyin: 'Qǐngwèn Wáng jīnglǐ zài bàngōngshì ma? Tā xiànzài bú zài.',
        translation_vi: 'Xin hỏi giám đốc Vương có ở văn phòng không? Hiện tại ông ấy không có ở đây.',
        explanation: '"在" làm động từ vị ngữ chính chỉ sự hiện diện.'
      },
      {
        chinese: '我的护照和钱包都在抽屉里。',
        pinyin: 'Wǒ de hùzhào hé qiánbāo dōu zài chōuti lǐ.',
        translation_vi: 'Hộ chiếu và ví tiền của tôi đều ở trong ngăn kéo.',
        explanation: 'Kết hợp "在" với từ chỉ phương vị "里" (bên trong).'
      }
    ]
  },
  {
    order_index: 23,
    name: 'Động từ năng nguyện "会" (Biết qua học tập)',
    pattern: 'Chủ ngữ + 会 / 不会 + Động từ',
    category: 'Động từ năng nguyện',
    explanation_vi: '"会" (huì) biểu thị một kỹ năng hoặc năng lực có được thông qua quá trình học tập, rèn luyện (ví dụ: biết bơi, biết lái xe, biết nói tiếng Trung). Thể phủ định dùng "不会" (không biết làm).',
    examples: [
      {
        chinese: '哥哥会开车，但是弟弟还不会。',
        pinyin: 'Gēge huì kāichē, dànshì dìdi hái bú huì.',
        translation_vi: 'Anh trai biết lái xe, nhưng em trai vẫn chưa biết.',
        explanation: '"会开车" là kỹ năng học được qua đào tạo lái xe.'
      },
      {
        chinese: '你会写自己的中文名字吗？',
        pinyin: 'Nǐ huì xiě zìjǐ de zhōngwén míngzi ma?',
        translation_vi: 'Bạn có biết viết tên tiếng Trung của mình không?',
        explanation: '"会写" hỏi về kỹ năng viết chữ Hán.'
      }
    ]
  },
  {
    order_index: 24,
    name: 'Động từ năng nguyện "想" (Muốn / Dự định)',
    pattern: 'Chủ ngữ + 想 / 不想 + Động từ',
    category: 'Động từ năng nguyện',
    explanation_vi: '"想" (xiǎng) đứng trước động từ biểu thị ý muốn chủ quan, dự định hoặc nguyện vọng ("muốn làm gì"). Phủ định dùng "不想" (không muốn). Ngoài ra khi đứng độc lập trước danh từ, "想" còn mang nghĩa là "nhớ" (想家 - nhớ nhà) hoặc "nghĩ" (想一想).',
    examples: [
      {
        chinese: '明天下午我想去图书馆看书。',
        pinyin: 'Míngtiān xiàwǔ wǒ xiǎng qù túshūguǎn kànshū.',
        translation_vi: 'Chiều mai tôi muốn đến thư viện đọc sách.',
        explanation: '"想去" biểu thị mong muốn dự định trong tương lai gần.'
      },
      {
        chinese: '天气太热了，我不想出去运动。',
        pinyin: 'Tiānqì tài rè le, wǒ bù xiǎng chūqù yùndòng.',
        translation_vi: 'Thời tiết nóng quá rồi, tôi không muốn ra ngoài vận động.',
        explanation: '"不想" phủ định ý muốn chủ quan.'
      }
    ]
  },
  {
    order_index: 25,
    name: 'Động từ năng nguyện "能" (Có thể / Năng lực)',
    pattern: 'Chủ ngữ + 能 / 不能 + Động từ',
    category: 'Động từ năng nguyện',
    explanation_vi: '"能" (néng) biểu thị năng lực bẩm sinh, khả năng khách quan đạt được mức độ nào đó, hoặc hoàn cảnh khách quan cho phép có thể thực hiện được hành động. Thể phủ định dùng "不能".',
    examples: [
      {
        chinese: '我的感冒好了，明天能去上学了。',
        pinyin: 'Wǒ de gǎnmào hǎo le, míngtiān néng qù shàngxué le.',
        translation_vi: 'Bệnh cảm của tôi đã khỏi rồi, ngày mai có thể đi học lại rồi.',
        explanation: 'Khả năng thể chất và sức khỏe cho phép thực hiện hành động.'
      },
      {
        chinese: '这里太吵了，我不能专心看书。',
        pinyin: 'Zhèlǐ tài chǎo le, wǒ bù néng zhuānxīn kànshū.',
        translation_vi: 'Ở đây ồn ào quá, tôi không thể tập trung đọc sách.',
        explanation: 'Điều kiện hoàn cảnh khách quan không cho phép.'
      }
    ]
  },
  {
    order_index: 26,
    name: 'Động từ năng nguyện "可以" (Được phép / Có thể)',
    pattern: 'Chủ ngữ + 可以 + Động từ / (Phủ định cấm đoán: 不能 / 不行)',
    category: 'Động từ năng nguyện',
    explanation_vi: '"可以" (kěyǐ) biểu thị sự cho phép về mặt quy định, phép lịch sự hoặc đưa ra lời thỉnh cầu ("có thể / được phép làm gì"). Khi trả lời phủ định từ chối sự cho phép, người ta thường dùng "不能" hoặc "不行" chứ ít khi dùng "不可以" (vì mang sắc thái quá gay gắt).',
    examples: [
      {
        chinese: '请问，我可以在这里吸烟吗？不可以。',
        pinyin: 'Qǐngwèn, wǒ kěyǐ zài zhèlǐ xīyān ma? Bù kěyǐ.',
        translation_vi: 'Xin hỏi, tôi có thể hút thuốc ở đây không? Không được.',
        explanation: 'Dùng "可以" trong lời thỉnh cầu lịch sự xin phép.'
      },
      {
        chinese: '作业做完了，你现在可以看电视了。',
        pinyin: 'Zuòyè zuò wán le, nǐ xiànzài kěyǐ kàn diànshì le.',
        translation_vi: 'Bài tập làm xong rồi, bây giờ con có thể xem tivi rồi.',
        explanation: 'Biểu thị sự cho phép sau khi hoàn thành điều kiện.'
      }
    ]
  },
  {
    order_index: 27,
    name: 'Giới từ địa điểm "在" (在作介词: Ở đâu làm gì)',
    pattern: 'Chủ ngữ + 在 + Nơi chốn + Động từ + Tân ngữ',
    category: 'Giới từ',
    explanation_vi: 'Quy tắc ngữ pháp vàng của tiếng Trung: TRẠNG TỪ CHỈ NƠI CHỐN ĐỨNG TRƯỚC ĐỘNG TỪ CHÍNH. Khác với tiếng Việt nói "Tôi đọc sách ở thư viện", tiếng Trung bắt buộc phải nói theo trình tự: "Tôi [ở thư viện] đọc sách" (我在图书馆看书).',
    examples: [
      {
        chinese: '爸爸每天都在医院工作。',
        pinyin: 'Bàba měitiān dōu zài yīyuàn gōngzuò.',
        translation_vi: 'Bố mỗi ngày đều làm việc ở bệnh viện.',
        explanation: '"在医院" (ở bệnh viện) đặt trước động từ "工作" (làm việc).'
      },
      {
        chinese: '我们晚上在家里吃中国菜。',
        pinyin: 'Wǒmen wǎnshang zài jiā lǐ chī Zhōngguócài.',
        translation_vi: 'Buổi tối chúng tôi ăn món ăn Trung Quốc ở nhà.',
        explanation: '"在家里" đặt trước hành động "吃中国菜".'
      }
    ]
  },
  {
    order_index: 28,
    name: 'Giới từ cùng đối tượng "跟" (跟...一起)',
    pattern: 'A + 跟 + B + (一起) + Động từ',
    category: 'Giới từ',
    explanation_vi: '"跟" (gēn) đóng vai trò giới từ chỉ đối tượng cùng tham gia hành động ("cùng với ai làm gì"). Trong khẩu ngữ thường kết hợp với phó từ "一起" (yìqǐ) để tăng cường nghĩa đồng hành ("cùng nhau").',
    examples: [
      {
        chinese: '周末我常跟我妈妈一起去超市买菜。',
        pinyin: 'Zhōumò wǒ cháng gēn wǒ māma yìqǐ qù chāoshì mǎi cài.',
        translation_vi: 'Cuối tuần tôi thường cùng mẹ đi siêu thị mua thức ăn.',
        explanation: '"跟我妈妈一起" bổ nghĩa cho hành động đi siêu thị.'
      },
      {
        chinese: '我想跟你商量一件重要的事情。',
        pinyin: 'Wǒ xiǎng gēn nǐ shāngliang yí jiàn zhòngyào de shìqing.',
        translation_vi: 'Tôi muốn bàn bạc với bạn một việc quan trọng.',
        explanation: '"跟 + bạn" chỉ đối tượng trao đổi giao tiếp.'
      }
    ]
  },
  {
    order_index: 29,
    name: 'Giới từ trao nhận "给" (给作介词)',
    pattern: 'Chủ ngữ + 给 + Đối tượng + Động từ / 给 + Đối tượng + 打电话',
    category: 'Giới từ',
    explanation_vi: '"给" (gěi) ngoài nghĩa là động từ "cho/tặng", còn làm giới từ chỉ đối tượng tiếp nhận hành động ("cho ai, tới ai"). Mẫu câu kinh điển nhất là "给...打电话" (gọi điện thoại cho ai).',
    examples: [
      {
        chinese: '我下了飞机就给你打电话。',
        pinyin: 'Wǒ xià le fēijī jiù gěi nǐ dǎ diànhuà.',
        translation_vi: 'Tôi vừa bước xuống máy bay là gọi điện thoại cho bạn ngay.',
        explanation: '"给你打电话" là mẫu câu tiêu chuẩn trong giao tiếp tiếng Trung.'
      },
      {
        chinese: '妈妈每天都给我做可口的早饭。',
        pinyin: 'Māma měitiān dōu gěi wǒ zuò kěkǒu de zǎofàn.',
        translation_vi: 'Mẹ mỗi ngày đều nấu bữa sáng ngon miệng cho tôi.',
        explanation: '"给我做早饭" biểu thị làm bữa sáng cho đối tượng "tôi".'
      }
    ]
  },
  {
    order_index: 30,
    name: 'Liên từ nối từ "和" (和字连词)',
    pattern: 'Danh từ / Đại từ A + 和 + Danh từ / Đại từ B',
    category: 'Liên từ',
    explanation_vi: '"和" (hé) là liên từ mang nghĩa "và, cùng". LƯU Ý CỰC KỲ QUAN TRỌNG: "和" CHỈ DÙNG ĐỂ NỐI DANH TỪ HOẶC ĐẠI TỪ, TUYỆT ĐỐI KHÔNG DÙNG "和" ĐỂ NỐI HAI CÂU HOẶC HAI MỆNH ĐỀ như từ "and" trong tiếng Anh hay "và" trong tiếng Việt.',
    examples: [
      {
        chinese: '桌子上有三个苹果和两根香蕉。',
        pinyin: 'Zhuōzi shang yǒu sān gè píngguǒ hé liǎng gēn xiāngjiāo.',
        translation_vi: 'Trên bàn có ba quả táo và hai quả chuối.',
        explanation: '"和" nối hai cụm danh từ "苹果" và "香蕉".'
      },
      {
        chinese: '我和他是小学同班同学。',
        pinyin: 'Wǒ hé tā shì xiǎoxué tóngbān tóngxué.',
        translation_vi: 'Tôi và anh ấy là bạn cùng lớp tiểu học.',
        explanation: '"和" nối hai đại từ nhân xưng "我" và "他".'
      }
    ]
  },
  {
    order_index: 31,
    name: 'Trợ từ kết cấu "的" chỉ sở hữu (领属性"的")',
    pattern: 'Người sở hữu + 的 + Vật sở hữu',
    category: 'Trợ từ',
    explanation_vi: '"的" (de) đặt giữa người sở hữu và vật sở hữu mang nghĩa là "của" (ví dụ: 我的书 - sách của tôi). LƯU Ý: Khi biểu thị mối quan hệ người thân ruột thịt (bố mẹ, anh chị) hoặc tổ chức gắn bó thân thiết (trường tôi, nước tôi), chữ "的" có thể lược bỏ (ví dụ: 我妈妈, 我家, 我们学校).',
    examples: [
      {
        chinese: '这是我爸爸的车，不是我的车。',
        pinyin: 'Zhè shì wǒ bàba de chē, bú shì wǒ de chē.',
        translation_vi: 'Đây là xe của bố tôi, không phải xe của tôi.',
        explanation: '"我爸爸" lược bỏ "的" vì là người thân, "爸爸的车" giữ "的" biểu thị sở hữu xe.'
      },
      {
        chinese: '请问这是谁的杯子？',
        pinyin: 'Qǐngwèn zhè shì shéi de bēizi?',
        translation_vi: 'Xin hỏi đây là cốc của ai vậy?',
        explanation: 'Hỏi quyền sở hữu đồ vật dùng "谁的".'
      }
    ]
  },
  {
    order_index: 32,
    name: 'Trợ từ kết cấu "的" nối định ngữ và trung tâm ngữ (修饰性"的")',
    pattern: 'Tính từ / Cụm miêu tả + 的 + Danh từ trung tâm',
    category: 'Trợ từ',
    explanation_vi: 'Khi một tính từ hai âm tiết, cụm tính từ hoặc cụm chủ vị đứng trước để miêu tả đặc điểm tính chất cho một danh từ đứng sau, bắt buộc phải dùng trợ từ kết cấu "的" làm cầu nối. Quy tắc: "Định ngữ + 的 + Trung tâm ngữ".',
    examples: [
      {
        chinese: '她是一个非常漂亮且热情的中国女孩。',
        pinyin: 'Tā shì yí gè fēicháng piàoliang qiě rèqíng de Zhōngguó nǚhái.',
        translation_vi: 'Cô ấy là một cô gái Trung Quốc vô cùng xinh đẹp và nhiệt tình.',
        explanation: 'Cụm miêu tả "漂亮且热情" bổ nghĩa cho danh từ "女孩" qua chữ "的".'
      },
      {
        chinese: '我想买一件白色的保暖衣服。',
        pinyin: 'Wǒ xiǎng mǎi yí jiàn báisè de bǎonuǎn yīfu.',
        translation_vi: 'Tôi muốn mua một chiếc áo ấm màu trắng.',
        explanation: '"白色" bổ nghĩa cho "衣服" qua chữ "的".'
      }
    ]
  },
  {
    order_index: 33,
    name: 'Trợ từ nghi vấn "吗" (吗字疑问句)',
    pattern: 'Câu trần thuật + 吗？',
    category: 'Trợ từ',
    explanation_vi: '"吗" (ma) là trợ từ nghi vấn đặt ở cuối câu trần thuật để biến câu đó thành câu hỏi Có/Không (Yes/No question). Câu trả lời chỉ cần nhắc lại động từ/tính từ khẳng định hoặc phủ định bằng "不 / 没".',
    examples: [
      {
        chinese: '你是河内大学的留学生吗？是的。',
        pinyin: 'Nǐ shì Hénèi Dàxué de liúxuéshēng ma? Shì de.',
        translation_vi: 'Bạn là du học sinh Đại học Hà Nội phải không? Đúng vậy.',
        explanation: 'Biến câu trần thuật thành câu hỏi xác nhận thân phận.'
      },
      {
        chinese: '你今天晚上有空儿吗？没有，我很忙。',
        pinyin: 'Nǐ jīntiān wǎnshang yǒu kòngr ma? Méiyǒu, wǒ hěn máng.',
        translation_vi: 'Tối nay bạn có rảnh không? Không có, tôi bận lắm.',
        explanation: 'Hỏi trạng thái rảnh rỗi và trả lời phủ định bằng "没有".'
      }
    ]
  },
  {
    order_index: 34,
    name: 'Trợ từ ngữ khí "呢" hỏi tỉnh lược (呢字省略问)',
    pattern: 'Danh từ / Đại từ + 呢？ (Thế còn...?) / Nơi chốn + 呢？ (Ở đâu?)',
    category: 'Trợ từ',
    explanation_vi: 'Trợ từ "呢" (ne) đặt sau danh từ hoặc đại từ có 2 công dụng lớn: 1. Câu hỏi tỉnh lược rút gọn dựa theo ngữ cảnh trước đó: "A thì... thế còn B đâu/thì sao?" (我喜欢吃苹果，你呢？). 2. Hỏi tìm kiếm vị trí của người hoặc vật: "Điện thoại của tôi đâu rồi?" (我的手机呢？).',
    examples: [
      {
        chinese: '我是越南人，你呢？我是中国人。',
        pinyin: 'Wǒ shì Yuènánrén, nǐ ne? Wǒ shì Zhōngguórén.',
        translation_vi: 'Tôi là người Việt Nam, thế còn bạn? Tôi là người Trung Quốc.',
        explanation: '"你呢？" kế thừa câu hỏi quốc tịch phía trước mà không cần lặp lại cả câu.'
      },
      {
        chinese: '妈妈，我的汉语书呢？在桌子上。',
        pinyin: 'Māma, wǒ de hànyǔ shū ne? Zài zhuōzi shang.',
        translation_vi: 'Mẹ ơi, sách tiếng Trung của con đâu rồi? Ở trên bàn kìa.',
        explanation: 'Dùng "呢" để hỏi vị trí đồ vật thất lạc.'
      }
    ]
  },
  {
    order_index: 35,
    name: 'Trợ từ ngữ khí "吧" đề nghị và thương lượng (吧字祈使句)',
    pattern: 'Câu đề xuất / rủ rê + 吧。',
    category: 'Trợ từ',
    explanation_vi: '"吧" (ba) đứng cuối câu biểu thị lời đề nghị, rủ rê, khuyên bảo hoặc thương lượng với ngữ điệu nhẹ nhàng, lịch sự ("...đi, ...nhé, ...nào"). Thường đi kèm với đại từ "我们" (chúng ta).',
    examples: [
      {
        chinese: '时间不早了，我们一起回家吧。',
        pinyin: 'Shíjiān bù zǎo le, wǒmen yìqǐ huíjiā ba.',
        translation_vi: 'Thời gian không còn sớm nữa, chúng ta cùng về nhà đi thôi.',
        explanation: '"我们...吧" là cấu trúc rủ rê thân thiện kinh điển.'
      },
      {
        chinese: '快点儿走吧，电影马上要开始了。',
        pinyin: 'Kuài diǎnr zǒu ba, diànyǐng mǎshàng yào kāishǐ le.',
        translation_vi: 'Đi nhanh lên nào, phim sắp sửa bắt đầu rồi đấy.',
        explanation: '"吧" làm dịu ngữ khí của câu mệnh lệnh thúc giục.'
      }
    ]
  },
  {
    order_index: 36,
    name: 'Trợ từ ngữ thái "了" biểu thị biến hóa trạng thái mới (句尾"了")',
    pattern: 'Chủ ngữ + V / Adj + 了。 (Biểu thị có sự thay đổi)',
    category: 'Trợ từ',
    explanation_vi: 'Chữ "了" (le) đặt ở CUỐI CÂU biểu thị sự phát sinh một trạng thái mới hoặc có sự thay đổi so với trước đây ("rồi"). Ví dụ: 下雨了 (trời mưa rồi - trước đó chưa mưa), 我有女朋友了 (tôi có bạn gái rồi).',
    examples: [
      {
        chinese: '秋天到了，树叶变黄了。',
        pinyin: 'Qiūtiān dào le, shùyè biàn huáng le.',
        translation_vi: 'Mùa thu đến rồi, lá cây chuyển sang màu vàng rồi.',
        explanation: '"了" ở cuối câu thể hiện sự thay đổi trạng thái của thời tiết và lá cây.'
      },
      {
        chinese: '我已经十八岁了，是一个大人了。',
        pinyin: 'Wǒ yǐjīng shíbā suì le, shì yí gè dàrén le.',
        translation_vi: 'Tôi đã mười tám tuổi rồi, là một người lớn rồi.',
        explanation: '"十八岁了" biểu thị số tuổi mới đạt được.'
      }
    ]
  },
  {
    order_index: 37,
    name: 'Trợ từ động thái "了" biểu thị hoàn thành hành động (动后"了")',
    pattern: 'Chủ ngữ + Động từ + 了 + (Số lượng/Định ngữ) + Tân ngữ',
    category: 'Trợ từ',
    explanation_vi: 'Chữ "了" đặt NGAY SAU ĐỘNG TỪ biểu thị hành động đó đã được thực hiện xong, hoàn thành hoặc hiện thực hóa. Nếu có tân ngữ đi kèm, tân ngữ thường có định ngữ, số lượng từ bổ nghĩa (ví dụ: 我买了一本书 - Tôi đã mua một quyển sách).',
    examples: [
      {
        chinese: '我今天下午在书店买了两本小说。',
        pinyin: 'Wǒ jīntiān xiàwǔ zài shūdiàn mǎi le liǎng běn xiǎoshuō.',
        translation_vi: 'Chiều nay tôi đã mua hai quyển tiểu thuyết ở hiệu sách.',
        explanation: '"买了" đứng ngay sau động từ "买", kết hợp với số lượng từ "两本".'
      },
      {
        chinese: '他喝了一杯热牛奶就睡觉了。',
        pinyin: 'Tā hē le yì bēi rè niúnǎi jiù shuìjiào le.',
        translation_vi: 'Anh ấy uống xong một cốc sữa nóng là đi ngủ ngay.',
        explanation: '"喝了" biểu thị hành động uống đã kết thúc trước khi ngủ.'
      }
    ]
  },
  {
    order_index: 38,
    name: 'Câu vị ngữ hình dung từ (形容词谓语句)',
    pattern: 'Chủ ngữ + (很 / 不) + Tính từ (Tuyệt đối KHÔNG có "是")',
    category: 'Cấu trúc câu',
    explanation_vi: 'LỖI PHỔ BIẾN NHẤT CỦA NGƯỜI VIỆT: Người Việt hay nói "Tôi là vui" -> dịch sang tiếng Trung thành "我是高兴" (SAI!). Trong tiếng Trung, tính từ trực tiếp làm vị ngữ, KHÔNG ĐƯỢC DÙNG "是". Câu chuẩn: "我很高兴" (Tôi rất vui) hoặc "天气很冷" (Trời rất lạnh).',
    examples: [
      {
        chinese: '今天天气很好，阳光明媚。',
        pinyin: 'Jīntiān tiānqì hěn hǎo, yángguāng míngmèi.',
        translation_vi: 'Hôm nay thời tiết rất đẹp, ánh nắng chan hòa.',
        explanation: '"天气很好", không dùng "天气是好".'
      },
      {
        chinese: '这里的苹果又大又甜，一点儿也不贵。',
        pinyin: 'Zhèlǐ de píngguǒ yòu dà yòu tián, yìdiǎnr yě bú guì.',
        translation_vi: 'Táo ở đây vừa to vừa ngọt, một chút cũng không đắt.',
        explanation: 'Tính từ "大", "甜", "贵" trực tiếp làm vị ngữ câu.'
      }
    ]
  },
  {
    order_index: 39,
    name: 'Câu vị ngữ danh từ (名词谓语句)',
    pattern: 'Chủ ngữ (thời gian/người) + Cụm danh từ (ngày tháng/tuổi/giá cả)',
    category: 'Cấu trúc câu',
    explanation_vi: 'Câu vị ngữ danh từ là câu mà vị ngữ do danh từ hoặc cụm danh từ trực tiếp đảm nhiệm mà không cần động từ "是". Thường dùng chuyên biệt để nói về: Ngày tháng, thứ, giờ giấc, tuổi tác, quê quán hoặc giá tiền.',
    examples: [
      {
        chinese: '今天星期天，明天星期一。',
        pinyin: 'Jīntiān xīngqītiān, míngtiān xīngqīyī.',
        translation_vi: 'Hôm nay là chủ nhật, ngày mai là thứ hai.',
        explanation: '"星期天" trực tiếp làm vị ngữ cho chủ ngữ "今天" không cần dùng "是".'
      },
      {
        chinese: '我弟弟今年十八岁。',
        pinyin: 'Wǒ dìdi jīnnián shíbā suì.',
        translation_vi: 'Em trai tôi năm nay 18 tuổi.',
        explanation: '"十八岁" làm vị ngữ danh từ biểu thị số tuổi.'
      }
    ]
  },
  {
    order_index: 40,
    name: 'Câu vị ngữ động từ cơ bản (动词谓语句: S + V + O)',
    pattern: 'Chủ ngữ + Trạng ngữ (thời gian/địa điểm) + Động từ + Tân ngữ',
    category: 'Cấu trúc câu',
    explanation_vi: 'Trật tự câu cơ bản của tiếng Trung là S-V-O tương tự tiếng Việt. Tuy nhiên, các trạng ngữ chỉ thời gian và nơi chốn BẮT BUỘC ĐỨNG TRƯỚC ĐỘNG TỪ (hoặc đứng đầu câu trước chủ ngữ), không được đặt bừa bãi ở cuối câu như tiếng Việt.',
    examples: [
      {
        chinese: '学生们每天上午在教室听课。',
        pinyin: 'Xuéshengmen měitiān shàngwǔ zài jiàoshì tīngkè.',
        translation_vi: 'Học sinh mỗi buổi sáng đều nghe giảng trong phòng học.',
        explanation: 'Trật tự chuẩn: Chủ ngữ (学生们) + Thời gian (每天上午) + Địa điểm (在教室) + Động từ (听课).'
      },
      {
        chinese: '我喜欢在周末听轻音乐。',
        pinyin: 'Wǒ xǐhuan zài zhōumò tīng qīngyīnyuè.',
        translation_vi: 'Tôi thích nghe nhạc nhẹ vào dịp cuối tuần.',
        explanation: 'Trạng từ thời gian "在周末" đặt trước động từ "听".'
      }
    ]
  },
  {
    order_index: 41,
    name: 'Câu liên động chỉ mục đích (连动句: 去 / 来 + Nơi chốn + V)',
    pattern: 'Chủ ngữ + 去 / 来 / 到 + Nơi chốn + Động từ mục đích',
    category: 'Cấu trúc câu',
    explanation_vi: 'Câu liên động là câu có từ hai động từ trở lên cùng chia sẻ một chủ ngữ. Trong HSK 1, dạng phổ biến nhất là dùng động từ chỉ di chuyển (去, 来, 到) đi kèm địa điểm, theo sau là động từ thứ hai chỉ mục đích ("Đi đâu để làm gì").',
    examples: [
      {
        chinese: '下午我想去中国银行换钱。',
        pinyin: 'Xiàwǔ wǒ xiǎng qù Zhōngguó Yínháng huànqián.',
        translation_vi: 'Buổi chiều tôi muốn đến Ngân hàng Trung Quốc đổi tiền.',
        explanation: 'Động từ 1: "去" (đến Ngân hàng Trung Quốc) -> Động từ 2: "换钱" (đổi tiền - mục đích).'
      },
      {
        chinese: '朋友晚上来我家吃饭。',
        pinyin: 'Péngyou wǎnshang lái wǒ jiā chīfàn.',
        translation_vi: 'Buổi tối bạn bè đến nhà tôi ăn cơm.',
        explanation: 'Động từ 1: "来我家" -> Động từ 2: "吃饭" (mục đích).'
      }
    ]
  },
  {
    order_index: 42,
    name: 'Câu có hai tân ngữ (双宾语句: 给 / 教 / 送)',
    pattern: 'Chủ ngữ + Động từ + Tân ngữ gián tiếp (Người) + Tân ngữ trực tiếp (Vật)',
    category: 'Cấu trúc câu',
    explanation_vi: 'Một số động từ mang ý nghĩa trao tặng, chuyển giao (như 给 - cho, 送 - tặng, 教 - dạy) có thể mang theo 2 tân ngữ: Tân ngữ 1 chỉ người nhận (tân ngữ gián tiếp) đứng trước, Tân ngữ 2 chỉ sự vật được trao nhận (tân ngữ trực tiếp) đứng sau.',
    examples: [
      {
        chinese: '老师每天教我们汉字和发音。',
        pinyin: 'Lǎoshī měitiān jiāo wǒmen hànzì hé fāyīn.',
        translation_vi: 'Thầy giáo mỗi ngày dạy chúng tôi chữ Hán và phát âm.',
        explanation: 'Tân ngữ 1: "我们" (người), Tân ngữ 2: "汉字和发音" (vật/nội dung).'
      },
      {
        chinese: '过生日时，朋友送我一本精美的画册。',
        pinyin: 'Guò shēngrì shí, péngyou sòng wǒ yì běn jīngměi de huàcè.',
        translation_vi: 'Dịp sinh nhật, bạn bè tặng tôi một cuốn tập tranh tinh xảo.',
        explanation: 'Tân ngữ 1: "我" (người), Tân ngữ 2: "一本精美的画册" (vật).'
      }
    ]
  },
  {
    order_index: 43,
    name: 'Câu hỏi chính phản (正反疑问句: V 不 V / Adj 不 Adj)',
    pattern: 'Chủ ngữ + Động từ + 不 + Động từ？ / Tính từ + 不 + Tính từ？',
    category: 'Câu hỏi',
    explanation_vi: 'Câu hỏi chính phản ghép hình thức khẳng định và phủ định của động từ/tính từ lại với nhau để tạo thành câu hỏi lựa chọn ("Có... hay không?"). Chú ý: ĐÃ DÙNG CÂU HỎI CHÍNH PHẢN THÌ TUYỆT ĐỐI KHÔNG DÙNG "吗" Ở CUỐI CÂU NỮA.',
    examples: [
      {
        chinese: '你想不想去中国旅游？想去。',
        pinyin: 'Nǐ xiǎng bù xiǎng qù Zhōngguó lǚyóu? Xiǎng qù.',
        translation_vi: 'Bạn có muốn đi du lịch Trung Quốc không? Muốn đi.',
        explanation: 'Ghép chính phản "想不想", không thêm "吗" ở cuối.'
      },
      {
        chinese: '这件衣服贵不贵？不贵，挺便宜的。',
        pinyin: 'Zhè jiàn yīfu guì bú guì? Bú guì, tǐng piányi de.',
        translation_vi: 'Bộ quần áo này có đắt không? Không đắt, khá rẻ.',
        explanation: 'Hỏi chính phản với tính từ "贵不贵".'
      }
    ]
  },
  {
    order_index: 44,
    name: 'Câu hỏi chính phản với "有没有" (有没有疑问句)',
    pattern: 'Chủ ngữ + 有没有 + Tân ngữ？ / Câu trần thuật + 没有？',
    category: 'Câu hỏi',
    explanation_vi: 'Hình thức chính phản của động từ "有" là "有没有" (yǒu méiyǒu), mang nghĩa "có... hay không?" hoặc "đã... chưa?". Khi đặt "没有" ở cuối câu trần thuật cũng tạo thành câu hỏi "đã làm gì chưa?".',
    examples: [
      {
        chinese: '请问你有没有中文词典？有，在书架上。',
        pinyin: 'Qǐngwèn nǐ yǒu méiyǒu zhōngwén cídiǎn? Yǒu, zài shūjià shang.',
        translation_vi: 'Xin hỏi bạn có từ điển tiếng Trung không? Có, ở trên giá sách.',
        explanation: 'Dùng "有没有" để hỏi về sự sở hữu đồ vật.'
      },
      {
        chinese: '你吃早饭了没有？还没吃呢。',
        pinyin: 'Nǐ chī zǎofàn le méiyǒu? Hái méi chī ne.',
        translation_vi: 'Bạn đã ăn bữa sáng chưa? Vẫn chưa ăn.',
        explanation: '"...了没有？" dùng để hỏi hành động đã hoàn thành chưa.'
      }
    ]
  },
  {
    order_index: 45,
    name: 'Câu hỏi lựa chọn "还是" (选择疑问句)',
    pattern: 'Lựa chọn A + 还是 + Lựa chọn B？',
    category: 'Câu hỏi',
    explanation_vi: '"还是" (háishì) dùng trong CÂU HỎI để đưa ra hai hay nhiều phương án cho người nghe lựa chọn ("hay là / hoặc là?"). Phân biệt: "还是" dùng trong câu hỏi, còn "或者" (huòzhě) dùng trong câu trần thuật khẳng định.',
    examples: [
      {
        chinese: '你想喝热茶还是冰咖啡？我想喝热茶。',
        pinyin: 'Nǐ xiǎng hē rèchá háishì bīng kāfēi? Wǒ xiǎng hē rèchá.',
        translation_vi: 'Bạn muốn uống trà nóng hay là cà phê đá? Tôi muốn uống trà nóng.',
        explanation: 'Đưa ra hai đồ uống để người nghe chọn lựa.'
      },
      {
        chinese: '我们今天坐公交车还是坐地铁去？',
        pinyin: 'Wǒmen jīntiān zuò gōngjiāochē háishì zuò dìtiě qù?',
        translation_vi: 'Hôm nay chúng ta đi xe buýt hay là đi tàu điện ngầm?',
        explanation: 'Lựa chọn phương tiện giao thông di chuyển.'
      }
    ]
  },
  {
    order_index: 46,
    name: 'Quy tắc diễn đạt Ngày, Tháng, Năm (年月日表达法)',
    pattern: 'Năm (年) + Tháng (月) + Ngày (日 / 号) + Thứ (星期)',
    category: 'Quy tắc biểu đạt',
    explanation_vi: 'Quy tắc tư duy thời gian trong tiếng Trung là ĐI TỪ LỚN ĐẾN NHỎ (ngược hoàn toàn với tiếng Việt): Năm -> Tháng -> Ngày -> Thứ. Trong văn viết dùng "日" (rì), trong khẩu ngữ nói hàng ngày thường dùng "号" (hào).',
    examples: [
      {
        chinese: '今天是二零二六年十月二十三号，星期五。',
        pinyin: 'Jīntiān shì èr líng èr liù nián shí yuè èrshísān hào, xīngqīwǔ.',
        translation_vi: 'Hôm nay là thứ Sáu, ngày 23 tháng 10 năm 2026.',
        explanation: 'Thứ tự chuẩn: Năm (2026) -> Tháng (10) -> Ngày (23) -> Thứ (Thứ Sáu).'
      },
      {
        chinese: '明天是他的生日，五月八号。',
        pinyin: 'Míngtiān shì tā de shēngrì, wǔ yuè bā hào.',
        translation_vi: 'Ngày mai là sinh nhật của anh ấy, ngày 8 tháng 5.',
        explanation: 'Khẩu ngữ nói ngày sinh nhật dùng "号".'
      }
    ]
  },
  {
    order_index: 47,
    name: 'Quy tắc diễn đạt Giờ giấc và Thời điểm (时间表达法)',
    pattern: 'Buổi trong ngày + ...点 (giờ) + ...分 (phút) / 半 (rưỡi)',
    category: 'Quy tắc biểu đạt',
    explanation_vi: 'Tương tự ngày tháng, thời gian trong ngày cũng đi từ đơn vị lớn đến nhỏ: Buổi (上午, 下午, 晚上) -> Giờ (点) -> Phút (分). "半" (bàn) dùng chỉ 30 phút (rưỡi). Trạng ngữ thời gian luôn đứng trước động từ trong câu.',
    examples: [
      {
        chinese: '我们每天上午八点半开始上课。',
        pinyin: 'Wǒmen měitiān shàngwǔ bā diǎn bàn kāishǐ shàngkè.',
        translation_vi: 'Chúng tôi mỗi sáng bắt đầu vào lớp lúc 8 giờ rưỡi.',
        explanation: 'Thứ tự: 上午 (buổi sáng) -> 八点 (8 giờ) -> 半 (30 phút) đứng trước động từ "开始上课".'
      },
      {
        chinese: '现在正好是下午三点十五分。',
        pinyin: 'Xiànzài zhènghǎo shì xiàwǔ sān diǎn shíwǔ fēn.',
        translation_vi: 'Bây giờ đúng lúc là 3 giờ 15 phút chiều.',
        explanation: '"点" chỉ giờ, "分" chỉ phút.'
      }
    ]
  },
  {
    order_index: 48,
    name: 'Các mẫu câu giao tiếp nghi thức xã giao cơ bản (日常交际用语)',
    pattern: '你好 / 谢谢 / 不客气 / 对不起 / 没关系 / 再见',
    category: 'Quy tắc biểu đạt',
    explanation_vi: 'Hệ thống các cặp câu giao tiếp lễ nghi lịch sự thông dụng nhất: 1. Chào hỏi: 你好 (chào bạn), 你们好 (chào các bạn), 老师好 (chào thầy/cô). 2. Cảm ơn & Đáp lại: 谢谢 -> 不客气 / 不用谢. 3. Xin lỗi & Thứ lỗi: 对不起 -> 没关系. 4. Chào tạm biệt: 再见.',
    examples: [
      {
        chinese: '非常感谢你的热情帮助！不客气，应该的。',
        pinyin: 'Fēicháng gǎnxiè nǐ de rèqíng bāngzhù! Bú kèqi, yīnggāi de.',
        translation_vi: 'Vô cùng cảm ơn sự giúp đỡ nhiệt tình của bạn! Không có chi, việc nên làm mà.',
        explanation: 'Cặp đối thoại cảm ơn và đáp từ lịch sự chuẩn mực.'
      },
      {
        chinese: '对不起，我来晚了。没关系，快请进。',
        pinyin: 'Duìbuqǐ, wǒ lái wǎn le. Méi guānxi, kuài qǐng jìn.',
        translation_vi: 'Xin lỗi, tôi đến muộn rồi. Không sao đâu, xin mời vào nhanh.',
        explanation: 'Cặp đối thoại xin lỗi và an ủi thứ lỗi.'
      }
    ]
  }
];

console.log(`Đã chuẩn bị ${HSK1_GRAMMAR_POINTS.length} điểm ngữ pháp HSK 1.`);

// 1. Tạo file TypeScript: data/hsk1-grammar-48-data.ts
const tsFilePath = 'data/hsk1-grammar-48-data.ts';
let tsContent = `// ==============================================================================
// 48 ĐIỂM NGỮ PHÁP CHUẨN HSK 1 THEO TIÊU CHUẨN GF 0025-2021
// 《国际中文教育中文水平等级标准》- 一级语法大纲
// Kèm giải thích chi tiết tiếng Việt và các câu ví dụ thực tế có Pinyin và dịch nghĩa
// ==============================================================================

export interface GrammarExampleItem {
  chinese: string;
  pinyin: string;
  translation_vi: string;
  explanation: string;
}

export interface GrammarPointItem {
  order_index: number;
  name: string;
  pattern: string;
  category: string;
  explanation_vi: string;
  hsk_level: string;
  examples: GrammarExampleItem[];
}

export const HSK1_GRAMMAR_POINTS_DATA: GrammarPointItem[] = ${JSON.stringify(HSK1_GRAMMAR_POINTS.map(gp => ({ ...gp, hsk_level: 'HSK 1' })), null, 2)};
`;

fs.writeFileSync(tsFilePath, tsContent, 'utf8');
console.log(`Đã tạo thành công ${tsFilePath}!`);

// 2. Tạo SQL Migration & Rollback
const migrationTimestamp = '20261023210000';
const migrationPath = `supabase/migrations/${migrationTimestamp}_hsk1_grammar_48_seed.sql`;
const rollbackPath = `supabase/migrations/rollbacks/${migrationTimestamp}_hsk1_grammar_48_seed_rollback.sql`;

let sql = `-- ==============================================================================
-- MIGRATION: ${migrationTimestamp}_hsk1_grammar_48_seed.sql
-- MỤC TIÊU:
-- 1. Mở rộng cấu trúc bảng grammar_points (bổ sung hsk_level, category, order_index)
-- 2. Nạp toàn bộ 48 điểm ngữ pháp HSK 1 chuẩn theo tiêu chuẩn GF 0025-2021
-- 3. Nạp hơn 100 câu ví dụ ngữ pháp kèm Pinyin và giải nghĩa tiếng Việt chi tiết
-- ==============================================================================

BEGIN;

-- 1. Nâng cấp schema bảng grammar_points nếu chưa có các cột quản lý cấp độ
ALTER TABLE public.grammar_points
  ADD COLUMN IF NOT EXISTS hsk_level text DEFAULT 'HSK 1',
  ADD COLUMN IF NOT EXISTS category text DEFAULT 'Ngữ pháp cơ bản',
  ADD COLUMN IF NOT EXISTS order_index integer DEFAULT 1,
  ADD COLUMN IF NOT EXISTS source text DEFAULT 'gf0025_2021',
  ADD COLUMN IF NOT EXISTS validation_status text DEFAULT 'verified';

CREATE INDEX IF NOT EXISTS idx_grammar_points_level ON public.grammar_points(hsk_level);
CREATE INDEX IF NOT EXISTS idx_grammar_points_order ON public.grammar_points(order_index);

-- 2. Nạp dữ liệu 48 điểm ngữ pháp HSK 1 kèm câu ví dụ
DO $$
DECLARE
  v_gp_id uuid;
BEGIN
`;

for (const gp of HSK1_GRAMMAR_POINTS) {
  sql += `
  -- Điểm ngữ pháp #${gp.order_index}: ${gp.name}
  INSERT INTO public.grammar_points (name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status)
  VALUES (
    ${escapeSql(gp.name)},
    ${escapeSql(gp.pattern)},
    ${escapeSql(gp.category)},
    ${escapeSql(gp.explanation_vi)},
    'HSK 1',
    ${gp.order_index},
    'gf0025_2021',
    'verified'
  )
  RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (grammar_point_id, chinese, pinyin, translation_vi, explanation)
  VALUES
`;
  const exTuples = gp.examples.map(ex => `    (
      v_gp_id,
      ${escapeSql(ex.chinese)},
      ${escapeSql(ex.pinyin)},
      ${escapeSql(ex.translation_vi)},
      ${escapeSql(ex.explanation)}
    )`);
  sql += exTuples.join(',\n') + ';\n';
}

sql += `
END $$;

COMMIT;
`;

fs.writeFileSync(migrationPath, sql, 'utf8');
console.log(`Đã tạo thành công Migration SQL: ${migrationPath} (${(fs.statSync(migrationPath).size / 1024).toFixed(1)} KB)`);

// Rollback SQL
let rollbackSql = `-- ==============================================================================
-- ROLLBACK: ${migrationTimestamp}_hsk1_grammar_48_seed_rollback.sql
-- Hoàn tác nạp 48 điểm ngữ pháp HSK 1
-- ==============================================================================

BEGIN;

-- Xóa dữ liệu các điểm ngữ pháp HSK 1 thuộc nguồn gf0025_2021 (các câu ví dụ tự động cascade theo foreign key)
DELETE FROM public.grammar_points
WHERE hsk_level = 'HSK 1'
  AND source = 'gf0025_2021';

COMMIT;
`;

fs.writeFileSync(rollbackPath, rollbackSql, 'utf8');
console.log(`Đã tạo thành công Rollback SQL: ${rollbackPath}`);
