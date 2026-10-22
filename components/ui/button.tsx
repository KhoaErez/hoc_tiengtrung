import * as React from "react"
import { Button as ButtonPrimitive } from "@base-ui/react/button"
import { cva, type VariantProps } from "class-variance-authority"
import { Loader2 } from "lucide-react"
import { cn } from "cn"

const buttonVariants = cva(
  'group/button cursor-pointer relative inline-flex shrink-0 items-center justify-center rounded-xl border border-transparent text-sm font-medium tracking-normal whitespace-nowrap transition-all duration-150 outline-none select-none active:scale-[0.98] focus-visible:ring-2 focus-visible:ring-[#B8322D]/35 focus-visible:ring-offset-1 disabled:pointer-events-none disabled:opacity-50 touch-manipulation motion-reduce:transition-none motion-reduce:transform-none [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*="size-"])]:size-4 gap-2',
  {
    variants: {
      variant: {
        default:
          'bg-[#B8322D] hover:bg-[#982923] active:bg-[#85211B] text-white shadow-2xs hover:shadow-xs',
        primary:
          'bg-[#B8322D] hover:bg-[#982923] active:bg-[#85211B] text-white shadow-2xs hover:shadow-xs',
        secondary:
          'bg-[#FFF9F3] hover:bg-[#F6EDE3] active:bg-[#ECE0D3] text-[#243047] hover:text-[#B8322D] border border-[#E9DDD1] hover:border-[#DDD0C2] shadow-2xs font-semibold',
        neutral:
          'bg-[#F4F0EB] hover:bg-[#EAE4DC] active:bg-[#E0D8CE] text-[#243047] border border-[#E9DDD1] shadow-2xs',
        tertiary:
          'bg-[#243047] hover:bg-[#1A2436] active:bg-[#141C2B] text-white shadow-2xs hover:shadow-xs',
        outline:
          'border border-[#E9DDD1] bg-card hover:bg-[#FFF9F3] text-[#243047] hover:text-[#B8322D] hover:border-[#B8322D]/40 shadow-2xs',
        ghost:
          'hover:bg-[#FFF9F3] text-[#243047] hover:text-[#B8322D]',
        success:
          'bg-[#24856A] hover:bg-[#1B6A54] active:bg-[#165543] text-white shadow-2xs hover:shadow-xs',
        destructive:
          'bg-[#FEE2E2] hover:bg-[#FCD2D2] active:bg-[#F8B4B4] text-[#B91C1C] border border-[#FCA5A5]/60 hover:border-[#F87171] shadow-2xs',
        danger:
          'bg-[#B91C1C] hover:bg-[#991B1B] active:bg-[#7F1D1D] text-white shadow-2xs hover:shadow-xs',
        link:
          'text-[#B8322D] underline-offset-4 hover:underline p-0 h-auto font-normal',
      },
      size: {
        default: 'h-11 px-5 py-2 text-sm rounded-xl min-h-[44px]',
        xs: 'h-8 px-2.5 text-xs rounded-lg min-h-[32px]',
        sm: 'h-9 px-3.5 text-xs rounded-xl min-h-[36px]',
        lg: 'h-12 px-6 text-base rounded-2xl min-h-[48px]',
        icon: 'size-11 rounded-xl min-h-[44px] min-w-[44px] p-0',
        'icon-xs': 'size-8 rounded-lg min-h-[32px] min-w-[32px] p-0',
        'icon-sm': 'size-9 rounded-xl min-h-[36px] min-w-[36px] p-0',
        'icon-lg': 'size-12 rounded-2xl min-h-[48px] min-w-[48px] p-0',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'default',
    },
  }
)

export interface ButtonProps
  extends ButtonPrimitive.Props,
    VariantProps<typeof buttonVariants> {
  isLoading?: boolean
}

function Button({
  className,
  variant = "default",
  size = "default",
  isLoading = false,
  disabled,
  children,
  ...props
}: ButtonProps) {
  return (
    <ButtonPrimitive
      data-slot="button"
      disabled={disabled || isLoading}
      className={cn(buttonVariants({ variant, size, className }))}
      {...props}
    >
      {isLoading && <Loader2 className="w-4 h-4 animate-spin shrink-0 text-current" />}
      {children}
    </ButtonPrimitive>
  )
}

export { Button, buttonVariants }
