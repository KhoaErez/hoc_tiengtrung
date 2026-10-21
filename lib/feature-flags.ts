/**
 * Chinese Notebook - Cấu hình Feature Flags toàn hệ thống
 * 
 * Cho phép bật/tắt các tính năng thử nghiệm hoặc đang phát triển an toàn
 * ở cả môi trường Server Components, Server Actions và Client Components.
 * 
 * CÁCH BẬT LẠI TÍNH NĂNG "LUYỆN VIẾT AI" TRONG TƯƠNG LAI:
 * 1. Cách 1: Đổi giá trị `AI_WRITING: false` thành `AI_WRITING: true` bên dưới.
 * 2. Cách 2: Thêm biến môi trường trong file `.env.local`:
 *    NEXT_PUBLIC_FEATURE_AI_WRITING="true"
 */

export const FEATURE_FLAGS = {
  /**
   * Tính năng "Luyện Viết AI" (AI Writing Correction)
   * - false: Tạm dừng phát triển, hiển thị giao diện "Sắp ra mắt (Coming Soon)", chặn gọi API AI.
   * - true: Kích hoạt toàn bộ giao diện soạn thảo bài viết, chấm điểm và góp ý ngữ pháp AI.
   */
  AI_WRITING: process.env.NEXT_PUBLIC_FEATURE_AI_WRITING === 'true' ? true : false,
} as const

export type FeatureFlagKey = keyof typeof FEATURE_FLAGS

/**
 * Kiểm tra xem một tính năng có đang được kích hoạt hay không.
 * Hoạt động đồng nhất cả trên Server và Client.
 */
export function isFeatureEnabled(flag: FeatureFlagKey): boolean {
  return FEATURE_FLAGS[flag] ?? false
}
