'use client'

import React, { useState, useEffect } from 'react'
import { useAuthModal } from './auth-modal-context'
import { createClient } from '@/lib/supabase/client'
import {
  X,
  Lock,
  Mail,
  Eye,
  EyeOff,
  AlertCircle,
  Loader2,
  BookOpen,
  ArrowRight,
  User,
} from 'lucide-react'
import { toast } from 'sonner'
import { useRouter } from 'next/navigation'

export function AuthModal() {
  const {
    isOpen,
    view,
    options,
    closeModal,
    switchView,
    setUser,
  } = useAuthModal()

  const router = useRouter()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [fullName, setFullName] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const [isGoogleLoading, setIsGoogleLoading] = useState(false)
  const [errorMessage, setErrorMessage] = useState<string | null>(null)

  // Reset form state when view or open status changes
  useEffect(() => {
    if (!isOpen) {
      setEmail('')
      setPassword('')
      setFullName('')
      setShowPassword(false)
      setIsLoading(false)
      setIsGoogleLoading(false)
      setErrorMessage(null)
    }
  }, [isOpen, view])

  // Close on Escape key press
  useEffect(() => {
    if (!isOpen) return
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        closeModal()
      }
    }
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [isOpen, closeModal])

  if (!isOpen) return null

  // 1. Handle Google OAuth 1-Click
  const handleGoogleSignIn = async () => {
    try {
      setIsGoogleLoading(true)
      setErrorMessage(null)
      const supabase = createClient()

      const targetNext = options.redirectUrl && options.redirectUrl.startsWith('/') ? options.redirectUrl : '/'
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
        setErrorMessage('Không thể kết nối đến Google. Vui lòng thử lại.')
        setIsGoogleLoading(false)
      } else if (data?.url) {
        window.location.href = data.url
      }
    } catch (err) {
      console.error('Google Sign-in error:', err)
      setErrorMessage('Đã xảy ra lỗi khi đăng nhập với Google.')
      setIsGoogleLoading(false)
    }
  }

  // 2. Handle in-modal Email/Password Login
  const handleEmailSignIn = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!email || !password) {
      setErrorMessage('Vui lòng nhập đầy đủ email và mật khẩu.')
      return
    }

    try {
      setIsLoading(true)
      setErrorMessage(null)
      const supabase = createClient()

      const { data, error } = await supabase.auth.signInWithPassword({
        email: email.trim(),
        password,
      })

      if (error) {
        let msg = error.message
        if (msg.includes('Invalid login credentials')) {
          msg = 'Email hoặc mật khẩu không chính xác.'
        } else if (msg.includes('Email not confirmed')) {
          msg = 'Email chưa được xác nhận.'
        }
        setErrorMessage(msg)
        setIsLoading(false)
        return
      }

      if (data?.user) {
        setUser(data.user)
        const name = data.user.user_metadata?.full_name || data.user.email?.split('@')[0] || 'bạn'
        toast.success(`Đăng nhập thành công! Chào mừng ${name}.`)

        // Execute post-login callback if specified
        if (options.onSuccess) {
          try {
            await options.onSuccess()
          } catch (callbackErr) {
            console.error('Error executing onSuccess callback:', callbackErr)
          }
        }

        router.refresh()
        closeModal()
      }
    } catch (err) {
      console.error('Sign-in exception:', err)
      setErrorMessage('Không thể kết nối đến máy chủ. Vui lòng thử lại.')
    } finally {
      setIsLoading(false)
    }
  }

  // 3. Handle in-modal Sign Up
  const handleSignUp = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!email || !password) {
      setErrorMessage('Vui lòng nhập đầy đủ email và mật khẩu.')
      return
    }

    if (password.length < 6) {
      setErrorMessage('Mật khẩu cần có tối thiểu 6 ký tự.')
      return
    }

    try {
      setIsLoading(true)
      setErrorMessage(null)
      const supabase = createClient()

      const { data, error } = await supabase.auth.signUp({
        email: email.trim(),
        password,
        options: {
          data: {
            full_name: fullName.trim() || email.split('@')[0],
          },
        },
      })

      if (error) {
        let msg = error.message
        if (msg.includes('User already registered')) {
          msg = 'Email này đã được đăng ký. Vui lòng đăng nhập.'
        }
        setErrorMessage(msg)
        setIsLoading(false)
        return
      }

      if (data?.user) {
        setUser(data.user)
        toast.success('Đăng ký tài khoản thành công!')

        if (options.onSuccess) {
          try {
            await options.onSuccess()
          } catch (callbackErr) {
            console.error('Error in onSuccess:', callbackErr)
          }
        }

        router.refresh()
        closeModal()
      }
    } catch (err) {
      console.error('Sign-up error:', err)
      setErrorMessage('Không thể tạo tài khoản. Vui lòng thử lại.')
    } finally {
      setIsLoading(false)
    }
  }

  const handleForgotPassword = (e: React.MouseEvent) => {
    e.preventDefault()
    toast.info('Để đặt lại mật khẩu, vui lòng liên hệ admin hoặc sử dụng Đăng nhập bằng Google.')
  }

  return (
    <div
      role="dialog"
      aria-modal="true"
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/45 backdrop-blur-xs animate-in fade-in duration-150"
      onClick={(e) => {
        if (e.target === e.currentTarget) closeModal()
      }}
    >
      <div className="relative w-full max-w-[420px] bg-card border border-border/80 rounded-2xl shadow-2xl p-6 sm:p-7 z-10 animate-in zoom-in-95 duration-150 select-none">
        {/* Nút đóng ở góc trên bên phải */}
        <button
          onClick={closeModal}
          className="absolute top-4 right-4 p-1.5 rounded-lg text-muted hover:text-title hover:bg-page transition-colors cursor-pointer"
          aria-label="Đóng"
          title="Đóng (Escape)"
        >
          <X className="w-4 h-4" />
        </button>

        {/* ======================================================== */}
        {/* LUỒNG 1: DIALOG THÔNG BÁO CẦN ĐĂNG NHẬP                    */}
        {/* ======================================================== */}
        {view === 'login-required' && (
          <div className="space-y-5 text-center">
            {/* Con dấu triện đỏ học giả thương hiệu Chinese Notebook */}
            <div className="mx-auto w-14 h-14 rounded-2xl bg-app-accent text-white flex items-center justify-center shadow-md border border-app-accent/30 ring-4 ring-app-accent/10 mt-1">
              <Lock className="w-6 h-6 text-white" />
            </div>

            {/* Tiêu đề & Nội dung chuẩn theo yêu cầu */}
            <div className="space-y-2">
              <h2 className="text-2xl font-serif font-bold text-title tracking-tight">
                {options.title || 'Bạn cần đăng nhập'}
              </h2>
              <p className="text-xs sm:text-sm font-sans text-muted leading-relaxed max-w-xs mx-auto">
                {options.description ||
                  'Đăng nhập để sử dụng tính năng này và lưu lại tiến trình học tập của bạn.'}
              </p>
            </div>

            {/* Các nút hành động: Đăng nhập ngay vs Để sau */}
            <div className="space-y-2.5 pt-2">
              <button
                type="button"
                onClick={() => switchView('login-form')}
                className="w-full h-11 rounded-xl bg-app-accent hover:bg-accent-hover text-white font-serif text-sm font-semibold flex items-center justify-center gap-2 shadow-xs hover:shadow-sm active:scale-[0.99] transition-all cursor-pointer"
              >
                <span>Đăng nhập ngay</span>
                <ArrowRight className="w-4 h-4" />
              </button>

              <button
                type="button"
                onClick={closeModal}
                className="w-full h-10 rounded-xl border border-border/80 hover:bg-page text-muted hover:text-title font-serif text-xs sm:text-sm transition-colors cursor-pointer"
              >
                Để sau
              </button>
            </div>
          </div>
        )}

        {/* ======================================================== */}
        {/* LUỒNG 2: DIALOG ĐĂNG NHẬP (THEO GIAO DIỆN THAM KHẢO)       */}
        {/* ======================================================== */}
        {view === 'login-form' && (
          <div className="space-y-4">
            {/* Header: Tiêu đề & Mô tả */}
            <div className="text-center space-y-1">
              <h2 className="text-2xl font-serif font-bold text-title tracking-tight">
                Đăng nhập
              </h2>
              <p className="text-xs sm:text-sm font-sans text-muted">
                Đăng nhập để đồng bộ tiến trình học của bạn.
              </p>
            </div>

            {/* Minh họa Mascot / Con dấu thương hiệu độc quyền Chinese Notebook */}
            <div className="flex justify-center py-1">
              <div className="relative group">
                {/* Con dấu triện tròn thư pháp cổ điển */}
                <div className="w-16 h-16 rounded-full bg-gradient-to-br from-red-600 via-app-accent to-red-800 text-white flex items-center justify-center shadow-md shadow-red-700/15 border-2 border-white ring-4 ring-app-accent/15">
                  <div className="text-center leading-none">
                    <span className="font-serif text-2xl font-bold tracking-tight">汉</span>
                    <span className="block text-[8px] font-sans uppercase tracking-widest text-white/80 mt-0.5">CHINESE</span>
                  </div>
                </div>
              </div>
            </div>

            {/* Nút Đăng nhập bằng Google (Chuẩn Logo SVG 4 màu) */}
            <button
              type="button"
              onClick={handleGoogleSignIn}
              disabled={isGoogleLoading}
              className="w-full h-11 rounded-xl border border-border/90 bg-card hover:bg-page text-title font-sans text-xs sm:text-sm font-medium flex items-center justify-center gap-3 shadow-xs hover:shadow-sm active:scale-[0.99] transition-all cursor-pointer disabled:opacity-60 disabled:cursor-not-allowed"
            >
              {isGoogleLoading ? (
                <>
                  <Loader2 className="w-4 h-4 animate-spin text-app-accent" />
                  <span>Đang kết nối Google...</span>
                </>
              ) : (
                <>
                  <svg className="w-4 h-4 flex-shrink-0" viewBox="0 0 24 24">
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
                  <span>Đăng nhập bằng Google</span>
                </>
              )}
            </button>

            {/* Đường phân cách HOẶC như ảnh tham khảo */}
            <div className="relative flex items-center justify-center my-2">
              <div className="border-t border-border/80 w-full" />
              <span className="bg-card px-3 text-[11px] font-sans font-semibold text-muted tracking-widest uppercase absolute">
                HOẶC
              </span>
            </div>

            {/* Form Email & Mật khẩu */}
            <form onSubmit={handleEmailSignIn} className="space-y-3 pt-1">
              {/* Input Email với icon Thư */}
              <div className="space-y-1">
                <div className="relative">
                  <Mail className="w-4 h-4 text-muted absolute left-3.5 top-1/2 -translate-y-1/2 pointer-events-none" />
                  <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    autoComplete="email"
                    placeholder="Email"
                    className="w-full h-11 pl-10 pr-3.5 rounded-xl border border-border/80 bg-page/50 text-title placeholder:text-muted/70 text-xs sm:text-sm font-sans focus:outline-none focus:border-app-accent focus:ring-2 focus:ring-app-accent/15 transition-all"
                  />
                </div>
              </div>

              {/* Input Mật khẩu với icon Khóa & nút Ẩn/Hiện */}
              <div className="space-y-1">
                <div className="relative">
                  <Lock className="w-4 h-4 text-muted absolute left-3.5 top-1/2 -translate-y-1/2 pointer-events-none" />
                  <input
                    type={showPassword ? 'text' : 'password'}
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                    autoComplete="current-password"
                    placeholder="Mật khẩu"
                    className="w-full h-11 pl-10 pr-10 rounded-xl border border-border/80 bg-page/50 text-title placeholder:text-muted/70 text-xs sm:text-sm font-sans focus:outline-none focus:border-app-accent focus:ring-2 focus:ring-app-accent/15 transition-all"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    aria-label={showPassword ? 'Ẩn mật khẩu' : 'Hiện mật khẩu'}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-muted hover:text-title p-1 transition-colors cursor-pointer"
                  >
                    {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                  </button>
                </div>

                {/* Quên mật khẩu */}
                <div className="flex justify-end pt-0.5">
                  <button
                    type="button"
                    onClick={handleForgotPassword}
                    className="text-[11px] font-sans text-muted hover:text-app-accent transition-colors cursor-pointer"
                  >
                    Quên mật khẩu?
                  </button>
                </div>
              </div>

              {/* Thông báo lỗi */}
              {errorMessage && (
                <div className="p-2.5 rounded-xl bg-red-50/80 border border-red-200/60 flex items-start gap-2 text-xs text-red-700 font-sans animate-in fade-in">
                  <AlertCircle className="w-4 h-4 text-red-600 flex-shrink-0 mt-0.5" />
                  <span className="leading-relaxed">{errorMessage}</span>
                </div>
              )}

              {/* Nút Đăng nhập tối màu đồng bộ ảnh tham khảo */}
              <button
                type="submit"
                disabled={isLoading}
                className="w-full h-11 rounded-xl bg-[#23272F] hover:bg-[#181B20] text-white font-sans text-sm font-semibold flex items-center justify-center gap-2 shadow-xs hover:shadow-sm active:scale-[0.99] transition-all cursor-pointer disabled:opacity-60 disabled:cursor-not-allowed mt-2"
              >
                {isLoading ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin text-white" />
                    <span>Đang đăng nhập...</span>
                  </>
                ) : (
                  <span>Đăng nhập</span>
                )}
              </button>
            </form>

            {/* Chuyển sang form Đăng ký */}
            <div className="text-center pt-2">
              <p className="text-xs font-sans text-muted">
                Chưa có tài khoản?{' '}
                <button
                  type="button"
                  onClick={() => switchView('register-form')}
                  className="text-app-accent hover:text-accent-hover font-semibold underline underline-offset-2 transition-colors cursor-pointer"
                >
                  Tạo tài khoản mới
                </button>
              </p>
            </div>

            {/* Điều khoản sử dụng và chính sách */}
            <div className="text-center pt-1 border-t border-border/50">
              <p className="text-[10px] text-muted/80 font-sans leading-tight">
                Bằng việc đăng nhập, bạn đồng ý với{' '}
                <span className="underline cursor-pointer hover:text-title">Điều khoản sử dụng</span> và{' '}
                <span className="underline cursor-pointer hover:text-title">Chính sách quyền riêng tư</span>.
              </p>
            </div>
          </div>
        )}

        {/* ======================================================== */}
        {/* FORM ĐĂNG KÝ (KHI BẤM 'TẠO TÀI KHOẢN MỚI' TRONG MODAL)     */}
        {/* ======================================================== */}
        {view === 'register-form' && (
          <div className="space-y-4">
            <div className="text-center space-y-1">
              <h2 className="text-2xl font-serif font-bold text-title tracking-tight">
                Tạo tài khoản
              </h2>
              <p className="text-xs sm:text-sm font-sans text-muted">
                Bắt đầu trang vở mới của bạn cùng Chinese Notebook
              </p>
            </div>

            {/* Mascot / Con dấu chữ Học */}
            <div className="flex justify-center py-1">
              <div className="w-16 h-16 rounded-full bg-gradient-to-br from-amber-600 via-app-accent to-red-800 text-white flex items-center justify-center shadow-md shadow-red-700/15 border-2 border-white ring-4 ring-app-accent/15">
                <div className="text-center leading-none">
                  <span className="font-serif text-2xl font-bold tracking-tight">学</span>
                  <span className="block text-[8px] font-sans uppercase tracking-widest text-white/80 mt-0.5">LEARN</span>
                </div>
              </div>
            </div>

            {/* Đăng ký nhanh với Google */}
            <button
              type="button"
              onClick={handleGoogleSignIn}
              disabled={isGoogleLoading}
              className="w-full h-11 rounded-xl border border-border/90 bg-card hover:bg-page text-title font-sans text-xs sm:text-sm font-medium flex items-center justify-center gap-3 shadow-xs hover:shadow-sm active:scale-[0.99] transition-all cursor-pointer disabled:opacity-60 disabled:cursor-not-allowed"
            >
              {isGoogleLoading ? (
                <>
                  <Loader2 className="w-4 h-4 animate-spin text-app-accent" />
                  <span>Đang kết nối Google...</span>
                </>
              ) : (
                <>
                  <svg className="w-4 h-4 flex-shrink-0" viewBox="0 0 24 24">
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
                  <span>Đăng ký nhanh với Google</span>
                </>
              )}
            </button>

            <div className="relative flex items-center justify-center my-2">
              <div className="border-t border-border/80 w-full" />
              <span className="bg-card px-3 text-[11px] font-sans font-semibold text-muted tracking-widest uppercase absolute">
                HOẶC
              </span>
            </div>

            <form onSubmit={handleSignUp} className="space-y-3 pt-1">
              <div className="relative">
                <User className="w-4 h-4 text-muted absolute left-3.5 top-1/2 -translate-y-1/2 pointer-events-none" />
                <input
                  type="text"
                  value={fullName}
                  onChange={(e) => setFullName(e.target.value)}
                  required
                  placeholder="Tên hiển thị của bạn"
                  className="w-full h-11 pl-10 pr-3.5 rounded-xl border border-border/80 bg-page/50 text-title placeholder:text-muted/70 text-xs sm:text-sm font-sans focus:outline-none focus:border-app-accent focus:ring-2 focus:ring-app-accent/15 transition-all"
                />
              </div>

              <div className="relative">
                <Mail className="w-4 h-4 text-muted absolute left-3.5 top-1/2 -translate-y-1/2 pointer-events-none" />
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                  placeholder="Email"
                  className="w-full h-11 pl-10 pr-3.5 rounded-xl border border-border/80 bg-page/50 text-title placeholder:text-muted/70 text-xs sm:text-sm font-sans focus:outline-none focus:border-app-accent focus:ring-2 focus:ring-app-accent/15 transition-all"
                />
              </div>

              <div className="relative">
                <Lock className="w-4 h-4 text-muted absolute left-3.5 top-1/2 -translate-y-1/2 pointer-events-none" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  minLength={6}
                  placeholder="Mật khẩu (tối thiểu 6 ký tự)"
                  className="w-full h-11 pl-10 pr-10 rounded-xl border border-border/80 bg-page/50 text-title placeholder:text-muted/70 text-xs sm:text-sm font-sans focus:outline-none focus:border-app-accent focus:ring-2 focus:ring-app-accent/15 transition-all"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  aria-label={showPassword ? 'Ẩn mật khẩu' : 'Hiện mật khẩu'}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-muted hover:text-title p-1 transition-colors cursor-pointer"
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>

              {errorMessage && (
                <div className="p-2.5 rounded-xl bg-red-50/80 border border-red-200/60 flex items-start gap-2 text-xs text-red-700 font-sans animate-in fade-in">
                  <AlertCircle className="w-4 h-4 text-red-600 flex-shrink-0 mt-0.5" />
                  <span className="leading-relaxed">{errorMessage}</span>
                </div>
              )}

              <button
                type="submit"
                disabled={isLoading}
                className="w-full h-11 rounded-xl bg-app-accent hover:bg-accent-hover text-white font-sans text-sm font-semibold flex items-center justify-center gap-2 shadow-xs hover:shadow-sm active:scale-[0.99] transition-all cursor-pointer disabled:opacity-60 disabled:cursor-not-allowed mt-2"
              >
                {isLoading ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin text-white" />
                    <span>Đang tạo tài khoản...</span>
                  </>
                ) : (
                  <span>Tạo tài khoản</span>
                )}
              </button>
            </form>

            <div className="text-center pt-2">
              <p className="text-xs font-sans text-muted">
                Đã có tài khoản?{' '}
                <button
                  type="button"
                  onClick={() => switchView('login-form')}
                  className="text-app-accent hover:text-accent-hover font-semibold underline underline-offset-2 transition-colors cursor-pointer"
                >
                  Đăng nhập ngay
                </button>
              </p>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
