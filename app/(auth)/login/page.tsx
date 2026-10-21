import Link from 'next/link'
import { X, ArrowLeft } from 'lucide-react'
import { LoginForm } from './login-form'
import { BrandSymbol } from '@/components/ui/brand-logo'

export const metadata = {
  title: 'Đăng nhập - Chinese Notebook',
  description: 'Đăng nhập tài khoản Chinese Notebook để lưu trữ từ vựng, bài học và tiến độ ôn tập HSK.',
}

export default async function LoginPage(props: {
  searchParams: Promise<{ error?: string; redirect?: string }>
}) {
  const searchParams = await props.searchParams
  const isRedirected = Boolean(searchParams?.redirect)
  const redirectTarget = searchParams?.redirect || '/'
  const registerHref = searchParams?.redirect
    ? `/register?redirect=${encodeURIComponent(searchParams.redirect)}`
    : '/register'

  return (
    <div className="min-h-screen w-full flex items-center justify-center bg-page relative px-4 py-8 overflow-hidden select-none">
      {/* Background traditional rice-paper pattern texture (local, zero external DNS dependency) */}
      <div
        className="absolute inset-0 bg-repeat opacity-35 pointer-events-none mix-blend-multiply"
        style={{ backgroundImage: `url('/patterns/rice-paper.png')` }}
      />

      {/* Main Authentication Card */}
      <div className="relative w-full max-w-[420px] bg-card border border-border/80 rounded-2xl shadow-xl shadow-black/[0.04] p-6 sm:p-8 z-10">
        {/* Top return button */}
        <Link
          href={redirectTarget}
          className="absolute top-4 right-4 p-1.5 rounded-lg text-muted hover:text-title hover:bg-page transition-colors"
          title="Quay lại"
          aria-label="Quay lại"
        >
          <X className="w-4 h-4" />
        </Link>

        {/* Brand Stamp & Header */}
        <div className="text-center space-y-2 mb-6">
          <div className="flex justify-center">
            <BrandSymbol size={48} />
          </div>
          <div className="space-y-1 pt-1">
            <h1 className="text-2xl font-serif font-bold text-title tracking-tight">
              Đăng nhập
            </h1>
            <p className="text-xs sm:text-sm font-sans text-muted">
              {isRedirected
                ? 'Vui lòng đăng nhập để tiếp tục thao tác này'
                : 'Chào mừng bạn trở lại với Chinese Notebook'}
            </p>
          </div>
        </div>

        {/* Interactive Client Form */}
        <LoginForm
          error={searchParams?.error}
          redirectUrl={searchParams?.redirect}
        />

        {/* Footer Navigation */}
        <div className="mt-6 pt-4 border-t border-border/60 text-center">
          <p className="text-xs font-sans text-muted">
            Chưa có tài khoản?{' '}
            <Link
              href={registerHref}
              className="text-app-accent hover:text-accent-hover font-medium underline underline-offset-2 transition-colors"
            >
              Tạo tài khoản mới
            </Link>
          </p>
        </div>
      </div>
    </div>
  )
}
