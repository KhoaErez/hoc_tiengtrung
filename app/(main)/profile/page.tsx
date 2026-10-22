import { redirect } from 'next/navigation'
import { createClient, getCachedAuthUser, getCachedUserProfile } from '@/lib/supabase/server'
import ProfileClient from './profile-client'

export const dynamic = 'force-dynamic'

export default async function ProfilePage() {
  const user = await getCachedAuthUser()

  if (!user) {
    redirect('/login?next=/profile')
  }

  const supabase = await createClient()

  // 1. Fetch user profile (0ms từ React Request Cache nếu layout đã tải)
  const cachedProfile = await getCachedUserProfile(user.id)
  const profile = cachedProfile || (await supabase
    .from('profiles')
    .select('id, display_name, avatar_url, created_at')
    .eq('id', user.id)
    .maybeSingle()).data

  // 2. Fetch user learning counts from Supabase
  const now = new Date().toISOString()
  const [
    { count: savedCount },
    { count: memorizedCount },
    { count: customLessonsCount },
    { count: dueReviewCount },
    { data: userVocabsData }
  ] = await Promise.all([
    supabase.from('user_vocabularies').select('*', { count: 'exact', head: true }).eq('user_id', user.id),
    supabase.from('user_vocabularies').select('*', { count: 'exact', head: true }).eq('user_id', user.id).gte('review_interval_days', 21),
    supabase.from('lessons').select('*', { count: 'exact', head: true }).eq('user_id', user.id),
    supabase.from('user_vocabularies').select('*', { count: 'exact', head: true }).eq('user_id', user.id).lte('next_review_at', now),
    supabase.from('user_vocabularies').select('id, vocabularies!inner(hsk_level)').eq('user_id', user.id)
  ])

  // 3. Count learned vocabs per HSK 3.0 level
  const hskCounts: Record<number, number> = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0 }
  userVocabsData?.forEach((uv: unknown) => {
    const item = uv as { vocabularies: { hsk_level?: string } | { hsk_level?: string }[] }
    const v = Array.isArray(item.vocabularies) ? item.vocabularies[0] : item.vocabularies
    if (!v?.hsk_level) return
    if (v.hsk_level === 'HSK 7-9' || v.hsk_level === 'HSK 7') {
      hskCounts[7] = (hskCounts[7] || 0) + 1
      return
    }
    const match = v.hsk_level.match(/HSK (\d)/)
    if (match) {
      const lvl = parseInt(match[1])
      if (lvl >= 1 && lvl <= 6) {
        hskCounts[lvl] = (hskCounts[lvl] || 0) + 1
      } else if (lvl >= 7 && lvl <= 9) {
        hskCounts[7] = (hskCounts[7] || 0) + 1
      }
    }
  })

  const displayName = profile?.display_name || user.user_metadata?.full_name || user.email?.split('@')[0] || 'Học viên'

  return (
    <div className="max-w-5xl mx-auto space-y-8 pb-16">
      <ProfileClient
        user={{
          id: user.id,
          email: user.email || '',
          displayName,
          avatarUrl: profile?.avatar_url || null,
          createdAt: profile?.created_at || user.created_at,
        }}
        stats={{
          savedVocabCount: savedCount || 0,
          memorizedVocabCount: memorizedCount || 0,
          customLessonsCount: customLessonsCount || 0,
          dueReviewCount: dueReviewCount || 0,
          hskCounts,
        }}
      />
    </div>
  )
}
