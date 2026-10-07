export default function Loading() {
  return (
    <div className="flex flex-col items-center justify-center w-full h-full min-h-[50vh] space-y-6">
      <div className="relative w-16 h-16 flex items-center justify-center">
        <div className="absolute inset-0 bg-primary/20 rounded-full animate-ping" style={{ animationDuration: '2s' }}></div>
        <div className="relative z-10 w-14 h-14 bg-gradient-to-br from-primary to-primary/80 rounded-2xl flex items-center justify-center shadow-xl shadow-primary/20 transform rotate-3 hover:rotate-0 transition-transform duration-500 animate-pulse">
          <span className="text-primary-foreground text-3xl font-serif">汉</span>
        </div>
      </div>
      <p className="text-muted-foreground font-serif tracking-[0.2em] text-xs uppercase animate-pulse">
        Đang tải...
      </p>
    </div>
  )
}
