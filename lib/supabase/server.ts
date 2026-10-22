import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import { cache } from 'react'

export async function createClient() {
  const cookieStore = await cookies()

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll()
        },
        setAll(cookiesToSet) {
          try {
            cookiesToSet.forEach(({ name, value, options }) =>
              cookieStore.set(name, value, options)
            )
          } catch {
          }
        },
      },
    }
  )
}

/**
 * Lấy thông tin user hiện tại được cache theo vòng đời của mỗi Server Request (React.cache).
 * Giúp triệt tiêu Triple Auth Fetch: nếu layout, page và action cùng gọi trong 1 request,
 * Supabase Auth chỉ được gọi đúng 1 lần duy nhất qua mạng.
 */
export const getCachedAuthUser = cache(async () => {
  const supabase = await createClient()
  const { data: { user }, error } = await supabase.auth.getUser()
  if (error || !user) return null
  return user
})

export interface UserProfileCache {
  id: string
  email?: string | null
  display_name?: string | null
  is_admin?: boolean | null
  avatar_url?: string | null
  created_at?: string | null
}

/**
 * Lấy profile và quyền admin của user được cache theo vòng đời request.
 */
export const getCachedUserProfile = cache(async (userId: string): Promise<UserProfileCache | null> => {
  const supabase = await createClient()
  try {
    const { data, error } = await supabase
      .from('profiles')
      .select('id, email, display_name, is_admin, avatar_url, created_at')
      .eq('id', userId)
      .maybeSingle()
    if (!error && data) return data
    return null
  } catch {
    return null
  }
})

