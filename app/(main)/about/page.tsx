import type { Metadata } from 'next'
import Link from 'next/link'
import { 
  ShieldCheck, 
  User, 
  Code2, 
  BookOpen, 
  Scale, 
  Layers, 
  CheckCircle2, 
  Sparkles,
  ArrowLeft,
  ExternalLink
} from 'lucide-react'
import { SITE_CONFIG } from '@/lib/site-config'
import { BrandSymbol } from '@/components/ui/brand-logo'

export const metadata: Metadata = {
  title: 'Về Chinese Notebook | Tác giả & Quyền sở hữu trí tuệ',
  description: 'Thông tin chính thức về dự án Chinese Notebook, người phát triển Trần Doãn Khoa, mục đích nền tảng và chính sách bản quyền.',
}

export default function AboutPage() {
  return (
    <div className="max-w-4xl mx-auto space-y-8 animate-in fade-in duration-300">
      {/* 1. Header điều hướng và tiêu đề chính */}
      <div className="space-y-3">
        <Link 
          href="/" 
          className="inline-flex items-center gap-1.5 text-xs font-serif text-muted hover:text-app-accent transition-colors group"
        >
          <ArrowLeft className="w-3.5 h-3.5 transition-transform group-hover:-translate-x-1" />
          <span>Quay lại Trang chủ</span>
        </Link>

        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-border/60">
          <div className="flex items-center gap-3.5">
            <BrandSymbol size={44} />
            <div>
              <h1 className="text-2xl sm:text-3xl font-serif font-bold text-title tracking-tight">
                Về {SITE_CONFIG.name}
              </h1>
              <p className="text-xs sm:text-sm font-serif text-muted mt-0.5">
                {SITE_CONFIG.tagline}
              </p>
            </div>
          </div>
          <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-app-accent-soft border border-app-accent/20 text-app-accent text-xs font-serif self-start sm:self-auto">
            <span className="w-1.5 h-1.5 rounded-full bg-app-accent animate-pulse" />
            <span>Phiên bản {SITE_CONFIG.version} (2026)</span>
          </div>
        </div>
      </div>

      {/* 2. Khối thông tin Tác giả & Mục đích dự án (Core Project Metadata) */}
      <section className="bg-card border border-border rounded-2xl p-6 sm:p-8 shadow-xs space-y-6">
        <div className="flex items-center gap-2.5 text-app-accent">
          <User className="w-5 h-5" />
          <h2 className="text-lg font-serif font-bold text-title">Thông tin Tác giả & Dự án</h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className="p-4 rounded-xl bg-page/70 border border-border/60 space-y-1">
            <span className="text-[11px] font-sans uppercase tracking-wider text-muted font-semibold">
              Tên dự án
            </span>
            <p className="text-base font-serif font-bold text-title">
              {SITE_CONFIG.name}
            </p>
          </div>

          <div className="p-4 rounded-xl bg-page/70 border border-border/60 space-y-1">
            <span className="text-[11px] font-sans uppercase tracking-wider text-muted font-semibold">
              Người thiết kế & phát triển
            </span>
            <p className="text-base font-serif font-bold text-app-accent">
              {SITE_CONFIG.developer}
            </p>
          </div>
        </div>

        <div className="space-y-2">
          <h3 className="text-sm font-serif font-semibold text-title flex items-center gap-2">
            <Sparkles className="w-4 h-4 text-app-accent" />
            <span>Mục đích & Sứ mệnh</span>
          </h3>
          <p className="text-sm font-serif text-body leading-relaxed text-justify">
            <strong>{SITE_CONFIG.name}</strong> là nền tảng số hóa hỗ trợ người Việt học tiếng Trung một cách bài bản, trực quan và khoa học. Dự án được thiết kế và phát triển độc lập bởi <strong>{SITE_CONFIG.developer}</strong> nhằm mục tiêu cung cấp giải pháp toàn diện cho việc tự học, củng cố vốn từ vựng HSK, nắm vững ngữ pháp ứng dụng và rèn luyện các kỹ năng nghe - nói - đọc - gõ chữ Hán.
          </p>
        </div>
      </section>

      {/* 3. Khối tính năng cốt lõi (Core Capabilities) */}
      <section className="bg-card border border-border rounded-2xl p-6 sm:p-8 shadow-xs space-y-5">
        <div className="flex items-center gap-2.5 text-app-accent">
          <BookOpen className="w-5 h-5" />
          <h2 className="text-lg font-serif font-bold text-title">Tính năng trọng tâm</h2>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
          <div className="p-4 rounded-xl bg-page/60 border border-border/60 space-y-1.5">
            <div className="flex items-center gap-2 text-title font-serif font-semibold text-sm">
              <CheckCircle2 className="w-4 h-4 text-app-accent shrink-0" />
              <span>Hệ thống từ vựng HSK (1 - 6)</span>
            </div>
            <p className="text-xs font-serif text-muted leading-relaxed pl-6">
              Tra cứu, học tập từ vựng chuẩn hóa kèm pinyin, nghĩa tiếng Việt, âm Hán Việt và ví dụ ngữ cảnh sinh động.
            </p>
          </div>

          <div className="p-4 rounded-xl bg-page/60 border border-border/60 space-y-1.5">
            <div className="flex items-center gap-2 text-title font-serif font-semibold text-sm">
              <CheckCircle2 className="w-4 h-4 text-app-accent shrink-0" />
              <span>Luyện gõ chữ Hán (Pinyin Typing)</span>
            </div>
            <p className="text-xs font-serif text-muted leading-relaxed pl-6">
              Môi trường rèn luyện phản xạ gõ pinyin chọn chữ Hán theo thời gian thực, lưu lại câu sai để khắc phục điểm yếu.
            </p>
          </div>

          <div className="p-4 rounded-xl bg-page/60 border border-border/60 space-y-1.5">
            <div className="flex items-center gap-2 text-title font-serif font-semibold text-sm">
              <CheckCircle2 className="w-4 h-4 text-app-accent shrink-0" />
              <span>Flashcard & Ôn tập thông minh (SRS)</span>
            </div>
            <p className="text-xs font-serif text-muted leading-relaxed pl-6">
              Thuật toán lặp lại ngắt quãng giúp tối ưu hóa khả năng ghi nhớ dài hạn mặt chữ Hán và ngữ nghĩa.
            </p>
          </div>

          <div className="p-4 rounded-xl bg-page/60 border border-border/60 space-y-1.5">
            <div className="flex items-center gap-2 text-title font-serif font-semibold text-sm">
              <CheckCircle2 className="w-4 h-4 text-app-accent shrink-0" />
              <span>Mô phỏng quy tắc bút thuận</span>
            </div>
            <p className="text-xs font-serif text-muted leading-relaxed pl-6">
              Học viết từng nét chữ Hán chính xác theo trật tự quy chuẩn, trực quan hóa cấu trúc bộ thủ.
            </p>
          </div>
        </div>
      </section>

      {/* 4. Tuyên bố Quyền sở hữu trí tuệ & Giấy phép (Intellectual Property & Licenses) */}
      <section id="intellectual-property" className="bg-card border border-border rounded-2xl p-6 sm:p-8 shadow-xs space-y-6">
        <div className="flex items-center gap-2.5 text-app-accent">
          <Scale className="w-5 h-5" />
          <h2 className="text-lg font-serif font-bold text-title">
            Quyền sở hữu trí tuệ & Điều khoản pháp lý
          </h2>
        </div>

        <p className="text-sm font-serif text-body leading-relaxed text-justify">
          Dự án tuân thủ nghiêm ngặt các nguyên tắc bảo vệ quyền tác giả, minh bạch hóa ranh giới giữa tài sản sáng tạo cá nhân và các thành phần học thuật, mã nguồn mở công cộng:
        </p>

        <div className="space-y-4">
          {/* Mục 1: Mã nguồn và Thiết kế cá nhân */}
          <div className="p-4.5 rounded-xl bg-page/70 border-l-[3px] border-app-accent space-y-2">
            <div className="flex items-center gap-2 text-title font-serif font-bold text-sm">
              <Code2 className="w-4 h-4 text-app-accent" />
              <span>1. Mã nguồn & Thiết kế hệ thống (Proprietary Asset)</span>
            </div>
            <p className="text-xs font-serif text-body leading-relaxed">
              Toàn bộ kiến trúc mã nguồn phần mềm, giao diện người dùng (UI/UX), đồ họa thương hiệu biểu tượng con dấu Hán tự và các thuật toán tương tác độc quyền trên website thuộc quyền sở hữu trí tuệ của <strong>{SITE_CONFIG.developer}</strong>.
            </p>
            <p className="text-[11px] font-mono text-muted">
              {SITE_CONFIG.copyrightNotice}
            </p>
          </div>

          {/* Mục 2: Danh mục khảo thí HSK */}
          <div className="p-4.5 rounded-xl bg-page/70 border-l-[3px] border-border-strong space-y-2">
            <div className="flex items-center gap-2 text-title font-serif font-bold text-sm">
              <Layers className="w-4 h-4 text-muted" />
              <span>2. Dữ liệu chuẩn khảo thí Hán ngữ (HSK Standard)</span>
            </div>
            <p className="text-xs font-serif text-body leading-relaxed text-justify">
              Các danh mục cấp độ từ vựng HSK 1 đến HSK 6 được xây dựng dựa trên tiêu chuẩn khảo thí quốc tế của cơ quan khảo thí Hán ngữ (Hanban / CTI). Chinese Notebook chỉ sở hữu bản quyền đối với phương thức biên tập bài giảng, câu ví dụ minh họa và hệ thống bài tập thực hành do tác giả sáng tạo, không tuyên bố độc quyền đối với bản thân chuẩn khảo thí công cộng.
            </p>
          </div>

          {/* Mục 3: Thư viện mã nguồn mở */}
          <div className="p-4.5 rounded-xl bg-page/70 border-l-[3px] border-border-strong space-y-2">
            <div className="flex items-center gap-2 text-title font-serif font-bold text-sm">
              <ShieldCheck className="w-4 h-4 text-muted" />
              <span>3. Ghi nhận thư viện mã nguồn mở & Phông chữ (Attribution)</span>
            </div>
            <p className="text-xs font-serif text-body leading-relaxed">
              Chinese Notebook trân trọng ghi nhận và tuân thủ giấy phép của các công nghệ mã nguồn mở được ứng dụng trong dự án:
            </p>
            <ul className="text-xs font-serif text-muted space-y-1 list-disc list-inside pl-2">
              <li><strong>Next.js & React:</strong> Được cấp phép theo MIT License (Vercel & Meta).</li>
              <li><strong>Hanzi Writer:</strong> Hiển thị hoạt họa bút thuận chữ Hán theo MIT License.</li>
              <li><strong>Lucide Icons:</strong> Hệ thống biểu tượng giao diện theo ISC License.</li>
              <li><strong>Supabase:</strong> Nền tảng dữ liệu và định danh theo Apache-2.0 / MIT.</li>
              <li><strong>Phông chữ Lora & Noto Sans SC:</strong> Được cấp phép theo SIL Open Font License 1.1.</li>
            </ul>
          </div>
        </div>
      </section>

      {/* 5. Góp ý và Liên hệ */}
      <section className="bg-app-accent-soft/40 border border-app-accent/20 rounded-2xl p-6 text-center space-y-3">
        <h2 className="text-base font-serif font-bold text-title">
          Đóng góp ý kiến & Hỗ trợ học tập
        </h2>
        <p className="text-xs sm:text-sm font-serif text-body max-w-xl mx-auto leading-relaxed">
          Nếu bạn gặp bất kỳ vấn đề gì trong quá trình học tập hoặc có đề xuất cải thiện nội dung, vui lòng gửi phản hồi trực tiếp cho tác giả qua hộp thư <strong>Tiểu Bút</strong> ở góc màn hình.
        </p>
        <div className="pt-1">
          <Link
            href="/"
            className="inline-flex items-center justify-center px-4 py-2 rounded-xl bg-app-accent text-white font-serif text-xs font-medium hover:bg-accent-hover transition-colors shadow-2xs"
          >
            Bắt đầu học ngay
          </Link>
        </div>
      </section>
    </div>
  )
}
