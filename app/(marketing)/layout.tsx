import { ReactNode } from 'react'
import { checkIsAdmin } from '@/app/actions/feedback'
import { AuthModalProvider } from '@/components/auth/auth-modal-context'
import { AdminNotificationProvider } from '@/components/dashboard/admin-notification-context'
import { PillNavbar } from '@/components/layout/pill-navbar'
import { MobileBottomNav } from '@/components/layout/mobile-bottom-nav'
import { MobileNavProvider } from '@/components/layout/mobile-nav-context'
import { SiteFooter } from '@/components/layout/site-footer'
import { AuthModal } from '@/components/auth/auth-modal'

export default async function MarketingLayout({ children }: { children: ReactNode }) {
  const { isAdmin, user, profile } = await checkIsAdmin()

  return (
    <AuthModalProvider initialUser={user}>
      <AdminNotificationProvider adminId={isAdmin ? user?.id : null}>
        <MobileNavProvider>
          <div className="min-h-screen bg-page text-title font-sans flex flex-col relative overflow-x-clip selection:bg-[#B8322D]/15 selection:text-[#B8322D]">
            {/* Nền giấy Tuyên Chỉ (Rice Paper Pattern) với độ trong suốt tinh tế */}
            <div className="fixed inset-0 bg-[url('/patterns/rice-paper.png')] opacity-25 pointer-events-none mix-blend-multiply z-0" />

            {/* Họa tiết thư pháp kinh điển mờ hai bên rìa màn hình lớn (>= 1536px / 1920px) */}
            <div className="hidden 2xl:block fixed left-3 top-1/2 -translate-y-1/2 pointer-events-none select-none opacity-[0.035] dark:opacity-[0.05] z-0 font-serif font-hanzi text-6xl [writing-mode:vertical-rl] tracking-[0.5em] text-[#182238] dark:text-white">
              学无止境
            </div>
            <div className="hidden 2xl:block fixed right-3 top-1/2 -translate-y-1/2 pointer-events-none select-none opacity-[0.035] dark:opacity-[0.05] z-0 font-serif font-hanzi text-6xl [writing-mode:vertical-rl] tracking-[0.5em] text-[#182238] dark:text-white">
              温故知新
            </div>
            
            {/* Thanh điều hướng dạng viên thuốc nổi ở đỉnh (Pill Navbar) */}
            <PillNavbar 
              user={user} 
              profile={profile} 
              isAdmin={isAdmin} 
            />

            {/* Vùng nội dung chính (Tối ưu Mobile-First: chiếm gần toàn bộ chiều rộng điện thoại, pb-24 tránh bị Bottom Nav che) */}
            <main className="flex-1 w-full sm:w-[94%] max-w-[1536px] 2xl:max-w-[1640px] mx-auto px-3 sm:px-4 lg:px-6 2xl:px-8 py-3.5 sm:py-6 pb-24 lg:pb-8 relative z-10 min-w-0">
              {children}
            </main>

            {/* Chân trang EdTech 4 cột toàn diện */}
            <SiteFooter />

            {/* Thanh điều hướng dưới chuyên biệt cho Mobile (Bottom Navigation) */}
            <MobileBottomNav />

            {/* Modal Đăng nhập / Đăng ký dùng chung */}
            <AuthModal />
          </div>
        </MobileNavProvider>
      </AdminNotificationProvider>
    </AuthModalProvider>
  )
}

