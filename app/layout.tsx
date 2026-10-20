import type { Metadata } from "next";
import { Lora, Noto_Sans_SC } from "next/font/google";
import "./globals.css";
import { Toaster } from 'sonner';
import { GlobalLoader } from '@/components/global-loader';
import { AudioLifecycleManager } from '@/components/audio/audio-lifecycle-manager';
import { Suspense } from 'react';

const lora = Lora({
  variable: "--font-lora",
  subsets: ["vietnamese", "latin"],
  weight: ["400", "500", "600", "700"],
  display: "swap",
});

const notoSansSC = Noto_Sans_SC({
  variable: "--font-noto-sans-sc",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
  display: "swap",
  preload: false,
});

export const metadata: Metadata = {
  title: "Chinese Notebook AI",
  description: "AI-powered Chinese Learning Notebook",
  icons: {
    icon: "/icon.svg?v=1",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="vi"
      className={`${lora.variable} ${notoSansSC.variable} h-full antialiased`}
    >
      <head>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link
          href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;600;700&display=swap"
          rel="stylesheet"
        />
      </head>
      <body className="min-h-full flex flex-col font-serif">
        <Suspense fallback={null}>
          <GlobalLoader />
          <AudioLifecycleManager />
        </Suspense>
        {children}
        <Toaster richColors position="top-center" />
      </body>
    </html>
  );
}
