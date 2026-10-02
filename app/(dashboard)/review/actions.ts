'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

export async function updateReviewStatusAction(userVocabId: string, isRemembered: boolean) {
  const supabase = await createClient()
  
  // Fetch current stats
  const { data: current } = await supabase
    .from('user_vocabularies')
    .select('review_interval_days, ease_factor')
    .eq('id', userVocabId)
    .single()
    
  if (!current) throw new Error('Not found')
  
  let newInterval = current.review_interval_days
  let newEase = current.ease_factor
  
  if (isRemembered) {
    if (newInterval === 0) newInterval = 1
    else if (newInterval === 1) newInterval = 3
    else newInterval = Math.round(newInterval * newEase)
    
    newEase = newEase + 0.1
  } else {
    newInterval = 1
    newEase = Math.max(1.3, newEase - 0.2)
  }
  
  const nextReviewDate = new Date()
  nextReviewDate.setDate(nextReviewDate.getDate() + newInterval)
  
  await supabase
    .from('user_vocabularies')
    .update({
      review_interval_days: newInterval,
      ease_factor: newEase,
      next_review_at: nextReviewDate.toISOString(),
      status: 'reviewing'
    })
    .eq('id', userVocabId)
    
  revalidatePath('/review')
  revalidatePath('/dashboard')
}
