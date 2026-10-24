'use client'

import { useState } from 'react'
import { NotebookPen, ChevronRight, BookOpen, Compass, Check, X } from 'lucide-react'
import { Button } from '@/components/ui/button'

export interface WritingTopic {
  id: string
  title: string
  chineseTitle: string
  icon: string
  levelHint: string
  prompt: string
  keywords: string[]
  sampleStructure: string
}

export const WRITING_TOPICS: WritingTopic[] = [
  {
    id: 'intro',
    title: 'Giới thiệu bản thân',
    chineseTitle: '自我介绍',
    icon: '👤',
    levelHint: 'HSK 1–2',
    prompt: 'Hãy viết một đoạn văn ngắn (50–150 chữ) giới thiệu về tên, tuổi, quê quán, nghề nghiệp/trường học và sở thích học tiếng Trung của bạn.',
    keywords: ['名字 (Tên)', '岁 (Tuổi)', '来自 (Đến từ)', '爱好 (Sở thích)', '学习汉语 (Học Hán ngữ)'],
    sampleStructure: '我叫...，今年...岁。我是...人。我喜欢...，因为...',
  },
  {
    id: 'daily',
    title: 'Một ngày của tôi',
    chineseTitle: '我的一天',
    icon: '☀️',
    levelHint: 'HSK 2–3',
    prompt: 'Kể lại một ngày sinh hoạt bình thường của bạn từ khi thức dậy, đi làm/đi học, ăn uống đến các hoạt động thư giãn vào buổi tối.',
    keywords: ['起床 (Thức dậy)', '吃早饭 (Ăn sáng)', '上班/上课 (Đi làm/học)', '下班 (Tan làm)', '睡觉 (Đi ngủ)'],
    sampleStructure: '我每天早上...点起床。吃完早饭后，我...。晚上我通常...',
  },
  {
    id: 'family',
    title: 'Gia đình tôi',
    chineseTitle: '我的家庭',
    icon: '🏡',
    levelHint: 'HSK 2–3',
    prompt: 'Miêu tả các thành viên trong gia đình bạn, tính cách, sở thích của từng người hoặc một kỷ niệm ấm áp khi cả nhà sum họp.',
    keywords: ['家庭 (Gia đình)', '父母 (Bố mẹ)', '幸福 (Hạnh phúc)', '照顾 (Chăm sóc)', '团圆 (Sum họp)'],
    sampleStructure: '我家有...口人，分别是...。我的爸爸是...，妈妈很喜欢...。我们一家人...',
  },
  {
    id: 'work_study',
    title: 'Công việc & Học tập',
    chineseTitle: '工作与学习',
    icon: '💼',
    levelHint: 'HSK 3–4',
    prompt: 'Chia sẻ về công việc hiện tại hoặc chuyên ngành bạn đang theo học. Lý do bạn quyết định học tiếng Trung và mục tiêu đạt HSK trong tương lai.',
    keywords: ['职业 (Nghề nghiệp)', '经验 (Kinh nghiệm)', '提高 (Nâng cao)', '目标 (Mục tiêu)', '挑战 (Thử thách)'],
    sampleStructure: '目前我是一名...。为了...，我正在努力学习中文。我的目标是在今年...',
  },
  {
    id: 'weekend',
    title: 'Kế hoạch cuối tuần',
    chineseTitle: '周末计划',
    icon: '☕',
    levelHint: 'HSK 3–4',
    prompt: 'Bạn thường dành thời gian cuối tuần để làm gì? Kể về một kế hoạch đặc biệt vào thứ Bảy hoặc Chủ nhật sắp tới cùng bạn bè hoặc người thân.',
    keywords: ['周末 (Cuối tuần)', '打算 (Dự định)', '看电影 (Xem phim)', '逛街 (Dạo phố)', '放松 (Thư giãn)'],
    sampleStructure: '这个周末，我打算和...一起去...。如果天气好的话，我们还会...',
  },
  {
    id: 'travel',
    title: 'Chuyến du lịch đáng nhớ',
    chineseTitle: '一次难忘的旅行',
    icon: '✈️',
    levelHint: 'HSK 4–6',
    prompt: 'Kể về một chuyến du lịch đến một thành phố hoặc đất nước mà bạn ấn tượng nhất: phong cảnh thiên nhiên, văn hóa, ẩm thực đặc sắc và cảm xúc của bạn.',
    keywords: ['旅行 (Du lịch)', '风景 (Phong cảnh)', '特色美食 (Món đặc sản)', '印象深刻 (Ấn tượng sâu sắc)', '留念 (Kỷ niệm)'],
    sampleStructure: '去年夏天，我有机会去了一趟...。那里的风景不仅...，而且当地人非常...',
  },
]

interface TopicSuggestionsProps {
  currentText: string
  onSelectPrompt: (promptText: string) => void
}

export function TopicSuggestions({ currentText, onSelectPrompt }: TopicSuggestionsProps) {
  const [selectedTopic, setSelectedTopic] = useState<WritingTopic | null>(null)
  const [showConfirmModal, setShowConfirmModal] = useState(false)

  const handleApplyTopic = () => {
    if (!selectedTopic) return
    if (currentText.trim().length > 0) {
      // Confirm if there's already writing in progress
      setShowConfirmModal(true)
    } else {
      onSelectPrompt(selectedTopic.sampleStructure)
      setSelectedTopic(null)
    }
  }

  const handleConfirmReplace = () => {
    if (selectedTopic) {
      onSelectPrompt(selectedTopic.sampleStructure)
      setSelectedTopic(null)
      setShowConfirmModal(false)
    }
  }

  return (
    <div className="space-y-3 font-serif">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <span className="w-2 h-2 rounded-full bg-app-accent" />
          <h2 className="text-xs sm:text-sm font-bold text-title flex items-center gap-1.5">
            <Compass className="w-4 h-4 text-app-accent" />
            <span>Hôm nay viết gì? (Chủ đề gợi ý)</span>
          </h2>
        </div>
        <span className="text-[11px] text-muted hidden sm:inline">
          Nhấp vào chủ đề để xem hướng dẫn & từ khóa
        </span>
      </div>

      {/* Horizontal Topic Chips */}
      <div className="flex items-center gap-2 overflow-x-auto pb-1.5 no-scrollbar scroll-smooth">
        {WRITING_TOPICS.map((topic) => {
          const isSelected = selectedTopic?.id === topic.id
          return (
            <button
              key={topic.id}
              type="button"
              onClick={() => setSelectedTopic(isSelected ? null : topic)}
              className={`flex-shrink-0 flex items-center gap-2 px-3 py-1.5 rounded-xl border text-xs transition-all duration-200 cursor-pointer ${
                isSelected
                  ? 'bg-app-accent text-white border-app-accent shadow-2xs font-semibold'
                  : 'bg-card text-title border-border hover:border-app-accent/60 hover:bg-page'
              }`}
            >
              <span>{topic.icon}</span>
              <span className="font-medium">{topic.title}</span>
              <span className={`text-[10px] px-1.5 py-0.2 rounded-md ${
                isSelected ? 'bg-white/20 text-white' : 'bg-page text-muted border border-border'
              }`}>
                {topic.levelHint}
              </span>
            </button>
          )
        })}
      </div>

      {/* Expanded Topic Detail Card */}
      {selectedTopic && (
        <div className="bg-card border border-app-accent/30 rounded-2xl p-4 sm:p-5 shadow-sm space-y-3.5 animate-in fade-in slide-in-from-top-2 duration-200">
          <div className="flex items-start justify-between gap-3">
            <div className="flex items-center gap-2.5">
              <span className="text-2xl p-2 bg-app-accent-soft/50 rounded-xl border border-app-accent/20">
                {selectedTopic.icon}
              </span>
              <div>
                <div className="flex items-center gap-2">
                  <h3 className="font-bold text-sm text-title">{selectedTopic.title}</h3>
                  <span className="text-xs text-app-accent font-bold font-sans">
                    ({selectedTopic.chineseTitle})
                  </span>
                  <span className="text-[10px] bg-jade-soft text-jade font-sans px-2 py-0.5 rounded-full font-medium">
                    Phù hợp {selectedTopic.levelHint}
                  </span>
                </div>
                <p className="text-xs text-muted mt-1 leading-relaxed">
                  {selectedTopic.prompt}
                </p>
              </div>
            </div>
            <button
              type="button"
              onClick={() => setSelectedTopic(null)}
              className="text-muted hover:text-title p-1 rounded-lg hover:bg-page"
              title="Đóng gợi ý"
            >
              <X className="w-4 h-4" />
            </button>
          </div>

          {/* Keywords & Sentence Template */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3 pt-2 border-t border-border/60 text-xs">
            <div className="space-y-1">
              <span className="text-[11px] font-bold text-muted uppercase tracking-wider">
                Từ vựng then chốt nên dùng:
              </span>
              <div className="flex flex-wrap gap-1.5 pt-0.5">
                {selectedTopic.keywords.map((kw, i) => (
                  <span
                    key={i}
                    className="bg-page px-2 py-0.5 rounded-lg border border-border text-[11px] text-body"
                  >
                    {kw}
                  </span>
                ))}
              </div>
            </div>

            <div className="space-y-1">
              <span className="text-[11px] font-bold text-muted uppercase tracking-wider">
                Cấu trúc câu gợi ý mở bài:
              </span>
              <div className="bg-page p-2 rounded-xl border border-border text-[11px] font-mono text-body">
                {selectedTopic.sampleStructure}
              </div>
            </div>
          </div>

          {/* Action Row */}
          <div className="flex items-center justify-between pt-1">
            <span className="text-[11px] text-muted italic">
              💡 Bạn có thể tự viết bài theo đề bài trên hoặc dùng cấu trúc gợi ý để bắt đầu.
            </span>
            <Button
              type="button"
              size="sm"
              onClick={handleApplyTopic}
              className="font-serif text-xs h-8 bg-title hover:bg-app-accent text-white rounded-xl gap-1.5"
            >
              <NotebookPen className="w-3.5 h-3.5 text-gold" />
              <span>Chèn khung gợi ý vào bài viết</span>
            </Button>
          </div>
        </div>
      )}

      {/* Confirmation Modal if text is not empty */}
      {showConfirmModal && (
        <div className="fixed inset-0 z-50 bg-black/40 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-card border border-border rounded-2xl max-w-sm w-full p-5 space-y-4 shadow-xl animate-in zoom-in-95">
            <h4 className="font-bold text-sm text-title">Thay thế nội dung đang viết?</h4>
            <p className="text-xs text-muted leading-relaxed">
              Khung soạn thảo hiện tại của bạn đã có chữ. Bạn có muốn ghi đè bằng mẫu cấu trúc gợi ý của chủ đề{' '}
              <strong>&ldquo;{selectedTopic?.title}&rdquo;</strong> không?
            </p>
            <div className="flex justify-end gap-2 pt-2">
              <Button
                variant="outline"
                size="sm"
                onClick={() => setShowConfirmModal(false)}
                className="font-serif text-xs h-8"
              >
                Hủy bỏ
              </Button>
              <Button
                size="sm"
                onClick={handleConfirmReplace}
                className="font-serif text-xs h-8 bg-app-accent hover:bg-accent-hover text-white"
              >
                Đồng ý thay thế
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
