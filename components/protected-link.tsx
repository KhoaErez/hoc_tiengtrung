"use client"

import * as React from "react"
import Link from "next/link"
import { useRouter, usePathname } from "next/navigation"
import { 
  Dialog, 
  DialogContent, 
  DialogDescription, 
  DialogHeader, 
  DialogTitle, 
  DialogTrigger 
} from "@/components/ui/dialog"
import { Button } from "@/components/ui/button"

export function ProtectedLink({ 
  href, 
  children, 
  className,
  isLoggedIn
}: { 
  href: string, 
  children: React.ReactNode, 
  className?: string,
  isLoggedIn: boolean
}) {
  const router = useRouter()
  const pathname = usePathname()

  if (isLoggedIn) {
    return (
      <Link href={href} className={className}>
        {children}
      </Link>
    )
  }

  return (
    <Dialog>
      <DialogTrigger asChild>
        <button className={className} type="button">
          {children}
        </button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-md font-serif border-border rounded-xl">
        <DialogHeader>
          <div className="mx-auto w-16 h-16 bg-gradient-to-br from-red-600 to-red-800 rounded-2xl flex items-center justify-center shadow-lg shadow-red-700/20 mb-4 transform rotate-3">
            <span className="text-white text-3xl font-serif">汉</span>
          </div>
          <DialogTitle className="text-2xl text-center text-slate-800 tracking-tight">Yêu cầu đăng nhập</DialogTitle>
          <DialogDescription className="text-center text-slate-600">
            Vui lòng đăng nhập để sử dụng chức năng này.
          </DialogDescription>
        </DialogHeader>
        <div className="flex flex-col space-y-3 mt-4">
          <Button 
            className="w-full bg-red-700 hover:bg-red-800 text-white rounded-lg h-12 text-base"
            onClick={() => router.push(`/login?redirect=${href}`)}
          >
            Đăng nhập ngay
          </Button>
          <p className="text-sm text-slate-500 text-center mt-4">
            Chưa có tài khoản?{' '}
            <button 
              className="text-red-600 font-medium hover:text-red-700 hover:underline transition-colors cursor-pointer"
              onClick={() => router.push(`/register?redirect=${href}`)}
            >
              Tạo tài khoản mới
            </button>
          </p>
        </div>
      </DialogContent>
    </Dialog>
  )
}
