import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config({ path: '.env.local' });
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function run() {
  console.log('=== ĐỐI SOÁT VÀ PHÂN BỔ 1.013 TỪ VỰNG HSK 4 VÀO 43 BÀI HỌC HỆ THỐNG ===\n');

  // 1. Lấy 43 bài học hệ thống HSK 4
  const { data: lessons, error: lErr } = await supabase
    .from('lessons')
    .select('id, lesson_number, title, subtitle')
    .eq('hsk_level', 'HSK 4')
    .eq('is_system', true)
    .order('lesson_number', { ascending: true });

  if (lErr || !lessons) {
    console.error('Lỗi khi lấy lessons:', lErr);
    return;
  }
  console.log(`Tìm thấy ${lessons.length} bài học hệ thống HSK 4.`);

  // 2. Lấy 1.013 từ vựng HSK 4
  let vocabs = [];
  let from = 0;
  const pageSize = 1000;
  while(true) {
    const { data, error } = await supabase
      .from('vocabularies')
      .select('id, hanzi, pinyin, meaning_vi, word_type')
      .eq('hsk_level', 'HSK 4')
      .range(from, from + pageSize - 1)
      .order('id');
    if (error) {
      console.error('Lỗi khi lấy vocabularies:', error);
      return;
    }
    vocabs = vocabs.concat(data);
    if (data.length < pageSize) break;
    from += pageSize;
  }
  console.log(`Tìm thấy ${vocabs.length} từ vựng HSK 4 trong DB.`);

  // 3. Lấy liên kết hiện có
  const lessonIds = lessons.map(l => l.id);
  const { data: existingLinks, error: linkErr } = await supabase
    .from('lesson_vocabularies')
    .select('lesson_id, vocabulary_id')
    .in('lesson_id', lessonIds);

  if (linkErr) {
    console.error('Lỗi khi lấy lesson_vocabularies:', linkErr);
    return;
  }

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

  // Lesson index helper (0-indexed: lesson_number - 1)
  const L = (num) => lessons[num - 1].id;

  // Polyphonic words explicit assignment
  const polyphonicAssignments = {
    '03c18985-6da9-40b9-b911-971b38cc506c': L(20), // 空 kōng (trống rỗng, rỗng không) -> Bài 20: Thời gian và Ước lượng
    'ef0effa0-ba1b-482b-8dda-e620156562a6': L(10), // 重 chóng (lại, trùng điệp) -> Bài 10: Mức độ, Phạm vi và Tần suất
  };

  // Hàm chấm điểm độ phù hợp của từ với bài học
  function scoreWordForLesson(v, lessonNum) {
    const text = `${v.hanzi} ${v.pinyin} ${v.meaning_vi || ''} ${v.word_type || ''}`.toLowerCase();
    let score = 0;

    switch(lessonNum) {
      // Nhóm Công việc / Công sở: 1, 11, 27, 39
      case 1:
        if (/công việc|văn phòng|nhiệm vụ|chức vụ|nhân viên|lãnh đạo|tác phong|kỹ năng|báo cáo|kế hoạch|chuyên môn|chuyên nghiệp|quản lý|trách nhiệm|thư ký|giám đốc|chế độ/.test(text)) score += 10;
        break;
      case 11:
        if (/phỏng vấn|tuyển dụng|hồ sơ|lý lịch|kinh nghiệm|ứng tuyển|hợp đồng|tiền lương|đãi ngộ|thử việc|nghề nghiệp|công tác|chế độ/.test(text)) score += 10;
        break;
      case 27:
        if (/kinh doanh|cạnh tranh|sự nghiệp|thị trường|lợi nhuận|doanh nghiệp|đầu tư|thương mại|đàm phán|hợp tác|thành công|thất bại/.test(text)) score += 10;
        break;
      case 39:
        if (/năng lực|trách nhiệm|chấp hành|quy chế|cơ quan|hiệu quả|cống hiến|chuyên cần|nỗ lực|hoàn thành|phấn đấu|kỷ luật/.test(text)) score += 10;
        break;

      // Nhóm Giao tiếp / Xã hội / Ứng xử: 2, 16, 37
      case 2:
        if (/bạn bè|người thân|tương tác|xã hội|quan hệ|gặp gỡ|lời khuyên|chia sẻ|giúp đỡ|thân thiết|ủng hộ|bảo đảm/.test(text)) score += 10;
        break;
      case 16:
        if (/quan điểm|đề xuất|trao đổi|xã giao|lịch sự|khéo léo|thuyết phục|bàn bạc|giải thích|từ chối|chấp nhận|đồng ý/.test(text)) score += 10;
        break;
      case 37:
        if (/hẹn hò|giao lưu|hiểu lầm|tha thứ|an ủi|chúc mừng|kết bạn|trò chuyện|tâm sự|ấn tượng|nhiệt tình/.test(text)) score += 10;
        break;

      // Nhóm Cảm xúc / Tính cách / Phẩm chất: 3, 14, 15, 38
      case 3:
        if (/cảm xúc|tâm lý|vui|buồn|tức giận|hài lòng|tự hào|xấu hổ|lo lắng|sợ hãi|phẩm chất|nghiêm túc|hài hước/.test(text)) score += 10;
        break;
      case 14:
        if (/ngoại hình|phong thái|tuổi tác|dáng vẻ|khuôn mặt|nụ cười|thanh lịch|trầm lặng|hoạt bát|dịu dàng|thông minh/.test(text)) score += 10;
        break;
      case 15:
        if (/nội tâm|động lực|kiên trì|ý chí|ước mơ|hy vọng|lạc quan|bi quan|dũng cảm|tự tin|vượt qua|thử thách/.test(text)) score += 10;
        break;
      case 38:
        if (/phẩm chất|trung thực|chăm chỉ|khiêm tốn|thành thật|rộng lượng|chu đáo|tỉ mỉ|nhẫn nại|độc lập|tinh thần/.test(text)) score += 10;
        break;

      // Nhóm Giao thông / Du lịch / Địa lý: 4, 18, 25, 35
      case 4:
        if (/phương tiện|giao thông|tàu|xe|đường|vé|trạm|bến|hướng dẫn|chuyến đi|hành lý|xuất phát|đến nơi/.test(text)) score += 10;
        break;
      case 18:
        if (/địa lý|vị trí|khoảng cách|không gian|quốc tế|miền|bản đồ|biên giới|phía|hướng|địa phương/.test(text)) score += 10;
        break;
      case 25:
        if (/du lịch|thiên nhiên|phong cảnh|danh lam|thời tiết|môi trường|rừng|núi|sông|biển|khí hậu|cây cối/.test(text)) score += 10;
        break;
      case 35:
        if (/chuyến bay|sân bay|hộ chiếu|visa|khách sạn|đặt chỗ|tham quan|hành trình|vé máy bay|định hướng/.test(text)) score += 10;
        break;

      // Nhóm Nhà cửa / Gia đình / Không gian sống: 5, 12, 22, 23, 42
      case 5:
        if (/bếp|nấu nướng|gia vị|món ăn|bữa|đời sống|sinh hoạt|thường nhật|quét dọn|lau chùi|vật dụng/.test(text)) score += 10;
        break;
      case 12:
        if (/nhà cửa|nơi ở|phòng|đồ đạc|bàn ghế|giường|tủ|chuyển nhà|thuê nhà|chủ nhà|hàng xóm|sinh hoạt/.test(text)) score += 10;
        break;
      case 22:
        if (/gia đình|bố mẹ|vợ chồng|con cái|anh em|tình yêu|hôn nhân|kết hôn|hạnh phúc|chăm sóc|tình thân/.test(text)) score += 10;
        break;
      case 23:
        if (/vệ sinh|làm đẹp|mỹ phẩm|chăm sóc|tắm|gội|quần áo|thời trang|gọn gàng|ngăn nắp/.test(text)) score += 10;
        break;
      case 42:
        if (/thể trạng|động tác|ngủ|thức|nghỉ ngơi|thói quen|vận động|sức khỏe|thể lực|mệt mỏi|phục hồi/.test(text)) score += 10;
        break;

      // Nhóm Ẩm thực / Mua sắm: 6, 13, 24, 33, 34
      case 6:
        if (/mua sắm|tiêu dùng|chọn lựa|chất lượng|giá cả|thanh toán|hóa đơn|dịch vụ|khuyến mãi|giảm giá/.test(text)) score += 10;
        break;
      case 13:
        if (/ẩm thực|hương vị|chua|cay|mặn|ngọt|đắng|ngon|thực đơn|nhà hàng|thưởng thức|đặc sản/.test(text)) score += 10;
        break;
      case 24:
        if (/chi tiêu|tiền bạc|quản lý|ngân sách|chi phí|tiết kiệm|ví tiền|tài chính|đời thường/.test(text)) score += 10;
        break;
      case 33:
        if (/món ăn|đồ uống|bia|rượu|trà|cà phê|thịt|cá|rau|trái cây|bánh|mùi vị|cảm giác/.test(text)) score += 10;
        break;
      case 34:
        if (/đi chợ|siêu thị|mua sắm|hàng hóa|đồ dùng|thương hiệu|đắt|rẻ|đổi trả|bảo hành/.test(text)) score += 10;
        break;

      // Nhóm Học tập / Học thuật / Ngôn ngữ: 17, 26, 40
      case 17:
        if (/học tập|trường học|lớp|thầy cô|kỳ nghỉ|tài liệu|rèn luyện|kỹ năng|bài tập|thi cử|điểm số/.test(text)) score += 10;
        break;
      case 26:
        if (/học thuật|tri thức|đại học|nghiên cứu|khoa học|giáo dục|học vị|luận văn|phát minh|lý thuyết/.test(text)) score += 10;
        break;
      case 40:
        if (/ngôn ngữ|tiếng trung|chữ hán|pinyin|ngữ pháp|từ vựng|đọc hiểu|dịch thuật|phát âm|luyện tập/.test(text)) score += 10;
        break;

      // Nhóm Văn hóa / Thể thao / Giải trí: 7, 28, 36
      case 7:
        if (/văn hóa|kỷ nguyên số|công nghệ|internet|máy tính|phần mềm|website|mạng xã hội|truyền thông/.test(text)) score += 10;
        break;
      case 28:
        if (/xã hội|văn hóa|giải trí|nghệ thuật|phim|kịch|ca nhạc|pháp luật|quy định|cộng đồng|lễ hội/.test(text)) score += 10;
        break;
      case 36:
        if (/thể thao|bóng đá|bóng rổ|bơi lội|chạy bộ|thi đấu|vận động viên|giải trí|sân vận động|khán giả/.test(text)) score += 10;
        break;

      // Nhóm Tư duy / Thời gian / Lập luận / Ngữ pháp: 8, 9, 10, 19, 20, 21, 29, 30, 31, 32, 41, 43
      case 8:
        if (/tư duy|phán đoán|nguyên nhân|quyết định|suy nghĩ|phân tích|sáng suốt|biện pháp|giải quyết/.test(text)) score += 10;
        break;
      case 9:
        if (/liên kết|tranh luận|mạch lạc|thuyết phục|liên từ|tuy nhiên|bởi vì|cho nên|mặc dù/.test(text)) score += 10;
        break;
      case 10:
        if (/mức độ|phạm vi|tần suất|phó từ|lượng từ|vô cùng|rất|hơi|thường xuyên|luôn luôn|đặc biệt/.test(text)) score += 10;
        break;
      case 19:
        if (/sức khỏe|thao tác|bệnh tật|triệu chứng|thuốc|bác sĩ|bệnh viện|kiểm tra|điều trị|cảm giác/.test(text)) score += 10;
        break;
      case 20:
        if (/thời gian|ước lượng|thời điểm|khoảng chừng|dự kiến|tương lai|quá khứ|hiện tại|suy đoán/.test(text)) score += 10;
        break;
      case 21:
        if (/kết nối câu|lập luận|logic|tóm lại|mặt khác|ngược lại|do đó|chính là|thực ra/.test(text)) score += 10;
        break;
      case 29:
        if (/quản lý thời gian|kế hoạch|lịch trình|khẩn trương|thư giãn|sắp xếp|đúng giờ|trễ hẹn/.test(text)) score += 10;
        break;
      case 30:
        if (/nhận xét|đánh giá|góc nhìn|quan điểm|nhận diện|đặc điểm|ấn tượng|so sánh|tiêu chuẩn/.test(text)) score += 10;
        break;
      case 31:
        if (/số lượng|phương thức|trạng thái|biến chuyển|tăng|giảm|tỷ lệ|phần trăm|toàn bộ|một phần/.test(text)) score += 10;
        break;
      case 32:
        if (/lập luận|biểu cảm|kết nối|phó từ|chặt chẽ|không những|mà còn|thà rằng|thà là/.test(text)) score += 10;
        break;
      case 41:
        if (/kế hoạch|đánh giá|thảo luận|ý kiến|phù hợp|đo lường|dự án|kết quả|mục tiêu/.test(text)) score += 10;
        break;
      case 43:
        if (/liên từ logic|cấu trúc diễn đạt|lập luận|chặt chẽ|nói chung|trừ phi|chỉ cần|bất kể/.test(text)) score += 10;
        break;
    }
    return score;
  }

  // Sắp xếp bài học theo kích thước tối đa 24 từ (để tổng 43 bài đạt đủ 1.013 từ)
  // 1013 / 43 = 23 dư 24.
  // Do đó: 24 bài sẽ có 24 từ, 19 bài sẽ có 23 từ.
  const targetSizes = lessons.map((_, idx) => (idx < 24 ? 24 : 23));

  // Gán các từ đa âm trước
  for (const [vId, targetLessonId] of Object.entries(polyphonicAssignments)) {
    const v = unassigned.find(w => w.id === vId);
    if (v) {
      lessonVocabMap.get(targetLessonId).push(v);
      assignedVocabIds.add(v.id);
    }
  }

  const remainingUnassigned = unassigned.filter(w => !assignedVocabIds.has(w.id));
  console.log(`Còn lại ${remainingUnassigned.length} từ cần phân loại ngữ nghĩa.`);

  // Thuật toán phân bổ: chấm điểm và điền vào các bài có điểm cao nhất mà chưa đầy
  for (const v of remainingUnassigned) {
    let bestLessonId = null;
    let bestScore = -1;
    let minCapacityRatio = 999;

    for (let i = 0; i < lessons.length; i++) {
      const l = lessons[i];
      const currentList = lessonVocabMap.get(l.id);
      const maxSize = targetSizes[i];

      if (currentList.length >= maxSize) continue; // Bài đã đủ dung lượng

      const s = scoreWordForLesson(v, l.lesson_number);
      const capacityRatio = currentList.length / maxSize;

      // Ưu tiên điểm ngữ nghĩa, nếu bằng điểm thì ưu tiên bài đang trống nhiều hơn
      if (s > bestScore || (s === bestScore && capacityRatio < minCapacityRatio)) {
        bestScore = s;
        bestLessonId = l.id;
        minCapacityRatio = capacityRatio;
      }
    }

    // Nếu tất cả bài đều đã chạm targetSize (không thể xảy ra vì tổng targetSize = 1013), fallback
    if (!bestLessonId) {
      // Tìm bài bất kỳ có ít từ nhất
      let minLen = 999;
      for (const l of lessons) {
        const len = lessonVocabMap.get(l.id).length;
        if (len < minLen) {
          minLen = len;
          bestLessonId = l.id;
        }
      }
    }

    lessonVocabMap.get(bestLessonId).push(v);
    assignedVocabIds.add(v.id);
  }

  // 4. Kiểm tra nghiệm thu
  console.log('\n=== KẾT QUẢ PHÂN BỔ 43 BÀI HỌC HSK 4 ===');
  let totalLinked = 0;
  lessons.forEach((l, idx) => {
    const list = lessonVocabMap.get(l.id);
    totalLinked += list.length;
    console.log(`Bài ${l.lesson_number} [${l.title.padEnd(42, ' ')}]: ${list.length} từ (Target: ${targetSizes[idx]})`);
  });

  console.log(`\nTổng số từ đã phân bổ: ${totalLinked} / ${vocabs.length}`);
  if (totalLinked !== vocabs.length) {
    console.error(`CẢNH BÁO: Số lượng từ không khớp! ${totalLinked} vs ${vocabs.length}`);
    return;
  }
  console.log('CHÚC MỪNG: 100% từ vựng HSK 4 (1.013/1.013) đã được phân bổ trọn vẹn, không một từ nào bị bỏ sót!');

  // 5. Sinh migration SQL
  console.log('\nĐang sinh file migration SQL...');
  let sql = `-- Migration: 20261022040000_hsk4_curriculum_reconciliation.sql
-- Mục đích: Đồng bộ 100% từ vựng HSK 4 (1.013 từ vựng HSK 3.0) vào 43 bài học hệ thống
-- Đảm bảo mỗi bài có 23-24 từ, chuẩn hóa ngữ nghĩa và xử lý từ đa âm (空 kōng/kòng, 重 chóng/zhòng)
-- Bảo toàn 100% tiến độ học của người dùng và các bài học cá nhân

BEGIN;

-- 1. Xóa các liên kết bài học hệ thống cũ của HSK 4 (giữ nguyên bài học do user tạo)
DELETE FROM public.lesson_vocabularies
WHERE lesson_id IN (
    SELECT id FROM public.lessons
    WHERE hsk_level = 'HSK 4' AND is_system = true
);

-- 2. Chèn 1.013 liên kết từ vựng chuẩn hóa vào 43 bài học hệ thống
INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected) VALUES
`;

  const allTuples = [];
  lessons.forEach(l => {
    const list = lessonVocabMap.get(l.id);
    list.forEach((v, idx) => {
      allTuples.push({
        lessonId: l.id,
        vocabId: v.id,
        sortOrder: idx + 1,
        comment: `Bài ${l.lesson_number}: ${v.hanzi} (${v.pinyin})`
      });
    });
  });

  const lines = allTuples.map((t, idx) => {
    const isLast = idx === allTuples.length - 1;
    const comma = isLast ? '' : ',';
    return `  ('${t.lessonId}', '${t.vocabId}', ${t.sortOrder}, true)${comma} /* ${t.comment} */`;
  });

  sql += lines.join('\n');
  sql += `
ON CONFLICT (lesson_id, vocabulary_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order,
  is_selected = EXCLUDED.is_selected;

COMMIT;
`;

  const migrationPath = 'supabase/migrations/20261022040000_hsk4_curriculum_reconciliation.sql';
  fs.writeFileSync(migrationPath, sql, 'utf8');
  console.log(`Đã ghi thành công file migration tại: ${migrationPath} (${(fs.statSync(migrationPath).size / 1024).toFixed(1)} KB)`);
}

run();
