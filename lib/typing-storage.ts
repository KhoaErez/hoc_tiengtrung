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

