'use client'

import React, { createContext, useContext, useState, useEffect, useCallback, useRef } from 'react'
import { useRouter, usePathname } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import type { User } from '@supabase/supabase-js'
import { toast } from 'sonner'

export type AuthModalView = 'none' | 'login-required' | 'login-form' | 'register-form'

export interface AuthModalOptions {
  title?: string
  description?: string
  actionName?: string
  redirectUrl?: string
  onSuccess?: () => void | Promise<void>
}

interface AuthModalContextValue {
  isOpen: boolean
  view: AuthModalView
  options: AuthModalOptions
  user: User | null
  isLoggedIn: boolean
  openLoginRequired: (options?: AuthModalOptions) => void
  openLoginForm: (options?: AuthModalOptions) => void
  openRegisterForm: (options?: AuthModalOptions) => void
  switchView: (view: AuthModalView) => void
  closeModal: () => void
  requireAuth: (action: () => void | Promise<void>, options?: AuthModalOptions) => boolean
  setUser: React.Dispatch<React.SetStateAction<User | null>>
}

const AuthModalContext = createContext<AuthModalContextValue | undefined>(undefined)

export function AuthModalProvider({
  children,
  initialUser = null,
}: {
  children: React.ReactNode
  initialUser?: User | null
}) {
  const [user, setUser] = useState<User | null>(initialUser)
  const [view, setView] = useState<AuthModalView>('none')
  const [options, setOptions] = useState<AuthModalOptions>({})
  const router = useRouter()
  const pathname = usePathname()

  // Track pending success callback via ref to prevent stale closures
  const pendingCallbackRef = useRef<(() => void | Promise<void>) | null>(null)

  const isOpen = view !== 'none'
  const isLoggedIn = Boolean(user)

  // Listen to Supabase auth state changes
  useEffect(() => {
    const supabase = createClient()

    // Sync initial session if not supplied via SSR
    supabase.auth.getUser().then(({ data }) => {
      if (data?.user) {
        setUser(data.user)
      }
    })

    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      const newUser = session?.user || null
      setUser(newUser)

      if (event === 'SIGNED_IN' && newUser) {
        // Trigger server components refresh
        router.refresh()

        // Execute pending callback if user signed in during a protected flow
        if (pendingCallbackRef.current) {
          const callback = pendingCallbackRef.current
          pendingCallbackRef.current = null
          try {
            await callback()
          } catch (e) {
            console.error('Error executing post-login callback:', e)
          }
        }

        // Close any active modal
        setView('none')
        setOptions({})
      } else if (event === 'SIGNED_OUT') {
        setUser(null)
        router.refresh()
      }
    })

    return () => {
      subscription.unsubscribe()
    }
  }, [router])

  const openLoginRequired = useCallback((opts: AuthModalOptions = {}) => {
    if (opts.onSuccess) {
      pendingCallbackRef.current = opts.onSuccess
    }
    setOptions({
      redirectUrl: opts.redirectUrl || pathname || '/',
      ...opts,
    })
    setView('login-required')
  }, [pathname])

  const openLoginForm = useCallback((opts: AuthModalOptions = {}) => {
    if (opts.onSuccess) {
      pendingCallbackRef.current = opts.onSuccess
    }
    setOptions({
      redirectUrl: opts.redirectUrl || pathname || '/',
      ...opts,
    })
    setView('login-form')
  }, [pathname])

  const openRegisterForm = useCallback((opts: AuthModalOptions = {}) => {
    if (opts.onSuccess) {
      pendingCallbackRef.current = opts.onSuccess
    }
    setOptions({
      redirectUrl: opts.redirectUrl || pathname || '/',
      ...opts,
    })
    setView('register-form')
  }, [pathname])

  const switchView = useCallback((newView: AuthModalView) => {
    setView(newView)
  }, [])

  const closeModal = useCallback(() => {
    setView('none')
    setOptions({})
    pendingCallbackRef.current = null
  }, [])

  const requireAuth = useCallback(
    (action: () => void | Promise<void>, opts: AuthModalOptions = {}): boolean => {
      if (user) {
        action()
        return true
      }
      openLoginRequired({
        ...opts,
        onSuccess: action,
      })
      return false
    },
    [user, openLoginRequired]
  )

  return (
    <AuthModalContext.Provider
      value={{
        isOpen,
        view,
        options,
        user,
        isLoggedIn,
        openLoginRequired,
        openLoginForm,
        openRegisterForm,
        switchView,
        closeModal,
        requireAuth,
        setUser,
      }}
    >
      {children}
    </AuthModalContext.Provider>
  )
}

export function useAuthModal() {
  const context = useContext(AuthModalContext)
  if (!context) {
    throw new Error('useAuthModal must be used within an AuthModalProvider')
  }
  return context
}
