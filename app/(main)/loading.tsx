export default function DashboardLoading() {
  return (
    <div className="w-full max-w-6xl mx-auto space-y-6 animate-pulse font-serif py-2">
      {/* 1. Header Banner Skeleton */}
      <div className="h-36 rounded-2xl bg-black/5 border border-border/40 p-6 flex flex-col justify-center space-y-3">
        <div className="h-4 w-28 bg-black/10 rounded-full" />
        <div className="h-7 w-64 bg-black/10 rounded-lg" />
        <div className="h-3 w-80 bg-black/5 rounded-md" />
      </div>

      {/* 2. Sub-Navigation / Filter Bar Skeleton */}
      <div className="flex items-center gap-2 overflow-hidden py-1">
        <div className="h-9 w-24 bg-black/10 rounded-xl flex-shrink-0" />
        <div className="h-9 w-24 bg-black/5 rounded-xl flex-shrink-0" />
        <div className="h-9 w-24 bg-black/5 rounded-xl flex-shrink-0" />
        <div className="h-9 w-24 bg-black/5 rounded-xl flex-shrink-0" />
        <div className="h-9 w-24 bg-black/5 rounded-xl flex-shrink-0" />
      </div>

      {/* 3. Content Cards Grid Skeleton */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {[1, 2, 3, 4, 5, 6].map((i) => (
          <div
            key={i}
            className="h-32 rounded-2xl border border-border/50 bg-card/60 p-4 flex flex-col justify-between"
          >
            <div className="flex items-center justify-between">
              <div className="h-6 w-14 bg-black/10 rounded-lg" />
              <div className="h-4 w-10 bg-black/5 rounded-full" />
            </div>
            <div className="space-y-1.5">
              <div className="h-4 w-3/4 bg-black/10 rounded" />
              <div className="h-3 w-1/2 bg-black/5 rounded" />
            </div>
            <div className="h-1.5 w-full bg-black/5 rounded-full" />
          </div>
        ))}
      </div>
    </div>
  )
}
