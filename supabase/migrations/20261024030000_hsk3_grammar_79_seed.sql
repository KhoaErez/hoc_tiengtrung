-- ==============================================================================
-- MIGRATION: 20261024030000_hsk3_grammar_79_seed.sql
-- NẠP 79 ĐIỂM NGỮ PHÁP HSK 3 KÈM 158 CÂU VÍ DỤ CHUẨN GF 0025-2021 (APPENDIX A)
-- Có giải thích chi tiết tiếng Việt, công thức pattern, Pinyin có dấu thanh và phân loại chuẩn
-- ==============================================================================

BEGIN;

DO $$
DECLARE
  v_gp_id uuid;
BEGIN

  -- Điểm ngữ pháp #1: Đại từ phiếm chỉ chỉ người khác "别人" (Người khác / Người ngoài)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ phiếm chỉ chỉ người khác "别人" (Người khác / Người ngoài)',
    '别人 + Vị ngữ / Vị ngữ + 别人',
    'Đại từ',
    '"别人" (biérén) dùng để chỉ những người khác ngoài bản thân mình hoặc ngoài người đang giao tiếp (người khác, người ngoài). Thường làm chủ ngữ, tân ngữ hoặc định ngữ.',
    'HSK 3',
    1,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在公共场所与他人交流时，我们应当懂得倾听并尊重别人的意见。',
      'Zài gōnggòng chǎngsuǒ yǔ tārén jiāoliú shí, wǒmen yīngdāng dǒngde qīngtīng bìng zūnzhòng biérén de yìjiàn.',
      'Khi giao lưu với người khác ở nơi công cộng, chúng ta nên biết lắng nghe và tôn trọng ý kiến của người khác.',
      '"别人的意见" làm định ngữ bổ nghĩa cho danh từ ý kiến.'
    ),
    (
      v_gp_id,
      '遇到困难时不要一味依赖别人，要学会独立思考解决问题。',
      'Yù dào kùnnán shí bú yào yíwèi yīlài biérén, yào xuéhuì dúlì sīkǎo jiějué wèntí.',
      'Khi gặp khó khăn đừng chỉ biết mù quáng ỷ lại vào người khác, cần phải học cách suy nghĩ độc lập để giải quyết vấn đề.',
      '"依赖别人" làm tân ngữ đứng sau động từ phụ thuộc.'
    );

  -- Điểm ngữ pháp #2: Đại từ phân biệt "其他 / 其它" (Khác / Còn lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ phân biệt "其他 / 其它" (Khác / Còn lại)',
    '其他 (+ Lượng từ) + Danh từ (+ 都...)',
    'Đại từ',
    '"其他" (qítā) dùng để chỉ người hoặc sự vật khác ngoài đối tượng đã được đề cập (khác, còn lại). Khi chỉ đồ vật/sự việc có thể dùng "其它". Thường làm định ngữ hoặc đại từ độc lập.',
    'HSK 3',
    2,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '除了这两位请假的同学以外，班里其他学生都准时到校了。',
      'Chúle zhè liǎng wèi qǐngjià de tóngxué yǐwài, bān lǐ qítā xuésheng dōu zhǔnshí dào xiào le.',
      'Ngoại trừ hai bạn học sinh xin nghỉ phép này ra, các học sinh khác trong lớp đều đã đến trường đúng giờ.',
      '"其他学生" chỉ nhóm học sinh còn lại trong lớp.'
    ),
    (
      v_gp_id,
      '这个问题已经解决好了，你看看还有没有其他需要补充的建议？',
      'Zhè gè wèntí yǐjīng jiějué hǎo le, nǐ kànkan hái yǒu méiyǒu qítā xūyào bǔchōng de jiànyì?',
      'Vấn đề này đã được giải quyết xong xuôi rồi, bạn xem xem còn có kiến nghị nào khác cần bổ sung không?',
      '"其他...建议" bổ nghĩa cho danh từ kiến nghị.'
    );

  -- Điểm ngữ pháp #3: Đại từ bất định chỉ sự vật không hạn chế "任何" (Bất kỳ / Bất luận)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ bất định chỉ sự vật không hạn chế "任何" (Bất kỳ / Bất luận)',
    '任何 (+ Lượng từ) + Danh từ + 都 / 也 + Vị ngữ',
    'Đại từ',
    '"任何" (rènhé) là đại từ bất định biểu thị tính toàn thể không giới hạn (bất kỳ, bất luận cái gì/ai). Thường làm định ngữ đứng trước danh từ và vị ngữ bắt buộc phải có phó từ "都" hoặc "也".',
    'HSK 3',
    3,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在神圣的国家法律面前，任何公民都必须严格遵守社会公共秩序。',
      'Zài shénshèng de guójiā fǎlǜ miànqián, rènhé gōngmín dōu bìxū yángé zūnshǒu shèhuì gōnggòng zhìxù.',
      'Trước pháp luật quốc gia thiêng liêng, bất kỳ công dân nào cũng đều phải nghiêm chỉnh tuân thủ trật tự công cộng xã hội.',
      '"任何公民都" nhấn mạnh tính phổ quát không có ngoại lệ.'
    ),
    (
      v_gp_id,
      '只要我们下定决心努力奋斗，任何困难都不能阻挡我们前进的步伐。',
      'Zhǐyào wǒmen xiàdìng juéxīn nǔlì fèndòu, rènhé kùnnán dōu bù néng zǔdǎng wǒmen qiánjìn de bùfá.',
      'Chỉ cần chúng ta hạ quyết tâm nỗ lực phấn đấu, bất kỳ khó khăn nào cũng không thể cản bước tiến của chúng ta.',
      '"任何困难都" biểu thị tất cả mọi khó khăn đều bị khuất phục.'
    );

  -- Điểm ngữ pháp #4: Số ước lượng đặt sau số từ "左右" (Khoảng / Chừng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Số ước lượng đặt sau số từ "左右" (Khoảng / Chừng)',
    'Số từ + Lượng từ + Danh từ + 左右 / Mốc thời gian + 左右',
    'Số từ',
    '"左右" (zuǒyòu) đặt ngay sau số lượng từ hoặc từ chỉ thời gian, tuổi tác để biểu thị con số ước lượng xấp xỉ không hoàn toàn chính xác (khoảng, tầm, chừng).',
    'HSK 3',
    4,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '参加今天下午跨国学术视频研讨会的专家学者有五十人左右。',
      'Cānjiā jīntiān xiàwǔ kuàguó xuéshù shìpín yántǎohuì de zhuānjiā xuézhě yǒu wǔshí rén zuǒyòu.',
      'Các chuyên gia học giả tham gia hội thảo video học thuật xuyên quốc gia chiều nay có khoảng chừng năm mươi người.',
      '"五十人左右" ước lượng số lượng người tham dự xấp xỉ 50.'
    ),
    (
      v_gp_id,
      '我们今天下午四点半左右在校门口的公交车站集合出发。',
      'Wǒmen jīntiān xiàwǔ sì diǎn bàn zuǒyòu zài xiàoménkǒu de gōngjiāochē zhàn jíhé chūfā.',
      'Chúng tôi vào khoảng bốn giờ rưỡi chiều nay sẽ tập trung ở trạm xe buýt cổng trường rồi xuất phát.',
      '"四点半左右" chỉ mốc thời gian ước lượng.'
    );

  -- Điểm ngữ pháp #5: Số ước lượng đặt sau số tròn chục "上下" (Khoảng chừng / Xấp xỉ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Số ước lượng đặt sau số tròn chục "上下" (Khoảng chừng / Xấp xỉ)',
    'Số tuổi / Con số tròn + 上下',
    'Số từ',
    '"上下" (shàngxià) thường đứng sau số từ chỉ tuổi tác hoặc số đo tròn chục để biểu thị số ước tính chênh lệch chút ít lên hoặc xuống (khoảng chừng, trạc tuổi).',
    'HSK 3',
    5,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '那位正在讲台上给留学生授课的教授看起来四十岁上下。',
      'Nà wèi zhèngzài jiǎngtái shang gěi liúxuéshēng shòukè de jiàoshòu kàn qǐlai sìshí suì shàngxià.',
      'Vị giáo sư đang đứng trên bục giảng dạy bài cho lưu học sinh kia nhìn tầm khoảng bốn mươi tuổi.',
      '"四十岁上下" ước lượng độ tuổi xấp xỉ 40.'
    ),
    (
      v_gp_id,
      '参加这次马拉松比赛的长跑健儿体重大多在六十公斤上下。',
      'Cānjiā zhè cì mǎlāsōng bǐsài de chángpǎo jiàn''ér tǐzhòng dàduō zài liùshí gōngjīn shàngxià.',
      'Các vận động viên chạy dài tham gia cuộc đua marathon lần này thể trọng đa số ở khoảng sáu mươi cân (kg).',
      '"六十公斤上下" biểu thị khoảng cân nặng ước tính.'
    );

  -- Điểm ngữ pháp #6: Phó từ ước lượng đứng trước số từ "差不多" (Gần như / Xấp xỉ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ ước lượng đứng trước số từ "差不多" (Gần như / Xấp xỉ)',
    '差不多 + Số lượng từ / Danh từ / Tính từ',
    'Số từ',
    '"差不多" (chàbuduō) làm trạng ngữ đứng trước số lượng từ biểu thị con số gần sát mức đó (gần như, ngót nghét, xấp xỉ). Ngoài ra còn làm vị ngữ biểu thị sự tương đương (na ná nhau).',
    'HSK 3',
    6,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他在这个充满现代化活力的海滨城市生活了差不多十年。',
      'Tā zài zhè gè chōngmǎn xiàndàihuà huólì de hǎibīn chéngshì shēnghuó le chàbuduō shí nián.',
      'Anh ấy đã sinh sống ở thành phố ven biển tràn đầy sức sống hiện đại này ngót nghét gần mười năm.',
      '"差不多十年" ước lượng thời gian xấp xỉ gần đủ 10 năm.'
    ),
    (
      v_gp_id,
      '这两款国产智能手机的外观尺寸与显示效果差不多。',
      'Zhè liǎng kuǎn guóchǎn zhìnéng shǒujī de wàiguān chǐcùn yǔ xiǎnshì xiàoguǒ chàbuduō.',
      'Kích thước bề ngoài và hiệu quả hiển thị của hai mẫu điện thoại thông minh nội địa này xấp xỉ như nhau.',
      '"差不多" làm vị ngữ chỉ sự tương đương.'
    );

  -- Điểm ngữ pháp #7: Số ước lượng với "多" biểu thị số dôi dư (Hơn / Ngoài)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Số ước lượng với "多" biểu thị số dôi dư (Hơn / Ngoài)',
    'Số tròn chục/trăm/nghìn + 多 + Lượng từ / Số lẻ nhỏ hơn 10 + Lượng từ + 多',
    'Số từ',
    'Vị trí của "多" (duō) phụ thuộc vào con số đứng trước: nếu là số tròn chục trở lên (10, 20, 100) thì "多" đứng TRƯỚC lượng từ (như: 十多个人: mười mấy người); nếu là số lẻ dưới 10 thì "多" đứng SAU lượng từ (như: 三个多月: hơn ba tháng).',
    'HSK 3',
    7,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们大学的国际交流学院一共有二十多位外籍留学生。',
      'Wǒmen dàxué de guójì jiāoliú xuéyuàn yígòng yǒu èrshí duō wèi wàijí liúxuéshēng.',
      'Học viện giao lưu quốc tế trường đại học chúng tôi tổng cộng có hơn hai mươi bạn lưu học sinh nước ngoài.',
      '"二十多位" do 20 là số tròn chục nên "多" đứng trước lượng từ "位".'
    ),
    (
      v_gp_id,
      '他为了准备高级翻译资格考试，连续苦读了五个多月。',
      'Tā wèile zhǔnbèi gāojí fānyì zīgé kǎoshì, liánxù kǔdú le wǔ gè duō yuè.',
      'Để chuẩn bị cho kỳ thi chứng chỉ biên phiên dịch cao cấp, anh ấy đã miệt mài dùi mài liên tục hơn năm tháng.',
      '"五个多月" do 5 là số nhỏ hơn 10 nên "多" đứng sau lượng từ "个".'
    );

  -- Điểm ngữ pháp #8: Lượng từ đoạn đường / thời gian "段" (Đoạn / Quãng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Lượng từ đoạn đường / thời gian "段" (Đoạn / Quãng)',
    '一 + 段 + Thời gian (时间) / Khoảng cách (路) / Câu văn (话)',
    'Lượng từ',
    '"段" (duàn) là lượng từ dùng cho một phần của không gian dài (một đoạn đường: 一段路), một khoảng thời gian liên tục (một quãng thời gian: 一段时间), hoặc một phân đoạn văn bản, lời nói (一段话).',
    'HSK 3',
    8,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经过前一段时间的刻苦训练，他的汉语听说水平有了显著提升。',
      'Jīngguò qián yí duàn shíjiān de kèkǔ xùnliàn, tā de hànyǔ tīng-shuō shuǐpíng yǒu le xiǎnzhù tíshēng.',
      'Trải qua một quãng thời gian khổ luyện trước đó, trình độ nghe nói tiếng Hán của anh ấy đã có bước nâng cao rõ rệt.',
      '"一段时间" chỉ khoảng thời gian liên tục đã qua.'
    ),
    (
      v_gp_id,
      '老师在黑板上端正地抄写了一段著名的古文名言。',
      'Lǎoshī zài hēibǎn shang duānzhèng de chāoxiě le yí duàn zhùmíng de gǔwén míngyán.',
      'Thầy giáo nắn nót chép lên bảng đen một đoạn danh ngôn cổ văn nổi tiếng.',
      '"一段...名言" lượng từ cho đoạn văn bản.'
    );

  -- Điểm ngữ pháp #9: Lượng từ chủng loại / kiểu mẫu "种" (Loại / Thứ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Lượng từ chủng loại / kiểu mẫu "种" (Loại / Thứ)',
    'Số từ + 种 + Danh từ (水果 / 语言 / 办法)',
    'Lượng từ',
    '"种" (zhǒng) là lượng từ chỉ chủng loại, phân loại của sự vật hoặc hiện tượng trừu tượng (loại, thứ, phương diện).',
    'HSK 3',
    9,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这位资深翻译专家熟练掌握了英、法、西等三种联合国官方语言。',
      'Zhè wèi zīshēn fānyì zhuānjiā shúliàn zhǎngwò le yīng, fǎ, xī děng sān zhǒng Liánhéguó guānfāng yǔyán.',
      'Chuyên gia dịch thuật kỳ cựu này đã nắm vững thuần thục ba thứ ngôn ngữ chính thức của Liên Hợp Quốc gồm Anh, Pháp, Tây Ban Nha.',
      '"三种...语言" biểu thị ba loại ngôn ngữ.'
    ),
    (
      v_gp_id,
      '面对突如其来的技术故障，工程师提出了两种可行的解决办法。',
      'Miànduì tūrúqílái de jìshù gùzhàng, gōngchéngshī tíchū le liǎng zhǒng kěxíng de jiějué bànfǎ.',
      'Đối mặt với sự cố kỹ thuật đột xuất, kỹ sư đã đề xuất hai loại biện pháp giải quyết khả thi.',
      '"两种...办法" phân loại biện pháp xử lý.'
    );

  -- Điểm ngữ pháp #10: Lượng từ vật có cán / nắm tay "把" (Chiếc / Cây / Con)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Lượng từ vật có cán / nắm tay "把" (Chiếc / Cây / Con)',
    'Số từ + 把 + Ô (伞) / Dao (刀) / Ghế (椅子) / Thìa (勺子)',
    'Lượng từ',
    '"把" (bǎ) là lượng từ dùng cho các dụng cụ, đồ vật có cán cầm, chuôi nắm như chiếc ô (一把伞), con dao (一把刀), chiếc ghế dựa (一把椅子), cái thìa (一把勺子). Ngoài ra còn chỉ nắm tay (một nắm: 一把米).',
    'HSK 3',
    10,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '出门前看到天气阴沉沉的，母亲特意递给我一把结实的雨伞。',
      'Chūmén qián kàn dào tiānqì yīnchénchén de, mǔqīn tèyì dì gěi wǒ yì bǎ jiēshi de yǔsǎn.',
      'Trước khi ra khỏi cửa thấy trời râm u ám, người mẹ đã đặc biệt đưa cho tôi một chiếc ô chắc chắn.',
      '"一把...雨伞" là lượng từ tiêu chuẩn dùng cho ô dù có cán cầm.'
    ),
    (
      v_gp_id,
      '会议室里整齐地摆放着二十把舒适崭新的办公椅子。',
      'Huìyìshì lǐ zhěngqí de bǎifàng zhe èrshí bǎ shūshì zhǎnxīn de bàngōng yǐzi.',
      'Trong phòng họp đang bày biện ngay ngắn hai mươi chiếc ghế văn phòng mới toanh êm ái.',
      '"二十把...椅子" dùng cho ghế ngồi có tay vịn/tựa.'
    );

  -- Điểm ngữ pháp #11: Lượng từ tài liệu / phần ăn "份" (Bản / Phần / Suất)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Lượng từ tài liệu / phần ăn "份" (Bản / Phần / Suất)',
    'Số từ + 份 + Báo chí (报纸) / Hồ sơ (材料) / Bữa ăn (外卖)',
    'Lượng từ',
    '"份" (fèn) là lượng từ dùng cho các văn bản tài liệu được in ấn theo bản/bộ (một tờ báo: 一份报纸, một bản báo cáo: 一份报告), phần ăn suất ăn (một suất cơm: 一份午饭), hoặc công việc tình cảm (một công việc: 一份工作, một tấm lòng: 一份心意).',
    'HSK 3',
    11,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他在求职招聘网站上向知名外资企业投递了一份详尽的个人简历。',
      'Tā zài qiúzhí zhāopìn wǎngzhàn shang xiàng zhīmíng wàizī qǐyè tóudì le yí fèn xiángjìn de gèrén jiǎnlì.',
      'Anh ấy trên trang web tuyển dụng việc làm đã nộp một bản sơ yếu lý lịch cá nhân chi tiết tới doanh nghiệp có vốn đầu tư nước ngoài danh tiếng.',
      '"一份...简历" lượng từ cho bản sơ yếu lý lịch.'
    ),
    (
      v_gp_id,
      '中午下班后，同事们在写字楼下各自订了一份热气腾腾的营养快餐。',
      'Zhōngwǔ xiàbān hòu, tóngshì men zài xiězìlóu xià gèzì dìng le yí fèn rèqì-téngténg de yíngyǎng kuàicān.',
      'Buổi trưa sau khi tan sở, các đồng nghiệp dưới chân tòa nhà văn phòng ai nấy đều đặt một suất cơm nhanh dinh dưỡng nóng hổi.',
      '"一份...快餐" lượng từ cho suất ăn nhanh.'
    );

  -- Điểm ngữ pháp #12: Lượng từ thư từ / điện tín "封" (Bức / Lá)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Lượng từ thư từ / điện tín "封" (Bức / Lá)',
    'Số từ + 封 + Thư (信) / Email (电子邮件)',
    'Lượng từ',
    '"封" (fēng) là lượng từ chuyên dụng dùng cho thư từ, thư điện tử có niêm phong đóng gói (một bức thư: 一封信, một email: 一封电子邮件).',
    'HSK 3',
    12,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '远在大洋彼岸的海外留学生给父母寄来了一封长长的深情家书。',
      'Yuǎn zài dàyáng-bǐ''àn de hǎiwài liúxuéshēng gěi fùmǔ jì lái le yì fēng chángcháng de shēnqíng jiāshū.',
      'Người bạn du học sinh ở bờ bên kia đại dương xa xôi đã gửi về cho cha mẹ một bức thư nhà dài chan chứa thâm tình.',
      '"一封...家书" dùng cho lá thư gia đình.'
    ),
    (
      v_gp_id,
      '人力资源部门今早给每一位通过初试的求职者发送了一封复试通知。',
      'Rénlì zīyuán bùmén jīnzǎo gěi měi yí wèi tōngguò chūshì de qiúzhízhě fāsòng le yì fēng fùshì tōngzhī.',
      'Phòng nhân sự sáng nay đã gửi một bức thông báo thi vòng hai tới mỗi ứng viên vượt qua vòng sơ tuyển.',
      '"一封...通知" dùng cho bức thông báo gửi qua email.'
    );

  -- Điểm ngữ pháp #13: Lượng từ bài viết / bài báo "篇" (Bài / Thiên)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Lượng từ bài viết / bài báo "篇" (Bài / Thiên)',
    'Số từ + 篇 + Bài văn (文章) / Bài báo (报道) / Luận văn (论文)',
    'Lượng từ',
    '"篇" (piān) là lượng từ dùng cho bài văn, bài báo, bài viết hoặc luận văn học thuật có kết cấu hoàn chỉnh (một bài văn: 一篇文章, một bài báo: 一篇报道, một bài luận: 一篇论文).',
    'HSK 3',
    13,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这位青年学者在国际著名权威期刊上发表了一篇高水平的学术论文。',
      'Zhè wèi qīngnián xuézhě zài guójì zhùmíng quánwēi qīkān shang fābiǎo le yì piān gāo shuǐpíng de xuéshù lùnwén.',
      'Học giả trẻ này đã công bố một bài luận văn học thuật trình độ cao trên tạp chí uy tín nổi tiếng quốc tế.',
      '"一篇...论文" lượng từ cho bài luận văn khoa học.'
    ),
    (
      v_gp_id,
      '语文老师要求每个学生在周末认真阅读并背诵一篇古典抒情散文。',
      'Yǔwén lǎoshī yāoqiú měi gè xuésheng zài zhōumò rènzhēn yuèdú bìng bèisòng yì piān gǔdiǎn shūqíng sǎnwén.',
      'Thầy giáo ngữ văn yêu cầu mỗi học sinh vào dịp cuối tuần cần chăm chú đọc và học thuộc một bài tản văn trữ tình cổ điển.',
      '"一篇...散文" lượng từ cho bài tản văn.'
    );

  -- Điểm ngữ pháp #14: Phó từ mức độ tột đỉnh "极 / 极其" (Cực kỳ / Vô cùng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ mức độ tột đỉnh "极 / 极其" (Cực kỳ / Vô cùng)',
    'Tính từ + 极了! / 极其 + Tính từ / Cụm động từ',
    'Phó từ',
    'Khi làm bổ ngữ mức độ, "极" đứng sau tính từ theo cấu trúc "...极了" (vui mừng khôn xiết: 高兴极了). Khi làm phó từ đứng trước tính từ hoặc động từ tâm lý, thường dùng song âm tiết "极其" (cực kỳ quan trọng: 极其重要).',
    'HSK 3',
    14,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '得知国家队在决赛中逆转夺得冠军的消息，全体球迷高兴极了！',
      'Dézhī guójiāduì zài juésài zhōng nìzhuǎn duó dé guànjūn de xiāoxi, quántǐ qiúmǐ gāoxìng jí le!',
      'Hay tin đội tuyển quốc gia lội ngược dòng đoạt chức vô địch trong trận chung kết, toàn thể người hâm mộ bóng đá vui mừng khôn xiết!',
      '"高兴极了" biểu thị niềm vui đạt đến đỉnh điểm tuyệt đối.'
    ),
    (
      v_gp_id,
      '保护生物多样性对维系全球生态平衡具有极其重要的深远意义。',
      'Bǎohù shēngwù duōyàngxìng duì wéixì quánqiú shēngtài pínghéng jùyǒu jíqí zhòngyào de shēnyuǎn yìyì.',
      'Bảo vệ sự đa dạng sinh học có ý nghĩa sâu xa cực kỳ quan trọng đối với việc duy trì cân bằng sinh thái toàn cầu.',
      '"极其重要" trạng ngữ chỉ mức độ quan trọng tột bậc.'
    );

  -- Điểm ngữ pháp #15: Phó từ mức độ nhẹ "稍微 / 稍" (Hơi / Một chút)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ mức độ nhẹ "稍微 / 稍" (Hơi / Một chút)',
    '稍微 (+ 一点儿) + Tính từ / 稍微 + Động từ + 一下',
    'Phó từ',
    '"稍微" (shāowēi) biểu thị số lượng ít hoặc mức độ nhẹ (hơi, một chút, một lát). Phía sau thường kết hợp với "一点儿", "一些" hoặc động từ mang "一下". Khác với "有点儿" (thường mang sắc thái tiêu cực), "稍微" mang tính khách quan trung tính.',
    'HSK 3',
    15,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这件羊毛大衣的袖子稍微有一点儿长，请裁缝师傅帮忙改短一些。',
      'Zhè jiàn yángmáo dàyī de xiùzi shāowēi yǒu yìdiǎnr cháng, qǐng cáifeng shīfu bāngmáng gǎi duǎn yìxiē.',
      'Ống tay của chiếc áo khoác dạ len này hơi dài một chút, xin nhờ bác thợ may sửa ngắn bớt một tẹo.',
      '"稍微有一点儿长" miêu tả độ dài hơi chênh lệch một chút.'
    ),
    (
      v_gp_id,
      '请各位来宾在候车大厅稍微休息一下，列车马上进站检票。',
      'Qǐng gèwèi láibīn zài hòuchē dàtīng shāowēi xiūxi yíxià, lièchē mǎshàng jìn zhàn jiǎnpiào.',
      'Mời quý khách nghỉ ngơi một chút ở sảnh chờ, đoàn tàu sẽ vào ga soát vé ngay thôi.',
      '"稍微休息一下" đề nghị nghỉ ngơi chốc lát.'
    );

  -- Điểm ngữ pháp #16: Phó từ giới hạn tiệm cận "几乎" (Hầu như / Suýt nữa)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ giới hạn tiệm cận "几乎" (Hầu như / Suýt nữa)',
    '几乎 + 都 / 没 / Tính từ / Động từ',
    'Phó từ',
    '"几乎" (jīhū) biểu thị trạng thái vô cùng tiếp cận với toàn bộ hoặc suýt soát xảy ra nhưng thực tế chưa xảy ra (hầu như, gần như, suýt nữa).',
    'HSK 3',
    16,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经过一个学期的刻苦攻读，全班同学几乎都顺利通过了汉语水平考试。',
      'Jīngguò yí gè xuéqī de kèkǔ gōngdú, quán bān tóngxué jīhū dōu shùnlì tōngguò le hànyǔ shuǐpíng kǎoshì.',
      'Trải qua một học kỳ miệt mài dùi mài, học sinh cả lớp hầu như đều đã thuận lợi thi đỗ kỳ thi năng lực Hán ngữ.',
      '"几乎都" nhấn mạnh tỷ lệ đỗ đạt tiếp cận 100%.'
    ),
    (
      v_gp_id,
      '路面结冰太滑，他刚才在台阶上走得太急，几乎滑倒在地上。',
      'Lùmiàn jiébīng tài huá, tā gāngcái zài táijiē shang zǒu de tài jí, jīhū huádǎo zài dì shang.',
      'Mặt đường đóng băng trơn quá, ban nãy anh ấy bước quá vội trên bậc thang suýt nữa trượt ngã xuống đất.',
      '"几乎滑倒" biểu thị suýt ngã nhưng chưa ngã.'
    );

  -- Điểm ngữ pháp #17: Phó từ biến đổi tuần tự "逐渐 / 渐渐" (Dần dần / Từng bước)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ biến đổi tuần tự "逐渐 / 渐渐" (Dần dần / Từng bước)',
    '逐渐 / 渐渐 + Động từ / Tính từ (+ 起来 / 了)',
    'Phó từ',
    '"逐渐" (zhújiàn) biểu thị mức độ hoặc số lượng phát triển theo từng bước, diễn tiến từ từ theo thời gian (dần dần, từng bước một). Thường dùng trong văn viết, văn cảnh trang trọng.',
    'HSK 3',
    17,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '随着春天悄然来临，冰封的大地和山川河谷开始逐渐融化生机盎然。',
      'Suízhe chūntiān qiǎorán láilín, bīngfēng de dàdì hé shānchuān hégǔ kāishǐ zhújiàn rónghuà shēngjī-àngrán.',
      'Cùng với mùa xuân lặng lẽ đến, đất trời và sông núi thung lũng đóng băng bắt đầu dần dần tan chảy tràn trề sức sống.',
      '"逐渐融化" miêu tả quá trình tan băng diễn ra tuần tự từng ngày.'
    ),
    (
      v_gp_id,
      '经过几个月的临床药物治疗，患者的各项身体生理指标逐渐恢复正常。',
      'Jīngguò jǐ gè yuè de línchuáng yàowù zhìliáo, huànzhě de gè xiàng shēntǐ shēnglǐ zhǐbiāo zhújiàn huīfù zhèngcháng.',
      'Trải qua vài tháng điều trị thuốc lâm sàng, các chỉ số sinh lý cơ thể của bệnh nhân dần dần khôi phục bình thường.',
      '"逐渐恢复" chỉ sự phục hồi sức khỏe từng bước một.'
    );

  -- Điểm ngữ pháp #18: Phó từ tương hỗ đa phương "互相" (Lẫn nhau / Tương hỗ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tương hỗ đa phương "互相" (Lẫn nhau / Tương hỗ)',
    '互相 + Động từ song âm tiết (帮助 / 学习 / 尊重 / 理解)',
    'Phó từ',
    '"互相" (hùxiāng) biểu thị hai bên hoặc nhiều bên cùng tác động qua lại lẫn nhau với cùng một hành động (lẫn nhau, cùng nhau). Động từ theo sau thường là động từ song âm tiết.',
    'HSK 3',
    18,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '不同文化背景的留学生生活在一起，应当互相尊重、互相包容。',
      'Bùtóng wénhuà bèijǐng de liúxuéshēng shēnghuó zài yìqǐ, yīngdāng hùxiāng zūnzhòng, hùxiāng bāoróng.',
      'Các lưu học sinh có bối cảnh văn hóa khác nhau khi sống cùng nhau nên tôn trọng lẫn nhau, bao dung lẫn nhau.',
      '"互相尊重" thể hiện hành vi tôn trọng hai chiều qua lại.'
    ),
    (
      v_gp_id,
      '同学们在日常学习中经常互相帮助，共同解决学习中的疑难问题。',
      'Tóngxué men zài rìcháng xuéxí zhōng jīngcháng hùxiāng bāngzhù, gòngtóng jiějué xuéxí zhōng de yínán wèntí.',
      'Các bạn học sinh trong học tập hằng ngày thường xuyên giúp đỡ lẫn nhau, cùng nhau giải quyết các bài toán khó khăn.',
      '"互相帮助" chỉ sự tương trợ qua lại giữa bạn bè.'
    );

  -- Điểm ngữ pháp #19: Phó từ truy cứu đến cùng "到底 / 究竟" (Rốt cuộc / Cuối cùng)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ truy cứu đến cùng "到底 / 究竟" (Rốt cuộc / Cuối cùng)',
    '到底 / 究竟 + Từ để hỏi / Vị ngữ nghi vấn?',
    'Phó từ',
    '"到底" (dàodǐ) hoặc "究竟" (jiūjìng) đứng trước đại từ nghi vấn hoặc vị ngữ trong câu hỏi để thể hiện ngữ khí truy hỏi ráo riết đến cùng (rốt cuộc, rốt cuộc là thế nào). Ngoài ra "到底" còn chỉ kết quả cuối cùng trong câu trần thuật.',
    'HSK 3',
    19,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '明天早晨的学术专题报告会到底是在几点钟正式开始？',
      'Míngtiān zǎochén de xuéshù zhuāntí bàogàohuì dàodǐ shì zài jǐ diǎn zhōng zhèngshì kāishǐ?',
      'Buổi báo cáo chuyên đề học thuật sáng mai rốt cuộc là mấy giờ chính thức bắt đầu?',
      '"到底是在几点" tăng cường ngữ khí truy hỏi thời gian chính xác.'
    ),
    (
      v_gp_id,
      '经过长达五年的艰苦联合技术攻坚，这个国家级重大科研项目到底成功了！',
      'Jīngguò chángdá wǔ nián de jiānkǔ liánhé jìshù gōngjiān, zhè gè guójiājí zhòngdà kēyán xiàngmù dàodǐ chénggōng le!',
      'Trải qua suốt năm năm phối hợp công phá kỹ thuật gian khổ, dự án nghiên cứu khoa học trọng đại cấp quốc gia này cuối cùng cũng đã thành công!',
      '"到底成功了" chỉ kết quả đạt được sau nỗ lực dài lâu trong câu trần thuật.'
    );

  -- Điểm ngữ pháp #20: Phó từ thời gian vừa mới xảy ra "刚 / 刚才" (Vừa / Vừa mới)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thời gian vừa mới xảy ra "刚 / 刚才" (Vừa / Vừa mới)',
    '刚 + Động từ (Phó từ) / 刚才 + Vị ngữ (Danh từ chỉ thời gian)',
    'Phó từ',
    'Phân biệt "刚" và "刚才": "刚" là phó từ chỉ hành động vừa mới xảy ra cách đây chốc lát, đứng ngay trước động từ (như: 我刚来); còn "刚才" là danh từ thời gian chỉ thời điểm vài phút trước, có thể đứng trước hoặc sau chủ ngữ (như: 刚才我去开会 / 我刚才去开会).',
    'HSK 3',
    20,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '列车刚进站停稳，旅客们就井然有序地排队准备检票出站。',
      'Lièchē gāng jìn zhàn tíng wěn, lǚkè men jiù jǐngrán-yǒuxù de páiduì zhǔnbèi jiǎnpiào chū zhàn.',
      'Đoàn tàu vừa mới vào ga đỗ ngay ngắn, các hành khách liền trật tự xếp hàng chuẩn bị soát vé ra ga.',
      '"刚进站" phó từ "刚" đứng trước động từ chỉ sự việc vừa mới xong.'
    ),
    (
      v_gp_id,
      '刚才在走廊里和你热情打招呼的那位老教授是谁？',
      'Gāngcái zài zǒuláng lǐ hé nǐ rèqíng dǎ zhāohu de nà wèi lǎo jiàoshòu shì shéi?',
      'Vị giáo sư già vừa nãy ở hành lang nhiệt tình chào hỏi bạn là ai thế?',
      '"刚才" danh từ thời gian chỉ thời điểm ban nãy.'
    );

  -- Điểm ngữ pháp #21: Phó từ thời gian đột ngột "突然" (Đột nhiên / Bất ngờ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ thời gian đột ngột "突然" (Đột nhiên / Bất ngờ)',
    '突然 + Động từ / Cụm chủ vị (Trạng ngữ) / Rất + 突然 (Vị ngữ)',
    'Phó từ',
    '"突然" (tūrán) biểu thị sự việc phát sinh bất ngờ, mau lẹ ngoài dự liệu (đột nhiên, bất thình lình). Vừa có thể làm trạng ngữ đứng trước động từ, vừa có thể làm hình dung từ làm vị ngữ.',
    'HSK 3',
    21,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我们正走在回家的路上，天空中突然电闪雷鸣下起了倾盆暴雨。',
      'Wǒmen zhèng zǒu zài huíjiā de lù shang, tiānkōng zhōng tūrán diànshǎn-léimíng xià qǐ le qīngpén bàoyǔ.',
      'Chúng tôi đang đi trên đường về nhà, trên bầu trời đột nhiên chớp giật sấm rền đổ xuống cơn mưa rào như trút nước.',
      '"突然...下起" làm trạng ngữ miêu tả sự xuất hiện bất ngờ của cơn mưa.'
    ),
    (
      v_gp_id,
      '这个突发交通事故发生得太突然了，在场的所有人都惊呆了。',
      'Zhè gè tūfā jiāotōng shìgù fāshēng de tài tūrán le, zàichǎng de suǒyǒu rén dōu jīngdāi le.',
      'Vụ tai nạn giao thông đột xuất này xảy ra quá đỗi bất ngờ, toàn thể người có mặt đều sững sờ.',
      '"太突然了" làm bổ ngữ/vị ngữ tính từ chỉ mức độ bất ngờ.'
    );

  -- Điểm ngữ pháp #22: Phó từ kiên quyết nhất định "一定" (Nhất định / Chắc chắn)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ kiên quyết nhất định "一定" (Nhất định / Chắc chắn)',
    '一定 + Động từ / Tính từ / (不)一定',
    'Phó từ',
    '"一定" (yídìng) biểu thị ý chí kiên quyết, sự phán đoán chắc chắn không nghi ngờ (nhất định, chắc chắn). Phủ định là "不一定" (chưa chắc, không hẳn).',
    'HSK 3',
    22,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '只要我们坚持脚踏实地努力拼搏，就一定能够实现心中的梦想。',
      'Zhǐyào wǒmen jiānchí jiǎotà-shídì nǔlì pīnbó, jiù yídìng nénggòu shíxiàn xīnzhōng de mèngxiǎng.',
      'Chỉ cần chúng ta kiên trì vững vàng nỗ lực phấn đấu thì nhất định có thể thực hiện được giấc mơ trong lòng.',
      '"一定能够" khẳng định chắc chắn về khả năng thành công.'
    ),
    (
      v_gp_id,
      '外表光鲜亮丽的商品，其质量和做工并不一定都非常优良。',
      'Wàibiǎo guāngxiān-liànglì de shāngpǐn, qí zhìliàng hé zuògōng bìng bù yídìng dōu fēicháng yōuliáng.',
      'Mặt hàng bề ngoài bóng bẩy lộng lẫy thì chất lượng và gia công chưa hẳn đều rất ưu lương.',
      '"不一定" phủ định sự tất yếu tuyệt đối.'
    );

  -- Điểm ngữ pháp #23: Phó từ tiếp tục tiến thêm một bước "越发 / 更加" (Càng / Càng thêm)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tiếp tục tiến thêm một bước "越发 / 更加" (Càng / Càng thêm)',
    '更加 / 越发 + Tính từ / Cụm động từ tâm lý',
    'Phó từ',
    '"更加" (gèngjiā) hoặc "越发" (yuèfā) đứng trước tính từ hoặc động từ tâm lý biểu thị mức độ phát triển cao hơn một bậc trên nền tảng sẵn có (càng thêm, càng... hơn nữa).',
    'HSK 3',
    23,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '秋雨过后，漫山遍野枫树林的红叶显得更加鲜艳夺目。',
      'Qiūyǔ guòhòu, mànshān-biànyě fēngshùlín de hóngyè xiǎnde gèngjiā xiānyàn duómù.',
      'Sau cơn mưa thu, lá đỏ rừng phong khắp núi rừng lại càng thêm tươi thắm rực rỡ bắt mắt.',
      '"更加鲜艳" biểu thị mức độ tươi thắm tăng thêm một bậc sau mưa.'
    ),
    (
      v_gp_id,
      '听到恩师充满期许的真诚鼓励，他心中越发坚定了求学的信念。',
      'Tīng dào ēnshī chōngmǎn qīxǔ de zhēnchéng gǔlì, tā xīnzhōng yuèfā jiāndìng le qiúxué de xìnniàn.',
      'Nghe lời khích lệ chân thành tràn đầy kỳ vọng của thầy ơn, trong lòng anh càng thêm kiên định niềm tin theo đuổi học vấn.',
      '"越发坚定" nhấn mạnh niềm tin trở nên vững chắc hơn.'
    );

  -- Điểm ngữ pháp #24: Phó từ phạm vi hạn định "一共 / 总共" (Tổng cộng / Tất cả)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ phạm vi hạn định "一共 / 总共" (Tổng cộng / Tất cả)',
    '一共 / 总共 + Số lượng từ / Vị ngữ',
    'Phó từ',
    '"一共" (yígòng) hoặc "总共" (zǒnggòng) đứng trước cụm số từ hoặc vị ngữ để biểu thị tổng số lượng gộp lại của các khoản mục, số người hoặc chi phí (tổng cộng, tất cả gồm có).',
    'HSK 3',
    24,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '参加今天全校春季长跑越野赛的师生运动员一共有五百余人。',
      'Cānjiā jīntiān quán xiào chūnjì chángpǎo yuèyěsài de shīshēng yùndòngyuán yígòng yǒu wǔbǎi yú rén.',
      'Các thầy trò vận động viên tham gia giải chạy việt dã mùa xuân toàn trường hôm nay tổng cộng có hơn năm trăm người.',
      '"一共有" tổng kết toàn bộ số lượng vận động viên tham gia.'
    ),
    (
      v_gp_id,
      '买这些专业汉语教材和学习用品，总共花费了三百五十块钱。',
      'Mǎi zhèxiē zhuānyè hànyǔ jiàocái hé xuéxí yòngpǐn, zǒnggòng huāfèi le sānbǎi wǔshí kuài qián.',
      'Mua những cuốn giáo trình Hán ngữ chuyên ngành và đồ dùng học tập này, tổng cộng tiêu tốn hết ba trăm năm mươi tệ.',
      '"总共花费" gộp toàn bộ chi phí mua sắm.'
    );

  -- Điểm ngữ pháp #25: Phó từ giới hạn duy nhất "只 / 仅仅" (Chỉ / Chỉ có)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ giới hạn duy nhất "只 / 仅仅" (Chỉ / Chỉ có)',
    '只 / 仅仅 + Động từ / Số lượng từ',
    'Phó từ',
    '"只" (zhǐ) là phó từ phạm vi đứng trước động từ để biểu thị sự hạn định duy nhất vào một đối tượng, hành vi hoặc phạm vi nhỏ (chỉ, chỉ có). Văn viết trang trọng dùng "仅仅".',
    'HSK 3',
    25,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '整间宽敞的自习室里非常安静，只听见翻阅书页的沙沙声。',
      'Zhěng jiān kuānchǎng de zìxíshì lǐ fēicháng ānjìng, zhǐ tīngjiàn fānyuè shūyè de shāshā shēng.',
      'Bên trong cả phòng tự học rộng rãi vô cùng yên tĩnh, chỉ nghe thấy tiếng lật trang sách xào xạc.',
      '"只听见" hạn định duy nhất âm thanh lật sách.'
    ),
    (
      v_gp_id,
      '他今天早晨因为匆忙出门，只吃了一片烤面包就去上班了。',
      'Tā jīntiān zǎochén yīnwèi cōngmáng chūmén, zhǐ chī le yí piàn kǎo miànbāo jiù qù shàngbān le.',
      'Sáng nay vì vội vàng ra khỏi cửa, anh ấy chỉ ăn một lát bánh mì nướng là đi làm rồi.',
      '"只吃了一片" giới hạn lượng thức ăn ít ỏi.'
    );

  -- Điểm ngữ pháp #26: Phó từ xác nhận hiển nhiên "当然" (Đương nhiên / Dĩ nhiên)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ xác nhận hiển nhiên "当然" (Đương nhiên / Dĩ nhiên)',
    '当然 + Động từ / Tính từ / 当然可以!',
    'Phó từ',
    '"当然" (dāngrán) biểu thị sự việc là hợp lý, hiển nhiên không cần nghi ngờ hoặc dùng trong lời đáp để biểu thị sự đồng ý nhiệt tình, quả quyết (đương nhiên, dĩ nhiên).',
    'HSK 3',
    26,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '只要你平时付出足够的辛勤汗水，期末考试当然能取得好成绩。',
      'Zhǐyào nǐ píngrì fùchū zúgòu de xīnqín hànshuǐ, qīmò kǎoshì dāngrán néng qǔdé hǎo chéngjì.',
      'Chỉ cần ngày thường bạn bỏ ra đầy đủ mồ hôi công sức, kỳ thi cuối kỳ đương nhiên có thể đạt thành tích tốt.',
      '"当然能" khẳng định kết quả hiển nhiên theo quy luật nhân quả.'
    ),
    (
      v_gp_id,
      '“我可以在这里借阅这本汉语字典吗？”——“当然可以，请便！”',
      '“Wǒ kěyǐ zài zhèlǐ jièyuè zhè běn hànyǔ zìdiǎn ma?” —— “Dāngrán kěyǐ, qǐng biàn!”',
      '“Tôi có thể mượn đọc cuốn từ điển tiếng Hán này ở đây được không?” —— “Đương nhiên được chứ, xin cứ tự nhiên!”',
      '"当然可以" lời đáp biểu thị sự đồng ý dứt khoát vui vẻ.'
    );

  -- Điểm ngữ pháp #27: Phó từ ngữ khí phản vấn gay gắt "难道" (Chẳng lẽ / Lẽ nào)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ ngữ khí phản vấn gay gắt "难道" (Chẳng lẽ / Lẽ nào)',
    '难道 + Phân câu hỏi (+ 吗 / 不成)?',
    'Phó từ',
    '"难道" (nándào) đặt trước câu hỏi phản vấn để tăng cường ngữ khí ngạc nhiên, trách móc hoặc khẳng định dứt khoát một sự việc hiển nhiên (chẳng lẽ, lẽ nào... lại như thế). Thường kết hợp với "吗" ở cuối câu.',
    'HSK 3',
    27,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '明天的开学典礼这么重要，难道你真打算无故请假不去吗？',
      'Míngtiān de kāixué diǎnlǐ zhème zhòngyào, nándào nǐ zhēn dǎsuàn wúgù qǐngjià bú qù ma?',
      'Lễ khai giảng ngày mai quan trọng như thế, chẳng lẽ bạn thực sự dự tính xin nghỉ không lý do để không đi sao?',
      '"难道...吗" tăng cường ngữ khí chất vấn sự vô lý của việc xin nghỉ.'
    ),
    (
      v_gp_id,
      '这道题目老师上周刚讲过两次，难道你们大家都忘得一干二净了吗？',
      'Zhè dào tímù lǎoshī shàng zhōu gāng jiǎng guo liǎng cì, nándào nǐmen dàjiā dōu wàng de yìgān-èrjìng le ma?',
      'Bài toán này tuần trước thầy vừa giảng hai lần rồi, lẽ nào các em đều quên sạch sành sanh hết rồi sao?',
      '"难道...忘了吗" thể hiện sự kinh ngạc trước việc học sinh quên bài.'
    );

  -- Điểm ngữ pháp #28: Phó từ tình thái thuận tiện "顺便" (Nhân tiện / Tiện thể)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ tình thái thuận tiện "顺便" (Nhân tiện / Tiện thể)',
    '顺便 + Động từ (+ Tân ngữ)',
    'Phó từ',
    '"顺便" (shùnbiàn) làm trạng ngữ đứng trước động từ để biểu thị hành động được thực hiện nhân tiện, tiện thể trong lúc đang làm một việc chính khác mà không tốn thêm nhiều công sức (tiện thể, nhân tiện).',
    'HSK 3',
    28,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '你下楼去超市买水果的时候，顺便帮我取一下放在门卫室的快递包裹吧。',
      'Nǐ xià lóu qù chāoshì mǎi shuǐguǒ de shíhou, shùnbiàn bāng wǒ qǔ yíxià fàng zài ménwèishì de kuàidì bāoguǒ ba.',
      'Lúc bạn xuống tầng đi siêu thị mua hoa quả, tiện thể giúp tôi lấy gói bưu phẩm chuyển phát nhanh để ở phòng bảo vệ nhé.',
      '"顺便帮我取" thực hiện việc lấy bưu phẩm nhân tiện chuyến đi siêu thị.'
    ),
    (
      v_gp_id,
      '今天下午去图书馆查阅文献资料，顺便借了两本古典文学名著回来。',
      'Jīntiān xiàwǔ qù túshūguǎn cháyuè wénxiàn zīliào, shùnbiàn jiè le liǎng běn gǔdiǎn wénxué míngzhù huílai.',
      'Chiều nay đến thư viện tra cứu tài liệu văn kiện, tiện thể tôi đã mượn hai cuốn danh tác văn học cổ điển về.',
      '"顺便借" mượn sách tiện thể trong lúc đi tra cứu.'
    );

  -- Điểm ngữ pháp #29: Phó từ may mắn thoát nạn "幸亏 / 幸好" (May mà / May thay)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ may mắn thoát nạn "幸亏 / 幸好" (May mà / May thay)',
    '幸亏 / 幸好 + Tình huống may mắn, 不然 / 要不然 + Hậu quả xấu',
    'Phó từ',
    '"幸亏" (xìngkuī) hoặc "幸好" (xìnghǎo) đứng đầu câu hoặc đầu phân câu để biểu thị nhờ có điều kiện thuận lợi ngẫu nhiên mà tránh được tai họa, rắc rối hoặc hậu quả tồi tệ (may mà, may thay). Thường phối hợp với "不然 / 要不然" (nếu không thì).',
    'HSK 3',
    29,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '幸亏出门前母亲提醒我随身带了雨伞，不然刚才就被倾盆暴雨淋湿了。',
      'Xìngkuī chūmén qián mǔqīn tíxǐng wǒ suíshēn dài le yǔsǎn, bùrán gāngcái jiù bèi qīngpén bàoyǔ línshī le.',
      'May mà trước khi ra khỏi cửa mẹ nhắc tôi mang theo ô bên mình, nếu không thì ban nãy đã bị cơn mưa rào như trút làm ướt sũng rồi.',
      '"幸亏...不然..." nhấn mạnh sự may mắn nhờ mang ô tránh bị ướt mưa.'
    ),
    (
      v_gp_id,
      '幸好交警及时赶到事故现场疏导车流，拥堵的交通才没有彻底瘫痪。',
      'Xìnghǎo jiāojǐng jíshí gǎndào shìgù xiànchǎng shūdǎo chēliú, yōngdǔ de jiāotōng cái méiyǒu chèdǐ tānhuān.',
      'May thay cảnh sát giao thông kịp thời tới hiện trường vụ tai nạn phân luồng xe, giao thông ùn tắc mới không bị tê liệt hoàn toàn.',
      '"幸好...才没有" nhờ cảnh sát tới kịp mà tránh được tê liệt giao thông.'
    );

  -- Điểm ngữ pháp #30: Phó từ ngộ ra chân tướng sự thật "原来" (Hóa ra / Thì ra)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ ngộ ra chân tướng sự thật "原来" (Hóa ra / Thì ra)',
    '原来 + Sự thật mới phát hiện / (Vốn dĩ ban đầu)',
    'Phó từ',
    '"原来" (yuánlái) đứng đầu câu hoặc trước vị ngữ biểu thị sự ngộ ra, vỡ lẽ về một chân tướng sự thật sau khi tìm hiểu (hóa ra, thì ra là thế). Ngoài ra, "原来" còn làm danh từ/tính từ chỉ tình trạng vốn có ban đầu.',
    'HSK 3',
    30,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '我说今天早晨外面怎么这么安静，原来昨夜下了一场厚厚的瑞雪。',
      'Wǒ shuō jīntiān zǎochén wàimiàn zěnme zhème ānjìng, yuánlái zuóyè xià le yì chǎng hòuhòu de ruìxuě.',
      'Tôi cứ bảo sao sáng nay bên ngoài lại yên tĩnh thế này, hóa ra đêm qua trời đã đổ một trận tuyết lành dày xốp.',
      '"原来昨夜下了一场..." giải thích rõ nguyên nhân bất ngờ vỡ lẽ.'
    ),
    (
      v_gp_id,
      '他原来是一名优秀的中学语文教师，后来通过努力考上了研究生。',
      'Tā yuánlái shì yì míng yōuxiù de zhōngxué yǔwén jiàoshī, hòulái tōngguò nǔlì kǎo shàng le yánjiūshēng.',
      'Anh ấy ban đầu vốn là một giáo viên ngữ văn cấp hai ưu tú, sau này nhờ nỗ lực đã thi đỗ nghiên cứu sinh.',
      '"原来是" chỉ thân phận ban đầu trước đây.'
    );

  -- Điểm ngữ pháp #31: Phó từ cường điệu mức độ như thật "简直" (Quả là / Thật là)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ cường điệu mức độ như thật "简直" (Quả là / Thật là)',
    '简直 (+ 像 / 是 / 比) + Tính từ / Cụm vị ngữ',
    'Phó từ',
    '"简直" (jiǎnzhí) dùng để cường điệu hóa mức độ của sự việc, biểu thị tình huống đạt tới trạng thái gần như không thể tin nổi hoặc hoàn toàn tương đương với một sự việc khác (quả là, thật là, hoàn toàn như).',
    'HSK 3',
    31,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他在全国青少年魔术大赛上的精彩绝伦表演，简直令人难以置信！',
      'Tā zài quánguó qīng-shàonián móshù dàsài shang de jīngcǎi-juélún biǎoyǎn, jiǎnzhí lìngrén nányǐ-zhìxìn!',
      'Màn biểu diễn tuyệt luân đặc sắc của anh ấy trong cuộc thi ảo thuật thanh thiếu niên toàn quốc quả là khiến người ta khó lòng tin nổi!',
      '"简直令人难以置信" cường điệu hóa sự thán phục tột bực.'
    ),
    (
      v_gp_id,
      '清晨漫步在桂林秀丽的漓江两岸，周围美丽的风景简直像一幅生动的山水画。',
      'Qīngchén mànbù zài Guìlín xiùlì de Líjiāng liǎng''àn, zhōuwéi měilì de fēngjǐng jiǎnzhí xiàng yì fú shēngdòng de shānshuǐhuà.',
      'Sáng sớm tản bộ trên hai bờ sông Ly tươi đẹp ở Quế Lâm, phong cảnh mỹ lệ xung quanh quả thật như một bức tranh sơn thủy sống động.',
      '"简直像" so sánh cường điệu vẻ đẹp tự nhiên giống như tranh vẽ.'
    );

  -- Điểm ngữ pháp #32: Phó từ duy trì liên tục không ngắt quãng "一直" (Suốt / Luôn / Liên tục)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Phó từ duy trì liên tục không ngắt quãng "一直" (Suốt / Luôn / Liên tục)',
    '一直 + Động từ / Tính từ / Thời gian + 一直 (+ 都)...',
    'Phó từ',
    '"一直" (yìzhí) biểu thị một hành động hoặc trạng thái duy trì liên tục không gián đoạn từ quá khứ đến hiện tại hoặc trong suốt một khoảng thời gian (suốt, luôn luôn, liên tục). Cũng dùng chỉ phương hướng đi thẳng một mạch (一直走).',
    'HSK 3',
    32,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '从大学一年级开始，他就一直坚持每天清晨早起朗读中外名篇散文。',
      'Cóng dàxué yī niánjí kāishǐ, tā jiù yìzhí jiānchí měitiān qīngchén zǎoqǐ lǎngdú zhōng-wài míngpiān sǎnwén.',
      'Bắt đầu từ năm thứ nhất đại học, anh ấy đã luôn kiên trì mỗi sáng sớm dậy sớm đọc vang các áng văn tản văn danh tiếng trong và ngoài nước.',
      '"一直坚持" biểu thị thói quen duy trì liên tục không bỏ ngày nào.'
    ),
    (
      v_gp_id,
      '从这个十字路口一直往东走两百米，就能看到高耸的世纪电视塔。',
      'Cóng zhè gè shízì-lùkǒu yìzhí wǎng dōng zǒu liǎng bǎi mǐ, jiù néng kàn dào gāosǒng de shìjì diànshìtǎ.',
      'Từ ngã tư này đi thẳng một mạch về phía Đông hai trăm mét là có thể nhìn thấy tháp truyền hình thế kỷ cao vút.',
      '"一直往东走" chỉ hướng đi thẳng một mạch không rẽ.'
    );

  -- Điểm ngữ pháp #33: Liên từ tăng tiến đồng đẳng "不仅...而且..." (Không những... mà còn...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ tăng tiến đồng đẳng "不仅...而且..." (Không những... mà còn...)',
    'Chủ ngữ + 不仅 + Vị ngữ 1, 而且 + Vị ngữ 2 / 不仅 + Chủ ngữ 1..., 而且 + Chủ ngữ 2...',
    'Liên từ',
    'Cặp liên từ "不仅...而且..." (bùjǐn... érqiě...) biểu thị mối quan hệ tăng tiến thêm một bậc về phạm vi hoặc mức độ (không những... mà còn...). Nếu cùng chung chủ ngữ thì chủ ngữ đứng trước 不仅; nếu khác chủ ngữ thì 不仅 đứng trước chủ ngữ 1.',
    'HSK 3',
    33,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这家社区老字号餐馆不仅饭菜可口美味，而且价格十分公道实惠。',
      'Zhè jiā shèqū lǎozìhào cānguǎn bùjǐn fàncài kěkǒu měiwèi, érqiě jiàgé shífēn gōngdao shíhuì.',
      'Quán ăn lâu năm trong khu dân cư này không những cơm canh thơm ngon vừa miệng, mà giá cả còn rất hợp lý bình dân.',
      '"不仅...而且..." liên kết hai ưu điểm tăng tiến cùng chủ ngữ quán ăn.'
    ),
    (
      v_gp_id,
      '学习汉语不仅能开阔我们的文化视野，而且能为未来的职业发展提供广阔舞台。',
      'Xuéxí hànyǔ bùjǐn néng kāikuò wǒmen de wénhuà shìyě, érqiě néng wèi wèilái de zhíyè fāzhǎn tígōng guǎngkuò wǔtái.',
      'Học tiếng Hán không những có thể mở rộng tầm nhìn văn hóa của chúng ta, mà còn có thể mang lại vũ đài rộng lớn cho sự phát triển nghề nghiệp tương lai.',
      'Tăng tiến hai tầng lợi ích thiết thực của việc học Hán ngữ.'
    );

  -- Điểm ngữ pháp #34: Liên từ tăng tiến khẩu ngữ "不但...还 / 也..." (Không chỉ... mà còn...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ tăng tiến khẩu ngữ "不但...还 / 也..." (Không chỉ... mà còn...)',
    '不但 + Phân câu 1, 还 / 也 / 并且 + Phân câu 2',
    'Liên từ',
    '"不但...还 / 也..." (búdàn... hái/yě...) là biến thể khẩu ngữ quen thuộc của "不仅...而且..." dùng biểu thị mức độ tăng tiến bổ sung (không chỉ... mà còn...). Phân câu sau bổ sung thêm một hành động hoặc đặc điểm vượt trội hơn.',
    'HSK 3',
    34,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他不但能熟练使用普通话日常交流，还会唱很多首经典的民间民歌。',
      'Tā búdàn néng shúliàn shǐyòng pǔtōnghuà rìcháng jiāoliú, hái huì chàng hěn duō shǒu jīngdiǎn de mínjiān míngē.',
      'Anh ấy không chỉ có thể giao tiếp hằng ngày thuần thục bằng tiếng phổ thông, mà còn biết hát rất nhiều bài dân ca dân gian kinh điển.',
      '"不但...还会" bổ sung khả năng hát dân ca bên cạnh kỹ năng nói tiếng Trung.'
    ),
    (
      v_gp_id,
      '这次大扫除不仅把教室打扫得干干净净，还把走廊两侧的玻璃擦得透亮。',
      'Zhè cì dàsǎochú bùjǐn bǎ jiàoshì dǎsǎo de gāngān-jìngjìng, hái bǎ zǒuláng liǎngcè de bōli cā de tòuliàng.',
      'Đợt tổng vệ sinh này không chỉ quét dọn lớp học sạch bóng tinh tươm, mà còn lau kính hai bên hành lang sáng loáng.',
      '"不但...还..." mở rộng phạm vi công việc đã hoàn thành.'
    );

  -- Điểm ngữ pháp #35: Liên từ điều kiện duy nhất "只有...才..." (Chỉ có... mới...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ điều kiện duy nhất "只有...才..." (Chỉ có... mới...)',
    '只有 + Điều kiện duy nhất bắt buộc, 才 + Kết quả đạt được',
    'Liên từ',
    'Cặp liên từ "只有...才..." (zhǐyǒu... cái...) biểu thị điều kiện duy nhất và bắt buộc: chỉ có đáp ứng duy nhất điều kiện này thì kết quả mong đợi mới có thể xuất hiện (chỉ có... mới có thể...). Khác với "只要...就..." (điều kiện cần - chỉ cần là được).',
    'HSK 3',
    35,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '只有持之以恒地脚踏实地努力拼搏，才能在学术研究领域取得突破成就。',
      'Zhǐyǒu chízhi-yǐhéng de jiǎotà-shídì nǔlì pīnbó, cáinéng zài xuéshù yánjiū lǐngyù qùdé tūpò chéngjiù.',
      'Chỉ có kiên trì không ngơi nghỉ vững vàng nỗ lực phấn đấu thì mới có thể gặt hái thành tựu đột phá trong lĩnh vực nghiên cứu học thuật.',
      '"只有...才能..." nhấn mạnh sự kiên trì là con đường duy nhất dẫn tới đột phá.'
    ),
    (
      v_gp_id,
      '只有经过严格的专业体检与理论考核，合格者才能获得民航飞行员执照。',
      'Zhǐyǒu jīngguò yángé de zhuānyè tǐjiǎn yǔ lǐlùn kǎohé, hégézhě cáinéng huòdé mínháng fēixíngyuán zhízhào.',
      'Chỉ có trải qua khám sức khỏe chuyên môn và khảo hạch lý thuyết nghiêm ngặt, người đạt chuẩn mới có thể nhận bằng phi công hàng không dân dụng.',
      'Nêu điều kiện tiên quyết duy nhất để được cấp bằng bay.'
    );

  -- Điểm ngữ pháp #36: Liên từ giả thiết suy luận "既然...就..." (Đã... thì...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ giả thiết suy luận "既然...就..." (Đã... thì...)',
    '既然 + Tiền đề / Sự thật đã xảy ra, (那么) 就 + Kết luận / Lời khuyên',
    'Liên từ',
    'Cặp liên từ "既然...就..." (jìrán... jiù...) dùng để đưa ra kết luận hoặc kiến nghị hợp logic dựa trên một sự thật hiển nhiên hoặc một tiền đề đã định đoạt từ trước (đã như vậy rồi... thì hãy...).',
    'HSK 3',
    36,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '既然大家都已经一致同意了这个合作方案，那么我们就立刻着手组织实施吧。',
      'Jìrán dàjiā dōu yǐjīng yízhì tóngyì le zhè gè hézuò fāng''àn, nàme wǒmen jiù lìkè zhuóshǒu zǔzhī shíshī ba.',
      'Đã mọi người đều đã nhất trí thông qua phương án hợp tác này rồi, thế thì chúng ta hãy lập tức bắt tay vào tổ chức triển khai thôi.',
      '"既然...就..." đưa ra hành động triển khai dựa trên sự đồng thuận đã có.'
    ),
    (
      v_gp_id,
      '既然你今天身体有些发烧不适，就留在宿舍好好卧床休息，不要去自习了。',
      'Jìrán nǐ jīntiān shēntǐ yǒuxiē fāshāo bùshì, jiù liú zài sùshè hǎohǎo wòchuáng xiūxi, bú yào qù zìxí le.',
      'Đã hôm nay người bạn hơi phát sốt khó chịu rồi thì hãy ở lại ký túc xá tĩnh dưỡng nghỉ ngơi trên giường, đừng đi tự học nữa.',
      'Đưa ra lời khuyên nghỉ ngơi dựa trên tình hình sức khỏe thực tế.'
    );

  -- Điểm ngữ pháp #37: Liên từ nhượng bộ giả thiết "即使...也..." (Cho dù... cũng...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ nhượng bộ giả thiết "即使...也..." (Cho dù... cũng...)',
    '即使 + Giả thiết cực đoan / Khó khăn, 主语 + 也 + Kết quả không đổi',
    'Liên từ',
    'Cặp liên từ "即使...也..." (jíshǐ... yě...) biểu thị mối quan hệ nhượng bộ giả thiết: thừa nhận một tình huống giả định khó khăn hoặc cực đoan nhất, nhưng kết quả hoặc thái độ ở phân câu sau vẫn kiên định không hề lay chuyển (cho dù... cũng vẫn...).',
    'HSK 3',
    37,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '即使在前进的道路上遇到再大的风雨坎坷，我们也不会轻易放弃最初的理想。',
      'Jíshǐ zài qiánjìn de dàolù shang yù dào zài dà de fēngyǔ kǎnkě, wǒmen yě bú huì qīngyì fàngqì zuìchū de lǐxiǎng.',
      'Cho dù trên con đường phía trước gặp phải mưa gió gập ghềnh to lớn đến mấy, chúng tôi cũng sẽ không dễ dàng từ bỏ lý tưởng ban đầu.',
      '"即使...也..." nhấn mạnh sự kiên định lý tưởng trước mọi thử thách khắc nghiệt.'
    ),
    (
      v_gp_id,
      '明天即使户外下暴雪气温降到零下十度，长跑队员们也会按时参加常规体能集训。',
      'Míngtiān jíshǐ hùwài xià bàoxuě qìwēn jiàng dào língxià shí dù, chángpǎo duìyuán men yě huì ànshí cānjiā chángguī tǐnéng jíxùn.',
      'Ngày mai cho dù ngoài trời đổ bão tuyết nhiệt độ hạ xuống âm mười độ, các vận động viên chạy dài cũng sẽ tham gia tập huấn thể lực định kỳ đúng giờ.',
      'Khẳng định ý chí tập luyện bất chấp thời tiết bão tuyết giả định.'
    );

  -- Điểm ngữ pháp #38: Liên từ song song hai mặt "一方面...另一方面..." (Một mặt... mặt khác...)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ song song hai mặt "一方面...另一方面..." (Một mặt... mặt khác...)',
    '一方面 + Khía cạnh 1, 另一方面 + Khía cạnh 2',
    'Liên từ',
    'Cấu trúc "一方面...另一方面..." (yì fāngmiàn... lìng yì fāngmiàn...) dùng để trình bày, phân tích hai mặt hoặc hai khía cạnh tương đương cùng tồn tại song song trong một vấn đề (một mặt... mặt khác...). Giúp lập luận cân đối và toàn diện.',
    'HSK 3',
    38,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '发展数字经济一方面能大幅提高生产效率，另一方面也能催生出海量全新的高薪就业岗位。',
      'Fāzhǎn shùzì jīngjì yì fāngmiàn néng dàfú tígāo shēngchǎn xiàolǜ, lìng yì fāngmiàn yě néng cuīshēng chū hǎiliàng quánxīn de gāoxīn jiùyè gǎngwèi.',
      'Phát triển kinh tế số một mặt có thể nâng cao vượt bậc hiệu suất sản xuất, mặt khác cũng có thể sản sinh ra khối lượng lớn các vị trí việc làm lương cao mới toanh.',
      '"一方面...另一方面..." phân tích hai lợi ích song hành của kinh tế số.'
    ),
    (
      v_gp_id,
      '大学生活一方面要认真钻研专业理论知识，另一方面也要积极参与社会公益实践活动。',
      'Dàxué shēnghuó yì fāngmiàn yào rènzhēn zuānyán zhuānyè lǐlùn zhīshi, lìng yì fāngmiàn yě yào jījí cānyù shèhuì gōngyì shíjiàn huódòng.',
      'Đời sống đại học một mặt phải chăm chỉ đào sâu tri thức lý luận chuyên ngành, mặt khác cũng cần tích cực tham gia các hoạt động thực hành công ích xã hội.',
      'Cân bằng giữa việc học lý thuyết và hoạt động thực tế.'
    );

  -- Điểm ngữ pháp #39: Liên từ chuyển tiếp cực đoan "甚至" (Thậm chí / Ngay cả)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ chuyển tiếp cực đoan "甚至" (Thậm chí / Ngay cả)',
    'A, B, 甚至 (连) + C + 都 / 也 + Vị ngữ',
    'Liên từ',
    '"甚至" (shènzhì) dùng để đưa ra một ví dụ nổi bật, bất ngờ hoặc có tính chất cực đoan nhất nhằm nhấn mạnh mức độ sâu sắc vượt xa dự liệu thông thường (thậm chí, ngay cả... cũng).',
    'HSK 3',
    39,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这道物理科研难题极其复杂，很多资深教授甚至世界级科学家都感到十分棘手。',
      'Zhè dào wùlǐ kēyán nántí jíqí fùzá, hěn duō zīshēn jiàoshòu shènzhì shìjièjí kēxuéjiā dōu gǎndào shífēn jíshǒu.',
      'Bài toán nghiên cứu vật lý này phức tạp tột cùng, rất nhiều giáo sư kỳ cựu thậm chí cả các nhà khoa học đẳng cấp thế giới cũng đều cảm thấy vô cùng hóc búa.',
      '"甚至世界级科学家" đưa ra đối tượng đỉnh cao để làm nổi bật độ khó.'
    ),
    (
      v_gp_id,
      '他沉迷于实验室的核心技术攻坚，连续几个月甚至连周末都泡在仪器前。',
      'Tā chénmí yú shíyànshì de héxīn jìshù gōngjiān, liánxù jǐ gè yuè shènzhì lián zhōumò dōu pào zài yíqì qián.',
      'Anh ấy say mê công phá công nghệ cốt lõi trong phòng thí nghiệm, liên tục mấy tháng trời thậm chí ngay cả cuối tuần cũng cắm mặt bên thiết bị.',
      '"甚至连周末都" nhấn mạnh tinh thần nghiên cứu quên cả ngày nghỉ.'
    );

  -- Điểm ngữ pháp #40: Liên từ chuyển tiếp bổ sung "另外" (Ngoài ra / Hơn nữa)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ chuyển tiếp bổ sung "另外" (Ngoài ra / Hơn nữa)',
    'Phân câu 1. 另外, + Phân câu 2 / 另外 (+ 的) + Danh từ',
    'Liên từ',
    '"另外" (lìngwài) dùng làm liên từ đứng đầu câu hoặc phân câu để bổ sung thêm một ý, một thông tin hoặc một công việc khác bên cạnh điều đã nêu (ngoài ra, hơn nữa). Cũng làm đại từ/định ngữ (cái khác, người khác: 另外两个人).',
    'HSK 3',
    40,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '会议期间请大家务必保持手机静音，另外，会场内严禁随意吸烟与喧哗。',
      'Huìyì qījiān qǐng dàjiā wùbì bǎochí shǒujī jìngyīn, lìngwài, huìchǎng nèi yánjìn suíyì xīyān yǔ xuānhuá.',
      'Trong thời gian hội nghị xin mọi người nhất định giữ điện thoại ở chế độ im lặng, ngoài ra, trong hội trường nghiêm cấm tùy tiện hút thuốc và làm ồn.',
      '"另外" bổ sung thêm quy định cấm hút thuốc.'
    ),
    (
      v_gp_id,
      '今天上午我已经面试了五位求职者，另外三位候选人安排在今天下午两点。',
      'Jīntiān shàngwǔ wǒ yǐjīng miànshì le wǔ wèi qiúzhízhě, lìngwài sān wèi hòuxuǎnrén ānpái zài jīntiān xiàwǔ liǎng diǎn.',
      'Sáng nay tôi đã phỏng vấn năm ứng viên xin việc, ba ứng viên còn lại được sắp xếp vào lúc hai giờ chiều nay.',
      '"另外三位" làm định ngữ chỉ 3 người ứng viên còn lại.'
    );

  -- Điểm ngữ pháp #41: Liên từ điều kiện không giới hạn "无论 / 不管...都 / 也..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Liên từ điều kiện không giới hạn "无论 / 不管...都 / 也..."',
    '无论 / 不管 + Từ để hỏi / A hay B, Chủ ngữ + 都 / 也 + Vị ngữ',
    'Liên từ',
    '"无论" (wúlùn) hoặc "不管" (bùguǎn) biểu thị trong bất kỳ điều kiện, hoàn cảnh hoặc trường hợp nào thì kết quả, hành động ở vế sau vẫn diễn ra như cũ không hề thay đổi (cho dù, bất kể... đều). Phân câu trước bắt buộc phải có từ nghi vấn hoặc phương án lựa chọn (A hay B, làm gì, ở đâu).',
    'HSK 3',
    41,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '无论前方的道路有多么坎坷艰险，我们都会坚定不移地朝着心中的目标勇毅前行。',
      'Wúlùn qiánfāng de dàolù yǒu duōme kǎnkě jiānxiǎn, wǒmen dōu huì jiāndìng-bùyí de cháozhe xīnzhōng de mùbiāo yǒngyì qiánxíng.',
      'Bất kể con đường phía trước có gập ghềnh hiểm trở đến nhường nào, chúng tôi đều sẽ kiên định không dời dũng cảm tiến về mục tiêu trong lòng.',
      '"无论...有多么...都..." khẳng định quyết tâm trước mọi gian nan.'
    ),
    (
      v_gp_id,
      '不管明天天气晴天还是刮风下雨，全校的春季运动会都会如期隆重举行。',
      'Bùguǎn míngtiān tiānqì qíngtiān háishì guāfēng xiàyǔ, quán xiào de chūnjì yùndònghuì dōu huì rúqī lóngzhòng jǔxíng.',
      'Cho dù ngày mai thời tiết trời nắng hay nổi gió đổ mưa, đại hội thể thao mùa xuân toàn trường đều sẽ diễn ra đúng hẹn và long trọng.',
      '"不管...还是...都" loại bỏ ảnh hưởng của thời tiết đối với kế hoạch.'
    );

  -- Điểm ngữ pháp #42: Giới từ giới thiệu chủ đề phạm vi "关于" (Về / Về vấn đề)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ giới thiệu chủ đề phạm vi "关于" (Về / Về vấn đề)',
    '关于 + Đối tượng / Vấn đề, Chủ ngữ + Vị ngữ / 关于...的 + Danh từ',
    'Giới từ',
    '"关于" (guānyú) đứng trước danh từ để giới thiệu phạm vi, chủ đề hoặc nội dung liên quan của sự việc (về, về vấn đề). Thường đứng đầu câu làm trạng ngữ hoặc kết hợp "的" làm định ngữ (sách về...: 关于...的书).',
    'HSK 3',
    42,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '关于如何有效提高留学生汉语口语交际能力的问题，两位专家展开了深入探讨。',
      'Guānyú rúhé yǒuxiào tígāo liúxuéshēng hànyǔ kǒuyǔ jiāojì nénglì de wèntí, liǎng wèi zhuānjiā zhǎnkāi le shēnrù tàntǎo.',
      'Về vấn đề làm thế nào để nâng cao hữu hiệu năng lực giao tiếp khẩu ngữ tiếng Hán của lưu học sinh, hai vị chuyên gia đã mở ra cuộc thảo luận sâu sắc.',
      '"关于...的问题" giới thiệu chủ đề trung tâm của cuộc trao đổi.'
    ),
    (
      v_gp_id,
      '他在省立图书馆查阅了海量关于中国古代青铜器铸造工艺的历史文献。',
      'Tā zài shěnglì túshūguǎn cháyuè le hǎiliàng guānyú zhōngguó gǔdài qīngtóngqì zhùzào gōngyì de lìshǐ wénxiàn.',
      'Anh ấy ở thư viện cấp tỉnh đã tra cứu khối lượng lớn tài liệu lịch sử về kỹ nghệ đúc đồ đồng cổ đại Trung Quốc.',
      '"关于...的历史文献" làm cụm giới từ làm định ngữ bổ nghĩa cho tài liệu.'
    );

  -- Điểm ngữ pháp #43: Giới từ chỉ đối tượng thụ cảm "对于" (Đối với / Về mặt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ chỉ đối tượng thụ cảm "对于" (Đối với / Về mặt)',
    '对于 + Đối tượng, Chủ ngữ + Vị ngữ / Chủ ngữ + 对于 + Đối tượng + Vị ngữ',
    'Giới từ',
    '"对于" (duìyú) dùng để đưa ra đối tượng mà ý kiến, thái độ, sự phán đoán nhắm vào (đối với, đối cùng). Khác với "对", "对于" chỉ dùng cho quan điểm, thái độ, không dùng cho hành vi tác động cụ thể giữa người với người (không nói 对于他笑).',
    'HSK 3',
    43,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '对于这个涉及旧城改造与古建筑保护的城市规划草案，市民们提出了很多宝贵建议。',
      'Duìyú zhè gè shèjí jiùchéng gǎizào yǔ gǔ jiànzhù bǎohù de chéngshì guīhuà cǎo''àn, shìmín men tíchū le hěn duō bǎoguì jiànyì.',
      'Đối với dự thảo quy hoạch đô thị liên quan đến cải tạo phố cũ và bảo tồn kiến trúc cổ này, người dân đã đề xuất rất nhiều kiến nghị quý báu.',
      '"对于...规划草案" xác định đối tượng tiếp nhận ý kiến đóng góp.'
    ),
    (
      v_gp_id,
      '养成良好的每日阅读习惯，对于青少年综合素质的全面提升具有长远意义。',
      'Yǎngchéng liánghǎo de měirì yuèdú xíguàn, duìyú qīng-shàonián zōnghé sùzhì de quánmiàn tíshēng jùyǒu chángyuǎn yìyì.',
      'Hình thành thói quen đọc sách hằng ngày tốt đẹp, đối với việc nâng cao toàn diện tố chất tổng hợp của thanh thiếu niên có ý nghĩa lâu dài.',
      '"对于...全面提升" chỉ phương diện thụ hưởng lợi ích lâu dài.'
    );

  -- Điểm ngữ pháp #44: Giới từ căn cứ quy chuẩn "按照" (Theo / Căn cứ vào)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ căn cứ quy chuẩn "按照" (Theo / Căn cứ vào)',
    '按照 + Tiêu chuẩn / Quy định / Yêu cầu + Động từ (+ Tân ngữ)',
    'Giới từ',
    '"按照" (ànzhào) biểu thị hành động được thực hiện dựa theo một tiêu chuẩn, quy chuẩn, quy định, kế hoạch hoặc yêu cầu đã được đề ra từ trước (theo, căn cứ theo, chiểu theo).',
    'HSK 3',
    44,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '工程质检人员严格按照国家建筑安全工程标准，对大楼主体结构进行了全面检测。',
      'Gōngchéng zhìjiǎn rényuán yángé ànzhào guójiā jiànzhù ānquán gōngchéng biāozhǔn, duì dàlóu zhǔtǐ jiégòu jìnxíng le quánmiàn jiǎncè.',
      'Các nhân viên kiểm định chất lượng công trình nghiêm ngặt căn cứ theo tiêu chuẩn công trình an toàn xây dựng quốc gia để tiến hành kiểm định toàn diện kết cấu thân tòa nhà.',
      '"按照...标准" chỉ chuẩn mực căn cứ để kiểm tra chất lượng.'
    ),
    (
      v_gp_id,
      '请所有参会代表按照会务组统一安排的日程表，准时入场参加学术讨论。',
      'Qǐng suǒyǒu cānhuì dàibiǎo ànzhào huìwùzǔ tǒngyī ānpái de rìchéngbiǎo, zhǔnshí rùchǎng cānjiā xuéshù tǎolùn.',
      'Xin mời toàn thể đại biểu tham dự hội nghị theo đúng lịch trình do ban tổ chức sắp xếp thống nhất, vào hội trường đúng giờ tham gia thảo luận học thuật.',
      '"按照...日程表" hành động tuân thủ theo lịch trình có sẵn.'
    );

  -- Điểm ngữ pháp #45: Giới từ căn cứ chứng cứ "根据" (Căn cứ theo / Dựa vào)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ căn cứ chứng cứ "根据" (Căn cứ theo / Dựa vào)',
    '根据 + Căn cứ / Bằng chứng / Thực tế + Phán đoán / Hành động',
    'Giới từ',
    '"根据" (gēnjù) dùng để đưa ra cơ sở, bằng chứng, dữ liệu hoặc căn cứ thực tế làm điểm tựa để đưa ra kết luận, phán đoán hoặc quyết định (căn cứ vào, dựa trên cơ sở). Ngoài ra còn làm danh từ (chứng cứ, cơ sở).',
    'HSK 3',
    45,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '气象部门根据最新卫星云图的监测数据，及时发布了沿海强台风黄色预警。',
      'Qìxiàng bùmén gēnjù zuìxīn wèixīng yúntú de jiāncè shùjù, jíshí fābù le yánhǎi qiáng táifēng huángsè yùjǐng.',
      'Cơ quan khí tượng căn cứ vào số liệu giám sát của ảnh mây vệ tinh mới nhất đã kịp thời phát cảnh báo màu vàng về bão mạnh ven biển.',
      '"根据...数据" đưa ra căn cứ dữ liệu vệ tinh để phát cảnh báo.'
    ),
    (
      v_gp_id,
      '这本轰动文坛的侦探悬疑长篇小说，是作家根据几起真实历史案件创作而成的。',
      'Zhè běn hōngdòng wéntán de zhēntàn xuányí chángpiān xiǎoshuō, shì zuòjiā gēnjù jǐ qǐ zhēnshí lìshǐ ànjiàn chuàngzuò ér chéng de.',
      'Cuốn tiểu thuyết trường thiên trinh thám ly kỳ làm chấn động văn đàn này là do nhà văn dựa trên một vài vụ án lịch sử có thật sáng tác nên.',
      '"根据...案件" chỉ tư liệu thực tế làm điểm tựa sáng tác.'
    );

  -- Điểm ngữ pháp #46: Giới từ biến đổi đồng thời "随着" (Cùng với / Theo đà)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ biến đổi đồng thời "随着" (Cùng với / Theo đà)',
    '随着 + Danh từ / Sự phát triển / Biến đổi, Chủ ngữ + Vị ngữ biến đổi tương ứng',
    'Giới từ',
    '"随着" (suízhe) dùng để chỉ một sự việc, hiện tượng phát sinh hoặc biến đổi đồng thời theo sau sự chuyển biến của một sự vật, điều kiện khác (cùng với sự phát triển của..., theo đà...). Thường đứng ở đầu câu.',
    'HSK 3',
    46,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '随着现代数字科技的高速发展，移动支付与无接触购物已经深度融入了千家万户。',
      'Suízhe xiàndài shùzì kējì de gāosù fāzhǎn, yídòng zhīfù yǔ wú jiēchù gòuwù yǐjīng shēndù róngrù le qiānjiā-wànhù.',
      'Cùng với sự phát triển thần tốc của công nghệ số hiện đại, thanh toán di động và mua sắm không tiếp xúc đã hòa nhập sâu sắc vào muôn nhà vạn hộ.',
      '"随着...高速发展" đưa ra tiền đề công nghệ làm thay đổi đời sống tiêu dùng.'
    ),
    (
      v_gp_id,
      '随着深秋季节气温的持续下降，公园湖畔的大片水杉树叶变得一片金黄灿烂。',
      'Suízhe shēnqiū jìjié qìwēn de chíxù xiàjiàng, gōngyuán húpàn de dàpiàn shuǐshān shùyè biàn de yí piàn jīnhuáng cànlàn.',
      'Cùng với sự giảm liên tục của nhiệt độ mùa thu muộn, rặng lá cây thủy sam bên bờ hồ công viên đã ngả sang một màu vàng óng rực rỡ.',
      '"随着...持续下降" sự biến đổi màu lá đồng hành với sự hạ nhiệt thời tiết.'
    );

  -- Điểm ngữ pháp #47: Giới từ trải qua quá trình nỗ lực "经过" (Trải qua / Qua)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ trải qua quá trình nỗ lực "经过" (Trải qua / Qua)',
    '经过 + Quá trình / Nỗ lực / Thời gian, Chủ ngữ + Đạt được kết quả',
    'Giới từ',
    '"经过" (jīngguò) biểu thị một quá trình rèn luyện, tìm tòi, phấn đấu hoặc diễn biến thời gian đã trải qua để dẫn tới một kết quả cụ thể (trải qua, qua một quá trình...). Ngoài ra còn làm động từ chỉ việc đi ngang qua một địa điểm.',
    'HSK 3',
    47,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经过科研团队历时三年的联合技术攻坚，该新型环保节能材料终于研发成功了。',
      'Jīngguò kēyán tuánduì lìshí sān nián de liánhé jìshù gōngjiān, gāi xīnxíng huánbǎo jiénéng cáiliào zhōngyú yánfā chénggōng le.',
      'Trải qua ba năm công phá kỹ thuật liên hợp của đội ngũ nghiên cứu, vật liệu tiết kiệm năng lượng bảo vệ môi trường kiểu mới này cuối cùng đã phát triển thành công.',
      '"经过...技术攻坚" nhấn mạnh quá trình gian khổ dẫn đến thành quả.'
    ),
    (
      v_gp_id,
      '每天早晨乘坐这趟城际班车，都会经过那座横跨大江的宏伟跨海大桥。',
      'Měitiān zǎochén chéngzuò zhè tàng chéngjì bānchē, dōu huì jīngguò nà zuò héngkuà dàjiāng de hóngwěi kuàhǎi dàqiáo.',
      'Mỗi sáng sớm đi chuyến xe buýt liên tỉnh này đều sẽ đi ngang qua cây cầu vượt biển hùng vĩ bắc ngang sông lớn kia.',
      '"经过...跨海大桥" làm động từ chỉ việc đi ngang qua địa danh.'
    );

  -- Điểm ngữ pháp #48: Giới từ phương thức công cụ "通过" (Thông qua / Bằng cách)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Giới từ phương thức công cụ "通过" (Thông qua / Bằng cách)',
    '通过 + Phương thức / Kênh trung gian / Biện pháp, Chủ ngữ + Đạt mục đích',
    'Giới từ',
    '"通过" (tōngguò) giới thiệu phương thức, thủ đoạn, phương tiện hoặc khâu trung gian để đạt được mục đích đề ra (thông qua, nhờ có, bằng cách). Ngoài ra còn làm động từ chỉ việc thi đỗ hoặc được thông qua dự thảo (như 通过考试).',
    'HSK 3',
    48,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '通过阅读经典文学名著和观看中文纪录片，他的汉语听说水平有了显著飞跃。',
      'Tōngguò yuèdú jīngdiǎn wénxué míngzhù hé guānkàn zhōngwén jìlùpiàn, tā de hànyǔ tīng-shuō shuǐpíng yǒu le xiǎnzhù fēiyuè.',
      'Thông qua việc đọc danh tác văn học kinh điển và xem phim tài liệu tiếng Trung, trình độ nghe nói tiếng Hán của anh ấy đã có bước nhảy vọt rõ rệt.',
      '"通过阅读...和观看..." nêu phương thức rèn luyện dẫn tới bước tiến bộ.'
    ),
    (
      v_gp_id,
      '经过全校代表大会的热烈讨论，这项关于学生公寓管理的新规章获得了全票通过。',
      'Jīngguò quán xiào dàibiǎo dàhuì de rèliè tǎolùn, zhè xiàng guānyú xuésheng gōngyù guǎnlǐ de xīn guīzhāng huòdé le quánpiào tōngguò.',
      'Trải qua cuộc thảo luận sôi nổi của đại hội đại biểu toàn trường, quy định mới về quản lý ký túc xá sinh viên này đã được toàn phiếu thông qua.',
      '"全票通过" làm động từ chỉ văn bản được phê chuẩn chính thức.'
    );

  -- Điểm ngữ pháp #49: Bổ ngữ kết quả ly khai / dịch chuyển "走" (Đi / Rời đi)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả ly khai / dịch chuyển "走" (Đi / Rời đi)',
    'Động từ (拿 / 带 / 搬 / 借) + 走 (+ Tân ngữ)',
    'Bổ ngữ',
    '"走" (zǒu) làm bổ ngữ kết quả đứng sau động từ chỉ sự rời khỏi vị trí ban đầu của đồ vật hoặc con người do hành động gây ra (mang đi, lấy đi, chuyển đi, bay đi: 拿走, 带走, 搬走, 飞走).',
    'HSK 3',
    49,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他离开办公室去外地出差之前，顺手把桌上所有的重要公文都带走了。',
      'Tā líkāi bàngōngshì qù wàidì chūchāi zhīqián, shùnshǒu bǎ zhuō shang suǒyǒu de zhòngyào gōngwén dōu dài zǒu le.',
      'Trước khi rời văn phòng đi công tác ngoại tỉnh, anh ấy tiện tay đã mang đi tất cả công văn quan trọng trên bàn.',
      '"带走了" biểu thị tài liệu đã theo người di chuyển rời khỏi phòng.'
    ),
    (
      v_gp_id,
      '一阵猛烈的秋风刮过树梢，瞬间把树枝上的枯黄落叶全都吹走了。',
      'Yí zhèn měngliè de qiūfēng guā guò shùshāo, shùnjiān bǎ shùzhī shang de kūhuáng luòyè quándōu chuī zǒu le.',
      'Một cơn gió thu dữ dội thổi qua ngọn cây, trong nháy mắt đã thổi bay hết sạch lá vàng khô rụng trên cành cây.',
      '"吹走了" làm bổ ngữ miêu tả lá cây bị gió cuốn đi xa.'
    );

  -- Điểm ngữ pháp #50: Bổ ngữ kết quả tiêu biến / loại trừ "掉" (Mất / Hết / Vứt bỏ)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả tiêu biến / loại trừ "掉" (Mất / Hết / Vứt bỏ)',
    'Động từ (丢 / 扔 / 忘 / 擦 / 卖) + 掉 (+ Tân ngữ)',
    'Bổ ngữ',
    '"掉" (diào) làm bổ ngữ kết quả biểu thị sự biến mất, mất mát, tiêu biến hoặc loại bỏ hoàn toàn một đối tượng hay đặc tính nào đó (rơi mất: 丢掉, vứt đi: 扔掉, quên sạch: 忘掉, lau sạch: 擦掉).',
    'HSK 3',
    50,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '清洁工阿姨用干净的毛巾，把黑板上的所有粉笔字迹彻底擦掉了。',
      'Qīngjiégōng āyí yòng gānjìng de máojīn, bǎ hēibǎn shang de suǒyǒu fěnbǐ zìjì chèdǐ cā diào le.',
      'Bác lao công dùng chiếc khăn bông sạch sẽ lau sạch hoàn toàn mọi vết phấn trên bảng đen.',
      '"擦掉了" biểu thị vết phấn trên bảng bị xóa sạch không còn.'
    ),
    (
      v_gp_id,
      '面对生活中的挫折与烦恼，我们要学会调整心态，尽快把不愉快的情绪忘掉。',
      'Miànduì shēnghuó zhōng de cuòzhé yǔ fánnǎo, wǒmen yào xuéhuì tiáozhěng xīntài, jǐnkuài bǎ bù yúkuài de qíngxù wàng diào.',
      'Đối mặt với trắc trở và phiền muộn trong đời, chúng ta cần học cách điều chỉnh tâm thái, mau chóng quên hết những cảm xúc không vui đi.',
      '"忘掉" làm bổ ngữ kết quả cho việc loại bỏ nỗi buồn khỏi tâm trí.'
    );

  -- Điểm ngữ pháp #51: Bổ ngữ kết quả cố định vững chắc "住" (Chặt / Chắc / Dừng lại)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả cố định vững chắc "住" (Chặt / Chắc / Dừng lại)',
    'Động từ (站 / 记 / 拿 / 停 / 抓) + 住 (+ Tân ngữ)',
    'Bổ ngữ',
    '"住" (zhù) làm bổ ngữ kết quả biểu thị hành động đã làm cho người hoặc vật trở nên cố định, dừng lại, bám chắc hoặc khắc sâu vào trí nhớ (đứng vững: 站住, nhớ kỹ: 记住, cầm chắc: 拿住, dừng lại: 停住).',
    'HSK 3',
    51,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '老师反复认真强调的核心语法知识点，同学们必须牢牢记住并熟练运用。',
      'Lǎoshī fǎnfù rènzhēn qiángdiào de héxīn yǔfǎ zhīshidiǎn, tóngxué men bìxū láoláo jì zhù bìng shúliàn yùnyòng.',
      'Các điểm kiến thức ngữ pháp cốt lõi mà thầy giáo nghiêm túc nhấn mạnh nhiều lần, các bạn học sinh bắt buộc phải ghi nhớ thật chắc và vận dụng thuần thục.',
      '"记住" biểu thị kiến thức được ghi khắc vững chắc trong đầu.'
    ),
    (
      v_gp_id,
      '暴风雨中巡逻的边防战士们手挽着手，在泥泞陡峭的山坡上稳稳站住了脚跟。',
      'Bàofēngyǔ zhōng xúnluó de biānfáng zhànshì men shǒu wǎn zhe shǒu, zài nínìng dǒuqiào de shānpō shang wěnwěn zhàn zhù le jiǎogēn.',
      'Các chiến sĩ biên phòng tuần tra trong giông bão khoác tay nhau, đứng vững chắc gót chân trên sườn dốc trơn trượt hiểm trở.',
      '"站住了" biểu thị việc giữ vững tư thế không để bị trượt ngã.'
    );

  -- Điểm ngữ pháp #52: Bổ ngữ kết quả tách rời / khuếch tán "开" (Mở ra / Tách ra)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả tách rời / khuếch tán "开" (Mở ra / Tách ra)',
    'Động từ (打 / 翻 / 分 / 走 / 离开) + 开 (+ Tân ngữ)',
    'Bổ ngữ',
    '"开" (kāi) làm bổ ngữ kết quả biểu thị hành động làm cho hai hoặc nhiều sự vật tách rời nhau ra, mở rộng không gian hoặc tản rộng ra các phía (mở ra: 打开, giở sách: 翻开, tách ra: 分开, tránh ra: 避开).',
    'HSK 3',
    52,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '上课铃声响起，同学们迅速翻开崭新的汉语课本开始大声朗读课文。',
      'Shàngkè língshēng xiǎng qǐ, tóngxué men xùnsù fān kāi zhǎnxīn de hànyǔ kèběn kāishǐ dàshēng lǎngdú kèwén.',
      'Tiếng chuông vào lớp vang lên, các bạn học sinh nhanh chóng giở trang sách giáo khoa tiếng Hán mới tinh bắt đầu đọc to bài khóa.',
      '"翻开" biểu thị các trang sách mở tách rời ra.'
    ),
    (
      v_gp_id,
      '为了避免引起不必要的误解与冲突，讨论时双方应当把不同意见摊开来说清楚。',
      'Wèile bìmiǎn yǐnqǐ bú bìyào de wùjiě yǔ chōngtū, tǎolùn shí shuāngfāng yīngdāng bǎ bùtóng yìjiàn tān kāi lái shuō qīngchu.',
      'Để tránh gây ra hiểu lầm và xung đột không cần thiết, khi thảo luận hai bên nên trải rộng các ý kiến bất đồng ra để nói cho rõ ràng.',
      '"摊开" miêu tả việc mở rộng công khai các vấn đề.'
    );

  -- Điểm ngữ pháp #53: Bổ ngữ kết quả bám dính / khép lại "上" (Đóng / Mặc / Đạt)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả bám dính / khép lại "上" (Đóng / Mặc / Đạt)',
    'Động từ (穿 / 关 / 闭 / 爱 / 考) + 上 (+ Tân ngữ)',
    'Bổ ngữ',
    '"上" (shàng) làm bổ ngữ kết quả biểu thị hai vật tiếp xúc khép kín lại (như 闭上: nhắm mắt, 关上: đóng cửa, 穿上: mặc áo vào), hoặc bắt đầu nảy sinh tình cảm, đạt được mục tiêu mong ước (như 考上: thi đỗ, 爱上: đem lòng yêu).',
    'HSK 3',
    53,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '离开办公室前，请最后一位同事务必锁好抽屉并关上所有门窗。',
      'Líkāi bàngōngshì qián, qǐng zuìhòu yí wèi tóngshì wùbì suǒ hǎo chōuti bìng guān shàng suǒyǒu ménchuāng.',
      'Trước khi rời văn phòng, xin đồng nghiệp cuối cùng nhất định khóa kỹ ngăn kéo và đóng hết tất cả cửa sổ cửa ra vào.',
      '"关上" biểu thị hành động khép kín các cánh cửa lại.'
    ),
    (
      v_gp_id,
      '经过整整一年的艰苦努力复习，他今年终于考上了理想的重点大学。',
      'Jīngguò zhěngzhěng yì nián de jiānkǔ nǔlì fùxí, tā jīnnián zhōngyú kǎo shàng le lǐxiǎng de zhòngdiǎn dàxué.',
      'Trải qua tròn một năm gian khổ nỗ lực ôn tập, năm nay anh ấy cuối cùng đã thi đỗ vào trường đại học trọng điểm mơ ước.',
      '"考上了" biểu thị thi đỗ thành công đạt mục tiêu.'
    );

  -- Điểm ngữ pháp #54: Bổ ngữ kết quả lưu lại / cố định "下" (Lưu lại / Ngồi xuống)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả lưu lại / cố định "下" (Lưu lại / Ngồi xuống)',
    'Động từ (留 / 记 / 坐 / 停 / 拍) + 下 (+ Tân ngữ)',
    'Bổ ngữ',
    '"下" (xià) làm bổ ngữ kết quả biểu thị người hoặc vật dừng lại cố định tại một chỗ (như 坐下: ngồi xuống, 停下: dừng lại), hoặc biểu thị sự lưu giữ, bảo tồn lại dấu vết, ký ức (như 留下: để lại, 记下: ghi lại, 拍下: chụp lại).',
    'HSK 3',
    54,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他把客座教授在学术讲座上列举的参考书目仔细地记在了笔记本上。',
      'Tā bǎ kèzuò jiàoshòu zài xuéshù jiǎngzuò shang lièjǔ de cānkǎo shūmù zǐxì de jì xià zài le bǐjìběn shang.',
      'Anh ấy đã ghi chép lại một cách tỉ mỉ danh mục sách tham khảo mà giáo sư thỉnh giảng liệt kê trong buổi tọa đàm học thuật vào sổ tay.',
      '"记下" biểu thị hành động ghi chép lưu giữ thông tin.'
    ),
    (
      v_gp_id,
      '面对突然冲向路中央的小动物，经验丰富的司机沉着地踩刹车停下了汽车。',
      'Miànduì tūrán chōng xiàng lù zhōngyāng de xiǎo dòngwù, jīngyàn fēngfù de sījī chénzhuó de cǎi shāchē tíng xià le qìchē.',
      'Đối mặt với con vật nhỏ bất ngờ lao ra giữa lòng đường, người tài xế giàu kinh nghiệm đã bình tĩnh đạp phanh dừng chiếc xe lại.',
      '"停下了" miêu tả chiếc xe dừng lại cố định một chỗ.'
    );

  -- Điểm ngữ pháp #55: Bổ ngữ kết quả chuyển hóa kết quả "成" (Thành / Biến thành)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ kết quả chuyển hóa kết quả "成" (Thành / Biến thành)',
    'Động từ (变 / 改 / 翻 / 写 / 看) + 成 + Kết quả mới',
    'Bổ ngữ',
    '"成" (chéng) làm bổ ngữ kết quả biểu thị thông qua hành động làm cho đối tượng biến đổi thành một sự vật, trạng thái hoặc ngôn ngữ khác (dịch thành: 翻译成, viết thành: 写成, đổi thành: 改成, nhầm thành: 看成).',
    'HSK 3',
    55,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '著名翻译家将这部深奥的中国古代哲学典籍翻译成了标准现代英语。',
      'Zhùmíng fānyìjiā jiāng zhè bù shēn''ào de zhōngguó gǔdài zhéxué diǎnjí fānyì chéng le biāozhǔn xiàndài yīngyǔ.',
      'Nhà dịch thuật danh tiếng đã dịch cuốn điển tịch triết học cổ đại Trung Quốc sâu xa này thành tiếng Anh hiện đại tiêu chuẩn.',
      '"翻译成" biểu thị sự chuyển hóa ngôn ngữ từ văn ngôn sang tiếng Anh.'
    ),
    (
      v_gp_id,
      '这片原先杂草丛生的荒地，经过改造如今变成了一座美丽的花园市民公园。',
      'Zhè piàn yuánxiān zá cǎo cóngshēng de huāngdì, jīngguò gǎizào rújīn biàn chéng le yí zuò měilì de huāyuán shìmín gōngyuán.',
      'Khu đất hoang trước kia cỏ dại mọc um tùm này, sau khi cải tạo ngày nay đã biến thành một công viên công dân vườn hoa tươi đẹp.',
      '"变成" miêu tả sự biến đổi toàn diện về tính chất diện mạo.'
    );

  -- Điểm ngữ pháp #56: Bổ ngữ xu hướng mở rộng bắt đầu & phát triển "起来"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng mở rộng bắt đầu & phát triển "起来"',
    'Động từ / Tính từ + 起来 (+ 了) / 看 / 听 / 吃 + 起来',
    'Bổ ngữ',
    'Nghĩa mở rộng của "起来" (qǐlai): (1) Biểu thị hành động bắt đầu và tiếp tục phát triển (khóc òa lên: 哭起来, cười lên: 笑起来); (2) Đứng sau các động từ cảm giác biểu thị sự đánh giá, cảm nhận sơ bộ (nhìn có vẻ: 看起来, nghe có vẻ: 听起来, ăn có vị: 吃起来).',
    'HSK 3',
    56,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '听到相声演员妙趣横生的精彩幽默包袱，全场观众都忍不住哄堂大笑起来。',
      'Tīng dào xiàngsheng yǎnyuán miàoqù-héngshēng de jīngcǎi yōumò bāofu, quánchǎng guānzhòng dōu rěnbuzhù hōngtáng dàxiào qǐlai.',
      'Nghe miếng hài hước hóm hỉnh đặc sắc đầy thú vị của diễn viên tướng thanh, khán giả toàn trường đều không kìm được mà cười òa cả lên.',
      '"大笑起来" miêu tả tiếng cười bắt đầu nổ ra và tiếp diễn.'
    ),
    (
      v_gp_id,
      '这道刚出锅的中国传统松鼠桂鱼闻起来香气扑鼻，吃起来酸甜可口。',
      'Zhè dào gāng chūguō de zhōngguó chuántǒng sōngshǔ guìyú wén qǐlai xiāngqì-pūbí, chī qǐlai suāntián kěkǒu.',
      'Món cá quế sóc truyền thống Trung Quốc vừa mới nhấc khỏi chảo này ngửi có vẻ thơm nức mũi, ăn vào có vị chua ngọt vừa miệng.',
      '"闻起来" và "吃起来" thể hiện sự đánh giá qua khứu giác và vị giác.'
    );

  -- Điểm ngữ pháp #57: Bổ ngữ xu hướng mở rộng duy trì tiếp tục "下去"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng mở rộng duy trì tiếp tục "下去"',
    'Động từ + 下去 / Phủ định: 动词 + 不下去',
    'Bổ ngữ',
    '"下去" (xiàqu) làm bổ ngữ xu hướng mở rộng biểu thị hành động đang tiến hành sẽ tiếp tục kéo dài không ngừng tới tương lai (làm tiếp đi, sống tiếp, nói tiếp: 坚持下去, 说下去). Dạng phủ định là "V + 不下去" (không thể tiếp tục làm nổi).',
    'HSK 3',
    57,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '只要我们有坚定的恒心并坚持不懈地学下去，就一定能攻克汉语难关。',
      'Zhǐyào wǒmen yǒu jiāndìng de héngxīn bìng jiānchí-búxiè de xué xiàqu, jiù yídìng néng gōngkè hànyǔ nánguān.',
      'Chỉ cần chúng ta có lòng kiên trì vững vàng và bền bỉ học tiếp tục không ngơi nghỉ, thì nhất định có thể vượt qua cửa ải khó khăn của tiếng Hán.',
      '"学下去" biểu thị việc học tập tiếp tục duy trì đến tương lai.'
    ),
    (
      v_gp_id,
      '会议主持人微笑着请发言代表不要紧张，继续把调研报告详细讲下去。',
      'Huìyì zhǔchírén wēixiào zhe qǐng fāyán dàibiǎo bú yào jǐnzhāng, jìxù bǎ diàoyán bàogào xiángxì jiǎng xiàqu.',
      'Người chủ trì cuộc họp mỉm cười mời đại biểu phát biểu đừng căng thẳng, tiếp tục trình bày bản báo cáo khảo sát một cách chi tiết.',
      '"讲下去" khích lệ đại biểu tiếp tục nói phần tiếp theo.'
    );

  -- Điểm ngữ pháp #58: Bổ ngữ xu hướng mở rộng hồi phục trạng thái "过来"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng mở rộng hồi phục trạng thái "过来"',
    'Động từ (醒 / 恢复 / 明白) + 过来',
    'Bổ ngữ',
    '"过来" (guòlai) làm bổ ngữ xu hướng mở rộng biểu thị sự chuyển biến trở lại trạng thái tỉnh táo, bình thường, đúng đắn từ một trạng thái bất thường, hôn mê hoặc sai lầm (tỉnh lại: 醒过来, hồi phục lại: 缓过来, hiểu ra: 明白过来).',
    'HSK 3',
    58,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '经过医护人员连续几个小时的紧张抢救，昏迷的危重病人终于苏醒过来了。',
      'Jīngguò yīhù rényuán liánxù jǐ gè xiǎoshí de jǐnzhāng qiǎngjiù, hūnmí de wēizhòng bìngrén zhōngyú sūxǐng guòlai le.',
      'Trải qua nhiều giờ đồng hồ cấp cứu khẩn trương của nhân viên y tế, người bệnh nguy kịch hôn mê cuối cùng đã tỉnh táo lại rồi.',
      '"苏醒过来" biểu thị người bệnh từ hôn mê trở về trạng thái tỉnh táo.'
    ),
    (
      v_gp_id,
      '听到导师深入浅出的耐心点拨，小张才恍然大悟、彻底明白过来了。',
      'Tīng dào dǎoshī shēnrù-qiǎnchū de nàixīn diǎnbō, Xiǎo Zhāng cái huǎngrán-dàwù, chèdǐ míngbai guòlai le.',
      'Nghe lời chỉ bảo kiên nhẫn dễ hiểu của người hướng dẫn, Tiểu Trương mới bừng tỉnh ngộ ra, hiểu thấu suốt mọi chuyện.',
      '"明白过来" chỉ nhận thức từ mơ hồ chuyển sang thông suốt.'
    );

  -- Điểm ngữ pháp #59: Bổ ngữ xu hướng mở rộng rơi vào trạng thái tiêu cực "过去"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng mở rộng rơi vào trạng thái tiêu cực "过去"',
    'Động từ (晕 / 昏) + 过去',
    'Bổ ngữ',
    '"过去" (guòqu) làm bổ ngữ xu hướng mở rộng biểu thị sự chuyển biến sang một trạng thái bất tỉnh, tiêu cực hoặc mất đi ý thức (ngất xỉu đi: 晕过去, bất tỉnh nhân sự: 昏过去). Đối lập với "过来".',
    'HSK 3',
    59,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '连续在烈日下高强度站岗执勤数小时，这名年轻的士兵险些中暑晕过去了。',
      'Liánxù zài lièrì xià gāo qiángdù zhàngǎng zhíqín shù xiǎoshí, zhè míng niánqīng de shìbīng xiǎnxiē zhòngshǔ yūn guòqu le.',
      'Liên tục đứng gác làm nhiệm vụ cường độ cao dưới nắng gắt nhiều giờ, người binh sĩ trẻ tuổi này suýt nữa say nắng ngất xỉu đi.',
      '"晕过去" miêu tả trạng thái mất tri giác do say nắng.'
    ),
    (
      v_gp_id,
      '他得知突如其来的噩耗后悲痛欲绝，几乎一下子昏倒过去了。',
      'Tā dézhī tūrúqílái de èhào hòu bēitòng-yùjué, jīhū yíxiàzi hūndǎo guòqu le.',
      'Anh ấy sau khi hay tin dữ bất ngờ ập đến đau đớn tột cùng, suýt chút nữa ngất lịm đi.',
      '"昏倒过去" biểu thị ngã ngất đi vì nỗi đau quá lớn.'
    );

  -- Điểm ngữ pháp #60: Bổ ngữ xu hướng mở rộng hiển lộ sáng tỏ "出来"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ xu hướng mở rộng hiển lộ sáng tỏ "出来"',
    'Động từ (看 / 听 / 想 / 认 / 查) + 出来 (+ Tân ngữ)',
    'Bổ ngữ',
    '"出来" (chūlai) làm bổ ngữ xu hướng mở rộng biểu thị thông qua động tác phân tích, nhận biết mà làm cho một sự thật ẩn giấu, một ý tưởng hoặc thông tin được hiển lộ ra rõ ràng trước mắt (nhận ra: 认出来, nghe ra: 听出来, nhìn ra: 看出来, nghĩ ra cách: 想出来).',
    'HSK 3',
    60,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '虽然二十多年未曾谋面，但老同学相聚时他还是一眼就把我认出来了。',
      'Suīrán èrshí duō nián wèicéng móumiàn, dàn lǎo tóngxué xiāngjù shí tā háishì yì yǎn jiù bǎ wǒ rèn chūlai le.',
      'Mặc dù hơn hai mươi năm chưa từng gặp mặt, nhưng lúc bạn học cũ hội ngộ anh ấy vẫn vừa liếc mắt đã nhận ra tôi ngay.',
      '"认出来了" biểu thị nhận diện rõ danh tính người bạn cũ.'
    ),
    (
      v_gp_id,
      '经过整整一个下午的集思广益，研发小组终于想出来了一个绝妙的解决方案。',
      'Jīngguò zhěngzhěng yí gè xiàwǔ de jísī-guǎngyì, yánfā xiǎozǔ zhōngyú xiǎng chūlai le yí gè juémiào de jiějué fāng''àn.',
      'Trải qua trọn vẹn một buổi chiều tập hợp trí tuệ chung, tổ nghiên cứu phát triển cuối cùng đã nghĩ ra được một phương án giải quyết tuyệt diệu.',
      '"想出来" biểu thị ý tưởng giải pháp mới được hình thành.'
    );

  -- Điểm ngữ pháp #61: Bổ ngữ khả năng hoàn tất kết thúc "V + 得 / 不 + 了 (liǎo)"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ khả năng hoàn tất kết thúc "V + 得 / 不 + 了 (liǎo)"',
    'Động từ + 得 / 不 + 了 (liǎo) (+ Tân ngữ)',
    'Bổ ngữ',
    '"得了 / 不了" (de liǎo / bù liǎo) là bổ ngữ khả năng biểu thị hành động có khả năng tiến hành hoặc hoàn thành hay không (làm được/không nổi, đi được/không thể đi). Thường do điều kiện khách quan quyết định.',
    'HSK 3',
    61,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这盘红烧羊肉分量实在太大了，我一个人无论如何也吃不了。',
      'Zhè pán hóngshāo yángròu fènliàng shízài tài dà le, wǒ yí gè rén wúlùn-rúhé yě chī bu liǎo.',
      'Đĩa thịt cừu kho này khẩu phần thực sự quá nhiều rồi, một mình tôi bất luận thế nào cũng không thể ăn hết nổi.',
      '"吃不了" biểu thị sức ăn một mình không kham nổi số lượng thịt nhiều.'
    ),
    (
      v_gp_id,
      '今天晚上我有重要的国际学术会议要参加，恐怕去不了你的生日聚会了。',
      'Jīntiān wǎnshang wǒ yǒu zhòngyào de guójì xuéshù huìyì yào cānjiā, kǒngpà qù bu liǎo nǐ de shēngrì jùhuì le.',
      'Tối hôm nay tôi có cuộc họp học thuật quốc tế quan trọng phải tham dự, e rằng không thể đi tham gia buổi tiệc sinh nhật của bạn được rồi.',
      '"去不了" chỉ việc không thể tham gia do bị vướng lịch họp.'
    );

  -- Điểm ngữ pháp #62: Bổ ngữ khả năng thể lực vận động "V + 得 / 不 + 动"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ khả năng thể lực vận động "V + 得 / 不 + 动"',
    'Động từ + 得 / 不 + 动 (走 / 跑 / 搬 / 爬)',
    'Bổ ngữ',
    '"得动 / 不动" (de dòng / bu dòng) biểu thị về mặt thể lực, sức lực của con người có đủ khả năng làm cho thân thể hoặc vật thể chuyển dịch, vận động hay không (nhấc nổi/không nổi, đi nổi/không nổi).',
    'HSK 3',
    62,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '连续徒步跋涉了五个小时的山路，大家都累得气喘吁吁、走不动了。',
      'Liánxù túbù báshè le wǔ gè xiǎoshí de shānlù, dàjiā dōu lèi de qìchuǎn-xūxū, zǒu bu dòng le.',
      'Liên tục cuốc bộ vượt đường núi suốt năm tiếng đồng hồ, mọi người đều mệt tới thở hồng hộc, không thể bước nổi nữa rồi.',
      '"走不动了" miêu tả thể lực cạn kiệt không thể nhấc chân đi tiếp.'
    ),
    (
      v_gp_id,
      '这个装满厚重历史图书的大纸箱太沉了，我一个人根本搬不动。',
      'Zhè gè zhuāng mǎn hòuzhòng lìshǐ túshū de dà zhǐxiāng tài chén le, wǒ yí gè rén gēnběn bān bu dòng.',
      'Chiếc thùng carton lớn đựng đầy sách lịch sử nặng trịch này nặng quá, một mình tôi căn bản không bê nổi.',
      '"搬不动" biểu thị sức nặng của thùng sách vượt quá sức người.'
    );

  -- Điểm ngữ pháp #63: Bổ ngữ khả năng dung lượng sức chứa "V + 得 / 不 + 下"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ khả năng dung lượng sức chứa "V + 得 / 不 + 下"',
    'Động từ (坐 / 住 / 站 / 装 / 放) + 得 / 不 + 下 (+ Tân ngữ)',
    'Bổ ngữ',
    '"得下 / 不下" (de xià / bu xià) biểu thị không gian, diện tích hoặc sức chứa có thể dung nạp, chứa đựng được số lượng người hoặc vật thể đó hay không (ngồi vừa/không vừa, chứa hết/không hết, để vừa/không vừa).',
    'HSK 3',
    63,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这间小型阶梯自习室空间有限，最多只能坐得下五十位学生。',
      'Zhè jiān xiǎoxíng jiētī zìxíshì kōngjiān yǒuxiàn, zuìduō zhǐ néng zuò de xià wǔshí wèi xuésheng.',
      'Phòng tự học bậc thang cỡ nhỏ này không gian có hạn, tối đa chỉ có thể ngồi vừa năm mươi học sinh.',
      '"坐得下" khẳng định sức chứa tối đa của phòng học.'
    ),
    (
      v_gp_id,
      '你的旅行箱已经塞得太满了，这本大字典无论如何也装不下了。',
      'Nǐ de lǚxíngxiāng yǐjīng sāi de tài mǎn le, zhè běn dà zìdiǎn wúlùn-rúhé yě zhuāng bu xià le.',
      'Vali du lịch của bạn đã nhét quá chật rồi, cuốn đại tự điển này bất luận thế nào cũng không thể nhét vừa nữa rồi.',
      '"装不下" biểu thị dung lượng vali không còn chỗ chứa.'
    );

  -- Điểm ngữ pháp #64: Bổ ngữ khả năng giác quan tri giác "V + 得 / 不 + 见 / 懂"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ khả năng giác quan tri giác "V + 得 / 不 + 见 / 懂"',
    '看 / 听 + 得 / 不 + 见 / 懂',
    'Bổ ngữ',
    'Biểu thị năng lực của mắt, tai có thể nhìn thấy, nghe thấy hoặc hiểu được nội dung hay không (nhìn thấy được/không thấy: 看得见 / 看不见; nghe hiểu/không hiểu: 听得懂 / 听不懂).',
    'HSK 3',
    64,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '报告厅的音响设备非常清晰，即使坐在最后一排也能听得见发言。',
      'Bàogàotīng de yīnxiǎng shèbèi fēicháng qīngxī, jíshǐ zuò zài zuìhòu yì pái yě néng tīng de jiàn fāyán.',
      'Thiết bị âm thanh của phòng báo cáo rất rõ ràng, cho dù ngồi ở hàng ghế cuối cùng cũng có thể nghe thấy bài phát biểu.',
      '"听得见" khẳng định năng lực nghe rõ âm thanh từ xa.'
    ),
    (
      v_gp_id,
      '这位外国学者发言语速非常平缓标准，初学汉语的学生也能听得懂。',
      'Zhè wèi wàiguó xuézhě fāyán yǔsù fēicháng pínghuǎn biāozhǔn, chūxué hànyǔ de xuésheng yě néng tīng de dǒng.',
      'Học giả nước ngoài này phát biểu tốc độ nói rất thong thả chuẩn mực, học sinh mới học tiếng Hán cũng có thể nghe hiểu được.',
      '"听得懂" biểu thị khả năng tiếp nhận và hiểu nghĩa nội dung.'
    );

  -- Điểm ngữ pháp #65: Bổ ngữ khả năng đạt tới mục tiêu "V + 得 / 不 + 着 (zháo)"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Bổ ngữ khả năng đạt tới mục tiêu "V + 得 / 不 + 着 (zháo)"',
    'Động từ (睡 / 找 / 买 / 碰) + 得 / 不 + 着 (zháo)',
    'Bổ ngữ',
    '"得着 / 不着" (de zháo / bu zháo) biểu thị khả năng có đạt được kết quả mong đợi hay không (ngủ được/không ngủ được: 睡得着 / 睡不着; tìm thấy/không thấy: 找得着 / 找不着; với tới: 碰得着).',
    'HSK 3',
    65,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '明天就要公布全国研究生录取结果了，他昨晚兴奋得整夜睡不着觉。',
      'Míngtiān jiù yào gōngbù quánguó yánjiūshēng lùqǔ jiéguǒ le, tā zuówǎn xīngfèn de zhěng yè shuì bu zháo jiào.',
      'Ngày mai là công bố kết quả tuyển sinh nghiên cứu sinh toàn quốc rồi, tối qua anh ấy hưng phấn đến mức thức trắng đêm không ngủ được.',
      '"睡不着觉" biểu thị không thể đi vào giấc ngủ do tâm trạng bồi hồi.'
    ),
    (
      v_gp_id,
      '书架顶部那本珍贵的精装画册放得太高了，他踮起脚尖也够不着。',
      'Shūjià dǐngbù nà běn zhēnguì de jīngzhuāng huàcè fàng de tài gāo le, tā diǎn qǐ jiǎojiān yě gòu bu zháo.',
      'Cuốn tập tranh bìa cứng quý giá ở đỉnh giá sách để cao quá, anh ấy kiễng cả mũi chân cũng không với tới được.',
      '"够不着" biểu thị không thể chạm tới do khoảng cách quá cao.'
    );

  -- Điểm ngữ pháp #66: Câu chữ 把 mang bổ ngữ kết quả (把字句带结果补语)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 mang bổ ngữ kết quả (把字句带结果补语)',
    'Chủ ngữ + 把 + Tân ngữ + Động từ + Bổ ngữ kết quả (好 / 完 / 错 / 净)',
    'Cấu trúc câu',
    'Trong câu chữ 把 trung cấp, động từ thường mang bổ ngữ kết quả để làm rõ mức độ xử lý hoàn tất hoặc tình trạng mới của tân ngữ sau tác động (làm xong: 做完, chuẩn bị tốt: 准备好, lau sạch: 擦干净).',
    'HSK 3',
    66,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '请同学们在离开实验室之前，务必把桌面上的仪器设备收拾干净。',
      'Qǐng tóngxué men zài líkāi shíyànshì zhīqián, wùbì bǎ zhuōmiàn shang de yíqì shèbèi shōushi gānjìng.',
      'Xin mời các bạn học sinh trước khi rời phòng thí nghiệm, nhất định phải thu dọn sạch sẽ các trang thiết bị trên mặt bàn.',
      '"把...收拾干净" xử lý đối tượng thiết bị tới trạng thái sạch tinh tươm.'
    ),
    (
      v_gp_id,
      '他花了一整天的时间，终于把那篇长达一万字的研究报告写完了。',
      'Tā huā le yì zhěng tiān de shíjiān, zhōngyú bǎ nà piān chángdá yí wàn zì de yánjiū bàogào xiě wán le.',
      'Anh ấy đã bỏ ra trọn vẹn một ngày, cuối cùng đã viết xong bản báo cáo nghiên cứu dài một vạn chữ đó rồi.',
      '"把...写完了" biểu thị bài báo cáo đã hoàn thành trọn vẹn.'
    );

  -- Điểm ngữ pháp #67: Câu chữ 把 mang bổ ngữ xu hướng (把字句带趋向补语)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu chữ 把 mang bổ ngữ xu hướng (把字句带趋向补语)',
    'Chủ ngữ + 把 + Tân ngữ + Động từ + Bổ ngữ xu hướng (回来 / 进去 / 拿出来)',
    'Cấu trúc câu',
    'Câu chữ 把 kết hợp với bổ ngữ xu hướng (nhất là xu hướng kép) để miêu tả hành động dịch chuyển vật thể từ không gian này sang không gian khác hoặc theo một phương hướng nhất định đối với người nói.',
    'HSK 3',
    67,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他小心翼翼地从书包里把那幅珍贵的古代水墨山水画拿了出来。',
      'Tā xiǎoxīn-yìyì de cóng shūbāo lǐ bǎ nà fú zhēnguì de gǔdài shuǐmò shānshuǐhuà ná le chūlai.',
      'Anh ấy cẩn thận từng li từng tí từ trong cặp sách lấy bức tranh sơn thủy thủy mặc cổ đại quý giá đó ra ngoài.',
      '"把...拿了出来" làm dịch chuyển bức tranh từ trong cặp ra ngoài tầm mắt.'
    ),
    (
      v_gp_id,
      '天气突然变冷了，妈妈赶紧把晾晒在阳台上的厚棉被收了进来。',
      'Tiānqì tūrán biàn lěng le, māma gǎnjǐn bǎ liàngshài zài yángtái shang de hòu miánbèi shōu le jìnlái.',
      'Thời tiết đột nhiên chuyển lạnh, người mẹ vội vàng thu chiếc chăn bông dày phơi trên ban công vào trong nhà.',
      '"把...收了进来" mang chiếc chăn phơi vào trong nhà.'
    );

  -- Điểm ngữ pháp #68: Câu bị động tiêu chuẩn với giới từ "被" (被字句标准结构)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu bị động tiêu chuẩn với giới từ "被" (被字句标准结构)',
    'Chủ ngữ (Người/vật bị tác động) + 被 (+ Tác nhân) + Động từ + Thành phần khác',
    'Cấu trúc câu',
    'Câu chữ "被" (bèi) là câu bị động tiêu chuẩn trong tiếng Hán, dùng để nhấn mạnh chủ ngữ tiếp nhận hoặc gánh chịu một hành động tác động từ bên ngoài (thường là sự việc không mong muốn hoặc có tính chất thay đổi lớn). Động từ bắt buộc phải có thành phần đi kèm phía sau (như 了, bổ ngữ).',
    'HSK 3',
    68,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '那辆停放在路边无障碍通道上的违章轿车，被交通警察依法拖走了。',
      'Nà liàng tíngfàng zài lùbiān wúzhàng''ài tōngdào shang de wéizhāng jiàochē, bèi jiāotōng jǐngchá yīfǎ tuō zǒu le.',
      'Chiếc xe ô tô con vi phạm đỗ trên lối đi không rào cản ven đường đó đã bị cảnh sát giao thông cẩu đi theo đúng luật.',
      '"被交通警察...拖走了" cấu trúc bị động chỉ chiếc xe bị cẩu đi.'
    ),
    (
      v_gp_id,
      '昨夜狂风大作，门前花园里几株盛开的红月季被大风吹落了花瓣。',
      'Zuóyè kuángfēng-dàzuò, ménqián huāyuán lǐ jǐ zhū shèngkāi de hóng yuèjì bèi dàfēng chuī luò le huābàn.',
      'Đêm qua gió lốc thét gào, mấy khóm hoa nguyệt quý đỏ nở rộ trong vườn hoa trước cửa đã bị cơn gió lớn thổi rụng cánh hoa.',
      '"被大风吹落" miêu tả cánh hoa bị gió thổi rụng.'
    );

  -- Điểm ngữ pháp #69: Câu bị động khẩu ngữ với "叫 / 让" (叫/让字被动句)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu bị động khẩu ngữ với "叫 / 让" (叫/让字被动句)',
    'Chủ ngữ + 叫 / 让 + Tác nhân bắt buộc + Động từ + Thành phần khác',
    'Cấu trúc câu',
    'Trong khẩu ngữ sinh hoạt hàng ngày, người ta thường dùng "叫" (jiào) hoặc "让" (ràng) thay cho "被" để diễn đạt ý bị động. Chú ý điểm ngữ pháp cực kỳ quan trọng: Trong câu bị động chữ "叫 / 让", TÁC NHÂN BẮT BUỘC PHẢI XUẤT HIỆN, không được lược bỏ như trong câu chữ "被".',
    'HSK 3',
    69,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '桌上刚刚倒满的那杯香浓热牛奶，不小心让他给打翻了。',
      'Zhuō shang gānggāng dào mǎn de nà bēi xiāngnóng rè niúnǎi, bù xiǎoxīn ràng tā gěi dǎfān le.',
      'Cốc sữa bò nóng thơm lừng vừa mới rót đầy trên bàn, chẳng may đã bị anh ấy làm hắt đổ rồi.',
      '"让他给打翻了" cấu trúc bị động khẩu ngữ với tác nhân bắt buộc "他".'
    ),
    (
      v_gp_id,
      '放在阳台上晒干的新鲜草莓干，不知道叫谁偷偷吃掉了一半。',
      'Fàng zài yángtái shang shàigān de xīnxiān cǎoméi gān, bù zhīdào jiào shéi tōutōu chī diào le yíbàn.',
      'Món mứt dâu tây tươi phơi khô để ở ban công, không biết bị ai lén ăn mất một nửa rồi.',
      '"叫谁...吃掉了" cấu trúc bị động khẩu ngữ dùng chữ "叫".'
    );

  -- Điểm ngữ pháp #70: Câu kiêm ngữ sai khiến yêu cầu "让 / 叫 / 请" (兼语句)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu kiêm ngữ sai khiến yêu cầu "让 / 叫 / 请" (兼语句)',
    'Chủ ngữ + 让 / 叫 / 请 + Tân ngữ 1 (kiêm chủ ngữ 2) + Động từ 2 (+ Tân ngữ 2)',
    'Cấu trúc câu',
    'Câu kiêm ngữ có thành phần đứng giữa vừa làm tân ngữ cho động từ thứ nhất (让, 叫, 请), vừa làm chủ ngữ cho động từ thứ hai (bảo ai làm gì, mời ai làm gì).',
    'HSK 3',
    70,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '系主任请张教授下周在学术报告厅为全院师生做一场专题讲座。',
      'Xì zhǔrèn qǐng Zhāng jiàoshòu xià zhōu zài xuéshù bàogàotīng wèi quán yuàn shīshēng zuò yì chǎng zhuāntí jiǎngzuò.',
      'Chủ nhiệm khoa mời giáo sư Trương tuần sau tại phòng báo cáo học thuật thuyết trình một bài giảng chuyên đề cho toàn thể thầy trò trong viện.',
      '"张教授" vừa là tân ngữ của "请", vừa là chủ ngữ của hành động "做讲座".'
    ),
    (
      v_gp_id,
      '医生叮嘱病人一定要按时服药，并叫家属多陪老人散步散心。',
      'Yīshēng dīngzhǔ bìngrén yídìng yào ànshí fúyào, bìng jiào jiāshǔ duō péi lǎorén sànbù sànxīn.',
      'Bác sĩ dặn dò người bệnh nhất định phải uống thuốc đúng giờ, đồng thời bảo người nhà bồi bạn cùng người già đi dạo thư giãn.',
      '"叫家属多陪" kiêm ngữ chỉ đối tượng người nhà được dặn dò.'
    );

  -- Điểm ngữ pháp #71: Câu kiêm ngữ nguyên nhân kết quả với "使" (Khiến cho / Làm cho)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Câu kiêm ngữ nguyên nhân kết quả với "使" (Khiến cho / Làm cho)',
    'Nguyên nhân / Sự việc + 使 + Đối tượng kiêm ngữ + Động từ / Tính từ',
    'Cấu trúc câu',
    '"使" (shǐ) thường dùng trong văn viết hoặc văn cảnh trang trọng để biểu thị sự việc, hành động thứ nhất làm nảy sinh kết quả, biến đổi tâm trạng hoặc tình thái ở đối tượng tiếp theo (khiến cho, làm cho).',
    'HSK 3',
    71,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '科技创新成果的快速普及应用，使广大人民的生活变得更加便利舒适。',
      'Kējì chuàngxīn chéngguǒ de kuàisù pǔjí yìngyòng, shǐ guǎngdà rénmín de shēnghuó biàn de gèngjiā biànlì shūshì.',
      'Việc phổ cập ứng dụng nhanh chóng các thành quả đổi mới khoa học công nghệ đã khiến cho đời sống của đông đảo nhân dân trở nên tiện lợi thoải mái hơn nhiều.',
      '"使...变得更加便利" biểu thị thành quả công nghệ đem lại sự biến đổi tốt đẹp cho đời sống.'
    ),
    (
      v_gp_id,
      '老同学久别重逢的感人场面，使在场的每一个人都流下了激动的泪水。',
      'Lǎo tóngxué jiǔbié-chóngféng de gǎnrén chǎngmiàn, shǐ zàichǎng de měi yí gè rén dōu liú xià le jīdòng de lèishuǐ.',
      'Cảnh tượng cảm động hội ngộ sau bao năm xa cách của bạn học cũ đã làm cho mỗi người có mặt đều rơi những giọt nước mắt xúc động.',
      '"使在场的每一个人...流下泪水" kiêm ngữ chỉ cảm xúc dâng trào do buổi tao ngộ đem lại.'
    );

  -- Điểm ngữ pháp #72: Cấu trúc so sánh kém "A 不如 B (+ Tính từ)" (A không bằng B)
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc so sánh kém "A 不如 B (+ Tính từ)" (A không bằng B)',
    'Chủ ngữ A + 不如 + Chủ ngữ B (+ Tính từ / Động từ)',
    'Cấu trúc so sánh',
    'Cấu trúc "A 不如 B" (A bùrú B) dùng để biểu thị đối tượng A không bằng, kém hơn đối tượng B về một phương diện nào đó (A không bằng B, chi bằng). Thường dùng trong cả văn viết lẫn văn nói.',
    'HSK 3',
    72,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '看别人的书面文字转述，不如亲自走到实地深入考察来得真切深刻。',
      'Kàn biérén de shūmiàn wénzì zhuǎnshù, bùrú qīnzì zǒu dào shídì shēnrù kǎochá lái de zhēnqiè shēnkè.',
      'Xem bản diễn giải chữ nghĩa của người khác không bằng đích thân đi đến thực địa khảo sát sâu sắc chân thực.',
      '"不如亲自..." so sánh việc tự mình đi trải nghiệm tốt hơn việc chỉ đọc sách.'
    ),
    (
      v_gp_id,
      '这家超市普通苹果的口感不如北方果园直供的新鲜红富士甜脆。',
      'Zhè jiā chāoshì pǔtōng píngguǒ de kǒugǎn bùrú běifāng guǒyuán zhígōng de xīnxiān hóngfùshì tián cuì.',
      'Hương vị của táo thông thường ở siêu thị này không bằng độ giòn ngọt của táo Phú Sĩ đỏ tươi cung cấp trực tiếp từ vườn cây ăn quả phương Bắc.',
      '"不如...甜脆" so sánh hương vị không ngon bằng.'
    );

  -- Điểm ngữ pháp #73: Cấu trúc tăng tiến biến đổi theo thời gian "越来越 + Tính từ / Động từ"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc tăng tiến biến đổi theo thời gian "越来越 + Tính từ / Động từ"',
    'Chủ ngữ + 越来越 + Tính từ / Động từ tâm lý (+ 了)',
    'Cấu trúc câu',
    '"越来越..." (yuè lái yuè...) biểu thị mức độ của tính chất, trạng thái hoặc cảm xúc không ngừng gia tăng, phát triển theo bước tiến của thời gian (càng ngày càng..., ngày một... hơn). Không được dùng kèm các phó từ mức độ như 很, 非常.',
    'HSK 3',
    73,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '随着与中国朋友交流日渐密切，他的汉语口语表达越来越流利地道了。',
      'Suízhe yǔ zhōngguó péngyou jiāoliú rìjiàn mìqiè, tā de hànyǔ kǒuyǔ biǎodá yuè lái yuè liúlì dìdào le.',
      'Cùng với việc giao lưu với bạn bè Trung Quốc ngày càng gắn bó, biểu đạt khẩu ngữ tiếng Hán của anh ấy càng ngày càng lưu loát chuẩn vị rồi.',
      '"越来越流利" chỉ trình độ lưu loát tăng dần theo ngày tháng.'
    ),
    (
      v_gp_id,
      '立冬过后白昼变短，北方大地的天气变得越来越寒冷严酷了。',
      'Lìdōng guòhòu báizhòu biàn duǎn, běifāng dàdì de tiānqì biàn de yuè lái yuè hánlěng yánkù le.',
      'Sau tiết Lập đông ban ngày ngắn lại, thời tiết đất trời phương Bắc trở nên càng ngày càng giá buốt khắc nghiệt.',
      '"越来越寒冷" miêu tả độ lạnh ngày một gia tăng.'
    );

  -- Điểm ngữ pháp #74: Cấu trúc so sánh theo chu kỳ đối chiếu "一年比一年... / 一天比一天..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc so sánh theo chu kỳ đối chiếu "一年比一年... / 一天比一天..."',
    'Số từ + Lượng từ + 比 + Số từ + Lượng từ + Tính từ / Vị ngữ',
    'Cấu trúc so sánh',
    'Cấu trúc "Lượng từ + 比 + Lượng từ + Tính từ" (như: 一天比一天: từng ngày từng ngày một, 一年比一年: từng năm từng năm một) dùng để nhấn mạnh sự thay đổi, tiến triển liên tục theo từng chu kỳ thời gian đều đặn.',
    'HSK 3',
    74,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '在国家乡村振兴政策的大力支持下，山村百姓的生活一年比一年富裕幸福。',
      'Zài guójiā xiāngcūn zhènxīng zhèngcè de dàlì zhīchí xià, shāncūn bǎixìng de shēnghuó yì nián bǐ yì nián fùyù xìngfú.',
      'Dưới sự hỗ trợ đắc lực của chính sách chấn hưng nông thôn quốc gia, đời sống của người dân làng núi mỗi năm một thêm giàu có hạnh phúc.',
      '"一年比一年富裕" nhấn mạnh sự khấm khá tăng trưởng qua từng năm.'
    ),
    (
      v_gp_id,
      '春回大地万物复苏，公园池塘里的春水一天比一天清澈温暖。',
      'Chūnhuí-dàdì wànwù fùsū, gōngyuán chítáng lǐ de chūnshuǐ yì tiān bǐ yì tiān qīngchè wēnnuǎn.',
      'Xuân về trên đất mẹ muôn vật hồi sinh, dòng nước xuân trong ao đầm công viên mỗi ngày một trong veo ấm áp hơn.',
      '"一天比一天清澈" miêu tả sự biến đổi rõ rệt qua từng ngày.'
    );

  -- Điểm ngữ pháp #75: Cấu trúc loại trừ toàn bộ "除了...以外, (都...)"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc loại trừ toàn bộ "除了...以外, (都...)"',
    '除了 + Đối tượng loại trừ + (以外), 主语 + 都 + Vị ngữ',
    'Cấu trúc câu',
    'Cấu trúc "除了...以外, 都..." (chúle... yǐwài, dōu...) biểu thị sự loại trừ: trừ một hoặc một số đối tượng cá biệt đứng sau "除了", tất cả các đối tượng còn lại đều có cùng một đặc điểm hoặc hành động không ngoại lệ (ngoài... ra, tất cả đều...).',
    'HSK 3',
    75,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '除了最后一道高难度的附加思考题以外，试卷上的其他题目他都做对了。',
      'Chúle zuìhòu yí dào gāonándù de fùjiā sīkǎotí yǐwài, shìjuàn shang de qítā tímù tā dōu zuò duì le.',
      'Ngoại trừ bài toán suy ngẫm phụ thêm độ khó cao cuối cùng ra, các bài khác trên đề thi anh ấy đều làm đúng hết.',
      '"除了...以外, 都做对了" loại trừ 1 câu khó, còn lại đều làm đúng.'
    ),
    (
      v_gp_id,
      '除了周末定期闭馆维护以外，市立博物馆每天上午九点准时向公众免费开放。',
      'Chúle zhōumò dìngqī bìguǎn wéihù yǐwài, shìlì bówùguǎn měitiān shàngwǔ jiǔ diǎn zhǔnshí xiàng gōngzhòng miǎnfèi kāifàng.',
      'Ngoại trừ dịp cuối tuần định kỳ đóng cửa bảo trì ra, bảo tàng thành phố mỗi sáng chín giờ đều mở cửa miễn phí đúng giờ đón công chúng.',
      'Loại trừ ngày bảo trì, còn lại các ngày đều mở cửa.'
    );

  -- Điểm ngữ pháp #76: Cấu trúc bổ sung tiếp tục "除了...以外, (还 / 也...)"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc bổ sung tiếp tục "除了...以外, (还 / 也...)"',
    '除了 + Đối tượng nền tảng + (以外), 主语 + 还 / 也 + Vị ngữ bổ sung',
    'Cấu trúc câu',
    'Khác với cấu trúc loại trừ đi với "都", khi "除了...以外" kết hợp với "还" hoặc "也" thì nó mang ý nghĩa bao gồm và bổ sung thêm: ngoài đối tượng A đã có sẵn, chủ thể còn có thêm hoặc làm thêm cả đối tượng B nữa (ngoài... ra, còn có/cũng...).',
    'HSK 3',
    76,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '他在大学除了认真攻读计算机专业课程以外，还自学了法语和西班牙语。',
      'Tā zài dàxué chúle rènzhēn gōngdú jìsuànjī zhuānyè kèchéng yǐwài, hái zìxué le fǎyǔ hé xībānyáyǔ.',
      'Ở trường đại học ngoài việc chăm chỉ dùi mài các học phần chuyên ngành máy tính ra, anh ấy còn tự học cả tiếng Pháp và tiếng Tây Ban Nha.',
      '"除了...以外, 还自学..." biểu thị việc tự học thêm ngoại ngữ bên cạnh ngành chính.'
    ),
    (
      v_gp_id,
      '这间多功能体育活动中心除了配备室内羽毛球场以外，还有一座恒温游泳馆。',
      'Zhè jiān duō gōngnéng tǐyù huódòng zhōngxīn chúle pèibèi shìnèi yǔmáoqiú chǎng yǐwài, hái yǒu yí zuò héngwēn yóuyǒngguǎn.',
      'Trung tâm hoạt động thể dục thể thao đa năng này ngoài việc trang bị sân cầu lông trong nhà ra, còn có cả một nhà bể bơi nhiệt độ không đổi.',
      'Bổ sung thêm tiện ích bể bơi bên cạnh sân cầu lông.'
    );

  -- Điểm ngữ pháp #77: Cấu trúc nhấn mạnh trường hợp cực đoan "连...都 / 也..."
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc nhấn mạnh trường hợp cực đoan "连...都 / 也..."',
    '连 + Đối tượng cực đoan / Tối thiểu + 都 / 也 + Vị ngữ',
    'Cấu trúc câu',
    'Cấu trúc "连...都 / 也..." (lián... dōu/yě...) dùng để đưa ra một trường hợp cực đoan nhất hoặc một điều kiện tối thiểu nhất làm đòn bẩy nhằm nhấn mạnh toàn bộ các trường hợp thông thường khác đương nhiên cũng như vậy (ngay cả... cũng, đến cả... đều).',
    'HSK 3',
    77,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '这道题目的解题步骤极其简单明了，连刚上学的小朋友都能轻松看懂。',
      'Zhè dào tímù de jiětí bùzhòu jíqí jiǎndān míngliǎo, lián gāng shàngxué de xiǎopéngyou dōu néng qīngsōng kàn dǒng.',
      'Các bước giải của bài toán này cực kỳ đơn giản dễ hiểu, ngay cả em nhỏ vừa mới đi học cũng đều có thể dễ dàng xem hiểu.',
      '"连刚上学的小朋友都..." đưa ra em nhỏ làm đối tượng tối thiểu để nhấn mạnh bài toán rất dễ.'
    ),
    (
      v_gp_id,
      '他今天从早到晚连续做了好几场复杂的大手术，累得连晚饭都顾不上吃。',
      'Tā jīntiān cóng zǎo dào wǎn liánxù zuò le hǎo jǐ chǎng fùzá de dà shǒushù, lèi de lián wǎnfàn dōu gù bu shàng chī.',
      'Hôm nay từ sáng đến tối anh ấy liên tục làm mấy ca đại phẫu phức tạp, mệt tới mức ngay cả cơm tối cũng không màng ăn nổi.',
      '"连晚饭都顾不上吃" nhấn mạnh sự bận rộn vất vả cực độ.'
    );

  -- Điểm ngữ pháp #78: Đại từ nghi vấn phiếm chỉ toàn bộ "Ai / Cái gì / Ở đâu + 都 / 也 + Vị ngữ"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Đại từ nghi vấn phiếm chỉ toàn bộ "Ai / Cái gì / Ở đâu + 都 / 也 + Vị ngữ"',
    '谁 / 什么 / 哪里 / 怎么 + 都 / 也 + Vị ngữ',
    'Đại từ',
    'Khi các đại từ nghi vấn (谁: ai, 什么: cái gì, 哪儿/哪里: ở đâu, 怎么: thế nào) đi cùng phó từ "都" hoặc "也" trong câu khẳng định hoặc phủ định, chúng mất đi chức năng hỏi mà trở thành đại từ phiếm chỉ biểu thị tính toàn thể hoặc phủ định sạch trơn (ai cũng, cái gì cũng không, đi đâu cũng...).',
    'HSK 3',
    78,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '李老师为人谦逊和蔼、知识渊博，全校谁都很尊敬他、爱戴他。',
      'Lǐ lǎoshī wéirén qiānxùn hé''ǎi, zhīshi yuānbó, quán xiào shéi dōu hěn zūnjìng tā, àidài tā.',
      'Thầy Lý đối nhân xử thế khiêm tốn hòa nhã, tri thức uyên bác, toàn trường ai ai cũng đều rất tôn kính và yêu mến thầy.',
      '"谁都很尊敬" biểu thị tất cả mọi người trong trường không trừ một ai.'
    ),
    (
      v_gp_id,
      '在异国他乡初来乍到，他人生地不熟，哪里也没有去过。',
      'Zài yìguó-tāxiāng chūlái-zhàodào, tā rénshēng-dìbùshú, nǎlǐ yě méiyǒu qù guo.',
      'Mới chân ướt chân ráo đến nơi đất khách quê người, anh ấy người lạ nước lạ, ở đâu cũng đều chưa từng đi qua.',
      '"哪里也没有去过" phủ định toàn bộ các địa điểm.'
    );

  -- Điểm ngữ pháp #79: Cấu trúc bổ ngữ trạng thái kép nhấn mạnh kết quả "Động từ + 得 + Tân ngữ + Vị ngữ"
  INSERT INTO public.grammar_points (
    name, pattern, category, explanation_vi, hsk_level, order_index, source, validation_status
  ) VALUES (
    'Cấu trúc bổ ngữ trạng thái kép nhấn mạnh kết quả "Động từ + 得 + Tân ngữ + Vị ngữ"',
    'Chủ ngữ + Động từ + 得 + Tân ngữ bị ảnh hưởng + Vị ngữ kết quả',
    'Cấu trúc câu',
    'Cấu trúc phức hợp "Động từ + 得 + Tân ngữ + Vị ngữ" là dạng nâng cao của bổ ngữ trạng thái, trong đó thành phần sau "得" là một cụm chủ vị hoàn chỉnh miêu tả mức độ hoặc kết quả mà hành động gây ra cho đối tượng tiếp nhận (làm đến mức mà đối tượng bị như thế nào).',
    'HSK 3',
    79,
    'gf0025_2021',
    'verified'
  ) RETURNING id INTO v_gp_id;

  INSERT INTO public.grammar_examples (
    grammar_point_id, chinese, pinyin, translation_vi, explanation
  ) VALUES
    (
      v_gp_id,
      '晚会上相声演员幽默风趣的精彩表演，逗得全场观众捧腹大笑、眼泪直流。',
      'Wǎnhuì shang xiàngsheng yǎnyuán yōumò fēngqù de jīngcǎi biǎoyǎn, dòu de quánchǎng guānzhòng pěngfù-dàxiào, yǎnlèi zhí liú.',
      'Màn biểu diễn đặc sắc dí dỏm hài hước của diễn viên tướng thanh trong đêm tiệc đã chọc cho toàn thể khán giả cười nghiêng ngả ôm bụng, nước mắt trào ra.',
      '"逗得全场观众捧腹大笑" miêu tả kết quả khán giả cười nghiêng ngả do sự hài hước gây nên.'
    ),
    (
      v_gp_id,
      '经过连续几个小时烈日下的高强度长跑训练，累得队员们双腿发软直不起腰来。',
      'Jīngguò liánxù jǐ gè xiǎoshí lièrì xià de gāo qiángdù chángpǎo xùnliàn, lèi de duìyuán men shuāngtuǐ fāruǎn zhí bu qǐ yāo lái.',
      'Trải qua nhiều giờ tập luyện chạy dài cường độ cao liên tục dưới nắng gắt, mệt đến mức hai chân các đội viên bủn rủn không sao đứng thẳng lưng lên nổi.',
      '"累得队员们双腿发软" làm rõ trạng thái kiệt sức của các đội viên sau buổi tập.'
    );

END $$;

COMMIT;
