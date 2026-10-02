import { login } from '@/app/auth/actions'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import Link from 'next/link'

export default async function LoginPage(props: { searchParams: Promise<{ error?: string }> }) {
  const searchParams = await props.searchParams;
  return (
    <div className="flex min-h-screen w-full items-center justify-center bg-[#fdfdfc] p-4 relative overflow-hidden">
      <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/notebook-dark.png')] opacity-10 pointer-events-none mix-blend-multiply" />
      <Card className="w-full max-w-md z-10 shadow-sm border-[#e5e7eb] rounded-none border-t-[12px] border-t-red-700/80 bg-white/95 backdrop-blur">
        <CardHeader className="space-y-1 pb-8">
          <CardTitle className="text-2xl font-serif text-slate-800">Đăng nhập</CardTitle>
          <CardDescription className="text-slate-500 font-serif">
            Chinese Notebook AI
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form action={login} className="space-y-6">
            <div className="space-y-2">
              <Label htmlFor="email" className="font-serif text-slate-600">Email</Label>
              <Input id="email" name="email" type="email" placeholder="m@example.com" required className="rounded-none border-b-2 border-t-0 border-l-0 border-r-0 border-slate-200 bg-transparent focus-visible:ring-0 focus-visible:border-blue-400 px-0 font-serif text-lg h-10 shadow-none" />
            </div>
            <div className="space-y-2">
              <Label htmlFor="password" className="font-serif text-slate-600">Mật khẩu</Label>
              <Input id="password" name="password" type="password" required className="rounded-none border-b-2 border-t-0 border-l-0 border-r-0 border-slate-200 bg-transparent focus-visible:ring-0 focus-visible:border-blue-400 px-0 font-serif text-lg h-10 shadow-none" />
            </div>
            {searchParams?.error && (
              <p className="text-sm text-red-500 font-serif">{searchParams.error}</p>
            )}
            <Button type="submit" className="w-full rounded-sm font-serif bg-slate-800 hover:bg-slate-700 text-md h-12 mt-4">Đăng nhập</Button>
          </form>
        </CardContent>
        <CardFooter className="pt-4 border-t border-slate-100">
          <p className="text-sm text-slate-500 font-serif w-full text-center">
            Chưa có tài khoản?{' '}
            <Link href="/register" className="text-blue-600 hover:underline">
              Đăng ký
            </Link>
          </p>
        </CardFooter>
      </Card>
    </div>
  )
}
