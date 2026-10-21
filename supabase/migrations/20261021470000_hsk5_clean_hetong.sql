-- ====================================================================
-- MIGRATION: ĐỒNG BỘ 100% DỮ LIỆU BẢN GHI PHỤ CỦA TỪ [合同] (HSK 5)
-- ====================================================================

DO $$
DECLARE
  v_id uuid := 'c8be22f8-729d-44c2-b28d-4fbbdcf84efa';
BEGIN
  UPDATE public.vocabularies
  SET 
    hsk_level = 'HSK 5',
    word_type = 'Danh từ',
    pinyin = 'hétóng',
    meaning_vi = 'hợp đồng',
    example_hanzi = '新员工在正式入职之前，应当认真阅读并亲自签署用工劳动合同。',
    example_pinyin = 'Xīn yuángōng zài zhèngshì rùzhí zhīqián, yīngdāng rènzhēn yuèdú bìng qīnzì qiānshǔ yònggōng láodòng hétong.',
    example_vi = 'Nhân viên mới trước khi chính thức nhận việc, nên đọc kỹ và tự mình ký kết hợp đồng lao động tuyển dụng.'
  WHERE id = v_id;

  DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

  INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
  VALUES
    (v_id, '新员工在正式入职之前，应当认真阅读并亲自签署用工劳动合同。', 'Xīn yuángōng zài zhèngshì rùzhí zhīqián, yīngdāng rènzhēn yuèdú bìng qīnzì qiānshǔ yònggōng láodòng hétong.', 'Nhân viên mới trước khi chính thức nhận việc, nên đọc kỹ và tự mình ký kết hợp đồng lao động tuyển dụng.', 'basic', 1),
    (v_id, '在大型跨国能源工程采购招标中，双方总法律顾问对不可抗力免责条款、违约赔偿上限以及国际商事仲裁管辖权进行了长达数周的严谨合同条款会商。', 'Zài dàxíng kuàguó néngyuán gōngchéng cǎigòu zhāobiāo zhōng, shuāngfāng zǒng fǎlǜ gùwèn duì bùkěkànglì miǎnzé tiáokuǎn, wéiyuē péicháng shàngxiàn yǐjí guójì shāngshì zhòngcái guǎnxiáquán jìnxíng le cháng dá shù zhōu de yánjǐn hétong tiáokuǎn huìshāng.', 'Trong cuộc đấu thầu mua sắm công trình năng lượng xuyên quốc gia quy mô lớn, tổng cố vấn pháp lý của hai bên đã tiến hành hội đàm điều khoản hợp đồng nghiêm ngặt kéo dài nhiều tuần về các điều khoản miễn trừ do bất khả kháng, mức trần bồi thường vi phạm hợp đồng cũng như quyền tài phán trọng tài thương mại quốc tế.', 'applied', 2);

  RAISE NOTICE 'Đã đồng bộ hoàn tất bản ghi phụ của từ [合同]!';
END $$;
