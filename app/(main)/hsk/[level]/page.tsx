import { notFound, redirect } from 'next/navigation'

interface Props {
  params: Promise<{ level: string }>
}

export default async function HskLevelPage({ params }: Props) {
  const { level } = await params
  
  if (level === '7-9' || level === '7' || level === '8' || level === '9') {
    redirect('/topics?q=HSK 7-9')
  }

  const levelNum = parseInt(level, 10)

  if (isNaN(levelNum) || levelNum < 1 || levelNum > 9) {
    notFound()
  }

  if (levelNum >= 7) {
    redirect('/topics?q=HSK 7-9')
  }

  redirect(`/topics?q=HSK ${levelNum}`)
}
