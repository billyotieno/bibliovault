# BiblioVault

**Your Personal Library Vault - Secure, Organized, Accessible**

BiblioVault is a comprehensive web-based home library management system designed to organize your book collection, track reading progress, and manage book borrowing.

## Features

### Core Features
- **Book Management**: Add, edit, and organize your book collection
- **Reading Tracking**: Track your reading progress, history, and goals
- **Borrowing Management**: Keep track of books you've lent to friends and family
- **Search & Discovery**: Advanced search and filtering capabilities
- **Statistics & Reports**: Visual insights into your reading habits

### Advanced Features (Coming Soon)
- Barcode scanning for ISBN lookup
- External API integration (Google Books, Open Library)
- Data export/import
- Reading recommendations
- Multi-user support

## Technology Stack

### Frontend
- **React 19** with **Next.js 15**
- **TypeScript** for type safety
- **Tailwind CSS** for styling
- **Zustand** for state management
- **React Query** for data fetching

### Backend
- **Node.js 20+** with **Express.js**
- **TypeScript**
- **PostgreSQL 16** database
- **Prisma ORM** for database management
- **JWT** for authentication

## Getting Started

### Prerequisites
- Node.js 20+
- PostgreSQL 16
- npm or yarn

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/bibliovault.git
cd bibliovault
```

2. Set up the backend
```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your database credentials
npx prisma migrate dev
npx prisma generate
npm run dev
```

3. Set up the frontend
```bash
cd frontend
npm install
npm run dev
```

4. Access the application
- Backend API: http://localhost:3000
- Frontend: http://localhost:3001
- Prisma Studio: http://localhost:5555 (run `npx prisma studio`)

## Development

### Backend Development
```bash
cd backend
npm run dev          # Start development server
npm run build        # Build for production
npm run prisma:studio # Open Prisma Studio
```

### Frontend Development
```bash
cd frontend
npm run dev          # Start development server
npm run build        # Build for production
npm run lint         # Lint code
```

## Project Structure

```
bibliovault/
├── backend/
│   ├── src/
│   │   ├── controllers/
│   │   ├── routes/
│   │   ├── middleware/
│   │   ├── utils/
│   │   ├── types/
│   │   └── index.ts
│   ├── prisma/
│   │   └── schema.prisma
│   ├── package.json
│   └── tsconfig.json
├── frontend/
│   ├── src/
│   │   ├── app/
│   │   ├── components/
│   │   ├── lib/
│   │   └── styles/
│   ├── package.json
│   └── next.config.js
└── README.md
```

## Database Schema

The application uses PostgreSQL with the following main tables:
- `users` - User accounts and authentication
- `books` - Book information and metadata
- `authors` - Author information
- `genres` - Book genres and categories
- `tags` - Custom tags for books
- `reading_sessions` - Reading progress tracking
- `borrowers` - People who borrow books
- `borrowing_transactions` - Lending history
- `reading_goals` - Reading targets and goals

See the [Development Research Document](./BiblioVault-Development-Research.md) for complete database schema and architecture details.

## Contributing

This is a personal project, but suggestions and feedback are welcome!

## License

MIT License

## Author

Built with ❤️ for book lovers

---

For detailed development documentation, see [BiblioVault-Development-Research.md](./BiblioVault-Development-Research.md)
