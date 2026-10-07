-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- 1. PROFILES
create table if not exists public.profiles (
  id uuid references auth.users on delete cascade not null primary key,
  email text not null,
  display_name text,
  avatar_url text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. TOPICS
create table if not exists public.topics (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  name_vi text not null,
  name_zh text not null,
  description text,
  hsk_level text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. LESSONS
create table if not exists public.lessons (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  topic_id uuid references public.topics(id) on delete set null,
  title text not null,
  subtitle text,
  original_text text not null,
  pinyin text,
  translation_vi text,
  hsk_level text,
  source_type text, -- 'upload', 'text', 'topic'
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 4. VOCABULARIES (Global dictionary)
create table if not exists public.vocabularies (
  id uuid default uuid_generate_v4() primary key,
  hanzi text not null,
  pinyin text not null,
  meaning_vi text not null,
  word_type text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  unique(hanzi, pinyin)
);

-- 5. LESSON_VOCABULARIES (User selected vocabs for a lesson)
create table if not exists public.lesson_vocabularies (
  id uuid default uuid_generate_v4() primary key,
  lesson_id uuid references public.lessons(id) on delete cascade not null,
  vocabulary_id uuid references public.vocabularies(id) on delete cascade not null,
  is_selected boolean default true,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  unique(lesson_id, vocabulary_id)
);

-- 6. GRAMMAR_POINTS (Global grammar)
create table if not exists public.grammar_points (
  id uuid default uuid_generate_v4() primary key,
  name text not null,
  pattern text not null,
  explanation_vi text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 7. LESSON_GRAMMAR_POINTS (User selected grammar for a lesson)
create table if not exists public.lesson_grammar_points (
  id uuid default uuid_generate_v4() primary key,
  lesson_id uuid references public.lessons(id) on delete cascade not null,
  grammar_point_id uuid references public.grammar_points(id) on delete cascade not null,
  is_selected boolean default true,
  unique(lesson_id, grammar_point_id)
);

-- 8. GRAMMAR_EXAMPLES
create table if not exists public.grammar_examples (
  id uuid default uuid_generate_v4() primary key,
  grammar_point_id uuid references public.grammar_points(id) on delete cascade not null,
  chinese text not null,
  pinyin text,
  translation_vi text,
  explanation text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 9. USER_VOCABULARIES (Progress tracking)
create table if not exists public.user_vocabularies (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  vocabulary_id uuid references public.vocabularies(id) on delete cascade not null,
  status text default 'learning', -- 'learning', 'memorized'
  review_count integer default 0,
  last_reviewed_at timestamp with time zone,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  unique(user_id, vocabulary_id)
);

-- 10. AI_GENERATIONS
create table if not exists public.ai_generations (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  lesson_id uuid references public.lessons(id) on delete cascade,
  type text not null, -- 'grammar_analysis', 'writing_correction', 'translation'
  input text not null,
  output jsonb not null,
  model text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 11. FILES (For uploaded docs/pdfs)
create table if not exists public.files (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  lesson_id uuid references public.lessons(id) on delete cascade,
  file_name text not null,
  file_path text not null,
  file_type text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-------------------------------------------------------
-- ROW LEVEL SECURITY (RLS)
-------------------------------------------------------

-- Enable RLS for all tables
alter table public.profiles enable row level security;
alter table public.topics enable row level security;
alter table public.lessons enable row level security;
alter table public.vocabularies enable row level security;
alter table public.lesson_vocabularies enable row level security;
alter table public.grammar_points enable row level security;
alter table public.lesson_grammar_points enable row level security;
alter table public.grammar_examples enable row level security;
alter table public.user_vocabularies enable row level security;
alter table public.ai_generations enable row level security;
alter table public.files enable row level security;

-- PROFILES
create policy "Users can view own profile." on public.profiles for select using (auth.uid() = id);
create policy "Users can insert own profile." on public.profiles for insert with check (auth.uid() = id);
create policy "Users can update own profile." on public.profiles for update using (auth.uid() = id);

-- TOPICS
create policy "Users can CRUD own topics." on public.topics for all using (auth.uid() = user_id);

-- LESSONS
create policy "Users can CRUD own lessons." on public.lessons for all using (auth.uid() = user_id);

-- VOCABULARIES (Read-only for users, managed by AI/Admin)
create policy "Anyone can read vocabularies." on public.vocabularies for select using (true);
create policy "Service role can manage vocabularies" on public.vocabularies for all using (auth.jwt()->>'role' = 'service_role');

-- LESSON_VOCABULARIES
create policy "Users can CRUD lesson_vocabularies." on public.lesson_vocabularies for all using (
  exists (select 1 from public.lessons where id = lesson_id and user_id = auth.uid())
);

-- GRAMMAR_POINTS (Read-only for users)
create policy "Anyone can read grammar_points." on public.grammar_points for select using (true);
create policy "Service role can manage grammar_points" on public.grammar_points for all using (auth.jwt()->>'role' = 'service_role');

-- LESSON_GRAMMAR_POINTS
create policy "Users can CRUD lesson_grammar_points." on public.lesson_grammar_points for all using (
  exists (select 1 from public.lessons where id = lesson_id and user_id = auth.uid())
);

-- GRAMMAR_EXAMPLES
create policy "Anyone can read grammar_examples." on public.grammar_examples for select using (true);

-- USER_VOCABULARIES
create policy "Users can CRUD own user_vocabularies." on public.user_vocabularies for all using (auth.uid() = user_id);

-- AI_GENERATIONS
create policy "Users can CRUD own ai_generations." on public.ai_generations for all using (auth.uid() = user_id);

-- FILES
create policy "Users can CRUD own files." on public.files for all using (auth.uid() = user_id);

-------------------------------------------------------
-- TRIGGERS
-------------------------------------------------------

-- Automatically create profile on user signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, email, display_name)
  values (new.id, new.email, split_part(new.email, '@', 1));
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
