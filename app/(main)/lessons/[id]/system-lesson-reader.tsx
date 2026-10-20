'use client'

import { useState } from 'react'
import Link from 'next/link'
import { ArrowLeft, CheckCircle2, PlayCircle, Volume2, XCircle, BrainCircuit } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card } from '@/components/ui/card'
import { markVocabLearnedAction } from '../../review/actions'
import { toast } from 'sonner'

import { AudioButton } from '@/components/ui/audio-button'

import { useChineseTTS } from '@/hooks/use-chinese-tts'

type Vocabulary = {
  id: string
  hanzi: string
  pinyin: string
  meaning_vi: string
  example_hanzi?: string
  example_pinyin?: string
  example_vi?: string
}

export default function SystemLessonReader({ 
  lesson, 
  vocabularies,
  userVocabs
}: { 
  lesson: any
  vocabularies: Vocabulary[]
  userVocabs: string[] // Array of learned vocabulary IDs
}) {
  const { speak } = useChineseTTS()
  
  // Learning Mode State
  const [isLearning, setIsLearning] = useState(false)
  const [learningIndex, setLearningIndex] = useState(0)
  const [showAnswer, setShowAnswer] = useState(false)
  const [isUpdating, setIsUpdating] = useState(false)
  // Local state to instantly update UI after learning
  const [localUserVocabs, setLocalUserVocabs] = useState<string[]>(userVocabs)

  const handleLearnAnswer = async (isRemembered: boolean) => {
    setIsUpdating(true)
    const currentVocab = vocabularies[learningIndex]
    try {
      await markVocabLearnedAction(currentVocab.id, isRemembered)
      if (!localUserVocabs.includes(currentVocab.id)) {
        setLocalUserVocabs(prev => [...prev, currentVocab.id])
      }
      setShowAnswer(false)
      setLearningIndex(prev => prev + 1)
    } catch (e) {
      console.error(e)
      toast.error('Có lỗi xảy ra, vui lòng đăng nhập để lưu tiến độ')
    } finally {
      setIsUpdating(false)
    }
  }

  if (isLearning) {
    if (learningIndex >= vocabularies.length) {
      return (
        <div className="max-w-xl mx-auto text-center py-20 font-serif">
          <div className="bg-green-100 p-4 rounded-full inline-block mb-4">
            <BrainCircuit className="h-12 w-12 text-green-700" />
          </div>
          <h2 className="text-3xl text-slate-800 mb-2">Chúc mừng!</h2>
          <p className="text-slate-500 mb-8">Bạn đã hoàn thành bài học này.</p>
          <Button onClick={() => setIsLearning(false)} className="bg-blue-700 hover:bg-blue-800 text-white px-8">
            Trở về danh sách từ
          </Button>
        </div>
      )
    }

    const currentVocab = vocabularies[learningIndex]

    return (
      <div className="max-w-xl mx-auto py-10 font-serif px-4">
        <div className="flex justify-between items-center mb-6 text-sm text-slate-500">
          <button onClick={() => setIsLearning(false)} className="flex items-center hover:text-red-700 transition-colors">
            <ArrowLeft className="w-4 h-4 mr-1" /> Thoát
          </button>
          <span>Từ {learningIndex + 1} / {vocabularies.length}</span>
        </div>

        <Card 
          className="w-full aspect-[4/3] flex flex-col items-center justify-center cursor-pointer bg-[#FDFBF7] border-2 border-slate-200 shadow-sm relative transition-all"
          onClick={() => {
            if (!showAnswer) {
              setShowAnswer(true)
              speak(currentVocab.hanzi, { id: `fc-${currentVocab.id}` })
            }
          }}
        >
          {!showAnswer ? (
            <div className="text-center space-y-4">
              <span className="text-[120px] font-serif text-slate-800 leading-none">{currentVocab.hanzi}</span>
              <p className="text-slate-400 font-serif text-sm">Chạm để lật thẻ và nghe phát âm</p>
            </div>
          ) : (
            <div className="text-center flex flex-col items-center justify-center w-full h-full p-4 md:p-8 bg-red-700/5 rounded-sm">
              <span className="text-xl text-slate-500 font-sans tracking-widest mb-2">{currentVocab.pinyin}</span>
              <div className="flex items-center justify-center gap-3 mb-4">
                <span className="text-[60px] md:text-[80px] font-serif text-red-700 leading-none">{currentVocab.hanzi}</span>
                <AudioButton text={currentVocab.hanzi} id={`fc-${currentVocab.id}`} size="md" variant="subtle" tooltip="Nghe phát âm từ này" />
              </div>
              <div className="bg-white px-6 py-2.5 border-2 border-slate-200 rounded-sm shadow-sm mb-4">
                <span className="text-xl md:text-2xl font-serif text-slate-800">{currentVocab.meaning_vi}</span>
              </div>
              
              {/* Example block */}
              {currentVocab.example_hanzi && (
                <div className="bg-white/70 p-3.5 border border-slate-200 rounded-sm w-full max-w-sm text-center space-y-1">
                  <div className="text-xs font-sans text-slate-500">{currentVocab.example_pinyin}</div>
                  <div className="text-base md:text-lg font-serif text-slate-800 flex items-center justify-center gap-2">
                    <span>{currentVocab.example_hanzi}</span>
                    <AudioButton text={currentVocab.example_hanzi} id={`fc-ex-${currentVocab.id}`} size="xs" variant="ghost" tooltip="Nghe câu ví dụ" />
                  </div>
                  <div className="text-xs md:text-sm text-slate-600 font-serif italic">{currentVocab.example_vi}</div>
                </div>
              )}
            </div>
          )}
        </Card>

        <div className="mt-8 flex gap-4 h-14">
          {!showAnswer ? (
            <Button 
              className="w-full h-full text-lg font-serif transition-colors bg-red-700 hover:bg-red-800 text-white cursor-pointer"
              onClick={() => {
                setShowAnswer(true)
                speak(currentVocab.hanzi, { id: `fc-${currentVocab.id}` })
              }}
            >
              Lật thẻ
            </Button>
          ) : (
            <>
              <Button 
                variant="outline"
                disabled={isUpdating}
                className="flex-1 h-full text-lg font-serif border-2 text-slate-600 hover:bg-slate-100 transition-colors disabled:opacity-50"
                onClick={() => handleLearnAnswer(false)}
              >
                <XCircle className="mr-2 h-5 w-5 text-red-500" /> {isUpdating ? 'Đang lưu...' : 'Chưa thuộc'}
              </Button>
              <Button 
                disabled={isUpdating}
                className="flex-1 h-full text-lg font-serif bg-green-600 hover:bg-green-700 text-white transition-colors disabled:opacity-50"
                onClick={() => handleLearnAnswer(true)}
              >
                <CheckCircle2 className="mr-2 h-5 w-5" /> {isUpdating ? 'Đang lưu...' : 'Đã thuộc'}
              </Button>
            </>
          )}
        </div>
      </div>
    )
  }

  return (
    <div className="max-w-4xl mx-auto space-y-8 font-serif px-4 pb-20">
      {/* Header */}
      <div className="bg-white p-6 md:p-8 rounded-sm shadow-sm border-2 border-slate-200">
        <Link href={`/topics?q=${lesson.hsk_level}`} className="inline-flex items-center text-slate-500 hover:text-red-700 transition-colors mb-6 text-sm font-sans uppercase tracking-widest font-semibold">
          <ArrowLeft className="w-4 h-4 mr-2" />
          Về danh sách {lesson.hsk_level}
        </Link>
        
        <h1 className="text-3xl md:text-5xl font-serif text-slate-800 mb-4">{lesson.title}</h1>
        {lesson.subtitle && (
          <p className="text-lg md:text-xl text-slate-500 font-serif">{lesson.subtitle}</p>
        )}
        
        <div className="mt-8 flex items-center gap-4 border-t-2 border-slate-100 pt-6">
          <div className="flex-1">
            <div className="text-sm font-sans uppercase tracking-widest text-slate-500 mb-1 font-semibold">Tiến độ bài học</div>
            <div className="text-xl font-serif text-slate-800">
              {localUserVocabs.length} <span className="text-slate-400">/ {vocabularies.length} từ</span>
            </div>
          </div>
          <Button 
            className="font-serif bg-red-700 hover:bg-red-800 text-white rounded-sm px-8"
            onClick={() => {
              setLearningIndex(0)
              setShowAnswer(false)
              setIsLearning(true)
            }}
          >
            Học bài này
          </Button>
        </div>
      </div>

      {/* Vocabulary List */}
      <div className="space-y-4">
        <h2 className="text-2xl font-serif text-slate-800 border-b-2 border-slate-200 pb-2">Danh sách từ vựng ({vocabularies.length})</h2>
        
        <div className="bg-white border-2 border-slate-200 rounded-sm overflow-hidden flex flex-col divide-y divide-slate-100">
          {vocabularies.map((vocab, index) => {
            const isLearned = localUserVocabs.includes(vocab.id)
            
            return (
              <div key={vocab.id} className="p-4 md:p-6 flex flex-col md:flex-row gap-4 hover:bg-red-50/30 transition-colors group">
                <div className="flex items-start gap-4 md:w-1/3 shrink-0 mt-1">
                  <span className="text-slate-300 font-sans text-sm w-6 text-right shrink-0">{index + 1}</span>
                  <div className="flex-1">
                    <div className="text-4xl md:text-5xl font-serif text-slate-800 group-hover:text-red-700 transition-colors mb-1">{vocab.hanzi}</div>
                    <div className="text-slate-500 font-sans">{vocab.pinyin}</div>
                  </div>
                </div>
                
                <div className="flex-1 flex flex-col gap-3 md:border-l-2 md:border-slate-100 md:pl-6 mt-1">
                  <div className="text-lg font-serif text-slate-600">
                    {vocab.meaning_vi}
                  </div>
                  {vocab.example_hanzi && (
                    <div className="bg-slate-50 p-3 md:p-4 rounded border-l-4 border-slate-300 group-hover:border-red-300 transition-colors space-y-1">
                      <div className="text-slate-500 font-sans text-sm">{vocab.example_pinyin}</div>
                      <div className="text-slate-700 font-serif text-lg flex items-center justify-between gap-2">
                        <span>{vocab.example_hanzi}</span>
                        <AudioButton 
                          text={vocab.example_hanzi} 
                          id={`ex-${vocab.id}`} 
                          size="xs" 
                          variant="subtle" 
                          tooltip="Nghe câu ví dụ tiếng Trung" 
                        />
                      </div>
                      <div className="text-slate-600 font-serif italic text-sm">{vocab.example_vi}</div>
                    </div>
                  )}
                </div>
                
                <div className="flex items-center gap-3 shrink-0 md:justify-end">
                  <AudioButton 
                    text={vocab.hanzi} 
                    id={vocab.id} 
                    size="md" 
                    variant="ghost" 
                    tooltip="Nghe phát âm từ vựng" 
                  />
                  
                  {isLearned ? (
                    <div className="flex items-center gap-1.5 text-xs font-sans tracking-wide uppercase px-3 py-1.5 rounded-sm border bg-green-50 border-green-200 text-green-700">
                      <CheckCircle2 className="h-4 w-4" /> Đã học
                    </div>
                  ) : (
                    <div className="flex items-center gap-1.5 text-xs font-sans tracking-wide uppercase px-3 py-1.5 rounded-sm border bg-slate-50 border-slate-200 text-slate-500">
                      Chưa học
                    </div>
                  )}
                </div>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}
