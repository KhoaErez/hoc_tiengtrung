import { Metadata } from 'next'
import { notFound } from 'next/navigation'
import { getCachedAuthUser } from '@/lib/supabase/server'
import { getCourseLessonById, getNextCourseLesson } from '@/data/course-roadmap-data'
import LessonPlayer from '@/components/learn/lesson-player'

export async function generateMetadata(props: {
  params: Promise<{ lessonId: string }>
}): Promise<Metadata> {
  const { lessonId } = await props.params
  const found = getCourseLessonById(lessonId)
  if (!found) {
    return { title: 'Không tìm thấy bài học | Chinese Notebook' }
  }

  return {
    title: `${found.lesson.title} (${found.lesson.titleZh}) | Chinese Notebook`,
    description: found.lesson.subtitle,
  }
}

export default async function LessonPlayerPage(props: {
  params: Promise<{ lessonId: string }>
}) {
  const { lessonId } = await props.params
  const [user, found] = await Promise.all([
    getCachedAuthUser(),
    Promise.resolve(getCourseLessonById(lessonId)),
  ])

  if (!found) {
    notFound()
  }

  const nextLesson = getNextCourseLesson(lessonId)

  return (
    <LessonPlayer
      lesson={found.lesson}
      unit={found.unit}
      nextLesson={nextLesson}
      isLoggedIn={Boolean(user)}
    />
  )
}
