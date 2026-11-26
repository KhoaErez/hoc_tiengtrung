import { ReactNode } from 'react'
import { getCachedAuthUser } from '@/lib/supabase/server'
import { AuthModalProvider } from '@/components/auth/auth-modal-context'
import { AuthModal } from '@/components/auth/auth-modal'

/**
 * Focus Layout tối giản chuyên biệt cho Lesson Player:
 * - Ẩn hoàn toàn PillNavbar, MobileBottomNav và mega-footer để học viên tập trung 100%.
 * - Giữ nguyên nền giấy ngà #FAF9F6 và AuthModal khi cần đăng nhập lưu SM-2.
 */
export default async function FocusLayout({ children }: { children: ReactNode }) {
  const user = await getCachedAuthUser()

  return (
    <AuthModalProvider initialUser={user}>
      <div className="min-h-screen bg-[#FAF9F6] dark:bg-page text-title font-sans flex flex-col relative selection:bg-[#B91C1C]/15 selection:text-[#B91C1C]">
        <div className="fixed inset-0 bg-[url('/patterns/rice-paper.png')] opacity-25 pointer-events-none mix-blend-multiply z-0" />
        <main className="relative z-10 flex-1 flex flex-col w-full">
          {children}
        </main>
        <AuthModal />
      </div>
    </AuthModalProvider>
  )
}
