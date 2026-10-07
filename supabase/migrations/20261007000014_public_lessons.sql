-- Allow anyone to read all lessons
DROP POLICY IF EXISTS "Anyone can read system lessons." ON public.lessons;
CREATE POLICY "Anyone can read all lessons." ON public.lessons FOR SELECT USING (true);

-- Allow anyone to read all lesson_vocabularies
DROP POLICY IF EXISTS "Anyone can read system lesson_vocabularies." ON public.lesson_vocabularies;
CREATE POLICY "Anyone can read all lesson_vocabularies." ON public.lesson_vocabularies FOR SELECT USING (true);
