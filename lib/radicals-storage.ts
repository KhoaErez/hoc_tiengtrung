// Quản lý tiến độ học bộ thủ bằng localStorage
// Dùng cho cả khách và người dùng đã đăng nhập (lưu cục bộ)

const STORAGE_KEY_LEARNED = "radicals_learned";
const STORAGE_KEY_FAVORITES = "radicals_favorites";
const STORAGE_KEY_QUIZ_SCORES = "radicals_quiz_scores";

function getSet(key: string): Set<number> {
  if (typeof window === "undefined") return new Set();
  try {
    const raw = localStorage.getItem(key);
    if (!raw) return new Set();
    return new Set(JSON.parse(raw) as number[]);
  } catch {
    return new Set();
  }
}

function saveSet(key: string, set: Set<number>) {
  if (typeof window === "undefined") return;
  try {
    localStorage.setItem(key, JSON.stringify(Array.from(set)));
  } catch {
    // localStorage full or unavailable
  }
}

// === Đã học ===
export function getLearnedIds(): Set<number> {
  return getSet(STORAGE_KEY_LEARNED);
}

export function toggleLearned(id: number): boolean {
  const set = getSet(STORAGE_KEY_LEARNED);
  if (set.has(id)) {
    set.delete(id);
    saveSet(STORAGE_KEY_LEARNED, set);
    return false;
  } else {
    set.add(id);
    saveSet(STORAGE_KEY_LEARNED, set);
    return true;
  }
}

export function isLearned(id: number): boolean {
  return getSet(STORAGE_KEY_LEARNED).has(id);
}

// === Yêu thích ===
export function getFavoriteIds(): Set<number> {
  return getSet(STORAGE_KEY_FAVORITES);
}

export function toggleFavorite(id: number): boolean {
  const set = getSet(STORAGE_KEY_FAVORITES);
  if (set.has(id)) {
    set.delete(id);
    saveSet(STORAGE_KEY_FAVORITES, set);
    return false;
  } else {
    set.add(id);
    saveSet(STORAGE_KEY_FAVORITES, set);
    return true;
  }
}

export function isFavorite(id: number): boolean {
  return getSet(STORAGE_KEY_FAVORITES).has(id);
}

// === Quiz scores ===
export interface QuizScore {
  date: string;
  total: number;
  correct: number;
  type: string;
}

export function getQuizScores(): QuizScore[] {
  if (typeof window === "undefined") return [];
  try {
    const raw = localStorage.getItem(STORAGE_KEY_QUIZ_SCORES);
    if (!raw) return [];
    return JSON.parse(raw) as QuizScore[];
  } catch {
    return [];
  }
}

export function saveQuizScore(score: QuizScore) {
  if (typeof window === "undefined") return;
  try {
    const scores = getQuizScores();
    scores.push(score);
    // Chỉ lưu tối đa 50 lần gần nhất
    const trimmed = scores.slice(-50);
    localStorage.setItem(STORAGE_KEY_QUIZ_SCORES, JSON.stringify(trimmed));
  } catch {
    // localStorage full or unavailable
  }
}

// === Thống kê ===
export function getProgressStats() {
  const learned = getSet(STORAGE_KEY_LEARNED);
  const favorites = getSet(STORAGE_KEY_FAVORITES);
  return {
    learnedCount: learned.size,
    favoritesCount: favorites.size,
    totalRadicals: 214,
    percentage: Math.round((learned.size / 214) * 100),
  };
}
