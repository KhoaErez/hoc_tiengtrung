import React from 'react'
import {
  Home,
  BookOpen,
  BrainCircuit,
  GraduationCap,
  MessagesSquare,
  MessageSquareText,
  Factory,
  BookMarked,
  Component,
  Keyboard,
  PenTool,
  Wrench,
  ShieldCheck,
  MessageSquare,
} from 'lucide-react'
import { HSK_AUDIT_DATA, type HskLevelAuditData } from '@/data/hsk-curriculum'

// ============================================================================
// ĐỊNH NGHĨA TYPES CHO NAVIGATION
// ============================================================================

export interface NavItemConfig {
  label: string
  href: string
  topic?: string
  icon?: React.ComponentType<{ className?: string }>
  badge?: string
  isProtected?: boolean
  isComingSoon?: boolean
  data?: HskLevelAuditData
}

export interface NavGroupConfig {
  id: 'hsk' | 'applied' | 'foundation' | 'tools'
  title: string
  icon: React.ComponentType<{ className?: string }>
  description?: string
  defaultOpen?: boolean
}

// ============================================================================
// 1. NHÓM TỔNG QUAN (CORE LEARNING) - LUÔN HIỂN THỊ ĐẦU TIÊN
// ============================================================================
export const CORE_LEARNING_ITEMS: NavItemConfig[] = [
  {
    label: 'Trang chủ',
    href: '/',
    icon: Home,
    isProtected: false,
  },
  {
    label: 'Chủ đề sưu tầm',
    href: '/lessons',
    icon: BookOpen,
    isProtected: false,
  },
  {
    label: 'Ôn tập thẻ nhớ',
    href: '/review',
    icon: BrainCircuit,
    isProtected: true,
  },
]

// ============================================================================
// 2. NHÓM 1: LỘ TRÌNH HSK 3.0 (HSK 1 - 9)
// ============================================================================
export const HSK_GROUP_CONFIG: NavGroupConfig = {
  id: 'hsk',
  title: 'Lộ trình HSK 3.0',
  icon: GraduationCap,
  description: 'Khung 3 giai đoạn 9 cấp độ GF 0025-2021',
}

export interface HskStageConfig {
  stage: string
  stageZh: string
  levels: {
    label: string
    level: string
    href: string
    topic: string
    data: HskLevelAuditData
    isComingSoon?: boolean
  }[]
}

export const HSK_STAGES_CONFIG: HskStageConfig[] = [
  {
    stage: 'Sơ cấp',
    stageZh: '初等',
    levels: [
      {
        label: 'HSK 1',
        level: '1',
        href: '/topics?q=HSK%201',
        topic: 'HSK 1',
        data: HSK_AUDIT_DATA['HSK 1'],
      },
      {
        label: 'HSK 2',
        level: '2',
        href: '/topics?q=HSK%202',
        topic: 'HSK 2',
        data: HSK_AUDIT_DATA['HSK 2'],
      },
      {
        label: 'HSK 3',
        level: '3',
        href: '/topics?q=HSK%203',
        topic: 'HSK 3',
        data: HSK_AUDIT_DATA['HSK 3'],
      },
    ],
  },
  {
    stage: 'Trung cấp',
    stageZh: '中等',
    levels: [
      {
        label: 'HSK 4',
        level: '4',
        href: '/topics?q=HSK%204',
        topic: 'HSK 4',
        data: HSK_AUDIT_DATA['HSK 4'],
      },
      {
        label: 'HSK 5',
        level: '5',
        href: '/topics?q=HSK%205',
        topic: 'HSK 5',
        data: HSK_AUDIT_DATA['HSK 5'],
      },
      {
        label: 'HSK 6',
        level: '6',
        href: '/topics?q=HSK%206',
        topic: 'HSK 6',
        data: HSK_AUDIT_DATA['HSK 6'],
      },
    ],
  },
  {
    stage: 'Cao cấp',
    stageZh: '高等',
    levels: [
      {
        label: 'HSK 7–9',
        level: '7',
        href: '/topics?q=HSK%207-9',
        topic: 'HSK 7-9',
        data: HSK_AUDIT_DATA['HSK 7-9'],
        isComingSoon: true,
      },
    ],
  },
]

// ============================================================================
// 3. NHÓM 2: GIAO TIẾP & ỨNG DỤNG
// ============================================================================
export const APPLIED_GROUP_CONFIG: NavGroupConfig = {
  id: 'applied',
  title: 'Giao tiếp & Ứng dụng',
  icon: MessagesSquare,
  description: 'Thực hành hội thoại sinh hoạt & môi trường sản xuất',
}

export const APPLIED_ITEMS_CONFIG: NavItemConfig[] = [
  {
    label: 'Giao tiếp thực tế',
    href: '/topics?q=Giao%20ti%E1%BA%BFp',
    topic: 'Giao tiếp',
    icon: MessageSquareText,
    data: HSK_AUDIT_DATA['Giao tiếp'],
    isProtected: false,
  },
  {
    label: 'Tiếng Trung công xưởng',
    href: '/topics?q=C%C3%B4ng%20x%C6%B0%E1%BB%9Fng',
    topic: 'Công xưởng',
    icon: Factory,
    data: HSK_AUDIT_DATA['Công xưởng'],
    isProtected: false,
  },
]

// ============================================================================
// 4. NHÓM 3: NỀN TẢNG TIẾNG TRUNG
// ============================================================================
export const FOUNDATION_GROUP_CONFIG: NavGroupConfig = {
  id: 'foundation',
  title: 'Nền tảng tiếng Trung',
  icon: BookOpen,
  description: 'Ngữ pháp chuẩn GF 0025-2021 & 214 Bộ thủ Khang Hy',
}

export const FOUNDATION_ITEMS_CONFIG: NavItemConfig[] = [
  {
    label: 'Ngữ pháp HSK',
    href: '/grammar',
    icon: BookMarked,
    badge: 'HSK 1–6',
    isProtected: false,
  },
  {
    label: '214 Bộ thủ Khang Hy',
    href: '/radicals',
    icon: Component,
    badge: '214 bộ',
    isProtected: false,
  },
]

// ============================================================================
// 5. NHÓM 4: CÔNG CỤ & KỸ NĂNG
// ============================================================================
export const TOOLS_GROUP_CONFIG: NavGroupConfig = {
  id: 'tools',
  title: 'Công cụ & Kỹ năng',
  icon: Wrench,
  description: 'Luyện gõ chữ Hán & bài tập tương tác',
}

export const TOOLS_ITEMS_CONFIG: NavItemConfig[] = [
  {
    label: 'Luyện đánh máy',
    href: '/typing',
    icon: Keyboard,
    isProtected: false,
  },
  {
    label: 'Luyện Viết AI',
    href: '/write',
    icon: PenTool,
    badge: 'Sắp ra mắt',
    isProtected: false,
    isComingSoon: true,
  },
]

// ============================================================================
// 6. NHÓM QUẢN TRỊ VIÊN (ADMIN SECTION)
// ============================================================================
export const ADMIN_ITEMS_CONFIG: NavItemConfig[] = [
  {
    label: 'Phân quyền tài khoản',
    href: '/admin',
    icon: ShieldCheck,
    isProtected: true,
  },
  {
    label: 'Góp ý & Báo lỗi',
    href: '/admin/feedback',
    icon: MessageSquare,
    isProtected: true,
  },
]

// ============================================================================
// HELPER: KIỂM TRA TRẠNG THÁI ACTIVE CHUẨN XÁC
// ============================================================================
export function isNavigationItemActive(
  pathname: string,
  searchParamQ: string | null | undefined,
  item: { href?: string; topic?: string }
): boolean {
  // 1. Kiểm tra theo Topic (HSK 1–9, Giao tiếp, Công xưởng)
  if (item.topic) {
    if (pathname === '/topics') {
      if (item.topic === 'HSK 1' && !searchParamQ) return true
      return searchParamQ === item.topic
    }
    if (item.topic.startsWith('HSK ')) {
      const level = item.topic.replace('HSK ', '').trim()
      if (pathname === `/hsk/${level}` || pathname.startsWith(`/hsk/${level}/`)) {
        return true
      }
    }
    return false
  }

  // 2. Kiểm tra theo Href
  if (!item.href) return false

  // Trang chủ
  if (item.href === '/') {
    return pathname === '/'
  }

  // Khớp chính xác hoặc là route con
  if (pathname === item.href || pathname.startsWith(item.href + '/')) {
    return true
  }

  return false
}

// ============================================================================
// HELPER: TỰ ĐỘNG XÁC ĐỊNH NHÓM NÀO CÓ MỤC ACTIVE ĐỂ AUTO-EXPAND
// ============================================================================
export function getActiveGroupId(
  pathname: string,
  searchParamQ: string | null | undefined
): 'hsk' | 'applied' | 'foundation' | 'tools' | null {
  // Nhóm HSK: /hsk/* hoặc /topics?q=HSK... (hoặc /topics mặc định HSK 1)
  if (
    pathname.startsWith('/hsk') ||
    (pathname === '/topics' && (!searchParamQ || searchParamQ.startsWith('HSK')))
  ) {
    return 'hsk'
  }

  // Nhóm Giao tiếp & Ứng dụng: /topics?q=Giao tiếp hoặc /topics?q=Công xưởng
  if (
    pathname === '/topics' &&
    (searchParamQ === 'Giao tiếp' || searchParamQ === 'Công xưởng')
  ) {
    return 'applied'
  }

  // Nhóm Nền tảng tiếng Trung: /grammar hoặc /radicals
  if (pathname.startsWith('/grammar') || pathname.startsWith('/radicals')) {
    return 'foundation'
  }

  // Nhóm Công cụ & Kỹ năng: /typing hoặc /write
  if (pathname.startsWith('/typing') || pathname.startsWith('/write')) {
    return 'tools'
  }

  return null
}
