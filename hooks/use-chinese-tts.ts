'use client'

import { useCallback, useSyncExternalStore } from 'react'
import {
  ttsEngine,
  TTSState,
  SpeakOptions,
  TTS_SPEED_RATES,
  type TTSSpeedRate,
} from '@/lib/tts/tts-engine'

export { TTS_SPEED_RATES, type TTSSpeedRate }

// Server snapshot cố định (bất biến) cho SSR
const defaultServerSnapshot: TTSState = {
  status: 'idle',
  currentId: null,
  currentText: null,
  rate: 1.0,
  selectedVoiceURI: null,
  voices: [],
  hasChineseVoice: true,
}

export function useChineseTTS() {
  // Đồng bộ reactive với singleton engine qua useSyncExternalStore
  const state = useSyncExternalStore<TTSState>(
    (callback) => ttsEngine.subscribe(callback),
    () => ttsEngine.getState(),
    () => defaultServerSnapshot
  )

  const speak = useCallback((text: string, options?: SpeakOptions) => {
    return ttsEngine.speak(text, options)
  }, [])

  const stop = useCallback(() => {
    ttsEngine.stop()
  }, [])

  const pause = useCallback(() => {
    ttsEngine.pause()
  }, [])

  const resume = useCallback(() => {
    ttsEngine.resume()
  }, [])

  const setRate = useCallback((newRate: number, restartIfPlaying = true) => {
    ttsEngine.setRate(newRate, restartIfPlaying)
  }, [])

  const cycleNextRate = useCallback(() => {
    return ttsEngine.cycleNextRate()
  }, [])

  const setVoiceURI = useCallback((uri: string) => {
    ttsEngine.setVoiceURI(uri)
  }, [])

  /**
   * Kiểm tra xem một từ vựng, câu hoặc id cụ thể có đang được phát hay không
   */
  const isSpeakingItem = useCallback(
    (idOrText: string): boolean => {
      if (state.status !== 'playing' && state.status !== 'paused') return false
      return state.currentId === idOrText || state.currentText === idOrText
    },
    [state.status, state.currentId, state.currentText]
  )

  return {
    status: state.status,
    isPlaying: state.status === 'playing',
    isPaused: state.status === 'paused',
    currentId: state.currentId,
    currentText: state.currentText,
    rate: state.rate,
    voices: state.voices,
    hasChineseVoice: state.hasChineseVoice,
    selectedVoiceURI: state.selectedVoiceURI,
    speak,
    stop,
    pause,
    resume,
    setRate,
    cycleNextRate,
    setVoiceURI,
    isSpeakingItem,
  }
}
