'use client'

import * as React from 'react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import { useAuthModal } from '@/components/auth/auth-modal-context'

export function ProtectedLink({
  href,
  children,
  className,
  isLoggedIn,
  actionName,
}: {
  href: string
  children: React.ReactNode
  className?: string
  isLoggedIn?: boolean
  actionName?: string
}) {
  const router = useRouter()
  const { isLoggedIn: contextLoggedIn, openLoginRequired } = useAuthModal()
  const authenticated = typeof isLoggedIn === 'boolean' ? isLoggedIn : contextLoggedIn

  const handleClick = (e: React.MouseEvent) => {
    if (!authenticated) {
      e.preventDefault()
      openLoginRequired({
        actionName,
        redirectUrl: href,
        onSuccess: () => {
          router.push(href)
        },
      })
    }
  }

  return (
    <Link href={href} className={className} onClick={handleClick}>
      {children}
    </Link>
  )
}
