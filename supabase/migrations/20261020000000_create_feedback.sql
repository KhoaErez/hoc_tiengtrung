-- Migration: Create feedback table and security policies for Chinese Notebook

-- 1. Bổ sung trường phân quyền admin cho profiles (nếu chưa có)
alter table public.profiles 
add column if not exists is_admin boolean default false;

-- 2. Tạo bảng lưu trữ phản hồi (feedback)
create table if not exists public.feedback (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete set null,
  category text not null check (category in ('bug', 'feature', 'ui_ux', 'content', 'other')),
  title text not null,
  message text not null,
  steps_to_reproduce text,
  page_url text,
  device_info text,
  status text not null default 'new' check (status in ('new', 'under_review', 'in_progress', 'resolved', 'wont_fix')),
  admin_note text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Index tối ưu tốc độ tra cứu cho Admin
create index if not exists idx_feedback_status on public.feedback(status);
create index if not exists idx_feedback_created_at on public.feedback(created_at desc);
create index if not exists idx_feedback_user_id on public.feedback(user_id);

-- 3. Kích hoạt Row Level Security (RLS)
alter table public.feedback enable row level security;

-- Policy A: Cho phép bất kỳ ai (kể cả khách vãng lai hoặc đã đăng nhập) gửi góp ý
create policy "Anyone can insert feedback" 
  on public.feedback for insert 
  with check (true);

-- Policy B: Người dùng chỉ được xem phản hồi do chính mình tạo (nếu đăng nhập)
create policy "Users can view own feedback" 
  on public.feedback for select 
  using (auth.uid() = user_id);

-- Policy C: Chỉ Admin mới có quyền xem toàn bộ phản hồi
create policy "Admins can view all feedback" 
  on public.feedback for select 
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and is_admin = true
    )
  );

-- Policy D: Chỉ Admin mới có quyền cập nhật trạng thái và ghi chú nội bộ
create policy "Admins can update feedback" 
  on public.feedback for update 
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and is_admin = true
    )
  );
