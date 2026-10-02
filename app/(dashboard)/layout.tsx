import { ReactNode } from 'react'
import Link from 'next/link'
import { BookOpen, PenTool, BrainCircuit, Search, PlusCircle, LogOut, Home } from 'lucide-react'

export default function DashboardLayout({ children }: { children: ReactNode }) {
  return (
    <div className="min-h-screen bg-[#fdfdfc] text-slate-800 font-serif flex relative overflow-hidden">
      {/* Notebook Background Pattern */}
      <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/notebook-dark.png')] opacity-10 pointer-events-none mix-blend-multiply" />
      
      {/* Sidebar */}
      <aside className="w-64 border-r-2 border-slate-200 bg-[#fdfdfc]/90 backdrop-blur z-10 flex flex-col hidden md:flex h-screen sticky top-0">
        <div className="p-6 border-b-2 border-slate-200">
          <Link href="/dashboard" className="flex items-center gap-2">
            <BookOpen className="h-6 w-6 text-red-700" />
            <span className="font-bold text-xl text-red-700 tracking-wide">中文</span>
          </Link>
          <p className="text-xs text-slate-500 mt-1 uppercase tracking-widest">Chinese Notebook</p>
        </div>
        
        <div className="flex-1 overflow-y-auto py-6">
          <nav className="space-y-1 px-4">
            <Link href="/dashboard" className="flex items-center gap-3 px-3 py-2 text-slate-700 hover:bg-slate-100 rounded-sm">
              <Home className="h-4 w-4" />
              <span>Trang chủ</span>
            </Link>
            <Link href="/lessons" className="flex items-center gap-3 px-3 py-2 text-slate-700 hover:bg-slate-100 rounded-sm">
              <BookOpen className="h-4 w-4" />
              <span>Bài học</span>
            </Link>
            <Link href="/write" className="flex items-center gap-3 px-3 py-2 text-slate-700 hover:bg-slate-100 rounded-sm">
              <PenTool className="h-4 w-4" />
              <span>Viết</span>
            </Link>
            <Link href="/review" className="flex items-center gap-3 px-3 py-2 text-slate-700 hover:bg-slate-100 rounded-sm">
              <BrainCircuit className="h-4 w-4" />
              <span>Ôn tập</span>
            </Link>
          </nav>
          
          <div className="mt-8 px-4">
            <h3 className="px-3 text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">Chủ đề</h3>
            <nav className="space-y-1">
              {['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6', 'Giao tiếp', 'Công xưởng'].map((topic) => (
                <Link key={topic} href={"/topics?q=" + topic} className="flex items-center px-3 py-1.5 text-sm text-slate-600 hover:text-red-700">
                  <span className="w-1.5 h-1.5 rounded-full bg-slate-300 mr-3"></span>
                  {topic}
                </Link>
              ))}
            </nav>
          </div>
        </div>
        
        <div className="p-4 border-t-2 border-slate-200">
          <Link href="/login" className="flex items-center gap-3 px-3 py-2 text-slate-500 hover:text-red-700 transition-colors">
            <LogOut className="h-4 w-4" />
            <span className="text-sm">Đăng xuất</span>
          </Link>
        </div>
      </aside>

      {/* Main Content */}
      <main className="flex-1 flex flex-col min-h-screen h-full z-10">
        {/* Header */}
        <header className="h-16 border-b-2 border-slate-200 bg-[#fdfdfc]/80 backdrop-blur flex items-center justify-between px-6 sticky top-0 z-20">
          <div className="flex items-center w-full max-w-md bg-transparent border-b-2 border-slate-300 focus-within:border-red-700 transition-colors pb-1">
            <Search className="h-4 w-4 text-slate-400 mr-2" />
            <input 
              type="text" 
              placeholder="Tìm kiếm từ vựng, bài học..." 
              className="bg-transparent border-none outline-none w-full text-slate-700 placeholder:text-slate-400 text-sm font-serif h-8"
            />
          </div>
          <Link href="/lessons/create" className="flex items-center gap-2 bg-slate-800 hover:bg-slate-700 text-white px-4 py-2 rounded-sm text-sm transition-colors">
            <PlusCircle className="h-4 w-4" />
            <span>Tạo bài học</span>
          </Link>
        </header>

        {/* Page Content */}
        <div className="flex-1 p-6 md:p-10 overflow-auto">
          {children}
        </div>
      </main>
    </div>
  )
}
