-- Migration for Công xưởng Curriculum (With Examples)

DELETE FROM public.lessons WHERE hsk_level = 'Công xưởng' AND is_system = true;

INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('27309726-c6f2-4da4-8e56-a3b45d1bc2d9', '面试', 'miànshì', 'phỏng vấn', 'Công xưởng', '请问明天的面试在几号会议室？', 'Qǐngwèn míngtiān de miànshì zài jǐ hào huìyìshì?', 'Xin hỏi buổi phỏng vấn ngày mai diễn ra ở phòng họp số mấy?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('baf8de75-9ba2-4941-b8cb-549f584ec71f', '招聘', 'zhāopìn', 'tuyển dụng', 'Công xưởng', '我们厂正在紧急招聘熟练操作工。', 'Wǒmen chǎng zhèngzài jǐnjí zhāopìn shúliàn cāozuògōng.', 'Xưởng chúng tôi đang tuyển dụng khẩn cấp công nhân thao tác lành nghề.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('acfa1282-6082-4c1e-b674-9001dc14cec4', '简历', 'jiǎnlì', 'sơ yếu lý lịch, CV', 'Công xưởng', '你把简历发到人事部的邮箱了吗？', 'Nǐ bǎ jiǎnlì fā dào rénshìbù de yóuxiāng le ma?', 'Bạn đã gửi CV vào hòm thư của phòng nhân sự chưa?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('50991365-8769-4076-8d00-dd5598e09cb4', '经验', 'jīngyàn', 'kinh nghiệm', 'Công xưởng', '他在电子厂有三年以上的工作经验。', 'Tā zài diànzǐ chǎng yǒu sān nián yǐshàng de gōngzuò jīngyàn.', 'Anh ấy có hơn ba năm kinh nghiệm làm việc tại nhà máy điện tử.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a49621de-a190-494f-844c-d3ae5937edd7', '录用', 'lùyòng', 'tuyển dụng, trúng tuyển', 'Công xưởng', '恭喜你被我们公司正式录用了。', 'Gōngxǐ nǐ bèi wǒmen gōngsī zhèngshì lùyòng le.', 'Chúc mừng bạn đã được công ty chúng tôi chính thức tuyển dụng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1b7e1675-652a-4a2b-83dc-b75622f3a4a0', '试用期', 'shìyòngqī', 'thời gian thử việc', 'Công xưởng', '新员工的试用期通常是两个月。', 'Xīn yuángōng de shìyòngqī tōngcháng shì liǎng ge yuè.', 'Thời gian thử việc của nhân viên mới thông thường là hai tháng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e5f08d3b-bf8c-4dca-9dde-1f379db15575', '劳动合同', 'láodòng hétóng', 'hợp đồng lao động', 'Công xưởng', '入职第一天必须签订劳动合同。', 'Rùzhí dì-yī tiān bìxū qiāndìng láodòng hétóng.', 'Ngày đầu tiên nhận việc bắt buộc phải ký kết hợp đồng lao động.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0ad73bdd-c13f-4fab-8a9d-b61a06a1b3ca', '职位', 'zhíwèi', 'vị trí công việc, chức vụ', 'Công xưởng', '你应聘的是哪个车间的职位？', 'Nǐ yìngpìn de shì nǎge chējiān de zhíwèi?', 'Bạn ứng tuyển vào vị trí của phân xưởng nào?')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('fccccd47-aff5-4f90-b780-2c49f7d51e7c', '工资', 'gōngzī', 'tiền lương', 'Công xưởng', '公司每月十号准时发工资。', 'Gōngsī měi yuè shí hào zhǔnshí fā gōngzī.', 'Công ty phát lương đúng hạn vào ngày mùng 10 hàng tháng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6076f042-5471-4855-a80d-5b32f2eed462', '部门', 'bùmén', 'bộ phận, phòng ban', 'Công xưởng', '每个部门都必须严格执行工厂规章制度。', 'Měi ge bùmén dōu bìxū yángé zhíxíng gōngchǎng guīzhāng zhìdù.', 'Mỗi bộ phận đều phải nghiêm túc thực hiện nội quy nhà máy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('80836c29-120f-4b77-b6b2-eda3120541cf', '人事部', 'rénshìbù', 'phòng nhân sự', 'Công xưởng', '请去人事部领取你的工作证。', 'Qǐng qù rénshìbù lǐngqǔ nǐ de gōngzuòzhèng.', 'Vui lòng đến phòng nhân sự để nhận thẻ nhân viên của bạn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5df62c88-81d5-49dd-9c80-d18291f21155', '离职', 'lízhi', 'nghỉ việc, thôi việc', 'Công xưởng', '员工离职需要提前一个月提交申请。', 'Yuángōng lízhí xūyào tíqián yí ge yuè tíjiāo shēnqǐng.', 'Nhân viên nghỉ việc cần nộp đơn trước một tháng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('11fda800-4233-4fd9-b432-1d2a493e464c', '培训', 'péixùn', 'đào tạo, tập huấn', 'Công xưởng', '上岗前大家都要参加安全操作培训。', 'Shànggǎng qián dàjiā dōu yào cānjiā ānquán cāozuò péixùn.', 'Trước khi vào vị trí làm việc mọi người đều phải tham gia tập huấn thao tác an toàn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('262b357b-8dfe-4586-b206-1d5b6c667132', '技能', 'jìnéng', 'kỹ năng', 'Công xưởng', '这家工厂对员工的焊接技能要求很高。', 'Zhè jiā gōngchǎng duì yuángōng de hànjiē jìnéng yāoqiú hěn gāo.', 'Nhà máy này yêu cầu kỹ năng hàn của công nhân rất cao.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('738a5acf-0d2a-4359-83d9-e0c3dd9fefd3', '入职', 'rùzhí', 'nhận việc, vào làm', 'Công xưởng', '新员工入职手续已经办理完毕。', 'Xīn yuángōng rùzhí shǒuxù yǐjīng bànlǐ wánbì.', 'Thủ tục nhận việc cho nhân viên mới đã hoàn tất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('63269793-ab01-4b48-80f4-ae2272ebc011', '考勤', 'kǎoqín', 'chấm công, điểm danh', 'Công xưởng', '月底人事部会核对全厂的考勤记录。', 'Yuèdǐ rénshìbù huì héduì quán chǎng de kǎoqín jìlù.', 'Cuối tháng phòng nhân sự sẽ đối soát biên bản chấm công toàn xưởng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('99d71a08-6280-4507-859f-346c3da4bc81', '打卡', 'dǎkǎ', 'quẹt thẻ, chấm vân tay', 'Công xưởng', '进出车间时不要忘记刷卡打卡。', 'Jìnchū chējiān shí bú yào wàngjì shuākǎ dǎkǎ.', 'Khi ra vào xưởng đừng quên quẹt thẻ chấm công.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9d5b39dd-369a-4494-99a1-ca8fc8134f38', '加班', 'jiābān', 'tăng ca, làm thêm giờ', 'Công xưởng', '今晚为了赶订单，全线需要加班两小时。', 'Jīnwǎn wèile gǎn dìngdān, quán xiàn xūyào jiābān liǎng xiǎoshí.', 'Tối nay để kịp đơn hàng, toàn bộ chuyền cần tăng ca hai tiếng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c230cbd1-5424-4e83-a4fa-40d01fe2e61a', '倒班', 'dǎobān', 'đổi ca, xoay ca', 'Công xưởng', '我们车间实行两班倒的工作制度。', 'Wǒmen chējiān shíxíng liǎng bān dǎo de gōngzuò zhìdù.', 'Phân xưởng chúng tôi áp dụng chế độ làm việc xoay hai ca.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f075647d-20ce-4898-97d2-ef1b5d4c13f0', '白班', 'báibān', 'ca ngày', 'Công xưởng', '这周我们组负责上白班，早上八点开工。', 'Zhè zhōu wǒmen zǔ fùzé shàng báibān, zǎoshang bā diǎn kāigōng.', 'Tuần này tổ chúng tôi phụ trách ca ngày, tám giờ sáng bắt đầu làm việc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2b90418e-66df-422c-b0d5-ea170ae3f0bb', '夜班', 'yèbān', 'ca đêm', 'Công xưởng', '上夜班的员工每天有额外的夜班补贴。', 'Shàng yèbān de yuángōng měitiān yǒu éwài de yèbān bǔtiē.', 'Công nhân làm ca đêm mỗi ngày đều có phụ cấp ca đêm riêng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('8df592ae-f341-432f-93a9-41c8bbda312d', '请假', 'qǐngjià', 'xin nghỉ phép', 'Công xưởng', '如果你身体不适，必须先向线长请假。', 'Rúguǒ nǐ shēntǐ búshì, bìxū xiān xiàng xiànzhǎng qǐngjià.', 'Nếu bạn thấy không khỏe trong người, phải xin phép chuyền trưởng trước.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1fc5a8a0-5d32-4d89-87e5-20c9cb188895', '病假', 'bìngjià', 'nghỉ ốm', 'Công xưởng', '请病假必须提交医院出具的休假证明。', 'Qǐng bìngjià bìxū tíjiāo yīyuàn chūjù de xiūjià zhèngmíng.', 'Xin nghỉ ốm bắt buộc phải nộp giấy chứng nhận nghỉ ốm do bệnh viện cấp.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f01dcf71-8eda-4fe8-8f1c-dd51accd55de', '事假', 'shìjià', 'nghỉ việc riêng', 'Công xưởng', '他因为家里有急事请了两天事假。', 'Tā yīnwèi jiālǐ yǒu jíshì qǐng le liǎng tiān shìjià.', 'Anh ấy vì gia đình có việc gấp nên xin nghỉ việc riêng hai ngày.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('88ce0c51-0581-4048-a206-728de86ba9f5', '迟到', 'chídào', 'đi muộn, đến trễ', 'Công xưởng', '连续迟到三次会扣除当月的全勤奖。', 'Liánxù chídào sān cì huì kòuchú dāng yuè de quánqín jiǎng.', 'Đi muộn liên tiếp ba lần sẽ bị trừ thưởng chuyên cần của tháng đó.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a72d2ee2-8fea-4971-8fe4-82ca0875f3ee', '早退', 'zǎotuì', 'về sớm', 'Công xưởng', '未经主管允许，任何员工不得擅自早退。', 'Wèijīng zhǔguǎn yǔnxǔ, rènhé yuángōng bùdé shànzì zǎotuì.', 'Chưa có sự cho phép của quản lý, không nhân viên nào được tự ý về sớm.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('83bbb024-5bdd-414f-bcff-245427bea85a', '旷工', 'kuànggōng', 'tự ý nghỉ làm, bỏ việc không phép', 'Công xưởng', '无故旷工不仅没有工资，还会被警告处分。', 'Wúgù kuànggōng bùjǐn méiyǒu gōngzī, hái huì bèi jǐnggào chǔfèn.', 'Nghỉ không lý do chẳng những không có lương mà còn bị kỷ luật cảnh cáo.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4adf56fe-863f-4584-9c96-b5932347169d', '补贴', 'bǔtiē', 'phụ cấp, trợ cấp', 'Công xưởng', '公司为所有员工提供餐费补贴和住房补贴。', 'Gōngsī wèi suǒyǒu yuángōng tígōng cānfèi bǔtiē hé zhùfáng bǔtiē.', 'Công ty cung cấp phụ cấp tiền ăn và phụ cấp nhà ở cho toàn thể nhân viên.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5ff42b24-a89f-4e8a-af2c-b41550b1a06e', '奖金', 'jiǎngjīn', 'tiền thưởng', 'Công xưởng', '如果本月超额完成产量，全组都能拿绩效奖金。', 'Rúguǒ běn yuè chāo''é wánchéng chǎnliàng, quán zǔ dōu néng ná jìxiào jiǎngjīn.', 'Nếu tháng này hoàn thành vượt mức sản lượng, cả tổ đều nhận được tiền thưởng hiệu suất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2b1f8d38-cbf7-44c6-95a7-294674225748', '社会保险', 'shèhuì bǎoxiǎn', 'bảo hiểm xã hội', 'Công xưởng', '公司依法为每位正式员工缴纳社会保险。', 'Gōngsī yīfǎ wèi měi wèi zhèngshì yuángōng jiǎonà shèhuì bǎoxiǎn.', 'Công ty đóng bảo hiểm xã hội theo đúng pháp luật cho mỗi nhân viên chính thức.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('567d6b8a-33c6-48c0-95f8-a85b2aae61c4', '车间', 'chējiān', 'phân xưởng, nhà xưởng', 'Công xưởng', '进入无尘车间前必须穿好防尘服。', 'Jìnrù wúchén chējiān qián bìxū chuān hǎo fángchénfú.', 'Trước khi vào phân xưởng phòng sạch bắt buộc phải mặc áo chống bụi chỉnh tề.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c1115316-ca4e-4107-a5be-ec24d4ea6cba', '生产线', 'shēngchǎnxiàn', 'dây chuyền sản xuất', 'Công xưởng', '目前二号生产线正在全负荷运转。', 'Mùqián èr hào shēngchǎnxiàn zhèngzài quán fùhè yùnzhuǎn.', 'Hiện tại dây chuyền sản xuất số hai đang vận hành hết công suất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a51ef45c-7e06-4b00-8dea-d87c9979b6dd', '流水线', 'liúshuǐxiàn', 'băng chuyền lắp ráp, dây chuyền chuyền', 'Công xưởng', '产品在流水线上快速流转，请大家注意节奏。', 'Chǎnpǐn zài liúshuǐxiàn shang kuàisù liúzhuǎn, qǐng dàjiā zhùyì jiézòu.', 'Sản phẩm luân chuyển rất nhanh trên băng chuyền, xin mọi người chú ý nhịp độ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('44e773aa-a02b-4db7-851b-d1bd588d86c6', '工段', 'gōngduàn', 'công đoạn', 'Công xưởng', '这个工段主要是负责最后的组装与打包。', 'Zhè ge gōngduàn zhǔyào shì fùzé zuìhòu de zǔzhuāng yǔ dǎbāo.', 'Công đoạn này chủ yếu chịu trách nhiệm lắp ráp và đóng gói khâu cuối.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('07ca2a39-6d40-4bcd-a7a6-a7907892e433', '班长', 'bānzhǎng', 'trưởng ca, ca trưởng', 'Công xưởng', '早会时班长强调了今天的安全生产要点。', 'Zǎohuì shí bānzhǎng qiángdiào le jīntiān de ānquán shēngchǎn yàodiǎn.', 'Trong cuộc họp đầu giờ, trưởng ca đã nhấn mạnh các điểm mấu chốt về an toàn sản xuất hôm nay.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d8a9b3d7-6ed5-4982-8985-c5f0dd899627', '线长', 'xiànzhǎng', 'chuyền trưởng', 'Công xưởng', '如果发现物料不够，马上通知线长处理。', 'Rúguǒ fāxiàn wùliào bú gòu, mǎshàng tōngzhī xiànzhǎng chǔlǐ.', 'Nếu phát hiện nguyên vật liệu không đủ, lập tức báo cho chuyền trưởng xử lý.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('8c5a0104-39b7-4298-8e81-576dbc271843', '组长', 'zǔzhǎng', 'tổ trưởng', 'Công xưởng', '组长正在教新员工正确的螺丝打法。', 'Zǔzhǎng zhèngzài jiāo xīn yuángōng zhèngquè de luósī dǎfǎ.', 'Tổ trưởng đang dạy nhân viên mới cách bắt ốc vít đúng kỹ thuật.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('aa53cd9c-cce3-4757-8375-2d9c0aac579d', '操作工', 'cāozuògōng', 'công nhân thao tác, công nhân vận hành', 'Công xưởng', '操作工必须严格按标准作业程序操作。', 'Cāozuògōng bìxū yángé àn biāozhǔn zuòyè chéngxù cāozuò.', 'Công nhân vận hành bắt buộc phải thao tác nghiêm ngặt theo quy trình thao tác chuẩn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a03bbe14-fe51-4a50-92d8-4f0f69898051', '产能', 'chǎnnéng', 'năng lực sản xuất, công suất', 'Công xưởng', '升级设备后，该产线的日产能提升了百分之二十。', 'Shēngjí shèbèi hòu, gāi chǎnxiàn de rì chǎnnéng tíshēng le bǎifēnzhī èrshí.', 'Sau khi nâng cấp thiết bị, công suất ngày của chuyền này đã tăng thêm 20%.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0619dbd6-4a25-469d-ae09-fab7b2c909ea', '产量', 'chǎnliàng', 'sản lượng', 'Công xưởng', '今天白班的实际产量超过了目标值。', 'Jīntiān báibān de shíjì chǎnliàng chāoguò le mùbiāozhí.', 'Sản lượng thực tế của ca ngày hôm nay đã vượt qua mức mục tiêu.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('fd131ecd-bcd3-497b-8942-680881708926', '节拍', 'jiépāi', 'nhịp độ sản xuất (takt time)', 'Công xưởng', '我们必须调整各个工位的动作以匹配生产节拍。', 'Wǒmen bìxū tiáozhěng gège gōngwèi de dòngzuò yǐ pǐpèi shēngchǎn jiépāi.', 'Chúng ta phải điều chỉnh thao tác của từng vị trí để khớp với nhịp độ sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('374c3603-3fad-43b5-ae4b-e0a1eb68679f', '交接班', 'jiāojiēbān', 'giao ca, chuyển giao ca', 'Công xưởng', '交接班时要认真交代当班的设备运行情况。', 'Jiāojiēbān shí yào rènzhēn jiāodài dāngbān de shèbèi yùnxíng qíngkuàng.', 'Khi giao ca cần bàn giao nghiêm túc tình hình hoạt động máy móc của ca làm việc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ad4d842f-7102-444b-912f-7ba2c39fa532', '投产', 'tóuchǎn', 'đưa vào sản xuất', 'Công xưởng', '新产品将于下周一正式投产上线。', 'Xīn chǎnpǐn jiāng yú xià zhōuyī zhèngshì tóuchǎn shàngxiàn.', 'Sản phẩm mới sẽ chính thức đưa vào sản xuất trên chuyền vào thứ Hai tuần tới.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('38d95521-eb44-4dc5-b3d6-081d2916a47e', '瓶颈', 'píngjǐng', 'nút thắt cổ chai, điểm nghẽn', 'Công xưởng', '测试工位是整条流水线的生产瓶颈。', 'Cèshì gōngwèi shì zhěng tiáo liúshuǐxiàn de shēngchǎn píngjǐng.', 'Vị trí đo kiểm là điểm nghẽn sản xuất của toàn bộ dây chuyền chuyền.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ca4e2639-6246-4fbd-bbf2-c62500db51a8', '停线', 'tíngxiàn', 'dừng dây chuyền, dừng chuyền', 'Công xưởng', '因为物料缺件，三号线被迫停线半小时。', 'Yīnwèi wùliào quējiàn, sān hào xiàn bèipò tíngxiàn bàn xiǎoshí.', 'Do thiếu linh kiện, dây chuyền số 3 buộc phải dừng chuyền nửa tiếng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a28b239d-cc48-4d15-8099-308c39146acf', '螺丝刀', 'luósīdāo', 'tua vít', 'Công xưởng', '请递给我一把十字螺丝刀。', 'Qǐng dì gěi wǒ yì bǎ shízì luósīdāo.', 'Làm ơn đưa cho tôi một cái tua vít 4 cạnh.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b8893cd4-6af6-49f3-a5b5-c4f08f501b06', '扳手', 'bānshǒu', 'cờ lê, mỏ lết', 'Công xưởng', '用活动扳手把螺母拧紧。', 'Yòng huódòng bānshǒu bǎ luómǔ nǐng jǐn.', 'Dùng mỏ lết vặn chặt đai ốc lại.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2dac3bc1-7322-4b0f-8333-fa38c859ad39', '钳子', 'qiánzi', 'kìm', 'Công xưởng', '用尖嘴钳剪断多余的电线。', 'Yòng jiānzuǐqián jiǎnduàn duōyú de diànxiàn.', 'Dùng kìm nhọn cắt đứt đoạn dây điện thừa.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('04b33330-3310-4b5f-be82-02149bc0afb8', '卷尺', 'juǎnchǐ', 'thước cuộn', 'Công xưởng', '你拿卷尺量一下箱子的长度。', 'Nǐ ná juǎnchǐ liáng yíxià xiāngzi de chángdù.', 'Bạn lấy thước cuộn đo chiều dài thùng hàng một chút.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0c740d80-1c61-46b5-a698-dafba0bdb5d9', '万用表', 'wànyòngbiǎo', 'đồng hồ vạn năng', 'Công xưởng', '维修工用万用表测量电压。', 'Wéixiūgōng yòng wànyòngbiǎo cèliáng diànyā.', 'Thợ bảo trì dùng đồng hồ vạn năng để đo điện áp.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3f8bc183-2820-4090-91cf-40b3996011b5', '电烙铁', 'diànlàotiě', 'mỏ hàn điện', 'Công xưởng', '电烙铁温度很高，小心烫伤。', 'Diànlàotiě wēndù hěn gāo, xiǎoxīn tàngshāng.', 'Mỏ hàn nhiệt độ rất cao, cẩn thận kẻo bị bỏng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('55a8c31e-8fdc-4222-b330-2931e2ef22b5', '胶带', 'jiāodài', 'băng dính, băng keo', 'Công xưởng', '用封箱胶带把纸箱粘好。', 'Yòng fēngxiāng jiāodài bǎ zhǐxiāng nián hǎo.', 'Dùng băng keo đóng thùng dán kín thùng carton lại.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c70dcb4f-7bf2-46c4-a72b-d6558042c863', '螺丝', 'luósī', 'ốc vít, bu-lông', 'Công xưởng', '这个外壳需要打四颗螺丝。', 'Zhè gè wàiké xūyào dǎ sì kē luósī.', 'Vỏ này cần phải bắt bốn con ốc vít.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c5b142b8-6084-4785-a975-9fbf9c0a5fa8', '螺母', 'luómǔ', 'đai ốc, tán', 'Công xưởng', '这个规格的螺母松动了。', 'Zhè gè guīgé de luómǔ sōngdòng le.', 'Đai ốc quy cách này đã bị lỏng rồi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d90f3d4d-a893-4889-9206-c7ef9245d0e6', '美工刀', 'měigōngdāo', 'dao rọc giấy, dao trổ', 'Công xưởng', '使用美工刀开箱时要注意安全。', 'Shǐyòng měigōngdāo kāixiāng shí yào zhùyì ānquán.', 'Khi dùng dao rọc giấy để khui thùng phải chú ý an toàn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('624b16c7-6988-48e0-a4e8-cb1284115817', '砂纸', 'shāzhǐ', 'giấy ráp, giấy nhám', 'Công xưởng', '用细砂纸打磨产品表面。', 'Yòng xì shāzhǐ dǎmó chǎnpǐn biǎomiàn.', 'Dùng giấy nhám mịn để chà nhám bề mặt sản phẩm.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('753b6d75-2aa6-4be7-8ffe-787a7f31e916', '润滑油', 'rùnhuáyóu', 'dầu bôi trơn', 'Công xưởng', '导轨上要定期加润滑油。', 'Dǎoguǐ shàng yào dìngqī jiā rùnhuáyóu.', 'Trên thanh dẫn hướng cần định kỳ tra dầu bôi trơn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('20946ae1-f176-4df6-bf80-2ef3c22e34da', '工具箱', 'gōngjùxiāng', 'hộp dụng cụ', 'Công xưởng', '用完工具后请放回工具箱。', 'Yòng wán gōngjù hòu qǐng fàng huí gōngjùxiāng.', 'Dùng xong dụng cụ xin hãy để lại vào hộp dụng cụ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e25d8cc8-c5b4-4d6b-8fb5-22cacb7ec994', '抹布', 'mābù', 'giẻ lau', 'Công xưởng', '拿无尘抹布把工作台擦干净。', 'Ná wúchén mābù bǎ gōngzuòtái cā gānjìng.', 'Lấy giẻ lau phòng sạch lau sạch bàn làm việc.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e38e5a6f-f346-456b-a449-6d036887197d', '扎带', 'zhādài', 'dây rút nhựa, lạt nhựa', 'Công xưởng', '用尼龙扎带把这些线缆绑好。', 'Yòng nílóng zhādài bǎ zhèxiē xiànlǎn bǎng hǎo.', 'Dùng dây rút nylon buộc gọn các bó cáp này lại.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2e832e8a-8735-4c0a-8f1f-50e8db408869', '开机', 'kāijī', 'mở máy, khởi động máy', 'Công xưởng', '上班后的第一件事是开机预热。', 'Shàngbān hòu de dì-yī jiàn shì shì kāijī yùrè.', 'Việc đầu tiên sau khi vào làm là bật máy để làm nóng trước.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('eecfd7eb-636b-4fce-81ff-fabc64d87cdb', '关机', 'guānjī', 'tắt máy', 'Công xưởng', '下班前必须按标准步骤关机。', 'Xiàbān qián bìxū àn biāozhǔn bùzhòu guānjī.', 'Trước khi tan ca phải tắt máy theo đúng trình tự tiêu chuẩn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f5c8f5cb-6be6-4e91-a4d4-60918b9f6022', '调试', 'tiáoshì', 'căn chỉnh, chạy thử (debug/tuning)', 'Công xưởng', '技术员正在调试新设备。', 'Jìshùyuán zhèngzài tiáoshì xīn shèbèi.', 'Kỹ thuật viên đang căn chỉnh chạy thử thiết bị mới.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('72fc8845-c90a-4890-939e-01cede770407', '参数', 'cānshù', 'thông số kỹ thuật', 'Công xưởng', '不能随意修改机台的生产参数。', 'Bù néng suíyì xiūgǎi jītái de shēngchǎn cānshù.', 'Không được tự ý sửa đổi thông số sản xuất của máy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f1f744d1-b176-4435-af75-8a4377890091', '报警', 'bàojǐng', 'báo động, báo lỗi máy', 'Công xưởng', '如果机器报警，请立刻通知领班。', 'Rúguǒ jīqì bàojǐng, qǐng lìkè tōngzhī lǐngbān.', 'Nếu máy phát cảnh báo lỗi, xin hãy lập tức báo cho chuyền trưởng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('cea0580f-9e58-4c43-9b31-08214c2fa27b', '急停', 'jítíng', 'dừng khẩn cấp (E-stop)', 'Công xưởng', '遇到危险情况马上按急停按钮。', 'Yù dào wēixiǎn qíngkuàng mǎshàng àn jítíng ànniǔ.', 'Khi gặp tình huống nguy hiểm, nhấn ngay nút dừng khẩn cấp.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('46a7c59c-e241-4d85-8f12-89e23c8623d1', '故障', 'gùzhàng', 'sự cố, hỏng hóc', 'Công xưởng', '二号机台发生机械故障，正在排查。', 'Èr hào jītái fāshēng jīxiè gùzhàng, zhèngzài páichá.', 'Máy số 2 phát sinh sự cố cơ học, đang được kiểm tra xử lý.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('aae44350-f7f6-4263-a20a-eb9da2490338', '维修', 'wéixiū', 'sửa chữa, bảo dưỡng hỏng hóc', 'Công xưởng', '设备坏了需要叫维修工来修。', 'Shèbèi huài le xūyào jiào wéixiūgōng lái xiū.', 'Thiết bị hỏng rồi, cần gọi thợ sửa chữa đến sửa.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9e87a004-b764-48b9-9bd3-bdb8f132036e', '保养', 'bǎoyǎng', 'bảo trì định kỳ', 'Công xưởng', '每周六下午进行设备例行保养。', 'Měi zhōuliù xiàwǔ jìnxíng shèbèi lìxíng bǎoyǎng.', 'Chiều thứ Bảy hàng tuần tiến hành bảo trì máy móc định kỳ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e8ede2ce-bd33-4c82-b0a0-696658201313', '模具', 'mújù', 'khuôn mẫu (mould/die)', 'Công xưởng', '这套模具需要更换刀口。', 'Zhè tào mújù xūyào gēnghuàn dāokǒu.', 'Bộ khuôn này cần phải thay lưỡi cắt.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0127dcd1-8836-4a21-8663-8594e0d6c578', '换线', 'huànxiàn', 'đổi mã hàng, đổi chuyền', 'Công xưởng', '今天下午两点生产线要换线。', 'Jīntiān xiàwǔ liǎng diǎn shēngchǎnxiàn yào huànxiàn.', '2 giờ chiều nay dây chuyền sản xuất phải đổi mã hàng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6903e91d-c0f8-4730-a8c8-07193937d2cc', '治具', 'zhìjù', 'đồ gá, jig', 'Công xưởng', '装配前先检查治具是否放正。', 'Zhuāngpèi qián xiān jiǎnchá zhìjù shìfǒu fàng zhèng.', 'Trước khi lắp ráp hãy kiểm tra đồ gá đã đặt ngay ngắn chưa.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f32e251c-1805-4d1e-88c9-072a3732f68a', '感应器', 'gǎnyìngqì', 'cảm biến (sensor)', 'Công xưởng', '感应器脏了，导致机器无法感应物料。', 'Gǎnyìngqì zāng le, dǎozhì jīqì wúfǎ gǎnyìng wùliào.', 'Cảm biến bị bẩn nên máy không nhận biết được vật liệu.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2cfdb0d8-b991-46e5-902a-190b17ae4f65', '复位', 'fùwèi', 'reset, đặt lại vị trí ban đầu', 'Công xưởng', '清理卡料后，按复位键继续生产。', 'Qīnglǐ kǎliào hòu, àn fùwèi jiàn jìxù shēngchǎn.', 'Sau khi xử lý kẹt liệu, bấm nút reset để tiếp tục sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('674c4264-56d0-4179-8df5-faed4cc9854f', '运转', 'yùnzhuǎn', 'vận hành, chạy máy', 'Công xưởng', '机器在正常运转中，不能把手伸进去。', 'Jīqì zài zhèngcháng yùnzhuǎn zhōng, bù néng bǎ shǒu shēn jìnqù.', 'Khi máy đang vận hành bình thường, không được thò tay vào.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c366086c-0d2d-4b0c-9b1d-38a689d1aed6', '检验', 'jiǎnyàn', 'kiểm tra, nghiệm thu', 'Công xưởng', '每批产品出货前都要进行检验。', 'Měi pī chǎnpǐn chūhuò qián dōu yào jìnxíng jiǎnyàn.', 'Mỗi lô hàng trước khi xuất xưởng đều phải qua kiểm tra.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3f494da8-ab57-45d6-a322-94e9500a9fa3', '良品', 'liángpǐn', 'hàng đạt tiêu chuẩn, hàng OK', 'Công xưởng', '良品请放在绿色胶筐里。', 'Liángpǐn qǐng fàng zài lǜsè jiāokuāng lǐ.', 'Hàng đạt xin vui lòng đặt vào giỏ nhựa màu xanh lá.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e471d3fe-7042-4eb7-97a5-27017d424fbd', '不良品', 'bùliángpǐn', 'hàng lỗi, hàng NG', 'Công xưởng', '不良品必须贴上红色标签隔离。', 'Bùliángpǐn bìxū tiē shàng hóngsè biāoqiān gélí.', 'Hàng lỗi bắt buộc phải dán nhãn đỏ và cách ly.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('88cd29a3-8bf9-498c-a335-7f6105e9bdf3', '抽检', 'chōujiǎn', 'kiểm tra ngẫu nhiên, rút mẫu', 'Công xưởng', 'QC 正在按比例进行抽检。', 'QC zhèngzài àn bǐlì jìnxíng chōujiǎn.', 'QC đang rút mẫu kiểm tra theo tỉ lệ quy định.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('fbc3d4f0-7f34-4d29-bf7e-729dc0a887fc', '全检', 'quánjiǎn', 'kiểm tra 100%, kiểm tra toàn bộ', 'Công xưởng', '这批订单要求对外观进行全检。', 'Zhè pī dìngdān yāoqiú duì wàiguān jìnxíng quánjiǎn.', 'Đơn hàng đợt này yêu cầu kiểm tra toàn bộ ngoại quan.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0bce98dd-704e-488e-9e18-4f2488850cc0', '划痕', 'huáhén', 'vết xước', 'Công xưởng', '外壳上有明显的划痕，属于外观不良。', 'Wàiké shàng yǒu míngxiǎn de huáhén, shǔyú wàiguān bùliáng.', 'Trên bề mặt vỏ có vết xước rõ rệt, thuộc dạng lỗi ngoại quan.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1ac95e87-84dd-431f-b300-81016818c26b', '变形', 'biànxíng', 'biến dạng, cong vênh', 'Công xưởng', '注塑温度太高会导致工件变形。', 'Zhùsù wēndù tài gāo huì dǎozhì gōngjiàn biànxíng.', 'Nhiệt độ ép nhựa quá cao sẽ làm cho chi tiết bị biến dạng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d2777512-b160-43a3-a01e-56d1516b6b56', '尺寸', 'chǐcun', 'kích thước', 'Công xưởng', '用卡尺测量一下这个零件的尺寸。', 'Yòng kǎchǐ liáng yíxià zhè ge língjiàn de chǐcun.', 'Dùng thước kẹp đo thử kích thước của linh kiện này xem.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6d9ae1d5-c68d-48fa-96cc-708a88428d50', '公差', 'gōngchā', 'dung sai cho phép', 'Công xưởng', '这个长度超出公差范围了。', 'Zhè gè chángdù chāochū gōngchā fànwéi le.', 'Chiều dài này đã vượt quá phạm vi dung sai cho phép.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7573cb1c-256a-4dd3-a09c-f59ee91552a1', '报废', 'bàofèi', 'báo phế, loại bỏ', 'Công xưởng', '严重损坏的产品只能申请报废。', 'Yánzhòng sǔnhuài de chǎnpǐn zhǐ néng shēnqǐng bàofèi.', 'Sản phẩm hư hỏng nặng chỉ có thể làm đơn báo phế.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('69e669af-cc66-49fe-8ec2-da5773184439', '返工', 'fǎngōng', 'làm lại, sửa lại (rework)', 'Công xưởng', '这十箱货需要拆开重新返工。', 'Zhè shí xiāng huò xūyào chāikāi chóngxīn fǎngōng.', 'Mười thùng hàng này cần phải tháo ra để làm lại.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('88b1303a-209b-4d4e-b78d-06d48904ec5a', '首件', 'shǒujiàn', 'mẫu đầu tiên (first piece/first article)', 'Công xưởng', '开线后必须先做首件确认。', 'Kāixiàn hòu bìxū xiān zuò shǒujiàn quèrèn.', 'Sau khi mở chuyền bắt buộc phải xác nhận kiểm tra mẫu đầu tiên.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7a941ace-f731-44ee-8ae9-3209389caf29', '标准', 'biāozhǔn', 'tiêu chuẩn', 'Công xưởng', '所有操作必须符合检验标准书的要求。', 'Suǒyǒu cāozuò bìxū fúhé jiǎnyàn biāozhǔnshū de yāoqiú.', 'Mọi thao tác đều phải đáp ứng yêu cầu của bảng tiêu chuẩn kiểm tra.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('36ab9aaf-917a-4511-b4d5-365b779ee301', '毛刺', 'máocì', 'bavia, gờ sắc nhọn', 'Công xưởng', '塑料件边缘有毛刺，需要去毛刺。', 'Sùliàojiàn biānyuán yǒu máocì, xūyào qù máocì.', 'Viền chi tiết nhựa có bavia, cần phải gọt bavia.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d219026c-88a2-4ca4-9b19-f1b30800eeb7', '判定', 'pàndìng', 'phán định, kết luận đạt/không đạt', 'Công xưởng', '品质主管判定这批货为合格。', 'Pǐnzhì zhǔguǎn pàndìng zhè pī huò wéi hégé.', 'Chủ quản chất lượng phán định lô hàng này đạt yêu cầu.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('380e54cb-effc-4ca1-aade-14a58357c16a', '仓库', 'cāngkù', 'kho hàng', 'Công xưởng', '这批原料要马上送到一号仓库。', 'Zhè pī yuánliào yào mǎshàng sòng dào yī hào cāngkù.', 'Lô nguyên liệu này cần chuyển ngay đến kho số 1.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3bddbe47-c434-47f7-abf9-7759223871d4', '入库', 'rùkù', 'nhập kho', 'Công xưởng', '质检合格后才能办理入库手续。', 'Zhìjiǎn hégé hòu cáinéng bànlǐ rùkù shǒuxù.', 'Sau khi kiểm tra chất lượng đạt mới được làm thủ tục nhập kho.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('23b791b8-7e48-4ee1-9033-0ca9db1de404', '出库', 'chūkù', 'xuất kho', 'Công xưởng', '今天下午有五百箱成品需要出库。', 'Jīntiān xiàwǔ yǒu wǔbǎi xiāng chéngpǐn xūyào chūkù.', 'Chiều nay có 500 thùng thành phẩm cần xuất kho.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('dd443c17-9ea3-46df-a559-ff4b5eb11198', '库存', 'kùcún', 'hàng tồn kho', 'Công xưởng', '请查一下这个零件的安全库存。', 'Qǐng chá yíxià zhè ge língjiàn de ānquán kùcún.', 'Vui lòng kiểm tra lượng tồn kho an toàn của linh kiện này.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('8e672c71-b276-41b4-b9c4-7b8ee07f7d81', '盘点', 'pándiǎn', 'kiểm kê hàng hóa', 'Công xưởng', '我们仓库每个月末都要进行大盘点。', 'Wǒmen cāngkù měi gè yuè mò dōu yào jìnxíng dà pándiǎn.', 'Kho của chúng tôi đều tổng kiểm kê vào cuối mỗi tháng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('cc74baef-4e49-4997-98ad-65dbe370c0e7', '叉车', 'chāchē', 'xe nâng', 'Công xưởng', '只有持有操作证的人才能开叉车。', 'Zhǐyǒu chíyǒu cāozuò zhèng de rén cáinéng kāi chāchē.', 'Chỉ người có chứng chỉ vận hành mới được lái xe nâng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('bd721272-ffcd-425e-a15e-d1c99675c8ec', '托盘', 'tuōpán', 'pallet, tấm kê hàng', 'Công xưởng', '一个托盘最多只能放四十箱货物。', 'Yí ge tuōpán zuìduō zhǐ néng fàng sìshí xiāng huòwù.', 'Một pallet tối đa chỉ được để 40 thùng hàng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('15eecdee-7ffa-4ec0-9805-c2a3834cd164', '货架', 'huòjià', 'giá kệ để hàng', 'Công xưởng', '重物必须放在货架的最底层。', 'Zhòngwù bìxū fàng zài huòjià de zuì dǐ céng.', 'Hàng nặng bắt buộc phải để ở tầng thấp nhất của giá kệ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('bbb1c619-ffe4-4a62-b9a4-dda8052e822e', '包装', 'bāozhuāng', 'đóng gói, bao bì', 'Công xưởng', '发货前要检查外包装有没有破损。', 'Fāhuò qián yào jiǎnchá wàibāozhuāng yǒu méiyǒu pòsǔn.', 'Trước khi giao hàng phải kiểm tra xem bao bì bên ngoài có bị rách vỡ không.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('1cdfbbad-bec4-43af-96fe-2f615f658045', '标签', 'biāoqiān', 'nhãn mác, tem nhãn', 'Công xưởng', '外箱上的物料标签贴错了。', 'Wàixiāng shang de wùliào biāoqiān tiē cuò le.', 'Tem nguyên liệu dán trên thùng ngoài bị sai rồi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5719500d-4235-44e3-b072-c89ea82c014d', '发货', 'fāhuò', 'gửi hàng, giao hàng', 'Công xưởng', '这批订单明天早上准时发货。', 'Zhè pī dìngdān míngtiān zǎoshang zhǔnshí fāhuò.', 'Đơn hàng này sáng mai sẽ xuất giao đúng giờ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6341205b-f24d-4183-875c-5fd3600a13fc', '收货', 'shōuhuò', 'nhận hàng', 'Công xưởng', '收货员正在核对送货单和实物。', 'Shōuhuòyuán zhèngzài héduì sònghuòdān hé shíwù.', 'Nhân viên nhận hàng đang đối chiếu phiếu giao hàng và hàng thực tế.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b3af37f2-b6bc-46f1-b14f-c6a82a000b46', '堆放', 'duīfàng', 'chất đống, xếp chồng', 'Công xưởng', '纸箱堆放得太高容易倒下来。', 'Zhǐxiāng duīfàng de tài gāo róngyì dǎo xiàlái.', 'Thùng carton chất chồng quá cao rất dễ đổ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3bc2ec9f-7bc8-4553-95b7-bf3d537027a6', '破损', 'pòsǔn', 'hư hại, móp méo, rách vỡ', 'Công xưởng', '装卸货物时要小心，防止破损。', 'Zhuāngxiè huòwù shí yào xiǎoxīn, fángzhǐ pòsǔn.', 'Khi bốc dỡ hàng cần cẩn thận để tránh hư hại.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('044e4b03-6bb2-47ab-b7bf-3c6ded280c95', '批号', 'pīhào', 'số lô hàng (batch/lot number)', 'Công xưởng', '请记录下这批货物的生产批号。', 'Qǐng jìlù xià zhè pī huòwù de shēngchǎn pīhào.', 'Xin vui lòng ghi chép lại số lô sản xuất của kiện hàng này.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5f909a60-4c48-47e3-9fef-c53d9d84be79', '安全', 'ānquán', 'an toàn', 'Công xưởng', '安全生产是工厂的第一原则。', 'Ānquán shēngchǎn shì gōngchǎng de dì-yī yuánzé.', 'An toàn sản xuất là nguyên tắc số một của nhà máy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b2182cb8-4704-4b1d-bde7-5f36dc86dc14', '劳保用品', 'láobǎo yòngpǐn', 'đồ bảo hộ lao động (PPE)', 'Công xưởng', '进入车间必须按规定穿戴劳保用品。', 'Jìnrù chējiān bìxū àn guīdìng chuāndài láobǎo yòngpǐn.', 'Vào xưởng phải trang bị đồ bảo hộ lao động theo đúng quy định.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('298b6f0d-bf9f-433f-b242-5b9309eb405b', '安全帽', 'ānquánmào', 'mũ bảo hộ', 'Công xưởng', '在施工区域工作必须戴安全帽。', 'Zài shīgōng qūyù gōngzuò bìxū dài ānquánmào.', 'Làm việc tại khu vực thi công bắt buộc phải đội mũ bảo hộ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('599d232b-0cfb-4abc-ac2b-1361fdcc03cf', '防护眼镜', 'fánghù yǎnjìng', 'kính bảo hộ', 'Công xưởng', '打磨作业时一定要戴防护眼镜。', 'Dǎmó zuòyè shí yídìng yào dài fánghù yǎnjìng.', 'Khi làm việc mài bóng nhất định phải đeo kính bảo hộ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e69bdb2d-f55c-4a1d-adaa-b1052bd4c7f4', '耳塞', 'ěrsāi', 'nút bịt tai chống ồn', 'Công xưởng', '冲压车间噪音很大，工人要佩戴耳塞。', 'Chòngyā chējiān zàoyīn hěn dà, gōngrén yào pèidài ěrsāi.', 'Xưởng dập tiếng ồn rất lớn, công nhân phải đeo nút bịt tai.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('214b8509-d1b1-499a-8885-8ee4a3bc77ee', '口罩', 'kǒuzhào', 'khẩu trang', 'Công xưởng', '喷漆车间粉尘多，必须戴防尘口罩。', 'Pēnqī chējiān fěnchén duō, bìxū dài fángchén kǒuzhào.', 'Xưởng sơn nhiều bụi, bắt buộc phải đeo khẩu trang chống bụi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('52c3437c-87ca-4370-8a2c-77440d7b9997', '灭火器', 'mièhuǒqì', 'bình chữa cháy', 'Công xưởng', '每个月都要检查灭火器的压力表。', 'Měi gè yuè dōu yào jiǎnchá mièhuǒqì de yālìbiǎo.', 'Hàng tháng đều phải kiểm tra đồng hồ áp suất của bình chữa cháy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f75fe375-47e6-4560-8699-fd4943481867', '紧急出口', 'jǐnjí chūkǒu', 'lối thoát hiểm khẩn cấp', 'Công xưởng', '紧急出口附近严禁堆放任何杂物。', 'Jǐnjí chūkǒu fùjìn yánjìn duīfàng rènhé záwù.', 'Nghiêm cấm chất đống bất kỳ đồ vật nào gần lối thoát hiểm khẩn cấp.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d179d10f-cb95-4675-add8-8490b64a2fe0', '工伤', 'gōngshāng', 'tai nạn lao động', 'Công xưởng', '如果发生工伤，要立刻报告主管。', 'Rúguǒ fāshēng gōngshāng, yào lìkè bàogào zhǔguǎn.', 'Nếu xảy ra tai nạn lao động, phải báo cáo ngay cho chủ quản.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('22b93f86-8f3a-4fa5-8172-62fdbf26ea75', '危险', 'wēixiǎn', 'nguy hiểm', 'Công xưởng', '机器运转时伸手进去非常危险。', 'Jīqì yùnzhuǎn shí shēnshǒu jìnqù fēicháng wēixiǎn.', 'Thò tay vào khi máy đang chạy là cực kỳ nguy hiểm.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6a28b912-dc82-4a09-9074-64d91f4a2ce7', '禁止', 'jìnzhǐ', 'cấm, nghiêm cấm', 'Công xưởng', '车间内禁止吸烟和使用明火。', 'Chējiān nèi jìnzhǐ xīyān hé shǐyòng mínghuǒ.', 'Trong nhà xưởng nghiêm cấm hút thuốc và sử dụng ngọn lửa trần.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('680dbabb-813a-4c84-a57a-f826b0f2c0fe', '漏电', 'lòudiàn', 'rò rỉ điện', 'Công xưởng', '发现电线破皮漏电要马上切断电源。', 'Fāxiàn diànxiàn pòpí lòudiàn yào mǎshàng qiēduàn diànyuán.', 'Phát hiện dây điện rách vỏ bị rò điện phải ngắt nguồn điện ngay lập tức.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b25fe305-c4c2-47d8-9505-eb77ec529a40', '消防通道', 'xiāofáng tōngdào', 'lối đi phòng cháy chữa cháy', 'Công xưởng', '请保持消防通道畅通，不要堵塞。', 'Qǐng bǎochí xiāofáng tōngdào chàngtōng, bú yào dǔsè.', 'Xin giữ lối thoát hiểm PCCC thông thoáng, không làm tắc nghẽn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('bb8b7ea4-e191-4ef2-af44-775e12519a41', '演练', 'yǎnliàn', 'diễn tập', 'Công xưởng', '厂区明天下午组织消防疏散演练。', 'Chǎngqū míngtiān xiàwǔ zǔzhī xiāofáng shūsàn yǎnliàn.', 'Toàn khu nhà máy chiều mai sẽ tổ chức diễn tập sơ tán phòng cháy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('81b71097-0722-474c-b1d0-53916ab0b140', '急救箱', 'jíjiùxiāng', 'hộp sơ cứu y tế', 'Công xưởng', '每个车间办公室都有配备急救箱。', 'Měi gè chējiān bàngōngshì dōu yǒu pèibèi jíjiùxiāng.', 'Mỗi văn phòng xưởng đều được trang bị hộp sơ cứu y tế.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ef73a3dd-5178-4532-8c03-47e3f70e2b22', '工程师', 'gōngchéngshī', 'kỹ sư', 'Công xưởng', '设备工程师正在排查机器故障原因。', 'Shèbèi gōngchéngshī zhèngzài páichá jīqì gùzhàng yuányīn.', 'Kỹ sư thiết bị đang truy tìm nguyên nhân gây ra sự cố máy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4b45daa4-96db-4742-bb07-0a4db1da5e08', '维修', 'wéixiū', 'sửa chữa, bảo trì', 'Công xưởng', '这台注塑机坏了，需要马上维修。', 'Zhè tái zhùsùjī huài le, xūyào mǎshàng wéixiū.', 'Máy ép nhựa này bị hỏng rồi, cần sửa chữa ngay.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ea744f16-5104-45b8-8079-7bfcc971dfda', '保养', 'bǎoyǎng', 'bảo dưỡng', 'Công xưởng', '设备必须按照计划进行周保养和月保养。', 'Shèbèi bìxū ànzhào jìhuà jìnxíng zhōu bǎoyǎng hé yuè bǎoyǎng.', 'Thiết bị bắt buộc phải bảo dưỡng tuần và tháng theo kế hoạch.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('571a3533-6f9e-48b0-90ab-04661ec02639', '故障', 'gùzhàng', 'sự cố, hỏng hóc', 'Công xưởng', '如果机器出现故障，请立刻按下急停按钮。', 'Rúguǒ jīqì chūxiàn gùzhàng, qǐng lìkè ànxià jítíng ànniǔ.', 'Nếu máy móc gặp sự cố, xin hãy nhấn ngay nút dừng khẩn cấp.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('af428013-eaaa-4d80-b92a-6b74f834e27d', '调试', 'tiáoshì', 'căn chỉnh, chạy thử nghiệm (commissioning)', 'Công xưởng', '新机器安装好后需要先调试两天。', 'Xīn jīqì ānzhuāng hǎo hòu xūyào xiān tiáoshì liǎng tiān.', 'Máy mới sau khi lắp đặt xong cần chạy thử căn chỉnh trong hai ngày.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('36a7da52-ab3a-4433-a147-d5abcc43f4e6', '备件', 'bèijiàn', 'linh kiện dự phòng, phụ tùng thay thế', 'Công xưởng', '常用易损备件库房里都要有储备。', 'Chángyòng yìsǔn bèijiàn kùfáng lǐ dōu yào yǒu chǔbèi.', 'Phụ tùng dễ hao mòn thông dụng trong kho đều phải có dự trữ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d49a53a0-6ff1-418d-afe2-7ee04d5263ab', '图纸', 'túzhǐ', 'bản vẽ kỹ thuật', 'Công xưởng', '组装前必须仔细看懂机械图纸。', 'Zǔzhuāng qián bìxū zǐxì kàndǒng jīxiè túzhǐ.', 'Trước khi lắp ráp bắt buộc phải đọc hiểu kỹ bản vẽ cơ khí.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('365d262b-34a4-4d47-ac92-0be84718fe03', '拆卸', 'chāixiè', 'tháo dỡ, tháo rời', 'Công xưởng', '拆卸电机前一定要确保已经断电。', 'Chāixiè diànjī qián yídìng yào quèbǎo yǐjīng duàndiàn.', 'Trước khi tháo dỡ mô tơ nhất định phải đảm bảo đã ngắt nguồn điện.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('435caf7b-f24e-41e9-b5e2-2fb1a45575ed', '安装', 'ānzhuāng', 'lắp đặt', 'Công xưởng', '技术人员正在车间安装新的传送带。', 'Jìshù rényuán zhèngzài chējiān ānzhuāng xīn de chuánsòngdài.', 'Nhân viên kỹ thuật đang lắp đặt băng tải mới trong xưởng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7f2d4b53-1338-4c7b-91ef-3da9b428fee6', '参数', 'cānshù', 'thông số kỹ thuật', 'Công xưởng', '不能随便更改设备设定的工艺参数。', 'Bù néng suíbiàn gēnggǎi shèbèi shèdìng de gōngyì cānshù.', 'Không được tự ý thay đổi thông số quy trình đã cài đặt của thiết bị.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ac9288f4-d465-4412-9cd3-8cdd1d885fce', '精度', 'jīngdù', 'độ chính xác', 'Công xưởng', '这台数控机床的加工精度非常高。', 'Zhè tái shùkòng jīchuáng de jiāgōng jīngdù fēicháng gāo.', 'Độ chính xác gia công của máy CNC này rất cao.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9461695d-10fc-44a3-b0dc-c401783ad81d', '磨损', 'mósǔn', 'hao mòn, mài mòn', 'Công xưởng', '轴承磨损严重，运转时声音异常。', 'Zhóuchéng mósǔn yánzhòng, yùnzhuǎn shí shēngyīn yìcháng.', 'Vòng bi bị mài mòn nghiêm trọng, khi vận hành phát ra tiếng kêu bất thường.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3c894a06-60a6-42c0-87a0-6541565ffd66', '润滑油', 'rùnhuáyóu', 'dầu bôi trơn', 'Công xưởng', '每周要在导轨上加一次润滑油。', 'Měi zhōu yào zài dǎoguǐ shang jiā yí cì rùnhuáyóu.', 'Mỗi tuần cần tra dầu bôi trơn lên ray dẫn hướng một lần.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c2901948-ba85-4179-a9aa-2a88278a2472', '停机', 'tíngjī', 'dừng máy (ngừng hoạt động)', 'Công xưởng', '意外停机会给产线造成很大的损失。', 'Yìwài tíngjī huì gěi chǎnxiàn zàochéng hěn dà de sǔnshī.', 'Sự cố dừng máy đột ngột sẽ gây thiệt hại rất lớn cho dây chuyền.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ac132f3d-7f4d-470a-8aa9-ffbec95c8f98', '改造', 'gǎizào', 'cải tiến, nâng cấp cải tạo', 'Công xưởng', '工程部提出了老设备的技术改造方案。', 'Gōngchéngbù tíchū le lǎo shèbèi de jìshù gǎizào fāng''àn.', 'Bộ phận kỹ thuật đã đề xuất phương án cải tạo công nghệ cho thiết bị cũ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5d46e537-db7a-493d-a7fc-3e39927455ab', '工程师', 'gōngchéngshī', 'kỹ sư', 'Công xưởng', '制程工程师正在现场分析不良原因。', 'Zhìchéng gōngchéngshī zhèngzài xiànchǎng fēnxī bùliáng yuányīn.', 'Kỹ sư quy trình đang phân tích nguyên nhân lỗi tại hiện trường.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4217e8d6-048b-45c2-b697-eb2744046d10', '制程', 'zhìchéng', 'quy trình sản xuất, công đoạn chế tạo', 'Công xưởng', '我们要优化这个制程以提高生产效率。', 'Wǒmen yào yōuhuà zhège zhìchéng yǐ tígāo shēngchǎn xiàolǜ.', 'Chúng ta cần tối ưu hóa quy trình này để nâng cao hiệu suất sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0831c4cf-96f3-482c-afd2-defcfd6e68f4', '试产', 'shìchǎn', 'sản xuất thử nghiệm (trial run)', 'Công xưởng', '新产品明天进行第一次试产。', 'Xīn chǎnpǐn míngtiān jìnxíng dì-yī cì shìchǎn.', 'Sản phẩm mới ngày mai sẽ tiến hành sản xuất thử lần đầu.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('54425781-a9d5-40dd-bd47-b70181a7d60b', '量产', 'liàngchǎn', 'sản xuất hàng loạt (mass production)', 'Công xưởng', '下个月该机型将正式进入量产阶段。', 'Xià ge yuè gāi jīxíng jiāng zhèngshì jìnrù liàngchǎn jiēduàn.', 'Tháng sau mẫu máy này sẽ chính thức bước vào giai đoạn sản xuất hàng loạt.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f5ab19b0-6f8a-4a54-ba97-39c179f3c243', '样品', 'yàngpǐn', 'hàng mẫu, sản phẩm mẫu', 'Công xưởng', '请把这批样品送去实验室测试。', 'Qǐng bǎ zhè pī yàngpǐn sòng qù shíyànshì cèshì.', 'Xin hãy gửi lô hàng mẫu này tới phòng thí nghiệm để kiểm tra.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0cca1c7e-7f72-4c9e-9427-769c50b5728b', '图纸', 'túzhǐ', 'bản vẽ kỹ thuật', 'Công xưởng', '加工零件必须严格按照图纸尺寸。', 'Jiāgōng língjiàn bìxū yángé ànzhào túzhǐ chǐcun.', 'Gia công linh kiện phải tuân thủ nghiêm ngặt theo kích thước bản vẽ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6d9bfd1e-571c-4943-8585-069d841351e4', '规格', 'guīgé', 'quy cách, thông số kỹ thuật', 'Công xưởng', '这个零件的规格不符合客户要求。', 'Zhège língjiàn de guīgé bù fúhé kèhù yāoqiú.', 'Quy cách của linh kiện này không phù hợp với yêu cầu của khách hàng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('35c4e4ae-8e75-4c77-bfe8-d0ef89fd3ef7', '工艺', 'gōngyì', 'công nghệ chế tạo, kỹ thuật quy trình', 'Công xưởng', '这种焊接工艺需要非常高的温度控制。', 'Zhè zhǒng hànjiē gōngyì xūyào fēicháng gāo de wēndù kòngzhì.', 'Kỹ thuật hàn này đòi hỏi kiểm soát nhiệt độ rất khắt khe.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7edc387d-0286-4390-a2d5-c5cde6f002e3', '作业指导书', 'zuòyè zhǐdǎoshū', 'tài liệu hướng dẫn thao tác (SOP / WI)', 'Công xưởng', '工位上必须悬挂最新的作业指导书。', 'Gōngwèi shang bìxū xuánguà zuìxīn de zuòyè zhǐdǎoshū.', 'Tại vị trí làm việc bắt buộc phải treo bản hướng dẫn thao tác mới nhất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('839ed471-76e7-4384-bc9c-74804ac986ca', '治具', 'zhìjù', 'đồ gá (jig)', 'Công xưởng', '组装前先检查测试治具是否定位准确。', 'Zǔzhuāng qián xiān jiǎnchá cèshì zhìjù shìfǒu dìngwèi zhǔnquè.', 'Trước khi lắp ráp hãy kiểm tra đồ gá kiểm tra đã định vị chính xác chưa.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f3c47f61-e6e4-4a7f-9bcc-944ce267a475', '夹具', 'jiājù', 'kẹp định vị, đồ kẹp (fixture)', 'Công xưởng', '气动夹具松动导致产品加工偏移。', 'Qìdòng jiājù sōngdòng dǎozhì chǎnpǐn jiāgōng piānyí.', 'Đồ kẹp khí nén bị lỏng dẫn đến việc gia công sản phẩm bị lệch.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9ad37c6f-42cc-4abb-b7c3-5efcd19981d3', '改善', 'gǎishàn', 'cải tiến (Kaizen)', 'Công xưởng', '工程部提出了多项工序改善方案。', 'Gōngchéngbù tíchū le duō xiàng gōngxù gǎishàn fāng''àn.', 'Bộ phận kỹ thuật đã đưa ra nhiều phương án cải tiến công đoạn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d6d4d15b-445c-4cdd-bf0f-f4bd66fad9cb', '产能', 'chánnéng', 'năng lực sản xuất, sản lượng tối đa', 'Công xưởng', '白班的实际产能达到了设计标准的百分之九十。', 'Báibān de shíjì chánnéng dádào le shèjì biāozhǔn de bǎifēn zhī jiǔshí.', 'Sản lượng thực tế ca ngày đã đạt chín mươi phần trăm tiêu chuẩn thiết kế.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('21e1a8e1-dc8c-4864-a69b-c71676da4d90', '瓶颈', 'píngjǐng', 'điểm nghẽn, nút thắt cổ chai (bottleneck)', 'Công xưởng', '包装工序是目前整条流水线的瓶颈。', 'Bāozhuāng gōngxù shì mùqián zhěng tiáo liúshuǐxiàn de píngjǐng.', 'Công đoạn đóng gói hiện là nút thắt cổ chai của toàn bộ dây chuyền.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e86aac94-edbf-4a51-bb85-721a6a645cb9', '工程变更', 'gōngchéng biàngēng', 'thay đổi kỹ thuật (ECN - Engineering Change Notice)', 'Công xưởng', '收到工程变更通知后，旧物料立即停止使用。', 'Shōudào gōngchéng biàngēng tōngzhī hòu, jiù wùliào lìjí tíngzhǐ shǐyòng.', 'Sau khi nhận thông báo thay đổi kỹ thuật, lập tức ngừng sử dụng vật liệu cũ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('7ff7d2a4-0c48-40f0-a518-e49dfcbc5c82', '自动化', 'zìdònghuà', 'tự động hóa', 'Công xưởng', '这条组装线已经实现了全自动化生产。', 'Zhè tiáo zǔzhuāng xiàn yǐjīng shíxiàn le quán zìdònghuà shēngchǎn.', 'Dây chuyền lắp ráp này đã thực hiện sản xuất tự động hóa hoàn toàn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5c1cc23c-9fbf-4d83-924d-0cf0f6f30230', '机械臂', 'jīxièbì', 'cánh tay robot, tay máy', 'Công xưởng', '机械臂负责抓取零件并放入模具中。', 'Jīxièbì fùzé zhuāqǔ língjiàn bìng fàng rù mójù zhōng.', 'Cánh tay robot phụ trách gắp linh kiện đặt vào trong khuôn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4fd8deb5-47d6-48dd-b618-c428e059a053', '传感器', 'chuángǎnqì', 'cảm biến (sensor)', 'Công xưởng', '如果传感器沾上灰尘，机器会频繁报警。', 'Rúguǒ chuángǎnqì zhān shàng huīchén, jīqì huì pínfán bàojǐng.', 'Nếu cảm biến dính bụi bẩn, máy móc sẽ thường xuyên báo lỗi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3bb9577f-1034-4090-a2c9-662b2cf9a9ee', '气缸', 'qìgāng', 'xi lanh khí nén', 'Công xưởng', '推料气缸的动作有点缓慢，请检查气压。', 'Tuīliào qìgāng de dòngzuò yǒudiǎn huǎnmàn, qǐng jiǎnchá qìyā.', 'Động tác của xi lanh đẩy phôi hơi chậm, hãy kiểm tra áp suất khí.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('6b051d4c-0567-4d01-8e5b-0bd655ab3e48', '电磁阀', 'diàncífá', 'van điện từ (solenoid valve)', 'Công xưởng', '电磁阀烧坏了，导致气路无法切换。', 'Diàncífá shāohuài le, dǎozhì qìlù wúfǎ qiēhuàn.', 'Van điện từ bị cháy dẫn đến đường dẫn khí không thể chuyển đổi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b9535b8f-a962-4927-9a91-02fdae933bf9', '伺服电机', 'sìfú diànjī', 'động cơ servo', 'Công xưởng', '伺服电机能够保证极高的定位精度。', 'Sìfú diànjī nénggòu bǎozhèng jí gāo de dìngwèi jīngdù.', 'Động cơ servo có thể đảm bảo độ chính xác định vị cực cao.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('30eb0258-659c-4764-9b9a-12624216b2ae', '触摸屏', 'chùmòpíng', 'màn hình cảm ứng (HMI)', 'Công xưởng', '操作人员在触摸屏上输入生产参数。', 'Cāozuò rényuán zài chùmòpíng shang shūrù shēngchǎn cānshù.', 'Nhân viên vận hành nhập các thông số sản xuất trên màn hình cảm ứng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('745c673a-48e0-415d-9f23-4683ee737912', '参数', 'cānshù', 'tham số, thông số cài đặt', 'Công xưởng', '严禁非技术人员私自修改机器参数。', 'Yánjìn fēi jìshù rényuán sīzì xiūgǎi jīqì cānshù.', 'Nghiêm cấm người không thuộc bộ phận kỹ thuật tự ý sửa đổi thông số máy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ce71b64f-a81f-4570-a2f8-0a5c4f26f13a', '复位', 'fùwèi', 'reset, đặt lại vị trí ban đầu', 'Công xưởng', '故障排除后，按下绿色按钮进行机器复位。', 'Gùzhàng páichú hòu, àn xià lǜsè ànniǔ jìnxíng jīqì fùwèi.', 'Sau khi khắc phục sự cố, nhấn nút màu xanh lá để reset máy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('5c329a51-8040-449a-adc4-371f488b9d09', '报警', 'bàojǐng', 'báo động, cảnh báo lỗi', 'Công xưởng', '设备三色灯变红并发出蜂鸣报警。', 'Shèbèi sānsèdēng biàn hóng bìng fāchū fēngmíng bàojǐng.', 'Đèn 3 màu của thiết bị chuyển sang đỏ và phát ra tiếng chuông báo động.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('27a5da66-9339-4110-84b1-89771090f626', '光电开关', 'guāngdiàn kāiguān', 'công tắc quang điện', 'Công xưởng', '光电开关检测到产品到位后才会启动压合。', 'Guāngdiàn kāiguān jiǎncè dào chǎnpǐn dào wèi hòu cái huì qǐdòng yāhé.', 'Công tắc quang điện phát hiện sản phẩm đã vào vị trí mới kích hoạt ép.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a4b9ae66-acb5-4087-a89a-438a9660bc75', '传送带', 'chuánsòngdài', 'băng chuyền tải, băng tải', 'Công xưởng', '不要把杂物堆放在传送带两旁。', 'Bú yào bǎ záwù duīfàng zài chuánsòngdài liǎngpáng.', 'Không được chất đống đồ đạc tạp nham ở hai bên băng tải.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('15bb3070-89d6-468f-b2f0-0a8e7cb44cce', '编码器', 'biānmǎqì', 'bộ mã hóa xung (encoder)', 'Công xưởng', '编码器损坏会导致电机无法准确计算旋转角度。', 'Biānmǎqì sǔnhuài huì dǎozhì diànjī wúfǎ zhǔnquè jìsuàn xuánzhuǎn jiǎodù.', 'Bộ mã hóa hỏng sẽ khiến động cơ không thể tính toán chính xác góc quay.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ca800366-3500-41f6-8686-152d45f74ae3', '导轨', 'dǎoguǐ', 'thanh trượt, ray dẫn hướng', 'Công xưởng', '定期给直线导轨加注润滑油。', 'Dìngqī gěi zhíxiàn dǎoguǐ jiāzhù rùnhuáyóu.', 'Định kỳ tra dầu bôi trơn cho thanh ray dẫn hướng tuyến tính.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('920d8e2a-c823-43da-a4d0-eab1d717f88e', '行程', 'xíngchéng', 'hành trình (chuyển động của piston, trục)', 'Công xưởng', '气缸行程调整不当会压伤产品表面。', 'Qìgāng xíngchéng tiáozhěng bùdàng huì yāshāng chǎnpǐn biǎomiàn.', 'Điều chỉnh hành trình xi lanh không đúng cách sẽ làm dập nát bề mặt sản phẩm.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0fb496f8-d4bb-44e2-bd16-c290d7b3d70f', '条形码', 'tiáoxíngmǎ', 'mã vạch (barcode)', 'Công xưởng', '每个外箱上都贴有唯一的条形码。', 'Měi ge wàixiāng shang dōu tiē yǒu wéiyī de tiáoxíngmǎ.', 'Mỗi thùng ngoài đều được dán một mã vạch duy nhất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e6033f02-7fb2-4f46-8354-07a92e0fe216', '二维码', 'èrwéimǎ', 'mã QR (QR code)', 'Công xưởng', '员工需要扫描二维码确认工单信息。', 'Yuángōng xūyào sǎomiáo èrwéimǎ quèrèn gōngdān xìnxī.', 'Công nhân cần quét mã QR để xác nhận thông tin đơn hàng sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b3fe4488-e48e-47b7-a606-dc7da79e401d', '扫描枪', 'sǎomiáoqiāng', 'súng quét mã vạch', 'Công xưởng', '这把无线扫描枪电量不足，需要充电。', 'Zhè bǎ wúxiàn sǎomiáoqiāng diànliàng bùzú, xūyào chōngdiàn.', 'Khẩu súng quét không dây này pin yếu rồi, cần phải sạc điện.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('73b5e00d-9394-42d3-a175-4310c159c72a', '扫码', 'sǎomǎ', 'quét mã', 'Công xưởng', '进站和出站时都必须严格扫码过站。', 'Jìnzhàn hé chūzhàn shí dōu bìxū yángé sǎomǎ guòzhàn.', 'Khi vào trạm và ra trạm đều phải quét mã chuyển trạm nghiêm ngặt.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('a66d9b6e-fe09-40f3-89eb-1d799174c4c1', '追溯', 'zhuīsù', 'truy xuất nguồn gốc (traceability)', 'Công xưởng', '通过MES系统可以追溯任何批次物料的供应商。', 'Tōngguò MES xìtǒng kěyǐ zhuīsù rènhé pīcì wùliào de gōngyìngshāng.', 'Thông qua hệ thống MES có thể truy xuất nhà cung cấp của bất kỳ lô vật tư nào.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('27d976fe-52b2-430e-aa21-94a2d9631171', '联网', 'liánwǎng', 'kết nối mạng', 'Công xưởng', '测试工位的电脑必须与工厂服务器联网。', 'Cèshì gōngwèi de diànnǎo bìxū yǔ gōngchǎng fúwùqì liánwǎng.', 'Máy tính ở trạm kiểm tra phải được kết nối mạng với máy chủ nhà máy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4bd7b0a2-a810-49ff-8b50-bbf956deb037', '掉线', 'diàoxiàn', 'rớt mạng, mất kết nối mạng', 'Công xưởng', '系统突然掉线，导致测试数据无法上传。', 'Xìtǒng tūrán diàoxiàn, dǎozhì cèshì shùjù wúfǎ shàngchuán.', 'Hệ thống đột nhiên rớt mạng khiến dữ liệu kiểm tra không thể tải lên.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d1807a31-49d7-442e-92e2-dd6e29fcd3c7', '账号', 'zhànghào', 'tài khoản', 'Công xưởng', '请使用你自己的工号作为登录账号。', 'Qǐng shǐyòng nǐ zìjǐ de gōnghào zuòwéi dēnglù zhànghào.', 'Vui lòng sử dụng mã số nhân viên của bạn làm tài khoản đăng nhập.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('cef2a83c-46ca-4ee3-ab48-83d1e3343d99', '密码', 'mìmǎ', 'mật khẩu', 'Công xưởng', '初次登录系统后请立即修改初始密码。', 'Chūcì dēnglù xìtǒng hòu qǐng lìjí xiūgǎi chūshǐ mìmǎ.', 'Sau khi đăng nhập hệ thống lần đầu vui lòng đổi mật khẩu ban đầu ngay.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('dd2c0127-ec66-46d5-8357-61bb48855b32', '权限', 'quánxiàn', 'quyền hạn, phân quyền truy cập', 'Công xưởng', '普通操作工没有修改配方的系统权限。', 'Pǔtōng cāozuògōng méiyǒu xiūgǎi pèifāng de xìtǒng quánxiàn.', 'Công nhân thao tác thông thường không có quyền hệ thống để sửa công thức.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('4fe338b1-10ff-401e-8b3e-e1eb327e3252', '刷卡', 'shuākǎ', 'quẹt thẻ', 'Công xưởng', '开机前先刷员工卡确认操作人员资质。', 'Kāijī qián xiān shuākǎ quèrèn cāozuò rényuán zīzhì.', 'Trước khi mở máy hãy quẹt thẻ nhân viên để xác nhận tư cách người vận hành.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('dc432769-bcaa-4123-b440-6172dea2e8a8', '录入', 'lùrù', 'nhập dữ liệu vào hệ thống', 'Công xưởng', '仓管员正在将入库数量录入ERP系统。', 'Cāngguǎnyuán zhèngzài jiāng rùkù shùliàng lùrù ERP xìtǒng.', 'Thủ kho đang nhập số lượng nhập kho vào hệ thống ERP.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c527f6b2-911c-4f59-8f3a-6ba1555ed6e7', '数据库', 'shùjùkù', 'cơ sở dữ liệu', 'Công xưởng', 'IT部门正在对生产数据库进行日常备份。', 'IT bùmén zhèngzài duì shēngchǎn shùjùkù jìnxíng rìcháng bèifèn.', 'Bộ phận CNTT đang tiến hành sao lưu định kỳ cơ sở dữ liệu sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('32ec4cec-e62b-47e4-b2df-3d831a4e29fb', '打印机', 'dǎyìnjī', 'máy in', 'Công xưởng', '条码打印机卡纸了，请更换色带和标签纸。', 'Tiáomǎ dǎyìnjī kǎzhǐ le, qǐng gēnghuàn sèdài hé biāoqiānzhǐ.', 'Máy in mã vạch bị kẹt giấy rồi, vui lòng thay ruy băng mực và giấy nhãn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('306349df-d9ab-44f5-ab56-c742bb603ec5', '标签', 'biāoqiān', 'nhãn dán, tem nhãn (label)', 'Công xưởng', '贴错标签会导致客户验货时拒收。', 'Tiē cuò biāoqiān huì dǎozhì kèhù yànhuò shí jùshōu.', 'Dán nhầm tem nhãn sẽ khiến khách hàng từ chối nhận khi nghiệm thu hàng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('eff7c460-5c26-4ede-8b59-ecd3f5cb2607', '生产计划', 'shēngchǎn jìhuà', 'kế hoạch sản xuất', 'Công xưởng', '我们必须严格按照生产计划安排作业。', 'Wǒmen bìxū yángé ànzhào shēngchǎn jìhuà ānpái zuòyè.', 'Chúng ta phải sắp xếp công việc nghiêm ngặt theo kế hoạch sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('35d0e02a-23d9-49d0-8e07-de0b13e44fc8', '排程', 'páichéng', 'lập lịch / xếp lịch sản xuất', 'Công xưởng', 'PMC部门正在调整下周的车间排程。', 'PMC bùmén zhèngzài tiáozhěng xià zhōu de chējiān páichéng.', 'Bộ phận PMC đang điều chỉnh lịch trình sản xuất của xưởng cho tuần tới.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('e127439b-0fcb-4550-a326-535828380915', '产能', 'chánnéng', 'năng lực sản xuất / công suất', 'Công xưởng', '这条产线的日产能目前达到五千件。', 'Zhè tiáo chǎnxiàn de rì chánnéng mùqián dádào wǔqiān jiàn.', 'Năng lực sản xuất hàng ngày của chuyền này hiện đạt năm nghìn sản phẩm.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('f5fcd28e-f9ad-4617-975d-3484bf57b1a8', '负荷', 'fùhè', 'phụ tải / mức tải công việc', 'Công xưởng', '设备负荷过大容易引起故障停机。', 'Shèbèi fùhè guò dà róngyì yǐnqǐ gùzhàng tíngjī.', 'Thiết bị chịu tải quá mức rất dễ gây ra sự cố dừng máy.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('08c6954e-e724-4095-9e2f-2bbc13bc54aa', '交期', 'jiāoqī', 'thời hạn giao hàng', 'Công xưởng', '客户要求把这批订单的交期提前三天。', 'Kèhù yāoqiú bǎ zhè pī dìngdān de jiāoqī tíqián sān tiān.', 'Khách hàng yêu cầu đẩy sớm thời hạn giao hàng của lô này lên ba ngày.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('808fb71e-a928-4015-8206-0f18b4657e9c', '延误', 'yánwù', 'chậm trễ / đình trệ', 'Công xưởng', '由于原材料短缺，发货时间延误了。', 'Yóuyú yuáncáiliào duǎnquē, fāhuò shíjiān yánwù le.', 'Do thiếu hụt nguyên vật liệu, thời gian xuất hàng đã bị chậm trễ.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('852b806a-2e40-445d-be07-040ba964fd27', '瓶颈', 'píngjǐng', 'điểm nghẽn / nút thắt cổ chai', 'Công xưởng', '包装工序是目前制约整条产线的瓶颈。', 'Bāozhuāng gōngxù shì mùqián zhìyuē zhěng tiáo chǎnxiàn de píngjǐng.', 'Công đoạn đóng gói hiện là điểm nghẽn kìm hãm cả dây chuyền sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('9effe1ef-f7c3-452d-ad2e-48ba7a523013', '供应链', 'gōngyìngliàn', 'chuỗi cung ứng', 'Công xưởng', '供应链中断会导致全厂停工停产。', 'Gōngyìngliàn zhōngduàn huì dǎozhì quán chǎng tínggōng tíngchǎn.', 'Chuỗi cung ứng bị gián đoạn sẽ dẫn đến việc toàn nhà máy phải ngừng sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('57d1b35d-f696-4608-ac65-704310bb60d6', '采购', 'cǎigòu', 'thu mua / mua sắm vật tư', 'Công xưởng', '采购人员正在紧急联系备用供应商。', 'Cǎigòu rényuán zhèngzài jǐnjí liánxì bèiyòng gōngyìngshāng.', 'Nhân viên thu mua đang khẩn cấp liên hệ với nhà cung cấp dự phòng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b977bb5b-fdbe-4d5e-b121-82c84096e5ce', '供应商', 'gōngyìngshāng', 'nhà cung cấp', 'Công xưởng', '我们每个季度都会评估供应商的表现。', 'Wǒmen měi ge jìdù dōu huì pínggū gōngyìngshāng de biǎoxiàn.', 'Chúng tôi đánh giá biểu hiện của các nhà cung cấp vào mỗi quý.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('83d7601a-b9e9-43db-8d76-45f87ac13bbe', '缺料', 'quēliào', 'thiếu nguyên vật liệu / thiếu linh kiện', 'Công xưởng', '三号线因为缺料暂时停止作业。', 'Sān hào xiàn yīnwèi quēliào zànshí tíngzhǐ zuòyè.', 'Dây chuyền số 3 tạm dừng làm việc do thiếu linh kiện.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ebcb3851-d882-446b-b2b2-c5cc78af92ed', '备料', 'bèiliào', 'chuẩn bị vật tư / chuẩn bị linh kiện', 'Công xưởng', '仓库需要在开工前半小时完成备料。', 'Cāngkù xūyào zài kāigōng qián bàn xiǎoshí wánchéng bèiliào.', 'Kho cần hoàn thành việc chuẩn bị vật tư trước khi bắt đầu làm việc nửa tiếng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('339de58d-a06d-4110-bbe5-c82aa331332b', '齐套', 'qítào', 'đồng bộ / đầy đủ bộ linh kiện', 'Công xưởng', '只有物料齐套后才能正式上线生产。', 'Zhǐyǒu wùliào qítào hòu cáinéng zhèngshì shàngxiàn shēngchǎn.', 'Chỉ sau khi vật tư đã đầy đủ đồng bộ mới có thể chính thức đưa lên chuyền sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ca7d1169-08df-490c-8493-920fdfa0db05', '订单', 'dìngdān', 'đơn đặt hàng', 'Công xưởng', '我们今天收到了加急的大客户订单。', 'Wǒmen jīntiān shōudào le jiājí de dà kèhù dìngdān.', 'Hôm nay chúng tôi đã nhận được một đơn đặt hàng gấp từ khách hàng lớn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('91955fdf-583d-4ed4-95d8-7cde3c2311be', '追踪', 'zhuīzōng', 'theo dõi / truy vết tiến độ', 'Công xưởng', '生管主管正在追踪紧急批次的生产进度。', 'Shēngguǎn zhǔguǎn zhèngzài zhuīzōng jǐnjí pīcì de shēngchǎn jìndù.', 'Chủ quản kế hoạch sản xuất đang theo dõi tiến độ của lô hàng khẩn cấp.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b77684e7-f4ef-40db-8336-413dcdf1618d', '早会', 'zǎohuì', 'họp đầu ca / họp giao ban sáng', 'Công xưởng', '班长每天在早会上宣导质量注意事项。', 'Bānzhǎng měitiān zài zǎohuì shang xuāndǎo zhìliàng zhùyì shìxiàng.', 'Tổ trưởng mỗi ngày đều phổ biến các lưu ý về chất lượng trong cuộc họp đầu ca.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('0bd86c4a-6e9f-47e4-aa4c-a321c341acb3', '汇报', 'huìbào', 'báo cáo công việc', 'Công xưởng', '下班前各产线要汇报当天的产出数据。', 'Xiàbān qián gè chǎnxiàn yào huìbào dāngtiān de chǎnchū shùjù.', 'Trước khi tan ca, các dây chuyền phải báo cáo số liệu sản lượng trong ngày.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('2478736b-f018-4968-a893-9e37eb3b6eba', '绩效', 'jìxiào', 'hiệu suất / thành tích làm việc (KPI)', 'Công xưởng', '公司的绩效考核与生产效率直接挂钩。', 'Gōngsī de jìxiào kǎohé yǔ shēngchǎn xiàolǜ zhíjiē guàgōu.', 'Đánh giá KPI của công ty gắn liền trực tiếp với hiệu suất sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('c54c3d4e-2c84-4e05-a87b-ccd75cd5fec7', '达成率', 'dáchénglǜ', 'tỷ lệ hoàn thành mục tiêu', 'Công xưởng', '这个月的产量达成率超过了预期目标。', 'Zhè ge yuè de chǎnliàng dáchénglǜ chāoguò le yùqī mùbiāo.', 'Tỷ lệ hoàn thành sản lượng của tháng này đã vượt mục tiêu dự kiến.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('772e56a7-42ee-4985-a3c3-cfc7deafab2a', '持续改善', 'chíxù gǎishàn', 'cải tiến liên tục (Kaizen)', 'Công xưởng', '持续改善是降低生产成本的核心方法。', 'Chíxù gǎishàn shì jiàngdī shēngchǎn chéngběn de héxīn fāngfǎ.', 'Cải tiến liên tục là phương pháp cốt lõi để cắt giảm chi phí sản xuất.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3c9e94f8-6374-40e2-a562-b2cf54ca72ec', '浪费', 'làngfèi', 'lãng phí (Muda trong Lean)', 'Công xưởng', '我们要消除搬运和等待过程中的工时浪费。', 'Wǒmen yào xiāochú bānyùn hé děngdài guòchéng zhōng de gōngshí làngfèi.', 'Chúng ta phải loại bỏ lãng phí thời gian thao tác trong quá trình vận chuyển và chờ đợi.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('67074387-85c6-4cfc-8947-1474562d6d5a', '精益生产', 'jīngyì shēngchǎn', 'sản xuất tinh gọn (Lean Manufacturing)', 'Công xưởng', '工厂正在全面推行精益生产管理模式。', 'Gōngchǎng zhèngzài quánmiàn tuīxíng jīngyì shēngchǎn guǎnlǐ móshì.', 'Nhà máy đang triển khai toàn diện mô hình quản lý sản xuất tinh gọn.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('691018e5-b771-4fe7-b7fe-3c98066ce540', '对策', 'duìcè', 'đối sách / biện pháp giải quyết', 'Công xưởng', '针对不良品偏多的问题，工程师提出了有效对策。', 'Zhēnduì bùliángpǐn piānduō de wèntí, gōngchéngshī tíchū le yǒuxiào duìcè.', 'Nhắm vào vấn đề tỷ lệ hàng lỗi cao, kỹ sư đã đưa ra đối sách hiệu quả.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('83424945-f988-4ec6-89b5-dbf3e2f0f914', '落实', 'luòshí', 'triển khai thực tế / thực hiện', 'Công xưởng', '所有整改方案必须在三天内落实到位。', 'Suǒyǒu zhěnggǎi fāng''àn bìxū zài sān tiān nèi luòshí dàowèi.', 'Tất cả phương án khắc phục phải được triển khai thực hiện đầy đủ trong vòng ba ngày.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('3f951c48-5044-43c4-aca1-0d4ad6b2c3bb', '稽核', 'jīhé', 'đánh giá kiểm tra / kiểm toán (Audit)', 'Công xưởng', '品保部今天对五金车间进行例行稽核。', 'Pǐnbǎo bù jīntiān duì wǔjīn chējiān jìnxíng lìxíng jīhé.', 'Bộ phận QA hôm nay tiến hành kiểm tra đánh giá định kỳ đối với xưởng ngũ kim.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('d32a12ff-f52c-4773-99f0-bf4db92a2d53', '验厂', 'yàn chǎng', 'đánh giá nhà máy / kiểm định nhà xưởng', 'Công xưởng', '下周有重要客户的代表团来工厂验厂。', 'Xià zhōu yǒu zhòngyào kèhù de dàibiǎotuán lái gōngchǎng yàn chǎng.', 'Tuần tới có phái đoàn của khách hàng quan trọng đến nhà máy để đánh giá xưởng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('ca29687c-06ee-47c3-82a9-145d3efccb8d', '不符合项', 'bù fúhé xiàng', 'điểm không phù hợp (NC)', 'Công xưởng', '审核员在现场发现了三项安全不符合项。', 'Shěnhéyuán zài xiànchǎng fāxiàn le sān xiàng ānquán bù fúhé xiàng.', 'Chuyên gia đánh giá đã phát hiện ba điểm không phù hợp về an toàn tại hiện trường.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('263d3d28-0d09-4d61-8a27-406753442abe', '整改', 'zhěnggǎi', 'khắc phục chấn chỉnh / chỉnh đốn', 'Công xưởng', '车间必须在期限内提交整改报告。', 'Chējiān bìxū zài qīxiàn nèi tíjiāo zhěnggǎi bàogào.', 'Nhà xưởng phải nộp báo cáo khắc phục chỉnh đốn trong thời hạn quy định.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('cebeb616-6a1e-449f-92f3-aa705b220269', '客户', 'kèhù', 'khách hàng', 'Công xưởng', '我们要严格按照客户的标准进行抽检。', 'Wǒmen yào yángé ànzhào kèhù de biāozhǔn jìnxíng chōujiǎn.', 'Chúng ta phải lấy mẫu kiểm tra nghiêm ngặt theo tiêu chuẩn của khách hàng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;
INSERT INTO public.vocabularies (id, hanzi, pinyin, meaning_vi, hsk_level, example_hanzi, example_pinyin, example_vi)
VALUES ('b470e47e-11a7-47da-9ec0-c58bf8677f97', '满意度', 'mǎnyìdù', 'mức độ hài lòng', 'Công xưởng', '提高产品品质是提升客户满意度的关键。', 'Tígāo chǎnpǐn pǐnzhì shì tíshēng kèhù mǎnyìdù de guānjiàn.', 'Nâng cao chất lượng sản phẩm là chìa khóa để nâng cao mức độ hài lòng của khách hàng.')
ON CONFLICT (hanzi, pinyin) DO UPDATE SET example_hanzi = EXCLUDED.example_hanzi, example_pinyin = EXCLUDED.example_pinyin, example_vi = EXCLUDED.example_vi;

-- Insert Lessons and Mappings
INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('47664220-faae-47c2-8f43-ee79627c7073', 'Bài 1 - Phỏng vấn và Tuyển dụng Nhân sự', 'Từ vựng và mẫu câu cơ bản dành cho quy trình ứng tuyển, phỏng vấn và thủ tục nhân sự trong nhà máy.', 'Công xưởng', 1, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '47664220-faae-47c2-8f43-ee79627c7073', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('面试', '招聘', '简历', '经验', '录用', '试用期', '劳动合同', '职位', '工资', '部门', '人事部', '离职', '培训', '技能', '入职');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('8112f79d-3293-4ad1-89b9-f989a0bac18b', 'Bài 2 - Chấm công, Ca kíp và Phúc lợi', 'Các thuật ngữ về điểm danh, phân ca, làm thêm giờ, xin phép và các chế độ đãi ngộ cho người lao động.', 'Công xưởng', 2, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '8112f79d-3293-4ad1-89b9-f989a0bac18b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('考勤', '打卡', '加班', '倒班', '白班', '夜班', '请假', '病假', '事假', '迟到', '早退', '旷工', '补贴', '奖金', '社会保险');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('58041169-4347-47e4-9899-3c32a70298bc', 'Bài 3 - Dây chuyền Sản xuất và Tổ chức Nhà xưởng', 'Các thuật ngữ cơ bản về khu vực sản xuất, quản trị chuyền và điều phối năng suất hàng ngày.', 'Công xưởng', 3, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '58041169-4347-47e4-9899-3c32a70298bc', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('车间', '生产线', '流水线', '工段', '班长', '线长', '组长', '操作工', '产能', '产量', '节拍', '交接班', '投产', '瓶颈', '停线');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5b3823f3-728e-4470-b300-533701a221ad', 'Bài 4 - Dụng cụ, Công cụ cầm tay và Vật tư tiêu hao', 'Từ vựng về các loại công cụ, thiết bị cầm tay và vật tư phổ biến sử dụng trong dây chuyền và xưởng sản xuất.', 'Công xưởng', 4, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '5b3823f3-728e-4470-b300-533701a221ad', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('螺丝刀', '扳手', '钳子', '卷尺', '万用表', '电烙铁', '胶带', '螺丝', '螺母', '美工刀', '砂纸', '润滑油', '工具箱', '抹布', '扎带');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('5a5e93b1-5370-451c-b605-3fb30b405a51', 'Bài 5 - Vận hành Máy móc và Thiết bị Sản xuất', 'Các thuật ngữ cốt lõi khi thao tác khởi động, giám sát trạng thái và xử lý lỗi vận hành máy móc thiết bị công nghiệp.', 'Công xưởng', 5, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '5a5e93b1-5370-451c-b605-3fb30b405a51', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('开机', '关机', '调试', '参数', '报警', '急停', '故障', '维修', '保养', '模具', '换线', '治具', '感应器', '复位', '运转');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('35c61c44-38d2-4ce9-87b6-4eede84125af', 'Bài 6 - Quản lý Chất lượng và Kiểm soát Sản phẩm Lỗi', 'Thuật ngữ ngành kiểm soát chất lượng (QC/QA), các loại lỗi ngoại quan, kích thước và quy trình xử lý phế phẩm.', 'Công xưởng', 6, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '35c61c44-38d2-4ce9-87b6-4eede84125af', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('检验', '良品', '不良品', '抽检', '全检', '划痕', '变形', '尺寸', '公差', '报废', '返工', '首件', '标准', '毛刺', '判定');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('0df3297b-4d8c-47b9-8032-ae09db0c7ed7', 'Bài 7 - Quản lý Kho bãi và Xuất nhập hàng', 'Các từ vựng thiết yếu về tiếp nhận nguyên vật liệu, kiểm kê, lưu trữ và xuất nhập kho thành phẩm.', 'Công xưởng', 7, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '0df3297b-4d8c-47b9-8032-ae09db0c7ed7', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('仓库', '入库', '出库', '库存', '盘点', '叉车', '托盘', '货架', '包装', '标签', '发货', '收货', '堆放', '破损', '批号');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('980a5ac0-86f6-4259-8fce-20dcdf3f70d3', 'Bài 8 - An toàn Lao động và Bảo hộ Cá nhân', 'Các từ vựng về an toàn sản xuất (EHS), phòng cháy chữa cháy và trang thiết bị bảo hộ lao động cá nhân.', 'Công xưởng', 8, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '980a5ac0-86f6-4259-8fce-20dcdf3f70d3', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('安全', '劳保用品', '安全帽', '防护眼镜', '耳塞', '口罩', '灭火器', '紧急出口', '工伤', '危险', '禁止', '漏电', '消防通道', '演练', '急救箱');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('6deb52f9-90a7-40b6-a4a3-0b688de0db10', 'Bài 9 - Kỹ thuật Cơ điện và Bảo trì Thiết bị', 'Các từ vựng chuyên ngành dành cho kỹ sư PE, ME về bảo dưỡng, chẩn đoán lỗi và sửa chữa máy móc.', 'Công xưởng', 9, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '6deb52f9-90a7-40b6-a4a3-0b688de0db10', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('工程师', '维修', '保养', '故障', '调试', '备件', '图纸', '拆卸', '安装', '参数', '精度', '磨损', '润滑油', '停机', '改造');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('df782861-38b7-4b46-923b-b159142cec1c', 'Bài 10 - Kỹ thuật Quy trình và Phát triển Sản phẩm', 'Từ vựng chuyên ngành dành cho kỹ sư quy trình (PE), kỹ sư sản phẩm (IE/NPI), sản xuất thử nghiệm và cải tiến kỹ thuật.', 'Công xưởng', 10, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT 'df782861-38b7-4b46-923b-b159142cec1c', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('工程师', '制程', '试产', '量产', '样品', '图纸', '规格', '工艺', '作业指导书', '治具', '夹具', '改善', '产能', '瓶颈', '工程变更');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('3e561952-67c9-4597-9108-2bba85e00e03', 'Bài 11 - Tự động hóa và Robot Công nghiệp', 'Từ vựng về hệ thống máy tự động hóa, cánh tay robot công nghiệp, cảm biến và điều khiển khí nén.', 'Công xưởng', 11, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '3e561952-67c9-4597-9108-2bba85e00e03', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('自动化', '机械臂', '传感器', '气缸', '电磁阀', '伺服电机', '触摸屏', '参数', '复位', '报警', '光电开关', '传送带', '编码器', '导轨', '行程');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('d3168173-a0ee-4454-997a-c9d851f6f9cd', 'Bài 12 - Hệ thống Quản lý Sản xuất MES và CNTT Nhà xưởng', 'Các thuật ngữ sử dụng hệ thống điều hành sản xuất MES, quét mã QR/mã vạch, mạng nội bộ và truy xuất nguồn gốc.', 'Công xưởng', 12, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT 'd3168173-a0ee-4454-997a-c9d851f6f9cd', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('条形码', '二维码', '扫描枪', '扫码', '追溯', '联网', '掉线', '账号', '密码', '权限', '刷卡', '录入', '数据库', '打印机', '标签');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('37c94071-2cfa-466e-90ea-954d7934829b', 'Bài 13 - Kế hoạch Sản xuất (PMC) và Quản lý Chuỗi Cung ứng', 'Từ vựng chuyên sâu về điều độ sản xuất, lập lịch trình, cân bằng tải năng lực, quản lý đơn hàng và chuỗi cung ứng vật tư.', 'Công xưởng', 13, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT '37c94071-2cfa-466e-90ea-954d7934829b', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('生产计划', '排程', '产能', '负荷', '交期', '延误', '瓶颈', '供应链', '采购', '供应商', '缺料', '备料', '齐套', '订单', '追踪');

INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system) VALUES ('b4ffa8b8-2fec-496b-9736-886b72115171', 'Bài 14 - Cải tiến Kaizen, Họp Giao ban và Đánh giá Nhà xưởng (Audit)', 'Từ vựng về điều hành họp giao ban sản xuất, đánh giá KPI, phương pháp cải tiến liên tục (Kaizen, Lean) và tiếp đón đoàn khách hàng kiểm tra đánh giá nhà máy.', 'Công xưởng', 14, true);
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order) 
SELECT 'b4ffa8b8-2fec-496b-9736-886b72115171', id, row_number() over() FROM public.vocabularies WHERE hanzi IN ('早会', '汇报', '绩效', '达成率', '持续改善', '浪费', '精益生产', '对策', '落实', '稽核', '验厂', '不符合项', '整改', '客户', '满意度');

