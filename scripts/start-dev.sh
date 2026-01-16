#!/bin/bash

# BiblioVault Development Server Startup Script

echo "🚀 Starting BiblioVault Development Environment..."
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Check if PostgreSQL is running
echo -e "${YELLOW}📊 Checking PostgreSQL...${NC}"
if ! pg_isready -q; then
    echo -e "${YELLOW}Starting PostgreSQL...${NC}"
    pg_ctl -D /opt/homebrew/var/postgresql@14 start
    sleep 2
    if pg_isready -q; then
        echo -e "${GREEN}✅ PostgreSQL started${NC}"
    else
        echo -e "${RED}❌ Failed to start PostgreSQL${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✅ PostgreSQL is already running${NC}"
fi

echo ""

# Check if backend is already running
if lsof -ti:3000 > /dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Backend is already running on port 3000${NC}"
else
    echo -e "${YELLOW}🔧 Starting Backend Server...${NC}"
    cd "$PROJECT_ROOT/backend"
    npm run dev > /tmp/bibliovault-backend.log 2>&1 &
    BACKEND_PID=$!
    echo $BACKEND_PID > /tmp/bibliovault-backend.pid
    sleep 3
    if lsof -ti:3000 > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Backend running on http://localhost:3000${NC}"
        echo -e "   PID: $BACKEND_PID"
    else
        echo -e "${RED}❌ Failed to start backend${NC}"
    fi
fi

echo ""

# Check if frontend is already running
if lsof -ti:3001 > /dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Frontend is already running on port 3001${NC}"
else
    echo -e "${YELLOW}⚛️  Starting Frontend Server...${NC}"
    cd "$PROJECT_ROOT/frontend"
    npm run dev > /tmp/bibliovault-frontend.log 2>&1 &
    FRONTEND_PID=$!
    echo $FRONTEND_PID > /tmp/bibliovault-frontend.pid
    sleep 5
    if lsof -ti:3001 > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Frontend running on http://localhost:3001${NC}"
        echo -e "   PID: $FRONTEND_PID"
    else
        echo -e "${RED}❌ Failed to start frontend${NC}"
    fi
fi

echo ""
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}🎉 BiblioVault is ready!${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo ""
echo -e "📱 Frontend:    ${GREEN}http://localhost:3001${NC}"
echo -e "🔧 Backend API: ${GREEN}http://localhost:3000${NC}"
echo -e "📊 Health:      ${GREEN}http://localhost:3000/api/health${NC}"
echo ""
echo -e "📝 Logs:"
echo -e "   Backend:  tail -f /tmp/bibliovault-backend.log"
echo -e "   Frontend: tail -f /tmp/bibliovault-frontend.log"
echo ""
echo -e "🛑 To stop servers: ./scripts/stop-dev.sh"
echo ""
