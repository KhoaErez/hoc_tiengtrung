export default function LessonDetailLoading() {
  return (
    <div className="max-w-4xl mx-auto space-y-6 font-serif px-4 pb-20 animate-pulse">
      {/* 1. Header Skeleton */}
      <div className="bg-card border border-border/80 rounded-2xl p-6 md:p-8 shadow-2xs space-y-6">
        {/* Breadcrumb & Navigation Skeleton */}
        <div className="flex items-center justify-between pb-4 border-b border-border/60">
          <div className="h-6 w-36 bg-black/5 rounded-lg" />
          <div className="flex gap-2">
            <div className="h-7 w-20 bg-black/5 rounded-lg" />
            <div className="h-7 w-24 bg-black/5 rounded-lg" />
          </div>
        </div>

        {/* Title & Badge */}
        <div className="space-y-3">
          <div className="h-5 w-24 bg-app-accent-soft rounded-full" />
          <div className="h-8 md:h-10 w-2/3 bg-black/5 rounded-lg" />
          <div className="h-4 w-1/2 bg-black/5 rounded-md" />
        </div>

        {/* Progress & CTA Skeleton */}
        <div className="pt-4 border-t border-border/60 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="space-y-2 flex-1 max-w-xs">
            <div className="flex justify-between">
              <div className="h-3 w-24 bg-black/5 rounded" />
              <div className="h-3 w-12 bg-black/5 rounded" />
            </div>
            <div className="h-2 w-full bg-black/5 rounded-full" />
          </div>
          <div className="h-10 w-32 bg-black/5 rounded-xl" />
        </div>
      </div>

      {/* 2. Vocabulary List Header Skeleton */}
      <div className="flex items-center justify-between pt-2">
        <div className="h-6 w-44 bg-black/5 rounded-lg" />
        <div className="h-8 w-48 bg-black/5 rounded-lg" />
      </div>

      {/* 3. Vocabulary Cards Skeletons */}
      <div className="space-y-3">
        {[1, 2, 3, 4].map((i) => (
          <div
            key={i}
            className="bg-card border border-border/80 rounded-2xl p-5 shadow-2xs flex flex-col md:flex-row md:items-center justify-between gap-4"
          >
            <div className="flex items-start gap-4 flex-1">
              <div className="w-8 h-8 rounded-lg bg-black/5 flex-shrink-0" />
              <div className="space-y-2 flex-1">
                <div className="flex items-baseline gap-3">
                  <div className="h-8 w-16 bg-black/5 rounded" />
                  <div className="h-4 w-20 bg-black/5 rounded" />
                </div>
                <div className="h-4 w-32 bg-black/5 rounded" />
                <div className="h-14 w-full max-w-lg bg-page rounded-xl border border-border/60" />
              </div>
            </div>
            <div className="flex items-center gap-2 self-end md:self-center">
              <div className="w-8 h-8 rounded-xl bg-black/5" />
              <div className="w-20 h-8 rounded-xl bg-black/5" />
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
