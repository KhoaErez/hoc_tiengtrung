// Test suite mô phỏng chính xác logic State Machine & Keyboard Handler của TranslateTypingMode
import { evaluateTranslationInput } from '../lib/translation-typing-eval.ts';

function createTypingStateMachine(exercises) {
  let currentIndex = 0;
  let userInput = '';
  let practiceStatus = 'typing'; // typing | checking | incorrect | correct | transitioning
  let evaluation = null;
  let isComposing = false;
  let justEndedComposition = false;
  let correctCount = 0;
  let reviewCount = 0;
  let hasRecordedMistakeForCurrent = false;
  let hasCountedCorrectForCurrent = false;

  function resetSentenceState() {
    userInput = '';
    hasRecordedMistakeForCurrent = false;
    hasCountedCorrectForCurrent = false;
    practiceStatus = 'typing';
    evaluation = null;
    isComposing = false;
    justEndedComposition = false;
  }

  function handleInputChange(newVal) {
    userInput = newVal;
    if (practiceStatus === 'incorrect' || practiceStatus === 'correct') {
      if (practiceStatus === 'correct' && hasCountedCorrectForCurrent) {
        hasCountedCorrectForCurrent = false;
        correctCount = Math.max(0, correctCount - 1);
      }
      practiceStatus = 'typing';
      evaluation = null;
    }
  }

  function handleCompositionStart() {
    isComposing = true;
    justEndedComposition = false;
  }

  function handleCompositionEnd(committedVal) {
    isComposing = false;
    userInput = committedVal;
    if (practiceStatus === 'incorrect' || practiceStatus === 'correct') {
      if (practiceStatus === 'correct' && hasCountedCorrectForCurrent) {
        hasCountedCorrectForCurrent = false;
        correctCount = Math.max(0, correctCount - 1);
      }
      practiceStatus = 'typing';
      evaluation = null;
    }
    justEndedComposition = true;
  }

  function handleCheckAnswer() {
    const currentEx = exercises[currentIndex];
    if (!currentEx) return;
    if (practiceStatus !== 'typing' && practiceStatus !== 'incorrect') return;
    const val = userInput.trim();
    if (!val) return;

    practiceStatus = 'checking';
    const evalResult = evaluateTranslationInput(val, currentEx.chineseAnswer);
    evaluation = evalResult;

    if (evalResult.isExactMatch) {
      practiceStatus = 'correct';
      if (!hasCountedCorrectForCurrent) {
        hasCountedCorrectForCurrent = true;
        correctCount += 1;
      }
    } else {
      practiceStatus = 'incorrect';
      if (!hasRecordedMistakeForCurrent) {
        hasRecordedMistakeForCurrent = true;
        reviewCount += 1;
      }
    }
  }

  function handleNextSentence(options = {}) {
    if (practiceStatus === 'transitioning') return;
    practiceStatus = 'transitioning';
    if (currentIndex < exercises.length - 1) {
      currentIndex += 1;
      resetSentenceState();
    }
  }

  function handleKeyDown(event) {
    if (event.repeat && event.key === 'Enter') {
      return 'ignored_repeat';
    }

    if (
      isComposing ||
      event.isComposing ||
      event.keyCode === 229 ||
      event.key === 'Process' ||
      justEndedComposition
    ) {
      if (justEndedComposition && event.key === 'Enter') {
        justEndedComposition = false;
      }
      return 'ignored_ime';
    }

    if (event.key === 'Enter') {
      if (practiceStatus === 'typing' || practiceStatus === 'incorrect') {
        if (userInput.trim().length > 0) {
          handleCheckAnswer();
          return 'checked';
        }
        return 'empty_no_check';
      }

      if (practiceStatus === 'correct') {
        handleNextSentence();
        return 'moved_next';
      }

      if (practiceStatus === 'checking' || practiceStatus === 'transitioning') {
        return 'busy_ignored';
      }
    }
    return 'pass';
  }

  return {
    getState: () => ({
      currentIndex,
      userInput,
      practiceStatus,
      evaluation,
      correctCount,
      reviewCount,
      isComposing,
      justEndedComposition,
      hasRecordedMistakeForCurrent,
      hasCountedCorrectForCurrent,
    }),
    handleInputChange,
    handleCompositionStart,
    handleCompositionEnd,
    handleCheckAnswer,
    handleNextSentence,
    handleKeyDown,
    resetSentenceState,
  };
}

const mockExercises = [
  { id: '1', chineseAnswer: '你好世界', vietnamesePrompt: 'Chào thế giới' },
  { id: '2', chineseAnswer: '我是学生', vietnamesePrompt: 'Tôi là học sinh' },
  { id: '3', chineseAnswer: '今天天气很好', vietnamesePrompt: 'Thời tiết hôm nay rất tốt' },
];

console.log('--- BẮT ĐẦU KIỂM THỬ REGRESSION TYPING FLOW ---');
const sm = createTypingStateMachine(mockExercises);

function assert(condition, message) {
  if (!condition) {
    console.error(`❌ THẤT BẠI: ${message}`);
    process.exit(1);
  } else {
    console.log(`✅ ĐẠT: ${message}`);
  }
}

// 1. Nhập sai, nhấn Enter -> Hiển thị sai, không chuyển câu
sm.handleInputChange('你好吗');
const res1 = sm.handleKeyDown({ key: 'Enter' });
assert(res1 === 'checked', 'Nhấn Enter lần đầu khi gõ sai');
assert(sm.getState().practiceStatus === 'incorrect', 'Trạng thái chuyển thành incorrect');
assert(sm.getState().currentIndex === 0, 'Vẫn ở câu hiện tại (index 0), không chuyển câu');
assert(sm.getState().reviewCount === 1, 'Ghi nhận 1 câu cần xem lại');

// 2. Đã sai, nhấn Enter liên tục -> Không bỏ qua câu, không lặp reviewCount
const res2a = sm.handleKeyDown({ key: 'Enter' });
assert(res2a === 'checked', 'Nhấn Enter khi đang incorrect');
assert(sm.getState().practiceStatus === 'incorrect', 'Vẫn ở trạng thái incorrect');
assert(sm.getState().currentIndex === 0, 'Vẫn ở câu 0');
assert(sm.getState().reviewCount === 1, 'reviewCount không bị tăng nhiều lần cho cùng 1 câu');

// 3. Sửa đáp án sai -> Reset trạng thái về typing, evaluation bị xóa
sm.handleInputChange('你好世');
assert(sm.getState().practiceStatus === 'typing', 'Khi chỉnh sửa, status trở về typing');
assert(sm.getState().evaluation === null, 'Evaluation cũ bị xóa bỏ');

// 4. Sửa đáp án thành đúng, nhấn Enter -> Hiển thị đúng, chưa chuyển câu
sm.handleInputChange('你好世界');
const res4 = sm.handleKeyDown({ key: 'Enter' });
assert(res4 === 'checked', 'Nhấn Enter khi sửa thành đúng');
assert(sm.getState().practiceStatus === 'correct', 'Trạng thái chuyển thành correct');
assert(sm.getState().currentIndex === 0, 'Chưa chuyển câu, giữ nguyên để xem kết quả');
assert(sm.getState().correctCount === 1, 'correctCount tăng thành 1');

// 5. Sửa câu sau khi đã đúng -> Hủy trạng thái đúng cũ, giảm correctCount
sm.handleInputChange('你好世界！');
assert(sm.getState().practiceStatus === 'typing', 'Khi sửa sau khi đúng, status về typing');
assert(sm.getState().evaluation === null, 'Evaluation bị xóa');
assert(sm.getState().correctCount === 0, 'correctCount được hoàn tác chính xác');

// 6. Nhập lại đúng, kiểm tra
sm.handleInputChange('你好世界');
sm.handleKeyDown({ key: 'Enter' });
assert(sm.getState().practiceStatus === 'correct', 'Đã correct lại');
assert(sm.getState().correctCount === 1, 'correctCount = 1');

// 7. Đã đúng, nhấn Enter lần nữa -> Chuyển sang câu kế tiếp
const res7 = sm.handleKeyDown({ key: 'Enter' });
assert(res7 === 'moved_next', 'Nhấn Enter khi đã correct');
assert(sm.getState().currentIndex === 1, 'Chuyển sang câu index 1');
assert(sm.getState().practiceStatus === 'typing', 'Câu mới ở trạng thái typing');
assert(sm.getState().userInput === '', 'Input rỗng');

// 8. Đang chọn chữ Hán bằng IME -> Enter chỉ xác nhận IME
sm.handleCompositionStart();
assert(sm.getState().isComposing === true, 'Đang composing');
const res8 = sm.handleKeyDown({ key: 'Enter', isComposing: true, keyCode: 229 });
assert(res8 === 'ignored_ime', 'Enter khi đang composing bị chặn');
assert(sm.getState().currentIndex === 1, 'Không bị chuyển câu hay kiểm tra');

// 9. IME composition kết thúc với Enter
sm.handleCompositionEnd('我是');
assert(sm.getState().justEndedComposition === true, 'justEndedComposition là true');
const res9 = sm.handleKeyDown({ key: 'Enter' });
assert(res9 === 'ignored_ime', 'Enter xác nhận IME bị tiêu thụ');
assert(sm.getState().justEndedComposition === false, 'justEndedComposition được reset ngay');

// 10. Enter sau khi IME kết thúc -> Thực hiện kiểm tra câu
const res10 = sm.handleKeyDown({ key: 'Enter' });
assert(res10 === 'checked', 'Enter tiếp theo kiểm tra đáp án bình thường');
assert(sm.getState().practiceStatus === 'incorrect', 'Chưa đủ chữ nên sai');

// 11. Nhấn giữ Enter (e.repeat) -> Không lặp
const res11 = sm.handleKeyDown({ key: 'Enter', repeat: true });
assert(res11 === 'ignored_repeat', 'Phím giữ lặp bị chặn');

// 12. Bấm "Câu tiếp theo" để bỏ qua khi sai -> Chuyển câu bình thường
sm.handleNextSentence({ isSkipManual: true });
assert(sm.getState().currentIndex === 2, 'Chuyển sang câu index 2');
assert(sm.getState().practiceStatus === 'typing', 'Reset về typing');
assert(sm.getState().correctCount === 1, 'Không ghi nhận câu bỏ qua là đúng');

// 13. Chưa nhập, bấm Câu tiếp theo -> Chuyển câu theo yêu cầu
assert(sm.getState().userInput === '', 'Input rỗng');
// Câu cuối là index 2, chuyển câu bình thường
console.log('--- TẤT CẢ 13 KỊCH BẢN KIỂM THỬ REGRESSION ĐỀU VƯỢT QUA! ---');
