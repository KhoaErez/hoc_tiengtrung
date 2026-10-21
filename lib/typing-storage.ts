// Quản lý lịch sử luyện đánh máy và thống kê bằng localStorage
import { TypingMode } from '@/data/typing-lessons';

export interface TypingSession {
  id: string;
  exerciseId: string;
  date: string;
  mode: TypingMode;
  level: string;
  timeSeconds: number;
  targetChars: number;
  correctChars: number;
  errorChars: number;
  accuracy: number;     // 0 - 100%
  cpm: number;          // Ký tự / phút
}

export interface TypingStats {
  totalSessions: number;
  totalCharactersTyped: number;
  bestCPM: number;
  averageAccuracy: number;
  totalPracticeTimeSeconds: number;
}

export interface TypingPreferences {
  showPinyin: boolean;
  showMeaning: boolean;
  hideHanzi: boolean;
  normalizePunctuation: boolean;
  soundEffects: boolean;
  typingSoundEnabled?: boolean;
  speechRate?: number;
  autoSpeakNext?: boolean;
  speakOnType?: boolean;
  preferredVoiceURI?: string;
}

export interface TypingSegment {
  chinese: string;
  pinyin: string;
  meaning_vi: string;
}

export interface CustomTypingExercise {
  id: string;
  title: string;
  content: string;
  createdAt: string;
  updatedAt?: string;
  charCount: number;
  lineCount: number;
  // Bổ sung Pinyin & Nghĩa tiếng Việt từ Gemini cá nhân
  segments?: TypingSegment[];
  hasPinyinAndMeaning?: boolean;
  analyzedAt?: string;
  isOutdated?: boolean;
  lastResult?: {
    accuracy: number;
    cpm: number;
    date: string;
    timeSeconds: number;
    correctChars: number;
    errorChars: number;
    missingChars: number;
  };
}

const STORAGE_KEY_HISTORY = 'typing_practice_history';
const STORAGE_KEY_PREFERENCES = 'typing_practice_preferences';
const STORAGE_KEY_CUSTOM_EXERCISES = 'typing_practice_custom_exercises';

const DEFAULT_PREFERENCES: TypingPreferences = {
  showPinyin: true,
  showMeaning: true,
  hideHanzi: false,
  normalizePunctuation: true,
  soundEffects: true,
  typingSoundEnabled: true,
  speechRate: 1,
  autoSpeakNext: true,
  speakOnType: true,
  preferredVoiceURI: '',
};

// Lấy danh sách lịch sử các lượt luyện gõ
export function getTypingHistory(): TypingSession[] {
  if (typeof window === 'undefined') return [];
  try {
    const raw = localStorage.getItem(STORAGE_KEY_HISTORY);
    if (!raw) return [];
    return JSON.parse(raw) as TypingSession[];
  } catch {
    return [];
  }
}

// Lưu một phiên luyện gõ mới
export function saveTypingSession(session: TypingSession): void {
  if (typeof window === 'undefined') return;
  try {
    const history = getTypingHistory();
    history.unshift(session);
    // Giới hạn lưu 100 phiên gần nhất
    const trimmed = history.slice(0, 100);
    localStorage.setItem(STORAGE_KEY_HISTORY, JSON.stringify(trimmed));
  } catch {
    // localStorage full
  }
}

// Tính toán các chỉ số thống kê tổng hợp từ lịch sử
export function getTypingStats(): TypingStats {
  const history = getTypingHistory();
  if (history.length === 0) {
    return {
      totalSessions: 0,
      totalCharactersTyped: 0,
      bestCPM: 0,
      averageAccuracy: 100,
      totalPracticeTimeSeconds: 0,
    };
  }

  const totalSessions = history.length;
  const totalCharactersTyped = history.reduce((acc, cur) => acc + cur.correctChars, 0);
  const bestCPM = Math.max(...history.map((h) => h.cpm), 0);
  const sumAccuracy = history.reduce((acc, cur) => acc + cur.accuracy, 0);
  const averageAccuracy = Math.round(sumAccuracy / totalSessions);
  const totalPracticeTimeSeconds = history.reduce((acc, cur) => acc + cur.timeSeconds, 0);

  return {
    totalSessions,
    totalCharactersTyped,
    bestCPM,
    averageAccuracy,
    totalPracticeTimeSeconds,
  };
}

// Lấy tùy chọn người dùng
export function getTypingPreferences(): TypingPreferences {
  if (typeof window === 'undefined') return DEFAULT_PREFERENCES;
  try {
    const raw = localStorage.getItem(STORAGE_KEY_PREFERENCES);
    if (!raw) return DEFAULT_PREFERENCES;
    return { ...DEFAULT_PREFERENCES, ...JSON.parse(raw) };
  } catch {
    return DEFAULT_PREFERENCES;
  }
}

// Lưu tùy chọn người dùng
export function saveTypingPreferences(prefs: Partial<TypingPreferences>): void {
  if (typeof window === 'undefined') return;
  try {
    const current = getTypingPreferences();
    const updated = { ...current, ...prefs };
    localStorage.setItem(STORAGE_KEY_PREFERENCES, JSON.stringify(updated));
  } catch {
    // localStorage full
  }
}

// Xóa lịch sử luyện tập
export function clearTypingHistory(): void {
  if (typeof window === 'undefined') return;
  try {
    localStorage.removeItem(STORAGE_KEY_HISTORY);
  } catch {
    //
  }
}

// === QUẢN LÝ BÀI LUYỆN ĐOẠN VĂN TỰ TẠO (CUSTOM EXERCISES) ===

// Lấy danh sách bài luyện tự tạo từ localStorage
export function getCustomExercises(): CustomTypingExercise[] {
  if (typeof window === 'undefined') return [];
  try {
    const raw = localStorage.getItem(STORAGE_KEY_CUSTOM_EXERCISES);
    if (!raw) return [];
    return JSON.parse(raw) as CustomTypingExercise[];
  } catch {
    return [];
  }
}

// Lưu bài luyện tự tạo mới hoặc cập nhật bài có sẵn
export function saveCustomExercise(data: {
  id?: string;
  title?: string;
  content: string;
  segments?: TypingSegment[];
  hasPinyinAndMeaning?: boolean;
  analyzedAt?: string;
  isOutdated?: boolean;
}): CustomTypingExercise {
  const list = getCustomExercises();
  const rawContent = data.content;
  const lines = rawContent.split(/\r\n|\r|\n/).length;
  const charCount = rawContent.length;

  let title = (data.title || '').trim();
  if (!title) {
    // Tự sinh tên từ dòng đầu tiên hoặc trích đoạn đầu
    const firstLine = rawContent.split(/\r\n|\r|\n/)[0]?.trim();
    title = firstLine ? firstLine.slice(0, 30) : `Bài luyện tự tạo ${new Date().toLocaleDateString('vi-VN')}`;
  }

  if (data.id) {
    // Cập nhật bài hiện có
    const index = list.findIndex((item) => item.id === data.id);
    if (index !== -1) {
      const existing = list[index];
      // Nếu văn bản thay đổi mà chưa phân tích lại, kiểm tra đánh dấu outdated
      const isContentChanged = existing.content !== rawContent;
      const isOutdated = data.isOutdated ?? (isContentChanged && existing.hasPinyinAndMeaning);

      const updated: CustomTypingExercise = {
        ...existing,
        title,
        content: rawContent,
        charCount,
        lineCount: lines,
        updatedAt: new Date().toISOString(),
        segments: data.segments ?? existing.segments,
        hasPinyinAndMeaning: data.hasPinyinAndMeaning ?? existing.hasPinyinAndMeaning,
        analyzedAt: data.analyzedAt ?? existing.analyzedAt,
        isOutdated,
      };
      list[index] = updated;
      try {
        localStorage.setItem(STORAGE_KEY_CUSTOM_EXERCISES, JSON.stringify(list));
      } catch {}
      return updated;
    }
  }

  // Thêm mới
  const newExercise: CustomTypingExercise = {
    id: `custom-${Date.now()}-${Math.random().toString(36).substring(2, 7)}`,
    title,
    content: rawContent,
    createdAt: new Date().toISOString(),
    charCount,
    lineCount: lines,
    segments: data.segments,
    hasPinyinAndMeaning: data.hasPinyinAndMeaning ?? !!(data.segments && data.segments.length > 0),
    analyzedAt: data.analyzedAt ?? (data.segments ? new Date().toISOString() : undefined),
    isOutdated: data.isOutdated ?? false,
  };

  list.unshift(newExercise);
  try {
    localStorage.setItem(STORAGE_KEY_CUSTOM_EXERCISES, JSON.stringify(list.slice(0, 100)));
  } catch {}
  return newExercise;
}

// Cập nhật phân đoạn Pinyin & Nghĩa cho bài tập
export function updateCustomExerciseSegments(
  id: string,
  segments: TypingSegment[]
): boolean {
  if (typeof window === 'undefined') return false;
  try {
    const list = getCustomExercises();
    const item = list.find((it) => it.id === id);
    if (!item) return false;
    item.segments = segments;
    item.hasPinyinAndMeaning = segments.length > 0;
    item.analyzedAt = new Date().toISOString();
    item.isOutdated = false;
    item.updatedAt = new Date().toISOString();
    localStorage.setItem(STORAGE_KEY_CUSTOM_EXERCISES, JSON.stringify(list));
    return true;
  } catch {
    return false;
  }
}

// Xóa bài luyện tự tạo theo ID
export function deleteCustomExercise(id: string): boolean {
  if (typeof window === 'undefined') return false;
  try {
    const list = getCustomExercises();
    const filtered = list.filter((item) => item.id !== id);
    localStorage.setItem(STORAGE_KEY_CUSTOM_EXERCISES, JSON.stringify(filtered));
    return true;
  } catch {
    return false;
  }
}

// Cập nhật tên bài luyện tự tạo
export function updateCustomExerciseTitle(id: string, newTitle: string): boolean {
  if (typeof window === 'undefined') return false;
  try {
    const list = getCustomExercises();
    const item = list.find((it) => it.id === id);
    if (!item) return false;
    item.title = newTitle.trim() || item.title;
    item.updatedAt = new Date().toISOString();
    localStorage.setItem(STORAGE_KEY_CUSTOM_EXERCISES, JSON.stringify(list));
    return true;
  } catch {
    return false;
  }
}

// Cập nhật kết quả luyện tập gần nhất
export function updateCustomExerciseResult(
  id: string,
  result: CustomTypingExercise['lastResult']
): void {
  if (typeof window === 'undefined') return;
  try {
    const list = getCustomExercises();
    const item = list.find((it) => it.id === id);
    if (!item) return;
    item.lastResult = result;
    localStorage.setItem(STORAGE_KEY_CUSTOM_EXERCISES, JSON.stringify(list));
  } catch {}
}

// === QUẢN LÝ TIẾN ĐỘ & CÂU GÕ SAI TẠI LOCALSTORAGE (CHO KHÁCH & OFFLINE CACHE) ===

export type ReviewStatus = 'need_review' | 'reviewing' | 'mastered';

export interface TypingMistakeDetail {
  index: number;
  expected: string;
  actual: string;
}

export interface TypingProgressItem {
  id?: string;
  mode: string;
  exerciseId: string;
  currentSentenceIndex: number;
  completedSentences: number;
  totalSentences: number;
  correctSentences: number;
  errorSentences: number;
  lastTypedLength: number;
  timeSpentSeconds: number;
  status: 'not_started' | 'in_progress' | 'completed';
  updatedAt: string;
}

export interface TypingMistakeItem {
  id: string;
  mode: string;
  exerciseId: string;
  sentenceIndex: number;
  sentenceZh: string;
  pinyin?: string;
  meaningVi?: string;
  lastInputZh: string;
  mistakeDetails: TypingMistakeDetail[];
  mistakeCount: number;
  reviewStatus: ReviewStatus;
  reviewCount: number;
  reviewCorrectCount: number;
  consecutiveCorrect: number;
  lastErrorAt: string;
  lastReviewedAt?: string;
}

const STORAGE_KEY_PROGRESS_LOCAL = 'typing_practice_progress_local';
const STORAGE_KEY_MISTAKES_LOCAL = 'typing_practice_mistakes_local';

// Lấy toàn bộ danh sách tiến độ local
function getAllLocalProgressMap(): Record<string, TypingProgressItem> {
  if (typeof window === 'undefined') return {};
  try {
    const raw = localStorage.getItem(STORAGE_KEY_PROGRESS_LOCAL);
    return raw ? JSON.parse(raw) : {};
  } catch {
    return {};
  }
}

// Lấy tiến độ của một bài cụ thể từ local
export function getLocalTypingProgress(mode: string, exerciseId: string): TypingProgressItem | null {
  const map = getAllLocalProgressMap();
  const key = `${mode}_${exerciseId}`;
  return map[key] || null;
}

// Lưu tiến độ vào local
export function saveLocalTypingProgress(item: TypingProgressItem): void {
  if (typeof window === 'undefined') return;
  try {
    const map = getAllLocalProgressMap();
    const key = `${item.mode}_${item.exerciseId}`;
    map[key] = {
      ...item,
      updatedAt: new Date().toISOString(),
    };
    localStorage.setItem(STORAGE_KEY_PROGRESS_LOCAL, JSON.stringify(map));
  } catch {}
}

// Đặt lại tiến độ bài về 0 trong local
export function resetLocalTypingProgress(mode: string, exerciseId: string): void {
  if (typeof window === 'undefined') return;
  try {
    const map = getAllLocalProgressMap();
    const key = `${mode}_${exerciseId}`;
    if (map[key]) {
      map[key] = {
        ...map[key],
        currentSentenceIndex: 0,
        completedSentences: 0,
        correctSentences: 0,
        errorSentences: 0,
        lastTypedLength: 0,
        status: 'not_started',
        updatedAt: new Date().toISOString(),
      };
      localStorage.setItem(STORAGE_KEY_PROGRESS_LOCAL, JSON.stringify(map));
    }
  } catch {}
}

// Lấy danh sách câu sai từ local
export function getLocalTypingMistakes(filter?: {
  mode?: string;
  reviewStatus?: ReviewStatus | 'all';
}): TypingMistakeItem[] {
  if (typeof window === 'undefined') return [];
  try {
    const raw = localStorage.getItem(STORAGE_KEY_MISTAKES_LOCAL);
    if (!raw) return [];
    let list: TypingMistakeItem[] = JSON.parse(raw);

    if (filter?.mode && filter.mode !== 'all') {
      list = list.filter((m) => m.mode === filter.mode);
    }
    if (filter?.reviewStatus && filter.reviewStatus !== 'all') {
      list = list.filter((m) => m.reviewStatus === filter.reviewStatus);
    }
    return list.sort((a, b) => new Date(b.lastErrorAt).getTime() - new Date(a.lastErrorAt).getTime());
  } catch {
    return [];
  }
}

// Ghi nhận câu sai vào local (upsert)
export function recordLocalTypingMistake(data: {
  mode: string;
  exerciseId: string;
  sentenceIndex: number;
  sentenceZh: string;
  pinyin?: string;
  meaningVi?: string;
  lastInputZh: string;
  mistakeDetails: TypingMistakeDetail[];
}): TypingMistakeItem {
  const list = getLocalTypingMistakes();
  const now = new Date().toISOString();
  const existingIdx = list.findIndex(
    (m) => m.mode === data.mode && m.exerciseId === data.exerciseId && m.sentenceIndex === data.sentenceIndex
  );

  if (existingIdx !== -1) {
    const existing = list[existingIdx];
    const updated: TypingMistakeItem = {
      ...existing,
      sentenceZh: data.sentenceZh,
      pinyin: data.pinyin || existing.pinyin,
      meaningVi: data.meaningVi || existing.meaningVi,
      lastInputZh: data.lastInputZh,
      mistakeDetails: data.mistakeDetails,
      mistakeCount: existing.mistakeCount + 1,
      reviewStatus: 'need_review',
      consecutiveCorrect: 0,
      lastErrorAt: now,
    };
    list[existingIdx] = updated;
    try {
      localStorage.setItem(STORAGE_KEY_MISTAKES_LOCAL, JSON.stringify(list));
    } catch {}
    return updated;
  }

  const newMistake: TypingMistakeItem = {
    id: `local-mistake-${Date.now()}-${Math.random().toString(36).substring(2, 6)}`,
    mode: data.mode,
    exerciseId: data.exerciseId,
    sentenceIndex: data.sentenceIndex,
    sentenceZh: data.sentenceZh,
    pinyin: data.pinyin,
    meaningVi: data.meaningVi,
    lastInputZh: data.lastInputZh,
    mistakeDetails: data.mistakeDetails,
    mistakeCount: 1,
    reviewStatus: 'need_review',
    reviewCount: 0,
    reviewCorrectCount: 0,
    consecutiveCorrect: 0,
    lastErrorAt: now,
  };

  list.unshift(newMistake);
  try {
    localStorage.setItem(STORAGE_KEY_MISTAKES_LOCAL, JSON.stringify(list.slice(0, 300)));
  } catch {}
  return newMistake;
}

// Cập nhật kết quả ôn tập trong local
export function updateLocalMistakeReview(mistakeId: string, isCorrect: boolean): TypingMistakeItem | null {
  if (typeof window === 'undefined') return null;
  try {
    const list = getLocalTypingMistakes();
    const idx = list.findIndex((m) => m.id === mistakeId);
    if (idx === -1) return null;

    const current = list[idx];
    const now = new Date().toISOString();
    const newReviewCount = current.reviewCount + 1;
    let newReviewCorrectCount = current.reviewCorrectCount;
    let newConsecutive = current.consecutiveCorrect;
    let newStatus: ReviewStatus = current.reviewStatus;

    if (isCorrect) {
      newReviewCorrectCount += 1;
      newConsecutive += 1;
      newStatus = newConsecutive >= 2 ? 'mastered' : 'reviewing';
    } else {
      newConsecutive = 0;
      newStatus = 'need_review';
    }

    const updated: TypingMistakeItem = {
      ...current,
      reviewCount: newReviewCount,
      reviewCorrectCount: newReviewCorrectCount,
      consecutiveCorrect: newConsecutive,
      reviewStatus: newStatus,
      lastReviewedAt: now,
    };

    list[idx] = updated;
    localStorage.setItem(STORAGE_KEY_MISTAKES_LOCAL, JSON.stringify(list));
    return updated;
  } catch {
    return null;
  }
}

// Đổi trạng thái câu sai thủ công trong local
export function updateLocalMistakeStatus(mistakeId: string, status: ReviewStatus): boolean {
  if (typeof window === 'undefined') return false;
  try {
    const list = getLocalTypingMistakes();
    const idx = list.findIndex((m) => m.id === mistakeId);
    if (idx === -1) return false;

    list[idx].reviewStatus = status;
    localStorage.setItem(STORAGE_KEY_MISTAKES_LOCAL, JSON.stringify(list));
    return true;
  } catch {
    return false;
  }
}

// Lấy toàn bộ dữ liệu local chuẩn bị đồng bộ lên tài khoản người dùng
export function getAllLocalTypingDataForSync(): {
  progressList: TypingProgressItem[];
  mistakeList: TypingMistakeItem[];
} {
  const map = getAllLocalProgressMap();
  const progressList = Object.values(map);
  const mistakeList = getLocalTypingMistakes();
  return { progressList, mistakeList };
}

// Xóa sạch cache local sau khi đã đồng bộ an toàn lên Cloud
export function clearSyncedLocalData(): void {
  if (typeof window === 'undefined') return;
  try {
    localStorage.removeItem(STORAGE_KEY_PROGRESS_LOCAL);
    localStorage.removeItem(STORAGE_KEY_MISTAKES_LOCAL);
  } catch {}
}

// === QUẢN LÝ BẢN NHÁP KÝ TỰ ĐANG GÕ DỞ (DEBOUNCED DRAFT PERSISTENCE) ===
const STORAGE_KEY_TYPING_DRAFTS = 'typing_practice_drafts_v1';

export interface TypingDraftItem {
  mode: string;
  exerciseId: string;
  sentenceIndex: number;
  draftText: string;
  updatedAt: string;
}

// Lưu bản nháp chuỗi ký tự đang gõ dở (với debounce phía client)
export function saveLocalTypingDraft(
  mode: string,
  exerciseId: string,
  sentenceIndex: number,
  draftText: string
): void {
  if (typeof window === 'undefined') return;
  try {
    const raw = localStorage.getItem(STORAGE_KEY_TYPING_DRAFTS);
    const drafts: Record<string, TypingDraftItem> = raw ? JSON.parse(raw) : {};
    const key = `${mode}_${exerciseId}`;
    if (!draftText || !draftText.trim()) {
      delete drafts[key];
    } else {
      drafts[key] = {
        mode,
        exerciseId,
        sentenceIndex,
        draftText,
        updatedAt: new Date().toISOString(),
      };
    }
    localStorage.setItem(STORAGE_KEY_TYPING_DRAFTS, JSON.stringify(drafts));
  } catch {}
}

// Lấy bản nháp chuỗi ký tự đang gõ dở khi khôi phục bài học
export function getLocalTypingDraft(mode: string, exerciseId: string): TypingDraftItem | null {
  if (typeof window === 'undefined') return null;
  try {
    const raw = localStorage.getItem(STORAGE_KEY_TYPING_DRAFTS);
    if (!raw) return null;
    const drafts: Record<string, TypingDraftItem> = JSON.parse(raw);
    const key = `${mode}_${exerciseId}`;
    return drafts[key] || null;
  } catch {
    return null;
  }
}

// Xóa bản nháp khi câu hoàn thành hoặc làm lại từ đầu
export function clearLocalTypingDraft(mode: string, exerciseId: string): void {
  if (typeof window === 'undefined') return;
  try {
    const raw = localStorage.getItem(STORAGE_KEY_TYPING_DRAFTS);
    if (!raw) return;
    const drafts: Record<string, TypingDraftItem> = JSON.parse(raw);
    delete drafts[`${mode}_${exerciseId}`];
    localStorage.setItem(STORAGE_KEY_TYPING_DRAFTS, JSON.stringify(drafts));
  } catch {}
}


