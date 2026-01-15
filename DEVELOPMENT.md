# BiblioVault Development Guide

## 🚀 Quick Start

### Current Status: READY FOR DEVELOPMENT ✅

Both frontend and backend servers are currently running!

- **Frontend**: http://localhost:3001
- **Backend API**: http://localhost:3000
- **API Health Check**: http://localhost:3000/api/health
- **Database**: PostgreSQL (bibliovault)

---

## 📋 Development Commands

### Backend (Terminal 1)
```bash
cd backend
npm run dev              # Start development server
npm run build            # Build for production
npm run start            # Start production server
npm test                 # Run tests
npx prisma studio        # Open Prisma Studio (database GUI)
npx prisma migrate dev   # Create new migration
npx prisma generate      # Generate Prisma Client
```

### Frontend (Terminal 2)
```bash
cd frontend
npm run dev              # Start development server
npm run build            # Build for production
npm run start            # Start production server
npm run lint             # Lint code
```

---

## 🗄️ Database Management

### PostgreSQL Commands
```bash
# Start PostgreSQL
pg_ctl -D /opt/homebrew/var/postgresql@14 start

# Stop PostgreSQL
pg_ctl -D /opt/homebrew/var/postgresql@14 stop

# Access database
psql bibliovault

# List databases
psql -l
```

### Prisma Commands
```bash
cd backend

# Open Prisma Studio (Visual Database Manager)
npx prisma studio
# Opens at http://localhost:5555

# Create a new migration
npx prisma migrate dev --name your_migration_name

# Reset database (WARNING: Deletes all data)
npx prisma migrate reset

# View current database schema
npx prisma db pull
```

---

## 📁 Project Structure

```
bibliovault/
├── backend/                    # Express.js backend
│   ├── src/
│   │   ├── controllers/       # Request handlers
│   │   ├── routes/            # API routes
│   │   ├── middleware/        # Custom middleware
│   │   ├── utils/             # Helper functions
│   │   ├── types/             # TypeScript types
│   │   └── index.ts           # Entry point
│   ├── prisma/
│   │   ├── schema.prisma      # Database schema
│   │   └── migrations/        # Database migrations
│   ├── .env                   # Environment variables (not in git)
│   └── package.json
│
└── frontend/                  # Next.js frontend
    ├── app/                   # Next.js 15 App Router
    │   ├── dashboard/         # Dashboard pages
    │   ├── books/             # Book management pages
    │   ├── reading/           # Reading tracking pages
    │   ├── borrowing/         # Borrowing management pages
    │   ├── layout.tsx         # Root layout
    │   ├── page.tsx           # Landing page
    │   └── globals.css        # Global styles
    ├── components/            # Reusable components
    ├── lib/                   # Utilities and helpers
    │   └── api.ts             # API client
    ├── .env.local             # Environment variables (not in git)
    └── package.json
```

---

## 🔧 Environment Variables

### Backend (.env)
```env
NODE_ENV=development
PORT=3000
FRONTEND_URL=http://localhost:3001
DATABASE_URL=postgresql://botieno@localhost:5432/bibliovault
JWT_SECRET=bibliovault-dev-secret-key-change-in-production-2026
JWT_EXPIRES_IN=7d
GOOGLE_BOOKS_API_KEY=your-api-key-here
MAX_FILE_SIZE=5242880
UPLOAD_PATH=./uploads/covers
```

### Frontend (.env.local)
```env
NEXT_PUBLIC_API_URL=http://localhost:3000/api
```

---

## 📊 Database Schema

The database includes the following tables:
- **users** - User accounts and authentication
- **books** - Book information and metadata
- **authors** - Author information
- **book_authors** - Many-to-many relationship
- **genres** - Book genres and categories
- **book_genres** - Many-to-many relationship
- **tags** - Custom tags for books
- **book_tags** - Many-to-many relationship
- **reading_sessions** - Reading progress tracking
- **borrowers** - People who borrow books
- **borrowing_transactions** - Lending history
- **reading_goals** - Reading targets and goals

---

## 🛠️ Troubleshooting

### Backend won't start
```bash
# Check if port 3000 is in use
lsof -ti:3000

# Kill process if needed
kill -9 $(lsof -ti:3000)

# Restart backend
cd backend && npm run dev
```

### Frontend won't start
```bash
# Check if port 3001 is in use
lsof -ti:3001

# Kill process if needed
kill -9 $(lsof -ti:3001)

# Restart frontend
cd frontend && npm run dev
```

### Database connection issues
```bash
# Check if PostgreSQL is running
psql -l

# Start PostgreSQL if not running
pg_ctl -D /opt/homebrew/var/postgresql@14 start

# Test database connection
psql bibliovault
```

### Prisma issues
```bash
cd backend

# Regenerate Prisma Client
npx prisma generate

# Reset migrations (WARNING: Deletes all data)
npx prisma migrate reset

# Apply migrations
npx prisma migrate deploy
```

---

## 🎯 Next Development Steps

### Phase 1: Authentication (Week 1-2)
- [ ] Implement user registration endpoint
- [ ] Implement user login endpoint
- [ ] Create JWT authentication middleware
- [ ] Build login/register UI
- [ ] Implement protected routes

### Phase 2: Book Management (Week 2-3)
- [ ] Create CRUD endpoints for books
- [ ] Create CRUD endpoints for authors
- [ ] Build book listing UI
- [ ] Build add/edit book forms
- [ ] Implement image upload for covers
- [ ] Add search functionality

### Phase 3: Reading Tracking (Week 4)
- [ ] Create reading sessions endpoints
- [ ] Build "Currently Reading" UI
- [ ] Implement reading progress tracking
- [ ] Create reading statistics dashboard
- [ ] Add rating and review functionality

### Phase 4: Borrowing System (Week 5)
- [ ] Create borrowing endpoints
- [ ] Build borrower management UI
- [ ] Implement book lending workflow
- [ ] Create overdue tracking
- [ ] Add borrowing history

### Phase 5: Polish & Deploy (Week 6)
- [ ] Add dark mode
- [ ] Optimize performance
- [ ] Write tests
- [ ] Deploy to cloud VM

---

## 📚 Useful Resources

- **Prisma Docs**: https://www.prisma.io/docs
- **Next.js Docs**: https://nextjs.org/docs
- **Express.js Docs**: https://expressjs.com/
- **PostgreSQL Docs**: https://www.postgresql.org/docs/
- **Tailwind CSS**: https://tailwindcss.com/docs

---

## 🔗 Repository

GitHub: https://github.com/billyotieno/bibliovault

---

**Happy Coding! 📚**
