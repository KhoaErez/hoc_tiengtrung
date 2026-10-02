'use client'

import { useState } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { saveVocabularyAction, updateLessonAiDataAction } from '../actions'
import { PlusCircle, ArrowLeft, Edit, Sparkles, BookOpen, Trash2 } from 'lucide-react'
import HanziWriterComponent from '@/components/hanzi-writer-comp'
import Link from 'next/link'

type Word = { hanzi: string, pinyin: string, vi: string }
type Grammar = { structure: string, explanation: string }
type AiData = {
  words?: Word[],
  key_vocab?: Word[],
  pinyin_text?: string,
  translation?: string,
  grammar?: Grammar[]
}

export default function LessonReader({ lesson, aiData, originalText, runAiAction, hasAiData }: { lesson: { id: string, title: string, subtitle?: string | null }, aiData: AiData, originalText: string, runAiAction: (payload: FormData) => void, hasAiData: boolean }) {
  const [selectedWord, setSelectedWord] = useState<Word | null>(null)
  const [isSaving, setIsSaving] = useState(false)
  const [isEditMode, setIsEditMode] = useState(false)
  const [isUpdatingVocab, setIsUpdatingVocab] = useState(false)

  const handleSave = async (word: Word) => {
    setIsSaving(true)
    try {
      await saveVocabularyAction(word)
      alert("Đã lưu vào sổ tay thành công!")
      setSelectedWord(null)
    } catch(e) {
      console.error(e)
      alert("Lỗi khi lưu từ vựng")
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
      try {
        const newAiData = { ...aiData, key_vocab: [...keyVocab, word] };
        await updateLessonAiDataAction(lesson.id, newAiData);
      } catch (e) {
        console.error(e);
        alert("Lỗi khi thêm từ vựng");
      }
      setIsUpdatingVocab(false);
    } else {
      setSelectedWord(word);
    }
  }

  const handleRemoveWord = async (index: number) => {
    if (!aiData) return;
    setIsUpdatingVocab(true);
    try {
      const newKeyVocab = (aiData.key_vocab || []).filter((_, i) => i !== index);
      const newAiData = { ...aiData, key_vocab: newKeyVocab };
      await updateLessonAiDataAction(lesson.id, newAiData);
    } catch (e) {
      console.error(e);
      alert("Lỗi khi xóa từ vựng");
    }
    setIsUpdatingVocab(false);
  }

  const words = aiData?.words || (Array.isArray(aiData) ? aiData : [])
  const keyVocab = aiData?.key_vocab || []
  const grammarList = aiData?.grammar || []

  return (
    <>
      <div className="flex items-center justify-between mb-8">
        <Link href="/lessons" className="text-slate-500 hover:text-red-700 flex items-center font-serif transition-colors cursor-pointer">
          <ArrowLeft className="h-4 w-4 mr-1" /> Quay lại
        </Link>
        <div className="flex gap-2">
          <Button 
            variant={isEditMode ? "default" : "outline"} 
            className={`font-serif rounded-sm cursor-pointer ${isEditMode ? 'bg-red-700 hover:bg-red-800 text-white border-red-700' : 'border-slate-300'}`}
            onClick={() => setIsEditMode(!isEditMode)}
          >
            <Edit className="h-4 w-4 mr-2" /> {isEditMode ? "Xong" : "Sửa"}
          </Button>
          <form action={runAiAction}>
             <Button type="submit" className="font-serif rounded-sm bg-slate-800 hover:bg-slate-700 text-white group cursor-pointer">
               <Sparkles className="h-4 w-4 mr-2 group-hover:text-amber-300 transition-colors" /> {hasAiData ? "Phân tích lại AI" : "Phân tích AI"}
             </Button>
          </form>
        </div>
      </div>

      <div className="text-center mb-12 flex flex-col items-center">
        <div className="flex items-center gap-2 justify-center mb-2 text-slate-500">
          <BookOpen className="h-5 w-5 text-blue-500" />
          <span className="font-sans uppercase tracking-[0.2em] text-sm font-semibold">{lesson.title}</span>
        </div>
        {lesson.subtitle && (
          <h2 className="text-xl text-slate-700 font-serif mb-4">{lesson.subtitle}</h2>
        )}
      </div>

      {(!aiData || (!aiData.words && !Array.isArray(aiData))) ? (
        <div className="text-2xl font-serif text-slate-800 leading-relaxed whitespace-pre-wrap tracking-wider">
          {originalText}
        </div>
      ) : (
        <div className="flex flex-col lg:flex-row gap-8 items-start">
          {/* CỘT TRÁI: Nội dung bài học */}
          <div className="flex-1 space-y-12 w-full">
            
            {/* Box Tiếng Trung */}
            <div className="border border-slate-800 p-8 relative bg-[#FDFBF7]">
              {/* Corner decorations */}
              <div className="absolute top-0 left-0 w-4 h-4 border-t-2 border-l-2 border-slate-800 -translate-x-[2px] -translate-y-[2px]"></div>
              <div className="absolute top-0 right-0 w-4 h-4 border-t-2 border-r-2 border-slate-800 translate-x-[2px] -translate-y-[2px]"></div>
              <div className="absolute bottom-0 left-0 w-4 h-4 border-b-2 border-l-2 border-slate-800 -translate-x-[2px] translate-y-[2px]"></div>
              <div className="absolute bottom-0 right-0 w-4 h-4 border-b-2 border-r-2 border-slate-800 translate-x-[2px] translate-y-[2px]"></div>
              
              <div className={`text-[28px] font-serif text-slate-800 leading-[2.5] tracking-widest text-justify ${isUpdatingVocab ? 'opacity-50 pointer-events-none' : ''}`}>
                {words.map((word: Word, idx: number) => (
                  word.hanzi === "\\n" || word.hanzi === "\n" ? (
                     <br key={idx} />
                  ) : (
                    <span 
                      key={idx} 
                      title={word.vi} 
                      onClick={() => handleWordClick(word)}
                      className={`cursor-pointer transition-colors rounded-sm px-0.5 ${isEditMode && word.vi ? 'hover:bg-blue-100 hover:text-blue-800' : 'hover:text-red-700 hover:bg-red-50'}`}
                    >
                      {word.hanzi}
                    </span>
                  )
                ))}
              </div>
              {isEditMode && (
                <div className="absolute -bottom-6 left-0 text-xs text-blue-600 font-sans">
                  * Nhấp vào một từ trong văn bản để thêm vào danh sách từ vựng.
                </div>
              )}
            </div>

            {/* Phiên âm */}
            {aiData.pinyin_text && (
              <div className="space-y-4">
                <h3 className="text-center font-sans tracking-[0.3em] text-sm text-slate-800 uppercase">PHIÊN ÂM</h3>
                <p className="font-sans text-lg text-slate-700 leading-relaxed text-justify md:px-8">
                  {aiData.pinyin_text}
                </p>
              </div>
            )}

            {/* Dịch nghĩa */}
            {aiData.translation && (
              <div className="space-y-4">
                <h3 className="text-center font-sans tracking-[0.3em] text-sm text-slate-800 uppercase">DỊCH NGHĨA</h3>
                <p className="font-serif text-lg text-slate-800 leading-relaxed text-justify md:px-8">
                  {aiData.translation}
                </p>
              </div>
            )}

            {/* Cấu trúc */}
            {grammarList.length > 0 && (
              <div className="space-y-6 pt-4">
                <h3 className="text-center font-sans tracking-[0.3em] text-sm text-slate-800 uppercase">CẤU TRÚC</h3>
                <div className="space-y-6 md:px-8">
                  {grammarList.map((g: Grammar, idx: number) => (
                    <div key={idx} className="space-y-2">
                      <div className="flex gap-2">
                        <span className="flex-shrink-0 flex items-center justify-center w-5 h-5 rounded-full border border-slate-800 text-xs font-serif mt-1">{idx + 1}</span>
                        <p className="font-serif text-xl text-slate-800">{g.structure}</p>
                      </div>
                      <p className="pl-7 font-serif text-slate-600 text-base">{g.explanation}</p>
                    </div>
                  ))}
                </div>
              </div>
            )}
            
            {/* Luyện Viết */}
            {keyVocab.length > 0 && (
              <div className="space-y-6 pt-10 mt-8 border-t-2 border-slate-200 border-dashed">
                <h3 className="text-center font-sans tracking-[0.3em] text-sm text-slate-800 uppercase">LUYỆN VIẾT</h3>
                <p className="text-center font-serif text-slate-500 text-sm italic mb-4">Nhìn cách AI đi nét để học thứ tự viết chữ Hán chuẩn.</p>
                <div className="flex flex-wrap gap-8 justify-center p-4">
                  {keyVocab.map((vocab: Word, idx: number) => (
                    <div key={idx} className="flex flex-col items-center bg-white p-4 border border-slate-200 rounded-sm shadow-sm">
                      <div className="flex gap-1">
                        {vocab.hanzi.split('').map((char: string, charIdx: number) => {
                          if (/[.,!?，。！？()（）]/.test(char)) return null;
                          return <HanziWriterComponent key={charIdx} character={char} />
                        })}
                      </div>
                      <span className="font-sans text-slate-500 text-sm mt-3 tracking-wider">{vocab.pinyin}</span>
                      <span className="font-serif text-slate-800 text-base mt-1">{vocab.vi}</span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* CỘT PHẢI: Từ vựng */}
          {keyVocab.length > 0 && (
            <div className={`w-full lg:w-72 border border-slate-800 p-6 relative bg-[#FDFBF7] flex-shrink-0 ${isUpdatingVocab ? 'opacity-50 pointer-events-none' : ''}`}>
              {/* Corner decorations */}
              <div className="absolute top-0 left-0 w-4 h-4 border-t-2 border-l-2 border-slate-800 -translate-x-[2px] -translate-y-[2px]"></div>
              <div className="absolute top-0 right-0 w-4 h-4 border-t-2 border-r-2 border-slate-800 translate-x-[2px] -translate-y-[2px]"></div>
              <div className="absolute bottom-0 left-0 w-4 h-4 border-b-2 border-l-2 border-slate-800 -translate-x-[2px] translate-y-[2px]"></div>
              <div className="absolute bottom-0 right-0 w-4 h-4 border-b-2 border-r-2 border-slate-800 translate-x-[2px] translate-y-[2px]"></div>
              
              <h3 className="text-center font-sans tracking-[0.2em] text-sm text-slate-800 mb-8 font-semibold">TỪ VỰNG</h3>
              
              <div className="space-y-8">
                {keyVocab.map((vocab: Word, idx: number) => (
                  <div key={idx} className="flex flex-col group relative">
                    <div className="flex gap-3 items-start">
                      <span className="font-serif text-slate-500 mt-1">{idx + 1}.</span>
                      <div>
                        <div className="text-3xl font-serif text-slate-800 mb-1">{vocab.hanzi}</div>
                        <div className="text-sm font-sans tracking-widest text-slate-500">{vocab.pinyin}</div>
                        <div className="text-base font-serif text-slate-700 mt-1">{vocab.vi}</div>
                      </div>
                    </div>
                    
                    {isEditMode ? (
                      <button 
                        onClick={() => handleRemoveWord(idx)}
                        className="absolute right-0 top-1/2 -translate-y-1/2 bg-white hover:bg-red-50 border border-slate-200 p-2 rounded-full shadow-sm text-red-500 transition-colors"
                        title="Xóa khỏi danh sách"
                      >
                        <Trash2 className="h-4 w-4" />
                      </button>
                    ) : (
                      <button 
                        onClick={() => handleSave(vocab)}
                        disabled={isSaving}
                        className="absolute right-0 top-1/2 -translate-y-1/2 opacity-0 group-hover:opacity-100 transition-opacity bg-white hover:bg-slate-100 border border-slate-200 p-2 rounded-full shadow-sm"
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
        <DialogContent className="sm:max-w-md bg-[#FDFBF7] border-2 border-slate-200 shadow-lg rounded-sm">
          <DialogHeader>
            <DialogTitle className="font-serif text-xl text-slate-800">Chi tiết Từ vựng</DialogTitle>
            <DialogDescription className="font-serif">Bạn có muốn lưu từ này vào sổ tay để ôn tập không?</DialogDescription>
          </DialogHeader>
          {selectedWord && (
            <div className="flex flex-col items-center justify-center py-8">
              <span className="text-sm text-slate-500 font-sans tracking-widest mb-2">{selectedWord.pinyin}</span>
              <span className="text-6xl font-serif text-red-700 mb-6">{selectedWord.hanzi}</span>
              <div className="bg-slate-100 px-4 py-2 border border-slate-200 rounded-sm">
                <span className="text-lg font-serif text-slate-800 text-center">{selectedWord.vi || "(Dấu câu)"}</span>
              </div>
            </div>
          )}
          <DialogFooter className="sm:justify-between border-t-2 border-slate-100 pt-4 mt-2">
            <Button variant="outline" onClick={() => setSelectedWord(null)} className="font-serif rounded-sm border-slate-300">
              Đóng
            </Button>
            <Button onClick={handleSaveSelected} disabled={isSaving || !selectedWord?.vi} className="font-serif rounded-sm bg-red-700 hover:bg-red-800 text-white">
              {isSaving ? "Đang lưu..." : "Lưu vào Sổ tay"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  )
}
