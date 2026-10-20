import { Metadata } from 'next'
import { getRadicalById, radicals } from '@/data/radicals'
import { notFound } from 'next/navigation'
import RadicalDetailClient from './radical-detail-client'

type Props = {
  params: Promise<{ id: string }>
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { id } = await params
  const radical = getRadicalById(Number(id))
  if (!radical) return { title: 'Không tìm thấy bộ thủ' }
  return {
    title: `Bộ ${radical.radical} (${radical.meaning}) - Bộ thủ #${radical.id} - Chinese Notebook`,
    description: `Học bộ thủ ${radical.radical} (${radical.pinyin}): ${radical.meaning}. ${radical.explanation}`,
  }
}

export function generateStaticParams() {
  return radicals.map((r) => ({ id: String(r.id) }))
}

export default async function RadicalDetailPage({ params }: Props) {
  const { id } = await params
  const radicalId = Number(id)

  if (isNaN(radicalId) || radicalId < 1 || radicalId > 214) {
    notFound()
  }

  const radical = getRadicalById(radicalId)
  if (!radical) {
    notFound()
  }

  return (
    <div className="max-w-3xl mx-auto">
      <RadicalDetailClient radical={radical} />
    </div>
  )
}
