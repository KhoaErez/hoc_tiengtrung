'use server'

import { createClient } from '@/lib/supabase/server'
import { checkIsAdmin } from './feedback'

export interface AdminNotification {
  id: string
  category: string
  title: string
  message: string
  created_at: string
  sender_name: string | null
  sender_email: string | null
  is_read: boolean
}

export interface GetAdminNotificationsResult {
  success: boolean
  error?: string
  notifications: AdminNotification[]
  unreadCount: number
}

/**
 * Lấy danh sách thông báo mới nhất cho Admin cùng tổng số chưa đọc.
 * Truy vấn tối ưu: chỉ lấy `limit` thông báo gần nhất, LEFT JOIN với
 * bảng admin_feedback_reads để phân biệt đã đọc / chưa đọc.
 */
export async function getAdminNotificationsAction(
  limit: number = 20
): Promise<GetAdminNotificationsResult> {
  const { isAdmin, user } = await checkIsAdmin()
  if (!isAdmin || !user) {
    return { success: false, error: 'Không có quyền quản trị', notifications: [], unreadCount: 0 }
  }

  const supabase = await createClient()

  // 1. Lấy danh sách feedback mới nhất cùng trạng thái đã đọc của Admin hiện tại
  const { data: feedbacks, error: feedbackError } = await supabase
    .from('feedback')
    .select(`
      id,
      category,
      title,
      message,
      created_at,
      profiles:user_id (
        display_name,
        email
      )
    `)
    .order('created_at', { ascending: false })
    .limit(limit)

  if (feedbackError) {
    console.error('Error fetching admin notifications:', feedbackError.message)
    return { success: false, error: feedbackError.message, notifications: [], unreadCount: 0 }
  }

  // 2. Lấy tập feedback_ids đã đọc của Admin này
  const { data: readRecords } = await supabase
    .from('admin_feedback_reads')
    .select('feedback_id')
    .eq('admin_id', user.id)

  const readFeedbackIds = new Set(readRecords?.map((r) => r.feedback_id) || [])

  // 3. Map thành dạng AdminNotification
  const notifications: AdminNotification[] = (feedbacks || []).map((fb: any) => ({
    id: fb.id,
    category: fb.category,
    title: fb.title,
    message: fb.message,
    created_at: fb.created_at,
    sender_name: fb.profiles?.display_name || null,
    sender_email: fb.profiles?.email || null,
    is_read: readFeedbackIds.has(fb.id),
  }))

  // 4. Tính tổng số chưa đọc (từ toàn bộ feedback, không chỉ `limit` bản ghi hiển thị)
  const { count: totalFeedbackCount } = await supabase
    .from('feedback')
    .select('id', { count: 'exact', head: true })

  const totalReadCount = readRecords?.length || 0
  const unreadCount = Math.max(0, (totalFeedbackCount || 0) - totalReadCount)

  return { success: true, notifications, unreadCount }
}

/**
 * Đánh dấu một thông báo cụ thể là đã đọc cho Admin hiện tại.
 * Sử dụng UPSERT (ON CONFLICT DO NOTHING) để chống trùng an toàn.
 */
export async function markNotificationAsReadAction(feedbackId: string) {
  const { isAdmin, user } = await checkIsAdmin()
  if (!isAdmin || !user) {
    return { success: false, error: 'Không có quyền quản trị' }
  }

  const supabase = await createClient()

  const { error } = await supabase
    .from('admin_feedback_reads')
    .upsert(
      { admin_id: user.id, feedback_id: feedbackId },
      { onConflict: 'admin_id,feedback_id' }
    )

  if (error) {
    console.error('Error marking notification as read:', error.message)
    return { success: false, error: error.message }
  }

  return { success: true }
}

/**
 * Đánh dấu TẤT CẢ thông báo là đã đọc cho Admin hiện tại.
 * Lấy tất cả feedback chưa đọc rồi bulk insert vào admin_feedback_reads.
 */
export async function markAllNotificationsAsReadAction() {
  const { isAdmin, user } = await checkIsAdmin()
  if (!isAdmin || !user) {
    return { success: false, error: 'Không có quyền quản trị' }
  }

  const supabase = await createClient()

  // 1. Lấy toàn bộ feedback IDs
  const { data: allFeedbacks, error: fetchError } = await supabase
    .from('feedback')
    .select('id')

  if (fetchError) {
    console.error('Error fetching all feedbacks for mark-all:', fetchError.message)
    return { success: false, error: fetchError.message }
  }

  if (!allFeedbacks || allFeedbacks.length === 0) {
    return { success: true }
  }

  // 2. Lấy các ID đã đọc trước đó để loại trừ
  const { data: existingReads } = await supabase
    .from('admin_feedback_reads')
    .select('feedback_id')
    .eq('admin_id', user.id)

  const alreadyReadIds = new Set(existingReads?.map((r) => r.feedback_id) || [])

  // 3. Chỉ insert các bản ghi chưa tồn tại (tránh lỗi duplicate)
  const newReads = allFeedbacks
    .filter((fb) => !alreadyReadIds.has(fb.id))
    .map((fb) => ({ admin_id: user.id, feedback_id: fb.id }))

  if (newReads.length === 0) {
    return { success: true }
  }

  const { error: insertError } = await supabase
    .from('admin_feedback_reads')
    .insert(newReads)

  if (insertError) {
    console.error('Error marking all notifications as read:', insertError.message)
    return { success: false, error: insertError.message }
  }

  return { success: true }
}
