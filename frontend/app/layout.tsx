import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "BiblioVault - Your Personal Library Vault",
  description: "Organize your book collection, track reading progress, and manage book borrowing",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="antialiased">
        {children}
      </body>
    </html>
  );
}
