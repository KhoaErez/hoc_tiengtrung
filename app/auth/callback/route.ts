import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export async function GET(request: NextRequest) {
  const requestUrl = new URL(request.url)
  const code = requestUrl.searchParams.get('code')
  const next = requestUrl.searchParams.get('next') || '/'
  const error = requestUrl.searchParams.get('error')
  const errorDescription = requestUrl.searchParams.get('error_description')

  // 1. Handle error or user cancellation from OAuth provider
  if (error) {
    const errorMsg = errorDescription || error || 'Quá trình xác thực Google bị hủy.'
    return NextResponse.redirect(
      new URL(`/login?error=${encodeURIComponent(errorMsg)}`, request.url)
    )
  }

  // 2. Exchange authorization code for user session
  if (code) {
    const supabase = await createClient()
    const { error: exchangeError } = await supabase.auth.exchangeCodeForSession(code)

    if (!exchangeError) {
      // 3. Sync Google profile metadata to public.profiles if needed
      try {
        const { data: { user } } = await supabase.auth.getUser()

        if (user) {
          const userMeta = user.user_metadata || {}
          const googleName = userMeta.full_name || userMeta.name || user.email?.split('@')[0] || 'Học viên'
          const googleAvatar = userMeta.avatar_url || userMeta.picture || null

          // Check if profile exists
          const { data: existingProfile } = await supabase
            .from('profiles')
            .select('id, display_name, avatar_url')
            .eq('id', user.id)
            .maybeSingle()

          if (!existingProfile) {
            // Create profile record if database trigger didn't execute
            await supabase.from('profiles').insert({
              id: user.id,
              email: user.email!,
              display_name: googleName,
              avatar_url: googleAvatar,
            })
          } else if (!existingProfile.avatar_url && googleAvatar) {
            // Update avatar if not yet set
            await supabase
              .from('profiles')
              .update({ avatar_url: googleAvatar })
              .eq('id', user.id)
          }
        }
      } catch (e) {
        console.error('Error syncing profile from Google OAuth:', e)
      }

      // 4. Safe destination redirect
      const safeNext = next.startsWith('/') && !next.startsWith('//') ? next : '/'
      return NextResponse.redirect(new URL(safeNext, request.url))
    }

    console.error('Exchange code error:', exchangeError.message)
    return NextResponse.redirect(
      new URL(
        `/login?error=${encodeURIComponent('Không thể hoàn tất đăng nhập Google: ' + exchangeError.message)}`,
        request.url
      )
    )
  }

  // Default fallback if no code is present
  return NextResponse.redirect(
    new URL('/login?error=' + encodeURIComponent('Mã xác thực không hợp lệ hoặc đã hết hạn.'), request.url)
  )
}
