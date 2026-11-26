import { Metadata } from 'next';
import { Suspense } from 'react';
import TypingClient from './typing-client';
import {
  getSystemLessonsForTypingAction,
  getTranslationExercisesAction,
  type TranslateBootstrapData,
} from './actions';

export const metadata: Metadata = {
  title: 'Luyện đánh máy - Chinese Notebook',
  description:
    'Luyện kỹ năng gõ chữ Hán bằng Pinyin trên máy tính và điện thoại. Theo dõi tốc độ gõ (CPM), độ chính xác qua các chế độ: Nghe & Gõ, Dịch Việt → Gõ Hán, Đoạn văn và Theo HSK.',
};

function getFirstParam(val: string | string[] | undefined): string {
  if (Array.isArray(val)) return val[0] || '';
  return val || '';
}

async function resolveInitialTranslateBootstrap(
  requestedLevel: number,
  requestedLessonId: string
): Promise<TranslateBootstrapData> {
  let activeLevel = requestedLevel >= 1 && requestedLevel <= 5 ? requestedLevel : 1;
  let activeLessonId = requestedLessonId;

  let [lessonsRes, exRes] = await Promise.all([
    getSystemLessonsForTypingAction(activeLevel),
    getTranslationExercisesAction({
      hskLevel: activeLevel,
      lessonId: activeLessonId || undefined,
      limit: 60,
    }),
  ]);

  let lessons = lessonsRes.success ? lessonsRes.data : [];
  let exercises = exRes.success ? exRes.data : [];
  let notice: string | undefined;

  // Nếu lessonId ban đầu rỗng/không hợp lệ -> tự động gom tất cả bài học của cấp HSK đang chọn
  if (exercises.length === 0 && activeLessonId) {
    activeLessonId = '';
    const allRes = await getTranslationExercisesAction({ hskLevel: activeLevel, limit: 60 });
    if (allRes.success && allRes.data.length > 0) {
      exercises = allRes.data;
      notice = `Bài học được chọn chưa có câu ví dụ, đã chuyển sang tổng hợp HSK ${activeLevel}.`;
    }
  }

  // Nếu cấp độ mặc định vẫn chưa có dữ liệu -> dò sang cấp độ HSK đầu tiên (1..5) có sẵn dữ liệu
  if (exercises.length === 0) {
    for (const candidateLevel of [1, 2, 3, 4, 5]) {
      if (candidateLevel === activeLevel) continue;
      const [candLessonsRes, candExRes] = await Promise.all([
        getSystemLessonsForTypingAction(candidateLevel),
        getTranslationExercisesAction({ hskLevel: candidateLevel, limit: 60 }),
      ]);
      if (candExRes.success && candExRes.data.length > 0) {
        activeLevel = candidateLevel;
        activeLessonId = '';
        lessons = candLessonsRes.success ? candLessonsRes.data : [];
        exercises = candExRes.data;
        notice = `Đã chuyển sang HSK ${candidateLevel} (cấp độ gần nhất có dữ liệu).`;
        break;
      }
    }
  }

  return {
    hskLevel: activeLevel,
    lessonId: activeLessonId,
    lessons,
    exercises,
    notice,
  };
}

export default async function TypingPage({
  searchParams,
}: {
  searchParams?: Promise<Record<string, string | string[] | undefined>>;
}) {
  const sp = (await searchParams) || {};
  const rawLevel = parseInt(getFirstParam(sp.hskLevel), 10);
  const requestedLevel = !isNaN(rawLevel) && rawLevel >= 1 && rawLevel <= 5 ? rawLevel : 1;
  const requestedLessonId = getFirstParam(sp.lessonId);

  const initialTranslateData = await resolveInitialTranslateBootstrap(
    requestedLevel,
    requestedLessonId
  );

  return (
    <div className="w-full">
      <Suspense
        fallback={
          <div className="p-10 text-center text-muted font-serif text-sm">
            Đang tải phòng luyện đánh máy...
          </div>
        }
      >
        <TypingClient initialTranslateData={initialTranslateData} />
      </Suspense>
    </div>
  );
}
