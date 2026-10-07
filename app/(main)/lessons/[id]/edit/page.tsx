import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { SubmitButton } from '@/components/ui/submit-button'
import { Textarea } from '@/components/ui/textarea'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { updateLesson } from '../../actions'
import { createClient } from '@/lib/supabase/server'
import { notFound, redirect } from 'next/navigation'

export default async function EditLessonPage({ params }: { params: { id: string } }) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  const { data: lesson } = await supabase
    .from('lessons')
    .select('*')
    .eq('id', params.id)
    .single()

  if (!lesson) {
    notFound()
  }

  if (lesson.user_id !== user.id) {
    redirect('/lessons/' + params.id)
  }

  const updateLessonWithId = updateLesson.bind(null, params.id)

  return (
    <div className="max-w-3xl mx-auto">
      <div className="mb-6">
        <h1 className="text-3xl font-serif text-title">Sửa bài học</h1>
        <p className="text-muted font-serif">Chỉnh sửa nội dung tiếng Trung, hệ thống sẽ phân tích lại từ đầu.</p>
      </div>

      <Card className="rounded-2xl border border-border shadow-sm bg-card">
        <CardHeader>
          <CardTitle className="font-serif text-title">Nội dung bài học</CardTitle>
          <CardDescription className="text-muted">Chỉnh sửa tiêu đề và nội dung bằng chữ Hán</CardDescription>
        </CardHeader>
        <CardContent>
          <form action={updateLessonWithId} className="space-y-6">
            <div className="space-y-2">
              <Label htmlFor="title" className="font-serif text-title">Tiêu đề bài học</Label>
              <Input id="title" name="title" required defaultValue={lesson.title} placeholder="VD: Xin chào, tôi tên là..." className="font-serif bg-transparent border-border" />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="subtitle" className="font-serif text-title">Phụ đề (Tùy chọn)</Label>
                <Input id="subtitle" name="subtitle" defaultValue={lesson.subtitle || ''} placeholder="Bài 1 - HSK 1" className="font-serif bg-transparent border-border" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="hsk_level" className="font-serif text-title">Cấp độ</Label>
                <Select name="hsk_level" defaultValue={lesson.hsk_level || 'HSK 1'}>
                  <SelectTrigger className="font-serif bg-transparent border-border">
                    <SelectValue placeholder="Chọn cấp độ" />
                  </SelectTrigger>
                  <SelectContent>
                    {['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6', 'Giao tiếp', 'Công xưởng'].map(l => (
                      <SelectItem key={l} value={l} className="font-serif">{l}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="original_text" className="font-serif text-title">Văn bản tiếng Trung</Label>
              <Textarea 
                id="original_text" 
                name="original_text" 
                required 
                defaultValue={lesson.original_text}
                placeholder="你好！我叫..." 
                className="font-serif min-h-[200px] text-lg leading-loose resize-y bg-transparent border-border"
              />
            </div>

            <div className="flex justify-end pt-4 border-t border-border">
              <SubmitButton 
                text="Cập nhật Bài Học"
                loadingText="Đang cập nhật..."
                className="font-serif px-8" 
              />
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  )
}
