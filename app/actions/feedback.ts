'use server'

import { createClient, getCachedAuthUser, getCachedUserProfile } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { z } from 'zod'

export type FeedbackCategory = 'bug' | 'feature' | 'ui_ux' | 'content' | 'other'
export type FeedbackStatus = 'new' | 'under_review' | 'in_progress' | 'resolved' | 'wont_fix'

const submitFeedbackSchema = z.object({
  category: z.enum(['bug', 'feature', 'ui_ux', 'content', 'other']),
  title: z.string().trim().min(3, 'Tiêu đề cần tối thiểu 3 ký tự').max(150, 'Tiêu đề tối đa 150 ký tự'),
  message: z.string().trim().min(5, 'Nội dung cần tối thiểu 5 ký tự').max(3000, 'Nội dung tối đa 3000 ký tự'),
  steps_to_reproduce: z.string().trim().max(2000, 'Các bước tái hiện tối đa 2000 ký tự').optional().nullable(),
  page_url: z.string().trim().max(300).optional().nullable(),
  device_info: z.string().trim().max(300).optional().nullable(),
  is_anonymous: z.boolean().default(false),
})

export type SubmitFeedbackInput = z.infer<typeof submitFeedbackSchema>

// Sanitize string helper
function sanitizeText(str: string): string {
  return str.replace(/[\u0000-\u0008\u000B-\u000C\u000E-\u001F]/g, '').trim()
}

/**
 * Check if current user has admin privileges (Được cache theo vòng đời Server Request)
 */
export async function checkIsAdmin() {
  const user = await getCachedAuthUser()

  if (!user) {
    return { isAdmin: false, user: null, profile: null }
  }

  const profile = await getCachedUserProfile(user.id)

  const configuredAdmins = process.env.ADMIN_EMAIL
    ? process.env.ADMIN_EMAIL.split(',').map((e) => e.trim().toLowerCase())
    : []

  // Ensure khoadev27@gmail.com is always authorized even if env hasn't refreshed
  const adminEmails = Array.from(new Set(['khoadev27@gmail.com', ...configuredAdmins]))

  const userEmail = (user.email || profile?.email || '').toLowerCase()
  const isAdmin = Boolean(
    profile?.is_admin === true || (userEmail && adminEmails.includes(userEmail))
  )

  return { isAdmin, user, profile }
}

/**
 * Submit feedback from user or guest
 */
export async function submitFeedbackAction(input: SubmitFeedbackInput) {
  try {
    const validated = submitFeedbackSchema.parse(input)
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    // Determine user_id
    const userId = validated.is_anonymous || !user ? null : user.id

    const sanitizedTitle = sanitizeText(validated.title)
    const sanitizedMessage = sanitizeText(validated.message)
    const sanitizedSteps = validated.steps_to_reproduce ? sanitizeText(validated.steps_to_reproduce) : null
    const sanitizedUrl = validated.page_url ? sanitizeText(validated.page_url) : null
    const sanitizedDevice = validated.device_info ? sanitizeText(validated.device_info) : null

    const { data, error } = await supabase
      .from('feedback')
      .insert({
        user_id: userId,
        category: validated.category,
        title: sanitizedTitle,
        message: sanitizedMessage,
        steps_to_reproduce: sanitizedSteps,
        page_url: sanitizedUrl,
        device_info: sanitizedDevice,
        status: 'new',
      })
      .select('id')
      .single()

    if (error) {
      console.error('Error inserting feedback:', error.message)
      return { 
        success: false, 
        error: 'Không thể lưu phản hồi vào cơ sở dữ liệu. Vui lòng thử lại sau.' 
      }
    }

    return { 
      success: true, 
      feedbackId: data.id 
    }
  } catch (err: unknown) {
    if (err instanceof z.ZodError) {
      const issue = err.issues[0]
      return { 
        success: false, 
        error: issue ? issue.message : 'Dữ liệu không hợp lệ' 
      }
    }

    console.error('Unhandled feedback error:', err)
    return { 
      success: false, 
      error: 'Đã có lỗi xảy ra trong quá trình gửi. Vui lòng thử lại.' 
    }
  }
}

/**
 * Admin action: get feedback list with stats
 */
export async function getAdminFeedbacksAction(options?: {
  status?: string
  category?: string
  search?: string
}) {
  const { isAdmin } = await checkIsAdmin()
  if (!isAdmin) {
    return { success: false, error: 'Không có quyền quản trị', data: null, stats: null }
  }

  const supabase = await createClient()

  // 1. Fetch statistics
  const { data: allFeedbacks, error: countErr } = await supabase
    .from('feedback')
    .select('id, status, category')

  if (countErr && countErr.code === 'PGRST205') {
    return {
      success: false,
      error: 'Bảng feedback chưa tồn tại trong cơ sở dữ liệu Supabase. Vui lòng chạy đoạn mã SQL kích hoạt.',
      needsMigration: true,
      data: [],
      stats: {
        total: 0,
        new: 0,
        under_review: 0,
        in_progress: 0,
        resolved: 0,
        wont_fix: 0,
        bug: 0,
        feature: 0,
        ui_ux: 0,
        content: 0,
        other: 0,
      },
    }
  }

  const stats = {
    total: allFeedbacks?.length || 0,
    new: allFeedbacks?.filter((f) => f.status === 'new').length || 0,
    under_review: allFeedbacks?.filter((f) => f.status === 'under_review').length || 0,
    in_progress: allFeedbacks?.filter((f) => f.status === 'in_progress').length || 0,
    resolved: allFeedbacks?.filter((f) => f.status === 'resolved').length || 0,
    wont_fix: allFeedbacks?.filter((f) => f.status === 'wont_fix').length || 0,
    bug: allFeedbacks?.filter((f) => f.category === 'bug').length || 0,
    feature: allFeedbacks?.filter((f) => f.category === 'feature').length || 0,
    ui_ux: allFeedbacks?.filter((f) => f.category === 'ui_ux').length || 0,
    content: allFeedbacks?.filter((f) => f.category === 'content').length || 0,
    other: allFeedbacks?.filter((f) => f.category === 'other').length || 0,
  }

  // 2. Fetch filtered list
  let query = supabase
    .from('feedback')
    .select(`
      id,
      user_id,
      category,
      title,
      message,
      steps_to_reproduce,
      page_url,
      device_info,
      status,
      admin_note,
      created_at,
      updated_at,
      profiles:user_id (
        id,
        email,
        display_name,
        avatar_url
      )
    `)
    .order('created_at', { ascending: false })

  if (options?.status && options.status !== 'all') {
    query = query.eq('status', options.status)
  }

  if (options?.category && options.category !== 'all') {
    query = query.eq('category', options.category)
  }

  if (options?.search?.trim()) {
    const s = options.search.trim()
    query = query.or(`title.ilike.%${s}%,message.ilike.%${s}%`)
  }

  const { data, error } = await query

  if (error) {
    console.error('Error fetching admin feedbacks:', error.message)
    return { success: false, error: error.message, data: null, stats }
  }

  return { success: true, error: null, data, stats }
}

/**
 * Admin action: update feedback status and admin note
 */
export async function updateFeedbackStatusAction({
  id,
  status,
  adminNote,
}: {
  id: string
  status: FeedbackStatus
  adminNote?: string | null
}) {
  const { isAdmin } = await checkIsAdmin()
  if (!isAdmin) {
    return { success: false, error: 'Không có quyền quản trị' }
  }

  const supabase = await createClient()

  const updateData: {
    status: FeedbackStatus
    updated_at: string
    admin_note?: string | null
  } = {
    status,
    updated_at: new Date().toISOString(),
  }

  if (adminNote !== undefined) {
    updateData.admin_note = adminNote ? sanitizeText(adminNote) : null
  }

  const { error } = await supabase
    .from('feedback')
    .update(updateData)
    .eq('id', id)

  if (error) {
    console.error('Error updating feedback status:', error.message)
    return { success: false, error: error.message }
  }

  revalidatePath('/admin/feedback')
  return { success: true, error: null }
}
