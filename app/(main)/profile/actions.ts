'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

export async function updateDisplayName(formData: FormData) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    return { error: 'Bạn chưa đăng nhập' }
  }

  const displayName = formData.get('displayName')?.toString().trim()

  if (!displayName || displayName.length < 2) {
    return { error: 'Tên hiển thị phải có ít nhất 2 ký tự' }
  }

  if (displayName.length > 50) {
    return { error: 'Tên hiển thị không được vượt quá 50 ký tự' }
  }

  const { error } = await supabase
    .from('profiles')
    .update({ 
      display_name: displayName,
      updated_at: new Date().toISOString()
    })
    .eq('id', user.id)

  if (error) {
    return { error: error.message || 'Lỗi khi cập nhật tên hiển thị' }
  }

  revalidatePath('/', 'layout')
  revalidatePath('/profile')

  return { success: true, displayName }
}
