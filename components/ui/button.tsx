import { Button as ButtonPrimitive } from "@base-ui/react/button"
import { cva, type VariantProps } from "class-variance-authority"
import { cn } from "cn"

const buttonVariants = cva(
  'group/button cursor-pointer relative overflow-hidden inline-flex shrink-0 items-center justify-center rounded-xl border border-transparent bg-clip-padding text-sm font-semibold tracking-wide whitespace-nowrap transition-all duration-300 outline-none select-none active:scale[0.97] focus-visible:ring-4 disabled:pointer-events-none disabled:opacity-60 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*="size-"])]:size-5',
  {
    variants: {
      variant: {
        default: 'bg-gradient-to-br from-red-600 to-red-800 text-white shadow-lg shadow-red-700/30 hover:shadow-xl hover:shadow-red-700/40 hover:-translate-y-0.5',
        outline: 'border-2 border-red-200 bg-white/50 backdrop-blur-sm text-red-700 hover:bg-red-50 hover:border-red-300 shadow-sm',
        secondary: 'bg-gradient-to-br from-slate-700 to-slate-900 text-white shadow-lg shadow-slate-800/30 hover:shadow-xl hover:-translate-y-0.5',
        ghost: 'hover:bg-slate-100/80 hover:text-slate-900 text-slate-600',
        destructive: 'bg-red-100 text-red-700 hover:bg-red-200',
        link: 'text-red-700 underline-offset-4 hover:underline',
      },
      size: {
        default: 'h-11 px-6 py-2',
        xs: 'h-8 px-3 text-xs rounded-md',
        sm: 'h-9 px-4 text-xs rounded-lg',
        lg: 'h-14 px-8 text-lg rounded-2xl',
        icon: 'size-11 rounded-xl',
        'icon-xs': 'size-8 rounded-md',
        'icon-sm': 'size-9 rounded-lg',
        'icon-lg': 'size-14 rounded-2xl',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'default',
    },
  }
)

function Button({
  className,
  variant = "default",
  size = "default",
  ...props
}: ButtonPrimitive.Props & VariantProps<typeof buttonVariants>) {
  return (
    <ButtonPrimitive
      data-slot="button"
      className={cn(buttonVariants({ variant, size, className }))}
      {...props}
    />
  )
}

export { Button, buttonVariants }
