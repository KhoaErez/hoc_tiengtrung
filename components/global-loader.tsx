'use client';

import { useEffect, useState } from 'react';
import { usePathname, useSearchParams } from 'next/navigation';
import { Loader2 } from 'lucide-react';

export function GlobalLoader() {
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    // Tắt loading khi chuyển trang xong (pathname hoặc search thay đổi)
    setIsLoading(false);
  }, [pathname, searchParams]);

  useEffect(() => {
    const handleClick = (e: MouseEvent) => {
      const target = (e.target as HTMLElement).closest('a');
      if (
        target &&
        target.href &&
        target.target !== '_blank' &&
        !target.hasAttribute('download')
      ) {
        const url = new URL(target.href);
        // Bật loading nếu link trỏ đến nội bộ và khác trang hiện tại
        if (
          url.origin === window.location.origin &&
          (url.pathname !== window.location.pathname || url.search !== window.location.search)
        ) {
          setIsLoading(true);
          // Tự động tắt sau 3s đề phòng lỗi mạng hoặc trang đã prefetch
          setTimeout(() => setIsLoading(false), 3000);
        }
      }
    };
    
    document.addEventListener('click', handleClick);
    return () => document.removeEventListener('click', handleClick);
  }, []);

  if (!isLoading) return null;

  return (
    <div className="fixed top-6 left-1/2 -translate-x-1/2 z-[100] animate-in fade-in slide-in-from-top-4 duration-300 pointer-events-none">
      <div className="bg-card/90 backdrop-blur-xl shadow-lg border border-border px-5 py-2.5 rounded-full flex items-center gap-3">
        <Loader2 className="w-4 h-4 text-app-accent animate-spin" />
        <span className="text-sm font-serif text-title tracking-wide">Đang tải trang...</span>
      </div>
    </div>
  );
}
