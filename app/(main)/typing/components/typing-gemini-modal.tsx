'use client'

import { useState, useEffect, useRef } from 'react'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { TypingSegment } from '@/lib/typing-storage'
import {
  buildTypingPinyinPrompt,
  validateGeminiTypingJson,
  ValidationReport,
} from '@/lib/typing-gemini-validator'
import {
  Languages,
  Copy,
  Check,
  ExternalLink,
  CheckCircle2,
  AlertTriangle,
  XCircle,
  Eye,
  Trash2,
  ArrowRight,
  Info,
  Layers,
} from 'lucide-react'
import { toast } from 'sonner'

interface TypingGeminiModalProps {
  isOpen: boolean;
  onClose: () => void;
  rawText: string;
  onApplySegments: (segments: TypingSegment[]) => void;
  exerciseTitle?: string;
}

export default function TypingGeminiModal({
  isOpen,
  onClose,
  rawText,
  onApplySegments,
  exerciseTitle,
}: TypingGeminiModalProps) {
  // Trạng thái Prompt
  const [promptText, setPromptText] = useState('')
  const [isCopied, setIsCopied] = useState(false)
  const [isEditingPrompt, setIsEditingPrompt] = useState(false)
  const promptRef = useRef<HTMLTextAreaElement | null>(null)

  // Trạng thái nhập kết quả Gemini
  const [geminiJsonInput, setGeminiJsonInput] = useState('')
  const [validationReport, setValidationReport] = useState<ValidationReport | null>(null)
  const [hasChecked, setHasChecked] = useState(false)

  // Khi modal mở hoặc rawText thay đổi, sinh prompt tương ứng
  useEffect(() => {
    if (rawText && rawText.trim()) {
      const generated = buildTypingPinyinPrompt(rawText.trim())
      setPromptText(generated)
    } else {
      setPromptText('')
    }
    // Reset form validation khi đổi text
    setGeminiJsonInput('')
    setValidationReport(null)
    setHasChecked(false)
    setIsCopied(false)
  }, [rawText, isOpen])

  // Xử lý sao chép prompt
  const handleCopyPrompt = async () => {
    if (!promptText.trim()) {
      toast.error('Không có nội dung để tạo prompt.')
      return
    }

    try {
      if (navigator?.clipboard?.writeText) {
        await navigator.clipboard.writeText(promptText)
        setIsCopied(true)
        toast.success('Đã sao chép prompt vào bộ nhớ tạm!')
        setTimeout(() => setIsCopied(false), 3000)
      } else {
        throw new Error('Clipboard API không hỗ trợ')
      }
    } catch {
      // Fallback: bôi đen văn bản
      if (promptRef.current) {
        promptRef.current.focus()
        promptRef.current.select()
        setIsCopied(true)
        toast.info('Trình duyệt chặn sao chép tự động. Prompt đã được bôi đen, hãy bấm Ctrl + C.')
        setTimeout(() => setIsCopied(false), 4000)
      }
    }
  }

  // Mở trang Gemini trong tab mới
  const handleOpenGemini = () => {
    window.open('https://gemini.google.com/', '_blank', 'noopener,noreferrer')
  }

  // Kiểm tra và xem trước kết quả
  const handleValidate = () => {
    if (!geminiJsonInput.trim()) {
      toast.error('Vui lòng dán câu trả lời JSON từ Gemini vào ô nhập.')
      return
    }

    const report = validateGeminiTypingJson(geminiJsonInput, rawText)
    setValidationReport(report)
    setHasChecked(true)

    if (report.isValid) {
      if (report.warnings.length > 0) {
        toast.warning(`Trích xuất được ${report.totalSegments} đoạn với một số lưu ý nhỏ. Hãy xem trước kỹ trước khi áp dụng.`)
      } else {
        toast.success(`Dữ liệu JSON hoàn toàn hợp lệ! Khớp ${report.matchedCount} đoạn chữ Hán.`)
      }
    } else {
      toast.error('Dữ liệu JSON không hợp lệ. Vui lòng kiểm tra thông báo lỗi bên dưới.')
    }
  }

  // Xóa nội dung đã dán
  const handleClearJson = () => {
    setGeminiJsonInput('')
    setValidationReport(null)
    setHasChecked(false)
  }

  // Áp dụng Pinyin và Nghĩa vào bài tập
  const handleApply = () => {
    if (!validationReport || !validationReport.canApply || validationReport.parsedSegments.length === 0) {
      toast.error('Không có dữ liệu hợp lệ để áp dụng.')
      return
    }

    onApplySegments(validationReport.parsedSegments)
    toast.success('Đã áp dụng Pinyin và Nghĩa tiếng Việt vào bài luyện đánh máy!')
    onClose()
  }

  return (
    <Dialog open={isOpen} onOpenChange={(open) => !open && onClose()}>
      <DialogContent className="sm:max-w-4xl max-h-[92vh] overflow-y-auto no-scrollbar p-5 md:p-7 bg-card">
        <DialogHeader className="border-b border-border pb-3">
          <DialogTitle className="font-serif font-bold text-lg md:text-xl text-title flex items-center gap-2">
            <Languages className="w-5 h-5 text-app-accent flex-shrink-0" />
            <span>Bổ sung Pinyin & Nghĩa tiếng Việt bằng Gemini cá nhân</span>
          </DialogTitle>
          <DialogDescription className="font-serif text-xs text-muted">
            Quy trình bán tự động • Sử dụng tài khoản Google Gemini của bạn • Không tiêu tốn API quota website
            {exerciseTitle && ` • Bài: "${exerciseTitle}"`}
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-6 pt-2">
          
          {/* Hộp ghi chú bảo mật */}
          <div className="text-[11px] text-muted font-serif bg-page/80 p-3 rounded-xl border border-border flex items-start gap-2">
            <Info className="w-4 h-4 text-app-accent flex-shrink-0 mt-0.5" />
            <span>
              Website tự động tạo prompt sư phạm chuẩn xác cho bạn. Bạn chỉ cần sao chép sang tab Gemini cá nhân, sau đó dán kết quả JSON trở lại đây để kiểm tra đối chiếu trước khi áp dụng.
            </span>
          </div>

          {/* ======================================================== */}
          {/* BƯỚC 1: SAO CHÉP PROMPT & MỞ GEMINI */}
          {/* ======================================================== */}
          <div className="p-4 md:p-5 rounded-2xl bg-page border border-border space-y-4">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-border/80 pb-3">
              <div className="flex items-center gap-2">
                <span className="w-6 h-6 rounded-full bg-title text-white flex items-center justify-center font-bold text-xs">
                  1
                </span>
                <div>
                  <h4 className="font-serif font-bold text-sm text-title">
                    Bước 1: Sao chép Prompt & Mở Google Gemini
                  </h4>
                  <p className="text-[11px] text-muted font-serif">
                    Prompt yêu cầu Gemini phân tích từng câu và trả về cấu trúc JSON chuẩn
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => setIsEditingPrompt(!isEditingPrompt)}
                  className="font-serif text-xs rounded-xl border-border h-8"
                >
                  {isEditingPrompt ? 'Khóa sửa' : 'Tự sửa prompt'}
                </Button>

                <Button
                  size="sm"
                  onClick={handleCopyPrompt}
                  className={`font-serif text-xs rounded-xl shadow-2xs gap-1.5 h-8 px-4 transition-all ${
                    isCopied
                      ? 'bg-jade hover:bg-emerald-700 text-white font-bold'
                      : 'bg-app-accent hover:bg-accent-hover text-white'
                  }`}
                >
                  {isCopied ? <Check className="w-3.5 h-3.5" /> : <Copy className="w-3.5 h-3.5" />}
                  <span>{isCopied ? 'Đã sao chép prompt!' : 'Sao chép prompt'}</span>
                </Button>
              </div>
            </div>

            {/* Ô hiển thị / chỉnh sửa prompt */}
            <textarea
              ref={promptRef}
              value={promptText}
              onChange={(e) => setPromptText(e.target.value)}
              readOnly={!isEditingPrompt}
              rows={6}
              className={`w-full p-3.5 rounded-xl border font-mono text-xs text-body leading-relaxed transition-colors shadow-inner ${
                isEditingPrompt
                  ? 'bg-card border-app-accent focus:outline-none ring-1 ring-app-accent'
                  : 'bg-card/70 border-border select-all'
              }`}
            />

            {/* Nút mở Gemini kèm hướng dẫn ngắn */}
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-1">
              <p className="text-[11px] text-muted font-serif">
                Sau khi bấm <strong>Sao chép prompt</strong>, hãy mở Gemini trong tab mới để gửi yêu cầu.
              </p>

              <Button
                size="sm"
                onClick={handleOpenGemini}
                className="font-serif text-xs rounded-xl bg-title hover:bg-[#2A3250] text-white shadow-2xs gap-1.5 h-9 px-4 shrink-0"
              >
                <span>Mở Gemini (gemini.google.com)</span>
                <ExternalLink className="w-3.5 h-3.5" />
              </Button>
            </div>
          </div>

          {/* ======================================================== */}
          {/* BƯỚC 2: DÁN KẾT QUẢ TỪ GEMINI & KIỂM TRA */}
          {/* ======================================================== */}
          <div className="p-4 md:p-5 rounded-2xl bg-page border border-border space-y-4">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-border/80 pb-3">
              <div className="flex items-center gap-2">
                <span className="w-6 h-6 rounded-full bg-title text-white flex items-center justify-center font-bold text-xs">
                  2
                </span>
                <div>
                  <h4 className="font-serif font-bold text-sm text-title">
                    Bước 2: Dán kết quả JSON từ Gemini & Xem trước
                  </h4>
                  <p className="text-[11px] text-muted font-serif">
                    Dán toàn bộ phản hồi JSON từ Gemini vào đây để kiểm tra tính khớp nối
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={handleClearJson}
                  disabled={!geminiJsonInput}
                  className="font-serif text-xs rounded-xl border-border text-muted hover:text-red-600 gap-1 h-8"
                >
                  <Trash2 className="w-3.5 h-3.5" />
                  <span>Xóa</span>
                </Button>

                <Button
                  size="sm"
                  onClick={handleValidate}
                  disabled={!geminiJsonInput.trim()}
                  className="font-serif text-xs rounded-xl bg-title hover:bg-[#2A3250] text-white shadow-2xs gap-1.5 h-8 px-4"
                >
                  <Eye className="w-3.5 h-3.5" />
                  <span>Xem trước & Kiểm tra</span>
                </Button>
              </div>
            </div>

            {/* Ô nhập JSON */}
            <textarea
              value={geminiJsonInput}
              onChange={(e) => {
                setGeminiJsonInput(e.target.value)
                if (hasChecked) setHasChecked(false)
              }}
              rows={7}
              placeholder={`Dán kết quả JSON từ Gemini vào đây...\nVí dụ:\n{\n  "segments": [\n    {\n      "chinese": "我喜欢学习中文。",\n      "pinyin": "Wǒ xǐhuan xuéxí zhōngwén.",\n      "meaning_vi": "Tôi thích học tiếng Trung."\n    }\n  ]\n}`}
              className="w-full p-3.5 rounded-xl border-2 border-border focus:border-app-accent bg-card text-title font-mono text-xs placeholder:text-muted focus:outline-none transition-colors shadow-inner leading-relaxed whitespace-pre-wrap"
            />

            {/* Báo cáo Validation */}
            {hasChecked && validationReport && (
              <div className="space-y-3 pt-2">
                {/* Lỗi nghiêm trọng */}
                {validationReport.errors.length > 0 && (
                  <div className="p-3.5 rounded-xl bg-red-500/10 border border-red-500/30 text-red-600 dark:text-red-400 text-xs font-serif space-y-1.5">
                    <div className="flex items-center gap-2 font-bold">
                      <XCircle className="w-4 h-4 flex-shrink-0" />
                      <span>Không thể áp dụng dữ liệu do các lỗi sau:</span>
                    </div>
                    <ul className="list-disc list-inside space-y-1 pl-1 text-[11px]">
                      {validationReport.errors.map((err, i) => (
                        <li key={i}>{err}</li>
                      ))}
                    </ul>
                  </div>
                )}

                {/* Cảnh báo (nhắc nhở nếu có thiếu sót nhỏ) */}
                {validationReport.warnings.length > 0 && (
                  <div className="p-3.5 rounded-xl bg-amber-500/10 border border-amber-500/30 text-amber-700 dark:text-amber-400 text-xs font-serif space-y-1.5">
                    <div className="flex items-center gap-2 font-bold">
                      <AlertTriangle className="w-4 h-4 flex-shrink-0" />
                      <span>Lưu ý kiểm tra ({validationReport.warnings.length}):</span>
                    </div>
                    <ul className="list-disc list-inside space-y-0.5 pl-1 text-[11px] max-h-32 overflow-y-auto no-scrollbar">
                      {validationReport.warnings.map((warn, i) => (
                        <li key={i}>{warn}</li>
                      ))}
                    </ul>
                  </div>
                )}

                {/* Hợp lệ & Thống kê */}
                {validationReport.isValid && (
                  <div className="p-3.5 rounded-xl bg-emerald-500/10 border border-emerald-500/30 text-jade text-xs font-serif flex items-center justify-between flex-wrap gap-2">
                    <div className="flex items-center gap-2">
                      <CheckCircle2 className="w-4 h-4 flex-shrink-0 text-jade" />
                      <span className="font-bold">
                        Đã xác thực thành công {validationReport.totalSegments} đoạn văn bản!
                      </span>
                    </div>
                    <span className="text-[11px] font-sans">
                      Khớp chữ Hán: {validationReport.matchedCount}/{validationReport.totalSegments} đoạn
                    </span>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* ======================================================== */}
          {/* BƯỚC 3: XEM TRƯỚC VÀ XÁC NHẬN ÁP DỤNG */}
          {/* ======================================================== */}
          {validationReport && validationReport.parsedSegments.length > 0 && (
            <div className="p-4 md:p-5 rounded-2xl bg-card border border-border space-y-4 shadow-2xs">
              <div className="flex items-center justify-between border-b border-border/80 pb-3">
                <div className="flex items-center gap-2">
                  <Layers className="w-4 h-4 text-app-accent" />
                  <h4 className="font-serif font-bold text-sm text-title">
                    Bản xem trước 3 lớp thông tin (Chữ Hán - Pinyin - Nghĩa)
                  </h4>
                </div>
                <span className="text-xs text-muted font-serif">
                  {validationReport.parsedSegments.length} câu / đoạn
                </span>
              </div>

              {/* Danh sách từng đoạn xem trước */}
              <div className="space-y-3 max-h-64 overflow-y-auto no-scrollbar pr-1">
                {validationReport.parsedSegments.map((seg, idx) => (
                  <div
                    key={idx}
                    className="p-3 rounded-xl bg-page border border-border/80 space-y-1.5 text-left transition-all hover:border-app-accent/40"
                  >
                    <div className="flex items-center justify-between text-[11px] text-muted font-serif">
                      <span className="font-bold text-title">Câu {idx + 1}</span>
                      <span className="font-mono text-[10px]">{seg.chinese.length} ký tự</span>
                    </div>

                    {/* Lớp 1: Chữ Hán */}
                    <p
                      className="font-serif text-base text-title font-medium leading-relaxed"
                      style={{ fontFamily: 'var(--font-chinese), sans-serif' }}
                    >
                      {seg.chinese}
                    </p>

                    {/* Lớp 2: Pinyin */}
                    <p className="text-xs font-sans text-app-accent font-medium tracking-wide">
                      {seg.pinyin || <span className="text-muted italic">(Chưa có Pinyin)</span>}
                    </p>

                    {/* Lớp 3: Nghĩa tiếng Việt */}
                    <p className="text-xs font-serif text-muted italic">
                      {seg.meaning_vi || <span className="text-muted italic">(Chưa có nghĩa)</span>}
                    </p>
                  </div>
                ))}
              </div>

              {/* Nút hành động áp dụng */}
              <div className="flex items-center justify-end gap-3 pt-3 border-t border-border/80">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={onClose}
                  className="font-serif text-xs rounded-xl border-border"
                >
                  Hủy bỏ
                </Button>

                <Button
                  size="sm"
                  onClick={handleApply}
                  disabled={!validationReport.canApply}
                  className="font-serif text-xs rounded-xl bg-jade hover:bg-emerald-700 text-white shadow-2xs gap-1.5 px-5 font-bold"
                >
                  <CheckCircle2 className="w-4 h-4" />
                  <span>Áp dụng vào bài luyện đánh máy</span>
                </Button>
              </div>
            </div>
          )}

        </div>
      </DialogContent>
    </Dialog>
  )
}
