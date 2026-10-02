'use client'

import { useEffect, useRef } from 'react'
import HanziWriter from 'hanzi-writer'

export default function HanziWriterComponent({ character }: { character: string }) {
  const containerRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    if (!containerRef.current) return
    
    // Clear previous
    containerRef.current.innerHTML = ''

    const writer = HanziWriter.create(containerRef.current, character, {
      width: 100,
      height: 100,
      padding: 5,
      strokeAnimationSpeed: 1,
      delayBetweenStrokes: 50,
      showOutline: true,
      strokeColor: '#b91c1c', // red-700
      radicalColor: '#1e293b', // slate-800
    })

    const interval = setInterval(() => {
      writer.animateCharacter()
    }, 4000)
    
    writer.animateCharacter()

    return () => clearInterval(interval)
  }, [character])

  return (
    <div className="flex flex-col items-center gap-2">
      <div 
        ref={containerRef} 
        className="border-2 border-dashed border-red-200 bg-white shadow-sm flex items-center justify-center cursor-pointer hover:border-red-400 transition-colors"
        style={{ width: 100, height: 100, backgroundImage: 'linear-gradient(45deg, transparent 49%, #fecaca 50%, transparent 51%), linear-gradient(-45deg, transparent 49%, #fecaca 50%, transparent 51%), linear-gradient(to bottom, transparent 49%, #fecaca 50%, transparent 51%), linear-gradient(to right, transparent 49%, #fecaca 50%, transparent 51%)' }}
      />
    </div>
  )
}
