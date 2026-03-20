import Link from 'next/link';

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col bg-gradient-to-br from-blue-50 to-indigo-100">
      {/* Navigation */}
      <nav className="bg-white/80 backdrop-blur-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center">
              <span className="text-2xl font-bold text-indigo-600">BiblioVault</span>
            </div>
            <div className="flex items-center space-x-4">
              <Link
                href="/login"
                className="px-4 py-2 text-sm font-medium text-gray-700 hover:text-indigo-600 transition"
              >
                Sign In
              </Link>
              <Link
                href="/register"
                className="px-4 py-2 text-sm font-medium text-white bg-indigo-600 rounded-lg hover:bg-indigo-700 transition"
              >
                Get Started
              </Link>
            </div>
          </div>
        </div>
      </nav>

      {/* Hero */}
      <div className="flex-1 flex items-center justify-center px-4">
        <div className="text-center max-w-3xl">
          <h1 className="text-5xl md:text-6xl font-bold text-gray-900 mb-6">
            Your Personal Library Vault
          </h1>
          <p className="text-xl md:text-2xl text-gray-600 mb-4">
            Organize your book collection, track reading progress, and manage book borrowing
          </p>
          <p className="text-lg text-gray-500 mb-12">
            Secure, Organized, Accessible
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link
              href="/register"
              className="px-8 py-4 bg-indigo-600 text-white text-lg font-medium rounded-lg hover:bg-indigo-700 transition text-center"
            >
              Create Free Account
            </Link>
            <Link
              href="/login"
              className="px-8 py-4 bg-white text-indigo-600 text-lg font-medium border-2 border-indigo-600 rounded-lg hover:bg-indigo-50 transition text-center"
            >
              Sign In
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
