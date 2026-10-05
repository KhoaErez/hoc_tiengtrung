'use server'

import { revalidatePath } from 'next/cache'
import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'

export async function login(formData: FormData) {
  const supabase = await createClient()

  const data = {
    email: formData.get('email') as string,
    password: formData.get('password') as string,
  }

  const { error } = await supabase.auth.signInWithPassword(data)

  if (error) {
    let errorMsg = error.message
    if (errorMsg.includes('Invalid login credentials')) errorMsg = 'Email hoặc mật khẩu không chính xác.'
    else if (errorMsg.includes('Email not confirmed')) errorMsg = 'Email chưa được xác nhận.'
    
    redirect('/login?error=' + encodeURIComponent(errorMsg))
  }

  revalidatePath('/', 'layout')
  redirect('/dashboard')
}

export async function signup(formData: FormData) {
  const supabase = await createClient()

  const email = formData.get('email') as string
  const password = formData.get('password') as string
  const fullName = formData.get('full_name') as string

  const { error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      data: {
        full_name: fullName || email.split('@')[0],
      }
    }
  })

  if (error) {
    let errorMsg = error.message
    if (errorMsg.includes('User already registered')) errorMsg = 'Email này đã được đăng ký.'
    else if (errorMsg.includes('Password should be at least')) errorMsg = 'Mật khẩu quá ngắn, vui lòng nhập ít nhất 6 ký tự.'
    
    redirect('/register?error=' + encodeURIComponent(errorMsg))
  }

  revalidatePath('/', 'layout')
  redirect('/dashboard')
}

export async function logout() {
  const supabase = await createClient()
  await supabase.auth.signOut()
  revalidatePath('/', 'layout')
  redirect('/login')
}
