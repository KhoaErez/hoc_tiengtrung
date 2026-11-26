// Lưu trữ tiến độ học từng bài theo lộ trình (Lesson Player & Course Roadmap)
// Cho phép cả học viên đã đăng nhập lẫn người trải nghiệm nhanh khôi phục đúng bước đang học dở

export interface LessonPlayerProgressRecord {
  lessonId: string
  currentStepIndex: number
  totalSteps: number
  percent: number // 0 - 100
  completed: boolean
  accuracy?: number
  savedToSm2?: boolean
  updatedAt: string
}

const PROGRESS_STORAGE_KEY = 'chinese_notebook_course_progress_v1'
const LOCAL_SM2_BOOKMARKS_KEY = 'chinese_notebook_lesson_sm2_bookmarks_v1'

const EMPTY_PROGRESS_MAP: Record<string, LessonPlayerProgressRecord> = {}
let cachedRawJson: string | null = null
let cachedParsedMap: Record<string, LessonPlayerProgressRecord> = EMPTY_PROGRESS_MAP
const progressListeners = new Set<() => void>()

function emitProgressChange() {
  progressListeners.forEach((listener) => listener())
}

export function getCourseProgressServerSnapshot(): Record<string, LessonPlayerProgressRecord> {
  return EMPTY_PROGRESS_MAP
}

export function subscribeCourseProgress(callback: () => void): () => void {
  progressListeners.add(callback)
  if (typeof window === 'undefined') {
    return () => {
      progressListeners.delete(callback)
    }
  }
  const onStorage = (e: StorageEvent) => {
    if (!e.key || e.key === PROGRESS_STORAGE_KEY) callback()
  }
  window.addEventListener('storage', onStorage)
  return () => {
    progressListeners.delete(callback)
    window.removeEventListener('storage', onStorage)
  }
}

export function getAllCourseProgress(): Record<string, LessonPlayerProgressRecord> {
  if (typeof window === 'undefined') return EMPTY_PROGRESS_MAP
  try {
    const raw = window.localStorage.getItem(PROGRESS_STORAGE_KEY)
    if (!raw) {
      cachedRawJson = null
      cachedParsedMap = EMPTY_PROGRESS_MAP
      return EMPTY_PROGRESS_MAP
    }
    if (raw === cachedRawJson) {
      return cachedParsedMap
    }
    const parsed = JSON.parse(raw)
    if (parsed && typeof parsed === 'object') {
      cachedRawJson = raw
      cachedParsedMap = parsed as Record<string, LessonPlayerProgressRecord>
      return cachedParsedMap
    }
    return EMPTY_PROGRESS_MAP
  } catch {
    return EMPTY_PROGRESS_MAP
  }
}

export function getLessonProgress(lessonId: string): LessonPlayerProgressRecord | null {
  const all = getAllCourseProgress()
  return all[lessonId] || null
}

export function saveLessonProgress(record: Omit<LessonPlayerProgressRecord, 'updatedAt'>): LessonPlayerProgressRecord {
  const fullRecord: LessonPlayerProgressRecord = {
    ...record,
    percent: Math.max(0, Math.min(100, Math.round(record.percent))),
    updatedAt: new Date().toISOString(),
  }
  if (typeof window === 'undefined') return fullRecord

  try {
    const all = getAllCourseProgress()
    const existing = all[record.lessonId]
    // Nếu bài đã hoàn thành 100%, khi người học vào Ôn lại giữ nguyên trạng thái đã từng hoàn thành
    const merged: LessonPlayerProgressRecord =
      existing?.completed && !fullRecord.completed
        ? {
            ...fullRecord,
            completed: true,
            percent: 100,
            savedToSm2: existing.savedToSm2 || fullRecord.savedToSm2,
          }
        : {
            ...existing,
            ...fullRecord,
            savedToSm2: Boolean(fullRecord.savedToSm2 || existing?.savedToSm2),
          }

    const updatedMap = {
      ...all,
      [record.lessonId]: merged,
    }
    const serialized = JSON.stringify(updatedMap)
    cachedRawJson = serialized
    cachedParsedMap = updatedMap
    window.localStorage.setItem(PROGRESS_STORAGE_KEY, serialized)
    emitProgressChange()
    return merged
  } catch {
    return fullRecord
  }
}

export function saveLocalLessonSm2Bookmarks(
  words: { hanzi: string; pinyin: string; meaningVi: string }[]
): number {
  if (typeof window === 'undefined') return 0
  try {
    const raw = window.localStorage.getItem(LOCAL_SM2_BOOKMARKS_KEY)
    const existing: Record<string, { hanzi: string; pinyin: string; meaningVi: string; savedAt: string }> =
      raw ? JSON.parse(raw) : {}

    const now = new Date().toISOString()
    for (const word of words) {
      if (!word.hanzi) continue
      existing[word.hanzi] = {
        hanzi: word.hanzi,
        pinyin: word.pinyin,
        meaningVi: word.meaningVi,
        savedAt: now,
      }
    }
    window.localStorage.setItem(LOCAL_SM2_BOOKMARKS_KEY, JSON.stringify(existing))
    return words.length
  } catch {
    return 0
  }
}

export function getCourseCtaLabel(progress: LessonPlayerProgressRecord | null): 'Bắt đầu học' | 'Học tiếp' | 'Ôn lại' {
  if (!progress || progress.percent <= 0) return 'Bắt đầu học'
  if (progress.completed || progress.percent >= 100) return 'Ôn lại'
  return 'Học tiếp'
}

export function calculateCourseStepPercent(stepIndex: number, totalSteps: number, isSummaryStep: boolean): number {
  if (totalSteps <= 0) return 0
  if (isSummaryStep) return 100
  // Trước khi tới Summary: chia đều tiến độ thực tế trên các bước học
  return Math.min(95, Math.max(5, Math.round((stepIndex / Math.max(1, totalSteps - 1)) * 100)))
}
