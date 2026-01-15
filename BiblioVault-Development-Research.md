# BiblioVault: Home Library Management System
## Complete Development Research & Implementation Guide

---

## 🎯 Project Overview

**BiblioVault** is a comprehensive web-based home library management system designed to organize your book collection, track reading progress, and manage book borrowing. The system will be piloted on your MacBook before deployment to a cloud VM.

### System Name: **BiblioVault**
*"Your Personal Library Vault - Secure, Organized, Accessible"*

---

## 📋 Table of Contents

1. [Core Features & Components](#core-features--components)
2. [Technology Stack Selection](#technology-stack-selection)
3. [Database Design & Architecture](#database-design--architecture)
4. [System Architecture](#system-architecture)
5. [Development Phases](#development-phases)
6. [Security Implementation](#security-implementation)
7. [MacBook Local Development Setup](#macbook-local-development-setup)
8. [Cloud VM Deployment Strategy](#cloud-vm-deployment-strategy)
9. [Testing Strategy](#testing-strategy)
10. [Maintenance & Scaling](#maintenance--scaling)

---

## 1. Core Features & Components

### 1.1 Essential Features

#### Book Management Module
- **Add Books**: Manual entry with ISBN lookup integration
- **Book Details**: Title, author(s), publisher, publication date, genre, ISBN, cover image
- **Categorization**: Genres, tags, custom collections
- **Book Status**: Available, borrowed, currently reading, wishlist
- **Physical Location**: Shelf number, room location
- **Book Condition**: Tracking condition and acquisition date
- **Multiple Copies**: Support for multiple copies of the same book

#### Reading Tracking Module
- **Currently Reading**: Track books in progress with page numbers
- **Reading History**: Complete history of books read with dates
- **Reading Progress**: Percentage completion, pages read
- **Reading Goals**: Set and track yearly/monthly reading goals
- **Reading Statistics**: Books read per month/year, favorite genres, reading speed
- **Notes & Highlights**: Personal notes and favorite quotes from books
- **Ratings & Reviews**: Personal rating system and review notes

#### Borrowing Management Module
- **Lend Books**: Record who borrowed which book and when
- **Borrower Directory**: Maintain list of friends/family who borrow books
- **Due Dates**: Set return dates with reminders
- **Borrowing History**: Complete history of all lending transactions
- **Overdue Tracking**: Identify and track overdue books
- **Borrower Notes**: Add notes about borrowers or specific lending conditions

#### Search & Discovery
- **Advanced Search**: By title, author, ISBN, genre, status, location
- **Filters**: Multiple filter options (read/unread, available/borrowed, by genre)
- **Sorting**: By title, author, date added, rating, publication date
- **Smart Collections**: Auto-generated collections (recently added, top rated, unread)

#### User Interface Features
- **Dashboard**: Overview with statistics and quick actions
- **Book Cards/Grid View**: Visual representation with cover images
- **List View**: Detailed table view for power users
- **Dark Mode**: Eye-friendly reading interface
- **Responsive Design**: Works on desktop, tablet, and mobile devices

### 1.2 Advanced Features (Phase 2)

- **Barcode Scanning**: Use device camera to scan ISBN barcodes
- **External API Integration**: Fetch book data from Google Books, Open Library, or Goodreads API
- **Export/Import**: Backup and restore library data (CSV, JSON)
- **Recommendations**: Suggest books based on reading history
- **Reading Challenges**: Create and track reading challenges
- **Book Series Tracking**: Group books by series with order
- **Multi-user Support**: Family members with separate accounts
- **Wishlist & Shopping**: Track books to buy with price alerts
- **Digital Books Integration**: Track ebooks and audiobooks
- **Reports**: Generate detailed analytics and reports

---

## 2. Technology Stack Selection

Based on 2025 best practices and your MacBook development environment, here are the recommended technology stack options:

### 2.1 Recommended Stack: MERN (Modern & Popular)

**Frontend:**
- **React 19** with **Next.js 15**: Modern UI with server-side rendering
- **TypeScript**: Type safety and better development experience
- **Tailwind CSS**: Utility-first CSS framework for rapid styling
- **Zustand/React Query**: State management and data fetching
- **React Hook Form**: Form handling and validation

**Backend:**
- **Node.js 20+** with **Express.js**: Fast, scalable JavaScript backend
- **TypeScript**: Consistent type safety across stack

**Database:**
- **PostgreSQL 16**: Robust relational database for structured data
- **Prisma ORM**: Modern database toolkit with type safety

**Additional Tools:**
- **JWT**: Secure authentication
- **Multer**: File upload handling for book covers
- **Axios**: HTTP client
- **Bcrypt**: Password hashing

### 2.2 Alternative Stack: Python-based (Data-Friendly)

**Frontend:**
- Same as MERN stack (React/Next.js)

**Backend:**
- **Python 3.12** with **FastAPI**: Modern, fast Python web framework
- **SQLAlchemy**: SQL toolkit and ORM
- **Pydantic**: Data validation

**Database:**
- **PostgreSQL 16** or **SQLite** (for simplicity)

### 2.3 Alternative Stack: Full JavaScript with Laravel-like Experience

**Frontend:**
- **Vue.js 3** with **Nuxt 3**: Progressive framework
- **TypeScript**
- **Tailwind CSS**

**Backend:**
- **Node.js** with **NestJS**: Enterprise-grade Node framework
- **TypeORM**: TypeScript ORM

**Database:**
- **PostgreSQL 16**

### 2.4 Recommended Choice for BiblioVault

**Go with MERN Stack with TypeScript** because:
- Single language (JavaScript/TypeScript) across entire stack
- Huge community and resources
- Excellent for MacBook development
- Easy cloud deployment
- Rich ecosystem of libraries
- Great performance for this use case
- React skills are highly transferable

---

## 3. Database Design & Architecture

### 3.1 Database Schema

#### Core Tables

**1. Books Table**
```sql
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    isbn VARCHAR(13) UNIQUE,
    title VARCHAR(500) NOT NULL,
    subtitle VARCHAR(500),
    author_id INTEGER REFERENCES authors(author_id),
    publisher VARCHAR(200),
    publication_date DATE,
    edition VARCHAR(100),
    language VARCHAR(50),
    pages INTEGER,
    description TEXT,
    cover_image_url VARCHAR(500),
    genre_id INTEGER REFERENCES genres(genre_id),
    physical_location VARCHAR(200),
    purchase_date DATE,
    purchase_price DECIMAL(10,2),
    condition VARCHAR(50),
    status VARCHAR(50) DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**2. Authors Table**
```sql
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    full_name VARCHAR(400) NOT NULL,
    bio TEXT,
    birth_date DATE,
    nationality VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**3. Book_Authors Table (Many-to-Many)**
```sql
CREATE TABLE book_authors (
    book_id INTEGER REFERENCES books(book_id) ON DELETE CASCADE,
    author_id INTEGER REFERENCES authors(author_id) ON DELETE CASCADE,
    author_order INTEGER DEFAULT 1,
    PRIMARY KEY (book_id, author_id)
);
```

**4. Genres Table**
```sql
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    parent_genre_id INTEGER REFERENCES genres(genre_id)
);
```

**5. Book_Genres Table (Many-to-Many)**
```sql
CREATE TABLE book_genres (
    book_id INTEGER REFERENCES books(book_id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES genres(genre_id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, genre_id)
);
```

**6. Reading_Sessions Table**
```sql
CREATE TABLE reading_sessions (
    session_id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(book_id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE,
    start_page INTEGER,
    end_page INTEGER,
    current_page INTEGER,
    status VARCHAR(50) DEFAULT 'reading',
    rating DECIMAL(3,2) CHECK (rating >= 0 AND rating <= 5),
    review TEXT,
    notes TEXT,
    is_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**7. Borrowers Table**
```sql
CREATE TABLE borrowers (
    borrower_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**8. Borrowing_Transactions Table**
```sql
CREATE TABLE borrowing_transactions (
    transaction_id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(book_id),
    borrower_id INTEGER REFERENCES borrowers(borrower_id),
    borrowed_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(50) DEFAULT 'borrowed',
    notes TEXT,
    reminder_sent BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**9. Users Table (for authentication)**
```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role VARCHAR(50) DEFAULT 'user',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);
```

**10. Tags Table**
```sql
CREATE TABLE tags (
    tag_id SERIAL PRIMARY KEY,
    tag_name VARCHAR(100) UNIQUE NOT NULL,
    color VARCHAR(7),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**11. Book_Tags Table (Many-to-Many)**
```sql
CREATE TABLE book_tags (
    book_id INTEGER REFERENCES books(book_id) ON DELETE CASCADE,
    tag_id INTEGER REFERENCES tags(tag_id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, tag_id)
);
```

**12. Reading_Goals Table**
```sql
CREATE TABLE reading_goals (
    goal_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    year INTEGER NOT NULL,
    target_books INTEGER,
    target_pages INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 3.2 Entity Relationships

```
Users (1) -----> (Many) Reading_Sessions
Users (1) -----> (Many) Reading_Goals

Books (Many) <-----> (Many) Authors [through Book_Authors]
Books (Many) <-----> (Many) Genres [through Book_Genres]
Books (Many) <-----> (Many) Tags [through Book_Tags]
Books (1) -----> (Many) Reading_Sessions
Books (1) -----> (Many) Borrowing_Transactions

Borrowers (1) -----> (Many) Borrowing_Transactions
```

### 3.3 Indexes for Performance

```sql
-- Improve search performance
CREATE INDEX idx_books_title ON books(title);
CREATE INDEX idx_books_isbn ON books(isbn);
CREATE INDEX idx_books_status ON books(status);
CREATE INDEX idx_authors_name ON authors(full_name);
CREATE INDEX idx_borrowing_status ON borrowing_transactions(status);
CREATE INDEX idx_borrowing_dates ON borrowing_transactions(borrowed_date, due_date);
CREATE INDEX idx_reading_sessions_status ON reading_sessions(status);
```

---

## 4. System Architecture

### 4.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Frontend Layer (React)                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Dashboard   │  │  Book Mgmt   │  │  Reading     │      │
│  │  Component   │  │  Component   │  │  Component   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│  ┌──────────────┐  ┌──────────────┐                         │
│  │  Borrowing   │  │  Reports     │                         │
│  │  Component   │  │  Component   │                         │
│  └──────────────┘  └──────────────┘                         │
└─────────────────────────────────────────────────────────────┘
                            │
                     HTTP/HTTPS REST API
                            │
┌─────────────────────────────────────────────────────────────┐
│                    Backend Layer (Node.js/Express)           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │     Auth     │  │    Books     │  │   Reading    │      │
│  │  Controller  │  │  Controller  │  │  Controller  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Borrowing   │  │   Reports    │  │   External   │      │
│  │  Controller  │  │  Controller  │  │  APIs (Books)│      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                               │
│  ┌─────────────────────────────────────────────────┐        │
│  │           Middleware Layer                       │        │
│  │  • Authentication (JWT)                          │        │
│  │  • Validation                                    │        │
│  │  • Error Handling                                │        │
│  │  • Rate Limiting                                 │        │
│  └─────────────────────────────────────────────────┘        │
└─────────────────────────────────────────────────────────────┘
                            │
                       Database Layer
                            │
┌─────────────────────────────────────────────────────────────┐
│                    PostgreSQL Database                       │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │  Books   │  │ Authors  │  │ Reading  │  │Borrowing │   │
│  │  Tables  │  │  Tables  │  │  Tables  │  │  Tables  │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 4.2 API Endpoints Structure

**Authentication:**
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login
- `POST /api/auth/logout` - User logout
- `GET /api/auth/profile` - Get user profile
- `PUT /api/auth/profile` - Update user profile

**Books:**
- `GET /api/books` - List all books (with filters & pagination)
- `GET /api/books/:id` - Get single book details
- `POST /api/books` - Add new book
- `PUT /api/books/:id` - Update book
- `DELETE /api/books/:id` - Delete book
- `GET /api/books/search` - Advanced search
- `POST /api/books/isbn/:isbn` - Fetch book by ISBN from external API

**Authors:**
- `GET /api/authors` - List all authors
- `GET /api/authors/:id` - Get author details with books
- `POST /api/authors` - Add new author
- `PUT /api/authors/:id` - Update author
- `DELETE /api/authors/:id` - Delete author

**Reading Sessions:**
- `GET /api/reading` - Get all reading sessions
- `GET /api/reading/current` - Get currently reading books
- `POST /api/reading` - Start new reading session
- `PUT /api/reading/:id` - Update reading progress
- `DELETE /api/reading/:id` - Delete reading session
- `POST /api/reading/:id/complete` - Mark book as completed
- `GET /api/reading/history` - Get reading history
- `GET /api/reading/stats` - Get reading statistics

**Borrowing:**
- `GET /api/borrowing` - List all borrowing transactions
- `GET /api/borrowing/active` - Get active loans
- `GET /api/borrowing/overdue` - Get overdue books
- `POST /api/borrowing` - Record new borrowing
- `PUT /api/borrowing/:id/return` - Record book return
- `GET /api/borrowers` - List all borrowers
- `POST /api/borrowers` - Add new borrower
- `PUT /api/borrowers/:id` - Update borrower
- `DELETE /api/borrowers/:id` - Delete borrower

**Genres & Tags:**
- `GET /api/genres` - List all genres
- `POST /api/genres` - Add new genre
- `GET /api/tags` - List all tags
- `POST /api/tags` - Add new tag

**Reports:**
- `GET /api/reports/dashboard` - Dashboard summary
- `GET /api/reports/reading-stats` - Reading statistics
- `GET /api/reports/borrowing-stats` - Borrowing statistics
- `GET /api/reports/collection-stats` - Collection statistics

---

## 5. Development Phases

### Phase 1: Foundation (Weeks 1-3)

**Week 1: Setup & Infrastructure**
- Set up development environment on MacBook
- Initialize Git repository
- Create project structure (frontend & backend)
- Set up PostgreSQL database
- Configure Prisma ORM
- Create basic database schema
- Set up development servers

**Week 2: Backend Core**
- Implement authentication system (JWT)
- Create user registration/login
- Build Books CRUD API endpoints
- Build Authors CRUD API endpoints
- Implement basic validation
- Set up error handling middleware
- Create database seed scripts

**Week 3: Frontend Foundation**
- Set up Next.js project with TypeScript
- Configure Tailwind CSS
- Create authentication UI (login/register)
- Build main layout and navigation
- Create dashboard page
- Implement API client with Axios
- Set up state management (Zustand)

### Phase 2: Core Features (Weeks 4-6)

**Week 4: Book Management**
- Build book listing UI with pagination
- Create add/edit book forms
- Implement book search functionality
- Add book detail view
- Implement image upload for covers
- Add genre and tag management
- Build author management UI

**Week 5: Reading Tracking**
- Create reading sessions API
- Build "Currently Reading" UI
- Implement reading progress tracking
- Create reading history view
- Add rating and review functionality
- Build reading statistics dashboard
- Implement reading goals

**Week 6: Borrowing System**
- Build borrowing transactions API
- Create borrower management UI
- Implement book lending workflow
- Build active loans view
- Create overdue tracking
- Add borrowing history
- Implement reminder system

### Phase 3: Enhancement & Polish (Weeks 7-8)

**Week 7: Advanced Features**
- Integrate external book API (Google Books/Open Library)
- Add advanced search filters
- Implement data export/import
- Build reports and analytics
- Add dark mode
- Optimize performance
- Create mobile responsive views

**Week 8: Testing & Documentation**
- Write unit tests for backend
- Write integration tests
- Perform user acceptance testing
- Fix bugs and issues
- Write user documentation
- Create deployment documentation
- Prepare for production deployment

---

## 6. Security Implementation

### 6.1 Authentication & Authorization

**Password Security:**
```javascript
// Use bcrypt for password hashing
const bcrypt = require('bcrypt');
const saltRounds = 12;

// Hashing password
const hashPassword = async (password) => {
    return await bcrypt.hash(password, saltRounds);
};

// Verifying password
const verifyPassword = async (password, hash) => {
    return await bcrypt.compare(password, hash);
};
```

**JWT Implementation:**
```javascript
const jwt = require('jsonwebtoken');

// Generate JWT token
const generateToken = (userId) => {
    return jwt.sign(
        { userId, iat: Date.now() },
        process.env.JWT_SECRET,
        { expiresIn: '7d' }
    );
};

// Verify JWT token middleware
const authMiddleware = (req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];
    
    if (!token) {
        return res.status(401).json({ error: 'No token provided' });
    }
    
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.userId = decoded.userId;
        next();
    } catch (error) {
        return res.status(401).json({ error: 'Invalid token' });
    }
};
```

### 6.2 Data Validation

**Input Sanitization:**
```javascript
const { body, validationResult } = require('express-validator');

// Example: Book validation
const bookValidation = [
    body('title')
        .trim()
        .notEmpty()
        .withMessage('Title is required')
        .isLength({ max: 500 })
        .withMessage('Title too long'),
    body('isbn')
        .optional()
        .trim()
        .matches(/^(?:\d{10}|\d{13})$/)
        .withMessage('Invalid ISBN format'),
    body('pages')
        .optional()
        .isInt({ min: 1 })
        .withMessage('Pages must be a positive integer'),
];
```

### 6.3 Security Headers

```javascript
const helmet = require('helmet');
const cors = require('cors');

// Apply security headers
app.use(helmet());

// Configure CORS
app.use(cors({
    origin: process.env.FRONTEND_URL,
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
}));
```

### 6.4 Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');

// Apply rate limiting to API
const apiLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100, // limit each IP to 100 requests per windowMs
    message: 'Too many requests, please try again later.'
});

app.use('/api/', apiLimiter);

// Stricter rate limiting for auth endpoints
const authLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 5,
    message: 'Too many login attempts, please try again later.'
});

app.use('/api/auth/login', authLimiter);
```

### 6.5 Environment Variables

**Create `.env` file:**
```bash
# Server Configuration
NODE_ENV=development
PORT=3000
FRONTEND_URL=http://localhost:3001

# Database Configuration
DATABASE_URL=postgresql://username:password@localhost:5432/bibliovault

# Authentication
JWT_SECRET=your-super-secret-key-change-in-production
JWT_EXPIRES_IN=7d

# External APIs
GOOGLE_BOOKS_API_KEY=your-api-key-here

# File Upload
MAX_FILE_SIZE=5242880
UPLOAD_PATH=./uploads/covers
```

### 6.6 SQL Injection Prevention

Using Prisma ORM automatically prevents SQL injection:
```javascript
// Safe - Prisma parameterizes queries
const book = await prisma.book.findMany({
    where: {
        title: {
            contains: searchTerm,
            mode: 'insensitive'
        }
    }
});
```

### 6.7 XSS Protection

```javascript
// Sanitize user input
const sanitizeHtml = require('sanitize-html');

const sanitizeInput = (input) => {
    return sanitizeHtml(input, {
        allowedTags: [],
        allowedAttributes: {}
    });
};
```

---

## 7. MacBook Local Development Setup

### 7.1 Prerequisites Installation

**1. Install Homebrew (if not already installed):**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**2. Install Node.js (LTS version):**
```bash
brew install node@20
node --version  # Should show v20.x.x
npm --version   # Should show v10.x.x
```

**3. Install PostgreSQL:**
```bash
brew install postgresql@16
brew services start postgresql@16

# Create database
createdb bibliovault
```

**4. Install Git (if not already installed):**
```bash
brew install git
git --version
```

**5. Install VS Code or your preferred IDE:**
```bash
brew install --cask visual-studio-code
```

### 7.2 Project Setup

**1. Create project structure:**
```bash
mkdir bibliovault
cd bibliovault

# Initialize backend
mkdir backend
cd backend
npm init -y
npm install express prisma @prisma/client jsonwebtoken bcrypt dotenv cors helmet express-validator express-rate-limit multer

# Install dev dependencies
npm install --save-dev typescript @types/node @types/express @types/bcrypt @types/jsonwebtoken @types/cors nodemon ts-node

# Initialize Prisma
npx prisma init

# Initialize TypeScript
npx tsc --init

cd ..

# Initialize frontend
npx create-next-app@latest frontend --typescript --tailwind --app
cd frontend
npm install axios zustand react-hook-form zod @tanstack/react-query

cd ..
```

**2. Configure Backend:**

Create `backend/tsconfig.json`:
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}
```

Create `backend/package.json` scripts:
```json
{
  "scripts": {
    "dev": "nodemon --exec ts-node src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js",
    "prisma:generate": "prisma generate",
    "prisma:migrate": "prisma migrate dev",
    "prisma:studio": "prisma studio"
  }
}
```

**3. Create Backend Structure:**
```bash
cd backend
mkdir -p src/{controllers,routes,middleware,utils,types}
touch src/index.ts
```

**4. Basic Backend Setup (`backend/src/index.ts`):**
```typescript
import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:3001',
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', message: 'BiblioVault API is running' });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 BiblioVault backend running on http://localhost:${PORT}`);
});
```

**5. Set up Prisma Schema:**

Edit `backend/prisma/schema.prisma` with your database schema.

**6. Run migrations:**
```bash
cd backend
npx prisma migrate dev --name init
npx prisma generate
```

### 7.3 Development Workflow

**Terminal 1 - Backend:**
```bash
cd backend
npm run dev
# Server runs on http://localhost:3000
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm run dev
# Frontend runs on http://localhost:3001
```

**Terminal 3 - Database Management:**
```bash
cd backend
npx prisma studio
# Prisma Studio opens on http://localhost:5555
```

### 7.4 Version Control Setup

```bash
# Initialize Git
git init

# Create .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/

# Production
dist/
build/

# Environment variables
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*

# Prisma
prisma/migrations/*.sql

# Uploads
uploads/

# Next.js
.next/
out/
EOF

# Initial commit
git add .
git commit -m "Initial commit: BiblioVault project setup"
```

---

## 8. Cloud VM Deployment Strategy

### 8.1 Deployment Options

**Option 1: Oracle Cloud Infrastructure (Recommended for you)**
- Free tier available
- Powerful VMs with good performance
- Good for learning and production
- Excellent networking options

**Option 2: AWS (Most Popular)**
- EC2 instances
- RDS for PostgreSQL
- S3 for file storage
- Free tier for 12 months

**Option 3: DigitalOcean (Easiest)**
- Simple droplets
- Managed PostgreSQL
- Good documentation
- $200 free credit

**Option 4: Heroku (Simplest)**
- Platform-as-a-Service
- Easy deployment
- Free tier (with limitations)
- Automatic SSL

### 8.2 OCI Deployment Guide (Recommended)

**Step 1: Create OCI VM Instance**

1. Log into OCI Console
2. Create Compute Instance:
   - Image: Ubuntu 22.04 LTS
   - Shape: VM.Standard.E2.1.Micro (Free tier) or better
   - Network: Create new VCN with public subnet
   - Add SSH keys
   - Note: Public IP address

**Step 2: Configure Security Rules**

```bash
# Allow HTTP (80), HTTPS (443), and your app ports
oci network security-list-entry add \
  --security-list-id <your-security-list-id> \
  --protocol 6 \
  --source 0.0.0.0/0 \
  --destination-port-range-min 80 \
  --destination-port-range-max 80

# Similar for 443, 3000, etc.
```

**Step 3: Connect to VM and Setup**

```bash
# SSH into your VM
ssh -i ~/.ssh/your-key.pem ubuntu@<VM-PUBLIC-IP>

# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Install PostgreSQL
sudo apt install -y postgresql postgresql-contrib

# Install Nginx (reverse proxy)
sudo apt install -y nginx

# Install Git
sudo apt install -y git

# Install PM2 (process manager)
sudo npm install -g pm2
```

**Step 4: Setup PostgreSQL**

```bash
# Switch to postgres user
sudo -i -u postgres

# Create database and user
psql
CREATE DATABASE bibliovault;
CREATE USER bibliovault_user WITH PASSWORD 'secure_password';
GRANT ALL PRIVILEGES ON DATABASE bibliovault TO bibliovault_user;
\q

exit
```

**Step 5: Deploy Application**

```bash
# Clone your repository
cd /var/www
sudo git clone https://github.com/your-username/bibliovault.git
cd bibliovault

# Setup backend
cd backend
sudo npm install
sudo cp .env.example .env
sudo nano .env  # Edit with production values

# Run migrations
npx prisma migrate deploy
npx prisma generate

# Build backend
npm run build

# Setup frontend
cd ../frontend
sudo npm install
sudo npm run build

# Start backend with PM2
cd ../backend
pm2 start dist/index.js --name bibliovault-backend

# Start frontend with PM2
cd ../frontend
pm2 start npm --name bibliovault-frontend -- start

# Save PM2 configuration
pm2 save
pm2 startup
```

**Step 6: Configure Nginx**

```bash
sudo nano /etc/nginx/sites-available/bibliovault
```

Add configuration:
```nginx
server {
    listen 80;
    server_name your-domain.com;  # or use IP

    # Frontend
    location / {
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # Backend API
    location /api {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Enable site:
```bash
sudo ln -s /etc/nginx/sites-available/bibliovault /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

**Step 7: Setup SSL with Let's Encrypt (Optional but Recommended)**

```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com
```

**Step 8: Setup Automatic Deployments**

Create deployment script `deploy.sh`:
```bash
#!/bin/bash

cd /var/www/bibliovault

# Pull latest code
git pull origin main

# Update backend
cd backend
npm install
npm run build
pm2 restart bibliovault-backend

# Update frontend
cd ../frontend
npm install
npm run build
pm2 restart bibliovault-frontend

echo "Deployment completed!"
```

Make executable:
```bash
chmod +x deploy.sh
```

### 8.3 Deployment Checklist

- [ ] VM instance created and configured
- [ ] Security groups/firewall rules configured
- [ ] SSH access configured
- [ ] Node.js and PostgreSQL installed
- [ ] Application code deployed
- [ ] Environment variables configured
- [ ] Database migrated
- [ ] PM2 process manager configured
- [ ] Nginx configured and running
- [ ] SSL certificate installed
- [ ] Application accessible via public IP/domain
- [ ] Monitoring and logging configured
- [ ] Backup strategy implemented

### 8.4 Migration from MacBook to Cloud

**1. Backup Your Local Database:**
```bash
# On MacBook
cd backend
pg_dump bibliovault > bibliovault_backup.sql
```

**2. Transfer Data to Cloud:**
```bash
# Transfer backup file
scp -i ~/.ssh/your-key.pem bibliovault_backup.sql ubuntu@<VM-IP>:~/

# On VM, restore database
psql -U bibliovault_user -d bibliovault < ~/bibliovault_backup.sql
```

**3. Upload Media Files:**
```bash
# Transfer uploads folder
scp -r -i ~/.ssh/your-key.pem backend/uploads ubuntu@<VM-IP>:/var/www/bibliovault/backend/
```

---

## 9. Testing Strategy

### 9.1 Unit Testing

**Backend Tests with Jest:**

Install dependencies:
```bash
cd backend
npm install --save-dev jest @types/jest ts-jest supertest @types/supertest
```

Configure Jest (`backend/jest.config.js`):
```javascript
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src'],
  testMatch: ['**/__tests__/**/*.ts', '**/?(*.)+(spec|test).ts'],
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.d.ts',
  ],
};
```

Example test (`backend/src/__tests__/books.test.ts`):
```typescript
import request from 'supertest';
import app from '../app';

describe('Books API', () => {
  describe('GET /api/books', () => {
    it('should return list of books', async () => {
      const response = await request(app)
        .get('/api/books')
        .expect(200);
      
      expect(response.body).toHaveProperty('books');
      expect(Array.isArray(response.body.books)).toBe(true);
    });
  });

  describe('POST /api/books', () => {
    it('should create a new book', async () => {
      const newBook = {
        title: 'Test Book',
        author: 'Test Author',
        isbn: '1234567890'
      };

      const response = await request(app)
        .post('/api/books')
        .send(newBook)
        .expect(201);
      
      expect(response.body).toHaveProperty('id');
      expect(response.body.title).toBe(newBook.title);
    });
  });
});
```

**Frontend Tests with React Testing Library:**

```bash
cd frontend
npm install --save-dev @testing-library/react @testing-library/jest-dom @testing-library/user-event
```

### 9.2 Integration Testing

Test complete workflows:
- User registration and login
- Adding and editing books
- Starting and completing reading sessions
- Borrowing and returning books

### 9.3 Manual Testing Checklist

**Functionality:**
- [ ] User can register and login
- [ ] User can add books manually
- [ ] User can fetch books by ISBN
- [ ] User can edit and delete books
- [ ] User can start reading sessions
- [ ] User can update reading progress
- [ ] User can complete books with ratings
- [ ] User can lend books to borrowers
- [ ] User can mark books as returned
- [ ] User can search and filter books
- [ ] Dashboard shows correct statistics
- [ ] Overdue books are highlighted

**Security:**
- [ ] Passwords are hashed
- [ ] JWT tokens work correctly
- [ ] Protected routes require authentication
- [ ] SQL injection is prevented
- [ ] XSS attacks are prevented
- [ ] Rate limiting works

**Performance:**
- [ ] Pages load quickly (<2 seconds)
- [ ] Search is responsive
- [ ] Large lists are paginated
- [ ] Images load efficiently

**Usability:**
- [ ] UI is intuitive
- [ ] Forms have proper validation
- [ ] Error messages are clear
- [ ] Success messages appear
- [ ] Mobile view works well

---

## 10. Maintenance & Scaling

### 10.1 Monitoring

**Setup Basic Monitoring:**

```bash
# Install monitoring tools
npm install winston morgan

# Configure logger (backend/src/utils/logger.ts)
import winston from 'winston';

export const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' }),
  ],
});

if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.simple(),
  }));
}
```

### 10.2 Backup Strategy

**Automated Database Backups:**

Create backup script (`backup.sh`):
```bash
#!/bin/bash

# Configuration
DB_NAME="bibliovault"
BACKUP_DIR="/var/backups/bibliovault"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.sql"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Perform backup
pg_dump $DB_NAME > $BACKUP_FILE

# Compress backup
gzip $BACKUP_FILE

# Delete backups older than 30 days
find $BACKUP_DIR -type f -name "backup_*.sql.gz" -mtime +30 -delete

echo "Backup completed: $BACKUP_FILE.gz"
```

Schedule with cron:
```bash
# Edit crontab
crontab -e

# Add daily backup at 2 AM
0 2 * * * /path/to/backup.sh
```

### 10.3 Performance Optimization

**Database Optimization:**
- Create appropriate indexes
- Use connection pooling
- Implement query optimization
- Regular VACUUM and ANALYZE

**Application Optimization:**
- Implement caching (Redis)
- Use CDN for static assets
- Optimize images
- Implement lazy loading
- Use pagination for large datasets

**Frontend Optimization:**
- Code splitting
- Image optimization
- Lazy loading components
- Service workers for offline support

### 10.4 Scaling Considerations

**When to Scale:**
- Response times > 2 seconds
- Database connections maxing out
- CPU usage consistently > 80%
- Memory usage consistently > 80%

**Horizontal Scaling:**
- Add more VM instances
- Use load balancer
- Implement session store (Redis)
- Use managed database service

**Vertical Scaling:**
- Increase VM resources
- Upgrade database instance
- Add more memory/CPU

---

## 📚 Additional Resources

### Documentation
- **Next.js**: https://nextjs.org/docs
- **Express.js**: https://expressjs.com/
- **Prisma**: https://www.prisma.io/docs
- **PostgreSQL**: https://www.postgresql.org/docs/
- **React**: https://react.dev/

### External APIs
- **Google Books API**: https://developers.google.com/books
- **Open Library API**: https://openlibrary.org/developers/api
- **ISBN DB**: https://isbndb.com/

### Learning Resources
- **Full-Stack Development**: FreeCodeCamp, Udemy
- **PostgreSQL**: PostgreSQL Tutorial
- **React**: React Documentation, Scrimba
- **TypeScript**: TypeScript Handbook

---

## 🎯 Success Metrics

### Development Milestones
- [ ] Week 3: Basic authentication and database working
- [ ] Week 6: All core features implemented
- [ ] Week 8: Testing complete and ready for deployment
- [ ] Week 9: Successfully deployed to cloud VM

### Performance Targets
- Page load time < 2 seconds
- API response time < 500ms
- Search results < 1 second
- Support 100+ books without performance degradation
- Mobile responsive on all devices

### Feature Completeness
- All CRUD operations for books, authors, reading, borrowing
- Functional search and filtering
- Reading statistics and reporting
- Borrowing management with reminders
- Data export capability
- Responsive and intuitive UI

---

## 🚀 Getting Started

1. **Set up your MacBook development environment** (Section 7)
2. **Create the database schema** (Section 3)
3. **Build the backend API** (Section 4 & 5)
4. **Develop the frontend UI** (Section 4 & 5)
5. **Implement security** (Section 6)
6. **Test thoroughly** (Section 9)
7. **Deploy to cloud VM** (Section 8)
8. **Monitor and maintain** (Section 10)

---

## 📞 Next Steps

After reading this research document:

1. Review the technology stack and confirm your choice
2. Set up your MacBook development environment
3. Create a GitHub repository for version control
4. Start with Phase 1 development (Foundation)
5. Follow the development phases sequentially
6. Test thoroughly before cloud deployment
7. Deploy to OCI or your preferred cloud provider

**BiblioVault** will be your personal library management solution, keeping your book collection organized, tracking your reading journey, and managing book lending—all in one beautiful, secure application!

---

*Research compiled: January 2026*
*Document Version: 1.0*
*Project Name: BiblioVault - Your Personal Library Vault*
