-- ==============================================================================
-- MIGRATION: 20261024050000_hsk5_grammar_110_seed.sql
-- NẠP 110 ĐIỂM NGỮ PHÁP HSK 5 KÈM 220 CÂU VÍ DỤ CHUẨN GF 0025-2021 (APPENDIX A)
-- Có giải thích chi tiết tiếng Việt, công thức pattern, Pinyin có dấu thanh và phân loại chuẩn
-- ==============================================================================

BEGIN;

DO $$
DECLARE
  v_gp_id uuid;
BEGIN

  -- Điểm ngữ pháp #1: Đại từ văn ngôn chỉ định và sở thuộc "其" (Của nó / Trong đó / Họ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ văn ngôn chỉ định và sở thuộc "其" (Của nó / Trong đó / Họ)',
    '其 + Danh từ / 其中 / 其实 / 其余 / 极其 / 莫名其妙',
    'Đại từ',
    '"其" (qí) là đại từ nguồn gốc văn ngôn cổ được sử dụng rộng rãi trong tiếng Trung hiện đại, đặc biệt là văn viết chính luận, khoa học và báo chí. "其" tương đương với "他/她/它的" (của anh ấy/cô ấy/nó) hoặc "他们/它们" (của họ/chúng). Ngoài ra "其" tạo thành nhiều từ ghép cố định tối quan trọng như 其中 (trong đó), 其实 (thực ra), 其余 (phần còn lại), 极其 (cực kỳ).',
    'HSK 5',
    1,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '任何事物的发展都有其自身的规律，我们不能急于求成。',
      'Rènhé shìwù de fāzhǎn dōu yǒu qí zìshēn de guīlǜ, wǒmen bù néng jíyúqiúchéng.',
      'Sự phát triển của bất kỳ sự vật nào đều có quy luật của chính bản thân nó, chúng ta không thể nôn nóng muốn thành công ngay.',
      '"其自身" tương đương với "它自身" (chính bản thân nó), "其" thay thế cho "事物" tạo sắc thái văn phong triết lý sâu sắc.'
    ),
    (
      v_gp_id,
      '参加本次论坛的专家共有五十位，其中半数来自海外知名院校。',
      'Cānjiā běn cì lùntán de zhuānjiā gòng yǒu wǔshí wèi, qízhōng bànshù láizì hǎiwài zhīmíng yuànxiào.',
      'Có tổng cộng 50 chuyên gia tham dự diễn đàn lần này, trong số đó một nửa đến từ các trường viện nổi tiếng ở nước ngoài.',
      '"其中" (trong số đó) là cụm từ cố định dẫn ra một bộ phận thành viên nằm trong tổng thể 50 chuyên gia.'
    );

  -- Điểm ngữ pháp #2: Đại từ nghi vấn văn ngôn phản vấn "何" (Gì / Thế nào / Sao)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ nghi vấn văn ngôn phản vấn "何" (Gì / Thế nào / Sao)',
    '何 + Động từ/Danh từ (何必 / 何况 / 何在 / 何尝 / 为何 / 任何)',
    'Đại từ',
    '"何" (hé) là đại từ nghi vấn văn ngôn tương đương với "什么" (cái gì), "为什么" (tại sao) hoặc "怎么" (thế nào). Trong tiếng Trung hiện đại HSK 5, "何" thường xuất hiện trong các kết cấu câu trang trọng hoặc các liên từ, phó từ phản vấn như 何必 (hà tất), 何况 (huống hồ), 为何 (vì sao), 何在 (ở đâu, nằm ở chỗ nào).',
    'HSK 5',
    2,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '面对如此明显的错误事实，你又为何迟迟不肯当面承认呢？',
      'Miànduì rúcǐ míngxiǎn de cuòwù shìshí, nǐ yòu wèihé chíchí bù kěn dāngmiàn chéngrèn ne?',
      'Đối mặt với sự thật sai sót rõ ràng như thế này, cậu lại vì cớ gì mà cứ chần chừ không chịu thừa nhận trước mặt chứ?',
      '"为何" là cách diễn đạt trang trọng của "为什么", biểu thị ngữ khí chất vấn nghiêm túc.'
    ),
    (
      v_gp_id,
      '企业要想在激烈的市场中立足，其核心竞争力究竟何在？',
      'Qǐyè yào xiǎng zài jīliè de shìchǎng zhōng lìzú, qí héxīn jìngzhēnglì jiūjìng hézài?',
      'Doanh nghiệp muốn đứng vững trong thị trường cạnh tranh khốc liệt, sức cạnh tranh cốt lõi của nó rốt cuộc nằm ở đâu?',
      '"何在" tương đương với "在哪里" (nằm ở nơi đâu), đặt ra câu hỏi bản chất về năng lực cạnh tranh.'
    );

  -- Điểm ngữ pháp #3: Đại từ nhân xưng xưng hô trang trọng tập thể "诸位" (Chư vị / Các vị)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ nhân xưng xưng hô trang trọng tập thể "诸位" (Chư vị / Các vị)',
    '诸位 + (Danh từ xưng hô) / 诸位 + Xin hãy...',
    'Đại từ',
    '"诸位" (zhūwèi) là đại từ nhân xưng ngôi thứ hai số nhiều mang sắc thái vô cùng lịch thiệp, trang trọng (chư vị, các vị, quý vị). Thường được các diễn giả, người chủ trì hoặc lãnh đạo sử dụng khi mở đầu bài phát biểu, diễn thuyết trước cử tọa (như 诸位来宾, 诸位同事, 诸位朋友).',
    'HSK 5',
    3,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '非常荣幸能与诸位专家学者共同探讨人工智能的未来趋势。',
      'Fēicháng róngxìng néng yǔ zhūwèi zhuānjiā xuézhě gòngtóng tàntǎo réngōng zhìnéng de wèilái qūshì.',
      'Vô cùng vinh hạnh khi được cùng chư vị chuyên gia học giả thảo luận về xu thế tương lai của trí tuệ nhân tạo.',
      '"诸位专家学者" là cách xưng hô kính cẩn của diễn giả trước đông đảo các nhà khoa học.'
    ),
    (
      v_gp_id,
      '诸位请安静，今天的新闻发布会马上就要正式开始了。',
      'Zhūwèi qǐng ānjìng, jīntiān de xīnwén fābùhuì mǎshàng jiù yào zhèngshì kāishǐ le.',
      'Xin chư vị hãy giữ trật tự, buổi họp báo tin tức hôm nay sắp sửa chính thức bắt đầu rồi.',
      '"诸位请安静" dùng đại từ xưng hô trang trọng để thu hút sự chú ý của toàn thể phóng viên trong khán phòng.'
    );

  -- Điểm ngữ pháp #4: Đại từ văn ngôn phiếm chỉ bao quát "凡" (Phàm là / Hễ là / Toàn bộ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ văn ngôn phiếm chỉ bao quát "凡" (Phàm là / Hễ là / Toàn bộ)',
    '凡 + Danh từ/Mệnh đề, 皆 / 都 + Vị ngữ / 凡事 / 大凡',
    'Đại từ',
    '"凡" (fán) là đại từ phiếm chỉ bắt nguồn từ văn ngôn mang nghĩa "phàm là, hễ là, tất cả những ai/cái gì thuộc phạm vi đó". Trong HSK 5, "凡" thường kết hợp với "皆" (jiē - đều) trong văn cổ ngữ, hoặc kết hợp với "都" trong văn viết hiện đại, tạo nên các thành ngữ như "凡事" (mọi việc), "大凡" (đại phàm).',
    'HSK 5',
    4,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '凡事预则立，不预则废，做任何工作都需要提前做好充分准备。',
      'Fánshì yù zé lì, bú yù zé fèi, zuò rènhé gōngzuò dōu xūyào tíqián zuò hǎo chōngfèn zhǔnbèi.',
      'Phàm mọi việc có chuẩn bị trước thì ắt thành công, không chuẩn bị trước thì ắt thất bại, làm bất kỳ công việc gì cũng cần chuẩn bị chu đáo trước.',
      '"凡事" nghĩa là mọi việc, trích từ câu châm ngôn kinh điển nhấn mạnh tầm quan trọng của sự chuẩn bị.'
    ),
    (
      v_gp_id,
      '凡涉及国家机密的重要文件，一律不得通过公共互联网传输。',
      'Fán shèjí guójiā jīmì de zhòngyào wénjiàn, yílǜ bùdé tōngguò gōnggòng hùliánwǎng chuānshū.',
      'Phàm là tài liệu quan trọng liên quan đến bí mật quốc gia, nhất loạt không được truyền qua mạng internet công cộng.',
      '"凡涉及..." bao quát toàn bộ tài liệu cơ mật theo quy định bảo mật an ninh thông tin.'
    );

  -- Điểm ngữ pháp #5: Số từ văn ngôn chỉ tỉ lệ mười phần "成" (Phần mười / 10%)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Số từ văn ngôn chỉ tỉ lệ mười phần "成" (Phần mười / 10%)',
    'Số từ + 成 (三成 = 30% / 七成 = 70% / 九成 / 几成)',
    'Số từ',
    '"成" (chéng) trong lĩnh vực kinh tế, tài chính và phân tích xã hội biểu thị đơn vị một phần mười (tương đương 10%). Ví dụ: 一成 = 10%, 三成 = 30%, 八成 = 80%. Ngoài ra, trong khẩu ngữ "八成" hoặc "九成" còn làm phó từ mang nghĩa "chắc chắn đến tám chín phần mười, khả năng rất cao".',
    'HSK 5',
    5,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '今年我国新能源汽车的市场占有率已经成功突破了三成。',
      'Jīnnián wǒ guó xīn néngyuán qìchē de shìchǎng zhànyǒulǜ yǐjīng chénggōng tūpò le sān chéng.',
      'Năm nay thị phần xe ô tô năng lượng mới của nước ta đã thành công vượt mốc 30% (ba phần mười).',
      '"三成" chỉ tỉ lệ 30% thị phần tiêu thụ trong phân tích kinh tế vĩ mô.'
    ),
    (
      v_gp_id,
      '看他今天满面春风的样子，这次面试八成是顺利通过了。',
      'Kàn tā jīntiān mǎnmiànchūnfēng de yàngzi, zhè cì miànshì bāchéng shì shùnlì tōngguò le.',
      'Nhìn vẻ mặt hớn hở tràn đầy sức sống của anh ấy hôm nay, buổi phỏng vấn lần này đến tám chín phần mười là đã trót lọt đỗ rồi.',
      '"八成" ở đây đóng vai trò ước lượng xác suất cao (khoảng 80–90%) trong nhận định tâm lý.'
    );

  -- Điểm ngữ pháp #6: Số từ phiếm chỉ số lượng không xác định "若干" (Một số / Mấy / Vài)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Số từ phiếm chỉ số lượng không xác định "若干" (Một số / Mấy / Vài)',
    '若干 + (Lượng từ) + Danh từ / 划分为若干部分',
    'Số từ',
    '"若干" (ruògān) là số từ văn viết biểu thị một số lượng không xác định hoặc chưa tiện nêu con số cụ thể (khoảng một vài, một số, mấy). Thường dùng trong các văn kiện pháp quy, điều lệ, đề cương khoa học hoặc hợp đồng kinh tế.',
    'HSK 5',
    6,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '为了便于深入研究，专家组将整个课题细分成了若干个子项目。',
      'Wèile biànyú shēnrù yánjiū, zhuānjiāzǔ jiǎng zhěng gè kètí xìfēn chéng le ruògān gè zǐxiàngmù.',
      'Để tiện cho việc nghiên cứu chuyên sâu, tổ chuyên gia đã chia nhỏ toàn bộ đề tài thành một số dự án nhánh.',
      '"若干个子项目" chỉ một số dự án thành phần được chia tách có hệ thống.'
    ),
    (
      v_gp_id,
      '经过若干年的艰苦奋斗，这片曾经荒凉的戈壁滩变成了绿洲。',
      'Jīngguò ruògān nián de jiānkǔ fèndòu, zhè piàn céngjīng huāngliáng de gēbìtān biànchéng le lǜzhōu.',
      'Sau mấy năm ròng phấn đấu gian khổ, vùng đất sa mạc từng cằn cỗi hoang vu này đã biến thành một ốc đảo xanh tươi.',
      '"若干年" chỉ khoảng thời gian nhiều năm phấn đấu kiên trì không ghi đích danh số năm.'
    );

  -- Điểm ngữ pháp #7: Danh lượng từ chuyên dùng cho luồng khí, sức lực, mùi vị "股" (Luồng / Cơn / Dòng / Món)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chuyên dùng cho luồng khí, sức lực, mùi vị "股" (Luồng / Cơn / Dòng / Món)',
    'Số từ + 股 + Danh từ (力量 / 气味 / 热流 / 暖意 / 热情 / 泉水 / 烟)',
    'Lượng từ',
    '"股" (gǔ) là lượng từ chuyên dùng cho: 1) Các hiện tượng vô hình hoặc chất khí có dòng chảy như mùi hương, luồng nhiệt, khói (一股清香, 一股热浪); 2) Cảm xúc, tinh thần hoặc sức lực bộc phát mạnh mẽ (一股力量, 一股劲儿); 3) Dòng người hoặc nhóm người di chuyển (一股势力, 一股土匪).',
    'HSK 5',
    7,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '走进花园，迎面扑来一股淡淡的茉莉花清香。',
      'Zǒujìn huāyuán, yíngmiàn pūlái yì gǔ dàndàn de mòlìhuā qīngxiāng.',
      'Bước vào hoa viên, phả thẳng vào mặt là một luồng hương hoa nhài thơm mát thoang thoảng.',
      '"一股...清香" dùng "股" định lượng cho dòng hương thơm dịu mát của hoa cỏ.'
    ),
    (
      v_gp_id,
      '看到大家毫无私心的支援，他心头顿时涌起了一股强烈的暖意。',
      'Kàndào dàjiā háowú sīxīn de zhīyuán, tā xīntóu dùnshí yǒngqǐ le yì gǔ qiángliè de nuǎnyì.',
      'Nhìn thấy sự chi viện không chút vụ lợi của mọi người, trong lòng anh ấy lập tức dâng trào một luồng cảm giác ấm áp mãnh liệt.',
      '"一股强烈的暖意" dùng "股" miêu tả dòng cảm xúc ấm áp dạt dào trong tâm khảm.'
    );

  -- Điểm ngữ pháp #8: Danh lượng từ & động lượng từ chỉ đợt, cơn ngắn "阵" (Cơn / Trận / Đợt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ & động lượng từ chỉ đợt, cơn ngắn "阵" (Cơn / Trận / Đợt)',
    '一 + 阵 + Danh từ (雨 / 风 / 掌声 / 欢呼声 / 剧痛) / 一阵阵',
    'Lượng từ',
    '"阵" (zhèn) biểu thị một khoảng thời gian ngắn hoặc một đợt bộc phát của hành động, hiện tượng tự nhiên hoặc âm thanh diễn ra trong chốc lát rồi ngớt (như 一阵风 - cơn gió, 一阵掌声 - một tràng pháo tay). Dạng trùng điệp "一阵阵" diễn tả các đợt sóng âm thanh hoặc cảm giác nối tiếp nhau dồn dập.',
    'HSK 5',
    8,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '演出结束后，台下立刻爆发出一阵雷鸣般的掌声。',
      'Yǎnchū jiéshù hòu, táixià lìkè bàofā chū yí zhèn léimíng bān de zhǎngshēng.',
      'Sau khi buổi diễn kết thúc, dưới khán đài lập tức bùng nổ một tràng pháo tay rộn rã như sấm rền.',
      '"一阵...掌声" định lượng cho tràng vỗ tay nhiệt liệt bùng lên từ khán giả.'
    ),
    (
      v_gp_id,
      '突然刮来了一阵刺骨的狂风，吹得树枝剧烈摇晃。',
      'Tūrán guālái le yí zhèn cìgǔ de kuángfēng, chuī de shùzhī jùliè yáohuàng.',
      'Đột nhiên một cơn gió lốc buốt xương thổi tới, thổi khiến các cành cây rung lắc dữ dội.',
      '"一阵...狂风" diễn tả cơn gió lốc thổi mạnh đột ngột trong thời gian ngắn.'
    );

  -- Điểm ngữ pháp #9: Danh lượng từ chỉ bó, chùm, tia "束" (Bó / Chùm / Tia)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ bó, chùm, tia "束" (Bó / Chùm / Tia)',
    'Số từ + 束 + Danh từ (花 / 鲜花 / 光 / 阳光 / 激光)',
    'Lượng từ',
    '"束" (shù) dùng cho: 1) Các vật thể được bó lại, buộc túm lại thành chùm (như 一束鲜花 - một bó hoa tươi); 2) Chùm tia sáng tụ lại chiếu theo đường thẳng (như 一束光 - một chùm sáng, 一束阳光 - một tia nắng mặt trời).',
    'HSK 5',
    9,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他手捧着一束美丽的红玫瑰，微笑着走向新娘。',
      'Tā shǒu pěngzhe yí shù měilì de hóng méiguī, wēixiàozhe zǒuxiàng xīnniáng.',
      'Anh ấy hai tay ôm một bó hoa hồng đỏ tươi đẹp, mỉm cười bước về phía cô dâu.',
      '"一束...红玫瑰" dùng "束" chỉ bó hoa cưới được kết trang trọng.'
    ),
    (
      v_gp_id,
      '清晨，一束温暖的阳光穿透窗帘，静静地洒在书桌上。',
      'Qīngchén, yí shù wēnnuǎn de yángguāng chuāntòu chuānglián, jìngjìng de sǎ zài shūzhuō shang.',
      'Sáng sớm, một tia nắng ấm áp xuyên qua rèm cửa sổ, lặng lẽ rọi xuống mặt bàn học.',
      '"一束温暖的阳光" dùng "束" định lượng cho vạt nắng sáng sớm chiếu xuyên qua khe rèm.'
    );

  -- Điểm ngữ pháp #10: Danh lượng từ chỉ xâu, chuỗi liên hoàn "串" (Xâu / Chuỗi / Dãy)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ xâu, chuỗi liên hoàn "串" (Xâu / Chuỗi / Dãy)',
    'Số từ + 串 + Danh từ (钥匙 / 葡萄 / 珍珠 / 数字 / 问号 / 糖葫芦)',
    'Lượng từ',
    '"串" (chuàn) dùng cho các sự vật có cùng chủng loại được xâu nối tiếp liền nhau thành một đường dây (như 一串钥匙 - một chùm chìa khóa, 一串葡萄 - một chùm nho, 一串项链 - một chuỗi dây chuyền). Ngoài ra còn dùng ẩn dụ cho chuỗi trừu tượng (như 一连串问题 - một loạt vấn đề).',
    'HSK 5',
    10,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '奶奶手里提着一串新鲜的紫葡萄，笑盈盈地递给了孙子。',
      'Nǎinai shǒulǐ tízhe yí chuàn xīnxiān de zǐ pútáo, xiàoyíngyíng de dìgěi le sūnzi.',
      'Bà nội tay xách một chùm nho tím tươi ngon, cười tươi đon đả đưa cho cháu trai.',
      '"一串...紫葡萄" dùng "串" chỉ cả chùm quả nho bám tự nhiên trên cuống.'
    ),
    (
      v_gp_id,
      '这一连串突发的严重事故，引起了监管部门的高度警惕。',
      'Zhè yì lián chuàn tūfā de yánzhòng shìgù, yǐnqǐ le jiānguǎn bùmén de gāodù jǐngtì.',
      'Một chuỗi những sự cố nghiêm trọng bộc phát liên tiếp này đã dấy lên sự cảnh giác cao độ của cơ quan giám sát.',
      '"一连串...事故" dùng "串" ẩn dụ cho hàng loạt vụ việc xảy ra liên hoàn dồn dập.'
    );

  -- Điểm ngữ pháp #11: Danh lượng từ chuyên dùng cho hạng mục, công trình, quy định "项" (Hạng mục / Điều)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chuyên dùng cho hạng mục, công trình, quy định "项" (Hạng mục / Điều)',
    'Số từ + 项 + Danh từ (任务 / 技术 / 制度 / 纪录 / 调查 / 研究 / 成果)',
    'Lượng từ',
    '"项" (xiàng) là lượng từ chuyên dùng cho các sự vụ, hạng mục quy mô, điều khoản luật pháp, kế hoạch nghiên cứu, hoặc thành tựu thể thao mang tính phân mục rõ ràng.',
    'HSK 5',
    11,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '科学家们经过多年的探索，成功攻克了这这项重大的核心技术。',
      'Kēxuéjiāmen jīngguò duō nián de tànsuǒ, chénggōng gōngkè le zhè xiàng zhòngdà de héxīn jìshù.',
      'Các nhà khoa học trải qua nhiều năm tìm tòi, đã thành công chinh phục được hạng mục công nghệ cốt lõi trọng đại này.',
      '"这项重大的核心技术" dùng "项" định lượng cho hạng mục công nghệ cấp quốc gia.'
    ),
    (
      v_gp_id,
      '在这届世界田径锦标赛上，他打破了一项尘封二十年的世界纪录。',
      'Zài zhè jiè shìjiè tiánjìng jǐnbiāosài shang, tā dǎpò le yí xiàng chénfēng èrshí nián de shìjiè jìlù.',
      'Tại giải vô địch điền kinh thế giới lần này, anh ấy đã phá vỡ một kỷ lục thế giới bị phủ bụi suốt 20 năm.',
      '"一项...世界纪录" dùng "项" làm lượng từ chuẩn xác cho kỷ lục thể thao thành tích cao.'
    );

  -- Điểm ngữ pháp #12: Danh lượng từ chỉ lô, đợt hàng hóa hoặc tốp người "批" (Lô / Đợt / Tốp)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ lô, đợt hàng hóa hoặc tốp người "批" (Lô / Đợt / Tốp)',
    'Số từ + 批 + Danh từ (货物 / 产品 / 游客 / 学员 / 专家) / 第一批 / 分批',
    'Lượng từ',
    '"批" (pī) biểu thị một tập hợp số lượng lớn hàng hóa, sản phẩm được sản xuất/vận chuyển trong cùng một đợt, hoặc một nhóm đông người được tổ chức xuất phát/huấn luyện theo từng đợt.',
    'HSK 5',
    12,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '海关工作人员正在对刚从欧洲进口的第一批医疗器械进行严格检验。',
      'Hǎiguān gōngzuò rényuán zhèngzài duì gāng cóng Ōuzhōu jìnkǒu de dì yī pī yīliáo qìxiè jìnxíng yángé jiǎnyàn.',
      'Các nhân viên hải quan đang tiến hành kiểm nghiệm nghiêm ngặt lô thiết bị y tế đầu tiên vừa nhập khẩu từ châu Âu.',
      '"第一批医疗器械" chỉ lô hàng hóa thiết bị y tế đợt 1 cập cảng hải quan.'
    ),
    (
      v_gp_id,
      '景区采取了分批进入的限流措施，确保每批游客都能安全游览。',
      'Jǐngqū cǎiqǔ le fēnpī jìnrù de xiànliú cuòshī, quèbǎo měi pī yóukè dōu néng ānquán yóulǎn.',
      'Khu danh lam thắng cảnh đã áp dụng biện pháp hạn chế dòng người theo từng tốp, bảo đảm mỗi tốp du khách đều có thể tham quan an toàn.',
      '"分批进入" và "每批游客" dùng "批" để chỉ từng nhóm đoàn người vào cổng luân phiên.'
    );

  -- Điểm ngữ pháp #13: Danh lượng từ chỉ món tiền, vụ kiện, thương vụ lớn "宗" (Món / Vụ / Loại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ món tiền, vụ kiện, thương vụ lớn "宗" (Món / Vụ / Loại)',
    'Số từ + 宗 + Danh từ (买卖 / 案件 / 交易 / 生意 / 大宗商品)',
    'Lượng từ',
    '"宗" (zōng) là lượng từ kinh tế, thương mại và tư pháp trang trọng, dùng cho các giao dịch quy mô lớn (như 一宗买卖 - một mối làm ăn lớn, 一宗交易 - một vụ giao dịch), hoặc các vụ án tư pháp (一宗案件). Thuật ngữ "大宗商品" chỉ hàng hóa rời nguyên liệu thô số lượng lớn.',
    'HSK 5',
    13,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '两国跨国公司经过艰苦谈判，终于促成了一宗高达十亿美元的重大并购交易。',
      'Liǎng guó kuàguó gōngsī jīngguò jiānkǔ tánpàn, zhōngyú cùchéng le yì zōng gāodá shíyì měiyuán de zhòngdà bìnggòu jiāoyì.',
      'Các công ty đa quốc gia hai nước sau các cuộc đàm phán gian nan, cuối cùng đã thúc đẩy thành công một vụ giao dịch sáp nhập trọng đại lên tới một tỷ đô la Mỹ.',
      '"一宗...并购交易" dùng "宗" định lượng cho thương vụ sáp nhập doanh nghiệp tài chính khổng lồ.'
    ),
    (
      v_gp_id,
      '警方历时三年不懈追踪，成功侦破了这宗性质极其恶劣的跨国诈骗案件。',
      'Jǐngfāng lìshí sān nián búxiè zhuīzōng, chénggōng zhēnpò le zhè zōng xìngzhì jíqí èliè de kuàguó zhàpiàn ànjiàn.',
      'Lực lượng cảnh sát trải qua ba năm truy vết không ngừng nghỉ, đã phá thành công vụ án lừa đảo xuyên quốc gia có tính chất cực kỳ nghiêm trọng này.',
      '"这宗...案件" dùng "宗" làm lượng từ tư pháp chuẩn xác cho vụ án hình sự phức tạp.'
    );

  -- Điểm ngữ pháp #14: Danh lượng từ chỉ tượng điêu khắc, thần phật trang nghiêm "尊" (Bức / Pho / Vị)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ tượng điêu khắc, thần phật trang nghiêm "尊" (Bức / Pho / Vị)',
    'Số từ + 尊 + Danh từ (佛像 / 雕塑 / 大炮 / 铜像)',
    'Lượng từ',
    '"尊" (zūn) là lượng từ thể hiện sự tôn nghiêm, tôn kính cao quý, chuyên dùng cho các bức tượng Phật, pho tượng điêu khắc nghệ thuật cổ điển, tượng đồng vĩ nhân (như 一尊佛像, 一尊雕塑, 一尊青铜像).',
    'HSK 5',
    14,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在博物馆中央展厅里，陈列着一尊雕刻精湛的唐代石刻佛像。',
      'Zài bówùguǎn zhōngyāng zhǎntīng lǐ, chénlièzhe yì zūn diāokè jīngzhàn de Tángdài shíkè fóxiàng.',
      'Ở phòng triển lãm trung tâm của bảo tàng có trưng bày một pho tượng Phật khắc đá thời Đường được chạm trổ tuyệt mỹ.',
      '"一尊...佛像" dùng "尊" thể hiện sự tôn kính và giá trị linh thiêng của bảo vật tôn giáo cổ.'
    ),
    (
      v_gp_id,
      '广场中央矗立着一尊高大的民族英雄青铜雕塑。',
      'Guǎngchǎng zhōngyāng chùlìzhe yì zūn gāodà de mínzú yīngxióng qīngtóng diāosù.',
      'Giữa quảng trường sừng sững một bức tượng đồng anh hùng dân tộc uy nghi cao lớn.',
      '"一尊...青铜雕塑" dùng "尊" để thể hiện sự trang trọng, uy nghiêm của công trình đài tưởng niệm.'
    );

  -- Điểm ngữ pháp #15: Danh lượng từ chuyên dùng cho tàu thuyền vận tải "艘" (Chiếc / Con tàu)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chuyên dùng cho tàu thuyền vận tải "艘" (Chiếc / Con tàu)',
    'Số từ + 艘 + Danh từ (船 / 轮船 / 军舰 / 货轮 / 潜艇)',
    'Lượng từ',
    '"艘" (sōu) là lượng từ chuyên dụng dành riêng cho các phương tiện thủy cỡ lớn như tàu thủy, tàu chở hàng, tàu chiến, du thuyền, tàu ngầm (khác với "条" hoặc "只" thường dùng cho thuyền nhỏ dân dụng).',
    'HSK 5',
    15,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '港口码头边停泊着一艘装满了集装箱的大型远洋货轮。',
      'Gǎngkǒu mǎtóu biān tíngbózhe yì sōu zhuāngmǎn le jízhuāngxiāng de dàxíng yuǎnyáng huòlún.',
      'Bên cầu cảng có neo đậu một con tàu hàng viễn dương cỡ lớn chở đầy các thùng container.',
      '"一艘...远洋货轮" dùng "艘" làm lượng từ quy chuẩn cho tàu vận tải viễn dương quốc tế.'
    ),
    (
      v_gp_id,
      '经过严密的技术改造，这艘科考船即将启程前往南极进行深海科学考察。',
      'Jīngguò yánmì de jìshù gǎizào, zhè sōu kēkǎochuán jíjiāng qǐchéng qiánwǎng Nánjí jìnxíng shēnhǎi kēxué kǎochá.',
      'Sau khi được cải tạo kỹ thuật nghiêm ngặt, con tàu khảo sát khoa học này sắp sửa lên đường tới Nam Cực tiến hành khảo sát khoa học biển sâu.',
      '"这艘科考船" dùng "艘" định lượng cho tàu chuyên dụng nghiên cứu đại dương.'
    );

  -- Điểm ngữ pháp #16: Danh lượng từ chỉ tòa nhà, công trình đồ sộ "幢 / 栋" (Tòa / Căn / Dãy nhà)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Danh lượng từ chỉ tòa nhà, công trình đồ sộ "幢 / 栋" (Tòa / Căn / Dãy nhà)',
    'Số từ + 幢 / 栋 + Danh từ (大楼 / 别墅 / 教学楼 / 建筑 / 公寓)',
    'Lượng từ',
    '"幢" (zhuàng) và "栋" (dòng) là lượng từ chuyên dùng cho các tòa nhà kiến trúc độc lập, nhà cao tầng, khu biệt thự hoặc khối nhà chung cư. "栋" phổ biến hơn trong giao tiếp đời sống và bất động sản, còn "幢" mang sắc thái văn phong miêu tả kiến trúc trang trọng.',
    'HSK 5',
    16,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '市中心新建成了一幢高达三百米的地标性摩天大楼。',
      'Shìzhōngxīn xīn jiànchéng le yí zhuàng gāodá sān bǎi mǐ de dìbiāoxìng mótiāndàlóu.',
      'Tại trung tâm thành phố vừa mới xây xong một tòa nhà chọc trời mang tính biểu tượng cao tới 300 mét.',
      '"一幢...摩天大楼" dùng "幢" định lượng cho tòa tháp chọc trời nguy nga.'
    ),
    (
      v_gp_id,
      '学校规划在湖畔为新引进的青年学者建造两栋现代化的教师公寓。',
      'Xuéxiào guīhuà zài húpàn wèi xīn yǐnjìn de qīngnián xuézhě jiànzào liǎng dòng xiàndàihuà de jiàoshī gōngyù.',
      'Nhà trường quy hoạch xây dựng bên bờ hồ hai tòa nhà chung cư giáo viên hiện đại dành cho các học giả trẻ mới được thu hút về.',
      '"两栋...教师公寓" dùng "栋" chỉ hai khối nhà cư xá dành cho giảng viên.'
    );

  -- Điểm ngữ pháp #17: Phó từ thừa nhận nhượng bộ trước khi chuyển ngoặt "固然" (Cố nhiên / Tuy rằng / Đành rằng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thừa nhận nhượng bộ trước khi chuyển ngoặt "固然" (Cố nhiên / Tuy rằng / Đành rằng)',
    'A 固然... (但是 / 可是 / 也...) B',
    'Phó từ',
    '"固然" (gùrán) dùng để thừa nhận một sự thật, một ưu điểm hoặc thực tế hiển nhiên ở vế trước (đành rằng là như vậy, vốn dĩ đúng là thế), nhưng trọng tâm luận điểm thực sự nằm ở vế sau với quan hệ chuyển ngoặt (nhưng phương diện kia mới là mấu chốt quan trọng hơn).',
    'HSK 5',
    17,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '工作赚钱固然重要，但是身体健康才是人生最根本的基石。',
      'Gōngzuò zhuànqián gùrán zhòngyào, dànshì shēntǐ jiànkāng cái shì rénshēng zuì gēnběn de jīshí.',
      'Làm việc kiếm tiền đành rằng là quan trọng, nhưng sức khỏe mới là nền tảng căn bản nhất của đời người.',
      '"固然...但是..." thừa nhận giá trị của thu nhập để làm nổi bật tầm quan trọng tối cao của sức khỏe.'
    ),
    (
      v_gp_id,
      '引进先进技术固然能够解燃眉之急，但自主创新才拥有长远的未来。',
      'Yǐnjìn xiānjìn jìshù gùrán nénggòu jiě ránméizhījí, dàn zìzhǔ chuàngxīn cái yōngyǒu chángyuǎn de wèilái.',
      'Du nhập công nghệ tiên tiến cố nhiên có thể giải quyết được nhu cầu cấp bách trước mắt, nhưng tự chủ sáng tạo mới nắm giữ tương lai lâu dài.',
      '"固然...但..." so sánh giữa giải pháp tình thế trước mắt và chiến lược tự chủ lâu dài.'
    );

  -- Điểm ngữ pháp #18: Phó từ xác nhận sự thật chân thực "诚然" (Quả thực / Đúng là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ xác nhận sự thật chân thực "诚然" (Quả thực / Đúng là)',
    '诚然 + Sự thật thừa nhận, 但是 / 然而 + Luận điểm trọng tâm',
    'Phó từ',
    '"诚然" (chéngrán) là phó từ cao cấp tương đương với "固然", nhưng mang sắc thái chân thành, trang nghiêm và tính học thuật cao hơn (quả thực là, đúng là như vậy). Người viết thừa nhận một cách khách quan luận cứ của đối phương trước khi phản biện mở rộng.',
    'HSK 5',
    18,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这套方案诚然存在一定的执行风险，然而它所能带来的回报同样极其巨大。',
      'Zhè tào fāng''àn chéngrán cúnzài yídìng de zhíxíng fēngxiǎn, rán''ér tā suǒ néng dàilái de huíbào tóngyàng jíqí jùdà.',
      'Phương án này quả thực tồn tại rủi ro thực thi nhất định, tuy nhiên lợi ích đền đáp mà nó có thể mang lại cũng cực kỳ to lớn.',
      '"诚然...然而..." thể hiện phong thái biện luận khách quan thừa nhận rủi ro song hành cùng cơ hội.'
    ),
    (
      v_gp_id,
      '传统手工业诚然无法与现代机器生产的速度相比，但它蕴含着独一无二的人文温度。',
      'Chuántǒng shǒugōngyè chéngrán wúfǎ yǔ xiàndài jīqì shēngchǎn de sùdù xiāngbǐ, dàn tā yùnhánzhe dúyīwú''èr de rénwén wēndù.',
      'Thủ công nghiệp truyền thống quả thực không thể sánh được với tốc độ sản xuất máy móc hiện đại, nhưng nó hàm chứa hơi ấm nhân văn độc nhất vô nhị.',
      '"诚然...但..." tôn vinh giá trị tinh thần của làng nghề truyền thống trước sức ép công nghiệp.'
    );

  -- Điểm ngữ pháp #19: Phó từ kiên quyết phủ định lập trường "决不 / 绝不" (Tuyệt đối không / Quyết không)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ kiên quyết phủ định lập trường "决不 / 绝不" (Tuyệt đối không / Quyết không)',
    'Chủ ngữ + 决不 / 绝不 + Động từ/Tính từ (妥协 / 姑息 / 放弃 / 违背)',
    'Phó từ',
    '"决不" và "绝不" (juébù) là phó từ biểu thị ý chí sắt đá, quyết tâm sắt son không bao giờ làm một việc gì đó (tuyệt đối không, quyết không nhượng bộ). "决不" thiên về ý chí quyết định của chủ quan con người, còn "绝不" thiên về tính chất tuyệt đối không có ngoại lệ.',
    'HSK 5',
    19,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在事关国家领土和主权完整的原则问题上，我们决不作任何妥协。',
      'Zài shìguān guójiā lǐngtǔ hé zhǔquán wánzhěng de yuánzé wèntí shang, wǒmen juébù zuò rènhé tuǒxié.',
      'Trên vấn đề nguyên tắc liên quan đến chủ quyền và toàn vẹn lãnh thổ quốc gia, chúng ta quyết không đưa ra bất kỳ sự thỏa hiệp nào.',
      '"决不作任何妥协" tuyên bố đanh thép bảo vệ chủ quyền quốc gia bất khả xâm phạm.'
    ),
    (
      v_gp_id,
      '无论面临多大的诱惑，一名法官都绝不能违背司法公正的职业底线。',
      'Wúlùn miànlín duō dà de yòuhuò, yì míng fǎguān dōu juébù néng wéibèi sīfǎ gōngzhèng de zhíyè dǐxiàn.',
      'Bất luận đối mặt với cám dỗ lớn đến mức nào, một người thẩm phán đều tuyệt đối không thể làm trái lằn ranh đạo đức nghề nghiệp về sự công bằng tư pháp.',
      '"绝不能违背..." khẳng định ranh giới liêm chính tối thượng của người cầm cán cân công lý.'
    );

  -- Điểm ngữ pháp #20: Phó từ dứt khoát kiên quyết không do dự "断然" (Dứt khoát / Kiên quyết)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ dứt khoát kiên quyết không do dự "断然" (Dứt khoát / Kiên quyết)',
    'Chủ ngữ + 断然 + Động từ (拒绝 / 采取措施 / 否定 / 采取行动)',
    'Phó từ',
    '"断然" (duànrán) biểu thị hành động được đưa ra một cách dứt khoát, mạnh mẽ, không một chút do dự hay nhân nhượng (dứt khoát, kiên quyết). Thường đi với các động từ có tính quyết định cao như 拒绝 (từ chối), 采取措施 (áp dụng biện pháp), 否定 (bác bỏ).',
    'HSK 5',
    20,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '面对不法商人提出的无理要求，负责人断然拒绝了对方的行贿企图。',
      'Miànduì bùfǎ shāngrén tíchū de wúlǐ yāoqiú, fùzérén duànrán jùjué le duìfāng de xínghuì qǐtú.',
      'Đối mặt với yêu sách vô lý mà thương nhân bất chính đưa ra, người phụ trách đã dứt khoát cự tuyệt mưu toan hối lộ của đối phương.',
      '"断然拒绝" miêu tả thái độ kiên quyết từ chối thẳng thừng hành vi phi pháp.'
    ),
    (
      v_gp_id,
      '为了防止疫情进一步扩散，有关部门断然采取了严格的封闭隔离措施。',
      'Wèile fángzhǐ yìqíng jìnyíbù kuòsàn, yǒuguān bùmén duànrán cǎiqǔ le yángé de fēngbì gélí cuòshī.',
      'Để ngăn ngừa dịch bệnh lây lan thêm, các ban ngành hữu quan đã kiên quyết áp dụng các biện pháp phong tỏa cách ly nghiêm ngặt.',
      '"断然采取...措施" biểu thị hành động quyết đoán nhanh gọn vì an toàn cộng đồng.'
    );

  -- Điểm ngữ pháp #21: Phó từ phủ định hoàn toàn triệt để "毫不" (Mảy may không / Không chút nào)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phủ định hoàn toàn triệt để "毫不" (Mảy may không / Không chút nào)',
    '毫不 + Động từ/Tính từ (犹豫 / 畏惧 / 客气 / 掩饰 / 动摇 / 逊色)',
    'Phó từ',
    '"毫不" (háobù) tương đương với "一点儿也不", biểu thị mức độ phủ định triệt để (không một chút nào, mảy may không). Thường kết hợp với các động từ tâm lý hoặc phẩm chất đạo đức để tạo thành các cụm từ bốn chữ cao cấp như 毫不犹豫 (không chút do dự), 毫不客气 (chẳng chút khách sáo), 毫不畏惧 (không hề sợ hãi).',
    'HSK 5',
    21,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '当看到落水儿童命悬一线时，那位热心青年毫不犹豫地跳入冰冷的江水中救人。',
      'Dāng kàndào luòshuǐ értóng mìngxuányíxiàn shí, nà wèi rèxīn qīngnián háobù yóuyù de tiàorù bīnglěng de jiāngshuǐ zhōng jiùrén.',
      'Khi nhìn thấy đứa trẻ rơi xuống nước ngàn cân treo sợi tóc, chàng thanh niên nhiệt huyết đã không chút do dự lao mình xuống dòng sông băng giá cứu người.',
      '"毫不犹豫地跳入..." ca ngợi hành động dũng cảm cứu người bất chấp hiểm nguy tức thời.'
    ),
    (
      v_gp_id,
      '在这场激烈的辩论赛中，新组建的校队表现得毫不逊色于卫冕冠军。',
      'Zài zhè chǎng jīliè de biànlùnsài zhōng, xīn zǔjiàn de xiàoduì biǎoxiàn de háobù xùnsè yú wèimiǎn guànjūn.',
      'Trong trận thi đấu tranh biện gay cấn này, đội tuyển trường mới thành lập đã thể hiện mảy may không hề thua kém nhà đương kim vô địch.',
      '"毫不逊色" là cách nói văn học khẳng định năng lực xuất sắc ngang ngửa với đối thủ hàng đầu.'
    );

  -- Điểm ngữ pháp #22: Phó từ chỉ mức độ đỉnh điểm trang trọng "极为" (Cực kỳ / Hết sức / Vô cùng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ chỉ mức độ đỉnh điểm trang trọng "极为" (Cực kỳ / Hết sức / Vô cùng)',
    '极为 + Tính từ song âm tiết / Động từ tâm lý (重要 / 复杂 / 丰富 / 关注 / 遗憾)',
    'Phó từ',
    '"极为" (jíwéi) là phó từ chỉ mức độ cao cấp trong văn viết và chính luận, tương đương với "非常" hoặc "极其", nhưng mang sắc thái học thuật và văn phong trang nhã hơn. "极为" thường đi liền với tính từ song âm tiết miêu tả tính chất quan trọng, khó khăn hoặc tâm trạng sâu sắc.',
    'HSK 5',
    22,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '深海探测所获得的第一手地质样本，对地球演化研究具有极为重要的学术价值。',
      'Shēnhǎi tàncè suǒ huòdé de dìyīshǒu dìzhì yàngběn, duì dìqiú yǎnhuà yánjiū jùyǒu jíwéi zhòngyào de xuéshù jiàzhí.',
      'Mẫu vật địa chất đầu tay thu được từ việc thăm dò biển sâu có giá trị học thuật cực kỳ quan trọng đối với nghiên cứu sự tiến hóa của Trái Đất.',
      '"极为重要的学术价值" dùng "极为" nhấn mạnh ý nghĩa khoa học đột phá của phát hiện.'
    ),
    (
      v_gp_id,
      '在如此极为恶劣的自然条件下，科考队员们依然坚韧不拔地完成了观测任务。',
      'Zài rúcǐ jíwéi èliè de zìrán tiáojiàn xià, kēkǎo duìyuánmen yīrán jiānrènbùbá de wánchéng le guāncè rènwu.',
      'Dưới điều kiện tự nhiên khắc nghiệt cùng cực như vậy, các thành viên đội khảo sát khoa học vẫn kiên cường hoàn thành nhiệm vụ quan trắc.',
      '"极为恶劣" cực tả mức độ hiểm trở và nguy hiểm của khí hậu vùng cực.'
    );

  -- Điểm ngữ pháp #23: Phó từ phán đoán không chắc chắn "未必" (Chưa hẳn / Chưa chắc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phán đoán không chắc chắn "未必" (Chưa hẳn / Chưa chắc)',
    'Chủ ngữ + 未必 + (是/能/会/有) + Vị ngữ',
    'Phó từ',
    '"未必" (wèibì) là phó từ phủ định bán phần tương đương với "不一定" (chưa chắc, chưa hẳn). Dùng để phủ định sự võ đoán hoặc một định kiến chủ quan, nhắc nhở người nghe cần xem xét sự việc dưới góc nhìn đa chiều, khách quan hơn.',
    'HSK 5',
    23,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '最昂贵的商品未必就是品质最好的，适合自己的才是最理想的。',
      'Zuì ángguì de shāngpǐn wèibì jiù shì pǐnzhì zuì hǎo de, shìhé zìjǐ de cái shì zuì lǐxiǎng de.',
      'Mặt hàng đắt tiền nhất chưa hẳn đã là mặt hàng có chất lượng tốt nhất, cái phù hợp với bản thân mới là lý tưởng nhất.',
      '"未必就是..." phủ định quan niệm sai lầm đồng nhất giá tiền đắt đỏ với chất lượng hàng hóa.'
    ),
    (
      v_gp_id,
      '凭借一次考试的偶然失利，未必就能说明他在这个学科上缺乏天赋。',
      'Píngjiè yí cì kǎoshì de ǒurán shīlì, wèibì jiù néng shuōmíng tā zài zhè ge xuékē shang quēfá tiānfù.',
      'Dựa vào một lần trượt kỳ thi ngẫu nhiên, chưa chắc đã có thể chứng minh cậu ấy thiếu năng khiếu ở môn học này.',
      '"未必就能说明..." khuyên nhủ không nên đánh giá tiềm năng cả đời của học sinh qua một thất bại ngắn hạn.'
    );

  -- Điểm ngữ pháp #24: Phó từ chỉ kết quả tâm lý tự nhiên tất yếu "不免" (Không khỏi / Khó tránh)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ chỉ kết quả tâm lý tự nhiên tất yếu "不免" (Không khỏi / Khó tránh)',
    'Chủ ngữ + 不免 + (会/有点儿) + Động từ tâm lý / Tính từ',
    'Phó từ',
    '"不免" (bùmiǎn) dùng để diễn tả một cảm xúc, tâm trạng hoặc phản ứng tâm lý nảy sinh một cách hoàn toàn tự nhiên, khó lòng kiềm chế được trước một bối cảnh hay sự kiện cụ thể (không khỏi, khó lòng tránh được cảm giác đó). Thường đi với các từ chỉ cảm xúc như 担心, 难过, 遗憾, 紧张, 兴奋.',
    'HSK 5',
    24,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '第一次站在上千人的讲台上公开发言，他心里不免感到有些紧张。',
      'Dì yī cì zhàn zài shàngqiān rén de jiǎngtái shang gōngkāi fāyán, tā xīnlǐ bùmiǎn gǎndào yǒuxiē jǐnzhāng.',
      'Lần đầu tiên đứng trên bục giảng trước hàng nghìn người phát biểu công khai, trong lòng anh ấy không khỏi cảm thấy có đôi chút hồi hộp.',
      '"不免感到有些紧张" diễn tả tâm lý lo lắng hồi hộp rất con người khi đứng trước đám đông.'
    ),
    (
      v_gp_id,
      '看着老同学各奔前程的背影，离别之际大家心中不免涌起丝丝伤感。',
      'Kànzhe lǎotóngxué gèbènqiánchéng de bèiyǐng, líbié zhījì dàjiā xīnzhōng bùmiǎn yǒngqǐ sīsī shānggǎn.',
      'Nhìn bóng lưng bạn học cũ mỗi người một ngả vì tương lai, giờ phút chia tay trong lòng mọi người không khỏi dâng lên niềm ngậm ngùi.',
      '"不免涌起丝丝伤感" miêu tả cảm xúc xúc động bùi ngùi tất yếu lúc tốt nghiệp chia tay.'
    );

  -- Điểm ngữ pháp #25: Phó từ & Tính từ chỉ quy luật khách quan khó tránh "难免" (Khó tránh khỏi / Tất yếu xảy ra)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ & Tính từ chỉ quy luật khách quan khó tránh "难免" (Khó tránh khỏi / Tất yếu xảy ra)',
    '难免 + 会 + Kết quả bất lợi / Làm việc gì đó, 难免 + Thiếu sót',
    'Phó từ',
    '"难免" (nánmiǎn) vừa là phó từ vừa là tính từ, biểu thị một hiện tượng hoặc kết quả tiêu cực/sai sót là khó lòng tránh khỏi do sự hạn chế của quy luật khách quan hoặc điều kiện thực tế (khó tránh, khó lòng tránh khỏi). Khác với "不免" (thiên về cảm xúc tâm lý), "难免" thiên về sai sót, va chạm hoặc sơ suất trong hành vi.',
    'HSK 5',
    25,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '初学者在探索新领域时，难免会走一些弯路和犯一些小错误。',
      'Chūxuézhě zài tànsuǒ xīn lǐngyù shí, nánmiǎn huì zǒu yìxiē wānlù hé fàn yìxiē xiǎo cuòwù.',
      'Người mới bắt đầu học khi tìm tòi khám phá lĩnh vực mới, khó tránh khỏi sẽ đi đường vòng và phạm phải một vài sai lầm nhỏ.',
      '"难免会走弯路" cảm thông với quy luật vấp ngã tất yếu trong quá trình tích lũy học tập.'
    ),
    (
      v_gp_id,
      '一家人朝夕相处生活在同一个屋檐下，摩擦和矛盾是难免的。',
      'Yì jiā rén zhāoxīxiāngchǔ shēnghuó zài tóng yí gè wūyán xià, mócā hé máodùn shì nánmiǎn de.',
      'Cả gia đình sớm tối bên nhau sống chung dưới một mái nhà, va chạm và mâu thuẫn là điều khó tránh khỏi.',
      '"是难免的" dùng làm vị ngữ tính từ khẳng định va chạm đời sống là điều tất nhiên.'
    );

  -- Điểm ngữ pháp #26: Phó từ suýt chút nữa gặp nạn "险些" (Suýt nữa / Suýt chút nữa)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ suýt chút nữa gặp nạn "险些" (Suýt nữa / Suýt chút nữa)',
    'Chủ ngữ + 险些 + (就) + Kết quả xấu / 险些 + Gặp nguy hiểm',
    'Phó từ',
    '"险些" (xiǎnxiē) là phó từ cao cấp tương đương với "差点儿", biểu thị một tình huống nguy hiểm hoặc kết quả xấu suýt nữa đã xảy ra, nhưng nhờ may mắn hoặc xử lý kịp thời mà thực tế đã không xảy ra (suýt nữa thì, suýt chút nữa). Thường dùng trong văn viết hoặc văn phong kể chuyện kịch tính.',
    'HSK 5',
    26,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '由于地面结了厚厚一层暗冰，他脚下一滑，险些从台阶上摔了下去。',
      'Yóuyú dìmiàn jié le hòuhòu yì céng ànbīng, tā jiǎoxià yì huá, xiǎnxiē cóng táijiē shang shuāi le xiàqu.',
      'Do mặt đất đóng một lớp băng trơn mỏng, chân anh ấy trượt một cái, suýt nữa thì ngã nhào từ trên bậc thang xuống.',
      '"险些...摔了下去" miêu tả cú trượt chân nguy hiểm suýt gây thương tích nhưng may mắn gượng lại kịp.'
    ),
    (
      v_gp_id,
      '大货车紧急变道避让，客车司机反应敏捷，险些酿成一场连环追尾惨剧。',
      'Dà huòchē jǐnjí biàndào bìràng, kèchē sījī fǎnyìng mǐnjié, xiǎnxiē niàngchéng yì chǎng liánhuán zhuīwěi cǎnjù.',
      'Xe tải lớn đột ngột đổi làn né tránh, tài xế xe khách phản xạ nhanh nhạy, suýt chút nữa đã gây ra một thảm kịch đâm dồn đuôi xe liên hoàn.',
      '"险些酿成...惨剧" nhấn mạnh sự may mắn nhờ tay lái chuẩn xác tránh được tai nạn giao thông thảm khốc.'
    );

  -- Điểm ngữ pháp #27: Liên từ/Phó từ tương phản đối lập "反之" (Ngược lại / Trái lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ/Phó từ tương phản đối lập "反之" (Ngược lại / Trái lại)',
    'Mệnh đề thuận (nếu A thì B); 反之, Mệnh đề nghịch (nếu không A thì không B)',
    'Phó từ',
    '"反之" (fǎnzhī) là liên từ hoặc phó từ trang trọng trong văn viết nghị luận triết học, logic và pháp lý, mang nghĩa "nếu xét theo chiều hướng ngược lại thì...". Dùng để đối chiếu hai mặt thuận và nghịch của một quy luật hoặc giả thiết nhân quả.',
    'HSK 5',
    27,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '坚持规律的作息有助于增强免疫力；反之，长期熬夜则会严重损害身体健康。',
      'Jiānchí guīlǜ de zuòxī yǒuzhùyú zēngqiáng miǎnyìlì; fǎnzhī, chángqī áoyè zé huì yánzhòng sǔnhài shēntǐ jiànkāng.',
      'Kiên trì sinh hoạt điều độ góp phần tăng cường sức miễn dịch; ngược lại, thức đêm kéo dài sẽ hủy hoại nghiêm trọng sức khỏe thân thể.',
      '"反之" đứng đầu vế sau để đối chiếu hậu quả tiêu cực của việc thức khuya so với lối sống lành mạnh.'
    ),
    (
      v_gp_id,
      '企业尊重员工的创造力就能激发无限潜能；反之，僵化的管理只会压抑人才的积极性。',
      'Qǐyè zūnzhòng yuángōng de chuàngzàolì jiù néng jīfā wúxiàn qiánnéng; fǎnzhī, jiānghuà de guǎnlǐ zhǐ huì yāyì réncái de jījíxìng.',
      'Doanh nghiệp tôn trọng sức sáng tạo của nhân viên sẽ khơi dậy tiềm năng vô hạn; ngược lại, cách quản lý xơ cứng chỉ kìm hãm tính tích cực của nhân tài.',
      '"反之" lập luận sắc sảo về hai phong cách quản trị doanh nghiệp đối nghịch nhau.'
    );

  -- Điểm ngữ pháp #28: Phó từ tần suất cao lặp đi lặp lại "屡次" (Nhiều lần / Năm lần bảy lượt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tần suất cao lặp đi lặp lại "屡次" (Nhiều lần / Năm lần bảy lượt)',
    'Chủ ngữ + 屡次 + Động từ (犯错 / 获奖 / 警告 / 试验 / 申明)',
    'Phó từ',
    '"屡次" (lǚcì) là phó từ cao cấp biểu thị một hành động hoặc sự việc diễn ra nhiều lần, lặp đi lặp lại (năm lần bảy lượt, lặp lại nhiều đợt). Thường dùng trong văn viết chính thức, có thể dùng cho sự thành công liên tục (屡次获奖) hoặc hành vi tái phạm lỗi cần phê phán (屡次违规).',
    'HSK 5',
    28,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '该科研团队在极端恶劣的环境下屡次攻克难关，屡次荣获国家科技进步特等奖。',
      'Gāi kēyán tuánduì zài jíduān èliè de huánjìng xià lǚcì gōngkè nánguān, lǚcì rónghuò guójiā kējì jìnbù tèděngjiǎng.',
      'Nhóm nghiên cứu khoa học này dưới môi trường cực kỳ khắc nghiệt đã nhiều lần vượt qua khó khăn, nhiều lần vinh dự nhận giải đặc biệt Tiến bộ Khoa học Kỹ thuật Quốc gia.',
      '"屡次攻克难关" tôn vinh sự bền bỉ gặt hái thành tựu lặp lại qua nhiều năm tháng.'
    ),
    (
      v_gp_id,
      '尽管学校老师已经屡次三番进行提醒，他依然未能改正上课迟到的坏毛病。',
      'Jǐnguǎn xuéxiào lǎoshī yǐjīng lǚcìsānfān jìnxíng tíxǐng, tā yīrán wèinéng gǎizhèng shàngkè chídào de huài máobìng.',
      'Mặc dù thầy cô trong trường đã năm lần bảy lượt nhắc nhở, anh ta vẫn chưa thể sửa được tật xấu đi học muộn.',
      '"屡次三番" là quán dụng ngữ nhấn mạnh sự cảnh báo lặp đi lặp lại nhiều lần đối với lỗi vi phạm.'
    );

  -- Điểm ngữ pháp #29: Phó từ quy chuẩn bình đẳng tuyệt đối "一律" (Nhất loạt / Tất cả như nhau)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ quy chuẩn bình đẳng tuyệt đối "一律" (Nhất loạt / Tất cả như nhau)',
    'Chủ ngữ (số nhiều/phạm vi) + 一律 + Động từ / Tính từ',
    'Phó từ',
    '"一律" (yílǜ) là phó từ mang tính quy phạm pháp lý và thể chế cao cấp, biểu thị toàn bộ mọi đối tượng, trường hợp trong phạm vi quy định đều được đối xử hoặc thực hiện hoàn toàn giống nhau, tuyệt đối không có bất kỳ ngoại lệ hay sự phân biệt nào (nhất loạt, đều như nhau). Thường dùng trong các thông báo, nội quy, nghị định chính thức.',
    'HSK 5',
    29,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '根据考场纪律，所有考生的电子通信设备一律关机并统一存放。',
      'Gēnjù kǎochǎng jìlǜ, suǒyǒu kǎoshēng de diànzǐ tōngxìn shèbèi yílǜ guānjī bìng tǒngyī cúnfàng.',
      'Căn cứ theo kỷ luật phòng thi, thiết bị thông tin điện tử của tất cả thí sinh nhất loạt phải tắt nguồn và nộp lưu giữ tập trung.',
      '"一律关机" thể hiện tính nghiêm minh không có bất kỳ ngoại lệ nào trong quy chế phòng thi.'
    ),
    (
      v_gp_id,
      '本商场在周年庆期间，全场商品一律享受八五折优惠。',
      'Běn shāngchǎng zài zhōuniánqìng qījiān, quán chǎng shāngpǐn yílǜ xiǎngshòu bāwǔzhé yōuhuì.',
      'Trung tâm thương mại này trong thời gian đại lễ kỷ niệm, toàn bộ hàng hóa nhất loạt được hưởng ưu đãi giảm giá 15%.',
      '"一律享受..." áp dụng mức ưu đãi bình đẳng đồng loạt cho mọi sản phẩm.'
    );

  -- Điểm ngữ pháp #30: Phó từ bao quát triệt để không sót "统统" (Toàn bộ / Tuốt tuột / Tất thảy)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ bao quát triệt để không sót "统统" (Toàn bộ / Tuốt tuột / Tất thảy)',
    'Chủ ngữ / Tân ngữ đảo + 统统 + Động từ (扔掉 / 交出来 / 忘记)',
    'Phó từ',
    '"统统" (tǒngtǒng) là phó từ tương đương với "全都" (tất cả, toàn bộ), nhưng mang sắc thái dứt khoát, triệt để và sinh động hơn, biểu thị không chừa lại một cá thể hay đồ vật nào (toàn bộ, tuốt tuột). Thường dùng khi thu dọn đồ đạc, giao nộp hoặc gạt bỏ cảm xúc.',
    'HSK 5',
    30,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '搬家前夕，他把那些积累多年的旧报纸和破箱子统统扔掉了。',
      'Bānjiā qiánxī, tā bǎ nàxiē jīlěi duō nián de jiù bàozhǐ hé pò xiāngzi tǒngtǒng rēngdiào le.',
      'Vào đêm trước ngày chuyển nhà, anh ấy đã vứt tuốt tuột đống báo cũ và thùng giấy hỏng tích tụ nhiều năm.',
      '"统统扔掉" diễn tả hành động dọn dẹp sạch sẽ dứt khoát không giữ lại thứ gì.'
    ),
    (
      v_gp_id,
      '经过一个星期的封闭集训，学员们统统掌握了急救的基本操作规范。',
      'Jīngguò yí gè xīngqī de fēngbì jíxùn, xuéyuánmen tǒngtǒng zhǎowò le jíjiù de jīběn cāozuò guīfàn.',
      'Sau một tuần huấn luyện tập trung khép kín, các học viên đều nắm vững toàn bộ quy chuẩn thao tác sơ cứu cơ bản.',
      '"统统掌握了" biểu thị 100% học viên đều đạt tiêu chuẩn đầu ra huấn luyện y tế.'
    );

  -- Điểm ngữ pháp #31: Phó từ hoãn binh tạm thời "暂且" (Tạm thời / Trước mắt cứ gác lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ hoãn binh tạm thời "暂且" (Tạm thời / Trước mắt cứ gác lại)',
    'Chủ ngữ + 暂且 + Động từ + (不/放/搁/等) / 暂且不论',
    'Phó từ',
    '"暂且" (zànqiě) là phó từ văn viết trang trọng tương đương với "姑且" hoặc "暂时", mang ý nghĩa hoãn lại một sự việc, hành động để tập trung giải quyết vấn đề cấp bách hơn trước mắt (tạm thời cứ thế, trước mắt tạm gác sang một bên). Cụm từ cố định kinh điển: "暂且不论" (tạm thời chưa bàn tới khía cạnh này).',
    'HSK 5',
    31,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这笔资金的后续来源暂且不论，眼下当务之急是先把工程材料采购到位。',
      'Zhè bǐ zījīn de hòuxù láiyuán zànqiě búlùn, yǎnxià dāngwùzhījí shì xiān bǎ gōngchéng cáiliào cǎigòu dàowèi.',
      'Nguồn gốc tiếp theo của khoản vốn này tạm thời chưa bàn tới, nhiệm vụ cấp bách trước mắt là phải mua sắm đầy đủ vật liệu công trình trước.',
      '"暂且不论" phân định rõ việc nào nên gác lại để ưu tiên việc sống còn trước mắt.'
    ),
    (
      v_gp_id,
      '天色已经很晚了，关于这个方案的分歧我们暂且搁置，明天再作定夺。',
      'Tiānsè yǐjīng hěn wǎn le, guānyú zhè ge fāng''àn de fēnqí wǒmen zànqiě gēzhì, míngtiān zài zuò dìngduó.',
      'Trời đã rất muộn rồi, về những bất đồng của phương án này chúng ta tạm thời gác lại, ngày mai hãy đưa ra quyết định cuối cùng.',
      '"暂且搁置" biểu thị quyết định thông minh tạm hoãn tranh luận để nghỉ ngơi hồi phục trí lực.'
    );

  -- Điểm ngữ pháp #32: Phó từ chấp nhận giả định tạm thời "姑且" (Tạm thời coi như / Hãy cứ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ chấp nhận giả định tạm thời "姑且" (Tạm thời coi như / Hãy cứ)',
    '姑且 + Động từ (相信 / 试一试 / 承认 / 听之 / 算作)',
    'Phó từ',
    '"姑且" (gūqiě) mang ý nghĩa người nói dù chưa hoàn toàn tin tưởng hoặc chưa chắc chắn 100%, nhưng trong hoàn cảnh hiện tại sẵn sàng tạm thời chấp nhận, thử nghiệm hoặc nhượng bộ một bước để quan sát diễn biến tiếp theo (hãy cứ coi như, tạm thời hãy thử xem sao).',
    'HSK 5',
    32,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '虽然他的理由听起来有些牵强，但我们姑且相信他一次，给他一个机会。',
      'Suīrán tā de lǐyóu tīng qǐlai yǒuxiē qiānqiǎng, dàn wǒmen gūqiě xiāngxìn tā yí cì, gěi tā yí gè jīhuì.',
      'Tuy rằng lý do của anh ta nghe chừng có phần gượng gạo, nhưng chúng ta hãy cứ tạm tin anh ta một lần, cho anh ta một cơ hội.',
      '"姑且相信他一次" thể hiện sự bao dung thử thách lòng tin dù đối phương đưa ra lý do chưa thuyết phục.'
    ),
    (
      v_gp_id,
      '这个新颖的设计思路虽然还不成熟，我们姑且可以在实验室里小规模测试一下。',
      'Zhè ge xīnyǐng de shèjì sīlù suīrán hái bù chéngshú, wǒmen gūqiě kěyǐ zài shíyànshì lǐ xiǎoguīmó cèshì yíxià.',
      'Ý tưởng thiết kế mới mẻ này tuy rằng chưa hoàn thiện, chúng ta hãy cứ thử nghiệm quy mô nhỏ trong phòng thí nghiệm xem sao.',
      '"姑且可以在...测试" biểu thị thái độ cởi mở chấp nhận thử nghiệm ý tưởng khoa học mới.'
    );

  -- Điểm ngữ pháp #33: Phó từ dấn thân quả cảm không màng gian khổ "毅然" (Kiên quyết / Quả quyết / Dứt khoát dấn thân)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ dấn thân quả cảm không màng gian khổ "毅然" (Kiên quyết / Quả quyết / Dứt khoát dấn thân)',
    'Chủ ngữ + 毅然 + Động từ (放弃 / 决定 / 投身 / 踏上 / 回国)',
    'Phó từ',
    '"毅然" (yìrán) miêu tả một quyết định dũng cảm, dứt khoát dấn thân làm một việc lớn lao hoặc từ bỏ điều kiện êm ấm để hy sinh vì lý tưởng, nghĩa vụ hoặc quốc gia (kiên quyết, dũng cảm quyết định). Thường dùng trong các văn cảnh ca ngợi nhân cách cao đẹp như 毅然回国 (kiên quyết về nước), 毅然投身 (quả quyết dấn thân).',
    'HSK 5',
    33,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '完成学业后，他毅然放弃了国外优厚的生活待遇，回国投身西部乡村教育。',
      'Wánchéng xuéyè hòu, tā yìrán fàngqì le guówài yōuhòu de shēnghuó dàiyù, huíguó tóushēn xībù xiāngcūn jiàoyù.',
      'Sau khi hoàn thành chương trình học, anh ấy đã kiên quyết từ bỏ chế độ đãi ngộ hậu hĩnh ở nước ngoài, trở về nước dấn thân vào sự nghiệp giáo dục nông thôn miền Tây.',
      '"毅然放弃...回国投身..." tôn vinh lý tưởng cống hiến quên mình của người trí thức trẻ.'
    ),
    (
      v_gp_id,
      '在国家最危难的历史时刻，无数热血青年毅然奔赴抗战前线。',
      'Zài guójiā zuì wēinàn de lìshǐ shíkè, wúshù rèxiè qīngnián yìrán bēnfù kàngzhàn qiánxiàn.',
      'Vào thời khắc lịch sử nguy nan nhất của đất nước, vô số thanh niên nhiệt huyết đã quả quyết xông pha ra tiền tuyến kháng chiến.',
      '"毅然奔赴前线" khắc họa ý chí kiên cường xả thân cứu nước của cả một thế hệ.'
    );

  -- Điểm ngữ pháp #34: Phó từ sực tỉnh hoặc chuyển biến bất ngờ "猛然" (Đột nhiên / Sực tỉnh / Giật mình)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ sực tỉnh hoặc chuyển biến bất ngờ "猛然" (Đột nhiên / Sực tỉnh / Giật mình)',
    'Chủ ngữ + 猛然 + Động từ (醒悟 / 发现 / 意识到 / 回过头 / 站起来)',
    'Phó từ',
    '"猛然" (měngrán) biểu thị hành động hoặc hoạt động nhận thức biến đổi đột ngột với cường độ mạnh mẽ, bất ngờ trong một khoảnh khắc rất ngắn (sực nhớ ra, bừng tỉnh, giật mình thảng thốt). Khác với "突然", "猛然" nhấn mạnh sự đột ngột của cú sốc tinh thần hoặc sự sực nhận ra chân tướng.',
    'HSK 5',
    34,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '听到远处传来的急刹车声，他猛然停下脚步并机警地回头看去。',
      'Tīngdào yuǎnchù chuánlái de jíshāchē shēng, tā měngrán tíngxià jiǎobù bìng jījǐng de huítóu kàn qù.',
      'Nghe thấy tiếng phanh xe gấp từ đằng xa vọng lại, anh ấy giật mình dừng phắt bước chân và cảnh giác quay đầu nhìn lại.',
      '"猛然停下脚步" miêu tả phản ứng dừng lại đột ngột trước âm thanh nguy hiểm.'
    ),
    (
      v_gp_id,
      '直到翻出泛黄的旧相册，他才猛然意识到岁月已经悄悄溜走了三十年。',
      'Zhídào fānchū fànhuáng de jiù xiàngcè, tā cái měngrán yìshídào suìyuè yǐjīng qiāoqiāo liūzǒu le sānshí nián.',
      'Mãi tới khi lật giở cuốn album ảnh cũ ngả vàng, ông ấy mới sực nhận ra năm tháng đã lặng lẽ trôi qua 30 năm ròng.',
      '"猛然意识到" diễn tả cảm xúc thảng thốt bừng ngộ về sự trôi chảy của thời gian.'
    );

  -- Điểm ngữ pháp #35: Phó từ quy luật tất yếu không thể đảo ngược "势必" (Ắt hẳn / Thế tất / Chắc chắn sẽ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ quy luật tất yếu không thể đảo ngược "势必" (Ắt hẳn / Thế tất / Chắc chắn sẽ)',
    'Hành động hiện tại sai lầm/thiếu sót, 势必 + 会 + Hậu quả xấu tất yếu',
    'Phó từ',
    '"势必" (shìbì) là phó từ cao cấp kết hợp chữ "势" (thế thế, xu thế) và "必" (ắt, nhất định), mang nghĩa "dựa theo xu thế phát triển khách quan thì chắc chắn tất yếu sẽ dẫn tới một hệ quả nghiêm trọng nào đó" (thế tất, ắt hẳn). Thường dùng trong phân tích chiến lược, cảnh báo chính sách.',
    'HSK 5',
    35,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '如果不加节制地过度开采地下水资源，势必会引发严重的地面沉降危机。',
      'Rúguǒ bù jiā jiézhì de guòdù kāicǎi dìxiàshuǐ zīyuán, shìbì huì yǐnfā yánzhòng de dìmiàn chénjiàng wēijī.',
      'Nếu khai thác nước ngầm quá mức không kiêng dè, ắt hẳn sẽ châm ngòi cho cuộc khủng hoảng sụt lún mặt đất nghiêm trọng.',
      '"势必会引发..." cảnh báo hệ lụy môi trường tất yếu không thể tránh khỏi nếu hủy hoại tài nguyên.'
    ),
    (
      v_gp_id,
      '单方面撕毁国际贸易协定，势必会遭到国际社会的广泛谴责与反制。',
      'Dān fāngmiàn sīhuǐ guójì màoyì xiédìng, shìbì huì zāodào guójì shèhuì de guǎngfàn qiǎnzé yǔ fǎnzhì.',
      'Đơn phương xé bỏ hiệp định thương mại quốc tế, thế tất sẽ gặp phải sự lên án và trả đũa rộng rãi của cộng đồng quốc tế.',
      '"势必会遭到..." dự báo kết cục ngoại giao tất yếu của hành vi vi phạm thỏa ước.'
    );

  -- Điểm ngữ pháp #36: Phó từ phản vấn phủ định lịch sử "何尝" (Nào có / Đâu phải là không / Từng bao giờ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phản vấn phủ định lịch sử "何尝" (Nào có / Đâu phải là không / Từng bao giờ)',
    '何尝 + Phủ định (不想 / 不是 / 不知道) / 何尝 + Khẳng định + 呢',
    'Phó từ',
    '"何尝" (hécháng) dùng trong câu hỏi tu từ để biểu thị sự thanh minh hoặc khẳng định gián tiếp: 1) "何尝不..." (nào có phải là không) mang ý nghĩa khẳng định mãnh liệt nhưng bất lực (thực tế rất muốn, rất hiểu, nhưng hoàn cảnh trói buộc); 2) "何尝...呢" mang nghĩa phủ định (nào đã từng như vậy bao giờ).',
    'HSK 5',
    36,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '面对年迈生病的父母，身在异乡打拼的他何尝不想早点儿回家陪伴呢？',
      'Miànduì niánmài shēngbìng de fùmǔ, shēn zài yìxiāng dǎpīn de tā hécháng bù xiǎng zǎodiǎnr huíjiā péibàn ne?',
      'Đối mặt với cha mẹ già yếu ốm đau, người con đang bươn chải nơi đất khách quê người như anh ấy nào có phải không muốn sớm về nhà bầu bạn cơ chứ?',
      '"何尝不想...呢" bộc lộ nỗi lòng xót xa của người con xa xứ: thực lòng vô cùng muốn về nhưng bất khả kháng.'
    ),
    (
      v_gp_id,
      '在漫长的创业征程中，我们何尝经历过如此严峻的资金断裂危机？',
      'Zài màncháng de chuàngyè zhēngchéng zhōng, wǒmen hécháng jīnglìguo rúcǐ yánjùn de zījīn duànliè wēijī?',
      'Trong chặng đường khởi nghiệp dài đằng đẵng, chúng tôi nào đã từng trải qua cuộc khủng hoảng đứt gãy dòng tiền ngặt nghèo đến nhường này?',
      '"何尝经历过" dùng câu hỏi tu từ khẳng định đây là lần đầu tiên công ty gặp thử thách khốc liệt chưa từng có.'
    );

  -- Điểm ngữ pháp #37: Phó từ khẳng định uyển chuyển khiêm nhường "未尝" (Chưa từng / Vị tất không phải là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ khẳng định uyển chuyển khiêm nhường "未尝" (Chưa từng / Vị tất không phải là)',
    '未尝 + Phủ định (不可 / 不是 / 没有) / 未尝 + Động từ',
    'Phó từ',
    '"未尝" (wèicháng) là phó từ văn ngôn cao cấp mang nghĩa "chưa từng" (kết hợp 未: chưa, 尝: từng). Khi kết hợp ở dạng phủ định kép như "未尝不可" (chưa hẳn là không được / cũng có thể chấp nhận), nó biểu đạt một ý kiến nhượng bộ, đồng tình một cách thận trọng, lịch thiệp và sâu sắc.',
    'HSK 5',
    37,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '如果传统模式走不通，换一个全新的跨界视角未尝不是一种积极的尝试。',
      'Rúguǒ chuántǒng móshì zǒu bù tōng, huàn yí gè quánxīn de kuàjiè shìjiǎo wèicháng bú shì yì zhǒng jījí de chángshì.',
      'Nếu mô hình truyền thống đi vào bế tắc, đổi sang một góc nhìn xuyên ngành hoàn toàn mới vị tất không phải là một sự thử nghiệm tích cực.',
      '"未尝不是..." là cấu trúc phủ định kép nhã nhặn khẳng định đổi mới sáng tạo là hướng đi đúng đắn.'
    ),
    (
      v_gp_id,
      '对于年轻人的大胆构想，在严格控制风险的前提下，让他们放手一试也未尝不可。',
      'Duìyú niánqīngrén de dàdǎn gòuxiǎng, zài yángé kòngzhì fēngxiǎn de qiántí xià, ràng tāmen fàngshǒu yí shì yě wèicháng bùkě.',
      'Đối với ý tưởng táo bạo của người trẻ, dưới tiền đề kiểm soát rủi ro chặt chẽ, để họ tự do thử sức cũng chẳng phải là không được.',
      '"未尝不可" thể hiện sự cởi mở, đồng ý cho cấp dưới thử nghiệm cơ hội mới.'
    );

  -- Điểm ngữ pháp #38: Phó từ chỉ sự giới hạn duy nhất "无非" (Chẳng qua là / Không ngoài)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ chỉ sự giới hạn duy nhất "无非" (Chẳng qua là / Không ngoài)',
    'Chủ ngữ + 无非是 + Danh từ/Mệnh đề / 无非 + Động từ (想/为了)',
    'Phó từ',
    '"无非" (wúfēi) tương đương với "不过是" hoặc "只是", mang nghĩa "chẳng qua chỉ là, không ngoài mục đích gì khác". Thường dùng để chỉ rõ bản chất đơn giản của một hiện tượng tưởng chừng phức tạp, hoặc hạ thấp tính chất nghiêm trọng của vấn đề.',
    'HSK 5',
    38,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他之所以整天拼命工作加班，无非是想为家人创造一个更好的生活条件。',
      'Tā zhīsuǒyǐ zhěngtiān pīnmìng gōngzuò jiābān, wúfēi shì xiǎng wèi jiārén chuàngzào yí gè gèng hǎo de shēnghuó tiáojiàn.',
      'Sở dĩ anh ấy suốt ngày làm việc tăng ca bán mạng, chẳng qua cũng chỉ là muốn tạo dựng cho gia đình một điều kiện sống tốt hơn.',
      '"无非是想..." giải thích động cơ giản dị và nhân văn đằng sau sự vất vả của người trụ cột gia đình.'
    ),
    (
      v_gp_id,
      '商家炒作这些花哨的概念，无非是为了吸引年轻消费者的眼球从而增加销量。',
      'Shāngjiā chǎozuò zhèxiē huāshào de gàiniàn, wúfēi shì wèile xīyǐn niánqīng xiāofèizhě de yǎnqiú cóng''ér zēngjiā xiàoliàng.',
      'Thương gia thổi phồng những khái niệm hào nhoáng này, chẳng qua cũng chỉ là nhằm thu hút sự chú ý của người tiêu dùng trẻ để tăng doanh số.',
      '"无非是为了..." bóc trần mục đích thương mại thuần túy đằng sau chiêu trò quảng cáo.'
    );

  -- Điểm ngữ pháp #39: Phó từ hành động thẳng mạch không vòng vo "径直" (Đi thẳng / Thẳng một mạch)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ hành động thẳng mạch không vòng vo "径直" (Đi thẳng / Thẳng một mạch)',
    'Chủ ngữ + 径直 + Động từ di chuyển/Hành động (走 / 走向 / 穿过 / 离开)',
    'Phó từ',
    '"径直" (jìngzhí) biểu thị việc di chuyển thẳng tắp tới một đích đến xác định mà không dừng lại, không rẽ ngang rẽ tắt dọc đường; hoặc biểu thị tiến hành ngay một việc mà không cần trải qua các thủ tục trung gian rườm rà (thẳng một mạch, đi thẳng tới).',
    'HSK 5',
    39,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '走进办公大楼后，他没有在接待处停留，而是径直朝董事长的办公室走去。',
      'Zǒujìn bàngōng dàlóu hòu, tā méiyǒu zài jiēdàichù tíngliú, érshì jìngzhí cháo dǒngshìzhǎng de bàngōngshì zǒu qù.',
      'Sau khi bước vào tòa nhà văn phòng, anh ấy không dừng chân ở bàn tiếp tân mà đi thẳng một mạch về phía phòng làm việc của chủ tịch hội đồng quản trị.',
      '"径直朝...走去" miêu tả bước chân dứt khoát không ngập ngừng tiến thẳng tới phòng lãnh đạo.'
    ),
    (
      v_gp_id,
      '辩论结束后，代表团团长神情凝重，径直穿过记者包围圈乘车离开了会场。',
      'Biànlùn jiéshù hòu, dàibiǎotuán tuánzhǎng shénqíng níngzhòng, jìngzhí chuānguò jìzhě bāowéiquān chéngchē líkāi le huìchǎng.',
      'Sau khi cuộc tranh luận kết thúc, trưởng đoàn đại biểu nét mặt trang nghiêm, đi thẳng xuyên qua vòng vây nhà báo để lên xe rời khỏi hội trường.',
      '"径直穿过..." thể hiện hành động di chuyển dứt khoát né tránh phỏng vấn báo chí.'
    );

  -- Điểm ngữ pháp #40: Phó từ nỗ lực vô ích không kết quả "徒然" (Uổng công / Vô ích / Lãng phí)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ nỗ lực vô ích không kết quả "徒然" (Uổng công / Vô ích / Lãng phí)',
    'Chủ ngữ + 徒然 + Động từ (浪费 / 消耗 / 挣扎 / 叹息 / 耗费)',
    'Phó từ',
    '"徒然" (túrán) là phó từ văn học mang ý nghĩa "chỉ làm một cách vô ích, uổng phí công sức, thời gian mà không thu lại bất kỳ kết quả hay ý nghĩa thiết thực nào" (uổng công vô ích, chỉ tổ phí hoài). Thường mang sắc thái tiếc nuối sâu sắc.',
    'HSK 5',
    40,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '如果缺乏科学的复习方法，仅仅靠熬夜死记硬背只会徒然消耗宝贵的时间和精力。',
      'Rúguǒ quēfá kēxué de fùxí fāngfǎ, jǐnjǐn kào áoyè sǐjìyìngbèi zhǐ huì túrán xiāohào bǎoguì de shíjiān hé jīnglì.',
      'Nếu thiếu phương pháp ôn tập khoa học, chỉ dựa vào việc thức đêm học vẹt chỉ làm uổng công tiêu hao thời gian và tinh thần quý báu.',
      '"徒然消耗..." cảnh báo việc học vẹt không có phương pháp sẽ khiến công sức đổ sông đổ biển.'
    ),
    (
      v_gp_id,
      '与其坐在废墟前徒然悲伤落泪，不如擦干眼泪重整旗鼓重建家园。',
      'Yǔqí zuò zài fèixū qián túrán bēishāng luòlèi, bùrú cāgān yǎnlèi chóngzhěngqígǔ chóngjiàn jiāyuán.',
      'Thay vì ngồi trước đống tro tàn đổ nát đau buồn rơi lệ trong vô vọng, chi bằng hãy lau khô nước mắt sốc lại tinh thần tái thiết quê hương.',
      '"徒然悲伤落泪" khuyên người dân biến đau thương thành hành động thực tế xây dựng lại đời sống.'
    );

  -- Điểm ngữ pháp #41: Phó từ tần suất diễn biến dồn dập "屡屡" (Liên tiếp / Nhiều lần / Dồn dập)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tần suất diễn biến dồn dập "屡屡" (Liên tiếp / Nhiều lần / Dồn dập)',
    'Chủ ngữ + 屡屡 + Động từ (获奖 / 受挫 / 创下新高 / 发生)',
    'Phó từ',
    '"屡屡" (lǚlǚ) là dạng trùng điệp cao cấp của "屡", diễn tả hành động hoặc hiện tượng xuất hiện liên tiếp với tần suất rất cao trong một thời đoạn ngắn (liên tục, dồn dập, nhiều lần). Thường dùng trong tin tức tài chính, thể thao và báo cáo thời sự.',
    'HSK 5',
    41,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在这届世界大学生运动会上，我国游泳健儿表现出色，屡屡打破赛事纪录。',
      'Zài zhè jiè shìjiè dàxuéshēng yùndònghuì shang, wǒ guó yóuyǒng jiàn''ér biǎoxiàn chūsè, lǚlǚ dǎpò sàishì jìlù.',
      'Tại Đại hội Thể thao Sinh viên Thế giới lần này, các kình ngư nước ta thi đấu xuất sắc, liên tiếp phá vỡ các kỷ lục của giải đấu.',
      '"屡屡打破纪录" miêu tả chuỗi chiến thắng vang dội nối tiếp nhau của đoàn thể thao.'
    ),
    (
      v_gp_id,
      '国际原油市场受地缘局势影响剧烈波动，期货交易价格屡屡创下历史新高。',
      'Guójì yuányóu shìchǎng shòu dìyuán júshì yǐngxiǎng jùliè bōdòng, qīhuò jiāoyì jiàgé lǚlǚ chuàngxià lìshǐ xīngāo.',
      'Thị trường dầu thô quốc tế chịu ảnh hưởng của cục diện địa chính trị biến động dữ dội, giá giao dịch hợp đồng tương lai liên tiếp lập đỉnh cao lịch sử mới.',
      '"屡屡创下新高" phản ánh chuỗi tăng giá dồn dập nhiều phiên liên tục.'
    );

  -- Điểm ngữ pháp #42: Phó từ biến đổi âm thầm không một tiếng động "悄然" (Lặng lẽ / Âm thầm / Kín đáo)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ biến đổi âm thầm không một tiếng động "悄然" (Lặng lẽ / Âm thầm / Kín đáo)',
    'Chủ ngữ + 悄然 + Động từ (发生 / 兴起 / 来临 / 离去 / 改变)',
    'Phó từ',
    '"悄然" (qiǎorán) là phó từ mang phong vị văn học đậm nét, biểu thị một hiện tượng, sự việc hoặc một trào lưu xã hội diễn ra, lan tỏa một cách vô cùng êm ả, kín đáo, không ồn ào khoa trương mà tự nhiên thấm sâu vào đời sống (âm thầm, lặng lẽ). Khác với "悄悄" (khẩu ngữ đời thường), "悄然" dùng cho sự chuyển dịch của thời gian, mùa màng hoặc phong cách sống.',
    'HSK 5',
    42,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '随着移动互联网技术的飞速普及，一种绿色低碳的生活方式正在全社会悄然兴起。',
      'Suízhe yídòng hùliánwǎng jìshù de fēisù pǔjí, yì zhǒng lǜsè dītàn de shēnghuó fāngshì zhèngzài quán shèhuì qiǎorán xīngqǐ.',
      'Cùng với sự phổ cập thần tốc của công nghệ internet di động, một lối sống xanh giảm thiểu carbon đang âm thầm trỗi dậy trong toàn xã hội.',
      '"悄然兴起" miêu tả xu hướng văn minh đô thị lan tỏa tự nhiên, êm dịu không cần hô hào khẩu hiệu.'
    ),
    (
      v_gp_id,
      '不知不觉中，秋天已经悄然来临，公园里的枫叶逐渐染上了绚烂的红色。',
      'Bùzhībùjué zhōng, qiūtiān yǐjīng qiǎorán láilín, gōngyuán lǐ de fēngyè zhújiàn rǎnshàng le xuànlàn de hóngsè.',
      'Trong sự vô thức không nhận ra, mùa thu đã lặng lẽ tới tự bao giờ, lá phong trong công viên dần nhuộm sắc đỏ rực rỡ.',
      '"悄然来临" khắc họa bước chân chuyển mùa nhẹ nhàng của thiên nhiên vũ trụ.'
    );

  -- Điểm ngữ pháp #43: Phó từ chỉ sự biến đổi trạng thái tức thì "顿时" (Lập tức / Tức khắc / Thoắt cái)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ chỉ sự biến đổi trạng thái tức thì "顿时" (Lập tức / Tức khắc / Thoắt cái)',
    'Biến cố xuất hiện, Chủ ngữ / Không gian + 顿时 + Động từ/Tính từ (沸腾 / 安静 / 亮了起来)',
    'Phó từ',
    '"顿时" (dùnshí) là phó từ chỉ thời gian trong quá khứ hoặc hiện thực, biểu thị ngay sau khi một kích thích hoặc biến cố xảy ra, toàn bộ cục diện, bầu không khí hoặc trạng thái tâm lý lập tức thay đổi toàn diện trong nháy mắt (tức thì, thoắt cái). Khác với "立刻", "顿时" chuyên dùng miêu tả bầu không khí và cảnh tượng tập thể.',
    'HSK 5',
    43,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '当舞台上的灯光骤然亮起时，喧闹的剧场大厅顿时变得鸦雀无声。',
      'Dāng wǔtái shang de dēngguāng zhòurán liàngqǐ shí, xuānnào de jùchǎng dàtīng dùnshí biànde yāquèwúshēng.',
      'Khi ánh đèn trên sân khấu đột ngột bừng sáng, đại sảnh nhà hát đang ồn ào thoắt cái trở nên im phăng phắc không một tiếng động.',
      '"顿时变得鸦雀无声" miêu tả sự biến đổi chuyển trạng thái âm thanh tức thì của cả khán phòng.'
    ),
    (
      v_gp_id,
      '听到航天飞船成功着陆的播报，指挥控制中心顿时沸腾了起来。',
      'Tīngdào hángtiān fēichuán chénggōng zhuólù de bōbào, zhǐhuī kòngzhì zhōngxīn dùnshí fèiténg le qǐlái.',
      'Nghe bản tin tàu vũ trụ đã hạ cánh thành công, trung tâm chỉ huy điều khiển lập tức vỡ òa sôi động hẳn lên.',
      '"顿时沸腾了起来" lột tả bầu không khí vỡ òa sung sướng bùng nổ của toàn thể kỹ sư.'
    );

  -- Điểm ngữ pháp #44: Cụm phó từ khoảnh khắc cực ngắn "刹那间" (Trong chớp mắt / Trong khoảnh khắc)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm phó từ khoảnh khắc cực ngắn "刹那间" (Trong chớp mắt / Trong khoảnh khắc)',
    '刹那间, Mệnh đề biến cố / Chủ ngữ + 刹那间 + Vị ngữ',
    'Phó từ',
    '"刹那间" (chànàjiān) có nguồn gốc từ thuật ngữ Phật giáo "sát-na" (khoảnh khắc thời gian ngắn nhất chớp mắt). Dùng để đặc tả một sự kiện diễn ra nhanh như tia chớp, vượt quá tốc độ phản xạ thông thường của mắt người, tạo ấn tượng kịch tính phi thường.',
    'HSK 5',
    44,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '一道耀眼的闪电撕破了夜空，刹那间照亮了整座沉睡中的城市。',
      'Yí dào yàoyǎn de shǎndiàn sīpò le yèkōng, chànàjiān zhàoliàng le zhěng zuò chénshuì zhōng de chéngshì.',
      'Một tia chớp chói lòa xé toạc màn trời đêm, trong chớp mắt đã rọi sáng rực toàn bộ thành phố đang say ngủ.',
      '"刹那间照亮..." đặc tả ánh sáng sấm sét lóe lên cực nhanh chiếu rọi không gian vạn vật.'
    ),
    (
      v_gp_id,
      '听到自己名字被宣布为获奖者的一瞬间，他脑海中刹那间闪过无数奋斗的日夜。',
      'Tīngdào zìjǐ míngzi bèi xuānbù wéi huòjiǎngzhě de yí shùnjiān, tā nǎohǎi zhōng chànàjiān shǎnguò wúshù fèndòu de rìyè.',
      'Ngay khoảnh khắc nghe thấy tên mình được xướng lên là người đoạt giải, trong tâm trí anh ấy chỉ trong một chớp mắt đã vụt qua vô số ngày đêm phấn đấu.',
      '"刹那间闪过..." diễn tả dòng hồi ức hiện về nhanh như một cuốn phim tua tốc độ cao.'
    );

  -- Điểm ngữ pháp #45: Phó từ liên tục tiếp diễn thời gian "随即" (Liền ngay sau đó / Ngay tắp lự)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ liên tục tiếp diễn thời gian "随即" (Liền ngay sau đó / Ngay tắp lự)',
    'Hành động 1 hoàn thành, (Chủ ngữ) + 随即 + Hành động 2',
    'Phó từ',
    '"随即" (suíjí) là phó từ cao cấp tương đương với "接着" hoặc "立刻", biểu thị hành động thứ hai diễn ra liền ngay sau khi hành động thứ nhất vừa kết thúc mà không có bất kỳ khoảng trống thời gian gián đoạn nào (ngay sau đó, lập tức tiếp theo). Thường dùng trong báo cáo công tác và tin tức chính thức.',
    'HSK 5',
    45,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '两国元首举行了亲切友好的正式会晤，随即共同出席了联合记者招待会。',
      'Liǎng guó yuánshǒu jǔxíng le qīnqiè yǒuhǎo de zhèngshì huìwù, suíjí gòngtóng chūxí le liánhé jìzhě zhāodàihuì.',
      'Nguyên thủ hai nước đã tiến hành cuộc hội đàm chính thức thân mật và hữu nghị, ngay sau đó đã cùng nhau tham dự buổi họp báo chung với các phóng viên.',
      '"随即共同出席..." liên kết nhịp nhàng hai lịch trình đối ngoại ngoại giao cấp cao nối tiếp nhau.'
    ),
    (
      v_gp_id,
      '救援人员迅速将伤员从废墟中救出，随即用直升机转运往最近的急救中心。',
      'Jiùyuán rényuán xùnsù jiāng shāngyuán cóng fèixū zhōng jiùchū, suíjí yòng zhíshēngjī zhuǎnyùn wǎng zuì jìn de jíjiù zhōngxīn.',
      'Lực lượng cứu hộ nhanh chóng cứu người bị thương ra khỏi đống đổ nát, ngay sau đó đã dùng trực thăng chuyển thẳng tới trung tâm cấp cứu gần nhất.',
      '"随即用直升机转运" thể hiện quy trình cấp cứu khẩn cấp chạy đua với thời gian liên tục.'
    );

  -- Điểm ngữ pháp #46: Phó từ xu thế tương lai chắc chắn xảy ra "迟早" (Sớm muộn gì / Không sớm thì muộn)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ xu thế tương lai chắc chắn xảy ra "迟早" (Sớm muộn gì / Không sớm thì muộn)',
    'Chủ ngữ + 迟早 + (会 / 要) + Kết quả tất yếu',
    'Phó từ',
    '"迟早" (chízǎo) kết hợp hai chữ "迟" (muộn) và "早" (sớm), biểu thị một kết quả hoặc hiện tượng dù hiện tại chưa xuất hiện nhưng trong tương lai nhất định sẽ xảy ra theo quy luật nhân quả tất yếu (sớm muộn gì cũng, chẳng sớm thì muộn). Thường dùng để khuyên răn, cảnh báo hoặc bày tỏ niềm tin kiên định.',
    'HSK 5',
    46,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '只要坚持脚踏实地努力付出，你的才华迟早会得到社会的公正认可。',
      'Zhǐyào jiānchí jiǎotàshídì nǔlì fùchū, nǐ de cáihuá chízǎo huì dédào shèhuì de gōngzhèng rènkě.',
      'Chỉ cần kiên trì nỗ lực hết mình từng bước vững chắc, tài năng của bạn sớm muộn gì cũng sẽ nhận được sự công nhận công bằng của xã hội.',
      '"迟早会得到..." động viên người trẻ kiên định niềm tin vào giá trị bản thân trong tương lai.'
    ),
    (
      v_gp_id,
      '任何企图掩盖真相的不法行为，迟早会被法律的利剑公之于众并受到严惩。',
      'Rènhé qǐtú yǎngài zhēnxiàng de bùfǎ xíngwéi, chízǎo huì bèi fǎlǜ de lìjiàn gōngzhīyúzhòng bìng shòudào yánchéng.',
      'Bất kỳ hành vi phi pháp nào mưu toan che đậy sự thật, sớm muộn gì cũng sẽ bị thanh gươm pháp luật phơi bày trước công chúng và trừng trị thích đáng.',
      '"迟早会被..." khẳng định công lý tất thắng và sự trừng phạt tất yếu của pháp luật.'
    );

  -- Điểm ngữ pháp #47: Giới từ xem xét tình hình thực tế "鉴于" (Xét thấy / Nhận thấy / Do thấy)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ xem xét tình hình thực tế "鉴于" (Xét thấy / Nhận thấy / Do thấy)',
    '鉴于 + Tình hình thực tế / Bối cảnh khách quan, Mệnh đề quyết định chính sách',
    'Giới từ',
    '"鉴于" (jiànyú) là giới từ chính luận cao cấp dùng ở đầu câu, dẫn ra một thực trạng, một nguyên nhân khách quan hoặc một kinh nghiệm quá khứ làm căn cứ quan trọng để cơ quan, tổ chức đưa ra một chính sách, biện pháp ứng phó phù hợp (xét thấy tình hình này, do nhận thấy bối cảnh trên).',
    'HSK 5',
    47,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '鉴于近期沿海地区台风活动频繁，海事部门发布了全线禁航的安全警示。',
      'Jiànyú jìnqī yánhǎi dìqū táifēng huódòng pínfán, hǎishì bùmén fābù le quánxiàn jìnháng de ānquán jǐngshì.',
      'Xét thấy thời gian gần đây bão tại các vùng ven biển hoạt động dồn dập, cơ quan hải sự đã ban bố cảnh báo an toàn cấm tàu bè ra khơi trên toàn tuyến.',
      '"鉴于近期沿海地区台风活动频繁" nêu ra căn cứ thời tiết khách quan để ban hành lệnh cấm tàu bè.'
    ),
    (
      v_gp_id,
      '鉴于该员工在过去一年中的突出业务贡献，董事会决定破格提拔其为部门总监。',
      'Jiànyú gāi yuángōng zài guòqù yì nián zhōng de tūchū yèwù gòngxiàn, dǒngshìhuì juédìng pògé tíbá qí wéi bùmén zǒngjiān.',
      'Xét thấy những cống hiến nghiệp vụ xuất chúng của nhân viên này trong một năm qua, hội đồng quản trị đã quyết định đặc cách cất nhắc anh làm giám đốc bộ phận.',
      '"鉴于...突出业务贡献" là lý do chính đáng để doanh nghiệp bổ nhiệm nhân tài vượt cấp.'
    );

  -- Điểm ngữ pháp #48: Giới từ xây dựng trên nền tảng lý luận "基于" (Dựa trên / Căn cứ vào / Trên cơ sở)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ xây dựng trên nền tảng lý luận "基于" (Dựa trên / Căn cứ vào / Trên cơ sở)',
    '基于 + Nền tảng lý luận / Dữ liệu nghiên cứu / Khảo sát, Mệnh đề kết luận',
    'Giới từ',
    '"基于" (jīyú) chỉ cơ sở khoa học, nền tảng lý luận, số liệu thống kê hoặc mô hình thực nghiệm làm bệ phóng để xây dựng phương án, giải thuật hoặc kết luận nghiên cứu (dựa trên nền tảng, căn cứ trên cơ sở). Khác với "鉴于" (thiên về thời thế, rủi ro), "基于" thiên về dữ liệu và học thuật.',
    'HSK 5',
    48,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '该科研团队基于海量临床实验数据，研发出了一种全新的抗癌靶向药物。',
      'Gāi kēyán tuánduì jīyú hǎiliàng línchuáng shíyàn shùjù, yánfā chū le yì zhǒng quánxīn de kàng''ái bǎxiàng yàowù.',
      'Nhóm nghiên cứu khoa học này dựa trên nguồn dữ liệu thử nghiệm lâm sàng khổng lồ, đã nghiên cứu phát triển thành công một loại thuốc nhắm trúng đích chống ung thư hoàn toàn mới.',
      '"基于海量临床实验数据" khẳng định nền tảng khoa học thực nghiệm vững chắc của phát minh dược phẩm.'
    ),
    (
      v_gp_id,
      '基于对全球消费市场长期趋势的深入分析，公司制定了未来五年的出海战略。',
      'Jīyú duì quánqiú xiāofèi shìchǎng chángqī qūshì de shēnrù fēnxī, gōngsī zhìdìng le wèilái wǔ nián de chūhǎi zhànlüè.',
      'Dựa trên sự phân tích sâu sắc đối với xu thế dài hạn của thị trường tiêu dùng toàn cầu, công ty đã đề ra chiến lược vươn ra biển lớn trong 5 năm tới.',
      '"基于对...深入分析" làm rõ việc lập kế hoạch kinh doanh xuất phát từ dữ liệu nghiên cứu thị trường bài bản.'
    );

  -- Điểm ngữ pháp #49: Giới từ xuất phát từ động cơ tâm lý "出于" (Xuất phát từ / Do / Vì)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ xuất phát từ động cơ tâm lý "出于" (Xuất phát từ / Do / Vì)',
    '出于 + Động cơ/Mục đích (好意 / 好奇 / 同情 / 安全考虑 / 礼貌), Mệnh đề',
    'Giới từ',
    '"出于" (chūyú) dẫn ra động cơ nội tâm, ý định ban đầu hoặc sự cân nhắc xuất phát từ tấm lòng, sự đồng cảm hoặc đạo đức nghề nghiệp của con người (xuất phát từ, vì lý do). Thường kết hợp với các từ như 好奇, 好心, 礼貌, 谨慎, 责任感, 人道主义.',
    'HSK 5',
    49,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他当时之所以伸出援手，完全是出于一位普通公民最本能的善良与同情心。',
      'Tā dāngshí zhīsuǒyǐ shēnchū yuánshǒu, wánquán shì chūyú yí wèi pǔtōng gōngmín zuì běnnéng de shànliáng yǔ tóngqíngxīn.',
      'Sở dĩ lúc đó anh ấy đưa tay giúp đỡ, hoàn toàn là xuất phát từ lòng lương thiện và sự đồng cảm bản năng nhất của một công dân bình thường.',
      '"出于...善良与同情心" làm sáng tỏ động cơ nhân văn cao đẹp của nghĩa cử cứu giúp người khác.'
    ),
    (
      v_gp_id,
      '出于保护未成年人身心健康的考虑，国家严格限制了网络游戏的服务时长。',
      'Chūyú bǎohù wèichéngniánrén shēnxīn jiànkāng de kǎolǜ, guójiā yángé xiànzhì le wǎngluò yóuxì de fúwù shícháng.',
      'Xuất phát từ sự cân nhắc bảo vệ sức khỏe thể chất và tinh thần của trẻ vị thành niên, nhà nước đã hạn chế nghiêm ngặt thời lượng phục vụ của trò chơi điện tử trực tuyến.',
      '"出于保护...的考虑" giải thích nguyên nhân nhân văn đằng sau chính sách giới hạn giờ chơi game.'
    );

  -- Điểm ngữ pháp #50: Giới từ men theo tuyến đường địa lý "沿着" (Men theo / Dọc theo)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ men theo tuyến đường địa lý "沿着" (Men theo / Dọc theo)',
    'Chủ ngữ + 沿着 + Tuyến đường/Dòng sông/Bờ biển + Động từ di chuyển (走/跑/巡逻/行驶)',
    'Giới từ',
    '"沿着" (yánzhe) biểu thị hành động di chuyển tuân thủ bám sát theo một tuyến đường dài có sẵn như dòng sông, bờ biển, con đường, đường ray hoặc tuyến cáp (men theo, dọc theo con đường). Ngoài ra còn dùng ẩn dụ: "沿着...道路前进" (tiến bước theo con đường lý tưởng).',
    'HSK 5',
    50,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '夏日的傍晚，许多市民喜欢沿着风景秀丽的江边绿道散步乘凉。',
      'Xiàrì de bàngwǎn, xǔduō shìmín xǐhuan yánzhe fēngjǐng xiùlì de jiāngbiān lǜdào sànbù chéngliáng.',
      'Vào chiều tối mùa hè, rất nhiều người dân thành phố thích đi dạo hóng mát men theo con đường xanh ven sông phong cảnh tươi đẹp.',
      '"沿着...江边绿道散步" miêu tả lộ trình đi dạo bám sát cảnh quan bờ sông mát rượi.'
    ),
    (
      v_gp_id,
      '全体官兵将始终坚定不移地沿着中国特色强军之路奋勇向前。',
      'Quántǐ guānbīng jiāng shǐzhōng jiāndìngbùyí de yánzhe Zhōngguó tèsè qiángjūn zhī lù fènyǒng xiàngqián.',
      'Toàn thể cán bộ chiến sĩ sẽ luôn kiên định không dời vững bước tiến lên dọc theo con đường xây dựng quân đội hùng mạnh mang đặc sắc Trung Quốc.',
      '"沿着...之路奋勇向前" dùng "沿着" theo nghĩa ẩn dụ chính luận về con đường lý tưởng cách mạng.'
    );

  -- Điểm ngữ pháp #51: Giới từ lần theo manh mối hoặc xuôi chiều "顺着" (Xuôi theo / Lần theo / Thuận theo)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ lần theo manh mối hoặc xuôi chiều "顺着" (Xuôi theo / Lần theo / Thuận theo)',
    '顺着 + Hướng dòng chảy / Manh mối / Tiếng động, Chủ ngữ + Động từ',
    'Giới từ',
    '"顺着" (shùnzhe) có ba nghĩa chính: 1) Thuận theo hướng chuyển động tự nhiên (như 顺着水流 - xuôi theo dòng nước, 顺着风向 - thuận theo chiều gió); 2) Lần theo dấu vết, âm thanh hoặc manh mối để tìm kiếm (như 顺着声音看去 - nhìn theo hướng âm thanh); 3) Chiều theo ý người khác (như 顺着他的脾气).',
    'HSK 5',
    51,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '刑警顺着现场遗留的一点蛛丝马迹，最终成功锁定了犯罪嫌疑人的藏身之地。',
      'Xíngjǐng shùnzhe xiànchǎng yíliú de yì diǎn zhūsīmǎjì, zuìzhōng chénggōng suǒdìng le fànzuì xiányírén de cángshēn zhī dì.',
      'Cảnh sát hình sự lần theo một chút manh mối li ti còn sót lại tại hiện trường, cuối cùng đã khóa chặt thành công nơi ẩn náu của nghi phạm.',
      '"顺着现场遗留的蛛丝马迹" miêu tả quá trình phá án bám sát từng dấu vết nghiệp vụ.'
    ),
    (
      v_gp_id,
      '竹筏顺着湍急的溪流飞速而下，两岸奇峰耸立，令人目不暇接。',
      'Zhúfá shùnzhe tuānjí de xīliú fēisù ér xià, liǎng''àn qífēng sǒnglì, lìng rén mùbùxiájiē.',
      'Bè tre xuôi theo dòng suối chảy xiết lao vun vút xuống dưới, hai bên bờ núi non kỳ vĩ sừng sững khiến người ta nhìn không xuể mắt.',
      '"顺着湍急的溪流" miêu tả chuyển động trôi tự nhiên của con bè nương theo sức nước con suối.'
    );

  -- Điểm ngữ pháp #52: Giới từ nhân dịp hoặc mượn phương tiện "借" (Nhân dịp / Nhờ vào / Mượn cơ hội)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ nhân dịp hoặc mượn phương tiện "借" (Nhân dịp / Nhờ vào / Mượn cơ hội)',
    '借 + Cơ hội/Dịp tốt / 借...之机, Chủ ngữ + Động từ + Tân ngữ',
    'Giới từ',
    '"借" (jiè) trong tiếng Trung HSK 5 ngoài nghĩa động từ "vay, mượn" còn được dùng như một giới từ chỉ phương thức hoặc thời cơ thuận lợi (nhân dịp này, mượn cớ, dựa vào sức mạnh bên ngoài để hành sự). Thường dùng trong ngoại giao và văn hóa xã giao: "借此机会" (nhân cơ hội này), "借题发挥" (mượn đề tài để mở rộng).',
    'HSK 5',
    52,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '值此新春佳节来临之际，我借此机会向全体员工及家属致以最诚挚的节日问候。',
      'Zhícǐ xīnchūn jiājié láilín zhījì, wǒ jiè cǐ jīhuì xiàng quántǐ yuángōng jí jiāshǔ zhìyǐ zuì chéngzhì de jiérì wènhòu.',
      'Nhân dịp Tết đến xuân về này, tôi mượn cơ hội này xin gửi tới toàn thể nhân viên cùng gia quyến lời thăm hỏi ngày lễ chân thành nhất.',
      '"借此机会" là khẩu ngữ nghi lễ trang trọng quen thuộc mở đầu bức thư chúc mừng năm mới.'
    ),
    (
      v_gp_id,
      '风筝正是借着大风的托举之力，才能在湛蓝的高空中自由翱翔。',
      'Fēngzheng zhèng shì jièzhe dàfēng de tuōjǔ zhī lì, cái néng zài zhànlán de gāokōng zhōng zìyóu áoxiáng.',
      'Con diều chính là nhờ nương vào lực nâng của ngọn gió lớn mới có thể tự do chao lượn trên bầu trời xanh thẳm.',
      '"借着大风的托举之力" giải thích quy luật vật lý dựa vào sức gió để bay cao.'
    );

  -- Điểm ngữ pháp #53: Giới từ mốc quá trình thẩm định hoàn tất "经" (Qua / Sau khi qua / Trải qua)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ mốc quá trình thẩm định hoàn tất "经" (Qua / Sau khi qua / Trải qua)',
    '经 + Động từ song âm tiết (批准 / 调查 / 研究 / 核实 / 专家评审), Mệnh đề kết luận',
    'Giới từ',
    '"经" (jīng) là giới từ văn thư hành chính cao cấp, mang nghĩa "sau khi đã trải qua một thủ tục thẩm định, xem xét hoặc nghiên cứu kỹ lưỡng" (qua khảo sát, sau khi được cấp phép). Thường kết hợp với các động từ hai chữ như 批准 (phê chuẩn), 调查 (điều tra), 讨论 (thảo luận), 审核 (thẩm duyệt).',
    'HSK 5',
    53,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经上级教育主管部门严格批准，该校将从下学期起正式开设人工智能实验班。',
      'Jīng shàngjí jiàoyù zhǔguǎn bùmén yángé pīzhǔn, gāi xiào jiāng cóng xià xuéqī qǐ zhèngshì kāishè réngōng zhìnéng shíyànbān.',
      'Sau khi được cơ quan chủ quản giáo dục cấp trên phê chuẩn nghiêm ngặt, ngôi trường này sẽ chính thức mở lớp thực nghiệm trí tuệ nhân tạo từ học kỳ tới.',
      '"经...严格批准" xác lập tính pháp lý hoàn thiện cho việc mở mã ngành đào tạo mới.'
    ),
    (
      v_gp_id,
      '经公安机关缜密的技术核实，网络上热传的那段事故视频系后期恶意剪辑合成。',
      'Jīng gōng''ān jīguān zhěnmì de jìshù héshí, wǎngluò shang rèchuán de nà duàn shìgù shìpín xì hòuqī èyì jiǎnjí héchéng.',
      'Qua sự xác minh kỹ thuật cẩn trọng của cơ quan công an, đoạn video tai nạn đang lan truyền rầm rộ trên mạng là sản phẩm cắt ghép ác ý giai đoạn hậu kỳ.',
      '"经...缜密核实" công bố kết luận điều tra chính thức bác bỏ tin giả thất thiệt.'
    );

  -- Điểm ngữ pháp #54: Giới từ xác lập chủ đề hội đàm chính trị "就" (Về / Nhân / Đứng trên phương diện)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ xác lập chủ đề hội đàm chính trị "就" (Về / Nhân / Đứng trên phương diện)',
    '就 + Chủ đề/Vấn đề trọng đại + Động từ (达成协议 / 发表看法 / 交换意见 / 展开磋商)',
    'Giới từ',
    '"就" (jiù) trong ngoại giao và thời sự chính trị đóng vai trò như một giới từ chỉ phạm vi chủ đề được đưa ra bàn thảo (về vấn đề, liên quan tới phương diện). Thường đi với các cặp kết hợp: "就...达成共识" (đạt được đồng thuận về...), "就...交换意见" (trao đổi ý kiến về...). Khác với "对", "就" mang sắc thái nghi lễ đối ngoại ngoại giao cao hơn.',
    'HSK 5',
    54,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '两国经贸代表团在日内瓦就知识产权保护问题达成了广泛的共识。',
      'Liǎng guó jīngmào dàibiǎotuán zài Rìnèiwǎ jiù zhīshi chǎnquán bǎohù wèntí dáchéng le guǎngfàn de gòngshí.',
      'Đoàn đại biểu kinh tế thương mại hai nước tại Geneva đã đạt được sự đồng thuận rộng rãi về vấn đề bảo hộ quyền sở hữu trí tuệ.',
      '"就...达成共识" là công thức ngoại giao chuẩn mực xác định kết quả của vòng đàm phán quốc tế.'
    ),
    (
      v_gp_id,
      '新闻发言人就近期国际社会的关切问题逐一作出了权威、详尽的官方回应。',
      'Xīnwén fāyánrén jiù jìnqī guójì shèhuì de guānqiè wèntí zhúyī zuòchū le quánwēi, xiángjìn de guānfāng huíyìng.',
      'Người phát ngôn tin tức đã lần lượt đưa ra những phản hồi chính thức đầy thẩm quyền và chi tiết về các vấn đề mà cộng đồng quốc tế quan tâm gần đây.',
      '"就...作出了回应" xác lập mục tiêu đối thoại rõ ràng trong buổi họp báo quốc tế.'
    );

  -- Điểm ngữ pháp #55: Giới từ tuân thủ chỉ thị và mệnh lệnh "遵照" (Tuân theo / Làm đúng theo)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ tuân thủ chỉ thị và mệnh lệnh "遵照" (Tuân theo / Làm đúng theo)',
    '遵照 + Chỉ thị/Chỉ đạo/Lời dặn/Pháp luật + Động từ thực hiện',
    'Giới từ',
    '"遵照" (zūnzhào) biểu thị việc chấp hành tuyệt đối và nghiêm túc theo lời dặn, chỉ thị của cấp trên, di nguyện của tiền nhân, hoặc quy định của pháp luật (tuân theo, làm đúng theo chỉ đạo). Mang sắc thái kính cẩn, phục tùng và trách nhiệm pháp lý cao.',
    'HSK 5',
    55,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '医护人员严格遵照世界卫生组织的操作指南，有条不紊地开展感染防控工作。',
      'Yīhù rényuán yángé zūnzhào Shìjiè Wèishēng Zǔzhī de cāozuò zhǐnán, yǒutiáobùwěn de kāizhǎn gǎnrǎn fángkòng gōngzuò.',
      'Các nhân viên y tế tuân thủ nghiêm ngặt theo hướng dẫn thao tác của Tổ chức Y tế Thế giới, triển khai công tác phòng chống nhiễm trùng một cách ngăn nắp tuần tự.',
      '"严格遵照...操作指南" làm rõ hành động tuân thủ tiêu chuẩn y khoa quốc tế.'
    ),
    (
      v_gp_id,
      '他遵照已故老科学家的生前遗嘱，将毕生积蓄全额捐赠给了贫困山区学校。',
      'Tā zūnzhào yǐgù lǎo kēxuéjiā de shēngqián yízhǔ, jiāng bìshēng jīxù quán''é juānzèng gěi le pínkùn shānqū xuéxiào.',
      'Anh ấy làm đúng theo di chúc lúc sinh thời của cố nhà khoa học già, đem toàn bộ tiền tích lũy cả đời quyên tặng cho các trường học vùng núi nghèo khó.',
      '"遵照...生前遗嘱" thể hiện lòng trung thực và sự kính trọng đối với tâm nguyện của người đã khuất.'
    );

  -- Điểm ngữ pháp #56: Phân biệt ba giới từ chính luận cốt lõi: "鉴于" vs "基于" vs "出于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phân biệt ba giới từ chính luận cốt lõi: "鉴于" vs "基于" vs "出于"',
    '鉴于 (Tình hình khách quan/Kinh nghiệm) vs 基于 (Cơ sở dữ liệu/Lý luận) vs 出于 (Động cơ nội tâm)',
    'Giới từ',
    'Ba giới từ chữ "于" này phân định rõ ranh giới ngữ pháp học thuật: 1) "鉴于" (xét thấy) dẫn ra hiện thực khách quan, tình huống khẩn cấp hoặc bài học quá khứ để đưa ra cảnh báo/quyết sách; 2) "基于" (dựa trên) dẫn ra căn cứ dữ liệu, tài liệu, lý thuyết mô hình để rút ra kết luận khoa học; 3) "出于" (xuất phát từ) dẫn ra động cơ tâm lý, tình cảm, thiện chí hoặc nguyên tắc đạo đức nội tại của con người.',
    'HSK 5',
    56,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '鉴于天气突变，基于雷达监测数据，出于安全考虑，机长决定返航。',
      'Jiànyú tiānqì tūbiàn, jīyú léidá jiāncè shùjù, chūyú ānquán kǎolǜ, jīzhǎng juédìng fǎnháng.',
      'Xét thấy thời tiết đột biến, dựa trên dữ liệu giám sát ra-đa, xuất phát từ sự cân nhắc an toàn, cơ trưởng đã quyết định bay quay đầu về.',
      'Câu kinh điển phối hợp cả 3 giới từ làm nổi bật rõ ranh giới chức năng của từng từ trong tình huống hàng không.'
    ),
    (
      v_gp_id,
      '这项新规划基于长期的科学论证，旨在彻底消除各种潜在的安全隐患。',
      'Zhè xiàng xīn guīhuà jīyú chángqī de kēxué lùnzhèng, zhǐzài chèdǐ xiāochú gè zhǒng qiánzài de ānquán yǐnhuàn.',
      'Quy hoạch mới này được xây dựng trên cơ sở thẩm định khoa học lâu dài, nhằm triệt tiêu hoàn toàn các mối hiểm họa an toàn tiềm ẩn.',
      '"基于长期的科学论证" làm nổi bật tính vững chắc về mặt học thuật của quy hoạch dự án.'
    );

  -- Điểm ngữ pháp #57: Cấu trúc phản đề phủ định tăng tiến "不仅不...反而..." (Chẳng những không... trái lại còn...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc phản đề phủ định tăng tiến "不仅不...反而..." (Chẳng những không... trái lại còn...)',
    'Chủ ngữ + 不仅不 / 不但没 + Hành động mong đợi, 反而 + Hành động/Kết quả trái ngược',
    'Liên từ',
    '"不仅不...反而..." (bùjǐn bù... fǎn''ér...) kết hợp quan hệ tăng tiến và phản đề: vế trước phủ định việc hành vi thông thường hay kỳ vọng diễn ra, vế sau dùng "反而" để đẩy kết quả sang chiều hướng hoàn toàn đối lập với dự đoán hoặc gây bất ngờ lớn (chẳng những không... mà trái lại còn...).',
    'HSK 5',
    57,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '面对大家的诚恳批评，他不仅不虚心接受，反而蛮不讲理地大发雷霆。',
      'Miànduì dàjiā de chéngkěn pīpíng, tā bùjǐn bù xūxīn jiēshòu, fǎn''ér mánbùjiǎnglǐ de dàfāléitíng.',
      'Đối mặt với lời phê bình chân thành của mọi người, anh ta chẳng những không khiêm tốn tiếp thu, mà trái lại còn vô lý nổi trận lôi đình.',
      '"不仅不虚心接受，反而..." làm nổi bật thái độ ngang ngược trái ngược hoàn toàn với tinh thần cầu thị.'
    ),
    (
      v_gp_id,
      '受到对手的故意挑衅后，他不仅没有慌乱，反而冷静沉着地打出了制胜一球。',
      'Shòudào duìshǒu de gùyì tiǎoxìn hòu, tā bùjǐn méiyǒu huāngluàn, fǎn''ér lěngjìng chénzhuó de dǎchū le zhìshèng yì qiú.',
      'Sau khi bị đối thủ cố ý khiêu khích, anh ấy chẳng những không hề rối loạn, mà trái lại còn bình tĩnh điềm đạm đánh ra cú bóng quyết định chiến thắng.',
      '"不仅没有...反而..." tôn vinh bản lĩnh thép kiên cường trước sự khiêu khích trên sân đấu.'
    );

  -- Điểm ngữ pháp #58: Liên từ tăng tiến nâng cao bậc hành động "进而" (Tiến thêm một bước / Hơn thế nữa)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ tăng tiến nâng cao bậc hành động "进而" (Tiến thêm một bước / Hơn thế nữa)',
    'Hành động cấp 1, 进而 + Hành động cấp 2 (sâu hơn, rộng hơn hoặc đạt mục tiêu cao hơn)',
    'Liên từ',
    '"进而" (jìn''ér) là liên từ chính luận cao cấp nối hai hành động hoặc giai đoạn phát triển, trong đó hành động ở vế sau dựa trên cơ sở của vế trước để tiến thêm một bước sâu hơn, quy mô lớn hơn hoặc đạt tới tầm cao mới (từ đó tiến tới, hơn thế nữa). Khác với "从而" (chỉ kết quả tự nhiên), "进而" nhấn mạnh sự nỗ lực chủ động tiến cấp.',
    'HSK 5',
    58,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们要先掌握扎实的理论基础知识，进而培养独立分析和解决复杂问题的科研能力。',
      'Wǒmen yào xiān zhǎowò zhāshi de lǐlùn jīchǔ zhīshi, jìn''ér péiyǎng dúlì fēnxī hé jiějué fùzá wèntí de kēyán nénglì.',
      'Chúng ta cần nắm vững kiến thức nền tảng lý luận vững chắc trước, từ đó tiến tới bồi dưỡng năng lực nghiên cứu khoa học độc lập phân tích và giải quyết vấn đề phức tạp.',
      '"进而培养..." thể hiện bước tiến nâng cấp từ tích lũy kiến thức cơ bản lên năng lực sáng tạo đỉnh cao.'
    ),
    (
      v_gp_id,
      '企业通过并购地方龙头品牌打开了区域销路，进而实现了进军全国大市场的战略宏图。',
      'Qǐyè tōngguò bìnggòu dìfāng lóngtóu pǐnpái dǎkāi le qūyù xiāolù, jìn''ér shíxiàn le jìnjūn quánguó dà shìchǎng de zhànlüè hóngtú.',
      'Doanh nghiệp thông qua việc sáp nhập thương hiệu đầu ngành địa phương đã mở toang đầu ra tiêu thụ theo vùng, từ đó tiến tới hiện thực hóa đại đồ chiến lược tiến quân vào thị trường lớn cả nước.',
      '"进而实现了..." miêu tả bước nhảy vọt quy mô thị trường từ phạm vi địa phương sang toàn quốc.'
    );

  -- Điểm ngữ pháp #59: Liên từ chỉ chuỗi thời gian tuần tự của sự kiện "继而" (Tiếp đó / Sau đó không lâu)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ chỉ chuỗi thời gian tuần tự của sự kiện "继而" (Tiếp đó / Sau đó không lâu)',
    'Sự kiện 1 phát sinh, 继而 + Sự kiện 2 nối tiếp',
    'Liên từ',
    '"继而" (jì''ér) là liên từ biểu thị quan hệ thời gian nối tiếp chặt chẽ: một sự việc hoặc hiện tượng xảy ra xong, tiếp liền sau đó phát sinh một sự việc khác (tiếp đó, nối tiếp theo sau). Khác với "进而" (tăng tiến về chất và mức độ), "继而" thuần túy chỉ thứ tự trước sau về mặt thời gian.',
    'HSK 5',
    59,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '天空中先是响起了沉闷的雷声，继而下起了瓢泼大雨。',
      'Tiānkōng zhōng xiān shì xiǎngqǐ le chénmèn de léishēng, jì''ér xiàqǐ le piáopō dàyǔ.',
      'Trên bầu trời thoạt tiên vang lên tiếng sấm rền trầm đục, tiếp đó đổ xuống trận mưa rào như trút nước.',
      '"先是...继而..." diễn tả thứ tự thời gian tự nhiên: tiếng sấm dội trước rồi cơn mưa ập đến ngay sau đó.'
    ),
    (
      v_gp_id,
      '双方最初只是在学术观点上产生口角争执，继而演变成了激烈的言语人身攻击。',
      'Shuāngfāng zuìchū zhǐshì zài xuéshù guāndiǎn shang chǎnshēng kǒujiǎo zhēngzhí, jì''ér yǎnbiàn chéng le jīliè de yányǔ rénshēn gōngjī.',
      'Đôi bên ban đầu chỉ là cãi vã đôi co về quan điểm học thuật, tiếp đó đã biến tướng thành những lời công kích cá nhân gay gắt.',
      '"继而演变..." ghi nhận sự biến tướng leo thang nối tiếp nhau của mâu thuẫn giao tiếp.'
    );

  -- Điểm ngữ pháp #60: Phân biệt chuẩn xác cặp liên từ học thuật: "进而" vs "继而"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phân biệt chuẩn xác cặp liên từ học thuật: "进而" vs "继而"',
    '进而 (Tăng tiến bản chất/bước tiến sâu hơn) vs 继而 (Nối tiếp tuần tự thời gian)',
    'Liên từ',
    'Điểm mấu chốt để phân biệt: 1) "进而" (jìn''ér) biểu thị quan hệ tăng tiến (遞進): bước sau sâu sắc hơn, có chủ đích phát triển nâng cao hơn bước trước; 2) "继而" (jì''ér) biểu thị quan hệ nối tiếp thời gian (承接): sự việc sau xảy ra liền kề sau sự việc trước theo dòng thời gian, không nhất thiết có ý nghĩa nâng cao về chất.',
    'HSK 5',
    60,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们先调查掌握了第一手事实，进而深入剖析了问题的根源。',
      'Wǒmen xiān diàochá zhǎowò le dìyīshǒu shìshí, jìn''ér shēnrù pōuxī le wèntí de gēnyuán.',
      'Chúng tôi trước hết điều tra nắm vững sự thật đầu tay, từ đó tiến thêm một bước mổ xẻ sâu sắc nguồn cơn của vấn đề.',
      '"进而深入剖析" thể hiện bước tiến nhận thức sâu sắc hơn từ việc thu thập dữ liệu thô sang phân tích bản chất.'
    ),
    (
      v_gp_id,
      '人群中首先传出低微的啜泣声，继而演化为全场悲痛的痛哭。',
      'Rénqún zhōng shǒuxiān chuánchū dīwēi de chuòqì shēng, jì''ér yǎnhuà wéi quánchǎng bēitòng de tòngkū.',
      'Trong đám đông trước tiên phát ra tiếng khóc thút thít nghẹn ngào, tiếp đó biến thành tiếng khóc than bi thương của toàn hội trường.',
      '"继而演化..." miêu tả sự lan truyền nối tiếp của âm thanh tiếng khóc theo trình tự thời gian.'
    );

  -- Điểm ngữ pháp #61: Liên từ giả thiết trang trọng văn ngôn "假使" (Giả sử / Ví bằng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ giả thiết trang trọng văn ngôn "假使" (Giả sử / Ví bằng)',
    '假使 + Tình huống giả định, (那么) 主语 + Cũng/Sẽ + Kết quả',
    'Liên từ',
    '"假使" (jiǎshǐ) là liên từ giả thiết cao cấp tương đương với "如果" hoặc "假如", nhưng mang sắc thái trang nghiêm, triết luận và đậm tính học thuật văn học cổ điển (giả sử như, ví phỏng). Thường dùng khi đặt ra các giả thiết logic để phản biện hoặc chứng minh một chân lý.',
    'HSK 5',
    61,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '假使世界上没有了阳光和水源，一切生命都将彻底失去生存的可能。',
      'Jiǎshǐ shìjiè shang méiyǒu le yángguāng hé shuǐyuán, yíqiè shēngmìng dōu jiāng chèdǐ shīqù shēngcún de kěnéng.',
      'Giả sử trên thế giới không còn ánh nắng và nguồn nước, toàn bộ sinh linh đều sẽ mất đi hoàn toàn khả năng sinh tồn.',
      '"假使...都将..." đặt ra giả thiết triết học cực đoan nhằm khẳng định vai trò sống còn của thiên nhiên.'
    ),
    (
      v_gp_id,
      '假使当初我们没有坚持核心技术的自主研发，今天势必会处处受制于人。',
      'Jiǎshǐ dāngchū wǒmen méiyǒu jiānchí héxīn jìshù de zìzhǔ yánfā, jīntiān shìbì huì chùchù shòuzhìyúrén.',
      'Ví phỏng thuở ban đầu chúng ta không kiên trì tự chủ nghiên cứu phát triển công nghệ cốt lõi, ngày hôm nay ắt hẳn sẽ nơi nơi đều bị người khác kìm kẹp.',
      '"假使...势必..." nhìn lại quyết định lịch sử đúng đắn cứu doanh nghiệp khỏi sự phụ thuộc.'
    );

  -- Điểm ngữ pháp #62: Liên từ giả thiết giàu sắc thái văn học "倘若" (Nếu như / Ví thử)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ giả thiết giàu sắc thái văn học "倘若" (Nếu như / Ví thử)',
    '倘若 + Giả thiết giàu cảm xúc, 主语 + 便 / 就 + Kết quả',
    'Liên từ',
    '"倘若" (tǎngruò) là liên từ giả định văn học tao nhã tương đương với "要是" hoặc "如果", thường xuất hiện trong các tác phẩm văn xuôi, tùy bút, hoặc những lập luận giàu chất thơ và triết lý nhân sinh (ví thử, nếu như mà). Vế sau thường kết hợp với "便" hoặc "就".',
    'HSK 5',
    62,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '人生倘若没有崇高的追求与梦想，生活便会沦为一片乏味的荒漠。',
      'Rénshēng tǎngruò méiyǒu chónggāo de zhuīqiú yǔ mèngxiǎng, shēnghuó biàn huì lúnwéi yí piàn fáwèi de huāngmò.',
      'Đời người ví thử không có những hoài bão và ước mơ cao đẹp, cuộc sống ắt sẽ biến thành một sa mạc cằn cỗi nhạt nhẽo.',
      '"倘若...便会..." là cấu trúc giả thiết nhân sinh giàu chất thơ so sánh cuộc sống với hoang mạc.'
    ),
    (
      v_gp_id,
      '倘若明天天气晴朗无风，我们便可如期扬帆起航前往海岛写生。',
      'Tǎngruò míngtiān tiānqì qínglǎng wú fēng, wǒmen biàn kě rúqī yángfān qǐháng qiánwǎng hǎidǎo xiěshēng.',
      'Nếu như ngày mai tiết trời quang đãng không gió, chúng ta liền có thể giương buồm ra khơi tới hòn đảo vẽ ký họa đúng như dự định.',
      '"倘若...便可..." dùng giả thiết tao nhã trong câu chuyện du ngoạn nghệ thuật.'
    );

  -- Điểm ngữ pháp #63: Liên từ phản thực tế biết ơn hoặc tiếc nuối "要不是" (Nếu không nhờ / Nếu không vì)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ phản thực tế biết ơn hoặc tiếc nuối "要不是" (Nếu không nhờ / Nếu không vì)',
    '要不是 + Yếu tố cứu cánh/cản trở, 主语 + 早就 / 已经 + Hậu quả xấu / Kết quả khác',
    'Liên từ',
    '"要不是" (yàobúshì) là liên từ biểu thị điều kiện phản thực tế (counterfactual): trên thực tế điều đó ĐÃ xảy ra hoặc ĐÃ có mặt, nhưng người nói giả định tình huống ngược lại "nếu như không có nó thì sự việc đã dẫn tới hậu quả hoàn toàn khác" (nếu không nhờ có, nếu không vì). Thường dùng để bày tỏ sự cảm ơn sâu sắc hoặc niềm tiếc nuối.',
    'HSK 5',
    63,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '今天路上要不是交警同志及时疏通引导，我肯定赶不上这趟国际航班了。',
      'Jīntiān lùshang yàobúshì jiāojǐng tóngzhì jíshí shūtōng yǐndǎo, wǒ kěndìng gǎnbushàng zhè tàng guójì hángbān le.',
      'Hôm nay trên đường nếu không nhờ có đồng chí cảnh sát giao thông kịp thời phân luồng chỉ dẫn, tôi chắc chắn đã không kịp chuyến bay quốc tế này rồi.',
      '"要不是...肯定赶不上..." bày tỏ lòng biết ơn sâu sắc đối với sự hỗ trợ của cảnh sát giao thông.'
    ),
    (
      v_gp_id,
      '要不是突如其来的伤病困扰，这位天才射手本可以在本届世界杯上大放异彩。',
      'Yàobúshì tūrúqílái de shāngbìng kùnrǎo, zhè wèi tiāncái shèshǒu běn kěyǐ zài běn jiè shìjièbēi shang dàfàngyìcǎi.',
      'Nếu không vì chấn thương bất ngờ ập đến quấy rầy, tay săn bàn thiên tài này vốn dĩ đã có thể tỏa sáng rực rỡ tại kỳ World Cup lần này.',
      '"要不是...本可以..." bày tỏ niềm tiếc nuối vô hạn cho sự nghiệp của vận động viên tài năng.'
    );

  -- Điểm ngữ pháp #64: Liên từ mục đích phòng ngừa hậu quả xấu "以免" (Để tránh / Kẻo)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ mục đích phòng ngừa hậu quả xấu "以免" (Để tránh / Kẻo)',
    'Biện pháp phòng ngừa tích cực, 以免 + Hậu quả tiêu cực phát sinh',
    'Liên từ',
    '"以免" (yǐmiǎn) là liên từ chỉ mục đích trong văn viết, đứng ở vế sau để nêu ra một kết quả xấu hoặc tình huống bất lợi mà người nói muốn ngăn ngừa, phòng tránh (để tránh, kẻo). Vế trước luôn là một hành động, biện pháp cẩn trọng được tiến hành chủ động.',
    'HSK 5',
    64,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请大家在离开实验室前仔细关好水电设备，以免发生火灾等安全事故。',
      'Qǐng dàjiā zài líkāi shíyànshì qián zǐxì guān hǎo shuǐdiàn shèbèi, yǐmiǎn fāshēng huǒzāi děng ānquán shìgù.',
      'Xin mọi người trước khi rời phòng thí nghiệm hãy tắt cẩn thận các thiết bị điện nước, để tránh xảy ra sự cố an toàn hỏa hoạn.',
      '"以免发生火灾" nêu rõ mục đích an toàn của hành động kiểm tra thiết bị trước khi ra về.'
    ),
    (
      v_gp_id,
      '重要文件请务必保存在云端并备份，以免因电脑硬盘损坏而丢失数据。',
      'Zhòngyào wénjiàn qǐng wùbì bǎocún zài yúnduān bìng bèifèn, yǐmiǎn yīn diànnǎo yìngpán sǔnhuài ér diūshī shùjù.',
      'Tài liệu quan trọng xin hãy nhớ lưu trữ trên đám mây và sao lưu dự phòng, kẻo mất dữ liệu do ổ cứng máy tính bị hỏng hóc.',
      '"以免...丢失数据" chỉ rõ rủi ro mất tài liệu cần phòng ngừa bằng giải pháp sao lưu đám mây.'
    );

  -- Điểm ngữ pháp #65: Liên từ khẩu ngữ phòng ngừa phiền toái "免得" (Để đỡ phải / Kẻo mà)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ khẩu ngữ phòng ngừa phiền toái "免得" (Để đỡ phải / Kẻo mà)',
    'Hành vi chuẩn bị trước, 免得 + Phiền hà / Rắc rối phát sinh',
    'Liên từ',
    '"免得" (miǎnde) là dạng khẩu ngữ sinh động của "以免", mang ý nghĩa làm trước một việc chu đáo để sau này đỡ phải tốn công giải quyết phiền toái, rắc rối (để đỡ phải, kẻo mà).',
    'HSK 5',
    65,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '明天去露营你最好多带一件厚外套，免得晚上山顶起风着凉感冒。',
      'Míngtiān qù lùyíng nǐ zuì hǎo duō dài yí jiàn hòu wàitào, miǎnde wǎnshang shāndǐng qǐfēng zháoliáng gǎnmào.',
      'Ngày mai đi cắm trại cậu tốt nhất hãy mang thêm một chiếc áo khoác dày, để đỡ bị nhiễm lạnh cảm cúm khi đỉnh núi nổi gió về đêm.',
      '"免得...着凉感冒" nhắc nhở người bạn mang thêm áo ấm phòng ngừa bị ốm khi đi chơi xa.'
    ),
    (
      v_gp_id,
      '出门前把钥匙和门禁卡放进固定口袋里，免得到处翻找耽误时间。',
      'Chūmén qián bǎ yàoshi hé ménjìnkǎ fàngjìn gùdìng kǒudài lǐ, miǎnde dàochù fānzhǎo dānwù shíjiān.',
      'Trước khi ra khỏi nhà hãy cất chìa khóa và thẻ từ vào túi cố định, để khỏi phải lục lọi khắp nơi làm lỡ dở thời gian.',
      '"免得到处翻找" khuyên nhủ thói quen ngăn nắp để tránh lãng phí thời gian tìm kiếm.'
    );

  -- Điểm ngữ pháp #66: Liên từ tiết kiệm công sức và chi phí "省得" (Để đỡ / Đỡ tốn công / Khỏi phải)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ tiết kiệm công sức và chi phí "省得" (Để đỡ / Đỡ tốn công / Khỏi phải)',
    'Lựa chọn phương án tiện lợi, 省得 + Tốn công/tốn tiền/mệt mỏi',
    'Liên từ',
    '"省得" (shěngde) kết hợp chữ "省" (tiết kiệm, đỡ tốn) mang nghĩa "nhằm tránh phát sinh thêm chi phí, sức lực, thời gian hoặc sự mệt mỏi không cần thiết" (để đỡ tốn công, đỡ mất tiền, khỏi phải). Mang sắc thái khẩu ngữ dân dã, thực tế.',
    'HSK 5',
    66,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '咱们今天就在手机上买好返程的高铁票吧，省得到时候火车站窗口排长队。',
      'Zánmen jīntiān jiù zài shǒujī shang mǎihǎo fǎnchéng de gāotiěpiào ba, shěngde dào shíhou huǒchēzhàn chuāngkǒu pái cháng duì.',
      'Chúng ta hôm nay mua sẵn vé tàu cao tốc lượt về trên điện thoại luôn đi, để đỡ phải xếp hàng dài ở quầy vé nhà ga lúc đó.',
      '"省得到时候...排长队" giải thích lợi ích tiết kiệm thời gian chờ đợi nhờ mua vé online.'
    ),
    (
      v_gp_id,
      '有什么话当面一次性说清楚，省得日后大家在背地里互相猜疑。',
      'Yǒu shénme huà dāngmiàn yícìxìng shuō qīngchu, shěngde rìhòu dàjiā zài bèidìlǐ hùxiāng cāiyí.',
      'Có chuyện gì hãy nói rõ ràng thẳng thắn một lần trước mặt nhau, để đỡ phải ngày sau mọi người nghi kỵ lẫn nhau sau lưng.',
      '"省得日后...互相猜疑" khuyên giải giao tiếp minh bạch để tránh mâu thuẫn nội bộ về sau.'
    );

  -- Điểm ngữ pháp #67: Liên từ mục đích tạo thuận lợi tích cực "以便" (Để tiện / Nhằm tạo điều kiện)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ mục đích tạo thuận lợi tích cực "以便" (Để tiện / Nhằm tạo điều kiện)',
    'Chuẩn bị điều kiện thuận lợi, 以便 + Hành vi tiếp theo tiến hành dễ dàng',
    'Liên từ',
    '"以便" (yǐbiàn) là liên từ mục đích tích cực trong văn bản hành chính, thương mại và giao dịch (kết hợp 以: để, 便: thuận tiện). Vế trước tạo ra tiền đề, cung cấp thông tin hoặc công cụ; vế sau dùng "以便" để chỉ rõ mục đích tạo sự dễ dàng, thuận lợi cho hành động tiếp theo (để tiện cho việc, nhằm giúp cho).',
    'HSK 5',
    67,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请各位参会代表务必在签到表上留下手机号，以便会务组随时通知最新议程。',
      'Qǐng gèwèi cānhuì dàibiǎo wùbì zài qiāndàobiǎo shang liúxià shǒujīhào, yǐbiàn huìwùzǔ suíshí tōngzhī zuìxīn yìchéng.',
      'Xin các vị đại biểu tham dự hội nghị nhất thiết hãy để lại số điện thoại trên bảng điểm danh, để tiện cho ban tổ chức hội vụ thông báo lịch trình mới nhất bất cứ lúc nào.',
      '"以便会务组随时通知..." nêu rõ mục đích thu thập số điện thoại nhằm phục vụ liên lạc thông suốt.'
    ),
    (
      v_gp_id,
      '公司在官网上发布了详细的操作视频教程，以便新用户快速上手使用软件。',
      'Gōngsī zài guānwǎng shang fābù le xiángxì de cāozuò shìpín jiàochéng, yǐbiàn xīn yònghù kuàisù shàngshǒu shǐyòng ruǎnjiàn.',
      'Công ty đã đăng tải video hướng dẫn thao tác chi tiết trên trang web chính thức, để người dùng mới tiện làm quen sử dụng phần mềm nhanh chóng.',
      '"以便新用户快速上手..." thể hiện tôn chỉ thiết kế dịch vụ hỗ trợ khách hàng thuận tiện.'
    );

  -- Điểm ngữ pháp #68: Liên từ chỉ hệ quả tiêu cực nghiêm trọng "以致" (Dẫn đến / Gây ra hậu quả)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ chỉ hệ quả tiêu cực nghiêm trọng "以致" (Dẫn đến / Gây ra hậu quả)',
    'Nguyên nhân sai lầm/sơ suất, 以致(于) + Hậu quả xấu nghiêm trọng',
    'Liên từ',
    '"以致" (yǐzhì) là liên từ nối kết quả bắt buộc phải là một kết cục xấu, một thất bại, tổn thất hoặc tình huống đáng tiếc xảy ra do nguyên nhân ở vế trước gây nên (dẫn đến hậu quả, làm cho, đến nỗi). Tuyệt đối không dùng "以致" cho các kết quả tốt đẹp hay thành công.',
    'HSK 5',
    68,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '项目负责人在前期论证中严重低估了施工难度，以致整个工程延期了半年之久。',
      'Xiàngmù fùzérén zài qiánqī lùnzhèng zhōng yánzhòng dīgū le shīgōng nándù, yǐzhì zhěng gè gōngchéng yánqī le bàn nián zhī jiǔ.',
      'Người phụ trách dự án trong khâu kiểm định ban đầu đã đánh giá quá thấp độ khó thi công, dẫn đến toàn bộ công trình bị chậm tiến độ tới nửa năm ròng.',
      '"以致整个工程延期..." chỉ rõ hậu quả đình trệ công trình do sai lầm đánh giá chủ quan gây ra.'
    ),
    (
      v_gp_id,
      '他在平时工作中马虎大意屡教不改，以致酿成了一起重大的生产安全责任事故。',
      'Tā zài píngshí gōngzuò zhōng mǎhudàyì lǚjiàobùgǎi, yǐzhì niàngchéng le yì qǐ zhòngdà de shēngchǎn ānquán zérèn shìgù.',
      'Anh ta trong công việc hằng ngày làm việc cẩu thả nhắc nhở mãi không sửa, đến nỗi đã gây ra một vụ tai nạn trách nhiệm an toàn sản xuất nghiêm trọng.',
      '"以致酿成了...事故" liên kết tính cẩu thả với hậu quả tai nạn lao động đau lòng.'
    );

  -- Điểm ngữ pháp #69: Liên từ chỉ mức độ cực đại hoặc phạm vi phát triển "以至 / 以至于" (Đến mức / Đến nỗi / Cho tới tận)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ chỉ mức độ cực đại hoặc phạm vi phát triển "以至 / 以至于" (Đến mức / Đến nỗi / Cho tới tận)',
    'Mức độ tăng cao, 以至(于) + Đạt tới mức độ phi thường / Mở rộng phạm vi',
    'Liên từ',
    '"以至" hoặc "以至于" (yǐzhìyú) biểu thị mức độ, số lượng, thời gian hoặc phạm vi sự vật phát triển sâu rộng, mở rộng liên tục cho tới khi đạt tới một mốc giới hạn phi thường nào đó (đến mức mà, cho tới tận). Kết quả sau "以至" có thể là trung tính, tích cực hoặc tiêu cực.',
    'HSK 5',
    69,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这本历史小说的人物塑造极其生动，以至于读者们常常把虚构人物当作真人。',
      'Zhè běn lìshǐ xiǎoshuō de rénwù sùzào jíqí shēngdòng, yǐzhìyú dúzhěmen chángcháng bǎ xūgòu rénwù dàngzuò zhēnrén.',
      'Việc xây dựng nhân vật của cuốn tiểu thuyết lịch sử này sống động đến mức độc giả thường coi nhân vật hư cấu như người thật ngoài đời.',
      '"以至于读者们常常..." ca ngợi bút pháp khắc họa nhân vật đạt tới đỉnh cao nghệ thuật lôi cuốn.'
    ),
    (
      v_gp_id,
      '现代数字技术已经深度渗透到工业、农业、以至普通百姓日常生活的方方面面。',
      'Xiàndài shùzì jìshù yǐjīng shēndù shèntòu dào gōngyè, nóngyè, yǐzhì pǔtōng bǎixìng rìcháng shēnghuó de fāngfāngmiànmiàn.',
      'Công nghệ số hiện đại đã thâm nhập sâu rộng vào công nghiệp, nông nghiệp, cho tới tận mọi ngóc ngách đời sống thường nhật của người dân bình thường.',
      '"以至..." mở rộng phạm vi ứng dụng từ các ngành sản xuất lớn đến tận đời sống sinh hoạt dân sinh.'
    );

  -- Điểm ngữ pháp #70: Phân biệt kinh điển chuẩn mực thi cử: "以致" vs "以至 / 以至于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phân biệt kinh điển chuẩn mực thi cử: "以致" vs "以至 / 以至于"',
    '以致 (Chỉ dùng cho Hậu quả xấu/thất bại) vs 以至/以至于 (Chỉ Mức độ cực hạn hoặc Mở rộng phạm vi)',
    'Liên từ',
    'Quy tắc phân biệt vàng trong HSK 5: 1) "以致" (chữ 致 mang nghĩa dẫn tới hậu quả) CHỈ DÙNG khi vế sau là kết cục tiêu cực, sai sót, thất bại, tổn hại (không bao giờ dùng cho điều tốt); 2) "以至 / 以至于" (chữ 至 mang nghĩa đạt tới mốc) dùng khi biểu thị sự nâng cao về mức độ (đến mức mà...) hoặc sự nối dài về phạm vi thời gian, không gian, đối tượng (từ A đến B cho tới tận C).',
    'HSK 5',
    70,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '因为准备工作极其充分，以至于整个发布会进行得异常顺利。',
      'Yīnwèi zhǔnbèi gōngzuò jíqí chōngfèn, yǐzhìyú zhěng gè fābùhuì jìnxíng de yìcháng shùnlì.',
      'Bởi vì công tác chuẩn bị cực kỳ chu đáo, đến mức toàn bộ buổi họp báo diễn ra suôn sẻ lạ thường.',
      'Kết quả tốt đẹp ("顺利") bắt buộc phải dùng "以至于", tuyệt đối không được dùng "以致".'
    ),
    (
      v_gp_id,
      '司机疲劳驾驶注意力涣散，以致车辆失控撞上了路边的护栏。',
      'Sījī píláo jiàshǐ zhùyìlì huànsàn, yǐzhì chēliàng shīkòng zhuàngshàng le lùbiān de hùlán.',
      'Tài xế lái xe trong tình trạng mệt mỏi mất tập trung, dẫn đến chiếc xe mất lái đâm vào dải phân cách ven đường.',
      'Hậu quả tai nạn giao thông nghiêm trọng bắt buộc dùng "以致".'
    );

  -- Điểm ngữ pháp #71: Cụm liên từ suy luận logic từ hiện thực "既然如此" (Đã như vậy / Trong tình thế đó)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm liên từ suy luận logic từ hiện thực "既然如此" (Đã như vậy / Trong tình thế đó)',
    'Sự thật đã được xác nhận. 既然如此, (那么) Chủ ngữ + Nên/Sẽ + Quyết định',
    'Liên từ',
    '"既然如此" (jìrán rúcǐ) là cụm liên từ độc lập đứng đầu câu, dùng khi một tình huống, thực tế hoặc quan điểm vừa được phân tích và cả hai bên đều đã công nhận tính xác thực của nó, từ đó dẫn ra kết luận hoặc quyết sách hợp lý tiếp theo (đã là như thế thì, trong bối cảnh đó).',
    'HSK 5',
    71,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '双方在价格条款上已经无法达成一致，既然如此，我们不如暂时终止本次谈判。',
      'Shuāngfāng zài jiàgé tiáokuǎn shang yǐjīng wúfǎ dáchéng yízhì, jìrán rúcǐ, wǒmen bùrú zànshí zhōngzhǐ běn cì tánpàn.',
      'Đôi bên trên điều khoản giá cả đã không thể đạt được sự nhất trí, đã như vậy, chúng ta chi bằng hãy tạm dừng cuộc đàm phán lần này lại.',
      '"既然如此" thừa nhận sự bế tắc trong đàm phán giá cả để đưa ra giải pháp tạm hoãn thông minh.'
    ),
    (
      v_gp_id,
      '天气预报显示暴风雪即将来临，既然如此，原定的登山拉练计划只能取消了。',
      'Tiānqì yùbào xiǎnshì bàofēngxuě jíjiāng láilín, jìrán rúcǐ, yuándìng de dēngshān lāliàn jìhuà zhǐ néng qǔxiāo le.',
      'Dự báo thời tiết cho thấy bão tuyết sắp ập tới, đã là như vậy thì kế hoạch rèn luyện leo núi định sẵn chỉ đành phải hủy bỏ thôi.',
      '"既然如此" làm bản lề chuyển tiếp từ tin tức bão tuyết sang quyết định hủy chuyến đi an toàn.'
    );

  -- Điểm ngữ pháp #72: Cấu trúc lựa chọn chủ quan tự nguyện "宁愿...也不..." (Thà rằng... chứ không...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc lựa chọn chủ quan tự nguyện "宁愿...也不..." (Thà rằng... chứ không...)',
    'Chủ ngữ + 宁愿 + Phương án chịu khổ/hy sinh, 也不 / 决不 + Phương án vi phạm nhân cách',
    'Liên từ',
    '"宁愿...也不..." (nìngyuàn... yě bù...) tương tự như "宁可...也不...", nhưng nhấn mạnh hơn nữa ý chí chủ quan, nguyện vọng tha thiết từ đáy lòng của chủ thể (tự nguyện thà rằng chọn con đường gian nan, chứ quyết không chấp nhận điều trái với lương tâm).',
    'HSK 5',
    72,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '老艺术家宁愿过着清贫的生活，也绝不肯为了迎合低俗市场而粗制滥造作品。',
      'Lǎo yìshùjiā nìngyuàn guòzhe qīngpín de shēnghuó, yě jué bù kěn wèile yínghé dīsú shìchǎng ér cūzhìlànzào zuòpǐn.',
      'Người nghệ sĩ già thà rằng sống cuộc đời thanh bần, chứ quyết không chịu vì hùa theo thị hiếu thị trường tầm thường mà sản xuất tác phẩm cẩu thả bừa bãi.',
      '"宁愿...也绝不肯..." khắc họa khí tiết thanh cao và lương tâm sáng tạo của người làm nghệ thuật chân chính.'
    ),
    (
      v_gp_id,
      '很多年轻人宁愿留在大城市里承受巨大的竞争压力，也不愿意回到安逸的小县城。',
      'Hěn duō niánqīngrén nìngyuàn liú zài dà chéngshì lǐ chéngshòu jùdà de jìngzhēng yālì, yě bú yuànyì huídào ānyì de xiǎo xiànchéng.',
      'Rất nhiều người trẻ thà rằng ở lại thành phố lớn chịu đựng áp lực cạnh tranh khổng lồ, chứ không cam lòng quay về thị trấn nhỏ an phận êm đềm.',
      '"宁愿...也不愿意..." phản ánh khát vọng vươn lên tìm kiếm cơ hội bứt phá của thanh niên hiện đại.'
    );

  -- Điểm ngữ pháp #73: Cấu trúc định nghĩa chính xác bản chất "与其说...不如说..." (Thay vì nói là... đúng hơn là nói...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc định nghĩa chính xác bản chất "与其说...不如说..." (Thay vì nói là... đúng hơn là nói...)',
    '与其说 A, 不如说 B (B mới là cách mô tả chính xác thực chất của vấn đề)',
    'Liên từ',
    '"与其说...不如说..." (yǔqí shuō... bùrú shuō...) dùng để điều chỉnh lại cách hiểu hoặc cách diễn đạt chưa thật sự chuẩn xác về một sự việc: vế trước nêu cách nhìn bề ngoài thông thường (A), vế sau khẳng định cách nhìn (B) mới phản ánh đúng bản chất chân thực, sâu sắc nhất của sự vật.',
    'HSK 5',
    73,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这件精美的艺术品与其说是商品，不如说是一位民间大师倾注毕生心血的灵魂结晶。',
      'Zhè jiàn jīngměi de yìshùpǐn yǔqí shuō shì shāngpǐn, bùrú shuō shì yí wèi mínjiān dàshī qīngzhù bìshēng xīnxuè de línghún jiéjīng.',
      'Tác phẩm nghệ thuật tinh xảo này thay vì nói là một món hàng hóa, đúng hơn nên nói là sự kết tinh tâm hồn mà một bậc thầy dân gian đã dồn trọn tâm huyết cả đời vào đó.',
      '"与其说是商品，不如说..." nâng tầm giá trị của tác phẩm từ góc độ thương mại lên tầm vóc kiệt tác văn hóa.'
    ),
    (
      v_gp_id,
      '这次团队的成功与其说是依靠好运气，不如说是全体成员多年默默坚持的必然结果。',
      'Zhè cì tuánduì de chénggōng yǔqí shuō shì yīkào hǎo yùnqi, bùrú shuō shì quántǐ chéngyuán duō nián mòmò jiānchí de bìrán jiéguǒ.',
      'Thành công của đội ngũ lần này thay vì nói là nhờ vào vận may tốt, đúng hơn nên nói là kết quả tất yếu của sự kiên trì âm thầm suốt nhiều năm của toàn thể thành viên.',
      '"与其说是...不如说是..." bác bỏ yếu tố may rủi để khẳng định chân lý của sự khổ luyện bền bỉ.'
    );

  -- Điểm ngữ pháp #74: Liên từ tăng tiến chính luận đa diện "不单...而且/并且..." (Không chỉ... mà còn...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ tăng tiến chính luận đa diện "不单...而且/并且..." (Không chỉ... mà còn...)',
    'Chủ ngữ + 不单...而且 / 并且 / 甚至 + Vị ngữ',
    'Liên từ',
    '"不单" (bùdān) đồng nghĩa với "不仅" và "不但", nhưng trong văn phong HSK 5 thường xuất hiện trong các bài bình luận xã hội hoặc diễn thuyết kinh tế để liên kết các vế câu có tính chất bổ trợ đa chiều và nâng tầm tính chất của vấn đề.',
    'HSK 5',
    74,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这项教育改革不单关系到千家万户的切身利益，并且直接影响到国家未来人才的储备。',
      'Zhè xiàng jiàoyù gǎigé bùdān guānxì dào qiānjiāwànhù de qiēshēn lìyì, bìngqiě zhíjiē yǐngxiǎng dào guójiā wèilái réncái de chǔbèi.',
      'Cuộc cải cách giáo dục này không chỉ liên quan tới lợi ích thiết thân của hàng vạn gia đình, mà còn trực tiếp ảnh hưởng tới nguồn dự trữ nhân tài tương lai của đất nước.',
      '"不单...并且..." nâng tầm ảnh hưởng từ cấp độ hộ gia đình lên quy mô chiến lược quốc gia.'
    ),
    (
      v_gp_id,
      '他待人接物不单谦虚有礼，并且在专业业务领域表现出了极高的领悟力。',
      'Tā dàirénjiēwù bùdān qiānxū yǒulǐ, bìngqiě zài zhuānyè yèwù lǐngyù biǎoxiàn chū le jí gāo de lǐngwùlì.',
      'Anh ấy đối nhân xử thế không chỉ khiêm nhường lễ độ, mà còn thể hiện khả năng lĩnh hội cực kỳ cao trong lĩnh vực nghiệp vụ chuyên môn.',
      '"不单...并且..." ca ngợi toàn diện cả về phẩm chất đạo đức lẫn tài năng trí tuệ của nhân vật.'
    );

  -- Điểm ngữ pháp #75: Cụm liên từ nối chuyển tiếp đoạn văn "不仅如此" (Chẳng những vậy / Không những thế)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm liên từ nối chuyển tiếp đoạn văn "不仅如此" (Chẳng những vậy / Không những thế)',
    'Đoạn văn 1. 不仅如此, Đoạn văn 2 (bổ sung luận cứ/thành tựu tầng cao hơn)',
    'Liên từ',
    '"不仅如此" (bùjǐn rúcǐ) là cụm từ chuyển tiếp đoạn văn quan trọng bậc nhất trong văn nghị luận HSK 5. Nó đứng ở đầu câu hoặc đầu đoạn văn mới để tổng kết và thừa nhận toàn bộ thành tựu/hiện tượng ở đoạn trước, sau đó mở ra một tầng nghĩa còn quan trọng hoặc chấn động hơn nữa ở đoạn sau.',
    'HSK 5',
    75,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '该项新技术大幅度提高了生产效率。不仅如此，它还彻底解决了高能耗污染的难题。',
      'Gāi xiàng xīn jìshù dàfúdù tígāo le shēngchǎn xiàolǜ. Bùjǐn rúcǐ, tā hái chèdǐ jiějué le gāo nénghào wūrǎn de nándí.',
      'Công nghệ mới này đã nâng cao mạnh mẽ hiệu suất sản xuất. Chẳng những thế, nó còn giải quyết triệt để bài toán khó về ô nhiễm tiêu hao năng lượng cao.',
      '"不仅如此" chuyển tiếp mượt mà từ thành tựu năng suất sang cống hiến bảo vệ môi trường sinh thái.'
    ),
    (
      v_gp_id,
      '这位青年志愿者经常无偿献血。不仅如此，他还利用业余时间长期义务照顾社区里的孤寡老人。',
      'Zhè wèi qīngnián zhìyuànzhě jīngcháng wúcháng xiànxiè. Bùjǐn rúcǐ, tā hái lìyòng yèyú shíjiān chángqī yìwù zhàogù shèqū lǐ de gūguǎ lǎorén.',
      'Chàng thanh niên tình nguyện viên này thường xuyên hiến máu nhân đạo miễn phí. Không những thế, anh còn tận dụng thời gian rảnh rỗi chăm sóc thiện nguyện lâu dài các cụ già neo đơn trong khu dân cư.',
      '"不仅如此" tôn vinh liên hoàn các nghĩa cử cao đẹp vì cộng đồng của tấm gương thanh niên tốt.'
    );

  -- Điểm ngữ pháp #76: Cụm liên từ khẳng định quyết tâm tuyệt đối "无论如何" (Bất luận thế nào / Dù sao đi nữa)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm liên từ khẳng định quyết tâm tuyệt đối "无论如何" (Bất luận thế nào / Dù sao đi nữa)',
    '无论如何, 主语 + 都要 / 也不能 + Vị ngữ',
    'Liên từ',
    '"无论如何" (wúlùn rúhé) là cụm phó từ/liên từ đứng độc lập ở đầu câu hoặc trước động từ, biểu thị trong bất kỳ tình huống, điều kiện hoặc trước bất kỳ trở ngại nào đi chăng nữa thì một nghĩa vụ, nguyên tắc hoặc quyết tâm bắt buộc phải được thực hiện (dù thế nào đi nữa, bằng mọi giá).',
    'HSK 5',
    76,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这次任务事关重大，无论如何我们都要在明天天亮之前赶到指定地点集结。',
      'Zhè cì rènwu shìguān zhòngdà, wúlùn rúhé wǒmen dōu yào zài míngtiān tiānliàng zhīqián gǎndào zhǐdìng dìdiǎn jíjié.',
      'Nhiệm vụ lần này vô cùng trọng đại, bất luận thế nào chúng ta cũng phải có mặt tập kết tại địa điểm chỉ định trước khi trời sáng mai.',
      '"无论如何...都要..." thể hiện mệnh lệnh quân sự khẩn cấp bắt buộc phải hoàn thành đúng giờ bằng mọi giá.'
    ),
    (
      v_gp_id,
      '无论如何，你都绝不能把这一份涉及客户核心商业隐私的数据泄露出去。',
      'Wúlùn rúhé, nǐ dōu jué bù néng bǎ zhè yí fèn shèjí kèhù héxīn shāngyè yǐnsī de shùjù xièlòu chūqù.',
      'Dù trong bất kỳ hoàn cảnh nào, cậu cũng tuyệt đối không được để lộ phần dữ liệu liên quan tới bí mật thương mại cốt lõi của khách hàng này ra ngoài.',
      '"无论如何...绝不能..." là lời răn đe nghiêm khắc về trách nhiệm bảo mật thông tin tối mật.'
    );

  -- Điểm ngữ pháp #77: Cấu trúc giả thiết mốc thời khắc biến đổi "一旦...就..." (Một khi... thì...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc giả thiết mốc thời khắc biến đổi "一旦...就..." (Một khi... thì...)',
    '一旦 + Thời khắc điều kiện kích hoạt, 主语 + 就 + Chuỗi hệ quả tất yếu',
    'Liên từ',
    '"一旦...就..." (yídàn... jiù...) dùng để chỉ ra một thời điểm hoặc điều kiện mang tính bước ngoặt: "một khi" sự việc đó xảy ra thì nó sẽ lập tức kích hoạt một chuỗi phản ứng hoặc hệ quả tất yếu khó lòng cứu vãn hoặc làm thay đổi hoàn toàn cục diện ban đầu.',
    'HSK 5',
    77,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '信誉是企业的生命线，一旦失去客户的信任，想要重新建立就难如登天。',
      'Xìnyù shì qǐyè de shēngmìngxiàn, yídàn shīqù kèhù de xìnrèn, xiǎng yào chóngxīn jiànlì jiù nánrúdēngtiān.',
      'Uy tín là sinh mệnh của doanh nghiệp, một khi đánh mất niềm tin của khách hàng thì muốn gầy dựng lại sẽ khó như lên trời.',
      '"一旦失去...就难如登天" cảnh báo cái giá quá đắt của việc đánh mất chữ tín thương trường.'
    ),
    (
      v_gp_id,
      '这项前沿技术一旦实现商业化量产，就将彻底颠覆现有的传统能源工业格局。',
      'Zhè xiàng qiányán jìshù yídàn shíxiàn shāngyèhuà liàngchǎn, jiù jiāng chèdǐ diānfù xiànyǒu de chuántǒng néngyuán gōngyè géjú.',
      'Công nghệ tiên phong này một khi thực hiện được sản xuất thương mại hàng loạt thì sẽ đảo lộn hoàn toàn cục diện công nghiệp năng lượng truyền thống hiện có.',
      '"一旦实现...就将彻底颠覆..." dự báo bước ngoặt cách mạng công nghiệp khi công nghệ mới được thương mại hóa.'
    );

  -- Điểm ngữ pháp #78: Cấu trúc quy nạp lập trường dứt khoát "不管...总之..." (Bất kể... tóm lại là...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc quy nạp lập trường dứt khoát "不管...总之..." (Bất kể... tóm lại là...)',
    '不管 + Các tình huống giả thiết phức tạp, 总之 + Kết luận quy nạp cốt lõi',
    'Liên từ',
    '"不管...总之..." (bùguǎn... zǒngzhī...) dùng khi vế trước liệt kê hàng loạt các điều kiện hoặc khả năng có thể phát sinh, vế sau dùng "总之" để gạt bỏ các yếu tố rườm rà nhằm đưa ra một nguyên tắc, thái độ hoặc kết luận cốt lõi, bất biến duy nhất (bất kể thế nào, tóm lại là).',
    'HSK 5',
    78,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '不管前方的道路有多少未知挑战，总之我们既然出发了就绝没有后退的道理。',
      'Bùguǎn qiánfāng de dàolù yǒu duōshao wèizhī tiǎozhàn, zǒngzhī wǒmen jìrán chūfā le jiù jué méiyǒu hòutuì de dàolǐ.',
      'Bất kể con đường phía trước có bao nhiêu thử thách chưa biết, tóm lại chúng ta đã xuất phát rồi thì tuyệt đối không có đạo lý lùi bước.',
      '"不管...总之..." khẳng định ý chí quyết tâm sắt đá không hề lay chuyển trước khó khăn.'
    ),
    (
      v_gp_id,
      '不管别人在私底下如何议论，总之把自己的本职工作做好才是立足的根本。',
      'Bùguǎn biérén zài sīdǐxia rúhé yìlùn, zǒngzhī bǎ zìjǐ de běnzhí gōngzuò zuò hǎo cái shì lìzú de gēnběn.',
      'Bất kể người khác bàn tán sau lưng như thế nào, tóm lại làm tốt công việc bổn phận của mình mới là gốc rễ để đứng vững.',
      '"总之..." đúc kết kinh nghiệm sống thực tế: tập trung vào chuyên môn thay vì bận tâm thị phi bên ngoài.'
    );

  -- Điểm ngữ pháp #79: Cấu trúc điều kiện duy nhất văn ngôn trang nghiêm "唯有...方能..." (Duy chỉ có... mới có thể...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc điều kiện duy nhất văn ngôn trang nghiêm "唯有...方能..." (Duy chỉ có... mới có thể...)',
    '唯有 + Con đường/Điều kiện tiên quyết duy nhất, 方能 + Đạt được thành tựu vĩ đại',
    'Liên từ',
    '"唯有...方能..." (wéiyǒu... fāngnéng...) là cấu trúc văn ngôn cao cấp tương đương với "只有...才能...", nhưng mang âm hưởng hùng tráng, nghiêm cẩn và triết lý sâu sắc (duy chỉ có... mới có thể). "唯" nghĩa là duy nhất; "方" nghĩa là mới (cái). Thường xuất hiện trong các bài phát biểu nguyên thủ, tuyên ngôn lý tưởng.',
    'HSK 5',
    79,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '唯有勇于直面自身的不足并坚持改革创新，一个民族方能始终屹立于世界民族之林。',
      'Wéiyǒu yǒngyú zhímiàn zìshēn de bùzú bìng jiānchí gǎigé chuàngxīn, yí gè mínzú fāngnéng shǐzhōng yìlì yú shìjiè mínzú zhī lín.',
      'Duy chỉ có dũng cảm đối mặt với những thiếu sót của bản thân và kiên trì đổi mới sáng tạo, một dân tộc mới có thể luôn luôn đứng vững hiên ngang trong hàng ngũ các dân tộc trên thế giới.',
      '"唯有...方能..." diễn đạt tư tưởng chính trị tầm vóc lịch sử về sức sống trường tồn của một quốc gia.'
    ),
    (
      v_gp_id,
      '唯有经历过狂风暴雨的无情洗礼，雄鹰方能展翅翱翔于高远的天际。',
      'Wéiyǒu jīnglìguo kuángfēngbàoyǔ de wúqíng xǐlǐ, xióngyīng fāngnéng zhǎnchì áoxiáng yú gāoyuǎn de tiānjì.',
      'Duy chỉ có trải qua sự tôi luyện gội rửa không tình cảm của mưa giông bão táp, chim ưng mới có thể tung cánh chao lượn trên bầu trời cao rộng.',
      '"唯有...方能..." dùng hình tượng chim ưng vượt qua bão táp làm ẩn dụ cho sự thành tài qua gian khó.'
    );

  -- Điểm ngữ pháp #80: Cấu trúc thừa nhận hai thuộc tính song hành "固然...也..." (Đành rằng... nhưng cũng...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc thừa nhận hai thuộc tính song hành "固然...也..." (Đành rằng... nhưng cũng...)',
    'Khía cạnh A 固然... (hợp lý), (但是) Khía cạnh B 也... (không thể xem nhẹ)',
    'Liên từ',
    '"固然...也..." (gùrán... yě...) biểu thị sự thừa nhận một phương diện khách quan là có thật hoặc hợp lý, đồng thời khẳng định phương diện còn lại cũng tồn tại song hành và quan trọng không kém (đành rằng như thế, nhưng cái kia cũng...). Dùng để lập luận biện chứng tránh sự phiến diện.',
    'HSK 5',
    80,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '追求经济效益固然必不可少，但维护生态平衡也绝不容丝毫懈怠。',
      'Zhuīqiú jīngjì xiàoyì gùrán bìbùkěshǎo, dàn wéihù shēngtài pínghéng yě jué bùróng sīháo xièdài.',
      'Mưu cầu lợi ích kinh tế đành rằng là điều tất yếu không thể thiếu, nhưng bảo vệ cân bằng sinh thái cũng tuyệt đối không cho phép buông lỏng lơ là mảy may.',
      '"固然...也..." cân bằng hài hòa giữa bài toán phát triển kinh tế và bảo vệ môi trường tự nhiên.'
    ),
    (
      v_gp_id,
      '严格的管理规章固然能够保障工作秩序，但充满人文关怀的沟通也同样必不可少。',
      'Yángé de guǎnlǐ guīzhāng gùrán nénggòu bǎozhàng gōngzuò zhìxù, dàn chōngmǎn rénwén guānhuái de gōutōng yě tóngyàng bìbùkěshǎo.',
      'Quy chế quản lý nghiêm ngặt đành rằng có thể bảo đảm trật tự làm việc, nhưng sự giao tiếp chan chứa tình cảm quan tâm con người cũng cần thiết không kém.',
      '"固然...也..." kết hợp nghệ thuật quản lý giữa kỷ cương thép và tình yêu thương.'
    );

  -- Điểm ngữ pháp #81: Cụm liên từ chính sách tổng kết bối cảnh "有鉴于此" (Nhận thấy điều đó / Xét thấy tình hình này)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cụm liên từ chính sách tổng kết bối cảnh "有鉴于此" (Nhận thấy điều đó / Xét thấy tình hình này)',
    'Phân tích bối cảnh/nguy cơ. 有鉴于此, Cơ quan/Chủ thể + Quyết định đưa ra giải pháp',
    'Liên từ',
    '"有鉴于此" (yǒu jiàn yú cǐ) là cụm liên từ hành chính cao cấp đứng đầu câu kết luận, có nghĩa là "sau khi đã xem xét và đánh giá đầy đủ tình hình/nguy cơ vừa nêu ở trên, xuất phát từ thực tế đó". Đây là cấu trúc tiêu chuẩn mở đầu cho các nghị quyết hoặc phương án xử lý khủng hoảng.',
    'HSK 5',
    81,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '近期网络诈骗手段不断翻新且隐蔽性极高。有鉴于此，公安部门紧急升级了反诈预警系统。',
      'Jìnqī wǎngluò zhàpiàn shǒuduàn búduàn fānxīn qiě yǐnbìxìng jí gāo. Yǒujiànyúcǐ, gōng''ān bùmén jǐnjí shēngjí le fǎnzhà yùjǐng xìtǒng.',
      'Thời gian gần đây thủ đoạn lừa đảo qua mạng liên tục biến tướng và có tính ẩn giấu cực kỳ cao. Nhận thấy tình hình đó, cơ quan công an đã khẩn cấp nâng cấp hệ thống cảnh báo chống lừa đảo.',
      '"有鉴于此" là mắt xích liên kết giữa thủ đoạn tội phạm tinh vi với giải pháp kỹ thuật nâng cấp an ninh.'
    ),
    (
      v_gp_id,
      '老龄化社会的到来对医疗照护体系提出了全新挑战。有鉴于此，市政府出台了居家养老补贴政策。',
      'Lǎolínghuà shèhuì de dàolái duì yīliáo zhàohù tǐxì tíchū le quánxīn tiǎozhàn. Yǒujiànyúcǐ, shì zhèngfǔ chūtái le jūjiā yǎnglǎo bǔtiē zhèngcè.',
      'Sự xuất hiện của xã hội già hóa dân số đã đặt ra thách thức hoàn toàn mới cho hệ thống chăm sóc y tế. Xét thấy điều đó, chính quyền thành phố đã ban hành chính sách trợ cấp dưỡng lão tại nhà.',
      '"有鉴于此" giải thích căn cứ thực tiễn để chính quyền ban hành quyết sách phúc lợi an sinh xã hội.'
    );

  -- Điểm ngữ pháp #82: Cấu trúc song song nâng cao với thành ngữ 4 chữ "既...又..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc song song nâng cao với thành ngữ 4 chữ "既...又..."',
    'Chủ ngữ + 既 + Thành ngữ 4 chữ/Cụm từ cao cấp + 又 + Thành ngữ 4 chữ song hành',
    'Liên từ',
    'Ở trình độ HSK 5, cấu trúc "既...又..." (jì... yòu...) không chỉ kết hợp các tính từ đơn giản mà thường ghép đôi hai thành ngữ bốn chữ đối xứng hoặc hai cụm động tân trừu tượng để biểu thị hai phẩm chất, tính năng hoặc trạng thái cùng hội tụ một cách hoàn mỹ.',
    'HSK 5',
    82,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这栋现代建筑既保留了中国古典园林的古朴典雅，又展现了国际前沿设计的简洁明快。',
      'Zhè dòng xiàndài jiànzhù jì bǎoliú le Zhōngguó gǔdiǎn yuánlín de gǔpǔ diǎnyǎ, yòu zhǎnxiàn le guójì qiányán shèjì de jiǎnjié míngkuài.',
      'Tòa kiến trúc hiện đại này vừa bảo lưu nét cổ phác thanh nhã của hoa viên cổ điển Trung Hoa, lại vừa thể hiện sự tinh gọn sáng sủa của thiết kế tiên phong quốc tế.',
      '"既保留...又展现..." kết hợp đối xứng hoàn mỹ giữa giá trị truyền thống và ngôn ngữ thiết kế đương đại.'
    ),
    (
      v_gp_id,
      '他在会议上的即兴发言既高屋建瓴，又紧密联系基层实际，博得了阵阵热烈喝彩。',
      'Tā zài huìyì shang de jíxìng fāyán jì gāowūjiànlíng, yòu jǐnmì liánxì jīcéng shíjì, bódé le zhènzhèn rèliè hècǎi.',
      'Bài phát biểu ngẫu hứng của ông tại cuộc họp vừa mang tầm nhìn chiến lược bao quát cao độ, lại vừa gắn bó mật thiết với thực tiễn cơ sở, đã nhận được từng tràng hoan nghênh nhiệt liệt.',
      '"既高屋建瓴，又紧密联系..." ca ngợi tài năng hùng biện vừa có chiều sâu vĩ mô vừa sát sườn thực tiễn.'
    );

  -- Điểm ngữ pháp #83: Cấu trúc liên từ dẫn ra ngoại lệ duy nhất "除了...以外, 唯独..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc liên từ dẫn ra ngoại lệ duy nhất "除了...以外, 唯独..."',
    '除了...以外, 唯独 + Đối tượng đặc biệt + Vị ngữ khác biệt',
    'Liên từ',
    '"唯独" (wéidú) mang nghĩa "duy nhất, chỉ riêng một mình đối tượng đó". Khi kết hợp với "除了...以外" tạo thành cấu trúc nêu bật đối tượng cá biệt có hành vi hoặc trạng thái hoàn toàn khác với tập thể còn lại.',
    'HSK 5',
    83,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '全班同学都积极踊跃地报名参加了这次志愿者活动，唯独他借口身体不适拒绝参加。',
      'Quán bān tóngxué dōu jījí yǒngyuè de bàomíng cānjiā le zhè cì zhìyuànzhě huódòng, wéidú tā jièkǒu shēntǐ búlì jùjué cānjiā.',
      'Toàn thể học sinh trong lớp đều hăng hái nhiệt tình đăng ký tham gia hoạt động tình nguyện lần này, duy chỉ có anh ta viện cớ người không khỏe từ chối tham gia.',
      '"唯独他..." tách biệt cá nhân có thái độ thiếu tích cực khỏi phong trào tập thể sôi nổi.'
    ),
    (
      v_gp_id,
      '柜子里摆满了各种精致的现代工艺品，唯独这枚古朴的怀表是爷爷亲手传给他的传家宝。',
      'Guìzi lǐ bǎimǎn le gè zhǒng jīngzhì de xiàndài gōngyìpǐn, wéidú zhè méi gǔpǔ de huáibiǎo shì yéye qīnshǒu chuángěi tā de chuánjiābǎo.',
      'Trong tủ bày đầy đủ loại đồ thủ công mỹ nghệ hiện đại tinh xảo, duy chỉ có chiếc đồng hồ quả quýt cổ kính này là bảo vật gia truyền mà ông nội đích thân trao lại cho anh.',
      '"唯独这枚怀表" làm nổi bật giá trị tinh thần thiêng liêng độc nhất của kỷ vật gia đình.'
    );

  -- Điểm ngữ pháp #84: Cấu trúc phủ định tương phản tuyệt đối "决非...而是..." (Tuyệt không phải... mà là...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc phủ định tương phản tuyệt đối "决非...而是..." (Tuyệt không phải... mà là...)',
    'Chủ ngữ + 决非 / 绝非 + Nguyên nhân/Bản chất sai lầm, 而是 + Bản chất đích thực',
    'Liên từ',
    '"决非...而是..." (juéfēi... érshì...) là cấu trúc phản biện chính luận mạnh mẽ: vế trước dùng "决非" (tuyệt đối không phải là) để bác bỏ dứt khoát một quan niệm lệch lạc hoặc một ngộ nhận sai lầm, vế sau dùng "而是" để khẳng định chân lý bản chất thực sự của sự vật.',
    'HSK 5',
    84,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们今天所取得的巨大飞跃决非凭空而来的奇迹，而是几代科研人员前赴后继艰苦奋斗的结晶。',
      'Wǒmen jīntiān suǒ qǔdé de jùdà fēiyuè juéfēi píngkōng''érlái de qíjì, érshì jǐ dài kēyán rényuán qiánfùhòujì jiānkǔ fèndòu de jiéjīng.',
      'Bước nhảy vọt to lớn mà chúng ta đạt được ngày hôm nay tuyệt không phải là phép màu từ trên trời rơi xuống, mà là sự kết tinh của sự phấn đấu gian khổ lớp này nối tiếp lớp khác của nhiều thế hệ cán bộ khoa học.',
      '"决非...而是..." bác bỏ tư tưởng ỷ lại vào may mắn để tôn vinh sự hy sinh xương máu của các nhà khoa học.'
    ),
    (
      v_gp_id,
      '他提出这套严格的规章制度决非故意为难员工，而是为了防患于未然确保生产绝对安全。',
      'Tā tíchū zhè tào yángé de guīzhāng zhìdù juéfēi gùyì wéinán yuángōng, érshì wèile fánghuànyúwèirán quèbǎo shēngchǎn juéduì ānquán.',
      'Ông ấy đề xuất bộ nội quy chế tài nghiêm ngặt này tuyệt không phải là cố tình làm khó nhân viên, mà là để phòng ngừa rủi ro từ trong trứng nước, bảo đảm an toàn sản xuất tuyệt đối.',
      '"决非故意为难...而是为了..." giải tỏa định kiến của cấp dưới về sự khắt khe của kỷ luật an toàn lao động.'
    );

  -- Điểm ngữ pháp #85: Bổ ngữ trạng thái hư hóa chỉ cảm giác khó chịu "得慌" (Đến bồn chồn / Phát rầu)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ trạng thái hư hóa chỉ cảm giác khó chịu "得慌" (Đến bồn chồn / Phát rầu)',
    'Tính từ / Động từ cảm xúc + 得慌 (闷 / 闲 / 累 / 慌 / 憋 / 撑 + 得慌)',
    'Bổ ngữ',
    '"得慌" (de huang) là bổ ngữ mức độ khẩu ngữ đặc sắc bắt nguồn từ phương ngôn phương Bắc Trung Quốc, đứng sau các tính từ hoặc động từ chỉ trạng thái tâm lý, sinh lý để cực tả cảm giác khó chịu, bức bối, ngột ngạt hoặc buồn bực không yên (buồn bực phát điên, mệt bã người, no tức bụng).',
    'HSK 5',
    85,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '退休在家这几个月一直没有出门社交，老李总觉得闲得慌、心里闷得慌。',
      'Tuìxiū zài jiā zhè jǐ gè yuè yìzhí méiyǒu chūmén shèjiāo, lǎo Lǐ zǒng juéde xián de huāng, xīnlǐ mèn de huāng.',
      'Nghỉ hưu ở nhà mấy tháng nay luôn không ra ngoài giao lưu xã hội, bác Lý luôn cảm thấy rảnh rỗi đến bồn chồn, trong lòng ngột ngạt khó chịu.',
      '"闲得慌" và "闷得慌" khắc họa tâm trạng bứt rứt, hụt hẫng của người vừa rời ghế công tác.'
    ),
    (
      v_gp_id,
      '今天中午聚餐大家太热情了，不知不觉吃得太多，肚子撑得慌。',
      'Jīntiān zhōngwǔ jùcān dàjiā tài rèqíng le, bùzhībùjué chī de tài duō, dùzi chēng de huāng.',
      'Bữa liên hoan trưa nay mọi người nhiệt tình quá, vô thức ăn quá nhiều khiến bụng no căng tức anh ách.',
      '"撑得慌" miêu tả cảm giác no căng tức bụng khó chịu sau bữa tiệc thịnh soạn.'
    );

  -- Điểm ngữ pháp #86: Bổ ngữ mức độ cực hạn mạnh mẽ "不得了" (Vô cùng / Không xiết / Ghê gớm)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ mức độ cực hạn mạnh mẽ "不得了" (Vô cùng / Không xiết / Ghê gớm)',
    'Tính từ / Động từ tâm lý + 得不得了 / Tính từ + 得了不得',
    'Bổ ngữ',
    '"不得了" (bùdéliǎo) khi làm bổ ngữ sau trợ từ "得" biểu thị mức độ của tính chất hoặc cảm xúc đạt tới mức tột đỉnh, phi thường, không từ ngữ nào tả xiết (cực kỳ, ghê gớm, vô cùng). Có thể dùng cho cả cảm xúc tích cực hân hoan hoặc trạng thái tiêu cực nghiêm trọng.',
    'HSK 5',
    86,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '得知自己的科研成果荣获国际金奖的喜讯，整个实验室团队高兴得不得了。',
      'Dézhī zìjǐ de kēyán chéngguǒ rónghuò guójì jīnjiǎng de xǐxùn, zhěng gè shíyànshì tuánduì gāoxìng de bùdéliǎo.',
      'Được tin thành quả nghiên cứu khoa học của mình vinh dự đoạt huy chương vàng quốc tế, toàn thể đội ngũ phòng thí nghiệm vui mừng khôn xiết.',
      '"高兴得不得了" cực tả niềm hạnh phúc vỡ òa tột đỉnh khi đoạt giải thưởng danh giá thế giới.'
    ),
    (
      v_gp_id,
      '连续高强度加班了一个星期，大家身体都疲惫得不得了，迫切需要好好休整。',
      'Liánxù gāoqiángdù jiābān le yí gè xīngqī, dàjiā shēntǐ dōu píbèi de bùdéliǎo, pòqiè xūyào hǎohǎo xiūzhěng.',
      'Tăng ca cường độ cao liên tục suốt một tuần, cơ thể mọi người đều mệt mỏi rã rời ghê gớm, đang hết sức cần được nghỉ ngơi hồi phục.',
      '"疲惫得不得了" diễn tả sự suy kiệt thể lực cùng cực sau tuần làm việc căng thẳng.'
    );

  -- Điểm ngữ pháp #87: Bổ ngữ mức độ cực đoan dân dã "要命 / 要死" (Chết đi được / Muốn mạng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ mức độ cực đoan dân dã "要命 / 要死" (Chết đi được / Muốn mạng)',
    'Tính từ / Động từ tâm lý + 得要命 / 得要死',
    'Bổ ngữ',
    '"要命" (yàomìng) và "要死" (yàosǐ) là các bổ ngữ mức độ khẩu ngữ có tính phóng đại cao, dùng để đặc tả một trạng thái đau đớn, nóng bức, khát nước, hoặc nhớ nhung đến mức tưởng chừng như không chịu nổi tính mạng (chết đi được, đứt ruột).',
    'HSK 5',
    87,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在没有空调的车厢里熬了整整四个小时，车里闷热得要命。',
      'Zài méiyǒu kōngtiáo de chēxiāng lǐ áo le zhěngzhěng sì gè xiǎoshí, chē lǐ mēnrè de yàomìng.',
      'Chịu đựng tròn 4 tiếng đồng hồ trong toa xe không có điều hòa, bên trong xe nóng hầm hập chết đi được.',
      '"闷热得要命" phóng đại cảm giác bức bối oi ả không thể chịu đựng nổi.'
    ),
    (
      v_gp_id,
      '长跑比赛冲过终点线的那一刻，他只觉得双腿酸痛得要命，口渴得要死。',
      'Chángpǎo bǐsài chōngguò zhōngdiǎnxiàn de nà yí kè, tā zhǐ juéde shuāngtuǐ suāntòng de yàomìng, kǒukě de yàosǐ.',
      'Khoảnh khắc lao qua vạch đích cuộc thi chạy dài, anh ấy chỉ cảm thấy hai chân mỏi nhừ muốn chết, miệng khát khô cổ họng.',
      '"酸痛得要命" và "口渴得要死" diễn tả cảm giác thể xác mỏi nhừ và khát nước sau cuộc đua dài.'
    );

  -- Điểm ngữ pháp #88: Bổ ngữ xu hướng kép nghĩa trừu tượng "沉下去" (Lắng xuống / Chìm đắm / Hạ mình sâu sát)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng kép nghĩa trừu tượng "沉下去" (Lắng xuống / Chìm đắm / Hạ mình sâu sát)',
    'Động từ + 沉下去 / 沉下心来 + Động từ',
    'Bổ ngữ',
    '"沉下去" (chén xiàqu) khi làm bổ ngữ phái sinh trừu tượng mang hai tầng nghĩa cao cấp: 1) Cảm xúc nóng nảy, xáo động được kiềm chế, lắng đọng bình tâm trở lại (như 沉下心来 - tĩnh tâm lại); 2) Cán bộ, trí thức gạt bỏ bệnh quan liêu để đi sâu sát xuống tận cơ sở nhân dân (như 干部要沉下去).',
    'HSK 5',
    88,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '青年学者只有耐得住寂寞、真正沉下心来搞研究，才能产出具有开创性的成果。',
      'Qīngnián xuézhě zhǐyǒu nàidezhù jìmò, zhēnzhèng chén xià xīn lái gǎo yánjiū, cái néng chǎnchū jùyǒu kāichuàngxìng de chéngguǒ.',
      'Các học giả trẻ chỉ khi chịu được sự cô đơn tĩnh mịch, thực sự tĩnh tâm lại làm nghiên cứu, thì mới có thể cho ra đời những thành quả mang tính khai mở.',
      '"沉下心来" khuyên nhủ sự tĩnh tâm chuyên chú, không chạy theo hào nhoáng bề nổi.'
    ),
    (
      v_gp_id,
      '机关干部要主动沉下去，深入到田间地头倾听老百姓最真实的诉求。',
      'Jīguān gānbù yào zhǔdòng chén xiàqu, shēnrù dào tiánjiāndìtóu qīngtīng lǎobǎixìng zuì zhēnshí de sùqiú.',
      'Cán bộ cơ quan phải chủ động đi sâu sát xuống cơ sở, đi sâu tới tận bờ ruộng đầu làng lắng nghe những thỉnh cầu chân thực nhất của người dân.',
      '"主动沉下去" biểu thị tác phong lãnh đạo gần dân, sâu sát với thực tiễn đời sống.'
    );

  -- Điểm ngữ pháp #89: Bổ ngữ xu hướng kép nghĩa trừu tượng "浮上来" (Nổi lên / Hiện rõ ra bề mặt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng kép nghĩa trừu tượng "浮上来" (Nổi lên / Hiện rõ ra bề mặt)',
    'Động từ (显 / 浮 / 冒) + 浮上来 / 浮现在脑海中',
    'Bổ ngữ',
    '"浮上来" (fú shànglái) là phản nghĩa của "沉下去", biểu thị một mâu thuẫn, vấn đề tiềm ẩn từ chỗ bị che giấu bắt đầu bộc lộ rõ ràng trên bề mặt xã hội; hoặc hình ảnh, ký ức xưa cũ bỗng nhiên hiện về mồn một trong tâm trí con người.',
    'HSK 5',
    89,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '随着调查的逐步深入，那些隐藏多年的深层次管理漏洞终于彻底浮了上来。',
      'Suízhe diàochá de zhúbù shēnrù, nàxiē yǐncáng duō nián de shēncéngcì guǎnlǐ lòudòng zhōngyú chèdǐ fú le shànglái.',
      'Cùng với sự đi sâu từng bước của cuộc điều tra, những lỗ hổng quản lý tầng sâu bị che giấu nhiều năm cuối cùng đã hoàn toàn lộ rõ ra bề mặt.',
      '"浮了上来" ẩn dụ cho việc các sai phạm quản lý bị phơi bày trước ánh sáng công lý.'
    ),
    (
      v_gp_id,
      '望着远方故乡的明月，童年与祖母相依为命的温馨画面不禁浮现在眼前。',
      'Wàngzhe yuǎnfāng gùxiāng de míngyuè, tóngnián yǔ zǔmǔ xiāngyīwéimìng de wēnxīn huàmiàn bùjīn fúxiàn zài yǎnqián.',
      'Ngắm nhìn vầng trăng sáng nơi quê hương phương xa, bức tranh ấm áp thuở ấu thơ nương tựa bên bà nội bất giác hiện về mồn một trước mắt.',
      '"浮现在眼前" miêu tả dòng hồi ức êm đềm tái hiện sống động trong tâm trí người tha hương.'
    );

  -- Điểm ngữ pháp #90: Câu chữ 把 chính luận trang trọng: "把...置于..." (Đặt... vào vị trí)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 chính luận trang trọng: "把...置于..." (Đặt... vào vị trí)',
    'Chủ ngữ + 把 + Đối tượng trọng đại + 置于 + Vị trí chiến lược (核心地位 / 优先地位 / 首位)',
    'Câu chữ 把',
    'Trong các văn kiện chính trị, báo cáo đại hội và bình luận quốc tế, cấu trúc "把...置于..." (bǎ... zhìyú...) là mẫu câu kinh điển xác lập thứ tự ưu tiên chiến lược của một quốc gia, tổ chức (đặt đối tượng đó vào vị trí trung tâm, vị trí hàng đầu). "置" là từ văn ngôn của "放" (đặt).',
    'HSK 5',
    90,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们党始终把人民群众的生命安全和身体健康置于第一位。',
      'Wǒmen dǎng shǐzhōng bǎ rénmín qúnzhòng de shēngmìng ānquán hé shēntǐ jiànkāng zhìyú dìyīwèi.',
      'Đảng chúng ta luôn luôn đặt an toàn tính mạng và sức khỏe thân thể của quần chúng nhân dân vào vị trí hàng đầu.',
      '"把...置于第一位" khẳng định tôn chỉ tối thượng coi tính mạng nhân dân là trên hết.'
    ),
    (
      v_gp_id,
      '国家在现代化建设全局中，始终把科技自主创新置于核心地位。',
      'Guójiā zài xiàndàihuà jiànshè quánjú zhōng, shǐzhōng bǎ kējì zìzhǔ chuàngxīn zhìyú héxīn dìwèi.',
      'Nhà nước trong toàn cục công cuộc xây dựng hiện đại hóa luôn luôn đặt đổi mới sáng tạo tự chủ công nghệ vào vị trí cốt lõi.',
      '"把...置于核心地位" làm rõ tầm nhìn chiến lược phát triển công nghệ của quốc gia.'
    );

  -- Điểm ngữ pháp #91: Câu chữ 把 quy kết nguyên nhân: "把...归咎于..." (Quy tội cho / Đổ lỗi cho)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 quy kết nguyên nhân: "把...归咎于..." (Quy tội cho / Đổ lỗi cho)',
    'Chủ ngữ + 把 + Thất bại/Khó khăn/Trách nhiệm + 归咎于 + Đối tượng bên ngoài',
    'Câu chữ 把',
    '"把...归咎于..." (bǎ... guījiùyú...) là cấu trúc ngoại giao và bình luận xã hội sâu sắc, biểu thị việc đổ lỗi, quy trách nhiệm hoặc coi một kết quả thất bại là do một người, một nguyên nhân khách quan hoặc một thế lực bên ngoài gây ra (quy tội cho, đổ lỗi lên đầu). "咎" nghĩa là lỗi lầm, tai họa.',
    'HSK 5',
    91,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '遇到挫折时一味把自身失败归咎于外部环境，是缺乏担当与成熟的表现。',
      'Yùdào cuòzhé shí yíwèi bǎ zìshēn shībài guījiùyú wàibù huánjìng, shì quēfá dāndāng yǔ chéngshú de biǎoxiàn.',
      'Khi gặp trắc trở mà cứ một mực đổ lỗi thất bại của bản thân cho môi trường bên ngoài là biểu hiện của sự thiếu tinh thần gánh vác và thiếu chín chắn.',
      '"把自身失败归咎于外部环境" phê phán thái độ hèn nhát trốn tránh tự kiểm điểm bản thân.'
    ),
    (
      v_gp_id,
      '少数政客企图把国内经济问题归咎于别国的正当竞争，这种论调是毫无事实根据的。',
      'Shǎoshù zhèngkè qǐtú bǎ guónèi jīngjì wèntí guījiùyú biéguó de zhèngdàng jìngzhēng, zhè zhǒng lùndiào shì háowú shìshí gēnjù de.',
      'Một số ít chính khách mưu toan đổ lỗi cho các vấn đề kinh tế trong nước lên sự cạnh tranh chính đáng của nước khác, luận điệu này hoàn toàn không có căn cứ thực tế.',
      '"把...归咎于别国" bác bỏ thủ đoạn chính trị vô căn cứ nhằm chuyển hướng dư luận.'
    );

  -- Điểm ngữ pháp #92: Câu chữ 把 phân loại định danh: "把...列为..." (Liệt vào / Xếp vào danh sách)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 phân loại định danh: "把...列为..." (Liệt vào / Xếp vào danh sách)',
    'Chủ ngữ + 把 + Đối tượng + 列为 + Danh mục/Hạng mục ưu tiên (重点工程 / 保护对象 / 考察对象)',
    'Câu chữ 把',
    '"把...列为..." (bǎ... lièwéi...) biểu thị hành động chính thức xếp đặt, phân loại một sự vật, đối tượng vào một thứ bậc, danh mục hoặc hạng mục quản lý trọng điểm nào đó (liệt vào danh sách, coi là đối tượng). Thường dùng trong quản lý nhà nước, giáo dục và bảo tồn di sản.',
    'HSK 5',
    92,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '联合国教科文组织正式把这项古老的传统习俗列为人类非物质文化遗产代表作。',
      'Liánhéguó Jiàokēwén Zǔzhī zhèngshì bǎ zhè xiàng gǔlǎo de chuántǒng xísú lièwéi rénlèi fēiwùzhì wénhuà yíchǎn dàibiǎozuò.',
      'Tổ chức UNESCO đã chính thức ghi danh phong tục truyền thống cổ xưa này vào Danh sách Di sản Văn hóa Phi vật thể đại diện của Nhân loại.',
      '"把...列为...代表作" là thuật ngữ công nhận di sản văn hóa quốc tế chuẩn xác.'
    ),
    (
      v_gp_id,
      '市政府决定把改善老旧小区的供暖排污设施列为今年十件重点民生实事之一。',
      'Shì zhèngfǔ juédìng bǎ gǎishàn lǎojiù xiǎoqū de gōngnuǎn páiwū shèshī lièwéi jīnnián shí jiàn zhòngdiǎn mínshēng shíshì zhī yī.',
      'Chính quyền thành phố quyết định liệt việc cải tạo cơ sở hạ tầng sưởi ấm và thoát nước thải các khu tập thể cũ vào một trong mười việc dân sinh trọng điểm năm nay.',
      '"把...列为...实事之一" thể hiện ưu tiên phân bổ ngân sách cho phúc lợi nhân dân.'
    );

  -- Điểm ngữ pháp #93: Câu chữ 把 coi như định tính: "把...视作 / 视为..." (Coi... như là / Xem... là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 coi như định tính: "把...视作 / 视为..." (Coi... như là / Xem... là)',
    'Chủ ngữ + 把 + Đối tượng A + 视作 / 视为 + Đối tượng B (sinh mệnh / tấm gương / kim chỉ nam)',
    'Câu chữ 把',
    '"把...视作 / 视为..." (bǎ... shìzuò / shìwéi...) là dạng trang trọng tương đương với "把...当作 / 认作", mang nghĩa nhìn nhận, đánh giá và đối đãi với một sự vật theo một vị thế, tầm vóc hoặc phẩm chất đặc biệt thiêng liêng (coi là, xem như). "视" là động từ văn ngôn của "看" (nhìn).',
    'HSK 5',
    93,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '真正的科学家把探索未知的客观真理视作自己毕生最高的职业荣誉。',
      'Zhēnzhèng de kēxuéjiā bǎ tànsuǒ wèizhī de kèguān zhēnlǐ shìzuò zìjǐ bìshēng zuì gāo de zhíyè róngyù.',
      'Người làm khoa học chân chính coi việc tìm tòi chân lý khách quan chưa biết là niềm vinh dự nghề nghiệp cao quý nhất cả đời mình.',
      '"把探索真理视作最高荣誉" định nghĩa lý tưởng khoa học cống hiến thuần túy.'
    ),
    (
      v_gp_id,
      '这所百年名校始终把立德树人视为学校教育教学工作的根本任务。',
      'Zhè suǒ bǎinián míngxiào shǐzhōng bǎ lìdéshùrén shìwéi xuéxiào jiàoyù jiàoxué gōngzuò de gēnběn rènwu.',
      'Ngôi trường danh tiếng trăm năm tuổi này luôn luôn xem việc bồi dưỡng đạo đức trồng người là nhiệm vụ căn bản của công tác giảng dạy nhà trường.',
      '"把立德树人视为根本任务" khẳng định triết lý giáo dục lấy nhân cách làm gốc.'
    );

  -- Điểm ngữ pháp #94: Câu bị động văn viết kinh điển "为...所..." / "被...所..." (Bị/Được... làm cho...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu bị động văn viết kinh điển "为...所..." / "被...所..." (Bị/Được... làm cho...)',
    'Chủ ngữ + 为 / 被 + Tác nhân + 所 + Động từ song âm tiết (吸引 / 感动 / 熟知 / 震撼 / 蒙蔽)',
    'Câu bị động',
    'Kết cấu "为...所..." hoặc "被...所..." (wèi... suǒ... / bèi... suǒ...) là mẫu câu bị động trang nhã kế thừa từ cổ văn Hán ngữ, rất phổ biến trong văn học và báo chí hiện đại. "所" đứng trước động từ ngoại động từ song âm tiết nhằm làm nổi bật sự tác động sâu sắc của tác nhân lên chủ thể (như 为大家所熟知 - được mọi người biết tới rộng rãi, 被其美景所折服).',
    'HSK 5',
    94,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '初次来到桂林山水的海内外游客，无一不被大自然鬼斧神工的绝美风光所深深震撼。',
      'Chūcì láidào Guìlín shānshuǐ de hǎinèiwài yóukè, wúyībù bèi dàzìrán guǐfǔshéngōng de juéměi fēngguāng suǒ shēnshēn zhènhàn.',
      'Những du khách trong và ngoài nước lần đầu tới non nước Quế Lâm, không một ai là không bị cảnh sắc tuyệt mỹ tài tình của tạo hóa làm cho chấn động sâu sắc.',
      '"被...风光所深深震撼" lột tả sự choáng ngợp tột cùng trước vẻ đẹp thiên nhiên kỳ vĩ.'
    ),
    (
      v_gp_id,
      '这位默默扎根边疆三十二年的乡村教师的事迹，早已为全国广大人民所熟知与传颂。',
      'Zhè wèi mòmò zhāgēn biānjiāng sānshí''èr nián de xiāngcūn jiàoshī de shìjì, zǎoyǐ wéi quánguó guǎngdà rénmín suǒ shúzhī yǔ chuánsòng.',
      'Tấm gương người thầy giáo nông thôn thầm lặng cắm rễ nơi biên ải suốt 32 năm này từ lâu đã được đông đảo nhân dân cả nước biết đến và truyền tụng.',
      '"为广大人民所熟知" dùng "为...所..." trang trọng khẳng định sự ghi nhận của toàn xã hội.'
    );

  -- Điểm ngữ pháp #95: Câu bị động ủy thác thẩm quyền "受...委托 / 指派" (Nhận ủy thác / Được chỉ định bởi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu bị động ủy thác thẩm quyền "受...委托 / 指派" (Nhận ủy thác / Được chỉ định bởi)',
    'Chủ ngữ + 受 + Cơ quan/Cá nhân giao phó + (的) 委托 / 指派, Động từ thực hiện công vụ',
    'Câu bị động',
    '"受...委托" (shòu... wěituō) là cấu trúc pháp lý và hành chính chính thức, trong đó "受" đóng vai trò thụ nhận (nhận sự ủy quyền). Dùng để xác nhận tư cách pháp nhân hợp pháp của đại diện luật sư, phát ngôn viên hoặc tổ thanh tra khi thực thi nhiệm vụ được ủy thác.',
    'HSK 5',
    95,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '受当事人家属的正式委托，该律师事务所已向人民法院递交了无罪辩护申请书。',
      'Shòu dāngshìrén jiāshǔ de zhèngshì wěituō, gāi lǜshī shìwùsuǒ yǐ xiàng rénmín fǎyuàn dìjiāo le wúzuì biànhù shēnqǐngshū.',
      'Nhận sự ủy thác chính thức từ gia quyến của đương sự, văn phòng luật sư này đã nộp đơn xin bào chữa vô tội lên Tòa án Nhân dân.',
      '"受...正式委托" xác lập tư cách đại diện pháp lý hợp pháp của đoàn luật sư tranh tụng.'
    ),
    (
      v_gp_id,
      '受国务院指派，由部委专家组成的联合调查组已于今日清晨紧急赶赴事故现场。',
      'Shòu Guówùyuàn zhǐpài, yóu bùwěi zhuānjiā zǔchéng de liánhé diàocházǔ yǐ yú jīnrì qīngchén jǐnjí gǎnfù shìgù xiànchǎng.',
      'Được Quốc vụ viện chỉ định, tổ điều tra liên ngành do các chuyên gia các bộ ngành tạo thành đã khẩn cấp tới hiện trường vụ tai nạn vào sáng sớm hôm nay.',
      '"受国务院指派" công bố thẩm quyền cấp cao nhất của đoàn công tác chính phủ.'
    );

  -- Điểm ngữ pháp #96: Cấu trúc câu phản vấn hùng biện bác bỏ "岂不是...？" (Há chẳng phải là... sao?)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc câu phản vấn hùng biện bác bỏ "岂不是...？" (Há chẳng phải là... sao?)',
    'Nếu làm theo phương án sai lầm, 岂不是 + Hậu quả phi lý / Sai lầm tày đình + 吗 / 呢？',
    'Cấu trúc cố định',
    '"岂不是...？" (qǐbúshì...?) là mẫu câu hỏi tu từ văn ngôn kinh điển (chữ 岂 nghĩa là há, lẽ nào; 岂不是 = há chẳng phải là). Dùng trong văn phong nghị luận sắc bén để phản bác một luận điểm phi lý, bằng cách chỉ ra rằng nếu làm như vậy thì há chẳng phải sẽ dẫn tới một kết cục nực cười, mâu thuẫn hay sao.',
    'HSK 5',
    96,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '只顾追求眼前的短期暴利而肆意破坏赖以生存的青山绿水，这岂不是杀鸡取卵、自掘坟墓吗？',
      'Zhǐgù zhuīqiú yǎnqián de duǎnqī bàolì ér sìyì pòhuài làiyǐshēngcún de qīngshān lǜshuǐ, zhè qǐbúshì shājīqǔluǎn, zìjuéfénmù ma?',
      'Chỉ mải miết mưu cầu món siêu lợi nhuận ngắn hạn trước mắt mà ngang nhiên tàn phá non xanh nước biếc nơi ta nương tựa sinh tồn, điều này há chẳng phải là giết gà lấy trứng, tự đào mồ chôn mình hay sao?',
      '"这岂不是...吗？" dùng câu hỏi tu từ cực kỳ đanh thép lên án tội ác hủy hoại môi trường sống.'
    ),
    (
      v_gp_id,
      '如果连遵纪守法的诚实公民都得不到法律的保护，法治社会的尊严又岂不是形同虚设？',
      'Rúguǒ lián zūnjìshǒufǎ de chéngshí gōngmín dōu débúdào fǎlǜ de bǎohù, fǎzhì shèhuì de zūnyán yòu qǐbúshì xíngtóngxūshè?',
      'Nếu ngay cả những công dân trung thực tuân thủ kỷ cương pháp luật mà cũng không nhận được sự bảo vệ của luật pháp, thì phẩm giá của xã hội pháp quyền há chẳng phải chỉ là hình thức rỗng tuếch sao?',
      '"岂不是形同虚设" chất vấn tận gốc rễ giá trị thực thi công lý của bộ máy nhà nước.'
    );

  -- Điểm ngữ pháp #97: Cấu trúc cố định khẳng định chân lý không thể bàn cãi: "毫无疑问"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định khẳng định chân lý không thể bàn cãi: "毫无疑问"',
    '毫无疑问, Mệnh đề khẳng định chân lý / 是毫无疑问的',
    'Cấu trúc cố định',
    '"毫无疑问" (háowú yíwèn) biểu thị tính xác thực 100% không còn một chút mảy may nghi ngờ nào (không thể nghi ngờ, chắc chắn không thể chối cãi). Có thể đứng độc lập đầu câu làm trạng ngữ hoặc đứng cuối câu làm bổ ngữ vị ngữ.',
    'HSK 5',
    97,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '毫无疑问，绿色低碳转型是全球工业未来实现可持续发展的必由之路。',
      'Háowú yíwèn, lǜsè dītàn zhuǎnxíng shì quánqiú gōngyè wèilái shíxiàn kěchíxù fāzhǎn de bìyóuzhīlù.',
      'Không còn nghi ngờ gì nữa, chuyển dịch xanh giảm thiểu carbon là con đường tất yếu duy nhất để công nghiệp toàn cầu thực hiện phát triển bền vững trong tương lai.',
      '"毫无疑问" đứng đầu câu khẳng định tính tất yếu khách quan của xu hướng kinh tế xanh.'
    ),
    (
      v_gp_id,
      '在整场抢险救灾战役中，广大官兵付出的巨大牺牲与卓越功绩是毫无疑问的。',
      'Zài zhěng chǎng qiǎngxiǎn jiùzāi zhànyì zhōng, guǎngdà guānbīng fùchū de jùdà xīshēng yǔ zhuóyuè gōngjì shì háowú yíwèn de.',
      'Trong toàn bộ chiến dịch cứu hộ chống thiên tai, sự hy sinh to lớn và chiến công xuất sắc mà đông đảo cán bộ chiến sĩ bỏ ra là điều không còn nghi ngờ gì nữa.',
      '"是毫无疑问的" kết thúc câu khẳng định công lao bất tử của người lính cứu hộ.'
    );

  -- Điểm ngữ pháp #98: Cấu trúc cố định quy nạp nguyên nhân sâu xa: "归根结底"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định quy nạp nguyên nhân sâu xa: "归根结底"',
    '归根结底, Mệnh đề bản chất cốt lõi / Căn nguyên nằm ở...',
    'Cấu trúc cố định',
    '"归根结底" (guīgēn jiédǐ) biểu thị sau khi gạt bỏ toàn bộ những hiện tượng bề ngoài, chi tiết rườm rà, ta truy tìm đến tận gốc rễ, cội nguồn sâu xa nhất của vấn đề (suy cho cùng, rốt ráo, rốt cuộc quy về một mối). Đây là thành ngữ kết luận phân tích triết học kinh điển.',
    'HSK 5',
    98,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '现代企业之间的市场竞争，归根结底是高素质核心人才储备与创新能力的竞争。',
      'Xiàndài qǐyè zhījiān de shìchǎng jìngzhēng, guīgēn jiédǐ shì gāosùzhì héxīn réncái chǔbèi yǔ chuàngxīn nénglì de jìngzhēng.',
      'Cạnh tranh thị trường giữa các doanh nghiệp hiện đại, suy cho cùng chính là sự cạnh tranh về nguồn dự trữ nhân tài cốt lõi chất lượng cao và năng lực đổi mới sáng tạo.',
      '"归根结底是...竞争" quy nạp bản chất cạnh tranh kinh tế về yếu tố con người nhân tài.'
    ),
    (
      v_gp_id,
      '解决人民群众看病难、住房难的问题，归根结底要靠国家经济实力的不断壮大与科学治理。',
      'Jiějué rénmín qúnzhòng kànbìng nán, zhùfáng nán de wèntí, guīgēn jiédǐ yào kào guójiā jīngjì shílì de búduàn zhuàngdà yǔ kēxué zhìlǐ.',
      'Giải quyết vấn đề khám chữa bệnh khó, nhà ở khó của quần chúng nhân dân, rốt ráo phải dựa vào tiềm lực kinh tế quốc gia không ngừng lớn mạnh và nền quản trị khoa học.',
      '"归根结底要靠..." chỉ ra chiếc chìa khóa vạn năng giải quyết vấn đề an sinh xã hội.'
    );

  -- Điểm ngữ pháp #99: Cấu trúc cố định nhận định hiển nhiên: "显而易见"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định nhận định hiển nhiên: "显而易见"',
    '显而易见, Mệnh đề sự thật / ...的效果是显而易见的',
    'Cấu trúc cố định',
    '"显而易见" (xiǎn''ér yìjiàn) biểu thị sự thật, logic hoặc kết quả hiển lộ rõ ràng trước mắt, dễ thấy dễ hiểu mà bất kỳ ai có lý trí cũng đều nhận ra mà không cần phải tranh cãi (rõ ràng như ban ngày, hiển nhiên dễ thấy).',
    'HSK 5',
    99,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '吸烟严重危害人体呼吸系统健康，这一科学事实早已显而易见。',
      'Xīyān yánzhòng wēihài réntǐ hūxī xìtǒng jiànkāng, zhè yì kēxué shìshí zǎoyǐ xiǎn''ér yìjiàn.',
      'Hút thuốc lá gây nguy hại nghiêm trọng cho sức khỏe hệ hô hấp của cơ thể người, sự thật khoa học này từ lâu đã là điều hiển nhiên dễ thấy.',
      '"显而易见" khẳng định tác hại của thuốc lá là chân lý y học phổ biến được toàn cầu thừa nhận.'
    ),
    (
      v_gp_id,
      '显而易见，如果不能从源头上遏制工业废水排放，下游的生态治理都将徒劳无功。',
      'Xiǎn''ér yìjiàn, rúguǒ bù néng cóng yuántóu shang èzhì gōngyè fèishuǐ páifàng, xiàyóu de shēngtài zhìlǐ dōu jiāng túláowúgōng.',
      'Rõ ràng dễ thấy, nếu không thể kiềm chế xả thải nước thải công nghiệp từ thượng nguồn, mọi nỗ lực xử lý sinh thái ở hạ lưu đều sẽ trở nên vô ích.',
      '"显而易见" đứng đầu câu nhấn mạnh nguyên lý xử lý ô nhiễm môi trường từ gốc rễ.'
    );

  -- Điểm ngữ pháp #100: Cấu trúc cố định chân lý ngầm hiểu: "不言而喻"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định chân lý ngầm hiểu: "不言而喻"',
    '...的重要性 / 意义 / 价值 是不言而喻的',
    'Cấu trúc cố định',
    '"不言而喻" (bùyán ér yù) kết hợp chữ 言 (nói) và 喻 (hiểu rõ), mang nghĩa đạo lý, ý nghĩa hoặc tầm quan trọng quá rõ ràng, không cần mở lời giải thích mà tự nó đã sáng tỏ và ai nấy đều tự hiểu (không nói cũng hiểu, tự nó đã rõ ràng).',
    'HSK 5',
    100,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在激烈的知识经济时代，终身学习对于保持个人竞争力的重要性是不言而喻的。',
      'Zài jīliè de zhīshi jīngjì shídài, zhōngshēn xuéxí duìyú bǎochí gèrén jìngzhēnglì de zhòngyàoxìng shì bùyán''éryù de.',
      'Trong thời đại kinh tế tri thức gay gắt, tầm quan trọng của việc học tập suốt đời đối với việc duy trì sức cạnh tranh cá nhân là điều không nói cũng hiểu.',
      '"重要性是不言而喻的" là cụm từ quán dụng khẳng định chân lý của tinh thần học tập cả đời.'
    ),
    (
      v_gp_id,
      '父母言传身教对未成年子女品格养成所起的深远熏陶作用，自然是不言而喻的。',
      'Fùmǔ yánchuánshēnjiào duì wèichéngnián zǐnǚ pǐngé yǎngchéng suǒ qǐ de shēnyuǎn xūntáo zuòyòng, zìrán shì bùyán''éryù de.',
      'Tác dụng hun đúc sâu xa của việc cha mẹ làm gương dạy bảo đối với sự hình thành phẩm cách của con cái vị thành niên đương nhiên là điều tự rõ không cần nói.',
      '"自然是不言而喻的" làm nổi bật vai trò gia giáo thiêng liêng của đấng sinh thành.'
    );

  -- Điểm ngữ pháp #101: Cấu trúc cố định điểm nhấn đặc sắc: "值得一提的是"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định điểm nhấn đặc sắc: "值得一提的是"',
    '值得一提的是, Mệnh đề thông tin nổi bật / thành tựu bất ngờ',
    'Cấu trúc cố định',
    '"值得一提的是" (zhíde yì tí de shì) dùng trong các bài báo giới thiệu dự án, tác phẩm hoặc tường thuật sự kiện để hướng sự chú ý của độc giả vào một chi tiết, một thành tựu hoặc điểm sáng đặc biệt xuất sắc đáng được biểu dương (điều rất đáng nhắc tới ở đây là).',
    'HSK 5',
    101,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这次大型文化交流博览会取得了圆满成功，特别值得一提的是，青年志愿者们的专业素养博得了外宾的一致赞赏。',
      'Zhè cì dàxíng wénhuà jiāoliú bólǎnhuì qǔdé le yuánmǎn chénggōng, tèbié zhíde yì tí de shì, qīngnián zhìyuànzhěmen de zhuānyè sùyǎng bódé le wàibīn de yízhì zànshǎng.',
      'Hội chợ triển lãm giao lưu văn hóa quy mô lớn lần này đã gặt hái thành công mỹ mãn, điều đặc biệt rất đáng nhắc tới là tố chất chuyên nghiệp của các tình nguyện viên trẻ tuổi đã nhận được lời khen ngợi nhất trí của bạn bè quốc tế.',
      '"值得一提的是..." điểm xuyết sự cống hiến thầm lặng nhưng sáng chói của các bạn thanh niên tình nguyện.'
    ),
    (
      v_gp_id,
      '该款国产大飞机不仅性能达到了国际一流标准，值得一提的是，其核心零部件的国产化率高达百分之九十。',
      'Gāi kuǎn guóchǎn dà fēijī bùjǐn xìngnéng dádào le guójì yīliú biāozhǔn, zhíde yì tí de shì, qí héxīn língbùjiàn de guóchǎnhuàlǜ gāodá bǎi fēn zhī jiǔshí.',
      'Chiếc máy bay cỡ lớn sản xuất nội địa này không chỉ có tính năng đạt tiêu chuẩn hàng đầu quốc tế, điều đáng tự hào nhắc tới là tỷ lệ nội địa hóa các linh kiện cốt lõi của nó lên tới 90%.',
      '"值得一提的是..." làm nổi bật bước đột phá độc lập tự chủ công nghiệp hàng không của đất nước.'
    );

  -- Điểm ngữ pháp #102: Cấu trúc cố định biểu thị lợi ích thúc đẩy: "有助于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định biểu thị lợi ích thúc đẩy: "有助于"',
    'Biện pháp / Thói quen tốt + 有助于 + Thúc đẩy / Nâng cao / Giải quyết vấn đề',
    'Cấu trúc cố định',
    '"有助于" (yǒuzhùyú) kết hợp chữ 有 (có), 助 (trợ giúp, có lợi) và 于 (đối với), mang nghĩa "có sự giúp ích to lớn đối với, góp phần thúc đẩy vào". Thường đi với các động từ phát triển như 提高, 促进, 加强, 改善, 推动.',
    'HSK 5',
    102,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '保持充足的睡眠与均衡的营养摄入，有助于全面增强人体的免疫抵抗力。',
      'Bǎochí chōngzú de shuìmián yǔ jūnhéng de yíngyǎng shèrù, yǒuzhùyú quánmiàn zēngqiáng réntǐ de miǎnyì dǐkànglì.',
      'Duy trì giấc ngủ đầy đủ cùng lượng dinh dưỡng nạp vào cân đối góp phần tăng cường toàn diện sức đề kháng miễn dịch của cơ thể con người.',
      '"有助于全面增强..." giải thích tác dụng y học tích cực của lối sống điều độ khoa học.'
    ),
    (
      v_gp_id,
      '加强两国青年学者之间的学术往来，有助于加深彼此青年一代的友谊与相互理解。',
      'Jiāqiáng liǎng guó qīngnián xuézhě zhījiān de xuéshù wǎnglái, yǒuzhùyú jiāshēn bǐcǐ qīngnián yídài de yǒuyì yǔ xiānghù lǐjiě.',
      'Tăng cường giao lưu học thuật giữa các học giả trẻ hai nước góp phần làm sâu sắc thêm tình hữu nghị và sự thấu hiểu lẫn nhau của thế hệ trẻ đôi bên.',
      '"有助于加深...友谊" khẳng định ý nghĩa nhịp cầu giao lưu văn hóa ngoại giao nhân dân.'
    );

  -- Điểm ngữ pháp #103: Cấu trúc hành chính trang trọng giải quyết công vụ: "动词 + 予以"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc hành chính trang trọng giải quyết công vụ: "动词 + 予以"',
    '予以 + Động từ song âm tiết (批准 / 支持 / 澄清 / 考虑 / 驳回 / 惩罚)',
    'Cấu trúc cố định',
    '"予以" (yǔyǐ) là động từ hỗ trợ hành chính văn thư cao cấp mang nghĩa "cho phép, tiến hành, đưa ra sự xử lý" (kết hợp 与: cho, 以: bằng). Đi trước các động từ hai chữ biểu thị sự giải quyết công vụ chính thức như 予以批准 (cho phép phê chuẩn), 予以支持 (dành sự ủng hộ), 予以驳回 (bác bỏ), 予以免职 (cho thôi chức).',
    'HSK 5',
    103,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '对于受灾群众面临的实际生活困难，各级民政部门应当在政策范围内予以优先救助。',
      'Duìyú shòuzāi qúnzhòng miànlín de shíjì shēnghuó kùnnan, gèjí mínzhèng bùmén yīngdāng zài zhèngcè fànwéi nèi yǔyǐ yōuxiān jiùzhù.',
      'Đối với những khó khăn trong đời sống thực tế mà quần chúng vùng bị thiên tai đang đối mặt, các cấp ban ngành dân chính cần phải dành sự cứu trợ ưu tiên trong phạm vi chính sách.',
      '"予以优先救助" là thuật ngữ hành chính nhà nước yêu cầu cấp bách cứu tế nhân dân.'
    ),
    (
      v_gp_id,
      '对于一切企图分裂国家、破坏社会稳定的恶劣行径，司法机关必须依法予以坚决打击。',
      'Duìyú yíqiè qǐtú fēnliè guójiā, pòhuài shèhuì wěndìng de èliè xíngjìng, sīfǎ jīguān bìxū yīfǎ yǔyǐ jiānjué dǎjī.',
      'Đối với mọi hành vi ác ý mưu toan chia rẽ đất nước, phá hoại ổn định xã hội, cơ quan tư pháp bắt buộc phải kiên quyết giáng đòn trừng phạt theo đúng pháp luật.',
      '"予以坚决打击" thể hiện tính nghiêm minh không khoan nhượng của luật pháp quốc gia.'
    );

  -- Điểm ngữ pháp #104: Cấu trúc can thiệp xử lý đối tượng: "动词 + 加以"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc can thiệp xử lý đối tượng: "动词 + 加以"',
    '对 / 对于 + Đối tượng, 必须 / 应当 + 加以 + Động từ song âm tiết (解决 / 限制 / 引导 / 保护 / 改进)',
    'Cấu trúc cố định',
    '"加以" (jiāyǐ) là động từ hình thức cao cấp trong văn viết chính luận, đứng trước các động từ ngoại động từ song âm tiết để biểu thị việc thực thi một hành động tác động lên đối tượng được nhắc tới trước đó (tiến hành, áp dụng biện pháp). Thường đi với 解决 (giải quyết), 限制 (hạn chế), 引导 (định hướng), 保护 (bảo vệ).',
    'HSK 5',
    104,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '对于网络虚假信息的泛滥蔓延，相关监管部门必须及时加以严格规范与严厉治理。',
      'Duìyú wǎngluò xūjiǎ xìnxī de fànlàn mànyán, xiāngguān jiānguǎn bùmén bìxū jíshí jiāyǐ yángé guīfàn yǔ yánlì zhìlǐ.',
      'Đối với sự tràn lan lan truyền của thông tin giả mạo trên không gian mạng, các cơ quan giám sát hữu quan bắt buộc phải kịp thời tiến hành quy chuẩn nghiêm ngặt và quản trị nghiêm minh.',
      '"加以严格规范与治理" dùng "加以" chỉ đạo triển khai biện pháp quản lý không gian mạng.'
    ),
    (
      v_gp_id,
      '青年人在树立正确价值观的关键时期，家庭和学校应当耐心加以正面启发与引导。',
      'Qīngniánrén zài shùlì zhèngquè jiàzhíguān de guānjiàn shíqī, jiātíng hé xuéxiào yīngdāng nàixīn jiāyǐ zhèngmiàn qǐfā yǔ yǐndǎo.',
      'Thanh niên trong giai đoạn then chốt hình thành hệ giá trị đúng đắn, gia đình và nhà trường cần nhẫn nại tiến hành gợi mở và định hướng tích cực.',
      '"加以正面启发与引导" nhấn mạnh phương pháp sư phạm kiên trì định hướng thế hệ trẻ.'
    );

  -- Điểm ngữ pháp #105: Cấu trúc cố định quy định phạm vi pháp lý: "在...范围内" / "在...框架下"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định quy định phạm vi pháp lý: "在...范围内" / "在...框架下"',
    '在 + Pháp luật / Thẩm quyền / Khế ước + 的范围内 / 框架下, Tiến hành hành vi',
    'Cấu trúc cố định',
    '"在...范围内" (trong phạm vi) và "在...框架下" (dưới khuôn khổ) là hai công thức chuẩn xác xác lập giới hạn hợp pháp, biên độ cho phép của một hành động quản trị, giao dịch thương mại hoặc hợp tác quốc tế.',
    'HSK 5',
    105,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '任何组织和个人行使自身民事权利时，都必须严格在宪法和法律规定的范围内进行。',
      'Rènhé zǔzhī hé gèrén xíngshǐ zìshēn mínshì quánlì shí, dōu bìxū yángé zài xiànfǎ hé fǎlǜ guīdìng de fànwéi nèi jìnxíng.',
      'Bất kỳ tổ chức và cá nhân nào khi thực thi quyền dân sự của bản thân đều phải tiến hành nghiêm ngặt trong phạm vi mà hiến pháp và pháp luật quy định.',
      '"在宪法和法律规定的范围内" khẳng định ranh giới tối thượng của nhà nước pháp quyền.'
    ),
    (
      v_gp_id,
      '两国将继续在联合国等多边国际框架下，加强应对气候变化领域的密切合作。',
      'Liǎng guó jiāng jìxù zài Liánhéguó děng duōbiān guójì kuàngjià xià, jiāqiáng yìngduì qìhòu biànhuà lǐngyù de mìqiè hézuò.',
      'Hai nước sẽ tiếp tục tăng cường hợp tác chặt chẽ trong lĩnh vực ứng phó biến đổi khí hậu dưới khuôn khổ quốc tế đa phương như Liên Hợp Quốc.',
      '"在...多边国际框架下" là thuật ngữ hợp tác ngoại giao đa phương chính thống.'
    );

  -- Điểm ngữ pháp #106: Cấu trúc cố định định vị quá trình phát triển thời đại: "随着...的深入"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định định vị quá trình phát triển thời đại: "随着...的深入"',
    '随着 + Đề án/Nghiên cứu/Cải cách + 的深入 (推进/开展), Mệnh đề hệ quả',
    'Cấu trúc cố định',
    '"随着...的深入" (suízhe... de shēnrù) là cấu trúc mở màn kinh điển trong các bài luận văn, báo cáo thời sự, biểu thị sự việc, đề án đang đi vào giai đoạn chiều sâu, thực chất và toàn diện hơn, từ đó kéo theo chuỗi biến đổi tích cực tương ứng.',
    'HSK 5',
    106,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '随着新一轮课程教学改革的深入推进，学生们的自主探究能力得到了显著提高。',
      'Suízhe xīn yì lún kèchéng jiàoxué gǎigé de shēnrù tuījìn, xuéshengmen de zìzhǔ tànjiū nénglì dédào le xiǎnzhù tígāo.',
      'Cùng với sự thúc đẩy đi vào chiều sâu của đợt cải cách giảng dạy chương trình mới, năng lực tự chủ tìm tòi của học sinh đã được nâng cao rõ rệt.',
      '"随着...深入推进" ghi nhận thành quả cụ thể theo từng giai đoạn của đề án cải cách giáo dục.'
    ),
    (
      v_gp_id,
      '随着现代医学对大脑奥秘研究的逐步深入，人类征服阿尔茨海默病迎来了崭新的曙光。',
      'Suízhe xiàndài yīxué duì dànǎo àomì yánjiū de zhúbù shēnrù, rénlèi zhēngfú ā''ěrcíhǎimòbìng yínglái le zhǎnxīn de shǔguāng.',
      'Cùng với sự đi sâu từng bước của y học hiện đại đối với việc nghiên cứu bí ẩn bộ não, nhân loại chinh phục căn bệnh Alzheimer đã đón chào ánh bình minh hoàn toàn mới.',
      '"随着...逐步深入" miêu tả bước tiến khoa học thần kinh mở ra hy vọng chữa bệnh cho loài người.'
    );

  -- Điểm ngữ pháp #107: Cấu trúc cố định chỉ nhân tố quyết định sống còn: "取决于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định chỉ nhân tố quyết định sống còn: "取决于"',
    'Sự thành bại / Tương lai của A, 取决于 + Nhân tố cốt lõi B',
    'Cấu trúc cố định',
    '"取决于" (qǔjuéyú) biểu thị kết quả, số phận, sự thành bại hoặc hướng phát triển của một sự vật phụ thuộc hoàn toàn vào một nhân tố then chốt làm điều kiện chi phối (do... quyết định, phụ thuộc cốt yếu vào).',
    'HSK 5',
    107,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '一个科研团队能否攀登科学高峰，很大程度上取决于全体成员是否具有坚忍不拔的毅力。',
      'Yí gè kēyán tuánduì néngfǒu pāndēng kēxué gāofēng, hěn dà chéngdù shang qǔjuéyú quántǐ chéngyuán shìfǒu jùyǒu jiānrěnbùbá de yìlì.',
      'Một nhóm nghiên cứu khoa học có thể leo lên đỉnh cao khoa học hay không phần lớn phụ thuộc vào việc toàn thể thành viên có ý chí kiên định không dời hay không.',
      '"取决于...毅力" chỉ ra nhân tố quyết định thành bại của đề tài nghiên cứu chính là nghị lực con người.'
    ),
    (
      v_gp_id,
      '谈判最终能否达成实质性协议，完全取决于双方在核心关切问题上所展现的诚意。',
      'Tánpàn zuìzhōng néngfǒu dáchéng shízhìxìng xiéyì, wánquán qǔjuéyú shuāngfāng zài héxīn guānqiè wèntí shang suǒ zhǎnxiàn de chéngyì.',
      'Cuộc đàm phán cuối cùng có thể đạt được hiệp định thực chất hay không phụ thuộc hoàn toàn vào thành ý mà đôi bên thể hiện trên các vấn đề quan ngại cốt lõi.',
      '"完全取决于...诚意" xác định thành ý thiện chí là chìa khóa mở nút thắt đàm phán.'
    );

  -- Điểm ngữ pháp #108: Cấu trúc cố định truy nguyên cội nguồn: "源于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định truy nguyên cội nguồn: "源于"',
    'Hiện tượng / Tư tưởng / Sức mạnh + 源于 + Cội nguồn thực tế / Đời sống nhân dân',
    'Cấu trúc cố định',
    '"源于" (yuányú) biểu thị một tác phẩm nghệ thuật, tư tưởng triết học hoặc sức mạnh vĩ đại bắt nguồn từ hoặc bắt rễ sâu xa từ thực tiễn đời sống, lịch sử hoặc sự tích lũy lâu đời (kết hợp 源: nguồn nước, 于: từ). Công thức văn học nổi tiếng: "艺术源于生活，又高于生活".',
    'HSK 5',
    108,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '优秀的文学艺术创作必须牢牢植根于人民群众，因为一切真正的艺术灵感都源于火热的现实生活。',
      'Yōuxiù de wénxué yìshù chuàngzuò bìxū láoláo zhígēnyú rénmín qúnzhòng, yīnwèi yíqiè zhēnzhèng de yìshù línggǎn dōu yuányú huǒrè de xiànshí shēnghuó.',
      'Sáng tác văn học nghệ thuật xuất sắc bắt buộc phải cắm rễ sâu chắc vào quần chúng nhân dân, bởi vì mọi cảm hứng nghệ thuật chân chính đều bắt nguồn từ đời sống hiện thực sôi động.',
      '"艺术灵感都源于生活" trích dẫn triết lý nghệ thuật kinh điển về cội nguồn sáng tạo.'
    ),
    (
      v_gp_id,
      '中华文明之所以历经数千年风雨而生生不息，源于其海纳百川的包容精神与自强不息的品格。',
      'Zhōnghuá wénmíng zhīsuǒyǐ lìjīng shù qiān nián fēngyǔ ér shēngshēngbùxī, yuányú qí hǎinàbǎichuān de bāoróng jīngshén yǔ zìqiángbùxī de pǐngé.',
      'Văn minh Trung Hoa sở dĩ trải qua hàng nghìn năm phong ba mà vẫn trường tồn phát triển không ngừng, là bắt nguồn từ tinh thần bao dung như biển lớn dung nạp trăm sông và phẩm cách tự lực tự cường.',
      '"源于其...包容精神" giải thích sức sống trường tồn của nền văn minh cổ đại.'
    );

  -- Điểm ngữ pháp #109: Cặp cấu trúc phẩm chất lãnh đạo đối ứng: "勇于" vs "善于"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cặp cấu trúc phẩm chất lãnh đạo đối ứng: "勇于" vs "善于"',
    '勇于 + Đối mặt/Chấp nhận gian nan (担当 / 创新 / 承认错误) & 善于 + Kỹ năng thông thái (沟通 / 总结 / 发现人才)',
    'Cấu trúc cố định',
    'Đây là cặp từ ghép chính luận song hành miêu tả bản lĩnh và trí tuệ của người lãnh đạo: 1) "勇于" (dũng cảm, dám đương đầu với khó khăn mạo hiểm, dám chịu trách nhiệm); 2) "善于" (giỏi về, khéo léo, có tài năng và phương pháp khoa học để xử lý tình huống).',
    'HSK 5',
    109,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '一名优秀的团队领袖不仅要勇于承担责任风险，更要善于倾听并凝聚全体成员的智慧。',
      'Yì míng yōuxiù de tuánduì lǐngxiù bùjǐn yào yǒngyú chéngdān zérèn fēngxiǎn, gèng yào shànyú qīngtīng bìng níngjù quántǐ chéngyuán de zhìhuì.',
      'Một người lãnh đạo đội ngũ xuất sắc chẳng những phải dũng cảm gánh vác rủi ro trách nhiệm, mà càng phải giỏi lắng nghe và quy tụ trí tuệ của toàn thể thành viên.',
      '"勇于承担责任" và "善于倾听" kết hợp hoàn hảo giữa lòng can đảm và trí tuệ lắng nghe.'
    ),
    (
      v_gp_id,
      '年轻人在工作中要勇于跳出思维定势，善于在看似平凡的岗位上总结规律发现新机遇。',
      'Niánqīngrén zài gōngzuò zhōng yào yǒngyú tiàochū sīwéi dìngshì, shànyú zài kànsì píngfán de gǎngwèi shang zǒngjié guīlǜ fāxiàn xīn jīyù.',
      'Người trẻ trong công việc cần dũng cảm bước ra khỏi lối mòn tư duy, giỏi đúc kết quy luật và phát hiện cơ hội mới ở những vị trí tưởng như bình dị.',
      '"勇于跳出...善于总结..." định hướng tác phong làm việc sáng tạo cho nhân viên trẻ.'
    );

  -- Điểm ngữ pháp #110: Cấu trúc cố định quy nạp toàn văn trang trọng: "总而言之"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc cố định quy nạp toàn văn trang trọng: "总而言之"',
    'Phân tích các luận cứ. 总而言之, Kết luận đúc kết toàn diện',
    'Cấu trúc cố định',
    '"总而言之" (zǒng''éryánzhī) là cấu trúc kết luận cao cấp bậc nhất trong văn nghị luận HSK 5 (kết hợp 总: tổng quát, 言: nói, 之: nó). Đứng ở đầu đoạn văn cuối cùng để thâu tóm toàn bộ các luận điểm đã triển khai thành một thông điệp cốt lõi, sâu sắc và thuyết phục nhất (tóm lại mà nói, nói tóm lại).',
    'HSK 5',
    110,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '总而言之，科技创新不仅是推动经济高质量发展的核心引擎，更是赢得未来国际竞争主动权的关键基石。',
      'Zǒng''éryánzhī, kējì chuàngxīn bùjǐn shì tuīdòng jīngjì gāozhìliàng fāzhǎn de héxīn yǐnqíng, gèng shì yíngdé wèilái guójì jìngzhēng zhǔdòngquán de guānjiàn jīshí.',
      'Tóm lại mà nói, đổi mới sáng tạo công nghệ chẳng những là động cơ cốt lõi thúc đẩy kinh tế phát triển chất lượng cao, mà càng là nền tảng then chốt để giành thế chủ động trong cạnh tranh quốc tế tương lai.',
      '"总而言之" đứng đầu đoạn kết nâng tầm ý nghĩa của đổi mới công nghệ lên tầm vóc vận mệnh dân tộc.'
    ),
    (
      v_gp_id,
      '总而言之，幸福的生活不可能靠坐享其成，唯有脚踏实地奋斗才能铸就无愧于时代的辉煌业绩。',
      'Zǒng''éryánzhī, xìngfú de shēnghuó bù kěnéng kào zuòxiǎngqíchéng, wéiyǒu jiǎotàshídì fèndòu cái néng zhùjiù wúkuì yú shídài de huīhuáng yèjì.',
      'Nói tóm lại, cuộc sống hạnh phúc không thể dựa vào việc ngồi mát ăn bát vàng, duy chỉ có phấn đấu từng bước vững chắc mới có thể đúc nên những thành tích huy hoàng không hổ thẹn với thời đại.',
      '"总而言之" đúc kết toàn văn với thông điệp nhân sinh tích cực lay động lòng người.'
    );

END $$;

COMMIT;
