-- 1. BẢNG TIẾN ĐỘ BÀI LUYỆN ĐÁNH MÁY (typing_progress)
create table if not exists public.typing_progress (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  mode text not null, -- 'sentence', 'vocabulary', 'paragraph', 'hsk', 'custom'
  exercise_id text not null, -- 'sen-1', 'voc-3', 'par-1', 'hsk-10-ex', etc.
  current_sentence_index integer default 0 not null,
  completed_sentences integer default 0 not null,
  total_sentences integer default 1 not null,
  correct_sentences integer default 0 not null,
  error_sentences integer default 0 not null,
  last_typed_length integer default 0 not null,
  time_spent_seconds integer default 0 not null,
  status text default 'in_progress' not null check (status in ('not_started', 'in_progress', 'completed')),
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null,
  unique(user_id, mode, exercise_id)
);

-- 2. BẢNG CÂU GÕ SAI & ÔN TẬP (typing_mistakes)
create table if not exists public.typing_mistakes (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  mode text not null,
  exercise_id text not null,
  sentence_index integer default 0 not null,
  sentence_zh text not null,
  pinyin text,
  meaning_vi text,
  last_input_zh text not null,
  mistake_details jsonb default '[]'::jsonb not null,
  mistake_count integer default 1 not null,
  review_status text default 'need_review' not null check (review_status in ('need_review', 'reviewing', 'mastered')),
  review_count integer default 0 not null,
  review_correct_count integer default 0 not null,
  consecutive_correct integer default 0 not null,
  last_error_at timestamp with time zone default timezone('utc'::text, now()) not null,
  last_reviewed_at timestamp with time zone,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null,
  unique(user_id, mode, exercise_id, sentence_index)
);

-- 3. INDEXES TỐI ƯU HIỆU NĂNG TRUY VẤN
create index if not exists idx_typing_progress_user_mode on public.typing_progress(user_id, mode);
create index if not exists idx_typing_mistakes_user_status on public.typing_mistakes(user_id, review_status);
create index if not exists idx_typing_mistakes_user_mode on public.typing_mistakes(user_id, mode);

-- 4. ROW LEVEL SECURITY (RLS)
alter table public.typing_progress enable row level security;
alter table public.typing_mistakes enable row level security;

-- Drop old policies if exist
drop policy if exists "Users can view own typing_progress" on public.typing_progress;
drop policy if exists "Users can insert own typing_progress" on public.typing_progress;
drop policy if exists "Users can update own typing_progress" on public.typing_progress;
drop policy if exists "Users can delete own typing_progress" on public.typing_progress;
drop policy if exists "Users can CRUD own typing_progress" on public.typing_progress;

create policy "Users can CRUD own typing_progress"
  on public.typing_progress for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can view own typing_mistakes" on public.typing_mistakes;
drop policy if exists "Users can insert own typing_mistakes" on public.typing_mistakes;
drop policy if exists "Users can update own typing_mistakes" on public.typing_mistakes;
drop policy if exists "Users can delete own typing_mistakes" on public.typing_mistakes;
drop policy if exists "Users can CRUD own typing_mistakes" on public.typing_mistakes;

create policy "Users can CRUD own typing_mistakes"
  on public.typing_mistakes for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
