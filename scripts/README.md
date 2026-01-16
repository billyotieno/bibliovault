# BiblioVault Server Management Scripts

This directory contains scripts to manage your BiblioVault development and production environments.

## 🚀 Quick Start

### Start Development Environment
```bash
./scripts/start-dev.sh
```
This will:
- Start PostgreSQL (if not running)
- Start the backend server on port 3000
- Start the frontend server on port 3001
- Display access URLs and log locations

### Stop All Servers
```bash
./scripts/stop-dev.sh
```
This will:
- Stop the backend server
- Stop the frontend server
- Clean up PID and log files
- Keep PostgreSQL running (stop manually if needed)

### Restart Servers
```bash
./scripts/restart-dev.sh
```
Stops and starts all development servers.

### Check Server Status
```bash
./scripts/status.sh
```
Shows:
- PostgreSQL status
- Backend server status (PID, port, health check)
- Frontend server status (PID, port)
- Access URLs
- Log file locations

### Deploy Application
```bash
# Development deployment
./scripts/deploy.sh

# Production deployment
./scripts/deploy.sh production
```
This will:
- Pull latest code from git
- Install dependencies
- Run database migrations
- Build applications (production only)
- Restart services

---

## 📝 Script Details

### start-dev.sh
**Purpose**: Start all development servers

**What it does**:
1. Checks if PostgreSQL is running, starts it if needed
2. Starts backend on port 3000
3. Starts frontend on port 3001
4. Saves PIDs to `/tmp/bibliovault-*.pid`
5. Logs output to `/tmp/bibliovault-*.log`

**Usage**:
```bash
./scripts/start-dev.sh
```

**Access Points After Starting**:
- Frontend: http://localhost:3001
- Backend: http://localhost:3000
- API Health: http://localhost:3000/api/health

---

### stop-dev.sh
**Purpose**: Stop all development servers

**What it does**:
1. Stops backend server (using PID file or port)
2. Stops frontend server (using PID file or port)
3. Removes PID files
4. Removes log files
5. Leaves PostgreSQL running

**Usage**:
```bash
./scripts/stop-dev.sh
```

**To also stop PostgreSQL**:
```bash
./scripts/stop-dev.sh
pg_ctl -D /opt/homebrew/var/postgresql@14 stop
```

---

### restart-dev.sh
**Purpose**: Restart all development servers

**What it does**:
1. Calls `stop-dev.sh`
2. Waits 2 seconds
3. Calls `start-dev.sh`

**Usage**:
```bash
./scripts/restart-dev.sh
```

**When to use**:
- After making changes to server configuration
- After installing new dependencies
- When servers are behaving unexpectedly

---

### status.sh
**Purpose**: Check status of all services

**What it shows**:
- PostgreSQL: Running/Not running
- Backend: Running/Not running (with PID and port)
- Frontend: Running/Not running (with PID and port)
- Health check result (if backend is running)
- Access URLs
- Log file locations

**Usage**:
```bash
./scripts/status.sh
```

**Example Output**:
```
📊 BiblioVault Server Status
════════════════════════════════════════

PostgreSQL:  ✅ Running
Backend:     ✅ Running (PID: 12345, Port: 3000)
             🏥 Health check: OK
Frontend:    ✅ Running (PID: 12346, Port: 3001)

════════════════════════════════════════

🌐 Access Points:
   Frontend:   http://localhost:3001
   Backend:    http://localhost:3000
   API Health: http://localhost:3000/api/health

📝 Log Files:
   Backend:  /tmp/bibliovault-backend.log
   Frontend: /tmp/bibliovault-frontend.log
```

---

### deploy.sh
**Purpose**: Deploy application updates

**What it does**:
1. Checks prerequisites (git, node, npm)
2. Pulls latest code from git
3. Installs backend dependencies
4. Installs frontend dependencies
5. Runs database migrations
6. Generates Prisma client
7. **Development**: Restarts dev servers
8. **Production**: Builds apps and restarts with PM2

**Usage**:
```bash
# Deploy to development
./scripts/deploy.sh

# Deploy to production
./scripts/deploy.sh production
```

**Production Requirements**:
- PM2 installed globally: `npm install -g pm2`
- Proper environment variables configured
- Running on production server

---

## 📋 Common Tasks

### View Logs in Real-Time

**Backend logs**:
```bash
tail -f /tmp/bibliovault-backend.log
```

**Frontend logs**:
```bash
tail -f /tmp/bibliovault-frontend.log
```

### Manually Stop Servers by Port

If scripts fail, manually kill processes:

```bash
# Stop backend (port 3000)
kill -9 $(lsof -ti:3000)

# Stop frontend (port 3001)
kill -9 $(lsof -ti:3001)
```

### Start PostgreSQL Manually

```bash
pg_ctl -D /opt/homebrew/var/postgresql@14 start
```

### Stop PostgreSQL Manually

```bash
pg_ctl -D /opt/homebrew/var/postgresql@14 stop
```

### Check What's Running on Ports

```bash
# Check port 3000
lsof -i:3000

# Check port 3001
lsof -i:3001

# Check PostgreSQL port
lsof -i:5432
```

---

## 🐛 Troubleshooting

### "Address already in use" Error

**Problem**: Port is already in use

**Solution**:
```bash
# Find and kill the process
./scripts/stop-dev.sh

# Or manually
kill -9 $(lsof -ti:3000)
kill -9 $(lsof -ti:3001)
```

### PostgreSQL Not Starting

**Problem**: PostgreSQL fails to start

**Solutions**:
```bash
# Check if already running
pg_isready

# Check PostgreSQL logs
tail -f /opt/homebrew/var/postgresql@14/server.log

# Try starting manually
pg_ctl -D /opt/homebrew/var/postgresql@14 start
```

### Scripts Not Executable

**Problem**: Permission denied when running scripts

**Solution**:
```bash
chmod +x ./scripts/*.sh
```

### Backend Won't Start

**Problem**: Backend server fails to start

**Solutions**:
1. Check logs: `cat /tmp/bibliovault-backend.log`
2. Check if .env file exists: `ls -la backend/.env`
3. Verify database connection: `psql bibliovault`
4. Reinstall dependencies: `cd backend && npm install`

### Frontend Won't Start

**Problem**: Frontend server fails to start

**Solutions**:
1. Check logs: `cat /tmp/bibliovault-frontend.log`
2. Check if .env.local exists: `ls -la frontend/.env.local`
3. Reinstall dependencies: `cd frontend && npm install`
4. Clear Next.js cache: `cd frontend && rm -rf .next`

---

## 🔧 Development Workflow

### Typical Daily Workflow

1. **Start your day**:
   ```bash
   ./scripts/start-dev.sh
   ```

2. **Check status**:
   ```bash
   ./scripts/status.sh
   ```

3. **Make changes** to your code

4. **If needed, restart servers**:
   ```bash
   ./scripts/restart-dev.sh
   ```

5. **View logs** if something isn't working:
   ```bash
   tail -f /tmp/bibliovault-backend.log
   ```

6. **End your day**:
   ```bash
   ./scripts/stop-dev.sh
   ```

### After Pulling Changes

```bash
./scripts/deploy.sh
```

This handles everything:
- Installs new dependencies
- Runs new migrations
- Restarts servers

---

## 📦 Production Deployment

### Initial Production Setup

1. **Install PM2 globally**:
   ```bash
   npm install -g pm2
   ```

2. **Configure environment variables**:
   ```bash
   # Edit backend/.env with production values
   nano backend/.env

   # Edit frontend/.env.local with production values
   nano frontend/.env.local
   ```

3. **Run deployment**:
   ```bash
   ./scripts/deploy.sh production
   ```

### Subsequent Deployments

```bash
./scripts/deploy.sh production
```

### Managing Production Services

```bash
# Check status
pm2 status

# View logs
pm2 logs bibliovault-backend
pm2 logs bibliovault-frontend

# Restart specific service
pm2 restart bibliovault-backend
pm2 restart bibliovault-frontend

# Stop specific service
pm2 stop bibliovault-backend
pm2 stop bibliovault-frontend
```

---

## 📌 Quick Reference

| Command | Purpose |
|---------|---------|
| `./scripts/start-dev.sh` | Start all dev servers |
| `./scripts/stop-dev.sh` | Stop all dev servers |
| `./scripts/restart-dev.sh` | Restart all dev servers |
| `./scripts/status.sh` | Check server status |
| `./scripts/deploy.sh` | Deploy to development |
| `./scripts/deploy.sh production` | Deploy to production |
| `tail -f /tmp/bibliovault-backend.log` | View backend logs |
| `tail -f /tmp/bibliovault-frontend.log` | View frontend logs |

---

**Happy Developing! 🚀**
