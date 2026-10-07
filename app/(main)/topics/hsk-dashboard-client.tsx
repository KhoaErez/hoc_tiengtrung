'use client'

import { useState } from 'react'
import Link from 'next/link'
import { BookOpen, CheckCircle2, ChevronRight, PlayCircle, Sparkles, BookType, GraduationCap, WholeWord } from 'lucide-react'
import { Button } from '@/components/ui/button'

const HSK_TOTAL_VOCAB: Record<string, number> = {
  'HSK 1': 150,
  'HSK 2': 150,
  'HSK 3': 300,
  'HSK 4': 600,
  'HSK 5': 1300,
  'HSK 6': 2500
}

type Lesson = {
  id: string
  title: string
  subtitle?: string | null
  lesson_number?: number | null
  vocab_count?: number
}

export default function HskDashboardClient({
  currentHsk,
  lessons,
  userVocabCount,
  reviewVocabCount,
  recentVocabs,
  globalVocabs = [],
  isLoggedIn
}: {
  currentHsk: string
  lessons: Lesson[]
  userVocabCount: number
  reviewVocabCount: number
  recentVocabs?: { hanzi: string; pinyin: string; vi: string }[]
  globalVocabs?: { id: string; hanzi: string; pinyin: string; meaning_vi: string }[]
  isLoggedIn: boolean
}) {
  const [activeTab, setActiveTab] = useState<'lessons' | 'vocab'>('lessons')
  const totalVocab = HSK_TOTAL_VOCAB[currentHsk] || 150
  const progressPercent = Math.min(100, Math.round((userVocabCount / totalVocab) * 100))

  // In curriculum mode, maybe find the first lesson that is not 100% completed?
  // For now, if no progress tracking per lesson, we just continue from lesson 1 or let user pick.
  const nextLesson = lessons.length > 0 ? lessons[0] : null

  return (
    <div className="min-h-full font-serif">
      
      {/* 1. LEVEL SELECTOR (Sticky on mobile) */}
      <div className="bg-white/80 backdrop-blur-md border-b-2 border-slate-200 sticky top-0 z-10 -mx-4 md:-mx-10 px-4 md:px-10 mb-8">
        <div className="max-w-4xl mx-auto">
          <div className="flex overflow-x-auto hide-scrollbar snap-x snap-mandatory">
            {['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6', 'Giao tiếp', 'Công xưởng'].map((level) => (
              <Link 
                key={level} 
                href={`/topics?q=${level}`}
                className={`snap-start whitespace-nowrap px-6 py-4 text-sm font-sans tracking-widest uppercase transition-colors border-b-2 font-semibold ${
                  currentHsk === level 
                    ? 'border-red-700 text-red-700' 
                    : 'border-transparent text-slate-500 hover:text-slate-800'
                }`}
              >
                {level}
              </Link>
            ))}
          </div>
        </div>
      </div>

      <div className="max-w-4xl mx-auto w-full space-y-12">
        
        {/* 2. HEADER & OVERVIEW */}
        <section className="space-y-6">
          <div className="flex flex-col md:flex-row md:items-end justify-between gap-6">
            <div>
              <h1 className="text-4xl md:text-5xl font-serif text-slate-800 tracking-tight">Khu vực {currentHsk}</h1>
              <p className="text-slate-500 mt-2 text-lg">Chinh phục cấp độ {currentHsk} với các bài học và từ vựng.</p>
            </div>
            
            {/* Continue Learning CTA */}
            {isLoggedIn && (
              <div className="shrink-0 w-full md:w-auto">
                {reviewVocabCount > 0 ? (
                   <Link href="/review">
                     <Button className="w-full md:w-auto font-serif bg-amber-600 hover:bg-amber-700 text-white rounded-sm py-6 px-8 shadow-md hover:shadow-lg transition-all text-lg">
                       Ôn tập {reviewVocabCount} từ vựng
                     </Button>
                   </Link>
                ) : nextLesson ? (
                  <Link href={`/lessons/${nextLesson.id}`}>
                    <Button className="w-full md:w-auto font-serif bg-red-700 hover:bg-red-800 text-white rounded-sm py-6 px-8 shadow-md hover:shadow-lg transition-all text-lg group">
                      Học tiếp bài {lessons.findIndex(l => l.id === nextLesson.id) + 1}
                      <ChevronRight className="ml-2 h-5 w-5 group-hover:translate-x-1 transition-transform" />
                    </Button>
                  </Link>
                ) : (
                  <Button className="w-full md:w-auto font-serif bg-blue-700 hover:bg-blue-800 text-white rounded-sm py-6 px-8 shadow-md hover:shadow-lg transition-all text-lg group cursor-not-allowed opacity-50">
                    Chưa có bài học
                  </Button>
                )}
              </div>
            )}
          </div>

          {/* Progress Dashboard */}
          {isLoggedIn && (
            <div className="bg-white border-2 border-slate-200 p-6 md:p-8 rounded-sm shadow-sm">
              <div className="flex flex-col md:flex-row md:items-center gap-8">
                
                <div className="flex-1 space-y-3">
                  <div className="flex justify-between items-end">
                    <span className="font-sans uppercase tracking-widest text-xs text-slate-500 font-semibold">Tiến độ Từ vựng</span>
                    <span className="font-serif text-2xl text-slate-800">{progressPercent}%</span>
                  </div>
                  <div className="w-full bg-slate-100 h-3 rounded-full overflow-hidden">
                    <div 
                      className="bg-red-700 h-full rounded-full transition-all duration-1000 ease-out"
                      style={{ width: `${progressPercent}%` }}
                    />
                  </div>
                </div>

                <div className="flex gap-8 md:border-l-2 md:border-slate-100 md:pl-8">
                  <div>
                    <span className="block font-sans uppercase tracking-widest text-xs text-slate-500 mb-1 font-semibold">Đã học</span>
                    <span className="font-serif text-2xl text-slate-800">{userVocabCount} <span className="text-base text-slate-500">/ {totalVocab} từ</span></span>
                  </div>
                  <div>
                    <span className="block font-sans uppercase tracking-widest text-xs text-slate-500 mb-1 font-semibold">Bài học</span>
                    <span className="font-serif text-2xl text-slate-800">{lessons.length}</span>
                  </div>
                </div>
                
              </div>
            </div>
          )}

          {!isLoggedIn && (
            <div className="bg-white border-2 border-slate-200 p-8 rounded-sm text-center">
              <GraduationCap className="h-12 w-12 text-slate-300 mx-auto mb-4" />
              <h3 className="text-xl font-serif text-slate-700 mb-2">Bạn chưa đăng nhập</h3>
              <p className="text-slate-500 mb-6 font-serif max-w-md mx-auto">Đăng nhập để theo dõi tiến độ HSK, học từ vựng và tự động lưu các bài học của bạn.</p>
              <Link href="/login">
                <Button className="font-serif px-8 bg-red-700 hover:bg-red-800">Đăng nhập ngay</Button>
              </Link>
            </div>
          )}
        </section>

        {/* 3. TABS: LEARNING PATH (LESSONS) & VOCABULARY */}
        {isLoggedIn && (
          <section className="space-y-6">
            
            <div className="flex border-b-2 border-slate-200">
              <button 
                onClick={() => setActiveTab('lessons')}
                className={`flex items-center gap-2 px-6 py-4 font-serif text-lg transition-colors border-b-2 -mb-[2px] ${
                  activeTab === 'lessons' 
                    ? 'border-red-700 text-red-700' 
                    : 'border-transparent text-slate-500 hover:text-slate-800'
                }`}
              >
                <BookType className="h-5 w-5" />
                Lộ trình Bài học
              </button>
              <button 
                onClick={() => setActiveTab('vocab')}
                className={`flex items-center gap-2 px-6 py-4 font-serif text-lg transition-colors border-b-2 -mb-[2px] ${
                  activeTab === 'vocab' 
                    ? 'border-red-700 text-red-700' 
                    : 'border-transparent text-slate-500 hover:text-slate-800'
                }`}
              >
                <WholeWord className="h-5 w-5" />
                Từ vựng ({globalVocabs.length})
              </button>
            </div>

            {activeTab === 'lessons' && (
              <>
                {lessons.length === 0 ? (
                  <div className="border-2 border-dashed border-slate-300 p-10 text-center bg-white/50 rounded-sm">
                    <BookOpen className="h-12 w-12 text-slate-300 mx-auto mb-4" />
                    <h3 className="text-lg font-serif text-slate-700 mb-2">Chưa có bài học nào trong {currentHsk}</h3>
                    <p className="text-slate-500 mb-6 text-sm font-serif">Hãy tạo bài học đầu tiên để bắt đầu lộ trình của bạn.</p>
                    <Link href="/lessons/create">
                      <Button variant="outline" className="font-serif border-slate-300">Tạo bài học mới</Button>
                    </Link>
                  </div>
                ) : (
                  <div className="relative">
                    {/* Path line */}
                    <div className="absolute left-6 top-10 bottom-10 w-0.5 bg-slate-200 hidden sm:block"></div>
                    
                    <div className="space-y-4 md:space-y-6 relative">
                      {lessons.map((lesson) => {
                        return (
                          <Link 
                            key={lesson.id} 
                            href={`/lessons/${lesson.id}`}
                            className="block group"
                          >
                            <div className="flex flex-col sm:flex-row gap-4 sm:gap-6 items-center justify-between p-5 md:p-6 bg-white border-2 border-slate-200 hover:border-red-700/50 transition-all rounded-sm shadow-sm hover:shadow-md">
                              
                              <div className="flex-1 min-w-0">
                                <h3 className="text-xl md:text-2xl font-serif text-slate-800 mb-1 group-hover:text-red-700 transition-colors">
                                  {lesson.title}
                                </h3>
                                
                                {lesson.subtitle && (
                                  <p className="text-slate-500 font-serif text-base mb-3">{lesson.subtitle}</p>
                                )}

                                <div className="flex items-center gap-2 mt-2">
                                  <div className="flex items-center gap-1.5 text-sm font-sans text-slate-500 bg-slate-50 px-3 py-1 rounded-full border border-slate-200">
                                    <WholeWord className="h-4 w-4" /> 
                                    {lesson.vocab_count || 0} từ vựng
                                  </div>
                                </div>
                              </div>
                              
                              <div className="shrink-0 text-slate-300 group-hover:text-red-700 transition-colors bg-slate-50 group-hover:bg-red-50 p-3 rounded-full">
                                <ChevronRight className="h-6 w-6" />
                              </div>
                            </div>
                          </Link>
                        )
                      })}
                    </div>
                  </div>
                )}
              </>
            )}

            {activeTab === 'vocab' && (
              <div className="bg-white border-2 border-slate-200 rounded-sm overflow-hidden">
                {globalVocabs.length === 0 ? (
                  <div className="p-10 text-center text-slate-500 font-serif">
                    Chưa có từ vựng nào trong danh sách.
                  </div>
                ) : (
                  <div className="flex flex-col divide-y divide-slate-100">
                    {globalVocabs.map((v, i) => (
                      <div key={v.id} className="flex items-center justify-between p-4 md:p-6 hover:bg-red-50/30 transition-colors group">
                        <div className="flex items-center gap-4 md:gap-10 w-full">
                          <span className="text-slate-300 font-sans text-sm w-4 md:w-8 shrink-0 text-right">{i + 1}</span>
                          <div className="flex flex-col gap-1 w-24 md:w-32 shrink-0">
                            <span className="text-3xl md:text-4xl font-serif text-slate-800 group-hover:text-red-700 transition-colors">{v.hanzi}</span>
                            <span className="text-sm text-slate-500 font-sans">{v.pinyin}</span>
                          </div>
                          <div className="text-base md:text-lg font-serif text-slate-600 border-l-2 border-slate-100 pl-4 md:pl-8 py-2 flex-1">
                            {v.meaning_vi}
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )}
          </section>
        )}

        {/* 4. RECENT VOCABULARY */}
        {isLoggedIn && recentVocabs && recentVocabs.length > 0 && (
          <section className="space-y-6">
            <div className="flex items-center justify-between border-b-2 border-slate-200 pb-2">
              <h2 className="text-xl font-serif text-slate-800 flex items-center gap-2">
                Từ vựng đã lưu
              </h2>
            </div>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
              {recentVocabs.map((word) => (
                <div key={word.hanzi} className="border-2 border-slate-200 p-4 flex flex-col items-center justify-center rounded-sm bg-white hover:bg-slate-50 hover:border-red-700/30 transition-colors group relative overflow-hidden h-32">
                  <div className="absolute top-0 right-0 w-8 h-8 bg-red-700/5 rotate-45 translate-x-4 -translate-y-4 group-hover:bg-red-700/10 transition-colors"></div>
                  <span className="text-xs text-slate-400 mb-1 font-sans tracking-wide">{word.pinyin}</span>
                  <span className="text-3xl font-serif text-slate-800 mb-2 group-hover:text-red-700 transition-colors">{word.hanzi}</span>
                  <span className="text-sm text-slate-600 font-serif text-center line-clamp-1 px-2">{word.vi}</span>
                </div>
              ))}
            </div>
          </section>
        )}
      </div>
      
      {/* Required style to hide scrollbar for level selector */}
      <style dangerouslySetInnerHTML={{__html: `
        .hide-scrollbar::-webkit-scrollbar {
          display: none;
        }
        .hide-scrollbar {
          -ms-overflow-style: none;
          scrollbar-width: none;
        }
      `}} />
    </div>
  )
}
