// ==============================================================================
// KHO DỮ LIỆU NGỮ PHÁP HSK 1 - 6 CHUẨN GF 0025-2021 (BỘ GIÁO DỤC TRUNG QUỐC)
// TỔNG CỘNG: 542 ĐIỂM NGỮ PHÁP KÈM 1.084 CÂU VÍ DỤ SONG NGỮ
// ==============================================================================

export interface GrammarExampleItem {
  chinese: string
  pinyin: string
  translation_vi: string
  explanation?: string
}

export interface GrammarPointItem {
  id?: string
  order_index: number
  name: string
  pattern: string
  category: string
  explanation_vi: string
  hsk_level?: string
  source?: string
  validation_status?: string
  examples: GrammarExampleItem[]
}

export const ALL_HSK_GRAMMAR_DATA: Record<string, GrammarPointItem[]> = {
  "HSK 1": [
    {
      "order_index": 1,
      "name": "Đại từ nhân xưng (人称代词)",
      "pattern": "我 / 你 / 他 / 她 / 我们 / 你们 / 他们 / 她们",
      "category": "Đại từ",
      "explanation_vi": "Đại từ nhân xưng dùng để xưng hô chỉ người. Số ít gồm: 我 (tôi), 你 (bạn), 他 (anh ấy - nam), 她 (cô ấy - nữ). Để tạo số nhiều, chỉ cần thêm hậu tố \"们\" (men) vào sau: 我们 (chúng tôi), 你们 (các bạn), 他们 (họ - nam hoặc chung), 她们 (họ - toàn nữ).",
      "examples": [
        {
          "chinese": "我是越南人，他是中国人。",
          "pinyin": "Wǒ shì Yuènánrén, tā shì Zhōngguórén.",
          "translation_vi": "Tôi là người Việt Nam, anh ấy là người Trung Quốc.",
          "explanation": "Sử dụng đại từ \"我\" (tôi) và \"他\" (anh ấy) làm chủ ngữ trong câu phán đoán."
        },
        {
          "chinese": "我们都是汉语班的同学生。",
          "pinyin": "Wǒmen dōu shì hànyǔ bān de tóngxué.",
          "translation_vi": "Chúng tôi đều là bạn học cùng lớp tiếng Trung.",
          "explanation": "\"我们\" biểu thị ngôi thứ nhất số nhiều (chúng tôi), kết hợp với phó từ \"都\" (đều)."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 2,
      "name": "Đại từ chỉ thị (指示代词: 这 / 那)",
      "pattern": "这 (này/đây) / 那 (kia/đó) + (Lượng từ) + Danh từ",
      "category": "Đại từ",
      "explanation_vi": "\"这\" (zhè) chỉ người hoặc vật ở cự ly gần người nói (đây/này). \"那\" (nà) chỉ người hoặc vật ở cự ly xa người nói (kia/đó). Khi kết hợp với danh từ đếm được, thường phải thêm lượng từ ở giữa (这 + Lượng từ + Danh từ).",
      "examples": [
        {
          "chinese": "这是我的汉语老师。",
          "pinyin": "Zhè shì wǒ de hànyǔ lǎoshī.",
          "translation_vi": "Đây là giáo viên tiếng Trung của tôi.",
          "explanation": "\"这\" làm chủ ngữ đứng đầu câu để giới thiệu người ở gần."
        },
        {
          "chinese": "那本书不是我的，是他买的。",
          "pinyin": "Nà běn shū bú shì wǒ de, shì tā mǎi de.",
          "translation_vi": "Quyển sách kia không phải của tôi, là của anh ấy mua.",
          "explanation": "\"那\" kết hợp với lượng từ \"本\" trước danh từ \"书\" để chỉ quyển sách ở xa."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 3,
      "name": "Đại từ chỉ nơi chốn (这儿 / 那儿 / 哪儿)",
      "pattern": "这儿 (ở đây) / 那儿 (ở kia) / 哪儿 (ở đâu)",
      "category": "Đại từ",
      "explanation_vi": "Thêm âm uốn lưỡi \"儿\" (hoặc \"里\") vào sau đại từ chỉ thị để tạo thành đại từ chỉ nơi chốn: 这儿/这里 (chỗ này, ở đây), 那儿/那里 (chỗ kia, ở đó). Từ nghi vấn để hỏi nơi chốn là 哪儿/哪里 (ở đâu?).",
      "examples": [
        {
          "chinese": "我在这儿等你，你快来吧。",
          "pinyin": "Wǒ zài zhèr děng nǐ, nǐ kuài lái ba.",
          "translation_vi": "Tôi đợi bạn ở đây, bạn đến mau nhé.",
          "explanation": "\"这儿\" chỉ vị trí người nói đang đứng."
        },
        {
          "chinese": "你的手机在哪儿？在桌子上。",
          "pinyin": "Nǐ de shǒujī zài nǎr? Zài zhuōzi shang.",
          "translation_vi": "Điện thoại của bạn ở đâu? Ở trên bàn.",
          "explanation": "\"哪儿\" dùng trong câu hỏi vị trí nơi chốn."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 4,
      "name": "Đại từ nghi vấn \"谁\" (Hỏi người: Ai?)",
      "pattern": "谁 + V...? / S + 是 + 谁？",
      "category": "Đại từ",
      "explanation_vi": "\"谁\" (shéi hoặc shuí) dùng để hỏi về người (\"ai?\"). Trong tiếng Trung, vị trí của đại từ nghi vấn đặt đúng vào vị trí của thành phần cần hỏi trong câu trần thuật, không cần đảo ngữ ra đầu câu như tiếng Anh.",
      "examples": [
        {
          "chinese": "那个高个子的男生是谁？",
          "pinyin": "Nà gè gāo gèzi de nánshēng shì shéi?",
          "translation_vi": "Bạn nam dáng người cao kia là ai vậy?",
          "explanation": "\"谁\" đóng vai trò vị ngữ trong câu chữ \"是\"."
        },
        {
          "chinese": "今天谁去超市买水果？",
          "pinyin": "Jīntiān shéi qù chāoshì mǎi shuǐguǒ?",
          "translation_vi": "Hôm nay ai đi siêu thị mua hoa quả?",
          "explanation": "\"谁\" đóng vai trò chủ ngữ hỏi người thực hiện hành động."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 5,
      "name": "Đại từ nghi vấn \"什么\" (Hỏi vật: Cái gì / Gì?)",
      "pattern": "V + 什么？ / 什么 + Danh từ？",
      "category": "Đại từ",
      "explanation_vi": "\"什么\" (shénme) dùng để hỏi về đồ vật, sự việc (\"cái gì?\"). Khi đứng trước danh từ, nó mang nghĩa \"gì / nào\" (ví dụ: 什么书 - sách gì, 什么名字 - tên gì, 什么时候 - khi nào).",
      "examples": [
        {
          "chinese": "你在看什么书呢？",
          "pinyin": "Nǐ zài kàn shénme shū ne?",
          "translation_vi": "Bạn đang đọc sách gì thế?",
          "explanation": "\"什么\" bổ nghĩa cho danh từ \"书\" hỏi tên loại sách."
        },
        {
          "chinese": "请问，你叫什么名字？",
          "pinyin": "Qǐngwèn, nǐ jiào shénme míngzi?",
          "translation_vi": "Xin hỏi, bạn tên là gì?",
          "explanation": "Mẫu câu chào hỏi cơ bản nhất hỏi tên người."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 6,
      "name": "Đại từ nghi vấn \"哪\" (Hỏi lựa chọn: Nào?)",
      "pattern": "哪 + Lượng từ + Danh từ？ / 哪国人？",
      "category": "Đại từ",
      "explanation_vi": "\"哪\" (nǎ) dùng để hỏi về sự lựa chọn (\"nào?\"). Thường dùng theo công thức: \"哪 + Lượng từ + Danh từ\" (ví dụ: 哪本书 - quyển sách nào, 哪个杯子 - cái cốc nào) hoặc hỏi quốc tịch: \"哪国人\" (người nước nào).",
      "examples": [
        {
          "chinese": "请问你是哪国人？我是法国人。",
          "pinyin": "Qǐngwèn nǐ shì nǎ guó rén? Wǒ shì Fǎguórén.",
          "translation_vi": "Xin hỏi bạn là người nước nào? Tôi là người Pháp.",
          "explanation": "\"哪国人\" là cấu trúc tiêu chuẩn để hỏi quốc tịch."
        },
        {
          "chinese": "你想买哪件衣服？",
          "pinyin": "Nǐ xiǎng mǎi nǎ jiàn yīfu?",
          "translation_vi": "Bạn muốn mua bộ quần áo nào?",
          "explanation": "\"哪 + 件 (lượng từ) + 衣服\" hỏi sự lựa chọn cụ thể."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 7,
      "name": "Đại từ nghi vấn \"几\" và \"多少\" (Hỏi số lượng: Mấy & Bao nhiêu)",
      "pattern": "几 + Lượng từ + N (dưới 10) / 多少 + (Lượng từ) + N (trên 10)",
      "category": "Đại từ",
      "explanation_vi": "\"几\" (jǐ) dùng khi ước chừng số lượng ít (dưới 10) và bắt buộc phải có lượng từ đi kèm (几个人, 几本书). \"多少\" (duōshao) dùng khi số lượng nhiều (trên 10) hoặc không giới hạn, lượng từ có thể có hoặc không (多少钱, 多少(个)学生).",
      "examples": [
        {
          "chinese": "你家里有几口人？我家有四口人。",
          "pinyin": "Nǐ jiā lǐ yǒu jǐ kǒu rén? Wǒ jiā yǒu sì kǒu rén.",
          "translation_vi": "Nhà bạn có mấy người? Nhà tôi có bốn người.",
          "explanation": "Hỏi thành viên gia đình dưới 10 người dùng \"几\" kèm lượng từ \"口\"."
        },
        {
          "chinese": "请问这件黑色大衣多少钱？",
          "pinyin": "Qǐngwèn zhè jiàn hēisè dàyī duōshao qián?",
          "translation_vi": "Xin hỏi chiếc áo khoác đen này bao nhiêu tiền?",
          "explanation": "Hỏi giá tiền dùng \"多少钱\", không dùng \"几钱\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 8,
      "name": "Đại từ nghi vấn \"怎么\" (Hỏi phương thức / nguyên nhân: Thế nào / Làm sao)",
      "pattern": "怎么 + Động từ？ (Hỏi cách làm) / 怎么了？ (Hỏi tình hình)",
      "category": "Đại từ",
      "explanation_vi": "\"怎么\" (zěnme) đứng trước động từ để hỏi về cách thức tiến hành hành động (\"làm như thế nào?\"). Cụm \"怎么了\" dùng để hỏi thăm tình hình khi thấy ai đó có biểu hiện bất thường (\"Sao thế? Có chuyện gì vậy?\").",
      "examples": [
        {
          "chinese": "请问这个汉字怎么读？",
          "pinyin": "Qǐngwèn zhè gè hànzì zěnme dú?",
          "translation_vi": "Xin hỏi chữ Hán này đọc như thế nào?",
          "explanation": "\"怎么读\" hỏi phương thức phát âm của chữ Hán."
        },
        {
          "chinese": "你今天怎么没来上课？",
          "pinyin": "Nǐ jīntiān zěnme méi lái shàngkè?",
          "translation_vi": "Hôm nay làm sao mà bạn không đến lớp học?",
          "explanation": "\"怎么\" dùng hỏi nguyên nhân với sắc thái ngạc nhiên nhẹ."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 9,
      "name": "Đại từ nghi vấn \"怎么样\" (Hỏi tính chất / Ý kiến: Như thế nào)",
      "pattern": "Chủ ngữ + 怎么样？ / ..., 怎么样？",
      "category": "Đại từ",
      "explanation_vi": "\"怎么样\" (zěnmeyàng) dùng để hỏi về tính chất, tình trạng của người/sự vật (\"thế nào?\"), hoặc đặt ở cuối câu để thăm dò ý kiến, rủ rê đề nghị (\"...thì thế nào? Có được không?\").",
      "examples": [
        {
          "chinese": "你最近工作怎么样？挺忙的。",
          "pinyin": "Nǐ zuìjìn gōngzuò zěnmeyàng? Tǐng máng de.",
          "translation_vi": "Dạo này công việc của bạn thế nào? Khá bận rộn.",
          "explanation": "Dùng hỏi về tình hình, trạng thái công việc gần đây."
        },
        {
          "chinese": "我们明天下午去喝咖啡，怎么样？",
          "pinyin": "Wǒmen míngtiān xiàwǔ qù hē kāfēi, zěnmeyàng?",
          "translation_vi": "Chiều mai chúng ta đi uống cà phê nhé, thấy thế nào?",
          "explanation": "Đặt ở cuối câu để tham khảo ý kiến người nghe."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 10,
      "name": "Số từ cơ bản và cách đọc số đếm (数词 0 - 100)",
      "pattern": "零, 一, 二, 三, 四, 五, 六, 七, 八, 九, 十 ... 百",
      "category": "Số từ",
      "explanation_vi": "Quy tắc ghép số tiếng Trung: Hàng chục ghép từ \"十\" (10) đến \"九十九\" (99): 11 là 十一, 20 là 二十, 25 là 二十五. Số 100 là 一百 (yìbǎi). Khi đọc số phòng hoặc số điện thoại, số \"1\" thường đọc chệch thành \"yāo\" (yêu) để tránh nhầm với \"7\" (qī).",
      "examples": [
        {
          "chinese": "我的房间号码是三零一号。",
          "pinyin": "Wǒ de fángjiān hàomǎ shì sān líng yāo hào.",
          "translation_vi": "Số phòng của tôi là phòng số 301.",
          "explanation": "Số 1 trong số phòng được đọc là \"yāo\", số 0 đọc là \"líng\"."
        },
        {
          "chinese": "我们学校有八十五位中国留学生。",
          "pinyin": "Wǒmen xuéxiào yǒu bāshíwǔ wèi Zhōngguó liúxuéshēng.",
          "translation_vi": "Trường chúng tôi có 85 bạn du học sinh Trung Quốc.",
          "explanation": "Số đếm \"八十五\" ghép từ 八 (8) + 十 (10) + 五 (5)."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 11,
      "name": "Lượng từ thông dụng \"个\" (个字量词)",
      "pattern": "Số từ / Đại từ + 个 + Danh từ",
      "category": "Lượng từ",
      "explanation_vi": "\"个\" (ge) là lượng từ phổ biến và đa năng nhất trong tiếng Trung. Nó dùng cho người (一个人), đồ vật không có lượng từ riêng hoặc lượng từ thông dụng trong sinh hoạt (一个苹果, 一个月, 这个问题). Thường phát âm thanh nhẹ.",
      "examples": [
        {
          "chinese": "我今天在超市买了三个大苹果。",
          "pinyin": "Wǒ jīntiān zài chāoshì mǎi le sān gè dà píngguǒ.",
          "translation_vi": "Hôm nay tôi đã mua ba quả táo lớn ở siêu thị.",
          "explanation": "\"个\" làm lượng từ cho danh từ hoa quả \"苹果\"."
        },
        {
          "chinese": "这个月我们班来了两位新同学。",
          "pinyin": "Zhè gè yuè wǒmen bān lái le liǎng wèi xīn tóngxué.",
          "translation_vi": "Tháng này lớp chúng tôi có thêm hai bạn học sinh mới.",
          "explanation": "\"这个月\" (tháng này) sử dụng \"个\" làm lượng từ cho \"月\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 12,
      "name": "Lượng từ chuyên dụng cơ bản: 本, 张, 只, 件, 杯",
      "pattern": "Số từ + 本 (sách) / 张 (bề mặt phẳng) / 只 (động vật) / 件 (áo) / 杯 (cốc) + Danh từ",
      "category": "Lượng từ",
      "explanation_vi": "Tiếng Trung có lượng từ riêng cho từng nhóm đồ vật có hình dáng đặc thù: \"本\" (běn) cho sách vở có gáy, \"张\" (zhāng) cho vật bề mặt phẳng mỏng như bàn, giấy, vé, giường; \"只\" (zhī) cho động vật nhỏ hoặc một bên trong cặp; \"件\" (jiàn) cho áo, sự việc; \"杯\" (bēi) cho cốc, ly đồ uống.",
      "examples": [
        {
          "chinese": "桌子上有两本新汉语词典。",
          "pinyin": "Zhuōzi shang yǒu liǎng běn xīn hànyǔ cídiǎn.",
          "translation_vi": "Trên bàn có hai quyển từ điển tiếng Trung mới.",
          "explanation": "Dùng lượng từ \"本\" cho sách và từ điển (chú ý số 2 dùng \"两\")."
        },
        {
          "chinese": "服务员，请给我来一杯热绿茶。",
          "pinyin": "Fúwùyuán, qǐng gěi wǒ lái yì bēi rè lǜchá.",
          "translation_vi": "Phục vụ ơi, xin cho tôi một tách trà xanh nóng.",
          "explanation": "\"杯\" vừa là danh từ cái cốc, vừa đóng vai trò lượng từ đo lường đồ uống."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 13,
      "name": "Lượng từ đo lường thời gian: 岁, 年, 天, 星期, 分钟",
      "pattern": "Số từ + 岁 (tuổi) / 年 (năm) / 天 (ngày) / 星期 (tuần)",
      "category": "Lượng từ",
      "explanation_vi": "Trong tiếng Trung, \"年\" (năm) và \"天\" (ngày) vừa là danh từ vừa kiêm lượng từ, đứng trực tiếp sau số từ không cần chèn \"个\" (ví dụ: 一天, 三年). Ngược lại, \"星期\" (tuần) và \"月\" (tháng) khi nói về số lượng khoảng thời gian bắt buộc phải có lượng từ \"个\" (ví dụ: 一个星期, 三个月). \"岁\" dùng sau số từ để biểu thị tuổi tác.",
      "examples": [
        {
          "chinese": "李老师的女儿今年刚好五岁了。",
          "pinyin": "Lǐ lǎoshī de nǚ'ér jīnnián gānghǎo wǔ suì le.",
          "translation_vi": "Con gái của thầy Lý năm nay vừa tròn năm tuổi rồi.",
          "explanation": "\"岁\" làm lượng từ chỉ số tuổi sau số từ \"五\"."
        },
        {
          "chinese": "他在北京大学学习了整整两年汉语。",
          "pinyin": "Tā zài Běijīng Dàxué xuéxí le zhěngzhěng liǎng nián hànyǔ.",
          "translation_vi": "Anh ấy đã học tiếng Trung tại Đại học Bắc Kinh tròn hai năm.",
          "explanation": "\"两年\" đi trực tiếp với số từ \"两\", không nói \"两个年\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 14,
      "name": "Phó từ phủ định \"不\" (不字否定)",
      "pattern": "不 + Động từ / Tính từ",
      "category": "Phó từ",
      "explanation_vi": "\"不\" (bù) dùng để phủ định hành động ở hiện tại, tương lai, thói quen thường nhật, hoặc phủ định tính chất của tính từ. Mang tính chủ quan của người nói (\"không muốn, không làm\"). Lưu ý biến điệu: \"不\" đọc thanh 2 (bú) khi đứng trước từ mang thanh 4.",
      "examples": [
        {
          "chinese": "我今天身体不舒服，不想去上班。",
          "pinyin": "Wǒ jīntiān shēntǐ bù shūfu, bù xiǎng qù shàngbān.",
          "translation_vi": "Hôm nay người tôi không khỏe, không muốn đi làm.",
          "explanation": "\"不\" phủ định tính từ \"舒服\" và động từ năng nguyện \"想\"."
        },
        {
          "chinese": "他是韩国人，不是日本留学生。",
          "pinyin": "Tā shì Hánguórén, bú shì Rìběn liúxuéshēng.",
          "translation_vi": "Anh ấy là người Hàn Quốc, không phải du học sinh Nhật Bản.",
          "explanation": "\"不\" đứng trước \"是\" (thanh 4) biến điệu đọc thành \"bú shì\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 15,
      "name": "Phó từ phủ định \"没 / 没有\" (没字否定)",
      "pattern": "没 / 没有 + Động từ / Danh từ",
      "category": "Phó từ",
      "explanation_vi": "\"没\" hoặc \"没有\" (méiyǒu) dùng để: 1. Phủ định sở hữu (\"không có gì\": 没有钱, 没有时间). 2. Phủ định hành động chưa xảy ra hoặc chưa hoàn thành trong quá khứ (\"chưa làm gì\"). Tuyệt đối không dùng \"不\" để phủ định cho \"有\" (không có \"不有\").",
      "examples": [
        {
          "chinese": "我昨天感冒了，没有去学校上课。",
          "pinyin": "Wǒ zuótiān gǎnmào le, méiyǒu qù xuéxiào shàngkè.",
          "translation_vi": "Hôm qua tôi bị cảm cúm, không đi học ở trường.",
          "explanation": "\"没有去\" phủ định hành động trong quá khứ ngày hôm qua."
        },
        {
          "chinese": "书包里只有书本，没有钱包。",
          "pinyin": "Shūbāo lǐ zhǐyǒu shūběn, méiyǒu qiánbāo.",
          "translation_vi": "Trong cặp sách chỉ có sách vở, không có ví tiền.",
          "explanation": "\"没有\" biểu thị sự không tồn tại/không sở hữu ví tiền."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 16,
      "name": "Phó từ mức độ \"很\" (很字副词)",
      "pattern": "S + 很 + Tính từ",
      "category": "Phó từ",
      "explanation_vi": "\"很\" (hěn) là phó từ chỉ mức độ (\"rất\"). Trong câu vị ngữ tính từ tiếng Trung, \"很\" thường được thêm vào trước tính từ như một từ nối ngữ pháp đệm để câu không bị cộc lốc, khi đó nghĩa \"rất\" bị mờ nhạt đi và không cần dịch ra tiếng Việt.",
      "examples": [
        {
          "chinese": "汉语虽然声调难，但是汉字很有趣。",
          "pinyin": "Hànyǔ suīrán shēngdiào nán, dànshì hànzì hěn yǒuqù.",
          "translation_vi": "Tiếng Trung tuy thanh điệu khó, nhưng chữ Hán rất thú vị.",
          "explanation": "\"很有趣\" dùng \"很\" đứng trước tính từ biểu thị mức độ cao."
        },
        {
          "chinese": "我今天工作很忙。",
          "pinyin": "Wǒ jīntiān gōngzuò hěn máng.",
          "translation_vi": "Hôm nay công việc của tôi (rất) bận.",
          "explanation": "\"很\" đóng vai trò liên kết ngữ pháp đệm trước tính từ \"忙\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 17,
      "name": "Cấu trúc cảm thán \"太...了\" (太字结构)",
      "pattern": "太 + Tính từ / Tâm lý động từ + 了",
      "category": "Phó từ",
      "explanation_vi": "Cấu trúc \"太...了\" (tài... le) dùng để biểu thị mức độ cực cao hoặc cảm thán (\"quá... rồi!\"). Khi ở thể phủ định \"不太...\" thì bỏ \"了\", mang nghĩa \"không... lắm\" (ví dụ: 不太好 - không tốt lắm).",
      "examples": [
        {
          "chinese": "北京烤鸭的味道太好吃了！",
          "pinyin": "Běijīng kǎoyā de wèidao tài hǎochī le!",
          "translation_vi": "Mùi vị của món vịt quay Bắc Kinh quá ngon rồi!",
          "explanation": "Biểu thị ngữ khí khen ngợi cảm thán cao độ."
        },
        {
          "chinese": "这家饭馆的菜味道不太咸，很适合我。",
          "pinyin": "Zhè jiā fànguǎn de cài wèidao bú tài xián, hěn shìhé wǒ.",
          "translation_vi": "Món ăn của quán này vị không mặn lắm, rất hợp với tôi.",
          "explanation": "Dạng phủ định \"不太 + Tính từ\" biểu thị mức độ nhẹ nhàng."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 18,
      "name": "Phó từ phạm vi \"都\" (都字副词: Đều)",
      "pattern": "Chủ ngữ (số nhiều) + 都 + V / Adj",
      "category": "Phó từ",
      "explanation_vi": "\"都\" (dōu) là phó từ biểu thị toàn bộ đối tượng được nhắc đến trước đó (\"đều\"). Chủ ngữ đứng trước \"都\" bắt buộc phải là số nhiều hoặc mang tính tập hợp (chúng tôi, bọn họ, mọi người, tất cả).",
      "examples": [
        {
          "chinese": "他们俩都是河内国家大学的学生。",
          "pinyin": "Tāmen liǎ dōu shì Hénèi Guójiā Dàxué de xuésheng.",
          "translation_vi": "Hai người bọn họ đều là sinh viên Đại học Quốc gia Hà Nội.",
          "explanation": "\"都\" bao quát cả hai người \"他们俩\"."
        },
        {
          "chinese": "这些中国菜都很好吃。",
          "pinyin": "Zhèxiē Zhōngguócài dōu hěn hǎochī.",
          "translation_vi": "Những món ăn Trung Quốc này đều rất ngon miệng.",
          "explanation": "\"都\" đứng trước cụm vị ngữ \"很好吃\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 19,
      "name": "Phó từ tương đồng \"也\" (也字副词: Cũng)",
      "pattern": "Chủ ngữ + 也 + V / Adj",
      "category": "Phó từ",
      "explanation_vi": "\"也\" (yě) là phó từ biểu thị sự tương đồng, đồng nhất (\"cũng\"). \"也\" đứng trước động từ hoặc tính từ, đứng sau chủ ngữ. Nếu trong câu vừa có \"也\" vừa có \"都\", vị trí chuẩn mực là: \"也 + 都\" (ví dụ: 我们也都去 - chúng tôi cũng đều đi).",
      "examples": [
        {
          "chinese": "你会说汉语，我也会说一点儿。",
          "pinyin": "Nǐ huì shuō hànyǔ, wǒ yě huì shuō yìdiǎnr.",
          "translation_vi": "Bạn biết nói tiếng Trung, tôi cũng biết nói một chút.",
          "explanation": "\"也\" thể hiện sự tương đồng về khả năng nói tiếng Trung."
        },
        {
          "chinese": "明天是周末，我们也都休息。",
          "pinyin": "Míngtiān shì zhōumò, wǒmen yě dōu xiūxi.",
          "translation_vi": "Ngày mai là cuối tuần, chúng tôi cũng đều được nghỉ.",
          "explanation": "Trật tự kết hợp chuẩn: \"也\" đứng trước \"都\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 20,
      "name": "Câu chữ \"是\" phán đoán (是字句)",
      "pattern": "Khẳng định: A + 是 + B / Phủ định: A + 不是 + B",
      "category": "Cấu trúc câu",
      "explanation_vi": "Động từ \"是\" (shì) biểu thị sự phán đoán, xác nhận danh tính, quốc tịch hoặc quan hệ tương đương giữa chủ ngữ và tân ngữ (\"A là B\"). Thể phủ định là \"不是\" (bú shì).",
      "examples": [
        {
          "chinese": "她是我的好朋友，也是一名护士。",
          "pinyin": "Tā shì wǒ de hǎo péngyou, yě shì yì míng hùshi.",
          "translation_vi": "Cô ấy là bạn thân của tôi, cũng là một y tá.",
          "explanation": "Sử dụng \"是\" để xác nhận thân phận và nghề nghiệp."
        },
        {
          "chinese": "这支钢笔不是我的，是我同桌的。",
          "pinyin": "Zhè zhī gāngbǐ bú shì wǒ de, shì wǒ tóngzhuō de.",
          "translation_vi": "Chiếc bút máy này không phải của tôi, là của bạn cùng bàn tôi.",
          "explanation": "\"不是\" phủ định quan hệ sở hữu."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 21,
      "name": "Câu chữ \"有\" biểu thị sở hữu và tồn tại (有字句)",
      "pattern": "Sở hữu: Chủ ngữ + 有 + Tân ngữ / Tồn tại: Nơi chốn + 有 + Danh từ",
      "category": "Cấu trúc câu",
      "explanation_vi": "Động từ \"有\" (yǒu) có 2 công dụng chính: 1. Biểu thị quyền sở hữu (Tôi có sách - 我有书). 2. Biểu thị sự tồn tại khách quan tại một địa điểm (Trên bàn có một quả táo - 桌子上有个苹果). Thể phủ định bắt buộc dùng \"没有\", không được dùng \"不有\".",
      "examples": [
        {
          "chinese": "我家有一只非常可爱的白色小狗。",
          "pinyin": "Wǒ jiā yǒu yì zhī fēicháng kě'ài de báisè xiǎogǒu.",
          "translation_vi": "Nhà tôi có một chú chó nhỏ màu trắng vô cùng đáng yêu.",
          "explanation": "\"有\" biểu thị quan hệ sở hữu vật nuôi."
        },
        {
          "chinese": "学校大门口有一家很大的书店。",
          "pinyin": "Xuéxiào dàménkǒu yǒu yì jiā hěn dà de shūdiàn.",
          "translation_vi": "Ở cổng lớn của trường học có một hiệu sách rất to.",
          "explanation": "\"有\" biểu thị sự tồn tại nơi chốn ở cổng trường."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 22,
      "name": "Động từ vị trí \"在\" (在作动词)",
      "pattern": "Người / Vật + 在 + Nơi chốn / Phương vị từ",
      "category": "Động từ",
      "explanation_vi": "Khi \"在\" đóng vai trò vị ngữ chính trong câu, nó biểu thị người hoặc đồ vật đang ở tại một vị trí, địa điểm cụ thể (\"ở, tại\"). Thể phủ định dùng \"不在\" (không ở).",
      "examples": [
        {
          "chinese": "请问王经理在办公室吗？他现在不在。",
          "pinyin": "Qǐngwèn Wáng jīnglǐ zài bàngōngshì ma? Tā xiànzài bú zài.",
          "translation_vi": "Xin hỏi giám đốc Vương có ở văn phòng không? Hiện tại ông ấy không có ở đây.",
          "explanation": "\"在\" làm động từ vị ngữ chính chỉ sự hiện diện."
        },
        {
          "chinese": "我的护照和钱包都在抽屉里。",
          "pinyin": "Wǒ de hùzhào hé qiánbāo dōu zài chōuti lǐ.",
          "translation_vi": "Hộ chiếu và ví tiền của tôi đều ở trong ngăn kéo.",
          "explanation": "Kết hợp \"在\" với từ chỉ phương vị \"里\" (bên trong)."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 23,
      "name": "Động từ năng nguyện \"会\" (Biết qua học tập)",
      "pattern": "Chủ ngữ + 会 / 不会 + Động từ",
      "category": "Động từ năng nguyện",
      "explanation_vi": "\"会\" (huì) biểu thị một kỹ năng hoặc năng lực có được thông qua quá trình học tập, rèn luyện (ví dụ: biết bơi, biết lái xe, biết nói tiếng Trung). Thể phủ định dùng \"不会\" (không biết làm).",
      "examples": [
        {
          "chinese": "哥哥会开车，但是弟弟还不会。",
          "pinyin": "Gēge huì kāichē, dànshì dìdi hái bú huì.",
          "translation_vi": "Anh trai biết lái xe, nhưng em trai vẫn chưa biết.",
          "explanation": "\"会开车\" là kỹ năng học được qua đào tạo lái xe."
        },
        {
          "chinese": "你会写自己的中文名字吗？",
          "pinyin": "Nǐ huì xiě zìjǐ de zhōngwén míngzi ma?",
          "translation_vi": "Bạn có biết viết tên tiếng Trung của mình không?",
          "explanation": "\"会写\" hỏi về kỹ năng viết chữ Hán."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 24,
      "name": "Động từ năng nguyện \"想\" (Muốn / Dự định)",
      "pattern": "Chủ ngữ + 想 / 不想 + Động từ",
      "category": "Động từ năng nguyện",
      "explanation_vi": "\"想\" (xiǎng) đứng trước động từ biểu thị ý muốn chủ quan, dự định hoặc nguyện vọng (\"muốn làm gì\"). Phủ định dùng \"不想\" (không muốn). Ngoài ra khi đứng độc lập trước danh từ, \"想\" còn mang nghĩa là \"nhớ\" (想家 - nhớ nhà) hoặc \"nghĩ\" (想一想).",
      "examples": [
        {
          "chinese": "明天下午我想去图书馆看书。",
          "pinyin": "Míngtiān xiàwǔ wǒ xiǎng qù túshūguǎn kànshū.",
          "translation_vi": "Chiều mai tôi muốn đến thư viện đọc sách.",
          "explanation": "\"想去\" biểu thị mong muốn dự định trong tương lai gần."
        },
        {
          "chinese": "天气太热了，我不想出去运动。",
          "pinyin": "Tiānqì tài rè le, wǒ bù xiǎng chūqù yùndòng.",
          "translation_vi": "Thời tiết nóng quá rồi, tôi không muốn ra ngoài vận động.",
          "explanation": "\"不想\" phủ định ý muốn chủ quan."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 25,
      "name": "Động từ năng nguyện \"能\" (Có thể / Năng lực)",
      "pattern": "Chủ ngữ + 能 / 不能 + Động từ",
      "category": "Động từ năng nguyện",
      "explanation_vi": "\"能\" (néng) biểu thị năng lực bẩm sinh, khả năng khách quan đạt được mức độ nào đó, hoặc hoàn cảnh khách quan cho phép có thể thực hiện được hành động. Thể phủ định dùng \"不能\".",
      "examples": [
        {
          "chinese": "我的感冒好了，明天能去上学了。",
          "pinyin": "Wǒ de gǎnmào hǎo le, míngtiān néng qù shàngxué le.",
          "translation_vi": "Bệnh cảm của tôi đã khỏi rồi, ngày mai có thể đi học lại rồi.",
          "explanation": "Khả năng thể chất và sức khỏe cho phép thực hiện hành động."
        },
        {
          "chinese": "这里太吵了，我不能专心看书。",
          "pinyin": "Zhèlǐ tài chǎo le, wǒ bù néng zhuānxīn kànshū.",
          "translation_vi": "Ở đây ồn ào quá, tôi không thể tập trung đọc sách.",
          "explanation": "Điều kiện hoàn cảnh khách quan không cho phép."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 26,
      "name": "Động từ năng nguyện \"可以\" (Được phép / Có thể)",
      "pattern": "Chủ ngữ + 可以 + Động từ / (Phủ định cấm đoán: 不能 / 不行)",
      "category": "Động từ năng nguyện",
      "explanation_vi": "\"可以\" (kěyǐ) biểu thị sự cho phép về mặt quy định, phép lịch sự hoặc đưa ra lời thỉnh cầu (\"có thể / được phép làm gì\"). Khi trả lời phủ định từ chối sự cho phép, người ta thường dùng \"不能\" hoặc \"不行\" chứ ít khi dùng \"不可以\" (vì mang sắc thái quá gay gắt).",
      "examples": [
        {
          "chinese": "请问，我可以在这里吸烟吗？不可以。",
          "pinyin": "Qǐngwèn, wǒ kěyǐ zài zhèlǐ xīyān ma? Bù kěyǐ.",
          "translation_vi": "Xin hỏi, tôi có thể hút thuốc ở đây không? Không được.",
          "explanation": "Dùng \"可以\" trong lời thỉnh cầu lịch sự xin phép."
        },
        {
          "chinese": "作业做完了，你现在可以看电视了。",
          "pinyin": "Zuòyè zuò wán le, nǐ xiànzài kěyǐ kàn diànshì le.",
          "translation_vi": "Bài tập làm xong rồi, bây giờ con có thể xem tivi rồi.",
          "explanation": "Biểu thị sự cho phép sau khi hoàn thành điều kiện."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 27,
      "name": "Giới từ địa điểm \"在\" (在作介词: Ở đâu làm gì)",
      "pattern": "Chủ ngữ + 在 + Nơi chốn + Động từ + Tân ngữ",
      "category": "Giới từ",
      "explanation_vi": "Quy tắc ngữ pháp vàng của tiếng Trung: TRẠNG TỪ CHỈ NƠI CHỐN ĐỨNG TRƯỚC ĐỘNG TỪ CHÍNH. Khác với tiếng Việt nói \"Tôi đọc sách ở thư viện\", tiếng Trung bắt buộc phải nói theo trình tự: \"Tôi [ở thư viện] đọc sách\" (我在图书馆看书).",
      "examples": [
        {
          "chinese": "爸爸每天都在医院工作。",
          "pinyin": "Bàba měitiān dōu zài yīyuàn gōngzuò.",
          "translation_vi": "Bố mỗi ngày đều làm việc ở bệnh viện.",
          "explanation": "\"在医院\" (ở bệnh viện) đặt trước động từ \"工作\" (làm việc)."
        },
        {
          "chinese": "我们晚上在家里吃中国菜。",
          "pinyin": "Wǒmen wǎnshang zài jiā lǐ chī Zhōngguócài.",
          "translation_vi": "Buổi tối chúng tôi ăn món ăn Trung Quốc ở nhà.",
          "explanation": "\"在家里\" đặt trước hành động \"吃中国菜\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 28,
      "name": "Giới từ cùng đối tượng \"跟\" (跟...一起)",
      "pattern": "A + 跟 + B + (一起) + Động từ",
      "category": "Giới từ",
      "explanation_vi": "\"跟\" (gēn) đóng vai trò giới từ chỉ đối tượng cùng tham gia hành động (\"cùng với ai làm gì\"). Trong khẩu ngữ thường kết hợp với phó từ \"一起\" (yìqǐ) để tăng cường nghĩa đồng hành (\"cùng nhau\").",
      "examples": [
        {
          "chinese": "周末我常跟我妈妈一起去超市买菜。",
          "pinyin": "Zhōumò wǒ cháng gēn wǒ māma yìqǐ qù chāoshì mǎi cài.",
          "translation_vi": "Cuối tuần tôi thường cùng mẹ đi siêu thị mua thức ăn.",
          "explanation": "\"跟我妈妈一起\" bổ nghĩa cho hành động đi siêu thị."
        },
        {
          "chinese": "我想跟你商量一件重要的事情。",
          "pinyin": "Wǒ xiǎng gēn nǐ shāngliang yí jiàn zhòngyào de shìqing.",
          "translation_vi": "Tôi muốn bàn bạc với bạn một việc quan trọng.",
          "explanation": "\"跟 + bạn\" chỉ đối tượng trao đổi giao tiếp."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 29,
      "name": "Giới từ trao nhận \"给\" (给作介词)",
      "pattern": "Chủ ngữ + 给 + Đối tượng + Động từ / 给 + Đối tượng + 打电话",
      "category": "Giới từ",
      "explanation_vi": "\"给\" (gěi) ngoài nghĩa là động từ \"cho/tặng\", còn làm giới từ chỉ đối tượng tiếp nhận hành động (\"cho ai, tới ai\"). Mẫu câu kinh điển nhất là \"给...打电话\" (gọi điện thoại cho ai).",
      "examples": [
        {
          "chinese": "我下了飞机就给你打电话。",
          "pinyin": "Wǒ xià le fēijī jiù gěi nǐ dǎ diànhuà.",
          "translation_vi": "Tôi vừa bước xuống máy bay là gọi điện thoại cho bạn ngay.",
          "explanation": "\"给你打电话\" là mẫu câu tiêu chuẩn trong giao tiếp tiếng Trung."
        },
        {
          "chinese": "妈妈每天都给我做可口的早饭。",
          "pinyin": "Māma měitiān dōu gěi wǒ zuò kěkǒu de zǎofàn.",
          "translation_vi": "Mẹ mỗi ngày đều nấu bữa sáng ngon miệng cho tôi.",
          "explanation": "\"给我做早饭\" biểu thị làm bữa sáng cho đối tượng \"tôi\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 30,
      "name": "Liên từ nối từ \"和\" (和字连词)",
      "pattern": "Danh từ / Đại từ A + 和 + Danh từ / Đại từ B",
      "category": "Liên từ",
      "explanation_vi": "\"和\" (hé) là liên từ mang nghĩa \"và, cùng\". LƯU Ý CỰC KỲ QUAN TRỌNG: \"和\" CHỈ DÙNG ĐỂ NỐI DANH TỪ HOẶC ĐẠI TỪ, TUYỆT ĐỐI KHÔNG DÙNG \"和\" ĐỂ NỐI HAI CÂU HOẶC HAI MỆNH ĐỀ như từ \"and\" trong tiếng Anh hay \"và\" trong tiếng Việt.",
      "examples": [
        {
          "chinese": "桌子上有三个苹果和两根香蕉。",
          "pinyin": "Zhuōzi shang yǒu sān gè píngguǒ hé liǎng gēn xiāngjiāo.",
          "translation_vi": "Trên bàn có ba quả táo và hai quả chuối.",
          "explanation": "\"和\" nối hai cụm danh từ \"苹果\" và \"香蕉\"."
        },
        {
          "chinese": "我和他是小学同班同学。",
          "pinyin": "Wǒ hé tā shì xiǎoxué tóngbān tóngxué.",
          "translation_vi": "Tôi và anh ấy là bạn cùng lớp tiểu học.",
          "explanation": "\"和\" nối hai đại từ nhân xưng \"我\" và \"他\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 31,
      "name": "Trợ từ kết cấu \"的\" chỉ sở hữu (领属性\"的\")",
      "pattern": "Người sở hữu + 的 + Vật sở hữu",
      "category": "Trợ từ",
      "explanation_vi": "\"的\" (de) đặt giữa người sở hữu và vật sở hữu mang nghĩa là \"của\" (ví dụ: 我的书 - sách của tôi). LƯU Ý: Khi biểu thị mối quan hệ người thân ruột thịt (bố mẹ, anh chị) hoặc tổ chức gắn bó thân thiết (trường tôi, nước tôi), chữ \"的\" có thể lược bỏ (ví dụ: 我妈妈, 我家, 我们学校).",
      "examples": [
        {
          "chinese": "这是我爸爸的车，不是我的车。",
          "pinyin": "Zhè shì wǒ bàba de chē, bú shì wǒ de chē.",
          "translation_vi": "Đây là xe của bố tôi, không phải xe của tôi.",
          "explanation": "\"我爸爸\" lược bỏ \"的\" vì là người thân, \"爸爸的车\" giữ \"的\" biểu thị sở hữu xe."
        },
        {
          "chinese": "请问这是谁的杯子？",
          "pinyin": "Qǐngwèn zhè shì shéi de bēizi?",
          "translation_vi": "Xin hỏi đây là cốc của ai vậy?",
          "explanation": "Hỏi quyền sở hữu đồ vật dùng \"谁的\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 32,
      "name": "Trợ từ kết cấu \"的\" nối định ngữ và trung tâm ngữ (修饰性\"的\")",
      "pattern": "Tính từ / Cụm miêu tả + 的 + Danh từ trung tâm",
      "category": "Trợ từ",
      "explanation_vi": "Khi một tính từ hai âm tiết, cụm tính từ hoặc cụm chủ vị đứng trước để miêu tả đặc điểm tính chất cho một danh từ đứng sau, bắt buộc phải dùng trợ từ kết cấu \"的\" làm cầu nối. Quy tắc: \"Định ngữ + 的 + Trung tâm ngữ\".",
      "examples": [
        {
          "chinese": "她是一个非常漂亮且热情的中国女孩。",
          "pinyin": "Tā shì yí gè fēicháng piàoliang qiě rèqíng de Zhōngguó nǚhái.",
          "translation_vi": "Cô ấy là một cô gái Trung Quốc vô cùng xinh đẹp và nhiệt tình.",
          "explanation": "Cụm miêu tả \"漂亮且热情\" bổ nghĩa cho danh từ \"女孩\" qua chữ \"的\"."
        },
        {
          "chinese": "我想买一件白色的保暖衣服。",
          "pinyin": "Wǒ xiǎng mǎi yí jiàn báisè de bǎonuǎn yīfu.",
          "translation_vi": "Tôi muốn mua một chiếc áo ấm màu trắng.",
          "explanation": "\"白色\" bổ nghĩa cho \"衣服\" qua chữ \"的\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 33,
      "name": "Trợ từ nghi vấn \"吗\" (吗字疑问句)",
      "pattern": "Câu trần thuật + 吗？",
      "category": "Trợ từ",
      "explanation_vi": "\"吗\" (ma) là trợ từ nghi vấn đặt ở cuối câu trần thuật để biến câu đó thành câu hỏi Có/Không (Yes/No question). Câu trả lời chỉ cần nhắc lại động từ/tính từ khẳng định hoặc phủ định bằng \"不 / 没\".",
      "examples": [
        {
          "chinese": "你是河内大学的留学生吗？是的。",
          "pinyin": "Nǐ shì Hénèi Dàxué de liúxuéshēng ma? Shì de.",
          "translation_vi": "Bạn là du học sinh Đại học Hà Nội phải không? Đúng vậy.",
          "explanation": "Biến câu trần thuật thành câu hỏi xác nhận thân phận."
        },
        {
          "chinese": "你今天晚上有空儿吗？没有，我很忙。",
          "pinyin": "Nǐ jīntiān wǎnshang yǒu kòngr ma? Méiyǒu, wǒ hěn máng.",
          "translation_vi": "Tối nay bạn có rảnh không? Không có, tôi bận lắm.",
          "explanation": "Hỏi trạng thái rảnh rỗi và trả lời phủ định bằng \"没有\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 34,
      "name": "Trợ từ ngữ khí \"呢\" hỏi tỉnh lược (呢字省略问)",
      "pattern": "Danh từ / Đại từ + 呢？ (Thế còn...?) / Nơi chốn + 呢？ (Ở đâu?)",
      "category": "Trợ từ",
      "explanation_vi": "Trợ từ \"呢\" (ne) đặt sau danh từ hoặc đại từ có 2 công dụng lớn: 1. Câu hỏi tỉnh lược rút gọn dựa theo ngữ cảnh trước đó: \"A thì... thế còn B đâu/thì sao?\" (我喜欢吃苹果，你呢？). 2. Hỏi tìm kiếm vị trí của người hoặc vật: \"Điện thoại của tôi đâu rồi?\" (我的手机呢？).",
      "examples": [
        {
          "chinese": "我是越南人，你呢？我是中国人。",
          "pinyin": "Wǒ shì Yuènánrén, nǐ ne? Wǒ shì Zhōngguórén.",
          "translation_vi": "Tôi là người Việt Nam, thế còn bạn? Tôi là người Trung Quốc.",
          "explanation": "\"你呢？\" kế thừa câu hỏi quốc tịch phía trước mà không cần lặp lại cả câu."
        },
        {
          "chinese": "妈妈，我的汉语书呢？在桌子上。",
          "pinyin": "Māma, wǒ de hànyǔ shū ne? Zài zhuōzi shang.",
          "translation_vi": "Mẹ ơi, sách tiếng Trung của con đâu rồi? Ở trên bàn kìa.",
          "explanation": "Dùng \"呢\" để hỏi vị trí đồ vật thất lạc."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 35,
      "name": "Trợ từ ngữ khí \"吧\" đề nghị và thương lượng (吧字祈使句)",
      "pattern": "Câu đề xuất / rủ rê + 吧。",
      "category": "Trợ từ",
      "explanation_vi": "\"吧\" (ba) đứng cuối câu biểu thị lời đề nghị, rủ rê, khuyên bảo hoặc thương lượng với ngữ điệu nhẹ nhàng, lịch sự (\"...đi, ...nhé, ...nào\"). Thường đi kèm với đại từ \"我们\" (chúng ta).",
      "examples": [
        {
          "chinese": "时间不早了，我们一起回家吧。",
          "pinyin": "Shíjiān bù zǎo le, wǒmen yìqǐ huíjiā ba.",
          "translation_vi": "Thời gian không còn sớm nữa, chúng ta cùng về nhà đi thôi.",
          "explanation": "\"我们...吧\" là cấu trúc rủ rê thân thiện kinh điển."
        },
        {
          "chinese": "快点儿走吧，电影马上要开始了。",
          "pinyin": "Kuài diǎnr zǒu ba, diànyǐng mǎshàng yào kāishǐ le.",
          "translation_vi": "Đi nhanh lên nào, phim sắp sửa bắt đầu rồi đấy.",
          "explanation": "\"吧\" làm dịu ngữ khí của câu mệnh lệnh thúc giục."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 36,
      "name": "Trợ từ ngữ thái \"了\" biểu thị biến hóa trạng thái mới (句尾\"了\")",
      "pattern": "Chủ ngữ + V / Adj + 了。 (Biểu thị có sự thay đổi)",
      "category": "Trợ từ",
      "explanation_vi": "Chữ \"了\" (le) đặt ở CUỐI CÂU biểu thị sự phát sinh một trạng thái mới hoặc có sự thay đổi so với trước đây (\"rồi\"). Ví dụ: 下雨了 (trời mưa rồi - trước đó chưa mưa), 我有女朋友了 (tôi có bạn gái rồi).",
      "examples": [
        {
          "chinese": "秋天到了，树叶变黄了。",
          "pinyin": "Qiūtiān dào le, shùyè biàn huáng le.",
          "translation_vi": "Mùa thu đến rồi, lá cây chuyển sang màu vàng rồi.",
          "explanation": "\"了\" ở cuối câu thể hiện sự thay đổi trạng thái của thời tiết và lá cây."
        },
        {
          "chinese": "我已经十八岁了，是一个大人了。",
          "pinyin": "Wǒ yǐjīng shíbā suì le, shì yí gè dàrén le.",
          "translation_vi": "Tôi đã mười tám tuổi rồi, là một người lớn rồi.",
          "explanation": "\"十八岁了\" biểu thị số tuổi mới đạt được."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 37,
      "name": "Trợ từ động thái \"了\" biểu thị hoàn thành hành động (动后\"了\")",
      "pattern": "Chủ ngữ + Động từ + 了 + (Số lượng/Định ngữ) + Tân ngữ",
      "category": "Trợ từ",
      "explanation_vi": "Chữ \"了\" đặt NGAY SAU ĐỘNG TỪ biểu thị hành động đó đã được thực hiện xong, hoàn thành hoặc hiện thực hóa. Nếu có tân ngữ đi kèm, tân ngữ thường có định ngữ, số lượng từ bổ nghĩa (ví dụ: 我买了一本书 - Tôi đã mua một quyển sách).",
      "examples": [
        {
          "chinese": "我今天下午在书店买了两本小说。",
          "pinyin": "Wǒ jīntiān xiàwǔ zài shūdiàn mǎi le liǎng běn xiǎoshuō.",
          "translation_vi": "Chiều nay tôi đã mua hai quyển tiểu thuyết ở hiệu sách.",
          "explanation": "\"买了\" đứng ngay sau động từ \"买\", kết hợp với số lượng từ \"两本\"."
        },
        {
          "chinese": "他喝了一杯热牛奶就睡觉了。",
          "pinyin": "Tā hē le yì bēi rè niúnǎi jiù shuìjiào le.",
          "translation_vi": "Anh ấy uống xong một cốc sữa nóng là đi ngủ ngay.",
          "explanation": "\"喝了\" biểu thị hành động uống đã kết thúc trước khi ngủ."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 38,
      "name": "Câu vị ngữ hình dung từ (形容词谓语句)",
      "pattern": "Chủ ngữ + (很 / 不) + Tính từ (Tuyệt đối KHÔNG có \"是\")",
      "category": "Cấu trúc câu",
      "explanation_vi": "LỖI PHỔ BIẾN NHẤT CỦA NGƯỜI VIỆT: Người Việt hay nói \"Tôi là vui\" -> dịch sang tiếng Trung thành \"我是高兴\" (SAI!). Trong tiếng Trung, tính từ trực tiếp làm vị ngữ, KHÔNG ĐƯỢC DÙNG \"是\". Câu chuẩn: \"我很高兴\" (Tôi rất vui) hoặc \"天气很冷\" (Trời rất lạnh).",
      "examples": [
        {
          "chinese": "今天天气很好，阳光明媚。",
          "pinyin": "Jīntiān tiānqì hěn hǎo, yángguāng míngmèi.",
          "translation_vi": "Hôm nay thời tiết rất đẹp, ánh nắng chan hòa.",
          "explanation": "\"天气很好\", không dùng \"天气是好\"."
        },
        {
          "chinese": "这里的苹果又大又甜，一点儿也不贵。",
          "pinyin": "Zhèlǐ de píngguǒ yòu dà yòu tián, yìdiǎnr yě bú guì.",
          "translation_vi": "Táo ở đây vừa to vừa ngọt, một chút cũng không đắt.",
          "explanation": "Tính từ \"大\", \"甜\", \"贵\" trực tiếp làm vị ngữ câu."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 39,
      "name": "Câu vị ngữ danh từ (名词谓语句)",
      "pattern": "Chủ ngữ (thời gian/người) + Cụm danh từ (ngày tháng/tuổi/giá cả)",
      "category": "Cấu trúc câu",
      "explanation_vi": "Câu vị ngữ danh từ là câu mà vị ngữ do danh từ hoặc cụm danh từ trực tiếp đảm nhiệm mà không cần động từ \"是\". Thường dùng chuyên biệt để nói về: Ngày tháng, thứ, giờ giấc, tuổi tác, quê quán hoặc giá tiền.",
      "examples": [
        {
          "chinese": "今天星期天，明天星期一。",
          "pinyin": "Jīntiān xīngqītiān, míngtiān xīngqīyī.",
          "translation_vi": "Hôm nay là chủ nhật, ngày mai là thứ hai.",
          "explanation": "\"星期天\" trực tiếp làm vị ngữ cho chủ ngữ \"今天\" không cần dùng \"是\"."
        },
        {
          "chinese": "我弟弟今年十八岁。",
          "pinyin": "Wǒ dìdi jīnnián shíbā suì.",
          "translation_vi": "Em trai tôi năm nay 18 tuổi.",
          "explanation": "\"十八岁\" làm vị ngữ danh từ biểu thị số tuổi."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 40,
      "name": "Câu vị ngữ động từ cơ bản (动词谓语句: S + V + O)",
      "pattern": "Chủ ngữ + Trạng ngữ (thời gian/địa điểm) + Động từ + Tân ngữ",
      "category": "Cấu trúc câu",
      "explanation_vi": "Trật tự câu cơ bản của tiếng Trung là S-V-O tương tự tiếng Việt. Tuy nhiên, các trạng ngữ chỉ thời gian và nơi chốn BẮT BUỘC ĐỨNG TRƯỚC ĐỘNG TỪ (hoặc đứng đầu câu trước chủ ngữ), không được đặt bừa bãi ở cuối câu như tiếng Việt.",
      "examples": [
        {
          "chinese": "学生们每天上午在教室听课。",
          "pinyin": "Xuéshengmen měitiān shàngwǔ zài jiàoshì tīngkè.",
          "translation_vi": "Học sinh mỗi buổi sáng đều nghe giảng trong phòng học.",
          "explanation": "Trật tự chuẩn: Chủ ngữ (学生们) + Thời gian (每天上午) + Địa điểm (在教室) + Động từ (听课)."
        },
        {
          "chinese": "我喜欢在周末听轻音乐。",
          "pinyin": "Wǒ xǐhuan zài zhōumò tīng qīngyīnyuè.",
          "translation_vi": "Tôi thích nghe nhạc nhẹ vào dịp cuối tuần.",
          "explanation": "Trạng từ thời gian \"在周末\" đặt trước động từ \"听\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 41,
      "name": "Câu liên động chỉ mục đích (连动句: 去 / 来 + Nơi chốn + V)",
      "pattern": "Chủ ngữ + 去 / 来 / 到 + Nơi chốn + Động từ mục đích",
      "category": "Cấu trúc câu",
      "explanation_vi": "Câu liên động là câu có từ hai động từ trở lên cùng chia sẻ một chủ ngữ. Trong HSK 1, dạng phổ biến nhất là dùng động từ chỉ di chuyển (去, 来, 到) đi kèm địa điểm, theo sau là động từ thứ hai chỉ mục đích (\"Đi đâu để làm gì\").",
      "examples": [
        {
          "chinese": "下午我想去中国银行换钱。",
          "pinyin": "Xiàwǔ wǒ xiǎng qù Zhōngguó Yínháng huànqián.",
          "translation_vi": "Buổi chiều tôi muốn đến Ngân hàng Trung Quốc đổi tiền.",
          "explanation": "Động từ 1: \"去\" (đến Ngân hàng Trung Quốc) -> Động từ 2: \"换钱\" (đổi tiền - mục đích)."
        },
        {
          "chinese": "朋友晚上来我家吃饭。",
          "pinyin": "Péngyou wǎnshang lái wǒ jiā chīfàn.",
          "translation_vi": "Buổi tối bạn bè đến nhà tôi ăn cơm.",
          "explanation": "Động từ 1: \"来我家\" -> Động từ 2: \"吃饭\" (mục đích)."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 42,
      "name": "Câu có hai tân ngữ (双宾语句: 给 / 教 / 送)",
      "pattern": "Chủ ngữ + Động từ + Tân ngữ gián tiếp (Người) + Tân ngữ trực tiếp (Vật)",
      "category": "Cấu trúc câu",
      "explanation_vi": "Một số động từ mang ý nghĩa trao tặng, chuyển giao (như 给 - cho, 送 - tặng, 教 - dạy) có thể mang theo 2 tân ngữ: Tân ngữ 1 chỉ người nhận (tân ngữ gián tiếp) đứng trước, Tân ngữ 2 chỉ sự vật được trao nhận (tân ngữ trực tiếp) đứng sau.",
      "examples": [
        {
          "chinese": "老师每天教我们汉字和发音。",
          "pinyin": "Lǎoshī měitiān jiāo wǒmen hànzì hé fāyīn.",
          "translation_vi": "Thầy giáo mỗi ngày dạy chúng tôi chữ Hán và phát âm.",
          "explanation": "Tân ngữ 1: \"我们\" (người), Tân ngữ 2: \"汉字和发音\" (vật/nội dung)."
        },
        {
          "chinese": "过生日时，朋友送我一本精美的画册。",
          "pinyin": "Guò shēngrì shí, péngyou sòng wǒ yì běn jīngměi de huàcè.",
          "translation_vi": "Dịp sinh nhật, bạn bè tặng tôi một cuốn tập tranh tinh xảo.",
          "explanation": "Tân ngữ 1: \"我\" (người), Tân ngữ 2: \"一本精美的画册\" (vật)."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 43,
      "name": "Câu hỏi chính phản (正反疑问句: V 不 V / Adj 不 Adj)",
      "pattern": "Chủ ngữ + Động từ + 不 + Động từ？ / Tính từ + 不 + Tính từ？",
      "category": "Câu hỏi",
      "explanation_vi": "Câu hỏi chính phản ghép hình thức khẳng định và phủ định của động từ/tính từ lại với nhau để tạo thành câu hỏi lựa chọn (\"Có... hay không?\"). Chú ý: ĐÃ DÙNG CÂU HỎI CHÍNH PHẢN THÌ TUYỆT ĐỐI KHÔNG DÙNG \"吗\" Ở CUỐI CÂU NỮA.",
      "examples": [
        {
          "chinese": "你想不想去中国旅游？想去。",
          "pinyin": "Nǐ xiǎng bù xiǎng qù Zhōngguó lǚyóu? Xiǎng qù.",
          "translation_vi": "Bạn có muốn đi du lịch Trung Quốc không? Muốn đi.",
          "explanation": "Ghép chính phản \"想不想\", không thêm \"吗\" ở cuối."
        },
        {
          "chinese": "这件衣服贵不贵？不贵，挺便宜的。",
          "pinyin": "Zhè jiàn yīfu guì bú guì? Bú guì, tǐng piányi de.",
          "translation_vi": "Bộ quần áo này có đắt không? Không đắt, khá rẻ.",
          "explanation": "Hỏi chính phản với tính từ \"贵不贵\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 44,
      "name": "Câu hỏi chính phản với \"有没有\" (有没有疑问句)",
      "pattern": "Chủ ngữ + 有没有 + Tân ngữ？ / Câu trần thuật + 没有？",
      "category": "Câu hỏi",
      "explanation_vi": "Hình thức chính phản của động từ \"有\" là \"有没有\" (yǒu méiyǒu), mang nghĩa \"có... hay không?\" hoặc \"đã... chưa?\". Khi đặt \"没有\" ở cuối câu trần thuật cũng tạo thành câu hỏi \"đã làm gì chưa?\".",
      "examples": [
        {
          "chinese": "请问你有没有中文词典？有，在书架上。",
          "pinyin": "Qǐngwèn nǐ yǒu méiyǒu zhōngwén cídiǎn? Yǒu, zài shūjià shang.",
          "translation_vi": "Xin hỏi bạn có từ điển tiếng Trung không? Có, ở trên giá sách.",
          "explanation": "Dùng \"有没有\" để hỏi về sự sở hữu đồ vật."
        },
        {
          "chinese": "你吃早饭了没有？还没吃呢。",
          "pinyin": "Nǐ chī zǎofàn le méiyǒu? Hái méi chī ne.",
          "translation_vi": "Bạn đã ăn bữa sáng chưa? Vẫn chưa ăn.",
          "explanation": "\"...了没有？\" dùng để hỏi hành động đã hoàn thành chưa."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 45,
      "name": "Câu hỏi lựa chọn \"还是\" (选择疑问句)",
      "pattern": "Lựa chọn A + 还是 + Lựa chọn B？",
      "category": "Câu hỏi",
      "explanation_vi": "\"还是\" (háishì) dùng trong CÂU HỎI để đưa ra hai hay nhiều phương án cho người nghe lựa chọn (\"hay là / hoặc là?\"). Phân biệt: \"还是\" dùng trong câu hỏi, còn \"或者\" (huòzhě) dùng trong câu trần thuật khẳng định.",
      "examples": [
        {
          "chinese": "你想喝热茶还是冰咖啡？我想喝热茶。",
          "pinyin": "Nǐ xiǎng hē rèchá háishì bīng kāfēi? Wǒ xiǎng hē rèchá.",
          "translation_vi": "Bạn muốn uống trà nóng hay là cà phê đá? Tôi muốn uống trà nóng.",
          "explanation": "Đưa ra hai đồ uống để người nghe chọn lựa."
        },
        {
          "chinese": "我们今天坐公交车还是坐地铁去？",
          "pinyin": "Wǒmen jīntiān zuò gōngjiāochē háishì zuò dìtiě qù?",
          "translation_vi": "Hôm nay chúng ta đi xe buýt hay là đi tàu điện ngầm?",
          "explanation": "Lựa chọn phương tiện giao thông di chuyển."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 46,
      "name": "Quy tắc diễn đạt Ngày, Tháng, Năm (年月日表达法)",
      "pattern": "Năm (年) + Tháng (月) + Ngày (日 / 号) + Thứ (星期)",
      "category": "Quy tắc biểu đạt",
      "explanation_vi": "Quy tắc tư duy thời gian trong tiếng Trung là ĐI TỪ LỚN ĐẾN NHỎ (ngược hoàn toàn với tiếng Việt): Năm -> Tháng -> Ngày -> Thứ. Trong văn viết dùng \"日\" (rì), trong khẩu ngữ nói hàng ngày thường dùng \"号\" (hào).",
      "examples": [
        {
          "chinese": "今天是二零二六年十月二十三号，星期五。",
          "pinyin": "Jīntiān shì èr líng èr liù nián shí yuè èrshísān hào, xīngqīwǔ.",
          "translation_vi": "Hôm nay là thứ Sáu, ngày 23 tháng 10 năm 2026.",
          "explanation": "Thứ tự chuẩn: Năm (2026) -> Tháng (10) -> Ngày (23) -> Thứ (Thứ Sáu)."
        },
        {
          "chinese": "明天是他的生日，五月八号。",
          "pinyin": "Míngtiān shì tā de shēngrì, wǔ yuè bā hào.",
          "translation_vi": "Ngày mai là sinh nhật của anh ấy, ngày 8 tháng 5.",
          "explanation": "Khẩu ngữ nói ngày sinh nhật dùng \"号\"."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 47,
      "name": "Quy tắc diễn đạt Giờ giấc và Thời điểm (时间表达法)",
      "pattern": "Buổi trong ngày + ...点 (giờ) + ...分 (phút) / 半 (rưỡi)",
      "category": "Quy tắc biểu đạt",
      "explanation_vi": "Tương tự ngày tháng, thời gian trong ngày cũng đi từ đơn vị lớn đến nhỏ: Buổi (上午, 下午, 晚上) -> Giờ (点) -> Phút (分). \"半\" (bàn) dùng chỉ 30 phút (rưỡi). Trạng ngữ thời gian luôn đứng trước động từ trong câu.",
      "examples": [
        {
          "chinese": "我们每天上午八点半开始上课。",
          "pinyin": "Wǒmen měitiān shàngwǔ bā diǎn bàn kāishǐ shàngkè.",
          "translation_vi": "Chúng tôi mỗi sáng bắt đầu vào lớp lúc 8 giờ rưỡi.",
          "explanation": "Thứ tự: 上午 (buổi sáng) -> 八点 (8 giờ) -> 半 (30 phút) đứng trước động từ \"开始上课\"."
        },
        {
          "chinese": "现在正好是下午三点十五分。",
          "pinyin": "Xiànzài zhènghǎo shì xiàwǔ sān diǎn shíwǔ fēn.",
          "translation_vi": "Bây giờ đúng lúc là 3 giờ 15 phút chiều.",
          "explanation": "\"点\" chỉ giờ, \"分\" chỉ phút."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 48,
      "name": "Các mẫu câu giao tiếp nghi thức xã giao cơ bản (日常交际用语)",
      "pattern": "你好 / 谢谢 / 不客气 / 对不起 / 没关系 / 再见",
      "category": "Quy tắc biểu đạt",
      "explanation_vi": "Hệ thống các cặp câu giao tiếp lễ nghi lịch sự thông dụng nhất: 1. Chào hỏi: 你好 (chào bạn), 你们好 (chào các bạn), 老师好 (chào thầy/cô). 2. Cảm ơn & Đáp lại: 谢谢 -> 不客气 / 不用谢. 3. Xin lỗi & Thứ lỗi: 对不起 -> 没关系. 4. Chào tạm biệt: 再见.",
      "examples": [
        {
          "chinese": "非常感谢你的热情帮助！不客气，应该的。",
          "pinyin": "Fēicháng gǎnxiè nǐ de rèqíng bāngzhù! Bú kèqi, yīnggāi de.",
          "translation_vi": "Vô cùng cảm ơn sự giúp đỡ nhiệt tình của bạn! Không có chi, việc nên làm mà.",
          "explanation": "Cặp đối thoại cảm ơn và đáp từ lịch sự chuẩn mực."
        },
        {
          "chinese": "对不起，我来晚了。没关系，快请进。",
          "pinyin": "Duìbuqǐ, wǒ lái wǎn le. Méi guānxi, kuài qǐng jìn.",
          "translation_vi": "Xin lỗi, tôi đến muộn rồi. Không sao đâu, xin mời vào nhanh.",
          "explanation": "Cặp đối thoại xin lỗi và an ủi thứ lỗi."
        }
      ],
      "hsk_level": "HSK 1",
      "source": "gf0025_2021",
      "validation_status": "verified"
    }
  ],
  "HSK 2": [
    {
      "order_index": 1,
      "name": "Đại từ phân phối \"每\" (Mỗi / Từng)",
      "pattern": "每 (+ Lượng từ) + Danh từ (+ 都 + Động từ/Tính từ)",
      "category": "Đại từ",
      "explanation_vi": "\"每\" (měi) biểu thị từng cá thể đơn lẻ trong một tập thể (mỗi, từng). Khi làm định ngữ hoặc chủ ngữ, phía sau thường đi kèm lượng từ và trong vị ngữ thường có phó từ \"都\" (đều) để nhấn mạnh tính toàn thể không ngoại lệ.",
      "examples": [
        {
          "chinese": "他每天早晨六点都准时起床去公园跑步。",
          "pinyin": "Tā měi tiān zǎochén liù diǎn dōu zhǔnshí qǐchuáng qù gōngyuán pǎobù.",
          "translation_vi": "Anh ấy mỗi ngày vào sáu giờ sáng đều thức dậy đúng giờ đến công viên chạy bộ.",
          "explanation": "\"每天\" kết hợp với \"都\" biểu thị hành động diễn ra lặp lại đều đặn mỗi ngày."
        },
        {
          "chinese": "我们班每个学生都有属于自己的汉语词典。",
          "pinyin": "Wǒmen bān měi gè xuésheng dōu yǒu shǔyú zìjǐ de hànyǔ cídiǎn.",
          "translation_vi": "Mỗi học sinh trong lớp chúng tôi đều có cuốn từ điển tiếng Hán của riêng mình.",
          "explanation": "\"每个\" đứng trước danh từ \"学生\" và đi cùng phó từ \"都\"."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 2,
      "name": "Đại từ nghi vấn phương thức \"怎么\" (Làm sao / Thế nào)",
      "pattern": "怎么 + Động từ / Cụm động từ?",
      "category": "Đại từ",
      "explanation_vi": "\"怎么\" (zěnme) đứng trước động từ để hỏi về cách thức tiến hành của động tác (làm thế nào, đi bằng cách nào, viết ra sao) hoặc nguyên nhân xảy ra sự việc (sao lại, tại sao).",
      "examples": [
        {
          "chinese": "请问去火车站坐几路公共汽车，应该怎么走？",
          "pinyin": "Qǐngwèn qù huǒchēzhàn zuò jǐ lù gōnggòng qìchē, yīnggāi zěnme zǒu?",
          "translation_vi": "Xin hỏi đến ga tàu hỏa thì đi xe buýt tuyến số mấy, nên đi như thế nào?",
          "explanation": "\"怎么走\" là cấu trúc cố định dùng để hỏi đường đi trong giao tiếp hàng ngày."
        },
        {
          "chinese": "这个生词的汉字笔画有点多，怎么写才规范？",
          "pinyin": "Zhè gè shēngcí de hànzì bǐhuà yǒudiǎn duō, zěnme xiě cái guīfàn?",
          "translation_vi": "Chữ Hán của từ mới này nét hơi nhiều, viết thế nào mới đúng chuẩn?",
          "explanation": "\"怎么写\" dùng để hỏi quy cách và thứ tự viết các nét chữ Hán."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 3,
      "name": "Đại từ nghi vấn tính chất / trạng thái \"怎么样\" (Như thế nào)",
      "pattern": "Chủ ngữ + 怎么样? / 怎么样，...?",
      "category": "Đại từ",
      "explanation_vi": "\"怎么样\" (zěnmeyàng) dùng làm vị ngữ để hỏi về tính chất, tình trạng, sức khỏe của người hoặc sự vật, hoặc dùng trong câu hỏi gợi ý để trưng cầu ý kiến người nghe (thấy thế nào, có được không).",
      "examples": [
        {
          "chinese": "今天外面的天气怎么样，需要带雨伞吗？",
          "pinyin": "Jīntiān wàimiàn de tiānqì zěnmeyàng, xūyào dài yǔsǎn ma?",
          "translation_vi": "Thời tiết bên ngoài hôm nay thế nào, có cần mang theo ô không?",
          "explanation": "\"怎么样\" làm vị ngữ hỏi về tình hình thời tiết."
        },
        {
          "chinese": "我们下课后一起去图书馆看书，怎么样？",
          "pinyin": "Wǒmen xiàkè hòu yìqǐ qù túshūguǎn kànshū, zěnmeyàng?",
          "translation_vi": "Chúng ta tan học xong cùng nhau tới thư viện đọc sách, thấy thế nào?",
          "explanation": "\"怎么样\" đặt ở cuối câu để thăm dò và trưng cầu ý kiến đề xuất."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 4,
      "name": "Đại từ nghi vấn nguyên nhân \"为什么\" (Tại sao / Vì sao)",
      "pattern": "为什么 + Chủ ngữ / Vị ngữ? Hoặc Chủ ngữ + 为什么 + Vị ngữ?",
      "category": "Đại từ",
      "explanation_vi": "\"为什么\" (wèishénme) dùng để truy vấn nguyên nhân, mục đích hoặc lý do xảy ra của hành vi hoặc sự việc. Câu trả lời thường bắt đầu bằng liên từ chỉ nguyên nhân \"因为...\" (bởi vì...).",
      "examples": [
        {
          "chinese": "你昨天下午为什么没有来参加中文歌唱比赛？",
          "pinyin": "Nǐ zuótiān xiàwǔ wèishénme méiyǒu lái cānjiā zhōngwén gēchàng bǐsài?",
          "translation_vi": "Chiều hôm qua tại sao bạn không đến tham gia cuộc thi hát tiếng Trung?",
          "explanation": "\"为什么\" đứng trước vị ngữ hỏi rõ lý do vắng mặt."
        },
        {
          "chinese": "他今天心情很好，你知道是因为什么事情吗？",
          "pinyin": "Tā jīntiān xīnqíng hěn hǎo, nǐ zhīdào shì yīnwèi shénme shìqing ma?",
          "translation_vi": "Hôm nay tâm trạng anh ấy rất tốt, bạn có biết là vì chuyện gì không?",
          "explanation": "\"因为什么\" phối hợp hỏi rõ nguyên nhân cụ thể dẫn đến tâm trạng vui vẻ."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 5,
      "name": "Đại từ nhân xưng ngôi thứ ba chỉ sự vật / động vật \"它 / 它们\" (Nó / Chúng nó)",
      "pattern": "它 / 它们 + Vị ngữ",
      "category": "Đại từ",
      "explanation_vi": "\"它\" (tā) dùng để thay thế cho con vật, đồ vật hoặc sự việc ở ngôi thứ ba số ít (nó). Khi ở số nhiều, thêm hậu tố \"们\" thành \"它们\" (chúng, chúng nó).",
      "examples": [
        {
          "chinese": "这只小花猫非常可爱，它的眼睛又大又亮。",
          "pinyin": "Zhè zhī xiǎohuāmāo fēicháng kě'ài, tā de yǎnjīng yòu dà yòu liàng.",
          "translation_vi": "Chú mèo hoa nhỏ này rất đáng yêu, mắt của nó vừa to vừa sáng.",
          "explanation": "\"它的\" là đại từ sở hữu chỉ bộ phận mắt của con mèo."
        },
        {
          "chinese": "动物园里有许多大熊猫，它们正在竹林里吃竹子。",
          "pinyin": "Dòngwùyuán lǐ yǒu xǔduō dàxióngmāo, tāmen zhèngzài zhúlín lǐ chī zhúzi.",
          "translation_vi": "Trong sở thú có nhiều gấu trúc lớn, chúng đang ăn trúc trong rừng trúc.",
          "explanation": "\"它们\" thay thế số nhiều cho bầy gấu trúc lớn."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 6,
      "name": "Số từ hàng trăm \"百\" và hàng nghìn \"千\" (Trăm / Nghìn)",
      "pattern": "Số từ + 百 / 千 (+ Số từ lẻ)",
      "category": "Số từ",
      "explanation_vi": "\"百\" (bǎi) chỉ hàng trăm (100–999) và \"千\" (qiān) chỉ hàng nghìn (1.000–9.999). Khi ở giữa có số 0 (như 105, 1008), dùng chữ \"零\" (líng) để đọc, nếu có nhiều số 0 liên tiếp chỉ đọc một chữ \"零\".",
      "examples": [
        {
          "chinese": "这本现代汉语词典一共有一千五百页。",
          "pinyin": "Zhè běn xiàndài hànyǔ cídiǎn yígòng yǒu yì qiān wǔ bǎi yè.",
          "translation_vi": "Cuốn từ điển Hán ngữ hiện đại này tổng cộng có một nghìn năm trăm trang.",
          "explanation": "\"一千五百\" biểu thị số lượng trang sách hàng nghìn và hàng trăm."
        },
        {
          "chinese": "这件羊毛大衣在商场专卖店售价八百零五块钱。",
          "pinyin": "Zhè jiàn yángmáo dàyī zài shāngchǎng zhuānmàidiàn shòujià bā bǎi líng wǔ kuài qián.",
          "translation_vi": "Chiếc áo khoác dạ len này ở cửa hàng trung tâm thương mại có giá bán là tám trăm linh năm tệ.",
          "explanation": "\"八百零五\" thể hiện cách dùng chữ \"零\" ở hàng chục."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 7,
      "name": "Số thứ tự với tiền tố \"第\" (Thứ / Hạng)",
      "pattern": "第 + Số từ (+ Lượng từ + Danh từ)",
      "category": "Số từ",
      "explanation_vi": "Thêm tiền tố \"第\" (dì) trước số từ để biểu thị thứ tự lớp lang (thứ nhất: 第一, thứ hai: 第二). Khi kết hợp với danh từ, thường có lượng từ đi kèm (như: 第一次, 第二本书).",
      "examples": [
        {
          "chinese": "这是我第一次乘坐高铁去北京参加学术会议。",
          "pinyin": "Zhè shì wǒ dì-yī cì chéngzuò gāotiě qù Běijīng cānjiā xuéshù huìyì.",
          "translation_vi": "Đây là lần đầu tiên tôi đi tàu cao tốc đến Bắc Kinh tham gia hội nghị học thuật.",
          "explanation": "\"第一次\" là số thứ tự biểu thị lần thứ nhất."
        },
        {
          "chinese": "他在全国青少年游泳锦标赛决赛中获得了第一名。",
          "pinyin": "Tā zài quánguó qīng-shàonián yóuyǒng jǐnbiāosài juésài zhōng huòdé le dì-yī míng.",
          "translation_vi": "Anh ấy đã đoạt được hạng nhất trong trận chung kết giải bơi lội thanh thiếu niên toàn quốc.",
          "explanation": "\"第一名\" biểu thị thứ tự xếp hạng vị trí quán quân."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 8,
      "name": "Động lượng từ \"次\" (Lần / Lượt)",
      "pattern": "Động từ + (Số từ) + 次",
      "category": "Lượng từ",
      "explanation_vi": "\"次\" (cì) là động lượng từ thông dụng nhất chỉ số lần diễn ra của động tác hoặc sự kiện. Nó thường đứng sau động từ làm bổ ngữ động lượng (như 去过一次: đã từng đi một lần).",
      "examples": [
        {
          "chinese": "这部感人的纪录片我已经在电影院看了三次。",
          "pinyin": "Zhè bù gǎnrén de jìlùpiàn wǒ yǐjīng zài diànyǐngyuàn kàn le sān cì.",
          "translation_vi": "Bộ phim tài liệu cảm động này tôi đã xem ở rạp chiếu phim tới ba lần.",
          "explanation": "\"看了三次\" biểu thị hành động xem đã lặp lại tổng cộng 3 lần."
        },
        {
          "chinese": "老师耐心地把这道复杂的数学题讲了两次。",
          "pinyin": "Lǎoshī nàixīn de bǎ zhè dào fùzá de shùxué tí jiǎng le liǎng cì.",
          "translation_vi": "Thầy giáo đã kiên nhẫn giảng bài toán phức tạp này hai lần.",
          "explanation": "\"讲了两次\" bổ nghĩa cho số lần tiến hành động tác giảng bài."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 9,
      "name": "Danh lượng từ phương tiện \"辆\" (Chiếc / Xe)",
      "pattern": "Số từ + 辆 + Xe cộ (自行车 / 汽车 / 公共汽车)",
      "category": "Lượng từ",
      "explanation_vi": "\"辆\" (liàng) là lượng từ chuyên dụng dùng cho các loại phương tiện giao thông trên cạn có bánh xe như xe đạp (自行车), xe con (汽车), xe buýt (公共汽车).",
      "examples": [
        {
          "chinese": "爸爸上个月为我买了一辆崭新的山地自行车。",
          "pinyin": "Bàba shàng gè yuè wèi wǒ mǎi le yí liàng zhǎnxīn de shāndì zìxíngchē.",
          "translation_vi": "Tháng trước bố đã mua cho tôi một chiếc xe đạp leo núi mới toanh.",
          "explanation": "\"一辆...自行车\" là kết cấu lượng từ tiêu chuẩn dùng cho xe đạp."
        },
        {
          "chinese": "公司门口的停车场里整齐地停着十辆白色轿车。",
          "pinyin": "Gōngsī ménkǒu de tíngchēchǎng lǐ zhěngqí de tíng zhe shí liàng báisè jiàochē.",
          "translation_vi": "Trong bãi đỗ xe trước cửa công ty đang đỗ ngay ngắn mười chiếc ô tô con màu trắng.",
          "explanation": "\"十辆\" chỉ số lượng xe hơi đang dừng đỗ."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 10,
      "name": "Danh lượng từ y phục / sự việc \"件\" (Chiếc / Kiện / Việc)",
      "pattern": "Số từ + 件 + Áo quần / Đồ vật / Sự việc",
      "category": "Lượng từ",
      "explanation_vi": "\"件\" (jiàn) là lượng từ dùng cho áo quần phần thân trên (áo sơ mi, áo khoác, áo len: 一件衬衫), hành lý đồ đạc (一件行李) hoặc sự tình, công việc (一件事).",
      "examples": [
        {
          "chinese": "商场正在打折促销，她挑中了一件红色的毛衣。",
          "pinyin": "Shāngchǎng zhèngzài dǎzhé cùxiāo, tā tiāo zhòng le yí jiàn hóngsè de máoyī.",
          "translation_vi": "Trung tâm thương mại đang giảm giá khuyến mãi, cô ấy đã chọn trúng một chiếc áo len màu đỏ.",
          "explanation": "\"一件毛衣\" là cách dùng lượng từ cho trang phục áo len."
        },
        {
          "chinese": "今天在办公室发生了一件非常有趣的开心事。",
          "pinyin": "Jīntiān zài bàngōngshì fāshēng le yí jiàn fēicháng yǒuqù de kāixīn shì.",
          "translation_vi": "Hôm nay ở văn phòng đã xảy ra một chuyện vui vô cùng thú vị.",
          "explanation": "\"一件...事\" biểu thị lượng từ cho sự việc phát sinh."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 11,
      "name": "Danh lượng từ vật dài / mềm \"条\" (Con / Sợi / Chiếc)",
      "pattern": "Số từ + 条 + Quần / Khăn / Sông / Cá",
      "category": "Lượng từ",
      "explanation_vi": "\"条\" (tiáo) là lượng từ dùng cho các vật thể có hình dáng thon dài hoặc uốn lượn như sông ngòi (一条河), đường xá (一条路), quần (一条裤子), cá (一条鱼), khăn quàng (一条围巾).",
      "examples": [
        {
          "chinese": "这条清澈的小河绕着美丽的小山村缓缓流过。",
          "pinyin": "Zhè tiáo qīngchè de xiǎohé rào zhe měilì de xiǎoshāncūn huǎnhuǎn liúguò.",
          "translation_vi": "Dòng sông nhỏ trong vắt này chảy êm đềm uốn quanh ngôi làng núi xinh đẹp.",
          "explanation": "\"这条小河\" dùng cho con sông uốn lượn thon dài."
        },
        {
          "chinese": "妈妈在超市买了三条新鲜的鲤鱼准备做晚饭。",
          "pinyin": "Māma zài chāoshì mǎi le sān tiáo xīnxiān de lǐyú zhǔnbèi zuò wǎnfàn.",
          "translation_vi": "Mẹ đã mua ba con cá chép tươi ở siêu thị chuẩn bị nấu bữa tối.",
          "explanation": "\"三条...鲤鱼\" là cách dùng lượng từ cho loài cá."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 12,
      "name": "Danh lượng từ vật phẳng \"张\" (Tấm / Tờ / Chiếc)",
      "pattern": "Số từ + 张 + Giấy / Vé / Bàn / Giường",
      "category": "Lượng từ",
      "explanation_vi": "\"张\" (zhāng) là lượng từ dùng cho các vật mỏng phẳng hoặc có bề mặt mở rộng như tờ giấy (一张纸), tấm vé (一张票), bức ảnh (一张照片), cái bàn (一张桌子), chiếc giường (一张床).",
      "examples": [
        {
          "chinese": "他从皮夹里拿出一张全家人的幸福合影照片。",
          "pinyin": "Tā cóng píjiá lǐ ná chū yì zhāng quánjiā rén de xìngfú héyǐng zhàopiàn.",
          "translation_vi": "Anh ấy lấy từ trong ví ra một tấm ảnh chụp chung hạnh phúc của cả gia đình.",
          "explanation": "\"一张...照片\" dùng cho bức ảnh phẳng mỏng."
        },
        {
          "chinese": "我已经提前在网上预订好了两张今晚的话剧票。",
          "pinyin": "Wǒ yǐjīng tíqián zài wǎngshang yùdìng hǎo le liǎng zhāng jīnwǎn de huàjù piào.",
          "translation_vi": "Tôi đã đặt trước trên mạng xong xuôi hai tấm vé kịch nói tối nay.",
          "explanation": "\"两张...票\" dùng cho vé vào cửa."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 13,
      "name": "Danh lượng từ đôi / cặp \"双\" (Đôi / Cặp)",
      "pattern": "Số từ + 双 + Giày / Tất / Đũa / Mắt",
      "category": "Lượng từ",
      "explanation_vi": "\"双\" (shuāng) dùng cho những đồ vật đi liền thành một cặp gồm hai chiếc cùng loại như giày dép (一双鞋), tất vớ (一双袜子), đũa (一双筷子), hoặc bàn tay/đôi mắt (一双手 / 一双眼睛).",
      "examples": [
        {
          "chinese": "这双运动鞋穿起来特别轻便舒适，适合跑步。",
          "pinyin": "Zhè shuāng yùndòngxié chuān qǐlai tèbié qīngbiàn shūshì, shìhé pǎobù.",
          "translation_vi": "Đôi giày thể thao này đi vào đặc biệt nhẹ nhàng êm ái, rất hợp để chạy bộ.",
          "explanation": "\"这双运动鞋\" là lượng từ chỉ đôi giày đi liền nhau."
        },
        {
          "chinese": "服务员，请给我们多拿两双干净的木筷子。",
          "pinyin": "Fúwùyuán, qǐng gěi wǒmen duō ná liǎng shuāng gānjìng de mù kuàizi.",
          "translation_vi": "Phục vụ ơi, xin lấy thêm cho chúng tôi hai đôi đũa gỗ sạch sẽ nhé.",
          "explanation": "\"两双...筷子\" dùng cho đũa ăn cơm."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 14,
      "name": "Lượng từ cân lượng \"斤\" và tiền tệ \"元 / 块 / 角 / 毛\"",
      "pattern": "Số từ + 斤 / 块 / 毛 (+ Danh từ)",
      "category": "Lượng từ",
      "explanation_vi": "\"斤\" (jīn) là cân Trung Quốc (= 500g). Về tiền tệ, văn viết dùng \"元\" (yuán) và \"角\" (jiǎo), trong khẩu ngữ đời thường dùng \"块\" (kuài) và \"毛\" (máo). 1 元/块 = 10 角/毛.",
      "examples": [
        {
          "chinese": "这种红富士苹果五块五毛钱一斤，很甜。",
          "pinyin": "Zhè zhǒng hóngfùshì píngguǒ wǔ kuài wǔ máo qián yì jīn, hěn tián.",
          "translation_vi": "Loại táo Phú Sĩ đỏ này năm tệ rưỡi một cân (500g), rất ngọt.",
          "explanation": "\"五块五毛\" chỉ giá tiền khẩu ngữ và \"一斤\" chỉ đơn vị trọng lượng."
        },
        {
          "chinese": "他在菜市场买了三斤新鲜的西红柿和两斤土豆。",
          "pinyin": "Tā zài càishìchǎng mǎi le sān jīn xīnxiān de xīhóngshì hé liǎng jīn tǔdòu.",
          "translation_vi": "Anh ấy đã mua ba cân cà chua tươi và hai cân khoai tây ở chợ rau.",
          "explanation": "\"三斤\" và \"两斤\" định lượng khối lượng rau củ quả."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 15,
      "name": "Phó từ mức độ cảm thán \"真\" (Thật / Thật là)",
      "pattern": "真 + Tính từ / Cụm động từ tâm lý (+ 啊)!",
      "category": "Phó từ",
      "explanation_vi": "\"真\" (zhēn) đứng trước tính từ hoặc động từ tâm lý để bày tỏ thái độ tán thán, ngợi ca hoặc khẳng định mạnh mẽ từ đáy lòng (thật là, quả là). Cuối câu thường có trợ từ ngữ khí \"啊\".",
      "examples": [
        {
          "chinese": "春天的桂林山水风景真美丽啊！",
          "pinyin": "Chūntiān de Guìlín shānshuǐ fēngjǐng zhēn měilì a!",
          "translation_vi": "Phong cảnh non nước Quế Lâm vào mùa xuân thật là tươi đẹp biết bao!",
          "explanation": "\"真美丽\" nhấn mạnh mức độ cảm thán trước vẻ đẹp non nước."
        },
        {
          "chinese": "你做的那道红烧牛肉真好吃，大家都很喜欢。",
          "pinyin": "Nǐ zuò de nà dào hóngshāo niúròu zhēn hǎochī, dàjiā dōu hěn xǐhuan.",
          "translation_vi": "Món thịt bò kho mà bạn nấu thật là ngon miệng, mọi người đều rất thích.",
          "explanation": "\"真好吃\" khen ngợi hương vị món ăn xuất sắc."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 16,
      "name": "Phó từ mức độ tuyệt đối \"最\" (Nhất / Bậc nhất)",
      "pattern": "最 + Tính từ / Động từ tâm lý (+ Danh từ)",
      "category": "Phó từ",
      "explanation_vi": "\"最\" (zuì) biểu thị mức độ cao nhất trong các đối tượng so sánh (nhất). Thường đứng trước tính từ (như: 最好: tốt nhất, 最小: nhỏ nhất) hoặc động từ tâm lý (như: 最喜欢: thích nhất, 最爱: yêu nhất).",
      "examples": [
        {
          "chinese": "一年四季当中，我最喜欢的季节是凉爽的秋天。",
          "pinyin": "Yì nián sìjì dāngzhōng, wǒ zuì xǐhuan de jìjié shì liángshuǎng de qiūtiān.",
          "translation_vi": "Trong bốn mùa một năm, mùa tôi yêu thích nhất là mùa thu mát mẻ.",
          "explanation": "\"最喜欢\" chỉ sở thích cao nhất trong 4 mùa."
        },
        {
          "chinese": "他是我们长跑训练队里速度最快的优秀运动员。",
          "pinyin": "Tā shì wǒmen chángpǎo xùnliànduì lǐ sùdù zuì kuài de yōuxiù yùndòngyuán.",
          "translation_vi": "Anh ấy là vận động viên xuất sắc có tốc độ nhanh nhất trong đội chạy dài của chúng tôi.",
          "explanation": "\"最快\" so sánh tốc độ đứng đầu toàn đội."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 17,
      "name": "Phó từ thời gian hoàn thành \"已经\" (Đã / Đã từng)",
      "pattern": "Chủ ngữ + 已经 + Động từ / Tính từ (+ 了)",
      "category": "Phó từ",
      "explanation_vi": "\"已经\" (yǐjīng) biểu thị động tác đã hoàn thành hoặc trạng thái đã đạt đến một giai đoạn nhất định (đã). Cuối câu hoặc sau động từ thường đi kèm trợ từ ngữ khí \"了\".",
      "examples": [
        {
          "chinese": "飞机已经准时降落在首都国际机场了。",
          "pinyin": "Fēijī yǐjīng zhǔnshí jiàngluò zài shǒudū guójì jīchǎng le.",
          "translation_vi": "Máy bay đã hạ cánh đúng giờ xuống sân bay quốc tế thủ đô rồi.",
          "explanation": "\"已经...了\" biểu thị sự việc hạ cánh đã hoàn tất."
        },
        {
          "chinese": "爷爷的身体已经完全康复了，请大家放心。",
          "pinyin": "Yéye de shēntǐ yǐjīng wánquán kāngfù le, qǐng dàjiā fàngxīn.",
          "translation_vi": "Sức khỏe của ông nội đã hoàn toàn hồi phục rồi, xin mọi người hãy yên tâm.",
          "explanation": "\"已经...了\" chỉ trạng thái phục hồi sức khỏe trọn vẹn."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 18,
      "name": "Phó từ tiếp diễn hành động \"正 / 正在 / 在\" (Đang)",
      "pattern": "Chủ ngữ + 正 / 正在 / 在 + Động từ (+ Tân ngữ) (+ 呢)",
      "category": "Phó từ",
      "explanation_vi": "\"正\" (zhèng), \"在\" (zài) hoặc \"正在\" (zhèngzài) đứng trước động từ để biểu thị hành động đang trong quá trình tiến hành tại một thời điểm nhất định (đang). Cuối câu thường kết hợp trợ từ \"呢\".",
      "examples": [
        {
          "chinese": "同学们正在教室里认真地听老师讲课呢。",
          "pinyin": "Tóngxué men zhèngzài jiàoshì lǐ rènzhēn de tīng lǎoshī jiǎngkè ne.",
          "translation_vi": "Các bạn học sinh đang chăm chú nghe thầy giáo giảng bài trong lớp học.",
          "explanation": "\"正在...呢\" miêu tả hành động nghe giảng đang diễn ra tại thời điểm nói."
        },
        {
          "chinese": "爸爸在书房里看新闻，你不要大声说话。",
          "pinyin": "Bàba zài shūfáng lǐ kàn xīnwén, nǐ bú yào dàshēng shuōhuà.",
          "translation_vi": "Bố đang xem tin tức trong phòng sách, bạn đừng nói to nhé.",
          "explanation": "\"在看\" biểu thị trạng thái đang xem tin tức."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 19,
      "name": "Phó từ thời gian sớm / nhanh \"就\" (Đã / Liền / Ngay)",
      "pattern": "Thời gian + 就 + Động từ / Động từ 1 + 就 + Động từ 2",
      "category": "Phó từ",
      "explanation_vi": "\"就\" (jiù) đứng trước động từ để nhấn mạnh hành động xảy ra sớm, nhanh chóng, thuận lợi ngoài dự liệu (đã, liền, ngay). Đối lập với \"才\" (mới - muộn).",
      "examples": [
        {
          "chinese": "他今天早晨五点半就起床去跑步了。",
          "pinyin": "Tā jīntiān zǎochén wǔ diǎn bàn jiù qǐchuáng qù pǎobù le.",
          "translation_vi": "Anh ấy sáng nay năm rưỡi đã thức dậy đi chạy bộ rồi.",
          "explanation": "\"五点半就\" nhấn mạnh thức dậy rất sớm."
        },
        {
          "chinese": "我一吃完早饭就立刻坐地铁去公司上班。",
          "pinyin": "Wǒ yì chī wán zǎofàn jiù lìkè zuò dìtiě qù gōngsī shàngbān.",
          "translation_vi": "Tôi vừa ăn xong bữa sáng là lập tức đi tàu điện ngầm tới công ty đi làm ngay.",
          "explanation": "\"一...就...\" thể hiện hành động thứ hai diễn ra liền ngay sau hành động một."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 20,
      "name": "Phó từ duy trì trạng thái \"还\" (Vẫn / Còn)",
      "pattern": "Chủ ngữ + 还 + Động từ / Tính từ",
      "category": "Phó từ",
      "explanation_vi": "\"还\" (hái) biểu thị hành động hoặc trạng thái vốn có từ trước vẫn tiếp tục tiếp diễn chưa kết thúc (vẫn, còn). Phủ định thường dùng \"还没\" (vẫn chưa).",
      "examples": [
        {
          "chinese": "现在已经晚上十点了，他还在实验室里做化学实验。",
          "pinyin": "Xiànzài yǐjīng wǎnshang shí diǎn le, tā hái zài shíyànshì lǐ zuò huàxué shíyàn.",
          "translation_vi": "Bây giờ đã mười giờ đêm rồi, anh ấy vẫn đang làm thí nghiệm hóa học trong phòng thí nghiệm.",
          "explanation": "\"还在\" biểu thị hành vi làm thí nghiệm vẫn tiếp tục kéo dài tới đêm."
        },
        {
          "chinese": "外面虽然雨停了，但是天气还是很冷。",
          "pinyin": "Wàimiàn suīrán yǔ tíng le, dànshì tiānqì hái shì hěn lěng.",
          "translation_vi": "Bên ngoài tuy mưa đã tạnh, nhưng thời tiết vẫn còn rất lạnh.",
          "explanation": "\"还是\" nhấn mạnh tình trạng rét lạnh vẫn duy trì."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 21,
      "name": "Phó từ lặp lại trong tương lai \"再\" (Lại / Nữa / Hãy)",
      "pattern": "再 + Động từ (+ Tân ngữ)",
      "category": "Phó từ",
      "explanation_vi": "\"再\" (zài) biểu thị một hành động sẽ được lặp lại hoặc tiếp tục trong tương lai (lại, nữa), hoặc biểu thị hành động làm sau khi một điều kiện hoàn thành (rồi hãy...). Khác với \"又\" (đã lặp lại trong quá khứ).",
      "examples": [
        {
          "chinese": "这道中国名菜味道太好了，我下次还要再来吃一次。",
          "pinyin": "Zhè dào zhōngguó míngcài wèidào tài hǎo le, wǒ xià cì hái yào zài lái chī yí cì.",
          "translation_vi": "Món ăn danh tiếng Trung Quốc này hương vị ngon quá, lần sau tôi nhất định sẽ lại đến ăn lần nữa.",
          "explanation": "\"再来吃\" chỉ hành động ăn lặp lại ở lần sau (tương lai)."
        },
        {
          "chinese": "请大家先把课文读熟，然后再回答思考题。",
          "pinyin": "Qǐng dàjiā xiān bǎ kèwén dú shú, ránhòu zài huídá sīkǎotí.",
          "translation_vi": "Xin mời mọi người trước tiên đọc kỹ bài khóa, sau đó hãy trả lời các câu hỏi suy ngẫm.",
          "explanation": "\"然后再\" biểu thị thứ tự hành động làm sau."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 22,
      "name": "Phó từ hợp tác \"一起\" (Cùng nhau / Cùng)",
      "pattern": "一起 + Động từ (+ Tân ngữ) / 和 / 跟 + Ai + 一起 + Động từ",
      "category": "Phó từ",
      "explanation_vi": "\"一起\" (yìqǐ) biểu thị nhiều người cùng tham gia vào một địa điểm hoặc cùng tiến hành một hoạt động (cùng nhau). Thường kết hợp với giới từ \"和 / 跟\" (và, cùng).",
      "examples": [
        {
          "chinese": "周末我和大学同学一起去郊区爬山看红叶。",
          "pinyin": "Zhōumò wǒ hé dàxué tóngxué yìqǐ qù jiāoqū páshān kàn hóngyè.",
          "translation_vi": "Cuối tuần tôi cùng các bạn đại học cùng nhau đi leo núi ngắm lá đỏ ở ngoại ô.",
          "explanation": "\"和...一起\" chỉ sự phối hợp hoạt động leo núi của nhiều người."
        },
        {
          "chinese": "大家坐在一起热烈讨论关于汉语学习的有效方法。",
          "pinyin": "Dàjiā zuò zài yìqǐ rèliè tǎolùn guānyú hànyǔ xuéxí de yǒuxiào fāngfǎ.",
          "translation_vi": "Mọi người ngồi lại cùng nhau thảo luận sôi nổi về phương pháp học tiếng Hán hiệu quả.",
          "explanation": "\"坐在一起\" biểu thị vị trí tập hợp cùng một chỗ."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 23,
      "name": "Phó từ khuyên ngăn phủ định \"别\" (Đừng / Chớ)",
      "pattern": "别 + Động từ / Cụm động từ (+ 了)!",
      "category": "Phó từ",
      "explanation_vi": "\"别\" (bié) dùng trong câu cầu khiến phủ định để khuyên bảo, ngăn cản ai đó không nên làm một việc gì (đừng, chớ). Cuối câu có thể thêm \"了\" để khuyên dừng hành động đang làm.",
      "examples": [
        {
          "chinese": "医生叮嘱病人今天晚上千万别吃辛辣油腻的食物。",
          "pinyin": "Yīshēng dīngzhǔ bìngrén jīntiān wǎnshang qiānwàn bié chī xīnlà yóunì de shíwù.",
          "translation_vi": "Bác sĩ dặn dò bệnh nhân tối hôm nay tuyệt đối đừng ăn đồ ăn cay nóng nhiều dầu mỡ.",
          "explanation": "\"别吃\" là lời khuyên răn ngăn cản kiêng khem ăn uống."
        },
        {
          "chinese": "考试时间快到了，大家别说话了，专心答卷。",
          "pinyin": "Kǎoshì shíjiān kuài dào le, dàjiā bié shuōhuà le, zhuānxīn dájuàn.",
          "translation_vi": "Giờ thi sắp tới rồi, mọi người đừng nói chuyện nữa, hãy tập trung làm bài.",
          "explanation": "\"别说话了\" khuyên dừng hành động đang nói chuyện lại."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 24,
      "name": "Phó từ đồng nhất \"也\" (Cũng)",
      "pattern": "Chủ ngữ 1 + Vị ngữ, Chủ ngữ 2 + 也 + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"也\" (yě) đứng trước động từ hoặc tính từ để biểu thị sự đồng nhất về tính chất, trạng thái hoặc hành vi với đối tượng được đề cập trước đó (cũng). Luôn đứng trước phó từ phủ định 不/没.",
      "examples": [
        {
          "chinese": "他很喜欢喝中国茶，他的妹妹也很喜欢喝绿茶。",
          "pinyin": "Tā hěn xǐhuan hē zhōngguó chá, tā de mèimei yě hěn xǐhuan hē lǜchá.",
          "translation_vi": "Anh ấy rất thích uống trà Trung Quốc, em gái anh ấy cũng rất thích uống trà xanh.",
          "explanation": "\"也\" biểu thị em gái có sở thích tương tự như người anh."
        },
        {
          "chinese": "我今天没去图书馆，小明今天也没有去。",
          "pinyin": "Wǒ jīntiān méi qù túshūguǎn, Xiǎomíng jīntiān yě méiyǒu qù.",
          "translation_vi": "Hôm nay tôi không đến thư viện, Tiểu Minh hôm nay cũng không đi.",
          "explanation": "\"也没有\" đứng trước cụm phủ định biểu thị sự đồng nhất về việc không đi."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 25,
      "name": "Phó từ tổng quát \"都\" (Đều / Tất cả)",
      "pattern": "Chủ ngữ số nhiều + 都 + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"都\" (dōu) đứng trước động từ hoặc tính từ để bao hàm toàn bộ các chủ thể hoặc đối tượng phía trước không có ngoại lệ (đều, tất cả). Khi phủ định toàn bộ dùng \"都不\", phủ định một phần dùng \"不都\".",
      "examples": [
        {
          "chinese": "我们班的外国留学生都顺利通过了汉语水平考试。",
          "pinyin": "Wǒmen bān de wàiguó liúxuéshēng dōu shùnlì tōngguò le hànyǔ shuǐpíng kǎoshì.",
          "translation_vi": "Các lưu học sinh nước ngoài của lớp chúng tôi đều đã thuận lợi vượt qua kỳ thi năng lực Hán ngữ.",
          "explanation": "\"都通过\" nhấn mạnh toàn thể mọi học sinh không ai trượt."
        },
        {
          "chinese": "这些新鲜的水果都是从海南岛空运过来的。",
          "pinyin": "Zhèxiē xīnxiān de shuǐguǒ dōu shì cóng Hǎinándǎo kōngyùn guòlái de.",
          "translation_vi": "Những loại hoa quả tươi này đều là được vận chuyển bằng đường hàng không từ đảo Hải Nam tới.",
          "explanation": "\"都是\" xác nhận toàn bộ số hoa quả có cùng nguồn gốc."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 26,
      "name": "Cấu trúc vừa... vừa... \"又...又...\"",
      "pattern": "又 + Tính từ 1 + 又 + Tính từ 2 / 又 + Động từ 1 + 又 + Động từ 2",
      "category": "Liên từ",
      "explanation_vi": "Cấu trúc \"又...又...\" (yòu...yòu...) liên kết hai tính từ hoặc động từ có tính chất tương đương cùng tồn tại song song trong một chủ thể (vừa... lại vừa...). Hai thành phần liên kết phải cùng tích cực hoặc cùng tiêu cực.",
      "examples": [
        {
          "chinese": "这家新开的面馆做的面条又便宜又好吃。",
          "pinyin": "Zhè jiā xīn kāi de miànguǎn zuò de miàntiáo yòu piányi yòu hǎochī.",
          "translation_vi": "Mì do quán mì mới mở này nấu vừa rẻ lại vừa ngon miệng.",
          "explanation": "\"又便宜又好吃\" liên kết hai tính từ tích cực ca ngợi quán mì."
        },
        {
          "chinese": "超市里买来的西瓜个头又大又甜，水分很足。",
          "pinyin": "Chāoshì lǐ mǎi lái de xīguā gètóu yòu dà yòu tián, shuǐfèn hěn zú.",
          "translation_vi": "Quả dưa hấu mua ở siêu thị về quả vừa to lại vừa ngọt, mọng nước vô cùng.",
          "explanation": "\"又大又甜\" miêu tả hai đặc điểm nổi bật của quả dưa hấu."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 27,
      "name": "Liên từ nhân quả \"因为...所以...\" (Bởi vì... cho nên...)",
      "pattern": "因为 + Nguyên nhân, 所以 + Kết quả",
      "category": "Liên từ",
      "explanation_vi": "Cặp liên từ \"因为...所以...\" (yīnwèi... suǒyǐ...) dùng để biểu thị mối quan hệ nhân quả. Phân câu trước nêu lý do, phân câu sau nêu kết quả dẫn tới. Trong giao tiếp khẩu ngữ có thể lược bỏ \"因为\" hoặc \"所以\".",
      "examples": [
        {
          "chinese": "因为今天早晨突降大雨，所以我们取消了去郊区的野餐计划。",
          "pinyin": "Yīnwèi jīntiān zǎochén tūjiàng dàyǔ, suǒyǐ wǒmen qǔxiāo le qù jiāoqū de yěcān jìhuà.",
          "translation_vi": "Bởi vì sáng nay trời bất chợt đổ mưa to, cho nên chúng tôi đã hủy bỏ kế hoạch đi dã ngoại ngoại ô.",
          "explanation": "\"因为...所以...\" liên kết nguyên nhân trời mưa với kết quả hủy kế hoạch."
        },
        {
          "chinese": "因为他平时勤奋刻苦，所以这次汉语考试取得了好成绩。",
          "pinyin": "Yīnwèi tā píngrì qínfèn kèkǔ, suǒyǐ zhè cì hànyǔ kǎoshì qǔdé le hǎo chéngjì.",
          "translation_vi": "Bởi vì thường ngày anh ấy chăm chỉ khổ luyện, cho nên kỳ thi tiếng Hán lần này đã đạt được thành tích tốt.",
          "explanation": "Biểu thị nguyên nhân học tập chăm chỉ dẫn đến kết quả thi tốt."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 28,
      "name": "Liên từ chuyển ngoặt \"虽然...但是...\" (Tuy rằng... nhưng mà...)",
      "pattern": "虽然 + Phân câu nhượng bộ, 但是 / 可是 + Phân câu chuyển ngoặt",
      "category": "Liên từ",
      "explanation_vi": "Cặp liên từ \"虽然...但是...\" (suīrán... dànshì...) biểu thị mối quan hệ nhượng bộ và chuyển ngoặt (tuy... nhưng...). Phân câu sau chuyển hướng ý nghĩa ngược lại hoặc bổ sung khía cạnh khác so với phân câu trước.",
      "examples": [
        {
          "chinese": "这道中国菜虽然看起来有点辣，但是吃起来非常香。",
          "pinyin": "Zhè dào zhōngguócài suīrán kàn qǐlai yǒudiǎn là, dànshì chī qǐlai fēicháng xiāng.",
          "translation_vi": "Món ăn Trung Quốc này tuy nhìn có vẻ hơi cay, nhưng ăn vào lại vô cùng thơm ngon.",
          "explanation": "\"虽然...但是...\" thể hiện sự chuyển biến từ vẻ bề ngoài tới hương vị thực tế."
        },
        {
          "chinese": "他虽然学习汉语的时间不长，但是发音非常准确流利。",
          "pinyin": "Tā suīrán xuéxí hànyǔ de shíjiān bù cháng, dànshì fāyīn fēicháng zhǔnquè liúlì.",
          "translation_vi": "Anh ấy tuy thời gian học tiếng Hán chưa lâu, nhưng phát âm lại vô cùng chuẩn xác lưu loát.",
          "explanation": "Chuyển ngoặt giữa thời gian học ngắn và phát âm tốt."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 29,
      "name": "Liên từ lựa chọn câu trần thuật \"或者\" (Hoặc / Hoặc là)",
      "pattern": "Lựa chọn A + 或者 + Lựa chọn B",
      "category": "Liên từ",
      "explanation_vi": "\"或者\" (huòzhě) dùng để liên kết các sự vật, hành động có tính chất lựa chọn trong câu trần thuật hoặc câu khẳng định (hoặc, hoặc là). Không dùng trong câu hỏi nghi vấn lựa chọn (câu hỏi dùng \"还是\").",
      "examples": [
        {
          "chinese": "周末我通常在家里安静看书，或者去公园散步。",
          "pinyin": "Zhōumò wǒ tōngcháng zài jiā lǐ ānjìng kànshū, huòzhě qù gōngyuán sànbù.",
          "translation_vi": "Cuối tuần tôi thường yên tĩnh đọc sách ở nhà, hoặc là đến công viên đi dạo.",
          "explanation": "\"或者\" dùng trong câu trần thuật nối hai hoạt động lựa chọn cuối tuần."
        },
        {
          "chinese": "你可以选择喝热咖啡，或者喝新鲜的苹果汁。",
          "pinyin": "Nǐ kěyǐ xuǎnzé hē rè kāfēi, huòzhě hē xīnxiān de píngguǒzhī.",
          "translation_vi": "Bạn có thể lựa chọn uống cà phê nóng, hoặc là uống nước ép táo tươi.",
          "explanation": "\"或者\" đưa ra 2 phương án đồ uống cho người nghe."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 30,
      "name": "Liên từ lựa chọn câu nghi vấn \"还是\" (Hay là / Hay)",
      "pattern": "Phương án A + 还是 + Phương án B?",
      "category": "Liên từ",
      "explanation_vi": "\"还是\" (háishì) dùng trong câu hỏi lựa chọn để yêu cầu người nghe chọn một trong hai hoặc nhiều phương án được đưa ra (hay là, hoặc). Thường kết thúc bằng dấu chấm hỏi \"?\".",
      "examples": [
        {
          "chinese": "请问你想喝热茶还是想喝冰水？",
          "pinyin": "Qǐngwèn nǐ xiǎng hē rè chá háishì xiǎng hē bīngshuǐ?",
          "translation_vi": "Xin hỏi bạn muốn uống trà nóng hay là muốn uống nước đá?",
          "explanation": "\"还是\" dùng trong câu hỏi lựa chọn giữa trà nóng và nước đá."
        },
        {
          "chinese": "我们明天坐高铁去上海，还是坐飞机去？",
          "pinyin": "Wǒmen míngtiān zuò gāotiě qù Shànghǎi, háishì zuò fēijī qù?",
          "translation_vi": "Ngày mai chúng ta đi tàu cao tốc đến Thượng Hải, hay là đi máy bay?",
          "explanation": "Hỏi lựa chọn phương tiện di chuyển."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 31,
      "name": "Liên từ thứ tự thời gian \"然后\" (Sau đó / Rồi)",
      "pattern": "Hành động 1, 然后 + Hành động 2",
      "category": "Liên từ",
      "explanation_vi": "\"然后\" (ránhòu) là liên từ biểu thị sự tiếp nối tuần tự của hai hành động theo trình tự thời gian (sau đó, rồi thì). Thường đi liền trong chuỗi: \"先...然后...\" (trước tiên... sau đó...).",
      "examples": [
        {
          "chinese": "我们先去超市买蔬菜，然后回家一起做晚饭。",
          "pinyin": "Wǒmen xiān qù chāoshì mǎi shūcài, ránhòu huíjiā yìqǐ zuò wǎnfàn.",
          "translation_vi": "Chúng ta trước tiên đến siêu thị mua rau, sau đó về nhà cùng nhau nấu cơm tối.",
          "explanation": "\"先...然后...\" chỉ rõ trình tự trước sau của việc đi chợ và nấu ăn."
        },
        {
          "chinese": "你先填写这张个人表格，然后去二楼会议室面试。",
          "pinyin": "Nǐ xiān tiánxiě zhè zhāng gèrén biǎogé, ránhòu qù èr lóu huìyìshì miànshì.",
          "translation_vi": "Bạn trước tiên hãy điền vào phiếu cá nhân này, sau đó lên phòng họp tầng hai phỏng vấn.",
          "explanation": "Chỉ dẫn quy trình làm việc theo thứ tự."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 32,
      "name": "Giới từ đối tượng tiếp nhận \"给\" (Cho / Cho ai)",
      "pattern": "Chủ ngữ + 给 + Đối tượng + Động từ (+ Tân ngữ)",
      "category": "Giới từ",
      "explanation_vi": "\"给\" (gěi) làm giới từ đứng trước danh từ chỉ người hoặc tổ chức để chỉ đối tượng phục vụ hoặc người tiếp nhận hành động (cho, cho ai đó, tặng cho).",
      "examples": [
        {
          "chinese": "爸爸每天早晨都耐心地给我讲一个有趣的成语故事。",
          "pinyin": "Bàba měitiān zǎochén dōu nàixīn de gěi wǒ jiǎng yí gè yǒuqù de chéngyǔ gùshì.",
          "translation_vi": "Mỗi sáng sớm bố đều kiên nhẫn kể cho tôi nghe một câu chuyện thành ngữ thú vị.",
          "explanation": "\"给我讲\" biểu thị đối tượng lắng nghe câu chuyện là tôi."
        },
        {
          "chinese": "母亲正在厨房里给全家人准备丰盛可口的午饭。",
          "pinyin": "Mǔqīn zhèngzài chúfáng lǐ gěi quán jiārén zhǔnbèi fēngshèng kěkǒu de wǔfàn.",
          "translation_vi": "Người mẹ đang ở trong bếp chuẩn bị bữa trưa thịnh soạn ngon miệng cho cả gia đình.",
          "explanation": "\"给全家人准备\" chỉ đối tượng thụ hưởng bữa cơm trưa."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 33,
      "name": "Giới từ khởi điểm \"从\" (Từ / Bắt đầu từ)",
      "pattern": "从 + Nơi chốn / Thời gian + Động từ (+ 到...)",
      "category": "Giới từ",
      "explanation_vi": "\"从\" (cóng) biểu thị mốc xuất phát về không gian, thời gian hoặc phạm vi (từ, bắt đầu từ). Thường phối hợp với \"到\" (đến) tạo thành kết cấu \"从...到...\" (từ... đến...).",
      "examples": [
        {
          "chinese": "这趟高铁从北京出发，只需要四个小时就到上海。",
          "pinyin": "Zhè tàng gāotiě cóng Běijīng chūfā, zhǐ xūyào sì gè xiǎoshí jiù dào Shànghǎi.",
          "translation_vi": "Chuyến tàu cao tốc này xuất phát từ Bắc Kinh, chỉ cần bốn tiếng đồng hồ là đến Thượng Hải.",
          "explanation": "\"从北京出发\" chỉ điểm khởi hành về mặt địa lý."
        },
        {
          "chinese": "他从星期一到星期五都在大学图书馆认真复习功课。",
          "pinyin": "Tā cóng xīngqīyī dào xīngqīwǔ dōu zài dàxué túshūguǎn rènzhēn fùxí gōngkè.",
          "translation_vi": "Anh ấy từ thứ Hai đến thứ Sáu đều ở thư viện trường đại học chăm chỉ ôn bài.",
          "explanation": "\"从...到...\" biểu thị khoảng thời gian từ đầu tuần tới cuối tuần."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 34,
      "name": "Giới từ phương hướng chuyển động \"往\" (Về phía / Hướng về)",
      "pattern": "往 + Phương hướng / Địa điểm + Động từ (走 / 开 / 看 / 飞)",
      "category": "Giới từ",
      "explanation_vi": "\"往\" (wǎng) chỉ phương hướng mục tiêu của hành động di chuyển (hướng về phía, đi về phía). Thường đi với các động từ chỉ sự di chuyển như: 往东走 (đi về phía Đông), 往前看 (nhìn về phía trước).",
      "examples": [
        {
          "chinese": "从这个十字路口一直往前走两百米就是市立医院。",
          "pinyin": "Cóng zhè gè shízì-lùkǒu yìzhí wǎng qián zǒu liǎng bǎi mǐ jiù shì shìlì yīyuàn.",
          "translation_vi": "Từ ngã tư này đi thẳng về phía trước hai trăm mét là bệnh viện thành phố.",
          "explanation": "\"往前走\" chỉ dẫn phương hướng tiến bước về phía trước."
        },
        {
          "chinese": "请大家下了公共汽车后往右边拐，就能看到地铁站入口。",
          "pinyin": "Qǐng dàjiā xià le gōnggòng qìchē hòu wǎng yòubiān guǎi, jiù néng kàn dào dìtiězhàn rùkǒu.",
          "translation_vi": "Mời mọi người sau khi xuống xe buýt thì rẽ về phía bên phải là có thể nhìn thấy lối vào ga tàu điện ngầm.",
          "explanation": "\"往右边拐\" chỉ hướng rẽ phải."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 35,
      "name": "Giới từ hướng mục tiêu đối tượng \"向\" (Hướng tới / Về phía)",
      "pattern": "向 + Đối tượng / Phương vị + Động từ (学 / 借 / 走 / 报告)",
      "category": "Giới từ",
      "explanation_vi": "\"向\" (xiàng) có thể chỉ phương hướng không gian (như 往) và đặc biệt dùng chỉ đối tượng mà hành động nhắm vào (như 向老师请教: thỉnh giáo thầy giáo, 向他学习: học tập anh ấy).",
      "examples": [
        {
          "chinese": "全班同学都应当虚心向经验丰富的李老师学习。",
          "pinyin": "Quán bān tóngxué dōu yīngdāng xūxīn xiàng jīngyàn fēngfù de Lǐ lǎoshī xuéxí.",
          "translation_vi": "Học sinh cả lớp đều nên khiêm tốn học tập thầy Lý giàu kinh nghiệm.",
          "explanation": "\"向...学习\" chỉ đối tượng học tập là thầy Lý."
        },
        {
          "chinese": "轮船迎着朝阳缓缓向南方的大海深处航行。",
          "pinyin": "Lúnchuán yíng zhe zhāoyáng huǎnhuǎn xiàng nánfāng de dàhǎi shēncù hángxíng.",
          "translation_vi": "Con tàu đón ánh bình minh từ từ hướng về biển sâu phương Nam căng buồm rẽ sóng.",
          "explanation": "\"向南方...航行\" chỉ phương hướng di chuyển của con thuyền."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 36,
      "name": "Giới từ đối tượng tương tác \"对\" (Đối với / Về)",
      "pattern": "对 + Đối tượng + Vị ngữ / Đối tượng 1 + 对 + Đối tượng 2 + Tính từ",
      "category": "Giới từ",
      "explanation_vi": "\"对\" (duì) dùng để đưa ra đối tượng mà hành vi tác động tới, hoặc đối tượng tiếp nhận tình cảm, thái độ, tính chất (đối với, đối cùng). Cấu trúc thường gặp: 对...感兴趣 (có hứng thú với...), 对...好 (tốt với...).",
      "examples": [
        {
          "chinese": "这位热心的老教授对每一个学生都非常和蔼客气。",
          "pinyin": "Zhè wèi rèxīn de lǎo jiàoshòu duì měi yí gè xuésheng dōu fēicháng hé'ǎi kèqì.",
          "translation_vi": "Vị giáo sư già nhiệt tình này đối với mỗi một học sinh đều vô cùng hòa nhã nhã nhặn.",
          "explanation": "\"对...和蔼客气\" biểu thị thái độ cư xử tốt đối với học trò."
        },
        {
          "chinese": "很多外国留学生都对博大精深的中国京剧艺术很感兴趣。",
          "pinyin": "Hěn duō wàiguó liúxuéshēng dōu duì bódà-jīngshēn de zhōngguó jīngjù yìshù hěn gǎn xìngqù.",
          "translation_vi": "Rất nhiều lưu học sinh nước ngoài đều rất có hứng thú đối với nghệ thuật Kinh kịch Trung Quốc uyên thâm.",
          "explanation": "\"对...感兴趣\" là cấu trúc cố định chỉ sự say mê hứng thú."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 37,
      "name": "Giới từ cự ly không gian / thời gian \"离\" (Cách / Cách xa)",
      "pattern": "Địa điểm / Mốc thời gian A + 离 + B + (不) 远 / 近 / Cự ly cụ thể",
      "category": "Giới từ",
      "explanation_vi": "\"离\" (lí) biểu thị cự ly khoảng cách về mặt không gian hoặc thời gian giữa hai điểm (cách). Không được dùng với phó từ chỉ vị trí \"从\".",
      "examples": [
        {
          "chinese": "我家离学校非常近，走路只需要五分钟就能到达。",
          "pinyin": "Wǒ jiā lí xuéxiào fēicháng jìn, zǒulù zhǐ xūyào wǔ fēnzhōng jiù néng dàodá.",
          "translation_vi": "Nhà tôi cách trường học rất gần, đi bộ chỉ cần năm phút là có thể tới nơi.",
          "explanation": "\"离学校非常近\" chỉ khoảng cách không gian địa lý ngắn."
        },
        {
          "chinese": "现在离春节放假还有一个星期，大家都在忙着准备年货。",
          "pinyin": "Xiànzài lí chūnjié fàngjià hái yǒu yí gè xīngqī, dàjiā dōu zài máng zhe zhǔnbèi niánhuò.",
          "translation_vi": "Bây giờ cách kỳ nghỉ tết Nguyên đán còn một tuần nữa, mọi người đều đang bận sắm sửa đồ tết.",
          "explanation": "\"离春节放假\" chỉ khoảng cách thời gian còn lại."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 38,
      "name": "Giới từ mục đích & vì đối tượng \"为\" (Vì / Cho)",
      "pattern": "为 + Đối tượng / Mục đích + Động từ (+ Tân ngữ)",
      "category": "Giới từ",
      "explanation_vi": "\"为\" (wèi) đứng trước danh từ để chỉ mục đích của hành động (vì cái gì) hoặc chỉ người/đối tượng được hành động phục vụ (cho ai). Thường gặp: 为...高兴 (mừng cho ai), 为...服务 (phục vụ ai).",
      "examples": [
        {
          "chinese": "听到你顺利通过高级汉语考试的消息，我们都为你感到高兴。",
          "pinyin": "Tīng dào nǐ shùnlì tōngguò gāojí hànyǔ kǎoshì de xiāoxi, wǒmen dōu wèi nǐ gǎndào gāoxìng.",
          "translation_vi": "Nghe tin bạn thuận lợi thi đỗ kỳ thi Hán ngữ cao cấp, chúng tôi đều cảm thấy vui mừng thay cho bạn.",
          "explanation": "\"为你感到高兴\" chỉ người được vui mừng cho là bạn."
        },
        {
          "chinese": "这家社区服务中心始终全心全意为广大居民排忧解难。",
          "pinyin": "Zhè jiā shèqū fúwù zhōngxīn shǐzhōng quánxīn-quányì wèi guǎngdà jūmín páiyōu-jiěnán.",
          "translation_vi": "Trung tâm dịch vụ cộng đồng này luôn toàn tâm toàn ý giải quyết khó khăn lo toan cho đông đảo cư dân.",
          "explanation": "\"为广大居民\" chỉ đối tượng được phục vụ."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 39,
      "name": "Giới từ so sánh \"比\" cơ bản (Hơn / So với)",
      "pattern": "Chủ ngữ A + 比 + Chủ ngữ B + Tính từ",
      "category": "Giới từ",
      "explanation_vi": "\"比\" (bǐ) dùng trong câu so sánh bậc hơn giữa hai đối tượng A và B. Chú ý: Trước tính từ vị ngữ trong câu chữ 比 KHÔNG được dùng các phó từ mức độ như 很, 非常, 真.",
      "examples": [
        {
          "chinese": "弟弟现在的身高已经比哥哥高了整整两厘米。",
          "pinyin": "Dìdi xiànzài de shēngāo yǐjīng bǐ gēge gāo le zhěngzhěng liǎng límǐ.",
          "translation_vi": "Chiều cao hiện tại của em trai đã cao hơn anh trai trọn vẹn hai centimet.",
          "explanation": "\"比哥哥高\" là cấu trúc so sánh hơn tiêu chuẩn về chiều cao."
        },
        {
          "chinese": "今天户外的气温比昨天低了三度，需要多穿一件外套。",
          "pinyin": "Jīntiān hùwài de qìwēn bǐ zuótiān dī le sān dù, xūyào duō chuān yí jiàn wàitào.",
          "translation_vi": "Nhiệt độ ngoài trời hôm nay thấp hơn hôm qua ba độ, cần phải mặc thêm một chiếc áo khoác.",
          "explanation": "\"比昨天低\" so sánh nhiệt độ giữa hai ngày."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 40,
      "name": "Trợ từ kết cấu bổ ngữ trạng thái \"得\"",
      "pattern": "Động từ (+ Tân ngữ + Động từ) + 得 + (很 / 非常) + Tính từ / Cụm vị ngữ",
      "category": "Trợ từ",
      "explanation_vi": "\"得\" (de) là trợ từ kết cấu nối giữa động từ và bổ ngữ chỉ trạng thái để đánh giá, miêu tả mức độ, kết quả hoặc trạng thái thực hiện của hành động (làm ra sao, đến mức nào). Nếu động từ mang tân ngữ thì phải lặp lại động từ.",
      "examples": [
        {
          "chinese": "这位外国留学生的汉字写得非常工整漂亮。",
          "pinyin": "Zhè wèi wàiguó liúxuéshēng de hànzì xiě de fēicháng gōngzhěng piàoliang.",
          "translation_vi": "Chữ Hán của bạn lưu học sinh nước ngoài này viết rất nắn nót đẹp đẽ.",
          "explanation": "\"写得非常工整\" dùng \"得\" kết nối động từ \"写\" và bổ ngữ đánh giá."
        },
        {
          "chinese": "他昨天晚上睡得很香，今天早晨精神格外饱满。",
          "pinyin": "Tā zuótiān wǎnshang shuì de hěn xiāng, jīntiān zǎochén jīngshén géwài bǎomǎn.",
          "translation_vi": "Tối hôm qua anh ấy ngủ rất ngon giấc, sáng nay tinh thần cực kỳ phấn chấn.",
          "explanation": "\"睡得很香\" đánh giá trạng thái giấc ngủ."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 41,
      "name": "Trợ từ động thái trạng thái tiếp diễn \"着\"",
      "pattern": "Động từ + 着 (+ Tân ngữ)",
      "category": "Trợ từ",
      "explanation_vi": "\"着\" (zhe) đứng sau động từ để biểu thị hành động đang diễn ra hoặc trạng thái do hành động tạo ra vẫn đang được duy trì (đang, vẫn giữ nguyên). Thường gặp trong câu miêu tả tư thế hoặc câu tồn hiện.",
      "examples": [
        {
          "chinese": "会议室的大门紧紧关着，里面正在进行重要谈判。",
          "pinyin": "Huìyìshì de dàmén jǐnjǐn guān zhe, lǐmiàn zhèngzài jìnxíng zhòngyào tánpàn.",
          "translation_vi": "Cánh cửa lớn của phòng họp đang đóng chặt, bên trong đang tiến hành đàm phán quan trọng.",
          "explanation": "\"关着\" biểu thị trạng thái đóng cửa đang được duy trì."
        },
        {
          "chinese": "老奶奶手里拿着一本厚厚的相册，微笑着回忆过去。",
          "pinyin": "Lǎonǎinai shǒu lǐ ná zhe yì běn hòuhòu de xiàngcè, wēixiào zhe huíyì guòqù.",
          "translation_vi": "Bà cụ trong tay đang cầm một cuốn album ảnh dày cộp, mỉm cười nhớ về quá khứ.",
          "explanation": "\"拿着\" chỉ tư thế cầm sách và \"微笑着\" chỉ trạng thái mỉm cười."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 42,
      "name": "Trợ từ động thái kinh nghiệm quá khứ \"过\"",
      "pattern": "Chủ ngữ + Động từ + 过 (+ Tân ngữ) / Phủ định: 没(有) + Động từ + 过",
      "category": "Trợ từ",
      "explanation_vi": "\"过\" (guo) đứng ngay sau động từ để nhấn mạnh chủ thể đã từng có kinh nghiệm trải qua hành động đó trong quá khứ (đã từng, từng). Dạng phủ định là \"没 / 没有 + Động từ + 过\" (chưa từng).",
      "examples": [
        {
          "chinese": "我去年夏天曾经去过一次美丽的云南丽江古城。",
          "pinyin": "Wǒ qùnián xiàtiān céngjīng qù guo yí cì měilì de Yúnnán Lìjiāng gǔchéng.",
          "translation_vi": "Mùa hè năm ngoái tôi đã từng một lần đến phố cổ Lệ Giang tươi đẹp ở Vân Nam.",
          "explanation": "\"去过\" khẳng định đã từng có trải nghiệm du lịch Lệ Giang."
        },
        {
          "chinese": "他从来没有吃过这么地道正宗的四川麻婆豆腐。",
          "pinyin": "Tā cónglái méiyǒu chī guo zhème dìdào zhèngzōng de Sìchuān mápó dòufu.",
          "translation_vi": "Anh ấy từ trước tới nay chưa từng ăn món đậu phụ Ma Bà Tứ Xuyên chuẩn vị chính tông thế này.",
          "explanation": "\"没有吃过\" phủ định chưa từng nếm qua món ăn."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 43,
      "name": "Trợ từ ngữ khí biến đổi tình huống \"了\"",
      "pattern": "Vị ngữ + 了",
      "category": "Trợ từ",
      "explanation_vi": "\"了\" (le) đặt ở cuối câu dùng làm trợ từ ngữ khí để biểu thị sự xuất hiện của một tình huống mới, sự thay đổi trạng thái hoặc nhận thức mới (rồi, đã chuyển biến). Khác với \"了\" trợ từ động thái đứng sau động từ.",
      "examples": [
        {
          "chinese": "春风吹绿了大地，天气逐渐变得温暖了。",
          "pinyin": "Chūnfēng chuī lǜ le dàdì, tiānqì zhújiàn biàn de wēnnuǎn le.",
          "translation_vi": "Gió xuân thổi xanh đất trời, thời tiết dần dần trở nên ấm áp rồi.",
          "explanation": "\"温暖了\" biểu thị thời tiết đã có sự chuyển biến ấm lên."
        },
        {
          "chinese": "已经下课了，请大家收拾好书包离开教室。",
          "pinyin": "Yǐjīng xiàkè le, qǐng dàjiā shōushi hǎo shūbāo líkāi jiàoshì.",
          "translation_vi": "Đã tan học rồi, mời mọi người dọn dẹp cặp sách rời khỏi lớp học.",
          "explanation": "\"下课了\" thông báo tình huống mới là giờ học đã kết thúc."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 44,
      "name": "Trợ từ ngữ khí thương lượng / gợi ý \"吧\"",
      "pattern": "Câu đề xuất / Cầu khiến + 吧!",
      "category": "Trợ từ",
      "explanation_vi": "\"吧\" (ba) đặt ở cuối câu để biểu thị ngữ khí thương lượng, đề nghị, thỉnh cầu nhẹ nhàng hoặc đồng ý (nhé, đi, thôi). Giúp câu nói mềm mại và lịch sự hơn.",
      "examples": [
        {
          "chinese": "今天晚上的电影看起来很精彩，我们一起去看吧！",
          "pinyin": "Jīntiān wǎnshang de diànyǐng kàn qǐlai hěn jīngcǎi, wǒmen yìqǐ qù kàn ba!",
          "translation_vi": "Bộ phim tối nay xem chừng rất đặc sắc, chúng ta cùng nhau đi xem nhé!",
          "explanation": "\"一起去看吧\" rủ rê đề xuất bạn bè đi xem phim."
        },
        {
          "chinese": "时间不早了，大家快把桌子收拾干净准备休息吧。",
          "pinyin": "Shíjiān bù zǎo le, dàjiā kuài bǎ zhuōzi shōushi gānjìng zhǔnbèi xiūxi ba.",
          "translation_vi": "Thời gian không còn sớm nữa, mọi người mau dọn dẹp bàn ghế sạch sẽ chuẩn bị nghỉ ngơi thôi.",
          "explanation": "\"准备休息吧\" là lời khuyên thúc giục nhẹ nhàng."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 45,
      "name": "Trợ từ ngữ khí nhấn mạnh xác thực \"呢\"",
      "pattern": "Chủ ngữ + Vị ngữ + 呢 / Phó từ + 呢",
      "category": "Trợ từ",
      "explanation_vi": "\"呢\" (ne) đặt ở cuối câu khẳng định để nhấn mạnh sự thật hiển nhiên hoặc cường điệu ngữ khí khẳng định (đấy, đấy chứ, cơ mà). Cũng kết hợp với 在/正 để chỉ hành động đang diễn ra.",
      "examples": [
        {
          "chinese": "你别小看这道物理题，难着呢，需要仔细思考。",
          "pinyin": "Nǐ bié xiǎokàn zhè dào wùlǐ tí, nán zhe ne, xūyào zǐxì sīkǎo.",
          "translation_vi": "Bạn chớ có xem thường bài toán vật lý này, khó lắm đấy chứ, cần phải suy nghĩ cẩn thận.",
          "explanation": "\"难着呢\" nhấn mạnh mức độ khó của đề bài."
        },
        {
          "chinese": "妈妈还在厨房里给大家熬香喷喷的鸡汤呢。",
          "pinyin": "Māma hái zài chúfáng lǐ gěi dàjiā áo xiāngpēnpēn de jītāng ne.",
          "translation_vi": "Mẹ vẫn đang ở trong bếp ninh nồi canh gà thơm nức mũi cho cả nhà cơ mà.",
          "explanation": "\"还在...呢\" khẳng định hành động nấu nướng đang tiếp diễn."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 46,
      "name": "Động từ năng nguyện cho phép / năng lực \"可以\" (Có thể / Được phép)",
      "pattern": "Chủ ngữ + 可以 + Động từ (+ Tân ngữ) / Phủ định: 不可以 / 不能",
      "category": "Động từ năng nguyện",
      "explanation_vi": "\"可以\" (kěyǐ) biểu thị sự cho phép (được phép làm gì), tính khả thi hoặc năng lực có thể làm được điều gì. Dạng phủ định thường dùng \"不可以\" hoặc \"不能\".",
      "examples": [
        {
          "chinese": "请问大家在图书馆的阅览室里可以借用电脑吗？",
          "pinyin": "Qǐngwèn dàjiā zài túshūguǎn de yuèlǎnshì lǐ kěyǐ jièyòng diànnǎo ma?",
          "translation_vi": "Xin hỏi mọi người ở phòng đọc của thư viện có thể mượn máy vi tính dùng được không?",
          "explanation": "\"可以借用\" hỏi xin phép quy định trong phòng đọc."
        },
        {
          "chinese": "你做完课后作业以后就可以看半个小时动画片。",
          "pinyin": "Nǐ zuò wán kèhòu zuòyè yǐhòu jiù kěyǐ kàn bàn gè xiǎoshí dònghuàpiàn.",
          "translation_vi": "Con làm xong bài tập về nhà xong là có thể xem phim hoạt hình nửa tiếng.",
          "explanation": "\"就可以看\" biểu thị sự cho phép sau khi làm xong điều kiện."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 47,
      "name": "Động từ năng nguyện bổn phận / khuyên răn \"应该\" (Nên / Cần phải)",
      "pattern": "Chủ ngữ + 应该 + Động từ (+ Tân ngữ) / Phủ định: 不应该",
      "category": "Động từ năng nguyện",
      "explanation_vi": "\"应该\" (yīnggāi) biểu thị về mặt đạo lý, nghĩa vụ, phép lịch sự hoặc logic thì cần thiết phải làm một việc gì đó (nên, cần phải). Phủ định là \"不应该\" (không nên).",
      "examples": [
        {
          "chinese": "过马路的时候我们应该先看红绿灯，注意交通安全。",
          "pinyin": "Guò mǎlù de shíhou wǒmen yīnggāi xiān kàn hónglǜdēng, zhùyì jiāotōng ānquán.",
          "translation_vi": "Khi qua đường chúng ta nên nhìn đèn tín hiệu giao thông trước, chú ý an toàn giao thông.",
          "explanation": "\"应该先看\" khuyên bảo hành vi an toàn bắt buộc khi qua đường."
        },
        {
          "chinese": "朋友遇到困难时，我们应该主动伸出援助之手。",
          "pinyin": "Péngyou yù dào kùnnán shí, wǒmen yīnggāi zhǔdòng shēn chū yuánzhù zhī shǒu.",
          "translation_vi": "Khi bạn bè gặp khó khăn, chúng ta nên chủ động chìa bàn tay giúp đỡ.",
          "explanation": "\"应该主动\" nhấn mạnh bổn phận đạo đức đối với bạn bè."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 48,
      "name": "Động từ năng nguyện nguyện vọng \"想\" (Muốn / Nghĩ / Nhớ)",
      "pattern": "Chủ ngữ + 想 + Động từ (+ Tân ngữ) / Phủ định: 不想",
      "category": "Động từ năng nguyện",
      "explanation_vi": "\"想\" (xiǎng) đứng trước động từ biểu thị ý muốn, dự định chủ quan hoặc nguyện vọng trong lòng (muốn làm gì). Không mang tính quyết liệt và bắt buộc cao như \"要\".",
      "examples": [
        {
          "chinese": "今年寒假我想和家人一起去温暖的三亚海边度假。",
          "pinyin": "Jīnnián hánjià wǒ xiǎng hé jiārén yìqǐ qù wēnnuǎn de Sānyà hǎibiān dùjià.",
          "translation_vi": "Kỳ nghỉ đông năm nay tôi muốn cùng người nhà đến bãi biển Tam Á ấm áp để nghỉ mát.",
          "explanation": "\"我想...去\" biểu đạt mong muốn kế hoạch nghỉ đông."
        },
        {
          "chinese": "他今天身体有点不舒服，不想参加晚上的聚会。",
          "pinyin": "Tā jīntiān shēntǐ yǒudiǎn bù shūfu, bù xiǎng cānjiā wǎnshang de jùhuì.",
          "translation_vi": "Hôm nay người anh ấy hơi không khỏe, không muốn tham gia buổi tụ tập tối nay.",
          "explanation": "\"不想参加\" phủ định ý muốn tham gia."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 49,
      "name": "Động từ năng nguyện quyết tâm & tương lai gần \"要\" (Muốn / Sẽ / Phải)",
      "pattern": "Chủ ngữ + 要 + Động từ (+ Tân ngữ) / Phủ định: 不想 / 不用",
      "category": "Động từ năng nguyện",
      "explanation_vi": "\"要\" (yào) biểu thị quyết tâm mong muốn mạnh mẽ làm điều gì đó (muốn), hoặc biểu thị một hành động sắp xảy ra trong tương lai gần (sẽ). Phủ định ý muốn dùng \"不想\", phủ định nghĩa vụ dùng \"不用\".",
      "examples": [
        {
          "chinese": "明天早晨八点我们要举行新学期的开学典礼。",
          "pinyin": "Míngtiān zǎochén bā diǎn wǒmen yào jǔxíng xīn xuéqī de kāixué diǎnlǐ.",
          "translation_vi": "Tám giờ sáng mai chúng tôi sẽ tổ chức lễ khai giảng của học kỳ mới.",
          "explanation": "\"我们要举行\" biểu thị sự việc sắp diễn ra vào sáng mai."
        },
        {
          "chinese": "为了学好汉语，他下定决心每天都要背三十个生词。",
          "pinyin": "Wèile xué hǎo hànyǔ, tā xiàdìng juéxīn měitiān dōu yào bèi sānshí gè shēngcí.",
          "translation_vi": "Để học giỏi tiếng Hán, anh ấy hạ quyết tâm mỗi ngày đều phải học thuộc ba mươi từ mới.",
          "explanation": "\"都要背\" biểu thị ý chí quyết tâm bắt buộc bản thân làm."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 50,
      "name": "Động từ năng nguyện kỹ năng học được \"会\" (Biết / Sẽ)",
      "pattern": "Chủ ngữ + 会 + Động từ (+ Tân ngữ) / Phủ định: 不会",
      "category": "Động từ năng nguyện",
      "explanation_vi": "\"会\" (huì) biểu thị một kỹ năng hoặc năng lực nào đó đạt được thông qua quá trình học tập, rèn luyện (biết bơi, biết tiếng Trung), hoặc biểu thị khả năng sự việc sẽ xảy ra trong tương lai (sẽ).",
      "examples": [
        {
          "chinese": "他在中国生活了三年，现在不仅会说普通话，还会包饺子。",
          "pinyin": "Tā zài zhōngguó shēnghuó le sān nián, xiànzài bùjǐn huì shuō pǔtōnghuà, hái huì bāo jiǎozi.",
          "translation_vi": "Anh ấy đã sống ở Trung Quốc ba năm, bây giờ không chỉ biết nói tiếng phổ thông mà còn biết gói sủi cảo.",
          "explanation": "\"会说\" và \"会包\" chỉ các kỹ năng đạt được qua học tập thực tế."
        },
        {
          "chinese": "别担心，医生说你的病只要好好吃药就一定会好的。",
          "pinyin": "Bié dānxīn, yīshēng shuō nǐ de bìng zhǐyào hǎohǎo chīyào jiù yídìng huì hǎo de.",
          "translation_vi": "Đừng lo lắng, bác sĩ nói bệnh của bạn chỉ cần uống thuốc đầy đủ thì nhất định sẽ khỏi thôi.",
          "explanation": "\"一定会好\" biểu thị khả năng chắc chắn sẽ xảy ra trong tương lai."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 51,
      "name": "Bổ ngữ kết quả hoàn thiện đạt chuẩn \"好\"",
      "pattern": "Động từ + 好 (+ Tân ngữ) / Phủ định: 没(有) + Động từ + 好",
      "category": "Bổ ngữ",
      "explanation_vi": "\"好\" (hǎo) làm bổ ngữ kết quả đứng sau động từ để biểu thị hành động đã hoàn thành đạt tới mức độ hoàn thiện, hoàn hảo, khiến người ta hài lòng hoặc sẵn sàng cho bước tiếp theo (xong xuôi, tốt đẹp).",
      "examples": [
        {
          "chinese": "我已经准备好明天的求职面试发言稿了。",
          "pinyin": "Wǒ yǐjīng zhǔnbèi hǎo míngtiān de qiúzhí miànshì fāyángǎo le.",
          "translation_vi": "Tôi đã chuẩn bị xong xuôi bài phát biểu phỏng vấn xin việc ngày mai rồi.",
          "explanation": "\"准备好\" biểu thị sự việc chuẩn bị đã tươm tất hoàn tất."
        },
        {
          "chinese": "晚饭妈妈已经做好了，大家快洗手去餐厅吃饭吧。",
          "pinyin": "Wǎnfàn māma yǐjīng zuò hǎo le, dàjiā kuài xǐshǒu qù cāntīng chīfàn ba.",
          "translation_vi": "Cơm tối mẹ đã nấu xong rồi, mọi người mau rửa tay vào phòng ăn ăn cơm thôi.",
          "explanation": "\"做好了\" chỉ bữa cơm nấu xong thơm ngon sẵn sàng."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 52,
      "name": "Bổ ngữ kết quả kết thúc toàn bộ \"完\"",
      "pattern": "Động từ + 完 (+ Tân ngữ) / Phủ định: 没(有) + Động từ + 完",
      "category": "Bổ ngữ",
      "explanation_vi": "\"完\" (wán) làm bổ ngữ kết quả biểu thị hành động hoặc đối tượng của hành động đã kết thúc trọn vẹn, không còn gì sót lại (hết, xong). Dạng phủ định là \"没 / 没有 + Động từ + 完\" (chưa xong).",
      "examples": [
        {
          "chinese": "同学们只用了一个小时就看完了整本故事书。",
          "pinyin": "Tóngxué men zhǐ yòng le yí gè xiǎoshí jiù kàn wán le zhěng běn gùshì shū.",
          "translation_vi": "Các bạn học sinh chỉ dùng một giờ đồng hồ là đã đọc xong hết cả cuốn sách truyện.",
          "explanation": "\"看完了\" biểu thị đọc hết toàn bộ cuốn sách không bỏ sót trang nào."
        },
        {
          "chinese": "这道难题我还没有做完，请老师再给我五分钟时间。",
          "pinyin": "Zhè dào nántí wǒ hái méiyǒu zuò wán, qǐng lǎoshī zài gěi wǒ wǔ fēnzhōng shíjiān.",
          "translation_vi": "Bài toán khó này em vẫn chưa làm xong, xin thầy cho em thêm năm phút nữa ạ.",
          "explanation": "\"没有做完\" phủ định hành động làm toán chưa kết thúc."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 53,
      "name": "Bổ ngữ kết quả tiếp cận / đạt mục tiêu \"到\" (Tới / Được)",
      "pattern": "Động từ + 到 + Tân ngữ nơi chốn / thời gian / mục tiêu",
      "category": "Bổ ngữ",
      "explanation_vi": "\"到\" (dào) làm bổ ngữ kết quả đứng sau động từ biểu thị hành động đã đạt đến một địa điểm, một mốc thời gian nhất định (như 走到: đi đến, 学到: học đến), hoặc hành động đã thành công đạt được mục đích (như 买到: mua được, 找到: tìm thấy).",
      "examples": [
        {
          "chinese": "他昨天晚上在图书馆一直看书看到十一点半。",
          "pinyin": "Tā zuótiān wǎnshang zài túshūguǎn yìzhí kànshū kàn dào shíyī diǎn bàn.",
          "translation_vi": "Tối hôm qua anh ấy ở thư viện đọc sách liên tục đến tận mười một giờ rưỡi.",
          "explanation": "\"看到\" biểu thị mốc thời gian hành động đọc sách kéo dài tới."
        },
        {
          "chinese": "经过多方打听，我终于在旧书店买到了这本绝版名著。",
          "pinyin": "Jīngguò duōfāng dǎtīng, wǒ zhōngyú zài jiù shūdiàn mǎi dào le zhè běn juébǎn míngzhù.",
          "translation_vi": "Qua nhiều mối dò hỏi, tôi cuối cùng đã mua được cuốn danh tác tuyệt bản này ở một hiệu sách cũ.",
          "explanation": "\"买到了\" nhấn mạnh việc đạt được mục đích mua thành công."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 54,
      "name": "Bổ ngữ kết quả giác quan tri giác \"见\" (Thấy / Nghe thấy)",
      "pattern": "Động từ giác quan (看 / 听 / 闻) + 见 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"见\" (jiàn) làm bổ ngữ kết quả kết hợp với các động từ tri giác như \"看\" (nhìn), \"听\" (nghe) để biểu thị giác quan đã tiếp nhận được hình ảnh, âm thanh từ thế giới bên ngoài (nhìn thấy, nghe thấy). Dạng phủ định là \"没看(见)\", \"没听(见)\".",
      "examples": [
        {
          "chinese": "站在高山之巅，我们可以清楚地看见山谷里的小村庄。",
          "pinyin": "Zhàn zài gāoshān zhī diān, wǒmen kěyǐ qīngchu de kànjiàn shāngǔ lǐ de xiǎo cūnzhuāng.",
          "translation_vi": "Đứng trên đỉnh núi cao, chúng tôi có thể nhìn thấy rõ ràng ngôi làng nhỏ trong thung lũng.",
          "explanation": "\"看见\" biểu thị thị giác đã bắt được hình ảnh ngôi làng."
        },
        {
          "chinese": "教室外面太吵了，最后一排的学生听不见老师讲课。",
          "pinyin": "Jiàoshì wàimiàn tài chǎo le, zuìhòu yì pái de xuésheng tīng bu jiàn lǎoshī jiǎngkè.",
          "translation_vi": "Bên ngoài lớp học ồn ào quá, học sinh hàng ghế cuối cùng không nghe thấy thầy giáo giảng bài.",
          "explanation": "\"听不见\" biểu thị thính giác không thu nhận được âm thanh."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 55,
      "name": "Bổ ngữ kết quả hiểu thấu triệt \"懂\" (Hiểu / Hiểu ra)",
      "pattern": "听 / 看 + 懂 (+ Tân ngữ) / Phủ định: 没听懂 / 没看懂",
      "category": "Bổ ngữ",
      "explanation_vi": "\"懂\" (dǒng) làm bổ ngữ kết quả đứng sau động từ tiếp nhận thông tin như \"听\" (nghe), \"看\" (đọc/xem) để biểu thị người tiếp nhận đã hiểu rõ, lĩnh hội được nội dung, ý nghĩa của lời nói hoặc bài viết (nghe hiểu, xem hiểu).",
      "examples": [
        {
          "chinese": "虽然课文有些生词，但他依然认真听懂了整堂课的内容。",
          "pinyin": "Suīrán kèwén yǒuxiē shēngcí, dàn tā yīrán rènzhēn tīng dǒng le zhěng táng kè de nèiróng.",
          "translation_vi": "Mặc dù bài khóa có một số từ mới, nhưng anh ấy vẫn chăm chú nghe hiểu được nội dung của cả tiết học.",
          "explanation": "\"听懂了\" biểu thị đã lĩnh hội trọn vẹn lời giảng."
        },
        {
          "chinese": "这篇古汉语寓言文章深奥难懂，我读了两遍才看懂。",
          "pinyin": "Zhè piān gǔ hànyǔ yùyán wénzhāng shēn'ào nándǒng, wǒ dú le liǎng biàn cái kàn dǒng.",
          "translation_vi": "Bài văn ngụ ngôn Hán ngữ cổ này sâu xa khó hiểu, tôi đọc tới hai lần mới xem hiểu được.",
          "explanation": "\"看懂\" biểu thị việc đọc và hiểu thấu đáo ý nghĩa sau nhiều lần nghiền ngẫm."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 56,
      "name": "Bổ ngữ kết quả đúng / sai \"对 / 错\" (Đúng / Sai)",
      "pattern": "Động từ (做 / 说 / 写 / 算) + 对 / 错 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"对\" (duì) và \"错\" (cuò) làm bổ ngữ kết quả đứng sau động từ để biểu thị hành động đã tiến hành chính xác hoặc sai lệch so với tiêu chuẩn, sự thật (làm đúng/sai, nói đúng/sai, tính đúng/sai).",
      "examples": [
        {
          "chinese": "经过反复验算，他在数学考试中把最后一道难题做对了。",
          "pinyin": "Jīngguò fǎnfù yànsuàn, tā zài shùxué kǎoshì zhōng bǎ zuìhòu yí dào nántí zuò duì le.",
          "translation_vi": "Trải qua việc tính toán kiểm tra lại nhiều lần, anh ấy trong kỳ thi toán đã làm đúng bài toán khó cuối cùng.",
          "explanation": "\"做对了\" biểu thị kết quả giải toán chính xác."
        },
        {
          "chinese": "对不起，我刚才太匆忙，把您的手机号码记错了。",
          "pinyin": "Duìbuqǐ, wǒ gāngcái tài cōngmáng, bǎ nín de shǒujī hàomǎ jì cuò le.",
          "translation_vi": "Xin lỗi, ban nãy tôi vội vàng quá, đã ghi nhầm số điện thoại di động của ngài rồi.",
          "explanation": "\"记错了\" biểu thị việc ghi chép bị sai sót thông tin."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 57,
      "name": "Bổ ngữ xu hướng đơn \"来 / 去\" (Lại / Đi)",
      "pattern": "Động từ chuyển động (上 / 下 / 进 / 出 / 回 / 过) + 来 / 去",
      "category": "Bổ ngữ",
      "explanation_vi": "\"来\" (lái) và \"去\" (qù) làm bổ ngữ xu hướng đứng sau động từ chỉ sự di chuyển. Dùng \"来\" khi hướng chuyển động tiến về phía vị trí của người nói (hoặc đối tượng được miêu tả); dùng \"去\" khi hướng chuyển động đi xa dần khỏi vị trí của người nói.",
      "examples": [
        {
          "chinese": "外面风大天冷，你快进屋里来喝杯热姜茶吧。",
          "pinyin": "Wàimiàn fēng dà tiān lěng, nǐ kuài jìn wū lǐ lái hē bēi rè jiāngchá ba.",
          "translation_vi": "Bên ngoài gió to trời lạnh, bạn mau bước vào trong nhà uống cốc trà gừng nóng đi.",
          "explanation": "\"进来\" biểu thị người nói đang ở trong nhà, gọi người ngoài bước vào phía mình."
        },
        {
          "chinese": "爸爸让我去书房拿一本厚厚的汉语大字典回来。",
          "pinyin": "Bàba ràng wǒ qù shūfáng ná yì běn hòuhòu de hànyǔ dà zìdiǎn huílai.",
          "translation_vi": "Bố bảo tôi đi vào phòng sách lấy một cuốn đại tự điển tiếng Hán dày cộp mang về đây.",
          "explanation": "\"拿回来\" chỉ việc mang sách về lại chỗ người nói."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 58,
      "name": "Bổ ngữ xu hướng kép cơ bản \"出来 / 上去 / 回来 / 走过去\"",
      "pattern": "Động từ hành động + (上/下/进/出/回/过) + 来/去",
      "category": "Bổ ngữ",
      "explanation_vi": "Bổ ngữ xu hướng kép gồm hai chữ (kết hợp 上/下/进/出/回/过/起 với 来/去) đứng sau động từ để miêu tả hướng di chuyển phức hợp vừa có tính phương vị vừa có tính cự ly đối với người nói.",
      "examples": [
        {
          "chinese": "太阳慢慢从东方升起来，给大地披上了一层金色阳光。",
          "pinyin": "Tàiyáng mànmàn cóng dōngfāng shēng qǐlai, gěi dàdì pī shàng le yì céng jīnsè yángguāng.",
          "translation_vi": "Mặt trời từ từ nhô lên từ phía Đông, khoác lên mặt đất một lớp ánh nắng vàng rực rỡ.",
          "explanation": "\"升起来\" miêu tả mặt trời mọc hướng lên cao về phía tầm mắt."
        },
        {
          "chinese": "她从书包里拿出来一本刚买的新杂志借给同桌看。",
          "pinyin": "Tā cóng shūbāo lǐ ná chūlai yì běn gāng mǎi de xīn zázhì jiè gěi tóngzhuō kàn.",
          "translation_vi": "Cô ấy từ trong cặp sách lấy ra một cuốn tạp chí mới vừa mua cho bạn cùng bàn mượn xem.",
          "explanation": "\"拿出来\" miêu tả hành động lấy vật từ trong ra ngoài."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 59,
      "name": "Bổ ngữ thời lượng biểu thị độ dài hành động (时量补语)",
      "pattern": "Động từ + (了) + Khoảng thời gian (+ Tân ngữ) / Động từ + Tân ngữ + Động từ + Khoảng thời gian",
      "category": "Bổ ngữ",
      "explanation_vi": "Bổ ngữ thời lượng đứng sau động từ để biểu thị hành động diễn ra kéo dài trong bao lâu (như: 一个小时: một tiếng, 三天: ba ngày). Nếu động từ mang tân ngữ thì cần lặp lại động từ hoặc đặt khoảng thời gian trước tân ngữ.",
      "examples": [
        {
          "chinese": "他在北京大学认真学习了四年现代汉语言文学专业。",
          "pinyin": "Tā zài Běijīng Dàxué rènzhēn xuéxí le sì nián xiàndài hànyǔ yánwénxué zhuānyè.",
          "translation_vi": "Anh ấy đã chăm chỉ theo học chuyên ngành ngôn ngữ văn học Hán ngữ hiện đại tại Đại học Bắc Kinh suốt bốn năm.",
          "explanation": "\"学习了四年\" bổ nghĩa cho độ dài thời gian học tập là 4 năm."
        },
        {
          "chinese": "我和朋友在人民公园的湖边散步散了半个小时。",
          "pinyin": "Wǒ hé péngyou zài Rénmín Gōngyuán de húbiān sànbù sàn le bàn gè xiǎoshí.",
          "translation_vi": "Tôi và bạn bè đi dạo bên bờ hồ Công viên Nhân dân suốt nửa tiếng đồng hồ.",
          "explanation": "\"散了半个小时\" lặp lại động từ để mang bổ ngữ thời lượng."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 60,
      "name": "Bổ ngữ động lượng chỉ tần suất số lượt \"遍 / 趟 / 顿\"",
      "pattern": "Động từ + (了) + Số từ + 遍 / 趟 / 顿",
      "category": "Bổ ngữ",
      "explanation_vi": "Bên cạnh \"次\", các động lượng từ như \"遍\" (biàn - lượt từ đầu đến cuối), \"趟\" (tàng - chuyến đi về), \"顿\" (dùn - bữa, trận) đứng sau động từ để miêu tả số lần thực hiện hành động với sắc thái cụ thể.",
      "examples": [
        {
          "chinese": "这首优美的唐诗大家已经声情并茂地背诵了三遍。",
          "pinyin": "Zhè shǒu yōuměi de tángshī dàjiā yǐjīng shēngqíng-bìngmào de bèisòng le sān biàn.",
          "translation_vi": "Bài thơ Đường tươi đẹp này mọi người đã đọc thuộc lòng truyền cảm ba lượt từ đầu tới cuối.",
          "explanation": "\"背诵了三遍\" nhấn mạnh đọc trọn vẹn toàn bộ bài thơ 3 lần."
        },
        {
          "chinese": "为了办理护照签证手续，他这个星期专门跑了两趟外事办。",
          "pinyin": "Wèile bànlǐ hùzhào qiānzhèng shǒuxù, tā zhè gè xīngqī zhuānmén pǎo le liǎng tàng wàishìbàn.",
          "translation_vi": "Để làm thủ tục hộ chiếu visa, tuần này anh ấy đã chuyên công chạy đi chạy lại hai chuyến đến phòng ngoại vụ.",
          "explanation": "\"跑了两趟\" chỉ số chuyến đi lại giao dịch công việc."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 61,
      "name": "Cấu trúc so sánh hơn có mức độ cụ thể \"A 比 B + Tính từ + Mức độ\"",
      "pattern": "A 比 B + Tính từ + (一点儿 / 得多 / 多了 / Số lượng cụ thể)",
      "category": "Cấu trúc so sánh",
      "explanation_vi": "Để biểu thị mức độ chênh lệch cụ thể trong câu so sánh chữ \"比\", người ta đặt các từ chỉ lượng như \"一点儿\" (một chút), \"得多 / 多了\" (nhiều) hoặc số lượng từ cụ thể ở ngay sau tính từ vị ngữ.",
      "examples": [
        {
          "chinese": "坐高铁去上海比坐普通列车快得多，而且非常舒适。",
          "pinyin": "Zuò gāotiě qù Shànghǎi bǐ zuò pǔtōng lièchē kuài de duō, érqiě fēicháng shūshì.",
          "translation_vi": "Đi tàu cao tốc tới Thượng Hải nhanh hơn nhiều so với đi tàu hỏa thông thường, hơn nữa còn rất tiện nghi thoải mái.",
          "explanation": "\"快得多\" bổ ngữ mức độ chênh lệch tốc độ rất lớn."
        },
        {
          "chinese": "这件羊毛大衣比那件羽绒服贵了整整两百块钱。",
          "pinyin": "Zhè jiàn yángmáo dàyī bǐ nà jiàn yǔróngfú guì le zhěngzhěng liǎng bǎi kuài qián.",
          "translation_vi": "Chiếc áo khoác dạ len này đắt hơn chiếc áo lông vũ kia trọn vẹn hai trăm tệ.",
          "explanation": "\"贵了整整两百块钱\" nêu số lượng tiền chênh lệch cụ thể."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 62,
      "name": "Cấu trúc so sánh bằng phủ định \"A 没有 B (+ 那么/这么) + Tính từ\"",
      "pattern": "Chủ ngữ A + 没有 + Chủ ngữ B (+ 那么 / 这么) + Tính từ / Vị ngữ",
      "category": "Cấu trúc so sánh",
      "explanation_vi": "Cấu trúc \"A 没有 B (那么/这么) + Tính từ\" dùng để biểu thị sự so sánh kém hơn hoặc không bằng (A không... bằng B). Đây là dạng so sánh phổ biến nhất khi phủ định mức độ của A so với chuẩn B.",
      "examples": [
        {
          "chinese": "今天户外的风没有昨天那么大，感觉暖和了不少。",
          "pinyin": "Jīntiān hùwài de fēng méiyǒu zuótiān nàme dà, gǎnjué nuǎnhuo le bù shǎo.",
          "translation_vi": "Gió ngoài trời hôm nay không lớn bằng hôm qua, cảm thấy ấm áp hơn nhiều.",
          "explanation": "\"没有昨天那么大\" so sánh độ lớn của gió không bằng ngày hôm trước."
        },
        {
          "chinese": "这本科普读物的生词没有我想象的那么难懂。",
          "pinyin": "Zhè běn kēpǔ dúwù de shēngcí méiyǒu wǒ xiǎngxiàng de nàme nándǒng.",
          "translation_vi": "Từ mới trong cuốn sách phổ biến khoa học này không khó hiểu như tôi tưởng tượng.",
          "explanation": "So sánh mức độ khó hiểu không bằng suy nghĩ ban đầu."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 63,
      "name": "Cấu trúc so sánh ngang bằng \"A 跟 / 和 B 一样 (+ Tính từ)\"",
      "pattern": "A 跟 / 和 B 一样 (+ Tính từ) / Phủ định: A 跟 / 和 B 不一样",
      "category": "Cấu trúc so sánh",
      "explanation_vi": "Cấu trúc \"A 跟/和 B 一样\" biểu thị hai đối tượng A và B có điểm tương đồng, ngang bằng nhau về mặt tính chất, đặc điểm hoặc diện mạo (giống nhau, như nhau). Phía sau có thể thêm tính từ bổ sung khía cạnh so sánh.",
      "examples": [
        {
          "chinese": "小红现在的汉语听说水平跟中国本土学生一样流利。",
          "pinyin": "Xiǎohóng xiànzài de hànyǔ tīng-shuō shuǐpíng gēn zhōngguó běntǔ xuésheng yíyàng liúlì.",
          "translation_vi": "Trình độ nghe nói tiếng Hán hiện tại của Tiểu Hồng lưu loát hệt như học sinh bản xứ Trung Quốc.",
          "explanation": "\"跟...一样流利\" so sánh mức độ lưu loát tương đương người bản xứ."
        },
        {
          "chinese": "这两款智能手机的外观颜色虽然一样，但内部配置不一样。",
          "pinyin": "Zhè liǎng kuǎn zhìnéng shǒujī de wàiguān yánsè suīrán yíyàng, dàn nèibù pèizhì bù yíyàng.",
          "translation_vi": "Màu sắc bề ngoài của hai mẫu điện thoại thông minh này tuy giống nhau, nhưng cấu hình bên trong lại khác nhau.",
          "explanation": "\"一样\" và \"不一样\" đối chiếu sự giống và khác nhau giữa hai vật."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 64,
      "name": "Câu chữ 把 sơ cấp: Xử lý và dịch chuyển vị trí (把字句基础)",
      "pattern": "Chủ ngữ + 把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成 (+ Thành phần khác)",
      "category": "Cấu trúc câu",
      "explanation_vi": "Câu chữ \"把\" (bǎ) dùng để nhấn mạnh hành động tác động lên tân ngữ và làm thay đổi trạng thái, vị trí hoặc thuộc tính của tân ngữ đó. Động từ trong câu chữ 把 không được đứng đơn độc mà phải có thành phần khác đi kèm (như bổ ngữ kết quả, địa điểm, từ chỉ đích đến).",
      "examples": [
        {
          "chinese": "请大家离开教室之前把所有窗户都关好。",
          "pinyin": "Qǐng dàjiā líkāi jiàoshì zhīqián bǎ suǒyǒu chuānghu dōu guān hǎo.",
          "translation_vi": "Xin mời mọi người trước khi rời lớp học hãy đóng kỹ tất cả các cửa sổ lại.",
          "explanation": "\"把所有窗户都关好\" xử lý đối tượng cửa sổ bằng hành động đóng kín."
        },
        {
          "chinese": "哥哥下班回家后，把公文包放在了客厅的茶几上。",
          "pinyin": "Gēge xiàbān huíjiā hòu, bǎ gōngwénbāo fàng zài le kètīng de chájī shang.",
          "translation_vi": "Sau khi anh trai tan sở về nhà đã đặt chiếc cặp tài liệu lên bàn trà phòng khách.",
          "explanation": "\"把公文包放在...\" làm thay đổi vị trí của chiếc cặp tài liệu."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 65,
      "name": "Câu tồn hiện miêu tả sự vật tĩnh tại (存在句)",
      "pattern": "Nơi chốn + Động từ (放 / 挂 / 坐 / 站 / 停) + 着 + Danh từ",
      "category": "Cấu trúc câu",
      "explanation_vi": "Câu tồn hiện dùng để miêu tả một địa điểm cụ thể nào đó đang tồn tại hoặc duy trì một trạng thái của người hoặc vật. Đầu câu là cụm từ chỉ nơi chốn, sau động từ có trợ từ \"着\", danh từ phía sau là đối tượng chưa xác định (thường có số lượng từ).",
      "examples": [
        {
          "chinese": "会议室的正前方整齐地摆放着十张干净的长桌子。",
          "pinyin": "Huìyìshì de zhèng qiánfāng zhěngqí de bǎifàng zhe shí zhāng gānjìng de cháng zhuōzi.",
          "translation_vi": "Chính phía trước phòng họp đang được bày biện ngay ngắn mười chiếc bàn dài sạch sẽ.",
          "explanation": "\"摆放着...\" miêu tả sự vật bàn dài đang tồn tại cố định trong phòng họp."
        },
        {
          "chinese": "书房雪白的墙壁上挂着一幅名贵的水墨山水画。",
          "pinyin": "Shūfáng xuěbái de qiángbì shang guà zhe yì fú míngguì de shuǐmò shānshuǐhuà.",
          "translation_vi": "Trên bức tường trắng tinh của phòng sách đang treo một bức tranh sơn thủy thủy mặc quý giá.",
          "explanation": "\"挂着\" miêu tả trạng thái tranh treo trên tường."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 66,
      "name": "Câu liên động chỉ mục đích \"去 / 来 + Nơi chốn + Làm gì\"",
      "pattern": "Chủ ngữ + 去 / 来 / 到 + Địa điểm + Động từ hành động (+ Tân ngữ)",
      "category": "Cấu trúc câu",
      "explanation_vi": "Câu liên động chỉ mục đích gồm hai cụm động từ đi liền nhau. Động từ thứ nhất là \"来 / 去 / 到\" chỉ sự di chuyển đến địa điểm, cụm động từ thứ hai nêu rõ mục đích của chuyến đi (đến đâu để làm việc gì).",
      "examples": [
        {
          "chinese": "很多外国青年慕名来到中国学习传统中医药学文化。",
          "pinyin": "Hěn duō wàiguó qīngnián mùmíng lái dào Zhōngguó xuéxí chuántǒng zhōng-yīyàoxué wénhuà.",
          "translation_vi": "Rất nhiều thanh niên nước ngoài ngưỡng mộ tìm đến Trung Quốc để học tập văn hóa y dược học cổ truyền.",
          "explanation": "\"来到中国学习\" chỉ mục đích sang Trung Quốc là để học tập đông y."
        },
        {
          "chinese": "我们今天下午准备去新华书店购买几本汉语复习参考书。",
          "pinyin": "Wǒmen jīntiān xiàwǔ zhǔnbèi qù Xīnhuá Shūdiàn gòumǎi jǐ běn hànyǔ fùxí cānkǎoshū.",
          "translation_vi": "Chiều hôm nay chúng tôi chuẩn bị đến Nhà sách Tân Hoa để mua vài cuốn sách tham khảo ôn thi tiếng Hán.",
          "explanation": "\"去新华书店购买...\" nêu rõ mục đích đến hiệu sách mua sách tham khảo."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 67,
      "name": "Câu liên động chỉ phương thức \"Động từ 1 + 着 + Động từ 2\"",
      "pattern": "Chủ ngữ + Động từ 1 + 着 + (Tân ngữ 1) + Động từ 2 (+ Tân ngữ 2)",
      "category": "Cấu trúc câu",
      "explanation_vi": "Cấu trúc \"V1 + 着 + V2\" dùng hành động thứ nhất (V1) để làm phương thức hoặc trạng thái đệm cho hành động chính thứ hai (V2) diễn ra (làm việc 2 trong trạng thái việc 1, như: 站着说: đứng nói, 笑着听: cười nghe).",
      "examples": [
        {
          "chinese": "老校长微笑着走上讲台，热情地向全校新生致辞。",
          "pinyin": "Lǎo xiàozhǎng wēixiào zhe zǒu shàng jiǎngtái, rèqíng de xiàng quán xiào xīnshēng zhìcí.",
          "translation_vi": "Vị hiệu trưởng già mỉm cười bước lên bục giảng, nhiệt tình phát biểu chúc mừng tân sinh viên toàn trường.",
          "explanation": "\"微笑着走上\" miêu tả nụ cười là phương thức thái độ khi bước lên bục."
        },
        {
          "chinese": "下班回家的路上，几个年轻人听着音乐欢快地骑着自行车。",
          "pinyin": "Xiàbān huíjiā de lù shang, jǐ gè niánqīngrén tīng zhe yīnyuè huānkuài de qí zhe zìxíngchē.",
          "translation_vi": "Trên đường tan làm về nhà, mấy người trẻ vừa nghe nhạc vừa vui vẻ đạp xe đạp.",
          "explanation": "\"听着音乐骑自行车\" thể hiện trạng thái nghe nhạc đồng thời khi đi xe đạp."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 68,
      "name": "Câu hỏi phản vấn phủ định \"不是...吗？\" (Chẳng phải là... sao?)",
      "pattern": "Chủ ngữ + 不是 + Vị ngữ / Tình huống + 吗?",
      "category": "Cấu trúc câu",
      "explanation_vi": "Cấu trúc \"不是...吗？\" (bú shì... ma?) dùng để hỏi ngược lại nhằm nhấn mạnh sự khẳng định chắc chắn về một sự việc hiển nhiên mà người nghe lẽ ra phải biết (chẳng phải là... sao, không phải là... ư). Mang ngữ khí nhắc nhở hoặc ngạc nhiên.",
      "examples": [
        {
          "chinese": "你昨天不是答应过今天会准时来参加同学聚会吗？",
          "pinyin": "Nǐ zuótiān bú shì dāying guo jīntiān huì zhǔnshí lái cānjiā tóngxué jùhuì ma?",
          "translation_vi": "Hôm qua chẳng phải bạn đã hứa hôm nay sẽ đến đúng giờ tham gia buổi họp lớp rồi sao?",
          "explanation": "\"不是答应过...吗\" nhắc nhở lại lời hứa trong quá khứ."
        },
        {
          "chinese": "今天外面不是正在下大雨吗，你怎么不带雨伞出门？",
          "pinyin": "Jīntiān wàimiàn bú shì zhèngzài xià dàyǔ ma, nǐ zěnme bú dài yǔsǎn chūmén?",
          "translation_vi": "Hôm nay bên ngoài chẳng phải đang đổ mưa to sao, sao bạn lại không mang ô ra ngoài?",
          "explanation": "Nhấn mạnh thực tế trời mưa hiển nhiên."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 69,
      "name": "Cấu trúc tăng tiến \"越...越...\" (Càng... càng...)",
      "pattern": "越 + Tính từ / Động từ 1 + 越 + Tính từ / Động từ 2 / Chủ ngữ + 越 + V1 + 越 + V2",
      "category": "Cấu trúc câu",
      "explanation_vi": "Cấu trúc \"越...越...\" (yuè... yuè...) biểu thị mức độ phát triển của một trạng thái hoặc hành động tỉ lệ thuận tăng tiến theo sự gia tăng của một yếu tố khác hoặc theo thời gian (càng... thì càng...).",
      "examples": [
        {
          "chinese": "随着科技水平的不断提高，新能源汽车的性能越做越优异。",
          "pinyin": "Suízhe kējì shuǐpíng de bùduàn tígāo, xīn néngyuán qìchē de xìngnéng yuè zuò yuè yōuyì.",
          "translation_vi": "Cùng với trình độ công nghệ không ngừng nâng cao, tính năng của xe ô tô năng lượng mới càng làm càng trở nên vượt trội.",
          "explanation": "\"越做越优异\" biểu thị chất lượng ngày càng xuất sắc hơn."
        },
        {
          "chinese": "在异国他乡生活得越久，他心中对故乡亲人的思念就越深。",
          "pinyin": "Zài yìguó-tāxiāng shēnghuó de yuè jiǔ, tā xīnzhōng duì gùxiāng qīnrén de sīniàn jiù yuè shēn.",
          "translation_vi": "Sống ở nơi đất khách quê người càng lâu, nỗi nhớ nhung người thân nơi quê nhà trong lòng anh lại càng sâu nặng.",
          "explanation": "\"越久...越深\" chỉ thời gian càng dài thì nỗi nhớ càng sâu sắc."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 70,
      "name": "Cấu trúc tương lai sắp sửa xảy ra \"快(要)...了 / 就要...了\"",
      "pattern": "Chủ ngữ + 快 / 快要 / 就要 + Động từ / Tính từ + 了",
      "category": "Cấu trúc câu",
      "explanation_vi": "Cấu trúc \"快要 / 就要...了\" (kuài yào / jiù yào... le) biểu thị một hành động hoặc sự thay đổi trạng thái sẽ diễn ra trong thời gian rất ngắn sắp tới (sắp... rồi). Chú ý: Nếu câu có trạng ngữ thời gian cụ thể (như 明天, 下周) thì chỉ được dùng \"就要...了\", không dùng \"快要...了\".",
      "examples": [
        {
          "chinese": "列车快要开动了，请送行的亲友尽快走下车厢。",
          "pinyin": "Lièchē kuàiyào kāidòng le, qǐng sòngxíng de qīnyǒu jǐnkuài zǒu xià chēxiāng.",
          "translation_vi": "Đoàn tàu sắp chuyển bánh rồi, xin mời người thân tiễn đưa mau chóng bước xuống toa tàu.",
          "explanation": "\"快要开动了\" biểu thị sự việc khởi hành sắp sửa diễn ra trong tích tắc."
        },
        {
          "chinese": "明天早晨八点我们就要举行新校区奠基仪式了。",
          "pinyin": "Míngtiān zǎochén bā diǎn wǒmen jiù yào jǔxíng xīn xiàoqū diànjī yíshì le.",
          "translation_vi": "Tám giờ sáng mai chúng tôi sẽ tổ chức lễ đặt đá khởi công khu học xá mới rồi.",
          "explanation": "\"明天早晨八点...就要...了\" có mốc giờ cụ thể kết hợp với \"就要\"."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 71,
      "name": "Cấu trúc nhấn mạnh quá khứ \"是...的\" (Đặc tả thời gian, địa điểm, cách thức)",
      "pattern": "Chủ ngữ + 是 + [Thời gian / Địa điểm / Phương thức / Mục đích] + Động từ + 的",
      "category": "Cấu trúc câu",
      "explanation_vi": "Cấu trúc \"是...的\" (shì... de) dùng cho một sự việc ĐÃ HOÀN THÀNH trong quá khứ nhằm nhấn mạnh vào chi tiết thời gian (khi nào), địa điểm (ở đâu), cách thức tiến hành (bằng cách nào) hoặc chủ thể thực hiện.",
      "examples": [
        {
          "chinese": "我是去年九月份乘坐长途客机来到北京留学的。",
          "pinyin": "Wǒ shì qùnián jiǔ yuèfèn chéngzuò chángtú kèjī lái dào Běijīng liúxué de.",
          "translation_vi": "Tôi là vào tháng Chín năm ngoái đi máy bay đường dài đến Bắc Kinh du học.",
          "explanation": "\"是去年九月份...的\" nhấn mạnh mốc thời gian du học đã diễn ra."
        },
        {
          "chinese": "这本珍贵的汉语字典是恩师在大学毕业时送给我的。",
          "pinyin": "Zhè běn zhēnguì de hànyǔ zìdiǎn shì ēnshī zài dàxué bìyè shí sòng gěi wǒ de.",
          "translation_vi": "Cuốn tự điển tiếng Hán quý giá này là người thầy ơn đã tặng cho tôi khi tốt nghiệp đại học.",
          "explanation": "\"是恩师...送给我的\" nhấn mạnh người tặng và thời điểm tặng."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 72,
      "name": "Cấu trúc điều kiện cần thiết \"只要...就...\" (Chỉ cần... thì...)",
      "pattern": "只要 + Điều kiện cần, 就 + Kết quả tương ứng",
      "category": "Cấu trúc câu",
      "explanation_vi": "Cặp liên từ \"只要...就...\" (zhǐyào... jiù...) biểu thị mối quan hệ điều kiện cần thiết: chỉ cần có điều kiện này được đáp ứng thì nhất định sẽ sản sinh ra kết quả tương ứng kèm theo (chỉ cần... thì sẽ...).",
      "examples": [
        {
          "chinese": "只要大家齐心协力努力拼搏，就一定能够战胜困难。",
          "pinyin": "Zhǐyào dàjiā qíxīn-xiélì nǔlì pīnbó, jiù yídìng nénggòu zhànshèng kùnnán.",
          "translation_vi": "Chỉ cần mọi người đồng tâm hiệp lực nỗ lực phấn đấu thì nhất định có thể chiến thắng khó khăn.",
          "explanation": "\"只要...就...\" nhấn mạnh chỉ cần có sự chung sức sẽ dẫn tới thành công."
        },
        {
          "chinese": "只要明天天气晴朗不刮大风，我们全家人就去郊游。",
          "pinyin": "Zhǐyào míngtiān tiānqì qínglǎng bù guā dàfēng, wǒmen quán jiārén jiù qù jiāoyóu.",
          "translation_vi": "Chỉ cần ngày mai thời tiết tạnh ráo không nổi gió lớn thì cả gia đình chúng tôi sẽ đi dã ngoại.",
          "explanation": "Điều kiện thời tiết tốt để cả nhà đi chơi."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 73,
      "name": "Đại từ chỉ định không xác định \"一些 / 有的\" (Một số / Có những)",
      "pattern": "一些 + Danh từ / 有的 + Danh từ (+ ..., 有的...)",
      "category": "Đại từ",
      "explanation_vi": "\"一些\" (yìxiē) biểu thị số lượng không xác định của sự vật (một vài, một số). \"有的\" (yǒude) dùng để chỉ một bộ phận trong một tổng thể (có người, có những cái). Cấu trúc sóng đôi \"有的...有的...\" chỉ sự đa dạng.",
      "examples": [
        {
          "chinese": "下课后操场上很热闹，有的同学在打篮球，有的在跑步。",
          "pinyin": "Xiàkè hòu cāochǎng shang hěn rènao, yǒude tóngxué zài dǎ lánqiú, yǒude zài pǎobù.",
          "translation_vi": "Sau khi tan học sân vận động rất náo nhiệt, có bạn đang chơi bóng rổ, có bạn lại đang chạy bộ.",
          "explanation": "\"有的...有的...\" miêu tả các nhóm hoạt động phong phú của học sinh."
        },
        {
          "chinese": "他在书店精心挑选了一些适合初学者的汉语课外读物。",
          "pinyin": "Tā zài shūdiàn jīngxīn tiāoxuǎn le yìxiē shìhé chūxuézhě de hànyǔ kèwài dúwù.",
          "translation_vi": "Anh ấy ở hiệu sách đã kỳ công chọn lựa một số cuốn sách đọc thêm tiếng Hán thích hợp cho người mới bắt đầu.",
          "explanation": "\"一些...读物\" chỉ một số lượng sách nhất định."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 74,
      "name": "Trùng điệp động từ biểu thị thử nghiệm / thoải mái \"AA / A一A\"",
      "pattern": "Động từ đơn âm: AA / A一A / A了A (看看 / 看一看 / 看了看)",
      "category": "Động từ",
      "explanation_vi": "Trùng điệp động từ (lặp lại động từ) dùng để biểu thị động tác diễn ra trong thời gian ngắn, mang tính chất thử nghiệm, nhẹ nhàng hoặc làm cho ngữ khí câu cầu khiến trở nên mềm mại, hòa nhã (thử xem chút, ngắm một tí).",
      "examples": [
        {
          "chinese": "这件羊毛外套款式很新颖，你快穿上试一试合不合身。",
          "pinyin": "Zhè jiàn yángmáo wàitào kuǎnshì hěn xīnyǐng, nǐ kuài chuān shang shì-yi-shì hé bù héshēn.",
          "translation_vi": "Chiếc áo khoác dạ len này kiểu dáng rất mới lạ, bạn mau mặc thử một chút xem có vừa vặn không.",
          "explanation": "\"试一试\" biểu thị hành động mặc thử mang tính trải nghiệm ngắn."
        },
        {
          "chinese": "周末我们在家里听听轻音乐、看看书，身心格外放松。",
          "pinyin": "Zhōumò wǒmen zài jiā lǐ tīng-ting qīngyīnyuè, kàn-kan shū, shēnxīn géwài fàngsōng.",
          "translation_vi": "Cuối tuần chúng tôi ở nhà nghe chút nhạc nhẹ, đọc chút sách, thân tâm vô cùng thư thái.",
          "explanation": "\"听听\" và \"看看\" tạo cảm giác thư giãn nhẹ nhàng của các hoạt động."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 75,
      "name": "Trùng điệp tính từ miêu tả mức độ \"AA(的)\" (Xanh mướt / Tròn xoe / Cao vút)",
      "pattern": "Tính từ đơn âm trùng điệp: AA (+ 的) + Danh từ (红红的 / 大大的 / 高高的)",
      "category": "Tính từ",
      "explanation_vi": "Trùng điệp tính từ đơn âm tiết thành dạng \"AA(的)\" dùng để tăng cường mức độ miêu tả, mang sắc thái biểu cảm yêu mến, sinh động hoặc cụ thể hóa hình tượng (tròn xoe, đỏ ửng, cao vút). Thường làm định ngữ hoặc trạng ngữ.",
      "examples": [
        {
          "chinese": "小妹妹长着一双大大的眼睛和一张红红的小脸蛋。",
          "pinyin": "Xiǎo mèimei zhǎng zhe yì shuāng dàdà de yǎnjīng hé yì zhāng hónghóng de xiǎo liǎndàn.",
          "translation_vi": "Em gái nhỏ có một đôi mắt to tròn xoe và một khuôn mặt nhỏ ửng hồng xinh xắn.",
          "explanation": "\"大大的\" và \"红红的\" miêu tả sinh động vẻ đáng yêu của em bé."
        },
        {
          "chinese": "公路两旁整齐地生长着一排排高高的白杨树。",
          "pinyin": "Gōnglù liǎngpáng zhěngqí de shēngzhǎng zhe yì páipái gāogāo de báiyángshù.",
          "translation_vi": "Hai bên đường cái mọc ngay ngắn từng hàng cây bạch dương cao vút.",
          "explanation": "\"高高的\" nhấn mạnh chiều cao nổi bật của rặng cây."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 76,
      "name": "Phó từ biểu thị tính chất vốn có \"本来\" (Vốn dĩ / Ban đầu)",
      "pattern": "Chủ ngữ + 本来 + Vị ngữ (+ 后来 / 但是...)",
      "category": "Phó từ",
      "explanation_vi": "\"本来\" (běnlái) biểu thị trạng thái hoặc tình huống vốn dĩ từ trước đến nay là như vậy, hoặc kế hoạch ban đầu như vậy nhưng về sau có sự thay đổi (vốn dĩ, lẽ ra, ban đầu).",
      "examples": [
        {
          "chinese": "我们本来打算今天去郊游，可是突降大暴雨只好改期。",
          "pinyin": "Wǒmen běnlái dǎsuàn jīntiān qù jiāoyóu, kěshì tūjiàng dà bàoyǔ zhǐhǎo gǎiqī.",
          "translation_vi": "Chúng tôi vốn dĩ dự tính hôm nay đi dã ngoại, nhưng bất chợt đổ mưa to đành phải dời ngày.",
          "explanation": "\"本来打算...可是...\" biểu thị kế hoạch ban đầu bị thay đổi do mưa."
        },
        {
          "chinese": "这道数学题本来就很简单，只要细心就能做对。",
          "pinyin": "Zhè dào shùxué tí běnlái jiù hěn jiǎndān, zhǐyào xìxīn jiù néng zuò duì.",
          "translation_vi": "Bài toán này vốn dĩ đã rất đơn giản, chỉ cần cẩn thận là có thể làm đúng.",
          "explanation": "\"本来就很简单\" nhấn mạnh bản chất vốn có của bài toán."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 77,
      "name": "Từ chỉ thời gian cự ly ngắn \"不久\" (Chẳng bao lâu / Vừa mới)",
      "pattern": "Thời điểm / Hành động + 不久 (+ 就...) / 不久以前",
      "category": "Phó từ",
      "explanation_vi": "\"不久\" (bùjiǔ) chỉ khoảng cách thời gian rất ngắn giữa hai thời điểm hoặc khoảng cách ngắn so với hiện tại (chẳng bao lâu sau, cách đây không lâu).",
      "examples": [
        {
          "chinese": "他们大学毕业后不久，就顺利进入了知名外企工作。",
          "pinyin": "Tāmen dàxué bìyè hòu bùjiǔ, jiù shùnlì jìnrù le zhīmíng wàiqǐ gōngzuò.",
          "translation_vi": "Họ sau khi tốt nghiệp đại học chẳng bao lâu, thì đã thuận lợi bước chân vào làm việc tại công ty nước ngoài danh tiếng.",
          "explanation": "\"毕业后不久\" chỉ khoảng thời gian ngắn sau khi tốt nghiệp."
        },
        {
          "chinese": "这栋现代化的综合教学大楼是不久前刚刚建成的。",
          "pinyin": "Zhè dòng xiàndàihuà de zōnghé jiàoxué dàlóu shì bùjiǔ qián gānggāng jiànchéng de.",
          "translation_vi": "Tòa nhà giảng đường tổng hợp hiện đại này là cách đây không lâu vừa mới xây dựng xong.",
          "explanation": "\"不久前\" chỉ thời điểm xảy ra gần đây."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 78,
      "name": "Cấu trúc cảm thán biểu thị mức độ cao \"太...了\" (Quá... rồi / Lắm)",
      "pattern": "太 + Tính từ / Động từ tâm lý + 了!",
      "category": "Phó từ",
      "explanation_vi": "\"太...了\" (tài... le) dùng để biểu thị mức độ cực kỳ cao, thường dùng trong câu cảm thán để bày tỏ sự khen ngợi, tán thưởng nồng nhiệt hoặc phàn nàn, không hài lòng (quá... rồi, ...lắm).",
      "examples": [
        {
          "chinese": "你在全国青少年演讲比赛中的发挥真是太出色了！",
          "pinyin": "Nǐ zài quánguó qīng-shàonián yǎnjiǎng bǐsài zhōng de fāhuī zhēn shì tài chūsè le!",
          "translation_vi": "Màn thể hiện của bạn trong cuộc thi diễn thuyết thanh thiếu niên toàn quốc thật là quá xuất sắc rồi!",
          "explanation": "\"太出色了\" ca ngợi phong độ tuyệt vời của thí sinh."
        },
        {
          "chinese": "这盘北京烤鸭皮脆肉嫩，味道太香了！",
          "pinyin": "Zhè pán Běijīng kǎoyā pí cuì ròu nèn, wèidào tài xiāng le!",
          "translation_vi": "Đĩa vịt quay Bắc Kinh này da giòn thịt mềm, mùi vị thơm ngon quá chừng!",
          "explanation": "\"太香了\" tán thán hương vị tuyệt hảo của món ăn."
        }
      ],
      "hsk_level": "HSK 2",
      "source": "gf0025_2021",
      "validation_status": "verified"
    }
  ],
  "HSK 3": [
    {
      "order_index": 1,
      "name": "Đại từ phiếm chỉ chỉ người khác \"别人\" (Người khác / Người ngoài)",
      "pattern": "别人 + Vị ngữ / Vị ngữ + 别人",
      "category": "Đại từ",
      "explanation_vi": "\"别人\" (biérén) dùng để chỉ những người khác ngoài bản thân mình hoặc ngoài người đang giao tiếp (người khác, người ngoài). Thường làm chủ ngữ, tân ngữ hoặc định ngữ.",
      "examples": [
        {
          "chinese": "在公共场所与他人交流时，我们应当懂得倾听并尊重别人的意见。",
          "pinyin": "Zài gōnggòng chǎngsuǒ yǔ tārén jiāoliú shí, wǒmen yīngdāng dǒngde qīngtīng bìng zūnzhòng biérén de yìjiàn.",
          "translation_vi": "Khi giao lưu với người khác ở nơi công cộng, chúng ta nên biết lắng nghe và tôn trọng ý kiến của người khác.",
          "explanation": "\"别人的意见\" làm định ngữ bổ nghĩa cho danh từ ý kiến."
        },
        {
          "chinese": "遇到困难时不要一味依赖别人，要学会独立思考解决问题。",
          "pinyin": "Yù dào kùnnán shí bú yào yíwèi yīlài biérén, yào xuéhuì dúlì sīkǎo jiějué wèntí.",
          "translation_vi": "Khi gặp khó khăn đừng chỉ biết mù quáng ỷ lại vào người khác, cần phải học cách suy nghĩ độc lập để giải quyết vấn đề.",
          "explanation": "\"依赖别人\" làm tân ngữ đứng sau động từ phụ thuộc."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 2,
      "name": "Đại từ phân biệt \"其他 / 其它\" (Khác / Còn lại)",
      "pattern": "其他 (+ Lượng từ) + Danh từ (+ 都...)",
      "category": "Đại từ",
      "explanation_vi": "\"其他\" (qítā) dùng để chỉ người hoặc sự vật khác ngoài đối tượng đã được đề cập (khác, còn lại). Khi chỉ đồ vật/sự việc có thể dùng \"其它\". Thường làm định ngữ hoặc đại từ độc lập.",
      "examples": [
        {
          "chinese": "除了这两位请假的同学以外，班里其他学生都准时到校了。",
          "pinyin": "Chúle zhè liǎng wèi qǐngjià de tóngxué yǐwài, bān lǐ qítā xuésheng dōu zhǔnshí dào xiào le.",
          "translation_vi": "Ngoại trừ hai bạn học sinh xin nghỉ phép này ra, các học sinh khác trong lớp đều đã đến trường đúng giờ.",
          "explanation": "\"其他学生\" chỉ nhóm học sinh còn lại trong lớp."
        },
        {
          "chinese": "这个问题已经解决好了，你看看还有没有其他需要补充的建议？",
          "pinyin": "Zhè gè wèntí yǐjīng jiějué hǎo le, nǐ kànkan hái yǒu méiyǒu qítā xūyào bǔchōng de jiànyì?",
          "translation_vi": "Vấn đề này đã được giải quyết xong xuôi rồi, bạn xem xem còn có kiến nghị nào khác cần bổ sung không?",
          "explanation": "\"其他...建议\" bổ nghĩa cho danh từ kiến nghị."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 3,
      "name": "Đại từ bất định chỉ sự vật không hạn chế \"任何\" (Bất kỳ / Bất luận)",
      "pattern": "任何 (+ Lượng từ) + Danh từ + 都 / 也 + Vị ngữ",
      "category": "Đại từ",
      "explanation_vi": "\"任何\" (rènhé) là đại từ bất định biểu thị tính toàn thể không giới hạn (bất kỳ, bất luận cái gì/ai). Thường làm định ngữ đứng trước danh từ và vị ngữ bắt buộc phải có phó từ \"都\" hoặc \"也\".",
      "examples": [
        {
          "chinese": "在神圣的国家法律面前，任何公民都必须严格遵守社会公共秩序。",
          "pinyin": "Zài shénshèng de guójiā fǎlǜ miànqián, rènhé gōngmín dōu bìxū yángé zūnshǒu shèhuì gōnggòng zhìxù.",
          "translation_vi": "Trước pháp luật quốc gia thiêng liêng, bất kỳ công dân nào cũng đều phải nghiêm chỉnh tuân thủ trật tự công cộng xã hội.",
          "explanation": "\"任何公民都\" nhấn mạnh tính phổ quát không có ngoại lệ."
        },
        {
          "chinese": "只要我们下定决心努力奋斗，任何困难都不能阻挡我们前进的步伐。",
          "pinyin": "Zhǐyào wǒmen xiàdìng juéxīn nǔlì fèndòu, rènhé kùnnán dōu bù néng zǔdǎng wǒmen qiánjìn de bùfá.",
          "translation_vi": "Chỉ cần chúng ta hạ quyết tâm nỗ lực phấn đấu, bất kỳ khó khăn nào cũng không thể cản bước tiến của chúng ta.",
          "explanation": "\"任何困难都\" biểu thị tất cả mọi khó khăn đều bị khuất phục."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 4,
      "name": "Số ước lượng đặt sau số từ \"左右\" (Khoảng / Chừng)",
      "pattern": "Số từ + Lượng từ + Danh từ + 左右 / Mốc thời gian + 左右",
      "category": "Số từ",
      "explanation_vi": "\"左右\" (zuǒyòu) đặt ngay sau số lượng từ hoặc từ chỉ thời gian, tuổi tác để biểu thị con số ước lượng xấp xỉ không hoàn toàn chính xác (khoảng, tầm, chừng).",
      "examples": [
        {
          "chinese": "参加今天下午跨国学术视频研讨会的专家学者有五十人左右。",
          "pinyin": "Cānjiā jīntiān xiàwǔ kuàguó xuéshù shìpín yántǎohuì de zhuānjiā xuézhě yǒu wǔshí rén zuǒyòu.",
          "translation_vi": "Các chuyên gia học giả tham gia hội thảo video học thuật xuyên quốc gia chiều nay có khoảng chừng năm mươi người.",
          "explanation": "\"五十人左右\" ước lượng số lượng người tham dự xấp xỉ 50."
        },
        {
          "chinese": "我们今天下午四点半左右在校门口的公交车站集合出发。",
          "pinyin": "Wǒmen jīntiān xiàwǔ sì diǎn bàn zuǒyòu zài xiàoménkǒu de gōngjiāochē zhàn jíhé chūfā.",
          "translation_vi": "Chúng tôi vào khoảng bốn giờ rưỡi chiều nay sẽ tập trung ở trạm xe buýt cổng trường rồi xuất phát.",
          "explanation": "\"四点半左右\" chỉ mốc thời gian ước lượng."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 5,
      "name": "Số ước lượng đặt sau số tròn chục \"上下\" (Khoảng chừng / Xấp xỉ)",
      "pattern": "Số tuổi / Con số tròn + 上下",
      "category": "Số từ",
      "explanation_vi": "\"上下\" (shàngxià) thường đứng sau số từ chỉ tuổi tác hoặc số đo tròn chục để biểu thị số ước tính chênh lệch chút ít lên hoặc xuống (khoảng chừng, trạc tuổi).",
      "examples": [
        {
          "chinese": "那位正在讲台上给留学生授课的教授看起来四十岁上下。",
          "pinyin": "Nà wèi zhèngzài jiǎngtái shang gěi liúxuéshēng shòukè de jiàoshòu kàn qǐlai sìshí suì shàngxià.",
          "translation_vi": "Vị giáo sư đang đứng trên bục giảng dạy bài cho lưu học sinh kia nhìn tầm khoảng bốn mươi tuổi.",
          "explanation": "\"四十岁上下\" ước lượng độ tuổi xấp xỉ 40."
        },
        {
          "chinese": "参加这次马拉松比赛的长跑健儿体重大多在六十公斤上下。",
          "pinyin": "Cānjiā zhè cì mǎlāsōng bǐsài de chángpǎo jiàn'ér tǐzhòng dàduō zài liùshí gōngjīn shàngxià.",
          "translation_vi": "Các vận động viên chạy dài tham gia cuộc đua marathon lần này thể trọng đa số ở khoảng sáu mươi cân (kg).",
          "explanation": "\"六十公斤上下\" biểu thị khoảng cân nặng ước tính."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 6,
      "name": "Phó từ ước lượng đứng trước số từ \"差不多\" (Gần như / Xấp xỉ)",
      "pattern": "差不多 + Số lượng từ / Danh từ / Tính từ",
      "category": "Số từ",
      "explanation_vi": "\"差不多\" (chàbuduō) làm trạng ngữ đứng trước số lượng từ biểu thị con số gần sát mức đó (gần như, ngót nghét, xấp xỉ). Ngoài ra còn làm vị ngữ biểu thị sự tương đương (na ná nhau).",
      "examples": [
        {
          "chinese": "他在这个充满现代化活力的海滨城市生活了差不多十年。",
          "pinyin": "Tā zài zhè gè chōngmǎn xiàndàihuà huólì de hǎibīn chéngshì shēnghuó le chàbuduō shí nián.",
          "translation_vi": "Anh ấy đã sinh sống ở thành phố ven biển tràn đầy sức sống hiện đại này ngót nghét gần mười năm.",
          "explanation": "\"差不多十年\" ước lượng thời gian xấp xỉ gần đủ 10 năm."
        },
        {
          "chinese": "这两款国产智能手机的外观尺寸与显示效果差不多。",
          "pinyin": "Zhè liǎng kuǎn guóchǎn zhìnéng shǒujī de wàiguān chǐcùn yǔ xiǎnshì xiàoguǒ chàbuduō.",
          "translation_vi": "Kích thước bề ngoài và hiệu quả hiển thị của hai mẫu điện thoại thông minh nội địa này xấp xỉ như nhau.",
          "explanation": "\"差不多\" làm vị ngữ chỉ sự tương đương."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 7,
      "name": "Số ước lượng với \"多\" biểu thị số dôi dư (Hơn / Ngoài)",
      "pattern": "Số tròn chục/trăm/nghìn + 多 + Lượng từ / Số lẻ nhỏ hơn 10 + Lượng từ + 多",
      "category": "Số từ",
      "explanation_vi": "Vị trí của \"多\" (duō) phụ thuộc vào con số đứng trước: nếu là số tròn chục trở lên (10, 20, 100) thì \"多\" đứng TRƯỚC lượng từ (như: 十多个人: mười mấy người); nếu là số lẻ dưới 10 thì \"多\" đứng SAU lượng từ (như: 三个多月: hơn ba tháng).",
      "examples": [
        {
          "chinese": "我们大学的国际交流学院一共有二十多位外籍留学生。",
          "pinyin": "Wǒmen dàxué de guójì jiāoliú xuéyuàn yígòng yǒu èrshí duō wèi wàijí liúxuéshēng.",
          "translation_vi": "Học viện giao lưu quốc tế trường đại học chúng tôi tổng cộng có hơn hai mươi bạn lưu học sinh nước ngoài.",
          "explanation": "\"二十多位\" do 20 là số tròn chục nên \"多\" đứng trước lượng từ \"位\"."
        },
        {
          "chinese": "他为了准备高级翻译资格考试，连续苦读了五个多月。",
          "pinyin": "Tā wèile zhǔnbèi gāojí fānyì zīgé kǎoshì, liánxù kǔdú le wǔ gè duō yuè.",
          "translation_vi": "Để chuẩn bị cho kỳ thi chứng chỉ biên phiên dịch cao cấp, anh ấy đã miệt mài dùi mài liên tục hơn năm tháng.",
          "explanation": "\"五个多月\" do 5 là số nhỏ hơn 10 nên \"多\" đứng sau lượng từ \"个\"."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 8,
      "name": "Lượng từ đoạn đường / thời gian \"段\" (Đoạn / Quãng)",
      "pattern": "一 + 段 + Thời gian (时间) / Khoảng cách (路) / Câu văn (话)",
      "category": "Lượng từ",
      "explanation_vi": "\"段\" (duàn) là lượng từ dùng cho một phần của không gian dài (một đoạn đường: 一段路), một khoảng thời gian liên tục (một quãng thời gian: 一段时间), hoặc một phân đoạn văn bản, lời nói (一段话).",
      "examples": [
        {
          "chinese": "经过前一段时间的刻苦训练，他的汉语听说水平有了显著提升。",
          "pinyin": "Jīngguò qián yí duàn shíjiān de kèkǔ xùnliàn, tā de hànyǔ tīng-shuō shuǐpíng yǒu le xiǎnzhù tíshēng.",
          "translation_vi": "Trải qua một quãng thời gian khổ luyện trước đó, trình độ nghe nói tiếng Hán của anh ấy đã có bước nâng cao rõ rệt.",
          "explanation": "\"一段时间\" chỉ khoảng thời gian liên tục đã qua."
        },
        {
          "chinese": "老师在黑板上端正地抄写了一段著名的古文名言。",
          "pinyin": "Lǎoshī zài hēibǎn shang duānzhèng de chāoxiě le yí duàn zhùmíng de gǔwén míngyán.",
          "translation_vi": "Thầy giáo nắn nót chép lên bảng đen một đoạn danh ngôn cổ văn nổi tiếng.",
          "explanation": "\"一段...名言\" lượng từ cho đoạn văn bản."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 9,
      "name": "Lượng từ chủng loại / kiểu mẫu \"种\" (Loại / Thứ)",
      "pattern": "Số từ + 种 + Danh từ (水果 / 语言 / 办法)",
      "category": "Lượng từ",
      "explanation_vi": "\"种\" (zhǒng) là lượng từ chỉ chủng loại, phân loại của sự vật hoặc hiện tượng trừu tượng (loại, thứ, phương diện).",
      "examples": [
        {
          "chinese": "这位资深翻译专家熟练掌握了英、法、西等三种联合国官方语言。",
          "pinyin": "Zhè wèi zīshēn fānyì zhuānjiā shúliàn zhǎngwò le yīng, fǎ, xī děng sān zhǒng Liánhéguó guānfāng yǔyán.",
          "translation_vi": "Chuyên gia dịch thuật kỳ cựu này đã nắm vững thuần thục ba thứ ngôn ngữ chính thức của Liên Hợp Quốc gồm Anh, Pháp, Tây Ban Nha.",
          "explanation": "\"三种...语言\" biểu thị ba loại ngôn ngữ."
        },
        {
          "chinese": "面对突如其来的技术故障，工程师提出了两种可行的解决办法。",
          "pinyin": "Miànduì tūrúqílái de jìshù gùzhàng, gōngchéngshī tíchū le liǎng zhǒng kěxíng de jiějué bànfǎ.",
          "translation_vi": "Đối mặt với sự cố kỹ thuật đột xuất, kỹ sư đã đề xuất hai loại biện pháp giải quyết khả thi.",
          "explanation": "\"两种...办法\" phân loại biện pháp xử lý."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 10,
      "name": "Lượng từ vật có cán / nắm tay \"把\" (Chiếc / Cây / Con)",
      "pattern": "Số từ + 把 + Ô (伞) / Dao (刀) / Ghế (椅子) / Thìa (勺子)",
      "category": "Lượng từ",
      "explanation_vi": "\"把\" (bǎ) là lượng từ dùng cho các dụng cụ, đồ vật có cán cầm, chuôi nắm như chiếc ô (一把伞), con dao (一把刀), chiếc ghế dựa (一把椅子), cái thìa (一把勺子). Ngoài ra còn chỉ nắm tay (một nắm: 一把米).",
      "examples": [
        {
          "chinese": "出门前看到天气阴沉沉的，母亲特意递给我一把结实的雨伞。",
          "pinyin": "Chūmén qián kàn dào tiānqì yīnchénchén de, mǔqīn tèyì dì gěi wǒ yì bǎ jiēshi de yǔsǎn.",
          "translation_vi": "Trước khi ra khỏi cửa thấy trời râm u ám, người mẹ đã đặc biệt đưa cho tôi một chiếc ô chắc chắn.",
          "explanation": "\"一把...雨伞\" là lượng từ tiêu chuẩn dùng cho ô dù có cán cầm."
        },
        {
          "chinese": "会议室里整齐地摆放着二十把舒适崭新的办公椅子。",
          "pinyin": "Huìyìshì lǐ zhěngqí de bǎifàng zhe èrshí bǎ shūshì zhǎnxīn de bàngōng yǐzi.",
          "translation_vi": "Trong phòng họp đang bày biện ngay ngắn hai mươi chiếc ghế văn phòng mới toanh êm ái.",
          "explanation": "\"二十把...椅子\" dùng cho ghế ngồi có tay vịn/tựa."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 11,
      "name": "Lượng từ tài liệu / phần ăn \"份\" (Bản / Phần / Suất)",
      "pattern": "Số từ + 份 + Báo chí (报纸) / Hồ sơ (材料) / Bữa ăn (外卖)",
      "category": "Lượng từ",
      "explanation_vi": "\"份\" (fèn) là lượng từ dùng cho các văn bản tài liệu được in ấn theo bản/bộ (một tờ báo: 一份报纸, một bản báo cáo: 一份报告), phần ăn suất ăn (một suất cơm: 一份午饭), hoặc công việc tình cảm (một công việc: 一份工作, một tấm lòng: 一份心意).",
      "examples": [
        {
          "chinese": "他在求职招聘网站上向知名外资企业投递了一份详尽的个人简历。",
          "pinyin": "Tā zài qiúzhí zhāopìn wǎngzhàn shang xiàng zhīmíng wàizī qǐyè tóudì le yí fèn xiángjìn de gèrén jiǎnlì.",
          "translation_vi": "Anh ấy trên trang web tuyển dụng việc làm đã nộp một bản sơ yếu lý lịch cá nhân chi tiết tới doanh nghiệp có vốn đầu tư nước ngoài danh tiếng.",
          "explanation": "\"一份...简历\" lượng từ cho bản sơ yếu lý lịch."
        },
        {
          "chinese": "中午下班后，同事们在写字楼下各自订了一份热气腾腾的营养快餐。",
          "pinyin": "Zhōngwǔ xiàbān hòu, tóngshì men zài xiězìlóu xià gèzì dìng le yí fèn rèqì-téngténg de yíngyǎng kuàicān.",
          "translation_vi": "Buổi trưa sau khi tan sở, các đồng nghiệp dưới chân tòa nhà văn phòng ai nấy đều đặt một suất cơm nhanh dinh dưỡng nóng hổi.",
          "explanation": "\"一份...快餐\" lượng từ cho suất ăn nhanh."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 12,
      "name": "Lượng từ thư từ / điện tín \"封\" (Bức / Lá)",
      "pattern": "Số từ + 封 + Thư (信) / Email (电子邮件)",
      "category": "Lượng từ",
      "explanation_vi": "\"封\" (fēng) là lượng từ chuyên dụng dùng cho thư từ, thư điện tử có niêm phong đóng gói (một bức thư: 一封信, một email: 一封电子邮件).",
      "examples": [
        {
          "chinese": "远在大洋彼岸的海外留学生给父母寄来了一封长长的深情家书。",
          "pinyin": "Yuǎn zài dàyáng-bǐ'àn de hǎiwài liúxuéshēng gěi fùmǔ jì lái le yì fēng chángcháng de shēnqíng jiāshū.",
          "translation_vi": "Người bạn du học sinh ở bờ bên kia đại dương xa xôi đã gửi về cho cha mẹ một bức thư nhà dài chan chứa thâm tình.",
          "explanation": "\"一封...家书\" dùng cho lá thư gia đình."
        },
        {
          "chinese": "人力资源部门今早给每一位通过初试的求职者发送了一封复试通知。",
          "pinyin": "Rénlì zīyuán bùmén jīnzǎo gěi měi yí wèi tōngguò chūshì de qiúzhízhě fāsòng le yì fēng fùshì tōngzhī.",
          "translation_vi": "Phòng nhân sự sáng nay đã gửi một bức thông báo thi vòng hai tới mỗi ứng viên vượt qua vòng sơ tuyển.",
          "explanation": "\"一封...通知\" dùng cho bức thông báo gửi qua email."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 13,
      "name": "Lượng từ bài viết / bài báo \"篇\" (Bài / Thiên)",
      "pattern": "Số từ + 篇 + Bài văn (文章) / Bài báo (报道) / Luận văn (论文)",
      "category": "Lượng từ",
      "explanation_vi": "\"篇\" (piān) là lượng từ dùng cho bài văn, bài báo, bài viết hoặc luận văn học thuật có kết cấu hoàn chỉnh (một bài văn: 一篇文章, một bài báo: 一篇报道, một bài luận: 一篇论文).",
      "examples": [
        {
          "chinese": "这位青年学者在国际著名权威期刊上发表了一篇高水平的学术论文。",
          "pinyin": "Zhè wèi qīngnián xuézhě zài guójì zhùmíng quánwēi qīkān shang fābiǎo le yì piān gāo shuǐpíng de xuéshù lùnwén.",
          "translation_vi": "Học giả trẻ này đã công bố một bài luận văn học thuật trình độ cao trên tạp chí uy tín nổi tiếng quốc tế.",
          "explanation": "\"一篇...论文\" lượng từ cho bài luận văn khoa học."
        },
        {
          "chinese": "语文老师要求每个学生在周末认真阅读并背诵一篇古典抒情散文。",
          "pinyin": "Yǔwén lǎoshī yāoqiú měi gè xuésheng zài zhōumò rènzhēn yuèdú bìng bèisòng yì piān gǔdiǎn shūqíng sǎnwén.",
          "translation_vi": "Thầy giáo ngữ văn yêu cầu mỗi học sinh vào dịp cuối tuần cần chăm chú đọc và học thuộc một bài tản văn trữ tình cổ điển.",
          "explanation": "\"一篇...散文\" lượng từ cho bài tản văn."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 14,
      "name": "Phó từ mức độ tột đỉnh \"极 / 极其\" (Cực kỳ / Vô cùng)",
      "pattern": "Tính từ + 极了! / 极其 + Tính từ / Cụm động từ",
      "category": "Phó từ",
      "explanation_vi": "Khi làm bổ ngữ mức độ, \"极\" đứng sau tính từ theo cấu trúc \"...极了\" (vui mừng khôn xiết: 高兴极了). Khi làm phó từ đứng trước tính từ hoặc động từ tâm lý, thường dùng song âm tiết \"极其\" (cực kỳ quan trọng: 极其重要).",
      "examples": [
        {
          "chinese": "得知国家队在决赛中逆转夺得冠军的消息，全体球迷高兴极了！",
          "pinyin": "Dézhī guójiāduì zài juésài zhōng nìzhuǎn duó dé guànjūn de xiāoxi, quántǐ qiúmǐ gāoxìng jí le!",
          "translation_vi": "Hay tin đội tuyển quốc gia lội ngược dòng đoạt chức vô địch trong trận chung kết, toàn thể người hâm mộ bóng đá vui mừng khôn xiết!",
          "explanation": "\"高兴极了\" biểu thị niềm vui đạt đến đỉnh điểm tuyệt đối."
        },
        {
          "chinese": "保护生物多样性对维系全球生态平衡具有极其重要的深远意义。",
          "pinyin": "Bǎohù shēngwù duōyàngxìng duì wéixì quánqiú shēngtài pínghéng jùyǒu jíqí zhòngyào de shēnyuǎn yìyì.",
          "translation_vi": "Bảo vệ sự đa dạng sinh học có ý nghĩa sâu xa cực kỳ quan trọng đối với việc duy trì cân bằng sinh thái toàn cầu.",
          "explanation": "\"极其重要\" trạng ngữ chỉ mức độ quan trọng tột bậc."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 15,
      "name": "Phó từ mức độ nhẹ \"稍微 / 稍\" (Hơi / Một chút)",
      "pattern": "稍微 (+ 一点儿) + Tính từ / 稍微 + Động từ + 一下",
      "category": "Phó từ",
      "explanation_vi": "\"稍微\" (shāowēi) biểu thị số lượng ít hoặc mức độ nhẹ (hơi, một chút, một lát). Phía sau thường kết hợp với \"一点儿\", \"一些\" hoặc động từ mang \"一下\". Khác với \"有点儿\" (thường mang sắc thái tiêu cực), \"稍微\" mang tính khách quan trung tính.",
      "examples": [
        {
          "chinese": "这件羊毛大衣的袖子稍微有一点儿长，请裁缝师傅帮忙改短一些。",
          "pinyin": "Zhè jiàn yángmáo dàyī de xiùzi shāowēi yǒu yìdiǎnr cháng, qǐng cáifeng shīfu bāngmáng gǎi duǎn yìxiē.",
          "translation_vi": "Ống tay của chiếc áo khoác dạ len này hơi dài một chút, xin nhờ bác thợ may sửa ngắn bớt một tẹo.",
          "explanation": "\"稍微有一点儿长\" miêu tả độ dài hơi chênh lệch một chút."
        },
        {
          "chinese": "请各位来宾在候车大厅稍微休息一下，列车马上进站检票。",
          "pinyin": "Qǐng gèwèi láibīn zài hòuchē dàtīng shāowēi xiūxi yíxià, lièchē mǎshàng jìn zhàn jiǎnpiào.",
          "translation_vi": "Mời quý khách nghỉ ngơi một chút ở sảnh chờ, đoàn tàu sẽ vào ga soát vé ngay thôi.",
          "explanation": "\"稍微休息一下\" đề nghị nghỉ ngơi chốc lát."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 16,
      "name": "Phó từ giới hạn tiệm cận \"几乎\" (Hầu như / Suýt nữa)",
      "pattern": "几乎 + 都 / 没 / Tính từ / Động từ",
      "category": "Phó từ",
      "explanation_vi": "\"几乎\" (jīhū) biểu thị trạng thái vô cùng tiếp cận với toàn bộ hoặc suýt soát xảy ra nhưng thực tế chưa xảy ra (hầu như, gần như, suýt nữa).",
      "examples": [
        {
          "chinese": "经过一个学期的刻苦攻读，全班同学几乎都顺利通过了汉语水平考试。",
          "pinyin": "Jīngguò yí gè xuéqī de kèkǔ gōngdú, quán bān tóngxué jīhū dōu shùnlì tōngguò le hànyǔ shuǐpíng kǎoshì.",
          "translation_vi": "Trải qua một học kỳ miệt mài dùi mài, học sinh cả lớp hầu như đều đã thuận lợi thi đỗ kỳ thi năng lực Hán ngữ.",
          "explanation": "\"几乎都\" nhấn mạnh tỷ lệ đỗ đạt tiếp cận 100%."
        },
        {
          "chinese": "路面结冰太滑，他刚才在台阶上走得太急，几乎滑倒在地上。",
          "pinyin": "Lùmiàn jiébīng tài huá, tā gāngcái zài táijiē shang zǒu de tài jí, jīhū huádǎo zài dì shang.",
          "translation_vi": "Mặt đường đóng băng trơn quá, ban nãy anh ấy bước quá vội trên bậc thang suýt nữa trượt ngã xuống đất.",
          "explanation": "\"几乎滑倒\" biểu thị suýt ngã nhưng chưa ngã."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 17,
      "name": "Phó từ biến đổi tuần tự \"逐渐 / 渐渐\" (Dần dần / Từng bước)",
      "pattern": "逐渐 / 渐渐 + Động từ / Tính từ (+ 起来 / 了)",
      "category": "Phó từ",
      "explanation_vi": "\"逐渐\" (zhújiàn) biểu thị mức độ hoặc số lượng phát triển theo từng bước, diễn tiến từ từ theo thời gian (dần dần, từng bước một). Thường dùng trong văn viết, văn cảnh trang trọng.",
      "examples": [
        {
          "chinese": "随着春天悄然来临，冰封的大地和山川河谷开始逐渐融化生机盎然。",
          "pinyin": "Suízhe chūntiān qiǎorán láilín, bīngfēng de dàdì hé shānchuān hégǔ kāishǐ zhújiàn rónghuà shēngjī-àngrán.",
          "translation_vi": "Cùng với mùa xuân lặng lẽ đến, đất trời và sông núi thung lũng đóng băng bắt đầu dần dần tan chảy tràn trề sức sống.",
          "explanation": "\"逐渐融化\" miêu tả quá trình tan băng diễn ra tuần tự từng ngày."
        },
        {
          "chinese": "经过几个月的临床药物治疗，患者的各项身体生理指标逐渐恢复正常。",
          "pinyin": "Jīngguò jǐ gè yuè de línchuáng yàowù zhìliáo, huànzhě de gè xiàng shēntǐ shēnglǐ zhǐbiāo zhújiàn huīfù zhèngcháng.",
          "translation_vi": "Trải qua vài tháng điều trị thuốc lâm sàng, các chỉ số sinh lý cơ thể của bệnh nhân dần dần khôi phục bình thường.",
          "explanation": "\"逐渐恢复\" chỉ sự phục hồi sức khỏe từng bước một."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 18,
      "name": "Phó từ tương hỗ đa phương \"互相\" (Lẫn nhau / Tương hỗ)",
      "pattern": "互相 + Động từ song âm tiết (帮助 / 学习 / 尊重 / 理解)",
      "category": "Phó từ",
      "explanation_vi": "\"互相\" (hùxiāng) biểu thị hai bên hoặc nhiều bên cùng tác động qua lại lẫn nhau với cùng một hành động (lẫn nhau, cùng nhau). Động từ theo sau thường là động từ song âm tiết.",
      "examples": [
        {
          "chinese": "不同文化背景的留学生生活在一起，应当互相尊重、互相包容。",
          "pinyin": "Bùtóng wénhuà bèijǐng de liúxuéshēng shēnghuó zài yìqǐ, yīngdāng hùxiāng zūnzhòng, hùxiāng bāoróng.",
          "translation_vi": "Các lưu học sinh có bối cảnh văn hóa khác nhau khi sống cùng nhau nên tôn trọng lẫn nhau, bao dung lẫn nhau.",
          "explanation": "\"互相尊重\" thể hiện hành vi tôn trọng hai chiều qua lại."
        },
        {
          "chinese": "同学们在日常学习中经常互相帮助，共同解决学习中的疑难问题。",
          "pinyin": "Tóngxué men zài rìcháng xuéxí zhōng jīngcháng hùxiāng bāngzhù, gòngtóng jiějué xuéxí zhōng de yínán wèntí.",
          "translation_vi": "Các bạn học sinh trong học tập hằng ngày thường xuyên giúp đỡ lẫn nhau, cùng nhau giải quyết các bài toán khó khăn.",
          "explanation": "\"互相帮助\" chỉ sự tương trợ qua lại giữa bạn bè."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 19,
      "name": "Phó từ truy cứu đến cùng \"到底 / 究竟\" (Rốt cuộc / Cuối cùng)",
      "pattern": "到底 / 究竟 + Từ để hỏi / Vị ngữ nghi vấn?",
      "category": "Phó từ",
      "explanation_vi": "\"到底\" (dàodǐ) hoặc \"究竟\" (jiūjìng) đứng trước đại từ nghi vấn hoặc vị ngữ trong câu hỏi để thể hiện ngữ khí truy hỏi ráo riết đến cùng (rốt cuộc, rốt cuộc là thế nào). Ngoài ra \"到底\" còn chỉ kết quả cuối cùng trong câu trần thuật.",
      "examples": [
        {
          "chinese": "明天早晨的学术专题报告会到底是在几点钟正式开始？",
          "pinyin": "Míngtiān zǎochén de xuéshù zhuāntí bàogàohuì dàodǐ shì zài jǐ diǎn zhōng zhèngshì kāishǐ?",
          "translation_vi": "Buổi báo cáo chuyên đề học thuật sáng mai rốt cuộc là mấy giờ chính thức bắt đầu?",
          "explanation": "\"到底是在几点\" tăng cường ngữ khí truy hỏi thời gian chính xác."
        },
        {
          "chinese": "经过长达五年的艰苦联合技术攻坚，这个国家级重大科研项目到底成功了！",
          "pinyin": "Jīngguò chángdá wǔ nián de jiānkǔ liánhé jìshù gōngjiān, zhè gè guójiājí zhòngdà kēyán xiàngmù dàodǐ chénggōng le!",
          "translation_vi": "Trải qua suốt năm năm phối hợp công phá kỹ thuật gian khổ, dự án nghiên cứu khoa học trọng đại cấp quốc gia này cuối cùng cũng đã thành công!",
          "explanation": "\"到底成功了\" chỉ kết quả đạt được sau nỗ lực dài lâu trong câu trần thuật."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 20,
      "name": "Phó từ thời gian vừa mới xảy ra \"刚 / 刚才\" (Vừa / Vừa mới)",
      "pattern": "刚 + Động từ (Phó từ) / 刚才 + Vị ngữ (Danh từ chỉ thời gian)",
      "category": "Phó từ",
      "explanation_vi": "Phân biệt \"刚\" và \"刚才\": \"刚\" là phó từ chỉ hành động vừa mới xảy ra cách đây chốc lát, đứng ngay trước động từ (như: 我刚来); còn \"刚才\" là danh từ thời gian chỉ thời điểm vài phút trước, có thể đứng trước hoặc sau chủ ngữ (như: 刚才我去开会 / 我刚才去开会).",
      "examples": [
        {
          "chinese": "列车刚进站停稳，旅客们就井然有序地排队准备检票出站。",
          "pinyin": "Lièchē gāng jìn zhàn tíng wěn, lǚkè men jiù jǐngrán-yǒuxù de páiduì zhǔnbèi jiǎnpiào chū zhàn.",
          "translation_vi": "Đoàn tàu vừa mới vào ga đỗ ngay ngắn, các hành khách liền trật tự xếp hàng chuẩn bị soát vé ra ga.",
          "explanation": "\"刚进站\" phó từ \"刚\" đứng trước động từ chỉ sự việc vừa mới xong."
        },
        {
          "chinese": "刚才在走廊里和你热情打招呼的那位老教授是谁？",
          "pinyin": "Gāngcái zài zǒuláng lǐ hé nǐ rèqíng dǎ zhāohu de nà wèi lǎo jiàoshòu shì shéi?",
          "translation_vi": "Vị giáo sư già vừa nãy ở hành lang nhiệt tình chào hỏi bạn là ai thế?",
          "explanation": "\"刚才\" danh từ thời gian chỉ thời điểm ban nãy."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 21,
      "name": "Phó từ thời gian đột ngột \"突然\" (Đột nhiên / Bất ngờ)",
      "pattern": "突然 + Động từ / Cụm chủ vị (Trạng ngữ) / Rất + 突然 (Vị ngữ)",
      "category": "Phó từ",
      "explanation_vi": "\"突然\" (tūrán) biểu thị sự việc phát sinh bất ngờ, mau lẹ ngoài dự liệu (đột nhiên, bất thình lình). Vừa có thể làm trạng ngữ đứng trước động từ, vừa có thể làm hình dung từ làm vị ngữ.",
      "examples": [
        {
          "chinese": "我们正走在回家的路上，天空中突然电闪雷鸣下起了倾盆暴雨。",
          "pinyin": "Wǒmen zhèng zǒu zài huíjiā de lù shang, tiānkōng zhōng tūrán diànshǎn-léimíng xià qǐ le qīngpén bàoyǔ.",
          "translation_vi": "Chúng tôi đang đi trên đường về nhà, trên bầu trời đột nhiên chớp giật sấm rền đổ xuống cơn mưa rào như trút nước.",
          "explanation": "\"突然...下起\" làm trạng ngữ miêu tả sự xuất hiện bất ngờ của cơn mưa."
        },
        {
          "chinese": "这个突发交通事故发生得太突然了，在场的所有人都惊呆了。",
          "pinyin": "Zhè gè tūfā jiāotōng shìgù fāshēng de tài tūrán le, zàichǎng de suǒyǒu rén dōu jīngdāi le.",
          "translation_vi": "Vụ tai nạn giao thông đột xuất này xảy ra quá đỗi bất ngờ, toàn thể người có mặt đều sững sờ.",
          "explanation": "\"太突然了\" làm bổ ngữ/vị ngữ tính từ chỉ mức độ bất ngờ."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 22,
      "name": "Phó từ kiên quyết nhất định \"一定\" (Nhất định / Chắc chắn)",
      "pattern": "一定 + Động từ / Tính từ / (不)一定",
      "category": "Phó từ",
      "explanation_vi": "\"一定\" (yídìng) biểu thị ý chí kiên quyết, sự phán đoán chắc chắn không nghi ngờ (nhất định, chắc chắn). Phủ định là \"不一定\" (chưa chắc, không hẳn).",
      "examples": [
        {
          "chinese": "只要我们坚持脚踏实地努力拼搏，就一定能够实现心中的梦想。",
          "pinyin": "Zhǐyào wǒmen jiānchí jiǎotà-shídì nǔlì pīnbó, jiù yídìng nénggòu shíxiàn xīnzhōng de mèngxiǎng.",
          "translation_vi": "Chỉ cần chúng ta kiên trì vững vàng nỗ lực phấn đấu thì nhất định có thể thực hiện được giấc mơ trong lòng.",
          "explanation": "\"一定能够\" khẳng định chắc chắn về khả năng thành công."
        },
        {
          "chinese": "外表光鲜亮丽的商品，其质量和做工并不一定都非常优良。",
          "pinyin": "Wàibiǎo guāngxiān-liànglì de shāngpǐn, qí zhìliàng hé zuògōng bìng bù yídìng dōu fēicháng yōuliáng.",
          "translation_vi": "Mặt hàng bề ngoài bóng bẩy lộng lẫy thì chất lượng và gia công chưa hẳn đều rất ưu lương.",
          "explanation": "\"不一定\" phủ định sự tất yếu tuyệt đối."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 23,
      "name": "Phó từ tiếp tục tiến thêm một bước \"越发 / 更加\" (Càng / Càng thêm)",
      "pattern": "更加 / 越发 + Tính từ / Cụm động từ tâm lý",
      "category": "Phó từ",
      "explanation_vi": "\"更加\" (gèngjiā) hoặc \"越发\" (yuèfā) đứng trước tính từ hoặc động từ tâm lý biểu thị mức độ phát triển cao hơn một bậc trên nền tảng sẵn có (càng thêm, càng... hơn nữa).",
      "examples": [
        {
          "chinese": "秋雨过后，漫山遍野枫树林的红叶显得更加鲜艳夺目。",
          "pinyin": "Qiūyǔ guòhòu, mànshān-biànyě fēngshùlín de hóngyè xiǎnde gèngjiā xiānyàn duómù.",
          "translation_vi": "Sau cơn mưa thu, lá đỏ rừng phong khắp núi rừng lại càng thêm tươi thắm rực rỡ bắt mắt.",
          "explanation": "\"更加鲜艳\" biểu thị mức độ tươi thắm tăng thêm một bậc sau mưa."
        },
        {
          "chinese": "听到恩师充满期许的真诚鼓励，他心中越发坚定了求学的信念。",
          "pinyin": "Tīng dào ēnshī chōngmǎn qīxǔ de zhēnchéng gǔlì, tā xīnzhōng yuèfā jiāndìng le qiúxué de xìnniàn.",
          "translation_vi": "Nghe lời khích lệ chân thành tràn đầy kỳ vọng của thầy ơn, trong lòng anh càng thêm kiên định niềm tin theo đuổi học vấn.",
          "explanation": "\"越发坚定\" nhấn mạnh niềm tin trở nên vững chắc hơn."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 24,
      "name": "Phó từ phạm vi hạn định \"一共 / 总共\" (Tổng cộng / Tất cả)",
      "pattern": "一共 / 总共 + Số lượng từ / Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"一共\" (yígòng) hoặc \"总共\" (zǒnggòng) đứng trước cụm số từ hoặc vị ngữ để biểu thị tổng số lượng gộp lại của các khoản mục, số người hoặc chi phí (tổng cộng, tất cả gồm có).",
      "examples": [
        {
          "chinese": "参加今天全校春季长跑越野赛的师生运动员一共有五百余人。",
          "pinyin": "Cānjiā jīntiān quán xiào chūnjì chángpǎo yuèyěsài de shīshēng yùndòngyuán yígòng yǒu wǔbǎi yú rén.",
          "translation_vi": "Các thầy trò vận động viên tham gia giải chạy việt dã mùa xuân toàn trường hôm nay tổng cộng có hơn năm trăm người.",
          "explanation": "\"一共有\" tổng kết toàn bộ số lượng vận động viên tham gia."
        },
        {
          "chinese": "买这些专业汉语教材和学习用品，总共花费了三百五十块钱。",
          "pinyin": "Mǎi zhèxiē zhuānyè hànyǔ jiàocái hé xuéxí yòngpǐn, zǒnggòng huāfèi le sānbǎi wǔshí kuài qián.",
          "translation_vi": "Mua những cuốn giáo trình Hán ngữ chuyên ngành và đồ dùng học tập này, tổng cộng tiêu tốn hết ba trăm năm mươi tệ.",
          "explanation": "\"总共花费\" gộp toàn bộ chi phí mua sắm."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 25,
      "name": "Phó từ giới hạn duy nhất \"只 / 仅仅\" (Chỉ / Chỉ có)",
      "pattern": "只 / 仅仅 + Động từ / Số lượng từ",
      "category": "Phó từ",
      "explanation_vi": "\"只\" (zhǐ) là phó từ phạm vi đứng trước động từ để biểu thị sự hạn định duy nhất vào một đối tượng, hành vi hoặc phạm vi nhỏ (chỉ, chỉ có). Văn viết trang trọng dùng \"仅仅\".",
      "examples": [
        {
          "chinese": "整间宽敞的自习室里非常安静，只听见翻阅书页的沙沙声。",
          "pinyin": "Zhěng jiān kuānchǎng de zìxíshì lǐ fēicháng ānjìng, zhǐ tīngjiàn fānyuè shūyè de shāshā shēng.",
          "translation_vi": "Bên trong cả phòng tự học rộng rãi vô cùng yên tĩnh, chỉ nghe thấy tiếng lật trang sách xào xạc.",
          "explanation": "\"只听见\" hạn định duy nhất âm thanh lật sách."
        },
        {
          "chinese": "他今天早晨因为匆忙出门，只吃了一片烤面包就去上班了。",
          "pinyin": "Tā jīntiān zǎochén yīnwèi cōngmáng chūmén, zhǐ chī le yí piàn kǎo miànbāo jiù qù shàngbān le.",
          "translation_vi": "Sáng nay vì vội vàng ra khỏi cửa, anh ấy chỉ ăn một lát bánh mì nướng là đi làm rồi.",
          "explanation": "\"只吃了一片\" giới hạn lượng thức ăn ít ỏi."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 26,
      "name": "Phó từ xác nhận hiển nhiên \"当然\" (Đương nhiên / Dĩ nhiên)",
      "pattern": "当然 + Động từ / Tính từ / 当然可以!",
      "category": "Phó từ",
      "explanation_vi": "\"当然\" (dāngrán) biểu thị sự việc là hợp lý, hiển nhiên không cần nghi ngờ hoặc dùng trong lời đáp để biểu thị sự đồng ý nhiệt tình, quả quyết (đương nhiên, dĩ nhiên).",
      "examples": [
        {
          "chinese": "只要你平时付出足够的辛勤汗水，期末考试当然能取得好成绩。",
          "pinyin": "Zhǐyào nǐ píngrì fùchū zúgòu de xīnqín hànshuǐ, qīmò kǎoshì dāngrán néng qǔdé hǎo chéngjì.",
          "translation_vi": "Chỉ cần ngày thường bạn bỏ ra đầy đủ mồ hôi công sức, kỳ thi cuối kỳ đương nhiên có thể đạt thành tích tốt.",
          "explanation": "\"当然能\" khẳng định kết quả hiển nhiên theo quy luật nhân quả."
        },
        {
          "chinese": "“我可以在这里借阅这本汉语字典吗？”——“当然可以，请便！”",
          "pinyin": "“Wǒ kěyǐ zài zhèlǐ jièyuè zhè běn hànyǔ zìdiǎn ma?” —— “Dāngrán kěyǐ, qǐng biàn!”",
          "translation_vi": "“Tôi có thể mượn đọc cuốn từ điển tiếng Hán này ở đây được không?” —— “Đương nhiên được chứ, xin cứ tự nhiên!”",
          "explanation": "\"当然可以\" lời đáp biểu thị sự đồng ý dứt khoát vui vẻ."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 27,
      "name": "Phó từ ngữ khí phản vấn gay gắt \"难道\" (Chẳng lẽ / Lẽ nào)",
      "pattern": "难道 + Phân câu hỏi (+ 吗 / 不成)?",
      "category": "Phó từ",
      "explanation_vi": "\"难道\" (nándào) đặt trước câu hỏi phản vấn để tăng cường ngữ khí ngạc nhiên, trách móc hoặc khẳng định dứt khoát một sự việc hiển nhiên (chẳng lẽ, lẽ nào... lại như thế). Thường kết hợp với \"吗\" ở cuối câu.",
      "examples": [
        {
          "chinese": "明天的开学典礼这么重要，难道你真打算无故请假不去吗？",
          "pinyin": "Míngtiān de kāixué diǎnlǐ zhème zhòngyào, nándào nǐ zhēn dǎsuàn wúgù qǐngjià bú qù ma?",
          "translation_vi": "Lễ khai giảng ngày mai quan trọng như thế, chẳng lẽ bạn thực sự dự tính xin nghỉ không lý do để không đi sao?",
          "explanation": "\"难道...吗\" tăng cường ngữ khí chất vấn sự vô lý của việc xin nghỉ."
        },
        {
          "chinese": "这道题目老师上周刚讲过两次，难道你们大家都忘得一干二净了吗？",
          "pinyin": "Zhè dào tímù lǎoshī shàng zhōu gāng jiǎng guo liǎng cì, nándào nǐmen dàjiā dōu wàng de yìgān-èrjìng le ma?",
          "translation_vi": "Bài toán này tuần trước thầy vừa giảng hai lần rồi, lẽ nào các em đều quên sạch sành sanh hết rồi sao?",
          "explanation": "\"难道...忘了吗\" thể hiện sự kinh ngạc trước việc học sinh quên bài."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 28,
      "name": "Phó từ tình thái thuận tiện \"顺便\" (Nhân tiện / Tiện thể)",
      "pattern": "顺便 + Động từ (+ Tân ngữ)",
      "category": "Phó từ",
      "explanation_vi": "\"顺便\" (shùnbiàn) làm trạng ngữ đứng trước động từ để biểu thị hành động được thực hiện nhân tiện, tiện thể trong lúc đang làm một việc chính khác mà không tốn thêm nhiều công sức (tiện thể, nhân tiện).",
      "examples": [
        {
          "chinese": "你下楼去超市买水果的时候，顺便帮我取一下放在门卫室的快递包裹吧。",
          "pinyin": "Nǐ xià lóu qù chāoshì mǎi shuǐguǒ de shíhou, shùnbiàn bāng wǒ qǔ yíxià fàng zài ménwèishì de kuàidì bāoguǒ ba.",
          "translation_vi": "Lúc bạn xuống tầng đi siêu thị mua hoa quả, tiện thể giúp tôi lấy gói bưu phẩm chuyển phát nhanh để ở phòng bảo vệ nhé.",
          "explanation": "\"顺便帮我取\" thực hiện việc lấy bưu phẩm nhân tiện chuyến đi siêu thị."
        },
        {
          "chinese": "今天下午去图书馆查阅文献资料，顺便借了两本古典文学名著回来。",
          "pinyin": "Jīntiān xiàwǔ qù túshūguǎn cháyuè wénxiàn zīliào, shùnbiàn jiè le liǎng běn gǔdiǎn wénxué míngzhù huílai.",
          "translation_vi": "Chiều nay đến thư viện tra cứu tài liệu văn kiện, tiện thể tôi đã mượn hai cuốn danh tác văn học cổ điển về.",
          "explanation": "\"顺便借\" mượn sách tiện thể trong lúc đi tra cứu."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 29,
      "name": "Phó từ may mắn thoát nạn \"幸亏 / 幸好\" (May mà / May thay)",
      "pattern": "幸亏 / 幸好 + Tình huống may mắn, 不然 / 要不然 + Hậu quả xấu",
      "category": "Phó từ",
      "explanation_vi": "\"幸亏\" (xìngkuī) hoặc \"幸好\" (xìnghǎo) đứng đầu câu hoặc đầu phân câu để biểu thị nhờ có điều kiện thuận lợi ngẫu nhiên mà tránh được tai họa, rắc rối hoặc hậu quả tồi tệ (may mà, may thay). Thường phối hợp với \"不然 / 要不然\" (nếu không thì).",
      "examples": [
        {
          "chinese": "幸亏出门前母亲提醒我随身带了雨伞，不然刚才就被倾盆暴雨淋湿了。",
          "pinyin": "Xìngkuī chūmén qián mǔqīn tíxǐng wǒ suíshēn dài le yǔsǎn, bùrán gāngcái jiù bèi qīngpén bàoyǔ línshī le.",
          "translation_vi": "May mà trước khi ra khỏi cửa mẹ nhắc tôi mang theo ô bên mình, nếu không thì ban nãy đã bị cơn mưa rào như trút làm ướt sũng rồi.",
          "explanation": "\"幸亏...不然...\" nhấn mạnh sự may mắn nhờ mang ô tránh bị ướt mưa."
        },
        {
          "chinese": "幸好交警及时赶到事故现场疏导车流，拥堵的交通才没有彻底瘫痪。",
          "pinyin": "Xìnghǎo jiāojǐng jíshí gǎndào shìgù xiànchǎng shūdǎo chēliú, yōngdǔ de jiāotōng cái méiyǒu chèdǐ tānhuān.",
          "translation_vi": "May thay cảnh sát giao thông kịp thời tới hiện trường vụ tai nạn phân luồng xe, giao thông ùn tắc mới không bị tê liệt hoàn toàn.",
          "explanation": "\"幸好...才没有\" nhờ cảnh sát tới kịp mà tránh được tê liệt giao thông."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 30,
      "name": "Phó từ ngộ ra chân tướng sự thật \"原来\" (Hóa ra / Thì ra)",
      "pattern": "原来 + Sự thật mới phát hiện / (Vốn dĩ ban đầu)",
      "category": "Phó từ",
      "explanation_vi": "\"原来\" (yuánlái) đứng đầu câu hoặc trước vị ngữ biểu thị sự ngộ ra, vỡ lẽ về một chân tướng sự thật sau khi tìm hiểu (hóa ra, thì ra là thế). Ngoài ra, \"原来\" còn làm danh từ/tính từ chỉ tình trạng vốn có ban đầu.",
      "examples": [
        {
          "chinese": "我说今天早晨外面怎么这么安静，原来昨夜下了一场厚厚的瑞雪。",
          "pinyin": "Wǒ shuō jīntiān zǎochén wàimiàn zěnme zhème ānjìng, yuánlái zuóyè xià le yì chǎng hòuhòu de ruìxuě.",
          "translation_vi": "Tôi cứ bảo sao sáng nay bên ngoài lại yên tĩnh thế này, hóa ra đêm qua trời đã đổ một trận tuyết lành dày xốp.",
          "explanation": "\"原来昨夜下了一场...\" giải thích rõ nguyên nhân bất ngờ vỡ lẽ."
        },
        {
          "chinese": "他原来是一名优秀的中学语文教师，后来通过努力考上了研究生。",
          "pinyin": "Tā yuánlái shì yì míng yōuxiù de zhōngxué yǔwén jiàoshī, hòulái tōngguò nǔlì kǎo shàng le yánjiūshēng.",
          "translation_vi": "Anh ấy ban đầu vốn là một giáo viên ngữ văn cấp hai ưu tú, sau này nhờ nỗ lực đã thi đỗ nghiên cứu sinh.",
          "explanation": "\"原来是\" chỉ thân phận ban đầu trước đây."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 31,
      "name": "Phó từ cường điệu mức độ như thật \"简直\" (Quả là / Thật là)",
      "pattern": "简直 (+ 像 / 是 / 比) + Tính từ / Cụm vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"简直\" (jiǎnzhí) dùng để cường điệu hóa mức độ của sự việc, biểu thị tình huống đạt tới trạng thái gần như không thể tin nổi hoặc hoàn toàn tương đương với một sự việc khác (quả là, thật là, hoàn toàn như).",
      "examples": [
        {
          "chinese": "他在全国青少年魔术大赛上的精彩绝伦表演，简直令人难以置信！",
          "pinyin": "Tā zài quánguó qīng-shàonián móshù dàsài shang de jīngcǎi-juélún biǎoyǎn, jiǎnzhí lìngrén nányǐ-zhìxìn!",
          "translation_vi": "Màn biểu diễn tuyệt luân đặc sắc của anh ấy trong cuộc thi ảo thuật thanh thiếu niên toàn quốc quả là khiến người ta khó lòng tin nổi!",
          "explanation": "\"简直令人难以置信\" cường điệu hóa sự thán phục tột bực."
        },
        {
          "chinese": "清晨漫步在桂林秀丽的漓江两岸，周围美丽的风景简直像一幅生动的山水画。",
          "pinyin": "Qīngchén mànbù zài Guìlín xiùlì de Líjiāng liǎng'àn, zhōuwéi měilì de fēngjǐng jiǎnzhí xiàng yì fú shēngdòng de shānshuǐhuà.",
          "translation_vi": "Sáng sớm tản bộ trên hai bờ sông Ly tươi đẹp ở Quế Lâm, phong cảnh mỹ lệ xung quanh quả thật như một bức tranh sơn thủy sống động.",
          "explanation": "\"简直像\" so sánh cường điệu vẻ đẹp tự nhiên giống như tranh vẽ."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 32,
      "name": "Phó từ duy trì liên tục không ngắt quãng \"一直\" (Suốt / Luôn / Liên tục)",
      "pattern": "一直 + Động từ / Tính từ / Thời gian + 一直 (+ 都)...",
      "category": "Phó từ",
      "explanation_vi": "\"一直\" (yìzhí) biểu thị một hành động hoặc trạng thái duy trì liên tục không gián đoạn từ quá khứ đến hiện tại hoặc trong suốt một khoảng thời gian (suốt, luôn luôn, liên tục). Cũng dùng chỉ phương hướng đi thẳng một mạch (一直走).",
      "examples": [
        {
          "chinese": "从大学一年级开始，他就一直坚持每天清晨早起朗读中外名篇散文。",
          "pinyin": "Cóng dàxué yī niánjí kāishǐ, tā jiù yìzhí jiānchí měitiān qīngchén zǎoqǐ lǎngdú zhōng-wài míngpiān sǎnwén.",
          "translation_vi": "Bắt đầu từ năm thứ nhất đại học, anh ấy đã luôn kiên trì mỗi sáng sớm dậy sớm đọc vang các áng văn tản văn danh tiếng trong và ngoài nước.",
          "explanation": "\"一直坚持\" biểu thị thói quen duy trì liên tục không bỏ ngày nào."
        },
        {
          "chinese": "从这个十字路口一直往东走两百米，就能看到高耸的世纪电视塔。",
          "pinyin": "Cóng zhè gè shízì-lùkǒu yìzhí wǎng dōng zǒu liǎng bǎi mǐ, jiù néng kàn dào gāosǒng de shìjì diànshìtǎ.",
          "translation_vi": "Từ ngã tư này đi thẳng một mạch về phía Đông hai trăm mét là có thể nhìn thấy tháp truyền hình thế kỷ cao vút.",
          "explanation": "\"一直往东走\" chỉ hướng đi thẳng một mạch không rẽ."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 33,
      "name": "Liên từ tăng tiến đồng đẳng \"不仅...而且...\" (Không những... mà còn...)",
      "pattern": "Chủ ngữ + 不仅 + Vị ngữ 1, 而且 + Vị ngữ 2 / 不仅 + Chủ ngữ 1..., 而且 + Chủ ngữ 2...",
      "category": "Liên từ",
      "explanation_vi": "Cặp liên từ \"不仅...而且...\" (bùjǐn... érqiě...) biểu thị mối quan hệ tăng tiến thêm một bậc về phạm vi hoặc mức độ (không những... mà còn...). Nếu cùng chung chủ ngữ thì chủ ngữ đứng trước 不仅; nếu khác chủ ngữ thì 不仅 đứng trước chủ ngữ 1.",
      "examples": [
        {
          "chinese": "这家社区老字号餐馆不仅饭菜可口美味，而且价格十分公道实惠。",
          "pinyin": "Zhè jiā shèqū lǎozìhào cānguǎn bùjǐn fàncài kěkǒu měiwèi, érqiě jiàgé shífēn gōngdao shíhuì.",
          "translation_vi": "Quán ăn lâu năm trong khu dân cư này không những cơm canh thơm ngon vừa miệng, mà giá cả còn rất hợp lý bình dân.",
          "explanation": "\"不仅...而且...\" liên kết hai ưu điểm tăng tiến cùng chủ ngữ quán ăn."
        },
        {
          "chinese": "学习汉语不仅能开阔我们的文化视野，而且能为未来的职业发展提供广阔舞台。",
          "pinyin": "Xuéxí hànyǔ bùjǐn néng kāikuò wǒmen de wénhuà shìyě, érqiě néng wèi wèilái de zhíyè fāzhǎn tígōng guǎngkuò wǔtái.",
          "translation_vi": "Học tiếng Hán không những có thể mở rộng tầm nhìn văn hóa của chúng ta, mà còn có thể mang lại vũ đài rộng lớn cho sự phát triển nghề nghiệp tương lai.",
          "explanation": "Tăng tiến hai tầng lợi ích thiết thực của việc học Hán ngữ."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 34,
      "name": "Liên từ tăng tiến khẩu ngữ \"不但...还 / 也...\" (Không chỉ... mà còn...)",
      "pattern": "不但 + Phân câu 1, 还 / 也 / 并且 + Phân câu 2",
      "category": "Liên từ",
      "explanation_vi": "\"不但...还 / 也...\" (búdàn... hái/yě...) là biến thể khẩu ngữ quen thuộc của \"不仅...而且...\" dùng biểu thị mức độ tăng tiến bổ sung (không chỉ... mà còn...). Phân câu sau bổ sung thêm một hành động hoặc đặc điểm vượt trội hơn.",
      "examples": [
        {
          "chinese": "他不但能熟练使用普通话日常交流，还会唱很多首经典的民间民歌。",
          "pinyin": "Tā búdàn néng shúliàn shǐyòng pǔtōnghuà rìcháng jiāoliú, hái huì chàng hěn duō shǒu jīngdiǎn de mínjiān míngē.",
          "translation_vi": "Anh ấy không chỉ có thể giao tiếp hằng ngày thuần thục bằng tiếng phổ thông, mà còn biết hát rất nhiều bài dân ca dân gian kinh điển.",
          "explanation": "\"不但...还会\" bổ sung khả năng hát dân ca bên cạnh kỹ năng nói tiếng Trung."
        },
        {
          "chinese": "这次大扫除不仅把教室打扫得干干净净，还把走廊两侧的玻璃擦得透亮。",
          "pinyin": "Zhè cì dàsǎochú bùjǐn bǎ jiàoshì dǎsǎo de gāngān-jìngjìng, hái bǎ zǒuláng liǎngcè de bōli cā de tòuliàng.",
          "translation_vi": "Đợt tổng vệ sinh này không chỉ quét dọn lớp học sạch bóng tinh tươm, mà còn lau kính hai bên hành lang sáng loáng.",
          "explanation": "\"不但...还...\" mở rộng phạm vi công việc đã hoàn thành."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 35,
      "name": "Liên từ điều kiện duy nhất \"只有...才...\" (Chỉ có... mới...)",
      "pattern": "只有 + Điều kiện duy nhất bắt buộc, 才 + Kết quả đạt được",
      "category": "Liên từ",
      "explanation_vi": "Cặp liên từ \"只有...才...\" (zhǐyǒu... cái...) biểu thị điều kiện duy nhất và bắt buộc: chỉ có đáp ứng duy nhất điều kiện này thì kết quả mong đợi mới có thể xuất hiện (chỉ có... mới có thể...). Khác với \"只要...就...\" (điều kiện cần - chỉ cần là được).",
      "examples": [
        {
          "chinese": "只有持之以恒地脚踏实地努力拼搏，才能在学术研究领域取得突破成就。",
          "pinyin": "Zhǐyǒu chízhi-yǐhéng de jiǎotà-shídì nǔlì pīnbó, cáinéng zài xuéshù yánjiū lǐngyù qùdé tūpò chéngjiù.",
          "translation_vi": "Chỉ có kiên trì không ngơi nghỉ vững vàng nỗ lực phấn đấu thì mới có thể gặt hái thành tựu đột phá trong lĩnh vực nghiên cứu học thuật.",
          "explanation": "\"只有...才能...\" nhấn mạnh sự kiên trì là con đường duy nhất dẫn tới đột phá."
        },
        {
          "chinese": "只有经过严格的专业体检与理论考核，合格者才能获得民航飞行员执照。",
          "pinyin": "Zhǐyǒu jīngguò yángé de zhuānyè tǐjiǎn yǔ lǐlùn kǎohé, hégézhě cáinéng huòdé mínháng fēixíngyuán zhízhào.",
          "translation_vi": "Chỉ có trải qua khám sức khỏe chuyên môn và khảo hạch lý thuyết nghiêm ngặt, người đạt chuẩn mới có thể nhận bằng phi công hàng không dân dụng.",
          "explanation": "Nêu điều kiện tiên quyết duy nhất để được cấp bằng bay."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 36,
      "name": "Liên từ giả thiết suy luận \"既然...就...\" (Đã... thì...)",
      "pattern": "既然 + Tiền đề / Sự thật đã xảy ra, (那么) 就 + Kết luận / Lời khuyên",
      "category": "Liên từ",
      "explanation_vi": "Cặp liên từ \"既然...就...\" (jìrán... jiù...) dùng để đưa ra kết luận hoặc kiến nghị hợp logic dựa trên một sự thật hiển nhiên hoặc một tiền đề đã định đoạt từ trước (đã như vậy rồi... thì hãy...).",
      "examples": [
        {
          "chinese": "既然大家都已经一致同意了这个合作方案，那么我们就立刻着手组织实施吧。",
          "pinyin": "Jìrán dàjiā dōu yǐjīng yízhì tóngyì le zhè gè hézuò fāng'àn, nàme wǒmen jiù lìkè zhuóshǒu zǔzhī shíshī ba.",
          "translation_vi": "Đã mọi người đều đã nhất trí thông qua phương án hợp tác này rồi, thế thì chúng ta hãy lập tức bắt tay vào tổ chức triển khai thôi.",
          "explanation": "\"既然...就...\" đưa ra hành động triển khai dựa trên sự đồng thuận đã có."
        },
        {
          "chinese": "既然你今天身体有些发烧不适，就留在宿舍好好卧床休息，不要去自习了。",
          "pinyin": "Jìrán nǐ jīntiān shēntǐ yǒuxiē fāshāo bùshì, jiù liú zài sùshè hǎohǎo wòchuáng xiūxi, bú yào qù zìxí le.",
          "translation_vi": "Đã hôm nay người bạn hơi phát sốt khó chịu rồi thì hãy ở lại ký túc xá tĩnh dưỡng nghỉ ngơi trên giường, đừng đi tự học nữa.",
          "explanation": "Đưa ra lời khuyên nghỉ ngơi dựa trên tình hình sức khỏe thực tế."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 37,
      "name": "Liên từ nhượng bộ giả thiết \"即使...也...\" (Cho dù... cũng...)",
      "pattern": "即使 + Giả thiết cực đoan / Khó khăn, 主语 + 也 + Kết quả không đổi",
      "category": "Liên từ",
      "explanation_vi": "Cặp liên từ \"即使...也...\" (jíshǐ... yě...) biểu thị mối quan hệ nhượng bộ giả thiết: thừa nhận một tình huống giả định khó khăn hoặc cực đoan nhất, nhưng kết quả hoặc thái độ ở phân câu sau vẫn kiên định không hề lay chuyển (cho dù... cũng vẫn...).",
      "examples": [
        {
          "chinese": "即使在前进的道路上遇到再大的风雨坎坷，我们也不会轻易放弃最初的理想。",
          "pinyin": "Jíshǐ zài qiánjìn de dàolù shang yù dào zài dà de fēngyǔ kǎnkě, wǒmen yě bú huì qīngyì fàngqì zuìchū de lǐxiǎng.",
          "translation_vi": "Cho dù trên con đường phía trước gặp phải mưa gió gập ghềnh to lớn đến mấy, chúng tôi cũng sẽ không dễ dàng từ bỏ lý tưởng ban đầu.",
          "explanation": "\"即使...也...\" nhấn mạnh sự kiên định lý tưởng trước mọi thử thách khắc nghiệt."
        },
        {
          "chinese": "明天即使户外下暴雪气温降到零下十度，长跑队员们也会按时参加常规体能集训。",
          "pinyin": "Míngtiān jíshǐ hùwài xià bàoxuě qìwēn jiàng dào língxià shí dù, chángpǎo duìyuán men yě huì ànshí cānjiā chángguī tǐnéng jíxùn.",
          "translation_vi": "Ngày mai cho dù ngoài trời đổ bão tuyết nhiệt độ hạ xuống âm mười độ, các vận động viên chạy dài cũng sẽ tham gia tập huấn thể lực định kỳ đúng giờ.",
          "explanation": "Khẳng định ý chí tập luyện bất chấp thời tiết bão tuyết giả định."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 38,
      "name": "Liên từ song song hai mặt \"一方面...另一方面...\" (Một mặt... mặt khác...)",
      "pattern": "一方面 + Khía cạnh 1, 另一方面 + Khía cạnh 2",
      "category": "Liên từ",
      "explanation_vi": "Cấu trúc \"一方面...另一方面...\" (yì fāngmiàn... lìng yì fāngmiàn...) dùng để trình bày, phân tích hai mặt hoặc hai khía cạnh tương đương cùng tồn tại song song trong một vấn đề (một mặt... mặt khác...). Giúp lập luận cân đối và toàn diện.",
      "examples": [
        {
          "chinese": "发展数字经济一方面能大幅提高生产效率，另一方面也能催生出海量全新的高薪就业岗位。",
          "pinyin": "Fāzhǎn shùzì jīngjì yì fāngmiàn néng dàfú tígāo shēngchǎn xiàolǜ, lìng yì fāngmiàn yě néng cuīshēng chū hǎiliàng quánxīn de gāoxīn jiùyè gǎngwèi.",
          "translation_vi": "Phát triển kinh tế số một mặt có thể nâng cao vượt bậc hiệu suất sản xuất, mặt khác cũng có thể sản sinh ra khối lượng lớn các vị trí việc làm lương cao mới toanh.",
          "explanation": "\"一方面...另一方面...\" phân tích hai lợi ích song hành của kinh tế số."
        },
        {
          "chinese": "大学生活一方面要认真钻研专业理论知识，另一方面也要积极参与社会公益实践活动。",
          "pinyin": "Dàxué shēnghuó yì fāngmiàn yào rènzhēn zuānyán zhuānyè lǐlùn zhīshi, lìng yì fāngmiàn yě yào jījí cānyù shèhuì gōngyì shíjiàn huódòng.",
          "translation_vi": "Đời sống đại học một mặt phải chăm chỉ đào sâu tri thức lý luận chuyên ngành, mặt khác cũng cần tích cực tham gia các hoạt động thực hành công ích xã hội.",
          "explanation": "Cân bằng giữa việc học lý thuyết và hoạt động thực tế."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 39,
      "name": "Liên từ chuyển tiếp cực đoan \"甚至\" (Thậm chí / Ngay cả)",
      "pattern": "A, B, 甚至 (连) + C + 都 / 也 + Vị ngữ",
      "category": "Liên từ",
      "explanation_vi": "\"甚至\" (shènzhì) dùng để đưa ra một ví dụ nổi bật, bất ngờ hoặc có tính chất cực đoan nhất nhằm nhấn mạnh mức độ sâu sắc vượt xa dự liệu thông thường (thậm chí, ngay cả... cũng).",
      "examples": [
        {
          "chinese": "这道物理科研难题极其复杂，很多资深教授甚至世界级科学家都感到十分棘手。",
          "pinyin": "Zhè dào wùlǐ kēyán nántí jíqí fùzá, hěn duō zīshēn jiàoshòu shènzhì shìjièjí kēxuéjiā dōu gǎndào shífēn jíshǒu.",
          "translation_vi": "Bài toán nghiên cứu vật lý này phức tạp tột cùng, rất nhiều giáo sư kỳ cựu thậm chí cả các nhà khoa học đẳng cấp thế giới cũng đều cảm thấy vô cùng hóc búa.",
          "explanation": "\"甚至世界级科学家\" đưa ra đối tượng đỉnh cao để làm nổi bật độ khó."
        },
        {
          "chinese": "他沉迷于实验室的核心技术攻坚，连续几个月甚至连周末都泡在仪器前。",
          "pinyin": "Tā chénmí yú shíyànshì de héxīn jìshù gōngjiān, liánxù jǐ gè yuè shènzhì lián zhōumò dōu pào zài yíqì qián.",
          "translation_vi": "Anh ấy say mê công phá công nghệ cốt lõi trong phòng thí nghiệm, liên tục mấy tháng trời thậm chí ngay cả cuối tuần cũng cắm mặt bên thiết bị.",
          "explanation": "\"甚至连周末都\" nhấn mạnh tinh thần nghiên cứu quên cả ngày nghỉ."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 40,
      "name": "Liên từ chuyển tiếp bổ sung \"另外\" (Ngoài ra / Hơn nữa)",
      "pattern": "Phân câu 1. 另外, + Phân câu 2 / 另外 (+ 的) + Danh từ",
      "category": "Liên từ",
      "explanation_vi": "\"另外\" (lìngwài) dùng làm liên từ đứng đầu câu hoặc phân câu để bổ sung thêm một ý, một thông tin hoặc một công việc khác bên cạnh điều đã nêu (ngoài ra, hơn nữa). Cũng làm đại từ/định ngữ (cái khác, người khác: 另外两个人).",
      "examples": [
        {
          "chinese": "会议期间请大家务必保持手机静音，另外，会场内严禁随意吸烟与喧哗。",
          "pinyin": "Huìyì qījiān qǐng dàjiā wùbì bǎochí shǒujī jìngyīn, lìngwài, huìchǎng nèi yánjìn suíyì xīyān yǔ xuānhuá.",
          "translation_vi": "Trong thời gian hội nghị xin mọi người nhất định giữ điện thoại ở chế độ im lặng, ngoài ra, trong hội trường nghiêm cấm tùy tiện hút thuốc và làm ồn.",
          "explanation": "\"另外\" bổ sung thêm quy định cấm hút thuốc."
        },
        {
          "chinese": "今天上午我已经面试了五位求职者，另外三位候选人安排在今天下午两点。",
          "pinyin": "Jīntiān shàngwǔ wǒ yǐjīng miànshì le wǔ wèi qiúzhízhě, lìngwài sān wèi hòuxuǎnrén ānpái zài jīntiān xiàwǔ liǎng diǎn.",
          "translation_vi": "Sáng nay tôi đã phỏng vấn năm ứng viên xin việc, ba ứng viên còn lại được sắp xếp vào lúc hai giờ chiều nay.",
          "explanation": "\"另外三位\" làm định ngữ chỉ 3 người ứng viên còn lại."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 41,
      "name": "Liên từ điều kiện không giới hạn \"无论 / 不管...都 / 也...\"",
      "pattern": "无论 / 不管 + Từ để hỏi / A hay B, Chủ ngữ + 都 / 也 + Vị ngữ",
      "category": "Liên từ",
      "explanation_vi": "\"无论\" (wúlùn) hoặc \"不管\" (bùguǎn) biểu thị trong bất kỳ điều kiện, hoàn cảnh hoặc trường hợp nào thì kết quả, hành động ở vế sau vẫn diễn ra như cũ không hề thay đổi (cho dù, bất kể... đều). Phân câu trước bắt buộc phải có từ nghi vấn hoặc phương án lựa chọn (A hay B, làm gì, ở đâu).",
      "examples": [
        {
          "chinese": "无论前方的道路有多么坎坷艰险，我们都会坚定不移地朝着心中的目标勇毅前行。",
          "pinyin": "Wúlùn qiánfāng de dàolù yǒu duōme kǎnkě jiānxiǎn, wǒmen dōu huì jiāndìng-bùyí de cháozhe xīnzhōng de mùbiāo yǒngyì qiánxíng.",
          "translation_vi": "Bất kể con đường phía trước có gập ghềnh hiểm trở đến nhường nào, chúng tôi đều sẽ kiên định không dời dũng cảm tiến về mục tiêu trong lòng.",
          "explanation": "\"无论...有多么...都...\" khẳng định quyết tâm trước mọi gian nan."
        },
        {
          "chinese": "不管明天天气晴天还是刮风下雨，全校的春季运动会都会如期隆重举行。",
          "pinyin": "Bùguǎn míngtiān tiānqì qíngtiān háishì guāfēng xiàyǔ, quán xiào de chūnjì yùndònghuì dōu huì rúqī lóngzhòng jǔxíng.",
          "translation_vi": "Cho dù ngày mai thời tiết trời nắng hay nổi gió đổ mưa, đại hội thể thao mùa xuân toàn trường đều sẽ diễn ra đúng hẹn và long trọng.",
          "explanation": "\"不管...还是...都\" loại bỏ ảnh hưởng của thời tiết đối với kế hoạch."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 42,
      "name": "Giới từ giới thiệu chủ đề phạm vi \"关于\" (Về / Về vấn đề)",
      "pattern": "关于 + Đối tượng / Vấn đề, Chủ ngữ + Vị ngữ / 关于...的 + Danh từ",
      "category": "Giới từ",
      "explanation_vi": "\"关于\" (guānyú) đứng trước danh từ để giới thiệu phạm vi, chủ đề hoặc nội dung liên quan của sự việc (về, về vấn đề). Thường đứng đầu câu làm trạng ngữ hoặc kết hợp \"的\" làm định ngữ (sách về...: 关于...的书).",
      "examples": [
        {
          "chinese": "关于如何有效提高留学生汉语口语交际能力的问题，两位专家展开了深入探讨。",
          "pinyin": "Guānyú rúhé yǒuxiào tígāo liúxuéshēng hànyǔ kǒuyǔ jiāojì nénglì de wèntí, liǎng wèi zhuānjiā zhǎnkāi le shēnrù tàntǎo.",
          "translation_vi": "Về vấn đề làm thế nào để nâng cao hữu hiệu năng lực giao tiếp khẩu ngữ tiếng Hán của lưu học sinh, hai vị chuyên gia đã mở ra cuộc thảo luận sâu sắc.",
          "explanation": "\"关于...的问题\" giới thiệu chủ đề trung tâm của cuộc trao đổi."
        },
        {
          "chinese": "他在省立图书馆查阅了海量关于中国古代青铜器铸造工艺的历史文献。",
          "pinyin": "Tā zài shěnglì túshūguǎn cháyuè le hǎiliàng guānyú zhōngguó gǔdài qīngtóngqì zhùzào gōngyì de lìshǐ wénxiàn.",
          "translation_vi": "Anh ấy ở thư viện cấp tỉnh đã tra cứu khối lượng lớn tài liệu lịch sử về kỹ nghệ đúc đồ đồng cổ đại Trung Quốc.",
          "explanation": "\"关于...的历史文献\" làm cụm giới từ làm định ngữ bổ nghĩa cho tài liệu."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 43,
      "name": "Giới từ chỉ đối tượng thụ cảm \"对于\" (Đối với / Về mặt)",
      "pattern": "对于 + Đối tượng, Chủ ngữ + Vị ngữ / Chủ ngữ + 对于 + Đối tượng + Vị ngữ",
      "category": "Giới từ",
      "explanation_vi": "\"对于\" (duìyú) dùng để đưa ra đối tượng mà ý kiến, thái độ, sự phán đoán nhắm vào (đối với, đối cùng). Khác với \"对\", \"对于\" chỉ dùng cho quan điểm, thái độ, không dùng cho hành vi tác động cụ thể giữa người với người (không nói 对于他笑).",
      "examples": [
        {
          "chinese": "对于这个涉及旧城改造与古建筑保护的城市规划草案，市民们提出了很多宝贵建议。",
          "pinyin": "Duìyú zhè gè shèjí jiùchéng gǎizào yǔ gǔ jiànzhù bǎohù de chéngshì guīhuà cǎo'àn, shìmín men tíchū le hěn duō bǎoguì jiànyì.",
          "translation_vi": "Đối với dự thảo quy hoạch đô thị liên quan đến cải tạo phố cũ và bảo tồn kiến trúc cổ này, người dân đã đề xuất rất nhiều kiến nghị quý báu.",
          "explanation": "\"对于...规划草案\" xác định đối tượng tiếp nhận ý kiến đóng góp."
        },
        {
          "chinese": "养成良好的每日阅读习惯，对于青少年综合素质的全面提升具有长远意义。",
          "pinyin": "Yǎngchéng liánghǎo de měirì yuèdú xíguàn, duìyú qīng-shàonián zōnghé sùzhì de quánmiàn tíshēng jùyǒu chángyuǎn yìyì.",
          "translation_vi": "Hình thành thói quen đọc sách hằng ngày tốt đẹp, đối với việc nâng cao toàn diện tố chất tổng hợp của thanh thiếu niên có ý nghĩa lâu dài.",
          "explanation": "\"对于...全面提升\" chỉ phương diện thụ hưởng lợi ích lâu dài."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 44,
      "name": "Giới từ căn cứ quy chuẩn \"按照\" (Theo / Căn cứ vào)",
      "pattern": "按照 + Tiêu chuẩn / Quy định / Yêu cầu + Động từ (+ Tân ngữ)",
      "category": "Giới từ",
      "explanation_vi": "\"按照\" (ànzhào) biểu thị hành động được thực hiện dựa theo một tiêu chuẩn, quy chuẩn, quy định, kế hoạch hoặc yêu cầu đã được đề ra từ trước (theo, căn cứ theo, chiểu theo).",
      "examples": [
        {
          "chinese": "工程质检人员严格按照国家建筑安全工程标准，对大楼主体结构进行了全面检测。",
          "pinyin": "Gōngchéng zhìjiǎn rényuán yángé ànzhào guójiā jiànzhù ānquán gōngchéng biāozhǔn, duì dàlóu zhǔtǐ jiégòu jìnxíng le quánmiàn jiǎncè.",
          "translation_vi": "Các nhân viên kiểm định chất lượng công trình nghiêm ngặt căn cứ theo tiêu chuẩn công trình an toàn xây dựng quốc gia để tiến hành kiểm định toàn diện kết cấu thân tòa nhà.",
          "explanation": "\"按照...标准\" chỉ chuẩn mực căn cứ để kiểm tra chất lượng."
        },
        {
          "chinese": "请所有参会代表按照会务组统一安排的日程表，准时入场参加学术讨论。",
          "pinyin": "Qǐng suǒyǒu cānhuì dàibiǎo ànzhào huìwùzǔ tǒngyī ānpái de rìchéngbiǎo, zhǔnshí rùchǎng cānjiā xuéshù tǎolùn.",
          "translation_vi": "Xin mời toàn thể đại biểu tham dự hội nghị theo đúng lịch trình do ban tổ chức sắp xếp thống nhất, vào hội trường đúng giờ tham gia thảo luận học thuật.",
          "explanation": "\"按照...日程表\" hành động tuân thủ theo lịch trình có sẵn."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 45,
      "name": "Giới từ căn cứ chứng cứ \"根据\" (Căn cứ theo / Dựa vào)",
      "pattern": "根据 + Căn cứ / Bằng chứng / Thực tế + Phán đoán / Hành động",
      "category": "Giới từ",
      "explanation_vi": "\"根据\" (gēnjù) dùng để đưa ra cơ sở, bằng chứng, dữ liệu hoặc căn cứ thực tế làm điểm tựa để đưa ra kết luận, phán đoán hoặc quyết định (căn cứ vào, dựa trên cơ sở). Ngoài ra còn làm danh từ (chứng cứ, cơ sở).",
      "examples": [
        {
          "chinese": "气象部门根据最新卫星云图的监测数据，及时发布了沿海强台风黄色预警。",
          "pinyin": "Qìxiàng bùmén gēnjù zuìxīn wèixīng yúntú de jiāncè shùjù, jíshí fābù le yánhǎi qiáng táifēng huángsè yùjǐng.",
          "translation_vi": "Cơ quan khí tượng căn cứ vào số liệu giám sát của ảnh mây vệ tinh mới nhất đã kịp thời phát cảnh báo màu vàng về bão mạnh ven biển.",
          "explanation": "\"根据...数据\" đưa ra căn cứ dữ liệu vệ tinh để phát cảnh báo."
        },
        {
          "chinese": "这本轰动文坛的侦探悬疑长篇小说，是作家根据几起真实历史案件创作而成的。",
          "pinyin": "Zhè běn hōngdòng wéntán de zhēntàn xuányí chángpiān xiǎoshuō, shì zuòjiā gēnjù jǐ qǐ zhēnshí lìshǐ ànjiàn chuàngzuò ér chéng de.",
          "translation_vi": "Cuốn tiểu thuyết trường thiên trinh thám ly kỳ làm chấn động văn đàn này là do nhà văn dựa trên một vài vụ án lịch sử có thật sáng tác nên.",
          "explanation": "\"根据...案件\" chỉ tư liệu thực tế làm điểm tựa sáng tác."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 46,
      "name": "Giới từ biến đổi đồng thời \"随着\" (Cùng với / Theo đà)",
      "pattern": "随着 + Danh từ / Sự phát triển / Biến đổi, Chủ ngữ + Vị ngữ biến đổi tương ứng",
      "category": "Giới từ",
      "explanation_vi": "\"随着\" (suízhe) dùng để chỉ một sự việc, hiện tượng phát sinh hoặc biến đổi đồng thời theo sau sự chuyển biến của một sự vật, điều kiện khác (cùng với sự phát triển của..., theo đà...). Thường đứng ở đầu câu.",
      "examples": [
        {
          "chinese": "随着现代数字科技的高速发展，移动支付与无接触购物已经深度融入了千家万户。",
          "pinyin": "Suízhe xiàndài shùzì kējì de gāosù fāzhǎn, yídòng zhīfù yǔ wú jiēchù gòuwù yǐjīng shēndù róngrù le qiānjiā-wànhù.",
          "translation_vi": "Cùng với sự phát triển thần tốc của công nghệ số hiện đại, thanh toán di động và mua sắm không tiếp xúc đã hòa nhập sâu sắc vào muôn nhà vạn hộ.",
          "explanation": "\"随着...高速发展\" đưa ra tiền đề công nghệ làm thay đổi đời sống tiêu dùng."
        },
        {
          "chinese": "随着深秋季节气温的持续下降，公园湖畔的大片水杉树叶变得一片金黄灿烂。",
          "pinyin": "Suízhe shēnqiū jìjié qìwēn de chíxù xiàjiàng, gōngyuán húpàn de dàpiàn shuǐshān shùyè biàn de yí piàn jīnhuáng cànlàn.",
          "translation_vi": "Cùng với sự giảm liên tục của nhiệt độ mùa thu muộn, rặng lá cây thủy sam bên bờ hồ công viên đã ngả sang một màu vàng óng rực rỡ.",
          "explanation": "\"随着...持续下降\" sự biến đổi màu lá đồng hành với sự hạ nhiệt thời tiết."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 47,
      "name": "Giới từ trải qua quá trình nỗ lực \"经过\" (Trải qua / Qua)",
      "pattern": "经过 + Quá trình / Nỗ lực / Thời gian, Chủ ngữ + Đạt được kết quả",
      "category": "Giới từ",
      "explanation_vi": "\"经过\" (jīngguò) biểu thị một quá trình rèn luyện, tìm tòi, phấn đấu hoặc diễn biến thời gian đã trải qua để dẫn tới một kết quả cụ thể (trải qua, qua một quá trình...). Ngoài ra còn làm động từ chỉ việc đi ngang qua một địa điểm.",
      "examples": [
        {
          "chinese": "经过科研团队历时三年的联合技术攻坚，该新型环保节能材料终于研发成功了。",
          "pinyin": "Jīngguò kēyán tuánduì lìshí sān nián de liánhé jìshù gōngjiān, gāi xīnxíng huánbǎo jiénéng cáiliào zhōngyú yánfā chénggōng le.",
          "translation_vi": "Trải qua ba năm công phá kỹ thuật liên hợp của đội ngũ nghiên cứu, vật liệu tiết kiệm năng lượng bảo vệ môi trường kiểu mới này cuối cùng đã phát triển thành công.",
          "explanation": "\"经过...技术攻坚\" nhấn mạnh quá trình gian khổ dẫn đến thành quả."
        },
        {
          "chinese": "每天早晨乘坐这趟城际班车，都会经过那座横跨大江的宏伟跨海大桥。",
          "pinyin": "Měitiān zǎochén chéngzuò zhè tàng chéngjì bānchē, dōu huì jīngguò nà zuò héngkuà dàjiāng de hóngwěi kuàhǎi dàqiáo.",
          "translation_vi": "Mỗi sáng sớm đi chuyến xe buýt liên tỉnh này đều sẽ đi ngang qua cây cầu vượt biển hùng vĩ bắc ngang sông lớn kia.",
          "explanation": "\"经过...跨海大桥\" làm động từ chỉ việc đi ngang qua địa danh."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 48,
      "name": "Giới từ phương thức công cụ \"通过\" (Thông qua / Bằng cách)",
      "pattern": "通过 + Phương thức / Kênh trung gian / Biện pháp, Chủ ngữ + Đạt mục đích",
      "category": "Giới từ",
      "explanation_vi": "\"通过\" (tōngguò) giới thiệu phương thức, thủ đoạn, phương tiện hoặc khâu trung gian để đạt được mục đích đề ra (thông qua, nhờ có, bằng cách). Ngoài ra còn làm động từ chỉ việc thi đỗ hoặc được thông qua dự thảo (như 通过考试).",
      "examples": [
        {
          "chinese": "通过阅读经典文学名著和观看中文纪录片，他的汉语听说水平有了显著飞跃。",
          "pinyin": "Tōngguò yuèdú jīngdiǎn wénxué míngzhù hé guānkàn zhōngwén jìlùpiàn, tā de hànyǔ tīng-shuō shuǐpíng yǒu le xiǎnzhù fēiyuè.",
          "translation_vi": "Thông qua việc đọc danh tác văn học kinh điển và xem phim tài liệu tiếng Trung, trình độ nghe nói tiếng Hán của anh ấy đã có bước nhảy vọt rõ rệt.",
          "explanation": "\"通过阅读...和观看...\" nêu phương thức rèn luyện dẫn tới bước tiến bộ."
        },
        {
          "chinese": "经过全校代表大会的热烈讨论，这项关于学生公寓管理的新规章获得了全票通过。",
          "pinyin": "Jīngguò quán xiào dàibiǎo dàhuì de rèliè tǎolùn, zhè xiàng guānyú xuésheng gōngyù guǎnlǐ de xīn guīzhāng huòdé le quánpiào tōngguò.",
          "translation_vi": "Trải qua cuộc thảo luận sôi nổi của đại hội đại biểu toàn trường, quy định mới về quản lý ký túc xá sinh viên này đã được toàn phiếu thông qua.",
          "explanation": "\"全票通过\" làm động từ chỉ văn bản được phê chuẩn chính thức."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 49,
      "name": "Bổ ngữ kết quả ly khai / dịch chuyển \"走\" (Đi / Rời đi)",
      "pattern": "Động từ (拿 / 带 / 搬 / 借) + 走 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"走\" (zǒu) làm bổ ngữ kết quả đứng sau động từ chỉ sự rời khỏi vị trí ban đầu của đồ vật hoặc con người do hành động gây ra (mang đi, lấy đi, chuyển đi, bay đi: 拿走, 带走, 搬走, 飞走).",
      "examples": [
        {
          "chinese": "他离开办公室去外地出差之前，顺手把桌上所有的重要公文都带走了。",
          "pinyin": "Tā líkāi bàngōngshì qù wàidì chūchāi zhīqián, shùnshǒu bǎ zhuō shang suǒyǒu de zhòngyào gōngwén dōu dài zǒu le.",
          "translation_vi": "Trước khi rời văn phòng đi công tác ngoại tỉnh, anh ấy tiện tay đã mang đi tất cả công văn quan trọng trên bàn.",
          "explanation": "\"带走了\" biểu thị tài liệu đã theo người di chuyển rời khỏi phòng."
        },
        {
          "chinese": "一阵猛烈的秋风刮过树梢，瞬间把树枝上的枯黄落叶全都吹走了。",
          "pinyin": "Yí zhèn měngliè de qiūfēng guā guò shùshāo, shùnjiān bǎ shùzhī shang de kūhuáng luòyè quándōu chuī zǒu le.",
          "translation_vi": "Một cơn gió thu dữ dội thổi qua ngọn cây, trong nháy mắt đã thổi bay hết sạch lá vàng khô rụng trên cành cây.",
          "explanation": "\"吹走了\" làm bổ ngữ miêu tả lá cây bị gió cuốn đi xa."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 50,
      "name": "Bổ ngữ kết quả tiêu biến / loại trừ \"掉\" (Mất / Hết / Vứt bỏ)",
      "pattern": "Động từ (丢 / 扔 / 忘 / 擦 / 卖) + 掉 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"掉\" (diào) làm bổ ngữ kết quả biểu thị sự biến mất, mất mát, tiêu biến hoặc loại bỏ hoàn toàn một đối tượng hay đặc tính nào đó (rơi mất: 丢掉, vứt đi: 扔掉, quên sạch: 忘掉, lau sạch: 擦掉).",
      "examples": [
        {
          "chinese": "清洁工阿姨用干净的毛巾，把黑板上的所有粉笔字迹彻底擦掉了。",
          "pinyin": "Qīngjiégōng āyí yòng gānjìng de máojīn, bǎ hēibǎn shang de suǒyǒu fěnbǐ zìjì chèdǐ cā diào le.",
          "translation_vi": "Bác lao công dùng chiếc khăn bông sạch sẽ lau sạch hoàn toàn mọi vết phấn trên bảng đen.",
          "explanation": "\"擦掉了\" biểu thị vết phấn trên bảng bị xóa sạch không còn."
        },
        {
          "chinese": "面对生活中的挫折与烦恼，我们要学会调整心态，尽快把不愉快的情绪忘掉。",
          "pinyin": "Miànduì shēnghuó zhōng de cuòzhé yǔ fánnǎo, wǒmen yào xuéhuì tiáozhěng xīntài, jǐnkuài bǎ bù yúkuài de qíngxù wàng diào.",
          "translation_vi": "Đối mặt với trắc trở và phiền muộn trong đời, chúng ta cần học cách điều chỉnh tâm thái, mau chóng quên hết những cảm xúc không vui đi.",
          "explanation": "\"忘掉\" làm bổ ngữ kết quả cho việc loại bỏ nỗi buồn khỏi tâm trí."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 51,
      "name": "Bổ ngữ kết quả cố định vững chắc \"住\" (Chặt / Chắc / Dừng lại)",
      "pattern": "Động từ (站 / 记 / 拿 / 停 / 抓) + 住 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"住\" (zhù) làm bổ ngữ kết quả biểu thị hành động đã làm cho người hoặc vật trở nên cố định, dừng lại, bám chắc hoặc khắc sâu vào trí nhớ (đứng vững: 站住, nhớ kỹ: 记住, cầm chắc: 拿住, dừng lại: 停住).",
      "examples": [
        {
          "chinese": "老师反复认真强调的核心语法知识点，同学们必须牢牢记住并熟练运用。",
          "pinyin": "Lǎoshī fǎnfù rènzhēn qiángdiào de héxīn yǔfǎ zhīshidiǎn, tóngxué men bìxū láoláo jì zhù bìng shúliàn yùnyòng.",
          "translation_vi": "Các điểm kiến thức ngữ pháp cốt lõi mà thầy giáo nghiêm túc nhấn mạnh nhiều lần, các bạn học sinh bắt buộc phải ghi nhớ thật chắc và vận dụng thuần thục.",
          "explanation": "\"记住\" biểu thị kiến thức được ghi khắc vững chắc trong đầu."
        },
        {
          "chinese": "暴风雨中巡逻的边防战士们手挽着手，在泥泞陡峭的山坡上稳稳站住了脚跟。",
          "pinyin": "Bàofēngyǔ zhōng xúnluó de biānfáng zhànshì men shǒu wǎn zhe shǒu, zài nínìng dǒuqiào de shānpō shang wěnwěn zhàn zhù le jiǎogēn.",
          "translation_vi": "Các chiến sĩ biên phòng tuần tra trong giông bão khoác tay nhau, đứng vững chắc gót chân trên sườn dốc trơn trượt hiểm trở.",
          "explanation": "\"站住了\" biểu thị việc giữ vững tư thế không để bị trượt ngã."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 52,
      "name": "Bổ ngữ kết quả tách rời / khuếch tán \"开\" (Mở ra / Tách ra)",
      "pattern": "Động từ (打 / 翻 / 分 / 走 / 离开) + 开 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"开\" (kāi) làm bổ ngữ kết quả biểu thị hành động làm cho hai hoặc nhiều sự vật tách rời nhau ra, mở rộng không gian hoặc tản rộng ra các phía (mở ra: 打开, giở sách: 翻开, tách ra: 分开, tránh ra: 避开).",
      "examples": [
        {
          "chinese": "上课铃声响起，同学们迅速翻开崭新的汉语课本开始大声朗读课文。",
          "pinyin": "Shàngkè língshēng xiǎng qǐ, tóngxué men xùnsù fān kāi zhǎnxīn de hànyǔ kèběn kāishǐ dàshēng lǎngdú kèwén.",
          "translation_vi": "Tiếng chuông vào lớp vang lên, các bạn học sinh nhanh chóng giở trang sách giáo khoa tiếng Hán mới tinh bắt đầu đọc to bài khóa.",
          "explanation": "\"翻开\" biểu thị các trang sách mở tách rời ra."
        },
        {
          "chinese": "为了避免引起不必要的误解与冲突，讨论时双方应当把不同意见摊开来说清楚。",
          "pinyin": "Wèile bìmiǎn yǐnqǐ bú bìyào de wùjiě yǔ chōngtū, tǎolùn shí shuāngfāng yīngdāng bǎ bùtóng yìjiàn tān kāi lái shuō qīngchu.",
          "translation_vi": "Để tránh gây ra hiểu lầm và xung đột không cần thiết, khi thảo luận hai bên nên trải rộng các ý kiến bất đồng ra để nói cho rõ ràng.",
          "explanation": "\"摊开\" miêu tả việc mở rộng công khai các vấn đề."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 53,
      "name": "Bổ ngữ kết quả bám dính / khép lại \"上\" (Đóng / Mặc / Đạt)",
      "pattern": "Động từ (穿 / 关 / 闭 / 爱 / 考) + 上 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"上\" (shàng) làm bổ ngữ kết quả biểu thị hai vật tiếp xúc khép kín lại (như 闭上: nhắm mắt, 关上: đóng cửa, 穿上: mặc áo vào), hoặc bắt đầu nảy sinh tình cảm, đạt được mục tiêu mong ước (như 考上: thi đỗ, 爱上: đem lòng yêu).",
      "examples": [
        {
          "chinese": "离开办公室前，请最后一位同事务必锁好抽屉并关上所有门窗。",
          "pinyin": "Líkāi bàngōngshì qián, qǐng zuìhòu yí wèi tóngshì wùbì suǒ hǎo chōuti bìng guān shàng suǒyǒu ménchuāng.",
          "translation_vi": "Trước khi rời văn phòng, xin đồng nghiệp cuối cùng nhất định khóa kỹ ngăn kéo và đóng hết tất cả cửa sổ cửa ra vào.",
          "explanation": "\"关上\" biểu thị hành động khép kín các cánh cửa lại."
        },
        {
          "chinese": "经过整整一年的艰苦努力复习，他今年终于考上了理想的重点大学。",
          "pinyin": "Jīngguò zhěngzhěng yì nián de jiānkǔ nǔlì fùxí, tā jīnnián zhōngyú kǎo shàng le lǐxiǎng de zhòngdiǎn dàxué.",
          "translation_vi": "Trải qua tròn một năm gian khổ nỗ lực ôn tập, năm nay anh ấy cuối cùng đã thi đỗ vào trường đại học trọng điểm mơ ước.",
          "explanation": "\"考上了\" biểu thị thi đỗ thành công đạt mục tiêu."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 54,
      "name": "Bổ ngữ kết quả lưu lại / cố định \"下\" (Lưu lại / Ngồi xuống)",
      "pattern": "Động từ (留 / 记 / 坐 / 停 / 拍) + 下 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"下\" (xià) làm bổ ngữ kết quả biểu thị người hoặc vật dừng lại cố định tại một chỗ (như 坐下: ngồi xuống, 停下: dừng lại), hoặc biểu thị sự lưu giữ, bảo tồn lại dấu vết, ký ức (như 留下: để lại, 记下: ghi lại, 拍下: chụp lại).",
      "examples": [
        {
          "chinese": "他把客座教授在学术讲座上列举的参考书目仔细地记在了笔记本上。",
          "pinyin": "Tā bǎ kèzuò jiàoshòu zài xuéshù jiǎngzuò shang lièjǔ de cānkǎo shūmù zǐxì de jì xià zài le bǐjìběn shang.",
          "translation_vi": "Anh ấy đã ghi chép lại một cách tỉ mỉ danh mục sách tham khảo mà giáo sư thỉnh giảng liệt kê trong buổi tọa đàm học thuật vào sổ tay.",
          "explanation": "\"记下\" biểu thị hành động ghi chép lưu giữ thông tin."
        },
        {
          "chinese": "面对突然冲向路中央的小动物，经验丰富的司机沉着地踩刹车停下了汽车。",
          "pinyin": "Miànduì tūrán chōng xiàng lù zhōngyāng de xiǎo dòngwù, jīngyàn fēngfù de sījī chénzhuó de cǎi shāchē tíng xià le qìchē.",
          "translation_vi": "Đối mặt với con vật nhỏ bất ngờ lao ra giữa lòng đường, người tài xế giàu kinh nghiệm đã bình tĩnh đạp phanh dừng chiếc xe lại.",
          "explanation": "\"停下了\" miêu tả chiếc xe dừng lại cố định một chỗ."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 55,
      "name": "Bổ ngữ kết quả chuyển hóa kết quả \"成\" (Thành / Biến thành)",
      "pattern": "Động từ (变 / 改 / 翻 / 写 / 看) + 成 + Kết quả mới",
      "category": "Bổ ngữ",
      "explanation_vi": "\"成\" (chéng) làm bổ ngữ kết quả biểu thị thông qua hành động làm cho đối tượng biến đổi thành một sự vật, trạng thái hoặc ngôn ngữ khác (dịch thành: 翻译成, viết thành: 写成, đổi thành: 改成, nhầm thành: 看成).",
      "examples": [
        {
          "chinese": "著名翻译家将这部深奥的中国古代哲学典籍翻译成了标准现代英语。",
          "pinyin": "Zhùmíng fānyìjiā jiāng zhè bù shēn'ào de zhōngguó gǔdài zhéxué diǎnjí fānyì chéng le biāozhǔn xiàndài yīngyǔ.",
          "translation_vi": "Nhà dịch thuật danh tiếng đã dịch cuốn điển tịch triết học cổ đại Trung Quốc sâu xa này thành tiếng Anh hiện đại tiêu chuẩn.",
          "explanation": "\"翻译成\" biểu thị sự chuyển hóa ngôn ngữ từ văn ngôn sang tiếng Anh."
        },
        {
          "chinese": "这片原先杂草丛生的荒地，经过改造如今变成了一座美丽的花园市民公园。",
          "pinyin": "Zhè piàn yuánxiān zá cǎo cóngshēng de huāngdì, jīngguò gǎizào rújīn biàn chéng le yí zuò měilì de huāyuán shìmín gōngyuán.",
          "translation_vi": "Khu đất hoang trước kia cỏ dại mọc um tùm này, sau khi cải tạo ngày nay đã biến thành một công viên công dân vườn hoa tươi đẹp.",
          "explanation": "\"变成\" miêu tả sự biến đổi toàn diện về tính chất diện mạo."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 56,
      "name": "Bổ ngữ xu hướng mở rộng bắt đầu & phát triển \"起来\"",
      "pattern": "Động từ / Tính từ + 起来 (+ 了) / 看 / 听 / 吃 + 起来",
      "category": "Bổ ngữ",
      "explanation_vi": "Nghĩa mở rộng của \"起来\" (qǐlai): (1) Biểu thị hành động bắt đầu và tiếp tục phát triển (khóc òa lên: 哭起来, cười lên: 笑起来); (2) Đứng sau các động từ cảm giác biểu thị sự đánh giá, cảm nhận sơ bộ (nhìn có vẻ: 看起来, nghe có vẻ: 听起来, ăn có vị: 吃起来).",
      "examples": [
        {
          "chinese": "听到相声演员妙趣横生的精彩幽默包袱，全场观众都忍不住哄堂大笑起来。",
          "pinyin": "Tīng dào xiàngsheng yǎnyuán miàoqù-héngshēng de jīngcǎi yōumò bāofu, quánchǎng guānzhòng dōu rěnbuzhù hōngtáng dàxiào qǐlai.",
          "translation_vi": "Nghe miếng hài hước hóm hỉnh đặc sắc đầy thú vị của diễn viên tướng thanh, khán giả toàn trường đều không kìm được mà cười òa cả lên.",
          "explanation": "\"大笑起来\" miêu tả tiếng cười bắt đầu nổ ra và tiếp diễn."
        },
        {
          "chinese": "这道刚出锅的中国传统松鼠桂鱼闻起来香气扑鼻，吃起来酸甜可口。",
          "pinyin": "Zhè dào gāng chūguō de zhōngguó chuántǒng sōngshǔ guìyú wén qǐlai xiāngqì-pūbí, chī qǐlai suāntián kěkǒu.",
          "translation_vi": "Món cá quế sóc truyền thống Trung Quốc vừa mới nhấc khỏi chảo này ngửi có vẻ thơm nức mũi, ăn vào có vị chua ngọt vừa miệng.",
          "explanation": "\"闻起来\" và \"吃起来\" thể hiện sự đánh giá qua khứu giác và vị giác."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 57,
      "name": "Bổ ngữ xu hướng mở rộng duy trì tiếp tục \"下去\"",
      "pattern": "Động từ + 下去 / Phủ định: 动词 + 不下去",
      "category": "Bổ ngữ",
      "explanation_vi": "\"下去\" (xiàqu) làm bổ ngữ xu hướng mở rộng biểu thị hành động đang tiến hành sẽ tiếp tục kéo dài không ngừng tới tương lai (làm tiếp đi, sống tiếp, nói tiếp: 坚持下去, 说下去). Dạng phủ định là \"V + 不下去\" (không thể tiếp tục làm nổi).",
      "examples": [
        {
          "chinese": "只要我们有坚定的恒心并坚持不懈地学下去，就一定能攻克汉语难关。",
          "pinyin": "Zhǐyào wǒmen yǒu jiāndìng de héngxīn bìng jiānchí-búxiè de xué xiàqu, jiù yídìng néng gōngkè hànyǔ nánguān.",
          "translation_vi": "Chỉ cần chúng ta có lòng kiên trì vững vàng và bền bỉ học tiếp tục không ngơi nghỉ, thì nhất định có thể vượt qua cửa ải khó khăn của tiếng Hán.",
          "explanation": "\"学下去\" biểu thị việc học tập tiếp tục duy trì đến tương lai."
        },
        {
          "chinese": "会议主持人微笑着请发言代表不要紧张，继续把调研报告详细讲下去。",
          "pinyin": "Huìyì zhǔchírén wēixiào zhe qǐng fāyán dàibiǎo bú yào jǐnzhāng, jìxù bǎ diàoyán bàogào xiángxì jiǎng xiàqu.",
          "translation_vi": "Người chủ trì cuộc họp mỉm cười mời đại biểu phát biểu đừng căng thẳng, tiếp tục trình bày bản báo cáo khảo sát một cách chi tiết.",
          "explanation": "\"讲下去\" khích lệ đại biểu tiếp tục nói phần tiếp theo."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 58,
      "name": "Bổ ngữ xu hướng mở rộng hồi phục trạng thái \"过来\"",
      "pattern": "Động từ (醒 / 恢复 / 明白) + 过来",
      "category": "Bổ ngữ",
      "explanation_vi": "\"过来\" (guòlai) làm bổ ngữ xu hướng mở rộng biểu thị sự chuyển biến trở lại trạng thái tỉnh táo, bình thường, đúng đắn từ một trạng thái bất thường, hôn mê hoặc sai lầm (tỉnh lại: 醒过来, hồi phục lại: 缓过来, hiểu ra: 明白过来).",
      "examples": [
        {
          "chinese": "经过医护人员连续几个小时的紧张抢救，昏迷的危重病人终于苏醒过来了。",
          "pinyin": "Jīngguò yīhù rényuán liánxù jǐ gè xiǎoshí de jǐnzhāng qiǎngjiù, hūnmí de wēizhòng bìngrén zhōngyú sūxǐng guòlai le.",
          "translation_vi": "Trải qua nhiều giờ đồng hồ cấp cứu khẩn trương của nhân viên y tế, người bệnh nguy kịch hôn mê cuối cùng đã tỉnh táo lại rồi.",
          "explanation": "\"苏醒过来\" biểu thị người bệnh từ hôn mê trở về trạng thái tỉnh táo."
        },
        {
          "chinese": "听到导师深入浅出的耐心点拨，小张才恍然大悟、彻底明白过来了。",
          "pinyin": "Tīng dào dǎoshī shēnrù-qiǎnchū de nàixīn diǎnbō, Xiǎo Zhāng cái huǎngrán-dàwù, chèdǐ míngbai guòlai le.",
          "translation_vi": "Nghe lời chỉ bảo kiên nhẫn dễ hiểu của người hướng dẫn, Tiểu Trương mới bừng tỉnh ngộ ra, hiểu thấu suốt mọi chuyện.",
          "explanation": "\"明白过来\" chỉ nhận thức từ mơ hồ chuyển sang thông suốt."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 59,
      "name": "Bổ ngữ xu hướng mở rộng rơi vào trạng thái tiêu cực \"过去\"",
      "pattern": "Động từ (晕 / 昏) + 过去",
      "category": "Bổ ngữ",
      "explanation_vi": "\"过去\" (guòqu) làm bổ ngữ xu hướng mở rộng biểu thị sự chuyển biến sang một trạng thái bất tỉnh, tiêu cực hoặc mất đi ý thức (ngất xỉu đi: 晕过去, bất tỉnh nhân sự: 昏过去). Đối lập với \"过来\".",
      "examples": [
        {
          "chinese": "连续在烈日下高强度站岗执勤数小时，这名年轻的士兵险些中暑晕过去了。",
          "pinyin": "Liánxù zài lièrì xià gāo qiángdù zhàngǎng zhíqín shù xiǎoshí, zhè míng niánqīng de shìbīng xiǎnxiē zhòngshǔ yūn guòqu le.",
          "translation_vi": "Liên tục đứng gác làm nhiệm vụ cường độ cao dưới nắng gắt nhiều giờ, người binh sĩ trẻ tuổi này suýt nữa say nắng ngất xỉu đi.",
          "explanation": "\"晕过去\" miêu tả trạng thái mất tri giác do say nắng."
        },
        {
          "chinese": "他得知突如其来的噩耗后悲痛欲绝，几乎一下子昏倒过去了。",
          "pinyin": "Tā dézhī tūrúqílái de èhào hòu bēitòng-yùjué, jīhū yíxiàzi hūndǎo guòqu le.",
          "translation_vi": "Anh ấy sau khi hay tin dữ bất ngờ ập đến đau đớn tột cùng, suýt chút nữa ngất lịm đi.",
          "explanation": "\"昏倒过去\" biểu thị ngã ngất đi vì nỗi đau quá lớn."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 60,
      "name": "Bổ ngữ xu hướng mở rộng hiển lộ sáng tỏ \"出来\"",
      "pattern": "Động từ (看 / 听 / 想 / 认 / 查) + 出来 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"出来\" (chūlai) làm bổ ngữ xu hướng mở rộng biểu thị thông qua động tác phân tích, nhận biết mà làm cho một sự thật ẩn giấu, một ý tưởng hoặc thông tin được hiển lộ ra rõ ràng trước mắt (nhận ra: 认出来, nghe ra: 听出来, nhìn ra: 看出来, nghĩ ra cách: 想出来).",
      "examples": [
        {
          "chinese": "虽然二十多年未曾谋面，但老同学相聚时他还是一眼就把我认出来了。",
          "pinyin": "Suīrán èrshí duō nián wèicéng móumiàn, dàn lǎo tóngxué xiāngjù shí tā háishì yì yǎn jiù bǎ wǒ rèn chūlai le.",
          "translation_vi": "Mặc dù hơn hai mươi năm chưa từng gặp mặt, nhưng lúc bạn học cũ hội ngộ anh ấy vẫn vừa liếc mắt đã nhận ra tôi ngay.",
          "explanation": "\"认出来了\" biểu thị nhận diện rõ danh tính người bạn cũ."
        },
        {
          "chinese": "经过整整一个下午的集思广益，研发小组终于想出来了一个绝妙的解决方案。",
          "pinyin": "Jīngguò zhěngzhěng yí gè xiàwǔ de jísī-guǎngyì, yánfā xiǎozǔ zhōngyú xiǎng chūlai le yí gè juémiào de jiějué fāng'àn.",
          "translation_vi": "Trải qua trọn vẹn một buổi chiều tập hợp trí tuệ chung, tổ nghiên cứu phát triển cuối cùng đã nghĩ ra được một phương án giải quyết tuyệt diệu.",
          "explanation": "\"想出来\" biểu thị ý tưởng giải pháp mới được hình thành."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 61,
      "name": "Bổ ngữ khả năng hoàn tất kết thúc \"V + 得 / 不 + 了 (liǎo)\"",
      "pattern": "Động từ + 得 / 不 + 了 (liǎo) (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"得了 / 不了\" (de liǎo / bù liǎo) là bổ ngữ khả năng biểu thị hành động có khả năng tiến hành hoặc hoàn thành hay không (làm được/không nổi, đi được/không thể đi). Thường do điều kiện khách quan quyết định.",
      "examples": [
        {
          "chinese": "这盘红烧羊肉分量实在太大了，我一个人无论如何也吃不了。",
          "pinyin": "Zhè pán hóngshāo yángròu fènliàng shízài tài dà le, wǒ yí gè rén wúlùn-rúhé yě chī bu liǎo.",
          "translation_vi": "Đĩa thịt cừu kho này khẩu phần thực sự quá nhiều rồi, một mình tôi bất luận thế nào cũng không thể ăn hết nổi.",
          "explanation": "\"吃不了\" biểu thị sức ăn một mình không kham nổi số lượng thịt nhiều."
        },
        {
          "chinese": "今天晚上我有重要的国际学术会议要参加，恐怕去不了你的生日聚会了。",
          "pinyin": "Jīntiān wǎnshang wǒ yǒu zhòngyào de guójì xuéshù huìyì yào cānjiā, kǒngpà qù bu liǎo nǐ de shēngrì jùhuì le.",
          "translation_vi": "Tối hôm nay tôi có cuộc họp học thuật quốc tế quan trọng phải tham dự, e rằng không thể đi tham gia buổi tiệc sinh nhật của bạn được rồi.",
          "explanation": "\"去不了\" chỉ việc không thể tham gia do bị vướng lịch họp."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 62,
      "name": "Bổ ngữ khả năng thể lực vận động \"V + 得 / 不 + 动\"",
      "pattern": "Động từ + 得 / 不 + 动 (走 / 跑 / 搬 / 爬)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"得动 / 不动\" (de dòng / bu dòng) biểu thị về mặt thể lực, sức lực của con người có đủ khả năng làm cho thân thể hoặc vật thể chuyển dịch, vận động hay không (nhấc nổi/không nổi, đi nổi/không nổi).",
      "examples": [
        {
          "chinese": "连续徒步跋涉了五个小时的山路，大家都累得气喘吁吁、走不动了。",
          "pinyin": "Liánxù túbù báshè le wǔ gè xiǎoshí de shānlù, dàjiā dōu lèi de qìchuǎn-xūxū, zǒu bu dòng le.",
          "translation_vi": "Liên tục cuốc bộ vượt đường núi suốt năm tiếng đồng hồ, mọi người đều mệt tới thở hồng hộc, không thể bước nổi nữa rồi.",
          "explanation": "\"走不动了\" miêu tả thể lực cạn kiệt không thể nhấc chân đi tiếp."
        },
        {
          "chinese": "这个装满厚重历史图书的大纸箱太沉了，我一个人根本搬不动。",
          "pinyin": "Zhè gè zhuāng mǎn hòuzhòng lìshǐ túshū de dà zhǐxiāng tài chén le, wǒ yí gè rén gēnběn bān bu dòng.",
          "translation_vi": "Chiếc thùng carton lớn đựng đầy sách lịch sử nặng trịch này nặng quá, một mình tôi căn bản không bê nổi.",
          "explanation": "\"搬不动\" biểu thị sức nặng của thùng sách vượt quá sức người."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 63,
      "name": "Bổ ngữ khả năng dung lượng sức chứa \"V + 得 / 不 + 下\"",
      "pattern": "Động từ (坐 / 住 / 站 / 装 / 放) + 得 / 不 + 下 (+ Tân ngữ)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"得下 / 不下\" (de xià / bu xià) biểu thị không gian, diện tích hoặc sức chứa có thể dung nạp, chứa đựng được số lượng người hoặc vật thể đó hay không (ngồi vừa/không vừa, chứa hết/không hết, để vừa/không vừa).",
      "examples": [
        {
          "chinese": "这间小型阶梯自习室空间有限，最多只能坐得下五十位学生。",
          "pinyin": "Zhè jiān xiǎoxíng jiētī zìxíshì kōngjiān yǒuxiàn, zuìduō zhǐ néng zuò de xià wǔshí wèi xuésheng.",
          "translation_vi": "Phòng tự học bậc thang cỡ nhỏ này không gian có hạn, tối đa chỉ có thể ngồi vừa năm mươi học sinh.",
          "explanation": "\"坐得下\" khẳng định sức chứa tối đa của phòng học."
        },
        {
          "chinese": "你的旅行箱已经塞得太满了，这本大字典无论如何也装不下了。",
          "pinyin": "Nǐ de lǚxíngxiāng yǐjīng sāi de tài mǎn le, zhè běn dà zìdiǎn wúlùn-rúhé yě zhuāng bu xià le.",
          "translation_vi": "Vali du lịch của bạn đã nhét quá chật rồi, cuốn đại tự điển này bất luận thế nào cũng không thể nhét vừa nữa rồi.",
          "explanation": "\"装不下\" biểu thị dung lượng vali không còn chỗ chứa."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 64,
      "name": "Bổ ngữ khả năng giác quan tri giác \"V + 得 / 不 + 见 / 懂\"",
      "pattern": "看 / 听 + 得 / 不 + 见 / 懂",
      "category": "Bổ ngữ",
      "explanation_vi": "Biểu thị năng lực của mắt, tai có thể nhìn thấy, nghe thấy hoặc hiểu được nội dung hay không (nhìn thấy được/không thấy: 看得见 / 看不见; nghe hiểu/không hiểu: 听得懂 / 听不懂).",
      "examples": [
        {
          "chinese": "报告厅的音响设备非常清晰，即使坐在最后一排也能听得见发言。",
          "pinyin": "Bàogàotīng de yīnxiǎng shèbèi fēicháng qīngxī, jíshǐ zuò zài zuìhòu yì pái yě néng tīng de jiàn fāyán.",
          "translation_vi": "Thiết bị âm thanh của phòng báo cáo rất rõ ràng, cho dù ngồi ở hàng ghế cuối cùng cũng có thể nghe thấy bài phát biểu.",
          "explanation": "\"听得见\" khẳng định năng lực nghe rõ âm thanh từ xa."
        },
        {
          "chinese": "这位外国学者发言语速非常平缓标准，初学汉语的学生也能听得懂。",
          "pinyin": "Zhè wèi wàiguó xuézhě fāyán yǔsù fēicháng pínghuǎn biāozhǔn, chūxué hànyǔ de xuésheng yě néng tīng de dǒng.",
          "translation_vi": "Học giả nước ngoài này phát biểu tốc độ nói rất thong thả chuẩn mực, học sinh mới học tiếng Hán cũng có thể nghe hiểu được.",
          "explanation": "\"听得懂\" biểu thị khả năng tiếp nhận và hiểu nghĩa nội dung."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 65,
      "name": "Bổ ngữ khả năng đạt tới mục tiêu \"V + 得 / 不 + 着 (zháo)\"",
      "pattern": "Động từ (睡 / 找 / 买 / 碰) + 得 / 不 + 着 (zháo)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"得着 / 不着\" (de zháo / bu zháo) biểu thị khả năng có đạt được kết quả mong đợi hay không (ngủ được/không ngủ được: 睡得着 / 睡不着; tìm thấy/không thấy: 找得着 / 找不着; với tới: 碰得着).",
      "examples": [
        {
          "chinese": "明天就要公布全国研究生录取结果了，他昨晚兴奋得整夜睡不着觉。",
          "pinyin": "Míngtiān jiù yào gōngbù quánguó yánjiūshēng lùqǔ jiéguǒ le, tā zuówǎn xīngfèn de zhěng yè shuì bu zháo jiào.",
          "translation_vi": "Ngày mai là công bố kết quả tuyển sinh nghiên cứu sinh toàn quốc rồi, tối qua anh ấy hưng phấn đến mức thức trắng đêm không ngủ được.",
          "explanation": "\"睡不着觉\" biểu thị không thể đi vào giấc ngủ do tâm trạng bồi hồi."
        },
        {
          "chinese": "书架顶部那本珍贵的精装画册放得太高了，他踮起脚尖也够不着。",
          "pinyin": "Shūjià dǐngbù nà běn zhēnguì de jīngzhuāng huàcè fàng de tài gāo le, tā diǎn qǐ jiǎojiān yě gòu bu zháo.",
          "translation_vi": "Cuốn tập tranh bìa cứng quý giá ở đỉnh giá sách để cao quá, anh ấy kiễng cả mũi chân cũng không với tới được.",
          "explanation": "\"够不着\" biểu thị không thể chạm tới do khoảng cách quá cao."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 66,
      "name": "Câu chữ 把 mang bổ ngữ kết quả (把字句带结果补语)",
      "pattern": "Chủ ngữ + 把 + Tân ngữ + Động từ + Bổ ngữ kết quả (好 / 完 / 错 / 净)",
      "category": "Cấu trúc câu",
      "explanation_vi": "Trong câu chữ 把 trung cấp, động từ thường mang bổ ngữ kết quả để làm rõ mức độ xử lý hoàn tất hoặc tình trạng mới của tân ngữ sau tác động (làm xong: 做完, chuẩn bị tốt: 准备好, lau sạch: 擦干净).",
      "examples": [
        {
          "chinese": "请同学们在离开实验室之前，务必把桌面上的仪器设备收拾干净。",
          "pinyin": "Qǐng tóngxué men zài líkāi shíyànshì zhīqián, wùbì bǎ zhuōmiàn shang de yíqì shèbèi shōushi gānjìng.",
          "translation_vi": "Xin mời các bạn học sinh trước khi rời phòng thí nghiệm, nhất định phải thu dọn sạch sẽ các trang thiết bị trên mặt bàn.",
          "explanation": "\"把...收拾干净\" xử lý đối tượng thiết bị tới trạng thái sạch tinh tươm."
        },
        {
          "chinese": "他花了一整天的时间，终于把那篇长达一万字的研究报告写完了。",
          "pinyin": "Tā huā le yì zhěng tiān de shíjiān, zhōngyú bǎ nà piān chángdá yí wàn zì de yánjiū bàogào xiě wán le.",
          "translation_vi": "Anh ấy đã bỏ ra trọn vẹn một ngày, cuối cùng đã viết xong bản báo cáo nghiên cứu dài một vạn chữ đó rồi.",
          "explanation": "\"把...写完了\" biểu thị bài báo cáo đã hoàn thành trọn vẹn."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 67,
      "name": "Câu chữ 把 mang bổ ngữ xu hướng (把字句带趋向补语)",
      "pattern": "Chủ ngữ + 把 + Tân ngữ + Động từ + Bổ ngữ xu hướng (回来 / 进去 / 拿出来)",
      "category": "Cấu trúc câu",
      "explanation_vi": "Câu chữ 把 kết hợp với bổ ngữ xu hướng (nhất là xu hướng kép) để miêu tả hành động dịch chuyển vật thể từ không gian này sang không gian khác hoặc theo một phương hướng nhất định đối với người nói.",
      "examples": [
        {
          "chinese": "他小心翼翼地从书包里把那幅珍贵的古代水墨山水画拿了出来。",
          "pinyin": "Tā xiǎoxīn-yìyì de cóng shūbāo lǐ bǎ nà fú zhēnguì de gǔdài shuǐmò shānshuǐhuà ná le chūlai.",
          "translation_vi": "Anh ấy cẩn thận từng li từng tí từ trong cặp sách lấy bức tranh sơn thủy thủy mặc cổ đại quý giá đó ra ngoài.",
          "explanation": "\"把...拿了出来\" làm dịch chuyển bức tranh từ trong cặp ra ngoài tầm mắt."
        },
        {
          "chinese": "天气突然变冷了，妈妈赶紧把晾晒在阳台上的厚棉被收了进来。",
          "pinyin": "Tiānqì tūrán biàn lěng le, māma gǎnjǐn bǎ liàngshài zài yángtái shang de hòu miánbèi shōu le jìnlái.",
          "translation_vi": "Thời tiết đột nhiên chuyển lạnh, người mẹ vội vàng thu chiếc chăn bông dày phơi trên ban công vào trong nhà.",
          "explanation": "\"把...收了进来\" mang chiếc chăn phơi vào trong nhà."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 68,
      "name": "Câu bị động tiêu chuẩn với giới từ \"被\" (被字句标准结构)",
      "pattern": "Chủ ngữ (Người/vật bị tác động) + 被 (+ Tác nhân) + Động từ + Thành phần khác",
      "category": "Cấu trúc câu",
      "explanation_vi": "Câu chữ \"被\" (bèi) là câu bị động tiêu chuẩn trong tiếng Hán, dùng để nhấn mạnh chủ ngữ tiếp nhận hoặc gánh chịu một hành động tác động từ bên ngoài (thường là sự việc không mong muốn hoặc có tính chất thay đổi lớn). Động từ bắt buộc phải có thành phần đi kèm phía sau (như 了, bổ ngữ).",
      "examples": [
        {
          "chinese": "那辆停放在路边无障碍通道上的违章轿车，被交通警察依法拖走了。",
          "pinyin": "Nà liàng tíngfàng zài lùbiān wúzhàng'ài tōngdào shang de wéizhāng jiàochē, bèi jiāotōng jǐngchá yīfǎ tuō zǒu le.",
          "translation_vi": "Chiếc xe ô tô con vi phạm đỗ trên lối đi không rào cản ven đường đó đã bị cảnh sát giao thông cẩu đi theo đúng luật.",
          "explanation": "\"被交通警察...拖走了\" cấu trúc bị động chỉ chiếc xe bị cẩu đi."
        },
        {
          "chinese": "昨夜狂风大作，门前花园里几株盛开的红月季被大风吹落了花瓣。",
          "pinyin": "Zuóyè kuángfēng-dàzuò, ménqián huāyuán lǐ jǐ zhū shèngkāi de hóng yuèjì bèi dàfēng chuī luò le huābàn.",
          "translation_vi": "Đêm qua gió lốc thét gào, mấy khóm hoa nguyệt quý đỏ nở rộ trong vườn hoa trước cửa đã bị cơn gió lớn thổi rụng cánh hoa.",
          "explanation": "\"被大风吹落\" miêu tả cánh hoa bị gió thổi rụng."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 69,
      "name": "Câu bị động khẩu ngữ với \"叫 / 让\" (叫/让字被动句)",
      "pattern": "Chủ ngữ + 叫 / 让 + Tác nhân bắt buộc + Động từ + Thành phần khác",
      "category": "Cấu trúc câu",
      "explanation_vi": "Trong khẩu ngữ sinh hoạt hàng ngày, người ta thường dùng \"叫\" (jiào) hoặc \"让\" (ràng) thay cho \"被\" để diễn đạt ý bị động. Chú ý điểm ngữ pháp cực kỳ quan trọng: Trong câu bị động chữ \"叫 / 让\", TÁC NHÂN BẮT BUỘC PHẢI XUẤT HIỆN, không được lược bỏ như trong câu chữ \"被\".",
      "examples": [
        {
          "chinese": "桌上刚刚倒满的那杯香浓热牛奶，不小心让他给打翻了。",
          "pinyin": "Zhuō shang gānggāng dào mǎn de nà bēi xiāngnóng rè niúnǎi, bù xiǎoxīn ràng tā gěi dǎfān le.",
          "translation_vi": "Cốc sữa bò nóng thơm lừng vừa mới rót đầy trên bàn, chẳng may đã bị anh ấy làm hắt đổ rồi.",
          "explanation": "\"让他给打翻了\" cấu trúc bị động khẩu ngữ với tác nhân bắt buộc \"他\"."
        },
        {
          "chinese": "放在阳台上晒干的新鲜草莓干，不知道叫谁偷偷吃掉了一半。",
          "pinyin": "Fàng zài yángtái shang shàigān de xīnxiān cǎoméi gān, bù zhīdào jiào shéi tōutōu chī diào le yíbàn.",
          "translation_vi": "Món mứt dâu tây tươi phơi khô để ở ban công, không biết bị ai lén ăn mất một nửa rồi.",
          "explanation": "\"叫谁...吃掉了\" cấu trúc bị động khẩu ngữ dùng chữ \"叫\"."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 70,
      "name": "Câu kiêm ngữ sai khiến yêu cầu \"让 / 叫 / 请\" (兼语句)",
      "pattern": "Chủ ngữ + 让 / 叫 / 请 + Tân ngữ 1 (kiêm chủ ngữ 2) + Động từ 2 (+ Tân ngữ 2)",
      "category": "Cấu trúc câu",
      "explanation_vi": "Câu kiêm ngữ có thành phần đứng giữa vừa làm tân ngữ cho động từ thứ nhất (让, 叫, 请), vừa làm chủ ngữ cho động từ thứ hai (bảo ai làm gì, mời ai làm gì).",
      "examples": [
        {
          "chinese": "系主任请张教授下周在学术报告厅为全院师生做一场专题讲座。",
          "pinyin": "Xì zhǔrèn qǐng Zhāng jiàoshòu xià zhōu zài xuéshù bàogàotīng wèi quán yuàn shīshēng zuò yì chǎng zhuāntí jiǎngzuò.",
          "translation_vi": "Chủ nhiệm khoa mời giáo sư Trương tuần sau tại phòng báo cáo học thuật thuyết trình một bài giảng chuyên đề cho toàn thể thầy trò trong viện.",
          "explanation": "\"张教授\" vừa là tân ngữ của \"请\", vừa là chủ ngữ của hành động \"做讲座\"."
        },
        {
          "chinese": "医生叮嘱病人一定要按时服药，并叫家属多陪老人散步散心。",
          "pinyin": "Yīshēng dīngzhǔ bìngrén yídìng yào ànshí fúyào, bìng jiào jiāshǔ duō péi lǎorén sànbù sànxīn.",
          "translation_vi": "Bác sĩ dặn dò người bệnh nhất định phải uống thuốc đúng giờ, đồng thời bảo người nhà bồi bạn cùng người già đi dạo thư giãn.",
          "explanation": "\"叫家属多陪\" kiêm ngữ chỉ đối tượng người nhà được dặn dò."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 71,
      "name": "Câu kiêm ngữ nguyên nhân kết quả với \"使\" (Khiến cho / Làm cho)",
      "pattern": "Nguyên nhân / Sự việc + 使 + Đối tượng kiêm ngữ + Động từ / Tính từ",
      "category": "Cấu trúc câu",
      "explanation_vi": "\"使\" (shǐ) thường dùng trong văn viết hoặc văn cảnh trang trọng để biểu thị sự việc, hành động thứ nhất làm nảy sinh kết quả, biến đổi tâm trạng hoặc tình thái ở đối tượng tiếp theo (khiến cho, làm cho).",
      "examples": [
        {
          "chinese": "科技创新成果的快速普及应用，使广大人民的生活变得更加便利舒适。",
          "pinyin": "Kējì chuàngxīn chéngguǒ de kuàisù pǔjí yìngyòng, shǐ guǎngdà rénmín de shēnghuó biàn de gèngjiā biànlì shūshì.",
          "translation_vi": "Việc phổ cập ứng dụng nhanh chóng các thành quả đổi mới khoa học công nghệ đã khiến cho đời sống của đông đảo nhân dân trở nên tiện lợi thoải mái hơn nhiều.",
          "explanation": "\"使...变得更加便利\" biểu thị thành quả công nghệ đem lại sự biến đổi tốt đẹp cho đời sống."
        },
        {
          "chinese": "老同学久别重逢的感人场面，使在场的每一个人都流下了激动的泪水。",
          "pinyin": "Lǎo tóngxué jiǔbié-chóngféng de gǎnrén chǎngmiàn, shǐ zàichǎng de měi yí gè rén dōu liú xià le jīdòng de lèishuǐ.",
          "translation_vi": "Cảnh tượng cảm động hội ngộ sau bao năm xa cách của bạn học cũ đã làm cho mỗi người có mặt đều rơi những giọt nước mắt xúc động.",
          "explanation": "\"使在场的每一个人...流下泪水\" kiêm ngữ chỉ cảm xúc dâng trào do buổi tao ngộ đem lại."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 72,
      "name": "Cấu trúc so sánh kém \"A 不如 B (+ Tính từ)\" (A không bằng B)",
      "pattern": "Chủ ngữ A + 不如 + Chủ ngữ B (+ Tính từ / Động từ)",
      "category": "Cấu trúc so sánh",
      "explanation_vi": "Cấu trúc \"A 不如 B\" (A bùrú B) dùng để biểu thị đối tượng A không bằng, kém hơn đối tượng B về một phương diện nào đó (A không bằng B, chi bằng). Thường dùng trong cả văn viết lẫn văn nói.",
      "examples": [
        {
          "chinese": "看别人的书面文字转述，不如亲自走到实地深入考察来得真切深刻。",
          "pinyin": "Kàn biérén de shūmiàn wénzì zhuǎnshù, bùrú qīnzì zǒu dào shídì shēnrù kǎochá lái de zhēnqiè shēnkè.",
          "translation_vi": "Xem bản diễn giải chữ nghĩa của người khác không bằng đích thân đi đến thực địa khảo sát sâu sắc chân thực.",
          "explanation": "\"不如亲自...\" so sánh việc tự mình đi trải nghiệm tốt hơn việc chỉ đọc sách."
        },
        {
          "chinese": "这家超市普通苹果的口感不如北方果园直供的新鲜红富士甜脆。",
          "pinyin": "Zhè jiā chāoshì pǔtōng píngguǒ de kǒugǎn bùrú běifāng guǒyuán zhígōng de xīnxiān hóngfùshì tián cuì.",
          "translation_vi": "Hương vị của táo thông thường ở siêu thị này không bằng độ giòn ngọt của táo Phú Sĩ đỏ tươi cung cấp trực tiếp từ vườn cây ăn quả phương Bắc.",
          "explanation": "\"不如...甜脆\" so sánh hương vị không ngon bằng."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 73,
      "name": "Cấu trúc tăng tiến biến đổi theo thời gian \"越来越 + Tính từ / Động từ\"",
      "pattern": "Chủ ngữ + 越来越 + Tính từ / Động từ tâm lý (+ 了)",
      "category": "Cấu trúc câu",
      "explanation_vi": "\"越来越...\" (yuè lái yuè...) biểu thị mức độ của tính chất, trạng thái hoặc cảm xúc không ngừng gia tăng, phát triển theo bước tiến của thời gian (càng ngày càng..., ngày một... hơn). Không được dùng kèm các phó từ mức độ như 很, 非常.",
      "examples": [
        {
          "chinese": "随着与中国朋友交流日渐密切，他的汉语口语表达越来越流利地道了。",
          "pinyin": "Suízhe yǔ zhōngguó péngyou jiāoliú rìjiàn mìqiè, tā de hànyǔ kǒuyǔ biǎodá yuè lái yuè liúlì dìdào le.",
          "translation_vi": "Cùng với việc giao lưu với bạn bè Trung Quốc ngày càng gắn bó, biểu đạt khẩu ngữ tiếng Hán của anh ấy càng ngày càng lưu loát chuẩn vị rồi.",
          "explanation": "\"越来越流利\" chỉ trình độ lưu loát tăng dần theo ngày tháng."
        },
        {
          "chinese": "立冬过后白昼变短，北方大地的天气变得越来越寒冷严酷了。",
          "pinyin": "Lìdōng guòhòu báizhòu biàn duǎn, běifāng dàdì de tiānqì biàn de yuè lái yuè hánlěng yánkù le.",
          "translation_vi": "Sau tiết Lập đông ban ngày ngắn lại, thời tiết đất trời phương Bắc trở nên càng ngày càng giá buốt khắc nghiệt.",
          "explanation": "\"越来越寒冷\" miêu tả độ lạnh ngày một gia tăng."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 74,
      "name": "Cấu trúc so sánh theo chu kỳ đối chiếu \"一年比一年... / 一天比一天...\"",
      "pattern": "Số từ + Lượng từ + 比 + Số từ + Lượng từ + Tính từ / Vị ngữ",
      "category": "Cấu trúc so sánh",
      "explanation_vi": "Cấu trúc \"Lượng từ + 比 + Lượng từ + Tính từ\" (như: 一天比一天: từng ngày từng ngày một, 一年比一年: từng năm từng năm một) dùng để nhấn mạnh sự thay đổi, tiến triển liên tục theo từng chu kỳ thời gian đều đặn.",
      "examples": [
        {
          "chinese": "在国家乡村振兴政策的大力支持下，山村百姓的生活一年比一年富裕幸福。",
          "pinyin": "Zài guójiā xiāngcūn zhènxīng zhèngcè de dàlì zhīchí xià, shāncūn bǎixìng de shēnghuó yì nián bǐ yì nián fùyù xìngfú.",
          "translation_vi": "Dưới sự hỗ trợ đắc lực của chính sách chấn hưng nông thôn quốc gia, đời sống của người dân làng núi mỗi năm một thêm giàu có hạnh phúc.",
          "explanation": "\"一年比一年富裕\" nhấn mạnh sự khấm khá tăng trưởng qua từng năm."
        },
        {
          "chinese": "春回大地万物复苏，公园池塘里的春水一天比一天清澈温暖。",
          "pinyin": "Chūnhuí-dàdì wànwù fùsū, gōngyuán chítáng lǐ de chūnshuǐ yì tiān bǐ yì tiān qīngchè wēnnuǎn.",
          "translation_vi": "Xuân về trên đất mẹ muôn vật hồi sinh, dòng nước xuân trong ao đầm công viên mỗi ngày một trong veo ấm áp hơn.",
          "explanation": "\"一天比一天清澈\" miêu tả sự biến đổi rõ rệt qua từng ngày."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 75,
      "name": "Cấu trúc loại trừ toàn bộ \"除了...以外, (都...)\"",
      "pattern": "除了 + Đối tượng loại trừ + (以外), 主语 + 都 + Vị ngữ",
      "category": "Cấu trúc câu",
      "explanation_vi": "Cấu trúc \"除了...以外, 都...\" (chúle... yǐwài, dōu...) biểu thị sự loại trừ: trừ một hoặc một số đối tượng cá biệt đứng sau \"除了\", tất cả các đối tượng còn lại đều có cùng một đặc điểm hoặc hành động không ngoại lệ (ngoài... ra, tất cả đều...).",
      "examples": [
        {
          "chinese": "除了最后一道高难度的附加思考题以外，试卷上的其他题目他都做对了。",
          "pinyin": "Chúle zuìhòu yí dào gāonándù de fùjiā sīkǎotí yǐwài, shìjuàn shang de qítā tímù tā dōu zuò duì le.",
          "translation_vi": "Ngoại trừ bài toán suy ngẫm phụ thêm độ khó cao cuối cùng ra, các bài khác trên đề thi anh ấy đều làm đúng hết.",
          "explanation": "\"除了...以外, 都做对了\" loại trừ 1 câu khó, còn lại đều làm đúng."
        },
        {
          "chinese": "除了周末定期闭馆维护以外，市立博物馆每天上午九点准时向公众免费开放。",
          "pinyin": "Chúle zhōumò dìngqī bìguǎn wéihù yǐwài, shìlì bówùguǎn měitiān shàngwǔ jiǔ diǎn zhǔnshí xiàng gōngzhòng miǎnfèi kāifàng.",
          "translation_vi": "Ngoại trừ dịp cuối tuần định kỳ đóng cửa bảo trì ra, bảo tàng thành phố mỗi sáng chín giờ đều mở cửa miễn phí đúng giờ đón công chúng.",
          "explanation": "Loại trừ ngày bảo trì, còn lại các ngày đều mở cửa."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 76,
      "name": "Cấu trúc bổ sung tiếp tục \"除了...以外, (还 / 也...)\"",
      "pattern": "除了 + Đối tượng nền tảng + (以外), 主语 + 还 / 也 + Vị ngữ bổ sung",
      "category": "Cấu trúc câu",
      "explanation_vi": "Khác với cấu trúc loại trừ đi với \"都\", khi \"除了...以外\" kết hợp với \"还\" hoặc \"也\" thì nó mang ý nghĩa bao gồm và bổ sung thêm: ngoài đối tượng A đã có sẵn, chủ thể còn có thêm hoặc làm thêm cả đối tượng B nữa (ngoài... ra, còn có/cũng...).",
      "examples": [
        {
          "chinese": "他在大学除了认真攻读计算机专业课程以外，还自学了法语和西班牙语。",
          "pinyin": "Tā zài dàxué chúle rènzhēn gōngdú jìsuànjī zhuānyè kèchéng yǐwài, hái zìxué le fǎyǔ hé xībānyáyǔ.",
          "translation_vi": "Ở trường đại học ngoài việc chăm chỉ dùi mài các học phần chuyên ngành máy tính ra, anh ấy còn tự học cả tiếng Pháp và tiếng Tây Ban Nha.",
          "explanation": "\"除了...以外, 还自学...\" biểu thị việc tự học thêm ngoại ngữ bên cạnh ngành chính."
        },
        {
          "chinese": "这间多功能体育活动中心除了配备室内羽毛球场以外，还有一座恒温游泳馆。",
          "pinyin": "Zhè jiān duō gōngnéng tǐyù huódòng zhōngxīn chúle pèibèi shìnèi yǔmáoqiú chǎng yǐwài, hái yǒu yí zuò héngwēn yóuyǒngguǎn.",
          "translation_vi": "Trung tâm hoạt động thể dục thể thao đa năng này ngoài việc trang bị sân cầu lông trong nhà ra, còn có cả một nhà bể bơi nhiệt độ không đổi.",
          "explanation": "Bổ sung thêm tiện ích bể bơi bên cạnh sân cầu lông."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 77,
      "name": "Cấu trúc nhấn mạnh trường hợp cực đoan \"连...都 / 也...\"",
      "pattern": "连 + Đối tượng cực đoan / Tối thiểu + 都 / 也 + Vị ngữ",
      "category": "Cấu trúc câu",
      "explanation_vi": "Cấu trúc \"连...都 / 也...\" (lián... dōu/yě...) dùng để đưa ra một trường hợp cực đoan nhất hoặc một điều kiện tối thiểu nhất làm đòn bẩy nhằm nhấn mạnh toàn bộ các trường hợp thông thường khác đương nhiên cũng như vậy (ngay cả... cũng, đến cả... đều).",
      "examples": [
        {
          "chinese": "这道题目的解题步骤极其简单明了，连刚上学的小朋友都能轻松看懂。",
          "pinyin": "Zhè dào tímù de jiětí bùzhòu jíqí jiǎndān míngliǎo, lián gāng shàngxué de xiǎopéngyou dōu néng qīngsōng kàn dǒng.",
          "translation_vi": "Các bước giải của bài toán này cực kỳ đơn giản dễ hiểu, ngay cả em nhỏ vừa mới đi học cũng đều có thể dễ dàng xem hiểu.",
          "explanation": "\"连刚上学的小朋友都...\" đưa ra em nhỏ làm đối tượng tối thiểu để nhấn mạnh bài toán rất dễ."
        },
        {
          "chinese": "他今天从早到晚连续做了好几场复杂的大手术，累得连晚饭都顾不上吃。",
          "pinyin": "Tā jīntiān cóng zǎo dào wǎn liánxù zuò le hǎo jǐ chǎng fùzá de dà shǒushù, lèi de lián wǎnfàn dōu gù bu shàng chī.",
          "translation_vi": "Hôm nay từ sáng đến tối anh ấy liên tục làm mấy ca đại phẫu phức tạp, mệt tới mức ngay cả cơm tối cũng không màng ăn nổi.",
          "explanation": "\"连晚饭都顾不上吃\" nhấn mạnh sự bận rộn vất vả cực độ."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 78,
      "name": "Đại từ nghi vấn phiếm chỉ toàn bộ \"Ai / Cái gì / Ở đâu + 都 / 也 + Vị ngữ\"",
      "pattern": "谁 / 什么 / 哪里 / 怎么 + 都 / 也 + Vị ngữ",
      "category": "Đại từ",
      "explanation_vi": "Khi các đại từ nghi vấn (谁: ai, 什么: cái gì, 哪儿/哪里: ở đâu, 怎么: thế nào) đi cùng phó từ \"都\" hoặc \"也\" trong câu khẳng định hoặc phủ định, chúng mất đi chức năng hỏi mà trở thành đại từ phiếm chỉ biểu thị tính toàn thể hoặc phủ định sạch trơn (ai cũng, cái gì cũng không, đi đâu cũng...).",
      "examples": [
        {
          "chinese": "李老师为人谦逊和蔼、知识渊博，全校谁都很尊敬他、爱戴他。",
          "pinyin": "Lǐ lǎoshī wéirén qiānxùn hé'ǎi, zhīshi yuānbó, quán xiào shéi dōu hěn zūnjìng tā, àidài tā.",
          "translation_vi": "Thầy Lý đối nhân xử thế khiêm tốn hòa nhã, tri thức uyên bác, toàn trường ai ai cũng đều rất tôn kính và yêu mến thầy.",
          "explanation": "\"谁都很尊敬\" biểu thị tất cả mọi người trong trường không trừ một ai."
        },
        {
          "chinese": "在异国他乡初来乍到，他人生地不熟，哪里也没有去过。",
          "pinyin": "Zài yìguó-tāxiāng chūlái-zhàodào, tā rénshēng-dìbùshú, nǎlǐ yě méiyǒu qù guo.",
          "translation_vi": "Mới chân ướt chân ráo đến nơi đất khách quê người, anh ấy người lạ nước lạ, ở đâu cũng đều chưa từng đi qua.",
          "explanation": "\"哪里也没有去过\" phủ định toàn bộ các địa điểm."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 79,
      "name": "Cấu trúc bổ ngữ trạng thái kép nhấn mạnh kết quả \"Động từ + 得 + Tân ngữ + Vị ngữ\"",
      "pattern": "Chủ ngữ + Động từ + 得 + Tân ngữ bị ảnh hưởng + Vị ngữ kết quả",
      "category": "Cấu trúc câu",
      "explanation_vi": "Cấu trúc phức hợp \"Động từ + 得 + Tân ngữ + Vị ngữ\" là dạng nâng cao của bổ ngữ trạng thái, trong đó thành phần sau \"得\" là một cụm chủ vị hoàn chỉnh miêu tả mức độ hoặc kết quả mà hành động gây ra cho đối tượng tiếp nhận (làm đến mức mà đối tượng bị như thế nào).",
      "examples": [
        {
          "chinese": "晚会上相声演员幽默风趣的精彩表演，逗得全场观众捧腹大笑、眼泪直流。",
          "pinyin": "Wǎnhuì shang xiàngsheng yǎnyuán yōumò fēngqù de jīngcǎi biǎoyǎn, dòu de quánchǎng guānzhòng pěngfù-dàxiào, yǎnlèi zhí liú.",
          "translation_vi": "Màn biểu diễn đặc sắc dí dỏm hài hước của diễn viên tướng thanh trong đêm tiệc đã chọc cho toàn thể khán giả cười nghiêng ngả ôm bụng, nước mắt trào ra.",
          "explanation": "\"逗得全场观众捧腹大笑\" miêu tả kết quả khán giả cười nghiêng ngả do sự hài hước gây nên."
        },
        {
          "chinese": "经过连续几个小时烈日下的高强度长跑训练，累得队员们双腿发软直不起腰来。",
          "pinyin": "Jīngguò liánxù jǐ gè xiǎoshí lièrì xià de gāo qiángdù chángpǎo xùnliàn, lèi de duìyuán men shuāngtuǐ fāruǎn zhí bu qǐ yāo lái.",
          "translation_vi": "Trải qua nhiều giờ tập luyện chạy dài cường độ cao liên tục dưới nắng gắt, mệt đến mức hai chân các đội viên bủn rủn không sao đứng thẳng lưng lên nổi.",
          "explanation": "\"累得队员们双腿发软\" làm rõ trạng thái kiệt sức của các đội viên sau buổi tập."
        }
      ],
      "hsk_level": "HSK 3",
      "source": "gf0025_2021",
      "validation_status": "verified"
    }
  ],
  "HSK 4": [
    {
      "order_index": 1,
      "name": "Đại từ phân phối \"各\" (Từng / Mỗi / Các)",
      "pattern": "各 + Danh từ / Lượng từ + Danh từ",
      "category": "Đại từ",
      "explanation_vi": "\"各\" (gè) biểu thị từng cá thể riêng biệt trong một tổng thể hoặc các phương diện, các bên khác nhau. \"各\" có thể trực tiếp kết hợp với danh từ song âm tiết (như 各国, 各地, 各界) hoặc đi kèm lượng từ trước danh từ đơn âm tiết (各个, 各门). Khác với \"每\" nhấn mạnh tính đồng nhất của mọi cá thể, \"各\" nhấn mạnh tính độc lập, riêng rẽ của từng đối tượng.",
      "examples": [
        {
          "chinese": "代表们来自世界各国，共同探讨环境保护问题。",
          "pinyin": "Dàibiǎomen láizì shìjiè gèguó, gòngtóng tàntǎo huánjìng bǎohù wèntí.",
          "translation_vi": "Các đại biểu đến từ các quốc gia trên thế giới, cùng nhau thảo luận về vấn đề bảo vệ môi trường.",
          "explanation": "\"各\" trực tiếp đứng trước danh từ song âm tiết \"国\" (quốc gia) tạo thành \"各国\" chỉ từng quốc gia khác nhau trên thế giới."
        },
        {
          "chinese": "每个人都有自己的优点，各有各的长处。",
          "pinyin": "Měi gè rén dōu yǒu zìjǐ de yōudiǎn, gè yǒu gè de chángchù.",
          "translation_vi": "Mỗi người đều có ưu điểm riêng, ai cũng có sở trường của riêng mình.",
          "explanation": "Cấu trúc \"各有各的 + Danh từ\" là cách dùng khẩu ngữ cố định biểu thị mỗi người/mỗi bên đều có phần riêng của mình."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 2,
      "name": "Đại từ phiếm chỉ không xác định \"某\" (Nào đó / Ai đó / Chỗ nào đó)",
      "pattern": "某 + Lượng từ + Danh từ / 某人 / 某地 / 某事",
      "category": "Đại từ",
      "explanation_vi": "\"某\" (mǒu) dùng để chỉ người, sự vật, thời gian hoặc nơi chốn chưa xác định rõ hoặc không tiện nêu đích danh cụ thể. Khi đi với danh từ đơn âm tiết hoặc song âm tiết, thường dùng \"某 + Lượng từ + Danh từ\" (như 某种原因, 某一天) hoặc ghép thẳng (某人, 某市, 某校).",
      "examples": [
        {
          "chinese": "由于某种特殊原因，明天的会议需要推迟举行。",
          "pinyin": "Yóuyú mǒu zhǒng tèshū yuányīn, míngtiān de huìyì xūyào tuīchí jǔxíng.",
          "translation_vi": "Do một nguyên nhân đặc biệt nào đó, cuộc họp ngày mai cần phải hoãn lại.",
          "explanation": "\"某\" kết hợp với lượng từ \"种\" và danh từ \"原因\" để chỉ lý do không tiện nói rõ tên cụ thể."
        },
        {
          "chinese": "这篇小说的主要故事发生在北方的某座城市。",
          "pinyin": "Zhè piān xiǎoshuō de zhǔyào gùshì fāshēng zài běifāng de mǒu zuò chéngshì.",
          "translation_vi": "Câu chuyện chính của cuốn tiểu thuyết này xảy ra ở một thành phố nào đó ở miền Bắc.",
          "explanation": "\"某座城市\" biểu thị một thành phố phiếm chỉ, tác giả không muốn chỉ đích danh địa danh."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 3,
      "name": "Đại từ chỉ thị \"本\" chỉ bản thân hoặc hiện tại (Này / Bản...)",
      "pattern": "本 + Danh từ (本人 / 本地 / 本市 / 本课 / 本报)",
      "category": "Đại từ",
      "explanation_vi": "\"本\" (běn) trong văn viết hoặc phong cách trang trọng đóng vai trò như đại từ chỉ thị tương đương với \"这\" (này) hoặc \"自己\" (bản thân). Thường kết hợp trực tiếp với danh từ đơn âm tiết hoặc song âm tiết như 本人 (bản thân tôi/đương sự), 本地 (địa phương này), 本世纪 (thế kỷ này), 本文 (bài viết này).",
      "examples": [
        {
          "chinese": "这项优惠活动仅对本校学生和教职工有效。",
          "pinyin": "Zhè xiàng yōuhuì huódòng jǐn duì běnxiào xuésheng hé jiàozhígōng yǒuxiào.",
          "translation_vi": "Chương trình ưu đãi này chỉ có hiệu lực đối với học sinh và cán bộ giảng viên của trường này.",
          "explanation": "\"本校\" có nghĩa là trường này (ngôi trường của người nói/người viết), mang sắc thái trang trọng."
        },
        {
          "chinese": "如果需要办理签证，必须由申请人本人亲自到场。",
          "pinyin": "Rúguǒ xūyào bànlǐ qiānzhèng, bìxū yóu shēnqǐngrén běnrén qīnzì dàochǎng.",
          "translation_vi": "Nếu cần làm thủ tục xin thị thực, bắt buộc đích thân đương sự phải có mặt.",
          "explanation": "\"本人\" nhấn mạnh chính bản thân người nộp đơn, không thể ủy quyền cho người khác."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 4,
      "name": "Đại từ hỗ tương \"彼此\" (Lẫn nhau / Đôi bên / Cả hai)",
      "pattern": "Chủ ngữ (số nhiều) + 彼此 + Động từ / 彼此的 + Danh từ / 彼此彼此",
      "category": "Đại từ",
      "explanation_vi": "\"彼此\" (bǐcǐ) biểu thị quan hệ qua lại giữa hai hoặc nhiều bên đối tác (cả hai phía, lẫn nhau). Thường làm chủ ngữ, tân ngữ, định ngữ hoặc trạng ngữ. Trong giao tiếp lịch sự, nói \"彼此彼此\" mang hàm ý khiêm tốn đáp lại lời khen ngợi (hai bên đều như nhau cả thôi).",
      "examples": [
        {
          "chinese": "朋友之间应该互相尊重，理解彼此的想法。",
          "pinyin": "Péngyou zhījiān yīnggāi hùxiāng zūnzhòng, lǐjiě bǐcǐ de xiǎngfǎ.",
          "translation_vi": "Bạn bè với nhau nên tôn trọng lẫn nhau, thấu hiểu suy nghĩ của nhau.",
          "explanation": "\"彼此的想法\" nghĩa là ý nghĩ của đôi bên, \"彼此\" đứng làm định ngữ hạn định cho \"想法\"."
        },
        {
          "chinese": "他们多年不见，但彼此依然十分信任。",
          "pinyin": "Tāmen duō nián bú jiàn, dàn bǐcǐ yīrán shífēn xìnrèn.",
          "translation_vi": "Họ nhiều năm không gặp, nhưng đôi bên vẫn hết sức tin tưởng lẫn nhau.",
          "explanation": "\"彼此\" làm trạng ngữ đứng trước động từ \"信任\" để biểu thị sự tin tưởng hai chiều."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 5,
      "name": "Đại từ phiếm chỉ toàn thể vô điều kiện \"任何\" (Bất kỳ / Bất luận)",
      "pattern": "任何 + (Lượng từ) + Danh từ + 都 / 也",
      "category": "Đại từ",
      "explanation_vi": "\"任何\" (rènhé) là đại từ phiếm chỉ mang nghĩa không phân biệt đối tượng nào, bất kể sự vật hay con người nào trong phạm vi thảo luận. Thường kết hợp với \"都\" hoặc \"也\" ở vế sau để nhấn mạnh tính phổ quát tuyệt đối.",
      "examples": [
        {
          "chinese": "无论面对任何困难，我们都不应该轻易放弃。",
          "pinyin": "Wúlùn miànduì rènhé kùnnan, wǒmen dōu bù yīnggāi qīngyì fàngqì.",
          "translation_vi": "Bất luận đối mặt với bất kỳ khó khăn nào, chúng ta cũng không nên dễ dàng bỏ cuộc.",
          "explanation": "\"任何困难\" (bất kỳ khó khăn nào) kết hợp với \"无论...都...\" khẳng định quyết tâm kiên trì không có ngoại lệ."
        },
        {
          "chinese": "在法律面前，没有任何人享有特权。",
          "pinyin": "Zài fǎlǜ miànqián, méiyǒu rènhé rén xiǎngyǒu tèquán.",
          "translation_vi": "Trước pháp luật, không có bất kỳ ai được hưởng đặc quyền.",
          "explanation": "\"没有任何人\" phủ định hoàn toàn sự tồn tại của bất kỳ đối tượng ngoại lệ nào."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 6,
      "name": "Đại từ bao quát toàn bộ \"一切\" (Tất cả / Toàn bộ mọi thứ)",
      "pattern": "一切 + Danh từ / Danh từ + (的) 一切 / 一切 + 都...",
      "category": "Đại từ",
      "explanation_vi": "\"一切\" (yíqiè) là đại từ chỉ toàn bộ sự vật, hiện tượng hoặc phương diện (mọi thứ, tất cả). \"一切\" có thể làm chủ ngữ đứng độc lập, làm định ngữ (一切困难, 一切费用) hoặc làm tân ngữ (安排好了一切). Khác với \"所有\", \"一切\" thiên về tính chất trừu tượng và toàn diện.",
      "examples": [
        {
          "chinese": "请大家放心，我们已经为这次活动准备好了一切。",
          "pinyin": "Qǐng dàjiā fàngxīn, wǒmen yǐjīng wèi zhè cì huódòng zhǔnbèi hǎo le yíqiè.",
          "translation_vi": "Xin mọi người hãy yên tâm, chúng tôi đã chuẩn bị xong xuôi mọi thứ cho sự kiện lần này.",
          "explanation": "\"一切\" làm tân ngữ cho cụm động từ \"准备好\", bao gồm tất cả các khâu chuẩn bị cần thiết."
        },
        {
          "chinese": "为了孩子的健康成长，父母愿意付出自己的一切。",
          "pinyin": "Wèile háizi de jiànkāng chéngzhǎng, fùmǔ yuànyì fùchū zìjǐ de yíqiè.",
          "translation_vi": "Vì sự trưởng thành khỏe mạnh của con cái, cha mẹ sẵn lòng hy sinh tất cả của bản thân.",
          "explanation": "\"自己的一切\" là cụm định tâm thể hiện toàn bộ công sức, thời gian và tình cảm của cha mẹ."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 7,
      "name": "Đại từ phản thân tự thân \"自身\" (Bản thân / Chính mình)",
      "pattern": "自身 + Danh từ / Động từ + 自身 / Chủ ngữ + 自身",
      "category": "Đại từ",
      "explanation_vi": "\"自身\" (zìshēn) là đại từ chỉ bản thân chủ thể hoặc phẩm chất nội tại của một sự vật, cơ quan, tổ chức. So với \"自己\", \"自身\" mang sắc thái văn viết trang trọng hơn, thường dùng khi phân tích năng lực nội tại, sự phát triển hoặc nhược điểm của sự vật.",
      "examples": [
        {
          "chinese": "企业要想在竞争中立足，必须不断提高自身的产品质量。",
          "pinyin": "Qǐyè yào xiǎng zài jìngzhēng zhōng lìzú, bìxū búduàn tígāo zìshēn de chǎnpǐn zhìliàng.",
          "translation_vi": "Doanh nghiệp muốn đứng vững trong cạnh tranh, bắt buộc phải không ngừng nâng cao chất lượng sản phẩm của chính mình.",
          "explanation": "\"自身的产品质量\" nhấn mạnh năng lực và chất lượng nội tại xuất phát từ chính doanh nghiệp."
        },
        {
          "chinese": "很多时候，我们最大的敌人其实正是我们自身。",
          "pinyin": "Hěn duō shíhou, wǒmen zuì dà de dírén qíshí zhèng shì wǒmen zìshēn.",
          "translation_vi": "Rất nhiều khi, kẻ thù lớn nhất của chúng ta trên thực tế chính là bản thân chúng ta.",
          "explanation": "\"自身\" ở đây nhấn mạnh sự tự nhận thức và khắc phục nhược điểm của chính bản thân con người."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 8,
      "name": "Biểu thị phân số và phần trăm với \"百分之...\" / \"...分之...\"",
      "pattern": "Mẫu số + 分之 + Tử số (百分之八十 / 三分之二)",
      "category": "Số từ",
      "explanation_vi": "Trong tiếng Trung, quy tắc biểu thị phân số và tỉ lệ phần trăm tuân thủ nguyên tắc: đọc mẫu số trước rồi đến \"分之\" (fēn zhī), sau đó mới đọc tử số. Ví dụ: 1/3 đọc là \"三分之一\", 85% đọc là \"百分之八十五\".",
      "examples": [
        {
          "chinese": "调查显示，有百分之七十的年轻人习惯在网上购物。",
          "pinyin": "Diàochá xiǎnshì, yǒu bǎi fēn zhī qīshí de niánqīngrén xíguàn zài wǎngshang gòuwù.",
          "translation_vi": "Khảo sát cho thấy có 70% người trẻ tuổi có thói quen mua sắm trực tuyến.",
          "explanation": "\"百分之七十\" (70%) là cấu trúc chuẩn để biểu đạt tỷ lệ phần trăm trong tiếng Trung hiện đại."
        },
        {
          "chinese": "这本厚书我已经读了三分之二，内容非常精彩。",
          "pinyin": "Zhè běn hòu shū wǒ yǐjīng dú le sān fēn zhī èr, nèiróng fēicháng jīngcǎi.",
          "translation_vi": "Cuốn sách dày này tôi đã đọc được hai phần ba rồi, nội dung vô cùng hấp dẫn.",
          "explanation": "\"三分之二\" (2/3) thể hiện tiến độ đọc sách, trong đó mẫu số là 3 (三) và tử số là 2 (二)."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 9,
      "name": "Biểu thị bội số với \"倍\" (Lần / Gấp... lần)",
      "pattern": "A 是 B 的 + Số từ + 倍 / A 比 B + Tăng/Giảm + Số từ + 倍",
      "category": "Số từ",
      "explanation_vi": "\"倍\" (bèi) biểu thị số lần gấp lên của một đại lượng so với một đại lượng khác. Lưu ý: Tiếng Trung chỉ dùng \"倍\" cho sự tăng trưởng (tăng gấp bội), không dùng \"倍\" cho sự giảm bớt (khi giảm phải dùng phân số hoặc phần trăm). Khi nói \"A 是 B 的两倍\" nghĩa là A = 2B; còn \"A 比 B 增加了一倍\" cũng có nghĩa là A = 2B.",
      "examples": [
        {
          "chinese": "今年公司的营业额是去年的三倍，成绩十分显著。",
          "pinyin": "Jīnnián gōngsī de yíngyè'é shì qùnián de sān bèi, chéngjì shífēn xiǎnzhù.",
          "translation_vi": "Doanh thu năm nay của công ty gấp 3 lần năm ngoái, thành tích rất nổi bật.",
          "explanation": "Cấu trúc so sánh bội số \"A 是 B 的三倍\" biểu thị doanh số năm nay bằng 3 lần doanh số năm ngoái."
        },
        {
          "chinese": "采用了新技术后，工厂的生产效率提高了一倍。",
          "pinyin": "Cǎiyòng le xīn jìshù hòu, gōngchǎng de shēngchǎn xiàolǜ tígāo le yí bèi.",
          "translation_vi": "Sau khi áp dụng kỹ thuật mới, hiệu suất sản xuất của nhà máy đã tăng lên gấp đôi.",
          "explanation": "\"提高了一倍\" nghĩa là hiệu suất tăng thêm 100%, tức đạt mức gấp 2 lần ban đầu."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 10,
      "name": "Động lượng từ chỉ chuyến đi khứ hồi \"趟\" (Chuyến / Lượt)",
      "pattern": "Động từ (去/来/跑/走) + (Số từ) + 趟",
      "category": "Lượng từ",
      "explanation_vi": "\"趟\" (tàng) là động lượng từ chuyên dùng cho các hành động đi lại di chuyển khứ hồi (đi rồi về) hoặc chuyến xe/tàu. Khác với \"次\" (chỉ số lần phát sinh chung của mọi hành vi), \"趟\" bắt buộc gắn liền với hành động dịch chuyển vị trí thực tế của con người hoặc phương tiện giao thông.",
      "examples": [
        {
          "chinese": "为了办理护照，他昨天特意去了一趟出入境管理局。",
          "pinyin": "Wèile bànlǐ hùzhào, tā zuótiān tèyì qù le yí tàng chūrùjìng guǎnlǐjú.",
          "translation_vi": "Để làm hộ chiếu, hôm qua anh ấy đã đặc biệt đi đến Cục Quản lý Xuất Nhập cảnh một chuyến.",
          "explanation": "\"去了一趟\" chỉ chuyến đi đến cơ quan nhà nước giải quyết thủ tục rồi quay về."
        },
        {
          "chinese": "我们明天清晨坐最早一趟高铁去上海出差。",
          "pinyin": "Wǒmen míngtiān qīngchén zuò zuì zǎo yí tàng gāotiě qù Shànghǎi chūchāi.",
          "translation_vi": "Sáng sớm mai chúng tôi sẽ đi chuyến tàu cao tốc sớm nhất để đến Thượng Hải công tác.",
          "explanation": "\"一趟高铁\" dùng \"趟\" làm danh lượng từ để chỉ chuyến tàu vận tải hành khách."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 11,
      "name": "Danh lượng từ chuyên dùng cho bài viết, văn kiện \"篇\" (Bài / Thiên)",
      "pattern": "Số từ + 篇 + Danh từ (文章 / 论文 / 报道 / 日记 / 课文)",
      "category": "Lượng từ",
      "explanation_vi": "\"篇\" (piān) là lượng từ chuyên dụng dành cho các tác phẩm văn học, bài văn, bài báo, luận văn hoặc bài phát biểu hoàn chỉnh bằng chữ viết.",
      "examples": [
        {
          "chinese": "经过一个星期的努力，王教授终于完成了那篇学术论文。",
          "pinyin": "Jīngguò yí gè xīngqī de nǔlì, Wáng jiàoshòu zhōngyú wánchéng le nà piān xuéshù lùnwén.",
          "translation_vi": "Sau một tuần nỗ lực, giáo sư Vương cuối cùng đã hoàn thành bài luận văn học thuật đó.",
          "explanation": "\"篇\" làm lượng từ chuẩn đi kèm với danh từ học thuật \"论文\" (luận văn)."
        },
        {
          "chinese": "今天的报纸上刊登了一篇关于人工智能发展的特别报道。",
          "pinyin": "Jīntiān de bàozhǐ shang kāndēng le yì piān guānyú réngōng zhìnéng fāzhǎn de tèbié bàodào.",
          "translation_vi": "Trên tờ báo hôm nay có đăng một bài phóng sự đặc biệt về sự phát triển của trí tuệ nhân tạo.",
          "explanation": "\"一篇...报道\" dùng \"篇\" định lượng cho bài tin tức/phóng sự hoàn chỉnh trên báo in."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 12,
      "name": "Danh lượng từ chỉ phần, bản, suất \"份\" (Phần / Bản / Suất)",
      "pattern": "Số từ + 份 + Danh từ (报纸 / 礼物 / 工作 / 菜单 / 文件 / 早餐)",
      "category": "Lượng từ",
      "explanation_vi": "\"份\" (fèn) biểu thị một phần được chia ra từ một tổng thể, một ấn phẩm định kỳ (như báo chí), một tài liệu hành chính, một suất ăn hoặc một công việc/tình cảm mang tính chất trao tặng.",
      "examples": [
        {
          "chinese": "毕业之后，他凭借优秀的专业能力顺利找到了一份满意的工作。",
          "pinyin": "Bìyè zhīhòu, tā píngjiè yōuxiù de zhuānyè nénglì shùnlì zhǎodào le yí fèn mǎnyì de gōngzuò.",
          "translation_vi": "Sau khi tốt nghiệp, nhờ năng lực chuyên môn xuất sắc anh ấy đã thuận lợi tìm được một công việc ưng ý.",
          "explanation": "\"一份工作\" là cách dùng lượng từ \"份\" kết hợp chuẩn xác với \"工作\" (công việc)."
        },
        {
          "chinese": "服务员，请给我们拿一份菜单和两份特色早餐。",
          "pinyin": "Fúwùyuán, qǐng gěi wǒmen ná yí fèn càidān hé liǎng fèn tèsè zǎocān.",
          "translation_vi": "Phục vụ ơi, xin hãy lấy cho chúng tôi một cuốn thực đơn và hai phần bữa sáng đặc sản.",
          "explanation": "\"一份菜单\" (một cuốn thực đơn) và \"两份早餐\" (hai suất ăn sáng) dùng \"份\" chuẩn xác."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 13,
      "name": "Danh lượng từ chỉ khóa, kỳ, nhiệm kỳ \"届\" (Khóa / Kỳ / Lần)",
      "pattern": "Số thứ tự / Số từ + 届 + Danh từ (奥运会 / 毕业生 / 会议 / 比赛)",
      "category": "Lượng từ",
      "explanation_vi": "\"届\" (jiè) là lượng từ chuyên dùng cho các sự kiện định kỳ quy mô lớn diễn ra theo từng nhiệm kỳ, khóa học, đại hội thể thao, hoặc các hội nghị thường niên có đánh số thứ tự.",
      "examples": [
        {
          "chinese": "北京成功举办了第二十九届夏季奥林匹克运动会。",
          "pinyin": "Běijīng chénggōng jǔbàn le dì èrshíjiǔ jiè xiàjì àolínpǐkè yùndònghuì.",
          "translation_vi": "Bắc Kinh đã tổ chức thành công Thế vận hội Olympic Mùa hè lần thứ 29.",
          "explanation": "\"第二十九届\" chỉ kỳ thế vận hội thứ 29, \"届\" là lượng từ chuẩn xác cho các sự kiện thể thao/đại hội quốc tế."
        },
        {
          "chinese": "作为本届毕业生代表，她在毕业典礼上发表了感人的演讲。",
          "pinyin": "Zuòwéi běnjiè bìyèshēng dàibiǎo, tā zài bìyè diǎnlǐ shang fābiǎo le gǎnrén de yǎnjiǎng.",
          "translation_vi": "Với tư cách là đại biểu của khóa tốt nghiệp năm nay, cô ấy đã phát biểu một bài diễn văn xúc động tại lễ tốt nghiệp.",
          "explanation": "\"本届毕业生\" chỉ tập thể sinh viên của khóa ra trường hiện tại."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 14,
      "name": "Danh lượng từ chỉ cọng, que, sợi \"根\" (Cọng / Que / Sợi / Cây)",
      "pattern": "Số từ + 根 + Danh từ (头发 / 香蕉 / 绳子 / 筷子 / 针 / 黄瓜)",
      "category": "Lượng từ",
      "explanation_vi": "\"根\" (gēn) dùng để chỉ những đồ vật dài, mảnh, thon và tương đối dẻo hoặc có hình trụ nhỏ như sợi tóc, que diêm, quả chuối, cây kim, sợi dây thừng, chiếc đũa.",
      "examples": [
        {
          "chinese": "他在镜子前整理头发，发现自己长出了一根白发。",
          "pinyin": "Tā zài jìngzi qián zhěnglǐ tóufa, fāxiàn zìjǐ zhǎngchū le yì gēn báifà.",
          "translation_vi": "Anh ấy đứng trước gương chải tóc và phát hiện mình đã mọc một sợi tóc bạc.",
          "explanation": "\"一根白发\" dùng \"根\" chỉ một sợi tóc dài mỏng."
        },
        {
          "chinese": "桌子上放着一根新鲜的香蕉和几根黄瓜。",
          "pinyin": "Zhuōzi shang fàngzhe yì gēn xīnxiān de xiāngjiāo hé jǐ gēn huángguā.",
          "translation_vi": "Trên bàn có đặt một quả chuối tươi và mấy quả dưa chuột.",
          "explanation": "Trong tiếng Trung, hoa quả hình trụ thon dài như chuối (香蕉) hoặc dưa leo (黄瓜) đều dùng lượng từ \"根\"."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 15,
      "name": "Danh lượng từ chỉ hạt, viên, đồ vật nhỏ tròn \"颗\" (Viên / Hạt / Ngôi)",
      "pattern": "Số từ + 颗 + Danh từ (星星 / 药 / 心 / 种子 / 葡萄 / 牙齿)",
      "category": "Lượng từ",
      "explanation_vi": "\"颗\" (kē) dùng cho các vật thể có hình hạt, viên nhỏ, tròn hoặc tương đối tròn như hạt cây, viên thuốc, hạt ngọc, ngôi sao, viên kẹo, hoặc trái tim.",
      "examples": [
        {
          "chinese": "夜晚的天空十分晴朗，天空中闪烁着几颗明亮的星星。",
          "pinyin": "Yèwǎn de tiānkōng shífēn qínglǎng, tiānkōng zhōng shǎnshuòzhe jǐ kē míngliàng de xīngxing.",
          "translation_vi": "Bầu trời đêm rất quang đãng, trên không trung lấp lánh mấy ngôi sao sáng.",
          "explanation": "\"几颗...星星\" dùng \"颗\" để chỉ các vì tinh tú trên bầu trời."
        },
        {
          "chinese": "医生叮嘱他饭后按时吃两颗感冒药。",
          "pinyin": "Yīshēng dīngzhǔ tā fànhòu ànshí chī liǎng kē gǎnmàoyào.",
          "translation_vi": "Bác sĩ dặn dò anh ấy sau bữa ăn hãy uống đúng giờ hai viên thuốc cảm.",
          "explanation": "\"两颗感冒药\" dùng \"颗\" định lượng cho viên thuốc nén hoặc thuốc con nhộng hình hạt tròn."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 16,
      "name": "Danh lượng từ chỉ cây cỏ thực vật \"棵\" (Cây / Gốc)",
      "pattern": "Số từ + 棵 + Danh từ (树 / 草 / 白菜 / 牡丹)",
      "category": "Lượng từ",
      "explanation_vi": "\"棵\" (kē) là lượng từ chuyên dùng cho cây cối, thực vật mọc từ đất lên (khác với \"颗\" dùng cho vật nhỏ tròn dạng hạt/viên).",
      "examples": [
        {
          "chinese": "我们学校图书馆门前种着一棵百年的古老银杏树。",
          "pinyin": "Wǒmen xuéxiào túshūguǎn ménqián zhòngzhe yì kē bǎinián de gǔlǎo yínxìngshù.",
          "translation_vi": "Trước cửa thư viện trường chúng tôi có trồng một cây ngân hạnh cổ thụ trăm năm tuổi.",
          "explanation": "\"一棵...银杏树\" dùng \"棵\" (bộ Mộc 木) làm lượng từ chỉ cây đại thụ."
        },
        {
          "chinese": "爷爷在院子里亲手种了几棵绿色的蔬菜。",
          "pinyin": "Yéye zài yuànzi lǐ qīnshǒu zhòng le jǐ kē lǜsè de shūcài.",
          "translation_vi": "Ông nội đã tự tay trồng mấy luống cây rau xanh trong sân nhà.",
          "explanation": "\"几棵...蔬菜\" chỉ các cây rau xanh đơn lẻ mọc trong vườn."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 17,
      "name": "Danh lượng từ chỉ giọt chất lỏng \"滴\" (Giọt)",
      "pattern": "Số từ + 滴 + Danh từ (水 / 眼泪 / 汗 / 汗水 / 油 / 血)",
      "category": "Lượng từ",
      "explanation_vi": "\"滴\" (dī) biểu thị đơn vị giọt của chất lỏng. Ngoài ra \"滴\" cũng có thể đóng vai trò làm động từ mang nghĩa nhỏ giọt (滴水). Khi dùng làm lượng từ, \"一滴\" thường được dùng để nhấn mạnh số lượng nhỏ bé, quý giá.",
      "examples": [
        {
          "chinese": "在干旱的沙漠里，每一滴水都显得无比珍贵。",
          "pinyin": "Zài gānhàn de shāmò lǐ, měi yì dī shuǐ dōu xiǎnde wúbǐ zhēnguì.",
          "translation_vi": "Ở nơi sa mạc khô hạn, từng giọt nước đều trở nên vô cùng quý giá.",
          "explanation": "\"每一滴水\" dùng \"滴\" làm lượng từ biểu thị từng giọt nước nhỏ nhoi."
        },
        {
          "chinese": "看到儿子顺利考上理想的大学，母亲流下了激动的眼泪。",
          "pinyin": "Kàndào érzi shùnlì kǎoshàng lǐxiǎng de dàxué, mǔqīn liúxià le jīdòng de yǎnlèi.",
          "translation_vi": "Nhìn thấy con trai thi đỗ vào trường đại học mơ ước, người mẹ đã rơi những giọt nước mắt xúc động.",
          "explanation": "\"滴\" kết hợp cùng \"眼泪\" diễn tả giọt lệ xúc động trong tình huống gia đình sum vầy."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 18,
      "name": "Danh lượng từ chỉ bầy, đàn, đám \"群\" (Bầy / Đàn / Đám / Nhóm)",
      "pattern": "Số từ / 一 + 群 + Danh từ (人 / 孩子 / 羊 / 鸟 / 鸭子)",
      "category": "Lượng từ",
      "explanation_vi": "\"群\" (qún) là lượng từ tập hợp dùng cho một nhóm đông người tụ họp lại, hoặc một đàn động vật/chim chóc cùng di chuyển hoặc sinh sống cùng nhau.",
      "examples": [
        {
          "chinese": "放学后，一群活泼可爱的小学生唱着歌走出了校门。",
          "pinyin": "Fàngxué hòu, yì qún huópo kě'ài de xiǎoxuéshēng chàngzhe gē zǒuchū le xiàomén.",
          "translation_vi": "Sau khi tan học, một nhóm học sinh tiểu học hồn nhiên đáng yêu vừa hát vừa bước ra cổng trường.",
          "explanation": "\"一群...小学生\" chỉ một nhóm đông các em học sinh đi cùng nhau."
        },
        {
          "chinese": "在辽阔的草原上，有一大群羊正在安详地吃草。",
          "pinyin": "Zài liáokuò de cǎoyuán shang, yǒu yí dà qún yáng zhèngzài ānxiáng de chī cǎo.",
          "translation_vi": "Trên thảo nguyên bao la, có một đàn cừu lớn đang thong thả gặm cỏ.",
          "explanation": "\"一大群羊\" diễn tả số lượng bầy cừu đông đảo trên đồng cỏ."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 19,
      "name": "Danh lượng từ chỉ đống, chồng bừa bộn \"堆\" (Đống / Chồng)",
      "pattern": "Số từ / 一 + 堆 + Danh từ (书 / 垃圾 / 衣服 / 问题 / 事情)",
      "category": "Lượng từ",
      "explanation_vi": "\"堆\" (duī) biểu thị số lượng nhiều sự vật chất chồng lên nhau thành đống. Ngoài việc chỉ các vật thể cụ thể (như sách vở, quần áo, rác), \"堆\" còn dùng cho các sự việc trừu tượng (như 一堆问题, 一堆麻烦) với sắc thái bận rộn hoặc bừa bộn.",
      "examples": [
        {
          "chinese": "桌子上堆满了各种文件，还有一大堆待处理的工作。",
          "pinyin": "Zhuōzi shang duīmǎn le gè zhǒng wénjiàn, hái yǒu yí dà duī dài chǔlǐ de gōngzuò.",
          "translation_vi": "Trên bàn chất đầy đủ loại tài liệu, và còn có một đống công việc đang chờ xử lý.",
          "explanation": "\"一大堆待处理的工作\" dùng \"堆\" ẩn dụ cho khối lượng công việc bề bộn dồn lại."
        },
        {
          "chinese": "请大家把生活垃圾分类放好，不要在楼道里扔一堆垃圾。",
          "pinyin": "Qǐng dàjiā bǎ shēnghuó lājī fēnlèi fàng hǎo, bú yào zài lóudào lǐ rēng yì duī lājī.",
          "translation_vi": "Xin mọi người hãy phân loại rác sinh hoạt cẩn thận, không nên vứt một đống rác ở hành lang.",
          "explanation": "\"一堆垃圾\" chỉ đống rác thực tế bừa bãi chưa qua xử lý."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 20,
      "name": "Danh lượng từ chỉ hàng, dãy \"排\" (Hàng / Dãy)",
      "pattern": "Số từ + 排 + Danh từ (座位 / 树 / 房子 / 队伍)",
      "category": "Lượng từ",
      "explanation_vi": "\"排\" (pái) dùng cho người hoặc đồ vật được sắp xếp ngay ngắn theo một đường thẳng ngang hoặc dọc (như hàng ghế, hàng cây, dãy nhà, hàng người).",
      "examples": [
        {
          "chinese": "电影马上就要开场了，请大家按照票号找到第三排的座位。",
          "pinyin": "Diànyǐng mǎshàng jiù yào kāichǎng le, qǐng dàjiā ànzhào piàohào zhǎodào dì sān pái de zuòwèi.",
          "translation_vi": "Bộ phim sắp sửa bắt đầu rồi, xin mọi người hãy đối chiếu số vé để tìm chỗ ngồi ở hàng thứ ba.",
          "explanation": "\"第三排的座位\" dùng \"排\" xác định chính xác hàng ghế trong rạp chiếu phim."
        },
        {
          "chinese": "马路两旁种着两排整齐的白杨树，风景十分优美。",
          "pinyin": "Mǎlù liǎngpáng zhòngzhe liǎng pái zhěngqí de báiyángshù, fēngjǐng shífēn yōuměi.",
          "translation_vi": "Hai bên đường có trồng hai hàng cây bạch dương ngay ngắn, phong cảnh rất tươi đẹp.",
          "explanation": "\"两排整齐的白杨树\" dùng \"排\" để miêu tả các hàng cây thẳng tắp ven đường."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 21,
      "name": "Phó từ truy cứu đến cùng \"究竟\" (Rốt cuộc / Cuối cùng thì)",
      "pattern": "Chủ ngữ + 究竟 + Từ để hỏi / V_chính + 不 + V_chính / 究竟 + Sự thật/Nguyên nhân",
      "category": "Phó từ",
      "explanation_vi": "\"究竟\" (jiūjìng) dùng trong câu hỏi (câu hỏi có đại từ nghi vấn, câu hỏi chính phản hoặc lựa chọn) để tăng cường ngữ khí truy cứu, muốn tìm hiểu rõ chân tướng sự việc (rốt cuộc là sao). Ngoài ra, \"究竟\" trong câu trần thuật còn có nghĩa là \"cuối cùng/rốt cuộc thì\" (tương đương với 到头来, 到底). So với \"到底\", \"究竟\" trang trọng hơn và thường gặp trong văn viết.",
      "examples": [
        {
          "chinese": "关于那个神秘的项目，你究竟打听到了什么消息？",
          "pinyin": "Guānyú nà ge shénmì de xiàngmù, nǐ jiūjìng dǎtīng dào le shénme xiāoxi?",
          "translation_vi": "Liên quan đến dự án bí ẩn đó, rốt cuộc anh đã dò hỏi được tin tức gì rồi?",
          "explanation": "\"究竟\" đứng trước động từ trong câu hỏi có \"什么\" để nhấn mạnh sự truy hỏi đến cùng tin tức."
        },
        {
          "chinese": "面对这个问题，大家都很想知道究竟谁能够给出合理的答案。",
          "pinyin": "Miànduì zhè ge wèntí, dàjiā dōu hěn xiǎng zhīdào jiūjìng shéi nénggòu gěichū hélǐ de dá'àn.",
          "translation_vi": "Đối mặt với vấn đề này, mọi người đều rất muốn biết rốt cuộc ai có thể đưa ra đáp án thỏa đáng.",
          "explanation": "\"究竟谁\" làm rõ chủ thể giải quyết vấn đề, biểu thị tâm lý tò mò muốn biết rõ sự thật."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 22,
      "name": "Phó từ kết quả và nhấn mạnh ngữ khí \"到底\" (Rốt cuộc / Suy cho cùng / Đến cùng)",
      "pattern": "Chủ ngữ + 到底 + Câu hỏi / 坚持 + 到底 / 到底 + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"到底\" (dàodǐ) có ba cách dùng chính: 1) Trong câu hỏi biểu thị sự truy vấn rốt cuộc (khẩu ngữ dùng nhiều hơn 究竟); 2) Biểu thị làm một việc đến cùng không từ bỏ (như 坚持到底, 进行到底); 3) Trong câu trần thuật biểu thị nguyên nhân sâu xa hoặc bản chất thực sự (suy cho cùng thì: 他到底是孩子, 难免会犯错).",
      "examples": [
        {
          "chinese": "你不要再犹豫了，今天到底去还是不去？",
          "pinyin": "Nǐ bú yào zài yóuyù le, jīntiān dàodǐ qù háishì bú qù?",
          "translation_vi": "Cậu đừng do dự nữa, hôm nay rốt cuộc là đi hay không đi?",
          "explanation": "\"到底\" đặt trong câu hỏi lựa chọn \"去还是不去\" để thúc giục đối phương đưa ra quyết định dứt khoát."
        },
        {
          "chinese": "遇到困难时只要坚持到底，最终就一定会取得胜利。",
          "pinyin": "Yùdào kùnnan shí zhǐyào jiānchí dàodǐ, zuìzhōng jiù yídìng huì qǔdé shènglì.",
          "translation_vi": "Khi gặp khó khăn chỉ cần kiên trì đến cùng, cuối cùng nhất định sẽ giành được thắng lợi.",
          "explanation": "\"坚持到底\" là kết hợp quán dụng biểu thị hành động kiên trì tới bước cuối cùng."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 23,
      "name": "Phó từ phóng đại và nhấn mạnh cảm xúc \"简直\" (Quả là / Thật là / Hầu như)",
      "pattern": "Chủ ngữ + 简直 + (像/是/无法/太) + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"简直\" (jiǎnzhí) dùng để nhấn mạnh một trạng thái, mức độ đạt đến mức kinh ngạc, gần như hoàn toàn như vậy (thực sự là, quả thật là). Thường đi kèm với ngữ khí phóng đại để bày tỏ sự tán thưởng, ngạc nhiên hoặc bất bình.",
      "examples": [
        {
          "chinese": "仅仅用了半年时间他就掌握了汉语，这简直是一个奇迹。",
          "pinyin": "Jǐnjǐn yòng le bàn nián shíjiān tā jiù zhǎowò le hànyǔ, zhè jiǎnzhí shì yí gè qíjì.",
          "translation_vi": "Chỉ mất nửa năm anh ấy đã nắm vững tiếng Trung, điều này quả thực là một kỳ tích.",
          "explanation": "\"简直是一个奇迹\" phóng đại và khen ngợi năng lực tiếp thu ngoại ngữ phi thường."
        },
        {
          "chinese": "外面的天气太冷了，刺骨的寒风吹在脸上简直像刀割一样。",
          "pinyin": "Wàimiàn de tiānqì tài lěng le, cìgǔ de hánfēng chuī zài liǎn shang jiǎnzhí xiàng dāo gē yíyàng.",
          "translation_vi": "Thời tiết bên ngoài quá lạnh, gió lạnh thấu xương thổi vào mặt quả thật như dao cắt.",
          "explanation": "\"简直像...一样\" dùng \"简直\" kết hợp so sánh ví von để cực tả cảm giác buốt giá."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 24,
      "name": "Phó từ tỉnh ngộ và lý giải nguyên do \"难怪\" (Hèn chi / Thảo nào)",
      "pattern": "难怪 + Mệnh đề / Mệnh đề kết quả, 难怪 + Mệnh đề nguyên nhân",
      "category": "Phó từ",
      "explanation_vi": "\"难怪\" (nánguài) dùng khi người nói đột nhiên hiểu ra nguyên nhân thực sự của một hiện tượng hoặc kết quả nào đó sau khi biết được tình huống mới (thảo nào, hèn gì, chẳng trách). Có thể dùng đứng đầu câu hoặc giữa hai vế câu.",
      "examples": [
        {
          "chinese": "原来他在北京留学生活了五年，难怪普通话说得这么地道。",
          "pinyin": "Yuánlái tā zài Běijīng liúxué shēnghuó le wǔ nián, nánguài pǔtōnghuà shuō de zhème dìdao.",
          "translation_vi": "Thì ra anh ấy đã du học và sống ở Bắc Kinh 5 năm, hèn chi tiếng Phổ thông nói chuẩn như người bản xứ.",
          "explanation": "\"难怪\" đứng ở vế sau để bày tỏ sự vỡ lẽ khi biết lý do đối phương nói tiếng Trung xuất sắc."
        },
        {
          "chinese": "今天气温骤降了十度，难怪大家都穿上了厚羽绒服。",
          "pinyin": "Jīntiān qìwēn zhòujiàng le shí dù, nánguài dàjiā dōu chuānshàng le hòu yǔróngfú.",
          "translation_vi": "Hôm nay nhiệt độ đột ngột giảm 10 độ, thảo nào ai nấy đều mặc áo phao dày cộm.",
          "explanation": "\"难怪\" giải thích lý do mọi người đột ngột thay đổi trang phục vì thời tiết chuyển rét đậm."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 25,
      "name": "Phó từ đồng nghĩa khẩu ngữ \"怪不得\" (Hèn chi / Thảo nào / Chẳng trách)",
      "pattern": "怪不得 + Mệnh đề / Mệnh đề 1, 怪不得 + Mệnh đề 2",
      "category": "Phó từ",
      "explanation_vi": "\"怪不得\" (guàibude) là dạng khẩu ngữ phổ biến đồng nghĩa với \"难怪\", biểu thị sự ngộ ra nguyên nhân sau khi biết được sự thật (thảo nào, chả trách). Ngoài ra \"怪不得\" còn có cách dùng làm vị ngữ với nghĩa là không thể trách cứ được (như 这件事怪不得他 - Việc này không thể trách anh ấy được).",
      "examples": [
        {
          "chinese": "听说这家餐厅的主厨曾在国外拿过大奖，怪不得每天都有那么多人排队。",
          "pinyin": "Tīngshuō zhè jiā cāntīng de zhǔchú céng zài guówài náguo dàjiǎng, guàibude měitiān dōu yǒu nàme duō rén páiduì.",
          "translation_vi": "Nghe nói bếp trưởng của nhà hàng này từng đoạt giải lớn ở nước ngoài, thảo nào ngày nào cũng có bao nhiêu người xếp hàng.",
          "explanation": "\"怪不得\" giải thích nguyên nhân nhà hàng luôn đông khách là do tay nghề nổi tiếng của bếp trưởng."
        },
        {
          "chinese": "你昨晚熬夜看了整通宵的球赛，怪不得今天上课一直打瞌睡。",
          "pinyin": "Nǐ zuówǎn áoyè kàn le zhěng tōngxiāo de qiúsài, guàibude jīntiān shàngkè yìzhí dǎ kēshuì.",
          "translation_vi": "Tối qua cậu thức trắng đêm xem bóng đá, hèn chi hôm nay trong giờ học cứ ngủ gật suốt.",
          "explanation": "\"怪不得\" vạch rõ mối liên hệ giữa việc thức khuya và tình trạng mệt mỏi ban ngày."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 26,
      "name": "Phó từ tiện thể làm thêm việc \"顺便\" (Nhân tiện / Tiện thể)",
      "pattern": "Chủ ngữ + 顺便 + Động từ + Tân ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"顺便\" (shùnbiàn) biểu thị trong quá trình thực hiện một hành động chính nào đó, người nói nhân tiện hoặc tiện đường làm thêm một việc phụ khác mà không tốn thêm nhiều thời gian hay công sức.",
      "examples": [
        {
          "chinese": "你下楼去超市买水果的时候，顺便帮我取一下快递吧。",
          "pinyin": "Nǐ xiàlóu qù chāoshì mǎi shuǐguǒ de shíhou, shùnbiàn bāng wǒ qǔ yíxià kuàidì ba.",
          "translation_vi": "Khi cậu xuống tầng đi siêu thị mua hoa quả, tiện thể lấy giúp mình gói bưu phẩm nhé.",
          "explanation": "\"顺便\" kết hợp trước hành động phụ \"帮我取快递\" khi thực hiện việc chính đi mua hoa quả."
        },
        {
          "chinese": "李经理去广州出差，顺便拜访了几位多年合作的老客户。",
          "pinyin": "Lǐ jīnglǐ qù Guǎngzhōu chūchāi, shùnbiàn bàifǎng le jǐ wèi duō nián hézuò de lǎo kèhù.",
          "translation_vi": "Giám đốc Lý đi Quảng Châu công tác, nhân tiện đã ghé thăm mấy vị khách hàng cũ hợp tác lâu năm.",
          "explanation": "\"顺便拜访\" diễn tả hành động ghé thăm được kết hợp khéo léo trong chuyến đi công tác."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 27,
      "name": "Phó từ đích thân chủ thể \"亲自\" (Đích thân / Tự mình)",
      "pattern": "Chủ ngữ + 亲自 + Động từ (+ Tân ngữ)",
      "category": "Phó từ",
      "explanation_vi": "\"亲自\" (qīnzì) biểu thị chính bản thân người đó (thường là cấp trên, bậc trưởng bối, hoặc người có vị trí quan trọng) trực tiếp tham gia hoặc thực hiện hành động, chứ không thông qua người khác hay trung gian ủy quyền.",
      "examples": [
        {
          "chinese": "为了表示对客人的尊敬，总经理亲自去机场迎接。",
          "pinyin": "Wèile biǎoshì duì kèrén de zūnjìng, zǒngjīnglǐ qīnzì qù jīchǎng yíngjiē.",
          "translation_vi": "Để thể hiện sự tôn trọng đối với khách quý, tổng giám đốc đã đích thân ra sân bay đón tiếp.",
          "explanation": "\"亲自\" đứng trước \"去机场迎接\" nhấn mạnh sự trịnh trọng và tôn kính khi người lãnh đạo tự mình đi đón khách."
        },
        {
          "chinese": "这道特色菜是妈妈亲自下厨为我做的，味道格外鲜美。",
          "pinyin": "Zhè dào tèsè cài shì māma qīnzì xiàchú wèi wǒ zuò de, wèidào géwài xiānměi.",
          "translation_vi": "Món ăn đặc sản này là mẹ đích thân vào bếp nấu cho tôi, hương vị vô cùng thơm ngon.",
          "explanation": "\"亲自下厨\" thể hiện tấm lòng yêu thương khi chính người mẹ tự tay nấu nướng."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 28,
      "name": "Phó từ có chủ ý đặc biệt \"特意\" (Đặc biệt / Cố ý dành riêng)",
      "pattern": "Chủ ngữ + 特意 + Động từ (+ Tân ngữ)",
      "category": "Phó từ",
      "explanation_vi": "\"特意\" (tèyì) biểu thị chủ thể có một mục đích cụ thể rõ ràng và dành riêng thời gian, công sức hoặc tâm huyết để thực hiện một việc gì đó (thường mang ý nghĩa tích cực, thể hiện sự quan tâm chu đáo).",
      "examples": [
        {
          "chinese": "今天是你的生日，我特意为你定做了一个精美的蛋糕。",
          "pinyin": "Jīntiān shì nǐ de shēngrì, wǒ tèyì wèi nǐ dìngzuò le yí gè jīngměi de dàngāo.",
          "translation_vi": "Hôm nay là sinh nhật cậu, mình đã đặc biệt đặt riêng cho cậu một chiếc bánh gato tinh xảo.",
          "explanation": "\"特意为你定做\" biểu thị việc đặt bánh là hành động có chủ đích chu đáo dành riêng cho bạn nhân dịp sinh nhật."
        },
        {
          "chinese": "听说老朋友身体不适，他特意请假前去医院探望。",
          "pinyin": "Tīngshuō lǎopéngyou shēntǐ búlì, tā tèyì qǐngjià qiánqù yīyuàn tànwàng.",
          "translation_vi": "Nghe tin bạn cũ sức khỏe không tốt, anh ấy đã đặc biệt xin nghỉ phép để đến bệnh viện thăm hỏi.",
          "explanation": "\"特意请假\" nhấn mạnh hành động xin nghỉ việc xuất phát từ sự trân trọng tình bạn."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 29,
      "name": "Phó từ cố ý có chủ đích \"故意\" (Cố ý / Cố tình)",
      "pattern": "Chủ ngữ + 故意 + Động từ / 故意 + Làm ra hành động",
      "category": "Phó từ",
      "explanation_vi": "\"故意\" (gùyì) biểu thị hành động được thực hiện có ý thức, có toan tính từ trước (thường dùng cho những hành vi tiêu cực, gây phiền hà, trêu chọc hoặc vi phạm quy định). Khác với \"特意\" (mang sắc thái chu đáo, tốt đẹp), \"故意\" thường dùng để phê phán hoặc thanh minh (như \"我不是故意的\" - tôi không cố tình).",
      "examples": [
        {
          "chinese": "对不起，刚才我不小心碰翻了水杯，我真的不是故意的。",
          "pinyin": "Duìbuqǐ, gāngcái wǒ bù xiǎoxīn pèngfān le shuǐbēi, wǒ zhēnde bú shì gùyì de.",
          "translation_vi": "Xin lỗi, vừa nãy tôi không cẩn thận va đổ cốc nước, tôi thực sự không phải cố ý đâu.",
          "explanation": "\"不是故意的\" là câu xin lỗi kinh điển giải thích hành động xảy ra ngoài ý muốn sơ suất."
        },
        {
          "chinese": "他明明知道开会的时间，却故意迟到了半个小时。",
          "pinyin": "Tā míngmíng zhīdào kāihuì de shíjiān, què gùyì chídào le bàn gè xiǎoshí.",
          "translation_vi": "Anh ta rõ ràng biết thời gian họp, nhưng lại cố tình đến muộn nửa tiếng đồng hồ.",
          "explanation": "\"故意迟到\" phê phán thái độ thiếu nghiêm túc biết rõ giờ giấc nhưng vẫn cố ý vi phạm."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 30,
      "name": "Phó từ may mắn thoát nạn \"幸亏\" (May mà / May mắn thay)",
      "pattern": "幸亏 + Mệnh đề may mắn, 要不然 / 否则 + Hậu quả xấu",
      "category": "Phó từ",
      "explanation_vi": "\"幸亏\" (xìngkuī) dùng để biểu thị một tình huống thuận lợi hoặc sự trợ giúp kịp thời đã giúp tránh được một kết quả không mong muốn hoặc nguy hiểm nghiêm trọng (may mà, may mắn thay). Thường đi kèm với \"要不然\" hoặc \"否则\" ở vế sau để nêu ra hậu quả suýt xảy ra.",
      "examples": [
        {
          "chinese": "幸亏医生抢救及时，病人才脱离了生命危险。",
          "pinyin": "Xìngkuī yīshēng qiǎngjiù jíshí, bìngrén cái tuōlí le shēngmìng wēixiǎn.",
          "translation_vi": "May mà bác sĩ cấp cứu kịp thời, bệnh nhân mới qua khỏi cơn nguy kịch.",
          "explanation": "\"幸亏\" chỉ điều kiện may mắn (bác sĩ cấp cứu kịp) đã ngăn chặn được hậu quả nguy hiểm đến tính mạng."
        },
        {
          "chinese": "今天出门幸亏带了雨伞，否则肯定会被淋成落汤鸡。",
          "pinyin": "Jīntiān chūmén xìngkuī dài le yǔsǎn, fǒuzé kěndìng huì bèi línchéng luòtāngjī.",
          "translation_vi": "Hôm nay ra khỏi nhà may mà mang theo ô, nếu không chắc chắn đã bị ướt như chuột lột.",
          "explanation": "Cấu trúc \"幸亏...否则...\" làm nổi bật sự may mắn nhờ mang ô tránh được cơn mưa rào."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 31,
      "name": "Phó từ biểu thị điểm may mắn \"好在\" (May mà / Cũng may là)",
      "pattern": "好在 + Tình hình tích cực / Mệnh đề 1, 好在 + Mệnh đề 2",
      "category": "Phó từ",
      "explanation_vi": "\"好在\" (hǎozài) mang sắc thái khẩu ngữ tương tự \"幸亏\", biểu thị nhờ có một yếu tố thuận lợi mà giảm thiểu được rủi ro, tổn thất hoặc làm cho tình hình không đến mức quá tồi tệ (may ở chỗ, cũng may là).",
      "examples": [
        {
          "chinese": "路上遇到大堵车，好在面试地点就在地铁站旁边，我才没迟到。",
          "pinyin": "Lùshang yùdào dà dǔchē, hǎozài miànshì dìdiǎn jiù zài dìtiězhàn pángbiān, wǒ cái méi chídào.",
          "translation_vi": "Trên đường bị tắc xe nghiêm trọng, may mà địa điểm phỏng vấn nằm ngay cạnh ga tàu điện ngầm nên tôi mới không bị muộn.",
          "explanation": "\"好在\" nêu ra yếu tố thuận lợi về vị trí địa lý cứu vãn tình thế tắc đường."
        },
        {
          "chinese": "昨晚风吹得很大，好在大家都把窗户关严了，没有造成什么损失。",
          "pinyin": "Zuówǎn fēng chuī de hěn dà, hǎozài dàjiā dōu bǎ chuānghu guānyán le, méiyǒu zàochéng shénme sǔnshī.",
          "translation_vi": "Đêm qua gió thổi rất to, may mà mọi người đều đóng chặt cửa sổ nên không gây ra thiệt hại gì.",
          "explanation": "\"好在\" khẳng định sự phòng ngừa đúng đắn giúp giữ an toàn cho ngôi nhà."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 32,
      "name": "Phó từ phỏng đoán kèm lo lắng \"恐怕\" (E rằng / Sợ rằng)",
      "pattern": "Chủ ngữ + 恐怕 + Vị ngữ / 恐怕 + Mệnh đề phỏng đoán",
      "category": "Phó từ",
      "explanation_vi": "\"恐怕\" (kǒngpà) dùng để đưa ra ước đoán, nhận định về một khả năng có thể xảy ra trong tương lai, nhưng khả năng này thường không có lợi, gây thất vọng hoặc nằm ngoài ý muốn của người nói (e rằng, sợ rằng). Thường dùng để biểu đạt ý kiến một cách nhã nhặn, uyển chuyển.",
      "examples": [
        {
          "chinese": "现在的机票十分紧张，下周出发恐怕已经买不到票了。",
          "pinyin": "Xiànzài de jīpiào shífēn jǐnzhāng, xià zhōu chūfā kǒngpà yǐjīng mǎi bú dào piào le.",
          "translation_vi": "Hiện tại vé máy bay rất khan hiếm, tuần sau khởi hành e rằng đã không thể mua được vé nữa.",
          "explanation": "\"恐怕\" giảm nhẹ giọng điệu từ chối hoặc đưa ra phỏng đoán bất lợi về việc hết vé."
        },
        {
          "chinese": "今天的工作量太大，仅靠他一个人恐怕很难按时完成。",
          "pinyin": "Jīntiān de gōngzuòliàng tài dà, jǐn kào tā yí gè rén kǒngpà hěn nán ànshí wánchéng.",
          "translation_vi": "Khối lượng công việc hôm nay quá lớn, chỉ dựa vào một mình anh ấy e rằng rất khó hoàn thành đúng hạn.",
          "explanation": "\"恐怕很难按时完成\" đưa ra dự đoán e dè về tiến độ công việc nhằm đề xuất hỗ trợ."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 33,
      "name": "Phó từ trớ trêu ngoài dự tính \"偏偏\" (Trớ trêu thay / Ngặt nỗi / Cứ khăng khăng)",
      "pattern": "Chủ ngữ + 偏偏 + Động từ / 偏偏 + Mệnh đề nghịch cảnh",
      "category": "Phó từ",
      "explanation_vi": "\"偏偏\" (piānpiān) có hai cách dùng: 1) Diễn tả sự việc diễn ra hoàn toàn trái ngược với nguyện vọng, dự kiến trong hoàn cảnh trớ trêu (ngặt nỗi, oái oăm thay); 2) Biểu thị sự bướng bỉnh, khăng khăng làm một việc ngược lại với ý muốn của người khác.",
      "examples": [
        {
          "chinese": "今天我有非常重要的考试，偏偏早上闹钟坏了没有响。",
          "pinyin": "Jīntiān wǒ yǒu fēicháng zhòngyào de kǎoshì, piānpiān zǎoshang nàozhōng huài le méiyǒu xiǎng.",
          "translation_vi": "Hôm nay tôi có kỳ thi vô cùng quan trọng, trớ trêu thay sáng nay đồng hồ báo thức lại hỏng không kêu.",
          "explanation": "\"偏偏\" thể hiện sự không may xảy ra đúng vào thời điểm quan trọng nhất."
        },
        {
          "chinese": "大家都劝他要冷静考虑，他偏偏不听，执意要辞职。",
          "pinyin": "Dàjiā dōu quàn tā yào lěngjìng kǎolǜ, tā piānpiān bù tīng, zhíyì yào cízhí.",
          "translation_vi": "Mọi người đều khuyên anh ấy nên suy nghĩ bình tĩnh, anh ấy cứ khăng khăng không nghe, nhất quyết đòi từ chức.",
          "explanation": "\"偏偏不听\" diễn tả tính khí bướng bỉnh làm ngược lại lời khuyên bảo của mọi người."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 34,
      "name": "Phó từ phản đề tương phản \"反而\" (Trái lại / Ngược lại)",
      "pattern": "Vế 1 (dự kiến/lẽ thường), Vế 2 (反而 + Động từ/Tính từ)",
      "category": "Phó từ",
      "explanation_vi": "\"反而\" (fǎn'ér) biểu thị kết quả của sự việc xảy ra hoàn toàn trái ngược với lẽ thường, quy luật tự nhiên hoặc dự đoán thông thường. Vế đầu nêu lý do hoặc tác động, vế sau dùng \"反而\" để nêu phản ứng trái ngược.",
      "examples": [
        {
          "chinese": "吃了药之后，他的头痛不仅没有减轻，反而更加厉害了。",
          "pinyin": "Chī le yào zhīhòu, tā de tóutòng bùjǐn méiyǒu jiǎnqīng, fǎn'ér gèngjiā lìhai le.",
          "translation_vi": "Sau khi uống thuốc, chứng đau đầu của anh ấy chẳng những không thuyên giảm mà ngược lại càng dữ dội hơn.",
          "explanation": "\"反而更加厉害\" biểu thị kết quả trái ngược hẳn với tác dụng kỳ vọng của việc uống thuốc."
        },
        {
          "chinese": "受到批评之后，他没有灰心，反而激发了更大的学习斗志。",
          "pinyin": "Shòudào pīpíng zhīhòu, tā méiyǒu huīxīn, fǎn'ér jīfā le gèng dà de xuéxí dòuzhì.",
          "translation_vi": "Sau khi bị phê bình, anh ấy không nản lòng mà trái lại còn khơi dậy ý chí học tập mãnh liệt hơn.",
          "explanation": "\"反而\" nhấn mạnh phản ứng tích cực bất ngờ vượt ngoài tâm lý chán nản thông thường."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 35,
      "name": "Phó từ phản phục khẩu ngữ \"反倒\" (Trái lại / Ngược lại)",
      "pattern": "Vế trước, Chủ ngữ + 反倒 + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"反倒\" (fǎndào) đồng nghĩa với \"反而\", biểu thị sự chuyển ngoặt trái ngược với lẽ thường, thường dùng nhiều trong văn nói khẩu ngữ hoặc phong cách kể chuyện sinh động.",
      "examples": [
        {
          "chinese": "我本来是一片好心想去帮他，没想到他反倒嫌我多管闲事。",
          "pinyin": "Wǒ běnlái shì yí piàn hǎoxīn xiǎng qù bāng tā, méi xiǎngdào tā fǎndào xián wǒ duō guǎn xiánshì.",
          "translation_vi": "Tôi vốn mang tấm lòng tốt muốn đến giúp anh ta, không ngờ anh ta trái lại còn chê tôi lo chuyện bao đồng.",
          "explanation": "\"反倒嫌我多管闲事\" thể hiện phản ứng bất ngờ, vô lý của đối phương đối với lòng tốt."
        },
        {
          "chinese": "年纪大的人每天睡得少，年轻人反倒经常觉得睡不够。",
          "pinyin": "Niánjì dà de rén měitiān shuì de shǎo, niánqīngrén fǎndào jīngcháng juéde shuì bú gòu.",
          "translation_vi": "Người lớn tuổi mỗi ngày ngủ ít, người trẻ tuổi ngược lại thường cảm thấy ngủ không đủ giấc.",
          "explanation": "\"反倒\" nêu bật sự tương phản thú vị giữa thói quen giấc ngủ của hai thế hệ."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 36,
      "name": "Phó từ phản vấn phủ định \"何必\" (Hà tất / Việc gì phải / Cần gì)",
      "pattern": "何必 + Động từ / 何必 + Cụm từ + 呢",
      "category": "Phó từ",
      "explanation_vi": "\"何必\" (hébì) dùng trong câu hỏi tu từ để biểu thị ý nghĩa không cần thiết phải làm một việc gì đó (hà tất, cần gì, việc gì phải thế). Thường dùng để khuyên nhủ, an ủi hoặc khuyên can đối phương bớt nóng giận, lo âu. Cuối câu thường có trợ từ ngữ khí \"呢\".",
      "examples": [
        {
          "chinese": "这不过是一件微不足道的小事，你何必为它发那么大脾气呢？",
          "pinyin": "Zhè búguò shì yí jiàn wēibùzúdào de xiǎoshì, nǐ hébì wèi tā fā nàme dà píqi ne?",
          "translation_vi": "Đây chẳng qua chỉ là một chuyện nhỏ không đáng kể, cậu hà tất phải nổi trận lôi đình vì nó làm gì chứ?",
          "explanation": "Cấu trúc \"何必...呢\" mang ngữ khí khuyên can đối phương không nên lãng phí cảm xúc giận dữ vì chuyện vặt vãnh."
        },
        {
          "chinese": "既然双方都有诚意合作，又何必在细节问题上寸步不让呢？",
          "pinyin": "Jìrán shuāngfāng dōu yǒu chéngyì hézuò, yòu hébì zài xìjié wèntí shang cùnbù bú ràng ne?",
          "translation_vi": "Đã đôi bên đều có thành ý hợp tác, vậy cần gì phải so đo từng bước ở những vấn đề tiểu tiết chứ?",
          "explanation": "\"何必\" thúc đẩy sự nhượng bộ để đạt được đại cục hợp tác suôn sẻ."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 37,
      "name": "Phó từ câu hỏi tu từ chất vấn \"难道\" (Lẽ nào / Chẳng lẽ)",
      "pattern": "难道 + Chủ ngữ + Vị ngữ + 吗 / 难道 + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"难道\" (nándào) dùng trong câu hỏi tu từ để nhấn mạnh ngữ khí chất vấn hoặc phản bác mạnh mẽ (chẳng lẽ, lẽ nào). Nếu câu ở dạng khẳng định thì mang ý phủ định, và ngược lại nếu dùng phủ định (难道不...) thì biểu thị khẳng định mạnh mẽ.",
      "examples": [
        {
          "chinese": "这么简单的交通规则，难道你连这都不明白吗？",
          "pinyin": "Zhème jiǎndān de jiāotōng guīzé, nándào nǐ lián zhè dōu bù míngbai ma?",
          "translation_vi": "Quy tắc giao thông đơn giản như thế này, chẳng lẽ cậu ngay cả điều đó cũng không hiểu sao?",
          "explanation": "\"难道...吗\" tăng cường sự trách cứ, chất vấn sự thiếu hiểu biết đối với quy tắc cơ bản."
        },
        {
          "chinese": "大家为这个项目付出了那么多心血，难道我们能轻易放弃吗？",
          "pinyin": "Dàjiā wèi zhè ge xiàngmù fùchū le nàme duō xīnxuè, nándào wǒmen néng qīngyì fàngqì ma?",
          "translation_vi": "Mọi người đã bỏ ra bao nhiêu tâm huyết vì dự án này, lẽ nào chúng ta lại có thể dễ dàng từ bỏ hay sao?",
          "explanation": "\"难道能轻易放弃吗\" dùng câu hỏi tu từ để khẳng định tuyệt đối không thể bỏ cuộc."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 38,
      "name": "Phó từ dứt khoát đưa ra giải pháp \"索性\" (Dứt khoát / Thà rằng / Thẳng thừng)",
      "pattern": "Chủ ngữ + 索性 + Động từ + Tân ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"索性\" (suǒxìng) biểu thị khi đối mặt với một tình huống khó xử, trì hoãn hoặc phiền phức, chủ thể dứt khoát đưa ra một quyết định triệt để, đơn giản hóa vấn đề mà không còn đắn đo suy nghĩ nữa.",
      "examples": [
        {
          "chinese": "外面的雨越下越大，车也打不到，我们索性在朋友家住了一晚。",
          "pinyin": "Wàimiàn de yǔ yuè xià yuè dà, chē yě dǎ bú dào, wǒmen suǒxìng zài péngyou jiā zhù le yì wǎn.",
          "translation_vi": "Mưa bên ngoài càng lúc càng to, xe cũng không gọi được, chúng tôi dứt khoát ở lại nhà bạn một đêm.",
          "explanation": "\"索性\" thể hiện quyết định nhanh gọn ở lại qua đêm khi các phương án di chuyển đều bế tắc."
        },
        {
          "chinese": "既然这台电脑修起来费用那么高，他索性直接买了一台新的。",
          "pinyin": "Jìrán zhè tái diànnǎo xiū qǐlái fèiyong nàme gāo, tā suǒxìng zhíjiē mǎi le yì tái xīn de.",
          "translation_vi": "Đã chi phí sửa chiếc máy tính này cao đến thế, anh ấy thà rằng mua thẳng luôn một chiếc máy mới.",
          "explanation": "\"索性直接买新的\" diễn tả sự dứt khoát thay mới thay vì tốn tiền sửa chữa máy cũ."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 39,
      "name": "Phó từ kinh ngạc vượt ngoài mong đợi \"居然\" (Không ngờ / Lại)",
      "pattern": "Chủ ngữ + 居然 + Động từ / 居然 + Mệnh đề kinh ngạc",
      "category": "Phó từ",
      "explanation_vi": "\"居然\" (jūrán) biểu thị sự việc xảy ra hoàn toàn bất ngờ, khác xa hoặc vượt quá hẳn dự tính thông thường (vậy mà, lại, không ngờ rằng). Thường mang sắc thái kinh ngạc, khâm phục hoặc bất ngờ trước một kết quả hiếm có.",
      "examples": [
        {
          "chinese": "他平时很少参加体育锻炼，这次居然跑了全班第一名。",
          "pinyin": "Tā píngshí hěn shǎo cānjiā tǐyù duànliàn, zhè cì jūrán pǎo le quán bān dì yī míng.",
          "translation_vi": "Bình thường anh ấy rất ít khi tập luyện thể thao, lần này không ngờ lại chạy về đích thứ nhất toàn lớp.",
          "explanation": "\"居然跑了第一名\" nhấn mạnh sự ngạc nhiên tột cùng trước thành tích chạy đáng kinh ngạc."
        },
        {
          "chinese": "那对双胞胎姐妹分开生活了二十年，性格居然一模一样。",
          "pinyin": "Nà duì shuāngbāotāi jiěmèi fēnkāi shēnghuó le èrshí nián, xìnggé jūrán yìmúyíyàng.",
          "translation_vi": "Cặp chị em sinh đôi đó sống tách biệt suốt 20 năm, tính cách không ngờ lại giống hệt như đúc.",
          "explanation": "\"居然一模一样\" thể hiện sự kỳ diệu và kinh ngạc trước sự tương đồng tính cách."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 40,
      "name": "Phó từ ngoài ý muốn mạnh mẽ \"竟然\" (Lại / Không ngờ rằng)",
      "pattern": "Chủ ngữ + 竟然 + Động từ / Tính từ",
      "category": "Phó từ",
      "explanation_vi": "\"竟然\" (jìngrán) mang ý nghĩa tương tự như \"居然\", chỉ sự việc xảy ra nằm ngoài dự kiến (không ngờ, lại). Tuy nhiên, \"竟然\" thường được dùng nhiều hơn trong các ngữ cảnh mang tính tiêu cực, phản cảm hoặc khó tin về mặt đạo đức/hành vi.",
      "examples": [
        {
          "chinese": "我一直把他当作最好的朋友，他竟然在背后说我的坏话。",
          "pinyin": "Wǒ yìzhí bǎ tā dàngzuò zuì hǎo de péngyou, tā jìngrán zài bèihòu shuō wǒ de huàihuà.",
          "translation_vi": "Tôi luôn coi anh ta là người bạn tốt nhất, anh ta thế mà lại nói xấu sau lưng tôi.",
          "explanation": "\"竟然在背后说坏话\" thể hiện nỗi thất vọng và kinh ngạc trước sự phản bội của bạn bè."
        },
        {
          "chinese": "这项看起来非常复杂的任务，他竟然只用半天就完成了。",
          "pinyin": "Zhè xiàng kàn qǐlái fēicháng fùzá de rènwu, tā jìngrán zhǐ yòng bàn tiān jiù wánchéng le.",
          "translation_vi": "Nhiệm vụ trông có vẻ vô cùng phức tạp này, anh ấy thế mà chỉ dùng nửa ngày đã hoàn thành xong.",
          "explanation": "\"竟然只用半天\" biểu thị sự thán phục trước tốc độ xử lý công việc thần tốc ngoài dự đoán."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 41,
      "name": "Phó từ phán đoán căn cứ rõ ràng \"显然\" (Rõ ràng / Hiển nhiên)",
      "pattern": "显然 + Mệnh đề / Chủ ngữ + 显然 + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"显然\" (xiǎnrán) dùng để khẳng định một sự việc, tình huống là hiển nhiên, dễ thấy, ai cũng có thể nhận ra mà không cần phải tranh cãi. Có thể đứng ở đầu câu làm trạng ngữ cho cả câu hoặc đứng trước vị ngữ.",
      "examples": [
        {
          "chinese": "从目前的谈判进展来看，对方显然缺乏足够的合作诚意。",
          "pinyin": "Cóng mùqián de tánpàn jìnzhǎn lái kàn, duìfāng xiǎnrán quēfá zúgòu de hézuò chéngyì.",
          "translation_vi": "Nhìn từ tiến trình đàm phán hiện tại, đối phương rõ ràng là thiếu thành ý hợp tác thỏa đáng.",
          "explanation": "\"显然缺乏\" đưa ra nhận định dứt khoát dựa trên các dữ kiện thực tế của buổi đàm phán."
        },
        {
          "chinese": "这个问题显然没有大家想象的那么简单，需要深入研究。",
          "pinyin": "Zhè ge wèntí xiǎnrán méiyǒu dàjiā xiǎngxiàng de nàme jiǎndān, xūyào shēnrù yánjiū.",
          "translation_vi": "Vấn đề này hiển nhiên không đơn giản như mọi người tưởng tượng, cần phải nghiên cứu sâu hơn.",
          "explanation": "\"显然没有...那么简单\" làm sáng tỏ bản chất phức tạp của vấn đề."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 42,
      "name": "Phó từ đánh giá có phần quá đáng \"未免\" (Khó tránh / Hơi bị / Quá ư)",
      "pattern": "Chủ ngữ + 未免 + (太/有点儿) + Tính từ / Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"未免\" (wèimiǎn) dùng để đưa ra lời nhận xét, đánh giá phê bình một cách tế nhị, cho rằng hành vi hoặc tình huống nào đó có phần hơi quá đáng, không thỏa đáng hoặc khó tránh khỏi bị chê trách (thật là hơi bị, khó tránh khỏi). Thường kết hợp với \"太\", \"过分\", \"有点儿\".",
      "examples": [
        {
          "chinese": "只因为一点小小的失误就开除员工，这样做未免太严厉了。",
          "pinyin": "Zhǐ yīnwèi yì diǎn xiǎoxiǎo de shīwù jiù kāichú yuángōng, zhèyàng zuò wèimiǎn tài yánlì le.",
          "translation_vi": "Chỉ vì một sơ suất nhỏ mà sa thải nhân viên, làm như vậy thật là có phần quá khắt khe.",
          "explanation": "\"未免太严厉了\" phê bình mức độ xử phạt quá nặng nề so với tính chất của lỗi vi phạm."
        },
        {
          "chinese": "还没经过实地调查就下结论，这个决定未免有点儿草率。",
          "pinyin": "Hái méi jīngguò shídì diàochá jiù xià jiélùn, zhè ge juédìng wèimiǎn yǒudiǎnr cǎoshuài.",
          "translation_vi": "Còn chưa qua điều tra thực tế mà đã vội kết luận, quyết định này e là có phần hơi vội vàng hấp tấp.",
          "explanation": "\"未免有点儿草率\" nhận xét một cách uyển chuyển về sự thiếu cẩn trọng trong quyết định."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 43,
      "name": "Phó từ phủ định tuyệt đối không chút nào \"毫无\" (Mảy may không / Hoàn toàn không)",
      "pattern": "毫无 + Danh từ song âm tiết (毫无疑问 / 毫无经验 / 毫无准备 / 毫无关系)",
      "category": "Phó từ",
      "explanation_vi": "\"毫无\" (háowú) có nghĩa là mảy may không có, hoàn toàn không có một chút nào (毫 biểu thị đơn vị cực nhỏ; 无 là không có). \"毫无\" thường đi kèm trực tiếp với danh từ trừu tượng song âm tiết như 疑问, 意义, 价值, 准备, 关系, 经验.",
      "examples": [
        {
          "chinese": "凭借他在行业内的杰出贡献，获得这项荣誉是毫无疑问的。",
          "pinyin": "Píngjiè tā zài hángyè nèi de jiéchū gòngxiàn, huòdé zhè xiàng róngyù shì háowú yíwèn de.",
          "translation_vi": "Nhờ vào những cống hiến kiệt xuất của ông trong ngành, việc nhận được danh hiệu này là hoàn toàn không còn nghi ngờ gì nữa.",
          "explanation": "\"毫无疑问\" là cụm từ cố định khẳng định tính xác thực 100% không thể bàn cãi."
        },
        {
          "chinese": "对于刚刚大学毕业的新人来说，他们对实际工作往往毫无经验。",
          "pinyin": "Duìyú gānggāng dàxué bìyè de xīnrén láishuō, tāmen duì shíjì gōngzuò wǎngwǎng háowú jīngyàn.",
          "translation_vi": "Đối với những người mới vừa tốt nghiệp đại học, họ đối với công việc thực tế thường hoàn toàn không có kinh nghiệm gì.",
          "explanation": "\"毫无经验\" chỉ tình trạng thiếu hụt 100% kinh nghiệm thực chiến."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 44,
      "name": "Phó từ lặp lại từ đầu \"重新\" (Lại từ đầu / Làm lại)",
      "pattern": "Chủ ngữ + 重新 + Động từ + Tân ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"重新\" (chóngxīn) biểu thị một hành động được thực hiện lại từ đầu, thường là sau khi gặp thất bại, sai sót, hoặc muốn có một khởi đầu mới với chất lượng tốt hơn. Khác với \"又\" (lặp lại tự nhiên) và \"再\" (lặp lại tiếp diễn), \"重新\" nhấn mạnh tính chất bắt đầu lại toàn bộ quy trình từ điểm xuất phát.",
      "examples": [
        {
          "chinese": "方案虽然被客户否定了，但我们大家有信心重新设计出一套新方案。",
          "pinyin": "Fāng'àn suīrán bèi kèhù fǒudìng le, dàn wǒmen dàjiā yǒu xìnxīn chóngxīn shèjì chū yí tào xīn fāng'àn.",
          "translation_vi": "Phương án tuy bị khách hàng từ chối, nhưng mọi người chúng tôi đều có niềm tin thiết kế lại từ đầu một bộ phương án mới.",
          "explanation": "\"重新设计\" nhấn mạnh quá trình bắt tay làm lại từ vạch xuất phát."
        },
        {
          "chinese": "计算机死机之后，他只能按下电源键重新启动系统。",
          "pinyin": "Jìsuànjī sǐjī zhīhòu, tā zhǐ néng ànxià diànyuán jiàn chóngxīn qǐdòng xìtǒng.",
          "translation_vi": "Sau khi máy tính bị treo, anh ấy chỉ còn cách bấm nút nguồn để khởi động lại hệ thống.",
          "explanation": "\"重新启动\" chỉ thao tác khởi động lại thiết bị từ trạng thái tắt."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 45,
      "name": "Phó từ hành động lặng lẽ kín đáo \"悄悄\" (Lén lút / Lặng lẽ / Nhè nhẹ)",
      "pattern": "Chủ ngữ + 悄悄(地) + Động từ + Tân ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"悄悄\" (qiāoqiāo) diễn tả hành động được thực hiện một cách cực kỳ êm ái, yên ắng, không phát ra tiếng động, hoặc diễn ra kín đáo, lén lút để không làm kinh động đến người khác.",
      "examples": [
        {
          "chinese": "夜深了，孩子已经熟睡，妈妈悄悄地关上门走出了卧室。",
          "pinyin": "Yè shēn le, háizi yǐjīng shúshuì, māma qiāoqiāo de guānshàng mén zǒuchū le wòshì.",
          "translation_vi": "Đêm đã khuya, con đã ngủ say, người mẹ nhẹ nhàng đóng cửa bước ra khỏi phòng ngủ.",
          "explanation": "\"悄悄地关上门\" diễn tả động tác khép cửa nhẹ nhàng để không làm thức giấc em bé."
        },
        {
          "chinese": "趁大家都在专注看比赛，他悄悄地溜出了会议室。",
          "pinyin": "Chèn dàjiā dōu zài zhuānzhù kàn bǐsài, tā qiāoqiāo de liūchū le huìyìshì.",
          "translation_vi": "Nhân lúc mọi người đang mải mê xem trận đấu, anh ta đã lén lút chuồn ra khỏi phòng họp.",
          "explanation": "\"悄悄地溜出\" miêu tả hành vi rời đi bí mật không để người khác phát hiện."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 46,
      "name": "Phó từ tiến hành theo trình tự bài bản \"逐步\" (Từng bước / Từng chặng)",
      "pattern": "Chủ ngữ + 逐步 + Động từ song âm tiết / 逐步 + Đạt được trạng thái",
      "category": "Phó từ",
      "explanation_vi": "\"逐步\" (zhúbù) biểu thị sự việc tiến triển theo từng bước, từng giai đoạn có kế hoạch rõ ràng và có sự can thiệp của ý chí con người. Thường kết hợp với các động từ biến đổi như 提高, 完善, 落实, 改善.",
      "examples": [
        {
          "chinese": "随着经济的发展，人民的生活水平正在逐步提高。",
          "pinyin": "Suízhe jīngjì de fāzhǎn, rénmín de shēnghuó shuǐpíng zhèngzài zhúbù tígāo.",
          "translation_vi": "Cùng với sự phát triển của kinh tế, mức sống của nhân dân đang từng bước được nâng cao.",
          "explanation": "\"逐步提高\" thể hiện sự cải thiện từng giai đoạn có định hướng trong đời sống người dân."
        },
        {
          "chinese": "学校将逐步完善各项规章制度，为师生创造更好的环境。",
          "pinyin": "Xuéxiào jiāng zhúbù wánshàn gè xiàng guīzhāng zhìdù, wèi shīshēng chuàngzào gèng hǎo de huánjìng.",
          "translation_vi": "Nhà trường sẽ từng bước hoàn thiện các nội quy quy chế, tạo môi trường tốt hơn cho thầy và trò.",
          "explanation": "\"逐步完善\" chỉ tiến trình hoàn thiện thể chế theo từng bước kế hoạch."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 47,
      "name": "Phó từ biến đổi tiệm tiến tự nhiên \"逐渐\" (Dần dần / Từ từ)",
      "pattern": "Chủ ngữ + 逐渐 + Động từ / Tính từ",
      "category": "Phó từ",
      "explanation_vi": "\"逐渐\" (zhújiàn) biểu thị mức độ hoặc số lượng biến đổi dần dần theo thời gian, thường là diễn biến tự nhiên không phụ thuộc vào các bước kế hoạch cứng nhắc. So với \"逐步\", \"逐渐\" áp dụng rộng rãi hơn cho cả các hiện tượng tự nhiên và tâm lý con người.",
      "examples": [
        {
          "chinese": "春天来了，天气逐渐变暖，小草也渐渐露出了嫩绿的芽。",
          "pinyin": "Chūntiān lái le, tiānqì zhújiàn biàn nuǎn, xiǎocǎo yě jiànjiàn lùchū le nènlǜ de yá.",
          "translation_vi": "Mùa xuân đến rồi, thời tiết dần dần ấm lên, ngọn cỏ non cũng từ từ nhú mầm xanh biếc.",
          "explanation": "\"逐渐变暖\" miêu tả sự ấm dần lên của khí hậu theo quy luật chuyển mùa tự nhiên."
        },
        {
          "chinese": "来到新城市生活几个月后，他逐渐适应了这里的生活节奏。",
          "pinyin": "Láidào xīn chéngshì shēnghuó jǐ gè yuè hòu, tā zhújiàn shìyìng le zhèlǐ de shēnghuó jiézòu.",
          "translation_vi": "Sau mấy tháng chuyển đến thành phố mới sinh sống, anh ấy đã dần dần thích nghi với nhịp sống nơi đây.",
          "explanation": "\"逐渐适应\" chỉ quá trình hòa nhập tự nhiên qua thời gian."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 48,
      "name": "Phó từ tổng quát hóa điều kiện \"凡是\" (Phàm là / Hễ là / Mọi)",
      "pattern": "凡是 + Đối tượng/Điều kiện + 都 / 也 + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"凡是\" (fánshì) dùng ở đầu câu hoặc đầu vế câu để bao quát toàn bộ mọi thành viên hoặc sự vật nằm trong một phạm vi xác định (phàm là, hễ là, tất cả những ai/cái gì). Vế sau luôn đi kèm với phó từ \"都\" hoặc \"也\" để khẳng định tính phổ quát tuyệt đối.",
      "examples": [
        {
          "chinese": "凡是参加本次汉语比赛的选手，都可以获得一份精美的纪念品。",
          "pinyin": "Fánshì cānjiā běn cì hànyǔ bǐsài de xuǎnshǒu, dōu kěyǐ huòdé yí fèn jīngměi de jìnìanpǐn.",
          "translation_vi": "Phàm là thí sinh tham gia cuộc thi tiếng Hán lần này đều có thể nhận được một phần quà lưu niệm tinh xảo.",
          "explanation": "\"凡是...都...\" xác định toàn bộ người tham gia cuộc thi đều có quyền lợi nhận quà."
        },
        {
          "chinese": "凡是符合国家规定的企业，都可以申请这项科技创新补贴。",
          "pinyin": "Fánshì fúhé guójiā guīdìng de qǐyè, dōu kěyǐ shēnqǐng zhè xiàng kējì chuàngxīn bǔtiē.",
          "translation_vi": "Hễ là doanh nghiệp phù hợp với quy định của nhà nước, đều có thể nộp hồ sơ xin khoản trợ cấp đổi mới khoa học kỹ thuật này.",
          "explanation": "\"凡是...都...\" bao quát đối tượng đủ tiêu chuẩn theo quy định pháp lý."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 49,
      "name": "Phó từ tác động qua lại \"互相\" (Lẫn nhau / Cùng nhau)",
      "pattern": "Chủ ngữ (số nhiều) + 互相 + Động từ song âm tiết",
      "category": "Phó từ",
      "explanation_vi": "\"互相\" (hùxiāng) là phó từ biểu thị hành động qua lại hai chiều giữa các cá nhân hoặc các bên đối tác (lẫn nhau). Lưu ý: \"互相\" là phó từ nên chỉ làm trạng ngữ đứng trước động từ (thường là động từ song âm tiết như 帮助, 学习, 理解, 尊重), không thể trực tiếp làm chủ ngữ hay tân ngữ.",
      "examples": [
        {
          "chinese": "同学之间应该互相帮助，共同克服学习中遇到的困难。",
          "pinyin": "Tóngxué zhījiān yīnggāi hùxiāng bāngzhù, gòngtóng kèfú xuéxí zhōng yùdào de kùnnan.",
          "translation_vi": "Giữa các bạn học nên giúp đỡ lẫn nhau, cùng nhau khắc phục những khó khăn gặp phải trong học tập.",
          "explanation": "\"互相帮助\" là trạng ngữ + động từ biểu thị mối quan hệ tương trợ hai chiều giữa học sinh."
        },
        {
          "chinese": "两国领导人就双边合作深入交换了意见，达成了互相理解。",
          "pinyin": "Liǎng guó lǐngdǎorén jiù shuāngbiān hézuò shēnrù jiāohuàn le yìjiàn, dáchéng le hùxiāng lǐjiě.",
          "translation_vi": "Lãnh đạo hai nước đã trao đổi ý kiến sâu rộng về hợp tác song phương, đạt được sự thấu hiểu lẫn nhau.",
          "explanation": "\"互相理解\" chỉ sự hiểu biết và đồng thuận từ cả hai phía đối tác ngoại giao."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 50,
      "name": "Phó từ kín đáo trong tâm lý \"暗暗\" (Thầm / Ngầm / Trong lòng)",
      "pattern": "Chủ ngữ + 暗暗 + (下决心 / 高兴 / 佩服 / 担心 / 努力)",
      "category": "Phó từ",
      "explanation_vi": "\"暗暗\" (àn'àn) biểu thị hoạt động tâm lý, cảm xúc hoặc nỗ lực diễn ra thầm kín bên trong lòng, không bộc lộ ra ngoài cho người khác thấy (ngầm, thầm, trong bụng). Thường kết hợp với các từ ngữ biểu thị tâm tư như 下决心, 庆祝, 佩服, 赞叹, 担忧.",
      "examples": [
        {
          "chinese": "听到自己被心仪的公司录取的喜讯，他心里暗暗高兴。",
          "pinyin": "Tīngdào zìjǐ bèi xīnyí de gōngsī lùqǔ de xǐxùn, tā xīnli àn'àn gāoxìng.",
          "translation_vi": "Nghe được tin mừng mình đã được công ty mơ ước trúng tuyển, trong lòng anh ấy thầm mừng rỡ.",
          "explanation": "\"暗暗高兴\" diễn tả niềm vui sướng âm thầm dâng trào trong nội tâm."
        },
        {
          "chinese": "面对强大的竞争对手，他在心底暗暗下定决心一定要全力以赴。",
          "pinyin": "Miànduì qiángdà de jìngzhēng duìshǒu, tā zài xīndǐ àn'àn xiàdìng juéxīn yídìng yào quánlì yǐ fù.",
          "translation_vi": "Đối mặt với đối thủ cạnh tranh mạnh mẽ, anh ấy đã thầm hạ quyết tâm trong lòng nhất định phải dốc hết toàn lực.",
          "explanation": "\"暗暗下定决心\" chỉ ý chí quyết tâm được nung nấu trong thâm tâm."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 51,
      "name": "Phó từ kiên định xuyên suốt \"始终\" (Từ đầu đến cuối / Luôn luôn)",
      "pattern": "Chủ ngữ + 始终 + Phủ định/Khẳng định + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"始终\" (shǐzhōng) kết hợp chữ \"始\" (bắt đầu) và \"终\" (kết thúc), biểu thị một trạng thái, nguyên tắc hoặc hành vi duy trì liên tục từ đầu đến cuối không hề suy suyển hay thay đổi. Thường mang sắc thái tán thưởng ý chí kiên định hoặc miêu tả sự bế tắc kéo dài.",
      "examples": [
        {
          "chinese": "无论经历多少风雨，他始终保持着对科学探索的热情。",
          "pinyin": "Wúlùn jīnglì duōshao fēngyǔ, tā shǐzhōng bǎochízhe duì kēxué tànsuǒ de rèqíng.",
          "translation_vi": "Bất luận trải qua bao nhiêu phong ba, ông ấy luôn luôn giữ vững niềm nhiệt huyết đối với nghiên cứu khoa học.",
          "explanation": "\"始终保持着\" nhấn mạnh tinh thần đam mê bất di bất dịch xuyên suốt nhiều năm tháng."
        },
        {
          "chinese": "对于这次事故的原因，相关责任部门始终没有给出合理的解释。",
          "pinyin": "Duìyú zhè cì shìgù de yuányīn, xiāngguān zérèn bùmén shǐzhōng méiyǒu gěichū hélǐ de jiěshì.",
          "translation_vi": "Đối với nguyên nhân của vụ tai nạn lần này, bộ phận chịu trách nhiệm liên quan từ đầu đến cuối vẫn chưa đưa ra lời giải thích thỏa đáng.",
          "explanation": "\"始终没有给出\" phê phán sự né tránh trách nhiệm kéo dài liên tục."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 52,
      "name": "Phó từ thời điểm linh hoạt bất định \"随时\" (Bất cứ lúc nào / Sẵn sàng mọi lúc)",
      "pattern": "Chủ ngữ + 随时 + Động từ + Tân ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"随时\" (suíshí) biểu thị một hành động hoặc trạng thái có thể xảy ra hoặc sẵn sàng thực hiện ở bất kỳ thời điểm nào, không bị gò bó bởi thời gian cụ thể (bất cứ khi nào, mọi lúc).",
      "examples": [
        {
          "chinese": "如果有任何问题，您可以随时通过微信或电话与我联系。",
          "pinyin": "Rúguǒ yǒu rènhé wèntí, nín kěyǐ suíshí tōngguò wēixìn huò diànhuà yǔ wǒ liánxì.",
          "translation_vi": "Nếu có bất kỳ câu hỏi nào, quý khách có thể liên hệ với tôi bất cứ lúc nào qua WeChat hoặc điện thoại.",
          "explanation": "\"随时...联系\" là lời hẹn lịch thiệp thể hiện sự sẵn sàng hỗ trợ khách hàng 24/7."
        },
        {
          "chinese": "山区的气候多变，随时都可能下起倾盆大雨，出行需带好雨具。",
          "pinyin": "Shānqū de qìhòu duōbiàn, suíshí dōu kěnéng xiàqǐ qīngpén dàyǔ, chūxíng xū dài hǎo yǔjù.",
          "translation_vi": "Khí hậu vùng núi thay đổi thất thường, bất cứ lúc nào cũng có thể đổ mưa rào xối xả, đi lại cần mang sẵn đồ che mưa.",
          "explanation": "\"随时都可能\" diễn tả khả năng thời tiết biến đổi đột ngột bất chợt."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 53,
      "name": "Giới từ chỉ phạm vi đối tượng đề cập \"关于\" (Về / Liên quan đến)",
      "pattern": "关于 + Danh từ / Đoản ngữ, Chủ ngữ + Vị ngữ / Về... (Định ngữ + 的 + Danh từ)",
      "category": "Giới từ",
      "explanation_vi": "\"关于\" (guānyú) dùng để dẫn ra phạm vi sự vật, vấn đề cần nói tới hoặc tìm hiểu (liên quan đến, về vấn đề). Thường đứng ở đầu câu ngăn cách bằng dấu phẩy, hoặc làm định ngữ bổ nghĩa cho danh từ có chữ \"的\" (ví dụ: 关于这个问题的看法).",
      "examples": [
        {
          "chinese": "关于这次留学申请的具体流程，你可以参考招生简章。",
          "pinyin": "Guānyú zhè cì liúxué shēnqǐng de jùtǐ liúchéng, nǐ kěyǐ cānkǎo zhāoshēng jiǎnzhāng.",
          "translation_vi": "Về quy trình cụ thể của đợt nộp hồ sơ du học lần này, bạn có thể tham khảo đề án tuyển sinh.",
          "explanation": "\"关于这次留学申请...\" đứng đầu câu xác lập chủ đề thảo luận về các bước nộp hồ sơ du học."
        },
        {
          "chinese": "王教授刚刚发表了一本关于中国传统文化的新书。",
          "pinyin": "Wáng jiàoshòu gānggāng fābiǎo le yì běn guānyú Zhōngguó chuántǒng wénhuà de xīn shū.",
          "translation_vi": "Giáo sư Vương vừa mới xuất bản một cuốn sách mới về văn hóa truyền thống Trung Quốc.",
          "explanation": "Cụm giới tân \"关于中国传统文化\" làm định ngữ có \"的\" hạn định nội dung chủ đề của cuốn sách."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 54,
      "name": "Giới từ chỉ đối tượng tiếp nhận hành vi \"对于\" (Đối với / Về mặt)",
      "pattern": "对于 + Đối tượng, Chủ ngữ + Vị ngữ / Chủ ngữ + 对于 + Đối tượng + Vị ngữ",
      "category": "Giới từ",
      "explanation_vi": "\"对于\" (duìyú) chỉ đối tượng được nhắm tới, tiếp nhận sự đối đãi, thái độ, hoặc hành vi nhận thức (đối với). Khác với \"关于\" (chỉ phạm vi đề tài, sách báo, hội nghị), \"对于\" nhấn mạnh quan hệ tác động trực tiếp hoặc thái độ tâm lý (như 对于这件事我很重视).",
      "examples": [
        {
          "chinese": "对于大家提出的宝贵建议，公司领导层表示高度重视。",
          "pinyin": "Duìyú dàjiā tíchū de bǎoguì jiànyì, gōngsī lǐngdǎocéng biǎoshì gāodù zhòngshì.",
          "translation_vi": "Đối với những kiến nghị quý báu mà mọi người nêu ra, ban lãnh đạo công ty bày tỏ sự coi trọng cao độ.",
          "explanation": "\"对于大家提出的宝贵建议\" là đối tượng được ban lãnh đạo tiếp nhận và xem xét nghiêm túc."
        },
        {
          "chinese": "多做模拟题对于提高汉语考试成绩有极大的帮助。",
          "pinyin": "Duō zuò mónǐ tí duìyú tígāo hànyǔ kǎoshì chéngjì yǒu jídà de bāngzhù.",
          "translation_vi": "Làm nhiều đề thi thử đối với việc nâng cao thành tích thi tiếng Trung có sự trợ giúp rất lớn.",
          "explanation": "\"对于提高...成绩\" là đối tượng hưởng lợi ích từ việc luyện đề thi thử."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 55,
      "name": "Giới từ/Liên từ chuyển mạch chủ đề \"至于\" (Còn về / Đến mức)",
      "pattern": "Chủ đề 1..., 至于 + Chủ đề 2 + Mệnh đề / 不至于 + Kết quả xấu",
      "category": "Giới từ",
      "explanation_vi": "\"至于\" (zhìyú) có hai cách dùng quan trọng: 1) Đứng đầu vế câu sau để chuyển hướng câu chuyện sang một đối tượng hoặc chủ đề khác (còn về, còn đối với); 2) Biểu thị đạt đến mức độ nghiêm trọng (thường dùng ở dạng phủ định \"不至于\" - không đến nỗi, không đến mức).",
      "examples": [
        {
          "chinese": "这几个大问题我们已经解决了，至于具体的细节，明天再讨论。",
          "pinyin": "Zhè jǐ gè dà wèntí wǒmen yǐjīng jiějué le, zhìyú jùtǐ de xìjié, míngtiān zài tǎolùn.",
          "translation_vi": "Mấy vấn đề lớn này chúng ta đã giải quyết xong rồi, còn về chi tiết cụ thể, ngày mai sẽ thảo luận tiếp.",
          "explanation": "\"至于具体的细节\" chuyển mạch bàn luận từ vấn đề tổng thể sang các tiểu tiết kỹ thuật."
        },
        {
          "chinese": "虽然这次比赛没有拿到冠军，但我们也不至于感到绝望。",
          "pinyin": "Suīrán zhè cì bǐsài méiyǒu nádào guànjūn, dàn wǒmen yě bú zhìyú gǎndào juéwàng.",
          "translation_vi": "Tuy rằng cuộc thi lần này không đoạt cúp vô địch, nhưng chúng tôi cũng không đến mức cảm thấy tuyệt vọng.",
          "explanation": "\"不至于\" biểu thị mức độ thất vọng vẫn nằm trong tầm kiểm soát, chưa đến bờ vực bi quan cực đoan."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 56,
      "name": "Giới từ chỉ căn cứ chuẩn mực \"按照\" (Căn cứ vào / Theo / Chiểu theo)",
      "pattern": "按照 + Tiêu chuẩn/Quy định/Kế hoạch + Động từ + Tân ngữ",
      "category": "Giới từ",
      "explanation_vi": "\"按照\" (ànzhào) biểu thị việc tiến hành một hành động tuân thủ nghiêm ngặt theo một tiêu chuẩn, quy tắc, chỉ thị, hoặc thỏa thuận có sẵn (căn cứ theo, làm theo). Thường đi với các từ như 规定, 计划, 要求, 标准, 顺序.",
      "examples": [
        {
          "chinese": "所有参赛选手都必须按照比赛规则按时提交作品。",
          "pinyin": "Suǒyǒu cànsài xuǎnshǒu dōu bìxū ànzhào bǐsài guīzé ànshí tíjiāo zuòpǐn.",
          "translation_vi": "Tất cả các thí sinh dự thi đều phải nộp tác phẩm đúng hạn căn cứ theo quy chế cuộc thi.",
          "explanation": "\"按照比赛规则\" xác lập chuẩn mực pháp lý buộc thí sinh phải chấp hành giờ giấc."
        },
        {
          "chinese": "工程队正在按照原定计划抓紧施工，确保按期完工。",
          "pinyin": "Gōngchéngduì zhèngzài ànzhào yuándìng jìhuà zhuājǐn shīgōng, quèbǎo ànqī wángōng.",
          "translation_vi": "Đội thi công đang khẩn trương xây dựng theo kế hoạch định sẵn, bảo đảm hoàn thành đúng tiến độ.",
          "explanation": "\"按照原定计划\" làm rõ việc thi công tuân thủ đúng lộ trình tiến độ ban đầu."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 57,
      "name": "Giới từ chỉ cơ sở lập luận thực tế \"根据\" (Căn cứ vào / Dựa trên)",
      "pattern": "根据 + Dữ liệu/Khảo sát/Tình hình thực tế, Mệnh đề phán đoán",
      "category": "Giới từ",
      "explanation_vi": "\"根据\" (gēnjù) vừa là giới từ vừa là danh từ. Khi làm giới từ, nó dẫn ra căn cứ khách quan, sự thật, số liệu điều tra hoặc dữ kiện thực tế để làm cơ sở cho một phán đoán, kết luận hoặc hành động. So với \"按照\" (thiên về quy định chuẩn mực con người đặt ra), \"根据\" thiên về sự kiện thực tế và nghiên cứu khoa học.",
      "examples": [
        {
          "chinese": "根据气象部门发布的最新预报，今天傍晚将有雷阵雨。",
          "pinyin": "Gēnjù qìxiàng bùmén fābù de zuìxīn yùbào, jīntiān bàngwǎn jiāng yǒu léizhènyǔ.",
          "translation_vi": "Dựa trên dự báo mới nhất do cơ quan khí tượng công bố, chiều tối nay sẽ có mưa dông.",
          "explanation": "\"根据...最新预报\" dẫn ra nguồn tin tức khoa học xác thực làm căn cứ nhận định thời tiết."
        },
        {
          "chinese": "医生会根据每位病人的身体状况制定最合适的治疗方案。",
          "pinyin": "Yīshēng huì gēnjù měi wèi bìngrén de shēntǐ zhuàngkuàng zhìdìng zuì héshì de zhìliáo fāng'àn.",
          "translation_vi": "Bác sĩ sẽ căn cứ vào tình trạng sức khỏe của từng bệnh nhân để lập ra phác đồ điều trị phù hợp nhất.",
          "explanation": "\"根据每位病人的身体状况\" cho thấy việc trị liệu dựa sát vào tình trạng thực tế cá thể hóa."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 58,
      "name": "Giới từ chỉ tinh thần và phương châm chỉ đạo \"本着\" (Trên tinh thần / Dựa trên nguyên tắc)",
      "pattern": "本着 + Nguyên tắc/Phương châm/Tinh thần + 的原则/态度, Mệnh đề",
      "category": "Giới từ",
      "explanation_vi": "\"本着\" (běnzhe) là giới từ trang trọng trong văn viết chính luận, thương mại và pháp lý, mang nghĩa là xuất phát từ hoặc lấy một phương châm, tôn chỉ, nguyên tắc chỉ đạo tốt đẹp nào đó làm kim chỉ nam cho hành động.",
      "examples": [
        {
          "chinese": "双方本着平等互利的原则，签署了长期战略合作协议。",
          "pinyin": "Shuāngfāng běnzhe píngděng hùlì de yuánzé, qiānshǔ le chángqī zhànlüè hézuò xiéyì.",
          "translation_vi": "Đôi bên trên tinh thần nguyên tắc bình đẳng cùng có lợi, đã ký kết thỏa thuận hợp tác chiến lược dài hạn.",
          "explanation": "\"本着平等互利的原则\" là phương châm chỉ đạo chuẩn mực trong đàm phán hợp đồng kinh tế quốc tế."
        },
        {
          "chinese": "我们本着对消费者负责的态度，对这批产品进行了全面复检。",
          "pinyin": "Wǒmen běnzhe duì xiāofèizhě fùzé de tàidu, duì zhè pī chǎnpǐn jìnxíng le quánmiàn fùjiǎn.",
          "translation_vi": "Chúng tôi với thái độ chịu trách nhiệm đối với người tiêu dùng, đã tiến hành kiểm tra lại toàn diện lô hàng này.",
          "explanation": "\"本着...的态度\" thể hiện tinh thần trách nhiệm cao của nhà sản xuất."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 59,
      "name": "Giới từ dựa vào năng lực hoặc bằng chứng \"凭\" (Dựa vào / Dựa trên / Bằng)",
      "pattern": "凭 + Năng lực/Kinh nghiệm/Giấy tờ + Động từ + Tân ngữ",
      "category": "Giới từ",
      "explanation_vi": "\"凭\" (píng) biểu thị hành động được thực hiện dựa vào một kỹ năng chủ quan (kinh nghiệm, cảm giác, năng lực), hoặc dựa vào một điều kiện giấy tờ/bằng chứng khách quan (vé vào cửa, chứng minh nhân dân, giấy thông hành).",
      "examples": [
        {
          "chinese": "他凭着丰富的实践经验，很快就排除了这台机器的故障。",
          "pinyin": "Tā píngzhe fēngfù de shíjiàn jīngyàn, hěn kuài jiù páichú le zhè tái jīqì de gùzhàng.",
          "translation_vi": "Nhờ dựa vào kinh nghiệm thực tiễn phong phú, anh ấy đã rất nhanh chóng loại trừ được sự cố của cỗ máy này.",
          "explanation": "\"凭着丰富的实践经验\" làm rõ yếu tố giúp người thợ kỹ thuật giải quyết hỏng hóc máy móc."
        },
        {
          "chinese": "进入音乐厅前，请各位观众凭门票到入口处检票入场。",
          "pinyin": "Jìnrù yīnyuètīng qián, qǐng gèwèi guānzhòng píng ménpiào dào rùkǒuchù jiǎnpiào rùchǎng.",
          "translation_vi": "Trước khi vào phòng hòa nhạc, xin quý vị khán giả xuất trình vé để soát vé vào cửa.",
          "explanation": "\"凭门票\" (dựa vào vé) là điều kiện thủ tục bắt buộc để được phép vào khán phòng."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 60,
      "name": "Giới từ chỉ chủ thể phụ trách hoặc nguồn gốc \"由\" (Do / Bởi / Từ)",
      "pattern": "由 + Chủ thể phụ trách + Động từ + Tân ngữ / 由...组成",
      "category": "Giới từ",
      "explanation_vi": "\"由\" (yóu) có hai cách dùng chính: 1) Dẫn ra người hoặc cơ quan chịu trách nhiệm thực hiện, chi trả, hoặc phụ trách một việc (như 由他负责, 由学校出资); 2) Biểu thị thành phần cấu tạo nên một chỉnh thể (như 由三部分组成 - do ba phần cấu thành).",
      "examples": [
        {
          "chinese": "这次国际学术研讨会的所有接待工作由外事办公室全权负责。",
          "pinyin": "Zhè cì guójì xuéshù yántǎohuì de suǒyǒu jiēdài gōngzuò yóu wàishì bàngōngshì quánquán fùzé.",
          "translation_vi": "Toàn bộ công tác đón tiếp của hội thảo học thuật quốc tế lần này do văn phòng đối ngoại toàn quyền phụ trách.",
          "explanation": "\"由外事办公室...负责\" chỉ rõ cơ quan có thẩm quyền và trách nhiệm tổ chức sự kiện."
        },
        {
          "chinese": "这个科研小组是由十位来自不同学科的年轻博士组成的。",
          "pinyin": "Zhè ge kēyán xiǎozǔ shì yóu shí wèi láizì bùtóng xuékē de niánqīng bóshì zǔchéng de.",
          "translation_vi": "Tổ nghiên cứu khoa học này do mười vị tiến sĩ trẻ đến từ các ngành học khác nhau tạo thành.",
          "explanation": "\"由...组成\" là cấu trúc biểu thị các thành viên cấu tạo nên một tổ chức nghiên cứu."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 61,
      "name": "Giới từ mốc thời gian khởi điểm \"自从\" (Kể từ khi / Từ lúc)",
      "pattern": "自从 + Mốc thời gian/Sự kiện, Chủ ngữ + Đã/Luôn + Vị ngữ",
      "category": "Giới từ",
      "explanation_vi": "\"自从\" (zìcóng) chỉ mốc thời gian bắt đầu xảy ra một trạng thái hay quá trình liên tục kéo dài cho đến tận thời điểm hiện tại hoặc thời điểm đang nói tới (từ khi, kể từ sau khi). So với \"从\", \"自从\" chỉ dùng cho thời gian trong quá khứ, không dùng cho địa điểm không gian.",
      "examples": [
        {
          "chinese": "自从上了大学以后，他学会了独立安排自己的日常生活。",
          "pinyin": "Zìcóng shàng le dàxué yǐhòu, tā xuéhuì le dúlì ānpái zìjǐ de rìcháng shēnghuó.",
          "translation_vi": "Kể từ sau khi bước chân vào đại học, cậu ấy đã học được cách tự lập sắp xếp đời sống hằng ngày của mình.",
          "explanation": "\"自从上了大学以后\" xác định mốc biến cố quan trọng mở đầu cho quá trình trưởng thành tự lập."
        },
        {
          "chinese": "自从搬进这套新公寓，他的睡眠质量有了明显的改善。",
          "pinyin": "Zìcóng bānjìn zhè tào xīn gōngyù, tā de shuìmián zhìliàng yǒu le míngxiǎn de gǎishàn.",
          "translation_vi": "Kể từ khi dọn vào căn hộ mới này, chất lượng giấc ngủ của anh ấy đã có sự cải thiện rõ rệt.",
          "explanation": "\"自从...\" liên kết thời điểm chuyển nhà với chuỗi biến đổi tích cực về sức khỏe."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 62,
      "name": "Giới từ nắm bắt thời cơ thuận lợi \"趁\" (Nhân dịp / Thừa cơ / Tiện lúc)",
      "pattern": "趁 + Cơ hội/Thời gian thuận lợi, Chủ ngữ + Động từ + Tân ngữ",
      "category": "Giới từ",
      "explanation_vi": "\"趁\" (chèn) biểu thị việc tranh thủ hoặc nắm bắt một điều kiện thời gian, hoàn cảnh hoặc trạng thái thuận lợi đang diễn ra để thực hiện một hành động trước khi điều kiện đó qua đi (thừa dịp, nhân lúc). Thường gặp: 趁热 (nhân lúc còn nóng), 趁机 (thừa cơ), 趁年轻 (nhân lúc còn trẻ).",
      "examples": [
        {
          "chinese": "饺子刚刚煮好，你快趁热吃吧，凉了就不好吃了。",
          "pinyin": "Jiǎozi gānggāng zhǔhǎo, nǐ kuài chèn rè chī ba, liáng le jiù bù hǎochī le.",
          "translation_vi": "Bánh sủi cảo vừa mới luộc chín xong, cậu hãy mau ăn lúc còn nóng đi, nguội rồi sẽ không ngon nữa.",
          "explanation": "\"趁热吃\" là cách nói văn hóa quen thuộc nhắc nhở thưởng thức món ăn khi nhiệt độ thơm ngon nhất."
        },
        {
          "chinese": "我们应该趁着年轻多学一些实用的知识和专业技能。",
          "pinyin": "Wǒmen yīnggāi chènzhe niánqīng duō xué yìxiē shíyòng de zhīshi hé zhuānyè jìnéng.",
          "translation_vi": "Chúng ta nên nhân lúc còn trẻ học thêm nhiều kiến thức thực tế và kỹ năng chuyên môn.",
          "explanation": "\"趁着年轻\" khuyên nhủ nắm bắt thời thanh xuân tràn đầy năng lượng để tích lũy học vấn."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 63,
      "name": "Giới từ định hướng mục tiêu \"朝\" (Hướng về / Về phía)",
      "pattern": "Chủ ngữ + 朝 + Phương hướng/Đối tượng + Động từ (走/看/跑/挥手)",
      "category": "Giới từ",
      "explanation_vi": "\"朝\" (cháo) là giới từ biểu thị hướng quay mặt hoặc phương hướng chuyển động của hành động nhắm tới (về phía, hướng tới). Thường đi với các động từ chỉ động thái như 走, 看, 望, 挥手, 拜, 笑. Khác với \"往\", \"朝\" nhấn mạnh góc quay hoặc đối tượng đối diện.",
      "examples": [
        {
          "chinese": "列车缓缓启动了，站台上的亲友们纷纷朝车窗挥手告别。",
          "pinyin": "Lièchē huǎnhuǎn qǐdòng le, zhàntái shang de qīnyǒumen fēnfēn cháo chēchuāng huīshǒu gàobié.",
          "translation_vi": "Đoàn tàu từ từ lăn bánh, người thân và bạn bè trên sân ga đồng loạt vẫy tay về phía cửa sổ toa tàu để từ biệt.",
          "explanation": "\"朝车窗挥手\" chỉ động tác vẫy tay hướng về phía khung cửa sổ tàu hỏa."
        },
        {
          "chinese": "出了地铁站之后，一直朝前走两百米就能看到那家书店。",
          "pinyin": "Chū le dìtiězhàn zhīhòu, yìzhí cháo qián zǒu liǎng bǎi mǐ jiù néng kàndào nà jiā shūdiàn.",
          "translation_vi": "Sau khi ra khỏi ga tàu điện ngầm, cứ đi thẳng về phía trước 200 mét là có thể nhìn thấy hiệu sách đó.",
          "explanation": "\"朝前走\" chỉ dẫn phương hướng tiến lên phía trước."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 64,
      "name": "Giới từ thay mặt hoặc vì lợi ích của người khác \"替\" (Thay cho / Giúp)",
      "pattern": "Chủ ngữ + 替 + Người khác + Động từ + Tân ngữ",
      "category": "Giới từ",
      "explanation_vi": "\"替\" (tì) có hai nghĩa chính: 1) Đại diện hoặc thay thế vị trí cho ai đó làm một việc gì (như 替他请假 - xin nghỉ hộ anh ấy); 2) Đứng về phía tình cảm hoặc lợi ích của người khác để đồng cảm (như 替你高兴 - mừng thay cho cậu, 替他担心 - lo lắng cho anh ấy).",
      "examples": [
        {
          "chinese": "听到你顺利通过高级汉语考试的消息，大家都很替你高兴。",
          "pinyin": "Tīngdào nǐ shùnlì tōngguò gāojí hànyǔ kǎoshì de xiāoxi, dàjiā dōu hěn tì nǐ gāoxìng.",
          "translation_vi": "Nghe tin cậu đã thuận lợi vượt qua kỳ thi tiếng Hán cao cấp, mọi người đều rất mừng cho cậu.",
          "explanation": "\"替你高兴\" thể hiện sự chia sẻ niềm vui chân thành đứng trên cương vị người bạn."
        },
        {
          "chinese": "如果明天下午你有急事去不了，我可以替你去参加开幕式。",
          "pinyin": "Rúguǒ míngtiān xiàwǔ nǐ yǒu jíshì qù bù liǎo, wǒ kěyǐ tì nǐ qù cānjiā kāimùshì.",
          "translation_vi": "Nếu chiều mai cậu có việc bận gấp không đi được, mình có thể thay cậu đi tham dự lễ khai mạc.",
          "explanation": "\"替你去参加\" là hành động đi thay mặt, đại diện dự sự kiện."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 65,
      "name": "Cặp liên từ tăng tiến đa tầng \"不仅...而且...\" (Không những... mà còn...)",
      "pattern": "Chủ ngữ + 不仅...而且... / 不但...而且... / 不仅 A, 而且 B",
      "category": "Liên từ",
      "explanation_vi": "Cặp liên từ \"不仅...而且...\" (bùjǐn... érqiě...) biểu thị quan hệ tăng tiến từ tầng nghĩa cơ sở lên tầng nghĩa sâu hơn hoặc rộng lớn hơn. Nếu hai vế cùng một chủ ngữ thì chủ ngữ đứng trước \"不仅\"; nếu hai vế khác chủ ngữ thì mỗi chủ ngữ đứng sau \"不仅\" và \"而且\".",
      "examples": [
        {
          "chinese": "多吃新鲜蔬菜水果不仅有益健康，而且能有效保持皮肤光泽。",
          "pinyin": "Duō chī xīnxiān shūcài shuǐguǒ bùjǐn yǒuyì jiànkāng, érqiě néng yǒuxiào bǎochí pífū guāngzé.",
          "translation_vi": "Ăn nhiều rau quả tươi chẳng những có lợi cho sức khỏe mà còn duy trì hiệu quả độ sáng bóng của làn da.",
          "explanation": "\"不仅...而且...\" cùng chung chủ ngữ, nâng cao tác dụng từ sức khỏe tổng quát lên tới sắc đẹp làn da."
        },
        {
          "chinese": "不仅老师赞扬了他的勇敢举动，而且同学们也纷纷向他学习。",
          "pinyin": "Bùjǐn lǎoshī zànyáng le tā de yǒnggǎn jǔdòng, érqiě tóngxuémen yě fēnfēn xiàng tā xuéxí.",
          "translation_vi": "Không chỉ thầy cô ngợi khen hành động dũng cảm của cậu ấy, mà các bạn học sinh cũng đồng loạt noi gương học tập.",
          "explanation": "Khác chủ ngữ (\"老师\" và \"同学们\"), \"不仅\" đứng đầu vế một và \"而且\" đứng đầu vế hai."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 66,
      "name": "Liên từ tăng tiến cực hạn \"甚至\" (Thậm chí / Ngay cả)",
      "pattern": "Vế 1, 甚至 + (连...) + Vế 2 / A, B, 甚至 C",
      "category": "Liên từ",
      "explanation_vi": "\"甚至\" (shènzhì) nêu ra một trường hợp hoặc ví dụ cực đoan, nổi bật nhất để nhấn mạnh mức độ tăng tiến phi thường của sự việc. Có thể dùng để liên kết các từ, ngữ hoặc các phân câu độc lập.",
      "examples": [
        {
          "chinese": "这道数学题太难了，很多大学生都做不出来，甚至连老师都答不上来。",
          "pinyin": "Zhè dào shùxué tí tài nán le, hěn duō dàxuéshēng dōu zuò bù chūlái, shènzhì lián lǎoshī dōu dá bú shànglái.",
          "translation_vi": "Bài toán này quá khó, rất nhiều sinh viên đại học đều không giải được, thậm chí ngay cả giáo viên cũng không trả lời nổi.",
          "explanation": "\"甚至连老师...\" đẩy độ khó lên mức cực hạn, vượt quá tầm kiến thức thông thường."
        },
        {
          "chinese": "为了赶工期，工人们经常加班到深夜，有时候甚至彻夜不眠。",
          "pinyin": "Wèile gǎn gōngqī, gōngrénmen jīngcháng jiābān dào shēnyè, yǒu shíhou shènzhì chèyè bù mián.",
          "translation_vi": "Để kịp tiến độ thi công, các công nhân thường tăng ca đến tận đêm khuya, có lúc thậm chí thức trắng suốt đêm.",
          "explanation": "\"甚至彻夜不眠\" tăng tiến cường độ lao động vất vả từ đêm muộn đến trắng đêm."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 67,
      "name": "Liên từ bổ sung lý do xác đáng \"况且\" (Hơn nữa / Vả lại)",
      "pattern": "Lý do 1, 况且 + Lý do 2 (thuyết phục hơn) + Kết luận",
      "category": "Liên từ",
      "explanation_vi": "\"况且\" (kuàngqiě) dùng ở vế sau để bổ sung thêm một lý do hoặc điều kiện hiển nhiên khác, làm cho luận điểm hoặc quyết định được đưa ra càng thêm vững chắc, có sức thuyết phục cao hơn (vả lại, hơn nữa).",
      "examples": [
        {
          "chinese": "现在下着大暴雨，况且路灯也坏了，你一个人走夜路太危险了。",
          "pinyin": "Xiànzài xiàzhe dà bàoyǔ, kuàngqiě lùdēng yě huài le, nǐ yí gè rén zǒu yèlù tài wēixiǎn le.",
          "translation_vi": "Bây giờ trời đang mưa to tầm tã, hơn nữa đèn đường cũng hỏng rồi, bạn đi đường đêm một mình quá nguy hiểm.",
          "explanation": "\"况且路灯也坏了\" bổ sung thêm lý do thứ hai thuyết phục đối phương không nên ra đường ban đêm."
        },
        {
          "chinese": "我们已经准备了整整三个月，况且大家经验丰富，一定能圆满完成任务。",
          "pinyin": "Wǒmen yǐjīng zhǔnbèi le zhěngzhěng sān gè yuè, kuàngqiě dàjiā jīngyàn fēngfù, yídìng néng yuánmǎn wánchéng rènwu.",
          "translation_vi": "Chúng ta đã chuẩn bị tròn ba tháng ròng, hơn nữa mọi người lại giàu kinh nghiệm, nhất định sẽ hoàn thành mỹ mãn nhiệm vụ.",
          "explanation": "\"况且\" củng cố niềm tin thành công bằng việc viện dẫn kinh nghiệm dày dạn của đội ngũ."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 68,
      "name": "Liên từ tăng tiến tương phản ngụ ý \"何况\" (Huống hồ / Huống chi)",
      "pattern": "Tình huống A (dễ/gần) + Còn như vậy, 何况 + Tình huống B (khó/xa)",
      "category": "Liên từ",
      "explanation_vi": "\"何况\" (hékuàng) biểu thị ý nghĩa: ngay cả trường hợp thông thường, đối tượng mạnh mẽ/dễ hơn còn như vậy thì huống chi trường hợp đặc biệt, đối tượng yếu hơn (huống hồ, huống chi). Thường dùng trong so sánh ngầm mang tính tu từ mạnh mẽ.",
      "examples": [
        {
          "chinese": "成年人走这么陡峭的山路都很吃力，何况是几岁的小孩子呢？",
          "pinyin": "Chéngniánrén zǒu zhème dǒuqìao de shānlù dōu hěn chīlì, hékuàng shì jǐ suì de xiǎoháizi ne?",
          "translation_vi": "Người lớn đi con đường núi dốc đứng thế này còn rất tốn sức, huống chi là đứa trẻ con mấy tuổi đầu chứ?",
          "explanation": "Cấu trúc so sánh tương phản ngụ ý: người lớn còn chịu không nổi thì trẻ nhỏ càng không thể."
        },
        {
          "chinese": "本地人都经常在这座立交桥上迷路，何况你是第一次来这里的游客。",
          "pinyin": "Běndìrén dōu jīngcháng zài zhè zuò lìjiāoqiáo shang mílù, hékuàng nǐ shì dì yī cì lái zhèlǐ de yóukè.",
          "translation_vi": "Người bản xứ còn thường xuyên bị lạc đường trên cây cầu vượt này, huống hồ cậu lại là du khách lần đầu tiên đến đây.",
          "explanation": "\"何况\" cảm thông cho việc lạc đường của du khách bằng cách đối chiếu với người bản địa."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 69,
      "name": "Liên từ chỉ hệ quả và bước tiến tiếp theo \"从而\" (Do đó mà / Nhờ đó mà)",
      "pattern": "Biện pháp/Hành động, 从而 + Kết quả/Ý nghĩa tiến bộ",
      "category": "Liên từ",
      "explanation_vi": "\"从而\" (cóng'ér) là liên từ trang trọng nối liền nguyên nhân/biện pháp ở vế trước với kết quả, mục đích hoặc bước phát triển tất yếu ở vế sau (do đó mà, nhờ vậy mà). Vế sau thường là một kết quả tích cực, nâng cao chất lượng hoặc đạt được mục tiêu lớn.",
      "examples": [
        {
          "chinese": "公司引进了最先进的自动化设备，从而大幅降低了生产成本。",
          "pinyin": "Gōngsī yǐnjìn le zuì xiānjìn de zìdònghuà shèbèi, cóng'ér dàfú jiàngdī le shēngchǎn chéngběn.",
          "translation_vi": "Công ty đã du nhập thiết bị tự động hóa tiên tiến nhất, nhờ đó mà giảm mạnh chi phí sản xuất.",
          "explanation": "\"从而大幅降低...\" nối liền biện pháp cải tiến công nghệ với thành quả kinh tế to lớn đạt được."
        },
        {
          "chinese": "坚持每天阅读可以开阔视野，从而提高个人的综合文化修养。",
          "pinyin": "Jiānchí měitiān yuèdú kěyǐ kāikuò shìyě, cóng'ér tígāo gèrén de zōnghé wénhuà xiūyǎng.",
          "translation_vi": "Kiên trì đọc sách mỗi ngày có thể mở rộng tầm mắt, nhờ đó nâng cao tu dưỡng văn hóa tổng hợp của cá nhân.",
          "explanation": "\"从而\" diễn tả bước tiến nâng cao phẩm chất tinh thần xuất phát từ thói quen đọc sách."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 70,
      "name": "Liên từ suy luận kết quả tự nhiên \"因而\" (Vì vậy / Cho nên)",
      "pattern": "Nguyên nhân thực tế, 因而 + Kết quả tất yếu",
      "category": "Liên từ",
      "explanation_vi": "\"因而\" (yīn'ér) là liên từ kết hợp \"因\" (vì) và \"而\" (thì/cho nên), tương đương với \"因此\" hoặc \"所以\", dùng trong văn viết và phong cách nghị luận trang trọng để kết nối mối quan hệ nhân quả logic.",
      "examples": [
        {
          "chinese": "他在科学实验中付出了极大的心血，因而取得了举世瞩目的成就。",
          "pinyin": "Tā zài kēxué shíyàn zhōng fùchū le jídà de xīnxuè, yīn'ér qǔdé le jǔshì zhǔmù de chéngjiù.",
          "translation_vi": "Ông đã bỏ ra tâm huyết to lớn trong các thí nghiệm khoa học, vì vậy đã gặt hái được những thành tựu khiến cả thế giới dõi theo.",
          "explanation": "\"因而取得了...\" là kết quả xứng đáng đền đáp cho công lao nghiên cứu kiên trì."
        },
        {
          "chinese": "由于双方观点存在根本分歧，因而这次商务洽谈未能达成最终共识。",
          "pinyin": "Yóuyú shuāngfāng guāndiǎn cúnzài gēnběn fēnqí, yīn'ér zhè cì shāngwù qiàtán wèinéng dáchéng zuìzhōng gòngshí.",
          "translation_vi": "Do quan điểm của đôi bên tồn tại bất đồng căn bản, vì vậy cuộc đàm phán thương mại lần này đã không thể đạt được đồng thuận cuối cùng.",
          "explanation": "\"因而\" liên kết sự bất đồng quan điểm với kết quả đàm phán bất thành."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 71,
      "name": "Cặp liên từ tiền đề hiển nhiên \"既然...就...\" (Đã... thì...)",
      "pattern": "既然 + Sự thật đã rồi / Tiền đề được thừa nhận, (Chủ ngữ) + 就 + Kết luận/Hành động",
      "category": "Liên từ",
      "explanation_vi": "\"既然...就...\" (jìrán... jiù...) dùng khi sự việc ở vế trước đã là một thực tế hiển nhiên, được cả người nói và người nghe thừa nhận, từ đó vế sau đưa ra quyết định, giải pháp hoặc lời khuyên hợp tình hợp lý (đã thế thì hãy làm thế).",
      "examples": [
        {
          "chinese": "既然大家对此都没有异议，我们就按照这个方案开始执行吧。",
          "pinyin": "Jìrán dàjiā duì cǐ dōu méiyǒu yìyì, wǒmen jiù ànzhào zhè ge fāng'àn kāishǐ zhíxíng ba.",
          "translation_vi": "Đã mọi người đều không có dị nghị gì về điều này, thì chúng ta hãy bắt đầu triển khai theo phương án này đi.",
          "explanation": "\"既然...就...\" dựa trên tiền đề mọi người đồng thuận để đưa ra quyết định khởi động dự án."
        },
        {
          "chinese": "既然你身体不舒服，就留在宿舍里好好休息，别去跑步了。",
          "pinyin": "Jìrán nǐ shēntǐ bù shūfu, jiù liú zài sùshè lǐ hǎohǎo xiūxi, bié qù pǎobù le.",
          "translation_vi": "Đã cậu cảm thấy trong người không khỏe, thì hãy ở lại ký túc xá nghỉ ngơi thật tốt, đừng đi chạy bộ nữa.",
          "explanation": "\"既然\" thừa nhận trạng thái mệt mỏi của người bạn để đưa ra lời khuyên nghỉ ngơi hợp lý."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 72,
      "name": "Cặp liên từ giả thiết nhượng bộ tột bực \"哪怕...也...\" (Dù cho... cũng...)",
      "pattern": "哪怕 + Điều kiện cực đoan/Khó khăn nhất, 主语 + 也 + Quyết tâm/Hành vi",
      "category": "Liên từ",
      "explanation_vi": "\"哪怕...也...\" (nǎpà... yě...) biểu thị sự nhượng bộ giả định đối với một điều kiện cực đoan, khó khăn nhất có thể tưởng tượng ra, nhưng kết quả hoặc quyết tâm ở vế sau vẫn kiên định không hề lay chuyển (cho dù... cũng vẫn cứ).",
      "examples": [
        {
          "chinese": "哪怕前方的道路再艰难，我们也绝不会放弃自己的梦想。",
          "pinyin": "Nǎpà qiánfāng de dàolù zài jiānnán, wǒmen yě jué bú huì fàngqì zìjǐ de mèngxiǎng.",
          "translation_vi": "Dù cho con đường phía trước có gian nan đến mấy, chúng tôi cũng tuyệt đối không từ bỏ ước mơ của mình.",
          "explanation": "\"哪怕...也绝不会放弃\" khẳng định quyết tâm theo đuổi lý tưởng bất chấp muôn trùng chông gai."
        },
        {
          "chinese": "哪怕只剩下一线希望，医生们也会竭尽全力抢救这名伤员。",
          "pinyin": "Nǎpà zhǐ shèngxià yí xiàn xīwàng, yīshēngmen yě huì jiéjìn quánlì qiǎngjiù zhè míng shāngyuán.",
          "translation_vi": "Dù cho chỉ còn lại một tia hy vọng mong manh, các bác sĩ cũng sẽ dốc hết toàn lực cứu chữa người bị thương này.",
          "explanation": "\"哪怕只剩下一线希望\" thể hiện y đức cao cả không bỏ cuộc trước sự sống."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 73,
      "name": "Cặp liên từ nhượng bộ trang trọng \"即便...也...\" (Cho dù... cũng...)",
      "pattern": "即便 + Tình huống giả thiết bất lợi, 主语 + 也 + Vị ngữ",
      "category": "Liên từ",
      "explanation_vi": "\"即便...也...\" (jíbiàn... yě...) tương đương với \"即使...也...\", nhưng mang sắc thái trang nhã, văn phong uyển chuyển và học thuật hơn (cho dù... thì vẫn cứ). Thường dùng để biện luận trong văn viết chính luận.",
      "examples": [
        {
          "chinese": "即便在最困难的岁月里，他也始终没有丧失对未来的信心。",
          "pinyin": "Jíbiàn zài zuì kùnnan de suìyuè lǐ, tā yě shǐzhōng méiyǒu sàngshī duì wèilái de xìnxīn.",
          "translation_vi": "Cho dù ở vào những năm tháng khó khăn nhất, ông ấy cũng luôn luôn không đánh mất niềm tin vào tương lai.",
          "explanation": "\"即便...也...\" diễn tả nghị lực phi thường giữ trọn niềm tin qua thử thách khắc nghiệt."
        },
        {
          "chinese": "即便这项技术目前还不成熟，我们也有必要进行深入的预先研究。",
          "pinyin": "Jíbiàn zhè xiàng jìshù mùqián hái bù chéngshú, wǒmen yě yǒu bìyào jìnxíng shēnrù de yùxiān yánjiū.",
          "translation_vi": "Cho dù công nghệ này hiện tại vẫn chưa hoàn thiện, chúng ta cũng cần thiết phải tiến hành nghiên cứu đón đầu chuyên sâu.",
          "explanation": "\"即便...也有必要\" bảo vệ tính cần thiết của việc đón đầu công nghệ tương lai."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 74,
      "name": "Cặp liên từ chuyển ngoặt hiện thực \"尽管...但是/却...\" (Mặc dù... nhưng...)",
      "pattern": "尽管 + Sự thật khách quan, 但是 / 可是 / 却 + Kết quả tương phản",
      "category": "Liên từ",
      "explanation_vi": "\"尽管...但是...\" (jǐnguǎn... dànshì...) biểu thị quan hệ chuyển ngoặt trên cơ sở sự thật đã xảy ra hoặc đang tồn tại (khác với \"即使\" dùng cho giả thiết chưa xảy ra). Vế đầu thừa nhận một thực tế cản trở, vế sau dùng \"但是\" hoặc \"却\" nêu ra kết quả bất ngờ trái ngược.",
      "examples": [
        {
          "chinese": "尽管外面的天气非常严寒，但是大厅里的气氛却格外热烈。",
          "pinyin": "Jǐnguǎn wàimiàn de tiānqì fēicháng yánhán, dànshì dàtīng lǐ de qìfēn què géwài rèliè.",
          "translation_vi": "Mặc dù thời tiết bên ngoài vô cùng giá rét, nhưng bầu không khí bên trong đại sảnh lại hết sức ấm cúng náo nhiệt.",
          "explanation": "\"尽管...但是...却\" làm nổi bật sự đối lập sinh động giữa nhiệt độ ngoài trời và không khí trong hội trường."
        },
        {
          "chinese": "尽管遇到了许多意料之外的挑战，团队最终还是按时交付了产品。",
          "pinyin": "Jǐnguǎn yùdào le xǔduō yìliào zhīwài de tiǎozhàn, tuánduì zuìzhōng háishì ànshí jiāofù le chǎnpǐn.",
          "translation_vi": "Mặc dù đã gặp phải rất nhiều thách thức ngoài dự liệu, đội ngũ cuối cùng vẫn bàn giao sản phẩm đúng hạn.",
          "explanation": "\"尽管...\" ghi nhận sự gian khổ của tập thể để tôn vinh kết quả bàn giao dự án xuất sắc."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 75,
      "name": "Cấu trúc lựa chọn xả thân nhượng bộ \"宁可...也不...\" (Thà rằng... chứ không...)",
      "pattern": "Chủ ngữ + 宁可 + Phương án hy sinh/chấp nhận thiệt thòi, 也不 + Phương án vi phạm nguyên tắc",
      "category": "Liên từ",
      "explanation_vi": "\"宁可...也不...\" (nìngkě... yě bù...) biểu thị sự so sánh giữa hai khả năng bất lợi, trong đó chủ thể tình nguyện chấp nhận phương án thứ nhất (dù gian khổ, tốn kém hoặc chịu thiệt thòi) chứ quyết không bao giờ chấp nhận phương án thứ hai (vì vi phạm đạo đức, nguyên tắc hoặc phẩm giá cá nhân).",
      "examples": [
        {
          "chinese": "他宁可自己多吃点儿苦，也绝不给别人添麻烦。",
          "pinyin": "Tā nìngkě zìjǐ duō chī diǎnr kǔ, yě jué bù gěi biérén tiān máfan.",
          "translation_vi": "Anh ấy thà rằng bản thân chịu khổ thêm một chút, chứ quyết không gây phiền hà cho người khác.",
          "explanation": "\"宁可...也绝不...\" thể hiện phẩm chất tự trọng cao, sẵn sàng chịu vất vả vì tập thể."
        },
        {
          "chinese": "我们宁可在前期调研中多花时间，也不能盲目上马未经论证的项目。",
          "pinyin": "Wǒmen nìngkě zài qiánqī diàoyán zhōng duō huā shíjiān, yě bù néng mángmù shàngmǎ wèijīng lùnzhèng de xiàngmù.",
          "translation_vi": "Chúng ta thà rằng dành nhiều thời gian hơn trong khâu khảo sát ban đầu, chứ không thể mù quáng triển khai dự án chưa qua kiểm định.",
          "explanation": "\"宁可...也不能...\" nhấn mạnh nguyên tắc thận trọng khoa học trong quản lý dự án."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 76,
      "name": "Cấu trúc lựa chọn thông minh ưu việt \"与其...不如...\" (Thà rằng... còn hơn / Thay vì... thì nên...)",
      "pattern": "与其 + Phương án kém hiệu quả/thụ động, 不如 + Phương án sáng suốt/chủ động",
      "category": "Liên từ",
      "explanation_vi": "\"与其...不如...\" (yǔqí... bùrú...) dùng để so sánh hai phương án giải quyết vấn đề, nhằm khuyên bảo hoặc quyết định từ bỏ phương án ở vế trước (thụ động, tốn công vô ích) để lựa chọn phương án ở vế sau (thông minh, tích cực và có lợi hơn nhiều).",
      "examples": [
        {
          "chinese": "与其坐在家里无谓地抱怨生活，不如站起来用行动改变现状。",
          "pinyin": "Yǔqí zuò zài jiālǐ wúwèi de bàoyuàn shēnghuó, bùrú zhàn qǐlái yòng xíngdòng gǎibiàn xiànzhuàng.",
          "translation_vi": "Thay vì ngồi ở nhà than vãn về cuộc sống một cách vô ích, thà rằng đứng dậy dùng hành động để thay đổi hiện trạng.",
          "explanation": "\"与其...不如...\" khuyên đối phương chuyển hóa năng lượng tiêu cực thành hành động thiết thực."
        },
        {
          "chinese": "与其花大价钱买昂贵的补品，真不如平时养成规律作息的健康习惯。",
          "pinyin": "Yǔqí huā dà jiàqian mǎi ángguì de bǔpǐn, zhēn bùrú píngshí yǎngchéng guīlǜ zuòxī de jiànkāng xíguàn.",
          "translation_vi": "Thay vì bỏ số tiền lớn mua đồ bổ đắt đỏ, thật chẳng thà rèn luyện thói quen sinh hoạt điều độ hằng ngày.",
          "explanation": "\"与其...真不如...\" so sánh sự vượt trội về giá trị của lối sống lành mạnh so với việc lạm dụng thực phẩm chức năng."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 77,
      "name": "Cấu trúc điều kiện bắt buộc duy nhất \"除非...否则...\" (Trừ phi... nếu không...)",
      "pattern": "除非 + Điều kiện tiên quyết duy nhất, 否则 / 不然 + Hậu quả tiêu cực tất yếu",
      "category": "Liên từ",
      "explanation_vi": "\"除非...否则...\" (chúfēi... fǒuzé...) chỉ ra điều kiện duy nhất bắt buộc phải thực hiện để ngăn chặn một hậu quả xấu (trừ phi... nếu không thì). Vế \"除非\" đưa ra lối thoát duy nhất, vế \"否则\" nêu rõ kết cục không mong muốn nếu điều kiện đó không được đáp ứng.",
      "examples": [
        {
          "chinese": "除非双方都作出实质性的让步，否则这次和谈很难取得成功。",
          "pinyin": "Chúfēi shuāngfāng dōu zuòchū shízhìxìng de ràngbù, fǒuzé zhè cì hétán hěn nán qǔdé chénggōng.",
          "translation_vi": "Trừ phi cả hai bên đều đưa ra sự nhượng bộ thực chất, nếu không thì cuộc hòa đàm này rất khó giành được thành công.",
          "explanation": "\"除非...否则...\" khẳng định sự nhượng bộ lẫn nhau là chìa khóa duy nhất cứu vãn cuộc đàm phán."
        },
        {
          "chinese": "除非你有医院开具的假条，否则这次缺席将被记作旷课。",
          "pinyin": "Chúfēi nǐ yǒu yīyuàn kāijù de jiàtiáo, fǒuzé zhè cì quēxí jiāng bèi jìzuò kuàngkè.",
          "translation_vi": "Trừ phi em có giấy xin phép nghỉ của bệnh viện cấp, nếu không buổi vắng mặt này sẽ bị tính là trốn học.",
          "explanation": "\"除非...否则...\" nêu rõ quy chế quản lý điểm danh học đường nghiêm khắc."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 78,
      "name": "Cấu trúc lựa chọn loại trừ nhị phân \"要么...要么...\" (Hoặc là... hoặc là...)",
      "pattern": "要么 + Phương án A, 要么 + Phương án B (buộc chọn 1 trong 2)",
      "category": "Liên từ",
      "explanation_vi": "\"要么...要么...\" (yàome... yàome...) đưa ra hai phương án loại trừ lẫn nhau, bắt buộc chủ thể chỉ được chọn một trong hai chứ không thể cùng lúc thực hiện cả hai hoặc không chọn phương án nào (hoặc là... hoặc là).",
      "examples": [
        {
          "chinese": "面对严峻的考验，我们要么勇敢向前冲，要么被竞争彻底淘汰。",
          "pinyin": "Miànduì yánjùn de kǎoyàn, wǒmen yàome yǒnggǎn xiàng qián chōng, yàome bèi jìngzhēng chèdǐ táotài.",
          "translation_vi": "Đối mặt với thử thách gay gắt, chúng ta hoặc là dũng cảm xông về phía trước, hoặc là bị quy luật cạnh tranh đào thải hoàn toàn.",
          "explanation": "\"要么...要么...\" đặt ra thế trận bắt buộc phải chiến đấu sinh tồn trong môi trường cạnh tranh."
        },
        {
          "chinese": "放假期间，他要么在图书馆静心读书，要么去健身房锻炼身体。",
          "pinyin": "Fàngjià qījiān, tā yàome zài túshūguǎn jìngxīn dúshū, yàome qù jiànshēnfáng duànliàn shēntǐ.",
          "translation_vi": "Trong suốt kỳ nghỉ, cậu ấy hoặc là ở trong thư viện tĩnh tâm đọc sách, hoặc là đến phòng gym rèn luyện thân thể.",
          "explanation": "\"要么...要么...\" liệt kê hai hoạt động giải trí lành mạnh duy nhất được luân phiên chọn lựa."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 79,
      "name": "Cấu trúc liệt kê song song hai phương diện \"一方面...另一方面...\" (Một mặt... mặt khác...)",
      "pattern": "Chủ ngữ + 一方面..., 另一方面... / 一方面 + Mệnh đề 1, 另一方面 + Mệnh đề 2",
      "category": "Liên từ",
      "explanation_vi": "\"一方面...另一方面...\" (yī fāngmiàn... lìng yī fāngmiàn...) dùng để phân tích hai khía cạnh, hai nguyên nhân hoặc hai mục đích song hành của một vấn đề. Hai phương diện này có thể bổ sung cho nhau hoặc tương phản nhau nhằm tạo ra cái nhìn toàn diện.",
      "examples": [
        {
          "chinese": "利用假期去企业实习，一方面可以积累工作经验，另一方面也能赚取零花钱。",
          "pinyin": "Lìyòng jiàqī qù qǐyè shíxí, yì fāngmiàn kěyǐ jīlěi gōngzuò jīngyàn, lìng yì fāngmiàn yě néng zhuànqǔ línghuāqián.",
          "translation_vi": "Tận dụng kỳ nghỉ đi thực tập tại doanh nghiệp, một mặt có thể tích lũy kinh nghiệm làm việc, mặt khác cũng kiếm thêm được tiền tiêu vặt.",
          "explanation": "\"一方面...另一方面...\" phân tích hai lợi ích song hành thiết thực của việc đi thực tập hè."
        },
        {
          "chinese": "这项新政策一方面鼓励科技创新，另一方面加大了对知识产权的保护力度。",
          "pinyin": "Zhè xiàng xīn zhèngcè yì fāngmiàn gǔlì kējì chuàngxīn, lìng yì fāngmiàn jiādà le duì zhīshi chǎnquán de bǎohù lìdù.",
          "translation_vi": "Chính sách mới này một mặt khuyến khích đổi mới công nghệ, mặt khác tăng cường cường độ bảo hộ quyền sở hữu trí tuệ.",
          "explanation": "Cấu trúc nêu rõ hai mũi nhọn chiến lược bổ trợ lẫn nhau của chính sách nhà nước."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 80,
      "name": "Cấu trúc nhấn mạnh cực hạn \"连...也/都...\" (Ngay cả... cũng...)",
      "pattern": "连 + Thành phần cực đoan (Chủ ngữ/Tân ngữ) + 也 / 都 + Vị ngữ",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"连...也/都...\" (lián... yě/dōu...) đưa ra một đối tượng hoặc tình huống cực đoan, dễ thấy hoặc tối thiểu nhất để làm đòn bẩy nhấn mạnh ý nghĩa: đối tượng tối thiểu này còn như vậy thì những đối tượng khác hiển nhiên càng như thế.",
      "examples": [
        {
          "chinese": "这道菜的味道实在太辣了，连平时最喜欢吃辣椒的四川朋友都受不了。",
          "pinyin": "Zhè dào cài de wèidào shízài tài là le, lián píngshí zuì xǐhuan chī làjiāo de Sìchuān péngyou dōu shòubùliǎo.",
          "translation_vi": "Món ăn này vị cay quá chừng, ngay cả người bạn Tứ Xuyên bình thường thích ăn ớt nhất cũng không chịu nổi.",
          "explanation": "\"连...四川朋友都...\" dùng thói quen ăn cay nổi tiếng của người Tứ Xuyên làm thước đo nhấn mạnh độ cay tột bực."
        },
        {
          "chinese": "他今天工作忙得不可开交，连中午饭都顾不上吃。",
          "pinyin": "Tā jīntiān gōngzuò máng de bùkěkāijiāo, lián zhōngwǔfàn dōu gùbushàng chī.",
          "translation_vi": "Hôm nay anh ấy bận đến mức tối mắt tối mũi, ngay cả cơm trưa cũng chẳng đoái hoài ăn được.",
          "explanation": "\"连中午饭都...\" đưa bữa trưa (nhu cầu sinh học cơ bản) ra làm ví dụ cực tả mức độ bận rộn."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 81,
      "name": "Phân biệt câu điều kiện đủ \"只要...就...\" và điều kiện cần \"只有...才...\"",
      "pattern": "只要 + Điều kiện đủ + 就 + Kết quả / 只有 + Điều kiện duy nhất + 才 + Kết quả",
      "category": "Liên từ",
      "explanation_vi": "\"只要...就...\" (zhǐyào... jiù...) biểu thị điều kiện thỏa mãn là đủ để tạo ra kết quả (chỉ cần có điều kiện này là có kết quả ngay); trong khi \"只有...才...\" (zhǐyǒu... cái...) biểu thị điều kiện bắt buộc, tiên quyết và duy nhất (chỉ khi nào có điều kiện này thì mới đạt được kết quả, không có nó thì không thể).",
      "examples": [
        {
          "chinese": "只要我们齐心协力互相配合，就一定能够战胜眼前的困难。",
          "pinyin": "Zhǐyào wǒmen qíxīnxiélì hùxiāng pèihé, jiù yídìng nénggòu zhànshèng yǎnqián de kùnnan.",
          "translation_vi": "Chỉ cần chúng ta đồng tâm hiệp lực phối hợp với nhau thì nhất định sẽ có thể chiến thắng khó khăn trước mắt.",
          "explanation": "\"只要...就...\" khẳng định sự đoàn kết là điều kiện đầy đủ để đạt được thắng lợi vẻ vang."
        },
        {
          "chinese": "只有不断学习新知识，才能在日新月异的信息时代保持竞争力。",
          "pinyin": "Zhǐyǒu búduàn xuéxí xīn zhīshi, cái néng zài rìxīnyuèyì de xìnxī shídài bǎochí jìngzhēnglì.",
          "translation_vi": "Chỉ khi không ngừng học hỏi kiến thức mới thì mới có thể duy trì sức cạnh tranh trong thời đại thông tin đổi mới từng ngày.",
          "explanation": "\"只有...才能...\" xác định việc học tập liên tục là con đường duy nhất để giữ vững ưu thế."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 82,
      "name": "Cấu trúc điều kiện phiếm chỉ toàn diện \"无论/不管...都/也...\" (Bất luận / Bất kể... đều...)",
      "pattern": "无论 / 不管 + Từ để hỏi / A 还是 B / Chính phản + 都 / 也 + Vị ngữ",
      "category": "Liên từ",
      "explanation_vi": "\"无论/不管...都/也...\" (wúlùn/bùguǎn... dōu/yě...) biểu thị trong bất kỳ tình huống, điều kiện hoặc sự lựa chọn nào thì kết quả hay hành vi ở vế sau vẫn bất biến, không hề chịu ảnh hưởng (dù thế nào chăng nữa thì vẫn cứ). Vế trước bắt buộc phải chứa hình thức lựa chọn, từ để hỏi nghi vấn hoặc cặp đối lập.",
      "examples": [
        {
          "chinese": "不管外界环境发生什么变化，我们都必须坚持诚信经营的理念。",
          "pinyin": "Bùguǎn wàijiè huánjìng fāshēng shénme biànhuà, wǒmen dōu bìxū jiānchí chéngxìn jīngyíng de lǐniàn.",
          "translation_vi": "Bất kể môi trường bên ngoài phát sinh biến đổi gì, chúng ta đều phải kiên trì quan niệm kinh doanh chữ tín hàng đầu.",
          "explanation": "\"不管...什么变化...都...\" nhấn mạnh nguyên tắc đạo đức kinh doanh không đổi trước mọi biến động thương trường."
        },
        {
          "chinese": "无论是刮风还是下雨，交警同志都会坚守在交通指挥岗位上。",
          "pinyin": "Wúlùn shì guāfēng háishì xiàyǔ, jiāojǐng tóngzhì dōu huì jiānshǒu zài jiāotōng zhǐhuī gǎngwèi shang.",
          "translation_vi": "Bất luận là giông gió hay mưa tuôn, các chiến sĩ cảnh sát giao thông đều bám trụ trên vị trí điều tiết giao thông.",
          "explanation": "\"无论是...还是...都...\" bao quát cả hai điều kiện thời tiết xấu để ca ngợi tinh thần trách nhiệm của cảnh sát."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 83,
      "name": "Bổ ngữ xu hướng kép phái sinh \"起来\" (Bắt đầu và tiếp diễn / Đánh giá nhận định)",
      "pattern": "Động từ + 起来 (Bắt đầu và tiếp diễn) / Động từ (看/听/想/尝) + 起来 (Đánh giá)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"起来\" (qilai) mang hai nghĩa phái sinh đặc thù quan trọng ở HSK 4: 1) Biểu thị hành động hoặc trạng thái bắt đầu phát sinh và tiếp tục phát triển (như 唱起来, 哭起来, 热闹起来); 2) Đứng sau các động từ tri giác (看, 听, 尝, 闻, 想) để đưa ra nhận xét, đánh giá từ góc độ của giác quan đó (như 看起来 - trông có vẻ, 听起来 - nghe chừng).",
      "examples": [
        {
          "chinese": "听到这个令人振奋的好消息，整个办公室顿时欢呼起来。",
          "pinyin": "Tīngdào zhè ge lìng rén zhènfèn de hǎo xiāoxi, zhěng gè bàngōngshì dùnshí huānhū qǐlai.",
          "translation_vi": "Nghe được tin mừng đầy phấn khởi này, toàn bộ văn phòng lập tức reo hò rộn ràng lên.",
          "explanation": "\"欢呼起来\" biểu thị động tác reo hò bắt đầu bùng nổ và tiếp diễn náo nhiệt."
        },
        {
          "chinese": "这首古典音乐旋律优美，听起来让人感觉非常放松舒适。",
          "pinyin": "Zhè shǒu gǔdiǎn yīnyuè xuánlǜ yōuměi, tīng qǐlai ràng rén gǎnjué fēicháng fàngsōng shūshì.",
          "translation_vi": "Khúc nhạc cổ điển này giai điệu êm ái, nghe chừng khiến cho con người cảm thấy rất thư thái dễ chịu.",
          "explanation": "\"听起来\" dùng giác quan thính giác làm cơ sở đánh giá chất lượng và cảm xúc âm nhạc mang lại."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 84,
      "name": "Bổ ngữ xu hướng kép phái sinh \"下去\" (Tiếp tục duy trì sang tương lai)",
      "pattern": "Động từ + 下去 (坚持 / 学 / 活 / 走 / 讲 / 读 + 下去)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"下去\" (xiàqu) khi làm bổ ngữ phái sinh biểu thị một hành động hoặc trạng thái vốn đang được tiến hành sẽ tiếp tục duy trì, kéo dài từ thời điểm hiện tại hướng về tương lai (làm tiếp đi, duy trì tiếp). Thường dùng ở dạng khẳng định động viên hoặc phủ định \"V + 不下去\" (không thể tiếp tục nổi).",
      "examples": [
        {
          "chinese": "既然你选择了学习中文，就要克服一切困难坚持学下去。",
          "pinyin": "Jìrán nǐ xuǎnzé le xuéxí zhōngwén, jiù yào kèfú yíqiè kùnnan jiānchí xué xiàqu.",
          "translation_vi": "Đã cậu chọn học tiếng Trung thì phải khắc phục mọi khó khăn để kiên trì học tiếp.",
          "explanation": "\"坚持学下去\" cổ vũ đối phương giữ vững ý chí kiên định duy trì việc học tập trong tương lai dài lâu."
        },
        {
          "chinese": "会议时间太长，如果再这样争论下去，恐怕今天很难得出结论。",
          "pinyin": "Huìyì shíjiān tài cháng, rúguǒ zài zhèyàng zhēnglùn xiàqu, kǒngpà jīntiān hěn nán déchū jiélùn.",
          "translation_vi": "Thời gian cuộc họp quá dài rồi, nếu còn tiếp tục tranh cãi mãi như thế này, e rằng hôm nay khó đưa ra được kết luận.",
          "explanation": "\"再这样争论下去\" cảnh báo việc kéo dài tranh cãi vô ích sẽ làm đình trệ công việc."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 85,
      "name": "Bổ ngữ xu hướng kép phái sinh \"下来\" (Cố định, lưu giữ / Kéo dài từ quá khứ)",
      "pattern": "Động từ + 下来 (记 / 写 / 停 / 留 / 传承 + 下来)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"下来\" (xialai) mang hai nghĩa phái sinh chính: 1) Biểu thị hành động làm cho sự vật chuyển từ động sang tĩnh, cố định lại hoặc lưu giữ lại một thông tin, hình ảnh (như 记下来 - ghi chép lại, 拍下来 - chụp lại, 留下来 - ở lại); 2) Biểu thị hành động hoặc truyền thống được tiếp nối từ quá khứ đến hiện tại (như 传下来 - lưu truyền lại).",
      "examples": [
        {
          "chinese": "老师讲的重要考点，请大家一定要在笔记本上完整地记下来。",
          "pinyin": "Lǎoshī jiǎng de zhòngyào kǎodiǎn, qǐng dàjiā yídìng yào zài bǐjìběn shang wánzhěng de jì xialai.",
          "translation_vi": "Những trọng điểm thi quan trọng thầy giáo giảng, xin mọi người nhất định phải ghi chép lại đầy đủ vào vở.",
          "explanation": "\"完整地记下来\" dùng \"下来\" thể hiện hành động ghi chép lưu giữ kiến thức trên giấy tờ."
        },
        {
          "chinese": "这项古老的民间手工艺是由老一辈手艺人一代代流传下来的。",
          "pinyin": "Zhè xiàng gǔlǎo de mínjiān shǒugōngyì shì yóu lǎoyíbèi shǒuyìrén yídàidài liúchuán xialai de.",
          "translation_vi": "Kỹ nghệ thủ công dân gian cổ xưa này là do những người thợ thế hệ đi trước truyền lại từ đời này sang đời khác.",
          "explanation": "\"流传下来\" thể hiện dòng chảy văn hóa tiếp nối từ lịch sử xa xưa tới hiện đại."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 86,
      "name": "Bổ ngữ xu hướng kép phái sinh \"出来\" (Từ ẩn sang hiện / Nhận diện / Sáng tạo)",
      "pattern": "Động từ + 出来 (看 / 认 / 想 / 听 / 制作 + 出来)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"出来\" (chulai) làm bổ ngữ phái sinh có ba trường hợp tiêu biểu: 1) Sự vật từ trạng thái ẩn giấu, vô hình chuyển thành hiển lộ, nhìn thấy rõ ràng (như 太阳钻出来了); 2) Năng lực phân biệt, nhận diện rõ người hoặc vật qua tri giác (như 认出来 - nhận ra, 看出来 - nhìn ra được sự việc); 3) Hoàn thành một sản phẩm sáng tạo từ chỗ chưa có (như 想出办法来, 制作出来).",
      "examples": [
        {
          "chinese": "虽然他戴着帽子和口罩，但我还是一眼就认出了他。",
          "pinyin": "Suīrán tā dàizhe màozi hé kǒuzhào, dàn wǒ háishì yìyǎn jiù rènchū le tā.",
          "translation_vi": "Tuy rằng anh ấy đội mũ và đeo khẩu trang, nhưng tôi vẫn nhận ngay ra anh ấy chỉ bằng một ánh nhìn.",
          "explanation": "\"认出来\" biểu thị năng lực nhận biết chính xác người quen bất chấp việc cải trang."
        },
        {
          "chinese": "经过三天三夜的反复讨论，工程师们终于想出了解决故障的好方案。",
          "pinyin": "Jīngguò sān tiān sān yè de fǎnfù tǎolùn, gōngchéngshīmen zhōngyú xiǎngchū le jiějué gùzhàng de hǎo fāng'àn.",
          "translation_vi": "Sau ba ngày ba đêm thảo luận liên tục, các kỹ sư cuối cùng đã nghĩ ra được phương án tuyệt vời giải quyết sự cố.",
          "explanation": "\"想出来\" diễn tả thành quả tư duy sáng tạo từ chỗ bế tắc đến khi nảy ra giải pháp mới."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 87,
      "name": "Bổ ngữ xu hướng kép phái sinh \"过来\" (Hồi phục trạng thái bình thường)",
      "pattern": "Động từ + 过来 (醒 / 明白 / 反应 / 改 / 缓 + 过来)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"过来\" (guolai) khi mang nghĩa phái sinh biểu thị sự hồi phục hoặc chuyển biến từ một trạng thái tiêu cực, sai lệch hoặc bất thường trở về trạng thái tỉnh táo, chuẩn mực và tích cực ban đầu (như 醒过来 - tỉnh lại, 明白过来 - hiểu ra, 改过来 - sửa đúng lại, 缓过劲来 - hồi sức lại).",
      "examples": [
        {
          "chinese": "医生全力抢救了几个小时，昏迷的伤员终于慢慢醒过来了。",
          "pinyin": "Yīshēng quánlì qiǎngjiù le jǐ gè xiǎoshí, hūnmí de shāngyuán zhōngyú mànmàn xǐng guolai le.",
          "translation_vi": "Bác sĩ dốc sức cấp cứu mấy tiếng đồng hồ, người bị thương hôn mê cuối cùng đã từ từ tỉnh lại.",
          "explanation": "\"醒过来\" chỉ sự hồi phục ý thức từ trạng thái hôn mê sâu nguy kịch trở về trạng thái tỉnh táo."
        },
        {
          "chinese": "听了老师耐心的启发，他才猛然明白过来自己错在哪里。",
          "pinyin": "Tīng le lǎoshī nàixīn de qǐfā, tā cái měngrán míngbai guolai zìjǐ cuò zài nǎlǐ.",
          "translation_vi": "Nghe lời khuyên bảo kiên trì của thầy giáo, cậu ấy mới bừng tỉnh hiểu ra mình sai ở chỗ nào.",
          "explanation": "\"明白过来\" diễn tả sự chuyển biến nhận thức từ u mê, mơ hồ sang thấu tỏ bản chất."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 88,
      "name": "Bổ ngữ xu hướng kép phái sinh \"过去\" (Rơi vào trạng thái bất tỉnh hoặc bất lợi)",
      "pattern": "Động từ + 过去 (晕 / 昏 / 昏厥 + 过去)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"过去\" (guoqu) là phản nghĩa của \"过来\", khi làm bổ ngữ phái sinh diễn tả trạng thái con người bị mất ý thức, ngất lịm, rời xa trạng thái bình thường (rơi vào hôn mê, ngất đi) hoặc chỉ sự vật bị suy vong, chết đi.",
      "examples": [
        {
          "chinese": "听到这个突如其来的噩耗，老奶奶经受不住打击，直接晕了过去。",
          "pinyin": "Tīngdào zhè ge tūrúqílái de èhào, lǎonǎinai jīngshòu bú zhù dǎjī, zhíjiē yūn le guoqu.",
          "translation_vi": "Nghe tin dữ đột ngột ập đến này, người bà không chịu nổi cú sốc, đã ngất lịm đi ngay tại chỗ.",
          "explanation": "\"晕了过去\" miêu tả tình trạng ngất xỉu, mất hoàn toàn tri giác trước cú sốc tinh thần quá lớn."
        },
        {
          "chinese": "运动员由于严重脱水和体力透支，冲过终点线后瞬间昏了过去。",
          "pinyin": "Yùndòngyuán yóuyú yánzhòng tuōshuǐ hé tǐlì tòuzhī, chōngguò zhōngdiǎnxiàn hòu shùnjiān hūn le guoqu.",
          "translation_vi": "Vận động viên do mất nước nghiêm trọng và kiệt sức, sau khi lao qua vạch đích đã lập tức ngất đi.",
          "explanation": "\"昏了过去\" ghi nhận trạng thái hôn mê do suy kiệt thể lực tột cùng trên đường đua."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 89,
      "name": "Bổ ngữ kết quả phái sinh \"上\" (Gắn kết, tiếp xúc, đạt mục tiêu)",
      "pattern": "Động từ + 上 (关 / 穿 / 锁 / 考 / 爱 / 谈 / 遇 + 上)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"上\" (shang) làm bổ ngữ kết quả mang các nghĩa phái sinh đặc thù: 1) Hai vật thể tiếp xúc dính liền, khép kín lại với nhau (như 关上门, 穿上衣服, 锁上柜子); 2) Đạt được một mục đích hoặc kết quả mong muốn (như 考上大学 - thi đỗ đại học); 3) Bắt đầu nảy sinh một mối quan hệ tình cảm hoặc sự kiện (như 爱上 - yêu, 遇上 - gặp gỡ).",
      "examples": [
        {
          "chinese": "功夫不负有心人，经过刻苦努力他终于考上了心仪的名牌大学。",
          "pinyin": "Gōngfu bú fù yǒuxīnrén, jīngguò kèkǔ nǔlì tā zhōngyú kǎoshàng le xīnyí de míngpái dàxué.",
          "translation_vi": "Công phu không phụ lòng người, sau bao nỗ lực gian khổ cuối cùng anh ấy đã thi đỗ vào trường đại học danh tiếng ước mơ.",
          "explanation": "\"考上大学\" dùng \"上\" làm bổ ngữ kết quả biểu thị việc đạt được mục tiêu thi cử thành công rực rỡ."
        },
        {
          "chinese": "出门前请检查水龙头和电源，并记得随手把大门锁上。",
          "pinyin": "Chūmén qián qǐng jiǎnchá shuǐlóngtóu hé diànyuán, bìng jìde suíshǒu bǎ dàmén suǒshang.",
          "translation_vi": "Trước khi ra khỏi nhà xin hãy kiểm tra vòi nước và nguồn điện, đồng thời nhớ tiện tay khóa chặt cửa chính lại.",
          "explanation": "\"锁上\" biểu thị hành động tra chìa khóa làm cho hai cánh cửa gắn chặt đóng kín an toàn."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 90,
      "name": "Bổ ngữ kết quả phái sinh \"开\" (Tách rời, mở rộng, dàn trải)",
      "pattern": "Động từ + 开 (打 / 分 / 走 / 离 / 散 / 展 + 开)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"开\" (kāi) làm bổ ngữ kết quả mang nghĩa phân tách, làm cho các bộ phận đang gắn kết tách rời xa nhau ra (như 分开, 离开), hoặc làm cho không gian được mở rộng, bung tỏa ra các hướng (như 打开窗户, 散开, 展开调查).",
      "examples": [
        {
          "chinese": "请大家在考场内保持安静，并把书本和文具整齐地分开摆放。",
          "pinyin": "Qǐng dàjiā zài kǎochǎng nèi bǎochí ānjìng, bìng bǎ shūběn hé wénjù zhěngqí de fēnkāi bǎifàng.",
          "translation_vi": "Xin mọi người hãy giữ trật tự trong phòng thi, và để tách riêng sách vở với đồ dùng học tập một cách ngay ngắn.",
          "explanation": "\"分开摆放\" dùng \"开\" thể hiện trạng thái phân cách không để đồ dùng chồng chéo lên nhau."
        },
        {
          "chinese": "下课铃响了，操场上的学生们欢笑着迅速向四周散开。",
          "pinyin": "Xiàkè líng xiǎng le, cāochǎng shang de xuéshengmen huānxiàozhe xùnsù xiàng sìzhōu sànkāi.",
          "translation_vi": "Chuông tan học reo rồi, học sinh trên sân trường vừa cười nói vừa nhanh chóng tản ra bốn phía.",
          "explanation": "\"散开\" miêu tả đám đông di chuyển tản mát về các phương hướng khác nhau."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 91,
      "name": "Bổ ngữ trạng thái phức tạp dẫn mệnh đề \"得\" (Mức độ cực tả)",
      "pattern": "Chủ ngữ + Động từ/Tính từ + 得 + Cụm chủ vị / Mệnh đề miêu tả",
      "category": "Bổ ngữ",
      "explanation_vi": "Ở trình độ HSK 4, thành phần đứng sau trợ từ \"得\" (de) không chỉ là tính từ đơn lẻ mà phát triển thành một cụm chủ vị hoặc mệnh đề hoàn chỉnh để miêu tả sinh động, cụ thể hóa trạng thái hoặc hệ quả của hành vi đạt tới mức độ kinh ngạc (đến mức mà, đến nỗi mà).",
      "examples": [
        {
          "chinese": "小丑滑稽幽默的表演逗得全场观众哈哈大笑。",
          "pinyin": "Xiǎochǒu huájī yōumò de biǎoyǎn dòu de quánchǎng guānzhòng hāhā dàxiào.",
          "translation_vi": "Màn biểu diễn hài hước dí dỏm của chú hề chọc cho toàn thể khán giả cười nghiêng ngả.",
          "explanation": "\"逗得全场观众哈哈大笑\" dùng cả cụm chủ vị \"全场观众哈哈大笑\" làm bổ ngữ trạng thái miêu tả sức hút của tiết mục xiếc."
        },
        {
          "chinese": "听完老爷爷感人的战斗经历，大家感动得眼泪夺眶而出。",
          "pinyin": "Tīngwán lǎoyéye gǎnrén de zhàndòu jīnglì, dàjiā gǎndòng de yǎnlèi duókuàng ér chū.",
          "translation_vi": "Nghe xong trải nghiệm chiến đấu xúc động của cụ già, mọi người cảm động đến mức nước mắt trào ra khóe mi.",
          "explanation": "\"感动得眼泪夺眶而出\" cực tả mức độ xúc động sâu sắc đến rơi lệ của người nghe."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 92,
      "name": "Câu chữ 把 nâng cao kết hợp vị trí chuyển dịch: \"把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成\"",
      "pattern": "Chủ ngữ + 把 + Tân ngữ + Động từ + 在 / 到 / 给 / 成 + Nơi chốn / Người nhận / Kết quả",
      "category": "Câu chữ 把",
      "explanation_vi": "Đây là dạng nâng cao cực kỳ quan trọng của câu chữ 把 trong HSK 4, biểu thị hành vi xử lý làm cho tân ngữ chuyển dịch vị trí (放到... / 留在...), chuyển giao quyền sở hữu (借给... / 送给...), hoặc biến đổi bản chất thành dạng thức mới (翻译成... / 改变成...).",
      "examples": [
        {
          "chinese": "请大家把填好的调查问卷交到前面的工作人员手里。",
          "pinyin": "Qǐng dàjiā bǎ tiánhǎo de diàochá wènjuàn jiāodào qiánmiàn de gōngzuò rényuán shǒulǐ.",
          "translation_vi": "Xin mọi người hãy nộp phiếu khảo sát đã điền xong vào tay các nhân viên công tác phía trước.",
          "explanation": "Cấu trúc \"把问卷交到...手里\" thể hiện sự chuyển dời địa điểm vật lý của tờ phiếu khảo sát."
        },
        {
          "chinese": "翻译官十分熟练地把这篇中文发言稿翻译成了流利的英文。",
          "pinyin": "Fānyìguān shífēn shúliàn de bǎ zhè piān zhōngwén fāyángǎo fānyì chéng le liúlì de yīngwén.",
          "translation_vi": "Viên phiên dịch viên hết sức thành thạo dịch bài phát biểu tiếng Trung này thành tiếng Anh lưu loát.",
          "explanation": "Cấu trúc \"把发言稿翻译成英文\" thể hiện sự chuyển hóa hình thức ngôn ngữ của văn bản."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 93,
      "name": "Vị trí từ phủ định và động từ năng nguyện trong câu chữ 把",
      "pattern": "Chủ ngữ + 不/没/别/应该/想/愿意 + 把 + Tân ngữ + Động từ + Thành phần khác",
      "category": "Câu chữ 把",
      "explanation_vi": "Quy tắc vàng ngữ pháp tiếng Trung: Từ phủ định (不, 没, 别) và động từ năng nguyện (想, 愿意, 应该, 能够) bắt buộc phải đứng TRƯỚC giới từ \"把\", tuyệt đối không được chen vào giữa \"把\" và tân ngữ hoặc sau động từ chính.",
      "examples": [
        {
          "chinese": "你千万不要把这么机密的文件随手放在公共桌子上。",
          "pinyin": "Nǐ qiānwàn bú yào bǎ zhème jīmì de wénjiàn suíshǒu fàng zài gōnggòng zhuōzi shang.",
          "translation_vi": "Cậu tuyệt đối đừng tiện tay đặt tài liệu cơ mật như thế này trên bàn làm việc chung.",
          "explanation": "Phó từ khuyên răn phủ định \"千万不要\" đứng trước \"把\" tuân thủ chuẩn xác quy tắc ngữ pháp."
        },
        {
          "chinese": "他平时非常细心，从来没有把客户的联系电话记错。",
          "pinyin": "Tā píngshí fēicháng xìxīn, cónglái méiyǒu bǎ kèhù de liánxì diànhuà jìcuò.",
          "translation_vi": "Anh ấy bình thường rất cẩn thận, chưa bao giờ ghi nhầm số điện thoại liên lạc của khách hàng.",
          "explanation": "\"从来没有\" là trạng ngữ phủ định đứng trước \"把\", bảo đảm vị trí chuẩn xác trong câu."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 94,
      "name": "Câu chữ 把 kết hợp bổ ngữ kết quả và bổ ngữ xu hướng phức hợp",
      "pattern": "Chủ ngữ + 把 + Tân ngữ + Động từ + Bổ ngữ kết quả / Bổ ngữ xu hướng kép",
      "category": "Câu chữ 把",
      "explanation_vi": "Trong câu chữ 把, động từ không bao giờ đứng trơ trọi một mình mà bắt buộc phải có thành phần bổ trợ phía sau, phổ biến nhất ở HSK 4 là bổ ngữ kết quả (như 弄坏, 擦干净, 准备好) hoặc bổ ngữ xu hướng kép (như 拿出来, 搬进去, 送回去).",
      "examples": [
        {
          "chinese": "清洁工人用高压水枪把整条街道冲洗得干干净净。",
          "pinyin": "Qīngjié gōngrén yòng gāoyā shuǐqiāng bǎ zhěng tiáo jiēdào chōngxǐ de gāngānjìngjìng.",
          "translation_vi": "Công nhân vệ sinh dùng vòi xịt nước áp lực cao xối rửa cả con đường sạch bóng không một vết bẩn.",
          "explanation": "\"把街道冲洗得干干净净\" kết hợp câu chữ 把 với bổ ngữ trạng thái miêu tả kết quả sạch sẽ tinh tươm."
        },
        {
          "chinese": "请同学们把书包里的课本和练习册迅速拿出来。",
          "pinyin": "Qǐng tóngxuémen bǎ shūbāo lǐ de kèběn hé liànxícè xùnsù ná chūlái.",
          "translation_vi": "Xin các em học sinh hãy nhanh chóng lấy sách giáo khoa và vở bài tập trong cặp ra.",
          "explanation": "\"把课本...拿出来\" kết hợp câu chữ 把 với bổ ngữ xu hướng kép \"出来\" biểu thị hướng chuyển động của sách vở."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 95,
      "name": "Câu bị động nâng cao có tác nhân và ẩn tác nhân với \"被\"",
      "pattern": "Chủ ngữ + 被 + (Tác nhân thực hiện) + Động từ + Thành phần khác",
      "category": "Câu bị động",
      "explanation_vi": "Trong câu bị động chữ \"被\" ở trình độ HSK 4: 1) Có thể nêu rõ tác nhân gây ra hành động (như 行李被雨淋湿了); 2) Tác nhân có thể được tỉnh lược (ẩn tác nhân) khi không rõ ai làm hoặc muốn nhấn mạnh bản thân đối tượng bị tác động (như 自行车被偷了 - Xe đạp bị trộm mất). Động từ sau \"被\" cũng bắt buộc phải có thành phần khác kèm theo.",
      "examples": [
        {
          "chinese": "那篇优秀的调查报道被几家主流新闻媒体在头版转载。",
          "pinyin": "Nà piān yōuxiù de diàochá bàodào bèi jǐ jiā zhǔliú xīnwén méitǐ zài tóubǎn zhuǎnzǎi.",
          "translation_vi": "Bài phóng sự điều tra xuất sắc đó đã được mấy cơ quan truyền thông báo chí chính thống đăng lại trên trang nhất.",
          "explanation": "Câu bị động nêu rõ tác nhân \"几家主流新闻媒体\" làm rõ cơ quan báo chí đứng ra tái bản bài báo."
        },
        {
          "chinese": "放在阳台上的几盆鲜花被昨晚的大暴雨砸坏了。",
          "pinyin": "Fàng zài yángtái shang de jǐ pén xiānhuā bèi zuówǎn de dà bàoyǔ záhuài le.",
          "translation_vi": "Mấy chậu hoa tươi đặt ở ban công đã bị cơn mưa rào lớn đêm qua dập nát hỏng hết.",
          "explanation": "\"被大暴雨砸坏了\" kết hợp câu bị động với bổ ngữ kết quả \"坏\", tác nhân gây hại là thời tiết mưa to."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 96,
      "name": "Câu biểu thị bị động cảm thụ và đón nhận với \"受\" (Được / Bị)",
      "pattern": "Chủ ngữ + 受到 / 受 + Danh từ/Động từ (欢迎 / 尊重 / 感动 / 骗 / 惩罚)",
      "category": "Câu bị động",
      "explanation_vi": "Ngoài chữ \"被\", tiếng Trung HSK 4 thường dùng \"受\" (shòu) hoặc \"受到\" để tạo thành câu bị động mang tính cảm thụ. Khi kết hợp với từ ngữ tích cực (欢迎, 尊重, 表扬), nó mang nghĩa là \"được\"; khi kết hợp với từ ngữ tiêu cực (骗, 处分, 惩罚), nó mang nghĩa là \"bị\".",
      "examples": [
        {
          "chinese": "王老师讲课幽默生动，在学校里受到了全体学生的热烈欢迎。",
          "pinyin": "Wáng lǎoshī jiǎngkè yōumò shēngdòng, zài xuéxiào lǐ shòudào le quántǐ xuésheng de rèliè huānyíng.",
          "translation_vi": "Thầy Vương giảng bài hài hước sinh động, ở trường được toàn thể học sinh nhiệt liệt hoan nghênh.",
          "explanation": "\"受到了...热烈欢迎\" biểu thị câu bị động thụ hưởng sự mến mộ tích cực từ học trò."
        },
        {
          "chinese": "由于轻信了网络上的虚假投资广告，他上当受骗损失了一大笔钱。",
          "pinyin": "Yóuyú qīngxìn le wǎngluò shang de xūjiǎ tóuzī guǎnggào, tā shàngdàng shòupiàn sǔnshī le yí dà bǐ qián.",
          "translation_vi": "Do nhẹ dạ tin vào quảng cáo đầu tư giả mạo trên mạng, anh ta đã sập bẫy bị lừa mất một khoản tiền lớn.",
          "explanation": "\"上当受骗\" là cách dùng bị động mang ý nghĩa tiêu cực khi bị kẻ gian lừa gạt tài sản."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 97,
      "name": "Câu so sánh hơn nâng cao kèm lượng từ sai biệt cụ thể",
      "pattern": "A 比 B + Tính từ + 得多 / 多了 / 一些 / 一点儿 / Số từ + Lượng từ",
      "category": "Câu so sánh",
      "explanation_vi": "Trong câu so sánh chữ \"比\" ở trình độ HSK 4, để diễn đạt mức độ sai biệt giữa hai đối tượng, ta đặt thành phần đo lường ở SAU tính từ: 1) Sai biệt lớn: Tính từ + 得多 / 多了; 2) Sai biệt nhỏ: Tính từ + 一些 / 一点儿; 3) Sai biệt chuẩn xác: Tính từ + Số từ + Lượng từ (như 大五岁, 贵二十块).",
      "examples": [
        {
          "chinese": "坐高铁从北京到上海比坐普通火车快得多，节省了整整八个小时。",
          "pinyin": "Zuò gāotiě cóng Běijīng dào Shànghǎi bǐ zuò pǔtōng huǒchē kuài de duō, jiéshěng le zhěngzhěng bā gè xiǎoshí.",
          "translation_vi": "Đi tàu cao tốc từ Bắc Kinh đến Thượng Hải nhanh hơn nhiều so với tàu hỏa thường, tiết kiệm trọn vẹn 8 tiếng.",
          "explanation": "\"快得多\" đặt sau tính từ \"快\" biểu thị khoảng cách chênh lệch tốc độ vượt trội của đường sắt cao tốc."
        },
        {
          "chinese": "弟弟今年刚满十八岁，足足比他的表哥高了五厘米。",
          "pinyin": "Dìdi jīnnián gāng mǎn shíbā suì, zúzú bǐ tā de biǎogē gāo le wǔ límǐ.",
          "translation_vi": "Em trai năm nay vừa tròn 18 tuổi, đã cao hơn người anh họ của mình tròn 5 centimet.",
          "explanation": "\"高了五厘米\" dùng lượng từ số lượng cụ thể \"五厘米\" để đo lường độ chênh lệch chiều cao."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 98,
      "name": "Câu so sánh hơn tăng tiến có phó từ \"更\" / \"还\"",
      "pattern": "A 比 B + 更 / 还 + Tính từ (B vốn đã có tính chất đó, A lại vượt trội hơn)",
      "category": "Câu so sánh",
      "explanation_vi": "Khi muốn diễn đạt đối tượng B vốn dĩ đã mang một đặc tính ở mức độ cao, nhưng đối tượng A thậm chí còn vượt trội hơn B nữa, ta thêm phó từ \"更\" hoặc \"还\" vào trước tính từ vị ngữ trong câu so sánh chữ 比. Lưu ý tuyệt đối không dùng \"很\", \"真\", \"非常\" trong câu chữ 比.",
      "examples": [
        {
          "chinese": "这篇课文生词很多，但下一篇课文的语法比这篇还要复杂。",
          "pinyin": "Zhè piān kèwén shēngcí hěn duō, dàn xià yì piān kèwén de yǔfǎ bǐ zhè piān hái yào fùzá.",
          "translation_vi": "Bài khóa này từ mới rất nhiều, nhưng ngữ pháp của bài khóa tiếp theo còn phức tạp hơn cả bài này nữa.",
          "explanation": "\"还要复杂\" tiền giả định bài khóa 1 đã khó, bài khóa 2 mức độ phức tạp càng được đẩy lên tầng cao hơn."
        },
        {
          "chinese": "在激烈的市场竞争中，企业的创新能力比资金实力更为重要。",
          "pinyin": "Zài jīliè de shìchǎng jìngzhēng zhōng, qǐyè de chuàngxīn nénglì bǐ zījīn shílì gèng wéi zhòngyào.",
          "translation_vi": "Trong cạnh tranh thị trường khốc liệt, năng lực đổi mới sáng tạo của doanh nghiệp còn quan trọng hơn cả tiềm lực tài chính.",
          "explanation": "\"更为重要\" so sánh hai nhân tố quan trọng để khẳng định yếu tố sáng tạo mang tính sống còn."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 99,
      "name": "Phân biệt thể phủ định của câu so sánh: \"A 不比 B\" vs \"A 没有/不如 B\"",
      "pattern": "A 不比 B + Tính từ (A không kém gì B / ngang ngửa B) vs A 没有/不如 B + Tính từ (A thua kém B)",
      "category": "Câu so sánh",
      "explanation_vi": "\"A 不比 B + Tính từ\" mang hàm ý bác bỏ quan điểm cho rằng A thua kém B, ngụ ý A ngang ngửa hoặc thậm chí hơn B (không kém gì). Trong khi đó, \"A 没有 / 不如 B + Tính từ\" là so sánh thua kém đơn thuần, thừa nhận mức độ của A thấp hơn B.",
      "examples": [
        {
          "chinese": "我们虽然是刚创办的小公司，但在产品质量上绝不比大品牌差。",
          "pinyin": "Wǒmen suīrán shì gāng chuàngbàn de xiǎo gōngsī, dàn zài chǎnpǐn zhìliàng shang jué bù bǐ dà pǐnpái chà.",
          "translation_vi": "Chúng tôi tuy là công ty nhỏ mới thành lập, nhưng về chất lượng sản phẩm quyết không thua kém gì các thương hiệu lớn.",
          "explanation": "\"不比大品牌差\" tự tin khẳng định chất lượng đạt chuẩn ngang hàng với các ông lớn đầu ngành."
        },
        {
          "chinese": "在实际工作经验方面，刚刚入职的新人确实不如老员工丰富。",
          "pinyin": "Zài shíjì gōngzuò jīngyàn fāngmiàn, gānggāng rùzhí de xīnrén quèshí bùrú lǎoyuángōng fēngfù.",
          "translation_vi": "Về mặt kinh nghiệm làm việc thực tế, người mới vừa vào công ty quả thực không dồi dào bằng nhân viên kỳ cựu.",
          "explanation": "\"不如老员工丰富\" thừa nhận khoảng cách kinh nghiệm khách quan giữa lính mới và nhân viên lâu năm."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 100,
      "name": "Cấu trúc so sánh phát triển theo biến số: \"越来越...\" vs \"越...越...\"",
      "pattern": "Chủ ngữ + 越来越 + Tính từ / 越 + Điều kiện A + 越 + Kết quả B",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"越来越...\" (yuè lái yuè...) chỉ sự biến đổi của mức độ theo thời gian tự nhiên (càng ngày càng...); trong khi \"越...越...\" (yuè... yuè...) là cấu trúc có điều kiện: mức độ của vế sau biến thiên tỷ lệ thuận hoặc phụ thuộc trực tiếp vào mức độ phát triển của hành động/điều kiện ở vế trước (càng... thì càng...).",
      "examples": [
        {
          "chinese": "随着城市绿化工程的推进，这里的空气质量变得越来越好。",
          "pinyin": "Suízhe chéngshì lǜhuà gōngchéng de tuījìn, zhèlǐ de kōngqì zhìliàng biànde yuè lái yuè hǎo.",
          "translation_vi": "Cùng với sự thúc đẩy của công trình phủ xanh đô thị, chất lượng không khí nơi đây trở nên ngày một tốt hơn.",
          "explanation": "\"越来越好\" miêu tả sự tiến bộ dần đều của môi trường sống theo dòng thời gian."
        },
        {
          "chinese": "这本书的内容非常引人入胜，让人越读越觉得有意思。",
          "pinyin": "Zhè běn shū de nèiróng fēicháng yǐnrénrùshèng, ràng rén yuè dú yuè juéde yǒu yìsi.",
          "translation_vi": "Nội dung cuốn sách này vô cùng lôi cuốn, khiến người ta càng đọc càng cảm thấy thú vị.",
          "explanation": "\"越读越觉得有意思\" thể hiện mức độ say mê tăng dần theo từng trang sách được mở ra."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 101,
      "name": "Cấu trúc cố định dẫn nguồn thông tin khách quan: \"据...\" (Theo như / Căn cứ vào)",
      "pattern": "据 + Nguồn tin (说 / 统计 / 报道 / 专家介绍 / 我所知), Mệnh đề tin tức",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"据\" (jù) là giới từ trang trọng dẫn xuất nguồn gốc của thông tin, số liệu hoặc báo cáo báo chí (theo như, căn cứ theo). Các cụm từ cố định thường gặp trong HSK 4 gồm: 据说 (nghe nói), 据统计 (theo thống kê), 据报道 (theo đưa tin), 据了解 (theo tìm hiểu), 据我所知 (theo như tôi được biết).",
      "examples": [
        {
          "chinese": "据官方权威数据统计，今年该地区的游客接待量突破了五千万人次。",
          "pinyin": "Jù guānfāng quánwēi shùjù tǒngjì, jīnnián gāi dìqū de yóukè jiēdàiliàng tūpò le wǔqiān wàn réncì.",
          "translation_vi": "Theo thống kê số liệu có thẩm quyền chính thức, lượng đón khách du lịch của khu vực này năm nay đã vượt mốc 50 triệu lượt người.",
          "explanation": "\"据官方权威数据统计\" nâng cao độ tin cậy và chuẩn xác khoa học cho con số du lịch."
        },
        {
          "chinese": "据当地气象台报道，未来三天将有一股强冷空气席卷华北地区。",
          "pinyin": "Jù dāngdì qìxiàngtái bàodào, wèilái sān tiān jiāng yǒu yì gǔ qiáng lěngkōngqì xíjuǎn Huáběi dìqū.",
          "translation_vi": "Theo đài khí tượng địa phương đưa tin, trong ba ngày tới sẽ có một đợt không khí lạnh mạnh tràn qua khu vực Hoa Bắc.",
          "explanation": "\"据...报道\" trích dẫn nguồn tin báo chí khí tượng chính thống để cảnh báo rét đậm."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 102,
      "name": "Cấu trúc cố định nêu quan điểm nhận định: \"在我看来\" / \"从...来看\" / \"总的来说\"",
      "pattern": "在我看来, Mệnh đề / 从 + Góc độ + 来看, Mệnh đề / 总的来说, Mệnh đề",
      "category": "Cấu trúc cố định",
      "explanation_vi": "Đây là các mẫu câu định vị góc nhìn và quy nạp luận điểm chuẩn mực trong văn phong nghị luận tiếng Trung: 1) \"在我看来\" (theo quan điểm cá nhân tôi); 2) \"从...来看\" (xét từ góc độ khách quan nào đó); 3) \"总的来说\" (tổng kết lại, nói một cách tổng quát).",
      "examples": [
        {
          "chinese": "在我看来，健康和快乐是人生中最值得珍惜的宝贵财富。",
          "pinyin": "Zài wǒ kànlái, jiànkāng hé kuàilè shì rénshēng zhōng zuì zhíde zhēnxī de bǎoguì cáifù.",
          "translation_vi": "Theo quan điểm của tôi, sức khỏe và niềm vui là tài sản quý báu đáng trân trọng nhất trong cuộc đời.",
          "explanation": "\"在我看来\" mở đầu một cách nhã nhặn để trình bày nhân sinh quan cá nhân về hạnh phúc."
        },
        {
          "chinese": "总的来说，这次文化交流活动不仅增进了友谊，也取得了丰硕的成果。",
          "pinyin": "Zǒng de lái shuō, zhè cì wénhuà jiāoliú huódòng bùjǐn zēngjìn le yǒuyì, yě qǔdé le fēngshuò de chéngguǒ.",
          "translation_vi": "Nhìn chung mà nói, hoạt động giao lưu văn hóa lần này chẳng những thắt chặt tình hữu nghị mà còn đạt được những thành quả phong phú.",
          "explanation": "\"总的来说\" đứng đầu câu để đúc kết toàn diện thành công của chuyến giao lưu."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 103,
      "name": "Cấu trúc cố định phân tích dẫn chứng điển hình: \"拿...来说\" (Lấy... làm ví dụ / Xét về)",
      "pattern": "拿 + Ví dụ điển hình + 来说, Mệnh đề phân tích chi tiết",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"拿...来说\" (ná... lái shuō) dùng để dẫn ra một cá nhân, sự việc hoặc ví dụ điển hình tiêu biểu nhất để minh họa sinh động cho một luận điểm, quy luật chung vừa được nêu ra trước đó (lấy... làm ví dụ mà nói, xét riêng trường hợp...).",
      "examples": [
        {
          "chinese": "中国这几年的移动支付发展极为迅速，拿老年人来说，他们出门买菜也用手机扫码。",
          "pinyin": "Zhōngguó zhè jǐ nián de yídòng zhīfù fāzhǎn jíwéi xùnsù, ná lǎoniánrén láishuō, tāmen chūmén mǎicài yě yòng shǒujī sǎomǎ.",
          "translation_vi": "Thanh toán di động những năm gần đây của Trung Quốc phát triển cực kỳ nhanh chóng, lấy người cao tuổi làm ví dụ, họ ra ngoài mua rau cũng dùng điện thoại quét mã.",
          "explanation": "\"拿老年人来说\" chọn nhóm người cao tuổi làm minh chứng thuyết phục cho sự phổ cập của công nghệ."
        },
        {
          "chinese": "学习外语需要持之以恒，拿背单词来说，三天打鱼两天晒网是很难记牢的。",
          "pinyin": "Xuéxí wàiyǔ xūyào chízhīyǐhéng, ná bèi dāncí láishuō, sān tiān dǎ yú liǎng tiān shài wǎng shì hěn nán jì láo de.",
          "translation_vi": "Học ngoại ngữ cần sự kiên trì bền bỉ, xét về khâu học thuộc từ vựng, nếu bữa đực bữa cái thì rất khó ghi nhớ lâu bền.",
          "explanation": "\"拿背单词来说\" lấy công đoạn học từ vựng cụ thể làm ví dụ chứng minh sự cần thiết của tính kiên trì."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 104,
      "name": "Cấu trúc cố định định danh và giải thích bản chất: \"所谓的...\" & \"也就是说...\"",
      "pattern": "所谓的 + Danh từ/Khái niệm + 就是... / Mệnh đề 1, 也就是说, Mệnh đề 2 (giải thích tương đương)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"所谓的...\" (suǒwèi de...) dùng để đưa ra hoặc định nghĩa một thuật ngữ, khái niệm chuyên môn (cái gọi là...); trong khi \"也就是说...\" (yějiùshìshuō) đóng vai trò diễn giải lại câu nói hoặc mệnh đề phía trước bằng từ ngữ đơn giản, dễ hiểu hơn hoặc rút ra kết luận trực tiếp (tức là, nói cách khác).",
      "examples": [
        {
          "chinese": "所谓的团队合作，就是每个成员都发挥自己的特长并密切配合。",
          "pinyin": "Suǒwèi de tuánduì hézuò, jiù shì měi gè chéngyuán dōu fāhuī zìjǐ de tècháng bìng mìqiè pèihé.",
          "translation_vi": "Cái gọi là tinh thần làm việc nhóm, chính là mỗi thành viên đều phát huy sở trường của mình và phối hợp chặt chẽ.",
          "explanation": "\"所谓的团队合作...\" định nghĩa và làm sáng tỏ bản chất cốt lõi của khái niệm hợp tác tập thể."
        },
        {
          "chinese": "考试成绩达到六十分才算及格，也就是说，五十九分也必须重新补考。",
          "pinyin": "Kǎoshì chéngjì dádào liùshí fēn cái suàn jígé, yějiùshìshuō, wǔshíjiǔ fēn yě bìxū chóngxīn bǔkǎo.",
          "translation_vi": "Điểm thi đạt 60 điểm mới tính là qua môn, tức là nói, 59 điểm cũng bắt buộc phải thi lại.",
          "explanation": "\"也就是说...\" giải thích hệ quả trực tiếp cụ thể hóa của quy định điểm sàn."
        }
      ],
      "hsk_level": "HSK 4",
      "source": "gf0025_2021",
      "validation_status": "verified"
    }
  ],
  "HSK 5": [
    {
      "order_index": 1,
      "name": "Đại từ văn ngôn chỉ định và sở thuộc \"其\" (Của nó / Trong đó / Họ)",
      "pattern": "其 + Danh từ / 其中 / 其实 / 其余 / 极其 / 莫名其妙",
      "category": "Đại từ",
      "explanation_vi": "\"其\" (qí) là đại từ nguồn gốc văn ngôn cổ được sử dụng rộng rãi trong tiếng Trung hiện đại, đặc biệt là văn viết chính luận, khoa học và báo chí. \"其\" tương đương với \"他/她/它的\" (của anh ấy/cô ấy/nó) hoặc \"他们/它们\" (của họ/chúng). Ngoài ra \"其\" tạo thành nhiều từ ghép cố định tối quan trọng như 其中 (trong đó), 其实 (thực ra), 其余 (phần còn lại), 极其 (cực kỳ).",
      "examples": [
        {
          "chinese": "任何事物的发展都有其自身的规律，我们不能急于求成。",
          "pinyin": "Rènhé shìwù de fāzhǎn dōu yǒu qí zìshēn de guīlǜ, wǒmen bù néng jíyúqiúchéng.",
          "translation_vi": "Sự phát triển của bất kỳ sự vật nào đều có quy luật của chính bản thân nó, chúng ta không thể nôn nóng muốn thành công ngay.",
          "explanation": "\"其自身\" tương đương với \"它自身\" (chính bản thân nó), \"其\" thay thế cho \"事物\" tạo sắc thái văn phong triết lý sâu sắc."
        },
        {
          "chinese": "参加本次论坛的专家共有五十位，其中半数来自海外知名院校。",
          "pinyin": "Cānjiā běn cì lùntán de zhuānjiā gòng yǒu wǔshí wèi, qízhōng bànshù láizì hǎiwài zhīmíng yuànxiào.",
          "translation_vi": "Có tổng cộng 50 chuyên gia tham dự diễn đàn lần này, trong số đó một nửa đến từ các trường viện nổi tiếng ở nước ngoài.",
          "explanation": "\"其中\" (trong số đó) là cụm từ cố định dẫn ra một bộ phận thành viên nằm trong tổng thể 50 chuyên gia."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 2,
      "name": "Đại từ nghi vấn văn ngôn phản vấn \"何\" (Gì / Thế nào / Sao)",
      "pattern": "何 + Động từ/Danh từ (何必 / 何况 / 何在 / 何尝 / 为何 / 任何)",
      "category": "Đại từ",
      "explanation_vi": "\"何\" (hé) là đại từ nghi vấn văn ngôn tương đương với \"什么\" (cái gì), \"为什么\" (tại sao) hoặc \"怎么\" (thế nào). Trong tiếng Trung hiện đại HSK 5, \"何\" thường xuất hiện trong các kết cấu câu trang trọng hoặc các liên từ, phó từ phản vấn như 何必 (hà tất), 何况 (huống hồ), 为何 (vì sao), 何在 (ở đâu, nằm ở chỗ nào).",
      "examples": [
        {
          "chinese": "面对如此明显的错误事实，你又为何迟迟不肯当面承认呢？",
          "pinyin": "Miànduì rúcǐ míngxiǎn de cuòwù shìshí, nǐ yòu wèihé chíchí bù kěn dāngmiàn chéngrèn ne?",
          "translation_vi": "Đối mặt với sự thật sai sót rõ ràng như thế này, cậu lại vì cớ gì mà cứ chần chừ không chịu thừa nhận trước mặt chứ?",
          "explanation": "\"为何\" là cách diễn đạt trang trọng của \"为什么\", biểu thị ngữ khí chất vấn nghiêm túc."
        },
        {
          "chinese": "企业要想在激烈的市场中立足，其核心竞争力究竟何在？",
          "pinyin": "Qǐyè yào xiǎng zài jīliè de shìchǎng zhōng lìzú, qí héxīn jìngzhēnglì jiūjìng hézài?",
          "translation_vi": "Doanh nghiệp muốn đứng vững trong thị trường cạnh tranh khốc liệt, sức cạnh tranh cốt lõi của nó rốt cuộc nằm ở đâu?",
          "explanation": "\"何在\" tương đương với \"在哪里\" (nằm ở nơi đâu), đặt ra câu hỏi bản chất về năng lực cạnh tranh."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 3,
      "name": "Đại từ nhân xưng xưng hô trang trọng tập thể \"诸位\" (Chư vị / Các vị)",
      "pattern": "诸位 + (Danh từ xưng hô) / 诸位 + Xin hãy...",
      "category": "Đại từ",
      "explanation_vi": "\"诸位\" (zhūwèi) là đại từ nhân xưng ngôi thứ hai số nhiều mang sắc thái vô cùng lịch thiệp, trang trọng (chư vị, các vị, quý vị). Thường được các diễn giả, người chủ trì hoặc lãnh đạo sử dụng khi mở đầu bài phát biểu, diễn thuyết trước cử tọa (như 诸位来宾, 诸位同事, 诸位朋友).",
      "examples": [
        {
          "chinese": "非常荣幸能与诸位专家学者共同探讨人工智能的未来趋势。",
          "pinyin": "Fēicháng róngxìng néng yǔ zhūwèi zhuānjiā xuézhě gòngtóng tàntǎo réngōng zhìnéng de wèilái qūshì.",
          "translation_vi": "Vô cùng vinh hạnh khi được cùng chư vị chuyên gia học giả thảo luận về xu thế tương lai của trí tuệ nhân tạo.",
          "explanation": "\"诸位专家学者\" là cách xưng hô kính cẩn của diễn giả trước đông đảo các nhà khoa học."
        },
        {
          "chinese": "诸位请安静，今天的新闻发布会马上就要正式开始了。",
          "pinyin": "Zhūwèi qǐng ānjìng, jīntiān de xīnwén fābùhuì mǎshàng jiù yào zhèngshì kāishǐ le.",
          "translation_vi": "Xin chư vị hãy giữ trật tự, buổi họp báo tin tức hôm nay sắp sửa chính thức bắt đầu rồi.",
          "explanation": "\"诸位请安静\" dùng đại từ xưng hô trang trọng để thu hút sự chú ý của toàn thể phóng viên trong khán phòng."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 4,
      "name": "Đại từ văn ngôn phiếm chỉ bao quát \"凡\" (Phàm là / Hễ là / Toàn bộ)",
      "pattern": "凡 + Danh từ/Mệnh đề, 皆 / 都 + Vị ngữ / 凡事 / 大凡",
      "category": "Đại từ",
      "explanation_vi": "\"凡\" (fán) là đại từ phiếm chỉ bắt nguồn từ văn ngôn mang nghĩa \"phàm là, hễ là, tất cả những ai/cái gì thuộc phạm vi đó\". Trong HSK 5, \"凡\" thường kết hợp với \"皆\" (jiē - đều) trong văn cổ ngữ, hoặc kết hợp với \"都\" trong văn viết hiện đại, tạo nên các thành ngữ như \"凡事\" (mọi việc), \"大凡\" (đại phàm).",
      "examples": [
        {
          "chinese": "凡事预则立，不预则废，做任何工作都需要提前做好充分准备。",
          "pinyin": "Fánshì yù zé lì, bú yù zé fèi, zuò rènhé gōngzuò dōu xūyào tíqián zuò hǎo chōngfèn zhǔnbèi.",
          "translation_vi": "Phàm mọi việc có chuẩn bị trước thì ắt thành công, không chuẩn bị trước thì ắt thất bại, làm bất kỳ công việc gì cũng cần chuẩn bị chu đáo trước.",
          "explanation": "\"凡事\" nghĩa là mọi việc, trích từ câu châm ngôn kinh điển nhấn mạnh tầm quan trọng của sự chuẩn bị."
        },
        {
          "chinese": "凡涉及国家机密的重要文件，一律不得通过公共互联网传输。",
          "pinyin": "Fán shèjí guójiā jīmì de zhòngyào wénjiàn, yílǜ bùdé tōngguò gōnggòng hùliánwǎng chuānshū.",
          "translation_vi": "Phàm là tài liệu quan trọng liên quan đến bí mật quốc gia, nhất loạt không được truyền qua mạng internet công cộng.",
          "explanation": "\"凡涉及...\" bao quát toàn bộ tài liệu cơ mật theo quy định bảo mật an ninh thông tin."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 5,
      "name": "Số từ văn ngôn chỉ tỉ lệ mười phần \"成\" (Phần mười / 10%)",
      "pattern": "Số từ + 成 (三成 = 30% / 七成 = 70% / 九成 / 几成)",
      "category": "Số từ",
      "explanation_vi": "\"成\" (chéng) trong lĩnh vực kinh tế, tài chính và phân tích xã hội biểu thị đơn vị một phần mười (tương đương 10%). Ví dụ: 一成 = 10%, 三成 = 30%, 八成 = 80%. Ngoài ra, trong khẩu ngữ \"八成\" hoặc \"九成\" còn làm phó từ mang nghĩa \"chắc chắn đến tám chín phần mười, khả năng rất cao\".",
      "examples": [
        {
          "chinese": "今年我国新能源汽车的市场占有率已经成功突破了三成。",
          "pinyin": "Jīnnián wǒ guó xīn néngyuán qìchē de shìchǎng zhànyǒulǜ yǐjīng chénggōng tūpò le sān chéng.",
          "translation_vi": "Năm nay thị phần xe ô tô năng lượng mới của nước ta đã thành công vượt mốc 30% (ba phần mười).",
          "explanation": "\"三成\" chỉ tỉ lệ 30% thị phần tiêu thụ trong phân tích kinh tế vĩ mô."
        },
        {
          "chinese": "看他今天满面春风的样子，这次面试八成是顺利通过了。",
          "pinyin": "Kàn tā jīntiān mǎnmiànchūnfēng de yàngzi, zhè cì miànshì bāchéng shì shùnlì tōngguò le.",
          "translation_vi": "Nhìn vẻ mặt hớn hở tràn đầy sức sống của anh ấy hôm nay, buổi phỏng vấn lần này đến tám chín phần mười là đã trót lọt đỗ rồi.",
          "explanation": "\"八成\" ở đây đóng vai trò ước lượng xác suất cao (khoảng 80–90%) trong nhận định tâm lý."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 6,
      "name": "Số từ phiếm chỉ số lượng không xác định \"若干\" (Một số / Mấy / Vài)",
      "pattern": "若干 + (Lượng từ) + Danh từ / 划分为若干部分",
      "category": "Số từ",
      "explanation_vi": "\"若干\" (ruògān) là số từ văn viết biểu thị một số lượng không xác định hoặc chưa tiện nêu con số cụ thể (khoảng một vài, một số, mấy). Thường dùng trong các văn kiện pháp quy, điều lệ, đề cương khoa học hoặc hợp đồng kinh tế.",
      "examples": [
        {
          "chinese": "为了便于深入研究，专家组将整个课题细分成了若干个子项目。",
          "pinyin": "Wèile biànyú shēnrù yánjiū, zhuānjiāzǔ jiǎng zhěng gè kètí xìfēn chéng le ruògān gè zǐxiàngmù.",
          "translation_vi": "Để tiện cho việc nghiên cứu chuyên sâu, tổ chuyên gia đã chia nhỏ toàn bộ đề tài thành một số dự án nhánh.",
          "explanation": "\"若干个子项目\" chỉ một số dự án thành phần được chia tách có hệ thống."
        },
        {
          "chinese": "经过若干年的艰苦奋斗，这片曾经荒凉的戈壁滩变成了绿洲。",
          "pinyin": "Jīngguò ruògān nián de jiānkǔ fèndòu, zhè piàn céngjīng huāngliáng de gēbìtān biànchéng le lǜzhōu.",
          "translation_vi": "Sau mấy năm ròng phấn đấu gian khổ, vùng đất sa mạc từng cằn cỗi hoang vu này đã biến thành một ốc đảo xanh tươi.",
          "explanation": "\"若干年\" chỉ khoảng thời gian nhiều năm phấn đấu kiên trì không ghi đích danh số năm."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 7,
      "name": "Danh lượng từ chuyên dùng cho luồng khí, sức lực, mùi vị \"股\" (Luồng / Cơn / Dòng / Món)",
      "pattern": "Số từ + 股 + Danh từ (力量 / 气味 / 热流 / 暖意 / 热情 / 泉水 / 烟)",
      "category": "Lượng từ",
      "explanation_vi": "\"股\" (gǔ) là lượng từ chuyên dùng cho: 1) Các hiện tượng vô hình hoặc chất khí có dòng chảy như mùi hương, luồng nhiệt, khói (一股清香, 一股热浪); 2) Cảm xúc, tinh thần hoặc sức lực bộc phát mạnh mẽ (一股力量, 一股劲儿); 3) Dòng người hoặc nhóm người di chuyển (一股势力, 一股土匪).",
      "examples": [
        {
          "chinese": "走进花园，迎面扑来一股淡淡的茉莉花清香。",
          "pinyin": "Zǒujìn huāyuán, yíngmiàn pūlái yì gǔ dàndàn de mòlìhuā qīngxiāng.",
          "translation_vi": "Bước vào hoa viên, phả thẳng vào mặt là một luồng hương hoa nhài thơm mát thoang thoảng.",
          "explanation": "\"一股...清香\" dùng \"股\" định lượng cho dòng hương thơm dịu mát của hoa cỏ."
        },
        {
          "chinese": "看到大家毫无私心的支援，他心头顿时涌起了一股强烈的暖意。",
          "pinyin": "Kàndào dàjiā háowú sīxīn de zhīyuán, tā xīntóu dùnshí yǒngqǐ le yì gǔ qiángliè de nuǎnyì.",
          "translation_vi": "Nhìn thấy sự chi viện không chút vụ lợi của mọi người, trong lòng anh ấy lập tức dâng trào một luồng cảm giác ấm áp mãnh liệt.",
          "explanation": "\"一股强烈的暖意\" dùng \"股\" miêu tả dòng cảm xúc ấm áp dạt dào trong tâm khảm."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 8,
      "name": "Danh lượng từ & động lượng từ chỉ đợt, cơn ngắn \"阵\" (Cơn / Trận / Đợt)",
      "pattern": "一 + 阵 + Danh từ (雨 / 风 / 掌声 / 欢呼声 / 剧痛) / 一阵阵",
      "category": "Lượng từ",
      "explanation_vi": "\"阵\" (zhèn) biểu thị một khoảng thời gian ngắn hoặc một đợt bộc phát của hành động, hiện tượng tự nhiên hoặc âm thanh diễn ra trong chốc lát rồi ngớt (như 一阵风 - cơn gió, 一阵掌声 - một tràng pháo tay). Dạng trùng điệp \"一阵阵\" diễn tả các đợt sóng âm thanh hoặc cảm giác nối tiếp nhau dồn dập.",
      "examples": [
        {
          "chinese": "演出结束后，台下立刻爆发出一阵雷鸣般的掌声。",
          "pinyin": "Yǎnchū jiéshù hòu, táixià lìkè bàofā chū yí zhèn léimíng bān de zhǎngshēng.",
          "translation_vi": "Sau khi buổi diễn kết thúc, dưới khán đài lập tức bùng nổ một tràng pháo tay rộn rã như sấm rền.",
          "explanation": "\"一阵...掌声\" định lượng cho tràng vỗ tay nhiệt liệt bùng lên từ khán giả."
        },
        {
          "chinese": "突然刮来了一阵刺骨的狂风，吹得树枝剧烈摇晃。",
          "pinyin": "Tūrán guālái le yí zhèn cìgǔ de kuángfēng, chuī de shùzhī jùliè yáohuàng.",
          "translation_vi": "Đột nhiên một cơn gió lốc buốt xương thổi tới, thổi khiến các cành cây rung lắc dữ dội.",
          "explanation": "\"一阵...狂风\" diễn tả cơn gió lốc thổi mạnh đột ngột trong thời gian ngắn."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 9,
      "name": "Danh lượng từ chỉ bó, chùm, tia \"束\" (Bó / Chùm / Tia)",
      "pattern": "Số từ + 束 + Danh từ (花 / 鲜花 / 光 / 阳光 / 激光)",
      "category": "Lượng từ",
      "explanation_vi": "\"束\" (shù) dùng cho: 1) Các vật thể được bó lại, buộc túm lại thành chùm (như 一束鲜花 - một bó hoa tươi); 2) Chùm tia sáng tụ lại chiếu theo đường thẳng (như 一束光 - một chùm sáng, 一束阳光 - một tia nắng mặt trời).",
      "examples": [
        {
          "chinese": "他手捧着一束美丽的红玫瑰，微笑着走向新娘。",
          "pinyin": "Tā shǒu pěngzhe yí shù měilì de hóng méiguī, wēixiàozhe zǒuxiàng xīnniáng.",
          "translation_vi": "Anh ấy hai tay ôm một bó hoa hồng đỏ tươi đẹp, mỉm cười bước về phía cô dâu.",
          "explanation": "\"一束...红玫瑰\" dùng \"束\" chỉ bó hoa cưới được kết trang trọng."
        },
        {
          "chinese": "清晨，一束温暖的阳光穿透窗帘，静静地洒在书桌上。",
          "pinyin": "Qīngchén, yí shù wēnnuǎn de yángguāng chuāntòu chuānglián, jìngjìng de sǎ zài shūzhuō shang.",
          "translation_vi": "Sáng sớm, một tia nắng ấm áp xuyên qua rèm cửa sổ, lặng lẽ rọi xuống mặt bàn học.",
          "explanation": "\"一束温暖的阳光\" dùng \"束\" định lượng cho vạt nắng sáng sớm chiếu xuyên qua khe rèm."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 10,
      "name": "Danh lượng từ chỉ xâu, chuỗi liên hoàn \"串\" (Xâu / Chuỗi / Dãy)",
      "pattern": "Số từ + 串 + Danh từ (钥匙 / 葡萄 / 珍珠 / 数字 / 问号 / 糖葫芦)",
      "category": "Lượng từ",
      "explanation_vi": "\"串\" (chuàn) dùng cho các sự vật có cùng chủng loại được xâu nối tiếp liền nhau thành một đường dây (như 一串钥匙 - một chùm chìa khóa, 一串葡萄 - một chùm nho, 一串项链 - một chuỗi dây chuyền). Ngoài ra còn dùng ẩn dụ cho chuỗi trừu tượng (như 一连串问题 - một loạt vấn đề).",
      "examples": [
        {
          "chinese": "奶奶手里提着一串新鲜的紫葡萄，笑盈盈地递给了孙子。",
          "pinyin": "Nǎinai shǒulǐ tízhe yí chuàn xīnxiān de zǐ pútáo, xiàoyíngyíng de dìgěi le sūnzi.",
          "translation_vi": "Bà nội tay xách một chùm nho tím tươi ngon, cười tươi đon đả đưa cho cháu trai.",
          "explanation": "\"一串...紫葡萄\" dùng \"串\" chỉ cả chùm quả nho bám tự nhiên trên cuống."
        },
        {
          "chinese": "这一连串突发的严重事故，引起了监管部门的高度警惕。",
          "pinyin": "Zhè yì lián chuàn tūfā de yánzhòng shìgù, yǐnqǐ le jiānguǎn bùmén de gāodù jǐngtì.",
          "translation_vi": "Một chuỗi những sự cố nghiêm trọng bộc phát liên tiếp này đã dấy lên sự cảnh giác cao độ của cơ quan giám sát.",
          "explanation": "\"一连串...事故\" dùng \"串\" ẩn dụ cho hàng loạt vụ việc xảy ra liên hoàn dồn dập."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 11,
      "name": "Danh lượng từ chuyên dùng cho hạng mục, công trình, quy định \"项\" (Hạng mục / Điều)",
      "pattern": "Số từ + 项 + Danh từ (任务 / 技术 / 制度 / 纪录 / 调查 / 研究 / 成果)",
      "category": "Lượng từ",
      "explanation_vi": "\"项\" (xiàng) là lượng từ chuyên dùng cho các sự vụ, hạng mục quy mô, điều khoản luật pháp, kế hoạch nghiên cứu, hoặc thành tựu thể thao mang tính phân mục rõ ràng.",
      "examples": [
        {
          "chinese": "科学家们经过多年的探索，成功攻克了这这项重大的核心技术。",
          "pinyin": "Kēxuéjiāmen jīngguò duō nián de tànsuǒ, chénggōng gōngkè le zhè xiàng zhòngdà de héxīn jìshù.",
          "translation_vi": "Các nhà khoa học trải qua nhiều năm tìm tòi, đã thành công chinh phục được hạng mục công nghệ cốt lõi trọng đại này.",
          "explanation": "\"这项重大的核心技术\" dùng \"项\" định lượng cho hạng mục công nghệ cấp quốc gia."
        },
        {
          "chinese": "在这届世界田径锦标赛上，他打破了一项尘封二十年的世界纪录。",
          "pinyin": "Zài zhè jiè shìjiè tiánjìng jǐnbiāosài shang, tā dǎpò le yí xiàng chénfēng èrshí nián de shìjiè jìlù.",
          "translation_vi": "Tại giải vô địch điền kinh thế giới lần này, anh ấy đã phá vỡ một kỷ lục thế giới bị phủ bụi suốt 20 năm.",
          "explanation": "\"一项...世界纪录\" dùng \"项\" làm lượng từ chuẩn xác cho kỷ lục thể thao thành tích cao."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 12,
      "name": "Danh lượng từ chỉ lô, đợt hàng hóa hoặc tốp người \"批\" (Lô / Đợt / Tốp)",
      "pattern": "Số từ + 批 + Danh từ (货物 / 产品 / 游客 / 学员 / 专家) / 第一批 / 分批",
      "category": "Lượng từ",
      "explanation_vi": "\"批\" (pī) biểu thị một tập hợp số lượng lớn hàng hóa, sản phẩm được sản xuất/vận chuyển trong cùng một đợt, hoặc một nhóm đông người được tổ chức xuất phát/huấn luyện theo từng đợt.",
      "examples": [
        {
          "chinese": "海关工作人员正在对刚从欧洲进口的第一批医疗器械进行严格检验。",
          "pinyin": "Hǎiguān gōngzuò rényuán zhèngzài duì gāng cóng Ōuzhōu jìnkǒu de dì yī pī yīliáo qìxiè jìnxíng yángé jiǎnyàn.",
          "translation_vi": "Các nhân viên hải quan đang tiến hành kiểm nghiệm nghiêm ngặt lô thiết bị y tế đầu tiên vừa nhập khẩu từ châu Âu.",
          "explanation": "\"第一批医疗器械\" chỉ lô hàng hóa thiết bị y tế đợt 1 cập cảng hải quan."
        },
        {
          "chinese": "景区采取了分批进入的限流措施，确保每批游客都能安全游览。",
          "pinyin": "Jǐngqū cǎiqǔ le fēnpī jìnrù de xiànliú cuòshī, quèbǎo měi pī yóukè dōu néng ānquán yóulǎn.",
          "translation_vi": "Khu danh lam thắng cảnh đã áp dụng biện pháp hạn chế dòng người theo từng tốp, bảo đảm mỗi tốp du khách đều có thể tham quan an toàn.",
          "explanation": "\"分批进入\" và \"每批游客\" dùng \"批\" để chỉ từng nhóm đoàn người vào cổng luân phiên."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 13,
      "name": "Danh lượng từ chỉ món tiền, vụ kiện, thương vụ lớn \"宗\" (Món / Vụ / Loại)",
      "pattern": "Số từ + 宗 + Danh từ (买卖 / 案件 / 交易 / 生意 / 大宗商品)",
      "category": "Lượng từ",
      "explanation_vi": "\"宗\" (zōng) là lượng từ kinh tế, thương mại và tư pháp trang trọng, dùng cho các giao dịch quy mô lớn (như 一宗买卖 - một mối làm ăn lớn, 一宗交易 - một vụ giao dịch), hoặc các vụ án tư pháp (一宗案件). Thuật ngữ \"大宗商品\" chỉ hàng hóa rời nguyên liệu thô số lượng lớn.",
      "examples": [
        {
          "chinese": "两国跨国公司经过艰苦谈判，终于促成了一宗高达十亿美元的重大并购交易。",
          "pinyin": "Liǎng guó kuàguó gōngsī jīngguò jiānkǔ tánpàn, zhōngyú cùchéng le yì zōng gāodá shíyì měiyuán de zhòngdà bìnggòu jiāoyì.",
          "translation_vi": "Các công ty đa quốc gia hai nước sau các cuộc đàm phán gian nan, cuối cùng đã thúc đẩy thành công một vụ giao dịch sáp nhập trọng đại lên tới một tỷ đô la Mỹ.",
          "explanation": "\"一宗...并购交易\" dùng \"宗\" định lượng cho thương vụ sáp nhập doanh nghiệp tài chính khổng lồ."
        },
        {
          "chinese": "警方历时三年不懈追踪，成功侦破了这宗性质极其恶劣的跨国诈骗案件。",
          "pinyin": "Jǐngfāng lìshí sān nián búxiè zhuīzōng, chénggōng zhēnpò le zhè zōng xìngzhì jíqí èliè de kuàguó zhàpiàn ànjiàn.",
          "translation_vi": "Lực lượng cảnh sát trải qua ba năm truy vết không ngừng nghỉ, đã phá thành công vụ án lừa đảo xuyên quốc gia có tính chất cực kỳ nghiêm trọng này.",
          "explanation": "\"这宗...案件\" dùng \"宗\" làm lượng từ tư pháp chuẩn xác cho vụ án hình sự phức tạp."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 14,
      "name": "Danh lượng từ chỉ tượng điêu khắc, thần phật trang nghiêm \"尊\" (Bức / Pho / Vị)",
      "pattern": "Số từ + 尊 + Danh từ (佛像 / 雕塑 / 大炮 / 铜像)",
      "category": "Lượng từ",
      "explanation_vi": "\"尊\" (zūn) là lượng từ thể hiện sự tôn nghiêm, tôn kính cao quý, chuyên dùng cho các bức tượng Phật, pho tượng điêu khắc nghệ thuật cổ điển, tượng đồng vĩ nhân (như 一尊佛像, 一尊雕塑, 一尊青铜像).",
      "examples": [
        {
          "chinese": "在博物馆中央展厅里，陈列着一尊雕刻精湛的唐代石刻佛像。",
          "pinyin": "Zài bówùguǎn zhōngyāng zhǎntīng lǐ, chénlièzhe yì zūn diāokè jīngzhàn de Tángdài shíkè fóxiàng.",
          "translation_vi": "Ở phòng triển lãm trung tâm của bảo tàng có trưng bày một pho tượng Phật khắc đá thời Đường được chạm trổ tuyệt mỹ.",
          "explanation": "\"一尊...佛像\" dùng \"尊\" thể hiện sự tôn kính và giá trị linh thiêng của bảo vật tôn giáo cổ."
        },
        {
          "chinese": "广场中央矗立着一尊高大的民族英雄青铜雕塑。",
          "pinyin": "Guǎngchǎng zhōngyāng chùlìzhe yì zūn gāodà de mínzú yīngxióng qīngtóng diāosù.",
          "translation_vi": "Giữa quảng trường sừng sững một bức tượng đồng anh hùng dân tộc uy nghi cao lớn.",
          "explanation": "\"一尊...青铜雕塑\" dùng \"尊\" để thể hiện sự trang trọng, uy nghiêm của công trình đài tưởng niệm."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 15,
      "name": "Danh lượng từ chuyên dùng cho tàu thuyền vận tải \"艘\" (Chiếc / Con tàu)",
      "pattern": "Số từ + 艘 + Danh từ (船 / 轮船 / 军舰 / 货轮 / 潜艇)",
      "category": "Lượng từ",
      "explanation_vi": "\"艘\" (sōu) là lượng từ chuyên dụng dành riêng cho các phương tiện thủy cỡ lớn như tàu thủy, tàu chở hàng, tàu chiến, du thuyền, tàu ngầm (khác với \"条\" hoặc \"只\" thường dùng cho thuyền nhỏ dân dụng).",
      "examples": [
        {
          "chinese": "港口码头边停泊着一艘装满了集装箱的大型远洋货轮。",
          "pinyin": "Gǎngkǒu mǎtóu biān tíngbózhe yì sōu zhuāngmǎn le jízhuāngxiāng de dàxíng yuǎnyáng huòlún.",
          "translation_vi": "Bên cầu cảng có neo đậu một con tàu hàng viễn dương cỡ lớn chở đầy các thùng container.",
          "explanation": "\"一艘...远洋货轮\" dùng \"艘\" làm lượng từ quy chuẩn cho tàu vận tải viễn dương quốc tế."
        },
        {
          "chinese": "经过严密的技术改造，这艘科考船即将启程前往南极进行深海科学考察。",
          "pinyin": "Jīngguò yánmì de jìshù gǎizào, zhè sōu kēkǎochuán jíjiāng qǐchéng qiánwǎng Nánjí jìnxíng shēnhǎi kēxué kǎochá.",
          "translation_vi": "Sau khi được cải tạo kỹ thuật nghiêm ngặt, con tàu khảo sát khoa học này sắp sửa lên đường tới Nam Cực tiến hành khảo sát khoa học biển sâu.",
          "explanation": "\"这艘科考船\" dùng \"艘\" định lượng cho tàu chuyên dụng nghiên cứu đại dương."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 16,
      "name": "Danh lượng từ chỉ tòa nhà, công trình đồ sộ \"幢 / 栋\" (Tòa / Căn / Dãy nhà)",
      "pattern": "Số từ + 幢 / 栋 + Danh từ (大楼 / 别墅 / 教学楼 / 建筑 / 公寓)",
      "category": "Lượng từ",
      "explanation_vi": "\"幢\" (zhuàng) và \"栋\" (dòng) là lượng từ chuyên dùng cho các tòa nhà kiến trúc độc lập, nhà cao tầng, khu biệt thự hoặc khối nhà chung cư. \"栋\" phổ biến hơn trong giao tiếp đời sống và bất động sản, còn \"幢\" mang sắc thái văn phong miêu tả kiến trúc trang trọng.",
      "examples": [
        {
          "chinese": "市中心新建成了一幢高达三百米的地标性摩天大楼。",
          "pinyin": "Shìzhōngxīn xīn jiànchéng le yí zhuàng gāodá sān bǎi mǐ de dìbiāoxìng mótiāndàlóu.",
          "translation_vi": "Tại trung tâm thành phố vừa mới xây xong một tòa nhà chọc trời mang tính biểu tượng cao tới 300 mét.",
          "explanation": "\"一幢...摩天大楼\" dùng \"幢\" định lượng cho tòa tháp chọc trời nguy nga."
        },
        {
          "chinese": "学校规划在湖畔为新引进的青年学者建造两栋现代化的教师公寓。",
          "pinyin": "Xuéxiào guīhuà zài húpàn wèi xīn yǐnjìn de qīngnián xuézhě jiànzào liǎng dòng xiàndàihuà de jiàoshī gōngyù.",
          "translation_vi": "Nhà trường quy hoạch xây dựng bên bờ hồ hai tòa nhà chung cư giáo viên hiện đại dành cho các học giả trẻ mới được thu hút về.",
          "explanation": "\"两栋...教师公寓\" dùng \"栋\" chỉ hai khối nhà cư xá dành cho giảng viên."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 17,
      "name": "Phó từ thừa nhận nhượng bộ trước khi chuyển ngoặt \"固然\" (Cố nhiên / Tuy rằng / Đành rằng)",
      "pattern": "A 固然... (但是 / 可是 / 也...) B",
      "category": "Phó từ",
      "explanation_vi": "\"固然\" (gùrán) dùng để thừa nhận một sự thật, một ưu điểm hoặc thực tế hiển nhiên ở vế trước (đành rằng là như vậy, vốn dĩ đúng là thế), nhưng trọng tâm luận điểm thực sự nằm ở vế sau với quan hệ chuyển ngoặt (nhưng phương diện kia mới là mấu chốt quan trọng hơn).",
      "examples": [
        {
          "chinese": "工作赚钱固然重要，但是身体健康才是人生最根本的基石。",
          "pinyin": "Gōngzuò zhuànqián gùrán zhòngyào, dànshì shēntǐ jiànkāng cái shì rénshēng zuì gēnběn de jīshí.",
          "translation_vi": "Làm việc kiếm tiền đành rằng là quan trọng, nhưng sức khỏe mới là nền tảng căn bản nhất của đời người.",
          "explanation": "\"固然...但是...\" thừa nhận giá trị của thu nhập để làm nổi bật tầm quan trọng tối cao của sức khỏe."
        },
        {
          "chinese": "引进先进技术固然能够解燃眉之急，但自主创新才拥有长远的未来。",
          "pinyin": "Yǐnjìn xiānjìn jìshù gùrán nénggòu jiě ránméizhījí, dàn zìzhǔ chuàngxīn cái yōngyǒu chángyuǎn de wèilái.",
          "translation_vi": "Du nhập công nghệ tiên tiến cố nhiên có thể giải quyết được nhu cầu cấp bách trước mắt, nhưng tự chủ sáng tạo mới nắm giữ tương lai lâu dài.",
          "explanation": "\"固然...但...\" so sánh giữa giải pháp tình thế trước mắt và chiến lược tự chủ lâu dài."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 18,
      "name": "Phó từ xác nhận sự thật chân thực \"诚然\" (Quả thực / Đúng là)",
      "pattern": "诚然 + Sự thật thừa nhận, 但是 / 然而 + Luận điểm trọng tâm",
      "category": "Phó từ",
      "explanation_vi": "\"诚然\" (chéngrán) là phó từ cao cấp tương đương với \"固然\", nhưng mang sắc thái chân thành, trang nghiêm và tính học thuật cao hơn (quả thực là, đúng là như vậy). Người viết thừa nhận một cách khách quan luận cứ của đối phương trước khi phản biện mở rộng.",
      "examples": [
        {
          "chinese": "这套方案诚然存在一定的执行风险，然而它所能带来的回报同样极其巨大。",
          "pinyin": "Zhè tào fāng'àn chéngrán cúnzài yídìng de zhíxíng fēngxiǎn, rán'ér tā suǒ néng dàilái de huíbào tóngyàng jíqí jùdà.",
          "translation_vi": "Phương án này quả thực tồn tại rủi ro thực thi nhất định, tuy nhiên lợi ích đền đáp mà nó có thể mang lại cũng cực kỳ to lớn.",
          "explanation": "\"诚然...然而...\" thể hiện phong thái biện luận khách quan thừa nhận rủi ro song hành cùng cơ hội."
        },
        {
          "chinese": "传统手工业诚然无法与现代机器生产的速度相比，但它蕴含着独一无二的人文温度。",
          "pinyin": "Chuántǒng shǒugōngyè chéngrán wúfǎ yǔ xiàndài jīqì shēngchǎn de sùdù xiāngbǐ, dàn tā yùnhánzhe dúyīwú'èr de rénwén wēndù.",
          "translation_vi": "Thủ công nghiệp truyền thống quả thực không thể sánh được với tốc độ sản xuất máy móc hiện đại, nhưng nó hàm chứa hơi ấm nhân văn độc nhất vô nhị.",
          "explanation": "\"诚然...但...\" tôn vinh giá trị tinh thần của làng nghề truyền thống trước sức ép công nghiệp."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 19,
      "name": "Phó từ kiên quyết phủ định lập trường \"决不 / 绝不\" (Tuyệt đối không / Quyết không)",
      "pattern": "Chủ ngữ + 决不 / 绝不 + Động từ/Tính từ (妥协 / 姑息 / 放弃 / 违背)",
      "category": "Phó từ",
      "explanation_vi": "\"决不\" và \"绝不\" (juébù) là phó từ biểu thị ý chí sắt đá, quyết tâm sắt son không bao giờ làm một việc gì đó (tuyệt đối không, quyết không nhượng bộ). \"决不\" thiên về ý chí quyết định của chủ quan con người, còn \"绝不\" thiên về tính chất tuyệt đối không có ngoại lệ.",
      "examples": [
        {
          "chinese": "在事关国家领土和主权完整的原则问题上，我们决不作任何妥协。",
          "pinyin": "Zài shìguān guójiā lǐngtǔ hé zhǔquán wánzhěng de yuánzé wèntí shang, wǒmen juébù zuò rènhé tuǒxié.",
          "translation_vi": "Trên vấn đề nguyên tắc liên quan đến chủ quyền và toàn vẹn lãnh thổ quốc gia, chúng ta quyết không đưa ra bất kỳ sự thỏa hiệp nào.",
          "explanation": "\"决不作任何妥协\" tuyên bố đanh thép bảo vệ chủ quyền quốc gia bất khả xâm phạm."
        },
        {
          "chinese": "无论面临多大的诱惑，一名法官都绝不能违背司法公正的职业底线。",
          "pinyin": "Wúlùn miànlín duō dà de yòuhuò, yì míng fǎguān dōu juébù néng wéibèi sīfǎ gōngzhèng de zhíyè dǐxiàn.",
          "translation_vi": "Bất luận đối mặt với cám dỗ lớn đến mức nào, một người thẩm phán đều tuyệt đối không thể làm trái lằn ranh đạo đức nghề nghiệp về sự công bằng tư pháp.",
          "explanation": "\"绝不能违背...\" khẳng định ranh giới liêm chính tối thượng của người cầm cán cân công lý."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 20,
      "name": "Phó từ dứt khoát kiên quyết không do dự \"断然\" (Dứt khoát / Kiên quyết)",
      "pattern": "Chủ ngữ + 断然 + Động từ (拒绝 / 采取措施 / 否定 / 采取行动)",
      "category": "Phó từ",
      "explanation_vi": "\"断然\" (duànrán) biểu thị hành động được đưa ra một cách dứt khoát, mạnh mẽ, không một chút do dự hay nhân nhượng (dứt khoát, kiên quyết). Thường đi với các động từ có tính quyết định cao như 拒绝 (từ chối), 采取措施 (áp dụng biện pháp), 否定 (bác bỏ).",
      "examples": [
        {
          "chinese": "面对不法商人提出的无理要求，负责人断然拒绝了对方的行贿企图。",
          "pinyin": "Miànduì bùfǎ shāngrén tíchū de wúlǐ yāoqiú, fùzérén duànrán jùjué le duìfāng de xínghuì qǐtú.",
          "translation_vi": "Đối mặt với yêu sách vô lý mà thương nhân bất chính đưa ra, người phụ trách đã dứt khoát cự tuyệt mưu toan hối lộ của đối phương.",
          "explanation": "\"断然拒绝\" miêu tả thái độ kiên quyết từ chối thẳng thừng hành vi phi pháp."
        },
        {
          "chinese": "为了防止疫情进一步扩散，有关部门断然采取了严格的封闭隔离措施。",
          "pinyin": "Wèile fángzhǐ yìqíng jìnyíbù kuòsàn, yǒuguān bùmén duànrán cǎiqǔ le yángé de fēngbì gélí cuòshī.",
          "translation_vi": "Để ngăn ngừa dịch bệnh lây lan thêm, các ban ngành hữu quan đã kiên quyết áp dụng các biện pháp phong tỏa cách ly nghiêm ngặt.",
          "explanation": "\"断然采取...措施\" biểu thị hành động quyết đoán nhanh gọn vì an toàn cộng đồng."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 21,
      "name": "Phó từ phủ định hoàn toàn triệt để \"毫不\" (Mảy may không / Không chút nào)",
      "pattern": "毫不 + Động từ/Tính từ (犹豫 / 畏惧 / 客气 / 掩饰 / 动摇 / 逊色)",
      "category": "Phó từ",
      "explanation_vi": "\"毫不\" (háobù) tương đương với \"一点儿也不\", biểu thị mức độ phủ định triệt để (không một chút nào, mảy may không). Thường kết hợp với các động từ tâm lý hoặc phẩm chất đạo đức để tạo thành các cụm từ bốn chữ cao cấp như 毫不犹豫 (không chút do dự), 毫不客气 (chẳng chút khách sáo), 毫不畏惧 (không hề sợ hãi).",
      "examples": [
        {
          "chinese": "当看到落水儿童命悬一线时，那位热心青年毫不犹豫地跳入冰冷的江水中救人。",
          "pinyin": "Dāng kàndào luòshuǐ értóng mìngxuányíxiàn shí, nà wèi rèxīn qīngnián háobù yóuyù de tiàorù bīnglěng de jiāngshuǐ zhōng jiùrén.",
          "translation_vi": "Khi nhìn thấy đứa trẻ rơi xuống nước ngàn cân treo sợi tóc, chàng thanh niên nhiệt huyết đã không chút do dự lao mình xuống dòng sông băng giá cứu người.",
          "explanation": "\"毫不犹豫地跳入...\" ca ngợi hành động dũng cảm cứu người bất chấp hiểm nguy tức thời."
        },
        {
          "chinese": "在这场激烈的辩论赛中，新组建的校队表现得毫不逊色于卫冕冠军。",
          "pinyin": "Zài zhè chǎng jīliè de biànlùnsài zhōng, xīn zǔjiàn de xiàoduì biǎoxiàn de háobù xùnsè yú wèimiǎn guànjūn.",
          "translation_vi": "Trong trận thi đấu tranh biện gay cấn này, đội tuyển trường mới thành lập đã thể hiện mảy may không hề thua kém nhà đương kim vô địch.",
          "explanation": "\"毫不逊色\" là cách nói văn học khẳng định năng lực xuất sắc ngang ngửa với đối thủ hàng đầu."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 22,
      "name": "Phó từ chỉ mức độ đỉnh điểm trang trọng \"极为\" (Cực kỳ / Hết sức / Vô cùng)",
      "pattern": "极为 + Tính từ song âm tiết / Động từ tâm lý (重要 / 复杂 / 丰富 / 关注 / 遗憾)",
      "category": "Phó từ",
      "explanation_vi": "\"极为\" (jíwéi) là phó từ chỉ mức độ cao cấp trong văn viết và chính luận, tương đương với \"非常\" hoặc \"极其\", nhưng mang sắc thái học thuật và văn phong trang nhã hơn. \"极为\" thường đi liền với tính từ song âm tiết miêu tả tính chất quan trọng, khó khăn hoặc tâm trạng sâu sắc.",
      "examples": [
        {
          "chinese": "深海探测所获得的第一手地质样本，对地球演化研究具有极为重要的学术价值。",
          "pinyin": "Shēnhǎi tàncè suǒ huòdé de dìyīshǒu dìzhì yàngběn, duì dìqiú yǎnhuà yánjiū jùyǒu jíwéi zhòngyào de xuéshù jiàzhí.",
          "translation_vi": "Mẫu vật địa chất đầu tay thu được từ việc thăm dò biển sâu có giá trị học thuật cực kỳ quan trọng đối với nghiên cứu sự tiến hóa của Trái Đất.",
          "explanation": "\"极为重要的学术价值\" dùng \"极为\" nhấn mạnh ý nghĩa khoa học đột phá của phát hiện."
        },
        {
          "chinese": "在如此极为恶劣的自然条件下，科考队员们依然坚韧不拔地完成了观测任务。",
          "pinyin": "Zài rúcǐ jíwéi èliè de zìrán tiáojiàn xià, kēkǎo duìyuánmen yīrán jiānrènbùbá de wánchéng le guāncè rènwu.",
          "translation_vi": "Dưới điều kiện tự nhiên khắc nghiệt cùng cực như vậy, các thành viên đội khảo sát khoa học vẫn kiên cường hoàn thành nhiệm vụ quan trắc.",
          "explanation": "\"极为恶劣\" cực tả mức độ hiểm trở và nguy hiểm của khí hậu vùng cực."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 23,
      "name": "Phó từ phán đoán không chắc chắn \"未必\" (Chưa hẳn / Chưa chắc)",
      "pattern": "Chủ ngữ + 未必 + (是/能/会/有) + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"未必\" (wèibì) là phó từ phủ định bán phần tương đương với \"不一定\" (chưa chắc, chưa hẳn). Dùng để phủ định sự võ đoán hoặc một định kiến chủ quan, nhắc nhở người nghe cần xem xét sự việc dưới góc nhìn đa chiều, khách quan hơn.",
      "examples": [
        {
          "chinese": "最昂贵的商品未必就是品质最好的，适合自己的才是最理想的。",
          "pinyin": "Zuì ángguì de shāngpǐn wèibì jiù shì pǐnzhì zuì hǎo de, shìhé zìjǐ de cái shì zuì lǐxiǎng de.",
          "translation_vi": "Mặt hàng đắt tiền nhất chưa hẳn đã là mặt hàng có chất lượng tốt nhất, cái phù hợp với bản thân mới là lý tưởng nhất.",
          "explanation": "\"未必就是...\" phủ định quan niệm sai lầm đồng nhất giá tiền đắt đỏ với chất lượng hàng hóa."
        },
        {
          "chinese": "凭借一次考试的偶然失利，未必就能说明他在这个学科上缺乏天赋。",
          "pinyin": "Píngjiè yí cì kǎoshì de ǒurán shīlì, wèibì jiù néng shuōmíng tā zài zhè ge xuékē shang quēfá tiānfù.",
          "translation_vi": "Dựa vào một lần trượt kỳ thi ngẫu nhiên, chưa chắc đã có thể chứng minh cậu ấy thiếu năng khiếu ở môn học này.",
          "explanation": "\"未必就能说明...\" khuyên nhủ không nên đánh giá tiềm năng cả đời của học sinh qua một thất bại ngắn hạn."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 24,
      "name": "Phó từ chỉ kết quả tâm lý tự nhiên tất yếu \"不免\" (Không khỏi / Khó tránh)",
      "pattern": "Chủ ngữ + 不免 + (会/有点儿) + Động từ tâm lý / Tính từ",
      "category": "Phó từ",
      "explanation_vi": "\"不免\" (bùmiǎn) dùng để diễn tả một cảm xúc, tâm trạng hoặc phản ứng tâm lý nảy sinh một cách hoàn toàn tự nhiên, khó lòng kiềm chế được trước một bối cảnh hay sự kiện cụ thể (không khỏi, khó lòng tránh được cảm giác đó). Thường đi với các từ chỉ cảm xúc như 担心, 难过, 遗憾, 紧张, 兴奋.",
      "examples": [
        {
          "chinese": "第一次站在上千人的讲台上公开发言，他心里不免感到有些紧张。",
          "pinyin": "Dì yī cì zhàn zài shàngqiān rén de jiǎngtái shang gōngkāi fāyán, tā xīnlǐ bùmiǎn gǎndào yǒuxiē jǐnzhāng.",
          "translation_vi": "Lần đầu tiên đứng trên bục giảng trước hàng nghìn người phát biểu công khai, trong lòng anh ấy không khỏi cảm thấy có đôi chút hồi hộp.",
          "explanation": "\"不免感到有些紧张\" diễn tả tâm lý lo lắng hồi hộp rất con người khi đứng trước đám đông."
        },
        {
          "chinese": "看着老同学各奔前程的背影，离别之际大家心中不免涌起丝丝伤感。",
          "pinyin": "Kànzhe lǎotóngxué gèbènqiánchéng de bèiyǐng, líbié zhījì dàjiā xīnzhōng bùmiǎn yǒngqǐ sīsī shānggǎn.",
          "translation_vi": "Nhìn bóng lưng bạn học cũ mỗi người một ngả vì tương lai, giờ phút chia tay trong lòng mọi người không khỏi dâng lên niềm ngậm ngùi.",
          "explanation": "\"不免涌起丝丝伤感\" miêu tả cảm xúc xúc động bùi ngùi tất yếu lúc tốt nghiệp chia tay."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 25,
      "name": "Phó từ & Tính từ chỉ quy luật khách quan khó tránh \"难免\" (Khó tránh khỏi / Tất yếu xảy ra)",
      "pattern": "难免 + 会 + Kết quả bất lợi / Làm việc gì đó, 难免 + Thiếu sót",
      "category": "Phó từ",
      "explanation_vi": "\"难免\" (nánmiǎn) vừa là phó từ vừa là tính từ, biểu thị một hiện tượng hoặc kết quả tiêu cực/sai sót là khó lòng tránh khỏi do sự hạn chế của quy luật khách quan hoặc điều kiện thực tế (khó tránh, khó lòng tránh khỏi). Khác với \"不免\" (thiên về cảm xúc tâm lý), \"难免\" thiên về sai sót, va chạm hoặc sơ suất trong hành vi.",
      "examples": [
        {
          "chinese": "初学者在探索新领域时，难免会走一些弯路和犯一些小错误。",
          "pinyin": "Chūxuézhě zài tànsuǒ xīn lǐngyù shí, nánmiǎn huì zǒu yìxiē wānlù hé fàn yìxiē xiǎo cuòwù.",
          "translation_vi": "Người mới bắt đầu học khi tìm tòi khám phá lĩnh vực mới, khó tránh khỏi sẽ đi đường vòng và phạm phải một vài sai lầm nhỏ.",
          "explanation": "\"难免会走弯路\" cảm thông với quy luật vấp ngã tất yếu trong quá trình tích lũy học tập."
        },
        {
          "chinese": "一家人朝夕相处生活在同一个屋檐下，摩擦和矛盾是难免的。",
          "pinyin": "Yì jiā rén zhāoxīxiāngchǔ shēnghuó zài tóng yí gè wūyán xià, mócā hé máodùn shì nánmiǎn de.",
          "translation_vi": "Cả gia đình sớm tối bên nhau sống chung dưới một mái nhà, va chạm và mâu thuẫn là điều khó tránh khỏi.",
          "explanation": "\"是难免的\" dùng làm vị ngữ tính từ khẳng định va chạm đời sống là điều tất nhiên."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 26,
      "name": "Phó từ suýt chút nữa gặp nạn \"险些\" (Suýt nữa / Suýt chút nữa)",
      "pattern": "Chủ ngữ + 险些 + (就) + Kết quả xấu / 险些 + Gặp nguy hiểm",
      "category": "Phó từ",
      "explanation_vi": "\"险些\" (xiǎnxiē) là phó từ cao cấp tương đương với \"差点儿\", biểu thị một tình huống nguy hiểm hoặc kết quả xấu suýt nữa đã xảy ra, nhưng nhờ may mắn hoặc xử lý kịp thời mà thực tế đã không xảy ra (suýt nữa thì, suýt chút nữa). Thường dùng trong văn viết hoặc văn phong kể chuyện kịch tính.",
      "examples": [
        {
          "chinese": "由于地面结了厚厚一层暗冰，他脚下一滑，险些从台阶上摔了下去。",
          "pinyin": "Yóuyú dìmiàn jié le hòuhòu yì céng ànbīng, tā jiǎoxià yì huá, xiǎnxiē cóng táijiē shang shuāi le xiàqu.",
          "translation_vi": "Do mặt đất đóng một lớp băng trơn mỏng, chân anh ấy trượt một cái, suýt nữa thì ngã nhào từ trên bậc thang xuống.",
          "explanation": "\"险些...摔了下去\" miêu tả cú trượt chân nguy hiểm suýt gây thương tích nhưng may mắn gượng lại kịp."
        },
        {
          "chinese": "大货车紧急变道避让，客车司机反应敏捷，险些酿成一场连环追尾惨剧。",
          "pinyin": "Dà huòchē jǐnjí biàndào bìràng, kèchē sījī fǎnyìng mǐnjié, xiǎnxiē niàngchéng yì chǎng liánhuán zhuīwěi cǎnjù.",
          "translation_vi": "Xe tải lớn đột ngột đổi làn né tránh, tài xế xe khách phản xạ nhanh nhạy, suýt chút nữa đã gây ra một thảm kịch đâm dồn đuôi xe liên hoàn.",
          "explanation": "\"险些酿成...惨剧\" nhấn mạnh sự may mắn nhờ tay lái chuẩn xác tránh được tai nạn giao thông thảm khốc."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 27,
      "name": "Liên từ/Phó từ tương phản đối lập \"反之\" (Ngược lại / Trái lại)",
      "pattern": "Mệnh đề thuận (nếu A thì B); 反之, Mệnh đề nghịch (nếu không A thì không B)",
      "category": "Phó từ",
      "explanation_vi": "\"反之\" (fǎnzhī) là liên từ hoặc phó từ trang trọng trong văn viết nghị luận triết học, logic và pháp lý, mang nghĩa \"nếu xét theo chiều hướng ngược lại thì...\". Dùng để đối chiếu hai mặt thuận và nghịch của một quy luật hoặc giả thiết nhân quả.",
      "examples": [
        {
          "chinese": "坚持规律的作息有助于增强免疫力；反之，长期熬夜则会严重损害身体健康。",
          "pinyin": "Jiānchí guīlǜ de zuòxī yǒuzhùyú zēngqiáng miǎnyìlì; fǎnzhī, chángqī áoyè zé huì yánzhòng sǔnhài shēntǐ jiànkāng.",
          "translation_vi": "Kiên trì sinh hoạt điều độ góp phần tăng cường sức miễn dịch; ngược lại, thức đêm kéo dài sẽ hủy hoại nghiêm trọng sức khỏe thân thể.",
          "explanation": "\"反之\" đứng đầu vế sau để đối chiếu hậu quả tiêu cực của việc thức khuya so với lối sống lành mạnh."
        },
        {
          "chinese": "企业尊重员工的创造力就能激发无限潜能；反之，僵化的管理只会压抑人才的积极性。",
          "pinyin": "Qǐyè zūnzhòng yuángōng de chuàngzàolì jiù néng jīfā wúxiàn qiánnéng; fǎnzhī, jiānghuà de guǎnlǐ zhǐ huì yāyì réncái de jījíxìng.",
          "translation_vi": "Doanh nghiệp tôn trọng sức sáng tạo của nhân viên sẽ khơi dậy tiềm năng vô hạn; ngược lại, cách quản lý xơ cứng chỉ kìm hãm tính tích cực của nhân tài.",
          "explanation": "\"反之\" lập luận sắc sảo về hai phong cách quản trị doanh nghiệp đối nghịch nhau."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 28,
      "name": "Phó từ tần suất cao lặp đi lặp lại \"屡次\" (Nhiều lần / Năm lần bảy lượt)",
      "pattern": "Chủ ngữ + 屡次 + Động từ (犯错 / 获奖 / 警告 / 试验 / 申明)",
      "category": "Phó từ",
      "explanation_vi": "\"屡次\" (lǚcì) là phó từ cao cấp biểu thị một hành động hoặc sự việc diễn ra nhiều lần, lặp đi lặp lại (năm lần bảy lượt, lặp lại nhiều đợt). Thường dùng trong văn viết chính thức, có thể dùng cho sự thành công liên tục (屡次获奖) hoặc hành vi tái phạm lỗi cần phê phán (屡次违规).",
      "examples": [
        {
          "chinese": "该科研团队在极端恶劣的环境下屡次攻克难关，屡次荣获国家科技进步特等奖。",
          "pinyin": "Gāi kēyán tuánduì zài jíduān èliè de huánjìng xià lǚcì gōngkè nánguān, lǚcì rónghuò guójiā kējì jìnbù tèděngjiǎng.",
          "translation_vi": "Nhóm nghiên cứu khoa học này dưới môi trường cực kỳ khắc nghiệt đã nhiều lần vượt qua khó khăn, nhiều lần vinh dự nhận giải đặc biệt Tiến bộ Khoa học Kỹ thuật Quốc gia.",
          "explanation": "\"屡次攻克难关\" tôn vinh sự bền bỉ gặt hái thành tựu lặp lại qua nhiều năm tháng."
        },
        {
          "chinese": "尽管学校老师已经屡次三番进行提醒，他依然未能改正上课迟到的坏毛病。",
          "pinyin": "Jǐnguǎn xuéxiào lǎoshī yǐjīng lǚcìsānfān jìnxíng tíxǐng, tā yīrán wèinéng gǎizhèng shàngkè chídào de huài máobìng.",
          "translation_vi": "Mặc dù thầy cô trong trường đã năm lần bảy lượt nhắc nhở, anh ta vẫn chưa thể sửa được tật xấu đi học muộn.",
          "explanation": "\"屡次三番\" là quán dụng ngữ nhấn mạnh sự cảnh báo lặp đi lặp lại nhiều lần đối với lỗi vi phạm."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 29,
      "name": "Phó từ quy chuẩn bình đẳng tuyệt đối \"一律\" (Nhất loạt / Tất cả như nhau)",
      "pattern": "Chủ ngữ (số nhiều/phạm vi) + 一律 + Động từ / Tính từ",
      "category": "Phó từ",
      "explanation_vi": "\"一律\" (yílǜ) là phó từ mang tính quy phạm pháp lý và thể chế cao cấp, biểu thị toàn bộ mọi đối tượng, trường hợp trong phạm vi quy định đều được đối xử hoặc thực hiện hoàn toàn giống nhau, tuyệt đối không có bất kỳ ngoại lệ hay sự phân biệt nào (nhất loạt, đều như nhau). Thường dùng trong các thông báo, nội quy, nghị định chính thức.",
      "examples": [
        {
          "chinese": "根据考场纪律，所有考生的电子通信设备一律关机并统一存放。",
          "pinyin": "Gēnjù kǎochǎng jìlǜ, suǒyǒu kǎoshēng de diànzǐ tōngxìn shèbèi yílǜ guānjī bìng tǒngyī cúnfàng.",
          "translation_vi": "Căn cứ theo kỷ luật phòng thi, thiết bị thông tin điện tử của tất cả thí sinh nhất loạt phải tắt nguồn và nộp lưu giữ tập trung.",
          "explanation": "\"一律关机\" thể hiện tính nghiêm minh không có bất kỳ ngoại lệ nào trong quy chế phòng thi."
        },
        {
          "chinese": "本商场在周年庆期间，全场商品一律享受八五折优惠。",
          "pinyin": "Běn shāngchǎng zài zhōuniánqìng qījiān, quán chǎng shāngpǐn yílǜ xiǎngshòu bāwǔzhé yōuhuì.",
          "translation_vi": "Trung tâm thương mại này trong thời gian đại lễ kỷ niệm, toàn bộ hàng hóa nhất loạt được hưởng ưu đãi giảm giá 15%.",
          "explanation": "\"一律享受...\" áp dụng mức ưu đãi bình đẳng đồng loạt cho mọi sản phẩm."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 30,
      "name": "Phó từ bao quát triệt để không sót \"统统\" (Toàn bộ / Tuốt tuột / Tất thảy)",
      "pattern": "Chủ ngữ / Tân ngữ đảo + 统统 + Động từ (扔掉 / 交出来 / 忘记)",
      "category": "Phó từ",
      "explanation_vi": "\"统统\" (tǒngtǒng) là phó từ tương đương với \"全都\" (tất cả, toàn bộ), nhưng mang sắc thái dứt khoát, triệt để và sinh động hơn, biểu thị không chừa lại một cá thể hay đồ vật nào (toàn bộ, tuốt tuột). Thường dùng khi thu dọn đồ đạc, giao nộp hoặc gạt bỏ cảm xúc.",
      "examples": [
        {
          "chinese": "搬家前夕，他把那些积累多年的旧报纸和破箱子统统扔掉了。",
          "pinyin": "Bānjiā qiánxī, tā bǎ nàxiē jīlěi duō nián de jiù bàozhǐ hé pò xiāngzi tǒngtǒng rēngdiào le.",
          "translation_vi": "Vào đêm trước ngày chuyển nhà, anh ấy đã vứt tuốt tuột đống báo cũ và thùng giấy hỏng tích tụ nhiều năm.",
          "explanation": "\"统统扔掉\" diễn tả hành động dọn dẹp sạch sẽ dứt khoát không giữ lại thứ gì."
        },
        {
          "chinese": "经过一个星期的封闭集训，学员们统统掌握了急救的基本操作规范。",
          "pinyin": "Jīngguò yí gè xīngqī de fēngbì jíxùn, xuéyuánmen tǒngtǒng zhǎowò le jíjiù de jīběn cāozuò guīfàn.",
          "translation_vi": "Sau một tuần huấn luyện tập trung khép kín, các học viên đều nắm vững toàn bộ quy chuẩn thao tác sơ cứu cơ bản.",
          "explanation": "\"统统掌握了\" biểu thị 100% học viên đều đạt tiêu chuẩn đầu ra huấn luyện y tế."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 31,
      "name": "Phó từ hoãn binh tạm thời \"暂且\" (Tạm thời / Trước mắt cứ gác lại)",
      "pattern": "Chủ ngữ + 暂且 + Động từ + (不/放/搁/等) / 暂且不论",
      "category": "Phó từ",
      "explanation_vi": "\"暂且\" (zànqiě) là phó từ văn viết trang trọng tương đương với \"姑且\" hoặc \"暂时\", mang ý nghĩa hoãn lại một sự việc, hành động để tập trung giải quyết vấn đề cấp bách hơn trước mắt (tạm thời cứ thế, trước mắt tạm gác sang một bên). Cụm từ cố định kinh điển: \"暂且不论\" (tạm thời chưa bàn tới khía cạnh này).",
      "examples": [
        {
          "chinese": "这笔资金的后续来源暂且不论，眼下当务之急是先把工程材料采购到位。",
          "pinyin": "Zhè bǐ zījīn de hòuxù láiyuán zànqiě búlùn, yǎnxià dāngwùzhījí shì xiān bǎ gōngchéng cáiliào cǎigòu dàowèi.",
          "translation_vi": "Nguồn gốc tiếp theo của khoản vốn này tạm thời chưa bàn tới, nhiệm vụ cấp bách trước mắt là phải mua sắm đầy đủ vật liệu công trình trước.",
          "explanation": "\"暂且不论\" phân định rõ việc nào nên gác lại để ưu tiên việc sống còn trước mắt."
        },
        {
          "chinese": "天色已经很晚了，关于这个方案的分歧我们暂且搁置，明天再作定夺。",
          "pinyin": "Tiānsè yǐjīng hěn wǎn le, guānyú zhè ge fāng'àn de fēnqí wǒmen zànqiě gēzhì, míngtiān zài zuò dìngduó.",
          "translation_vi": "Trời đã rất muộn rồi, về những bất đồng của phương án này chúng ta tạm thời gác lại, ngày mai hãy đưa ra quyết định cuối cùng.",
          "explanation": "\"暂且搁置\" biểu thị quyết định thông minh tạm hoãn tranh luận để nghỉ ngơi hồi phục trí lực."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 32,
      "name": "Phó từ chấp nhận giả định tạm thời \"姑且\" (Tạm thời coi như / Hãy cứ)",
      "pattern": "姑且 + Động từ (相信 / 试一试 / 承认 / 听之 / 算作)",
      "category": "Phó từ",
      "explanation_vi": "\"姑且\" (gūqiě) mang ý nghĩa người nói dù chưa hoàn toàn tin tưởng hoặc chưa chắc chắn 100%, nhưng trong hoàn cảnh hiện tại sẵn sàng tạm thời chấp nhận, thử nghiệm hoặc nhượng bộ một bước để quan sát diễn biến tiếp theo (hãy cứ coi như, tạm thời hãy thử xem sao).",
      "examples": [
        {
          "chinese": "虽然他的理由听起来有些牵强，但我们姑且相信他一次，给他一个机会。",
          "pinyin": "Suīrán tā de lǐyóu tīng qǐlai yǒuxiē qiānqiǎng, dàn wǒmen gūqiě xiāngxìn tā yí cì, gěi tā yí gè jīhuì.",
          "translation_vi": "Tuy rằng lý do của anh ta nghe chừng có phần gượng gạo, nhưng chúng ta hãy cứ tạm tin anh ta một lần, cho anh ta một cơ hội.",
          "explanation": "\"姑且相信他一次\" thể hiện sự bao dung thử thách lòng tin dù đối phương đưa ra lý do chưa thuyết phục."
        },
        {
          "chinese": "这个新颖的设计思路虽然还不成熟，我们姑且可以在实验室里小规模测试一下。",
          "pinyin": "Zhè ge xīnyǐng de shèjì sīlù suīrán hái bù chéngshú, wǒmen gūqiě kěyǐ zài shíyànshì lǐ xiǎoguīmó cèshì yíxià.",
          "translation_vi": "Ý tưởng thiết kế mới mẻ này tuy rằng chưa hoàn thiện, chúng ta hãy cứ thử nghiệm quy mô nhỏ trong phòng thí nghiệm xem sao.",
          "explanation": "\"姑且可以在...测试\" biểu thị thái độ cởi mở chấp nhận thử nghiệm ý tưởng khoa học mới."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 33,
      "name": "Phó từ dấn thân quả cảm không màng gian khổ \"毅然\" (Kiên quyết / Quả quyết / Dứt khoát dấn thân)",
      "pattern": "Chủ ngữ + 毅然 + Động từ (放弃 / 决定 / 投身 / 踏上 / 回国)",
      "category": "Phó từ",
      "explanation_vi": "\"毅然\" (yìrán) miêu tả một quyết định dũng cảm, dứt khoát dấn thân làm một việc lớn lao hoặc từ bỏ điều kiện êm ấm để hy sinh vì lý tưởng, nghĩa vụ hoặc quốc gia (kiên quyết, dũng cảm quyết định). Thường dùng trong các văn cảnh ca ngợi nhân cách cao đẹp như 毅然回国 (kiên quyết về nước), 毅然投身 (quả quyết dấn thân).",
      "examples": [
        {
          "chinese": "完成学业后，他毅然放弃了国外优厚的生活待遇，回国投身西部乡村教育。",
          "pinyin": "Wánchéng xuéyè hòu, tā yìrán fàngqì le guówài yōuhòu de shēnghuó dàiyù, huíguó tóushēn xībù xiāngcūn jiàoyù.",
          "translation_vi": "Sau khi hoàn thành chương trình học, anh ấy đã kiên quyết từ bỏ chế độ đãi ngộ hậu hĩnh ở nước ngoài, trở về nước dấn thân vào sự nghiệp giáo dục nông thôn miền Tây.",
          "explanation": "\"毅然放弃...回国投身...\" tôn vinh lý tưởng cống hiến quên mình của người trí thức trẻ."
        },
        {
          "chinese": "在国家最危难的历史时刻，无数热血青年毅然奔赴抗战前线。",
          "pinyin": "Zài guójiā zuì wēinàn de lìshǐ shíkè, wúshù rèxiè qīngnián yìrán bēnfù kàngzhàn qiánxiàn.",
          "translation_vi": "Vào thời khắc lịch sử nguy nan nhất của đất nước, vô số thanh niên nhiệt huyết đã quả quyết xông pha ra tiền tuyến kháng chiến.",
          "explanation": "\"毅然奔赴前线\" khắc họa ý chí kiên cường xả thân cứu nước của cả một thế hệ."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 34,
      "name": "Phó từ sực tỉnh hoặc chuyển biến bất ngờ \"猛然\" (Đột nhiên / Sực tỉnh / Giật mình)",
      "pattern": "Chủ ngữ + 猛然 + Động từ (醒悟 / 发现 / 意识到 / 回过头 / 站起来)",
      "category": "Phó từ",
      "explanation_vi": "\"猛然\" (měngrán) biểu thị hành động hoặc hoạt động nhận thức biến đổi đột ngột với cường độ mạnh mẽ, bất ngờ trong một khoảnh khắc rất ngắn (sực nhớ ra, bừng tỉnh, giật mình thảng thốt). Khác với \"突然\", \"猛然\" nhấn mạnh sự đột ngột của cú sốc tinh thần hoặc sự sực nhận ra chân tướng.",
      "examples": [
        {
          "chinese": "听到远处传来的急刹车声，他猛然停下脚步并机警地回头看去。",
          "pinyin": "Tīngdào yuǎnchù chuánlái de jíshāchē shēng, tā měngrán tíngxià jiǎobù bìng jījǐng de huítóu kàn qù.",
          "translation_vi": "Nghe thấy tiếng phanh xe gấp từ đằng xa vọng lại, anh ấy giật mình dừng phắt bước chân và cảnh giác quay đầu nhìn lại.",
          "explanation": "\"猛然停下脚步\" miêu tả phản ứng dừng lại đột ngột trước âm thanh nguy hiểm."
        },
        {
          "chinese": "直到翻出泛黄的旧相册，他才猛然意识到岁月已经悄悄溜走了三十年。",
          "pinyin": "Zhídào fānchū fànhuáng de jiù xiàngcè, tā cái měngrán yìshídào suìyuè yǐjīng qiāoqiāo liūzǒu le sānshí nián.",
          "translation_vi": "Mãi tới khi lật giở cuốn album ảnh cũ ngả vàng, ông ấy mới sực nhận ra năm tháng đã lặng lẽ trôi qua 30 năm ròng.",
          "explanation": "\"猛然意识到\" diễn tả cảm xúc thảng thốt bừng ngộ về sự trôi chảy của thời gian."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 35,
      "name": "Phó từ quy luật tất yếu không thể đảo ngược \"势必\" (Ắt hẳn / Thế tất / Chắc chắn sẽ)",
      "pattern": "Hành động hiện tại sai lầm/thiếu sót, 势必 + 会 + Hậu quả xấu tất yếu",
      "category": "Phó từ",
      "explanation_vi": "\"势必\" (shìbì) là phó từ cao cấp kết hợp chữ \"势\" (thế thế, xu thế) và \"必\" (ắt, nhất định), mang nghĩa \"dựa theo xu thế phát triển khách quan thì chắc chắn tất yếu sẽ dẫn tới một hệ quả nghiêm trọng nào đó\" (thế tất, ắt hẳn). Thường dùng trong phân tích chiến lược, cảnh báo chính sách.",
      "examples": [
        {
          "chinese": "如果不加节制地过度开采地下水资源，势必会引发严重的地面沉降危机。",
          "pinyin": "Rúguǒ bù jiā jiézhì de guòdù kāicǎi dìxiàshuǐ zīyuán, shìbì huì yǐnfā yánzhòng de dìmiàn chénjiàng wēijī.",
          "translation_vi": "Nếu khai thác nước ngầm quá mức không kiêng dè, ắt hẳn sẽ châm ngòi cho cuộc khủng hoảng sụt lún mặt đất nghiêm trọng.",
          "explanation": "\"势必会引发...\" cảnh báo hệ lụy môi trường tất yếu không thể tránh khỏi nếu hủy hoại tài nguyên."
        },
        {
          "chinese": "单方面撕毁国际贸易协定，势必会遭到国际社会的广泛谴责与反制。",
          "pinyin": "Dān fāngmiàn sīhuǐ guójì màoyì xiédìng, shìbì huì zāodào guójì shèhuì de guǎngfàn qiǎnzé yǔ fǎnzhì.",
          "translation_vi": "Đơn phương xé bỏ hiệp định thương mại quốc tế, thế tất sẽ gặp phải sự lên án và trả đũa rộng rãi của cộng đồng quốc tế.",
          "explanation": "\"势必会遭到...\" dự báo kết cục ngoại giao tất yếu của hành vi vi phạm thỏa ước."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 36,
      "name": "Phó từ phản vấn phủ định lịch sử \"何尝\" (Nào có / Đâu phải là không / Từng bao giờ)",
      "pattern": "何尝 + Phủ định (不想 / 不是 / 不知道) / 何尝 + Khẳng định + 呢",
      "category": "Phó từ",
      "explanation_vi": "\"何尝\" (hécháng) dùng trong câu hỏi tu từ để biểu thị sự thanh minh hoặc khẳng định gián tiếp: 1) \"何尝不...\" (nào có phải là không) mang ý nghĩa khẳng định mãnh liệt nhưng bất lực (thực tế rất muốn, rất hiểu, nhưng hoàn cảnh trói buộc); 2) \"何尝...呢\" mang nghĩa phủ định (nào đã từng như vậy bao giờ).",
      "examples": [
        {
          "chinese": "面对年迈生病的父母，身在异乡打拼的他何尝不想早点儿回家陪伴呢？",
          "pinyin": "Miànduì niánmài shēngbìng de fùmǔ, shēn zài yìxiāng dǎpīn de tā hécháng bù xiǎng zǎodiǎnr huíjiā péibàn ne?",
          "translation_vi": "Đối mặt với cha mẹ già yếu ốm đau, người con đang bươn chải nơi đất khách quê người như anh ấy nào có phải không muốn sớm về nhà bầu bạn cơ chứ?",
          "explanation": "\"何尝不想...呢\" bộc lộ nỗi lòng xót xa của người con xa xứ: thực lòng vô cùng muốn về nhưng bất khả kháng."
        },
        {
          "chinese": "在漫长的创业征程中，我们何尝经历过如此严峻的资金断裂危机？",
          "pinyin": "Zài màncháng de chuàngyè zhēngchéng zhōng, wǒmen hécháng jīnglìguo rúcǐ yánjùn de zījīn duànliè wēijī?",
          "translation_vi": "Trong chặng đường khởi nghiệp dài đằng đẵng, chúng tôi nào đã từng trải qua cuộc khủng hoảng đứt gãy dòng tiền ngặt nghèo đến nhường này?",
          "explanation": "\"何尝经历过\" dùng câu hỏi tu từ khẳng định đây là lần đầu tiên công ty gặp thử thách khốc liệt chưa từng có."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 37,
      "name": "Phó từ khẳng định uyển chuyển khiêm nhường \"未尝\" (Chưa từng / Vị tất không phải là)",
      "pattern": "未尝 + Phủ định (不可 / 不是 / 没有) / 未尝 + Động từ",
      "category": "Phó từ",
      "explanation_vi": "\"未尝\" (wèicháng) là phó từ văn ngôn cao cấp mang nghĩa \"chưa từng\" (kết hợp 未: chưa, 尝: từng). Khi kết hợp ở dạng phủ định kép như \"未尝不可\" (chưa hẳn là không được / cũng có thể chấp nhận), nó biểu đạt một ý kiến nhượng bộ, đồng tình một cách thận trọng, lịch thiệp và sâu sắc.",
      "examples": [
        {
          "chinese": "如果传统模式走不通，换一个全新的跨界视角未尝不是一种积极的尝试。",
          "pinyin": "Rúguǒ chuántǒng móshì zǒu bù tōng, huàn yí gè quánxīn de kuàjiè shìjiǎo wèicháng bú shì yì zhǒng jījí de chángshì.",
          "translation_vi": "Nếu mô hình truyền thống đi vào bế tắc, đổi sang một góc nhìn xuyên ngành hoàn toàn mới vị tất không phải là một sự thử nghiệm tích cực.",
          "explanation": "\"未尝不是...\" là cấu trúc phủ định kép nhã nhặn khẳng định đổi mới sáng tạo là hướng đi đúng đắn."
        },
        {
          "chinese": "对于年轻人的大胆构想，在严格控制风险的前提下，让他们放手一试也未尝不可。",
          "pinyin": "Duìyú niánqīngrén de dàdǎn gòuxiǎng, zài yángé kòngzhì fēngxiǎn de qiántí xià, ràng tāmen fàngshǒu yí shì yě wèicháng bùkě.",
          "translation_vi": "Đối với ý tưởng táo bạo của người trẻ, dưới tiền đề kiểm soát rủi ro chặt chẽ, để họ tự do thử sức cũng chẳng phải là không được.",
          "explanation": "\"未尝不可\" thể hiện sự cởi mở, đồng ý cho cấp dưới thử nghiệm cơ hội mới."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 38,
      "name": "Phó từ chỉ sự giới hạn duy nhất \"无非\" (Chẳng qua là / Không ngoài)",
      "pattern": "Chủ ngữ + 无非是 + Danh từ/Mệnh đề / 无非 + Động từ (想/为了)",
      "category": "Phó từ",
      "explanation_vi": "\"无非\" (wúfēi) tương đương với \"不过是\" hoặc \"只是\", mang nghĩa \"chẳng qua chỉ là, không ngoài mục đích gì khác\". Thường dùng để chỉ rõ bản chất đơn giản của một hiện tượng tưởng chừng phức tạp, hoặc hạ thấp tính chất nghiêm trọng của vấn đề.",
      "examples": [
        {
          "chinese": "他之所以整天拼命工作加班，无非是想为家人创造一个更好的生活条件。",
          "pinyin": "Tā zhīsuǒyǐ zhěngtiān pīnmìng gōngzuò jiābān, wúfēi shì xiǎng wèi jiārén chuàngzào yí gè gèng hǎo de shēnghuó tiáojiàn.",
          "translation_vi": "Sở dĩ anh ấy suốt ngày làm việc tăng ca bán mạng, chẳng qua cũng chỉ là muốn tạo dựng cho gia đình một điều kiện sống tốt hơn.",
          "explanation": "\"无非是想...\" giải thích động cơ giản dị và nhân văn đằng sau sự vất vả của người trụ cột gia đình."
        },
        {
          "chinese": "商家炒作这些花哨的概念，无非是为了吸引年轻消费者的眼球从而增加销量。",
          "pinyin": "Shāngjiā chǎozuò zhèxiē huāshào de gàiniàn, wúfēi shì wèile xīyǐn niánqīng xiāofèizhě de yǎnqiú cóng'ér zēngjiā xiàoliàng.",
          "translation_vi": "Thương gia thổi phồng những khái niệm hào nhoáng này, chẳng qua cũng chỉ là nhằm thu hút sự chú ý của người tiêu dùng trẻ để tăng doanh số.",
          "explanation": "\"无非是为了...\" bóc trần mục đích thương mại thuần túy đằng sau chiêu trò quảng cáo."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 39,
      "name": "Phó từ hành động thẳng mạch không vòng vo \"径直\" (Đi thẳng / Thẳng một mạch)",
      "pattern": "Chủ ngữ + 径直 + Động từ di chuyển/Hành động (走 / 走向 / 穿过 / 离开)",
      "category": "Phó từ",
      "explanation_vi": "\"径直\" (jìngzhí) biểu thị việc di chuyển thẳng tắp tới một đích đến xác định mà không dừng lại, không rẽ ngang rẽ tắt dọc đường; hoặc biểu thị tiến hành ngay một việc mà không cần trải qua các thủ tục trung gian rườm rà (thẳng một mạch, đi thẳng tới).",
      "examples": [
        {
          "chinese": "走进办公大楼后，他没有在接待处停留，而是径直朝董事长的办公室走去。",
          "pinyin": "Zǒujìn bàngōng dàlóu hòu, tā méiyǒu zài jiēdàichù tíngliú, érshì jìngzhí cháo dǒngshìzhǎng de bàngōngshì zǒu qù.",
          "translation_vi": "Sau khi bước vào tòa nhà văn phòng, anh ấy không dừng chân ở bàn tiếp tân mà đi thẳng một mạch về phía phòng làm việc của chủ tịch hội đồng quản trị.",
          "explanation": "\"径直朝...走去\" miêu tả bước chân dứt khoát không ngập ngừng tiến thẳng tới phòng lãnh đạo."
        },
        {
          "chinese": "辩论结束后，代表团团长神情凝重，径直穿过记者包围圈乘车离开了会场。",
          "pinyin": "Biànlùn jiéshù hòu, dàibiǎotuán tuánzhǎng shénqíng níngzhòng, jìngzhí chuānguò jìzhě bāowéiquān chéngchē líkāi le huìchǎng.",
          "translation_vi": "Sau khi cuộc tranh luận kết thúc, trưởng đoàn đại biểu nét mặt trang nghiêm, đi thẳng xuyên qua vòng vây nhà báo để lên xe rời khỏi hội trường.",
          "explanation": "\"径直穿过...\" thể hiện hành động di chuyển dứt khoát né tránh phỏng vấn báo chí."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 40,
      "name": "Phó từ nỗ lực vô ích không kết quả \"徒然\" (Uổng công / Vô ích / Lãng phí)",
      "pattern": "Chủ ngữ + 徒然 + Động từ (浪费 / 消耗 / 挣扎 / 叹息 / 耗费)",
      "category": "Phó từ",
      "explanation_vi": "\"徒然\" (túrán) là phó từ văn học mang ý nghĩa \"chỉ làm một cách vô ích, uổng phí công sức, thời gian mà không thu lại bất kỳ kết quả hay ý nghĩa thiết thực nào\" (uổng công vô ích, chỉ tổ phí hoài). Thường mang sắc thái tiếc nuối sâu sắc.",
      "examples": [
        {
          "chinese": "如果缺乏科学的复习方法，仅仅靠熬夜死记硬背只会徒然消耗宝贵的时间和精力。",
          "pinyin": "Rúguǒ quēfá kēxué de fùxí fāngfǎ, jǐnjǐn kào áoyè sǐjìyìngbèi zhǐ huì túrán xiāohào bǎoguì de shíjiān hé jīnglì.",
          "translation_vi": "Nếu thiếu phương pháp ôn tập khoa học, chỉ dựa vào việc thức đêm học vẹt chỉ làm uổng công tiêu hao thời gian và tinh thần quý báu.",
          "explanation": "\"徒然消耗...\" cảnh báo việc học vẹt không có phương pháp sẽ khiến công sức đổ sông đổ biển."
        },
        {
          "chinese": "与其坐在废墟前徒然悲伤落泪，不如擦干眼泪重整旗鼓重建家园。",
          "pinyin": "Yǔqí zuò zài fèixū qián túrán bēishāng luòlèi, bùrú cāgān yǎnlèi chóngzhěngqígǔ chóngjiàn jiāyuán.",
          "translation_vi": "Thay vì ngồi trước đống tro tàn đổ nát đau buồn rơi lệ trong vô vọng, chi bằng hãy lau khô nước mắt sốc lại tinh thần tái thiết quê hương.",
          "explanation": "\"徒然悲伤落泪\" khuyên người dân biến đau thương thành hành động thực tế xây dựng lại đời sống."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 41,
      "name": "Phó từ tần suất diễn biến dồn dập \"屡屡\" (Liên tiếp / Nhiều lần / Dồn dập)",
      "pattern": "Chủ ngữ + 屡屡 + Động từ (获奖 / 受挫 / 创下新高 / 发生)",
      "category": "Phó từ",
      "explanation_vi": "\"屡屡\" (lǚlǚ) là dạng trùng điệp cao cấp của \"屡\", diễn tả hành động hoặc hiện tượng xuất hiện liên tiếp với tần suất rất cao trong một thời đoạn ngắn (liên tục, dồn dập, nhiều lần). Thường dùng trong tin tức tài chính, thể thao và báo cáo thời sự.",
      "examples": [
        {
          "chinese": "在这届世界大学生运动会上，我国游泳健儿表现出色，屡屡打破赛事纪录。",
          "pinyin": "Zài zhè jiè shìjiè dàxuéshēng yùndònghuì shang, wǒ guó yóuyǒng jiàn'ér biǎoxiàn chūsè, lǚlǚ dǎpò sàishì jìlù.",
          "translation_vi": "Tại Đại hội Thể thao Sinh viên Thế giới lần này, các kình ngư nước ta thi đấu xuất sắc, liên tiếp phá vỡ các kỷ lục của giải đấu.",
          "explanation": "\"屡屡打破纪录\" miêu tả chuỗi chiến thắng vang dội nối tiếp nhau của đoàn thể thao."
        },
        {
          "chinese": "国际原油市场受地缘局势影响剧烈波动，期货交易价格屡屡创下历史新高。",
          "pinyin": "Guójì yuányóu shìchǎng shòu dìyuán júshì yǐngxiǎng jùliè bōdòng, qīhuò jiāoyì jiàgé lǚlǚ chuàngxià lìshǐ xīngāo.",
          "translation_vi": "Thị trường dầu thô quốc tế chịu ảnh hưởng của cục diện địa chính trị biến động dữ dội, giá giao dịch hợp đồng tương lai liên tiếp lập đỉnh cao lịch sử mới.",
          "explanation": "\"屡屡创下新高\" phản ánh chuỗi tăng giá dồn dập nhiều phiên liên tục."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 42,
      "name": "Phó từ biến đổi âm thầm không một tiếng động \"悄然\" (Lặng lẽ / Âm thầm / Kín đáo)",
      "pattern": "Chủ ngữ + 悄然 + Động từ (发生 / 兴起 / 来临 / 离去 / 改变)",
      "category": "Phó từ",
      "explanation_vi": "\"悄然\" (qiǎorán) là phó từ mang phong vị văn học đậm nét, biểu thị một hiện tượng, sự việc hoặc một trào lưu xã hội diễn ra, lan tỏa một cách vô cùng êm ả, kín đáo, không ồn ào khoa trương mà tự nhiên thấm sâu vào đời sống (âm thầm, lặng lẽ). Khác với \"悄悄\" (khẩu ngữ đời thường), \"悄然\" dùng cho sự chuyển dịch của thời gian, mùa màng hoặc phong cách sống.",
      "examples": [
        {
          "chinese": "随着移动互联网技术的飞速普及，一种绿色低碳的生活方式正在全社会悄然兴起。",
          "pinyin": "Suízhe yídòng hùliánwǎng jìshù de fēisù pǔjí, yì zhǒng lǜsè dītàn de shēnghuó fāngshì zhèngzài quán shèhuì qiǎorán xīngqǐ.",
          "translation_vi": "Cùng với sự phổ cập thần tốc của công nghệ internet di động, một lối sống xanh giảm thiểu carbon đang âm thầm trỗi dậy trong toàn xã hội.",
          "explanation": "\"悄然兴起\" miêu tả xu hướng văn minh đô thị lan tỏa tự nhiên, êm dịu không cần hô hào khẩu hiệu."
        },
        {
          "chinese": "不知不觉中，秋天已经悄然来临，公园里的枫叶逐渐染上了绚烂的红色。",
          "pinyin": "Bùzhībùjué zhōng, qiūtiān yǐjīng qiǎorán láilín, gōngyuán lǐ de fēngyè zhújiàn rǎnshàng le xuànlàn de hóngsè.",
          "translation_vi": "Trong sự vô thức không nhận ra, mùa thu đã lặng lẽ tới tự bao giờ, lá phong trong công viên dần nhuộm sắc đỏ rực rỡ.",
          "explanation": "\"悄然来临\" khắc họa bước chân chuyển mùa nhẹ nhàng của thiên nhiên vũ trụ."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 43,
      "name": "Phó từ chỉ sự biến đổi trạng thái tức thì \"顿时\" (Lập tức / Tức khắc / Thoắt cái)",
      "pattern": "Biến cố xuất hiện, Chủ ngữ / Không gian + 顿时 + Động từ/Tính từ (沸腾 / 安静 / 亮了起来)",
      "category": "Phó từ",
      "explanation_vi": "\"顿时\" (dùnshí) là phó từ chỉ thời gian trong quá khứ hoặc hiện thực, biểu thị ngay sau khi một kích thích hoặc biến cố xảy ra, toàn bộ cục diện, bầu không khí hoặc trạng thái tâm lý lập tức thay đổi toàn diện trong nháy mắt (tức thì, thoắt cái). Khác với \"立刻\", \"顿时\" chuyên dùng miêu tả bầu không khí và cảnh tượng tập thể.",
      "examples": [
        {
          "chinese": "当舞台上的灯光骤然亮起时，喧闹的剧场大厅顿时变得鸦雀无声。",
          "pinyin": "Dāng wǔtái shang de dēngguāng zhòurán liàngqǐ shí, xuānnào de jùchǎng dàtīng dùnshí biànde yāquèwúshēng.",
          "translation_vi": "Khi ánh đèn trên sân khấu đột ngột bừng sáng, đại sảnh nhà hát đang ồn ào thoắt cái trở nên im phăng phắc không một tiếng động.",
          "explanation": "\"顿时变得鸦雀无声\" miêu tả sự biến đổi chuyển trạng thái âm thanh tức thì của cả khán phòng."
        },
        {
          "chinese": "听到航天飞船成功着陆的播报，指挥控制中心顿时沸腾了起来。",
          "pinyin": "Tīngdào hángtiān fēichuán chénggōng zhuólù de bōbào, zhǐhuī kòngzhì zhōngxīn dùnshí fèiténg le qǐlái.",
          "translation_vi": "Nghe bản tin tàu vũ trụ đã hạ cánh thành công, trung tâm chỉ huy điều khiển lập tức vỡ òa sôi động hẳn lên.",
          "explanation": "\"顿时沸腾了起来\" lột tả bầu không khí vỡ òa sung sướng bùng nổ của toàn thể kỹ sư."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 44,
      "name": "Cụm phó từ khoảnh khắc cực ngắn \"刹那间\" (Trong chớp mắt / Trong khoảnh khắc)",
      "pattern": "刹那间, Mệnh đề biến cố / Chủ ngữ + 刹那间 + Vị ngữ",
      "category": "Phó từ",
      "explanation_vi": "\"刹那间\" (chànàjiān) có nguồn gốc từ thuật ngữ Phật giáo \"sát-na\" (khoảnh khắc thời gian ngắn nhất chớp mắt). Dùng để đặc tả một sự kiện diễn ra nhanh như tia chớp, vượt quá tốc độ phản xạ thông thường của mắt người, tạo ấn tượng kịch tính phi thường.",
      "examples": [
        {
          "chinese": "一道耀眼的闪电撕破了夜空，刹那间照亮了整座沉睡中的城市。",
          "pinyin": "Yí dào yàoyǎn de shǎndiàn sīpò le yèkōng, chànàjiān zhàoliàng le zhěng zuò chénshuì zhōng de chéngshì.",
          "translation_vi": "Một tia chớp chói lòa xé toạc màn trời đêm, trong chớp mắt đã rọi sáng rực toàn bộ thành phố đang say ngủ.",
          "explanation": "\"刹那间照亮...\" đặc tả ánh sáng sấm sét lóe lên cực nhanh chiếu rọi không gian vạn vật."
        },
        {
          "chinese": "听到自己名字被宣布为获奖者的一瞬间，他脑海中刹那间闪过无数奋斗的日夜。",
          "pinyin": "Tīngdào zìjǐ míngzi bèi xuānbù wéi huòjiǎngzhě de yí shùnjiān, tā nǎohǎi zhōng chànàjiān shǎnguò wúshù fèndòu de rìyè.",
          "translation_vi": "Ngay khoảnh khắc nghe thấy tên mình được xướng lên là người đoạt giải, trong tâm trí anh ấy chỉ trong một chớp mắt đã vụt qua vô số ngày đêm phấn đấu.",
          "explanation": "\"刹那间闪过...\" diễn tả dòng hồi ức hiện về nhanh như một cuốn phim tua tốc độ cao."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 45,
      "name": "Phó từ liên tục tiếp diễn thời gian \"随即\" (Liền ngay sau đó / Ngay tắp lự)",
      "pattern": "Hành động 1 hoàn thành, (Chủ ngữ) + 随即 + Hành động 2",
      "category": "Phó từ",
      "explanation_vi": "\"随即\" (suíjí) là phó từ cao cấp tương đương với \"接着\" hoặc \"立刻\", biểu thị hành động thứ hai diễn ra liền ngay sau khi hành động thứ nhất vừa kết thúc mà không có bất kỳ khoảng trống thời gian gián đoạn nào (ngay sau đó, lập tức tiếp theo). Thường dùng trong báo cáo công tác và tin tức chính thức.",
      "examples": [
        {
          "chinese": "两国元首举行了亲切友好的正式会晤，随即共同出席了联合记者招待会。",
          "pinyin": "Liǎng guó yuánshǒu jǔxíng le qīnqiè yǒuhǎo de zhèngshì huìwù, suíjí gòngtóng chūxí le liánhé jìzhě zhāodàihuì.",
          "translation_vi": "Nguyên thủ hai nước đã tiến hành cuộc hội đàm chính thức thân mật và hữu nghị, ngay sau đó đã cùng nhau tham dự buổi họp báo chung với các phóng viên.",
          "explanation": "\"随即共同出席...\" liên kết nhịp nhàng hai lịch trình đối ngoại ngoại giao cấp cao nối tiếp nhau."
        },
        {
          "chinese": "救援人员迅速将伤员从废墟中救出，随即用直升机转运往最近的急救中心。",
          "pinyin": "Jiùyuán rényuán xùnsù jiāng shāngyuán cóng fèixū zhōng jiùchū, suíjí yòng zhíshēngjī zhuǎnyùn wǎng zuì jìn de jíjiù zhōngxīn.",
          "translation_vi": "Lực lượng cứu hộ nhanh chóng cứu người bị thương ra khỏi đống đổ nát, ngay sau đó đã dùng trực thăng chuyển thẳng tới trung tâm cấp cứu gần nhất.",
          "explanation": "\"随即用直升机转运\" thể hiện quy trình cấp cứu khẩn cấp chạy đua với thời gian liên tục."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 46,
      "name": "Phó từ xu thế tương lai chắc chắn xảy ra \"迟早\" (Sớm muộn gì / Không sớm thì muộn)",
      "pattern": "Chủ ngữ + 迟早 + (会 / 要) + Kết quả tất yếu",
      "category": "Phó từ",
      "explanation_vi": "\"迟早\" (chízǎo) kết hợp hai chữ \"迟\" (muộn) và \"早\" (sớm), biểu thị một kết quả hoặc hiện tượng dù hiện tại chưa xuất hiện nhưng trong tương lai nhất định sẽ xảy ra theo quy luật nhân quả tất yếu (sớm muộn gì cũng, chẳng sớm thì muộn). Thường dùng để khuyên răn, cảnh báo hoặc bày tỏ niềm tin kiên định.",
      "examples": [
        {
          "chinese": "只要坚持脚踏实地努力付出，你的才华迟早会得到社会的公正认可。",
          "pinyin": "Zhǐyào jiānchí jiǎotàshídì nǔlì fùchū, nǐ de cáihuá chízǎo huì dédào shèhuì de gōngzhèng rènkě.",
          "translation_vi": "Chỉ cần kiên trì nỗ lực hết mình từng bước vững chắc, tài năng của bạn sớm muộn gì cũng sẽ nhận được sự công nhận công bằng của xã hội.",
          "explanation": "\"迟早会得到...\" động viên người trẻ kiên định niềm tin vào giá trị bản thân trong tương lai."
        },
        {
          "chinese": "任何企图掩盖真相的不法行为，迟早会被法律的利剑公之于众并受到严惩。",
          "pinyin": "Rènhé qǐtú yǎngài zhēnxiàng de bùfǎ xíngwéi, chízǎo huì bèi fǎlǜ de lìjiàn gōngzhīyúzhòng bìng shòudào yánchéng.",
          "translation_vi": "Bất kỳ hành vi phi pháp nào mưu toan che đậy sự thật, sớm muộn gì cũng sẽ bị thanh gươm pháp luật phơi bày trước công chúng và trừng trị thích đáng.",
          "explanation": "\"迟早会被...\" khẳng định công lý tất thắng và sự trừng phạt tất yếu của pháp luật."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 47,
      "name": "Giới từ xem xét tình hình thực tế \"鉴于\" (Xét thấy / Nhận thấy / Do thấy)",
      "pattern": "鉴于 + Tình hình thực tế / Bối cảnh khách quan, Mệnh đề quyết định chính sách",
      "category": "Giới từ",
      "explanation_vi": "\"鉴于\" (jiànyú) là giới từ chính luận cao cấp dùng ở đầu câu, dẫn ra một thực trạng, một nguyên nhân khách quan hoặc một kinh nghiệm quá khứ làm căn cứ quan trọng để cơ quan, tổ chức đưa ra một chính sách, biện pháp ứng phó phù hợp (xét thấy tình hình này, do nhận thấy bối cảnh trên).",
      "examples": [
        {
          "chinese": "鉴于近期沿海地区台风活动频繁，海事部门发布了全线禁航的安全警示。",
          "pinyin": "Jiànyú jìnqī yánhǎi dìqū táifēng huódòng pínfán, hǎishì bùmén fābù le quánxiàn jìnháng de ānquán jǐngshì.",
          "translation_vi": "Xét thấy thời gian gần đây bão tại các vùng ven biển hoạt động dồn dập, cơ quan hải sự đã ban bố cảnh báo an toàn cấm tàu bè ra khơi trên toàn tuyến.",
          "explanation": "\"鉴于近期沿海地区台风活动频繁\" nêu ra căn cứ thời tiết khách quan để ban hành lệnh cấm tàu bè."
        },
        {
          "chinese": "鉴于该员工在过去一年中的突出业务贡献，董事会决定破格提拔其为部门总监。",
          "pinyin": "Jiànyú gāi yuángōng zài guòqù yì nián zhōng de tūchū yèwù gòngxiàn, dǒngshìhuì juédìng pògé tíbá qí wéi bùmén zǒngjiān.",
          "translation_vi": "Xét thấy những cống hiến nghiệp vụ xuất chúng của nhân viên này trong một năm qua, hội đồng quản trị đã quyết định đặc cách cất nhắc anh làm giám đốc bộ phận.",
          "explanation": "\"鉴于...突出业务贡献\" là lý do chính đáng để doanh nghiệp bổ nhiệm nhân tài vượt cấp."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 48,
      "name": "Giới từ xây dựng trên nền tảng lý luận \"基于\" (Dựa trên / Căn cứ vào / Trên cơ sở)",
      "pattern": "基于 + Nền tảng lý luận / Dữ liệu nghiên cứu / Khảo sát, Mệnh đề kết luận",
      "category": "Giới từ",
      "explanation_vi": "\"基于\" (jīyú) chỉ cơ sở khoa học, nền tảng lý luận, số liệu thống kê hoặc mô hình thực nghiệm làm bệ phóng để xây dựng phương án, giải thuật hoặc kết luận nghiên cứu (dựa trên nền tảng, căn cứ trên cơ sở). Khác với \"鉴于\" (thiên về thời thế, rủi ro), \"基于\" thiên về dữ liệu và học thuật.",
      "examples": [
        {
          "chinese": "该科研团队基于海量临床实验数据，研发出了一种全新的抗癌靶向药物。",
          "pinyin": "Gāi kēyán tuánduì jīyú hǎiliàng línchuáng shíyàn shùjù, yánfā chū le yì zhǒng quánxīn de kàng'ái bǎxiàng yàowù.",
          "translation_vi": "Nhóm nghiên cứu khoa học này dựa trên nguồn dữ liệu thử nghiệm lâm sàng khổng lồ, đã nghiên cứu phát triển thành công một loại thuốc nhắm trúng đích chống ung thư hoàn toàn mới.",
          "explanation": "\"基于海量临床实验数据\" khẳng định nền tảng khoa học thực nghiệm vững chắc của phát minh dược phẩm."
        },
        {
          "chinese": "基于对全球消费市场长期趋势的深入分析，公司制定了未来五年的出海战略。",
          "pinyin": "Jīyú duì quánqiú xiāofèi shìchǎng chángqī qūshì de shēnrù fēnxī, gōngsī zhìdìng le wèilái wǔ nián de chūhǎi zhànlüè.",
          "translation_vi": "Dựa trên sự phân tích sâu sắc đối với xu thế dài hạn của thị trường tiêu dùng toàn cầu, công ty đã đề ra chiến lược vươn ra biển lớn trong 5 năm tới.",
          "explanation": "\"基于对...深入分析\" làm rõ việc lập kế hoạch kinh doanh xuất phát từ dữ liệu nghiên cứu thị trường bài bản."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 49,
      "name": "Giới từ xuất phát từ động cơ tâm lý \"出于\" (Xuất phát từ / Do / Vì)",
      "pattern": "出于 + Động cơ/Mục đích (好意 / 好奇 / 同情 / 安全考虑 / 礼貌), Mệnh đề",
      "category": "Giới từ",
      "explanation_vi": "\"出于\" (chūyú) dẫn ra động cơ nội tâm, ý định ban đầu hoặc sự cân nhắc xuất phát từ tấm lòng, sự đồng cảm hoặc đạo đức nghề nghiệp của con người (xuất phát từ, vì lý do). Thường kết hợp với các từ như 好奇, 好心, 礼貌, 谨慎, 责任感, 人道主义.",
      "examples": [
        {
          "chinese": "他当时之所以伸出援手，完全是出于一位普通公民最本能的善良与同情心。",
          "pinyin": "Tā dāngshí zhīsuǒyǐ shēnchū yuánshǒu, wánquán shì chūyú yí wèi pǔtōng gōngmín zuì běnnéng de shànliáng yǔ tóngqíngxīn.",
          "translation_vi": "Sở dĩ lúc đó anh ấy đưa tay giúp đỡ, hoàn toàn là xuất phát từ lòng lương thiện và sự đồng cảm bản năng nhất của một công dân bình thường.",
          "explanation": "\"出于...善良与同情心\" làm sáng tỏ động cơ nhân văn cao đẹp của nghĩa cử cứu giúp người khác."
        },
        {
          "chinese": "出于保护未成年人身心健康的考虑，国家严格限制了网络游戏的服务时长。",
          "pinyin": "Chūyú bǎohù wèichéngniánrén shēnxīn jiànkāng de kǎolǜ, guójiā yángé xiànzhì le wǎngluò yóuxì de fúwù shícháng.",
          "translation_vi": "Xuất phát từ sự cân nhắc bảo vệ sức khỏe thể chất và tinh thần của trẻ vị thành niên, nhà nước đã hạn chế nghiêm ngặt thời lượng phục vụ của trò chơi điện tử trực tuyến.",
          "explanation": "\"出于保护...的考虑\" giải thích nguyên nhân nhân văn đằng sau chính sách giới hạn giờ chơi game."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 50,
      "name": "Giới từ men theo tuyến đường địa lý \"沿着\" (Men theo / Dọc theo)",
      "pattern": "Chủ ngữ + 沿着 + Tuyến đường/Dòng sông/Bờ biển + Động từ di chuyển (走/跑/巡逻/行驶)",
      "category": "Giới từ",
      "explanation_vi": "\"沿着\" (yánzhe) biểu thị hành động di chuyển tuân thủ bám sát theo một tuyến đường dài có sẵn như dòng sông, bờ biển, con đường, đường ray hoặc tuyến cáp (men theo, dọc theo con đường). Ngoài ra còn dùng ẩn dụ: \"沿着...道路前进\" (tiến bước theo con đường lý tưởng).",
      "examples": [
        {
          "chinese": "夏日的傍晚，许多市民喜欢沿着风景秀丽的江边绿道散步乘凉。",
          "pinyin": "Xiàrì de bàngwǎn, xǔduō shìmín xǐhuan yánzhe fēngjǐng xiùlì de jiāngbiān lǜdào sànbù chéngliáng.",
          "translation_vi": "Vào chiều tối mùa hè, rất nhiều người dân thành phố thích đi dạo hóng mát men theo con đường xanh ven sông phong cảnh tươi đẹp.",
          "explanation": "\"沿着...江边绿道散步\" miêu tả lộ trình đi dạo bám sát cảnh quan bờ sông mát rượi."
        },
        {
          "chinese": "全体官兵将始终坚定不移地沿着中国特色强军之路奋勇向前。",
          "pinyin": "Quántǐ guānbīng jiāng shǐzhōng jiāndìngbùyí de yánzhe Zhōngguó tèsè qiángjūn zhī lù fènyǒng xiàngqián.",
          "translation_vi": "Toàn thể cán bộ chiến sĩ sẽ luôn kiên định không dời vững bước tiến lên dọc theo con đường xây dựng quân đội hùng mạnh mang đặc sắc Trung Quốc.",
          "explanation": "\"沿着...之路奋勇向前\" dùng \"沿着\" theo nghĩa ẩn dụ chính luận về con đường lý tưởng cách mạng."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 51,
      "name": "Giới từ lần theo manh mối hoặc xuôi chiều \"顺着\" (Xuôi theo / Lần theo / Thuận theo)",
      "pattern": "顺着 + Hướng dòng chảy / Manh mối / Tiếng động, Chủ ngữ + Động từ",
      "category": "Giới từ",
      "explanation_vi": "\"顺着\" (shùnzhe) có ba nghĩa chính: 1) Thuận theo hướng chuyển động tự nhiên (như 顺着水流 - xuôi theo dòng nước, 顺着风向 - thuận theo chiều gió); 2) Lần theo dấu vết, âm thanh hoặc manh mối để tìm kiếm (như 顺着声音看去 - nhìn theo hướng âm thanh); 3) Chiều theo ý người khác (như 顺着他的脾气).",
      "examples": [
        {
          "chinese": "刑警顺着现场遗留的一点蛛丝马迹，最终成功锁定了犯罪嫌疑人的藏身之地。",
          "pinyin": "Xíngjǐng shùnzhe xiànchǎng yíliú de yì diǎn zhūsīmǎjì, zuìzhōng chénggōng suǒdìng le fànzuì xiányírén de cángshēn zhī dì.",
          "translation_vi": "Cảnh sát hình sự lần theo một chút manh mối li ti còn sót lại tại hiện trường, cuối cùng đã khóa chặt thành công nơi ẩn náu của nghi phạm.",
          "explanation": "\"顺着现场遗留的蛛丝马迹\" miêu tả quá trình phá án bám sát từng dấu vết nghiệp vụ."
        },
        {
          "chinese": "竹筏顺着湍急的溪流飞速而下，两岸奇峰耸立，令人目不暇接。",
          "pinyin": "Zhúfá shùnzhe tuānjí de xīliú fēisù ér xià, liǎng'àn qífēng sǒnglì, lìng rén mùbùxiájiē.",
          "translation_vi": "Bè tre xuôi theo dòng suối chảy xiết lao vun vút xuống dưới, hai bên bờ núi non kỳ vĩ sừng sững khiến người ta nhìn không xuể mắt.",
          "explanation": "\"顺着湍急的溪流\" miêu tả chuyển động trôi tự nhiên của con bè nương theo sức nước con suối."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 52,
      "name": "Giới từ nhân dịp hoặc mượn phương tiện \"借\" (Nhân dịp / Nhờ vào / Mượn cơ hội)",
      "pattern": "借 + Cơ hội/Dịp tốt / 借...之机, Chủ ngữ + Động từ + Tân ngữ",
      "category": "Giới từ",
      "explanation_vi": "\"借\" (jiè) trong tiếng Trung HSK 5 ngoài nghĩa động từ \"vay, mượn\" còn được dùng như một giới từ chỉ phương thức hoặc thời cơ thuận lợi (nhân dịp này, mượn cớ, dựa vào sức mạnh bên ngoài để hành sự). Thường dùng trong ngoại giao và văn hóa xã giao: \"借此机会\" (nhân cơ hội này), \"借题发挥\" (mượn đề tài để mở rộng).",
      "examples": [
        {
          "chinese": "值此新春佳节来临之际，我借此机会向全体员工及家属致以最诚挚的节日问候。",
          "pinyin": "Zhícǐ xīnchūn jiājié láilín zhījì, wǒ jiè cǐ jīhuì xiàng quántǐ yuángōng jí jiāshǔ zhìyǐ zuì chéngzhì de jiérì wènhòu.",
          "translation_vi": "Nhân dịp Tết đến xuân về này, tôi mượn cơ hội này xin gửi tới toàn thể nhân viên cùng gia quyến lời thăm hỏi ngày lễ chân thành nhất.",
          "explanation": "\"借此机会\" là khẩu ngữ nghi lễ trang trọng quen thuộc mở đầu bức thư chúc mừng năm mới."
        },
        {
          "chinese": "风筝正是借着大风的托举之力，才能在湛蓝的高空中自由翱翔。",
          "pinyin": "Fēngzheng zhèng shì jièzhe dàfēng de tuōjǔ zhī lì, cái néng zài zhànlán de gāokōng zhōng zìyóu áoxiáng.",
          "translation_vi": "Con diều chính là nhờ nương vào lực nâng của ngọn gió lớn mới có thể tự do chao lượn trên bầu trời xanh thẳm.",
          "explanation": "\"借着大风的托举之力\" giải thích quy luật vật lý dựa vào sức gió để bay cao."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 53,
      "name": "Giới từ mốc quá trình thẩm định hoàn tất \"经\" (Qua / Sau khi qua / Trải qua)",
      "pattern": "经 + Động từ song âm tiết (批准 / 调查 / 研究 / 核实 / 专家评审), Mệnh đề kết luận",
      "category": "Giới từ",
      "explanation_vi": "\"经\" (jīng) là giới từ văn thư hành chính cao cấp, mang nghĩa \"sau khi đã trải qua một thủ tục thẩm định, xem xét hoặc nghiên cứu kỹ lưỡng\" (qua khảo sát, sau khi được cấp phép). Thường kết hợp với các động từ hai chữ như 批准 (phê chuẩn), 调查 (điều tra), 讨论 (thảo luận), 审核 (thẩm duyệt).",
      "examples": [
        {
          "chinese": "经上级教育主管部门严格批准，该校将从下学期起正式开设人工智能实验班。",
          "pinyin": "Jīng shàngjí jiàoyù zhǔguǎn bùmén yángé pīzhǔn, gāi xiào jiāng cóng xià xuéqī qǐ zhèngshì kāishè réngōng zhìnéng shíyànbān.",
          "translation_vi": "Sau khi được cơ quan chủ quản giáo dục cấp trên phê chuẩn nghiêm ngặt, ngôi trường này sẽ chính thức mở lớp thực nghiệm trí tuệ nhân tạo từ học kỳ tới.",
          "explanation": "\"经...严格批准\" xác lập tính pháp lý hoàn thiện cho việc mở mã ngành đào tạo mới."
        },
        {
          "chinese": "经公安机关缜密的技术核实，网络上热传的那段事故视频系后期恶意剪辑合成。",
          "pinyin": "Jīng gōng'ān jīguān zhěnmì de jìshù héshí, wǎngluò shang rèchuán de nà duàn shìgù shìpín xì hòuqī èyì jiǎnjí héchéng.",
          "translation_vi": "Qua sự xác minh kỹ thuật cẩn trọng của cơ quan công an, đoạn video tai nạn đang lan truyền rầm rộ trên mạng là sản phẩm cắt ghép ác ý giai đoạn hậu kỳ.",
          "explanation": "\"经...缜密核实\" công bố kết luận điều tra chính thức bác bỏ tin giả thất thiệt."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 54,
      "name": "Giới từ xác lập chủ đề hội đàm chính trị \"就\" (Về / Nhân / Đứng trên phương diện)",
      "pattern": "就 + Chủ đề/Vấn đề trọng đại + Động từ (达成协议 / 发表看法 / 交换意见 / 展开磋商)",
      "category": "Giới từ",
      "explanation_vi": "\"就\" (jiù) trong ngoại giao và thời sự chính trị đóng vai trò như một giới từ chỉ phạm vi chủ đề được đưa ra bàn thảo (về vấn đề, liên quan tới phương diện). Thường đi với các cặp kết hợp: \"就...达成共识\" (đạt được đồng thuận về...), \"就...交换意见\" (trao đổi ý kiến về...). Khác với \"对\", \"就\" mang sắc thái nghi lễ đối ngoại ngoại giao cao hơn.",
      "examples": [
        {
          "chinese": "两国经贸代表团在日内瓦就知识产权保护问题达成了广泛的共识。",
          "pinyin": "Liǎng guó jīngmào dàibiǎotuán zài Rìnèiwǎ jiù zhīshi chǎnquán bǎohù wèntí dáchéng le guǎngfàn de gòngshí.",
          "translation_vi": "Đoàn đại biểu kinh tế thương mại hai nước tại Geneva đã đạt được sự đồng thuận rộng rãi về vấn đề bảo hộ quyền sở hữu trí tuệ.",
          "explanation": "\"就...达成共识\" là công thức ngoại giao chuẩn mực xác định kết quả của vòng đàm phán quốc tế."
        },
        {
          "chinese": "新闻发言人就近期国际社会的关切问题逐一作出了权威、详尽的官方回应。",
          "pinyin": "Xīnwén fāyánrén jiù jìnqī guójì shèhuì de guānqiè wèntí zhúyī zuòchū le quánwēi, xiángjìn de guānfāng huíyìng.",
          "translation_vi": "Người phát ngôn tin tức đã lần lượt đưa ra những phản hồi chính thức đầy thẩm quyền và chi tiết về các vấn đề mà cộng đồng quốc tế quan tâm gần đây.",
          "explanation": "\"就...作出了回应\" xác lập mục tiêu đối thoại rõ ràng trong buổi họp báo quốc tế."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 55,
      "name": "Giới từ tuân thủ chỉ thị và mệnh lệnh \"遵照\" (Tuân theo / Làm đúng theo)",
      "pattern": "遵照 + Chỉ thị/Chỉ đạo/Lời dặn/Pháp luật + Động từ thực hiện",
      "category": "Giới từ",
      "explanation_vi": "\"遵照\" (zūnzhào) biểu thị việc chấp hành tuyệt đối và nghiêm túc theo lời dặn, chỉ thị của cấp trên, di nguyện của tiền nhân, hoặc quy định của pháp luật (tuân theo, làm đúng theo chỉ đạo). Mang sắc thái kính cẩn, phục tùng và trách nhiệm pháp lý cao.",
      "examples": [
        {
          "chinese": "医护人员严格遵照世界卫生组织的操作指南，有条不紊地开展感染防控工作。",
          "pinyin": "Yīhù rényuán yángé zūnzhào Shìjiè Wèishēng Zǔzhī de cāozuò zhǐnán, yǒutiáobùwěn de kāizhǎn gǎnrǎn fángkòng gōngzuò.",
          "translation_vi": "Các nhân viên y tế tuân thủ nghiêm ngặt theo hướng dẫn thao tác của Tổ chức Y tế Thế giới, triển khai công tác phòng chống nhiễm trùng một cách ngăn nắp tuần tự.",
          "explanation": "\"严格遵照...操作指南\" làm rõ hành động tuân thủ tiêu chuẩn y khoa quốc tế."
        },
        {
          "chinese": "他遵照已故老科学家的生前遗嘱，将毕生积蓄全额捐赠给了贫困山区学校。",
          "pinyin": "Tā zūnzhào yǐgù lǎo kēxuéjiā de shēngqián yízhǔ, jiāng bìshēng jīxù quán'é juānzèng gěi le pínkùn shānqū xuéxiào.",
          "translation_vi": "Anh ấy làm đúng theo di chúc lúc sinh thời của cố nhà khoa học già, đem toàn bộ tiền tích lũy cả đời quyên tặng cho các trường học vùng núi nghèo khó.",
          "explanation": "\"遵照...生前遗嘱\" thể hiện lòng trung thực và sự kính trọng đối với tâm nguyện của người đã khuất."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 56,
      "name": "Phân biệt ba giới từ chính luận cốt lõi: \"鉴于\" vs \"基于\" vs \"出于\"",
      "pattern": "鉴于 (Tình hình khách quan/Kinh nghiệm) vs 基于 (Cơ sở dữ liệu/Lý luận) vs 出于 (Động cơ nội tâm)",
      "category": "Giới từ",
      "explanation_vi": "Ba giới từ chữ \"于\" này phân định rõ ranh giới ngữ pháp học thuật: 1) \"鉴于\" (xét thấy) dẫn ra hiện thực khách quan, tình huống khẩn cấp hoặc bài học quá khứ để đưa ra cảnh báo/quyết sách; 2) \"基于\" (dựa trên) dẫn ra căn cứ dữ liệu, tài liệu, lý thuyết mô hình để rút ra kết luận khoa học; 3) \"出于\" (xuất phát từ) dẫn ra động cơ tâm lý, tình cảm, thiện chí hoặc nguyên tắc đạo đức nội tại của con người.",
      "examples": [
        {
          "chinese": "鉴于天气突变，基于雷达监测数据，出于安全考虑，机长决定返航。",
          "pinyin": "Jiànyú tiānqì tūbiàn, jīyú léidá jiāncè shùjù, chūyú ānquán kǎolǜ, jīzhǎng juédìng fǎnháng.",
          "translation_vi": "Xét thấy thời tiết đột biến, dựa trên dữ liệu giám sát ra-đa, xuất phát từ sự cân nhắc an toàn, cơ trưởng đã quyết định bay quay đầu về.",
          "explanation": "Câu kinh điển phối hợp cả 3 giới từ làm nổi bật rõ ranh giới chức năng của từng từ trong tình huống hàng không."
        },
        {
          "chinese": "这项新规划基于长期的科学论证，旨在彻底消除各种潜在的安全隐患。",
          "pinyin": "Zhè xiàng xīn guīhuà jīyú chángqī de kēxué lùnzhèng, zhǐzài chèdǐ xiāochú gè zhǒng qiánzài de ānquán yǐnhuàn.",
          "translation_vi": "Quy hoạch mới này được xây dựng trên cơ sở thẩm định khoa học lâu dài, nhằm triệt tiêu hoàn toàn các mối hiểm họa an toàn tiềm ẩn.",
          "explanation": "\"基于长期的科学论证\" làm nổi bật tính vững chắc về mặt học thuật của quy hoạch dự án."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 57,
      "name": "Cấu trúc phản đề phủ định tăng tiến \"不仅不...反而...\" (Chẳng những không... trái lại còn...)",
      "pattern": "Chủ ngữ + 不仅不 / 不但没 + Hành động mong đợi, 反而 + Hành động/Kết quả trái ngược",
      "category": "Liên từ",
      "explanation_vi": "\"不仅不...反而...\" (bùjǐn bù... fǎn'ér...) kết hợp quan hệ tăng tiến và phản đề: vế trước phủ định việc hành vi thông thường hay kỳ vọng diễn ra, vế sau dùng \"反而\" để đẩy kết quả sang chiều hướng hoàn toàn đối lập với dự đoán hoặc gây bất ngờ lớn (chẳng những không... mà trái lại còn...).",
      "examples": [
        {
          "chinese": "面对大家的诚恳批评，他不仅不虚心接受，反而蛮不讲理地大发雷霆。",
          "pinyin": "Miànduì dàjiā de chéngkěn pīpíng, tā bùjǐn bù xūxīn jiēshòu, fǎn'ér mánbùjiǎnglǐ de dàfāléitíng.",
          "translation_vi": "Đối mặt với lời phê bình chân thành của mọi người, anh ta chẳng những không khiêm tốn tiếp thu, mà trái lại còn vô lý nổi trận lôi đình.",
          "explanation": "\"不仅不虚心接受，反而...\" làm nổi bật thái độ ngang ngược trái ngược hoàn toàn với tinh thần cầu thị."
        },
        {
          "chinese": "受到对手的故意挑衅后，他不仅没有慌乱，反而冷静沉着地打出了制胜一球。",
          "pinyin": "Shòudào duìshǒu de gùyì tiǎoxìn hòu, tā bùjǐn méiyǒu huāngluàn, fǎn'ér lěngjìng chénzhuó de dǎchū le zhìshèng yì qiú.",
          "translation_vi": "Sau khi bị đối thủ cố ý khiêu khích, anh ấy chẳng những không hề rối loạn, mà trái lại còn bình tĩnh điềm đạm đánh ra cú bóng quyết định chiến thắng.",
          "explanation": "\"不仅没有...反而...\" tôn vinh bản lĩnh thép kiên cường trước sự khiêu khích trên sân đấu."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 58,
      "name": "Liên từ tăng tiến nâng cao bậc hành động \"进而\" (Tiến thêm một bước / Hơn thế nữa)",
      "pattern": "Hành động cấp 1, 进而 + Hành động cấp 2 (sâu hơn, rộng hơn hoặc đạt mục tiêu cao hơn)",
      "category": "Liên từ",
      "explanation_vi": "\"进而\" (jìn'ér) là liên từ chính luận cao cấp nối hai hành động hoặc giai đoạn phát triển, trong đó hành động ở vế sau dựa trên cơ sở của vế trước để tiến thêm một bước sâu hơn, quy mô lớn hơn hoặc đạt tới tầm cao mới (từ đó tiến tới, hơn thế nữa). Khác với \"从而\" (chỉ kết quả tự nhiên), \"进而\" nhấn mạnh sự nỗ lực chủ động tiến cấp.",
      "examples": [
        {
          "chinese": "我们要先掌握扎实的理论基础知识，进而培养独立分析和解决复杂问题的科研能力。",
          "pinyin": "Wǒmen yào xiān zhǎowò zhāshi de lǐlùn jīchǔ zhīshi, jìn'ér péiyǎng dúlì fēnxī hé jiějué fùzá wèntí de kēyán nénglì.",
          "translation_vi": "Chúng ta cần nắm vững kiến thức nền tảng lý luận vững chắc trước, từ đó tiến tới bồi dưỡng năng lực nghiên cứu khoa học độc lập phân tích và giải quyết vấn đề phức tạp.",
          "explanation": "\"进而培养...\" thể hiện bước tiến nâng cấp từ tích lũy kiến thức cơ bản lên năng lực sáng tạo đỉnh cao."
        },
        {
          "chinese": "企业通过并购地方龙头品牌打开了区域销路，进而实现了进军全国大市场的战略宏图。",
          "pinyin": "Qǐyè tōngguò bìnggòu dìfāng lóngtóu pǐnpái dǎkāi le qūyù xiāolù, jìn'ér shíxiàn le jìnjūn quánguó dà shìchǎng de zhànlüè hóngtú.",
          "translation_vi": "Doanh nghiệp thông qua việc sáp nhập thương hiệu đầu ngành địa phương đã mở toang đầu ra tiêu thụ theo vùng, từ đó tiến tới hiện thực hóa đại đồ chiến lược tiến quân vào thị trường lớn cả nước.",
          "explanation": "\"进而实现了...\" miêu tả bước nhảy vọt quy mô thị trường từ phạm vi địa phương sang toàn quốc."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 59,
      "name": "Liên từ chỉ chuỗi thời gian tuần tự của sự kiện \"继而\" (Tiếp đó / Sau đó không lâu)",
      "pattern": "Sự kiện 1 phát sinh, 继而 + Sự kiện 2 nối tiếp",
      "category": "Liên từ",
      "explanation_vi": "\"继而\" (jì'ér) là liên từ biểu thị quan hệ thời gian nối tiếp chặt chẽ: một sự việc hoặc hiện tượng xảy ra xong, tiếp liền sau đó phát sinh một sự việc khác (tiếp đó, nối tiếp theo sau). Khác với \"进而\" (tăng tiến về chất và mức độ), \"继而\" thuần túy chỉ thứ tự trước sau về mặt thời gian.",
      "examples": [
        {
          "chinese": "天空中先是响起了沉闷的雷声，继而下起了瓢泼大雨。",
          "pinyin": "Tiānkōng zhōng xiān shì xiǎngqǐ le chénmèn de léishēng, jì'ér xiàqǐ le piáopō dàyǔ.",
          "translation_vi": "Trên bầu trời thoạt tiên vang lên tiếng sấm rền trầm đục, tiếp đó đổ xuống trận mưa rào như trút nước.",
          "explanation": "\"先是...继而...\" diễn tả thứ tự thời gian tự nhiên: tiếng sấm dội trước rồi cơn mưa ập đến ngay sau đó."
        },
        {
          "chinese": "双方最初只是在学术观点上产生口角争执，继而演变成了激烈的言语人身攻击。",
          "pinyin": "Shuāngfāng zuìchū zhǐshì zài xuéshù guāndiǎn shang chǎnshēng kǒujiǎo zhēngzhí, jì'ér yǎnbiàn chéng le jīliè de yányǔ rénshēn gōngjī.",
          "translation_vi": "Đôi bên ban đầu chỉ là cãi vã đôi co về quan điểm học thuật, tiếp đó đã biến tướng thành những lời công kích cá nhân gay gắt.",
          "explanation": "\"继而演变...\" ghi nhận sự biến tướng leo thang nối tiếp nhau của mâu thuẫn giao tiếp."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 60,
      "name": "Phân biệt chuẩn xác cặp liên từ học thuật: \"进而\" vs \"继而\"",
      "pattern": "进而 (Tăng tiến bản chất/bước tiến sâu hơn) vs 继而 (Nối tiếp tuần tự thời gian)",
      "category": "Liên từ",
      "explanation_vi": "Điểm mấu chốt để phân biệt: 1) \"进而\" (jìn'ér) biểu thị quan hệ tăng tiến (遞進): bước sau sâu sắc hơn, có chủ đích phát triển nâng cao hơn bước trước; 2) \"继而\" (jì'ér) biểu thị quan hệ nối tiếp thời gian (承接): sự việc sau xảy ra liền kề sau sự việc trước theo dòng thời gian, không nhất thiết có ý nghĩa nâng cao về chất.",
      "examples": [
        {
          "chinese": "我们先调查掌握了第一手事实，进而深入剖析了问题的根源。",
          "pinyin": "Wǒmen xiān diàochá zhǎowò le dìyīshǒu shìshí, jìn'ér shēnrù pōuxī le wèntí de gēnyuán.",
          "translation_vi": "Chúng tôi trước hết điều tra nắm vững sự thật đầu tay, từ đó tiến thêm một bước mổ xẻ sâu sắc nguồn cơn của vấn đề.",
          "explanation": "\"进而深入剖析\" thể hiện bước tiến nhận thức sâu sắc hơn từ việc thu thập dữ liệu thô sang phân tích bản chất."
        },
        {
          "chinese": "人群中首先传出低微的啜泣声，继而演化为全场悲痛的痛哭。",
          "pinyin": "Rénqún zhōng shǒuxiān chuánchū dīwēi de chuòqì shēng, jì'ér yǎnhuà wéi quánchǎng bēitòng de tòngkū.",
          "translation_vi": "Trong đám đông trước tiên phát ra tiếng khóc thút thít nghẹn ngào, tiếp đó biến thành tiếng khóc than bi thương của toàn hội trường.",
          "explanation": "\"继而演化...\" miêu tả sự lan truyền nối tiếp của âm thanh tiếng khóc theo trình tự thời gian."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 61,
      "name": "Liên từ giả thiết trang trọng văn ngôn \"假使\" (Giả sử / Ví bằng)",
      "pattern": "假使 + Tình huống giả định, (那么) 主语 + Cũng/Sẽ + Kết quả",
      "category": "Liên từ",
      "explanation_vi": "\"假使\" (jiǎshǐ) là liên từ giả thiết cao cấp tương đương với \"如果\" hoặc \"假如\", nhưng mang sắc thái trang nghiêm, triết luận và đậm tính học thuật văn học cổ điển (giả sử như, ví phỏng). Thường dùng khi đặt ra các giả thiết logic để phản biện hoặc chứng minh một chân lý.",
      "examples": [
        {
          "chinese": "假使世界上没有了阳光和水源，一切生命都将彻底失去生存的可能。",
          "pinyin": "Jiǎshǐ shìjiè shang méiyǒu le yángguāng hé shuǐyuán, yíqiè shēngmìng dōu jiāng chèdǐ shīqù shēngcún de kěnéng.",
          "translation_vi": "Giả sử trên thế giới không còn ánh nắng và nguồn nước, toàn bộ sinh linh đều sẽ mất đi hoàn toàn khả năng sinh tồn.",
          "explanation": "\"假使...都将...\" đặt ra giả thiết triết học cực đoan nhằm khẳng định vai trò sống còn của thiên nhiên."
        },
        {
          "chinese": "假使当初我们没有坚持核心技术的自主研发，今天势必会处处受制于人。",
          "pinyin": "Jiǎshǐ dāngchū wǒmen méiyǒu jiānchí héxīn jìshù de zìzhǔ yánfā, jīntiān shìbì huì chùchù shòuzhìyúrén.",
          "translation_vi": "Ví phỏng thuở ban đầu chúng ta không kiên trì tự chủ nghiên cứu phát triển công nghệ cốt lõi, ngày hôm nay ắt hẳn sẽ nơi nơi đều bị người khác kìm kẹp.",
          "explanation": "\"假使...势必...\" nhìn lại quyết định lịch sử đúng đắn cứu doanh nghiệp khỏi sự phụ thuộc."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 62,
      "name": "Liên từ giả thiết giàu sắc thái văn học \"倘若\" (Nếu như / Ví thử)",
      "pattern": "倘若 + Giả thiết giàu cảm xúc, 主语 + 便 / 就 + Kết quả",
      "category": "Liên từ",
      "explanation_vi": "\"倘若\" (tǎngruò) là liên từ giả định văn học tao nhã tương đương với \"要是\" hoặc \"如果\", thường xuất hiện trong các tác phẩm văn xuôi, tùy bút, hoặc những lập luận giàu chất thơ và triết lý nhân sinh (ví thử, nếu như mà). Vế sau thường kết hợp với \"便\" hoặc \"就\".",
      "examples": [
        {
          "chinese": "人生倘若没有崇高的追求与梦想，生活便会沦为一片乏味的荒漠。",
          "pinyin": "Rénshēng tǎngruò méiyǒu chónggāo de zhuīqiú yǔ mèngxiǎng, shēnghuó biàn huì lúnwéi yí piàn fáwèi de huāngmò.",
          "translation_vi": "Đời người ví thử không có những hoài bão và ước mơ cao đẹp, cuộc sống ắt sẽ biến thành một sa mạc cằn cỗi nhạt nhẽo.",
          "explanation": "\"倘若...便会...\" là cấu trúc giả thiết nhân sinh giàu chất thơ so sánh cuộc sống với hoang mạc."
        },
        {
          "chinese": "倘若明天天气晴朗无风，我们便可如期扬帆起航前往海岛写生。",
          "pinyin": "Tǎngruò míngtiān tiānqì qínglǎng wú fēng, wǒmen biàn kě rúqī yángfān qǐháng qiánwǎng hǎidǎo xiěshēng.",
          "translation_vi": "Nếu như ngày mai tiết trời quang đãng không gió, chúng ta liền có thể giương buồm ra khơi tới hòn đảo vẽ ký họa đúng như dự định.",
          "explanation": "\"倘若...便可...\" dùng giả thiết tao nhã trong câu chuyện du ngoạn nghệ thuật."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 63,
      "name": "Liên từ phản thực tế biết ơn hoặc tiếc nuối \"要不是\" (Nếu không nhờ / Nếu không vì)",
      "pattern": "要不是 + Yếu tố cứu cánh/cản trở, 主语 + 早就 / 已经 + Hậu quả xấu / Kết quả khác",
      "category": "Liên từ",
      "explanation_vi": "\"要不是\" (yàobúshì) là liên từ biểu thị điều kiện phản thực tế (counterfactual): trên thực tế điều đó ĐÃ xảy ra hoặc ĐÃ có mặt, nhưng người nói giả định tình huống ngược lại \"nếu như không có nó thì sự việc đã dẫn tới hậu quả hoàn toàn khác\" (nếu không nhờ có, nếu không vì). Thường dùng để bày tỏ sự cảm ơn sâu sắc hoặc niềm tiếc nuối.",
      "examples": [
        {
          "chinese": "今天路上要不是交警同志及时疏通引导，我肯定赶不上这趟国际航班了。",
          "pinyin": "Jīntiān lùshang yàobúshì jiāojǐng tóngzhì jíshí shūtōng yǐndǎo, wǒ kěndìng gǎnbushàng zhè tàng guójì hángbān le.",
          "translation_vi": "Hôm nay trên đường nếu không nhờ có đồng chí cảnh sát giao thông kịp thời phân luồng chỉ dẫn, tôi chắc chắn đã không kịp chuyến bay quốc tế này rồi.",
          "explanation": "\"要不是...肯定赶不上...\" bày tỏ lòng biết ơn sâu sắc đối với sự hỗ trợ của cảnh sát giao thông."
        },
        {
          "chinese": "要不是突如其来的伤病困扰，这位天才射手本可以在本届世界杯上大放异彩。",
          "pinyin": "Yàobúshì tūrúqílái de shāngbìng kùnrǎo, zhè wèi tiāncái shèshǒu běn kěyǐ zài běn jiè shìjièbēi shang dàfàngyìcǎi.",
          "translation_vi": "Nếu không vì chấn thương bất ngờ ập đến quấy rầy, tay săn bàn thiên tài này vốn dĩ đã có thể tỏa sáng rực rỡ tại kỳ World Cup lần này.",
          "explanation": "\"要不是...本可以...\" bày tỏ niềm tiếc nuối vô hạn cho sự nghiệp của vận động viên tài năng."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 64,
      "name": "Liên từ mục đích phòng ngừa hậu quả xấu \"以免\" (Để tránh / Kẻo)",
      "pattern": "Biện pháp phòng ngừa tích cực, 以免 + Hậu quả tiêu cực phát sinh",
      "category": "Liên từ",
      "explanation_vi": "\"以免\" (yǐmiǎn) là liên từ chỉ mục đích trong văn viết, đứng ở vế sau để nêu ra một kết quả xấu hoặc tình huống bất lợi mà người nói muốn ngăn ngừa, phòng tránh (để tránh, kẻo). Vế trước luôn là một hành động, biện pháp cẩn trọng được tiến hành chủ động.",
      "examples": [
        {
          "chinese": "请大家在离开实验室前仔细关好水电设备，以免发生火灾等安全事故。",
          "pinyin": "Qǐng dàjiā zài líkāi shíyànshì qián zǐxì guān hǎo shuǐdiàn shèbèi, yǐmiǎn fāshēng huǒzāi děng ānquán shìgù.",
          "translation_vi": "Xin mọi người trước khi rời phòng thí nghiệm hãy tắt cẩn thận các thiết bị điện nước, để tránh xảy ra sự cố an toàn hỏa hoạn.",
          "explanation": "\"以免发生火灾\" nêu rõ mục đích an toàn của hành động kiểm tra thiết bị trước khi ra về."
        },
        {
          "chinese": "重要文件请务必保存在云端并备份，以免因电脑硬盘损坏而丢失数据。",
          "pinyin": "Zhòngyào wénjiàn qǐng wùbì bǎocún zài yúnduān bìng bèifèn, yǐmiǎn yīn diànnǎo yìngpán sǔnhuài ér diūshī shùjù.",
          "translation_vi": "Tài liệu quan trọng xin hãy nhớ lưu trữ trên đám mây và sao lưu dự phòng, kẻo mất dữ liệu do ổ cứng máy tính bị hỏng hóc.",
          "explanation": "\"以免...丢失数据\" chỉ rõ rủi ro mất tài liệu cần phòng ngừa bằng giải pháp sao lưu đám mây."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 65,
      "name": "Liên từ khẩu ngữ phòng ngừa phiền toái \"免得\" (Để đỡ phải / Kẻo mà)",
      "pattern": "Hành vi chuẩn bị trước, 免得 + Phiền hà / Rắc rối phát sinh",
      "category": "Liên từ",
      "explanation_vi": "\"免得\" (miǎnde) là dạng khẩu ngữ sinh động của \"以免\", mang ý nghĩa làm trước một việc chu đáo để sau này đỡ phải tốn công giải quyết phiền toái, rắc rối (để đỡ phải, kẻo mà).",
      "examples": [
        {
          "chinese": "明天去露营你最好多带一件厚外套，免得晚上山顶起风着凉感冒。",
          "pinyin": "Míngtiān qù lùyíng nǐ zuì hǎo duō dài yí jiàn hòu wàitào, miǎnde wǎnshang shāndǐng qǐfēng zháoliáng gǎnmào.",
          "translation_vi": "Ngày mai đi cắm trại cậu tốt nhất hãy mang thêm một chiếc áo khoác dày, để đỡ bị nhiễm lạnh cảm cúm khi đỉnh núi nổi gió về đêm.",
          "explanation": "\"免得...着凉感冒\" nhắc nhở người bạn mang thêm áo ấm phòng ngừa bị ốm khi đi chơi xa."
        },
        {
          "chinese": "出门前把钥匙和门禁卡放进固定口袋里，免得到处翻找耽误时间。",
          "pinyin": "Chūmén qián bǎ yàoshi hé ménjìnkǎ fàngjìn gùdìng kǒudài lǐ, miǎnde dàochù fānzhǎo dānwù shíjiān.",
          "translation_vi": "Trước khi ra khỏi nhà hãy cất chìa khóa và thẻ từ vào túi cố định, để khỏi phải lục lọi khắp nơi làm lỡ dở thời gian.",
          "explanation": "\"免得到处翻找\" khuyên nhủ thói quen ngăn nắp để tránh lãng phí thời gian tìm kiếm."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 66,
      "name": "Liên từ tiết kiệm công sức và chi phí \"省得\" (Để đỡ / Đỡ tốn công / Khỏi phải)",
      "pattern": "Lựa chọn phương án tiện lợi, 省得 + Tốn công/tốn tiền/mệt mỏi",
      "category": "Liên từ",
      "explanation_vi": "\"省得\" (shěngde) kết hợp chữ \"省\" (tiết kiệm, đỡ tốn) mang nghĩa \"nhằm tránh phát sinh thêm chi phí, sức lực, thời gian hoặc sự mệt mỏi không cần thiết\" (để đỡ tốn công, đỡ mất tiền, khỏi phải). Mang sắc thái khẩu ngữ dân dã, thực tế.",
      "examples": [
        {
          "chinese": "咱们今天就在手机上买好返程的高铁票吧，省得到时候火车站窗口排长队。",
          "pinyin": "Zánmen jīntiān jiù zài shǒujī shang mǎihǎo fǎnchéng de gāotiěpiào ba, shěngde dào shíhou huǒchēzhàn chuāngkǒu pái cháng duì.",
          "translation_vi": "Chúng ta hôm nay mua sẵn vé tàu cao tốc lượt về trên điện thoại luôn đi, để đỡ phải xếp hàng dài ở quầy vé nhà ga lúc đó.",
          "explanation": "\"省得到时候...排长队\" giải thích lợi ích tiết kiệm thời gian chờ đợi nhờ mua vé online."
        },
        {
          "chinese": "有什么话当面一次性说清楚，省得日后大家在背地里互相猜疑。",
          "pinyin": "Yǒu shénme huà dāngmiàn yícìxìng shuō qīngchu, shěngde rìhòu dàjiā zài bèidìlǐ hùxiāng cāiyí.",
          "translation_vi": "Có chuyện gì hãy nói rõ ràng thẳng thắn một lần trước mặt nhau, để đỡ phải ngày sau mọi người nghi kỵ lẫn nhau sau lưng.",
          "explanation": "\"省得日后...互相猜疑\" khuyên giải giao tiếp minh bạch để tránh mâu thuẫn nội bộ về sau."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 67,
      "name": "Liên từ mục đích tạo thuận lợi tích cực \"以便\" (Để tiện / Nhằm tạo điều kiện)",
      "pattern": "Chuẩn bị điều kiện thuận lợi, 以便 + Hành vi tiếp theo tiến hành dễ dàng",
      "category": "Liên từ",
      "explanation_vi": "\"以便\" (yǐbiàn) là liên từ mục đích tích cực trong văn bản hành chính, thương mại và giao dịch (kết hợp 以: để, 便: thuận tiện). Vế trước tạo ra tiền đề, cung cấp thông tin hoặc công cụ; vế sau dùng \"以便\" để chỉ rõ mục đích tạo sự dễ dàng, thuận lợi cho hành động tiếp theo (để tiện cho việc, nhằm giúp cho).",
      "examples": [
        {
          "chinese": "请各位参会代表务必在签到表上留下手机号，以便会务组随时通知最新议程。",
          "pinyin": "Qǐng gèwèi cānhuì dàibiǎo wùbì zài qiāndàobiǎo shang liúxià shǒujīhào, yǐbiàn huìwùzǔ suíshí tōngzhī zuìxīn yìchéng.",
          "translation_vi": "Xin các vị đại biểu tham dự hội nghị nhất thiết hãy để lại số điện thoại trên bảng điểm danh, để tiện cho ban tổ chức hội vụ thông báo lịch trình mới nhất bất cứ lúc nào.",
          "explanation": "\"以便会务组随时通知...\" nêu rõ mục đích thu thập số điện thoại nhằm phục vụ liên lạc thông suốt."
        },
        {
          "chinese": "公司在官网上发布了详细的操作视频教程，以便新用户快速上手使用软件。",
          "pinyin": "Gōngsī zài guānwǎng shang fābù le xiángxì de cāozuò shìpín jiàochéng, yǐbiàn xīn yònghù kuàisù shàngshǒu shǐyòng ruǎnjiàn.",
          "translation_vi": "Công ty đã đăng tải video hướng dẫn thao tác chi tiết trên trang web chính thức, để người dùng mới tiện làm quen sử dụng phần mềm nhanh chóng.",
          "explanation": "\"以便新用户快速上手...\" thể hiện tôn chỉ thiết kế dịch vụ hỗ trợ khách hàng thuận tiện."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 68,
      "name": "Liên từ chỉ hệ quả tiêu cực nghiêm trọng \"以致\" (Dẫn đến / Gây ra hậu quả)",
      "pattern": "Nguyên nhân sai lầm/sơ suất, 以致(于) + Hậu quả xấu nghiêm trọng",
      "category": "Liên từ",
      "explanation_vi": "\"以致\" (yǐzhì) là liên từ nối kết quả bắt buộc phải là một kết cục xấu, một thất bại, tổn thất hoặc tình huống đáng tiếc xảy ra do nguyên nhân ở vế trước gây nên (dẫn đến hậu quả, làm cho, đến nỗi). Tuyệt đối không dùng \"以致\" cho các kết quả tốt đẹp hay thành công.",
      "examples": [
        {
          "chinese": "项目负责人在前期论证中严重低估了施工难度，以致整个工程延期了半年之久。",
          "pinyin": "Xiàngmù fùzérén zài qiánqī lùnzhèng zhōng yánzhòng dīgū le shīgōng nándù, yǐzhì zhěng gè gōngchéng yánqī le bàn nián zhī jiǔ.",
          "translation_vi": "Người phụ trách dự án trong khâu kiểm định ban đầu đã đánh giá quá thấp độ khó thi công, dẫn đến toàn bộ công trình bị chậm tiến độ tới nửa năm ròng.",
          "explanation": "\"以致整个工程延期...\" chỉ rõ hậu quả đình trệ công trình do sai lầm đánh giá chủ quan gây ra."
        },
        {
          "chinese": "他在平时工作中马虎大意屡教不改，以致酿成了一起重大的生产安全责任事故。",
          "pinyin": "Tā zài píngshí gōngzuò zhōng mǎhudàyì lǚjiàobùgǎi, yǐzhì niàngchéng le yì qǐ zhòngdà de shēngchǎn ānquán zérèn shìgù.",
          "translation_vi": "Anh ta trong công việc hằng ngày làm việc cẩu thả nhắc nhở mãi không sửa, đến nỗi đã gây ra một vụ tai nạn trách nhiệm an toàn sản xuất nghiêm trọng.",
          "explanation": "\"以致酿成了...事故\" liên kết tính cẩu thả với hậu quả tai nạn lao động đau lòng."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 69,
      "name": "Liên từ chỉ mức độ cực đại hoặc phạm vi phát triển \"以至 / 以至于\" (Đến mức / Đến nỗi / Cho tới tận)",
      "pattern": "Mức độ tăng cao, 以至(于) + Đạt tới mức độ phi thường / Mở rộng phạm vi",
      "category": "Liên từ",
      "explanation_vi": "\"以至\" hoặc \"以至于\" (yǐzhìyú) biểu thị mức độ, số lượng, thời gian hoặc phạm vi sự vật phát triển sâu rộng, mở rộng liên tục cho tới khi đạt tới một mốc giới hạn phi thường nào đó (đến mức mà, cho tới tận). Kết quả sau \"以至\" có thể là trung tính, tích cực hoặc tiêu cực.",
      "examples": [
        {
          "chinese": "这本历史小说的人物塑造极其生动，以至于读者们常常把虚构人物当作真人。",
          "pinyin": "Zhè běn lìshǐ xiǎoshuō de rénwù sùzào jíqí shēngdòng, yǐzhìyú dúzhěmen chángcháng bǎ xūgòu rénwù dàngzuò zhēnrén.",
          "translation_vi": "Việc xây dựng nhân vật của cuốn tiểu thuyết lịch sử này sống động đến mức độc giả thường coi nhân vật hư cấu như người thật ngoài đời.",
          "explanation": "\"以至于读者们常常...\" ca ngợi bút pháp khắc họa nhân vật đạt tới đỉnh cao nghệ thuật lôi cuốn."
        },
        {
          "chinese": "现代数字技术已经深度渗透到工业、农业、以至普通百姓日常生活的方方面面。",
          "pinyin": "Xiàndài shùzì jìshù yǐjīng shēndù shèntòu dào gōngyè, nóngyè, yǐzhì pǔtōng bǎixìng rìcháng shēnghuó de fāngfāngmiànmiàn.",
          "translation_vi": "Công nghệ số hiện đại đã thâm nhập sâu rộng vào công nghiệp, nông nghiệp, cho tới tận mọi ngóc ngách đời sống thường nhật của người dân bình thường.",
          "explanation": "\"以至...\" mở rộng phạm vi ứng dụng từ các ngành sản xuất lớn đến tận đời sống sinh hoạt dân sinh."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 70,
      "name": "Phân biệt kinh điển chuẩn mực thi cử: \"以致\" vs \"以至 / 以至于\"",
      "pattern": "以致 (Chỉ dùng cho Hậu quả xấu/thất bại) vs 以至/以至于 (Chỉ Mức độ cực hạn hoặc Mở rộng phạm vi)",
      "category": "Liên từ",
      "explanation_vi": "Quy tắc phân biệt vàng trong HSK 5: 1) \"以致\" (chữ 致 mang nghĩa dẫn tới hậu quả) CHỈ DÙNG khi vế sau là kết cục tiêu cực, sai sót, thất bại, tổn hại (không bao giờ dùng cho điều tốt); 2) \"以至 / 以至于\" (chữ 至 mang nghĩa đạt tới mốc) dùng khi biểu thị sự nâng cao về mức độ (đến mức mà...) hoặc sự nối dài về phạm vi thời gian, không gian, đối tượng (từ A đến B cho tới tận C).",
      "examples": [
        {
          "chinese": "因为准备工作极其充分，以至于整个发布会进行得异常顺利。",
          "pinyin": "Yīnwèi zhǔnbèi gōngzuò jíqí chōngfèn, yǐzhìyú zhěng gè fābùhuì jìnxíng de yìcháng shùnlì.",
          "translation_vi": "Bởi vì công tác chuẩn bị cực kỳ chu đáo, đến mức toàn bộ buổi họp báo diễn ra suôn sẻ lạ thường.",
          "explanation": "Kết quả tốt đẹp (\"顺利\") bắt buộc phải dùng \"以至于\", tuyệt đối không được dùng \"以致\"."
        },
        {
          "chinese": "司机疲劳驾驶注意力涣散，以致车辆失控撞上了路边的护栏。",
          "pinyin": "Sījī píláo jiàshǐ zhùyìlì huànsàn, yǐzhì chēliàng shīkòng zhuàngshàng le lùbiān de hùlán.",
          "translation_vi": "Tài xế lái xe trong tình trạng mệt mỏi mất tập trung, dẫn đến chiếc xe mất lái đâm vào dải phân cách ven đường.",
          "explanation": "Hậu quả tai nạn giao thông nghiêm trọng bắt buộc dùng \"以致\"."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 71,
      "name": "Cụm liên từ suy luận logic từ hiện thực \"既然如此\" (Đã như vậy / Trong tình thế đó)",
      "pattern": "Sự thật đã được xác nhận. 既然如此, (那么) Chủ ngữ + Nên/Sẽ + Quyết định",
      "category": "Liên từ",
      "explanation_vi": "\"既然如此\" (jìrán rúcǐ) là cụm liên từ độc lập đứng đầu câu, dùng khi một tình huống, thực tế hoặc quan điểm vừa được phân tích và cả hai bên đều đã công nhận tính xác thực của nó, từ đó dẫn ra kết luận hoặc quyết sách hợp lý tiếp theo (đã là như thế thì, trong bối cảnh đó).",
      "examples": [
        {
          "chinese": "双方在价格条款上已经无法达成一致，既然如此，我们不如暂时终止本次谈判。",
          "pinyin": "Shuāngfāng zài jiàgé tiáokuǎn shang yǐjīng wúfǎ dáchéng yízhì, jìrán rúcǐ, wǒmen bùrú zànshí zhōngzhǐ běn cì tánpàn.",
          "translation_vi": "Đôi bên trên điều khoản giá cả đã không thể đạt được sự nhất trí, đã như vậy, chúng ta chi bằng hãy tạm dừng cuộc đàm phán lần này lại.",
          "explanation": "\"既然如此\" thừa nhận sự bế tắc trong đàm phán giá cả để đưa ra giải pháp tạm hoãn thông minh."
        },
        {
          "chinese": "天气预报显示暴风雪即将来临，既然如此，原定的登山拉练计划只能取消了。",
          "pinyin": "Tiānqì yùbào xiǎnshì bàofēngxuě jíjiāng láilín, jìrán rúcǐ, yuándìng de dēngshān lāliàn jìhuà zhǐ néng qǔxiāo le.",
          "translation_vi": "Dự báo thời tiết cho thấy bão tuyết sắp ập tới, đã là như vậy thì kế hoạch rèn luyện leo núi định sẵn chỉ đành phải hủy bỏ thôi.",
          "explanation": "\"既然如此\" làm bản lề chuyển tiếp từ tin tức bão tuyết sang quyết định hủy chuyến đi an toàn."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 72,
      "name": "Cấu trúc lựa chọn chủ quan tự nguyện \"宁愿...也不...\" (Thà rằng... chứ không...)",
      "pattern": "Chủ ngữ + 宁愿 + Phương án chịu khổ/hy sinh, 也不 / 决不 + Phương án vi phạm nhân cách",
      "category": "Liên từ",
      "explanation_vi": "\"宁愿...也不...\" (nìngyuàn... yě bù...) tương tự như \"宁可...也不...\", nhưng nhấn mạnh hơn nữa ý chí chủ quan, nguyện vọng tha thiết từ đáy lòng của chủ thể (tự nguyện thà rằng chọn con đường gian nan, chứ quyết không chấp nhận điều trái với lương tâm).",
      "examples": [
        {
          "chinese": "老艺术家宁愿过着清贫的生活，也绝不肯为了迎合低俗市场而粗制滥造作品。",
          "pinyin": "Lǎo yìshùjiā nìngyuàn guòzhe qīngpín de shēnghuó, yě jué bù kěn wèile yínghé dīsú shìchǎng ér cūzhìlànzào zuòpǐn.",
          "translation_vi": "Người nghệ sĩ già thà rằng sống cuộc đời thanh bần, chứ quyết không chịu vì hùa theo thị hiếu thị trường tầm thường mà sản xuất tác phẩm cẩu thả bừa bãi.",
          "explanation": "\"宁愿...也绝不肯...\" khắc họa khí tiết thanh cao và lương tâm sáng tạo của người làm nghệ thuật chân chính."
        },
        {
          "chinese": "很多年轻人宁愿留在大城市里承受巨大的竞争压力，也不愿意回到安逸的小县城。",
          "pinyin": "Hěn duō niánqīngrén nìngyuàn liú zài dà chéngshì lǐ chéngshòu jùdà de jìngzhēng yālì, yě bú yuànyì huídào ānyì de xiǎo xiànchéng.",
          "translation_vi": "Rất nhiều người trẻ thà rằng ở lại thành phố lớn chịu đựng áp lực cạnh tranh khổng lồ, chứ không cam lòng quay về thị trấn nhỏ an phận êm đềm.",
          "explanation": "\"宁愿...也不愿意...\" phản ánh khát vọng vươn lên tìm kiếm cơ hội bứt phá của thanh niên hiện đại."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 73,
      "name": "Cấu trúc định nghĩa chính xác bản chất \"与其说...不如说...\" (Thay vì nói là... đúng hơn là nói...)",
      "pattern": "与其说 A, 不如说 B (B mới là cách mô tả chính xác thực chất của vấn đề)",
      "category": "Liên từ",
      "explanation_vi": "\"与其说...不如说...\" (yǔqí shuō... bùrú shuō...) dùng để điều chỉnh lại cách hiểu hoặc cách diễn đạt chưa thật sự chuẩn xác về một sự việc: vế trước nêu cách nhìn bề ngoài thông thường (A), vế sau khẳng định cách nhìn (B) mới phản ánh đúng bản chất chân thực, sâu sắc nhất của sự vật.",
      "examples": [
        {
          "chinese": "这件精美的艺术品与其说是商品，不如说是一位民间大师倾注毕生心血的灵魂结晶。",
          "pinyin": "Zhè jiàn jīngměi de yìshùpǐn yǔqí shuō shì shāngpǐn, bùrú shuō shì yí wèi mínjiān dàshī qīngzhù bìshēng xīnxuè de línghún jiéjīng.",
          "translation_vi": "Tác phẩm nghệ thuật tinh xảo này thay vì nói là một món hàng hóa, đúng hơn nên nói là sự kết tinh tâm hồn mà một bậc thầy dân gian đã dồn trọn tâm huyết cả đời vào đó.",
          "explanation": "\"与其说是商品，不如说...\" nâng tầm giá trị của tác phẩm từ góc độ thương mại lên tầm vóc kiệt tác văn hóa."
        },
        {
          "chinese": "这次团队的成功与其说是依靠好运气，不如说是全体成员多年默默坚持的必然结果。",
          "pinyin": "Zhè cì tuánduì de chénggōng yǔqí shuō shì yīkào hǎo yùnqi, bùrú shuō shì quántǐ chéngyuán duō nián mòmò jiānchí de bìrán jiéguǒ.",
          "translation_vi": "Thành công của đội ngũ lần này thay vì nói là nhờ vào vận may tốt, đúng hơn nên nói là kết quả tất yếu của sự kiên trì âm thầm suốt nhiều năm của toàn thể thành viên.",
          "explanation": "\"与其说是...不如说是...\" bác bỏ yếu tố may rủi để khẳng định chân lý của sự khổ luyện bền bỉ."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 74,
      "name": "Liên từ tăng tiến chính luận đa diện \"不单...而且/并且...\" (Không chỉ... mà còn...)",
      "pattern": "Chủ ngữ + 不单...而且 / 并且 / 甚至 + Vị ngữ",
      "category": "Liên từ",
      "explanation_vi": "\"不单\" (bùdān) đồng nghĩa với \"不仅\" và \"不但\", nhưng trong văn phong HSK 5 thường xuất hiện trong các bài bình luận xã hội hoặc diễn thuyết kinh tế để liên kết các vế câu có tính chất bổ trợ đa chiều và nâng tầm tính chất của vấn đề.",
      "examples": [
        {
          "chinese": "这项教育改革不单关系到千家万户的切身利益，并且直接影响到国家未来人才的储备。",
          "pinyin": "Zhè xiàng jiàoyù gǎigé bùdān guānxì dào qiānjiāwànhù de qiēshēn lìyì, bìngqiě zhíjiē yǐngxiǎng dào guójiā wèilái réncái de chǔbèi.",
          "translation_vi": "Cuộc cải cách giáo dục này không chỉ liên quan tới lợi ích thiết thân của hàng vạn gia đình, mà còn trực tiếp ảnh hưởng tới nguồn dự trữ nhân tài tương lai của đất nước.",
          "explanation": "\"不单...并且...\" nâng tầm ảnh hưởng từ cấp độ hộ gia đình lên quy mô chiến lược quốc gia."
        },
        {
          "chinese": "他待人接物不单谦虚有礼，并且在专业业务领域表现出了极高的领悟力。",
          "pinyin": "Tā dàirénjiēwù bùdān qiānxū yǒulǐ, bìngqiě zài zhuānyè yèwù lǐngyù biǎoxiàn chū le jí gāo de lǐngwùlì.",
          "translation_vi": "Anh ấy đối nhân xử thế không chỉ khiêm nhường lễ độ, mà còn thể hiện khả năng lĩnh hội cực kỳ cao trong lĩnh vực nghiệp vụ chuyên môn.",
          "explanation": "\"不单...并且...\" ca ngợi toàn diện cả về phẩm chất đạo đức lẫn tài năng trí tuệ của nhân vật."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 75,
      "name": "Cụm liên từ nối chuyển tiếp đoạn văn \"不仅如此\" (Chẳng những vậy / Không những thế)",
      "pattern": "Đoạn văn 1. 不仅如此, Đoạn văn 2 (bổ sung luận cứ/thành tựu tầng cao hơn)",
      "category": "Liên từ",
      "explanation_vi": "\"不仅如此\" (bùjǐn rúcǐ) là cụm từ chuyển tiếp đoạn văn quan trọng bậc nhất trong văn nghị luận HSK 5. Nó đứng ở đầu câu hoặc đầu đoạn văn mới để tổng kết và thừa nhận toàn bộ thành tựu/hiện tượng ở đoạn trước, sau đó mở ra một tầng nghĩa còn quan trọng hoặc chấn động hơn nữa ở đoạn sau.",
      "examples": [
        {
          "chinese": "该项新技术大幅度提高了生产效率。不仅如此，它还彻底解决了高能耗污染的难题。",
          "pinyin": "Gāi xiàng xīn jìshù dàfúdù tígāo le shēngchǎn xiàolǜ. Bùjǐn rúcǐ, tā hái chèdǐ jiějué le gāo nénghào wūrǎn de nándí.",
          "translation_vi": "Công nghệ mới này đã nâng cao mạnh mẽ hiệu suất sản xuất. Chẳng những thế, nó còn giải quyết triệt để bài toán khó về ô nhiễm tiêu hao năng lượng cao.",
          "explanation": "\"不仅如此\" chuyển tiếp mượt mà từ thành tựu năng suất sang cống hiến bảo vệ môi trường sinh thái."
        },
        {
          "chinese": "这位青年志愿者经常无偿献血。不仅如此，他还利用业余时间长期义务照顾社区里的孤寡老人。",
          "pinyin": "Zhè wèi qīngnián zhìyuànzhě jīngcháng wúcháng xiànxiè. Bùjǐn rúcǐ, tā hái lìyòng yèyú shíjiān chángqī yìwù zhàogù shèqū lǐ de gūguǎ lǎorén.",
          "translation_vi": "Chàng thanh niên tình nguyện viên này thường xuyên hiến máu nhân đạo miễn phí. Không những thế, anh còn tận dụng thời gian rảnh rỗi chăm sóc thiện nguyện lâu dài các cụ già neo đơn trong khu dân cư.",
          "explanation": "\"不仅如此\" tôn vinh liên hoàn các nghĩa cử cao đẹp vì cộng đồng của tấm gương thanh niên tốt."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 76,
      "name": "Cụm liên từ khẳng định quyết tâm tuyệt đối \"无论如何\" (Bất luận thế nào / Dù sao đi nữa)",
      "pattern": "无论如何, 主语 + 都要 / 也不能 + Vị ngữ",
      "category": "Liên từ",
      "explanation_vi": "\"无论如何\" (wúlùn rúhé) là cụm phó từ/liên từ đứng độc lập ở đầu câu hoặc trước động từ, biểu thị trong bất kỳ tình huống, điều kiện hoặc trước bất kỳ trở ngại nào đi chăng nữa thì một nghĩa vụ, nguyên tắc hoặc quyết tâm bắt buộc phải được thực hiện (dù thế nào đi nữa, bằng mọi giá).",
      "examples": [
        {
          "chinese": "这次任务事关重大，无论如何我们都要在明天天亮之前赶到指定地点集结。",
          "pinyin": "Zhè cì rènwu shìguān zhòngdà, wúlùn rúhé wǒmen dōu yào zài míngtiān tiānliàng zhīqián gǎndào zhǐdìng dìdiǎn jíjié.",
          "translation_vi": "Nhiệm vụ lần này vô cùng trọng đại, bất luận thế nào chúng ta cũng phải có mặt tập kết tại địa điểm chỉ định trước khi trời sáng mai.",
          "explanation": "\"无论如何...都要...\" thể hiện mệnh lệnh quân sự khẩn cấp bắt buộc phải hoàn thành đúng giờ bằng mọi giá."
        },
        {
          "chinese": "无论如何，你都绝不能把这一份涉及客户核心商业隐私的数据泄露出去。",
          "pinyin": "Wúlùn rúhé, nǐ dōu jué bù néng bǎ zhè yí fèn shèjí kèhù héxīn shāngyè yǐnsī de shùjù xièlòu chūqù.",
          "translation_vi": "Dù trong bất kỳ hoàn cảnh nào, cậu cũng tuyệt đối không được để lộ phần dữ liệu liên quan tới bí mật thương mại cốt lõi của khách hàng này ra ngoài.",
          "explanation": "\"无论如何...绝不能...\" là lời răn đe nghiêm khắc về trách nhiệm bảo mật thông tin tối mật."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 77,
      "name": "Cấu trúc giả thiết mốc thời khắc biến đổi \"一旦...就...\" (Một khi... thì...)",
      "pattern": "一旦 + Thời khắc điều kiện kích hoạt, 主语 + 就 + Chuỗi hệ quả tất yếu",
      "category": "Liên từ",
      "explanation_vi": "\"一旦...就...\" (yídàn... jiù...) dùng để chỉ ra một thời điểm hoặc điều kiện mang tính bước ngoặt: \"một khi\" sự việc đó xảy ra thì nó sẽ lập tức kích hoạt một chuỗi phản ứng hoặc hệ quả tất yếu khó lòng cứu vãn hoặc làm thay đổi hoàn toàn cục diện ban đầu.",
      "examples": [
        {
          "chinese": "信誉是企业的生命线，一旦失去客户的信任，想要重新建立就难如登天。",
          "pinyin": "Xìnyù shì qǐyè de shēngmìngxiàn, yídàn shīqù kèhù de xìnrèn, xiǎng yào chóngxīn jiànlì jiù nánrúdēngtiān.",
          "translation_vi": "Uy tín là sinh mệnh của doanh nghiệp, một khi đánh mất niềm tin của khách hàng thì muốn gầy dựng lại sẽ khó như lên trời.",
          "explanation": "\"一旦失去...就难如登天\" cảnh báo cái giá quá đắt của việc đánh mất chữ tín thương trường."
        },
        {
          "chinese": "这项前沿技术一旦实现商业化量产，就将彻底颠覆现有的传统能源工业格局。",
          "pinyin": "Zhè xiàng qiányán jìshù yídàn shíxiàn shāngyèhuà liàngchǎn, jiù jiāng chèdǐ diānfù xiànyǒu de chuántǒng néngyuán gōngyè géjú.",
          "translation_vi": "Công nghệ tiên phong này một khi thực hiện được sản xuất thương mại hàng loạt thì sẽ đảo lộn hoàn toàn cục diện công nghiệp năng lượng truyền thống hiện có.",
          "explanation": "\"一旦实现...就将彻底颠覆...\" dự báo bước ngoặt cách mạng công nghiệp khi công nghệ mới được thương mại hóa."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 78,
      "name": "Cấu trúc quy nạp lập trường dứt khoát \"不管...总之...\" (Bất kể... tóm lại là...)",
      "pattern": "不管 + Các tình huống giả thiết phức tạp, 总之 + Kết luận quy nạp cốt lõi",
      "category": "Liên từ",
      "explanation_vi": "\"不管...总之...\" (bùguǎn... zǒngzhī...) dùng khi vế trước liệt kê hàng loạt các điều kiện hoặc khả năng có thể phát sinh, vế sau dùng \"总之\" để gạt bỏ các yếu tố rườm rà nhằm đưa ra một nguyên tắc, thái độ hoặc kết luận cốt lõi, bất biến duy nhất (bất kể thế nào, tóm lại là).",
      "examples": [
        {
          "chinese": "不管前方的道路有多少未知挑战，总之我们既然出发了就绝没有后退的道理。",
          "pinyin": "Bùguǎn qiánfāng de dàolù yǒu duōshao wèizhī tiǎozhàn, zǒngzhī wǒmen jìrán chūfā le jiù jué méiyǒu hòutuì de dàolǐ.",
          "translation_vi": "Bất kể con đường phía trước có bao nhiêu thử thách chưa biết, tóm lại chúng ta đã xuất phát rồi thì tuyệt đối không có đạo lý lùi bước.",
          "explanation": "\"不管...总之...\" khẳng định ý chí quyết tâm sắt đá không hề lay chuyển trước khó khăn."
        },
        {
          "chinese": "不管别人在私底下如何议论，总之把自己的本职工作做好才是立足的根本。",
          "pinyin": "Bùguǎn biérén zài sīdǐxia rúhé yìlùn, zǒngzhī bǎ zìjǐ de běnzhí gōngzuò zuò hǎo cái shì lìzú de gēnběn.",
          "translation_vi": "Bất kể người khác bàn tán sau lưng như thế nào, tóm lại làm tốt công việc bổn phận của mình mới là gốc rễ để đứng vững.",
          "explanation": "\"总之...\" đúc kết kinh nghiệm sống thực tế: tập trung vào chuyên môn thay vì bận tâm thị phi bên ngoài."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 79,
      "name": "Cấu trúc điều kiện duy nhất văn ngôn trang nghiêm \"唯有...方能...\" (Duy chỉ có... mới có thể...)",
      "pattern": "唯有 + Con đường/Điều kiện tiên quyết duy nhất, 方能 + Đạt được thành tựu vĩ đại",
      "category": "Liên từ",
      "explanation_vi": "\"唯有...方能...\" (wéiyǒu... fāngnéng...) là cấu trúc văn ngôn cao cấp tương đương với \"只有...才能...\", nhưng mang âm hưởng hùng tráng, nghiêm cẩn và triết lý sâu sắc (duy chỉ có... mới có thể). \"唯\" nghĩa là duy nhất; \"方\" nghĩa là mới (cái). Thường xuất hiện trong các bài phát biểu nguyên thủ, tuyên ngôn lý tưởng.",
      "examples": [
        {
          "chinese": "唯有勇于直面自身的不足并坚持改革创新，一个民族方能始终屹立于世界民族之林。",
          "pinyin": "Wéiyǒu yǒngyú zhímiàn zìshēn de bùzú bìng jiānchí gǎigé chuàngxīn, yí gè mínzú fāngnéng shǐzhōng yìlì yú shìjiè mínzú zhī lín.",
          "translation_vi": "Duy chỉ có dũng cảm đối mặt với những thiếu sót của bản thân và kiên trì đổi mới sáng tạo, một dân tộc mới có thể luôn luôn đứng vững hiên ngang trong hàng ngũ các dân tộc trên thế giới.",
          "explanation": "\"唯有...方能...\" diễn đạt tư tưởng chính trị tầm vóc lịch sử về sức sống trường tồn của một quốc gia."
        },
        {
          "chinese": "唯有经历过狂风暴雨的无情洗礼，雄鹰方能展翅翱翔于高远的天际。",
          "pinyin": "Wéiyǒu jīnglìguo kuángfēngbàoyǔ de wúqíng xǐlǐ, xióngyīng fāngnéng zhǎnchì áoxiáng yú gāoyuǎn de tiānjì.",
          "translation_vi": "Duy chỉ có trải qua sự tôi luyện gội rửa không tình cảm của mưa giông bão táp, chim ưng mới có thể tung cánh chao lượn trên bầu trời cao rộng.",
          "explanation": "\"唯有...方能...\" dùng hình tượng chim ưng vượt qua bão táp làm ẩn dụ cho sự thành tài qua gian khó."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 80,
      "name": "Cấu trúc thừa nhận hai thuộc tính song hành \"固然...也...\" (Đành rằng... nhưng cũng...)",
      "pattern": "Khía cạnh A 固然... (hợp lý), (但是) Khía cạnh B 也... (không thể xem nhẹ)",
      "category": "Liên từ",
      "explanation_vi": "\"固然...也...\" (gùrán... yě...) biểu thị sự thừa nhận một phương diện khách quan là có thật hoặc hợp lý, đồng thời khẳng định phương diện còn lại cũng tồn tại song hành và quan trọng không kém (đành rằng như thế, nhưng cái kia cũng...). Dùng để lập luận biện chứng tránh sự phiến diện.",
      "examples": [
        {
          "chinese": "追求经济效益固然必不可少，但维护生态平衡也绝不容丝毫懈怠。",
          "pinyin": "Zhuīqiú jīngjì xiàoyì gùrán bìbùkěshǎo, dàn wéihù shēngtài pínghéng yě jué bùróng sīháo xièdài.",
          "translation_vi": "Mưu cầu lợi ích kinh tế đành rằng là điều tất yếu không thể thiếu, nhưng bảo vệ cân bằng sinh thái cũng tuyệt đối không cho phép buông lỏng lơ là mảy may.",
          "explanation": "\"固然...也...\" cân bằng hài hòa giữa bài toán phát triển kinh tế và bảo vệ môi trường tự nhiên."
        },
        {
          "chinese": "严格的管理规章固然能够保障工作秩序，但充满人文关怀的沟通也同样必不可少。",
          "pinyin": "Yángé de guǎnlǐ guīzhāng gùrán nénggòu bǎozhàng gōngzuò zhìxù, dàn chōngmǎn rénwén guānhuái de gōutōng yě tóngyàng bìbùkěshǎo.",
          "translation_vi": "Quy chế quản lý nghiêm ngặt đành rằng có thể bảo đảm trật tự làm việc, nhưng sự giao tiếp chan chứa tình cảm quan tâm con người cũng cần thiết không kém.",
          "explanation": "\"固然...也...\" kết hợp nghệ thuật quản lý giữa kỷ cương thép và tình yêu thương."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 81,
      "name": "Cụm liên từ chính sách tổng kết bối cảnh \"有鉴于此\" (Nhận thấy điều đó / Xét thấy tình hình này)",
      "pattern": "Phân tích bối cảnh/nguy cơ. 有鉴于此, Cơ quan/Chủ thể + Quyết định đưa ra giải pháp",
      "category": "Liên từ",
      "explanation_vi": "\"有鉴于此\" (yǒu jiàn yú cǐ) là cụm liên từ hành chính cao cấp đứng đầu câu kết luận, có nghĩa là \"sau khi đã xem xét và đánh giá đầy đủ tình hình/nguy cơ vừa nêu ở trên, xuất phát từ thực tế đó\". Đây là cấu trúc tiêu chuẩn mở đầu cho các nghị quyết hoặc phương án xử lý khủng hoảng.",
      "examples": [
        {
          "chinese": "近期网络诈骗手段不断翻新且隐蔽性极高。有鉴于此，公安部门紧急升级了反诈预警系统。",
          "pinyin": "Jìnqī wǎngluò zhàpiàn shǒuduàn búduàn fānxīn qiě yǐnbìxìng jí gāo. Yǒujiànyúcǐ, gōng'ān bùmén jǐnjí shēngjí le fǎnzhà yùjǐng xìtǒng.",
          "translation_vi": "Thời gian gần đây thủ đoạn lừa đảo qua mạng liên tục biến tướng và có tính ẩn giấu cực kỳ cao. Nhận thấy tình hình đó, cơ quan công an đã khẩn cấp nâng cấp hệ thống cảnh báo chống lừa đảo.",
          "explanation": "\"有鉴于此\" là mắt xích liên kết giữa thủ đoạn tội phạm tinh vi với giải pháp kỹ thuật nâng cấp an ninh."
        },
        {
          "chinese": "老龄化社会的到来对医疗照护体系提出了全新挑战。有鉴于此，市政府出台了居家养老补贴政策。",
          "pinyin": "Lǎolínghuà shèhuì de dàolái duì yīliáo zhàohù tǐxì tíchū le quánxīn tiǎozhàn. Yǒujiànyúcǐ, shì zhèngfǔ chūtái le jūjiā yǎnglǎo bǔtiē zhèngcè.",
          "translation_vi": "Sự xuất hiện của xã hội già hóa dân số đã đặt ra thách thức hoàn toàn mới cho hệ thống chăm sóc y tế. Xét thấy điều đó, chính quyền thành phố đã ban hành chính sách trợ cấp dưỡng lão tại nhà.",
          "explanation": "\"有鉴于此\" giải thích căn cứ thực tiễn để chính quyền ban hành quyết sách phúc lợi an sinh xã hội."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 82,
      "name": "Cấu trúc song song nâng cao với thành ngữ 4 chữ \"既...又...\"",
      "pattern": "Chủ ngữ + 既 + Thành ngữ 4 chữ/Cụm từ cao cấp + 又 + Thành ngữ 4 chữ song hành",
      "category": "Liên từ",
      "explanation_vi": "Ở trình độ HSK 5, cấu trúc \"既...又...\" (jì... yòu...) không chỉ kết hợp các tính từ đơn giản mà thường ghép đôi hai thành ngữ bốn chữ đối xứng hoặc hai cụm động tân trừu tượng để biểu thị hai phẩm chất, tính năng hoặc trạng thái cùng hội tụ một cách hoàn mỹ.",
      "examples": [
        {
          "chinese": "这栋现代建筑既保留了中国古典园林的古朴典雅，又展现了国际前沿设计的简洁明快。",
          "pinyin": "Zhè dòng xiàndài jiànzhù jì bǎoliú le Zhōngguó gǔdiǎn yuánlín de gǔpǔ diǎnyǎ, yòu zhǎnxiàn le guójì qiányán shèjì de jiǎnjié míngkuài.",
          "translation_vi": "Tòa kiến trúc hiện đại này vừa bảo lưu nét cổ phác thanh nhã của hoa viên cổ điển Trung Hoa, lại vừa thể hiện sự tinh gọn sáng sủa của thiết kế tiên phong quốc tế.",
          "explanation": "\"既保留...又展现...\" kết hợp đối xứng hoàn mỹ giữa giá trị truyền thống và ngôn ngữ thiết kế đương đại."
        },
        {
          "chinese": "他在会议上的即兴发言既高屋建瓴，又紧密联系基层实际，博得了阵阵热烈喝彩。",
          "pinyin": "Tā zài huìyì shang de jíxìng fāyán jì gāowūjiànlíng, yòu jǐnmì liánxì jīcéng shíjì, bódé le zhènzhèn rèliè hècǎi.",
          "translation_vi": "Bài phát biểu ngẫu hứng của ông tại cuộc họp vừa mang tầm nhìn chiến lược bao quát cao độ, lại vừa gắn bó mật thiết với thực tiễn cơ sở, đã nhận được từng tràng hoan nghênh nhiệt liệt.",
          "explanation": "\"既高屋建瓴，又紧密联系...\" ca ngợi tài năng hùng biện vừa có chiều sâu vĩ mô vừa sát sườn thực tiễn."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 83,
      "name": "Cấu trúc liên từ dẫn ra ngoại lệ duy nhất \"除了...以外, 唯独...\"",
      "pattern": "除了...以外, 唯独 + Đối tượng đặc biệt + Vị ngữ khác biệt",
      "category": "Liên từ",
      "explanation_vi": "\"唯独\" (wéidú) mang nghĩa \"duy nhất, chỉ riêng một mình đối tượng đó\". Khi kết hợp với \"除了...以外\" tạo thành cấu trúc nêu bật đối tượng cá biệt có hành vi hoặc trạng thái hoàn toàn khác với tập thể còn lại.",
      "examples": [
        {
          "chinese": "全班同学都积极踊跃地报名参加了这次志愿者活动，唯独他借口身体不适拒绝参加。",
          "pinyin": "Quán bān tóngxué dōu jījí yǒngyuè de bàomíng cānjiā le zhè cì zhìyuànzhě huódòng, wéidú tā jièkǒu shēntǐ búlì jùjué cānjiā.",
          "translation_vi": "Toàn thể học sinh trong lớp đều hăng hái nhiệt tình đăng ký tham gia hoạt động tình nguyện lần này, duy chỉ có anh ta viện cớ người không khỏe từ chối tham gia.",
          "explanation": "\"唯独他...\" tách biệt cá nhân có thái độ thiếu tích cực khỏi phong trào tập thể sôi nổi."
        },
        {
          "chinese": "柜子里摆满了各种精致的现代工艺品，唯独这枚古朴的怀表是爷爷亲手传给他的传家宝。",
          "pinyin": "Guìzi lǐ bǎimǎn le gè zhǒng jīngzhì de xiàndài gōngyìpǐn, wéidú zhè méi gǔpǔ de huáibiǎo shì yéye qīnshǒu chuángěi tā de chuánjiābǎo.",
          "translation_vi": "Trong tủ bày đầy đủ loại đồ thủ công mỹ nghệ hiện đại tinh xảo, duy chỉ có chiếc đồng hồ quả quýt cổ kính này là bảo vật gia truyền mà ông nội đích thân trao lại cho anh.",
          "explanation": "\"唯独这枚怀表\" làm nổi bật giá trị tinh thần thiêng liêng độc nhất của kỷ vật gia đình."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 84,
      "name": "Cấu trúc phủ định tương phản tuyệt đối \"决非...而是...\" (Tuyệt không phải... mà là...)",
      "pattern": "Chủ ngữ + 决非 / 绝非 + Nguyên nhân/Bản chất sai lầm, 而是 + Bản chất đích thực",
      "category": "Liên từ",
      "explanation_vi": "\"决非...而是...\" (juéfēi... érshì...) là cấu trúc phản biện chính luận mạnh mẽ: vế trước dùng \"决非\" (tuyệt đối không phải là) để bác bỏ dứt khoát một quan niệm lệch lạc hoặc một ngộ nhận sai lầm, vế sau dùng \"而是\" để khẳng định chân lý bản chất thực sự của sự vật.",
      "examples": [
        {
          "chinese": "我们今天所取得的巨大飞跃决非凭空而来的奇迹，而是几代科研人员前赴后继艰苦奋斗的结晶。",
          "pinyin": "Wǒmen jīntiān suǒ qǔdé de jùdà fēiyuè juéfēi píngkōng'érlái de qíjì, érshì jǐ dài kēyán rényuán qiánfùhòujì jiānkǔ fèndòu de jiéjīng.",
          "translation_vi": "Bước nhảy vọt to lớn mà chúng ta đạt được ngày hôm nay tuyệt không phải là phép màu từ trên trời rơi xuống, mà là sự kết tinh của sự phấn đấu gian khổ lớp này nối tiếp lớp khác của nhiều thế hệ cán bộ khoa học.",
          "explanation": "\"决非...而是...\" bác bỏ tư tưởng ỷ lại vào may mắn để tôn vinh sự hy sinh xương máu của các nhà khoa học."
        },
        {
          "chinese": "他提出这套严格的规章制度决非故意为难员工，而是为了防患于未然确保生产绝对安全。",
          "pinyin": "Tā tíchū zhè tào yángé de guīzhāng zhìdù juéfēi gùyì wéinán yuángōng, érshì wèile fánghuànyúwèirán quèbǎo shēngchǎn juéduì ānquán.",
          "translation_vi": "Ông ấy đề xuất bộ nội quy chế tài nghiêm ngặt này tuyệt không phải là cố tình làm khó nhân viên, mà là để phòng ngừa rủi ro từ trong trứng nước, bảo đảm an toàn sản xuất tuyệt đối.",
          "explanation": "\"决非故意为难...而是为了...\" giải tỏa định kiến của cấp dưới về sự khắt khe của kỷ luật an toàn lao động."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 85,
      "name": "Bổ ngữ trạng thái hư hóa chỉ cảm giác khó chịu \"得慌\" (Đến bồn chồn / Phát rầu)",
      "pattern": "Tính từ / Động từ cảm xúc + 得慌 (闷 / 闲 / 累 / 慌 / 憋 / 撑 + 得慌)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"得慌\" (de huang) là bổ ngữ mức độ khẩu ngữ đặc sắc bắt nguồn từ phương ngôn phương Bắc Trung Quốc, đứng sau các tính từ hoặc động từ chỉ trạng thái tâm lý, sinh lý để cực tả cảm giác khó chịu, bức bối, ngột ngạt hoặc buồn bực không yên (buồn bực phát điên, mệt bã người, no tức bụng).",
      "examples": [
        {
          "chinese": "退休在家这几个月一直没有出门社交，老李总觉得闲得慌、心里闷得慌。",
          "pinyin": "Tuìxiū zài jiā zhè jǐ gè yuè yìzhí méiyǒu chūmén shèjiāo, lǎo Lǐ zǒng juéde xián de huāng, xīnlǐ mèn de huāng.",
          "translation_vi": "Nghỉ hưu ở nhà mấy tháng nay luôn không ra ngoài giao lưu xã hội, bác Lý luôn cảm thấy rảnh rỗi đến bồn chồn, trong lòng ngột ngạt khó chịu.",
          "explanation": "\"闲得慌\" và \"闷得慌\" khắc họa tâm trạng bứt rứt, hụt hẫng của người vừa rời ghế công tác."
        },
        {
          "chinese": "今天中午聚餐大家太热情了，不知不觉吃得太多，肚子撑得慌。",
          "pinyin": "Jīntiān zhōngwǔ jùcān dàjiā tài rèqíng le, bùzhībùjué chī de tài duō, dùzi chēng de huāng.",
          "translation_vi": "Bữa liên hoan trưa nay mọi người nhiệt tình quá, vô thức ăn quá nhiều khiến bụng no căng tức anh ách.",
          "explanation": "\"撑得慌\" miêu tả cảm giác no căng tức bụng khó chịu sau bữa tiệc thịnh soạn."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 86,
      "name": "Bổ ngữ mức độ cực hạn mạnh mẽ \"不得了\" (Vô cùng / Không xiết / Ghê gớm)",
      "pattern": "Tính từ / Động từ tâm lý + 得不得了 / Tính từ + 得了不得",
      "category": "Bổ ngữ",
      "explanation_vi": "\"不得了\" (bùdéliǎo) khi làm bổ ngữ sau trợ từ \"得\" biểu thị mức độ của tính chất hoặc cảm xúc đạt tới mức tột đỉnh, phi thường, không từ ngữ nào tả xiết (cực kỳ, ghê gớm, vô cùng). Có thể dùng cho cả cảm xúc tích cực hân hoan hoặc trạng thái tiêu cực nghiêm trọng.",
      "examples": [
        {
          "chinese": "得知自己的科研成果荣获国际金奖的喜讯，整个实验室团队高兴得不得了。",
          "pinyin": "Dézhī zìjǐ de kēyán chéngguǒ rónghuò guójì jīnjiǎng de xǐxùn, zhěng gè shíyànshì tuánduì gāoxìng de bùdéliǎo.",
          "translation_vi": "Được tin thành quả nghiên cứu khoa học của mình vinh dự đoạt huy chương vàng quốc tế, toàn thể đội ngũ phòng thí nghiệm vui mừng khôn xiết.",
          "explanation": "\"高兴得不得了\" cực tả niềm hạnh phúc vỡ òa tột đỉnh khi đoạt giải thưởng danh giá thế giới."
        },
        {
          "chinese": "连续高强度加班了一个星期，大家身体都疲惫得不得了，迫切需要好好休整。",
          "pinyin": "Liánxù gāoqiángdù jiābān le yí gè xīngqī, dàjiā shēntǐ dōu píbèi de bùdéliǎo, pòqiè xūyào hǎohǎo xiūzhěng.",
          "translation_vi": "Tăng ca cường độ cao liên tục suốt một tuần, cơ thể mọi người đều mệt mỏi rã rời ghê gớm, đang hết sức cần được nghỉ ngơi hồi phục.",
          "explanation": "\"疲惫得不得了\" diễn tả sự suy kiệt thể lực cùng cực sau tuần làm việc căng thẳng."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 87,
      "name": "Bổ ngữ mức độ cực đoan dân dã \"要命 / 要死\" (Chết đi được / Muốn mạng)",
      "pattern": "Tính từ / Động từ tâm lý + 得要命 / 得要死",
      "category": "Bổ ngữ",
      "explanation_vi": "\"要命\" (yàomìng) và \"要死\" (yàosǐ) là các bổ ngữ mức độ khẩu ngữ có tính phóng đại cao, dùng để đặc tả một trạng thái đau đớn, nóng bức, khát nước, hoặc nhớ nhung đến mức tưởng chừng như không chịu nổi tính mạng (chết đi được, đứt ruột).",
      "examples": [
        {
          "chinese": "在没有空调的车厢里熬了整整四个小时，车里闷热得要命。",
          "pinyin": "Zài méiyǒu kōngtiáo de chēxiāng lǐ áo le zhěngzhěng sì gè xiǎoshí, chē lǐ mēnrè de yàomìng.",
          "translation_vi": "Chịu đựng tròn 4 tiếng đồng hồ trong toa xe không có điều hòa, bên trong xe nóng hầm hập chết đi được.",
          "explanation": "\"闷热得要命\" phóng đại cảm giác bức bối oi ả không thể chịu đựng nổi."
        },
        {
          "chinese": "长跑比赛冲过终点线的那一刻，他只觉得双腿酸痛得要命，口渴得要死。",
          "pinyin": "Chángpǎo bǐsài chōngguò zhōngdiǎnxiàn de nà yí kè, tā zhǐ juéde shuāngtuǐ suāntòng de yàomìng, kǒukě de yàosǐ.",
          "translation_vi": "Khoảnh khắc lao qua vạch đích cuộc thi chạy dài, anh ấy chỉ cảm thấy hai chân mỏi nhừ muốn chết, miệng khát khô cổ họng.",
          "explanation": "\"酸痛得要命\" và \"口渴得要死\" diễn tả cảm giác thể xác mỏi nhừ và khát nước sau cuộc đua dài."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 88,
      "name": "Bổ ngữ xu hướng kép nghĩa trừu tượng \"沉下去\" (Lắng xuống / Chìm đắm / Hạ mình sâu sát)",
      "pattern": "Động từ + 沉下去 / 沉下心来 + Động từ",
      "category": "Bổ ngữ",
      "explanation_vi": "\"沉下去\" (chén xiàqu) khi làm bổ ngữ phái sinh trừu tượng mang hai tầng nghĩa cao cấp: 1) Cảm xúc nóng nảy, xáo động được kiềm chế, lắng đọng bình tâm trở lại (như 沉下心来 - tĩnh tâm lại); 2) Cán bộ, trí thức gạt bỏ bệnh quan liêu để đi sâu sát xuống tận cơ sở nhân dân (như 干部要沉下去).",
      "examples": [
        {
          "chinese": "青年学者只有耐得住寂寞、真正沉下心来搞研究，才能产出具有开创性的成果。",
          "pinyin": "Qīngnián xuézhě zhǐyǒu nàidezhù jìmò, zhēnzhèng chén xià xīn lái gǎo yánjiū, cái néng chǎnchū jùyǒu kāichuàngxìng de chéngguǒ.",
          "translation_vi": "Các học giả trẻ chỉ khi chịu được sự cô đơn tĩnh mịch, thực sự tĩnh tâm lại làm nghiên cứu, thì mới có thể cho ra đời những thành quả mang tính khai mở.",
          "explanation": "\"沉下心来\" khuyên nhủ sự tĩnh tâm chuyên chú, không chạy theo hào nhoáng bề nổi."
        },
        {
          "chinese": "机关干部要主动沉下去，深入到田间地头倾听老百姓最真实的诉求。",
          "pinyin": "Jīguān gānbù yào zhǔdòng chén xiàqu, shēnrù dào tiánjiāndìtóu qīngtīng lǎobǎixìng zuì zhēnshí de sùqiú.",
          "translation_vi": "Cán bộ cơ quan phải chủ động đi sâu sát xuống cơ sở, đi sâu tới tận bờ ruộng đầu làng lắng nghe những thỉnh cầu chân thực nhất của người dân.",
          "explanation": "\"主动沉下去\" biểu thị tác phong lãnh đạo gần dân, sâu sát với thực tiễn đời sống."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 89,
      "name": "Bổ ngữ xu hướng kép nghĩa trừu tượng \"浮上来\" (Nổi lên / Hiện rõ ra bề mặt)",
      "pattern": "Động từ (显 / 浮 / 冒) + 浮上来 / 浮现在脑海中",
      "category": "Bổ ngữ",
      "explanation_vi": "\"浮上来\" (fú shànglái) là phản nghĩa của \"沉下去\", biểu thị một mâu thuẫn, vấn đề tiềm ẩn từ chỗ bị che giấu bắt đầu bộc lộ rõ ràng trên bề mặt xã hội; hoặc hình ảnh, ký ức xưa cũ bỗng nhiên hiện về mồn một trong tâm trí con người.",
      "examples": [
        {
          "chinese": "随着调查的逐步深入，那些隐藏多年的深层次管理漏洞终于彻底浮了上来。",
          "pinyin": "Suízhe diàochá de zhúbù shēnrù, nàxiē yǐncáng duō nián de shēncéngcì guǎnlǐ lòudòng zhōngyú chèdǐ fú le shànglái.",
          "translation_vi": "Cùng với sự đi sâu từng bước của cuộc điều tra, những lỗ hổng quản lý tầng sâu bị che giấu nhiều năm cuối cùng đã hoàn toàn lộ rõ ra bề mặt.",
          "explanation": "\"浮了上来\" ẩn dụ cho việc các sai phạm quản lý bị phơi bày trước ánh sáng công lý."
        },
        {
          "chinese": "望着远方故乡的明月，童年与祖母相依为命的温馨画面不禁浮现在眼前。",
          "pinyin": "Wàngzhe yuǎnfāng gùxiāng de míngyuè, tóngnián yǔ zǔmǔ xiāngyīwéimìng de wēnxīn huàmiàn bùjīn fúxiàn zài yǎnqián.",
          "translation_vi": "Ngắm nhìn vầng trăng sáng nơi quê hương phương xa, bức tranh ấm áp thuở ấu thơ nương tựa bên bà nội bất giác hiện về mồn một trước mắt.",
          "explanation": "\"浮现在眼前\" miêu tả dòng hồi ức êm đềm tái hiện sống động trong tâm trí người tha hương."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 90,
      "name": "Câu chữ 把 chính luận trang trọng: \"把...置于...\" (Đặt... vào vị trí)",
      "pattern": "Chủ ngữ + 把 + Đối tượng trọng đại + 置于 + Vị trí chiến lược (核心地位 / 优先地位 / 首位)",
      "category": "Câu chữ 把",
      "explanation_vi": "Trong các văn kiện chính trị, báo cáo đại hội và bình luận quốc tế, cấu trúc \"把...置于...\" (bǎ... zhìyú...) là mẫu câu kinh điển xác lập thứ tự ưu tiên chiến lược của một quốc gia, tổ chức (đặt đối tượng đó vào vị trí trung tâm, vị trí hàng đầu). \"置\" là từ văn ngôn của \"放\" (đặt).",
      "examples": [
        {
          "chinese": "我们党始终把人民群众的生命安全和身体健康置于第一位。",
          "pinyin": "Wǒmen dǎng shǐzhōng bǎ rénmín qúnzhòng de shēngmìng ānquán hé shēntǐ jiànkāng zhìyú dìyīwèi.",
          "translation_vi": "Đảng chúng ta luôn luôn đặt an toàn tính mạng và sức khỏe thân thể của quần chúng nhân dân vào vị trí hàng đầu.",
          "explanation": "\"把...置于第一位\" khẳng định tôn chỉ tối thượng coi tính mạng nhân dân là trên hết."
        },
        {
          "chinese": "国家在现代化建设全局中，始终把科技自主创新置于核心地位。",
          "pinyin": "Guójiā zài xiàndàihuà jiànshè quánjú zhōng, shǐzhōng bǎ kējì zìzhǔ chuàngxīn zhìyú héxīn dìwèi.",
          "translation_vi": "Nhà nước trong toàn cục công cuộc xây dựng hiện đại hóa luôn luôn đặt đổi mới sáng tạo tự chủ công nghệ vào vị trí cốt lõi.",
          "explanation": "\"把...置于核心地位\" làm rõ tầm nhìn chiến lược phát triển công nghệ của quốc gia."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 91,
      "name": "Câu chữ 把 quy kết nguyên nhân: \"把...归咎于...\" (Quy tội cho / Đổ lỗi cho)",
      "pattern": "Chủ ngữ + 把 + Thất bại/Khó khăn/Trách nhiệm + 归咎于 + Đối tượng bên ngoài",
      "category": "Câu chữ 把",
      "explanation_vi": "\"把...归咎于...\" (bǎ... guījiùyú...) là cấu trúc ngoại giao và bình luận xã hội sâu sắc, biểu thị việc đổ lỗi, quy trách nhiệm hoặc coi một kết quả thất bại là do một người, một nguyên nhân khách quan hoặc một thế lực bên ngoài gây ra (quy tội cho, đổ lỗi lên đầu). \"咎\" nghĩa là lỗi lầm, tai họa.",
      "examples": [
        {
          "chinese": "遇到挫折时一味把自身失败归咎于外部环境，是缺乏担当与成熟的表现。",
          "pinyin": "Yùdào cuòzhé shí yíwèi bǎ zìshēn shībài guījiùyú wàibù huánjìng, shì quēfá dāndāng yǔ chéngshú de biǎoxiàn.",
          "translation_vi": "Khi gặp trắc trở mà cứ một mực đổ lỗi thất bại của bản thân cho môi trường bên ngoài là biểu hiện của sự thiếu tinh thần gánh vác và thiếu chín chắn.",
          "explanation": "\"把自身失败归咎于外部环境\" phê phán thái độ hèn nhát trốn tránh tự kiểm điểm bản thân."
        },
        {
          "chinese": "少数政客企图把国内经济问题归咎于别国的正当竞争，这种论调是毫无事实根据的。",
          "pinyin": "Shǎoshù zhèngkè qǐtú bǎ guónèi jīngjì wèntí guījiùyú biéguó de zhèngdàng jìngzhēng, zhè zhǒng lùndiào shì háowú shìshí gēnjù de.",
          "translation_vi": "Một số ít chính khách mưu toan đổ lỗi cho các vấn đề kinh tế trong nước lên sự cạnh tranh chính đáng của nước khác, luận điệu này hoàn toàn không có căn cứ thực tế.",
          "explanation": "\"把...归咎于别国\" bác bỏ thủ đoạn chính trị vô căn cứ nhằm chuyển hướng dư luận."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 92,
      "name": "Câu chữ 把 phân loại định danh: \"把...列为...\" (Liệt vào / Xếp vào danh sách)",
      "pattern": "Chủ ngữ + 把 + Đối tượng + 列为 + Danh mục/Hạng mục ưu tiên (重点工程 / 保护对象 / 考察对象)",
      "category": "Câu chữ 把",
      "explanation_vi": "\"把...列为...\" (bǎ... lièwéi...) biểu thị hành động chính thức xếp đặt, phân loại một sự vật, đối tượng vào một thứ bậc, danh mục hoặc hạng mục quản lý trọng điểm nào đó (liệt vào danh sách, coi là đối tượng). Thường dùng trong quản lý nhà nước, giáo dục và bảo tồn di sản.",
      "examples": [
        {
          "chinese": "联合国教科文组织正式把这项古老的传统习俗列为人类非物质文化遗产代表作。",
          "pinyin": "Liánhéguó Jiàokēwén Zǔzhī zhèngshì bǎ zhè xiàng gǔlǎo de chuántǒng xísú lièwéi rénlèi fēiwùzhì wénhuà yíchǎn dàibiǎozuò.",
          "translation_vi": "Tổ chức UNESCO đã chính thức ghi danh phong tục truyền thống cổ xưa này vào Danh sách Di sản Văn hóa Phi vật thể đại diện của Nhân loại.",
          "explanation": "\"把...列为...代表作\" là thuật ngữ công nhận di sản văn hóa quốc tế chuẩn xác."
        },
        {
          "chinese": "市政府决定把改善老旧小区的供暖排污设施列为今年十件重点民生实事之一。",
          "pinyin": "Shì zhèngfǔ juédìng bǎ gǎishàn lǎojiù xiǎoqū de gōngnuǎn páiwū shèshī lièwéi jīnnián shí jiàn zhòngdiǎn mínshēng shíshì zhī yī.",
          "translation_vi": "Chính quyền thành phố quyết định liệt việc cải tạo cơ sở hạ tầng sưởi ấm và thoát nước thải các khu tập thể cũ vào một trong mười việc dân sinh trọng điểm năm nay.",
          "explanation": "\"把...列为...实事之一\" thể hiện ưu tiên phân bổ ngân sách cho phúc lợi nhân dân."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 93,
      "name": "Câu chữ 把 coi như định tính: \"把...视作 / 视为...\" (Coi... như là / Xem... là)",
      "pattern": "Chủ ngữ + 把 + Đối tượng A + 视作 / 视为 + Đối tượng B (sinh mệnh / tấm gương / kim chỉ nam)",
      "category": "Câu chữ 把",
      "explanation_vi": "\"把...视作 / 视为...\" (bǎ... shìzuò / shìwéi...) là dạng trang trọng tương đương với \"把...当作 / 认作\", mang nghĩa nhìn nhận, đánh giá và đối đãi với một sự vật theo một vị thế, tầm vóc hoặc phẩm chất đặc biệt thiêng liêng (coi là, xem như). \"视\" là động từ văn ngôn của \"看\" (nhìn).",
      "examples": [
        {
          "chinese": "真正的科学家把探索未知的客观真理视作自己毕生最高的职业荣誉。",
          "pinyin": "Zhēnzhèng de kēxuéjiā bǎ tànsuǒ wèizhī de kèguān zhēnlǐ shìzuò zìjǐ bìshēng zuì gāo de zhíyè róngyù.",
          "translation_vi": "Người làm khoa học chân chính coi việc tìm tòi chân lý khách quan chưa biết là niềm vinh dự nghề nghiệp cao quý nhất cả đời mình.",
          "explanation": "\"把探索真理视作最高荣誉\" định nghĩa lý tưởng khoa học cống hiến thuần túy."
        },
        {
          "chinese": "这所百年名校始终把立德树人视为学校教育教学工作的根本任务。",
          "pinyin": "Zhè suǒ bǎinián míngxiào shǐzhōng bǎ lìdéshùrén shìwéi xuéxiào jiàoyù jiàoxué gōngzuò de gēnběn rènwu.",
          "translation_vi": "Ngôi trường danh tiếng trăm năm tuổi này luôn luôn xem việc bồi dưỡng đạo đức trồng người là nhiệm vụ căn bản của công tác giảng dạy nhà trường.",
          "explanation": "\"把立德树人视为根本任务\" khẳng định triết lý giáo dục lấy nhân cách làm gốc."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 94,
      "name": "Câu bị động văn viết kinh điển \"为...所...\" / \"被...所...\" (Bị/Được... làm cho...)",
      "pattern": "Chủ ngữ + 为 / 被 + Tác nhân + 所 + Động từ song âm tiết (吸引 / 感动 / 熟知 / 震撼 / 蒙蔽)",
      "category": "Câu bị động",
      "explanation_vi": "Kết cấu \"为...所...\" hoặc \"被...所...\" (wèi... suǒ... / bèi... suǒ...) là mẫu câu bị động trang nhã kế thừa từ cổ văn Hán ngữ, rất phổ biến trong văn học và báo chí hiện đại. \"所\" đứng trước động từ ngoại động từ song âm tiết nhằm làm nổi bật sự tác động sâu sắc của tác nhân lên chủ thể (như 为大家所熟知 - được mọi người biết tới rộng rãi, 被其美景所折服).",
      "examples": [
        {
          "chinese": "初次来到桂林山水的海内外游客，无一不被大自然鬼斧神工的绝美风光所深深震撼。",
          "pinyin": "Chūcì láidào Guìlín shānshuǐ de hǎinèiwài yóukè, wúyībù bèi dàzìrán guǐfǔshéngōng de juéměi fēngguāng suǒ shēnshēn zhènhàn.",
          "translation_vi": "Những du khách trong và ngoài nước lần đầu tới non nước Quế Lâm, không một ai là không bị cảnh sắc tuyệt mỹ tài tình của tạo hóa làm cho chấn động sâu sắc.",
          "explanation": "\"被...风光所深深震撼\" lột tả sự choáng ngợp tột cùng trước vẻ đẹp thiên nhiên kỳ vĩ."
        },
        {
          "chinese": "这位默默扎根边疆三十二年的乡村教师的事迹，早已为全国广大人民所熟知与传颂。",
          "pinyin": "Zhè wèi mòmò zhāgēn biānjiāng sānshí'èr nián de xiāngcūn jiàoshī de shìjì, zǎoyǐ wéi quánguó guǎngdà rénmín suǒ shúzhī yǔ chuánsòng.",
          "translation_vi": "Tấm gương người thầy giáo nông thôn thầm lặng cắm rễ nơi biên ải suốt 32 năm này từ lâu đã được đông đảo nhân dân cả nước biết đến và truyền tụng.",
          "explanation": "\"为广大人民所熟知\" dùng \"为...所...\" trang trọng khẳng định sự ghi nhận của toàn xã hội."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 95,
      "name": "Câu bị động ủy thác thẩm quyền \"受...委托 / 指派\" (Nhận ủy thác / Được chỉ định bởi)",
      "pattern": "Chủ ngữ + 受 + Cơ quan/Cá nhân giao phó + (的) 委托 / 指派, Động từ thực hiện công vụ",
      "category": "Câu bị động",
      "explanation_vi": "\"受...委托\" (shòu... wěituō) là cấu trúc pháp lý và hành chính chính thức, trong đó \"受\" đóng vai trò thụ nhận (nhận sự ủy quyền). Dùng để xác nhận tư cách pháp nhân hợp pháp của đại diện luật sư, phát ngôn viên hoặc tổ thanh tra khi thực thi nhiệm vụ được ủy thác.",
      "examples": [
        {
          "chinese": "受当事人家属的正式委托，该律师事务所已向人民法院递交了无罪辩护申请书。",
          "pinyin": "Shòu dāngshìrén jiāshǔ de zhèngshì wěituō, gāi lǜshī shìwùsuǒ yǐ xiàng rénmín fǎyuàn dìjiāo le wúzuì biànhù shēnqǐngshū.",
          "translation_vi": "Nhận sự ủy thác chính thức từ gia quyến của đương sự, văn phòng luật sư này đã nộp đơn xin bào chữa vô tội lên Tòa án Nhân dân.",
          "explanation": "\"受...正式委托\" xác lập tư cách đại diện pháp lý hợp pháp của đoàn luật sư tranh tụng."
        },
        {
          "chinese": "受国务院指派，由部委专家组成的联合调查组已于今日清晨紧急赶赴事故现场。",
          "pinyin": "Shòu Guówùyuàn zhǐpài, yóu bùwěi zhuānjiā zǔchéng de liánhé diàocházǔ yǐ yú jīnrì qīngchén jǐnjí gǎnfù shìgù xiànchǎng.",
          "translation_vi": "Được Quốc vụ viện chỉ định, tổ điều tra liên ngành do các chuyên gia các bộ ngành tạo thành đã khẩn cấp tới hiện trường vụ tai nạn vào sáng sớm hôm nay.",
          "explanation": "\"受国务院指派\" công bố thẩm quyền cấp cao nhất của đoàn công tác chính phủ."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 96,
      "name": "Cấu trúc câu phản vấn hùng biện bác bỏ \"岂不是...？\" (Há chẳng phải là... sao?)",
      "pattern": "Nếu làm theo phương án sai lầm, 岂不是 + Hậu quả phi lý / Sai lầm tày đình + 吗 / 呢？",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"岂不是...？\" (qǐbúshì...?) là mẫu câu hỏi tu từ văn ngôn kinh điển (chữ 岂 nghĩa là há, lẽ nào; 岂不是 = há chẳng phải là). Dùng trong văn phong nghị luận sắc bén để phản bác một luận điểm phi lý, bằng cách chỉ ra rằng nếu làm như vậy thì há chẳng phải sẽ dẫn tới một kết cục nực cười, mâu thuẫn hay sao.",
      "examples": [
        {
          "chinese": "只顾追求眼前的短期暴利而肆意破坏赖以生存的青山绿水，这岂不是杀鸡取卵、自掘坟墓吗？",
          "pinyin": "Zhǐgù zhuīqiú yǎnqián de duǎnqī bàolì ér sìyì pòhuài làiyǐshēngcún de qīngshān lǜshuǐ, zhè qǐbúshì shājīqǔluǎn, zìjuéfénmù ma?",
          "translation_vi": "Chỉ mải miết mưu cầu món siêu lợi nhuận ngắn hạn trước mắt mà ngang nhiên tàn phá non xanh nước biếc nơi ta nương tựa sinh tồn, điều này há chẳng phải là giết gà lấy trứng, tự đào mồ chôn mình hay sao?",
          "explanation": "\"这岂不是...吗？\" dùng câu hỏi tu từ cực kỳ đanh thép lên án tội ác hủy hoại môi trường sống."
        },
        {
          "chinese": "如果连遵纪守法的诚实公民都得不到法律的保护，法治社会的尊严又岂不是形同虚设？",
          "pinyin": "Rúguǒ lián zūnjìshǒufǎ de chéngshí gōngmín dōu débúdào fǎlǜ de bǎohù, fǎzhì shèhuì de zūnyán yòu qǐbúshì xíngtóngxūshè?",
          "translation_vi": "Nếu ngay cả những công dân trung thực tuân thủ kỷ cương pháp luật mà cũng không nhận được sự bảo vệ của luật pháp, thì phẩm giá của xã hội pháp quyền há chẳng phải chỉ là hình thức rỗng tuếch sao?",
          "explanation": "\"岂不是形同虚设\" chất vấn tận gốc rễ giá trị thực thi công lý của bộ máy nhà nước."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 97,
      "name": "Cấu trúc cố định khẳng định chân lý không thể bàn cãi: \"毫无疑问\"",
      "pattern": "毫无疑问, Mệnh đề khẳng định chân lý / 是毫无疑问的",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"毫无疑问\" (háowú yíwèn) biểu thị tính xác thực 100% không còn một chút mảy may nghi ngờ nào (không thể nghi ngờ, chắc chắn không thể chối cãi). Có thể đứng độc lập đầu câu làm trạng ngữ hoặc đứng cuối câu làm bổ ngữ vị ngữ.",
      "examples": [
        {
          "chinese": "毫无疑问，绿色低碳转型是全球工业未来实现可持续发展的必由之路。",
          "pinyin": "Háowú yíwèn, lǜsè dītàn zhuǎnxíng shì quánqiú gōngyè wèilái shíxiàn kěchíxù fāzhǎn de bìyóuzhīlù.",
          "translation_vi": "Không còn nghi ngờ gì nữa, chuyển dịch xanh giảm thiểu carbon là con đường tất yếu duy nhất để công nghiệp toàn cầu thực hiện phát triển bền vững trong tương lai.",
          "explanation": "\"毫无疑问\" đứng đầu câu khẳng định tính tất yếu khách quan của xu hướng kinh tế xanh."
        },
        {
          "chinese": "在整场抢险救灾战役中，广大官兵付出的巨大牺牲与卓越功绩是毫无疑问的。",
          "pinyin": "Zài zhěng chǎng qiǎngxiǎn jiùzāi zhànyì zhōng, guǎngdà guānbīng fùchū de jùdà xīshēng yǔ zhuóyuè gōngjì shì háowú yíwèn de.",
          "translation_vi": "Trong toàn bộ chiến dịch cứu hộ chống thiên tai, sự hy sinh to lớn và chiến công xuất sắc mà đông đảo cán bộ chiến sĩ bỏ ra là điều không còn nghi ngờ gì nữa.",
          "explanation": "\"是毫无疑问的\" kết thúc câu khẳng định công lao bất tử của người lính cứu hộ."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 98,
      "name": "Cấu trúc cố định quy nạp nguyên nhân sâu xa: \"归根结底\"",
      "pattern": "归根结底, Mệnh đề bản chất cốt lõi / Căn nguyên nằm ở...",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"归根结底\" (guīgēn jiédǐ) biểu thị sau khi gạt bỏ toàn bộ những hiện tượng bề ngoài, chi tiết rườm rà, ta truy tìm đến tận gốc rễ, cội nguồn sâu xa nhất của vấn đề (suy cho cùng, rốt ráo, rốt cuộc quy về một mối). Đây là thành ngữ kết luận phân tích triết học kinh điển.",
      "examples": [
        {
          "chinese": "现代企业之间的市场竞争，归根结底是高素质核心人才储备与创新能力的竞争。",
          "pinyin": "Xiàndài qǐyè zhījiān de shìchǎng jìngzhēng, guīgēn jiédǐ shì gāosùzhì héxīn réncái chǔbèi yǔ chuàngxīn nénglì de jìngzhēng.",
          "translation_vi": "Cạnh tranh thị trường giữa các doanh nghiệp hiện đại, suy cho cùng chính là sự cạnh tranh về nguồn dự trữ nhân tài cốt lõi chất lượng cao và năng lực đổi mới sáng tạo.",
          "explanation": "\"归根结底是...竞争\" quy nạp bản chất cạnh tranh kinh tế về yếu tố con người nhân tài."
        },
        {
          "chinese": "解决人民群众看病难、住房难的问题，归根结底要靠国家经济实力的不断壮大与科学治理。",
          "pinyin": "Jiějué rénmín qúnzhòng kànbìng nán, zhùfáng nán de wèntí, guīgēn jiédǐ yào kào guójiā jīngjì shílì de búduàn zhuàngdà yǔ kēxué zhìlǐ.",
          "translation_vi": "Giải quyết vấn đề khám chữa bệnh khó, nhà ở khó của quần chúng nhân dân, rốt ráo phải dựa vào tiềm lực kinh tế quốc gia không ngừng lớn mạnh và nền quản trị khoa học.",
          "explanation": "\"归根结底要靠...\" chỉ ra chiếc chìa khóa vạn năng giải quyết vấn đề an sinh xã hội."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 99,
      "name": "Cấu trúc cố định nhận định hiển nhiên: \"显而易见\"",
      "pattern": "显而易见, Mệnh đề sự thật / ...的效果是显而易见的",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"显而易见\" (xiǎn'ér yìjiàn) biểu thị sự thật, logic hoặc kết quả hiển lộ rõ ràng trước mắt, dễ thấy dễ hiểu mà bất kỳ ai có lý trí cũng đều nhận ra mà không cần phải tranh cãi (rõ ràng như ban ngày, hiển nhiên dễ thấy).",
      "examples": [
        {
          "chinese": "吸烟严重危害人体呼吸系统健康，这一科学事实早已显而易见。",
          "pinyin": "Xīyān yánzhòng wēihài réntǐ hūxī xìtǒng jiànkāng, zhè yì kēxué shìshí zǎoyǐ xiǎn'ér yìjiàn.",
          "translation_vi": "Hút thuốc lá gây nguy hại nghiêm trọng cho sức khỏe hệ hô hấp của cơ thể người, sự thật khoa học này từ lâu đã là điều hiển nhiên dễ thấy.",
          "explanation": "\"显而易见\" khẳng định tác hại của thuốc lá là chân lý y học phổ biến được toàn cầu thừa nhận."
        },
        {
          "chinese": "显而易见，如果不能从源头上遏制工业废水排放，下游的生态治理都将徒劳无功。",
          "pinyin": "Xiǎn'ér yìjiàn, rúguǒ bù néng cóng yuántóu shang èzhì gōngyè fèishuǐ páifàng, xiàyóu de shēngtài zhìlǐ dōu jiāng túláowúgōng.",
          "translation_vi": "Rõ ràng dễ thấy, nếu không thể kiềm chế xả thải nước thải công nghiệp từ thượng nguồn, mọi nỗ lực xử lý sinh thái ở hạ lưu đều sẽ trở nên vô ích.",
          "explanation": "\"显而易见\" đứng đầu câu nhấn mạnh nguyên lý xử lý ô nhiễm môi trường từ gốc rễ."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 100,
      "name": "Cấu trúc cố định chân lý ngầm hiểu: \"不言而喻\"",
      "pattern": "...的重要性 / 意义 / 价值 是不言而喻的",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"不言而喻\" (bùyán ér yù) kết hợp chữ 言 (nói) và 喻 (hiểu rõ), mang nghĩa đạo lý, ý nghĩa hoặc tầm quan trọng quá rõ ràng, không cần mở lời giải thích mà tự nó đã sáng tỏ và ai nấy đều tự hiểu (không nói cũng hiểu, tự nó đã rõ ràng).",
      "examples": [
        {
          "chinese": "在激烈的知识经济时代，终身学习对于保持个人竞争力的重要性是不言而喻的。",
          "pinyin": "Zài jīliè de zhīshi jīngjì shídài, zhōngshēn xuéxí duìyú bǎochí gèrén jìngzhēnglì de zhòngyàoxìng shì bùyán'éryù de.",
          "translation_vi": "Trong thời đại kinh tế tri thức gay gắt, tầm quan trọng của việc học tập suốt đời đối với việc duy trì sức cạnh tranh cá nhân là điều không nói cũng hiểu.",
          "explanation": "\"重要性是不言而喻的\" là cụm từ quán dụng khẳng định chân lý của tinh thần học tập cả đời."
        },
        {
          "chinese": "父母言传身教对未成年子女品格养成所起的深远熏陶作用，自然是不言而喻的。",
          "pinyin": "Fùmǔ yánchuánshēnjiào duì wèichéngnián zǐnǚ pǐngé yǎngchéng suǒ qǐ de shēnyuǎn xūntáo zuòyòng, zìrán shì bùyán'éryù de.",
          "translation_vi": "Tác dụng hun đúc sâu xa của việc cha mẹ làm gương dạy bảo đối với sự hình thành phẩm cách của con cái vị thành niên đương nhiên là điều tự rõ không cần nói.",
          "explanation": "\"自然是不言而喻的\" làm nổi bật vai trò gia giáo thiêng liêng của đấng sinh thành."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 101,
      "name": "Cấu trúc cố định điểm nhấn đặc sắc: \"值得一提的是\"",
      "pattern": "值得一提的是, Mệnh đề thông tin nổi bật / thành tựu bất ngờ",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"值得一提的是\" (zhíde yì tí de shì) dùng trong các bài báo giới thiệu dự án, tác phẩm hoặc tường thuật sự kiện để hướng sự chú ý của độc giả vào một chi tiết, một thành tựu hoặc điểm sáng đặc biệt xuất sắc đáng được biểu dương (điều rất đáng nhắc tới ở đây là).",
      "examples": [
        {
          "chinese": "这次大型文化交流博览会取得了圆满成功，特别值得一提的是，青年志愿者们的专业素养博得了外宾的一致赞赏。",
          "pinyin": "Zhè cì dàxíng wénhuà jiāoliú bólǎnhuì qǔdé le yuánmǎn chénggōng, tèbié zhíde yì tí de shì, qīngnián zhìyuànzhěmen de zhuānyè sùyǎng bódé le wàibīn de yízhì zànshǎng.",
          "translation_vi": "Hội chợ triển lãm giao lưu văn hóa quy mô lớn lần này đã gặt hái thành công mỹ mãn, điều đặc biệt rất đáng nhắc tới là tố chất chuyên nghiệp của các tình nguyện viên trẻ tuổi đã nhận được lời khen ngợi nhất trí của bạn bè quốc tế.",
          "explanation": "\"值得一提的是...\" điểm xuyết sự cống hiến thầm lặng nhưng sáng chói của các bạn thanh niên tình nguyện."
        },
        {
          "chinese": "该款国产大飞机不仅性能达到了国际一流标准，值得一提的是，其核心零部件的国产化率高达百分之九十。",
          "pinyin": "Gāi kuǎn guóchǎn dà fēijī bùjǐn xìngnéng dádào le guójì yīliú biāozhǔn, zhíde yì tí de shì, qí héxīn língbùjiàn de guóchǎnhuàlǜ gāodá bǎi fēn zhī jiǔshí.",
          "translation_vi": "Chiếc máy bay cỡ lớn sản xuất nội địa này không chỉ có tính năng đạt tiêu chuẩn hàng đầu quốc tế, điều đáng tự hào nhắc tới là tỷ lệ nội địa hóa các linh kiện cốt lõi của nó lên tới 90%.",
          "explanation": "\"值得一提的是...\" làm nổi bật bước đột phá độc lập tự chủ công nghiệp hàng không của đất nước."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 102,
      "name": "Cấu trúc cố định biểu thị lợi ích thúc đẩy: \"有助于\"",
      "pattern": "Biện pháp / Thói quen tốt + 有助于 + Thúc đẩy / Nâng cao / Giải quyết vấn đề",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"有助于\" (yǒuzhùyú) kết hợp chữ 有 (có), 助 (trợ giúp, có lợi) và 于 (đối với), mang nghĩa \"có sự giúp ích to lớn đối với, góp phần thúc đẩy vào\". Thường đi với các động từ phát triển như 提高, 促进, 加强, 改善, 推动.",
      "examples": [
        {
          "chinese": "保持充足的睡眠与均衡的营养摄入，有助于全面增强人体的免疫抵抗力。",
          "pinyin": "Bǎochí chōngzú de shuìmián yǔ jūnhéng de yíngyǎng shèrù, yǒuzhùyú quánmiàn zēngqiáng réntǐ de miǎnyì dǐkànglì.",
          "translation_vi": "Duy trì giấc ngủ đầy đủ cùng lượng dinh dưỡng nạp vào cân đối góp phần tăng cường toàn diện sức đề kháng miễn dịch của cơ thể con người.",
          "explanation": "\"有助于全面增强...\" giải thích tác dụng y học tích cực của lối sống điều độ khoa học."
        },
        {
          "chinese": "加强两国青年学者之间的学术往来，有助于加深彼此青年一代的友谊与相互理解。",
          "pinyin": "Jiāqiáng liǎng guó qīngnián xuézhě zhījiān de xuéshù wǎnglái, yǒuzhùyú jiāshēn bǐcǐ qīngnián yídài de yǒuyì yǔ xiānghù lǐjiě.",
          "translation_vi": "Tăng cường giao lưu học thuật giữa các học giả trẻ hai nước góp phần làm sâu sắc thêm tình hữu nghị và sự thấu hiểu lẫn nhau của thế hệ trẻ đôi bên.",
          "explanation": "\"有助于加深...友谊\" khẳng định ý nghĩa nhịp cầu giao lưu văn hóa ngoại giao nhân dân."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 103,
      "name": "Cấu trúc hành chính trang trọng giải quyết công vụ: \"动词 + 予以\"",
      "pattern": "予以 + Động từ song âm tiết (批准 / 支持 / 澄清 / 考虑 / 驳回 / 惩罚)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"予以\" (yǔyǐ) là động từ hỗ trợ hành chính văn thư cao cấp mang nghĩa \"cho phép, tiến hành, đưa ra sự xử lý\" (kết hợp 与: cho, 以: bằng). Đi trước các động từ hai chữ biểu thị sự giải quyết công vụ chính thức như 予以批准 (cho phép phê chuẩn), 予以支持 (dành sự ủng hộ), 予以驳回 (bác bỏ), 予以免职 (cho thôi chức).",
      "examples": [
        {
          "chinese": "对于受灾群众面临的实际生活困难，各级民政部门应当在政策范围内予以优先救助。",
          "pinyin": "Duìyú shòuzāi qúnzhòng miànlín de shíjì shēnghuó kùnnan, gèjí mínzhèng bùmén yīngdāng zài zhèngcè fànwéi nèi yǔyǐ yōuxiān jiùzhù.",
          "translation_vi": "Đối với những khó khăn trong đời sống thực tế mà quần chúng vùng bị thiên tai đang đối mặt, các cấp ban ngành dân chính cần phải dành sự cứu trợ ưu tiên trong phạm vi chính sách.",
          "explanation": "\"予以优先救助\" là thuật ngữ hành chính nhà nước yêu cầu cấp bách cứu tế nhân dân."
        },
        {
          "chinese": "对于一切企图分裂国家、破坏社会稳定的恶劣行径，司法机关必须依法予以坚决打击。",
          "pinyin": "Duìyú yíqiè qǐtú fēnliè guójiā, pòhuài shèhuì wěndìng de èliè xíngjìng, sīfǎ jīguān bìxū yīfǎ yǔyǐ jiānjué dǎjī.",
          "translation_vi": "Đối với mọi hành vi ác ý mưu toan chia rẽ đất nước, phá hoại ổn định xã hội, cơ quan tư pháp bắt buộc phải kiên quyết giáng đòn trừng phạt theo đúng pháp luật.",
          "explanation": "\"予以坚决打击\" thể hiện tính nghiêm minh không khoan nhượng của luật pháp quốc gia."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 104,
      "name": "Cấu trúc can thiệp xử lý đối tượng: \"动词 + 加以\"",
      "pattern": "对 / 对于 + Đối tượng, 必须 / 应当 + 加以 + Động từ song âm tiết (解决 / 限制 / 引导 / 保护 / 改进)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"加以\" (jiāyǐ) là động từ hình thức cao cấp trong văn viết chính luận, đứng trước các động từ ngoại động từ song âm tiết để biểu thị việc thực thi một hành động tác động lên đối tượng được nhắc tới trước đó (tiến hành, áp dụng biện pháp). Thường đi với 解决 (giải quyết), 限制 (hạn chế), 引导 (định hướng), 保护 (bảo vệ).",
      "examples": [
        {
          "chinese": "对于网络虚假信息的泛滥蔓延，相关监管部门必须及时加以严格规范与严厉治理。",
          "pinyin": "Duìyú wǎngluò xūjiǎ xìnxī de fànlàn mànyán, xiāngguān jiānguǎn bùmén bìxū jíshí jiāyǐ yángé guīfàn yǔ yánlì zhìlǐ.",
          "translation_vi": "Đối với sự tràn lan lan truyền của thông tin giả mạo trên không gian mạng, các cơ quan giám sát hữu quan bắt buộc phải kịp thời tiến hành quy chuẩn nghiêm ngặt và quản trị nghiêm minh.",
          "explanation": "\"加以严格规范与治理\" dùng \"加以\" chỉ đạo triển khai biện pháp quản lý không gian mạng."
        },
        {
          "chinese": "青年人在树立正确价值观的关键时期，家庭和学校应当耐心加以正面启发与引导。",
          "pinyin": "Qīngniánrén zài shùlì zhèngquè jiàzhíguān de guānjiàn shíqī, jiātíng hé xuéxiào yīngdāng nàixīn jiāyǐ zhèngmiàn qǐfā yǔ yǐndǎo.",
          "translation_vi": "Thanh niên trong giai đoạn then chốt hình thành hệ giá trị đúng đắn, gia đình và nhà trường cần nhẫn nại tiến hành gợi mở và định hướng tích cực.",
          "explanation": "\"加以正面启发与引导\" nhấn mạnh phương pháp sư phạm kiên trì định hướng thế hệ trẻ."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 105,
      "name": "Cấu trúc cố định quy định phạm vi pháp lý: \"在...范围内\" / \"在...框架下\"",
      "pattern": "在 + Pháp luật / Thẩm quyền / Khế ước + 的范围内 / 框架下, Tiến hành hành vi",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"在...范围内\" (trong phạm vi) và \"在...框架下\" (dưới khuôn khổ) là hai công thức chuẩn xác xác lập giới hạn hợp pháp, biên độ cho phép của một hành động quản trị, giao dịch thương mại hoặc hợp tác quốc tế.",
      "examples": [
        {
          "chinese": "任何组织和个人行使自身民事权利时，都必须严格在宪法和法律规定的范围内进行。",
          "pinyin": "Rènhé zǔzhī hé gèrén xíngshǐ zìshēn mínshì quánlì shí, dōu bìxū yángé zài xiànfǎ hé fǎlǜ guīdìng de fànwéi nèi jìnxíng.",
          "translation_vi": "Bất kỳ tổ chức và cá nhân nào khi thực thi quyền dân sự của bản thân đều phải tiến hành nghiêm ngặt trong phạm vi mà hiến pháp và pháp luật quy định.",
          "explanation": "\"在宪法和法律规定的范围内\" khẳng định ranh giới tối thượng của nhà nước pháp quyền."
        },
        {
          "chinese": "两国将继续在联合国等多边国际框架下，加强应对气候变化领域的密切合作。",
          "pinyin": "Liǎng guó jiāng jìxù zài Liánhéguó děng duōbiān guójì kuàngjià xià, jiāqiáng yìngduì qìhòu biànhuà lǐngyù de mìqiè hézuò.",
          "translation_vi": "Hai nước sẽ tiếp tục tăng cường hợp tác chặt chẽ trong lĩnh vực ứng phó biến đổi khí hậu dưới khuôn khổ quốc tế đa phương như Liên Hợp Quốc.",
          "explanation": "\"在...多边国际框架下\" là thuật ngữ hợp tác ngoại giao đa phương chính thống."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 106,
      "name": "Cấu trúc cố định định vị quá trình phát triển thời đại: \"随着...的深入\"",
      "pattern": "随着 + Đề án/Nghiên cứu/Cải cách + 的深入 (推进/开展), Mệnh đề hệ quả",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"随着...的深入\" (suízhe... de shēnrù) là cấu trúc mở màn kinh điển trong các bài luận văn, báo cáo thời sự, biểu thị sự việc, đề án đang đi vào giai đoạn chiều sâu, thực chất và toàn diện hơn, từ đó kéo theo chuỗi biến đổi tích cực tương ứng.",
      "examples": [
        {
          "chinese": "随着新一轮课程教学改革的深入推进，学生们的自主探究能力得到了显著提高。",
          "pinyin": "Suízhe xīn yì lún kèchéng jiàoxué gǎigé de shēnrù tuījìn, xuéshengmen de zìzhǔ tànjiū nénglì dédào le xiǎnzhù tígāo.",
          "translation_vi": "Cùng với sự thúc đẩy đi vào chiều sâu của đợt cải cách giảng dạy chương trình mới, năng lực tự chủ tìm tòi của học sinh đã được nâng cao rõ rệt.",
          "explanation": "\"随着...深入推进\" ghi nhận thành quả cụ thể theo từng giai đoạn của đề án cải cách giáo dục."
        },
        {
          "chinese": "随着现代医学对大脑奥秘研究的逐步深入，人类征服阿尔茨海默病迎来了崭新的曙光。",
          "pinyin": "Suízhe xiàndài yīxué duì dànǎo àomì yánjiū de zhúbù shēnrù, rénlèi zhēngfú ā'ěrcíhǎimòbìng yínglái le zhǎnxīn de shǔguāng.",
          "translation_vi": "Cùng với sự đi sâu từng bước của y học hiện đại đối với việc nghiên cứu bí ẩn bộ não, nhân loại chinh phục căn bệnh Alzheimer đã đón chào ánh bình minh hoàn toàn mới.",
          "explanation": "\"随着...逐步深入\" miêu tả bước tiến khoa học thần kinh mở ra hy vọng chữa bệnh cho loài người."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 107,
      "name": "Cấu trúc cố định chỉ nhân tố quyết định sống còn: \"取决于\"",
      "pattern": "Sự thành bại / Tương lai của A, 取决于 + Nhân tố cốt lõi B",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"取决于\" (qǔjuéyú) biểu thị kết quả, số phận, sự thành bại hoặc hướng phát triển của một sự vật phụ thuộc hoàn toàn vào một nhân tố then chốt làm điều kiện chi phối (do... quyết định, phụ thuộc cốt yếu vào).",
      "examples": [
        {
          "chinese": "一个科研团队能否攀登科学高峰，很大程度上取决于全体成员是否具有坚忍不拔的毅力。",
          "pinyin": "Yí gè kēyán tuánduì néngfǒu pāndēng kēxué gāofēng, hěn dà chéngdù shang qǔjuéyú quántǐ chéngyuán shìfǒu jùyǒu jiānrěnbùbá de yìlì.",
          "translation_vi": "Một nhóm nghiên cứu khoa học có thể leo lên đỉnh cao khoa học hay không phần lớn phụ thuộc vào việc toàn thể thành viên có ý chí kiên định không dời hay không.",
          "explanation": "\"取决于...毅力\" chỉ ra nhân tố quyết định thành bại của đề tài nghiên cứu chính là nghị lực con người."
        },
        {
          "chinese": "谈判最终能否达成实质性协议，完全取决于双方在核心关切问题上所展现的诚意。",
          "pinyin": "Tánpàn zuìzhōng néngfǒu dáchéng shízhìxìng xiéyì, wánquán qǔjuéyú shuāngfāng zài héxīn guānqiè wèntí shang suǒ zhǎnxiàn de chéngyì.",
          "translation_vi": "Cuộc đàm phán cuối cùng có thể đạt được hiệp định thực chất hay không phụ thuộc hoàn toàn vào thành ý mà đôi bên thể hiện trên các vấn đề quan ngại cốt lõi.",
          "explanation": "\"完全取决于...诚意\" xác định thành ý thiện chí là chìa khóa mở nút thắt đàm phán."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 108,
      "name": "Cấu trúc cố định truy nguyên cội nguồn: \"源于\"",
      "pattern": "Hiện tượng / Tư tưởng / Sức mạnh + 源于 + Cội nguồn thực tế / Đời sống nhân dân",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"源于\" (yuányú) biểu thị một tác phẩm nghệ thuật, tư tưởng triết học hoặc sức mạnh vĩ đại bắt nguồn từ hoặc bắt rễ sâu xa từ thực tiễn đời sống, lịch sử hoặc sự tích lũy lâu đời (kết hợp 源: nguồn nước, 于: từ). Công thức văn học nổi tiếng: \"艺术源于生活，又高于生活\".",
      "examples": [
        {
          "chinese": "优秀的文学艺术创作必须牢牢植根于人民群众，因为一切真正的艺术灵感都源于火热的现实生活。",
          "pinyin": "Yōuxiù de wénxué yìshù chuàngzuò bìxū láoláo zhígēnyú rénmín qúnzhòng, yīnwèi yíqiè zhēnzhèng de yìshù línggǎn dōu yuányú huǒrè de xiànshí shēnghuó.",
          "translation_vi": "Sáng tác văn học nghệ thuật xuất sắc bắt buộc phải cắm rễ sâu chắc vào quần chúng nhân dân, bởi vì mọi cảm hứng nghệ thuật chân chính đều bắt nguồn từ đời sống hiện thực sôi động.",
          "explanation": "\"艺术灵感都源于生活\" trích dẫn triết lý nghệ thuật kinh điển về cội nguồn sáng tạo."
        },
        {
          "chinese": "中华文明之所以历经数千年风雨而生生不息，源于其海纳百川的包容精神与自强不息的品格。",
          "pinyin": "Zhōnghuá wénmíng zhīsuǒyǐ lìjīng shù qiān nián fēngyǔ ér shēngshēngbùxī, yuányú qí hǎinàbǎichuān de bāoróng jīngshén yǔ zìqiángbùxī de pǐngé.",
          "translation_vi": "Văn minh Trung Hoa sở dĩ trải qua hàng nghìn năm phong ba mà vẫn trường tồn phát triển không ngừng, là bắt nguồn từ tinh thần bao dung như biển lớn dung nạp trăm sông và phẩm cách tự lực tự cường.",
          "explanation": "\"源于其...包容精神\" giải thích sức sống trường tồn của nền văn minh cổ đại."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 109,
      "name": "Cặp cấu trúc phẩm chất lãnh đạo đối ứng: \"勇于\" vs \"善于\"",
      "pattern": "勇于 + Đối mặt/Chấp nhận gian nan (担当 / 创新 / 承认错误) & 善于 + Kỹ năng thông thái (沟通 / 总结 / 发现人才)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "Đây là cặp từ ghép chính luận song hành miêu tả bản lĩnh và trí tuệ của người lãnh đạo: 1) \"勇于\" (dũng cảm, dám đương đầu với khó khăn mạo hiểm, dám chịu trách nhiệm); 2) \"善于\" (giỏi về, khéo léo, có tài năng và phương pháp khoa học để xử lý tình huống).",
      "examples": [
        {
          "chinese": "一名优秀的团队领袖不仅要勇于承担责任风险，更要善于倾听并凝聚全体成员的智慧。",
          "pinyin": "Yì míng yōuxiù de tuánduì lǐngxiù bùjǐn yào yǒngyú chéngdān zérèn fēngxiǎn, gèng yào shànyú qīngtīng bìng níngjù quántǐ chéngyuán de zhìhuì.",
          "translation_vi": "Một người lãnh đạo đội ngũ xuất sắc chẳng những phải dũng cảm gánh vác rủi ro trách nhiệm, mà càng phải giỏi lắng nghe và quy tụ trí tuệ của toàn thể thành viên.",
          "explanation": "\"勇于承担责任\" và \"善于倾听\" kết hợp hoàn hảo giữa lòng can đảm và trí tuệ lắng nghe."
        },
        {
          "chinese": "年轻人在工作中要勇于跳出思维定势，善于在看似平凡的岗位上总结规律发现新机遇。",
          "pinyin": "Niánqīngrén zài gōngzuò zhōng yào yǒngyú tiàochū sīwéi dìngshì, shànyú zài kànsì píngfán de gǎngwèi shang zǒngjié guīlǜ fāxiàn xīn jīyù.",
          "translation_vi": "Người trẻ trong công việc cần dũng cảm bước ra khỏi lối mòn tư duy, giỏi đúc kết quy luật và phát hiện cơ hội mới ở những vị trí tưởng như bình dị.",
          "explanation": "\"勇于跳出...善于总结...\" định hướng tác phong làm việc sáng tạo cho nhân viên trẻ."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 110,
      "name": "Cấu trúc cố định quy nạp toàn văn trang trọng: \"总而言之\"",
      "pattern": "Phân tích các luận cứ. 总而言之, Kết luận đúc kết toàn diện",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"总而言之\" (zǒng'éryánzhī) là cấu trúc kết luận cao cấp bậc nhất trong văn nghị luận HSK 5 (kết hợp 总: tổng quát, 言: nói, 之: nó). Đứng ở đầu đoạn văn cuối cùng để thâu tóm toàn bộ các luận điểm đã triển khai thành một thông điệp cốt lõi, sâu sắc và thuyết phục nhất (tóm lại mà nói, nói tóm lại).",
      "examples": [
        {
          "chinese": "总而言之，科技创新不仅是推动经济高质量发展的核心引擎，更是赢得未来国际竞争主动权的关键基石。",
          "pinyin": "Zǒng'éryánzhī, kējì chuàngxīn bùjǐn shì tuīdòng jīngjì gāozhìliàng fāzhǎn de héxīn yǐnqíng, gèng shì yíngdé wèilái guójì jìngzhēng zhǔdòngquán de guānjiàn jīshí.",
          "translation_vi": "Tóm lại mà nói, đổi mới sáng tạo công nghệ chẳng những là động cơ cốt lõi thúc đẩy kinh tế phát triển chất lượng cao, mà càng là nền tảng then chốt để giành thế chủ động trong cạnh tranh quốc tế tương lai.",
          "explanation": "\"总而言之\" đứng đầu đoạn kết nâng tầm ý nghĩa của đổi mới công nghệ lên tầm vóc vận mệnh dân tộc."
        },
        {
          "chinese": "总而言之，幸福的生活不可能靠坐享其成，唯有脚踏实地奋斗才能铸就无愧于时代的辉煌业绩。",
          "pinyin": "Zǒng'éryánzhī, xìngfú de shēnghuó bù kěnéng kào zuòxiǎngqíchéng, wéiyǒu jiǎotàshídì fèndòu cái néng zhùjiù wúkuì yú shídài de huīhuáng yèjì.",
          "translation_vi": "Nói tóm lại, cuộc sống hạnh phúc không thể dựa vào việc ngồi mát ăn bát vàng, duy chỉ có phấn đấu từng bước vững chắc mới có thể đúc nên những thành tích huy hoàng không hổ thẹn với thời đại.",
          "explanation": "\"总而言之\" đúc kết toàn văn với thông điệp nhân sinh tích cực lay động lòng người."
        }
      ],
      "hsk_level": "HSK 5",
      "source": "gf0025_2021",
      "validation_status": "verified"
    }
  ],
  "HSK 6": [
    {
      "order_index": 1,
      "name": "Đại từ văn ngôn tân ngữ & sở thuộc \"之\" (Nó / Của nó / Họ / Điều đó)",
      "pattern": "Động từ + 之 / Danh từ + 之 + Danh từ / 之所以...是因为... / ...之一 / 忘之 / 避之不及",
      "category": "Đại từ",
      "explanation_vi": "\"之\" (zhī) là một trong những hư từ văn ngôn quan trọng nhất trong tiếng Trung cổ và hiện đại. Trong HSK 6, \"之\" đóng vai trò đại từ làm tân ngữ trực tiếp thay thế cho người, vật hoặc sự việc vừa được nhắc tới (tương đương với \"他/她/它\" hoặc \"他们\"). Ngoài ra \"之\" làm trợ từ sở thuộc tương đương \"的\", xuất hiện trong các cấu trúc kinh điển như \"之所以...是因为...\", \"取之于民，用之于民\".",
      "examples": [
        {
          "chinese": "优秀的文化传统是民族的血脉，我们应当倍加珍惜之、弘扬之。",
          "pinyin": "Yōuxiù de wénhuà chuántǒng shì mínzú de xuèmài, wǒmen yīngdāng bèijiā zhēnxī zhī, hóngyáng zhī.",
          "translation_vi": "Truyền thống văn hóa xuất sắc là huyết mạch của dân tộc, chúng ta cần phải hết sức trân trọng nó, phát huy nó.",
          "explanation": "\"珍惜之、弘扬之\" dùng \"之\" làm tân ngữ thay thế trực tiếp cho \"优秀的文化传统\", mang lại nhịp điệu biền ngẫu trang nghiêm."
        },
        {
          "chinese": "政府设立这项专项基金的根本初衷，就在于取之于民并全额用之于民。",
          "pinyin": "Zhèngfǔ shèlì zhè xiàng zhuānxiàng jījīn de gēnběn chūzhōng, jiù zàiyú qǔ zhī yú mín bìng quán'é yòng zhī yú mín.",
          "translation_vi": "Ý định ban đầu căn bản của chính phủ khi thành lập quỹ chuyên dùng này chính là lấy của dân và dùng toàn bộ phục vụ nhân dân.",
          "explanation": "\"取之于民，用之于民\" là châm ngôn quản trị quốc gia kinh điển thể hiện trách nhiệm tài chính công đối với nhân dân."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 2,
      "name": "Đại từ nhân xưng & chỉ thị văn ngôn \"尔\" (Ngươi / Mày / Như thế / Thế thôi)",
      "pattern": "尔等 (các ngươi) / 尔后 (sau đó) / 不过尔尔 (chẳng qua chỉ có vậy)",
      "category": "Đại từ",
      "explanation_vi": "\"尔\" (ěr) là đại từ nhân xưng ngôi thứ hai văn ngôn (ngươi, các ngươi) hoặc mang nghĩa chỉ thị \"như thế, ngần ấy\" (tương đương \"如此, 罢了\"). Thành ngữ HSK 6 \"不过尔尔\" miêu tả sự vật tầm thường, bình thường chẳng qua chỉ đến thế mà thôi.",
      "examples": [
        {
          "chinese": "原以为这家号称百年老字号的餐馆菜肴非同凡响，实地品尝后才发现水平不过尔尔。",
          "pinyin": "Yuán yǐwéi zhè jiā hàochēng bǎinián lǎozìhào de cānguǎn càiyáo fēitóngfánxiǎng, shídì pǐncháng hòu cái fāxiàn shuǐpíng búguò'ěr'ěr.",
          "translation_vi": "Cứ ngỡ món ăn của nhà hàng tự xưng trăm năm danh tiếng này xuất chúng phi phàm, sau khi thưởng thức thực tế mới phát hiện trình độ cũng chỉ bình thường đến thế mà thôi.",
          "explanation": "\"不过尔尔\" thể hiện sự thất vọng tinh tế đối với chất lượng không tương xứng với danh tiếng đồn thổi."
        },
        {
          "chinese": "双方就停火协议达成初步共识，尔后将展开关于战后重建细节的深入磋商。",
          "pinyin": "Shuāngfāng jiù tínghuǒ xiéyì dáchéng chūbù gòngshí, ěrhòu jiāng zhǎnkāi guānyú zhànhòu chóngjiàn xìjié de shēnrù cuōshāng.",
          "translation_vi": "Đôi bên đã đạt được đồng thuận sơ bộ về thỏa thuận ngừng bắn, sau đó sẽ triển khai tham vấn sâu rộng về các chi tiết tái thiết hậu chiến.",
          "explanation": "\"尔后\" là từ nối văn ngôn trang trọng biểu thị mốc thời gian nối tiếp tương đương với \"此后, 以后\"."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 3,
      "name": "Đại từ văn ngôn chỉ định tập hợp số nhiều \"诸\" (Chư / Các / Mọi)",
      "pattern": "诸 + Danh từ / 诸位 / 诸如此类 / 付诸实施 / 付诸东流",
      "category": "Đại từ",
      "explanation_vi": "\"诸\" (zhū) có hai công năng cốt lõi trong HSK 6: 1) Đại từ văn ngôn chỉ số nhiều (các, chư, nhiều), như 诸位 (chư vị), 诸子百家 (chư tử bách gia), 诸事 (mọi việc); 2) Kiêm từ văn ngôn gộp của \"之于\" (đối với nó, vào đó) trong các kết cấu: 付诸实施 (đưa vào thực thi), 付诸东流 (đổ sông đổ biển).",
      "examples": [
        {
          "chinese": "宏伟的规划如果仅仅停留在纸面上而不付诸实施，终究不过是一纸空谈。",
          "pinyin": "Hóngwěi de guīhuà rúguǒ jǐnjǐn tíngliú zài zhǐmiàn shang ér bú fù zhū shíshī, zhōngjiū búguò shì yì zhǐ kōngtán.",
          "translation_vi": "Quy hoạch hùng vĩ nếu như chỉ dừng lại trên mặt giấy tờ mà không đưa vào thực thi, rốt cuộc cũng chẳng qua chỉ là một tờ giấy sáo rỗng.",
          "explanation": "\"付诸实施\" mang cấu trúc \"付之于实施\" (đem nó áp dụng vào thực tiễn), là quán dụng ngữ chính trị cao cấp."
        },
        {
          "chinese": "商场里摆满了智能手表、无线耳机、扫地机器人诸如此类的高科技消费品。",
          "pinyin": "Shāngchǎng lǐ bǎimǎn le zhìnéng shǒubiǎo, wúxiàn ěrjī, sǎodì jīqìrén zhū rúcǐ lèi de gāo kējì xiāofèipǐn.",
          "translation_vi": "Trong trung tâm thương mại bày đầy đồng hồ thông minh, tai nghe không dây, robot hút bụi cùng các loại sản phẩm tiêu dùng công nghệ cao đại loại như thế.",
          "explanation": "\"诸如此类\" là thành ngữ ngữ pháp hóa liệt kê đại từ tương đương với \"等等此类\" (các loại như vậy)."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 4,
      "name": "Đại từ xưng hô tôn kính ngoại giao đỉnh cao \"阁下\" (Các hạ / Ngài)",
      "pattern": "阁下 + Lời chào nghi lễ / Tổng thống / Thủ tướng + 阁下",
      "category": "Đại từ",
      "explanation_vi": "\"阁下\" (géxià) là đại từ xưng hô nghi lễ ngoại giao cấp cao nhất dành cho nguyên thủ quốc gia, thủ tướng, đại sứ đặc mệnh toàn quyền hoặc các yếu nhân quốc tế (Các hạ, Kính thưa Ngài).",
      "examples": [
        {
          "chinese": "尊敬的总统阁下，我谨代表全体中国人民向您及贵国人民致以最诚挚的祝贺。",
          "pinyin": "Zūnjìng de zǒngtǒng géxià, wǒ jǐn dàibiǎo quántǐ Zhōngguó rénmín xiàng nín jí guìguó rénmín zhìyǐ zuì chéngzhì de zhùhè.",
          "translation_vi": "Kính thưa Tổng thống Các hạ, tôi xin trân trọng đại diện cho toàn thể nhân dân Trung Quốc gửi tới Ngài cùng nhân dân quý quốc lời chúc mừng chân thành nhất.",
          "explanation": "\"总统阁下\" là nghi thức xưng hô ngoại giao nguyên thủ quốc gia tối cao theo công pháp quốc tế."
        },
        {
          "chinese": "大使阁下在任期内为增进两国人民之间的传统友谊作出了不可磨灭的历史贡献。",
          "pinyin": "Dàshǐ géxià zài rènqī nèi wèi zēngjìn liǎng guó rénmín zhījiān de chuántǒng yǒuyì zuòchū le bùkě mómì de lìshǐ gòngxiàn.",
          "translation_vi": "Đại sứ Các hạ trong nhiệm kỳ của mình đã đóng góp những cống hiến lịch sử không thể phai mờ vào việc thắt chặt tình hữu nghị truyền thống giữa nhân dân hai nước.",
          "explanation": "\"大使阁下\" thể hiện sự tôn vinh cao quý dành cho vị trưởng đoàn ngoại giao nước bạn."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 5,
      "name": "Cụm đại từ văn ngôn bao quát tổng kết \"凡此种种\" (Phàm tất thảy những điều đó)",
      "pattern": "Liệt kê các hiện tượng phức tạp... 凡此种种, 皆 / 都 + Kết luận quy nạp",
      "category": "Đại từ",
      "explanation_vi": "\"凡此种种\" (fán cǐ zhǒngzhǒng) là cụm từ văn ngôn quy nạp độc lập đứng ở đầu phân câu kết luận, có nghĩa là \"phàm tất thảy những hiện tượng, nguyên nhân đa dạng vừa được liệt kê ở trên\". Dùng để thâu tóm toàn bộ dữ kiện thành một nhận định bản chất.",
      "examples": [
        {
          "chinese": "缺乏科学规划、盲目投资扩张、内部管理松懈，凡此种种，最终导致了企业的破产重组。",
          "pinyin": "Quēfá kēxué guīhuà, mángmù tóuzī kuòzhāng, nèibù guǎnlǐ sōngxiè, fán cǐ zhǒngzhǒng, zuìzhōng dǎozhì le qǐyè de pòchǎn chóngzǔ.",
          "translation_vi": "Thiếu quy hoạch khoa học, mù quáng đầu tư bành trướng, quản lý nội bộ lỏng lẻo, phàm tất thảy những điều đó, cuối cùng đã dẫn tới việc doanh nghiệp phá sản tái cơ cấu.",
          "explanation": "\"凡此种种\" thâu tóm toàn bộ 3 căn nguyên sai lầm quản trị dẫn tới kết cục sụp đổ của công ty."
        },
        {
          "chinese": "民俗文化的传承、民间工艺的保护、非遗技艺的弘扬，凡此种种，皆需要全社会共同关注。",
          "pinyin": "Mínsú wénhuà de chuánchéng, mínjiān gōngyì de bǎohù, fēiyí jìyì de hóngyáng, fán cǐ zhǒngzhǒng, jiē xūyào quán shèhuì gòngtóng guānzhù.",
          "translation_vi": "Sự kế thừa văn hóa dân gian, sự bảo tồn nghề thủ công làng quê, sự phát huy kỹ nghệ phi vật thể, phàm tất cả những điều đó, đều cần sự chung tay quan tâm của toàn xã hội.",
          "explanation": "\"凡此种种，皆需要...\" quy nạp các nhánh di sản văn hóa vào mối quan tâm chung của toàn dân."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 6,
      "name": "Danh lượng từ thi ca chỉ làn, luồng tơ mỏng manh \"缕\" (Làn / Luồng / Sợi / Tia)",
      "pattern": "Số từ + 缕 + Danh từ (清风 / 阳光 / 炊烟 / 哀思 / 思绪 / 幽香)",
      "category": "Lượng từ",
      "explanation_vi": "\"缕\" (lǚ) là lượng từ thi ca cực kỳ tinh tế, dùng cho: 1) Các hiện tượng tự nhiên thanh thoát, nhẹ nhàng như sợi tơ (một làn gió mát, một luồng khói bếp, một tia nắng sớm); 2) Cảm xúc, tâm tư hoặc nỗi niềm vương vấn trong lòng (một niềm tiếc thương, một mối tơ lòng).",
      "examples": [
        {
          "chinese": "清晨，一缕金色的阳光穿过茂密的松林，在青翠的草地上洒下了斑驳的林荫。",
          "pinyin": "Qīngchén, yì lǚ jīnsè de yángguāng chuānguò màomì de sōnglín, zài qīngcuì de cǎodì shang sǎxià le bānbó de línyīn.",
          "translation_vi": "Sáng sớm, một tia nắng vàng rực rỡ xuyên qua rừng thông rậm rạp, rọi bóng cây lốm đốm xuống thảm cỏ xanh mướt.",
          "explanation": "\"一缕金色的阳光\" dùng \"缕\" đặc tả tia nắng mai mềm mại xuyên qua kẽ lá."
        },
        {
          "chinese": "微风徐徐吹过湖面，送来了一缕沁人心脾的荷花幽香。",
          "pinyin": "Wēifēng xúxú chuīguò húmiàn, sònglái le yì lǚ qìnrénxīnpí de héhuā yōuxiāng.",
          "translation_vi": "Làn gió nhẹ từ từ lướt qua mặt hồ, mang theo một làn hương hoa sen thanh tao làm mát tận lòng người.",
          "explanation": "\"一缕...荷花幽香\" định lượng cho làn hương sen thoang thoảng dịu êm."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 7,
      "name": "Danh lượng từ hội họa chỉ vệt màu, nét cười \"抹\" (Vệt / Vạt / Nét)",
      "pattern": "Số từ + 抹 + Danh từ (晚霞 / 微笑 / 斜阳 / 亮色 / 忧伤)",
      "category": "Lượng từ",
      "explanation_vi": "\"抹\" (mǒ) có nguồn gốc từ động từ quệt màu, quét sơn trong hội họa. Khi làm lượng từ, \"抹\" chuyên dùng cho những mảng màu sắc trên nền trời tự nhiên (như 一抹晚霞 - một vạt ráng chiều) hoặc biểu cảm thoảng qua trên khuôn mặt con người (như 一抹微笑 - một nét cười thoáng qua).",
      "examples": [
        {
          "chinese": "夕阳西下，天边残留着一抹绚烂如锦的火红晚霞。",
          "pinyin": "Xīyáng xīxià, tiānbiān cánliúzhe yì mǒ xuànlàn rújǐn de huǒhóng wǎnxiá.",
          "translation_vi": "Mặt trời lặn về tây, nơi chân trời còn sót lại một vạt ráng chiều đỏ rực rỡ đẹp tựa gấm thêu.",
          "explanation": "\"一抹...晚霞\" dùng \"抹\" định lượng cho dải mây chiều lộng lẫy nơi góc trời hoàng hôn."
        },
        {
          "chinese": "得知考试合格的好消息，她紧绷的嘴角边终于浮现出了一抹舒心的微笑。",
          "pinyin": "Dézhī kǎoshì hégé de hǎo xiāoxi, tā jǐnbēng de zuǐjiǎobiān zhōngyú fúxiàn chū le yì mǒ shūxīn de wēixiào.",
          "translation_vi": "Được tin kỳ thi đã qua môn, khóe miệng đang căng thẳng của cô cuối cùng đã hé nở một nét cười thanh thản.",
          "explanation": "\"一抹舒心的微笑\" miêu tả nét cười nhẹ nhõm thoáng hiện trên nét mặt xua tan lo lắng."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 8,
      "name": "Danh lượng từ nghệ thuật cổ chỉ bức tranh cuộn trục \"轴\" (Trục / Cuộn / Bức tranh cuộn)",
      "pattern": "Số từ + 轴 + Danh từ (画卷 / 山水画 / 长卷 / 史诗)",
      "category": "Lượng từ",
      "explanation_vi": "\"轴\" (zhóu) là lượng từ chuyên dùng cho tranh thủy mạc, tranh thư pháp cổ truyền Trung Hoa được gắn trục cuốn lại thành cuộn dài (như 一轴山水画 - một bức tranh cuộn sơn thủy, 一轴长卷). Thường dùng ẩn dụ cho bức tranh lịch sử hào hùng (như 一轴波澜壮阔的历史画卷).",
      "examples": [
        {
          "chinese": "展厅正中央徐徐展开了一轴传世千年的北宋青绿山水古画长卷。",
          "pinyin": "Zhǎntīng zhèng zhōngyāng xúxú zhǎnkāi le yì zhóu chuánshì qiānnián de Běisòng qīnglǜ shānshuǐ gǔhuà chángjuàn.",
          "translation_vi": "Chính giữa phòng triển lãm từ từ mở ra một cuộn tranh dài sơn thủy thanh lục thời Bắc Tống truyền đời ngàn năm.",
          "explanation": "\"一轴...古画长卷\" dùng \"轴\" định lượng cho bức thư họa cổ trang quý báu cuộn trên trục gỗ."
        },
        {
          "chinese": "新时代的发展进程宛如一轴波澜壮阔的历史宏伟长卷，记录着人民奋斗的足迹。",
          "pinyin": "Xīn shídài de fāzhǎn jìnchéng wǎnrú yì zhóu bōlánzhuàngkuò de lìshǐ hóngwěi chángjuàn, jìlùzhe rénmín fèndòu de zújì.",
          "translation_vi": "Tiến trình phát triển của thời đại mới ví tựa một bức tranh cuộn lịch sử tráng lệ sóng gió muôn trùng, ghi lại những dấu chân phấn đấu của nhân dân.",
          "explanation": "\"一轴...历史画卷\" dùng \"轴\" theo nghĩa ẩn dụ thi ca tôn vinh sự nghiệp đổi mới của đất nước."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 9,
      "name": "Danh lượng từ điện ảnh & nhiếp ảnh chỉ khung hình \"帧\" (Khung hình / Tấm)",
      "pattern": "Số từ + 帧 + Danh từ (画面 / 胶片 / 照片 / 影像)",
      "category": "Lượng từ",
      "explanation_vi": "\"帧\" (zhēn) là lượng từ chuyên môn trong nghệ thuật điện ảnh, truyền hình số và nhiếp ảnh, biểu thị một khung hình ảnh đơn lẻ (frame) trong một chuỗi phim chuyển động hoặc một bức ảnh nghệ thuật tĩnh vật cao cấp (như 一帧画面, 每一帧 đều là kiệt tác).",
      "examples": [
        {
          "chinese": "这部纪录片的拍摄构图极其考究，可以说电影里的每一帧画面都美得令人窒息。",
          "pinyin": "Zhè bù jìlùpiàn de pāishè gòutú jíqí kǎojiu, kěyǐ shuō diànyǐng lǐ de měi yì zhēn huàmiàn dōu měi de lìngrénzhìxī.",
          "translation_vi": "Bố cục quay phim của bộ phim tài liệu này cực kỳ tinh tế, có thể nói từng khung hình trong phim đều đẹp đến ngạt thở.",
          "explanation": "\"每一帧画面\" ca ngợi nghệ thuật thị giác đỉnh cao của tác phẩm điện ảnh."
        },
        {
          "chinese": "高速摄像机以每秒一千帧的惊人速度，清晰捕捉到了雨滴落入水面的微观瞬间。",
          "pinyin": "Gāosù shèxiàngjī yǐ měi miǎo yìqiān zhēn de jīngrén sùdù, qīngxī bǔzhuō dào le yǔdī luòrù shuǐmiàn de wēiguān shùnjiān.",
          "translation_vi": "Chiếc máy quay tốc độ cao với tốc độ đáng kinh ngạc 1000 khung hình/giây đã bắt trọn rõ nét khoảnh khắc vi mô hạt mưa rơi chạm mặt nước.",
          "explanation": "\"每秒一千帧\" dùng \"帧\" làm đơn vị đo lường tần số quét khung hình công nghệ cao."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 10,
      "name": "Danh lượng từ y học cổ truyền chỉ liều, thang thuốc \"剂\" (Liều / Thang / Liều thuốc)",
      "pattern": "Số từ + 剂 + Danh từ (良药 / 补药 / 强心针 / 疫苗 / 镇静剂)",
      "category": "Lượng từ",
      "explanation_vi": "\"剂\" (jì) là lượng từ y dược chuyên dùng cho một thang thuốc thang hoàn chỉnh, một liều vắc-xin tiêm chủng (như 一剂疫苗), hoặc dùng theo nghĩa ẩn dụ triết học cho một lời khuyên chân thành thức tỉnh con người (như 一剂良药 - một liều thuốc tốt đắng miệng, 一剂强心针 - một liều thuốc trợ tim cổ vũ tinh thần).",
      "examples": [
        {
          "chinese": "这篇针砭时弊的犀利评论宛如一剂苦口良药，振聋发聩地警醒了迷茫中的年轻人。",
          "pinyin": "Zhè piān zhēnbiānshíbì de xīlì pínglùn wǎnrú yí jì kǔkǒu liángyào, zhènlóngfākuì de jǐngxǐng le mímáng zhōng de niánqīngrén.",
          "translation_vi": "Bài bình luận sắc sảo châm thẳng vào tệ nạn thời thế này ví tựa một thang thuốc đắng dã tật, đã gióng lên hồi chuông cảnh tỉnh người trẻ đang hoang mang lạc lối.",
          "explanation": "\"一剂苦口良药\" dùng \"剂\" ẩn dụ cho bài học đạo đức nghiêm khắc nhưng cứu rỗi nhận thức."
        },
        {
          "chinese": "政府及时出台的减税降费纾困政策，为陷入低谷的实体经济注入了一剂强心针。",
          "pinyin": "Zhèngfǔ jíshí chūtái de jiǎnshuì jiàngfèi shūkùn zhèngcè, wèi xiànrù dīgǔ de shítǐ jīngjì zhùrù le yí jì qiángxīnzhēn.",
          "translation_vi": "Chính sách giảm thuế hạ phí tháo gỡ khó khăn kịp thời của chính phủ đã tiêm một liều thuốc trợ tim cho nền kinh tế thực thể đang chìm trong đáy vực.",
          "explanation": "\"注入了一剂强心针\" là lối nói kinh tế quen thuộc chỉ gói kích thích tài khóa cứu nguy doanh nghiệp."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 11,
      "name": "Danh lượng từ thi ca cổ điển chỉ bài từ, khúc hát \"阕\" (Khúc / Bài từ / Bài ca)",
      "pattern": "Số từ + 阕 + Danh từ (宋词 / 词 / 乐曲 / 绝唱)",
      "category": "Lượng từ",
      "explanation_vi": "\"阕\" (què) là lượng từ văn học cổ điển chuyên biệt dành riêng cho các bài Tống từ (宋词) hoặc các khúc nhạc điệu nhã nhạc cung đình (như 一阕宋词, 上阕, 下阕). Thể hiện phong thái uyên bác, phong lưu của học giả văn phong cổ điển.",
      "examples": [
        {
          "chinese": "在中秋皓月当空之夜，文人墨客常常轻吟苏东坡那阕千古流传的水调歌头。",
          "pinyin": "Zài zhōngqiū hàoyuè dāngkōng zhī yè, wénrénmòkè chángcháng qīngyín Sū Dōngpō nà què qiāngǔ liúchuán de Shuǐdiàogētóu.",
          "translation_vi": "Vào đêm trung thu trăng sáng vằng vặc trên không trung, các bậc văn nhân thi sĩ thường ngâm nga bài từ \"Thủy Điệu Ca Đầu\" truyền tụng ngàn thu của Tô Đông Pha.",
          "explanation": "\"那一阕...水调歌头\" dùng \"阕\" làm lượng từ chuẩn mực cao quý cho kiệt tác Tống từ."
        },
        {
          "chinese": "古琴名家抚琴弹奏了一阕清幽旷远的古曲，令在场听众如痴如醉。",
          "pinyin": "Gǔqín míngjiā fǔqín tánzòu le yí què qīngyōu kuàngyuǎn de gǔqǔ, lìng zàichǎng tīngzhòng rúchīrúzuì.",
          "translation_vi": "Nghệ nhân đàn cổ cầm gảy tấu lên một khúc cổ nhạc thanh u khoáng đạt khiến khán giả có mặt đều mê mẩn ngất ngây.",
          "explanation": "\"一阕...古曲\" định lượng cho khúc nhạc thính phòng tao nhã xưa."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 12,
      "name": "Danh lượng từ chỉ vụ việc, cọc tâm sự phức tạp \"桩\" (Vụ / Mối / Chuyện)",
      "pattern": "Số từ + 桩 + Danh từ (心事 / 婚事 / 惨案 / 交易 / 疑案)",
      "category": "Lượng từ",
      "explanation_vi": "\"桩\" (zhuāng) có nguồn gốc từ cọc gỗ đóng đất. Khi dùng làm lượng từ, \"桩\" chuyên dùng cho các sự kiện, vụ án ly kỳ, hoặc các mối tâm tư, hôn sự lớn trong đời người (như 一桩心事 - một mối tâm sự nặng trĩu, 一桩婚姻 - một mối hôn sự, 一桩悬案 - một vụ kỳ án chưa có lời giải).",
      "examples": [
        {
          "chinese": "看到唯一的女儿顺利成家立业，老两口心头的一桩大心事终于落地了。",
          "pinyin": "Kàndào wéiyī de nǚ'ér shùnlì chéngjiālìyè, lǎo liǎngkǒu xīntóu de yì zhuāng dà xīnshì zhōngyú luòdì le.",
          "translation_vi": "Nhìn thấy cô con gái độc nhất yên bề gia thất lập nghiệp vững vàng, một mối tâm sự lớn trong lòng hai ông bà già cuối cùng cũng đã được trút bỏ.",
          "explanation": "\"一桩大心事\" dùng \"桩\" định lượng cho mối âu lo đăm đăm nuôi dạy con cái của cha mẹ."
        },
        {
          "chinese": "这桩轰动全国的长达三十年的历史悬案，经过现代DNA技术的比对终于水落石出。",
          "pinyin": "Zhè zhuāng hōngdòng quánguó de chángdá sānshí nián de lìshǐ xuán'àn, jīngguò xiàndài DNA jìshù de bǐduì zhōngyú shuǐluòshíchū.",
          "translation_vi": "Vụ án tồn đọng lịch sử kéo dài suốt 30 năm gây chấn động cả nước này, qua đối chiếu kỹ thuật DNA hiện đại cuối cùng đã sáng tỏ chân tướng.",
          "explanation": "\"这桩...历史悬案\" dùng \"桩\" làm lượng từ tư pháp chuẩn mực cho vụ án hình sự phức tạp."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 13,
      "name": "Danh lượng từ thi vị chỉ vầng trăng khuyết hình cánh cung \"弯\" (Mảnh / Vầng trăng cong)",
      "pattern": "一 + 弯 + Danh từ (新月 / 残月 / 月亮 / 清泉)",
      "category": "Lượng từ",
      "explanation_vi": "\"弯\" (wān) vốn là tính từ/động từ cong, uốn cong. Khi làm lượng từ nghệ thuật, \"弯\" chuyên dùng cho mảnh trăng non đầu tháng hoặc trăng tàn cuối tháng hình lưỡi liềm uốn cong thanh tú (như 一弯新月 - một mảnh trăng non).",
      "examples": [
        {
          "chinese": "夜幕初垂，深蓝色的天幕上静静地挂着一弯皎洁明亮的新月。",
          "pinyin": "Yèmù chūchuí, shēnlánsè de tiānmù shang jìngjìng de guàzhe yì wān jiǎojié míngliàng de xīnyuè.",
          "translation_vi": "Màn đêm vừa buông xuống, trên bức màn trời xanh thẳm lặng lẽ treo một mảnh trăng non trong sáng vằng vặc.",
          "explanation": "\"一弯...新月\" miêu tả hình ảnh trăng khuyết lưỡi liềm thanh tao trên bầu trời đêm yên tĩnh."
        },
        {
          "chinese": "山谷深处环绕着一弯碧绿澄澈的天然清泉，倒映着四周秀丽的奇峰。",
          "pinyin": "Shāngǔ shēnchù huánràozhe yì wān bìlǜ chéngchè de tiānrán qīngquán, dàoyìngzhe sìzhōu xiùlì de qífēng.",
          "translation_vi": "Nơi sâu trong thung lũng uốn quanh một dòng suối trong tự nhiên xanh biếc trong vắt, in bóng non ngút ngàn kỳ vĩ bốn bề.",
          "explanation": "\"一弯...清泉\" dùng \"弯\" định lượng cho dòng suối uốn lượn hình cánh cung mềm mại."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 14,
      "name": "Danh lượng từ chỉ cảnh tượng, khí thế bao trùm \"派\" (Cảnh / Vẻ / Khí thế)",
      "pattern": "一 + 派 + Danh từ cảnh tượng/không khí (生机 / 祥和 / 欣欣向荣 / 繁荣景象)",
      "category": "Lượng từ",
      "explanation_vi": "\"派\" (pài) khi làm lượng từ biểu thị một bầu không khí, cảnh tượng toàn cảnh hoặc một phong cách khí thế bao trùm khắp không gian (như 一派生机 - một vùng tràn đầy sức sống, 一派祥和 - một cảnh tượng an lành thái bình, 一派胡言 - toàn lời nói nhảm).",
      "examples": [
        {
          "chinese": "春回大地，万物复苏，田野山川到处呈现出一派生机勃勃的欣欣向荣景象。",
          "pinyin": "Chūnhuídàdì, wànwù fùsū, tiányě shānchuān dàochù chéngxiàn chū yí pài shēngjībóbó de xīnxīnxiàngróng jǐngxiàng.",
          "translation_vi": "Xuân về trên đất mẹ, muôn vật hồi sinh, đồng ruộng núi sông khắp nơi hiện ra một cảnh tượng dạt dào sức sống phồn vinh mơn mởn.",
          "explanation": "\"一派生机勃勃的景象\" miêu tả toàn cảnh không gian thiên nhiên trỗi dậy mãnh liệt vào mùa xuân."
        },
        {
          "chinese": "逢年过节，大街小巷张灯结彩，呈现出一派欢天喜地、安定祥和的节日氛围。",
          "pinyin": "Féngniánguòjié, dàjiēxiǎoxiàng zhāngdēngjiécǎi, chéngxiàn chū yí pài huāntiānxǐdì, āndìng xiánghé de jiérì fènwéi.",
          "translation_vi": "Mỗi độ tết đến xuân về, phố lớn ngõ nhỏ giăng đèn kết hoa, hiện ra một bầu không khí lễ hội vui vẻ rộn ràng, thanh bình an lạc.",
          "explanation": "\"一派...节日氛围\" đặc tả bầu không khí tưng bừng phấn khởi bao trùm khắp phố phường."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 15,
      "name": "Danh lượng từ thi vị chỉ cánh hoa, múi và tấm lòng \"瓣\" (Cánh / Múi / Mảnh)",
      "pattern": "Số từ + 瓣 + Danh từ (花瓣 / 蒜 / 橘子 / 心香 / 心意)",
      "category": "Lượng từ",
      "explanation_vi": "\"瓣\" (bàn) dùng cho cánh hoa, múi quả (như 一瓣橘子 - một múi quýt, 一瓣大蒜 - một nhánh tỏi). Trong văn học tao nhã HSK 6, \"一瓣心香\" là thành ngữ ngữ pháp hóa ẩn dụ cho tấm lòng thành kính, trong sạch và tôn kính dâng lên bề trên.",
      "examples": [
        {
          "chinese": "春风拂过，枝头的粉红桃花纷纷飘落，将几瓣残红轻轻落在了旅人的肩头。",
          "pinyin": "Chūnfēng fúguò, zhītóu de fěnhóng táohuā fēnfēn piāoluò, jiāng jǐ bàn cánhóng qīngqīng luò zài le lǚrén de jiāntóu.",
          "translation_vi": "Gió xuân thổi qua, hoa đào phớt hồng trên đầu cành đua nhau rụng xuống, thả nhẹ mấy cánh hoa phai lên bờ vai người lữ thứ.",
          "explanation": "\"几瓣残红\" dùng \"瓣\" định lượng cho những cánh hoa đào rơi rụng theo gió xuân."
        },
        {
          "chinese": "临别之际无以为赠，谨奉上一瓣心香，遥祝恩师健康长寿、福泽绵长。",
          "pinyin": "Línbié zhījì wúyǐwéizèng, jǐn fèngshàng yí bàn xīnxiāng, yáozhù ēnshī jiànkāng chángshòu, fúzé miáncháng.",
          "translation_vi": "Giờ phút chia tay chẳng có gì để tặng, kính dâng một tấm lòng thành kính tựa nén tâm hương, từ phương xa kính chúc ân sư sức khỏe trường thọ, phúc trạch dài lâu.",
          "explanation": "\"一瓣心香\" là cách nói văn hóa nho nhã bày tỏ sự tri ân kính trọng sâu nặng với người thầy."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 16,
      "name": "Danh lượng từ thực vật & địa lý chỉ khóm, bụi, cụm \"丛\" (Bụi / Khóm / Cụm)",
      "pattern": "Số từ + 丛 + Danh từ (灌木 / 鲜花 / 杂草 / 绿竹)",
      "category": "Lượng từ",
      "explanation_vi": "\"丛\" (cóng) là lượng từ tập hợp dành cho các loài cây cỏ, hoa lá mọc tụ họp dày đặc sát cạnh nhau từ một gốc hoặc một cụm đất (như 一丛灌木 - một bụi cây bụi, 一丛野花 - một khóm hoa dại).",
      "examples": [
        {
          "chinese": "在悬崖峭壁的岩石缝隙里，顽强地生长着一丛傲雪凌霜的野菊花。",
          "pinyin": "Zài xuányáqiàobì de yánshí fèngxì lǐ, wánqiáng de shēngzhǎngzhe yì cóng àoxuělíngshuāng de yějúhuā.",
          "translation_vi": "Nơi khe nứt của vách đá cheo leo, kiên cường sinh trưởng một khóm cúc dại ngạo nghễ đạp tuyết khinh sương.",
          "explanation": "\"一丛...野菊花\" dùng \"丛\" định lượng cho cụm hoa cúc dại vươn mình giữa đá núi hiểm trở."
        },
        {
          "chinese": "院子角落里种着一丛翠绿挺拔的修竹，为整个庭院平添了几分幽雅静谧。",
          "pinyin": "Yuànzi jiǎoluò lǐ zhòngzhe yì cóng cuìlǜ tǐngbá de xiūzhú, wèi zhěng gè tíngyuàn píngtiān le jǐ fēn yōuyǎ jìngmì.",
          "translation_vi": "Ở góc sân có trồng một bụi trúc xanh biếc thẳng tắp, điểm xuyết thêm cho cả khu vườn vài phần thanh nhã tĩnh mịch.",
          "explanation": "\"一丛翠绿挺拔的修竹\" miêu tả bụi tre trúc cảnh trang trí sân vườn phương Đông."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 17,
      "name": "Danh lượng từ chỉ nhúm nhỏ, nắm tay hoặc nhóm cực nhỏ \"撮\" (Nhúm / Dúm / Nhóm nhỏ)",
      "pattern": "一 + 撮 + Danh từ (土 / 盐 / 头发) / 一小撮 + Đối tượng tiêu cực (阴谋分子 / 暴徒)",
      "category": "Lượng từ",
      "explanation_vi": "\"撮\" (cuō) có hai cách dùng: 1) Lượng từ chỉ lượng rất ít có thể dùng các đầu ngón tay nhón lấy (như 一撮盐 - một nhúm muối, 一撮土 - một nắm đất); 2) Dùng trong chính trị chỉ một nhóm cực nhỏ những phần tử xấu, manh động bị xã hội cô lập (như 一小撮坏人, 一小撮分裂分子).",
      "examples": [
        {
          "chinese": "考古队员小心翼翼地用刷子扫起一撮古墓地层深处的灰烬样本进行年代测定。",
          "pinyin": "Kǎogǔ duìyuán xiǎoxīnyìyì de yòng shuāzi sǎoqǐ yì cuō gǔmù dìcéng shēnchù de huījìn yàngběn jìnxíng niándài cèdìng.",
          "translation_vi": "Cán bộ khảo cổ cẩn thận dùng cọ quét lấy một nhúm mẫu tro tàn nơi tầng sâu ngôi mộ cổ để tiến hành đo niên đại.",
          "explanation": "\"一撮...灰烬样本\" dùng \"撮\" định lượng cho lượng mẫu tro cực nhỏ phục vụ xét nghiệm khoa học."
        },
        {
          "chinese": "那一小撮企图破坏边疆民族团结与社会繁荣的极端分子，终将受到法律的威严制裁。",
          "pinyin": "Nà yì xiǎocuō qǐtú pòhuài biānjiāng mínzú tuánjié yǔ shèhuì fánróng de jíduān fènzǐ, zhōng jiāng shòudào fǎlǜ de wēiyán zhìcái.",
          "translation_vi": "Một nhóm nhỏ những phần tử cực đoan mưu toan phá hoại đoàn kết dân tộc và sự phồn vinh xã hội nơi biên ải, cuối cùng sẽ phải chịu sự trừng phạt uy nghiêm của pháp luật.",
          "explanation": "\"一小撮...极端分子\" là thuật ngữ chính luận lột tả sự cô lập thiểu số của phần tử phá hoại."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 18,
      "name": "Phó từ văn ngôn chỉ sự tiếp diễn chưa dứt \"尚\" (Còn / Hãy còn / Vẫn / Chưa)",
      "pattern": "尚 + Động từ/Tính từ (尚可 / 尚无定论 / 尚未可知 / 尚待研究 / 尚有)",
      "category": "Phó từ",
      "explanation_vi": "\"尚\" (shàng) là phó từ văn ngôn tương đương với \"还\" (vẫn còn), nhưng mang phong cách trang trọng hàn lâm. Thường kết hợp trong các thành ngữ bốn chữ biểu thị sự việc đang trong quá trình tiếp diễn chưa ngã ngũ: 尚未 (chưa từng), 尚待 (còn chờ xem xét), 尚未可知 (vẫn chưa thể biết trước), 尚有欠缺 (vẫn còn khiếm khuyết).",
      "examples": [
        {
          "chinese": "该项假说在国际学术界尚存激烈争议，其客观真实性目前尚未得到最终确证。",
          "pinyin": "Gāi xiàng jiǎshuō zài guójì xuéshùjiè shàng cún jīliè zhēngyì, qí kèguān zhēnshíxìng mùqián shàngwèi dédào zuìzhōng quèzhèng.",
          "translation_vi": "Giả thuyết này trong giới học thuật quốc tế vẫn còn tồn tại tranh cãi gay gắt, tính chân thực khách quan của nó hiện tại vẫn chưa nhận được sự xác chứng cuối cùng.",
          "explanation": "\"尚存争议\" và \"尚未得到确证\" thể hiện thái độ thận trọng khoa học đối với vấn đề chưa được chứng minh."
        },
        {
          "chinese": "经过紧急抢修，目前通信主干线尚可维持基本通话，全面修复尚需两到三天。",
          "pinyin": "Jīngguò jǐnjí qiǎngxiū, mùqián tōngxìn zhǔgànxiàn shàngkě wéichí jīběn tōnghuà, quánmiàn xiūfù shàng xū liǎng dào sān tiān.",
          "translation_vi": "Sau khi cấp tốc sửa chữa khẩn cấp, hiện tại tuyến trục thông tin hãy còn có thể duy trì đàm thoại cơ bản, việc khôi phục toàn diện vẫn cần từ hai tới ba ngày.",
          "explanation": "\"尚可维持\" và \"尚需...\" thông báo tiến độ khắc phục sự cố thông tin liên lạc."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 19,
      "name": "Cấu trúc liên từ tăng tiến nhượng bộ cực hạn \"尚且...何况/况且...\" (Ngay cả... huống chi...)",
      "pattern": "Trường hợp thông thường/mạnh 尚且 + Như thế nào, 何况 / 况且 + Trường hợp yếu/đặc biệt",
      "category": "Liên từ",
      "explanation_vi": "\"尚且...何况...\" (shàngqiě... hékuàng...) là mẫu câu tăng tiến lập luận tu từ đỉnh cao: vế trước đưa ra đối tượng mạnh mẽ, điều kiện thuận lợi hoặc mức chuẩn tối thiểu mà \"ngay cả đối tượng đó còn không làm nổi / còn gặp khó khăn\", vế sau dùng \"何况\" để khẳng định đối tượng yếu kém hơn chắc chắn càng không thể.",
      "examples": [
        {
          "chinese": "经验老到的资深探险家在此恶劣环境下尚且步步惊心，何况毫无野外生存经验的普通游客呢？",
          "pinyin": "Jīngyàn lǎodào de zīshēn tànxiǎnjiā zài cǐ èliè huánjìng xià shàngqiě bùbùjīngxīn, hékuàng háowú yěwài shēngcún jīngyàn de pǔtōng yóukè ne?",
          "translation_vi": "Những nhà thám hiểm kỳ cựu dày dạn kinh nghiệm dưới môi trường khắc nghiệt này ngay cả họ còn từng bước thót tim, huống chi là du khách thông thường hoàn toàn không có kinh nghiệm sinh tồn nơi hoang dã chứ?",
          "explanation": "\"尚且...何况...呢\" dùng thử thách của chuyên gia để cảnh báo nguy cơ tử thần đối với người nghiệp dư."
        },
        {
          "chinese": "身居高位的古代君王尚且虚心求教于田野贤士，我们作为普通人又怎能骄傲自满呢？",
          "pinyin": "Shēnjū gāowèi de gǔdài jūnwáng shàngqiě xūxīn qiújiào yú tiányě xiánshì, wǒmen zuòwéi pǔtōngrén yòu zěn néng jiāo'àozìmǎn ne?",
          "translation_vi": "Những vị quân vương cổ đại ở ngôi vị tối cao ngay cả họ còn khiêm tốn thỉnh giáo các bậc hiền tài nơi đồng nội, chúng ta với tư cách là người bình thường sao có thể kiêu ngạo tự mãn chứ?",
          "explanation": "\"君王尚且...怎能...\" lấy tấm gương của bậc đế vương răn dạy đức tính khiêm tốn cầu thị."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 20,
      "name": "Phó từ thời gian văn ngôn khởi đầu \"甫\" (Vừa mới / Thoạt vừa mới)",
      "pattern": "甫 + Động từ (甫一上市 / 甫一亮相 / 甫一出场 / 惊魂甫定)",
      "category": "Phó từ",
      "explanation_vi": "\"甫\" (fǔ) là phó từ thời gian văn ngôn cổ xưa tương đương với \"刚刚\" (vừa mới), chuyên dùng miêu tả thời điểm một sự vật hoặc nhân vật vừa mới xuất hiện thì lập tức gây chấn động hoặc tạo nên phản ứng tức thì (như 甫一上市 - vừa mới tung ra thị trường, 惊魂甫定 - hồn phách vừa mới định thần lại).",
      "examples": [
        {
          "chinese": "该款自主研发的折叠屏旗舰手机甫一亮相，便在全球科技展会上引起了极大的轰动。",
          "pinyin": "Gāi kuǎn zìzhǔ yánfā de zhédiépíng qíjiàn shǒujī fǔyí liàngxiàng, biàn zài quánqiú kējì zhǎnhuì shang yǐnqǐ le jídà de hōngdòng.",
          "translation_vi": "Chiếc điện thoại đầu bảng màn hình gập tự chủ nghiên cứu phát triển này thoạt vừa mới ra mắt đã lập tức gây chấn động cực lớn tại triển lãm công nghệ toàn cầu.",
          "explanation": "\"甫一亮相，便引起轰动\" là cách viết thời sự kinh điển miêu tả sức hút mãnh liệt tức thì của sản phẩm mới."
        },
        {
          "chinese": "大巴车司机在惊魂甫定之后，迅速组织全体乘客有序撤离到高速公路护栏外。",
          "pinyin": "Dàbāchē sījī zài jīnghúnfǔdìng zhīhòu, xùnsù zǔzhī quántǐ chéngkè yǒuxù chèlí dào gāosù gōnglù hùlán wài.",
          "translation_vi": "Tài xế xe buýt sau khi vừa mới hoàn hồn định thần lại sau cơn hoảng loạn, đã nhanh chóng tổ chức toàn thể hành khách sơ tán có trật tự ra ngoài dải phân cách đường cao tốc.",
          "explanation": "\"惊魂甫定\" là thành ngữ miêu tả tâm trạng vừa kịp trấn tĩnh lại sau cú sốc tai nạn giao thông."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 21,
      "name": "Phó từ hoàn thành pháp lý lịch sử \"业已\" (Đã / Đã từng hoàn tất)",
      "pattern": "Chủ ngữ + 业已 + Động từ song âm tiết (完成 / 生效 / 查明 / 达成 / 告竣)",
      "category": "Phó từ",
      "explanation_vi": "\"业已\" (yèyǐ) là phó từ ngoại giao và pháp lý cao cấp tương đương với \"已经\", biểu thị một hiệp ước, công trình hoặc quy trình điều tra đã được hoàn thành triệt để trong quá khứ và hiện đang phát sinh hiệu lực đầy đủ (như 业已生效 - đã chính thức có hiệu lực, 业已查明 - đã điều tra làm rõ).",
      "examples": [
        {
          "chinese": "两国议会正式批准的双边投资保护协定业已于今日凌晨起全面生效。",
          "pinyin": "Liǎng guó yìhuì zhèngshì pīzhǔn de shuāngbiān tóuzī bǎohù xiéyì yèyǐ yú jīnrì língchén qǐ quánmiàn shēngxiào.",
          "translation_vi": "Hiệp định bảo hộ đầu tư song phương do nghị viện hai nước chính thức phê chuẩn đã chính thức phát sinh hiệu lực toàn diện kể từ rạng sáng hôm nay.",
          "explanation": "\"业已...全面生效\" là thuật ngữ công pháp ngoại giao tuyên bố mốc hiệu lực của điều ước quốc tế."
        },
        {
          "chinese": "经过跨部门专案组的不懈努力，事故发生的直接诱因及责任链条业已彻底查明。",
          "pinyin": "Jīngguò kuà bùmén zhuān'ànzǔ de búxiè nǔlì, shìgù fāshēng de zhíjiē yòuyīn jí zérèn liàntiáo yèyǐ chèdǐ chámíng.",
          "translation_vi": "Qua sự nỗ lực không ngừng nghỉ của ban chuyên án liên ngành, nguyên nhân trực tiếp châm ngòi và chuỗi trách nhiệm của vụ tai nạn đã được điều tra làm rõ triệt để.",
          "explanation": "\"业已彻底查明\" khẳng định kết quả điều tra đã ngã ngũ rõ ràng không còn uẩn khúc."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 22,
      "name": "Phó từ cấp bách không thể trì hoãn \"亟待\" (Cực kỳ cấp thiết cần phải / Cần kíp)",
      "pattern": "Vấn đề nhức nhối / Tồn đọng + 亟待 + Động từ song âm tiết (解决 / 完善 / 澄清 / 规范 / 拯救)",
      "category": "Phó từ",
      "explanation_vi": "\"亟待\" (jídài) kết hợp chữ \"亟\" (jí - khẩn cấp, gấp gáp) và \"待\" (dài - chờ đợi, cần phải), mang nghĩa \"vô cùng khẩn thiết, cấp bách đòi hỏi phải hành động ngay lập tức không thể chậm trễ thêm một giây phút nào\" (cực kỳ cấp bách cần giải quyết). Thường dùng trong các thông điệp cảnh báo xã hội.",
      "examples": [
        {
          "chinese": "传统手工造纸技艺面临着后继无人的濒危严峻困境，这一非遗项目亟待抢救性保护。",
          "pinyin": "Chuántǒng shǒugōng zàozhǐ jìyì miànlínzhe hòujìwúrén de bīnwēi yánjùn kùnjìng, zhè yì fēiyí xiàngmù jídài qiǎngjiùxìng bǎohù.",
          "translation_vi": "Nghề làm giấy thủ công truyền thống đang đối mặt với nghịch cảnh ngặt nghèo không người kế nghiệp, dự án di sản phi vật thể này đang hết sức cấp bách cần được bảo vệ khẩn cấp mang tính giải cứu.",
          "explanation": "\"亟待抢救性保护\" phát đi thông điệp cấp bách bảo tồn nghề cổ truyền trước nguy cơ thất truyền."
        },
        {
          "chinese": "网络未成年人打赏巨额资金的社会乱象屡禁不绝，相关监管法律漏洞亟待立法完善。",
          "pinyin": "Wǎngluò wèichéngniánrén dǎshǎng jù'é zījīn de shèhuì luànxiàng lǚjìnbùjué, xiāngguān jiānguǎn fǎlǜ lòudòng jídài lìfǎ wánshàn.",
          "translation_vi": "Vấn nạn xã hội trẻ vị thành niên nạp thưởng số tiền khổng lồ trên mạng cấm mãi không dứt, các lỗ hổng luật pháp giám sát liên quan hết sức cấp bách cần được hoàn thiện bằng công tác lập pháp.",
          "explanation": "\"亟待立法完善\" chỉ ra yêu cầu khẩn cấp của việc hoàn thiện thể chế pháp lý."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 23,
      "name": "Phó từ biến đổi dốc đứng đột ngột \"陡然\" (Đột ngột / Đùng một cái / Dốc đứng)",
      "pattern": "Chủ ngữ + 陡然 + Động từ/Tính từ biến đổi (增加 / 下降 / 紧张 / 升温 / 变色)",
      "category": "Phó từ",
      "explanation_vi": "\"陡然\" (dǒurán) có gốc từ chữ \"陡\" (dốc đứng, hiểm trở). Biểu thị số liệu, nhiệt độ, áp lực hoặc bầu không khí biến đổi đột ngột như một vách đá dựng đứng, khiến mọi người không kịp trở tay (đột ngột thay đổi chóng mặt).",
      "examples": [
        {
          "chinese": "突如其来的国际金融动荡，让这家外贸企业的资金链压力陡然剧增。",
          "pinyin": "Tūrúqílái de guójì jīnróng dòngdàng, ràng zhè jiā wàimào qǐyè de zījīnliàn yālì dǒurán jùzēng.",
          "translation_vi": "Biến động tài chính quốc tế bất ngờ ập đến đã khiến áp lực dòng tiền của doanh nghiệp ngoại thương này đột ngột tăng vọt lên chóng mặt.",
          "explanation": "\"压力陡然剧增\" miêu tả mức độ căng thẳng tài chính tăng vọt dữ dội ngoài tầm kiểm soát."
        },
        {
          "chinese": "原本平静和谐的谈判会场，因对方突然提出苛刻要求而使气氛陡然紧张了起来。",
          "pinyin": "Yuánběn píngjìng héxié de tánpàn huìchǎng, yīn duìfāng tūrán tíchū kēkè yāoqiú ér shǐ qìfēn dǒurán jǐnzhāng le qǐlái.",
          "translation_vi": "Hội trường đàm phán vốn dĩ đang yên ắng hòa hợp bỗng vì đối phương đột ngột đưa ra yêu sách hà khắc mà khiến bầu không khí bỗng chốc căng thẳng tột độ.",
          "explanation": "\"气氛陡然紧张\" diễn tả sự chuyển biến tâm lý đối đầu kịch tính trong đàm phán ngoại giao."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 24,
      "name": "Phó từ thời tiết và âm thanh bùng phát đột ngột \"骤然\" (Đột nhiên bùng phát / Bất thình lình)",
      "pattern": "Chủ ngữ + 骤然 + Động từ/Tính từ (降温 / 响起了 / 停止 / 狂风大作 / 亮起)",
      "category": "Phó từ",
      "explanation_vi": "\"骤然\" (zhòurán) kết hợp chữ \"骤\" (chạy nước đại, đột ngột), biểu thị một hiện tượng thiên nhiên (gió bão, nhiệt độ) hoặc âm thanh, ánh sáng bộc phát nhanh và mạnh mẽ như một cơn lốc bất ngờ (đột ngột, bất thình lình bùng lên).",
      "examples": [
        {
          "chinese": "受北方强冷空气南下袭击影响，该地区的气温在短短半天内骤然下降了十五摄氏度。",
          "pinyin": "Shòu běifāng qiáng lěngkōngqì nánxià xíjī yǐngxiǎng, gāi dìqū de qìwēn zài duǎnduǎn bàn tiān nèi zhòurán xiàjiàng le shíwǔ shèshìdù.",
          "translation_vi": "Chịu ảnh hưởng bởi đợt không khí lạnh mạnh từ phương Bắc tràn xuống tấn công, nhiệt độ của khu vực này chỉ trong vòng nửa ngày ngắn ngủi đã đột ngột giảm mạnh 15 độ C.",
          "explanation": "\"气温...骤然下降\" miêu tả hiện tượng rét đậm ập đến cực nhanh theo quy luật thời tiết cực đoan."
        },
        {
          "chinese": "寂静无声的深夜里，走廊深处骤然响起了一阵急促而惊慌的敲门声。",
          "pinyin": "Jìjìngwúshēng de shēnyè lǐ, zǒuláng shēnchù zhòurán xiǎngqǐ le yí zhèn jícù ér jīnghuāng de qiāomén shēng.",
          "translation_vi": "Nơi đêm khuya thanh vắng tĩnh mịch không một tiếng động, sâu trong hành lang bỗng nhiên bất thình lình vang lên một hồi tiếng gõ cửa dồn dập đầy hoảng sợ.",
          "explanation": "\"骤然响起敲门声\" tạo bầu không khí kịch tính, hồi hộp trong văn phong tiểu thuyết trinh thám."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 25,
      "name": "Thành ngữ ngữ pháp hóa chỉ sự bí mật êm ả \"悄无声息\" (Lặng lẽ không một tiếng động)",
      "pattern": "Chủ ngữ + 悄无声息地 + Động từ (蔓延 / 潜入 / 发生 / 改变 / 离去)",
      "category": "Phó từ",
      "explanation_vi": "\"悄无声息\" (qiǎowúshēngxī) mang ý nghĩa tuyệt đối yên ắng, không phát ra một chút âm thanh hay tiếng động nhỏ nào, làm cho người khác hoàn toàn không hay biết (lặng lẽ không một tiếng động, âm thầm không ai hay). Thường dùng làm trạng ngữ miêu tả sự xâm nhập bí mật hoặc dòng chảy thời gian trôi đi.",
      "examples": [
        {
          "chinese": "一场以人工智能大模型为标志的全新工业革命，正在各行各业悄无声息地全面蔓延。",
          "pinyin": "Yì chǎng yǐ réngōng zhìnéng dà móxíng wéi biāozhì de quánxīn gōngyè gémìng, zhèngzài gèhánggèyè qiǎowúshēngxī de quánmiàn mànyán.",
          "translation_vi": "Một cuộc cách mạng công nghiệp hoàn toàn mới lấy mô hình trí tuệ nhân tạo lớn làm dấu mốc đang âm thầm lan tỏa không một tiếng động trong mọi ngành nghề.",
          "explanation": "\"悄无声息地蔓延\" ẩn dụ cho sự thâm nhập tất yếu, sâu sắc của công nghệ vào nền kinh tế số."
        },
        {
          "chinese": "特警队员在夜幕的掩护下，悄无声息地包围了犯罪团伙藏匿的废弃仓库。",
          "pinyin": "Tèjǐng duìyuán zài yèmù de yǎnhù xià, qiǎowúshēngxī de bāowéi le fànzuì tuánhuǒ cángnì de fèiqì cāngkù.",
          "translation_vi": "Dưới sự che chở của màn đêm, các chiến sĩ cảnh sát đặc nhiệm đã bí mật lặng lẽ khép chặt vòng vây kho hàng bỏ hoang nơi băng nhóm tội phạm ẩn náu.",
          "explanation": "\"悄无声息地包围\" miêu tả chiến thuật đột kích tuyệt mật chuyên nghiệp của lực lượng đặc nhiệm."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 26,
      "name": "Động từ/Phó từ duyên kỳ ngộ đúng dịp may mắn \"适逢\" (Đúng dịp / Vừa khéo gặp / Trùng phùng)",
      "pattern": "适逢 + Dịp đại lễ/Sự kiện trọng đại / 适逢其会",
      "category": "Phó từ",
      "explanation_vi": "\"适逢\" (shìféng) kết hợp chữ \"适\" (vừa vặn, đúng lúc) và \"逢\" (gặp gỡ), mang nghĩa \"vừa vặn trùng hợp đúng vào thời điểm hoặc dịp lễ hội, sự kiện tốt đẹp\" (đúng vào dịp, may mắn trùng phùng). Thành ngữ \"适逢其会\" chỉ việc vừa khéo có mặt đúng vào thời điểm thuận lợi nhất.",
      "examples": [
        {
          "chinese": "代表团这次访问适逢该国建国七十周年盛大庆典，因此受到了东道国最高规格的礼遇。",
          "pinyin": "Dàibiǎotuán zhè cì fǎngwèn shìféng gāi guó jiànguó qīshí zhōunián shèngdà qìngdiǎn, yīncǐ shòudào le dōngdàoguó zuì gāo guīgé de lǐyù.",
          "translation_vi": "Chuyến thăm lần này của đoàn đại biểu đúng vào dịp đại lễ kỷ niệm 70 năm lập quốc của đất nước này, do đó đã nhận được sự đón tiếp theo quy chuẩn lễ nghi cao nhất của nước chủ nhà.",
          "explanation": "\"适逢...盛大庆典\" liên kết sự trùng hợp tốt đẹp về thời điểm lịch sử với quy cách đón tiếp trang trọng."
        },
        {
          "chinese": "青年一代生逢其时、适逢其会，必将在这个伟大的时代大有作为。",
          "pinyin": "Qīngnián yídài shēngféngqíshí, shìféngqíhuì, bìjiāng zài zhè ge wěidà de shídài dàyǒuzuòwéi.",
          "translation_vi": "Thế hệ trẻ sinh ra đúng thời, gặp đúng thời cơ lịch sử, nhất định sẽ làm nên những sự nghiệp vĩ đại trong thời đại huy hoàng này.",
          "explanation": "\"生逢其时、适逢其会\" là cặp thành ngữ truyền cảm hứng cổ vũ thanh niên nắm bắt vận hội non sông."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 27,
      "name": "Phó từ thời gian nối tiếp thần tốc \"旋即\" (Liền ngay sau đó / Nhanh chóng tiếp nối)",
      "pattern": "Hành động 1 bộc phát, 旋即 + Hành động 2 / Kết quả phản hồi tức thì",
      "category": "Phó từ",
      "explanation_vi": "\"旋即\" (xuánjí) là phó từ văn ngôn cổ nhã tương đương với \"随即\" hoặc \"转身立刻\", biểu thị một sự biến đổi hoặc phản ứng diễn ra cực nhanh, chớp nhoáng nối liền ngay sau sự việc thứ nhất (ngay sau đó, thoắt cái liền). Mang sắc thái văn phong bác học.",
      "examples": [
        {
          "chinese": "爆炸发生后，附近驻军部队闻令而动，旋即奔赴现场展开了紧急的抢险救援。",
          "pinyin": "Bàozhà fāshēng hòu, fùjìn zhùjūn bùduì wénlìng'érdòng, xuánjí bēnfù xiànchǎng zhǎnkāi le jǐnjí de qiǎngxiǎn jiùyuán.",
          "translation_vi": "Sau khi vụ nổ xảy ra, lực lượng quân đội đóng quân gần đó nghe lệnh lập tức hành động, ngay tắp lự đã lao tới hiện trường triển khai công tác cứu hộ khẩn cấp.",
          "explanation": "\"旋即奔赴现场\" đặc tả tốc độ phản ứng điều binh thần tốc của quân đội trước thảm họa."
        },
        {
          "chinese": "公司发布的辟谣声明言之凿凿，旋即平息了网络上持续数日的恶意造谣风波。",
          "pinyin": "Gōngsī fābù de pìyáo shēngmíng yánzhīzàozào, xuánjí píngxī le wǎngluò shang chíxù shù rì de èyì zàoyáo fēngbō.",
          "translation_vi": "Thông cáo đính chính bác bỏ tin đồn của công ty đưa ra đầy đủ bằng chứng xác thực, ngay lập tức đã dập tắt cơn sóng gió bịa đặt ác ý kéo dài suốt nhiều ngày trên mạng.",
          "explanation": "\"旋即平息了...风波\" nhấn mạnh hiệu quả trấn an dư luận tức thời của thông điệp minh bạch."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 28,
      "name": "Liên từ lựa chọn văn ngôn cổ kính \"抑或\" (Hoặc là / Hay là)",
      "pattern": "Lựa chọn A, 抑或 + Lựa chọn B (mang tính triết lý, suy tư sâu xa)",
      "category": "Liên từ",
      "explanation_vi": "\"抑或\" (yìhuò) là liên từ lựa chọn bắt nguồn từ Hán ngữ cổ đại tương đương với \"还是\" hoặc \"或者是\", nhưng mang đậm phong vị suy tư triết học, chất vấn lịch sử hoặc phong cách tùy bút văn học thâm trầm (hay là, hoặc giả là).",
      "examples": [
        {
          "chinese": "人类探索浩瀚太空的终极驱动力，究竟是源于对未知世界的好奇，抑或是为了寻求文明未来的生存空间？",
          "pinyin": "Rénlèi tànsuǒ hàohàn tàikōng de zhōngjí qūdònglì, jiūjìng shì yuányú duì wèizhī shìjiè de hàoqí, yìhuò shì wèile xúnqiú wénmíng wèilái de shēngcún kōngjiān?",
          "translation_vi": "Động lực tối thượng thúc đẩy nhân loại khám phá vũ trụ bao la, rốt cuộc là bắt nguồn từ trí tò mò đối với thế giới chưa biết, hay là nhằm tìm kiếm không gian sinh tồn tương lai cho nền văn minh?",
          "explanation": "\"究竟是...抑或是...\" đặt ra câu hỏi triết học sâu xa về sứ mệnh chinh phục vũ trụ của nhân loại."
        },
        {
          "chinese": "这场长达百年的历史论战，究竟是一场学术立场的交锋，抑或是一场意识形态的较量？",
          "pinyin": "Zhè chǎng chángdá bǎinián de lìshǐ lùnzhàn, jiūjìng shì yì chǎng xuéshù lìchǎng de jiāofēng, yìhuò shì yì chǎng yìshíxíngtài de jiàoliàng?",
          "translation_vi": "Cuộc luận chiến lịch sử kéo dài suốt trăm năm này, rốt cuộc là một cuộc so găng về lập trường học thuật, hay là một cuộc đọ sức về hình thái ý thức?",
          "explanation": "\"抑或\" đưa ra hai giả thuyết sâu sắc để mổ xẻ bản chất của cuộc tranh biện lịch sử."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 29,
      "name": "Phó từ phỏng đoán tu từ hoài nghi \"莫非\" (Lẽ nào / Chẳng lẽ / Hay là)",
      "pattern": "莫非 + Phỏng đoán nghi hoặc + (不成 / 吗 / 呢)？",
      "category": "Phó từ",
      "explanation_vi": "\"莫非\" (mòfēi) dùng trong câu hỏi phỏng đoán để biểu thị sự nghi hoặc, ngạc nhiên trước một tình huống bất thường (lẽ nào, chẳng lẽ). Cuối câu thường kết hợp với quán dụng ngữ \"不成\" tạo thành cấu trúc tu từ \"莫非...不成？\" (chẳng lẽ... hay sao?).",
      "examples": [
        {
          "chinese": "大门紧锁且屋内一片漆黑，莫非他们全家都去外地度假了不成？",
          "pinyin": "Dàmén jǐnsuǒ qiě wūnèi yí piàn qīhēi, mòfēi tāmen quán jiā dōu qù wàidì dùjià le bùchéng?",
          "translation_vi": "Cửa chính khóa chặt và trong nhà tối om không một bóng đèn, chẳng lẽ cả nhà họ đều đã đi nơi khác nghỉ dưỡng rồi hay sao?",
          "explanation": "\"莫非...不成？\" đưa ra phán đoán phỏng đoán trước hiện trường ngôi nhà vắng vẻ."
        },
        {
          "chinese": "平时最守时的人今天居然迟到了一个小时，莫非路上遇到了什么突发险情？",
          "pinyin": "Píngshí zuì shǒushí de rén jīntiān jūrán chídào le yí gè xiǎoshí, mòfēi lùshang yùdào le shénme tūfā xiǎnqíng?",
          "translation_vi": "Người bình thường đúng giờ nhất hôm nay không ngờ lại đến muộn một tiếng đồng hồ, lẽ nào trên đường đã gặp phải tình huống nguy hiểm bất trắc gì rồi sao?",
          "explanation": "\"莫非...\" biểu thị sự lo lắng cho an nguy của người bạn khi xuất hiện sự bất thường."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 30,
      "name": "Phó từ phủ định kép khẳng định tính phổ quát \"莫不\" (Không ai là không / Không gì là không)",
      "pattern": "Mọi người / Mọi sự vật + 莫不 + Động từ/Tính từ (称赞 / 感慨 / 欣喜 / 为之动容)",
      "category": "Phó từ",
      "explanation_vi": "\"莫不\" (mòbù) là phó từ văn ngôn kết hợp chữ 莫 (không ai, không có gì) và 不 (không), tạo thành phủ định kép khẳng định 100% tính phổ quát tuyệt đối của hiện tượng (không ai là không như vậy, ai nấy đều, không gì là không). Mang sắc thái ngợi ca hoặc thán phục trang nghiêm.",
      "examples": [
        {
          "chinese": "凡是亲眼目睹过这位老红军英雄事迹报告的听众，无不热泪盈眶，莫不为之深深动容。",
          "pinyin": "Fánshì qīnyǎn mùdǔguo zhè wèi lǎohóngjūn yīngxióng shìjì bàogào de tīngzhòng, wúbù rèlèiyíngkuàng, mòbù wéizhī shēnshēn dòngróng.",
          "translation_vi": "Phàm là người nghe từng tận mắt chứng kiến báo cáo thành tích anh hùng của người chiến sĩ Hồng quân già này, không ai là không ngấn lệ, không một ai là không vì thế mà xúc động sâu sắc.",
          "explanation": "\"莫不为之动容\" cực tả sức lay động lòng người mãnh liệt của câu chuyện anh hùng cách mạng."
        },
        {
          "chinese": "历代登临泰山玉皇顶极目远眺的文人骚客，莫不被其雄浑壮阔的巍峨气象所震撼。",
          "pinyin": "Lìdài dēnglín Tàishān Yùhuángdǐng jímù yuǎntiào de wénrénsāokè, mòbù bèi qí xiónghún zhuàngkuò de wēi'é qìxiàng suǒ zhènhàn.",
          "translation_vi": "Các bậc văn nhân thi khách qua các thời đại khi bước lên đỉnh Ngọc Hoàng của núi Thái Sơn phóng tầm mắt nhìn xa, không một ai là không bị khí tượng nguy nga hùng vĩ tráng lệ của nó làm cho chấn động.",
          "explanation": "\"莫不被...所震撼\" dùng phủ định kép văn ngôn khẳng định sự sùng kính của tiền nhân trước ngọn núi thiêng."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 31,
      "name": "Phó từ văn ngôn phủ định không cần thiết \"毋庸\" (Không cần / Khỏi phải / Không cần bàn cãi)",
      "pattern": "毋庸 + Động từ song âm tiết (置疑 / 讳言 / 多言 / 细述 / 赘述)",
      "category": "Phó từ",
      "explanation_vi": "\"毋庸\" (wúyōng) kết hợp chữ \"毋\" (không) và \"庸\" (cần), mang nghĩa \"hoàn toàn không cần thiết phải làm, không cần phải nói thêm\" (khỏi phải, không cần). Tạo thành các thành ngữ học thuật bất hủ trong HSK 6: \"毋庸置疑\" (không còn nghi ngờ gì nữa), \"毋庸讳言\" (thẳng thắn không cần giấu giếm, nói thẳng thắn), \"毋庸赘述\" (không cần nói rườm rà thêm).",
      "examples": [
        {
          "chinese": "创新对于现代高科技产业生存发展的决定性引领作用，是毋庸置疑的。",
          "pinyin": "Chuàngxīn duìyú xiàndài gāo kējì chǎnyè shēngcún fāzhǎn de juédìngxìng yǐnlǐng zuòyòng, shì wúyōngzhìyí de.",
          "translation_vi": "Tác dụng dẫn dắt mang tính quyết định của đổi mới sáng tạo đối với sự sinh tồn phát triển của ngành công nghệ cao hiện đại là điều khỏi cần nghi ngờ.",
          "explanation": "\"是毋庸置疑的\" khẳng định tính chân lý không thể lay chuyển của yếu tố đổi mới công nghệ."
        },
        {
          "chinese": "毋庸讳言，我们在前期的市场调研中确实存在着一定的盲目乐观与经验主义倾向。",
          "pinyin": "Wúyōnghuìyán, wǒmen zài qiánqī de shìchǎng diàoyán zhōng quèshí cúnzài zhe yídìng de mángmù lèguān yǔ jīngyànzhǔyì qīngxiàng.",
          "translation_vi": "Thẳng thắn không cần giấu giếm, chúng tôi trong khâu khảo sát thị trường giai đoạn ban đầu quả thực có tồn tại khuynh hướng lạc quan mù quáng và chủ nghĩa kinh nghiệm nhất định.",
          "explanation": "\"毋庸讳言\" thể hiện tinh thần dũng cảm nhìn thẳng vào khuyết điểm và tự phê bình nghiêm túc."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 32,
      "name": "Phó từ văn ngôn phủ định nhu cầu \"毋须 / 无须\" (Không cần thiết / Chẳng cần phải)",
      "pattern": "Chủ ngữ + 毋须 / 无须 + Động từ (多言 / 担忧 / 介意 / 恐慌)",
      "category": "Phó từ",
      "explanation_vi": "\"毋须\" và \"无须\" (wúxū) là các phó từ văn ngôn tương đương với \"不需要\" hoặc \"不必\", mang sắc thái trang nhã, điềm đạm và dứt khoát (không cần thiết phải làm, chẳng cần bận tâm). Thường dùng trong các thông cáo ngoại giao hoặc lời khuyên nhủ học thuật.",
      "examples": [
        {
          "chinese": "事实真相早已大白于天下，公道自在人心，我们毋须再作多余的无谓辩解。",
          "pinyin": "Shìshí zhēnxiàng zǎoyǐ dàbái yú tiānxià, gōngdào zì zài rénxīn, wǒmen wúxū zài zuò duōyú de wúwèi biànjiě.",
          "translation_vi": "Sự thật chân tướng từ lâu đã sáng tỏ dưới thanh thiên bạch nhật, lẽ công bằng tự ở trong lòng người, chúng ta không cần thiết phải giải thích vô ích thêm thừa thãi nữa.",
          "explanation": "\"毋须再作多余的辩解\" thể hiện phong thái tự tin vững vàng khi sự thật đã rõ ràng mười mươi."
        },
        {
          "chinese": "两国在此领域的合作完全符合国际法规范，外界对此无须产生任何不必要的过度猜忌。",
          "pinyin": "Liǎng guó zài cǐ lǐngyù de hézuò wánquán fúhé guójìfǎ guīfàn, wàijiè duì cǐ wúxū chǎnshēng rènhé bú bìyào de guòdù cāijì.",
          "translation_vi": "Sự hợp tác giữa hai nước trong lĩnh vực này hoàn toàn phù hợp với quy phạm luật pháp quốc tế, bên ngoài đối với điều này chẳng cần nảy sinh bất kỳ sự nghi kỵ thái quá không cần thiết nào.",
          "explanation": "\"无须产生...猜忌\" là phát ngôn ngoại giao chính thức trấn an các đồn đoán thất thiệt."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 33,
      "name": "Phó từ văn ngôn chỉ mức độ ngạc nhiên và thảng thốt \"殊\" (Rất / Thật là / Đâu ngờ)",
      "pattern": "殊 + Tính từ (殊为不易 / 殊不知 / 殊途同归)",
      "category": "Phó từ",
      "explanation_vi": "\"殊\" (shū) là phó từ văn ngôn mang hai nghĩa chính trong HSK 6: 1) Tương đương với \"很, 极\" (rất, thật là), như 殊为不易 (thực sự hết sức khó khăn không dễ chút nào); 2) Biểu thị sự bất ngờ hoàn toàn nằm ngoài dự liệu, tương đương với \"哪里知道\" (nào ngờ đâu, đâu biết rằng), như thành ngữ ngữ pháp hóa \"殊不知\".",
      "examples": [
        {
          "chinese": "在完全缺乏现成技术资料的前提下攻克这项世界级难关，其探索过程殊为不易。",
          "pinyin": "Zài wánquán quēfá xiànchéng jìshù zīliào de qiántí xià gōngkè zhè xiàng shìjièjí nánguān, qí tànsuǒ guòchéng shū wéi bùyì.",
          "translation_vi": "Dưới tiền đề hoàn toàn thiếu thốn tài liệu kỹ thuật có sẵn mà chinh phục được ải khó cấp thế giới này, quá trình tìm tòi của nó thực sự vô cùng không dễ dàng chút nào.",
          "explanation": "\"殊为不易\" dùng \"殊\" làm phó từ mức độ văn ngôn trang trọng cực tả sự gian truân của nhóm nghiên cứu."
        },
        {
          "chinese": "许多人以为熬夜后补觉就能抵消身体损伤，殊不知长期昼夜颠倒会对生物钟造成不可逆的破坏。",
          "pinyin": "Xǔduō rén yǐwéi áoyè hòu bǔjiào jiù néng dǐxiāo shēntǐ sǔnshāng, shūbùzhī chángqī zhòuyèdiāndǎo huì duì shēngwùzhōng zàochéng bùkěnì de pòhuài.",
          "translation_vi": "Nhiều người ngỡ rằng sau khi thức đêm ngủ bù là có thể triệt tiêu tổn thương thể xác, đâu biết rằng việc ngày đêm đảo lộn lâu dài sẽ gây ra sự hủy hoại không thể đảo ngược đối với đồng hồ sinh học.",
          "explanation": "\"殊不知...\" lật mở một chân lý y học đối nghịch với nhận thức sai lầm thông thường của đại chúng."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 34,
      "name": "Phó từ mức độ văn ngôn cực hạn \"甚\" (Rất / Quá đỗi / Thậm chí)",
      "pattern": "甚 + Tính từ song âm tiết / 甚为 / 甚或 / 欺人太甚 / 甚嚣尘上",
      "category": "Phó từ",
      "explanation_vi": "\"甚\" (shèn) là phó từ văn ngôn tương đương với \"很, 非常\" (rất, hết sức) hoặc \"甚至\" (thậm chí). Thường gặp: \"甚为\" (rất đỗi: 甚为满意, 甚为欣慰), \"甚或\" (thậm chí hoặc là), \"过甚\" (quá đáng).",
      "examples": [
        {
          "chinese": "听到青年科研团队在量子计算领域取得突破性进展的喜报，老院士甚为欣慰。",
          "pinyin": "Tīngdào qīngnián kēyán tuánduì zài liàngzǐ jìsuàn lǐngyù qǔdé tūpòxìng jìnzhǎn de xǐbào, lǎo yuànshì shènwéi xīnwèi.",
          "translation_vi": "Nghe tin vui nhóm nghiên cứu khoa học trẻ đạt được bước tiến đột phá trong lĩnh vực tính toán lượng tử, vị viện sĩ già cảm thấy hết sức ấm lòng mừng rỡ.",
          "explanation": "\"甚为欣慰\" thể hiện sự hài lòng sâu sắc của thế hệ đi trước trước sự trưởng thành của lớp trẻ."
        },
        {
          "chinese": "这种极端自私的行径不仅会伤害身边的朋友，甚或可能触犯国家的刑事法律。",
          "pinyin": "Zhè zhǒng jíduān zìsī de xíngjìng bùjǐn huì shānghài shēnbiān de péngyou, shènhuò kěnéng chùfàn guójiā de xíngshì fǎlǜ.",
          "translation_vi": "Hành vi ích kỷ cực đoan này không chỉ làm tổn thương bạn bè xung quanh, thậm chí hoặc là có thể xúc phạm tới luật pháp hình sự của quốc gia.",
          "explanation": "\"甚或可能...\" tăng tiến mức độ nguy hại từ phạm trù đạo đức cá nhân lên tới lằn ranh vi phạm pháp luật."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 35,
      "name": "Cụm phó từ mức độ tăng tiến tương phản \"尤甚\" (Càng dữ dội hơn / Lại càng thậm tệ)",
      "pattern": "Hiện tượng A nghiêm trọng, mà Hiện tượng B + 尤甚",
      "category": "Phó từ",
      "explanation_vi": "\"尤甚\" (yóushèn) kết hợp chữ \"尤\" (đặc biệt, càng) và \"甚\" (dữ dội, nghiêm trọng), mang nghĩa \"so với các trường hợp khác thì đối tượng này lại càng thêm gay gắt, dữ dội hơn một bậc\" (càng thêm thậm tệ, lại càng dữ dội hơn). Thường đứng cuối phân câu thứ hai.",
      "examples": [
        {
          "chinese": "全球气候异常给发展中国家带来了巨大挑战，而极度干旱贫瘠的非洲内陆地区受灾尤甚。",
          "pinyin": "Quánqiú qìhòu yìcháng gěi fāzhǎnzhōng guójiā dàilái le jùdà tiǎozhàn, ér jídù gānhàn pínjí de Fēizhōu nèilù dìqū shòuzāi yóushèn.",
          "translation_vi": "Khí hậu toàn cầu dị thường đã đem lại thách thức khổng lồ cho các nước đang phát triển, mà vùng nội lục châu Phi khô hạn cằn cỗi cùng cực chịu ảnh hưởng thiên tai lại càng thậm tệ hơn.",
          "explanation": "\"受灾尤甚\" làm nổi bật mức độ tổn thương nặng nề nhất của khu vực dễ bị tổn thương."
        },
        {
          "chinese": "现代都市人普遍面临着失眠焦虑的困扰，而处于高强度竞争中的IT从业人员尤甚。",
          "pinyin": "Xiàndài dūshìrén pǔbiàn miànlínzhe shīmián jiāolǜ de kùnrǎo, ér chǔyú gāoqiángdù jìngzhēng zhōng de IT cóngyè rényuán yóushèn.",
          "translation_vi": "Người dân đô thị hiện đại phổ biến đang đối mặt với nỗi phiền muộn lo âu mất ngủ, mà nhân sự làm nghề công nghệ thông tin trong môi trường cạnh tranh cường độ cao lại càng nặng nề hơn nữa.",
          "explanation": "\"尤甚\" so sánh giữa diện rộng cư dân thành phố với nhóm ngành nghề chịu áp lực đặc thù."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 36,
      "name": "Phó từ cấm đoán và nguyên tắc thép \"断不可\" (Quyết không thể / Dứt khoát không được)",
      "pattern": "面对... / 在...面前, 断不可 + Động từ (大意 / 妥协 / 姑息 / 违背)",
      "category": "Phó từ",
      "explanation_vi": "\"断不可\" (duànbùkě) là phó từ cấm chỉ văn ngôn đanh thép tương đương với \"绝对不能\" hoặc \"万万不可\" (dứt khoát không được, quyết không thể). Dùng trong các huấn thị quân sự, quy chế an toàn hoặc di huấn răn dạy con cháu.",
      "examples": [
        {
          "chinese": "安全生产重于泰山，在任何细小环节上都断不可抱有丝毫侥幸麻痹心理。",
          "pinyin": "Ānquán shēngchǎn zhòngyú Tàishān, zài rènhé xìxiǎo huánjié shang dōu duànbùkě bàoyǒu sīháo jiǎoxìng mábì xīnlǐ.",
          "translation_vi": "An toàn sản xuất nặng hơn núi Thái Sơn, ở bất kỳ khâu tiểu tiết nào cũng dứt khoát không được ôm giữ mảy may tâm lý cầu may mất cảnh giác.",
          "explanation": "\"断不可抱有丝毫侥幸心理\" là mệnh lệnh kỷ luật an toàn lao động bất di bất dịch."
        },
        {
          "chinese": "做学问当持严谨求实之态度，抄袭剽窃他人成果的学术不端行径断不可为。",
          "pinyin": "Zuò xuéwèn dāng chí yánjǐn qiúshí zhī tàidu, chāoxí piāoqiè tārén chéngguǒ de xuéshù bùduān xíngjìng duànbùkě wéi.",
          "translation_vi": "Làm học vấn phải giữ thái độ cẩn trọng cầu thị, hành vi bất chính học thuật sao chép đạo văn thành quả của người khác dứt khoát không thể làm.",
          "explanation": "\"断不可为\" nghiêm cấm tuyệt đối các hành vi vi phạm đạo đức học thuật."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 37,
      "name": "Phó từ đặc tả hiển lộ sừng sững đập vào mắt \"赫然\" (Sừng sững / Đập vào mắt / Nổi bật)",
      "pattern": "赫然 + Động từ (矗立 / 出现 / 显露 / 印着 / 映入眼帘)",
      "category": "Phó từ",
      "explanation_vi": "\"赫然\" (hèrán) là phó từ miêu tả thị giác mạnh mẽ, biểu thị một vật thể to lớn, một dòng chữ lớn gây sốc, hoặc một nhân vật uy nghi đột nhiên đập ngay vào mắt người nhìn với khí thế nổi bật, khiến người ta kinh ngạc hoặc giật mình (sừng sững, đập ngay vào mắt).",
      "examples": [
        {
          "chinese": "转过幽暗的山崖转角，眼前赫然矗立着一座高达数十米的千年古佛石雕。",
          "pinyin": "Zhuǎnguò yōu'àn de shānyá zhuǎnjiǎo, yǎnqián hèrán chùlìzhe yí zuò gāodá shùshí mǐ de qiānnián gǔfó shídiāo.",
          "translation_vi": "Vòng qua khúc quanh vách núi u ám, trước mắt sừng sững một pho tượng đá cổ nghìn năm cao tới mấy chục mét đập ngay vào tầm mắt.",
          "explanation": "\"眼前赫然矗立着...\" khắc họa cảm giác ngỡ ngàng thán phục khi bất ngờ diện kiến kỳ quan điêu khắc khổng lồ."
        },
        {
          "chinese": "在解密档案的死难者名单头版上，赫然印着他苦苦寻找了半个世纪的父亲的名字。",
          "pinyin": "Zài jiěmì dàng'àn de sǐnànzhě míngdān tóubǎn shang, hèrán yìnzhe tā kǔkǔ xúnzhǎo le bàn gè shìjì de fùqīn de míngzi.",
          "translation_vi": "Trên trang đầu danh sách người tử nạn trong hồ sơ giải mật, đập ngay vào mắt là dòng chữ in tên người cha mà ông đã khổ công tìm kiếm suốt nửa thế kỷ.",
          "explanation": "\"赫然印着...\" đặc tả cảm xúc bàng hoàng nghẹn ngào khi tìm thấy tên người thân trong tài liệu lịch sử."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 38,
      "name": "Phó từ mô phỏng phong thái giống hệt \"俨然\" (Hệt như / Đường hoàng như là / Ra vẻ)",
      "pattern": "Chủ ngữ + 俨然 + (是 / 成了 / 一位) + Danh từ (专家 / 统帅 / 小主人 / 世外桃源)",
      "category": "Phó từ",
      "explanation_vi": "\"俨然\" (yǎnrán) có hai nghĩa chính: 1) Miêu tả phong thái, khí chất hoặc hành vi của một người trông đường hoàng, chững chạc giống hệt như một chức danh hay vai vế nào đó (như 俨然成了一位专家 - ra dáng hệt như một chuyên gia); 2) Miêu tả cảnh sắc đẹp đẽ, trật tự ngay ngắn như bồng lai (như 俨然一座世外桃源).",
      "examples": [
        {
          "chinese": "年仅十二岁的小选手在棋盘前沉着落子、神态自若，俨然是一位久经沙场的国际特级大师。",
          "pinyin": "Nián jǐn shí'èr suì de xiǎo xuǎnshǒu zài qípán qián chénzhuó luòzǐ, shéntài zìruò, yǎnrán shì yí wèi jiǔjīngshāchǎng de guójì tèjí dàshī.",
          "translation_vi": "Kỳ thủ nhí mới 12 tuổi ngồi trước bàn cờ điềm tĩnh hạ cờ, thần thái tự tin đĩnh đạc, trông đường hoàng hệt như một đại kiện tướng quốc tế đã trải trăm trận trường kỳ.",
          "explanation": "\"俨然是一位...大师\" ca ngợi bản lĩnh chững chạc vượt tuổi tác của thần đồng cờ vua."
        },
        {
          "chinese": "春雪过后，粉妆玉砌的古城屋檐错落有致，俨然一幅意境悠远的淡雅水墨画。",
          "pinyin": "Chūnxuě zhīhòu, fěnzhuāngyùqì de gǔchéng wūyán cuòluòyǒuzhì, yǎnrán yì fú yìjìng yōuyuǎn de dànyǎ shuǐmòhuà.",
          "translation_vi": "Sau cơn tuyết xuân, những mái ngói thành cổ tráng tuyết ngọc đan xen ngăn nắp, trông hệt như một bức tranh thủy mạc thanh nhã có ý cảnh xa xăm.",
          "explanation": "\"俨然一幅...水墨画\" dùng \"俨然\" so sánh ví von cảnh sắc thành cổ đẹp như tranh vẽ."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 39,
      "name": "Phó từ phân định ranh giới rành rọt \"截然\" (Rành rọt / Hoàn toàn khác biệt / Dứt khoát)",
      "pattern": "截然 + Tính từ song âm tiết (截然不同 / 截然相反 / 截然两样 / 截然划分)",
      "category": "Phó từ",
      "explanation_vi": "\"截然\" (jiérán) có gốc từ động từ \"截\" (cắt đứt, phân chia rõ rệt). Dùng để chỉ hai sự vật, quan điểm hoặc tính cách đối lập nhau một cách tuyệt đối, có ranh giới rành rọt như dùng dao cắt đôi (hoàn toàn khác biệt, rành rọt tách bạch). Hai thành ngữ chuẩn thi cử HSK 6: \"截然不同\" (hoàn toàn khác nhau) và \"截然相反\" (hoàn toàn trái ngược nhau).",
      "examples": [
        {
          "chinese": "对于同一历史人物的历史功过，两位资深历史学家给出了截然相反的学术评价。",
          "pinyin": "Duìyú tóng yí lìshǐ rénwù de lìshǐ gōngguò, liǎng wèi zīshēn lìshǐxuéjiā gěichū le jiérán xiāngfǎn de xuéshù píngjià.",
          "translation_vi": "Đối với công và tội của cùng một nhân vật lịch sử, hai nhà sử học kỳ cựu đã đưa ra những đánh giá học thuật hoàn toàn trái ngược nhau.",
          "explanation": "\"截然相反的评价\" miêu tả sự đối lập 180 độ trong quan điểm phân tích lịch sử."
        },
        {
          "chinese": "这对双胞胎兄弟在成长轨迹上展现出了截然不同的性格特征与职业追求。",
          "pinyin": "Zhè duì shuāngbāotāi xiōngdì zài chéngzhǎng guǐjì shang zhǎnxiàn chū le jiérán bùtóng de xìnggé tèzhēng yǔ zhíyè zhuīqiú.",
          "translation_vi": "Cặp anh em sinh đôi này trên quỹ đạo trưởng thành đã bộc lộ những nét tính cách và định hướng nghề nghiệp hoàn toàn khác biệt nhau.",
          "explanation": "\"截然不同\" phân định ranh giới rành rẽ giữa hai lối đi cuộc đời của cặp song sinh."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 40,
      "name": "Phó từ kết cục uổng phí cay đắng \"枉然\" (Uổng công / Hoài công / Vô ích)",
      "pattern": "Nỗ lực không đúng phương pháp, 终归是 / 一切都是 + 枉然 / 徒劳枉然",
      "category": "Phó từ",
      "explanation_vi": "\"枉然\" (wǎngrán) kết hợp chữ \"枉\" (uổng, oan uổng) và \"然\", mang nghĩa \"mọi công sức, tâm huyết, hy sinh đã bỏ ra cuối cùng hoàn toàn tan biến thành con số không, không thu lại được một kết quả nào (uổng công hoài phí). Mang sắc thái cay đắng, xót xa sâu sắc hơn \"徒劳\".",
      "examples": [
        {
          "chinese": "做任何工作如果脱离了实事求是的根本原则，付出再多心血终究也不过是枉然。",
          "pinyin": "Zuò rènhé gōngzuò rúguǒ tuōlí le shíshìqiúshì de gēnběn yuánzé, fùchū zài duō xīnxuè zhōngjiū bùguò shì wǎngrán.",
          "translation_vi": "Làm bất kỳ công việc nào nếu tách rời nguyên tắc căn bản thực sự cầu thị, có bỏ ra bao nhiêu tâm huyết đi chăng nữa rốt cuộc cũng chẳng qua chỉ là hoài công vô ích.",
          "explanation": "\"终究不过是枉然\" cảnh báo cái giá của việc làm trái quy luật khách quan."
        },
        {
          "chinese": "既然对方缺乏最基本的签约诚意，我们此前所作的一切磋商努力均告枉然。",
          "pinyin": "Jìrán duìfāng quēfá zuì jīběn de qiānyuē chéngyì, wǒmen cǐqián suǒ zuò de yíqiè cuōshāng nǔlì jūn gào wǎngrán.",
          "translation_vi": "Đã đối phương thiếu thành ý ký kết cơ bản nhất thì mọi nỗ lực đàm phán mà chúng ta đã bỏ ra trước đó đều xem như uổng công phí sức.",
          "explanation": "\"均告枉然\" là cách nói thương mại ngoại giao đúc kết sự thất bại đáng tiếc của vòng đàm phán."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 41,
      "name": "Phó từ thời gian vụt tắt cực nhanh \"倏忽\" (Thoắt cái / Vút qua trong chớp mắt)",
      "pattern": "倏忽间, Mệnh đề / 时间 + 倏忽而逝 / 倏忽万里",
      "category": "Phó từ",
      "explanation_vi": "\"倏忽\" (shūhū) là phó từ văn học cổ xưa miêu tả tốc độ trôi đi của thời gian hoặc chuyển động của một vật thể diễn ra nhanh đến mức chỉ như một cái chớp mắt (thoắt cái, vụt qua trong chốc lát). Thường dùng than thở về sự ngắn ngủi của đời người hoặc tuổi xuân.",
      "examples": [
        {
          "chinese": "回首往昔峥嵘岁月，青春年华倏忽而逝，唯有那份坚守初心的信念历久弥新。",
          "pinyin": "Huíshǒu wǎngxī zhēngróng suìyuè, qīngchūn niánhuá shūhū ér shì, wéiyǒu nà fèn jiānshǒu chūxīn de xìnniàn lìjiǔmíxīn.",
          "translation_vi": "Ngoảnh đầu nhìn lại năm tháng oanh liệt xưa kia, tuổi thanh xuân thoắt cái đã vụt trôi qua, duy chỉ có niềm tin kiên định thuở ban đầu là càng trải qua thời gian lại càng thêm tươi mới.",
          "explanation": "\"青春年华倏忽而逝\" than thở về bước chân thời gian trôi nhanh như tên bắn."
        },
        {
          "chinese": "倏忽间，疾驰的高铁列车已经穿过了连绵起伏的秦岭崇山峻岭。",
          "pinyin": "Shūhū jiān, jíchí de gāotiě lièchē yǐjīng chuānguò le liánmián qǐfú de Qínlǐng chóngshānjùnlǐng.",
          "translation_vi": "Thoắt cái trong chớp mắt, đoàn tàu cao tốc lao vun vút đã vượt qua dãy núi Tần Lĩnh trùng điệp nhấp nhô hiểm trở.",
          "explanation": "\"倏忽间\" đặc tả tốc độ di chuyển thần tốc của phương tiện giao thông hiện đại."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 42,
      "name": "Phó từ bừng tỉnh bất chợt \"蓦然\" (Chợt / Bất chợt / Sực nhận ra)",
      "pattern": "蓦然 + Động từ (回首 / 发现 / 醒悟 / 惊觉)",
      "category": "Phó từ",
      "explanation_vi": "\"蓦然\" (mòrán) có nguồn gốc từ câu từ cổ điển \"蓦然回首，那人却在灯火阑珊处\", mang nghĩa bất chợt, đột nhiên trong một khoảnh khắc ngộ ra chân lý hoặc sực nhận thấy một điều kỳ diệu mà bấy lâu nay mình vô tình bỏ quên (bất giác, sực nhớ, chợt nhận ra).",
      "examples": [
        {
          "chinese": "在异国他乡漫步街头，蓦然听到熟悉的小提琴乡音，他不禁热泪潸然。",
          "pinyin": "Zài yìguó tāxiāng mànbù jiētóu, mòrán tīngdào shúxī de xiǎotíqín xiāngyīn, tā bùjīn rèlèishānrán.",
          "translation_vi": "Dạo bước trên đường phố nơi đất khách quê người, bất chợt nghe thấy âm vang giai điệu quê hương quen thuộc của cây vĩ cầm, anh ấy bất giác rơi nước mắt.",
          "explanation": "\"蓦然听到...\" miêu tả khoảnh khắc xúc động bất ngờ chạm vào nỗi nhớ nhà da diết."
        },
        {
          "chinese": "直到白发悄悄爬上鬓角，他才蓦然醒悟陪伴家人才是生命中最珍贵的幸福。",
          "pinyin": "Zhídào báifà qiāoqiāo páshàng bìnjiǎo, tā cái mòrán xǐngwù péibàn jiārén cái shì shēngmìng zhōng zuì zhēnguì de xìngfú.",
          "translation_vi": "Mãi tới khi tóc bạc lặng lẽ len lỏi lên khóe mai, ông mới bừng tỉnh sực ngộ ra rằng ở bên gia đình mới là niềm hạnh phúc quý báu nhất trong cuộc đời.",
          "explanation": "\"蓦然醒悟\" diễn tả sự giác ngộ triết lý nhân sinh muộn màng nhưng sâu sắc."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 43,
      "name": "Phó từ biến cố đột ngột ập tới \"猝然\" (Đột ngột / Bất thình lình ập tới)",
      "pattern": "猝然 + Động từ biến cố (发生 / 降临 / 长逝 / 离世 / 发难)",
      "category": "Phó từ",
      "explanation_vi": "\"猝然\" (cùrán) kết hợp chữ \"猝\" (cù - bất ngờ, không kịp trở tay), chuyên dùng cho các tai họa, cái chết hoặc biến cố bất ngờ ập đến khiến con người hoàn toàn không có sự phòng bị tâm lý (đột ngột qua đời, bất ngờ ập xuống). Thành ngữ cao cấp: \"猝然长逝\" (đột ngột tạ thế).",
      "examples": [
        {
          "chinese": "这位德高望重的功勋老科学家在实验岗位上猝然长逝，令全国科技界悲痛万分。",
          "pinyin": "Zhè wèi dégāowàngzhòng de gōngxūn lǎo kēxuéjiā zài shíyàn gǎngwèi shang cùrán chángshì, lìng quánguó kējìjiè bēitòng wànfēn.",
          "translation_vi": "Vị nhà khoa học già có công huân đức cao vọng trọng này đã đột ngột tạ thế ngay trên cương vị nghiên cứu, khiến toàn thể giới khoa học công nghệ cả nước đau buồn khôn xiết.",
          "explanation": "\"猝然长逝\" là thành ngữ trang trọng nhất biểu thị sự ra đi đột ngột cống hiến tới hơi thở cuối cùng."
        },
        {
          "chinese": "面对猝然降临的特大暴雨山洪灾害，当地党委政府紧急启动了一级应急响应机制。",
          "pinyin": "Miànduì cùrán jiànglín de tèdà bàoyǔ shānhóng zāihài, dāngdì dǎngwěi zhèngfǔ jǐnjí qǐdòng le yījí yìngjí xiǎngyìng jīzhì.",
          "translation_vi": "Đối mặt với thảm họa lũ quét mưa bão cực lớn bất thình lình ập xuống, cấp ủy chính quyền địa phương đã khẩn cấp kích hoạt cơ chế ứng phó khẩn cấp cấp độ 1.",
          "explanation": "\"面对猝然降临的...灾害\" phản ánh tính bất ngờ hung hãn của thảm họa thiên nhiên."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 44,
      "name": "Phó từ quy nạp kết quả tối hậu \"终归\" (Rốt cuộc thì / Chung quy lại)",
      "pattern": "Chủ ngữ + 终归 + (会 / 是 / 要) + Kết quả quy nạp tất yếu",
      "category": "Phó từ",
      "explanation_vi": "\"终归\" (zhōngguī) là phó từ cao cấp tương đương với \"到底\" hoặc \"终究\", mang ý nghĩa sau khi trải qua muôn vàn biến thiên, quanh co khúc khuỷu, sự việc nhất định sẽ quay trở về với bản chất hoặc kết quả tất yếu của nó theo quy luật (chung quy lại, rốt cuộc thì vẫn cứ).",
      "examples": [
        {
          "chinese": "任何谎言无论编造得多么巧妙，在铁一般的历史事实面前终归是要破产的。",
          "pinyin": "Rènhé huǎngyán wúlùn biānzào de duōme qiǎomiào, zài tiě yībān de lìshǐ shìshí miànqián zhōngguī shì yào pòchǎn de.",
          "translation_vi": "Bất kỳ lời nói dối nào cho dù thêu dệt khéo léo đến đâu, trước sự thật lịch sử vững như sắt thép rốt cuộc thì cũng phải phá sản.",
          "explanation": "\"终归是要破产的\" khẳng định chân lý tất thắng của sự thật trước mọi thủ đoạn lừa dối."
        },
        {
          "chinese": "漂泊在外的游子无论走过多远的风雨路程，其心灵深处的精神根脉终归在故乡。",
          "pinyin": "Piāobó zài wài de yóuzǐ wúlùn zǒuguo duō yuǎn de fēngyǔ lùchéng, qí xīnlíng shēnchù de jīngshén gēnmài zhōngguī zài gùxiāng.",
          "translation_vi": "Người con phiêu bạt bên ngoài bất kể đã đi qua chặng đường mưa gió bao xa, cội rễ tinh thần nơi sâu thẳm tâm hồn rốt cuộc vẫn thuộc về cố hương.",
          "explanation": "\"终归在故乡\" lột tả tình cảm gắn bó thiêng liêng vĩnh cửu của con người với mảnh đất chôn rau cắt rốn."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 45,
      "name": "Phó từ cảm thán mức độ tột cùng \"何其\" (Biết bao / Dường nào / Xiết bao)",
      "pattern": "何其 + Tính từ song âm tiết (相似 / 艰难 / 幸运 / 壮烈 / 荒谬) !",
      "category": "Phó từ",
      "explanation_vi": "\"何其\" (héqí) là phó từ tu từ cảm thán văn ngôn kết hợp chữ \"何\" (sao, thế nào) và \"其\", mang nghĩa \"mức độ cao đến nhường nào, biết bao, xiết bao\". Thường dùng trong câu cảm thán hoặc nghị luận đanh thép để bộc lộ cảm xúc thán phục, kinh ngạc hoặc phẫn nộ tột độ.",
      "examples": [
        {
          "chinese": "历史的进程在某些关键转折点上，其内在逻辑表现得何其相似啊！",
          "pinyin": "Lìshǐ de jìnchéng zài mǒuxiē guānjiàn zhuǎnzhédiǎn shang, qí nèizài luójí biǎoxiàn de héqí xiāngsì a!",
          "translation_vi": "Tiến trình lịch sử tại một số bước ngoặt the chốt, logic nội tại của nó thể hiện ra giống nhau đến dường nào!",
          "explanation": "\"表现得何其相似\" cảm thán về quy luật lặp lại kỳ diệu của các bài học lịch sử."
        },
        {
          "chinese": "老一辈革命先烈在风雨如晦的年代开辟救国救民之路，其探索历程何其艰难卓绝！",
          "pinyin": "Lǎoyíbèi gémìng xiānliè zài fēngyǔrúhuì de niándài kāipì jiùguójiùmín zhī lù, qí tànsuǒ lìchéng héqí jiānnánzhuójué!",
          "translation_vi": "Các bậc tiền liệt cách mạng tiền bối vào thời đại gió mưa mịt mù đã mở ra con đường cứu nước cứu dân, chặng đường tìm tòi ấy gian nan khôn xiết biết bao!",
          "explanation": "\"何其艰难卓绝\" ca ngợi tinh thần kiên cường bất khuất vượt qua muôn trùng thử thách của cha ông."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 46,
      "name": "Cụm liên từ dẫn xuất sự thật xác thực \"诚如\" (Đúng như / Thật đúng như)",
      "pattern": "诚如 + Nhân vật uy tín / Danh ngôn / Lời khẳng định (所言 / 所料 / 大家所见), Mệnh đề",
      "category": "Liên từ",
      "explanation_vi": "\"诚如\" (chéngrú) kết hợp chữ \"诚\" (chân thực, quả thật) và \"如\" (như), mang nghĩa \"thực tế diễn ra hoàn toàn đúng y như lời nhận định, dự báo hoặc danh ngôn của ai đó\" (đúng như đã nói, quả đúng như dự liệu). Dùng để trích dẫn lập luận củng cố uy tín học thuật.",
      "examples": [
        {
          "chinese": "诚如爱因斯坦所言，想象力远比单纯的知识记忆更加重要，因为它是科学探索的源泉。",
          "pinyin": "Chéngrú Àiyīnsītǎn suǒ yán, xiǎngxiànglì yuǎn bǐ dānchún de zhīshi jìyì gèngjiā zhòngyào, yīnwèi tā shì kēxué tànsuǒ de yuánquán.",
          "translation_vi": "Đúng như Einstein từng nói, trí tưởng tượng còn quan trọng hơn nhiều so với việc ghi nhớ kiến thức đơn thuần, bởi vì nó là suối nguồn của sự tìm tòi khoa học.",
          "explanation": "\"诚如...所言\" trích dẫn lời vĩ nhân để nâng cao sức nặng luận điểm cho bài viết."
        },
        {
          "chinese": "诚如专家们此前所料，这项重大金融改革举措的出台极大稳定了市场信心。",
          "pinyin": "Chéngrú zhuānjiāmen cǐqián suǒ liào, zhè xiàng zhòngdà jīnróng gǎigé jǔcuò de chūtái jídà wěndìng le shìchǎng xìnxīn.",
          "translation_vi": "Đúng như các chuyên gia đã dự liệu trước đó, việc ban hành biện pháp cải cách tài chính trọng đại này đã làm ổn định mạnh mẽ niềm tin thị trường.",
          "explanation": "\"诚如...所料\" khẳng định sự chuẩn xác trong công tác dự báo kinh tế của giới học giả."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 47,
      "name": "Động từ/Phó từ tỉ dụ thi ca tráng lệ \"宛如\" (Ví tựa như / Giống hệt như)",
      "pattern": "Chủ ngữ + 宛如 + Cảnh tượng/Hình ảnh thi ca hoa lệ",
      "category": "Phó từ",
      "explanation_vi": "\"宛如\" (wǎnrú) là từ tỉ dụ so sánh mang phẩm cách thi ca trang nhã bậc nhất trong HSK 6, tương đương với \"好似\" hoặc \"仿佛\", nhưng thường đi liền với những bức tranh phong cảnh thiên nhiên tráng lệ hoặc hình tượng nghệ thuật lung linh kỳ vĩ (ví tựa như, dường như).",
      "examples": [
        {
          "chinese": "夜晚从空中俯瞰维多利亚港，两岸璀璨绚丽的万家灯火宛如银河跌落人间。",
          "pinyin": "Yèwǎn cóng kōngzhōng fǔkàn Wéiduōlìyǎ Gǎng, liǎng'àn cuǐcàn xuànlì de wànjiādēnghuǒ wǎnrú yínhé diēluò rénjiān.",
          "translation_vi": "Ban đêm từ trên không trung nhìn xuống cảng Victoria, muôn ánh đèn lung linh rực rỡ hai bên bờ ví tựa dải Ngân Hà rơi xuống cõi nhân gian.",
          "explanation": "\"宛如银河跌落人间\" là câu văn so sánh tuyệt mỹ miêu tả cảnh đêm bến cảng phồn hoa."
        },
        {
          "chinese": "大漠深处的月牙泉宛如一颗镶嵌在金黄色沙海中的璀璨绿宝石，神奇而静谧。",
          "pinyin": "Dàmò shēnchù de Yuèyáquán wǎnrú yì kē xiāngqiàn zài jīnhuángsè shāhǎi zhōng de cuǐcàn lǜbǎoshí, shénqí ér jìngmì.",
          "translation_vi": "Suối Nguyệt Nha nơi sâu thẳm chốn sa mạc ví tựa như một viên ngọc bích rực rỡ khảm vào giữa biển cát vàng óng ả, kỳ diệu và tĩnh mịch.",
          "explanation": "\"宛如一颗...绿宝石\" khắc họa vẻ đẹp độc nhất vô nhị của ốc đảo sa mạc."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 48,
      "name": "Động từ/Phó từ so sánh tương đồng khách quan \"犹如\" (Tựa như / Dường như)",
      "pattern": "Chủ ngữ + 犹如 + Biểu tượng so sánh sâu sắc",
      "category": "Phó từ",
      "explanation_vi": "\"犹如\" (yóurú) có nguồn gốc văn ngôn tương tự \"宛如\", nhưng thiên về việc so sánh giữa các hiện tượng triết học, ý niệm trừu tượng với các quy luật tự nhiên (tựa như, giống như). Thường dùng trong văn phong nghị luận sâu lắng.",
      "examples": [
        {
          "chinese": "一位杰出的思想导师犹如黑夜航行中的明亮灯塔，指引着学子们迷茫的心灵。",
          "pinyin": "Yí wèi jiéchū de sīxiǎng dǎoshī yóurú hēiyè hángxíng zhōng de míngliàng dēngtǎ, zhǐyǐnzhe xuézǐmen mímáng de xīnlíng.",
          "translation_vi": "Một người thầy tư tưởng kiệt xuất tựa như ngọn hải đăng sáng rực trong đêm đen hải trình, dẫn lối cho tâm hồn đang hoang mang của các học trò.",
          "explanation": "\"犹如...明亮灯塔\" ví người thầy với ngọn hải đăng soi sáng con đường tri thức."
        },
        {
          "chinese": "逆水行舟用力撑，一篙松劲退千寻，学业的追求犹如逆水行舟，不进则退。",
          "pinyin": "Nìshuǐ xíng zhōu yònglì chēng, yì gāo sōngjìn tuì qiānxún, xuéyè de zhuīqiú yóurú nìshuǐxíngzhōu, bújìnzétuì.",
          "translation_vi": "Chèo thuyền ngược dòng phải dốc sức chống, lơi tay một sào ắt lùi ngàn tầm, sự theo đuổi học nghiệp tựa như chèo thuyền ngược nước, không tiến ắt lùi.",
          "explanation": "\"犹如逆水行舟\" trích dẫn thành ngữ kinh điển răn dạy sự khổ học không được buông lỏng."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 49,
      "name": "Liên từ lựa chọn văn ngôn thà rằng \"毋宁\" (Thà rằng / Chi bằng / Đúng hơn là)",
      "pattern": "与其 A, 毋宁 B (B mới là sự lựa chọn hoặc định nghĩa chuẩn xác)",
      "category": "Liên từ",
      "explanation_vi": "\"毋宁\" (wúnìng) là liên từ văn ngôn cổ kính tương đương với \"不如\" hoặc \"宁肯\", biểu thị thái độ thà rằng chọn phương án B còn hơn phương án A, hoặc khẳng định cách gọi B mới phản ánh đúng chân lý hơn (chi bằng, thà rằng, đúng hơn là). Thường kết hợp với \"与其\".",
      "examples": [
        {
          "chinese": "与其苟且偷生而出卖自己的人格尊严，毋宁为了捍卫正义而英勇就义。",
          "pinyin": "Yǔqí gǒuqiětōushēng ér chūmài zìjǐ de réngé zūnyán, wúnìng wèile hànwèi zhèngyì ér yīngyǒngjiùyì.",
          "translation_vi": "Thay vì sống tạm bợ hèn nhát mà bán rẻ phẩm giá nhân cách của bản thân, thà rằng anh dũng hy sinh vì sự nghiệp bảo vệ chính nghĩa.",
          "explanation": "\"与其...毋宁...\" thể hiện khí tiết trung liệt cao cả thà chết vinh còn hơn sống nhục."
        },
        {
          "chinese": "这项重大的科学发现与其说是个人智慧的灵光一现，毋宁说是无数前人垫脚石堆叠的必然产物。",
          "pinyin": "Zhè xiàng zhòngdà de kēxué fāxiàn yǔqí shuō shì gèrén zhìhuì de língguāngyíxiàn, wúnìng shuō shì wúshù qiánrén diànjiǎoshí duīdié de bìrán chǎnwù.",
          "translation_vi": "Phát hiện khoa học trọng đại này thay vì nói là sự lóe sáng của trí tuệ cá nhân, đúng hơn nên nói là sản vật tất yếu được đắp bồi từ những hòn đá lót đường của vô số tiền nhân đi trước.",
          "explanation": "\"毋宁说是...\" khiêm tốn ghi nhận công lao tích lũy của nhiều thế hệ khoa học tiền bối."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 50,
      "name": "Cụm phó từ khẳng định không thể tranh cãi \"不容置疑\" (Không được phép hoài nghi)",
      "pattern": "Chủ quyền / Sự thật / Nguyên tắc + 是不容置疑的",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"不容置疑\" (bùróng zhìyí) kết hợp chữ 不容 (không cho phép) và 置疑 (đặt câu hỏi hoài nghi), biểu thị một sự thật, một nguyên tắc hoặc chủ quyền thiêng liêng tuyệt đối không cho phép bất kỳ ai được nghi ngờ, xuyên tạc hay bàn cãi (hoàn toàn không được phép nghi ngờ). Thường dùng trong tuyên ngôn ngoại giao quốc gia.",
      "examples": [
        {
          "chinese": "中国对包括钓鱼岛及其附属岛屿在内的领土拥有无可争辩的主权，这是不容置疑的历史事实。",
          "pinyin": "Zhōngguó duì bāokuò Diàoyúdǎo jí qí fùshǔ dǎoyǔ zài nèi de lǐngtǔ yōngyǒu wúkězhēngbiàn de zhǔquán, zhè shì bùróngzhìyí de lìshǐ shìshí.",
          "translation_vi": "Trung Quốc có chủ quyền không thể tranh cãi đối với lãnh thổ bao gồm đảo Điếu Ngư cùng các đảo phụ cận, đây là sự thật lịch sử không cho phép hoài nghi.",
          "explanation": "\"是不容置疑的历史事实\" khẳng định lập trường chủ quyền quốc gia vững như bàn thạch."
        },
        {
          "chinese": "法律面前人人平等是现代法治文明的基本准则，任何特权阶层的存在都是不容置疑的违法行为。",
          "pinyin": "Fǎlǜ miànqián rénrén píngděng shì xiàndài fǎzhì wénmíng de jīběn zhǔnzé, rènhé tèquán jiēcéng de cúnzài dōu shì bùróngzhìyí de wéifǎ xíngwéi.",
          "translation_vi": "Mọi người đều bình đẳng trước pháp luật là chuẩn tắc cơ bản của văn minh pháp quyền hiện đại, sự tồn tại của bất kỳ tầng lớp đặc quyền nào đều là hành vi vi phạm pháp luật không thể bàn cãi.",
          "explanation": "\"是不容置疑的...\" bảo vệ nguyên tắc công bằng tư pháp tối thượng."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 51,
      "name": "Cụm phó từ cảnh báo không thể xem nhẹ \"不容忽视\" (Không được phép xem nhẹ / Bỏ qua)",
      "pattern": "Vấn đề / Nguy cơ tiềm ẩn / Tác dụng + 是不容忽视的",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"不容忽视\" (bùróng hūshì) biểu thị một hiện tượng, một nguy cơ tiềm ẩn hoặc tác động tiêu cực có tầm vóc vô cùng nghiêm trọng, bắt buộc toàn xã hội phải cảnh giác cao độ và nghiêm túc xử lý, tuyệt đối không được lơ là xem nhẹ (không thể xem thường).",
      "examples": [
        {
          "chinese": "电子产品的过度使用对少年儿童视力健康造成的长期负面影响，是绝对不容忽视的。",
          "pinyin": "Diànzǐ chǎnpǐn de guòdù shǐyòng duì shàonián értóng shìlì jiànkāng zàochéng de chángqī fùmiàn yǐngxiǎng, shì juéduì bùróng hūshì de.",
          "translation_vi": "Tác động tiêu cực dài hạn của việc lạm dụng thiết bị điện tử đối với sức khỏe thị lực của trẻ em và thanh thiếu niên là điều tuyệt đối không được phép xem nhẹ.",
          "explanation": "\"是不容忽视的\" gióng lên hồi chuông cảnh báo tới các bậc phụ huynh và nhà trường."
        },
        {
          "chinese": "中小企业在吸纳社会劳动力就业和激发市场创新活力方面所起的独特作用，不容忽视。",
          "pinyin": "Zhōngxiǎo qǐyè zài xīnà shèhuì láodònglì jiùyè hé jīfā shìchǎng chuàngxīn huólì fāngmiàn suǒ qǐ de dútè zuòyòng, bùróng hūshì.",
          "translation_vi": "Tác dụng độc đáo của các doanh nghiệp vừa và nhỏ trong việc thu hút việc làm cho lực lượng lao động xã hội và khơi dậy sức sống sáng tạo thị trường là điều không thể xem thường.",
          "explanation": "\"不容忽视\" khẳng định vị thế xương sống của khối doanh nghiệp vừa và nhỏ trong nền kinh tế."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 52,
      "name": "Cấu trúc quy luật hành động bắt buộc \"势在必行\" (Thế tất phải làm / Bắt buộc phải tiến hành)",
      "pattern": "Việc cải cách/xử lý vấn đề + 势在必行",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"势在必行\" (shì zài bì xíng) kết hợp chữ 势 (xu thế), 必 (tất yếu) và 行 (hành động), biểu thị một cuộc cải cách, chuyển đổi thể chế hoặc giải pháp cấp bách đã chín muồi về mặt xu thế khách quan, bắt buộc phải tiến hành thực hiện ngay lập tức chứ không thể trì hoãn thêm (thế tất phải làm, việc không thể không làm).",
      "examples": [
        {
          "chinese": "面对严峻的能源危机与环境保护重任，加快推进传统工业的绿色低碳改造势在必行。",
          "pinyin": "Miànduì yánjùn de néngyuán wēijī yǔ huánjìng bǎohù zhòngrèn, jiākuài tuījìn chuántǒng gōngyè de lǜsè dītàn gǎizào shìzàibìxíng.",
          "translation_vi": "Đối mặt với cuộc khủng hoảng năng lượng ngặt nghèo và trọng trách bảo vệ môi trường, việc đẩy nhanh thúc đẩy cải tạo xanh giảm thiểu carbon đối với công nghiệp truyền thống là điều thế tất phải làm.",
          "explanation": "\"势在必行\" khẳng định tính cấp bách không thể đảo ngược của chiến lược chuyển đổi năng lượng xanh."
        },
        {
          "chinese": "为了破除阻碍科技成果转化的体制机制障碍，新一轮深化科研评价制度改革势在必行。",
          "pinyin": "Wèile pòchú zǔ'ài kējì chéngguǒ zhuǎnhuà de tǐzhì jīzhì zhàng'ài, xīn yì lún shēnhuà kēyán píngjià zhìdù gǎigé shìzàibìxíng.",
          "translation_vi": "Để xóa bỏ các rào cản thể chế cơ chế cản trở việc chuyển hóa thành quả khoa học công nghệ, đợt cải cách sâu rộng chế độ đánh giá nghiên cứu khoa học mới là điều bắt buộc phải tiến hành.",
          "explanation": "\"改革势在必行\" thể hiện quyết tâm chính trị mạnh mẽ tháo gỡ điểm nghẽn cho giới nghiên cứu."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 53,
      "name": "Cấu trúc tình thế nguy cấp sát sườn \"迫在眉睫\" (Cấp bách trước mắt / Nước sôi lửa bỏng)",
      "pattern": "Nhiệm vụ / Hiểm họa / Vấn đề + 迫在眉睫",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"迫在眉睫\" (pò zài méijié) là thành ngữ ngữ pháp hóa miêu tả tình huống khẩn cấp đến mức lửa cháy sát tới tận lông mày và lông mi (gần ngay trước mắt, ngàn cân treo sợi tóc, vô cùng cấp bách).",
      "examples": [
        {
          "chinese": "洪水即将漫过堤坝，紧急转移低洼地带数万被困群众的任务迫在眉睫。",
          "pinyin": "Hóngshuǐ jíjiāng mànguò dībà, jǐnjí zhuǎnyí dīwā dìdài shù wàn bèikùn qúnzhòng de rènwu pòzàiméijié.",
          "translation_vi": "Nước lũ sắp sửa tràn qua mặt đê, nhiệm vụ khẩn cấp sơ tán hàng vạn quần chúng đang mắc kẹt ở vùng trũng thấp đang cấp bách trước mắt.",
          "explanation": "\"任务迫在眉睫\" đặc tả tính chất sinh tử của nhiệm vụ sơ tán lũ lụt từng giây từng phút."
        },
        {
          "chinese": "全球生物多样性急剧衰退的危机迫在眉睫，国际社会必须立即采取联合拯救行动。",
          "pinyin": "Quánqiú shēngwù duōyàngxìng jíjù shuāituì de wēijī pòzàiméijié, guójì shèhuì bìxū lìjí cǎiqǔ liánhé zhěngjiù xíngdòng.",
          "translation_vi": "Cuộc khủng hoảng suy thoái nghiêm trọng của đa dạng sinh học toàn cầu đang cấp bách ngay trước mắt, cộng đồng quốc tế bắt buộc phải hành động giải cứu phối hợp ngay tức thì.",
          "explanation": "\"危机迫在眉睫\" thôi thúc toàn cầu chung tay ngăn chặn thảm họa tuyệt chủng sinh vật."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 54,
      "name": "Cấu trúc trọng lượng chi phối cán cân cục diện \"举足轻重\" (Có sức nặng quyết định / Cân bằng cục diện)",
      "pattern": "Chủ ngữ + 在...中起着 / 占据着 + 举足轻重的地位 / 作用",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"举足轻重\" (jǔzúqīngzhòng) có nguồn gốc từ binh thư cổ đại: mỗi bước chân di chuyển của một thế lực đều làm lệch cán cân sức mạnh của toàn cuộc diện. Dùng để chỉ một nhân vật, quốc gia hoặc ngành công nghiệp có vai trò rường cột, mang tính quyết định chi phối đại cục (giữ vị trí then chốt, nhất cử nhất động làm rung chuyển cục diện).",
      "examples": [
        {
          "chinese": "芯片制造业作为现代数字经济的心脏，在全球高科技产业链中具有举足轻重的战略地位。",
          "pinyin": "Xīnpiàn zhìzàoyè zuòwéi xiàndài shùzì jīngjì de xīnzàng, zài quánqiú gāo kējì chǎnyèliàn zhōng jùyǒu jǔzúqīngzhòng de zhànlüè dìwèi.",
          "translation_vi": "Ngành sản xuất chip bán dẫn với tư cách là trái tim của nền kinh tế số hiện đại có vị thế chiến lược mang tính quyết định chi phối trong chuỗi ngành công nghệ cao toàn cầu.",
          "explanation": "\"具有举足轻重的战略地位\" làm rõ vai trò yết hầu của vi mạch điện tử trong thế giới hiện đại."
        },
        {
          "chinese": "他在该跨国并购案中凭借深厚的法律造诣和谈判技巧，起到了举足轻重的关键推动作用。",
          "pinyin": "Tā zài gāi kuàguó bìnggòu'àn zhōng píngjiè shēnhòu de fǎlǜ zàoyì hé tánpàn jìqiǎo, qǐdào le jǔzúqīngzhòng de guānjiàn tuīdòng zuòyòng.",
          "translation_vi": "Anh ấy trong thương vụ sáp nhập xuyên quốc gia này nhờ vào học vấn pháp lý thâm sâu và kỹ năng đàm phán đã đóng vai trò then chốt có sức nặng quyết định thúc đẩy thành công.",
          "explanation": "\"起到了举足轻重的作用\" ca ngợi tài năng đàm phán xoay chuyển cục diện của luật sư trưởng."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 55,
      "name": "Cấu trúc liên hệ hữu cơ sống còn \"息息相关\" (Liên quan mật thiết / Hơi thở liền kề)",
      "pattern": "A 与 / 和 B + 息息相关 (như hơi thở gắn liền sự sống)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"息息相关\" (xīxī xiāngguān) kết hợp chữ \"息\" (hơi thở), biểu thị hai sự vật gắn bó chặt chẽ với nhau tới mức từng nhịp thở đều hòa làm một, lợi hại tương quan mật thiết không thể tách rời (liên quan mật thiết, gắn bó máu thịt).",
      "examples": [
        {
          "chinese": "物价稳定和食品安全直接关系到千家万户的切身福祉，与人民群众的幸福感息息相关。",
          "pinyin": "Wùjià wěndìng hé shípǐn ānquán zhíjiē guānxì dào qiānjiāwànhù de qiēshēn fúzhǐ, yǔ rénmín qúnzhòng de xìngfúgǎn xīxīxiāngguān.",
          "translation_vi": "Giá cả ổn định và an toàn thực phẩm liên quan trực tiếp tới phúc lợi thiết thân của hàng vạn gia đình, gắn bó mật thiết tới cảm giác hạnh phúc của quần chúng nhân dân.",
          "explanation": "\"与...幸福感息息相关\" nêu rõ mối quan hệ khăng khít giữa kinh tế đời sống và chỉ số hạnh phúc xã hội."
        },
        {
          "chinese": "生态环境质量的好坏，与整个人类社会未来的可持续繁衍息息相关。",
          "pinyin": "Shēngtài huánjìng zhìliàng de hǎohuài, yǔ zhěng gè rénlèi shèhuì wèilái de kěchíxù fányǎn xīxīxiāngguān.",
          "translation_vi": "Chất lượng môi trường sinh thái tốt hay xấu gắn bó mật thiết với sự sinh sôi phát triển bền vững tương lai của toàn bộ xã hội loài người.",
          "explanation": "\"与...繁衍息息相关\" liên kết sự bảo vệ tự nhiên với tương lai tồn vong của giống nòi nhân loại."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 56,
      "name": "Cấu trúc chia ngọt sẻ bùi đồng cam cộng khổ \"休戚与共\" (Cùng chung chia sẻ buồn vui / Hoạn nạn có nhau)",
      "pattern": "A 与 B + 形成 / 建设 + 休戚与共的命运共同体",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"休戚与共\" (xiūqī yǔgòng) kết hợp chữ \"休\" (điều mừng, hoan lạc) và \"戚\" (nỗi buồn, hoạn nạn), mang ý nghĩa cùng nhau chia sẻ mọi niềm vui lẫn nỗi buồn, kề vai sát cánh sống chết có nhau trong cùng một vận mệnh (đồng cam cộng khổ, hoạn nạn chia bùi). Mẫu câu chuẩn mực xây dựng \"Cộng đồng chung vận mệnh nhân loại\".",
      "examples": [
        {
          "chinese": "在这个全球深度互联的信息时代，世界各国同乘一条大船，早已结成了休戚与共的命运共同体。",
          "pinyin": "Zài zhè ge quánqiú shēndù hùlián de xìnxī shídài, shìjiè gèguó tóng chéng yì tiáo dàchuán, zǎoyǐ jiéchéng le xiūqīyǔgòng de mìngyùn gòngtóngtǐ.",
          "translation_vi": "Trong thời đại thông tin kết nối sâu sắc toàn cầu này, các quốc gia trên thế giới cùng ngồi chung một con thuyền lớn, từ lâu đã kết thành một cộng đồng chung vận mệnh đồng cam cộng khổ.",
          "explanation": "\"休戚与共的命运共同体\" là khẩu hiệu ngoại giao toàn cầu thể hiện tính tương trợ quốc tế."
        },
        {
          "chinese": "军民休戚与共、生死相依的光荣传统，是我们战胜一切艰难险阻的最坚固长城。",
          "pinyin": "Jūnmín xiūqīyǔgòng, shēngsǐxiāngyī de guāngróng chuántǒng, shì wǒmen zhànshèng yíqiè jiānnánxiǎnzǔ de zuì jiāngù chángchéng.",
          "translation_vi": "Truyền thống vẻ vang quân dân đồng cam cộng khổ, sống chết có nhau chính là bức Vạn Lý Trường Thành vững chắc nhất giúp chúng ta chiến thắng mọi gian nan hiểm trở.",
          "explanation": "\"军民休戚与共\" ca ngợi tình cảm gắn bó keo sơn như cá với nước giữa quân đội và nhân dân."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 57,
      "name": "Cấu trúc cố định tổng kết văn kiện chính thức: \"综上所述\"",
      "pattern": "Phân tích các luận điểm chi tiết. 综上所述, Kết luận quy nạp toàn diện",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"综上所述\" (zōng shàng suǒ shù) kết hợp chữ 综 (tổng hợp), 上 (ở trên), 所述 (những điều đã trình bày), mang nghĩa \"tổng hợp lại toàn bộ những sự thật, số liệu và lập luận đã được nêu ra ở các đoạn trên\". Là từ mở màn đoạn kết chuẩn mực tuyệt đối trong luận án tiến sĩ, báo cáo kiểm toán và bản cáo trạng tòa án.",
      "examples": [
        {
          "chinese": "综上所述，该研发项目不仅技术路径完全可行，而且预期经济效益显著，建议董事会立即批准立项。",
          "pinyin": "Zōngshàngsuǒshù, gāi yánfā xiàngmù bùjǐn jìshù lùjìng wánquán kěxíng, érqiě yùqī jīngjì xiàoyì xiǎnzhù, jiànyì dǒngshìhuì lìjí pīzhǔn lìxiàng.",
          "translation_vi": "Tổng hợp những điều đã trình bày ở trên, dự án nghiên cứu phát triển này không chỉ có lộ trình công nghệ hoàn toàn khả thi, mà hiệu quả kinh tế kỳ vọng lại hết sức rõ rệt, kiến nghị hội đồng quản trị lập tức phê chuẩn khởi động dự án.",
          "explanation": "\"综上所述...\" đúc kết thẩm định dự án thuyết phục đưa ra kiến nghị quyết sách đầu tư."
        },
        {
          "chinese": "综上所述，原告提交的各项证据确凿充分，被告侵犯商业机密的事实清楚，应当承担全部民事赔偿责任。",
          "pinyin": "Zōngshàngsuǒshù, yuángào tíjiāo de gè xiàng zhèngjù quèzáo chōngfèn, bèigào qīnfàn shāngyè jīmì de shìshí qīngchu, yīngdāng chéngdān quánbù mínshì péicháng zérèn.",
          "translation_vi": "Tổng hợp lại những điều đã trình bày ở trên, các bằng chứng mà nguyên đơn nộp lên là xác thực đầy đủ, sự thật bị đơn xâm phạm bí mật thương mại là rõ ràng, phải chịu toàn bộ trách nhiệm bồi thường dân sự.",
          "explanation": "\"综上所述...\" là lời luận tội và lập luận kết án mẫu mực của luật sư trong phiên tòa dân sự."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 58,
      "name": "Cấu trúc cố định dẫn chiếu tài liệu đính kèm: \"详见附录 / 详见下文\"",
      "pattern": "Khái quát ngắn gọn (详见附录 A / 具体技术参数详见下文表格)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"详见\" (xiángjiàn) kết hợp chữ \"详\" (chi tiết, tường tận) và \"见\" (xem, tra cứu), dùng trong các văn bản học thuật khoa học, tài liệu kỹ thuật hoặc phụ lục hợp đồng để hướng dẫn người đọc tra cứu bảng biểu dữ liệu chi tiết (xem chi tiết tại phụ lục / xem cụ thể ở phần văn bản bên dưới).",
      "examples": [
        {
          "chinese": "关于本次实验的具体化学试剂配比及安全操作细则，详见本报告附录三。",
          "pinyin": "Guānyú běn cì shíyàn de jùtǐ huàxué shìjì pèibǐ jí ānquán cāozuò xìzé, xiángjiàn běn bàogào fùlù sān.",
          "translation_vi": "Về tỷ lệ pha chế hóa chất cụ thể và quy tắc thao tác an toàn của thí nghiệm lần này, xem chi tiết tại Phụ lục 3 của báo cáo này.",
          "explanation": "\"详见本报告附录三\" chỉ dẫn nguồn dữ liệu kỹ thuật chuẩn xác trong văn bản khoa học."
        },
        {
          "chinese": "各类参赛作品的投稿规格要求及评奖评分细则，详见大赛官方网站下文通告。",
          "pinyin": "Gèlèi cànsài zuòpǐn de tóugǎo guīgé yāoqiú jí píngjiǎng píngfēn xìzé, xiángjiàn dàsài guānfāng wǎngzhàn xiàwén tōnggào.",
          "translation_vi": "Yêu cầu quy chuẩn gửi bài dự thi của các thể loại tác phẩm cùng chi tiết chấm điểm trao giải, xin xem chi tiết thông báo bên dưới trên trang web chính thức của cuộc thi.",
          "explanation": "\"详见...下文通告\" hướng dẫn thí sinh theo dõi chi tiết thể lệ cuộc thi."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 59,
      "name": "Cấu trúc văn ngôn đúc kết bài học lịch sử \"鉴往知来\" (Soi xét quá khứ thấu hiểu tương lai)",
      "pattern": "鉴往知来, Chủ ngữ + Cần phải tổng kết kinh nghiệm lịch sử",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"鉴往知来\" (jiàn wǎng zhī lái) kết hợp chữ 鉴 (soi gương, xem xét), 往 (quá khứ), 知 (biết), 来 (tương lai), mang ý nghĩa lấy lịch sử quá khứ làm tấm gương soi chiếu để rút ra bài học kinh nghiệm dẫn đường cho tương lai (ôn nghèo nhớ khổ, soi xưa đoán nay). Thường dùng trong các thông điệp giáo dục truyền thống.",
      "examples": [
        {
          "chinese": "历史是最好的教科书，我们只有鉴往知来，才能在复兴的新征程上行稳致远。",
          "pinyin": "Lìshǐ shì zuì hǎo de jiàokēshū, wǒmen zhǐyǒu jiànwǎngzhīlái, cái néng zài fùxīng de xīn zhēngchéng shang xíngwěnzhìyuǎn.",
          "translation_vi": "Lịch sử là cuốn sách giáo khoa tốt nhất, chúng ta chỉ khi biết soi xét quá khứ để định hướng tương lai thì mới có thể vững bước tiến xa trên chặng đường phục hưng mới.",
          "explanation": "\"鉴往知来，行稳致远\" là cặp đối ngữ chính luận lịch sử kinh điển định hướng cho tương lai."
        },
        {
          "chinese": "回顾人类历次公共卫生危机的演变规律，鉴往知来，对于完善当代全球疾病防控体系具有重大启示。",
          "pinyin": "Huígù rénlèi lìcì gōnggòng wèishēng wēijī de yǎnbiàn guīlǜ, jiànwǎngzhīlái, duìyú wánshàn dāngdài quánqiú jíbìng fángkòng tǐxì jùyǒu zhòngdà qǐshì.",
          "translation_vi": "Nhìn lại quy luật diễn biến của các cuộc khủng hoảng y tế công cộng qua các thời kỳ của nhân loại, soi xét quá khứ để hiểu tương lai có gợi mở to lớn đối với việc hoàn thiện hệ thống phòng chống dịch bệnh toàn cầu đương đại.",
          "explanation": "\"鉴往知来\" đúc kết bài học dịch tễ học lịch sử để ứng phó với đại dịch tương lai."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 60,
      "name": "Cấu trúc cố định trạng thái chờ hoàn thiện: \"有待于\"",
      "pattern": "Vấn đề phức tạp + 尚 / 仍 + 有待于 + Động từ song âm tiết (解决 / 验证 / 考证 / 澄清 / 完善)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"有待于\" (yǒudàiyú) kết hợp chữ 有待 (còn chờ đợi, còn cần phải) và 于 (đối với), mang nghĩa một vấn đề học thuật hoặc vướng mắc xã hội hiện tại vẫn chưa hoàn tất, còn cần phải tiếp tục nghiên cứu, thẩm định hoặc nỗ lực giải quyết thêm trong tương lai (còn cần phải, vẫn còn đợi). Thường đi kèm với phó từ \"尚\" hoặc \"仍\".",
      "examples": [
        {
          "chinese": "尽管初步临床试验展现出了良好效果，但该药品的长期安全性仍有待于更大样本的跟踪验证。",
          "pinyin": "Jǐnguǎn chūbù línchuáng shìyàn zhǎnxiàn chū le liánghǎo xiàoguǒ, dàn gāi yàopǐn de chángqī ānquánxìng réng yǒudàiyú gèng dà yàngběn de gēnzōng yànzhèng.",
          "translation_vi": "Tuy rằng thử nghiệm lâm sàng bước đầu đã bộc lộ hiệu quả khả quan, nhưng độ an toàn lâu dài của dược phẩm này vẫn còn cần phải theo dõi xác chứng với quy mô mẫu lớn hơn.",
          "explanation": "\"仍有待于...跟踪验证\" thể hiện đạo đức khoa học thận trọng nghiêm ngặt của ngành y dược."
        },
        {
          "chinese": "出土竹简中记录的这几条古老律法条文的确切含义，学术界尚有待于进一步深入考证。",
          "pinyin": "Chūtǔ zhújiǎn zhōng jìlù de zhè jǐ tiáo gǔlǎo lǜfǎ tiáowén de quèqiè hányì, xuéshùjiè shàng yǒudàiyú jìnyíbù shēnrù kǎozhèng.",
          "translation_vi": "Ý nghĩa chuẩn xác của mấy điều khoản luật pháp cổ xưa ghi trên thẻ tre khai quật được, giới học thuật vẫn còn phải chờ đợi sự khảo cứu sâu hơn nữa.",
          "explanation": "\"尚有待于进一步考证\" xác lập tính mở trong công tác nghiên cứu khảo cổ học."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 61,
      "name": "Cấu trúc cố định cống hiến tâm sức trọn vẹn: \"致力于\"",
      "pattern": "Chủ ngữ + 长期 / 始终 + 致力于 + Sự nghiệp vĩ đại / Mục tiêu cao cả",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"致力于\" (zhìlìyú) kết hợp chữ \"致\" (dốc hết, tận lực), \"力\" (sức lực) và \"于\", mang nghĩa cống hiến toàn bộ tâm trí, sức lực và thời gian vào việc theo đuổi một sự nghiệp cao cả, hòa bình, khoa học hoặc giáo dục (hết lòng dốc sức vào, tận tâm cống hiến cho).",
      "examples": [
        {
          "chinese": "这位诺贝尔和平奖得主毕生致力于消除全球贫困与促进跨文明平等对话。",
          "pinyin": "Zhè wèi Nuòbèi'ěr hépíngjiǎng dézhǔ bìshēng zhìlìyú xiāochú quánqiú pínkùn yǔ cùjìn kuà wénmíng píngděng duìhuà.",
          "translation_vi": "Chủ nhân giải Nobel Hòa bình này suốt cả đời đã hết lòng dốc sức vào sự nghiệp xóa đói giảm nghèo toàn cầu và thúc đẩy đối thoại bình đẳng xuyên các nền văn minh.",
          "explanation": "\"毕生致力于...\" ca ngợi lý tưởng nhân đạo cao cả dâng hiến trọn đời vì hòa bình nhân loại."
        },
        {
          "chinese": "中国政府始终坚定不移地致力于维护多边主义国际秩序与促进共同繁荣。",
          "pinyin": "Zhōngguó zhèngfǔ shǐzhōng jiāndìngbùyí de zhìlìyú wéihù duōbiānzhǔyì guójì zhìxù yǔ cùjìn gòngtóng fánróng.",
          "translation_vi": "Chính phủ Trung Quốc luôn kiên định không dời dốc sức vào việc bảo vệ trật tự quốc tế chủ nghĩa đa phương và thúc đẩy sự phồn vinh chung.",
          "explanation": "\"致力于维护...秩序\" là lời cam kết ngoại giao cấp cao nhất về trách nhiệm nước lớn."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 62,
      "name": "Động từ/Cấu trúc cố định chứng nhân lịch sử: \"见证了\"",
      "pattern": "Di tích / Thế hệ tiền bối / Công trình + 见证了 + Biến thiên lịch sử / Kỳ tích",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"见证\" (jiànzhèng) là động từ cao cấp chỉ việc một nhân vật, một tòa nhà di tích lịch sử hoặc một dòng sông đã tận mắt chứng kiến, ghi dấu lại toàn bộ sự biến đổi thăng trầm hoặc sự ra đời của những kỳ tích vĩ đại qua năm tháng (làm nhân chứng, chứng kiến sự ra đời).",
      "examples": [
        {
          "chinese": "这座横跨长江的现代化大桥不仅连通了两岸交通，更见证了中国基建工业腾飞的奇迹历程。",
          "pinyin": "Zhè zuò héngkuà Chángjiāng de xiàndàihuà dàqiáo bùjǐn liántōng le liǎng'àn jiāotōng, gèng jiànzhèng le Zhōngguó jījiàn gōngyè téngfēi de qíjì lìchéng.",
          "translation_vi": "Cây cầu lớn hiện đại bắc qua sông Trường Giang này không chỉ kết nối giao thông hai bên bờ, mà càng chứng kiến chặng đường kỳ tích cất cánh của ngành công nghiệp xây dựng hạ tầng Trung Quốc.",
          "explanation": "\"见证了...奇迹历程\" nhân hóa cây cầu thành chứng nhân sống động cho sự trỗi dậy của đất nước."
        },
        {
          "chinese": "几代地质勘探队员扎根荒原六十年，亲眼见证了这片不毛之地崛起为现代化石油新城的沧桑巨变。",
          "pinyin": "Jǐ dài dìzhì kāntàn duìyuán zhāgēn huāngyuán liùshí nián, qīnyǎn jiànzhèng le zhè piàn bùmáozhīdì juéqǐ wéi xiàndàihuà shíyóu xīnchéng de cāngsāngjùbiàn.",
          "translation_vi": "Mấy thế hệ cán bộ thăm dò địa chất cắm rễ nơi hoang mạc suốt 60 năm, tận mắt chứng kiến sự đổi thay dâu bể của vùng đất không ngọn cỏ này vươn mình thành một đô thị dầu khí hiện đại.",
          "explanation": "\"见证了...沧桑巨变\" ca ngợi công lao của những người mở đường khai phá mỏ dầu."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 63,
      "name": "Giới từ văn ngôn chỉ địa điểm nơi chốn \"于\" (Ở / Tại / Nơi)",
      "pattern": "Động từ + 于 + Địa điểm không gian (生于 / 处于 / 止于 / 见于 / 位于)",
      "category": "Giới từ",
      "explanation_vi": "\"于\" (yú) là giới từ văn ngôn đa năng quan trọng nhất trong tiếng Hán. Khi chỉ không gian, \"于\" đứng sau động từ tương đương với \"在\" (ở, tại, nơi). Thường gặp: 生于 (sinh tại), 位于 (tọa lạc tại), 处于 (đang ở vào thế), 见于 (thấy xuất hiện tại sách báo/di tích).",
      "examples": [
        {
          "chinese": "这位享誉海内外的著名物理学家出生于江苏无锡的一个书香门第。",
          "pinyin": "Zhè wèi xiǎngyù hǎinèiwài de zhùmíng wùlǐxuéjiā chūshēng yú Jiāngsū Wúxī de yí gè shūxiāngméndì.",
          "translation_vi": "Vị nhà vật lý học nổi tiếng danh thơm trong ngoài nước này sinh ra tại một gia đình dòng dõi thư hương ở Vô Tích, Giang Tô.",
          "explanation": "\"出生于...\" dùng \"于\" làm giới từ chỉ nơi chốn nơi vị khoa học gia cất tiếng khóc chào đời."
        },
        {
          "chinese": "当前世界经济正处于深刻转型的关键十字路口，面临诸多不确定因素。",
          "pinyin": "Dāngqián shìjiè jīngjì zhèng chǔyú shēnkè zhuǎnxíng de guānjiàn shízìlùkǒu, miànlín zhūduō bùquèdìngxìng yīnsù.",
          "translation_vi": "Kinh tế thế giới hiện nay đang ở vào ngã tư đường then chốt của sự chuyển dịch sâu sắc, đối mặt với muôn vàn nhân tố bất định.",
          "explanation": "\"处于...十字路口\" là hình ảnh ẩn dụ không gian vị thế của cục diện kinh tế toàn cầu."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 64,
      "name": "Giới từ văn ngôn chỉ thời gian & khởi điểm \"于\" (Vào lúc / Bắt đầu từ / Đến lúc)",
      "pattern": "于 + Thời gian / Động từ + 于 + Thời điểm lịch sử (始于 / 终于 / 成立于)",
      "category": "Giới từ",
      "explanation_vi": "\"于\" (yú) đứng trước hoặc sau các mốc thời gian lịch sử tương đương với \"在...的时候\" (vào năm, vào ngày). Thường dùng: 始于 (bắt đầu từ), 终于 (kết thúc vào), 成立于 (được thành lập vào năm).",
      "examples": [
        {
          "chinese": "中华文明源远流长，其农耕文明的发轫最早可追溯于数千年前的仰韶文化时期。",
          "pinyin": "Zhōnghuá wénmíng yuányuǎnliúcháng, qí nónggēng wénmíng de fārèn zuì zǎo kě zhuīsù yú shù qiān nián qián de Yǎngsháo wénhuà shíqī.",
          "translation_vi": "Văn minh Trung Hoa nguồn xa dòng dài, sự khởi đầu của nền văn minh nông nghiệp của nó sớm nhất có thể ngược dòng về thời kỳ văn hóa Ngưỡng Thiều cách đây mấy nghìn năm.",
          "explanation": "\"追溯于...时期\" dùng \"于\" dẫn ra mốc khởi điểm xa xưa của nền văn minh lúa nước."
        },
        {
          "chinese": "中国自主设计建造的第一座核电站于一九九一年底顺利并网发电。",
          "pinyin": "Zhōngguó zìzhǔ shèjì jiànzào de dì yī zuò hédiànzhàn yú yījiǔjiǔyī niándǐ shùnlì bìngwǎng fādiàn.",
          "translation_vi": "Nhà máy điện hạt nhân đầu tiên do Trung Quốc tự chủ thiết kế xây dựng đã thuận lợi hòa lưới phát điện vào cuối năm 1991.",
          "explanation": "\"于一九九一年底\" làm trạng ngữ chỉ mốc thời gian lịch sử trọng đại trong công nghiệp năng lượng."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 65,
      "name": "Giới từ văn ngôn chỉ đối tượng tiếp nhận & hướng tới \"于\" (Đối với / Hướng về / Cho)",
      "pattern": "Động từ + 于 + Đối tượng (忠于 / 善于 / 勇于 / 归咎于 / 寄希望于)",
      "category": "Giới từ",
      "explanation_vi": "\"于\" (yú) đứng sau các tính từ hoặc động từ tâm lý để dẫn ra đối tượng được hướng tới hoặc tiếp nhận hành vi, tương đương với \"对\" hoặc \"向\" (đối với ai, hướng tới ai). Thường gặp: 忠于祖国 (trung với tổ quốc), 善于思考 (giỏi suy nghĩ), 寄希望于青年 (đặt kỳ vọng vào giới trẻ).",
      "examples": [
        {
          "chinese": "全体国家工作人员必须时刻牢记宪法誓言，始终忠于祖国、忠于人民、恪尽职守。",
          "pinyin": "Quántǐ guójiā gōngzuò rényuán bìxū shíkè láojì xiànfǎ shìyán, shǐzhōng zhōngyú zǔguó, zhōngyú rénmín, kèjìnzhíshǒu.",
          "translation_vi": "Toàn thể cán bộ công chức nhà nước phải luôn ghi nhớ lời tuyên thệ hiến pháp, luôn luôn trung thành với tổ quốc, trung thành với nhân dân, tận tụy mẫn cán với chức trách.",
          "explanation": "\"忠于祖国、忠于人民\" dùng \"于\" dẫn ra hai đối tượng phụng sự tối cao của người làm công bộc."
        },
        {
          "chinese": "中华民族的伟大复兴与科技自立自强，寄希望于朝气蓬勃的新一代青年学子。",
          "pinyin": "Zhōnghuá mínzú de wěidà fùxīng yǔ kējì zìlìzìqiáng, jì xīwàng yú zhāoqìpéngbó de xīn yídài qīngnián xuézǐ.",
          "translation_vi": "Sự phục hưng vĩ đại và tinh thần tự lực tự cường khoa học công nghệ của dân tộc Trung Hoa gửi gắm hy vọng vào thế hệ học sinh sinh viên trẻ tuổi tràn đầy sức sống.",
          "explanation": "\"寄希望于...\" thể hiện sự trao gửi niềm tin và trọng trách lịch sử lên vai thế hệ măng non."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 66,
      "name": "Giới từ văn ngôn trong so sánh hơn \"于\" (Hơn / Vượt trội hơn)",
      "pattern": "Tính từ / Động từ + 于 + Tiêu chuẩn so sánh (高于 / 大于 / 重于 / 优于 / 胜于)",
      "category": "Giới từ",
      "explanation_vi": "\"于\" (yú) đứng sau tính từ tương đương với chữ \"比\" (hơn, vượt trội hơn so với). Đây là cấu trúc so sánh cổ xưa kinh điển: \"青出于蓝而胜于蓝\" (xanh từ chàm mà đậm hơn chàm), \"人固有一死，或重于泰山，或轻于鸿毛\" (người ta ai cũng một lần chết, có cái chết nặng hơn núi Thái Sơn, có cái chết nhẹ tựa lông hồng).",
      "examples": [
        {
          "chinese": "人固有一死，或重于泰山，或轻于鸿毛，为人民利益而死，就比泰山还重。",
          "pinyin": "Rén gù yǒu yì sǐ, huò zhòng yú Tàishān, huò qīng yú hóngmáo, wèi rénmín lìyì ér sǐ, jiù bǐ Tàishān hái zhòng.",
          "translation_vi": "Đời người ai chẳng có một lần chết, hoặc là chết nặng hơn núi Thái Sơn, hoặc là chết nhẹ hơn chiếc lông hồng, vì lợi ích của nhân dân mà hy sinh thì nặng hơn cả núi Thái Sơn.",
          "explanation": "\"重于泰山，轻于鸿毛\" là danh ngôn tư tưởng Tư Mã Thiên dùng \"于\" so sánh nhân phẩm đỉnh cao."
        },
        {
          "chinese": "这家年轻企业生产的高精度光学传感器，在核心抗震性能指标上明显优于国外同类竞品。",
          "pinyin": "Zhè jiā niánqīng qǐyè shēngchǎn de gāojīngdù guāngxué chuángǎnqì, zài héxīn kàngzhèn xìngnéng zhǐbiāo shang míngxiǎn yōuyú guówài tónglèi jìngpǐn.",
          "translation_vi": "Cảm biến quang học độ chính xác cao do doanh nghiệp trẻ này sản xuất trên các chỉ số tính năng chống rung cốt lõi vượt trội hơn hẳn các sản phẩm cạnh tranh cùng loại của nước ngoài.",
          "explanation": "\"优于国外竞品\" dùng \"优于\" so sánh hơn làm nổi bật năng lực cạnh tranh công nghệ nội địa."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 67,
      "name": "Giới từ văn ngôn trong câu bị động \"于\" (Bị / Chịu sự tác động bởi)",
      "pattern": "Động từ + 于 + Tác nhân gây hại (见笑于 / 受制于 / 困于 / 败于)",
      "category": "Giới từ",
      "explanation_vi": "\"于\" (yú) đứng sau động từ dẫn ra tác nhân gây ra hành động tương đương với chữ \"被\" (bị ai làm cho, chịu sự trói buộc của). Thường gặp: 见笑于大方之家 (bị các bậc uyên bác chê cười), 受制于人 (bị người khác kìm kẹp, chế ngự).",
      "examples": [
        {
          "chinese": "核心技术如果不牢牢掌握在自己手里，国家的产业安全就随时可能受制于人。",
          "pinyin": "Héxīn jìshù rúguǒ bù láoláo zhǎowò zài zìjǐ shǒulǐ, guójiā de chǎnyè ānquán jiù suíshí kěnéng shòuzhìyúrén.",
          "translation_vi": "Công nghệ cốt lõi nếu không nắm chắc trong tay mình thì an ninh ngành công nghiệp quốc gia bất cứ lúc nào cũng có thể bị kẻ khác khống chế kìm kẹp.",
          "explanation": "\"受制于人\" là cấu trúc bị động văn ngôn cảnh báo hiểm họa của sự lệ thuộc công nghệ nước ngoài."
        },
        {
          "chinese": "在学术研究中如果不讲究严谨实证而信口开河，势必会见笑于真正的大方之家。",
          "pinyin": "Zài xuéshù yánjiū zhōng rúguǒ bù jiǎngjiu yánjǐn shízhèng ér xìnkǒukāihé, shìbì huì jiànxiào yú zhēnzhèng de dàfāngzhījiā.",
          "translation_vi": "Trong nghiên cứu học thuật nếu không coi trọng thực chứng cẩn trọng mà nói năng tùy tiện, thế tất sẽ bị các bậc học giả uyên bác thực sự chê cười.",
          "explanation": "\"见笑于大方之家\" kết hợp chữ \"见\" và \"于\" tạo thành mẫu câu bị động văn ngôn kinh điển."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 68,
      "name": "Giới từ văn ngôn phương thức & công cụ \"以\" (Dùng / Lấy / Bằng)",
      "pattern": "以 + Công cụ/Phương thức/Nguyên tắc + 为 + Trọng tâm/Mục tiêu (以科技为引擎 / 以人为本 / 以事实为依据)",
      "category": "Giới từ",
      "explanation_vi": "\"以\" (yǐ) là giới từ văn ngôn nguồn cội chỉ phương tiện, căn cứ hoặc công cụ hành động, tương đương với \"用\" hoặc \"拿\" (lấy... làm..., dùng... để...). Thường xuất hiện trong cấu trúc triết luận chính trị tối cao: \"以...为...\" (lấy A làm B, coi A là B).",
      "examples": [
        {
          "chinese": "我们的城市建设必须坚持以人为本，切实把居民的宜居度作为最重要的考核指标。",
          "pinyin": "Wǒmen de chéngshì jiànshè bìxū jiānchí yǐrénwéiběn, qièshí bǎ jūmín de yíjūdù zuòwéi zuì zhòngyào de kǎohé zhǐbiāo.",
          "translation_vi": "Công cuộc xây dựng đô thị của chúng ta bắt buộc phải kiên trì lấy con người làm gốc, thiết thực coi mức độ đáng sống của cư dân là chỉ số đánh giá quan trọng nhất.",
          "explanation": "\"以人为本\" là tôn chỉ nhân văn tối cao lấy hạnh phúc nhân dân làm gốc rễ phát triển."
        },
        {
          "chinese": "人民法院审理各类民刑案件，必须坚持以事实为依据、以法律为准绳的客观公正原则。",
          "pinyin": "Rénmín fǎyuàn shěnlǐ gèlèi mínxíng ànjiàn, bìxū jiānchí yǐ shìshí wéi yījù, yǐ fǎlǜ wéi zhǔnshéng de kèguān gōngzhèng yuánzé.",
          "translation_vi": "Tòa án Nhân dân khi xét xử các loại án dân sự và hình sự bắt buộc phải kiên trì nguyên tắc khách quan công bằng lấy sự thật làm căn cứ, lấy pháp luật làm thước đo.",
          "explanation": "\"以事实为依据、以法律为准绳\" là kim chỉ nam xét xử tư pháp chuẩn mực quốc gia."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 69,
      "name": "Giới từ/Liên từ mục đích văn ngôn \"以\" (Để / Nhằm / Nhằm mục đích)",
      "pattern": "Hành động tích cực, 以 + Đạt được mục tiêu (以期 / 以防 / 以飨 / 予以 / 以求)",
      "category": "Giới từ",
      "explanation_vi": "\"以\" (yǐ) đứng giữa hai vế câu làm liên từ chỉ mục đích tương đương với \"用来, 为了\" (để, nhằm). Thường kết hợp trong các từ ghép chỉ mục đích: \"以期\" (nhằm hy vọng), \"以防\" (nhằm phòng ngừa), \"以求\" (nhằm mưu cầu).",
      "examples": [
        {
          "chinese": "博物馆在暑假期间免费延长开放两小时，以期满足广大中小学生假期的文化需求。",
          "pinyin": "Bówùguǎn zài shǔjià qījiān miǎnfèi yáncháng kāifàng liǎng xiǎoshí, yǐqī mǎnzú guǎngdà zhōngxiǎoxuéshēng jiàqī de wénhuà xūqiú.",
          "translation_vi": "Bảo tàng trong dịp nghỉ hè miễn phí kéo dài thời gian mở cửa thêm 2 tiếng, nhằm hy vọng đáp ứng nhu cầu văn hóa trong kỳ nghỉ của đông đảo học sinh.",
          "explanation": "\"以期满足...\" nêu rõ mục đích xã hội cao đẹp của việc nới rộng giờ phục vụ công cộng."
        },
        {
          "chinese": "登山队员们在冰川营地储备了充足的氧气和高能食品，以防恶劣风雪天气封锁下山路线。",
          "pinyin": "Dēngshānduìyuánmen zài bīngchuān yíngdì chǔbèi le chōngzú de yǎngqì hé gāonéng shípǐn, yǐfáng èliè fēngxuě tiānqì fēngsuǒ xiàshān lùxiàn.",
          "translation_vi": "Các thành viên đội leo núi đã dự trữ đầy đủ oxy và thực phẩm giàu năng lượng tại doanh trại sông băng, nhằm phòng ngừa thời tiết mưa tuyết khắc nghiệt phong tỏa tuyến đường xuống núi.",
          "explanation": "\"以防...\" nêu rõ rủi ro cần phòng bị trước điều kiện thiên nhiên vùng núi tuyết."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 70,
      "name": "Cấu trúc giới từ xác lập tư cách đại diện: \"以...身份 / 以...名义\"",
      "pattern": "Chủ ngữ + 以 + Tư cách/Danh nghĩa/Chức vụ + Động từ (出席 / 签署 / 呼吁 / 发表声明)",
      "category": "Giới từ",
      "explanation_vi": "\"以...身份\" và \"以...名义\" dùng để xác lập tư cách pháp lý, địa vị xã hội hoặc danh nghĩa đại diện khi một cá nhân hoặc tổ chức tham gia hoạt động ngoại giao, ký kết hợp đồng hoặc công bố tuyên ngôn chính thức (với tư cách là, nhân danh).",
      "examples": [
        {
          "chinese": "这位资深外交官以联合国特别顾问的身份，出席了本次关于中东和平进程的国际会议。",
          "pinyin": "Zhè wèi zīshēn wàijiāoguān yǐ Liánhéguó tèbié gùwèn de shēnfèn, chūxí le běn cì guānyú Zhōngdōng hépíng jìnchéng de guójì huìyì.",
          "translation_vi": "Vị nhà ngoại giao kỳ cựu này với tư cách là cố vấn đặc biệt của Liên Hợp Quốc đã tham dự hội nghị quốc tế lần này về tiến trình hòa bình Trung Đông.",
          "explanation": "\"以...身份出席\" xác định tư cách đại diện phái đoàn quốc tế hợp pháp của nhà ngoại giao."
        },
        {
          "chinese": "他以全资控股企业法人的名义，与当地政府正式签署了总投资五十亿元的新能源汽车产业园合作协议。",
          "pinyin": "Tā yǐ quánzī kònggǔ qǐyè fǎrén de míngyì, yǔ dāngdì zhèngfǔ zhèngshì qiānshǔ le zǒng tóuzī wǔshí yì yuán de xīn néngyuán qìchē chǎnyèyuán hézuò xiéyì.",
          "translation_vi": "Ông ấy nhân danh pháp nhân doanh nghiệp nắm giữ 100% vốn đã chính thức ký kết với chính quyền địa phương thỏa thuận hợp tác khu công nghiệp xe ô tô năng lượng mới với tổng vốn đầu tư 5 tỷ nhân dân tệ.",
          "explanation": "\"以...法人的名义\" xác lập năng lực chủ thể ký kết hợp đồng kinh tế theo luật doanh nghiệp."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 71,
      "name": "Giới từ căn cứ chuẩn tắc trang trọng \"依\" (Căn cứ vào / Chiểu theo / Nương theo)",
      "pattern": "依 + Căn cứ/Ý kiến (依我之见 / 依法 / 依规 / 依此类推 / 依我看)",
      "category": "Giới từ",
      "explanation_vi": "\"依\" (yī) là giới từ văn ngôn trang trọng mang nghĩa \"căn cứ vào, chiểu theo, dựa trên cơ sở\" (tương đương với 按照 hoặc 根据). Thường gặp trong các cấu trúc kinh điển: \"依我之见\" (theo thiển kiến của tôi), \"依法治国\" (quản lý đất nước theo pháp luật), \"依此类推\" (cứ theo loại này mà suy luận tiếp).",
      "examples": [
        {
          "chinese": "依我之见，解决这一国际争端的唯一正途，依然在于通过平等坦诚的政治外交谈判。",
          "pinyin": "Yī wǒ zhī jiàn, jiějué zhè yì guójì zhēngduān de wéiyī zhèngtú, yīrán zàiyú tōngguò píngděng tǎnchéng de zhèngzhì wàijiāo tánpàn.",
          "translation_vi": "Theo thiển kiến của tôi, con đường đúng đắn duy nhất để giải quyết tranh chấp quốc tế này vẫn nằm ở việc thông qua đàm phán chính trị ngoại giao bình đẳng và thẳng thắn.",
          "explanation": "\"依我之见\" là cách mở đầu học thuật uyên bác đưa ra quan điểm phân tích thời sự sắc sảo."
        },
        {
          "chinese": "执法机关必须严格做到依法行政，绝不允许任何人在法定权限之外滥用权力。",
          "pinyin": "Zhífǎ jīguān bìxū yángé zuòdào yīfǎ xíngzhèng, jué bù yǔnxǔ rènhé rén zài fǎdìng quánxiàn zhīwài lànyòng quánlì.",
          "translation_vi": "Cơ quan hành pháp bắt buộc phải thực hiện nghiêm ngặt hành chính theo đúng pháp luật, tuyệt đối không cho phép bất kỳ ai lạm dụng quyền lực ngoài quyền hạn luật định.",
          "explanation": "\"依法行政\" dùng \"依\" xác lập nguyên tắc thượng tôn pháp luật trong quản lý nhà nước."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 72,
      "name": "Giới từ nhân duyên cơ hội & tùy biến \"因\" (Vì / Nhân cơ hội / Dựa theo sự khác biệt)",
      "pattern": "因 + Điều kiện địa phương/con người/thời thế (因地制宜 / 因人而异 / 因势利导)",
      "category": "Giới từ",
      "explanation_vi": "\"因\" (yīn) trong HSK 6 ngoài nghĩa nguyên nhân \"vì\" còn là giới từ chỉ phương thức tùy biến nương theo hoàn cảnh khách quan để hành động linh hoạt (dựa theo, tùy thuộc vào). Tạo thành các thành ngữ triết lý quản trị tuyệt đỉnh: \"因地制宜\" (tùy theo điều kiện địa phương mà đề ra giải pháp), \"因人而异\" (tùy từng người mà khác nhau), \"因势利导\" (nương theo thế mà dẫn dắt khéo léo).",
      "examples": [
        {
          "chinese": "乡村振兴战略必须坚持因地制宜，绝不能脱离当地自然资源禀赋而盲目机械照搬别处模式。",
          "pinyin": "Xiāngcūn zhènxīng zhànlüè bìxū jiānchí yīndìzhìyí, jué bù néng tuōlí dāngdì zìrán zīyuán bǐngfù ér mángmù jīxiè zhàobān biéchù móshì.",
          "translation_vi": "Chiến lược phục hưng nông thôn bắt buộc phải kiên trì căn cứ theo đặc thù từng địa phương, tuyệt đối không thể tách rời nguồn lực tài nguyên thiên nhiên sẵn có mà mù quáng sao chép máy móc mô hình nơi khác.",
          "explanation": "\"因地制宜\" là nguyên tắc quản trị chiến lược phát triển kinh tế phù hợp với thổ nhưỡng."
        },
        {
          "chinese": "经验丰富的名医给患者开药方总是因人而异，精准把握每个人的体质特异性。",
          "pinyin": "Jīngyàn fēngfù de míngyī gěi huànzhě kāi yàofāng zǒngshì yīnrén'éryì, jīngzhǔn bǎwò měi gè rén de tǐzhì tèyìxìng.",
          "translation_vi": "Bậc danh y giàu kinh nghiệm khi bốc đơn thuốc cho người bệnh luôn tùy theo thể trạng từng người mà biến hóa, nắm bắt chuẩn xác tính dị biệt thể chất của mỗi người.",
          "explanation": "\"因人而异\" phản ánh triết lý y học cổ truyền điều trị cá thể hóa."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 73,
      "name": "Giới từ mượn cớ nương nhờ văn ngôn \"藉 / 借\" (Mượn cơ hội / Nhờ cậy / Nhằm)",
      "pattern": "Chủ ngữ + 藉 / 借 + Cớ/Công cụ + 以 + Đạt được mục đích ngầm (藉以 / 藉此)",
      "category": "Giới từ",
      "explanation_vi": "\"藉\" (jiè) là dạng chữ cổ của \"借\", khi làm giới từ mang nghĩa \"mượn cớ, nương vào một cơ hội hay hình thức để đạt tới một mục đích cụ thể\". Cấu trúc kinh điển: \"藉以...\" (nhằm lấy đó để...), \"藉此机会\" (nhân cơ hội này).",
      "examples": [
        {
          "chinese": "不法分子企图藉虚构的投资项目非法集资，广大群众对此务必提高防范警惕。",
          "pinyin": "Bùfǎ fènzǐ qǐtú jiè xūgòu de tóuzī xiàngmù fēifǎ jízī, guǎngdà qúnzhòng duì cǐ wùbì tígāo fángfàn jǐngtì.",
          "translation_vi": "Những phần tử bất chính mưu toan mượn các dự án đầu tư hư cấu để huy động vốn phi pháp, đông đảo quần chúng nhân dân đối với điều này nhất thiết phải nâng cao tinh thần cảnh giác phòng ngừa.",
          "explanation": "\"藉虚构的投资项目\" dùng \"藉\" vạch trần vỏ bọc che đậy thủ đoạn lừa đảo tài chính."
        },
        {
          "chinese": "两国元首在峰会期间举行了非正式漫步茶叙，藉以增进私人互信与战略沟通。",
          "pinyin": "Liǎng guó yuánshǒu zài fēnghuì qījiān jǔxíng le fēizhèngshì mànbù cháxù, jièyǐ zēngjìn sīrén hùxìn yǔ zhànlüè gōutōng.",
          "translation_vi": "Nguyên thủ hai nước trong thời gian hội nghị thượng đỉnh đã tiến hành cuộc đi dạo uống trà không chính thức, nhằm lấy đó làm cầu nối tăng cường sự tin cậy cá nhân và giao lưu chiến lược.",
          "explanation": "\"藉以增进...\" thể hiện nghệ thuật ngoại giao mềm mại thắt chặt quan hệ quốc tế."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 74,
      "name": "Giới từ ngoại giao lễ nghi cùng đi \"偕同\" (Cùng đi với / Cùng với)",
      "pattern": "Lãnh đạo / VIP + 偕同 + Phu nhân / Quan chức cấp cao + Động từ (访华 / 抵达 / 出席)",
      "category": "Giới từ",
      "explanation_vi": "\"偕同\" (xiétóng) là giới từ ngoại giao nhà nước cực kỳ trang trọng tương đương với \"一起, 带着\" (cùng với, dẫn theo), chuyên dùng khi đưa tin về nguyên thủ quốc gia hoặc thủ tướng đi công du cùng phu nhân hoặc đoàn đại biểu cấp cao (như 偕同夫人 - cùng phu nhân tới thăm).",
      "examples": [
        {
          "chinese": "应国家主席邀请，法国总统偕同夫人于今日下午乘专机抵达北京开始进行国事访问。",
          "pinyin": "Yìng guójiā zhǔxí yāoqǐng, Fǎguó zǒngtǒng xiétóng fūrén yú jīnrì xiàwǔ chéng zhuānjī dǐdá Běijīng kāishǐ jìnxíng guóshì fǎngwèn.",
          "translation_vi": "Nhận lời mời của Chủ tịch nước, Tổng thống Pháp cùng phu nhân đã đáp chuyên cơ tới Bắc Kinh vào chiều nay bắt đầu chuyến thăm cấp nhà nước.",
          "explanation": "\"总统偕同夫人\" là nghi thức xưng hô ngoại giao nghi lễ nhà nước chuẩn mực trong bản tin đối ngoại."
        },
        {
          "chinese": "联合国秘书长偕同主要随行高级官员，亲赴灾区实地视察难民救援安置营地。",
          "pinyin": "Liánhéguó mìshūzhǎng xiétóng zhǔyào suíxíng gāojí guānyuán, qīnfù zāiqū shídì shìchá nànmín jiùyuán ānzhì yíngdì.",
          "translation_vi": "Tổng thư ký Liên Hợp Quốc cùng các quan chức cấp cao tháp tùng chủ chốt đã đích thân tới vùng thiên tai khảo sát thực tế khu trại cứu trợ tái định cư người tị nạn.",
          "explanation": "\"偕同...高级官员\" thể hiện sự nghiêm cẩn trong tường thuật chuyến công tác quốc tế."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 75,
      "name": "Liên từ tăng tiến quy mô vĩ mô \"乃至\" (Cho đến / Thậm chí đến mức)",
      "pattern": "Phạm vi hẹp / Nhỏ, 乃至 + Phạm vi rộng lớn / Toàn cầu (本省乃至全国 / 全国乃至全世界)",
      "category": "Liên từ",
      "explanation_vi": "\"乃至\" (nǎizhì) là liên từ tăng tiến chính luận trang trọng tương đương với \"甚至, 以及\", dùng để mở rộng quy mô từ phạm vi một khu vực, một quốc gia nâng cấp lên tới tầm vóc toàn cầu, hoặc từ một cá nhân nâng lên cả nhân loại (cho đến tận, thậm chí đến).",
      "examples": [
        {
          "chinese": "这不仅关乎本地区的发展繁荣，更直接影响到亚洲乃至整个世界的长治久安。",
          "pinyin": "Zhè bùjǐn guānhū běn dìqū de fāzhǎn fánróng, gèng zhíjiē yǐngxiǎng dào Yàzhōu nǎizhì zhěng gè shìjiè de chángzhìjiǔ'ān.",
          "translation_vi": "Điều này không chỉ liên quan tới sự phát triển phồn vinh của khu vực này, mà càng trực tiếp ảnh hưởng tới sự bình yên ổn định lâu dài của châu Á cho tới cả toàn thế giới.",
          "explanation": "\"亚洲乃至整个世界\" nâng tầm ảnh hưởng an ninh từ cấp độ châu lục lên quy mô toàn cầu."
        },
        {
          "chinese": "该项原始创新成果的问世，必将深刻重塑当前行业格局乃至整个人类社会的生产方式。",
          "pinyin": "Gāi xiàng yuánshǐ chuàngxīn chéngguǒ de wènshì, bìjiāng shēnkè zhòngsù dāngqián hángyè géjú nǎizhì zhěng gè rénlèi shèhuì de shēngchǎn fāngshì.",
          "translation_vi": "Sự ra đời của thành quả sáng tạo gốc này nhất định sẽ định hình lại sâu sắc cục diện ngành nghề hiện tại cho tới cả phương thức sản xuất của toàn thể xã hội loài người.",
          "explanation": "\"行业格局乃至人类社会\" làm nổi bật sức tác động mang tính cách mạng của công nghệ mới."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 76,
      "name": "Liên từ bổ sung lý do văn ngôn \"兼之\" (Lại thêm / Vả lại / Huống hồ)",
      "pattern": "Nguyên nhân 1, 兼之 + Nguyên nhân 2 (phức tạp hơn) + Dẫn đến kết quả",
      "category": "Liên từ",
      "explanation_vi": "\"兼之\" (jiānzhī) là liên từ văn ngôn cổ nhã tương đương với \"加之\" hoặc \"况且\", dùng ở đầu phân câu sau để bổ sung thêm một lý do khách quan phụ họa vào lý do trước, làm cho kết quả xảy ra càng thêm tất yếu và hợp lý (lại thêm vào đó, vả lại).",
      "examples": [
        {
          "chinese": "山高路险车辆难行，兼之暴雨连绵道路塌方，救援队伍只能徒步艰难挺进震中。",
          "pinyin": "Shāngāo lùxiǎn chēliàng nánxíng, jiānzhī bàoyǔ liánmián dàolù tāfāng, jiùyuán duìwù zhǐ néng túbù jiānnán tǐngjìn zhènzhōng.",
          "translation_vi": "Núi cao đường hiểm xe cộ khó đi, lại thêm mưa bão kéo dài sạt lở đường sá, đội cứu hộ chỉ đành đi bộ gian nan hành quân vào tâm chấn.",
          "explanation": "\"兼之暴雨连绵...\" bổ sung thêm điều kiện thời tiết khắc nghiệt giải thích sự khó khăn của công tác cứu hộ."
        },
        {
          "chinese": "他自幼聪慧过人勤奋好学，兼之名师悉心指点点拨，年纪轻轻便在画坛崭露头角。",
          "pinyin": "Tā zìyòu cōnghuì guòrén qínfèn hàoxué, jiānzhī míngshī xīxīn zhǐdiǎn diǎnbō, niánjì qīngqīng biàn zài huàtán zhǎnlùtóujiǎo.",
          "translation_vi": "Anh từ nhỏ đã thông minh hơn người lại chăm chỉ hiếu học, lại thêm được danh sư ân cần chỉ bảo khai sáng, tuổi đời còn trẻ đã sớm nổi danh trên thi họa đàn.",
          "explanation": "\"兼之名师悉心指点\" kết hợp thiên bẩm cá nhân với sự chỉ dạy của thầy giỏi làm nên thành tài."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 77,
      "name": "Cấu trúc nối tiếp hành động bài bản \"继之以...\" (Nối tiếp theo bằng...)",
      "pattern": "Giai đoạn 1 tiến hành, 继之以 + Biện pháp giai đoạn 2 hoàn thiện",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"继之以...\" (jì zhī yǐ...) là cấu trúc văn ngôn cao cấp biểu thị sau khi một hành động ban đầu kết thúc, chủ thể lập tức tiếp nối bằng một hành động khác có tính kế thừa hoặc nâng cao hơn để hoàn thiện chu trình (nối tiếp bằng cái gì, tiếp theo sau đó là biện pháp gì).",
      "examples": [
        {
          "chinese": "在考古发掘中，专家们先是进行精细的表层泥土剥离，继之以高科技的三维数字化建模扫描。",
          "pinyin": "Zài kǎogǔ fājué zhōng, zhuānjiāmen xiān shì jìnxíng jīngxì de biǎocéng nítǔ bōlí, jì zhī yǐ gāokējì de sānwéi shùzìhuà jiànmó sǎomiáo.",
          "translation_vi": "Trong công tác khai quật khảo cổ, các chuyên gia thoạt tiên tiến hành bóc tách tinh vi lớp đất mặt, nối tiếp theo đó bằng thao tác quét mô hình kỹ thuật số 3D công nghệ cao.",
          "explanation": "\"继之以三维建模\" kết hợp tuần tự nhịp nhàng giữa phương pháp khảo cổ truyền thống và công nghệ số."
        },
        {
          "chinese": "对于受灾群众的救助，首先当保障饮食饮水等温饱问题，继之以全面的灾后心理疏导与家园重建。",
          "pinyin": "Duìyú shòuzāi qúnzhòng de jiùzhù, shǒuxiān dāng bǎozhàng yǐnshí yǐnshuǐ děng wēnbǎo wèntí, jì zhī yǐ quánmiàn de zāihòu xīnlǐ shūdǎo yǔ jiāyuán chóngjiàn.",
          "translation_vi": "Đối với việc cứu trợ quần chúng vùng thiên tai, trước hết cần bảo đảm vấn đề no ấm ăn uống, tiếp nối sau đó bằng sự khai thông tâm lý sau thảm họa toàn diện và tái thiết quê hương.",
          "explanation": "\"继之以心理疏导...\" phân định lộ trình cứu trợ từ vật chất cấp bách đến chăm sóc tinh thần lâu dài."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 78,
      "name": "Cấu trúc nhượng bộ văn ngôn chặt chẽ \"虽...亦...\" (Tuy... nhưng cũng...)",
      "pattern": "虽 + Điều kiện khó khăn / Nhỏ bé, 亦 + Vẫn giữ nguyên giá trị / Quyết tâm",
      "category": "Liên từ",
      "explanation_vi": "\"虽...亦...\" (suī... yì...) là cặp từ nối nhượng bộ Hán ngữ cổ đại tương đương với \"虽然...但也...\", nhưng mang tính hàm súc, biền ngẫu ngắn gọn (tuy rằng... thì cũng vẫn cứ). Thường dùng trong các câu danh ngôn chí hướng, thơ văn tự sự.",
      "examples": [
        {
          "chinese": "前行道路虽千难万险，我们亦当一往无前、义无反顾。",
          "pinyin": "Qiánxíng dàolù suī qiānnánwànxiǎn, wǒmen yì dāng yìwǎngwúqián, yìwúfǎngù.",
          "translation_vi": "Con đường tiến bước phía trước tuy muôn vàn gian nan nguy hiểm, chúng ta cũng phải dũng cảm tiến lên, quyết không chùn bước.",
          "explanation": "\"虽千难万险，亦当一往无前\" thể hiện khí phách anh hùng không sợ hiểm nguy."
        },
        {
          "chinese": "个人的力量虽微不足道，但若汇聚到集体的大潮之中，亦能激荡起磅礴的伟力。",
          "pinyin": "Gèrén de lìliàng suī wēibùzúdào, dàn ruò huìjù dào jítǐ de dàcháo zhīzhōng, yì néng jīdàng qǐ pángbó de wěilì.",
          "translation_vi": "Sức mạnh của cá nhân tuy nhỏ bé không đáng kể, nhưng nếu hòa vào làn sóng chung của tập thể, cũng có thể tạo nên sức mạnh vĩ đại dạt dào.",
          "explanation": "\"虽微不足道...亦能...\" khẳng định giá trị to lớn của tinh thần đoàn kết tập thể."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 79,
      "name": "Cấu trúc giả thiết tột bực văn ngôn \"纵使...亦...\" (Dẫu cho... cũng vẫn...)",
      "pattern": "纵使 + Giả thiết khắc nghiệt nhất, (主语) 亦 + Kiên định lập trường / Bất biến",
      "category": "Liên từ",
      "explanation_vi": "\"纵使...亦...\" (zòngshǐ... yì...) tương đương với \"即使...也...\", nhưng mang phong vị cổ điển bi tráng. Đặt ra một giả thiết hiểm nguy hoặc bất lợi tột cùng để làm nổi bật ý chí sắt son không hề lay chuyển (cho dù là thế... thì vẫn cứ).",
      "examples": [
        {
          "chinese": "纵使历经沧海桑田的岁月变迁，中华民族对和平安宁的向往亦从未改变。",
          "pinyin": "Zòngshǐ lìjīng cānghǎisāngtián de suìyuè biànqiān, Zhōnghuá mínzú duì hépíng ānníng de xiàngwǎng yì cóngwèi gǎibiàn.",
          "translation_vi": "Dẫu cho trải qua những biến thiên năm tháng dâu bể khôn lường, khát vọng của dân tộc Trung Hoa đối với hòa bình an lành cũng chưa từng thay đổi.",
          "explanation": "\"纵使...亦从未改变\" khẳng định ước mơ hòa bình thiên niên kỷ bất biến của dân tộc."
        },
        {
          "chinese": "纵使面临千夫所指的巨大舆论压力，追求客观真理的勇士亦绝不后退半步。",
          "pinyin": "Zòngshǐ miànlín qiānfūsuǒzhǐ de jùdà yúlùn yālì, zhuīqiú kèguān zhēnlǐ de yǒngshì yì jué bú hòutuì bàn bù.",
          "translation_vi": "Dẫu cho đối mặt với áp lực dư luận khổng lồ vạn người chỉ trích, người dũng sĩ mưu cầu chân lý khách quan cũng tuyệt đối không lùi nửa bước.",
          "explanation": "\"纵使...亦绝不后退\" ca ngợi lòng quả cảm bảo vệ chân lý trước định kiến thời đại."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 80,
      "name": "Cấu trúc lựa chọn khí tiết văn ngôn \"宁...毋...\" (Thà rằng... chứ không...)",
      "pattern": "宁 + Chấp nhận mất mát vật chất, 毋 + Làm tổn hại đạo đức / Nguyên tắc",
      "category": "Liên từ",
      "explanation_vi": "\"宁...毋...\" (nìng... wú...) là dạng văn ngôn cổ kính của \"宁可...也不...\", thể hiện thái độ dứt khoát thà chấp nhận hy sinh quyền lợi chứ quyết không làm điều trái đạo lý (chữ 毋 nghĩa là chớ, không). Danh ngôn kinh điển: \"宁缺毋滥\" (thà thiếu chứ không lấy ẩu, thà ít mà chất lượng).",
      "examples": [
        {
          "chinese": "选拔高精尖专业人才必须秉持严格标准，宁缺毋滥，确保队伍的高质量。",
          "pinyin": "Xuǎnbá gāojīngjiān zhuānyè réncái bìxū bǐngchí yángé biāozhǔn, nìngquēwúlàn, quèbǎo duìwù de gāo zhìliàng.",
          "translation_vi": "Tuyển chọn nhân tài chuyên môn đỉnh cao tinh hoa bắt buộc phải giữ vững tiêu chuẩn nghiêm ngặt, thà thiếu còn hơn chọn ẩu, bảo đảm chất lượng cao của đội ngũ.",
          "explanation": "\"宁缺毋滥\" là tiêu chuẩn vàng rèn quân chọn tướng của các tập đoàn hàng đầu."
        },
        {
          "chinese": "学者撰写论文当求字字有据，宁慢毋错，严防浮躁虚假风气滋生。",
          "pinyin": "Xuézhě zhuànxiě lùnwén dāng qiú zìzìyǒujù, nìng màn wú cuò, yánfáng fúzào xūjiǎ fēngqì zīshēng.",
          "translation_vi": "Học giả khi viết luận văn phải cầu từng chữ đều có chứng cớ, thà chậm chứ không được sai, nghiêm phòng thói bốc đồng giả dối nảy sinh.",
          "explanation": "\"宁慢毋错\" răn dạy đức tính cẩn trọng tỉ mỉ từng chi tiết trong nghiên cứu học thuật."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 81,
      "name": "Cấu trúc tăng tiến phủ định văn phong học thuật \"非但...而且...\" (Chẳng những... mà còn...)",
      "pattern": "Chủ ngữ + 非但 + Không bị cản trở, 而且 / 反而 + Phát triển mạnh mẽ hơn",
      "category": "Liên từ",
      "explanation_vi": "\"非但...而且...\" (fēidàn... érqiě...) có chữ \"非但\" là dạng văn ngôn của \"不但/不仅\". Dùng trong các bài nghị luận chính trị xã hội để bác bỏ quan niệm nghi ngờ trước khi chỉ ra sự phát triển vượt bậc (chẳng những không... mà còn...).",
      "examples": [
        {
          "chinese": "外部的风雨施压非但没有压垮中国经济的筋骨，而且倒逼我们加快了科技自主创新的步伐。",
          "pinyin": "Wàibù de fēngyǔ shīyā fēidàn méiyǒu yākuǎ Zhōngguó jīngjì de jīngǔ, érqiě dàobī wǒmen jiākuài le kējì zìzhǔ chuàngxīn de bùfá.",
          "translation_vi": "Những áp lực gió mưa chèn ép từ bên ngoài chẳng những không đè bẹp được gân cốt của kinh tế Trung Quốc, mà còn ép chúng ta đẩy nhanh bước chân đổi mới sáng tạo tự chủ công nghệ.",
          "explanation": "\"非但没有...而且倒逼...\" khẳng định sức bền nội tại và khả năng biến thách thức thành động lực."
        },
        {
          "chinese": "严格的环保监管标准非但没有降低企业的利润，而且促使其提前完成了产业智能化绿色升级。",
          "pinyin": "Yángé de huánbǎo jiānguǎn biāozhǔn fēidàn méiyǒu jiàngdī qǐyè de lìrùn, érqiě cùshǐ qí tíqián wánchéng le chǎnyè zhìnénghuà lǜsè shēngjí.",
          "translation_vi": "Tiêu chuẩn giám sát bảo vệ môi trường nghiêm ngặt chẳng những không làm giảm lợi nhuận của doanh nghiệp, mà còn thúc đẩy doanh nghiệp hoàn thành sớm việc nâng cấp xanh thông minh hóa ngành nghề.",
          "explanation": "\"非但没有...而且促使...\" giải tỏa hiểu lầm cho rằng bảo vệ môi trường kìm hãm lợi nhuận."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 82,
      "name": "Cấu trúc kiểm chứng xác thực giả định \"果真...就...\" (Nếu quả thật... thì...)",
      "pattern": "果真 + Như dự đoán/thực tế, 主语 + 就 + Hành động tương ứng",
      "category": "Liên từ",
      "explanation_vi": "\"果真\" (guǒzhēn) vừa là liên từ giả định vừa là phó từ xác thực, tương đương với \"如果真的, 果然\" (nếu quả thực đúng như vậy). Dùng khi muốn đưa ra một hành động, quyết định dựa trên điều kiện tình huống được kiểm chứng là hoàn toàn có thật.",
      "examples": [
        {
          "chinese": "如果技术参数果真能达到实验室预设的标准，这项产品就完全具备了颠覆市场的潜力。",
          "pinyin": "Rúguǒ jìshù cānshù guǒzhēn néng dádào shíyànshì yùshè de biāozhǔn, zhè xiàng chǎnpǐn jiù wánquán jùbèi le diānfù shìchǎng de qiánlì.",
          "translation_vi": "Nếu thông số kỹ thuật quả thực có thể đạt tới tiêu chuẩn dự kiến trong phòng thí nghiệm, sản phẩm này liền hoàn toàn hội tụ tiềm năng làm đảo lộn thị trường.",
          "explanation": "\"果真能达到...就具备...\" đặt ra điều kiện kiểm định tính năng trước khi đánh giá tiềm năng thương mại."
        },
        {
          "chinese": "事情果真如你所说的那样顺利，我们明天就可以提前召开项目结项庆功会了。",
          "pinyin": "Shìqing guǒzhēn rú nǐ suǒ shuō de nàyàng shùnlì, wǒmen míngtiān jiù kěyǐ tíqián zhàokāi xiàngmù jiéxiàng qìnggōnghuì le.",
          "translation_vi": "Sự việc nếu quả thật suôn sẻ đúng như lời cậu nói, chúng ta ngày mai liền có thể mở tiệc mừng công tổng kết dự án sớm hơn dự kiến rồi.",
          "explanation": "\"果真如你所说...\" thể hiện sự kiểm chứng tin tức với niềm vui mừng chờ đón."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 83,
      "name": "Cấu trúc câu hỏi tu từ khuyên can \"既然...何必...\" (Đã... hà tất phải...)",
      "pattern": "既然 + Sự thật đã ngã ngũ rõ ràng, 又 / 也 + 何必 + Làm điều thừa thãi/tổn thương + 呢？",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"既然...何必...\" (jìrán... hébì...) phối hợp liên từ tiền đề \"既然\" và phó từ phản vấn \"何必\", tạo thành mẫu câu khuyên can thấu tình đạt lý: đã là một sự thật hiển nhiên hoặc đôi bên đều đã hiểu rõ nhau, vậy thì cần gì phải so đo, tranh cãi hay làm khổ nhau làm gì nữa.",
      "examples": [
        {
          "chinese": "既然双方都怀揣着真诚的合作愿望，又何必在枝节问题上寸土必争以致伤了和气呢？",
          "pinyin": "Jìrán shuāngfāng dōu huáichuǎizhe zhēnchéng de hézuò yuànwàng, yòu hébì zài zhījié wèntí shang cùntǔbìzhēng yǐzhì shāng le héqì ne?",
          "translation_vi": "Đã đôi bên đều ấp ủ nguyện vọng hợp tác chân thành, vậy cần gì phải tranh giành từng tấc trên những vấn đề râu ria đến nỗi làm tổn thương hòa khí chứ?",
          "explanation": "\"既然...又何必...呢？\" khuyên nhủ sự nhượng bộ đại cục tránh tổn hại quan hệ ngoại giao đối tác."
        },
        {
          "chinese": "往事既然已经随风而逝无法挽回，我们又何必整天沉溺在过去的自责与痛苦之中呢？",
          "pinyin": "Wǎngshì jìrán yǐjīng suífēng'érshì wúfǎ wǎnhuí, wǒmen yòu hébì zhěngtiān chénnì zài guòqù de zìzé yǔ tòngkǔ zhīzhōng ne?",
          "translation_vi": "Chuyện xưa đã theo gió thoảng trôi qua không thể cứu vãn, chúng ta cần gì phải suốt ngày chìm đắm trong nỗi tự trách và đau khổ của quá khứ cơ chứ?",
          "explanation": "\"又何必...呢\" là lời an ủi tâm lý động viên đối phương buông bỏ gánh nặng quá khứ hướng về tương lai."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 84,
      "name": "Cấu trúc tương sinh bổ trợ hoàn mỹ \"相辅相成\" (Hỗ trợ bổ sung cho nhau / Song hành phát triển)",
      "pattern": "A 与 / 和 B + 相辅相成, 缺一不可",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"相辅相成\" (xiāngfǔ xiāngchéng) kết hợp chữ 辅 (giúp đỡ, tương trợ) và 成 (hoàn thành, phát triển), biểu thị hai sự vật hoặc phương diện bổ sung, nương tựa và thúc đẩy lẫn nhau cùng hoàn thiện, thiếu một trong hai thì bên kia không thể đứng vững (hỗ trợ lẫn nhau, tương sinh tương hợp). Thường đi với cụm \"缺一不可\".",
      "examples": [
        {
          "chinese": "经济的高质量发展与生态环境的高水平保护是相辅相成的辩证统一关系。",
          "pinyin": "Jīngjì de gāozhìliàng fāzhǎn yǔ shēngtài huánjìng de gāoshuǐpíng bǎohù shì xiāngfǔxiāngchéng de biànzhèng tǒngyī guānxì.",
          "translation_vi": "Sự phát triển kinh tế chất lượng cao và việc bảo vệ môi trường sinh thái mức độ cao là mối quan hệ thống nhất biện chứng hỗ trợ bổ sung cho nhau.",
          "explanation": "\"相辅相成\" làm sáng tỏ triết lý không đánh đổi môi trường lấy kinh tế ngắn hạn."
        },
        {
          "chinese": "扎实的理论知识传授与生动的动手实践操作相辅相成，共同构成了现代高等工程教育的基石。",
          "pinyin": "Zhāshi de lǐlùn zhīshi chuánshòu yǔ shēngdòng de dòngshǒu shíjiàn cāozuò xiāngfǔxiāngchéng, gòngtóng gòuchéng le xiàndài gāoděng gōngchéng jiàoyù de jīshí.",
          "translation_vi": "Việc truyền thụ kiến thức lý luận vững chắc và thao tác thực hành sinh động hỗ trợ bổ sung cho nhau, cùng nhau cấu thành nền tảng của giáo dục kỹ thuật công trình đại học hiện đại.",
          "explanation": "\"相辅相成\" kết hợp nhuần nhuyễn giữa học lý thuyết và hành thực tế trong đào tạo kỹ sư."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 85,
      "name": "Cấu trúc tương phản đối nghịch đi ngược chiều \"背道而驰\" (Đi ngược lại hoàn toàn / Trái chiều)",
      "pattern": "Hành vi thực tế + 与 + Mục tiêu ban đầu / Xu thế thời đại + 背道而驰",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"背道而驰\" (bèidào'érchí) kết hợp chữ 背 (quay lưng), 道 (con đường), 驰 (chạy ngựa), miêu tả hành động thực tế chạy theo hướng hoàn toàn trái ngược với mục tiêu, phương châm hoặc quy luật tiến bộ chung của thời đại (đi ngược lại, trái chiều hoàn toàn). Mang sắc thái phê phán mạnh mẽ.",
      "examples": [
        {
          "chinese": "某些国家搞单边保护主义的逆流，与全球化深度发展的历史潮流显然是背道而驰的。",
          "pinyin": "Mǒuxiē guójiā gǎo dānbiān bǎohùzhǔyì de nìliú, yǔ quánqiúhuà shēndù fāzhǎn de lìshǐ cháoliú xiǎnrán shì bèidào'érchí de.",
          "translation_vi": "Dòng nước ngược chủ nghĩa bảo hộ đơn phương của một số quốc gia rõ ràng là đi ngược lại hoàn toàn với trào lưu lịch sử phát triển sâu sắc của toàn cầu hóa.",
          "explanation": "\"与...潮流背道而驰\" là lời bình luận quốc tế sắc sảo phê phán chính sách bảo hộ mậu dịch."
        },
        {
          "chinese": "如果口头上高喊减负口号，背地里却不断加码考试难度，这种做法完全与教育初衷背道而驰。",
          "pinyin": "Rúguǒ kǒutóushang gāohǎn jiǎnfù kǒuhào, bèidìlǐ què búduàn jiāmǎ kǎoshì nándù, zhè zhǒng zuòfǎ wánquán yǔ jiàoyù chūzhōng bèidào'érchí.",
          "translation_vi": "Nếu ngoài miệng hô hào khẩu hiệu giảm tải áp lực, nhưng sau lưng lại không ngừng tăng độ khó của các kỳ thi, cách làm này hoàn toàn đi ngược lại ý định ban đầu của giáo dục.",
          "explanation": "\"与教育初衷背道而驰\" vạch trần mâu thuẫn giữa khẩu hiệu và hành động thực tế trong nhà trường."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 86,
      "name": "Cấu trúc quy nạp đồng quy trăm sông về biển \"殊途同归\" (Khác đường cùng đích / Đều hướng về một mục tiêu)",
      "pattern": "Phương pháp A và Phương pháp B tuy khác nhau, nhưng + 殊途同归",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"殊途同归\" (shūtú tóngguī) kết hợp chữ 殊 (khác nhau), 途 (con đường), 同 (cùng), 归 (quy về một mối), mang nghĩa đi bằng những con đường, giải pháp, góc nhìn khác nhau nhưng cuối cùng đều dẫn tới cùng một kết quả hoặc chân lý tốt đẹp (khác đường cùng đích, trăm sông đổ về một biển).",
      "examples": [
        {
          "chinese": "世界各大古老文明虽然起源地理环境迥异，但在追求人类社会公平正义的道德准则上却是殊途同归。",
          "pinyin": "Shìjiè gè dà gǔlǎo wénmíng suīrán qǐyuán dìlǐ huánjìng jiǒngyì, dàn zài zhuīqiú rénlèi shèhuì gōngpíng zhèngyì de dàodé zhǔnzé shang què shì shūtútóngguī.",
          "translation_vi": "Các nền văn minh cổ đại lớn trên thế giới tuy môi trường địa lý khởi nguồn hoàn toàn khác biệt, nhưng trên chuẩn tắc đạo đức mưu cầu công bằng chính nghĩa cho xã hội loài người lại đều hướng về cùng một đích đến.",
          "explanation": "\"殊途同归\" làm nổi bật sự hội tụ giá trị nhân loại phổ quát xuyên qua các nền văn minh."
        },
        {
          "chinese": "中西医在治病救人的机理体系上虽然各有侧重，但其维护人类生命健康的崇高使命殊途同归。",
          "pinyin": "Zhōngxīyī zài zhìbìngjiùrén de jīlǐ tǐxì shang suīrán gè yǒu cèzhòng, dàn qí wéihù rénlèi shēngmìng jiànkāng de chónggāo shǐmìng shūtútóngguī.",
          "translation_vi": "Đông y và Tây y trên hệ thống cơ chế trị bệnh cứu người tuy mỗi bên có điểm nhấn riêng, nhưng sứ mệnh cao cả bảo vệ sức khỏe tính mạng nhân loại của đôi bên lại cùng hướng về một mục tiêu.",
          "explanation": "\"使命殊途同归\" khẳng định sự giao thoa hài hòa giữa y học cổ truyền và y học hiện đại."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 87,
      "name": "Cấu trúc quy luật phát triển bài bản khoa học \"循序渐进\" (Tuần tự tiến bước / Theo trình tự khoa học)",
      "pattern": "Học tập / Cải cách + 必须 + 循序渐进, 不可操之过急",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"循序渐进\" (xúnxù jiànjìn) kết hợp chữ 循 (tuân theo), 序 (trình tự), 渐 (dần dần), 进 (tiến lên), biểu thị việc học tập, rèn luyện hoặc cải cách thể chế bắt buộc phải tiến hành từng bước theo đúng quy luật phát triển từ dễ đến khó, từ thấp đến cao, không được nôn nóng đốt cháy giai đoạn (tuần tự từng bước). Thường đi với \"不可操之过急\".",
      "examples": [
        {
          "chinese": "掌握一门高难度外语必须遵循循序渐进的科学规律，绝不可能靠突击几天便一蹴而就。",
          "pinyin": "Zhǎowò yì mén gāonándù wàiyǔ bìxū zūnxún xúnxùjiànjìn de kēxué guīlǜ, jué bù kěnéng kào tūjī jǐ tiān biàn yícù'érjiù.",
          "translation_vi": "Nắm vững một ngoại ngữ có độ khó cao bắt buộc phải tuân theo quy luật khoa học tuần tự từng bước, tuyệt đối không thể dựa vào vài ngày học nhồi nhét cấp tốc mà một bước thành tài ngay được.",
          "explanation": "\"遵循循序渐进的规律\" răn dạy sự kiên nhẫn tích lũy trong việc tiếp thu ngôn ngữ."
        },
        {
          "chinese": "资本市场的全面对外开放当坚持稳中求进、循序渐进，有效防范跨境金融风险传染。",
          "pinyin": "Zīběn shìchǎng de quánmiàn duìwài kāifàng dāng jiānchí wěnzhōngqiújìn, xúnxùjiànjìn, yǒuxiào fángfàn kuàjìng jīnróng fēngxiǎn chuánrǎn.",
          "translation_vi": "Việc mở cửa toàn diện thị trường vốn với bên ngoài cần kiên trì phương châm tìm kiếm tiến bộ trong sự ổn định, tuần tự từng bước, phòng ngừa hiệu quả sự lây lan rủi ro tài chính xuyên biên giới.",
          "explanation": "\"循序渐进\" xác lập nguyên tắc thận trọng mở cửa hội nhập tài chính an toàn."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 88,
      "name": "Cấu trúc phán đoán lẽ tự nhiên đạo lý \"理所当然\" (Đương nhiên / Lẽ tất nhiên phải vậy)",
      "pattern": "Chủ ngữ + 享受权利 / 履行义务, 是理所当然的",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"理所当然\" (lǐ suǒ dāng rán) kết hợp chữ 理 (đạo lý), 当 (phải, nên), 然 (như vậy), mang nghĩa xét về mặt quy luật, đạo đức hoặc khế ước thì sự việc diễn ra như thế là hoàn toàn hợp tình hợp lý, hiển nhiên không cần phải bàn cãi (lẽ tất nhiên, đương nhiên là phải thế).",
      "examples": [
        {
          "chinese": "子女在成年后赡养照顾年迈体弱的父母，无论从伦理道德还是法律义务上讲都是理所当然的。",
          "pinyin": "Zǐnǚ zài chéngnián hòu shànyǎng zhàogù niánmài tǐruò de fùmǔ, wúlùn cóng lúnlǐ dàodé háishì fǎlǜ yìwù shang jiǎng dōu shì lǐsuǒdāngrán de.",
          "translation_vi": "Con cái sau khi trưởng thành phụng dưỡng chăm sóc cha mẹ già yếu, bất luận xét từ góc độ luân lý đạo đức hay nghĩa vụ pháp luật đều là điều hiển nhiên đương nhiên phải làm.",
          "explanation": "\"是理所当然的\" khẳng định đạo hiếu phụng dưỡng cha mẹ là thiên chức đạo đức bất biến."
        },
        {
          "chinese": "在知识经济时代，创新者通过合法的知识产权保护获取商业回报是理所当然的权利。",
          "pinyin": "Zài zhīshi jīngjì shídài, chuàngxīnzhě tōngguò héfǎ de zhīshi chǎnquán bǎohù huòqǔ shāngyè huíbào shì lǐsuǒdāngrán de quánlì.",
          "translation_vi": "Trong thời đại kinh tế tri thức, người đổi mới sáng tạo thông qua việc bảo hộ quyền sở hữu trí tuệ hợp pháp thu về lợi ích thương mại là quyền lợi đương nhiên chính đáng.",
          "explanation": "\"理所当然的权利\" bảo vệ quyền sở hữu trí tuệ của nhà phát minh sáng chế."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 89,
      "name": "Cấu trúc phê phán hành vi trái quy luật tự nhiên \"缘木求鱼\" (Leo cây tìm cá / Làm chuyện ngược đời)",
      "pattern": "Phương pháp sai lầm + 无异于 / 等同于 + 缘木求鱼",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"缘木求鱼\" (yuán mù qiú yú) là tích xưa Mạnh Tử: leo lên cây để bắt cá (chữ 缘 nghĩa là leo). Dùng để chỉ phương hướng hoặc phương pháp tiếp cận hoàn toàn sai lầm, trái với quy luật khách quan nên vĩnh viễn không bao giờ đạt được mục đích (leo cây tìm cá, làm chuyện hão huyền trái quy luật).",
      "examples": [
        {
          "chinese": "企图不经过刻苦踏实的日常积累而单凭考前突击押题取得优异成绩，无异于缘木求鱼。",
          "pinyin": "Qǐtú bù jīngguò kèkǔ tāshi de rìcháng jīlěi ér dān píng kǎoqián tūjī yātí qǔdé yōuyì chéngjì, wúyìyú yuánmùqiúyú.",
          "translation_vi": "Mưu toan không qua sự tích lũy chăm chỉ vững chắc thường ngày mà chỉ dựa vào việc học tủ đoán đề trước thi để đạt thành tích xuất sắc, chẳng khác nào leo cây tìm cá.",
          "explanation": "\"无异于缘木求鱼\" phê phán tâm lý ỷ lại vào học tủ may rủi trong thi cử."
        },
        {
          "chinese": "脱离群众的真实生活关切而关起门来搞所谓的文学艺术创作，终究只能是缘木求鱼。",
          "pinyin": "Tuōlí qúnzhòng de zhēnshí shēnghuó guānqiè ér guānqǐ mén lái gǎo suǒwèi de wénxué yìshù chuàngzuò, zhōngjiū zhǐ néng shì yuánmùqiúyú.",
          "translation_vi": "Tách rời sự quan tâm đời sống chân thực của quần chúng mà đóng kín cửa làm cái gọi là sáng tác văn học nghệ thuật, rốt cuộc cũng chỉ có thể là leo cây tìm cá mà thôi.",
          "explanation": "\"终究只能是缘木求鱼\" răn dạy nghệ sĩ không được thoát ly hiện thực đời sống nhân dân."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 90,
      "name": "Cấu trúc phòng ngừa rủi ro từ trong trứng nước \"防患于未然\" (Phòng ngừa hiểm họa từ lúc chưa phát sinh)",
      "pattern": "必须 + 建立健全机制 / 提高警惕, 防患于未然",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"防患于未然\" (fáng huàn yú wèi rán) kết hợp chữ 防 (phòng ngừa), 患 (tai họa), 于 (ở, tại), 未然 (khi chưa xảy ra), mang nghĩa áp dụng mọi biện pháp phòng ngừa nghiêm ngặt trước khi sự cố hay thảm họa bộc phát để triệt tiêu mọi mầm mống rủi ro (phòng ngừa hiểm họa từ lúc chưa phát sinh, lo toan chu đáo trước).",
      "examples": [
        {
          "chinese": "安全生产重在日常预防，企业必须建立全覆盖的排查监管机制，切实防患于未然。",
          "pinyin": "Ānquán shēngchǎn zhòng zài rìcháng yùfáng, qǐyè bìxū jiànlì quán fùgài de páichá jiānguǎn jīzhì, qièshí fánghuànyúwèirán.",
          "translation_vi": "An toàn sản xuất cốt ở việc phòng ngừa thường nhật, doanh nghiệp bắt buộc phải thiết lập cơ chế rà soát giám sát bao phủ toàn diện, thiết thực phòng ngừa hiểm họa từ lúc chưa phát sinh.",
          "explanation": "\"防患于未然\" là kim chỉ nam an toàn lao động trong quản lý sản xuất công nghiệp."
        },
        {
          "chinese": "在汛期到来之前提前加固水利大堤并疏浚河道，才能未雨绸缪、防患于未然。",
          "pinyin": "Zài xùnqī dàolái zhīqián tíqián jiāgù shuǐlì dàdī bìng shūjùn hédào, cái néng wèiyǔchóumóu, fánghuànyúwèirán.",
          "translation_vi": "Trước khi mùa mưa lũ kéo tới gia cố trước đê điều thủy lợi và nạo vét lòng sông thì mới có thể lo toan chu đáo trước lúc mưa giông, phòng ngừa hiểm họa từ lúc chưa bùng phát.",
          "explanation": "\"未雨绸缪、防患于未然\" là cặp thành ngữ đôi miêu tả nghệ thuật phòng chống thiên tai chủ động."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 91,
      "name": "Cấu trúc linh hoạt thích ứng tình huống \"随机应变\" (Tùy cơ ứng biến / Linh hoạt thích nghi)",
      "pattern": "面对瞬息万变的局势, 必须 + 善于 / 沉着 + 随机应变",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"随机应变\" (suí jī yìng biàn) kết hợp chữ 随 (nương theo), 机 (thời cơ, hoàn cảnh biến đổi), 应变 (ứng phó với sự biến), biểu thị năng lực tư duy nhạy bén, biết tùy theo sự thay đổi của tình thế khách quan mà linh hoạt điều chỉnh chiến thuật hành động thích hợp, không dập khuôn máy móc.",
      "examples": [
        {
          "chinese": "商场如战场，面对瞬息万变的市场供需形势，企业家必须具备沉着冷静、随机应变的高超指挥艺术。",
          "pinyin": "Shāngchǎng rú zhànchǎng, miànduì shùnxīwànbiàn de shìchǎng gōngxū xíngshì, qǐyèjiā bìxū jùbèi chénzhuó lěngjìng, suíjīyìngbiàn de gāochāo zhǐhuī yìshù.",
          "translation_vi": "Thương trường như chiến trường, đối mặt với tình thế cung cầu thị trường biến đổi trong từng hơi thở, nhà doanh nghiệp bắt buộc phải hội tụ nghệ thuật chỉ huy tài ba trầm tĩnh bình thản và tùy cơ ứng biến.",
          "explanation": "\"随机应变的高超指挥艺术\" tôn vinh sự linh hoạt nhạy bén của lãnh đạo doanh nghiệp."
        },
        {
          "chinese": "在野外突发恶劣极端天气时，领队要善于根据地形和风向随机应变，迅速带领队伍避险。",
          "pinyin": "Zài yěwài tūfā èliè jíduān tiānqì shí, lǐngduì yào shànyú gēnjù dìxíng hé fēngxiàng suíjīyìngbiàn, xùnsù dàilǐng duìwù bìxiǎn.",
          "translation_vi": "Khi nơi hoang dã đột phát thời tiết cực đoan khắc nghiệt, người trưởng đoàn phải giỏi căn cứ theo địa hình và hướng gió để tùy cơ ứng biến, nhanh chóng dẫn dắt đoàn lánh nạn.",
          "explanation": "\"善于...随机应变\" là kỹ năng sinh tồn then chốt bảo vệ an toàn tính mạng nơi thiên nhiên hoang dã."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 92,
      "name": "Cấu trúc tương khắc không thể dung hòa \"水火不容\" (Như nước với lửa / Tuyệt đối không đội trời chung)",
      "pattern": "A 与 B + 犹如水火不容 / 矛盾双方 + 势同水火",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"水火不容\" (shuǐ huǒ bù róng) dùng hình ảnh nước và lửa tương khắc triệt tiêu lẫn nhau để ẩn dụ cho hai lập trường, quan điểm hoặc hệ giá trị đối kháng gay gắt, mâu thuẫn đối kháng sâu sắc đến mức tuyệt đối không thể cùng tồn tại song hành hay dung hòa lẫn nhau.",
      "examples": [
        {
          "chinese": "坚守公平正义的职业良知与追逐不正当私利的贪腐念头，是水火不容、绝不相容的。",
          "pinyin": "Jiānshǒu gōngpíng zhèngyì de zhíyè liángzhī yǔ zhuīzhú búzhengdàng sīlì de tānfǔ niàntou, shì shuǐhuǒbùróng, jué bù xiāngróng de.",
          "translation_vi": "Lương tâm nghề nghiệp kiên định bảo vệ công bằng chính nghĩa và ý niệm tham nhũng theo đuổi tư lợi bất chính là điều như nước với lửa, tuyệt đối không thể dung hòa.",
          "explanation": "\"水火不容\" phân định ranh giới đạo đức liêm chính không thể nhân nhượng."
        },
        {
          "chinese": "真正的学术自由探索与学术不端抄袭剽窃行为，本质上是势同水火、不可调和的。",
          "pinyin": "Zhēnzhèng de xuéshù zìyóu tànsuǒ yǔ xuéshù bùduān chāoxí piāoqiè xíngwéi, běnzhì shang shì shìtóngshuǐhuǒ, bùkě tiáohé de.",
          "translation_vi": "Sự tự do tìm tòi học thuật chân chính và hành vi bất lương sao chép đạo văn học thuật về bản chất là như nước với lửa, không thể điều hòa.",
          "explanation": "\"势同水火\" khẳng định sự đối lập tận gốc rễ giữa nghiên cứu chân chính và hành vi đạo văn."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 93,
      "name": "Cấu trúc đồng cam vinh nhục máu thịt \"荣辱与共\" (Vinh nhục có nhau / Cùng chia sẻ vinh quang và cay đắng)",
      "pattern": "A 与 B + 风雨同舟, 荣辱与共",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"荣辱与共\" (róngrǔ yǔgòng) kết hợp chữ 荣 (vinh quang), 辱 (tủi nhục, hoạn nạn), 与共 (cùng chia sẻ), mang nghĩa cùng nhau gánh vác mọi thành bại, cùng chia sẻ ánh hào quang vinh dự lẫn lúc chịu đựng gian nan thử thách (vinh nhục có nhau, chung lưng đấu cật). Thường đi với \"风雨同舟\".",
      "examples": [
        {
          "chinese": "几十年来，各民主党派与中国共产党风雨同舟、荣辱与共，共同谱写了爱国统一战线的光辉篇章。",
          "pinyin": "Jǐshí nián lái, gè mínzhǔ dǎngpài yǔ Zhōngguó Gòngchǎndǎng fēngyǔtóngzhōu, róngrǔyǔgòng, gòngtóng pǔxiě le àiguó tǒngyī zhànxiàn de guānghuī piānzhāng.",
          "translation_vi": "Mấy chục năm qua, các đảng phái dân chủ cùng Đảng Cộng sản Trung Quốc kề vai sát cánh cùng chung một con thuyền, vinh nhục có nhau, cùng viết nên thiên trang vẻ vang của mặt trận thống nhất yêu nước.",
          "explanation": "\"风雨同舟、荣辱与共\" là phương châm hợp tác chính trị đa đảng đoàn kết thống nhất."
        },
        {
          "chinese": "全体员工同心协力把企业视作自己的大家庭，在市场风浪中与公司荣辱与共、患难相恤。",
          "pinyin": "Quántǐ yuángōng tóngxīnxiélì bǎ qǐyè shìzuò zìjǐ de dàjiātíng, zài shìchǎng fēnglàng zhōng yǔ gōngsī róngrǔyǔgòng, huànnàn xiāngxù.",
          "translation_vi": "Toàn thể nhân viên đồng tâm hiệp lực coi doanh nghiệp như đại gia đình của mình, trước sóng gió thương trường cùng công ty vinh nhục có nhau, hoạn nạn đùm bọc lẫn nhau.",
          "explanation": "\"与公司荣辱与共\" thể hiện sự gắn bó son sắt trung thành giữa người lao động và tập thể doanh nghiệp."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 94,
      "name": "Câu chữ 把 văn thư ngoại giao & tư pháp: \"把...付诸...\" (Đưa... vào thực tế / Đem ra...)",
      "pattern": "Chủ ngữ + 把 + Phương án / Kế hoạch + 付诸 + (实施 / 表决 / 实践 / 东流)",
      "category": "Câu chữ 把",
      "explanation_vi": "Trong các văn kiện chính trị, ngoại giao và nghị trường quốc tế, kết cấu \"把...付诸...\" (bǎ... fùzhū...) là mẫu câu trang trọng bậc nhất biểu thị hành động đem một ý niệm, hiệp định hoặc đề án chuyển hóa vào thực tiễn hành động (付诸实施 - đưa vào thực thi, 付诸表决 - đem ra biểu quyết thông qua). Chữ \"诸\" tương đương \"之于\".",
      "examples": [
        {
          "chinese": "大会主席团一致决定把关于气候治理的联合宣言草案正式付诸全体大会表决。",
          "pinyin": "Dàhuì zhǔxítuán yízhì juédìng bǎ guānyú qìhòu zhìlǐ de liánhé xuānyán cǎofàn zhèngshì fùzhū quántǐ dàhuì biǎojué.",
          "translation_vi": "Đoàn chủ tịch đại hội đã nhất trí quyết định đem bản dự thảo tuyên ngôn chung về quản trị khí hậu chính thức đưa ra toàn thể đại hội biểu quyết.",
          "explanation": "\"把...草案正式付诸表决\" là thuật ngữ thủ tục nghị trường chuẩn xác trong các kỳ họp liên hợp quốc."
        },
        {
          "chinese": "青年科研人员应当敢于把书本上的前沿理论大胆付诸创新工程的实践探索之中。",
          "pinyin": "Qīngnián kēyán rényuán yīngdāng gǎnyú bǎ shūběn shang de qiányán lǐlùn dàdǎn fùzhū chuàngxīn gōngchéng de shíjiàn tànsuǒ zhīzhōng.",
          "translation_vi": "Cán bộ nghiên cứu khoa học trẻ tuổi cần dũng cảm đem các lý luận tiên phong trên sách vở táo bạo áp dụng vào thực tiễn tìm tòi của công trình đổi mới.",
          "explanation": "\"把理论付诸实践\" khuyên nhủ sự kết hợp giữa tri thức hàn lâm và thực nghiệm công nghệ."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 95,
      "name": "Câu chữ 把 công bố chân tướng toàn cầu: \"把...公诸于世\" (Công bố trước bàn dân thiên hạ)",
      "pattern": "Chủ ngữ + 把 + Bằng chứng / Chân tướng lịch sử / Hồ sơ cơ mật + 公诸于世",
      "category": "Câu chữ 把",
      "explanation_vi": "\"把...公诸于世\" (bǎ... gōngzhūyúshì) kết hợp chữ 公 (công khai), 诸 (đến), 世 (thế gian), mang nghĩa đem một sự thật bị che giấu bấy lâu, một hồ sơ tội ác lịch sử hoặc một phát hiện khảo cổ chấn động công bố rộng rãi trước bàn dân thiên hạ và toàn thế giới.",
      "examples": [
        {
          "chinese": "国际调查委员会将历经三年秘密收集的战争罪证档案原件完整地公诸于世。",
          "pinyin": "Guójì diàochá wěiyuánhuì jiāng lìjīng sān nián mìmì shōují de zhànzhēng zuìzhèng dàng'àn yuánjiàn wánzhěng de gōngzhūyúshì.",
          "translation_vi": "Ủy ban điều tra quốc tế đã công bố trọn vẹn trước bàn dân thiên hạ bản gốc hồ sơ bằng chứng tội ác chiến tranh trải qua 3 năm bí mật thu thập.",
          "explanation": "\"把档案原件完整地公诸于世\" đặc tả thời khắc công lý phơi bày tội ác ra trước ánh sáng công luận."
        },
        {
          "chinese": "这位勇敢的科学家冒着巨大的职业风险，坚决把食品添加剂的真实毒理检测报告公诸于世。",
          "pinyin": "Zhè wèi yǒnggǎn de kēxuéjiā màozhe jùdà de zhíyè fēngxiǎn, jiānjué bǎ shípǐn tiānjiājì de zhēnshí dúlǐ jiǎncè bàogào gōngzhūyúshì.",
          "translation_vi": "Nhà khoa học dũng cảm này đã bất chấp rủi ro nghề nghiệp khổng lồ, kiên quyết công bố bản báo cáo kiểm nghiệm độc lý chân thực của chất phụ gia thực phẩm ra trước công chúng.",
          "explanation": "\"把...报告公诸于世\" ca ngợi đạo đức dũng cảm vì sức khỏe cộng đồng của người làm khoa học."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 96,
      "name": "Câu chữ 把 văn học cổ điển chỉ sự hủy diệt: \"把...付之一炬\" (Thiêu rụi trong ngọn lửa)",
      "pattern": "Chủ ngữ + 把 + Tác phẩm tâm huyết / Thư tịch / Thành trì + 付之一炬",
      "category": "Câu chữ 把",
      "explanation_vi": "\"把...付之一炬\" (bǎ... fùzhīyījù) kết hợp chữ 付 (giao phó), 之 (nó), 一炬 (một ngọn đuốc, mồi lửa), mang nghĩa đem toàn bộ tác phẩm nghệ thuật, sách quý hoặc cơ nghiệp đốt sạch sành sanh trong một mồi lửa lớn (thiêu rụi hoàn toàn). Mang sắc thái bi tráng, tiếc nuối tột cùng.",
      "examples": [
        {
          "chinese": "侵略者洗劫了这座宏伟的古代皇家园林，并在撤退前毫无人性地把它付之一炬。",
          "pinyin": "Qīnlüèzhě xǐjié le zhè zuò hóngwěi de gǔdài huángjiā yuánlín, bìng zài chètuì qián háowú rénxìng de bǎ tā fùzhīyījù.",
          "translation_vi": "Những kẻ xâm lược đã cướp phá khu hoa viên hoàng gia cổ đại hùng vĩ này, và trước khi rút quân đã mất hết nhân tính thiêu rụi nó trong một biển lửa.",
          "explanation": "\"把它付之一炬\" lên án tội ác man rợ tàn phá di sản văn hóa nhân loại của quân xâm lăng."
        },
        {
          "chinese": "这位追求完美的孤傲作家在临终前，亲手把未完成的几部手稿残卷付之一炬。",
          "pinyin": "Zhè wèi zhuīqiú wánměi de gū'ào zuòjiā zài línzhōng qián, qīnshǒu bǎ wèiwánchéng de jǐ bù shǒugǎo cánjuàn fùzhīyījù.",
          "translation_vi": "Người nhà văn cô độc ngạo nghễ mưu cầu sự hoàn mỹ này trước lúc lâm chung đã tự tay thiêu rụi mấy tập bản thảo dang dở trong đống lửa.",
          "explanation": "\"把手稿付之一炬\" khắc họa cá tính nghệ thuật cực đoan chỉ giữ lại kiệt tác hoàn hảo của tác giả."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 97,
      "name": "Câu chữ 把 chỉ sự gạt bỏ lãng quên: \"把...抛诸脑后\" (Vứt bỏ ra sau đầu / Lãng quên hoàn toàn)",
      "pattern": "Chủ ngữ + 把 + Lời dặn / An toàn / Phiền muộn + 抛诸脑后",
      "category": "Câu chữ 把",
      "explanation_vi": "\"把...抛诸脑后\" (bǎ... pāozhū nǎohòu) kết hợp chữ 抛 (quẳng, ném), 诸 (đến), 脑后 (sau gáy), mang nghĩa vứt bỏ hoàn toàn, không thèm đoái hoài nhớ tới những lời răn dạy, sự an toàn hoặc những muộn phiền (quẳng ra sau đầu, lãng quên sạch sẽ).",
      "examples": [
        {
          "chinese": "个别司机为了抢那一两秒的绿灯，竟然把最基本的交通安全规则完全抛诸脑后。",
          "pinyin": "Gèbié sījī wèile qiǎng nà yì liǎng miǎo de lǜdēng, jìngrán bǎ zuì jīběn de jiāotōng ānquán guīzé wánquán pāozhū nǎohòu.",
          "translation_vi": "Một số ít tài xế vì muốn tranh thủ một hai giây đèn xanh mà lại vứt bỏ hoàn toàn quy tắc an toàn giao thông cơ bản nhất ra sau đầu.",
          "explanation": "\"把安全规则抛诸脑后\" phê phán thái độ coi thường tính mạng khi tham gia giao thông."
        },
        {
          "chinese": "一踏入风景秀丽的宁静大自然，他便把平日里繁重工作带来的种种焦虑抛诸脑后。",
          "pinyin": "Yí tàrù fēngjǐng xiùlì de níngjìng dàzìrán, tā biàn bǎ píngrì lǐ fánzhòng gōngzuò dàilái de zhǒngzhǒng jiāolǜ pāozhū nǎohòu.",
          "translation_vi": "Vừa bước chân vào thiên nhiên tĩnh lặng phong cảnh tươi đẹp, anh ấy liền quẳng sạch sẽ mọi nỗi âu lo do công việc bề bộn ngày thường đem lại ra sau đầu.",
          "explanation": "\"把种种焦虑抛诸脑后\" miêu tả cảm giác thư thái trút bỏ gánh nặng tinh thần nơi thiên nhiên khoáng đạt."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 98,
      "name": "Câu chữ 把 nâng tầm tư duy chiến lược: \"把...上升为 / 提升为...\"",
      "pattern": "Chủ ngữ + 把 + Phương châm/Đề án + 上升为 / 提升为 + 国家战略 / 全球共识",
      "category": "Câu chữ 把",
      "explanation_vi": "\"把...上升为...\" (bǎ... shàngshēngwéi...) là mẫu câu hoạch định chính sách cấp cao, biểu thị việc nâng tầm một vấn đề, một ý tưởng từ cấp độ cục bộ, kỹ thuật lên tầm vóc chiến lược quốc gia, luật pháp hiến định hoặc sứ mệnh lịch sử.",
      "examples": [
        {
          "chinese": "国家正式把保护知识产权与鼓励原始创新上升为关乎经济命脉的核心国家战略。",
          "pinyin": "Guójiā zhèngshì bǎ bǎohù zhīshi chǎnquán yǔ gǔlì yuánshǐ chuàngxīn shàngshēng wéi guānhū jīngjì mìngmài de héxīn guójiā zhànlüè.",
          "translation_vi": "Nhà nước đã chính thức nâng việc bảo hộ quyền sở hữu trí tuệ và khuyến khích sáng tạo gốc lên thành chiến lược quốc gia cốt lõi liên quan tới sinh mệnh kinh tế.",
          "explanation": "\"把...上升为国家战略\" khẳng định tầm vóc chính trị cao nhất của chính sách sở hữu trí tuệ."
        },
        {
          "chinese": "企业董事会决定把数字化转型从单一的业务手段提升为驱动未来发展的根本动力。",
          "pinyin": "Qǐyè dǒngshìhuì juédìng bǎ shùzìhuà zhuǎnxíng cóng dānyī de yèwù shǒuduàn tíshēng wéi qūdòng wèilái fāzhǎn de gēnběn dònglì.",
          "translation_vi": "Hội đồng quản trị doanh nghiệp quyết định nâng việc chuyển đổi số từ thủ đoạn nghiệp vụ đơn thuần lên thành động lực căn bản dẫn dắt sự phát triển tương lai.",
          "explanation": "\"把...提升为根本动力\" định hình lại vai trò của công nghệ thông tin trong quản trị doanh nghiệp."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 99,
      "name": "Câu chữ 把 hòa nhập đa chiều hoàn mỹ: \"把...融为一体\"",
      "pattern": "Chủ ngữ + 把 + Yếu tố A + 与 / 和 + Yếu tố B + 完美地融为一体",
      "category": "Câu chữ 把",
      "explanation_vi": "\"把...融为一体\" (bǎ... róngwéi yītǐ) biểu thị hành động khéo léo kết hợp hai hay nhiều yếu tố tưởng chừng khác biệt (như truyền thống và hiện đại, nghệ thuật và kỹ thuật) hòa quyện chặt chẽ thành một chỉnh thể hữu cơ hoàn mỹ, không tì vết.",
      "examples": [
        {
          "chinese": "这栋地标性建筑巧妙地把古典东方美学意境与现代前沿环保科技完美地融为了一体。",
          "pinyin": "Zhè dòng dìbiāoxìng jiànzhù qiǎomiào de bǎ gǔdiǎn dōngfāng měixué yìjìng yǔ xiàndài qiányán huánbǎo kējì wánměi de róngwéi le yītǐ.",
          "translation_vi": "Tòa kiến trúc biểu tượng này đã khéo léo hòa quyện ý cảnh mỹ học phương Đông cổ điển với công nghệ bảo vệ môi trường tiên phong hiện đại thành một thể thống nhất hoàn mỹ.",
          "explanation": "\"把...融为了一体\" ca ngợi bàn tay tài hoa của kiến trúc sư kết hợp mỹ cảm truyền thống với công nghệ xanh."
        },
        {
          "chinese": "优秀的演员能够把自身的情感体验与角色的内心波澜深度交织，把生活与表演融为一体。",
          "pinyin": "Yōuxiù de yǎnyuán nénggòu bǎ zìshēn de qínggǎn tǐyàn yǔ juésè de nèixīn bōlán shēndù jiāozhī, bǎ shēnghuó yǔ biǎoyǎn róngwéi yītǐ.",
          "translation_vi": "Người diễn viên xuất sắc có thể đan xen sâu sắc trải nghiệm cảm xúc của bản thân với những làn sóng ngầm nội tâm của nhân vật, hòa quyện đời sống và diễn xuất làm một.",
          "explanation": "\"把生活与表演融为一体\" đạt tới cảnh giới nhập vai thần sầu trong nghệ thuật sân khấu điện ảnh."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 100,
      "name": "Câu bị động văn ngôn cổ điển với giới từ kép: \"见...于...\" (Bị / Được... bởi)",
      "pattern": "Chủ ngữ + 见 + Động từ + 于 + Tác nhân (见笑于 / 见疑于 / 见容于 / 见信于)",
      "category": "Câu bị động",
      "explanation_vi": "Kết cấu \"见 + Động từ + 于 + Tác nhân\" là công thức câu bị động ngữ pháp hóa cổ xưa nhất trong Hán văn. Chữ \"见\" đứng trước động từ đóng vai trò trợ từ tiêu chí bị động, chữ \"于\" đứng sau dẫn ra tác nhân gây ra hành động (như 见信于人 - được người đời tin tưởng, 见疑于众 - bị mọi người nghi ngờ).",
      "examples": [
        {
          "chinese": "为人处事唯有恪守诚信底线，方能在社会上立足长远，真正见信于广大公众。",
          "pinyin": "Wéirénchǔshì wéiyǒu kèshǒu chéngxìn dǐxiàn, fāngnéng zài shèhuì shang lìzú chángyuǎn, zhēnzhèng jiànxìn yú guǎngdà gōngzhòng.",
          "translation_vi": "Đối nhân xử thế duy chỉ có giữ trọn lằn ranh chữ tín thì mới có thể đứng vững lâu dài trong xã hội, thực sự nhận được sự tin cậy từ đông đảo công chúng.",
          "explanation": "\"见信于广大公众\" nghĩa là \"được đông đảo công chúng tin yêu\", dùng thể bị động văn ngôn cổ tao nhã."
        },
        {
          "chinese": "这篇立论荒谬且缺乏基本史实根据的历史小说，一经出版便见疑于学术界同仁。",
          "pinyin": "Zhè piān lìlùn huāngmiù qiě quēfá jīběn shǐshí gēnjù de lìshǐ xiǎoshuō, yījīng chūbǎn biàn jiànyí yú xuéshùjiè tóngrén.",
          "translation_vi": "Cuốn tiểu thuyết lịch sử có luận điểm nực cười lại thiếu thốn căn cứ sự thật lịch sử cơ bản này, vừa mới xuất bản đã lập tức bị các đồng nghiệp trong giới học thuật hoài nghi chê trách.",
          "explanation": "\"见疑于学术界同仁\" nghĩa là \"bị giới học thuật hoài nghi chất vấn\"."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 101,
      "name": "Câu bị động văn ngôn ràng buộc kiểm soát: \"受...于...\" (Chịu sự... bởi / Bị khống chế)",
      "pattern": "Chủ ngữ + 受 + Động từ + 于 + Đối tượng kìm kẹp (受制于 / 受惑于 / 受益于 / 受损于)",
      "category": "Câu bị động",
      "explanation_vi": "\"受 + Động từ + 于\" biểu thị chủ thể bị ràng buộc, kiểm soát, hoặc thụ hưởng lợi ích/thiệt hại từ một nguồn bên ngoài (như 受制于人 - bị người khác kìm kẹp, 受惑于表象 - bị mê hoặc bởi hiện tượng bề ngoài, 受益于政策 - hưởng lợi từ chính sách).",
      "examples": [
        {
          "chinese": "我们在做战略决策时决不能受惑于暂时的表面泡沫繁荣，必须看清深层的经济基本面。",
          "pinyin": "Wǒmen zài zuò zhànlüè juécè shí jué bù néng shòuhuò yú zànshí de biǎomiàn pàomò fánróng, bìxū kànqīng shēncéng de jīngjì jīběnmiàn.",
          "translation_vi": "Chúng ta khi đưa ra quyết sách chiến lược quyết không thể bị mê hoặc bởi sự phồn vinh bong bóng bề ngoài tạm thời, bắt buộc phải nhìn rõ các yếu tố căn bản tầng sâu của nền kinh tế.",
          "explanation": "\"决不能受惑于表面的繁荣\" cảnh báo lãnh đạo không để các số liệu ảo đánh lừa tư duy."
        },
        {
          "chinese": "广大普通老百姓深切受益于国家持续推进的医疗体制改革，看病报销门槛大幅降低。",
          "pinyin": "Guǎngdà pǔtōng lǎobǎixìng shēnqiè shòuyì yú guójiā chíxù tuījìn de yīliáo tǐzhì gǎigé, kànbìng bàoxiāo ménkǎn dàfú jiàngdī.",
          "translation_vi": "Đông đảo người dân bình thường hưởng lợi sâu sắc từ công cuộc cải cách thể chế y tế mà nhà nước liên tục thúc đẩy, rào cản thanh toán viện phí đã giảm mạnh.",
          "explanation": "\"受益于...医疗体制改革\" dùng thể bị động tích cực thể hiện quyền lợi người dân được hưởng từ chính sách an sinh."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 102,
      "name": "Câu bị động văn ngôn \"为...所...\" chuyên sâu kết hợp hư từ kép",
      "pattern": "Chủ ngữ + 为 + Hoàn cảnh/Ảo tưởng + 所 + Động từ (困 / 左右 / 蒙蔽 / 折服 / 铭记)",
      "category": "Câu bị động",
      "explanation_vi": "Ở HSK 6, cấu trúc bị động \"为...所...\" phát triển lên tầng cao hàm súc triết luận, thường đi kèm các động từ trừu tượng đơn âm tiết hoặc song âm tiết: 为贫困所困 (bị sự nghèo khó bủa vây), 不为物欲所左右 (không bị dục vọng vật chất thao túng), 为历史所铭记 (được lịch sử khắc ghi).",
      "examples": [
        {
          "chinese": "真正有远大抱负的思想者，绝不会为眼前的名利诱惑所左右。",
          "pinyin": "Zhēnzhèng yǒu yuǎndà bàofù de sīxiǎngzhě, jué bú huì wéi yǎnqián de mínglì yòuhuò suǒ zuǒyòu.",
          "translation_vi": "Người có tư tưởng hoài bão lớn lao thực sự tuyệt đối sẽ không bị những cám dỗ danh lợi trước mắt thao túng chi phối.",
          "explanation": "\"不为名利诱惑所左右\" khẳng định bản lĩnh tự chủ độc lập kiên định của bậc thức giả."
        },
        {
          "chinese": "无数先烈为了国家独立和民族尊严抛头颅洒热血，他们的丰功伟绩必将永远为历史所铭记。",
          "pinyin": "Wúshù xiānliè wèile guójiā dúlì hé mínzú zūnyán pāotóulú sǎrèxiè, tāmen de fēnggōngwěijì bìjiāng yǒngyuǎn wéi lìshǐ suǒ míngjì.",
          "translation_vi": "Vô số các bậc tiền liệt vì độc lập quốc gia và phẩm giá dân tộc đã dâng hiến đầu rơi máu chảy, công lao vĩ đại của họ nhất định sẽ mãi mãi được lịch sử khắc ghi.",
          "explanation": "\"为历史所铭记\" là lời ngợi ca trang nghiêm thiêng liêng nhất dành cho công đức liệt sĩ."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 103,
      "name": "Câu phản vấn tu từ văn ngôn cổ phong: \"安能...？\" (Sao có thể...?)",
      "pattern": "安能 + Hành động hèn nhát / Trái đạo đức + 乎 / 哉 / 呢？",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"安能...？\" (ān néng...?) là mẫu câu hỏi tu từ văn ngôn cổ đại (chữ 安 nghĩa là sao, lẽ nào, làm sao; 安能 = sao có thể). Bắt nguồn từ câu thơ Lý Bạch nổi tiếng \"安能摧眉折腰事权贵，使我不得开心颜\" (Sao có thể cúi mày khom lưng thờ quyền quý, khiến ta chẳng được nở nụ cười). Dùng để bộc lộ khí phách thanh cao kiên quyết cự tuyệt sự ô uế.",
      "examples": [
        {
          "chinese": "知识分子当以兼济天下为己任，面对民生疾苦，安能闭目塞听、袖手旁观？",
          "pinyin": "Zhīshi fènzǐ dāng yǐ jiānjì tiānxià wéi jǐrèn, miànduì mínshēng jíkǔ, ān néng bìmùsètīng, xiùshǒupángguān?",
          "translation_vi": "Người trí thức phải lấy việc giúp đỡ thiên hạ làm trách nhiệm của mình, đối mặt với nỗi cơ cực lầm than của muôn dân, sao có thể nhắm mắt bịt tai, khoanh tay đứng nhìn?",
          "explanation": "\"安能闭目塞听...\" dùng câu phản vấn văn ngôn cổ đỉnh cao chất vấn lương tâm người có học."
        },
        {
          "chinese": "既立志献身于追求科学客观真理之崇高事业，安能因暂时的挫折嘲弄而中途退缩？",
          "pinyin": "Jì lìzhì xiànshēn yú zhuīqiú kēxué kèguān zhēnlǐ zhī chónggāo shìyè, ān néng yīn zànshí de cuòzhé cháonòng ér zhōngtú tuìsuō?",
          "translation_vi": "Đã lập chí hiến thân cho sự nghiệp cao cả mưu cầu chân lý khách quan khoa học, sao có thể vì những thất bại và lời chế giễu tạm thời mà thoái lui nửa chừng?",
          "explanation": "\"安能...中途退缩\" khẳng định ý chí kiên định theo đuổi con đường khoa học bất chấp gièm pha."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 104,
      "name": "Câu phản vấn tu từ tra hỏi nhân tâm: \"孰能...？\" (Ai có thể...?)",
      "pattern": "面对... / 在...面前, 孰能 + Không xúc động / Đứng ngoài cuộc + 呢？",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"孰能...？\" (shú néng...?) kết hợp chữ \"孰\" (ai, cái nào) và \"能\" (có thể), mang nghĩa \"ai có thể làm được việc đó / ai có thể thờ ơ được\". Dùng để khẳng định một phản ứng nhân tính là phổ quát toàn nhân loại (ai có thể dửng dưng không động lòng).",
      "examples": [
        {
          "chinese": "目睹同胞在灾难中守望相助、共克时艰的动人场景，身居华夏热土之人孰能不为之动容？",
          "pinyin": "Mùdǔ tóngbāo zài zāinàn zhōng shǒuwàngxiāngzhù, gòngkèshíjiān de dòngrén chǎngjǐng, shēnjū Huáxià rètǔ zhī rén shú néng bù wéizhī dòngróng?",
          "translation_vi": "Tận mắt chứng kiến cảnh tượng xúc động đồng bào trong cơn hoạn nạn đùm bọc che chở lẫn nhau, cùng nhau vượt qua thời khắc gian nan, người sống trên mảnh đất Hoa Hạ này ai có thể không xúc động vì điều đó?",
          "explanation": "\"孰能不为之动容\" dùng phản vấn khẳng định toàn thể nhân dân đều trào dâng niềm xúc động thiêng liêng."
        },
        {
          "chinese": "面对浩瀚无垠的宇宙星空与深邃永恒的时间长河，凡胎肉身之人类孰能不心怀敬畏？",
          "pinyin": "Miànduì hàohànwúyín de yǔzhòu xīngkōng yǔ shēnsuì yǒnghéng de shíjiān chánghé, fántāiròushēn zhī rénlèi shú néng bù xīnhuái jìngwèi?",
          "translation_vi": "Đối mặt với bầu trời sao vũ trụ bao la vô tận và dòng sông dài thời gian vĩnh hằng thâm sâu, con người phàm trần này ai có thể không ôm giữ lòng kính sợ trong tim?",
          "explanation": "\"孰能不心怀敬畏\" triết lý hóa sự nhỏ bé và lòng kính ngưỡng của nhân loại trước tạo hóa vĩ đại."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 105,
      "name": "Bổ ngữ mức độ hư hóa văn hóa nhã nhặn \"不亦乐乎\" (Vui xiết bao / Bận túi bụi)",
      "pattern": "Động từ/Tính từ + 得 + 不亦乐乎 (忙 / 累 / 吵 / 玩 + 得不亦乐乎)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"不亦乐乎\" (búyìlèhū) có xuất xứ từ Luận Ngữ: \"有朋自远方来，不亦乐乎\" (có bạn từ phương xa tới, chẳng cũng vui sao). Trong ngữ pháp hiện đại, nó được hư hóa làm bổ ngữ mức độ sau \"得\" mang hai nghĩa: 1) Nghĩa gốc: vui mừng khôn xiết; 2) Nghĩa phái sinh phổ biến: miêu tả trạng thái bận rộn túi bụi hoặc cãi vã náo nhiệt đến mức tột cùng (như 忙得不亦乐乎 - bận túi bụi tối mắt).",
      "examples": [
        {
          "chinese": "除夕之夜，全家人围在热气腾腾的厨房里包饺子贴春联，忙得不亦乐乎。",
          "pinyin": "Chúxī zhī yè, quán jiā rén wéi zài rèqìténgténg de chúfáng lǐ bāo jiǎozi tiē chūnlián, máng de búyìlèhū.",
          "translation_vi": "Đêm trừ tịch, cả gia đình quây quần trong căn bếp ấm cúng nghi ngút khói gói sủi cảo dán câu đối xuân, bận rộn túi bụi mà ngập tràn niềm vui.",
          "explanation": "\"忙得不亦乐乎\" miêu tả không khí tất bật đón giao thừa ấm áp hạnh phúc gia đình."
        },
        {
          "chinese": "周末的游乐场里到处洋溢着欢声笑语，孩子们在沙滩城堡边嬉戏打闹，玩得不亦乐乎。",
          "pinyin": "Zhōumò de yóulèchǎng lǐ dàochù yángyìzhe huānshēngxiàoyǔ, háizimen zài shātān chéngbǎo biān xīxì dǎjiào, wán de búyìlèhū.",
          "translation_vi": "Khu vui chơi cuối tuần khắp nơi rộn rã tiếng cười nói, lũ trẻ con nô đùa rượt đuổi bên lâu đài cát, chơi đùa vui vẻ khôn xiết.",
          "explanation": "\"玩得不亦乐乎\" đặc tả niềm vui chơi đùa thỏa thích quên hết âu lo của con trẻ."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 106,
      "name": "Bổ ngữ kết quả nghĩa triệt để cùng cực \"殆尽\" (Kiệt quệ / Không còn sót lại chút gì)",
      "pattern": "Động từ tiêu hao/hủy hoại + 殆尽 (消耗 / 丧失 / 破坏 / 掠夺 + 殆尽)",
      "category": "Bổ ngữ",
      "explanation_vi": "\"殆尽\" (dàijìn) kết hợp chữ 殆 (gần như, hầu như) và 尽 (hết, cạn kiệt), làm bổ ngữ kết quả văn ngôn biểu thị sự vật, tài nguyên hoặc phẩm chất bị tiêu hao, cướp bóc hoặc phá hủy gần như hoàn toàn đến tận giọt cuối cùng, không còn lại một chút nào (cạn kiệt không còn gì). Thường dùng cảnh báo tài nguyên, đạo đức.",
      "examples": [
        {
          "chinese": "掠夺式的无序开采致使该地区的地下矿产与水资源在短短几十年间消耗殆尽。",
          "pinyin": "Lüèduóshì de wúxù kāicǎi zhìshǐ gāi dìqū de dìxià kuàngchǎn yǔ shuǐ zīyuán zài duǎnduǎn jǐshí nián jiān xiāohào dàijìn.",
          "translation_vi": "Việc khai thác bừa bãi mang tính vơ vét đã khiến tài nguyên khoáng sản và nước ngầm của khu vực này chỉ trong mấy chục năm ngắn ngủi đã bị tiêu hao cạn kiệt không còn lại gì.",
          "explanation": "\"消耗殆尽\" gióng lên hồi chuông cảnh tỉnh về thảm họa kiệt quệ tài nguyên thiên nhiên."
        },
        {
          "chinese": "企业若为了短期暴利而肆意践踏社会道德良知，其积累多年的品牌声誉必将丧失殆尽。",
          "pinyin": "Qǐyè ruò wèile duǎnqī bàolì ér sìyì jiàntà shèhuì dàodé liángzhī, qí jīlěi duō nián de pǐnpái shēngyù bìjiāng sàngshī dàijìn.",
          "translation_vi": "Doanh nghiệp nếu vì lợi nhuận kếch xù ngắn hạn mà ngang nhiên chà đạp lên lương tâm đạo đức xã hội thì danh tiếng thương hiệu tích lũy nhiều năm của nó nhất định sẽ mất sạch sành sanh.",
          "explanation": "\"丧失殆尽\" cảnh báo cái giá tự hủy diệt uy tín thương hiệu khi làm ăn phi pháp."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 107,
      "name": "Bổ ngữ xu hướng trừu tượng vượt thoát nghịch cảnh: \"走出来\"",
      "pattern": "Chủ ngữ + 从 + Bóng tối/Thất bại/Đau thương + 勇敢地走出来",
      "category": "Bổ ngữ",
      "explanation_vi": "\"走出来\" (zǒuchūlai) khi làm bổ ngữ phái sinh trừu tượng biểu thị hành động dũng cảm vượt thoát ra khỏi một trạng thái u ám, đau buồn, thất bại hoặc bóng ma tâm lý trong quá khứ để bước vào ánh sáng tái sinh một cuộc đời mới (bước ra khỏi nghịch cảnh, vượt qua nỗi đau).",
      "examples": [
        {
          "chinese": "在心理咨询师和亲友的悉心关怀下，他终于勇敢地从抑郁症的灰暗阴霾中走了出来。",
          "pinyin": "Zài xīnlǐ zīxúnshī hé qīnyǒu de xīxīn guānhuái xià, tā zhōngyú yǒnggǎn de cóng yìyùzhèng de huī'àn yīnmái zhōng zǒuchū lai le.",
          "translation_vi": "Dưới sự chăm sóc ân cần của chuyên gia tư vấn tâm lý và người thân bạn bè, anh ấy cuối cùng đã dũng cảm bước ra khỏi đám mây mù u ám của căn bệnh trầm cảm.",
          "explanation": "\"从...阴霾中走出来\" ca ngợi nghị lực phục hồi tinh thần tái hòa nhập cuộc sống."
        },
        {
          "chinese": "受灾地区人民擦干眼泪重建家园，以坚韧不拔的顽强毅力从特大自然灾害的创伤中走了出来。",
          "pinyin": "Shòuzāi dìqū rénmín cāgān yǎnlèi chóngjiàn jiāyuán, yǐ jiānrènbùbá de wánqiáng yìlì cóng tèdà zìrán zāihài de chuāngshāng zhōng zǒuchū lai le.",
          "translation_vi": "Người dân vùng bị thiên tai lau khô nước mắt tái thiết quê hương, bằng ý chí ngoan cường kiên định không dời đã bước ra khỏi nỗi đau thương của thảm họa thiên nhiên kinh hoàng.",
          "explanation": "\"从创伤中走出来\" khắc họa sức sống quật cường vươn lên từ đổ nát của nhân dân."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 108,
      "name": "Bổ ngữ trạng thái tầng bậc cực tả: \"形容词 + 到 + 令人发指 / 令人叹为观止\"",
      "pattern": "Tính từ (残暴 / 逼真 / 严密 / 丰富) + 到 + 令人发指 (tiêu cực) / 令人叹为观止 (tích cực)",
      "category": "Bổ ngữ",
      "explanation_vi": "Trong HSK 6, bổ ngữ trạng thái mở rộng kết hợp với giới từ \"到\" dẫn ra các thành ngữ bốn chữ miêu tả cảm xúc tột cùng của con người: 1) Đạt mức tàn nhẫn phẫn nộ cùng cực: \"残忍到令人发指\" (tàn nhẫn đến mức khiến người ta dựng tóc gáy phẫn nộ); 2) Đạt mức nghệ thuật tuyệt mỹ đỉnh cao: \"精美到令人叹为观止\" (tinh xảo đến mức khiến người ta phải trầm trồ thán phục).",
      "examples": [
        {
          "chinese": "侵略军在战争中所犯下的屠杀虐待平民暴行，其手段残酷野蛮到了令人发指的地步。",
          "pinyin": "Qīnlüèjūn zài zhànzhēng zhōng suǒ fànxià de túshā nüèdài píngmín bàoxíng, qí shǒuduàn cánkù yěmán dào le lìngrénfàzhǐ de dìbù.",
          "translation_vi": "Những tội ác dã man tàn sát ngược đãi thường dân mà quân xâm lược phạm phải trong chiến tranh, thủ đoạn của nó tàn khốc dã man tới mức khiến người ta phải dựng tóc gáy phẫn nộ.",
          "explanation": "\"野蛮到了令人发指的地步\" đanh thép lên án tội ác chiến tranh tột cùng phi nhân tính."
        },
        {
          "chinese": "这件镂空雕刻象牙球工艺品层层相套且转动自如，技艺之精湛奇绝令人叹为观止。",
          "pinyin": "Zhè jiàn lòukōng diāokè xiàngyáqiú gōngyìpǐn céngcéng xiāngtào qiě zhuàndòng zìrú, jìyì zhī jīngzhàn qíjué lìngréntànwéiguānzhǐ.",
          "translation_vi": "Món đồ thủ công mỹ nghệ quả cầu ngà voi chạm khắc lọng này từng tầng lồng vào nhau lại xoay chuyển tự do, kỹ nghệ tinh xảo kỳ tuyệt đến mức khiến người xem phải trầm trồ thán phục.",
          "explanation": "\"令人叹为观止\" ca ngợi đỉnh cao tuyệt kỹ điêu khắc thủ công dân gian."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 109,
      "name": "Cấu trúc so sánh tu từ không hề thua kém: \"不亚于\"",
      "pattern": "Chủ ngữ A + 对...的影响 / 价值 + 绝不亚于 + Đối tượng chuẩn mực B",
      "category": "Câu so sánh",
      "explanation_vi": "\"不亚于\" (bùyàyú) kết hợp chữ 不 (không), 亚 (thứ hai, kém hơn), 于 (so với), mang nghĩa \"mức độ, sức ảnh hưởng hoặc tầm quan trọng hoàn toàn ngang hàng, tuyệt đối không thua kém gì đối tượng mẫu mực hàng đầu\" (không thua kém gì, chẳng khác nào). Dùng để nâng tầm một sự vật mới sánh vai cùng tượng đài đã được công nhận.",
      "examples": [
        {
          "chinese": "这支青年创业团队研发的新型超级电池技术，在能量密度指标上绝不亚于国际领军巨头。",
          "pinyin": "Zhè zhī qīngnián chuàngyè tuánduì yánfā de xīnxíng chāojí diànchí jìshù, zài néngliàng mìdù zhǐbiāo shang jué bú yàyú guójì lǐngjūn jùtóu.",
          "translation_vi": "Công nghệ pin siêu cấp thế hệ mới do nhóm khởi nghiệp trẻ này nghiên cứu phát triển trên chỉ số mật độ năng lượng tuyệt đối không thua kém gì các tập đoàn khổng lồ đầu ngành quốc tế.",
          "explanation": "\"绝不亚于国际巨头\" khẳng định chất lượng kỹ thuật ngang ngửa với các ông lớn toàn cầu."
        },
        {
          "chinese": "在现代社会中，无形的信息网络诈骗对人民财产安全造成的破坏力，绝不亚于传统实体盗窃。",
          "pinyin": "Zài xiàndài shèhuì zhōng, wúxíng de xìnxī wǎngluò zhàpiàn duì rénmín cáichǎn ānquán zàochéng de pòhuàilì, jué bú yàyú chuántǒng shítǐ dàoqiè.",
          "translation_vi": "Trong xã hội hiện đại, sức tàn phá của nạn lừa đảo mạng thông tin vô hình đối với an toàn tài sản của nhân dân tuyệt đối không thua kém gì các vụ trộm cắp thực thể truyền thống.",
          "explanation": "\"不亚于传统盗窃\" so sánh mức độ nguy hại của tội phạm công nghệ cao với tội phạm truyền thống."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 110,
      "name": "Cấu trúc định vị góc nhìn đối sánh học thuật: \"相较于...而言\"",
      "pattern": "相较于 + Đối tượng đối chứng A + 而言, Đối tượng B + Có ưu thế vượt trội",
      "category": "Câu so sánh",
      "explanation_vi": "\"相较于...而言\" (xiāngjiàoyú... éryán) là công thức định vị góc nhìn so sánh đối chiếu chuẩn mực trong các luận văn nghiên cứu khoa học (so sánh đối chiếu với đối tượng A mà nói). Dùng để đặt một sự vật vào trong hệ quy chiếu cụ thể để rút ra ưu nhược điểm khách quan.",
      "examples": [
        {
          "chinese": "相较于传统的化石能源消耗模式而言，太阳能光伏发电具有清洁低碳、取之不尽的巨大综合优势。",
          "pinyin": "Xiāngjiàoyú chuántǒng de huàshí néngyuán xiāohào móshì éryán, tàiyángnéng guāngfú fādiàn jùyǒu qīngjié dītàn, qǔzhībújìn de jùdà zōnghé yōushì.",
          "translation_vi": "So với mô hình tiêu hao năng lượng hóa thạch truyền thống mà nói, phát điện quang điện mặt trời hội tụ ưu thế tổng hợp to lớn sạch sẽ giảm thiểu carbon và khai thác không bao giờ cạn.",
          "explanation": "\"相较于...而言\" đặt năng lượng mặt trời lên bàn cân đối chiếu với năng lượng hóa thạch."
        },
        {
          "chinese": "相较于大刀阔斧的激进变革而言，循序渐进的渐进式改良往往更容易凝聚社会共识并降低转型成本。",
          "pinyin": "Xiāngjiàoyú dàdāokuòfǔ de jījìn biàngé éryán, xúnxùjiànjìn de jiànjìnshì gǎiliáng wǎngwǎng gèng róngyì níngjù shèhuì gòngshí bìng jiàngdī zhuǎnxíng chéngběn.",
          "translation_vi": "So với sự biến cách cấp tiến làm mạnh tay rầm rộ mà nói, sự cải lương tiệm tiến từng bước thường dễ dàng quy tụ đồng thuận xã hội và giảm thiểu chi phí chuyển đổi hơn.",
          "explanation": "\"相较于...而言\" phân tích so sánh hai phương pháp luận cải cách thể chế chính trị xã hội."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 111,
      "name": "Cấu trúc so sánh mức độ cách biệt cực xa: \"远甚于\"",
      "pattern": "Chủ ngữ A + 带来的危害 / 意义 + 远甚于 + Đối tượng B",
      "category": "Câu so sánh",
      "explanation_vi": "\"远甚于\" (yuǎn shèn yú) kết hợp chữ 远 (xa, nhiều), 甚 (dữ dội, nặng nề), 于 (hơn), mang nghĩa \"vượt xa hơn rất nhiều so với, mức độ nghiêm trọng hoặc to lớn hơn gấp bội phần đối tượng so sánh\". Dùng khi phân tích mức độ chênh lệch cực lớn giữa hai yếu tố.",
      "examples": [
        {
          "chinese": "重大虚假财务造假行为对资本市场健康生态造成的毁灭性打击，其恶劣程度远甚于普通商业违约。",
          "pinyin": "Zhòngdà xūjiǎ cáiwù zàojiǎ xíngwéi duì zīběn shìchǎng jiànkāng shēngtài zàochéng de huǐmièxìng dǎjī, qí èliè chéngdù yuǎn shèn yú pǔtōng shāngyè wéiyuē.",
          "translation_vi": "Đòn đánh hủy diệt mà hành vi làm giả báo cáo tài chính trọng đại gây ra đối với hệ sinh thái lành mạnh của thị trường vốn, mức độ ác liệt của nó vượt xa hơn rất nhiều so với việc vi phạm hợp đồng thương mại thông thường.",
          "explanation": "\"远甚于普通商业违约\" vạch rõ ranh giới hiểm họa của tội phạm gian lận tài chính vĩ mô."
        },
        {
          "chinese": "青年时代树立崇高理想对一生人格成长所起的潜移默化滋养作用，其深远意义远甚于一时的考试名次。",
          "pinyin": "Qīngnián shídài shùlì chónggāo lǐxiǎng duì yìshēng réngé chéngzhǎng suǒ qǐ de qiányímòhuà zīyǎng zuòyòng, qí shēnyuǎn yìyì yuǎn shèn yú yìshí de kǎoshì míngcì.",
          "translation_vi": "Tác dụng nuôi dưỡng thẩm thấu âm thầm của việc xây dựng lý tưởng cao đẹp thời thanh xuân đối với sự trưởng thành nhân cách cả đời, ý nghĩa sâu xa của nó vượt xa hơn rất nhiều so với thứ hạng thi cử nhất thời.",
          "explanation": "\"远甚于一时的名次\" định hướng triết lý giáo dục nhân cách cao hơn thành tích thi cử ngắn hạn."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 112,
      "name": "Cấu trúc điều kiện ràng buộc tiên quyết: \"以...为前提\"",
      "pattern": "Tiến hành hợp tác / Phát triển kinh tế, 必须 + 以...为前提",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"以...为前提\" (yǐ... wéi qiántí) là cấu trúc pháp lý và ngoại giao chuẩn xác, biểu thị điều kiện A là tiền đề bắt buộc không thể thương lượng; nếu không đáp ứng được điều kiện tiên quyết A này thì toàn bộ thỏa thuận hoặc hành động tiếp theo đều trở nên vô nghĩa và không thể diễn ra.",
      "examples": [
        {
          "chinese": "世界各国开展平等经贸往来的根本基石，必须以互相尊重国家主权与核心利益为前提。",
          "pinyin": "Shìjiè gèguó kāizhǎn píngděng jīngmào wǎnglái de gēnběn jīshí, bìxū yǐ hùxiāng zūnzhòng guójiā zhǔquán yǔ héxīn lìyì wéi qiántí.",
          "translation_vi": "Nền tảng căn bản để các quốc gia trên thế giới triển khai giao lưu kinh tế thương mại bình đẳng bắt buộc phải lấy việc tôn trọng lẫn nhau về chủ quyền quốc gia và lợi ích cốt lõi làm tiền đề tiên quyết.",
          "explanation": "\"以互相尊重...为前提\" xác lập nguyên tắc bang giao quốc tế không thể xâm phạm."
        },
        {
          "chinese": "任何商业模式的技术创新与利润追求，都必须以绝对保障消费者的生命财产安全为前提。",
          "pinyin": "Rènhé shāngyè móshì de jìshù chuàngxīn yǔ lìrùn zhuīqiú, dōu bìxū yǐ juéduì bǎozhàng xiāofèizhě de shēngmìng cáichǎn ānquán wéi qiántí.",
          "translation_vi": "Bất kỳ sự đổi mới công nghệ và mưu cầu lợi nhuận nào của mô hình kinh doanh đều bắt buộc phải lấy việc bảo đảm tuyệt đối an toàn tính mạng và tài sản của người tiêu dùng làm tiền đề.",
          "explanation": "\"以绝对保障...安全为前提\" đặt an toàn tính mạng con người lên trên mọi mưu cầu lợi nhuận."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 113,
      "name": "Cấu trúc điểm tựa nương tựa phát triển: \"以...为依托\"",
      "pattern": "Dự án / Doanh nghiệp + 以 + Điểm tựa vững chắc (实体产业 / 科技实力 / 广阔市场) + 为依托",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"以...为依托\" (yǐ... wéi yītuō) kết hợp chữ 依托 (chỗ dựa, điểm tựa), biểu thị một tổ chức, một kế hoạch kinh doanh hoặc đề tài nghiên cứu lấy một thế mạnh sẵn có làm bệ đỡ vững chắc để sinh tồn và phát triển vươn lên (dựa vào, lấy... làm điểm tựa).",
      "examples": [
        {
          "chinese": "该自由贸易试验区以粤港澳大湾区雄厚完整的制造业产业链为依托，打造世界级创新高地。",
          "pinyin": "Gāi zìyóu màoyì shìyànqū yǐ Yuè-Gǎng-Ào Dàwānqū xiónghòu wánzhěng de zhìzàoyè chǎnyèliàn wéi yītuō, dǎzào shìjièjí chuàngxīn gāodì.",
          "translation_vi": "Khu thí điểm thương mại tự do này lấy chuỗi ngành chế tạo hùng hậu hoàn chỉnh của Vùng vịnh lớn Quảng Đông - Hồng Kông - Ma Cao làm điểm tựa vững chắc, kiến tạo nên vùng đất cao đổi mới cấp thế giới.",
          "explanation": "\"以...制造业产业链为依托\" làm rõ bệ phóng công nghiệp giúp khu thương mại cất cánh."
        },
        {
          "chinese": "现代金融服务业必须始终坚持以实体经济为坚强依托，决不能脱实向虚搞自我循环的投机泡沫。",
          "pinyin": "Xiàndài jīnróng fúwùyè bìxū shǐzhōng jiānchí yǐ shítǐ jīngjì wéi jiānqiáng yītuō, jué bù néng tuōshíxiàngxū gǎo zìwǒ xúnhuán de tóujī pàomò.",
          "translation_vi": "Ngành dịch vụ tài chính hiện đại bắt buộc phải luôn luôn kiên trì lấy nền kinh tế thực thể làm chỗ dựa vững chắc, quyết không thể rời xa thực tế hướng vào ảo để tạo ra những bong bóng đầu cơ tự tuần hoàn.",
          "explanation": "\"以实体经济为坚强依托\" khẳng định mối quan hệ cộng sinh giữa dòng tiền tài chính và sản xuất thực."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 114,
      "name": "Cấu trúc định hướng kim chỉ nam hành động: \"以...为导向\"",
      "pattern": "Chính sách / Nghiên cứu / Giáo dục + 必须 + 以...为导向 (市场需求 / 问题 / 结果 / 人民满意)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"以...为导向\" (yǐ... wéi dǎoxiàng) biểu thị việc xác định mục tiêu hoặc nhu cầu thực tiễn làm kim chỉ nam chỉ đạo phương hướng cho toàn bộ quá trình hành động, nghiên cứu hay ban hành chính sách (lấy... làm kim chỉ nam định hướng). Thường gặp: 以市场需求为导向 (lấy nhu cầu thị trường làm định hướng).",
      "examples": [
        {
          "chinese": "高校的人才培养方案必须紧密以国家重大战略需求和产业未来趋势为导向。",
          "pinyin": "Gāoxiào de réncái péiyǎng fāng'àn bìxū jǐnmì yǐ guójiā zhòngdà zhànlüè xūqiú hé chǎnyè wèilái qūshì wéi dǎoxiàng.",
          "translation_vi": "Phương án đào tạo nhân tài của các trường đại học bắt buộc phải lấy nhu cầu chiến lược trọng đại của quốc gia và xu thế tương lai của ngành nghề làm kim chỉ nam định hướng chặt chẽ.",
          "explanation": "\"以...需求为导向\" định hình mối liên kết giữa giảng dạy đại học và bài toán phát triển đất nước."
        },
        {
          "chinese": "各级政府部门深化放管服改革，必须始终坚持以人民群众的切身满意度为根本工作导向。",
          "pinyin": "Gèjí zhèngfǔ bùmén shēnhuà fàngguǎnfú gǎigé, bìxū shǐzhōng jiānchí yǐ rénmín qúnzhòng de qiēshēn mǎnyìdù wéi gēnběn gōngzuò dǎoxiàng.",
          "translation_vi": "Các cấp ban ngành chính phủ làm sâu sắc cải cách tinh gọn thủ tục hành chính bắt buộc phải luôn luôn kiên trì lấy sự hài lòng thiết thân của quần chúng nhân dân làm kim chỉ nam công tác căn bản.",
          "explanation": "\"以人民满意度为导向\" là chuẩn mực đánh giá chất lượng phục vụ công vụ nhà nước."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 115,
      "name": "Cấu trúc nguồn gốc quy nạp tính chất: \"由...所决定\"",
      "pattern": "Bản chất của sự vật + 是由 + Nguyên nhân nội tại cốt lõi + 所决定的",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"由...所决定\" (yóu... suǒ juédìng) là mẫu câu triết học chính luận kinh điển, dùng chữ \"由\" (do) kết hợp trợ từ \"所\" để khẳng định mạnh mẽ tính tất yếu: tính chất, quy luật hoặc vận mệnh của sự vật là do một yếu tố bản chất nội tại quyết định, chứ không phải ngẫu nhiên sinh ra.",
      "examples": [
        {
          "chinese": "中国始终奉行防御性的国防政策，这是由我国社会主义国家性质和走和平发展道路的战略抉择所决定的。",
          "pinyin": "Zhōngguó shǐzhōng fèngxíng fángyùxìng de guófáng zhèngcè, zhè shì yóu wǒ guó shèhuìzhǔyì guójiā xìngzhì hé zǒu hépíng fāzhǎn dàolù de zhànlüè juézé suǒ juédìng de.",
          "translation_vi": "Trung Quốc luôn luôn theo đuổi chính sách quốc phòng mang tính phòng ngự, điều này là do bản chất nhà nước xã hội chủ nghĩa và sự lựa chọn chiến lược đi theo con đường phát triển hòa bình của nước ta quyết định.",
          "explanation": "\"是由...所决定的\" là lời tuyên bố lập trường đối ngoại khẳng định bản chất yêu chuộng hòa bình của quốc gia."
        },
        {
          "chinese": "物质生产方式在人类历史演进中所起的最终决定作用，是由人类生存必须获取生活资料的基本规律所决定的。",
          "pinyin": "Wùzhì shēngchǎn fāngshì zài rénlèi lìshǐ yǎnjìn zhōng suǒ qǐ de zuìzhōng juédìng zuòyòng, shì yóu rénlèi shēngcún bìxū huòqǔ shēnghuó zīliào de jīběn guīlǜ suǒ juédìng de.",
          "translation_vi": "Tác dụng quyết định cuối cùng của phương thức sản xuất vật chất trong tiến trình lịch sử nhân loại là do quy luật cơ bản con người sinh tồn bắt buộc phải thu hoạch tư liệu sinh hoạt quyết định.",
          "explanation": "\"是由...规律所决定的\" làm sáng tỏ nguyên lý duy vật lịch sử về vai trò của sản xuất vật chất."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 116,
      "name": "Cấu trúc quan hệ phụ thuộc hữu cơ: \"附属于\"",
      "pattern": "Chủ thể B + 始终附属于 / 绝不是附属于 + Chủ thể A",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"附属于\" (fùshǔyú) kết hợp chữ 附属 (phụ thuộc, trực thuộc) và 于, mang nghĩa thuộc về, lệ thuộc vào một tổng thể lớn hơn, không thể tách rời tồn tại độc lập (trực thuộc, phụ thuộc vào).",
      "examples": [
        {
          "chinese": "这些小岛屿自古以来在地理、历史及法律管辖上都始终紧密附属于祖国大陆，是不可分割的一部分。",
          "pinyin": "Zhèxiē xiǎodǎoyǔ zìgǔyǐlái zài dìlǐ, lìshǐ jí fǎlǜ guǎnxiá shang dōu shǐzhōng jǐnmì fùshǔyú zǔguó dàlù, shì bùkě fēngē de yí bùfen.",
          "translation_vi": "Những hòn đảo nhỏ này từ xưa đến nay trên phương diện địa lý, lịch sử và quyền tài phán pháp luật đều luôn luôn gắn kết phụ thuộc chặt chẽ vào đại lục tổ quốc, là một bộ phận không thể tách rời.",
          "explanation": "\"附属于祖国大陆\" khẳng định chứng cứ chủ quyền lãnh thổ hải đảo thiêng liêng."
        },
        {
          "chinese": "文艺创作绝不是单纯附属于商业资本的赚钱工具，它拥有独立的审美追求与崇高的人文灵魂。",
          "pinyin": "Wényì chuàngzuò jué bú shì dānchún fùshǔyú shāngyè zīběn de zhuànqián gōngjù, tā yōngyǒu dúlì de shěnměi zhuīqiú yǔ chónggāo de rénwén línghún.",
          "translation_vi": "Sáng tác văn nghệ tuyệt đối không phải là công cụ kiếm tiền đơn thuần phụ thuộc vào tư bản thương mại, nó nắm giữ sự theo đuổi thẩm mỹ độc lập và linh hồn nhân văn cao cả.",
          "explanation": "\"绝不是附属于商业资本\" bảo vệ phẩm giá tự do sáng tạo nghệ thuật độc lập."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 117,
      "name": "Cấu trúc tích lũy theo thời gian tạo biến đổi về chất: \"日积月累\"",
      "pattern": "经过 + 日积月累的 (努力 / 积累 / 钻研), 才能 + Gặt hái thành tựu",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"日积月累\" (rì jī yuè lěi) kết hợp chữ 日 (ngày), 积 (tích cóp), 月 (tháng), 累 (chất chồng), miêu tả quá trình tích lũy kiến thức, kinh nghiệm hoặc rèn luyện kỹ năng qua từng ngày từng tháng lâu bền cho tới khi tạo nên bước nhảy vọt thần kỳ về lượng biến thành chất biến (ngày tích tháng dồn, tích tiểu thành đại).",
      "examples": [
        {
          "chinese": "学问与技艺的真正大成绝无任何捷径可走，靠的完全是数十年如一日日积月累的苦功夫。",
          "pinyin": "Xuéwèn yǔ jìyì de zhēnzhèng dàchéng jué wú rènhé jiéjìng kě zǒu, kào de wánquán shì shùshí nián rú yí rì rìjīyuèlěi de kǔ gōngfu.",
          "translation_vi": "Sự đại thành thực sự của học vấn và tay nghề tuyệt đối không có bất kỳ con đường tắt nào để đi, cái dựa vào hoàn toàn là công phu gian khổ ngày tích tháng dồn mấy chục năm như một ngày.",
          "explanation": "\"日积月累的苦功夫\" khẳng định chân lý khổ luyện thành tài không có đường tắt."
        },
        {
          "chinese": "良好语言语感的培养源于每天坚持听读背诵，经过日积月累，自然能出口成章、下笔有神。",
          "pinyin": "Liánghǎo yǔyán yǔgǎn de péiyǎng yuányú měitiān jiānchí tīng dú bèisòng, jīngguò rìjīyuèlěi, zìrán néng chūkǒuchéngzhāng, xiàbǐyǒushén.",
          "translation_vi": "Việc bồi dưỡng cảm thụ ngôn ngữ tốt đẹp bắt nguồn từ việc kiên trì nghe đọc học thuộc mỗi ngày, trải qua ngày tích tháng dồn, tự nhiên sẽ có thể mở miệng thành lời hay, hạ bút có thần sắc.",
          "explanation": "\"经过日积月累\" động viên người học ngoại ngữ bền bỉ luyện tập tích lũy hằng ngày."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 118,
      "name": "Cấu trúc biến đổi vĩ đại long trời lở đất: \"翻天覆地\"",
      "pattern": "Nơi chốn / Đất nước + 发生了 + 翻天覆地的历史性巨变",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"翻天覆地\" (fān tiān fù dì) kết hợp chữ 翻天 (lật trời) và 覆地 (đảo đất), là thành ngữ phóng đại hùng tráng miêu tả sự biến đổi, đổi thay mang tính cách mạng toàn diện, triệt để đến mức làm thay đổi hoàn toàn diện mạo của non sông, xã hội (long trời lở đất, thay trời đổi đất).",
      "examples": [
        {
          "chinese": "改革开放四十多年来，这片曾经贫困闭塞的古老土地发生了翻天覆地的历史性巨变。",
          "pinyin": "Gǎigé kāifàng sìshí duō nián lái, zhè piàn céngjīng pínkùn bìsè de gǔlǎo tǔdì fāshēng le fāntiānfùdì de lìshǐxìng jùbiàn.",
          "translation_vi": "Hơn 40 năm cải cách mở cửa đến nay, mảnh đất cổ xưa từng nghèo khó khép kín này đã xảy ra sự đổi thay lịch sử to lớn long trời lở đất.",
          "explanation": "\"翻天覆地的历史性巨变\" ca ngợi thành tựu vĩ đại của công cuộc đổi mới hiện đại hóa đất nước."
        },
        {
          "chinese": "高新技术的迅猛发展正在以颠覆性的力量重构传统商业模式，给人们的生活方式带来了翻天覆地的变化。",
          "pinyin": "Gāoxīn jìshù de xùnměng fāzhǎn zhèngzài yǐ diānfùxìng de lìliàng chónggòu chuántǒng shāngyè móshì, gěi rénmen de shēnghuó fāngshì dàilái le fāntiānfùdì de biànhuà.",
          "translation_vi": "Sự phát triển vũ bão của công nghệ cao mới đang bằng sức mạnh mang tính đảo lộn tái cấu trúc mô hình kinh doanh truyền thống, đem lại những biến đổi long trời lở đất cho lối sống của con người.",
          "explanation": "\"翻天覆地的变化\" lột tả sức mạnh xoay chuyển càn khôn của cuộc cách mạng công nghệ số."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 119,
      "name": "Cấu trúc thành tựu vĩ đại khiến cả thế giới dõi theo: \"举世瞩目\"",
      "pattern": "取得 / 创造了 + 举世瞩目的 (辉煌成就 / 伟大奇迹 / 巨大飞跃)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"举世瞩目\" (jǔshì zhǔmù) kết hợp chữ 举世 (toàn thế giới), 瞩目 (dõi mắt dõi theo ngắm nhìn), miêu tả một thành tựu khoa học, công trình kỳ tích hoặc sự trỗi dậy kinh tế đạt tới tầm vóc phi thường khiến toàn thể nhân loại trên trái đất đều phải ngước nhìn dõi theo thán phục.",
      "examples": [
        {
          "chinese": "经过几代人的艰辛探索与无私奉献，中国载人航天工程取得了举世瞩目的辉煌跨越。",
          "pinyin": "Jīngguò jǐ dài rén de jiānxīn tànsuǒ yǔ wúsī fèngxiàn, Zhōngguó zàirén hángtiān gōngchéng qǔdé le jǔshìzhǔmù de huīhuáng kuàyuè.",
          "translation_vi": "Qua sự tìm tòi gian nan và cống hiến quên mình của mấy thế hệ, công trình hàng không vũ trụ có người lái của Trung Quốc đã giành được bước nhảy vọt huy hoàng khiến cả thế giới dõi theo ngưỡng mộ.",
          "explanation": "\"举世瞩目的辉煌跨越\" tôn vinh kỳ tích chinh phục không gian vũ trụ của các nhà khoa học."
        },
        {
          "chinese": "我国在消除绝对贫困这一困扰人类数千年的历史性难题上，创造了令举世瞩目的伟大奇迹。",
          "pinyin": "Wǒ guó zài xiāochú juéduì pínkùn zhè yì kùnrǎo rénlèi shù qiān nián de lìshǐxìng nándí shang, chuàngzào le lìng jǔshìzhǔmù de wěidà qíjì.",
          "translation_vi": "Nước ta trên bài toán khó lịch sử quấy rầy nhân loại suốt mấy nghìn năm qua là xóa bỏ đói nghèo tuyệt đối, đã kiến tạo nên một kỳ tích vĩ đại khiến toàn thế giới đều phải dõi mắt thán phục.",
          "explanation": "\"令举世瞩目的伟大奇迹\" ghi nhận thành tựu xóa đói giảm nghèo vĩ đại cống hiến cho văn minh nhân loại."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 120,
      "name": "Cấu trúc mưa dầm thấm lâu thẩm thấu âm thầm: \"潜移默化\"",
      "pattern": "Nền giáo dục / Môi trường gia đình + 起到了 + 潜移默化的熏陶作用",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"潜移默化\" (qián yí mò huà) kết hợp chữ 潜 (ngấm ngầm, vô hình), 移 (chuyển dịch), 默 (lặng lẽ, không tiếng động), 化 (cải hóa, biến đổi), miêu tả sự hun đúc tư tưởng, đạo đức, thẩm mỹ hoặc thói quen diễn ra tự nhiên, từ từ như mưa dầm thấm đất, khiến con người biến đổi tính cách mà bản thân không hề hay biết.",
      "examples": [
        {
          "chinese": "优秀的经典文学名著对青少年精神品格的塑造，起着春风化雨、潜移默化的深远滋养作用。",
          "pinyin": "Yōuxiù de jīngdiǎn wénxué míngzhù duì qīngshàonián jīngshén pǐngé de sùzào, qǐzhe chūnfēnghuàyǔ, qiányímòhuà de shēnyuǎn zīyǎng zuòyòng.",
          "translation_vi": "Những danh tác văn học kinh điển xuất sắc đối với việc đắp nặn phẩm cách tinh thần của thanh thiếu niên đóng vai trò nuôi dưỡng sâu xa như gió xuân mơn man, mưa dầm thấm lâu biến đổi âm thầm.",
          "explanation": "\"潜移默化的滋养作用\" khẳng định giá trị hun đúc nhân cách bền bỉ của việc đọc sách văn học cổ điển."
        },
        {
          "chinese": "父母在日常生活中言谈举止所展现的文明修养，正在潜移默化地深刻影响着孩子的行为习惯。",
          "pinyin": "Fùmǔ zài rìcháng shēnghuó zhōng yántánjǔzhǐ suǒ zhǎnxiàn de wénmíng xiūyǎng, zhèngzài qiányímòhuà de shēnkè yǐngxiǎngzhe háizi de xíngwéi xíguàn.",
          "translation_vi": "Sự tu dưỡng văn minh thể hiện trong từng lời ăn tiếng nói cử chỉ hằng ngày của cha mẹ đang âm thầm ngấm dần ảnh hưởng sâu sắc tới thói quen hành vi của con cái.",
          "explanation": "\"潜移默化地影响\" nêu bật vai trò làm gương mẫu mực của đấng sinh thành trong giáo dục gia đình."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 121,
      "name": "Cấu trúc chí nguyện thề son sắt không dời: \"矢志不渝\"",
      "pattern": "Chủ ngữ + 始终 + 矢志不渝地 + Động từ (奋斗 / 坚守 / 追求 / 奉献)",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"矢志不渝\" (shǐ zhì bù yú) kết hợp chữ 矢 (thề, bắn mũi tên thề), 志 (chí hướng, lý tưởng), 渝 (thay đổi, phụ bạc), biểu thị ý chí son sắt, lời thề thủy chung son sắt đối với lý tưởng, tình yêu hoặc sự nghiệp cách mạng, dù trải qua muôn trùng bão táp sinh tử cũng tuyệt đối không bao giờ phản bội hay đổi thay.",
      "examples": [
        {
          "chinese": "老一辈革命家为了实现民族独立与人民解放的宏伟誓愿，抛家舍业、矢志不渝。",
          "pinyin": "Lǎoyíbèi gémìngjiā wèile shíxiàn mínzú dúlì yǔ rénmín jiěfàng de hóngwěi shìyuàn, pāojiāshěyè, shǐzhìbùyú.",
          "translation_vi": "Các nhà cách mạng thế hệ tiền bối vì hiện thực hóa lời thề nguyện hùng vĩ độc lập dân tộc và giải phóng nhân dân đã gác lại gia đình dấn thân cống hiến, son sắt một lòng thề không đổi dời.",
          "explanation": "\"矢志不渝\" ca ngợi lòng kiên trung bất khuất của các chiến sĩ tiền bối vì non sông."
        },
        {
          "chinese": "一代代塞罕坝务林人扎根荒漠六十年如一日，矢志不渝地在高原荒原上筑起了一道绿色生态屏障。",
          "pinyin": "Yídàidài Sàihǎnbà wùlínrén zhāgēn huāngmò liùshí nián rú yí rì, shǐzhìbùyú de zài gāoyuán huāngyuán shang zhùqǐ le yí dào lǜsè shēngtài píngzhàng.",
          "translation_vi": "Bao thế hệ người trồng rừng Saihanba bám rễ nơi hoang mạc suốt 60 năm như một ngày, kiên định son sắt không đổi dời đã dựng nên một tấm bình phong sinh thái xanh biếc trên cao nguyên hoang cằn.",
          "explanation": "\"矢志不渝地筑起屏障\" tôn vinh tinh thần trồng rừng bền bỉ cải tạo thiên nhiên của những người hùng thầm lặng."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 122,
      "name": "Cấu trúc cội nguồn văn hóa truyền thống sâu dày: \"源远流长\"",
      "pattern": "Chủ ngữ + 历史悠久, 源远流长 / 友谊源远流长",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"源远流长\" (yuán yuǎn liú cháng) kết hợp chữ 源 (nguồn nước), 远 (xa xôi), 流 (dòng chảy), 长 (dài lâu), mang nghĩa nguồn cội xuất phát từ thời cổ đại xa xôi, dòng chảy kế thừa liên tục xuyên suốt ngàn năm mà không bao giờ đứt đoạn (nguồn xa dòng dài, có bề dày lịch sử ngàn năm). Chuyên dùng cho văn hóa, hữu nghị quốc tế.",
      "examples": [
        {
          "chinese": "中华优秀传统文化源远流长、博大精深，是我们在世界文化激荡中站稳脚跟的坚实根基。",
          "pinyin": "Zhōnghuá yōuxiù chuántǒng wénhuà yuányuǎnliúcháng, bódàjīngshēn, shì wǒmen zài shìjiè wénhuà jīdàng zhōng zhànwěn jiǎogēn de jiānshí gēnjī.",
          "translation_vi": "Văn hóa truyền thống xuất sắc của Trung Hoa nguồn xa dòng dài, uyên bác tinh thâm, chính là nền tảng vững chắc giúp chúng ta đứng vững gót chân giữa sự biến động sóng gió của văn hóa thế giới.",
          "explanation": "\"源远流长、博大精深\" là cặp thành ngữ chuẩn mực nhất ca ngợi bề dày lịch sử của nền văn minh Trung Hoa."
        },
        {
          "chinese": "中非两国人民之间的深厚友谊源远流长，历经国际风云变幻的严峻考验而历久弥坚。",
          "pinyin": "Zhōng-Fēi liǎng guó rénmín zhījiān de shēnhòu yǒuyì yuányuǎnliúcháng, lìjīng guójì fēngyún biànhuàn de yánjùn kǎoyàn ér lìjiǔmíjiān.",
          "translation_vi": "Tình hữu nghị sâu đậm giữa nhân dân hai nước Trung Quốc và châu Phi nguồn xa dòng dài, trải qua các thử thách ngặt nghèo của phong vân biến đổi quốc tế mà ngày càng thêm son sắt bền chặt.",
          "explanation": "\"友谊源远流长，历久弥坚\" là công thức ngoại giao mẫu mực khẳng định tình bạn truyền thống quốc tế trường tồn."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    },
    {
      "order_index": 123,
      "name": "Cấu trúc gắn bó hòa hợp tự nhiên không tì vết: \"天衣无缝\"",
      "pattern": "Cấu trúc / Sự phối hợp / Kế hoạch + 严密到 + 天衣无缝",
      "category": "Cấu trúc cố định",
      "explanation_vi": "\"天衣无缝\" (tiān yī wú fèng) bắt nguồn từ truyền thuyết: chiếc áo của tiên nữ trên trời dệt bằng mây ngũ sắc không hề có một đường kim mũi chỉ nào ráp nối. Dùng để khen ngợi một kế hoạch chu toàn, một kết cấu văn chương liền mạch hoặc sự phối hợp tác chiến ăn ý hoàn mỹ không một kẽ hở (kín kẽ không một kẽ hở, hoàn hảo tự nhiên).",
      "examples": [
        {
          "chinese": "这支双人花样滑冰组合在冰面上的动作编排行云流水，彼此默契配合得堪称天衣无缝。",
          "pinyin": "Zhè zhī shuāngrén huāyàng huábīng zǔhé zài bīngmiàn shang de dòngzuò biānpái xíngyúnliúshuǐ, bǐcǐ mòqì pèihé de kānchēng tiānyīwúfèng.",
          "translation_vi": "Cặp đôi trượt băng nghệ thuật này trên mặt băng có sự dàn dựng động tác uyển chuyển như mây trôi nước chảy, sự phối hợp ăn ý ngầm của đôi bên đáng gọi là hoàn hảo không một tì vết.",
          "explanation": "\"配合得堪称天衣无缝\" ca ngợi sự ăn ý tuyệt đỉnh của cặp vận động viên vô địch trượt băng."
        },
        {
          "chinese": "犯罪分子自以为作案计划设计得天衣无缝，殊不知在现代高科技刑侦技术面前漏洞百出。",
          "pinyin": "Fànzuì fènzǐ zìyǐwéi zuò'àn jìhuà shèjì de tiānyīwúfèng, shūbùzhī zài xiàndài gāokējì xíngzhēn jìshù miànqián lòudòngbǎichū.",
          "translation_vi": "Kẻ phạm tội tự ngỡ kế hoạch gây án của mình được thiết kế kín kẽ không một kẽ hở, đâu ngờ rằng trước công nghệ điều tra hình sự công nghệ cao hiện đại lại lộ ra trăm nghìn sơ hở.",
          "explanation": "\"设计得天衣无缝\" miêu tả sự tự mãn sai lầm của kẻ gian trước sự phá án tinh tường của công an."
        }
      ],
      "hsk_level": "HSK 6",
      "source": "gf0025_2021",
      "validation_status": "verified"
    }
  ]
}
