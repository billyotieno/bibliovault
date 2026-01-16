# 🚀 BiblioVault Quick Start Guide

## One-Command Server Management

### Start Everything
```bash
./scripts/start-dev.sh
```
Starts PostgreSQL, Backend (port 3000), and Frontend (port 3001)

### Stop Everything
```bash
./scripts/stop-dev.sh
```
Stops Backend and Frontend (keeps PostgreSQL running)

### Restart Everything
```bash
./scripts/restart-dev.sh
```
Stops and starts all servers

### Check Status
```bash
./scripts/status.sh
```
Shows what's running and health status

### Deploy Updates
```bash
./scripts/deploy.sh
```
Pulls code, installs deps, runs migrations, restarts servers

---

## 🌐 Access Your Application

After running `./scripts/start-dev.sh`:

- **Frontend**: <http://localhost:3001>
- **Backend API**: <http://localhost:3000>
- **Health Check**: <http://localhost:3000/api/health>
- **Database GUI**: `cd backend && npx prisma studio` → <http://localhost:5555>

---

## 📝 View Logs

```bash
# Backend logs
tail -f /tmp/bibliovault-backend.log

# Frontend logs
tail -f /tmp/bibliovault-frontend.log
```

---

## 🛠️ Common Tasks

### Make Changes and See Them
1. Edit your code
2. Save the file
3. Servers auto-reload (no restart needed!)

### After Git Pull
```bash
./scripts/deploy.sh
```
Installs new dependencies and runs migrations

### Something Not Working?
```bash
./scripts/restart-dev.sh
```

### Check What's Running
```bash
./scripts/status.sh
```

---

## 🗄️ Database Access

### Visual Database Manager (Prisma Studio)
```bash
cd backend
npx prisma studio
```
Opens at <http://localhost:5555>

### Command Line
```bash
psql bibliovault
```

### Create New Migration
```bash
cd backend
# Edit prisma/schema.prisma
npx prisma migrate dev --name your_migration_name
```

---

## 📚 Full Documentation

- **[DEVELOPMENT.md](DEVELOPMENT.md)** - Complete development guide
- **[scripts/README.md](scripts/README.md)** - Detailed script documentation
- **[README.md](README.md)** - Project overview
- **[BiblioVault-Development-Research.md](BiblioVault-Development-Research.md)** - Full architecture

---

## 🆘 Troubleshooting

### Port Already in Use
```bash
./scripts/stop-dev.sh
./scripts/start-dev.sh
```

### Database Connection Error
```bash
# Check PostgreSQL is running
pg_isready

# Start if needed
pg_ctl -D /opt/homebrew/var/postgresql@14 start
```

### Scripts Won't Run
```bash
chmod +x ./scripts/*.sh
```

---

## 🎯 Development Workflow

**Morning:**
```bash
./scripts/start-dev.sh
```

**Work on features...**

**Check if everything is OK:**
```bash
./scripts/status.sh
```

**Evening:**
```bash
./scripts/stop-dev.sh
```

---

**That's it! You're ready to build! 🎉**

For detailed information, see [DEVELOPMENT.md](DEVELOPMENT.md)
