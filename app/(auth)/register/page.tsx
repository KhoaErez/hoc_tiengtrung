import { signup } from '@/app/auth/actions'

import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import Link from 'next/link'
import { AuthSubmitButton } from '../submit-button'
import { X } from 'lucide-react'

export default async function RegisterPage(props: { searchParams: Promise<{ error?: string }> }) {
  const searchParams = await props.searchParams;
  return (
    <div className="flex min-h-screen w-full items-center justify-center bg-gradient-to-br from-red-50 via-orange-50 to-amber-50 p-4 relative overflow-hidden">
      {/* Decorative background elements */}
      <div className="absolute top-[-10%] right-[-5%] w-96 h-96 bg-red-200/40 rounded-full blur-3xl pointer-events-none" />
      <div className="absolute bottom-[-10%] left-[-5%] w-80 h-80 bg-amber-200/40 rounded-full blur-3xl pointer-events-none" />
      
      <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/rice-paper.png')] opacity-40 pointer-events-none mix-blend-multiply" />
      
      <Card className="w-full max-w-md z-10 shadow-2xl border border-white/60 rounded-2xl bg-white/60 backdrop-blur-xl overflow-hidden relative">
        <Link href="/" className="absolute top-4 right-4 z-20 text-slate-400 hover:text-slate-600 transition-colors p-2 rounded-full hover:bg-slate-100/50">
          <X className="w-5 h-5" />
        </Link>
        <div className="absolute top-0 left-0 w-full h-1.5 bg-gradient-to-r from-red-600 to-amber-500" />
        
        <CardHeader className="space-y-2 pb-8 pt-10 text-center">
          <div className="mx-auto w-16 h-16 bg-gradient-to-br from-red-600 to-red-800 rounded-2xl flex items-center justify-center shadow-lg shadow-red-700/20 mb-4 transform -rotate-3">
            <span className="text-white text-3xl font-serif">學</span>
          </div>
          <CardTitle className="text-3xl font-serif text-slate-800 font-bold tracking-tight">Tạo tài khoản</CardTitle>
          <CardDescription className="text-slate-500 font-serif text-base">
            Bắt đầu trang vở mới của bạn
          </CardDescription>
        </CardHeader>
        <CardContent className="px-8 pb-8">
          <form action={signup} className="space-y-5">
            <div className="space-y-2 relative group">
              <Label htmlFor="full_name" className="font-serif text-slate-700 font-medium">Tên hiển thị</Label>
              <Input 
                id="full_name" 
                name="full_name" 
                type="text" 
                placeholder="Ví dụ: Nguyễn Văn A" 
                required 
                className="rounded-xl border-slate-200/80 bg-white/50 focus-visible:ring-2 focus-visible:ring-red-500/20 focus-visible:border-red-500 transition-all duration-300 font-serif text-base h-12 shadow-sm" 
              />
            </div>
            <div className="space-y-2 relative group">
              <Label htmlFor="email" className="font-serif text-slate-700 font-medium">Email</Label>
              <Input 
                id="email" 
                name="email" 
                type="email" 
                placeholder="m@example.com" 
                required 
                className="rounded-xl border-slate-200/80 bg-white/50 focus-visible:ring-2 focus-visible:ring-red-500/20 focus-visible:border-red-500 transition-all duration-300 font-serif text-base h-12 shadow-sm" 
              />
            </div>
            <div className="space-y-2 relative group">
              <Label htmlFor="password" className="font-serif text-slate-700 font-medium">Mật khẩu</Label>
              <Input 
                id="password" 
                name="password" 
                type="password" 
                required 
                className="rounded-xl border-slate-200/80 bg-white/50 focus-visible:ring-2 focus-visible:ring-red-500/20 focus-visible:border-red-500 transition-all duration-300 font-serif text-base h-12 shadow-sm" 
              />
            </div>
            
            {searchParams?.error && (
              <div className="p-3 rounded-lg bg-red-50 border border-red-100 flex items-start gap-2">
                <span className="text-red-500 mt-0.5">⚠️</span>
                <p className="text-sm text-red-600 font-serif leading-relaxed">{searchParams.error}</p>
              </div>
            )}
            
            <AuthSubmitButton text="Đăng ký ngay" loadingText="Đang tạo tài khoản..." />
          </form>
        </CardContent>
        <CardFooter className="pt-6 pb-8 border-t border-slate-200/50 bg-slate-50/30">
          <p className="text-sm text-slate-500 font-serif w-full text-center">
            Đã có tài khoản?{' '}
            <Link href="/login" className="text-red-600 font-medium hover:text-red-700 hover:underline transition-colors">
              Đăng nhập ngay
            </Link>
          </p>
        </CardFooter>
      </Card>
    </div>
  )
}
