'use client'

import { useState, Suspense } from 'react'
import { PlayCircle, FileText, ChevronDown, ChevronRight, BookOpen, Layers } from 'lucide-react'
import { useSearchParams } from 'next/navigation'

function TopicContent() {
  const searchParams = useSearchParams()
  const topicName = searchParams?.get('q') || 'HSK 1'
  
  const [expandedModules, setExpandedModules] = useState<number[]>([1]) // Default expand module 1

  const toggleModule = (id: number) => {
    setExpandedModules(prev => 
      prev.includes(id) ? prev.filter(m => m !== id) : [...prev, id]
    )
  }

  return (
    <div className="flex flex-1 overflow-hidden h-full">
      {/* Left Sidebar */}
      <aside className="w-48 lg:w-64 border-r-2 border-slate-200 bg-white flex flex-col shrink-0 overflow-y-auto hidden md:flex">
        <div className="p-4 border-b-2 border-slate-100 flex items-center justify-center">
          <h2 className="font-bold text-xl text-slate-800 tracking-wider text-center">{topicName.toUpperCase()}</h2>
        </div>
        <nav className="flex-1 p-4 space-y-2">
          {[1, 2, 3, 4, 5].map(num => (
            <div 
              key={num}
              className={`flex items-center gap-3 px-4 py-3 rounded-sm cursor-pointer transition-colors ${num === 1 ? 'text-blue-600 font-medium' : 'text-slate-600 hover:text-blue-600'}`}
            >
              <BookOpen className="h-5 w-5 opacity-70" />
              <span className="font-serif text-lg">Bài {num}</span>
            </div>
          ))}
        </nav>
      </aside>

      {/* Main Content Area */}
      <main className="flex-1 flex flex-col overflow-y-auto bg-slate-50">
        {/* Video Player Area */}
        <div className="w-full bg-slate-100 border-b-2 border-slate-200 aspect-video flex flex-col items-center justify-center shrink-0">
          <h2 className="font-sans text-xl text-slate-700 tracking-widest uppercase mb-4 font-bold">VIDEO PLAYER</h2>
          <PlayCircle className="h-16 w-16 text-slate-400 cursor-pointer hover:text-blue-600 transition-colors" />
        </div>

        {/* Lesson Info */}
        <div className="p-6 md:p-10 flex-1 bg-white">
          <div className="max-w-4xl mx-auto text-center border-t border-slate-200 pt-8 mt-4">
             <h3 className="font-serif text-xl text-slate-700">Thông tin bài học</h3>
             <p className="text-slate-500 font-serif mt-4">Nội dung chi tiết của bài học sẽ hiển thị ở đây...</p>
          </div>
        </div>
      </main>

      {/* Right Sidebar (Course Content) */}
      <aside className="w-64 lg:w-80 border-l-2 border-slate-200 bg-white flex flex-col shrink-0 overflow-y-auto hidden lg:flex">
        <div className="p-4 border-b-2 border-slate-100 flex items-center justify-center">
          <h2 className="font-bold text-sm text-slate-700 tracking-widest uppercase text-center">
            NỘI DUNG KHÓA HỌC
          </h2>
        </div>
        
        <div className="flex-1">
          {[1, 2, 3].map(num => (
            <div key={num} className="flex flex-col border-b border-slate-100">
              <button 
                className="flex items-center justify-between p-4 hover:bg-slate-50 transition-colors w-full text-left"
                onClick={() => toggleModule(num)}
              >
                <span className="font-serif text-lg text-slate-700">{num}. Bài {num}</span>
                {expandedModules.includes(num) ? <ChevronDown className="h-4 w-4 text-slate-400" /> : <ChevronRight className="h-4 w-4 text-slate-400" />}
              </button>
              
              {expandedModules.includes(num) && (
                <div className="bg-white flex flex-col pb-3">
                  <div className={`flex items-center gap-3 py-2 px-8 text-base cursor-pointer hover:text-blue-600 transition-colors ${num === 1 ? 'font-medium' : 'text-slate-600'}`}>
                    <PlayCircle className="h-4 w-4 shrink-0" />
                    <span className="font-serif">Video</span>
                  </div>
                  <div className="flex items-center gap-3 py-2 px-8 text-base cursor-pointer hover:text-blue-600 transition-colors text-slate-600">
                    <PlayCircle className="h-4 w-4 shrink-0" />
                    <span className="font-serif">Từ vựng</span>
                  </div>
                  {num === 1 && (
                    <div className="flex items-center gap-3 py-2 px-8 text-base cursor-pointer hover:text-blue-600 transition-colors text-slate-600">
                      <PlayCircle className="h-4 w-4 shrink-0" />
                      <span className="font-serif">Ngữ pháp</span>
                    </div>
                  )}
                </div>
              )}
            </div>
          ))}
        </div>
      </aside>
    </div>
  )
}

export default function TopicPage() {
  return (
    <Suspense fallback={<div className="p-8 text-center font-sans text-slate-500">Đang tải...</div>}>
      <TopicContent />
    </Suspense>
  )
}
