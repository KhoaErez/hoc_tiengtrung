'use client'

import { LogIn } from 'lucide-react'
import { useAuthModal } from '@/components/auth/auth-modal-context'

export function SidebarAuthButton() {
  const { openLoginForm } = useAuthModal()

  return (
    <button
      type="button"
      onClick={() => openLoginForm()}
      className="w-full flex items-center gap-3 px-3 py-2 text-muted hover:text-app-accent hover:bg-black/5 transition-colors rounded-lg text-sm font-medium text-left cursor-pointer"
    >
      <LogIn className="h-4 w-4" />
      <span>Đăng nhập</span>
    </button>
  )
}
