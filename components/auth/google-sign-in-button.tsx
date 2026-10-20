'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Loader2 } from 'lucide-react'
import { toast } from 'sonner'

interface GoogleSignInButtonProps {
  text?: string
  redirectUrl?: string
  className?: string
}

export function GoogleSignInButton({
  text = 'Tiếp tục với Google',
  redirectUrl,
  className = '',
}: GoogleSignInButtonProps) {
  const [isLoading, setIsLoading] = useState(false)

  const handleGoogleSignIn = async () => {
    try {
      setIsLoading(true)
      const supabase = createClient()

      // Determine return URL after OAuth callback
      const targetNext = redirectUrl && redirectUrl.startsWith('/') ? redirectUrl : '/'
      const callbackUrl = `${window.location.origin}/auth/callback?next=${encodeURIComponent(targetNext)}`

      const { data, error } = await supabase.auth.signInWithOAuth({
        provider: 'google',
        options: {
          redirectTo: callbackUrl,
          queryParams: {
            access_type: 'offline',
            prompt: 'select_account',
          },
        },
      })

      if (error) {
        console.error('Google OAuth error:', error.message)
        toast.error('Không thể kết nối đến Google. Vui lòng thử lại sau.')
        setIsLoading(false)
      } else if (data?.url) {
        // Redirecting to Google OAuth Consent screen
        window.location.href = data.url
      }
    } catch (err) {
      console.error('Google Sign-in exception:', err)
      toast.error('Đã xảy ra lỗi khi đăng nhập bằng Google.')
      setIsLoading(false)
    }
  }

  return (
    <button
      type="button"
      onClick={handleGoogleSignIn}
      disabled={isLoading}
      className={`w-full h-12 rounded-xl border border-slate-200/90 bg-white hover:bg-slate-50/90 text-slate-800 font-serif text-sm font-medium flex items-center justify-center gap-3 shadow-xs hover:shadow-sm active:scale-[0.99] transition-all duration-200 disabled:opacity-60 disabled:cursor-not-allowed cursor-pointer ${className}`}
    >
      {isLoading ? (
        <>
          <Loader2 className="w-4 h-4 animate-spin text-app-accent" />
          <span>Đang kết nối Google...</span>
        </>
      ) : (
        <>
          {/* Official Google G Logo SVG */}
          <svg className="w-5 h-5 flex-shrink-0" viewBox="0 0 24 24">
            <path
              fill="#4285F4"
              d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
            />
            <path
              fill="#34A853"
              d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
            />
            <path
              fill="#FBBC05"
              d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"
            />
            <path
              fill="#EA4335"
              d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"
            />
          </svg>
          <span>{text}</span>
        </>
      )}
    </button>
  )
}
