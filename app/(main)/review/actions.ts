'use server'

import { createClient, getCachedAuthUser } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

/**
 * Cập nhật trạng thái ôn tập theo thuật toán Spaced Repetition (SRS)
 * Tối ưu hóa:
 * - Chấp nhận currentInterval và currentEase từ client nếu có để loại bỏ 1 lượt SELECT thừa.
 * - Không gọi revalidatePath trên từng thẻ đơn lẻ (vốn làm Next.js re-render lại toàn bộ RSC của trang chủ và phòng ôn tập 10+ lần).
 */
export async function updateReviewStatusAction(
  userVocabId: string, 
  isRemembered: boolean,
  currentInterval?: number,
  currentEase?: number
) {
  const [supabase, user] = await Promise.all([
    createClient(),
    getCachedAuthUser(),
  ])
  if (!user) throw new Error('Unauthorized')
  
  let baseInterval: number
  let baseEase: number

  // Nếu client chưa truyền sẵn thông số SRS, truy vấn từ database
  if (typeof currentInterval !== 'number' || typeof currentEase !== 'number') {
    const { data: current, error: fetchErr } = await supabase
      .from('user_vocabularies')
      .select('review_interval_days, ease_factor')
      .eq('id', userVocabId)
      .eq('user_id', user.id)
      .single()
      
    if (fetchErr || !current) throw new Error('Không tìm thấy dữ liệu từ vựng ôn tập')
    baseInterval = current.review_interval_days ?? 0
    baseEase = current.ease_factor ?? 2.5
  } else {
    baseInterval = currentInterval
    baseEase = currentEase
  }
  
  let newInterval = baseInterval
  let newEase = baseEase
  
  if (isRemembered) {
    if (newInterval === 0) newInterval = 1
    else if (newInterval === 1) newInterval = 3
    else newInterval = Math.round(newInterval * newEase)
    
    newEase = newEase + 0.1
  } else {
    newInterval = 1
    newEase = Math.max(1.3, newEase - 0.2)
  }
  
  const nextReviewDate = new Date()
  nextReviewDate.setDate(nextReviewDate.getDate() + newInterval)
  
  const { error: updateErr } = await supabase
    .from('user_vocabularies')
    .update({
      review_interval_days: newInterval,
      ease_factor: newEase,
      next_review_at: nextReviewDate.toISOString(),
      status: 'reviewing'
    })
    .eq('id', userVocabId)
    .eq('user_id', user.id)
    
  if (updateErr) throw updateErr

  return { success: true, newInterval, nextReviewDate: nextReviewDate.toISOString() }
}

/**
 * Đánh dấu từ vựng đã học trong chế độ học bài học
 * Tối ưu hóa:
 * - Thực hiện ghi trực tiếp vào Supabase
 * - Không gọi revalidatePath trên từng thẻ đơn lẻ để phản hồi siêu tốc (< 200ms)
 */
export async function markVocabLearnedAction(vocabularyId: string, isRemembered: boolean) {
  const [supabase, user] = await Promise.all([
    createClient(),
    getCachedAuthUser(),
  ])
  if (!user) throw new Error('Unauthorized')
  
  // Kiểm tra xem người dùng đã có từ vựng này trong kho chưa
  const { data: existing, error: selectErr } = await supabase
    .from('user_vocabularies')
    .select('id, review_interval_days, ease_factor')
    .eq('vocabulary_id', vocabularyId)
    .eq('user_id', user.id)
    .maybeSingle()
    
  if (selectErr) throw selectErr

  let newInterval = existing?.review_interval_days ?? 0
  let newEase = existing?.ease_factor ?? 2.5
  
  if (isRemembered) {
    if (newInterval === 0) newInterval = 1
    else if (newInterval === 1) newInterval = 3
    else newInterval = Math.round(newInterval * newEase)
    
    newEase = newEase + 0.1
  } else {
    newInterval = 1
    newEase = Math.max(1.3, newEase - 0.2)
  }
  
  const nextReviewDate = new Date()
  nextReviewDate.setDate(nextReviewDate.getDate() + newInterval)
  
  if (existing) {
    const { error: updateErr } = await supabase
      .from('user_vocabularies')
      .update({
        review_interval_days: newInterval,
        ease_factor: newEase,
        next_review_at: nextReviewDate.toISOString(),
        status: isRemembered ? 'memorized' : 'reviewing'
      })
      .eq('id', existing.id)
    if (updateErr) throw updateErr
  } else {
    const { error: insertErr } = await supabase
      .from('user_vocabularies')
      .insert({
        user_id: user.id,
        vocabulary_id: vocabularyId,
        review_interval_days: newInterval,
        ease_factor: newEase,
        next_review_at: nextReviewDate.toISOString(),
        status: isRemembered ? 'memorized' : 'learning'
      })
    if (insertErr) throw insertErr
  }
  
  return { success: true }
}

/**
 * Đồng bộ làm mới cache sau khi người dùng HOÀN THÀNH TOÀN BỘ phiên học
 * Chỉ gọi 1 lần duy nhất khi kết thúc phiên để không làm chậm trải nghiệm lật thẻ từng từ
 */
export async function revalidateReviewSessionAction() {
  revalidatePath('/review')
  revalidatePath('/')
  revalidatePath('/lessons')
  revalidatePath('/topics')
}
