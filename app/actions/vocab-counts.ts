'use server'

import { updateTag, revalidatePath } from 'next/cache'
import { getCachedAllVocabCounts, AllVocabCountsResult } from '@/lib/curriculum-cache'

/**
 * Server action để client components lấy số lượng từ vựng thực tế theo thời gian thực
 */
export async function getLiveVocabCountsAction(): Promise<AllVocabCountsResult> {
  return await getCachedAllVocabCounts()
}

/**
 * Server action để Admin hoặc các luồng import/thêm/xóa từ vựng làm mới tức thì cache thống kê
 */
export async function revalidateVocabCountsAction() {
  try {
    updateTag('vocab-counts')
    updateTag('curriculum-vocab-counts')
    revalidatePath('/', 'layout')
    return { success: true }
  } catch (err: any) {
    console.error('Lỗi revalidateVocabCountsAction:', err)
    return { success: false, error: err?.message || 'Lỗi không xác định' }
  }
}
