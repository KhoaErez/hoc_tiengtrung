-- Add example columns to vocabularies

ALTER TABLE public.vocabularies
ADD COLUMN IF NOT EXISTS example_hanzi text,
ADD COLUMN IF NOT EXISTS example_pinyin text,
ADD COLUMN IF NOT EXISTS example_vi text;
