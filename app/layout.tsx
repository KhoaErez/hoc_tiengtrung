import type { Metadata } from "next";
import { Lora, Noto_Serif_SC } from "next/font/google";
import "./globals.css";
import { Toaster } from 'sonner';
import { GlobalLoader } from '@/components/global-loader';

const lora = Lora({
  variable: "--font-lora",
  subsets: ["vietnamese", "latin"],
  weight: ["400", "500", "600", "700"],
  display: "swap",
});

const notoSerifSC = Noto_Serif_SC({
  variable: "--font-noto-serif-sc",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
  display: "swap",
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
      className={`${lora.variable} ${notoSerifSC.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col font-serif">
        <GlobalLoader />
        {children}
        <Toaster richColors position="top-center" />
      </body>
    </html>
  );
}
