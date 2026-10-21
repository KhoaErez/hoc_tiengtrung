import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function run() {
  console.log('=== ĐỐI SOÁT VÀ PHÂN BỔ 514 TỪ VỰNG HSK 3 VÀO 24 BÀI HỌC ===\n');

  // 1. Lấy 24 bài học hệ thống
  const { data: lessons } = await supabase
    .from('lessons')
    .select('id, lesson_number, title, subtitle')
    .eq('hsk_level', 'HSK 3')
    .eq('is_system', true)
    .order('lesson_number', { ascending: true });

  console.log(`Tìm thấy ${lessons.length} bài học hệ thống HSK 3.`);

  // 2. Lấy 514 từ vựng HSK 3
  const { data: vocabs } = await supabase
    .from('vocabularies')
    .select('id, hanzi, pinyin, meaning_vi, word_type')
    .eq('hsk_level', 'HSK 3')
    .order('pinyin', { ascending: true });

  console.log(`Tìm thấy ${vocabs.length} từ vựng HSK 3 trong DB.`);

  // 3. Lấy liên kết hiện có
  const lessonIds = lessons.map(l => l.id);
  const { data: existingLinks } = await supabase
    .from('lesson_vocabularies')
    .select('lesson_id, vocabulary_id')
    .in('lesson_id', lessonIds);

  const vocabById = new Map();
  vocabs.forEach(v => vocabById.set(v.id, v));

  const assignedVocabIds = new Set();
  const lessonVocabMap = new Map();
  lessons.forEach(l => lessonVocabMap.set(l.id, []));

  // Giữ lại các liên kết hiện có hợp lệ
  existingLinks.forEach(link => {
    if (vocabById.has(link.vocabulary_id) && lessonVocabMap.has(link.lesson_id)) {
      if (!assignedVocabIds.has(link.vocabulary_id)) {
        assignedVocabIds.add(link.vocabulary_id);
        lessonVocabMap.get(link.lesson_id).push(vocabById.get(link.vocabulary_id));
      }
    }
  });

  const unassigned = vocabs.filter(v => !assignedVocabIds.has(v.id));
  console.log(`Đã có ${assignedVocabIds.size} từ liên kết sẵn, còn ${unassigned.length} từ cần phân bổ.`);

  // Định nghĩa hàm phân loại ngữ nghĩa cho các từ chưa gán
  function getBestLessonId(v) {
    const text = (v.hanzi + ' ' + v.meaning_vi + ' ' + (v.word_type || '')).toLowerCase();

    // 1. Mùa, thời tiết, thế giới
    if (/mùa|xuân|hạ|thu|đông|thế giới|quốc gia|mặt trời|gió|thời tiết|địa lý|sìjì|bốn mùa|xiàtiān|chūn|dōng/.test(text)) {
      return lessons[0].id; // Bài 1
    }
    // 2. Phương hướng, vị trí, di chuyển
    if (/hướng|đông|tây|nam|bắc|trung gian|chuyển nhà|hộ chiếu|tài xế|bảo hộ|khoảng cách|bên cạnh|qua lại|xīběi|xīnán/.test(text)) {
      return lessons[1].id; // Bài 2
    }
    // 3. Con người, xưng hô, tính cách
    if (/chú|bác|dượng|đồng nghiệp|khách|tính cách|trẻ trung|dễ thương|âm thanh|người khác|ngoại hình|người|lịch sự|đáng yêu/.test(text)) {
      return lessons[2].id; // Bài 3
    }
    // 4. Nhịp sống gia đình, thói quen
    if (/đánh răng|bàn chải|tủ lạnh|thói quen|cuối tuần|dọn dẹp|quét|bầu không khí|nếp sống|gia đình|yáshuā|shuā/.test(text)) {
      return lessons[3].id; // Bài 4
    }
    // 5. Sức khỏe, cảm xúc, bệnh tật
    if (/cảm mạo|phát sốt|ho|đau|sợ hãi|kỳ lạ|khỏe mạnh|chăm sóc|lo lắng|yên tâm|khóc|sức khỏe|tâm trạng|thân thể/.test(text)) {
      return lessons[4].id; // Bài 5
    }
    // 6. Trường học, tri thức, môn học
    if (/ôn tập|toán học|lịch sử|thành tích|nâng cao|câu chuyện|thư viện|văn hóa|câu văn|bài tập|học kỳ|trang sách|ngoại ngữ|xuéqī|yè|wàiyǔ/.test(text)) {
      return lessons[5].id; // Bài 6
    }
    // 7. Công sở, giải quyết công việc
    if (/giúp đỡ|quan hệ|đồng ý|tham gia|văn phòng|trả lời|ảnh hưởng|hoàn thành|hội nghị|cố gắng|biện pháp|dự định|quyết định|nhiệm vụ|sự tình/.test(text)) {
      return lessons[6].id; // Bài 7
    }
    // 8. Mua sắm, số lượng, tiền tệ, thanh toán
    if (/thẻ tín dụng|thẻ ngân hàng|đồng|hào|tiền|vay|mượn|đổi tiền|ký|kg|tờ|tấm|đôi|chiếc|yínhángkǎ/.test(text)) {
      return lessons[7].id; // Bài 8
    }
    // 9. Hành động, công nghệ, internet
    if (/phát hiện|tin tức|hứng thú|đặt|để|đóng|tắt|quên|tiếp nhận|gửi|trang web|hòm thư|email|wǎngzhàn|yóuxiāng|yóujiàn/.test(text)) {
      return lessons[8].id; // Bài 9
    }
    // 10. Thời gian, tần suất
    if (/lâu|khắc|trước kia|sau này|hầu như|vừa mới|bao nhiêu|nửa|thông thường|kém|luôn luôn|lúc|thời gian|zhídào|cho đến khi/.test(text)) {
      return lessons[9].id; // Bài 10
    }
    // 11. Thái độ, nhận định, quan điểm
    if (/tất nhiên|phải|bằng lòng|thực ra|nên|giống nhau|nhất định|dễ dàng|chủ yếu|cho rằng|nghĩ rằng|yǐwéi|tưởng rằng/.test(text)) {
      return lessons[10].id; // Bài 11
    }
    // 12. Liên từ, ngữ pháp phức
    if (/vì|trước|nếu|hoặc|đối với|không những|mà còn|chỉ có|mới|cho nên|về việc|tuy rằng|liên từ|zhǐyào|zhǐ néng|chỉ cần/.test(text)) {
      return lessons[11].id; // Bài 12
    }
    // 13. Diện mạo, cơ thể
    if (/ngắn|chân|gầy|béo|thấp|già|chân|mũi|tai|dài|mặt|khuôn mặt|miệng|răng|đầu|mắt|bụng|lưng|yá/.test(text)) {
      return lessons[12].id; // Bài 13
    }
    // 14. Sức khỏe, sinh hoạt, phục hồi
    if (/đói|khát|chăm sóc|rèn luyện|kiểm tra|no|xin nghỉ|nghỉ phép|nằm viện|thuốc|tiêm|bệnh viện|xiūjià|zhùyuàn/.test(text)) {
      return lessons[13].id; // Bài 14
    }
    // 15. Gia đình, giao tiếp, họ hàng
    if (/hàng xóm|hoan nghênh|tin tưởng|gặp mặt|nói|kể|trò chuyện|nhiệt tình|kết hôn|dì|làm khách|khách|zuòkè|zánmen|chúng mình/.test(text)) {
      return lessons[14].id; // Bài 15
    }
    // 16. Ẩm thực, bàn ăn, đồ ngọt
    if (/đồ uống|bình|chai|gạo|chuối|ngọt|đũa|thực đơn|bánh ngọt|bát|bánh mì|đĩa|siêu thị|dưa hấu|đường|kẹo|giao hàng|wàimài|táng|xīguā/.test(text)) {
      return lessons[15].id; // Bài 16
    }
    // 17. Mua sắm, trang phục, giày dép
    if (/quà tặng|thử|giày da|ngân hàng|đơn giản|dùng|loại|váy|sơ mi|giày|áo mưa|xié|yǔyī|quần áo|áo|mua/.test(text)) {
      return lessons[16].id; // Bài 17
    }
    // 18. Nhà cửa, đồ dùng, phòng ốc
    if (/môi trường|rõ ràng|thang máy|vở|từ điển|ảnh|điều hòa|máy ảnh|vali|đèn|phòng|căn phòng|ngôi nhà|máy giặt|hộp|wūzi|xiāngzi|xǐyījī|shì/.test(text)) {
      return lessons[17].id; // Bài 18
    }
    // 19. Thiên nhiên, muôn loài, cảnh vật
    if (/mặt trăng|thu|ngựa|nổi tiếng|cây|phía tây|gấu trúc|xanh lam|cỏ|hoàng hà|xanh lá|cừu|dê|nuôi|chim|yáng|yǎng/.test(text)) {
      return lessons[18].id; // Bài 19
    }
    // 20. Giao thông, di chuyển, vé tàu xe
    if (/xe đạp|gặp|rời khỏi|trạm|đường phố|đi qua|thuyền|chiếc xe|cưỡi|cất cánh|gần|trễ giờ|chậm giờ|du khách|wǎndiǎn|yóukè/.test(text)) {
      return lessons[19].id; // Bài 20
    }
    // 21. Học tập, công sở, quản lý
    if (/hiệu trưởng|du học|lớp|giám đốc|lựa chọn|email|bảng đen|cơ hội|luyện tập|yêu cầu|đến muộn|giải quyết|khuôn viên|nhân viên|xiàoyuán|yuán|xuǎn/.test(text)) {
      return lessons[20].id; // Bài 21
    }
    // 22. Sở thích, giải trí, thể thao
    if (/âm nhạc|leo núi|tiết mục|trò chơi|trình độ|hài lòng|chú ý|ngày lễ|thi đấu|cầu lông|quần vợt|hội thao|vận động viên|dạ hội|năm mới|nhảy|khiêu vũ|yêu thích|yǔmáoqiú|wǎngqiú|yùndònghuì|yùndòngyuán|wǎnhuì|xīnnián|xǐ’ài|tiào/.test(text)) {
      return lessons[21].id; // Bài 22
    }
    // 23. Cảm xúc, nhận định, so sánh
    if (/đau lòng|cực kỳ|cần|tức giận|đặc biệt|khó|sốt ruột|so sánh|hơn|nhận được|chịu|bẩn|rất|khá|tốt nhất|trong lòng|shòu|shòudào|zāng|tǐng|zuìhǎo|xīnlǐ/.test(text)) {
      return lessons[22].id; // Bài 23
    }
    // 24. Thời gian, liên từ logic, trợ từ
    if (/bị|ngoài ra|sau đó|kết thúc|đột nhiên|ngay lập tức|vẫn|càng|căn cứ|đoạn|cuối cùng|sau này|trở lên|trở xuống|cùng nhau|chỉ là|yǐhòu|yǐshàng|yǐxià|yǐwài|yíkuàir|zhǐshì/.test(text)) {
      return lessons[23].id; // Bài 24
    }

    // Mặc định: Gán vào bài học có số lượng từ ít nhất để đảm bảo cân bằng
    let minLesson = lessons[0];
    let minCount = lessonVocabMap.get(lessons[0].id).length;
    for (const l of lessons) {
      const c = lessonVocabMap.get(l.id).length;
      if (c < minCount) {
        minCount = c;
        minLesson = l;
      }
    }
    return minLesson.id;
  }

  // Phân bổ lần lượt các từ chưa gán
  unassigned.forEach(v => {
    // Trường hợp đặc biệt: 2 từ '得' (dé vs děi)
    if (v.hanzi === '得') {
      if (v.pinyin === 'dé') {
        lessonVocabMap.get(lessons[10].id).push(v); // Bài 11 (đạt được)
      } else {
        lessonVocabMap.get(lessons[23].id).push(v); // Bài 24 (phải, cần phải)
      }
      assignedVocabIds.add(v.id);
      return;
    }

    const targetLessonId = getBestLessonId(v);
    lessonVocabMap.get(targetLessonId).push(v);
    assignedVocabIds.add(v.id);
  });

  // Cân bằng từ vựng giữa các bài để không bài nào quá nhiều hoặc quá ít (chỉ tiêu 21-22 từ/bài)
  const allEntries = Array.from(lessonVocabMap.entries());
  console.log('\nThống kê từ vựng sau phân bổ sơ bộ:');
  lessons.forEach((l, idx) => {
    const list = lessonVocabMap.get(l.id);
    console.log(`Bài ${String(idx + 1).padStart(2, ' ')}: ${list.length} từ - ${l.title}`);
  });

  // Điều hòa cân bằng các bài > 23 từ sang các bài < 21 từ
  let rebalanced = true;
  while (rebalanced) {
    rebalanced = false;
    let maxLesson = null;
    let minLesson = null;
    let maxLen = 0;
    let minLen = 999;

    for (const [lId, list] of lessonVocabMap.entries()) {
      if (list.length > maxLen) {
        maxLen = list.length;
        maxLesson = lId;
      }
      if (list.length < minLen) {
        minLen = list.length;
        minLesson = lId;
      }
    }

    if (maxLen > 22 && minLen < 21) {
      // Chuyển 1 từ trung tính từ maxLesson sang minLesson
      const fromList = lessonVocabMap.get(maxLesson);
      const toList = lessonVocabMap.get(minLesson);
      const movedVocab = fromList.pop();
      toList.push(movedVocab);
      rebalanced = true;
    }
  }

  console.log('\nThống kê từ vựng sau điều hòa cân bằng chuẩn mực (21-22 từ/bài):');
  let totalAssigned = 0;
  const distinctCheck = new Set();
  lessons.forEach((l, idx) => {
    const list = lessonVocabMap.get(l.id);
    totalAssigned += list.length;
    list.forEach(v => distinctCheck.add(v.id));
    console.log(`Bài ${String(idx + 1).padStart(2, ' ')}: ${list.length} từ - ${l.title}`);
  });

  console.log(`\nTổng số từ được gán: ${totalAssigned} / 514`);
  console.log(`Tổng số từ duy nhất: ${distinctCheck.size} / 514`);

  if (distinctCheck.size !== 514 || totalAssigned !== 514) {
    console.error('LỖI KIỂM KÊ! Số lượng không khớp 514.');
    return;
  }

  console.log('✅ KIỂM KÊ CHUẨN XÁC 100%! Bắt đầu sinh file SQL Migration...');

  // Sinh nội dung SQL
  let sql = `-- ====================================================================
-- MIGRATION: ĐỒNG BỘ TOÀN DIỆN LỘ TRÌNH 24 BÀI HỌC HSK 3 (514 TỪ CHUẨN HSK 3.0)
-- 1. Cập nhật 24 bài học hệ thống hiện có vào public.lessons
-- 2. Liên kết toàn bộ 514 từ vựng HSK 3 vào bài học qua lesson_vocabularies (21-22 từ/bài)
-- Tuyệt đối bảo toàn 100% tiến độ người dùng trong user_vocabularies!
-- ====================================================================

DO $$
BEGIN
  -- ------------------------------------------------------------------
  -- BƯỚC 1: CẬP NHẬT HOẶC CHÈN 24 BÀI HỌC HSK 3 VÀO PUBLIC.LESSONS
  -- ------------------------------------------------------------------
`;

  lessons.forEach(l => {
    const escapedTitle = l.title.replace(/'/g, "''");
    const escapedSubtitle = (l.subtitle || '').replace(/'/g, "''");
    sql += `  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('${l.id}', '${escapedTitle}', '${escapedSubtitle}', 'HSK 3', ${l.lesson_number}, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

`;
  });

  const lessonIdList = lessons.map(l => `'${l.id}'`).join(', ');

  sql += `  -- ------------------------------------------------------------------
  -- BƯỚC 2: DỌN DẸP VÀ TÁI LIÊN KẾT BẢNG NỐI LESSON_VOCABULARIES CHO 24 BÀI HSK 3
  -- ------------------------------------------------------------------
  DELETE FROM public.lesson_vocabularies
  WHERE lesson_id IN (${lessonIdList});

`;

  lessons.forEach((l, idx) => {
    const list = lessonVocabMap.get(l.id);
    const escapedTitle = l.title.replace(/'/g, "''");
    sql += `  -- Bài ${l.lesson_number}: ${escapedTitle} (${list.length} từ)\n`;

    // Tách riêng từ đa âm '得' nếu có
    const normalWords = list.filter(v => v.hanzi !== '得');
    const deWords = list.filter(v => v.hanzi === '得');

    if (normalWords.length > 0) {
      const quotedWords = normalWords.map(w => `'${w.hanzi.replace(/'/g, "''")}'`).join(', ');
      sql += `  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '${l.id}',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi IN (${quotedWords});

`;
    }

    if (deWords.length > 0) {
      deWords.forEach(sp => {
        sql += `  -- Từ đặc biệt phân biệt đa âm [得] (${sp.pinyin})
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '${l.id}',
    v.id,
    99,
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 3' AND v.hanzi = '得' AND v.pinyin = '${sp.pinyin}';

`;
      });
    }
  });

  sql += `  RAISE NOTICE 'Hoàn tất đồng bộ 24 bài học HSK 3 với 514 từ vựng chuẩn HSK 3.0!';
END $$;
`;

  const outPath = 'supabase/migrations/20261022030000_hsk3_curriculum_reconciliation.sql';
  fs.writeFileSync(outPath, sql, 'utf8');
  console.log(`Đã xuất thành công file migration: ${outPath}`);
}

run();
