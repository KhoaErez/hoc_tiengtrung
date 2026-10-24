export const HSK3_GRAMMAR_PART1 = [
  // --- NHÓM 1: ĐẠI TỪ BẤT ĐỊNH & PHIẾM CHỈ (不定代词) ---
  {
    order_index: 1,
    name: "Đại từ phiếm chỉ chỉ người khác \"别人\" (Người khác / Người ngoài)",
    pattern: "别人 + Vị ngữ / Vị ngữ + 别人",
    category: "Đại từ",
    explanation_vi: "\"别人\" (biérén) dùng để chỉ những người khác ngoài bản thân mình hoặc ngoài người đang giao tiếp (người khác, người ngoài). Thường làm chủ ngữ, tân ngữ hoặc định ngữ.",
    examples: [
      {
        chinese: "在公共场所与他人交流时，我们应当懂得倾听并尊重别人的意见。",
        pinyin: "Zài gōnggòng chǎngsuǒ yǔ tārén jiāoliú shí, wǒmen yīngdāng dǒngde qīngtīng bìng zūnzhòng biérén de yìjiàn.",
        translation_vi: "Khi giao lưu với người khác ở nơi công cộng, chúng ta nên biết lắng nghe và tôn trọng ý kiến của người khác.",
        explanation: "\"别人的意见\" làm định ngữ bổ nghĩa cho danh từ ý kiến."
      },
      {
        chinese: "遇到困难时不要一味依赖别人，要学会独立思考解决问题。",
        pinyin: "Yù dào kùnnán shí bú yào yíwèi yīlài biérén, yào xuéhuì dúlì sīkǎo jiějué wèntí.",
        translation_vi: "Khi gặp khó khăn đừng chỉ biết mù quáng ỷ lại vào người khác, cần phải học cách suy nghĩ độc lập để giải quyết vấn đề.",
        explanation: "\"依赖别人\" làm tân ngữ đứng sau động từ phụ thuộc."
      }
    ]
  },
  {
    order_index: 2,
    name: "Đại từ phân biệt \"其他 / 其它\" (Khác / Còn lại)",
    pattern: "其他 (+ Lượng từ) + Danh từ (+ 都...)",
    category: "Đại từ",
    explanation_vi: "\"其他\" (qítā) dùng để chỉ người hoặc sự vật khác ngoài đối tượng đã được đề cập (khác, còn lại). Khi chỉ đồ vật/sự việc có thể dùng \"其它\". Thường làm định ngữ hoặc đại từ độc lập.",
    examples: [
      {
        chinese: "除了这两位请假的同学以外，班里其他学生都准时到校了。",
        pinyin: "Chúle zhè liǎng wèi qǐngjià de tóngxué yǐwài, bān lǐ qítā xuésheng dōu zhǔnshí dào xiào le.",
        translation_vi: "Ngoại trừ hai bạn học sinh xin nghỉ phép này ra, các học sinh khác trong lớp đều đã đến trường đúng giờ.",
        explanation: "\"其他学生\" chỉ nhóm học sinh còn lại trong lớp."
      },
      {
        chinese: "这个问题已经解决好了，你看看还有没有其他需要补充的建议？",
        pinyin: "Zhè gè wèntí yǐjīng jiějué hǎo le, nǐ kànkan hái yǒu méiyǒu qítā xūyào bǔchōng de jiànyì?",
        translation_vi: "Vấn đề này đã được giải quyết xong xuôi rồi, bạn xem xem còn có kiến nghị nào khác cần bổ sung không?",
        explanation: "\"其他...建议\" bổ nghĩa cho danh từ kiến nghị."
      }
    ]
  },
  {
    order_index: 3,
    name: "Đại từ bất định chỉ sự vật không hạn chế \"任何\" (Bất kỳ / Bất luận)",
    pattern: "任何 (+ Lượng từ) + Danh từ + 都 / 也 + Vị ngữ",
    category: "Đại từ",
    explanation_vi: "\"任何\" (rènhé) là đại từ bất định biểu thị tính toàn thể không giới hạn (bất kỳ, bất luận cái gì/ai). Thường làm định ngữ đứng trước danh từ và vị ngữ bắt buộc phải có phó từ \"都\" hoặc \"也\".",
    examples: [
      {
        chinese: "在神圣的国家法律面前，任何公民都必须严格遵守社会公共秩序。",
        pinyin: "Zài shénshèng de guójiā fǎlǜ miànqián, rènhé gōngmín dōu bìxū yángé zūnshǒu shèhuì gōnggòng zhìxù.",
        translation_vi: "Trước pháp luật quốc gia thiêng liêng, bất kỳ công dân nào cũng đều phải nghiêm chỉnh tuân thủ trật tự công cộng xã hội.",
        explanation: "\"任何公民都\" nhấn mạnh tính phổ quát không có ngoại lệ."
      },
      {
        chinese: "只要我们下定决心努力奋斗，任何困难都不能阻挡我们前进的步伐。",
        pinyin: "Zhǐyào wǒmen xiàdìng juéxīn nǔlì fèndòu, rènhé kùnnán dōu bù néng zǔdǎng wǒmen qiánjìn de bùfá.",
        translation_vi: "Chỉ cần chúng ta hạ quyết tâm nỗ lực phấn đấu, bất kỳ khó khăn nào cũng không thể cản bước tiến của chúng ta.",
        explanation: "\"任何困难都\" biểu thị tất cả mọi khó khăn đều bị khuất phục."
      }
    ]
  },

  // --- NHÓM 2: SỐ TỪ ƯỚC LƯỢNG (概数表达法) ---
  {
    order_index: 4,
    name: "Số ước lượng đặt sau số từ \"左右\" (Khoảng / Chừng)",
    pattern: "Số từ + Lượng từ + Danh từ + 左右 / Mốc thời gian + 左右",
    category: "Số từ",
    explanation_vi: "\"左右\" (zuǒyòu) đặt ngay sau số lượng từ hoặc từ chỉ thời gian, tuổi tác để biểu thị con số ước lượng xấp xỉ không hoàn toàn chính xác (khoảng, tầm, chừng).",
    examples: [
      {
        chinese: "参加今天下午跨国学术视频研讨会的专家学者有五十人左右。",
        pinyin: "Cānjiā jīntiān xiàwǔ kuàguó xuéshù shìpín yántǎohuì de zhuānjiā xuézhě yǒu wǔshí rén zuǒyòu.",
        translation_vi: "Các chuyên gia học giả tham gia hội thảo video học thuật xuyên quốc gia chiều nay có khoảng chừng năm mươi người.",
        explanation: "\"五十人左右\" ước lượng số lượng người tham dự xấp xỉ 50."
      },
      {
        chinese: "我们今天下午四点半左右在校门口的公交车站集合出发。",
        pinyin: "Wǒmen jīntiān xiàwǔ sì diǎn bàn zuǒyòu zài xiàoménkǒu de gōngjiāochē zhàn jíhé chūfā.",
        translation_vi: "Chúng tôi vào khoảng bốn giờ rưỡi chiều nay sẽ tập trung ở trạm xe buýt cổng trường rồi xuất phát.",
        explanation: "\"四点半左右\" chỉ mốc thời gian ước lượng."
      }
    ]
  },
  {
    order_index: 5,
    name: "Số ước lượng đặt sau số tròn chục \"上下\" (Khoảng chừng / Xấp xỉ)",
    pattern: "Số tuổi / Con số tròn + 上下",
    category: "Số từ",
    explanation_vi: "\"上下\" (shàngxià) thường đứng sau số từ chỉ tuổi tác hoặc số đo tròn chục để biểu thị số ước tính chênh lệch chút ít lên hoặc xuống (khoảng chừng, trạc tuổi).",
    examples: [
      {
        chinese: "那位正在讲台上给留学生授课的教授看起来四十岁上下。",
        pinyin: "Nà wèi zhèngzài jiǎngtái shang gěi liúxuéshēng shòukè de jiàoshòu kàn qǐlai sìshí suì shàngxià.",
        translation_vi: "Vị giáo sư đang đứng trên bục giảng dạy bài cho lưu học sinh kia nhìn tầm khoảng bốn mươi tuổi.",
        explanation: "\"四十岁上下\" ước lượng độ tuổi xấp xỉ 40."
      },
      {
        chinese: "参加这次马拉松比赛的长跑健儿体重大多在六十公斤上下。",
        pinyin: "Cānjiā zhè cì mǎlāsōng bǐsài de chángpǎo jiàn'ér tǐzhòng dàduō zài liùshí gōngjīn shàngxià.",
        translation_vi: "Các vận động viên chạy dài tham gia cuộc đua marathon lần này thể trọng đa số ở khoảng sáu mươi cân (kg).",
        explanation: "\"六十公斤上下\" biểu thị khoảng cân nặng ước tính."
      }
    ]
  },
  {
    order_index: 6,
    name: "Phó từ ước lượng đứng trước số từ \"差不多\" (Gần như / Xấp xỉ)",
    pattern: "差不多 + Số lượng từ / Danh từ / Tính từ",
    category: "Số từ",
    explanation_vi: "\"差不多\" (chàbuduō) làm trạng ngữ đứng trước số lượng từ biểu thị con số gần sát mức đó (gần như, ngót nghét, xấp xỉ). Ngoài ra còn làm vị ngữ biểu thị sự tương đương (na ná nhau).",
    examples: [
      {
        chinese: "他在这个充满现代化活力的海滨城市生活了差不多十年。",
        pinyin: "Tā zài zhè gè chōngmǎn xiàndàihuà huólì de hǎibīn chéngshì shēnghuó le chàbuduō shí nián.",
        translation_vi: "Anh ấy đã sinh sống ở thành phố ven biển tràn đầy sức sống hiện đại này ngót nghét gần mười năm.",
        explanation: "\"差不多十年\" ước lượng thời gian xấp xỉ gần đủ 10 năm."
      },
      {
        chinese: "这两款国产智能手机的外观尺寸与显示效果差不多。",
        pinyin: "Zhè liǎng kuǎn guóchǎn zhìnéng shǒujī de wàiguān chǐcùn yǔ xiǎnshì xiàoguǒ chàbuduō.",
        translation_vi: "Kích thước bề ngoài và hiệu quả hiển thị của hai mẫu điện thoại thông minh nội địa này xấp xỉ như nhau.",
        explanation: "\"差不多\" làm vị ngữ chỉ sự tương đương."
      }
    ]
  },
  {
    order_index: 7,
    name: "Số ước lượng với \"多\" biểu thị số dôi dư (Hơn / Ngoài)",
    pattern: "Số tròn chục/trăm/nghìn + 多 + Lượng từ / Số lẻ nhỏ hơn 10 + Lượng từ + 多",
    category: "Số từ",
    explanation_vi: "Vị trí của \"多\" (duō) phụ thuộc vào con số đứng trước: nếu là số tròn chục trở lên (10, 20, 100) thì \"多\" đứng TRƯỚC lượng từ (như: 十多个人: mười mấy người); nếu là số lẻ dưới 10 thì \"多\" đứng SAU lượng từ (như: 三个多月: hơn ba tháng).",
    examples: [
      {
        chinese: "我们大学的国际交流学院一共有二十多位外籍留学生。",
        pinyin: "Wǒmen dàxué de guójì jiāoliú xuéyuàn yígòng yǒu èrshí duō wèi wàijí liúxuéshēng.",
        translation_vi: "Học viện giao lưu quốc tế trường đại học chúng tôi tổng cộng có hơn hai mươi bạn lưu học sinh nước ngoài.",
        explanation: "\"二十多位\" do 20 là số tròn chục nên \"多\" đứng trước lượng từ \"位\"."
      },
      {
        chinese: "他为了准备高级翻译资格考试，连续苦读了五个多月。",
        pinyin: "Tā wèile zhǔnbèi gāojí fānyì zīgé kǎoshì, liánxù kǔdú le wǔ gè duō yuè.",
        translation_vi: "Để chuẩn bị cho kỳ thi chứng chỉ biên phiên dịch cao cấp, anh ấy đã miệt mài dùi mài liên tục hơn năm tháng.",
        explanation: "\"五个多月\" do 5 là số nhỏ hơn 10 nên \"多\" đứng sau lượng từ \"个\"."
      }
    ]
  },

  // --- NHÓM 3: LƯỢNG TỪ TRUNG CẤP (中级量词) ---
  {
    order_index: 8,
    name: "Lượng từ đoạn đường / thời gian \"段\" (Đoạn / Quãng)",
    pattern: "一 + 段 + Thời gian (时间) / Khoảng cách (路) / Câu văn (话)",
    category: "Lượng từ",
    explanation_vi: "\"段\" (duàn) là lượng từ dùng cho một phần của không gian dài (một đoạn đường: 一段路), một khoảng thời gian liên tục (một quãng thời gian: 一段时间), hoặc một phân đoạn văn bản, lời nói (一段话).",
    examples: [
      {
        chinese: "经过前一段时间的刻苦训练，他的汉语听说水平有了显著提升。",
        pinyin: "Jīngguò qián yí duàn shíjiān de kèkǔ xùnliàn, tā de hànyǔ tīng-shuō shuǐpíng yǒu le xiǎnzhù tíshēng.",
        translation_vi: "Trải qua một quãng thời gian khổ luyện trước đó, trình độ nghe nói tiếng Hán của anh ấy đã có bước nâng cao rõ rệt.",
        explanation: "\"一段时间\" chỉ khoảng thời gian liên tục đã qua."
      },
      {
        chinese: "老师在黑板上端正地抄写了一段著名的古文名言。",
        pinyin: "Lǎoshī zài hēibǎn shang duānzhèng de chāoxiě le yí duàn zhùmíng de gǔwén míngyán.",
        translation_vi: "Thầy giáo nắn nót chép lên bảng đen một đoạn danh ngôn cổ văn nổi tiếng.",
        explanation: "\"一段...名言\" lượng từ cho đoạn văn bản."
      }
    ]
  },
  {
    order_index: 9,
    name: "Lượng từ chủng loại / kiểu mẫu \"种\" (Loại / Thứ)",
    pattern: "Số từ + 种 + Danh từ (水果 / 语言 / 办法)",
    category: "Lượng từ",
    explanation_vi: "\"种\" (zhǒng) là lượng từ chỉ chủng loại, phân loại của sự vật hoặc hiện tượng trừu tượng (loại, thứ, phương diện).",
    examples: [
      {
        chinese: "这位资深翻译专家熟练掌握了英、法、西等三种联合国官方语言。",
        pinyin: "Zhè wèi zīshēn fānyì zhuānjiā shúliàn zhǎngwò le yīng, fǎ, xī děng sān zhǒng Liánhéguó guānfāng yǔyán.",
        translation_vi: "Chuyên gia dịch thuật kỳ cựu này đã nắm vững thuần thục ba thứ ngôn ngữ chính thức của Liên Hợp Quốc gồm Anh, Pháp, Tây Ban Nha.",
        explanation: "\"三种...语言\" biểu thị ba loại ngôn ngữ."
      },
      {
        chinese: "面对突如其来的技术故障，工程师提出了两种可行的解决办法。",
        pinyin: "Miànduì tūrúqílái de jìshù gùzhàng, gōngchéngshī tíchū le liǎng zhǒng kěxíng de jiějué bànfǎ.",
        translation_vi: "Đối mặt với sự cố kỹ thuật đột xuất, kỹ sư đã đề xuất hai loại biện pháp giải quyết khả thi.",
        explanation: "\"两种...办法\" phân loại biện pháp xử lý."
      }
    ]
  },
  {
    order_index: 10,
    name: "Lượng từ vật có cán / nắm tay \"把\" (Chiếc / Cây / Con)",
    pattern: "Số từ + 把 + Ô (伞) / Dao (刀) / Ghế (椅子) / Thìa (勺子)",
    category: "Lượng từ",
    explanation_vi: "\"把\" (bǎ) là lượng từ dùng cho các dụng cụ, đồ vật có cán cầm, chuôi nắm như chiếc ô (一把伞), con dao (一把刀), chiếc ghế dựa (一把椅子), cái thìa (一把勺子). Ngoài ra còn chỉ nắm tay (một nắm: 一把米).",
    examples: [
      {
        chinese: "出门前看到天气阴沉沉的，母亲特意递给我一把结实的雨伞。",
        pinyin: "Chūmén qián kàn dào tiānqì yīnchénchén de, mǔqīn tèyì dì gěi wǒ yì bǎ jiēshi de yǔsǎn.",
        translation_vi: "Trước khi ra khỏi cửa thấy trời râm u ám, người mẹ đã đặc biệt đưa cho tôi một chiếc ô chắc chắn.",
        explanation: "\"一把...雨伞\" là lượng từ tiêu chuẩn dùng cho ô dù có cán cầm."
      },
      {
        chinese: "会议室里整齐地摆放着二十把舒适崭新的办公椅子。",
        pinyin: "Huìyìshì lǐ zhěngqí de bǎifàng zhe èrshí bǎ shūshì zhǎnxīn de bàngōng yǐzi.",
        translation_vi: "Trong phòng họp đang bày biện ngay ngắn hai mươi chiếc ghế văn phòng mới toanh êm ái.",
        explanation: "\"二十把...椅子\" dùng cho ghế ngồi có tay vịn/tựa."
      }
    ]
  },
  {
    order_index: 11,
    name: "Lượng từ tài liệu / phần ăn \"份\" (Bản / Phần / Suất)",
    pattern: "Số từ + 份 + Báo chí (报纸) / Hồ sơ (材料) / Bữa ăn (外卖)",
    category: "Lượng từ",
    explanation_vi: "\"份\" (fèn) là lượng từ dùng cho các văn bản tài liệu được in ấn theo bản/bộ (một tờ báo: 一份报纸, một bản báo cáo: 一份报告), phần ăn suất ăn (một suất cơm: 一份午饭), hoặc công việc tình cảm (một công việc: 一份工作, một tấm lòng: 一份心意).",
    examples: [
      {
        chinese: "他在求职招聘网站上向知名外资企业投递了一份详尽的个人简历。",
        pinyin: "Tā zài qiúzhí zhāopìn wǎngzhàn shang xiàng zhīmíng wàizī qǐyè tóudì le yí fèn xiángjìn de gèrén jiǎnlì.",
        translation_vi: "Anh ấy trên trang web tuyển dụng việc làm đã nộp một bản sơ yếu lý lịch cá nhân chi tiết tới doanh nghiệp có vốn đầu tư nước ngoài danh tiếng.",
        explanation: "\"一份...简历\" lượng từ cho bản sơ yếu lý lịch."
      },
      {
        chinese: "中午下班后，同事们在写字楼下各自订了一份热气腾腾的营养快餐。",
        pinyin: "Zhōngwǔ xiàbān hòu, tóngshì men zài xiězìlóu xià gèzì dìng le yí fèn rèqì-téngténg de yíngyǎng kuàicān.",
        translation_vi: "Buổi trưa sau khi tan sở, các đồng nghiệp dưới chân tòa nhà văn phòng ai nấy đều đặt một suất cơm nhanh dinh dưỡng nóng hổi.",
        explanation: "\"一份...快餐\" lượng từ cho suất ăn nhanh."
      }
    ]
  },
  {
    order_index: 12,
    name: "Lượng từ thư từ / điện tín \"封\" (Bức / Lá)",
    pattern: "Số từ + 封 + Thư (信) / Email (电子邮件)",
    category: "Lượng từ",
    explanation_vi: "\"封\" (fēng) là lượng từ chuyên dụng dùng cho thư từ, thư điện tử có niêm phong đóng gói (một bức thư: 一封信, một email: 一封电子邮件).",
    examples: [
      {
        chinese: "远在大洋彼岸的海外留学生给父母寄来了一封长长的深情家书。",
        pinyin: "Yuǎn zài dàyáng-bǐ'àn de hǎiwài liúxuéshēng gěi fùmǔ jì lái le yì fēng chángcháng de shēnqíng jiāshū.",
        translation_vi: "Người bạn du học sinh ở bờ bên kia đại dương xa xôi đã gửi về cho cha mẹ một bức thư nhà dài chan chứa thâm tình.",
        explanation: "\"一封...家书\" dùng cho lá thư gia đình."
      },
      {
        chinese: "人力资源部门今早给每一位通过初试的求职者发送了一封复试通知。",
        pinyin: "Rénlì zīyuán bùmén jīnzǎo gěi měi yí wèi tōngguò chūshì de qiúzhízhě fāsòng le yì fēng fùshì tōngzhī.",
        translation_vi: "Phòng nhân sự sáng nay đã gửi một bức thông báo thi vòng hai tới mỗi ứng viên vượt qua vòng sơ tuyển.",
        explanation: "\"一封...通知\" dùng cho bức thông báo gửi qua email."
      }
    ]
  },
  {
    order_index: 13,
    name: "Lượng từ bài viết / bài báo \"篇\" (Bài / Thiên)",
    pattern: "Số từ + 篇 + Bài văn (文章) / Bài báo (报道) / Luận văn (论文)",
    category: "Lượng từ",
    explanation_vi: "\"篇\" (piān) là lượng từ dùng cho bài văn, bài báo, bài viết hoặc luận văn học thuật có kết cấu hoàn chỉnh (một bài văn: 一篇文章, một bài báo: 一篇报道, một bài luận: 一篇论文).",
    examples: [
      {
        chinese: "这位青年学者在国际著名权威期刊上发表了一篇高水平的学术论文。",
        pinyin: "Zhè wèi qīngnián xuézhě zài guójì zhùmíng quánwēi qīkān shang fābiǎo le yì piān gāo shuǐpíng de xuéshù lùnwén.",
        translation_vi: "Học giả trẻ này đã công bố một bài luận văn học thuật trình độ cao trên tạp chí uy tín nổi tiếng quốc tế.",
        explanation: "\"一篇...论文\" lượng từ cho bài luận văn khoa học."
      },
      {
        chinese: "语文老师要求每个学生在周末认真阅读并背诵一篇古典抒情散文。",
        pinyin: "Yǔwén lǎoshī yāoqiú měi gè xuésheng zài zhōumò rènzhēn yuèdú bìng bèisòng yì piān gǔdiǎn shūqíng sǎnwén.",
        translation_vi: "Thầy giáo ngữ văn yêu cầu mỗi học sinh vào dịp cuối tuần cần chăm chú đọc và học thuộc một bài tản văn trữ tình cổ điển.",
        explanation: "\"一篇...散文\" lượng từ cho bài tản văn."
      }
    ]
  },

  // --- NHÓM 4: PHÓ TỪ MỨC ĐỘ & THỜI GIAN (程度与时间副词) ---
  {
    order_index: 14,
    name: "Phó từ mức độ tột đỉnh \"极 / 极其\" (Cực kỳ / Vô cùng)",
    pattern: "Tính từ + 极了! / 极其 + Tính từ / Cụm động từ",
    category: "Phó từ",
    explanation_vi: "Khi làm bổ ngữ mức độ, \"极\" đứng sau tính từ theo cấu trúc \"...极了\" (vui mừng khôn xiết: 高兴极了). Khi làm phó từ đứng trước tính từ hoặc động từ tâm lý, thường dùng song âm tiết \"极其\" (cực kỳ quan trọng: 极其重要).",
    examples: [
      {
        chinese: "得知国家队在决赛中逆转夺得冠军的消息，全体球迷高兴极了！",
        pinyin: "Dézhī guójiāduì zài juésài zhōng nìzhuǎn duó dé guànjūn de xiāoxi, quántǐ qiúmǐ gāoxìng jí le!",
        translation_vi: "Hay tin đội tuyển quốc gia lội ngược dòng đoạt chức vô địch trong trận chung kết, toàn thể người hâm mộ bóng đá vui mừng khôn xiết!",
        explanation: "\"高兴极了\" biểu thị niềm vui đạt đến đỉnh điểm tuyệt đối."
      },
      {
        chinese: "保护生物多样性对维系全球生态平衡具有极其重要的深远意义。",
        pinyin: "Bǎohù shēngwù duōyàngxìng duì wéixì quánqiú shēngtài pínghéng jùyǒu jíqí zhòngyào de shēnyuǎn yìyì.",
        translation_vi: "Bảo vệ sự đa dạng sinh học có ý nghĩa sâu xa cực kỳ quan trọng đối với việc duy trì cân bằng sinh thái toàn cầu.",
        explanation: "\"极其重要\" trạng ngữ chỉ mức độ quan trọng tột bậc."
      }
    ]
  },
  {
    order_index: 15,
    name: "Phó từ mức độ nhẹ \"稍微 / 稍\" (Hơi / Một chút)",
    pattern: "稍微 (+ 一点儿) + Tính từ / 稍微 + Động từ + 一下",
    category: "Phó từ",
    explanation_vi: "\"稍微\" (shāowēi) biểu thị số lượng ít hoặc mức độ nhẹ (hơi, một chút, một lát). Phía sau thường kết hợp với \"一点儿\", \"一些\" hoặc động từ mang \"一下\". Khác với \"有点儿\" (thường mang sắc thái tiêu cực), \"稍微\" mang tính khách quan trung tính.",
    examples: [
      {
        chinese: "这件羊毛大衣的袖子稍微有一点儿长，请裁缝师傅帮忙改短一些。",
        pinyin: "Zhè jiàn yángmáo dàyī de xiùzi shāowēi yǒu yìdiǎnr cháng, qǐng cáifeng shīfu bāngmáng gǎi duǎn yìxiē.",
        translation_vi: "Ống tay của chiếc áo khoác dạ len này hơi dài một chút, xin nhờ bác thợ may sửa ngắn bớt một tẹo.",
        explanation: "\"稍微有一点儿长\" miêu tả độ dài hơi chênh lệch một chút."
      },
      {
        chinese: "请各位来宾在候车大厅稍微休息一下，列车马上进站检票。",
        pinyin: "Qǐng gèwèi láibīn zài hòuchē dàtīng shāowēi xiūxi yíxià, lièchē mǎshàng jìn zhàn jiǎnpiào.",
        translation_vi: "Mời quý khách nghỉ ngơi một chút ở sảnh chờ, đoàn tàu sẽ vào ga soát vé ngay thôi.",
        explanation: "\"稍微休息一下\" đề nghị nghỉ ngơi chốc lát."
      }
    ]
  },
  {
    order_index: 16,
    name: "Phó từ giới hạn tiệm cận \"几乎\" (Hầu như / Suýt nữa)",
    pattern: "几乎 + 都 / 没 / Tính từ / Động từ",
    category: "Phó từ",
    explanation_vi: "\"几乎\" (jīhū) biểu thị trạng thái vô cùng tiếp cận với toàn bộ hoặc suýt soát xảy ra nhưng thực tế chưa xảy ra (hầu như, gần như, suýt nữa).",
    examples: [
      {
        chinese: "经过一个学期的刻苦攻读，全班同学几乎都顺利通过了汉语水平考试。",
        pinyin: "Jīngguò yí gè xuéqī de kèkǔ gōngdú, quán bān tóngxué jīhū dōu shùnlì tōngguò le hànyǔ shuǐpíng kǎoshì.",
        translation_vi: "Trải qua một học kỳ miệt mài dùi mài, học sinh cả lớp hầu như đều đã thuận lợi thi đỗ kỳ thi năng lực Hán ngữ.",
        explanation: "\"几乎都\" nhấn mạnh tỷ lệ đỗ đạt tiếp cận 100%."
      },
      {
        chinese: "路面结冰太滑，他刚才在台阶上走得太急，几乎滑倒在地上。",
        pinyin: "Lùmiàn jiébīng tài huá, tā gāngcái zài táijiē shang zǒu de tài jí, jīhū huádǎo zài dì shang.",
        translation_vi: "Mặt đường đóng băng trơn quá, ban nãy anh ấy bước quá vội trên bậc thang suýt nữa trượt ngã xuống đất.",
        explanation: "\"几乎滑倒\" biểu thị suýt ngã nhưng chưa ngã."
      }
    ]
  },
  {
    order_index: 17,
    name: "Phó từ biến đổi tuần tự \"逐渐 / 渐渐\" (Dần dần / Từng bước)",
    pattern: "逐渐 / 渐渐 + Động từ / Tính từ (+ 起来 / 了)",
    category: "Phó từ",
    explanation_vi: "\"逐渐\" (zhújiàn) biểu thị mức độ hoặc số lượng phát triển theo từng bước, diễn tiến từ từ theo thời gian (dần dần, từng bước một). Thường dùng trong văn viết, văn cảnh trang trọng.",
    examples: [
      {
        chinese: "随着春天悄然来临，冰封的大地和山川河谷开始逐渐融化生机盎然。",
        pinyin: "Suízhe chūntiān qiǎorán láilín, bīngfēng de dàdì hé shānchuān hégǔ kāishǐ zhújiàn rónghuà shēngjī-àngrán.",
        translation_vi: "Cùng với mùa xuân lặng lẽ đến, đất trời và sông núi thung lũng đóng băng bắt đầu dần dần tan chảy tràn trề sức sống.",
        explanation: "\"逐渐融化\" miêu tả quá trình tan băng diễn ra tuần tự từng ngày."
      },
      {
        chinese: "经过几个月的临床药物治疗，患者的各项身体生理指标逐渐恢复正常。",
        pinyin: "Jīngguò jǐ gè yuè de línchuáng yàowù zhìliáo, huànzhě de gè xiàng shēntǐ shēnglǐ zhǐbiāo zhújiàn huīfù zhèngcháng.",
        translation_vi: "Trải qua vài tháng điều trị thuốc lâm sàng, các chỉ số sinh lý cơ thể của bệnh nhân dần dần khôi phục bình thường.",
        explanation: "\"逐渐恢复\" chỉ sự phục hồi sức khỏe từng bước một."
      }
    ]
  },
  {
    order_index: 18,
    name: "Phó từ tương hỗ đa phương \"互相\" (Lẫn nhau / Tương hỗ)",
    pattern: "互相 + Động từ song âm tiết (帮助 / 学习 / 尊重 / 理解)",
    category: "Phó từ",
    explanation_vi: "\"互相\" (hùxiāng) biểu thị hai bên hoặc nhiều bên cùng tác động qua lại lẫn nhau với cùng một hành động (lẫn nhau, cùng nhau). Động từ theo sau thường là động từ song âm tiết.",
    examples: [
      {
        chinese: "不同文化背景的留学生生活在一起，应当互相尊重、互相包容。",
        pinyin: "Bùtóng wénhuà bèijǐng de liúxuéshēng shēnghuó zài yìqǐ, yīngdāng hùxiāng zūnzhòng, hùxiāng bāoróng.",
        translation_vi: "Các lưu học sinh có bối cảnh văn hóa khác nhau khi sống cùng nhau nên tôn trọng lẫn nhau, bao dung lẫn nhau.",
        explanation: "\"互相尊重\" thể hiện hành vi tôn trọng hai chiều qua lại."
      },
      {
        chinese: "同学们在日常学习中经常互相帮助，共同解决学习中的疑难问题。",
        pinyin: "Tóngxué men zài rìcháng xuéxí zhōng jīngcháng hùxiāng bāngzhù, gòngtóng jiějué xuéxí zhōng de yínán wèntí.",
        translation_vi: "Các bạn học sinh trong học tập hằng ngày thường xuyên giúp đỡ lẫn nhau, cùng nhau giải quyết các bài toán khó khăn.",
        explanation: "\"互相帮助\" chỉ sự tương trợ qua lại giữa bạn bè."
      }
    ]
  },
  {
    order_index: 19,
    name: "Phó từ truy cứu đến cùng \"到底 / 究竟\" (Rốt cuộc / Cuối cùng)",
    pattern: "到底 / 究竟 + Từ để hỏi / Vị ngữ nghi vấn?",
    category: "Phó từ",
    explanation_vi: "\"到底\" (dàodǐ) hoặc \"究竟\" (jiūjìng) đứng trước đại từ nghi vấn hoặc vị ngữ trong câu hỏi để thể hiện ngữ khí truy hỏi ráo riết đến cùng (rốt cuộc, rốt cuộc là thế nào). Ngoài ra \"到底\" còn chỉ kết quả cuối cùng trong câu trần thuật.",
    examples: [
      {
        chinese: "明天早晨的学术专题报告会到底是在几点钟正式开始？",
        pinyin: "Míngtiān zǎochén de xuéshù zhuāntí bàogàohuì dàodǐ shì zài jǐ diǎn zhōng zhèngshì kāishǐ?",
        translation_vi: "Buổi báo cáo chuyên đề học thuật sáng mai rốt cuộc là mấy giờ chính thức bắt đầu?",
        explanation: "\"到底是在几点\" tăng cường ngữ khí truy hỏi thời gian chính xác."
      },
      {
        chinese: "经过长达五年的艰苦联合技术攻坚，这个国家级重大科研项目到底成功了！",
        pinyin: "Jīngguò chángdá wǔ nián de jiānkǔ liánhé jìshù gōngjiān, zhè gè guójiājí zhòngdà kēyán xiàngmù dàodǐ chénggōng le!",
        translation_vi: "Trải qua suốt năm năm phối hợp công phá kỹ thuật gian khổ, dự án nghiên cứu khoa học trọng đại cấp quốc gia này cuối cùng cũng đã thành công!",
        explanation: "\"到底成功了\" chỉ kết quả đạt được sau nỗ lực dài lâu trong câu trần thuật."
      }
    ]
  },
  {
    order_index: 20,
    name: "Phó từ thời gian vừa mới xảy ra \"刚 / 刚才\" (Vừa / Vừa mới)",
    pattern: "刚 + Động từ (Phó từ) / 刚才 + Vị ngữ (Danh từ chỉ thời gian)",
    category: "Phó từ",
    explanation_vi: "Phân biệt \"刚\" và \"刚才\": \"刚\" là phó từ chỉ hành động vừa mới xảy ra cách đây chốc lát, đứng ngay trước động từ (như: 我刚来); còn \"刚才\" là danh từ thời gian chỉ thời điểm vài phút trước, có thể đứng trước hoặc sau chủ ngữ (như: 刚才我去开会 / 我刚才去开会).",
    examples: [
      {
        chinese: "列车刚进站停稳，旅客们就井然有序地排队准备检票出站。",
        pinyin: "Lièchē gāng jìn zhàn tíng wěn, lǚkè men jiù jǐngrán-yǒuxù de páiduì zhǔnbèi jiǎnpiào chū zhàn.",
        translation_vi: "Đoàn tàu vừa mới vào ga đỗ ngay ngắn, các hành khách liền trật tự xếp hàng chuẩn bị soát vé ra ga.",
        explanation: "\"刚进站\" phó từ \"刚\" đứng trước động từ chỉ sự việc vừa mới xong."
      },
      {
        chinese: "刚才在走廊里和你热情打招呼的那位老教授是谁？",
        pinyin: "Gāngcái zài zǒuláng lǐ hé nǐ rèqíng dǎ zhāohu de nà wèi lǎo jiàoshòu shì shéi?",
        translation_vi: "Vị giáo sư già vừa nãy ở hành lang nhiệt tình chào hỏi bạn là ai thế?",
        explanation: "\"刚才\" danh từ thời gian chỉ thời điểm ban nãy."
      }
    ]
  },
  {
    order_index: 21,
    name: "Phó từ thời gian đột ngột \"突然\" (Đột nhiên / Bất ngờ)",
    pattern: "突然 + Động từ / Cụm chủ vị (Trạng ngữ) / Rất + 突然 (Vị ngữ)",
    category: "Phó từ",
    explanation_vi: "\"突然\" (tūrán) biểu thị sự việc phát sinh bất ngờ, mau lẹ ngoài dự liệu (đột nhiên, bất thình lình). Vừa có thể làm trạng ngữ đứng trước động từ, vừa có thể làm hình dung từ làm vị ngữ.",
    examples: [
      {
        chinese: "我们正走在回家的路上，天空中突然电闪雷鸣下起了倾盆暴雨。",
        pinyin: "Wǒmen zhèng zǒu zài huíjiā de lù shang, tiānkōng zhōng tūrán diànshǎn-léimíng xià qǐ le qīngpén bàoyǔ.",
        translation_vi: "Chúng tôi đang đi trên đường về nhà, trên bầu trời đột nhiên chớp giật sấm rền đổ xuống cơn mưa rào như trút nước.",
        explanation: "\"突然...下起\" làm trạng ngữ miêu tả sự xuất hiện bất ngờ của cơn mưa."
      },
      {
        chinese: "这个突发交通事故发生得太突然了，在场的所有人都惊呆了。",
        pinyin: "Zhè gè tūfā jiāotōng shìgù fāshēng de tài tūrán le, zàichǎng de suǒyǒu rén dōu jīngdāi le.",
        translation_vi: "Vụ tai nạn giao thông đột xuất này xảy ra quá đỗi bất ngờ, toàn thể người có mặt đều sững sờ.",
        explanation: "\"太突然了\" làm bổ ngữ/vị ngữ tính từ chỉ mức độ bất ngờ."
      }
    ]
  },
  {
    order_index: 22,
    name: "Phó từ kiên quyết nhất định \"一定\" (Nhất định / Chắc chắn)",
    pattern: "一定 + Động từ / Tính từ / (不)一定",
    category: "Phó từ",
    explanation_vi: "\"一定\" (yídìng) biểu thị ý chí kiên quyết, sự phán đoán chắc chắn không nghi ngờ (nhất định, chắc chắn). Phủ định là \"不一定\" (chưa chắc, không hẳn).",
    examples: [
      {
        chinese: "只要我们坚持脚踏实地努力拼搏，就一定能够实现心中的梦想。",
        pinyin: "Zhǐyào wǒmen jiānchí jiǎotà-shídì nǔlì pīnbó, jiù yídìng nénggòu shíxiàn xīnzhōng de mèngxiǎng.",
        translation_vi: "Chỉ cần chúng ta kiên trì vững vàng nỗ lực phấn đấu thì nhất định có thể thực hiện được giấc mơ trong lòng.",
        explanation: "\"一定能够\" khẳng định chắc chắn về khả năng thành công."
      },
      {
        chinese: "外表光鲜亮丽的商品，其质量和做工并不一定都非常优良。",
        pinyin: "Wàibiǎo guāngxiān-liànglì de shāngpǐn, qí zhìliàng hé zuògōng bìng bù yídìng dōu fēicháng yōuliáng.",
        translation_vi: "Mặt hàng bề ngoài bóng bẩy lộng lẫy thì chất lượng và gia công chưa hẳn đều rất ưu lương.",
        explanation: "\"不一定\" phủ định sự tất yếu tuyệt đối."
      }
    ]
  },
  {
    order_index: 23,
    name: "Phó từ tiếp tục tiến thêm một bước \"越发 / 更加\" (Càng / Càng thêm)",
    pattern: "更加 / 越发 + Tính từ / Cụm động từ tâm lý",
    category: "Phó từ",
    explanation_vi: "\"更加\" (gèngjiā) hoặc \"越发\" (yuèfā) đứng trước tính từ hoặc động từ tâm lý biểu thị mức độ phát triển cao hơn một bậc trên nền tảng sẵn có (càng thêm, càng... hơn nữa).",
    examples: [
      {
        chinese: "秋雨过后，漫山遍野枫树林的红叶显得更加鲜艳夺目。",
        pinyin: "Qiūyǔ guòhòu, mànshān-biànyě fēngshùlín de hóngyè xiǎnde gèngjiā xiānyàn duómù.",
        translation_vi: "Sau cơn mưa thu, lá đỏ rừng phong khắp núi rừng lại càng thêm tươi thắm rực rỡ bắt mắt.",
        explanation: "\"更加鲜艳\" biểu thị mức độ tươi thắm tăng thêm một bậc sau mưa."
      },
      {
        chinese: "听到恩师充满期许的真诚鼓励，他心中越发坚定了求学的信念。",
        pinyin: "Tīng dào ēnshī chōngmǎn qīxǔ de zhēnchéng gǔlì, tā xīnzhōng yuèfā jiāndìng le qiúxué de xìnniàn.",
        translation_vi: "Nghe lời khích lệ chân thành tràn đầy kỳ vọng của thầy ơn, trong lòng anh càng thêm kiên định niềm tin theo đuổi học vấn.",
        explanation: "\"越发坚定\" nhấn mạnh niềm tin trở nên vững chắc hơn."
      }
    ]
  },
  {
    order_index: 24,
    name: "Phó từ phạm vi hạn định \"一共 / 总共\" (Tổng cộng / Tất cả)",
    pattern: "一共 / 总共 + Số lượng từ / Vị ngữ",
    category: "Phó từ",
    explanation_vi: "\"一共\" (yígòng) hoặc \"总共\" (zǒnggòng) đứng trước cụm số từ hoặc vị ngữ để biểu thị tổng số lượng gộp lại của các khoản mục, số người hoặc chi phí (tổng cộng, tất cả gồm có).",
    examples: [
      {
        chinese: "参加今天全校春季长跑越野赛的师生运动员一共有五百余人。",
        pinyin: "Cānjiā jīntiān quán xiào chūnjì chángpǎo yuèyěsài de shīshēng yùndòngyuán yígòng yǒu wǔbǎi yú rén.",
        translation_vi: "Các thầy trò vận động viên tham gia giải chạy việt dã mùa xuân toàn trường hôm nay tổng cộng có hơn năm trăm người.",
        explanation: "\"一共有\" tổng kết toàn bộ số lượng vận động viên tham gia."
      },
      {
        chinese: "买这些专业汉语教材和学习用品，总共花费了三百五十块钱。",
        pinyin: "Mǎi zhèxiē zhuānyè hànyǔ jiàocái hé xuéxí yòngpǐn, zǒnggòng huāfèi le sānbǎi wǔshí kuài qián.",
        translation_vi: "Mua những cuốn giáo trình Hán ngữ chuyên ngành và đồ dùng học tập này, tổng cộng tiêu tốn hết ba trăm năm mươi tệ.",
        explanation: "\"总共花费\" gộp toàn bộ chi phí mua sắm."
      }
    ]
  },
  {
    order_index: 25,
    name: "Phó từ giới hạn duy nhất \"只 / 仅仅\" (Chỉ / Chỉ có)",
    pattern: "只 / 仅仅 + Động từ / Số lượng từ",
    category: "Phó từ",
    explanation_vi: "\"只\" (zhǐ) là phó từ phạm vi đứng trước động từ để biểu thị sự hạn định duy nhất vào một đối tượng, hành vi hoặc phạm vi nhỏ (chỉ, chỉ có). Văn viết trang trọng dùng \"仅仅\".",
    examples: [
      {
        chinese: "整间宽敞的自习室里非常安静，只听见翻阅书页的沙沙声。",
        pinyin: "Zhěng jiān kuānchǎng de zìxíshì lǐ fēicháng ānjìng, zhǐ tīngjiàn fānyuè shūyè de shāshā shēng.",
        translation_vi: "Bên trong cả phòng tự học rộng rãi vô cùng yên tĩnh, chỉ nghe thấy tiếng lật trang sách xào xạc.",
        explanation: "\"只听见\" hạn định duy nhất âm thanh lật sách."
      },
      {
        chinese: "他今天早晨因为匆忙出门，只吃了一片烤面包就去上班了。",
        pinyin: "Tā jīntiān zǎochén yīnwèi cōngmáng chūmén, zhǐ chī le yí piàn kǎo miànbāo jiù qù shàngbān le.",
        translation_vi: "Sáng nay vì vội vàng ra khỏi cửa, anh ấy chỉ ăn một lát bánh mì nướng là đi làm rồi.",
        explanation: "\"只吃了一片\" giới hạn lượng thức ăn ít ỏi."
      }
    ]
  },
  {
    order_index: 26,
    name: "Phó từ xác nhận hiển nhiên \"当然\" (Đương nhiên / Dĩ nhiên)",
    pattern: "当然 + Động từ / Tính từ / 当然可以!",
    category: "Phó từ",
    explanation_vi: "\"当然\" (dāngrán) biểu thị sự việc là hợp lý, hiển nhiên không cần nghi ngờ hoặc dùng trong lời đáp để biểu thị sự đồng ý nhiệt tình, quả quyết (đương nhiên, dĩ nhiên).",
    examples: [
      {
        chinese: "只要你平时付出足够的辛勤汗水，期末考试当然能取得好成绩。",
        pinyin: "Zhǐyào nǐ píngrì fùchū zúgòu de xīnqín hànshuǐ, qīmò kǎoshì dāngrán néng qǔdé hǎo chéngjì.",
        translation_vi: "Chỉ cần ngày thường bạn bỏ ra đầy đủ mồ hôi công sức, kỳ thi cuối kỳ đương nhiên có thể đạt thành tích tốt.",
        explanation: "\"当然能\" khẳng định kết quả hiển nhiên theo quy luật nhân quả."
      },
      {
        chinese: "“我可以在这里借阅这本汉语字典吗？”——“当然可以，请便！”",
        pinyin: "“Wǒ kěyǐ zài zhèlǐ jièyuè zhè běn hànyǔ zìdiǎn ma?” —— “Dāngrán kěyǐ, qǐng biàn!”",
        translation_vi: "“Tôi có thể mượn đọc cuốn từ điển tiếng Hán này ở đây được không?” —— “Đương nhiên được chứ, xin cứ tự nhiên!”",
        explanation: "\"当然可以\" lời đáp biểu thị sự đồng ý dứt khoát vui vẻ."
      }
    ]
  }
];
