# Chinese Notebook (中文笔记本)

> **Nền tảng hỗ trợ học Hán ngữ hiện đại, luyện thi HSK, trau dồi từ vựng, ngữ pháp và luyện tập tương tác đa giác quan.**

---

## 📌 Thông tin Dự án & Tác quyền

* **Tên dự án:** Chinese Notebook
* **Người phát triển:** Trần Doãn Khoa
* **Bản quyền:** © 2026 Trần Doãn Khoa. All rights reserved.
* **Tình trạng phân phối:** Sản phẩm cá nhân độc quyền (Proprietary / All Rights Reserved).

---

## ✨ Tính năng Nổi bật

1. **Lộ trình HSK Chuẩn hóa (HSK 1 – 6):**
   - Kho dữ liệu từ vựng HSK đối soát thực tế, chuẩn xác theo khung khảo thí Hán ngữ quốc tế.
   - Pinyin, nghĩa tiếng Việt chuẩn, âm Hán Việt và các câu ví dụ ứng dụng song ngữ.

2. **Luyện gõ chữ Hán (Pinyin Typing IME):**
   - Trình luyện gõ theo thời gian thực mô phỏng bộ gõ chuẩn, đo lường tốc độ WPM và độ chính xác.
   - Cơ chế phát hiện và lưu trữ câu sai để củng cố phản xạ ghi nhớ mặt chữ.

3. **Hệ thống Flashcard SRS (Spaced Repetition System):**
   - Luyện nhớ từ vựng với thuật toán lặp lại ngắt quãng, tự động phân phối từ vựng cần ôn tập theo mức độ ghi nhớ.

4. **214 Bộ thủ Khang Hy & Bút thuận:**
   - Tra cứu đầy đủ biến thể, ý nghĩa và ví dụ của 214 bộ thủ kinh điển.
   - Hoạt họa mô phỏng quy tắc bút thuận trực quan từng nét vẽ chữ Hán.

5. **Chuyên đề Ứng dụng Thực tế:**
   - Tiếng Trung giao tiếp hàng ngày và Tiếng Trung công xưởng / nhà máy.

---

## 🛠️ Công nghệ & Kiến trúc Hệ thống

* **Framework:** Next.js 16 (App Router)
* **Frontend:** React 19, TypeScript, TailwindCSS v4, shadcn/ui
* **Database & Auth:** Supabase (PostgreSQL với Row Level Security)
* **Animation & Visuals:** Hanzi Writer, Lucide React, Canvas Confetti
* **Typography:** Lora (Serif) & Noto Sans SC (Simplified Chinese)
* **Hosting:** Vercel

---

## 🚀 Khởi chạy Môi trường Phát triển

Yêu cầu môi trường: **Node.js 20.x trở lên** (khuyến nghị 24.x)

```bash
# Cài đặt thư viện phụ thuộc
npm install

# Khởi chạy máy chủ phát triển
npm run dev

# Kiểm tra kiểu dữ liệu TypeScript
npm run type-check

# Đóng gói sản phẩm (Production Build)
npm run build
```

Mở trình duyệt tại: [http://localhost:3000](http://localhost:3000)

---

## 📜 Điều khoản Bản quyền & Sở hữu Trí tuệ

### 1. Thành phần thuộc quyền sở hữu của Trần Doãn Khoa
* Toàn bộ mã nguồn hệ thống, kiến trúc giải pháp, thuật toán phần mềm và ngôn ngữ thiết kế giao diện (UI/UX) của website là tài sản trí tuệ độc quyền của **Trần Doãn Khoa**.
* Mọi hành vi sao chép, phân phối lại hoặc thương mại hóa mã nguồn khi chưa có sự đồng ý bằng văn bản của tác giả đều bị nghiêm cấm theo quy định pháp luật về quyền tác giả.

### 2. Dữ liệu khảo thí Hán ngữ
* Danh mục cấp độ và từ vựng khảo thí HSK dựa trên tiêu chuẩn học thuật của cơ quan khảo thí Hán ngữ quốc tế (Hanban / CTI). Chinese Notebook không tuyên bố sở hữu đối với các danh mục khảo thí học thuật công cộng.

### 3. Thư viện mã nguồn mở bên thứ ba
Dự án ứng dụng các thư viện mã nguồn mở với sự tuân thủ đầy đủ điều khoản giấy phép đi kèm:
* Next.js, React, Hanzi Writer, TailwindCSS (MIT License)
* Lucide React (ISC License)
* Supabase (Apache-2.0 / MIT)
* Phông chữ Lora & Noto Sans SC (SIL Open Font License 1.1)

Chi tiết xem tại tài liệu [LEGAL.md](./LEGAL.md).
