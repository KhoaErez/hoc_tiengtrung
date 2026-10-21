export { cn } from "cn"

/**
 * Format số với dấu phẩy phân cách hàng nghìn một cách xác định (deterministic),
 * đảm bảo chuỗi kết xuất giống hệt nhau 100% giữa Server (Node.js) và Client (Browser),
 * loại bỏ hoàn toàn nguy cơ lỗi Hydration Mismatch do khác biệt Locale.
 */
export function formatNumber(num: number | string | null | undefined): string {
  if (num === null || num === undefined) return '0'
  const str = typeof num === 'number' ? num.toString() : num
  return str.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
}
