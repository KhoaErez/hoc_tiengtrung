'use client'

import { useState } from 'react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { updateReviewStatusAction } from './actions'
import { BrainCircuit, CheckCircle, XCircle, Volume2 } from 'lucide-react'
import { toast } from 'sonner'

type Vocab = {
  id: string; // user_vocab_id
  hanzi: string;
  pinyin: string;
  meaning_vi: string;
  example_hanzi?: string;
  example_pinyin?: string;
  example_vi?: string;
}

export default function FlashcardReviewer({ vocabs }: { vocabs: Vocab[] }) {
  const [currentIndex, setCurrentIndex] = useState(0)
  const [showAnswer, setShowAnswer] = useState(false)
  const [isUpdating, setIsUpdating] = useState(false)

  const playAudio = (text: string) => {
    if (typeof window !== 'undefined' && window.speechSynthesis) {
      window.speechSynthesis.cancel()
      const utterance = new SpeechSynthesisUtterance(text)
      utterance.lang = 'zh-CN'
      utterance.rate = 0.8
      window.speechSynthesis.speak(utterance)
    }
  }

  if (currentIndex >= vocabs.length) {
    return (
      <div className="text-center py-20">
        <div className="bg-green-100 p-4 rounded-full inline-block mb-4">
          <BrainCircuit className="h-12 w-12 text-green-700" />
        </div>
        <h2 className="text-3xl font-serif text-slate-800 mb-2">Chúc mừng!</h2>
        <p className="text-slate-500 font-serif">Bạn đã hoàn thành phiên ôn tập hôm nay.</p>
      </div>
    )
  }

  const currentVocab = vocabs[currentIndex]

  const handleAnswer = async (isRemembered: boolean) => {
    setIsUpdating(true)
    try {
      await updateReviewStatusAction(currentVocab.id, isRemembered)
      setShowAnswer(false)
      setCurrentIndex(prev => prev + 1)
    } catch (e) {
      console.error(e)
      toast.error('Có lỗi xảy ra, vui lòng thử lại')
    } finally {
      setIsUpdating(false)
    }
  }

  return (
    <div className="max-w-xl mx-auto">
      <div className="flex justify-between items-center mb-6 text-sm text-slate-500 font-serif">
        <span>Từ {currentIndex + 1} / {vocabs.length}</span>
        <span>Thẻ flashcard</span>
      </div>

      <Card 
        className="w-full aspect-[4/3] flex flex-col items-center justify-center cursor-pointer bg-[#FDFBF7] border-2 border-slate-200 shadow-sm relative transition-all"
        onClick={() => !showAnswer && setShowAnswer(true)}
      >
        {!showAnswer ? (
          <div className="text-center space-y-4">
            <div className="flex items-center gap-4">
              <span className="text-[120px] font-serif text-slate-800 leading-none">{currentVocab.hanzi}</span>
              <button 
                onClick={(e) => { e.stopPropagation(); playAudio(currentVocab.hanzi); }}
                className="text-slate-400 hover:text-red-700 p-4 rounded-full hover:bg-red-50 transition-colors"
              >
                <Volume2 className="h-8 w-8" />
              </button>
            </div>
            <p className="text-slate-400 font-serif text-sm">Chạm để lật thẻ</p>
          </div>
        ) : (
          <div className="text-center flex flex-col items-center justify-center w-full h-full p-8 bg-red-700/5 rounded-sm">
            <span className="text-xl text-slate-500 font-sans tracking-widest mb-4">{currentVocab.pinyin}</span>
            <div className="flex items-center gap-4 mb-8">
              <span className="text-[80px] font-serif text-red-700 leading-none">{currentVocab.hanzi}</span>
              <button 
                onClick={(e) => { e.stopPropagation(); playAudio(currentVocab.hanzi); }}
                className="text-slate-400 hover:text-red-700 p-3 rounded-full hover:bg-red-50 transition-colors"
              >
                <Volume2 className="h-8 w-8" />
              </button>
            </div>
            <div className="bg-white px-6 py-3 border-2 border-slate-200 rounded-sm shadow-sm w-full max-w-sm mx-auto">
              <span className="text-2xl font-serif text-slate-800">{currentVocab.meaning_vi}</span>
            </div>
            {currentVocab.example_hanzi && (
              <div className="mt-6 border-t-2 border-slate-200/50 pt-4 w-full text-center px-4 max-w-sm mx-auto">
                <div className="text-xl font-serif text-slate-800 mb-1">{currentVocab.example_hanzi}</div>
                <div className="text-sm font-sans tracking-widest text-slate-500 mb-2">{currentVocab.example_pinyin}</div>
                <div className="text-base font-serif text-slate-700">{currentVocab.example_vi}</div>
              </div>
            )}
          </div>
        )}
      </Card>

      <div className="mt-8 flex gap-4 h-14">
        {!showAnswer ? (
          <Button 
            className="w-full h-full text-lg font-serif transition-colors"
            onClick={() => setShowAnswer(true)}
          >
            Xem đáp án
          </Button>
        ) : (
          <>
            <Button 
              variant="outline"
              disabled={isUpdating}
              className="flex-1 h-full text-lg font-serif border-2 text-slate-600 hover:bg-slate-100 transition-colors disabled:opacity-50"
              onClick={() => handleAnswer(false)}
            >
              <XCircle className="mr-2 h-5 w-5 text-red-500" /> {isUpdating ? 'Đang lưu...' : 'Quên rồi'}
            </Button>
            <Button 
              disabled={isUpdating}
              className="flex-1 h-full text-lg font-serif transition-colors disabled:opacity-50"
              onClick={() => handleAnswer(true)}
            >
              <CheckCircle className="mr-2 h-5 w-5" /> {isUpdating ? 'Đang lưu...' : 'Đã nhớ'}
            </Button>
          </>
        )}
      </div>
    </div>
  )
}
