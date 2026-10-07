'use client'

import { useState, useTransition } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { saveVocabularyAction, updateLessonAiDataAction } from '../actions'
import { PlusCircle, ArrowLeft, Edit, Sparkles, BookOpen, Trash2, Loader2, Volume2 } from 'lucide-react'
import HanziWriterComponent from '@/components/hanzi-writer-comp'
import Link from 'next/link'
import { toast } from 'sonner'

type Word = { hanzi: string, pinyin: string, vi: string, example_hanzi?: string, example_pinyin?: string, example_vi?: string }
type Grammar = { structure: string, explanation: string }
type AiData = {
  words?: Word[],
  key_vocab?: Word[],
  pinyin_text?: string,
  translation?: string,
  grammar?: Grammar[]
}

export default function LessonReader({ lesson, aiData, originalText, runAiAction, hasAiData }: { lesson: { id: string, title: string, subtitle?: string | null }, aiData: AiData, originalText: string, runAiAction: (payload: FormData) => Promise<void>, hasAiData: boolean }) {
  const [selectedWord, setSelectedWord] = useState<Word | null>(null)
  const [isSaving, setIsSaving] = useState(false)
  const [isEditMode, setIsEditMode] = useState(false)
  const [isUpdatingVocab, setIsUpdatingVocab] = useState(false)
  const [isAnalyzing, startTransition] = useTransition()
  
  const [wordToDeleteIndex, setWordToDeleteIndex] = useState<number | null>(null)

  const playAudio = (text: string) => {
    if (typeof window !== 'undefined' && window.speechSynthesis) {
      // Cancel any ongoing speech to avoid queueing delays
      window.speechSynthesis.cancel()
      const utterance = new SpeechSynthesisUtterance(text)
      utterance.lang = 'zh-CN'
      utterance.rate = 0.8
      window.speechSynthesis.speak(utterance)
    }
  }

  const handleAiAnalysis = () => {
    startTransition(async () => {
      const toastId = toast.loading('AI đang phân tích bài viết...')
      try {
        await runAiAction(new FormData())
        toast.success('Phân tích AI hoàn tất', { id: toastId })
      } catch (e: unknown) {
        const err = e as { message?: string }
        toast.error(err?.message || 'Không thể phân tích bài viết', { id: toastId })
      }
    })
  }

  const handleSave = async (word: Word) => {
    setIsSaving(true)
    const toastId = toast.loading('Đang lưu từ vựng...')
    try {
      await saveVocabularyAction(word)
      toast.success("Đã lưu vào sổ tay thành công", { id: toastId })
      setSelectedWord(null)
    } catch(e) {
      console.error(e)
      toast.error("Không thể lưu. Vui lòng thử lại.", { id: toastId })
    }
    setIsSaving(false)
  }

  const handleSaveSelected = () => {
    if (selectedWord) handleSave(selectedWord)
  }

  const handleWordClick = async (word: Word) => {
    if (isEditMode) {
      if (!word.vi) return; // Don't add punctuation
      // Check if already in key_vocab
      const keyVocab = aiData.key_vocab || [];
      if (keyVocab.some(v => v.hanzi === word.hanzi)) {
        return; // Already added
      }
      setIsUpdatingVocab(true);
      const toastId = toast.loading('Đang thêm từ vựng...')
      try {
        const newAiData = { ...aiData, key_vocab: [...keyVocab, word] };
        await updateLessonAiDataAction(lesson.id, newAiData);
        toast.success("Đã thêm từ vựng", { id: toastId })
      } catch (e) {
        console.error(e);
        toast.error("Không thể thêm từ vựng", { id: toastId })
      }
      setIsUpdatingVocab(false);
    } else {
      setSelectedWord(word);
    }
  }

  const confirmRemoveWord = (index: number) => {
    setWordToDeleteIndex(index);
  }

  const handleRemoveWord = async () => {
    if (!aiData || wordToDeleteIndex === null) return;
    
    setIsUpdatingVocab(true);
    const toastId = toast.loading('Đang xóa từ vựng...')
    try {
      const newKeyVocab = (aiData.key_vocab || []).filter((_, i) => i !== wordToDeleteIndex);
      const newAiData = { ...aiData, key_vocab: newKeyVocab };
      await updateLessonAiDataAction(lesson.id, newAiData);
      
      setWordToDeleteIndex(null);
      toast.success("Đã xóa khỏi danh sách", { id: toastId })
    } catch (e) {
      console.error(e);
      toast.error("Không thể xóa từ vựng", { id: toastId })
    }
    setIsUpdatingVocab(false);
  }

  const words = aiData?.words || (Array.isArray(aiData) ? aiData : [])
  const keyVocab = aiData?.key_vocab || []
  const grammarList = aiData?.grammar || []

  return (
    <>
      <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-8">
        <Link href="/lessons" className="text-slate-500 hover:text-red-700 flex items-center font-serif transition-colors cursor-pointer shrink-0">
          <ArrowLeft className="h-4 w-4 mr-1" /> Quay lại
        </Link>
        <div className="flex flex-wrap gap-2 w-full sm:w-auto">
          <Button 
            variant={isEditMode ? "default" : "outline"} 
            className={`font-serif rounded-sm cursor-pointer flex-auto sm:flex-none min-w-[80px] ${isEditMode ? 'bg-red-700 hover:bg-red-800 text-white border-red-700' : 'border-slate-300'}`}
            onClick={() => setIsEditMode(!isEditMode)}
          >
            <Edit className="h-4 w-4 mr-2 shrink-0" /> {isEditMode ? "Xong" : "Sửa"}
          </Button>
          <Button 
            disabled={isAnalyzing} 
            onClick={handleAiAnalysis} 
            className="font-serif group cursor-pointer flex-auto sm:flex-none min-w-[140px] sm:min-w-[170px]"
          >
            {isAnalyzing ? (
              <>
                <Loader2 className="h-4 w-4 mr-2 animate-spin shrink-0" /> Đang phân tích...
              </>
            ) : (
              <>
                <Sparkles className="h-4 w-4 mr-2 group-hover:text-amber-300 transition-colors shrink-0" /> <span>{hasAiData ? "Phân tích lại AI" : "Phân tích AI"}</span>
              </>
            )}
          </Button>
        </div>
      </div>

      <div className="text-center mb-12 flex flex-col items-center w-full">
        <div className="flex flex-wrap items-center gap-2 justify-center mb-2 text-slate-500 w-full max-w-full">
          <BookOpen className="h-5 w-5 text-blue-500 shrink-0" />
          <span className="font-sans uppercase tracking-[0.2em] text-sm font-semibold text-center min-w-0 break-words max-w-full">{lesson.title}</span>
        </div>
        {lesson.subtitle && (
          <h2 className="text-xl text-slate-700 font-serif mb-4 min-w-0 break-words max-w-full px-4">{lesson.subtitle}</h2>
        )}
      </div>

      {(!aiData || (!aiData.words && !Array.isArray(aiData))) ? (
        <div className="text-xl md:text-2xl font-serif text-slate-800 leading-relaxed whitespace-pre-wrap tracking-wider break-words max-w-full overflow-hidden">
          {originalText}
        </div>
      ) : (
        <div className="flex flex-col lg:flex-row gap-8 items-start min-w-0 w-full">
          {/* CỘT TRÁI: Nội dung bài học */}
          <div className="flex-1 space-y-12 w-full min-w-0">
            
            {/* Box Tiếng Trung */}
            <div className="border border-slate-800 p-4 md:p-8 relative bg-[#FDFBF7] max-w-full overflow-hidden">
              {/* Corner decorations */}
              <div className="absolute top-0 left-0 w-4 h-4 border-t-2 border-l-2 border-slate-800 -translate-x-[2px] -translate-y-[2px]"></div>
              <div className="absolute top-0 right-0 w-4 h-4 border-t-2 border-r-2 border-slate-800 translate-x-[2px] -translate-y-[2px]"></div>
              <div className="absolute bottom-0 left-0 w-4 h-4 border-b-2 border-l-2 border-slate-800 -translate-x-[2px] translate-y-[2px]"></div>
              <div className="absolute bottom-0 right-0 w-4 h-4 border-b-2 border-r-2 border-slate-800 translate-x-[2px] translate-y-[2px]"></div>
              
              <div className={`text-xl md:text-[28px] font-serif text-slate-800 leading-loose md:leading-[2.5] tracking-widest text-justify break-words ${isUpdatingVocab ? 'opacity-50 pointer-events-none' : ''}`}>
                {words.map((word: Word, idx: number) => (
                  word.hanzi === "\\n" || word.hanzi === "\n" ? (
                     <br key={idx} />
                  ) : (
                    <span 
                      key={idx} 
                      title={word.vi} 
                      onClick={() => handleWordClick(word)}
                      className={`cursor-pointer transition-colors rounded-sm px-0.5 inline-block ${isEditMode && word.vi ? 'hover:bg-blue-100 hover:text-blue-800' : 'hover:text-red-700 hover:bg-red-50'}`}
                    >
                      {word.hanzi}
                    </span>
                  )
                ))}
              </div>
              {isEditMode && (
                <div className="absolute -bottom-6 left-0 text-xs text-blue-600 font-sans max-w-full break-words pr-2">
                  * Nhấp vào một từ trong văn bản để thêm vào danh sách từ vựng.
                </div>
              )}
            </div>

            {/* Phiên âm */}
            {aiData.pinyin_text && (
              <div className="space-y-4 max-w-full">
                <h3 className="text-center font-sans tracking-[0.3em] text-sm text-red-700 font-bold uppercase">PHIÊN ÂM</h3>
                <p className="font-sans text-lg text-slate-700 leading-relaxed text-justify md:px-8 break-words">
                  {aiData.pinyin_text}
                </p>
              </div>
            )}

            {/* Dịch nghĩa */}
            {aiData.translation && (
              <div className="space-y-4 max-w-full">
                <h3 className="text-center font-sans tracking-[0.3em] text-sm text-red-700 font-bold uppercase">DỊCH NGHĨA</h3>
                <p className="font-serif text-lg text-slate-800 leading-relaxed text-justify md:px-8 break-words">
                  {aiData.translation}
                </p>
              </div>
            )}

            {/* Cấu trúc */}
            {grammarList.length > 0 && (
              <div className="space-y-6 pt-4 max-w-full">
                <h3 className="text-center font-sans tracking-[0.3em] text-sm text-red-700 font-bold uppercase">CẤU TRÚC</h3>
                <div className="space-y-6 md:px-8">
                  {grammarList.map((g: Grammar, idx: number) => (
                    <div key={idx} className="space-y-2 min-w-0">
                      <div className="flex gap-2 items-start">
                        <span className="flex-shrink-0 flex items-center justify-center w-5 h-5 rounded-full border border-slate-800 text-xs font-serif mt-1">{idx + 1}</span>
                        <p className="font-serif text-xl text-slate-800 min-w-0 break-words">{g.structure}</p>
                      </div>
                      <p className="pl-7 font-serif text-slate-600 text-base min-w-0 break-words">{g.explanation}</p>
                    </div>
                  ))}
                </div>
              </div>
            )}
            
            {/* Luyện Viết */}
            {keyVocab.length > 0 && (
              <div className="space-y-6 pt-10 mt-8 border-t-2 border-slate-200 border-dashed max-w-full overflow-hidden">
                <h3 className="text-center font-sans tracking-[0.3em] text-sm text-red-700 font-bold uppercase">LUYỆN VIẾT</h3>
                <p className="text-center font-serif text-slate-500 text-sm italic mb-4 px-2">Nhìn cách AI đi nét để học thứ tự viết chữ Hán chuẩn.</p>
                <div className="flex flex-wrap gap-4 md:gap-8 justify-center p-2 md:p-4">
                  {keyVocab.map((vocab: Word, idx: number) => (
                    <div key={idx} className="flex flex-col items-center bg-white p-3 md:p-4 border border-slate-200 rounded-sm shadow-sm max-w-full">
                      <div className="flex flex-wrap justify-center gap-1">
                        {vocab.hanzi.split('').map((char: string, charIdx: number) => {
                          if (/[.,!?，。！？()（）]/.test(char)) return null;
                          return <HanziWriterComponent key={charIdx} character={char} />
                        })}
                      </div>
                      <span className="font-sans text-slate-500 text-sm mt-3 tracking-wider text-center break-words max-w-full">{vocab.pinyin}</span>
                      <span className="font-serif text-slate-800 text-base mt-1 text-center break-words max-w-full">{vocab.vi}</span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* CỘT PHẢI: Từ vựng */}
          {keyVocab.length > 0 && (
            <div className={`w-full lg:w-72 border border-slate-800 p-4 md:p-6 relative bg-[#FDFBF7] flex-shrink-0 min-w-0 ${isUpdatingVocab ? 'opacity-50 pointer-events-none' : ''}`}>
              {/* Corner decorations */}
              <div className="absolute top-0 left-0 w-4 h-4 border-t-2 border-l-2 border-slate-800 -translate-x-[2px] -translate-y-[2px]"></div>
              <div className="absolute top-0 right-0 w-4 h-4 border-t-2 border-r-2 border-slate-800 translate-x-[2px] -translate-y-[2px]"></div>
              <div className="absolute bottom-0 left-0 w-4 h-4 border-b-2 border-l-2 border-slate-800 -translate-x-[2px] translate-y-[2px]"></div>
              <div className="absolute bottom-0 right-0 w-4 h-4 border-b-2 border-r-2 border-slate-800 translate-x-[2px] translate-y-[2px]"></div>
              
              <h3 className="text-center font-sans tracking-[0.2em] text-sm text-slate-800 mb-8 font-semibold">TỪ VỰNG</h3>
              
              <div className="space-y-6 md:space-y-8">
                {keyVocab.map((vocab: Word, idx: number) => (
                  <div key={idx} className="flex flex-col group relative min-w-0">
                    <div className="flex gap-2 md:gap-3 items-start min-w-0 pr-8">
                      <span className="font-serif text-slate-500 mt-1 shrink-0">{idx + 1}.</span>
                      <div className="min-w-0">
                        <div className="flex items-center gap-2 mb-1">
                          <span className="text-2xl md:text-3xl font-serif text-slate-800 break-words">{vocab.hanzi}</span>
                          <button onClick={() => playAudio(vocab.hanzi)} className="text-slate-400 hover:text-red-700 p-1.5 rounded-full hover:bg-red-50 transition-colors cursor-pointer shrink-0" title="Nghe phát âm">
                            <Volume2 className="h-4 w-4" />
                          </button>
                        </div>
                        <div className="text-xs md:text-sm font-sans tracking-widest text-slate-500 break-words">{vocab.pinyin}</div>
                        <div className="text-sm md:text-base font-serif text-slate-700 mt-1 break-words">{vocab.vi}</div>
                      </div>
                    </div>
                    
                    {isEditMode ? (
                      <button 
                        onClick={() => confirmRemoveWord(idx)}
                        className="absolute right-0 top-1/2 -translate-y-1/2 bg-white hover:bg-red-50 border border-slate-200 p-2 rounded-full shadow-sm text-red-500 transition-colors cursor-pointer shrink-0"
                        title="Xóa khỏi danh sách"
                      >
                        <Trash2 className="h-4 w-4" />
                      </button>
                    ) : (
                      <button 
                        onClick={() => handleSave(vocab)}
                        disabled={isSaving}
                        className="absolute right-0 top-1/2 -translate-y-1/2 opacity-0 group-hover:opacity-100 transition-opacity bg-white hover:bg-slate-100 border border-slate-200 p-2 rounded-full shadow-sm shrink-0"
                        title="Lưu vào Sổ tay"
                      >
                        <PlusCircle className="h-5 w-5 text-slate-600" />
                      </button>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      )}

      <Dialog open={!!selectedWord} onOpenChange={(open) => !open && setSelectedWord(null)}>
        <DialogContent className="sm:max-w-md bg-[#FDFBF7] border-2 border-slate-200 shadow-lg rounded-sm w-[90vw] max-w-[400px]">
          <DialogHeader>
            <DialogTitle className="font-serif text-xl text-slate-800">Chi tiết Từ vựng</DialogTitle>
            <DialogDescription className="font-serif">Bạn có muốn lưu từ này vào sổ tay để ôn tập không?</DialogDescription>
          </DialogHeader>
          {selectedWord && (
            <div className="flex flex-col items-center justify-center py-8 min-w-0">
              <span className="text-sm text-slate-500 font-sans tracking-widest mb-2 text-center break-words max-w-full px-4">{selectedWord.pinyin}</span>
              <div className="flex items-center justify-center gap-4 mb-6">
                <span className="text-5xl md:text-6xl font-serif text-red-700 text-center break-words">{selectedWord.hanzi}</span>
                <button 
                  onClick={() => playAudio(selectedWord.hanzi)}
                  className="text-slate-400 hover:text-red-700 p-2.5 rounded-full hover:bg-red-50 transition-colors cursor-pointer"
                  title="Nghe phát âm"
                >
                  <Volume2 className="h-6 w-6" />
                </button>
              </div>
              <div className="bg-slate-100 px-4 py-2 border border-slate-200 rounded-sm max-w-full">
                <span className="text-base md:text-lg font-serif text-slate-800 text-center break-words block">{selectedWord.vi || "(Dấu câu)"}</span>
              </div>
            </div>
          )}
          <DialogFooter className="flex-col sm:flex-row sm:justify-between border-t-2 border-slate-100 pt-4 mt-2 gap-2">
            <Button variant="outline" onClick={() => setSelectedWord(null)} className="font-serif rounded-sm border-slate-300 w-full sm:w-auto">
              Đóng
            </Button>
            <Button onClick={handleSaveSelected} disabled={isSaving || !selectedWord?.vi} className="font-serif w-full sm:w-auto">
              {isSaving ? "Đang lưu..." : "Lưu vào Sổ tay"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Xác nhận xóa từ vựng */}
      <Dialog open={wordToDeleteIndex !== null} onOpenChange={(open) => !isUpdatingVocab && !open && setWordToDeleteIndex(null)}>
        <DialogContent className="sm:max-w-md border-red-700/20 w-[90vw] max-w-[400px]">
          <DialogHeader>
            <DialogTitle className="font-serif text-xl text-slate-800">Xóa từ vựng</DialogTitle>
            <DialogDescription className="font-serif text-base text-slate-600">
              Bạn có chắc chắn muốn xóa từ vựng này khỏi danh sách ôn tập không?
            </DialogDescription>
          </DialogHeader>
          <DialogFooter className="flex-col sm:flex-row mt-4 gap-2 sm:gap-0">
            <Button variant="outline" onClick={() => setWordToDeleteIndex(null)} disabled={isUpdatingVocab} className="font-serif rounded-sm cursor-pointer w-full sm:w-auto">
              Hủy bỏ
            </Button>
            <Button onClick={handleRemoveWord} disabled={isUpdatingVocab} className="font-serif cursor-pointer w-full sm:w-auto">
              {isUpdatingVocab ? "Đang xử lý..." : "Có, xóa ngay"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  )
}
