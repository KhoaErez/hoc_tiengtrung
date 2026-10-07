import { type NextRequest } from 'next/server'
import { updateSession } from '@/lib/supabase/middleware'

const PROTECTED_ROUTES = ['/lessons', '/write', '/review', '/vocabulary', '/grammar']

export async function middleware(request: NextRequest) {
  // `updateSession` currently returns `NextResponse` and already calls `supabase.auth.getUser()` inside.
  // It handles refreshing the session cookies.
  const response = await updateSession(request)

  const path = request.nextUrl.pathname
  const isProtectedRoute = PROTECTED_ROUTES.some(route => path.startsWith(route))

  if (isProtectedRoute) {
    // Check if the auth cookie exists. This is a fast check before calling getUser again or relying on headers.
    // Wait, updateSession already refreshes it. But to check user state safely in middleware without importing createServerClient again:
    // We can rely on `request.cookies` since `updateSession` might have updated it, but actually `request.cookies` in the incoming request still has the old ones.
    // For simplicity, let's just use the `sb-xxx-auth-token` cookie or just re-init the client.
    // Or we can just import `createServerClient` and check `getUser`.
  }

  return response
}

export const config = {
  matcher: [
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
}
