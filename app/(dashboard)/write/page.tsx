'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Textarea } from '@/components/ui/textarea'
import { correctWritingAction } from './actions'
import { PenTool, CheckCircle2, Sparkles, Loader2 } from 'lucide-react'

export default function WritingClient() {
  const [text, setText] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [result, setResult] = useState<{ score: number, corrected_text: string, feedback: string } | null>(null)

  const handleSubmit = async () => {
    if (!text.trim()) return
    setIsSubmitting(true)
    try {
      const res = await correctWritingAction(text)
      setResult(res)
    } catch {
      alert("Lỗi kết nối AI")
    }
    setIsSubmitting(false)
  }

  return (
    <div className="max-w-4xl mx-auto pb-20 space-y-8">
      <div className="border-b-2 border-red-700/30 pb-6">
        <h1 className="text-3xl font-serif text-slate-800 mb-2 flex items-center gap-3">
          <PenTool className="text-red-700" /> Luyện Viết (AI sửa)
        </h1>
        <p className="text-slate-500 font-serif">Viết một đoạn văn tiếng Trung và nhờ AI chấm điểm, sửa lỗi ngữ pháp.</p>
      </div>

      <div className="bg-[#FDFBF7] p-6 border-2 border-slate-200 shadow-sm relative">
        <Textarea 
          placeholder="Nhập đoạn văn tiếng Trung của bạn vào đây... (Ví dụ: 我今天去超市买东西...)"
          className="min-h-[200px] text-lg font-serif resize-y bg-transparent border-none focus-visible:ring-0 px-4 py-4 leading-loose tracking-wide"
          value={text}
          onChange={(e) => setText(e.target.value)}
        />
        <div className="absolute left-8 top-0 bottom-0 w-0.5 bg-red-700/20 pointer-events-none"></div>
        <div className="absolute left-10 top-0 bottom-0 w-0.5 bg-red-700/20 pointer-events-none"></div>
      </div>

      <div className="flex justify-end">
        <Button 
          onClick={handleSubmit} 
          disabled={!text.trim() || isSubmitting}
          className="bg-red-700 hover:bg-red-800 text-white font-serif px-8 py-6 rounded-sm text-lg shadow-sm"
        >
          {isSubmitting ? (
            <><Loader2 className="mr-2 h-5 w-5 animate-spin" /> Đang chấm điểm...</>
          ) : (
            <><Sparkles className="mr-2 h-5 w-5" /> Nhờ AI Chấm Điểm</>
          )}
        </Button>
      </div>

      {result && (
        <div className="bg-white border-2 border-slate-200 p-8 shadow-sm space-y-8 animate-in fade-in slide-in-from-bottom-4">
          <div className="flex items-center gap-4 border-b pb-4">
            <div className="bg-green-100 text-green-800 text-4xl font-serif p-4 rounded-full w-24 h-24 flex items-center justify-center border-4 border-green-200">
              {result.score}/10
            </div>
            <div>
              <h2 className="text-2xl font-serif text-slate-800">Kết quả đánh giá</h2>
              <p className="text-slate-500 font-serif">AI đã phân tích bài viết của bạn</p>
            </div>
          </div>
          
          <div className="space-y-4">
            <h3 className="font-sans tracking-[0.2em] text-sm text-slate-500 uppercase flex items-center gap-2">
              <CheckCircle2 className="h-4 w-4 text-green-500" /> Bài viết đã sửa chuẩn
            </h3>
            <p className="text-xl font-serif text-slate-800 leading-loose bg-green-50 p-6 rounded-sm border border-green-100">
              {result.corrected_text}
            </p>
          </div>

          <div className="space-y-4">
            <h3 className="font-sans tracking-[0.2em] text-sm text-slate-500 uppercase">Nhận xét chi tiết</h3>
            <p className="text-lg font-serif text-slate-700 leading-relaxed whitespace-pre-wrap">
              {result.feedback}
            </p>
          </div>
        </div>
      )}
    </div>
  )
}
