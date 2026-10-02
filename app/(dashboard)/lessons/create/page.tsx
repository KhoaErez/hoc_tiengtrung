import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Button } from '@/components/ui/button'
import { Textarea } from '@/components/ui/textarea'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { createLesson } from '../actions'

export default function CreateLessonPage() {
  return (
    <div className="max-w-3xl mx-auto">
      <div className="mb-6">
        <h1 className="text-3xl font-serif text-slate-800">Tạo bài học mới</h1>
        <p className="text-slate-500 font-serif">Dán đoạn văn bản tiếng Trung vào đây để AI xử lý</p>
      </div>

      <Card className="rounded-sm border-2 border-slate-200 shadow-none bg-white/50 backdrop-blur">
        <CardHeader>
          <CardTitle className="font-serif">Nội dung bài học</CardTitle>
          <CardDescription>Nhập tiêu đề và nội dung bằng chữ Hán</CardDescription>
        </CardHeader>
        <CardContent>
          <form action={createLesson} className="space-y-6">
            <div className="space-y-2">
              <Label htmlFor="title" className="font-serif">Tiêu đề bài học</Label>
              <Input id="title" name="title" required placeholder="VD: Xin chào, tôi tên là..." className="font-serif bg-transparent" />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="subtitle" className="font-serif">Phụ đề (Tùy chọn)</Label>
                <Input id="subtitle" name="subtitle" placeholder="Bài 1 - HSK 1" className="font-serif bg-transparent" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="hsk_level" className="font-serif">Cấp độ</Label>
                <Select name="hsk_level" defaultValue="HSK 1">
                  <SelectTrigger className="font-serif bg-transparent">
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
              <Label htmlFor="original_text" className="font-serif">Văn bản tiếng Trung</Label>
              <Textarea 
                id="original_text" 
                name="original_text" 
                required 
                placeholder="你好！我叫..." 
                className="font-serif min-h-[200px] text-lg leading-loose resize-y bg-transparent"
              />
            </div>

            <div className="flex justify-end pt-4 border-t-2 border-slate-100">
              <Button type="submit" className="bg-red-700 hover:bg-red-800 text-white font-serif rounded-sm px-8">
                Lưu Bài Học
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  )
}
