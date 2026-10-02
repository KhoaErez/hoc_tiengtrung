import { ReactNode } from 'react'
import Link from 'next/link'
import { Search, User, BookOpen } from 'lucide-react'

export default function CourseLayout({ children }: { children: ReactNode }) {
  return (
    <div className="min-h-screen flex flex-col bg-[#fdfdfc] text-slate-800 font-serif overflow-hidden h-screen">
      {/* Header */}
      <header className="h-14 border-b-2 border-slate-200 bg-[#fdfdfc]/90 flex items-center justify-between px-6 shrink-0 z-20">
        <Link href="/dashboard" className="flex items-center gap-2 hover:opacity-80 transition-opacity">
          <BookOpen className="h-6 w-6 text-red-700" />
          <span className="font-bold text-xl text-red-700 tracking-wide uppercase">Tiếng Trung</span>
        </Link>
        <div className="flex items-center gap-6">
          <div className="flex items-center bg-slate-100 rounded-full px-3 py-1 border border-slate-200 focus-within:border-red-700 focus-within:ring-1 focus-within:ring-red-700 transition-all hidden sm:flex">
            <Search className="h-4 w-4 text-slate-400 mr-2" />
            <input 
              type="text" 
              placeholder="Tìm kiếm..." 
              className="bg-transparent border-none outline-none w-32 md:w-64 text-sm font-sans"
            />
          </div>
          <div className="flex items-center gap-2 cursor-pointer hover:text-red-700 transition-colors">
            <div className="h-8 w-8 rounded-full bg-slate-200 flex items-center justify-center border-2 border-slate-300">
              <User className="h-4 w-4 text-slate-500" />
            </div>
            <span className="font-sans font-medium text-sm hidden sm:block">Học viên</span>
          </div>
        </div>
      </header>

      {/* Body */}
      {children}
    </div>
  )
}
