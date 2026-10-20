'use client'

import { useState } from 'react'
import { signup } from '@/app/auth/actions'
import { GoogleSignInButton } from '@/components/auth/google-sign-in-button'
import { AuthSubmitButton } from '../submit-button'
import { Eye, EyeOff, AlertCircle } from 'lucide-react'

interface RegisterFormProps {
  error?: string
  redirectUrl?: string
}

export function RegisterForm({ error, redirectUrl }: RegisterFormProps) {
  const [showPassword, setShowPassword] = useState(false)

  return (
    <div className="space-y-4">
      {/* 1-Click Google Authentication */}
      <GoogleSignInButton
        text="Đăng ký nhanh với Google"
        redirectUrl={redirectUrl}
        className="w-full h-11 text-sm font-sans font-medium border-border/80 bg-card hover:bg-page transition-all"
      />

      {/* Subtle Divider */}
      <div className="relative flex items-center justify-center my-3">
        <div className="border-t border-border/70 w-full" />
        <span className="bg-card px-3 text-xs font-sans text-muted tracking-wide absolute">
          hoặc tạo tài khoản bằng email
        </span>
      </div>

      {/* Sign Up Form */}
      <form action={signup} className="space-y-3.5">
        {redirectUrl && (
          <input type="hidden" name="redirect" value={redirectUrl} />
        )}

        {/* Full Name field */}
        <div className="space-y-1.5">
          <label
            htmlFor="full_name"
            className="block text-xs font-sans font-medium text-title"
          >
            Tên hiển thị
          </label>
          <input
            id="full_name"
            name="full_name"
            type="text"
            required
            autoComplete="name"
            placeholder="Ví dụ: Minh Tâm"
            className="w-full h-10 px-3 rounded-lg border border-border/80 bg-page/50 text-title placeholder:text-muted/70 text-sm font-sans focus:outline-none focus:border-app-accent focus:ring-2 focus:ring-app-accent/15 transition-all"
          />
        </div>

        {/* Email field */}
        <div className="space-y-1.5">
          <label
            htmlFor="email"
            className="block text-xs font-sans font-medium text-title"
          >
            Email
          </label>
          <input
            id="email"
            name="email"
            type="email"
            required
            autoComplete="email"
            placeholder="ban@example.com"
            className="w-full h-10 px-3 rounded-lg border border-border/80 bg-page/50 text-title placeholder:text-muted/70 text-sm font-sans focus:outline-none focus:border-app-accent focus:ring-2 focus:ring-app-accent/15 transition-all"
          />
        </div>

        {/* Password field with show/hide toggle */}
        <div className="space-y-1.5">
          <label
            htmlFor="password"
            className="block text-xs font-sans font-medium text-title"
          >
            Mật khẩu
          </label>
          <div className="relative">
            <input
              id="password"
              name="password"
              type={showPassword ? 'text' : 'password'}
              required
              minLength={6}
              autoComplete="new-password"
              placeholder="Tối thiểu 6 ký tự"
              className="w-full h-10 pl-3 pr-10 rounded-lg border border-border/80 bg-page/50 text-title placeholder:text-muted/70 text-sm font-sans focus:outline-none focus:border-app-accent focus:ring-2 focus:ring-app-accent/15 transition-all"
            />
            <button
              type="button"
              onClick={() => setShowPassword(!showPassword)}
              aria-label={showPassword ? 'Ẩn mật khẩu' : 'Hiện mật khẩu'}
              className="absolute right-2.5 top-1/2 -translate-y-1/2 text-muted hover:text-title transition-colors p-1"
            >
              {showPassword ? (
                <EyeOff className="w-4 h-4" />
              ) : (
                <Eye className="w-4 h-4" />
              )}
            </button>
          </div>
        </div>

        {/* Error message */}
        {error && (
          <div className="p-2.5 rounded-lg bg-red-50/80 border border-red-200/60 flex items-start gap-2 text-xs text-red-700 font-sans">
            <AlertCircle className="w-4 h-4 text-red-600 flex-shrink-0 mt-0.5" />
            <span className="leading-relaxed">{error}</span>
          </div>
        )}

        {/* Submit Button */}
        <div className="pt-1">
          <AuthSubmitButton text="Tạo tài khoản" loadingText="Đang tạo tài khoản..." />
        </div>
      </form>
    </div>
  )
}
