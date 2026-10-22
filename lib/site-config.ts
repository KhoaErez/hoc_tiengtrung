/**
 * SITE CONFIGURATION & INTELLECTUAL PROPERTY NOTICE
 * Project: Chinese Notebook
 * Developer: Trần Doãn Khoa
 * Copyright: © 2026 Chinese Notebook. All rights reserved.
 */

export const SITE_CONFIG = {
  name: 'Chinese Notebook',
  shortName: 'Chinese Notebook',
  developer: 'Trần Doãn Khoa',
  authorUrl: '/about',
  copyrightYear: 2026,
  tagline: 'Nền tảng học Hán ngữ hiện đại & Luyện thi HSK',
  purpose: 'Nền tảng hỗ trợ học tiếng Trung, luyện thi HSK, học từ vựng, ngữ pháp và luyện tập tương tác.',
  copyrightNotice: '© 2026 Chinese Notebook. All rights reserved.',
  creditText: 'Thiết kế & Phát triển bởi Trần Doãn Khoa.',
  version: '1.0.0',
  links: {
    about: '/about',
    hsk: '/topics',
    typing: '/typing',
    review: '/review',
    grammar: '/grammar',
    feedback: '/feedback',
  },
} as const

export type SiteConfig = typeof SITE_CONFIG
