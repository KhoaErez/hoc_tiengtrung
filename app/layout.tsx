import type { Metadata } from "next";
import { Lora, Noto_Sans_SC, Be_Vietnam_Pro } from "next/font/google";
import "./globals.css";
import { Toaster } from 'sonner';
import { GlobalLoader } from '@/components/global-loader';
import { AudioLifecycleManager } from '@/components/audio/audio-lifecycle-manager';
import { FeedbackWidget } from '@/components/feedback/feedback-widget';
import { PresenceProvider } from '@/components/presence/presence-context';
import { Suspense } from 'react';

const beVietnamPro = Be_Vietnam_Pro({
  variable: "--font-sans",
  subsets: ["vietnamese", "latin"],
  weight: ["400", "500", "600", "700"],
  display: "swap",
});

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
      className={`${beVietnamPro.variable} ${lora.variable} ${notoSansSC.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col font-sans text-body bg-background">
        <Suspense fallback={null}>
          <GlobalLoader />
          <AudioLifecycleManager />
          <FeedbackWidget />
        </Suspense>
        <PresenceProvider>
          {children}
        </PresenceProvider>
        <Toaster richColors position="top-center" />
      </body>
    </html>
  );
}
