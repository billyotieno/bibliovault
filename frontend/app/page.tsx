export default function Home() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="text-center">
        <h1 className="text-6xl font-bold text-gray-900 mb-4">
          BiblioVault
        </h1>
        <p className="text-2xl text-gray-600 mb-8">
          Your Personal Library Vault
        </p>
        <p className="text-lg text-gray-500 mb-12">
          Secure, Organized, Accessible
        </p>
        <div className="space-x-4">
          <button className="px-6 py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition">
            Get Started
          </button>
          <button className="px-6 py-3 bg-white text-indigo-600 border border-indigo-600 rounded-lg hover:bg-indigo-50 transition">
            Learn More
          </button>
        </div>
      </div>
    </div>
  );
}
