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
  last_seen_at?: string | null
}

export interface AdminStats {
  totalUsers: number
  adminCount: number
  regularCount: number
  active24hCount: number
  onlineFallbackCount: number
}

export interface AdminPagination {
  page: number
  pageSize: number
  totalItems: number
  totalPages: number
}

export interface GetAdminUsersParams {
  page?: number
  pageSize?: number
  search?: string
}

export interface GetAdminUsersResponse {
  success: boolean
  error?: string
  users: AdminUserItem[]
  stats: AdminStats
  pagination: AdminPagination
  hasIsAdminColumn: boolean
  hasLastSeenAtColumn: boolean
  currentUserId?: string
}

/**
 * Check if required database tables and columns exist
 */
export async function checkDatabaseMigrationStatusAction() {
  const supabase = await createClient()

  let hasFeedbackTable = false
  let hasIsAdminColumn = false
  let hasLastSeenAtColumn = false

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

  try {
    const { error: seenErr } = await supabase.from('profiles').select('last_seen_at').limit(1)
    hasLastSeenAtColumn = !seenErr || seenErr.code !== '42703'
  } catch {
    hasLastSeenAtColumn = false
  }

  return {
    hasFeedbackTable,
    hasIsAdminColumn,
    hasLastSeenAtColumn,
    isFullyMigrated: hasFeedbackTable && hasIsAdminColumn && hasLastSeenAtColumn,
  }
}

/**
 * Touch user activity (Throttled update of last_seen_at)
 */
export async function touchUserActivityAction() {
  try {
    const supabase = await createClient()
    const { error } = await supabase.rpc('touch_user_activity')
    if (error) {
      return { success: false, error: error.message }
    }
    return { success: true }
  } catch (err: any) {
    return { success: false, error: err?.message || 'Lỗi cập nhật hoạt động' }
  }
}

/**
 * Fetch user profiles with server-side pagination, search, and global statistics
 */
export async function getAdminUsersAction(
  paramsOrSearch?: string | GetAdminUsersParams
): Promise<GetAdminUsersResponse> {
  const { isAdmin, user: currentUser } = await checkIsAdmin()
  if (!isAdmin) {
    return {
      success: false,
      error: 'Không có quyền quản trị',
      users: [],
      stats: { totalUsers: 0, adminCount: 0, regularCount: 0, active24hCount: 0, onlineFallbackCount: 0 },
      pagination: { page: 1, pageSize: 20, totalItems: 0, totalPages: 1 },
      hasIsAdminColumn: false,
      hasLastSeenAtColumn: false,
    }
  }

  const params: GetAdminUsersParams =
    typeof paramsOrSearch === 'string' ? { search: paramsOrSearch } : paramsOrSearch || {}
  const page = Math.max(1, params.page || 1)
  const pageSize = Math.max(1, Math.min(100, params.pageSize || 20))
  const rawSearch = params.search?.trim() || ''
  // Sanitize search keyword to remove PostgREST operator injection characters
  const sanitizedSearch = rawSearch.replace(/[,%()]/g, '').trim()

  const supabase = await createClient()

  const adminEmails = [
    ...(process.env.ADMIN_EMAIL ? process.env.ADMIN_EMAIL.split(',').map((e) => e.trim().toLowerCase()) : []),
    'khoadev27@gmail.com',
  ]

  let hasIsAdminColumn = true
  let hasLastSeenAtColumn = true

  const twentyFourHoursAgo = new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString()
  const twoMinutesAgo = new Date(Date.now() - 2 * 60 * 1000).toISOString()

  // 1. Fetch Global Statistics in parallel using HEAD queries (zero row payload transfer)
  const totalCountPromise = supabase
    .from('profiles')
    .select('*', { count: 'exact', head: true })

  const adminCountPromise = supabase
    .from('profiles')
    .select('*', { count: 'exact', head: true })
    .eq('is_admin', true)

  const active24hPromise = supabase
    .from('profiles')
    .select('*', { count: 'exact', head: true })
    .gte('last_seen_at', twentyFourHoursAgo)

  const onlineFallbackPromise = supabase
    .from('profiles')
    .select('*', { count: 'exact', head: true })
    .gte('last_seen_at', twoMinutesAgo)

  // 2. Build paginated query with stable sorting
  const from = (page - 1) * pageSize
  const to = from + pageSize - 1

  let dataQuery = supabase
    .from('profiles')
    .select('id, email, display_name, avatar_url, created_at, is_admin, last_seen_at', { count: 'exact' })
    .order('created_at', { ascending: false })
    .order('id', { ascending: false })

  if (sanitizedSearch) {
    dataQuery = dataQuery.or(`email.ilike.%${sanitizedSearch}%,display_name.ilike.%${sanitizedSearch}%`)
  }

  dataQuery = dataQuery.range(from, to)

  const [totalRes, adminRes, active24hRes, onlineFallbackRes, dataRes] = await Promise.all([
    totalCountPromise,
    adminCountPromise,
    active24hPromise,
    onlineFallbackPromise,
    dataQuery,
  ])

  // Fallback if last_seen_at or is_admin column doesn't exist yet
  if (dataRes.error && (dataRes.error.code === '42703' || dataRes.error.message?.includes('last_seen_at') || dataRes.error.message?.includes('is_admin'))) {
    if (dataRes.error.message?.includes('is_admin')) {
      hasIsAdminColumn = false
    }
    if (dataRes.error.message?.includes('last_seen_at')) {
      hasLastSeenAtColumn = false
    }

    let selectCols = 'id, email, display_name, avatar_url, created_at'
    if (hasIsAdminColumn) selectCols += ', is_admin'
    if (hasLastSeenAtColumn) selectCols += ', last_seen_at'

    let fallbackQuery = supabase
      .from('profiles')
      .select(selectCols, { count: 'exact' })
      .order('created_at', { ascending: false })
      .order('id', { ascending: false })

    if (sanitizedSearch) {
      fallbackQuery = fallbackQuery.or(`email.ilike.%${sanitizedSearch}%,display_name.ilike.%${sanitizedSearch}%`)
    }
    fallbackQuery = fallbackQuery.range(from, to)

    const { data: fallbackData, error: fallbackErr, count: fallbackCount } = await fallbackQuery
    if (fallbackErr) {
      return {
        success: false,
        error: fallbackErr.message,
        users: [],
        stats: { totalUsers: 0, adminCount: 0, regularCount: 0, active24hCount: 0, onlineFallbackCount: 0 },
        pagination: { page, pageSize, totalItems: 0, totalPages: 1 },
        hasIsAdminColumn,
        hasLastSeenAtColumn,
      }
    }

    const totalFiltered = fallbackCount ?? 0
    const totalPages = Math.max(1, Math.ceil(totalFiltered / pageSize))
    const totalGlobal = totalRes.count ?? totalFiltered
    let adminGlobal = adminRes.count ?? 0
    if (adminGlobal === 0 && totalGlobal > 0) adminGlobal = 1
    const regularGlobal = Math.max(0, totalGlobal - adminGlobal)

    const users: AdminUserItem[] = (fallbackData || []).map((u: any) => ({
      ...u,
      is_admin: Boolean(u.is_admin || adminEmails.includes((u.email || '').toLowerCase())),
      last_seen_at: u.last_seen_at || null,
    }))

    return {
      success: true,
      users,
      stats: {
        totalUsers: totalGlobal,
        adminCount: adminGlobal,
        regularCount: regularGlobal,
        active24hCount: active24hRes.count ?? 0,
        onlineFallbackCount: onlineFallbackRes.count ?? 0,
      },
      pagination: {
        page: Math.min(page, totalPages),
        pageSize,
        totalItems: totalFiltered,
        totalPages,
      },
      hasIsAdminColumn,
      hasLastSeenAtColumn,
      currentUserId: currentUser?.id,
    }
  }

  if (dataRes.error) {
    return {
      success: false,
      error: dataRes.error.message,
      users: [],
      stats: { totalUsers: 0, adminCount: 0, regularCount: 0, active24hCount: 0, onlineFallbackCount: 0 },
      pagination: { page, pageSize, totalItems: 0, totalPages: 1 },
      hasIsAdminColumn,
      hasLastSeenAtColumn,
    }
  }

  const totalFiltered = dataRes.count ?? 0
  const totalPages = Math.max(1, Math.ceil(totalFiltered / pageSize))
  const totalGlobal = totalRes.count ?? totalFiltered
  let adminGlobal = adminRes.count ?? 0
  if (adminRes.error && adminRes.error.code === '42703') {
    adminGlobal = 1
  }
  // Ensure root admin is accounted for if totalGlobal > 0
  if (adminGlobal === 0 && totalGlobal > 0) {
    adminGlobal = 1
  }
  const regularGlobal = Math.max(0, totalGlobal - adminGlobal)
  const active24hGlobal = active24hRes.count ?? 0
  const onlineFallbackGlobal = onlineFallbackRes.count ?? 0

  // Map users with admin email fallback
  let users: AdminUserItem[] = (dataRes.data || []).map((u: any) => ({
    ...u,
    is_admin: Boolean(u.is_admin || adminEmails.includes((u.email || '').toLowerCase())),
    last_seen_at: u.last_seen_at || null,
  }))

  // Auto-adjust: If page was out of bounds (e.g. user was on page 3 and searched something yielding 1 page)
  let safePage = page
  if (users.length === 0 && totalFiltered > 0 && page > totalPages) {
    safePage = 1
    const { data: page1Data } = await supabase
      .from('profiles')
      .select('id, email, display_name, avatar_url, created_at, is_admin, last_seen_at')
      .order('created_at', { ascending: false })
      .order('id', { ascending: false })
      .range(0, pageSize - 1)

    users = (page1Data || []).map((u: any) => ({
      ...u,
      is_admin: Boolean(u.is_admin || adminEmails.includes((u.email || '').toLowerCase())),
      last_seen_at: u.last_seen_at || null,
    }))
  }

  return {
    success: true,
    users,
    stats: {
      totalUsers: totalGlobal,
      adminCount: adminGlobal,
      regularCount: regularGlobal,
      active24hCount: active24hGlobal,
      onlineFallbackCount: onlineFallbackGlobal,
    },
    pagination: {
      page: safePage,
      pageSize,
      totalItems: totalFiltered,
      totalPages,
    },
    hasIsAdminColumn,
    hasLastSeenAtColumn,
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

  // 1. Invoke database-level secure RPC
  const { data: rpcData, error: rpcError } = await supabase.rpc('set_user_admin_role', {
    target_user_id: targetUserId,
    new_is_admin: newIsAdmin,
  })

  if (rpcError) {
    console.error('Error invoking set_user_admin_role RPC:', rpcError.message)
    // If function does not exist in DB yet, fallback gracefully
    if (
      rpcError.code === '42883' || 
      rpcError.code === 'PGRST202' ||
      rpcError.message?.includes('set_user_admin_role')
    ) {
      const { error: directErr } = await supabase
        .from('profiles')
        .update({ is_admin: newIsAdmin })
        .eq('id', targetUserId)

      if (directErr) {
        return {
          success: false,
          error: 'Cần chạy đoạn mã SQL kích hoạt RPC và chính sách bảo mật: ' + directErr.message,
          needsMigration: true,
        }
      }
    } else {
      return { success: false, error: rpcError.message }
    }
  }

  revalidatePath('/admin')
  revalidatePath('/admin/feedback')
  return { success: true }
}
