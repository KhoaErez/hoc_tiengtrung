<!-- BEGIN:nextjs-agent-rules -->

# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` (resolved from this file's directory; in monorepos the `next` package may not be visible from the repo root) before writing any code. Heed deprecation notices.

This block is written and re-added by `next dev` — verify at `node_modules/next/dist/server/lib/generate-agent-files.js`. Removing it from a diff only re-creates the uncommitted change; committing it with your work keeps the tree clean.

<!-- END:nextjs-agent-rules -->

# Custom Assistant Rules & Workflow Directives

## 1. Completion Notification Requirement (Bắt buộc)
Khi hoàn thành bất kỳ nhiệm vụ hoặc giai đoạn công việc nào, trợ lý AI bắt buộc phải:
1. Kích hoạt thông báo âm thanh hệ thống (chạy lệnh PowerShell `[System.Console]::Beep(1200, 300)` hoặc phát chuông báo hiệu).
2. Hiển thị thông báo trạng thái hoàn thành rõ ràng, nổi bật ở cuối câu trả lời cho người dùng (bao gồm tóm tắt kết quả, trạng thái build/test và các bước tiếp theo).

## 2. Chinese Notebook EdTech Design System
Tuân thủ định hướng giao diện "Immersive 3D EdTech Experience" lấy cảm hứng từ The Mandarin Lab:
- Hero phong cảnh 3D có chiều sâu (núi non, biển mây, ánh bình minh, con đường học vấn).
- Thanh điều hướng Pill Navbar viền Navy Ink (`#182238`), nền ngà sáng (`#FAF7F2`), bóng đổ tactile (`shadow-[0_4px_0_#182238]`).
- Khung thông tin nổi Floating Frosted Glass Panel ở góc trái với độ tương phản cao, bo góc lớn (`rounded-3xl`).
- Mascot Panda 3D (Tiểu Bút 🐼) ở góc dưới bên phải với bong bóng chào đón và các thao tác nhanh.
- Giữ nguyên bộ nhận diện thương hiệu Chinese Notebook: Đỏ Chu Sa (`#B8322D`), Xanh Mực Navy (`#182238`), Giấy Ngà Tuyên Chỉ (`#FAF7F2`).
- Bảo toàn toàn bộ dữ liệu Supabase, logic Luyện gõ phím (bảo vệ IME Pinyin, 2-step Enter), thuật toán ôn tập SM-2 và phân quyền hệ thống.
