'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { checkIsAdmin } from './feedback'

export interface AdminUserItem {
  id: string
  email: string
  display_name: string | null
  avatar_url: string | null
  created_at: string
  is_admin: boolean
}

/**
 * Check if required database tables and columns exist
 */
export async function checkDatabaseMigrationStatusAction() {
  const supabase = await createClient()

  let hasFeedbackTable = false
  let hasIsAdminColumn = false

  try {
    const { error: fbErr } = await supabase.from('feedback').select('id').limit(1)
    hasFeedbackTable = !fbErr || fbErr.code !== 'PGRST205'
  } catch {
    hasFeedbackTable = false
  }

  try {
    const { error: colErr } = await supabase.from('profiles').select('is_admin').limit(1)
    hasIsAdminColumn = !colErr || colErr.code !== '42703'
  } catch {
    hasIsAdminColumn = false
  }

  return {
    hasFeedbackTable,
    hasIsAdminColumn,
    isFullyMigrated: hasFeedbackTable && hasIsAdminColumn,
  }
}

/**
 * Fetch all user profiles for admin role management
 */
export async function getAdminUsersAction(search?: string) {
  const { isAdmin, user: currentUser } = await checkIsAdmin()
  if (!isAdmin) {
    return { success: false, error: 'Không có quyền quản trị', users: [] }
  }

  const supabase = await createClient()

  // First try querying with is_admin
  let users: AdminUserItem[] = []
  let hasIsAdminColumn = true

  let query = supabase
    .from('profiles')
    .select('id, email, display_name, avatar_url, created_at, is_admin')
    .order('created_at', { ascending: false })

  if (search?.trim()) {
    const s = search.trim()
    query = query.or(`email.ilike.%${s}%,display_name.ilike.%${s}%`)
  }

  const { data, error } = await query

  if (error && error.code === '42703') {
    // Column is_admin doesn't exist yet
    hasIsAdminColumn = false
    const fallbackQuery = supabase
      .from('profiles')
      .select('id, email, display_name, avatar_url, created_at')
      .order('created_at', { ascending: false })

    const { data: fallbackData, error: fallbackErr } = await fallbackQuery
    if (fallbackErr) {
      return { success: false, error: fallbackErr.message, users: [] }
    }

    const adminEmails = [
      ...(process.env.ADMIN_EMAIL ? process.env.ADMIN_EMAIL.split(',').map((e) => e.trim().toLowerCase()) : []),
      'khoadev27@gmail.com',
    ]

    users = (fallbackData || []).map((u) => ({
      ...u,
      is_admin: adminEmails.includes((u.email || '').toLowerCase()),
    }))
  } else if (error) {
    return { success: false, error: error.message, users: [] }
  } else {
    const adminEmails = [
      ...(process.env.ADMIN_EMAIL ? process.env.ADMIN_EMAIL.split(',').map((e) => e.trim().toLowerCase()) : []),
      'khoadev27@gmail.com',
    ]

    users = (data || []).map((u: any) => ({
      ...u,
      is_admin: Boolean(u.is_admin || adminEmails.includes((u.email || '').toLowerCase())),
    }))
  }

  return {
    success: true,
    users,
    hasIsAdminColumn,
    currentUserId: currentUser?.id,
  }
}

/**
 * Toggle admin role for a specific user profile
 */
export async function toggleUserAdminRoleAction(targetUserId: string, newIsAdmin: boolean) {
  const { isAdmin, user: currentUser } = await checkIsAdmin()
  if (!isAdmin) {
    return { success: false, error: 'Không có quyền quản trị' }
  }

  // Safety check: Cannot demote yourself
  if (currentUser?.id === targetUserId && !newIsAdmin) {
    return { success: false, error: 'Bạn không thể tự hạ quyền quản trị của chính mình.' }
  }

  const supabase = await createClient()

  // Verify column exists
  const { error: testErr } = await supabase.from('profiles').select('is_admin').limit(1)
  if (testErr && testErr.code === '42703') {
    return {
      success: false,
      error: 'Cột is_admin chưa tồn tại trong cơ sở dữ liệu Supabase. Vui lòng chạy đoạn mã SQL kích hoạt.',
      needsMigration: true,
    }
  }

  const { error } = await supabase
    .from('profiles')
    .update({ is_admin: newIsAdmin })
    .eq('id', targetUserId)

  if (error) {
    console.error('Error updating profile is_admin:', error.message)
    return { success: false, error: error.message }
  }

  revalidatePath('/admin')
  revalidatePath('/admin/feedback')
  return { success: true }
}
