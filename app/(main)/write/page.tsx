'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Textarea } from '@/components/ui/textarea'
import { correctWritingAction } from './actions'
import { PenTool, CheckCircle2, Sparkles, Loader2, AlertCircle, XCircle, CheckCircle, BookOpen, Lightbulb } from 'lucide-react'
import { toast } from 'sonner'

interface AIResult {
  score: number;
  level: string;
  summary: string;
  correctedText: string;
  errors: Array<{
    original: string;
    correction: string;
    type: string;
    severity: string;
    explanation: string;
    reason: string;
  }>;
  strengths: string[];
  weaknesses: string[];
  vocabularySuggestions: Array<{
    word: string;
    pinyin: string;
    meaning: string;
    example: string;
  }>;
  learningSuggestions: string[];
  scoreDetails: {
    grammar: number;
    vocabulary: number;
    wordOrder: number;
    naturalness: number;
    coherence: number;
    hskAppropriateness: number;
  };
}

export default function WritingClient() {
  const [text, setText] = useState('')
  const [level, setLevel] = useState('Chưa xác định')
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [result, setResult] = useState<AIResult | null>(null)
  const [errorMsg, setErrorMsg] = useState<string | null>(null)

  const handleSubmit = async () => {
    if (!text.trim()) {
      setErrorMsg("Vui lòng nhập bài viết trước khi phân tích.")
      return
    }
    setIsSubmitting(true)
    setErrorMsg(null)
    setResult(null)
    
    const toastId = toast.loading('AI đang kiểm tra ngữ pháp, từ vựng và độ tự nhiên...')
    
    try {
      const res = await correctWritingAction(text, level)
      if (res.error) {
        setErrorMsg(res.error)
        toast.error('Không thể phân tích bài viết. Vui lòng thử lại.', { id: toastId })
      } else if (res.data) {
        setResult(res.data)
        if (res.data.level && res.data.level.startsWith('HSK')) {
          setLevel(res.data.level)
        }
        toast.success('Phân tích hoàn tất', { id: toastId })
      }
    } catch (err: unknown) {
      const error = err as Error;
      const msg = error.message || "Lỗi không xác định khi kết nối với máy chủ."
      setErrorMsg(msg)
      toast.error('Không thể phân tích bài viết. Vui lòng thử lại.', { id: toastId })
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <div className="max-w-4xl mx-auto pb-20 space-y-8">
      <div className="border-b-2 border-red-700/30 pb-6">
        <h1 className="text-3xl font-serif text-slate-800 mb-2 flex items-center gap-3">
          <PenTool className="text-red-700" /> Luyện Viết (AI sửa)
        </h1>
        <p className="text-slate-500 font-serif">Viết một đoạn văn tiếng Trung và nhờ AI chấm điểm, sửa lỗi ngữ pháp.</p>
      </div>

      <div className="space-y-4">
        <div className="flex gap-4 items-center flex-wrap">
          <span className="font-medium text-slate-700">Trình độ của bạn:</span>
          <select 
            value={level}
            onChange={(e) => setLevel(e.target.value)}
            className="border-2 border-slate-200 rounded-md p-2 font-serif focus:border-red-500 outline-none"
          >
            <option value="Chưa xác định">Chưa xác định</option>
            <option value="HSK1">HSK 1 (Sơ cấp)</option>
            <option value="HSK2">HSK 2</option>
            <option value="HSK3">HSK 3</option>
            <option value="HSK4">HSK 4 (Trung cấp)</option>
            <option value="HSK5">HSK 5</option>
            <option value="HSK6">HSK 6 (Cao cấp)</option>
          </select>
        </div>

        <div className="bg-[#FDFBF7] p-6 border-2 border-slate-200 shadow-sm relative">
          <Textarea 
            placeholder="Nhập đoạn văn tiếng Trung của bạn vào đây... (Ví dụ: 我今天去超市买东西...)"
            className="min-h-[200px] text-lg font-serif resize-y bg-transparent border-none focus-visible:ring-0 pl-10 pr-4 py-4 leading-loose tracking-wide disabled:opacity-50"
            value={text}
            onChange={(e) => setText(e.target.value)}
            disabled={isSubmitting}
          />
          <div className="absolute left-8 top-0 bottom-0 w-0.5 bg-red-700/20 pointer-events-none"></div>
          <div className="absolute left-10 top-0 bottom-0 w-0.5 bg-red-700/20 pointer-events-none"></div>
        </div>

        {errorMsg && (
          <div className="bg-red-50 text-red-700 p-4 border border-red-200 rounded-md flex items-start gap-2">
            <AlertCircle className="shrink-0 mt-0.5" size={18} />
            <p>{errorMsg}</p>
          </div>
        )}

        <div className="flex justify-end">
          <Button 
            onClick={handleSubmit} 
            disabled={!text.trim() || isSubmitting}
            size="lg" className="font-serif text-lg w-full md:w-auto mt-4"
          >
            {isSubmitting ? (
              <><Loader2 className="mr-2 h-5 w-5 animate-spin" /> Đang phân tích...</>
            ) : (
              <><Sparkles className="mr-2 h-5 w-5" /> Phân tích bài viết</>
            )}
          </Button>
        </div>
      </div>

      {result && (
        <div className="bg-white border-2 border-slate-200 p-6 md:p-8 shadow-sm space-y-10 animate-in fade-in slide-in-from-bottom-4">
          
          {/* ĐIỂM */}
          <div className="grid md:grid-cols-[auto_1fr] gap-8 border-b pb-8">
            <div className="flex flex-col items-center justify-center space-y-2">
              <div className="bg-green-100 text-green-800 text-5xl font-serif p-4 rounded-full w-32 h-32 flex items-center justify-center border-4 border-green-200 shadow-inner">
                {result.score}
              </div>
              <span className="text-sm font-medium text-slate-500 uppercase tracking-widest">Điểm Tổng</span>
              <span className="bg-red-100 text-red-800 font-bold px-4 py-1 rounded-full text-sm mt-2 border border-red-200 shadow-sm">
                Đánh giá năng lực: {result.level}
              </span>
            </div>
            
            <div className="flex flex-col justify-center space-y-4">
              <h2 className="text-2xl font-serif text-slate-800 border-b pb-2">Chi tiết tiêu chí</h2>
              <div className="grid grid-cols-2 gap-4">
                <div className="flex justify-between border-b border-dashed pb-1">
                  <span className="text-slate-600">Ngữ pháp</span>
                  <span className="font-semibold text-slate-800">{result.scoreDetails?.grammar || 0}/30</span>
                </div>
                <div className="flex justify-between border-b border-dashed pb-1">
                  <span className="text-slate-600">Từ vựng</span>
                  <span className="font-semibold text-slate-800">{result.scoreDetails?.vocabulary || 0}/20</span>
                </div>
                <div className="flex justify-between border-b border-dashed pb-1">
                  <span className="text-slate-600">Trật tự từ</span>
                  <span className="font-semibold text-slate-800">{result.scoreDetails?.wordOrder || 0}/15</span>
                </div>
                <div className="flex justify-between border-b border-dashed pb-1">
                  <span className="text-slate-600">Độ tự nhiên</span>
                  <span className="font-semibold text-slate-800">{result.scoreDetails?.naturalness || 0}/15</span>
                </div>
                <div className="flex justify-between border-b border-dashed pb-1">
                  <span className="text-slate-600">Mạch lạc</span>
                  <span className="font-semibold text-slate-800">{result.scoreDetails?.coherence || 0}/10</span>
                </div>
                <div className="flex justify-between border-b border-dashed pb-1">
                  <span className="text-slate-600">Chuẩn HSK</span>
                  <span className="font-semibold text-slate-800">{result.scoreDetails?.hskAppropriateness || 0}/10</span>
                </div>
              </div>
              <p className="text-slate-700 italic mt-2">&quot;{result.summary}&quot;</p>
            </div>
          </div>

          {/* BÀI VIẾT GỐC & SỬA */}
          <div className="grid md:grid-cols-2 gap-6">
            <div className="space-y-3">
              <h3 className="font-sans tracking-[0.2em] text-sm text-slate-500 uppercase flex items-center gap-2">
                Bài viết gốc
              </h3>
              <div className="bg-slate-50 p-4 rounded-md border border-slate-200 min-h-[150px] text-lg font-serif leading-loose whitespace-pre-wrap">
                {text}
              </div>
            </div>
            <div className="space-y-3">
              <h3 className="font-sans tracking-[0.2em] text-sm text-slate-500 uppercase flex items-center gap-2">
                <CheckCircle2 className="h-4 w-4 text-green-500" /> Bài viết đã sửa
              </h3>
              <div className="bg-green-50 p-4 rounded-md border border-green-200 min-h-[150px] text-lg font-serif leading-loose whitespace-pre-wrap">
                {result.correctedText}
              </div>
            </div>
          </div>

          {/* LỖI CẦN CẢI THIỆN */}
          <div className="space-y-4">
            <h3 className="font-sans tracking-[0.2em] text-sm text-slate-500 uppercase border-b pb-2">
              Lỗi cần cải thiện
            </h3>
            {(!result.errors || result.errors.length === 0) ? (
              <p className="text-slate-500 italic">Không tìm thấy lỗi đáng kể nào! Bài viết của bạn rất tốt.</p>
            ) : (
              <div className="space-y-4">
                {result.errors.map((err, idx) => (
                  <div key={idx} className="bg-white border rounded-md p-4 shadow-sm space-y-3">
                    <div className="flex items-start gap-3">
                      {err.severity === 'error' ? (
                        <XCircle className="text-red-500 shrink-0 mt-1" size={20} />
                      ) : (
                        <AlertCircle className="text-amber-500 shrink-0 mt-1" size={20} />
                      )}
                      <div>
                        <span className={"text-xs font-semibold px-2 py-1 rounded mr-2 uppercase " + (err.severity === 'error' ? 'bg-red-100 text-red-700' : 'bg-amber-100 text-amber-700')}>
                          {err.severity === 'error' ? 'LỖI (' + err.type + ')' : 'GỢI Ý (' + err.type + ')'}
                        </span>
                        <span className="text-lg line-through text-slate-500">{err.original}</span>
                      </div>
                    </div>
                    <div className="flex items-start gap-3">
                      <CheckCircle className="text-green-500 shrink-0 mt-1" size={20} />
                      <div className="text-lg text-slate-800">{err.correction}</div>
                    </div>
                    <div className="pl-8 pt-2 border-t mt-2">
                      <p className="text-slate-700"><strong>Giải thích:</strong> {err.explanation}</p>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* TỪ VỰNG GỢI Ý & GỢI Ý HỌC TẬP */}
          <div className="grid md:grid-cols-2 gap-8">
            <div className="space-y-4">
              <h3 className="font-sans tracking-[0.2em] text-sm text-slate-500 uppercase flex items-center gap-2 border-b pb-2">
                <BookOpen className="h-4 w-4" /> Từ vựng gợi ý
              </h3>
              {result.vocabularySuggestions?.length > 0 ? (
                <ul className="space-y-4">
                  {result.vocabularySuggestions.map((v, idx) => (
                    <li key={idx} className="bg-slate-50 p-3 rounded border">
                      <div className="flex items-baseline gap-2 mb-1">
                        <span className="text-xl font-bold text-red-700">{v.word}</span>
                        <span className="text-sm text-slate-500">{v.pinyin}</span>
                      </div>
                      <p className="text-slate-700 mb-1">{v.meaning}</p>
                      <p className="text-sm text-slate-500 italic">Ví dụ: {v.example}</p>
                    </li>
                  ))}
                </ul>
              ) : (
                <p className="text-slate-500 italic">Không có từ vựng gợi ý mới.</p>
              )}
            </div>

            <div className="space-y-4">
              <h3 className="font-sans tracking-[0.2em] text-sm text-slate-500 uppercase flex items-center gap-2 border-b pb-2">
                <Lightbulb className="h-4 w-4 text-amber-500" /> Gợi ý học tập
              </h3>
              {result.learningSuggestions?.length > 0 ? (
                <ul className="list-disc pl-5 space-y-2 text-slate-700 leading-relaxed">
                  {result.learningSuggestions.map((s, idx) => (
                    <li key={idx}>{s}</li>
                  ))}
                </ul>
              ) : (
                <p className="text-slate-500 italic">Hãy tiếp tục phát huy nhé!</p>
              )}
            </div>
          </div>
          
        </div>
      )}
    </div>
  )
}
